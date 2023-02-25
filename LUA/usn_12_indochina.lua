--SceneFile="missions\USN\usn_12_Indochina.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--[[
	
	todo: vegen end kamera a vonatot mutassa (scriptelt kell)!!!
	
	todo: forszolva beleultetes az uj gepbe
	
]]

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	--MessageMap betoltese
	LoadMessageMap("usn12dlg",1)
	LandConvoySetSpeed(FindEntity("Train"), 3)
	LandConvoyStop(FindEntity("Train"))
	Dialogues = {
		["intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01c",
				},
				{
					["message"] = "idlg01d",
				},
				{
					["message"] = "idlg01e",
				},
			},
		},
	}
	MissionNarrative("usn12.date_location")
	luaDelay(luaUSN12_Dialog_Intro, 18.5)
end

function luaUSN12_Dialog_Intro()
	StartDialog("intro", Dialogues["intro"])
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitUS12")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitUS12(this)
	Mission = this
	this.Name = "US12"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_12_Indochina.lua"


	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	this.MissionPhase = 1
	this.FirstRun = true
	Blackout(true,"",0)
	
	-- precache
	
    -- allied hajok

	-- allied repcsik
	this.StartLightningTemplate = luaFindHidden("P38 Lightning 01")
	this.Corsair = FindEntity("Corsair")
	this.TrainLightningTemplate = luaFindHidden("LightningTemplate")
	this.CorsairTemplate = luaFindHidden("CorsairTemplate")
	this.Bombers = {}
	this.BomberTemplates = {
		luaFindHidden("B-29 Superfortress 01"),
		luaFindHidden("B-29 Superfortress 02"),
		luaFindHidden("B-29 Superfortress 03"),
		luaFindHidden("B-29 Superfortress 04"),
		luaFindHidden("B-29 Superfortress 05"),
		--luaFindHidden("B-29 Superfortress 06"),- OPTIMALIZALAS
		--luaFindHidden("B-29 Superfortress 07"),
		--luaFindHidden("B-29 Superfortress 08"),
		--luaFindHidden("B-29 Superfortress 09"),
		--luaFindHidden("B-29 Superfortress 10"),
		}
		
	this.Movie_B29_Templates = {}
		table.insert(this.Movie_B29_Templates, luaFindHidden("Movie_B29"))
		table.insert(this.Movie_B29_Templates, luaFindHidden("Movie_B29 01"))
		table.insert(this.Movie_B29_Templates, luaFindHidden("Movie_B29 02"))
	
	this.Movie_B29_Templates_xbox = {}
		table.insert(this.Movie_B29_Templates_xbox, luaFindHidden("Movie_B29_xbox1"))
		table.insert(this.Movie_B29_Templates_xbox, luaFindHidden("Movie_B29_xbox2"))
		table.insert(this.Movie_B29_Templates_xbox, luaFindHidden("Movie_B29_xbox3"))
	
	-- allied pathok, nav pontok
	this.NavToClear = FindEntity("NavToClear")
	this.NavRelease1 = FindEntity("NavRelease1") --B17 release pont
	this.NavRelease1 = FindEntity("NavRelease2") --B17 release pont
	this.NavRelease1 = FindEntity("NavRelease3") --B17 release pont
	this.NavB17Spawn1 = FindEntity("NavB17Spawn1") --B17 Spawn point 
	this.NavB17Spawn2 = FindEntity("NavB17Spawn2") --B17 Spawn point 
	this.NavB17Spawn3= FindEntity("NavB17Spawn3") --B17 Spawn point 
	this.NavWest02 = FindEntity("NavWest02") --Convoy escape point
	this.NavB17North = FindEntity("Navpoint_B17_North")
	this.NavB25 = FindEntity("Navpoint_B25")
	this.NavUsFighterRespawn = FindEntity("Navpoint_usFighter_Respawn")
	this.NavInterceptSpawn1 = FindEntity("Navpoint_Interceptor1")
	this.NavInterceptSpawn2 = FindEntity("Navpoint_Interceptor2")
	this.NavInterceptSpawn3 = FindEntity("Navpoint_Interceptor3")
	this.NavLookat = FindEntity("Navpoint_Lookat")
	this.NavLightning = FindEntity("Navpoint_Corsair")
	this.NavTrainExit = FindEntity("Navpoint_Train_Exit")
	this.NavTrainBridge = FindEntity("Navpoint_Train_Bridge")
	this.NavBridge = FindEntity("NavBridge")
	this.NavRefineryHint = FindEntity("NavRefineryHint")
	this.NavCpConvoyPoints = {}
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 01"))
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 02"))
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 03"))
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 04"))
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 05"))
		table.insert(this.NavCpConvoyPoints, FindEntity("NavCp_Convoy 06"))
		
	this.B17SpawnPoints = {}
		table.insert(this.B17SpawnPoints, this.NavB17Spawn1)
		table.insert(this.B17SpawnPoints, this.NavB17Spawn2)
		table.insert(this.B17SpawnPoints, this.NavB17Spawn3)
		
	this.B17ReleasePoints = {}
		table.insert(this.B17ReleasePoints, this. NavRelease1)
		table.insert(this.B17ReleasePoints, this. NavRelease2)
		table.insert(this.B17ReleasePoints, this. NavRelease3)
	
	this.NavBridgeEffectPosTable = {}
		for i=1,17 do
			local pos = GetPosition(FindEntity("NavBridgeEffect "..tostring(i)))
			table.insert(this.NavBridgeEffectPosTable, pos)	
		end
	-- japanese unitok
	this.Kuma1 = FindEntity("Kuma-class 01")
	this.Kuma2 = FindEntity("Kuma-class 02")
	this.Mogami = FindEntity("Mogami-class 01")
	this.Hangar = FindEntity("Hangar")
	this.Storage = FindEntity("Storage")
	this.Bunker = FindEntity("Bunker")
	this.ZeroTemplatesEast = {}
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 01"))
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 02"))
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 03"))
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 04"))
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 05"))
		table.insert(this.ZeroTemplatesEast, luaFindHidden("ZeroEastTemplate 06"))
	this.ZeroTemplatesWest= {}
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 01"))
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 02"))
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 03"))
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 04"))
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 05"))
		table.insert(this.ZeroTemplatesWest, luaFindHidden("ZeroWestTemplate 06"))
	
	this.RaidenTemplates = {}
		table.insert(this.RaidenTemplates, luaFindHidden("RaidenTemplate 01"))
		table.insert(this.RaidenTemplates, luaFindHidden("RaidenTemplate 02"))
		table.insert(this.RaidenTemplates, luaFindHidden("RaidenTemplate 03"))
		table.insert(this.RaidenTemplates, luaFindHidden("RaidenTemplate 04"))
		table.insert(this.RaidenTemplates, luaFindHidden("RaidenTemplate 05"))
		
	this.RaidenTemplates2 = {}
		table.insert(this.RaidenTemplates2, luaFindHidden("RaidenTemplate 06"))
		table.insert(this.RaidenTemplates2, luaFindHidden("RaidenTemplate 07"))
		table.insert(this.RaidenTemplates2, luaFindHidden("RaidenTemplate 08"))
		table.insert(this.RaidenTemplates2, luaFindHidden("RaidenTemplate 09"))
		table.insert(this.RaidenTemplates2, luaFindHidden("RaidenTemplate 10"))
	
	this.Raidens = {}
	this.Zeros = {}
	
	this.JapCruisers = {
					this.Kuma1,
					this.Kuma2,
					this.Mogami,
					}
	this.JapPT1 = FindEntity("Japanese Patrolboat 01")
	this.JapPT2 = FindEntity("Japanese Patrolboat 02")
	this.JapPT3 = FindEntity("Japanese Patrolboat 03")
	this.JapPT4 = FindEntity("Japanese Patrolboat 04")
	this.JapPT5 = FindEntity("Japanese Patrolboat 05")
	this.JapPT6 = FindEntity("Japanese Patrolboat 06")
	
	this.Minekaze = FindEntity("Minekaze")
	this.Minekaze2 = FindEntity("Minekaze_2")
	
	this.Train = FindEntity("Train")
	this.Bridge = FindEntity("Bridge")
	this.ConvoyShips = {}
		table.insert(this.ConvoyShips, FindEntity("Japan Cargo Transport 02"))
		table.insert(this.ConvoyShips, FindEntity("Japan Tanker 01"))
		table.insert(this.ConvoyShips, FindEntity("Japan Tanker 02"))
		table.insert(this.ConvoyShips, FindEntity("Japan Cargo Transport 03"))
		table.insert(this.ConvoyShips, FindEntity("Japan Tanker 03"))
		table.insert(this.ConvoyShips, FindEntity("Japan Cargo Transport 01"))
						
	-- japanese objektumok
	this.BomberTargets = {
		--this.Storage,
		this.Bunker,
		--this.Hangar,
		this.Kuma1,
		this.Kuma2,
		this.Mogami,
	}

	this.PrimaryTargets = {}
		table.insert(this.PrimaryTargets, FindEntity("AA_Phase1_1"))
		table.insert(this.PrimaryTargets, FindEntity("AA_Bridge_East_4"))
		table.insert(this.PrimaryTargets, FindEntity("Light AA, Sandbag, Japanese 01"))
		table.insert(this.PrimaryTargets, FindEntity("AA_Bridge_North_5"))
		table.insert(this.PrimaryTargets, FindEntity("Light AA, Japanese 01"))
		table.insert(this.PrimaryTargets, FindEntity("Heavy AA, Japanese 01"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 01"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 02"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 03"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 04"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 05"))
		table.insert(this.PrimaryTargets, FindEntity("Japanese Patrolboat 06"))
		table.insert(this.PrimaryTargets, FindEntity("Minekaze"))
		table.insert(this.PrimaryTargets, FindEntity("Minekaze_2"))
			
	this.SecondaryObjects = {}
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 01"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 02"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 06"))
		table.insert(this.SecondaryObjects, FindEntity("Office 01"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 05"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 04"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Japanese 02"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker_b, Tarawa 01"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 03"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 04"))	
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 07"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 06"))
		table.insert(this.SecondaryObjects, FindEntity("Watchtower, 01 02"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker_a, Tarawa 01"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 10"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 03"))
		table.insert(this.SecondaryObjects, FindEntity("Heavy AA, Japanese 02"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Sandbag, Japanese 03"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Japanese 01xx"))
		table.insert(this.SecondaryObjects, FindEntity("Medium Bunker, Concrete 07"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Japanese 03"))
		table.insert(this.SecondaryObjects, FindEntity("Watchtower, 01 05"))
		table.insert(this.SecondaryObjects, FindEntity("Watchtower, 01 06"))
		table.insert(this.SecondaryObjects, FindEntity("Watchtower, 01 04"))
		table.insert(this.SecondaryObjects, FindEntity("Watchtower, 01 03"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Japanese 04"))
		table.insert(this.SecondaryObjects, FindEntity("Light AA, Japanese 05"))
		table.insert(this.SecondaryObjects, FindEntity("Coastal Gun, Japanese 02"))
		table.insert(this.SecondaryObjects, FindEntity("Coastal Gun, Japanese 01"))
		table.insert(this.SecondaryObjects, FindEntity("Office 02"))
		
	this.ObjectTemplates = {}
		--table.insert(this.ObjectTemplates, luaFindHidden("Heavy AA, Japanese 05"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Medium Bunker, Concrete 03"))
		--table.insert(this.ObjectTemplates, luaFindHidden("AA_Bridge_West_1"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Small Pillbox, Concrete 01"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Small Pillbox, Concrete 03"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Light AA, Japanese 02"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Hangar, Small, 02 02"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Storage, 05 02"))
		--table.insert(this.ObjectTemplates, luaFindHidden("House, Small, Wooden, White 04"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Light AA, Japanese 02"))
		--table.insert(this.ObjectTemplates, luaFindHidden("Medium Bunker, Concrete 05"))
					
	this.Oiltanks = {}			
		table.insert(this.Oiltanks, FindEntity("Oil Tank, Big 01"))
		table.insert(this.Oiltanks, FindEntity("Oil Tank, Big 02"))
		table.insert(this.Oiltanks, FindEntity("Oil Tank, Big 05"))
					
	this.OilRefinery = FindEntity("Oil Refinery 01")
	this.StationMain = FindEntity("Station")
	this.StationMain2 = FindEntity("Station 01")
		
	-- japanese pathok, nav pontok
	this.PathPT1 = FindEntity("PT1_path")
	this.PathPT2 = FindEntity("PT2_path")
	this.PathPT3 = FindEntity("PT3_path")
	this.PathPT4 = FindEntity("PT4_path")
	this.PathPT5 = FindEntity("PT5_path")
	this.PathPT6 = FindEntity("PT6_path")
	this.PathDD = FindEntity("DD_path")
	this.PathDD2 = FindEntity("DD2_path")
		
	-- Misc valtozok
	this.BombersShotDown = 0
	this.ConvoyCounter = 1
	this.SecondaryFlag = 0
	this.OperettB17Count = 0
	this.B29Wave = 0
	this.B29Number = 0
	this.SumSecondary = table.getn(this.SecondaryObjects) --ennyi objektum van osszesen
	--this.SecondaryLimit = 30 --ennyi objektumot kell kiloni
	--this.SecondaryDiff = this.SumSecondary - this.SecondaryLimit --ennyi elo ha marad, akkor teljesul a limit
	this.FirstPhaseTimer = 6 -- elso fazis timer percben
	this.PrimaryToKill = 10
	this.SecondaryDebugKillCount = 0
	this.PrimarySum = table.getn(Mission.PrimaryTargets)
	this.B29LossLimit = 9
	this.B29WarningLimit = 4
	this.B29SumPlanes = 0
	this.BridgeBombed = false
	this.CorsairCount = 1
	this.SquadLimit = 3
	this.TrainAchievementGained = false
	-- Teszt valtozok
		
	-- Support Manager tiltas
		
	-- Achievements init
	

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	-- dialogusok

	-- objektivak
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "DestroyDefense",		-- azonosito
				["Text"] = "usn12.obj_p1",
				["TextCompleted"] = "usn12.obj_p1_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "DefendBombers",		-- azonosito
				["Text"] = "usn12.obj_p2",
				["TextCompleted"] = "usn12.obj_p2_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "DestroyTrain",		-- azonosito
				["Text"] = "usn12.obj_p3",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			
		},
		
		["hidden"] = {
			[1] =
			{
				["ID"] = "SinkConvoy",		-- azonosito
				["Text"] = "usn12.obj_h1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		
		["secondary"] = {
			[1] =
			{
				["ID"] = "DestroyObjects",		-- azonosito
				["Text"] = "usn12.obj_s1",
				["TextCompleted"] = "usn12.obj_s1_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	LoadMessageMap("usn12dlg",1)

	Mission.Dialogues = {
		["intro"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a",
				},
				{
					["message"] = "dlg04b",
				},
				{
					["message"] = "dlg04c",
				},
				{
					["message"] = "dlg04d",
				},
				{
					["message"] = "dlg04e",
				},
			},
		},
		["pt_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
			},
		},
		["minekaze_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
			},
		},
		["minekaze_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
				{
					["message"] = "dlg08c",
				},
			},
		},
		["zeros_incoming"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
				{
					["message"] = "dlg17c",
				},
				{
					["message"] = "dlg17d",
				},
			},
		},
		["b29_start"] = {
			["sequence"] = {
				{
					["message"] = "dlg01",
				},
			},
		},
		["b29_underattack"] = {
			["sequence"] = {
				{
					["message"] = "dlg02",
				},
			},
		},
		["b29_damaged"] = {
			["sequence"] = {
				{
					["message"] = "dlg03",
				},
			},
		},
		["b29_manylost"] = {
			["sequence"] = {
				{
					["message"] = "dlg19",
				},
			},
		},
		["b29_failed"] = {
			["sequence"] = {
				{
					["message"] = "dlg20a",
				},
				{
					["message"] = "dlg20b",
				},
			},
		},
		["train_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg07",
				},
			},
		},
		["b29_attack_bridge"] = {
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
				{
					["message"] = "dlg21b",
				},
			},
		},
		["bridge_bombed"] = {
			["sequence"] = {
				{
					["message"] = "dlg22a",
				},
				{
					["message"] = "dlg22b",
				},
				{
					["message"] = "dlg22c",
				},
				{
					["message"] = "dlg22d",
				},
			},
		},
		["train_chase"] = {
			["sequence"] = {
				{
					["message"] = "dlg23a",
				},
				{
					["message"] = "dlg23b",
				},
			},
		},
		["convoy_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
				{
					["message"] = "dlg14c",
				},
				{
					["message"] = "dlg14d",
				},
			},
		},
		["convoy_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
				{
					["message"] = "dlg16b",
				},
			},
		},
		["train_90"] = {
			["sequence"] = {
				{
					["message"] = "dlg09",
				},
				{
					["message"] = "dlg09b",
				},
			},
		},
		["train_80"] = {
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
			},
		},
		["tunnel_ahead"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["train_killed"] = {
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
				{
					["type"] = "callback",
					["callback"] = "luaUS12DelayVictory",
				}
			},
		},
		["train_exited"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS12DelayFailedMission",
				}
			},
		},
}	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()
	
    --SetDeviceReloadTimeMul(0)
    SetThink(this, "US12Think")
	
	--Bomba target invincible 
	SetInvincible(this.Storage,true)
	SetInvincible(this.Hangar,true)
	SetInvincible(this.Bunker,true)
	
	--Train invincible
	for idx,unit in pairs(Mission.Train.Members) do
		SetInvincible(unit, true)
	end
	
	--Station
	SetInvincible(this.StationMain,true)
	SetInvincible(this.StationMain2,true)
			
	--Secondary invincible
	for idx,unit in pairs(Mission.SecondaryObjects) do
		SetInvincible(unit,0.1)
-- RELEASE_LOGOFF  		luaLog(" >>>>>>>>>>>>>>> SECONDARY LISTA <<<<<<<<<<<<<<<<<<<")
-- RELEASE_LOGOFF  		luaLog(unit.Name)
	end
	
	--repcsi magassagok
	SetSelectedUnit(Mission.Corsair)
	SquadronSetTravelAlt(Mission.Corsair,GetPosition(Mission.Corsair).y)
	SquadronSetAttackAlt(Mission.Corsair,GetPosition(Mission.Corsair).y)
	PilotMoveToRange(Mission.Corsair, GetPosition(Mission.NavBridge), 100)
	--reload enable
	SetDeviceReloadEnabled(true)
	
	--bridge always in recon
	SetForcedReconLevel(Mission.Bridge, 2, PARTY_ALLIED)
	
	--recon cheat
	SetSimplifiedReconMultiplier(0.8)
		
	--Init Functions
	Blackout(false, "", 1)
	EnableMessages(true)
	LandConvoySetSpeed(Mission.Train, 3)
	LandConvoyStop(Mission.Train)
	--Difficulty settings
	if Mission.Difficulty == 0 then
		for idx,unit in pairs (luaRemoveDeadsFromTable(Mission.PrimaryTargets)) do
			SetSkillLevel(unit,SKILL_STUN)
		end
		Mission.TrainSpeed = 8
		Mission.FighterSkillLevel = SKILL_STUN
		Mission.FighterWaveCount = 2 --3
	elseif Mission.Difficulty == 1 then
		for idx,unit in pairs (luaRemoveDeadsFromTable(Mission.PrimaryTargets)) do
			SetSkillLevel(unit,SKILL_SPNORMAL)
		end
		Mission.TrainSpeed = 9
		Mission.FighterSkillLevel = SKILL_SPNORMAL
		Mission.FighterWaveCount = 2 --3
	elseif Mission.Difficulty == 2 then
		for idx,unit in pairs (luaRemoveDeadsFromTable(Mission.PrimaryTargets)) do
			SetSkillLevel(unit,SKILL_SPNORMAL)
		end
		Mission.TrainSpeed = 10
		Mission.FighterSkillLevel = SKILL_SPNORMAL
		Mission.FighterWaveCount = 2 --4
	end
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS12Cp1LoadMissionData,luaUS12CpRelocateUnits},
		[2] = {luaUS12Cp1LoadMissionData,luaUS12CpRelocateUnits},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {},
		[2] = {},
	}
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == true then
		luaUS12PhaseManager()
	else
		Blackout(false,"",1.5)
	end
