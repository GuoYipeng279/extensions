--SceneFile="Missions\Multi\Scene5.scn"

function luaPrecacheUnits()
	PrepareClass(102) -- Corsair
	PrepareClass(108) -- Dauntless
	PrepareClass(113) -- Avenger
	PrepareClass(67) -- Mogami
	PrepareClass(70) -- Kuma
	PrepareClass(69) -- Takao
	PrepareClass(71) -- Agano
	PrepareClass(68) -- Tone
	PrepareClass(14) -- Akizuki
	PrepareClass(58) -- Shimakaze
	PrepareClass(77) -- JapPT
	PrepareClass(59) -- Yamato
	PrepareClass(60) -- Kongo
	PrepareClass(61) -- Fuso
	PrepareClass(159) -- Judy
	PrepareClass(162) -- Kate
	PrepareClass(154) -- Oscar
	PrepareClass(32) -- Betty Ohka
	PrepareClass(167) -- Betty
	PrepareClass(116) -- B17
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC5Mission")
end

function luaInitQAC5Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp5"..dateandtime

	Mission.HelperLog = true
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- precache

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	if LobbySettings.TimeLimit == "globals.none" then
		Mission.LobbyCountDown = 0
	elseif LobbySettings.TimeLimit == "globals.5m" then
		Mission.LobbyCountDown = 5 * 60
	elseif LobbySettings.TimeLimit == "globals.10m" then
		Mission.LobbyCountDown = 10 * 60
	elseif LobbySettings.TimeLimit == "globals.15m" then
		Mission.LobbyCountDown = 15 * 60
	elseif LobbySettings.TimeLimit == "globals.20m" then
		Mission.LobbyCountDown = 20 * 60
	elseif LobbySettings.TimeLimit == "globals.25m" then
		Mission.LobbyCountDown = 25 * 60
	elseif LobbySettings.TimeLimit == "globals.30m" then
		Mission.LobbyCountDown = 30 * 60
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.TimeLimit contains non-handled string | LobbySettings.TimeLimit: "..LobbySettings.TimeLimit)
		Mission.LobbyCountDown = 0
	end

	if Mission.LobbyCountDown == 0 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
		Mission.FourthWarningDone = true
	elseif Mission.LobbyCountDown <= 900 and Mission.LobbyCountDown >= 601 then
		Mission.FirstWarningDone = true
	elseif Mission.LobbyCountDown <= 600 and Mission.LobbyCountDown >= 301 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
	elseif Mission.LobbyCountDown <= 300 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
	end

	if LobbySettings.PointLimit == "globals.none" then
		Mission.PointLimit = 0
	elseif LobbySettings.PointLimit == "500" then
		Mission.PointLimit = 500
	elseif LobbySettings.PointLimit == "1000" then
		Mission.PointLimit = 1000
	elseif LobbySettings.PointLimit == "2000" then
		Mission.PointLimit = 2000
	elseif LobbySettings.PointLimit == "3000" then
		Mission.PointLimit = 3000
	elseif LobbySettings.PointLimit == "4000" then
		Mission.PointLimit = 4000
	elseif LobbySettings.PointLimit == "5000" then
		Mission.PointLimit = 5000
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.PointLimit contains non-handled string | LobbySettings.PointLimit: "..LobbySettings.PointLimit)
		Mission.PointLimit = 0
	end

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 5
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0

	-- mission tablak, valtozok
	Mission.FighterRandom = luaRnd(5, 7)
	Mission.BomberRandom = luaRnd(3, 4)
	Mission.PowerupLevels = {}
	for i = 1, 8 do
		table.insert(Mission.PowerupLevels, 1)
	end
	Mission.PowerupLevelups = {}
		table.insert(Mission.PowerupLevelups, 500)
		table.insert(Mission.PowerupLevelups, 1000)
		table.insert(Mission.PowerupLevelups, 1500)
		table.insert(Mission.PowerupLevelups, 2500)
		table.insert(Mission.PowerupLevelups, 4000)
	Mission.Powerups = {}
		table.insert(Mission.Powerups, "improved_shells")
		table.insert(Mission.Powerups, "evasive_manoeuvre")
		table.insert(Mission.Powerups, "full_throttle")
		--table.insert(Mission.Powerups, "levelbomb1")

	-- spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 5"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 6"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 7"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 8"))
	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")
	for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- amerikai objektumok
	Mission.USCVs = {}
		table.insert(Mission.USCVs, FindEntity("Comp - Lexington"))
		table.insert(Mission.USCVs, FindEntity("Comp - Yorktown"))
	Mission.USDefShips = {}
		table.insert(Mission.USDefShips, FindEntity("Comp - Atlanta"))
		table.insert(Mission.USDefShips, FindEntity("Comp - Fletcher 1"))
		table.insert(Mission.USDefShips, FindEntity("Comp - Fletcher 2"))
		table.insert(Mission.USDefShips, FindEntity("Comp - Fletcher 3"))
	Mission.USCVSPs = {}
		table.insert(Mission.USCVSPs, FindEntity("Comp - Lexi SP"))
		table.insert(Mission.USCVSPs, FindEntity("Comp - York SP"))

	for index, entity in pairs (Mission.USCVSPs) do
		for index2, value in pairs (Mission.SlotIDTable) do
			DeactivateSpawnpoint(entity, value)
		end
	end
