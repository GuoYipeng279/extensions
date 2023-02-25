--SceneFile="missions\USN\usn_14_battle_of_okinawa.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--todo: landing trigger "landing_ongoing" dialogushoz
--todo: convoy nem megy ki teljesen megall a border szelenel
--todo: dinamikus ellenallas a vegen
--todo: kis csonakok kapjanak uj targetet mindig
--todo: transport ship loss -> vesztes legyen
--todo: felgyujtando epuleteket veglegesiteni (906. sor)

function luaEngineMovieInit()
	EnableMessages(false)
	Music_Control_SetLevel(MUSIC_TENSION)
	--MessageMap betoltese
	LoadMessageMap("usn14dlg",1)
	Dialogues = {
		["intro_1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
			},
		},
		["intro_2"] = {
			["sequence"] = {
				{
					["message"] = "idlg02",
				},
			},
		},
		["intro_3"] = {
			["sequence"] = {
				{
					["message"] = "idlg03",
				},
			},
		},
	}
	MissionNarrative("usn14.date_location")
	luaDelay(luaUSN14_Dialog_Intro1, 17)
	luaDelay(luaUSN14_Dialog_Intro2, 34.5)
	luaDelay(luaUSN14_Dialog_Intro3, 47)
	luaDelay(luaUSN14_SmokeStart,30)
end

function luaUSN14_SmokeStart()
	Effect("EnvironmentSmoke", GetPosition(FindEntity("NavSmoke1")))
	Effect("SmallFire", GetPosition(FindEntity("NavSmoke2")))
	Effect("GiantSmoke", GetPosition(FindEntity("NavSmoke3")))
end

function luaUSN14_Dialog_Intro1()
	StartDialog("intro_1", Dialogues["intro_1"] )
end

function luaUSN14_Dialog_Intro2()
	StartDialog("intro_2", Dialogues["intro_2"] )
end

function luaUSN14_Dialog_Intro3()
	StartDialog("intro_3", Dialogues["intro_3"] )
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitUS14")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitUS14(this)
	Mission = this
	this.Name = "US14"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_14_battle_of_okinawa.lua "

			
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
			
	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	this.MissionPhase = 1
	this.FirstRun = true

	Mission.ChangeableNames = {}
	Mission.ChangeableNames[11] = {	-- Allen M. Sumner
		"ingame.shipnames_hank",
		"ingame.shipnames_borie",
		"ingame.shipnames_soley",
		"ingame.shipnames_hyman",
		"ingame.shipnames_compton"
	}
	Mission.ChangeableNames[48] = {	-- ASW Fletcher
		"ingame.shipnames_stockham",
		"ingame.shipnames_picking",
		"ingame.shipnames_remey",
		"ingame.shipnames_wadleigh",
		"ingame.shipnames_mertz"
	}
	Mission.ChangeableNames[900] = {	-- Luppis
		"ingame.shipnames_english",
		"ingame.shipnames_harlan_r_dickson",
		"ingame.shipnames_laffey",
		"ingame.shipnames_strong",
		"ingame.shipnames_charles_s_sperry",
	}
	Mission.ChangeableNames[17] ={	-- Atlanta
		"ingame.shipnames_fresno",
		"ingame.shipnames_tucson",
		"ingame.shipnames_spokane",
	}
	Mission.ChangeableNames[390] ={	-- Alaska
		"ingame.shipnames_hawaii",
		"ingame.shipnames_puerto_rico",
		"ingame.shipnames_philippine",
	}
	Mission.ChangeableNames[15] = {	-- Iowa
		"ingame.shipnames_wisconsin",
		"ingame.shipnames_illinois",
	}
	Mission.ChangeableNames[389] = { -- Montana
		"ingame.shipnames_lousiana",
		"ingame.shipnames_montana",		
	}
	
	-- allied hajok
	this.usTroopTransports = {}
		--table.insert(this.usTroopTransports, FindEntity("USTroopTransport 01"))
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 02"))
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 03"))	
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 04"))
		--table.insert(this.usTroopTransports, FindEntity("USTroopTransport 05"))
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 06"))
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 07"))
		table.insert(this.usTroopTransports, FindEntity("USTroopTransport 08"))
		-- ideiglenesen az LSM is benne a transportok kozott
		table.insert(this.usTroopTransports, FindEntity("Landing Ship, Medium - Rocket 01"))
	
	this.usCV = FindEntity("Yorktown-class 01")
	this.usBB = FindEntity("South Dakota Class 01")
	this.usCA = FindEntity("Northampton-class 01")
	this.AlabamaTemplate = luaFindHidden("AlabamaTemplate")
	this.usLSMTemplate = luaFindHidden("LSM_Template")
	this.SupportConvoyTemplates = {}
		table.insert(this.SupportConvoyTemplates, luaFindHidden("US Cargo Transport 01"))
		table.insert(this.SupportConvoyTemplates, luaFindHidden("Fletcher-class 06"))
	
	this.SupportConvoyNames = {}
		table.insert(this.SupportConvoyNames, "USS Andromeda")
		table.insert(this.SupportConvoyNames, "USS Waters")
		
	this.PlayerShips = {}
		table.insert(this.PlayerShips, FindEntity("Fletcher-class 01"))
		table.insert(this.PlayerShips, FindEntity("Fletcher-class 02"))
		table.insert(this.PlayerShips, FindEntity("Fletcher-class 03"))
		table.insert(this.PlayerShips, FindEntity("Fletcher-class 04"))
		--table.insert(this.PlayerShips, FindEntity("Fletcher-class 05"))
		table.insert(this.PlayerShips, FindEntity("Yorktown-class 01"))
		table.insert(this.PlayerShips, FindEntity("South Dakota Class 01"))
		table.insert(this.PlayerShips, FindEntity("Northampton-class 01"))
	for idx, unit in pairs(this.PlayerShips) do
		if IsClassChanged(unit.ClassID) then
			luaSetUnlockName(unit)
		end
	end
		
	this.alliedHQs = {}
	
	-- allied repcsik
	
	-- allied pathok, nav pontok
		
	-- japanese unitok
	this.japDD1 = FindEntity("Fubuki-class 01")
	this.japDD2 = FindEntity("Fubuki-class 02")
	this.japJudy = FindEntity("D4Y Judy 01")
	this.YamatoTempateCheckpoint = luaFindHidden("YamatoTempateCheckpoint")
	SetGuiName(this.japJudy , "D4Y Judy")
	this.Kashumi = FindEntity("Fubuki-class 07")
	this.japPlanes = {}
	this.AirPatrol1 = {}
	this.AirPatrol2 = {}
	this.Shipyard1Ships	= {}
	this.Shipyard2Ships	= {}
	this.Shipyard3Ships	= {}
	this.NorthAttackers = {}
	this.CenterAttackers = {}
	this.SouthAttackers = {}
	this.usFighters = {}
	this.usBombers = {}
	
	-- japanese objektumok
	this.NorthHQ = FindEntity("CommandBuilding_North")
	this.CenterHQ = FindEntity("CommandStation_Center")
	this.SouthHQ = FindEntity("CommandStation_South")
		
	this.Airfield1 = FindEntity("AirField01")
	this.Airfield2 = FindEntity("AirField02")
	this.Shipyards = {}
		table.insert(this.Shipyards, FindEntity("Shipyard01"))
			FindEntity("Shipyard01").Spawnpos = FindEntity("Shipyard01_Spawnpos")
		table.insert(this.Shipyards, FindEntity("Shipyard02"))
			FindEntity("Shipyard02").Spawnpos = FindEntity("Shipyard02_Spawnpos")
		table.insert(this.Shipyards, FindEntity("Shipyard03"))
			FindEntity("Shipyard03").Spawnpos = FindEntity("Shipyard03_Spawnpos")
		
	-- japanese pathok, nav pontok
	this.ConvoyPath = FindEntity("ConvoyPath")
	this.YamatoStartPoints = {}
		table.insert(this.YamatoStartPoints, FindEntity("Navpoint_Yamato_Start_1"))
		table.insert(this.YamatoStartPoints, FindEntity("Navpoint_Yamato_Start_2"))
		table.insert(this.YamatoStartPoints, FindEntity("Navpoint_Yamato_Start_3"))
	this.NavYamatoFinish = FindEntity("Navpoint_Yamato_Finish")
	
	this.Nav_japDD = FindEntity("Navpoint_Center01")
	this.japPlaneSpawnPoints = {}
		table.insert(this.japPlaneSpawnPoints, FindEntity("Navpoint_East01"))
		table.insert(this.japPlaneSpawnPoints, FindEntity("Navpoint_East02"))
		table.insert(this.japPlaneSpawnPoints, FindEntity("Navpoint_East03"))
		table.insert(this.japPlaneSpawnPoints, FindEntity("Navpoint_North03"))
		table.insert(this.japPlaneSpawnPoints, FindEntity("Navpoint_South02"))
		
	this.japConvoyAttackSpawnPoints = {}
		table.insert(this.japConvoyAttackSpawnPoints, FindEntity("Navpoint_East02"))
		table.insert(this.japConvoyAttackSpawnPoints, FindEntity("Navpoint_East03"))
		table.insert(this.japConvoyAttackSpawnPoints, FindEntity("Navpoint_South02"))
		
	this.japShipSpawnPoints = {}
		table.insert(this.japShipSpawnPoints, FindEntity("Navpoint_North01"))
		table.insert(this.japShipSpawnPoints, FindEntity("Navpoint_North02"))
		table.insert(this.japShipSpawnPoints, FindEntity("Navpoint_South01"))
			
	this.NavConvoyStart = FindEntity("Navpoint_ConvoyStart")
	this.NavConvoyExit = FindEntity("Navpoint_ConvoyExit")
		
	this.AreaNorth = FindEntity("Navpoint_Area_North")
	this.AreaCenter = FindEntity("Navpoint_Area_Center")
	this.AreaSouth = FindEntity("Navpoint_Area_South")
	
	this.NorthHQ.AreaPos = GetPosition(this.AreaNorth)
	this.CenterHQ.AreaPos = GetPosition(this.AreaCenter)
	this.SouthHQ.AreaPos = GetPosition(this.AreaSouth)
	
	this.NorthHQ.CapturedFlag = false
	this.CenterHQ.CapturedFlag = false
	this.SouthHQ.CapturedFlag = false
	
	this.NorthHQ.Location = "North"
	this.CenterHQ.Location = "Center"
	this.SouthHQ.Location = "South"
	
	this.AvengerSpawnPos = FindEntity("Navpoint_West02")
	this.NavReinfocement = FindEntity("Navpoint_Reinforcement")
	this.NavPTLookat = FindEntity("NavPTLookat")
	
	this.HQs = {}
		table.insert(this.HQs, this.NorthHQ)
		table.insert(this.HQs, this.CenterHQ)
		table.insert(this.HQs, this.SouthHQ)
	
	this.CPNavpoints = {}
		this.CPNavpoints.North = {}
			this.CPNavpoints.North.CV = {}
				table.insert(this.CPNavpoints.North.CV, FindEntity("NavCpCVNorth 01"))
				table.insert(this.CPNavpoints.North.CV, FindEntity("NavCpCVNorth 02"))
			this.CPNavpoints.North.Transports = {}
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 01"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 02"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 03"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 04"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 05"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 06"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 07"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 08"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 09"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 10"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 11"))
				table.insert(this.CPNavpoints.North.Transports, FindEntity("NavCpTransportNorth 12"))
			this.CPNavpoints.North.Fleet = {}
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 01"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 02"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 03"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 04"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 05"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 06"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 07"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 08"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 09"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 10"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 11"))
				table.insert(this.CPNavpoints.North.Fleet, FindEntity("NavCpFleetNorth 12"))
				
		this.CPNavpoints.Center = {}
			this.CPNavpoints.Center.CV = {}
				table.insert(this.CPNavpoints.Center.CV, FindEntity("NavCpCVCenter 01"))
				table.insert(this.CPNavpoints.Center.CV, FindEntity("NavCpCVCenter 02"))
			this.CPNavpoints.Center.Transports = {}
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 01"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 02"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 03"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 04"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 05"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 06"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 07"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 08"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 09"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 10"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 11"))
				table.insert(this.CPNavpoints.Center.Transports, FindEntity("NavCpTransportCenter 12"))
			this.CPNavpoints.Center.Fleet = {}
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 01"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 02"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 03"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 04"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 05"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 06"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 07"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 08"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 09"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 10"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 11"))
				table.insert(this.CPNavpoints.Center.Fleet, FindEntity("NavCpFleetCenter 12"))
				
		this.CPNavpoints.South = {}
			this.CPNavpoints.South.CV = {}
				table.insert(this.CPNavpoints.South.CV, FindEntity("NavCpCVSouth 01"))
				table.insert(this.CPNavpoints.South.CV, FindEntity("NavCpCVSouth 02"))
			this.CPNavpoints.South.Transports = {}
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 01"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 02"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 03"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 04"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 05"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 06"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 07"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 08"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 09"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 10"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 11"))
				table.insert(this.CPNavpoints.South.Transports, FindEntity("NavCpTransportSouth 12"))
			this.CPNavpoints.South.Fleet = {}
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 01"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 02"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 03"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 04"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 05"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 06"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 07"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 08"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 09"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 10"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 11"))
				table.insert(this.CPNavpoints.South.Fleet, FindEntity("NavCpFleetSouth 12"))
			
	-- Misc valtozok
	this.LandingStarted = false
	this.ThinkCounter = 0
	this.NorthPower = 0
	this.CenterPower = 0
	this.SouthPower = 0
	this.LastJapPlaneSpawned = 0
	this.JapPlaneSpawnInterval = 80 --ennyi masodpercenkent spawnol a palya szelen
	this.ShipyardLimit = 3 --ennyi hajo lehet kint egy shipyardbol maximum
	this.LastShipyard1Spawned = 10
	this.LastShipyard2Spawned = 0
	this.LastShipyard3Spawned = 0
	this.JapShipSpawnInterval = 80
	this.PeaceTime = 1 --ennyi percig van nyugi, nem swarmol az ellenfel
	this.SwarmTime = 5 --ennyi percig tamad az ellen mint a vocsok
	this.CycleTime = -1 --egy cikluson beluli szamlalo
	this.FirstCaptured = false
	this.SecondCaptured = false
	this.EndMission = false
	this.YamatoTimer = 16 --timer a yamato warninghoz, ehhez kepest 2 perc mulva jon meg
	this.ConvoyTimer = 12 --timer convoy spawnhoz percben
	this.YamatoKilled = -1 --0 ha mar megszuletett, 1 ha kilotek, -1 ha meg nem spawnolt
	this.ConvoyActive = false
	this.ConvoyAttackInterval = 90 --ennyi masodpercenkent spawnol tamado gep a covoy ideje alatt
	this.LastConvoyAttackerSpawned = 0
	this.HQMovieRunning = false --HQ mozi futasat jelzi

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
				["ID"] = "CaptureOkinawa",		-- azonosito
				["Text"] = "usn14.obj_p1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "KillYamato",		-- azonosito
				["Text"] = "usn14.obj_p2",
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
				["ID"] = "YamatoBeach",		-- azonosito
				["Text"] = "usn14.obj_h1",
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
				["ID"] = "SaveConvoy",		-- azonosito
				["Text"] = "usn14.obj_s1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
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
	LoadMessageMap("usn14dlg",1)

	Mission.Dialogues = {
		["capture_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
			},
		},
		["easter"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
				{
					["message"] = "dlg02b",
				},
				{
					["message"] = "dlg02c",
				},
				{
					["message"] = "dlg02d",
				},
				{
					["message"] = "dlg02e",
				},
				{
					["message"] = "dlg02f",
				},
				{
					["message"] = "dlg02g",
				},
				{
					["message"] = "dlg02h",
				},
			},
		},
		["kamikaze_incoming"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["kamikaze_hit"] = {
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
				{
					["message"] = "dlg04f",
				},
				{
					["message"] = "dlg04g",
				},
			},
		},
		["ships_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
			},
		},
		["reinforcements_arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
			},
		},
		["yamato_warning"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07a_1",
				},
				{
					["message"] = "dlg07b",
				},
			},
		},
		["landing_succcess"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
			},
		},
		["landing_ongoing"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
				{
					["message"] = "dlg09b",
				},
				{
					["message"] = "dlg09c",
				},
				{
					["message"] = "dlg09d",
				},
				{
					["message"] = "dlg09d_1",
				},
			},
		},
		["landing_numbers"] = {
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
			},
		},
		["yamato_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
				{
					["message"] = "dlg11c",
				},
				{
					["message"] = "dlg11d",
				},
				{
					["message"] = "dlg11e",
				},
			},
		},
		["yamato_closing"] = {
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
					["message"] = "dlg12d",
				},
				{
					["message"] = "dlg12e",
				},
				{
					["message"] = "dlg12f",
				},
				{
					["message"] = "dlg12g",
				},
				{
					["message"] = "dlg12h",
				},
			},
		},
		["yamato_halfway"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
				{
					["message"] = "dlg13c",
				},
			},
		},
		["yamato_near"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["yamato_beached"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a",
				},
				{
					["message"] = "dlg15b",
				},
				{
					["message"] = "dlg15c",
				},
				{
					["message"] = "dlg15d",
				},
				{
					["message"] = "dlg15e",
				},
				{
					["message"] = "dlg15f",
				},
			},
		},
		["yamato_sinked_before"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
				{
					["message"] = "dlg16b",
				},
				{
					["message"] = "dlg16c",
				},
			},
		},
		["yamato_sinked_after"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
			},
		},
		["convoy_arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg18a",
				},
				{
					["message"] = "dlg18b",
				},
				{
					["message"] = "dlg18c",
				},
				{
					["message"] = "dlg18d",
				},
			},
		},
		["convoy_hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19b",
				},
			},
		},
		["convoy_critical"] = {
			["sequence"] = {
				{
					["message"] = "dlg20",
				},
			},
		},
		["convoy_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg21",
				},
			},
		},
		["convoy_success"] = {
			["sequence"] = {
				{
					["message"] = "dlg22a",
				},
				{
					["message"] = "dlg22b",
				},
			},
		},
		["kamikaze_japan"] = {
			["sequence"] = {
				{
					["message"] = "dlg23a",
				},
				{
					["message"] = "dlg23b",
				},
			},
		},
		["fleet_japan"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
			},
		},
		["yamato_japan"] = {
			["sequence"] = {
				{
					["message"] = "dlg25",
				},
				{
					["message"] = "dlg26",
				},
			},
		},
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
    SetDeviceReloadTimeMul(0)
    luaInitNewSystems()

    SetThink(this, "US14Think")

	--reconcheat
	SetSimplifiedReconMultiplier(1.0)
	
	--reload
	SetDeviceReloadEnabled(true)
	
	--Init Functions
	SetSelectedUnit(Mission.usBB)
	Blackout(false, "", 1)
	EnableMessages(true)
	
	--if Scoring_IsUnlocked("US11_GOLD") then
		luaUS14UnlockAlabama()
	--end 
	--if Scoring_IsUnlocked("US13_GOLD") then
		luaUS14UnlockLSM()
	--end
	--Difficulty settings
	if Mission.Difficulty == 0 then
		Mission.YamatoSkill = SKILL_SPVETERAN
	elseif Mission.Difficulty == 1 then
		Mission.YamatoSkill = SKILL_SPVETERAN
	elseif Mission.Difficulty == 2 then
		Mission.YamatoSkill = SKILL_ELITE
	end
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS14CpLoadMissionData,luaUS14CpRelocateUnits},
		[2] = {luaUS14CpLoadMissionData,luaUS14CpRelocateUnits},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS14SaveMissionData},
		[2] = {luaUS14SaveMissionData},
	}
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == true then
		luaUS14PhaseManager()
	else
		Blackout(false,"",1.5)
		--powerup init
		AddPowerup({
				["classID"] = "targeting_computer",
				["useLimit"]	 = 2,
				})
		AddPowerup({
				["classID"] = "improved_repair_team",
				["useLimit"]	 = 2,
				})
	end

