--SceneFile="missions\USN\usn_09_Leyte.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--todo: kulon faziskent kezelni a PT boatokat
--todo: raiden jojjon

function luaEngineMovieInit()
	SetSimplifiedReconMultiplier(0.1)
	ArtilleryEnable(FindEntity("Fortress1"),false)
	ArtilleryEnable(FindEntity("Fortress2"),false)
	ArtilleryEnable(FindEntity("Fortress3"),false)
	Music_Control_SetLevel(MUSIC_CALM)
	EnableMessages(false)
	--MessageMap betoltese
	LoadMessageMap("usn09dlg",1)
	Dialogues = {
		["intro1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
			},
		},
		["intro2"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07b",
				},
				{
					["message"] = "dlg07c",
				},
			},
		},
	}
	MissionNarrative("usn09.date_location")
	luaDelay(luaUSN09_Dialog_Intro1, 20)
	luaDelay(luaUSN09_EM_Hack_AAEnable,40)
end

function luaUSN09_EM_Hack_AAEnable()
	SetSimplifiedReconMultiplier(0.5)
	AAEnable(FindEntity("Atlanta-class 01"), true)
	AAEnable(FindEntity("deadcv"), true)
end

function luaUSN09_Dialog_Intro1()  
	StartDialog("intro1", Dialogues["intro1"])
	luaDelay(luaUSN09_MusicSetToAction,20)
	luaDelay(luaUSN09_Dialog_Intro2,20)
end

function luaUSN09_Dialog_Intro2()
	StartDialog("intro2", Dialogues["intro2"])
end

function luaUSN09_MusicSetToAction()
	Music_Control_SetLevel(MUSIC_ACTION)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitUS09")
	Scoring_RealPlayTimeRunning(true) 
end

function luaInitUS09(this)
	Mission = this
	this.Name = "US09"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_09_Leyte.lua"

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	this.MissionPhase = 1
	this.FirstRun = true
	Blackout(true,"",0)
	ForceRecon()
	
    -- allied hajok
	this.Atlanta = FindEntity("Atlanta-class 01")
	this.StLo = FindEntity("USS St. Lo")
	this.KalininBay = FindEntity("USS Kalinin Bay")
	this.GambierBay = FindEntity("USS Gambier Bay")
	
	luaSetUnlockName(FindEntity("Atlanta-class 01"))
	
	this.CVs = {}
		table.insert(this.CVs, this.StLo) -- Hellcat
		table.insert(this.CVs, this.KalininBay) --Avenger
		table.insert(this.CVs, this.GambierBay) --Helldiver
	
	this.KamikazeTargets = {}
		table.insert(this.KamikazeTargets, this.KalininBay)
		table.insert(this.KamikazeTargets, this.GambierBay)
		
	this.DeadCV = FindEntity("deadcv")
	this.AttackingPlanes = {}
				
	-- allied repcsik
	this.FakeUSFighters = {}
	this.HellcatTemplate = luaFindHidden("HellcatTemplate")
			
	-- allied pathok, nav pontok
	this.NavInitial = FindEntity("NavInitial")
	this.PathStLo = FindEntity("PathStLo")
	this.PathGambier = FindEntity("PathGambier")
	this.PathKalinin = FindEntity("PathKalinin")
	this.PathAtlanta = FindEntity("PathAtlanta")
	-- checkpoint pontok
	this.NavCp1_Atlanta = FindEntity("NavCp1_Atlanta")
	this.NavCp1_StLo = FindEntity("NavCp1_StLo")
	this.NavCp1_GambierBay = FindEntity("NavCp1_GambierBay")
	this.NavCp1_KalininBay = FindEntity("NavCp1_KalininBay")
	
	this.NavCp2_Atlanta = FindEntity("NavCp2_Atlanta")
	this.NavCp2_StLo = FindEntity("NavCp2_StLo")
	this.NavCp2_GambierBay = FindEntity("NavCp2_GambierBay")
	this.NavCp2_KalininBay = FindEntity("NavCp2_KalininBay")
	
	-- japanese unitok
	this.Junk = FindEntity("Junk 01")
	this.JunkPath = FindEntity("PathTraffic1")
	this.Gekkos = {}
	this.MoviePTHangar = FindEntity("PTHangar 03")
	this.PTHangars = {}
		table.insert(this.PTHangars,FindEntity("PTHangar 01"))
		table.insert(this.PTHangars,FindEntity("PTHangar 02"))
		table.insert(this.PTHangars,FindEntity("PTHangar 03"))
	
	this.FakeJapFighters = {}
	this.Kamikaze1 = FindEntity("Kamikaze1")
	this.Kamikaze2 = FindEntity("Kamikaze2")
	this.Kamikaze3 = FindEntity("Kamikaze3")
	this.CenterShipyard = FindEntity("Shipyard_Center")
	this.EastShipyard = FindEntity("Shipyard_North")
	this.SouthShipyard = FindEntity("Shipyard_South")
	this.CenterShipyard.Spawn = GetPosition(FindEntity("SpawnPos_Center"))
	this.EastShipyard.Spawn = GetPosition(FindEntity("SpawnPos_East"))
	this.SouthShipyard.Spawn = GetPosition(FindEntity("SpawnPos_South"))
	this.Shipyards = {}
		table.insert(this.Shipyards,this.CenterShipyard)
		table.insert(this.Shipyards,this.EastShipyard)
		table.insert(this.Shipyards,this.SouthShipyard)
	this.ShipyardsRemaining = table.getn(this.Shipyards)
	
	this.MusashiTemplate = luaFindHidden("MusashiTemplate")
	this.FubukiTemplate = luaFindHidden("FubukiTemplate")
	this.Airfield = FindEntity("AirField 01")
	this.Hangar = FindEntity("Hangar")
	this.Fortresses = {}
		table.insert(this.Fortresses, FindEntity("Fortress1"))
		table.insert(this.Fortresses, FindEntity("Fortress2"))
		table.insert(this.Fortresses, FindEntity("Fortress3"))
		
	this.JapPts = {}
	this.Shindens = {}
		
	-- japanese objektumok
	this.Turrets = {}
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 01"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 02"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 03"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 04"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 05"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 06"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 07"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 08"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 09"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 10"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 11"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 12"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 13"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 14"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 15"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 16"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 17"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 18"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 19"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 20"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 21"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 22"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 23"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 24"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 25"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 26"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 27"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 28"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 29"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 30"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 31"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 32"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 33"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 34"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 35"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 36"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 37"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 38"))
		table.insert(this.Turrets, FindEntity("Heavy AA, Japanese 39"))
		table.insert(this.Turrets, FindEntity("Light AA, Japanese 01"))
		table.insert(this.Turrets, FindEntity("Coastal Gun, Japanese 01"))
		table.insert(this.Turrets, FindEntity("Coastal Gun, Japanese 02"))
	-- japanese pathok, nav pontok
	this.NavGekko = FindEntity("NavGekko")
	this.NavMusashi= FindEntity("NavMusashi")
	this.PathMusashi = FindEntity("PathMusashi")
	this.NavMusashiColose1 = FindEntity("NavMusashiColose1")
	this.NavMusashiColose2 = FindEntity("NavMusashiColose2")
	this.ShindenPosTable = {}
		table.insert(Mission.ShindenPosTable,GetPosition(FindEntity("NavShindenSouth")))
		table.insert(Mission.ShindenPosTable,GetPosition(FindEntity("NavShindenEast")))
		table.insert(Mission.ShindenPosTable,GetPosition(FindEntity("NavShindenNorth")))
	
	this.KamikazeTemplates = {}
		table.insert(this.KamikazeTemplates, luaFindHidden("KamikazeTemplate1"))
		table.insert(this.KamikazeTemplates, luaFindHidden("KamikazeTemplate2"))
		table.insert(this.KamikazeTemplates, luaFindHidden("KamikazeTemplate3"))
	
	this.Phase1GekkoTemplates = {}
		table.insert(this.Phase1GekkoTemplates, luaFindHidden("Phase1GekkoTemplate1"))
		table.insert(this.Phase1GekkoTemplates, luaFindHidden("Phase1GekkoTemplate2"))
		
	this.Phase2GekkoTemplates = {}
		table.insert(this.Phase2GekkoTemplates, luaFindHidden("Phase2GekkoTemplate1"))
		table.insert(this.Phase2GekkoTemplates, luaFindHidden("Phase2GekkoTemplate2"))
		table.insert(this.Phase2GekkoTemplates, luaFindHidden("Phase2GekkoTemplate3"))
		
	this.ZeroTemplate = luaFindHidden("ZeroTemplate")
	this.BettyTemplate = luaFindHidden("BettyTemplate")
	this.PTTemplate = luaFindHidden("PTTemplate")
	
	-- Misc valtozok
	this.ShipyardLimit = 5
	this.JapShipSpawnInterval = 40
	this.LastShipyardSpawned = 1
	this.AirfieldTimer = 120 --ennyi ido mulva kezd kuldeni repcsit az airfield masodpercben
	this.TravelAlt = 20 --override-olt repulesi magassag minden gep szamara
	this.AttackAlt = 20	--override-olt tamadasi magassag minden gep szamara
	this.StockCounter = 0
	this.RepairCycleTimer = 3 --ennyi percenkent javitodik vissza egy AA a Musashin
	this.Distance = 9999
	this.MPStoKTS = 1.94			-- 1 m/s = 1.94 knots
	this.DistanceWarning = 0
	this.AirfieldEnrageTime = 5 --airfield megtalalasa utan ennyi percel kezdenek durvulni a kamikazek
	this.AirfieldEnrage = false
	this.CVManagerRunning = false
	this.MaxTurretNum = table.getn(Mission.Turrets)
	this.TurretsKilled = 0
	this.KilledShipyardNum = 0
		
	-- Teszt valtozok
		
	-- Support Manager tiltas
	
	--reload enable
	SetDeviceReloadEnabled(true)
	SetDeviceReloadTimeMul(1.8)
	
	-- Achievements init
	

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	-- objektivak
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "CarrierSurvive",		-- azonosito
				["Text"] = "usn09.obj_p1",
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
				["ID"] = "DestroyHangars",		-- azonosito
				["Text"] = "usn09.obj_p2",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "DestroyMusashi",		-- azonosito
				["Text"] = "usn09.obj_p3",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[4] =
			{
				["ID"] = "DestroyAirfield",		-- azonosito
				["Text"] = "usn09.obj_p4",
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
				["ID"] = "KillFortresses",		-- azonosito
				["Text"] = "usn09.obj_h1",
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
				["ID"] = "KillTurrets",		-- azonosito
				["Text"] = "usn09.obj_s1",
				["TextCompleted"] = "usn09.obj_s1_coplete" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
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
	LoadMessageMap("usn09dlg",1)

	Mission.Dialogues = {
		["pt_warning"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
				{
					["message"] = "dlg01c",
				},
			},
		},
		["airfield_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
				{
					["message"] = "dlg02b",
				},
			},
		},
		["airfield_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["musashi_detected"] = {
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
		["musashi_halfway"] = {
			["sequence"] = {
				--szandekos a sorrend: a, d, b, c
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05d",
				},
				{
					["message"] = "dlg05b",
				},
				{
					["message"] = "dlg05c",
				},
			},
		},
		["musashi_curve"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
			},
		},
		["kamikaze_attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07b",
				},
				{
					["message"] = "dlg07c",
				},
			},
		},
		["kamikaze_hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
				{
					["message"] = "dlg08b_1",
				},
				{
					["message"] = "dlg08c",
				},
			},
		},
		["musashi_veryclose"] = {
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
			},
		},
		["musashi_firing"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["first_base_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["all_bases_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["musashi_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
			},
		},
		["raiden_attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["victory"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["message"] = "dlg15_1",
				},
				{	["type"] = "callback",
					["callback"] = "luaUS09MissionEnd"
				},
			},
		},
}	
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()

    --SetDeviceReloadTimeMul(0)
    SetThink(this, "US09Think")
		
	--powerup init
	
	--recon nerf
	SetSimplifiedReconMultiplier(0.50)
	
	--Support manager ban
	BannSupportmanager()
	
	--kezdeti tiltasok, formaciok
	NavigatorSetAvoidAllShipCollision(false)
	--CV tiltas
	for idx,unit in pairs (Mission.CVs) do
		if DEMO_2009_JAN then
			--CVk elitre allitva, hogy lelojek a kamikat
			SetSkillLevel(unit,SKILL_ELITE)
		end
		NavigatorSetAvoidShipCollision(unit,false)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetShipMaxSpeed(unit, 8)
		AAEnable(unit, true)
	end
	SetRoleAvailable(Mission.DeadCV, EROLF_ALL, PLAYER_AI)
	
	--cheat invincible
	--SetInvincible(Mission.StLo, true)
	
	--Atlanta tiltas
	SetRoleAvailable(Mission.Atlanta, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Atlanta, EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.Atlanta, PCF_NONE+PCF_TARGET)
	SetShipMaxSpeed(Mission.Atlanta, 8)
	--SetSelectedUnit(Mission.Atlanta)
	AAEnable(Mission.Atlanta,true)
	ForceEnableInput(IC_OVERLAY_BLUE,false)
	ForceEnableInput(IC_CMD_MAP_CLEARTARGET,false)
	
	--fortress tiltas
	for idx,unit in pairs(Mission.Fortresses) do
		ArtilleryEnable(unit, false)
	end
	
	-- turrets to untouchable units
	for idx,unit in pairs(Mission.Turrets) do
		AddUntouchableUnit(unit)
		unit.TurretFlag = 1
	end
	AddListener("kill","TurretKill", {
					["callback"] = "luaUS09TurretKilled",
					["entity"] = Mission.Turrets,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})
	
	AddListener("hit", "AchievementlistenerID", {
		["callback"] = "luaUS09AchievementListener", -- callback fuggveny
		["target"] = {this.Atlanta, this.StLo, this.KalininBay, this.GambierBay}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"KAMIKAZE"}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})	
	
	--Init Functions
	Effect("RealGiantSmoke", {["x"]=-671,["y"]=1, ["z"]=-2987.5},Mission.DeadCV, 2)

	--HP override Shipyardoknak es kezdeti invincible
	for idx,unit in pairs(Mission.Shipyards) do
		OverrideHP(unit, 1000)
	end
	for idx,unit in pairs(Mission.PTHangars) do
		OverrideHP(unit, 1000)
	end
	for idx,unit in pairs(Mission.Fortresses) do
		OverrideHP(unit, 2000)
	end
	
	--Ship control hint disabled for demo
	if DEMO_2009_JAN then
		AddStoredHint("BASICSHIP")
		AddStoredHint("BASICSHIP2")
	end
	--Difficulty settings
	if Mission.Difficulty == 0 then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Turrets)) do
			SetSkillLevel(unit,SKILL_STUN)
		end
		Mission.ShipSkillLevel = SKILL_STUN
		Mission.ShipyardLimit = 4
	elseif Mission.Difficulty == 1 then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Turrets)) do
			SetSkillLevel(unit,SKILL_STUN)
		end
		Mission.ShipSkillLevel = SKILL_SPNORMAL
		Mission.ShipyardLimit = 5
	elseif Mission.Difficulty == 2 then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Turrets)) do
			SetSkillLevel(unit,SKILL_SPNORMAL)
		end
		Mission.ShipSkillLevel = SKILL_SPNORMAL
		Mission.ShipyardLimit = 6
	end
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS09Cp1_Reposition, luaUS09Cp1_KillPlanes, luaUS09KamikazeManager, luaUS09ReplaceTurrets},
		[2] = {luaUS09Cp2_Reposition, luaUS09Cp2_KillShipyards, luaUS09ReplaceTurrets},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS09SaveMissionData},
		[2] = {luaUS09SaveMissionData},
	}
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == true then
		EnableMessages(true)
		--Orded menu visszaallitas
		ForceEnableInput(IC_OVERLAY_BLUE,true)
		ForceEnableInput(IC_CMD_MAP_CLEARTARGET,true)
		luaUS09PhaseManager()
		luaUS09SecondaryInit()
		luaUS09CVManager()
	else
		luaUS09InitMovie()
		Blackout(false, "", 1.5)
		if not DEMO_2009_JAN then
			AddPowerup({
				["classID"] = "automatic_reloader",
				["useLimit"]	 = 1,
				})
		end
	end
		
