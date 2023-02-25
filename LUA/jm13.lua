--SceneFile="universe\Scenes\missions\IJN\ijn_13.scn"
DoFile("Scripts/datatables/Inputs.lua")

--[[

	*Yorktown-class 01		Yorktown
	*Yorktown-class 02		Enterprise
	*Iowa-class 01			USS Iowa (4)
	*SOUTH DAKOTA 1			USS Alabama (60)
	*SOUTH DAKOTA 2			USS South Dakota (49)
	*SOUTH DAKOTA 3			USS Indiana (50)
	Troop transport 01		USS Knox
	Troop transport 02		USS Ormsby
	Troop transport 03		USS Windsor

	Troop transport 05		USS American Legion
	Troop transport 06		USS President Grant
	Troop transport 07		USS John Penn
	Troop transport 08		USS Dorothea L. Dix


	Fuso 01         Fuso
	Fuso 02			Yamashiro
	Fuso 03			Hyuga
	Kaga-class		Kaga
	*Kongo-class		Haruna


	EFFECT:

	20
	154
	67 - magazine

]]--

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_CALM)
	EnableMessages(false)
	LoadMessageMap("ijndlg",13)

	Dialogues = {
		["Intro1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
			},
		},
		["Intro2"] = {
			["sequence"] = {
				{
					["message"] = "idlg01_1",
				},
			},
		},
	}

	MissionNarrative("ijn13.date_location")
	luaDelay(luaJM13EMDlg, 10)
end

function luaJM13EMDlg()
	StartDialog("Intro_dlg1", Dialogues["Intro1"]);
	luaDelay(luaJM13EMDlg2, 12)
end

function luaJM13EMDlg2()
	StartDialog("Intro_dlg2", Dialogues["Intro2"]);
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitJM13")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM13(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM13.lua"

	this.Name = "JM13"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

-- RELEASE_LOGOFF  --	luaLog("init start")

	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.Difficulty = GetDifficulty()

	SETLOG(this, true)