end

function US14Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")
	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	--luaCheckMusic()
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF    		luaLog(this.Name.." mission is terminated!")
		return
	end
	
	-- Dead unitok kitakaritasa
	Mission.PlayerShips = luaRemoveDeadsFromTable(Mission.PlayerShips)
	Mission.usTroopTransports = luaRemoveDeadsFromTable(Mission.usTroopTransports)
	Mission.japPlanes = luaRemoveDeadsFromTable(Mission.japPlanes)
	Mission.NorthAttackers = luaRemoveDeadsFromTable(Mission.NorthAttackers)
	Mission.CenterAttackers = luaRemoveDeadsFromTable(Mission.CenterAttackers)
	Mission.SouthAttackers = luaRemoveDeadsFromTable(Mission.SouthAttackers)
	Mission.usFighters = luaRemoveDeadsFromTable(Mission.usFighters)
	Mission.usBombers = luaRemoveDeadsFromTable(Mission.usBombers)
	
	luaUS14CheckConditions(this)
			
-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)

-- MissionPhase 1
	if this.MissionPhase == 1 then
		--Kezdeti cap felkuldese
		local slotIndex = LaunchSquadron(Mission.usCV,26,3)
		local launchedAvenger = thisTable[tostring(GetProperty(Mission.usCV, "slots")[slotIndex].squadron)]
		PilotMoveTo(launchedAvenger, Mission.usCV)
		
		-- Kezdeti player formaciok
		JoinFormation(FindEntity("Fletcher-class 01"),Mission.usCA)
		JoinFormation(FindEntity("Fletcher-class 04"),Mission.usCA)
		JoinFormation(Mission.usCV, Mission.usCA)
		
		JoinFormation(FindEntity("Fletcher-class 02"),Mission.usBB)
		JoinFormation(FindEntity("Fletcher-class 03"),Mission.usBB)
		--JoinFormation(FindEntity("Fletcher-class 05"),Mission.usBB)
		
		--JoinFormation(FindEntity("USTroopTransport 01"),FindEntity("USTroopTransport 04"))
		JoinFormation(FindEntity("USTroopTransport 02"),FindEntity("USTroopTransport 04"))
		JoinFormation(FindEntity("USTroopTransport 03"),FindEntity("USTroopTransport 04"))
		
		--JoinFormation(FindEntity("USTroopTransport 05"),FindEntity("USTroopTransport 08"))
		JoinFormation(FindEntity("USTroopTransport 06"),FindEntity("USTroopTransport 08"))
		JoinFormation(FindEntity("USTroopTransport 07"),FindEntity("USTroopTransport 08"))
		JoinFormation(FindEntity("Landing Ship, Medium - Rocket 01"),FindEntity("USTroopTransport 08"))
			
		-- Jap DD-k indulnak
		if random(1, 2) == 1 then
			JoinFormation(Mission.japDD2, Mission.japDD1)
			NavigatorAttackMove(Mission.japDD1, Mission.usCV, {})
			
		else
			PutRelTo(Mission.japDD1, Mission.Nav_japDD,{["x"]=-30,["y"]=0,["z"]=20},45)
			PutRelTo(Mission.japDD2, Mission.Nav_japDD,{["x"]=-30,["y"]=0,["z"]=-20},45)
						
			JoinFormation(Mission.japDD2, Mission.japDD1)
			NavigatorAttackMove(Mission.japDD1, Mission.usBB, {})
			
		end
		
		PilotMoveTo(Mission.japJudy, Mission.usCV)
		
		Mission.ShipTable = luaGetOwnUnits("ship", PARTY_ALLIED)
		
		AddListener("hit", "listenerKamikazeHit", {
					["callback"] = "luaUS14KamikazeHit", -- callback fuggveny
					["target"] = Mission.ShipTable, -- entityk akiken a listener aktiv
					["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
					["attacker"] = {}, -- tamado entityk
					["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
					["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
					["damageCaused"] = {["1000"] = minValue, [""] = maxValue}, -- ket ertek kozotti sebzes szures
					["fireCaused"] = {[""] = minValue, [""] = maxValue}, -- ket ertek kozotti tuzsebzes szures
					["leakCaused"] = {[""] = minValue, [""] = maxValue}, -- ket ertek kozotti viz damage szures
					})
		
		AddListener("kill", "listenerShipKilled", {
					["callback"] = "luaUS14ShipKilled",
					["entity"] = Mission.PlayerShips,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
						
		--HQ sebzodes listener -> partraszallas figyeles megkezdodik
		AddListener("hpEvent", "ListenerHQdamage1" , {
				["callback"] = "luaUS14HQDamaged1",
				["entity"]   = Mission.HQs,
				["reason"]   = {"damage"},
				["hp"]       = 0.95,
				})
		
		AddDamage(FindEntity("Hangar, Large, 01 06"),10000)
		AddDamage(FindEntity("Hangar, Small, 01 19"),10000)
		AddDamage(FindEntity("Hangar, Medium, 03 04"),10000)
		AddDamage(FindEntity("Hangar, Small, 01 04"),10000)
		AddDamage(FindEntity("Hangar, Large, 06 05"),10000)
		AddDamage(FindEntity("Storage, 04 02"),10000)
		
		Mission.MissionPhase = 2

	elseif this.MissionPhase == 2 and this.FirstRun then
		Mission.FirstRun = false
		Mission.Phase2ThinkCounter = 0
	end
end

function luaUS14CheckConditions()
	if Mission.MissionPhase == 2 and not Mission.FirstRun then
		Mission.Phase2ThinkCounter = Mission.Phase2ThinkCounter + 1
		if Mission.Phase2ThinkCounter == 1 then
			luaStartDialog("capture_objective")
		end
		
		if Mission.Phase2ThinkCounter == 4 then
			luaObj_Add("primary", 1, Mission.HQs)
			Mission.ObjRemindTime = 10
			--luaObj_AddReminder("primary", 1, 2)
			Mission.Primary1Complete = false
		end
		
		if Mission.Phase2ThinkCounter == 6 then
			luaStartDialog("easter")
		end
		
		if Mission.Phase2ThinkCounter == 14 then
			luaStartDialog("kamikaze_incoming")
		end
		if Mission.Phase2ThinkCounter > 2 then
			--luaObj_Reminder()
		end
	
	if Mission.Primary1Complete and Mission.Primary2Complete then
		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary",1) == nil then
			luaObj_Completed("secondary",1)
		end
		luaMissionCompletedNew(Mission.CenterHQ, "usn14.obj_p1_success", "us_outro.bik", nil, true)
	 	Mission.EndMission = true
		end
	end
-- HQs check
	Mission.alliedHQs = {}
	Mission.japHQs = {}
	for idx,hq in pairs(Mission.HQs) do
		if hq.Party == PARTY_ALLIED then
			table.insert(Mission.alliedHQs, hq)
			if hq.CapturedFlag == false then
				hq.CapturedFlag = true
				if not Mission.HQMovieRunning then
					if GetSelectedUnit() ~= nil and not GetSelectedUnit().Dead then
						Mission.LastSelected = GetSelectedUnit()
						SetInvincible(Mission.LastSelected,true)
					end
					luaUS14EM_HQ_1(hq)
				end
			end
		else
			table.insert(Mission.japHQs, hq)	
		end
	end
	--luaLog("Japan HQk szama: "..table.getn(Mission.japHQs))
	--luaLog("Allied HQk szama: "..table.getn(Mission.alliedHQs))
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil and Mission.Phase2ThinkCounter > 4 then
		DisplayScores(1,0,"usn14.obj_p1_display", table.getn(Mission.alliedHQs).." / "..table.getn(Mission.HQs))
	end
	if table.getn(Mission.HQs) == table.getn(Mission.alliedHQs) then
		Mission.Primary1Complete = true
		luaObj_Completed("primary",1)
	end
	if table.getn(Mission.japHQs) == 2 and not Mission.FirstCaptured then
		Mission.FirstCaptured = true
		Mission.CheckpointHQ = Mission.alliedHQs[1]
		luaStartDialog("landing_ongoing")
		ForceRecon()
		--luaCheckpoint(1,nil)
		
-- RELEASE_LOGOFF    		luaLog("Capture detected, starting counteattack!")
		Mission.FirstCounterAttackTime = math.floor(GameTime())
		
		--MissionNarrative("New powerup available!")
		AddPowerup({
				["classID"] = "fierce_assault",
				["useLimit"]	 = 1,
				})
		
		luaUS14Counterattack()
		
	elseif table.getn(Mission.japHQs) == 1 and not Mission.SecondCaptured then
		Mission.SecondCaptured = true
		Mission.CheckpointHQ = Mission.alliedHQs[2]
		ForceRecon()
		--luaCheckpoint(2,nil)
		
-- RELEASE_LOGOFF    		luaLog("Capture detected, starting counteattack!")
  		AddPowerup({
				["classID"] = "improved_shells",
				["useLimit"]	 = 1,
				})
		if math.floor(GameTime()) - Mission.FirstCounterAttackTime < 120 then
			luaDelay(luaUS14Counterattack, 60)
		else
			luaUS14Counterattack()
		end
	end

	--PlayerShips number check
	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerShips)) < 5 and not Mission.ShipNumberWarning then
		Mission.ShipNumberWarning = true
		luaStartDialog("ships_lost")
	elseif table.getn(luaRemoveDeadsFromTable(Mission.PlayerShips)) < 7 and not Mission.ShipScatterHint then
		Mission.ShipScatterHint = true
		ShowHint("USN14_Hint_Together")
	end
	
	--Transport ship number check
	if table.getn(luaRemoveDeadsFromTable(Mission.usTroopTransports)) < 4 and not Mission.ReinforcementTriggered then
		Mission.ReinforcementTriggered = true
		luaUS14ReinforcementStart()
	elseif table.getn(luaRemoveDeadsFromTable(Mission.usTroopTransports)) < 6 and not Mission.TransportsHint then
		Mission.TransportsHint = ture
		ShowHint("USN14_Hint_Transports")
	end
	
	luaUS14NorthAreaCheck()
	luaUS14CenterAreaCheck()
	luaUS14SouthAreaCheck()
	luaUS14AttackManager()
	luaUS14AirforceCheck()
	if not luaObj_IsActive("primary",2) then
		luaUS14YamatoTimer()
	end
	luaUS14ConvoyTimer()
	if Mission.YamatoKilled == 0 then
		luaUS14YamatoShoreCheck()
	end
	
end

function luaUS14HQDamaged1()
	if IsListenerActive("hpEvent", "ListenerHQdamage1") then
		RemoveListener("hpEvent", "ListenerHQdamage1")
	end
	luaUS14CaptureCheck()
	
end

function luaUS14CaptureCheck()
	if Mission.EndMission then
		return
	else
		for idx,unit in pairs(Mission.HQs) do
			if GetCapturePercentage(unit) > 0 then
				Mission.LandingStarted = true
				luaStartDialog("landing_succcess")
				return
			end
		end
		if not Mission.LandingStarted then
			luaDelay(luaUS14CaptureCheck,5)
		end
	end
end

function luaUS14Airfield1()
-- RELEASE_LOGOFF    	luaLog("luaUS14Airfield1 called!")
	local Airfield = Mission.Airfield1
	
	if not Airfield.Dead and Airfield.Party == PARTY_JAPANESE then
		local FighterCLIDs = {
			[1] = 150, --Zero
			[2] = 45, -- Kamikaze Zero
		}
		local OtherCLIDs = {
			[1] = 162, --Kate
			[2]	= 159, --Judy
		}
				
		--fleet targeting
		local random = luaRnd(1,4)
		
		if (table.getn(Mission.usTroopTransports) > 0) and (random < 3) then
			local LowestTransportDistance = luaGetDistance(Airfield, Mission.usTroopTransports[1])
			local NearestTransport = Mission.usTroopTransports[1]
			
			for idx,transport in pairs (Mission.usTroopTransports) do
				local distance = luaGetDistance(Airfield, transport)
				if distance < LowestTransportDistance then
					local LowestTransportDistance = distance
					local NearestTransport = transport		
				end
			end
-- RELEASE_LOGOFF    			luaLog("Legkozelebbi transport:  "..NearestTransport.Name.."  -   "..LowestTransportDistance)
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, {NearestTransport})
		
		elseif table.getn(Mission.PlayerShips) > 0 then
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, Mission.PlayerShips)
		else
-- RELEASE_LOGOFF    			luaLog("elvileg game over mert elfogytak a transportok es a hajok is!")
		end
	elseif Airfield.Party ~= PARTY_JAPANESE and not Mission.CapturedAirfield1 then
		Mission.CapturedAirfield1 = true
		RemoveAllAirBasePlanes(Airfield)
-- RELEASE_LOGOFF    		luaLog("Airbase 1 slots cleared")
	end
end

function luaUS14Airfield2()
-- RELEASE_LOGOFF    	luaLog("luaUS14Airfield2 called!")
	local Airfield = Mission.Airfield2
	if not Airfield.Dead and Airfield.Party == PARTY_JAPANESE then
		local FighterCLIDs = {
			[1] = 150,	--Zero
		}
		local OtherCLIDs = {
			[1] = 45, --Kamikaze Zero
			[2]	= 159, --Judy
		}
		
		--nearest transport
		local random = luaRnd(1,4)
		if (table.getn(Mission.usTroopTransports) > 0) and (random < 3) then
			local LowestTransportDistance = luaGetDistance(Airfield, Mission.usTroopTransports[1])
			local NearestTransport = Mission.usTroopTransports[1]

			for idx,transport in pairs (Mission.usTroopTransports) do
				local distance = luaGetDistance(Airfield, transport)
				if distance < LowestTransportDistance then
					local LowestTransportDistance = distance
					local NearestTransport = transport
				end
			end
-- RELEASE_LOGOFF    			luaLog("Legkozelebbi transport:  "..NearestTransport.Name.."  -   "..LowestTransportDistance)
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, {NearestTransport})
			
		elseif table.getn(Mission.PlayerShips) > 0 then
			luaAirfieldManager(Airfield, FighterCLIDs, OtherCLIDs, Mission.PlayerShips)
		end
	elseif Airfield.Party ~= PARTY_JAPANESE and not Mission.CapturedAirfield2 then
		Mission.CapturedAirfield2 = true
		RemoveAllAirBasePlanes(Airfield)