end

function US09Think(this, msg)	
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
	Mission.CVs = luaRemoveDeadsFromTable(Mission.CVs)
	Mission.JapPts = luaRemoveDeadsFromTable(Mission.JapPts)
	Mission.Gekkos = luaRemoveDeadsFromTable(Mission.Gekkos)
	Mission.Shipyards = luaRemoveDeadsFromTable(Mission.Shipyards)
	Mission.Fortresses = luaRemoveDeadsFromTable(Mission.Fortresses)
	Mission.FakeUSFighters = luaRemoveDeadsFromTable(Mission.FakeUSFighters)
	Mission.FakeJapFighters = luaRemoveDeadsFromTable(Mission.FakeJapFighters)
		
	luaUS09CheckConditions()
	--luaUS09AirfieldSendPlanes()
			
-- MissionPhase 1 (init dolgok)
	if this.MissionPhase == 1 then
		this.MissionPhase = 2
		
		SetNumbering(this.Atlanta,95)
		SetNumbering(this.StLo,63)
		SetNumbering(this.KalininBay,68)
		SetNumbering(this.GambierBay,73)
		SetNumbering(this.DeadCV,79)
		
		--Atlanta killed
		AddListener("kill", "listenerAtlantaKilled", {
					["callback"] = "luaUS09AtlantaKilled",
					["entity"] = {Mission.Atlanta},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})

		--CV
		AddListener("kill", "listenerCVKilled", {
					["callback"] = "luaUS09CVKilled",
					["entity"] = Mission.CVs,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})
		
		--Airfield detected	
		AddProximityTrigger(Mission.Airfield, "ProximityAirfield", "luaUS09AirfieldDetected", Mission.Atlanta, 2100)
		
		--Shipyards invincible
-- RELEASE_LOGOFF  		luaLog("FIRSTTHINK SHIT")
		for idx,unit in pairs(Mission.Shipyards) do
			SetInvincible(unit, true)
		end
		for idx,unit in pairs(Mission.PTHangars) do
			SetInvincible(unit, true)
		end	
		
		
		--First Kamikaze attack
		PilotSetTarget(Mission.Kamikaze1, Mission.KalininBay)
		PilotSetTarget(Mission.Kamikaze2, Mission.Atlanta)
		PilotSetTarget(Mission.Kamikaze3, Mission.GambierBay)
		
		--Pathon indulas
		NavigatorMoveOnPath(Mission.StLo, Mission.PathStLo)
		NavigatorMoveOnPath(Mission.GambierBay, Mission.PathGambier)
		NavigatorMoveOnPath(Mission.KalininBay, Mission.PathKalinin)
		NavigatorMoveOnPath(Mission.Atlanta, Mission.PathAtlanta)
		
		AddDamage(Mission.DeadCV,4000)
		
		for idx,unit in pairs(Mission.Shipyards) do
			SetParty(unit, 2)
		end