-- RELEASE_LOGOFF  --	luaLog("Initiating "..this.Name.." mission!")

	--luaLog(Mission.Difficulty)

	if Mission.Difficulty == 0 then
		Mission.MaxSpawns = 30
		Mission.DiffDelay = 90
	elseif Mission.Difficulty == 1 then
		Mission.MaxSpawns = 25
		Mission.DiffDelay = 60
	elseif Mission.Difficulty == 2 then
		Mission.MaxSpawns = 20
		Mission.DiffDelay = 30
	end

	--luaLog("MAX: "..tostring(Mission.MaxSpawns))


	Blackout(true, "", 0.1)
	EnableMessages(true)

	--enginemovies
	BannSupportmanager()
	--Mission.PlayerUnit = FindEntity("J2M Raiden 01")

	--SetSelectedUnit(Mission.PlayerUnit)
	--luaJM13AddKillListener(Mission.PlayerUnit)

	SetDeviceReloadEnabled(true)

	Mission.IJNCarrier = FindEntity("Kaga-class 01")
	SetGuiName(Mission.IJNCarrier, "ingame.shipnames_kaga")
	--LaunchSquadron(Mission.IJNCarrier, 150, 1, 1)

	Mission.MovieOption = luaGetMovieOption()

	Mission.DakotaSpawn = FindEntity("DakotaSpawn")
	Mission.DakotaSpawn2 = FindEntity("DakotaSpawn2")
	Mission.PlayerSpawnForAmmoShip = FindEntity("PlayerSpawnForAmmoShip")
	Mission.PlayerSpawnForDakota = FindEntity("PlayerSpawnForDakota")
	Mission.PlayerSpawnForAK = FindEntity("PlayerSpawnForAK")

	Mission.LastPos = nil
	Mission.LastLookAt = nil
	Mission.Exit = FindEntity("Exit")
	Mission.RePos = FindEntity("RePos")

	Mission.FXPos = FindEntity("FXPoint")
	Mission.SpawnCounter = 0
	--Mission.AmmoShipPath = FindEntity("AmmoShipPath")

	Mission.LandingDebug = {}
		Mission.LandingDebug["-1"] = "Nincs a cargonak beallitva LandingShipClass"
		Mission.LandingDebug["-2"] = "Nincs a cargonak beallitva LandingShipAmount"
		Mission.LandingDebug["-3"] = "Nemreg kuldott, meg nem jart le a cooldown"
		Mission.LandingDebug["-4"] = "Minden LandingPoint foglalt"
		Mission.LandingDebug["-5"] = "Nincs command building a palyan"
		Mission.LandingDebug["-6"] = "Nincs ellenseges vagy neutral command building a palyan"
		Mission.LandingDebug["-7"] = "Nincs a hajo LandingRange-en belul"
		Mission.LandingDebug["-8"] = "Nem talalt helyet a hajo korul a landing shipek lerakasahoz"

	--[[Mission.Junks = {}
		table.insert(Mission.Junks, FindEntity("Junk Moving 01"))
		table.insert(Mission.Junks, FindEntity("Junk Moving 02"))
		table.insert(Mission.Junks, FindEntity("Junk Moving 03"))
		table.insert(Mission.Junks, FindEntity("Junk Moving 04"))

	Mission.JunkPaths = {}
		table.insert(Mission.JunkPaths, FindEntity("JunkTraffic1A"))
		table.insert(Mission.JunkPaths, FindEntity("JunkTraffic1B"))
		table.insert(Mission.JunkPaths, FindEntity("JunkTraffic2A"))
		table.insert(Mission.JunkPaths, FindEntity("JunkTraffic2B"))]]--

	Mission.AFEnts = {
		[1] = {},
		[2] = {},
	}


	Mission.USNAttackers = {}
	Mission.SecNames = {}
		table.insert(Mission.SecNames, luaFindHidden("Kaga-class 01s"))
		--table.insert(Mission.SecNames, luaFindHidden("Fuso-class Battleship 01s"))
		--table.insert(Mission.SecNames, luaFindHidden("Fuso-class Battleship 02s"))

	Mission.SecNamesNames = {"ingame.shipnames_kaga"} --,"ingame.shipnames_fuso","ingame.shipnames_yamashiro"}

	Mission.USNCarriers = {}
	Mission.USNTransports = {}

	Mission.USNFleet = {}
		--table.insert(Mission.USNFleet, FindEntity("USTroopTransport_light 01"))
		--table.insert(Mission.USNFleet, FindEntity("USTroopTransport_light 02"))
		--table.insert(Mission.USNFleet, FindEntity("USTroopTransport_light 03"))

		table.insert(Mission.USNFleet, FindEntity("US Tanker 01"))
		table.insert(Mission.USNFleet, FindEntity("US Tanker 02"))
		--table.insert(Mission.USNFleet, FindEntity("US Tanker 03"))

	Mission.USNFleetNames = {"ingame.shipnames_knox", "ingame.shipnames_ormsby"} --, "ingame.shipnames_windsor"}


	for i,n in pairs(Mission.USNFleet) do
		SetGuiName(n, Mission.USNFleetNames[i])
		--SetNumbering(n,0)
	end

	Mission.USNAttackerNames = {}
		--table.insert(Mission.USNAttackerNames, luaFindHidden("Yorktown-class 01"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("Yorktown-class 02"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("South Dakota Class 01"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("South Dakota Class 02"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("South Dakota Class 03"))
		table.insert(Mission.USNAttackerNames, luaFindHidden("Iowa Class 01"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("USTroopTransport 05"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("USTroopTransport 06"))
		table.insert(Mission.USNAttackerNames, luaFindHidden("USTroopTransport 07"))
		table.insert(Mission.USNAttackerNames, luaFindHidden("USTroopTransport 08"))
		table.insert(Mission.USNAttackerNames, luaFindHidden("Landing Ship, Tank 01"))
		--table.insert(Mission.USNAttackerNames, luaFindHidden("AmmoShip"))

	Mission.USNAttackerNamesNames = {
		--"ingame.shipnames_yorktown",
		--"ingame.shipnames_enterprise",
		--"ingame.shipnames_south_dakota",
		--"ingame.shipnames_alabama",
		--"ingame.shipnames_indiana",
		"ingame.shipnames_iowa",
		--"ingame.shipnames_american_legion",
		--"ingame.shipnames_pres_grant",
		"ingame.shipnames_john_penn",
		"ingame.shipnames_dorothea_l_dix",
		"ingame.shipnames_lst|.415"
		--"ijn13.ammoship"
	}

	Mission.ShipNumbers = {4,0,0,415}

	Mission.FinalFleet = {}
	Mission.FinalFleetNames = {}
		table.insert(Mission.FinalFleetNames, {luaFindHidden("Yorktown-class 01"), "ingame.shipnames_yorktown", 5})
		table.insert(Mission.FinalFleetNames, {luaFindHidden("Yorktown-class 02"), "ingame.shipnames_enterprise",6})
		table.insert(Mission.FinalFleetNames, {luaFindHidden("AmmoShip"), "ijn13.ammoship", 0})

	--[[Mission.IJNBBs = {}
		table.insert(Mission.IJNBBs, FindEntity("Fuso-class Battleship 01"))
		table.insert(Mission.IJNBBs, FindEntity("Fuso-class Battleship 02"))
		table.insert(Mission.IJNBBs, FindEntity("Fuso-class Battleship 03"))
		table.insert(Mission.IJNBBs, FindEntity("Kongo-class Battleship 01"))]]

	Mission.IJNFleet = {}
		--table.insert(Mission.IJNFleet, FindEntity("Fuso-class Battleship 01"))
		--table.insert(Mission.IJNFleet, FindEntity("Fuso-class Battleship 02"))
		--table.insert(Mission.IJNFleet, FindEntity("Fuso-class Battleship 03"))
		--table.insert(Mission.IJNFleet, FindEntity("Kongo-class Battleship 01"))
		table.insert(Mission.IJNFleet, FindEntity("Kaga-class 01"))
		table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 02"))
		--table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 04"))
		--table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 05"))
		--table.insert(Mission.IJNFleet, FindEntity("Japan Troop Transport 06"))


	Mission.IJNFleetNames = {
		--"ingame.shipnames_fuso",
		--"ingame.shipnames_yamashiro",
		--"ingame.shipnames_hyuga",
		--"ingame.shipnames_haruna",
		"ingame.shipnames_kaga",
		"ingame.shipnames_kumagawa",
		"ingame.shipnames_sumanoura",
		--"ingame.shipnames_yukka",
		--"ingame.shipnames_sagamai",
		--"ingame.shipnames_sasago",
		--"ingame.shipnames_tatsukami",
	}

	for i,n in pairs(Mission.IJNFleet) do
		SetGuiName(n, Mission.IJNFleetNames[i])
		SetRoleAvailable(n, EROLF_ALL, PLAYER_AI)
		NavigatorStop(n)
	end

	Mission.IJNTroops = {}
		table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 02"))
		--table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 04"))
		--table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 05"))
		--table.insert(Mission.IJNTroops, FindEntity("Japan Troop Transport 06"))


	Mission.IJNA = {}
		table.insert(Mission.IJNA, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.IJNA, FindEntity("Japan Troop Transport 02"))

	Mission.IJNB = {}
		--table.insert(Mission.IJNB, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.IJNB, FindEntity("Japan Troop Transport 04"))

	--[[Mission.CoastalGuns = {}
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 01"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 02"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 03"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 04"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 05"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 06"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 07"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 08"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 09"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 10"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 11"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 12"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 13"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 14"))	--beta
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 15"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 16"))	--alpha
		table.insert(Mission.CoastalGuns, FindEntity("Coastal Gun, US 17"))	--alpha


Mission.AlphaGuns = {}
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 04"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 05"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 06"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 07"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 15"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 16"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 17"))]]


Mission.AlphaGuns = {}
	table.insert(Mission.AlphaGuns, FindEntity("Light AA, US 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Light AA, US 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, US 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, US 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, US 03"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, CB 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, CB 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, CB 03"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, CB 04"))
	table.insert(Mission.AlphaGuns, FindEntity("Heavy AA, CB 05"))
	table.insert(Mission.AlphaGuns, FindEntity("Huge Battery Open Strafeable 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Huge Battery Open Strafeable 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Huge Battery Open Strafeable 03"))
	table.insert(Mission.AlphaGuns, FindEntity("Huge Battery Open Strafeable 04"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 01"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 02"))
	table.insert(Mission.AlphaGuns, FindEntity("Coastal Gun, US 03"))
	table.insert(Mission.AlphaGuns, FindEntity("Patrol4"))
	table.insert(Mission.AlphaGuns, FindEntity("Patrol5"))
	table.insert(Mission.AlphaGuns, FindEntity("PT Boat 80' Elco 01"))
	table.insert(Mission.AlphaGuns, FindEntity("PT Boat 80' Elco 02"))
	table.insert(Mission.AlphaGuns, FindEntity("PT Boat 80' Elco 03"))
	table.insert(Mission.AlphaGuns, FindEntity("US Cargo Transport 01"))


--[[Mission.BetaGuns = {}
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 08"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 09"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 10"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 11"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 12"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 13"))
	table.insert(Mission.BetaGuns, FindEntity("Coastal Gun, US 14"))

	Mission.Targets = {}
		table.insert(Mission.Targets, FindEntity("Fortress element, Long 01"))
		table.insert(Mission.Targets, FindEntity("Fortress element, Long 02"))
		table.insert(Mission.Targets, FindEntity("Fortress element, Long 03"))
		table.insert(Mission.Targets, FindEntity("Heavy AA, US 01"))
		table.insert(Mission.Targets, FindEntity("Heavy AA, US 02"))
		table.insert(Mission.Targets, FindEntity("Heavy AA, US 03"))
		table.insert(Mission.Targets, FindEntity("Command Building - Radar Station 01"))
		table.insert(Mission.Targets, FindEntity("Light AA, US 01"))
		table.insert(Mission.Targets, FindEntity("Light AA, US 02"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 01"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 02"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 03"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 04"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 05"))
		table.insert(Mission.Targets, FindEntity("Coastal Gun, US 06"))]]--

	Mission.Raidens = {}
		table.insert(Mission.Raidens, FindEntity("J2M Raiden 01"))
		--table.insert(Mission.Raidens, FindEntity("J2M Raiden 02"))
		table.insert(Mission.Raidens, FindEntity("A6M Zero 01"))
		--table.insert(Mission.Raidens, FindEntity("A6M Zero 02"))
		--table.insert(Mission.Raidens, FindEntity("A6M Zero 03"))
		--table.insert(Mission.Raidens, FindEntity("Gekko 01"))

	Mission.USNPlanes = {}
		--table.insert(Mission.USNPlanes, FindEntity("F4U Corsair 01"))
		--table.insert(Mission.USNPlanes, FindEntity("F4U Corsair 02"))
		--table.insert(Mission.USNPlanes, FindEntity("P-40 Warhawk 01"))
		--table.insert(Mission.USNPlanes, FindEntity("P-40 Warhawk 02"))
		--table.insert(Mission.USNPlanes, FindEntity("F6F Hellcat 01"))
		--table.insert(Mission.USNPlanes, FindEntity("F6F Hellcat 02"))

	Mission.CB = FindEntity("HQ 01")
	--Mission.CC = FindEntity("Command Station 01")

	--for faking purposes only!
	--AddDamage(Mission.CC, 999999)
	OverrideHP(Mission.CB, 1000) -- mert kulonben sose foglaljak el bazeg
	--OverrideHP(Mission.CC, 1000)

	Mission.HQs = {Mission.CB}
	--Mission.HQs = {Mission.CB}
	RepairEnable(Mission.CB, false)
	--RepairEnable(Mission.CC, false)

	Mission.LookAt = FindEntity("LookAt")

	--for idx, ship in pairs(Mission.IJNBBs) do
		--SetSkillLevel(ship, SKILL_SPVETERAN)
	--end
	-- hiddenhez a dolgok

	Mission.RescuePath = FindEntity("RescuePath")
	Mission.RescuePlane = nil
	Mission.VoltMar = false
	Mission.EscapePos = nil
	Mission.EscapeDone = false
	Mission.Prison = FindEntity("Radiotower 01")
	--SetInvincible(Mission.Prison, 0.1)
	SetGuiName(Mission.Prison, "ijn13.prison")
	--[[Mission.PrisonPatrol = {}
		table.insert(Mission.PrisonPatrol, FindEntity("Patrol1"))
		table.insert(Mission.PrisonPatrol, FindEntity("Patrol2"))
		table.insert(Mission.PrisonPatrol, FindEntity("Patrol3"))
		table.insert(Mission.PrisonPatrol, FindEntity("Patrol7"))]]

	Mission.PrisonPatrol2 = {}
		table.insert(Mission.PrisonPatrol2, FindEntity("Patrol4"))
		table.insert(Mission.PrisonPatrol2, FindEntity("Patrol5"))
		--table.insert(Mission.PrisonPatrol2, FindEntity("Patrol6"))
		--table.insert(Mission.PrisonPatrol2, FindEntity("Patrol8"))

	Mission.PatrolPath = FindEntity("PatrolPath")
	Mission.PatrolPath2 = FindEntity("PatrolPath2")

	Mission.PrisonGuns = {}
		table.insert(Mission.PrisonGuns, FindEntity("Prison Gun 01"))
		table.insert(Mission.PrisonGuns, FindEntity("Prison Gun 02"))
		table.insert(Mission.PrisonGuns, FindEntity("Prison Gun 03"))
		table.insert(Mission.PrisonGuns, FindEntity("Prison Gun 04"))
		table.insert(Mission.PrisonGuns, FindEntity("Radiotower 01"))
		--table.insert(Mission.PrisonGuns, FindEntity("House, Small, Wooden, White 02"))

	for idx,unit in pairs(Mission.PrisonGuns) do
		AddUntouchableUnit(unit)
	end


	NavigatorMoveOnPath(FindEntity("PT Boat 80' Elco 01"), Mission.PatrolPath2, PATH_FM_CIRCLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(FindEntity("PT Boat 80' Elco 02"), Mission.PatrolPath2, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS)
	NavigatorMoveOnPath(FindEntity("PT Boat 80' Elco 03"), Mission.PatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN)

	for i=1,3 do
		SetGuiName(FindEntity("PT Boat 80' Elco 0"..tostring(i)), "ijn13.patrol")
	end

	--[[for idx,unit in pairs(Mission.PrisonPatrol) do
		AddUntouchableUnit(unit)
		SetGuiName(unit, "ijn13.patrol")
	end]]--

	for idx,unit in pairs(Mission.PrisonPatrol2) do
		AddUntouchableUnit(unit)
		SetGuiName(unit, "ijn13.patrol")
	end


	--NavigatorMoveOnPath(Mission.PrisonPatrol[1], Mission.PatrolPath, PATH_FM_CIRCLE)
	--NavigatorMoveOnPath(Mission.PrisonPatrol[2], Mission.PatrolPath, PATH_FM_CIRCLE)


	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM13LoadBlackout, luaJM13StepPhase, luaJM13SpawnPlayerUnit, luaJM13GenerateEscapist},
		[2] = {luaJM13LoadBlackout, luaJM13StepPhase, luaJM13SpawnPlayerUnit, luaJM13GenerateEscapist},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM13SaveMissionData,},
		[2] = {luaJM13SaveMissionData,},
	}


	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Landing",
				["Text"] = "ijn13.obj_p1",
				["TextCompleted"] = "ijn13.obj_p1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Transports",
				["Text"] = "ijn13.obj_p2",
				["TextCompleted"] = "ijn13.obj_p2_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Dakota",
				["Text"] = "ijn13.obj_p3",
				["TextCompleted"] = "ijn13.obj_p3_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Ammoship",
				["Text"] = "ijn13.obj_p4",
				["TextCompleted"] = "" ,
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Escapers",
				["Text"] = "ijn13.obj_s1",
				["TextCompleted"] = "ijn13.obj_s1_comp" ,
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "PrisonBreak",
				["Text"] = "ijn13.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["marker2"] = {
				[1] = {
				["ID"] = "markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		}

	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--dialogues
	LoadMessageMap("ijndlg",13)


	Mission.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
				{
					["message"] = "dlg1_1",
				},
			},
		},

		["Escaping"] = {
			["sequence"] = {
				{
					["message"] = "dlg2",
				},

			},
		},

		["BasesCaptured"] = {
			["sequence"] = {
				{
					["message"] = "dlg3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM13DlgCBChkp",
				},
			},
		},
		["Ambush"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["message"] = "dlg4c",
				},
				{
					["message"] = "dlg4d",
				},
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},

		["Paratroopers"] = {
			["sequence"] = {
				--{
					--["message"] = "dlg6a",
				--},
				{
					["message"] = "dlg6b",
				},
			},
		},

		["C47Done"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM13Atvezeto1A",
				},
			},
		},
		["GoHome"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
			},
		},
 		["LastBattle"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
				{
					["message"] = "dlg9c",
				},
				--[[{
					["type"] = "callback",
					["callback"] = "luaJM13AmmoShip1",
				},]]--
			},
		},

 		["LastBattle2"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
				{
					["message"] = "dlg10c",
				},
				{
					["message"] = "dlg10d",
				},
				{
					["message"] = "dlg10e",
				},
				{
					["message"] = "dlg10f",
				},
			},
		},
	}

	--luaJM13SetGuiNames()
	Mission.MissionPhase = -1

	Mission.FirstRun = true

	luaCheckSavedCheckpoint()
	Music_Control_SetLevel(MUSIC_ACTION)
	--luaCheckMusicSetMinLevel(MUSIC_ACTION)

	--think
	SetThink(this, "luaJM13_think")

	--NavigatorAttackMove(Mission.IJNBB, Mission.CB, {})
	--luaJM13JunkTrafficInit()

	if not Mission.CheckpointLoaded then
		luaJM13StartRaidens()
		--luaDelay(luaJM13AddLandingListener, 6)
		luaDelay(luaJM13CarrierMovie, 3)
		--luaLog("VISSZAMENNYE")
		--Blackout(false,"luaJM13VisszaMennye",2)
	end

-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
	--AddWatch("Mission.SpawnCounter")
-- RELEASE_LOGOFF  	AddWatch("Mission.ThinkStop")
-- RELEASE_LOGOFF  	AddWatch("Mission.Mehet")
-- RELEASE_LOGOFF  	AddWatch("Mission.VanE")

	--luaLog("init end")
end

