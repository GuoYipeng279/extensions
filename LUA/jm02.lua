--SceneFile="universe\Scenes\missions\IJN\ijn_02_force_z.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",2)

	Dialogues =
	{
		["Intro_A"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01a",
				},
			},
		},
		["Intro_B"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01b",
				},
			},
		},
		["Intro_C"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01c",
				},
			},
		},
		["Intro_D"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01d",
				},
			},
		},
	}

	MissionNarrative("ijn02.date_location")
	luaDelay(luaEngineInit1, 11, "")

end

function luaEngineInit1()
	StartDialog("Intro_dlg1", Dialogues["Intro_A"] );
	luaDelay(luaEngineInit2, 9, "")
end

function luaEngineInit2()
	StartDialog("Intro_dlg2", Dialogues["Intro_C"] );
	luaDelay(luaEngineInit3, 1, "")
end

function luaEngineInit3()
	StartDialog("Intro_dlg3", Dialogues["Intro_D"] );
	luaDelay(luaEngineInit4, 23, "")
end

function luaEngineInit4()
	StartDialog("Intro_dlg4", Dialogues["Intro_B"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM2")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM2(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/ESMP/JM02.lua"

	this.Name = "JM2"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	--ForceEnableInput(IC_MAP_TOGGLE, false)

	this.Party = SetParty(this, PARTY_JAPANESE)

	this.MissionPhase = 1
	this.FirstRun = true

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.DiffMul = 1.25
		Mission.SkillLevel = SKILL_STUN
		--SetDeviceReloadTimeMul(3.0)
	elseif Mission.Difficulty == 1 then
		Mission.DiffMul = 1
		Mission.SkillLevel = SKILL_SPNORMAL
		--SetDeviceReloadTimeMul(2.0)
	elseif Mission.Difficulty == 2 then
		Mission.DiffMul = 0.85
		Mission.SkillLevel = SKILL_SPVETERAN
	end


	Mission.DodiSzorzo = 1 -- EZT ALLITSD HA KONNYITENI AKARSZ AZ ELSO FAZISON

	Mission.ReinfTimer = 180
	Mission.EscortGenerated = false
	Mission.FirstWaveGenerated = false
	Mission.SecondWaveGenerated = false
	Mission.BuffCount = 10

	Mission.AIPlaneReq = "AIPlaneSpawnID"
	Mission.PlayerPlaneReq = "PlayerPlaneSpawnID"
	Mission.ReinfSpawnReq = "ReinfSpawnReq"
	Mission.BuffaloSpawnReq = "BuffaloSpawnReq"

	Mission.DroidCounter = 0

	Mission.AlliedGroup = {}
	Mission.JapanesePlanes = {}
	Mission.Buff = {}
	Mission.FirstWaveBuff = {}
	Mission.SecWaveBuff = {}
	Mission.FakeNells = {}

	Mission.DeadJapPlanes = 0
	Mission.SpawnedUnits = 0

	Mission.BuffaloGrp1 = {}
	Mission.BuffaloGrp2 = {}
	Mission.AirPatrol1 = {}
	Mission.AirPatrol2 = {}
	Mission.MaxBuffalosInAir1 = 3
	Mission.MaxBuffalosInAir2 = 3


	Mission.BorderZone = {GetPosition(FindEntity("Border 01")), GetPosition(FindEntity("Border 02"))}
	Mission.BettyPath = FindEntity("BettyPath")
	Mission.NellPaths = {}
		table.insert(Mission.NellPaths, FindEntity("NellPath 01"))
		table.insert(Mission.NellPaths, FindEntity("NellPath 02"))

	Mission.ReinfGrp = {}

	Mission.BombersKilled = 0
	Mission.PlayerNear = false

	Mission.PoW = FindEntity("King George V-class 1")
	SetGuiName(Mission.PoW, "ingame.shipnames_prince_of_wales")
	table.insert(Mission.AlliedGroup, Mission.PoW)
	Mission.Repulse = FindEntity("Renown-class 1")
	SetGuiName(Mission.Repulse, "ingame.shipnames_repulse")
	table.insert(Mission.AlliedGroup, Mission.Repulse)

	RepairEnable(Mission.PoW, false)
	RepairEnable(Mission.Repulse, false)

	Mission.PlayerBetty = FindEntity("G4M Betty")
	Mission.WingMan = FindEntity("G4M Betty 01")
	SetInvincible(Mission.WingMan, true)
	Mission.PlayerNell = {}
	Mission.MaxSpawns = 5
	SetSelectedUnit(Mission.PlayerBetty)
	PilotMoveToRange(Mission.PlayerBetty, Mission.PoW)

	if GetProperty(Mission.PlayerBetty, "ammoType") ~= 6 then
		PilotSetTarget(Mission.PlayerBetty, Mission.PoW)
	end

	SquadronSetTravelAlt(Mission.PlayerBetty, 500, true)
	SquadronSetAttackAlt(Mission.PlayerBetty, 500, true)
	luaJM2BettyListener(Mission.PlayerBetty)

	SquadronSetTravelAlt(FindEntity("G4M Betty 01"), 500, true)
	SquadronSetAttackAlt(FindEntity("G4M Betty 01"), 500, true)

	SetDeviceReloadEnabled(true)
	--SetSimplifiedReconMultiplier(0.5)
	BannSupportmanager()

	Mission.RepulseSpawns = {}
		table.insert(Mission.RepulseSpawns, FindEntity("SpawnPoint 05"))
		table.insert(Mission.RepulseSpawns, FindEntity("SpawnPoint 06"))
		table.insert(Mission.RepulseSpawns, FindEntity("SpawnPoint 07"))
		table.insert(Mission.RepulseSpawns, FindEntity("SpawnPoint 08"))
	Mission.PoWSpawns = {}
		table.insert(Mission.PoWSpawns, FindEntity("SpawnPoint 01"))
		table.insert(Mission.PoWSpawns, FindEntity("SpawnPoint 02"))
		table.insert(Mission.PoWSpawns, FindEntity("SpawnPoint 03"))
		table.insert(Mission.PoWSpawns, FindEntity("SpawnPoint 04"))

	--Mission.AlliedRetreatPoints = {FindEntity("ARetreat1"), FindEntity("ARetreat2"), FindEntity("ARetreat3")}
	Mission.ClemsonNames = {"ingame.shipnames_electra", "ingame.shipnames_vampire", "ingame.shipnames_express"} --, "Tendos"}

	for i=1,3 do
		local unit = FindEntity("Clemson-class "..tostring(i))
		--luaLog(unit)
		SetGuiName(unit, Mission.ClemsonNames[i])
		table.insert(Mission.AlliedGroup, unit)
	end

	Mission.RNPath = FindEntity("RoyalNavyPath1")

	--groups &formations
	for idx,unit in pairs(Mission.AlliedGroup) do
		SetSkillLevel(unit, Mission.SkillLevel)
		--UnitFreeFire(unit)
		if unit.ID ~= Mission.Repulse.ID then
			JoinFormation(unit, Mission.Repulse)
		end

		SetNumbering(unit, 0)
	end

	--Spawnpoints
	Mission.SpawnPoints = {}
	for i=1,21 do
		table.insert(Mission.SpawnPoints, FindEntity("Navpoint "..tostring(i)))
	end

	NavigatorMoveOnPath(Mission.Repulse, Mission.RNPath)

	SetInvincible(Mission.PoW, true)
	SetInvincible(Mission.Repulse, true)

	Mission.AlliedShipExited = false
	Mission.HitCounter = 0
	Mission.StartArea = {GetPosition(FindEntity("OpX")), GetPosition(FindEntity("OpY"))}

	Mission.RndFailures = {
		[1] = "Fire",
		[2] = "EngineJam",
		[3] = "Explosion",
	}

	Mission.Failrun = 1

	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM2LoadBlackOut, luaJM2GenerateEscort},
		[2] = {luaJM2LoadBlackOut, luaJM2GenerateEscort, luaJM2RepulseCam, luaJM2PutToAfter},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM2SaveMissionData,},
		[2] = {luaJM2SaveMissionData,},
	}

	--objectives
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "boom2",
				["Text"] = "ijn02.obj_p1", --Destroy the HMS Prince of Wales
				["TextCompleted"] = "ijn02.obj_p1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[2] = {
				["ID"] = "escort",
				["Text"] = "ijn02.obj_p2",
				["TextCompleted"] = "ijn02.obj_p2_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[3] = {
				["ID"] = "boom1",
				["Text"] = "ijn02.obj_p3", --Destroy the HMS Repulse
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "killallbuff",
				["Text"] = "ijn02.obj_s1", --"ijn02.obj_h1", --Too many casualties are not acceptable.
				["TextCompleted"] = "ijn02.obj_s1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "reinf",
				["Text"] = "ijn02.obj_h1", --Destroy the second battleship before the reinforcements arrive
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["marker2"] = {
				[1] = {
				["ID"] = "Event_markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		},
	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--dialogues
	Mission.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13a_1",
				},
				{
					["message"] = "dlg13b",
				},
				{
					["message"] = "dlg13c",
				},
				{
					["message"] = "dlg13d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM2BombCamHint",
				},
			},
		},
		["RunFailed1"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",--"That's not what we expect from you. Try harder!",
				},
			},
		},
		["RunFailed2"] = {
			["sequence"] = {
				{
					["message"] = "dlg1b",--"You're a disgrace. How could you pass aviaton exams?",
				},
			},
		},
		["RunFailed3"] = {
			["sequence"] = {
				{
					["message"] = "dlg1c",--"Complete and utter failure.  Do you want to be described as that? Go at it again!",
				},
			},
		},
		["RunFailed4"] = {
			["sequence"] = {
				{
					["message"] = "dlg1d",--"AGAIN!!!",
				},
			},
		},
		["BBHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg2",--"We've achieved a hit on an enemy battleship.",
				},
			},
		},
		["BBFire1"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",--"Enemy battleship is on fire.",
				},
			},
		},
		["BBFire2"] = {
			["sequence"] = {
				{
					["message"] = "dlg3b",--"Good, good! Set them aflame!",
				},
			},
		},
		["BBListing1"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",--"Enemy Battleship is listing to the side!",
				},
			},
		},
		["BBListing2"] = {
			["sequence"] = {
				{
					["message"] = "dlg4b",--"Just don't get too enthusiastic about that. Finish the job!",
				},
			},
		},
		["BBEngine1"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",--"Allied battleship stopped!",
				},
			},
		},
		["BBEngine2"] = {
			["sequence"] = {
				{
					["message"] = "dlg5b",--"A good hit on the engineroom. Now... what we know about sitting ducks?",
				},
			},
		},
		["BBMagazine1"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",--"Huge explosion on an enemy battleship.",
				},
			},
		},
		["BBMagazine2"] = {
			["sequence"] = {
				{
					["message"] = "dlg6b",--"It's not called Fool's Luck by coincidence... You must have hit its magazine.",
				},
			},
		},
		["BBLowHP"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",--"That battleship is almost finished.",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["Buffalos_Incomm1"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",--"Enemy fighters incoming!",
				},
			},
		},
		["Buffalos_Incomm2"] = {
			["sequence"] = {
				{
					["message"] = "dlg8b",--"Then pray to the Gods... Or do something about it!",
				},
			},
		},
		["Buffalos_Incomm3"] = {
			["sequence"] = {
				{
					["message"] = "dlg31a",
				},
				{
					["message"] = "dlg31b",
				},

			},
		},
		["Split1"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",--"They're loosening up their formation...",
				},
			},
		},
		["Split2"] = {
			["sequence"] = {
				{
					["message"] = "dlg9b",--"Enemy fleet is splitting.",
				},
			},
		},
		["Split3"] = {
			["sequence"] = {
				{
					["message"] = "dlg9c",--"Don't lose them. We want them dead!",
				},
			},
		},
		["StockLow1"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",--"We have only a few planes available. Time to learn better aiming, don't you think?",
				},
			},
		},
		["StockLow2"] = {
			["sequence"] = {
				{
					["message"] = "dlg10b",--"Success is your duty!",
				},
			},
		},
		["Reconlaunched1"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",--"Enemy seaplane was launched from an enemy battleship.",
				},
			},
		},
		["Reconlaunched2"] = {
			["sequence"] = {
				{
					["message"] = "dlg11b",--"You're not going to shit your pants, right? ",
				},
			},
		},
		["ReinfIn1"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",--"Incoming destroyers!",
				},
			},
		},
		["ReinfIn2"] = {
			["sequence"] = {
				--[[
				{
					["message"] = "Play with your food too long and it becomes uninviting.",
				},
				{
					["message"] = "You still have to eat it though...  COME ON!",
				},]]
				{
					["message"] = "dlg12b",
				},
				{
					["message"] = "dlg12c",
				},
			},
		},
		["BothBBRemind"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["PoWRemind"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
			},
		},
		["RepulseRemind"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
			},
		},
		["BBDead"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
			},
		},
		["PoWDead"] = {
			["sequence"] = {
				{
					["message"] = "dlg30a",
				},
				{
					["message"] = "dlg30a_1",
				},
--				{
--					["type"] = "callback",
--					["callback"] = "luaJM2GenerateEscort",
--				},
			},
		},
		["Intermezzo"] = {
			["sequence"] = {
				{
					["message"] = "dlg30b",
				},
				--{
					--["type"] = "callback",
					--["callback"] = "luaJM2GenerateFirstWave",
				--},
			},
		},
		["Intermezzo2"] = {
			["sequence"] = {
				{
					["message"] = "dlg30c",
				},
				{
					["message"] = "dlg30d",
				},
				{
					["message"] = "dlg30e",
				},
				{
					["message"] = "dlg30f",
				},
				{
					["message"] = "dlg30g",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM2DelayedBuffaloDlg",
				},

			},
		},
		["TorpedoSquadron"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
				{
					["message"] = "dlg18_1",
				},
			},
		},
		["SOS"] = {
			["sequence"] = {
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19b",
				},
				{
					["message"] = "dlg19c",
				},
			},
		},
		["SOSMorseOnly"] = {
			["sequence"] = {
				{
					["message"] = "dlg19a",
				},
			},
		},
		["BomberLost"] = {
			["sequence"] = {
				{
					["message"] = "dlg20a",
				},
				{
					["message"] = "dlg20b",
				},
			},
		},
		["BomberLost2"] = {
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
				{
					["message"] = "dlg21b",
				},
			},
		},
		["BuffInc"] = {
			["sequence"] = {
				{
					["message"] = "dlg21b",
				},
			},
		},
		["DDAA"] = {
			["sequence"] = {
				{
					["message"] = "dlg22a",
				},
				{
					["message"] = "dlg22b",
				},
			},
		},
		["NotThisDroid1"] = {
			["sequence"] = {
				{
					["message"] = "dlg27",
				},
			},
		},
		["NotThisDroid2"] = {
			["sequence"] = {
				{
					["message"] = "dlg28",
				},
			},
		},
		["NotThisDroid3"] = {
			["sequence"] = {
				{
					["message"] = "dlg29",
				},
			},
		},
		["NellsArrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg32a",
				},
				{
					["message"] = "dlg32b",
				},
				{
					["message"] = "dlg32c",
				},
				{
					["message"] = "dlg32d",
				},
			},
		},

		["Final"] = {
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
				{
					["message"] = "dlg23_1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM2MissionCompleted",
				},
			},
		},
		---nmiradio
		["EnemyBuffalo"] = {
			["sequence"] = {
				{
					["message"] = "dlg24a",
				},
				{
					["message"] = "dlg24b",
				},
				{
					["message"] = "dlg24c",
				},
			},
		},

		["EnemyBuffalo1"] = {
			["sequence"] = {
				{
					["message"] = "dlg25a",
				},
				{
					["message"] = "dlg25b",
				},
			},
		},

		["DDIN"] = {
			["sequence"] = {
				{
					["message"] = "dlg26a",
				},
				{
					["message"] = "dlg26b",
				},
			},
		},
		["BuffShot"] = {
			["sequence"] = {
				{
					["message"] = "dlg33a",
				},
				{
					["message"] = "dlg33b",
				},
			},
		},
	}

	LoadMessageMap("ijndlg",2)

	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	--think
	--SetDeviceReloadTimeMul(0)
    SetThink(this, "luaJM2_think")


	RepairEnable(Mission.PoW, false)
	RepairEnable(Mission.Repulse, false)

	luaJM2FadeIn()
	--watch

	--luaJM2JumpToUnit(Mission.PlayerBetty)
	--AddWatch("Mission.PlayerNell.ID")
	--AddWatch("Mission.HitCounter")


	--[[AddWatch("Mission.PlayerBetty.AICtrl")
-- RELEASE_LOGOFF  	AddWatch("Mission.PlayerBetty.Dead")
-- RELEASE_LOGOFF  	AddWatch("Mission.PlayerBetty.ID")

-- RELEASE_LOGOFF  	AddWatch("Mission.PlayerNell.AICtrl")
-- RELEASE_LOGOFF  	AddWatch("Mission.PlayerNell.Dead")
-- RELEASE_LOGOFF  	AddWatch("Mission.PlayerNell.ID")

-- RELEASE_LOGOFF  	AddWatch("Mission.HitTrue")
-- RELEASE_LOGOFF  	AddWatch("Mission.HitListener")

-- RELEASE_LOGOFF  	AddWatch("Mission.BettyID")
-- RELEASE_LOGOFF  	AddWatch("Mission.NellID")
-- RELEASE_LOGOFF  	AddWatch("Mission.SEntity")
-- RELEASE_LOGOFF  	AddWatch("Mission.DeadSEntity")]]--
end

