--SceneFile="universe\Scenes\missions\IJN\ijn_01_attack_on_pearl_harbor.scn"
DoFile("Scripts/datatables/Inputs.lua")

--todo:
function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)

	Blackout(true,"",true)
	--PlayBinkMovie("jp_intro.bik")
	Blackout(false, "", 2)

	LoadMessageMap("ijndlg",1)

	Dialogues =
	{
		["Intro1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
			},
		},
		["Intro2"] = {
			["sequence"] = {
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01c",
				},
				--{
				--	["message"] = "idlg01c_1",
				--},
			},
		},
		["Intro3"] = {
			["sequence"] = {
				{
					["message"] = "idlg01d",
				},
				{
					["message"] = "idlg01e",
				},
				{
					["message"] = "idlg01f",
				},
				{
					["message"] = "idlg01g",
				},
			},
		},
	}

	MissionNarrative("ijn01.date_location")
	luaDelay(luaJM1EMDlgA, 8,2)
end

function luaJM1EMDlgA()
	StartDialog("Intro_dlg1", Dialogues["Intro1"] );
	luaDelay(luaJM1EMDlgB, 27)
end

function luaJM1EMDlgB()
	StartDialog("Intro_dlg2", Dialogues["Intro2"] );
	luaDelay(luaJM1EMDlgC, 17)
end

function luaJM1EMDlgC()
	StartDialog("Intro_dlg3", Dialogues["Intro3"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM1")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM1(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM01.lua"

	this.Name = "JM1"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	EnableMessages(false)

	SETLOG(this, true)

	--maptiltas
	ForceEnableInput(IC_MAP_TOGGLE, false)

	SetDeviceReloadTimeMul(3)

	luaJM1AddStoredTips()

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	end

	--debug
	Mission.Debug = false

	--reload
	SetDeviceReloadEnabled(true)

	--fire managerhez
	Mission.BigFire = false

	--smoke managerhez
	Mission.BigSmoke = false

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM1LoadMissionData, luaJM1SpawnPhase2PlayerUnit, luaJM1StartFireManager, luaJM1StartSmokeManager, luaJM1StartFlakManager },
		[2] = {luaJM1LoadMissionData, luaJM1SpawnPhase1PlayerUnit, luaJM1StartFireManager, luaJM1StartSmokeManager, luaJM1StartFlakManager },
		--[1] = {luaJM1LoadMissionData, luaJM1SpawnPhase2PlayerUnit, luaJM1StartFireManager},
		--[2] = {luaJM1LoadMissionData, luaJM1SpawnPhase1PlayerUnit, luaJM1StartFireManager},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM1SaveMissionData,},
		[2] = {luaJM1SaveMissionData,},
	}

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.CompleteMsg = "ijn01.obj_missioncompleted"

	--this.ObjRemindTime = 90

	--units, objects
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield 01"))
		table.insert(Mission.Airfields, FindEntity("Airfield 02"))

	SetSkillLevel(Mission.Airfields[1], Mission.SkillLevel)
	SetSkillLevel(Mission.Airfields[2], Mission.SkillLevel)

	SetInvincible(Mission.Airfields[1],1)
	SetInvincible(Mission.Airfields[2],1)

	Mission.PlayerUnit = FindEntity("A6M Zero")

	if Mission.Difficulty == 0 then
		AddUntouchableUnit(Mission.PlayerUnit)
	end

	SquadronSetTravelAlt(Mission.PlayerUnit, 550, true)
	SetSelectedUnit(Mission.PlayerUnit)
	PilotMoveToRange(Mission.PlayerUnit, FindEntity("PlayerMoveTo"))

	Mission.Phase1Zeros = {}
		table.insert(Mission.Phase1Zeros, FindEntity("AIZero 01"))
		table.insert(Mission.Phase1Zeros, FindEntity("AIZero 02"))
		table.insert(Mission.Phase1Zeros, FindEntity("AIZero 03"))
		table.insert(Mission.Phase1Zeros, FindEntity("AIZero 04"))
		table.insert(Mission.Phase1Zeros, FindEntity("AIZero 05"))
		--table.insert(Mission.Phase1Zeros, FindEntity("AIZero 08"))
		--table.insert(Mission.Phase1Zeros, FindEntity("AIZero 09"))
		--table.insert(Mission.Phase1Zeros, FindEntity("AIZero 10"))
		--table.insert(Mission.Phase1Zeros, FindEntity("AIZero 11"))

	for idx,unit in pairs(Mission.Phase1Zeros) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		local pos = GetPosition(unit)
		PilotMoveToRange(unit, Mission.Airfields[1])
		SquadronSetTravelAlt(unit, pos.y)
		SquadronSetAttackAlt(unit, 150, true)
	end

	Mission.Utah = FindEntity("Utah")
	Mission.Oklahoma = FindEntity("Oklahoma")
	Mission.Arizona = FindEntity("Arizona")
	Mission.Virginia = FindEntity("West Virginia")

	Mission.DlgUnits = {}
		table.insert(Mission.DlgUnits, FindEntity("California"))--
		table.insert(Mission.DlgUnits, FindEntity("Maryland"))	--
		table.insert(Mission.DlgUnits, FindEntity("Oklahoma"))
		table.insert(Mission.DlgUnits, FindEntity("Tennessee"))	--
		table.insert(Mission.DlgUnits, FindEntity("West Virginia"))
		table.insert(Mission.DlgUnits, FindEntity("Arizona"))
		table.insert(Mission.DlgUnits, FindEntity("Vestal"))
		table.insert(Mission.DlgUnits, FindEntity("Utah"))
		table.insert(Mission.DlgUnits, FindEntity("Neosho"))
		table.insert(Mission.DlgUnits, FindEntity("Nevada"))
		--table.insert(Mission.DlgUnits, Mission.Airfields[1])
		--table.insert(Mission.DlgUnits, Mission.Airfields[2])

	Mission.CapsizedShips = {}

	Mission.Monaghan = FindEntity("Clemson-class 01")
	SetGuiName(Mission.Monaghan, "ingame.shipnames_monaghan")
	SetNumbering(Mission.Monaghan, 354)
	NavigatorEnable(Mission.Monaghan, false)
	AAEnable(Mission.Monaghan, false)
	TorpedoEnable(Mission.Monaghan, false)
	ArtilleryEnable(Mission.Monaghan, false)
	--SetInvincible(Mission.Monaghan, 0.2)

	Mission.Phoenix = FindEntity("Phoenix")
	Mission.PhoenixPos = GetPosition(Mission.Phoenix)
	SetGuiName(Mission.Phoenix, "ingame.shipnames_phoenix")
	--SetInvincible(Mission.Phoenix, 0.2)

	Mission.Neosho = FindEntity("Neosho")
	NavigatorEnable(Mission.Neosho, false)
	AAEnable(Mission.Neosho, false)
	AddUntouchableUnit(Mission.Neosho)
	--SetInvincible(Mission.Neosho, 0.2)
	NavigatorSetAvoidShipCollision(Mission.Neosho, false)
	NavigatorSetAvoidLandCollision(Mission.Neosho, false)

	Mission.California = FindEntity("California")
	--SetInvincible(Mission.California, 0.2)

	Mission.Vestal = FindEntity("Vestal")
	NavigatorEnable(Mission.Vestal, false)
	AAEnable(Mission.Vestal, false)

	Mission.Phase2Vals = {}
	Mission.Phase3Kates = {}
	Mission.AIVals = {}
	Mission.AIKates = {}

	Mission.Nevada = FindEntity("Nevada")
	--SetInvincible(Mission.Nevada, 0.2)
	RepairEnable(Mission.Nevada, false)
	Mission.BombHitOnNevada = 0
	Mission.NevadaListenerActive = false

	--SetInvincible(Mission.Virginia, 0.2)
	Mission.TorpHitOnVirginia = 0
	Mission.VirginiaListenerActive = false

	luaJM1InitStageShips()
	luaJM1SetShipsInvincible(0.4)
	ForceEnableInput(IC_SM_SECONDARY, false)

	Mission.MaxZeros = 2
	Mission.ZeroSpawnReq = "ZerosSpawn"

	Mission.RadioStation = FindEntity("DLRadioTower 01")

	Mission.Phase1Targets = {}
	Mission.HiddenPlanes = {}
		table.insert(Mission.HiddenPlanes, FindEntity("Static Catalina 01"))
		table.insert(Mission.HiddenPlanes, FindEntity("Static Catalina 02"))
		table.insert(Mission.HiddenPlanes, FindEntity("Static Catalina 03"))
		table.insert(Mission.HiddenPlanes, FindEntity("Static Catalina 04"))
		table.insert(Mission.HiddenPlanes, FindEntity("Static Catalina 05"))
		table.insert(Mission.HiddenPlanes, FindEntity("B-17_01"))
		table.insert(Mission.HiddenPlanes, FindEntity("B-17_02"))
	for idx,unit in pairs(Mission.HiddenPlanes) do
		AddUntouchableUnit(unit)
	end

	Mission.HiddenPlanesDeads = {
		[1] = false,
		[2] = false,
		[3] = false,
		[4] = false,
		[5] = false,
		[6] = false,
		[7] = false,
	}

	this.FirePoints = {}
	for i=1,12 do
		local point = FindEntity("Boom_"..tostring(i))
		if point then
			table.insert(this.FirePoints, point)
		end
	end

	this.SmokePoints = {}
	for i=1,13 do
		local point = FindEntity("IslandEffect_"..tostring(i))
		if point then
			table.insert(this.SmokePoints, point)
		end
	end

	Mission.SmokeSpawnOk = true
	Mission.FireSpawnOk = true

	Mission.SmokeAlpha = 0
	SetOldCloudAlpha(Mission.SmokeAlpha)

	Mission.Phase3Paths = {FindEntity("fake_path1"), FindEntity("fake_path2"), FindEntity("fake_path3"), FindEntity("fake_path4"), FindEntity("fake_path5"), FindEntity("fake_path6"), FindEntity("fake_path7"), FindEntity("fake_path8")}

	this.MissionPhase = 1
	this.ThinkNum = 0
	Mission.ShootedDownPlanes = 0

	this.CPUnits = {}
		table.insert(this.CPUnits, FindEntity("Clemson-class 01"))
		table.insert(this.CPUnits, FindEntity("Cassin"))
		table.insert(this.CPUnits, FindEntity("Downes"))
		table.insert(this.CPUnits, FindEntity("Phoenix 01"))
		table.insert(this.CPUnits, FindEntity("Medusa"))
		table.insert(this.CPUnits, FindEntity("Vestal"))
		table.insert(this.CPUnits, FindEntity("Neosho"))
		table.insert(this.CPUnits, FindEntity("Phoenix"))

	this.CPUnitsDeadTbl = {
		[1] = false,
		[2] = false,
		[3] = false,
		[4] = false,
		[5] = false,
		[6] = false,
		[7] = false,
		[8] = false,
	}

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "kill",
				["Text"] = "ijn01.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "bomb",
				["Text"] = "ijn01.obj_p2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		[3] = {
				["ID"] = "torp",
				["Text"] = "ijn01.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[4] = {
				["ID"] = "dogfight2",
				["Text"] = "ijn01.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[5] = {
				["ID"] = "microtut",
				["Text"] = "ijn01.obj_p5",
				--["TextCompleted"] = "ijn01.obj_p5_comp",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "MonaghanShallDie",
				["Text"] = "ijn01.obj_h2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "NeoshoShallDie",
				["Text"] = "ijn01.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
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

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()

	Mission.MessageQ = {}

	this.Dialogues = {
		--into fighter
		["Intro_Fighter"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["message"] = "dlg1c",
				},
				{
					["message"] = "dlg1d",
				},
			},
		},
		--entering x range of warhawks (objective reminder)
		["InRange"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		--if grounded planes aren't killed in X minutes (objective reminder)
		["Grounded_reminder"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
			},
		},
		--success
		["1st_Success"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["message"] = "dlg4c"
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM1AddMicrotutObj",
				},
			},
		},
		--fail
		["1st_fail"] = {
			["sequence"] = {
				{
					["message"] = "dlg5",
				},
			},
		},
		--into divebomber
		["Intro_Diver"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		--bomb the Nevada
		["Nevada_bomb"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
			},
		},
		--if Nevada isn't bombed in X minutes (objective reminder)
		["Nevada_reminder"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
			},
		},
		--Neosho bombed
		["Neosho_hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
			},
		},
		--California ignited
		["Califorina_on_fire"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		--Bomb hit anything else than Neosho or Nevada
		["Bomb_other"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		--1st bomb hit Nevada
		["Nevada_hit1"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},

		--["Arizona_down"] = {
		--	["sequence"] = {
		--		{
		--			["message"] = "dlg13",
		--		},
		--	},
		--},
		--Bombhit failed Nevada
		["Nevada_failed"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		--into torpedobomber
		["Intro_torper"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["message"] = "dlg16",
				},
			},
		},
		--torpedo Virginia
		["Torp_Virginia"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
			},
		},
		--if West Virginia isn't torpedoed in X minutes (objective reminder)
		["Virginia_reminder"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
		--Torpedo hit anything else than Virginia or Monaghan
		["Torp_other"] = {
			["sequence"] = {
				{
					["message"] = "dlg19",
				},
			},
		},
		--Monaghan torpedoed
		["Monaghan_hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg20",
				},
			},
		},
		--Midget sub saved
		["Minisub_saved"] = {
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
				{
					["message"] = "dlg21b",
				},
			},
		},
		--1st torpedo hit
		["Virginia_hit1"] = {
			["sequence"] = {
				{
					["message"] = "dlg22",
				},
			},
		},
		--["Virginia_hit2"] = {
		--	["sequence"] = {
		--		{
		--			["message"] = "dlg23",
		--		},
		--	},
		--},
		--3rd phase (west virginia) success
		["Virginia_success"] = {
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
			},
		},
		-- fail
		["Virginia_fail"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
			},
		},
		--into fighter - dogfight
		["Back_to_fighter"] = {
			["sequence"] = {
				{
					["message"] = "dlg25",
				},
			},
		},
		--dogfight - reminder
		["Dogfight_reminer"] = {
			["sequence"] = {
				{
					["message"] = "dlg26",
				},
			},
		},
		--easter egg1 - henry pt
		["Henry"] = {
			["sequence"] = {
				{
					["message"] = "dlg27",
				},
			},
		},
		--easter egg2 - donald warhawk
		["Donald"] = {
			["sequence"] = {
				{
					["message"] = "dlg28",
				},
			},
		},
		--Midget sub destroys Phoenix
		["Phoenix_dead"] = {
			["sequence"] = {
				{
					["message"] = "dlg29a",
				},
				{
					["message"] = "dlg29b",
				},
			},
		},
		--Nevada tries to beach
		["Nevada_beach"] = {
			["sequence"] = {
				{
					["message"] = "dlg30",
				},
			},
		},
		--Mission end
		["Mission_end"] = {
			["sequence"] = {
				{
					["message"] = "dlg31a",
				},
				{
					["message"] = "dlg31a_1",
				},
				{
					["message"] = "dlg31b",
				},
			},
		},
		---US RADIO TRAFFIC
		--init - while player flies in1
		["Fly_in_radio1"] = {
			["sequence"] = {
				{
					["message"] = "dlg32c",
				},
			},
		},
		--init - while player flies in2
		["Fly_in_radio2"] = {
			["sequence"] = {
				{
					["message"] = "dlg33a",
				},
				{
					["message"] = "dlg33b",
				},
				{
					["message"] = "dlg33c",
				},
				{
					["message"] = "dlg33d",
				},
			},
		},
		--radio station killed
		["Radio_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg34",
				},
			},
		},
		--first US target destroyed
		["Plane_destroyed1"] = {
			["sequence"] = {
				{
					["message"] = "dlg35a",
				},
			},
		},
		["Plane_destroyed2"] = {
			["sequence"] = {
				{
					["message"] = "dlg35b",
				},
			},
		},
		["Plane_destroyed3"] = {
			["sequence"] = {
				{
					["message"] = "dlg35c",
				},
			},
		},
		--firing on US planes on ground
		["Plane_killing"] = {
			["sequence"] = {
				{
					["message"] = "dlg36a",
				},
				{
					["message"] = "dlg36b",
				},
			},
		},
		--x after
		["Nevada_beaching"] = {
			["sequence"] = {
				{
					["message"] = "dlg37a",
				},
				{
					["message"] = "dlg37b",
				},
			},
		},
		--Nevada explodes
		["Nevada_explodes"] = {
			["sequence"] = {
				{
					["message"] = "dlg38",
				},
			},
		},
		--5-10 sec after Nevada exploded
		["Arizona_Hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg39a",
				},
				{
					["message"] = "dlg39b",
				},
				{
					["message"] = "dlg39c",
				},
				{
					["message"] = "dlg39d",
				},
				{
					["message"] = "dlg39d_1",
				},
			},
		},
		--Nevada Dead
		["Arizona_dead"] = {
			["sequence"] = {
				{
					["message"] = "dlg40",
				},
			},
		},
		--Neosho got away
		["Neosho_away"] = {
			["sequence"] = {
				{
					["message"] = "dlg41",
				},
			},
		},
		--Neosho exploded
		["Neosho_exploded"] = {
			["sequence"] = {
				{
					["message"] = "dlg42",
				},
			},
		},
		--Neosho exploded igniting California (hidden completed)
		["Californa_down"] = {
			["sequence"] = {
				{
					["message"] = "dlg43",
				},
			},
		},
		--midget sub event
		["Minisub_init"] = {
			["sequence"] = {
				{
					["message"] = "dlg44a",
				},
				{
					["message"] = "dlg44b",
				},
				{
					["message"] = "dlg44c",
				},
			},
		},
		--After monaghan rammed sub
		["Minisub_rammed"] = {
			["sequence"] = {
				{
					["message"] = "dlg45",
				},
			},
		},
		--Monaghan destroys midget sub
		["Minisub_dead"] = {
			["sequence"] = {
				{
					["message"] = "dlg46",
				},
			},
		},
		--Monaghan lost
		["Monaghan_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg47",
				},
			},
		},
		--Phoenix lost
		["Phoenix_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg48",
				},
			},
		},
		--radio
		["Radio_speech1"] = {
			["sequence"] = {
				{
					["message"] = "dlg49a",
				},
			},
		},
		["Radio_speech2"] = {
			["sequence"] = {
				{
					["message"] = "dlg49b",
				},
			},
		},
		["Radio_speech3"] = {
			["sequence"] = {
				{
					["message"] = "dlg49c",
				},
			},
		},
		["Radio_speech4"] = {
			["sequence"] = {
				{
					["message"] = "dlg49d",
				},
			},
		},
		["Radio_speech4"] = {
			["sequence"] = {
				{
					["message"] = "dlg49e",
				},
			},
		},
		--West Virginia dead
		["WV_dead"] = {
			["sequence"] = {
				{
					["message"] = "dlg50",
				},
			},
		},
		--Oklahoma dead
		["Oklahoma_dead"] = {
			["sequence"] = {
				{
					["message"] = "dlg51",
				},
			},
		},
		--Nevada beached
		["Nevada_beached"] = {
			["sequence"] = {
				{
					["message"] = "dlg52",
				},
			},
		},
		--Utah hit
		["Utah_hit1"] = {
			["sequence"] = {
				{
					["message"] = "dlg53",
				},
			},
		},
		--5-10 sec after utah hit
		["Utah_hit2"] = {
			["sequence"] = {
				{
					["message"] = "dlg54",
				},
			},
		},
		--20-30 sec after utah hit Message
		["Utah_hit3"] = {
			["sequence"] = {
				{
					["message"] = "dlg55",
				},
			},
		},
		--radio governor
		["Governor"] = {
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "dlg56a",
				},
				{
					["message"] = "dlg56a_1",
				},
				{
					["message"] = "dlg56a_2",
				},
				{
					["message"] = "dlg56b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM1EndFlag"
				},
			},
		},
		["MicrotutDone"] = {
			["sequence"] = {
				{
					["message"] = "dlg4d",
				},
				{
					["message"] = "dlg4e",
				},
			},
		},
	}

	LoadMessageMap("ijndlg",1)

	--think
	SetThink(this, "luaJM1_think")

	Mission.Cheat_PhaseShift = false