-- RELEASE_LOGOFF    		luaLog("Airbase 2 slots cleared")
	end
end

function luaUS14NorthAreaCheck()
	if Mission.NorthHQ.Party == PARTY_JAPANESE then
		local power = 0
		local area = Mission.AreaNorth
		local ships = luaGetShipsAroundCoordinate(GetPosition(area), 2500, PARTY_ALLIED, "own", nil, nil, nil)
		if ships ~= nil then
			Mission.NorthAttackers = ships
			for idx,unit in pairs(Mission.NorthAttackers) do
				if unit.Type == "LANDINGSHIP" then
					luaRemoveByName(Mission.NorthAttackers, unit.Name)
				elseif unit.Type == "CARGO" then
					power = power + 2
				else
					power = power + 1
				end
			end
-- RELEASE_LOGOFF    			luaLog("NorthAttackers szama: "..table.getn(Mission.NorthAttackers))
			if not Mission.HangarWarningDone then
				Mission.HangarWarningDone = true
				ShowHint("USN14_Hint_Hangars")
			end
		end
		Mission.NorthPower = power
-- RELEASE_LOGOFF    		luaLog("NorthPower :"..Mission.NorthPower)
	else
		Mission.NorthPower = 0
-- RELEASE_LOGOFF    		luaLog("NorthPower : zero, mert nem el a bazis")
	end