function luaJM2_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")
	--PerfTimingStart("white")
	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
		--PerfTimingEnd("white")
	end

	if Mission.EndMission then
		return
	end

	if Mission.ThinkStop then
		return
	end

	luaCheckMusic()

	luaJM2CheckObjectives()

	--luaJM2MemCucc()
	if Mission.MissionPhase == 1 then

		if Mission.FirstRun then
			Mission.FirstRun = false
			luaJM2StartFlakManager()
		end


		if Mission.PoW and not Mission.PoW.Dead then
			luaJM2CheckPlayerPlane()
			--luaJM2CheckBBFailures()
			luaJM2CheckSpawns()
			luaJM2SquadCounter()
		end
		--luaJM2FakeFlakManager()
		luaJM2LandHintChecker()

	elseif Mission.MissionPhase == 2 then

		luaJM2OhkaChecker()

		if Mission.FirstWaveGenerated --[[and table.getn(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)) == 0]] then
			if not Mission.SecondWaveGenerated then
				Mission.SecondWaveGenerated = true
				luaDelay(luaJM2GenerateSecondWave, 45)
			else
				luaJM2BuffaloTargetChecker()
			end
		end


		luaJM2IsPlayerNear(Mission.PlayerBetty, Mission.Repulse, 5000)
		--local cmd = GetProperty(Mission.PlayerBetty, "unitcommand")
		--luaLog(cmd)

		if not Mission.ScoreHided and Mission.FirstWaveGenerated then
			luaJM2DistanceCounter()
		end

	elseif Mission.MissionPhase == 3 then

		if Mission.FirstRun then
			Mission.FirstRun = false
			if Mission.Hollywood then
				DeleteScript(Mission.Hollywood)
			end

			luaJM2EnableControls(true)
			if IsListenerActive("hit", "RepulseHit") then
				RemoveListener("hit", "RepulseHit")
			end

			if IsListenerActive("kill", "PlaneSquadronLost") then
				RemoveListener("kill", "PlaneSquadronLost")
			end

			luaJM2StartFlakManager()
			Mission.MaxSpawns = 5
			PilotSetTarget(Mission.PlayerNell, Mission.Repulse)
		end

		luaJM2LandHintChecker()

		if Mission.Repulse and not Mission.Repulse.Dead then
			--luaJM2CheckPlanes()
			luaJM2CheckPlayerPlane()
			luaJM2OhkaChecker()
			--luaJM2CheckBuffalos()
			if not Mission.CheckpointLoaded then
				luaJM2CheckSpawns()
			end
			--luaJM2CheckBBFailures()
			luaJM2SquadCounter()
		end

	end

	if Mission.MissionPhase < 99 and Mission.ReinfIn then
		luaJM2CheckReinf()
		luaJM2CheckShips()
	end
	--PerfTimingEnd("white")
end

function luaJM2CheckObjectives()

--[[	if Mission.AlliedShipExited and Mission.MissionPhase < 99 then -- missionfail
		--if luaObj_IsActive("primary",1) and not luaObj_GetSuccess("primary",1) then
		--	luaObj_FailedAll()
		--end

		Mission.MissionFailed = true
		Mission.EndMission = true
		Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
		luaJM2StepPhase(99)
	end]]

	if not Mission.BBDeadDlg then
		if Mission.MissionPhase == 3 and not Mission.Repulse.Dead then
			--luaJM2StartDialog("BBDead")
			luaDelay(luaJM2SOSDialog, random(10,20))
			Mission.BBDeadDlg = true
		end
	end

	if Mission.MissionPhase == 1 then


		if not IsListenerActive("hit", "PoWHit") then
			luaJM2AddPoWListener()
		end

		if Mission.Repulse.Dead then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn02.obj_missionfailed_3" --Allied ships exited the mission area
			luaJM2StepPhase(99)
			return
		end

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			luaObj_AddUnit("primary",1,Mission.PoW)
			--luaObj_AddReminder("primary",1)
			DisplayUnitHP({Mission.PoW}, "ijn02.obj_p1")
			luaJM2StartDialog("Init")
		else
			if luaObj_GetSuccess("primary",1) == nil then
				if Mission.PoW.Dead then
					if Mission.PoW.KillReason ~= "exitzone" then
						if IsListenerActive("command","BettyRetreat") then
							RemoveListener("command","BettyRetreat")
						end
						luaObj_Completed("primary",1, true)

						HideUnitHP()
						HideScoreDisplay(1,0)

						luaJM2StepPhase()

						--MissionNarrativeUrgent("globals.checkpoint_r")
						luaDelay(luaJM2DelayedChkp, 3)
					else
						Mission.MissionFailed = true
						Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
						luaJM2StepPhase(99)
					end
				else
					--luaObj_Reminder("primary",1)
				end
			end
		end

	elseif Mission.MissionPhase == 2 then
		if Mission.Repulse.Dead and Mission.Repulse.KillReason == "exitzone" then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
			luaJM2StepPhase(99)
			return
		end

		if not luaObj_IsActive("primary",2) then
			if Mission.FirstWaveGenerated and Mission.EscortGenerated then
				luaObj_Add("primary",2)
				luaObj_Add("secondary",1)
				--luaJM2BuffaloKillListener()

				for i,v in pairs(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)) do
					--luaObj_AddUnit("secondary",1,v)
				end

				--DisplayScores(9,0,"ijn02.obj_s1","")
			end
		else
			if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
				if Mission.PlayerNear or luaObj_GetSuccess("secondary",1) then
					luaObj_Completed("primary",2, true)
					--luaJM2NellHint()
					--luaCheckpoint(2,nil)
					Blackout(true, "luaJM2CheckPoint2", 2)
				end
			end

			if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
				if table.getn(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.SecWaveBuff)) == 0 then
					if Mission.SecondWaveGenerated then
						luaObj_Completed("secondary",1)
						--Mission.PlayerNear = true
						--HideScoreDisplay(9,0)
					end
				end
			end

			if Mission.EscortGenerated and table.getn(luaRemoveDeadsFromTable(Mission.FakeNells)) == 0 then
				--luaObj_FailedAll()
				Mission.MissionFailed = true
				Mission.FailMsg = "ijn02.obj_missionfailed_1"
				luaJM2StepPhase(99)
			end

			if Mission.EscortGenerated and Mission.PlayerBetty.Dead then
				Mission.MissionFailed = true
				Mission.FailMsg = "ijn02.obj_missionfailed_1"
				luaJM2StepPhase(99)
			end
		end

	elseif Mission.MissionPhase == 3 then

		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)) ~= 0 or table.getn(luaRemoveDeadsFromTable(Mission.SecWaveBuff)) ~= 0 then
				luaObj_Failed("secondary",1)
				MissionNarrative("ijn02.obj_s1_fail")
				--HideScoreDisplay(9,0)
			end
		end

		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		end


		if not luaObj_IsActive("primary",3) then
			if Mission.RepulseCamDone then
				luaObj_Add("primary",3)
				Mission.LandHintShown = false
				if not IsListenerActive("hit", "RepulseTorpHit") then
					luaJM2AddRepulseTorpListener()
					if not IsUnitUntouchable(Mission.Repulse) then
						AddUntouchableUnit(Mission.Repulse)
					end
				end

				luaJM2NellListener()


				if not Mission.Repulse.Dead then
					luaObj_AddUnit("primary",3,Mission.Repulse)
					--luaObj_AddReminder("primary",3)
					DisplayUnitHP({Mission.Repulse}, "ijn02.obj_p3")
					--luaObj_AddReminder("secondary",1)
					--luaJumpinMovieSetCurrentMovie("GoAround",Mission.Repulse.ID)
				end
			end
		else
			if luaObj_GetSuccess("primary",3) == nil and Mission.Repulse.Dead then
				if Mission.Repulse.KillReason ~= "exitzone" then
					if IsListenerActive("command","NellRetreat") then
						RemoveListener("command","NellRetreat")
					end

					HideUnitHP()
					HideScoreDisplay(1,0)
					--CheatMaxRepair(Mission.Repulse)
					luaObj_Completed("primary",3)
					Blackout(true, "luaJM2ShowDeadRepulse", 2)
				else
					Mission.MissionFailed = true
					Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
					luaJM2StepPhase(99)
				end
			else
				if not Mission.ThirdReminderAdded then
					Mission.ThirdReminderAdded = true
				end
				--luaObj_Reminder("primary",3)
			end
		end

	elseif Mission.MissionPhase == 99 then

		if Mission.MissionFailed then
			HideUnitHP()
			HideScoreDisplay(1,0)

			local unit
			if not Mission.Repulse.Dead then
				unit = Mission.Repulse

			elseif not Mission.PoW.Dead then
				unit = Mission.PoW
			else
				unit = nil
			end

			luaMissionFailedNew(unit, Mission.FailMsg)
			Mission.EndMission = true

		elseif Mission.MissionCompleted then
			--luaJM2EndCam2()
			--[[luaJM2StartDialog("Final")

			--luaObj_Add("hidden",1)

			if not Mission.ReinfIn then --sec completed
				--luaObj_Add("hidden",1)
				--luaObj_Completed("hidden",1)
				luaObj_Completed("hidden",1)
			end

			if Mission.MaxSpawns > 15 then
				luaObj_Completed("hidden",1)
			end

			if not Mission.Repulse.TrulyDead then
				luaMissionCompletedNew(Mission.Repulse, "ijn02.obj_missioncompleted") --Mission completed
			else
				local unit = GetSelectedUnit()
				if not unit or unit.Dead then
					unit = luaPickRnd(recon[PARTY_JAPANESE].own.levelbomber)
				end
				luaMissionCompletedNew(unit, "ijn02.obj_missioncompleted") --Mission completed
			end
		end

		luaJM2StepPhase()]]--
		end
	end
end

function luaJM2StepPhase(phase)
	if phase then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end

	Mission.FirstRun = true
end

function luaJM2CheckPlanes()
	--Spawn
	--luaLog("------------------luaJM2CheckPlanes called-----------------")
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.levelbomber) do
		if not unit.Dead then
			local ammo = GetProperty(unit, "ammoType")
			local selected = GetSelectedUnit()

			--luaLog("\tselectedID")
			if selected == nil then
				--luaLog("\tnil")
			else
				--luaLog("\t"..selected.ID)
			end
			--luaLog("\tammo")
			--luaLog("\t"..tostring(ammo))

			if ammo == 0 and (selected == nil or selected.ID ~= unit.ID) and not unit.AICtrl then
				--luaLog("\tsending "..unit.ID.." home")
				unit.AICtrl = true
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				PilotRetreat(unit)
			elseif ammo == 0 and selected and selected.ID == unit.ID then
				if not unit.retreatDlg then
					luaJM2RetreatHint()
					unit.retreatDlg = true
				end
			end
		end
	end
end



function luaJM2CheckShips()
	--Mission.AlliedGroup = luaRemoveDeadsFromTable(Mission.AlliedGroup)

	if Mission.PoW and not Mission.PoW.Dead then
		if IsInBorderZone(Mission.PoW) then
			Mission.MissionFailed = true
			--Mission.EndMission = true
			Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
			luaJM2StepPhase(99)
		end
	elseif not Mission.PoW or Mission.PoW.Dead then
		if Mission.PoW.KillReason == "exitzone" then
			Mission.MissionFailed = true
			--Mission.EndMission = true
			Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
			luaJM2StepPhase(99)
		end
	end


	if Mission.Repulse and not Mission.Repulse.Dead then
		if IsInBorderZone(Mission.Repulse) then
			Mission.MissionFailed = true
			--Mission.EndMission = true
			Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
			luaJM2StepPhase(99)
		end
	elseif not Mission.Repulse or Mission.Repulse.Dead then
		if Mission.Repulse.KillReason == "exitzone" then
			Mission.MissionFailed = true
			--Mission.EndMission = true
			Mission.FailMsg = "ijn02.obj_missionfailed_2" --Allied ships exited the mission area
			luaJM2StepPhase(99)
		end
	end


	--[[if not Mission.PoW.Dead then
		if IsInBorderZone(Mission.PoW) then
			Mission.AlliedShipExited = true
			return
		else
			if Mission.MissionPhase == 1 and Mission.ReconsAllowed then
				luaJM2CheckReconplanes(Mission.PoW)
			end
		end
	else
		if Mission.PoW.KillReason == "exitzone" then
			Mission.AlliedShipExited = true
			return
		end
	end

	if not Mission.Repulse.Dead then
		if IsInBorderZone(Mission.Repulse) then
			Mission.AlliedShipExited = true
			return
		else
			if (Mission.MissionPhase == 2 or Mission.MissionPhase == 3) and Mission.ReconsAllowed then
				luaJM2CheckReconplanes(Mission.Repulse)
			end
		end
	else
		if Mission.Repulse.KillReason == "exitzone" then
			Mission.AlliedShipExited = true
			return
		end
	end]]



