--SceneFile="Missions\Multi\Scene2.scn"

function luaPrecacheUnits()
	PrepareClass(158) -- Val
	--PrepareClass(159) -- Judy
	--PrepareClass(163) -- Jill
	PrepareClass(162) -- Kate
	--PrepareClass(166) -- Nell
	PrepareClass(32) -- Betty - Ohka
	--PrepareClass(174) -- Mavis
	--PrepareClass(175) -- Emily
	PrepareClass(77) -- Elco
	PrepareClass(75) -- Minekaze
	PrepareClass(73) -- Fubuki
	PrepareClass(70) -- Kuma
	PrepareClass(67) -- Mogami
	PrepareClass(81) -- TypeB w Kaiten
	PrepareClass(43) -- Kamikaze Boat
	PrepareClass(60) -- Kongo
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC2Mission")
end

function luaInitQAC2Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp2"..dateandtime

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 2
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

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

	-- mission tablak, valtozok
	Mission.CenterPoint = {["x"] = -9850, ["y"] = 0, ["z"] = 1900}
		--Competitive_nw = V3 -14594.7715 0.0000 5987.0171 ;
		--Competitive_se = V3 -7501.8823 0.0000 -2361.9036 ;
--[[
	Mission.ExitPoints = {}
		table.insert(Mission.ExitPoints, {["x"] = -14500, ["y"] = 100, ["z"] = 2000})
		table.insert(Mission.ExitPoints, {["x"] = -11000, ["y"] = 100, ["z"] = -2350})
		table.insert(Mission.ExitPoints, {["x"] = -7500, ["y"] = 100, ["z"] = 2000})
		table.insert(Mission.ExitPoints, {["x"] = -11000, ["y"] = 100, ["z"] = 5950})
	Mission.EntryPoints = {}
		table.insert(Mission.EntryPoints, {["x"] = -13000, ["y"] = 100, ["z"] = -850})
		table.insert(Mission.EntryPoints, {["x"] = -13000, ["y"] = 100, ["z"] = 4450})
		table.insert(Mission.EntryPoints, {["x"] = -9000, ["y"] = 100, ["z"] = -850})
		table.insert(Mission.EntryPoints, {["x"] = -9000, ["y"] = 100, ["z"] = 4450})
]]
	Mission.SpawnPosition = nil
	Mission.ExitNumber = nil
	Mission.ExitValue = nil

	Mission.KillScoreSub = 250
	Mission.KillScoreShip = 175
	Mission.KillScorePlane = 100

	-- amerikai objektumok
	Mission.PlayerShips = {}
		--table.insert(Mission.PlayerShips, FindEntity("Comp - Test - Cleveland"))
		--SetGuiName(Mission.PlayerShips[1], "Tesztunit")

	Mission.HQ = FindEntity("Comp - HQ")
	Mission.TurnToPoint = GetPosition(Mission.HQ)
	--SetParty(Mission.HQ, PARTY_ALLIED)

	-- japan objektumok
	Mission.Bomb1Judy = luaFindHidden("Comp - 1xBomb - Judy")
	Mission.Bomb1Val = luaFindHidden("Comp - 1xBomb - Val")
	Mission.Bomb6Nell = luaFindHidden("Comp - 6xBomb - Nell")
	Mission.Bomb12Betty = luaFindHidden("Comp - 12xBomb - Betty")
	Mission.Torp1Jill = luaFindHidden("Comp - 1xTorp - Jill")
	Mission.Torp1Kate = luaFindHidden("Comp - 1xTorp - Kate")
	Mission.Torp4Emily = luaFindHidden("Comp - 4xTorp - Emily")
	Mission.Torp4Mavis = luaFindHidden("Comp - 4xTorp - Mavis")
	Mission.Kami1Betty = luaFindHidden("Comp - 1xKami -  Betty")
	Mission.StrikePlaneTMPL = luaFindHidden("Comp - Betty")
	Mission.JapShipPaths = {}
		table.insert(Mission.JapShipPaths, FindEntity("Comp - JapShipPath 1"))
		table.insert(Mission.JapShipPaths, FindEntity("Comp - JapShipPath 2"))
		table.insert(Mission.JapShipPaths, FindEntity("Comp - JapShipPath 3"))
		table.insert(Mission.JapShipPaths, FindEntity("Comp - JapShipPath 4"))

	-- jatekosok
	Mission.Player1 = false
	Mission.Player2 = false
	Mission.Player3 = false
	Mission.Player4 = false
	Mission.Player5 = false
	Mission.Player6 = false
	Mission.Player7 = false
	Mission.Player8 = false
	Mission.AI1 = false -- AI jatekosok
	Mission.AI2 = false
	Mission.AI3 = false
	Mission.AI4 = false
	Mission.AI5 = false
	Mission.AI6 = false
	Mission.AI7 = false
	Mission.AI8 = false
	Mission.Wandering1Ready = false -- filterezes
	Mission.Wandering2Ready = false
	Mission.Wandering3Ready = false
	Mission.Wandering4Ready = false
	Mission.Wandering5Ready = false
	Mission.Wandering6Ready = false
	Mission.Wandering7Ready = false
	Mission.Wandering8Ready = false

	-- revamp cucc
	Mission.SpawnPositions = {}
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 1")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 2")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 3")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 4")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 5")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 6")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 7")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Comp - Navpoint 8")))
	Mission.ExitPoint = {}
		table.insert(Mission.ExitPoint, GetPosition(FindEntity("Comp - Navpoint 9")))
		-- {["x"] = -14097.0156, ["y"] = 150.0000, ["z"] = 5326.4497})
	Mission.StrikePoints = {}
		table.insert(Mission.StrikePoints, GetPosition(FindEntity("Comp - Navpoint 10")))
		table.insert(Mission.StrikePoints, GetPosition(FindEntity("Comp - Navpoint 11")))
		table.insert(Mission.StrikePoints, GetPosition(FindEntity("Comp - Navpoint 12")))
	Mission.AssaultPoint = GetPosition(FindEntity("Comp - AssaultPoint"))

	--Mission.PlaneWave = 1
	Mission.PlaneWaveDone = false
	Mission.ShipWave = 1
	Mission.ShipWaveDone = false

	Mission.TypeVal = 158
	Mission.NameVal = "globals.unitclass_val"
	--Mission.TypeJudy = 159
	--Mission.NameJudy = "Judy"
	--Mission.TypeJill = 163
	--Mission.NameJill = "Jill"
	Mission.TypeKate = 162
	Mission.NameKate = "globals.unitclass_kate"
	--Mission.TypeNell = 166
	--Mission.NameNell = "Nell"
	--Mission.TypeBetty = 167
	--Mission.NameBetty = "Betty"
	--Mission.TypeMavis = 174
	--Mission.NameMavis = "Mavis"
	--Mission.TypeEmily = 175
	--Mission.NameEmily = "Emily"
	--Mission.TypePT = 77
	--Mission.NamePT = "Patrol Boat"
	Mission.TypeMinekaze = 75
	Mission.NameMinekaze = "globals.unitclass_minekaze"
	Mission.TypeFubuki = 73
	Mission.NameFubuki = "globals.unitclass_fubuki"
	Mission.TypeKuma = 70
	Mission.NameKuma = "globals.unitclass_kuma"
	Mission.TypeMogami = 67
	Mission.NameMogami = "globals.unitclass_mogami"
	Mission.TypeKongo = 60
	Mission.NameKongo = "globals.unitclass_kongo"
	Mission.TypeTypeB = 81
	Mission.NameTypeB = "globals.unitclass_typeb"
	Mission.TypeKamikazeBoat = 43
	Mission.NameKamikazeBoat = "globals.unitclass_kamikazeboat"

	Mission.AttackerShips = {}
	Mission.AttackerPlanes = {}
	Mission.RetreatingPlanes = {}
	Mission.ShipsInScene = {}
	Mission.StrikePlanes = {}
	Mission.KamikazeBoats = {}

	--Mission.Players = 0
	--Mission.AIPlayers = 0
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
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 3
		Mission.RndPlaneMax = 4
		Mission.Ships = 2
		Mission.ShipsHalf = 1
		Mission.BB = 1
	elseif Mission.Players == 3 or Mission.Players == 4 then
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 3
		Mission.RndPlaneMax = 4
		Mission.Ships = 3
		Mission.ShipsHalf = 2
		Mission.BB = 1