--[[
	DeactivateSpawnpoint(Mission.USCVSPs[1])
	DeactivateSpawnpoint(Mission.USCVSPs[2])
]]
	-- japan objektumok
	Mission.JapCVs = {}
		table.insert(Mission.JapCVs, FindEntity("Comp - Akagi"))
		table.insert(Mission.JapCVs, FindEntity("Comp - Hiryu"))
	Mission.AttackerPlanes = {}
	Mission.JapSmallDefShips = {}
	Mission.JapSmallDefShipTMPLs = {}
		table.insert(Mission.JapSmallDefShipTMPLs, luaFindHidden("Comp - Akizuki TMPL"))
		table.insert(Mission.JapSmallDefShipTMPLs, luaFindHidden("Comp - Shimakaze TMPL"))
		table.insert(Mission.JapSmallDefShipTMPLs, luaFindHidden("Comp - JapPT TMPL"))
	Mission.JapMediumDefShips = {}
	Mission.JapMediumDefShipTMPLs = {}
		table.insert(Mission.JapMediumDefShipTMPLs, luaFindHidden("Comp - Mogami TMPL"))
		table.insert(Mission.JapMediumDefShipTMPLs, luaFindHidden("Comp - Kuma TMPL"))
		table.insert(Mission.JapMediumDefShipTMPLs, luaFindHidden("Comp - Takao TMPL"))
		table.insert(Mission.JapMediumDefShipTMPLs, luaFindHidden("Comp - Agano TMPL"))
		table.insert(Mission.JapMediumDefShipTMPLs, luaFindHidden("Comp - Tone TMPL"))
	Mission.JapBBFleet = {}
	Mission.JapBBFleetLevel = 1
	Mission.JapBigDefShipTMPLs = {}
		table.insert(Mission.JapBigDefShipTMPLs, luaFindHidden("Comp - Yamato TMPL"))
		table.insert(Mission.JapBigDefShipTMPLs, luaFindHidden("Comp - Kongo TMPL"))
		table.insert(Mission.JapBigDefShipTMPLs, luaFindHidden("Comp - Fuso TMPL"))
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Comp - HQ 1"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 2"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 3"))
	Mission.HQs[1].ignore = false
	Mission.HQs[2].ignore = false
	Mission.HQs[3].ignore = false
	Mission.BombersCV1 = {}
	Mission.BombersCV2 = {}
	Mission.BombersHQ1 = {}
	Mission.BomberTMPLs = {}
		table.insert(Mission.BomberTMPLs, luaFindHidden("Comp - Judy TMPL"))
		table.insert(Mission.BomberTMPLs, luaFindHidden("Comp - Kate TMPL"))
	Mission.FightersCV1 = {}
	Mission.FightersCV2 = {}
	Mission.FightersHQ1 = {}
	Mission.FighterTMPL = luaFindHidden("Comp - Oscar TMPL")
	Mission.OhkaCarriersHQ1 = {}
	Mission.OhkaCarriersHQ2 = {}
	Mission.OhkaCarriersHQ3 = {}
	Mission.OhkaCarrierTMPL = luaFindHidden("Comp - Betty TMPL")
	Mission.BomberFilter = {}

	-- utvonalak, navpontok
	Mission.JapNavPoints1 = {}
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 01")))
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 02")))
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 03")))
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 04")))
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 19")))
		table.insert(Mission.JapNavPoints1, GetPosition(FindEntity("Comp - Navpoint 20")))
	Mission.JapNavPoints2 = {}
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 05")))
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 06")))
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 07")))
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 08")))
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 09")))
		table.insert(Mission.JapNavPoints2, GetPosition(FindEntity("Comp - Navpoint 10")))
	Mission.JapNavPoints3 = {}
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 11")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 12")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 13")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 14")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 15")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 16")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 17")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 18")))
		table.insert(Mission.JapNavPoints3, GetPosition(FindEntity("Comp - Navpoint 26")))
	Mission.JapNavPoints4 = {}
		table.insert(Mission.JapNavPoints4, GetPosition(FindEntity("Comp - Navpoint 21")))
		table.insert(Mission.JapNavPoints4, GetPosition(FindEntity("Comp - Navpoint 22")))
		table.insert(Mission.JapNavPoints4, GetPosition(FindEntity("Comp - Navpoint 23")))
		table.insert(Mission.JapNavPoints4, GetPosition(FindEntity("Comp - Navpoint 24")))
		table.insert(Mission.JapNavPoints4, GetPosition(FindEntity("Comp - Navpoint 25")))
	Mission.JapNavPoints42 = {}
		table.insert(Mission.JapNavPoints42, GetPosition(FindEntity("Comp - Navpoint 27")))
		table.insert(Mission.JapNavPoints42, GetPosition(FindEntity("Comp - Navpoint 28")))
		table.insert(Mission.JapNavPoints42, GetPosition(FindEntity("Comp - Navpoint 29")))
		table.insert(Mission.JapNavPoints42, GetPosition(FindEntity("Comp - Navpoint 30")))
		table.insert(Mission.JapNavPoints42, GetPosition(FindEntity("Comp - Navpoint 31")))
	Mission.AtlantaPath = FindEntity("Comp - AtlantaPath")
	Mission.FletcherPaths = {}
		table.insert(Mission.FletcherPaths,	FindEntity("Comp - FletcherPath 1"))
		table.insert(Mission.FletcherPaths,	FindEntity("Comp - FletcherPath 2"))
		table.insert(Mission.FletcherPaths,	FindEntity("Comp - FletcherPath 3"))
	Mission.TurnToPoint = GetPosition(FindEntity("Comp - CVPoint"))
	Mission.EmergencyExitPos = GetPosition(FindEntity("Comp - EmergencyExitPos"))

	Mission.KillScoreShip = 175
	Mission.KillScorePlane = 100

	-- jatekosok

	-- lefigyelesek

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 0,
				["ID"] = "us_obj_primary_1_player_1",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 1,
				["ID"] = "us_obj_primary_1_player_2",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 2,
				["ID"] = "us_obj_primary_1_player_3",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 3,
				["ID"] = "us_obj_primary_1_player_4",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[5] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 4,
				["ID"] = "us_obj_primary_1_player_5",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[6] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 5,
				["ID"] = "us_obj_primary_1_player_6",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[7] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 6,
				["ID"] = "us_obj_primary_1_player_7",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[8] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 7,
				["ID"] = "us_obj_primary_1_player_8",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[9] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_2",
				["Text"] = "mp05.obj_comp_p2_text",
				["TextCompleted"] = "mp05.obj_comp_p2_comp",
				["TextFailed"] = "mp05.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "mp05.obj_comp_s1_text",
				["TextCompleted"] = "mp05.obj_comp_s1_comp",
				["TextFailed"] = "mp05.obj_comp_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_2",
				["Text"] = "mp05.obj_comp_s2_text",
				["TextCompleted"] = "mp05.obj_comp_s2_comp",
				["TextFailed"] = "mp05.obj_comp_s2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	Mission.Digit4 = 8888

	MultiScore =	{
		[0]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
	}

	if Mission.PointLimit == 0 then
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1#", "mp01.score_comp_high".."| #MultiScore.0.5#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1#", "mp01.score_comp_high".."| #MultiScore.1.5#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1#", "mp01.score_comp_high".."| #MultiScore.2.5#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1#", "mp01.score_comp_high".."| #MultiScore.3.5#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1#", "mp01.score_comp_high".."| #MultiScore.4.5#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1#", "mp01.score_comp_high".."| #MultiScore.5.5#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1#", "mp01.score_comp_high".."| #MultiScore.6.5#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1#", "mp01.score_comp_high".."| #MultiScore.7.5#")
	else
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.7#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.7#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.7#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.7#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.7#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.7#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.7#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.7#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.7#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.7#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.7#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.7#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.7#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.7#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.7#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.7#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][7] = Mission.PointLimit
		end
	end

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-----------------")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	if Mission.Players <= 2 then
		Mission.JapSmallDefShipsNumber = 3
		Mission.JapMediumDefShipsNumber = 3
		Mission.JapSmallPlanes = 2
		Mission.JapBigPlanes = 2
		Mission.JapBBFleetNumber = 2
	elseif Mission.Players == 3 then
		Mission.JapSmallDefShipsNumber = 3
		Mission.JapMediumDefShipsNumber = 4
		Mission.JapSmallPlanes = 2
		Mission.JapBigPlanes = 2
		Mission.JapBBFleetNumber = 3
	elseif Mission.Players == 4 then
		Mission.JapSmallDefShipsNumber = 3
		Mission.JapMediumDefShipsNumber = 5
		Mission.JapSmallPlanes = 2
		Mission.JapBigPlanes = 2
		Mission.JapBBFleetNumber = 3
	elseif Mission.Players == 5 then
		Mission.JapSmallDefShipsNumber = 3
		Mission.JapMediumDefShipsNumber = 6
		Mission.JapSmallPlanes = 3
		Mission.JapBigPlanes = 3
		Mission.JapBBFleetNumber = 4
	elseif Mission.Players == 6 then
		Mission.JapSmallDefShipsNumber = 3
		Mission.JapMediumDefShipsNumber = 7
		Mission.JapSmallPlanes = 3
		Mission.JapBigPlanes = 3
		Mission.JapBBFleetNumber = 4
	elseif Mission.Players == 7 then
		Mission.JapSmallDefShipsNumber = 4
		Mission.JapMediumDefShipsNumber = 8
		Mission.JapSmallPlanes = 3
		Mission.JapBigPlanes = 3
		Mission.JapBBFleetNumber = 5
	elseif Mission.Players == 8 then
		Mission.JapSmallDefShipsNumber = 4
		Mission.JapMediumDefShipsNumber = 8
		Mission.JapSmallPlanes = 3
		Mission.JapBigPlanes = 3
		Mission.JapBBFleetNumber = 5
	end

	luaInitNewSystems()

    SetThink(this, "luaQAC5Mission_think")