end

function luaJM2CheckBuffalos()

	if Mission.PoW.Dead and Mission.Repulse.Dead then
		return
	end

	if not Mission.PoW.Dead then
		Mission.BuffaloGrp1 = luaRemoveDeadsFromTable(Mission.BuffaloGrp1)
		--luaLog("Allowed planes: "..tostring(Mission.MaxBuffalosInAir1))
		--luaLog("No. of planes in table1 "..tostring(table.getn(Mission.BuffaloGrp1)))
		if table.getn(Mission.BuffaloGrp1) < Mission.MaxBuffalosInAir1 then
			if not SpawnNewIDIsRequested(Mission.BuffaloSpawnReq) then
				luaJM2SpawnBuffalos(1)
			end
		end
		Mission.AirPatrol1 = luaAirPatrol(Mission.PoW, 1000, 3000, Mission.BuffaloGrp1, Mission.AirPatrol1)
	else
		Mission.BuffaloGrp1 = luaRemoveDeadsFromTable(Mission.BuffaloGrp1)
		if table.getn(Mission.BuffaloGrp1) > 0 then
			for idx,unit in pairs(Mission.BuffaloGrp1) do
				table.remove(Mission.BuffaloGrp1, idx)
				if not unit.Dead then
					table.insert(Mission.BuffaloGrp2, unit)
				end
			end
			if not Mission.Repulse.Dead then
				Mission.AirPatrol2 = luaAirPatrol(Mission.Repulse, 1000, 3000, Mission.BuffaloGrp2, Mission.AirPatrol2)
			end
		end
	end

	if not Mission.Repulse.Dead then
		Mission.BuffaloGrp2 = luaRemoveDeadsFromTable(Mission.BuffaloGrp2)
		--luaLog("No. of planes in table2: "..tostring(table.getn(Mission.BuffaloGrp2)))
		--luaLog("Allowed planes: "..tostring(Mission.MaxBuffalosInAir2))
		if table.getn(Mission.BuffaloGrp2) < Mission.MaxBuffalosInAir2 then
			if not SpawnNewIDIsRequested(Mission.BuffaloSpawnReq) then
				luaJM2SpawnBuffalos(2)
			end
		end
		Mission.AirPatrol2 = luaAirPatrol(Mission.Repulse, 1000, 3000, Mission.BuffaloGrp2, Mission.AirPatrol2)
	else
		Mission.BuffaloGrp2 = luaRemoveDeadsFromTable(Mission.BuffaloGrp2)
		if table.getn(Mission.BuffaloGrp2) > 0 then
			for idx,unit in pairs(Mission.BuffaloGrp2) do
				table.remove(Mission.BuffaloGrp2, idx)
				if not unit.Dead then
					table.insert(Mission.BuffaloGrp1, unit)
				end
			end
			if not Mission.PoW.Dead then
				Mission.AirPatrol1 = luaAirPatrol(Mission.PoW, 1000, 3000, Mission.BuffaloGrp1, Mission.AirPatrol1)
			end
		end
	end
end

function luaJM2SpawnBuffalos(grp)
	local clb = {
		"luaJM2BuffaloSpawned1",
		"luaJM2BuffaloSpawned2"
	}
	local refPos = {
		Mission.PoW,
		Mission.Repulse
	}

	local spawnPoint = luaJM2GetClosestSpawnPoint(refPos[grp])
	if not spawnPoint then
		--luaLog("Got an invalid spawnPoint for Buffalo spawn, returning")
		return
	else
		spawnPoint.y = 400
	end

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 133,
			["Name"] = "F2A Buffalo",
			["Crew"] = 1,
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = spawnPoint,
		--["angleRange"] = { -1, 1 },
		["angleRange"] = { 2.4, 4 },
	},
	["callback"] = clb[grp],
	["id"] = Mission.BuffaloSpawnReq,
})
end

function luaJM2BuffaloSpawned1(unit)
	--luaLog("luaJM2BuffaloSpawned1 called")

	if not Mission.BuffaloDlg then
	 luaJM2StartDialog("Buffalos_Incomm1",true)
	 luaJM2StartDialog("Buffalos_Incomm2",true)
	 Mission.BuffaloDlg = true
	end

	table.insert(Mission.BuffaloGrp1, unit)
	Mission.AirPatrol1 = luaAirPatrol(Mission.PoW, 1000, 3000, Mission.BuffaloGrp1, Mission.AirPatrol1)

	if not Mission.BomberListener then
		luaJM2AddFighterKillListener()
		luaJM2StartDialog("EnemyBuffalo")
	end
end

function luaJM2BuffaloSpawned2(unit)
	--luaLog("luaJM2BuffaloSpawned2 called")
	table.insert(Mission.BuffaloGrp2, unit)
	Mission.AirPatrol2 = luaAirPatrol(Mission.Repulse, 1000, 3000, Mission.BuffaloGrp2, Mission.AirPatrol2)
	if not Mission.BomberListener then
		luaJM2AddFighterKillListener()
		luaJM2StartDialog("EnemyBuffalo")
	end
end

function luaJM2CheckReinf()
	if not Mission.ReinfIn then
		if not SpawnNewIDIsRequested(Mission.ReinfSpawnReq) then
			luaJM2SpawnReinforcements()
		end
	end

	Mission.ReinfGrp = luaRemoveDeadsFromTable(Mission.ReinfGrp)
	if table.getn(Mission.ReinfGrp) == 0 then
		return
	end

	for idx,unit in pairs(Mission.ReinfGrp) do

		if not Mission.DDDialog then
			local planesAround = luaGetPlanesAround(unit, 1500, "enemy")
			if planesAround then
				luaJM2StartDialog("DDAA")
				Mission.DDDialog = true
			end
		end

		if not IsInFormation(unit) then
			if not Mission.Repulse.Dead then
				JoinFormation(unit, Mission.Repulse)
			elseif not Mission.PoW.Dead then
				JoinFormation(unit, Mission.PoW)
			end
		end
	end

end

function luaJM2SpawnReinforcements()

	local spawnPoint
	if not Mission.Repulse.Dead then
		spawnPoint = luaJM2GetClosestSpawnPoint(Mission.Repulse)
	elseif not Mission.PoW.Dead then
		spawnPoint = luaJM2GetClosestSpawnPoint(Mission.PoW)
	else
		return
	end

	if not spawnPoint then
		--luaLog("Got an invalid spawnPoint for reinf spawn, returning")
		return
	end

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 265,
			["Name"] = "HMS Wager",
			["Crew"] = 1,
			["Race"] = USA,
		},
		{
			["Type"] = 25,
			["Name"] = "HMS Tenedos",
			["Crew"] = 1,
			["Race"] = USA,
		},
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = spawnPoint,
		--["angleRange"] = { -1, 1 },
		["angleRange"] = { 2.4, 4 },
	},
	["callback"] = "luaJM2ReinforcementsSpawned",
	["id"] = Mission.ReinfSpawnReq,
})
end

function luaJM2ReinforcementsSpawned(unit1, unit2)
	table.insert(Mission.ReinfGrp, unit1)
	table.insert(Mission.ReinfGrp, unit2)

	SetGuiName(unit1, "ingame.shipnames_wager")
	SetGuiName(unit2, "ingame.shipnames_tenedos")

	SetNumbering(unit1, 0)
	SetNumbering(unit2, 0)

	Mission.AlliedGroup = luaRemoveDeadsFromTable(Mission.AlliedGroup)

	if IsInFormation(unit1) then
		LeaveFormation(unit1)
	end

	if IsInFormation(unit2) then
		LeaveFormation(unit2)
	end

	luaDelay(luaJM2ReinfFormation, 2)

	Mission.ReinfIn = true
	luaJM2StartDialog("ReinfIn1",true)
	luaJM2StartDialog("ReinfIn2",true)
	luaJM2StartDialog("DDIN",true)
end

function luaJM2ReinfFormation()
	for i,v in pairs(luaRemoveDeadsFromTable(Mission.ReinfGrp)) do
		if Mission.PoW and not Mission.PoW.Dead then
			JoinFormation(v, Mission.PoW)
		elseif Mission.Repulse and not Mission.Repulse.Dead then
			JoinFormation(v, Mission.Repulse)
		end

		AAEnable(v, true)
		SetFireTarget(v, Mission.PlayerNell)
		--NavigatorMoveToRange(v, Mission.Repulse)
	end
end

function luaJM2BettyListener(unit)
	if unit and not unit.Dead then
		Mission.BettyID = unit.ID
		AddListener("command", "BettyRetreat", {
			["callback"] = "luaJM2BettyRetreat",  -- callback fuggveny
			["entity"] = {unit}, -- entityk akiken a listener aktiv
			["target"] = {}, -- a vizsgalt command celpontja
			["command"] = {"retreat"}, -- vizsgalt command pl. moveonpath
			["status"] = {}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
			})
		Mission.BettyListenerActive = true
	end
end

function luaJM2BettyRetreat()
	--if GetSelectedUnit().ID ~= Mission.PlayerBetty.ID then
	if Mission.PlayerBetty.AICtrl then
		--luaLog("Betty retreat was initiated by the AI")
		--return
	else
		SetRoleAvailable(Mission.PlayerBetty, EROLF_ALL, PLAYER_AI)
		--MissionNarrativeEnqueue("G4M Betty is heading home")
		luaJM2AddNarrative("ijn02.betty_home") --G4M Betty is heading home
	end

	--luaLog("Removing listener, retreat")
	if IsListenerActive("command", "BettyRetreat") then
		RemoveListener("command", "BettyRetreat")
		Mission.BettyListenerActive = false
	end

	if not SpawnNewIDIsRequested(Mission.PlayerPlaneReq) then
		--luaLog("Spawning a new Betty, player retreated")
		luaJM2CheckSpawnPoints()
	else
		--luaLog("Betty spawn in progress")
	end

end

function luaJM2NellListener()
	--Mission.NellID = unit.ID
	if not Mission.NellListenerActive and Mission.PlayerNell and not Mission.PlayerNell.Dead then
		AddListener("command", "NellRetreat", {
			["callback"] = "luaJM2NellRetreat",  -- callback fuggveny
			["entity"] = {Mission.PlayerNell}, -- entityk akiken a listener aktiv
			["target"] = {}, -- a vizsgalt command celpontja
			["command"] = {"retreat"}, -- vizsgalt command pl. moveonpath
			["status"] = {}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
			})
			Mission.NellListenerActive = true
	end
end

function luaJM2NellRetreat()
	--if GetSelectedUnit().ID ~= Mission.PlayerNell.ID then
	if Mission.PlayerNell.AICtrl then
		--luaLog("Nell retreat was initiated by the AI")
		--return
	else
		SetRoleAvailable(Mission.PlayerNell, EROLF_ALL, PLAYER_AI)
		--MissionNarrativeEnqueue("G3M Nell is heading home")
		luaJM2AddNarrative("ijn02.nell_home") --G3M Nell is heading home
	end

	--luaLog("Removing listener, retreat")
	if IsListenerActive("command", "NellRetreat") then
		RemoveListener("command", "NellRetreat")
		Mission.NellListenerActive = false
	end

	if not SpawnNewIDIsRequested(Mission.PlayerPlaneReq) then
		--luaLog("Spawning a new Nell, player retreated")
		luaJM2CheckSpawnPoints()
	else
		--luaLog("Nell spawn in progress")
	end
end


function luaJM2CheckPlayerPlane()

	if Mission.MissionPhase == 1 then
		if Mission.PlayerBetty.Dead then
			--luaLog("Player's unit is dead")
			if not SpawnNewIDIsRequested(Mission.PlayerPlaneReq) then
				--luaLog("Spawning a new plane, players plane is dead")
				luaJM2CheckSpawnPoints()
			else
				--luaLog("Spawn in progress")
			end
		end
	elseif Mission.MissionPhase == 3 then
		if Mission.PlayerNell.Dead then
			--luaLog("Player's unit is dead")
			if not SpawnNewIDIsRequested(Mission.PlayerPlaneReq) then
				--luaLog("Spawning a new plane, players plane is dead")
				luaJM2CheckSpawnPoints()
			else
				--luaLog("Spawn in progress")
			end
		end
	end
end

function luaJM2SpawnPlayerPlane(point)

--luaLog("spawning playerplane")

local grpTbl
	if Mission.MissionPhase == 1 then
		grpTbl = {
			["Type"] = 167,
			["Name"] = "G4M Betty",
			["Crew"] = 1,
			["Race"] = JAPAN,
			["WingCount"] = 3,
			["Equipment"] = 1,
		}
	else
--[[		if type == 1 then
--[[			grpTbl = {
				["Type"] = 167,
				["Name"] = "G4M Betty",
				["Crew"] = 1,
				["Race"] = JAPAN,
				["WingCount"] = 3,
				["Equipment"] = 1,
			}]]
			return
		else]]
			grpTbl = {
				["Type"] = 166,
				["Name"] = "G3M Nell",
				["Crew"] = 2,
				["Race"] = JAPAN,
				["WingCount"] = 3,
				["Equipment"] = 2,
			}
		--end
	end

	local lookAt

	if not Mission.PoW.Dead then
		lookAt = GetPosition(Mission.PoW)
	elseif not Mission.Repulse.Dead then
		lookAt = GetPosition(Mission.Repulse)
	elseif Mission.AlliedGroup then
		local posz = GetPosition(luaPickRnd(Mission.AlliedGroup))
		lookAt = posz
	else
		lookAt = {["x"]=0,["y"]=0,["z"]=0}
	end

	local refPos = GetPosition(point)
	if grpTbl.Type == 167 then
		refPos.y = 500
		--luaLog("Betty spawn setting ref y coord to 500")
	else
		refPos.y = 150
		--luaLog("Nell spawn setting ref y coord to 150")
	end

	--luaLog(refPos)

SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		grpTbl,
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 0,
		["enemyHorizontal"] = 0,
		["ownVertical"] = 0,
		["enemyVertical"] = 0,
		["formationHorizontal"] = 0,
	},
	["area"] = {
		["refPos"] = refPos,
		["angleRange"] = { DEG(-90), DEG(90) },
		["lookAt"] = lookAt,
	},
	["callback"] = "luaJM2PlayerSpawned",
	["id"] = Mission.PlayerPlaneReq,
})
end

