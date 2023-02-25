--SceneFile="Missions\Multi\Scene11.scn"

function luaPrecacheUnits()
	PrepareClass(58) -- Shimakaze
	PrepareClass(77) -- Japanese PT
	PrepareClass(8) -- I-400
	PrepareClass(163) -- Jill
	PrepareClass(174) -- Mavis
	PrepareClass(45) -- Kamikaze Zero
	PrepareClass(70) -- Kuma
	PrepareClass(60) -- Kongo
	PrepareClass(121) -- Kingfisher
	PrepareClass(11) -- Allen M. Sumner
	PrepareClass(48) -- ASW Fletcher
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC11Mission")
end

function luaInitQAC11Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp7"..dateandtime

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

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
	Mission.MultiplayerNumber = 11
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission tablak, valtozok
	Mission.US = {}
	Mission.Jap = {}
	Mission.Jap.ActualSP = 0
	Mission.Jap.SpawnAllowed = {}
	Mission.Jap.SpawnAllowed.Ship1 = false
	Mission.Jap.SpawnAllowed.Ship2 = false
	Mission.Jap.SpawnAllowed.Plane1 = false
	Mission.Jap.SpawnAllowed.Plane2 = false
	Mission.Jap.SpawnAllowed.PlaneDelay = 20
	Mission.Jap.SpawnAllowed.ShipDelay = 40
	Mission.Jap.SpawnAllowed.BB = true
	Mission.Jap.SpawnAllowed.Sub = true
	Mission.Jap.SpawnAllowed.BBGroupNo = 0
	Mission.Jap.SpawnAllowed.SubGroupNo = 0
	Mission.Jap.UnitLimits = {}
	Mission.Jap.AttackerPlanes = {}
	Mission.Jap.AttackerShips = {}
	Mission.Jap.AttackerPlanes.Group1 = {}
	Mission.Jap.AttackerPlanes.Group2 = {}
	Mission.Jap.AttackerShips.Group1 = {}
	Mission.Jap.AttackerShips.Group2 = {}
	Mission.Jap.TableToPutIn = {}
	Mission.Jap.TableToPutIn.Plane = 0
	Mission.Jap.TableToPutIn.Ship = 0

	-- spawn pontok
	Mission.US.YorkPoint = FindEntity("Comp - YorkPoint")
	Mission.US.SpawnPoints = {}
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 1"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 2"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 3"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 4"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 5"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 6"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 7"))
		table.insert(Mission.US.SpawnPoints, FindEntity("Comp - SP 8"))

	Mission.US.SlotIDTable = {}
		table.insert(Mission.US.SlotIDTable, 0)
		table.insert(Mission.US.SlotIDTable, 1)
		table.insert(Mission.US.SlotIDTable, 2)
		table.insert(Mission.US.SlotIDTable, 3)
		table.insert(Mission.US.SlotIDTable, 4)
		table.insert(Mission.US.SlotIDTable, 5)
		table.insert(Mission.US.SlotIDTable, 6)
		table.insert(Mission.US.SlotIDTable, 7)

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")
	for index, entity in pairs (Mission.US.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.US.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
				DeactivateSpawnpoint(Mission.US.YorkPoint, value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- amerikai objektumok
	Mission.US.Carriers = {}
		table.insert(Mission.US.Carriers, FindEntity("Comp - Lexington"))
		table.insert(Mission.US.Carriers, FindEntity("Comp - Yorktown"))
	Mission.US.Cruisers = {}
		table.insert(Mission.US.Cruisers, FindEntity("Comp - DeRuyter"))
		table.insert(Mission.US.Cruisers, FindEntity("Comp - York"))

	Mission.EndUnit = luaFindHidden("Comp - EndUnit")

	Mission.US.UnitType = {}
	Mission.US.UnitName = {}
	Mission.US.UnitType.PT = 121
	Mission.US.UnitName.PT = "globals.unitclass_kingfisher"

	-- japan objektumok
	Mission.Jap.UnitType = {}
	Mission.Jap.UnitName = {}
	Mission.Jap.UnitType.DD = 58
	Mission.Jap.UnitName.DD = "globals.unitclass_shimakaze"
	Mission.Jap.UnitType.PT = 77
	Mission.Jap.UnitName.PT = "globals.unitclass_japanesept"
	Mission.Jap.UnitType.Sub = 8
	Mission.Jap.UnitName.Sub = "globals.unitclass_i400"
	Mission.Jap.UnitType.TB = 163
	Mission.Jap.UnitName.TB = "globals.unitclass_jill"
	Mission.Jap.UnitType.LRP = 174
	Mission.Jap.UnitName.LRP = "globals.unitclass_mavis"
	Mission.Jap.UnitType.Kamikaze = 45
	Mission.Jap.UnitName.Kamikaze = "globals.unitclass_kamikazezero"
	Mission.Jap.UnitType.CL = 70
	Mission.Jap.UnitName.CL = "globals.unitclass_kuma"
	Mission.Jap.UnitType.BB = 60
	Mission.Jap.UnitName.BB = "globals.unitclass_kongo"

	Mission.Jap.UnitTemplate = {}
	Mission.Jap.UnitTemplate.DD = {["Type"] = Mission.Jap.UnitType.DD, ["Name"] = Mission.Jap.UnitName.DD, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.PT = {["Type"] = Mission.Jap.UnitType.PT, ["Name"] = Mission.Jap.UnitName.PT, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.Sub = {["Type"] = Mission.Jap.UnitType.Sub, ["Name"] = Mission.Jap.UnitName.Sub, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.TB = {["Type"] = Mission.Jap.UnitType.TB, ["Name"] = Mission.Jap.UnitName.TB, ["Crew"] = 1, ["Race"] = JAPANESE, ["WingCount"] = 3, ["Equipment"] = 1, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.LRP = {["Type"] = Mission.Jap.UnitType.LRP, ["Name"] = Mission.Jap.UnitName.LRP, ["Crew"] = 1, ["Race"] = JAPANESE, ["WingCount"] = 1, ["Equipment"] = 1, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.Kamikaze = {["Type"] = Mission.Jap.UnitType.Kamikaze, ["Name"] = Mission.Jap.UnitName.Kamikaze, ["Crew"] = 1, ["Race"] = JAPANESE, ["WingCount"] = 3, ["Equipment"] = 0, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.CL = {["Type"] = Mission.Jap.UnitType.CL, ["Name"] = Mission.Jap.UnitName.CL, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.Jap.UnitTemplate.BB = {["Type"] = Mission.Jap.UnitType.BB, ["Name"] = Mission.Jap.UnitName.BB, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,}

	-- utvonalak, navpontok

	Mission.US.CarrierPath = FindEntity("Comp - US Path")
	Mission.Jap.EntryPoints = {}
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 1")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 2")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 3")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 4")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 5")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 6")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 7")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 8")))
		table.insert(Mission.Jap.EntryPoints, GetPosition(FindEntity("Comp - JapEnrtyPoint 9")))

	Mission.US.Listener = {}
	Mission.US.Listener.Ranges = {}
	Mission.US.Listener.KillScore = {}
	Mission.US.Listener.Ranges.Ship = 8000
	Mission.US.Listener.Ranges.Plane = 8000
	Mission.US.Listener.KillScore.Ship = 175
	Mission.US.Listener.KillScore.Plane = 100

	-- jatekosok
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS START --")
	Mission.Players = 0
	local players = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog(players)
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS END --")
	for index, value in pairs (players) do
		if index == 0 then
			Mission.Player1 = true
		elseif index == 1 then
			Mission.Player2 = true
		elseif index == 2 then
			Mission.Player3 = true
		elseif index == 3 then
			Mission.Player4 = true
		elseif index == 4 then
			Mission.Player5 = true
		elseif index == 5 then
			Mission.Player6 = true
		elseif index == 6 then
			Mission.Player7 = true
		elseif index == 7 then
			Mission.Player8 = true
		end
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	if Mission.Players <= 2 then
		Mission.Jap.UnitTemplate.DDMin = 2
		Mission.Jap.UnitTemplate.DDMax = 3
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 4
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 1
		Mission.Jap.UnitTemplate.TBMin = 2
		Mission.Jap.UnitTemplate.TBMax = 3
		Mission.Jap.UnitTemplate.LRPMin = 1
		Mission.Jap.UnitTemplate.LRPMax = 2
		Mission.Jap.UnitTemplate.KamikazeMin = 2
		Mission.Jap.UnitTemplate.KamikazeMax = 3
		Mission.Jap.UnitTemplate.CLMin = 1
		Mission.Jap.UnitTemplate.CLMax = 2
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 1
	elseif Mission.Players == 3 then
		Mission.Jap.UnitTemplate.DDMin = 2
		Mission.Jap.UnitTemplate.DDMax = 3
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 4
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 1
		Mission.Jap.UnitTemplate.TBMin = 2
		Mission.Jap.UnitTemplate.TBMax = 3
		Mission.Jap.UnitTemplate.LRPMin = 2
		Mission.Jap.UnitTemplate.LRPMax = 3
		Mission.Jap.UnitTemplate.KamikazeMin = 2
		Mission.Jap.UnitTemplate.KamikazeMax = 3
		Mission.Jap.UnitTemplate.CLMin = 1
		Mission.Jap.UnitTemplate.CLMax = 2
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 1
	elseif Mission.Players == 4 then
		Mission.Jap.UnitTemplate.DDMin = 2
		Mission.Jap.UnitTemplate.DDMax = 4
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 4
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 1
		Mission.Jap.UnitTemplate.TBMin = 3
		Mission.Jap.UnitTemplate.TBMax = 4
		Mission.Jap.UnitTemplate.LRPMin = 2
		Mission.Jap.UnitTemplate.LRPMax = 3
		Mission.Jap.UnitTemplate.KamikazeMin = 3
		Mission.Jap.UnitTemplate.KamikazeMax = 4
		Mission.Jap.UnitTemplate.CLMin = 1
		Mission.Jap.UnitTemplate.CLMax = 3
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 1
	elseif Mission.Players == 5 then
		Mission.Jap.UnitTemplate.DDMin = 2
		Mission.Jap.UnitTemplate.DDMax = 4
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 4
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 2
		Mission.Jap.UnitTemplate.TBMin = 3
		Mission.Jap.UnitTemplate.TBMax = 4
		Mission.Jap.UnitTemplate.LRPMin = 3
		Mission.Jap.UnitTemplate.LRPMax = 4
		Mission.Jap.UnitTemplate.KamikazeMin = 3
		Mission.Jap.UnitTemplate.KamikazeMax = 4
		Mission.Jap.UnitTemplate.CLMin = 2
		Mission.Jap.UnitTemplate.CLMax = 3
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 1
	elseif Mission.Players == 6 then
		Mission.Jap.UnitTemplate.DDMin = 3
		Mission.Jap.UnitTemplate.DDMax = 4
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 5
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 2
		Mission.Jap.UnitTemplate.TBMin = 3
		Mission.Jap.UnitTemplate.TBMax = 5
		Mission.Jap.UnitTemplate.LRPMin = 3
		Mission.Jap.UnitTemplate.LRPMax = 5
		Mission.Jap.UnitTemplate.KamikazeMin = 3
		Mission.Jap.UnitTemplate.KamikazeMax = 5
		Mission.Jap.UnitTemplate.CLMin = 3
		Mission.Jap.UnitTemplate.CLMax = 3
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 1
	elseif Mission.Players == 7 then
		Mission.Jap.UnitTemplate.DDMin = 3
		Mission.Jap.UnitTemplate.DDMax = 5
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 5
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 2
		Mission.Jap.UnitTemplate.TBMin = 4
		Mission.Jap.UnitTemplate.TBMax = 5
		Mission.Jap.UnitTemplate.LRPMin = 3
		Mission.Jap.UnitTemplate.LRPMax = 5
		Mission.Jap.UnitTemplate.KamikazeMin = 4
		Mission.Jap.UnitTemplate.KamikazeMax = 5
		Mission.Jap.UnitTemplate.CLMin = 3
		Mission.Jap.UnitTemplate.CLMax = 4
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 2
	elseif Mission.Players == 8 then
		Mission.Jap.UnitTemplate.DDMin = 3
		Mission.Jap.UnitTemplate.DDMax = 5
		Mission.Jap.UnitTemplate.PTMin = 3
		Mission.Jap.UnitTemplate.PTMax = 5
		Mission.Jap.UnitTemplate.SubMin = 1
		Mission.Jap.UnitTemplate.SubMax = 2
		Mission.Jap.UnitTemplate.TBMin = 4
		Mission.Jap.UnitTemplate.TBMax = 5
		Mission.Jap.UnitTemplate.LRPMin = 4
		Mission.Jap.UnitTemplate.LRPMax = 5
		Mission.Jap.UnitTemplate.KamikazeMin = 4
		Mission.Jap.UnitTemplate.KamikazeMax = 5
		Mission.Jap.UnitTemplate.CLMin = 3
		Mission.Jap.UnitTemplate.CLMax = 4
		Mission.Jap.UnitTemplate.BBMin = 1
		Mission.Jap.UnitTemplate.BBMax = 2
	end

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
				["Text"] = "mp11.obj_comp_p2_text",
				["TextCompleted"] = "mp11.obj_comp_p2_comp",
				["TextFailed"] = "mp11.obj_comp_p2_fail",
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
				["Text"] = "mp11.obj_comp_s1_text",
				["TextCompleted"] = "mp11.obj_comp_s1_comp",
				["TextFailed"] = "mp11.obj_comp_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_2",
				["Text"] = "mp11.obj_comp_s2_text",
				["TextCompleted"] = "mp11.obj_comp_s2_comp",
				["TextFailed"] = "mp11.obj_comp_s2_fail",
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

	luaInitNewSystems()

    SetThink(this, "luaQAC11Mission_think")
end

function luaQAC11Mission_think(this, msg)
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
		luaQAC11CheckUSForces()
		luaQAC11CheckMissionEnd()
		luaQAC11HintManager()
		luaQAC11CheckJapForces()

	elseif not Mission.Started then
		luaQAC11StartMission()
		luaUpdateCounters()
	end
end

function luaQAC11StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	luaObj_Add("primary", 9)
	luaObj_AddUnit("primary", 9, Mission.US.Carriers[1])
	luaObj_Add("secondary", 1)
	luaObj_AddUnit("secondary", 1, Mission.US.Carriers[2])
	luaObj_Add("secondary", 2)
	for index, unit in pairs (Mission.US.Cruisers) do
		luaObj_AddUnit("secondary", 2, unit)
	end

	SetShipMaxSpeed(Mission.US.Carriers[1], GetShipMaxSpeed(Mission.US.Carriers[1])*0.5)
	NavigatorMoveOnPath(Mission.US.Carriers[1], Mission.US.CarrierPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.US.CarrierPath)
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.US.Carriers[1], "LexingtonExit", "luaQAC11LexingtonExit", pathpoints[pathpointsnumber], 800)
	NavigatorSetAvoidLandCollision(Mission.US.Carriers[1], false)
	NavigatorSetAvoidLandCollision(Mission.US.Carriers[2], false)
	SetShipMaxSpeed(Mission.US.Carriers[1], GetShipMaxSpeed(Mission.US.Carriers[1])*1.1)
	SetShipMaxSpeed(Mission.US.Carriers[2], GetShipMaxSpeed(Mission.US.Carriers[2])*1.1)
	SetRepairEffectivity(Mission.US.Carriers[1], 1.35)
	SetSkillLevel(Mission.US.Carriers[1], SKILL_MPNORMAL)
	SetSkillLevel(Mission.US.Carriers[2], SKILL_MPNORMAL)

	for i = 0, 7 do
		DisplayUnitHP(i, {Mission.US.Carriers[1]})
	end

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC11MissionEndTimeIsUp")
	end

	JoinFormation(Mission.US.Carriers[2], Mission.US.Carriers[1])
	for index, unit in pairs (Mission.US.Cruisers) do
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		JoinFormation(unit, Mission.US.Carriers[1])
		SetSkillLevel(unit, SKILL_MPNORMAL)
	end

	Mission.Started = true
	luaDelay(luaQAC11ManageJapSpawnPoints, 2)
end

function luaQAC11LexingtonExit()
-- RELEASE_LOGOFF  	luaLog(" The Lexington has reached the last path point...")
	local PlayersInGame = GetPlayerDetails()
	local highestindex, highestplayerscore = luaQAC11CheckHighestScore()
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
	Mission.LexingtonExited = true
	MissionNarrativeParty(PARTY_ALLIED, "mp11.nar_comp_lexington_exit")
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaQAC11MissionEnd, 0.1)
end

function luaQAC11CheckJapForces()
-- RELEASE_LOGOFF  	luaLog(" Checking Japanese forces...")
	Mission.Jap.AttackerPlanes.Group1 = luaRemoveDeadsFromTable(Mission.Jap.AttackerPlanes.Group1)
	if table.getn(Mission.Jap.AttackerPlanes.Group1) == 0 and Mission.Jap.SpawnAllowed.Plane1 then
		if not Mission.US.Carriers[1].Dead then
			local minno = Mission.Jap.ActualSP - 2
			local maxno = Mission.Jap.ActualSP + 2
			local rndno = 1
			local japentrypoints = table.getn(Mission.Jap.EntryPoints)
			if minno > 0 and maxno <= japentrypoints then
				rndno = luaRnd(minno, maxno)
			elseif minno <= 0 then
				rndno = luaRnd(1, maxno)
			elseif maxno > japentrypoints then
				rndno = luaRnd(minno, japentrypoints)
			end
-- RELEASE_LOGOFF  			luaLog("  AttackerPlanes.Group1 | Mission.Jap.ActualSP: "..tostring(Mission.Jap.ActualSP).."| minno: "..tostring(minno).." | maxno: "..tostring(maxno).." | rndno: "..tostring(rndno))
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local randomplanenumber = 1
			local template = nil
			if randomplanetype == 1 then
				template = Mission.Jap.UnitTemplate.TB
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.TBMin, Mission.Jap.UnitTemplate.TBMax)
			elseif randomplanetype == 2 then
				template = Mission.Jap.UnitTemplate.LRP
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.LRPMin, Mission.Jap.UnitTemplate.LRPMax)
			elseif randomplanetype == 3 then
				template = Mission.Jap.UnitTemplate.Kamikaze
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.KamikazeMin, Mission.Jap.UnitTemplate.KamikazeMax)
			end
			for i = 1, randomplanenumber do
				table.insert(grouptable, template)
			end
			Mission.Jap.TableToPutIn.Plane = 1
			local lookatpos = GetPosition(Mission.US.Carriers[1])
			luaQAC11SpawnPlane(Mission.Jap.EntryPoints[rndno], grouptable, lookatpos)
			Mission.Jap.SpawnAllowed.Plane1 = false
			Mission.Jap.SpawnAllowed.Plane2 = false
			luaDelay(luaQAC11ResetPlaneFlags, Mission.Jap.SpawnAllowed.PlaneDelay)
		end
	else
		for index, unit in pairs (Mission.Jap.AttackerPlanes.Group1) do
			if UnitGetAttackTarget(unit) == nil then
				luaQAC11SetTarget(unit, "plane")
			end
		end
	end

	Mission.Jap.AttackerPlanes.Group2 = luaRemoveDeadsFromTable(Mission.Jap.AttackerPlanes.Group2)
	if table.getn(Mission.Jap.AttackerPlanes.Group2) == 0 and Mission.Jap.SpawnAllowed.Plane2 then
		if not Mission.US.Carriers[1].Dead then
			local minno = Mission.Jap.ActualSP - 2
			local maxno = Mission.Jap.ActualSP + 2
			local rndno = 1
			local japentrypoints = table.getn(Mission.Jap.EntryPoints)
			if minno > 0 and maxno <= japentrypoints then
				rndno = luaRnd(minno, maxno)
			elseif minno <= 0 then
				rndno = luaRnd(1, maxno)
			elseif maxno > japentrypoints then
				rndno = luaRnd(minno, japentrypoints)
			end
