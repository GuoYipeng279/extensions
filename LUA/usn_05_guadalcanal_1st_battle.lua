--SceneFile="missions\USN\usn_05_GuadalCanal_1st_Battle.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--todo: secondary legyen megcsinalhato (primaryk ne ussek ki)
--todo: retreatnel legyen okos
--toso: ne ragadjanak bent a destroyerek ha a vezerhajok mar kiernek 
--todo: luaUS05RetreatStart hivodhat akkor ha mar nincs hajo

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	--MessageMap betoltese
	LoadMessageMap("usn05dlg",1)
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
			},
		},
	}
	MissionNarrative("usn05.date_location")
	luaDelay(luaUSN05_Dialog_Intro, 12)
end

function luaUSN05_Dialog_Intro()
	StartDialog("intro", Dialogues["intro"])
end


function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitUS05")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitUS05(this)
	Mission = this
	this.Name = "US05"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_05_guadalcanal_1st_battle.lua"

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	this.MissionPhase = 1
	this.FirstRun = true
	Blackout(true,"",0)
	
	SetVisibilityTerrainNode("usn06 Second Batt Guadal:mapzone", false)
	
	--unit names
	this.UnitNames = {}
	this.UnitNames.Us = {}
		this.UnitNames.Us.DD = {}
		table.insert(this.UnitNames.Us.DD,"USS O'Bannon")
		table.insert(this.UnitNames.Us.DD,"USS Fletcher")
		table.insert(this.UnitNames.Us.DD,"USS Cushing")
		table.insert(this.UnitNames.Us.DD,"USS Laffey")
		
		this.UnitNames.Us.CL = {}
		table.insert(this.UnitNames.Us.CL,"USS San Francisco")
		table.insert(this.UnitNames.Us.CL,"USS Atlanta")
		
		this.UnitNames.Us.Hidden = {}
		table.insert(this.UnitNames.Us.Hidden,"USS Portland")
		table.insert(this.UnitNames.Us.Hidden,"USS Aaron Ward")
		table.insert(this.UnitNames.Us.Hidden,"USS Sterett")
		
	this.UnitNames.Jap = {}
		this.UnitNames.Jap.DD = {}
		table.insert(this.UnitNames.Jap.DD,"Akatsuki")
		table.insert(this.UnitNames.Jap.DD,"Ikazuchi")
		table.insert(this.UnitNames.Jap.DD,"Inazuma")
		table.insert(this.UnitNames.Jap.DD,"Yukikaze")
		table.insert(this.UnitNames.Jap.DD,"Amatsukaze")
		table.insert(this.UnitNames.Jap.DD,"Harusame")
		table.insert(this.UnitNames.Jap.DD,"Teruzuki")
		table.insert(this.UnitNames.Jap.DD,"Inazuma")
		table.insert(this.UnitNames.Jap.DD,"Yudachi")
		table.insert(this.UnitNames.Jap.DD,"Murasame")
		
		this.UnitNames.Jap.CL = {}
		table.insert(this.UnitNames.Jap.CL,"Nagara")
		table.insert(this.UnitNames.Jap.CL,"Mogami")
		
		this.UnitNames.Jap.BB = {}
		table.insert(this.UnitNames.Jap.BB,"Hiei")
		
    -- allied hajok
	this.UsCruisers = {}
		table.insert(this.UsCruisers,FindEntity("Northampton-class 01"))
		table.insert(this.UsCruisers,FindEntity("Atlanta-class 01"))
		
	this.UsDestroyers = {}		
		table.insert(this.UsDestroyers,FindEntity("Fletcher-class 01"))
		table.insert(this.UsDestroyers,FindEntity("Fletcher-class 02"))
		table.insert(this.UsDestroyers,FindEntity("Fletcher-class 03"))
		table.insert(this.UsDestroyers,FindEntity("Clemson-class 01"))
	
	this.HiddenUsForce = {}
	
	this.HiddenUsForceTemplate = {}
		table.insert(this.HiddenUsForceTemplate,luaFindHidden("Cleveland-class 01"))
		table.insert(this.HiddenUsForceTemplate,luaFindHidden("Fletcher-class 04"))
		table.insert(this.HiddenUsForceTemplate,luaFindHidden("Fletcher-class 05"))
	
	this.HiddenUsForcePostable = {}
		this.HiddenUsForcePostable.North = {}
			table.insert(this.HiddenUsForcePostable.North, GetPosition(FindEntity("Nav_Hidden_Cleveland")))
			table.insert(this.HiddenUsForcePostable.North, GetPosition(FindEntity("Nav_Hidden_Fletcher_1")))
			table.insert(this.HiddenUsForcePostable.North, GetPosition(FindEntity("Nav_Hidden_Fletcher_2")))
			table.insert(this.HiddenUsForcePostable.North, GetPosition(FindEntity("Nav_Hidden_Fubuki")))
	
	this.SanFrancisco = this.UsCruisers[1]
	this.Atlanta = this.UsCruisers[2]
	
	this.UsShips = {}
		for i=1,table.getn(this.UsDestroyers) do
			table.insert(this.UsShips,this.UsDestroyers[i])
			--SetGuiName(this.UsDestroyers[i], this.UnitNames.Us.DD[i])
			this.UsDestroyers[i].Threat = 1
		end
		for i=1,table.getn(this.UsCruisers) do
			table.insert(this.UsShips,this.UsCruisers[i])
			--SetGuiName(this.UsCruisers[i], this.UnitNames.Us.CL[i])
			this.UsCruisers[i].Threat = 3
		end
		
	-- allied repcsik
		
	-- allied pathok, nav pontok
	this.NavKingfisher = FindEntity("NavKingfisher")
	this.NavHieiSpawn = FindEntity("NavHieiSpawn")

	-- Checkpoint navpoints
	this.CheckpointShipPos_US = {}
		table.insert(this.CheckpointShipPos_US,FindEntity("NavCp1_US_Pos 01"))
		table.insert(this.CheckpointShipPos_US,FindEntity("NavCp1_US_Pos 02"))
		
	this.CheckpointShipPos_IJN = {}
		this.CheckpointShipPos_IJN.South = {}
			table.insert(this.CheckpointShipPos_IJN.South,FindEntity("NavCp1_IJN_Pos 01"))
			table.insert(this.CheckpointShipPos_IJN.South,FindEntity("NavCp1_IJN_Pos 02"))
			table.insert(this.CheckpointShipPos_IJN.South,FindEntity("NavCp1_IJN_Pos 03"))
		this.CheckpointShipPos_IJN.Center = {}
			table.insert(this.CheckpointShipPos_IJN.Center,FindEntity("NavCp1_IJN_Pos 04"))
			table.insert(this.CheckpointShipPos_IJN.Center,FindEntity("NavCp1_IJN_Pos 05"))
			table.insert(this.CheckpointShipPos_IJN.Center,FindEntity("NavCp1_IJN_Pos 06"))
		this.CheckpointShipPos_IJN.North = {}
			table.insert(this.CheckpointShipPos_IJN.North,FindEntity("NavCp1_IJN_Pos 07"))
			table.insert(this.CheckpointShipPos_IJN.North,FindEntity("NavCp1_IJN_Pos 08"))
			table.insert(this.CheckpointShipPos_IJN.North,FindEntity("NavCp1_IJN_Pos 09"))
	
	-- japanese unitok
	this.HieiTemplate = luaFindHidden("HieiTemplate")

	this.IJNFleet = {}
		table.insert(this.IJNFleet, FindEntity("South_Fubuki_1")) --1st formation
		table.insert(this.IJNFleet, FindEntity("South_Fubuki_2")) --1st formation 
		table.insert(this.IJNFleet, FindEntity("South_Mogami_1")) --1st formation leader & FlagShip
		table.insert(this.IJNFleet, FindEntity("South_Fubuki_3")) --2nd  formation
		table.insert(this.IJNFleet, FindEntity("South_Fubuki_4")) --2nd  formation
		table.insert(this.IJNFleet, FindEntity("South_Tone_1")) --2nd  formation leader 
		table.insert(this.IJNFleet, FindEntity("South_Minekaze_1")) --3rd formation
		table.insert(this.IJNFleet, FindEntity("South_Minekaze_2")) --3rd formation
		table.insert(this.IJNFleet, FindEntity("South_Akizuki_1")) --3rd formation leader
		table.insert(this.IJNFleet, FindEntity("South_Minekaze_3")) --scout
		table.insert(this.IJNFleet, FindEntity("South_Fubuki_5")) --scout
	
	this.CenterPosTable= {}
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Fubuki_1_Pos"))) --1st formation
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Fubuki_2_Pos"))) --1st formation 
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Mogami_1_Pos"))) --1st formation leader
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Fubuki_3_Pos"))) --2nd  formation
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Fubuki_4_Pos"))) --2nd  formation
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Tone_1_Pos"))) --2nd  formation leader 
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Minekaze_1_Pos"))) --3rd formation
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Minekaze_2_Pos"))) --3rd formation
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Akizuki_1_Pos"))) --3rd formation leader
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Minekaze_3_Pos"))) --scout
		table.insert(this.CenterPosTable, GetPosition(FindEntity("Center_Fubuki_5_Pos"))) --scout
	
	this.NorthPosTable= {}
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Fubuki_1_Pos"))) --1st formation
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Fubuki_2_Pos"))) --1st formation 
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Mogami_1_Pos"))) --1st formation leader
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Fubuki_3_Pos"))) --2nd  formation
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Fubuki_4_Pos"))) --2nd  formation
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Tone_1_Pos"))) --2nd  formation leader 
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Minekaze_1_Pos"))) --3rd formation
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Minekaze_2_Pos"))) --3rd formation
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Akizuki_1_Pos"))) --3rd formation leader
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Minekaze_3_Pos"))) --scout
		table.insert(this.NorthPosTable, GetPosition(FindEntity("North_Fubuki_5_Pos"))) --scout
				
	this.FlagShip =	this.IJNFleet[3]
	
	this.HiddenJapDestroyerTemplate = luaFindHidden("Fubuki-class 01")
	
	-- japanese objektumok
	
	-- japanese pathok, nav pontok
	this.NavJapEscape = FindEntity("NavJapEscape")
	this.NavHieiNorth = FindEntity("NavHieiSpawn")
	this.IJNPaths = {}
		this.IJNPaths.South = {}
			table.insert(Mission.IJNPaths.South, FindEntity("South_Mogami_Path"))
			table.insert(Mission.IJNPaths.South, FindEntity("South_Tone_Path"))
			table.insert(Mission.IJNPaths.South, FindEntity("South_Akizuki_Path"))
		this.IJNPaths.Center = {}
			table.insert(Mission.IJNPaths.Center, FindEntity("Center_Mogami_Path"))
			table.insert(Mission.IJNPaths.Center, FindEntity("Center_Tone_Path"))
			table.insert(Mission.IJNPaths.Center, FindEntity("Center_Akizuki_Path"))
		this.IJNPaths.North = {}
			table.insert(Mission.IJNPaths.North, FindEntity("North_Mogami_Path"))
			table.insert(Mission.IJNPaths.North, FindEntity("North_Tone_Path"))
			table.insert(Mission.IJNPaths.North, FindEntity("North_Akizuki_Path"))
	
	this.NavCenterEscape = FindEntity("NavCenterEscape")
	this.NavNorthEscape = FindEntity("NavNorthEscape")
	this.NavSouthEscape = FindEntity("NavSouthEscape")
	this.EscapePoints = {}
		this.EscapePoints.South = {FindEntity("NavSouthEscape")}
		this.EscapePoints.Center = {FindEntity("NavCenterEscape")}
		this.EscapePoints.North = {FindEntity("NavNorthEscape")}
	
			
	-- Misc valtozok
	this.HieiState = 0 --0=meg nem spawnolt, 1=spawnolt nem detektalt, 2=detektalt, -1=halott
	this.SubStatus = 0 --0= meg nem spawnolt, 1=spawnolt, 2=killezett, 3=elmenekult
	this.Phase2Delay = 10 --hidden us csapat megerkezesenek idozitese percben
	this.UsMaxThreat = 0 --az initben kesobb toltjuk fel
	this.UsActualThreat = 0 --az elso ciklusban toltjuk fel
	this.DDThreatRange = 2800 --DD-k bekerulnek a threat tablaba ha flagshiphez ennel kozelebb mennek
	this.CLThreatRange = 3200 --CL-k bekerulnek a threat tablaba ha flagshiphez ennel kozelebb mennek
	this.CLTorpedoRange = 1300 --ennel kozelebbi usa CLek torpedot kapnak a pofajukba
	this.CommandPeriod = 20 --ennyi masodpercenkent kaphat uj kommandot a unit
	this.TorpedoEnableCount = 0
	this.MaxTorpedoEnable = 4
	this.Primary1RemindCount = 3
	this.Primary2RemindCount = 1
	this.Primary3RemindCount = 3
	this.LostUSShips = 0
	this.LostUSShipsLimit = 5 -- ennyi hajo elvesztese jelenti a secondary failt
	this.HieiDelay = 60 -- a hidden unitok megjelenese utan ennyi mp-el erkezik a Hiei
	this.HieiVictory = false
	
	-- Teszt valtozok
	this.Teszt = {}
		
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
				["ID"] = "DestroyFlagship",		-- azonosito
				["Text"] = "usn05.obj_p1",
				["TextCompleted"] = "usn05.obj_p1_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "FindBombardmentForce",		-- azonosito
				["Text"] = "usn05.obj_p2",
				["TextCompleted"] = "usn05.obj_p2_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "SinkHiei",		-- azonosito
				["Text"] = "usn05.obj_p3",
				["TextCompleted"] = "usn05.obj_p3_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		
		["hidden"] = {
			[1] =
			{
				["ID"] = "HieiFastKill",		-- azonosito
				["Text"] = "usn05.obj_h1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 200*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		 
		["secondary"] = {
			[1] =
			{
				["ID"] = "4USNShipSunk",		-- azonosito
				["Text"] = "usn05.obj_s1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 300*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	LoadMessageMap("usn05dlg",1)

	Mission.Dialogues = {
		["destroyers_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
			},
		},
		["mainforce_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
				{
					["message"] = "dlg02b",
				},
			},
		},
		["flagship_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
				{
					["message"] = "dlg03c",
				},
				{
					["message"] = "dlg03d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS05FlagshipObjective",
				},
			},
		},
		["reinforcement_arrives"] = {
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
			},
		},
		["Hiei_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
				{
					["message"] = "dlg05c",
				},
				{
					["message"] = "dlg05d",
				},
				{
					["message"] = "dlg05e",
				},
				{
					["message"] = "dlg05f",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS05HieiObjective",
				},
			},
		},
		["flagship_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
				{
					["message"] = "dlg06c",
				},
			},
		},
		["japs_retreating"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07b",
				},
			},
		},
		["Hiei_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg08",
				},
			},
		},
		["victory"] = {
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
					["type"] = "callback",
					["callback"] = "luaUS05Victory",
				},
			},
		},
}
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(this, "US05Think")

	SetSelectedUnit(Mission.UsCruisers[1])
		
	--initial formations
	--USN formacio
	JoinFormation(Mission.UsDestroyers[1], Mission.UsCruisers[2]) --atlanta
	JoinFormation(Mission.UsDestroyers[2], Mission.UsCruisers[2]) --atlanta
	JoinFormation(Mission.UsDestroyers[3], Mission.UsCruisers[1]) --san francisco
	JoinFormation(Mission.UsDestroyers[4], Mission.UsCruisers[1]) --san francisco
	
	SetShipMaxSpeed(Mission.IJNFleet[3], 11)
	SetShipMaxSpeed(Mission.IJNFleet[6], 11)
	SetShipMaxSpeed(Mission.IJNFleet[9], 11)
	
	--Init Functions
	EnableMessages(true)
	
	Mission.DDNameCounter = 1
	Mission.CLNameCounter = 1
	for idx,unit in pairs(Mission.IJNFleet) do
		if unit.Class.Type == "Destroyer" then
			--SetGuiName(unit, Mission.UnitNames.Jap.DD[Mission.DDNameCounter])
			Mission.DDNameCounter = Mission.DDNameCounter + 1
		end
		if unit.Class.Type == "Cruiser" then
			--SetGuiName(unit, Mission.UnitNames.Jap.CL[Mission.CLNameCounter])
			Mission.CLNameCounter = Mission.CLNameCounter + 1
		end	
	end
	
	this.ChangeableNames = {}
		this.ChangeableNames[11] = {	-- AllenMSumner
			"ingame.shipnames_hank",
			"ingame.shipnames_borie",
			"ingame.shipnames_hyman",
			"ingame.shipnames_compton",
			"ingame.shipnames_soley"
		}
		this.ChangeableNames[48] = {	-- ASWFletchers
			"ingame.shipnames_wadleigh",
			"ingame.shipnames_mertz",
			"ingame.shipnames_remey",
			"ingame.shipnames_picking",
			"ingame.shipnames_stockham"
		}
		this.ChangeableNames[900] = {	-- Luppis
			"ingame.shipnames_charles_s_sperry",
			"ingame.shipnames_john_w_weeks",
			"ingame.shipnames_harlan_r_dickson",
			"ingame.shipnames_hugh_purvis",
			"ingame.shipnames_walke",
		}
		this.ChangeableNames[17] = {	-- Atlanta
			"ingame.shipnames_oakland",
			"ingame.shipnames_reno",
		}
		this.ChangeableNames[390] = {	-- Alaska
			"ingame.shipnames_guam",
			"ingame.shipnames_hawaii",
		}
		
	Mission.DestroyerGuiNameCounter = 1
	for idx, unit in pairs(Mission.UsDestroyers) do
		if IsClassChanged(unit.ClassID) then
			luaSetUnlockName(unit)
		end
	end
	
	--Difficulty settings
	if Mission.Difficulty == 0 then
		Mission.MaxTorpedoEnable = 2
		Mission.HieiHiddenTimer = 8
	elseif Mission.Difficulty == 1 then
		Mission.MaxTorpedoEnable = 4
		Mission.HieiHiddenTimer = 6
	elseif Mission.Difficulty == 2 then
		Mission.MaxTorpedoEnable = 6
		SetSkillLevel(FindEntity("South_Mogami_1"),SKILL_SPVETERAN)
		SetSkillLevel(FindEntity("South_Tone_1"),SKILL_SPVETERAN)
		SetSkillLevel(FindEntity("South_Akizuki_1"),SKILL_SPVETERAN)
		Mission.HieiHiddenTimer = 5
	end
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS05Cp1LoadMissionData},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS05Cp1SaveMissionData},
	}
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == true then
		luaDelay(luaUS05PhaseManager,1)
		--Jap flagship csapat
		JoinFormation(Mission.IJNFleet[1],Mission.IJNFleet[3])
		JoinFormation(Mission.IJNFleet[2],Mission.IJNFleet[3])
		
		--Tone csapat
		JoinFormation(Mission.IJNFleet[4], Mission.IJNFleet[6])	
		JoinFormation(Mission.IJNFleet[5], Mission.IJNFleet[6])
		
		--Akizuki csapat
		JoinFormation(Mission.IJNFleet[7], Mission.IJNFleet[9])
		JoinFormation(Mission.IJNFleet[8], Mission.IJNFleet[9])	
	else
		Blackout(false, "", 1.5)
	end