end

function luaQAC5Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaQACCheckListeners()
		luaQAC5CheckShips()
		luaQAC5CheckPlanes()
		--luaQAC5CheckGameTime()
		luaQAC5CheckMissionEnd()
		luaQAC5HintManager()
		--luaQACGivePowerups()

	elseif not Mission.Started then
		luaQAC5StartMission()		
		luaUpdateCounters()
	end
end

function luaQAC5StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for index, unit in pairs (Mission.USCVs) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end

	for index, unit in pairs (Mission.USDefShips) do
		SetSkillLevel(unit, SKILL_MPNORMAL)
	end

	for i = 1, 9 do
		luaObj_Add("primary", i)
	end

	luaObj_AddUnit("primary", 9, Mission.USCVs[1])
	luaObj_AddUnit("primary", 9, Mission.USCVs[2])

	luaObj_Add("secondary", 1, Mission.USDefShips[1])
	luaObj_Add("secondary", 2)

	for index, unit in pairs (Mission.USDefShips) do
		if index ~= 1 then
			luaObj_AddUnit("secondary", 2, unit)
		end
	end

	for i = 1, 4 do
		TorpedoEnable(Mission.USDefShips[i], true)
	end

	NavigatorMoveOnPath(Mission.USDefShips[1], Mission.AtlantaPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	NavigatorMoveOnPath(Mission.USDefShips[2], Mission.FletcherPaths[1], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	NavigatorMoveOnPath(Mission.USDefShips[3], Mission.FletcherPaths[2], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	NavigatorMoveOnPath(Mission.USDefShips[4], Mission.FletcherPaths[3], PATH_FM_CIRCLE, PATH_SM_BEGIN)

	for i = 1, Mission.JapSmallDefShipsNumber do
		local randomtmpl = luaPickRnd(Mission.JapSmallDefShipTMPLs)
		local navpos = Mission.JapNavPoints1[i]
		local unit = GenerateObject(randomtmpl.Name, {["x"] = navpos["x"], ["y"] = 0, ["z"] = navpos["z"]})
		AISetHintWeight(unit, 20)
		TorpedoEnable(unit, true)
		NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
		EntityTurnToEntity(unit, Mission.USCVs[1])
		local shipspeed = GetShipMaxSpeed(unit) * 0.8
		SetShipSpeed(unit, shipspeed)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		table.insert(Mission.JapSmallDefShips, unit)
	end

	for i = 1, Mission.JapSmallDefShipsNumber do
		local randomtmpl = luaPickRnd(Mission.JapSmallDefShipTMPLs)
		local navpos = Mission.JapNavPoints2[i]
		local unit = GenerateObject(randomtmpl.Name, {["x"] = navpos["x"], ["y"] = 0, ["z"] = navpos["z"]})
		AISetHintWeight(unit, 20)
		TorpedoEnable(unit, true)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		table.insert(Mission.JapSmallDefShips, unit)
	end

	for i = 1, Mission.JapMediumDefShipsNumber do
		local randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
		local navpos = Mission.JapNavPoints3[i]
		local unit = GenerateObject(randomtmpl.Name, {["x"] = navpos["x"], ["y"] = 0, ["z"] = navpos["z"]})
		AISetHintWeight(unit, 50)
		local turntopos
		if i > 0 and i < 5 then
			turntopos = {["x"] = navpos["x"] - 400, ["y"] = 0, ["z"] = navpos["z"] - 200}
		else
			turntopos = {["x"] = navpos["x"] - 400, ["y"] = 0, ["z"] = navpos["z"] + 200}
		end
		EntityTurnToPosition(unit, turntopos)
		TorpedoEnable(unit, true)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		table.insert(Mission.JapMediumDefShips, unit)
	end

	local BB = luaPickRnd(Mission.JapBigDefShipTMPLs)
	Mission.JapAnchoredBB = GenerateObject(BB.Name, Mission.JapNavPoints3[9])
	local BBPos = GetPosition(Mission.JapAnchoredBB)
	local turntopos = {["x"] = BBPos["x"] - 400, ["y"] = 0, ["z"] = BBPos["z"] + 200}
	EntityTurnToPosition(Mission.JapAnchoredBB, turntopos)
	--AAEnable(Mission.JapAnchoredBB, false)
	--ArtilleryEnable(Mission.JapAnchoredBB, false)
	table.insert(Mission.JapMediumDefShips, Mission.JapAnchoredBB)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC5MissionEndTimeIsUp")
	end
	Mission.Started = true
end

function luaQAC5CheckShips()
-- RELEASE_LOGOFF  	luaLog(" Checking ships...")
	local fletcherDC = 0
	for index, unit in pairs (Mission.USDefShips) do
		if index == 1 then
			if unit.Dead and not Mission.Secondary1Failed then
				Mission.Secondary1Failed = true
				luaObj_Failed("secondary", 1)
			end
		else
			if unit.Dead and not Mission.Secondary2Failed then
				fletcherDC = fletcherDC + 1
				if fletcherDC == 3 then
					Mission.Secondary2Failed = true
					luaObj_Failed("secondary", 2)
				end
			end
		end
	end

	Mission.USCVs = luaRemoveDeadsFromTable(Mission.USCVs)
	if table.getn(Mission.USCVs) == 0 then
		Mission.USCarriersDown = true
		return
	end

	Mission.JapSmallDefShips = luaRemoveDeadsFromTable(Mission.JapSmallDefShips)
	Mission.JapMediumDefShips = luaRemoveDeadsFromTable(Mission.JapMediumDefShips)
	if table.getn(Mission.JapSmallDefShips) <= 8 and not Mission.FirstNav2FleetSent then
-- RELEASE_LOGOFF  		luaLog("  ordering small ships to begin the attack move")
		Mission.FirstNav2FleetSent = true
		--MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_fleet_second")
		for index, unit in pairs(Mission.JapSmallDefShips) do
			if UnitGetAttackTarget(unit) == nil then
				if table.getn(Mission.USCVs) ~= 0 then
					NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
					local shipspeed = GetShipMaxSpeed(unit) * 0.8
					SetShipSpeed(unit, shipspeed)
				end
			end
		end
	elseif table.getn(Mission.JapSmallDefShips) <= 4 and not Mission.FirstNav3FleetSent then
-- RELEASE_LOGOFF  		luaLog("  ordering medium ships to begin the attack move (1, 2)")
		Mission.FirstNav3FleetSent = true
		Mission.Nav3FleetStartTime = GameTime()
		--MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_fleet_third")
		for index, unit in pairs(Mission.JapMediumDefShips) do
			if index == 1 or index == 2 then
				if table.getn(Mission.USCVs) ~= 0 then
					NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
					local shipspeed = GetShipMaxSpeed(unit) * 0.8
					SetShipSpeed(unit, shipspeed)
				end
				unit.onthemove = true
			end
		end
	end

	if table.getn(Mission.JapSmallDefShips) == 0 and not Mission.AvengersSet then
-- RELEASE_LOGOFF  		luaLog("  ordering the skirmish AI to use avengers")
		Mission.AvengersSet = true
		AISetTargetWeight(102, 67, false, 5)
		AISetTargetWeight(102, 70, false, 5)
		AISetTargetWeight(102, 69, false, 5)
		AISetTargetWeight(102, 71, false, 5)
		AISetTargetWeight(102, 68, false, 5)
		AISetTargetWeight(102, 59, false, 5)
		AISetTargetWeight(102, 60, false, 5)
		AISetTargetWeight(102, 61, false, 5)
		AISetTargetWeight(113, 67, false, 25)
		AISetTargetWeight(113, 70, false, 55)
		AISetTargetWeight(113, 69, false, 25)
		AISetTargetWeight(113, 71, false, 25)
		AISetTargetWeight(113, 68, false, 25)
		AISetTargetWeight(113, 59, false, 25)
		AISetTargetWeight(113, 60, false, 25)
		AISetTargetWeight(113, 61, false, 25)
		luaQAC5CheckNearestEnemy()
	end

	if Mission.FirstNav3FleetSent and not Mission.Nav3FleetFourthWave then
		local secondtime
		local thirdtime
		local fourthtime
		local fifthtime
		if Mission.Players <= 3 then
			secondtime = Mission.Nav3FleetStartTime + 200
			thirdtime = Mission.Nav3FleetStartTime + 300
			fourthtime = Mission.Nav3FleetStartTime + 500
			fifthtime = Mission.Nav3FleetStartTime + 700
		elseif Mission.Players <= 5 then
			secondtime = Mission.Nav3FleetStartTime + 160
			thirdtime = Mission.Nav3FleetStartTime + 290
			fourthtime = Mission.Nav3FleetStartTime + 420
			fifthtime = Mission.Nav3FleetStartTime + 550
		else
			secondtime = Mission.Nav3FleetStartTime + 120
			thirdtime = Mission.Nav3FleetStartTime + 240
			fourthtime = Mission.Nav3FleetStartTime + 360
			fifthtime = Mission.Nav3FleetStartTime + 520
		end
-- RELEASE_LOGOFF  		luaLog("  GameTime() = "..tostring(luaRound(GameTime())).." | s: "..tostring(luaRound(secondtime)).." t: "..tostring(luaRound(thirdtime)).." f: "..tostring(luaRound(fourthtime)))
		if GameTime() >= secondtime and not Mission.Nav3FleetSecondWave then
-- RELEASE_LOGOFF  			luaLog("  ordering medium ships to begin the attack move (3, 4)")
			Mission.Nav3FleetSecondWave = true
			local unitsallowed = 2
			local unitssent = 0
			for index, unit in pairs(Mission.JapMediumDefShips) do
				if not unit.onthemove and unitssent < 2 then
					if table.getn(Mission.USCVs) ~= 0 then
						NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
						local shipspeed = GetShipMaxSpeed(unit) * 0.8
						SetShipSpeed(unit, shipspeed)
					end
					unit.onthemove = true
					unitssent = unitssent + 1
				end
			end
		elseif GameTime() >= thirdtime and not Mission.Nav3FleetThirdWave then
-- RELEASE_LOGOFF  			luaLog("  ordering medium ships to begin the attack move (5, 6)")
			Mission.Nav3FleetThirdWave = true
			local unitsallowed = 2
			local unitssent = 0
			for index, unit in pairs(Mission.JapMediumDefShips) do
				if not unit.onthemove and unitssent < 2 then
					if table.getn(Mission.USCVs) ~= 0 then
						NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
						local shipspeed = GetShipMaxSpeed(unit) * 0.8
						SetShipSpeed(unit, shipspeed)
					end
					unit.onthemove = true
					unitssent = unitssent + 1
				end
			end
		elseif GameTime() >= fourthtime and not Mission.Nav3FleetFourthWave then
-- RELEASE_LOGOFF  			luaLog("  ordering medium ships to begin the attack move (7, 8)")
			Mission.Nav3FleetFourthWave = true
			local unitsallowed = 2
			local unitssent = 0
			for index, unit in pairs(Mission.JapMediumDefShips) do
				if not unit.onthemove and unitssent < 2 then
					if table.getn(Mission.USCVs) ~= 0 then
						NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
						local shipspeed = GetShipMaxSpeed(unit) * 0.8
						SetShipSpeed(unit, shipspeed)
					end
					unit.onthemove = true
					unitssent = unitssent + 1
				end
			end
		elseif GameTime() >= fifthtime and not Mission.Nav3FleetFifthWave then
			Mission.Nav3FleetFifthWave = true
			if not Mission.JapAnchoredBB.Dead then
				--AAEnable(Mission.JapAnchoredBB, true)
				--ArtilleryEnable(Mission.JapAnchoredBB, true)
				if table.getn(Mission.USCVs) ~= 0 then
					NavigatorAttackMove(Mission.JapAnchoredBB, luaPickRnd(Mission.USCVs), {})
					local shipspeed = GetShipMaxSpeed(Mission.JapAnchoredBB) * 0.8
					SetShipSpeed(Mission.JapAnchoredBB, shipspeed)
				end				
			end
		end
	end

	if table.getn(Mission.JapSmallDefShips) <= Mission.FighterRandom and not Mission.FighterSpawnsAllowed then
-- RELEASE_LOGOFF  		luaLog("  allowing fighter spawns")
		Mission.FighterSpawnsAllowed = true
	elseif table.getn(Mission.JapMediumDefShips) <= Mission.BomberRandom and not Mission.BomberSpawnsAllowed then
-- RELEASE_LOGOFF  		luaLog("  allowing bomber spawns")
		Mission.BomberSpawnsAllowed = true
	elseif table.getn(Mission.JapMediumDefShips) == 0 and not Mission.OhkaSpawnsAllowed then
-- RELEASE_LOGOFF  		luaLog("  allowing ohka spawns")
		Mission.OhkaSpawnsAllowed = true
		Mission.BattleshipSpawnEnabled = true

		table.remove(Mission.JapSmallDefShipTMPLs, 3)

		luaQC5SpawnBBFleet(Mission.JapBBFleetLevel)

	elseif Mission.BattleshipSpawnEnabled then
		Mission.JapBBFleet = luaRemoveDeadsFromTable(Mission.JapBBFleet)
		if table.getn(Mission.JapBBFleet) == 0 then
			luaQC5SpawnBBFleet(Mission.JapBBFleetLevel)
		end
	end
end

function luaQC5SpawnBBFleet(level)
-- RELEASE_LOGOFF  	luaLog("  spawning BB fleet!")
	local enteringposition = luaRnd(1, 2)
	local navpointstable = {}
	if enteringposition == 1 then
		for index, value in pairs (Mission.JapNavPoints4) do
			table.insert(navpointstable, value)
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_fleet_north")
	else
		for index, value in pairs (Mission.JapNavPoints42) do
			table.insert(navpointstable, value)
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_fleet_south")
	end
	for i = 1, Mission.JapBBFleetNumber do
		local randomtmpl
		if Mission.JapBBFleetLevel == 1 then
			if i == 1 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapSmallDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel == 2 then
			if i == 1 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			elseif i == 2 or i == 3 then
				randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapSmallDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel == 3 then
			if i == 1 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel == 4 then
			if i == 1 or i == 2 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel == 5 then
			if i >= 1 and i <= 3 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel == 6 then
			if i >= 1 and i <= 4 then
				randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
			else
				randomtmpl = luaPickRnd(Mission.JapMediumDefShipTMPLs)
			end
		elseif Mission.JapBBFleetLevel >= 7 then
			randomtmpl = luaPickRnd(Mission.JapBigDefShipTMPLs)
		end

		local navpos = navpointstable[i]
		local unit = GenerateObject(randomtmpl.Name, {["x"] = navpos["x"], ["y"] = 0, ["z"] = navpos["z"]})
		local turntopos = {["x"] = navpos["x"] - 300, ["y"] = 0, ["z"] = navpos["z"] - 100}
		EntityTurnToPosition(unit, turntopos)
		AISetHintWeight(unit, 69)
		if i == 1 then
			NavigatorAttackMove(unit, luaPickRnd(Mission.USCVs), {})
		else
			JoinFormation(unit, Mission.JapBBFleet[1])
			TorpedoEnable(unit, true)
		end
		table.insert(Mission.JapBBFleet, unit)
	end
	for index, unit in pairs (Mission.USDefShips) do
		if not unit.Dead then
			NavigatorAttackMove(unit, Mission.JapBBFleet[1], {})
			SetSkillLevel(unit, SKILL_MPVETERAN)
		end
	end
	Mission.JapBBFleetLevel = Mission.JapBBFleetLevel + 1
end

function luaQAC5CheckPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking planes...")
	if Mission.FighterSpawnsAllowed and not Mission.FirstFighterSpawnDone then
-- RELEASE_LOGOFF  		luaLog("  spawning the first wave of fighters")
		if not Mission.JapCVs[1].Dead then
			--for i = 1, 2 do
			for i = 1, 1 do
				local fighter = luaQAC5SpawnFighter(1, i)
				table.insert(Mission.FightersCV1, fighter)
			end
		end
		if not Mission.JapCVs[2].Dead and Mission.JapSmallPlanes >= 2 then
			--for i = 1, 2 do
			for i = 1, 1 do
				local fighter = luaQAC5SpawnFighter(2, i)
				table.insert(Mission.FightersCV2, fighter)
			end
		end
		if not Mission.HQs[1].Dead and Mission.JapSmallPlanes >= 3 then
			--for i = 1, 2 do
			for i = 1, 1 do
				local fighter = luaQAC5SpawnFighter(3, i)
				table.insert(Mission.FightersHQ1, fighter)
			end
		end
		Mission.FirstFighterSpawnDone = true
		MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_fighter")
	end

	if Mission.BomberSpawnsAllowed and not Mission.FirstBomberSpawnDone then
-- RELEASE_LOGOFF  		luaLog("  spawning the first wave of bombers")
		if not Mission.JapCVs[1].Dead then
			--for i = 1, 2 do
			for i = 1, 1 do
				local bomber = luaQAC5SpawnBomber(1, i)
				table.insert(Mission.BombersCV1, bomber)
				AISetHintWeight(bomber, 5)
			end
		end
		if not Mission.JapCVs[2].Dead and Mission.JapSmallPlanes >= 2 then
			--for i = 1, 2 do
			for i = 1, 1 do
				local bomber = luaQAC5SpawnBomber(2, i)
				table.insert(Mission.BombersCV2, bomber)
				AISetHintWeight(bomber, 5)
			end
		end
		if not Mission.HQs[1].Dead and Mission.JapSmallPlanes >= 3 then
			--for i = 1, 2 do
			for i = 1, 1 do
				local bomber = luaQAC5SpawnBomber(3, i)
				table.insert(Mission.BombersHQ1, bomber)
				AISetHintWeight(bomber, 5)
			end
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_bomber")
		Mission.FirstBomberSpawnDone = true
	end

	if Mission.OhkaSpawnsAllowed and not Mission.FirstOhkaSpawnDone then
-- RELEASE_LOGOFF  		luaLog("  spawning the first wave of ohkas")
		if not Mission.HQs[1].Dead then
			local ohkacarrier = luaQAC5SpawnOhkaCarrier(1, i)
			table.insert(Mission.OhkaCarriersHQ1, ohkacarrier)
			AISetHintWeight(ohkacarrier, 15)
		end
		if not Mission.HQs[2].Dead and Mission.JapBigPlanes >= 2 then
			local ohkacarrier = luaQAC5SpawnOhkaCarrier(2, i)
			table.insert(Mission.OhkaCarriersHQ2, ohkacarrier)
			AISetHintWeight(ohkacarrier, 15)
		end
		if not Mission.HQs[3].Dead and Mission.JapBigPlanes >= 3 then
			local ohkacarrier = luaQAC5SpawnOhkaCarrier(3, i)
			table.insert(Mission.OhkaCarriersHQ3, ohkacarrier)
			AISetHintWeight(ohkacarrier, 15)
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp05.nar_comp_ohka")
		Mission.FirstOhkaSpawnDone = true
	end

	if not Mission.JapCVs[1].ignore then
		if table.getn(Mission.FightersCV1) ~= 0 then
			for index, unit in pairs(Mission.FightersCV1) do
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead fighter found in CV1 table, trying to replace it")
					if not Mission.JapCVs[1].Dead then
						Mission.FightersCV1[index] = luaQAC5SpawnFighter(1, index)
--[[
					else
-- RELEASE_LOGOFF  						luaLog("   CV1 is dead, replacing denied")
						Mission.JapCVs[1].ignore = true
]]
					end
				elseif UnitGetAttackTarget(unit) == nil then
					luaQAC5SetTarget(unit)
				end
			end
		end
		if table.getn(Mission.BombersCV1) ~= 0 then
			for index, unit in pairs(Mission.BombersCV1) do
				if unit.Dead then
					if not Mission.JapCVs[1].Dead then
-- RELEASE_LOGOFF  						luaLog("  dead bomber found in CV1 table, trying to replace it")
						Mission.BombersCV1[index] = luaQAC5SpawnBomber(1, index)
						AISetHintWeight(Mission.BombersCV1[index], 5)
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "CV1"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
	end

	if not Mission.JapCVs[2].ignore then
		if table.getn(Mission.FightersCV2) ~= 0 and Mission.JapSmallPlanes >= 2 then
			for index, unit in pairs(Mission.FightersCV2) do
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead fighter found in CV2 table, trying to replace it")
					if not Mission.JapCVs[2].Dead then
						Mission.FightersCV2[index] = luaQAC5SpawnFighter(2, index)
--[[
					else
-- RELEASE_LOGOFF  						luaLog("   CV2 is dead, replacing denied")
						Mission.JapCVs[2].ignore = true
]]
					end
				elseif UnitGetAttackTarget(unit) == nil then
					luaQAC5SetTarget(unit)
				end
			end
		end
		if table.getn(Mission.BombersCV2) ~= 0 and Mission.JapSmallPlanes >= 2 then
			for index, unit in pairs(Mission.BombersCV2) do
				if unit.Dead then
					if not Mission.JapCVs[2].Dead then
-- RELEASE_LOGOFF  						luaLog("  dead bomber found in CV2 table, trying to replace it")
						Mission.BombersCV2[index] = luaQAC5SpawnBomber(2, index)
						AISetHintWeight(Mission.BombersCV2[index], 5)
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "CV2"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
	end

	if not Mission.HQs[1].ignore then
		if table.getn(Mission.FightersHQ1) ~= 0 and Mission.JapSmallPlanes >= 3 then
			for index, unit in pairs(Mission.FightersHQ1) do
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead fighter found in HQ1 table, trying to replace it")
					if Mission.HQs[1].Party == PARTY_JAPANESE then
						Mission.FightersHQ1[index] = luaQAC5SpawnFighter(3, index)
--[[
					else
-- RELEASE_LOGOFF  						luaLog("   HQ1 is not owned by the Allied forces anymore, replacing denied")
						Mission.HQs[1].ignore = true
]]
					end
				elseif UnitGetAttackTarget(unit) == nil then
					luaQAC5SetTarget(unit)
				end
			end
		end
		if table.getn(Mission.BombersHQ1) ~= 0 and Mission.JapSmallPlanes >= 3 then
			for index, unit in pairs(Mission.BombersHQ1) do
				if unit.Dead then
					if Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  dead bomber found in HQ1 table, trying to replace it")
						Mission.BombersHQ1[index] = luaQAC5SpawnBomber(3, index)
						AISetHintWeight(Mission.BombersHQ1[index], 5)
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "HQ1"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
		if table.getn(Mission.OhkaCarriersHQ1) ~= 0 then
			for index, unit in pairs(Mission.OhkaCarriersHQ1) do
				if unit.Dead then
					if Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  dead betty found in HQ1 table, trying to replace it")
						Mission.OhkaCarriersHQ1[index] = luaQAC5SpawnOhkaCarrier(1, index)
						AISetHintWeight(Mission.OhkaCarriersHQ1[index], 15)
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "HQ1"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
	end

	if not Mission.HQs[2].ignore then
		if table.getn(Mission.OhkaCarriersHQ2) ~= 0 and Mission.JapBigPlanes >= 2 then
			for index, unit in pairs(Mission.OhkaCarriersHQ2) do
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead betty found in HQ2 table, trying to replace it")
					if Mission.HQs[2].Party == PARTY_JAPANESE then
						Mission.OhkaCarriersHQ2[index] = luaQAC5SpawnOhkaCarrier(2, index)
						AISetHintWeight(Mission.OhkaCarriersHQ2[index], 15)
--[[
					else
-- RELEASE_LOGOFF  						luaLog("   HQ2 is not owned by the Allied forces anymore, replacing denied")
						Mission.HQs[2].ignore = true
]]
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "HQ2"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
	end

	if not Mission.HQs[3].ignore then
		if table.getn(Mission.OhkaCarriersHQ3) ~= 0 and Mission.JapBigPlanes >= 3 then
			for index, unit in pairs(Mission.OhkaCarriersHQ3) do
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead betty found in HQ3 table, trying to replace it")
					if Mission.HQs[3].Party == PARTY_JAPANESE then
						Mission.OhkaCarriersHQ3[index] = luaQAC5SpawnOhkaCarrier(3, index)
						AISetHintWeight(Mission.OhkaCarriersHQ3[index], 15)
--[[
					else
-- RELEASE_LOGOFF  						luaLog("   HQ3 is not owned by the Allied forces anymore, replacing denied")
						Mission.HQs[3].ignore = true
]]
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
					luaQAC5SetTarget(unit)
				elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					unit.exitpoint = "HQ3"
					table.insert(Mission.BomberFilter, unit)
					AISetHintWeight(unit, 1)
				end
			end
		end
	end

	Mission.BomberFilter = luaRemoveDeadsFromTable(Mission.BomberFilter)
	if table.getn(Mission.BomberFilter) ~= 0 then
		for index, unit in pairs (Mission.BomberFilter) do
			local exitpos = 0
			if unit.exitpoint == "CV1" and not Mission.JapCVs[1].Dead then
				exitpos = GetPosition(Mission.JapCVs[1])
			elseif unit.exitpoint == "CV2" and not Mission.JapCVs[2].Dead then
				exitpos = GetPosition(Mission.JapCVs[2])
			elseif unit.exitpoint == "HQ1" and Mission.HQs[1].Party == PARTY_JAPANESE then
				exitpos = GetPosition(Mission.HQs[1])
			elseif unit.exitpoint == "HQ2" and Mission.HQs[2].Party == PARTY_JAPANESE then
				exitpos = GetPosition(Mission.HQs[2])
			elseif unit.exitpoint == "HQ3" and Mission.HQs[3].Party == PARTY_JAPANESE then
				exitpos = GetPosition(Mission.HQs[3])
			end

			if exitpos == 0 then
-- RELEASE_LOGOFF  				luaLog("  exit position not found for a filtered bomber, table CV1")
				exitpos = Mission.EmergencyExitPos
			end

			local checkpos = {["x"] = exitpos["x"], ["y"] = 400, ["z"] = exitpos["z"]}
			if luaGetDistance(unit, checkpos) < 1200 and not unit.landing then
				unit.landing = true
				SquadronSetTravelAlt(unit, 400)
			elseif luaGetDistance(unit, checkpos) < 150 then
-- RELEASE_LOGOFF  				luaLog("  a filtered bomber reached the exit position, softkill needed")
				table.remove(Mission.BomberFilter, index)
				Kill(unit, true)
			end
		end
	end
end

function luaQAC5SetTarget(unit)
	if unit.Class.Type == "Fighter" then
		local possibletargets = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQs[1]), 20000, PARTY_ALLIED, "own")
		if possibletargets ~= nil then
			local randomtarget = luaPickRnd(possibletargets)
-- RELEASE_LOGOFF  			luaLog("  fighter picking "..randomtarget.Name.." to attack")
			PilotSetTarget(unit, randomtarget)
		else
-- RELEASE_LOGOFF  			luaLog("   no target for fighter")
		end
	elseif unit.Class.Type == "DiveBomber" or unit.Class.Type == "TorpedoBomber" or unit.Class.Type == "LevelBomber" then
		local possibletargets = luaRemoveDeadsFromTable(Mission.USCVs)
		if table.getn(possibletargets) ~= 0 then
			local randomtarget = luaPickRnd(possibletargets)
-- RELEASE_LOGOFF  			luaLog("  bomber picking "..randomtarget.Name.." to attack")
			PilotSetTarget(unit, randomtarget)
		else
-- RELEASE_LOGOFF  			luaLog("   no target for bomber")
		end
	end
end

function luaQAC5SpawnFighter(tableindex, index)
	local posmod = 120 * index
	local posmod2 = 50 * index
	local spawnpos
	if tableindex == 1 then
-- RELEASE_LOGOFF  		luaLog("  fighter pos 1")
		spawnpos = GetPosition(Mission.JapCVs[1])
		--PutTo(fighter, {["x"] = spawnpos["x"] + posmod, ["y"] = 200, ["z"] = spawnpos["z"] + posmod})
	elseif tableindex == 2 then
-- RELEASE_LOGOFF  		luaLog("  fighter pos 2")
		spawnpos = GetPosition(Mission.JapCVs[2])
		--PutTo(fighter, {["x"] = spawnpos["x"] + posmod, ["y"] = 200, ["z"] = spawnpos["z"] + posmod})
	elseif tableindex == 3 then
-- RELEASE_LOGOFF  		luaLog("  fighter pos 3")
		spawnpos = GetPosition(Mission.HQs[1])
		--PutTo(fighter, {["x"] = spawnpos["x"] + posmod, ["y"] = 200, ["z"] = spawnpos["z"] + posmod})
	end
	local fighter = GenerateObject(Mission.FighterTMPL.Name, {["x"] = spawnpos["x"] + posmod, ["y"] = 200 + posmod2, ["z"] = spawnpos["z"] + posmod})
	SetSkillLevel(fighter, SKILL_SPNORMAL)
	luaQAC5SetTarget(fighter)
	return fighter
end

function luaQAC5SpawnBomber(tableindex, index)
	local posmod = 120 * index
	local posmod2 = 50 * index
	local spawnpos
	if tableindex == 1 then
-- RELEASE_LOGOFF  		luaLog("  bomber pos 1")
		spawnpos = GetPosition(Mission.JapCVs[1])
	elseif tableindex == 2 then
-- RELEASE_LOGOFF  		luaLog("  bomber pos 2")
		spawnpos = GetPosition(Mission.JapCVs[2])
	elseif tableindex == 3 then
-- RELEASE_LOGOFF  		luaLog("  bomber pos 3")
		spawnpos = GetPosition(Mission.HQs[1])
	end
	position = {["x"] = spawnpos["x"] + posmod, ["y"] = 150 + posmod2, ["z"] = spawnpos["z"] + posmod}
	local rndunit = luaPickRnd(Mission.BomberTMPLs)
	local bomber = GenerateObject(rndunit.Name, spawnpos)
	SetSkillLevel(bomber, SKILL_SPNORMAL)
	luaQAC5SetTarget(bomber)
	return bomber
end

function luaQAC5SpawnOhkaCarrier(tableindex, index)
-- RELEASE_LOGOFF  	luaLog(" luaQAC5SpawnOhkaCarrier called")
-- RELEASE_LOGOFF  	luaLog(tableindex)
	-- az index hasznalata kikotve
	local spawnpos = GetPosition(Mission.HQs[tableindex])
	--luaLog(spawnpos)
	local ohkacarrier = GenerateObject(Mission.OhkaCarrierTMPL.Name, {["x"] = spawnpos.x, ["y"] = 500, ["z"] = spawnpos.z})
	SetSkillLevel(ohkacarrier, SKILL_SPNORMAL)
	--luaLog(ohkacarrier)
	--PutTo(ohkacarrier, {["x"] = spawnpos["x"], ["y"] = 500, ["z"] = spawnpos["z"]})
	luaQAC5SetTarget(ohkacarrier)
	return ohkacarrier
end

function luaQACGivePowerups()
-- RELEASE_LOGOFF  	luaLog(" Checking powerup distribution...")
	local MPlayers = GetPlayerDetails()
	for slotID, value in pairs (MPlayers) do
		local tableID = slotID + 1
		if Mission.PowerupLevels[tableID] <= table.getn(Mission.PowerupLevelups) then
			if Scoring_GetTotalMissionScore(slotID) > Mission.PowerupLevelups[Mission.PowerupLevels[tableID]] then
				local powerup1
				local powerup2
				powerup1 = luaPickRnd(Mission.Powerups)
--[[
				repeat
					powerup2 = luaPickRnd(Mission.Powerups)
				until powerup1 ~= powerup2
]]
				AddPowerup(slotID, {["classID"] = powerup1, ["useLimit"] = 1})
				--AddPowerup(slotID, {["classID"] = powerup2, ["useLimit"] = 1})
				Mission.PowerupLevels[tableID] = Mission.PowerupLevels[tableID] + 1
				MissionNarrativePlayer(slotID, "mp05.nar_comp_supply")
			end
		end
	end
end

function luaQAC5CheckGameTime()
-- RELEASE_LOGOFF  	luaLog(" Checking gametime...")
	if CountdownTimeLeft() <= 900 and not Mission.FirstWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 15 minutes warining")
		Mission.FirstWarningDone = true
		MissionNarrativeParty(1, "15 minutes left!")
	elseif CountdownTimeLeft() <= 600 and not Mission.SecondWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 10 minutes warining")
		Mission.SecondWarningDone = true
		MissionNarrativeParty(1, "10 minutes left!")
	elseif CountdownTimeLeft() <= 300 and not Mission.ThirdWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 5 minutes warining")
		Mission.ThirdWarningDone = true
		MissionNarrativeParty(1, "5 minutes left!")
	elseif CountdownTimeLeft() <= 60 and not Mission.FourthWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 1 minutes warining")
		Mission.FourthWarningDone = true
		MissionNarrativeParty(1, "1 minute left!")
	end
end

function luaQAC5CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC5CheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
			--luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
			local PlayersInGame = GetPlayerDetails()
			local playerwhowon = PlayersInGame[highestindex]
			for index, value in pairs (PlayersInGame) do
				if playerwhowon.playerName ~= "" then
					MultiScore[index][4] = playerwhowon.playerName
					Mission.WinnerPlayer = playerwhowon.playerName
				else
					Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
					Mission.WinnerPlayerAILevel = playerwhowon.ailevel
					if playerwhowon.ailevel == 3 then
						MultiScore[index][4] = "FE.easy"
					elseif playerwhowon.ailevel == 4 then
						MultiScore[index][4] = "FE.normal"
					elseif playerwhowon.ailevel == 5 then
						MultiScore[index][4] = "FE.hard"
					end
				end
			end
			Mission.MissionEndCalled = true
			Mission.PointLimitReached = true
			CountdownCancel()
			ForceMultiScoreSend()
			luaDelay(luaQAC5MissionEnd, 0.1)
		end
	end

	if Mission.USCarriersDown and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		CountdownCancel()
		luaQAC5MissionEnd()
	end
end

function luaQAC5CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		--luaLog(" playerindex: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC5MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC5CheckHighestScore()
	local PlayersInGame = GetPlayerDetails()
	local playerwhowon = PlayersInGame[highestindex]
	for index, value in pairs (PlayersInGame) do
		if playerwhowon.playerName ~= "" then
			MultiScore[index][4] = playerwhowon.playerName
			Mission.WinnerPlayer = playerwhowon.playerName
		else
			Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
			Mission.WinnerPlayerAILevel = playerwhowon.ailevel
			if playerwhowon.ailevel == 3 then
				MultiScore[index][4] = "FE.easy"
			elseif playerwhowon.ailevel == 4 then
				MultiScore[index][4] = "FE.normal"
			elseif playerwhowon.ailevel == 5 then
				MultiScore[index][4] = "FE.hard"
			end
		end
	end
	Mission.MissionEndCalled = true
	Mission.TimeIsUp = true
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaQAC5MissionEnd, 0.1)
end

function luaQAC5MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
--[[
		if not Mission.TimeIsUp and not Mission.MissionFailed then
			MissionNarrativePlayer(0, "#MultiScore.0.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(1, "#MultiScore.1.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(2, "#MultiScore.2.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(3, "#MultiScore.3.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(4, "#MultiScore.4.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(5, "#MultiScore.5.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(6, "#MultiScore.6.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(7, "#MultiScore.7.4# |".."mp01.nar_comp_player_won")
		end
]]
		local highestindex, highestplayerscore = luaQAC5CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog("  player "..highestindex.." won, if the CVs are still up")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		if Mission.USCarriersDown then
-- RELEASE_LOGOFF  			luaLog("  CVs are down")
			luaObj_Failed("primary", 9)
		else
			luaObj_Completed("primary", 9)
		end
	
		if not Mission.Secondary1Failed then
			luaObj_Completed("secondary", 1)
		end
	
		if not Mission.Secondary2Failed then
			luaObj_Completed("secondary", 2)
		end

		luaQAC5DelayedMissionComplete()
		--luaDelay(luaQAC5DelayedMissionComplete, 4)
	end
end

function luaQAC5DelayedMissionComplete()
	if not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.USCarriersDown then
			luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
		else
			local possiblecamunits = luaRemoveDeadsFromTable(Mission.USCVs)
			luaMissionCompletedNew(luaPickRnd(possiblecamunits), "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive05")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC5CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC5CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		--luaLog(" playerindex: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC5HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive05_rockets")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive05_TB")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Competitive05_enemy_planes")
			Mission.Hint3Shown = true
		end
	end
end

function luaQACCheckListeners()
-- RELEASE_LOGOFF  	luaLog(" Checking Listeners...")
	if not Mission.ListenerTimerSet then
-- RELEASE_LOGOFF  		luaLog("  setting listener timer")
		Mission.ListenerTimerSet = true
		Mission.ListenerTimer = 40
		Mission.ReminderTimer = 0
	end

	if GameTime() > Mission.ListenerTimer and not Mission.ListenerActive then
		local randomtime = luaRnd(80, 120)
		Mission.ListenerTimer = GameTime() + randomtime
		Mission.ReminderTimer = GameTime() + 14
		Mission.AttackerShips = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
		Mission.AttackerPlanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
		if Mission.AttackerShips == nil then
			Mission.AttackerShips = {}
		end
		if Mission.AttackerPlanes == nil then
			Mission.AttackerPlanes = {}
		end
		if table.getn(Mission.AttackerShips) ~= 0 or table.getn(Mission.AttackerPlanes) ~= 0 then
			Mission.RandomListener = luaRnd(1, 2)
			if Mission.RandomListener == 1 and table.getn(Mission.AttackerShips) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerShips)
			elseif Mission.RandomListener == 2 and table.getn(Mission.AttackerPlanes) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerPlanes)
			else
				Mission.RandomTarget = nil
			end
			if Mission.RandomTarget ~= nil then
				MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