end

function luaUS14CenterAreaCheck()	
	if Mission.CenterHQ.Party == PARTY_JAPANESE then
		local power = 0
		local area = Mission.AreaCenter
		local ships = luaGetShipsAroundCoordinate(GetPosition(area), 2000, PARTY_ALLIED, "own", nil, nil, nil)
		if ships ~= nil then
			Mission.CenterAttackers = ships
			for idx,unit in pairs(Mission.CenterAttackers) do
				if unit.Type == "LANDINGSHIP" then
					luaRemoveByName(Mission.CenterAttackers, unit.Name)
				elseif unit.Type == "CARGO" then
					power = power + 2
				else
					power = power + 1
				end
			end
-- RELEASE_LOGOFF    			luaLog("CenterAttackers szama: "..table.getn(Mission.CenterAttackers))
			if not Mission.HangarWarningDone then
				Mission.HangarWarningDone = true
				ShowHint("USN14_Hint_Hangars")
			end
		end
		Mission.CenterPower = power
-- RELEASE_LOGOFF    		luaLog("CenterPower :"..Mission.CenterPower)
	else
		Mission.CenterPower = 0
-- RELEASE_LOGOFF    		luaLog("CenterPower : zero, mert nem el a bazis")
	end
end

function luaUS14SouthAreaCheck()	
	if Mission.SouthHQ.Party == PARTY_JAPANESE then
		local power = 0
		local area = Mission.AreaSouth
		local ships = luaGetShipsAroundCoordinate(GetPosition(area), 2200, PARTY_ALLIED, "own", nil, nil, nil)
		if ships ~= nil then
			Mission.SouthAttackers = ships
			for idx,unit in pairs(Mission.SouthAttackers) do
				if unit.Type == "LANDINGSHIP" then
					luaRemoveByName(Mission.SouthAttackers, unit.Name)
				elseif unit.Type == "CARGO" then
					power = power + 2
				else
					power = power + 1
				end
			end
-- RELEASE_LOGOFF    			luaLog("SouthAttackers szama: "..table.getn(Mission.SouthAttackers))
			if not Mission.HangarWarningDone then
				Mission.HangarWarningDone = true
				ShowHint("USN14_Hint_Hangars")
			end
		end
		Mission.SouthPower = power
-- RELEASE_LOGOFF    		luaLog("SouthPower :"..Mission.SouthPower)
	else
		Mission.SouthPower = 0
-- RELEASE_LOGOFF    		luaLog("SouthPower : zero, mert nem el a bazis")
	end	
end

function luaUS14AttackManager()
-- RELEASE_LOGOFF    	luaLog("luaUS14AttackManager called!")
	--default MainTargetShip
	if table.getn(Mission.PlayerShips) > table.getn(Mission.usTroopTransports) then
		Mission.MainTargetShip = luaPickRnd(Mission.PlayerShips)
	else
		Mission.MainTargetShip = luaPickRnd(Mission.usTroopTransports)
	end
	
	--spawned planes target check
	for idx,unit in pairs(Mission.japPlanes) do
		if not unit.Dead and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) and GetProperty(unit,"ammoType") ~= 0 and not unit.retreating then
			if table.getn(Mission.PlayerShips) ~= 0 then
				local trg = luaPickRnd(Mission.PlayerShips)
				luaSetScriptTarget(unit, trg)
				PilotSetTarget(unit, trg)
			elseif table.getn(Mission.usTroopTransports) ~= 0 then
				local trg = luaPickRnd(Mission.usTroopTransports)
				luaSetScriptTarget(unit, trg)
				PilotSetTarget(unit, trg)
			end
		end
	end	
	
	
	--Area powers check
	if Mission.NorthPower + Mission.CenterPower + Mission.SouthPower > 0 then
		--Attackers near!
		local HighestThreat = 0
		if Mission.NorthPower > HighestThreat then
			local HighestThreat = Mission.NorthPower
			Mission.MainTargetShip = luaPickRnd(Mission.NorthAttackers)
-- RELEASE_LOGOFF    			luaLog("North a threat!")
		end
		if Mission.CenterPower > HighestThreat then
			local HighestThreat = Mission.CenterPower
			Mission.MainTargetShip = luaPickRnd(Mission.CenterAttackers)
-- RELEASE_LOGOFF    			luaLog("Center a threat!")
		end
		if Mission.SouthPower > HighestThreat then
			local HighestThreat = Mission.SouthPower
			Mission.MainTargetShip = luaPickRnd(Mission.SouthAttackers)
-- RELEASE_LOGOFF    			luaLog("South a threat!")
		end
-- RELEASE_LOGOFF    		luaLog("MainTargetShip aktualisan: "..Mission.MainTargetShip.Name)
	end
		
	if Mission.CycleTime == -1 then
		--First run -> swarm phase
		Mission.CycleTime = math.floor(GameTime())
		Mission.Phase = "swarm"
	elseif Mission.Phase == "swarm" then
		if Mission.CycleTime + (Mission.SwarmTime * 60) < math.floor(GameTime()) then
			--switching to peace phase
			Mission.Phase = "peace"
			Mission.CycleTime = math.floor(GameTime())
			luaDelay(luaUS14PeaceWarning,20)
		else
			--running the attack coordinators
			luaUS14Airfield1()
			luaUS14Airfield2()
			luaUS14Shipyard()
			luaUS14japLevelbomberCheck()
		end
	elseif Mission.Phase == "peace" then
		if Mission.CycleTime + (Mission.PeaceTime * 60) < math.floor(GameTime()) then
			--switching to swarm phase
			Mission.Phase = "swarm"
			Mission.CycleTime = math.floor(GameTime())
			luaDelay(luaUS14SwarmWarning,20)
		end
	end		
end		

function luaUS14japLevelbomberCheck()
	if table.getn(Mission.japPlanes) < 2 then
		if math.floor(GameTime()) - Mission.LastJapPlaneSpawned > (Mission.JapPlaneSpawnInterval + luaRnd(5, 25)) then
		--New attack plane Spawn needed
		luaUS14japLevelbomberSpawn()
		Mission.LastJapPlaneSpawned = math.floor(GameTime())
		end
	end
end

function luaUS14japLevelbomberSpawn()
	local spawnpos = GetPosition(luaPickRnd(Mission.japPlaneSpawnPoints))
	Mission.planeTypes={
						32,--Betty Okhaval
						}
	if not Mission.FirstCaptured and not Mission.SecondCaptured then
		--egyik HQ sincs meg elfoglalva
		Mission.planeTypes={
							167,--Betty
							}
	elseif Mission.FirstCaptured and not Mission.SecondCaptured then
		--egy HQ mar el van foglalva
		Mission.planeTypes={
							167,--Betty
							32,--Betty Okhaval
							}
	elseif Mission.Firstcaptured and Mission.SecondCaptured then
		--ket HQ elfoglalva
		Mission.planeTypes={
							167,--Betty
							32,--Betty Okhaval
							}
	end
	
	local spawnType = luaPickRnd(Mission.planeTypes)
	if spawnType == 32 then
		Mission.Equipment = 1
	else
		Mission.Equipment =2
	end
	
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = spawnType,
				["Name"] = "lokaszt",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = JAPAN,
				["WingCount"] = 1,
				["Equipment"] = Mission.Equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { -1,1 },
			["lookAt"] = GetPosition(Mission.AreaCenter)
		},
		["callback"] = "luaUS14japPlaneSpawnCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100,
			
		},
		})
end

function luaUS14japPlaneSpawnCallback(spawnedplane)
	if Mission.EndMission then
-- RELEASE_LOGOFF    		luaLog("Mission in end state...")
		return
	end
	if table.getn(Mission.PlayerShips) ~= 0 then
		local target = luaPickRnd(Mission.PlayerShips)
		PilotSetTarget(spawnedplane, target)
-- RELEASE_LOGOFF    		luaLog(spawnedplane.Name.." spawned and attacking "..target.Name)
		table.insert(Mission.japPlanes, spawnedplane)
	elseif table.getn(Mission.usTroopTransports) ~= 0 then
		local target = luaPickRnd(Mission.usTroopTransports)
		PilotSetTarget(spawnedplane, target)
-- RELEASE_LOGOFF    		luaLog(spawnedplane.Name.." spawned and attacking "..target.Name)
		table.insert(Mission.japPlanes, spawnedplane)
	end		
end

function luaUS14PeaceWarning()
-- RELEASE_LOGOFF    	luaLog("....PEACE WARNING....")
end

function luaUS14SwarmWarning()
-- RELEASE_LOGOFF    	luaLog("....SWARM WARNING....")
end

function luaUS14Shipyard()
-- RELEASE_LOGOFF    	luaLog("luaUS14Shipyard called!")
	local shipyard1 = Mission.Shipyards[1]
	local shipyard2 = Mission.Shipyards[2]
	local shipyard3 = Mission.Shipyards[3]
	
	--Shipyard1
	if shipyard1.Dead or shipyard1.Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF    		luaLog("Shipyard 1 down")
	else
		Mission.Shipyard1Ships = luaRemoveDeadsFromTable(Mission.Shipyard1Ships)
		if table.getn(Mission.Shipyard1Ships) < Mission.ShipyardLimit then
			if (math.floor(GameTime()) - Mission.LastShipyard1Spawned) > (Mission.JapShipSpawnInterval + luaRnd(5,20)) then
				local typeTable = {
					43, --kamikaze boat
					77, --jap pt
					77, --jap pt
				}
				local spawnType = luaPickRnd(typeTable)
				local shipyardNum = 1
				luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF    				luaLog("spawnship called on shipyard1")
				
				Mission.LastShipyard1Spawned = math.floor(GameTime())
			end
		end
	end
	--Shipyard2
	if shipyard2.Dead or shipyard2.Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF    		luaLog("Shipyard 2 down")
	else
		Mission.Shipyard2Ships = luaRemoveDeadsFromTable(Mission.Shipyard2Ships)
		if table.getn(Mission.Shipyard2Ships) < Mission.ShipyardLimit then
			if (math.floor(GameTime()) - Mission.LastShipyard2Spawned) > (Mission.JapShipSpawnInterval + luaRnd(5,20)) then
				local typeTable = {
					43, --kamikaze boat
					77, --jap pt
					77, --jap pt
				}
				local spawnType = luaPickRnd(typeTable)
				local shipyardNum = 2
				luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF    				luaLog("spawnship called on shipyard2")
				
				Mission.LastShipyard2Spawned = math.floor(GameTime())
			end
		end
	end
	--Shipyard3
	if shipyard3.Dead or shipyard3.Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF    		luaLog("Shipyard 3 down")
	else
		Mission.Shipyard3Ships = luaRemoveDeadsFromTable(Mission.Shipyard3Ships)
		if table.getn(Mission.Shipyard3Ships) < Mission.ShipyardLimit then
			if (math.floor(GameTime()) - Mission.LastShipyard3Spawned) > (Mission.JapShipSpawnInterval + luaRnd(5,20)) then
				local typeTable = {
					77, --jap pt
					43, --kamikaze boat
				}
				local spawnType = luaPickRnd(typeTable)
				local shipyardNum = 3
				luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF    				luaLog("spawnship called on shipyard3")
								
				Mission.LastShipyard3Spawned = math.floor(GameTime())
			end
		end
	end
	for idx,unit in pairs(Mission.Shipyard1Ships) do
		if not unit.Dead and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) then
			if table.getn(Mission.PlayerShips) ~= 0 then
				local trg1 = luaPickRnd(Mission.PlayerShips)