end

function US05Think(this, msg)
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
	Mission.UsDestroyers = luaRemoveDeadsFromTable(Mission.UsDestroyers)
	Mission.UsCruisers = luaRemoveDeadsFromTable(Mission.UsCruisers)
	Mission.UsShips = luaRemoveDeadsFromTable(Mission.UsShips)
	
	Mission.IJNFleet = luaRemoveDeadsFromTable(Mission.IJNFleet)
	
	luaUS05CheckConditions()
		
-- MissionPhase 1
	if this.MissionPhase == 1 then
		this.MissionPhase = 2
		--Blackout(false, "", 1)
		local randomRoll = luaRnd(1,3)
		--local randomRoll = 3 --debug
		local shipNum = table.getn(Mission.IJNFleet)
		if randomRoll == 1 then
			Mission.StartupPos = "South"
			Mission.EscapePoint = Mission.NavSouthEscape
		elseif randomRoll == 2 then
			Mission.StartupPos = "Center"
			Mission.EscapePoint = Mission.NavCenterEscape
			for i=1,shipNum do
				PutTo(Mission.IJNFleet[i], Mission.CenterPosTable[i], -100)
			end
		elseif randomRoll == 3 then
			Mission.StartupPos = "North"
			Mission.EscapePoint = Mission.NavNorthEscape
			for i=1,shipNum do
				PutTo(Mission.IJNFleet[i], Mission.NorthPosTable[i], 140)
			end
		end
		
		--Jap flagship csapat
		JoinFormation(Mission.IJNFleet[1],Mission.IJNFleet[3])
		JoinFormation(Mission.IJNFleet[2],Mission.IJNFleet[3])
		
		--Tone csapat
		JoinFormation(Mission.IJNFleet[4], Mission.IJNFleet[6])	
		JoinFormation(Mission.IJNFleet[5], Mission.IJNFleet[6])
		
		--Akizuki csapat
		JoinFormation(Mission.IJNFleet[7], Mission.IJNFleet[9])
		JoinFormation(Mission.IJNFleet[8], Mission.IJNFleet[9])	
		
		NavigatorMoveOnPath(Mission.IJNFleet[3], Mission.IJNPaths[Mission.StartupPos][1])
		NavigatorMoveOnPath(Mission.IJNFleet[6], Mission.IJNPaths[Mission.StartupPos][2])
		NavigatorMoveOnPath(Mission.IJNFleet[9], Mission.IJNPaths[Mission.StartupPos][3])
		
		--scout minekaze
		NavigatorAttackMove(Mission.IJNFleet[10], Mission.SanFrancisco, {})
		TorpedoEnable(Mission.IJNFleet[10],true)
		NavigatorAttackMove(Mission.IJNFleet[11], Mission.SanFrancisco, {})
		TorpedoEnable(Mission.IJNFleet[11],true)
				
		--kezdeti, szumma threat meghatarozasa
		for idx,unit in pairs(this.UsShips) do
			this.UsMaxThreat = this.UsMaxThreat + unit.Threat
		end
		
