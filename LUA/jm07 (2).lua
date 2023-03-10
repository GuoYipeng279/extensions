--SceneFile="universe\Scenes\missions\IJN\ijn_07_invasion_of_midway.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	EnableMessages(false)
	Music_Control_SetLevel(MUSIC_CALM)
	LoadMessageMap("ijndlg",7)

	Dialogues =
	{
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01a",
				},
				{
					["message"] = "Idlg01a_1",
				},
				{
					["message"] = "Idlg01b",
				},
				{
					["message"] = "Idlg01b_1",
				},
				{
					["message"] = "Idlg01c",
				},
				{
					["message"] = "Idlg01d",
				},
				{
					["message"] = "Idlg01d_1",
				},
				{
					["message"] = "Idlg01e",
				},
			},
		},
	}

	MissionNarrative("ijn07.date_location")
	luaDelay(luaEngineInit, 4, "")
end

function luaEngineInit()
	StartDialog("Intro_dlg1", Dialogues["Intro"] );
	--StartDialog("Intro_dlg2", Dialogues["Intro_B"] );
	--StartDialog("Intro_dlg3", Dialogues["Intro_C"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM7")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM7(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM07.lua"

	this.Name = "JM7"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	this.Party = SetParty(this, PARTY_JAPANESE)

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	--this.ObjRemindTime = 150

	EnableMessages(true)

	--reload
	--SetDeviceReloadEnabled(true)

	Mission.Unlockables = {
		["59"] = {"ingame.shipnames_yamato"},
		["2008"] = {"ingame.shipnames_yamato"},
		["1310"] = {"Bismarck"},
		["68"] = {"ingame.shipnames_chikuma"},
		["1311"] = {"Prinz Eugen"},
		["58"] = {"ingame.shipnames_shimakaze"},
		["14"] = {"ingame.shipnames_akizuki"},
		["81"] = {"globals.unitclass_typeb_kaiten"},
		["8"] = {"ingame.shipnames_i400"},
		["388"] = {"ingame.shipnames_asahi"},
		["391"] = {"ingame.shipnames_oi"},
	}

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM7SpawnFirstCVFleet,luaJM7LoadMissionData},
		[2] = {luaJM7LoadMissionData},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM7SaveMissionData},
		[2] = {luaJM7SaveMissionData}
	}

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	end

	--Mission.UnlockLvl = 3

	if Scoring_IsUnlocked("JM6_GOLD") then
		Mission.PlayerSub = GenerateObject("Submarine TypeB w Jake 01")
		if IsClassChanged(Mission.PlayerSub.Class.ID) then
			luaSetUnlockName(Mission.PlayerSub)
		else
			SetGuiName(Mission.PlayerSub, "ingame.shipnames_i|.112")
		end
	elseif Scoring_IsUnlocked("JM6_SILVER") then
		luaJM7AddPowerup("improved_shells")
	end

	--landing points for AI
	Mission.ShipyardLandingPoint = FindEntity("ShipyardLandingPoint 01")
	Mission.AirfieldLandingPoint = FindEntity("AirfieldLandingPoint 01")

	--cb
	Mission.CommandBuilding1 = FindEntity("Headquarter 01")
	Mission.CommandBuilding2 = FindEntity("CommandBuilding Control Tower 01")
	RepairEnable(Mission.CommandBuilding2, false)

	--shipyards
	Mission.ShipyardSpawnInterval = 150
	Mission.LastShipyardSpawn = 0
	Mission.Shipyard2 = FindEntity("Shipyard 02")
	Mission.SY2SpawnPoint = FindEntity("Shipyard2SpawnPoint")
	Mission.Shipyard2Ships = {}
	Mission.SY2PatrolPath = FindEntity("Shipyard2Patrol")
	Mission.Shipyard2SpawnReq = "Shipyard2SpawnReq"

	Mission.USNReinforcementSPawnPoint = FindEntity("USNReinforcement")
	Mission.USNReinfReq = "USNReinfReq"
	Mission.USNReinforcements = {}

	Mission.Catalina = FindEntity("PBY Catalina 01")
	luaJM7InitalSkillz({Mission.Catalina})
	PilotMoveOnPath(Mission.Catalina, FindEntity("CatalinaPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)

	Mission.PrevParty = "PARTY_ALLIED"
	Mission.AirGuns = {}
		table.insert(Mission.AirGuns, FindEntity("Heavy AA, US Big Platform 07"))
		table.insert(Mission.AirGuns, FindEntity("Heavy AA, US Big Platform 08"))
		table.insert(Mission.AirGuns, FindEntity("Heavy AA, US Big Platform 09"))
		table.insert(Mission.AirGuns, FindEntity("Heavy AA, US Big Platform 10"))
		table.insert(Mission.AirGuns, FindEntity("Heavy AA, US Big Platform 11"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 14"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 15"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 16"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 17"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 18"))
		table.insert(Mission.AirGuns, FindEntity("Coastal Gun, US 19"))

	Mission.PlayerFleet = {}
		table.insert(Mission.PlayerFleet, FindEntity("Fuso-class Battleship 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 11"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 12"))
		table.insert(Mission.PlayerFleet, FindEntity("Hiryu-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Kaga-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Takao-class 01"))
		--table.insert(Mission.PlayerFleet, FindEntity("Takao-class 02"))
		for idx,unit in pairs(Mission.PlayerFleet) do
			if idx > 1 then
				JoinFormation(unit, Mission.PlayerFleet[1])
			end
		end
		SetSelectedUnit(Mission.PlayerFleet[1])
		Mission.Kaga = FindEntity("Kaga-class 01")
		Mission.Hiryu = FindEntity("Hiryu-class 01")
		SetShipSpeed(Mission.PlayerFleet[1], 10)

	--debug
	--luaJM7CVsInvincible()

	Mission.PlayerFleetNames = {}
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_fuso")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_fubuki")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_shirayuki")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_hiryu")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_kaga")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_takao")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_maya")

	Mission.IJNInvasionFleetNames = {}
		table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_yamato")
		table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_meiko")
		table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_myoken")
		table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_fukusei")
		table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_harbin")

	Mission.Fleets = {
		[1] = {},
		[2] = {},
	}

	--Mission.InvasionSpawnTime = 900

	Mission.USNReinfFleetNames = {}
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_enterprise", 8})				--CV8
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_northampton", 26})	--CA26
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_vincennes", 44})		--CA44
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_astoria", 34})			--CA34

		--table.insert(Mission.USNReinfFleetNames, "USS John P. Holder")
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_reid", 369})				--DD369
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_dent", 116})				--DD116
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_russell", 414})			--DD414
		--table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_ellett", 398})			--DD398
		--table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_gwin", 433})				--DD433

	Mission.MainIJNFleet = {}
	Mission.IJNInvasionFleet = {}
	Mission.IJNCargos = {}
	Mission.IJNInvasionReq = "IJNInvasionReq"

	Mission.Atlanta = FindEntity("Atlanta-class 01")
	luaJM7InitalSkillz({Mission.Atlanta})
	SetGuiName(Mission.Atlanta, "ingame.shipnames_atlanta")	--CL51
	SetNumbering(Mission.Atlanta, 51)

	Mission.USReinforcementHeading = FindEntity("USReinforcementHeading")

	Mission.IJNPlaneSpawnPoint = FindEntity("IJNPlaneSpawnPoint")
	Mission.IJNBombersSpawned = 0
	Mission.IJNBomberSpawnReq = "IJNBomberSpawnReq"
	Mission.IJNBombers = {}

	Mission.Airfield1 = FindEntity("AirFieldEntity 01")
	Mission.Airfield1Ents = {}
	Mission.Airfield1Phase = 1
	Mission.Airfield2 = FindEntity("AirFieldEntity 02")
	Mission.Airfield2Ents = {}
	Mission.Airfield2Phase = 1
	Mission.Airfield3 = FindEntity("AirFieldEntity 03")
	Mission.Airfield3Ents = {}
	Mission.Airfield3Phase = 1

	Mission.Airfield2.Active = true
	Mission.Airfield3.Active = true
	--Mission.Airfield3.Active = false
	--Mission.AirfieldActiveFlagChange = 300

	Mission.Airfield1.Maxplanes = 24
	Mission.Airfield2.Maxplanes = 36
	Mission.Airfield3.Maxplanes = 24

	luaJM7InitalSkillz({Mission.Airfield1, Mission.Airfield2, Mission.Airfield3})

	Mission.AirPatrol = {}

	Mission.Nautilus = FindEntity("Narwhal class Sub")
	SetGuiName(Mission.Nautilus, "ingame.shipnames_nautilus")	--SS168
	SetNumbering(Mission.Nautilus, 168)
	luaJM7InitalSkillz({Mission.Nautilus})

	--hiddenhez dolgok
	Mission.StatixAF1 = {}
		table.insert(Mission.StatixAF1, FindEntity("Kerosene Tank 01"))
		table.insert(Mission.StatixAF1, FindEntity("Kerosene Tank 02"))

	Mission.StatixAF2 = {}
		table.insert(Mission.StatixAF2, FindEntity("Kerosene Tank 03"))
		table.insert(Mission.StatixAF2, FindEntity("Kerosene Tank 04"))

	Mission.StatixAF3 = {}
		table.insert(Mission.StatixAF3, FindEntity("Kerosene Tank 05"))
		table.insert(Mission.StatixAF3, FindEntity("Kerosene Tank 06"))

	for i,v in pairs(luaSumTablesIndex(Mission.StatixAF1,Mission.StatixAF2,Mission.StatixAF3)) do
		SetGuiName(v, "ijn07.kerosene")
	end

	Mission.SqLaunched = 0

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "AirSuperiority",
				["Text"] = "ijn07.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		--	[2] = {
		--		["ID"] = "Invasion",
		--		["Text"] = "ijn07.obj_p2",
		--		["Active"] = false,
		--		["Success"] = nil,
		--		["Target"] = {},
		--		["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
		--		["ScoreFailed"] = 0
		--	},
			[3] = {
				["ID"] = "Carriers",
				["Text"] = "ijn07.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "AtlantaKill",
				["Text"] = "ijn07.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Preparation",
				["Text"] = "ijn07.obj_s2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "DisableAF",
				["Text"] = "ijn07.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
				["TextCompleted"] = "ijn07.obj_h1_completed",
			},
		}
	}

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	Mission.ScoreDisplay = {}
	Mission.CarriersSunk = 0

	--DIALOGUES
	this.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1a_1",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["message"] = "dlg1b_1",
				},
				{
					["message"] = "dlg1c",
				},
			},
		},
		["PlayerInRecon"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["Pri1Added"] = {
			["sequence"] = {
				{
					["message"] = "dlg3",
				},
			},
		},
		["NmiPlanesIncom"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["JapInvFleetIn"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
				{
					["message"] = "dlg5b_1",
				},
				{
					["message"] = "dlg5c",
				},
			},
		},
		["NmiReinfIn"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
				{
					["message"] = "dlg6c",
				},
				{
					["message"] = "dlg6c_1",
				},
			},
		},
		["YamatoIn"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
				--{
				--	["message"] = "dlg7c",
				--},
				--{
				--	["message"] = "dlg7d",
				--},
				{
					["type"] = "callback",
					["callback"] = "luaJM7CargoHint",
				},
			},
		},
		--["AirfieldDestroyed1"] = {
		--	["sequence"] = {
		--		{
		--			["message"] = "dlg8",
		--		},
		--	},
		--},
		["AirfieldDestroyed2"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
			},
		},
		["Retreat"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["ShipyardInRecon"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["UnlockSub"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
				{
					["message"] = "dlg12c",
				},
			},
		},
		["AtlantaSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["AtlantaKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
			},
		},
		["Subseen"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
			},
		},
		["Outro"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
				{
					["message"] = "dlg13_1",
				},
				--{
				--	["type"] = "callback",
				--	["callback"] = "luaJM7CompleteMission",
				--},
			},
		},
	}

	LoadMessageMap("ijndlg",7)

	luaJM7AddAtlantaListener()
	luaJM7AddSubReconListener()
	luaJM7AddSYListener()
	luaJM7SetGuiNames()

	Mission.MissionPhase = 1

	if Mission.PlayerSub and not Mission.PlayerSub.Dead then
		luaDelay(luaJM7UnlockDlg,3)
	end

	luaJM7AtlantaGo()
	luaAddSeagulls()
	luaJM7HangarHPOverride()

	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_CALM)

	Mission.ThinkNum = 0

	luaCheckSavedCheckpoint()

	luaJM7FadeIn()