function luaJM2PlayerSpawned(unit)
	--luaLog("---------luaJM2PlayerSpawned-----------")
	--luaLog("\tposition")
	--luaLog(GetPosition(unit))

	SquadronSetSpeed(unit, 80)
	SquadronSetTravelSpeed(unit, 80)

	Mission.MaxSpawns = Mission.MaxSpawns - 1

	if Mission.MaxSpawns <= 0 then
		--Mission.SpawnLimitReached = true
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn02.obj_missionfailed_1" --No more japanese units to spawn
		luaJM2StepPhase(99)
		return
	else
		--MissionNarrativeEnqueue(tostring(Mission.MaxSpawns).." units left to spawn")
		--luaJM2AddNarrative(tostring(Mission.MaxSpawns).." squadron(s) remaining")
		if not Mission.PlayerPlaneDlg and Mission.MaxSpawns <= 1 then
			luaJM2StartDialog("StockLow1")
			luaJM2StartDialog("StockLow2")
			Mission.PlayerPlaneDlg = true
		end
	end

	--[[if Mission.MissionPhase == 1 then
		luaJM2ResurrectWingman()
	end]]

	--[[if unit.Class.ID == 166 and not luaIsEntityTable({Mission.PlayerNell}) then
		luaJM2NellHint()
	end]]

	local selected = GetSelectedUnit()
	local unitcommand = "retreat"
	if selected then
		unitcommand = GetProperty(selected, "unitcommand")
	end

	if unit.Class.ID == 166 and luaIsEntityTable({Mission.PlayerNell}) then
		--luaLog("Spawned Nell")
		if not selected or unitcommand == "retreat" then
			if Mission.PlayerNell.Dead or not IsUnitSelectable(Mission.PlayerNell) then
				--SetSelectedUnit(unit)
				local trg
				if not Mission.Repulse.Dead then
					trg = Mission.Repulse
				elseif Mission.Repulse.Dead and not Mission.PoW.Dead then
					trg = Mission.PoW
				end
				--luaLog("Move trg is")
				--luaLog(trg)
				if trg and not trg.Dead then
					--luaLog(unit.Name.." is goint to "..trg.Name)
					PilotMoveToRange(unit, trg)
				end
				luaJM2JumpToUnit(unit)
			end
		end
	else
		if luaIsEntityTable({Mission.PlayerBetty}) then
		--luaLog("Spawned Betty")
			if not selected or unitcommand == "retreat" then
				if Mission.PlayerBetty.Dead or not IsUnitSelectable(Mission.PlayerBetty) then
					--SetSelectedUnit(unit)
					local trg
					if not Mission.Repulse.Dead then
						trg = Mission.Repulse
					elseif Mission.Repulse.Dead and not Mission.PoW.Dead then
						trg = Mission.PoW
					end
					--luaLog("Move trg is")
					--luaLog(trg)
					if trg and not trg.Dead then
						if Mission.MissionPhase ~= 2 then
							PilotMoveToRange(unit, trg)
							--luaLog(unit.Name.." is goint to "..trg.Name)
						end
					end
					luaJM2JumpToUnit(unit)
				end
			end
		end
	end

	if string.find(unit.Name,"Betty") or string.find(unit.Name,"Ohka") then
		if Mission.BettyListenerActive or Mission.PlayerBetty.Dead then
			RemoveListener("command","BettyRetreat")
			Mission.BettyListenerActive = false
		end
		Mission.PlayerBetty = unit
		luaJM2BettyListener(unit)
		if Mission.MissionPhase == 1 then
			if Mission.BettyBombListener then
				RemoveListener("ammoType", "BettyBomb")
				Mission.BettyBombListener = false
			end
			luaJM2AddBettyBmbListener(unit)
		end
		SquadronSetTravelAlt(unit,500,true)
		SquadronSetAttackAlt(unit,500,true)
	else
		if Mission.NellListenerActive or Mission.PlayerNell.Dead then
			RemoveListener("command","NellRetreat")
			Mission.NellListenerActive = false
		end
		Mission.PlayerNell = unit
		luaJM2NellListener()
		SquadronSetTravelAlt(unit,150,true)
		--SquadronSetAttackAlt(unit,20,true)
	end
	--AddUntouchableUnit(unit)
end

function luaJM2SpawnAISquaron(point,spawnType)
	--luaLog("-----------luaJM2SpawnAISquaron---------------")
	--luaLog(spawnType)

	local grpTbl = {
		["Type"] = 167,
		["Name"] = "G4M Betty",
		["Crew"] = 1,
		["Race"] = JAPAN,
		["WingCount"] = 3,
		["Equipment"] = 1,
	}

	local cbs = {"luaJM2AISpawned1","luaJM2AISpawned2","luaJM2AISpawned3"}

	local lookAt

	if not Mission.PoW.Dead then
		lookAt = GetPosition(Mission.PoW)
	elseif not Mission.Repulse.Dead then
		lookAt = GetPosition(Mission.Repulse)
	elseif Mission.AlliedGroup then
		local posz = GetPosition(luaPickRnd(Mission.AlliedGroup))
		lookAt = posz
	else
		lookAt = {["x"]=0,["y"]=0,["z"]=0}
	end

SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		grpTbl,
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = GetPosition(point),
		["angleRange"] = { DEG(0), DEG(180) },
		["lookAt"] = lookAt,
	},
	["callback"] = cbs[spawnType],
	["id"] = Mission.AIPlaneReq,
})
end

function luaJM2AISpawned1(unit)
	--luaLog("aispawned 1 called")
	Mission.Squadron1 = unit
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	local trg = {}
	if not Mission.Repulse.Dead then
		table.insert(trg, Mission.Repulse)
	end
	if not Mission.PoW.Dead then
		table.insert(trg, Mission.PoW)
	end
	local target = luaPickRnd(trg)
	if target then
		luaSetScriptTarget(Mission.Squadron1, target)
		PilotSetTarget(Mission.Squadron1, target)
	end
	SquadronSetTravelAlt(unit,500,true)
	SquadronSetAttackAlt(unit,500,true)
end

function luaJM2AISpawned2(unit)
	--luaLog("aispawned 2 called")
	Mission.Squadron2 = unit
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	local trg = {}
	if not Mission.Repulse.Dead then
		table.insert(trg, Mission.Repulse)
	end
	if not Mission.PoW.Dead then
		table.insert(trg, Mission.PoW)
	end
	local target = luaPickRnd(trg)
	if target then
		luaSetScriptTarget(Mission.Squadron2, target)
		PilotSetTarget(Mission.Squadron2, target)
	end
	SquadronSetTravelAlt(unit,500,true)
	SquadronSetAttackAlt(unit,500,true)
end

function luaJM2AISpawned3(unit)
	--luaLog("aispawned 3 called")
	Mission.Squadron3 = unit
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	local trg = {}
	if not Mission.Repulse.Dead then
		table.insert(trg, Mission.Repulse)
	end
	if not Mission.PoW.Dead then
		table.insert(trg, Mission.PoW)
	end
	local target = luaPickRnd(trg)
	if target then
		luaSetScriptTarget(Mission.Squadron3, target)
		PilotSetTarget(Mission.Squadron3, target)
	end
	SquadronSetTravelAlt(unit,500,true)
	SquadronSetAttackAlt(unit,500,true)
end

function luaJM2HiddenTimer()
	--luaDelay(luaJM2StepPhase, Mission.ReinfTimer)
	luaDelay(luaJM2CheckReinf, Mission.ReinfTimer)
end

function luaJM2GetClosestSpawnPoint(target)

	local playerBomber = GetSelectedUnit()

	if playerBomber == nil then
		--luaLog("playerBomber is nil")
	else
		--luaLog("playerBomber:")
		--luaLog(playerBomber.Name)
		--luaLog(playerBomber.ID)
		--luaLog("Dead?: "..tostring(playerBomber.Dead))
	end

	local dist = 10000000
	local closest

	for idx,coord in pairs(Mission.SpawnPoints) do
		local calcDist = luaGetDistance(target, coord)
		if playerBomber and not playerBomber.Dead then
			if not luaIsVisibleCoordinate(playerBomber, GetPosition(coord)) then
				--luaLog("playerBomber is active, checked coord is not visible")
				--luaLog("Checking coord: "..coord.Name)
				if calcDist < dist then
					closest = coord
					dist = calcDist
				end
			end
		elseif not playerBomber then
			--luaLog("playerBomber is not active")
			--luaLog("Checking coord: "..coord.Name)
			if calcDist < dist then
				closest = coord
				dist = calcDist
			end
		else
			--luaLog("Coordinate is visible for player")
		end
	end

	if closest then
		--luaLog("Found a valid spawn coordinate: "..closest.Name)
		return GetPosition(closest)
	else
		--luaLog("No valid spawn coordinate")
		return false
	end
end

function luaJM2SeparateFormation()
	Mission.AlliedGroup = luaRemoveDeadsFromTable(Mission.AlliedGroup)

	for idx,unit in pairs(Mission.AlliedGroup) do
		LeaveFormation(unit)
		--luaLog(unit.Name.." leaves formation")
	end

	luaDelay(luaJM2NewFormations, 2)
end

function luaJM2NewFormations()

	local dests = {}
	local paths = {}
	table.insert(paths, FindEntity("RoyalNavyPath1"))
	table.insert(paths, FindEntity("RoyalNavyPath2"))
	table.insert(paths, FindEntity("RoyalNavyPath3"))

	for idx,unit in pairs(Mission.AlliedGroup) do
		if unit.Class.Type == "Destroyer" then
			table.insert(dests, unit)
		end
	end

	if not Mission.PoW.Dead and not Mission.Repulse.Dead then

		local num = math.floor(table.getn(dests)/2)
		--local cmd
		for idx,unit in pairs(dests) do
			if idx <= num then
				--luaLog(unit.Name.." joins to PoW")
				JoinFormation(unit, Mission.PoW)
				--cmd = GetProperty(unit, "unitcommand")
				--luaLog("its cmd: "..cmd)
			else
				--luaLog(unit.Name.." joins to Repulse")
				JoinFormation(unit, Mission.Repulse)
				--cmd = GetProperty(unit, "unitcommand")
				--luaLog("its cmd: "..cmd)
			end
		end

		local rnd = luaRnd(1,3)
		NavigatorMoveOnPath(Mission.PoW, paths[rnd])
		table.remove(paths, rnd)
		NavigatorMoveOnPath(Mission.Repulse, luaPickRnd(paths))

	elseif not Mission.PoW.Dead and Mission.Repulse.Dead then

		--local cmd
		for idx,unit in pairs(dests) do
			--luaLog(unit.Name.." joins to PoW")
			JoinFormation(unit, Mission.PoW)
			--cmd = GetProperty(unit, "unitcommand")
			--luaLog("its cmd: "..cmd)
		end

		NavigatorMoveOnPath(Mission.PoW, luaPickRnd(paths))

	elseif Mission.PoW.Dead and not Mission.Repulse.Dead then

		--local cmd
		for idx,unit in pairs(dests) do
			--luaLog(unit.Name.." joins to Repulse")
			JoinFormation(unit, Mission.Repulse)
			--cmd = GetProperty(unit, "unitcommand")
			--luaLog("its cmd: "..cmd)
		end

		NavigatorMoveOnPath(Mission.Repulse, luaPickRnd(paths))

	end

	--[[
	for idx,unit in pairs(Mission.AlliedGroup) do
		local cmd
		if unit.Class.Type == "Destroyer" then
			cmd = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  			luaLog(unit.Name.."'s cmd: "..cmd)
		end
	end
	]]

	luaJM2StartDialog("Split1")
	luaJM2StartDialog("Split2")
	luaJM2StartDialog("Split3")
end

function luaJM2CheckSpawnPoints(spawnType,aispawn)
	--luaLog("luaJM2CheckSpawnPoints called "..debug.traceback())
	--luaLog("params: "..tostring(spawnType).." "..tostring(aispawn))
	local spawnPoint
	if not Mission.PoW.Dead then
		for idx,point in pairs(Mission.PoWSpawns) do
			if point and not point.Dead and not IsInBorderZone(GetPosition(point)) then
				spawnPoint = point
				break
			end
		end
	else
		for idx,point in pairs(Mission.RepulseSpawns) do
			if point and not point.Dead and not IsInBorderZone(GetPosition(point)) then
				spawnPoint = point
				break
			end
		end
	end

	if not spawnPoint then
		--luaLog("NOT SPAWNPOINT")
		return
	end

	--luaLog("spawnPoint")
	--luaLog(spawnPoint)
	if aispawn then
		luaJM2SpawnAISquaron(spawnPoint,spawnType)
		--luaLog("aispawn in luaJM2CheckSpawnPoints")
		--luaLog(spawnType)
	else
		luaJM2SpawnPlayerPlane(spawnPoint)
	end
end

function luaJM2CheckSpawns()
--[[	if Mission.PlayerBetty.Dead then
		luaJM2CheckSpawnPoints()
	end

	if Mission.MissionPhase == 3 and (next(Mission.PlayerNell) == nil or Mission.PlayerNell.Dead) then
		luaJM2CheckSpawnPoints()
	end]]--

	--AISQUADRONS
	if Mission.Squadron1 == nil or Mission.Squadron1.Dead then
		if not SpawnNewIDIsRequested(Mission.AIPlaneReq) then
			--luaLog("spawn ai1")
			--luaLog("Squadron1")
			--luaLog(Mission.Squadron1)
			luaJM2CheckSpawnPoints(1,true)
		end
	else
		local ammo = GetProperty(Mission.Squadron1, "ammoType")
		if ammo == 0 then
			PilotRetreat(Mission.Squadron1)
			Mission.Squadron1 = nil
		else
			if luaGetScriptTarget(Mission.Squadron1) == nil or luaGetScriptTarget(Mission.Squadron1).Dead then
				local trg
				if not Mission.PoW.Dead then
					trg = Mission.PoW
				elseif Mission.PoW.Dead and not Mission.Repulse.Dead then
					trg = Mission.Repulse
				end
				if trg then
					PilotSetTarget(Mission.Squadron1, trg)
					luaSetScriptTarget(Mission.Squadron1, trg)
				end
			end
		end
	end

	if Mission.Squadron2 == nil or Mission.Squadron2.Dead then
		if not SpawnNewIDIsRequested(Mission.AIPlaneReq) then
			--luaLog("spawn ai2")
			--luaLog("Squadron2")
			--luaLog(Mission.Squadron2)
			luaJM2CheckSpawnPoints(2,true)
		end
	else
		local ammo = GetProperty(Mission.Squadron2, "ammoType")
		if ammo == 0 then
			PilotRetreat(Mission.Squadron2)
			Mission.Squadron2 = nil
		else
			if luaGetScriptTarget(Mission.Squadron2) == nil or luaGetScriptTarget(Mission.Squadron2).Dead then
				local trg
				if not Mission.PoW.Dead then
					trg = Mission.PoW
				elseif Mission.PoW.Dead and not Mission.Repulse.Dead then
					trg = Mission.Repulse
				end
				if trg then
					PilotSetTarget(Mission.Squadron2, trg)
					luaSetScriptTarget(Mission.Squadron2, trg)
				end
			end
		end
	end

	if Mission.Squadron3 == nil or Mission.Squadron3.Dead then
		if not SpawnNewIDIsRequested(Mission.AIPlaneReq) then
			--luaLog("spawn ai3")
			--luaLog("Squadron3")
			--luaLog(Mission.Squadron3)
			luaJM2CheckSpawnPoints(3,true)
		end
	else
		local ammo = GetProperty(Mission.Squadron3, "ammoType")
		if ammo == 0 then
			PilotRetreat(Mission.Squadron3)
			Mission.Squadron3 = nil
		else
			if luaGetScriptTarget(Mission.Squadron3) == nil or luaGetScriptTarget(Mission.Squadron3).Dead then
				local trg
				if not Mission.PoW.Dead then
					trg = Mission.PoW
				elseif Mission.PoW.Dead and not Mission.Repulse.Dead then
					trg = Mission.Repulse
				end
				if trg then
					PilotSetTarget(Mission.Squadron3, trg)
					luaSetScriptTarget(Mission.Squadron3, trg)
				end
			end
		end
	end