-- RELEASE_LOGOFF  		luaLog("MaxTherat erteke kezdetben:  "..this.UsMaxThreat)
				
		AddProximityTrigger(Mission.FlagShip, "ProxiamityFlagshipEscape", "luaUS05FlagshipEscapeWarning", Mission.EscapePoint, 4000)	
				
-- IJN Flagship detected		
		AddListener("recon", "JapFlagshipDetected", {
					["callback"] = "luaUS05DetectedJapFlagShip",
					["entity"] = {Mission.FlagShip},
					["oldLevel"] = {}, 
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED},
					})
		luaUS05AddListeners()
		luaDelay(luaUS05JumpinHint,3)
		luaDelay(luaUS05CrosshairHint,20)
		
-- MissionPhase 2
	elseif this.MissionPhase == 2 and this.FirstRun == true then
		this.Phase2ThinkCounter = 0
		this.FirstRun = false
		
-- MissionPhase 3	
	elseif this.MissionPhase == 3 and this.FirstRun == true then
		this.FirstRun = false
		this.Phase3ThinkCounter = 0
		--generating chased japanese ship
		local generatedFubuki = GenerateObject(Mission.HiddenJapDestroyerTemplate.Name)
		Mission.Fubuki = generatedFubuki
		--SetGuiName(generatedFubuki, "Samidare")
		if Mission.StartupPos == "North" then
			PutTo(generatedFubuki, Mission.HiddenUsForcePostable[Mission.StartupPos][4],-100)
		end
		NavigatorAttackMove(generatedFubuki, luaPickRnd(Mission.UsShips),{})
		--generating us ships
		for i=1,3 do
			local ship = GenerateObject(Mission.HiddenUsForceTemplate[i].Name,Mission.UnitNames.Us.Hidden[i])
			--SetGuiName(ship,Mission.UnitNames.Us.Hidden[i])
			if IsClassChanged(ship.ClassID) then
				luaSetUnlockName(ship)
			end
			if Mission.StartupPos == "North" then
				PutTo(ship, Mission.HiddenUsForcePostable[Mission.StartupPos][i],-100)
			end
			table.insert(Mission.HiddenUsForce,ship)
			table.insert(Mission.UsShips,ship)
			if ship.Class.Type == "Cruiser" then
				Mission.MovieCruiser = ship
				ship.Threat = 3
				Mission.UsMaxThreat = Mission.UsMaxThreat + 3
				table.insert(Mission.UsCruisers,ship)
			else
				ship.Threat = 1
				Mission.UsMaxThreat = Mission.UsMaxThreat + 1
				table.insert(Mission.UsDestroyers,ship)
			end
			if IsListenerActive("exitzone", "ListenerUSShipExited") then
				RemoveListener("exitzone", "ListenerUSShipExited")
			end
			if IsListenerActive("kill", "ListenerUSShipKilled") then
				RemoveListener("kill", "ListenerUSShipKilled")
			end
			AddListener("exitzone", "ListenerUSShipExited", {
					["callback"] = "luaUS05USShipKilled",
					["entity"] = Mission.UsShips,
					["exited"] = {true}, -- false: entity entered exit zone, true: entity exited
					})		
					
			AddListener("kill", "ListenerUSShipKilled", {
					["callback"] = "luaUS05USShipKilled",
					["entity"] = Mission.UsShips,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
		end
		
		--Hidden formacio
		JoinFormation(Mission.HiddenUsForce[2], Mission.HiddenUsForce[1])
		JoinFormation(Mission.HiddenUsForce[3], Mission.HiddenUsForce[1])
		
-- RELEASE_LOGOFF  		luaLog("MaxThreat generalas utan:  "..Mission.UsMaxThreat)
		NavigatorMoveToRange(Mission.HiddenUsForce[1],luaRemoveDeadsFromTable(Mission.UsShips)[1])
		
		--dialogus erosites megerkezett
		local tDialogIDs = GetActDialogIDs()
		for i, pDialogID in pairs (tDialogIDs) do
			KillDialog(pDialogID)
		end
		luaStartDialog("reinforcement_arrives")
		if GetSelectedUnit() ~= nil then
			SetInvincible(GetSelectedUnit(), 0.2)
		end
		Mission.LastUsed = GetSelectedUnit()
		luaUS05EM_Hidden_Start()
	end
end

function luaUS05CheckConditions()
	--luaLog("checking conditions")
	luaUS05ThreatCheck()

--Mission Phase 2 Check
	if Mission.MissionPhase == 2 and not Mission.FirstRun then
		Mission.Phase2ThinkCounter = Mission.Phase2ThinkCounter + 1
		if GetHpPercentage(Mission.FlagShip) < 0.6 or Mission.Phase2ThinkCounter == Mission.Phase2Delay * 20 then
			--luaCheckpoint(1, nil)
			Mission.MissionPhase = 3
			Mission.FirstRun = true
		end
		if Mission.Phase2ThinkCounter == 2 then
			luaStartDialog("destroyers_detected")
		elseif Mission.Phase2ThinkCounter == 4 then
			luaObj_Add("primary",2)
			AddListener("recon", "JapMainShipsDetected", {
					["callback"] = "luaUS05DetectedJapMainShips",
					["entity"] = {FindEntity("South_Tone_1")},
					["oldLevel"] = {}, 
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED},
					})
		elseif Mission.Phase2ThinkCounter == 7 then
			luaObj_Add("secondary",1)
			luaDelay(luaUS05SecondaryDisplay,4)
		end
		
		if Mission.Phase2ThinkCounter > 4 and luaObj_GetSuccess("primary", 2) == nil then
			DisplayScores(1,0,"usn05.obj_p2","")
		end
	end

--Mission Phase 3 Check
	if Mission.MissionPhase == 3 and not Mission.FirstRun then
		Mission.Phase3ThinkCounter = Mission.Phase3ThinkCounter + 1
		if Mission.Phase3ThinkCounter == (Mission.HieiDelay/3) then
			luaUS05HieiGenerate()
		end
		
		if Mission.HieiState == 2 then --Hiei already detected
			if Mission.Hiei.Dead then
				Mission.HieiState = -1
				luaObj_Completed("primary",3)
				HideScoreDisplay(3,0)
				if math.floor(GameTime()) - Mission.HieiStartTime <= (Mission.HieiHiddenTimer * 60) then
					luaObj_Completed("hidden",1)
				else
					luaObj_Failed("hidden",1)
				end
				luaStartDialog("Hiei_killed")
				if luaObj_GetSuccess("primary",1) == true then
					Mission.EndMission = true
					Mission.HieiVictory = true
					local fakeship = luaPickRnd(Mission.UsShips)
					local actualhp = GetHpPercentage(fakeship)
					SetInvincible(fakeship, actualhp)
					SetWait(Mission,3)
					if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
						luaObj_Completed("secondary",1,true)
						--HideScoreDisplay(4,0)
					end
					SetWait(Mission,3)
					luaStartDialog("victory")
					return
				end
			else
				if GetHpPercentage(Mission.Hiei) < 0.6 and not Mission.HieiDamageWarning then
					Mission.HieiDamageWarning = true
					--dialogus Hiei damaged
				end	
			end
		end
	end
	
--IJN fleet count check
	if table.getn(Mission.IJNFleet) < 5 then
		--luaLog("IJN fleet in trouble!")
		for idx,unit in pairs(Mission.IJNFleet) do
			if unit.Class.Type == "Destroyer" then
				TorpedoEnable(unit,true)
-- RELEASE_LOGOFF  				luaLog("Torpedo enabled for: "..tostring(unit.Name))
			end
		end
	end

--Flagship Hp Display
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil and not Mission.FlagShip.Dead then
		Mission.FlagshipHull = math.floor(GetHpPercentage(Mission.FlagShip)*100)
		DisplayScores(2,0,"usn05.obj_p1", "usn05.obj_p1_display")
	end	

--Hiei Hp Display
	if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil and not Mission.Hiei.Dead then
		Mission.HieiHull = math.floor(GetHpPercentage(Mission.Hiei)*100)
		DisplayScores(3,0,"usn05.obj_p3", "usn05.obj_p3_display")
	end	
	
--Flagship moveonpath command refresh
	if not Mission.EndMission and not Mission.FlagShip.Dead and Mission.StartupPos then
		NavigatorStop(Mission.FlagShip)
		NavigatorMoveOnPath(Mission.FlagShip, Mission.IJNPaths[Mission.StartupPos][1])
	end
	
end

function luaUS05Victory()
	if Mission.HieiVictory == true then
		luaMissionCompletedNew(Mission.Hiei,"usn05.obj_missioncomplete")
	else
		luaMissionCompletedNew(Mission.FlagShip,"usn05.obj_missioncomplete")
	end
end

function luaUS05SecondaryDisplay()
	if Mission.EndMission then
		return
	else
		--DisplayScores(4,0,"usn05.obj_s1","usn05.obj_s1_display")
	end
end

function luaUS05MissionFailed(reason,target)
	for i=1,4 do
		HideScoreDisplay(i,0)
	end
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
	if reason == "shipslost" then
		luaMissionFailedNew(Mission.LastShip, "usn05.obj_missionfailed_shipslost")
	elseif reason == "flagshipexited" then
		luaMissionFailedNew(luaPickRnd(Mission.UsShips), "usn05.obj_missionfailed_flagshipescaped")
	end
end

function luaUS05ThreatCheck()
	Mission.UsActualThreat = 0	
	for idx,unit in pairs (Mission.UsShips) do
		Mission.UsActualThreat = Mission.UsActualThreat + unit.Threat
	end
end

function luaUS05JapanAI()
-- RELEASE_LOGOFF  	luaLog("******* J a p a n   A I   s t a r t *******")
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		--DD Threat list
		Mission.UsDestroyers = luaRemoveDeadsFromTable(Mission.UsDestroyers)
		if table.getn(Mission.UsDestroyers) ~= 0 then		
			local DDSortedByRange = luaSortByDistance(Mission.FlagShip, Mission.UsDestroyers)
			
			Mission.DDThreatList = {}
			for idx,unit in pairs(DDSortedByRange) do
				if luaGetDistance(Mission.FlagShip,unit) < Mission.DDThreatRange then
					table.insert(Mission.DDThreatList,unit)
				end
			end
-- RELEASE_LOGOFF  			luaLog("Kozel levo DDk ("..table.getn(Mission.DDThreatList)..")")
			--DD Torpedo warning
			if table.getn(Mission.DDThreatList) ~= 0 then 
				if luaGetDistance(Mission.DDThreatList[1],Mission.FlagShip) < 1100 then
					Mission.TorpedoDanger = true
-- RELEASE_LOGOFF  					luaLog("Torpedozas veszely!!! : "..tostring(Mission.DDThreatList[1].Name))
				end
			else
				Mission.TorpedoDanger = false
			end
		end
		--Optimal Cl target for torpedo
		Mission.TorpedoMatrix = {}
		for idx1,CLunit in pairs (Mission.UsCruisers) do
			for idx2,DDunit in pairs (Mission.JapDestroyers) do
				if luaGetDistance(DDunit, CLunit) < Mission.CLTorpedoRange then
					Mission.TorpedoMatrix[DDunit.ID] = CLunit.ID
				end
			end
		end
		
		--minden ciklusban letultjuk
		for idx,unit in pairs(Mission.JapDestroyers) do
			TorpedoEnable(unit,false)
		end
		
		if table.getn(Mission.TorpedoMatrix) ~= 0 then
-- RELEASE_LOGOFF  			luaLog("---Torpedo Matrix---")
-- RELEASE_LOGOFF  			luaLog(Mission.TorpedoMatrix)
-- RELEASE_LOGOFF  			luaLog("--------End---------")
			for idx,unit in pairs(Mission.TorpedoMatrix) do
				local attackerDD = tostring(idx)
				local targetCL = tostring(unit)
				if math.floor(GameTime()) - attackerDD.LastCommand > Mission.CommandPeriod then
					NavigatorAttackMove(attackerDD, targetCL,{})
					luaSetScriptTarget(attackerDD, targetCL)
					TorpedoEnable(attackerDD)
-- RELEASE_LOGOFF  					luaLog("Jap Torpedo against us Cruiser :::::::"..attackerDD.Name.." NavigatorAttackMove"..targetCL.Name)
					attackerDD.LastCommand = math.floor(GameTime())
				end
			end
		end
			
		if Mission.TorpedoDanger then
			for idx,unit in pairs(Mission.JapDestroyers) do
				if luaGetDistance(unit,Mission.DDThreatList[1]) < 1500 and (math.floor(GameTime()) - unit.LastCommand > Mission.CommandPeriod) then
					if unit.Role ~= "CLHunter" then
						SetFireTarget(unit,Mission.DDThreatList[1])
-- RELEASE_LOGOFF  						luaLog("Torpedo DANGER! ->>> "..unit.Name.." SetFireTarget "..Mission.DDThreatList[1].Name)
						unit.LastCommand = math.floor(GameTime())
						unit.Role = "DDHunter"
					end
				end
			end
		end
		
		if table.getn(Mission.DDThreatList) ~= 0 then
			for idx,unit in pairs(Mission.JapCruisers) do
				if math.floor(GameTime()) - unit.LastCommand > Mission.CommandPeriod then
					local targetShip = luaPickRnd(Mission.DDThreatList)
					SetFireTarget(unit, targetShip)
-- RELEASE_LOGOFF  					luaLog("Pirckrandom for Cruisers: ===== "..unit.Name.." SetFireTarget "..targetShip.Name)
					unit.LastCommand = math.floor(GameTime())
					unit.Role = "RandomTarget"
				end
			end
		end
	end
	luaDelay(luaUS05JapanAI,10)
-- RELEASE_LOGOFF  	luaLog("******* J a p a n   A I   e n d  *******")
end

function luaUS05AddListeners()
-- US CA HP warning
	Mission.UsShips = luaRemoveDeadsFromTable(Mission.UsShips)
	Mission.IJNFleet = luaRemoveDeadsFromTable(Mission.IJNFleet)
	local cruisers ={}
	if not Mission.SanFrancisco.Dead then
		table.insert(cruisers, Mission.SanFrancisco)
	end
	if not Mission.Atlanta.Dead then
		table.insert(cruisers, Mission.Atlanta)
	end
	if table.getn(cruisers) > 0 then
		AddListener("hpEvent", "damage_listener" , {
		           	["callback"] = "luaUS05SanFranciscoWarning",
	             	["entity"] = cruisers,
	           		["reason"] = {"damage"}, --„repair” eseten gyogyulasra szol
	                ["hp"] = 0.5,
	  				})
	end
	
-- USN ship exited
	AddListener("exitzone", "ListenerUSShipExited", {
				["callback"] = "luaUS05USShipKilled",
				["entity"] = Mission.UsShips,
				["exited"] = {true}, -- false: entity entered exit zone, true: entity exited
				})		
		
-- USN ship killed		
	AddListener("kill", "ListenerUSShipKilled", {
				["callback"] = "luaUS05USShipKilled",
				["entity"] = Mission.UsShips,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
	
-- IJN Flagship exited
	AddListener("exitzone", "ListenerFlagShipExited", {
				["callback"] = "luaUS05FlagShipExited",
				["entity"] = {Mission.FlagShip},
				["exited"] = {true}, -- false: entity entered exit zone, true: entity exited
				})		
	
	
-- Flagship Kill
	if Mission.CheckpointLoaded == true then 
		AddListener("kill", "ListenerFlagshipKilled", {
					["callback"] = "luaUS05FlagshipKilled",
					["entity"] = {Mission.FlagShip},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary", 1) == nil then
			luaObj_AddUnit("primary",1,Mission.FlagShip)
		end
	end
		
	for idx,unit in pairs(Mission.IJNFleet) do
		if unit.Class.Type == "Destroyer" then			
			if Mission.TorpedoEnableCount < Mission.MaxTorpedoEnable and luaRnd(1,2) == 1 then
				TorpedoEnable(unit,true)
-- RELEASE_LOGOFF  				luaLog("Torpedo ON ->>>> "..tostring(unit.Name))
				Mission.TorpedoEnableCount = Mission.TorpedoEnableCount + 1
			end
		end
	end
		
	luaUS09FlagshipDangerCheck()
end

function luaUS05DetectedJapFlagShip()
-- RELEASE_LOGOFF  	luaLog("Flagship Detected!")
	if IsListenerActive("recon", "JapFlagshipDetected") then
		RemoveListener("recon", "JapFlagshipDetected")
	end
	--dialogus flagship detected
	luaStartDialog("flagship_detected")
	--[[
	if not Mission.Kingfisher.Dead then
		PilotMoveToRange(Mission.Kingfisher,GetPosition(Mission.Kingfisher))
	end
	]]
	AddListener("kill", "ListenerFlagshipKilled", {
				["callback"] = "luaUS05FlagshipKilled",
				["entity"] = {Mission.FlagShip},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
end

function luaUS05DetectedJapMainShips()
	if IsListenerActive("recon", "JapMainShipsDetected") then
		RemoveListener("recon", "JapMainShipsDetected")
	end
	local tDialogIDs = GetActDialogIDs()
	for i, pDialogID in pairs (tDialogIDs) do
		KillDialog(pDialogID)
	end
	luaStartDialog("mainforce_detected")
	if GetSelectedUnit() ~= nil then
		SetInvincible(GetSelectedUnit(), 0.2)
	end
	Mission.LastUsed = GetSelectedUnit()
	luaUS05EM_Fleet_Start()
end

function luaUS05P2CompleteDelay()
	if Mission.EndMission then
		return
	else
		luaObj_Completed("primary",2,true)
		HideScoreDisplay(1,0)
	end
	luaDelay(luaUS05Hint_Tropedo,15)
end

function luaUS05HieiGenerate()
	Mission.Hiei = GenerateObject(Mission.HieiTemplate.Name,"Hiei")
	--SetGuiName(Mission.Hiei,"Hiei")
	if Mission.StartupPos == "North" then
		PutTo(Mission.Hiei, GetPosition(Mission.NavHieiNorth), -120)
	end
	
	Mission.HieiState = 1
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.UsShips))
	NavigatorAttackMove(Mission.Hiei, trg,{})
	SetFireTarget(Mission.Hiei,Mission.HiddenUsForce[1])
	luaSetScriptTarget(Mission.Hiei, trg)
					
	AddListener("recon", "HieiIdentified", {
					["callback"] = "luaUS05HieiIdentified",
					["entity"] = {Mission.Hiei},
					["oldLevel"] = {}, 
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED},
					})
					
		luaUS05HieiTargetManager()
end 

function luaUS05HieiIdentified()
	if IsListenerActive ("recon", "HieiIdentified") then
		RemoveListener("recon", "HieiIdentified")
	end
	local tDialogIDs = GetActDialogIDs()
	for i, pDialogID in pairs (tDialogIDs) do
		KillDialog(pDialogID)
	end
	luaStartDialog("Hiei_detected")
	if GetSelectedUnit() ~= nil then
		SetInvincible(GetSelectedUnit(), 0.2)
	end
	Mission.LastUsed = GetSelectedUnit()
	luaUS05EM_Hiei_Start()
	Mission.HieiState = 2
	luaObj_Add("hidden",1)
	luaDelay(luaUS05HieiHint,30)
	Mission.HieiStartTime = math.floor(GameTime())
	--luaObj_AddReminder("primary",3,Mission.Primary3RemindCount)
	
end

function luaUS05HieiTargetManager()
	if Mission.EndMission then
		return
	else
		if not Mission.Hiei.Dead and (not luaGetScriptTarget(Mission.Hiei) or luaGetScriptTarget(Mission.Hiei).Dead) then
			local newtarget = luaGetNearestUnitFromTable(Mission.Hiei, Mission.UsShips)
			NavigatorAttackMove(Mission.Hiei, newtarget, {})
			luaSetScriptTarget(Mission.Hiei, newtarget)
		end
		luaDelay(luaUS05HieiTargetManager,5)
	end
end

function luaUS05RetreatStart()
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNFleet)) > 0 then
		--dialogus IJN retreating
		luaStartDialog("japs_retreating")
		SetWait(Mission,5)
		--retreat kell
		for idx,unit in pairs (Mission.IJNFleet) do
			LeaveFormation(unit)
			NavigatorMoveToPos(unit,Mission.NavJapEscape)
		end
	end
end

function luaUS05FlagshipKilled()
	if IsListenerActive("kill","ListenerFlagshipKilled") then
		RemoveListener("kill","ListenerFlagshipKilled")
	end
	luaStartDialog("flagship_killed")
	luaObj_Completed("primary",1,true)
	luaDelay(luaUS05AddPowerup,3)
	MissionNarrative("usn05.obj_p1_success")
	HideScoreDisplay(2,0)
	if luaObj_GetSuccess("primary",3) == true then
		Mission.EndMission = true
		local fakeship = luaPickRnd(Mission.UsShips)
		local actualhp = GetHpPercentage(fakeship)
		SetInvincible(fakeship, actualhp)
		SetWait(Mission,3)
		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			luaObj_Completed("secondary",1)
			--HideScoreDisplay(4,0)
		end
		SetWait(Mission,3)
		luaStartDialog("victory")
	end
	--luaUS05RetreatStart()
end

function luaUS05MissionWin()

end
function luaUS05AddPowerup()
	AddPowerup({
				["classID"] = "hardened_armour",
				["useLimit"]	 = 1,
				})
end

function luaUS05USShipKilled(killedship)
	killedship.Dead = true
	Mission.UsShips = luaRemoveDeadsFromTable(Mission.UsShips)
	Mission.LostUSShips = Mission.LostUSShips + 1
	if Mission.LostUSShips > Mission.LostUSShipsLimit then
		Mission.LostUSShips = Mission.LostUSShipsLimit
	end
	if luaObj_GetSuccess("secondary",1) == nil then
		--DisplayScores(4,0,"usn05.obj_s1","usn05.obj_s1_display")
	end
	if Mission.LostUSShips == 3 and luaObj_GetSuccess("secondary",1) == nil then
		luaUS05FleetWarning()
	elseif Mission.LostUSShips == Mission.LostUSShipsLimit and luaObj_GetSuccess("secondary",1) == nil then
		luaObj_Failed("secondary",1)
		MissionNarrative("usn05.obj_s1_failed")
		--HideScoreDisplay(4,0)
	end
		
	if table.getn(Mission.UsShips) == 0 then
		Mission.LastShip = killedship
		if IsListenerActive("kill","ListenerUSShipKilled") then
			RemoveListener("kill","ListenerUSShipKilled")
		end
		if IsListenerActive("exitzone", "ListenerUSShipExited") then
			RemoveListener("exitzone", "ListenerUSShipExited")
		end
		Mission.EndMission = true
		luaUS05MissionFailed("shipslost")
		return
	end
end

function luaUS05FlagShipExited()
	if IsListenerActive("exitzone", "ListenerFlagShipExited") then
		RemoveListener("exitzone", "ListenerFlagShipExited")
	end
	Mission.EndMission = true
	luaUS05MissionFailed("flagshipexited")
	return
end

function luaUS05AiTorpedoSuccessfull(target,device,attacker)
-- RELEASE_LOGOFF  	luaLog("TORPEDO HIT on  "..tostring(target.Name).."  by  "..tostring(attacker.Name))
	
end

function luaUS09FlagshipDangerCheck()
	Mission.IJNFleet = luaRemoveDeadsFromTable(Mission.IJNFleet)
	if not Mission.SanFrancisco.Dead and not Mission.FlagShip.Dead then
		if not Mission.SanFrancisco.Dead and luaGetDistance(Mission.FlagShip,Mission.SanFrancisco) < 2000 then
			for idx,unit in pairs(Mission.IJNFleet) do
				SetFireTarget(unit, Mission.SanFrancisco)
			end
		elseif not Mission.Atlanta.Dead and luaGetDistance(Mission.FlagShip,Mission.Atlanta) < 2000 then
			for idx,unit in pairs(Mission.IJNFleet) do
				SetFireTarget(unit, Mission.Atlanta)
			end
		end
		luaDelay(luaUS09FlagshipDangerCheck,15)
	end
end

function luaUS05Phase()
	if Mission.MissionPhase == 2 then
		luaUS05DetectedJapFlagShip()
		SetWait(Mission,2)
		AddDamage(Mission.FlagShip,3500)
	end
end

function luaUS05FlagshipObjective()
	if Mission.EndMission then 
		return
	else
		luaObj_Add("primary",1,Mission.FlagShip)
		--luaObj_AddReminder("primary",1,Mission.Primary1RemindCount)
	end
	luaDelay(luaUS05PowerupDelayed,6)
	luaDelay(luaUS05OutnumberedWarning,20)
end

function luaUS05PowerupDelayed()
	if Mission.EndMission then
		return
	else
		if not Mission.CheckpointLoaded then
			AddPowerup({
				["classID"] = "improved_repair_team",
				["useLimit"]	 = 1,
				})
		end
	end
end
function luaUS05CrosshairHint()
	if not Mission.CrosshairHintShowed then
		Mission.CrosshairHintShowed = 0
	end
	ShowHint("Advanced_Hint_Crosshair")
	Mission.CrosshairHintShowed = Mission.CrosshairHintShowed + 1
	if Mission.CrosshairHintShowed < 3 then
		luaDelay(luaUS05CrosshairHint,180)
	end
end

function luaUS05OutnumberedWarning()
	ShowHint("USN05_Hint_Outnumbered")
end

function luaUS05JumpinHint()
	if not Mission.JumptoHintShowed then
		Mission.JumptoHintShowed = 0
	end
	ShowHint("Advanced_Hint_Jumptounit")
	Mission.JumptoHintShowed = Mission.JumptoHintShowed + 1
	if Mission.JumptoHintShowed < 3 then
		luaDelay(luaUS05JumpinHint,180)
	end
end

function luaUS05SanFranciscoWarning()
	if IsListenerActive("hpEvent", "damage_listener") then
		RemoveListener("hpEvent", "damage_listener")
	end
	ShowHint("USN05_Hint_SanFrancisco_Warning")
end

function luaUS05FleetWarning()
	ShowHint("USN05_Hint_FleetWarning")
end

function luaUS05Hint_Tropedo()
	ShowHint("USN05_Hint_Torpedo")
end

function luaUS05HieiHint()
	ShowHint("USN05_Hint_HieiKill")
end

function luaUS05FlagshipEscapeWarning()
	RemoveTrigger(Mission.FlagShip,"ProximityFlagshipEscape")
	ShowHint("USN05_Hint_FlagshipEscaping")
end

function luaUS05HieiObjective()
	luaObj_Add("primary",3,Mission.Hiei)
end

--[[
*****************************************************************************************
**                         		INGAME ENGINE MOVIES                                   **
*****************************************************************************************
]]
function luaUS05EM_Fleet_Start()
	Blackout(true, "luaUS05EM_Fleet", 0.5)
end

function luaUS05EM_Fleet()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = FindEntity("South_Akizuki_1"), ["distance"] = 200, ["theta"] = 40, ["rho"] = 30, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("South_Akizuki_1"), ["distance"] = 200, ["theta"] = 14, ["rho"] = 80, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("South_Tone_1"), ["distance"] = 230, ["theta"] = 10, ["rho"] = 80, ["moveTime"] = 9, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("South_Tone_1"), ["distance"] = 130, ["theta"] = 5, ["rho"] = 6, ["moveTime"] = 7, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			    },
    			luaUS05EM_Fleet_Fade
				)