-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
	--think
	SetThink(this, "luaJM7_think")
end

function luaJM7_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.ThinkNum < 2 then		-- Mission - FirstSeconds fakez
		Mission.ThinkNum = Mission.ThinkNum + 1
		return
	end

	luaJM7CheckObjectives()
	luaJM7CheckShipyards()
	luaJM7CheckAirGuns()
	luaJM7CheckSub()

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	if Mission.MissionPhase == 1 then

		luaJM7ISPlayerInRecon()

	elseif Mission.MissionPhase == 2 then

		luaJM7CheckIJNBombers()

	elseif Mission.MissionPhase == 3 then

		luaJM7CheckUSNCarrierFleet1()
		luaJM7PowerupCheck()

		if Mission.USNReinfIn then
			luaJM7CheckUSNCarrierFleet2()
		end

	elseif Mission.MissionPhase == 4 then

		--luaJM7CheckInvasionFleet()

		--if Mission.InvasionStarted then
		--	if not Mission.USNReinfCalled and (math.floor(GameTime()) - Mission.InvasionStarted) > 15 then
		--		luaJM7SpawnUSNReinf()
		--		Mission.USNReinfCalled = true
		--	elseif Mission.USNReinfIn then
		--		luaJM7CheckUSNCarrierFleet2()
		--	end
		--end

	elseif Mission.MissionPhase == 5 then

		--luaJM7CheckInvasionFleet()
		luaJM7CheckUSNCarrierFleet1()
		luaJM7CheckUSNCarrierFleet2()

	end
end

--objectives
function luaJM7CheckObjectives()

	if Mission.MissionPhase < 99 then
		if table.getn(luaRemoveDeadsFromTable(Mission.PlayerFleet)) == 0 then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn07.obj_missionfailed1"
			--luaObj_FailedAll()
			--Mission.LastUnit
			for idx,unit in pairs(Mission.PlayerFleet) do
				if not TrulyDead(unit) then
					Mission.LastUnit = unit
					break
				end
			end
-- RELEASE_LOGOFF  			luaLog("No more playerunits")
			luaJM7StepPhase(99)
		end

		if not luaObj_IsActive("hidden", 1) then
			luaObj_Add("hidden",1)
		else
			if luaObj_GetSuccess("hidden",1) == nil then

				local elso = table.getn(luaRemoveDeadsFromTable(Mission.StatixAF1))
				local masodik = table.getn(luaRemoveDeadsFromTable(Mission.StatixAF2))
				local harmadik = table.getn(luaRemoveDeadsFromTable(Mission.StatixAF3))

				if elso == 0 then
					Mission.Airfield1.HiddenDisabled = true
				end

				if masodik == 0 then
					Mission.Airfield2.HiddenDisabled = true
				end

				if harmadik == 0 then
					Mission.Airfield3.HiddenDisabled = true
				end

				if (elso+masodik+harmadik) == 0 then
					luaObj_Completed("hidden",1)
					luaJM7AddPowerup("improved_repair_team")
				end

			end
		end

		if Mission.CommandBuilding1.Party ~= PARTY_JAPANESE and Mission.CommandBuilding2.Party ~= PARTY_JAPANESE then
			if Mission.InvasionStarted and table.getn(luaRemoveDeadsFromTable(Mission.IJNCargos)) == 0 then
				Mission.MissionFailed = true
				--Mission.LastUnit
				for idx,unit in pairs(Mission.IJNCargos) do
					if not TrulyDead(unit) then
						Mission.LastUnit = unit
						break
					end
				end
				Mission.FailMsg = "ijn07.obj_missionfailed2"
-- RELEASE_LOGOFF  				luaLog("No more cargos")
				--luaObj_FailedAll()
				luaJM7StepPhase(99)
			end
		end

		if Mission.AFMovieOK then
			if not luaObj_IsActive("secondary",2) then
				luaObj_Add("secondary",2)
				luaJM7AirstrikeHint()
				luaJM7Sec2Score()
			elseif luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil then
				if luaJM7PrepObj() then
					luaObj_Completed("secondary",2)
					luaJM7RemoveScore(4)
					luaJM7CAPHint()
				else
					luaJM7Sec2Score()
				end
			end

			if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
				luaJM7Sec1Score()
			end
		end

		luaJM7CheckObjReminders()

	end

	if Mission.MissionPhase == 1 or Mission.MissionPhase == 2 then

		if not luaJM7IsHintActive() and not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			SetForcedReconLevel(Mission.Airfield1, 2, PARTY_JAPANESE)
			SetForcedReconLevel(Mission.Airfield2, 2, PARTY_JAPANESE)
			SetForcedReconLevel(Mission.Airfield3, 2, PARTY_JAPANESE)
			luaObj_AddUnit("primary",1,Mission.Airfield1)
			luaObj_AddUnit("primary",1,Mission.Airfield2)
			luaObj_AddUnit("primary",1,Mission.Airfield3)


			luaJM7Pri1Score()
			luaJM7AFMovie()
			--luaJumpinMovieSetCurrentMovie("GoAround",Mission.Airfield3.ID)
			--luaJM7AddAFMovie()
			luaJM7StartDialog("Pri1Added",true)
-- RELEASE_LOGOFF  			luaLog("Adding obj p1")
		elseif luaObj_IsActive("primary",1) then
			if luaObj_GetSuccess("primary",1) == nil then
				if luaJM7AirfieldObj() then
					luaObj_Completed("primary",1)
					luaJM7AddPowerup("hardened_armour")
					luaJM7SpawnFirstCVFleet()
					luaJM7RemoveScore(1)
					luaJM7StepPhase(3)

					Blackout(true, "luaJM7Checkpoint1", 1)

				else
					luaJM7Pri1Score()
				end
			end
		end

	elseif Mission.MissionPhase == 3 then

		if Mission.Fleet1Ready and not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
-- RELEASE_LOGOFF  			luaLog("Adding obj p3")
			luaJM7CarrierMovie()
			luaJM7Pri3Score()
		elseif luaObj_IsActive("primary",3) then
			if luaObj_GetSuccess("primary",3) == nil then
				if luaJM7CarrierObj() then--and not luaJM7IsEnemyNear() then
					luaObj_Completed("primary",3)
					luaJM7RemoveScore(3)
					--luaJM7StepPhase(5)

					Mission.MissionCompleted = true
					luaJM7StepPhase(99)

					--Blackout(true, "luaJM7Checkpoint2", 1)

					--luaJM7SpawnIJNInvasionFleet()
				else
					luaJM7Pri3Score()
				end
			end
		end

	--[[
	elseif Mission.MissionPhase == 4 then

		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) and luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) then
			if not Mission.InvasionStarted and not Mission.InvasionInit then
				luaJM7SpawnIJNInvasionFleet()
				Mission.InvasionInit = true
			end
			if not luaObj_IsActive("primary",2) and Mission.InvasionStarted then
				luaObj_Add("primary",2)
-- RELEASE_LOGOFF  				luaLog("Adding obj p2")
				luaJM7Pri2Score()
			elseif luaObj_IsActive("primary",2) then
				if luaObj_GetSuccess("primary",2) == nil then
					if luaJM7InvasionObj() then
						luaObj_Completed("primary",2)
						luaJM7RemoveScore(2)
						luaJM7StepPhase()
					end
				end
			end
		end
	]]
	elseif Mission.MissionPhase == 5 then

		if luaJM7CheckEndConds() then
			Mission.MissionCompleted = true
			luaJM7StepPhase(99)
		end

	elseif Mission.MissionPhase == 99 then

		if Mission.MissionFailed then
			if Mission.LastUnit then
				luaMissionFailedNew(Mission.LastUnit, Mission.FailMsg)
			else
				luaMissionFailedNew(Mission.CommandBuilding1, Mission.FailMsg)
			end
			luaJM7StepPhase()

		elseif Mission.MissionCompleted then
			luaJM7StartDialog("Outro")
			luaDelay(luaJM7CompleteMission,20)
			luaJM7StepPhase()
		end

	end

end

function luaJM7Checkpoint1()
	--luaCheckpoint(1,133)
	Blackout(false, "", 1)
end


function luaJM7Checkpoint2()
	--luaCheckpoint(2,133)
	Blackout(false, "", 1)
end

function luaJM7CompleteMission()
-- RELEASE_LOGOFF  	luaLog(debug.traceback())
	luaMissionCompletedNew(Mission.CommandBuilding1, "ijn07.obj_missioncompl")
-- RELEASE_LOGOFF  	luaLog("itt")
end

function luaJM7CheckObjReminders()
	if luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil and not Mission.Objectives.secondary[2].Remind then

		for idx,obj in pairs(Mission.Objectives.primary) do
			if obj.Remind then
				luaObj_RemoveReminder("primary",idx)
			end
		end
		luaObj_AddReminder("secondary",2)

	elseif luaObj_GetSuccess("secondary",2) then

		if Mission.InvasionStarted and luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil and not Mission.Objectives.primary[2].Remind then

			for idx,obj in pairs(Mission.Objectives.primary) do
				if obj.Remind then
					luaObj_RemoveReminder("primary",idx)
				end
			end
			luaObj_AddReminder("primary",2)

		elseif not Mission.InvasionStarted or luaObj_GetSuccess("primary",2) ~= nil then

			if Mission.CVsSighted and luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil and not Mission.Objectives.primary[3].Remind then
				for idx,obj in pairs(Mission.Objectives.primary) do
					if obj.Remind then
						luaObj_RemoveReminder("primary",idx)
					end
				end
				luaObj_AddReminder("primary",3)
			elseif not Mission.CVsSighted or luaObj_GetSuccess("primary",3) ~= nil then
				if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil and not Mission.Objectives.primary[1].Remind then
					for idx,obj in pairs(Mission.Objectives.primary) do
						if obj.Remind then
							luaObj_RemoveReminder("primary",idx)
						end
					end
					luaObj_AddReminder("primary",1)
				end
			end

		end

	end

	luaObj_Reminder()