end

function luaJM2FadeIn()
	--SoundFade(1, "",0.1)
	luaCheckMusic()
	luaCheckSavedCheckpoint()
	if not Mission.SavedCheckpoint then
		if not IsListenerActive("hit", "RepulseHit") then
			luaJM2AddRepulseListener()
		end

		Blackout(false, "", 0.5)
	end
end

function luaJM2CheckListing()
	if Mission.ListingDlg then
		return
	end

	local hp1 = 1
	local hp2 = 1

	if not Mission.Repulse.Dead then
	 hp1 = GetHpPercentage(Mission.Repulse)
	end

	if not Mission.PoW.Dead then
	 hp2 = GetHpPercentage(Mission.PoW)
	end

	if hp1 <= 0.5 or hp2 <= 0.5 then
		luaJM2StartDialog("BBListing1",true)
		luaJM2StartDialog("BBListing2",true)
	end

	if hp1 <= 0.35 or hp2 <= 0.35 then
		luaJM2StartDialog("BBLowHP")
		Mission.ListingDlg = true
		return
	end

end

function luaJM2CheckPoWFailures(unit)

	local index = table.getn(Mission.RndFailures)

	if index == 0 then
		return
	end

	if not unit or unit.Dead then
		return
	end


	local rndFailure = random(1,4)
	if rndFailure <= 2 then
		local failureNum = random(1,index)
		if Mission.RndFailures[failureNum] == "Fire" then
			local pos = GetPosition(unit)
			pos.y = 15
			Effect("BigFire", pos, unit)
		elseif Mission.RndFailures[failureNum] == "EngineJam" then
			SetFailure(unit, "EngineJam", 10)
			if not Mission.PoW.Dead then
				luaJM2StartDialog("BBEngine1",true)
				luaJM2StartDialog("BBEngine2",true)
			end
		elseif Mission.RndFailures[failureNum] == "Explosion" then
			SetFailure(unit, "explosion", DAM_ENGINEROOM, 0, 40, 200, 154)
		end
		table.remove(Mission.RndFailures, failureNum)
	end
end

function luaJM2AddRepulseListener()
	if Mission.Repulse and not Mission.Repulse.Dead then
		AddListener("hit", "RepulseHit", {
			["callback"] = "luaJM2NemEzek",
			["targetDevice"] = {},
			["target"] = {Mission.Repulse},
			["attacker"] = {},
			["attackType"] = {},
			["attackerPlayerIndex"] = {},
			["damageCaused"] = {},
			["fireCaused"] = {},
			["leakCaused"] = {},
			})
		Mission.RepulseListener = true
	end
end

function luaJM2AddRepulseTorpListener()
	if Mission.Repulse and not Mission.Repulse.Dead then
		AddListener("hit", "RepulseTorpHit", {
			["callback"] = "luaJM2RepulseTorpedo",
			["targetDevice"] = {},
			["target"] = {Mission.Repulse},
			["attacker"] = {},
			["attackType"] = {},
			["attackerPlayerIndex"] = {PLAYER_1},
			["damageCaused"] = {},
			["fireCaused"] = {},
			["leakCaused"] = {},
			})
		Mission.RepulseListener = true
	end
end

function luaJM2AddPoWListener()
	if Mission.PoW and not Mission.PoW.Dead then
		AddListener("hit", "PoWHit", {
			["callback"] = "luaJM2PoWHit",
			["targetDevice"] = {},
			["target"] = {Mission.PoW},
			["attacker"] = {},
			["attackType"] = {},
			["attackerPlayerIndex"] = {PLAYER_1},
			["damageCaused"] = {},
			["fireCaused"] = {},
			["leakCaused"] = {},
			})
		Mission.PoWListener = true
	end
end

function luaJM2StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM2StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM2StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
		--luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM2CheckFailDlgs()

	if Mission.MissionPhase == 1 and Mission.Failrun <= 4 then
		if not Mission.HitTrue then
			luaJM2StartDialog("RunFailed"..tostring(Mission.Failrun),true)
			Mission.Failrun = Mission.Failrun + 1
		end
	end
end

function luaJM2AddBettyBmbListener()
	if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
		AddListener("ammoType", "BettyBomb", {
			["callback"] = "luaJM2RemainingBmbTime",  -- callback fuggveny
			["entity"] = {Mission.PlayerBetty}, -- entityk akiken a listener aktiv
			["ammoType"] = {0}, -- 0-none, 1-bomb, 2-torpedo, 3-dc, 4-rocket
			})
			Mission.BettyBombListener = true
	end
end

function luaJM2RemainingBmbTime()
	if Mission.BettyBombListener then
		RemoveListener("ammoType", "BettyBomb")
		Mission.BettyBombListener = false
	end

	if not Mission.PlayerBetty.Dead then
		--luaLog("Betty released bombs")
		local playerPlane = GetSelectedUnit()
		local BmbRemainingTime = 5

		if playerPlane and not playerPlane.Dead then
			local sqPlanes = GetSquadronPlanes(Mission.PlayerBetty)
			for idx,planeID in pairs(sqPlanes) do
				if planeID == playerPlane.ID then
					BmbRemainingTime = PlaneBombFallingTime(thisTable[tostring(planeID)])
					--luaLog("bmb remain time "..tostring(BmbRemainingTime))
				end
			end
		end

		luaDelay(luaJM2CheckFailDlgs, BmbRemainingTime)

	end
end

function luaJM2CheckReconplanes(unit)
	if unit and not unit.Dead then
		local num = GetNumCatapulted(unit)
		local inAir = GetLastCatapulted(unit)
		if inAir then
			inAir.LauncherUnitID = unit.ID
		end
		if not inAir and num < 4 and not inAir then
			ShipUseCatapult(unit)
			if not Mission.ReconDlg then
				luaJM2StartDialog("Reconlaunched1",true)
				luaJM2StartDialog("Reconlaunched2",true)
				Mission.ReconDlg = true
			end
		end
	end
end

function luaJM2GetAIPlanes()
	Mission.AIPlanes = {}
	for idx,unit in pairs(recon[PARTY_ALLIED].own.reconplane) do
		if not unit.Dead then
			table.insert(Mission.AIPlanes, unit)
		end
	end
	return Mission.AIPlanes
end

function luJM2CheckReconPlanes()
	if luaRemoveDeadsFromTable(Mission.AIPlanes) == 0 then
		return
	end

	for idx,unit in pairs(Mission.AIPlanes) do
		if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
			local planes = luaGetPlanesAround(unit, 2000, "enemy")
			if planes then
				local trg = luaSortByDistance(unit, planes, true)
				if trg and not trg.Dead then
					PilotSetTarget(unit, trg)
					luaSetScriptTarget(unit, trg)
					unit.BaseFly = false
				end
			else
				if unit.LauncherUnitID and not unit.BaseFly then
					PilotMoveToRange(unit, thisTable[tostring(unit.LauncherUnitID)])
					unit.BaseFly = true
				end
			end
		end
	end
end

function luaJM2AllowRecon()
	Mission.ReconsAllowed = true
end

function luaJM2AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM2RetreatHint()
	MissionNarrativeUrgent("ijn02.hint_1_desc") --Press retreat in the Orders menu to get a new squad
end

function luaJM2NellHint()
	if Mission.MultipleHintDone then
		luaJM2AddNarrative("ijn02.hint_2_desc") --G3M Squadron joins the airstrike - Press 'Switch Unit' to get its control
	else
		Mission.MultipleHintDone = true
	end
	--luaJM2StartDialog("TorpedoSquadron")
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(167)
	PrepareClass(166)
	PrepareClass(133)
	PrepareClass(25)
	PrepareClass(265)
	Loading_Finish()
end

function luaJM2JumpToUnit(unit)
	SetSelectedUnit(unit)
	--Mission.CamScript = luaCamOnTargetFree(unit, 32, 180, 25, true, "noupdate", 3, nil)
end

function luaJM2SelectUnit()
	SetSelectedUnit(Mission.MovieSelUnit)
	Mission.MovieSelUnit = nil
end

function luaJM2AddNarrative(str)
	MissionNarrativeClear()
	MissionNarrativeUrgent(str)
end


function luaJM2SOSDialog()
	luaJM2StartDialog("SOS")
	luaDelay(luaJM2SOSMorseOnlyDialog, random(45,60))
end

function luaJM2SOSMorseOnlyDialog()
	if Mission.Repulse and not Mission.Repulse.Dead then
		luaJM2StartDialog("SOSMorseOnly")
		--luaDelay(luaJM2SOSMorseOnlyDialog, random(15,25))
	end
end

function luaJM2AddFighterKillListener()
	if Mission.FakeNells then
		Mission.FakeNells = luaRemoveDeadsFromTable(Mission.FakeNells)
		AddListener("kill", "PlaneSquadronLost", {
				["callback"] = "luaJM2PlaneSquadronLost",
				["entity"] = Mission.FakeNells,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {PLAYER_AI}, -- [PLAYER_1..PLAYER_8]
		})
		Mission.BomberListener = true
	end
end

function luaJM2PlaneSquadronLost()
	Mission.BombersKilled = Mission.BombersKilled + 1
	if not Mission.BomberLostDlg and Mission.BombersKilled >= 1 then
		luaJM2StartDialog("BomberLost")
		luaJM2StartDialog("EnemyBuffalo1")
		Mission.BomberLostDlg = true
	end

	if Mission.BombersKilled >= 2 then
		luaJM2StartDialog("BomberLost2")
		if IsListenerActive("kill", "PlaneSquadronLost") then
			RemoveListener("kill", "PlaneSquadronLost")
		end
	end
end

function luaJM2IsPlayerNear(entity, target, distance)
	local dist

	if entity and not entity.Dead and target and not target.Dead then
		dist = luaGetDistance(entity, target)
		if dist < distance then
			Mission.PlayerNear = true
			return true
		else
			Mission.PlayerNear = false
			return false
		end
	else
		return
	end
end

function luaJM2GenerateEscort()

	SetSimplifiedReconMultiplier(0.5)

	local pBufName
	local pBName
	local pNName
	local bettySpawn = FindEntity("BettySpawnPoint")

	pBName = luaFindHidden("G4M Betty Torp")
	Mission.PlayerBetty = GenerateObject(pBName.Name, "G4M Betty")

	--PutTo(Mission.PlayerBetty, GetPosition(bettySpawn))

	--SetInvincible(Mission.PlayerBetty, 0.2)
	SquadronSetTravelAlt(Mission.PlayerBetty, 500, true)
	SquadronSetAttackAlt(Mission.PlayerBetty, 500, true)
	UnitHoldFire(Mission.PlayerBetty)
	if Mission.Repulse and not Mission.Repulse.Dead then 
		PilotMoveTo(Mission.PlayerBetty, Mission.Repulse)
	end

	for i=1,4 do
		pNName = luaFindHidden("G3M Nell 0"..i)
		local nell = GenerateObject(pNName.Name, "G3M Nell 0"..i)
		--SetInvincible(nell, 0.2)
		table.insert(Mission.FakeNells, nell)
--		PutTo(nell, GetPosition(FindEntity("BettySpawnPoint 0"..i)))
		SquadronSetTravelAlt(nell, 500, true)
		SetSkillLevel(nell,SKILL_ELITE)
		SetRoleAvailable(nell, EROLF_ALL, PLAYER_AI)
		PilotMoveTo(nell, Mission.Repulse)
	end

	luaJM2OhkaChecker()
	luaJM2GenerateFirstWave()
	luaJM2DramaticCameraMovement(Mission.PlayerBetty, 15)

end

function luaJM2ForceTailGunner()
	local bettys = {}

	bettys = luaGetOwnUnits("plane", PARTY_JAPANESE)

	for idx,plane in pairs(bettys) do
		if plane.Name ~= "G4M Betty Torp" then
			SetRoleAvailable(plane, EROLF_ALL, PLAYER_AI)
		end
	end

	--SetSelectedUnit(Mission.PlayerBetty)
	SetRoleAvailable(Mission.PlayerBetty, EROLF_ALL, PLAYER_1)
	SetRoleAvailable(Mission.PlayerBetty, EROLF_PILOT, PLAYER_AI)
	SquadronForceGunnerMode(Mission.PlayerBetty, true)
	luaJM2EnableControls(false)
	HideScoreDisplay(1,0)
	Blackout(false, "", 1)
end

function luaJM2NemEzek(...)
-- RELEASE_LOGOFF  	luaLog("NEMEZEK")
-- RELEASE_LOGOFF  	luaLog(arg[5])

	if arg[5] ~= PLAYER_1 then
		return
	end

	if IsListenerActive("hit", "RepulseHit") then
		RemoveListener("hit", "RepulseHit")
	end

	SetInvincible(Mission.Repulse, false)
	AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*(0.3*Mission.DiffMul*Mission.DodiSzorzo))
	SetInvincible(Mission.Repulse, true)

	Mission.DroidCounter = Mission.DroidCounter + 1

	if not IsListenerActive("hit", "RepulseHit") then
		luaDelay(luaJM2AddRepulseListener, 15)
	end

	if Mission.DroidCounter == 1 then
		luaJM2StartDialog("NotThisDroid1")
	elseif Mission.DroidCounter == 2 then
		luaJM2StartDialog("NotThisDroid2")
	elseif Mission.DroidCounter >= 3 then
		luaJM2StartDialog("NotThisDroid3")
	end