end

function luaUS05EM_Fleet_Fade()
	Blackout(true, "luaUS05EM_Fleet_End", 0.5)
end

function luaUS05EM_Fleet_End()
	if Mission.LastUsed ~= nil and not Mission.LastUsed.Dead then
		SetSelectedUnit(Mission.LastUsed)
		SetInvincible(Mission.LastUsed,false)
		EnableInput(true)
	else
		SetSelectedUnit(luaPickRnd(Mission.UsShips))
		EnableInput(true)
	end
	Blackout(false, "", 0.5)
	luaDelay(luaUS05P2CompleteDelay,3)
end

function luaUS05EM_Hidden_Start()
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		Blackout(true, "luaUS05_CheckpointSave", 0.5)
	else
		Blackout(true, "luaUS05EM_Hidden", 0.5)
	end
end

function luaUS05_CheckpointSave()
	--luaCheckpoint(1, nil)
	luaUS05EM_Hidden()
end


function luaUS05EM_Hidden()
	Blackout(false, "", 1)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.MovieCruiser, ["distance"] = 240, ["theta"] = 23, ["rho"] = 143, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.MovieCruiser, ["distance"] = 210, ["theta"] = 16, ["rho"] = 145, ["moveTime"] = 3.5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "target", ["target"] = Mission.Fubuki, ["moveTime"] = 3, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Fubuki, ["distance"] = 260, ["theta"] = 14, ["rho"] = 145, ["moveTime"] = 7.5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			    },
    			luaUS05EM_Hidden_Fade
				)