-- RELEASE_LOGOFF  			luaLog("  AttackerPlanes.Group2 | Mission.Jap.ActualSP: "..tostring(Mission.Jap.ActualSP).."| minno: "..tostring(minno).." | maxno: "..tostring(maxno).." | rndno: "..tostring(rndno))
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local randomplanenumber = 1
			local template = nil
			if randomplanetype == 1 then
				template = Mission.Jap.UnitTemplate.TB
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.TBMin, Mission.Jap.UnitTemplate.TBMax)
			elseif randomplanetype == 2 then
				template = Mission.Jap.UnitTemplate.LRP
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.LRPMin, Mission.Jap.UnitTemplate.LRPMax)
			elseif randomplanetype == 3 then
				template = Mission.Jap.UnitTemplate.Kamikaze
				randomplanenumber = luaRnd(Mission.Jap.UnitTemplate.KamikazeMin, Mission.Jap.UnitTemplate.KamikazeMax)
			end
			for i = 1, randomplanenumber do
				table.insert(grouptable, template)
			end
			Mission.Jap.TableToPutIn.Plane = 2
			local lookatpos = GetPosition(Mission.US.Carriers[1])
			luaQAC11SpawnPlane(Mission.Jap.EntryPoints[rndno], grouptable, lookatpos)
			Mission.Jap.SpawnAllowed.Plane1 = false
			Mission.Jap.SpawnAllowed.Plane2 = false
			luaDelay(luaQAC11ResetPlaneFlags, Mission.Jap.SpawnAllowed.PlaneDelay)
		end
	else
		for index, unit in pairs (Mission.Jap.AttackerPlanes.Group2) do
			if UnitGetAttackTarget(unit) == nil then
				luaQAC11SetTarget(unit, "plane")
			end
		end
	end

	Mission.Jap.AttackerShips.Group1 = luaRemoveDeadsFromTable(Mission.Jap.AttackerShips.Group1)
	if table.getn(Mission.Jap.AttackerShips.Group1) == 0 and Mission.Jap.SpawnAllowed.Ship1 then
		if Mission.Jap.SpawnAllowed.SubGroupNo == 1 and not Mission.Jap.SpawnAllowed.Sub then
			Mission.Jap.SpawnAllowed.Sub = true
		end
		if Mission.Jap.SpawnAllowed.BBGroupNo == 1 and not Mission.Jap.SpawnAllowed.BB then
			Mission.Jap.SpawnAllowed.BB = true
		end

		if not Mission.US.Carriers[1].Dead then
			local minno = Mission.Jap.ActualSP - 1
			local maxno = Mission.Jap.ActualSP + 1
			local rndno = 1
			local japentrypoints = table.getn(Mission.Jap.EntryPoints)
			if minno > 4 and maxno <= japentrypoints then
				rndno = luaRnd(minno, maxno)
			elseif minno <= 4 then
				rndno = 5
			elseif maxno > japentrypoints then
				rndno = luaRnd(minno, japentrypoints)
			end