function luaJM13_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.EndMission then
		--Scoring_RealPlayTimeRunning(false)
		return
	end

	if Mission.ThinkStop then
		if not Mission.Mehet then
			return
		end
	end

	if Mission.MissionPhase < 99 and Mission.MissionPhase > 0 then
		--luaCheckMusic()
		--luaJM13WhereWasI()
		--luaJM13TargetSelector()
		luaJM13DisplayCBHP()
		--luaJM13VanEListener()
	end

	if Mission.MissionPhase == -1 then
		if Mission.FirstRun then
			Mission.FirstRun = false
		end

	elseif Mission.MissionPhase == 1 then
		luaJM13Invasion()
		luaJM13CheckObjectives()
		luaJM13CheckPlayer()
		luaJM13CheckHQ()
		luaJM13AKChecker()
		luaJM13CargoAttacker()
		luaJM13WhereWasI()
		--luaJM13EmptyBaseChecker()
		luaJM13LandingIndicator()
	elseif Mission.MissionPhase == 2 then

		luaJM13CheckHQ()
		if Mission.C47Done then
			luaJM13CheckPlayer()
			luaJM13CheckPara()
			luaJM13CheckRecapt()
		end

		luaJM13CheckObjectives()

	elseif Mission.MissionPhase == 3 then
		--[[luaJM13CheckPlayer()
		luaJM13CheckObjectives()
		luaJM13TryLanding()
		luaJM13CheckRecapt()]]--
		if Mission.FirstRun then
			Mission.FirstRun = false
			--Blackout(true, "luaJM13EztMajdKiKellKotni", 1.5)
		end

		luaJM13CheckObjectives()

	elseif Mission.MissionPhase == 4 then
		--[[if Mission.C47Done then
			luaJM13CheckPlayer()
			luaJM13CheckPara()
			luaJM13CheckRecapt()
		end

		luaJM13CheckObjectives()]]

		luaJM13CheckRecapt()
		luaJM13CheckPlayer()
		luaJM13TryLanding()
		luaJM13CheckObjectives()

	elseif Mission.MissionPhase == 5 then
		--luaJM13CheckPlayer()
		luaJM13KillAllOther()
		luaJM13CheckObjectives()
		luaJM13Harrass()
		--luaJM13AmmoShipChecker()
		--luaJM13CheckRecapt()


	elseif Mission.MissionPhase == 99 then
		Mission.EndMission = true
		local endEnt
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			if Mission.FailMsg == "ijn13.obj_missionfailed_para" then
				if Mission.Dakota and not Mission.Dakota.Dead then
					endEnt = Mission.Dakota
				elseif Mission.Dakota2 and not Mission.Dakota.Dead2 then
					endEnt = Mission.Dakota2
				end
			else
				endEnt = Mission.PlayerUnit
			end
		else
			endEnt = nil
		end

		if Mission.MissionFailed then
			luaMissionFailedNew(endEnt, Mission.FailMsg)
			luaJM13StepPhase()
		end

		if Mission.MissionCompleted then
			luaMissionCompletedNew(nil, "ijn13.obj_missioncomp")

			local medal = luaGetMedalReward()
			if medal == MEDAL_GOLD then
				Scoring_GrantBonus("JM13_SCORING_GOLD", "ijn13.bonus1_title", "ijn13.bonus1_text", 58)
			end

			luaJM13StepPhase()
		end

		--Mission.EndMission = true
	end

end


function luaJM13SpawnPlayerUnit()
	--luaLog("PlayerSpawned "..debug.traceback())
		
	Mission.SpawnCounter = Mission.SpawnCounter + 1

	if Mission.SpawnCounter > Mission.MaxSpawns then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn13.obj_missionfailed_toomany"
		luaJM13StepPhase(99)
		return
	end


	local spawnPos
	local lookAt

	--[[if not Mission.IJNCarrier or Mission.IJNCarrier.Dead then
-- RELEASE_LOGOFF  		luaLog("spawn aborted carriers are dead")
		if Mission.MissionPhase == 1 then
			return
		end
	end]]

	local cType = 150
	local eq = nil
	--local refPoint
	--local lookAt

	--[[if Mission.MissionPhase == 1 then
		--cType = 150
		eq = 1
		--refPoint = GetPosition(Mission.IJNCarrier)
		--refPoint.y = 150
		--lookAt = GetPosition(Mission.LookAt)
	elseif Mission.MissionPhase == 2 then
		--cType = 150
		eq = nil
-- RELEASE_LOGOFF  		luaLog("sima Zero")
	else
		--cType = 45
		eq = nil
		--refPoint = GetPosition(Mission.LookAt)
		--refPoint.y = 150
		--lookAt = GetPosition(Mission.USNTransports[1])
-- RELEASE_LOGOFF  		luaLog("kamikaze Zero")
	end]]

	if Mission.MissionPhase == 1 then

		spawnPos = Mission.LastPos
		lookAt = Mission.LastLookAt
		spawnPos.y = 150

		if IsInBorderZone(Mission.LastPos) then
			Mission.LastPos = Mission.LookAt
		end

		if Mission.LastPos and not luaIsCoordinate(Mission.LastPos) then
			Mission.LastPos = GetPosition(Mission.LastPos)
		end

	elseif Mission.MissionPhase == 2 then
		spawnPos = GetPosition(Mission.PlayerSpawnForDakota)
		spawnPos.y = 1000
		if Mission.Dakota and not Mission.Dakota.Dead then
			lookAt = GetPosition(Mission.Dakota)
		else
			lookAt = Mission.LastLookAt
		end

	elseif Mission.MissionPhase == 3 or Mission.MissionPhase == 4 then
		Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)

		spawnPos = GetPosition(Mission.PlayerSpawnForAK)
		spawnPos.y = 150

		if Mission.USNTransports[1] and not Mission.USNTransports[1].Dead then
			lookAt = GetPosition(Mission.USNTransports[1])
		else
			lookAt = Mission.LastLookAt
		end
	elseif Mission.MissionPhase == 5 then
		spawnPos = GetPosition(Mission.PlayerSpawnForAmmoShip)
		spawnPos.y = 150

		if Mission.AmmoShip and not Mission.AmmoShip.Dead then
			lookAt = GetPosition(Mission.AmmoShip)
		else
			lookAt = Mission.LastLookAt
		end
	end


	--spawnPos.y = 150

	--luaLog("Mission.LastPos")
	--luaLog(Mission.LastPos)
	--luaLog("Mission.LastLookAt")
	--luaLog(Mission.LastLookAt)
	--luaLog("spawnPos")
	--luaLog(spawnPos)
	--luaLog("lookAt")
	--luaLog(lookAt)

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
			{
				["Type"] = cType,
				["Name"] = "A6M Zero",
				["Equipment"] = eq,
				["Crew"] = 2,
				["Race"] = JAPANESE,
				["Velocity"] = 400.0,
				["WingCount"] = 3,
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
		["refPos"] = spawnPos,
		["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
		["lookAt"] = lookAt,
	},
	["callback"] = "luaJM13PlayerSpawned",
	["id"] = Mission.PlayerSpawnReq,
	})
end

function luaJM13PlayerSpawned(unit)
	--luaLog("Spawn CB")
	SquadronSetSpeed(unit, 77.8)
	SquadronSetTravelSpeed(unit, 77.8)
	AddUntouchableUnit(unit)
	SetInvincible(unit, true)
	--luaJM13AddKillListener(unit)
	luaDelay(luaJM13RemoveUntouch,5)
	Mission.PlayerUnit = unit
	--MissionNarrativeUrgent("New squadron at your service")
	--SquadronSetTravelAlt(unit, 150)
	SetSelectedUnit(unit)

	if Mission.Dakota and not Mission.Dakota.Dead then
		PilotSetTarget(unit, Mission.Dakota)
		PilotMoveTo(unit, Mission.Dakota)
	end

	if Mission.MissionPhase == 4 then
		SetGuiName(unit, "globals.unitclass_kamikazezero")
		local trg = luaRemoveDeadsFromTable(Mission.USNTransports)[1]
		if trg and not trg.Dead then
			PilotSetTarget(unit, trg)
		end

		if IsListenerActive("hit", "kamikazeCheat") then
			RemoveListener("hit", "kamikazeCheat")
			luaDelay(luaJM13KamikazeCheat, 1)
		else
			luaDelay(luaJM13KamikazeCheat, 1)
		end
	elseif Mission.MissionPhase == 5 then
		SetGuiName(unit, "globals.unitclass_kamikazezero")
		if Mission.AmmoShip and not Mission.AmmoShip.Dead then
			PilotSetTarget(unit, Mission.AmmoShip)
		end

		if IsListenerActive("hit", "kamikazeCheat") then
			RemoveListener("hit", "kamikazeCheat")
			luaDelay(luaJM13KamikazeCheat, 1)
		else
			luaDelay(luaJM13KamikazeCheat, 1)			
		end

	end

	--Mission.MovieEnd = false
	--Mission.Roled = false
end

function luaJM13RemoveUntouch()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		if IsUnitUntouchable(Mission.PlayerUnit) then
			RemoveUntouchableUnit(Mission.PlayerUnit)
			SetInvincible(Mission.PlayerUnit, false)
		end
	end
end

function luaJM13AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrative("missionglobals.newpowerup")
end

function luaJM13RAD(x)
	return x *  0.0174532925
end

function luaJM13CheckObjectives()

	--[[if table.getn(luaRemoveDeadsFromTable(Mission.IJNTroops)) == 0 then
		Mission.FailMsg = "No more troop transports"
		Mission.MissionFailed = true
		luaJM13StepPhase(99)
	end

	if not Mission.IJNCarrier or Mission.IJNCarrier.Dead then
		Mission.FailMsg = "Your carrier is dead"
		Mission.MissionFailed = true
		luaJM13StepPhase(99)
	end]]--

	if Mission.MissionPhase > 0 then
		luaJM13CheckHidden()

		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.USNFleet)) == 0 then
				luaObj_Completed("secondary",1)
				luaJM13SecCompCam()
			else
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNFleet)) do
					if IsInBorderZone(unit) then
						luaObj_Failed("secondary",1)
						MissionNarrative("ijn13.obj_s1_fail")
					end
				end
			end
		end
	end


	if Mission.MissionPhase == 1 then
		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1,Mission.AlphaGuns)
			--luaObj_AddUnit("primary",1, GetPosition(Mission.CB))
			--luaObj_AddUnit("primary",1, GetPosition(Mission.CC))
			luaJM13AssistHint()
			--luaObj_AddReminder("primary",1)
		else
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				if Mission.CB.Party == PARTY_JAPANESE --[[ and Mission.CC.Party == PARTY_JAPANESE]] then

					for i,v in pairs(luaRemoveDeadsFromTable(Mission.AlphaGuns)) do
						if v.Class.Type == "LandFort" then
							SetParty(v, PARTY_JAPANESE)
						end
					end

					luaObj_Completed("primary",1,true)
					HideScoreDisplay(1,0)
					HideScoreDisplay(2,0)
					--for i,v in pairs(luaRemoveDeadsFromTable(Mission.CoastalGuns)) do
						--luaObj_RemoveUnit("marker2", 1, v)
					--end
					luaJM13StartDialog("BasesCaptured")
					--Blackout(true, "luaJM13Checkpoint1", 1)
					--luaJM13StartDialog("GoHome")
					--luaJM13StepPhase()
				else
					luaJM13LandingIndicator()
				end
			end
		end


	elseif Mission.MissionPhase == 2 then

		if not luaObj_IsActive("primary",3) then
			if not Mission.C47Added then
				Blackout(true, "luaJM13InitDakota", 2)
				Mission.C47Added = true
			end
			luaDelay(luaJM13ParaHint, 3)
		else
			if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then

				if Mission.SecPhaseC47Done then
					if Mission.Dakota.Dead and Mission.Dakota2.Dead then
						luaObj_Completed("primary",3,true)
						luaJM13StartDialog("C47Done")
						luaJM13StepPhase()
					end

					if Mission.Dakota and not Mission.Dakota.Dead then
						if GetPlaneIsReloading(Mission.Dakota) then
							Mission.MissionFailed = true
							Mission.FailMsg = "ijn13.obj_missionfailed_para"
							--luaJM13StartDialog("C47Done")
							luaJM13StepPhase(99)
						end
					end

					if Mission.Dakota2 and not Mission.Dakota2.Dead then
						if GetPlaneIsReloading(Mission.Dakota2) then
							Mission.MissionFailed = true
							Mission.FailMsg = "ijn13.obj_missionfailed_para"
							--luaJM13StartDialog("C47Done")
							luaJM13StepPhase(99)
						end
					end
				else
					if Mission.Dakota and not Mission.Dakota.Dead then
						if GetPlaneIsReloading(Mission.Dakota) then
							Mission.MissionFailed = true
							Mission.FailMsg = "ijn13.obj_missionfailed_para"
							--luaJM13StartDialog("C47Done")
							luaJM13StepPhase(99)
						end
					end
				end
			end
		end

	elseif Mission.MissionPhase == 3 then
			luaJM13StepPhase()
	elseif Mission.MissionPhase == 4 then
		if Mission.Mehet then
			if not luaObj_IsActive("primary",2) then
				Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)
				Mission.Roled = false
				--luaLog("transport db: "..tostring(table.getn(Mission.USNTransports)))
				--luaLog(Mission.MissionPhase)
				luaObj_Add("primary",2,Mission.USNTransports)
				luaJM13Pri2Score()
				luaJM13KamikazeHint()
				luaDelay(luaJM13StrafeHint, 30)
				--luaObj_AddReminder("primary",2)
				--luaJM13StartDialog("Kamikaze")
				--luaJM13KamikazeCheat(Mission.USNTransports)

				if Mission.USNTransports[1] and not Mission.USNTransports[1].Dead then
					NavigatorAttackMove(Mission.USNTransports[1], Mission.CB, {})
				end

				if Mission.USNTransports[2] and not Mission.USNTransports[2].Dead then
					NavigatorAttackMove(Mission.USNTransports[2], Mission.CB, {})
				end

				if Mission.USNTransports[3] and not Mission.USNTransports[3].Dead then
					--NavigatorAttackMove(Mission.USNTransports[3], Mission.CC, {})
				end
			else
				if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
					if table.getn(luaRemoveDeadsFromTable(Mission.USNTransports)) == 0 then
						--[[local fail
						for i,v in pairs(Mission.USNTransports) do
							if v.Dead and v.KillReason == "soft" then
								fail = true
							end
						end
						
						if not fail then]]
							luaObj_Completed("primary",2,true)
							HideScoreDisplay(999,0)
						--luaJM13StepPhase()
							Blackout(true, "luaJM13Checkpoint2", 1)
						--end
					else
						luaJM13Pri2Score()
					end
				end
			end
		end

	elseif Mission.MissionPhase == 5 then
		if not luaObj_IsActive("primary",4) then
			if not Mission.AmmoShipAdded then
				--Blackout(true, "luaJM13InitAmmoShip", 2)
				luaJM13GenerateFinalFleet()
				luaJM13LastplaneHint()
				Mission.AmmoShipAdded = true
			end
		else
			if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
				if Mission.AmmoHit then
					luaObj_Completed("primary",4)
					--luaJM13EndMovie()
					Mission.MissionCompleted = true
					luaJM13StepPhase(99)
				else
					luaJM13CheckLastPlane()
				end
			end
		end
	end

	--[[
	elseif Mission.MissionPhase == 99 then

		local endEnt
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			endEnt = Mission.PlayerUnit
		else
			endEnt = nil
		end

		if Mission.MissionFailed then
			luaMissionFailedNew(endEnt, Mission.FailMsg)
			luaJM13StepPhase()
		end

		if Mission.MissionCompleted then
			luaMissionCompletedNew(endEnt, "missionglobals.obj_compl")
			luaJM13StepPhase()
		end
	end
	]]

