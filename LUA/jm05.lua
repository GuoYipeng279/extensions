--SceneFile="universe\Scenes\missions\IJN\ijn_05_invasion_of_port_moresby.scn"
DoFile("Scripts/datatables/Inputs.lua")

---INTRO
function luaEngineMovieInit()
--	dprintf("create---em")
	Music_Control_SetLevel(MUSIC_CALM)
	EnableMessages(false)

	LoadMessageMap("ijndlg",5)
	Dialogues =
	{
		["Intro_A"] = {
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["message"] = "idlg01a_2",
				},
			},
		},
		["Intro_B"] = {
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["message"] = "idlg01b_2",
				},
			},
		},
		["Intro_C"] = {
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "idlg01c",
				},
				{
					["message"] = "idlg01c_1",
				},
			},
		},
		["Intro_D"] = {
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "idlg01d",
				},
			},
		},
	}

	MissionNarrative("ijn05.date_location")
	luaDelay(luaJM5EMDlgA, 10)
end

function luaJM5EMDlgA()
	StartDialog("Intro_dlg_a", Dialogues["Intro_A"] );
	luaDelay(luaJM5EMDlgB, 20)
end

function luaJM5EMDlgB()
	StartDialog("Intro_dlg_b", Dialogues["Intro_B"] );
	luaDelay(luaJM5EMDlgC, 21)
end

function luaJM5EMDlgC()
	StartDialog("Intro_dlg_c", Dialogues["Intro_C"] );
	luaDelay(luaJM5EMDlgD, 23)
end

function luaJM5EMDlgD()
	StartDialog("Intro_dlg_d", Dialogues["Intro_D"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM5")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM5(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM05.lua"

	this.Name = "JM5"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	--lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	this.MissionPhase = 0

	this.ObjRemindTime = 150
	this.FirstSpawn = true

	--maptiltas dialogusig
	--ForceEnableInput(IC_MAP_TOGGLE, false)

	SetDeviceReloadEnabled(true)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		--[1] = { luaJM5LoadMissionData, luaJM5EnableMap},
		[1] = { luaJM5LoadMissionData, },
		--[2] = { luaJM5SpawnJapLvlBomber, luaJM5LoadMissionData, luaJM5EnableMap},
		[2] = { luaJM5SpawnJapLvlBomber, luaJM5LoadMissionData },
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM5SaveMissionData,},
		[2] = {luaJM5SaveMissionData,},
	}

	--enginemovies
	--luaInitJumpinMovies()

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	end

	-- weather
	--SetDayTime(12) -- 12 orakor kezdodik
	--SetWeather("Clear") -- tiszta idoben

	--OBJECTIVES
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "CapAirfield",
				["Text"] = "ijn05.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "CapPort",
				["Text"] = "ijn05.obj_p2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[3] = {
			--	["ID"] = "DefPort",
			--	["Text"] = "ijn05.obj_p3",
			--	["Active"] = false,
			--	["Success"] = nil,
			--	["Target"] = {},
			--	["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
			--	["ScoreFailed"] = 0
			--},
			[4] = {
				["ID"] = "CapRadar",
				["Text"] = "ijn05.obj_p4",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Help2Cap",
				["Text"] = "ijn05.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "DefBases",
				["Text"] = "ijn05.obj_h1",
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
		}
	}

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()


	--DIALOGUES
	this.Dialogues = {
		["Intro2"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
			},
		},
		["FirstJapAirSpawn"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2a_1",
				},
				{
					["message"] = "dlg2b",
				},
				{
					["message"] = "dlg2c",
				},
			},
		},
		["RadarHint1"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3a_1",
				},
				{
					["message"] = "dlg3b",
				},
			},
		},
		["Map_hint1"] = {
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
				--{
				--	["type"] = "callback",
				--	["callback"] = "luaJM5EnableMap",
				--},
			},
		},
		["Map_hint2"] = {
			["sequence"] = {
				{
					["message"] = "dlg5",
				},
				{
					["message"] = "dlg5_1",
				},
			},
		},
		["RadarHint2"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10a_1",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["FleetStopped"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
				{
					["message"] = "dlg7_1",
				},
			},
		},
		["Fortressbuilt"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9a_1",
				},
				{
					["message"] = "dlg9b",
				},
			},
		},
		["AirfieldCaptured"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["AirfieldCaptured_Vals"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["AirfieldCaptured2"] = {
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
			},
		},
		["FleetOngoing2"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["TransportsKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["message"] = "dlg15_1",
				},
			},
		},
		["NmiFleetSpawn"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
				{
					["message"] = "dlg17b_1",
				},
			},
		},
		["NmiFleetSpawn_Radar"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
		["RadarDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg28",
				},
			},
		},
		["AirfieldDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg29",
				},
			},
		},
		["PortCaptured"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
			},
		},
		["PortDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg30a",
				},
				{
					["message"] = "dlg30b",
				},
			},
		},
		["Paratroopers"] = {
			["sequence"] = {
				{
					["message"] = "dlg27a",
				},
				{
					["message"] = "dlg27b",
				},
			},
		},
		["Cap_range"] = {
			["sequence"] = {
				{
					["message"] = "dlg6",
				},
				{
					["message"] = "dlg6_1",
				},
			},
		},
		["Vals_going"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
			},
		},
		["Vals_success"] = {
			["sequence"] = {
				{
					["message"] = "dlg8b",
				},
				{
					["message"] = "dlg8c",
				},
			},
		},
		["Vals_fail"] = {
			["sequence"] = {
				{
					["message"] = "dlg8d",
				},
			},
		},
	}

	LoadMessageMap("ijndlg",5)

	Mission.MessageQ = {}
	Mission.StopMessages = false

	Mission.HintsShowed = {}

	Mission.Unlockables = {
		["68"] = {"ingame.shipnames_tone","ingame.shipnames_chikuma"},
		["1311"] = {"Prinz Eugen","Admiral Hipper"},
		["14"] = {"ingame.shipnames_akizuki","ingame.shipnames_teruzuki","ingame.shipnames_suzutsuki","ingame.shipnames_hatsutsuki","ingame.shipnames_niizuki"},
		["58"] = {"ingame.shipnames_hayaharu","ingame.shipnames_hatsuaki","ingame.shipnames_fuyukaze","ingame.shipnames_natsukaze","ingame.shipnames_kitakaze"},
		["391"] = {"ingame.shipnames_fuji"}
	}

	Mission.LastDialog = 0
	Mission.CargoCounter = 1
	Mission.ClemsonNameCounter = 1
	Mission.FletcherNameCounter = 1

	Mission.UntouchUnits = {}
		table.insert(Mission.UntouchUnits, FindEntity("USTroopTransport 01"))
		table.insert(Mission.UntouchUnits, FindEntity("US Tanker 01"))
		table.insert(Mission.UntouchUnits, FindEntity("Landing Ship, Tank 02"))
		table.insert(Mission.UntouchUnits, FindEntity("Landing Ship, Tank 03"))
		table.insert(Mission.UntouchUnits, FindEntity("US Cargo Transport 01"))
		table.insert(Mission.UntouchUnits, FindEntity("US Cargo Transport 02"))
		table.insert(Mission.UntouchUnits, FindEntity("Clemson Class Damaged 02"))
		table.insert(Mission.UntouchUnits, FindEntity("Clemson Class Damaged 01"))
		table.insert(Mission.UntouchUnits, FindEntity("PT Boat 80' Elco 02"))
		table.insert(Mission.UntouchUnits, FindEntity("PT Boat 80' Elco 01"))
		table.insert(Mission.UntouchUnits, FindEntity("PT Boat 80' Elco 04"))

	Mission.UntouchUnitNames = {}
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_henderson")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_sabine")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_lst|.134")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_lst|.136")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_argonne")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_wharton")
		table.insert(Mission.UntouchUnitNames, {"ingame.shipnames_sands",243})		--DD243
		table.insert(Mission.UntouchUnitNames, {"ingame.shipnames_stewart",224})	--DD224
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_pt|.140")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_pt|.109")
		table.insert(Mission.UntouchUnitNames, "ingame.shipnames_pt|.124")

	Mission.AlliedFleetNames = {}
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_chicago",29})			--CA29
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_hobart",39})			--DDG39
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_australia",84})	--DDG84
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_perkins",377})			--DD377
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_walke",416})				--DD416
		table.insert(Mission.AlliedFleetNames, {"ingame.shipnames_farragut",300})		--DD300

	Mission.SpawnNames = {}
		Mission.SpawnNames.Flecsi = {}
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_fletcher",445})		--DD445
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_fullam",474})			--DD474
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_bennett",473})		--DD473
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_guest",472})			--DD472
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_beale",471})			--DD471
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_bache",470})			--DD470
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_de_haven",469})		--DD469
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_taylor",94})			--DD94
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_strong",467})			--DD467
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_waller",466})			--DD466
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_saufley",465})		--DD465
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_chevalier",805})	--DD805
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_obannon",987})		--DD987
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_nicholas",311})		--DD311
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_la_vallette",315})--DD315
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_jenkins",42})		--DD42
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_radford",446})		--DD446
			table.insert(Mission.SpawnNames.Flecsi, {"ingame.shipnames_john_p_holder",525})--DD525

		Mission.SpawnNames.Clemson = {}
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_alden",211})						--DD211
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_barker",213})					--DD213
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_brooks",232})					--DD232
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_bulmer",222})					--DD222
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_clemson",186})					--DD186
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_gilmer",233})					--DD233
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_humphreys",236})				--DD236
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_john_d_edwards",216})	--DD216
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_john_d_ford",228})		--DD228
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_kane",235})						--DD235
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_king",242})						--DD242
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_parrott",218})					--DD218
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_paul_jones",10})			--DD10
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_pillsbury",227})				--DD227
			table.insert(Mission.SpawnNames.Clemson, {"ingame.shipnames_pope",225})						--DD225

		Mission.SpawnNames.Transport = {}
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_harris")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_zeilin")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_mccawley")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_heywood")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_fuller")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_harry_lee")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_munargo")
			table.insert(Mission.SpawnNames.Transport, "ingame.shipnames_florence_nightingale")

	for idx,unit in pairs(Mission.UntouchUnits) do
		AddUntouchableUnit(unit)
		NavigatorSetAvoidLandCollision(unit,false)
	end

	Mission.Sec2Bunkers = {}
		table.insert(Mission.Sec2Bunkers, FindEntity("Sec2_1"))
		table.insert(Mission.Sec2Bunkers, FindEntity("Sec2_2"))
		table.insert(Mission.Sec2Bunkers, FindEntity("Sec2_3"))
		table.insert(Mission.Sec2Bunkers, FindEntity("Sec2_4"))
		table.insert(Mission.Sec2Bunkers, FindEntity("Sec2_5"))

	--supportm hack
	Mission.SMBanned = true
	BannSupportmanager()

	--function spec variables
	--Mission.JapFleetSpawnInterval = 600
	--jap airgroup
	Mission.LastJapAirSpawn = 0
	Mission.JapAirSpawnInterval = 100
	Mission.JapAirSpawnReq = "JapAirGrpSpawnRequest"

	if Scoring_IsUnlocked("JM4_GOLD")	then
		Mission.UnlockLvl = 3
	elseif Scoring_IsUnlocked("JM4_SILVER") then
		Mission.UnlockLvl = 2
	else
		Mission.UnlockLvl = 1
	end

	--jap lv bomber
	Mission.JapLvlBomberSpawnReq = "JapLvlBomberSpawnReq"

	--allied fleet
	Mission.AlliedFleetSpawnTime = 900
	Mission.AlliedFleetSpawnReq = "AlliedFleetSpawnRequest"
	--Mission.CarrierPath = FindEntity("CarrierPath 1")

	--radar
	Mission.RadarStation = FindEntity("RadarStation 01")

	--main command building
	Mission.MainCmdBuilding = FindEntity("MainCommandBuilding 01")

	--shipyards
	Mission.Shipyard1Ships = {}
	Mission.Shipyard2Ships = {}
	Mission.Shipyard2Cargos = {}

	if Mission.Difficulty == 0 then

		Mission.Shiyard1SpawnInterval = 1200
		Mission.Shiyard2SpawnInterval = 1200
		Mission.MaxAllowedShipyard1Ships = 1
		Mission.MaxAllowedShipyard2Ships = 1
		Mission.MaxAllowedAlliedCargos = 1

	elseif Mission.Difficulty == 1 then

		Mission.Shiyard1SpawnInterval = 900
		Mission.Shiyard2SpawnInterval = 900
		Mission.MaxAllowedShipyard1Ships = 1
		Mission.MaxAllowedShipyard2Ships = 1
		Mission.MaxAllowedAlliedCargos = 2

	elseif Mission.Difficulty == 2 then

		Mission.Shiyard1SpawnInterval = 700
		Mission.Shiyard2SpawnInterval = 700
		Mission.MaxAllowedShipyard1Ships = 1
		Mission.MaxAllowedShipyard2Ships = 2
		Mission.MaxAllowedAlliedCargos = 2

	end

	Mission.LastShipyard1Spawned = 0
	Mission.LastShipyard2Spawned = 0

	Mission.ShipyardSpawnPoint = {FindEntity("MainShipyard 01 Navpoint 01"),  FindEntity("MainShipyard 02 Navpoint 01")}
	Mission.Shipyard1SpawnReq = "SH1SpawnRequest"
	Mission.Shipyard2SpawnReq = "SH2SpawnRequest"
	Mission.AlliedCargoSpawnReq = "ACargoSpawnRequest"
	Mission.ShipyardCheckInterval = 10

	--spawnPoints
	Mission.USNSpawnPoint = FindEntity("USNSpawn 01")
	Mission.IJNSpawnPoint = FindEntity("IJNSpawn 01")
	Mission.IJNBomberSpawnPoint = FindEntity("IJNBomberSpawnPoint 01")

	--Allied recapture
	Mission.Units2Recapture = {}
	Mission.MainCapPoints = {FindEntity("MainNavpoint 01"), FindEntity("MainNavpoint 02"), FindEntity("MainNavpoint 03"), FindEntity("MainNavpoint 04")}
	Mission.SecCapPoints = {FindEntity("SecondaryNavpoint 01"), FindEntity("SecondaryNavpoint 02"), FindEntity("SecondaryNavpoint 03"), FindEntity("SecondaryNavpoint 04")}
	Mission.RadarCapPoints = {FindEntity("RadarStationNavpoint 01"), FindEntity("RadarStationNavpoint 02"), FindEntity("RadarStationNavpoint 03"), FindEntity("RadarStationNavpoint 04")}

	--Speedupzones
	Mission.SpeedZones = {
		[1] = {GetPosition(FindEntity("SpeedZone1a")), GetPosition(FindEntity("SpeedZone1b"))},
		[2] = {GetPosition(FindEntity("SpeedZone2a")), GetPosition(FindEntity("SpeedZone2b"))},
		[3] = {GetPosition(FindEntity("SpeedZone3a")), GetPosition(FindEntity("SpeedZone3b"))},
	}

	--inital unit names
	Mission.Zero = FindEntity("A6M Zero 01")
	--SetGuiName(Mission.Zero, "A6M Zero")

	this.UnitNames = {}
	this.UnitNames.Jap = {}
	this.UnitNames.Allied = {}

		this.UnitNames.Jap.CL = {}
			table.insert(this.UnitNames.Jap.CL, "ingame.shipnames_tsugaru")
			table.insert(this.UnitNames.Jap.CL, "ingame.shipnames_tatsuta")
			--table.insert(this.UnitNames.Jap.CL, "Tenryu")
		this.UnitNames.Jap.DD = {}
			table.insert(this.UnitNames.Jap.DD, "ingame.shipnames_asanagi")
			table.insert(this.UnitNames.Jap.DD, "ingame.shipnames_mochitsuki")
			table.insert(this.UnitNames.Jap.DD, "ingame.shipnames_mutsuki")
			table.insert(this.UnitNames.Jap.DD, "ingame.shipnames_oite")
			table.insert(this.UnitNames.Jap.DD, "ingame.shipnames_yayoi")
		this.UnitNames.Jap.Cargos = {}
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_hakusan")
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_kirisima")
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_kamikara")
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_nankai")
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_zenyo")
			table.insert(this.UnitNames.Jap.Cargos, "ingame.shipnames_junyo_maru")

	--JAPANESE UNITS
	this.JapUnits = {}
		this.JapUnits.Cruisers = {}
		--CA
		table.insert(this.JapUnits.Cruisers, FindEntity("Mogami-class 01"))
		--unlock tone
		if IsClassChanged(this.JapUnits.Cruisers[1].Class.ID) then
			if this.JapUnits.Cruisers[1].Class.ID == 68 then
				SetGuiName(this.JapUnits.Cruisers[1], Mission.Unlockables["68"][1])
			elseif this.JapUnits.Cruisers[1].Class.ID == 391 then
				SetGuiName(this.JapUnits.Cruisers[1], Mission.Unlockables["391"][1])
			elseif this.JapUnits.Cruisers[1].Class.ID == 1311 then
				SetGuiName(this.JapUnits.Cruisers[1], Mission.Unlockables["1311"][1])
			else
				SetGuiName(this.JapUnits.Cruisers[1], this.JapUnits.Cruisers[1].Class.Name)
			end
		else
			SetGuiName(this.JapUnits.Cruisers[1], "ingame.shipnames_kako")
		end
		--CL
		--for i=1,3 do
		for i=1,2 do
			local unit = FindEntity("Kuma-class 0"..tostring(i))
			table.insert(this.JapUnits.Cruisers, unit)
			SetGuiName(unit, this.UnitNames.Jap.CL[i])
		end
		--DD
		this.JapUnits.Destroyers = {}
		for i=1,5 do
			table.insert(this.JapUnits.Destroyers, FindEntity("Fubuki-class 0"..tostring(i)))
			if IsClassChanged(this.JapUnits.Destroyers[i].Class.ID) then
				if this.JapUnits.Destroyers[i].Class.ID == 14 then
					SetGuiName(this.JapUnits.Destroyers[i], Mission.Unlockables["14"][i])
				elseif this.JapUnits.Destroyers[i].Class.ID == 58 then
					SetGuiName(this.JapUnits.Destroyers[i], Mission.Unlockables["58"][i])
				else
					SetGuiName(this.JapUnits.Destroyers[i], this.JapUnits.Destroyers[i].Class.Name)
				end
			else
				SetGuiName(this.JapUnits.Destroyers[i], this.UnitNames.Jap.DD[i])
			end
		end
		--Cargo
		this.JapUnits.Cargos = {}
		for i=1,5 do
			table.insert(this.JapUnits.Cargos, FindEntity("Japan Troop Transport 0"..tostring(i)))
			SetGuiName(this.JapUnits.Cargos[i], this.UnitNames.Jap.Cargos[i])
			--SetInvincible(this.JapUnits.Cargos[i], 0.5)
		end

	--PlayerControled units
	--2 troop transports, 1 light cruiser and 2 destroyers
	this.PlayerUnits = {}
		table.insert(this.PlayerUnits, this.JapUnits.Cruisers[1])
		table.insert(this.PlayerUnits, this.JapUnits.Destroyers[1])
		table.insert(this.PlayerUnits, this.JapUnits.Destroyers[2])
		table.insert(this.PlayerUnits, this.JapUnits.Cargos[1])
		table.insert(this.PlayerUnits, this.JapUnits.Cargos[2])
		table.insert(this.PlayerUnits, this.JapUnits.Cargos[5])
	for idx,unit in pairs(this.PlayerUnits) do
		if idx > 1 then
			--luaLog(unit.Name.." goes into player formation")
			JoinFormation(unit, this.PlayerUnits[1])
		end
		--SetShipSpeed(unit, 10)
	end
	SetSelectedUnit(this.PlayerUnits[1])
	Mission.Cruiser = this.PlayerUnits[1]
	--SetShipSpeed(this.PlayerUnits[1], 10)

	this.AIUnits = {}
		table.insert(this.AIUnits, this.JapUnits.Cruisers[2])
		table.insert(this.AIUnits, this.JapUnits.Cruisers[3])
		table.insert(this.AIUnits, this.JapUnits.Destroyers[3])
		table.insert(this.AIUnits, this.JapUnits.Destroyers[4])
		table.insert(this.AIUnits, this.JapUnits.Destroyers[5])
		table.insert(this.AIUnits, this.JapUnits.Cargos[3])
		table.insert(this.AIUnits, this.JapUnits.Cargos[4])