-- RELEASE_LOGOFF    				luaLog("Shipyard1 ship uj target: "..unit.Name..">>>>>>> "..trg1.Name)
				luaSetScriptTarget(unit, trg1)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg1, {})
			elseif table.getn(Mission.usTroopTransports) ~= 0 then
				local trg1 = luaPickRnd(Mission.usTroopTransports)
-- RELEASE_LOGOFF    				luaLog("Shipyard1 ship uj target: "..unit.Name..">>>>>>> "..trg1.Name)
				luaSetScriptTarget(unit, trg1)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg1, {})
			end
			
			
		end
	end	
	for idx,unit in pairs(Mission.Shipyard2Ships) do
		if not unit.Dead and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) then
			if table.getn(Mission.PlayerShips) ~= 0 then
				local trg2 = luaPickRnd(Mission.PlayerShips)
-- RELEASE_LOGOFF    				luaLog("Shipyard2 ship uj target: "..unit.Name..">>>>>>> "..trg2.Name)
				luaSetScriptTarget(unit, trg2)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg2, {})
			elseif table.getn(Mission.usTroopTransports) ~= 0 then
				local trg2 = luaPickRnd(Mission.usTroopTransports)
-- RELEASE_LOGOFF    				luaLog("Shipyard2 ship uj target: "..unit.Name..">>>>>>> "..trg2.Name)
				luaSetScriptTarget(unit, trg2)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg2, {})
			end
		end
	end	
	for idx,unit in pairs(Mission.Shipyard3Ships) do
		if not unit.Dead and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) then
			if table.getn(Mission.PlayerShips) ~= 0 then
				local trg3 = luaPickRnd(Mission.PlayerShips)
-- RELEASE_LOGOFF    				luaLog("Shipyard3 ship uj target: "..unit.Name..">>>>>>> "..trg3.Name)
				luaSetScriptTarget(unit, trg3)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg3, {})
			elseif table.getn(Mission.usTroopTransports) ~= 0 then
				local trg3 = luaPickRnd(Mission.usTroopTransports)
-- RELEASE_LOGOFF    				luaLog("Shipyard3 ship uj target: "..unit.Name..">>>>>>> "..trg3.Name)
				luaSetScriptTarget(unit, trg3)
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg3, {})
			end
		end
	end		
	
end

function luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF    	luaLog("shipyard "..shipyardNum.."spawnstart")	
	local callbacks = {"luaUS14Shipyard1Callback", "luaUS14Shipyard2Callback", "luaUS14Shipyard3Callback"}

	local grpTbl = {
		{
			["Type"] = spawnType,
			["Name"] = "sit",
			["Skill"] = SKILL_SPVETERAN,
			["Race"] = JAPAN,
		},
	}
	
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = GetPosition(Mission.Shipyards[shipyardNum].Spawnpos),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.NavPTLookat)
	},
	["callback"] = callbacks[shipyardNum],
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100,
	},
	})
	--luaLog("!!!!!!!!!!!!!SPAN POZICIO :  ")
	--luaLog(GetPosition(Mission.Shipyards[shipyardNum].Spawnpos))	
  	--luaLog("shipyard "..shipyardNum.."spawnend")
end

function luaUS14Shipyard1Callback(ship)
	if Mission.EndMission then
-- RELEASE_LOGOFF    		luaLog("Mission in end state...")
		return
	end
-- RELEASE_LOGOFF    	luaLog("spawn1 callback hivodott")
  	--SetSelectedUnit(ship)
  	--luaLog("!!!!!!!!!!!!!SINYO1 POZICIO :  ")
  	--luaLog(GetPosition(GetSelectedUnit()))
	table.insert(Mission.Shipyard1Ships,ship)
	if Mission.MainTargetShip == nil or Mission.MainTargetShip.Dead then
-- RELEASE_LOGOFF    		luaLog("Maintarget nil vagy dead!!")
		Mission.MainTargetShip = luaPickRnd(Mission.PlayerShips)
	end
	luaSetScriptTarget(ship, Mission.MainTargetShip)
	TorpedoEnable(ship, true)
	NavigatorAttackMove(ship, Mission.MainTargetShip,{})
end

function luaUS14Shipyard2Callback(ship)
	if Mission.EndMission then
-- RELEASE_LOGOFF    		luaLog("Mission in end state...")
		return
	end
-- RELEASE_LOGOFF    	luaLog("spawn2 callback hivodott")
  	--SetSelectedUnit(ship)
  	--luaLog("!!!!!!!!!!!!!SINYO2 POZICIO :  ")
  	--luaLog(GetPosition(GetSelectedUnit()))
  	table.insert(Mission.Shipyard2Ships,ship)
	if Mission.MainTargetShip == nil or Mission.MainTargetShip.Dead then
-- RELEASE_LOGOFF    		luaLog("Maintarget nil vagy dead!!")
		Mission.MainTargetShip = luaPickRnd(Mission.PlayerShips)
	end
	luaSetScriptTarget(ship, Mission.MainTargetShip)
	TorpedoEnable(ship, true)
	NavigatorAttackMove(ship, Mission.MainTargetShip,{})
end

function luaUS14Shipyard3Callback(ship)
	if Mission.EndMission then
-- RELEASE_LOGOFF    		luaLog("Mission in end state...")
		return
	end
-- RELEASE_LOGOFF    	luaLog("spawn3 callback hivodott")
  	--SetSelectedUnit(ship)
  	--luaLog("!!!!!!!!!!!!!SINYO3 POZICIO :  ")
  	--luaLog(GetPosition(GetSelectedUnit()))
	table.insert(Mission.Shipyard3Ships,ship)
	if Mission.MainTargetShip == nil or Mission.MainTargetShip.Dead then
-- RELEASE_LOGOFF    		luaLog("Maintarget nil vagy dead!!")
		Mission.MainTargetShip = luaPickRnd(Mission.PlayerShips)
	end
	luaSetScriptTarget(ship, Mission.MainTargetShip)
	TorpedoEnable(ship, true)
	NavigatorAttackMove(ship, Mission.MainTargetShip,{})
end

function luaUS14Counterattack()
-- RELEASE_LOGOFF    	luaLog("counterattack meghivodott!")
	--lehetseges counterattackok foglalas eseten
	local randomAttack = luaRnd(1,1)
	local classTable = {
				73, --fubuki
				73,
				73,
				73,
				}
	local shipNames = {
				"ingame.shipnames_uranami",
				"ingame.shipnames_usugumo",
				"ingame.shipnames_akebono",
				"ingame.shipnames_yugiri",	
				}
	
	if randomAttack == 1 then
	-- 2 hajo spawnol random poziciokra
		for i=1,2 do
			local randomNum = luaRnd(1,table.getn(classTable))
			local shipType = classTable[randomNum]
			local shipName = shipNames[randomNum]
			--luaLog("counter shiptype: "..shipType)
			local shipSpawnPos = luaRnd(1,3)
			
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = shipType,
						["Name"] = "sefsef",
						["Skill"] = SKILL_SPNORMAL,
						["Race"] = JAPAN,
						["GuiName"] = shipName,
					},
				},
				["area"] = {
					["refPos"] = GetPosition(Mission.japShipSpawnPoints[shipSpawnPos]),
					["angleRange"] = { -1,1},
					["lookAt"] = GetPosition(Mission.AreaCenter)

				},
				["callback"] = "luaUS14CounterShipSpawned",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 200,
				},
				})
		end
	elseif randomAttack == 2 then
	--Okha attack
		local okhaSpawnPos = luaRnd(1,5)
		for i=1,2 do
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 32,
						["Name"] = "werwer",
						["Skill"] = SKILL_SPVETERAN,
						["Race"] = JAPAN,
						["WingCount"] = 1,
						["Equipment"] = 1,
					},
				},
				["area"] = {
					["refPos"] = GetPosition(Mission.japPlaneSpawnPoints[okhaSpawnPos]),
					["angleRange"] = {-1,1},
					["lookAt"] = GetPosition(Mission.AreaCenter)

				},
				["callback"] = "luaUS14CounterOkhaSpawned",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 200,
				},
				})
		end
	else
		
	end	
end

function luaUS14CounterShipSpawned(ship)
	TorpedoEnable(ship, true)
	UnitSetFireStance(ship, 2)
	local targetBase = luaPickRnd(Mission.alliedHQs)
	NavigatorMoveToPos(ship, targetBase.AreaPos)
	
end

function luaUS14CounterOkhaSpawned(betty)
	if table.getn(Mission.usTroopTransports) > 0 then
		local LowestTransportDistance = luaGetDistance(betty, Mission.usTroopTransports[1])
		local NearestTransport = Mission.usTroopTransports[1]
		
		for idx,transport in pairs (Mission.usTroopTransports) do
			local distance = luaGetDistance(betty, transport)
			if distance < LowestTransportDistance then
				local LowestTransportDistance = distance
				local NearestTransport = transport		
			end
		end
		
		luaSetScriptTarget(betty, NearestTransport)
		PilotSetTarget(betty, NearestTransport)
	
	elseif table.getn(Mission.PlayerShips) > 0 then
		local targetShip = luaPickRnd(Mission.PlayerShips)
		luaSetScriptTarget(betty, targetShip)
		PilotSetTarget(betty, targetShip)
	end
end