-- RELEASE_LOGOFF  		luaLog("SETPARTY LEFUTOTT")
		
		--Junka elinditas
		--NavigatorMoveOnPath(Mission.Junk, Mission.JunkPath, PATH_FM_CIRCLE)
	
		luaUS09KamikazeManager()
		luaDelay(luaUS09GenerateKamikaze,45)
		luaDelay(luaUS09BettyGenerate,luaRnd(20,90))
		luaDelay(luaUS09ControlHint,6)
		
-- MissionPhase 2 (kamikaze attack)
	elseif this.MissionPhase == 2 and this.FirstRun == true then
		EnableMessages(true)
		this.Phase2ThinkCounter = 0
		this.FirstRun = false
		
-- MissionPhase 3 (airfield fazis)
	elseif this.MissionPhase == 3 and this.FirstRun == true then
		this.FirstRun = false
		luaUS09PreparePhase3()
		
-- MissionPhase 4 (PT Boat hangarok)
	elseif this.MissionPhase == 4 and this.FirstRun == true then
		this.FirstRun = false
		this.Phase4ThinkCounter = 0
		for idx,unit in pairs (Mission.Shipyards) do
			SetParty(unit, 1)
		end
		luaUS09ShipyardManager()
		luaUS09JapFighterManager()
		
-- MissionPhase 5 (Musashi)
	elseif this.MissionPhase == 5 and this.FirstRun == true then
		this.FirstRun = false
		this.Phase5ThinkCounter = 0
		luaUS09PreparePhase5()
	end
end	

function luaUS09CheckConditions()
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end
			
--Mission Phase 2 Check
	if Mission.MissionPhase == 2 and not Mission.FirstRun and not Mission.CheckpointLoaded then
		Mission.Phase2ThinkCounter = Mission.Phase2ThinkCounter + 1
		if Mission.Phase2ThinkCounter == 2 then
			
			AddDamage(Mission.DeadCV,10000)
			luaStartDialog("kamikaze_hit")
			luaObj_Add ("primary", 1, nil, true)
			luaUS09FakeFighterManager()
			DisplayScores(1,0,"usn09.score01","usn09.score02")
		end
	end
	
--Mission Phase 3 Check	
	if Mission.MissionPhase == 3 and not Mission.FirstRun then
		--luaObj_Reminder()
	end
--Mission Phase 4 Check
	if Mission.MissionPhase == 4 and not Mission.FirstRun then
		--luaObj_Reminder()
		Mission.Phase4ThinkCounter = Mission.Phase4ThinkCounter + 1
		if Mission.Phase4ThinkCounter == 4 then
			-- (aTom): a kov. sorok atrakva a luaUS09_InitPri02() fv-be, az airfield-es EM elnyomhatosaga es az ebbol kovetkezo idozites miatt
			--luaObj_Add("primary", 2, Mission.PTHangars)
			--luaObj_AddReminder("primary", 2, 5)
			--DisplayUnitHP(Mission.Shipyards,"usn09.unit_hp01")
			for idx,unit in pairs(Mission.Shipyards) do
				SetForcedReconLevel(unit, 2, 0)
			end
			Mission.AAHintDone = 0
			luaDelay(luaUS09HintAA,20)
			luaDelay(luaUS09HintRocket,30)
		end
	end

--Mission Phase 5 Check
	if Mission.MissionPhase == 5 and not Mission.FirstRun then
		--luaObj_Reminder()
		Mission.Phase5ThinkCounter = Mission.Phase5ThinkCounter + 1
		if Mission.Phase5ThinkCounter == 7 then
			ShowHint("USN09_Hint_Avenger")
		end
		if not Mission.EndMission and Mission.Musashi ~= nil and not Mission.Musashi.Dead then
			NavigatorStop(Mission.Musashi)
			NavigatorMoveOnPath(Mission.Musashi, Mission.PathMusashi)
		end			
	end

--Airfield & Shipyards gone -> Shinden attack
	--[[
	if (luaObj_GetSuccess("primary",2) == true and luaObj_GetSuccess("secondary",1) == true) and not Mission.ShindensStarted then
		Mission.ShindensStarted = true
		luaUS09ShindenSpawnManager()
	end
	]]
--f0rtress check
	if luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
		if table.getn(Mission.Fortresses) == 0 then
			luaObj_Completed("hidden", 1)
		end
	end
end

function luaUS09MissionFailed(reason,target)
	for i=1,3 do
		if luaObj_IsActive("primary",i) and luaObj_GetSuccess("primary",i) == nil then
			luaObj_Failed("primary",i)
		end
		HideScoreDisplay(i,0)
	end
	if reason == "cvlost" then
		luaMissionFailedNew(Mission.CVTriggered, "usn09.obj_p1_failed_cv")
	elseif reason == "atlanta" then
		luaMissionFailedNew(Mission.Atlanta, "usn09.obj_p1_failed_atlanta")
	end
end

function luaUS09AchievementListener(...)
	RemoveListener("hit", "AchievementlistenerID")
	Mission.AchievementFailed = true
-- RELEASE_LOGOFF  	luaLog("ACSI !!FAILED!!")
end

function luaUS09KamikazeManager()
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	else
		if not Mission.Airfield.Dead then
			Mission.LowestHP = GetHpPercentage(Mission.CVs[1])
			Mission.LowestHPShip = Mission.CVs[1]
			Mission.percentage = 0
			for idx,unit in pairs (Mission.CVs) do
				Mission.percentage = GetHpPercentage(unit)
				if Mission.percentage < Mission.LowestHP then
					Mission.LowestHP = Mission.percentage
					Mission.LowestHPShip = unit
				end
			end
-- RELEASE_LOGOFF  			luaLog("Legkisebb HPju carrier:  "..Mission.LowestHPShip.Name)
					
			--todo: Enrage-t betenni
			if Mission.MissionPhase < 3 then
				Mission.FighterCLIDs = {
									[1] = 45, --kamikaze zero
									[2] = 46, --kamikaze val
									}
			elseif Mission.MissionPhase == 3 then
				Mission.FighterCLIDs = {
									[1] = 152, --gekko
									[2] = 46, --kamikaze val
									}
			end
			local activeSquads, planeEntTable = luaGetSlotsAndSquads(Mission.Airfield)
			if activeSquads < 4 then
				local wing = luaRnd(1,2)
				luaAirfieldManager(Mission.Airfield, Mission.FighterCLIDs, Mission.FighterCLIDs, {Mission.LowestHPShip}, nil, wing)
			end
			if planeEntTable ~= nil then
				for idx,unit in pairs(planeEntTable) do
					if not unit.Dead then
						if unit.Class.ID ~= 152 then
							SetGuiName(unit, "usn09.kamikaze")
						end
						local altitude = luaPickRnd({200,400,600,800})
						SquadronSetAttackAlt(unit, altitude)
						SquadronSetTravelAlt(unit, altitude)
						unit.Class.MaxSpd = 70
						SetSkillLevel(unit,SKILL_MPNORMAL)
					end
				end
			end
			luaDelay(luaUS09KamikazeManager,15)
		end
	end
end

function luaUS09AirfieldDetected()
	luaObj_Completed("primary", 1,true)
	HideScoreDisplay(1,0)
	--luaCheckpoint(1, nil)
	--Cheat serthetetlenseg ideiglenesen a CVkre
	for idx,unit in pairs (Mission.CVs) do
		SetInvincible(unit, 0.2)
	end
	Mission.MissionPhase = 3
	Mission.FirstRun = true
	if Mission.AchievementFailed ~= true then
		luaUS09AchievementChecker()
	end
end

function luaUS09AirfieldKilled()
	if IsListenerActive("kill", "listenerAirfieldKilled") then
		RemoveListener("kill", "listenerAirfieldKilled")
	end
	Effect("SmallFire",GetPosition(Mission.Hangar))
	luaDelay(luaUS09AirfieldKilled_delayed,3)
end

function luaUS09AirfieldKilled_delayed()
	if GetSelectedUnit() ~= nil and not GetSelectedUnit().Dead then
		Mission.TempUnit = GetSelectedUnit()
	end
	luaUS09EM_Airfield_1()
	luaStartDialog("airfield_killed")
	luaObj_Completed("primary", 4,true)
	MissionNarrative("usn09.obj_p4_coplete")
	HideUnitHP(0)
	Mission.MissionPhase = 4
	Mission.FirstRun = true
end
function luaUS09AchievementChecker()
	if Mission.AchievementFailed ~= true then
		local kamikazes = luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.kamikaze)
		for idx, unit in pairs(kamikazes) do
			Kill(unit,true)
-- RELEASE_LOGOFF  			luaLog("ACSI ++KAMIKAZE KILLED++")
		end
		if IsListenerActive("hit", "AchievementlistenerID") then
			RemoveListener("hit", "AchievementlistenerID")
		end
		SetAchievements("MA_YC")
-- RELEASE_LOGOFF  		luaLog("ACSI ########COMPLETE###########")
	end
end

function luaUS09ShipyardManager()
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	else
		if Mission.MissionPhase == 4 and table.getn(luaRemoveDeadsFromTable(Mission.Shipyards)) ~= 0 then
			if table.getn(Mission.JapPts) < Mission.ShipyardLimit and ((math.floor(GameTime()) - Mission.LastShipyardSpawned) > ((Mission.JapShipSpawnInterval))) then
				local tempshipyard = luaPickRnd(Mission.Shipyards)
				SpawnNew({
						["party"] = PARTY_JAPANESE,
						["groupMembers"] = {
							{
								["Type"] = 77,
								["Name"] = "Gyoraitei PT",
								["Race"] = JAPAN,
							},
						},
						["area"] = {
							["refPos"] = tempshipyard.Spawn,
							["angleRange"] = {-1,1},
							["lookAt"] = GetPosition(Mission.StLo)	
		
						},
						["callback"] = "luaUS09JapPTSpawned",
						["excludeRadiusOverride"] = {
							["ownHorizontal"] = 5,
							["enemyHorizontal"] = 5,
							["ownVertical"] = 5,
							["enemyVertical"] = 5,
							["formationHorizontal"] = 200,
						},
						})
			end
			luaDelay(luaUS09ShipyardManager,3)
		end
	end