end

function US12Think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")
	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	luaCheckMusic()
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end
	
	-- Dead unitok kitakaritasa
	Mission.SecondaryObjects = luaRemoveDeadsFromTable(Mission.SecondaryObjects)
	Mission.ConvoyShips = luaRemoveDeadsFromTable(Mission.ConvoyShips)
	Mission.Bombers = luaRemoveDeadsFromTable(Mission.Bombers)
	
	luaUS12CheckConditions(this)

	-- MissionPhase 1
	if this.MissionPhase == 1 then
		Mission.MissionPhase = 2
		luaUS12SetPlaneAlt(Mission.Corsair)
		SetInvincible(Mission.Bridge, true)
		luaUS12Phase1Functions()
		--Convoy detected
		AddListener("recon", "listenerConvoyDetected", {
					["callback"] = "luaUS12ConvoyDetected",
					["entity"] = Mission.ConvoyShips,
					["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED },
					})
				
		--Minekaze detected
		AddListener("recon", "listenerMinekazeDetected", {
					["callback"] = "luaUS12MinekazeDetected",
					["entity"] = {Mission.Minekaze},
					["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED },
					})
					
		AddListener("kill", "listenerMinekazeKilled", {
					["callback"] = "luaUS12MinekazeKilled",
					["entity"] = {Mission.Minekaze,Mission.Minekaze2},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
					
		
		--Corsair killed listener
		Mission.PlayerPlane = GetSelectedUnit()
		
		--Robbantando olajtartalyok 40% invincible allitasa				
		for idx,unit in pairs(Mission.Oiltanks) do
			SetInvincible(unit,0.4)
		end
		--PT boatok es Minekaze indulasa
		NavigatorMoveOnPath(Mission.JapPT1, Mission.PathPT1, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.JapPT2, Mission.PathPT2, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.JapPT3, Mission.PathPT3, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.JapPT4, Mission.PathPT4, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.JapPT5, Mission.PathPT5, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.JapPT6, Mission.PathPT6, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.Minekaze, Mission.PathDD, PATH_FM_CIRCLE)
		NavigatorMoveOnPath(Mission.Minekaze2, Mission.PathDD2, PATH_FM_CIRCLE)
		AddDamage(Mission.Minekaze,1800)
		AddDamage(Mission.Minekaze2,1700)
		RepairEnable(Mission.Minekaze,false)
		RepairEnable(Mission.Minekaze2,false)
		
		AddListener("kill", "PrimartyTargetKillListener",{
					["callback"] = "luaUS12PrimaryTargetKilled",
					["entity"] = Mission.PrimaryTargets,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
-- MissionPhase 2
	elseif this.MissionPhase == 2 and this.FirstRun then
		Mission.FirstRun = false
		Mission.Phase2ThinkCounter = 0
							
-- MissionPhase 3
	elseif this.MissionPhase == 3 and this.FirstRun then
		this.FirstRun = false							
		this.Phase3ThinkCounter = 0	
	
-- MissionPhase 4
	elseif this.MissionPhase == 4 and this.FirstRun then
		this.FirstRun = false
		this.Phase4ThinkCounter = 0
		luaObj_Completed("primary",2,true)
						
-- MissionPhase 5
	elseif this.MissionPhase == 5 and this.FirstRun then
		Mission.FirstRun = true
		
	end	
end

function luaUS12CheckConditions()
--MissionPhase 2 Check -> Killing the ground target
	if Mission.MissionPhase == 2 and not Mission.FirstRun then
		Mission.Phase2ThinkCounter = Mission.Phase2ThinkCounter + 1
		if Mission.Phase2ThinkCounter == 1 then
			luaStartDialog("intro")
		elseif Mission.Phase2ThinkCounter == 3 then
			luaObj_Add("primary",1,Mission.PrimaryTargets)
		elseif Mission.Phase2ThinkCounter == 4 then
			luaStartDialog("pt_detected")
			Countdown("usn12.obj_p1_countdown", 1, Mission.FirstPhaseTimer*60, "luaUS12TimerExpired")
			DisplayScores(1,0,"usn12.obj_p1_display",Mission.PrimarySum.." / "..Mission.PrimarySum)
		elseif Mission.Phase2ThinkCounter == 11 then
			ShowHint("USN12_Hint_saverockets")
		end
		if Mission.PlayerPlane.Dead or Mission.PlayerPlane == nil then
			luaUS12CorsairKilled()
		end
	end
--MissionPhase 3 Check
	if Mission.MissionPhase == 3 and not Mission.FirstRun then
		Mission.Phase3ThinkCounter = Mission.Phase3ThinkCounter + 1
		if Mission.Phase3ThinkCounter == 1 then
			luaStartDialog("b29_start")
		elseif Mission.Phase3ThinkCounter == 3 then
			luaObj_Add("primary",2,Mission.Zeros)
			luaStartDialog("zeros_incoming")
		elseif Mission.Phase3ThinkCounter == 4 then
			Mission.KilledPlaneNum = 0
			DisplayScores(2,0,"usn12.obj_p2","usn12.obj_p2_display")
		end
			
		if Mission.Phase3ThinkCounter > 3 and not Mission.BridgeBombed then -- bomber number check
			Mission.Distance = luaGetDistance(Mission.BridgeBomber,Mission.NavBridge)
			Mission.B29LostPlanes = 0
			for idx,unit in pairs (Mission.Bombers) do
				if not unit.Dead then
					local planeTable = GetSquadronPlanes(unit)
					local alivePlanesNum = table.getn(planeTable)
					Mission.B29LostPlanes = Mission.B29LostPlanes + alivePlanesNum
				end
			end
			Mission.KilledPlaneNum = Mission.B29SumPlanes - Mission.B29LostPlanes
			DisplayScores(2,0,"usn12.obj_p2","usn12.obj_p2_display")
			if Mission.KilledPlaneNum == Mission.B29WarningLimit and not Mission.B29WarningDone then
				Mission.B29WarningDone = true
				luaStartDialog("b29_manylost")
			elseif Mission.KilledPlaneNum >= Mission.B29LossLimit then
				Mission.EndMission = true
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
					SetInvincible(unit, true)
					PilotRetreat(unit)
				end
				luaStartDialog("b29_failed")
				luaUS12MissionFailed("b29_lost",luaPickRnd(Mission.Bombers))
			end
		end
		if Mission.PlayerPlane.Dead or Mission.PlayerPlane == nil then
			luaUS12BomberLightningKilled()
		end
	end

--MissionPhase 4 Check	
	if Mission.MissionPhase == 4 and not Mission.FirstRun then
		if Mission.PlayerPlane.Dead or Mission.PlayerPlane == nil then
			luaUS12TrainLightningKilled()
		end
		Mission.Phase4ThinkCounter = Mission.Phase4ThinkCounter + 1
		if Mission.Phase4ThinkCounter == 2 then
			luaStartDialog("train_chase")
		end
		if Mission.Phase4ThinkCounter == 4 then
			luaObj_Add("primary",3,Mission.Train.Members[8])
			for idx,unit in pairs(Mission.Train.Members) do
				SetInvincible(unit, false)
			end
			LandConvoySetSpeed(Mission.Train,Mission.TrainSpeed)
			DisplayUnitHP({Mission.Train.Members[1]}, "usn12.obj_p3")
		elseif Mission.Phase4ThinkCounter == 14 then
			--ShowHint("USN12_Hint_trainengine")
		end
		
		if Mission.Phase4ThinkCounter > 5 then
			luaUS12SecondaryCheck()
		end
		
		if not GetSelectedUnit() == nil then
			if luaGetDistance(GetSelectedUnit(),Mission.NavRefineryHint) < 500 and not Mission.RefineryHinted then
				Mission.RefineryHinted = true
				ShowHint("USN12_Hint_refinery")
			end
		end
		
		local selectedunit = GetSelectedUnit()
		if selectedunit then
			if luaGetDistance(selectedunit, GetPosition(Mission.NavTrainExit)) < 3000 and not Mission.TunnelWarning then
				Mission.TunnelWarning = true
				luaStartDialog("tunnel_ahead")
			end
		end
		if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
			Mission.TrainHP = GetHpPercentage(Mission.Train.Members[1])
			if Mission.TrainHP < 0.9 and Mission.TrainWarning == 0 then
				--elso warning
				luaStartDialog("train_90")
				Mission.TrainWarning = 1
			elseif Mission.TrainHP < 0.8 and Mission.TrainWarning == 1 then
				--masodik warning
				luaStartDialog("train_80")
				Mission.TrainWarning = 2
			elseif Mission.TrainHP < 0.7 and Mission.TrainWarning == 2 then
				--harmadik warning
				Mission.TrainWarning = 3
			end
		end
	end
	
	if table.getn(Mission.ConvoyShips) == 0 and (luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil) then
		--luaStartDialog("convoy_destroyed")
		luaObj_Completed("hidden",1)
	end
end

function luaUS12Phase1Functions()
	--Convoy exit listener
	AddListener("exitzone", "listenerConvoyExited", {
			["callback"] = "luaUS12ConvoyExited",
			["entity"] = Mission.ConvoyShips,
			["exited"] = {true}, -- false: entity entered exit zone, true: entity exited
			})
	
	AddListener("kill", "ConvoyMemberKilled",{
				["callback"] = "luaUS12FirstConvoySunk",
				["entity"] = Mission.ConvoyShips,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
					
	--Convoy start
	for idx,unit in pairs(Mission.ConvoyShips) do
		local exitpos = {["x"]=(GetPosition(Mission.NavWest02).x)-2000,["y"]=GetPosition(Mission.NavWest02).y,["z"]=GetPosition(Mission.NavWest02).z}
		NavigatorMoveToPos(unit,exitpos)
		SetShipSpeed(unit,10)
		AAEnable(unit, false)
	end
	
	if not luaObj_IsActive("primary",2) then
		--Jap cruiserek AA tiltasa az obolben
		for idx,unit in pairs(Mission.JapCruisers) do
			AAEnable(unit, false)
		end
		--uccso cruiser elindul
		AddListener("kill", "CruiserKilled",{
					["callback"] = "luaUS12CruiserKilled",
					["entity"] = Mission.JapCruisers,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
	end
	--Robbantando olajtartalyok 40% invincible allitasa				
	for idx,unit in pairs(Mission.Oiltanks) do
		SetInvincible(unit,0.4)
	end
end

function luaUS12FirstConvoySunk()
	if IsListenerActive("kill", "ConvoyMemberKilled") then
		RemoveListener("kill", "ConvoyMemberKilled")
	end
	--torolve mert szetbassza a missiont
	--[[
	AddPowerup({
		["classID"] = "levelbomb1",
		["useLimit"]	 = 1,
		})	
	]]
end

function luaUS12ConvoyExited()
	if Mission.EndMission then
		return
	else
		if IsListenerActive("exitzone", "listenerConvoyExited") then
			RemoveListener("exitzone", "listenerConvoyExited")
		end
		luaObj_Failed("hidden",1)
	end
end

function luaUS12CruiserKilled(entity)
-- RELEASE_LOGOFF  	luaLog("CruiserKilled meghivodott:  "..tostring(entity.Name))
	entity.Dead = true
	Mission.JapCruisers = luaRemoveDeadsFromTable(Mission.JapCruisers)
-- RELEASE_LOGOFF  	luaLog("japcruisers tabla hossza: "..table.getn(Mission.JapCruisers))
	if table.getn(Mission.JapCruisers) == 1 then
		SetShipMaxSpeed(Mission.JapCruisers[1],10)
		NavigatorMoveToRange(Mission.JapCruisers[1], Mission.NavWest02)
		
	elseif table.getn(Mission.JapCruisers) == 0 then
		if IsListenerActive("kill", "CruiserKilled") then
			RemoveListener("kill", "CruiserKilled")
		end
	end	
end

function luaUS12B29Spawn()
	if Mission.EndMission then
		return
	else
		if Mission.MissionPhase < 3 then
			Mission.B29Wave = Mission.B29Wave + 1
			local units = random(2,4)
			for i = 1, units do
				local spawnpos = GetPosition(Mission.NavB17North)
				spawnpos.x = spawnpos.x + (random(-500,500))
				spawnpos.z = spawnpos.z + (random(-500,500))
				spawnpos.y = 1100
				SpawnNew({
					["party"] = PARTY_USA,
					["groupMembers"] = {
						{
							["Type"] = 117,
							["Name"] = "B-29",
							["Race"] = USA,
							["WingCount"] = 3,
							["Equipment"] = 1,
						},
					},
					["area"] = {
						["refPos"] = spawnpos,
						["angleRange"] = { -1,1},
						["lookAt"] = GetPosition(Mission.NavLookat)
					},
					["callback"] = "luaUS12B29SpawnCallback",
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 25,
						["enemyHorizontal"] = 5,
						["ownVertical"] = 5,
						["enemyVertical"] = 5,
						["formationHorizontal"] = 100,
						
					},
					})
			end
			luaDelay(luaUS12B29Spawn, random(30,60))
		end
	end
end

function luaUS12B29Killed(unit, listenername)
-- RELEASE_LOGOFF  	luaLog(unit)
-- RELEASE_LOGOFF  	luaLog(listenername)
end

function luaUS12B29SpawnCallback(spawnedB29)
	if Mission.EndMission then
		return
	else
		SetSkillLevel(spawnedB29,SKILL_SPVETERAN)
		Mission.B29Number = Mission.B29Number + 1
		spawnedB29.Number = Mission.B29Number
		if Mission.B29Group[Mission.B29Wave] == nil then
			Mission.B29Group[Mission.B29Wave] = {}
		end
		table.insert(Mission.B29Group[Mission.B29Wave], spawnedB29)
		table.insert(Mission.Bombers, spawnedB29)
		SetRoleAvailable(spawnedB29, EROLF_ALL, PLAYER_AI)
		SetInvincible(spawnedB29, true)
		SquadronSetTravelAlt(spawnedB29,1100)
		SquadronSetAttackAlt(spawnedB29,1100)
		SquadronSetReleaseAlt(spawnedB29,1100)
		local b17pos = GetPosition(spawnedB29)
		PutTo(spawnedB29, {["x"]=b17pos.x,["y"]=600,["z"]=b17pos.z})
		
		local ammolistenername = "B29Drop"..spawnedB29.Number
		AddListener("ammoType", ammolistenername, {
					["callback"] = "luaUS12B29Dropped",
					["entity"] = {spawnedB29},
					["ammoType"] = {0},
					})
	end
end

function luaUS12B29Dropped(plane)
	if Mission.EndMission then
		return
	else
-- RELEASE_LOGOFF  		luaLog("--- luaUS12B29Dropped on ---")
		if luaGetScriptTarget(plane) then
-- RELEASE_LOGOFF  			luaLog(luaGetScriptTarget(plane).Name)
			AddDamage(luaGetScriptTarget(plane), 10000)
		end
		local ammolistenername = "B29Drop"..plane.Number
-- RELEASE_LOGOFF  		luaLog("Removing ammo listener: "..ammolistenername)
		RemoveListener("ammoType", ammolistenername)
	end
end

function luaUS12B29Attack(unit)
	local trg = luaPickRnd(Mission.BomberTargets)
-- RELEASE_LOGOFF  	luaLog(trg.Name)
	PilotSetTarget(unit, trg)
	
	luaSetScriptTarget(unit, trg)
end
function luaUS12CountBombers()
	for idx, unit in pairs(Mission.Bombers) do
		if unit.Dead == true then
			Mission.BombersShotDown = Mission.BombersShotDown + 1
		end
	end
end
function luaUS12StartBombers()
-- RELEASE_LOGOFF  	luaLog("--- Managing Bombers ---")
	Mission.StartTime = math.floor(GameTime())
	for idx,unit in pairs (Mission.BomberTemplates) do
		local generatedBomber = GenerateObject(unit.Name)
		table.insert(Mission.Bombers,generatedBomber)
	end
	for idx,unit in pairs (Mission.Bombers) do
		luaUS12SetPlaneAlt(unit)
		SquadronSetSpeed(unit,50)
		Mission.B29Number = Mission.B29Number + 1
		unit.Number = Mission.B29Number
		local ammolistenername = "B29Drop"..Mission.B29Number
-- RELEASE_LOGOFF  		luaLog("Adding ammolistener name:")
-- RELEASE_LOGOFF  		luaLog(ammolistenername)
		AddListener("ammoType", ammolistenername, {
					["callback"] = "luaUS12B29Dropped",
					["entity"] = {unit},
					["ammoType"] = {0},
					})
		Mission.B29SumPlanes = Mission.B29SumPlanes + 3
	end		
	PilotSetTarget(Mission.Bombers[1], Mission.BomberTargets[1]) 
	PilotSetTarget(Mission.Bombers[2], Mission.BomberTargets[2]) --1 OPTIMALIZALAS
	PilotSetTarget(Mission.Bombers[3], Mission.BomberTargets[3]) --2 OPTIMALIZALAS
	PilotSetTarget(Mission.Bombers[4], Mission.BomberTargets[4]) --2 OPTIMALIZALAS
	PilotSetTarget(Mission.Bombers[5], Mission.BomberTargets[3]) -- OPTIMALIZALAS
	--[[
	PilotSetTarget(Mission.Bombers[6], Mission.BomberTargets[3])
	PilotSetTarget(Mission.Bombers[7], Mission.BomberTargets[4])
	PilotSetTarget(Mission.Bombers[8], Mission.BomberTargets[4])
	PilotSetTarget(Mission.Bombers[9], Mission.BomberTargets[5])
	]]
	local BombersWithoutAA = {1,3,4}
	for idx,unit in pairs (BombersWithoutAA) do
		AAEnable(Mission.Bombers[unit], false)
	end
	
	--az utolso a hidat bombazza
	--Mission.BridgeBomber = Mission.Bombers[10] - OPTIMALIZALAS
	Mission.BridgeBomber = Mission.Bombers[5]
	PilotSetTarget(Mission.BridgeBomber, Mission.BomberTargets[4])
	AAEnable(Mission.BridgeBomber, false)
	--hid bombazo invincible cheat
	SetInvincible(Mission.BridgeBomber, 0.2)
	SetSkillLevel(Mission.BridgeBomber, SKILL_ELITE)
	--bridge no more invincible
	SetInvincible(Mission.Bridge,false)
	Mission.Distance = luaGetDistance(Mission.BridgeBomber,Mission.NavBridge)
	--AddWatch("Mission.Distance")
	luaDelay(luaUS12BridgeTargetedDialog,80)
	luaDelay(luaUS12TrainDetected,135)
	luaDelay(luaUS12BridgeBombingPrepare,155)
	--AddProximityTrigger(Mission.BridgeBomber, "BridgeBomberProximity", "luaUS12BridgeBombingPrepare", Mission.Bridge, 870)
	--AddProximityTrigger(Mission.BridgeBomber, "BridgeTrainProximity", "luaUS12TrainDetected", Mission.NavBridge, 2500)
	--AddProximityTrigger(Mission.BridgeBomber, "BridgeProximity", "luaUS12BridgeTargetedDialog", Mission.NavBridge, 6000)
	
	Mission.BomberLightning = GenerateObject(Mission.StartLightningTemplate.Name)
	Mission.PlayerPlane = Mission.BomberLightning
	Mission.BomberLightningCount = 1
	luaUS12SetPlaneAlt(Mission.BomberLightning)
	PilotMoveTo(Mission.BomberLightning,Mission.NavBridge)
	for idx,unit in pairs(Mission.BomberTargets) do
		SetInvincible(unit,false)
	end
	luaUS12GenerateInterceptors()
	AddPowerup({
			["classID"] = "full_throttle",
			["useLimit"]	 = 2,
			})
end
	
function luaUS12BridgeBombingPrepare()
	--luaCheckpoint(2, nil)
	local timer = (math.floor(GameTime()) - Mission.StartTime)
-- RELEASE_LOGOFF  	luaLog(" TIME: Bombing movie start "..tostring(timer))
	luaDelay(luaUS12BridgeBombing, 0.5)
end

function luaUS12BridgeBombing()
	if Mission.EndMission then
		return
	else
		HideScoreDisplay(2,0)			
		Mission.BridgeBombed = true
		Blackout(true, "luaUS12EM_Bridge_1", 1)
	end
end


function luaUS12SetPlaneAlt(planeSquad)
	--beallitja minden gepnek az utazo es tamado magassagot az aktualis magassagat alapul veve
	local altitude = GetPosition(planeSquad).y
	SquadronSetAttackAlt(planeSquad,altitude)
	SquadronSetTravelAlt(planeSquad,altitude)
	SquadronSetReleaseAlt(planeSquad,altitude)
end

function luaUS12TrainDetected()
	if Mission.EndMission then
		return
	else
		LandConvoyStart(Mission.Train)
		LandConvoySetSpeed(Mission.Train,10)
		local timer = (math.floor(GameTime()) - Mission.StartTime)
-- RELEASE_LOGOFF  		luaLog(" TIME: Train start "..tostring(timer))
		luaStartDialog("b29_attack_bridge")	
	end
end

function luaUS12BridgeTargetedDialog()
	if Mission.EndMission then
		return
	else
		local timer = (math.floor(GameTime()) - Mission.StartTime)
-- RELEASE_LOGOFF  		luaLog(" TIME: Train detected dialogus "..tostring(timer))
		luaStartDialog("train_detected")
	end
end

function luaUS12TrainNearStation()
	if Mission.MissionPhase == 3 then
		LandConvoyStop(Mission.Train)
	end
end

function luaUS12TrainKilled()
	if luaObj_GetSuccess("primary",3) ~= false then
		LandConvoyStop(Mission.Train)
		Effect("WreckFire", GetPosition(Mission.Train.Members[8]))
		luaStartDialog("train_killed")
		luaObj_Completed("primary",3)
		if Mission.TrainAchievementGained == true then
			SetAchievements("SA_TK")
		end
		if IsListenerActive("kill", "TrainKilled") then
			RemoveListener("kill", "TrainKilled")
		end
		if IsListenerActive("kill", "listeneroiltankkill") then
			RemoveListener("kill", "listeneroiltankkill")
		end
	end
end

function luaUS12TrainExited()
	if Mission.EndMission then
		return
	else
		if luaObj_GetSuccess("primary",3) == nil then
			if IsListenerActive("kill", "TrainKilled") then
				RemoveListener("kill", "TrainKilled")
			end
			luaStartDialog("train_exited")
			Mission.EndMission = true
		end
	end
end

function luaUS12DelayFailedMission()
	luaUS12MissionFailed("train_escaped",GetSelectedUnit())
end

function luaUS12OiltankKilled(killedunit)

	if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
		local distance = luaGetDistance(GetPosition(killedunit), Mission.Train.Members[1])
		if distance < 300 then
			AddDamage(Mission.Train.Members[1],5000)
			Mission.TrainAchievementGained = true
		end
		killedunit.Dead = true
		Mission.Oiltanks = luaRemoveDeadsFromTable(Mission.Oiltanks)
	end
	if table.getn(Mission.Oiltanks) == 0 then
		if IsListenerActive("kill", "listeneroiltankkill") then
			RemoveListener("kill", "listeneroiltankkill")
		end
	end
end

function luaUS12ConvoySpawnCB(convoyShip)
	NavigatorMoveToPos(convoyShip, Mission.NavWest02)

end

function luaUS12SecondaryCheck()
	if Mission.SecondaryFlag ~= -1 then
		Mission.SecondaryFlag = Mission.SecondaryFlag + 1
		if Mission.SecondaryFlag == 3 then
			Mission.SecondaryFlag = -1
		end
	end
	if Mission.SecondaryFlag == -1 then
		if luaObj_GetSuccess("secondary",1) == nil and not luaObj_IsActive("secondary",1) then
			luaObj_Add("secondary",1)
			DisplayScores(3,0,"usn12.obj_s1_display","0 / "..Mission.SumSecondary)
-- RELEASE_LOGOFF  			luaLog("------------SECONDARY LISTA---------------")
			for idx,unit in pairs(Mission.SecondaryObjects) do
				SetInvincible(unit,false)
			end
-- RELEASE_LOGOFF  			luaLog("------------SECONDARY LISTA---------------")
					
		end
			
		if luaObj_GetSuccess("secondary",1) == nil and luaObj_IsActive("secondary",1) then
			Mission.SecondaryObjects = luaRemoveDeadsFromTable(Mission.SecondaryObjects)
			if table.getn(Mission.SecondaryObjects) == 0 then
				luaObj_Completed("secondary",1,true)
				HideScoreDisplay(3,0)
			else
				local secondaryKilled = Mission.SumSecondary - table.getn(Mission.SecondaryObjects)
				DisplayScores(3,0,"usn12.obj_s1_display", secondaryKilled.." / "..Mission.SumSecondary)
				if GetSelectedUnit() ~= nil then
					Mission.playerUnit = GetSelectedUnit()
				else
					Mission.playerUnit = Mission.NavLookat
				end
				for idx,unit in pairs(Mission.SecondaryObjects) do
					if unit.MarkedSecondary then
						luaObj_RemoveUnit("secondary",1,unit)
						unit.MarkedSecondary = false
						--luaLog("Removed marker : "..tostring(unit.Name))
					end
				end
				local nearLandforts = luaUS12GetLandforts(Mission.playerUnit , 1500, "enemy")
				Mission.SecondaryObjectsSorted = luaSortByDistance(Mission.playerUnit, nearLandforts)
				if Mission.SecondaryObjectsSorted ~= nil then
					for idx,unit in pairs(Mission.SecondaryObjectsSorted) do
						if unit.MarkedSecondary then
							luaObj_RemoveUnit("secondary",1,unit)
							unit.MarkedSecondary = false
							--luaLog("Removed marker : "..tostring(unit.Name))
						end
					end
					--luaLog("---SecondaryObjectsSorted hossza: "..table.getn(Mission.SecondaryObjectsSorted))
					--luaLog(Mission.SecondaryObjectsSorted)
					local count = 0
					for idx,unit in pairs(Mission.SecondaryObjectsSorted) do
						if not unit.Dead and luaIsInside(unit, Mission.SecondaryObjects) then
							luaObj_AddUnit("secondary",1,unit)
							--luaLog("secondary Marked: "..tostring(unit.Name))
							unit.MarkedSecondary = true
							count = count + 1
							--luaLog("*Distance "..idx.." :"..tostring(luaGetDistance(GetSelectedUnit(), unit)))
							if count == 4 or count == table.getn(Mission.SecondaryObjectsSorted) then
								break
							end
						end
					end
				end
			end
		end
	end
end

function luaUS12ConvoyDetected()
	if Mission.EndMission then
		return
	else
		if IsListenerActive("recon", "listenerConvoyDetected") then
			RemoveListener("recon", "listenerConvoyDetected")
		end
		--luaStartDialog("convoy_detected") --removed
		luaObj_Add("hidden",1)
	end
end

function luaUS12MissionFailed(reason,entity)
	for i=1,3 do
		if luaObj_IsActive("primary",i) and luaObj_GetSuccess("primary",i) == nil then
			luaObj_Failed("primary",i)
		end
	end 
	for i=1,1 do
		if luaObj_IsActive("secondary",i) and luaObj_GetSuccess("secondary",i) == nil then
			luaObj_Failed("secondary",i)
		end
	end
	for i=1,1 do
		if luaObj_IsActive("hidden",i) and luaObj_GetSuccess("hidden",i) == nil then
			luaObj_Failed("hidden",i)
		end
	end
	if reason == "b29_lost" then
		luaUS12RetreatBombers()
		luaMissionFailedNew(entity, "usn12.obj_p2_failed")
	elseif reason == "train_escaped" then
		luaMissionFailedNew(entity, "usn12.obj_p3_failed_escape")
	elseif reason == "bridge_missed" then
		luaMissionFailedNew(entity, "Bridge is still standing!")
	elseif reason == "b25_lost" then
		luaMissionFailedNew(entity, "B25 squadron is down!")
	elseif reason == "lightning" then
		luaMissionFailedNew(Mission.Train.Members[8], "usn12.obj_p3_failed_fighters")
	elseif reason == "timer" then
		luaMissionFailedNew(entity, "usn12.obj_p1_failed")
	elseif reason == "corsair" then
		luaMissionFailedNew(entity, "usn12.obj_p1_failed_corsair")
	elseif reason == "bomberlightning" then
		luaUS12RetreatBombers()
		luaMissionFailedNew(entity, "usn12.obj_p3_failed_fighters")
	elseif reason == "trainlightning" then
		luaMissionFailedNew(Mission.TrainLightning, "usn12.obj_p3_failed_fighters")
	end
	
end

function luaUS12RetreatBombers()
	Mission.Bombers = luaRemoveDeadsFromTable(Mission.Bombers)
	for idx,unit in pairs(Mission.Bombers) do
		PilotRetreat(unit)
	end
end

function luaUS12PrimaryMarkerCheck()
	if Mission.EndMission then
		return
	else
		--luaLog("primarytargetcheck called")
		Mission.PrimaryTargets = luaRemoveDeadsFromTable(Mission.PrimaryTargets)
		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			if GetSelectedUnit() ~= nil then
				Mission.playerUnit = GetSelectedUnit()
			else
				Mission.playerUnit = Mission.NavLookat
			end
			Mission.PrimaryObjectsSorted = luaSortByDistance(Mission.playerUnit , Mission.PrimaryTargets)
			for idx,unit in pairs(Mission.PrimaryTargets) do
				if unit.MarkedPrimary then
					luaObj_RemoveUnit("primary",1,unit)
					unit.MarkedPrimary = false
				end
			end
			local count = 0
			for idx,unit in pairs(Mission.PrimaryObjectsSorted) do
				luaObj_AddUnit("primary",1,unit)
				--luaLog("unit added to primary markers: "..unit.Name)
				unit.MarkedPrimary = true
				count = count + 1
				if count == 4 or count == table.getn(Mission.PrimaryObjectsSorted) then
					break
				end
			end
		end
	end
end

function luaUS12LevelbombManager()
	if Mission.EndMission then
		return
	else
		if Mission.B29Wave == 3 then
			local b17pos = luaPickRnd(Mission.B17SpawnPoints)
			local b17lookat = luaPickRnd(Mission.B17ReleasePoints)
		
			SpawnNew({
			["party"] = PARTY_USA,
			["groupMembers"] = {
				{
					["Type"] = 116,
					["Name"] = "B-17",
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = GetPosition(b17pos),
				["angleRange"] = { -1,1},
				["lookAt"] = GetPosition(b17lookat)
			},
			["callback"] = "luaUS12OperettB17CB",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 5,
				["enemyHorizontal"] = 5,
				["ownVertical"] = 5,
				["enemyVertical"] = 5,
				["formationHorizontal"] = 100,
				
			},
			})
		end
	end
end

function luaUS12OperettB17CB(operettb17)
	SetInvincible(operettb17,true)
	Mission.OperettB17Count = Mission.OperettB17Count + 1
	local b17target = luaPickRnd(Mission.B17ReleasePoints)
	SquadronSetTravelAlt(operettb17,800)
	SquadronSetAttackAlt(operettb17,800)
	SquadronSetReleaseAlt(operettb17,800)
	PilotMoveTo(operettb17, b17target)
	local triggerName = "releasetrigger"..tostring(Mission.OperettB17Count)
	AddProximityTrigger(operettb17, triggerName, "luaUS12ForceRelease", b17target, 200)
	local random = luaRnd(1,60)
	luaDelay(luaUS12LevelbombManager,60)
end

function luaUS12ForceRelease(unit)
	if Mission.EndMission then
		return
	else
		SquadronForceRelease(unit)
		PilotRetreat(unit)
	end
end

function luaUS12Phase()
	if Mission.MissionPhase == 2 then
		for idx,unit in pairs(Mission.PrimaryTargets)do
			AddDamage(unit,8000)
		end
	elseif Mission.MissionPhase	== 3 then
		for idx,unit in pairs(Mission.Raidens) do
			Kill(unit)
		end
		for idx,unit in pairs(Mission.Zeros) do
			Kill(unit)
		end
		LandConvoyStart(Mission.Train)
		LandConvoySetSpeed(Mission.Train,15)
		luaDelay(luaUS12BridgeBombingPrepare,4)
	end	
	
end

function luaUS12GetLandforts(target, radius, allegiance)
	if allegiance == nil then
		error("***Script function error: no 'allegiance' parameter at luaGetLandforts.", 2)
	elseif allegiance ~= "enemy" and allegiance ~= "neutral" and allegiance ~= "own" then
		error("***Script function error: bad 'allegiance' parameter at luaGetLandforts: "..allegiance, 2)
	end
-- RELEASE_LOGOFF  	Assert(target ~= nil and target.ID ~= nil, "***ERROR: luaGetLandforts's first param must have an ID key!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaGetLandforts "..target.Name..","..radius..","..tostring(allegiance))
			
	local targetUnit = thisTable[target.ID]
	local landfortsAround = {}
	local i = 0
	for key, unittype in pairs(recon[targetUnit.Party][allegiance]) do
		if key == "landfort" then
			for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  				luaHelperLog(" Unit "..unit.Name)
				if not unit.Dead and luaGetDistance(unit, targetUnit) < radius then
					tonumber(i)
					i = i+1
					landfortsAround[key..tostring(i)] = unit
				end
			end
		end
	end
			
	--return shipsAround
	if next(landfortsAround) == nil then
		return nil
	else
		return landfortsAround
	end
end

function luaUS12GenerateInterceptors()
	local randomPos = luaRnd(1,2)
	if randomPos == 1 then
		for i=1,Mission.FighterWaveCount do
			local generatedZero = GenerateObject(Mission.ZeroTemplatesEast[i].Name)
			PilotSetTarget(generatedZero, Mission.Bombers[luaRnd(1,3)])
			SquadronSetTravelAlt(generatedZero, 700)
			SquadronSetAttackAlt(generatedZero, 700)
			SetSkillLevel(generatedZero,Mission.FighterSkillLevel)
			--Rookie difficulty -> set at least one fighter squad to normal bot level
			if i==Mission.FighterWaveCount and Mission.Difficulty == 0 then
				SetSkillLevel(generatedZero,SKILL_SPNORMAL)
			end
			table.insert(Mission.Zeros, generatedZero)
		end
	else
		for i=1,Mission.FighterWaveCount do
			local generatedZero = GenerateObject(Mission.ZeroTemplatesWest[i].Name)
-- RELEASE_LOGOFF  			luaLog("west zero general")
-- RELEASE_LOGOFF  			luaLog(generatedZero)
			PilotSetTarget(generatedZero, Mission.Bombers[luaRnd(1,3)])
			SquadronSetTravelAlt(generatedZero, 700)
			SquadronSetAttackAlt(generatedZero, 700)
			SetSkillLevel(generatedZero,Mission.FighterSkillLevel)
			--Rookie difficulty -> set at least one fighter squad to normal bot level
			if i==Mission.FighterWaveCount and Mission.Difficulty == 0 then
				SetSkillLevel(generatedZero,SKILL_SPNORMAL)
			end
			table.insert(Mission.Zeros, generatedZero)
		end
	end
	
	luaDelay(luaUS12RaidensGenerate,35)
end

function luaUS12RaidensGenerate()
	if Mission.EndMission then
		return
	else
		for i=1,Mission.FighterWaveCount do
			local generatedRaiden = GenerateObject(Mission.RaidenTemplates[i].Name)
			PilotSetTarget(generatedRaiden, Mission.Bombers[luaRnd(1,4)]) --[luaRnd(3,6)] -OPTIMALIZALAS
			SquadronSetTravelAlt(generatedRaiden, 700)
			SquadronSetAttackAlt(generatedRaiden, 700)
			SetSkillLevel(generatedRaiden,Mission.FighterSkillLevel)
			--Rookie difficulty -> set at least one fighter squad to normal bot level
			if i==Mission.FighterWaveCount and Mission.Difficulty == 0 then
				SetSkillLevel(generatedRaiden,SKILL_SPNORMAL)
			end
			table.insert(Mission.Raidens, generatedRaiden)
		end
		luaDelay(luaUS12AddRaidenListener,4)
		luaDelay(luaUS12Raidens2Generate,25)
	end
end

function luaUS12Raidens2Generate()
	if Mission.EndMission then
		return
	else
		for i=1,Mission.FighterWaveCount do
			local generatedRaiden = GenerateObject(Mission.RaidenTemplates2[i].Name)
			PilotSetTarget(generatedRaiden, Mission.Bombers[luaRnd(1,4)]) --[luaRnd(3,6)] -OPTIMALIZALAS
			SquadronSetTravelAlt(generatedRaiden, 700)
			SquadronSetAttackAlt(generatedRaiden, 700)
			SetSkillLevel(generatedRaiden,Mission.FighterSkillLevel)
			table.insert(Mission.Raidens, generatedRaiden)
			--Rookie difficulty -> set at least one fighter squad to normal bot level
			if i==Mission.FighterWaveCount and Mission.Difficulty == 0 then
				SetSkillLevel(generatedRaiden,SKILL_SPNORMAL)
			end
			--luaObj_AddUnit("primary", 2, generatedRaiden)
		end
	end
end

function luaUS12AddRaidenListener()
	if not Mission.EndMission then
		AddListener("recon", "listenerRaidenDetected", {
					["callback"] = "luaUS12RaidenDetected",
					["entity"] = {Mission.Raidens[1]},
					["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED },
					})
	else
		return
	end
end

function luaUS12RaidenDetected()
	if Mission.EndMission then
		return
	else
		if IsListenerActive("recon", "listenerRaidenDetected") then
			RemoveListener("recon", "listenerRaidenDetected")
		end
		for idx,unit in pairs (Mission.Raidens) do
			luaObj_AddUnit("primary", 2, unit)
			luaDelay(luaUS12_Hint_Raidens,5)
		end
	end
end

function luaUS12_Hint_Raidens()
	if Mission.EndMission then
		return
	else
		ShowHint("USN12_Hint_raiden")		
	end
end


function luaUS12TimerExpired()
	if luaObj_IsActive("primary",1) and not luaObj_GetSuccess("primary",1) then
		Mission.EndMission = true
		luaUS12MissionFailed("timer",luaPickRnd(Mission.PrimaryTargets))
	end
end

function luaUS12CorsairKilled()
	if Mission.CorsairCount < Mission.SquadLimit then
		--respawn kell
		Mission.Corsair = GenerateObject(Mission.CorsairTemplate.Name)
		Mission.PlayerPlane = Mission.Corsair
		SquadronSetTravelAlt(Mission.Corsair,GetPosition(Mission.Corsair).y)
		SquadronSetAttackAlt(Mission.Corsair,GetPosition(Mission.Corsair).y)
		PilotMoveToRange(Mission.Corsair, GetPosition(Mission.NavBridge), 100)		
		Mission.CorsairCount = Mission.CorsairCount + 1
		if Mission.CorsairCount == Mission.SquadLimit then
			--last squadron spawned -> warning
			luaDelay(luaUS12_Hint_LastSquadron,4)
		end
		if GetSelectedUnit() == nil or GetSelectedUnit().Dead then
		luaJumpToUnit(Mission.Corsair)
		end
	else		
		if luaObj_IsActive("primary",1) and not luaObj_GetSuccess("primary",1) then
			Mission.EndMission = true
			luaUS12MissionFailed("corsair",luaPickRnd(luaRemoveDeadsFromTable(Mission.PrimaryTargets)))
		end
	end
end

function luaUS12_Hint_LastSquadron()
	if Mission.EndMission then
		return
	else
		ShowHint("USN12_Hint_planelimit")		
	end
end

function luaUS12Primary1CompleteDelay()
	if Mission.EndMission then
		return
	else
		luaObj_Completed("primary",1,true)
		CountdownCancel()
		HideScoreDisplay(1,0)
		Blackout(true, "luaUSPhase3Prepare_1", 2)
		--luaCheckpoint(1, nil)
	end
end

function luaUSPhase3Prepare_1()
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		--luaCheckpoint(1, nil)
	end
	luaUS12StartBombers()
	luaUS12EM_Bombers()
end

function luaUS12PrimaryTargetKilled(killedtarget)
	killedtarget.Dead = true
	Mission.PrimaryTargets = luaRemoveDeadsFromTable(Mission.PrimaryTargets)
	local targetsLeft = table.getn(Mission.PrimaryTargets)
	DisplayScores(1,0,"usn12.obj_p1_display",targetsLeft.." / "..Mission.PrimarySum)
	if targetsLeft == 0 then
		if (IsListenerActive("kill", "PrimartyTargetKillListener")) then
			RemoveListener("kill", "PrimartyTargetKillListener")
		end
		luaDelay(luaUS12Primary1CompleteDelay,3)
	end
end

function luaUS12MinekazeDetected()
	if IsListenerActive("recon", "listenerMinekazeDetected") then
		RemoveListener("recon", "listenerMinekazeDetected")
	end
	luaStartDialog("minekaze_detected")
end

function luaUS12MinekazeKilled()
	if IsListenerActive("kill", "listenerMinekazeKilled") then
		RemoveListener("kill", "listenerMinekazeKilled")
	end
	luaStartDialog("minekaze_killed")
end

function luaUS12TrainLightningKilled()
	if Mission.TrainLightningCount < (Mission.SquadLimit+2) then
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 104,
				["Name"] = "P-38 Lightning",
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 0,
				["Velocity"] = 200.0,
			},
		},
		["area"] = {
			["refPos"] = Mission.NavBridge,
			["angleRange"] = {-1,1},
			--["lookAt"] = GetPosition(Mission.NavTrainExit)
		},
		["callback"] = "luaUS07TrainLightningSpawnCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100,
			
		},
		})
	else
		Mission.EndMission = true
		luaUS12MissionFailed("trainlightning")
	end
end

function luaUS07TrainLightningSpawnCB(spawnedLightning)
	Mission.TrainLightning = spawnedLightning
	Mission.PlayerPlane = Mission.TrainLightning
	Mission.TrainLightningCount = Mission.TrainLightningCount + 1
	if GetSelectedUnit() == nil or GetSelectedUnit().Dead then
	luaJumpToUnit(spawnedLightning,"",2)
	end
	if Mission.TrainLightningCount == (Mission.SquadLimit + 2) then
		--last squadron spawned -> warning
		luaDelay(luaUS12_Hint_LastSquadron,4)		
	end
end


function luaUS12BomberLightningKilled()
	if Mission.BomberLightningCount < Mission.SquadLimit then
		
		local spawnPos = {["x"] = GetPosition(Mission.BridgeBomber).x+100, ["y"]= GetPosition(Mission.BridgeBomber).y, ["z"]= GetPosition(Mission.BridgeBomber).z + 500}
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 104,
				["Name"] = "P-38 Lightning",
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 0,
				["Velocity"] = 200.0,
			},
		},
		["area"] = {
			["refPos"] = spawnPos,
			["angleRange"] = {-1,1},
			["lookAt"] = GetPosition(Mission.BridgeBomber)
		},
		["callback"] = "luaUS07BomberLightningSpawnCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100,
			
		},
		})
	else
		Mission.EndMission = true
		luaUS12MissionFailed("bomberlightning", luaPickRnd(luaRemoveDeadsFromTable(Mission.Bombers)))
	end