--[[
				if Mission.RandomListener == 1 then
					AISetHintWeight(Mission.RandomTarget, 80)
				else
					AISetHintWeight(Mission.RandomTarget, 20)
				end
]]
				luaQACRandomTargetKillListener(Mission.RandomTarget)
			end
		end
	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then
		Mission.ReminderTimer = GameTime() + 22
		if not Mission.RandomTarget.Dead then
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
		else
-- RELEASE_LOGOFF  			luaLog("  ERROR!!! Mission.ListenerActive was wrong")
			Mission.ListenerActive = false
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
		end
	end
end

function luaQACRandomTargetKillListener(target)
	if target ~= nil then
-- RELEASE_LOGOFF  		luaLog(" LISTENER: Activating kill listener on "..target.Name)
		AddListener("kill", "TargetKill", {
			["callback"] = "luaQACTargetKill",
			["entity"] = {target},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.ListenerActive = true
	else
-- RELEASE_LOGOFF  		luaLog(" LISTENER: listener activation failed, got nil for target")
	end
end

function luaQACTargetKill(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" luaQACTargetKill")
-- RELEASE_LOGOFF  	luaLog(target)
-- RELEASE_LOGOFF  	luaLog(lastAttacker)
-- RELEASE_LOGOFF  	luaLog(lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			if Mission.RandomListener == 1 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScoreShip)
			elseif Mission.RandomListener == 2 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScorePlane)
			end
			for i = 1, 8 do
-- RELEASE_LOGOFF  				luaLog("i = "..i)
				local y = i - 1
-- RELEASE_LOGOFF  				luaLog("y = "..y)
-- RELEASE_LOGOFF  				luaLog("lastAttackerPlayerIndex = "..lastAttackerPlayerIndex)
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  					luaLog(playerwhoscored)
-- RELEASE_LOGOFF  					luaLog(playerwhoscored.playerName)
					Mission.MultiScoreAILevel = 33
					for z = 1, 8 do
						local x = z - 1
						if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
							Mission.MultiScoreAILevel = 3
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
							Mission.MultiScoreAILevel = 4
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
							Mission.MultiScoreAILevel = 5
						end
						MultiScore[x][6] = playerwhoscored.playerName
					end
				end
]]
			end
			--luaDelay(luaKillNarrative, 2, "ai", Mission.MultiScoreAILevel)
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! lastAttackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! lastAttacker")
	end
	RemoveListener("kill", "TargetKill")
	Mission.ListenerActive = false
	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