-- RELEASE_LOGOFF  			luaLog("  AttackerShips.Group1 | Mission.Jap.ActualSP: "..tostring(Mission.Jap.ActualSP).."| minno: "..tostring(minno).." | maxno: "..tostring(maxno).." | rndno: "..tostring(rndno))
			local grouptable = {}
			local randomshiptype = 1
			if Mission.Jap.ActualSP < 6 then
				randomshiptype = luaRnd(1, 4)
			else
				randomshiptype = luaRnd(1, 5)
			end
			local randomshipnumber = 1
			-- egyelore a BB kiszedve
			local template = nil
			if randomshiptype == 1 then
				template = Mission.Jap.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.PTMin, Mission.Jap.UnitTemplate.PTMax)
			elseif randomshiptype == 2 then
				template = Mission.Jap.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.DDMin, Mission.Jap.UnitTemplate.DDMax)
			elseif randomshiptype == 3 and Mission.Jap.SpawnAllowed.Sub then
				template = Mission.Jap.UnitTemplate.Sub
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.SubMin, Mission.Jap.UnitTemplate.SubMax)
				Mission.Jap.SpawnAllowed.Sub = false
				Mission.Jap.SpawnAllowed.SubGroupNo = 1
			elseif randomshiptype == 4 then
				template = Mission.Jap.UnitTemplate.CL
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.CLMin, Mission.Jap.UnitTemplate.CLMax)
			elseif randomshiptype == 5 and Mission.Jap.SpawnAllowed.BB then
				template = Mission.Jap.UnitTemplate.BB
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.BBMin, Mission.Jap.UnitTemplate.BBMax)
				Mission.Jap.SpawnAllowed.BB = false
				Mission.Jap.SpawnAllowed.BBGroupNo = 1
			else
				template = Mission.Jap.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.DDMin, Mission.Jap.UnitTemplate.DDMax)
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			Mission.Jap.TableToPutIn.Ship = 1
			local lookatpos = GetPosition(Mission.US.Carriers[1])
			luaQAC11SpawnShip(Mission.Jap.EntryPoints[rndno], grouptable, lookatpos)
			Mission.Jap.SpawnAllowed.Ship1 = false
			Mission.Jap.SpawnAllowed.Ship2 = false
			luaDelay(luaQAC11ResetShipFlags, Mission.Jap.SpawnAllowed.ShipDelay)
		end
	else
		for index, unit in pairs (Mission.Jap.AttackerShips.Group1) do
			if UnitGetAttackTarget(unit) == nil then
				luaQAC11SetTarget(unit, "ship")
			end
		end
	end

	Mission.Jap.AttackerShips.Group2 = luaRemoveDeadsFromTable(Mission.Jap.AttackerShips.Group2)
	if table.getn(Mission.Jap.AttackerShips.Group2) == 0 and Mission.Jap.SpawnAllowed.Ship2 then
		if Mission.Jap.SpawnAllowed.SubGroupNo == 2 and not Mission.Jap.SpawnAllowed.Sub then
			Mission.Jap.SpawnAllowed.Sub = true
		end
		if Mission.Jap.SpawnAllowed.BBGroupNo == 2 and not Mission.Jap.SpawnAllowed.BB then
			Mission.Jap.SpawnAllowed.BB = true
		end
		
		if not Mission.US.Carriers[1].Dead then
			local minno = Mission.Jap.ActualSP - 1
			local maxno = Mission.Jap.ActualSP + 1
			local rndno = 1
			local japentrypoints = table.getn(Mission.Jap.EntryPoints)
			if minno > 4 and maxno <= japentrypoints then
				rndno = luaRnd(minno, maxno)
			elseif minno <= 4 then
				rndno = 5
			elseif maxno > japentrypoints then
				rndno = luaRnd(minno, japentrypoints)
			end