function luaUS14AirforceCheck()
-- RELEASE_LOGOFF    	luaLog("luaUS14AirforceCheck called!")
	--us airforce check
	if not Mission.usCV.Dead then
		Mission.usFighters = {}
		Mission.usBombers = {}
		
		local activeSquads, planeEntTable = luaGetSlotsAndSquads(Mission.usCV)
		if planeEntTable ~= nil then
			for idx,unit in pairs(planeEntTable) do
				if unit.Class.Type == "Fighter" and not unit.Dead and GetProperty(unit, "unitcommand") ~= "land" then
					table.insert(Mission.usFighters, unit)
				elseif unit.Class.Type == "DiveBomber" and not unit.Dead and GetProperty(unit, "unitcommand") ~= "land" then
					table.insert(Mission.usBombers, unit)
				end
			end
		end 
	end
	
	--japanese fighter airforce check
	Mission.japFighters = {}
	Mission.japKamikazes = {}
	local activeSquads1, planeEntTable1 = luaGetSlotsAndSquads(Mission.Airfield1)
	if planeEntTable1 ~= nil then
		for idx,unit in pairs(planeEntTable1) do
			if unit.Party == PARTY_JAPANESE and unit.Class.Type == "Fighter" then
				table.insert(Mission.japFighters, unit)
			elseif unit.Party == PARTY_JAPANESE and unit.Class.Type == "Kamikaze" then
				table.insert(Mission.japKamikazes, unit)
			end
		end
	end
	local activeSquads2, planeEntTable2 = luaGetSlotsAndSquads(Mission.Airfield2)
	if planeEntTable2 ~= nil then
		for idx,unit in pairs(planeEntTable2) do
			if unit.Party == PARTY_JAPANESE and unit.Class.Type == "Fighter" then
				table.insert(Mission.japFighters, unit)
			elseif unit.Party == PARTY_JAPANESE and unit.Class.Type == "Kamikaze" then
				table.insert(Mission.japKamikazes, unit)
			end
		end
	end
	
	--assign targets and patrol points
	for idx,unit in pairs(Mission.japFighters) do
		if not unit.Dead and (not UnitGetAttackTarget(unit) or UnitGetAttackTarget(unit).Dead) then
			if not unit.patroling and table.getn(Mission.usBombers) ~= 0 then
				--nincs targetje es nem patrolozik es van ellenseges bomber
				if luaGetDistance(unit, Mission.usBombers[1]) < 7000 then
					luaSetScriptTarget(unit, Mission.usBombers[1])
					PilotSetTarget(unit, Mission.usBombers[1])
					unit.patroling = false
				else
					if table.getn(Mission.japHQs) ~= 0 then
						local targethq = luaPickRnd(Mission.japHQs)
						PilotMoveToRange(unit, targethq, 1000)		
						unit.patroling = true
					else
						local targetship = luaPickRnd(Mission.usTroopTransports)
						PilotSetTarget(unit, targetship)
					end
				end
			elseif unit.patroling and table.getn(Mission.usBombers) ~= 0 and luaGetDistance(unit, Mission.usBombers[1]) < 7000 then
				--patrolozik de van ellenseges bombazo
				luaSetScriptTarget(unit, Mission.usBombers[1])
				PilotSetTarget(unit, Mission.usBombers[1])
				unit.patroling = false
			elseif not unit.patroling and table.getn(Mission.usBombers) == 0 then
				--nem patrolozik es nincs ellenseg - most szuletett
				if table.getn(Mission.japHQs) ~= 0 then
					local targethq = luaPickRnd(Mission.japHQs)
					PilotMoveToRange(unit, targethq, 1000)		
					unit.patroling = true
				else
					local targetship = luaPickRnd(Mission.usTroopTransports)
					PilotSetTarget(unit, targetship)
				end
			end
		end
	end
	for idx,unit in pairs(Mission.japKamikazes) do
		if not unit.Dead and (not UnitGetAttackTarget(unit) or UnitGetAttackTarget(unit).Dead) then
			if table.getn(Mission.PlayerShips) > 0 then
				luaSetScriptTarget(unit, luaPickRnd(Mission.PlayerShips))
				PilotSetTarget(unit, luaPickRnd(Mission.PlayerShips))
			elseif table.getn(Mission.usTroopTransports) > 0 then
				luaSetScriptTarget(unit, luaPickRnd(Mission.usTroopTransports))
				PilotSetTarget(unit, luaPickRnd(Mission.usTroopTransports))
			end
		end
	end
end

function luaUS14Yamato()
	if Mission.HQMovieRunning then
		luaDelay(luaUS14Yamato, 3)
		return
	end
	--select the Spawn spot
	local northSpawn = luaGetShipsAroundCoordinate(GetPosition(Mission.YamatoStartPoints[1]), 2000, PARTY_ALLIED, "own", nil, nil, nil)
	local southSpawn = luaGetShipsAroundCoordinate(GetPosition(Mission.YamatoStartPoints[2]), 2000, PARTY_ALLIED, "own", nil, nil, nil)
	
	if northSpawn ~= nil then
		Mission.ShipsNumberforYamato = table.getn(northSpawn)
	else
		Mission.ShipsNumberforYamato = 0
	end
	Mission.YamatoSpawnPos = GetPosition(Mission.YamatoStartPoints[1])
			
	if southSpawn ~= nil and table.getn(southSpawn) < Mission.ShipsNumberforYamato then
		Mission.ShipsNumberforYamato = table.getn(southSpawn)
		Mission.YamatoSpawnPos = GetPosition(Mission.YamatoStartPoints[2])
	end
	
	--Yamato Spawn
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 255,
				["Name"] = "sdfsdfsdf",
				["GuiName"] = "ingame.shipnames_yamato",
				["Skill"] = SKILL_SPVETERAN,
				["Race"] = JAPAN,
			},
		},
		["area"] = {
			["refPos"] = Mission.YamatoSpawnPos,
			["angleRange"] = {-1,1},
			["lookAt"] = GetPosition(Mission.NavYamatoFinish)

		},
		["callback"] = "luaUS14YamatoCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 200,
		},
		})
	--Avenger Spawn torpedoval	
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 113,
				["Name"] = "vaanyad",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = GetPosition(Mission.AvengerSpawnPos),
			["angleRange"] = {-1,1},
			["lookAt"] = GetPosition(Mission.NavYamatoFinish)

		},
		["callback"] = "luaUS14AvengerCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 200,
		},
	})
	
end

function luaUS14YamatoCB(yamato)
	Mission.Yamato = yamato
	SetSkillLevel(Mission.Yamato,Mission.YamatoSkill)
	NavigatorSetAvoidShipCollision(yamato, false)
	NavigatorSetAvoidLandCollision(yamato, false)
	NavigatorMoveToPos(yamato, Mission.NavYamatoFinish)
	local yamatogun = GetGun(Mission.Yamato,2)
	--AddDamage(yamatogun,1000)
	--AddDamage(Mission.Yamato, 1000)
	if GetSelectedUnit() ~= nil and not GetSelectedUnit().Dead then
		Mission.LastSelected = GetSelectedUnit()
		SetInvincible(Mission.LastSelected,true)
	end
	luaUS14EM_Yamato_1()
	luaStartDialog("yamato_detected")
	DisplayUnitHP({Mission.Yamato},"usn14.obj_p2")
	luaObj_Add("hidden",1)
	Mission.Primary2Complete = false
	AddListener("kill", "listenerYamatoKilled", {
				["callback"] = "luaUS14YamatoKilled",
				["entity"] = {Mission.Yamato},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
	Mission.LastDistance = luaGetDistance(Mission.NavYamatoFinish, Mission.Yamato)
	Mission.StartDistance = Mission.LastDistance
	Mission.YamatoShoreFlag = 0
	Mission.YamatoKilled = 0
	luaDelay(luaUS14YamatoHeadingtoShoreDialogue,60)
end

function luaUS14YamatoHeadingtoShoreDialogue()
	if Mission.EndMission then
		return
	else
		luaStartDialog("yamato_closing")
	end
end

function luaUS14AvengerCB(avenger)
	PilotMoveTo(avenger, Mission.Yamato)
end

function luaUS14YamatoTimer()
	if Mission.YamatoTimer ~= 0 and math.floor(GameTime()) > ((Mission.YamatoTimer+luaRnd(0, 4))*60) then
		Mission.YamatoTimer = 0
-- RELEASE_LOGOFF    		luaLog("Yamato phase initiated")
		luaStartDialog("yamato_warning")
		luaDelay(luaUS14Yamato,120)	
	end
end

function luaUS14ConvoyTimer()
	if Mission.ConvoyTimer ~= 0 and math.floor(GameTime()) > ((Mission.ConvoyTimer+luaRnd(0, 5))*60) then
		Mission.ConvoyTimer = 0
-- RELEASE_LOGOFF    		luaLog("Convoy phase initiated")
  		if not luaObj_IsActive("secondary",1) then
			luaUS14ConvoyStart()
		end
	end
	if Mission.ConvoyActive == true then
		--convoy tamadas idonkent
		if math.floor(GameTime()) - Mission.LastConvoyAttackerSpawned > (Mission.ConvoyAttackInterval + luaRnd(0, 20)) then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 150,
						["Name"] = "lokaszt",
						["Skill"] = SKILL_SPNORMAL,
						["Race"] = JAPAN,
						["WingCount"] = luaRnd(2,3),
						["Equipment"] = 0,	
					},
				},
				["area"] = {
					["refPos"] = GetPosition(luaPickRnd(Mission.japConvoyAttackSpawnPoints)),
					["angleRange"] = {-1,1},
					["lookAt"] = GetPosition(Mission.NavConvoyExit)
				},
				["callback"] = "luaUS14ConvoyAttackSpawnCB",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 200,
				},
			})			
			Mission.LastConvoyAttackerSpawned = math.floor(GameTime())
		end
		--DisplayScores(2,0,"usn14.obj_s1","Distance: "..math.floor(luaGetDistance(Mission.SupportConvoy[1],Mission.NavConvoyExit)-500))
	end
end

function luaUS14ConvoyAttackSpawnCB(spawnedzero)
	PilotSetTarget(spawnedzero, Mission.SupportConvoy[1])

end

function luaUS14YamatoKilled()
	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		luaObj_Completed("primary",2)
		Mission.Primary2Complete = true
		Mission.YamatoKilled = 1
		if Mission.YamatoShoreFlag ~= 99 then
			luaStartDialog("yamato_sinked_before")
			luaObj_Completed("hidden",1)
		else
			luaStartDialog("yamato_sinked_after")
		end
	end
	HideUnitHP(0)
	if IsListenerActive("kill", "listenerYamatoKilled") then
		RemoveListener("kill", "listenerYamatoKilled")
	end
end

function luaUS14YamatoShoreCheck()
	if Mission.YamatoKilled == 0 and  Mission.YamatoShoreFlag ~= 99 then
		Mission.ActualDistance = luaGetDistance(Mission.NavYamatoFinish, Mission.Yamato)
		if Mission.ActualDistance * 2 < Mission.StartDistance and not Mission.YamatoHalfway then
			Mission.YamatoHalfway = true
			luaStartDialog("yamato_halfway")
		end
		
		if Mission.ActualDistance < 800 and Mission.YamatoClose then
			Mission.YamatoClose = true
			luaStartDialog("yamato_near")
		end
		if Mission.ActualDistance < 400 then
			if Mission.LastDistance - Mission.ActualDistance < 5 then
				Mission.YamatoShoreFlag = Mission.YamatoShoreFlag + 1
				if Mission.YamatoShoreFlag > 2 then
					--yamato arrived
					Mission.YamatoShoreFlag = 99
					luaObj_Failed("hidden",1)
					luaStartDialog("yamato_beached")
					SetInvincible(Mission.Yamato,false)
					NavigatorStop(Mission.Yamato)
					NavigatorSetTorpedoEvasion(Mission.Yamato, false)
					AddUntouchableUnit(Mission.NorthHQ)	
					AddUntouchableUnit(Mission.Airfield1)
					AddUntouchableUnit(Mission.Airfield2)
				end
			else
				Mission.YamatoShoreFlag = 0
			end
		end
		Mission.LastDistance = Mission.ActualDistance
	end
end

function luaUS14KamikazeHit(target,targetdevice,attacker)
-- RELEASE_LOGOFF    	luaLog("HITLISTENER BEIZZITVA")
	if attacker ~= nil and target ~= nil then
-- RELEASE_LOGOFF    		luaLog(">>>> "..target.Name.."kapott egy pofont "..attacker.Name.." -tol <<<<")
		if (attacker.ClassID == 45 or attacker.ClassID == 46) and not Mission.PlaneWarning then
			Mission.PlaneWarning = true
-- RELEASE_LOGOFF    			luaLog("Kamikaze PLANE hit on "..target.Name.."   by  "..attacker.Name)
			luaStartDialog("kamikaze_hit")
			luaDelay(luaUS14HintKamikaze,12)
		elseif attacker.ClassID == 43 and not Mission.BoatWarning then
			Mission.BoatWarning = true
			luaUS14KamikazeDiaogueJapan()
-- RELEASE_LOGOFF    			luaLog("Kamikaze BOAT hit on "..target.Name.."   by  "..attacker.Name)
		end
		if Mission.PlaneWarning == true and Mission.BoatWarning == true then
			if IsListenerActive("hit", "listenerKamikazePlaneHit") then
				RemoveListener("hit", "listenerKamikazePlaneHit")
-- RELEASE_LOGOFF    				luaLog("Kamikaze listener REMOVED")
			end
		end
	end
end

function luaUS14KamikazeDiaogueJapan()
	if Mission.EndMission then
		return
	else
		if table.getn(GetActDialogIDs()) ~= 0 then
			luaDelay(luaUS14KamikazeDiaogueJapan,3)
		else
			luaStartDialog("kamikaze_japan")
		end
	end