end

function luaUS07BomberLightningSpawnCB(spawnedLightning)
	Mission.BomberLightningCount = Mission.BomberLightningCount + 1
	Mission.BomberLightning = spawnedLightning
	Mission.PlayerPlane = Mission.BomberLightning
	if GetSelectedUnit() == nil or GetSelectedUnit().Dead then
	luaJumpToUnit(spawnedLightning,"",2)
	end
	if Mission.BomberLightningCount == Mission.SquadLimit then
		--last lighting spawned -> warning
		luaDelay(luaUS12_Hint_LastSquadron,4)		
	end
end

function luaUS12PreparePhase4()
	local enemyPlanesClose = luaGetPlanesAroundCoordinate(GetPosition(Mission.NavToClear), 600, PARTY_JAPANESE, "own", nil, nil, nil)
	local ownPlanesClose = luaGetPlanesAroundCoordinate(GetPosition(Mission.NavToClear), 600, PARTY_ALLIED, "own", nil, nil, nil)
	if enemyPlanesClose ~= nil then
		for idx,unit in pairs (enemyPlanesClose) do
			Kill(unit,true)
-- RELEASE_LOGOFF  			luaLog("enemy repcsi kill: "..unit.Name)
		end
	end
	if ownPlanesClose ~= nil then
		for idx,unit in pairs (ownPlanesClose) do
			Kill(unit,true)