end

function luaJM13DlgCBChkp()
	Blackout(true, "luaJM13Checkpoint1", 1)
end

function luaJM13Checkpoint1()
	luaCheckpoint(1,nil)
	luaJM13StepPhase()
	--Blackout(false, "", 1)
end

function luaJM13Checkpoint2()
	luaCheckpoint(2,nil)
	--Blackout(false, "", 1)
	luaJM13StepPhase()
end

function luaJM13StepPhase(phase)
	if phase ~= nil and type(phase) == "number" then
		--luaLog("Setting phase to "..tostring(phase))
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM13StartDialog(dialogID, log, ignorePrinted)
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
		--luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaPrecacheUnits()
	--Blackout(true,"",true)
	Loading_Start()
	PrepareClass(151)
	PrepareClass(150)
	PrepareClass(45)
	PrepareClass(38)
	PrepareClass(113)
	PrepareClass(136)
	PrepareClass(101)
	PrepareClass(104)
	PrepareClass(108)
	Loading_Finish()
end

function luaJM13CheckHidden()
	--luaLog("hiddent csekkolom")
	local dist

	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	elseif luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.PrisonGuns)) == 0 then
				if not Mission.VoltMar then
					Mission.VoltMar = true
					--local hdnName = luaFindHidden("RescuePlane")
					--Mission.RescuePlane = GenerateObject(hdnName.Name, "RescuePlane")
					--SetRoleAvailable(Mission.RescuePlane, EROLF_ALL, PLAYER_AI)
					--SetGuiName(Mission.RescuePlane, "ijn13.rescue")
					--SquadronSetTravelAlt(Mission.RescuePlane, 100)
					--SetInvincible(Mission.RescuePlane, 0.1)
					--PilotMoveOnPath(Mission.RescuePlane, Mission.RescuePath)
					luaObj_Completed("hidden", 1, true)
					--luaJM13AddPowerup("evasive_manoeuvre")
				end
			end
	--[[else
		if Mission.RescuePlane and not Mission.RescuePlane.Dead then
			if Mission.Prison and not Mission.Prison.Dead then
				dist = luaGetDistance(Mission.RescuePlane, Mission.Prison)
-- RELEASE_LOGOFF  				luaLog("TAVOLSAG: "..dist)
				if dist < 300 then
					Mission.EscapePos = GetClosestBorderZone(GetPosition(Mission.RescuePlane))
					PilotMoveTo(Mission.RescuePlane, GetClosestBorderZone(GetPosition(Mission.RescuePlane)))
				end
			end
		end]]
	end
end

function luaJM13SetGuiNames()
	--luaLog("allitom a guineveket")
end

function luaJM13Invasion()
	luaJM13StartDialog("Init")
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNFleet)) do
		--local trg
		--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--SetSkillLevel(unit, SKILL_ELITE)
		--NavigatorStop(unit)
		--UnitSetFireStance(unit, 0) -- MERESHEZ DEBUG, KI KELL MAJD SZEDNI!!!!!
		--UnitFreeFire(unit)

		if unit.Class.Type == "Cargo" then
			local err = StartLanding2(unit)

			if err > 0 then
				--luaLog(unit.Name.." inditott "..tostring(err).." hajot")
			else
				--luaLog(unit.Name.." nem tud hajot inditani, mert: "..Mission.LandingDebug[tostring(err)])
			end
		end
	end
end


function luaJM13StartRaidens()
	for idx,unit in pairs(Mission.Raidens) do
		UnitHoldFire(unit)
		SetPlaneGears(unit, GEARS_UP)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SquadronSetTravelAlt(unit, 50)
		SquadronSetAttackAlt(unit, 50)
		luaSetScriptTarget(unit, Mission.CB)
		PilotSetTarget(unit, Mission.CB)
		PilotMoveTo(unit, Mission.CB)
	end

	--[[for idx,unit in pairs(Mission.USNPlanes) do
		SquadronSetTravelAlt(unit, 50)
		SquadronSetAttackAlt(unit, 50)
	end]]
end


function luaJM13GenerateEscapist()
	--luaLog("generaltam")
	--luaLog("meghivta: "..debug.traceback())
	for idx,ship in pairs(luaRemoveDeadsFromTable(Mission.USNFleet)) do
		--local ship = GenerateObject(unit.Name, unit.Name)
		AddUntouchableUnit(ship)
		--table.insert(Mission.USNFleet, ship)
		local exitPos = GetPosition(FindEntity("Exit"))
		NavigatorMoveToPos(ship, exitPos)
	end

	Mission.USNFleet = luaRemoveDeadsFromTable(Mission.USNFleet)

	if not luaObj_IsActive("secondary",1) then
		luaObj_Add("secondary",1,Mission.USNFleet)
		--luaObj_AddReminder("secondary",1)
		luaJM13StartDialog("Escaping")
	end

end

function luaJM13EndMovieListener(callback)
	AddListener("input", "movielistenerID", {
		["callback"] = callback,  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
end


function luaJM13CheckPlayer()

	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead and not Mission.AmmoHit then
		--luaLog("spawnolom az uj repcsit")

		if Mission.MissionPhase == 3 or Mission.MissionPhase == 4 then

			ForceRecon()
			local ijn = luaGetOwnUnits()

			if ijn and not Mission.Roled then
				for i,v in pairs(ijn) do --mit erdemel az a scripter: for i,v in pairs()
					if v.Class.ID ~= 45 then
						--luaLog("elvettem a rolet")
						--SetRoleAvailable(v, EROLF_ALL, PLAYER_AI)
					end
				end
				--luaLog("elveszem a rolet")
				Mission.Roled = true
			end
		end
		luaDelay(luaJM13SpawnPlayerUnit, 1)
	end
end

function luaJM13EztMajdKiKellKotni()

	--luaLog("luaJM13EztMajdKiKellKotni")
	--luaLog("Meghivta: "..debug.traceback())

	for idx,unit in pairs(Mission.USNAttackerNames) do
		if idx ~= 10 then
			local ship = GenerateObject(unit.Name, unit.Name)
			table.insert(Mission.USNAttackers, ship)
			SetGuiName(ship, Mission.USNAttackerNamesNames[idx])
			SetNumbering(ship, Mission.ShipNumbers[idx])

			--if ship.Class.Type == "MotherShip" then
				--table.insert(Mission.USNCarriers, ship)
				--SetInvincible(ship, 0.1)
			if ship.Class.Type == "Cargo" or ship.Class.Type == "LandingShip" then
				table.insert(Mission.USNTransports, ship)
				UnitHoldFire(ship)
				NavigatorMoveToRange(ship, Mission.CB)
			end

			AddUntouchableUnit(ship)
			--[[if Mission.Difficulty == 2 then
				SetSkillLevel(ship, SKILL_NORMAL)
			else
				SetSkillLevel(ship, SKILL_STUN)
			end]]

			--[[if idx == 11 then
				Mission.AmmoShip = ship
				SetGuiName(Mission.AmmoShip, "ijn13.ammoship")
			end]]--
		end
	end

	--luaLog("tablak elvileg feltoltve, phase: "..tostring(Mission.MissionPhase))
	PutTo(Mission.IJNCarrier, GetPosition(Mission.RePos), 90)

	for idx, ship in pairs(luaRemoveDeadsFromTable(Mission.IJNFleet)) do
		Kill(ship, false)
	end

	Mission.IJNFleet = luaRemoveDeadsFromTable(Mission.IJNFleet)

	for idx, unit in pairs(Mission.SecNames) do
		local ship = GenerateObject(unit.Name, unit.Name)
		table.insert(Mission.IJNFleet, ship)

		SetRoleAvailable(ship, EROLF_ALL, PLAYER_AI)
		SetGuiName(ship, Mission.SecNamesNames[idx])
		NavigatorMoveToPos(ship, GetPosition(Mission.Exit))

		if ship.Class.Type == "MotherShip" then
			Mission.IJNCarrier = ship
		end
	end

	--luaLog("CSEKKPOJNTLODID "..tostring(Mission.SavedCheckpoint))
	if not Mission.SavedCheckpoint then
		Blackout(false, "", 2)
	end

	--if not Mission.SavedCheckpoint then
	if Mission.Checkpoint.CheckPoint.Num[1] == 1 then
		luaJM13FleetCam()
	end

end

function luaJM13FleetCam()
	Mission.ThinkStop = true
	--luaLog("FLEETCAM START: "..tostring(GameTime()))
	--luaLog("MEGHIVTA: "..debug.traceback())
	--[[luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 150, ["theta"] = 15, ["rho"] = 240, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 250, ["theta"] = 15, ["rho"] = 240, ["moveTime"] = 3},
		},	luaJM13FleetCamCB, true)]]

		luaJM13FleetCamCB()
end

function luaJM13FleetCamCB()
	SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
					{
						["Type"] = 113,
						["Name"] = "TBF Avenger",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 3,
						["Velocity"] = 400.0,
						["Equipment"] = 1,
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
				["refPos"] = GetPosition(Mission.RePos),
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.IJNCarrier)
			},
			["callback"] = "luaJM13TorpSpawned",
			})


	--[[for idx, unit in pairs(luaRemoveDeadsFromTable(Mission.Raidens)) do
		if unit.Class.ID == 150 then
			lastPos = GetPosition(unit)

			Kill(unit, true)
			lastPos.y = 150

			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
					{
						["Type"] = 45,
						["Name"] = "A6M Zero",
						["Crew"] = 1,
						["Race"] = JAPANESE,
						["WingCount"] = 1,
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
				["refPos"] = lastPos,
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.LookAt)
			},
			["callback"] = "luaJM13PlaneChanged",
			})
		end
	end]]

	Blackout(false, "luaJM13AmbushCam", 2)
	--Blackout(false, "", 2)
	--luaLog("FLEETCAM END: "..tostring(GameTime()))