--	luaDelay(luaJM5FormationHax, 3)
	for idx,unit in pairs(this.AIUnits) do
		if idx > 1 then
			--luaLog(unit.Name.." goes into formation")
			JoinFormation(unit, this.AIUnits[1])
		end
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end

	this.JapFleetPath = FindEntity("IJNAIFleetPath 01")
	this.JapFleetAlertLvl = 0	-- 0 semmi gaz, megy pathon, 1 - eszlelt valamit
	this.JapFleetCmd = ""
	this.StopPoint = FindEntity("AIStopPoint")

	--Shipyards
	this.Shipyards = {}
		table.insert(this.Shipyards, FindEntity("MainShipyardEntity 01"))
		table.insert(this.Shipyards, FindEntity("MainShipyardEntity 02"))

	--Airfields
	this.Airfields = {}
		table.insert(this.Airfields, FindEntity("MainAirfieldEntity 01"))
		table.insert(this.Airfields, FindEntity("SecondaryAirfieldEntity 01"))
		this.Airfields[1].ThinkTime = 400
		this.Airfields[2].ThinkTime = 150


	Mission.AF1Mnager = CreateScript("luaJM5AF1ManagerInit")
	Mission.AF2Mnager = CreateScript("luaJM5AF2ManagerInit")

	--complete & fail
	Mission.FailMsg = ""
	Mission.CompleteMsg = ""

	--scoredisplay
	Mission.ScoreDisplay = {}

	--achievements
	Mission.CoastalGuns = luaJM5GetEnemyArtillery()

	--Events
	Mission.EventBonusAdded = 0
	Mission.EventBonuses = {
		[1] = "full_throttle",
		[2] = "evasive_manoeuvre",
		[3] = "fierce_assault",
		[4] = "improved_ship_manoeuvreability",
		[5] = "improved_repair_team",
		[6] = "hardened_armour",
		[7] = "improved_shells",
	}
	Mission.EventTable = {
		["Plane_events"] = {

			[1] = {
				["Name"] = "ijn05.obj_event1_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event1_desc",
				["Bonus"] = "improved_shells", --powerup when completed
				["ID"] = 1, --ID
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg25a",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg25c",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg25d",
						},
					},
				},
			},

			[2] = {
				["Name"] = "ijn05.obj_event2_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event2_desc",
				["Bonus"] = "improved_repair_team",
				["ID"] = 2,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg20a",
						},
						{
							["message"] = "dlg20b",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg20d",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg20e",
						},
					},
				},
			},

			[3] = {
				["Name"] = "ijn05.obj_event3_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event3_desc",
				["Bonus"] = "full_throttle",
				["ID"] = 3,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg21a",
						},
						{
							["message"] = "dlg21a_1",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg21c",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg21d",
						},
					},
				},
			},

			[4] = {
				["Name"] = "ijn05.obj_event4_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event4_desc",
				["Bonus"] = "evasive_manoeuvre",
				["ID"] = 4,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg23a",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg23c",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg23d",
						},
					},
				},
			},

			[5] = {
				["Name"] = "ijn05.obj_event5_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event5_desc",
				["Bonus"] = "hardened_armour",
				["ID"] = 5,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg26a",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg26c",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg26d",
						},
					},
				},
			},

		},
		["Non_plane_events"] = {

			[1] = {
				["Name"] = "ijn05.obj_event6_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event6_desc",
				["Bonus"] = "fierce_assault",
				["ID"] = 6,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg19a",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg19c",
						},
					},
				},
				["Failure"] = {
					["sequence"] = {
						{
							["message"] = "dlg19d",
						},
					},
				},
			},

			[2] = {
				["Name"] = "ijn05.obj_event7_name",
				["Timer"] = 400,
				["Desc"] = "ijn05.obj_event7_desc",
				["Bonus"] = "improved_ship_manoeuvreability",
				["ID"] = 7,
				["InitDialog"] = {
					["sequence"] = {
						{
							["message"] = "dlg22a",
						},
					},
				},
				["Success"] = {
					["sequence"] = {
						{
							["message"] = "dlg22c",
						},
					},
				},
				["Failure_A"] = {
					["sequence"] = {
						{
							["message"] = "dlg22d",
						},
					},
				},
				["Failure_B"] = {
					["sequence"] = {
						{
							["message"] = "dlg22e",
						},
					},
				},
			},
		},
	}

	Mission.EventIntervals = 180 --120
	Mission.MaxEvents = 4 --7
	Mission.PlayedEvents = 0
	Mission.EventsEnabled = false
	--luaDelaySet("EventsEnabled", true, 300)
	--luaDelaySet("EventsEnabled", true, 30)

	this.Cheat_PhaseShift = false

	Mission.FailEnt = false

	--updatelendo valtozok ojjektiva kiirashoz
	Mission.CaptureProgress = 0
	Mission.ShipsRemaining = 0
	Mission.BunkersRemaining = 0
	Mission.Time0 = GameTime()

	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	--Music_Control_SetLevel(MUSIC_CALM)

	--fade stb

	luaJM5InitCapPt()

	luaJM5StartMsg()
	luaJM5ShipyardDelayedCheck()
	luaDelay(luaJM5StartMessageQ, 2)

	--think
	SetThink(this, "luaJM5_think")

	--luaLog("Time")
	--luaLog(GameTime())

-- RELEASE_LOGOFF  --	AddWatch("Mission.EventsEnabled")
	--AddWatch("Mission.CurrentEventTable")
	--AddWatch("Mission.PlayerOnMap")
	--AddWatch("Mission.MovieOn")
	--AddWatch("Mission.MovieObjID")
-- RELEASE_LOGOFF  --	AddWatch("Mission.JapFleetAlertLvl")
-- RELEASE_LOGOFF  --	AddWatch("Mission.MissionPhase")
end

function luaJM5_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	--if Mission.StopThink then
	--	return
	--end

	--luaLog(recon[PARTY_JAPANESE].own)



	if Mission.MissionPhase <= 99 then

		luaCheckMusic()
	--luaLog(recon[PARTY_ALLIED].enemy)

		--Objectives
		luaJM5CheckObjectives()

		--Captures
		luaJM5CheckCaptures()

		--Airfields
		--luaJM5Airfield1()
		--luaJM5Airfield2()

		--Japanese fleet
		luaJM5JapFleet()

		--Shipyards
		--luaJM5Shipyard()

		--Event2PT
		luaJM5CheckCapPt()

		--elites
		luaJM5CheckUltimateEnemy()

		--pete
		luaJM5PeteSkill()

		--speedcheat
		--luaJM5IsInSpeedZone()

		if Mission.MissionPhase == 1 then
			--cheat
			if this.Cheat_PhaseShift then
				SetCommandBuildingOwnerPlayer(Mission.RadarStation,  PLAYER_1)
				SetCommandBuildingOwnerPlayer(FindEntity("SecondaryCommandBuilding 01"), PLAYER_1)
				--luaJM5CheatPutFleet()
				--SetParty(Mission.RadarStation, PARTY_JAPANESE)
				--SetParty(Mission.Airfields[2], PARTY_JAPANESE)
				this.Cheat_PhaseShift = false
			end

			if not Mission.AirGroupDelay then
				luaDelay(luaJM5JapAirGroup, 90)
				Mission.AirGroupDelay = truen
			else
				if Mission.LastJapAirSpawn > 0 then
					luaJM5JapAirGroup()
				end
			end
		end

		if Mission.MissionPhase == 2 then
			--cheat
			if this.Cheat_PhaseShift then
				SetCommandBuildingOwnerPlayer(FindEntity("MainCommandBuilding 01"), PLAYER_1)
				--SetParty(Mission.Airfields[1], PARTY_JAPANESE)
				this.Cheat_PhaseShift = false
			end

			luaJM5JapAirGroup()
		end

		--event controls
		if Mission.EventsEnabled then
			if Mission.Event and Mission.Event.Finished then
					--Mission.CurrentEventTable = nil
					--Mission.Event = {}
					luaDelay(luaJM5EventFlags, Mission.EventIntervals)
					Mission.EventsEnabled = false
			end

			if not Mission.CurrentEventTable and Mission.MissionPhase < 2 and FindEntity("MainCommandBuilding 01").Party == PARTY_ALLIED then
				luaJM5GetNewEvent()
				Mission.CurrentEventTable.Phase = 0
				Mission.Event = {}
			end

			luaJM5EventManager()
		end

		--if Mission.MissionPhase == 3 then
			--cheat
			--if this.Cheat_PhaseShift then
			--	if Mission.AlliedFleet and table.getn(luaRemoveDeadsFromTable(Mission.AlliedFleet)) > 0 then
			--		for idx,unit in pairs(Mission.AlliedFleet) do
			--			Kill(unit,true)
			--		end
			--	end
			--	this.Cheat_PhaseShift = false
			--end

			--luaJM5JapAirGroup()

			--AlliedFleet
			--luaJM5AlliedFleet()
			--Paratroopers
			--luaJM5CheckParatroopers()
		--end

	end

	--debug ONLY
	--luaJM5Airfield2Stock()
	--luaJM5LogUnitInfo()

end

function luaJM5CheckCapPt()
	if Mission.CapPt and Mission.CapPt.Party == PARTY_ALLIED and not Mission.CapPt.Dead then
		local planes = luaGetPlanesAround(Mission.CapPt, 300, "enemy")
		if planes ~= nil then
			for idx2,unit in pairs(planes) do
				if IsUnitSelectable(unit) and GetPosition(unit).y < 50 and GetEntitySpeed(unit) < 10 then
					SetParty(Mission.CapPt, PARTY_JAPANESE)
					SetGuiName(Mission.CapPt, "ijn05.captured_pt")
					NavigatorEnable(Mission.CapPt, true)
					AAEnable(Mission.CapPt,true)
					TorpedoEnable(Mission.CapPt,true)
					RemoveUntouchableUnit(Mission.CapPt)
					SetRoleAvailable(Mission.CapPt, EROLF_ALL, PLAYER_1)
				end
			end
		end
	end
end

function luaJM5StartMsg()
	EnableInput(false)
	Blackout(true,"",true)
	luaJM5SetGuiNames()
	luaDelay(luaJM5StartMsgClb, 1.5)
 	luaDelay(luaCheckSavedCheckpoint,0.5)
end

function luaJM5StartMsgClb()
	--luaCheckSavedCheckpoint() ---stepphase az elejen nem olyan jo...
	--SoundFade(1, "",0.1)
	luaDelay(luaJM5EnableInput, 1.5)

  if not Mission.CheckpointLoaded then
  	Blackout(false, "", 1.5)
  	luaJM5StepPhase()
  end
end

function luaJM5EnableInput()
	EnableInput(true)
	luaDelay(luaJM5FirstDlg, 4)
end

function luaJM5FirstDlg()
	--luaJM5StartDialog("Intro2")
	luaJM5ShowHintorDlg("Intro2",0)
end

--Airfield1
function luaJM5AF1ManagerInit(this)
	--luaLog("AFM1 called")
	SetThink(this, "luaJM5AF1Manager_think")
end

function luaJM5AF1Manager_think(this, msg)
	if luaMessageHandler (this, msg) == "killed" then
		return
	end
	SetWait(this, Mission.Airfields[1].ThinkTime)
	luaJM5Airfield1()
end

--Airfield2
function luaJM5AF2ManagerInit(this)
	--luaLog("AFM2 called")
	SetThink(this, "luaJM5AF2Manager_think")
end

function luaJM5AF2Manager_think(this, msg)
	if luaMessageHandler (this, msg) == "killed" then
		return
	end
	SetWait(this, Mission.Airfields[2].ThinkTime)
	luaJM5Airfield2()
end

function luaJM5Airfield1()
	--luaLog("AFM1 Call "..tostring(math.floor(GameTime())))
	local Airfield = Mission.Airfields[1]

	--luaLog("---Airfield1")
	--luaLog(Airfield.Dead)
	--luaLog(Airfield.Party)

	if Airfield.Dead or luaJM5IsDisabled(Airfield) or Airfield.Party ~= PARTY_ALLIED then
		--luaLog("Main Airfield dead or captured")
		local activeSquads, planeEntTable = luaGetSlotsAndSquads(Airfield)
		if planeEntTable ~= nil then
			--luaLog("Active squads")
			for idx,unit in pairs(planeEntTable) do
				if unit.Party == PARTY_ALLIED and GetProperty(unit,"ammoType") == 0 and not unit.retreating then
					--luaLog(unit.Name.." retreates")
					PilotRetreat(unit)
					unit.retreating = true
				end
			end
		end
		--luaLog("No active squads")
		return
	end

	local FighterCLIDs = {
			[1] = 135 --Warhawk
		}
	local OtherCLIDs = {
			--[1] = 118, --B25
			[1] = 108, --Avenger
			--[2]	= 108, --Dauntless
		}
		--fleet targeting
		if table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Cruisers)) > 0 then
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Cruisers))
		elseif table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Destroyers)) > 0 then
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Destroyers))
		else
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Cargos), 500)
		end
end

function luaJM5Airfield2()
	--luaLog("AFM2 Call "..tostring(math.floor(GameTime())))
	local Airfield = Mission.Airfields[2]

	--luaLog("---Airfield2")
	--luaLog(Airfield.Dead)
	--luaLog(Airfield.Party)

	if Airfield.Dead or luaJM5IsDisabled(Airfield) or Airfield.Party ~= PARTY_ALLIED then
		--luaLog("Sec Airfield dead or captured")
		Mission.Airfields[1].ThinkTime = 3
		local activeSquads, planeEntTable = luaGetSlotsAndSquads(Airfield)
		if planeEntTable ~= nil then
			--luaLog("Active squads")
			for idx,unit in pairs(planeEntTable) do
				if unit.Party == PARTY_ALLIED and GetProperty(unit,"ammoType") == 0 and not unit.retreating then
					PilotRetreat(unit)
					--luaLog(unit.Name.." retreates")
					unit.retreating = true
				end
			end
		end
		--luaLog("No active squads")
		return
	end

		local FighterCLIDs = {
			[1] = 135 --Warhawk
		}
		local OtherCLIDs = {
			--[1] = 113, --Avenger
			[1] = 112, --Devastator
			[2] = 108, --Dauntless
		}
		if table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)) > 0 then
			--luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Cargos))
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Destroyers))
		elseif table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Destroyers)) > 0 then
			--luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Destroyers))
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, luaRemoveDeadsFromTable(Mission.JapUnits.Cargos), 200)
		end
end

function luaJM5EmptyAirfieldStock(airbaseNum)
	local airbase = Mission.Airfields[airbaseNum]
	if airbase == nil then
		--luaLog("Wrong airbase ent")
		return
	end
	--luaLog("luaJM5EmptyAirfieldStock called on "..airbase.Name)
	RemoveAllAirBasePlanes(airbase)

	if Mission.SMBanned then
		PermitSupportmanager()
		--luaJM5SMHint()
		Mission.SMBanned = nil
	end

end

function luaJM5SpawnJapAirGroup()
	--luaLog("luaJM5SpawnJapAirGroup called")

	local spawnPoint = GetPosition(Mission.IJNSpawnPoint)
		spawnPoint.y = 450

	local groupMembers = {
		[1] = {
			--[[{
				["Type"] = 158,
				["Name"] = "D3A Val",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = 150,
				["Name"] = "A6M Zero",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},]]
		},
		[2] = {
			--[[{
				["Type"] = 150,
				["Name"] = "A6M Zero",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},]]
			{
				["Type"] = 158,
				["Name"] = "D3A Val",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		[3] = {
			--[[{
				["Type"] = 150,
				["Name"] = "A6M Zero",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},]]
			{
				["Type"] = 158,
				["Name"] = "D3A Val",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = 158,
				["Name"] = "D3A Val",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		}
	}

	if not Mission.Zero or Mission.Zero.Dead then
		local zeroTbl = {
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Crew"] = Mission.SkillLevel,
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 0,
		}
		table.insert(groupMembers[Mission.UnlockLvl], zeroTbl)
		--luaLog("Adding zero to grpmembers")
	end

	if table.getn(groupMembers[Mission.UnlockLvl]) == 0 then
		return
	end

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = groupMembers[Mission.UnlockLvl],
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = spawnPoint, --Mission.Airfields[2], -- or: { ["x"] = 1500, ["y"] = 0, ["z"] = -150 },
		--["angleRange"] = { -1, 1 },
		["angleRange"] = { luaJM5RAD(180), luaJM5RAD(270)},
		["lookAt"] = GetPosition(Mission.RadarStation)
	},
	["callback"] = "luaJM5JapAirGroupSpawned",
	["id"] = Mission.JapAirSpawnReq,
})

end

function luaJM5JapAirGroupSpawned(...)
	--luaLog("luaJM5JapAirGroupSpawned called with "..table.getn(arg).." arg(s)")

	local spawnedSquads = {}
		for i,v in ipairs(arg) do
			table.insert(spawnedSquads, v)
		end

	Mission.Vals = {}

	for idx,unit in pairs(spawnedSquads) do
		SetSkillLevel(unit, Mission.SkillLevel)
		if unit.Class.Type == "Fighter" then
			Mission.Zero = unit
			luaJM5ZeroHint()
			if table.getn(luaRemoveDeadsFromTable(Mission.PlayerUnits)) > 0 then
				local trgUnit
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerUnits)) do
					if not unit.Dead then
						trgUnit = unit
						break
					end
				end
				PilotMoveTo(Mission.Zero, trgUnit)
			end
		else
			table.insert(Mission.Vals, unit)
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end
	end

	--luaLog("last spawn time")
	--luaLog(math.floor(GameTime()))

	Mission.LastJapAirSpawn = math.floor(GameTime())

	local currTrg
	local ownField
	local targets = {}
		table.insert(targets, Mission.Airfields[2])
		table.insert(targets, Mission.Airfields[1])
		table.insert(targets, Mission.Shipyards[1])
		table.insert(targets, Mission.Shipyards[2])

	for idx,trg in pairs(targets) do
		if not trg.Dead and not luaJM5IsDisabled(trg) and trg.Party == PARTY_ALLIED then
			currTrg = trg
			break
		elseif not ownField and not trg.Dead and trg.Party  == PARTY_JAPANESE and string.find(trg.Name, "Airfield") then
			ownField = trg
		end
	end

	if currTrg ~= nil then
		for idx,unit in pairs(Mission.Vals) do
			luaSetScriptTarget(unit, currTrg)
			luaJM5ShowHintorDlg("FirstJapAirSpawn",0)
		end
	elseif currTrg == nil and ownField ~= nil then
		for idx,unit in pairs(Mission.Vals) do
			PilotLand(unit, ownField)
		end
		--if Mission.Zero and not Mission.Zero.Dead then
			--PilotLand(Mission.Zero, ownField)
		--end
	end
end