-- RELEASE_LOGOFF  			luaLog("  AttackerShips.Group2 | Mission.Jap.ActualSP: "..tostring(Mission.Jap.ActualSP).."| minno: "..tostring(minno).." | maxno: "..tostring(maxno).." | rndno: "..tostring(rndno))
			local grouptable = {}
			local randomshiptype = 1
			if Mission.Jap.ActualSP < 6 then
				randomshiptype = luaRnd(1, 4)
			else
				randomshiptype = luaRnd(1, 5)
			end
			local randomshipnumber = 1
			-- egyelore a BB kiszedve
			local template = nil
			if randomshiptype == 1 then
				template = Mission.Jap.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.PTMin, Mission.Jap.UnitTemplate.PTMax)
			elseif randomshiptype == 2 then
				template = Mission.Jap.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.DDMin, Mission.Jap.UnitTemplate.DDMax)
			elseif randomshiptype == 3 and Mission.Jap.SpawnAllowed.Sub then
				template = Mission.Jap.UnitTemplate.Sub
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.SubMin, Mission.Jap.UnitTemplate.SubMax)
				Mission.Jap.SpawnAllowed.Sub = false
				Mission.Jap.SpawnAllowed.SubGroupNo = 2
			elseif randomshiptype == 4 then
				template = Mission.Jap.UnitTemplate.CL
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.CLMin, Mission.Jap.UnitTemplate.CLMax)
			elseif randomshiptype == 5 and Mission.Jap.SpawnAllowed.BB then
				template = Mission.Jap.UnitTemplate.BB
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.BBMin, Mission.Jap.UnitTemplate.BBMax)
				Mission.Jap.SpawnAllowed.BB = false
				Mission.Jap.SpawnAllowed.BBGroupNo = 2
			else
				template = Mission.Jap.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.Jap.UnitTemplate.DDMin, Mission.Jap.UnitTemplate.DDMax)
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			Mission.Jap.TableToPutIn.Ship = 2
			local lookatpos = GetPosition(Mission.US.Carriers[1])
			luaQAC11SpawnShip(Mission.Jap.EntryPoints[rndno], grouptable, lookatpos)
			Mission.Jap.SpawnAllowed.Ship1 = false
			Mission.Jap.SpawnAllowed.Ship2 = false
			luaDelay(luaQAC11ResetShipFlags, Mission.Jap.SpawnAllowed.ShipDelay)
		end
	else
		for index, unit in pairs (Mission.Jap.AttackerShips.Group2) do
			if UnitGetAttackTarget(unit) == nil then
				luaQAC11SetTarget(unit, "ship")
			end
		end
	end