--[[
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 3
		Mission.RndPlaneMax = 5
		Mission.Ships = 4 
		Mission.ShipsHalf = 2
		Mission.BB = 1
]]
	elseif Mission.Players == 5 or Mission.Players == 6 then
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 4
		Mission.RndPlaneMax = 5
		Mission.Ships = 5
		Mission.ShipsHalf = 3
		Mission.BB = 1
--[[
		Mission.StrikePlaneNumber = 2
		Mission.RndPlaneMin = 3
		Mission.RndPlaneMax = 5
		Mission.Ships = 6 
		Mission.ShipsHalf = 3
		Mission.BB = 1
]]
	elseif Mission.Players == 7 then
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 4
		Mission.RndPlaneMax = 5
		Mission.Ships = 5
		Mission.ShipsHalf = 3
		Mission.BB = 1
--[[
		Mission.StrikePlaneNumber = 2
		Mission.RndPlaneMin = 5
		Mission.RndPlaneMax = 7
		Mission.Ships = 8
		Mission.ShipsHalf = 4
		Mission.BB = 2
]]
	elseif Mission.Players == 8 then
		Mission.StrikePlaneNumber = 1
		Mission.RndPlaneMin = 5
		Mission.RndPlaneMax = 6
		Mission.Ships = 6
		Mission.ShipsHalf = 4
		Mission.BB = 2
--[[
		Mission.StrikePlaneNumber = 3
		Mission.RndPlaneMin = 6
		Mission.RndPlaneMax = 8
		Mission.Ships = 8
		Mission.ShipsHalf = 4
		Mission.BB = 2
]]
	end