end


function luaJM13AmbushCam()
	--luaLog("Ambushcam start: "..tostring(GameTime()))
	--luaJM13StartDialog("GoHome")

	Mission.ThinkStop = true
	--if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		--Kill(Mission.PlayerUnit, true)
	--end

	--Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)
	--local lastPos = ORIGO
	--local lookAt = ORIGO

	--lastPos.y = 1500

		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
					{
						["Type"] = 45,
						["Name"] = "A6M Zero",
						["Crew"] = 2,
						["Race"] = JAPANESE,
						["Velocity"] = 400.0,
						["WingCount"] = 1,
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
				["refPos"] = GetPosition(Mission.DakotaSpawn2),
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.DakotaSpawn)
			},
			["callback"] = "luaJM13DodiCB",
		})
end


function luaJM13DodiCB(unit)
	Mission.MoziUnit = unit
	SetInvincible(unit, true)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	SetSkillLevel(unit, SKILL_ELITE)
	SquadronSetTravelAlt(unit, 150)
end

function luaJM13TorpSpawned(unit)

	SetInvincible(unit, true)
	SetSkillLevel(unit, SKILL_ELITE)
	PilotSetTarget(unit, Mission.IJNCarrier)
	luaSetScriptTarget(unit, Mission.IJNCarrier)
	Mission.MovieAvenger = unit

	if Mission.IJNCarrier and not Mission.IJNCarrier.Dead then
		AddListener("hit", "carrierHit", {
			["callback"] = "luaJM13CarrierHit", -- callback fuggveny
			["target"] = {Mission.IJNCarrier}, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
	end

	--luaLog("torpcam start: "..tostring(GameTime()))
	luaJM13StartDialog("GoHome")
	luaIngameMovie(
	{
	   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 4},

		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-280,["y"]=3,["z"]=10},["parent"] = Mission.IJNCarrier,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=30,["y"]=3,["z"]=10},["parent"] = Mission.IJNCarrier,},["moveTime"] = 0,["transformtype"] = "keepall"},

		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-50,["y"]=30,["z"]=200},["parent"] = Mission.IJNCarrier,},["moveTime"] = 6,["transformtype"] = "keepall",},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=30,["y"]=30,["z"]=10},["parent"] = Mission.IJNCarrier,},["moveTime"] = 6,["transformtype"] = "keepall",},

		{["postype"] = "cameraandtarget", ["position"] = {}, ["moveTime"] = 0, ["transformtype"] = "keepall",},




   }, luaJM13AvengerMovie, nil, nil, false)

end

function luaJM13CarrierHit(...)
	if arg[4] == "TORPEDO" then
		RemoveListener("hit", "carrierHit")
		luaJM13StartDialog("Ambush")
		SetInvincible(Mission.IJNCarrier, false)
		--AddDamage(Mission.IJNCarrier, 999999)
		Effect("ExplosionBigShip", ORIGO, Mission.IJNCarrier)
		Effect("ExplosionMagazine", ORIGO, Mission.IJNCarrier)
		--luaDelay(luaJM13IngameMovieEnd, 3)
		--BreakShip(Mission.IJNCarrier)
	end

	--luaDelay(luaJM13AvengerMovie, 6)
end

function luaJM13AvengerMovie()

	--luaLog("avenger movie")

	luaDelay(luaJM13DelayedExplodeToParts, 3)

	luaIngameMovie(
	{
  	    {["postype"] = "cameraandtarget", ["target"] = Mission.MovieAvenger, ["distance"] = 20, ["theta"] = 2, ["rho"] = 5, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.MovieAvenger, ["distance"] = 30, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 10},

    }, luaJM13TroopMovie, nil, nil, false)

end

function luaJM13DelayedExplodeToParts()
	local trTbl = {["x"]=0,["y"]=-25,["z"]=0,}
	local rotTbl = {["x"]=2,["y"]=0,["z"]=2,}

	if Mission.IJNCarrier and not Mission.IJNCarrier.Dead then
		Effect("ExplosionBigShip", ORIGO, Mission.IJNCarrier)
		--ExplodeToParts(Mission.IJNCarrier)
		DisablePhysics(Mission.IJNCarrier)
		AddMatrixInterpolator(Mission.IJNCarrier, trTbl, rotTbl, 300)
	end
end

function luaJM13TroopMovie()
	Mission.ThinkStop = true

	if Mission.IJNCarrier and not Mission.IJNCarrier.Dead then
		--Kill(Mission.IJNCarrier,true)
	end

	if Mission.MovieAvenger and not Mission.MovieAvenger.Dead then
		SetInvincible(Mission.MovieAvenger, false)
	end

	Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)

	if not Mission.USNTransports[1] or Mission.USNTransports[1].Dead then
		luaJM13IngameMovieEnd()
		Mission.ThinkStop = false
		return
	end

	AAEnable(Mission.USNTransports[1], true)
	NavigatorStop(Mission.USNTransports[1])

	luaJM13KamikazeCheat()

	if Mission.MoziUnit and not Mission.MoziUnit.Dead then
		SetInvincible(Mission.MoziUnit, true)
		PutRelTo(Mission.MoziUnit, Mission.USNTransports[1], {["x"]=1600,["y"]=150,["z"]=300}, -180)
		PilotSetTarget(Mission.MoziUnit, Mission.USNTransports[1])
		luaJM13KamikazeCheatMozi()
		luaDelay(luaJM13SetMovieUnitVulnerable, 10)
	end



	luaIngameMovie(
	{
  	    {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 300, ["theta"] = 50, ["rho"] = 160, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 400, ["theta"] = 10, ["rho"] = 210, ["moveTime"] = 8},
  	    {["postype"] = "cameraandtarget", ["target"] = Mission.MoziUnit, ["distance"] = 30, ["theta"] = 2, ["rho"] = 150, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.MoziUnit, ["distance"] = 30, ["theta"] = 2, ["rho"] = 150, ["moveTime"] = 6},
  	    {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 500, ["theta"] = 50, ["rho"] = 160, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.USNTransports[1], ["distance"] = 200, ["theta"] = 30, ["rho"] = 100, ["moveTime"] = 8},
    }, luaJM13IngameMovieEnd)
end

function luaJM13SetMovieUnitVulnerable()
	if Mission.MoziUnit and not Mission.MoziUnit.Dead and IsInvincible(Mission.MoziUnit) then
		SetInvincible(Mission.MoziUnit, false)
	end
end


function luaJM13PlaneChanged(unit)
	table.insert(Mission.Raidens, unit)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
end

function luaJM13PlayerPlaneChanged(unit)
	Mission.PlayerUnit = unit
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
	SetSelectedUnit(unit)
	EnableInput(true)
	--Blackout(false, "", 2)
	--luaJM13StartDialog("Ambush")
	--luaJM13StepPhase(3)
end

function luaJM13TryLanding()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNTransports)) do
		local err = StartLanding2(unit)

		if err > 0 then
			--luaLog(unit.Name.." inditott "..tostring(err).." hajot")
		else
			--luaLog(unit.Name.." nem tud hajot inditani, mert: "..Mission.LandingDebug[tostring(err)])
		end
	end
end

function luaJM13CheckEnemyPlanes()
	local planeTbl = {26, 102, 135}

	if table.getn(luaRemoveDeadsFromTable(Mission.USNPlanes)) < 3 then
		local idx = random(1,table.getn(planeTbl))
		local eq = random(0,1)

		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
					{
						["Type"] = planeTbl[idx],
						--["Name"] = "A6M Zero",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 1,
						["Equipment"] = eq,
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
				["refPos"] = GetPosition(Mission.Exit),
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.LookAt)
			},
			["callback"] = "luaJM13EnemyPlaneSpawned",
		})
	end
end

function luaJM13EnemyPlaneSpawned(unit)
	table.insert(Mission.USNPlanes, unit)
	PilotMoveTo(Mission.CB)
end

function luaJM13WhereWasI()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then

		Mission.LastPos = GetPosition(Mission.PlayerUnit)
		local lookat = GetPosition(Mission.PlayerUnit)
		local rot = GetRotation(Mission.PlayerUnit)

		lookat.x = lookat.x - math.sin(rot.y) * 100
		lookat.z = lookat.z + math.sin(rot.y) * 100
		lookat.y = 150

		Mission.LastLookAt = lookat

		--Mission.LastLookAt.z = Mission.LastLookAt.z + 200
	end
end

function luaJM13InitDakota()

	--luaLog("spawning dakota")
	local refPos = GetPosition(Mission.DakotaSpawn)
	refPos.y = 1500

	SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
					{
						["Type"] = 136,
						["Name"] = "C47 Dakota",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 3,
						["Velocity"] = 400.0,
						["Equipment"] = 1,
					},
					{
						["Type"] = 104,
						["Name"] = "P38",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 3,
						["Velocity"] = 400.0,
						["Equipment"] = nil,
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
				["refPos"] = refPos,
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.CB)
			},
			["callback"] = "luaJM13DakotaSpawned",
		})
end

function luaJM13DakotaSpawned(...)

	if Mission.CheckpointLoaded then
		--luaJM13DisableAfterChkp()
	end

	for i,unit in ipairs(arg) do
		if unit.Class.Type == "LevelBomber" then
			Mission.Dakota = unit
			PilotMoveTo(unit, Mission.CB)
			PilotSetTarget(unit, Mission.CB)

		else
			Mission.FighterEscort = unit
			--SquadronSetAttackAlt(unit, 1500)
			--SquadronSetTravelAlt(unit, 1500)

			if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
				PilotMoveTo(unit, Mission.PlayerUnit)
				PilotSetTarget(unit, Mission.PlayerUnit)
			else
				PilotMoveTo(unit, Mission.CB)
				PilotSetTarget(unit, Mission.CB)
			end
		end

		SquadronSetSpeed(unit, 100.0)
		SquadronSetTravelSpeed(unit, 100.0)


	end
	--Blackout(false, "", 1)

	--luaLog("dakota spawned")

--	Mission.SelectedUnit = GetSelectedUnit()
--	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		--SetInvincible(Mission.SelectedUnit, true)
	--end


	--if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		--Kill(Mission.PlayerUnit, true)
	--end

	luaDelay(luaJM13ParaDlg, 6)

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 100, ["theta"] = 15, ["rho"] = 20, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 200, ["theta"] = 15, ["rho"] = 150, ["moveTime"] = 14},
		},	luaJM13DakotaCamCB, true)


end

function luaJM13InitDakotaSecondWave()

	--luaLog("spawning dakota 2")
	local refPos = GetPosition(Mission.DakotaSpawn2)
	refPos.y = 1500

	SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
					{
						["Type"] = 136,
						["Name"] = "C47 Dakota",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 3,
						["Velocity"] = 400.0,
						["Equipment"] = 1,
					},
					{
						["Type"] = 104,
						["Name"] = "P38",
						["Crew"] = 2,
						["Race"] = USA,
						["WingCount"] = 3,
						["Velocity"] = 400.0,
						["Equipment"] = nil,
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
				["refPos"] = refPos,
				["angleRange"] = { luaJM13RAD(180), luaJM13RAD(270)},
				["lookAt"] = GetPosition(Mission.CB)
			},
			["callback"] = "luaJM13Dakota2Spawned",
		})
end