end

function luaQAC11ResetPlaneFlags()
-- RELEASE_LOGOFF  	luaLog(" Resetting plane flags...")
	Mission.Jap.SpawnAllowed.Plane1 = true
	Mission.Jap.SpawnAllowed.Plane2 = true
end

function luaQAC11ResetShipFlags()
-- RELEASE_LOGOFF  	luaLog(" Resetting plane flags...")
	Mission.Jap.SpawnAllowed.Ship1 = true
	Mission.Jap.SpawnAllowed.Ship2 = true
end

function luaQAC11SetTarget(unit, unittype)
	local attacktarget = nil
	if Mission.US.Cruisers[2] ~= nil then
		if not Mission.US.Cruisers[2].Dead then
			attacktarget = Mission.US.Cruisers[2]
		end
	elseif Mission.US.Cruisers[1] ~= nil then
		if not Mission.US.Cruisers[1].Dead then
			attacktarget = Mission.US.Cruisers[1]
		end
	elseif not Mission.US.Carriers[2].Dead then
		attacktarget = Mission.US.Carriers[2]
	elseif not Mission.US.Carriers[1].Dead then
		attacktarget = Mission.US.Carriers[1]
	end
	
	if unittype == "plane" and attacktarget ~= nil then
		SquadronSetTravelAlt(unit, 175)
		PilotSetTarget(unit, attacktarget)
		if not unit.Class.Type == "TorpedoBomber" then
			SquadronSetAttackAlt(unit, 175)
		end
	elseif unittype == "ship" and attacktarget ~= nil then
		--luaLog(unit)
		--luaLog(attacktarget)
		NavigatorAttackMove(unit, attacktarget, {})
	end