end

function luaUS14ConvoyStart()
	Mission.SupportConvoy = {}
	for idx,unit in pairs(Mission.SupportConvoyTemplates) do
		local generatedShip = GenerateObject(unit.Name)
		SetGuiName(generatedShip, Mission.SupportConvoyNames[idx])
		table.insert(Mission.SupportConvoy,generatedShip)
	end
	NavigatorMoveOnPath(Mission.SupportConvoy[1],Mission.ConvoyPath)
	NavigatorMoveToRange(Mission.SupportConvoy[2], Mission.SupportConvoy[1])
	luaDelay(luaUS14ConvoyMoveManager,20)
	--NavigatorMoveOnPath(Mission.SupportConvoy[2],Mission.ConvoyPath)
	table.insert(Mission.PlayerShips, Mission.SupportConvoy[2])
	SetRoleAvailable(Mission.SupportConvoy[1], EROLF_ALL, PLAYER_AI)
	
	AddListener("kill", "listenerSupplyKill", {
			["callback"] = "luaUS14SupplyKilled",
			["entity"] = {Mission.SupportConvoy[1]},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
			})
	
	AddListener("hpEvent", "ListenerConvoyDamage1" , {	
				["callback"] = "luaUS14ConvoyDamaged1",
				["entity"]   = {Mission.SupportConvoy[1]},
				["reason"]   = {"damage"},
				["hp"]       = 0.9,
				})
				
	AddProximityTrigger(Mission.SupportConvoy[1], "proximityConvoy", "luaUS14ConvoyExited", Mission.NavConvoyExit, 300)
	
	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1)==nil then
		luaObj_AddUnit("secondary",1,Mission.SupportConvoy[1])
	else
		luaStartDialog("convoy_arrived")
		luaObj_Add("secondary", 1, Mission.SupportConvoy[1])
	end
	Mission.ConvoyActive = true
end

function luaUS14ConvoyMoveManager()
	if Mission.EndMission then
		return
	else
		if Mission.ConvoyActive == true then
			NavigatorStop(Mission.SupportConvoy[1])
			NavigatorMoveOnPath(Mission.SupportConvoy[1],Mission.ConvoyPath)
			NavigatorMoveToRange(Mission.SupportConvoy[2], Mission.SupportConvoy[1])
			luaDelay(luaUS14ConvoyMoveManager,6)
		end
	end
end

function luaUS14SupplyKilled()
	if IsListenerActive("kill", "listenerSupplyKill") then
		RemoveListener("kill", "listenerSupplyKill")
	end
	
	RemoveTrigger(Mission.SupportConvoy[1],"proximityConvoy")
	if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
		luaObj_Failed("secondary", 1)
		HideScoreDisplay(2,0)
		MissionNarrative("usn14.obj_s1_failed")
		luaStartDialog("convoy_lost")
		Mission.ConvoyActive = false
		luaDelay(luaUS14ConvoyFailedNarrative,3)
	end
	if not Mission.SupportConvoy[2].Dead then
		NavigatorMoveToRange(Mission.SupportConvoy[2], Mission.SouthHQ)
	end
end

function luaUS14ConvoyFailedNarrative()
	if Mission.EndMission then
		return
	else
		MissionNarrative("usn14.obj_s1_failed")
	end
end

function luaUS14ConvoyDamaged1()
	luaStartDialog("convoy_hit")
	if IsListenerActive("hpEvent", "ListenerConvoyDamage1") then
		RemoveListener("hpEvent", "ListenerConvoyDamage1")
	end
	AddListener("hpEvent", "ListenerConvoyDamage2" , {
				["callback"] = "luaUS14ConvoyDamaged2",
				["entity"]   = {Mission.SupportConvoy[1]},
				["reason"]   = {"damage"},
				["hp"]       = 0.3,
				})
end

function luaUS14ConvoyDamaged2()
	luaStartDialog("convoy_critical")
	if IsListenerActive("hpEvent", "ListenerConvoyDamage2") then
		RemoveListener("hpEvent", "ListenerConvoyDamage2")
	end
end

function luaUS14ConvoyExited()
	if IsListenerActive("kill", "listenerSupplyKill") then
		RemoveListener("kill", "listenerSupplyKill")
	end
	RemoveTrigger(Mission.SupportConvoy[1], "proximityConvoy")
	luaStartDialog("convoy_success")
	luaObj_Completed("secondary",1,true)
	MissionNarrative("usn14.obj_s1_success")
	SetInvincible(Mission.SupportConvoy[1], true)
	HideScoreDisplay(2,0)
	Mission.ConvoyActive = false
	if not Mission.SupportConvoy[2].Dead then
		NavigatorMoveToRange(Mission.SupportConvoy[2], Mission.SouthHQ)
	end
end

function luaUS14ReinforcementStart()
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 36,
				["Name"] = "USS Bayfield",
				["GuiName"] = "ingame.shipnames_bayfield",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
			},
			{
				["Type"] = 36,
				["Name"] = "USS Leon",
				["GuiName"] = "ingame.shipnames_leon",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
			},
			{
				["Type"] = 36,
				["Name"] = "USS Clay",
				["GuiName"] = "ingame.shipnames_clay",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
			},
			{
				["Type"] = 36,
				["Name"] = "USS Elmore",
				["GuiName"] = "ingame.shipnames_elmore",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
			},
			{
				["Type"] = 19,
				["Name"] = "USS Amsterdam",
				["GuiName"] = "ingame.shipnames_amsterdam",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
				["Numbering"] = 121,
			},
			{
				["Type"] = 23,
				["Name"] = "USS Twining",
				["GuiName"] = "ingame.shipnames_twining",
				["Skill"] = SKILL_SPNORMAL,
				["Race"] = USA,
				["Numbering"] = 540,
			},
		},
		["area"] = {
			["refPos"] = GetPosition(Mission.NavReinfocement),
			["angleRange"] = { -1,1},
			["lookAt"] = GetPosition(Mission.HQs[1])
		},
		["callback"] = "luaUS14ReinforcementCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100,
			
		},
	})	
	luaStartDialog("reinforcements_arrived")
	luaDelay(luaUS14HintReinforcements,15)
end