end

function luaUS09JapPTSpawned(spawnedpt)
-- RELEASE_LOGOFF  	luaLog("!!!!!Jap PT Spawned!!!!!!")
	SetSkillLevel(spawnedpt,SKILL_SPNORMAL)
	table.insert(Mission.JapPts,spawnedpt)
	NavigatorAttackMove(spawnedpt,luaPickRnd(Mission.CVs),{})
	Mission.LastShipyardSpawned = math.floor(GameTime())
end

--[[
function luaUS09AirfieldSendPlanes()
	if math.floor(GameTime()) > Mission.AirfieldTimer then
		if not Mission.Airfield.Dead then
			local FighterCLIDs = {
								[1] = 154,
								[2] = 150,
								}
			local activeSquads, planeEntTable = luaGetSlotsAndSquads(Mission.Airfield)
			if activeSquads < 1 and not Mission.Airfield.Dead then
				luaAirfieldManager(Mission.Airfield, FighterCLIDs, FighterCLIDs, Mission.AttackingPlanes)
			end
			
			StLoactiveSquads, StLoPlanes = luaGetSlotsAndSquads(Mission.StLo)
			
			Mission.AttackingPlanes = {}
			if StLoPlanes ~= nil then
				for idx,unit in pairs(StLoPlanes) do
					if not unit.Dead and GetProperty(unit, "unitcommand") ~= "land" then
						table.insert(Mission.AttackingPlanes,unit)
					end
				end
			end
			
			if activeSquads > 0 and table.getn(Mission.AttackingPlanes) ~= 0 then
				for idx,unit in pairs(planeEntTable) do
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						local target = luaPickRnd(Mission.AttackingPlanes)
						luaSetScriptTarget(unit, target)
						PilotSetTarget(unit, target)
					end
				end
			end
		end
	end
	luaDelay(luaUS09AirfieldSendPlanes,120)
end
]]
function luaUS09MusashiDetected()
	if IsListenerActive("recon","listenerMusashiDetected") then
		RemoveListener("recon","listenerMusashiDetected")
	end
	luaDelay(luaUS09AddMusashiObjective,2.5)
	
	--AA enable rutin init
	--luaDelay(luaUS09RepairCycle, Mission.RepairCycleTimer*60)

end

function luaUS09AddMusashiObjective()
	if Mission.EndMission then
		return
	else
		luaObj_Add("primary", 3, Mission.Musashi)
		DisplayUnitHP({Mission.Musashi}, "usn09.unit_hp02")
		AddListener("kill", "listenerMusashikilled", {
					["callback"] = "luaUS09MusashiKilled",
					["entity"] = {Mission.Musashi},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})	
	end
end

function luaUS09MusashiKilled()
	if IsListenerActive("kill", "listenerMusashikilled") then
		RemoveListener("kill", "listenerMusashikilled")
	end
	HideUnitHP(0)
	luaStartDialog("musashi_killed")
	--MissionNarrative("usn09.obj_p3_coplete")
	luaUS09FinalDialogueCheck()
end

function luaUS09FinalDialogueCheck()
	Mission.DialogFlag = 0
	local tDialogIDs = GetActDialogIDs()
	for i, pDialogID in pairs (tDialogIDs) do
		if pDialogID == "musashi_killed" then
			Mission.DialogFlag = 1
		end
	end
	if Mission.DialogFlag == 0 then
		luaUS09MusashiKilled_delay()
	else
		luaDelay(luaUS09FinalDialogueCheck,1)
	end
end

function luaUS09MusashiKilled_delay()
	luaObj_Completed("primary",3)
	local tDialogIDs = GetActDialogIDs()
	for i, pDialogID in pairs (tDialogIDs) do
		KillDialog(pDialogID)
	end
	luaDelay(luaUS09MusashiKilled_WIN,1)
end

function luaUS09MusashiKilled_WIN()
	Mission.EndMission = true
	if luaObj_GetSuccess("hidden", 1) ~= true then
		luaObj_Failed("hidden", 1)
	end
	SetWait(Mission,0.5)
	luaStartDialog("victory")
end

function luaUS09MissionEnd()
	luaMissionCompletedNew (Mission.Musashi, "usn09.obj_p3_coplete")
	local medal = luaGetMedalReward()
	if not DEMO_2009_JAN then
		if (medal == MEDAL_SILVER) then
			Scoring_GrantBonus("US09_SCORING_SILVER", "usn09.bonus1_title", "usn09.bonus1_text", "globals.powerup_airsupport_levelbomb1_name_us")
		end
		if (medal == MEDAL_GOLD) then
			Scoring_GrantBonus("US09_SCORING_SILVER", "usn09.bonus1_title", "usn09.bonus1_text", "globals.powerup_airsupport_levelbomb1_name_us")
			Scoring_GrantBonus("US09_SCORING_GOLD", "usn09.bonus2_title", "usn09.bonus2_text", 19)
		end
	end
end

function luaUS09MusashiHitStLo()
	if IsListenerActive("hit", "ListenerStLoHit") then
		RemoveListener("hit", "ListenerStLoHit")
	end
-- RELEASE_LOGOFF  	luaLog("MUSASHI IN FIRE RANGE!!!!!!!!")
	luaStartDialog("musashi_firing")
	--MissionNarrative("New powerup available!")
	
end

function luaUS09RepairCycle()
	RepairEnable(Mission.AAGuns[1],true)
	luaRemoveByName(Mission.AAGuns, Mission.AAGuns[1].Name)
	if table.getn(Mission.AAGuns) ~= 0 then
		luaDelay(luaUS09RepairCycle,Mission.RepairCycleTimer*60)
	end
	
end

function luaUS09CVKilled(killedcv)
	killedcv.Dead = true
	Mission.CVs = luaRemoveDeadsFromTable(Mission.CVs)
	if table.getn(Mission.CVs) < 3 then
		Mission.EndMission = true
		Mission.CVTriggered = killedcv
		luaUS09MissionFailed("cvlost")
	end
end

function luaUS09ShipyardKilled(killedshipyard)
	killedshipyard.Dead = true
	Mission.KilledShipyardNum = Mission.KilledShipyardNum + 1
	Mission.Shipyards = luaRemoveDeadsFromTable(Mission.Shipyards)
	Mission.ShipyardsRemaining = table.getn(Mission.Shipyards)
	DisplayScores(3,0,"usn09.unit_hp01","usn09.unit_hp04")
-- RELEASE_LOGOFF  	luaLog("halott shipyard: "..killedshipyard.Name)
-- RELEASE_LOGOFF  	luaLog("shipyardok szama :"..table.getn(Mission.Shipyards))
	if table.getn(Mission.Shipyards) == 2 then
		luaStartDialog("first_base_killed")
-- RELEASE_LOGOFF  		luaLog("hangar killed dialog lejatszva")
	elseif table.getn(Mission.Shipyards) == 0 then
		Mission.LastShipyard = killedshipyard
		luaDelay(luaUS09ShipyardKilled_delay,3)
	end
end 

function luaUS09ShipyardKilled_delay()
	HideScoreDisplay(3,0)
	luaStartDialog("all_bases_killed")
	luaObj_Completed("primary", 2,true)
	HideUnitHP(0)
	--luaCheckpoint(2, nil)
	--MissionNarrative("usn09.obj_p2_coplete")
	Mission.MissionPhase = 5
	Mission.FirstRun = true
end

function luaUS09ShindenSpawnManager()
	Mission.Shindens = luaRemoveDeadsFromTable(Mission.Shindens)
	luaUS12ShindenTargetCheck()
	if table.getn(Mission.Shindens) == 0 then
		local spawnpos = luaPickRnd(Mission.ShindenPosTable)
		
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 189,
				["Name"] = "J7W Shinden",
				["Crew"] = 2,
				["Race"] = JAPAN,
				["WingCount"] = 1,
				["Equipment"] = 0,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = {-1,1},
			["lookAt"] = GetPosition(Mission.StLo)
		},
		["callback"] = "luaUS09ShindenCB",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100,
			
		},
		})
	end
	if not Mission.EndMission then
		luaDelay(luaUS09ShindenSpawnManager,10)
	end
end

function luaUS09ShindenCB(spawnedshinden)
	table.insert(Mission.Shindens,spawnedshinden)
	
	StLoactiveSquads, StLoPlanes = luaGetSlotsAndSquads(Mission.StLo)
	Mission.AttackingPlanes = {}
	if StLoPlanes ~= nil then
		for idx,unit in pairs(StLoPlanes) do
			if not unit.Dead and GetProperty(unit, "unitcommand") ~= "land" then
				table.insert(Mission.AttackingPlanes,unit)
			end
		end
	end
		
	if table.getn(Mission.AttackingPlanes) ~= 0 then
		local target = luaPickRnd(Mission.AttackingPlanes)
		PilotSetTarget(spawnedshinden, target)