end

function luaJM7AirfieldObj()

	local AirfieldsDestroyed = 0
	if Mission.Airfield1.Dead or luaJM7IsDisabled(Mission.Airfield1) or Mission.Airfield1.Party ~= PARTY_ALLIED then
		AirfieldsDestroyed = AirfieldsDestroyed + 1
-- RELEASE_LOGOFF  		luaLog("AF1Destroyed")
	end
	if Mission.Airfield2.Dead or luaJM7IsDisabled(Mission.Airfield2) or Mission.Airfield2.Party ~= PARTY_ALLIED then
		AirfieldsDestroyed = AirfieldsDestroyed + 1
-- RELEASE_LOGOFF  		luaLog("AF2Destroyed")
	end
	if Mission.Airfield3.Dead or luaJM7IsDisabled(Mission.Airfield3) or Mission.Airfield3.Party ~= PARTY_ALLIED then
		AirfieldsDestroyed = AirfieldsDestroyed + 1
-- RELEASE_LOGOFF  		luaLog("AF3Destroyed")
	end

	--luaLog("AFDestroyed: "..tostring(AirfieldsDestroyed))

	--if AirfieldsDestroyed == 1 then
	--	luaJM7StartDialog("AirfieldDestroyed1", true)
	--elseif AirfieldsDestroyed == 3 then
	if AirfieldsDestroyed == 3 then
		luaJM7StartDialog("AirfieldDestroyed2", true)
		return true, AirfieldsDestroyed
	end

	return false, AirfieldsDestroyed
end

function luaJM7InvasionObj()
	if Mission.CommandBuilding1.Party == PARTY_JAPANESE and Mission.CommandBuilding2.Party == PARTY_JAPANESE then
		return true
	else
		return false
	end
end

function luaJM7CarrierObj()
	local deads = 0
	if Mission.Yorktown and Mission.Yorktown.Dead then
		deads = deads + 1

		if not Mission.USNReinfCalled then
			luaJM7SpawnUSNReinf()
			Mission.USNReinfCalled = true
		end

	end

	if Mission.Enterprise and Mission.Enterprise.Dead then
		deads = deads + 1
	end
	--if Mission.Hornet and Mission.Hornet.Dead and (Scoring_IsUnlocked("JM6_BRONZE") or Scoring_IsUnlocked("JM6_SILVER") or Scoring_IsUnlocked("JM6_GOLD")) then
	--	deads = deads + 1
	--end

	if not Mission.AchievmentAdded and deads == 2 then
		SetAchievements("MA_TP")
		Mission.AchievmentAdded = true
	end

	Mission.CarriersSunk = deads

	if deads >= 2 then
		return true
	else
		return false
	end
end

function luaJM7PrepObj()
	local numsquads = 0
	if not Mission.Kaga.Dead then
		_, sq = luaGetSlotsAndSquads(Mission.Kaga)
		if sq then
			numsquads = numsquads + table.getn(sq)
		end
	end
	if not Mission.Hiryu.Dead then
		_, sq = luaGetSlotsAndSquads(Mission.Hiryu)
		if sq then
			numsquads = numsquads + table.getn(sq)
		end
	end

	Mission.SqLaunched = numsquads

	if numsquads >= 8 then
		return true
	else
		return false
	end
end

function luaJM7PowerupCheck()
	if not Mission.CVPowerup then

		if not Mission.YorktownPowerup and Mission.Yorktown and Mission.Yorktown.Dead and Mission.Yorktown.KillReason ~= "exitzone" then
			luaJM7AddPowerup("automatic_reloader")
			Mission.CVPowerup = true
			return
		end
		if not Mission.EnterprisePowerup and Mission.Enterprise and Mission.Enterprise.Dead and Mission.Enterprise.KillReason ~= "exitzone" then
			luaJM7AddPowerup("automatic_reloader")
			Mission.CVPowerup = true
			return
		end
		--if not Mission.HornetPowerup and Mission.Hornet and Mission.Hornet.Dead and Mission.Hornet.KillReason ~= "exitzone" then
		--	luaJM7AddPowerup("automatic_reloader")
		--	Mission.CVPowerup = true
		--	return
		--end

	end
end

--- PHASE1 Bombers
function luaJM7CheckIJNBombers()
	if Mission.IJNBombersSpawned >= 6 then
		return
	end
	Mission.IJNBombers = luaRemoveDeadsFromTable(Mission.IJNBombers)

	if table.getn(Mission.IJNBombers) == 0 then
		if not SpawnNewIDIsRequested(Mission.IJNBomberSpawnReq) then
-- RELEASE_LOGOFF  			luaLog("No more bombers, spawning")
			luaJM7SpawnIJNBombers()
		end
	else
		--local ammo = false
		for idx,unit in pairs(Mission.IJNBombers) do
			--if GetProperty(unit,"ammoType") ~= 0 then
			if not unit.msgDisabled then
				EnableMessages(unit, false)
				unit.msgDisabled = true
			end

			if not GetPlaneIsReloading(unit) and not unit.retreating then
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then

					local trgs = luaJM7GetUnits("mothership", PARTY_ALLIED)

					if next(trgs) then
						local trg = luaPickRnd(trgs)
						luaSetScriptTarget(unit, trg)
						PilotSetTarget(unit, trg)
					else
-- RELEASE_LOGOFF  						luaLog("no trg for bombers")
						PilotRetreat(unit)
						unit.retreating = true
					end
				end
				--ammo = true
			else
				PilotRetreat(unit)
				unit.retreating = true
			end
		end
		--if not ammo then
		--	if not SpawnNewIDIsRequested(Mission.IJNBomberSpawnReq) then
-- RELEASE_LOGOFF  		--		luaLog("No ammo on bombers, spawning")
		--		luaJM7SpawnIJNBombers()
		--	end
		--end
	end
end

function luaJM7SpawnIJNBombers()
	local grpTbl =  {}
	local squadNum = random(3,5)
-- RELEASE_LOGOFF  	luaLog("Spawning "..tostring(squadNum).." bomberssquadrons")
	local typeTbl = {
			["Type"] = 167,
			["Name"] = "G4M Betty",
			["Crew"] = 3,
			["Race"] = JAPAN,
			["WingCount"] = 3,
			["Equipment"] = 1,
		}

	for i=1,squadNum do
		table.insert(grpTbl, typeTbl)
	end

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = GetPosition(Mission.IJNPlaneSpawnPoint),
		["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = GetPosition(Mission.CommandBuilding2),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7IJNBombersSpawned",
	["id"] = Mission.IJNBomberSpawnReq,
})
end

function luaJM7IJNBombersSpawned(...)

	local targets = {}
	local trg

	if not luaJM7IsDisabled(Mission.Airfield1) and not Mission.Airfield1.Dead then
		table.insert(targets, Mission.Airfield1)
	end
	if not luaJM7IsDisabled(Mission.Airfield2) and not Mission.Airfield2.Dead then
		table.insert(targets, Mission.Airfield2)
	end
	if not luaJM7IsDisabled(Mission.Airfield3) and not Mission.Airfield3.Dead then
		table.insert(targets, Mission.Airfield3)
	end
	if Mission.CommandBuilding1.Party ~= PARTY_JAPANESE then
		table.insert(targets, Mission.CommandBuilding1)
	end
	if Mission.CommandBuilding2.Party ~= PARTY_JAPANESE then
		table.insert(targets, Mission.CommandBuilding2)
	end

	trg = luaPickRnd(targets)

	for idx,unit in ipairs(arg) do
		--luaLog("squadron spawned")
		SetSkillLevel(unit, Mission.SkillLevel)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.IJNBombers, unit)

		if trg then
			luaSetScriptTarget(unit, trg)
			PilotSetTarget(unit, trg)
		else
			PilotRetreat(unit)
		end

		local rnd = random(1,100)
		if rnd >=98 then
			SetInvincible(unit, 0.1)
		end

	end

	Mission.IJNBombersSpawned = Mission.IJNBombersSpawned + 1
end

function luaJM7RAD(x)
	return x *  0.0174532925
end

---Airfields
function luaJM7CheckMaxplanes(airfield)
	--maxplanes check
	if not airfield or airfield.Dead then
		return
	end

	_,squads = luaGetSlotsAndSquads(airfield)

	if not squads then
		return
	end

	for idx,unit in pairs(squads) do
		if unit and not unit.Dead and not unit.removed then
			if airfield.Maxplanes == 0 then
-- RELEASE_LOGOFF  				luaLog(airfield.Name.." has no more planes")
			else
				unit.removed = true
				airfield.Maxplanes = airfield.Maxplanes - 1
-- RELEASE_LOGOFF  				luaLog("Removing squadron from stock "..airfield.Name)
			end
		end
	end

	--[[
	for idx,slot in pairs(GetProperty(airfield,"slots")) do
		if GetAirBaseSlotStatus(airfield,idx) == 5 then
			if airfield.Maxplanes == 0 then
				--MissionNarrativeEnqueue(airfield.Name.." has no more planes")
-- RELEASE_LOGOFF  				luaLog(airfield.Name.." has no more planes")
			else
				airfield.Maxplanes = airfield.Maxplanes - 1
-- RELEASE_LOGOFF  				luaLog("Removing squadron from stock "..airfield.Name)
			end
		end
	end	]]
end

function luaJM7AirfieldIsActive()
	if Mission.NoAcitveCheckNeeded then
		return
	end

	if Mission.Airfield2.Dead or luaJM7IsDisabled(Mission.Airfield2) or Mission.Airfield2.Maxplanes <= 0 or Mission.Airfield3.Dead or luaJM7IsDisabled(Mission.Airfield3) or Mission.Airfield3.Maxplanes <= 0 then
		--Mission.NoAcitveCheckNeeded = true
		Mission.Airfield2.Active = true
		Mission.Airfield3.Active = true
	end

	--if Mission.AirfieldLastActiveCheck == nil then
	--	Mission.AirfieldLastActiveCheck = math.floor(GameTime())
	--end

	--if math.floor(GameTime()) - Mission.AirfieldLastActiveCheck > Mission.AirfieldActiveFlagChange then
	--	if Mission.Airfield2.Active then
	--		Mission.Airfield2.Active = false
	--		Mission.Airfield3.Active = true
	--	else
	--		Mission.Airfield2.Active = true
	--		Mission.Airfield3.Active = false
	--	end
	--end

end

function luaJM7ReloadAF1()
	Mission.Airfield1.Maxplanes = 24
	Mission.Airfield1.Reload = false
end

function luaJM7ReloadAF2()
	Mission.Airfield2.Maxplanes = 36
	Mission.Airfield2.Reload = false