-- RELEASE_LOGOFF  			luaLog("sajat repcsi kill: "..unit.Name)
		end
	end
	Mission.TrainLightning = GenerateObject(Mission.TrainLightningTemplate.Name)
	Mission.PlayerPlane = Mission.TrainLightning
	Mission.TrainLightningCount = 1
-- RELEASE_LOGOFF  	luaLog("TrainLightning GENERATED!!!")
	SetInvincible(Mission.TrainLightning, true)
	luaUS12SetPlaneAlt(Mission.TrainLightning)
	PilotMoveTo(Mission.TrainLightning,Mission.Train.Members[8])
	if Mission.BomberLightning ~= nil and not Mission.BomberLightning.Dead then
		Kill(Mission.BomberLightning,true)
	end
	AddListener("kill", "TrainKilled",{
				["callback"] = "luaUS12TrainKilled",
				["entity"] = {Mission.Train.Members[1]},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
	
	AddProximityTrigger(Mission.Train.Members[8], "trainExited", "luaUS12TrainExited", Mission.NavTrainExit, 50)
	Mission.TrainWarning = 0
	Mission.TrainHP = GetHpPercentage(Mission.Train.Members[1])
	--AddWatch("Mission.TrainHP")
	for idx,unit in pairs (Mission.Oiltanks) do
		SetInvincible(unit, false)
	end
	AddListener("kill", "listeneroiltankkill", {
				["callback"] = "luaUS12OiltankKilled",
				["entity"] = Mission.Oiltanks,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
			})
	
end


--[[
*****************************************************************************************
**                         		INGAME ENGINE MOVIES                                   **
*****************************************************************************************
]]

function luaUS12EM_Bridge_1()
	--Blackout(true, "", 1)
	--[[local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) or ((num ~= nil) and (table.getn(num)>0) and (num[1] ~= 2)) then
		--luaCheckpoint(2, nil)
	end]]
	luaDelay(luaUS12EM_Bridge_2, 1)
end

function luaUS12EM_Bridge_2()
	luaCamOnTargetFree(Mission.Bridge, 8, 55, 180, false, nil , 0, luaUS12EM_Bridge_3)
	Blackout(false, "", 1)
	BlackBars(true)
end

function luaUS12EM_Bridge_3()
	Mission.BombEffectCounter = 0
	luaDelay(luaUS12FakeBombing,3.5)
	luaCamOnTargetFree(Mission.Bridge, 5, 48, 180, false, nil , 11, luaUS12EM_Bridge_4)
end

function luaUS12EM_Bridge_4()
	luaStartDialog("bridge_bombed")
	if Mission.Bridge.Dead == false then
		AddDamage(Mission.Bridge, 1000000)
	end
	Blackout(true, "luaUS12EM_Bridge_5", 1.5)
	BlackBars(false)
	luaUS12PreparePhase4()
end

function luaUS12EM_Bridge_5()
	Blackout(false, "", 1)
-- RELEASE_LOGOFF  	luaLog("setselected trainlightning!!!!!")
	SetSelectedUnit(Mission.TrainLightning)
	SetInvincible(Mission.TrainLightning, false)
	EnableInput(true)
	Mission.MissionPhase = 4
	Mission.FirstRun = true
end

function luaUS12Train()
	LandConvoyStart(Mission.Train)
	luaObj_Add("primary",3,Mission.Train.Members[8])
	for idx,unit in pairs(Mission.Train.Members) do
		SetInvincible(unit, false)
	end
end

function luaUS12FakeBombing()
	Mission.BombEffectCounter = Mission.BombEffectCounter + 1
	if Mission.BombEffectCounter < 18 then
		local EffectPos = Mission.NavBridgeEffectPosTable[Mission.BombEffectCounter]
		if EffectPos.y > 1 then
			Effect("ImpactBigArmor", EffectPos)
		else
			Effect("ImpactBigBombWater", EffectPos)
		end
		luaDelay(luaUS12FakeBombing,0.1)
		if Mission.BombEffectCounter == 9 then
			AddDamage(Mission.Bridge,10000)
		end
	end
end

function luaUS12EM_Bombers()
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Bombers[1], ["distance"] = 60, ["theta"] = 20, ["rho"] = 5, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Bombers[1], ["distance"] = 60, ["theta"] = 10, ["rho"] = 3, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	       {["postype"] = "target", ["target"] = Mission.Bombers[3], ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			    },
    			luaUS12EM_Bombers_Fade,
    			true, nil, false
				)
	