-- RELEASE_LOGOFF  		luaLog("Shinden attacking "..tostring(target.Name))
	end
	if not Mission.FirstShinden then
		Mission.FirstShinden = true
		AddListener("recon", "listenerShindenDetected", {
					["callback"] = "luaUS09ShindenDetected",
					["entity"] = {spawnedshinden},
					["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
					["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
					["party"] = { PARTY_ALLIED},
					})
	end
end

function luaUS12ShindenTargetCheck()
	StLoactiveSquads, StLoPlanes = luaGetSlotsAndSquads(Mission.StLo)
	Mission.AttackingPlanes = {}
	if StLoPlanes ~= nil then
		for idx,unit in pairs(StLoPlanes) do
			if not unit.Dead and GetProperty(unit, "unitcommand") ~= "land" then
				table.insert(Mission.AttackingPlanes,unit)
			end
		end
	end
	
	if table.getn(Mission.AttackingPlanes) ~= 0 and table.getn(Mission.Shindens) ~= 0 then
		for idx,unit in pairs(Mission.Shindens) do
			if (UnitGetAttackTarget(unit) == nil) or (UnitGetAttackTarget(unit).Dead) or (GetProperty(UnitGetAttackTarget(unit), "unitcommand") == "land") then
				local target = luaPickRnd(Mission.AttackingPlanes)
				PilotSetTarget(unit, target)
				--luaLog("Shinden attacking "..tostring(target.Name))
			end
		end
	end

end

function luaUS09ShindenDetected(detectedshinden)
	if IsListenerActive("recon", "listenerShindenDetected") then
		RemoveListener("recon", "listenerShindenDetected")
	end
	luaStartDialog("shindens_detected")
	luaDelay(luaUS09SecondShindenDialog,15)
end

function luaUS09SecondShindenDialog()
	luaStartDialog("engaging_shindens")

end

function luaUS09AtlantaKilled()
	if not luaObj_IsActive("primary", 4) then
		Mission.EndMission = true
		luaUS09MissionFailed("atlanta")
	else
		--MissionNarrative("Atlanta is lost all we have left is the planes of our carriers")
	end
end

function luaUS09GenerateKamikaze()
	if Mission.EndMission then
		return
	elseif Mission.MissionPhase == 2 then
		if luaRnd(1,2) == 1 then
			local generatedfighter = GenerateObject(luaPickRnd(Mission.Phase1GekkoTemplates).Name)
			PilotSetTarget(generatedfighter, Mission.Atlanta) 	
		else
			local generatedkamikaze = GenerateObject(luaPickRnd(Mission.KamikazeTemplates).Name)
			PilotSetTarget(generatedkamikaze, Mission.Atlanta)
		end
		luaDelay(luaUS09HintKamikaze,5)
		luaDelay(luaUS09GenerateKamikaze,40)
	end
end

function luaUS09UnitSwitchCheck()
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	else
		if IsUnitSelectable(Mission.FirstHelldiver) then
	 		luaJumpToUnit(Mission.FirstHelldiver)
			SetRoleAvailable(Mission.Atlanta, EROLF_ALL, PLAYER_AI)
			luaDelay(luaUS09AirfieldObjective,3)
		else
			luaDelay(luaUS09UnitSwitchCheck,1)
		end
	end
end

function luaUS09FakeFighterManager()
	if Mission.EndMission then
		return
	else
		local hellcatNum, hellcatTable = luaGetSlotsAndSquads(Mission.StLo)
		if hellcatNum < 1  and IsReadyToSendPlanes(Mission.StLo) then 
			local slotIndex = LaunchSquadron(Mission.StLo,26,3)
			local launchedHellcat = thisTable[tostring(GetProperty(Mission.StLo, "slots")[slotIndex].squadron)]
			luaUS09SetAlt(launchedHellcat)
			table.insert(Mission.FakeUSFighters, launchedHellcat)
		end
		if table.getn(Mission.FakeJapFighters) == 0 then
			local generatedZero = GenerateObject(Mission.ZeroTemplate.Name)
			table.insert(Mission.FakeJapFighters, generatedZero)
			for idx,unit in pairs(Mission.FakeJapFighters) do
				if table.getn(Mission.FakeUSFighters) ~= 0 and not Mission.FakeUSFighters[1].Dead then
					PilotSetTarget(generatedZero, Mission.FakeUSFighters[1])
				else 
					PilotMoveToRange(unit, Mission.StLo, 1500)
				end
			end
		end
		if Mission.MissionPhase == 2 then
			luaDelay(luaUS09FakeFighterManager,3)
		end	
	end
end

--[[
*****************************************************************************************
**                         		Japan Fighter Manager                                 **
*****************************************************************************************
]]
function luaUS09JapFighterManager()
	if Mission.EndMission then
		return
	else
		if Mission.MissionPhase == 4 then
			Mission.GekkoLimit = 1
		elseif Mission.MissionPhase == 5 then
			Mission.GekkoLimit = 2
		end
		if table.getn(luaRemoveDeadsFromTable(Mission.Gekkos)) < Mission.GekkoLimit then
			generatedGekko = GenerateObject(luaPickRnd(Mission.Phase2GekkoTemplates).Name, "J1N1 Gekko")
			table.insert(Mission.Gekkos, generatedGekko)
			PilotMoveTo(generatedGekko, Mission.NavGekko)
		end
		luaDelay(luaUS09JapFighterManager, 4)
	end
end

--[[
*****************************************************************************************
**                         		Carrier Planes Manager                                 **
*****************************************************************************************
]]
function luaUS09CVManager()
	if Mission.EndMission then
		return
	else
		--Airfield fazis: Helldivers from Gambier Bay
		--PT Hangar fazis: Corsairs from Kalinin Bay
		--Musashi fazis: Avengers from Gambier Bay
		if Mission.MissionPhase < 3 then
			--Kamikaze fazis: nem kell gep
			Mission.HelldiverNeeded = 0
			Mission.HellcatNeeded = 0
			Mission.AvengerNeeded = 0
			Mission.CorsairNeeded = 0
		elseif Mission.MissionPhase == 3 then
			--Airfield bombazas - csak Helldiver van
			Mission.HelldiverNeeded = 2
			Mission.HellcatNeeded = 0
			Mission.AvengerNeeded = 0
			Mission.CorsairNeeded = 0
		elseif Mission.MissionPhase == 4 then
			--Shipyard raketazas - csak corsair van
			Mission.HelldiverNeeded = 0
			Mission.HellcatNeeded = 1
			Mission.AvengerNeeded = 0
			Mission.CorsairNeeded = 2
		elseif Mission.MissionPhase == 5 then
			Mission.HelldiverNeeded = 0
			Mission.HellcatNeeded = 1
			Mission.AvengerNeeded = 4
			Mission.CorsairNeeded = 0
		end

		Mission.Helldivers = {} 
		Mission.Corsairs = {}
		Mission.Avengers = {}
		local hellcatNum, hellcatTable = luaGetSlotsAndSquads(Mission.StLo)
		local helldiveravengerNum, helldiveravengerTable = luaGetSlotsAndSquads(Mission.GambierBay)
		if helldiveravengerTable ~= nil then
			for idx,unit in pairs(helldiveravengerTable) do
				if unit.Class.Type == "DiveBomber" then
					table.insert(Mission.Helldivers, unit)
				else 
					table.insert(Mission.Avengers, unit)
				end
			end
		end
		local helldiverNum = table.getn(Mission.Helldivers)
		local avengerNum = table.getn(Mission.Avengers)
		local corsairNum, corsairTable = luaGetSlotsAndSquads(Mission.KalininBay)
		Mission.Corsairs = corsairTable
		if hellcatNum < Mission.HellcatNeeded  and IsReadyToSendPlanes(Mission.StLo) then
			local slotIndex = LaunchSquadron(Mission.StLo,26,3)
			local launchedHellcat = thisTable[tostring(GetProperty(Mission.StLo, "slots")[slotIndex].squadron)]
			--SetRoleAvailable(launchedHellcat, EROLF_ALL, PLAYER_ANY)
			luaUS09SetAlt(launchedHellcat)
		end
		if helldiverNum < Mission.HelldiverNeeded and IsReadyToSendPlanes(Mission.GambierBay) then
			local slotIndex = LaunchSquadron(Mission.GambierBay,38,3)
			local launchedHelldiver = thisTable[tostring(GetProperty(Mission.GambierBay, "slots")[slotIndex].squadron)]
			SetRoleAvailable(launchedHelldiver, EROLF_ALL, PLAYER_ANY)
			luaUS09SetAlt(launchedHelldiver)
		end
		if corsairNum < Mission.CorsairNeeded and IsReadyToSendPlanes(Mission.KalininBay) then
			local slotIndex = LaunchSquadron(Mission.KalininBay,102,3,1)
			local launchedCorsair = thisTable[tostring(GetProperty(Mission.KalininBay, "slots")[slotIndex].squadron)]
			SetRoleAvailable(launchedCorsair, EROLF_ALL, PLAYER_ANY)
			luaUS09SetAlt(launchedCorsair)
			if not Mission.FirstCorsairLaunched then
				Mission.FirstCorsair = launchedCorsair
				SetInvincible(Mission.FirstCorsair, true)
				Mission.FirstCorsairLaunched = true
			end
		end
		if avengerNum < Mission.AvengerNeeded and IsReadyToSendPlanes(Mission.GambierBay) then
			local slotIndex = LaunchSquadron(Mission.GambierBay,113,3)
			local launchedAvenger = thisTable[tostring(GetProperty(Mission.GambierBay, "slots")[slotIndex].squadron)]
			SetRoleAvailable(launchedAvenger, EROLF_ALL, PLAYER_ANY)
			luaUS09SetAlt(launchedAvenger)
			if Mission.Musashi ~= nil and not Mission.Musashi.Dead then
				PilotSetTarget(launchedAvenger,Mission.Musashi)
			end
			if not Mission.FirstAvengerLaunched then
				Mission.FirstAvenger = launchedAvenger
				SetInvincible(Mission.FirstAvenger, true)
				Mission.FirstAvengerLaunched = true
			end
		end
		Mission.CVManagerRunning = true
		luaDelay(luaUS09CVManager,2)
	end
end

--[[
*****************************************************************************************
**                      	Carrier Planes Manager      END                            **
*****************************************************************************************
]]

function luaUS09SetAlt(planesquad)
	if planesquad.Class.Type == "TorpedoBomber" then
		SquadronSetTravelAlt(planesquad,100)
	else
		SquadronSetAttackAlt(planesquad,100)
		SquadronSetTravelAlt(planesquad,100)
	end
end

function luaUS09AirfieldObjective()
	SetInvincible(Mission.FirstHelldiver, 0)
	luaObj_Add("primary", 4, Mission.Hangar)
	if DEMO_2009_JAN then
		luaDelay(luaUS09MapHint,6)
	end
	--ideiglenes serthetetlenseg leszedve a carrierekrol
	luaDelay(luaUS09RemoveInvincible,50)
	DisplayUnitHP({Mission.Airfield}, "usn09.unit_hp03")
end

function luaUS09BettyGenerate()
	local generatedBetty = GenerateObject(Mission.BettyTemplate.Name)
	luaUS09SetAlt(generatedBetty)
	PilotSetTarget(generatedBetty, luaPickRnd(Mission.CVs))
end

function luaUS09RemoveInvincible()
	if Mission.EndMission then
		return
	else
		for idx,unit in pairs (Mission.CVs) do
			SetFireDamage(unit, 0, true) -- Apply mondta: hogy a gamblierBay tuzsebzest kapott mikor pinaszorszalnyi HPja volt es le let szedve a lathatatlansag rola es meghalt es a SetRoleAvailable a Mission.HellDivers kornyeken elhalalozott mert csunya nil volt a unit (de lehet hogy nem)
			SetInvincible(unit, false)
		end
	end
end

function luaUS09ControlHint()
	ShowHint("USN09_Hint_Control")
end

function luaUS09HintAA() 

	if Mission.AAHintDone ~= 2 then
		ShowHint("USN09_Hint_AA")
		luaDelay(luaUS09HintAA, 60)
		Mission.AAHintDone = Mission.AAHintDone + 1
	end
end

function luaUS09HintMusashi()
	ShowHint("USN09_Hint_MusashiNear")
end

function luaUS09HintRocket()
	if Mission.MissionPhase == 4 then
		ShowHint("USN09_Hint_Rocket")
		if not Mission.RocketHintDone then
			Mission.RocketHintDone = true
			luaDelay(luaUS09HintRocket,30)
		end
	end
	
end
function luaUS09HintKamikaze()
	ShowHint("USN09_Hint_Kamikaze")
end

function luaUS09EnrageAirfield()
	Mission.AirfieldEnrage = true
end

function luaUS09TurretKilled(killedturret)
	killedturret.Dead = true
	Mission.Turrets = luaRemoveDeadsFromTable(Mission.Turrets)
	Mission.TurretsRemaining = table.getn(Mission.Turrets)
	Mission.TurretsKilled = Mission.TurretsKilled + 1
	if Mission.TurretsKilled == 1 then
		--first turret killed -> add secondary objective
		luaDelay(luaUS09S1Add,3)
	else
		--DisplayScores(2,0,"usn09.obj_s1","usn09.obj_s1_display")
	end
	
	local reminderLimits = {30,20,10,5} --ennyi turret szamnal szol a narrativa reminder pl 30 more guns remaining
	
	for idx,limit in pairs (reminderLimits) do
		if Mission.TurretsRemaining == limit then
			MissionNarrative("usn09.obj_s1_reminder")
			return
		end
	end
	
	if Mission.TurretsKilled == Mission.MaxTurretNum and luaObj_GetSuccess("secondary",1) == nil then
		HideScoreDisplay(2,0)
		luaObj_Completed("secondary",1,true)
		--[[AddPowerup({
				["classID"] = "levelbomb1",
				["useLimit"]	 = 1,
				})		]]		
	end
end

function luaUS09S1Add()
	if Mission.EndMission then
		return
	elseif Mission.CamScript ~= nil and not Mission.CamScript.Dead then
		luaDelay(luaUS09S1Add,2)
	else
		luaObj_Add("secondary",1)
		--DisplayScores(2,0,"usn09.obj_s1","usn09.obj_s1_display")
	end
end

--[[
*****************************************************************************************
**                         		INGAME ENGINE MOVIES                                   **
*****************************************************************************************
]]

function luaUS09InitMovie()
	 local campos1 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= Mission.Atlanta.ID,
				["pos"] = {75, 50, -150}
			},
			["transformtype"]="keepz",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=0.0,
			["wanderer"]=true,
			["smoothtime"]=1.0,
			["zoom"] = 1.0,
		}

  local campos2 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= Mission.Atlanta.ID,
				["modifier"] = {
						["name"] = "gamecamera",
					},
				},
			["transformtype"]="keepall",
			["starttime"]=0.0,
			["blendtime"]=6.0,
			["wanderer"]=false,
			["zoom"] = 1,
			["finishscript"] = "luaUS09InitMovieEnd",
		}
 	MovCamNew_AddPosition(campos1)
	MovCamNew_AddPosition(campos2)
	BlackBars(false)
