--SceneFile="Missions\Multi\Scene1.scn"

function luaPrecacheUnits()

	if LobbySettings.UnitType == "globals.unitcat_destroyer" then
		PrepareClass(23) -- Fletcher
		PrepareClass(25) -- Clemson
		PrepareClass(73) -- Fubuki
		PrepareClass(75) -- Minekaze
	elseif LobbySettings.UnitType == "globals.unitcat_cruiser" then
		PrepareClass(317) -- Northampton
		PrepareClass(21) -- York
		PrepareClass(67) -- Mogami
		PrepareClass(69) -- Takao
	elseif LobbySettings.UnitType == "globals.unitcat_lightcruiser" then
		PrepareClass(316) -- Cleveland
		PrepareClass(252) -- Brooklyn
		PrepareClass(20) -- De Ruyter
		PrepareClass(70) -- Kuma
		PrepareClass(71) -- Agano
		PrepareClass(274) -- Ishikari
	elseif LobbySettings.UnitType == "globals.unitcat_battleship" then
		PrepareClass(301) -- Hood
		PrepareClass(13) -- New York
		PrepareClass(9)	 --	King George V.
		PrepareClass(7)	 -- South Dakota
		PrepareClass(253)	 -- North Carolina
		PrepareClass(60) -- Kongo
		PrepareClass(61) -- Fuso
		PrepareClass(254) -- Nagato
	elseif LobbySettings.UnitType == "globals.unitcat_torpedoboat" then
		PrepareClass(27) -- Elco
		PrepareClass(77) -- Jap PT
	elseif LobbySettings.UnitType == "globals.unitcat_submarine" then
		PrepareClass(31) -- Narwhal
		PrepareClass(93) -- Type B
	elseif LobbySettings.UnitType == "globals.unitcat_fighter" then
		PrepareClass(101) -- Wildcat
		PrepareClass(133) -- Buffalo
		PrepareClass(26)  -- Hellcat
		PrepareClass(102) -- Corsair	
		PrepareClass(104) -- Ligtning		
		PrepareClass(134) -- Hurricane
		PrepareClass(135) -- Warhawk
		PrepareClass(150) -- Zero
		PrepareClass(152) -- Gekko
		PrepareClass(151) -- Raiden
		PrepareClass(154) -- Oscar
--[[
	elseif Mission.DuelDiveBomber then
		Mission.USEndUnit = luaFindHidden("")
		Mission.JapEndUnit = luaFindHidden("")
	elseif Mission.DuelTorpedoBomber then
		Mission.USEndUnit = luaFindHidden("")
		Mission.JapEndUnit = luaFindHidden("")
]]	
	end
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQADMission")
end

function luaInitQADMission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Duel"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
--	AddLockitPathToSelection("missionglobals")
--	LoadSelectedPaths()

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Duel"

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.AlliedDown = 0
	Mission.JapaneseDown = 0
	Mission.DuelPlanes = true

	Mission.BattleCounter = 1
	Mission.AlliedRoundWon = 0
	Mission.JapaneseRoundWon = 0
	Mission.ManagerCounter = 1
	Mission.BattleGoingOn = false
	Mission.AILevelSet = false

	-- amerikai objektumok
	Mission.Allied = {}
	Mission.AlliedUnits = {}

	-- japan objektumok
	Mission.Japanese = {}
	Mission.JapaneseUnits = {}

	-- spawn pontok
	Mission.SpawnPoints = {}
	-- destroyer 1-8
--	if LobbySettings.UnitType == "globals.unitcat_destroyer" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DD Jap SP 4"))
	-- heavy cruiser 9-16
--	elseif LobbySettings.UnitType == "globals.unitcat_cruiser" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CA Jap SP 4"))
	-- light cruiser 17-24
--	elseif LobbySettings.UnitType == "globals.unitcat_lightcruiser" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - CL Jap SP 4"))
	-- battleship 25-32
--	elseif LobbySettings.UnitType == "globals.unitcat_battleship" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - BB Jap SP 4"))
	-- patrolboat 33-40
--	elseif LobbySettings.UnitType == "globals.unitcat_torpedoboat" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - PT Jap SP 4"))
	-- submarine 41-48
--	elseif LobbySettings.UnitType == "globals.unitcat_submarine" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Sub Jap SP 4"))
	-- fighter 49-56
--	elseif LobbySettings.UnitType == "globals.unitcat_fighter" then
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - Fighter Jap SP 4"))
--	end
--[[
-- ezek nincsenek benne a scene-ben
	-- divebomber 57-64
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - DiveBomber Jap SP 4"))
	-- torpedobomber 65-72
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Duel - TorpedoBomber Jap SP 4"))
]]

	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

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

	if LobbySettings.RoundLimit == "none" then
		Mission.RoundLimit = 0
	elseif LobbySettings.RoundLimit == "1" then
		Mission.RoundLimit = 1
	elseif LobbySettings.RoundLimit == "3" then
		Mission.RoundLimit = 3
	elseif LobbySettings.RoundLimit == "5" then
		Mission.RoundLimit = 5
	elseif LobbySettings.RoundLimit == "7" then
		Mission.RoundLimit = 7
	elseif LobbySettings.RoundLimit == "9" then
		Mission.RoundLimit = 9
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.RoundLimit contains non-handled string | LobbySettings.RoundLimit: "..LobbySettings.RoundLimit)
		Mission.RoundLimit = 0
	end

	if LobbySettings.UnitType == "globals.unitcat_destroyer" then