--	SoundFade(0,"", 0.5)

	Music_Control_SetLevel(MUSIC_TENSION)
	luaDelay(luaJM1StartMessageQ, 2)

	luaJM1GeneratePTTrafic()

	luaJM1AddUtahListener()
	--luaJM1OklahomaListener()
	--luaJM1AddOklahomaListener2()
	luaJM1RadioListener()
	luaJM1DlgListener()
	--luaJM1BBRowListener()

	luaJM1FadeInScene()


	--traffic
	luaJM1InitTrafficUnits()

	--AddWatch("Mission.StopMessages")
end

function luaJM1_think(this, msg)

	if luaMessageHandler (this, msg) == "killed" then
		return
	end

	luaJM1CheckPlayerUnit()

	if not Mission.ManagersStarted then
		if not Mission.CheckpointLoaded then
			luaDelay(luaJM1StartFlakManager, 60)
			luaDelay(luaJM1StartFireManager, 120)
			luaDelay(luaJM1StartSmokeManager, 150)
			Mission.ManagersStarted = true
		end
	end

	if Mission.MissionPhase == 1 then

		if Mission.Inrange then
			luaJM1CheckTrafficUnits()
			luaJM1SetActionMusic()
			if not Mission.BasicPlaneHint3 then
				luaDelay(luaJM1ShowBasicPlane3, 5)
				Mission.BasicPlaneHint3 = true
			end
		end

		luaJM1CheckZeros()

	elseif Mission.MissionPhase == 2 then

		if not Mission.NevadaListenerActive then
			luaJM1AddHitListener()
		end

		if not Mission.ArizonaListener then
			luaJM1AddHitListener3()
		end

		if Mission.PhoenixMustDie then
			luaJM1KillPhoenix()
			Mission.PhoenixMustDie = nil
		end

		luaJM1CheckStageVals()
		luaJM1CheckNeosho()
		--luaJM1CheckMonaghan()

		luaJM1CheckTrafficUnits()

	elseif Mission.MissionPhase == 3 then

		if not Mission.MonaghanListener then
			luaJM1AddMonaghanListener()
			Mission.MonaghanListener = true
		end

		if not Mission.VirginiaListenerActive then
			luaJM1AddHitListener2()
			luaJM1SetShipsInvincible(0.2)
		end

		luaJM1CheckStageKates()
		luaJM1CheckNeosho()
		luaJM1CheckMonaghan()
		luaJM1CheckMinisub()

		luaJM1CheckTrafficUnits()

	elseif Mission.MissionPhase == 4 then

		if Mission.Donald and Mission.DonaldKilledByPlayer then
			if not Mission.Donalddlg then
				MissionNarrativeEnqueue("ijn01.hint_easteregg_1")
				Mission.Donalddlg = true
			end
		end

		if Mission.DlgListener then
			RemoveListener("hit", "dlghit")
			Mission.DlgListener = nil
		end

		luaJM1CheckZeros()
		luaJM1CheckAirfields()
		luaJM1CheckNeosho()
		luaJM1CheckMinisub()
		luaJM1CheckMonaghan()

	end

	luaJM1CheckHenry()


	if this.ThinkNum > 1 then
		luaJM1CheckObjectives()
	elseif this.ThinkNum == 0 then
		this.ThinkNum = this.ThinkNum + 1
	else
		this.ThinkNum = this.ThinkNum + 1
	end

end

function luaJM1SetActionMusic()
	if Mission.ActionMusic then
		return
	end
	Music_Control_SetLevel(MUSIC_ACTION)
	Mission.ActionMusic = true
end

function luaJM1StartFlakManager()
	Mission.FlakManager = CreateScript("luaJM1FMInit")
end

function luaJM1StartFireManager()
	Mission.FireManager = CreateScript("luaJM1FireInit")
end

function luaJM1StartSmokeManager()
	Mission.SmokeManager = CreateScript("luaJM1SmokeInit")
end

function luaJM1CheckAirfields()
	local Airfield1 = Mission.Airfields[1]
	local Airfield2 = Mission.Airfields[2]

	if Mission.GovSpeech then
		return
	end

	--airfield1
	if Airfield1.Dead then
		--lualog("Airfield1 is dead")
	else

		if Mission.MissionPhase == 4 then
			--if Mission.LaunchedPhase4Squads < Mission.MaxPhase4Squads then
				--local activeSquads1, _dummy = luaGetSlotsAndSquads(Airfield1)
				luaCapManager(Airfield1, {274}, 3)
				local activeSquads2, planeEntTable = luaGetSlotsAndSquads(Airfield1)
				--local launched = activeSquads2 - activeSquads1

				if planeEntTable ~= nil then
					for idx,unit in pairs(planeEntTable) do
						if unit and not unit.Dead and not unit.marked then
							luaObj_AddUnit("marker2",1,unit)
							unit.marked = true
						end
					end
				end

				--cp visszatoltesnel a levegoben levo unitok
				if not Mission.CPFighterMarkerCheck then

					local planes = recon[PARTY_ALLIED].own.fighter
					for idx,unit in pairs(planes) do
						if not unit.Dead and not unit.marked then
							luaObj_AddUnit("marker2",1,unit)
							unit.marked = true
						end
					end

					Mission.CPFighterMarkerCheck = true
				end

				--if launched > 0 then
				--	Mission.LaunchedPhase4Squads = Mission.LaunchedPhase4Squads + launched
				--end
			--else
-- RELEASE_LOGOFF  			--	luaLog("Max squadrons limit reached")
			--	Mission.Phase4End = true
			--end
		--else
			--luaCapManager(Airfield1, {135}, 3)
			--luaCapManager(Airfield1, {274}, 3)
		end
	end

	--airfield2
	if Airfield2.Dead then
		--lualog("Airfield2 is dead")
	else

		if Mission.MissionPhase == 4 then
			--if Mission.LaunchedPhase4Squads < Mission.MaxPhase4Squads then
				--local activeSquads1, _dummy = luaGetSlotsAndSquads(Airfield2)
				luaCapManager(Airfield2, {274}, 3)
				local activeSquads2, planeEntTable = luaGetSlotsAndSquads(Airfield2)
				--local launched = activeSquads2 - activeSquads1

				if planeEntTable ~= nil then
					for idx,unit in pairs(planeEntTable) do
						if unit and not unit.Dead and not unit.marked then
							luaObj_AddUnit("marker2",1,unit)
							unit.marked = true
						end
					end
				end

				--if launched > 0 then
				--	Mission.LaunchedPhase4Squads = Mission.LaunchedPhase4Squads + launched
				--end
			--else
			--	Mission.Phase4End = true
			--end
		--else
			--luaLog("Max squadrons limit reached")
			--luaCapManager(Airfield2, {135}, 3)
			--luaCapManager(Airfield2, {274}, 3)
		end

	end
end

function luaJM1SpawnPhase1PlayerUnit()
	luaJM1RestrictPlayer()
	local rnd = random(1,3)

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		Mission.UnitToKill = Mission.PlayerUnit
	end

	if not Mission.Inrange then
		Mission.PlayerUnit = GenerateObject("PlayerZero 04", "globals.unitclass_zero")
	else
		Mission.PlayerUnit = GenerateObject("PlayerZero 0"..tostring(rnd), "globals.unitclass_zero")
	end

	luaJM1AnnounceSpawn(Mission.PlayerUnit.Name)
	--SetGuiName(Mission.PlayerUnit, "A6M Zero")
	PilotMoveToRange(Mission.PlayerUnit, FindEntity("PlayerMoveTo"))
	SquadronSetTravelAlt(Mission.PlayerUnit, 300, true)

	if Mission.Difficulty == 0 then
		AddUntouchableUnit(Mission.PlayerUnit)
	end

	Mission.StopMessages = true
	luaJM1JumpToUnit(Mission.PlayerUnit)
end

function luaJM1GetPhase1targets()
	--luaLog("luaJM1GetPhase1targets called")

	Mission.AFMovieFirePoints = {}
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		--luaLog("Checking unit: "..unit.Name)
		--luaLog("Dead flag: "..tostring(unit.Dead))
		if not unit.Dead and (string.find(unit.Name, "Static warhawk") or string.find(unit.Name, "Static B")) then
			--luaLog("Adding unit "..unit.Name.." to objtable")
			table.insert(Mission.Phase1Targets, unit)
			table.insert(Mission.AFMovieFirePoints, GetPosition(unit))
		end
	end
end

