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
	SetDeviceReloadEnabled(false)

	Mission.Unlockables = {
		["59"] = {"ingame.shipnames_yamato"},
		["68"] = {"ingame.shipnames_chikuma"},
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
		Mission.SkillLower = SKILL_SPNORMAL
		Mission.SkillLevel = SKILL_MPVETERAN
	end

	--Mission.UnlockLvl = 3

	if Scoring_IsUnlocked("JM6_GOLD") then
		Mission.PlayerSub = GenerateObject("Submarine TypeB w Jake 01")
		if IsClassChanged(Mission.PlayerSub.Class.ID) then
			if Mission.PlayerSub.Class.ID == 8 then
				SetGuiName(Mission.PlayerSub, Mission.Unlockables["8"][1])
			elseif Mission.PlayerSub.Class.ID == 81 then
				SetGuiName(Mission.PlayerSub, Mission.Unlockables["81"][1])
			else
				SetGuiName(Mission.PlayerSub, Mission.PlayerSub.Class.Name)
			end
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
		table.insert(Mission.PlayerFleet, FindEntity("Akagi"))
		table.insert(Mission.PlayerFleet, FindEntity("Kaga-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Fuso-class Battleship 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Tone-class 02"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 11"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 31"))
		table.insert(Mission.PlayerFleet, FindEntity("Kuma-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Hiryu-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Soryu"))
		table.insert(Mission.PlayerFleet, FindEntity("Haruna"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 12"))
		table.insert(Mission.PlayerFleet, FindEntity("Takao-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 21"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 41"))
		for idx,unit in pairs(Mission.PlayerFleet) do
			if idx > 1 and idx < 8 then
				JoinFormation(unit, Mission.PlayerFleet[1])
			end
			if idx >= 8 then
				JoinFormation(unit, Mission.PlayerFleet[8])
			end
		end
		SetSelectedUnit(Mission.PlayerFleet[1])
		Mission.Kaga = FindEntity("Kaga-class 01")
		Mission.Hiryu = FindEntity("Hiryu-class 01")
		Mission.Akagi = FindEntity("Akagi")
		Mission.Soryu = FindEntity("Soryu")
		Mission.Haruna = FindEntity("Haruna")
		Mission.Tone = FindEntity("Tone-class 02")
		Mission.Chikuma = FindEntity("Takao-class 01")
		Mission.Nagara = FindEntity("Kuma-class 01")
		Mission.Kaga.AtFire = false
		Mission.Hiryu.AtFire = false
		Mission.Akagi.AtFire = false
		Mission.Soryu.AtFire = false
		SetGuiName(Mission.Kaga, "Kaga")
		SetGuiName(Mission.Hiryu, "Hiryu")
		SetGuiName(Mission.Akagi, "Akagi")
		SetGuiName(Mission.Soryu, "Soryu")
		SetShipSpeed(Mission.PlayerFleet[1], 10)
		SetShipSpeed(Mission.PlayerFleet[8], 10)

	--debug
	--luaJM7CVsInvincible()

	Mission.PlayerFleetNames = {}
		table.insert(Mission.PlayerFleetNames, "Akagi")
		table.insert(Mission.PlayerFleetNames, "Kaga")
		table.insert(Mission.PlayerFleetNames, "Kirishima")
		table.insert(Mission.PlayerFleetNames, "Chikuma")
		table.insert(Mission.PlayerFleetNames, "Nowaki")
		table.insert(Mission.PlayerFleetNames, "Hagikaze")
		table.insert(Mission.PlayerFleetNames, "Nagara")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_shirayuki")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_hiryu")
		table.insert(Mission.PlayerFleetNames, "Soryu")
		table.insert(Mission.PlayerFleetNames, "Haruna")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_tone")
		table.insert(Mission.PlayerFleetNames, "Arashi")
		table.insert(Mission.PlayerFleetNames, "Maikaze")

	Mission.IJNInvasionFleetNames = {}
		-- table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_yamato")
		-- table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_meiko")
		-- table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_myoken")
		-- table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_fukusei")
		-- table.insert(Mission.IJNInvasionFleetNames, "ingame.shipnames_harbin")
		table.insert(Mission.IJNInvasionFleetNames, "Hosho")
		table.insert(Mission.IJNInvasionFleetNames, "Naruto")
		table.insert(Mission.IJNInvasionFleetNames, "Yukaze")

	Mission.Fleets = {
		[1] = {},
		[2] = {},
	}

	--Mission.InvasionSpawnTime = 900

	Mission.USNReinfFleetNames = {}
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_enterprise", 6})	
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_hornet", 8})			--CV8
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_northampton", 26})	--CA26
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_vincennes", 44})		--CA44
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_astoria", 34})			--CA34

		--table.insert(Mission.USNReinfFleetNames, "USS John P. Holder")
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_reid", 369})				--DD369
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_dent", 116})				--DD116
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_russell", 414})			--DD414
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_ellett", 398})			--DD398
		table.insert(Mission.USNReinfFleetNames, {"ingame.shipnames_gwin", 433})				--DD433

	Mission.MainIJNFleet = {}
	Mission.IJNInvasionFleet = {}
	Mission.IJNCargos = {}
	Mission.IJNInvasionReq = "IJNInvasionReq"

	Mission.Atlanta = FindEntity("Atlanta-class 01")
	luaJM7InitalSkillzLower({Mission.Atlanta})
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

	luaJM7InitalSkillzLower({Mission.Airfield1, Mission.Airfield2, Mission.Airfield3})

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
				-- ["Text"] = "ijn07.obj_p3",
				["Text"] = "Sink at least 2 enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "CarriersSurvive",
				["Text"] = "Kido Butai must survive!",
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
			[3] = {
				["ID"] = "ElitePilots",
				["Text"] = "Do not lose more than 60 elite pilots!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_PRIMARY_MULTIPLIER,
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
				-- {
				-- 	["message"] = "dlg1a",
				-- },
				-- {
				-- 	["message"] = "dlg1a_1",
				-- },
				-- {
				-- 	["message"] = "dlg1b",
				-- },
				-- {
				-- 	["message"] = "dlg1b_1",
				-- },
				-- {
				-- 	["message"] = "dlg1c",
				-- },
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
				{
					["message"] = "dlg2c",
				},
				{
					["message"] = "dlg2d",
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
				-- {
				-- 	["message"] = "dlg12a",
				-- },
				-- {
				-- 	["message"] = "dlg12b",
				-- },
				-- {
				-- 	["message"] = "dlg12c",
				-- },
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
	
	luaAddCVHitListener(Mission.Akagi,"Akagi")
	luaAddCVHitListener(Mission.Soryu,"Soryu")
	luaAddCVHitListener(Mission.Kaga,"Kaga")
	luaAddCVHitListener(Mission.Hiryu,"Hiryu")

	luaJM7InitalSkillz({Mission.Akagi, Mission.Soryu, Mission.Kaga, Mission.Hiryu})
	local randomDelay = random(120, 600)
	luaDelay(luaJM7SpawnFirstCVFleet, randomDelay)
	---test---
	if not Mission.USNReinfCalled then
		luaDelay(luaJM7SpawnUSNReinf, randomDelay + random(-60,60))
		-- luaDelay(luaJM7SpawnFirstCVFleet, 5)
		Mission.USNReinfCalled = true
	end
	---test---

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
	luaBomberLanding(Mission.Akagi)
	luaBomberLanding(Mission.Kaga)
	luaBomberLanding(Mission.Soryu)
	luaBomberLanding(Mission.Hiryu, true)
	luaBomberLanding(Mission.Hosho)
	-- SetInvincible(Mission.Kaga, true)
	-- SetInvincible(Mission.Akagi, true)
	-- SetInvincible(Mission.Soryu, true)
	-- SetInvincible(Mission.Hiryu, true)
	luaBomberLanding(Mission.Yorktown)
	luaBomberLanding(Mission.Enterprise)
	luaBomberLanding(Mission.Hornet)
	luaSeaPlaneManager(Mission.Tone)
	luaSeaPlaneManager(Mission.Chikuma)
	luaSeaPlaneManager(Mission.Nagara)

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	luaJM7CheckUSNCarrierFleet1()
	if Mission.USNReinfIn then
		luaJM7CheckUSNCarrierFleet2()
	end

	if Mission.MissionPhase == 1 then

		luaJM7ISPlayerInRecon()

	elseif Mission.MissionPhase == 2 then

		luaJM7CheckIJNBombers()

	elseif Mission.MissionPhase == 3 then

		luaJM7CheckUSNCarrierFleet1()
		luaJM7PowerupCheck()

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

function hintAkagi()
	if GetSelectedUnit() == Mission.Akagi then
		ShowHint("IJN07_Hint07")
	end
end

function hintKaga()
	if GetSelectedUnit() == Mission.Kaga then
		ShowHint("IJN07_Hint08")
	end
end

function hintSoryu()
	if GetSelectedUnit() == Mission.Soryu then
		ShowHint("IJN07_Hint09")
	end
end

function hintHiryu()
	if GetSelectedUnit() == Mission.Hiryu then
		ShowHint("IJN07_Hint10")
	end
end

function detailHints()
	if GetSelectedUnit() == Mission.Akagi then
		luaDelay(hintAkagi, 10)
	elseif GetSelectedUnit() == Mission.Kaga then
		luaDelay(hintKaga, 10)
	elseif GetSelectedUnit() == Mission.Soryu then
		luaDelay(hintSoryu, 10)
	elseif GetSelectedUnit() == Mission.Hiryu then
		luaDelay(hintHiryu, 10)
	end
end

--objectives
function luaJM7CheckObjectives()
	-- Mission.MissionPhase = 99
	-- Mission.MissionCompleted = true

	if Mission.MissionPhase < 99 then
		if table.getn(luaRemoveDeadsFromTable({Mission.Akagi, Mission.Soryu, Mission.Kaga, Mission.Hiryu})) == 0 then
			Mission.MissionFailed = true
			luaObj_Failed("primary", 4)
			Mission.FailMsg = "Kido Butai is doomed."
			-- Mission.FailMsg = "ijn07.obj_missionfailed1"
			--luaObj_FailedAll()
			--Mission.LastUnit
			for idx,unit in pairs({Mission.Akagi, Mission.Soryu, Mission.Kaga, Mission.Hiryu}) do
				if not TrulyDead(unit) then
					Mission.LastUnit = unit
					break
				end
			end
						-- RELEASE_LOGOFF  			luaLog("No more playerunits")
			luaJM7StepPhase(99)
		end

		local danger = 0
		for _, carrier in pairs({Mission.Akagi, Mission.Soryu, Mission.Kaga, Mission.Hiryu}) do
			if carrier.Dead or carrier.RunwayFailure and carrier.efxList and #(carrier.efxList) >= 2 then
				danger = danger + 1
			end
		end

		if danger >= 3 and not Mission.StartHosho then
			MissionNarrativePlayer(0, "Hosho is on her way")
			Mission.StartHosho = true
			luaDelay(luaJM7SpawnIJNHoshoFleet, random(200, 300))
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
			detailHints()
			if not luaObj_IsActive("secondary",2) then
				luaObj_Add("secondary",2)
				Mission.PilotLoss = 0
				luaAddPilotKillListener()
				luaObj_Add("secondary",3)
				luaJM7AirstrikeHint()
				-- ShowHint("IJN07_Hint05")
				ShowHint("IJN07_Hint05")
				ShowHint("IJN07_Hint06")
				-- luaJM7Sec2Score()
				luaJM7FuelScore()
			elseif luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil then
				if false and luaJM7PrepObj() then
					luaObj_Completed("secondary",2)
					luaJM7RemoveScore(4)
					luaJM7CAPHint()
				else
					-- luaJM7Sec2Score()
					luaJM7FuelScore()
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
			luaObj_Add("primary",4)
			SetForcedReconLevel(Mission.Airfield1, 2, PARTY_JAPANESE)
			SetForcedReconLevel(Mission.Airfield2, 2, PARTY_JAPANESE)
			SetForcedReconLevel(Mission.Airfield3, 2, PARTY_JAPANESE)
			luaObj_AddUnit("primary",1,Mission.Airfield1)
			luaObj_AddUnit("primary",1,Mission.Airfield2)
			luaObj_AddUnit("primary",1,Mission.Airfield3)


			luaJM7Pri1Score()
			luaJM7Pri4Score()
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
					-- luaJM7SpawnFirstCVFleet()
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
		local killCheckList = {Mission.Yorktown, Mission.Hornet, Mission.Enterprise, Mission.Akagi, Mission.Kaga, Mission.Soryu, Mission.Hiryu, Mission.Haruna, Mission.Kirishima}
		if Mission.MissionFailed then
			if Mission.LastUnit then
				luaMissionFailedNew(Mission.LastUnit, Mission.FailMsg)
			else
				luaMissionFailedNew(Mission.CommandBuilding1, Mission.FailMsg)
			end
			killList(killCheckList)
			luaJM7StepPhase()

		elseif Mission.MissionCompleted then
			luaObj_Completed("primary",4)
			if Mission.PilotLoss < 60 then
				luaObj_Completed("secondary",3)
			end
			luaJM7StartDialog("Outro")
			killList(killCheckList)
			luaDelay(luaJM7CompleteMission,20)
			luaJM7StepPhase()
		end

	end

end

function killList(list)
	for _, dead in pairs(list) do
		if dead and dead.Dead then
			if not dead.lastAttacker then
				MissionNarrativePlayer(0, GetGuiName(dead).." scuttled")
			else
				MissionNarrativePlayer(0, dead.lastAttacker.." sunk "..GetGuiName(dead))
			end
		end
	end
end

function luaAddPilotKillListener()
	Mission.JapPlanes = {}
	AddListener("kill", "PilotKillListener", {
		["callback"] = "luaPilotKill",
		["entity"] = Mission.JapPlanes,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})

end

function luaPilotKill(target)
	if target.Party ~= PARTY_JAPANESE then return end
	Mission.PilotLoss = Mission.PilotLoss + 1
	if Mission.PilotLoss % 1 == 0 or Mission.PilotLoss > 50 and Mission.PilotLoss <= 60 then
		MissionNarrativePlayer(0, "Pilot loss: "..Mission.PilotLoss)
	end
end

function luaJM7Checkpoint1()
	luaCheckpoint(1,133)
	Blackout(false, "", 1)
end


function luaJM7Checkpoint2()
	luaCheckpoint(2,133)
	Blackout(false, "", 1)
end

function luaJM7CompleteMission()
						-- RELEASE_LOGOFF  	luaLog(debug.traceback())
	local finale = luaRemoveDeadsFromTable({Mission.Akagi, Mission.Kaga, Mission.Hiryu, Mission.Soryu, Mission.Kirishima, Mission.Haruna, Mission.CommandBuilding1})[1]
	luaMissionCompletedNew(finale, "ijn07.obj_missioncompl")
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
			-- luaJM7SpawnUSNReinf()
			Mission.USNReinfCalled = true
		end

	end

	if Mission.Enterprise and Mission.Enterprise.Dead then
		deads = deads + 1
	end
	if Mission.Hornet and Mission.Hornet.Dead and (Scoring_IsUnlocked("JM6_BRONZE") or Scoring_IsUnlocked("JM6_SILVER") or Scoring_IsUnlocked("JM6_GOLD")) then
		deads = deads + 1
	end

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

function luaAddCVHitListener(carrier, name)
	luaDoCustomLog("debug.txt", {"luaAddCVHitListener",carrier, name}, "a")
	carrier.efxList = {}
	carrier.hithint = name
	carrier.enablehithint = true
	carrier.vulnerable = 0
	-- "MEDIUMARTILLERY", "HEAVYARTILLERY", "BOMB", "TORPEDO"
	AddListener("hit", "CVHitListener"..name, {
		["callback"] = "luaCVHit1",
		["target"] = {carrier},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},	
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})

end

function luaCVHit1(target, targetDevice, attacker, attackType, attackerPlayerIndex, damageCaused, fireCaused, leakCaused)
	-- MissionNarrativePlayer(0, GetGuiName(target)..GetGuiName(attacker))
	target.lastAttacker = GetGuiName(attacker)
	if attacker.from then target.lastAttacker = GetGuiName(attacker.from) end

	luaDoCustomLog("debug.txt", {"luaCVHit1", target, targetDevice, attacker, attackType, attackerPlayerIndex, damageCaused, fireCaused, leakCaused}, "a")
	local threshold = math.pow(damageCaused/300, 0.5) * 100
	local rnd = random(1,100)
	ShowHint("IJN07_Hint15")
	-- SetInvincible(target, true) and damageCaused > 50
	if attackType == "HEAVYARTILLERY" or (attackType == "BOMB" and damageCaused > 20) or attackType == "TORPEDO" or rnd < threshold then
		if attackType == "BOMB" and target.vulnerable > 0 then
			target.deadlyExpl = true
			target.fatalExpl = true
		end
		target.takeFire = true
		if target.enablehithint then
			if target.deadlyExpl then
				MissionNarrativePlayer(0, target.hithint.." is burning!")
			else
				MissionNarrativePlayer(0, target.hithint.." is at fire.")
			end
			target.enablehithint = false
		end
	end
	luaDoCustomLog("debug.txt", {"luaCVHit1End"}, "a")
end

function luaExpl(unit)
	luaDoCustomLog("debug.txt", {"luaExpl", unit}, "a")
	if not unit then return end
	-- SetInvincible(unit, true)
	local efxList = unit.efxList
	local pos = ORIGO
	pos.z = random(unit.Class.Length * 0.7) - unit.Class.Length * 0.35
	pos.x = random(unit.Class.Width * 0.7) - unit.Class.Width * 0.35
	pos.y = unit.Class.Height * 0.8
	local efx
	if unit.deadlyExpl and (random(1,100) > 70 or unit.fatalExpl) then
		Effect("ExplosionBigShip", pos, unit)
		Effect("ExplosionMagazine", pos, unit)
		unit.fatalExpl = false
		AddDamage(unit, 500)
		efx = Effect("BigFire", pos, unit)
		efx.big = true
	else
		Effect("ExplosionMagazine", pos, unit)
		AddDamage(unit, 300)
		efx = Effect("SmallFire", pos, unit)
		efx.big = false
	end
	-- MissionNarrativePlayer(0, tostring(efx.big))
	table.insert(efxList, efx)
	luaDoCustomLog("debug.txt", {"luaExplEnd"}, "a")
end

function luaFireControlFail(carrier)
	luaDoCustomLog("debug.txt", {"luaFireControlFail", carrier}, "a")
	local unit = carrier.ParamTable.carrier
	if not unit or unit.Dead then return end
	luaExpl(unit)
	unit.RunwayFailure = true
	SetFailure(unit, "RunwayFailure")
	local efxList = unit.efxList
	-- Kill(unit, true)
	-- return
	local luck = random(1,100)
	if not carrier.deadlyExpl and luck > 60 or luck > 85 then luaDelay(luaFireControlSuccess,40,"carrier",unit)
	else
		if (#efxList)*(#efxList) >= random(1,30) then
			unit.deadlyExpl = true -- five fires cause big explosion
			unit.fatalExpl = true
		end
		luaDelay(luaFireControlFail,luck*1.5,"carrier",unit)
	end
	MissionNarrativePlayer(0, unit.Name.." "..#efxList)
	luaDoCustomLog("debug.txt", {"luaFireControlFailEnd"}, "a")
end

function luaFireControlSuccess(carrier)
	luaDoCustomLog("debug.txt", {"luaFireControlSuccess", carrier}, "a")
	local unit = carrier.ParamTable.carrier
	if not unit or unit.Dead then return end
	local efxList = unit.efxList
	local toStop = random(#efxList)
	StopEffect(efxList[toStop].Pointer)
	table.remove(efxList, toStop)
	if #efxList == 0 then 
		unit.RunwayFailure = false
		ClearFailure(unit, "RunwayFailure")
		unit.atFire = false
		unit.enablehithint = true
		if unit.Party == PARTY_JAPANESE then
			MissionNarrativePlayer(0, unit.hithint.." reporting flight deck clear.")
		end
		return
	end
	local luck = random(1,100)
	if not carrier.deadlyExpl and luck > 40 or luck > 60 then
		carrier.deadlyExpl = false
		for _, efx in pairs(efxList) do
			if efx.big then carrier.deadlyExpl = true end
		end
		luaDelay(luaFireControlSuccess,20,"carrier",unit)
	else luaDelay(luaFireControlFail,luck*1.5,"carrier",unit)
	end
	MissionNarrativePlayer(0, unit.Name.." "..#efxList)
	luaDoCustomLog("debug.txt", {"luaFireControlSuccessEnd"}, "a")
end

function luaDitching(params)
	local p = params.ParamTable.sq
	local burn = params.ParamTable.burn
	if not p or p.Dead then return end
	luaDoCustomLog("debug.txt", {"luaDitching"..p.Name}, "a")
	p.burn_rate = 1.0
	p.fuel = p.fuel-burn*p.burn_rate
	SquadronSetTravelAlt(p, 0)
	SquadronSetTravelSpeed(p, 0)
	PilotStop(p)
	if GetSelectedUnit() == p then
		MissionNarrativePlayer(0, "squadron ditching "..p.Class.Name)
	end
	if luaHasFuel(p) then
		luaDelay(luaDitching, 1, "sq", p, "burn", burn)
	else
		MissionNarrativePlayer(0, "squadron ditched "..p.Class.Name)
		Kill(p)
	end
	luaDoCustomLog("debug.txt", {"luaDitchingEnd"}, "a")
end

function luaIsLowFuel(plane, carrier)
	if not plane.fuel then return false end
	if not carrier or carrier.Dead then return plane.fuel <= 3000.0 end
	if plane.fuel <= luaGetDistance(plane, carrier) + 10000 then return true end
	return false
end

function luaHasFuel(plane)
	if not plane.fuel then return true end
	return plane.fuel > 0.0
end

function luaNearestLandingBase(plane, bases)
end

function luaLandable(carrier)
	return carrier and not carrier.Dead and (carrier.Class.Type ~= "MotherShip" or not carrier.RunwayFailure)
end

function burnStep(now, last)
	return math.sqrt(math.pow(now.x-last.x, 2)+math.pow(now.z-last.z, 2)+math.pow(math.max(now.y-last.y,0), 3))
end

function reloadingTag3sec(params)
	local p = params.ParamTable.sq
	if p and not p.Dead then
		p.reloadingTag = true
	end
end

function luaFuel(params)
	local p = params.ParamTable.sq
	local burn = params.ParamTable.burn
	local carrier = params.ParamTable.carrier
	local last_loc = params.ParamTable.last_loc
	if not p or p.Dead then return end
	if GetPlaneIsReloading(p) then luaDelay(reloadingTag3sec, 3, "sq", p) end
	if not last_loc then last_loc = GetPosition(p) end
	local curr_loc = GetPosition(p)
	local fleet
	if p.Party == PARTY_JAPANESE then fleet = luaRemoveDeadsFromTable({Mission.Akagi, Mission.Kaga, Mission.Hiryu, Mission.Soryu})
	else fleet = luaRemoveDeadsFromTable({Mission.Yorktown, Mission.Enterprise, Mission.Hornet, Mission.Airfield1})
	end
	if p.burn_rate == nil then p.burn_rate = 1.0 end
	p.fuel = p.fuel-burnStep(curr_loc, last_loc)
	luaDoCustomLog("debug.txt", {"luaFuel "..p.fuel.." "..p.Name}, "a")
	-- MissionNarrativePlayer(0, "s4"..p.fuel.." ratio "..p.fuel/p.maxFuel*100)
	-- p.fuel = p.fuel-burn*p.burn_rate
	-- SetCheatTurbo(p,2)
	if p.landing and carrier and carrier.Class.Type ~= "MotherShip" then
		luaDelay(luaFuel, 1, "sq", p, "carrier", carrier, "burn", burn, "last_loc", curr_loc)
		luaDoCustomLog("debug.txt", {"luaFuel End1"..p.fuel.." "..p.Name}, "a")
		return
	end
	if carrier and carrier.Class.Type == "MotherShip" and GetSquadronLanded(p) then
		carrier.landingStack = carrier.landingStack - 1
		luaDoCustomLog("debug.txt", {"luaFuel End2"..p.fuel.." "..p.Name}, "a")
		return
	end
	if carrier and not p.sent then p.from = carrier end
	if carrier and carrier.Class.Type == "MotherShip" and not p.sent then
		if carrier.vulnerable == 0 and carrier.Party == PARTY_JAPANESE then
			Effect("Recon", ORIGO, Mission.Akagi)
			MissionNarrativePlayer(0, carrier.hithint..": launching")
		end
		carrier.vulnerable = carrier.vulnerable + 1
		luaDelay(luaPlaneSentSafe, 40, "carrier",carrier)
	end
	p.sent = true
	if not luaHasFuel(p) then
		MissionNarrativePlayer(0, "Dit cuz no fuel")
		luaDelay(luaDitching, 1, "sq", p, "burn", burn)
		luaDoCustomLog("debug.txt", {"luaFuel End3"..p.fuel.." "..p.Name}, "a")
		return
	end
	if luaIsLowFuel(p, carrier) and (not luaLandable(carrier) or carrier.landingStack > 6) then
		local possibles = {}
		for _, mother in pairs(fleet) do
			if luaLandable(mother) and mother.landingStack < 4 then table.insert(possibles, mother) end
		end
		if #possibles == 0 then 
			MissionNarrativePlayer(0, "no carrier")
			-- luaDelay(luaDitching, 1, "sq", p, "burn", burn)
			-- return
		else
			local near = luaSortByDistance2(p, possibles, true)
			MissionNarrativePlayer(0, "Landing from "..carrier.Name.." to "..near.Name)
			if p.landing then p.landing.landingStack = p.landing.landingStack - 1 end
			p.landing = near
			-- PilotStop(p)
			PilotLand(p,near)
			-- p.burn_rate = 0.08
			near.landingStack = near.landingStack + 1
			carrier = near
		end
		-- p.signInLanding = false
	elseif not p.landing and (p.reloadingTag or luaIsLowFuel(p, carrier)) and carrier and not carrier.Dead and carrier.Class.Type == "MotherShip" then
		p.landing = carrier
		-- p.burn_rate = 0.08
		PilotLand(p,carrier)
		carrier.landingStack = carrier.landingStack + 1
		-- SquadronSetTravelAlt(p,1400)
		-- PilotMoveTo(p,carrier)
		-- if not p.signInLanding then 
		-- 	p.signInLanding = true
		-- 	table.insert(carrier.landingStack, p)
		-- 	carrier.landingStack = luaSortByDistance2(carrier, luaRemoveDeadsFromTable(carrier.landingStack))
		-- end
	end
	-- MissionNarrativePlayer(0, "s7")
	luaDelay(luaFuel, 1, "sq", p, "carrier", carrier, "burn", burn, "last_loc", curr_loc)
	luaDoCustomLog("debug.txt", {"luaFuel End4"..p.fuel.." "..p.Name}, "a")
end

function luaPlaneSentSafe(params)
	luaDoCustomLog("debug.txt", {"luaPlaneSentSafe"}, "a")
	luaDoCustomLog("debug.txt", params.ParamTable, "a")
	local carrier = params.ParamTable.carrier
	if carrier and carrier.vulnerable > 0 then
		carrier.vulnerable = carrier.vulnerable - 1
		if carrier.vulnerable == 0 and carrier.Party == PARTY_JAPANESE then
			MissionNarrativePlayer(0, carrier.hithint.." reporting flight deck clear.")
		end
	end
	luaDoCustomLog("debug.txt", {"luaPlaneSentSafeEnd"}, "a")
end

function setInitFuel(p, f)
	p.fuel = f
	p.maxFuel = f
end

function luaBomberLanding(carrier)
	luaDoCustomLog("debug.txt", {"luaBomberLanding",carrier}, "a")
	if carrier and not carrier.Dead then
		if math.floor(GameTime()) % 20 == 0 then MissionNarrativePlayer(0, carrier.Name.." "..#efxList) end
		-- SetFailure(carrier, "RunwayFailure", 180)
		-- SetFailure(carrier, "explosion", DAM_ENGINEROOM, 0, 100, 200, 154)
		-- SetFailure(carrier, "EngineJam", 10)

		if carrier.takeFire then
			carrier.takeFire = false
			if carrier.atFire then luaExpl(carrier)
			else luaDelay(luaFireControlFail,1,"carrier",carrier)
			end
			carrier.atFire = true
		end

		-- Effect("ExplosionBigShip", pos)
		local _, sq = luaGetSlotsAndSquads(carrier)
		local haveLanding = false
		if not carrier.landingStack then carrier.landingStack = 0 end
		carrier.landing_count = 0
		if not carrier.backups then carrier.backups = 8 end
		if sq then
			for _,p in pairs(sq) do
				-- SetCheatTurbo(p,5)
				if p and not p.fuelCount then
					if not carrier.defaultRange then
						carrier.defaultRange = 100000.0
					end
					setInitFuel(p, carrier.defaultRange)
					if carrier.Party == PARTY_JAPANESE then
						if not Mission.JapPlanes then Mission.JapPlanes = {} end
						table.insert(Mission.JapPlanes, p)
						for _, pp in pairs(GetSquadronPlanes(p)) do
							table.insert(Mission.JapPlanes, pp)
							-- pp.elite = true do not assign variables to entity planes!!!
						end
						if #sq > 4 then
							carrier.backups = carrier.backups - 1
							p.fuel = 30000.0
							p.maxFuel = 100000.0
							if #sq == 5 then
								MissionNarrativePlayer(0, carrier.hithint.." launching back up plane, "..carrier.backups.." left.")
							end
						end
					end
					local burn = random(14,16)/100
					p.fuelCount = true
					luaDelay(luaFuel, 1, "sq", p, "carrier", carrier, "burn", burn)
				end
				if p and p.landing then carrier.landing_count = carrier.landing_count + 1 end
				if p and p.landing and not carrier.RunwayFailure then haveLanding = true end
				-- if not GetPlaneIsReloading(p) then needReload = false break end
			end
		end
		-- if carrier and not carrier.RunwayFailure then
		-- 	for idx, landingRequest in pairs(carrier.landingStack) do
		-- 		if landingRequest and not landingRequest.Dead and not GetSquadronLanded(landingRequest) then
		-- 			if idx < 4 then
		-- 				PilotLand(landingRequest, carrier)
		-- 			else
		-- 				PilotMoveTo(landingRequest, carrier)
		-- 			end
		-- 		end
		-- 	end
		-- end
		-- SetAirBaseSlotCount(carrier, 4+carrier.landing_count)
		if carrier.backups > 0 then
			SetAirBaseSlotCount(carrier, 6)
		else
			SetAirBaseSlotCount(carrier, 4)
		end
		local speedLimit = 999
		if haveLanding and carrier.maxLandSpeed then speedLimit = carrier.maxLandSpeed end
		local checkHp = GetHpPercentage(carrier)
		SetShipMaxSpeed(carrier, math.min(speedLimit, math.max(math.min(checkHp+0.3,1.0), 0.3) * carrier.Class.MaxSpeed))
	end
	luaDoCustomLog("debug.txt", {"luaBomberLandingEnd",carrier}, "a")
end

function luaRecoverSeaplane(params)
	luaDoCustomLog("debug.txt", {"luaRecoverSeaplane"}, "a")
	luaDoCustomLog("debug.txt", params.ParamTable, "a")
	local seaplane = params.ParamTable.seaplane
	local ship = params.ParamTable.ship
	if seaplane and not seaplane.Dead and GetEntitySpeed(seaplane) < 20 then
		Kill(seaplane, true)
		SetCatapultStock(ship, GetCatapultStock(ship)+1)
	end
end

function luaSeaPlaneManager(ship)
	if ship and not ship.Dead then
		luaDoCustomLog("debug.txt", {"luaSeaPlaneManager",ship.Name}, "a")
		if not ship.SeaPlanes then ship.SeaPlanes = {} end
		local seaplane = GetLastCatapulted(ship)
		if #ship.SeaPlanes == 0 or seaplane ~= ship.SeaPlanes[#ship.SeaPlanes] then
			table.insert(ship.SeaPlanes, seaplane)
		end
		ship.activePlanes = luaRemoveDeadsFromTable(ship.SeaPlanes)
		for _, seaplane in pairs(ship.activePlanes) do
			if seaplane.flew == 4 then 
				-- SquadronSetTravelSpeed(seaplane, KMH(0))
				-- SquadronSetTravelAlt(seaplane, -100)
			elseif seaplane.flew == 1 then
				SquadronSetTravelAlt(seaplane, 1500)
				-- SetCheatTurbo(seaplane, 5)
				-- Mission.Akagi.takeFire = true
				-- if luaIsLowFuel(seaplane) then seaplane.flew = 2 end
				-- if seaplane.fuel <= 15.0 then seaplane.flew = 2 end
				if luaIsLowFuel(seaplane, ship) then seaplane.flew = 2 end
				if GetEntitySpeed(seaplane) < 13 and luaGetDistance(seaplane, ship) < 500 then
					PilotStop(seaplane)
					luaDelay(luaRecoverSeaplane, 5, "seaplane", seaplane, "ship", ship)
					-- seaplane.flew = 4
				end
			elseif seaplane.flew == 2 then
				seaplane.landing = ship
				PilotMoveTo(seaplane, ship)
				SquadronSetTravelAlt(seaplane, 1500)
				-- seaplane.burn_rate = 0.08
				local distance = math.sqrt(math.pow(GetPosition(seaplane).x-GetPosition(ship).x, 2)+math.pow(GetPosition(seaplane).z-GetPosition(ship).z, 2))
				-- Mission.Akagi.takeFire = true
				if distance < 500 then seaplane.flew = 3 end
			elseif seaplane.flew == 3 then
				-- Mission.Kaga.takeFire = true
				SquadronSetTravelSpeed(seaplane, KMH(0))
				SquadronSetTravelAlt(seaplane, -100)
				PilotMoveTo(seaplane, ship)
				if GetEntitySpeed(seaplane) < 13 then
					PilotStop(seaplane)
					luaDelay(luaRecoverSeaplane, 5, "seaplane", seaplane, "ship", ship)
					-- seaplane.flew = 4
				end
			elseif GetEntitySpeed(seaplane) > 15 then 
				seaplane.flew = 1
				if not ship.defaultRange then
					ship.defaultRange = 180000.0
				end
				setInitFuel(seaplane, ship.defaultRange)
				local burn = random(14,16)/100
				SquadronSetTravelAlt(seaplane, 1500)
				PilotMoveTo(seaplane, ship)
				luaDelay(luaFuel, 1, "sq", seaplane, "carrier", ship, "burn", burn)
			end
			-- luaDoCustomLog("debug.txt", {"luaSeaPlaneManager1 "..seaplane.fuel.." "..seaplane.flew}, "a")
		-- PilotSetTarget(seaplane, ship)
		end
		luaDoCustomLog("debug.txt", {"luaSeaPlaneManagerEnd",ship.Name}, "a")
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
		if not Mission.HornetPowerup and Mission.Hornet and Mission.Hornet.Dead and Mission.Hornet.KillReason ~= "exitzone" then
			luaJM7AddPowerup("automatic_reloader")
			Mission.CVPowerup = true
			return
		end

	end
end

--- PHASE1 Bombers
function luaJM7CheckIJNBombers()
	if Mission.IJNBombersSpawned >= 0 then  -- do not spawn land-based bombers
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
	MissionNarrativePlayer(0, "reload af1")
	Mission.Airfield1.Maxplanes = 24
	Mission.Airfield1.Reload = false
end

function luaJM7ReloadAF2()
	MissionNarrativePlayer(0, "reload af2")
	Mission.Airfield2.Maxplanes = 36
	Mission.Airfield2.Reload = false
end

function luaJM7ReloadAF3()
	MissionNarrativePlayer(0, "reload af3")
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

function luaJM7ReloadHornet()
	Mission.Hornet.Maxplanes = 24
	Mission.Hornet.Reload = false
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
	luaDoCustomLog("debug.txt", {"luaJM7CheckUSNCarrierFleet1"}, "a")
	if Mission.Fleet1CarriersDead or not Mission.Fleet1Ready then
		return
	end
	-- Kill(Mission.Yorktown, true)

	luaJM7IncPlanesDlgTrigger(Mission.Yorktown,Mission.Enterprise,1) --dlg trigger check

	-- Kill(Mission.Yorktown, true)
	--carriers
	if Mission.Yorktown and Mission.Yorktown.Dead then
		--luaLog("Yorktown died")
	else
		-- Kill(Mission.Yorktown, true)
		if Mission.Yorktown.Maxplanes <= 0 then

			if not Mission.Yorktown.Reload then
				luaDelay(luaJM7ReloadYorktown, 300)
				Mission.Yorktown.Reload = true
			end

		else

			-- Kill(Mission.Yorktown, true)
			luaJM7CheckMaxplanes(Mission.Yorktown)

			local fighterClassIDs = {101}
			local otherClassIDs = {108,112}
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
			-- Mission.Yorktown.takeFire = true
			-- LaunchSquadron(Mission.Yorktown,fighterClassIDs[1],5)
			luaAirfieldManager1(Mission.Yorktown, fighterClassIDs, otherClassIDs, targetList, 1500, 3)
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
			local otherClassIDs = {108,112}
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
		RepairEnable(unit, false)
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

function luaJM7SpawnIJNHoshoFleet()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 57,
			["Name"] = "Hosho",
			["Crew"] = Mission.SkillLevel,
			["Race"] = Japan,
			["NumSlots"] = 4,
			["MaxInAirPlanes"] = 12,
			["PlaneStock 1"] = {
				["Type"] = 109,
				["Count"] = 8,
				["SquadLimit"] = 5,
			},
			["Slot 1"] = {
				["Type"] = 109,
				["Arm"] = 0,
				["Count"] = 3,
			},
			["Class"] = "MotherShip",
		},
		{
			["Type"] = 75,
			["Name"] = "Yukaze",
			["Crew"] = Mission.SkillLower,
			["Race"] = Japan,
			["Class"] = "Destroyer",
		},
		{
			["Type"] = 86,
			["Name"] = "Cargo2",
			["Crew"] = 2,
			["Race"] = Japan,
		},
		-- {
		-- 	["Type"] = 86,
		-- 	["Name"] = "Cargo3",
		-- 	["Crew"] = 2,
		-- 	["Race"] = Japan,
		-- },
		-- {
		-- 	["Type"] = 86,
		-- 	["Name"] = "Cargo4",
		-- 	["Crew"] = 2,
		-- 	["Race"] = Japan,
		-- },
	},
	["area"] = {
		["refPos"] = {["x"] = -25000, ["y"] = 0, ["z"] = 25000},
		["angleRange"] = { luaJM7RAD(0), luaJM7RAD(180)},
		["lookAt"] = GetPosition(Mission.Airfield1),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7IJNHoshoFleetSpawned",
	["id"] = "Mission.IJNInvasionReq",
	})
end

function luaJM7IJNHoshoFleetSpawned(...)
	MissionNarrativePlayer(0, "Hosho has arrived")
	for idx,unit in ipairs(arg) do
		table.insert(Mission.IJNInvasionFleet, unit)
		if unit.Class.Type == "Cargo" then
			-- table.insert(Mission.IJNCargos, unit)
		elseif unit.Class.Type == "BattleShip" then
			-- Mission.Yamato = unit
			-- SetShipMaxSpeed(Mission.Yamato, (Mission.Yamato.Class.MaxSpeed * 1.5))
		elseif unit.Class.Type == "MotherShip" then
			luaAddCVHitListener(unit)
			Mission.Hosho = unit
			Mission.Hosho.defaultRange = 70000.0
		end
	end

	for idx,unit in pairs(Mission.IJNInvasionFleet) do
		-- SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		if idx > 1 then
			JoinFormation(unit, Mission.IJNInvasionFleet[1])
		end
	end


	for idx, unit in pairs(Mission.IJNInvasionFleet) do
		RepairEnable(unit, false)
		SetGuiName(unit, Mission.IJNInvasionFleetNames[idx])
	end

	--luaJumpinMovieSetCurrentMovie("GoAround", Mission.IJNInvasionFleet[1].ID)
	-- if not Mission.CheckpointLoaded then
	-- 	luaJM7InvasionMovie()
	-- end

	-- NavigatorMoveToRange(Mission.IJNInvasionFleet[1], Mission.ShipyardLandingPoint)
	-- Mission.InvasionStarted = math.floor(GameTime())

	-- luaJM7StartDialog("JapInvFleetIn")
	-- luaJM7StartDialog("YamatoIn")
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


function antiAirFormation(fleet, center)
	-- SetFormationShape
	-- MissionNarrativePlayer(0, "Start formation")
	-- MissionNarrativePlayer(0, "Get position")
	core = {}
	heavy = {}
	medium = {}
	light = {}
	distance_mul = 250.0
	-- MissionNarrativePlayer(0, "Start formation")
	for idx,unit in pairs(fleet.groupMembers) do
		-- LeaveFormation(unit)
		if unit.Class == "MotherShip" or unit.Class == "Cargo" then
			table.insert(core, unit)
		elseif unit.Class == "BattleShip" then
			table.insert(heavy, unit)
		elseif unit.Class == "Cruiser" then
			table.insert(medium, unit)
		else table.insert(light, unit)
		end
	end
	core_cir = 2*math.pi/(#core)
	heavy_cir = 2*math.pi/(#heavy)
	medium_cir = 2*math.pi/(#medium)
	light_cir = 2*math.pi/(#light)
	core_mul = distance_mul*math.sqrt(#core-1)
	heavy_mul = core_mul+1.0*distance_mul*math.sqrt(#heavy)
	medium_mul = heavy_mul+0.4*distance_mul*math.sqrt(#medium)
	light_mul = medium_mul+0.3*distance_mul*math.sqrt(#light)
	core_start = random(1,100)/100*2*math.pi
	heavy_start = random(1,100)/100*2*math.pi
	medium_start = random(1,100)/100*2*math.pi
	light_start = random(1,100)/100*2*math.pi
	-- MissionNarrativePlayer(0, "End Calc")
	poslist = {}
	for idx,unit in pairs(core) do
		coo = {["x"] = center.x+core_mul*math.cos(core_start+idx*core_cir), ["y"] = 0, ["z"] = center.z+core_mul*math.sin(core_start+idx*core_cir)}
		unit.coo = coo
	end
	for idx,unit in pairs(heavy) do
		coo = {["x"] = center.x+heavy_mul*math.cos(heavy_start+idx*heavy_cir), ["y"] = 0, ["z"] = center.z+heavy_mul*math.sin(heavy_start+idx*heavy_cir)}
		unit.coo = coo
	end
	for idx,unit in pairs(medium) do
		coo = {["x"] = center.x+medium_mul*math.cos(medium_start+idx*medium_cir), ["y"] = 0, ["z"] = center.z+medium_mul*math.sin(medium_start+idx*medium_cir)}
		unit.coo = coo
	end
	for idx,unit in pairs(light) do
		coo = {["x"] = center.x+light_mul*math.cos(light_start+idx*light_cir), ["y"] = 0, ["z"] = center.z+light_mul*math.sin(light_start+idx*light_cir)}
		unit.coo = coo
	end
	for idx,unit in pairs(fleet.groupMembers) do
		SpawnNew({
			["party"] = fleet.party,
			["groupMembers"] = { unit },
			["area"] = {
				["refPos"] = unit.coo,
				["angleRange"] = fleet.area.angleRange,
				["lookAt"] = fleet.area.lookAt,
			},
			["excludeRadiusOverride"] = fleet.excludeRadiusOverride,
			["callback"] = fleet.callback,
			["id"] = fleet.id,
		})
	end
	return poslist
end

function destroyerAntiSub(params)
	local destroyer = params.ParamTable.destroyer
	local subs = luaRemoveDeadsFromTable(params.ParamTable.subs)
	if not destroyer or destroyer.Dead then return end
	luaDelay(destroyerAntiSub, 5, "destroyer",destroyer,"subs",subs)
	if #subs == 0 then return end
	if destroyer.AntiSub ~= nil then
		if luaGetDistance(destroyer, destroyer.AntiSub) < 2500 then return end
	end
	local target, dist = luaSortByDistance2(destroyer,subs,true)
	if dist < 2000 then
		-- MissionNarrativePlayer(0, "iter2"..destroyer.Name)
		destroyer.AntiSub = target
		luaSetScriptTarget(destroyer, target)
		NavigatorAttackMove(destroyer, target)
	end
end
		

function callbackSpawnUSNReinf(...)
	if not Mission.reinf_ready then Mission.reinf_ready = {} end
	table.insert(Mission.reinf_ready, arg[1])
	if arg[1].Class.Type == "Destroyer" then
		-- MissionNarrativePlayer(0, "new"..arg[1].Name)
		luaDelay(destroyerAntiSub, 3, "destroyer",arg[1],"subs",{Mission.PlayerSub})
	end
	if #(Mission.reinf_ready) == Mission.reinf_total then
		luaJM7USNReinfFleetSpawned(unpack(Mission.reinf_ready))
	end
end


--spawnsecond--
---USNreinf
function luaJM7SpawnUSNReinf()
	---test---
	local possible_positions = {
	10000, 10000, 
	10000, 15000, 
	15000, 10000, 
	15000, 15000,
	10000, -10000,
	10000, -15000,
	0, -15000,
	-10000, -15000,
	5000, -5000,
	-10000, -10000}
	local pos = GetPosition(Mission.Akagi)
	local rnd = (random(1,10)-1)*2+1
	pos.x = possible_positions[rnd]
	pos.z = possible_positions[rnd+1]
	-- pos.x = pos.x - 6000
	fleet = {
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 2,
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
				["Class"] = "MotherShip",
			},
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
				["Class"] = "MotherShip",
			},
			{
				["Type"] = 19,
				["Name"] = "Northampton1",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Cruiser",
			},
			{
				["Type"] = 19,
				["Name"] = "Northampton2",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Cruiser",
			},
			{
				["Type"] = 19,
				["Name"] = "Northampton3",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Cruiser",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher1",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher2",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher3",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher4",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher5",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
		},
		["area"] = {
			-- ["refPos"] = GetPosition(Mission.USNReinforcementSPawnPoint),
			["refPos"] = pos,
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
		["callback"] = "callbackSpawnUSNReinf",
		["id"] = Mission.USNReinfReq,
	}
	Mission.reinf_total = #(fleet.groupMembers)
	antiAirFormation(fleet, pos)
end

function luaJM7USNReinfFleetSpawned(...)
	luaDoCustomLog("debug.txt", {"luaJM7USNReinfFleetSpawned"}, "a")
	-- this function is called repetitively
	local leader
	for idx,unit in ipairs(arg) do
		-- SetSkillLevel(unit, Mission.SkillLevel)
		table.insert(Mission.USNReinforcements, unit)

		if idx == 1 then
			leader = unit
		end

		if unit.Class.Type == "MotherShip" then
			if string.find(unit.Name, "Yorktown1") then
				if unit.Class.ID == 2 then
					Mission.Enterprise = unit
				end
			end
			if string.find(unit.Name, "Yorktown2") then
				if unit.Class.ID == 2 then
					Mission.Hornet = unit
				end
			end
		end
	end
	
	-- antiAirFormation(Mission.USNReinforcements)

	Mission.USNReinfIn = true
	for idx,unit in pairs(Mission.USNReinforcements) do
		if unit.ID ~= Mission.Enterprise.ID then
		--if unit.ID ~= leader.ID then
			JoinFormation(unit, Mission.Enterprise)
			JoinFormation(unit, Mission.Hornet)
			--JoinFormation(unit, leader)
		else
			Mission.Enterprise.maxLandSpeed = 10
			Mission.Hornet.maxLandSpeed = 10
			luaAddCVHitListener(Mission.Enterprise, "Enterprise")
			luaAddCVHitListener(Mission.Hornet, "Hornet")
		end
	end

	for idx, unit in pairs(Mission.USNReinforcements) do
						-- RELEASE_LOGOFF  		luaLog("assigning name "..Mission.USNReinfFleetNames[idx][1].." to "..unit.Name)
		SetGuiName(unit, Mission.USNReinfFleetNames[idx][1])
		RepairEnable(unit, false)
		SetNumbering(unit, Mission.USNReinfFleetNames[idx][2])
	end
	
	-- SetFormationShape(Mission.Enterprise, 1)
	-- if true then return end

	--NavigatorMoveOnPath(Mission.Hornet, FindEntity("USNReinfPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	-- NavigatorMoveOnPath(leader, FindEntity("USNReinfPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	local defaults = {FindEntity("USNReinfPath"), PATH_FM_CIRCLE, PATH_SM_JOIN}
	local points = {{{10000,10000},{15000,15000},{20000,20000}},
		{{-10000,10000},{-15000,15000},{-20000,20000}},
		{{-10000,-10000},{-15000,-15000},{-20000,-20000}},
		{{10000,-10000},{15000,-15000},{20000,-20000}}}
	MissionNarrativePlayer(0, "s0")
	luaDelay(strategicPath, 1, "fleet", Mission.USNReinforcements,"like",{Mission.Akagi, Mission.Kaga, Mission.Soryu, Mission.Hiryu}, "dislike", {Mission.Haruna, Mission.Kirishima}, "defaults", defaults, "points", points, "call", 0)
	-- luaJM7SpawnIJNHoshoFleet()
end

function strategicPath(params)
	if not Mission.strategicPathCall then Mission.strategicPathCall = 0  end
	if params.ParamTable.call ~= Mission.strategicPathCall then return end -- It is crazy, idk why it is replicating!!!!!
	Mission.strategicPathCall = Mission.strategicPathCall + 1
	luaDoCustomLog("debug.txt", {"strategicPath "..Mission.strategicPathCall.." call from "..params.ParamTable.call}, "a")
	local fleet = params.ParamTable.fleet
	local like = params.ParamTable.like
	local dislike = params.ParamTable.dislike
	local defaults = params.ParamTable.defaults
	local points = params.ParamTable.points
	if fleet then fleet = luaRemoveDeadsFromTable(fleet) end
	if like then like = luaRemoveDeadsFromTable(like) end
	if dislike then dislike = luaRemoveDeadsFromTable(dislike) end
	if #fleet == 0 then return end
	local leader = fleet[1]
	luaDelay(strategicPath, 5, "fleet", fleet, "like",like, "dislike", dislike, "defaults", defaults, "points", points, "call", Mission.strategicPathCall)
	if not leader or leader.Dead then return end
	-- MissionNarrativePlayer(0, "s3")
	if #dislike == 0 then
		NavigatorMoveOnPath(leader, defaults[1], defaults[2], defaults[3])
	else
		local closest_node
		local distance = 99999999.0
		local cur = GetPosition(leader)
		for i, node in pairs(points) do
			for j, subnode in pairs(node) do
				local this_dist = math.pow(cur.x-subnode[1], 2)+math.pow(cur.z-subnode[2],2)
				if this_dist < distance then
					distance = this_dist
					closest_node = {i,j}
				end
			end
		end
		-- MissionNarrativePlayer(0, "s4")
		local target_node-- = points[closest_node[1]][closest_node[2]]
		local score = -99999999.0
		for i=-1,1 do
			local index = (closest_node[1]-1+i)%(#points)+1
			for j, subnode in pairs(points[index]) do
				local sc1 = 99999999.0
				local sc2 = 99999999.0
				local sc3 = -99999999.0
				for _, d in pairs(dislike) do
					local dispos = GetPosition(d)
					local enm_sel_x = subnode[1] - cur.x
					local enm_sel_z = subnode[2] - cur.z
					local enm_sel = math.sqrt(math.pow(enm_sel_x,2)+math.pow(enm_sel_z,2))
					local enm_pos_x = dispos.x - cur.x
					local enm_pos_z = dispos.z - cur.z
					local enm_pos = math.sqrt(math.pow(enm_pos_x,2)+math.pow(enm_pos_z,2))
					local cosine = (enm_sel_x*enm_pos_x+enm_sel_z*enm_pos_z)/enm_sel/enm_pos
					-- local dist = math.sqrt(math.pow(dispos.x-subnode[1], 2)+math.pow(dispos.z-subnode[2],2))
					local dist = math.sqrt(math.pow(enm_pos_x, 2)+math.pow(enm_pos_z,2))
					sc1 = math.min(-cosine, sc1)
					sc2 = math.min(dist, sc2)
				end
				for _, l in pairs(like) do
					local dispos = GetPosition(l)
					local enm_sel_x = subnode[1] - cur.x
					local enm_sel_z = subnode[2] - cur.z
					local enm_sel = math.sqrt(math.pow(enm_sel_x,2)+math.pow(enm_sel_z,2))
					local enm_pos_x = dispos.x - cur.x
					local enm_pos_z = dispos.z - cur.z
					local enm_pos = math.sqrt(math.pow(enm_pos_x,2)+math.pow(enm_pos_z,2))
					local cosine = (enm_sel_x*enm_pos_x+enm_sel_z*enm_pos_z)/enm_sel/enm_pos
					-- local dist = math.sqrt(math.pow(dispos.x-subnode[1], 2)+math.pow(dispos.z-subnode[2],2))
					local dist = math.sqrt(math.pow(enm_pos_x, 2)+math.pow(enm_pos_z,2))
					sc3 = math.max(cosine, sc3)-dist
				end
				local sc4
				if sc2 < 10000 then sc4 = sc1
				else sc4 = sc3 end
				if subnode == points[closest_node[1]][closest_node[2]] then
					sc4 = -999999999.0
				end
				if sc4 > score then
					target_node = subnode
					score = sc4
				end
			end
		end
		NavigatorMoveToPos(leader, {["x"] = target_node[1], ["y"] = 0.0, ["z"] = target_node[2]})
		-- MissionNarrativePlayer(0, target_node[1].."  "..target_node[2])
	end
	luaDoCustomLog("debug.txt", {"strategicPath End"}, "a")

end

function luaAirfieldManager(airfield, fighterClassIDs, otherClassIDs, targetList, travelAlt, wingCount)
		-- RELEASE_LOGOFF  	luaHelperLog("luaAirfieldManager Called!")
		-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable({airfield}), "***ERROR: luaAirfieldManager needs an airfield/carrier as first param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(fighterClassIDs ~= nil and luaIsNumberTable(fighterClassIDs), "***ERROR: luaAirfieldManager needs a classID table as second param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(otherClassIDs ~= nil and luaIsNumberTable(otherClassIDs), "***ERROR: luaAirfieldManager needs a classID table as third param!"..debug.traceback())
	if targetList then
		-- RELEASE_LOGOFF  		Assert(luaIsEntityTable(targetList, true), "***ERROR: luaAirfieldManager's targetList must be a unitlist!"..debug.traceback())
	else
		targetList = {}
	end
	if travelAlt then
		-- RELEASE_LOGOFF  		Assert(type(travelAlt) == "number", "***ERROR: luaAirfieldManager's travelAlt must be a number!"..debug.traceback())
	end
	if wingCount then
		-- RELEASE_LOGOFF  		Assert(wingCount == 1 or wingCount == 2 or wingCount == 3, "***ERROR: luaAirfieldManager's wingCount must be 1, 2 or 3!"..debug.traceback())
	else
		wingCount = 3
	end

	local slotSetting = GetProperty(airfield, "NumSlots")
	--luaLog("slotsetting "..tostring(slotsetting))
	local activeSquads = 0
	local planeEntTable = {}
	local slotIndex
	activeSquads, planeEntTable = luaGetSlotsAndSquads(airfield)
	--luaHelperLog("active squads: "..tostring(activeSquads))
	if activeSquads == 0 and IsReadyToSendPlanes(airfield) then
		local i = luaRnd(1,table.getn(fighterClassIDs))
		if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		else
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		end
		airfield.slots = GetProperty(airfield, "slots")
		planeEntTable = {}
		table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
		
		if Mission.AirfieldManagerFunctionFighterTable and type(Mission.AirfieldManagerFunctionFighterTable) == "table" then
		
			table.insert(Mission.AirfieldManagerFunctionFighterTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
		end
		
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
	elseif activeSquads < slotSetting and IsReadyToSendPlanes(airfield) then
		if table.getn(luaTypeFilter(planeEntTable, "Fighter")) == 0 then
			local i = luaRnd(1,table.getn(fighterClassIDs))
			if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
			if Mission.AirfieldManagerFunctionFighterTable and type(Mission.AirfieldManagerFunctionFighterTable) == "table" then
			
				table.insert(Mission.AirfieldManagerFunctionFighterTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
				
			end
			
		-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		else
			local i = luaRnd(1,table.getn(otherClassIDs))
			if VehicleClass[otherClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
			if Mission.AirfieldManagerFunctionBomberTable and type(Mission.AirfieldManagerFunctionBomberTable) == "table" then
			
				table.insert(Mission.AirfieldManagerFunctionBomberTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
				
			end
			
		-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		end
	elseif activeSquads >= slotSetting then
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: There isn't any free slots!"..airfield.Name)
	else
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: Airfield occupied!"..airfield.Name)
	end

	if not planeEntTable then
		return
	end

	for index, unit in pairs (planeEntTable) do
		unit.ammo = GetProperty(unit, "ammoType")
		if unit.Class.Type == "Fighter" then
		-- RELEASE_LOGOFF  			luaHelperLog("Unit on patrol:"..unit.Name)
		elseif ( UnitGetAttackTarget(unit) == nil ) and (unit.ammo ~= 0 or unit.Class.Type == "Kamikaze") then
		-- RELEASE_LOGOFF  			luaHelperLog("Unit searching for new target:"..unit.Name)
			--luaHelperLog("targetList")
			--luaHelperLog(targetList)
			local filteredTargetList = {}
			if unit.ammo == AMMO_TORPEDO and next(targetList) then
				local tempTargetList = {}
				local filtered = false
				for index, target in pairs (targetList) do
					if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
						table.insert(tempTargetList, target)
					else
						filtered = true
					end
				end
				if filtered and table.getn(tempTargetList) == 0 then
		-- RELEASE_LOGOFF  					luaHelperLog("There is no valid torpedo target in targetList!")
				elseif filtered then
		-- RELEASE_LOGOFF  					luaHelperLog("Invalid torpedo targets removed from targetList!")
				end
				filteredTargetList = tempTargetList
			else
		-- RELEASE_LOGOFF  				luaHelperLog("There is no need for target filtering for this unit!")
				filteredTargetList = targetList
			end
			--luaHelperLog("filteredTargetList")
			--luaHelperLog(filteredTargetList)

			local shipsAround
			local number
			if not filteredTargetList or not next(filteredTargetList) then
				shipsAround, number = luaGetShipsAround(airfield, 10000, "enemy")
				if shipsAround and (unit.ammo == AMMO_TORPEDO or unit.Class.Type == "Kamikaze") then
					local tempShipsAround = {}
					local filtered = false
					for index, target in pairs (shipsAround) do
						if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
							table.insert(tempShipsAround, target)
						else
							filtered = true
						end
					end
					if filtered and table.getn(tempShipsAround) == 0 then
		-- RELEASE_LOGOFF  						luaHelperLog("There isn't any valid torpedo/kamikaze target in range!")
						shipsAround = nil
					elseif filtered then
						shipsAround = tempShipsAround
					end
				end
			end

			if shipsAround then
				local preferedTargets = luaTypeFilter(shipsAround, "MotherShip")
				if table.getn(preferedTargets) == 0 then
					preferedTargets = shipsAround
				end
				---luaLogElementNames(preferedTargets, "preferedTargets")

				local currentTarget
				local distance
				currentTarget, distance = luaSortByDistance(unit, preferedTargets, true)
		-- RELEASE_LOGOFF  				luaHelperLog("Targeting... "..tostring(currentTarget.Name))
				PilotSetTarget(unit, currentTarget)
				if unit.ammo == AMMO_BOMB and travelAlt then
					SquadronSetTravelAlt(unit, travelAlt)
					SquadronSetAttackAlt(unit, travelAlt)
				end
				unit.AirfieldManager = nil
		-- RELEASE_LOGOFF  				luaHelperLog("Orders received, Target confirmed:"..unit.Name..currentTarget.Name)
			elseif filteredTargetList and next(filteredTargetList) then
				--luaLogElementNames(filteredTargetList, " Designated target ")
		-- RELEASE_LOGOFF  				luaHelperLog("Choosing one from the designated targets...")
				local currentTarget = luaPickRnd(filteredTargetList)
		-- RELEASE_LOGOFF  				luaHelperLog(" Chosen target: "..currentTarget.Name)
				PilotSetTarget(unit, currentTarget)
				if unit.ammo == AMMO_BOMB and travelAlt then
					SquadronSetTravelAlt(unit, travelAlt)
					SquadronSetAttackAlt(unit, travelAlt)
				end
				unit.AirfieldManager = nil
			else
				if unit.AirfieldManager == nil then
					PilotMoveToRange(unit,airfield,2000)
					unit.AirfieldManager = "PilotMoveToRange"
		-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Returning for patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				else
		-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Continuing patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				end
			end
		elseif unit.ammo ~= 0 or unit.Class.Type == "Kamikaze" then
		-- RELEASE_LOGOFF  			luaHelperLog("Unit with ammo and active target:"..unit.Name..GetProperty(unit, "unitcommand")..GetPrimaryTarget(unit).Name)
		end
	end
end

function luaAirfieldManager1(airfield, fighterClassIDs, otherClassIDs, targetList, travelAlt, wingCount)
	-- RELEASE_LOGOFF  	luaHelperLog("luaAirfieldManager Called!")
	-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable({airfield}), "***ERROR: luaAirfieldManager needs an airfield/carrier as first param!"..debug.traceback())
	-- RELEASE_LOGOFF  	Assert(fighterClassIDs ~= nil and luaIsNumberTable(fighterClassIDs), "***ERROR: luaAirfieldManager needs a classID table as second param!"..debug.traceback())
	-- RELEASE_LOGOFF  	Assert(otherClassIDs ~= nil and luaIsNumberTable(otherClassIDs), "***ERROR: luaAirfieldManager needs a classID table as third param!"..debug.traceback())
	if targetList then
		-- RELEASE_LOGOFF  		Assert(luaIsEntityTable(targetList, true), "***ERROR: luaAirfieldManager's targetList must be a unitlist!"..debug.traceback())
	else
		targetList = {}
	end
	if travelAlt then
		-- RELEASE_LOGOFF  		Assert(type(travelAlt) == "number", "***ERROR: luaAirfieldManager's travelAlt must be a number!"..debug.traceback())
	end
	if wingCount then
		-- RELEASE_LOGOFF  		Assert(wingCount == 1 or wingCount == 2 or wingCount == 3, "***ERROR: luaAirfieldManager's wingCount must be 1, 2 or 3!"..debug.traceback())
	else
		wingCount = 3
	end

	local slotSetting = GetProperty(airfield, "NumSlots")
	--luaLog("slotsetting "..tostring(slotsetting))
	local activeSquads = 0
	local planeEntTable = {}
	local slotIndex
	activeSquads, planeEntTable = luaGetSlotsAndSquads(airfield)
	if math.floor(GameTime()) % 15 == 0 then
		-- MissionNarrativePlayer(0,airfield.Name.." active squads: "..tostring(activeSquads))
	end
	if airfield.FighterCount == nil then airfield.FighterCount = 0 end
	if (activeSquads == 0) and IsReadyToSendPlanes(airfield) then
		local i = luaRnd(1,table.getn(fighterClassIDs))
		if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		else
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		end
		airfield.slots = GetProperty(airfield, "slots")
		planeEntTable = {}
		table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
		
		if Mission.AirfieldManagerFunctionFighterTable and type(Mission.AirfieldManagerFunctionFighterTable) == "table" then
		
			table.insert(Mission.AirfieldManagerFunctionFighterTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
		end
		
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
	elseif activeSquads < slotSetting and IsReadyToSendPlanes(airfield) then
		if table.getn(luaTypeFilter(planeEntTable, "Fighter")) < 2 then
			local i = luaRnd(1,table.getn(fighterClassIDs))
			if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
			if Mission.AirfieldManagerFunctionFighterTable and type(Mission.AirfieldManagerFunctionFighterTable) == "table" then
			
				table.insert(Mission.AirfieldManagerFunctionFighterTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
				
			end
			
		-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		else
			local i = luaRnd(1,table.getn(otherClassIDs))
			if VehicleClass[otherClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
			
			if Mission.AirfieldManagerFunctionBomberTable and type(Mission.AirfieldManagerFunctionBomberTable) == "table" then
			
				table.insert(Mission.AirfieldManagerFunctionBomberTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
				
			end
			
		-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		end
	elseif activeSquads >= slotSetting then
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: There isn't any free slots!"..airfield.Name)
	else
		-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: Airfield occupied!"..airfield.Name)
	end

	if not planeEntTable then
		return
	end
	airfield.FighterCount = 0
	if not airfield.CAP then airfield.CAP = {} end
	airfield.CAP = luaRemoveDeadsFromTable(airfield.CAP)
	for index, unit in pairs (planeEntTable) do
		unit.ammo = GetProperty(unit, "ammoType")
		if unit.Class.Type == "Fighter" then
			airfield.FighterCount = airfield.FighterCount + 1
			if #(airfield.CAP) > 0 and not unit.CAP then
				for index1, unit1 in pairs(planeEntTable) do
					if unit1 and not unit1.Dead then
						ammo1 = GetProperty(unit1, "ammoType")
						if luaGetDistance(unit, unit1) < 1000 and (ammo1 == AMMO_BOMB or ammo1 == AMMO_TORPEDO) then
							PilotMoveTo(unit, unit1)
						end
					end
				end
			elseif luaGetDistance(unit, airfield) < 3000 then
				if not unit.CAP then
					table.insert(airfield.CAP, unit)
					PilotSetTarget(unit, airfield)
				end
				unit.CAP = true
			end
		-- RELEASE_LOGOFF  			luaHelperLog("Unit on patrol:"..unit.Name)
		elseif ( UnitGetAttackTarget(unit) == nil ) and (unit.ammo ~= 0 or unit.Class.Type == "Kamikaze") then
		-- RELEASE_LOGOFF  			luaHelperLog("Unit searching for new target:"..unit.Name)
			--luaHelperLog("targetList")
			--luaHelperLog(targetList)
			local filteredTargetList = {}
			if unit.ammo == AMMO_TORPEDO and next(targetList) then
				local tempTargetList = {}
				local filtered = false
				for index, target in pairs (targetList) do
					if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
						table.insert(tempTargetList, target)
					else
						filtered = true
					end
				end
				if filtered and table.getn(tempTargetList) == 0 then
		-- RELEASE_LOGOFF  					luaHelperLog("There is no valid torpedo target in targetList!")
				elseif filtered then
		-- RELEASE_LOGOFF  					luaHelperLog("Invalid torpedo targets removed from targetList!")
				end
				filteredTargetList = tempTargetList
			else
		-- RELEASE_LOGOFF  				luaHelperLog("There is no need for target filtering for this unit!")
				filteredTargetList = targetList
			end
			--luaHelperLog("filteredTargetList")
			--luaHelperLog(filteredTargetList)

			local shipsAround
			local number
			if not filteredTargetList or not next(filteredTargetList) then
				shipsAround, number = luaGetShipsAround(airfield, 10000, "enemy")
				if shipsAround and (unit.ammo == AMMO_TORPEDO or unit.Class.Type == "Kamikaze") then
					local tempShipsAround = {}
					local filtered = false
					for index, target in pairs (shipsAround) do
						if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
							table.insert(tempShipsAround, target)
						else
							filtered = true
						end
					end
					if filtered and table.getn(tempShipsAround) == 0 then
		-- RELEASE_LOGOFF  						luaHelperLog("There isn't any valid torpedo/kamikaze target in range!")
						shipsAround = nil
					elseif filtered then
						shipsAround = tempShipsAround
					end
				end
			end

			if shipsAround then
				local preferedTargets = luaTypeFilter(shipsAround, "MotherShip")
				if table.getn(preferedTargets) == 0 then
					preferedTargets = shipsAround
				end
				---luaLogElementNames(preferedTargets, "preferedTargets")

				local currentTarget
				local distance
				currentTarget, distance = luaSortByDistance(unit, preferedTargets, true)
		-- RELEASE_LOGOFF  				luaHelperLog("Targeting... "..tostring(currentTarget.Name))
				-- PilotSetTarget(unit, currentTarget)
				local alt = 1100
				if unit.ammo == AMMO_TORPEDO then alt = 300 end
				-- MissionNarrativePlayer(0, luaJM7GetUnits(nil, PARTY_JAPANESE)[1].Name)
				if not unit.RegisteredWave then
					unit.wave = airfield.wave
					luaDelay(luaPlaneManeuver, 1, "plane",unit,"trg",currentTarget,"attackAlt",alt,"attackAng",0,"distance",5000,"designated",preferedTargets,"skirmish",luaJM7GetUnits(nil, PARTY_JAPANESE))
				end
				if unit.ammo == AMMO_BOMB and travelAlt then
					-- SetCheatTurbo(unit, 5)
					-- luaDelay(luaPlaneManeuver, 1, "plane",unit,"trg",currentTarget,"attackAlt",1500,"attackAng",0)
				end
				unit.AirfieldManager = nil
		-- RELEASE_LOGOFF  				luaHelperLog("Orders received, Target confirmed:"..unit.Name..currentTarget.Name)
			elseif filteredTargetList and next(filteredTargetList) then
				--luaLogElementNames(filteredTargetList, " Designated target ")
		-- RELEASE_LOGOFF  				luaHelperLog("Choosing one from the designated targets...")
				local currentTarget = luaPickRnd(filteredTargetList)
		-- RELEASE_LOGOFF  				luaHelperLog(" Chosen target: "..currentTarget.Name)
				local alt = 1100
				if unit.ammo == AMMO_TORPEDO then alt = 300 end
				-- MissionNarrativePlayer(0, type(filteredTargetList))
				-- MissionNarrativePlayer(0, luaJM7GetUnits(nil, PARTY_JAPANESE)[1].Name)
				if not unit.RegisteredWave then 
					unit.wave = airfield.wave
					luaDelay(luaPlaneManeuver, 1, "plane",unit,"trg",currentTarget,"attackAlt",alt,"attackAng",0,"distance",5000,"designated",filteredTargetList,"skirmish",luaJM7GetUnits(nil, PARTY_JAPANESE))
				end
				if unit.ammo == AMMO_BOMB and travelAlt then
					-- SetCheatTurbo(unit, 2)
					-- luaDelay(luaPlaneManeuver, 1, "plane",unit,"trg",currentTarget,"attackAlt",1500,"attackAng",0)
				end
				unit.AirfieldManager = nil
			else
				if unit.AirfieldManager == nil then
					PilotMoveToRange(unit,airfield,2000)
					unit.AirfieldManager = "PilotMoveToRange"
		-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Returning for patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				else
		-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Continuing patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				end
			end
		elseif unit.ammo ~= 0 or unit.Class.Type == "Kamikaze" then
		-- RELEASE_LOGOFF  			luaHelperLog("Unit with ammo and active target:"..unit.Name..GetProperty(unit, "unitcommand")..GetPrimaryTarget(unit).Name)
		end
	end
end


function luaJM7CheckUSNCarrierFleet2()
	if Mission.USNReinforcementsWave == nil then
		Mission.USNReinforcementsWave = {["Wave"] = {}, ["Require"] = 0, ["Assemble"] = 0, ["NoWait"] = 600}
	end
	local wave = Mission.USNReinforcementsWave
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
	if Mission.Enterprise.Dead and Mission.Hornet.Dead then
						-- RELEASE_LOGOFF  		luaLog("Enterprise dead")
	else
		local fighterClassIDs = {101}
		local otherClassIDs = {108,112}
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
		wave["Require"] = 0
		if not Mission.Hornet.Dead then
			Mission.Hornet.wave = wave
			if not Mission.Hornet.RunwayFailure then wave["Require"] = wave["Require"] + 4 end
			luaAirfieldManager1(Mission.Hornet, fighterClassIDs, otherClassIDs, targetList, 1500, 3)
			if math.floor(GameTime()) % 10 == 0 then MissionNarrativePlayer(0, "Hornet"..Mission.Hornet.FighterCount.." "..#(Mission.Hornet.CAP)) end
		end
		if not Mission.Enterprise.Dead then
			Mission.Enterprise.wave = wave
			if not Mission.Enterprise.RunwayFailure then wave["Require"] = wave["Require"] + 4 end
			-- luaLaunchAirstrike1()
			luaAirfieldManager1(Mission.Enterprise, fighterClassIDs, otherClassIDs, targetList, 1500, 3)
			if math.floor(GameTime()) % 10 == 0 then MissionNarrativePlayer(0, "Enterprise"..Mission.Enterprise.FighterCount.." "..#(Mission.Enterprise.CAP)) end
		end
		if math.floor(GameTime()) % 10 == 0 then MissionNarrativePlayer(0, #(wave["Wave"])..wave["Require"]..wave["Assemble"]..wave["NoWait"]) end
		if #(wave["Wave"]) >= wave["Require"] or wave["Assemble"] >= wave["NoWait"] then
			for _, p in pairs(wave["Wave"]) do p.wave = nil end -- wave control reach launch attack wave condition. 
			wave["Wave"] = {} -- start to prepare next attack wave
			wave["Assemble"] = 0
		end
		luaJM7ScreenTargeting(Mission.USNReinforcements,2)
	end

	if table.getn(Mission.USNReinforcements) == 0 then
						-- RELEASE_LOGOFF  		luaLog("1st USN Fleet is dead")
		return
	end

	--if Mission.Hornet.Dead then
	if Mission.Enterprise.Dead and Mission.Hornet.Dead then
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
		CV2 = Mission.Hornet
		CV1 = Mission.Enterprise
	end

	local shipsAroundCV1 = {}
	local shipsAroundCV2 = {}

	if not CV1.Dead then
		shipsAroundCV1 = luaGetShipsAround(CV1, 4000, "enemy")
	end
	if CV2 and not CV2.Dead then
		shipsAroundCV2 = luaGetShipsAround(CV2, 3300, "enemy")
	end

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
					if not IsInFormation(unit) and (not unit.AntiSub or unit.AntiSub.Dead) then
						if CV1 and not CV1.Dead then
							JoinFormation(unit, CV1)
						elseif CV2 and not CV2.Dead then
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
						if CV1 and not CV1.Dead then
							JoinFormation(unit, CV1)
						elseif CV2 and not CV2.Dead then
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
			["Crew"] = Mission.SkillLower,
			["Race"] = USA,
		}
		req = Mission.Shipyard1SpawnReq
		refPoint = Mission.SY1SpawnPoint
	elseif shipyardNum == 2 then
		grpTbl = {
			["Type"] = 27,
			["Name"] = "PT Elco",
			["Crew"] = Mission.SkillLower,
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

	SetSkillLevel(unit, Mission.SkillLower)

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
		-- Effect("Warning Dive DIVE Dive", ORIGO, Mission.Akagi)
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
	PrepareClass(1)
	PrepareClass(2)
	PrepareClass(19)
	PrepareClass(23)
	PrepareClass(27)
	PrepareClass(31)
	PrepareClass(60)
	PrepareClass(70)
	PrepareClass(73)
	PrepareClass(86)
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

			for idx2,unlID in pairs(Mission.Unlockables) do

				if tostring(oldID) == tostring(idx2) then
					SetGuiName(unit, unlID[1])
					break
				else
					SetGuiName(unit, unit.Class.Name)
				end

			end

		else
			SetGuiName(unit, Mission.PlayerFleetNames[idx])
		end
		RepairEnable(unit, false)

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
	ShowHint("IJN07_Hint11")
	ShowHint("IJN07_Hint12")
	ShowHint("IJN07_Hint13")
	ShowHint("IJN07_Hint14")
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

function luaJM7FuelScore()
	Mission.SeletedFuel = GetSelectedUnit()
	if not Mission.SeletedFuel.fuel then Mission.SqLaunched = 0
	else Mission.SqLaunched = math.floor(Mission.SeletedFuel.fuel/Mission.SeletedFuel.maxFuel*100) end
	local line1 = "Selected squadron"
	local line2 = Mission.SqLaunched.."% of oil left"
	luaJM7DisplayScore(4,line1,line2)
	-- DisplayScores(4, 0,"Oil: "..math.floor(Mission.SeletedFuel.fuel).."% left","")
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

function luaJM7Pri4Score()
	--Mission.CarriersSunk
	-- local line1 = "ijn07.obj_p3_onscreen"
	-- local line2 = "ijn07.hint_5_desc"
	DisplayUnitHP({Mission.Akagi, Mission.Kaga, Mission.Soryu, Mission.Hiryu},"Kido Butai")
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
	return math.floor(GameTime()) + random(1300,1480)
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
		OverrideHP(ent, 2300 + random(1,2000))
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

function luaLaunchAirstrike1(phase, stopPhase, airfields, classIDs, entities, num, equipments)
		-- RELEASE_LOGOFF  	Assert(type(phase) == "number" and phase > 0, "***ERROR: luaLaunchAirstrike needs a positive number as first param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(type(stopPhase) == "number" and phase > 0, "***ERROR: luaLaunchAirstrike needs a positive number as second param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(airfields ~= nil and luaIsAirfieldTable(airfields, true), "***ERROR: luaLaunchAirstrike needs a table which consists of airfield/carrier entities as third param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(classIDs ~= nil and luaIsNumberTable(classIDs), "***ERROR: luaLaunchAirstrike needs a classID table as fourth param!"..debug.traceback())
		-- RELEASE_LOGOFF  	Assert(entities ~= nil and luaIsEntityTable(entities, true), "***ERROR: luaLaunchAirstrike needs an entity table as fifth param!"..debug.traceback())

	if not equipments or type(equipments) ~= "table" then
		equipments = {}
	end

	if phase >= stopPhase then
		-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Warning: StopPhase already reached!")
		--luaLog("luaLaunchAirstrike Warning: StopPhase already reached!")
		return phase, entities, 1
	end
	airfields = luaRemoveDeadsFromTable(airfields)
	if table.getn(airfields) == 0 then
		-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Error: There isn't any living airfield!")
		--luaLog("luaLaunchAirstrike Error: There isn't any living airfield!")
		phase = stopPhase
		return phase, entities, 2
	end
	local airfieldWarning = 0
	local airfieldSuccess = 0

	for index, airfield in pairs (airfields) do
		if phase >= stopPhase then
		-- RELEASE_LOGOFF  			luaHelperLog("luaLaunchAirstrike Skipped: StopPhase reached! "..airfield.Name)
			--luaLog("luaLaunchAirstrike Skipped: StopPhase reached! "..airfield.Name)
		else
			airfield.slots = GetProperty(airfield, "slots")
			local numberOfUsedSlots = 0
			local i=1
			while i<5 do
				if airfield.slots[i].squadron ~= nil then
					numberOfUsedSlots = numberOfUsedSlots + 1
				end
				i=i+1
			end
			if numberOfUsedSlots > 999 then
		-- RELEASE_LOGOFF  				luaHelperLog("luaLaunchAirstrike Warning: The following airfield has no available slots! "..airfield.Name)
				--luaLog("luaLaunchAirstrike Warning: The following airfield has no available slots! "..airfield.Name)
				airfieldWarning = airfieldWarning + 1
			elseif numberOfUsedSlots < 999 then
				if IsReadyToSendPlanes(airfield) then
					local i = math.mod(phase-1,table.getn(classIDs))+1
					local slotIndex
					if equipments[i] and type(equipments[i]) == "number" then
						slotIndex = LaunchSquadron(airfield,classIDs[i],num,equipments[i])
					else
						slotIndex = LaunchSquadron(airfield,classIDs[i],num)
					end
					airfield.slots = GetProperty(airfield, "slots")
					table.insert(entities, thisTable[tostring(airfield.slots[slotIndex].squadron)])
		-- RELEASE_LOGOFF  					luaHelperLog("luaLaunchAirstrike Generated: "..entities[table.getn(entities)].Name)
					--luaLog("luaLaunchAirstrike Generated: "..entities[table.getn(entities)].Name)
					phase = phase + 1
					airfieldSuccess = airfieldSuccess + 1
				elseif not IsReadyToSendPlanes(airfield) then
		-- RELEASE_LOGOFF  					luaHelperLog("luaLaunchAirstrike Skipped: Airfield occupied! "..airfield.Name)
					--luaLog("luaLaunchAirstrike Skipped: Airfield occupied! "..airfield.Name)
				end
			end
		end
	end
	if airfieldWarning == table.getn(airfields) then
		-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Skipped: There isn't any free slots!")
		--luaLog("luaLaunchAirstrike Skipped: There isn't any free slots!")
		--phase = stopPhase
		return phase, entities, 3
	end
	if airfieldSuccess > 0 then
		return phase, entities, 0
	else
		-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Skipped: All airfields are busy!")
		--luaLog("luaLaunchAirstrike Skipped: All airfields are busy!")
		return phase, entities, 4
	end
end

function luaPlaneManeuver(params)
	local plane = params.ParamTable.plane
	local trg = params.ParamTable.trg
	local attackAlt = params.ParamTable.attackAlt
	local attackAng = params.ParamTable.attackAng
	local distance = params.ParamTable.distance
	local designated = params.ParamTable.designated
	local skirmish = params.ParamTable.skirmish
	if not plane or plane.Dead or not luaHasFuel(plane) or (plane.planed and attackAng == 0) or plane.landing then return end
	local wave = plane.wave
	-- wave["Wave"] < wave["Require"] and wave["Assemble"] < wave["NoWait"]
	if wave and not plane.RegisteredWave then
		table.insert(wave["Wave"], plane)
	end
	plane.RegisteredWave = true
	if plane.lockedUpTarget or wave then
		if wave then wave["Assemble"] = wave["Assemble"] + 1 end
		luaDelay(luaPlaneManeuver, 1, "plane",plane,"trg",trg,"attackAlt",attackAlt,"attackAng",deg,"distance",distance,"designated",designated, "skirmish",skirmish)
		if not trg or trg.Dead then
			plane.lockedUpTarget = false
		end
		return
	end
	designated = luaRemoveDeadsFromTable(designated)
	if #designated == 0 and Mission.Airfield3 and not Mission.Airfield3.Dead then PilotLand(plane, Mission.Airfield3) end --mission specific
	if not trg or trg.Dead then trg = designated[1] end
	plane.planed = true
	if skirmish then skirmish = luaRemoveDeadsFromTable(skirmish) end
	if skirmish and #skirmish > 0 and not plane.lockedUpTarget then
		new_skirmish = {}
		for _, pot in pairs(skirmish) do
			if pot and not pot.Dead and 
				(GetProperty(plane, "ammoType") == AMMO_TORPEDO and (pot.Class.Type == "MotherShip" or pot.Class.Type == "BattleShip" or pot.Class.Type == "Cargo")
				or GetProperty(plane, "ammoType") == AMMO_BOMB) then
					table.insert(new_skirmish, pot)
			end
		end
		local closestDesignated, closestd = luaSortByDistance2(plane, designated, true)
		local closestSkirmish, closests = luaSortByDistance2(plane, new_skirmish, true)
		-- if closestSkirmish and math.floor(GameTime()) % 20 == 0 then MissionNarrativePlayer(0, "closestSkirmish"..closestSkirmish.Name) end
		if closestSkirmish and not closestSkirmish.Dead and closests < 2000 and (#designated == 0 or closestd > 5000) then
			trg = closestSkirmish
			plane.lockedUpTarget = true
			-- luaSetScriptTarget(plane, closestSkirmish)
			PilotSetTarget(plane, trg)
			luaDelay(luaPlaneManeuver, 1, "plane",plane,"trg",trg,"attackAlt",attackAlt,"attackAng",deg,"distance",distance,"designated",designated, "skirmish",skirmish)
			-- if closestSkirmish and math.floor(GameTime()) % 3 == 0 then MissionNarrativePlayer(0, "in closestSkirmish"..closestSkirmish.Name) end
			return
		end
	end
	-- SetCheatTurbo(plane, 5)
	local dist = math.sqrt(math.pow(GetPosition(plane).x-GetPosition(trg).x, 2)+math.pow(GetPosition(plane).z-GetPosition(trg).z, 2))
	if dist > distance+100 and dist >= 3500 then
		local enm = GetPosition(trg)
		SquadronSetTravelAlt(plane,attackAlt)
		-- SetCheatTurbo(plane, 5)
		local deg
		if attackAng > 0 then deg = attackAng
		else deg = random(1,360)/180*math.pi end
		local inc_x = math.cos(deg)*distance
		local inc_z = math.sin(deg)*distance
		enm.x = enm.x + inc_x
		enm.z = enm.z + inc_z
		PilotMoveTo(plane, enm)
		luaDelay(luaPlaneManeuver, 1, "plane",plane,"trg",trg,"attackAlt",attackAlt,"attackAng",deg,"distance",distance,"designated",designated, "skirmish",skirmish)
	elseif dist < 4000 then
		if not plane.lockedUpTarget then
			plane.lockedUpTarget = true
			local sel = GetPosition(plane)
			local enm = GetPosition(trg)
			local ori = trg
			local enm_sel_x = sel.x - enm.x
			local enm_sel_z = sel.z - enm.z
			local enm_sel = math.sqrt(math.pow(enm_sel_x,2)+math.pow(enm_sel_z,2))
			local curcos = 0.8
			-- MissionNarrativePlayer(0, plane.Class.Name.." enter attack "..trg.Class.Name)
			for _, pos in pairs(designated) do
				-- MissionNarrativePlayer(0, plane.Class.Name.." enter attack "..trg.Class.Name)
				local dist2 = math.sqrt(math.pow(GetPosition(plane).x-GetPosition(pos).x, 2)+math.pow(GetPosition(plane).z-GetPosition(pos).z, 2))
				if dist > dist2 then
					local pos1 = GetPosition(pos)
					local enm_pos_x = pos1.x - enm.x
					local enm_pos_z = pos1.z - enm.z
					local enm_pos = math.sqrt(math.pow(enm_pos_x,2)+math.pow(enm_pos_z,2))
					local cosine = (enm_sel_x*enm_pos_x+enm_sel_z*enm_pos_z)/enm_sel/enm_pos
					if cosine > 0.8 and cosine > curcos then
						trg = pos
						curcos = cosine
					end
				end
			end
			-- MissionNarrativePlayer(0, plane.Class.Name.." enter attack "..trg.Class.Name.." instead "..ori.Class.Name)
			-- luaSetScriptTarget(plane, trg)
			PilotSetTarget(plane, trg)
			luaDelay(luaPlaneManeuver, 1, "plane",plane,"trg",trg,"attackAlt",attackAlt,"attackAng",deg,"distance",distance,"designated",designated, "skirmish",skirmish)
		end
	else
		local enm = GetPosition(trg)
		SquadronSetTravelAlt(plane,attackAlt)
		-- SetCheatTurbo(plane, 5)
		local deg
		if attackAng > 0 then deg = attackAng
		else deg = random(1,360)/180*math.pi end
		local inc_x = math.cos(deg)*distance*0.7
		local inc_z = math.sin(deg)*distance*0.7
		enm.x = enm.x + inc_x
		enm.z = enm.z + inc_z
		PilotMoveTo(plane, enm)
		luaDelay(luaPlaneManeuver, 0.5, "plane",plane,"trg",trg,"attackAlt",attackAlt,"attackAng",deg,"distance",math.min(distance,dist)*0.8,"designated",designated, "skirmish",skirmish)
	end
end

function luaJM7AF_Think(this, msg)

	-- if true then return end
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
					MissionNarrativePlayer(0,"Airfield1 has no more planes")
					luaDelay(luaJM7ReloadAF1, 300)
					Mission.Airfield1.Reload = true
				end
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield1)
			local activeSquads, squadTable = luaGetSlotsAndSquads(Mission.Airfield1)
			if activeSquads < 4 and IsReadyToSendPlanes(Mission.Airfield1) then
				LaunchSquadron(Mission.Airfield1, 133, random(2,3))
			end
			if squadTable then
				for _, sq in pairs(squadTable) do
					if sq and not sq.fuelCount then
						luaDelay(luaFuel, 1, "sq", sq, "carrier", Mission.Airfield1, "burn", random(12,14)/100)
						sq.fuelCount = true
					end
				end
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
					MissionNarrativePlayer(0,"Airfield2 has no more planes")
					luaDelay(luaJM7ReloadAF2, 300)
					Mission.Airfield2.Reload = true
				end
			else
						-- RELEASE_LOGOFF  				luaLog("Airfield2 is disabled ")
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield2)
			local fighterClassIDs = {133}
			local otherClassIDs = {108,112,108,112}

			if Mission.Airfield2StrikeOngoing then
				Mission.Airfield2Ents = luaRemoveDeadsFromTable(Mission.Airfield2Ents)
				if table.getn(Mission.Airfield2Ents) == 0 then
					Mission.Airfield2StrikeOngoing = false
					Mission.Airfield2Phase = 1
				end
			end

			if Mission.Airfield2Phase == 7 then --5

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
						if squadron and not squadron.fuelCount then
							luaDelay(luaFuel, 1, "sq", squadron, "carrier", Mission.Airfield2, "burn", random(12,14)/100)
							squadron.fuelCount = true
						end
						if ammo ~= 0 then
							luaDelay(luaPlaneManeuver, 1, "plane",squadron,"trg",trg,"attackAlt",1500,"attackAng",0,"distance",5000,"designated",targetList)
							-- luaSetScriptTarget(squadron, trg)
							-- PilotSetTarget(squadron, trg)
						end
					end
				end
				Mission.Airfield2StrikeOngoing = true

			elseif Mission.Airfield2Phase < 7 then --5

				Mission.Airfield2Phase, Mission.Airfield2Ents, errorLvl = luaLaunchAirstrike1(Mission.Airfield2Phase, 7, {Mission.Airfield2}, otherClassIDs, Mission.Airfield2Ents, 2) --5
				Mission.Airfield2StrikeOngoing = false

			end

			--luaAirfieldManager(Mission.Airfield2, fighterClassIDs, otherClassIDs, targetList)
		end
	end

	--airfield3
	if not Mission.Airfield3.HiddenDisabled then
		if math.floor(GameTime()) % 10 == 0 then
			-- MissionNarrativePlayer(0,"Airfields has "..Mission.Airfield1.Maxplanes.." "..Mission.Airfield2.Maxplanes.." "..Mission.Airfield3.Maxplanes.." planes")
		end
		if Mission.Airfield3.Dead or luaJM7IsDisabled(Mission.Airfield3) or not Mission.Airfield3.Active then
			if Mission.Airfield3.Maxplanes <= 0 then
						-- RELEASE_LOGOFF  				luaLog("Airfield3 has no more planes")
				if not Mission.Airfield3.Reload then
					MissionNarrativePlayer(0,"Airfield3 has no more planes")
					luaDelay(luaJM7ReloadAF3, 300)
					Mission.Airfield3.Reload = true
				end
			else
						-- RELEASE_LOGOFF  				luaLog("Airfield3 is disabled")
			end
		else
			luaJM7CheckMaxplanes(Mission.Airfield3)
			local fighterClassIDs = {116}
			local otherClassIDs = {118,116,118,116}

			if Mission.Airfield3StrikeOngoing then
				--luaLog("itt")
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfield3Ents)) == 0 then
					Mission.Airfield3Ents = {}
					Mission.Airfield3StrikeOngoing = false
					Mission.Airfield3Phase = 1
				end
			end

			if Mission.Airfield3Phase == 6 then --5

				--luaLog("phase "..tostring(phase))
				--luaLog("errorLvl "..tostring(errorLvl))

				local targetList = {}
				if next(luaJM7GetUnits("mothership",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting battleships")
					targetList = luaJM7GetUnits("mothership",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("battleship",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting motherships")
					targetList = luaJM7GetUnits("battleship",PARTY_JAPANESE)
				elseif next(luaJM7GetUnits("cargo",PARTY_JAPANESE)) ~= nil then
					--luaLog("Getting cargoships")
					targetList = luaJM7GetUnits("cargo",PARTY_JAPANESE)
				else
					targetList = luaJM7GetUnits(nil,PARTY_JAPANESE)
				end

				local trg = luaPickRnd(targetList)
				for idx2,squadron in pairs(Mission.Airfield3Ents) do
					-- SetSkillLevel(squadron, Mission.SkillLower)
					if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
						--lualog("-------------")
						--lualog(squadron)
						local ammo = GetProperty(squadron, "ammoType")
						if squadron and not squadron.fuelCount then
							luaDelay(luaFuel, 1, "sq", squadron, "carrier", Mission.Airfield3, "burn", random(12,14)/100)
							squadron.fuelCount = true
						end
						if ammo ~= 0 then
							luaDelay(luaPlaneManeuver, 1, "plane",squadron,"trg",trg,"attackAlt",1500,"attackAng",0,"distance",5000,"designated",targetList)
							-- luaSetScriptTarget(squadron, trg)
							-- PilotSetTarget(squadron, trg)
						end
					end
				end

				Mission.Airfield3StrikeOngoing = true

			elseif Mission.Airfield3Phase < 6 then --5

				Mission.Airfield3Phase, Mission.Airfield3Ents, errorLvl = luaLaunchAirstrike1(Mission.Airfield3Phase, 6, {Mission.Airfield3}, otherClassIDs, Mission.Airfield3Ents, 1) --5
				Mission.Airfield3StrikeOngoing = false

			end

			--luaAirfieldManager(Mission.Airfield3, fighterClassIDs, otherClassIDs, targetList)
		end
	end

	SetWait(this, 3)
end
--spawnfirst--
function luaJM7SpawnFirstCVFleet()
	---test---
	local possible_positions = {
	10000, 10000, 
	10000, 15000, 
	15000, 10000, 
	15000, 15000,
	10000, -10000,
	10000, -15000,
	0, -15000,
	-10000, -15000,
	5000, -5000,
	-10000, -10000}
	local pos = GetPosition(Mission.Akagi)
	local rnd = (random(1,10)-1)*2+1
	pos.x = possible_positions[rnd]
	pos.z = possible_positions[rnd+1]
	-- pos.x = pos.x + 5000
	fleet = {
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 19,
				["Name"] = "Northampton1",
				["Crew"] = Mission.SkillLevel,
				["Race"] = USA,
				["Class"] = "Cruiser",
			},
			{
				["Type"] = 2,
				["Name"] = "Yorktown0",
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
				["Class"] = "MotherShip",
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
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher2",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher3",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 23,
				["Name"] = "Fletcher4",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Destroyer",
			},
			{
				["Type"] = 19,
				["Name"] = "Northampton2",
				["Crew"] = Mission.SkillLower,
				["Race"] = USA,
				["Class"] = "Cruiser",
			},
		},
		["area"] = {
			-- ["refPos"] = GetPosition(FindEntity("CVSpawn")),
			["refPos"] = pos,
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
		["callback"] = "callbackSpawnUSNCVFleet",
		["id"] = "USNFirstFleet",
	}
	Mission.cv_total = #(fleet.groupMembers)
	antiAirFormation(fleet, pos)
end

function callbackSpawnUSNCVFleet(...)
	if not Mission.cv_ready then Mission.cv_ready = {} end
	table.insert(Mission.cv_ready, arg[1])
	if #(Mission.cv_ready) == Mission.cv_total then
		luaJM7USNCVFleetSpawned(unpack(Mission.cv_ready))
	end
end

function luaJM7USNCVFleetSpawned(...)
	Mission.USNFleet1 = {}
	local ddname

	for idx,unit in ipairs(arg) do
		RepairEnable(unit, false)

		-- SetSkillLevel(unit, Mission.SkillLevel)

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
		else
			Mission.Yorktown.maxLandSpeed = 10
		end
	end
	
	luaAddCVHitListener(Mission.Yorktown, "Yorktown")

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

function luaJM7InitalSkillzLower(tbl)
	for idx,unit in pairs(tbl) do
		SetSkillLevel(unit, Mission.SkillLower)
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