end

function luaJM7ReloadAF3()
	Mission.Airfield3.Maxplanes = 24
	Mission.Airfield3.Reload = false
end

function luaJM7ReloadYorktown()
	Mission.Yorktown.Maxplanes = 24
	Mission.Yorktown.Reload = false
end

function luaJM7ReloadEnterprise()
	Mission.Enterprise.Maxplanes = 24
	Mission.Enterprise.Reload = false
end

function luaJM7GetUnits(searchedType,searchedParty)
	local returnTbl = {}

	if type(searchedType) == "string" then --and recon[PARTY_JAPANESE].own.searchedType then
		for idx,unit in pairs(recon[searchedParty].own[searchedType]) do
			if not unit.Dead then
				table.insert(returnTbl, unit)
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog("No param or wrong param returning all ships")

		for idx,unitTbl in pairs(recon[searchedParty].own) do
			for idx2,unit in pairs(unitTbl) do
				if not unit.Dead and luaGetType(unit) == "ship" then
					--luaLog("Inserting "..unit.Name.." intotargetlist")
					table.insert(returnTbl, unit)
				end
			end
		end

	end

	return returnTbl
end

function luaJM7IsDisabled(ent)
	if not luaIsEntityTable({ent},false) then
-- RELEASE_LOGOFF  		luaLog("luaJM5IsDisabled got a wrong param")
-- RELEASE_LOGOFF  		luaLog(ent.Name)
		return
	end

	if GetFailure(ent, "InferiorFailure") then
		return true
	end

	return false
end

---USNCarrierFleet1
function luaJM7CheckUSNCarrierFleet1()
	if Mission.Fleet1CarriersDead or not Mission.Fleet1Ready then
		return
	end

	luaJM7IncPlanesDlgTrigger(Mission.Yorktown,Mission.Enterprise,1) --dlg trigger check

	--carriers
	if Mission.Yorktown and Mission.Yorktown.Dead then
		--luaLog("Yorktown died")
	else

		if Mission.Yorktown.Maxplanes <= 0 then

			if not Mission.Yorktown.Reload then
				luaDelay(luaJM7ReloadYorktown, 300)
				Mission.Yorktown.Reload = true
			end

		else

			luaJM7CheckMaxplanes(Mission.Yorktown)

			local fighterClassIDs = {101}
			local otherClassIDs = {108,113}
			local targetList = {}
				if next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting motherships")
					targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting battleships")
					targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting cargoships")
					targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
				else
					targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
				end
			luaAirfieldManager(Mission.Yorktown, fighterClassIDs, otherClassIDs, targetList, 300, 2)

		end
	end

	--[[ FPS BALTA
	if Mission.Enterprise and Mission.Enterprise.Dead then
		--luaLog("Enterprise died")
	else

		if Mission.Enterprise.Maxplanes <= 0 then

			if not Mission.Enterprise.Reload then
				luaDelay(luaJM7ReloadEnterprise, 300)
				Mission.Enterprise.Reload = true
			end

		else

			luaJM7CheckMaxplanes(Mission.Enterprise)
			local fighterClassIDs = {101}
			local otherClassIDs = {108,113}
			local targetList = {}
				if next(luaJM7GetUnits("destroyer",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting destroyers")
					targetList = luaJM7GetUnits("destroyer",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting motherships")
					targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting battleships")
					targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
				else
					targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
				end
			luaAirfieldManager(Mission.Enterprise	, fighterClassIDs, otherClassIDs, targetList, 300, 2)

		end

	end
	]]

	Mission.USNFleet1 = luaRemoveDeadsFromTable(Mission.USNFleet1)

	if table.getn(Mission.USNFleet1) == 0 then
		--luaLog("1st USN Fleet is dead")
		return
	end

	luaJM7ScreenTargeting(Mission.USNFleet1,1)

	--luaLog("yorkt 2nd command")
	--luaLog(GetProperty(Mission.Yorktown, "unitcommand"))

	--if Mission.Yorktown.Dead and Mission.Enterprise.Dead then
	if Mission.Yorktown.Dead then
		Mission.Fleet1CarriersDead = true
		local refunit = GetFormationLeader(Mission.USNFleet1[1])
		if refunit and not refunit.retreating then
			local point = GetClosestBorderZone(GetPosition(refunit))
			NavigatorMoveToPos(refunit, point)
			refunit.retreating = true
		else
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNFleet1)) do
				if not unit.retreating then
					local point = GetClosestBorderZone(GetPosition(unit))
					NavigatorMoveToPos(unit, point)
					unit.retreating = true
				end
			end
		end
		luaJM7StartDialog("Retreat")
	end
end

function luaJM7SumEnemyTables(...)
	--luaLog("--luaJM7SumEnemyTables--")
	local nmi = {}
	for idx,unitTbl in ipairs(arg) do
		--luaLog(unitTbl)
		for idx2,unit in pairs(unitTbl) do
			--luaLog(unit)
			if not unit.Dead then
				local index = unit.Class.Type
				if nmi[tostring(index)] == nil then
					nmi[tostring(index)] = {}
				end
				table.insert(nmi[tostring(index)], unit)
			end
		end
	end

	--luaLog(nmi)
	return nmi
end

function luaJM7USNFleet1PathListener()
	AddListener("command", "fleet1move", {
		["callback"] = "luaJM7ChangeUSNFleet1Path",  -- callback fuggveny
		["entity"] = Mission.USNFleet1, -- entityk akiken a listener aktiv
		["target"] = {}, -- a vizsgalt command celpontja
		["command"] = {"moveonpath"}, -- vizsgalt command pl. "moveonpath" (string)
		["status"] = {"finish"}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
		})
end

function luaJM7ChangeUSNFleet1Path()
	RemoveListener("command", "fleet1move")

	local path

	if not Mission.FirstChangeDone then
		local x = {FindEntity("USNCarrierPath2"), FindEntity("USNCarrierPath3")}
		path = luaPickRnd(x)
		Mission.FirstChangeDone = ture
	else
		path = FindEntity("USNCarrierPath1")
		Mission.FirstChangeDone = nil
	end

	local leader = GetFormationLeader(Mission.USNFleet1[1])
	NavigatorMoveOnPath(leader, path)
	luaJM7USNFleet1PathListener()
end

function luaJM7StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM7SpawnIJNInvasionFleet()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
	{
			["Type"] = 59,
			["Name"] = "Yamato1",
			["Crew"] = 3,
			["Race"] = Japan,
		},
		{
			["Type"] = 86,
			["Name"] = "Cargo1",
			["Crew"] = 2,
			["Race"] = Japan,
		},
		{
			["Type"] = 86,
			["Name"] = "Cargo2",
			["Crew"] = 2,
			["Race"] = Japan,
		},
		{
			["Type"] = 86,
			["Name"] = "Cargo3",
			["Crew"] = 2,
			["Race"] = Japan,
		},
		{
			["Type"] = 86,
			["Name"] = "Cargo4",
			["Crew"] = 2,
			["Race"] = Japan,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(FindEntity("IJNInvasionFleetSpawnPoint 01")),
		["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
		["lookAt"] = GetPosition(Mission.ShipyardLandingPoint),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7IJNInvasionFleetSpawned",
	["id"] = Mission.IJNInvasionReq,
})
end

function luaJM7IJNInvasionFleetSpawned(...)

	for idx,unit in ipairs(arg) do
		table.insert(Mission.IJNInvasionFleet, unit)
		if unit.Class.Type == "Cargo" then
			table.insert(Mission.IJNCargos, unit)
		elseif unit.Class.Type == "BattleShip" then
			Mission.Yamato = unit
			SetShipMaxSpeed(Mission.Yamato, (Mission.Yamato.Class.MaxSpeed * 1.5))
		end
	end

	for idx,unit in pairs(Mission.IJNInvasionFleet) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		if idx > 1 then
			JoinFormation(unit, Mission.IJNInvasionFleet[1])
		end
	end


	for idx, unit in pairs(Mission.IJNInvasionFleet) do
		SetGuiName(unit, Mission.IJNInvasionFleetNames[idx])
	end

	--luaJumpinMovieSetCurrentMovie("GoAround", Mission.IJNInvasionFleet[1].ID)
	if not Mission.CheckpointLoaded then
		luaJM7InvasionMovie()
	end

	NavigatorMoveToRange(Mission.IJNInvasionFleet[1], Mission.ShipyardLandingPoint)
	Mission.InvasionStarted = math.floor(GameTime())

	luaJM7StartDialog("JapInvFleetIn")
	luaJM7StartDialog("YamatoIn")
end

function luaJM7CheckInvasionPart(unitTbl, nmiCmd)

	--luaLog("luaJM7CheckInvasionPart called")

	local landingpoint
	--local InCaprange

	if nmiCmd.ID == Mission.CommandBuilding1.ID then
		landingpoint = 	Mission.ShipyardLandingPoint
		--InCaprange = "shipyardcaprange"
	elseif nmiCmd.ID == Mission.CommandBuilding2.ID then
		landingpoint = Mission.AirfieldLandingPoint
		--InCaprange = "airfieldcaprange"
	end

	--luaLog(unitTbl)

	for idx,unit in pairs(unitTbl) do
		--luaLog("----")
		if not unit.InCapRange then

			if luaGetDistance(unit, landingpoint) < 1200 then
-- RELEASE_LOGOFF  				luaLog("cap range")
				unit.InCapRange = true
			else
				local cmd = GetProperty(unit, "unitcommand")
				if cmd ~= "moveto" then
					NavigatorMoveToRange(unit, landingpoint)
				end
			end

		else

			if luaGetDistance(unit, landingpoint) < 200 then
				--luaLog("cargo in landingrange "..unit.Name)
				NavigatorStop(unit)
				StartLanding2(unit)
			end

		end

	end

end

---IJNInvasion Fleet
function luaJM7CheckInvasionFleet()
	Mission.IJNInvasionFleet = luaRemoveDeadsFromTable(Mission.IJNInvasionFleet)
	Mission.IJNCargos = luaRemoveDeadsFromTable(Mission.IJNCargos)

	if table.getn(Mission.IJNInvasionFleet) == 0 then
-- RELEASE_LOGOFF  		luaLog("IJNIvasionFleet is dead or being spawned")
		return
	end

	local nmiCmd = {}
	if Mission.CommandBuilding1.Party ~= PARTY_JAPANESE then
		table.insert(nmiCmd, Mission.CommandBuilding1)
	end
	if Mission.CommandBuilding2.Party ~= PARTY_JAPANESE then
		table.insert(nmiCmd, Mission.CommandBuilding2)
	end

	local need2reassign = false
	local YamatoNmis = {}

	if not Mission.NumNmi then
		Mission.NumNmi = table.getn(nmiCmd)
	else
		if Mission.NumNmi ~= table.getn(nmiCmd) then
			Mission.NumNmi = table.getn(nmiCmd)
			need2reassign = true
-- RELEASE_LOGOFF  			luaLog("need to reassign")
		end
	end

	if Mission.NumNmi == 0 then

-- RELEASE_LOGOFF  		luaLog("Everything is captured")

	else

		local j = 1
		for idx,unit in pairs(Mission.IJNCargos) do

			if not unit.assigned or need2reassign then
				--assign ships
				local index = math.mod(j,Mission.NumNmi) + 1
				table.insert(Mission.Fleets[index],unit)
				unit.assigned = true
				unit.InCapRange = false
				--
-- RELEASE_LOGOFF  				luaLog("assigning "..unit.Name.." to fleet "..tostring(index))

				j = j + 1
			end

			--possible yamato trg
			local x = luaGetShipsAround(unit, 2000, "enemy")
			if x then
				for k,v in pairs(x) do
					table.insert(YamatoNmis, v)
				end
			end

		end

		local j = 1
		for idx,cmd in pairs(nmiCmd) do
			local index = math.mod(j,Mission.NumNmi) + 1
			luaJM7CheckInvasionPart(Mission.Fleets[index], cmd)
			j = j + 1
		end

	end

	if not Mission.Yamato.Dead then
		if luaGetScriptTarget(Mission.Yamato) == nil or luaGetScriptTarget(Mission.Yamato).Dead then

			local trg
			if next(YamatoNmis) then
				trg = luaSortByDistance2(Mission.Yamato, YamatoNmis, true)

			else

				local trglist = luaGetShipsAround(Mission.Yamato, 3500, "enemy")
				if trglist then
					trg = luaSortByDistance2(Mission.Yamato, trglist, true)
				end

			end

			if trg and not trg.Dead then
				NavigatorAttackMove(Mission.Yamato, trg, {})
				luaSetScriptTarget(Mission.Yamato, trg)
			end

		end
	end

end

function luaJM7GetInvasionFleetLeader()
	Mission.IJNInvasionFleet = luaRemoveDeadsFromTable(Mission.IJNInvasionFleet)
	for idx,unit in pairs(Mission.IJNInvasionFleet) do
		if IsInFormation(unit) then
			return GetFormationLeader(unit)
		end
	end

	--luaLog("ooops invasion fleetnek nincse leadere")
	--for idx,unit in pairs(Mission.IJNInvasionFleet) do
	--	if idx > 1 then
	--		JoinFormation(unit, Mission.IJNInvasionFleet[1])
	--	end
	--end
	return Mission.IJNInvasionFleet[1]
end

---USNreinf
function luaJM7SpawnUSNReinf()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 317,
			["Name"] = "Northampton1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 315,
			["Name"] = "Yorktown1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
			["NumSlots"] = 4,
			["MaxInAirPlanes"] = 12,
			["PlaneStock 1"] = {
				["Type"] = 101,
				["Count"] = 20,
				["SquadLimit"] = 5,
			},
			["Slot 1"] = {
				["Type"] = 101,
				["Arm"] = 0,
				["Count"] = 3,
			},
		},