--[[	
	Mission.PlayersDiv2 = math.floor(Mission.Players / 2)
	if Mission.PlayersDiv2 == 0 or Mission.PlayersDiv2 == 1 then
		Mission.PlayersDiv2 = 2
	end
	Mission.PlayersDiv4 = math.floor(Mission.Players / 4)
	if Mission.PlayersDiv4 == 0 then
		Mission.PlayersDiv4 = 1
	end
	Mission.PlayersDiv8 = math.floor(Mission.Players / 8)
	if Mission.PlayersDiv8 == 0 then
		Mission.PlayersDiv8 = 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Div2: "..Mission.PlayersDiv2.." | Div4: "..Mission.PlayersDiv4.." | Div8: "..Mission.PlayersDiv8)
]]
--[[
	local players = Multi_GetPlayers()
	for playerindex, playerparty in pairs (players) do
		if playerindex == 0 then
			Mission.Player1 = true
		elseif playerindex == 1 then
			Mission.Player2 = true
		elseif playerindex == 2 then
			Mission.Player3 = true
		elseif playerindex == 3 then
			Mission.Player4 = true
		elseif playerindex == 4 then
			Mission.Player5 = true
		elseif playerindex == 5 then
			Mission.Player6 = true
		elseif playerindex == 6 then
			Mission.Player7 = true
		elseif playerindex == 7 then
			Mission.Player8 = true
		end
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Human players total: "..Mission.Players)

	-- lefigyelesek
]]
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
				["ID"] = "us_obj_primary_2_player_all",
				["Text"] = "mp02.obj_comp_p2_text",
				["TextCompleted"] = "mp02.obj_comp_p2_comp",
				["TextFailed"] = "mp02.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
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
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = Mission.Digit4,
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
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.8#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.8#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.8#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.8#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.8#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.8#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.8#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.8#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.8#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.8#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.8#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.8#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.8#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.8#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.8#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.8#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][8] = Mission.PointLimit
		end
	end

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC2Mission_think")
end

function luaQAC2Mission_think(this, msg)
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
		luaQAC2CheckListeners()
		--luaQAC2CheckGameTime()
		luaQAC2CheckMissionEnd()
		luaQAC2CheckWaves()
		luaQAC2FilterBombers()
		luaQAC2CheckEnemyShips()
		--luaUpdateCounters()
		luaQAC2HintManager()

	elseif not Mission.Started then
		luaQAC2StartMission()
		luaUpdateCounters()
	end
end

function luaQAC2StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC2MissionEndTimeIsUp")
	end

	luaDelay(luaQAC2StrikePlayerShips, 300)

	luaDelay(luaPermitPlaneSpawn, 4)
	luaDelay(luaPermitShipSpawn, 24)
	luaObj_Add("primary", 9)
	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	Mission.Started = true
end

function luaPermitPlaneSpawn()
	Mission.PlaneWaveDone = true
end

function luaPermitShipSpawn()
	Mission.ShipWaveDone = true
end

function luaQAC2CheckWaves()
-- RELEASE_LOGOFF  	luaLog("  Checking Waves...")
	if not Mission.PlaneWaveReady then
		Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
		if table.getn(Mission.AttackerPlanes) == 0 then
			Mission.PlaneWaveReady = true
		end
	end

	if Mission.PlaneWaveReady and Mission.PlaneWaveDone then
-- RELEASE_LOGOFF  		luaLog("    sending plane wave")
--		if Mission.PlaneWave == 1 then
			MissionNarrativeParty(0, "mp02.nar_comp_bombers")
			local divebombersnumber = luaRnd(Mission.RndPlaneMin, Mission.RndPlaneMax)
			for i = 1, divebombersnumber do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 3, 1)
			end
			local torpedobombersnumber = Mission.RndPlaneMax - divebombersnumber
			if torpedobombersnumber ~= 0 then
				for i = 1, torpedobombersnumber do
					local spawnpos = divebombersnumber + i
					luaSpawnUnit(Mission.SpawnPositions[spawnpos], Mission.TypeKate, Mission.NameKate, 3, 1)
				end
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
--[[
		elseif Mission.PlaneWave == 2 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.PlayersDiv2 do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 2, 1)
			end

			for i = 1, Mission.PlayersDiv2 do
				local sp = i + 4
				luaSpawnUnit(Mission.SpawnPositions[sp], Mission.TypeKate, Mission.NameKate, 2, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 3 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 2, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 4 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 2, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 5 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 2, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 6 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 2, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 7 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 3, 1)
			end
			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)
			
		elseif Mission.PlaneWave == 8 then
			MissionNarrativeParty(0, "Planes incoming!")
			for i = 1, Mission.Players do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeVal, Mission.NameVal, 3, 1)
			end

			Mission.PlaneWaveDone = false
			luaDelay(luaDelayedPlaneWave, 45)

		elseif Mission.PlaneWave == 9 then
			Mission.PlaneWave = 1
		end
]]
		Mission.PlaneWaveReady = false
	end

	if not Mission.ShipWaveReady then
		Mission.AttackerShips = luaRemoveDeadsFromTable(Mission.AttackerShips)
		if table.getn(Mission.AttackerShips) == 0 then
			Mission.ShipWaveReady = true
		end
	end

	if Mission.ShipWaveReady and Mission.ShipWaveDone then