function luaJM5JapAirGroup()
	--if (not Mission.Zero or Mission.Zero.Dead) and (not Mission.Vals or table.getn(luaRemoveDeadsFromTable(Mission.Vals)) == 0) then

	local time = math.floor(GameTime())

	if Mission.UnlockLvl > 1 then
		if not Mission.Vals or table.getn(luaRemoveDeadsFromTable(Mission.Vals)) == 0 then

			--luaLog("Jap aircover")
			--luaLog(time)
			--luaLog(Mission.LastJapAirSpawn)

		if time - Mission.LastJapAirSpawn < Mission.JapAirSpawnInterval then
			return
		end

		if not SpawnNewIDIsRequested(Mission.JapAirSpawnReq) and ((time - Mission.Time0) > 30) then
			--luaLog("Requesting Jap Airgroup spawn")
			luaJM5SpawnJapAirGroup()
		else
			--luaLog("Jap Airgroup is being spawned")
		end

		else

			Mission.Vals = luaRemoveDeadsFromTable(Mission.Vals)
			--Zero
			--[[
			if Mission.Zero and not Mission.Zero.Dead and table.getn(Mission.Vals) ~= 0 then
				if luaGetScriptTarget(Mission.Zero) == nil then
					local trg
					local planesAroundTable = luaGetPlanesAround(Mission.Zero, 1500, "enemy")

					if planesAroundTable ~= nil then
						--luaLog("planesAroundTable")
						--luaLog(planesAroundTable)

						for idx,unit in pairs(planesAroundTable) do
							if unit.Type == "Fighter" and luaGetDistance(Mission.Zero, unit) < 1500 then
								trg = unit
								break
							end
						end
						if not trg then
							trg = luaPickRnd(planesAroundTable)
						end
						luaSetScriptTarget(Mission.Zero, trg)

					else
						--UnitFreeFire(Mission.Zero)
						if not Mission.Vals[1].Dead then
							PilotMoveTo(Mission.Zero, Mission.Vals[1])
						end
					end
				end

			elseif Mission.Zero and not Mission.Zero.Dead and table.getn(Mission.Vals) == 0 then
				local cmd = GetProperty(Mission.Zero, "unitcommand")
				--luaLog("Zero unitcmd "..cmd)
				if cmd ~= "land" then
					if not Mission.Airfields[2].Dead and Mission.Airfields[2].Party == PARTY_JAPANESE then
						PilotLand(Mission.Zero, Mission.Airfields[2])
					elseif not Mission.Airfields[1].Dead and Mission.Airfields[1].Party  == PARTY_JAPANESE then
						PilotLand(Mission.Zero, Mission.Airfields[1])
					end
					if cmd ~= "retreat" then --csak 1x adjuk ki
						PilotRetreat(Mission.Zero)
					end
				end
			end
			]]
			--Val
			if table.getn(Mission.Vals) ~= 0 then
				for idx,unit in pairs(Mission.Vals) do

					local cmd = GetProperty(unit, "unitcommand")
					local planeAmmo = GetProperty(unit, "ammoType")

					--nincs ammo, leszallunk vagy lelepunk
					if planeAmmo == 0 then
						--luaLog("nincs ammo, leszallunk vagy lelepunk")
						if cmd ~= "land" then
							if not Mission.Airfields[2].Dead and Mission.Airfields[2].Party == PARTY_JAPANESE then
								PilotLand(unit, Mission.Airfields[2])
								--luaLog("landing on airfield2")
								--luaJM5StartDialog("AirfieldCaptured_Vals", true)
								luaJM5ShowHintorDlg("AirfieldCaptured_Vals",0)
							elseif not Mission.Airfields[1].Dead and Mission.Airfields[1].Party  == PARTY_JAPANESE then
								PilotLand(unit, Mission.Airfields[1])
								--luaLog("landing on airfield1")
							end

							local cmd = GetProperty(unit, "unitcommand") --updateunittable2
							if cmd ~= "retreat" and cmd ~= "land" then
								PilotRetreat(unit)
								--luaLog("retreating")
							end
						end

					elseif planeAmmo ~= 0 and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Party ~= PARTY_ALLIED) then

						-- van ammo de nincs trg
						--luaLog("van ammo de nincs trg")
						luaSetScriptTarget(unit, nil)
						local targets = {}
							table.insert(targets, Mission.Airfields[2])
							table.insert(targets, Mission.Airfields[1])
							table.insert(targets, Mission.Shipyards[1])
							table.insert(targets, Mission.Shipyards[2])

							if Mission.MissionPhase == 3 then
								local ships = luaGetShipsAround(unit, 15000, "enemy")
								if ships ~= nil and next(ships) ~= nil then
									for idx,ship in pairs(ships) do
										if ship.Class.Type ~= "Submarine" then
											table.insert(targets, ship)
										end
									end
								end
							end

							luaJM5GetEnemyArtillery()
							if next(Mission.CoastalGuns) ~= nil then
								for idx,gun in pairs(Mission.CoastalGuns) do
									if gun.Party == PARTY_ALLIED then
										table.insert(targets, gun)
									end
								end
							end

						for idx,trg in pairs(targets) do
							if not trg.Dead and not luaJM5IsDisabled(trg) and trg.Party == PARTY_ALLIED then
								luaSetScriptTarget(unit, trg)
								PilotSetTarget(unit, trg)

								if not Mission.TrgDlg and trg.ID == Mission.Airfields[2].ID then
									--luaJM5StartDialog("Vals_going",true)
									luaJM5ShowHintorDlg("Vals_going",0)
									Mission.TrgDlg = true
								end

								--luaLog("Val gets a new target "..trg.Name)
								break
							end
						end

						--ha nincse trg akkor leszallunk
						local cmd = GetProperty(unit, "unitcommand") --updateunittable2
						if luaGetScriptTarget(unit) == nil and cmd ~= "land" then
							if not Mission.Airfields[2].Dead and Mission.Airfields[2].Party == PARTY_JAPANESE then
								PilotLand(unit, Mission.Airfields[2])
								--luaLog("landing on airfield2")
							elseif not Mission.Airfields[1].Dead and Mission.Airfields[1].Party  == PARTY_JAPANESE then
								PilotLand(unit, Mission.Airfields[1])
								--luaLog("landing on airfield1")
							end
						end

					end
				end
			end

		end

	else --unlocklvl
		if (not Mission.Zero or Mission.Zero.Dead) then
			if time - Mission.LastJapAirSpawn < Mission.JapAirSpawnInterval then
				return
			else
				if not SpawnNewIDIsRequested(Mission.JapAirSpawnReq) then
					luaJM5SpawnJapAirGroup()
				end
			end
		end
	end

end

function luaJM5ShipyardDelayedCheck()
	luaJM5Shipyard()
	luaDelay(luaJM5ShipyardDelayedCheck, Mission.ShipyardCheckInterval)
end

function luaJM5Shipyard()
	--luaLog("luaJM5Shipyard called")
	local Shipyard1 = Mission.Shipyards[1]
	local Shipyard2 = Mission.Shipyards[2]

	--Shipyard1
	if Shipyard1.Dead or Shipyard1.Party == PARTY_JAPANESE or (Mission.MissionPhase < 2) then
		--luaLog("Shipyard1 is dead or captured by the player")
		if SpawnNewIDIsRequested(Mission.Shipyard1SpawnReq) then
			SpawnNewIDRemove(Mission.Shipyard1SpawnReq)
		end
		Shipyard1.spawn = false
	else
		Shipyard1.spawn = true
	end

	Mission.Shipyard1Ships = luaRemoveDeadsFromTable(Mission.Shipyard1Ships)

	if Shipyard1.spawn then
		if table.getn(Mission.Shipyard1Ships) < Mission.MaxAllowedShipyard1Ships then
			if math.floor(GameTime()) - Mission.LastShipyard1Spawned > Mission.Shiyard1SpawnInterval then
				if not SpawnNewIDIsRequested(Mission.Shipyard1SpawnReq) then
					--luaLog("Requesting Elco spawn")
					luaJM5SpawnShipyardShip(1,27,nil,true)
					Mission.LastShipyard1Spawned = math.floor(GameTime())
				else
					--luaLog("Elco is being spawned")
				end
			end
		end
	end

	for idx, unit in pairs(Mission.Shipyard1Ships) do
		if not unit.Dead and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) then
			local shipsAroundTable
			if Mission.RadarStation.Party == PARTY_ALLIED then
				shipsAroundTable = luaGetShipsAround(unit, 15000, "enemy")
			else
				--luaLog("Radarstation captured")
				shipsAroundTable = luaJM5GetVisibleShips(PARTY_ALLIED)
			end
			if shipsAroundTable ~= nil and next(shipsAroundTable) ~= nil then
				local trg = shipsAroundTable[1]
				luaSetScriptTarget(unit, trg)
				if Mission.Difficulty >= 1 then
					TorpedoEnable(unit, true)
				end
				NavigatorAttackMove(unit, trg, {})
			else
				--luaLog("No visible target")
			end
		end
	end


	--Shipyard2
	if Shipyard2.Dead or Shipyard2.Party == PARTY_JAPANESE then
		--luaLog("Shipyard2 is dead or captured by the player")
		if SpawnNewIDIsRequested(Mission.Shipyard2SpawnReq) then
			SpawnNewIDRemove(Mission.Shipyard2SpawnReq)
		end
		Shipyard2.spawn = false
	else
		Shipyard2.spawn = true
	end

	Mission.Shipyard2Ships = luaRemoveDeadsFromTable(Mission.Shipyard2Ships)

	if Shipyard2.spawn then
		if Mission.FirstSpawn and not Mission.CheckpointLoaded then
			luaJM5SpawnShipyardShip(2,25,nil,false)
			--luaJM5SpawnShipyardShip(2,25,nil,false)
			luaJM5SpawnShipyardShip(2,23,nil,false)
			Mission.FirstSpawn = false
		else
			if table.getn(Mission.Shipyard2Ships) < Mission.MaxAllowedShipyard2Ships then
				if math.floor(GameTime()) - Mission.LastShipyard2Spawned > Mission.Shiyard2SpawnInterval then
					if not SpawnNewIDIsRequested(Mission.Shipyard2SpawnReq) then
						--luaLog("Requesting Fletcher spawn")
						luaJM5SpawnShipyardShip(2,25,nil,true)
						Mission.LastShipyard2Spawned = math.floor(GameTime())
					else
						--luaLog("Fletcher is being spawned")
					end
				end
			end
		end
	end

	if table.getn(Mission.Shipyard2Ships) == 0 then
		--luaLog("No allied DDs")
		return
	end

	if Mission.Shipyard2Ships[2] and not IsInFormation(Mission.Shipyard2Ships[2]) then
		--luaLog("2nd Fletcher is not in formation, joining her to the 1st Fletcher")
		JoinFormation(Mission.Shipyard2Ships[2], Mission.Shipyard2Ships[1])
	end

	local leader = GetFormationLeader(Mission.Shipyard2Ships[1])
	if leader == nil then
		leader = Mission.Shipyard2Ships[1]
		--luaLog("No leader found")
	end
	local trg = luaGetScriptTarget(leader)
	--if trg == nil then
		--luaLog("No target for DD")
	--end

	if Mission.Need2Capture then
		--Spawning AKs
		Mission.Shipyard2Cargos = luaRemoveDeadsFromTable(Mission.Shipyard2Cargos)

		if table.getn(Mission.Shipyard2Cargos) < Mission.MaxAllowedAlliedCargos then
			--luaLog("Calling cargo spawn")
			if not SpawnNewIDIsRequested(Mission.AlliedCargoSpawnReq) then
				--luaLog("Requesting cargo spawn")
				luaJM5SpawnShipyardShip(2,36) --2.nd shipyard 36 Vehicle Class (US TroopTransport)
			else
				--luaLog("Cargo is being spawned")
			end
		end
		--AK landing here
		if table.getn(Mission.Shipyard2Cargos) > 1 then
			for idx,unit in pairs(Mission.Shipyard2Cargos) do
				--luaLog("Shipyard2 cargo "..unit.Name.." "..GetProperty(unit, "unitcommand"))
				if not unit.Dead and unit.toCapTrg ~= nil then
					if luaGetDistance(unit, unit.toCapTrg) < 200 then
						--luaLog("Start cargo landing")
						NavigatorStop(unit)
						local err = StartLanding2(unit)
						local errTbl = {}
							errTbl["0"] = "Big landing ship elindult partraszállni"
							errTbl["1"] = "1 kislandig elindult"
							errTbl["2"] = "2 kislandig elindult"
							errTbl["3"] = "3 kislandig elindult"
							errTbl["4"] = "4 kislandig elindult"
							errTbl["5"] = "5 kislandig elindult"
							errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
							errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
							errTbl["-3"] = "Nemrég indított már, és még cooldown van"
							errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
							errTbl["-5"] = "Nincs command building a pályán"
							errTbl["-6"] = "Csak saját command building van a pályán"
							errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
							--luaLog(errTbl[tostring(err)])
							--luaLog(err)
						else
							local cmd = GetProperty(unit, "unitcommand")
							if cmd ~= "moveto" and IsInFormation(unit) and GetFormationLeader(unit).ID == unit.ID then
								NavigatorMoveToRange(unit, unit.toCapTrg)
							end
						end
				elseif not unit.Dead and unit.toCapTrg == nil then
					luaJM5GetCaptarget()
				end
			end
		end
	end

	if trg == nil or trg.Dead then
		local trg
		Mission.JapUnits.Cargos = luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)

		local shipsAroundTable
		if Mission.RadarStation.Party == PARTY_ALLIED then
			--if table.getn(Mission.JapUnits.Cargos) ~= 0 then
			--	shipsAroundTable = Mission.JapUnits.Cargos
			--else
				shipsAroundTable = luaGetShipsAround(leader, 15000, "enemy")
			--end
		else
			--luaLog("Radarstation captured")
			shipsAroundTable = luaJM5GetVisibleShips(PARTY_ALLIED)
		end
		if shipsAroundTable ~= nil and next(shipsAroundTable) ~= nil then
				trg = shipsAroundTable[1]
				luaSetScriptTarget(leader, trg)
				if Mission.Difficulty >= 1 then
					TorpedoEnable(leader, true)
				end
				NavigatorAttackMove(leader, trg, {})
		else
			if not leader.followingAKs and table.getn(Mission.Shipyard2Cargos) > 0 then
				luaSetScriptTarget(leader, nil)
				NavigatorMoveToRange(leader, Mission.Shipyard2Cargos[1])
				leader.followingAKs = true
				--luaLog("DDs moving towards Cargos")
			end
			--luaLog("No visible target 2")
		end
	end
end

function luaJM5SpawnShipyardShip(shipyardNum, unitClass, unitName, rnd)

	local cb = {"luaJM5Shipyard1Spawned", "luaJM5Shipyard2Spawned"}
	local sIDTbl = {Mission.Shipyard1SpawnReq, Mission.Shipyard2SpawnReq, Mission.AlliedCargoSpawnReq}
	local SID
	if VehicleClass[unitClass].Type == "Cargo" then
		SID = sIDTbl[3]
	else
		SID = sIDTbl[shipyardNum]
	end

	if unitName == nil then
		unitName = VehicleClass[unitClass].Name
	end

	local crewLvl
	if Mission.AllElites then
		crewLvl = SKILL_ELITE
	else
		crewLvl = Mission.SkillLevel
	end

	local grpTbl = {
		{
			["Type"] = unitClass,
			["Name"] = unitName,
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
	}


		--[[
		local rndMax

		if shipyardNum == 1 then
			rndMax = Mission.MaxAllowedShipyard1Ships - table.getn(luaRemoveDeadsFromTable(Mission.Shipyard1Ships))
		elseif shipyardNum == 2 then
			rndMax = Mission.MaxAllowedShipyard2Ships - table.getn(luaRemoveDeadsFromTable(Mission.Shipyard2Ships))
		end

		if not rndMax or rndMax < 1 then
			rndMax = 1
		end

		if rnd then
			local rndNum = random(1,rndMax)
			for i=1,rndNum do
				if i==3 and shipyardNum == 2 then
					table.insert(grpTbl, {["Type"] = 23,["Name"] = "Fletcher",["Crew"] = 1,["Race"] = USA,} )
				else
					table.insert(grpTbl, {["Type"] = unitClass,["Name"] = unitName,["Crew"] = 1,["Race"] = USA,} )
				end
			end
		end
		]]

		local rnd = random(1,100)
		if rnd <= 15 then
			if shipyardNum == 2 then
				table.insert(grpTbl, {["Type"] = 23,["Name"] = "Fletcher",["Crew"] = 1,["Race"] = USA,} )
			end
		else
			table.insert(grpTbl, {["Type"] = unitClass,["Name"] = unitName,["Crew"] = 1,["Race"] = USA,} )
		end

	--luaLog(grpTbl)

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = Mission.ShipyardSpawnPoint[shipyardNum],
		--["angleRange"] = { 2, 4 },
		--["angleRange"] = { 1.575, 2.1 },
		["angleRange"] = { luaJM5RAD(45), luaJM5RAD(155) },
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	--["callback"] = "luaJM5Shipyard"..tostring(shipyardNum).."Spawned",
	--["callback"] = "luaJM5Shipyard1Spawned",
	["callback"] = cb[shipyardNum],
	["id"] = SID,
	})
end

function luaJM5Shipyard1Spawned(...)

	--luaLog("spawnedunit")
	--luaLog(spawnedUnit)
	for idx,spawnedUnit in ipairs(arg) do
		SetSkillLevel(spawnedUnit, Mission.SkillLevel)
		if spawnedUnit.Class.ID == 25 then
			SetGuiName(spawnedUnit, Mission.SpawnNames.Clemson[Mission.ClemsonNameCounter][1])
			luaJM5SetShipNumber(spawnedUnit, Mission.SpawnNames.Clemson[Mission.ClemsonNameCounter][2])
				if Mission.ClemsonNameCounter < 14 then
					Mission.ClemsonNameCounter = Mission.ClemsonNameCounter + 1
				else
					Mission.ClemsonNameCounter = 1
				end
		elseif spawnedUnit.Class.ID == 27 then
			local numma = luaRnd(200,400)
			SetGuiName(spawnedUnit, "ingame.shipnames_pt|."..tostring(numma))
		elseif spawnedUnit.Class.ID == 23 then
			SetGuiName(spawnedUnit, Mission.SpawnNames.Flecsi[Mission.FletcherNameCounter][1])
			luaJM5SetShipNumber(spawnedUnit, Mission.SpawnNames.Flecsi[Mission.FletcherNameCounter][2])
				if Mission.FletcherNameCounter < 17 then
					Mission.FletcherNameCounter = Mission.FletcherNameCounter + 1
				else
					Mission.FletcherNameCounter = 1
				end
		elseif spawnedUnit.Class.ID == 36 then
			SetGuiName(spawnedUnit, Mission.SpawnNames.Transport[Mission.CargoCounter])
-- RELEASE_LOGOFF  			luaLog("cargo spawn, setting shipnumber to 0")
			SetNumbering(spawnedUnit, 0)
			if Mission.CargoCounter < 8  then
				Mission.CargoCounter = Mission.CargoCounter + 1
			else
				Mission.CargoCounter = 1
			end
		end


		table.insert(Mission.Shipyard1Ships, spawnedUnit)
		if spawnedUnit.Class.Type == "Destroyer" then
			ShipSetTorpedoStock(spawnedUnit, 2)
		end
		if Mission.Difficulty >= 1 then
			TorpedoEnable(spawnedUnit, true)
		end
	end
end

function luaJM5Shipyard2Spawned(...)
	Mission.Shipyard2Ships = luaRemoveDeadsFromTable(Mission.Shipyard2Ships)

	--luaLog("spawnedunit2")
	--luaLog(spawnedUnit)

	for idx,spawnedUnit in ipairs(arg) do
		if spawnedUnit.Class.Type ~= "Cargo" then
			table.insert(Mission.Shipyard2Ships, spawnedUnit)
			if table.getn(Mission.Shipyard2Ships) > 1 then
				JoinFormation(spawnedUnit, Mission.Shipyard2Ships[1])
			end

			if spawnedUnit.Class.ID == 25 then
				SetGuiName(spawnedUnit, Mission.SpawnNames.Clemson[Mission.ClemsonNameCounter][1])
				luaJM5SetShipNumber(spawnedUnit, Mission.SpawnNames.Clemson[Mission.ClemsonNameCounter][2])
					if Mission.ClemsonNameCounter < 14 then
						Mission.ClemsonNameCounter = Mission.ClemsonNameCounter + 1
					else
						Mission.ClemsonNameCounter = 1
					end
			elseif spawnedUnit.Class.ID == 27 then
				local numma = luaRnd(200,400)
				SetGuiName(spawnedUnit, "ingame.shipnames_pt|."..tostring(numma))
			elseif spawnedUnit.Class.ID == 23 then
				SetGuiName(spawnedUnit, Mission.SpawnNames.Flecsi[Mission.FletcherNameCounter][1])
				luaJM5SetShipNumber(spawnedUnit, Mission.SpawnNames.Flecsi[Mission.FletcherNameCounter][2])
					if Mission.FletcherNameCounter < 17 then
						Mission.FletcherNameCounter = Mission.FletcherNameCounter + 1
					else
						Mission.FletcherNameCounter = 1
					end
			end

		else
			--luaLog("Cargos spawned")
			table.insert(Mission.Shipyard2Cargos, spawnedUnit)

			SetGuiName(spawnedUnit, Mission.SpawnNames.Transport[Mission.CargoCounter])
-- RELEASE_LOGOFF  			luaLog("cargo spawn, setting shipnumber to 0")
			SetNumbering(spawnedUnit, 0)

			if Mission.CargoCounter < 8  then
				Mission.CargoCounter = Mission.CargoCounter + 1
			else
				Mission.CargoCounter = 1
			end
			luaJM5GetCaptarget()
		end
	end
end