function luaKillNarrative(timerthis)
	if timerthis.ParamTable.ai == 33 then
		MissionNarrativePlayer(0, "mp01.nar_comp_kill".."| #MultiScore.0.6#")
		MissionNarrativePlayer(1, "mp01.nar_comp_kill".."| #MultiScore.1.6#")
		MissionNarrativePlayer(2, "mp01.nar_comp_kill".."| #MultiScore.2.6#")
		MissionNarrativePlayer(3, "mp01.nar_comp_kill".."| #MultiScore.3.6#")
		MissionNarrativePlayer(4, "mp01.nar_comp_kill".."| #MultiScore.4.6#")
		MissionNarrativePlayer(5, "mp01.nar_comp_kill".."| #MultiScore.5.6#")
		MissionNarrativePlayer(6, "mp01.nar_comp_kill".."| #MultiScore.6.6#")
		MissionNarrativePlayer(7, "mp01.nar_comp_kill".."| #MultiScore.7.6#")
	elseif timerthis.ParamTable.ai == 3 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.hard")
	end
end

function luaQAC5CheckNearestEnemy()
-- RELEASE_LOGOFF  	luaLog(" Checking nearest enemy ship...")
	local nearestEnemy = nil
	if table.getn(Mission.USCVs) ~= 0 then
		for index, unit in pairs (Mission.USCVs) do
			if not unit.Dead then
				nearestEnemy = luaGetNearestEnemy(unit, "cruiser")
				if nearestEnemy ~= nil then
					AISetHintWeight(nearestEnemy, 100)
				end
			end
		end
	end
	if nearestEnemy ~= nil then
		luaDelay(luaQAC5CheckNearestEnemy, 30)
	else
-- RELEASE_LOGOFF  		luaLog("  no more cruisers around!")
	end
end