-- RELEASE_LOGOFF  		luaLog("    sending ship wave")
--[[
		if Mission.ShipWave == 1 then
			MissionNarrativeParty(0, "Ships incoming!")
			for i = 1, Mission.Ships do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypePT, Mission.NamePT, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
]]
		if Mission.ShipWave == 1 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			for i = 1, Mission.Ships do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeMinekaze, Mission.NameMinekaze, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
			
		elseif Mission.ShipWave == 2 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			for i = 1, Mission.ShipsHalf do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeFubuki, Mission.NameFubuki, 1, 1)
			end
			for i = 1, Mission.ShipsHalf do
				local sp = i + 4
				luaSpawnUnit(Mission.SpawnPositions[sp], Mission.TypeKuma, Mission.NameKuma, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
			
		elseif Mission.ShipWave == 3 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			for i = 1, Mission.Ships do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeKuma, Mission.NameKuma, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
			
		elseif Mission.ShipWave == 4 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			for i = 1, Mission.ShipsHalf do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeMinekaze, Mission.NameMinekaze, 1, 1)
			end
			for i = 1, Mission.ShipsHalf do
				local sp = i + 4
				luaSpawnUnit(Mission.SpawnPositions[sp], Mission.TypeMogami, Mission.NameMogami, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
			
		elseif Mission.ShipWave == 5 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			for i = 1, Mission.Ships do
				luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeMogami, Mission.NameMogami, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)
			
		elseif Mission.ShipWave == 6 then
			MissionNarrativeParty(0, "mp02.nar_comp_ships")
			local firstspawnpoint = luaRnd(1, 6)
			for i = 1, Mission.BB do
				local sp = firstspawnpoint + i
				luaSpawnUnit(Mission.SpawnPositions[sp], Mission.TypeKongo, Mission.NameKongo, 1, 1)
			end
			Mission.ShipWaveDone = false
			luaDelay(luaDelayedShipWave, 45)

		elseif Mission.ShipWave == 7 then
			if GameTime() <= 240 then
				Mission.ShipWave = 1
			elseif GameTime() <= 480 then
				Mission.ShipWave = 2
			elseif GameTime() <= 720 then
				Mission.ShipWave = 3
			elseif GameTime() <= 960 then
				Mission.ShipWave = 4
			elseif GameTime() <= 1440 then
				Mission.ShipWave = 5
			elseif GameTime() > 1440 then
				Mission.ShipWave = 6
--[[
			elseif GameTime() <= 1680 then
				Mission.ShipWave = 7
]]
			end
		end
		Mission.ShipWaveReady = false
	end
end

function luaSpawnUnit(position, unittype, unitname, wingcount, eqindex)
	--luaLog("    spawning "..unitname)
	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPANESE,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC2UnitSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC2UnitSpawned(aiunit)
	Mission.RandomEntity = nil
	local alliedships = luaGetShipsAroundCoordinate(Mission.CenterPoint, 20000, PARTY_ALLIED, "own")
	if alliedships ~= nil then
		if table.getn(alliedships) ~= 0 then
			Mission.RandomEntity = luaPickRnd(alliedships)
		else
			if not Mission.HQ.Dead then
				Mission.RandomEntity = Mission.HQ
			end
		end
	end

	if aiunit.Class.ID == 43 then
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class.ID == 43")
		AISetHintWeight(aiunit, 10)
		local closestenemy = luaGetNearestEnemy(aiunit)
		if closestenemy ~= nil then
			NavigatorAttackMove(aiunit, closestenemy, {})
		end
		table.insert(Mission.KamikazeBoats, aiunit)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
	elseif aiunit.Class.Type == "Destroyer" then
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class.Type == Destroyer")
		AISetHintWeight(aiunit, 30)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
		TorpedoEnable(aiunit, true)
		local closest = 10000
		local closestindex = 0
		for i = 1, 4 do
			if luaGetDistance(aiunit, Mission.SpawnPositions[i]) < closest then
				closestindex = i
				closest = luaGetDistance(aiunit, Mission.SpawnPositions[i])
			end
		end
		NavigatorMoveOnPath(aiunit, Mission.JapShipPaths[closestindex], PATH_FM_CIRCLE, PATH_SM_JOIN)
--[[
		if Mission.RandomEntity ~= nil then
-- RELEASE_LOGOFF  			luaLog("  calling NavigatorAttackMove(aiunit, Mission.RandomEntity, {})")
			luaSetScriptTarget(aiunit, Mission.RandomEntity)
			NavigatorAttackMove(aiunit, Mission.RandomEntity, {})
		end
]]
		table.insert(Mission.AttackerShips, aiunit)
	elseif aiunit.Class.Type == "Cruiser" or aiunit.Class.Type == "BattleShip" then
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class.Type == Cruiser or Battleship")
		AISetHintWeight(aiunit, 50)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
		TorpedoEnable(aiunit, true)
		local closest = 10000
		local closestindex = 0
		for i = 1, 4 do
			if luaGetDistance(aiunit, Mission.SpawnPositions[i]) < closest then
				closestindex = i
				closest = luaGetDistance(aiunit, Mission.SpawnPositions[i])
			end
		end
		NavigatorMoveOnPath(aiunit, Mission.JapShipPaths[closestindex], PATH_FM_CIRCLE, PATH_SM_JOIN)
		table.insert(Mission.AttackerShips, aiunit)
	elseif aiunit.Class.ID == 81 then
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class.ID == 81")
		AISetHintWeight(aiunit, 10)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
		TorpedoEnable(aiunit, true)
		local closestenemy = luaGetNearestEnemy(aiunit)
		if closestenemy ~= nil then
			NavigatorAttackMove(aiunit, closestenemy, {})
		end
		for i = 1, 8 do
			luaObj_AddUnit("primary", i, aiunit)
		end
		Mission.AttackerSub = aiunit
	elseif aiunit.Class.Type == "TorpedoBomber" then
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class.Type == TorpedoBomber")
		AISetHintWeight(aiunit, 5)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
		if Mission.RandomEntity ~= nil then