function luaJM5GetCaptarget()
	--luaLog("luaJM5GetCaptarget called")
	Mission.Shipyard2Cargos = luaRemoveDeadsFromTable(Mission.Shipyard2Cargos)
	if table.getn(Mission.Shipyard2Cargos) == 0 then
		--luaLog("luaJM5GetCaptarget called, no cargos")
	end

	local priorTbl = {Mission.Airfields[1].ID, Mission.Airfields[2].ID, Mission.Shipyards[1].ID, Mission.Shipyards[2].ID, Mission.RadarStation.ID}
	local toCapTbl = {}
	local toCap

	if table.getn(Mission.Units2Recapture) > 0 then
		for idx,unit in pairs(Mission.Units2Recapture) do
			for idx,priorID in pairs(priorTbl) do
				if unit.ID == priorID then
					local toCapName = thisTable[tostring(priorID)].Name
					if string.find(toCapName, "SecondaryAirField") then
						toCapTbl = Mission.SecCapPoints
						--luaJM5StartDialog("AirfieldCaptured2",true)
						luaJM5ShowHintorDlg("AirfieldCaptured2",0)
					elseif string.find(toCapName, "Radar") then
						toCapTbl = Mission.RadarCapPoints
					else
						toCapTbl = Mission.MainCapPoints
					end

					local dist = 10000000
					for idx,coord in pairs(toCapTbl) do
						local currDist = luaGetDistance(Mission.Shipyard2Cargos[1], coord)
						if currDist < dist then
							dist = currDist
							toCap = coord
						end
					end
					break
				end
			end
		end
	end

	--luaLog(toCapTbl)
	--luaLog(toCap)

	if Mission.Shipyard2Cargos[1].toCapTrg == nil or Mission.Shipyard2Cargos[1].toCapTrg.Party == PARTY_ALLIED then
		Mission.Shipyard2Cargos[1].toCapTrg = toCap
		NavigatorMoveToRange(Mission.Shipyard2Cargos[1], toCap)
	end

	for idx,unit in pairs(Mission.Shipyard2Cargos) do
		if idx > 1 and not IsInFormation(unit) then
			JoinFormation(unit, Mission.Shipyard2Cargos[1])
			unit.toCapTrg = Mission.Shipyard2Cargos[1].toCapTrg
		end
	end
end

function luaJM5GetVisibleShips(searchedParty)
	--luaLog("Visible enemy ships")
	local tbl = {}
	--luaLog(recon[PARTY_ALLIED].enemy)
	--destroyer
	if recon[searchedParty].enemy.destroyer ~= nil and next(recon[searchedParty].enemy.destroyer) ~= nil then
		--luaLog("Found a destroyer table")
		for idx2,unit in pairs(recon[searchedParty].enemy.destroyer) do
			if not unit.Dead then
				table.insert(tbl, unit)
			end
			--luaLog(unit.Name)
		end
	end
	--cargo
	if recon[searchedParty].enemy.cargo ~= nil and next(recon[searchedParty].enemy.cargo) ~= nil then
		--luaLog("Found a destroyer table")
		for idx2,unit in pairs(recon[searchedParty].enemy.cargo) do
			if not unit.Dead then
				table.insert(tbl, unit)
				--luaLog(unit.Name)
			end
		end
	end
	--cruiser
	if recon[searchedParty].enemy.cruiser ~= nil and next(recon[searchedParty].enemy.cruiser) ~= nil then
		--luaLog("Found a cruiser table")
		for idx2,unit in pairs(recon[searchedParty].enemy.cruiser) do
			if not unit.Dead then
				table.insert(tbl, unit)
				--luaLog(unit.Name)
			end
		end
	end

	if next(tbl) ~= nil then
		---luaLog("Returning a valid table")
		return tbl
	else
		--luaLog("No visible enemies found")
		return nil
	end
end

function luaJM5CheckCaptures()

		--capdlg
		if not Mission.CapDlg then
			luaJM5IsInCaptureRange()
		end

	--if not Mission.Need2Capture then
		if Mission.Airfields[1].Party == PARTY_ALLIED and Mission.Airfields[2].Party == PARTY_ALLIED and Mission.Shipyards[1].Party == PARTY_ALLIED and Mission.Shipyards[2].Party == PARTY_ALLIED and Mission.RadarStation.Party == PARTY_ALLIED then
			Mission.Need2Capture = false
		end

		if Mission.Airfields[1].Party == PARTY_JAPANESE and not luaIsInside(Mission.Airfields[1], Mission.Units2Recapture) then
			Mission.Need2Capture = true
			luaJM5EmptyAirfieldStock(1)
			if not Mission.FirstAFCapture then
				luaJM5AF1StockFillup(Mission.Airfields[1])
				Mission.FirstAFCapture = true
			end
			table.insert(Mission.Units2Recapture, Mission.Airfields[1])
		end

		if Mission.Airfields[2].Party == PARTY_JAPANESE and not luaIsInside(Mission.Airfields[2], Mission.Units2Recapture) then
			Mission.Need2Capture = true
			luaJM5EmptyAirfieldStock(2)
			if not Mission.FirstAF2Cap then
				luaJM5AF1StockFillup2(Mission.Airfields[2])
				Mission.FirstAF2Cap = true
			end
			table.insert(Mission.Units2Recapture, Mission.Airfields[2])
		end

		if Mission.Shipyards[1].Party == PARTY_JAPANESE and not luaIsInside(Mission.Shipyards[1], Mission.Units2Recapture) then
			Mission.Need2Capture = true
			table.insert(Mission.Units2Recapture, Mission.Shipyards[1])
		end

		if Mission.Shipyards[2].Party == PARTY_JAPANESE and not luaIsInside(Mission.Shipyards[2], Mission.Units2Recapture) then
			Mission.Need2Capture = true
			table.insert(Mission.Units2Recapture, Mission.Shipyards[2])
		end

		if Mission.RadarStation.Party == PARTY_JAPANESE and not luaIsInside(Mission.RadarStation, Mission.Units2Recapture) then
			Mission.Need2Capture = true
			table.insert(Mission.Units2Recapture, Mission.RadarStation)
		end
	--else


		if table.getn(Mission.Units2Recapture) > 0 then
			for idx,unit in pairs(Mission.Units2Recapture) do
				if unit.Party == PARTY_ALLIED then
						if unit.ID == Mission.Airfields[1] then
							luaJM5EmptyAirfieldStock(1)
						elseif unit.ID == Mission.Airfields[2] then
							luaJM5EmptyAirfieldStock(2)
						end
						table.remove(Mission.Units2Recapture, idx)
				end
			end
		end

	--end
end

function luaJM5CheckAlliedFleetConds()
	if Mission.AlliedFleetSpawnedIn then
		luaJM5FleetScore()
		return
	end

	--if Mission.Need2Capture then
	if Mission.Airfields[1].Party == PARTY_JAPANESE then
		if not SpawnNewIDIsRequested(Mission.AlliedFleetSpawnReq) then
			luaJM5SpawnAlliedFleet()
			Mission.AlliedFleetSpawnedIn = true
		end
	end

	if math.floor(GameTime()) > Mission.AlliedFleetSpawnTime then
		if not SpawnNewIDIsRequested(Mission.AlliedFleetSpawnReq) then
			luaJM5SpawnAlliedFleet()
			Mission.AlliedFleetSpawnedIn = true
		end
	end
end

function luaJM5SpawnAlliedFleet()

	local crewLvl
	if Mission.AllElites then
		crewLvl = SKILL_ELITE
	else
		crewLvl = Mission.SkillLevel
	end

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 19,
			["Name"] = "Chicago",		--CA14
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 20,
			["Name"] = "Hobart",		--DDG26
			["Crew"] = crewLvl,
			["Race"] = AUSTRALIAN,
		},
		{
			["Type"] = 20,
			["Name"] = "Australia",	--D84
			["Crew"] = crewLvl,
			["Race"] = AUSTRALIAN,
		},
		{
			["Type"] = 23,
			["Name"] = "Perkins",		--DD377
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Walke",		--DD416
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Farragut",	--DD300
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.USNSpawnPoint),
		["angleRange"] = { luaJM5RAD(180), luaJM5RAD(270)},
		["lookAt"] = GetPosition(Mission.RadarStation),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM5AlliedFleetSpawned",
})
end

function luaJM5AlliedFleetSpawned(fleet1, fleet2, fleet3, fleet4, fleet5, fleet6)
	Mission.AlliedFleet = {}
		table.insert(Mission.AlliedFleet, fleet1)
		table.insert(Mission.AlliedFleet, fleet2)
		table.insert(Mission.AlliedFleet, fleet3)
		table.insert(Mission.AlliedFleet, fleet4)
		table.insert(Mission.AlliedFleet, fleet5)
		table.insert(Mission.AlliedFleet, fleet6)

	for idx,unit in pairs(Mission.AlliedFleet) do
		SetSkillLevel(unit, Mission.SkillLevel)
		if unit.Class.Type == "Destroyer" and Mission.Difficulty >= 1 then
			TorpedoEnable(unit, true)
		end
		UnitFreeAttack(unit)
		SetGuiName(Mission.AlliedFleet[idx], Mission.AlliedFleetNames[idx][1])
		luaJM5SetShipNumber(Mission.AlliedFleet[idx], Mission.AlliedFleetNames[idx][2])
	end

	Mission.AlliedFleetSpawn = math.floor(GameTime())
	--luaJM5StartDialog("NmiFleetSpawn",true)
	luaJM5ShowHintorDlg("NmiFleetSpawn",0)
	if Mission.RadarStation.Party == PARTY_JAPANESE then
		--luaJM5StartDialog("NmiFleetSpawn_Radar", true)
		luaJM5ShowHintorDlg("NmiFleetSpawn_Radar",0)
	end

	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.AlliedFleet[1].ID)
	--luaJM5AddJumpinMovie("GoAround",Mission.AlliedFleet[1].ID)
	luaJM5AlliedReinfMovie(Mission.AlliedFleet[1])
end

function luaJM5AlliedFleet()
	if Mission.AlliedFleet == nil then
		--luaLog("Allied fleet does not exist")
		return
	end

	Mission.AlliedFleet = luaRemoveDeadsFromTable(Mission.AlliedFleet)

	if next(Mission.AlliedFleet) == nil then
		--luaLog("Allied fleet is dead")
		return
	end

	local leader = GetFormationLeader(Mission.AlliedFleet[1])

	if leader == nil or leader.Dead then
		if not Mission.AlliedFleet[1].Dead then
			leader = Mission.AlliedFleet[1]
		else
			return
		end
	end

	local trg = luaGetScriptTarget(leader)
	--luaLog("Fleet leader is "..leader.Name)
	--luaLog("Leader target")
	--luaLog(trg)

	if trg ~= nil and not trg.Dead then
		--luaLog("Leader's target is still living")
		return
	elseif trg ~= nil and trg.Dead then
		--luaLog("Leader's target is dead")
		trg = nil
	end

	if trg == nil then
		local cargoTbl = luaGetShipsAround(leader, 200000, "enemy", nil, nil, "cargo")
		if cargoTbl ~= nil then
			luaSetScriptTarget(leader, cargoTbl[1])
			NavigatorAttackMove(leader, cargoTbl[1], {})
			--luaLog("Leader's new target is a cargo")
		else
			--luaLog("Running out of cargos")
			if luaGetScriptTarget(leader) == nil or luaGetScriptTarget(leader).Dead then
				if Mission.Airfields[1].Party == PARTY_JAPANESE then
					luaSetScriptTarget(leader, Mission.Airfields[1])
					NavigatorAttackMove(leader, Mission.Airfields[1], {})
				end
			end
		end
	else
			--luaLog("Hmmm")
	end

end

function luaJM5LogUnitInfo()
-- RELEASE_LOGOFF  	luaLog("------------------UNIT DEBUG INFO------------------")
	Mission.Shipyard1Ships = luaRemoveDeadsFromTable(Mission.Shipyard1Ships,"Found dead unit in Shipyard1Ships: ")
	Mission.Shipyard2Ships = luaRemoveDeadsFromTable(Mission.Shipyard2Ships,"Found dead unit in Shipyard2Ships: ")
	Mission.Shipyard2Cargos = luaRemoveDeadsFromTable(Mission.Shipyard2Cargos,"Found dead unit in Shipyard2Cargos: ")
	if Mission.AlliedFleet then
		Mission.AlliedFleet = luaRemoveDeadsFromTable(Mission.AlliedFleet,"Found dead unit in AlliedFleet: ")
	end

-- RELEASE_LOGOFF  	luaLog("--- Shipyard1Ships")
	for idx,unit in pairs(Mission.Shipyard1Ships) do
-- RELEASE_LOGOFF  		luaLog("\t Unit Name: "..unit.Name)
		local command = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  		luaLog("\t Unit Command: "..command)
	end

-- RELEASE_LOGOFF  	luaLog("--- Shipyard2Ships")
	for idx,unit in pairs(Mission.Shipyard2Ships) do
-- RELEASE_LOGOFF  		luaLog("\t Unit Name: "..unit.Name)
		local command = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  		luaLog("\t Unit Command: "..command)
	end

-- RELEASE_LOGOFF  	luaLog("--- Shipyard2Cargos")
	for idx,unit in pairs(Mission.Shipyard2Cargos) do
-- RELEASE_LOGOFF  		luaLog("\t Unit Name: "..unit.Name)
		local command = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  		luaLog("\t Unit Command: "..command)
	end

-- RELEASE_LOGOFF  	luaLog("--- AlliedFleet")
	if Mission.AlliedFleet then
		for idx,unit in pairs(Mission.AlliedFleet) do
-- RELEASE_LOGOFF  			luaLog("\t Unit Name: "..unit.Name)
			local command = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  			luaLog("\t Unit Command: "..command)
		end
	end

-- RELEASE_LOGOFF  	luaLog("--- JapaneseFleet")
	for Tblidx,unitTbl in pairs(Mission.JapUnits) do
		for idx, unit in pairs(unitTbl) do
-- RELEASE_LOGOFF  			luaLog("\t Unit Name: "..unit.Name)
			local command = GetProperty(unit, "unitcommand")
-- RELEASE_LOGOFF  			luaLog("\t Unit Command: "..command)
		end
	end

-- RELEASE_LOGOFF  	luaLog("------------------END OF UNIT DEBUG INFO------------------")
end

function luaCheat()
	Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
	for key, value in pairs (Mission.PlayerUnits) do
		AddDamage(value, 1000000)
	end
end

function luaJM5CheckObjectives()

	luaJM5AddMarkerObj()

	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerUnits)) == 0 then
		Mission.MissionPhase = 99
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn05.obj_missionfailed_1"
		for idx,unit in pairs(Mission.PlayerUnits) do
			if unit.Dead and not TrulyDead(unit) then
				Mission.FailEnt = unit
				break
			end
		end
	end

	if Mission.MissionPhase < 99 then

		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		end

		if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
			if Mission.RadarStation.Party == PARTY_JAPANESE then
				Mission.RadarStationCaptured = true
				luaObj_Completed("primary",4,true)
				luaJM5RemoveScore(2)
				luaJM5CBHint()
				luaDelay(luaJM5RadarHint2, 240)
				luaJM5AddRSweepPowerUp()

				Blackout(true, "luaJM5Checkpoint1", 1)

				--if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) then
					--luaJM5AddJumpinMovie("GoAround",Mission.Airfields[2].ID)
				--end

			end

		elseif luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) then

			--if Mission.RadarStation.Party == PARTY_JAPANESE and GetCommandBuildingLevel(FindEntity("RadarStationCommandBuilding 01")) >= 2 then
			if Mission.RadarStation.Party == PARTY_JAPANESE and GetCommandBuildingLevel(Mission.RadarStation) >= 2 then
				--luaJM5StartDialog("Fortressbuilt", true)
				luaJM5ShowHintorDlg("Fortressbuilt",0)
				--local unitTbl = luaRemoveDeadsFromTable(Mission.AIUnits)
				--local unit = unitTbl[1]
				--if unit and not unit.Dead then
				--	luaJM5AddJumpinMovie("JumpTo", unit.ID)
				--end
			end

			if not luaObj_IsActive("secondary",1) then
				luaJM5AddObjS1()
				--luaDelay(luaJM5SecBunkerMovie,10)
			elseif luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
					--luaLog("aaaaaaa")
				if luaJM5DisabledBunkers() then
					luaObj_Completed("secondary",1)
					MissionNarrative("ijn05.obj_s1_compl")
				end
			end

		end

		--if not Mission.HiddenFailed then
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) and Mission.RadarStation.Party ~= PARTY_JAPANESE then
				--luaJM5StartDialog("RadarDisabled",true)
				if Mission.RadarStationCaptured then
					luaJM5ShowHintorDlg("RadarDisabled",0)
					Mission.HiddenFailed = true
				end
			end
			if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) and Mission.Airfields[2].Party ~= PARTY_JAPANESE then
				--luaJM5StartDialog("AirfieldDisabled",true)
				if Mission.AirfieldCaptured then
					luaJM5ShowHintorDlg("AirfieldDisabled",0)
					Mission.HiddenFailed = true
				end
			end
			--if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) and Mission.Airfields[1].Party ~= PARTY_JAPANESE then
				--luaJM5StartDialog("PortDisabled",true)
				--luaJM5ShowHintorDlg("PortDisabled",0)
				--Mission.HiddenFailed = true
			--end
		--end

		if table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)) == 0 and Mission.MissionPhase < 3 then
			Mission.MissionPhase = 99
			Mission.MissionFailed = true
			for idx,unit in pairs(Mission.JapUnits.Cargos) do
				if unit.Dead and not TrulyDead(unit) then
					Mission.FailEnt = unit
					break
				end
			end
			Mission.FailMsg = "ijn05.obj_missionfailed_2"
		end

	end

	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil and Mission.Airfields[2].Party == PARTY_JAPANESE then
		local convoy = FindEntity("SecondaryLandConvoy 01")
		if convoy and not convoy.Dead then
			Kill(convoy, true)
		end
		luaObj_Completed("primary",1,true)
		luaJM5RemoveScore(1)
		MissionNarrative("ijn05.obj_p1_compl")
		--if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		--	luaObj_Failed("secondary",1)
		--	MissionNarrative("ijn05.obj_s1_fail")
		--end
		--luaJM5StartDialog("AirfieldCaptured",true)
		Mission.AirfieldCaptured = true
		luaJM5ShowHintorDlg("AirfieldCaptured",0)
		luaJM5AddDeffensePUp()
		if not luaObj_IsActive("primary",2) then
			luaJM5AddObjP2()
			luaJM5AirfieldMovie(Mission.Airfields[2])
		else
			if not Mission.Obj2OnScreen then
				luaJM5AddObjP2()
			end
			luaObj_Reminder("primary",2)
		end
		luaJM5SpawnJapLvlBomber()
		luaJM5StepPhase(2)

		Blackout(true, "luaJM5Checkpoint2",1)

	end

	--if Mission.Airfields[1].Party == PARTY_JAPANESE and Mission.MissionPhase < 3 then
	if Mission.Airfields[1].Party == PARTY_JAPANESE and Mission.MissionPhase < 3 then
		if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
			luaObj_Completed("primary",2,true)
			luaJM5RemoveScore(3)
			--luaJM5StartDialog("PortCaptured",true)
			--luaJM5ShowHintorDlg("PortCaptured",0)
		elseif not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			luaObj_Completed("primary",2)
			MissionNarrative("ijn05.obj_p2_compl")
		end

		if luaJM5AllPriCompleted() then

			if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
				if luaJM5DisabledBunkers() then
					luaObj_Completed("secondary",1,nil,true)
				else
					luaObj_Failed("secondary",1,nil,true)
				end
			end

			Mission.MissionPhase = 99
			Mission.MissionCompleted = true
			Mission.CompleteMsg = "ijn05.obj_missioncompleted"
		end


		--luaJM5StepPhase(3)
		--luaJM5AddObjP3()
	end

	if Mission.MissionPhase == 1 then

		if not luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",4) then
			luaJM5AddObjP1()
		else
			luaObj_Reminder("primary",1)
		end

		luaJM5AddObjP4()

	elseif Mission.MissionPhase == 2 then



	elseif Mission.MissionPhase == 3 then

		if luaObj_GetSuccess("primary",3) == nil then
			--if Mission.AlliedFleet ~= nil then
					if Mission.Airfields[1].Party ~= PARTY_JAPANESE then
						luaObj_Failed("primary",3,true)
						MissionNarrative("ijn05.obj_p3_fail")
						Mission.FailMsg = "ijn05.obj_missionfailed_3"
						Mission.MissionPhase = 99
						Mission.MissionFailed	= true
						Mission.FailEnt = Mission.Airfields[1]
					else
						--if table.getn(luaRemoveDeadsFromTable(Mission.AlliedFleet)) == 0 then
						if table.getn(luaRemoveDeadsFromTable(Mission.Paratroopers)) == 0 then
							luaObj_Completed("primary",3,true)
							luaJM5RemoveScore(5)
							--luaJM5RemoveScore(6)
							MissionNarrative("ijn05.obj_p3_compl")
							--luaLog("Mission completed")
							Mission.MissionPhase = 99
							Mission.MissionCompleted = true
							Mission.CompleteMsg = "ijn05.obj_missioncompleted"
						else
							luaObj_Reminder("primary",3)
						end
					end
			--end
		end

	elseif Mission.MissionPhase == 99 then

		if luaObj_GetSuccess("secondary",1) == nil then
			luaObj_Failed("secondary",1,nil,true)
		end

		if Mission.MissionFailed then

			luaJM5ClearScoreDisplay()
			if Mission.FailEnt then
				luaMissionFailedNew(Mission.FailEnt, Mission.FailMsg)
			else
				luaMissionFailedNew(Mission.Airfields[1], Mission.FailMsg)
			end
			luaJM5StepPhase()
		elseif Mission.MissionCompleted then
			if not Mission.HiddenFailed then
				luaObj_Completed("hidden",1,true)
				MissionNarrative("ijn05.obj_h1_compl")
			end
			luaMissionCompletedNew(Mission.Airfields[1], Mission.CompleteMsg)
			luaJM5StepPhase()
		end

	end