function luaJM1CheckObjectives()
	if Mission.HenryKilledByPlayer and not Mission.HenryDlg then
		--luaJM1StartDialog("Henry",true)
		luaJM1ShowHintorDlg("Henry",0)
		--luaJM1AddPowerup("full_throttle")
		--Mission.HenryKilledByPlayer = nil
		Mission.HenryDlg = true
	end

	if not luaObj_IsActive("marker2",1) then
		luaObj_Add("marker2",1)
	end

	if not Mission.Achievment1Added and Mission.HenryKilledByPlayer and Mission.DonaldKilledByPlayer then
		SetAchievements("SA_PM")
		Mission.Achievment1Added = true
	end

	if not Mission.Achievement2Added then

		local alldead = true
		for idx,unit in pairs(Mission.HiddenPlanes) do
			if unit.Dead then
				Mission.HiddenPlanesDeads[idx] = true
			else
				alldead = false
			end
		end

		if alldead and table.getn(luaRemoveDeadsFromTable(Mission.Phase1Targets)) == 0 then
			SetAchievements("MA_SA")
			Mission.Achievement2Added = true
		end
	end

	if Mission.MissionPhase == 1 then

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			luaJM1GetPhase1targets()
			--luaJM1AddTimer()
			for idx,unit in pairs(Mission.Phase1Targets) do
				--luaLog("Adding unit "..unit.Name.." to obj pri 1")
				luaObj_AddUnit("primary",1,unit)
			end
			luaObj_AddReminder("primary",1)
			luaJM1HenryInit()
			luaDelay(luaJM1Pri1Score,3)
			--luaLog("Obj1 Added")
		else
			--if Mission.Timer then
			luaJM1CheckProx()
			--end
			Mission.Phase1Targets = luaJM1CheckPhase1Targets()
			if table.getn(Mission.Phase1Targets) == 0 and luaObj_GetSuccess("primary",1) == nil then
				--luaLog("Obj1 completed")
				luaObj_Completed("primary",1,true)
				luaJM1RemoveScore(1)
				--luaJM1AirfieldMovie()
			elseif table.getn(Mission.Phase1Targets) > 0 and luaObj_GetSuccess("primary",1) == nil then
				luaObj_Reminder("primary",1)
				--luaLog("Obj1 remind")
				luaJM1Pri1Score()
			end
		end

		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) ~= nil then
			if not luaObj_IsActive("primary",5) then
				if not Mission.MicrotutDlg then
					luaJM1ShowHintorDlg("1st_Success",0)
					Mission.MicrotutDlg = true
				end
			else
				if luaObj_GetSuccess("primary",5) == nil then
					local unit = GetSelectedUnit()
					if unit and not unit.Dead and GetProperty(unit, "unitcommand") == "retreat" then
						luaObj_Completed("primary",5)
						luaJM1RemoveScore(5)
						--Blackout(true, "luaJM1Checkpoint1", 1)
						luaDelay(luaJM1AirfieldMovieInit, 3)
					else
						luaObj_Reminder("primary",5)
						if not IsHintActive("IJN01_Hint08") then
							luaJM1OrdersHint()
						end
					end
				end
			end
		end

	elseif Mission.MissionPhase == 2 then

		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			luaObj_AddUnit("primary",2,Mission.Nevada)
			luaObj_AddReminder("primary",2)
			luaDelay(luaJM1Pri2Score,3)
			--luaLog("Obj2 add")
			luaJM1NevadaMovie()
		else
			if Mission.NevadaBeaching and luaObj_GetSuccess("primary",2) == nil then
				luaObj_Completed("primary",2,true)
				luaJM1RemoveScore(2)
				luaJM1NevadaGoMovie()
				--luaLog("Obj2 complete")
			elseif not Mission.NevadaBeaching and luaObj_GetSuccess("primary",2) == nil then
				luaObj_Reminder("primary",2)
				--luaLog("Obj2 remind")
				luaJM1Pri2Score()
			end
		end

		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		end

	elseif Mission.MissionPhase == 3 then

		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
			luaObj_AddUnit("primary",3,Mission.Virginia)
			luaObj_AddReminder("primary",3)
			luaDelay(luaJM1Pri3Score,3)
			--luaLog("Obj3 add")
			luaJM1VirginiaMovie()
		else
			if not Mission.PlayerUnit.Dead then
				if Mission.VirginiaSunken and luaObj_GetSuccess("primary",3) == nil then
					luaObj_Completed("primary",3,true)
					luaJM1StartDialog("Virginia_success")
					--luaJM1ShowHintorDlg("Virginia_success",0)
					luaJM1RemoveScore(3)
					--luaJM1VirginiaMovieInit()
					--Blackout(true, "luaJM1Checkpoint2", 1)
					luaJM1VirginiaDeadMovie()
					--luaLog("Obj3 complete")
				elseif not Mission.VirginiaSunken and luaObj_GetSuccess("primary",3) == nil then
					luaObj_Reminder("primary",3)
					luaJM1Pri3Score()
					--luaLog("Obj3 remind")
				end
			end
		end

		if not luaObj_IsActive("secondary",1) then
			luaObj_Add("secondary",1)
			if not Mission.Monaghan.Dead then
				luaObj_AddUnit("secondary",1,Mission.Monaghan)
			else
				luaObj_Completed("secondary",1)
			end
		end

	elseif Mission.MissionPhase == 4 then

		--if not luaObj_IsActive("primary",4) then
		--	luaObj_Add("primary",4)
			--luaJM1StartEndTimer()
		--	luaObj_AddReminder("primary",4)
		--	luaDelay(luaJM1DonaldInit,30)
		--else

		if not luaObj_IsActive("primary",4) then
			luaObj_Add("primary",4)
			luaJM1FighterListener()
			luaDelay(luaJM1DonaldInit,30)
			luaDelay(luaJM1Sec1Score,3)
		else
			if luaObj_GetSuccess("primary",4) == nil then
				if Mission.ShootedDownPlanes == 5 then
					luaJM1RemoveScore(4)
					luaObj_Completed("primary",4)
					MissionNarrative("ijn01.obj_s1_compl")
					--luaJM1AddPowerup("evasive_manoeuvre")
					luaJM1RadioMsg13()
				elseif Mission.ShootedDownPlanes < 5 then
					luaJM1Sec1Score()
					if not Mission.MicroTut then
						luaJM1ShowHintorDlg("Advanced_Hint_Cameralock",1)
						Mission.MicroTut = true
					end
				end
			end
		end

		if Mission.Donald and Mission.DonaldKilledByPlayer then
			--luaJM1StartDialog("Donald",true)
			if not Mission.DonaldPowerupAdded then
				luaJM1ShowHintorDlg("Donald",0)
				--luaJM1AddPowerup("improved_shells")
				Mission.DonaldPowerupAdded = true
			end
		end

		if Mission.Phase4End then

			--local activeSquads1, _dummy = luaGetSlotsAndSquads(Mission.Airfields[1])
			--local activeSquads2, _dummy = luaGetSlotsAndSquads(Mission.Airfields[2])

			--if activeSquads1 <= 3 and activeSquads2 <= 3 then
				--lualog("No more fighters")

				if luaObj_GetSuccess("secondary",1) == nil then
					luaObj_Failed("secondary",1,nil,true)
				end

				--SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
				PilotMoveToRange(Mission.PlayerUnit, Mission.Airfields[1])

				--luaObj_Completed("primary",4)
				luaDelay(luaJM1MissionCompleted, 5)
				luaJM1StepPhase()
				--else
				--	luaObj_Reminder("primary",4)
			--end

			--else
			--	luaObj_Reminder("primary",4)
		end

			--[[
			if not Mission.PlayerUnit.Dead then

				luaJM1StartDialog("Mission_end",true)

				local cmd = GetProperty(Mission.PlayerUnit, "unitcommand")
				if cmd == "retreat" or Mission.MissionEnd then

					if Mission.EndTimer then
						CountdownCancel()
					end

					if luaObj_GetSuccess("secondary",1) == nil then
						luaObj_Failed("secondary",1)
					end

					SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
					PilotMoveToRange(Mission.PlayerUnit, Mission.Airfields[1])

					luaObj_Completed("primary",4)
					luaDelay(luaJM1MissionCompleted, 15)
					luaJM1StepPhase()
				else
					luaObj_Reminder("primary",4)
				end
			end
			]]
		--end

	elseif Mission.MissionPhase == 99 then

		if Mission.MissionFailed then
			local endEnt
			if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
				endEnt = Mission.PlayerUnit
			else
				endEnt = Mission.Airfields[1]
			end
			luaMissionFailedNew(endEnt, Mission.FailMsg)
			luaJM1StepPhase()
		end

	end
end

function luaJM1AirfieldMovieInit()
	luaJM1ShowHintorDlg("MicrotutDone",0)
	luaJM1AirfieldMovie()
end

function luaJM1AddMicrotutObj()
	if not luaObj_IsActive("primary",5) then
		luaObj_Add("primary",5)
		luaObj_AddReminder("primary",5)
		luaJM1DisplayScore(5,"ijn01.obj_p5","")
		luaJM1OrdersHint()
	end
end

function luaJM1MissionCompleted()
	if not Mission.PlayerUnit.Dead then
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
		luaMissionCompletedNew(Mission.PlayerUnit, Mission.CompleteMsg)
	else
		luaMissionCompletedNew(FindEntity("Control Tower, 02 01"), Mission.CompleteMsg)
	end
end

function luaJM1GeneratePTTrafic()
	Mission.Phase1PTs = {}
	local PTNames = {
		[1] = "PT-20",
		[2] = "PT-21",
		[3] = "PT-22",
		[4] = "PT-24",
		[5] = "PT-25",
	}
	local paths = {FindEntity("pt_path1"),FindEntity("pt_path2"),FindEntity("pt_path3"),FindEntity("pt_path4")}
	for idx,path in pairs(paths) do
		local pathTbl = FillPathPoints(path)
		local unit = GenerateObject("PT", PTNames[idx])
		luaJM1AnnounceSpawn(unit.Name)
		if idx > 1 and idx < 4 then
			PutTo(unit, pathTbl[1])
			NavigatorMoveOnPath(unit, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
		else
			PutTo(unit, pathTbl[table.getn(pathTbl)])
			NavigatorMoveOnPath(unit, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
		end
		table.insert(Mission.Phase1PTs, unit)
	end
end

function luaJM1AddSwapListener()
	--luaLog("luaJM1AddSwapListener called")
	Mission.SwapListener = true
	--luaDelaySet("StopMessages", true, 5)
	Mission.StopMessages = false
	AddListener("input", "swap", {
		["callback"] = "luaJM1SwapChange",
		["inputID"] = {IC_MAP_TOGGLE},
	})
	luaDelay(luaJM1ResetSwapListener,15)
end

function luaJM1SwapChange(inputID, inputValue)
	--luaLog("luaJM1SwapChange called")
	RemoveListener("input","swap")
	Mission.SwapListener = false
	--luaLog("Removing listener")

	if IsHintActive("IJN01_Hint03") then
		HideHint()
	end

	if inputID == IC_MAP_TOGGLE then
		--MissionNarrativeEnqueue("ijn01.hint_swapsticks")
		local stickReverse, invertCameraY, invertPlaneY = GetInputModifiers()
		SetInputModifiers(luaJM1SwapCtrl(stickReverse), invertCameraY, invertPlaneY)
	--else
		--MissionNarrativeEnqueue("WTF")
	end
end

function luaJM1SwapCtrl(ctrl)
	if ctrl then
		return false
	else
		return true
	end
end

function luaJM1ResetSwapListener()
	--luaLog("luaJM1ResetSwapListener called")
	if Mission.SwapListener then
		RemoveListener("input","swap")
	end
	if IsHintActive("IJN01_Hint03") then
		HideHint()
	end
end

function luaJM1StepPhase(phase)
	if phase then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM1StartMsg()
	--EnableInput(false)
	--Blackout(true,"",true)
	--MissionNarrative("Ford Island, Pearl Harbor, 07-Dec-1941")
  --luaDelay(luaJM1StartMsgClb, 5)
end

--function luaJM1StartMsgClb()
--	SoundFade(1, "",0.5)
--	Blackout(false, "", 5)
--  EnableInput(true)
--end

function luaJM1FadeOut()
	--luaLog(debug.traceback())
	--lualog("luaJM1FadeOut called")
	Blackout(true, "", 1.5)
	--SoundFade(0,"", 0.5)

	EnableInput(false)
	luaDelay(luaJM1ClearPlayerUnit, 2)
	luaJM1StepPhase()
end

function luaJM1FadeIn()
	--luaLog("luaJM1FadeIn called")
	--luaLog(debug.traceback())
	EnableInput(true)
	--SoundFade(1, "", 0.5)
	if Mission.MissionPhase == 1 then

	elseif Mission.MissionPhase == 2 then
		luaJM1SpawnPhase2PlayerUnit()
		if not Mission.P2InitDlg then
			--luaJM1StartDialog("Intro_Diver",true)
			luaJM1ReleaseHint()
			luaJM1ShowHintorDlg("Intro_Diver",0)
			luaDelay(luaJM1DiverDlg,10)
			Mission.P2InitDlg = true
		end
	elseif Mission.MissionPhase == 3 then
		luaJM1SpawnPhase3PlayerUnit()
		if not Mission.P3InitDlg then
			--luaJM1StartDialog("Intro_torper",true)
			luaJM1TorpHint()
			luaJM1ShowHintorDlg("Intro_torper",0)
			luaDelay(luaJM1TorperDlg,10)
			Mission.P3InitDlg = true
		end
	elseif Mission.MissionPhase == 4 then
		luaJM1SpawnPhase1PlayerUnit()
		if not Mission.P4InitDlg then
			--luaJM1StartDialog("Back_to_fighter",true)
			luaJM1ShowHintorDlg("Back_to_fighter",0)
			luaDelay(luaJM1TargetHint, 10)
			luaDelay(luaJM1RadioMsg9, 15)
			luaDelay(luaJM1ReminderDlg5,10)
			Mission.P4InitDlg = true
		end
	end
	Blackout(false, "", 1)
  EnableInput(true)
  Mission.StopMessages = false
end

function luaJM1Phase2Spawns()
	--luaLog("luaJM1Phase2Spawns called")

	local paths = {FindEntity("dive_attackpath1"), FindEntity("dive_attackpath2"), FindEntity("dive_attackpath3")}

	for idx,path in pairs(paths) do
		local pathTbl = FillPathPoints(path)
		local unit = GenerateObject("PlayerVal 01", "globals.unitclass_val")
		luaJM1AnnounceSpawn(unit.Name)
		PutTo(unit, pathTbl[1])
		unit.bombOn = pathTbl[table.getn(pathTbl)]
		table.insert(Mission.Phase2Vals, unit)
		PilotMoveOnPath(unit, path)
		SquadronSetTravelAlt(unit, 200)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--sok ez igy egyszerre
		return
	end
end

function luaJM1SpawnPhase2PlayerUnit()
	luaJM1RestrictPlayer()
	local rnd = random(1,3)

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		Mission.UnitToKill = Mission.PlayerUnit
	end

	Mission.PlayerUnit = GenerateObject("PlayerVal 0"..tostring(rnd), "globals.unitclass_val")
	luaJM1AnnounceSpawn(Mission.PlayerUnit.Name)
	luaJM1JumpToUnit(Mission.PlayerUnit)
	PilotMoveToRange(Mission.PlayerUnit, Mission.Nevada)
	SquadronSetTravelAlt(Mission.PlayerUnit, 410)
	SquadronSetAttackAlt(Mission.PlayerUnit, 410)

	if Mission.Difficulty == 0 then
		AddUntouchableUnit(Mission.PlayerUnit)
	end

	--AI units

	local unit1 = GenerateObject("AIVal 0"..tostring(rnd).."_1", "globals.unitclass_val")
	luaJM1AnnounceSpawn(unit1.Name)
	local pos1 = GetPosition(unit1)
	local unit2 = GenerateObject("AIVal 0"..tostring(rnd).."_2", "globals.unitclass_val")
	luaJM1AnnounceSpawn(unit2.Name)
	local pos2 = GetPosition(unit2)
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)


	if not Mission.Nevada.Dead then
		PilotSetTarget(Mission.PlayerUnit, Mission.Nevada)
	end


	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.MainShips))

	PilotSetTarget(unit1, trg)
	SquadronSetAttackAlt(unit1, pos1.y)
	SquadronSetTravelAlt(unit1, pos1.y)
	PilotSetTarget(unit2, trg)
	SquadronSetAttackAlt(unit2, pos2.y)
	SquadronSetTravelAlt(unit2, pos2.y)

	table.insert(Mission.AIVals, unit1)
	table.insert(Mission.AIVals, unit2)

	if Mission.FirstPhase2Unit == nil then
		luaJM1ShowHintorDlg("Advanced_Hint_Cameralock",1)
		luaDelay(luaJM1DiverHint, 10)
		--luaDelay(luaJM1ReleaseHint, 20)
		Mission.FirstPhase2Unit = true
	elseif Mission.FirstPhase2Unit then
		Mission.FirstPhase2Unit = false
	end
end

function luaJM1RestrictPlayer()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
	end
end

function luaJM1Phase3Spawns()

	local needToSpawn = {}
	for idx,path in pairs(Mission.Phase3Paths) do
		if path.refUnit == nil or path.refUnit.Dead then
			table.insert(needToSpawn, path)
		end
	end

	if table.getn(needToSpawn) > 0 then
		local path = luaPickRnd(needToSpawn)
		luaJM1Phase3KateSpawn(path)
	end
end

function luaJM1Phase3KateSpawn(path)
	local pathTbl = FillPathPoints(path)
	local unit = GenerateObject("PlayerKate 01", "globals.unitclass_kate")
	luaJM1AnnounceSpawn(unit.Name)
	PutTo(unit, pathTbl[1])
	unit.bombOn = pathTbl[table.getn(pathTbl)]
	table.insert(Mission.Phase3Kates, unit)
	path.refUnit = unit
	PilotMoveOnPath(unit, path)
	SquadronSetTravelAlt(unit, 75)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
end

function luaJM1SpawnPhase3PlayerUnit()
	--luaLog("luaJM1SpawnPhase3PlayerUnit")
	--luaLog(debug.traceback())
	--luaLog("\n")
	luaJM1RestrictPlayer()
	local rnd = random(1,3)

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		--luaLog("Killing unit "..Mission.PlayerUnit.Name)
		Mission.UnitToKill = Mission.PlayerUnit
	end

	Mission.PlayerUnit = GenerateObject("PlayerKate 0"..tostring(rnd), "globals.unitclass_kate")
	luaJM1AnnounceSpawn(Mission.PlayerUnit.Name)
	--SetSelectedUnit(Mission.PlayerUnit)
	luaJM1JumpToUnit(Mission.PlayerUnit)
	PilotMoveToRange(Mission.PlayerUnit, Mission.Virginia)
	SquadronSetTravelAlt(Mission.PlayerUnit, 230)

	if Mission.Difficulty == 0 then
		AddUntouchableUnit(Mission.PlayerUnit)
	end

	--AI units

	local unit1 = GenerateObject("AIKate 0"..tostring(rnd).."_1", "globals.unitclass_kate")
	luaJM1AnnounceSpawn(unit1.Name)
	local pos1 = GetPosition(unit1)
	local unit2 = GenerateObject("AIKate 0"..tostring(rnd).."_2", "globals.unitclass_kate")
	luaJM1AnnounceSpawn(unit2.Name)
	local pos2 = GetPosition(unit2)
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)

	if not Mission.Virginia.Dead then
		--backlog req:
		PilotSetTarget(Mission.PlayerUnit, Mission.Virginia)
	end


	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.MainShips))
	PilotSetTarget(unit1, trg)
	SquadronSetTravelAlt(unit1, pos1.y)
	PilotSetTarget(unit2, trg)
	SquadronSetTravelAlt(unit2, pos2.y)

	table.insert(Mission.AIVals, unit1)
	table.insert(Mission.AIVals, unit2)


	--if Mission.FirstPhase3Unit == nil then
		--luaDelay(luaJM1TorpHint, 10)
		--Mission.FirstPhase3Unit = true
	--elseif Mission.FirstPhase3Unit then
	--	Mission.FirstPhase3Unit = false
	--end