end

function luaUS05EM_Hidden_Fade()
	Blackout(true, "luaUS05EM_Hidden_End", 0.5)
end

function luaUS05EM_Hidden_End()
	if Mission.LastUsed ~= nil and not Mission.LastUsed.Dead then
		SetSelectedUnit(Mission.LastUsed)
		SetInvincible(Mission.LastUsed,false)
		EnableInput(true)
	else
		SetSelectedUnit(luaPickRnd(Mission.UsShips))
		EnableInput(true)
	end
	Blackout(false, "", 0.5)
end

function luaUS05EM_Hiei_Start()
	Blackout(true, "luaUS05EM_Hiei", 0.5)
end

function luaUS05EM_Hiei()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Hiei, ["distance"] = 100, ["theta"] = 1, ["rho"] = 5, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Hiei, ["distance"] = 110, ["theta"] = 1, ["rho"] = 3, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Hiei, ["distance"] = 200, ["theta"] = 5, ["rho"] = 3, ["moveTime"] = 13, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			    },
    			luaUS05EM_Hiei_Fade
				)
end

function luaUS05EM_Hiei_Fade()
	Blackout(true, "luaUS05EM_Hidden_End", 0.5)
end

function luaUS05EM_Hiei_End()
	if Mission.LastUsed ~= nil and not Mission.LastUsed.Dead then
		SetSelectedUnit(Mission.LastUsed)
		SetInvincible(Mission.LastUsed,false)
		EnableInput(true)
	else
		SetSelectedUnit(luaPickRnd(Mission.UsShips))
		EnableInput(true)
	end
	Blackout(false, "", 0.5)