end

function luaJM5AllPriCompleted()
	if (luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1)) and (luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2)) and (luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4)) then
		return true
	end
	return false
end

function luaJM5Checkpoint1()
	luaCheckpoint(1,135)
	Blackout(false,"",1)
end

function luaJM5Checkpoint2()
	luaCheckpoint(2,135)
	Blackout(false,"",1)
end

function luaJM5AddObjP1(quiet)
	if quiet then
		luaObj_Add("primary",1,nil,true)
	else
		luaObj_Add("primary",1)
	end
	luaObj_AddUnit("primary",1,FindEntity("SecondaryCommandBuilding 01"))
	luaObj_AddReminder("primary",1)
	luaDelay(luaJM5Pri1Score, 5)
end

function luaJM5AddObjP2(quiet)
	if quiet then
		luaObj_Add("primary",2,nil,true)
	else
		luaObj_Add("primary",2)
	end
	--luaJM5StartDialog("FleetOngoing2",true)
	luaDelay(luaJM5Pri2Score,5)
	if not Mission.MainCmdBuilding.Party ~= PARTY_JAPANESE then
		luaObj_AddUnit("primary",2,FindEntity("MainCommandBuilding 01"))
		luaJM5ShowHintorDlg("FleetOngoing2",0)
	end
	luaObj_AddReminder("primary",2)
	Mission.Obj2OnScreen = true
end

function luaJM5AddObjP3(quiet)
	if quiet then
		luaObj_Add("primary",3,nil,true)
	else
		luaObj_Add("primary",3)
	end
	luaDelay(luaJM5Pri3Score,5)
	--luaObj_AddUnit("primary",3,Mission.Airfields[1])
	--luaJM5SpawnAlliedFleet()
	luaJM5SpawnParatroopers()
	luaJM5StepPhase(3)
end

function luaJM5AddObjP4(quiet)
	if not luaObj_IsActive("primary",4) then
		if quiet then
			luaObj_Add("primary",4,nil,true)
		else
			luaObj_Add("primary",4)
		end
		luaObj_AddUnit("primary",4,Mission.RadarStation)
		luaDelay(luaJM5RadarHint1, 60)
		luaDelay(luaJM5Sec1Score, 5)
	end
end

function luaJM5AddObjS1(quiet)
	if quiet then
		luaObj_Add("secondary",1,nil,true)
	else
		luaObj_Add("secondary",1)
	end
	for idx,unit in pairs(Mission.Sec2Bunkers) do
		luaObj_AddUnit("secondary",1,unit)
	end
	--luaDelay(luaJM5Sec2Score,10) --ilyen hosszu a movie
	--luaJM5Sec2Score()
end

function luaJM5AddMarkerObj()
	if not luaObj_IsActive("marker2",1) then
		luaObj_Add("marker2",1)
		luaJM5ShowHintorDlg("Advanced_Hint_Cameralock",1)
	end
end

function luaJM5DisabledBunkers()
	for idx,unit in pairs(Mission.Sec2Bunkers) do
		--if not luaJM5IsDisabled(unit) or not unit.Dead then
		if not unit.Dead then
			return false
		end
	end
	return true
end

function luaJM5CheckHelperCargo()
	if not Mission.PlayerCargosDead then

		--luaLog("Checking for dead playercargos")
		Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
		--luaLog("ciklus")
		--luaLog(Mission.PlayerUnits)

		local isDead = true
		for idx,playerunit in pairs(Mission.PlayerUnits) do
			--luaLog("Got "..playerunit.Class.Type)
			if playerunit.Class.Type == "Cargo" then
				isDead = false
				break
			end
		end

		if isDead then
			Mission.PlayerCargosDead = true
		end
		--luaLog("Variable value is "..tostring(Mission.PlayerCargosDead))

	else

		Mission.JapUnits.Cargos = luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)
			--luaJM5StartDialog("TransportsKilled",true)
		luaJM5ShowHintorDlg("TransportsKilled",0)

		if not Mission.AICargosHelping and table.getn(Mission.JapUnits.Cargos) > 0 then

			--luaLog("Assigning a helpercargo")
			Mission.HelperCargo = Mission.JapUnits.Cargos[1]
			local dist = 10000000
			local capPoints,capTrg = luaJM5GetHelperCargoCapPoints()
			if type(capPoints) == "table" and next(capPoints) ~= nil then
				for idx,point in pairs(capPoints) do
					local dist2 = luaGetDistance(Mission.HelperCargo,point)
					if dist2 < dist then
						dist = dist2
						Mission.HelperCargo.toTrg = GetPosition(point)
						Mission.HelperCargo.capTrg = capTrg
					end
				end
				if IsInFormation(Mission.HelperCargo) then
					LeaveFormation(Mission.HelperCargo)
					--luaLog("Helpercargo was in formation")
				end
				NavigatorMoveToRange(Mission.HelperCargo,Mission.HelperCargo.toTrg)
				Mission.AICargosHelping = true
				--luaLog("Helpercargo moving to cap point")
			else
-- RELEASE_LOGOFF  				luaLog("Helpercargo active but no capturepos found")
			end

		elseif Mission.AICargosHelping and table.getn(Mission.JapUnits.Cargos) > 0 then

			if Mission.HelperCargo.Dead then
				Mission.HelperCargo = nil
				Mission.AICargosHelping = false
				--luaLog("Helpercargo died")
			else
				if luaGetDistance(Mission.HelperCargo, Mission.HelperCargo.toTrg) < 200 then
					NavigatorStop(Mission.HelperCargo)
					StartLanding2(Mission.HelperCargo)
				end

				if Mission.HelperCargo.capTrg.Party == PARTY_JAPANESE then
					Mission.HelperCargo = nil
					Mission.AICargosHelping = false
				end

			end

		end
	end
end

function luaJM5JapFleet()
	Mission.AIUnits = luaRemoveDeadsFromTable(Mission.AIUnits)
	if table.getn(Mission.AIUnits) == 0 then
		--luaLog("Japanese fleet is no more")
		return
	end

	local leader = GetFormationLeader(Mission.AIUnits[1])

	--luaLog("leader: "..leader.Name)

	if leader == nil then
		leader = Mission.AIUnits[1]
		for idx,unit in pairs(Mission.AIUnits) do
			if idx > 1 then
				--luaLog(unit.Name.." goes into formation")
				JoinFormation(unit, leader)
			end
		end
	end

	if Mission.MissionPhase == 1 then

		--luaLog("Checking jap fleet")

		if Mission.JapFleetAlertLvl == 0 then

			if Mission.JapFleetCmd ~= "MoveOnPath" then
				NavigatorMoveOnPath(leader, Mission.JapFleetPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
				Mission.JapFleetCmd = "MoveOnPath"
				--luaLog("JapFleet is moving on path")
			end

			--luaLog(recon[PARTY_JAPANESE].enemy)
			--if luaIsInside(Mission.MainCmdBuilding, recon[PARTY_JAPANESE].enemy.landfort) then
			--if luaGetDistance(leader, Mission.MainCmdBuilding) < 2500 then
			local pathTbl = FillPathPoints(Mission.JapFleetPath)
			--if luaGetDistance(leader, pathTbl[5]) < 500 then
			if luaGetDistance(leader, Mission.StopPoint) < 500 then
				Mission.JapFleetAlertLvl = 1
			end

		elseif Mission.JapFleetAlertLvl == 1 then

			if Mission.JapFleetCmd ~= "Stop" then
				NavigatorStop(leader)
				Mission.JapFleetCmd = "Stop"
-- RELEASE_LOGOFF  				luaLog("JapFleet is stopped")
				--luaJM5StartDialog("FleetStopped",true)
				luaJM5ShowHintorDlg("FleetStopped",0)
			end

		end

		--cargos
		luaJM5CheckHelperCargo()

	elseif Mission.MissionPhase == 2 then

		luaJM5CheckHelperCargo()

		--cargok
		if Mission.Airfields[1].Party == PARTY_ALLIED or Mission.Airfields[1].Party == PARTY_NEUTRAL then

			if Mission.PlayerCargosDead then --csak ekkor jojjenek az ai cargok, Jon.

				if table.getn(luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)) > 0 then
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapUnits.Cargos)) do
						local roles = GetRoleOwner(unit)
						if roles[EROLE_CAPTAIN] == PLAYER_AI and not IsUnitSelectable(unit) then
							for idx2,point in pairs(Mission.MainCapPoints) do
								if luaGetDistance(unit, point) < 200 then
									NavigatorStop(unit)
									local err = StartLanding2(unit)
									local errTbl = {}
										errTbl["0"] = "Big landing ship elindult partraszállni"
										errTbl["1"] = "1 kislandig elindult"
										errTbl["2"] = "2 kislandig elindult"
										errTbl["3"] = "3 kislandig elindult"
										errTbl["4"] = "4 kislandig elindult"
										errTbl["5"] = "5 kislandig elindult"
										errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
										errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
										errTbl["-3"] = "Nemrég indított már, és még cooldown van"
										errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
										errTbl["-5"] = "Nincs command building a pályán"
										errTbl["-6"] = "Csak saját command building van a pályán"
										errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
										--luaLog(errTbl[tostring(err)])
										--luaLog(err)
								else
									if not string.find(GetProperty(unit, "unitcommand"),"move") then
										--luaLog(unit)
										--luaLog(point)
										LeaveFormation(unit)
										NavigatorMoveToRange(unit, point)
										break
									end
								end
							end
						end
					end
				end

			end
		end

	end

		--warships
	if Mission.MissionPhase > 1 then
		Mission.AIUnits = luaRemoveDeadsFromTable(Mission.AIUnits)
		if table.getn(Mission.AIUnits) > 0 then
			for idx,unit in pairs(Mission.AIUnits) do

				if unit.Class.Type ~= "Cargo" and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then

					--luaLog("Targeting "..unit.Name)
					local trg

					if not Mission.Shipyards[1].Dead then
						trg = Mission.Shipyards[1]
					elseif not Mission.Shipyards[2].Dead then
						trg = Mission.Shipyards[2]
					else
						local enemies = luaGetShipsAround(unit, 15000, "enemy")
						if enemies ~= nil and next(enemies) ~= nil then
							for idx2,nmi in pairs(enemies) do
								if nmi.Class.Type == "Cargo" or nmi.Class.Type == "Submarine" or nmi.Class.Type == "TorpedoBoat" then
-- RELEASE_LOGOFF  									luaLog("removing "..nmi.Name.." from table")
									table.remove(enemies, idx2)
								end
							end
						end
						if enemies ~= nil and next(enemies) ~= nil then
							trg = enemies[1]
						else
							--luaLog("Gun targets for AI ships")
							luaJM5GetEnemyArtillery()
							if next(Mission.CoastalGuns) ~= nil then
								--legkozelebbit kell :(
								local gundist = 1000000
								for idx3,gun in pairs(Mission.CoastalGuns) do
									if luaGetDistance(unit, gun) < gundist and gun.Party == PARTY_ALLIED then
										trg = gun
									end
								end
							end
						end
					end

					if trg ~= nil and not trg.Dead and trg.Party == PARTY_ALLIED then
						if IsInFormation(unit) then
							LeaveFormation(unit)
						end
						luaSetScriptTarget(unit, trg)
						TorpedoEnable(unit, true)
						NavigatorAttackMove(unit, trg, {})
						--luaLog(unit.Name.." gets a new target "..trg.Name)
					end

				elseif unit.Class.Type == "Cargo" and Mission.MissionPhase >= 3 then

					--luaLog("Checking cargos in phase 3")

					if IsInFormation(unit) then
						LeaveFormation(unit)
						NavigatorStop(unit)
						--luaLog("Stoping cargo")
					end

				end
			end
		end
	end

end

function luaJM5GetHelperCargoCapPoints()
	if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
		return Mission.RadarCapPoints, Mission.RadarStation
	end
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		return Mission.SecCapPoints, FindEntity("SecondaryCommandBuilding 01")
	end
	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		return Mission.MainCapPoints, FindEntity("MainCommandBuilding 01")
	end
end

function luaJM5SpawnJapLvlBomber()
	local spawnPoint = GetPosition(Mission.IJNBomberSpawnPoint)
		spawnPoint.y = 450

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 166,
			["Name"] = "G3M Nell",
			["Crew"] = Mission.SkillLevel,
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 1,
		}
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
		["angleRange"] = {luaJM5RAD(0), luaJM5RAD(360)},
	},
	["callback"] = "luaJM5JapLvlBomberSpawned",
	["id"] = Mission.JapLvlBomberSpawnReq,
})
end

function luaJM5JapLvlBomberSpawned(...)
	for i,v in ipairs(arg) do
		SetSkillLevel(v, Mission.SkillLevel)

		if Mission.PlayerUnits[1] and not Mission.PlayerUnits[1].Dead then
			PilotMoveToRange(v, Mission.PlayerUnits[1])
		end

	end
	luaJM5NellHint()
end

function luaJM5RAD(x)
	return x *  0.0174532925
end

function luaJM5IsDlgRunning()
	if next(GetActDialogIDs()) == nil then
		return false
	else
		return true
	end
end

function luaJM5StartDialog(dialogID, log)
-- dialog indito wrapper

	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM5StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM5StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM5RadarHint1()
	--luaJM5StartDialog("RadarHint1",true)
	luaJM5ShowHintorDlg("RadarHint1",0)
	luaJM5ShowHintorDlg("Map_hint1",0,true)
	--luaJM5AddMapListener()
end


function luaJM5RadarHint2()
	--luaJM5StartDialog("RadarHint2",true)
	luaJM5ShowHintorDlg("RadarHint2",0)
end

function luaJM5StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM5AddRSweepPowerUp()
	AddPowerup({
		["classID"] = "radar_sweep",
		["useLimit"] = 1,
	})
	--luaLog("Speed powerup granted")
end

function luaJM5AddDeffensePUp()
	AddPowerup({
		["classID"] = "fearless_defense",
	})
end

function luaJM5IsDisabled(ent)
	if not luaIsEntityTable({ent},false) then
		--luaLog("luaJM5IsDisabled got a wrong param")
		--luaLog(ent.Name)
		return
	end

	if GetFailure(ent, "InferiorFailure") then
		if ent.ID == Mission.Airfields[2].ID then
			--luaJM5StartDialog("ValSuccess",true)
		end
		return true
	end

	return false
end

function luaJM5GetEnemyArtillery()
	local tbl = recon[PARTY_ALLIED].own.landfort
	Mission.CoastalGuns = {}
	for idx,unit in pairs(tbl) do
			if not unit.Dead and (string.find(unit.Name, "Coastal Gun") or string.find(unit.Name, "Fortress")) then
				--luaLog("Inserting "..unit.Name.." into the table")
				table.insert(Mission.CoastalGuns, unit)
			end
	end
	return
end

function luaJM5SpawnParatroopers()
	local refPos = GetPosition(FindEntity("USNSpawn 01"))
	refPos.y = 600


	local crewLvl
	if Mission.AllElites then
		crewLvl = SKILL_ELITE
	else
		crewLvl = Mission.SkillLevel
	end

SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
			{
				["Type"] = 136,
				["Name"] = "C47 Dakota",
				["Crew"] = crewLvl,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = 135,
				["Name"] = "Warhawk",
				["Crew"] = crewLvl,
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
		--["refPos"] = FindEntity("USNSpawn 02"),
		["refPos"] = refPos,
		["angleRange"] = {luaJM5RAD(15), luaJM5RAD(180)},
		["lookAt"] = GetPosition(Mission.Airfields[1])
	},
	["callback"] = "luaJM5ParatroopersSpawned",
	["id"] = Mission.ParatrooperSpawnReq,
})
end

function luaJM5ParatroopersSpawned(...)

	--local spawnedSquads = {}
	Mission.Paratroopers = {}
	local fighter
	local dakota
	for i,v in ipairs(arg) do
		SetSkillLevel(v, Mission.SkillLevel)
		if v.Class.Type == "Fighter" then
			fighter = v
		end
		if v.Class.Type == "LevelBomber" then
			dakota = v
			--PilotSetTarget(v, Mission.Airfields[1])
			PilotMoveTo(v, Mission.Airfields[1])
			table.insert(Mission.Paratroopers, v)
		end
		--table.insert(spawnedSquads, v)
	end

	PilotMoveTo(fighter, dakota)
	Mission.ParaFighter = fighter
	--luaLog("Paratroopers init done")
	--luaJM5StartDialog("Paratroopers")
	luaJM5ShowHintorDlg("Paratroopers",0)
	--luaJM5DakotaMovie(dakota.ID) Petya kommentelte kuldesre, mert nincs hozza fuggveny!
	--luaJumpinMovieSetCurrentMovie("JumpTo",dakota.ID)
	--luaJM5AddJumpinMovie("JumpTo",dakota.ID)
	luaJM5DakotaMovie(dakota)
end

function luaJM5CheckParatroopers()
	if Mission.Paratroopers == nil then
		if Mission.ParaFighter and not Mission.ParaFighter.Dead and not Mission.ParaFighter.retreating then
			PilotRetreat(Mission.ParaFighter)
			Mission.ParaFighter.retreating = true
		end
		return
	end

	Mission.Paratroopers = luaRemoveDeadsFromTable(Mission.Paratroopers)
	if table.getn(Mission.Paratroopers) == 0 then
		return
	end

	for idx,unit in pairs(Mission.Paratroopers) do
		local ammo = GetProperty(unit, "ammoType")
		if ammo ~= 0 and luaGetDistance(unit, Mission.Airfields[1]) < 300 then
			local planes = GetSquadronPlanes(unit)
			for idx2,planeID in pairs(planes) do
				PlaneForceRelease(thisTable[tostring(planeID)])
			end
		end
	end
end

function luaJM5AF1StockFillup(airbase)
	--luaLog("luaJM5AF1StockFillup called")
	AddAirBasePlanes(airbase, 158, 12) --val
	AddAirBasePlanes(airbase, 150, 12) --zero
	AddAirBasePlanes(airbase, 162, 12) --kate
	--AddAirBasePlanes(airbase, 112, 10) --devastator
end

function luaJM5AF1StockFillup2(airbase)
	--luaLog("luaJM5AF1StockFillup2 called")
	AddAirBasePlanes(airbase, 158, 18) --val
	AddAirBasePlanes(airbase, 150, 12) --zero
	AddAirBasePlanes(airbase, 166, 12) --nell
	--AddAirBasePlanes(airbase, 112, 10) --devastator
end

---------------------------------------- EVENTS ---------------------------------------
function luaJM5EventFlags()
	Mission.CurrentEventTable = nil
	Mission.Event = {}
	Mission.PlayedEvents = Mission.PlayedEvents + 1
	if Mission.MaxEvents > Mission.PlayedEvents then
		Mission.EventsEnabled = true
	end
end