-- RELEASE_LOGOFF  		luaLog("  destroyer duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 1
--[[
		PrepareClass(23) -- Fletcher
		PrepareClass(25) -- Clemson
		PrepareClass(73) -- Fubuki
		PrepareClass(75) -- minekaze
]]
		Mission.USEndUnit = luaFindHidden("Duel - Fletcher")
		Mission.JapEndUnit = luaFindHidden("Duel - Fubuki")
	elseif LobbySettings.UnitType == "globals.unitcat_cruiser" then
-- RELEASE_LOGOFF  		luaLog("  heavy cruiser duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 9
--[[
		PrepareClass(19) -- Northampton
		PrepareClass(21) -- York
		PrepareClass(67) -- Mogami
		PrepareClass(69) -- Takao
]]
		Mission.USEndUnit = luaFindHidden("Duel - Northampton")
		Mission.JapEndUnit = luaFindHidden("Duel - Mogami")
	elseif LobbySettings.UnitType == "globals.unitcat_lightcruiser" then
-- RELEASE_LOGOFF  		luaLog("  light cruiser duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 17
--[[
		PrepareClass(18) -- Cleveland
		PrepareClass(20) -- De Ruyter
		PrepareClass(70) -- Kuma
		PrepareClass(71) -- Agano
]]
		Mission.USEndUnit = luaFindHidden("Duel - Cleveland")
		Mission.JapEndUnit = luaFindHidden("Duel - Agano")
	elseif LobbySettings.UnitType == "globals.unitcat_battleship" then
-- RELEASE_LOGOFF  		luaLog("  battleship duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 25
--[[
		PrepareClass(10) -- Renown
		PrepareClass(13) -- New York
		PrepareClass(60) -- Kongo
		PrepareClass(61) -- Fuso
]]
		Mission.USEndUnit = luaFindHidden("Duel - NewYork")
		Mission.JapEndUnit = luaFindHidden("Duel - Fuso")
	elseif LobbySettings.UnitType == "globals.unitcat_torpedoboat" then
-- RELEASE_LOGOFF  		luaLog("  patrol boat duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 33
--[[
		PrepareClass(27) -- Elco
		PrepareClass(77) -- Jap PT
]]
		Mission.USEndUnit = luaFindHidden("Duel - ElcoPT")
		Mission.JapEndUnit = luaFindHidden("Duel - JapPT")
	elseif LobbySettings.UnitType == "globals.unitcat_submarine" then
-- RELEASE_LOGOFF  		luaLog("  submarine duel!")
		Mission.DuelShips = true
		Mission.FirstIndex = 41
--[[
		PrepareClass(31) -- Narwhal
		PrepareClass(93) -- Type B
]]
		Mission.USEndUnit = luaFindHidden("Duel - Narwhal")
		Mission.JapEndUnit = luaFindHidden("Duel - TypeB")
	elseif LobbySettings.UnitType == "globals.unitcat_fighter" then
-- RELEASE_LOGOFF  		luaLog("  fighter duel!")
		Mission.DuelPlanes = true
		Mission.FirstIndex = 49
--[[
		PrepareClass(101) -- Wildcat
		PrepareClass(133) -- Buffalo
		PrepareClass(26) -- Hellcat
		PrepareClass(150) -- Zero
		PrepareClass(152) -- Gekko
		PrepareClass(151) -- Raiden
]]
		Mission.USEndUnit = luaFindHidden("Duel - Wildcat")
		Mission.JapEndUnit = luaFindHidden("Duel - Zero")
--[[
	elseif Mission.DuelDiveBomber then
-- RELEASE_LOGOFF  		luaLog("  divebomber duel!")
		Mission.DuelPlanes = true
		Mission.FirstIndex = 57
		Mission.USEndUnit = luaFindHidden("")
		Mission.JapEndUnit = luaFindHidden("")
	elseif Mission.DuelTorpedoBomber then
-- RELEASE_LOGOFF  		luaLog("  torpedo bomber duel!")
		Mission.DuelPlanes = true
		Mission.FirstIndex = 65
		Mission.USEndUnit = luaFindHidden("")
		Mission.JapEndUnit = luaFindHidden("")
]]
	end
--[[
	for idx, sp in pairs(Mission.SpawnPoints) do
		i = 0
		while i == 8 do
			DeactivateSpawnpoint(sp, i)
			i = i + 1
		end
	end
]]

	for idx, sp in pairs(Mission.SpawnPoints) do
		DeactivateSpawnpoint(sp)
	end

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation | first index: "..Mission.FirstIndex.." --")
	for index, entity in pairs (Mission.SpawnPoints) do
		local modifiedID = index - Mission.FirstIndex
		--luaLog(" modifiedID: "..modifiedID)
		for index2, value in pairs (Mission.SlotIDTable) do
			if modifiedID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity)
				ActivateSpawnpoint(entity, value)
			else
				--luaLog(" deactivating SPID "..index.." for slotID "..value)
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- semleges objektumok
	Mission.CenterPoint = {["x"] = 0, ["y"] = 0, ["z"] = 0}

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj",
				["Text"] = "mp.obj_duel_us_text",
				["TextCompleted"] = "mp.obj_duel_us_comp",
				["TextFailed"] = "mp.obj_duel_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj",
				["Text"] = "mp.obj_duel_jap_text",
				["TextCompleted"] = "mp.obj_duel_jap_comp",
				["TextFailed"] = "mp.obj_duel_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	SetRocketAirGroundTypeDifferent(false)

	luaInitNewSystems()

    SetThink(this, "luaQADMission_think")
end

function luaQADMission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	luaQADCheckRounds()

	if Mission.Started and not Mission.RoundLimitReached then
		if Mission.DuelShips then
			luaQADSDeadWatcher()
			luaQADSCheckBattle()
		elseif Mission.DuelPlanes then
			luaQADPDeadWatcher()
			luaQADPCheckBattle()
		end

		luaUpdateCounters()

		if Mission.ResetAllowed then
			Mission.ManagerCounter = 5
			Mission.ResetAllowed = false
			Mission.PCheckAllowed = false
			Mission.SCheckAllowed = false
			Mission.Allied = {}
			Mission.Japanese = {}
			if Mission.DuelShips then
				luaQADSManager()
			elseif Mission.DuelPlanes then
				luaQADPManager()
			end
		end

	elseif not Mission.Started then
		luaQADStartMission()
	end
end

function luaQADStartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	Music_Control_SetLevel(MUSIC_ACTION)

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)

	Mission.OverTimeNarrativeTimer = 0
	
	AISetTargetWeight(488, 10, false, 0) -- Nagato to Renown
	AISetTargetWeight(488, 9, false, 0) -- Nagato to KGV
	AISetTargetWeight(488, 487, false, 0) -- Nagato to North Carolina
	AISetTargetWeight(488, 13, false, 0) -- Nagato to New York
	AISetTargetWeight(488, 15, false, 0) -- Nagato to Iowa
	AISetTargetWeight(488, 389, false, 0) -- Nagato to Montana
	AISetTargetWeight(488, 7, false, 0) -- Nagato to South Dakota
	AISetTargetWeight(488, 466, false, 0) -- Nagato to Colorado
	AISetTargetWeight(488, 467, false, 0) -- Nagato to New Mexico
	AISetTargetWeight(488, 468, false, 0) -- Nagato to Pennsylvania
	AISetTargetWeight(488, 476, false, 0) -- Nagato to QE
	AISetTargetWeight(488, 479, false, 0) -- Nagato to Richelieu
	
	AISetTargetWeight(487, 60, false, 0) -- North Carolina to Kongo
	AISetTargetWeight(487, 61, false, 0) -- North Carolina to Fuso
	AISetTargetWeight(487, 488, false, 0) -- North Carolina to Nagato
	AISetTargetWeight(487, 492, false, 0) -- North Carolina to Bismarck
	AISetTargetWeight(487, 59, false, 0) -- North Carolina to Yamato
	AISetTargetWeight(487, 388, false, 0) -- North Carolina to Super Yamato
	AISetTargetWeight(487, 489, false, 0) -- North Carolina to Yamato 1945
	
	if Mission.DuelShips then
		luaDelay(luaQADSManager, 1)
	elseif Mission.DuelPlanes then
		luaDelay(luaQADPManager, 1)
	end

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.nar_timeleft", 0, Mission.LobbyCountDown, "luaQADMissionEnd")
	end
	Mission.Started = true
end

function luaQADCheckRounds()
	if Mission.RoundLimit ~= 0 then
-- RELEASE_LOGOFF  		luaLog(" Checking round limit counter...")
		if Mission.AlliedRoundWon == Mission.RoundLimit and not Mission.RoundLimitReached or Mission.JapaneseRoundWon == Mission.RoundLimit and not Mission.RoundLimitReached then
		--if Mission.BattleCounter > Mission.RoundLimit and not Mission.RoundLimitReached then
			Mission.RoundLimitReached = true
			CountdownCancel()
			luaQADMissionEnd()
		end
	end
end

function luaQADSManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Manager called...")
		if Mission.ManagerCounter == 1 then
--			MissionNarrativeClear()
			Mission.WarningTime = 15
--			luaWarningNarrative()
			--MissionNarrative("15 seconds left to spawn")
			Mission.ManagerCounter = 2
			luaDelay(luaQADSManager, 5)
		elseif Mission.ManagerCounter == 2 then
			MissionNarrativeClear()
			Mission.WarningTime = 10
			luaWarningNarrative()
			--MissionNarrative("10 seconds left to spawn")
			Mission.ManagerCounter = 3
			luaDelay(luaQADSManager, 5)
		elseif Mission.ManagerCounter == 3 then
			MissionNarrativeClear()
			Mission.WarningTime = 5
			luaWarningNarrative()
			--MissionNarrative("5 seconds left to spawn")
			Mission.ManagerCounter = 4
			luaDelay(luaQADSManager, 5)
		elseif Mission.ManagerCounter == 4 then
			MissionNarrativeClear()
			luaTimeUp()
			--MissionNarrative("Time is up, no more spawns in this round")
			--MissionNarrative("Battle "..Mission.BattleCounter.."!")
			BannSupportmanager()
			luaDelay(luaQADSStoreUnits, 5)
			Mission.BattleGoingOn = true
		elseif Mission.ManagerCounter == 5 then
			Mission.WarningTime = 15
			luaWarningNarrative()
			--MissionNarrative("15 seconds left to spawn")
			Mission.ManagerCounter = 2
			luaDelay(luaQADSManager, 5)
			PermitSupportmanager()
		end
	end
end

function luaWarningNarrative()
	for i = 0, 7 do
		MultiScore[i][4] = Mission.WarningTime
	end
	MissionNarrativePlayer(0, "#MultiScore.0.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(1, "#MultiScore.1.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(2, "#MultiScore.2.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(3, "#MultiScore.3.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(4, "#MultiScore.4.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(5, "#MultiScore.5.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(6, "#MultiScore.6.4#".." |mp.nar_duel_timer_warning")
	MissionNarrativePlayer(7, "#MultiScore.7.4#".." |mp.nar_duel_timer_warning")
end

function luaTimeUp()
	for i = 0, 7 do
		MissionNarrativePlayer(i, "mp.nar_duel_time_up")
	end
end

function luaQADSStoreUnits()
	if not Mission.Completed then
-- RELEASE_LOGOFF  		luaLog(" Storing ships into tables...")
		Mission.JapaneseUnits = luaGetShipsAroundCoordinate(Mission.CenterPoint, 40000, PARTY_JAPANESE, "own")
		if Mission.JapaneseUnits ~= nil then
			if table.getn(Mission.JapaneseUnits) ~= nil then
-- RELEASE_LOGOFF  				luaLog(" JapaneseShips units: "..table.getn(Mission.JapaneseUnits))
				for index, unit in pairs(Mission.JapaneseUnits) do
					if not luaIsInside(unit, Mission.Japanese) then
						SetForcedReconLevel(unit, 2, PARTY_ALLIED)
						--SetSkillLevel(unit, SKILL_ELITE)
						table.insert(Mission.Japanese, unit)
-- RELEASE_LOGOFF  						luaLog("  inserting ID "..unit.ID.." into Mission.Japanese")
					end
				end
			end
		end
	
		Mission.AlliedUnits = luaGetShipsAroundCoordinate(Mission.CenterPoint, 40000, PARTY_ALLIED, "own")
		if Mission.AlliedUnits ~= nil then
			if table.getn(Mission.AlliedUnits) ~= nil then
-- RELEASE_LOGOFF  				luaLog(" Allied units: "..table.getn(Mission.AlliedUnits))
				for index, unit in pairs(Mission.AlliedUnits) do
					if not luaIsInside(unit, Mission.Allied) then
						SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
						--SetSkillLevel(unit, SKILL_ELITE)
						table.insert(Mission.Allied, unit)
-- RELEASE_LOGOFF  						luaLog("  inserting ID "..unit.ID.." into Mission.Allied")
					end
				end
			end
		end
	end
	Mission.SCheckAllowed = true
end

function luaQADSDeadWatcher()
	if Mission.SCheckAllowed then
		if table.getn(Mission.Japanese) ~= 0 then
			for index, unit in pairs (Mission.Japanese) do
				if not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  ID "..unit.ID.." is still alive")
				end
			end
		end
		if table.getn(Mission.Allied) ~= 0 then
			for index, unit in pairs (Mission.Allied) do
				if not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  ID "..unit.ID.." is still alive")
				end
			end
		end
	end
end

function luaQADSCheckBattle()
	if Mission.SCheckAllowed then
		if Mission.BattleGoingOn then
-- RELEASE_LOGOFF  			luaLog(" Checking battle... | Jap: "..table.getn(Mission.Japanese).." | US: "..table.getn(Mission.Allied))
			local japshipcheck = {}
			if table.getn(Mission.Japanese) ~= 0 then
				for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  					luaLog("   inserting "..unit.Name.." into japshipcheck")
					table.insert(japshipcheck, unit)
				end
			end
			japshipcheck = luaRemoveDeadsFromTable(japshipcheck)
-- RELEASE_LOGOFF  			luaLog("  number of Japanese units alive: "..table.getn(japshipcheck))
		
			local alliedshipcheck = {}
			if table.getn(Mission.Allied) ~= 0 then
				for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  					luaLog("   inserting "..unit.Name.." into alliedshipcheck")
					table.insert(alliedshipcheck, unit)
				end
			end
			alliedshipcheck = luaRemoveDeadsFromTable(alliedshipcheck)
-- RELEASE_LOGOFF  			luaLog("  number of US units alive: "..table.getn(alliedshipcheck))
		
			if table.getn(japshipcheck) == 0 and table.getn(alliedshipcheck) == 0 then
-- RELEASE_LOGOFF  				luaLog(" Battle over, draw")
				--Mission.JapaneseRoundWon = Mission.JapaneseRoundWon + 1
				--Mission.AlliedRoundWon = Mission.AlliedRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_draw")
				end
				--MissionNarrativeParty(0, "| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				--MissionNarrativeParty(1, "| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				--MissionNarrative("| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				luaDelay(luaQADSDrawKill, 7)
				Mission.BattleGoingOn = false
				--Mission.BattleCounter = Mission.BattleCounter + 1
				--MissionNarrative("Battle "..Mission.BattleCounter.."!")
			elseif table.getn(alliedshipcheck) == 0 then
-- RELEASE_LOGOFF  				luaLog(" Battle over, Japan won")
				Mission.JapaneseRoundWon = Mission.JapaneseRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_jap")
				end
				--MissionNarrative("| Japan won | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				luaDelay(luaQADSJapWonKill, 7)
				Mission.BattleGoingOn = false
				Mission.BattleCounter = Mission.BattleCounter + 1
				--MissionNarrative("Battle "..Mission.BattleCounter.."!")
			elseif table.getn(japshipcheck) == 0 then
-- RELEASE_LOGOFF  				luaLog(" Battle over, US won")
				Mission.AlliedRoundWon = Mission.AlliedRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_us")
				end
				--MissionNarrative("| US won | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				luaDelay(luaQADSUSWonKill, 7)
				Mission.BattleGoingOn = false
				Mission.BattleCounter = Mission.BattleCounter + 1
				--MissionNarrative("Battle "..Mission.BattleCounter.."!")
			end
		end
	end
end

function luaQADSDrawKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" DrawKill")
		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
	luaQADSKillPlanes()
end

function luaQADSJapWonKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" JapKill")
		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
	luaQADSKillPlanes()
end

function luaQADSUSWonKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" USKill")
		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
			--KillTorpedoesFromUnit(unit)
		end
		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
	luaQADSKillPlanes()
end

function luaQADSKillPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking planes in ships duel...")
	local japplanestokill = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 40000, PARTY_JAPANESE, "own")
	local usplanestokill = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 40000, PARTY_ALLIED, "own")
	if japplanestokill ~= nil then
-- RELEASE_LOGOFF  		luaLog("  Japanese planes found...")
		for index, unit in pairs (japplanestokill) do
-- RELEASE_LOGOFF  			luaLog("   killing "..unit.Name)
			Kill(unit, true)
		end
	end
	if usplanestokill ~= nil then
-- RELEASE_LOGOFF  		luaLog("  US planes found...")
		for index, unit in pairs (usplanestokill) do
-- RELEASE_LOGOFF  			luaLog("   killing "..unit.Name)
			Kill(unit, true)
		end
	end
end

function luaQADPManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Manager called...")
		if Mission.ManagerCounter == 1 then
--			MissionNarrativeClear()
			Mission.WarningTime = 15
--			luaWarningNarrative()
			Mission.ManagerCounter = 2
			luaDelay(luaQADPManager, 5)
		elseif Mission.ManagerCounter == 2 then
			MissionNarrativeClear()
			Mission.WarningTime = 10
			luaWarningNarrative()
			Mission.ManagerCounter = 3
			luaDelay(luaQADPManager, 5)
		elseif Mission.ManagerCounter == 3 then
			MissionNarrativeClear()
			Mission.WarningTime = 5
			luaWarningNarrative()
			Mission.ManagerCounter = 4
			luaDelay(luaQADPManager, 5)
		elseif Mission.ManagerCounter == 4 then
			MissionNarrativeClear()
			luaTimeUp()
			BannSupportmanager()
			luaDelay(luaQADPStoreUnits, 5)
			Mission.BattleGoingOn = true
		elseif Mission.ManagerCounter == 5 then
			Mission.WarningTime = 15
			luaWarningNarrative()
			Mission.ManagerCounter = 2
			luaDelay(luaQADPManager, 5)
			PermitSupportmanager()
		end
	end
end



function luaQADPStoreUnits()
	if not Mission.Completed then
-- RELEASE_LOGOFF  		luaLog(" Storing units into tables...")
		Mission.JapaneseUnits = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 40000, PARTY_JAPANESE, "own")
		if Mission.JapaneseUnits ~= nil then
			if table.getn(Mission.JapaneseUnits) ~= nil then
-- RELEASE_LOGOFF  				luaLog(" Japanese units: "..table.getn(Mission.JapaneseUnits))
				for index, unit in pairs(Mission.JapaneseUnits) do
					if not luaIsInside(unit, Mission.Japanese) then
						SetForcedReconLevel(unit, 2, PARTY_ALLIED)
						--SetSkillLevel(unit, SKILL_ELITE)
						table.insert(Mission.Japanese, unit)
-- RELEASE_LOGOFF  						luaLog("  inserting ID "..unit.ID.." into Mission.Japanese")
					end
				end
			end
		end
	
		Mission.AlliedUnits = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 40000, PARTY_ALLIED, "own")
		if Mission.AlliedUnits ~= nil then
			if table.getn(Mission.AlliedUnits) ~= nil then
-- RELEASE_LOGOFF  				luaLog(" Allied units: "..table.getn(Mission.AlliedUnits))
				for index, unit in pairs(Mission.AlliedUnits) do
					if not luaIsInside(unit, Mission.Allied) then
						SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
						--SetSkillLevel(unit, SKILL_ELITE)
						table.insert(Mission.Allied, unit)
-- RELEASE_LOGOFF  						luaLog("  inserting ID "..unit.ID.." into Mission.Allied")
					end
				end
			end
		end
	end
	Mission.PCheckAllowed = true
end

function luaQADPCheckBattle()
	if Mission.PCheckAllowed then
		if Mission.BattleGoingOn then
-- RELEASE_LOGOFF  			luaLog(" Checking battle... | Jap: "..table.getn(Mission.Japanese).." | US: "..table.getn(Mission.Allied))
			local japcheck = {}
			if table.getn(Mission.Japanese) ~= 0 then
				for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  					luaLog("   inserting "..unit.Name.." into japcheck")
					table.insert(japcheck, unit)
				end
			end
			japcheck = luaRemoveDeadsFromTable(japcheck)
-- RELEASE_LOGOFF  			luaLog("  number of Japanese units alive: "..table.getn(japcheck))
		
			local alliedcheck = {}
			if table.getn(Mission.Allied) ~= 0 then
				for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  					luaLog("   inserting "..unit.Name.." into alliedcheck")
					table.insert(alliedcheck, unit)
				end
			end
			alliedcheck = luaRemoveDeadsFromTable(alliedcheck)
-- RELEASE_LOGOFF  			luaLog("  number of US units alive: "..table.getn(alliedcheck))

			if table.getn(japcheck) ~= 0 and table.getn(alliedcheck) ~= 0 and not Mission.AILevelSet then
-- RELEASE_LOGOFF  				luaLog("  searching for living player units...")
				local playersInGame = GetPlayerDetails()
				--luaLog(playersInGame)
				local playerunitsalive = 0
				for index, unit in pairs (japcheck) do
					local ownerplayer = GetRoleAvailable(unit)[1]
					--luaLog("   ownerplayer: "..tostring(ownerplayer))
					for index2, playerInSlot in pairs (playersInGame) do
						--luaLog("   index2: "..tostring(index2))
						if ownerplayer == index2 then
							--luaLog("   playerInSlot.ai: "..tostring(playerInSlot.ai))
							if not playerInSlot.ai then
-- RELEASE_LOGOFF  								luaLog("   living player unit found!")
								playerunitsalive = playerunitsalive + 1
							end
						end
					end
				end
				for index, unit in pairs (alliedcheck) do
					local ownerplayer = GetRoleAvailable(unit)[1]
					--luaLog("   ownerplayer: "..tostring(ownerplayer))
					for index2, playerInSlot in pairs (playersInGame) do
						--luaLog("   index2: "..tostring(index2))
						if ownerplayer == index2 then
							--luaLog("   playerInSlot.ai: "..tostring(playerInSlot.ai))
							if not playerInSlot.ai then
-- RELEASE_LOGOFF  								luaLog("   living player unit found!")
								playerunitsalive = playerunitsalive + 1
							end
						end
					end
				end
				if playerunitsalive == 0 then
					Mission.AILevelSet = true
					local skillModifier = luaRnd(1, 2)
					if table.getn(japcheck) > table.getn(alliedcheck) then
						luaQADPSetAILevel(japcheck, alliedcheck)
					elseif table.getn(japcheck) < table.getn(alliedcheck) then
						luaQADPSetAILevel(alliedcheck, japcheck)
					elseif skillModifier == 1 then
						luaQADPSetAILevel(japcheck, alliedcheck)
					else
						luaQADPSetAILevel(alliedcheck, japcheck)
					end
				end
			elseif table.getn(japcheck) == 0 and table.getn(alliedcheck) == 0 then
				--Mission.JapaneseRoundWon = Mission.JapaneseRoundWon + 1
				--Mission.AlliedRoundWon = Mission.AlliedRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_draw")
				end
				--MissionNarrativeParty(0, "| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				--MissionNarrativeParty(1, "| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				--MissionNarrative("| Battle draw | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				luaDelay(luaQADPDrawKill, 7)
				Mission.BattleGoingOn = false
				Mission.AILevelSet = false
				--Mission.BattleCounter = Mission.BattleCounter + 1
				--MissionNarrative("Battle "..Mission.BattleCounter.."!")
			elseif table.getn(alliedcheck) == 0 then
-- RELEASE_LOGOFF  				luaLog(" Battle over, Japan won")
				Mission.JapaneseRoundWon = Mission.JapaneseRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_jap")
				end
				luaDelay(luaQADPJapWonKill, 7)
				Mission.BattleGoingOn = false
				Mission.AILevelSet = false
				Mission.BattleCounter = Mission.BattleCounter + 1
			elseif table.getn(japcheck) == 0 then
-- RELEASE_LOGOFF  				luaLog(" Battle over, US won")
				Mission.AlliedRoundWon = Mission.AlliedRoundWon + 1
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp.nar_duel_round_us")
				end
				--MissionNarrativeParty(0, "| US won | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				--MissionNarrativeParty(1, "| US won | Jap: "..Mission.JapaneseRoundWon.." | US: "..Mission.AlliedRoundWon.." |")
				luaDelay(luaQADPUSWonKill, 7)
				Mission.BattleGoingOn = false
				Mission.AILevelSet = false
				Mission.BattleCounter = Mission.BattleCounter + 1
			end
		end
	end
end

function luaQADPSetAILevel(elite, stun)
-- RELEASE_LOGOFF  	luaLog("  modifying AI skill levels")
	for index, unit in pairs (elite) do
		SetSkillLevel(unit, SKILL_ELITE)
	end
	for index, unit in pairs (stun) do
		SetSkillLevel(unit, SKILL_STUN)
	end
end

function luaQADPDeadWatcher()
	if Mission.PCheckAllowed then
		if table.getn(Mission.Japanese) ~= 0 then
			for index, unit in pairs (Mission.Japanese) do
				if not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  ID "..unit.ID.." is still alive")
				end
			end
		end
	
		if table.getn(Mission.Allied) ~= 0 then
			for index, unit in pairs (Mission.Allied) do
				if not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  ID "..unit.ID.." is still alive")
				end
			end
		end
	end
end

function luaQADPDrawKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" DrawKill")
		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
end

function luaQADPJapWonKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" JapKill")
		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
end

function luaQADPUSWonKill()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" USKill")
		for index, unit in pairs (Mission.Allied) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		for index, unit in pairs (Mission.Japanese) do
-- RELEASE_LOGOFF  			luaLog("  unit ID "..unit.ID.." | TrulyDead?")
-- RELEASE_LOGOFF  			luaLog(TrulyDead(unit))
			if not TrulyDead(unit) then
-- RELEASE_LOGOFF  				luaLog("  killing!")
				Kill(unit, true)
			end
		end

		Mission.ResetAllowed = true
		RemoveWrecks()
		KillBullets()
		DestroyEffect()
	end
end

function luaQADMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called, checking counters...")
	if Mission.JapaneseRoundWon == Mission.AlliedRoundWon then
-- RELEASE_LOGOFF  		luaLog("  one more kill needed to decide")
		if Mission.OverTimeNarrativeTimer < GameTime() then
			Mission.OverTimeNarrativeTimer = GameTime() + 30
			MissionNarrativeParty(PARTY_ALLIED, "mp.nar_duel_overtime")
			MissionNarrativeParty(PARTY_JAPANESE, "mp.nar_duel_overtime")
		end
		luaDelay(luaQADMissionEnd, 3)

	elseif Mission.JapaneseRoundWon > Mission.AlliedRoundWon then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		Mission.Japanese = luaRemoveDeadsFromTable(Mission.Japanese)
		if table.getn(Mission.Japanese) ~= 0 then
			local unittoshow = luaPickRnd(Mission.Japanese)
-- RELEASE_LOGOFF  			luaLog("  unittoshow: "..unittoshow.Name)
			SetForcedReconLevel(unittoshow, 2, PARTY_ALLIED)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)