end

function luaQAC11ManageJapSpawnPoints()
-- RELEASE_LOGOFF  	luaLog(" Checking actual Japanese spawn point...")
	if Mission.Jap.ActualSP == 0 then
		Mission.Jap.SpawnAllowed.Plane1 = true
		Mission.Jap.SpawnAllowed.Plane2 = true
	elseif Mission.Jap.ActualSP == 1 then
		Mission.Jap.SpawnAllowed.Ship1 = true
		Mission.Jap.SpawnAllowed.Ship2 = true
	end

	Mission.Jap.ActualSP = Mission.Jap.ActualSP + 1
-- RELEASE_LOGOFF  	luaLog("  ActualSP set to "..tostring(Mission.Jap.ActualSP))
	if Mission.Jap.ActualSP < table.getn(Mission.Jap.EntryPoints) then
		local randomSPcheck = luaRnd(140, 190)
		luaDelay(luaQAC11ManageJapSpawnPoints, randomSPcheck)
	end
end

function luaQAC11CheckUSForces()
-- RELEASE_LOGOFF  	luaLog(" Checking US forces...")
	Mission.US.Cruisers = luaRemoveDeadsFromTable(Mission.US.Cruisers)
	if table.getn(Mission.US.Cruisers) == 0 and luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
		luaObj_Failed("secondary", 2)
	end

	if Mission.US.Carriers[2].Dead and luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
		luaObj_Failed("secondary", 1)
	end
		
	if Mission.US.Carriers[1].Dead and luaObj_IsActive("primary", 9) and luaObj_GetSuccess("primary", 9) == nil then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		luaObj_Failed("primary", 9)
		ForceMultiScoreSend()
		luaQAC11MissionEnd()
	end