-- RELEASE_LOGOFF  			luaLog("  calling PilotSetTarget(aiunit, Mission.RandomEntity)")
			PilotSetTarget(aiunit, Mission.RandomEntity)
		end
		table.insert(Mission.AttackerPlanes, aiunit)
	else
-- RELEASE_LOGOFF  		luaLog(" aiunit.Class else")
		AISetHintWeight(aiunit, 5)
		EntityTurnToPosition(aiunit, Mission.TurnToPoint)
		if Mission.HQ.Party == PARTY_ALLIED then
-- RELEASE_LOGOFF  			luaLog("  calling PilotSetTarget(aiunit, Mission.HQ)")
			PilotSetTarget(aiunit, Mission.HQ)
		end
		SquadronSetTravelAlt(aiunit, 100)
		table.insert(Mission.AttackerPlanes, aiunit)
	end
end

function luaDelayedPlaneWave()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  Delayed spawn called for plane wave")
		--Mission.PlaneWave = Mission.PlaneWave + 1
		Mission.PlaneWaveDone = true
	end
end

function luaDelayedShipWave()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  Delayed spawn called for ship wave")
		Mission.ShipWave = Mission.ShipWave + 1
		Mission.ShipWaveDone = true
	end
end

function luaQAC2StrikePlayerShips()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  Spawning Ohka planes...")
		MissionNarrativeParty(0, "mp02.nar_comp_ohka")
		for i = 1, Mission.StrikePlaneNumber do
			local strikeplane = GenerateObject(Mission.StrikePlaneTMPL.Name, Mission.StrikePoints[i])
			--PutTo(strikeplane, Mission.StrikePoints[i])
			strikeplane.enterpoint = i
			Mission.OhkaTarget = nil
			local alliedships = luaGetShipsAroundCoordinate(Mission.CenterPoint, 20000, PARTY_ALLIED, "own")
			if alliedships ~= nil then
				if table.getn(alliedships) ~= 0 then
					local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
					for index, unit in pairs (alliedships) do
						local ownerID = GetRoleAvailable(unit)[1]
						if ownerID == highestindex then
							Mission.OhkaTarget = unit
						end
					end
					if Mission.OhkaTarget ~= nil then
						PilotSetTarget(strikeplane, Mission.OhkaTarget)
					else
						local randomentity = luaPickRnd(alliedships)
						PilotSetTarget(strikeplane, randomentity)
					end
				end
			end
			table.insert(Mission.StrikePlanes, strikeplane)
		end
		local randomtimer = luaRnd(80, 120)
		luaDelay(luaQAC2StrikePlayerShips, randomtimer)
	end
end

function luaQAC2FilterBombers()
-- RELEASE_LOGOFF  	luaLog("  Filtering bombers...")
	Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
	for index, unit in pairs (Mission.AttackerPlanes) do
		if unit.Class.Type == "TorpedoBomber" then
			if UnitGetAttackTarget(unit) == nil or table.getn(GetPayloads(unit)) == 0 then
-- RELEASE_LOGOFF  				luaLog("   "..unit.Name.." doesn't have a target")
				PilotMoveTo(unit, Mission.ExitPoint[1])
				SquadronSetTravelAlt(unit, 100)
				AISetHintWeight(unit, 1)
				table.remove(Mission.AttackerPlanes, index)
				table.insert(Mission.RetreatingPlanes, unit)
			end
		else
			local payloads = GetPayloads(unit)
			if table.getn(payloads) == 0 then
-- RELEASE_LOGOFF  				luaLog("   "..unit.Name.." is out of equipment")
				PilotMoveTo(unit, Mission.ExitPoint[1])
				AISetHintWeight(unit, 1)
				SquadronSetTravelAlt(unit, 100)
				table.remove(Mission.AttackerPlanes, index)
				table.insert(Mission.RetreatingPlanes, unit)
			end
		end
	end

	Mission.StrikePlanes = luaRemoveDeadsFromTable(Mission.StrikePlanes)
	for index, unit in pairs (Mission.StrikePlanes) do
		if UnitGetAttackTarget(unit) == nil or table.getn(GetPayloads(unit)) == 0 then
			PilotMoveTo(unit, Mission.StrikePoints[unit.enterpoint])
			table.remove(Mission.StrikePlanes, index)
			table.insert(Mission.RetreatingPlanes, unit)
		end
	end

	Mission.RetreatingPlanes = luaRemoveDeadsFromTable(Mission.RetreatingPlanes)
	for index, unit in pairs (Mission.RetreatingPlanes) do
		if unit.enterpoint ~= nil then
			if luaGetDistance(unit, Mission.StrikePoints[unit.enterpoint]) < 450 then
-- RELEASE_LOGOFF  				luaLog("   killing "..unit.Name)
				Kill(unit, true)
			end
		elseif luaGetDistance(unit, Mission.ExitPoint[1]) < 400 then
-- RELEASE_LOGOFF  			luaLog("   killing "..unit.Name)
			Kill(unit, true)
		end
	end
end