-- RELEASE_LOGOFF  			luaLog(Scoring_GetRealPlayTime())
			luaMissionCompletedNew(unittoshow, "", nil, nil, nil, PARTY_JAPANESE)
		else
			local unittoshow = GenerateObject(Mission.JapEndUnit.Name)
			SetForcedReconLevel(unittoshow, 2, PARTY_ALLIED)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)
-- RELEASE_LOGOFF  			luaLog(Scoring_GetRealPlayTime())
			luaMissionCompletedNew(unittoshow, "", nil, nil, nil, PARTY_JAPANESE)
		end

	elseif Mission.JapaneseRoundWon < Mission.AlliedRoundWon then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		Mission.Allied = luaRemoveDeadsFromTable(Mission.Allied)
		if table.getn(Mission.Allied) ~= 0 then
			local unittoshow = luaPickRnd(Mission.Allied)
-- RELEASE_LOGOFF  			luaLog("  unittoshow: "..unittoshow.Name)
			SetForcedReconLevel(unittoshow, 2, PARTY_JAPANESE)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
-- RELEASE_LOGOFF  			luaLog(Scoring_GetRealPlayTime())
			luaMissionCompletedNew(unittoshow, "", nil, nil, nil, PARTY_ALLIED)
		else
			local unittoshow = GenerateObject(Mission.USEndUnit.Name)
			SetForcedReconLevel(unittoshow, 2, PARTY_JAPANESE)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