end

function luaUS09InitMovieEnd()
	SetSelectedUnit(Mission.Atlanta) 
	EnableInput(true)
end



function luaUS09EM_Helldiver_1()
	Blackout(true, "luaUS09EM_Helldiver_1A", 1)
end

function luaUS09EM_Helldiver_1A()
	Mission.EMTime = 3
	Mission.EMStartTime = GameTime()
	--luaLog("Time @ start = "..Mission.EMStartTime)
	Mission.EM_Interrupted = false
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		--luaCheckpoint(1, nil)
	end
	luaDelay(luaUS09EM_Helldiver_2, 1)
end

function luaUS09EM_Helldiver_2()
-- RELEASE_LOGOFF  	luaLog("EM START ELINDULT")
	BlackBars(true)
	luaStartDialog("airfield_detected")
	Mission.CamScript = luaCamOnTargetFree(Mission.Atlanta, 10, 200, 130, false, nil , 0, luaUS09EM_Helldiver_3)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS09EM_Helldiver_3_EMInterrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Blackout(false, "", 1)
end

function luaUS09EM_Helldiver_3()
-- RELEASE_LOGOFF  	luaLog("EM MEGHIVODOTT")
	Mission.CamScript = luaCamOnTargetFree(Mission.FirstHelldiver, 0, 180, 25, true, nil , 9, luaUS09EM_Helldiver_4)
end