function luaUS14ReinforcementCB(spawnedship)
	NavigatorMoveToPos(spawnedship, GetPosition(Mission.AreaCenter))
	table.insert(Mission.PlayerShips,FindEntity("USS Twining"))
	table.insert(Mission.PlayerShips,FindEntity("USS Amsterdam"))
	if IsListenerActive("kill", "listenerShipKilled") then
		RemoveListener("kill", "listenerShipKilled")
	end
	AddListener("kill", "listenerShipKilled", {
					["callback"] = "luaUS14ShipKilled",
					["entity"] = Mission.PlayerShips,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
	table.insert(Mission.usTroopTransports,FindEntity("USS Elmore"))
	table.insert(Mission.usTroopTransports,FindEntity("USS Clay"))
	table.insert(Mission.usTroopTransports,FindEntity("USS Leon"))
	table.insert(Mission.usTroopTransports,FindEntity("USS Bayfield"))
	
end

function luaUS14ShipKilled(killedship)
	killedship.Dead = true
-- RELEASE_LOGOFF    	luaLog("Meghalt a "..killedship.Name)	
	Mission.PlayerShips = luaRemoveDeadsFromTable(Mission.PlayerShips)
	if table.getn(Mission.PlayerShips) == 0 then
		Mission.LastShip = killedship
		luaUS14Failed("nomoreships")
	end
end

function luaUS14HintKamikaze()
	if Mission.EndMission then
		return
	else
		ShowHint("USN14_Hint_Kamikaze")
	end
end

function luaUS14HintReinforcements()
	if Mission.EndMission then
		return
	else
		ShowHint("USN14_Hint_Reinforcement")
	end
end

function luaUS14Failed(reason)
	Mission.EndMission = true
	if reason == "nomoreships" then
		luaMissionFailedNew(Mission.LastShip, "usn14.obj_p1_failed")
	end
end


function luaUS14UnlockAlabama()
	local alabama = GenerateObject(Mission.AlabamaTemplate.Name)
	table.insert(Mission.PlayerShips, alabama)
	JoinFormation(alabama, Mission.usCA)
end

function luaUS14UnlockLSM()
	local LSM2 = GenerateObject(Mission.usLSMTemplate.Name,"LSM")
	local LSM2TemplatePos = GetPosition(LSM2)
	local LSM2ModifiedPos = {["x"]=LSM2TemplatePos.x, ["y"]=LSM2TemplatePos.y, ["z"]=(LSM2TemplatePos.z-150)}
	PutTo(LSM2, LSM2ModifiedPos)
		table.insert(Mission.usTroopTransports, LSM2)
	local LSM3 = GenerateObject(Mission.usLSMTemplate.Name)
		SetNumbering(LSM3,175)
		SetGuiName(LSM3,"usn14.lsm175")
		table.insert(Mission.usTroopTransports, LSM3)
end

function luaUS14Unlock()
	local alabama = GenerateObject(Mission.AlabamaTemplate.Name)
	table.insert(Mission.PlayerShips, alabama)
	JoinFormation(alabama, Mission.usCA)
end

--[[
*****************************************************************************************
**                         		INGAME ENGINE MOVIES                                   **
*****************************************************************************************
]]
-- Yamato EM
function luaUS14EM_Yamato_1()
	Mission.YamatoMovieRunning = true
	Blackout(true, "luaUS14EM_Yamato_2", 1)
end

function luaUS14EM_Yamato_2()
	BlackBars(true)
	Mission.CamScript = luaCamOnTargetFree(Mission.Yamato, 7, 2, 65, false, nil , 0, nil)
	Blackout(false, "", 1.5)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS14EM_Yamato_Interrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Mission.Delay = luaDelay(luaUS14EM_Yamato_3,2)
end

function luaUS14EM_Yamato_3()
	Mission.CamScript = luaCamOnTargetFree(Mission.Yamato, 7, 2, 180, false, "noupdate" , 9, luaUS14EM_Yamato_4)
	
end

function luaUS14EM_Yamato_4()
	Mission.CamScript = luaCamOnTargetFree(Mission.Yamato, 3, 6, 250, false, "noupdate" , 8, luaUS14EM_Yamato_5)
end

function luaUS14EM_Yamato_5()
	Blackout(true, "luaUS14EM_Yamato_6", 1)
end

function luaUS14EM_Yamato_6()
	BlackBars(false)
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	if Mission.LastSelected ~= nil and not Mission.LastSelected.Dead then
		SetSelectedUnit(Mission.LastSelected)
		SetInvincible(Mission.LastSelected,false)
	else
		SetSelectedUnit(luaPickRnd(Mission.PlayerShips))
	end
	EnableInput(true)
	Blackout(false, "", 1)
	luaObj_Add("primary",2,Mission.Yamato)
	Mission.YamatoMovieRunning = false
end

function luaUS14EM_Yamato_Interrupted()
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	Blackout(true, "luaUS14EM_Yamato_6", 1)
end

--HQ EM
function luaUS14EM_HQ_1(capturedHQ)
	if Mission.YamatoMovieRunning then
		luaDelay(luaUS14EM_HQ_1, 3, "capturedHQ", capturedHQ)
		return
	end
	Mission.HQMovieRunning = true
	Blackout(true, "luaUS14EM_HQ_2", 1)
	Mission.MovieHQ = capturedHQ

end

function luaUS14EM_HQ_2()
	if (table.getn(Mission.alliedHQs) == 1) then
		--[[if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
			--luaCheckpoint(1,nil)
		end]]
	elseif (table.getn(Mission.alliedHQs) == 2) then
		--[[local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
		if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) or ((num ~= nil) and (table.getn(num)>0) and (num[1] ~= 2)) then
			--luaCheckpoint(2, nil)
		end]]
	end
	BlackBars(true)
	Mission.CamScript = luaCamOnTargetFree(Mission.MovieHQ, 10, 30, 300, false, nil , 0, nil)
	Blackout(false, "", 1.5)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS14EM_HQ_Interrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Mission.Delay = luaDelay(luaUS14EM_HQ_3,2)
end

function luaUS14EM_HQ_3()
	Mission.CamScript = luaCamOnTargetFree(Mission.MovieHQ, 5, 15, 800, false, "noupdate" , 9, luaUS14EM_HQ_4)
	
end

function luaUS14EM_HQ_4()
	Mission.CamScript = luaCamOnTargetFree(Mission.MovieHQ, 7, 90, 800, false, "noupdate" , 7, luaUS14EM_HQ_5)

end

function luaUS14EM_HQ_5()
	Blackout(true, "luaUS14EM_HQ_6", 1)
end

function luaUS14EM_HQ_6()
	BlackBars(false)
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	Mission.HQMovieRunning = false
	if Mission.LastSelected ~= nil and not Mission.LastSelected.Dead then
		SetSelectedUnit(Mission.LastSelected)
		SetInvincible(Mission.LastSelected, false)
	else
		SetSelectedUnit(luaPickRnd(Mission.PlayerShips))
	end
	EnableInput(true)
	Blackout(false, "", 1)
end

function luaUS14EM_HQ_Interrupted()
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	Blackout(true, "luaUS14EM_HQ_6", 1)
end

function luaUS14SetChangeableGUIName(unit)
	if Mission.ChangeableNames[unit.ClassID] then
		if Mission.ChangeableNames[unit.ClassID].Counter ==  nil then
			Mission.ChangeableNames[unit.ClassID].Counter = 1
		end
		SetGuiName(unit, Mission.ChangeableNames[unit.ClassID][Mission.ChangeableNames[unit.ClassID].Counter])
-- RELEASE_LOGOFF  		luaLog("GUIName set for " .. unit.Name .. ", class " .. tostring(unit.ClassID) .. " : " .. Mission.ChangeableNames[unit.ClassID][Mission.ChangeableNames[unit.ClassID].Counter].." number "..tostring(Mission.ChangeableNames[unit.ClassID].Counter))
		Mission.ChangeableNames[unit.ClassID].Counter = Mission.ChangeableNames[unit.ClassID].Counter + 1
		if table.getn(Mission.ChangeableNames[unit.ClassID]) < Mission.ChangeableNames[unit.ClassID].Counter then
			Mission.ChangeableNames[unit.ClassID].Counter = 1
		end
	else
		SetGuiName(unit, "")
	end
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(150)		--zero
	PrepareClass(159)		--judy
	PrepareClass(167)		--betty
	PrepareClass(162)		--kate
	PrepareClass(45)		--kamikaze zero
	PrepareClass(32)		--Betty-Ohka
	PrepareClass(43)		--kamikaze boat
	PrepareClass(77)		--jap PT
	PrepareClass(73)		-- Fubuki
	--PrepareClass(425) 		--boss yamato
	PrepareClass(255) 		--Yamato1945
	Loading_Finish()
end

--[[
*****************************************************************************************
**                         			  CHECKPOINT FUNCTIONS							   **
*****************************************************************************************
]]
function luaUS14PhaseManager()
	PilotMoveTo(Mission.japJudy, Mission.usCV)
	Mission.FirstCounterAttackTime = math.floor(GameTime())
	Mission.ShipTable = luaGetOwnUnits("ship", PARTY_ALLIED)
	Mission.Phase2ThinkCounter = 666
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
-- RELEASE_LOGOFF  	luaLog("SOUTHHQ Party: "..Mission.SouthHQ.Party)
	
	AddListener("kill", "listenerShipKilled", {
					["callback"] = "luaUS14ShipKilled",
					["entity"] = Mission.PlayerShips,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
	if num[1] == 1 then
		Mission.MissionPhase = 2
		Mission.FirstRun = false
		Mission.FirstCaptured = true
		if not luaObj_IsActive("primary",2) then
			Mission.YamatoTimer = 9
		end
		if not luaObj_IsActive("secondary",1) then
			Mission.ConvoyTimer = 4
		end
	elseif num[1] == 2 then
		Mission.MissionPhase = 2
		Mission.FirstRun = false
		Mission.FirstCaptured = true
		Mission.SecondCaptured = true
		if not luaObj_IsActive("primary",2) then
			Mission.YamatoTimer = 3
		end
		if not luaObj_IsActive("secondary",1) then
			Mission.ConvoyTimer = 1
		end
	end
	
	--yamato uton volt mar mentes kozben
	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		Mission.Yamato = GenerateObject(Mission.YamatoTempateCheckpoint.Name)
		SetSkillLevel(Mission.Yamato,Mission.YamatoSkill)
		NavigatorSetAvoidShipCollision(Mission.Yamato, false)
		NavigatorSetAvoidLandCollision(Mission.Yamato, false)
		NavigatorMoveToPos(Mission.Yamato, Mission.NavYamatoFinish)
		AddDamage(Mission.Yamato, 1000)		
		luaObj_AddUnit("primary",2,Mission.Yamato)
		DisplayUnitHP({Mission.Yamato},"usn14.obj_p2")
		Mission.Primary2Complete = false
		AddListener("kill", "listenerYamatoKilled", {
					["callback"] = "luaUS14YamatoKilled",
					["entity"] = {Mission.Yamato},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
		Mission.LastDistance = luaGetDistance(Mission.NavYamatoFinish, Mission.Yamato)
		Mission.StartDistance = Mission.LastDistance
		Mission.YamatoTimer = 0
		Mission.YamatoShoreFlag = 0
		Mission.YamatoKilled = 0
		luaDelay(luaUS14YamatoHeadingtoShoreDialogue,60)
	end
	
	--Convoy objective check
	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		Mission.ConvoyTimer = 0
		luaUS14ConvoyStart()
	end
	luaDelay(luaUS14CheckKashumi,0.5)
end

function luaUS14CheckKashumi()
	if Mission.SouthHQ.Party ~= 1 then
		Kill(Mission.Kashumi,true)
	end
end

function luaUS14SaveMissionData()
	Mission.Checkpoint.CheckpointHQ = Mission.CheckpointHQ.Name
	Mission.Checkpoint.TransportNum	= table.getn(Mission.usTroopTransports)
	Mission.Checkpoint.PlayerShipNum	= table.getn(Mission.PlayerShips)
end

function luaUS14CpLoadMissionData()
	Mission.CheckpointHQ = Mission.Checkpoint.CheckpointHQ
	FindEntity(Mission.CheckpointHQ).CapturedFlag = true
	Mission.TransportNum = Mission.Checkpoint.TransportNum
	Mission.PlayerShipNum = Mission.Checkpoint.PlayerShipNum
end

function luaUS14CpRelocateUnits()
	--relocate
	if Mission.CheckpointHQ == "CommandBuilding_North" then
		Mission.Location = "North"
		Mission.Rotation = -150
	elseif Mission.CheckpointHQ == "CommandStation_Center" then
		Mission.Location = "Center"
		Mission.Rotation = 30
	elseif Mission.CheckpointHQ == "CommandStation_South" then
		Mission.Location = "South"
		Mission.Rotation = -60
	end
	--Transport Ships
	for idx,unit in pairs(Mission.usTroopTransports) do
-- RELEASE_LOGOFF    		luaLog("PUTTO LOG "..idx.."  :  "..Mission.CPNavpoints[Mission.Location].Transports[idx].Name)
		PutTo(unit, GetPosition(Mission.CPNavpoints[Mission.Location].Transports[idx]),-100)
	end
	--CV Group
	PutTo(FindEntity("Yorktown-class 01"), GetPosition(Mission.CPNavpoints[Mission.Location].CV[1]),-100)
	PutTo(FindEntity("Fletcher-class 01"), GetPosition(Mission.CPNavpoints[Mission.Location].CV[2]),-100)
	luaRemoveByName(Mission.PlayerShips, "Yorktown-class 01")
	luaRemoveByName(Mission.PlayerShips, "Fletcher-class 01")
		
	--BB Group
	for idx,unit in pairs(Mission.PlayerShips) do
		PutTo(unit, GetPosition(Mission.CPNavpoints[Mission.Location].Fleet[idx]),Mission.Rotation)
	end
	table.insert(Mission.PlayerShips,FindEntity("Yorktown-class 01"))
	table.insert(Mission.PlayerShips,FindEntity("Fletcher-class 01"))
	
	--Kill not needed ships
	Kill(Mission.japDD1,true)
	Kill(Mission.japDD2,true)
	
	Mission.TransportMinimum = 4
	if Mission.TransportNum < 4 then 
		Mission.TransportMinimum = 4
	end
	Mission.RemovedTransport = 0
	
	--Kill Fletchers and Transport ships
	luaDelay(luaUS14NeutralReset,3)
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]
	local usnsaved = luaGetCheckpointData("Units", "USUnits")
	local usnunits = luaGetOwnUnits("ship", PARTY_ALLIED)

	for idx,unit in pairs(usnunits) do
		NavigatorStop(unit)
		if unit.Class.Type == "Destroyer" then
			local found = false
			for idx2,unitTbl in pairs(usnsaved[1]) do
				if unit.Name == unitTbl[1] then
					if unitTbl[4] and unitTbl[4] >= 0 then
						ShipSetTorpedoStock(unit, unitTbl[4])
					end
					found = true
					break
				end
			end
			--Kill
			if not found then
-- RELEASE_LOGOFF    				luaLog("Unit not found, killing her "..unit.Name)
				Kill(unit, true)
			end
		end
		
		if unit.Class.Type == "Cargo" then
			local found = false
			for idx2,unitTbl in pairs(usnsaved[1]) do
				if unit.Name == unitTbl[1] then
					found = true
					break
				end
			end
			--Kill
			if not found and Mission.RemovedTransport < Mission.TransportMinimum then
-- RELEASE_LOGOFF    				luaLog("Unit not found, killing her "..unit.Name)
				Kill(unit, true)
			end
		end
	end
end

function luaUS14NeutralReset()
	Mission.Neutralbuildings = luaSumTablesIndex(recon[PARTY_NEUTRAL].own.landfort, recon[PARTY_NEUTRAL].own.airfield, recon[PARTY_NEUTRAL].own.shipyard)
	for idx,unit in pairs(Mission.Neutralbuildings) do
		SetParty(unit, PARTY_JAPANESE)
	end
	ForceRecon()

end

function mozi()
	luaObj_CompletedAll()
	Mission.Primary1Complete=true
	Mission.Primary2Complete=true
end

function luaspawn1()
	local shipyard1 = Mission.Shipyards[1]
	local typeTable = {
		43, --kamikaze boat
		77, --jap pt
		77, --jap pt
	}
	local spawnType = luaPickRnd(typeTable)
	local shipyardNum = 1
	luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF  	luaLog("spawnship called on shipyard1")
end

function luaspawn2()
	local shipyard2 = Mission.Shipyards[2]
	local typeTable = {
		43, --kamikaze boat
		77, --jap pt
		77, --jap pt
	}
	local spawnType = luaPickRnd(typeTable)
	local shipyardNum = 2
	luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF  	luaLog("spawnship called on shipyard2")
end

function luaspawn3()
	local shipyard3 = Mission.Shipyards[3]
	local typeTable = {
		77, --jap pt
		43, --kamikaze boat
	}
	local spawnType = luaPickRnd(typeTable)
	local shipyardNum = 3
	luaUS14ShipyardSpawn(shipyardNum, spawnType)
-- RELEASE_LOGOFF  	luaLog("spawnship called on shipyard3")
end