function luaJM5GetNewEvent()
	local idx = luaPickInRange("Non_plane_events", 1, "Plane_events", 3)
	--luaLog("Plane or Nonplane_event "..tostring(idx))

	if table.getn(Mission.EventTable[idx]) == 0 then
		if idx == "Non_plane_events" then
			idx = "Plane_events"
		else
			idx = "Non_plane_events"
		end
	end

	if table.getn(Mission.EventTable[idx]) == 0 then
		--luaLog("No more events")
		Mission.EventsEnabled = false
		return
	end

	local idx2 = luaRnd(1,table.getn(Mission.EventTable[idx]))
	--luaLog("Table idx "..tostring(idx2))
	local tbl = copy_table(Mission.EventTable[idx][idx2])
	Mission.CurrentEventTable = tbl
	--Mission.CurrentEventTable = Mission.EventTable[idx][idx2]
	--Mission.CurrentEventTable = Mission.EventTable["Plane_events"][1]

	Mission.CurrentEventTable.Phase = 0
	--luaLog("Current")
	--luaLog(Mission.CurrentEventTable)
	table.remove(Mission.EventTable[idx],idx2)
end

function luaJM5EventManager()
	if Mission.Event.Finished then

		--subhunt spec
		if Mission.CurrentEventTable and Mission.CurrentEventTable.ID == 1 then
			Mission.RemainingSub = Mission.CurrentEventTable.RefUnit
			if not Mission.RemainingSub.Dead then

				if not Mission.RemainingSub.MarkerRemoved then
					luaObj_RemoveUnit("marker2",1,Mission.RemainingSub)
					Mission.RemainingSub.MarkerRemoved = true
				end

				luaJM5SubEventEnd()
			end
		end

		--recon spec
		if Mission.CurrentEventTable and Mission.CurrentEventTable.ID == 2 then
			for idx, navPoint in pairs(Mission.CurrentEventTable.NavPointsTbl) do
				if not navPoint.reconned then
					luaJM5RemoveEventMarker(GetPosition(FindEntity(Mission.CurrentEventTable.NavPointsTbl2[idx])))
				end
			end
		end

		--lostplane
		if Mission.CurrentEventTable and Mission.CurrentEventTable.ID == 3 then
			if Mission.CurrentEventTable.NavPoint and Mission.CurrentEventTable.MarkerOn then
				luaObj_RemoveUnit("marker2",1,Mission.CurrentEventTable.NavPoint)
			end
		end

			--catch the convoy special
		if Mission.CurrentEventTable and Mission.CurrentEventTable.ID == 5 then
			if Mission.CurrentEventTable.Convoy and not Mission.CurrentEventTable.Convoy.Dead then
				Kill(Mission.CurrentEventTable.Convoy, true)
			end
		end

		--pts special
		if Mission.CurrentEventTable and Mission.CurrentEventTable.ID == 7 then
			if table.getn(luaRemoveDeadsFromTable(Mission.CurrentEventTable.RefUnitTable)) > 0 then
				Mission.Event7Table = luaRemoveDeadsFromTable(Mission.CurrentEventTable.RefUnitTable)
				luaJM5Event7Patrol()
			end
		end

		if Mission.Event.Bonus and Mission.CurrentEventTable.Bonus ~= nil then
			luaJM5AddEventBonus()
		elseif not Mission.Event.Bonus then
			--failure msgs
			if Mission.CurrentEventTable.Failure then
				StartDialog("Event_failureDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Failure)
			end
		end

		--luaLog("Event Finished")
		return
	else
		if Mission.Event.TimerStarted then
			local timeLeft = CountdownTimeLeft()
			if timeLeft and type(timeLeft) == "number" then
				if not Mission.CurrentEventTable.Remind then
					Mission.CurrentEventTable.Remind = math.floor(timeLeft/60)
				else
					local remind = math.floor(timeLeft/60)
					if remind ~= Mission.CurrentEventTable.Remind then
						Mission.CurrentEventTable.Remind = mod
						--MissionNarrativeEnqueue(Mission.CurrentEventTable.Name.." is active!")
						Mission.EventName = Mission.CurrentEventTable.Desc
						Mission.TimeLeft = math.floor(timeLeft)
						luaJM5EventReminder()
					end
				end
			end
		end
	end

	if Mission.CurrentEventTable and Mission.CurrentEventTable.Phase == 0 and (not Mission.MissionCompleted or not Mission.MissionFailed) then
		luaJM5InitEvent(Mission.CurrentEventTable)
		Mission.CurrentEventTable.Phase = Mission.CurrentEventTable.Phase + 1
		--luaLog("Event Phase will be "..tostring(Mission.CurrentEventTable.Phase))
	end

	if not Mission.Event.Finished and Mission.CurrentEventTable then
		luaJM5CheckEvent(Mission.CurrentEventTable.ID)
	end

end

function luaJM5AddEventBonus()
	if Mission.EventBonusAdded > 7 then
		Mission.EventBonusAdded = 1
	else
		Mission.EventBonusAdded = Mission.EventBonusAdded + 1
	end
	--AddPowerup({
	--	["classID"] = Mission.CurrentEventTable.Bonus,
	--	["useLimit"] = 1,
	--})
	AddPowerup({
		["classID"] = Mission.EventBonuses[Mission.EventBonusAdded],
		["useLimit"] = 1,
	})
end

function luaJM5InitEvent(eventTbl)
	--luaLog("CurrentEventTable")
	--luaLog(eventTbl)
	--luaLog("luaJM5InitEvent called")

	if eventTbl.ID == 1 then --SubHunt
		--luaLog("Subhunt event init")


		local crewLvl
		if Mission.AllElites then
			crewLvl = SKILL_ELITE
		else
			crewLvl = Mission.SkillLevel
		end

		local spawnPoint = GetPosition(FindEntity("Event1SpawnPoint"))
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 31,
					["Name"] = "USS Dolphin", --SS169
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
			},
			["area"] = {
				["refPos"] = spawnPoint,
				["angleRange"] = {luaJM5RAD(0),luaJM5RAD(360)},
				["lookAt"] = GetPosition(luaRemoveDeadsFromTable(Mission.PlayerUnits)[1])
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM5Event1Spawned",
		})

	elseif eventTbl.ID == 2 then --Reconnaissance

		--local navPoints = {FindEntity("Event3Navpoint1"), FindEntity("Event3Navpoint2"), FindEntity("Event3Navpoint3")}
		--Mission.CurrentEventTable.NavPoint = luaPickRnd(navPoints)
		Mission.CurrentEventTable.NavPointsTbl = {}
		Mission.CurrentEventTable.NavPointsTbl2 = {}
		table.insert(Mission.CurrentEventTable.NavPointsTbl, GetPosition(FindEntity("Event2Navpoint1")))
		table.insert(Mission.CurrentEventTable.NavPointsTbl2,"Event2Navpoint1")
		table.insert(Mission.CurrentEventTable.NavPointsTbl, GetPosition(FindEntity("Event2Navpoint2")))
		table.insert(Mission.CurrentEventTable.NavPointsTbl2,"Event2Navpoint2")
		table.insert(Mission.CurrentEventTable.NavPointsTbl, GetPosition(FindEntity("Event2Navpoint3")))
		table.insert(Mission.CurrentEventTable.NavPointsTbl2,"Event2Navpoint3")

		for idx,navPoint in pairs(Mission.CurrentEventTable.NavPointsTbl) do
			--AddPlayerObjective(PLAYER_1, GetPosition(navPoint))
			--Objectives_AddUnit(Mission.Party, nil, "event2_marker", GetPosition(navPoint))
			luaObj_AddUnit("marker2",1,navPoint)
			--luaLog("Adding marker")
		end

	elseif eventTbl.ID == 3 then--Lost plane

		--local navPoints = {FindEntity("Event3Navpoint1"), FindEntity("Event3Navpoint2"), FindEntity("Event3Navpoint3")}
		local mavises = {"Static Mavis, Crashed 01", "Static Mavis, Crashed 02", "Static Mavis, Crashed 03"}
		local convoy = {"Event3Convoy 01","Event3Convoy 02","Event3Convoy 03"}

		local rand = random(1,3)
		Mission.CurrentEventTable.NavPoint = GenerateObject(mavises[rand],"globals.unitclass_mavis")--GenerateObject(luaPickRnd(mavises))
		SetInvincible(Mission.CurrentEventTable.NavPoint, true)
		Mission.CurrentEventTable.Efx = Effect("GiantSmoke", GetPosition(Mission.CurrentEventTable.NavPoint))
		Mission.CurrentEventTable.Convoy = GenerateObject(convoy[rand],"ijn05.hint_15_title|.")
		luaObj_AddUnit("marker2",1,Mission.CurrentEventTable.NavPoint)
		Mission.CurrentEventTable.MarkerOn = true

		--movie
		--luaJM5SetCurrentMovie("GoAround",Mission.CurrentEventTable.NavPoint.ID)
		--luaDelay(luaJM5ChangeJumpinCtrl,2)
		--luaJM5AddJumpinMovie("GoAround",Mission.CurrentEventTable.Convoy.ID)
		--luaJM5AddJumpinMovie("JumpTo",Mission.CurrentEventTable.NavPoint.ID)

	elseif eventTbl.ID == 4 then--Intercept the recons

		--local spawnPoint = GetPosition(Mission.Airfields[2])
		local spawnPoint = GetPosition(FindEntity("Event4SpawnPoint"))
		spawnPoint["y"] = 120

		local crewLvl
		if Mission.AllElites then
			crewLvl = SKILL_ELITE
		else
			crewLvl = Mission.SkillLevel
		end

		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 125,
					["Name"] = "PBY Catalina",
					["Crew"] = crewLvl,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 0,
				},
			},
			["area"] = {
				["refPos"] = spawnPoint,
				["angleRange"] = {luaJM5RAD(10), luaJM5RAD(180)},
				["lookAt"] = GetPosition(Mission.RadarStation)
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM5Event4CatalinaSpawned",
		})

	elseif eventTbl.ID == 5 then --Catch the convoy

		--luaLog("Event 5 init")
		Mission.CurrentEventTable.Convoy = GenerateObject("Event5Convoy","ijn05.hint_15_title|.")
		luaJM5AddEventMarker(Mission.CurrentEventTable.Convoy)
		local tbl = FillPathPoints(FindEntity("Event5Path"))
		Mission.CurrentEventTable.ConvoyLastPoint = tbl[table.getn(tbl)]
		--luaJM5EventConvoyMovie(Mission.CurrentEventTable.Convoy)

	elseif eventTbl.ID == 6 then--Cargo hunt
		--luaLog("Cargo hunt event init")

		Mission.CurrentEventTable.Path = FindEntity("Event6Path")
		local spawnPoint = FindEntity("Event6Navpoint")

		local crewLvl
		if Mission.AllElites then
			crewLvl = SKILL_ELITE
		else
			crewLvl = Mission.SkillLevel
		end

		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 35,
					["Name"] = "Cargo1",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 37,
					["Name"] = "Cargo2",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 37,
					["Name"] = "Cargo3",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
			},
			["area"] = {
				["refPos"] = spawnPoint,
				["angleRange"] = { luaJM5RAD(10), luaJM5RAD(180) },
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM5Event6Spawned",
		})

	elseif eventTbl.ID == 7 then--Patrol
		--luaLog("Patrol event init")

		Mission.CurrentEventTable.Path = FindEntity("Event7Path")
		local pathTbl = FillPathPoints(Mission.CurrentEventTable.Path)
		local spawnPoint = pathTbl[1]

		local crewLvl
		if Mission.AllElites then
			crewLvl = SKILL_ELITE
		else
			crewLvl = Mission.SkillLevel
		end

		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 27,
					["Name"] = "Elco PT 80'",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 27,
					["Name"] = "Elco PT 80'",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 27,
					["Name"] = "Elco PT 80'",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 27,
					["Name"] = "Elco PT 80'",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
				{
					["Type"] = 27,
					["Name"] = "Elco PT 80'",
					["Crew"] = crewLvl,
					["Race"] = USA,
				},
			},
			["area"] = {
				["refPos"] = spawnPoint,
				["angleRange"] = { luaJM5RAD(10), luaJM5RAD(45) },
				["lookAt"] = GetPosition(Mission.Airfields[2])
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM5Event7Spawned",
		})

	elseif eventTbl.ID == 8 then--Meeting with allies nem hasznalt

	end

	if Mission.CurrentEventTable.InitDialog then
		StartDialog("Event_initDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.InitDialog)
	end

end

function luaJM5Event1Spawned(unit)
	SetGuiName(unit, "ingame.shipnames_dolphin")
	Mission.CurrentEventTable.RefUnit = unit
	SetSubmarineDepthLevel(unit,1)
	SetSkillLevel(unit, Mission.SkillLevel)

	--movie + marker
	--luaJM5AddJumpinMovie("JumpTo",unit.ID)
	luaJM5AddEventMarker(unit)
	luaJM5EventSubMovie(unit)
end

function luaJM5Event4CatalinaSpawned(unit)
	Mission.CurrentEventTable.RefUnit = unit
	PilotMoveToRange(unit, Mission.PlayerUnits[1])
	unit.MoveToUnitID = Mission.PlayerUnits[1].ID
	SetSkillLevel(unit, Mission.SkillLevel)

	--movie + marker
	--luaJM5AddJumpinMovie("GoAround",unit.ID)
	luaJM5AddEventMarker(unit)
	luaJM5EventCatalinaMovie(unit)
end

function luaJM5Event6Spawned(unit1,unit2,unit3)
	SetGuiName(unit1,"ingame.shipnames_whitney")
	SetGuiName(unit2,"ingame.shipnames_dobbin")
	SetGuiName(unit3,"ingame.shipnames_tippecanoe")

	Mission.CurrentEventTable.RefUnitTable = {}
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit1)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit2)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit3)
	JoinFormation(unit2, unit1)
	JoinFormation(unit3, unit1)
	NavigatorMoveOnPath(unit1, Mission.CurrentEventTable.Path)

	--movie + marker
	--luaJM5AddJumpinMovie("GoAround",unit1.ID)
	luaJM5AddEventMarker(unit1)
	luaJM5AddEventMarker(unit2)
	luaJM5AddEventMarker(unit3)
	luaJM5EventCargoMovie(unit1)

	SetSkillLevel(unit1, Mission.SkillLevel)
	SetSkillLevel(unit2, Mission.SkillLevel)
	SetSkillLevel(unit3, Mission.SkillLevel)
end

function luaJM5Event7Spawned(unit1,unit2,unit3,unit4,unit5)
	Mission.CurrentEventTable.RefUnitTable = {}
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit1)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit2)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit3)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit4)
	table.insert(Mission.CurrentEventTable.RefUnitTable, unit5)

	SetGuiName(unit1, "ingame.shipnames_pt|.102")
	SetGuiName(unit2, "ingame.shipnames_pt|.103")
	SetGuiName(unit3, "ingame.shipnames_pt|.106")
	SetGuiName(unit4, "ingame.shipnames_pt|.111")
	SetGuiName(unit5, "ingame.shipnames_pt|.120")

	JoinFormation(unit2, unit1)
	JoinFormation(unit3, unit1)
	JoinFormation(unit4, unit1)
	JoinFormation(unit5, unit1)
	NavigatorMoveOnPath(unit1, Mission.CurrentEventTable.Path)

	--movie + marker
	--luaJM5AddJumpinMovie("GoAround",unit1.ID)
	luaJM5AddEventMarker(unit1)
	luaJM5AddEventMarker(unit2)
	luaJM5AddEventMarker(unit3)
	luaJM5AddEventMarker(unit4)
	luaJM5AddEventMarker(unit5)

	SetSkillLevel(unit1, Mission.SkillLevel)
	SetSkillLevel(unit2, Mission.SkillLevel)
	SetSkillLevel(unit3, Mission.SkillLevel)
	SetSkillLevel(unit4, Mission.SkillLevel)
	SetSkillLevel(unit5, Mission.SkillLevel)


	luaJM5EventPtMovie(unit1)
end

function luaJM5Event7Patrol()
	if table.getn(luaRemoveDeadsFromTable(Mission.Event7Table)) == 0 then
		return
	end

	for idx,unit in pairs(Mission.Event7Table) do
		if not unit.Dead then

			local ships = luaGetShipsAround(unit, 2000, "enemy")

			if not unit.patroling and not ships then
				NavigatorMoveOnPath(unit, FindEntity("Event7PatrolPath"))
				unit.patroling = true
			elseif ships then
				TorpedoEnable(unit, true)
				local trg = luaPickRnd(ships)
				if trg and not trg.Dead then
					NavigatorAttackMove(unit, trg, {})
					unit.patroling = false
				end
			end

		end
	end

	luaDelay(luaJM5Event7Patrol, 3)
end

function luaJM5SubEventEnd()
	if Mission.RemainingSub.Dead then
		return
	end

	local depth = GetSubmarineDepthLevel(Mission.RemainingSub)
	if depth ~= 3 then
		Mission.RemainingSub.retreatPoint = FindEntity("Event1SpawnPoint")
		NavigatorStop(Mission.RemainingSub)
		NavigatorMoveToPos(Mission.RemainingSub,Mission.RemainingSub.retreatPoint)
		UnitSetFireStance(Mission.RemainingSub, STANCE_HOLD_FIRE)
		SetSubmarineDepthLevel(Mission.RemainingSub, 3)
	elseif depth == 3 then
		SetForcedReconLevel(Mission.RemainingSub, 0, PARTY_JAPANESE)
		Kill(Mission.RemainingSub, true)
		return
	end

	luaDelay(luaJM5SubEventEnd, 3)
end

function luaJM5EventStartTimer()
	if not Mission.Event.TimerStarted then
		Countdown(Mission.CurrentEventTable.Name, 1, Mission.CurrentEventTable.Timer, "luaJM5EventTimerExpired")
		Mission.Event.TimerStarted = true
	end
end

--[[
function luaJM5ConvoyEnd()
	if not Mission.Event.Finished then
		Mission.Event.Finished = true
		CountdownCancel()
		if Mission.CurrentEventTable.Convoy then
			Kill(Mission.CurrentEventTable.Convoy, true)
		end
	end
end
]]
function luaJM5EventTimerExpired()
	Mission.Event.Finished = true
	Mission.Event.TimerStarted = false
	--luaLog("\t Event: Timer finished")
end

function luaJM5CheckEvent(ID)

	--luaLog("luaJM5CheckEvent called")
	if Mission.Event.Finished then
		--luaLog("luaJM5CheckEvent returns")
		return
	end

	if ID == 1 then --SubHunt

		if Mission.CurrentEventTable.RefUnit then

			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint1()
			end

			local enemysub = Mission.CurrentEventTable.RefUnit
			--timeup or killed by player

			if enemysub.Dead and not Mission.Event.Finished then
				Mission.Event.Bonus = true
				Mission.Event.Finished = true
				--success msgs
				StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
				CountdownCancel()
				return
			end

			--targeting
			if not Mission.EventSubretreats then
				if luaGetScriptTarget(enemysub) == nil or luaGetScriptTarget(enemysub).Dead then
					local trg
					for idx,unit in pairs(Mission.PlayerUnits) do
						if not unit.Dead and unit.Class.Type == "Cargo" then
							trg = unit
							break
						end
					end

					if trg == nil then
						trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.PlayerUnits))
					end

					if trg ~= nil and not trg.Dead then
						luaSetScriptTarget(enemysub,trg)
						--SetSubmarineAttack(enemysub,trg)
						NavigatorAttackMove(enemysub, trg, {})
						--luaLog("\t Event: Submarnie gets a target")
					end
				end
			end

			--stock empty, despawn
			local stock = GetProperty(enemysub, "TorpedoStock")
			if stock == 0 and not Mission.EventSubretreats then
				Mission.EventSubretreats = true
				enemysub.retreatPoint = FindEntity("Event1SpawnPoint")
				NavigatorMoveToPos(enemysub,enemysub.retreatPoint)
-- RELEASE_LOGOFF  				luaLog("\t Event: Submarnie retreats")
			elseif Mission.EventSubretreats then
				local depth = GetSubmarineDepthLevel(enemysub)
				if depth ~= 3 and luaGetDistance(enemysub,enemysub.retreatPoint) < 200 then
					SetSubmarineDepthLevel(enemysub,3)
				elseif depth == 3 then
					SetForcedReconLevel(unit, 0, PARTY_JAPANESE)
					luaJM5RemoveEventMarker(enemysub)
					Kill(enemysub, true)
					Mission.Event.Finished = true
					CountdownCancel()