end

function luaUS12EM_Bombers_Fade()
	Blackout(true, "luaUS12EM_Bombers_End", 0.5)
end

function luaUS12EM_Bombers_End()
	if Mission.Corsair ~= nil and not Mission.Corsair.Dead then
 		Kill(Mission.Corsair,true)
 	end
	EnableInput(true)
	SetSelectedUnit(Mission.BomberLightning)
	Blackout(false, "", 0.5)
	Mission.MissionPhase = 3 
	Mission.FirstRun = true
end

--[[
*****************************************************************************************
**                         		PATH SMOOTHING TOOL                                    **
*****************************************************************************************
]]

function luaTestPath()
	local pathPoints = FillPathPoints(FindEntity("Railway"))
	local centerPos = pathPoints[1]

	local lastKey = table.getn(pathPoints)
	local interpolatedPathPoints = {}
	local maxDistance = 20

	for key, value in pairs (pathPoints) do
		--[[
		if key > 100 and key < 500 then
			value.y = value.y + 5
		end
		]]
		if key ~= lastKey then
			local distanceCoordinate = {}
			distanceCoordinate.x = pathPoints[key+1].x - value.x
			distanceCoordinate.y = pathPoints[key+1].y - value.y
			distanceCoordinate.z = pathPoints[key+1].z - value.z
			
			local distance = math.sqrt(math.pow(distanceCoordinate.x, 2)+math.pow(distanceCoordinate.z, 2)+math.pow(distanceCoordinate.y, 2))
			local inserted = math.floor(distance/maxDistance)

			local modifier = {}
			modifier.x = distanceCoordinate.x / (inserted+1)
			modifier.y = distanceCoordinate.y / (inserted+1)
			modifier.z = distanceCoordinate.z / (inserted+1)

			table.insert(interpolatedPathPoints, value)
			for i=1, inserted do
				local insertedPoint = {}
				insertedPoint.x = value.x + i*modifier.x
				insertedPoint.y = value.y + i*modifier.y
				insertedPoint.z = value.z + i*modifier.z

				table.insert(interpolatedPathPoints, insertedPoint)
			end
		else
			table.insert(interpolatedPathPoints, value)
		end
	end

	pathPoints = interpolatedPathPoints

	local file = io.open("Indochina.tmp", "w+")

	file:write("entity \"Railway\" (Path) {", "\n")
	file:write("  localframe 1.0000 0.0000 0.0000 0.0000 0.0000 1.0000 0.0000 0.0000 0.0000 0.0000 1.0000 0.0000 "..luaTestFormatForSceneFile(pathPoints[1].x).." "..luaTestFormatForSceneFile(pathPoints[1].y).." "..luaTestFormatForSceneFile(pathPoints[1].z).." 1.0000 ;", "\n")
	file:write("  template \"Path\" ;", "\n")
	file:write("", "\n")
	file:write("  properties (Common, Path, MultiEntity)  {", "\n")
	file:write("    \"MultiType\" {", "\n")
	file:write("    }", "\n")
	file:write("    Party = E Party : Neutral  ;", "\n")
	file:write("    \"PathPoints\" {", "\n")
	file:write("      \"Point00\" {", "\n")
	file:write("        Pos = V3 0.0000 0.0000 0.0000 ;", "\n")
	file:write("      }", "\n")

	for key, worldPos in pairs (pathPoints) do
		if key > 1 and key < 11 then
			file:write("      \"Point0"..(key-1).."\" {", "\n")
		elseif key > 10 then
			file:write("      \"Point"..(key-1).."\" {", "\n")
		end
		if key > 1 then
			file:write("        Pos = V3 "..luaTestFormatForSceneFile(luaTestConvertWorldToRel(centerPos, worldPos).x).." "..luaTestFormatForSceneFile(luaTestConvertWorldToRel(centerPos, worldPos).y).." "..luaTestFormatForSceneFile(luaTestConvertWorldToRel(centerPos, worldPos).z).." ;", "\n")
			file:write("      }", "\n")
		end
	end

	file:write("    }", "\n")
	file:write("  }", "\n")
	file:write("}", "\n")
	file:close()