-- RELEASE_LOGOFF  			luaLog(Scoring_GetRealPlayTime())
			luaMissionCompletedNew(unittoshow, "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()

	if LobbySettings.UnitType == "globals.unitcat_destroyer" then
-- RELEASE_LOGOFF  		luaLog("DD Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_cruiser" then
-- RELEASE_LOGOFF  		luaLog("CA Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_lightcruiser" then
-- RELEASE_LOGOFF  		luaLog("CL Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_battleship" then
-- RELEASE_LOGOFF  		luaLog("BB Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_torpedoboat" then
-- RELEASE_LOGOFF  		luaLog("PT Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_submarine" then
-- RELEASE_LOGOFF  		luaLog("Sub Duel Hint")
		ShowHint("ID_Hint_Duel01")
	elseif LobbySettings.UnitType == "globals.unitcat_fighter" then
-- RELEASE_LOGOFF  		luaLog("Fighter Duel Hint")
		ShowHint("ID_Hint_Duel01")
	end

--	ShowHint("ID_Hint_Duel01")
	-- mode description hint overlay
end

function luaUpdateCounters()
-- RELEASE_LOGOFF  	luaLog(" Updating counters...")
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.AlliedRoundWon
			MultiScore[i][2] = Mission.JapaneseRoundWon
		end
	end

	if not Mission.CountersSet then
		luaSetMultiScoreTable()
		Mission.CountersSet = true
	end
end
	
function luaSetMultiScoreTable()
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	MultiScore = {
		[0]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[1]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[2]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[3]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[4]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[5]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[6]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
		[7]= {
			[1] = Mission.AlliedRoundWon,
			[2] = Mission.JapaneseRoundWon,
			[3] = nil,
			[4] = nil,
		},
	}

	if Mission.RoundLimit ~= 0 then
		for i = 0, 7 do
			MultiScore[i][3] = Mission.RoundLimit
		end
		DisplayScores(1, 0, "mp.score_duel|".." #MultiScore.0.1# / #MultiScore.0.3#", "mp.score_duel|".." #MultiScore.0.2# / #MultiScore.0.3#",2,1)
		DisplayScores(1, 1, "mp.score_duel|".." #MultiScore.1.1# / #MultiScore.1.3#", "mp.score_duel|".." #MultiScore.1.2# / #MultiScore.1.3#",2,1)
		DisplayScores(1, 2, "mp.score_duel|".." #MultiScore.2.1# / #MultiScore.2.3#", "mp.score_duel|".." #MultiScore.2.2# / #MultiScore.2.3#",2,1)
		DisplayScores(1, 3, "mp.score_duel|".." #MultiScore.3.1# / #MultiScore.3.3#", "mp.score_duel|".." #MultiScore.3.2# / #MultiScore.3.3#",2,1)
		DisplayScores(1, 4, "mp.score_duel|".." #MultiScore.4.1# / #MultiScore.4.3#", "mp.score_duel|".." #MultiScore.4.2# / #MultiScore.4.3#",2,1)
		DisplayScores(1, 5, "mp.score_duel|".." #MultiScore.5.1# / #MultiScore.5.3#", "mp.score_duel|".." #MultiScore.5.2# / #MultiScore.5.3#",2,1)
		DisplayScores(1, 6, "mp.score_duel|".." #MultiScore.6.1# / #MultiScore.6.3#", "mp.score_duel|".." #MultiScore.6.2# / #MultiScore.6.3#",2,1)
		DisplayScores(1, 7, "mp.score_duel|".." #MultiScore.7.1# / #MultiScore.7.3#", "mp.score_duel|".." #MultiScore.7.2# / #MultiScore.7.3#",2,1)
	else
		DisplayScores(1, 0, "mp.score_duel|".." #MultiScore.0.1#", "mp.score_duel|".." #MultiScore.0.2#",2,1)
		DisplayScores(1, 1, "mp.score_duel|".." #MultiScore.1.1#", "mp.score_duel|".." #MultiScore.1.2#",2,1)
		DisplayScores(1, 2, "mp.score_duel|".." #MultiScore.2.1#", "mp.score_duel|".." #MultiScore.2.2#",2,1)
		DisplayScores(1, 3, "mp.score_duel|".." #MultiScore.3.1#", "mp.score_duel|".." #MultiScore.3.2#",2,1)
		DisplayScores(1, 4, "mp.score_duel|".." #MultiScore.4.1#", "mp.score_duel|".." #MultiScore.4.2#",2,1)
		DisplayScores(1, 5, "mp.score_duel|".." #MultiScore.5.1#", "mp.score_duel|".." #MultiScore.5.2#",2,1)
		DisplayScores(1, 6, "mp.score_duel|".." #MultiScore.6.1#", "mp.score_duel|".." #MultiScore.6.2#",2,1)
		DisplayScores(1, 7, "mp.score_duel|".." #MultiScore.7.1#", "mp.score_duel|".." #MultiScore.7.2#",2,1)
	end
end