-- RELEASE_LOGOFF  					luaLog("\t Event: Submarnie retreated")
				end
			end

		end

	elseif ID == 2 then --Reconnaissance

		if Mission.CurrentEventTable.NavPointsTbl then
			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint2()
			end


			local reconned = 0
			for idx, navPoint in pairs(Mission.CurrentEventTable.NavPointsTbl) do

				if not navPoint.reconned then
					local planes = luaGetPlanesAroundCoordinate(navPoint, 300, PARTY_JAPANESE, "own")
					if planes ~= nil then
						for idx2,unit in pairs(planes) do
							if IsUnitSelectable(unit) then
								luaJM5Event2PopUp(idx)
								navPoint.reconned = true
								luaJM5RemoveEventMarker(GetPosition(FindEntity(Mission.CurrentEventTable.NavPointsTbl2[idx])))
							end
						end
					end
				else
					reconned = reconned + 1
				end

			end

			if reconned == 3 then
				--success msgs
				StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
				Mission.Event.Finished = true
				Mission.Event.Bonus = true
				CountdownCancel()
			end

		end

	elseif ID == 3 then--Lost plane

		if Mission.CurrentEventTable.NavPoint then
			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint3()
			end

			local planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.CurrentEventTable.NavPoint), 300, PARTY_JAPANESE, "own")
			if planes ~= nil then
				for idx,unit in pairs(planes) do
					if IsUnitSelectable(unit) then
						--luaLog("Event completed")
						Mission.Event.Finished = true
						Mission.Event.Bonus = true
						luaObj_RemoveUnit("marker2",1,Mission.CurrentEventTable.NavPoint)
						Mission.CurrentEventTable.MarkerOn = false
						StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
						CountdownCancel()
						break
					end
				end
			end

		end

	elseif ID == 4 then--Intercept the recons

		if Mission.CurrentEventTable.RefUnit then-- and Mission.PlayerZero then

			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint4()
			end

			local catalina = Mission.CurrentEventTable.RefUnit
			if thisTable[tostring(catalina.MoveToUnitID)].Dead then
				Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
				if table.getn(Mission.PlayerUnits) == 0 then
					return
				end
				PilotMoveToRange(catalina, Mission.PlayerUnits[1])
				catalina.MoveToUnitID = Mission.PlayerUnits[1].ID
			end

			if catalina.Dead and catalina.KillReason ~= "exitzone" then
				--success msgs
				StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
				Mission.Event.Finished = true
				Mission.Event.Bonus = true
				CountdownCancel()
				return
			elseif catalina.Dead and catalina.KillReason == "exitzone" then
				Mission.Event.Finished = true
				CountdownCancel()
				return
			end

			local cmd = GetProperty(catalina, "unitcommand")
			if cmd ~= "retreat" then
				if luaGetDistance(catalina, thisTable[tostring(catalina.MoveToUnitID)]) < 300 then
					PilotRetreat(catalina)
					luaJM5RemoveEventMarker(catalina)
				end
			end

		end

	elseif ID == 5 then--Catch the convoy

		if Mission.CurrentEventTable.Convoy then
			 --timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint5()
			end

			if Mission.CurrentEventTable.Convoy.Dead then
				--success msgs
				StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
				Mission.Event.Finished = true
				CountdownCancel()
				Mission.Event.Bonus = true
			else
				if luaGetDistance(Mission.CurrentEventTable.Convoy, Mission.CurrentEventTable.ConvoyLastPoint) < 150 then
					Mission.Event.Finished = true
					luaJM5RemoveEventMarker(Mission.CurrentEventTable.Convoy)
					CountdownCancel()
					Kill(Mission.CurrentEventTable.Convoy, true)
-- RELEASE_LOGOFF  					luaLog("ittittitttittttt")
				end
			end
		end

	elseif ID == 6 then--Cargo hunt

		if Mission.CurrentEventTable.RefUnitTable then

			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint6()
			end

			--retreat
			for idx,unit in pairs(Mission.CurrentEventTable.RefUnitTable) do
				if not unit.Dead and IsInBorderZone(unit) then
					Mission.Event.Finished = true
					luaJM5RemoveEventMarker(unit)
					CountdownCancel()
					return
				elseif unit.Dead and unit.Killreason ~= "exitzone" then
					table.remove(Mission.CurrentEventTable.RefUnitTable, idx)
				elseif unit.Dead and unit.Killreason == "exitzone" then
					Mission.Event.Finished = true
					CountdownCancel()
					return
				end
			end

			if table.getn(Mission.CurrentEventTable.RefUnitTable) == 0 then
				--success msgs
				StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
				Mission.Event.Finished = true
				Mission.Event.Bonus = true
				CountdownCancel()
			end
		end

	elseif ID == 7 then--Patrol

		if Mission.CurrentEventTable.RefUnitTable then

			--timer
			if not Mission.Event.TimerStarted then
				luaJM5EventStartTimer()
				luaJM5EventStartHint7()
			end

			--reached pos
			for idx,unit in pairs(Mission.CurrentEventTable.RefUnitTable) do
				if unit.Dead then
					table.remove(Mission.CurrentEventTable.RefUnitTable, idx)
				else
					local pathTbl = FillPathPoints(Mission.CurrentEventTable.Path)
					local pos = pathTbl[table.getn(pathTbl)]
					if luaGetDistance(unit, pos) < 200 then
						Mission.Event.Finished = true
						CountdownCancel()

						luaJM5RemoveEventMarker(unit)

						if Mission.Airfields[2].Party == PARTY_ALLIED then
							Mission.CurrentEventTable.Failure = Mission.CurrentEventTable.Failure_A
						else
							Mission.CurrentEventTable.Failure = Mission.CurrentEventTable.Failure_B
						end

						return
					end
				end

				if table.getn(Mission.CurrentEventTable.RefUnitTable) == 0 then
					--success msgs
					StartDialog("Event_successDlg"..tostring(Mission.CurrentEventTable.ID), Mission.CurrentEventTable.Success)
					Mission.Event.Finished = true
					Mission.Event.Bonus = true
					CountdownCancel()
				end
			end
		end

	end

end

function luaJM5AddEventMarker(unit)
	luaObj_AddUnit("marker2",1,unit)
end

function luaJM5RemoveEventMarker(unit)
	luaObj_RemoveUnit("marker2",1,unit)
end

function luaJM5Event2PopUp(Navpoint)
	local found = random(0,100)
	if found <= 50 then
		--luaLog("No popup")
		--return
	end

	if Navpoint == 1 then
		GenerateObject("Event2OilTank 01","globals.unitclass_oiltankbig")
		GenerateObject("Event2OilTank 02","globals.unitclass_oiltankbig")
		GenerateObject("Event2OilTank 03","globals.unitclass_oiltankbig")
	elseif Navpoint == 2 then
		--Mission.CapPt = GenerateObject("Event2Pt")
		--SetGuiName(Mission.CapPt, "ingame.shipnames_pt|.101")
		--NavigatorEnable(Mission.CapPt, false)
		--AAEnable(Mission.CapPt,false)
		--TorpedoEnable(Mission.CapPt,false)
		--AddUntouchableUnit(Mission.CapPt)
	elseif navPoint == 3 then
		GenerateObject("Event2Gun 01","fe.tutoriallib_08_title")
		GenerateObject("Event2Gun 02","fe.tutoriallib_08_title")
		GenerateObject("Event2Tower","globals.unitclass_watchtower")
	end

end

function luaJM5InitCapPt()
	Mission.CapPt = GenerateObject("Event2Pt")
	SetGuiName(Mission.CapPt, "ingame.shipnames_pt|.101")
	NavigatorEnable(Mission.CapPt, false)
	AAEnable(Mission.CapPt,false)
	TorpedoEnable(Mission.CapPt,false)
	AddUntouchableUnit(Mission.CapPt)
end

------------------------------------------ CHEATZ -------------------------------------
function luaJM5CheatPutFleet()
	local pathTbl = FillPathPoints(Mission.JapFleetPath)

	for idx,unit in pairs(Mission.AIUnits) do
		if IsInFormation(unit) then
			DisbandFormation(unit)
			--LeaveFormation(unit)
		end
		if idx == 1 then
			--luaLog("Putting unit: "..unit.Name)
			--luaLog("to point: ")
			--luaLog(pathTbl[table.getn(pathTbl)])
			PutTo(unit, pathTbl[table.getn(pathTbl)])
		else
			--luaLog("Putting relto: "..Mission.AIUnits[1].Name)
			--luaLog("unit : "..unit.Name)
			PutRelTo(unit,Mission.AIUnits[1],{["x"]=0,["y"]=0,["z"]=idx*150})
			--JoinFormation(unit, Mission.AIUnits[1])
		end
	end

	local point = Mission.SecCapPoints[1]

	for idx,unit in pairs(Mission.PlayerUnits) do
		if IsInFormation(unit) then
			DisbandFormation(unit)
			--LeaveFormation(unit)
		end
		if idx == 1 then
			PutTo(unit, GetPosition(point))
		else
			PutRelTo(unit,Mission.PlayerUnits[1],{["x"]=0,["y"]=0,["z"]=idx*150})
			--JoinFormation(unit, Mission.PlayerUnits[1])
		end
	end
end

function luaJM5ActivatePowerups()
-- RELEASE_LOGOFF  	LogToConsole("----EVENT POWERUPS CHECK----")
	for idx,eventTbl in pairs(Mission.EventTable) do
		for idx2,event in pairs(eventTbl) do
			if event.Name then
-- RELEASE_LOGOFF  				LogToConsole("Event name: "..event.Name)
			else
-- RELEASE_LOGOFF  				LogToConsole("ERROR: no Name for event")
			end
			if event.Bonus then
-- RELEASE_LOGOFF  				LogToConsole("bonus upon complete "..event.Bonus)
-- RELEASE_LOGOFF  				LogToConsole("Granting powerup")
				luaJM5AddBonus(event.Bonus)
			else
-- RELEASE_LOGOFF  				LogToConsole("ERROR: no Bonus for event")
			end
		end
	end
end