function luaJM13Dakota2Spawned(...)

	for i,unit in ipairs(arg) do
		if unit.Class.Type == "LevelBomber" then
			Mission.Dakota2 = unit
			PilotMoveTo(unit, Mission.CB)
			PilotSetTarget(unit, Mission.CB)

		else
			Mission.FighterEscort2 = unit
			--SquadronSetAttackAlt(unit, 1500)
			--SquadronSetTravelAlt(unit, 1500)

			if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
				PilotMoveTo(unit, Mission.PlayerUnit)
				PilotSetTarget(unit, Mission.PlayerUnit)
			else
				PilotMoveTo(unit, Mission.CB)
				PilotSetTarget(unit, Mission.CB)
			end
		end

		SquadronSetSpeed(unit, 100.0)
		SquadronSetTravelSpeed(unit, 100.0)
	end

	--luaLog("dakota 2 spawned")

	luaObj_AddUnit("primary",3,Mission.Dakota2)

	SetForcedReconLevel(Mission.Dakota2, 2, PARTY_JAPANESE)
	Mission.SecPhaseC47Done = true
end


function luaJM13ParaDlg()
	luaJM13StartDialog("Paratroopers")
end

function luaJM13DakotaCamCB()

	--[[if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		PutTo(Mission.PlayerUnit, GetPosition(Mission.LookAt))
		PilotSetTarget(Mission.PlayerUnit, Mission.Dakota)
		SetSelectedUnit(Mission.PlayerUnit)
	end]]--
	--luaJM13SpawnPlayerUnit()
	Blackout(false, "", 2)
	--SetSelectedUnit(Mission.PlayerUnit)
	EnableInput(true)

	luaObj_Add("primary",3,Mission.Dakota)
	luaObj_AddReminder("primary",3)

	Mission.C47Done = true
	--SetSelectedUnit(Mission.PlayerUnit)

	--luaLog("dakota tamadas prequel")
	--luaLog(Mission.PlayerUnit.Name)

	luaDelay(luaJM13DelayedAttack, 10)
	SetForcedReconLevel(Mission.Dakota, 2, PARTY_JAPANESE)
	luaDelay(luaJM13InitDakotaSecondWave, Mission.DiffDelay)
	luaJM13AddPowerup("full_throttle")
	luaJM13IngameMovieEnd()
	--luaJM13StepPhase(5)
end

function luaJM13DelayedAttack()
	ForceRecon()

	for i,unit in pairs(luaRemoveDeadsFromTable(recon[PARTY_ALLIED].own.fighter)) do
		--luaLog("attackom?")
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			PilotMoveTo(unit, Mission.PlayerUnit)
			PilotSetTarget(unit, Mission.PlayerUnit)
		end
	end
end


function luaJM13CheckRecapt()
	if Mission.CB.Party == PARTY_ALLIED --[[and Mission.CC.Party == PARTY_ALLIED]] then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn13.obj_missionfailed_recap"
		luaJM13StepPhase(99)
	end
end

function luaJM13JunkTrafficInit()
	local nearestpath

	if not IsListenerActive("command","junklistener") then
		AddListener("command", "junklistener", {
			["callback"] = "luaJM13JunkTraffic",  -- callback fuggveny
			["entity"] = Mission.Junks, -- entityk akiken a listener aktiv
			["target"] = {}, -- a vizsgalt command celpontja
			["command"] = {"moveonpath"}, -- vizsgalt command pl. "moveonpath" (string)
			["status"] = {"finish"}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
		})
	end


	for idx, junk in pairs(luaRemoveDeadsFromTable(Mission.Junks)) do
		nearestpath = luaSortByDistance(junk, Mission.JunkPaths)[1]
		NavigatorMoveOnPath(junk, nearestpath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	end
end

function luaJM13JunkTraffic(junk)

	local nearestpath = luaSortByDistance(junk, Mission.JunkPaths)[1]
	NavigatorMoveOnPath(junk, nearestpath, PATH_FM_SIMPLE, PATH_SM_JOIN)

end

function luaJM13InitAmmoShip()
	if Mission.CheckpointLoaded then
		--luaJM13DisableAfterChkp()
	end

	Mission.ThinkStop = true
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNAttackers)) do
		AAEnable(unit, false)
	end

	--[[Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end]]


	luaJM13StartDialog("LastBattle")
	NavigatorStop(Mission.AmmoShip)
	luaJM13StartDialog("LastBattle2")

	SetInvincible(Mission.AmmoShip, true)

	--Kill(Mission.PlayerUnit, true)

	Blackout(false, "", 1)

	luaIngameMovie(
		{
		   --{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 175, ["theta"] = 89, ["rho"] = 179, ["moveTime"] = 0},
		   --{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 175, ["theta"] = 89, ["rho"] = 179, ["moveTime"] = 15},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AmmoShip, ["distance"] = 450, ["theta"] = 20, ["rho"] = 10, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AmmoShip, ["distance"] = 250, ["theta"] = 20, ["rho"] = 350, ["moveTime"] = 10},

		}, luaJM13AmmoShipSkip)
end