function luaQAC2CheckEnemyShips()
-- RELEASE_LOGOFF  	luaLog("  Checking enemy ships...")
	Mission.RandomEntity = nil
	Mission.AttackerShips = luaRemoveDeadsFromTable(Mission.AttackerShips)
	if table.getn(Mission.AttackerShips) ~= 0 then
		for index, unit in pairs(Mission.AttackerShips) do
			if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  				luaLog("   "..unit.Name.." doesn't have a target")
				local alliedships = luaGetShipsAroundCoordinate(Mission.CenterPoint, 20000, PARTY_ALLIED, "own")
				local trgrnd = luaRnd(1, 7)
				if trgrnd <= 5 then
					if alliedships ~= nil then
						alliedships = luaRemoveDeadsFromTable(alliedships)
						if table.getn(alliedships) ~= 0 then
							Mission.RandomEntity = luaPickRnd(alliedships)
						end
					else
						if Mission.HQ.Party == PARTY_ALLIED then
							Mission.RandomEntity = Mission.HQ
						end
					end
				else
					if Mission.HQ.Party == PARTY_ALLIED then
						Mission.RandomEntity = Mission.HQ
					end
				end

				if Mission.RandomEntity ~= nil then
-- RELEASE_LOGOFF  					luaLog("TARGET: "..Mission.RandomEntity.Name.." | ID: "..Mission.RandomEntity.ID)
					luaSetScriptTarget(unit, Mission.RandomEntity)
					NavigatorAttackMove(unit, Mission.RandomEntity, {})
				end
--[[
			elseif UnitGetAttackTarget(unit) == Mission.HQ then
-- RELEASE_LOGOFF  				luaLog("   "..unit.Name.." is attacking the HQ, searching for ships")
				local alliedships = luaGetShipsAroundCoordinate(Mission.CenterPoint, 20000, PARTY_ALLIED, "own")
				if alliedships ~= nil then
					alliedships = luaRemoveDeadsFromTable(alliedships)
					if table.getn(alliedships) ~= 0 then
						Mission.RandomEntity = luaPickRnd(alliedships)
-- RELEASE_LOGOFF  						luaLog("TARGET: "..Mission.RandomEntity.Name.." | ID: "..Mission.RandomEntity.ID)
						luaSetScriptTarget(unit, Mission.RandomEntity)
						NavigatorAttackMove(unit, Mission.RandomEntity, {})
					end
				end
]]
			end
		end
	end

	if not Mission.SubInitDone then
		Mission.SubInitDone = true
		local subrandomtime = luaRnd(15, 150)
		Mission.NextSubSpawnTime = 250 + subrandomtime
	else
		if Mission.NextSubSpawnTime < GameTime() then
			Mission.NextSubSpawnTime = 100000
			if Mission.AttackerSub == nil then
				local position = luaPickRnd(Mission.SpawnPositions)
				local subposition = {["x"] = position.x, ["y"] = -80, ["z"] = position.z}
				luaSpawnUnit(subposition, Mission.TypeTypeB, Mission.NameTypeB, 1, 1)
			elseif Mission.AttackerSub.Dead then
				local position = luaPickRnd(Mission.SpawnPositions)
				local subposition = {["x"] = position.x, ["y"] = -80, ["z"] = position.z}
				luaSpawnUnit(subposition, Mission.TypeTypeB, Mission.NameTypeB, 1, 1)
			end
			Mission.SubCheck = false
			luaDelay(luaQAC2SubCheckEnabler, 30)
		end
		if Mission.SubCheck then
			if Mission.AttackerSub ~= nil then
				if not Mission.AttackerSub.Dead and not Mission.SubListenerInitiated then
-- RELEASE_LOGOFF  					luaLog(" LISTENER: Activating kill listener on "..Mission.AttackerSub.Name)
					AddListener("kill", "SubKill", {
						["callback"] = "luaQAC2SubKill",
						["entity"] = {Mission.AttackerSub},
						["lastAttacker"] = {},
						["lastAttackerPlayerIndex"] = {},
					})
					Mission.SubListenerInitiated = true
				elseif not Mission.AttackerSub.Dead then
					if UnitGetAttackTarget(Mission.AttackerSub) == nil then
						local closestenemy = luaGetNearestEnemy(Mission.AttackerSub)
						if closestenemy ~= nil then
							NavigatorAttackMove(Mission.AttackerSub, closestenemy, {})
						end
					end
				end
			end
		end
	end

	Mission.KamikazeBoats = luaRemoveDeadsFromTable(Mission.KamikazeBoats)
	if not Mission.KamikazeBoatInitDone then
		local kamikazeboatrandomtime = luaRnd(10, 75)
		Mission.NextKamikazeBoatSpawnTime = 150 + kamikazeboatrandomtime
		if Mission.Players <= 2 then
			Mission.KamikazeBoatNumber = 1
		elseif Mission.Players <= 5 then
			Mission.KamikazeBoatNumber = 2
		elseif Mission.Players <= 8 then
			Mission.KamikazeBoatNumber = 3
		end
		Mission.KamikazeBoatInitDone = true
	else
		if Mission.NextKamikazeBoatSpawnTime < GameTime() then
			if table.getn(Mission.KamikazeBoats) == 0 then
				local positionnumber = luaRnd(1,2)
				local position
				local kamikazeboatposition
				if positionnumber == 1 then
					position = Mission.SpawnPositions[1]
					kamikazeboatposition = {["x"] = position.x, ["y"] = 0, ["z"] = position.z + 400}
				else
					position = Mission.SpawnPositions[4]
					kamikazeboatposition = {["x"] = position.x + 400, ["y"] = 0, ["z"] = position.z}
				end
				for i = 1, Mission.KamikazeBoatNumber do
					local posmod = i * 100 
					local pos
					if positionnumber == 1 then
						pos = {["x"] = kamikazeboatposition.x - posmod, ["y"] = 0, ["z"] = kamikazeboatposition.z}
					else
						pos = {["x"] = kamikazeboatposition.x, ["y"] = 0, ["z"] = kamikazeboatposition.z - posmod}
					end
					luaSpawnUnit(pos, Mission.TypeKamikazeBoat, Mission.NameKamikazeBoat, 1, 1)
				end
				Mission.NextKamikazeBoatSpawnTime = 100000
				Mission.KamikazeBoatSpawnTimeInitiated = false
				luaDelay(luaQAC2KamikazeBoatsCheckEnabler, 30)
			end
		end

		if Mission.KamikazeBoatsCheck then
			if table.getn(Mission.KamikazeBoats) ~= 0 then
				for index, unit in pairs (Mission.KamikazeBoats) do
					if UnitGetAttackTarget(unit) == nil then
						local closestenemy = luaGetNearestEnemy(unit)
						if closestenemy ~= nil then
							NavigatorAttackMove(unit, closestenemy, {})
						end
					end
				end
			elseif not Mission.KamikazeBoatSpawnTimeInitiated then
				local kamikazeboatrandomtime = luaRnd(25, 75)
				Mission.NextKamikazeBoatSpawnTime = 75 + kamikazeboatrandomtime
				Mission.KamikazeBoatsCheck = false
				Mission.KamikazeBoatSpawnTimeInitiated = true
			end
		end
	end