function luaUS09EM_Helldiver_4()
	BlackBars(false)
	local campos3 = {
		["postype"]="cameraandtarget",
		["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.FirstHelldiver.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},
		["transformtype"]="keepall",
		["starttime"]=0.0,
		["blendtime"]=1.5,
		["wanderer"]=false,
		["zoom"] = 1,
		["finishscript"] = "luaUS09EM_Helldiver_3_CB",
	}
	MovCamNew_AddPosition(campos3)
end

function luaUS09EM_Helldiver_3_EMInterrupted()
	RemoveListener("input", "movielistenerID")
	Mission.EM_Interrupted = true
	Blackout(true, "luaUS09EM_Helldiver_3_CB", 1)
end

function luaUS09EM_Helldiver_3_CB()
-- RELEASE_LOGOFF  	luaLog("EM CB MEGHIVODOTT")
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.CamScript.Dead == false then
		--luaLog("EM CB - A script kiirtva")
		DeleteScript(Mission.CamScript)
	end
	EnableInput(true)
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	else
		--luaLog("EM CB - Nincs EndMission")
		if IsUnitSelectable(Mission.FirstHelldiver) then
	 		--luaJumpToUnit(Mission.FirstHelldiver)
	 		--luaLog("EM CB - A unit szelektalhato")
	 		if ((GetSelectedUnit() ~= nil) and (GetSelectedUnit().Class.ID ~= 38)) then		-- 38-as ClassID -> Helldiver
	 			--luaLog("EM CB - SetSelectable() meghivva")
				SetSelectedUnit(Mission.FirstHelldiver)
			end
			SetRoleAvailable(Mission.Atlanta, EROLF_ALL, PLAYER_AI)
			local ObjDelayTime = 3
			if (Mission.EM_Interrupted) then
				Mission.EM_Interrupted = false
				local ActTime = GameTime()
				local difftime = ActTime - Mission.EMStartTime
				if (difftime < Mission.EMTime) then
					local BlackoutTime = Mission.EMTime - difftime
					ObjDelayTime = BlackoutTime + 3
					luaDelay(luaUS09EM_Helldiver_3_CB_BlackoutEnd, BlackoutTime)
				else
					luaUS09EM_Helldiver_3_CB_BlackoutEnd()
				end
			end
			luaDelay(luaUS09AirfieldObjective, ObjDelayTime)
		else
			--luaLog("EM CB - A unit meg nem szelektalhato")
			luaDelay(luaUS09EM_Helldiver_3_CB,1)
		end
	end
end

function luaUS09EM_Helldiver_3_CB_BlackoutEnd()
	Blackout(false, "", 1)
end

function luaUS09EM_Airfield_1()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_1")
	Blackout(true, "", 1.5)
	Mission.EMTime = 4
	Mission.EMStartTime = GameTime()
	--luaLog("Time @ start = "..Mission.EMStartTime)
	Mission.EM_Interrupted = false
	luaDelay(luaUS09EM_Airfield_2, 1.5)
	Mission.MoviePT = GenerateObject(Mission.PTTemplate.Name,"Gyoraitei PT")
end

function luaUS09EM_Airfield_2()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_2")
	BlackBars(true)
	Mission.CamScript = luaCamOnTargetFree(Mission.Hangar, 11, 120, 280, false, nil , 0, nil)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS09EM_Airfield_EMInterrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Blackout(false, "", 1)
	Mission.Delay = luaDelay(luaUS09EM_Airfield_3, 2)
	luaDelay(luaUS09EM_Airfield_PTStart,4.5)
end

function luaUS09EM_Airfield_3()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_3")
	Mission.CamScript = luaCamOnTargetFree(Mission.MoviePTHangar, 9, 130, 250, false, nil , 8, luaUS09EM_Airfield_4)
end

function luaUS09EM_Airfield_PTStart()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_PTStart")
	NavigatorAttackMove(Mission.MoviePT, Mission.Atlanta, {})
end

function luaUS09EM_Airfield_4()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_4")
	Blackout(true, "", 1.5)
	Mission.Delay = luaDelay(luaUS09EM_Airfield_5, 1.5)
end

function luaUS09EM_Airfield_5()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_5")
	Blackout(false, "", 2)
	luaUS09EM_Airfield_6()
end

function luaUS09EM_Airfield_EMInterrupted()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_EMInterrupted")
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	Blackout(true, "luaUS09EM_Airfield_6", 1)
	Mission.EM_Interrupted = true
end

function luaUS09EM_Airfield_6()
-- RELEASE_LOGOFF  	luaLog("EM Airfield_6")
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
	if Mission.TempUnit ~= nil and not Mission.TempUnit.Dead then
		SetRoleAvailable(Mission.TempUnit,EROLF_ALL, PLAYER_AI)
	end
	if Mission.FirstCorsair ~= nil and IsUnitSelectable(Mission.FirstCorsair) then
-- RELEASE_LOGOFF  		luaLog("EM Airfield: A corsair nem nil es szelektalhato")
		SetInvincible(Mission.FirstCorsair, false)
		SetSelectedUnit(Mission.FirstCorsair)
		SetRoleAvailable(Mission.FirstCorsair,EROLF_ALL, PLAYER_ANY)
		EnableInput(true)
		PilotSetTarget(Mission.FirstCorsair, Mission.Shipyards[1])
		local nObjDelayTime = 4
		for idx,unit in pairs(Mission.Helldivers) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotMoveTo(unit, Mission.NavGekko)
			luaRemoveByName(Mission.Helldivers, unit.Name)
		end
		if (Mission.EM_Interrupted) then
			Mission.EM_Interrupted = false
			local nDiff = GameTime() - Mission.EMStartTime
			if (nDiff < Mission.EMTime) then
				local nBlackoutTime = Mission.EMTime - nDiff
				nObjDelayTime = nObjDelayTime + nBlackoutTime
				luaDelay(luaUS09EM_Airfield_6_BlackoutEnd, nBlackoutTime)
			else
				luaUS09EM_Airfield_6_BlackoutEnd()
			end
		end
		luaDelay(luaUS09HangarObjective, nObjDelayTime)
	else
-- RELEASE_LOGOFF  			luaLog("EM Airfield: A corsair nil vagy nem szelektalhato. Probalkozok meg.")
			luaDelay(luaUS09EM_Airfield_6,1)
	end
end

function luaUS09EM_Airfield_6_BlackoutEnd()
	Blackout(false, "", 1)
end

function luaUS09HangarObjective()
	luaObj_Add("primary", 2, Mission.PTHangars)
	for idx,unit in pairs(Mission.PTHangars) do
		SetInvincible(unit, false)
	end
	for idx,unit in pairs(Mission.Shipyards) do
		SetInvincible(unit, false)
	end
	AddListener("kill", "listenerShipyardKilled", {
					["callback"] = "luaUS09ShipyardKilled",
					["entity"] = Mission.Shipyards,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})
	--DisplayUnitHP(Mission.Shipyards,"usn09.unit_hp01")
	DisplayScores(3,0,"usn09.unit_hp01","usn09.unit_hp04")
	if DEMO_2009_JAN then
		luaDelay(luaUS09SwitchHint,6)
	end
end

function luaUS09EM_Musashi_1()
	Blackout(true, "luaUS09EM_Musashi_1A", 1.5)
end

function luaUS09EM_Musashi_1A()
	Mission.EMTime = 4
	Mission.EMStartTime = GameTime()
	--[[local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) or ((num ~= nil) and (table.getn(num)>0) and (num[1] ~= 2)) then
		--luaCheckpoint(2, nil)
	end]]
	--luaLog("Time @ start = "..Mission.EMStartTime)
	Mission.EM_Interrupted = false
	Mission.MovieHellcat = GenerateObject(Mission.HellcatTemplate.Name,"F6F Hellcat")
	AddUntouchableUnit(Mission.MovieHellcat)
	SetRoleAvailable(Mission.MovieHellcat,EROLF_ALL, PLAYER_AI)
	Effect("SmallFire",GetPosition(Mission.LastShipyard), nil, 4)
	luaDelay(luaUS09EM_Musashi_2, 1)
end

function luaUS09EM_Musashi_2()
	--luaLog("luaUS09EM_Musashi_2")
	BlackBars(true)
	Mission.CamScript = luaCamOnTargetFree(Mission.LastShipyard, 14, 60, 250, false, nil , 0, nil)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS09EM_Musashi_EMInterrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Blackout(false, "", 1.5)
	Mission.Delay = luaDelay(luaUS09EM_Musashi_3, 4)
-- RELEASE_LOGOFF  	luaLog("em2 ok")
end

function luaUS09EM_Musashi_3()
	--luaLog("luaUS09EM_Musashi_3")
	Blackout(true, "", 1.5)
	Mission.Delay = luaDelay(luaUS09EM_Musashi_4, 1)
-- RELEASE_LOGOFF  	luaLog("em3 ok")
end

function luaUS09EM_Musashi_4()
	--luaLog("luaUS09EM_Musashi_4")
	Mission.CamScript = luaCamOnTargetFree(Mission.Musashi, 1, 2, 240, false, nil , 0, nil)
	Blackout(false, "", 1.5)
	Mission.Delay = luaDelay(luaUS09EM_Musashi_5, 2.5)
-- RELEASE_LOGOFF  	luaLog("em4 ok")
end

function luaUS09EM_Musashi_5()
	--luaLog("luaUS09EM_Musashi_5")
	Mission.CamScript = luaCamOnTargetFree(Mission.Musashi, 6, 6, 170, false, nil , 8, nil)	--17
	luaStartDialog("musashi_detected")
	Mission.Delay = luaDelay(luaUS09EM_Musashi_6, 6)	--6
-- RELEASE_LOGOFF  	luaLog("em5 ok")
end

function luaUS09EM_Musashi_6()
	--luaLog("luaUS09EM_Musashi_6")
	Blackout(true, "", 1.5)
	Mission.Delay = luaDelay(luaUS09EM_Musashi_6B, 2)
-- RELEASE_LOGOFF  	luaLog("em6a ok")
end

function luaUS09EM_Musashi_6B()
	--luaLog("luaUS09EM_Musashi_6B")
	Blackout(false, "", 1.5)
	luaUS09EM_Musashi_7()
-- RELEASE_LOGOFF  	luaLog("em6b ok")
end

function luaUS09EM_Musashi_EMInterrupted()
-- RELEASE_LOGOFF  	luaLog("EM Musashi_EMInterrupted")
	if (IsListenerActive("input", "movielistenerID")) then
		RemoveListener("input", "movielistenerID")
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	Blackout(true, "luaUS09EM_Musashi_7", 1)
	Mission.EM_Interrupted = true
end

function luaUS09EM_Musashi_7()
	--luaLog("luaUS09EM_Musashi_7")
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
	if Mission.FirstAvenger ~= nil and IsUnitSelectable(Mission.FirstAvenger) then
-- RELEASE_LOGOFF  		luaLog("belefutott eleje")
		SetInvincible(Mission.FirstAvenger, false)
		PilotSetTarget(Mission.FirstAvenger,Mission.Musashi)
		SetSelectedUnit(Mission.FirstAvenger)
		SetRoleAvailable(Mission.FirstAvenger,EROLF_ALL, PLAYER_ANY)
		EnableInput(true)
		PilotSetTarget(Mission.FirstAvenger, Mission.Musashi)
		if (Mission.Corsairs ~= nil) then
			for idx,unit in pairs(Mission.Corsairs) do
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				PilotMoveTo(unit, Mission.NavGekko)
				--luaRemoveByName(Mission.Corsairs, unit.Name)
			end
			Mission.Corsairs = {}
		end
-- RELEASE_LOGOFF  		luaLog("belefutott kozepe")
		--Kill(Mission.CamScript)
		--Blackout(false, "", 1)
		local nObjDelayTime = 3
		if (Mission.EM_Interrupted) then
			Mission.EM_Interrupted = false
			local nDiff = GameTime() - Mission.EMStartTime
			if (nDiff < Mission.EMTime) then
				local nBlackoutTime = Mission.EMTime - nDiff
				nObjDelayTime = nObjDelayTime + nBlackoutTime
				luaDelay(luaUS09EM_Musashi_7_BlackoutEnd, nBlackoutTime)
			else
				luaUS09EM_Musashi_7_BlackoutEnd()
			end
		end
-- RELEASE_LOGOFF  		luaLog("belefutott vege")
		luaDelay(luaUS09MusashiDetected,nObjDelayTime)
		AddPowerup({
				["classID"] = "full_throttle",
				["useLimit"]	 = 1,
				})		
	else
		luaDelay(luaUS09EM_Musashi_7,1)
	end