end

function luaJM2StartFlakManager()
	Mission.FlakManager = CreateScript("luaJM2FakeFlakManager_Init")
end

function luaJM2FakeFlakManager_Init(this)
	--SetDeviceReloadTimeMul(0)
    SetThink(this, "luaJM2FakeFlakManager_think")
end

function luaJM2FakeFlakManager_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		if Mission.FlakManager and not Mission.FlakManager.Dead then
			DeleteScript(Mission.FlakManager)
		end

		return
	end

	--luaLog("fakeflak thinking")

	local unit
	local pos0
	local pos
	local dir
	local dirside
	local dirup
	local rndPos
	local rndDelay
	local rndDb
	local len
	local rx,ry,rz

	if Mission.MissionPhase == 3 then
		unit = Mission.PlayerNell
	elseif Mission.MissionPhase == 1 then
		unit = Mission.PlayerBetty
	end

	if luaJM2IsPlayerNear(unit, Mission.Repulse, 2000) or luaJM2IsPlayerNear(unit, Mission.PoW, 2000) then

		if unit and not unit.Dead then

			pos = GetPosition(unit)
			dir = GetDirection(unit)

-- RELEASE_LOGOFF  --				luaLog("UNITPOS")
-- RELEASE_LOGOFF  --				luaLog(pos)
-- RELEASE_LOGOFF  --				luaLog("UNITDIR")
-- RELEASE_LOGOFF  --				luaLog(dir)

--[[
			pos0 = pos
			dirside = dir
			dirup = dir

			dirside.x = pos.z
--			dirside.y=0
			dirside.z = -pos.x

			len = math.sqrt(dirside.x*dirside.x+dirside.z*dirside.z)
			dirside.x = dirside.x/len
			dirside.z = dirside.z/len

--			dirup.x=dir.y*dirside.z-dir.z*dirside.y
			dirup.x = dir.y*dirside.z
			dirup.y = dir.z*dirside.x-dir.x*dirside.z
--			dirup.z=dir.x*dirside.y-dir.y*dirside.x
			dirup.z = -dir.y*dirside.x

			--luaLog("RANDOM FLAK: "..tostring(rndDb))
-- RELEASE_LOGOFF  --				luaLog("UNITPOS")
-- RELEASE_LOGOFF  --				luaLog(pos)
-- RELEASE_LOGOFF  --				luaLog("UNITDIR")
-- RELEASE_LOGOFF  --				luaLog(dir)


]]

			rndDb = random(30, 60)
			--luaLog("Darab: "..tostring(rndDb))

			for idx=1,rndDb do

				local flakPos = luaJM2GetFlakPos(pos,dir)
				--luaLog("FLAKPOS: ")
				--luaLog(flakPos)

				if flakPos.y > 20 then
					rndDelay = random(10,100)/10
					--luaLog("Delay time: "..tostring(rndDelay))
					luaDelay(luaJM2DelayedEffect, rndDelay, "Effect", "Impact5InchFlak", "Pos", flakPos)
					--luaLog("STARTTIME: "..tostring(GameTime()))
					--luaDelay(luaJM2DelayedLog, rndDelay)
					--Effect("Impact5InchFlak", flakPos)
				end

			end

			local wait = random(10,30)/10
			--luaLog("Wait time set to: "..tostring(wait))
			--luaLog("At: "..tostring(GameTime()))
			SetWait(this, wait)

		end
	end
end

function luaJM2DelayedLog()
	--luaLog("DELAYELT LOG: "..tostring(GameTime()))
end

function luaJM2DelayedEffect(timerthis)
	local fx = timerthis.ParamTable.Effect
	local pos = timerthis.ParamTable.Pos

	--[[luaLog("______________")
-- RELEASE_LOGOFF  	luaLog("DELAYED EFFECT")
-- RELEASE_LOGOFF  	luaLog("ENDTIME: "..GameTime())
-- RELEASE_LOGOFF  	luaLog("______________")]]--

	Effect(fx, pos)
end

function luaJM2GenerateSecondWave()
	local pBufName
		for i=7,9 do
			pBufName = luaFindHidden("F2A Buffalo 0"..i)

			local pos = {["x"]=20,["y"]=0,["z"]=20}
			pos.x = pos.x + random(-100, 100)
			pos.z = pos.z + random(-100, 100)

			local buffalo = GenerateObject(pBufName.Name, "F2A Buffalo")
			table.insert(Mission.SecWaveBuff, buffalo)
			table.insert(Mission.Buff, buffalo)

			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaPutToRecon(buffalo, Mission.PlayerBetty, 250+i*2)
			end
--			PutRelTo(buffalo, FindEntity("BuffaloSpawnPoint 02"), pos)

			SquadronSetTravelAlt(buffalo, 500, true)
			SquadronSetAttackAlt(buffalo, 500, true)
			--SetSkillLevel(buffalo, Mission.SkillLevel)
			SetSkillLevel(buffalo, SKILL_SPNORMAL)
			Mission.FakeNells = luaRemoveDeadsFromTable(Mission.FakeNells)
			if Mission.FakeNells[1] and not Mission.FakeNells[1].Dead then
				luaSetScriptTarget(buffalo, Mission.FakeNells[1])
			elseif Mission.PlayerBetty and not Mission.PlayerBetty.Dead	then
				luaSetScriptTarget(buffalo, Mission.PlayerBetty)
			end
			--luaObj_AddUnit("secondary",1,buffalo)
		end

		for i=10,11 do
			pBufName = luaFindHidden("F2A Buffalo "..i)

			local pos = {["x"]=20,["y"]=0,["z"]=20}
			pos.x = pos.x + random(-100, 100)
			pos.z = pos.z + random(-100, 100)

			local buffalo = GenerateObject(pBufName.Name, "F2A Buffalo")
			table.insert(Mission.SecWaveBuff, buffalo)
			table.insert(Mission.Buff, buffalo)

			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaPutToRecon(buffalo, Mission.PlayerBetty, 250+i*5)
			end
--			PutRelTo(buffalo, FindEntity("BuffaloSpawnPoint 02"), pos)

			SquadronSetTravelAlt(buffalo, 500, true)
			SquadronSetAttackAlt(buffalo, 500, true)
			--SetSkillLevel(buffalo, Mission.SkillLevel)
			SetSkillLevel(buffalo, SKILL_SPNORMAL)
			Mission.FakeNells = luaRemoveDeadsFromTable(Mission.FakeNells)
			if Mission.FakeNells[2] and not Mission.FakeNells[2].Dead then
				luaSetScriptTarget(buffalo, Mission.FakeNells[2])
			elseif Mission.PlayerBetty and not Mission.PlayerBetty.Dead	then
				luaSetScriptTarget(buffalo, Mission.PlayerBetty)
			end
			--luaObj_AddUnit("secondary",1,buffalo)
		end


		--[[for idx,squad in pairs(Mission.SecWaveBuff) do
			PutRelTo(squad ,Mission.PlayerBetty, {["x"]=100,["y"]=100,["z"]=500})
		end]]

		if not IsListenerActive("recon", "bufflist") and not IsListenerActive("kill", "buffkill") then
			luaJM2AddBuffaloListener()
		end

		--luaObj_AddReminder("secondary",1)
		--Mission.SecondWaveGenerated = true
end

function luaJM2IsPlayerInArea(area)
	local pos = GetPosition(Mission.PlayerBetty)
	if luaIsInArea(area, pos) then
		return true
	else
		return false
	end
end

function c()
	--ForceEnableInput(IC_MAP_TOGGLE, true)
	KillDialog("Init")
	SetInvincible(Mission.PoW, false)
	AddDamage(Mission.PoW, 40000)
end

function luaJM2AddBuffaloListener()
	Mission.SecWaveBuff = luaRemoveDeadsFromTable(Mission.SecWaveBuff)
	AddListener("recon", "bufflist", {
		["callback"] = "luaJM2BuffaloSpotted",  -- callback fuggveny
		["entity"] = Mission.SecWaveBuff, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})

		AddListener("kill", "buffkill", {
			["callback"] = "luaJM2BuffaloKilled",
			["entity"] = Mission.SecWaveBuff,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {PLAYER_1}, -- [PLAYER_1..PLAYER_8]
		})
end

function luaJM2BuffaloSpotted(...)
	for idx,barmi in ipairs(arg) do
		--luaLog("-----------------")
		--luaLog(idx, barmi)
	end

	if IsListenerActive("recon", "bufflist") then
		RemoveListener("recon", "bufflist")
	end
	
	luaJM2StartDialog("Buffalos_Incomm3")
end


function luaJM2PoWHit(...)
-- RELEASE_LOGOFF  	luaLog("egy hit")
-- RELEASE_LOGOFF  	luaLog(arg)
-- RELEASE_LOGOFF  	luaLog("-hitlog end-")
	if arg[4] == "BOMB" then

		SetInvincible(Mission.PoW, false)

		if arg[5] == PLAYER_1 then
-- RELEASE_LOGOFF  			luaLog("player damage added")
			AddDamage(Mission.PoW, Mission.PoW.Class.HP*(0.035*Mission.DiffMul*Mission.DodiSzorzo))
-- RELEASE_LOGOFF  			luaLog("pow current hp: "..tostring(GetHpPercentage(Mission.PoW)*Mission.PoW.Class.HP))
		else
			AddDamage(Mission.PoW, Mission.PoW.Class.HP*(0.01*Mission.DiffMul*Mission.DodiSzorzo))
		end

		SetInvincible(Mission.PoW, true)

		luaJM2CheckPoWFailures(Mission.PoW)

	elseif arg[4] == "KAMIKAZE" then

		SetInvincible(Mission.PoW, false)

		if arg[5] == PLAYER_1 then
			AddDamage(Mission.PoW, Mission.PoW.Class.HP*(0.45*Mission.DiffMul))
		else
			AddDamage(Mission.PoW, Mission.PoW.Class.HP*(0.01*Mission.DiffMul))
		end

		SetInvincible(Mission.PoW, true)

		luaJM2CheckPoWFailures(Mission.PoW)
	end
end

function luaJM2RepulseTorpedo(...)
	--luaLog(arg)

	if arg[4] == "TORPEDO" then
		--luaLog("torphit")
		SetInvincible(Mission.Repulse, false)

		if arg[5] == PLAYER_1 then
			--luaLog("player sebzes")
			AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*(0.34*Mission.DiffMul*Mission.DodiSzorzo))

			--if Mission.Difficulty == 0 then
				--AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*0.1)
			--end
		else
			--luaLog("ai sebzes")
			AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*(0.01*Mission.DiffMul*Mission.DodiSzorzo))
		end

		SetInvincible(Mission.Repulse, true)

	elseif arg[4] == "KAMIKAZE" then

		SetInvincible(Mission.Repulse, false)

		if arg[5] == PLAYER_1 then
			AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*(0.45*Mission.DiffMul))
		else
			AddDamage(Mission.Repulse, Mission.Repulse.Class.HP*(0.01*Mission.DiffMul))
		end

		SetInvincible(Mission.Repulse, true)
	end
end

function luaJM2StartHollywoodizer()
	Mission.Hollywood = CreateScript("luaJM2Hollywoodizer_init")
end

function luaJM2Hollywoodizer_init(this)

	Mission.Avoid = true

	Mission.RndFX = {}
		table.insert(Mission.RndFX, "Avoid")
		table.insert(Mission.RndFX, "HDodge")
		table.insert(Mission.RndFX, "VDodge")
		--table.insert(Mission.RndFX, "Inv")
		table.insert(Mission.RndFX, "BettyDodge")
		table.insert(Mission.RndFX, "Explosion")


	--SetDeviceReloadTimeMul(0)
    SetThink(this, "luaJM2Hollywoodizer_think")
end

function luaJM2Hollywoodizer_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
--[[		if Mission.Hollywood and not Mission.Hollywood.Dead then
			DeleteScript(Mission.Hollywood)
		end]]

		return
	end

	local idx = random(1,table.getn(luaRemoveDeadsFromTable(Mission.FakeNells)))
	local idx2 = random(1,table.getn(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)))
	local rndfx = random(1,table.getn(Mission.RndFX))
	local rndfxbuff = random(1,table.getn(Mission.RndFX))
	local subject = Mission.FakeNells[idx]
	local buff = Mission.FirstWaveBuff[idx2]

	if subject and not subject.Dead then
		if table.getn(luaRemoveDeadsFromTable(Mission.Buff)) ~= 0 then
			if Mission.RndFX[rndfx] == "Avoid" then
				if Mission.Avoid then
					SquadronEnableGunfireAvoidance(subject, false)
					Mission.Avoid = false
					--luaLog(subject.Name.." is AVOIDING.")
				else
					SquadronEnableGunfireAvoidance(subject, true)
					Mission.Avoid = true
					--luaLog(subject.Name.." is NOT AVOIDING.")
				end
			elseif Mission.RndFX[rndfx] == "HDodge" then
				luaJM2HDodge(subject)
			elseif Mission.RndFX[rndfx] == "VDodge" then
				luaJM2VDodge(subject)
			elseif Mission.RndFX[rndfx] == "BettyDodge" then
				luaJM2VDodge(Mission.PlayerBetty)
			elseif Mission.RndFX[rndfx] == "Explosion" then
				Effect("ExplosionBigPlane",GetPosition(subject))
				--luaLog(subject.Name.." EXPLODING")
			end
		end
	end

	if buff and not buff.Dead then
		if Mission.EscortGenerated then
			if table.getn(luaRemoveDeadsFromTable(Mission.Buff)) ~= 0 then
				if Mission.RndFX[rndfxbuff] == "Avoid" then
					if Mission.Avoid then
						SquadronEnableGunfireAvoidance(buff, false)
						--luaLog(subject.Name.." is AVOIDING.")
					else
						SquadronEnableGunfireAvoidance(buff, true)
						--luaLog(subject.Name.." is NOT AVOIDING.")
					end
				elseif Mission.RndFX[rndfxbuff] == "HDodge" then
					luaJM2HDodge(buff)
				elseif Mission.RndFX[rndfxbuff] == "VDodge" then
					luaJM2VDodge(buff)
				elseif Mission.RndFX[rndfxbuff] == "BettyDodge" then

				elseif Mission.RndFX[rndfxbuff] == "Explosion" then
					Effect("ExplosionBigPlane",GetPosition(buff))
					--luaLog(subject.Name.." EXPLODING")
				end

				local idx = random(1,2)
				local unit = luaRemoveDeadsFromTable(Mission.FakeNells)[idx]
				if unit and not unit.Dead then
					PilotSetTarget(buff, unit)
				end

			end
		end
	end



	SetWait(this, random(2,5))
end