--		{
--			["Type"] = 19,
--			["Name"] = "Northampton2",
--			["Crew"] = Mission.SkillLevel,
--			["Race"] = USA,
--		},
--		{
--			["Type"] = 19,
--			["Name"] = "Northampton3",
--			["Crew"] = Mission.SkillLevel,
--			["Race"] = USA,
--		},
		{
			["Type"] = 23,
			["Name"] = "Fletcher1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Fletcher2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
--		{
--			["Type"] = 23,
--			["Name"] = "Fletcher3",
--			["Crew"] = Mission.SkillLevel,
--			["Race"] = USA,
--		},
	--	{
	--		["Type"] = 23,
	--		["Name"] = "Fletcher4",
	--		["Crew"] = Mission.SkillLevel,
	--		["Race"] = USA,
	--	},
	--	{
	--		["Type"] = 23,
	--		["Name"] = "Fletcher5",
	--		["Crew"] = Mission.SkillLevel,
	--		["Race"] = USA,
	--	},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.USNReinforcementSPawnPoint),
		["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
		["lookAt"] = GetPosition(Mission.ShipyardLandingPoint),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7USNReinfFleetSpawned",
	["id"] = Mission.USNReinfReq,
})
end

function luaJM7USNReinfFleetSpawned(...)
	local leader
	for idx,unit in ipairs(arg) do
		SetSkillLevel(unit, Mission.SkillLevel)
		table.insert(Mission.USNReinforcements, unit)

		if idx == 1 then
			leader = unit
		end

		if unit.Class.Type == "MotherShip" then
			if string.find(unit.Name, "Yorktown") then
				if unit.Class.ID == 315 then
					--Mission.Hornet = unit
					Mission.Enterprise = unit
				end
			end
		end
	end

	for idx,unit in pairs(Mission.USNReinforcements) do
		if unit.ID ~= Mission.Enterprise.ID then
		--if unit.ID ~= leader.ID then
			--JoinFormation(unit, Mission.Hornet)
			JoinFormation(unit, Mission.Enterprise)
			--JoinFormation(unit, leader)
		end
	end

	for idx, unit in pairs(Mission.USNReinforcements) do