function luaJM5AddBonus(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(19)		--northampton
	PrepareClass(20)		--de ruyter
	PrepareClass(23)		--fletcher
	PrepareClass(25)		--clemson
	PrepareClass(27)		--elco
	PrepareClass(30)		--gato
	PrepareClass(35)		--us tanker
	PrepareClass(36)		--us troop
	PrepareClass(37)		--jap cargo
	PrepareClass(108)
	PrepareClass(112)
	PrepareClass(118)
	PrepareClass(125)		--catalina
	PrepareClass(135) 	--warhawk
	PrepareClass(136)		--dakota
	PrepareClass(150)		--zero
	PrepareClass(158)		--val
	PrepareClass(162)
	PrepareClass(166)		--nell
	--convoy szar
	--convoy nem szar
	--PrepareClass(250)		--us truck
	--PrepareClass(253)		--US Sherman Tank
	--PrepareClass(252)		--US jeep
	--PrepareClass(257)		--US apc
	Loading_Finish()
end

function luaJM5AddMapListener()
	--luaLog("maplistener added")
	AddListener("gui", "IJN5MapListener", {
		["callback"] = "luaJM5OnMap",  -- callback fuggveny
		["guiName"] = {"GUI_Map"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
		["enter"] = {true}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
		})
		--luaJM5StartDialog("Map_hint1",true)
		--luaJM5ShowHintorDlg("Map_hint1",0,true)
end

function luaJM5EnableMap()
	ForceEnableInput(IC_MAP_TOGGLE, true)
	luaJM5MapHint1CleanUp()
end

--function luaJM5OnMap(guiName,enter)
function luaJM5OnMap()

	if luaJM5IsDlgRunning() then
-- RELEASE_LOGOFF  		luaLog("Cant show map hint dlg is running")
		return
	end

	if not Mission.MapHint2Done then
		luaJM5MapHint2()
-- RELEASE_LOGOFF  		luaLog("Showhint MapHint2")
		Mission.MapHint2Done = true
	elseif not Mission.MapHint3Done then
		luaJM5MapHint3()
-- RELEASE_LOGOFF  		luaLog("Showhint MapHint3")
		Mission.MapHint3Done = true
	elseif not Mission.MapHint4Done then
		luaJM5MapHint4()
-- RELEASE_LOGOFF  		luaLog("Showhint MapHint4")
		Mission.MapHint4Done = true
	elseif not Mission.MapHint5Done then
		luaJM5MapHint5()
-- RELEASE_LOGOFF  		luaLog("Showhint MapHint5")
		Mission.MapHint5Done = true
	else
		RemoveListener("gui", "IJN5MapListener")
-- RELEASE_LOGOFF  		luaLog("Removing map listener")
	end

end

function luaJM5IsInCaptureRange()
	if Mission.CapDlg then
		return
	end
	for idx,unit in pairs(Mission.JapUnits.Cargos) do
		if not unit.Dead and luaGetDistance(unit, Mission.RadarStation) < 1500 then
			--luaJM5StartDialog("Cap_range",true)
			luaJM5ShowHintorDlg("Cap_range",0)
			luaDelaySet("EventsEnabled", true, 120)
			luaJM5CaptureHint()
			Mission.CapDlg = true
		end
	end
end

function luaJM5HangarListener()
	AddListener("hit", "hangarhit", {
		["callback"] = "luaJM5HangarHit", -- callback fuggveny
		["target"] = {FindEntity("SecondaryAirfieldHangar 01")}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_AI}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM5HangarHit()
	if Mission.ValSuccessDlg and Mission.ValFailDlg then
		RemoveListener("hit", "hangarhit")
		return
	end
	if not Mission.ValSuccessDlg then
		if luaJM5IsDisabled(Mission.Airfields[2]) then
			--luaJM5StartDialog("Vals_success",true)
			luaJM5ShowHintorDlg("Vals_success",0)
			Mission.ValSuccessDlg = true
			return
		end
	end
	if not Mission.ValFailDlg then
		if not luaJM5IsDisabled(Mission.Airfields[2]) then
			--luaJM5StartDialog("Vals_fail",true)
			luaJM5ShowHintorDlg("Vals_fail",0)
			Mission.ValFailDlg = true
			return
		end
	end
end

function luaJM5CaptureHint()
	--local str = "HINT: To capture an island move your ships close enough to cause the capture bar to appear. The more ships you have in range the faster the bar moves in your favour. LST's and landing boats cause the bar to move even faster.When you see <landing in range icon> icon press <LB icon> to launch landing ships."
	--MissionNarrativeUrgent(str)
	luaJM5ShowHintorDlg("IJN05_Hint01",1)
end

function luaJM5ZeroHint()
	--local str = "HINT: A squadron of Zero fighters have joined your side. They're waiting for your orders."
	--MissionNarrativeEnqueue(str)
	luaJM5ShowHintorDlg("IJN05_Hint02",1)
end

function luaJM5NellHint()
	--local str = "HINT: A squadron of Nell bombers have joined your side. They're waiting for your orders."
	--MissionNarrativeEnqueue(str)
	luaJM5ShowHintorDlg("IJN05_Hint03",1)
end

function luaJM5MapHint1()
	--local str = "HINT: Press <back button icon> to enter the map screen."
	--MissionNarrativeUrgent(str)
	--luaJM5ShowHintorDlg("IJN05_Hint04",1)
	if not IsGUIActive("GUI_map") then
		ShowHint("IJN05_Hint04")
		table.insert(Mission.HintsShowed, "IJN05_Hint04")
	end
end

function luaJM5MapHint2()
	--local str = "HINT: The light areas of the map are within visual range of your units, the green areas are within sonar range (the only way to detect submerged submarines), everything else is covered by radar and shows only the enemy presence not their composition.<LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives."
	--MissionNarrativeUrgent(str)
-- RELEASE_LOGOFF  	luaLog("aaaaa")
	ShowHint("IJN05_Hint05")
	--luaJM5StartDialog("Map_hint2", true)
	luaJM5ShowHintorDlg("Map_hint2",0)
end

function luaJM5MapHint3()
	--local str = "HINT: <LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint06")
end

function luaJM5MapHint4()
	--local str = "HINT: Move the crosshair over a unit to see its details. Use the d-pad as normal to cycle through your own units or press <A button icon> to select a friendly unit under the crosshair. Pressing <A button icon> or <Y button icon> while over an enemy unit will order the currently selected friendly unit to attack that enemy unit.Press <Y button icon> while the crosshair is over empty ocean or sky to set that point as a destination for your currently selected unit. Press <Y button icon> while the crosshair is over a friendly unit to follow that unit with your currently selected unit (this causes a ship to join a formation).Press <B button icon> to cancel orders."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint07")
end

function luaJM5MapHint5()
	--local str = "HINT: Y - select unit A - issue order B - cancel order LB - objectives menu"
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint08")
end

function luaJM5CBHint()
	--local str = "HINT: Buildings and building defences can be selected and controlled just like your other units."
	--MissionNarrativeUrgent(str)
	luaJM5ShowHintorDlg("IJN05_Hint09",1)
end

function luaJM5SMHint()
	--local str = "HINT: Access the new stock through the support manager."
	--MissionNarrativeUrgent(str)
	luaJM5ShowHintorDlg("IJN05_Hint10",1)
end

function luaJM5EventStartHint1()
	luaJM5ShowHintorDlg("IJN05_Hint11",1)
end

function luaJM5EventStartHint2()
	luaJM5ShowHintorDlg("IJN05_Hint12",1)
end

function luaJM5EventStartHint3()
	luaJM5ShowHintorDlg("IJN05_Hint13",1)
end

function luaJM5EventStartHint4()
	luaJM5ShowHintorDlg("IJN05_Hint14",1)
end

function luaJM5EventStartHint5()
	luaJM5ShowHintorDlg("IJN05_Hint15",1)
end

function luaJM5EventStartHint6()
	luaJM5ShowHintorDlg("IJN05_Hint16",1)
end

function luaJM5EventStartHint7()
	luaJM5ShowHintorDlg("IJN05_Hint17",1)
end

function luaJM5EventReminder()
	luaJM5ShowHintorDlg("IJN05_Hint18",1)
end

function luaJM5SetGuiNames()
	--luaLog("allitom a guineveket")

	for idx, unit in pairs(Mission.UntouchUnits) do
		if type(Mission.UntouchUnitNames[idx]) == "table" then
			SetGuiName(unit, Mission.UntouchUnitNames[idx][1])
			luaJM5SetShipNumber(unit, Mission.UntouchUnitNames[idx][2])
		else
			SetGuiName(unit, Mission.UntouchUnitNames[idx])
		end
	end

end

function c()
	Mission.Cheat_PhaseShift = true
end

--[[
function luaJM5ShowHint(hintID)

	--luaLog("luaJM5ShowHint called with param")
	--luaLog(hintID)

	--delay call miatt lesz paramtable
	if type(hintID) == "table" then
		hintID = nil
	end

	local dlgRunning = luaJM5IsDlgRunning()
	local numHints = table.getn(Mission.DelayedHints)
	local inside = false

	if numHints > 0 and hintID then
		for idx,dHint in pairs(Mission.DelayedHints) do
			if hintID == dHint then
-- RELEASE_LOGOFF  				luaLog("Hint "..tostring(hintID).." already in delay queue")
				inside = true
			end
		end
	end

	if dlgRunning and hintID then
-- RELEASE_LOGOFF  		luaLog("Dialog is playing delaying hint "..tostring(hintID))
		if not inside then
			table.insert(Mission.DelayedHints, hintID)
		end
	elseif not dlgRunning then
		if numHints > 0 then
			local idx,dHintID = next(Mission.DelayedHints)
-- RELEASE_LOGOFF  			luaLog("delayed hint id, hint")
-- RELEASE_LOGOFF  			luaLog(idx)
-- RELEASE_LOGOFF  			luaLog(dHintID)
			ShowHint(dHintID)
			table.remove(Mission.DelayedHints, idx)
-- RELEASE_LOGOFF  			luaLog("No dlg playing, showing first delayed hint "..tostring(dHintID))
		elseif numHints == 0 and hintID then
			ShowHint(hintID)
-- RELEASE_LOGOFF  			luaLog("No dlg playing, showing hint")
		end
	end

	if table.getn(Mission.DelayedHints) > 0 then
		luaDelay(luaJM5ShowHint,5)
	end
end
]]
function luaJM5IsHintActive(hintID)

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

function luaJM5AddDlgQ(dlgID, important)
	local tbl = {
		["ID"] = dlgID,
		["Type"] = 0,
		["Time"] = math.floor(GameTime()),
	}
	if important then
		table.insert(Mission.MessageQ, 1, tbl)
	else
		table.insert(Mission.MessageQ, tbl)
	end
end

function luaJM5AddHintQ(hintID, important)
	local tbl = {
		["ID"] = hintID,
		["Type"] = 1,
		["Time"] = math.floor(GameTime()),
	}
	if important then
		table.insert(Mission.MessageQ, 1, tbl)
	else
		table.insert(Mission.MessageQ, tbl)
	end
end

function luaJM5ShowHintorDlg(ID, type, important)

	if Mission.StopMessages then
		if type == 0 then
			luaJM5AddDlgQ(ID, important)
-- RELEASE_LOGOFF  			luaLog("Messages stopped dlg queued")
		elseif type == 1 then
			luaJM5AddHintQ(ID, important)
-- RELEASE_LOGOFF  			luaLog("Messages stopped hint queued")
		end
		return
	end

	local isHintActive = luaJM5IsHintActive()
	local isDlgActive = luaJM5IsDlgRunning()
	local numQ = table.getn(Mission.MessageQ)

	if numQ == 0 and not isHintActive and not isDlgActive then
-- RELEASE_LOGOFF  		luaLog("No q, no active hint and no dialog running")
		if type == 0 then
			luaJM5StartDialog(ID, true)
		elseif type == 1 then
			ShowHint(ID)
			table.insert(Mission.HintsShowed, ID)
-- RELEASE_LOGOFF  			luaLog("Showing hint "..ID)
		end
	elseif (numQ == 0 and (isHintActive or isDlgActive)) or numQ > 0 then
		if type == 0 then
			luaJM5AddDlgQ(ID, important)
-- RELEASE_LOGOFF  			luaLog("No q, but hint or dlg playing adding dlg in q")
		elseif type == 1 then
			luaJM5AddHintQ(ID, important)
-- RELEASE_LOGOFF  			luaLog("No q, but hint or dlg playing adding hint in q")
		end
	end

end

function luaJM5DlgHintQCheck()
	local isHintActive = luaJM5IsHintActive()
	local isDlgActive = luaJM5IsDlgRunning()

	if isHintActive or isDlgActive then
-- RELEASE_LOGOFF  		luaLog("Q check suspended dlg or hint active")
		return
	end

	if Mission.StopMessages then
-- RELEASE_LOGOFF  		luaLog("Q check suspended messages stoped")
		return
	end

	local idx,tbl = next(Mission.MessageQ)

	if tbl.Type == 0 then
-- RELEASE_LOGOFF  		luaLog("Displaying dlg from q "..tbl.ID)
		luaJM5StartDialog(tbl.ID,true)
-- RELEASE_LOGOFF  		luaLog("Time in Q "..tostring(math.floor(GameTime()) - tbl.Time))
		table.remove(Mission.MessageQ, idx)
	elseif tbl.Type == 1 then
-- RELEASE_LOGOFF  		luaLog("Displaying hint from q "..tbl.ID)
		luaJM5HideActHint()
		ShowHint(tbl.ID)
		table.insert(Mission.HintsShowed, tbl.ID)
-- RELEASE_LOGOFF  		luaLog("Time in Q "..tostring(math.floor(GameTime()) - tbl.Time))
		table.remove(Mission.MessageQ, idx)
	end

end

function luaJM5StartMessageQ()
	Mission.MessageQManager = CreateScript("luaJM5MessageQInit")
end

function luaJM5MessageQInit(this)
	--luaLog("Fire init called")
	SetThink(this, "luaJM5MessageQ_think")
end

function luaJM5MessageQ_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		--luaLog("Fire_think killed")
		return
	end

	if table.getn(Mission.MessageQ) > 0 then
		luaJM5DlgHintQCheck()
	end
	SetWait(this, 2)
end

function luaJM5HideActHint()
	local hintTbl = IsHintActive()

	if hintTbl then
		if not IsHintCritical(hintTbl.HintID) then
			HideHint()
		else
-- RELEASE_LOGOFF  			luaLog("Cant hide hints cos its critical")
		end
	end

end

function luaJM5AddJumpinMovie(camType,unitID)
-- RELEASE_LOGOFF  	luaLog(debug.traceback())
	if not luaJM5IsHintActive() then
		luaJumpinMovieSetCurrentMovie(camType, unitID)
		Mission.StopMessages = true
		luaDelay(luaJM5MessagesOn, 10)
	else
		luaDelay(luaJM5AddDelayedJumpinMovie, 5, "camType", camType, "unitID", unitID)
	end
end

function luaJM5AddDelayedJumpinMovie(timerThis)

	if not luaJM5IsHintActive() then
		local camType = timerThis.ParamTable.camType
		local unitID = timerThis.ParamTable.unitID
		luaJumpinMovieSetCurrentMovie(camType, unitID)
		Mission.StopMessages = true
		luaDelaySet("StopMessages", true, 20)
	else
-- RELEASE_LOGOFF  		luaLog("Movie skipped hint crit hint is active")
	end

end

function luaJM5MessagesOn()
	Mission.StopMessages = false
end

function luaJM5MapHint1CleanUp()
	luaJM5HideActHint()
	luaJM5MapHint1()
end

function luaJM5AddRadarCapMovie()
	--luaJumpinMovieSetCurrentMovie("JumpTo", GetPosition(FindEntity("RSMoviePoint")), GetPosition(FindEntity("RSMovieLookatPoint")))
end

function luaJM5DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM5RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

function luaJM5ClearScoreDisplay()
	for idx,display in pairs(Mission.ScoreDisplay) do
		--luaLog("display")
		--luaLog(display)
		if display then
			luaJM5RemoveScore(idx)
			--luaLog("remove score")
		end
	end
end

function luaJM5Pri1Score()
	local cb = FindEntity("SecondaryCommandBuilding 01")
	if cb.Party ~= PARTY_JAPANESE then
		local line1 = "ijn05.obj_p1"
		--local hp = GetHpPercentage(cb) * 100
		local hp = GetCapturePercentage(cb) * 100
		Mission.CaptureProgress = string.format("%.0f",hp)
		local line2 = "ijn05.hint_19_desc"
		luaJM5DisplayScore(1,line1,line2)
		luaDelay(luaJM5Pri1Score, 3)
	end
end

function luaJM5Pri2Score()
	local cb = FindEntity("MainCommandBuilding 01")
	if cb.Party ~= PARTY_JAPANESE then
		local line1 = "ijn05.obj_p2"
		--local hp = GetHpPercentage(cb) * 100
		local hp = GetCapturePercentage(cb) * 100
		Mission.CaptureProgress = string.format("%.0f",hp)
		local line2 = "ijn05.hint_19_desc"
		luaJM5DisplayScore(3,line1,line2)
		luaDelay(luaJM5Pri2Score, 3)
	end
end

function luaJM5Pri3Score()
	local cb = FindEntity("MainCommandBuilding 01")
	if cb.Party ~= PARTY_JAPANESE then
		local line1 = "ijn05.obj_p3"
		--local hp = GetHpPercentage(cb) * 100
		local hp = GetCapturePercentage(cb) * 100
		Mission.CaptureProgress = string.format("%.0f",hp)
		local line2 = "ijn05.hint_19_desc"
		luaJM5DisplayScore(5,line1,line2)
		luaDelay(luaJM5Pri3Score, 3)
	end
end

function luaJM5Sec1Score()
	if Mission.RadarStation.Party ~= PARTY_JAPANESE then
		local line1 = "ijn05.obj_p4"
		--local hp = GetHpPercentage(Mission.RadarStation) * 100
		local hp = GetCapturePercentage(Mission.RadarStation) * 100

		--if hp > 35 and not Mission.RSMovie then
			--luaJM5AddRadarCapMovie()
			--luaJM5CaptureMovie(Mission.RadarStation)
			--Mission.RSMovie = true
		--end

		Mission.CaptureProgress = string.format("%.0f",hp)
		local line2 = "ijn05.hint_20_desc"
		luaJM5DisplayScore(2,line1,line2)
		luaDelay(luaJM5Sec1Score, 3)
	end
end

function luaJM5Sec2Score()
	--local num = table.getn(luaRemoveDeadsFromTable(Mission.Sec2Bunkers))
-- RELEASE_LOGOFF  	luaLog("luaJM5Sec2Score called")
	local num = 0
	for idx,unit in pairs(Mission.Sec2Bunkers) do
		if unit.Dead or luaJM5IsDisabled(unit) then
			if not unit.markerremoved then
				luaObj_RemoveUnit("secondary",1,unit)
				unit.markerremoved = true
			end
		else
			num = num + 1
		end
	end

-- RELEASE_LOGOFF  	luaLog("num "..tostring(num))

	--if num > 0 and luaObj_GetSuccess("secondary",1) == nil then
	--	local line1 = "ijn05.obj_s1"
	--	Mission.BunkersRemaining = num
	--	local line2 = "ijn05.hint_21_desc"
	--	luaJM5DisplayScore(4,line1,line2)
	--	luaDelay(luaJM5Sec2Score, 3)
	--end
end

function luaJM5FleetScore()
	local num = table.getn(luaRemoveDeadsFromTable(Mission.AlliedFleet))
	if num > 0 then
		local line1 = "ijn05.obj_p3"
		Mission.ShipsRemaining = tostring(num)
		local line2 = "ijn05.hint_22_desc"
		luaJM5DisplayScore(6,line1,line2)
		luaDelay(luaJM5FleetScore, 3)
	end
end

function luaJM5UltimateElites()
	Mission.AllElites = true
	Mission.SkillLevel = SKILL_ELITE
	for idx,unitTbl in pairs(recon[PARTY_ALLIED].own) do
		for idx2,unit in pairs(unitTbl) do
			if not unit.Dead and (luaGetType(unit) == "ship" or luaGetType(unit) == "plane" or luaGetType(unit) == "sub") and GetSkillLevel(unit) ~= SKILL_ELITE then
				SetSkillLevel(unit, SKILL_ELITE)
			end
		end
	end
end

function luaJM5NoMoreElites()
	Mission.AllElites = false
	for idx,unitTbl in pairs(recon[PARTY_ALLIED].own) do
		for idx2,unit in pairs(unitTbl) do
			if not unit.Dead and (luaGetType(unit) == "ship" or luaGetType(unit) == "plane" or luaGetType(unit) == "sub") and GetSkillLevel(unit) ~= SKILL_SPNORMAL then
				SetSkillLevel(unit, SKILL_SPNORMAL)
			end
		end
	end
end

function luaJM5CheckUltimateEnemy()
	local RSParty = Mission.RadarStation.Party
	local AF2Party = Mission.Airfields[2].Party
	local AF1Party = Mission.Airfields[1].Party

	if not Mission.AllElites then

		if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
			if AF2Party == PARTY_JAPANESE or AF1Party == PARTY_JAPANESE then
				luaJM5UltimateElites()
-- RELEASE_LOGOFF  				luaLog("RadarStation obj active, but other thing are captured, elites on")
			end
		end

		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			if AF1Party == PARTY_JAPANESE then
				luaJM5UltimateElites()
-- RELEASE_LOGOFF  				luaLog("SecAF obj active, but other thing are captured, elites on")
			end
		end

	else

		if luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) then
			if AF2Party == PARTY_JAPANESE and AF1Party ~= PARTY_JAPANESE then
				luaJM5NoMoreElites()
-- RELEASE_LOGOFF  				luaLog("RadarStation obj done, Port is not captured, elites off")
			end
		end

		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) then
			if AF1Party ~= PARTY_JAPANESE then
				luaJM5NoMoreElites()
-- RELEASE_LOGOFF  				luaLog("SecAF obj active, but Port is not captured, elites on")
			end
		end

	end

end

function luaJM5SetShipNumber(unit,number)
	SetNumbering(unit,number)
end

function luaJM5ObjCam(unit)
	luaCamOnTargetFree(unit, 10, 179, 200, true, "noupdate", 3, luaJM2RepCamDone)
end

function luaJM5MS2KTS(x)
	return x * 1.942615
end

function luaJM5IsInSpeedZone()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerUnits)) do
		if not unit.Dead then
			local inArea
			for idx2,area in pairs(Mission.SpeedZones) do
				inArea = luaIsInArea(area, GetPosition(unit))
				if inArea then
					break
				end
			end
			if not inArea and not unit.SpeedUp then
				--local maxSpeed = luaJM5MS2KTS(unit.Class.MaxSpeed) * 1.2
				local maxSpeed = unit.Class.MaxSpeed * 1.2
				SetShipMaxSpeed(unit, maxSpeed)
				unit.SpeedUp = true
			elseif inArea and unit.SpeedUp then
				--local maxSpeed = luaJM5MS2KTS(unit.Class.MaxSpeed)
				local maxSpeed = unit.Class.MaxSpeed
				SetShipMaxSpeed(unit, maxSpeed)
				unit.SpeedUp = false
			end
		end
	end
end

--------MOVIEZ-------------
--[[
ijn05 Emovies

-- allied reinforcement fleet spawned
-- airfield
-- dakota spawn
-- radarstation capture
-- event spawns: sub
-- event spawns: catalina
-- event spawns: cargos
-- event spawns: pts
-- event spawns: convoy
-- sec. obj. bunkers
]]

function luaJM5MovieInit()
	--SetInvincible(Mission.PlayerCruiser, 0.1)
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	end
end

function luaJM5SelectUnit()
	--SetInvincible(Mission.PlayerCruiser, false)
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	else
		Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
		if Mission.PlayerUnits[1] and not Mission.PlayerUnits[1].Dead then
			SetSelectedUnit(Mission.PlayerUnits[1])
		end
	end
	EnableInput(true)
end

--------------------moviez-----------------------

function luaJM5AlliedReinfMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5AirfieldMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5DakotaMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5EventSubMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 3, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 35, ["theta"] = 3, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5EventCatalinaMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5EventCargoMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5EventPtMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5EventConvoyMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 140, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 80, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5CaptureMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

function luaJM5SecBunkerMovie()

	local unit = Mission.Sec2Bunkers[3]

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM5MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM5SelectUnit, true)
end

------------Checkpoint system--------------------
function luaJM5RestoreJapUnits(chkPointNum)

	local japUnits = luaGetCheckpointData("Units", "JapUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units")
	local leader
	for idx,unit in pairs(Mission.PlayerUnits) do
		local found = false
		for idx2,unitTbl in pairs(japUnits[1]) do
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
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end

		--formation leader
		if unit and not unit.Dead then
			if leader == nil then
				leader = unit
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Setting leader: "..unit.Name)
			end
			if leader then
				if unit.Class.Type == "Cruiser" then
					leader = unit
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting new leader: "..unit.Name)
				end
			end
			if IsInFormation(unit) then
				LeaveFormation(unit)
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Unit leaves formation: "..unit.Name)
			end
		end
	end

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units done, starting to reposition")
	local navPoint
	local lookAt
	if chkPointNum == 1 then
		navPoint = Mission.Checkpoint.Navpoints[1]
		lookAt = GetPosition(FindEntity("SecondaryCommandBuilding 01"))
	else
		navPoint = Mission.Checkpoint.Navpoints[2]
		lookAt = GetPosition(Mission.MainCmdBuilding)
	end
	luaDelay(luaJM5PutUnits, 1.5, "leader", leader, "unitTbl", luaRemoveDeadsFromTable(Mission.PlayerUnits), "navPoint", navPoint, "lookAt", lookAt)

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese AI units")
	local leader
	for idx,unit in pairs(Mission.AIUnits) do
		local found = false
		for idx2,unitTbl in pairs(japUnits[1]) do
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
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end

		--formation leader
		if unit and not unit.Dead then
			if leader == nil then
				leader = unit
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Setting leader: "..unit.Name)
			end
			if leader then
				if unit.Class.Type == "Cruiser" then
					leader = unit
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting new leader: "..unit.Name)
				end
			end
			if IsInFormation(unit) then
				LeaveFormation(unit)
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Unit leaves formation: "..unit.Name)
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese AI units done, starting to reposition")

	local navPoint
	local lookAt
	if chkPointNum == 1 then
		navPoint = GetPosition(Mission.StopPoint)
		lookAt = GetPosition(Mission.MainCmdBuilding)
	else
		navPoint = Mission.Checkpoint.Navpoints[3]
		lookAt = GetPosition(Mission.MainCmdBuilding)
	end
	luaDelay(luaJM5PutUnits, 1.5, "leader", leader, "unitTbl", luaRemoveDeadsFromTable(Mission.AIUnits), "navPoint", navPoint, "lookAt", lookAt)
end

function luaJM5PutUnits(timerThis)

-- RELEASE_LOGOFF  	luaLog(timerThis.ParamTable.lookAt)

	local leader = timerThis.ParamTable.leader
	local unitTbl = timerThis.ParamTable.unitTbl
	local navPoint = timerThis.ParamTable.navPoint
	local angle = luaGetAngle("world", navPoint, timerThis.ParamTable.lookAt)

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."luaJM5PutUnits:")
-- RELEASE_LOGOFF  	luaLog(leader.Name)
-- RELEASE_LOGOFF  	luaLog(leader.Dead)
	--luaLog(unitTbl)
	--luaLog(navPoint)
	--luaLog(angle)

	if not leader.Dead then
		PutTo(leader, navPoint, -angle)
	end

	local i = 1
	local x = 100
	local z = -100
	local multi = {[1] = 1, [2] = -1,}

	for idx,unit in pairs(unitTbl) do

		if not unit.Dead and unit.ID ~= leader.ID then
-- RELEASE_LOGOFF  			luaLog("unit: "..unit.Name)
			local relTbl = {
				["x"] = x * i * multi[math.fmod(i,2)+1],
				["y"] = 0,
				["z"] = z * i,
			}
			if not leader.Dead then
				PutRelTo(unit, leader, relTbl)
				JoinFormation(unit, leader)
				i = i + 1
			else
				local pt = navPoint
				pt.x = pt.x + i * multi[math.fmod(i,2)+1]
				pt.z = pt.z + i * z
				PutTo(unit, pt)
				i = i + 1
			end
		end
	end

	Blackout(false, "", 0.5)

end
------------------------missionspec Save and load functions----------------------
function luaJM5SaveMissionData()
	luaRegisterCheckpointData("Event", "EventTable", Mission.EventTable)
	luaRegisterCheckpointData("Event", "EventBonusAdded", Mission.EventBonusAdded)
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)

	Mission.Checkpoint.Navpoints = {
		GetPosition(FindEntity("Checkpoint 01")),
		GetPosition(FindEntity("Checkpoint 02")),
		GetPosition(FindEntity("Checkpoint 03")),
	}

end

function luaJM5LoadMissionData()
	Mission.EventBonusAdded = Mission.Checkpoint.Event.EventBonusAdded[1]
	Mission.EventTable = Mission.Checkpoint.Event.EventTable[1]
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]

	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	luaJM5RestoreJapUnits(num[1])

	if num[1] == 2 then
		luaJM5Pri2Score()
		luaObj_AddUnit("primary",2,FindEntity("MainCommandBuilding 01"))
	end

	if num[1] > 1 then
		PermitSupportmanager()
	end

	if num[1] == 1 then
		--Mission.EventIntervals = 120
		luaDelaySet("EventsEnabled", true, 20) --hack
		luaObj_AddUnit("primary",1,FindEntity("SecondaryCommandBuilding 01"))
		luaJM5Pri1Score()
		luaJM5AddObjS1(true)
	end

	--local japUnits = luaGetCheckpointData("Units", "JapUnits")
	--local usUnits = luaGetCheckpointData("Units", "USUnits")
	--local nUnits = luaGetCheckpointData("Units", "NUnits")

end

function luaJM5PeteSkill()
	if Mission.Cruiser.Dead then
		return
	end

	local pete = GetLastCatapulted(Mission.Cruiser)
	if pete and not pete.Dead then
		if not pete.skillUpg then
			SetSkillLevel(pete, SKILL_ELITE)
			pete.skillUpg = true
		--else
		--	if not pete.ordcheck then
		--		luaDelay(luaJM5PeteOrdCheat, 15)
		--		pete.ordcheck = true
		--	end
		end
	end
end

function luaJM5PeteOrdCheat()
	if Mission.Cruiser.Dead then
		return
	end

	local pete = GetLastCatapulted(Mission.Cruiser)

	if not pete or pete.Dead then
		return
	end

	if GetSelectedUnit() and GetSelectedUnit().ID ~= pete.ID then
			PlaneReloadBombPlatforms(pete)
	end
	pete.ordcheck = false
end