function luaJM13AmmoShipSkip()
	--luaLog("Adding ammoship listener")

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		CheatMaxRepair(Mission.PlayerUnit)
		SetSelectedUnit(Mission.PlayerUnit)
	else
		Mission.ThinkStop = true
		luaJM13SpawnPlayerUnit()
	end

	--PilotMoveTo(Mission.PlayerUnit, Mission.AmmoShip)

	if not luaObj_IsActive("primary",4) then
		luaObj_Add("primary",4, Mission.AmmoShip)
		AddListener("hit", "ammoHit", {
			["callback"] = "luaJM13AmmoHit", -- callback fuggveny
			["target"] = {Mission.AmmoShip}, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end

	if Mission.ThinkStop then
		Mission.ThinkStop = false
	end

	EnableInput(true)

	--luaJM13StartDialog("AmmoShip")
end

function luaJM13AmmoHit(...)
	--luaLog("Ammoship listener cb")
	--luaLog(arg)
	if arg[3] and arg[1] and arg[4] and arg[4] == "KAMIKAZE" then

		--if not Mission.AmmoShip or Mission.AmmoShip.Dead then
		--if Mission.AmmoShip then
			Mission.AmmoHit = true

			luaDelay(luaJM13DelayedCVExp, 1)

			RemoveListener("hit", "ammoHit")

			if Mission.AmmoShip and not Mission.AmmoShip.Dead then
				--luaDelay(luaJM13EndExpEffect, 1)
				--AddDamage(arg[1], 99999)
				Effect("ExplosionBigShip", ORIGO, Mission.AmmoShip)
				Effect("ExplosionMagazine", ORIGO, Mission.AmmoShip)
				if IsInvincible(Mission.AmmoShip) then
					SetInvincible(Mission.AmmoShip, false)
				end
				
				ExplodeToParts(Mission.AmmoShip)
				luaDelay(luaJM13DelayedBreakShip, 2)
				
			end

			if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
				Kill(Mission.PlayerUnit)
			end

			luaJM13EndMovie()

			--SetInvincible(Mission.USNCarriers[1], false)
			--SetInvincible(Mission.USNCarriers[2], false)


			--luaLog("mission completed")

		--else

			--Mission.MissionFailed = true

		--end
	end
end

function luaJM13EndExpEffect()
	--[[local rnd = random(1, 2)
	local fxTbl = {
		--"ExplosionBigTurret",
		"ExplosionMagazine",
		"ExplosionBigShip",
	}

	local rndfx = luaPickRnd(fxTbl)

-- RELEASE_LOGOFF  	luaLog("EFFECT: ")
-- RELEASE_LOGOFF  	luaLog(rndfx)

	local pos = ORIGO

	pos.x = pos.x + random(-20,30)
	pos.y = pos.x + random(-30,50)


	if Mission.FX then
		StopEffect(Mission.FX.Pointer)
	else
		if not Mission.EndMission then
			Mission.FX = Effect(rndfx, pos, Mission.AmmoShip)
		end
	end

	luaDelay(luaJM13EndExpEffect, rnd)]]

	local pos = ORIGO

	pos.x = pos.x + 5
	pos.z = pos.z - 5

	if Mission.AmmoShip and not Mission.AmmoShip.Dead then
		--luaLog(pos)
		Effect("ExplosionBigShip", pos, Mission.AmmoShip)
		Effect("ExplosionMagazine", ORIGO, Mission.AmmoShip)
	end

	luaDelay(luaJM13DelayedCVExp, 1)
	luaDelay(luaJM13EndExpEffect, random(1,2))
end

function luaJM13DelayedCVExp()
	--luaLog("CV EXPLODE")

	local pos = ORIGO
	local ship = FindEntity("Yorktown-class 01") --	random(1,2)
	local ship2 = FindEntity("Yorktown-class 02") --	random(1,2)

	pos.x = pos.x + random(-15,15)
	pos.z = pos.z - random(-10,10)



	if ship and not ship.Dead then
		local planes = luaGetPlanesAround(ship, 300, "own")
		Effect("ExplosionBigShip", pos, ship)
		pos.x = pos.x - 30
		pos.y = pos.y + 20
		Effect("ExplosionMagazine", pos, ship)
		
		if IsInvincible(ship) then
			SetInvincible(ship, false)
		end

		
		ExplodeToParts(ship)
		SetDeadMeat(ship)
		
		
		if planes then
			for i,v in pairs(luaRemoveDeadsFromTable(planes)) do
				w = GetSquadronPlanes(v)
				for j,z in pairs(luaRemoveDeadsFromTable(w)) do
					AddDamage(thisTable[z], 500)
				end
			end
		end
		--AddDamage(ship, 99999)
	end

	if ship2 and not ship2.Dead then
		Effect("ExplosionMagazine", pos, ship2)
		pos.x = pos.x - 30
		pos.y = pos.y + 20
		Effect("ExplosionBigShip", pos, ship2)
		AddDamage(ship2, 99999)
	end

	--if not Mission.ShipsBroken then
		--Mission.ShipsBroken = true
		--luaDelay(luaJM13DelayedBreakShip, 2)
		--BreakShip(Mission.AmmoShip)
	--end
end

function luaJM13DelayedBreakShip()
	if Mission.AmmoShip and not Mission.AmmoShip.Dead then
		BreakShip(Mission.AmmoShip)
	end
end

function luaJM13TargetSelector()
	local units = luaGetOwnUnits()
	local landingships = {}
	local fighters = {}
	local trg

	for idx,unit in pairs(units) do
		if unit.Class.Type == "LandingShip" or unit.Class.Type == "Cargo" then
			table.insert(landingships, unit)
		elseif unit.Class.Type == "Fighter" then
			table.insert(fighters, unit)
		end
	end

	for idx,plane in pairs(luaRemoveDeadsFromTable(Mission.USNPlanes)) do
		if plane.Class.ID == 135 then
			if not plane.Target or plane.Target.Dead then
				trg = luaPickRnd(fighters)
				plane.Target = trg
			else
				luaSetScriptTarget(plane, plane.Target)
				PilotSetTarget(plane, plane.Target)
			end
		else
			if not plane.Target or plane.Target.Dead then
				trg = luaPickRnd(landingships)
				plane.Target = trg
			else
				luaSetScriptTarget(plane, plane.Target)
				PilotSetTarget(plane, plane.Target)
			end
		end
	end
end


function luaJM13Atvezeto1A()
	--luaJM13StartDialog("GoHome")
	--luaJM13StepPhase()
	Blackout(true, "luaJM13EztMajdKiKellKotni", 2)
end

function luaJM13CheckHQ()
	if not Mission.CBBanned then
		if Mission.CB.Party == PARTY_JAPANESE then
			SetRoleAvailable(Mission.CB, EROLF_ALL, PLAYER_AI)
			Mission.CBBanned = true
		end
	end

	--[[if not Mission.CCBanned then
		if Mission.CC.Party == PARTY_JAPANESE then
			SetRoleAvailable(Mission.CC, EROLF_ALL, PLAYER_AI)
			Mission.CCBanned = true
		end
	end]]--
end

function luaJM13KamikazeCheat()
	--for i,v in pairs(Mission.USNTransports) do
-- RELEASE_LOGOFF  	--	luaLog(v.Name)
	--end

	Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)

	if not IsListenerActive("hit", "kamikazeCheat") then
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			AddListener("hit", "kamikazeCheat", {
				["callback"] = "luaJM13KamikazeCheatCB", -- callback fuggveny
				["target"] = Mission.USNTransports, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {Mission.PlayerUnit}, -- tamado entityk
				["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
-- RELEASE_LOGOFF  			luaLog("kamikaze listener added: "..debug.traceback())
		end
	end
end

function luaJM13KamikazeCheatMozi()
	--for i,v in pairs(Mission.USNTransports) do
-- RELEASE_LOGOFF  	--	luaLog(v.Name)
	--end

	Mission.USNTransports = luaRemoveDeadsFromTable(Mission.USNTransports)

	if not IsListenerActive("hit", "kamikazeCheatMozi") then
		if Mission.MoziUnit and not Mission.MoziUnit.Dead then
			AddListener("hit", "kamikazeCheatMozi", {
				["callback"] = "luaJM13KamikazeCheatMoziCB", -- callback fuggveny
				["target"] = Mission.USNTransports, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {Mission.MoziUnit}, -- tamado entityk
				["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
-- RELEASE_LOGOFF  			luaLog("kamikaze mozi listener added: "..debug.traceback())
		end
	end
end

function luaJM13KamikazeCheatMoziCB(...)

	if IsListenerActive("hit", "kamikazeCheatMozi") then
		RemoveListener("hit", "kamikazeCheatMozi")
	end

	if arg[3] and arg[1] and arg[4] and arg[4] == "KAMIKAZE" then
		Effect("ExplosionBigShip", ORIGO, arg[1])
		AddDamage(arg[1], 99999)
		--BreakShip(arg[1])
	end


end



function luaJM13KamikazeCheatCB(...)

-- RELEASE_LOGOFF  	luaLog("-------------- kamilistcb -----------------")
-- RELEASE_LOGOFF  	luaLog(arg)
-- RELEASE_LOGOFF  	luaLog("------------ kamilistcb end ---------------")

	--[[if IsListenerActive("hit", "kamikazeCheat") and (not Mission.PlayerUnit or Mission.PlayerUnit.Dead) then
		RemoveListener("hit", "kamikazeCheat")
	end]]

	if arg[3] and arg[1] and arg[4] and arg[4] == "KAMIKAZE" then

		if IsListenerActive("hit", "kamikazeCheat") then
			RemoveListener("hit", "kamikazeCheat")
		end

		Effect("ExplosionBigShip", ORIGO, arg[1])
		AddDamage(arg[1], 99999)
		--BreakShip(arg[1])
		luaDelay(luaJM13KamikazeCheat, 3)
	end



end

function luaJM13LandingIndicator()
	local perc1 = GetCapturePercentage(Mission.CB)
	--local perc2 = GetCapturePercentage(Mission.CC)
	--if perc <= 0 then
		--perc = math.abs(perc)
	--end

	if Mission.CB.Party == PARTY_JAPANESE then
		Mission.AlphaCap = "100"
	else
		Mission.AlphaCap = string.format("%.0f",(perc1 * 100))
	end


	--[[if Mission.CC.Party == PARTY_JAPANESE then
		Mission.BetaCap = "100"
	else
		Mission.BetaCap = string.format("%.0f",(perc2 * 100))
	end]]

	Mission.AlphaBunkers = table.getn(luaRemoveDeadsFromTable(Mission.AlphaGuns))

	DisplayScores(1,0,"ijn13.alpha","ijn13.alpha_1")
	--DisplayScores(2,0,"ijn13.alpha_1","")

	if Mission.CB.Party == PARTY_JAPANESE --[[and Mission.CC.Party == PARTY_JAPANESE]] then
		HideScoreDisplay(1,0)
		--HideScoreDisplay(2,0)
	end

	--[[if Mission.AlphaBunkers == 0 then
		HideScoreDisplay(2,0)
	end]]

end

function luaJM13AKChecker()
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNTroops)) == 0 then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn13.obj_missionfailed_akdead"
		luaJM13StepPhase(99)
	end
end

function c()
	SetParty(Mission.CB, 1)
	--SetParty(Mission.CC, 1)
end

function luaJM13Harrass()
	if table.getn(luaRemoveDeadsFromTable(Mission.USNCarriers)) == 0 or Mission.HarrassVolt then
-- RELEASE_LOGOFF  		luaLog("kireturnolok")
		return
	else
		for i,cv in pairs(luaRemoveDeadsFromTable(Mission.USNCarriers)) do
			if IsReadyToSendPlanes(cv) then
				LaunchSquadron(cv, 102, 3, 1)
			end
			
	
-- RELEASE_LOGOFF  			luaLog("harrass vege")
		end
		
		Mission.HarrassVolt = true		
		
		-- for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNCarriers)) do
			-- local fighterClassIDs = {}
				-- table.insert(fighterClassIDs, 102)

			-- local otherClassIDs = {}
				-- table.insert(otherClassIDs, 102)
				-- --table.insert(otherClassIDs, 102)

			-- local equipments = {}
				-- table.insert(equipments, 1)
				-- table.insert(equipments, 1)
				-- --table.insert(equipments, 1)


			-- local phase
			-- local errorLvl

			-- luaCapManager(unit, fighterClassIDs, 1)
			-- phase, Mission.AFEnts[idx], errorLvl = luaLaunchAirstrike(1, 2, {unit}, otherClassIDs, Mission.AFEnts[idx], nil)

			-- if errorLvl == 3 then
				-- local trg = Mission.PlayerUnit

				-- for idx,tbl in pairs(luaRemoveDeadsFromTable(Mission.AFEnts)) do
					-- for idx2,squadron in pairs(luaRemoveDeadsFromTable(tbl)) do
						-- if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
							-- local ammo = GetProperty(unit, "ammoType")
							-- if ammo ~= 0 then
								-- if trg and not trg.Dead then
									-- --SetSkillLevel(squadron, SKILL_STUN)
									-- luaSetScriptTarget(squadron, trg)
									-- PilotSetTarget(squadron, trg)
								-- end
							-- end
						-- end
					-- end
				-- end
			-- end
		-- end
	end
end


function luaJM13CheckPara()
	--luaLog("checking paratroopers")
	if Mission.Dakota and not Mission.Dakota.Dead then
		local ammo = GetProperty(Mission.Dakota, "ammoType")
		local dist = luaGetDistance(Mission.Dakota, Mission.CB)
		--luaLog("tavolsag: "..tostring(dist))
		if ammo ~= 0 and dist < 300 then
			local planes = GetSquadronPlanes(Mission.Dakota)
			for idx,planeID in pairs(planes) do
				PlaneForceRelease(thisTable[tostring(planeID)])
				--luaLog("dobtam")
			end
		end
	end

	if Mission.Dakota2 and not Mission.Dakota2.Dead then
		local ammo = GetProperty(Mission.Dakota2, "ammoType")
		local dist = luaGetDistance(Mission.Dakota2, Mission.CB)
		--luaLog("tavolsag 2: "..tostring(dist))
		if ammo ~= 0 and dist < 300 then
			local planes = GetSquadronPlanes(Mission.Dakota2)
			for idx,planeID in pairs(planes) do
				PlaneForceRelease(thisTable[tostring(planeID)])
				--luaLog("dobtam 2")
			end
		end
	end

end

function luaJM13AddLandingListener()
	local units = luaGetOwnUnits()
	local lShips = {}

	for idx,unit in pairs(units) do
		if unit.Class.Type == "LandingShip" then
			table.insert(lShips, unit)
		end
	end

	if not IsListenerActive("shipLanded", "landingListener") then
		--luaLog("izzitom a listenert")
		--luaLog(lShips)
		--luaLog("-------------------")
		AddListener("shipLanded", "landingListener", {
			["callback"] = "luaJM13ShipsLanded",  -- callback fuggveny
			["entity"] = lShips, -- entityk akiken a listener aktiv
		})
	end

end

function luaJM13ShipsLanded(ship)
	--luaLog("landing callback")
	RemoveListener("shipLanded", "landingListener")

	if Mission.MovieOption then

		Mission.SelectedUnit = Mission.PlayerUnit

		if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
			SetInvincible(Mission.SelectedUnit, true)
		end

		local nearest = luaSortByDistance2(ship, Mission.HQs)[1]

		luaIngameMovie(
			{
			   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 350, ["theta"] = 15, ["rho"] = 145, ["moveTime"] = 0},
			   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 100, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 5},
			   {["postype"] = "cameraandtarget", ["target"] = nearest, ["distance"] = 500, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 10},
			},	luaJM13IngameMovieEnd )
	end
end

function luaJM13IngameMovieEnd()

	if Mission.MissionPhase >= 99 then

		if Mission.MissionCompleted then
			luaJM13StepPhase()
			luaMissionCompletedNew(nil, "ijn13.obj_missioncomp")

			local medal = luaGetMedalReward()
			if medal == MEDAL_GOLD then
				Scoring_GrantBonus("JM13_SCORING_GOLD", "ijn13.bonus1_title", "ijn13.bonus1_text", 58)
			end


		elseif Mission.MissionFailed then
			luaJM13StepPhase()
			luaMissionFailedNew(nil, Mission.FailMsg, nil, true)
		end

	else

		if Mission.ThinkStop then
			Mission.ThinkStop = false
		end


		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			if IsInvincible(Mission.PlayerUnit) then
				SetInvincible(Mission.PlayerUnit, false)
			end
			SetSelectedUnit(Mission.PlayerUnit)
			--Mission.PlayerUnit = Mission.SelectedUnit
		else
			--Mission.MovieEnd = true
			if Mission.MissionPhase < 5 then
				luaJM13SpawnPlayerUnit()
			end
		end

		if Mission.MissionPhase == 4 then
			Mission.Mehet = true

			local aTbl = GetActDialogIDs()

			for i,d in pairs(aTbl) do
				BreakDialog(d)
			end

			if table.getn(luaRemoveDeadsFromTable(Mission.USNTransports)) > 2 then
				if Mission.USNTransports[1] and not Mission.USNTransports[1].Dead then
					BreakShip(Mission.USNTransports[1])
				end
			end

			if Mission.IJNCarrier and not Mission.IJNCarrier.Dead then
				Kill(Mission.IJNCarrier,true)
			end

			if not IsListenerActive("hit", "kamikazeCheat") then
				luaJM13KamikazeCheat()
			end
		end

	end

	EnableInput(true)

end

function luaJM13CheckLastPlane()
	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead then
		if Mission.AmmoShip and not Mission.AmmoShip.Dead then
			luaJM13StepPhase(99)
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn13.obj_missionfailed_lastplane"
		end
	end
end

------------------------moviez----------------------------
function luaJM13CarrierMovie()
	--Loading_Finish()
	--luaJM13StartDialog("Init")
	--Mission.PlayerUnit = luaGetPlanesAround(Mission.IJNCarrier, 100, "own")[1]
	Mission.PlayerUnit = FindEntity("A6M Zero 01")
	AddProximityTrigger(Mission.PlayerUnit, "PrisonRecon", "luaJM13PrisonReconned", Mission.Prison, 300)
	SquadronSetTravelAlt(Mission.PlayerUnit, 50)
	PilotMoveTo(Mission.PlayerUnit, Mission.Prison)
	UnitHoldFire(Mission.PlayerUnit)
	luaJM13Invasion()
	luaDelay(luaJM13GenerateEscapist, 60)
	--luaDelay(luaJM13SpawnIJNParatroopers, 10)

	luaIngameMovie(
		{
		   --{["postype"] = "cameraandtarget", ["target"] = Mission.IJNCarrier, ["distance"] = 300, ["theta"] = 10, ["rho"] = 30, ["moveTime"] = 0},
		  -- {["postype"] = "cameraandtarget", ["target"] = Mission.IJNCarrier, ["distance"] = 150, ["theta"] = 10, ["rho"] = 30, ["moveTime"] = 3},
   		   --{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 150, ["theta"] = 10, ["rho"] = 180, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.IJNCarrier, ["distance"] = 250, ["theta"] = 1, ["rho"] = 180, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 150, ["theta"] = 10, ["rho"] = 180, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 50, ["theta"] = 20, ["rho"] = 180, ["moveTime"] = 5},
		},	luaJM13CarrierMovieSkip, true )
end

function luaJM13CarrierMovieSkip()
	Mission.PlayerSpawnReq = "PlayerSpawnReq"
	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_1)
	SetSelectedUnit(Mission.PlayerUnit)
	EnableInput(true)
	luaJM13StepPhase(1)