-- RELEASE_LOGOFF  		luaLog("assigning name "..Mission.USNReinfFleetNames[idx][1].." to "..unit.Name)
		SetGuiName(unit, Mission.USNReinfFleetNames[idx][1])
		SetNumbering(unit, Mission.USNReinfFleetNames[idx][2])
	end

	--NavigatorMoveOnPath(Mission.Hornet, FindEntity("USNReinfPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(leader, FindEntity("USNReinfPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	Mission.USNReinfIn = true
end

function luaJM7CheckUSNCarrierFleet2()
	if Mission.Fleet2CarriersDead or not Mission.USNReinfIn then
		return
	end

	--unlock
	--if Scoring_IsUnlocked("JM6_GOLD") and not Mission.Hornet.Dead then
-- RELEASE_LOGOFF  	--	luaLog("Challenge was gold, killing lex after spawn")
	--	Kill(Mission.Hornet, true)
	--end

	Mission.USNReinforcements = luaRemoveDeadsFromTable(Mission.USNReinforcements)

	--luaJM7IncPlanesDlgTrigger(Mission.Hornet,nil,2) --dlg trigger check

	--carriers
	--if Mission.Hornet.Dead then
	if Mission.Enterprise.Dead then
-- RELEASE_LOGOFF  		luaLog("Enterprise dead")
	else
		local fighterClassIDs = {101}
		local otherClassIDs = {108,113}
		local targetList = {}
			if next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
				--luaLog("Getting motherships")
				targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
			elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
				--luaLog("Getting battleships")
				targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
			elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
				--luaLog("Getting cargoships")
				targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
			else
				targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
			end
		--luaAirfieldManager(Mission.Hornet, fighterClassIDs, otherClassIDs, targetList)
		luaAirfieldManager(Mission.Enterprise, fighterClassIDs, otherClassIDs, targetList, 300, 2)
		luaJM7ScreenTargeting(Mission.USNReinforcements,2)
	end

	if table.getn(Mission.USNReinforcements) == 0 then
-- RELEASE_LOGOFF  		luaLog("1st USN Fleet is dead")
		return
	end

	--if Mission.Hornet.Dead then
	if Mission.Enterprise.Dead then
		Mission.Fleet2CarriersDead = true
		for idx,unit in pairs(Mission.USNReinforcements) do
			if not unit.Dead and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
				local trgGrp
				local trg
				if Mission.InvasionStarted and table.getn(luaRemoveDeadsFromTable(Mission.IJNInvasionFleet)) > 0 then
					trgGrp = luaRemoveDeadsFromTable(Mission.IJNInvasionFleet)
				else
					trgGrp = luaRemoveDeadsFromTable(Mission.PlayerFleet)
				end
				trg = luaPickRnd(trgGrp)
				if trg and not trg.Dead then
					NavigatorAttackMove(unit, trg, {})
					luaSetScriptTarget(unit, trg)
				end
			end
		end
	end
end

function luaJM7TorpCheat(unit)
	if unit and not unit.Dead then
		local stock = GetProperty(unit, "TorpedoStock")
		if stock == 0 then
			ReloadTorpedoes(unit, unit.Class.MaxTorpedoStock)
		end
	end
end

function luaJM7ScreenTargeting(screen,fleetNum)
	screen = luaRemoveDeadsFromTable(screen)

	local CV1
	local CV2

	if fleetNum == 1 then
		CV1 = Mission.Yorktown
		--CV2 = Mission.Enterprise
	elseif fleetNum == 2 then
		--CV1 = Mission.Hornet
		CV1 = Mission.Enterprise
	end

	local shipsAroundCV1 = {}
	local shipsAroundCV2 = {}

	if not CV1.Dead then
		shipsAroundCV1 = luaGetShipsAround(CV1, 4000, "enemy")
	end
	--if CV2 and not CV2.Dead then
	--	shipsAroundCV2 = luaGetShipsAround(CV2, 3300, "enemy")
	--end

	local enemiesTable = luaJM7SumEnemyTables(shipsAroundCV1,shipsAroundCV2)
	--luaLog("-------")
	--luaLog(enemiesTable)

	--targeting ha kozel vannak az enemi hajok
	for idx,unit in pairs(screen) do
		if unit.Class.Type == "Destroyer" then
			--luaLog("kimennek BBket es CA-kat torpedozni")
			local trgTbl = {}
			if enemiesTable["BattleShip"] and next(enemiesTable["BattleShip"]) ~= nil then
				for idx2,nmi in pairs(enemiesTable["BattleShip"]) do
-- RELEASE_LOGOFF  					luaLog("Adding BB into the table")
					table.insert(trgTbl, nmi)
				end
			end
			if enemiesTable["Cruiser"] and next(enemiesTable["Cruiser"]) ~= nil then
				for idx2,nmi in pairs(enemiesTable["Cruiser"]) do
-- RELEASE_LOGOFF  					luaLog("Adding cruiser into the table")
					table.insert(trgTbl, nmi)
				end
			end

			--luaLog(trgTbl)

			if next(trgTbl) ~= nil then
				local trg = luaPickRnd(trgTbl)
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					LeaveFormation(unit)
					luaSetScriptTarget(unit, trg)
					luaJM7SetSkillLvlOptions(unit)

					if Mission.Difficulty == 2 then
						luaJM7TorpCheat(unit)
					end

					NavigatorAttackMove(unit, trg, {})
-- RELEASE_LOGOFF  					luaLog("unit "..unit.Name.." is going to attack "..trg.Name)
				end
			else
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					if not IsInFormation(unit) then
						if not CV1.Dead then
							JoinFormation(unit, CV1)
						elseif not CV2 then
							JoinFormation(unit, CV2)
						end
					end
				end
			end

		elseif unit.Class.Type == "Cruiser" then

			--kimennek DDket olni
			local trgTbl = {}
			if enemiesTable["Destroyer"] and next(enemiesTable["Destroyer"]) ~= nil then
				for idx2,nmi in pairs(enemiesTable["Destroyer"]) do
					table.insert(trgTbl, nmi)
-- RELEASE_LOGOFF  					luaLog("Adding DD into the table")
				end
			end

			if next(trgTbl) ~= nil then
				local trg = luaPickRnd(trgTbl)
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					LeaveFormation(unit)
					luaSetScriptTarget(unit, trg)
					NavigatorAttackMove(unit, trg, {})
-- RELEASE_LOGOFF  					luaLog("unit "..unit.Name.." is going to attack "..trg.Name)
				end
			else
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					if not IsInFormation(unit) then
						if not CV1.Dead then
							JoinFormation(unit, CV1)
						elseif not CV2.Dead then
							JoinFormation(unit, CV2)
						end
					end
				end
			end

		end
	end
end

---shipyard
function luaJM7CheckShipyards()
	--sy1
	--[[

	if Mission.Shipyard1.Party ~= PARTY_ALLIED or Mission.Shipyard1.Dead or luaJM7IsDisabled(Mission.Shipyard1) then
-- RELEASE_LOGOFF  		luaLog("Shipyard1 dead or disabled or seized")
	else
		Mission.Shipyard1Ships = luaRemoveDeadsFromTable(Mission.Shipyard1Ships)

		if table.getn(Mission.Shipyard1Ships) <= 2 then
-- RELEASE_LOGOFF  			luaLog("SY1 shiptable count: "..tostring(table.getn(Mission.Shipyard1Ships)))
			if not SpawnNewIDIsRequested(Mission.Shipyard1SpawnReq) then
-- RELEASE_LOGOFF  				luaLog("Requesting SY1 spawn - Fletcher")
				luaJM7SpawnShipyardShip(1)
			end
		end

		for idx,unit in pairs(Mission.Shipyard1Ships) do
			if not unit.Dead then
				local nmiShips = luaGetShipsAround(unit, 2000, "enemy")
				if nmiShips ~= nil and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
					local trg = luaPickRnd(nmiShips)
					luaJM7TorpCheat(unit)
					TorpedoEnable(unit,true)
					NavigatorAttackMove(unit, trg, {})
					luaSetScriptTarget(unit, trg)
				elseif nmiShips == nil and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
					local cmd = GetProperty(unit, "unitcommand")
					if cmd ~= "moveonpath" then
						NavigatorMoveOnPath(unit, Mission.SY1PatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN)
					end
				end
			end
		end
	end
	]]

	--sy2
	if Mission.Shipyard2.Party ~= PARTY_ALLIED or Mission.Shipyard2.Dead or luaJM7IsDisabled(Mission.Shipyard2) then
		--luaLog("Shipyard2 dead or disabled or seized")
	else
		Mission.Shipyard2Ships = luaRemoveDeadsFromTable(Mission.Shipyard2Ships)

		if table.getn(Mission.Shipyard2Ships) <= 1 then
			--luaLog("SY2 shiptable count: "..tostring(table.getn(Mission.Shipyard2Ships)))
			if not SpawnNewIDIsRequested(Mission.Shipyard2SpawnReq) then
				if math.floor(GameTime()) - Mission.LastShipyardSpawn > Mission.ShipyardSpawnInterval then
-- RELEASE_LOGOFF  					luaLog("Requesting SY12 spawn - Elco")
					luaJM7SpawnShipyardShip(2)
				end
			end
		end

		for idx,unit in pairs(Mission.Shipyard2Ships) do
			if not unit.Dead then
				local nmiShips = luaGetShipsAround(unit, 2000, "enemy")
				if nmiShips ~= nil and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
					local trg = luaPickRnd(nmiShips)
					luaJM7SetSkillLvlOptions(unit)

					if Mission.Difficulty == 2 then
						luaJM7TorpCheat(unit)
					end

					NavigatorAttackMove(unit, trg, {})
					luaSetScriptTarget(unit, trg)
				elseif nmiShips == nil and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
					local cmd = GetProperty(unit, "unitcommand")
					if cmd ~= "moveonpath" then
						NavigatorMoveOnPath(unit, Mission.SY2PatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN)
					end
				end
			end
		end
	end

end


function luaJM7SpawnShipyardShip(shipyardNum)
	local grpTbl
	local req
	local refPoint
	if shipyardNum == 1 then
		grpTbl = {
			["Type"] = 23,
			["Name"] = "Fletcher1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		}
		req = Mission.Shipyard1SpawnReq
		refPoint = Mission.SY1SpawnPoint
	elseif shipyardNum == 2 then
		grpTbl = {
			["Type"] = 27,
			["Name"] = "PT Elco",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		}
		req = Mission.Shipyard2SpawnReq
		refPoint = Mission.SY2SpawnPoint
	end

	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {grpTbl},
		["area"] = {
			["refPos"] = GetPosition(refPoint),
			["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
			--["direction"] = Mission.USNSPawnDir,
			["lookAt"] = GetPosition(Mission.CommandBuilding2),
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		["callback"] = "luaJM7ShipyardShipSpawned",
		["id"] = req,
	})
end

function luaJM7ShipyardShipSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("luaJM7ShipyardShipSpawned called")
-- RELEASE_LOGOFF  	luaLog("spawnedunit type: "..unit.Class.Type)

	SetSkillLevel(unit, Mission.SkillLevel)

	if unit.Class.Type == "Destroyer" then
		table.insert(Mission.Shipyard1Ships, unit)
		NavigatorMoveOnPath(unit, Mission.SY1PatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN)
-- RELEASE_LOGOFF  		luaLog("Inserting DD into SH1Table")
	elseif unit.Class.Type == "TorpedoBoat" then
		table.insert(Mission.Shipyard2Ships, unit)
		NavigatorMoveOnPath(unit, Mission.SY2PatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN)
-- RELEASE_LOGOFF  		luaLog("Inserting TorpBoat into SH2Table")
	end
	Mission.LastShipyardSpawn = math.floor(GameTime())
end

--listener
function luaJM7AddCVReconListener()
	AddListener("recon", "CVrecon", {
		["callback"] = "luaJM7CVsSighted",  -- callback fuggveny
		--["entity"] = {Mission.Yorktown, Mission.Enterprise}, -- entityk akiken a listener aktiv
		["entity"] = {Mission.Yorktown}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM7AddAtlantaListener()
	AddListener("recon", "atlantarecon", {
		["callback"] = "luaJM7AtlantaRecon",  -- callback fuggveny
		["entity"] = {Mission.Atlanta}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})


	AddListener("kill", "atlantakill", {
		["callback"] = "luaJM7AtlantaKill",  -- callback fuggveny
		["entity"] = {Mission.Atlanta}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

--listener
function luaJM7AddSubReconListener()
	AddListener("recon", "Subrecon", {
		["callback"] = "luaJM7SubSighted",  -- callback fuggveny
		["entity"] = {Mission.Nautilus}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM7SubSighted()
	RemoveListener("recon", "Subrecon")
	luaJM7StartDialog("Subseen")
	luaJM7SubHint()
end

function luaJM7AtlantaRecon()
	RemoveListener("recon", "atlantarecon")
	luaJM7StartDialog("AtlantaSighted")
	if not luaObj_IsActive("secondary", 1) then
		luaObj_Add("secondary",1)
		luaJM7Sec1Score()
	end
	if not Mission.CheckpointLoaded then
		luaJM7AtlantaMovie()
	end
end

function luaJM7AtlantaKill()
	RemoveListener("kill", "atlantakill")
	luaJM7StartDialog("AtlantaKilled")
	if not luaObj_GetSuccess("secondary", 1) then
		luaObj_Completed("secondary", 1)
		--RemoveUnitHP(Mission.Atlanta)
		HideUnitHP()
	end
end


function luaJM7CVsSighted(...)
	--for idx,x in ipairs(arg) do
-- RELEASE_LOGOFF  	--	luaLog(idx)
-- RELEASE_LOGOFF  	--	luaLog(x)
	--end
	RemoveListener("recon", "CVrecon")
	Mission.CVsSighted = true
end

----
function luaJM7ISPlayerInRecon()
	for idx,unitTbl in pairs(recon[PARTY_ALLIED].enemy) do
		for idx2,unit in pairs(unitTbl) do
			if unit and unit.Class.Type ~= "SmallReconPlane" then -- luaGetType(unit) == "ship" then
				--Mission.PlayerSighted = true
				luaJM7FusoHint()
				luaJM7StepPhase()
				luaJM7StartDialog("PlayerInRecon",true)
				luaJM7StartAFManager()
				return
			end
		end
	end
end

function luaJM7AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM7FadeIn()

	Blackout(true, "", 0)

	--if not Mission.CheckpointLoaded then
		--SoundFade(1, "",0.1)
	--end
	--luaLog("ittttttt")
	if not Mission.CheckpointLoaded then
		Blackout(false, "", 2)
	end
end

function luaJM7StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM6StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM6StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM7IncPlanesDlgTrigger(CV1,CV2,num) --2 carrier, es elso vagy reinf vizsgalat e

	if num == 1 and (Mission.NmiPlanesInrecon1 or Mission.CVsSighted) then
		return
	end

	if num == 2 and Mission.NmiPlanesInrecon2 then
		return
	end

	local CV1Planes = {}
	local CV2Planes = {}
	local sumPlanes = {}

	if CV1 and not CV1.Dead then
		_dummy, CV1Planes = luaGetSlotsAndSquads(CV1)
	end

	if CV2 and not CV2.Dead then
		_dummy, CV2Planes = luaGetSlotsAndSquads(CV2)
	end

	sumPlanes = luaSumTablesIndex(CV1Planes,CV2Planes)
	for idx,unit in pairs(sumPlanes) do
		for idx2,unit2 in pairs(luaRemoveDeadsFromTable(Mission.PlayerFleet)) do
			if luaGetDistance(unit,unit2) < 2900 then
				if num == 1 then
					Mission.NmiPlanesInrecon1 = true
					luaJM7StartDialog("NmiPlanesIncom")
				elseif num == 2 then
					Mission.NmiPlanesInrecon2 = true
					luaJM7StartDialog("NmiReinfIn")
				end
			end
		end
	end
end

function luaJM7AddSYListener()
	AddListener("recon", "SYRecon", {
		["callback"] = "luaJM7SYSighted",  -- callback fuggveny
		--["entity"] = {Mission.Shipyard1, Mission.Shipyard2}, -- entityk akiken a listener aktiv
		["entity"] = {Mission.Shipyard2}, -- entityk akiken a listener aktiv
		["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

function luaJM7SYSighted()
	RemoveListener("recon", "SYRecon")
	luaJM7StartDialog("ShipyardInRecon")
end

function luaJM7UnlockDlg()
	luaJM7StartDialog("UnlockSub")
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(314)
	PrepareClass(315)
	PrepareClass(317)
	PrepareClass(23)
	PrepareClass(27)
	PrepareClass(31)
	PrepareClass(60)
	PrepareClass(70)
	PrepareClass(275)
	PrepareClass(224)
	PrepareClass(93)
	PrepareClass(167)
	PrepareClass(133)
	Loading_Finish()
end

function luaJM7SetGuiNames()
-- RELEASE_LOGOFF  	luaLog("allitom a guineveket")


	for idx, unit in pairs(Mission.PlayerFleet) do
		local oldID = unit.Class.ID

		if IsClassChanged(oldID) then

			luaSetUnlockName(unit)

		else
			SetGuiName(unit, Mission.PlayerFleetNames[idx])
		end

	end

	--for idx, unit in pairs(Mission.USNFleet1) do
	--	SetGuiName(unit, Mission.USNFleet1Names[idx][1])
	--	SetNumbering(unit, Mission.USNFleet1Names[idx][2])
	--end
end

function luaJM7CheckAirGuns()

	if Mission.CommandBuilding2.Party ~= Mission.PrevParty then

		for idx,gun in pairs(Mission.AirGuns) do
			SetParty(gun, Mission.CommandBuilding2.Party)
		end

		Mission.PrevParty = Mission.CommandBuilding2.Party
	end
end

function luaJM7CheckSub()

	if Mission.Nautilus.Dead then
		return
	end

	luaJM7TorpCheat(Mission.Nautilus)

	if luaGetScriptTarget(Mission.Nautilus) == nil or luaGetScriptTarget(Mission.Nautilus).Dead then

		local targetList = {}
		local trg
		if next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
			targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
		elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
			targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
		elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
			targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
		else
			targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
		end
		trg = luaPickRnd(targetList)
		if trg and not trg.Dead then
			NavigatorAttackMove(Mission.Nautilus, trg, {})
		end
	end
end

function luaJM7SubHint()
	ShowHint("IJN07_Hint01")
end

function luaJM7FusoHint()
	ShowHint("IJN07_Hint02")
end

function luaJM7CAPHint()
	ShowHint("IJN07_Hint03")
	Mission.CAPHintOk = true
end

function luaJM7AirstrikeHint()
	ShowHint("IJN07_Hint04")
end

function luaJM7CargoHint()
	ShowHint("IJN11_AK")
end

function luaJM7CVsInvincible()
	if not Mission.Kaga.Dead then
		SetInvincible(Mission.Kaga, true)
	end
	if not Mission.Hiryu.Dead then
		SetInvincible(Mission.Hiryu, true)
	end
end

function luaJM7AddAFMovie()
	luaJumpinMovieSetCurrentMovie("JumpTo", GetPosition(FindEntity("MoviePoint")), GetPosition(FindEntity("MovieLookatPoint")))
end

function luaJM7AtlantaPathListener()
	AddListener("command", "atlantamove", {
		["callback"] = "luaJM7AtlantaStop",  -- callback fuggveny
		["entity"] = {Mission.Atlanta}, -- entityk akiken a listener aktiv
		["target"] = {}, -- a vizsgalt command celpontja
		["command"] = {"moveonpath"}, -- vizsgalt command pl. "moveonpath" (string)
		["status"] = {"finish"}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
		})
end

function luaJM7AtlantaStop()
	RemoveListener("command", "atlantamove")
	NavigatorStop(Mission.Atlanta)
end

function luaJM7AtlantaGo()
	NavigatorMoveOnPath(Mission.Atlanta, FindEntity("AtlantaPath"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	luaJM7AtlantaPathListener()
end

function luaJM7Pri1Score()
	local _,hd = luaJM7AirfieldObj()
	Mission.HangarsDestroyed = hd
	local line1 = "ijn07.obj_p1_onscreen"
	local line2 = "ijn07.obj_p1_onscreen2"
	luaJM7DisplayScore(1,line1,line2)
end

function luaJM7Pri2Score()
	local line1 = "ijn07.obj_p2"
	luaJM7DisplayScore(2,line1,"")
end

function luaJM7Pri3Score()
	--Mission.CarriersSunk
	local line1 = "ijn07.obj_p3_onscreen"
	local line2 = "ijn07.hint_5_desc"
	luaJM7DisplayScore(3,line1,line2)
end

function luaJM7Sec1Score()

	local i = 0
	for idx,score in pairs(Mission.ScoreDisplay) do
		if score then
			i = i + 1
		end
	end

	if i > 2 then
		if Mission.AtlantaScoreDisplayed then
			HideUnitHP()
			Mission.AtlantaScoreDisplayed = false
		end
		return
	end

	DisplayUnitHP({Mission.Atlanta}, "ijn07.obj_s1")
	Mission.AtlantaScoreDisplayed = true

end

function luaJM7Sec2Score()
	--Mission.SqLaunched
	local line1 = "ijn07.obj_s2_onscreen"
	local line2 = "ijn07.hint_6_desc"
	luaJM7DisplayScore(4,line1,line2)
end

function luaJM7DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM7RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

function luaJM7PauseAirstrike()
	if Mission.AFPauseReset then
		Mission.AFPauseReset = false
	end
	return math.floor(GameTime()) + random(300,480)
end

function luaJM7IsEnemyNear()
	local shipsAround
	local planesAround

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerFleet)) do
		shipsAround = luaGetShipsAround(unit, 3200, "enemy")
		if shipsAround then
			return true
		end
		planesAround = luaGetPlanesAround(unit, 3200, "enemy")
		if planesAround then
			return true
		end
	end
	return false
end

-----------------------------moviez-----------------------------------------
function luaJM7MovieInit()
	Mission.MovieUnitPL = GetSelectedUnit()
	if Mission.MovieUnitPL then
		SetInvincible(Mission.MovieUnitPL, 0.1)
	end
end

function luaJM7SelectUnit()
	if Mission.MovieUnitPL then
		SetSelectedUnit(Mission.MovieUnitPL)
		SetInvincible(Mission.MovieUnitPL, false)
		Mission.MovieUnitPL = nil
	end
	EnableInput(true)
end

function luaJM7AFMovie()
	if IsListenerActive("input", "IngameMovieInputListenerID") then
		luaDelay(luaJM7AFMovie, 5)
		return
	end
	luaDelay(luaJM7AFMFlag, 20)
	luaJM7MovieInit()
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield1, ["distance"] = 200, ["theta"] = 15, ["rho"] = 259, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield1, ["distance"] = 200, ["theta"] = 15, ["rho"] = 10, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield2, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield2, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield3, ["distance"] = 200, ["theta"] = 15, ["rho"] = 20, ["moveTime"] = 0,},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield3, ["distance"] = 200, ["theta"] = 15, ["rho"] = 300, ["moveTime"] = 5},
		},	luaJM7SelectUnit )
end

function luaJM7AFMFlag()
	Mission.AFMovieOK = true
end

function luaJM7InvasionMovie()
	if IsListenerActive("input", "IngameMovieInputListenerID") then
		luaDelay(luaJM7InvasionMovie, 5)
		return
	end
	luaJM7MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.IJNInvasionFleet[1], ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.IJNInvasionFleet[1], ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM7SelectUnit)
end

function luaJM7CarrierMovie()
	if IsListenerActive("input", "IngameMovieInputListenerID") then
		luaDelay(luaJM7CarrierMovie, 5)
		return
	end
	luaJM7MovieInit()

	local unit
	if Mission.Yorktown and not Mission.Yorktown.Dead then
		unit = Mission.Yorktown
	elseif Mission.Enterprise and not Mission.Enterprise.Dead then
		unit = Mission.Enterprise
	else
		luaJM7SelectUnit()
		return
	end

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM7SelectUnit)
end

function luaJM7AtlantaMovie()
	if IsListenerActive("input", "IngameMovieInputListenerID") then
		luaDelay(luaJM7AtlantaMovie, 5)
		return
	end
	luaJM7MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Atlanta, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Atlanta, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM7SelectUnit)
end

function luaJM7IsHintActive(hintID)

	local hintTbl = IsHintActive()

	if hintTbl == nil then
		return false
	else
		for idx,hint in pairs(hintTbl) do
			if string.find(hintTbl.HintID,"IJN07") or IsHintCritical(hintTbl.HintID) then
				return true
			end
		end
		return false
	end

	return true

end

---checkpoints
function luaJM7SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	luaRegisterCheckpointData("NavPoints", "NavpointTbl", GetPosition(FindEntity("FleetChck")))
	if Mission.Atlanta and not Mission.Atlanta.Dead then
		Mission.Checkpoint.AtlantaPos = GetPosition(Mission.Atlanta)
	end
	Mission.Checkpoint.USNReinfCalled = Mission.USNReinfCalled
end

function luaJM7LoadMissionData()
	--Blackout(true, "", 0.5)
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]

	Mission.USNReinfCalled = Mission.Checkpoint.USNReinfCalled
	--if Mission.USNReinfCalled then
		--luaJM7SpawnUSNReinf() --delay vajh kell e, bejonnek idoben?
	--end

	local japUnits = luaGetCheckpointData("Units", "JapUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units")
	for idx,unit in pairs(Mission.PlayerFleet) do
		local found = false
		for idx2,unitTbl in pairs(japUnits[1]) do
			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end

		if unit and not unit.Dead and IsInFormation(unit) then
			LeaveFormation(unit)
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit leaves formation: "..unit.Name)
		end

	end

	local USUnits = luaGetCheckpointData("Units", "USUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking allied units")
	for idx,unit in pairs(luaSumTablesIndex({Mission.Atlanta})) do
		local found = false
		for idx2,unitTbl in pairs(USUnits[1]) do
			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	--PutTo
	luaDelay(luaJM7PutUnits,2)
end

function luaJM7PutUnits()
-- RELEASE_LOGOFF  	luaLog("luaJM7PutUnits called")
	local tbl = luaGetCheckpointData("NavPoints", "NavpointTbl")
	local navPoint = tbl[1]
	local angle = luaGetAngle("world", navPoint, GetPosition(Mission.CommandBuilding1))
	local leader = Mission.PlayerFleet[1]

	--PutTo(leader, navPoint, -angle)
	PutFormationTo(leader, navPoint, -angle)
	local i = 1
	local x = 100
	local z = -100
	local multi = {[1] = 1, [2] = -1,}

	--for idx,unit in pairs(Mission.PlayerFleet) do

		--if not unit.Dead and unit.ID ~= leader.ID then
			--luaLog("unit: "..unit.Name)
			--local relTbl = {
			--	["x"] = x * i * multi[math.fmod(i,2)+1],
			--	["y"] = 0,
			--	["z"] = z * i,
			--}
			--luaLog("relTbl")
			--luaLog(relTbl)
			--luaLog(leader.Name)
			--PutRelTo(unit, leader, relTbl)
			--JoinFormation(unit, leader)
			--i = i + 1
		--end

	--end

	SetShipSpeed(leader, 10)
	SetSelectedUnit(leader)

	if Mission.Atlanta and not Mission.Atlanta.Dead and Mission.Checkpoint.AtlantaPos then
		PutTo(Mission.Atlanta, Mission.Checkpoint.AtlantaPos)
	end

	--SoundFade(1, "",0.5)
	Blackout(false, "luaJM7AddInput", 2.5)
-- RELEASE_LOGOFF  	luaLog("ezt kene")
end

function luaJM7AddInput()
	EnableInput(true)
end

function luaJM7HangarHPOverride()
	local ents = {
		FindEntity("Hangar, Large, 08 01"),
		FindEntity("Hangar, Large, 08 02"),
		FindEntity("Hangar, Large, 08 03"),
		FindEntity("AirFieldEntity 01"),
		FindEntity("AirFieldEntity 02"),
		FindEntity("AirFieldEntity 03")
	}

	for idx,ent in pairs(ents) do
		OverrideHP(ent, 2500)
	end
end

------airfields--------
function luaJM7StartAFManager()
	Mission.FlakManager = CreateScript("luaJM7AFInit")
end

function luaJM7AFInit(this)
	--luaLog("FM called")
	SetThink(this, "luaJM7AF_Think")
end

function luaJM7AF_Think(this, msg)

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	luaJM7AirfieldIsActive()

	if Mission.CommandBuilding2.Party ~= PARTY_ALLIED then
		return
	end

	if Mission.AFNextPause == nil then
		Mission.AFNextPause = luaJM7PauseAirstrike()
	end

	if math.floor(GameTime()) > Mission.AFNextPause then

		if not Mission.AFPauseReset then
			luaDelay(luaJM7PauseAirstrike, random(60,180))
			Mission.AFPauseReset = true
		end
		return
	end

	--airfield1
	if not Mission.Airfield1.HiddenDisabled then
		if Mission.Airfield1.Dead or luaJM7IsDisabled(Mission.Airfield1) then
-- RELEASE_LOGOFF  			luaLog("Airfield1 is disabled")
			if Mission.Airfield1.Maxplanes <= 0 then
-- RELEASE_LOGOFF  				luaLog("Airfield1 has no more planes")
				if not Mission.Airfield1.Reload then
					luaDelay(luaJM7ReloadAF1, 300)
					Mission.Airfield1.Reload = true
				end
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield1)
			local activeSquads, squadTable = luaGetSlotsAndSquads(Mission.Airfield1)
			if activeSquads < 4 and IsReadyToSendPlanes(Mission.Airfield1) then
				LaunchSquadron(Mission.Airfield1, 133, 3)
			end
			if squadTable then
				Mission.AirPatrol = luaAirPatrol(Mission.Airfield1, 1500, 3000, squadTable, Mission.AirPatrol)
			end
		end
	end

	--airfield2
	if not Mission.Airfield2.HiddenDisabled then
		if Mission.Airfield2.Dead or luaJM7IsDisabled(Mission.Airfield2) or not Mission.Airfield2.Active then
			if Mission.Airfield2.Maxplanes <= 0 then
-- RELEASE_LOGOFF  				luaLog("Airfield2 has no more planes")
				if not Mission.Airfield2.Reload then
					luaDelay(luaJM7ReloadAF2, 300)
					Mission.Airfield2.Reload = true
				end
			else
-- RELEASE_LOGOFF  				luaLog("Airfield2 is disabled ")
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield2)
			local fighterClassIDs = {133}
			local otherClassIDs = {108,113,108,113}

			if Mission.Airfield2StrikeOngoing then
				Mission.Airfield2Ents = luaRemoveDeadsFromTable(Mission.Airfield2Ents)
				if table.getn(Mission.Airfield2Ents) == 0 then
					Mission.Airfield2StrikeOngoing = false
					Mission.Airfield2Phase = 1
				end
			end

			if Mission.Airfield2Phase == 3 then --5

				local targetList = {}
				if next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting motherships")
					targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting cargoships")
					targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting battleships")
					targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
				else
					targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
				end

				local trg = luaPickRnd(targetList)
				for idx2,squadron in pairs(Mission.Airfield2Ents) do
					if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
						--lualog("-------------")
						--lualog(squadron)
						local ammo = GetProperty(squadron, "ammoType")
						if ammo ~= 0 then
							luaSetScriptTarget(squadron, trg)
							PilotSetTarget(squadron, trg)
						end
					end
				end
				Mission.Airfield2StrikeOngoing = true

			elseif Mission.Airfield2Phase < 3 then --5

				Mission.Airfield2Phase, Mission.Airfield2Ents, errorLvl = luaLaunchAirstrike(Mission.Airfield2Phase, 3, {Mission.Airfield2}, otherClassIDs, Mission.Airfield2Ents) --5
				Mission.Airfield2StrikeOngoing = false

			end

			--luaAirfieldManager(Mission.Airfield2, fighterClassIDs, otherClassIDs, targetList)
		end
	end

	--airfield3
	if not Mission.Airfield3.HiddenDisabled then
		if Mission.Airfield3.Dead or luaJM7IsDisabled(Mission.Airfield3) or not Mission.Airfield3.Active then
			if Mission.Airfield3.Maxplanes <= 0 then
-- RELEASE_LOGOFF  				luaLog("Airfield3 has no more planes")
				if not Mission.Airfield3.Reload then
					luaDelay(luaJM7ReloadAF3, 300)
					Mission.Airfield3.Reload = true
				end
			else
-- RELEASE_LOGOFF  				luaLog("Airfield3 is disabled")
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield3)
			local fighterClassIDs = {116}
			local otherClassIDs = {116,116,116,116}

			if Mission.Airfield3StrikeOngoing then
				--luaLog("itt")
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfield3Ents)) == 0 then
					Mission.Airfield3Ents = {}
					Mission.Airfield3StrikeOngoing = false
					Mission.Airfield3Phase = 1
				end
			end

			if Mission.Airfield3Phase == 3 then --5

				--luaLog("phase "..tostring(phase))
				--luaLog("errorLvl "..tostring(errorLvl))

				local targetList = {}
				if next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting battleships")
					targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting motherships")
					targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting cargoships")
					targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
				else
					targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
				end

				local trg = luaPickRnd(targetList)
				for idx2,squadron in pairs(Mission.Airfield3Ents) do
					if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
						--lualog("-------------")
						--lualog(squadron)
						local ammo = GetProperty(squadron, "ammoType")
						if ammo ~= 0 then
							luaSetScriptTarget(squadron, trg)
							PilotSetTarget(squadron, trg)
						end
					end
				end

				Mission.Airfield3StrikeOngoing = true

			elseif Mission.Airfield3Phase < 3 then --5

				Mission.Airfield3Phase, Mission.Airfield3Ents, errorLvl = luaLaunchAirstrike(Mission.Airfield3Phase, 3, {Mission.Airfield3}, otherClassIDs, Mission.Airfield3Ents) --5
				Mission.Airfield3StrikeOngoing = false

			end

			--luaAirfieldManager(Mission.Airfield3, fighterClassIDs, otherClassIDs, targetList)
		end
	end

	SetWait(this, 3)