end

function luaQAC11SpawnPlane(position, grouptable, lookat)
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = grouptable,
		["area"] = {
			["refPos"] = position,
			["angleRange"] = { 1, -1 },
			["lookAt"] = lookat,
		},
		["callback"] = "luaQAC11PlaneSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 133,
			["enemyHorizontal"] = 133,
			["ownVertical"] = 133,
			["formationHorizontal"] = 133,
			["enemyVertical"] = 133,
			["enemyHorizontal"] = 133,
		},
	})
end

function luaQAC11SpawnShip(position, grouptable, lookat)
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] =  grouptable,
		["area"] = {
			["refPos"] = position,
			["angleRange"] = { 1, -1 },
			["lookAt"] = lookat,
		},
		["callback"] = "luaQAC11ShipSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 100,
			["enemyHorizontal"] = 100,
			["ownVertical"] = 100,
			["formationHorizontal"] = 100,
			["enemyVertical"] = 100,
			["enemyHorizontal"] = 100,
		},
	})
end

function luaQAC11PlaneSpawned(unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8)
	if Mission.Jap.TableToPutIn.Plane == 1 then
		if unit1 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit1)
		end
		if unit2 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit2)
		end
		if unit3 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit3)
		end
		if unit4 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit4)
		end
		if unit5 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit5)
		end
		if unit6 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit6)
		end
		if unit7 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit7)
		end
		if unit8 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group1, unit8)
		end
		for index, unit in pairs (Mission.Jap.AttackerPlanes.Group1) do
			luaQAC11SetTarget(unit, "plane")
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	elseif Mission.Jap.TableToPutIn.Plane == 2 then
		if unit1 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit1)
		end
		if unit2 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit2)
		end
		if unit3 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit3)
		end
		if unit4 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit4)
		end
		if unit5 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit5)
		end
		if unit6 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit6)
		end
		if unit7 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit7)
		end
		if unit8 ~= nil then
			table.insert(Mission.Jap.AttackerPlanes.Group2, unit8)
		end
		for index, unit in pairs (Mission.Jap.AttackerPlanes.Group2) do
			luaQAC11SetTarget(unit, "plane")
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	end
end

function luaQAC11ShipSpawned(unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8)
	if Mission.Jap.TableToPutIn.Ship == 1 then
		if unit1 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit1)
		end
		if unit2 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit2)
		end
		if unit3 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit3)
		end
		if unit4 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit4)
		end
		if unit5 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit5)
		end
		if unit6 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit6)
		end
		if unit7 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit7)
		end
		if unit8 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group1, unit8)
		end
		for index, unit in pairs (Mission.Jap.AttackerShips.Group1) do
			NavigatorSetTorpedoEvasion(unit, false)
			SetSkillLevel(unit, SKILL_SPNORMAL)
			luaQAC11SetTarget(unit, "ship")
		end
	elseif Mission.Jap.TableToPutIn.Ship == 2 then
		if unit1 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit1)
		end
		if unit2 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit2)
		end
		if unit3 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit3)
		end
		if unit4 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit4)
		end
		if unit5 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit5)
		end
		if unit6 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit6)
		end
		if unit7 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit7)
		end
		if unit8 ~= nil then
			table.insert(Mission.Jap.AttackerShips.Group2, unit8)
		end
		for index, unit in pairs (Mission.Jap.AttackerShips.Group2) do
			NavigatorSetTorpedoEvasion(unit, false)
			SetSkillLevel(unit, SKILL_SPNORMAL)
			luaQAC11SetTarget(unit, "ship")
		end
	end