end

function luaJM13HiddenMovie()

	if IsListenerActive("input", "IngameMovieInputListenerID") then
		return
	end

	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.RescuePlane, ["distance"] = 200, ["theta"] = 25, ["rho"] = 160, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.RescuePlane, ["distance"] = 400, ["theta"] = 75, ["rho"] = 359, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.RescuePlane, ["distance"] = 400, ["theta"] = 75, ["rho"] = 359, ["moveTime"] = 5},
		},	luaJM13IngameMovieEnd )
end

function luaJM13EndMovie()
	Mission.SelectedUnit = GetSelectedUnit()

	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AmmoShip, ["distance"] = 100, ["theta"] = 15, ["rho"] = 145, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AmmoShip, ["distance"] = 200, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 10},
		},	luaJM13IngameMovieEnd )

	--BreakShip(Mission.AmmoShip)
end

function luaJM13SecCompCam()
	local trg

	for i,v in pairs(Mission.USNFleet) do
		if not TrulyDead(v) then
			trg = v
		end
	end

	if trg then

		Mission.SelectedUnit = GetSelectedUnit()

		if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
			SetInvincible(Mission.SelectedUnit, true)
		end


		luaIngameMovie(
			{
			   {["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 200, ["theta"] = 25, ["rho"] = 160, ["moveTime"] = 0},
			   {["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 400, ["theta"] = 75, ["rho"] = 200, ["moveTime"] = 5},
			},	luaJM13IngameMovieEnd )

	end
end


-----hints-----------
function luaJM13AssistHint()
	ShowHint("IJN13_Assist")
end

function luaJM13KamikazeHint()
	ShowHint("IJN13_Kamikaze")
end

function luaJM13LastplaneHint()
	ShowHint("IJN13_Lastplane")
end

function luaJM13ParaHint()
	ShowHint("IJN13_Para")
end

function luaJM13StrafeHint()
	ShowHint("IJN13_Strafe")
end

function luaJM13SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)

	for i,v in pairs(Mission.Checkpoint.Units.JapUnits[1]) do
		v[7] = GetPosition(FindEntity(v[1]))
	end

	for i,v in pairs(Mission.Checkpoint.Units.USUnits[1]) do
		v[7] = GetPosition(FindEntity(v[1]))
	end


	Mission.Checkpoint.LastPos = Mission.LastPos
	Mission.Checkpoint.LastLookAt = Mission.LastLookAt
	Mission.Checkpoint.SpawnCounter = Mission.SpawnCounter

end

function luaJM13LoadBlackout()
	Blackout(true, "", 0)
	--Loading_Start()
	luaJM13LoadMissionData()
end

function luaJM13LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

--[[	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		Kill(Mission.PlayerUnit, true)
	end]]

	for i,v in pairs(luaRemoveDeadsFromTable(Mission.IJNFleet)) do
		SetRoleAvailable(v, EROLF_ALL, PLAYER_AI)
	end

	MissionNarrativeClear()

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.LastPos = Mission.Checkpoint.LastPos
	Mission.LastLookAt = Mission.Checkpoint.LastLookAt
	Mission.SpawnCounter = Mission.Checkpoint.SpawnCounter

	if num == 2 then
		luaJM13EztMajdKiKellKotni()
	end

	luaDelay(luaJM13Restore, 1)
end

function luaJM13Restore()
	luaJM13RestoreUnits(Mission.Checkpoint.CheckPoint.Num[1])
end

function luaJM13RestoreUnits(num)

	local ijn = luaGetCheckpointData("Units", "JapUnits")
	local usn = luaGetCheckpointData("Units", "USUnits")

	luaJM13CheckHQ()
	ForceRecon()
	local usnnow = luaGetOwnUnits(nil, PARTY_ALLIED)
	local ijnnow = luaGetOwnUnits(nil, PARTY_JAPANESE)

	--luaLog("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
	--luaLog(usnnow)
	--luaLog("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")

	for idx,unit in pairs(usnnow) do
		local found = false
		for idx2,unitTbl in pairs(usn[1]) do
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
			--GenerateObject(unitTbl[1], unitTbl[2])
		end

	end


	for idx,unit in pairs(ijnnow) do
		local found = false
		for idx2,unitTbl in pairs(ijn[1]) do
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



	luaDelay(luaJM13ArrabbBaszo, 1)

end

function luaJM13ArrabbBaszo()

	for i,v in pairs(Mission.Checkpoint.Units.USUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end

	for i,v in pairs(Mission.Checkpoint.Units.JapUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end
end

function luaJM13LoadEnd()

	--luaJM13GenerateEscapist()

	Loading_Finish()
end


function luaJM13DisableAfterChkp()
	ForceRecon()
	local ijn = luaGetOwnUnits()
	local ship = luaGetOwnUnits("ship", PARTY_JAPANESE)

	if Mission.Checkpoint.CheckPoint.Num[1] == 2 then
		for i,v in pairs(ship) do
			if IsInvincible(v) then
				SetInvincible(v, false)
			end

			Kill(v,true)
		end

		for i,v in pairs(luaRemoveDeadsFromTable(Mission.USNAttackers)) do
			if v.Class.ID == 36 then

				if IsInvincible(v) then
					SetInvincible(v, false)
				end

				Kill(v,true)
			end
		end
	end

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNFleet)) do
		local found = false
		for idx2,unitTbl in pairs(Mission.Checkpoint.Units.USUnits[1]) do
			if unit.Name == unitTbl[1] then
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

	for i,v in pairs(luaRemoveDeadsFromTable(ijn)) do
		--luaLog("DASDASDAS "..v.Name)
		SetRoleAvailable(v, EROLF_ALL, PLAYER_AI)
	end

	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_1)
end

function luaJM13GenerateFinalFleet()

	--Mission.ThinkStop = true
	for	idx,unitTbl in pairs(Mission.FinalFleetNames) do
		local ship = GenerateObject(unitTbl[1].Name, unitTbl[1].Name)
		SetGuiName(ship, unitTbl[2])
		SetNumbering(ship, unitTbl[3])

		if ship.Class.Type == "MotherShip" then
			table.insert(Mission.USNCarriers, ship)
			AAEnable(ship, false)
		else
			Mission.AmmoShip = ship
		end
	end

	luaJM13InitAmmoShip()
end

function luaJM13PrisonReconned()
	SetGuiName(Mission.Prison, "ijn13.prison_reconned")
end

function luaJM13CargoAttacker()
	--luaLog("cargoattacker")
	local rnd

	Mission.IJNA = luaRemoveDeadsFromTable(Mission.IJNA)
	--Mission.IJNB = luaRemoveDeadsFromTable(Mission.IJNB)

	--[[for i,gun in pairs(luaRemoveDeadsFromTable(Mission.AlphaGuns)) do
		if not gun.trg or gun.trg.Dead then
			rnd = random(1,table.getn(Mission.IJNA))
			gun.trg = Mission.IJNA[rnd]
		else
			SetFireTarget(gun, gun.trg)
		end
	end

	for i,gun in pairs(luaRemoveDeadsFromTable(Mission.BetaGuns)) do
		if not gun.trg or gun.trg.Dead then
			rnd = random(1,table.getn(Mission.IJNB))
			gun.trg = Mission.IJNB[rnd]
		else
			SetFireTarget(gun, gun.trg)
		end
	end


	for i,pt in pairs(luaRemoveDeadsFromTable(Mission.PrisonPatrol)) do
		if not pt.trg or pt.trg.Dead then
			if table.getn(Mission.IJNB) ~= 0 then
				rnd = random(1,table.getn(Mission.IJNB))
				pt.trg = Mission.IJNB[rnd]
			elseif table.getn(Mission.IJNA) ~= 0 then
				rnd = random(1,table.getn(Mission.IJNA))
				pt.trg = Mission.IJNA[rnd]
			end
		else
			NavigatorAttackMove(pt, pt.trg, {})
		end
	end]]

	for i,pt in pairs(luaRemoveDeadsFromTable(Mission.PrisonPatrol2)) do
		if not pt.trg or pt.trg.Dead then
			if table.getn(luaRemoveDeadsFromTable(Mission.IJNA)) ~= 0 then
				rnd = random(1,table.getn(Mission.IJNA))
				pt.trg = Mission.IJNA[rnd]
			--[[elseif table.getn(Mission.IJNB) ~= 0 then
				rnd = random(1,table.getn(Mission.IJNB))
				pt.trg = Mission.IJNB[rnd]]--
			end
		else
			NavigatorAttackMove(pt, pt.trg, {})
		end
	end


end

function luaJM13EmptyBaseChecker()
	if Mission.CB.Party == PARTY_JAPANESE and table.getn(luaRemoveDeadsFromTable(Mission.IJNB)) == 0 then
		for i,v in pairs(luaRemoveDeadsFromTable(Mission.IJNA)) do
			NavigatorAttackMove(v, Mission.CB, {})
		end
	end

	--[[if Mission.CC.Party == PARTY_JAPANESE and table.getn(luaRemoveDeadsFromTable(Mission.IJNA)) == 0 then
		for i,v in pairs(luaRemoveDeadsFromTable(Mission.IJNB)) do
			NavigatorAttackMove(v, Mission.CB, {})
		end
	end]]

end

function luaJM13DisplayCBHP()
	Mission.CBHP = GetHpPercentage(Mission.CB)*Mission.CB.Class.HP
end

function luaJM13KillAllOther()
	ForceRecon()

	for i,v in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.fighter)) do
		if Mission.PlayerUnit.ID and v.ID ~= Mission.PlayerUnit.ID then
			Kill(v, true)
			--luaLog("killezek: "..v.Name)
		end
	end

	for i,v in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.kamikaze)) do
		if Mission.PlayerUnit.ID and v.ID ~= Mission.PlayerUnit.ID then
			Kill(v, true)
			--luaLog("killezek: "..v.Name)
		end
	end

end

function luaJM13Pri2Score()
	Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.USNTransports))

	DisplayScores(999,0,"ijn13.obj_p2", "ijn13.nmitt")
end

function luaJM13SpawnIJNParatroopers()
	local para = luaFindHidden("Douglas L2D Transport 01")
	Mission.IJNParatrooper = GenerateObject(para.Name, para.Name)
	SetRoleAvailable(Mission.IJNParatrooper, EROLF_ALL, PLAYER_AI)
	PilotMoveTo(Mission.IJNParatrooper, Mission.CC)
	AddProximityTrigger(Mission.IJNParatrooper, "drop", "luaJM13Drop", Mission.CC, 300)

	if not IsListenerActive("kill", "para") then
		AddListener("kill", "para", {
			["callback"] = "luaJM13SpawnIJNParatroopers",  -- callback fuggveny
			["entity"] = {Mission.IJNParatrooper}, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	end
end

function luaJM13Drop()
	--luaLog("hanyszor hivodsz te szar?")
	local planes = GetSquadronPlanes(Mission.IJNParatrooper)

	if not GetPlaneIsReloading(Mission.IJNParatrooper) then
		PilotMoveTo(Mission.IJNParatrooper, Mission.CC)
		for idx,planeID in pairs(planes) do
			PlaneForceRelease(thisTable[tostring(planeID)])
			--AddProximityTrigger(Mission.IJNParatrooper, "drop", "luaJM13Drop", Mission.CC, 300)
			--luaLog("IJN dobtam")
		end
	end
end

function luaJM13VanEListener()
	Mission.VanE = IsListenerActive("hit", "kamikazeCheat")
end