function luaJM2VDodge(squad)
	local delta = random(10,60)
	local minus = random(1,2)
	local szorzo
	local pos
	local alt

	if minus == 1 then
		szorzo = 1
	else
		szorzo = -1
	end

	if squad and not squad.Dead then
		alt = GetPosition(squad).y
		pos = (szorzo*delta)+alt

		if (alt < 250) or (alt > 500) then
			pos = 500
		end

		SquadronSetTravelAlt(squad, pos)

	end

	--SquadronSetAttackAlt(squad, pos)

	--luaLog("VDODGE CALLED: "..squad.Name.." is setting alt to: "..tostring(pos))
end

function luaJM2HDodge(squad)
	if squad and not squad.Dead then
		local trg = luaGetNearestEnemy(squad)
		if trg and not trg.Dead then
			PilotMoveTo(squad, trg)
			luaDelay(luaJM2DodgeRestore, 2, "Squadron", squad)			
		end
		--luaLog("HDODGE CALLED: "..squad.Name.." is moving towards: "..trg.Name)
		
	end
end

function luaJM2DodgeRestore(timerthis)

	local squad = timerthis.ParamTable.Squadron
	if squad and not squad.Dead then
		if Mission.Repulse and not Mission.Repulse.Dead then
			PilotMoveTo(squad, Mission.Repulse)
		end
	end
	--luaLog(squad.Name.." is returning to Repulse.")
end


function luaJM2BuffaloKilled()
	if IsListenerActive("kill", "buffkill") then
		RemoveListener("kill", "buffkill")
	end
	luaJM2StartDialog("BuffShot")
end

function luaJM2GenerateFirstWave()
	if not Mission.FirstWaveGenerated then
-- RELEASE_LOGOFF  		luaLog("first phase generated")
		Mission.FirstWaveGenerated = true
		local pBufName

		for i=1,3 do
			pBufName = luaFindHidden("F2A Buffalo 0"..i)
			local pos = {["x"]=20,["y"]=20,["z"]=20}
			pos.x = pos.x + random(-100, 100)
			pos.z = pos.z + random(-100, 100)
			local buffalo = GenerateObject(pBufName.Name, "F2A Buffalo")
			table.insert(Mission.Buff, buffalo)
			table.insert(Mission.FirstWaveBuff, buffalo)

			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaPutToRecon(buffalo, Mission.PlayerBetty, 250+i*5)
			end
--			PutRelTo(buffalo, FindEntity("BuffaloSpawnPoint 01"), pos)

			SquadronSetTravelAlt(buffalo, 500, true)
			SquadronSetAttackAlt(buffalo, 500, true)
			Mission.FakeNells = luaRemoveDeadsFromTable(Mission.FakeNells)
			if Mission.FakeNells[i] and not Mission.FakeNells[i].Dead then
				luaSetScriptTarget(buffalo, Mission.FakeNells[i])
			end
			SetSkillLevel(buffalo, SKILL_SPNORMAL)
			--luaObj_AddUnit("secondary",1,buffalo)
		end

		for i=4,6 do
			pBufName = luaFindHidden("F2A Buffalo 0"..i)
			local pos = {["x"]=20,["y"]=0,["z"]=20}
			pos.x = pos.x + random(-100, 100)
			pos.z = pos.z + random(-100, 100)

			local buffalo = GenerateObject(pBufName.Name, "F2A Buffalo")
			table.insert(Mission.Buff, buffalo)
			table.insert(Mission.FirstWaveBuff, buffalo)

			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaPutToRecon(buffalo, Mission.PlayerBetty, 250+i*2)
			end
--			PutRelTo(buffalo, FindEntity("BuffaloSpawnPoint 01"), pos)

			SquadronSetTravelAlt(buffalo, 500, true)
			SquadronSetAttackAlt(buffalo, 500, true)
			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead	then
				luaSetScriptTarget(buffalo, Mission.PlayerBetty)
			end
			SetSkillLevel(buffalo, SKILL_SPNORMAL)
			--luaObj_AddUnit("secondary",1,buffalo)
		end


		luaJM2StartHollywoodizer()
		luaJM2StartDialog("Intermezzo2")
	end
end

function luaJM2DramaticCameraMovement(unit, delay)
	luaJM2StartDialog("Intermezzo")

	Mission.MovieNells = {}
	Mission.MovieBuffs = {}

	Mission.MovieNellNames = {}
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieNell 01"))
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieNell 02"))
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieNell 03"))
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieNell 04"))
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieNell 05"))
		table.insert(Mission.MovieNellNames, luaFindHidden("MovieBettyTorp"))

	Mission.MovieBuffNames = {}
		table.insert(Mission.MovieBuffNames, luaFindHidden("MovieBuffalo 01"))
		table.insert(Mission.MovieBuffNames, luaFindHidden("MovieBuffalo 02"))
		table.insert(Mission.MovieBuffNames, luaFindHidden("MovieBuffalo 03"))
		table.insert(Mission.MovieBuffNames, luaFindHidden("MovieBuffalo 04"))

	Mission.FlyTo = FindEntity("FlyTo")
	Mission.FlyTo2 = FindEntity("FlyTo2")

	if not Mission.SavedCheckpoint or Mission.Checkpoint.CheckPoint.Num[1] == 1 then
		for i,v in pairs(Mission.MovieNellNames) do
			--luaLog("movieunitgeneralas meg a faszom")
			local nell = GenerateObject(v.Name, v.Name)
			table.insert(Mission.MovieNells, nell)
			SetRoleAvailable(nell, EROLF_ALL, PLAYER_AI)
			SquadronSetTravelAlt(nell, 500)
			PilotMoveTo(nell, Mission.FlyTo2)

			if nell.Class.ID == 167 then
				Mission.MovieBetty = nell
			end
		end

		for i,v in pairs(Mission.MovieBuffNames) do
			local buff = GenerateObject(v.Name, v.Name)
			SetParty(buff, PARTY_ALLIED)
			SquadronSetTravelAlt(buff, 600)
			SquadronSetAttackAlt(buff, 600)
			table.insert(Mission.MovieBuffs, buff)
			--PilotSetTarget(buff, Mission.MovieBetty)
		end


		if Mission.MovieNells[1] and not Mission.MovieNells[1].Dead then
			SetInvincible(Mission.MovieNells[1], true)
		end
		Mission.DelayedMovieAttack = luaDelay(luaJM2MovieAttack, 4)
		Mission.DelayedMovieExplosion = luaDelay(luaJM2MovieExplosion, 10)

		luaIngameMovie(
			{
				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=300,["y"]=7,["z"]=-130},["parent"] = FindEntity("MovieBettyTorp"),},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=3,},
				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=300,["y"]=-7,["z"]=-130},["parent"] = FindEntity("MovieBettyTorp"),},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=3,},

				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-50,["y"]=-1,["z"]=150},["parent"] = FindEntity("MovieBuffalo 02"),},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=2,},
				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-50,["y"]=-1,["z"]=350},["parent"] = FindEntity("MovieBuffalo 02"),},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=2,},

				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-15,["y"]=7,["z"]=-230},["parent"] = FindEntity("MovieBettyTorp"),},["moveTime"] = 0,["transformtype"] = "keepnone",},
				{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-15,["y"]=-17,["z"]=-200},["parent"] = FindEntity("MovieBettyTorp"),},["moveTime"] = 6,["transformtype"] = "keepnone",},
			}, luaJM2DoEscortedBlackOut, true, nil, false)


		--luaDelay(luaJM2DoEscortedBlackOut, 20)

		if not Mission.CheckpointLoaded then
			luaDelay(luaJM2KillAmiNemKell, 3)
		end
	else
		luaJM2DoEscortedBlackOut()
	end
end

function luaJM2MovieAttack()
	if Mission.MovieNells[1] and not Mission.MovieNells[1].Dead then
		for i,v in pairs(luaRemoveDeadsFromTable(Mission.MovieBuffs)) do
			PilotSetTarget(v, Mission.MovieNells[1])
		end
	end
end

function luaJM2MovieExplosion()
	if Mission.MovieNells[1] and not Mission.MovieNells[1].Dead then
		Effect("ExplosionBigPlane", GetPosition(Mission.MovieNells[1]))
		SquadronSetTravelAlt(Mission.MovieNells[1], 300)
		PilotMoveTo(Mission.MovieNells[1], Mission.FlyTo)
		luaDelay(luaJM2NellKill, 3)
	end
		--SetFailure(Mission.MovieNells[1], "enginefire")
end

function luaJM2NellKill()
	if Mission.MovieNells[1] and not Mission.MovieNells[1].Dead then
		Effect("ExplosionBigPlane", GetPosition(Mission.MovieNells[1]))
		SetInvincible(Mission.MovieNells[1], false)
		Kill(Mission.MovieNells[1], true)
	end
end

function luaJM2KillAmiNemKell()
	--luaLog("killer "..debug.traceback())

	if Mission.FakePoW and not Mission.FakePoW.Dead then
		Kill(Mission.FakePoW, true)
	end

	if Mission.FakeRescue and not Mission.FakeRescue.Dead then
		Kill(Mission.FakeRescue, true)
	end

	local mb1 = FindEntity("MovieBetty")
	local mb2 = FindEntity("MovieBetty 01")
	local mb3 = FindEntity("MovieBetty 02")

	if mb1 and not mb1.Dead then
		Kill(mb1, true)
	end

	if mb2 and not mb2.Dead then
		Kill(mb2, true)
	end

	if mb3 and not mb3.Dead then
		Kill(mb3, true)
	end

end

function luaJM2DoEscortedBlackOut()
	Blackout(true,"luaJM2DoEscorted",1)

	if Mission.DelayedMovieAttack and not Mission.DelayedMovieAttack.Dead then
		DeleteScript(Mission.DelayedMovieAttack)
	end

	if Mission.DelayedMovieExplosion and not Mission.DelayedMovieExplosion.Dead then
		DeleteScript(Mission.DelayedMovieExplosion)
	end

	luaDelay(luaJM2DelayedKill, 2)

--[[	for i,v in pairs(luaRemoveDeadsFromTable(Mission.MovieBuffs)) do
		Kill(v, true)
	end

	for i,v in pairs(luaRemoveDeadsFromTable(Mission.MovieNells)) do
		Kill(v, true)
	end
]]
end

function luaJM2DelayedKill()
	for i,v in pairs(luaRemoveDeadsFromTable(Mission.MovieBuffs)) do
		Kill(v, true)
	end

	for i,v in pairs(luaRemoveDeadsFromTable(Mission.MovieNells)) do
		Kill(v, true)
	end
end


function luaJM2DoEscorted()
	SetSelectedUnit(Mission.PlayerBetty)
	EnableInput(true)
	Mission.EscortGenerated = true
	--luaDelay(luaJM2ForceTailGunner,2)
	luaJM2ForceTailGunner()
	--luaJM2StepPhase()
	Mission.ThinkStop = false
end

function luaJM2EnableControls(on)
	--ForceEnableInput(IC_MAP_TOGGLE, on)

	if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
		if on then
			UnitSetPlayerCommandsEnabled(Mission.PlayerBetty, PCF_ALL)
		else
			UnitSetPlayerCommandsEnabled(Mission.PlayerBetty, PCF_NONE)
		end
	end


	--[[ForceEnableInput(IC_CMD_SETTARGET, on)
	ForceEnableInput(IC_CMD_CLEARTARGET, on)
	ForceEnableInput(IC_CMD_JUMPIN, on)
	ForceEnableInput(IC_OVERLAY_GREEN, on)
	ForceEnableInput(IC_OVERLAY_RED, on)
	ForceEnableInput(IC_OVERLAY_BLUE, on)
	ForceEnableInput(IC_OVERLAY_YELLOW, on)
	ForceEnableInput(IC_PLANE_BOMBSWITCH, on)
	ForceEnableInput(IC_PLANE_BOMBFIRE, on)
	ForceEnableInput(IC_PLANE_TURBO, on)
	ForceEnableInput(IC_PLANE_POWER, on)
	ForceEnableInput(IC_PLANE_YAW, on)
	ForceEnableInput(IC_PLANE_ROLL, on)
	ForceEnableInput(IC_PLANE_PITCH, on)
	ForceEnableInput(IC_PLANE_ROLL_MOUSE, on)
	ForceEnableInput(IC_PLANE_PITCH_MOUSE, on)]]--
end

function luaJM2SquadCounter()
	DisplayScores(1,0,"ijn02.squadrons","")
end

function luaJM2PoWDead()
	luaJM2StartDialog("PoWDead")


	--SetInvincible(Mission.PoW, false)
	SetWaterDamage(Mission.FakePoW, 5000)
	--AddDamage(Mission.FakePoW, 10000)
	--BreakShip(Mission.FakePoW)
	--SetDeadMeat(Mission.PoW)
end

function luaJM2ShowDeadBB()
	--luaLog("luaJM2ShowDeadBB")
	local trTbl = {["x"]=0,["y"]=-300,["z"]=0,}
	local rotTbl = {["x"]=-15,["y"]=0,["z"]=10,}

	local fakepow = luaFindHidden("FakePoW")
	local fakerescue = luaFindHidden("Rescue")
	local flyto = FindEntity("FlyTo")
	Mission.Fakepath = FindEntity("MoviePath")
	local fakebettys = {}
		table.insert(fakebettys, luaFindHidden("MovieBetty"))
		table.insert(fakebettys, luaFindHidden("MovieBetty 01"))
		table.insert(fakebettys, luaFindHidden("MovieBetty 02"))

	Mission.FakePoW = GenerateObject(fakepow.Name, fakepow.Name)
	SetDamagedGFXLevel(Mission.FakePoW, 1)

	AAEnable(Mission.FakePoW, false)
	DisablePhysics(Mission.FakePoW)

	for i,v in pairs(fakebettys) do
		local fb  = GenerateObject(v.Name, v.Name)
		SquadronSetTravelAlt(fb, 60)
		PilotMoveOnPath(fb, Mission.Fakepath, PATH_FM_SIMPLE, PATH_SM_JOIN, 300)
		luaDelay(luaJM2MovieDrop, 1)
	end

	--Mission.FakeRescue = GenerateObject(fakerescue.Name, fakerescue.Name)
	--NavigatorMoveToPos(Mission.FakeRescue, flyto)

	SetNumbering(Mission.FakePoW, 0)
	SetGuiName(Mission.FakePoW, "ingame.shipnames_prince_of_wales")
	Effect("GiantSmoke",ORIGO,Mission.FakePoW)

	AddMatrixInterpolator(Mission.FakePoW, trTbl, rotTbl, 600)


	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-198.66259765625,["y"]=37.659881591797,["z"]=68.58984375},["parent"] = Mission.FakePoW,},["moveTime"] = 0,["transformtype"] = "keepnone",},
		{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-246.9814453125,["y"]=38.193695068359,["z"]=-2.38671875},["parent"] = Mission.FakePoW,},["moveTime"] = 8,["transformtype"] = "keepnone",},

		--{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-250.27490234375,["y"]=47.659713745117,["z"]=68.28857421875},["parent"] = Mission.FakePoW,},["moveTime"] = 0,["transformtype"] = "keepnone",},
		--{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-255.1279296875,["y"]=95.711532592773,["z"]=-65.86962890625},["parent"] = Mission.FakePoW,},["moveTime"] = 8,["transformtype"] = "keepnone",},
	}, luaJM2GenerateEscort)

	--[[local oilPos

	if Mission.FakePoW and not Mission.FakePoW.Dead then
		oilPos = ORIGO
-- RELEASE_LOGOFF  		luaLog("OILPOS")
-- RELEASE_LOGOFF  		luaLog(oilPos)
	end

	if oilPos then
-- RELEASE_LOGOFF  		luaLog("playing bugybor")
		oilPos.y = oilPos.y + 18
-- RELEASE_LOGOFF  		luaLog(oilPos)
		Effect("SurfaceBubbles",oilPos,Mission.FakePoW)
	end	]]

	Blackout(false, "luaJM2PoWDead", 1)