--[[
entity "New path" (Path) {
  localframe 1.0000 0.0000 0.0000 0.0000 0.0000 1.0000 0.0000 0.0000 0.0000 0.0000 1.0000 0.0000 PosX PosY PosZ 1.0000 ;
  template "Path" ;

  properties (Common, Path, MultiEntity)  {
    "MultiType" {
    }
    Party = E Party : Neutral  ;
    "PathPoints" {
      "Point00" {
        Pos = V3 0.0000 0.0000 0.0000 ;
      }
    }
  }
}
]]
end

function luaTestFormatForSceneFile(number)
	local rounded = tostring(number)
	local decimal = string.find(rounded, ".", 1, true)
	if decimal then
		rounded = string.sub(rounded, 1, decimal+4)
	end
	return rounded
end

function luaTestConvertWorldToRel(centerPos, worldPos)
	local relPos =
	{
		["x"] = worldPos.x - centerPos.x,
		["y"] = worldPos.y - centerPos.y,
		["z"] = worldPos.z - centerPos.z,
	}
	return relPos
end

--[[
*****************************************************************************************
**                         			  CHECKPOINT FUNCTIONS							   **
*****************************************************************************************
]]
function luaUS12Cp1LoadMissionData()
	MissionNarrativeClear()
end

function luaUS12CpRelocateUnits()
-- RELEASE_LOGOFF  	luaLog("luaUS12CpRelocateUnits: #1")
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if num[1] == 1 then
		for idx,unit in pairs(Mission.PrimaryTargets) do
			Kill(unit,true)
			HideScoreDisplay(1,0)
		end
		local ijnsaved = luaGetCheckpointData("Units", "JapUnits")
		for idx,unit in pairs(Mission.ConvoyShips) do
		local found = false
		for idx2,unitTbl in pairs(ijnsaved[1]) do
			if unit.Name == unitTbl[1] then
				found = true
				break
			end
		end
		
		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog("Turret not found, killing it "..unit.Name)
			Kill(unit, true)
		end
	end
		
	elseif num[1] == 2 then
		for idx,unit in pairs(Mission.PrimaryTargets) do
			Kill(unit,true)
			HideScoreDisplay(1,0)
		end
		for idx,unit in pairs(Mission.JapCruisers) do
			SetInvincible(unit, 0.3)
			AddDamage(unit,10000)
			AAEnable(unit, false)
			SetInvincible(unit, false)
		end
		for idx,unit in pairs(Mission.BomberTargets) do
			SetInvincible(unit,false)
		end
		Kill(Mission.Corsair,true)
		--generate fake b29 for bridge bombing
		--[[
		Mission.MovieB29s = {}
		if PC then
			Mission.MovieBombers = Mission.Movie_B29_Templates
		else
			Mission.MovieBombers = Mission.Movie_B29_Templates_xbox
		end
		for idx,unit in pairs (Mission.MovieBombers) do
			Mission.MovieB29s[idx] = GenerateObject(Mission.MovieBombers[idx].Name)
			PilotSetTarget(Mission.MovieB29s[idx], Mission.Bridge)
			SetRoleAvailable(Mission.MovieB29s[idx], EROLF_ALL, PLAYER_AI)
			SetSkillLevel(Mission.MovieB29s[idx], SKILL_ELITE)
		end
		luaDelay(luaUS12MovieB29Retreat,12)
		]]