end

function luaJM7SpawnFirstCVFleet()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 317,
			["Name"] = "Northampton1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 315,
			["Name"] = "Yorktown1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
			["NumSlots"] = 4,
			["MaxInAirPlanes"] = 12,
			["PlaneStock 1"] = {
				["Type"] = 101,
				["Count"] = 20,
				["SquadLimit"] = 5,
			},
			["Slot 1"] = {
				["Type"] = 101,
				["Arm"] = 0,
				["Count"] = 3,
			},
		},
		--[[ FPS balta
		{
			["Type"] = 2,
			["Name"] = "Yorktown2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
			["NumSlots"] = 4,
			["MaxInAirPlanes"] = 12,
			["PlaneStock 1"] = {
				["Type"] = 101,
				["Count"] = 20,
				["SquadLimit"] = 5,
			},
			["Slot 1"] = {
				["Type"] = 101,
				["Arm"] = 0,
				["Count"] = 3,
			},
		},
		]]
		{
			["Type"] = 23,
			["Name"] = "Fletcher1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Fletcher2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(FindEntity("CVSpawn")),
		["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
		["lookAt"] = GetPosition(FindEntity("CVSpawnLookAt")),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7USNCVFleetSpawned",
	["id"] = Mission.USNReinfReq,
})
end