-- RELEASE_LOGOFF  	luaLog("em7 ok")
end

function luaUS09EM_Musashi_7_BlackoutEnd()
	Blackout(false, "", 1)
end

--[[
*****************************************************************************************
**                         			  CHECKPOINT FUNCTIONS							   **
*****************************************************************************************
]]
function luaUS09Cp1_Reposition()
	Kill(Mission.DeadCV)
	PutTo(Mission.Atlanta, GetPosition(Mission.NavCp1_Atlanta))
	PutTo(Mission.GambierBay, GetPosition(Mission.NavCp1_GambierBay))
	PutTo(Mission.StLo, GetPosition(Mission.NavCp1_StLo))
	PutTo(Mission.KalininBay, GetPosition(Mission.NavCp1_KalininBay))
	NavigatorMoveOnPath(Mission.StLo, Mission.PathStLo, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.GambierBay, Mission.PathGambier, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.KalininBay, Mission.PathKalinin, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.Atlanta, Mission.PathAtlanta, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	Mission.AchievementFailed = Mission.Checkpoint.AchievementFailed
end

function luaUS09SaveMissionData()
	Mission.Checkpoint.TurretsKilled = Mission.TurretsKilled
	Mission.Checkpoint.AchievementFailed = Mission.AchievementFailed
end

function luaUS09ReplaceTurrets()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]
	local ijnsaved = luaGetCheckpointData("Units", "JapUnits")
	local turretsatstart = Mission.Turrets
	for idx,unit in pairs(turretsatstart) do
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
end

function luaUS09Cp1_KillPlanes()
	ForceRecon()
	local japPlanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx,unit in pairs(japPlanes) do
		Kill(unit,true)
	end
end

function luaUS09PreparePhase3()
	AddListener("kill", "listenerAirfieldKilled", {
					["callback"] = "luaUS09AirfieldKilled",
					["entity"] = {Mission.Airfield},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
					})
	
	luaObj_Add("hidden", 1, Mission.Fortresses)
	
	--atlanta levalik, sebesseg allitas
	SetShipMaxSpeed(Mission.Atlanta,12)
	--Order menu engedelyezes
	ForceEnableInput(IC_OVERLAY_BLUE,true)
	ForceEnableInput(IC_CMD_MAP_CLEARTARGET,true)
	for idx,unit in pairs(Mission.CVs) do
		SetShipMaxSpeed(unit,5)
	end
	
	for idx,unit in pairs(Mission.Fortresses) do
		ArtilleryEnable(unit,true)
	end
	local slotIndex = LaunchSquadron(Mission.GambierBay,38,3)
	Mission.FirstHelldiver = thisTable[tostring(GetProperty(Mission.GambierBay, "slots")[slotIndex].squadron)]
	SetRoleAvailable(Mission.FirstHelldiver, EROLF_ALL, PLAYER_ANY)
	PilotSetTarget(Mission.FirstHelldiver, Mission.Airfield)
	SetInvincible(Mission.FirstHelldiver, 1)
	--luaUS09UnitSwitchCheck()
	luaUS09EM_Helldiver_1()
	if Mission.CVManagerRunning == false then
		luaUS09CVManager()
	end
	--hidden enrage timer
	luaDelay(luaUS09EnrageAirfield,Mission.AirfieldEnrageTime * 60)
end

function luaUS09DelayedBlackout()
	Blackout(false,"",1.5)
end

function luaUS09Cp2_Reposition()
	Kill(Mission.DeadCV)
	SetRoleAvailable(Mission.Atlanta, EROLF_ALL, PLAYER_AI)
	PutTo(Mission.Atlanta, GetPosition(Mission.NavCp1_Atlanta))
	PutTo(Mission.GambierBay, GetPosition(Mission.NavCp1_GambierBay))
	PutTo(Mission.StLo, GetPosition(Mission.NavCp1_StLo))
	PutTo(Mission.KalininBay, GetPosition(Mission.NavCp1_KalininBay))
	NavigatorMoveOnPath(Mission.StLo, Mission.PathStLo, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.GambierBay, Mission.PathGambier, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.KalininBay, Mission.PathKalinin, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveOnPath(Mission.Atlanta, Mission.PathAtlanta, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
end

function luaUS09PreparePhase5()
	Mission.Musashi = GenerateObject(Mission.MusashiTemplate.Name)
	Mission.Fubuki = GenerateObject(Mission.FubukiTemplate.Name)
	SetSkillLevel (Mission.Musashi, Mission.ShipSkillLevel)
	--SetSkillLevel (Mission.Fubuki, Mission.ShipSkillLevel)
	SetSkillLevel (Mission.Fubuki, SKILL_STUN)
	JoinFormation(Mission.Fubuki, Mission.Musashi)
	NavigatorMoveOnPath(Mission.Musashi, Mission.PathMusashi)
	SetForcedReconLevel(Mission.Musashi, 2, 0)
	AddProximityTrigger(Mission.Musashi, "ProximityMusashi1", "luaUS09MusashiClose1", Mission.NavMusashiColose1, 100)
	AddProximityTrigger(Mission.Musashi, "ProximityMusashi2", "luaUS09MusashiClose2", Mission.NavMusashiColose2, 100)

	Mission.AAGuns = {}
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,4)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,5)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,6)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,7)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,8)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,9)) --flak
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,14)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,15)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,16)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,17)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,18)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,19)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,20)) --25mm triple
		table.insert(Mission.AAGuns,GetGun(Mission.Musashi,21)) --25mm triple
	
	--[[
	for idx,gun in pairs(Mission.AAGuns) do
		AddDamage(gun,5000)
		RepairEnable(gun,false)
	end
	]]
	--Musashi hit listener (lovi a StLo -t)
	AddListener("hit", "ListenerStLoHit", {
				["callback"] = "luaUS09MusashiHitStLo", -- callback fuggveny
				["target"] = Mission.CVs, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {Mission.Musashi}, -- tamado entityk
				["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {[""] = minValue, [""] = maxValue}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {[""] = minValue, [""] = maxValue}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {[""] = minValue, [""] = maxValue}, -- ket ertek kozotti viz damage szures
				})		

	luaUS09EM_Musashi_1()
end

function luaUS09MusashiClose1()
	luaStartDialog("musashi_curve")
end

function luaUS09MusashiClose2()
	luaStartDialog("musashi_halfway")
end

function luaUS09Cp2_KillShipyards()
-- RELEASE_LOGOFF  	luaLog("MASODIK")
	for idx,unit in pairs (Mission.PTHangars) do
		SetInvincible(unit,false)
		AddDamage(unit,10000)
	end
	Mission.LastShipyard = Mission.Shipyards[2]
end

function luaUS09PhaseManager()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if num[1] == 1 then
		Mission.MissionPhase = 3
		Mission.FirstRun = false
		--Shipyards invincible
-- RELEASE_LOGOFF  		luaLog("PHASEMANAGER SHIT")
		for idx,unit in pairs(Mission.Shipyards) do
			SetInvincible(unit, true)
		end
		for idx,unit in pairs(Mission.PTHangars) do
			SetInvincible(unit, true)
		end
		luaUS09PreparePhase3()
	elseif num[1] == 2 then
		Mission.MissionPhase = 5
		Mission.FirstRun = false
		Mission.Phase5ThinkCounter = 0
		luaUS09PreparePhase5()
	end
	AddListener("kill", "listenerCVKilled", {
				["callback"] = "luaUS09CVKilled",
				["entity"] = Mission.CVs,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
				})
end

function luaUS09SecondaryInit()
	if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary",1) == nil then
		Mission.TurretsKilled = Mission.Checkpoint.TurretsKilled
		Mission.Turrets = luaRemoveDeadsFromTable(Mission.Turrets)
		luaDelay(luaUS09DisplaySecondaryAfterLoading,10)
	end
end

function luaUS09DisplaySecondaryAfterLoading()
	--DisplayScores(2,0,"usn09.obj_s1","usn09.obj_s1_display")
end

--[[
*****************************************************************************************
**                         			  CHEATS 	   	                                   **
*****************************************************************************************
]]

function luaUS09Phase()
	if Mission.MissionPhase == 2 then
		RemoveTrigger(Mission.Airfield, "ProximityAirfield")
		luaUS09AirfieldDetected()
	elseif Mission.MissionPhase == 3 then
		AddDamage(Mission.Hangar,10000)
	elseif Mission.MissionPhase == 4 then
		for idx,unit in pairs(Mission.Shipyards) do
			AddDamage(unit,10000)
		end
	elseif Mission.MissionPhase == 5 then
		AddDamage(Mission.Musashi,15000)
	end
end

function luaPrecacheUnits()
	Loading_Start()
	--PrepareClass(203)--kamikaze zero (gyengebb sebzesu verzio)
	--PrepareClass(204)--kamikaze val (gyengebb sebzesu verzio)
	PrepareClass(45)--kamikaze zero 
	PrepareClass(46)--kamikaze val 
	PrepareClass(77)--japan PT
	PrepareClass(102)--Corsair
	PrepareClass(171)--Pete
	PrepareClass(116)--B-17
	Loading_Finish()
end

--[[
*****************************************************************************************
**                         			  DEMO FUNCTIONS                                   **
*****************************************************************************************
]]

function luaUS09Teszt()
	if not DEMO_2009_JAN then
		MissionNarrative("LOKASZT")
	end
end

function luaUS09MapHint()
	ShowHint("USN09_Hint_Map")
end

function luaUS09SwitchHint()
	ShowHint("USN09_Hint_Switch_Unit")
end