-- RELEASE_LOGOFF  		luaLog("luaUS12CpRelocateUnits: #2")
		--train teleport
		AddProximityTrigger(Mission.Train.Members[8], "trainonbridge", "luaUS12TrainOnBridge", Mission.NavTrainBridge, 40)
		LandConvoySetSpeed(FindEntity("Train"), 400)
		LandConvoyStart(Mission.Train)
		
		--convoy relocate/Kill
		local ijnsaved = luaGetCheckpointData("Units", "JapUnits")
		for idx,unit in pairs(Mission.ConvoyShips) do
			local found = false
			for idx2,unitTbl in pairs(ijnsaved[1]) do
				if unit.Name == unitTbl[1] then
					found = true
					break
				end
			end
			--Kill
			if not found then
-- RELEASE_LOGOFF  				luaLog("Turret not found, killing it "..unit.Name)
				Kill(unit, true)
			end
		end
		if luaObj_GetSuccess("hidden", 1) ~= true then
			for idx,unit in pairs(Mission.ConvoyShips) do
				PutTo(unit, GetPosition(Mission.NavCpConvoyPoints[idx]),100)
				local exitpos = {["x"]=(GetPosition(Mission.NavWest02).x)-2000,["y"]=GetPosition(Mission.NavWest02).y,["z"]=GetPosition(Mission.NavWest02).z}
				NavigatorMoveToPos(unit,exitpos)
				SetShipSpeed(unit,10)
				AAEnable(unit, false)				
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog("luaUS12CpRelocateUnits: #3")
end

function luaUS12TrainOnBridge()
	LandConvoySetSpeed(FindEntity("Train"), 10)
end

function luaUS12MovieB29Retreat()
	for idx,unit in pairs(Mission.MovieB29s) do
		PilotRetreat(unit)
	end
end

function luaUS12PhaseManager()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if num[1] == 1 then
		luaUSPhase3Prepare_1()
		luaUS12Phase1Functions()	
	elseif num[1] == 2 then
		Mission.MissionPhase = 666
		luaUS12BridgeBombing()
		luaUS12Phase1Functions()
	end
end

function luaUS12DelayVictory()
	Mission.EndMission = true
	luaMissionCompletedNew(GetSelectedUnit(),"usn12.obj_p3_success")
	local medal = luaGetMedalReward()
	if (medal == MEDAL_GOLD) then
		Scoring_GrantBonus("US12_SCORING_GOLD", "usn12.bonus1_title", "usn12.bonus1_text", 116)
	end
end

function luaPrecacheUnits()
	PrepareClass(116)--B-17
	--PrepareClass(167)--Betty
end