end

function luaQAC2SubCheckEnabler()
	Mission.SubCheck = true
end

function luaQAC2KamikazeBoatsCheckEnabler()
	Mission.KamikazeBoatsCheck = true
end

function luaQAC2CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.HQ.Party ~= PARTY_ALLIED and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		for index, entity in pairs (Mission.SpawnPoints) do
			local slotID = index - 1
			for index2, value in pairs (Mission.SlotIDTable) do
				if slotID == value then
-- RELEASE_LOGOFF  					luaLog(" deactivating SPID "..index.." for slotID "..value)
					DeactivateSpawnpoint(entity, value)
				end
			end
		end
		luaQAC2MissionEnd()
	end

	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
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
			luaDelay(luaQAC2MissionEnd, 0.1)
		end
	end
end
--[[
function luaQAC2CheckGameTime()
-- RELEASE_LOGOFF  	luaLog(" Checking gametime...")
	if CountdownTimeLeft() <= 900 and not Mission.FirstWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 15 minutes warining")
		Mission.FirstWarningDone = true
		Mission.WarningTime = 15
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 600 and not Mission.SecondWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 10 minutes warining")
		Mission.SecondWarningDone = true
		Mission.WarningTime = 10
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 300 and not Mission.ThirdWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 5 minutes warining")
		Mission.ThirdWarningDone = true
		Mission.WarningTime = 5
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 60 and not Mission.FourthWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 1 minutes warining")
		Mission.FourthWarningDone = true
		Mission.WarningTime = 1
		luaWarningNarrative()
	end
end

function luaWarningNarrative()
	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][2] = Mission.WarningTime
	end
	MissionNarrativePlayer(0, "mp01.nar_comp_timer_warning_0")
	MissionNarrativePlayer(1, "mp01.nar_comp_timer_warning_1")
	MissionNarrativePlayer(2, "mp01.nar_comp_timer_warning_2")
	MissionNarrativePlayer(3, "mp01.nar_comp_timer_warning_3")
	MissionNarrativePlayer(4, "mp01.nar_comp_timer_warning_4")
	MissionNarrativePlayer(5, "mp01.nar_comp_timer_warning_5")
	MissionNarrativePlayer(6, "mp01.nar_comp_timer_warning_6")
	MissionNarrativePlayer(7, "mp01.nar_comp_timer_warning_7")
end
]]
function luaQAC2MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
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
	luaDelay(luaQAC2MissionEnd, 0.1)
end

function luaQAC2CheckHighestScore()
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

function luaQAC2MissionEnd()
-- RELEASE_LOGOFF  	luaLog("  MissionEnd called...")
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
		local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		if Mission.MissionFailed then
			luaObj_Failed("primary", 9)
		else
			luaObj_Completed("primary", 9)
		end

		luaQAC2DelayedMissionComplete()
		--luaDelay(luaQAC2DelayedMissionComplete, 1.5)
	end
end