end

function luaJM1CheckPlayerUnit()
	--if Mission.PlayerUnit then
-- RELEASE_LOGOFF  	--	luaLog("Playa")
-- RELEASE_LOGOFF  	--	luaLog(Mission.PlayerUnit.Dead)
-- RELEASE_LOGOFF  	--	luaLog(GetProperty(Mission.PlayerUnit, "unitcommand"))
	--end
	if Mission.MovieInit then
		--luaLog("Movie playing")
		return
	end

	if Mission.MissionPhase == 1 and Mission.PlayerUnit.Dead then
		if not Mission.StarfeFailedDlg then
			--luaJM1StartDialog("1st_fail",true)
			luaJM1ShowHintorDlg("1st_fail",0)
			Mission.StarfeFailedDlg = true
		end
		luaJM1SpawnPhase1PlayerUnit()
		--if Mission.Timer then
		--	CountdownCancel()
		--end
	elseif Mission.MissionPhase == 2 then
		if Mission.PlayerUnit.Dead or GetProperty(Mission.PlayerUnit, "unitcommand") == "retreat" then
			luaJM1SpawnPhase2PlayerUnit()
			if not Mission.BombFailedDlg and Mission.BombHitOnNevada == 0 and not Mission.FirstPhase2Unit then
				luaJM1ShowHintorDlg("Nevada_failed",0)
				Mission.BombFailedDlg = true
			end
		elseif not Mission.PlayerUnit.Dead and Mission.PlayerUnit.Class.Type == "DiveBomber" then
			--local ammo = GetProperty(Mission.PlayerUnit, "ammoType")
			--if ammo == 0 and not Mission.PlayerUnit.retHint then
			if GetPlaneIsReloading(Mission.PlayerUnit) and not Mission.PlayerUnit.retHint then
				--luaJM1OrdersHint()
				luaDelay(luaJM1RetreatHint,10)
				Mission.PlayerUnit.retHint = true
			end
		end
	elseif Mission.MissionPhase == 3 then
		if Mission.PlayerUnit.Dead or GetProperty(Mission.PlayerUnit, "unitcommand") == "retreat" then
			luaJM1SpawnPhase3PlayerUnit()
			if not Mission.TorpFailDlg and Mission.TorpHitOnVirginia == 0 and not Mission.FirstPhase2Unit then
			--luaJM1StartDialog("Virginia_fail",true)
			luaJM1ShowHintorDlg("Virginia_fail",0)
			end
		elseif not Mission.PlayerUnit.Dead and Mission.PlayerUnit.Class.Type == "TorpedoBomber" then
			--local ammo = GetProperty(Mission.PlayerUnit, "ammoType")
			--if ammo == 0 and not Mission.PlayerUnit.retHint then
			if GetPlaneIsReloading(Mission.PlayerUnit) and not Mission.PlayerUnit.retHint then
				luaJM1RetreatHint()
				Mission.PlayerUnit.retHint = true
			end
		end
	elseif Mission.MissionPhase == 4 and Mission.PlayerUnit.Dead then
		luaJM1SpawnPhase1PlayerUnit()
	end
end

function luaJM1CheckZeros()
	Mission.Phase1Zeros = luaRemoveDeadsFromTable(Mission.Phase1Zeros)
	if table.getn(Mission.Phase1Zeros) < Mission.MaxZeros then
		if not SpawnNewIDIsRequested(Mission.ZeroSpawnReq) then
			luaJM1SpawnZero()
		end
	end
end

function luaJM1SpawnZero()
	local path = FillPathPoints(FindEntity("dive_attackpath1"))
	local spawnPoint = path[1]
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
			{
				["Type"] = 150,
				["Name"] = "A6M Zero",
				["Crew"] = 1,
				["Race"] = JAPANESE,
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
		["angleRange"] = { 2.4, 4 },
	},
	["callback"] = "luaJM1ZeroSpawned",
	["id"] = Mission.ZeroSpawnReq,
	})
end

function luaJM1ZeroSpawned(unit)
	table.insert(Mission.Phase1Zeros, unit)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	PilotMoveToRange(unit, Mission.Airfields[1])
end