end

function luaName()
-- RELEASE_LOGOFF  	luaLog("................JAP HAJOK..................")
	for idx,unit in pairs(luaGetOwnUnits("ship",PARTY_JAPANESE)) do
-- RELEASE_LOGOFF  		luaLog("Jap hajo >>>>>    "..tostring(unit.Name).."  ///  "..tostring(GetGuiName(unit)))
	end
-- RELEASE_LOGOFF  	luaLog("...................OVER.....................")
-- RELEASE_LOGOFF  	luaLog("................AMCSI HAJOK..................")
	for idx,unit in pairs(luaGetOwnUnits("ship",PARTY_ALLIED)) do
-- RELEASE_LOGOFF  		luaLog("Jap hajo >>>>>    "..tostring(unit.Name).."  ///  "..tostring(GetGuiName(unit)))
	end
-- RELEASE_LOGOFF  	luaLog("...................OVER.....................")
end

--[[
*****************************************************************************************
**                         			  CHECKPOINT FUNCTIONS							   **
*****************************************************************************************
]]
function luaUS05Cp1SaveMissionData()
-- RELEASE_LOGOFF  	luaLog("checkpoint tabla hossza: "..table.getn(Mission.Checkpoint))
	Mission.Checkpoint.StartupPos = Mission.StartupPos
	Mission.Checkpoint.LostUSShips = Mission.LostUSShips