end

function luaJM2MovieDrop()
	local fb = FindEntity("MovieBetty 01")

	SquadronForceRelease(fb)
	--PilotMoveOnPath(fb, Mission.Fakepath, PATH_FM_SIMPLE, PATH_SM_JOIN, 300)
	--SquadronSetTravelAlt(fb, 63)
end

function luaJM2GetFlakPos(unitpos,direction)

	local pos = {}
	local pos0 = {}
	local dirside = {}
	local dirup = {}

	for k,v in pairs(unitpos) do
		pos0[k] = v
	end

	for k,v in pairs(direction) do
		dirside[k] = v
		dirup[k] = v
		--table.insert(dirside,k,v)
		--table.insert(dirup,k,v)
	end

	--luaLog(pos0)
	--luaLog(dirside)
	--luaLog(dirup)

	dirside.x = unitpos.z
	dirside.z = -unitpos.x

	len = math.sqrt(dirside.x*dirside.x+dirside.z*dirside.z)
	dirside.x = dirside.x/len
	dirside.z = dirside.z/len

	dirup.x = direction.y*dirside.z
	dirup.y = direction.z*dirside.x-direction.x*dirside.z
	dirup.z = -direction.y*dirside.x

	local rz = random (100, 450)
	pos.x = pos0.x + rz * direction.x
	pos.y = pos0.y + rz * direction.y
	pos.z = pos0.z + rz * direction.z

	local rx = random(-150,150)
	pos.x = pos.x + rx * dirside.x
	pos.y = pos.y + rx * dirside.y
	pos.z = pos.z + rx * dirside.z

	local ry = random(-35,35)
	pos.x = pos.x + ry * dirup.x
	pos.y = pos.y + ry * dirup.y
	pos.z = pos.z + ry * dirup.z

	return pos
end

function luaJM2RepulseCam()

		if not Mission.ScoreHided then
			HideScoreDisplay(2,0)
			--HideScoreDisplay(9,0)
			Mission.ScoreHided = true
		end
		PilotRetreat(Mission.PlayerBetty)
		Mission.FakeNells = luaRemoveDeadsFromTable(Mission.FakeNells)

		if table.getn(Mission.FakeNells) == 0 then
			Mission.MissionFailed = true
			luaJM2StepPhase(99)
			return
		end

		SetRoleAvailable(Mission.FakeNells[1], EROLF_ALL, PLAYER_1)
		Mission.PlayerNell = Mission.FakeNells[1]

		--Mission.CamScript = luaCamOnTargetFree(Mission.PlayerNell, 20, 179, 350, false, "noupdate", 0, nil)



		--local pos = GetPosition(Mission.PlayerNell)
		--pos.y = 75

		--PutTo(Mission.PlayerNell, pos)

		--Blackout(false, "luaJM2NellsArrived", 2)
		PutRelTo(Mission.PlayerNell, Mission.Repulse, {["x"]=3500,["y"]=80,["z"]=0}, -90)
		luaJM2NellsArrived()
end

function luaJM2NellsArrived()
		SetSimplifiedReconMultiplier(1.5)
		luaJM2StartDialog("NellsArrived")
		luaJM2HiddenTimer()

		if Mission.PlayerNell and not Mission.PlayerNell.Dead then
			SetInvincible(Mission.PlayerNell, true)
		end

		luaDelay(luaJM2NellDescent, 2)

		luaIngameMovie(
		{
		   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-100,["y"]=15,["z"]=-200},["parent"] = FindEntity("Renown-class 1"),},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=2,},
		   {["postype"] = "target",["position"] = {["pos"] = {["x"]=200,["y"]=13,["z"]=100},["parent"] = FindEntity("Renown-class 1"),},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=2,},

		   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-100,["y"]=15,["z"]=-200},["parent"] = FindEntity("Renown-class 1"),},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=2,},
		   {["postype"] = "target",["position"] = {["pos"] = {["x"]=200,["y"]=13,["z"]=100},["parent"] = FindEntity("Renown-class 1"),},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=2,},

		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerNell, ["distance"] = 350, ["theta"] = 20, ["rho"] = 179, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerNell, ["distance"] = 150, ["theta"] = 20, ["rho"] = 179, ["moveTime"] = 6,},
	   }, luaJM2RepCamDone, true)
end

function luaJM2NellDescent()
	if Mission.PlayerNell and not Mission.PlayerNell.Dead then
		SquadronSetTravelAlt(Mission.PlayerNell, 50)	
	end
end

function luaJM2RepCamDone()
	Mission.RepulseCamDone = true
	if Mission.Repulse and not Mission.Repulse.Dead then
		SetInvincible(Mission.Repulse, true)
	end
	--for idx, unit in pairs(luaGetOwnUnits()) do
		--SetSkillLevel(unit, SKILL_STUN)
	--end

	EnableInput(true)

	if Mission.PlayerNell and not Mission.PlayerNell.Dead then
		SetSkillLevel(Mission.PlayerNell, SKILL_SPNORMAL)
		SetSelectedUnit(Mission.PlayerNell)
		SetInvincible(Mission.PlayerNell, false)
	end

	luaJM2StepPhase()
end

function luaJM2DistanceCounter()
	--local dist = luaJM2Metric(luaGetDistance3D(Mission.PlayerBetty, Mission.Repulse)) - luaJM2Metric(3500)
	--Mission.Measure = GetMeasure()
	--Mission.RepDistance = string.format("%.1f",dist)
	--DisplayScores(2,0,"ijn02.obj_p2","ijn02.distance")
	DisplayScores(2,0,"ijn02.obj_p2","ijn02.obj_s1")
end

function luaJM2Metric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end

end

function luaJM2ShowDeadRepulse()
	--luaLog("showdeadrepulse "..debug.traceback())

	Mission.MissionCompleted = true
	luaJM2StepPhase(99)

	local trTbl = {["x"]=0,["y"]=-600,["z"]=0,}
	local rotTbl = {["x"]=-15,["y"]=0,["z"]=10,}

	local fakerep = luaFindHidden("FakeRepulse")
	Mission.Fakepath2 = FindEntity("MoviePath 02")
	local fakenells = {}
		table.insert(fakenells, luaFindHidden("FakeRepulseNell 01"))
		table.insert(fakenells, luaFindHidden("FakeRepulseNell 02"))

	Mission.FakeRepulse = GenerateObject(fakerep.Name, fakerep.Name)
	SetDamagedGFXLevel(Mission.FakeRepulse, 1)
	AAEnable(Mission.FakeRepulse, false)
	DisablePhysics(Mission.FakeRepulse)

	for i,v in pairs(fakenells) do
		local fb = GenerateObject(v.Name, v.Name)
		SquadronSetTravelAlt(fb, 20)
		PilotMoveOnPath(fb, Mission.Fakepath2, PATH_FM_SIMPLE, PATH_SM_JOIN, 300)
	end

	SetNumbering(Mission.FakeRepulse, 0)
	SetGuiName(Mission.FakeRepulse, "ingame.shipnames_repulse")
	Effect("GiantSmoke",ORIGO,Mission.FakeRepulse)

	AddMatrixInterpolator(Mission.FakeRepulse, trTbl, rotTbl, 400)

	luaIngameMovie(
	{
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-75,["y"]=44,["z"]=75},["parent"] = FindEntity("FakeRepulse"),},["moveTime"] = 0,["transformtype"] = "keepnone",},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = FindEntity("FakeRepulse"),},["moveTime"] = 0,["transformtype"] = "keepnone",},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-75,["y"]=-100,["z"]=75},["parent"] = FindEntity("FakeRepulse"),},["moveTime"] = 20,["transformtype"] = "keepnone",},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=-100,["z"]=0},["parent"] = FindEntity("FakeRepulse"),},["moveTime"] = 20,["transformtype"] = "keepnone",},
		{["postype"] = "cameraandtarget", ["position"] = {}, ["moveTime"] = 0, ["transformtype"] = "keepall",},
	}, nil)

	Blackout(false, "luaJM2RepulseDead", 1)

end

function luaJM2RepulseDead()
	--luaLog("repulsedead CB "..debug.traceback())

	if not Mission.ReinfIn then --sec completed
		luaObj_Completed("hidden",1,nil,true)
	end

	SetDeadMeat(Mission.FakeRepulse)
	HideScoreDisplay(1,0)
	luaJM2StartDialog("Final")
end

function luaJM2MissionCompleted()

	luaMissionCompletedNew(nil, "ijn02.obj_missioncompleted")

	local medal = luaGetMedalReward()
	if medal == MEDAL_SILVER then
		Scoring_GrantBonus("JM2_SCORING_SILVER", "ijn02.bonus1_title", "ijn02.bonus1_text", 166)
	elseif medal == MEDAL_GOLD then
		--Scoring_GrantBonus("JM2_SCORING_SILVER", "ijn02.bonus1_title", "ijn02.bonus1_text", 166)
		Scoring_GrantBonus("JM2_SCORING_GOLD", "ijn02.bonus2_title", "ijn02.bonus2_text", 166)
	end

	--luaCheckMusicSetMinLevel(MUSIC_VICTORY)
	luaJM2StepPhase()
	Mission.EndMission = true
end


function luaJM2SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
end

function luaJM2LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]

	local usnsaved = luaGetCheckpointData("Units", "USUnits")
	local usn = luaGetOwnUnits(nil, PARTY_ALLIED)
	local ijn = luaGetOwnUnits(nil, PARTY_JAPANESE)

	for idx,unit in pairs(usn) do
		local found = false
		for idx2,unitTbl in pairs(usnsaved[1]) do
			if unit.Name == unitTbl[1] then
				--luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
			--luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	if num == 2 then
		--luaLog(ijn)

		for j,w in pairs(ijn) do
			if w.Class.ID ~= 166 then
				--luaLog("KILLING ANNOYING OTHERS")
				Kill(w,true)
			end
		end

	end
end

function luaJM2PutToAfter()
	PutRelTo(Mission.PlayerNell, Mission.Repulse, {["x"]=3500,["y"]=500,["z"]=0}, -90)
	SetSimplifiedReconMultiplier(1.5)
	luaJM2KillAmiNemKell2()
end

function luaJM2KillAmiNemKell2()
	for i,v in pairs(luaRemoveDeadsFromTable(Mission.Buff)) do
		Kill(v, true)
	end

	Kill(Mission.PlayerBetty)
	--Blackout(false, "", 1)
end

function luaJM2BombCamHint()
	ShowHint("Advanced_Hint_Bombcamera")
	luaDelay(luaJM2StallHint, 30)
end

function luaJM2StallHint()
	ShowHint("Advanced_Hint_Stall")
end

function luaJM2OhkaChecker()
	if Mission.OhkasKilled then
		return
	end

	ForceRecon()

	for u,w in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.kamikaze)) do
		SetRoleAvailable(w, EROLF_ALL, PLAYER_AI)
		--Kill(w,true)
	end

	--Mission.OhkasKilled = true
end

function luaJM2CheckPoint()
	--luaCheckpoint(1,nil)
	luaDelay(luaJM2ShowDeadBB, 2)
end

function luaJM2DelayedChkp()
	Blackout(true, "luaJM2CheckPoint", 2)
end

function luaJM2CheckPoint2()
	SetRoleAvailable(Mission.PlayerBetty, EROLF_ALL, PLAYER_AI)
	--luaCheckpoint(2,nil)
	luaDelay(luaJM2RepulseCam, 2)
end

function luaJM2DelayedChkp2()
	Blackout(true, "luaJM2CheckPoint2", 2)
end

function luaJM2LoadBlackOut()
	Blackout(true, "", 0)
	MissionNarrativeClear()
	luaJM2LoadMissionData()
end

function luaJM2BuffaloTargetChecker()
	for i,v in pairs(luaRemoveDeadsFromTable(Mission.FirstWaveBuff)) do
		if not luaGetScriptTarget(v) or luaGetScriptTarget(v).Dead then
			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaSetScriptTarget(v, Mission.PlayerBetty)
			end
		end
	end

	for i,v in pairs(luaRemoveDeadsFromTable(Mission.SecWaveBuff)) do
		if not luaGetScriptTarget(v) or luaGetScriptTarget(v).Dead then
			if Mission.PlayerBetty and not Mission.PlayerBetty.Dead then
				luaSetScriptTarget(v, Mission.PlayerBetty)
			end
		end
	end
end

function luaJM2DelayedBuffaloDlg()
	luaDelay(luaJM2StartBuffDlg, 3)
end

function luaJM2StartBuffDlg()
	luaJM2StartDialog("EnemyBuffalo")
	if not Mission.BomberListener then
		luaJM2AddFighterKillListener()
		--luaLog("nell kill listener active")
	end
end

function luaJM2LandHintChecker()
	local unit

	if Mission.MissionPhase == 1 then
		unit = Mission.PlayerBetty
	elseif Mission.MissionPhase == 3 then
		unit = Mission.PlayerNell
	end

	if unit and not unit.Dead then
		if GetPlaneIsReloading(unit) then
			if not Mission.LandHintShown then
				ShowHint("IJN01_Hint01")
				Mission.LandHintShown = true
			end
		end
	end
end

function luaJM2MemCucc()

-- RELEASE_LOGOFF  	luaLog("----------MEMCUCC-------------")

	local i = 0
	local j = 0
	for idx,ent in pairs(thisTable) do

		if ent.Type == "SCRIPTENTITY" and ent["ParamTable"] and ent["ParamTable"]["Effect"] == "Impact5InchFlak" then
			if not ent.Dead then
				i = i + 1
				--luaLog(ent)
			else
				j = j + 1
			end
		end

	end


	--luaLog("---------------")
	--luaLog("active script ents "..tostring(i)) 
	--luaLog("dead script ents "..tostring(j))
	Mission.SEntity = i
	Mission.DeadSEntity = j

end