function luaJM1AddHitListener()
	AddListener("hit", "bombhit", {
		["callback"] = "luaJM1NevadaHit", -- callback fuggveny
		["target"] = {Mission.Nevada}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.NevadaListenerActive = true
end

function luaJM1NevadaHit()
	Mission.BombHitOnNevada = Mission.BombHitOnNevada + 1
	if Mission.BombHitOnNevada == 1 then
		luaJM1ShowHintorDlg("Nevada_hit1",0)
	end
	if Mission.BombHitOnNevada >= 2 then
		luaJM1ShowHintorDlg("Nevada_beach",0)
		if Mission.NevadaListenerActive then
			RemoveListener("hit", "bombhit")
			Mission.NevadaListenerActive = false
			luaJM1KillNevada()
		end
	end
end

function luaJM1AddHitListener3()
	AddListener("hit", "bombhit3", {
		["callback"] = "luaJM1ArizonaHit", -- callback fuggveny
		["target"] = {Mission.Arizona}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB", "TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.ArizonaListener = true
	Mission.ArizonaHit = 0
end

function luaJM1ArizonaHit()

	if not Mission.ArizonaHit then
		Mission.ArizonaHit = 1
	else
		Mission.ArizonaHit = Mission.ArizonaHit + 1
	end

	if Mission.ArizonaHit >= 8 then

		RemoveListener("hit", "bombhit3")
		Mission.ArizonaListener = false

		if not Mission.Vestal.Dead then
			luaJM1ShowHintorDlg("Arizona_Hit",0)
		end

		SetDamagedGFXLevel(Mission.Arizona, 1)
		--ExplodeToParts(Mission.Arizona)
		DisablePhysics(Mission.Arizona)
		AddMatrixInterpolator(Mission.Arizona, {["x"]=0, ["y"]=-15, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(-5)}, 30)
		luaDelay(luaJM1RadioMsg7, 11)
		table.insert(Mission.CapsizedShips, Mission.Arizona.Name)
	end
end

function luaJM1KillNevada()
	--MissionNarrativeEnqueue("Bombhit")
	Effect("ExplosionBigShip", GetPosition(Mission.Nevada))
	Effect("SmallFire", ORIGO, Mission.Nevada)
	AddDamage(Mission.Nevada, 8000)
	NavigatorMoveOnPath(Mission.Nevada, FindEntity("nevada_beaching"))
	local pathTbl = FillPathPoints(FindEntity("nevada_beaching"))
	Mission.Nevada.LastPoint = pathTbl[table.getn(pathTbl)]
	--luaJM1StartDialog("Nevada_beach",true)
	luaJM1ShowHintorDlg("Nevada_explodes",0)
	luaDelay(luaJM1RadioMsg5, 10)
	--luaJM1RollStageShips()
	Mission.NevadaBeaching = true
end

function luaJM1CheckNevada()
	if Mission.Nevada.Dead or not Mission.NevadaBeaching or Mission.NevadaBeachFinished then
		return
	end
	if luaGetDistance(Mission.Nevada, Mission.Nevada.LastPoint) < 300 then
		--luaJM1StartDialog("Nevada_beached",true)
		luaJM1ShowHintorDlg("Nevada_beached",0)
		Mission.NevadaBeachFinished = true
	end
end

function luaJM1AddHitListener2()
	AddListener("hit", "torphit", {
		["callback"] = "luaJM1VirginiaHit", -- callback fuggveny
		["target"] = {Mission.Virginia}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.VirginiaListenerActive = true
end

function luaJM1VirginiaHit()
	Mission.TorpHitOnVirginia = Mission.TorpHitOnVirginia + 1

	if Mission.TorpHitOnVirginia == 1 and not Mission.VirginiaDlg1 then
		--luaJM1StartDialog("Virginia_hit1",true)
		luaJM1ShowHintorDlg("Virginia_hit1",0)
		Mission.VirginiaDlg1 = true
	end

	if Mission.TorpHitOnVirginia >= 2 then
		--luaJM1StartDialog("Virginia_hit2",true)
		--luaJM1ShowHintorDlg("Virginia_hit2",0)
		if Mission.VirginiaListenerActive then
			RemoveListener("hit", "torphit")
			Mission.VirginiaListenerActive = false
			luaJM1KillVirginia()
		end
	end
end

function luaJM1KillVirginia()
	--MissionNarrativeEnqueue("Torphit")
	Effect("ExplosionBigShip", GetPosition(Mission.Virginia))
	Effect("SmallFire", ORIGO, Mission.Virginia)
	Mission.VirginiaSunken = true
	--luaJM1StartDialog("WV_dead",true)
	luaJM1ShowHintorDlg("WV_dead",0)
end

function luaJM1SetShipsInvincible(ratio)
	for idx,unit in pairs(Mission.MainShips) do
		if ratio == nil then
			--luaLog("Setting invincible "..unit.Name.." without ratio")
			SetInvincible(unit, 1)
		else
			SetInvincible(unit, ratio)
			--luaLog("Setting invincible "..unit.Name.." with ratio "..tostring(ratio))
		end
	end
end

function luaJM1CheckStageVals()
	Mission.Phase2Vals = luaRemoveDeadsFromTable(Mission.Phase2Vals)

	if table.getn(Mission.Phase2Vals) <= 3 then
		luaJM1Phase2Spawns()
	end

	for idx,unit in pairs(Mission.Phase2Vals) do
		local cmd = GetProperty(unit, "unitcommand")
		local ammo = GetProperty(unit, "ammotype")
		if ammo ~= 0 and cmd ~= "bomb" and luaGetDistance(unit, unit.bombOn) < 350 then
			luaJM1GetTarget(unit)
		elseif ammo == 0 and cmd ~= "retreat" then
			PilotRetreat(unit)
		elseif cmd == "retreat" then
			if Mission.PlayerUnit.Dead or luaGetDistance(Mission.PlayerUnit, unit) > 2000 then
				Kill(unit,true)
			end
		end
	end
end

function luaJM1CheckStageKates()
	Mission.Phase3Kates = luaRemoveDeadsFromTable(Mission.Phase3Kates)

	if table.getn(Mission.Phase3Kates) <= 3 then
		luaJM1Phase3Spawns()
	end

	for idx,unit in pairs(Mission.Phase3Kates) do
		local cmd = GetProperty(unit, "unitcommand")
		local ammo = GetProperty(unit, "ammotype")
		if ammo ~= 0 and cmd ~= "torpedo" and luaGetDistance(unit, unit.bombOn) < 350 then
			luaJM1GetTarget(unit)
		elseif ammo == 0 and cmd ~= "retreat" then
			PilotRetreat(unit)
		elseif cmd == "retreat" then
			if Mission.PlayerUnit.Dead or luaGetDistance(Mission.PlayerUnit, unit) > 2000 then
				Kill(unit,true)
			end
		end
	end
end

function luaJM1GetTarget(unit)
	if unit.Dead then
		return
	end

	local target

	if unit.Class.Type == "DiveBomber" then

		if Mission.MissionPhase >= 2 then
			if not Mission.RadioStation.Dead then
				table.insert(Mission.MainShips, Mission.RadioStation)
			end
		end
		if Mission.MissionPhase >= 3 then
			if not Mission.Utah.Dead then
				table.insert(Mission.MainShips, Mission.Utah)
			end
			if not Mission.Oklahoma.Dead then
				table.insert(Mission.MainShips, Mission.Oklahoma)
			end
		end

		local dist = 1000000
		local dist2
		for idx,ship in pairs(Mission.MainShips) do
			if not ship.Dead then
				dist2 = luaGetDistance(unit, ship)
				if dist2 < dist then
					dist = dist2
					target = ship
				end
			end
		end

	else

		local dist = 1000000
		local dist2
		for idx,ship in pairs(Mission.MainShips) do
			if not ship.Dead then
				dist2 = luaGetDistance(unit, ship)
				if dist2 < dist then
					dist = dist2
					target = ship
				end
			end
		end

	end
	PilotSetTarget(unit, target)
end

function luaJM1RollStageShips()
	local unit = FindEntity("Oklahoma")
	--AddMatrixInterpolator(unit, {["x"]=0, ["y"]=-4, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(25),}, 30)

	--AddMatrixInterpolator(Mission.Utah, {["x"]=0, ["y"]=-8, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(30),}, 25)
end

function luaJM1FMInit(this)
	--luaLog("FM called")
	SetThink(this, "luaJM1FM_think")
end

function luaJM1FM_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		--luaLog("FM_think killed")
		return
	end

	local squads = {}

	if Mission.MissionPhase == 2 then
		squads = luaRemoveDeadsFromTable(Mission.Phase2Vals)
	elseif Mission.MissionPhase == 3 then
		squads = luaRemoveDeadsFromTable(Mission.Phase3Kates)
	elseif Mission.MissionPhase == 4 then
		squads = luaRemoveDeadsFromTable(Mission.Phase1Zeros)
	end

	if next(squads) == nil then
		--luaLog("no planes inside")
		return
	end


	local rndPick = random(1, table.getn(squads))
	local v1 = squads[rndPick]
	table.remove(squads, rndPick)

	local rndPick = random(1, table.getn(squads))
	local v2 = squads[rndPick]
	table.remove(squads, rndPick)

	local numFlaks1 = random(4,10)
	local numFlaks2 = random(2,5)
	local numFlaks3 = random(2,5)

	if not Mission.PlayerUnit.Dead then
		for i=1,numFlaks1 do
			local rndDelay = random(10,100)/10
			local pos = GetPosition(Mission.PlayerUnit)
			local dir = GetDirection(Mission.PlayerUnit)
			local flakpos = luaJM1GetFlakPos(pos,dir)

			--luaLog("rnd delay 1 "..tostring(rndDelay))

			if pos.y > 5 then
				luaDelay(luaJM1DelayedEffect, rndDelay, "Effect", "Impact5InchFlak", "Pos", flakpos)
			end
		end
	end

	if v1 and not v1.Dead then
		for i=1,numFlaks2 do
			local rndDelay = random(10,400)/10
			local pos = GetPosition(v1)
			local dir = GetDirection(v1)
			local flakpos = luaJM1GetFlakPos(pos,dir)

			--luaLog("rnd delay 2 "..tostring(rndDelay))

			if pos.y > 5 then
				luaDelay(luaJM1DelayedEffect, rndDelay, "Effect", "Impact5InchFlak", "Pos", flakpos)
			end
		end
	end

	if v2 and not v2.Dead then
		for i=1,numFlaks3 do
			local rndDelay = random(10,400)/10
			local pos = GetPosition(v2)
			local dir = GetDirection(v2)
			local flakpos = luaJM1GetFlakPos(pos,dir)

			--luaLog("rnd delay 3 "..tostring(rndDelay))

			if pos.y > 5 then
				luaDelay(luaJM1DelayedEffect, rndDelay, "Effect", "Impact5InchFlak", "Pos", flakpos)
			end
		end
	end

	SetWait(this, random(10,30)/10)
end

function luaJM1DelayedEffect(timerthis)
	local fx = timerthis.ParamTable.Effect
	local pos = timerthis.ParamTable.Pos

	--luaLog("generating flak effect")

	Effect(fx, pos)
end

function luaJM1GetFlakPos(unitpos,direction)

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

	local rx = random(-75,75)
	pos.x = pos.x + rx * dirside.x
	pos.y = pos.y + rx * dirside.y
	pos.z = pos.z + rx * dirside.z

	local ry = random(-35,35)
	pos.x = pos.x + ry * dirup.x
	pos.y = pos.y + ry * dirup.y
	pos.z = pos.z + ry * dirup.z

	return pos
end

function luaJM1SmokeInit(this)
	--luaLog("Smoke init called")
	SetThink(this, "luaJM1Smoke_think")
end

function luaJM1Smoke_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		--luaLog("Smoke_think killed")
		return
	end

	local smokes = 0
	local smokeEfx = {}
	for idx,smoke in pairs(Mission.SmokePoints) do
		if smoke.effectin then
			--smokes = smokes + 1
			--luaLog("smokes "..tostring(smokes))
			table.insert(smokeEfx, smoke)
		end
	end

	if table.getn(smokeEfx) > 4 then
		local killefx = luaPickRnd(smokeEfx)
		--luaLog("Destroying smoke on point "..tostring(killefx.Name))

		if killefx.BigSmoke then
			Mission.BigSmoke = false
			killefx.BigSmoke = false
		end

		StopEffect(killefx.effect.Pointer)
		killefx.effect = nil
		killefx.effectin = false

		Mission.SmokeSpawnOk = false
		luaDelaySet("SmokeSpawnOk", true, 20)
		return
	end

	if Mission.SmokeSpawnOk then
		luaJM1SpawnSmoke()
	end
end

function luaJM1SpawnSmoke()
	local points = {}
	for idx,point in pairs(Mission.SmokePoints) do
		if not point.effectin then
			table.insert(points, point)
		end
	end

	local spawnpoint = luaPickRnd(points)
	--local efxName = {"GiantSmoke","RealGiantSmoke","MoreRealGiantSmoke"}
	local efxName = {"SmallSmoke", "EnvironmentSmoke"}
	--local efx = Effect(luaPickRnd(efxName), GetPosition(spawnpoint))
	local efx

	if not Mission.BigSmoke then
		efx = Effect(efxName[2], GetPosition(spawnpoint))
		Mission.BigSmoke = true
		spawnpoint.BigSmoke = true
	else
		efx = Effect(efxName[1], GetPosition(spawnpoint))
	end

	spawnpoint.effect = efx
	spawnpoint.effectin = true
end


function luaJM1FireInit(this)
	--luaLog("Fire init called")
	SetThink(this, "luaJM1Fire_think")
end

function luaJM1Fire_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		--luaLog("Fire_think killed")
		return
	end

	local fires = 0
	local fireEfx = {}
	for idx,fire in pairs(Mission.FirePoints) do
		if fire.effectin then
			fires = fires + 1
			--luaLog("fires "..tostring(fires))
			table.insert(fireEfx, fire)
		end
	end

	if table.getn(fireEfx) > 4 then
		local killefx = luaPickRnd(fireEfx)

		if killefx.BigFire then
			Mission.BigFire = false
		end

		StopEffect(killefx.effect.Pointer)
		killefx.effect = nil
		killefx.effectin = false
		Mission.FireSpawnOk = false
		luaDelaySet("FireSpawnOk", true, 20)
		return
	end

	if Mission.FireSpawnOk then
		luaJM1SpawnFire()
	end
end

function luaJM1SpawnFire()
	local points = {}
	for idx,point in pairs(Mission.FirePoints) do
		if not point.effectin then
			table.insert(points, point)
		end
	end

	local spawnpoint = luaPickRnd(points)
	--luaLog("Spawning fire on point "..tostring(spawnpoint.Name))

	local efx

	if not Mission.BigFire then
		efx = Effect("BigFire", GetPosition(spawnpoint))
		efx.BigFire = true
		Mission.BigFire = true
	else
		efx = Effect("SmallFire", GetPosition(spawnpoint))
	end


	spawnpoint.effect = efx
	spawnpoint.effectin = true
end

function luaJM1RAD(x)
	return x *  0.0174532925
end

function luaJM1InitStageShips()
	Mission.MainShips = {}
		table.insert(Mission.MainShips, FindEntity("California"))
		table.insert(Mission.MainShips, FindEntity("Nevada"))
		table.insert(Mission.MainShips, FindEntity("Maryland"))
		table.insert(Mission.MainShips, FindEntity("Oklahoma"))
		table.insert(Mission.MainShips, FindEntity("Tennessee"))
		table.insert(Mission.MainShips, FindEntity("West Virginia"))
		table.insert(Mission.MainShips, FindEntity("Utah"))
		table.insert(Mission.MainShips, Mission.Arizona)


	for idx,unit in pairs(Mission.MainShips) do
		local width = unit.Class.Width - 20
		local height = unit.Class.Height
		local pos = GetPosition(unit)
		local dir = GetDirection(unit)
		local points = {}
			points[1] = {["x"] = (random(-2,2) * dir.x + pos.x), ["y"] = height, ["z"] = pos.z - 25 * dir.z}
			points[2] = {["x"] = (random(-2,2) * dir.x + pos.x), ["y"] = height, ["z"] = pos.z - 50 * dir.z}
			points[3] = {["x"] = (random(-2,2) * dir.x + pos.x), ["y"] = height, ["z"] = pos.z + 50 * dir.z}
			points[4] = {["x"] = (random(-2,2) * dir.x + pos.x), ["y"] = height, ["z"] = pos.z + 25 * dir.z}
		unit.points = points
	end
end

function luaJM1CheckStageShips()
	--luaLog("luaJM1CheckStageShips")
	if Mission.MissionPhase < 2 then
		return
	end
	for idx,unit in pairs(Mission.MainShips) do
		if unit.points and not unit.Capsized then

			if not unit.ID ~= Mission.California.ID then

				if unit.exploded and not unit.explodeflagreset then
					luaDelay(luaJM1ResetExplodeFlag, 15, "unit", unit)
					unit.explodeflagreset = true
				else
					for idx2,point in pairs(unit.points) do
						local rnd = random(1,100)
						--luaLog(rnd)
						if rnd >= 90 then
							local rnd2 = random(1000,3000)/1000
							--luaLog(rnd2)
							luaDelay(luaJM1SecExpl, rnd2, "pos", point)
							unit.exploded = true
-- RELEASE_LOGOFF  							luaLog("ship to explode "..unit.Name)
						end
					end
				end

			end

		elseif unit.Capsized and not unit.capsizeSmoke then
			Effect("SmallSmoke", ORIGO, unit)
			unit.capsizeSmoke = true
		end
	end
	local rnd3

	if Mission.MissionPhase > 3 then
		rnd3 = 	random(30,45)
	else
		rnd3 = random(15,25)
	end
	--luaLog(rnd3)
	luaDelay(luaJM1CheckStageShips, rnd3)
end

function luaJM1ResetExplodeFlag(timerthis)
	local unit = timerthis.ParamTable.unit
	if not unit or unit.Dead then
		return
	end

	unit.exploded = false
	unit.explodeflagreset = false
end

function luaJM1SecExpl(timerthis)
	local point = timerthis.ParamTable.pos
	Effect("ExplosionBigShip", point)
end

function luaJM1ClearPlayerUnit()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		Kill(Mission.PlayerUnit, true)
	end
end

function luaJM1HenryInit()
	Mission.Henry = GenerateObject("PT")
	luaJM1AnnounceSpawn(Mission.Henry.Name)
	SetGuiName(Mission.Henry, "ingame.shipnames_pt|.23")
	AddUntouchableUnit(Mission.Henry)
	SetShipMaxSpeed(Mission.Henry, 8)
	NavigatorMoveOnPath(Mission.Henry, FindEntity("henry_path"), PATH_FM_SIMPLE, PATH_SM_JOIN, 8)
	luaJM1HenryListener()
end

function luaJM1CheckHenry()
	if not Mission.Henry then
		return
		--luaLog("no Henry init yet")
	end
	if Mission.HenryKilledByPlayer ~= nil then
		return
	end

	if Mission.MissionPhase > 1 then
		if IsListenerActive("kill", "HenryListener") then
			RemoveListener("kill", "HenryListener")
		end
		if Mission.Henry and not Mission.Henry.Dead then
			Kill(Mission.Henry,true)
		end
		Mission.HenryKilledByPlayer = false
	end


	if not Mission.Henry.Dead then
		if luaGetDistance(Mission.Henry, Mission.PhoenixPos) < 300 then
			if GetDistFromCrosshair(Mission.Henry) > 1 then
				if IsListenerActive("kill", "HenryListener") then
					RemoveListener("kill", "HenryListener")
				end
				Kill(Mission.Henry,true)
				Mission.HenryKilledByPlayer = false
			end
		end
	end
end

function luaJM1DonaldInit()

	if Mission.DonaldInit then
		return
	end

	Mission.Donald = GenerateObject("Donald")
	luaJM1AnnounceSpawn(Mission.Donald.Name)
	SetGuiName(Mission.Donald, "ijn01.donald")
	luaJM1DonaldListener()
	AddUntouchableUnit(Mission.Donald)
	UnitFreeAttack(Mission.Donald)
	Mission.DonaldInit = true
end

--[[
function luaJM4AddProxTrigger(numPoint)
	local point = FindEntity("PlaneNavpoint 0"..tonumber(numPoint))
	if numPoint > 1 then
		local point2 = FindEntity("PlaneNavpoint 0"..tonumber(numPoint-1))
		--luaLog("remove")
		luaObj_RemoveUnit("primary",5,GetPosition(point2))
	end
	luaObj_AddUnit("primary",5,GetPosition(point))
	AddProximityTrigger(Mission.PlayerUnit, "proxTrigger", "luaJM1Navpoint", point, 1500)
end

function luaJM1Navpoint()
	Mission.PointsReached = Mission.PointsReached + 1
	--luaLog("reached "..tostring(Mission.PointsReached))
	if Mission.PointsReached < 4 then
		luaJM4AddProxTrigger(Mission.PointsReached)
	--else
		--luaObj_RemoveUnit("primary",5,GetPosition(FindEntity("PlaneNavpoint 04")))
	end
end
]]
function luaJM1AddTimer()
	Countdown("Time to fly in", 1, 120, "luaJM1TimesUp")
	Mission.Timer = true
end

function luaJM1TimesUp()
	Mission.MissionFailed = true
	Mission.FailMsg = "ijn01.obj_missionfailed"
	luaJM1StepPhase(99)
end

function luaJM1CheckProx()
	if not Mission.PlayerUnit.Dead then
		for idx,trg in pairs(luaRemoveDeadsFromTable(Mission.Phase1Targets)) do
			if luaGetDistance(Mission.PlayerUnit, trg) < 1000 then
				Mission.Inrange = true
				break
			end
		end
	end
	if not Mission.ZerosInrange then
		for idx,unit in pairs(Mission.Phase1Zeros) do
			if not unit.Dead and luaGetDistance(Mission.Airfields[1],unit) < 3000 then
				Mission.ZerosInrange = true
				luaJM1CheckPhase1Zeros()
			end
		end
	end
end

function luaJM1FadeInScene()
	--lualog("luaJM1FadeInScene called")
	luaCheckSavedCheckpoint()
--	SoundFade(1, "",0.1)
	Blackout(false, "", 0.5)

	if not Mission.CheckpointLoaded then
		luaDelay(luaJM1TurboHint,3)
		luaDelay(luaJM1CockpitHint, 25)
		luaDelay(luaJM1ShowBasicPlane2, 45)
		luaDelay(luaJM1HintHistory,65)
		if not PC or X360COMP then
			luaDelay(luaJM1SwapHint, 10)
		end
		luaDelay(luaJM1InitDlg,4)
	end
end

function luaJM1InitDlg()
	if not PC or X360COMP then
		Mission.StopMessages = true
	end
	luaJM1ShowHintorDlg("Intro_Fighter",0)
	luaDelay(luaJM1RadioMsg1,6)
	luaDelay(luaJM1ReminderDlg1, 30)
	luaDelay(luaJM1ReminderDlg2, 60)
end

function luaJM1ReminderDlg1()
	--luaJM1StartDialog("InRange",true)
	luaJM1ShowHintorDlg("InRange",0)
end

function luaJM1ReminderDlg2()
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		--luaJM1StartDialog("Grounded_reminder",true)
		luaJM1ShowHintorDlg("Grounded_reminder",0)
	end
end

function luaJM1DiverDlg()
	luaJM1ShowHintorDlg("Nevada_bomb",0)
	luaDelay(luaJM1ReminderDlg3,30)
end

function luaJM1TorperDlg()
	--luaJM1StartDialog("Torp_Virginia",true)
	luaJM1ShowHintorDlg("Torp_Virginia",0)
	luaDelay(luaJM1ReminderDlg4,30)
end

function luaJM1ReminderDlg4()
	if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil and (not Mission.TorpHitOnVirginia or Mission.TorpHitOnVirginia == 0) then
		--luaJM1StartDialog("Virginia_reminder",true)
		luaJM1ShowHintorDlg("Virginia_reminder",0)
	end
end

function luaJM1ReminderDlg5()
	--if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		--luaJM1StartDialog("Dogfight_reminer",true)
		luaJM1ShowHintorDlg("Dogfight_reminer",0)
	end
end

function luaJM1StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM3StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM3StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
		--lualog("Dialog started. ID: "..dialogID)
	end
end

function luaJM1AddPowerup(type)
	if not Mission.FirstPowerup then
		ForceEnableInput(IC_SM_SECONDARY, true)
		--luaJM1PowerupHint1()
		Mission.FirstPowerup = true
	end
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM1DonaldListener()
	if IsListenerActive("kill", "DonaldListener") then --checkpoint
		return
	end
	AddListener("kill", "DonaldListener", {
		["callback"] = "luaJM1DonaldDead",  -- callback fuggveny
		["entity"] = {Mission.Donald}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM1DonaldDead()
	RemoveListener("kill", "DonaldListener")
	Mission.DonaldKilledByPlayer = true
end

function luaJM1HenryListener()
	AddListener("kill", "HenryListener", {
		["callback"] = "luaJM1HenryDead",  -- callback fuggveny
		["entity"] = {Mission.Henry}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {Mission.PlayerUnit},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM1HenryDead()
	--luaLog("listener faszom")
	RemoveListener("kill", "HenryListener")
	Mission.HenryKilledByPlayer = true
end

function luaJM1FighterListener()

	if IsListenerActive("kill", "PlaneSquadronLost") then --checkpoint
		return
	end

	AddListener("kill", "PlaneSquadronLost", {
			["callback"] = "luaJM1PlaneSquadronLost",
			["entity"] = {},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {PLAYER_1}, -- [PLAYER_1..PLAYER_8]
	})
	Mission.FighterListener = true
end

function luaJM1PlaneSquadronLost(entity, lastAttacker, lastAttackerPlayerIndex)
	--luaLog("luaJM1PlaneSquadronLost called")

	--luaLog(entity.Name)
	--luaLog(lastAttacker.Name)
	--luaLog(lastAttackerPlayerIndex)
	--luaLog(entity.Class.Type)
	--luaLog(entity.Party)
	--luaLog(entity)

	if entity.Party == PARTY_ALLIED then
		if entity.Class.Type == "Fighter" and string.find(entity.Name, ".|") then--or string.find(entity.Name, "II") or string.find(entity.Name, "III")) then
			--local x = GetSquadronPlanes(entity)
			--luaLog(entity)

			Mission.ShootedDownPlanes = Mission.ShootedDownPlanes + 1
			--luaLog("squadron lost")
			--luaLog("ShootedDownPlanes "..tostring(Mission.ShootedDownPlanes))
			--luaLog("unit name "..entity.Name)
		end
		if Mission.ShootedDownPlanes == 5 then
			RemoveListener("kill", "PlaneSquadronLost")
		end
	end
end

function luaJM1RetreatHint()
	--MissionNarrativeUrgent("Press retreat in the Orders menu to get a new squad")
	ShowHint("IJN01_Hint01")
	--luaLog("Hint1 show")
end

function luaJM1TurboHint()
	--local str = "Use the <reft stick icon> to dive, climb and roll. Use up and down on the <right stick icon> to set your speed and left and right to control the rudder.	Hold down <turbo button icon> to temporarily boost your speed, this turbo boost takes time to recharge after use."
	--MissionNarrativeUrgent(str)
	--ShowHint("IJN01_Hint02")
	--luaLog("Hint2 show")
end

function luaJM1SwapHint()
	--local str = "HINT: If you're not feeling comfortable with the way the control sticks are set then press  <? button icon> to swap them now."
	--MissionNarrativeUrgent(str)
	ShowHintForced("IJN01_Hint03")
	luaJM1AddSwapListener()
end

function luaJM1CockpitHint()
	--local str = "HINT: Press <cockpit view button icon> to go in and out of cockpit view. Press and hold <Look around button icon> and then move the <Right stick icon> to look around."
	--MissionNarrativeUrgent(str)
	luaJM1ShowHintorDlg("IJN01_Hint04",1)
end

function luaJM1TargetHint()
	--local str = "HINT: Press <A button icon> to cycle between enemy targets. Press <A button icon> while your crosshair is over an enemy to make that enemy the active target."
	--MissionNarrativeUrgent(str)
	--luaJM1ShowHintorDlg("IJN01_Hint05",1)
end

function luaJM1DiverHint()
	--local str = "HINT: This is a divebomber, try to dive down on a target and get as close as you can before releasing your bomb."
	--MissionNarrativeUrgent(str)
	luaJM1ShowHintorDlg("IJN01_Hint06",1)
end

function luaJM1ReleaseHint()
	--local str = "HINT: If your plane is equipped with bombs press and hold <LT icon> to display the bombing reticule, press <RT icon> while in this view to release your bombs."
	--MissionNarrativeUrgent(str)
	luaJM1ShowHintorDlg("IJN01_Hint07",1)
end

function luaJM1OrdersHint()
	--local str = "HINT: Press and hold <X button icon> to bring up the orders menu, while holding X press the corresponding direction on the d-pad to give an order."
	--MissionNarrativeUrgent(str)
	luaJM1ShowHintorDlg("IJN01_Hint08",1)
end

function luaJM1TorpHint()
	--local str = "HINT: You are in a torpedo bomber. Torpedos must dropped below 100ft (the red line on your altimeter) or they will explode on impact."
	--MissionNarrativeUrgent(str)
	luaJM1ShowHintorDlg("IJN01_Hint09",1)
end

function luaJM1PowerupHint1()
	--local str = "HINT: You've earned a power-up, press and hold <RB icon> to access the power-up menu."
	--MissionNarrativeUrgent(str)
	--ShowHint("IJN01_Hint10")
	--luaLog("Hint10 show")
	luaJM1AddPowerupPanelListener()
end

function luaJM1PowerupHint2()
	--local str = "HINT: Select your power-up with the d-pad and press <A button icon> to use it."
	--MissionNarrativeUrgent(str)
	--luaJM1ShowHintorDlg("IJN01_Hint11",1)
end

function luaJM1HintHistory()
	luaJM1ShowHintorDlg("Advanced_Hint_Hinthistory",1)
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(162)
	PrepareClass(158)
	PrepareClass(135)
	PrepareClass(150)
	PrepareClass(274)
	--PrepareClass(354)
	--PrepareClass(355)
	--PrepareClass(356)
	PrepareClass(27)
	Loading_Finish()
end

function luaJM1JumpToUnit(unit)
	EnableInput(false)
	SetInvincible(unit, true)

	if luaGetMovieOption() then

		local length = unit.Class.Length
		local height = unit.Class.Height
		local width = unit.Class.Width

		local rndPos1 = {
			[1] = {width*2, 2, 0},
			[2] = {-width*2, 2, 0}
		}
		local rndPos2 = {
			[1] = {0, 2, -length},
			--[2] = {0, 2, length}
		}

		local campos1 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= unit.ID,
				["pos"] = luaPickRnd(rndPos1)
			},
			["transformtype"]="keepz",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=0.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
			["zoom"] = 0.8,
		}


		local campos2 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= unit.ID,
				["pos"] = luaPickRnd(rndPos2)
				},
			["transformtype"]="keepz",
			["starttime"]=0.0,
			["blendtime"]=3.0,
			["linearblend"]=0.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
			["zoom"] = 0.8,
		}

		local campos3 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= unit.ID,
				["modifier"] = {
						["name"] = "gamecamera",
					},
				},
			["transformtype"]="keepall",
			["starttime"]=3.0,
			["blendtime"]=3.0,
			["wanderer"]=false,
			["zoom"] = 1,
			["finishscript"] = "luaJM1SelectUnit",
		}

		MovCamNew_AddPosition(campos1)
		MovCamNew_AddPosition(campos2)
		MovCamNew_AddPosition(campos3)

	else

		luaJM1SelectUnitKills(unit)
		luaJM1SelectUnit()
		return

	end

	luaJM1SelectUnitKills(unit)
	EnableInput(true)
end

function luaJM1SelectUnitKills(x)

	--luaLog("luaJM1SelectUnitKills")
	--luaLog(debug.traceback())

	if Mission.UnitToKill and not Mission.UnitToKill.Dead then
		--luaLog("PY ID"..tostring(Mission.PlayerUnit.ID))
		--luaLog("UK ID"..tostring(Mission.UnitToKill.ID))
		Kill(Mission.UnitToKill, true)
	end

	Mission.AIVals = luaRemoveDeadsFromTable(Mission.AIVals)
	for idx,unit in pairs(Mission.AIVals) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end

	Mission.AIKates = luaRemoveDeadsFromTable(Mission.AIKates)
	for idx,unit in pairs(Mission.AIKates) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end

	Mission.MovieSelUnit = x
end

function luaJM1SelectUnit()
	--luaLog("unit to select")
	--luaLog(Mission.MovieSelUnit)
	if not Mission.MovieSelUnit.Dead then
		if IsUnitSelectable(Mission.MovieSelUnit) then
			SetInvincible(Mission.MovieSelUnit, false)
			SetSelectedUnit(Mission.MovieSelUnit)
			Mission.MovieSelUnit = nil
			Mission.StopMessages = false
		elseif IsUnitSelectable(Mission.MovieSelUnit) then
			luaDelay(luaJM1SelectUnit,1)
		end
	end
end

function luaJM1NevadaMovieFinish()
	--luaLog("luaJM1NevadaMovieFinish called")
	--luaDelay(luaJM1FadeOut,1)
	luaJM1FadeOut()
	--luaLog("delayed mozi utani cucc")
	--luaDelay(luaJM1SpawnPhase3PlayerUnit,3.5)
	--luaDelay(luaJM1Phase3Spawns,3)
	--luaDelay(luaJM1FadeIn,5.5)
	--Mission.MovieInit = false
end

function luaJM1VestalBoom()
	if not Mission.Vestal.Dead then
		Effect("ExplosionBigShip", GetPosition(Mission.Vestal))
	end
end

----virginiamovie
function luaJM1VirginiaMovieInit()
	Mission.MovieInit = true
	Mission.StopMessages = true
	EnableInput(false)
	Blackout(true, "", 1)
	luaDelay(luaJM1ClearPhase3Units, 1.5)
	Blackout(false, "", 2)
	luaDelay(luaJM1VirginiaMovie,2.5)
end

function luaJM1VirginiaMovieFinish()
	--luaLog("luaJM1VirginiaMovieFinish called")
	luaJM1FadeOut()
	luaDelay(luaJM1Checkpoint2, 1.5)
	luaDelay(luaJM1FadeIn,3.5)
	luaDelaySet("MovieInit", false, 4)
	--Blackout(true, "luaJM1Checkpoint2", 1)
end

function luaJM1Checkpoint2()
	luaCheckpoint(2,274)
	--Blackout(false, "", 1)
end

function luaJM1AFMovieFinish()
	--lualog("luaJM1AFMovieFinish called")
	--luaDelay(, 1)
	luaJM1FadeOut()
	--luaDelay(luaJM1AddBGSmoke, 2)
	luaDelay(luaJM1Checkpoint1, 1.5)
	luaDelay(luaJM1Phase2Spawns,2)
	--luaDelay(luaJM1FadeIn,5.5)
	luaDelay(luaJM1CheckStageShips, 5)
	luaDelay(luaJM1DestroyAFMovieEfx, 10)
	--Blackout(true, "luaJM1Checkpoint1", 1)
	--Mission.MovieInit = false
end

function luaJM1Checkpoint1()
	luaCheckpoint(1,nil)
	--Blackout(false, "", 1)
end


function luaJM1CheckPhase1Targets()

	if Mission.DestroyAFMovieEfx == nil then
		Mission.DestroyAFMovieEfx = {}
	end

	for idx,unit in pairs(Mission.Phase1Targets) do
		if unit.Dead then
			--table.remove(Mission.Phase1Targets, idx)
			if Mission.AFMovieFirePoints[idx] then
				local x = Effect("SmallFire",Mission.AFMovieFirePoints[idx])
				table.remove(Mission.AFMovieFirePoints, idx)
				table.insert(Mission.DestroyAFMovieEfx, x)
			end
		end
	end
	return luaRemoveDeadsFromTable(Mission.Phase1Targets)
end

function luaJM1KillRndTrg()
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Phase1Targets))
	if trg and not trg.Dead then
		SetDeadMeat(trg)
	end
end

function luaJM1StartEndTimer()
	Countdown("Time", 1, 600, "luaJM1End")
	Mission.EndTimer = true
end

function luaJM1End()
	Mission.EndTimer = false
	Mission.MissionEnd = true
end

function luaJM1CheckMonaghan()
	if Mission.Monaghan.Dead or Mission.Monaghan.retreating then
		--if Mission.MonaghanListenerActive then
		--	RemoveListener("hit", "monaghanhit")
		--	Mission.MonaghanListenerActive = nil
		--end
		return
	end

	if Mission.MissionPhase >= 3 then

		if not Mission.MonaghanInit then

			NavigatorEnable(Mission.Monaghan, true)
			AAEnable(Mission.Monaghan, true)
			--TorpedoEnable(Mission.Monaghan, true)
			ArtilleryEnable(Mission.Monaghan, true)
			SetInvincible(Mission.Monaghan, false)

			luaJM1InitMinisub()

			Mission.MonaghanInit = true

		else

			if not Mission.Minisub.Dead then
				local unitcmd = GetProperty(Mission.Monaghan, "unitcommand")
				if unitcmd ~= "attackmove" then
					NavigatorAttackMove(Mission.Monaghan, Mission.Minisub, {})
					--luaJM1StartDialog("Minisub_init",true)
					luaJM1ShowHintorDlg("Minisub_init",0)
				end
			else
				if not Mission.Monaghan.retrating then
					NavigatorMoveOnPath(Mission.Monaghan, FindEntity("RetreatPath"))
					Mission.Monaghan.retreating = true
				end
			end

		end

	end

end

function luaJM1AddMonaghanListener()
	if Mission.Monaghan.Dead then
		return
	end
	AddListener("hit", "monaghanhit", {
		["callback"] = "luaJM1MonaghanHit", -- callback fuggveny
		["target"] = {Mission.Monaghan}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB", "TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.MonaghanListenerActive = true
end

function luaJM1MonaghanHit()
	if not Mission.Monaghan.Dead then
		Effect("ExplosionBigShip", GetPosition(Mission.Monaghan))
		SetDeadMeat(Mission.Monaghan)
	end
	luaObj_Completed("secondary",1)
	MissionNarrative("ijn01.obj_h2_compl")
	if Mission.MonaghanListenerActive then
		RemoveListener("hit", "monaghanhit")
		Mission.MonaghanListenerActive = nil
	end
	--luaJM1StartDialog("Monaghan_hit",true)
	luaJM1ShowHintorDlg("Monaghan_hit",0)
	--luaJM1StartDialog("Monaghan_lost",true)
	luaJM1ShowHintorDlg("Monaghan_lost",0)
	if Mission.Minisub and not Mission.Minisub.Dead then
		luaDelay(luaJM1MinisubMsg,10)
		luaJM1MinisubInvincible()
	end
end

function luaJM1MinisubMsg()
	--luaJM1StartDialog("Minisub_saved",true)
	luaJM1ShowHintorDlg("Minisub_saved",0)
end

function luaJM1MinisubInvincible()
	SetInvincible(Mission.Minisub, 0.2)
end

function luaJM1CheckMinisub()
	if not Mission.MiniSub then --atraktuk masik fazisba
		return
	end
	if Mission.Minisub.Dead or Mission.Minisub.retrating then
		if Mission.Minisub.Dead and not Mission.MinisubDlg then
			--luaJM1StartDialog("Minisub_dead",true)
			luaJM1ShowHintorDlg("Minisub_dead",0)
			Mission.MinisubDlg = true
		end
		return
	end

	if Mission.MissionPhase >= 2 then

		if not Mission.MinisubInit then
			SetInvincible(Mission.Minisub, false)
			Mission.MinisubInit = true
			luaJM1AddPhoenixListener()
		else
			local torps = GetProperty(Mission.Minisub, "TorpedoStock")
			local unitcmd = GetProperty(Mission.Minisub, "unitcommand")
			if torps ~= 0 and not Mission.Phoenix.Dead then

				if unitcmd ~= "attackmove" and luaGetDistance(Mission.Minisub, Mission.Phoenix) < 1200 then
					NavigatorAttackMove(Mission.Minisub, Mission.Phoenix, {})
				end

			elseif torps == 0 or Mission.Phoenix.Dead then

				if not Mission.Minisub.retrating then
					NavigatorMoveOnPath(Mission.Minisub, FindEntity("RetreatPath"))
					Mission.Minisub.retrating = true
				end

				if not Mission.MinisubRamedDlg then
					if not Mission.Monaghan.Dead and GetSubmarineOnSurface(Mission.Minisub) and luaGetDistance(Mission.Minisub, Mission.Monaghan) < 200 then
						--luaJM1StartDialog("Minisub_rammed",true)
						luaJM1ShowHintorDlg("Minisub_rammed",0)
						Mission.MinisubRamedDlg = true
					end
				end

			end

		end
	end
end

function luaJM1CheckNeosho()
	if Mission.Neosho.Dead then
		if Mission.NeoshoListener then
			RemoveListener("hit", "neoshohit")
			Mission.NeoshoListener = false
		end
		return
	end

	if Mission.MissionPhase == 2 then
		if not Mission.NeoshoInit then
			NavigatorEnable(Mission.Neosho, true)
			AAEnable(Mission.Neosho, true)
			Mission.NeoshoInit = true
		else
			local unitcmd = GetProperty(Mission.Neosho, "unitcommand")
			if unitcmd ~= "moveonpath" then
				NavigatorMoveOnPath(Mission.Neosho, FindEntity("NeoshoPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
				local pathTbl = FillPathPoints(FindEntity("RetreatPath"))
				Mission.Neosho.LastPoint = pathTbl[table.getn(pathTbl)]
			else
				if not Mission.NeoshoListener then
					luaJM1AddNeoshoListener()
				end
				if not Mission.NeoshoFinaldDlg then
					if luaGetDistance(Mission.Neosho, Mission.Neosho.LastPoint) < 300 then
						--luaJM1StartDialog("Neosho_away",true)
						luaJM1ShowHintorDlg("Neosho_away",0)
						Mission.NeoshoFinaldDlg = true
					end
				end
			end
		end


	end

end

function luaJM1AddPhoenixListener()
	--luaLog("luaJM1AddPhoenixListener")

	if Mission.Phoenix.Dead then
		return
	end

	AddListener("hit", "phhit", {
		["callback"] = "luaJM1PhoenixHit", -- callback fuggveny
		["target"] = {Mission.Phoenix}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {Mission.Minisub,Mission.PlayerUnit}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.PhoenixListener = true
end

function luaJM1PhoenixHit()
	--luaLog("luaJM1PhoenixHit")
	RemoveListener("hit", "phhit")
	--luaJM1StartDialog("Phoenix_dead",true)
	luaJM1ShowHintorDlg("Phoenix_dead",0)
	--luaJM1StartDialog("Phoenix_lost",true)
	luaJM1ShowHintorDlg("Phoenix_lost",0)

	if not Mission.Phoenix.Dead then
		Effect("ExplosionBigShip", GetPosition(Mission.Phoenix))
		if Mission.MissionPhase > 1 then
			luaJM1KillPhoenix()
		else
			Mission.PhoenixMustDie = true
		end
	end
end

function luaJM1KillPhoenix()
	if not Mission.Phoenix.Dead then
		SetInvincible(Mission.Phoenix, false)
		SetDeadMeat(Mission.Phoenix)
	end
end

function luaJM1AddNeoshoListener()
	AddListener("hit", "neoshohit", {
		["callback"] = "luaJM1NeoshoHit", -- callback fuggveny
		["target"] = {Mission.Neosho}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.NeoshoListener = true
end

function luaJM1NeoshoHit()
	--luaJM1StartDialog("Neosho_hit",true)
	luaJM1ShowHintorDlg("Neosho_hit",0)
	if not Mission.Neosho.Dead then
		if luaGetDistance(Mission.Neosho, Mission.California) < 300 then
			--luaJumpinMovieSetCurrentMovie("GoAround",Mission.California.ID)
			RemoveListener("hit", "neoshohit")
			SetInvincible(Mission.Neosho, false)
			luaDelay(CaliforniaDies, 5)
			Mission.NeoshoListener = false
		end
		luaDelay(luaJM1NeoshoDies,5)
	end
end

function luaJM1NeoshoDies()
	Effect("ExplosionBigShip", GetPosition(Mission.Neosho))
	SetDeadMeat(Mission.Neosho)
	--luaJM1StartDialog("Neosho_exploded",true)
	luaJM1ShowHintorDlg("Neosho_exploded",0)
end

function CaliforniaDies()
	SetInvincible(Mission.California, false)
	Effect("ExplosionBigShip", GetPosition(Mission.California))
	SetDeadMeat(Mission.California)
	--luaJM1StartDialog("Califorina_on_fire",true)
	luaJM1ShowHintorDlg("Califorina_on_fire",0)
	luaDelay(luaJM1RadioMsg8, 5)
	luaObj_Completed("hidden",1)
	MissionNarrative("ijn01.obj_h1_compl")
	luaJM1CaliforniaMovie()
end

--cheat
function luaJM1CompObj1()
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		for idx,unit in pairs(Mission.Phase1Targets) do
			if not unit.Dead then
				Kill(unit)
			end
		end
	else
		--LogToConsole("Varja meg vagy nem aktiv az ojjektiva vagy teljesult")
	end
end

function luaJM1RadioMsg1()
	--luaJM1StartDialog("Fly_in_radio1",true)
	luaJM1ShowHintorDlg("Fly_in_radio1",0)
	luaDelay(luaJM1RadioMsg2, 15)
end

function luaJM1RadioMsg2()
	--luaJM1StartDialog("Fly_in_radio2",true)
	luaJM1ShowHintorDlg("Fly_in_radio2",0)
end

function luaJM1RadioMsg3()
	--luaJM1StartDialog("Plane_destroyed2",true)
	luaJM1ShowHintorDlg("Plane_destroyed2",0)
end

function luaJM1RadioMsg4()
	--luaJM1StartDialog("Plane_destroyed3",true)
	luaJM1ShowHintorDlg("Plane_destroyed3",0)
end

function luaJM1RadioMsg5()
	--luaJM1StartDialog("Nevada_beaching",true)
	luaJM1ShowHintorDlg("Nevada_beaching",0)
end

--function luaJM1RadioMsg6()
--	luaJM1ShowHintorDlg("After_Nevada",0)
--	luaDelay(luaJM1RadioMsg7, 15)
--end

function luaJM1RadioMsg7()
	luaJM1ShowHintorDlg("Arizona_dead",0)
	--luaJM1ShowHintorDlg("Arizona_down",0)
end

function luaJM1RadioMsg8()
	--luaJM1StartDialog("Californa_down",true)
	luaJM1ShowHintorDlg("Californa_down",0)
end

function luaJM1RadioMsg9()
	--luaJM1StartDialog("Radio_speech1",true)
	luaJM1ShowHintorDlg("Radio_speech1",0)
	--luaDelay(luaJM1RadioMsg10, random(3,6))
	luaDelay(luaJM1RadioMsg11, random(3,6))
end

function luaJM1RadioMsg10()
	--luaJM1StartDialog("Radio_speech2",true)
	luaJM1ShowHintorDlg("Radio_speech2",0)
	luaDelay(luaJM1RadioMsg11, random(3,6))
end

function luaJM1RadioMsg11()
	--luaJM1StartDialog("Radio_speech3",true)
	luaJM1ShowHintorDlg("Radio_speech3",0)
	luaDelay(luaJM1RadioMsg12, random(3,6))
end

function luaJM1RadioMsg12()
	--luaJM1StartDialog("Radio_speech4",true)
	luaJM1ShowHintorDlg("Radio_speech4",0)
end

function luaJM1RadioMsg13()
	--luaJM1StartDialog("Governor",true)
	luaJM1ShowHintorDlg("Governor",0)
	Mission.GovSpeech = true
end

function luaJM1RepeatMsgs()
	--luaJM1StartDialog("Plane_killing",true)
	luaJM1ShowHintorDlg("Plane_killing",0)
	luaDelay(luaJM1RadioMsg3, random(15,20))
	luaDelay(luaJM1RadioMsg4, random(5,10))
end

function luaJM1RadioListener()
	AddListener("entityKilled", "radiokilled", {
		["callback"] = "luaJM1RadioKilled",
		["entity"] = {Mission.RadioStation},
		["killReason"] = {},
	})
end

function luaJM1RadioKilled()
	--luaJM1StartDialog("Radio_destroyed",true)
	luaJM1ShowHintorDlg("Radio_destroyed",0)
end

function luaJM1AddOklahomaListener2()
	AddListener("hit", "oklahit", {
		["callback"] = "luaJM1OklahomaHit", -- callback fuggveny
		["target"] = {Mission.Oklahoma}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM1OklahomaHit()

	if not Mission.OklahomaHitOnce then
		DisablePhysics(Mission.Oklahoma)
		local x = random(-5,35)
		AddMatrixInterpolator(Mission.Oklahoma, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, random(45,65))
		Mission.OklahomaHitOnce = true
		Mission.Oklahoma.Capsized = true
	else
		RemoveListener("hit", "oklahit")
		luaJM1OklahomaKilled()
	end
end

function luaJM1OklahomaListener()
	AddListener("entityKilled", "oklahomakilled", {
		["callback"] = "luaJM1OklahomaKilled",
		["entity"] = {Mission.Oklahoma},
		["killReason"] = {},
	})
end

function luaJM1OklahomaKilled()
	--luaJM1StartDialog("Oklahoma_dead",true)
	luaJM1ShowHintorDlg("Oklahoma_dead",0)
end

function luaJM1AddUtahListener()
	AddListener("hit", "utahhit", {
		["callback"] = "luaJM1UtahHit", -- callback fuggveny
		["target"] = {Mission.Utah}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.UtahListener = true
end

function luaJM1UtahHit()

	if not Mission.UtahHitByPlayer then
		Mission.UtahHitByPlayer = 1
	else
		Mission.UtahHitByPlayer = Mission.UtahHitByPlayer + 1
	end

	if Mission.UtahHitByPlayer < 2 then
		return
	end

	RemoveListener("hit", "utahhit")
	--luaJM1StartDialog("Utah_hit1",true)
	luaJM1ShowHintorDlg("Utah_hit1",0)
	luaDelay(luaJM1UtahDlg1, random(5,10))

	DisablePhysics(Mission.Utah)
	local x = random(-5,35)
	AddMatrixInterpolator(Mission.Utah, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, random(45,65))
	Mission.Utah.Capsized = true
	table.insert(Mission.CapsizedShips, Mission.Utah.Name)
end

function luaJM1UtahDlg1()
	--luaJM1StartDialog("Utah_hit2",true)
	luaJM1ShowHintorDlg("Utah_hit2",0)
	luaDelay(luaJM1UtahDlg2, random(20,30))
end

function luaJM1UtahDlg2()
	--luaJM1StartDialog("Utah_hit3",true)
	luaJM1ShowHintorDlg("Utah_hit3",0)
end

function luaJM1DlgListener()
	AddListener("hit", "dlghit", {
		["callback"] = "luaJM1DlgHit", -- callback fuggveny
		["target"] = Mission.DlgUnits, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB","TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.DlgListener = true
end

function luaJM1DlgHit(...)

	local target = arg[1]
	local attackType = arg[4]

	--luaLog("-----")
	--luaLog(target)
	--luaLog(attackType)
	--luaLog("-----")
	--luaLog(arg)

	if target.Dead then
		return
	end

	if attackType == "TORPEDO" and GetHpPercentage(target) < 0.3 then

		if not target.Capsized then
			if target.ID ~= Mission.Virginia.ID then
				DisablePhysics(target)
				local x = random(-5,35)
				AddMatrixInterpolator(target, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, random(45,65))
			end

			target.Capsized = true
			table.insert(Mission.CapsizedShips, target.Name)

			if target.ID == Mission.Oklahoma.ID then
				luaJM1OklahomaKilled()
			end
		end

	end

	if Mission.MissionPhase == 2 and not Mission.Nevada.Dead and not Mission.BombOtherMsg then
		if target.ID ~= Mission.Nevada.ID then
			--luaLog("MAST TALALTAM EL")
			--luaJM1StartDialog("Bomb_other",true)
			luaJM1ShowHintorDlg("Bomb_other",0)
			Mission.BombOtherMsg = true
		end
	end
	if Mission.MissionPhase == 3 and not Mission.Virginia.Dead and not Mission.TorpOtherMsg then
		if target.ID ~= Mission.Virginia.ID then
			--luaJM1StartDialog("Torp_other",true)
			luaJM1ShowHintorDlg("Torp_other",0)
			Mission.TorpOtherMsg = true
		end
	end

end

function luaJM1AddBGSmoke()
	Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke1")), nil, 30)
	Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke2")), nil, 30)
	luaJM1ScriptedAlphaSmoke()
	--luaLog("bgsmoke generated")
end

function luaJM1ScriptedAlphaSmoke()
	Mission.SmokeAlpha = Mission.SmokeAlpha + 0.2

	if Mission.SmokeAlpha >= 1 then
		return
	else
		SetOldCloudAlpha(Mission.SmokeAlpha)
		luaDelay(luaJM1ScriptedAlphaSmoke, 2.5)
	end
end

function luaJM1AddPowerupPanelListener()
	AddListener("gui", "PowerupGuiListener", {
		["callback"] = "luaJM1PowerupGuiActivated",  -- callback fuggveny
		["guiName"] = {"GUI_powerups"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
		["enter"] = {true}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
	})
end

function luaJM1PowerupGuiActivated()
	luaJM1PowerupHint2()
	RemoveListener("gui", "PowerupGuiListener")
end

function luaJM1LogUnits()
	if not Mission.Debug then
		return
	end

	local all_living_jap = 0
	local all_dead_jap = 0
	local all_living_us = 0
	local all_dead_us = 0

	--lualog("---------------UNITS IN SCENE------------------")
	--lualog("JAPANESE SIDE:")

	for idx,unitTbl in pairs(recon[PARTY_JAPANESE].own) do
		local living_units = 0
		local dead_units = 0

		for idx2,unit in pairs(unitTbl) do
			if unit.Dead then
				dead_units = dead_units + 1
				all_dead_jap = all_dead_jap + 1
			else
				living_units = living_units + 1
				all_living_jap = all_living_jap + 1
			end
		end
		if living_units > 0 or dead_units > 0 then
			--lualog("\t"..tostring(idx).." has "..tostring(living_units).." living, and "..tostring(dead_units).." dead units")
		end
	end
	--lualog("All together the jap side has "..tostring(all_living_jap).." living, and "..tostring(all_dead_jap).." dead units")

	----------------------------

	--lualog("ALLIED SIDE:")

	for idx,unitTbl in pairs(recon[PARTY_ALLIED].own) do
		local living_units = 0
		local dead_units = 0

		for idx2,unit in pairs(unitTbl) do
			if unit.Dead then
				dead_units = dead_units + 1
				all_dead_us = all_dead_us + 1
			else
				living_units = living_units + 1
				all_living_us = all_living_us + 1
			end
		end
		if living_units > 0 or dead_units > 0 then
			--lualog("\t"..tostring(idx).." has "..tostring(living_units).." living, and "..tostring(dead_units).." dead units")
		end
	end
	--lualog("All together the allied side has "..tostring(all_living_us).." living, and "..tostring(all_dead_us).." dead units")

end

function luaJM1AnnounceSpawn(str)
	if not Mission.Debug then
		return
	end
	MissionNarrativeUrgent("Unit generated :"..tostring(str))
end

function luaJM1ClearPhase1Units()
	--zerok ki
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.fighter) do
		if unit.ID ~= Mission.PlayerUnit.ID and not unit.Dead then
			--lualog("Killing phase 1 Zero: "..unit.Name)
			Kill(unit, true)
		end
	end
	--luaJM1StartFlakManager()
end

function luaJM1ClearPhase2Units()
	--valok ki
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.divebomber) do
		if unit.ID ~= Mission.PlayerUnit.ID and not unit.Dead then
			--lualog("Killing phase 2 Val: "..unit.Name)
			Kill(unit, true)
		end
	end
end

function luaJM1ClearPhase3Units()
	--katek ki
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.torpedobomber) do
		if unit.ID ~= Mission.PlayerUnit.ID and not unit.Dead then
			--lualog("Killing phase 3 Kate: "..unit.Name)
			Kill(unit, true)
		end
	end
end

function luaJM1CheckPhase1Zeros()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Phase1Zeros)) do
		local trgs = {FindEntity("Attackpoint1"), FindEntity("Attackpoint2"), FindEntity("Attackpoint3"), FindEntity("Attackpoint4")}
		PilotSetTarget(unit, luaPickRnd(trgs))
		--PilotSetTarget(unit, FindEntity("Attackpoint4"))
		--PilotSetTarget(unit, FindEntity("Teszt"))
		SquadronSetAttackAlt(unit, 150, true)
		--PilotSetTarget(unit, Mission.Airfields[1])
		UnitSetFireStance(unit, STANCE_FREE_FIRE)
	end
end

-----------Message q ----------------
function luaJM1IsHintActive(hintID)

	local hintTbl = IsHintActive()

	if hintTbl == nil then
		return false
	else
		for idx,hint in pairs(hintTbl) do
			if string.find(hintTbl.HintID,"IJN05") or IsHintCritical(hintTbl.HintID) then
				return true
			end
		end
		return false
	end

	return true

end

function luaJM1AddDlgQ(dlgID)
	local tbl = {
		["ID"] = dlgID,
		["Type"] = 0,
		["Time"] = math.floor(GameTime()),
	}
	table.insert(Mission.MessageQ, tbl)
end

function luaJM1AddHintQ(hintID)
	local tbl = {
		["ID"] = hintID,
		["Type"] = 1,
		["Time"] = math.floor(GameTime()),
	}
	table.insert(Mission.MessageQ, tbl)
end

function luaJM1ShowHintorDlg(ID, type)

	--luaLog("luaJM1ShowHintorDlg called: "..tostring(ID))

	if Mission.StopMessages then
		if type == 0 then
			luaJM1AddDlgQ(ID)
			--luaLog("Messages stopped dlg queued")
		elseif type == 1 then
			luaJM1AddHintQ(ID)
			--luaLog("Messages stopped hint queued")
		end
		return
	end

	local isHintActive = luaJM1IsHintActive()
	local isDlgActive = luaJM1IsDlgRunning()
	local numQ = table.getn(Mission.MessageQ)

	if numQ == 0 and not isHintActive and not isDlgActive then
		--luaLog("No q, no active hint and no dialog running")
		if type == 0 then
			luaJM1StartDialog(ID, true)
		elseif type == 1 then
			ShowHint(ID)
			--luaLog("Showing hint "..ID)
		end
	elseif (numQ == 0 and (isHintActive or isDlgActive)) or numQ > 0 then
		if type == 0 then
			luaJM1AddDlgQ(ID)
			--luaLog("No q, but hint or dlg playing adding dlg in q")
		elseif type == 1 then
			luaJM1AddHintQ(ID)
			--luaLog("No q, but hint or dlg playing adding hint in q")
		end
	end

end

function luaJM1DlgHintQCheck()
	local isHintActive = luaJM1IsHintActive()
	local isDlgActive = luaJM1IsDlgRunning()

	if Mission.StopMessages then
		--luaLog("Q check suspended messages stoped")
		return
	end

	if isHintActive or isDlgActive then
		--luaLog("Q check suspended dlg or hint active")
		return
	end

	local idx,tbl = next(Mission.MessageQ)

	if tbl.Type == 0 then
		--luaLog("Displaying dlg from q "..tbl.ID)
		luaJM1StartDialog(tbl.ID,true)
		--luaLog("Time in Q "..tostring(math.floor(GameTime()) - tbl.Time))
		table.remove(Mission.MessageQ, idx)
	elseif tbl.Type == 1 then
		--luaLog("Displaying hint from q "..tbl.ID)
		luaJM1HideActHint()
		ShowHint(tbl.ID)
		--luaLog("Time in Q "..tostring(math.floor(GameTime()) - tbl.Time))
		table.remove(Mission.MessageQ, idx)
	end

end

function luaJM1StartMessageQ()
	Mission.MessageQManager = CreateScript("luaJM1MessageQInit")
end

function luaJM1MessageQInit(this)
	--luaLog("Fire init called")
	SetThink(this, "luaJM1MessageQ_think")
end

function luaJM1MessageQ_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		--luaLog("Fire_think killed")
		return
	end

	if table.getn(Mission.MessageQ) > 0 then
		luaJM1DlgHintQCheck()
	end
	SetWait(this, 2)
end

function luaJM1HideActHint()
	local hintTbl = IsHintActive()

	if hintTbl then
		if not IsHintCritical(hintTbl.HintID) then
			HideHint()
		else
			--luaLog("Cant hide hints cos its critical")
		end
	end

end

function luaJM1IsDlgRunning()
	if next(GetActDialogIDs()) == nil then
		return false
	else
		return true
	end
end

function luaJM1DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	--luaLog("luaJM1DisplayScore called with scoreID: "..tostring(scoreID))
end

function luaJM1RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	--luaLog("luaJM1RemoveScore called with scoreID: "..tostring(scoreID))
end

function luaJM1Pri1Score()
	local line1 = "ijn01.obj_p1"
	Mission.NumTargets = table.getn(luaRemoveDeadsFromTable(Mission.Phase1Targets))
	local line2 = "ijn01.hint_12_desc"
	luaJM1DisplayScore(1,line1,line2)
end

function luaJM1Pri2Score()
	local line1 = "ijn01.obj_p2"
	local line2 = "ijn01.hint_13_desc"
	luaJM1DisplayScore(2,line1,line2)
end

function luaJM1Pri3Score()
	local line1 = "ijn01.obj_p3"
	local line2 = "ijn01.hint_14_desc"
	luaJM1DisplayScore(3,line1,line2)
end

function luaJM1Sec1Score()
	local line1 = "ijn01.obj_s1"
	local line2 = "ijn01.hint_15_desc"
	luaJM1DisplayScore(4,line1,line2)
end

function luaJM1EndFlag()
	Mission.Phase4End = true
end

---------------moviez--------------
function luaJM1MovieInit()
	Mission.MovieInit = true
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	else
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			SetInvincible(Mission.PlayerUnit, 0.1)
		end
	end
end

function luaJM1SelectMovieUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	else
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			SetInvincible(Mission.PlayerUnit, false)
			SetSelectedUnit(Mission.PlayerUnit)
		end
	end
	EnableInput(true)
	Mission.MovieInit = false
end

function luaJM1NevadaMovie()

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM1MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Nevada, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Nevada, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM1SelectMovieUnit, true)


end

function luaJM1VirginiaMovie()

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM1MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Virginia, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Virginia, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM1SelectMovieUnit, true)
end

function luaJM1CaliforniaMovie()

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM1MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.California, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.California, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM1SelectMovieUnit, true)


		SetDamagedGFXLevel(Mission.California,1)
		--ExplodeToParts(Mission.Clifornia)
		DisablePhysics(Mission.California)
		AddMatrixInterpolator(Mission.California, {["x"]=0, ["y"]=-6, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(-35)}, 10)
		Mission.California.Capsized = true
		table.insert(Mission.CapsizedShips, Mission.California.Name)
end

function luaJM1NevadaGoMovie()
	Mission.MovieInit = true
	EnableInput(false)
	Mission.StopMessages = true
	Blackout(true, "", 1)
	luaDelay(luaJM1ClearPhase2Units, 1.5)

	luaJM1MovieInit()
	luaDelay(luaJM1DelayedNevadaEfx,2)

	luaDelay(luaJM1VestalBoom, 2)

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Nevada, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Nevada, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM1NevadaMovieFinish, true)

end

function luaJM1DelayedNevadaEfx()
		Effect("ExplosionBigShip", GetPosition(Mission.Nevada))
end

function luaJM1VirginiaDeadMovie()
	--Mission.MovieInit = true
	Mission.StopMessages = true
	EnableInput(false)
	Blackout(true, "", 1)
	luaDelay(luaJM1ClearPhase3Units, 1.5)

	luaJM1MovieInit()

	luaDelay(luaJM1DelayedVirginiaEfx,2)

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Virginia, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Virginia, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM1VirginiaMovieFinish, true)


		SetDamagedGFXLevel(Mission.Virginia, 1)
		--ExplodeToParts(Mission.Virginia)
		DisablePhysics(Mission.Virginia)
		AddMatrixInterpolator(Mission.Virginia, {["x"]=0, ["y"]=-10, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(30),}, 45)
end

function luaJM1DelayedVirginiaEfx()
	Effect("ExplosionBigShip", GetPosition(Mission.Virginia))
	Effect("BigFire", ORIGO, Mission.Virginia)
end

function luaJM1AirfieldMovie()

	--luaJM1ShowHintorDlg("1st_Success",0)
	Mission.StopMessages = true
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, true)
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
		--PilotMoveToRange(Mission.PlayerUnit, Mission.Airfields[1])
		PilotMoveToRange(Mission.PlayerUnit, FindEntity("PlayerMoveTo"))
	end
	--luaDelay(luaJM1MakeAFMovieFire, 1)
	luaDelay(luaJM1ClearPhase1Units, 1.5)
	--Blackout(true, "", 1)

	luaJM1ArizonaOnFire()

	luaJM1MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[1], ["distance"] = 780, ["theta"] = 0.3, ["rho"] = 24, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[1], ["distance"] = 750, ["theta"] = 0.5, ["rho"] = 24, ["moveTime"] = 10},
		}, luaJM1AFMovieFinish, true)

end

function luaJM1MakeAFMovieFire()
	Mission.DestroyAFMovieEfx = {}
	for idx,point in pairs(Mission.AFMovieFirePoints) do
		local x = Effect("SmallFire",point)
		table.insert(Mission.DestroyAFMovieEfx, x)
	end
end

function luaJM1DestroyAFMovieEfx()
	for idx,efx in pairs(Mission.DestroyAFMovieEfx) do
		StopEffect(efx.Pointer)
		table.remove(Mission.DestroyAFMovieEfx,idx)
		break
	end

	if table.getn(Mission.DestroyAFMovieEfx) > 0 then
		luaDelay(luaJM1DestroyAFMovieEfx, 5)
	end
end

function luaJM1SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	Mission.Checkpoint.HenryKilledByPlayer = Mission.HenryKilledByPlayer
	Mission.Checkpoint.CapsizedShips = Mission.CapsizedShips

	for idx,unit in pairs(Mission.CPUnits) do
		if unit.Dead then
			Mission.CPUnitsDeadTbl[idx] = true
		end
	end

	Mission.Checkpoint.DeadShipsTbl = Mission.CPUnitsDeadTbl

	Mission.Checkpoint.DeadPlanesTbl = Mission.HiddenPlanesDeads

end

function luaJM1LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.HenryKilledByPlayer = Mission.Checkpoint.HenryKilledByPlayer

	Mission.Inrange = true

	if num[1] == 1 then
		if luaObj_IsActive("primary",2) then
			luaObj_AddUnit("primary",2,Mission.Nevada)
		end
	end

	if num[1] == 2 then
		luaJM1FighterListener()
		luaJM1CheckStageShips()
		---luaJM1SinkTrgShips(Mission.Virginia)
		luaDelay(luaJM1DonaldInit,32)

		luaJM1CheckCapsize()

	end

	local deadTbl = Mission.Checkpoint.DeadShipsTbl
	for idx,val in pairs(deadTbl) do
		if val then
			Kill(Mission.CPUnits[idx],true)
		end
	end

	local deadplanes = Mission.Checkpoint.DeadPlanesTbl
	for idx,val in pairs(deadplanes) do
		if val then
			Kill(Mission.HiddenPlanes[idx],true)
		end
	end
	--luaLog()
end

function luaJM1CheckCapsize()

	for idx,unit in pairs(Mission.DlgUnits) do
		--luaLog(unit.Name.." checking")
		for idx2,shipName in pairs(Mission.Checkpoint.CapsizedShips) do
			if unit.Name == shipName then
				--luaLog("found unit "..unit.Name)
				if unit.Name ~= Mission.Nevada.Name and unit.Name ~= Mission.Virginia.Name then
					luaJM1SinkTrgShips(unit)
				--elseif unit.Name == Mission.Nevada.Name then
				end
			end
		end
	end

	luaJM1SinkNevadaCP()
	luaJM1SinkVirginiaCP()

end

function luaJM1CheckUSShipsAtCP()
	luaJM1SetShipsInvincible(0.2)
end

---- traffic es egyeb backlog basz
function luaJM1InitTrafficUnits()
	Mission.TrafficUnits = {}
	Mission.TrafficUnitPaths = {
		[1] = FindEntity("TrafficPath1"),
		[2] = FindEntity("TrafficPath2"),
		[3] = FindEntity("TrafficPath3"),
		[4] = FindEntity("TrafficPath4"),
		[5] = FindEntity("TrafficPath5"),
	}
end

function luaJM1CheckTrafficUnits()
	Mission.TrafficUnits = luaRemoveDeadsFromTable(Mission.TrafficUnits)
	if table.getn(Mission.TrafficUnits) < 3 then
		for idx,path in pairs(Mission.TrafficUnitPaths) do

			if path.unit == nil or path.unit.Dead then
				local pathTbl = FillPathPoints(path)

				local unit
				if Mission.MissionPhase == 1 then
					unit = GenerateObject("TrafficZero")
					--luaLog("generating traffic zero")
				elseif Mission.MissionPhase == 2 then
					unit = GenerateObject("TrafficVal")
					--luaLog("generating traffic val")
				elseif Mission.MissionPhase == 3 then
					unit = GenerateObject("TrafficKate")
					--luaLog("generating traffic kate")
				end

				table.insert(Mission.TrafficUnits, unit)

				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				UnitSetFireStance(unit, STANCE_HOLD_FIRE)
				PilotMoveOnPath(unit, path)
				SquadronSetTravelAlt(unit, 40, true)
				path.unit = unit
				unit.lastPoint = pathTbl[table.getn(pathTbl)]
				break
			end

		end
	end

	for idx,unit in pairs(Mission.TrafficUnits) do
		--luaLog("command "..GetProperty(unit, "unitcommand").." "..unit.Name)
		if not unit.retreating then
			if not unit.Dead and luaGetDistance(unit, unit.lastPoint) < 200 then
				PilotRetreat(unit)
				unit.retreating = true
				--luaLog("retreating "..unit.Name)
			end
		else
			if not Mission.PlayerUnit.Dead and not unit.Dead and luaGetDistance(unit, Mission.PlayerUnit) > 2000 then
				Kill(unit, true)
				--luaLog("killing unit "..unit.Name)
			end
		end
	end

end

function luaJM1AddDebrish()

		local debrisTbl = {
			[1] = {GetPosition(FindEntity("Debris1_1")), GetPosition(FindEntity("Debris1_2")),},
			[2] = {GetPosition(FindEntity("Debris2_1")), GetPosition(FindEntity("Debris2_2")),},
		}

		for idx,tbl in pairs(debrisTbl) do
	 		TempAddFloatsam({
			["topBox"] = {
				["minCorner"] = tbl[1],
				["maxCorner"] = tbl[2],
			},
			["buoyClassNames"] = { "Debrish_01", "Debrish_02", "Debrish_03", "Debrish_04", "Vizihulla_01", "Vizihulla_02", "Mentoov", "Box", },
			["buoyTypeWeights"] = { 3, 3, 3, 3, 2, 2, 1, 2, },
			["buoyGap"] = 40,
			["buoyDev"] = 20,
		})
	end
end

----ameriaki cuccok-----
function luaJM1ArizonaOnFire()
	Effect("BigFire", ORIGO, Mission.Arizona)
end


function c1()
	for idx,unit in pairs(Mission.Phase1Targets) do
		Kill(unit)
	end
end

function luaJM1InitMinisub()
	--Mission.Minisub = FindEntity("Type A minisub 01")
	Mission.Minisub = GenerateObject("Type A minisub 01")
	SetRoleAvailable(Mission.Minisub, EROLF_ALL, PLAYER_AI)
	SetInvincible(Mission.Minisub, 0.2)
	SetUnlimitedAirSupply(Mission.Minisub, true)
	NavigatorMoveOnPath(Mission.Minisub, FindEntity("MiniSubPath"))
	SetSubmarineDepthLevel(Mission.Minisub, 1)
end

function luaJM1c()
	Mission.MissionPhase = 3
	luaObj_Add("primary",3)
	luaObj_Completed("primary",3,true)
	Mission.VirginiaSunken = true
	Mission.Inrange = true
	luaJM1VirginiaDeadMovie()
end

--[[
function luaJM1BBRowListener()
	AddListener("hit", "bbrowhit", {
		["callback"] = "luaJM1BBRowHit", -- callback fuggveny
		["target"] = Mission.BBToSink, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end
]]
function luaJM1BBRowHit(target)
	if target.Capsized then
		return
	end

	DisablePhysics(target)
	local x = random(-25,35)
	AddMatrixInterpolator(target, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, random(45,65))
	target.Capsized = true
end

function luaJM1SinkTrgShips(trg)
	--luaLog("capsizing ship")
	--luaLog(trg)
	DisablePhysics(trg)
	local x = random(-25,35)
	AddMatrixInterpolator(trg, {["x"]=0, ["y"]=-7, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, 1)
	trg.Capsized = true
end

function luaJM1SinkNevadaCP()
	local pos = GetPosition(FindEntity("debrish_top"))
	PutTo(Mission.Nevada, pos)
	DisablePhysics(Mission.Nevada)
	local x = random(-25,35)
	AddMatrixInterpolator(Mission.Nevada, {["x"]=0, ["y"]=-7, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, 1)
	Mission.Nevada.Capsized = true
end

function luaJM1SinkVirginiaCP()
	DisablePhysics(Mission.Virginia)
	local x = random(-25,35)
	AddMatrixInterpolator(Mission.Virginia, {["x"]=0, ["y"]=-7, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaJM1RAD(x)}, 1)
	Mission.Virginia.Capsized = true
end

function luaJM1AddStoredTips()
	AddStoredHint("BASICPLANE2")
	AddStoredHint("BASICPLANE3")
	AddStoredHint("MACHINEGUN")
end

function luaJM1ShowBasicPlane2()
	RemoveStoredHint("BASICPLANE2")
	--luaJM1ShowHintorDlg("BASICPLANE2")
	ShowHintForced("BASICPLANE2")
end

function luaJM1ShowBasicPlane3()
	RemoveStoredHint("BASICPLANE3")
	--luaJM1ShowHintorDlg("BASICPLANE3")
	ShowHintForced("BASICPLANE3")
end