end

function luaQAC11CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC11CheckHighestScore()
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
			luaDelay(luaQAC11MissionEnd, 0.1)
		end
	end
end

function luaQAC11CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC11MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC11CheckHighestScore()
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
	ForceMultiScoreSend()
	luaDelay(luaQAC11MissionEnd, 0.1)
end

function luaQAC11MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
		if Mission.US.Carriers[1].Dead and luaObj_IsActive("primary", 9) and luaObj_GetSuccess("primary", 9) == nil then
			Mission.MissionLost = true
			luaObj_Failed("primary", 9)
		else
			luaObj_Completed("primary", 9)
		end

		Mission.US.Cruisers = luaRemoveDeadsFromTable(Mission.US.Cruisers)
		if table.getn(Mission.US.Cruisers) == 0 and luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
			luaObj_Failed("secondary", 2)
		else
			luaObj_Completed("secondary", 2)
		end

		if Mission.US.Carriers[2].Dead and luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			luaObj_Failed("secondary", 1)
		else
			luaObj_Completed("secondary", 1)
		end

		local highestindex, highestplayerscore = luaQAC11CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		luaQAC11DelayedMissionComplete()
	end
end

function luaQAC11DelayedMissionComplete()
	if not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.MissionLost then
			if not TrulyDead(Mission.US.Carriers[1]) then
				luaMissionCompletedNew(Mission.US.Carriers[1], "", nil, nil, nil, PARTY_ALLIED)
			else
				local japaneseunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
				local alliedunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
				if japaneseunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(japaneseunits), "", nil, nil, nil, PARTY_JAPANESE)
				elseif alliedunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(alliedunits), "", nil, nil, nil, PARTY_JAPANESE)
				else
					local endunit = GenerateObject(Mission.EndUnit.Name)
					luaMissionCompletedNew(endunit, "", nil, nil, nil, PARTY_JAPANESE)
				end
			end
		else
			luaMissionCompletedNew(Mission.US.Carriers[1], "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive11")
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC11CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC11HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")

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
		local possibleshiptargets = luaGetShipsAround(Mission.US.Carriers[1], Mission.US.Listener.Ranges.Ship, "enemy")
		local possibleplanetargets = luaGetPlanesAround(Mission.US.Carriers[1], Mission.US.Listener.Ranges.Plane, "enemy")
		if possibleshiptargets ~= nil and possibleplanetargets ~= nil then
			Mission.RandomListener = luaRnd(1, 2)
			if Mission.RandomListener == 1 then
				Mission.RandomTarget = luaPickRnd(possibleshiptargets)
			elseif Mission.RandomListener == 2 then
				Mission.RandomTarget = luaPickRnd(possibleplanetargets)
			end
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.RandomTarget)
			end
--[[
			if Mission.RandomListener ~= 2 then
				AISetHintWeight(Mission.RandomTarget, 100)
			end
]]
			luaQACRandomTargetKillListener(Mission.RandomTarget)
		elseif possibleshiptargets ~= nil then
			Mission.RandomListener = 1
			Mission.RandomTarget = luaPickRnd(possibleshiptargets)
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.RandomTarget)
			end
--[[
			if Mission.RandomListener ~= 2 then
				AISetHintWeight(Mission.RandomTarget, 100)
			end
]]
			luaQACRandomTargetKillListener(Mission.RandomTarget)
		elseif possibleplanetargets ~= nil then
			Mission.RandomListener = 2
			Mission.RandomTarget = luaPickRnd(possibleplanetargets)
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.RandomTarget)
			end
--[[
			if Mission.RandomListener ~= 2 then
				AISetHintWeight(Mission.RandomTarget, 100)
			end
]]
			luaQACRandomTargetKillListener(Mission.RandomTarget)
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
	--luaLog(target)
	--luaLog(lastAttacker)
-- RELEASE_LOGOFF  	luaLog(lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex ~= nil then
			if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
				if Mission.RandomListener == 1 then
					Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.US.Listener.KillScore.Ship)
				elseif Mission.RandomListener == 2 then
					Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.US.Listener.KillScore.Plane)
				end
				for i = 1, 8 do
					--luaLog("i = "..i)
					local y = i - 1
					--luaLog("y = "..y)
-- RELEASE_LOGOFF  					luaLog(" lastAttackerPlayerIndex = "..lastAttackerPlayerIndex)
					if y == lastAttackerPlayerIndex then
						MissionNarrativePlayer(y, "mp01.nar_comp_kill")
					else
						MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
					end
				end
			else
-- RELEASE_LOGOFF  				luaLog(" FAIL!!! lastAttackerPlayerIndex == 8")
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
				end
			end
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! lastAttackerPlayerIndex == nil")
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