function luaJM7USNCVFleetSpawned(...)
	Mission.USNFleet1 = {}
	local ddname

	for idx,unit in ipairs(arg) do

		SetSkillLevel(unit, Mission.SkillLevel)

		table.insert(Mission.USNFleet1, unit)

		if not Mission.Yorktown and unit.Class.Type == "MotherShip" then
			Mission.Yorktown = unit
			Mission.Yorktown.Maxplanes = 24
			SetGuiName(unit, "ingame.shipnames_yorktown")
			SetNumbering(unit, 5)
		end

	--	if not Mission.Enterprise and unit.Class.Type == "MotherShip" then
	--		if Mission.Yorktown and Mission.Yorktown.ID ~= unit.ID then
	--			Mission.Enterprise = unit
	--			Mission.Enterprise.Maxplanes = 24
	--			SetGuiName(unit, "ingame.shipnames_enterprise")
	--			SetNumbering(unit, 6)
	--		end
	--	end

		if unit.Class.Type == "Cruiser" then
			SetGuiName(unit, "ingame.shipnames_northampton")
			SetNumbering(unit, 26)
		end

		if unit.Class.Type == "Destroyer" then
			if not ddname then
				SetGuiName(unit, "ingame.shipnames_hamman")
				SetNumbering(unit, 131)
				ddname = true
			else
				SetGuiName(unit, "ingame.shipnames_hughes")
				SetNumbering(unit, 410)
			end
		end

	end

	for idx,unit in pairs(Mission.USNFleet1) do
		if unit.ID ~= Mission.Yorktown.ID then
			JoinFormation(unit, Mission.Yorktown)
		end
	end

	luaDelay(luaJM7FollowTheLeader,2)
end

function luaJM7FollowTheLeader()
	local leader = Mission.Yorktown
	local x = {FindEntity("USNCarrierPath1"), FindEntity("USNCarrierPath4"), FindEntity("USNCarrierPath5")}
	path = luaPickRnd(x)
	NavigatorMoveOnPath(leader, path)

-- RELEASE_LOGOFF  	luaLog(leader.Name)

	luaJM7AddCVReconListener()
	luaJM7USNFleet1PathListener()

	Mission.Fleet1Ready = true
end

function luaJM7InitalSkillz(tbl)
	for idx,unit in pairs(tbl) do
		SetSkillLevel(unit, Mission.SkillLevel)
	end
end

function luaJM7SetSkillLvlOptions(unit)
	if unit and not unit.Dead then
		if not unit.skillcheckOK then

			if Mission.Difficulty >= 1 then
				TorpedoEnable(unit, true)
			end

			unit.skillcheckOK = true
		end
	end
end

function luaJM7CheckEndConds()

	--[[
	local own = recon[PARTY_JAPANESE].own

	for idx,tbl in pairs(luaRemoveDeadsFromTable(own)) do

		for idx2,unit in pairs(tbl) do
			if unit and not unit.Dead then
				local type = luaGetType(unit)
				if type == "ship" or type == "sub" or type == "plane" then

					local x = luaGetShipsAround(unit, 3600, "enemy")
					local y = luaGetPlanesAround(unit, 3600, "enemy")

					if x or y then
						return false
					end
				end
			end
		end

	end

	return true
]]


end