-- RELEASE_LOGOFF  	luaLog("checkpoint tabla hossza: "..table.getn(Mission.Checkpoint))
end

function luaUS05Cp1LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	Mission.StartupPos = Mission.Checkpoint.StartupPos
	Mission.LostUSShips = Mission.Checkpoint.LostUSShips
	
	if Mission.StartupPos == "South" then
		Mission.EscapePoint = Mission.NavSouthEscape
	elseif Mission.StartupPos == "Center" then
		Mission.EscapePoint = Mission.NavCenterEscape
	elseif Mission.StartupPos == "North" then
		Mission.EscapePoint = Mission.NavNorthEscape
	end
	
end

function luaUS05RecoverShips()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]
	local usnsaved = luaGetCheckpointData("Units", "USUnits")
	local ijnsaved = luaGetCheckpointData("Units", "JapUnits")
	local usn = luaGetOwnUnits(nil, PARTY_ALLIED)
	local ijn = luaGetOwnUnits(nil, PARTY_JAPANESE)
	for idx,unit in pairs(usn) do
		local found = false
		for idx2,unitTbl in pairs(usnsaved[1]) do
			if unit.Name == unitTbl[1] then
				EntityTurnToPosition(unit, GetPosition(Mission.NavHieiSpawn))
				if unitTbl[4] and unitTbl[4] >= 0 then
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog("Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end
	for idx,unit in pairs(ijn) do
		local found = false
		for idx2,unitTbl in pairs(ijnsaved[1]) do
			if unit.Name == unitTbl[1] then
				EntityTurnToPosition(unit, GetPosition(Mission.EscapePoints[Mission.StartupPos][1]))
				if unitTbl[4] and unitTbl[4] >= 0 then
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog("Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end
	
	NavigatorMoveOnPath(Mission.IJNFleet[3], Mission.IJNPaths[Mission.StartupPos][1])
	NavigatorMoveOnPath(Mission.IJNFleet[6], Mission.IJNPaths[Mission.StartupPos][2])
	NavigatorMoveOnPath(Mission.IJNFleet[9], Mission.IJNPaths[Mission.StartupPos][3])
	luaDelay(luaUS05DelayBlackout,2)
end

function luaUS05DelayBlackout()
	Blackout(false, "", 1.5)
end

function luaUS05RelocateShips()
	PutTo(Mission.UsCruisers[1],GetPosition(Mission.CheckpointShipPos_US[1]),77)
	PutTo(Mission.UsCruisers[2],GetPosition(Mission.CheckpointShipPos_US[2]),77)
	
	PutTo(Mission.IJNFleet[3],GetPosition(Mission.CheckpointShipPos_IJN[Mission.StartupPos][1]),77)
	PutTo(Mission.IJNFleet[6],GetPosition(Mission.CheckpointShipPos_IJN[Mission.StartupPos][2]),77)
	PutTo(Mission.IJNFleet[9],GetPosition(Mission.CheckpointShipPos_IJN[Mission.StartupPos][3]),77)
	
	luaUS05RecoverShips()
end

function luaUS05IsLeaderRegistered(lname)
	for idx,tbl in pairs(Mission.ChckFormation) do
		if idx == lname then
			return true
		end
	end
	return false
end

function luaUS05PhaseManager()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if num[1] == 1 then
		Mission.MissionPhase = 3
		AddProximityTrigger(Mission.FlagShip, "ProxiamityFlagshipEscape", "luaUS05FlagshipEscapeWarning", Mission.EscapePoint, 4000)
		luaUS05AddListeners()
		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			luaDelay(luaUS05SecondaryDisplay,2)
		end
		luaDelay(luaUS05RelocateShips,1)
	end
end

function luaUS05SetChangeableGUIName(unit)
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
--[[
*****************************************************************************************
**                         			  PRECACHE										   **
*****************************************************************************************
]]
function luaPrecacheUnits()
	Loading_Start()
	--PrepareClass(116) --B-17 powerup
	--PrepareClass(167) --Betty
	Loading_Finish()
end