function luaQAC2DelayedMissionComplete()
	local playerships = luaGetShipsAroundCoordinate(GetPosition(Mission.HQ), 20000, PARTY_ALLIED, "own")
	Mission.EndShip = nil
	if playerships ~= nil then
		local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
		for index, unit in pairs (playerships) do
			local ownerID = GetRoleAvailable(unit)[1]
			if ownerID == highestindex then
				Mission.EndShip = unit
			end
		end
	end

	Scoring_RealPlayTimeRunning(false)
	if Mission.MissionFailed then
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	else
		if Mission.EndShip ~= nil then
			luaMissionCompletedNew(Mission.EndShip, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.EndShip == nil and playerships ~= nil then
			Mission.EndShip = luaPickRnd(playerships)
			luaMissionCompletedNew(Mission.EndShip, "", nil, nil, nil, PARTY_ALLIED)
		else
			luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive02")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
	--[[
				local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
				for i = 0, 7 do
					MultiScore[i][2] = highestplayerscore
				end
	]]
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC2CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC2CheckListeners()
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
		Mission.AttackerShips = luaRemoveDeadsFromTable(Mission.AttackerShips)
		Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
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
				AISetHintWeight(Mission.RandomTarget, 50)
				luaQAC2RandomTargetKillListener(Mission.RandomTarget)
			end
		end
	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then
		Mission.ReminderTimer = GameTime() + 22
		if not Mission.RandomTarget.Dead then
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
		else
-- RELEASE_LOGOFF  			luaLog("  ERROR!!! Mission.ListenerActive was wrong")
			Mission.ListenerActive = false
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
		end
	end
end

function luaQAC2RandomTargetKillListener(target)
	if target ~= nil then
-- RELEASE_LOGOFF  		luaLog(" LISTENER: Activating kill listener on "..target.Name)
		AddListener("kill", "TargetKill", {
			["callback"] = "luaQAC2TargetKill",
			["entity"] = {target},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.ListenerActive = true
	else
-- RELEASE_LOGOFF  		luaLog(" LISTENER: listener activation failed, got nil for target")
	end
end

function luaQAC2TargetKill(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" luaQAC2TargetKill")
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
				local y = i - 1
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
--[[
function luaQAC2RemoveListener()
-- RELEASE_LOGOFF  	luaLog(" FAIL!!!")
	RemoveListener("kill", "TargetKill")
	Mission.ListenerActive = false
	--MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_denied")
	if not Mission.RandomTarget.Dead then
		for i = 1, 8 do
			luaObj_RemoveUnit("primary", i, Mission.RandomTarget)
		end
	end
	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end
]]
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

function luaQAC2SubKill(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" luaQAC2SubKill")
-- RELEASE_LOGOFF  	luaLog(target)
-- RELEASE_LOGOFF  	luaLog(lastAttacker)
-- RELEASE_LOGOFF  	luaLog(lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  		luaLog(" LISTENER: sub killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScoreSub)
			for i = 1, 8 do
				local y = i - 1
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp02.nar_comp_subkill")
				else
					MissionNarrativePlayer(y, "mp02.nar_comp_subkill_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  					luaLog(playerwhoscored.playerName)
					Mission.MultiScoreAILevelSub = 33
					for z = 1, 8 do
						local x = z - 1
						if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
							Mission.MultiScoreAILevelSub = 3
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
							Mission.MultiScoreAILevelSub = 4
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
							Mission.MultiScoreAILevelSub = 5
						end
						MultiScore[x][7] = playerwhoscored.playerName
					end
				end
]]
			end
			--luaDelay(luaSubKillNarrative, 2, "ai", Mission.MultiScoreAILevelSub)
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! lastAttackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp02.nar_comp_subkill_fail")
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! lastAttacker")
	end
	if IsListenerActive("kill", "SubKill") then
		RemoveListener("kill", "SubKill")
	end
	Mission.SubListenerInitiated = false
	local subrandomtime = luaRnd(15, 75)
	Mission.NextSubSpawnTime = GameTime() + 100 + subrandomtime
end
--[[
function luaQAC2RemoveListenerSub()
-- RELEASE_LOGOFF  	luaLog(" FAIL!!! removing sub kill listener")
	RemoveListener("kill", "SubKill")
	--MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_denied")
	Mission.SubListenerInitiated = false
end
]]
function luaSubKillNarrative(timerthis)
	if timerthis.ParamTable.ai == 33 then
		MissionNarrativePlayer(0, "mp02.nar_comp_subkill".."| #MultiScore.0.7#")
		MissionNarrativePlayer(1, "mp02.nar_comp_subkill".."| #MultiScore.1.7#")
		MissionNarrativePlayer(2, "mp02.nar_comp_subkill".."| #MultiScore.2.7#")
		MissionNarrativePlayer(3, "mp02.nar_comp_subkill".."| #MultiScore.3.7#")
		MissionNarrativePlayer(4, "mp02.nar_comp_subkill".."| #MultiScore.4.7#")
		MissionNarrativePlayer(5, "mp02.nar_comp_subkill".."| #MultiScore.5.7#")
		MissionNarrativePlayer(6, "mp02.nar_comp_subkill".."| #MultiScore.6.7#")
		MissionNarrativePlayer(7, "mp02.nar_comp_subkill".."| #MultiScore.7.7#")
	elseif timerthis.ParamTable.ai == 3 then
		MissionNarrativeParty(PARTY_ALLIED, "mp02.nar_comp_subkill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_ALLIED, "mp02.nar_comp_subkill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_ALLIED, "mp02.nar_comp_subkill".."| |FE.hard")
	end
end

function luaQAC2HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive02_HQ")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive02_Fleet")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Competitive02_Points")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Competitive02_Bonus")
			Mission.Hint4Shown = true
		elseif GameTime() > 150 and not Mission.Hint5Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint5Shown")
			ShowHint("ID_Hint_Competitive02_Boat")
			Mission.Hint5Shown = true
		elseif GameTime() > 180 and not Mission.Hint6Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint6Shown")
			ShowHint("ID_Hint_Competitive02_Sub")
			Mission.Hint6Shown = true
		elseif GameTime() > 210 and not Mission.Hint7Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint7Shown")
			ShowHint("ID_Hint_Competitive02_Ohka")
			Mission.Hint7Shown = true
		end
	end
end