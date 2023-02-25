 --SceneFile="missions\USN\usn_11_protecting_iowa.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")

--[[
	Notes:
		- ha hozzaadok egy player unitot az USN_Units tablahoz, akkor remove-olni, majd ujra addolni a listenert Listener_PlayerUnitDied
		- RepairEnable(entity, boolean)
		
]]--

--[[
	TODO:
		- avoid zone-t legeneralni
		- Script zaras elott a vegerol a debug fv-eket kiszedni!
		
		
Mission Redesign:
		- EM-ben Catalina repul, eszreveszi a transport hajokat
		- Subot iranyitjuk, meg kell semmisiteni 5 transport hajot (sziget japoke, de semleges)
		- ezutan ingame EM -> Catalina eszreveszi, hogy a sziget a japoke, kov. obj. semmisitsd meg a subbal a PT hangarokat
		- japo PT-k spawnolnak idonkent a hangarbol
		- ezutan ingam EM -> Catalina all a hangar mellett
		- kov. obj: Catalinaval fel kell szallni es torpdozni az erkezo cirkalot
		- Catalina reloadol, amig meg nem semmisul
		- ha megsemmisult, es meg nem nyirta ki a cirkalot, akkor a subbal meg van lehetosege a playernek
		- blackout, majd a subot iranyitjuk (a torpedot urja toltjuk). Ha ez is megsemmisul, akkor mission failed
		- a cirkalot par destroyer kiseri
		
		
		Taskok:
		- PlaneChangeAmmoType(nEquipment) -> uj equipmentet lehet adni a selectedunit-nak
		- sebzeshez szintek: 0, 20, 50, 80 m
		- fazisvaltasokkor kikillezni a kilott torpedokat
		
		- utolso fazisban, ha a DD-k megerkeztek a pos-ra, akkor figyelni, hogy kozelukbe ert -e mar a sub, ha igen, akkor a DD-k tamadjak a subot
		- 1. fazis szoveg: minden konvoj hajo megsemmisulesnel a szovegben aszondja, hogy: egy konvoj megsemmisult -> atirni
		- a hidden Pete bombaja nagyon kicsit sebez, erre kitalalni valamit
		- ha a buildingek GuiName-e megjavul, akkor kitorolni a SetGuiName-et ra
		- a HijackedPlane-t most nem lehet megsemmisiteni addig, amig meg nem szerzi a player. Azert van, mert ha nem rakok ra sebezhetetlenseget, akkor magatol felrobban (bugos)
		
]]--

------------------------------------------------------------------------------
function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	--MessageMap betoltese
	LoadMessageMap("usn11dlg",1)
	EnableMessages(false)
	luaDelay(luaUSN11_Date, 3)
	luaDelay(luaUSN11_DialogEM01, 14)
	UnitHoldFire(FindEntity("Minekaze-class 01"))
	UnitHoldFire(FindEntity("Japan Cargo Transport 01"))
	UnitHoldFire(FindEntity("Japan Cargo Transport 02"))
	UnitHoldFire(FindEntity("Japan Cargo Transport 03"))
	UnitHoldFire(FindEntity("Japan Cargo Transport 04"))
end

------------------------------------------------------------------------------		
function luaUSN11_Date()
	MissionNarrative("usn11.date_location")
end
		
------------------------------------------------------------------------------		
function luaUSN11_DialogEM01()
	local Dialogs = {
		["intro01"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
			},
		},
	}
	StartDialog("intro01", Dialogs["intro01"])
	luaDelay(luaUSN11_DialogEM02, 10)
end		

------------------------------------------------------------------------------
function luaUSN11_DialogEM02()
	local Dialogs = {
		["intro02"] = {
			["sequence"] = {
				{
					["message"] = "idlg01b",
				},
			},
		},
	}
	StartDialog("intro02", Dialogs["intro02"])
	luaDelay(luaUSN11_DialogEM03, 2)
end

------------------------------------------------------------------------------
function luaUSN11_DialogEM03()
	local Dialogs = {
		["intro03"] = {
			["sequence"] = {
				{
					["message"] = "idlg01c",
				},
			},
		},
	}
	StartDialog("intro03", Dialogs["intro03"])
	luaDelay(luaUSN11_DialogEM04, 1)
end

------------------------------------------------------------------------------
function luaUSN11_DialogEM04()
	local Dialogs = {
		["intro04"] = {
			["sequence"] = {
				{
					["message"] = "idlg01d",
				},
			},
		},
	}
	StartDialog("intro04", Dialogs["intro04"])
end
------------------------------------------------------------------------------
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaUSN11Init")
	Scoring_RealPlayTimeRunning(true)
end

------------------------------------------------------------------------------
function luaUSN11Init(this)
	Mission = this
	this.Name = "US11"
	this.ScriptFile = "SCRIPTS/missions/USN/usn_11_Protecting_Iowa.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	
	--for debug only--
	--TODO: Veglegesben false-ra rakni
	this.Debug = false
	if (this.Debug) then
-- RELEASE_LOGOFF  		luaLog("Mission running in Script DEBUG mode!")
		this.UnlockLvl = 0
	end
	--for debug only end--
	
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	--Mission beallitasok
	this.Party = PARTY_ALLIED

	--difficulty
	this.difficulty = GetDifficulty()
	
	--global Constants
	this.MPStoKTS												= 1.94			-- 1 m/s = 1.94 knots
	this.ConvoyShipsNeedToDestroy 			= 4
	this.NumberOfConvoyShips 						= 4
	this.SpeedOfConvoy 									= KTS(10)
	this.RepairHPPercentage 						= 0.5				-- a HP-janak max ennyi %-ra gyogyulhat fel az Iowa
	this.NumberOfJapanSubs							= 5
	this.TorpedoNumAtReload							= 40
	this.HijackedPlaneDamagePerc				= 20				-- hitkor 20%-ot sebzek az elrabolhato gepen
	
	--global variables
	this.MissionPhase 				= 1
	this.EndMission 					= false
	this.FirstRun 						= 1
	this.MissionCounter 			= 0
	this.ConvoyShipDestroyed 	= 0
	this.Sub01Spotted 				= false		-- erteke igaz, ha a kezdo subot eszrevette egy destroyer
	this.EM01									= false		-- erteke true, ha lejatszodott mar az EM01
	this.CruiserChase					= false		-- erteke true, ha a cruiserek uldozik az Iowa-t, ilyenkor folyamatosan az Iowa pociziojara kapnak move commandot
	this.RepairEnable					= false		-- erteke true, ha az Iowa javithajta magat
	--this.CheckIowaZone				= true		-- erteke true, ha phase3-ban az Iowa elhagyta a 2 sziget kozotti oblot, ekkor kezdik el tamadni a subok
	--this.JAPPTsSpawning				= false		-- erteke true, ha a phase2-ben a PT-k spawnolhatnak
	this.ReloadMarkerPos			= {}
	this.ReloadNum						=	0				-- ebben szamolom, hogy hanyszor reloadolt a Catalina
	this.EnableReload					= false		-- erteke true, ha a Catalina reloadolhat
	this.EnableHintSubdepth		= false		-- erteke true, ha a Sub sullyedeses hint kiirhato (csak az elejen hasznalom kesleltetesre)
	--this.EnablePeteAttack			= false		-- erteke true, ha a Pete-ek tamadhatnak. Akkor tamadhatnak, ha a sub a vizfelszinen van, egyebkent pos-ra mennek
	this.EMPlaying						= false		-- erteke true, ha eppen engine movie jatszodik. A showhint fv-nel hasznalom
	this.HiddenActive					= false		-- erteke true addig, amig lehet teljesiteni a hiddent
	this.SetPeteAvailable			= false		-- erteke true, ha az ellopott Pete elerhetove valik es mar dobtunk hintet errol a playernek
	this.ReloadDistance				= 0				-- lockit miatt van globalis valtozoban, displayscore-hoz hasznalom
	this.AttackManagerActive	= false		-- erteke true, ha tamadnia kell a DD-knek az 1. fazisban
	this.HijackedPlaneMaxHP		= 0				-- ennyi a HP-ja az elrabolhato gepnek (Class HP)
	this.HijackedPlaneDamage	= 0				-- ennyit sebzek mindenegyes hitkor az elrabolhato gepen ( = Class HP * DamagePerc)
	this.NumberofJakesKilled = 0		-- poweruphoz számolni kell, hány recont lõtt le
	
	--Mission narratives
	this.Narratives = {}
		table.insert(this.Narratives, "Some cruisers got loose from the convoy. They headed to Iowa. We must stop them")
		-- Mission elejen subban ulunk: semmisitsuk meg az erkezo transport hajokat
		-- Subban ulunk: eszrevesznek a destroyerek - Destroyerek kozelednek, vigyazzunk
		-- Levalnak a cruiserek, elindulnak az Iowa fele
		-- Amerikai subok (3db) spawnolnak, megkapjuk az iranyitast
		-- Iowa-t eloszor talalat erte
		-- Megsemmisitettuk az osszes cruisert
		-- Iowa elindul a kikotobol az evac zone fele
		-- tengeralatti mozgast eszleltek eszakra (Iowa utvonalan), kuldjunk ki Catalinakat felderiteni es fedezni az Iowa-t
	
	--Precache
	
	--allied hajok
	this.ChangeableNames = {}
	this.ChangeableNames[30] = {"ingame.shipnames_halibut"}	-- Gato
	
	this.USN_Units = {}
		table.insert(this.USN_Units, FindEntity("Narwhal-class Submarine 01"))
	--this.USN_Iowa = {}
		--table.insert(this.USN_Iowa, FindEntity("Iowa Class 01"))

	--allied submarines
	this.USN_Sub01 = {}
		table.insert(this.USN_Sub01, FindEntity("Narwhal-class Submarine 01"))
		if IsClassChanged(this.USN_Sub01[1].ClassID) then
			luaSetUnlockName(this.USN_Sub01[1])
		else
			SetGuiName(this.USN_Sub01[1], "ingame.shipnames_nautilus")
		end
		ShipSetTorpedoStock(Mission.USN_Sub01[1], Mission.TorpedoNumAtReload)
	
	--this.USN_SubDefense = {}

	--allied repulok
	this.USN_Plane = {}
		table.insert(this.USN_Plane, FindEntity("PBY Catalina 01"))
	
	--Level Bomber unlock unit
	
	--allied path-ok, navpointok
	this.USN_SubWaypoints = {}
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Sub01"))		-- Phase2 startkor a sub pozicioja
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_SubReload"))	-- Phase3 startkor a sub pozicioja (reload)
		
		--[[table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Center01"))
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Center03"))
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Center04"))
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Center05"))
		table.insert(this.USN_SubWaypoints, FindEntity("Navpoint_Center06"))]]--
	this.USN_CatalinaWaypoints = {}
		table.insert(this.USN_CatalinaWaypoints, FindEntity("Navpoint_Catalina01"))		-- Phase2 start-kor a Catalina pozicioja
		table.insert(this.USN_CatalinaWaypoints, FindEntity("Navpoint_CatalinaReload"))		-- Phase3 start-kor a Catalina pozicioja (reload)
		table.insert(this.USN_CatalinaWaypoints, FindEntity("Navpoint_Catalina02"))		-- Phase2 start-kor a Catalina pozicioja
		table.insert(this.USN_CatalinaWaypoints, FindEntity("Navpoint_Catalina03"))		-- Phase2-ben erre a pontra retreat-el a Catalina
		table.insert(this.USN_CatalinaWaypoints, FindEntity("Navpoint_Catalina04"))		-- EM02-ben a Catalina start pos-a
		
	this.Area_IowaZone = {}
		table.insert(this.Area_IowaZone, FindEntity("Area01_Iowa"))
	
	this.USN_PathIowa = {}
		table.insert(this.USN_PathIowa, FindEntity("Path_Iowa"))
		
	--player shipyardok
		
	this.USN_Shipyard = {}
		table.insert(this.USN_Shipyard, FindEntity("Shipyard 01"))
		table.insert(this.USN_Shipyard, FindEntity("Shipyard 02"))
	
	--japan hajok
	this.JAP_Convoy = {}
		table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 01"))	
		this.JAP_Convoy[1].SoftKill = false		--ez azert kell, mert ha en nyirom ki a bordernel, akkor nem szamit bele a kilott convoy hajok koze
		table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 02"))
		this.JAP_Convoy[2].SoftKill = false
		table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 03"))
		this.JAP_Convoy[3].SoftKill = false
		table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 04"))
		this.JAP_Convoy[4].SoftKill = false
		--[[table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 05"))
		this.JAP_Convoy[5].SoftKill = false
		table.insert(this.JAP_Convoy, FindEntity("Japan Cargo Transport 06"))
		this.JAP_Convoy[6].SoftKill = false]]--
		
	this.JAP_DD = {}
		table.insert(this.JAP_DD, FindEntity("Minekaze-class 01"))
		this.JAP_DD[1].Attacking = false
		table.insert(this.JAP_DD, FindEntity("Minekaze-class 02"))
		this.JAP_DD[2].Attacking = false
		--table.insert(this.JAP_DD, FindEntity("Minekaze-class 03"))
		
	this.JAP_AttackManager = {}
		table.insert(this.JAP_AttackManager, this.JAP_Convoy[1])
		table.insert(this.JAP_AttackManager, this.JAP_Convoy[2])
		table.insert(this.JAP_AttackManager, this.JAP_Convoy[3])
		table.insert(this.JAP_AttackManager, this.JAP_Convoy[4])
		table.insert(this.JAP_AttackManager, this.JAP_DD[1])
		table.insert(this.JAP_AttackManager, this.JAP_DD[2])
		
	this.JAP_PT	= {}
	
	this.JAP_Planes = {}
		
	this.JAP_CruisersGroup = {}
		--table.insert(this.JAP_CruisersGroup, FindEntity("Mogami-class 01"))
		--table.insert(this.JAP_CruisersGroup, FindEntity("Mogami-class 02"))
		--table.insert(this.JAP_CruisersGroup, FindEntity("Mogami-class 03"))
	this.JAP_Cruiser = {}
	
	this.Kumano = {}	-- ezt csak Mission completedkor hasznalom, mert a JAP_Cruiser tablabol egyeb okok miatt eltavolitom
	
	this.JAP_Warships = {}
	
	--this.JAP_Subs = {}
		
	--japan repulok
	
	--japan path-ok, navpointok
	this.JAP_Navpoint_Convoy = {}
		table.insert(this.JAP_Navpoint_Convoy, FindEntity("Navpoint_West01"))	
		
	this.JAP_Navpoint_DD = {}
		table.insert(this.JAP_Navpoint_DD, FindEntity("Navpoint_West02"))
		table.insert(this.JAP_Navpoint_DD, FindEntity("Navpoint_West03"))
		
	this.JAP_Navpoint_PTsSpawn = {}
		table.insert(this.JAP_Navpoint_PTsSpawn, FindEntity("Navpoint_PTSpawn"))
		
	this.JAP_Navpoint_Cruiser = {}
		table.insert(this.JAP_Navpoint_Cruiser, FindEntity("Navpoint_CruisersGroup01"))
		table.insert(this.JAP_Navpoint_Cruiser, FindEntity("Navpoint_CruisersGroup02"))
		table.insert(this.JAP_Navpoint_Cruiser, FindEntity("Navpoint_CruisersGroup03"))
		table.insert(this.JAP_Navpoint_Cruiser, FindEntity("Navpoint_CruisersGroup04"))

	this.JAP_Marker = {}
		table.insert(this.JAP_Marker, FindEntity("Navpoint_CruiserMarker"))
		
	this.JAP_SubSpawnPoints = {}
		--[[table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North01"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North02"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North03"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North04"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North05"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North06"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North07"))
		table.insert(this.JAP_SubSpawnPoints, FindEntity("Navpoint_North08"))]]--
		
	-- japo shipyardok
	this.JAP_Hangar = {}
		--table.insert(this.JAP_Hangar, FindEntity("PTHangar 01"))
		--table.insert(this.JAP_Hangar, FindEntity("PTHangar 02"))		
		
	-- japo epuletek
	this.JAP_Buildings = {}
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 01"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 02"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 03"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 04"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 05"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 06"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 07"))
		table.insert(this.JAP_Buildings, FindEntity("Storage - Raktar03 08"))
		table.insert(this.JAP_Buildings, FindEntity("RadarStation 01"))
	this.MaxJapBuildings = table.getn(this.JAP_Buildings)
	this.RemainingJAPBuildings = this.MaxJapBuildings			-- azt tarolja, hogy hany japan epuletet kell meg megsemmisiteni -> DisplayScores-hoz kell
	-- neutral units
	this.PeteHijacked = {}
		table.insert(this.PeteHijacked, FindEntity("F1M Pete Hijacked"))
		--SetInvincible(this.PeteHijacked[1], 1)
		SetForcedReconLevel(this.PeteHijacked[1], 2, PARTY_ALLIED)
		SetParty(this.PeteHijacked[1], 2)
		
	--Ingame Engine Movie Waypointok
	this.IngameEM01_WP = {}
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Sub"))
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Catalina"))
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Jake01"))
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Jake02"))
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Jake03"))
		table.insert(this.IngameEM01_WP, FindEntity("Navpoint_IngameEM01_Jake04"))
	
	this.IngameEM02_WP = {}
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Sub"))
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Catalina"))
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Kumano"))
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Cruiser01"))
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Cruiser02"))
		table.insert(this.IngameEM02_WP, FindEntity("Navpoint_IngameEM02_Cruiser03"))
		
	--Achivements Init
	
	--music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	--engine movie
	--luaInitJumpinMovies()
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUSN11LoadMissionData, luaUSN11_Checkpoint_Cleaning, luaUSN11_Checkpoint_Preparing, luaUSN11_InitBuldingsHP,luaUSN11_Checkpoint01_PreparingPhase2_BlackOut1},
		[2] = {luaUSN11LoadMissionData, luaUSN11_Checkpoint_Cleaning, luaUSN11_Checkpoint_Preparing, luaUSN11_Checkpoint02_PreparingPhase3_Blackout1},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUSN11SaveMissionData},
		[2] = {luaUSN11SaveMissionData},
	}
	
	--dialogusok
	LoadMessageMap("usn11dlg",1)
	this.Dialogs = {
		["Init"] = {
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
				{
					["message"] = "dlg01c_1",
				},
				{
					["message"] = "dlg01d",
				},
				{	
					["type"] = "callback",
					["callback"] = "luaUSN11_DialogFiringRange",
				},
			},
		},
		["In3rdLevel"] = {
			["sequence"] = {
				{
					["message"] = "dlg02",
				},
			},
		},
		["In4thLevel"] = {
			["sequence"] = {
				{
					["message"] = "dlg03",
				},
			},
		},
		["FiringRange"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a",
				},
				{
					["message"] = "dlg04b",
				},
			},
		},
		["ConvoyDestroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
			},
		},
		["EM01_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
			},
		},
		["EM01_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg06b",
				},
			},
		},
		["EM01_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg06c",
				},
			},
		},
		["BuildingsDestroyed"] = {
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
				{
					["message"] = "dlg08d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUSN11_PreparingPhase3_Blackout1",
				},
			},
		},
		["EM02_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg09e",
				},
			},
		},
		["EM02_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
			},
		},
		["EM02_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg09c",
				},
			},
		},
		["EM02_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg09d",
				},
			},
		},
		["EM02_05"] = {
			["sequence"] = {
				{
					["message"] = "dlg09b",
				},
			},
		},
		["TorpedosLoaded"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
				--[[{
					["message"] = "dlg10c",
				},]]--
			},
		},
		["DestroyerThreat"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["BombersIncoming"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
			},
		},
		["CruiserOnHalfway"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["RadioMessage"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["message"] = "dlg15_1",
				},
			},
		},
		["ReconplaneAcquired"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
				{
					["message"] = "dlg16b",
				},
			},
		},
		["ReconplaneAcquired_2ndPhase"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
			},
		},
		["DisguiseFall"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
	}
	
	--SoundFade(1, "", 1)
	
	SetSimplifiedReconMultiplier(0.5)
	
	BannSupportmanager()
	
	luaInitNewSystems()

    --SetDeviceReloadTimeMul(0)
    SetThink(this, "luaUSN11Think")
	
	--Objectives
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "Convoy",		-- azonosito
				["Text"] = "usn11.obj_p1", -- "Destroy the transport ships",
				["TextCompleted"] = "usn11.obj_p1_compl", --"The transport ships have been destroyed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn11.obj_p1_fail", --"You couldn't destroy the transport ships",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "Buildings",		-- azonosito
				["Text"] = "usn11.obj_p2", --"Destroy the desiganted buildings",
				["TextCompleted"] = "usn11.obj_p2_compl", --"The designated buildings have destroyed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "You failed to destroy the designated buildings",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "Cruisers",		-- azonosito
				["Text"] = "usn11.obj_p3", --"Destroy the flagship",
				["TextCompleted"] = "usn11.obj_p3_compl", --"You have destroyed the flagship" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "You couldn't destroy the flagship",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["secondary"] = {
			[1] =
			{
				["ID"] = "TransportDD",		-- azonosito
				["Text"] = "usn11.obj_s1", --"Destroy all of the DDs escorting the transportships",
				["TextCompleted"] = "usn11.obj_s1_compl", --"All DDs have been destroyed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["hidden"] = 
		{
			[1] =
			{
				["ID"] = "CatalinaAlive",		-- azonosito
				["Text"] = "usn11.obj_h1", 	-- "Not even a single japanese cargo managed to unload",
				["TextCompleted"] = "", 		-- "You have successfuly destroyed the japanese Command Center" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", 				-- "You couldn't destroy the japanese Command Center",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["marker2"] = 
		{
			[1] =
			{
				["ID"] = "LandingPoint",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0,
			},
		},
		["marker3"] = 
		{
			[1] =
			{
				["ID"] = "Cruiser",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0,
			},
		},
	}
	luaObj_FillSingleScores()
	--EM holdfire visszaallitas
	UnitFreeFire(FindEntity("Minekaze-class 01"))
	UnitFreeFire(FindEntity("Japan Cargo Transport 01"))
	UnitFreeFire(FindEntity("Japan Cargo Transport 02"))
	UnitFreeFire(FindEntity("Japan Cargo Transport 03"))
	UnitFreeFire(FindEntity("Japan Cargo Transport 04"))
		
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	luaCheckSavedCheckpoint()
	
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		SetSelectedUnit(this.USN_Sub01[1])
	else
		Mission.MissionPhase = 100
		--Blackout(true, "", 0)
		BlackBars(true)
	end
	
end

------------------------------------------------------------------------------
function luaUSN11Think(this, msg)
	if luaMessageHandler(Mission, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." is terminated!")
		return
	end
	
	if (Mission.EndMission) then
		return
	end
	
	--debug--
	--AddWatch()
	--debug--
	
	Mission.MissionCounter = Mission.MissionCounter + 1
	luaCheckMusic()

	luaUSN11_RemoveDeadsFromTable()
	--luaUSN11_CruiserChase()
	--luaUSN11_IowaRepairing()
	
	luaUSN11_CheckDepth()
	
	luaUSN11_Hint_SubDepth()
	
	luaUSN11_CheckHidden()
		
	if (Mission.MissionPhase == 1) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			EnableMessages(true)
			luaUSN11_StartingBlackout()
			luaUSN11_InitPlayerUnits()
			luaUSN11_InitBuldingsHP()
			luaDelay(luaUSN11_InitPRI01, 3)
			luaDelay(luaUSN11_InitHid01, 4)
			luaDelay(luaUSN11_InitSec01, 5)
			luaDelay(luaUSN11_DialogInit, 8)	--TEST: 
			luaUSN11_InitJAPUnits()
			luaDelay(luaUSN11_InitReconListener, 3)
			--luaUSN11_InitIowaHitListener()
			luaDelay(luaUSN11_EnableHintSubDepth, 45)
			luaUSN11_InitAttackManager()
			--luaUSN11_InitHijackedPlane()
		end
		luaUSN11_CheckPRI01()
		luaUSN11_CheckSec01()
		luaUSN11_AttackManager()
	elseif (Mission.MissionPhase == 2) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN11_InitJakeListener()
			--luaUSN11_InitPhase2()
			--luaUSN11_PlayerSubsSpawning()
			--luaUSN11_IowaSetup()
			--luaUSN11_InitPRI02()
			--luaUSN11_InitPri03()
			
			--Mission.JAPPTsSpawning = true
			--luaDelay(luaUSN11_JAPPTsSpawning, 4)
		end
		luaUSN11_PeteManager()
	elseif (Mission.MissionPhase == 3) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			--[[luaUSN11_InitShipyards()
			luaUSN11_InitIowaMove()
			luaUSN11_SpawnJAPSubs()]]--
			luaUSN11_CheckReloadArea()
		end
		--luaUSN11_DisplayDistanceReload()
		luaUSN11_CheckPlayerUnits()
		--luaUSN11_RefreshMarkerPos()
	end
end

------------------------------------------------------------------------------
function luaUSN11_StartingBlackout()
	Blackout(true, "", 0.5, 0)
end
------------------------------------------------------------------------------
function luaUSN11_InitJAPUnits()
	luaUSN11_InitSkillLevels()
	luaUSN11_InitConvoyMove()
	luaUSN11_InitDDMove()
	luaUSN11_InitConvoyListener()
	--SetInvincible(Mission.JAP_Hangar[1], 1)
	--SetInvincible(Mission.JAP_Hangar[2], 1)
	--[[SetInvincible(Mission.JAP_Buildings[1], 1)
	SetInvincible(Mission.JAP_Buildings[2], 1)
	SetInvincible(Mission.JAP_Buildings[3], 1)
	SetInvincible(Mission.JAP_Buildings[4], 1)
	SetInvincible(Mission.JAP_Buildings[5], 1)]]--
	--luaUSN11_InitCruiserMove()
	--luaUSN11_InitCruiserKillListener()
	for i, pBuilding in pairs (Mission.JAP_Buildings) do
		SetInvincible(pBuilding, 1)
		--SetGuiName(pBuilding, "usn11.storage")
		SetForcedReconLevel(pBuilding, 2, PARTY_JAPANESE)
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitSkillLevels()
	for i, pUnit in pairs (Mission.JAP_DD) do
		if (Mission.difficulty == 0) then
			SetSkillLevel(pUnit, SKILL_SPNORMAL)
			TorpedoEnable(pUnit, false)
			NavigatorSetTorpedoEvasion(pUnit, false)
		elseif (Mission.difficulty == 1) then
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
			TorpedoEnable(pUnit, false)
			NavigatorSetTorpedoEvasion(pUnit, true)
		elseif (Mission.difficulty == 2) then
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
			TorpedoEnable(pUnit, true)
			NavigatorSetTorpedoEvasion(pUnit, true)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_RemoveDeadsFromTable()
	Mission.JAP_Convoy = luaRemoveDeadsFromTable(Mission.JAP_Convoy)
	Mission.JAP_CruisersGroup = luaRemoveDeadsFromTable(Mission.JAP_CruisersGroup)
	Mission.USN_Units = luaRemoveDeadsFromTable(Mission.USN_Units)
	Mission.JAP_DD = luaRemoveDeadsFromTable(Mission.JAP_DD)
	Mission.JAP_Warships = luaRemoveDeadsFromTable(Mission.JAP_Warships)
end

------------------------------------------------------------------------------
function luaUSN11_Hint_SubDepth()
	if (Mission.USN_Sub01 ~= nil) and (not Mission.USN_Sub01[1].Dead) and (IsPlayerControlled(Mission.USN_Sub01[1])) and (Mission.EnableHintSubdepth) then
		luaUSN11_ShowHint("USN11_Hint_Subdepth")
	end
end

------------------------------------------------------------------------------
function luaUSN11_EnableHintSubDepth()
	Mission.EnableHintSubdepth = true
end

------------------------------------------------------------------------------
function luaUSN11_InitHijackedPlane()		-- meg kellett fakezni, mert a Pete allandoan felrobbant -> most invincible + hit listenerbol sebzem
	if (not IsListenerActive("hit", "Listener_HijackedPlane")) then
		AddListener("hit", "Listener_HijackedPlane", {
			["callback"] = "luaUSN11_HijackedPlaneWasHit", -- callback fuggveny
			["target"] = Mission.PeteHijacked, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_InitAttackManager): Attack manager listener beregisztralva")
		--LogToConsole("Attack manager listener beregisztralva")
	end
	Mission.HijackedPlaneMaxHP = Mission.PeteHijacked[1].Class.HP
	Mission.HijackedPlaneDamage = Mission.HijackedPlaneMaxHP * Mission.HijackedPlaneDamagePerc
end

------------------------------------------------------------------------------
function luaUSN11_HijackedPlaneWasHit(...)
	if (arg[1] ~= nil) and (arg[3] ~= nil) then
		AddDamage(Mission.PeteHijacked[1], Mission.HijackedPlaneDamage)
		local nHP = GetHpPercentage(Mission.PeteHijacked[1])
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_HijackedPlaneWasHit): HijackedHP = "..nHP)
		if (nHP == 0) then
			RemoveListener("hit", "Listener_HijackedPlane")
-- RELEASE_LOGOFF  			luaLog("(luaUSN11_HijackedPlaneWasHit): Az elrabolhato gep megsemmisult")
		end
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_HijackedPlaneWasHit): a target vagy az attacker param nil -> nincs sebzes")
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitAttackManager()
	if (not IsListenerActive("hit", "Listener_AttackManager")) then
		AddListener("hit", "Listener_AttackManager", {
			["callback"] = "luaUSN11_UnitWasHit", -- callback fuggveny
			["target"] = Mission.JAP_AttackManager, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_InitAttackManager): Attack manager listener beregisztralva")
		--LogToConsole("Attack manager listener beregisztralva")
	end
end

------------------------------------------------------------------------------
function luaUSN11_UnitWasHit()
	if (IsListenerActive("hit", "Listener_AttackManager")) then
		RemoveListener("hit", "Listener_AttackManager")
	end
	Mission.AttackManagerActive = true
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_UnitWasHit): A convoy-t vagy az egyik DD-t eltalaltak. AttackManager aktiv.")
	--LogToConsole("A convoy-t vagy az egyik DD-t eltalaltak. AttackManager aktiv.")
end

------------------------------------------------------------------------------
function luaUSN11_AttackManager()
	if (Mission.AttackManagerActive) and (table.getn(Mission.USN_Sub01) > 0) and (not Mission.USN_Sub01[1].Dead) and (table.getn(Mission.JAP_DD) > 0) then
		Mission.JAP_DD = luaRemoveDeadsFromTable(Mission.JAP_DD)
		local bIsAttacking = false
		local nClosestDistance = 100000
		local nIndex = 0
		for i, pShip in pairs (Mission.JAP_DD) do
			if (pShip.Attacking) then
				bIsAttacking = true
			end
			tTemp = luaGetDistance(pShip, Mission.USN_Sub01[1])
			if (tTemp < nClosestDistance) then
				nClosestDistance = tTemp
				nIndex = i
			end
		end
		if (not bIsAttacking) and (nIndex > 0) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN11_AttackManager): Nem tamadott senki, a legkozelebbi DD: "..Mission.JAP_DD[nIndex].Name)
			--LogToConsole("Nem tamadott senki, a legkozelebbi DD: "..Mission.JAP_DD[nIndex].Name)
			pUnit = Mission.JAP_DD[nIndex]
			local nMaxSpeed = VehicleClass[pUnit.Class.ID].MaxSpeed
			SetShipMaxSpeed(pUnit, nMaxSpeed)
			--TorpedoEnable(pUnit, true)
			luaSetScriptTarget(pUnit, Mission.USN_Sub01[1])
			NavigatorAttackMove(pUnit, Mission.USN_Sub01[1], {})
			pUnit.Attacking = true
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitPlayerUnits()
	AddUntouchableUnit(Mission.USN_Plane[1])
	SetInvincible(Mission.USN_Plane[1], 1)
	SetRoleAvailable(Mission.USN_Plane[1], EROLF_ALL, PLAYER_AI)
	PilotMoveToRange(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[3], 100)
	SetSubmarineDepthLevel(Mission.USN_Sub01[1], 1)
	UnitHoldFire(Mission.USN_Sub01[1])
	SetShipSpeed(Mission.USN_Sub01[1], 3)
	AddListener("kill", "Listener_SubDied", 
	{
			["callback"] = "luaUSN11_SubDied",
			["entity"] = Mission.USN_Sub01,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
	if (not IsListenerActive("exitzone", "Listener_SubExited")) then
		AddListener("exitzone", "Listener_SubExited", 
		{
				["callback"] = "luaUSN11_SubDied",
				["entity"] = Mission.USN_Sub01,
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	end
	Mission.RepairEnable = true
	luaDelay(luaUSN11_DialogTransportShips, 5)
end

------------------------------------------------------------------------------
function luaUSN11_InitBuldingsHP()
	for i, pBuilding in pairs (Mission.JAP_Buildings) do
		if (pBuilding.Class.ID == 114) then
			OverrideHP(pBuilding, 600)
		elseif (pBuilding.Class.ID == 720) then
			OverrideHP(pBuilding, 400)
		elseif (pBuilding.Class.ID == 514) then
			OverrideHP(pBuilding, 300)
		elseif (pBuilding.Class.ID == 511) then
			OverrideHP(pBuilding, 400)
		elseif (pBuilding.Class.ID == 571) then
			OverrideHP(pBuilding, 300)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_StartDialog(szDialogID)
	if (Mission.Dialogs[szDialogID].printed == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = nil")
	elseif (Mission.Dialogs[szDialogID].printed == false) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = false")
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = true")
	end
	if (Mission.Dialogs[szDialogID].printed == nil) or (Mission.Dialogs[szDialogID].printed == false) then
		Mission.Dialogs[szDialogID].printed = true
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID)
		StartDialog(szDialogID, Mission.Dialogs[szDialogID])
	end
end

------------------------------------------------------------------------------
function luaUSN11_DialogTransportShips()
	--luaUSN11_StartDialog("Transport_Ships")
end

------------------------------------------------------------------------------
function luaUSN11_SubDied(pEntity)
	pEntity.Dead = true
	Mission.USN_Units = luaRemoveDeadsFromTable(Mission.USN_Units)
	if (table.getn(Mission.USN_Units) == 0) then
		if (IsListenerActive("kill", "Listener_SubDied")) then
			RemoveListener("kill", "Listener_SubDied")
		end
		if (IsListenerActive("exitzone", "Listener_SubExited")) then
			RemoveListener("exitzone", "Listener_SubExited")
		end
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_CheckNumberOfUSNUnits): Megsemmisult az osszes player unit. Mission Failed")
		luaUSN11_MissionFailed(pEntity, "usn11.submarine_destroyed")
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitPRI01()
	luaObj_Add("primary", 1, Mission.JAP_Convoy)
	DisplayScores(1,0, "usn11.obj_p1", "usn11.score01")
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitPRI01): PRI01 addolva")
end

------------------------------------------------------------------------------
function luaUSN11_InitSec01()
	luaObj_Add("secondary", 1, Mission.JAP_DD)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitSec01): SEC01 addolva")
end

------------------------------------------------------------------------------
function luaUSN11_InitHid01()
	luaObj_Add("hidden", 1)
	Mission.HiddenActive = true
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitHid01): HID01 addolva")
end

------------------------------------------------------------------------------
function luaUSN11_DialogInit()
	luaUSN11_StartDialog("Init")
end

------------------------------------------------------------------------------
function luaUSN11_DialogFiringRange()
	luaUSN11_StartDialog("FiringRange")
end
------------------------------------------------------------------------------
function luaUSN11_InitConvoyMove()
	for i, pUnit in pairs (Mission.JAP_Convoy)do
		SetShipMaxSpeed(pUnit, Mission.SpeedOfConvoy)
		NavigatorMoveToRange(pUnit, Mission.JAP_Navpoint_Convoy[1])
		AddProximityTrigger(pUnit, "ConvoyShipReachedEvacPoint", "luaUSN11_ConvoyShipReachedEvacZone", Mission.JAP_Navpoint_Convoy[1], 800)
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitConvoyListener()
	AddListener("kill", "Listener_ConvoyShipWasDestroyed", 
	{
			["callback"] = "luaUSN11_ConvoyShipWasDestroyed",
			["entity"] = Mission.JAP_Convoy,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

------------------------------------------------------------------------------
function luaUSN11_ConvoyShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Convoy = luaRemoveDeadsFromTable(Mission.JAP_Convoy)
	Mission.ConvoyShipsNeedToDestroy = Mission.ConvoyShipsNeedToDestroy - 1
	DisplayScores(1,0, "usn11.obj_p1", "usn11.score01")
end

------------------------------------------------------------------------------
function luaUSN11_ConvoyShipReachedEvacZone(pEntity)
	if (luaObj_IsActive("primary", 1) and (luaObj_GetSuccess("primary", 1) == nil)) then
		luaObj_Failed("primary", 1)
	end
	--[[pEntity.SoftKill = true
	Kill(pEntity, true)]]--
	Mission.JAP_Convoy = luaRemoveDeadsFromTable(Mission.JAP_Convoy)
	for i, pShip in pairs (Mission.JAP_Convoy) do
		SetInvincible(pShip, 1)
	end
	luaUSN11_MissionFailed(Mission.JAP_Convoy[1], "usn11.obj_p1_fail")	--"One of the convoy has escaped. Mission Failed")
-- RELEASE_LOGOFF  	luaLog("One of the convoy has escaped. Mission Failed")
end

------------------------------------------------------------------------------
function luaUSN11_CheckPRI01()
	--if (Mission.ConvoyShipDestroyed >= Mission.ConvoyShipsNeedToDestroy) then
	if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		if (table.getn(Mission.JAP_Convoy) == 0) then
			luaObj_Completed("primary", 1, true)
			if (IsListenerActive("recon", "Listener_SubSpotted")) then
				RemoveListener("recon", "Listener_SubSpotted")
			end
			--luaCheckpoint(1, nil)
			HideScoreDisplay(1, 0)
-- RELEASE_LOGOFF  			luaLog("(luaUSN11_CheckPRI01): PRI01 obj completed")
			SetInvincible(Mission.USN_Sub01[1], 1)
			luaDelay(luaUSN11_PreparingPhase2_BlackOut1, 10)
			KillDialog("ConvoyDestroyed")
			Mission.Dialogs["ConvoyDestroyed"].printed = false
			luaUSN11_StartDialog("ConvoyDestroyed")	--TEST: 
			Mission.MissionPhase = 100
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_CheckSec01()
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) and (table.getn(Mission.JAP_DD) == 0) then
		luaObj_Completed("secondary", 1, true)
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_CheckSec01): Sec01 objective completed")
	end
end

------------------------------------------------------------------------------
function luaUSN11_PreparingPhase2_BlackOut1()
	Blackout(true, "luaUSN11_SaveCheckpoint01", 3, 1)
end

------------------------------------------------------------------------------
function luaUSN11_SaveCheckpoint01()
	--luaCheckpoint(1, nil)
	luaUSN11_PreparingPhase2_BlackOut1End()
end

------------------------------------------------------------------------------
function luaUSN11_Checkpoint01_PreparingPhase2_BlackOut1()
	Blackout(true, "", 0, 1)
	luaUSN11_PreparingPhase2_BlackOut1End()
end

------------------------------------------------------------------------------
function luaUSN11_PreparingPhase2_BlackOut1End()
	Mission.JAP_DD = luaRemoveDeadsFromTable(Mission.JAP_DD)
	if (table.getn(Mission.JAP_DD) > 0) then
		if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
			luaObj_Failed("secondary", 1)
		end
		for i, pDD in pairs (Mission.JAP_DD) do
			if (not Mission.JAP_DD[i].Dead) then
				Kill(pDD, true)
			end
		end
	end
	SetInvincible(Mission.USN_Plane[1], 1)
	PilotStop(Mission.USN_Plane[1])
	SetRoleAvailable(Mission.USN_Plane[1], EROLF_ALL, PLAYER_AI)
	local nPos = GetPosition(Mission.USN_CatalinaWaypoints[1])
	nPos["y"] = 100
	PutTo(Mission.USN_Plane[1], nPos, 20)
	nPos = GetPosition(Mission.USN_CatalinaWaypoints[2])
	nPos["y"] = 100
	SquadronSetAttackAlt(Mission.USN_Plane[1], 100)
	SquadronSetTravelAlt(Mission.USN_Plane[1], 100)
	UnitHoldFire(Mission.USN_Plane[1])
	PilotMoveToRange(Mission.USN_Plane[1], nPos, 100)
	--PilotMoveToRange(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[1], 100)
	SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_AI)
	NavigatorStop(Mission.USN_Sub01[1])
	SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_1)
	UnitHoldFire(Mission.USN_Sub01[1])
	SetSubmarineDepthLevel(Mission.USN_Sub01[1], 0)
	PutTo(Mission.USN_Sub01[1], GetPosition(Mission.USN_SubWaypoints[1]), 320)
	SetInvincible(Mission.USN_Sub01[1], 0)
	SetShipSpeed(Mission.USN_Sub01[1], 10)
	for i, pBuilding in pairs (Mission.JAP_Buildings) do
		SetParty(pBuilding, PARTY_JAPANESE)
		SetInvincible(pBuilding, 0)
	end
	luaUSN11_PetesSpawning()
	Mission.EMPlaying = true
	Blackout(false, "", 3, 1)
	luaSetPartyInvincible(1, PARTY_ALLIED)
	--luaDelay(luaUSN11_CatalinaEscape_EM01, 12)
	EnableMessages(false)	-- EM miatt
	BlackBars(true)
	Mission.Delay = luaDelay(luaUSN11_EM01Dialog01, 5)
	Mission.CamScript = luaCamIngameMovieAuto(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 40, ["theta"] = 10, ["rho"] = 160, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 40, ["theta"] = 10, ["rho"] = 160, ["moveTime"] = 5, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Buildings[2], ["distance"] = 200, ["theta"] = 10, ["rho"] = 110, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Buildings[2], ["distance"] = 200, ["theta"] = 10, ["rho"] = 110, ["moveTime"] = 3, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 100, ["theta"] = 5, ["rho"] = 160, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 100, ["theta"] = 5, ["rho"] = 160, ["moveTime"] = 4, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Planes[1], ["distance"] = 20, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Planes[1], ["distance"] = 20, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 3, ["smoothtime"] = 2},
			--{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 50, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 0},
			--{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 50, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 6, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 30, ["theta"] = 15, ["rho"] = 160, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 30, ["theta"] = 15, ["rho"] = 160, ["moveTime"] = 6, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Buildings[2], ["distance"] = 1500, ["theta"] = 5, ["rho"] = 115, ["moveTime"] = 0, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 100, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 6, ["smoothtime"] = 2},
		},
		luaUSN11_EM01End,
		true)
		
	AddListener("input", "Listener_EM01", {
		["callback"] = "luaUSN11_EM01_Interrupted",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
	
	Mission.Delay2 = luaDelay(luaUSN11_BlackBarsEnd, 24)
					
		--luaUSN11_EM01End()
end

------------------------------------------------------------------------------
function luaUSN11_BlackBarsEnd()
	if (Mission.Delay2 ~= nil) and (Mission.Delay2.Dead == false) then
		DeleteScript(Mission.Delay2)
	end
	BlackBars(false)
end

------------------------------------------------------------------------------
function luaUSN11_EM01Dialog01()
	luaUSN11_StartDialog("EM01_01")
	luaUSN11_StartDialog("EM01_02")
	Mission.Delay = luaDelay(luaUSN11_EM01Dialog02, 11)
end

------------------------------------------------------------------------------
function luaUSN11_EM01Dialog02()
	luaUSN11_StartDialog("EM01_03")
end

------------------------------------------------------------------------------
function luaUSN11_CatalinaEscape_EM01()
	PilotMoveToRange(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[4], 100)
	AddProximityTrigger(Mission.USN_Plane[1], "CatalinaEvacuation", "luaUSN11_CatalinaReachedEvacZone", Mission.USN_CatalinaWaypoints[4], 300)
end

------------------------------------------------------------------------------
--[[function luaUSN11_PreparingPhase2_End()
	
end]]--

------------------------------------------------------------------------------
function luaUSN11_EM01_UnitPutTo()
	local nPos = GetPosition(Mission.IngameEM01_WP[1])
	PutTo(Mission.USN_Sub01[1], nPos, 320)
	nPos = GetPosition(Mission.IngameEM01_WP[2])
	PutTo(Mission.USN_Plane[1], nPos, 20)
	for i, pPlane in pairs (Mission.JAP_Planes) do
		nPos = GetPosition(Mission.IngameEM01_WP[i+2])
		PutTo(pPlane, nPos)
		EntityTurnToEntity(pPlane, Mission.USN_Sub01[1])
	end
end

------------------------------------------------------------------------------
function luaUSN11_EM01_Interrupted()
	if (IsListenerActive("input","Listener_EM01")) then
		RemoveListener("input","Listener_EM01")
	end
	Blackout(true, "luaUSN11_EM01_Interrupted_BlackOutEnd", 0.5)
end

------------------------------------------------------------------------------
function luaUSN11_EM01_Interrupted_BlackOutEnd()
	luaUSN11_EM01_UnitPutTo()
	luaUSN11_KillAllDialog()
	luaUSN11_EM01End()
	Blackout(false, "", 2)
end

------------------------------------------------------------------------------
function luaUSN11_EM01End()
	if Mission.CamScript.Dead == false then
			DeleteScript(Mission.CamScript)
	end
	if Mission.Delay.Dead == false then
			DeleteScript(Mission.Delay)
	end
	if (Mission.Delay2.Dead == false) then
		DeleteScript(Mission.Delay2)
	end
	if (IsListenerActive("input","Listener_EM01")) then
		RemoveListener("input","Listener_EM01")
	end
	luaSetPartyInvincible(0, PARTY_ALLIED)
	EnableMessages(true)
	EnableInput(true)
	BlackBars(false)
	SetSelectedUnit(Mission.USN_Sub01[1])
	--CheatMaxRepair(Mission.USN_Sub01[1])
	local nHPPercentage = GetHpPercentage(Mission.USN_Sub01[1])
	if (nHPPercentage < 0.3) then
		local nClassHP = Mission.USN_Sub01[1].Class.HP
		nClassHP = nClassHP * 0.3
		SetHP(Mission.USN_Sub01[1], nClassHP)
	end
	ShipSetTorpedoStock(Mission.USN_Sub01[1], Mission.TorpedoNumAtReload)
	luaDelay(luaUSN11_InitPRi02, 3)
	luaUSN11_CatalinaEscape_EM01()
	Mission.EMPlaying = false
	Mission.MissionPhase = 2
	Mission.FirstRun = true
end

------------------------------------------------------------------------------
function luaUSN11_InitPRi02()
	luaObj_Add("primary", 2, Mission.JAP_Buildings)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitPRi02): PRI02 inicializalva")
	Mission.RemainingJAPBuildings = table.getn(Mission.JAP_Buildings)
	DisplayScores(1,0, "usn11.obj_p2", "usn11.score02")
	if (not IsListenerActive("kill", "Listener_BuildingWasDestroyed")) then
		AddListener("kill", "Listener_BuildingWasDestroyed", 
		{
				["callback"] = "luaUSN11_BuildingWasDestroyed",
				["entity"] = Mission.JAP_Buildings,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	--[[AddListener("kill", "Listener_PTHangarWasDestroyed", 
	{
			["callback"] = "luaUSN11_PTHangarWasDestroyed",
			["entity"] = Mission.JAP_Hangar,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})]]--
	--SetForcedReconLevel(Mission.USN_Sub01[1], 2, PARTY_JAPANESE)
	--luaDelay(luaUSN11_DialogJAPPT, 4)
	luaDelay(luaUSN11_DialogBombersIncoming, 5)
	luaDelay(luaUSN11_Hint_Buildings, 15)
end

------------------------------------------------------------------------------
--[[function luaUSN11_DialogJAPPT()
	luaUSN11_StartDialog("JAPPT")
end]]--

------------------------------------------------------------------------------
function luaUSN11_DialogBombersIncoming()
	luaUSN11_StartDialog("BombersIncoming")
end

------------------------------------------------------------------------------
function luaUSN11_Hint_Buildings()
	luaUSN11_ShowHint("USN11_Hint_Buildings")
	--luaDelay(luaUSN11_Hint_PTHangars, 10)
end

------------------------------------------------------------------------------
--[[function luaUSN11_Hint_PTHangars()
	luaUSN11_ShowHint("USN11_Hint_PThangars")
end]]--

------------------------------------------------------------------------------
function luaUSN11_BuildingWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Buildings = luaRemoveDeadsFromTable(Mission.JAP_Buildings)
	Mission.RemainingJAPBuildings = table.getn(Mission.JAP_Buildings)
	DisplayScores(1,0, "usn11.obj_p2", "usn11.score02")
	if (table.getn(Mission.JAP_Buildings) == 0) then
		if (IsListenerActive("kill", "Listener_BuildingWasDestroyed")) then
			RemoveListener("kill", "Listener_BuildingWasDestroyed")
		end
		if (IsListenerActive("kill", "Listener_JakeWasKilled")) then
			RemoveListener("kill", "Listener_JakeWasKilled")
-- RELEASE_LOGOFF  			luaLog("(luaUSN11_BuildingWasDestroyed): JakeListener be volt regisztralva remove-oltam")
		end
		luaObj_Completed("primary", 2, true)
		--[[AddPowerup(
		{
				["classID"] = "divebomb1",
				["useLimit"] = 1,
		})]]
		--luaCheckpoint(2, nil)
		HideScoreDisplay(1, 0)
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_BuildingWasDestroyed): PRI02 completed")
		luaUSN11_StartDialog("BuildingsDestroyed")
		luaSetPartyInvincible(1, PARTY_ALLIED)
		--Mission.JAPPTsSpawning = false
		Mission.MissionPhase = 100
		-- a luaUSN11_PreparingPhase3_Blackout1() fv. a "BuildingsDestroyed" callback-jeben hivodik meg
	end
end
------------------------------------------------------------------------------
function luaUSN11_InitDDMove()
	for i, pUnit in pairs (Mission.JAP_DD) do
		--local nShipSpeed = VehicleClass[]
		SetShipMaxSpeed(pUnit, Mission.SpeedOfConvoy)
		local tPos = GetPosition(Mission.JAP_Navpoint_DD[i])
		--[[local nRndX = luaRnd(-400, 400)
		tPos["x"] = tPos["x"] + nRndX
		local nRndZ = luaRnd(-400, 400)
		tPos["z"] = tPos["z"] + nRndZ]]--
		NavigatorMoveToRange(pUnit, tPos)
	end
end

------------------------------------------------------------------------------
function luaUSN11_PetesSpawning()
	local pUnitClass = luaFindHidden("E13A Jake 01")
	local pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 01")
	pUnit.SpawnIndex = 1
	table.insert(Mission.JAP_Planes, pUnit)
	local pUnitClass = luaFindHidden("E13A Jake 02")
	local pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 02")
	pUnit.SpawnIndex = 2
	table.insert(Mission.JAP_Planes, pUnit)
	if (Mission.difficulty > 0) then
		local pUnitClass = luaFindHidden("F1M Pete 03")
		local pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 03")
		pUnit.SpawnIndex = 3
		table.insert(Mission.JAP_Planes, pUnit)
		if (Mission.difficulty > 1) then
			local pUnitClass = luaFindHidden("F1M Pete 04")
			local pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 04")
			pUnit.SpawnIndex = 4
			table.insert(Mission.JAP_Planes, pUnit)
		end
	end
	local nPos = GetPosition(Mission.USN_SubWaypoints[1])
	for i, pPlane in pairs (Mission.JAP_Planes) do
		SquadronSetAttackAlt(pPlane, 100)
		SquadronSetTravelAlt(pPlane, 100)
		SquadronSetReleaseAlt(pPlane, 100)
		--UnitFreeAttack(pPlane)
		UnitHoldFire(pPlane)
		PilotMoveTo(pPlane, nPos)
	end
	SetDeviceReloadEnabled(true)
	SetInvincible(Mission.USN_Plane[1], 1)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_PetesSpawning): tabla hossz = "..table.getn(Mission.JAP_Planes))
	--PilotMoveTo(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[4])
	--AddProximityTrigger(Mission.USN_Plane[1], "CatalinaEvacuation", "luaUSN11_CatalinaReachedEvacZone", Mission.USN_CatalinaWaypoints[4], 300)
end

------------------------------------------------------------------------------
function luaUSN11_CatalinaReachedEvacZone(pEntity)
	RemoveTrigger(Mission.USN_Plane[1], "CatalinaEvacuation")
	SetInvincible(Mission.USN_Plane[1], 0)
	Kill(Mission.USN_Plane[1], true)
end

------------------------------------------------------------------------------
function luaUSN11_InitJakeListener()
	if (IsListenerActive("kill", "Listener_JakeWasKilled")) then
		RemoveListener("kill", "Listener_JakeWasKilled")
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_InitJakeListener): JakeListener be volt regisztralva remove-oltam")
	end
	Mission.JAP_Planes = luaRemoveDeadsFromTable(Mission.JAP_Planes)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitJakeListener): tabla hossz = "..table.getn(Mission.JAP_Planes))
	AddListener("kill", "Listener_JakeWasKilled", 
	{
			["callback"] = "luaUSN11_JakeWasKilled",
			["entity"] = Mission.JAP_Planes,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitJakeListener): JakeListener ujra addoltam")
end

------------------------------------------------------------------------------
function luaUSN11_JakeWasKilled(pEntity)
	local nIndex = pEntity.SpawnIndex
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_JakeWasKilled): Egy Jake kimurdalt, ujat spawnolok a(z) "..nIndex..". posra")
	Mission.NumberofJakesKilled = Mission.NumberofJakesKilled + 1
	if Mission.NumberofJakesKilled == 3 then
		--[[AddPowerup(
		{
				["classID"] = "divebomb1",
				["useLimit"] = 1,
		})]]
	end
	pEntity.Dead = true
	local pUnitClass
	local pUnit
	local nRnd = luaRnd(1, 100)
	if (nIndex == 1) then
		if (nRnd < 51) then
			pUnitClass = luaFindHidden("E13A Jake 01")
			pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 01")
		else
			pUnitClass = luaFindHidden("F1M Pete 01")
			pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 01")
		end
		pUnit.SpawnIndex = 1
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_JakeWasKilled): Uj gep generalodott 1-es index-szel")
	elseif (nIndex == 2) then
		if (nRnd < 51) then
			pUnitClass = luaFindHidden("E13A Jake 02")
			pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 02")
		else
			pUnitClass = luaFindHidden("F1M Pete 02")
			pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 02")
		end
		pUnit.SpawnIndex = 2
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_JakeWasKilled): Uj gep generalodott 2-es index-szel")
	elseif (nIndex == 3) then
		if (nRnd < 51) then
			pUnitClass = luaFindHidden("E13A Jake 03")
			pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 03")
		else
			pUnitClass = luaFindHidden("F1M Pete 03")
			pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 03")
		end
		pUnit.SpawnIndex = 3
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_JakeWasKilled): Uj gep generalodott 3-as index-szel")
	elseif (nIndex == 4) then
		if (nRnd < 51) then
			pUnitClass = luaFindHidden("E13A Jake 04")
			pUnit = GenerateObject(pUnitClass.Name, "E13A Jake 04")
		else
			pUnitClass = luaFindHidden("F1M Pete 04")
			pUnit = GenerateObject(pUnitClass.Name, "F1M Pete 04")
		end
		pUnit.SpawnIndex = 4
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_JakeWasKilled): Uj gep generalodott 4-es index-szel")
	end
	--[[luaLog("--Generalt unit--")
-- RELEASE_LOGOFF  	luaLog(pUnit)
-- RELEASE_LOGOFF  	luaLog("-----------------")]]--
	table.insert(Mission.JAP_Planes, pUnit)
	local nPos = GetPosition(Mission.USN_SubWaypoints[1])
	SquadronSetAttackAlt(pUnit, 100)
	SquadronSetTravelAlt(pUnit, 100)
	SquadronSetReleaseAlt(pUnit, 100)
	UnitHoldFire(pUnit)
	PilotMoveTo(pUnit, nPos)
	luaUSN11_InitJakeListener()
end

------------------------------------------------------------------------------
function luaUSN11_PeteManager()
	Mission.JAP_Planes = luaRemoveDeadsFromTable(Mission.JAP_Planes)
	if (table.getn(Mission.USN_Sub01) > 0) and (not Mission.USN_Sub01[1].Dead) then
-- RELEASE_LOGOFF  		luaLog("Sub Depth = "..GetPosition(Mission.USN_Sub01[1])["y"])
		if (GetPosition(Mission.USN_Sub01[1])["y"] > -2) then --(GetSubmarineDepthLevel(Mission.USN_Sub01[1]) == 0) then
-- RELEASE_LOGOFF  			luaLog("A Pete-k tamadhatjak a subot")
			for i, pPlane in pairs (Mission.JAP_Planes) do
				local pTarget = luaGetScriptTarget(pPlane)
				if (pTarget == nil) then
-- RELEASE_LOGOFF  					luaLog(pPlane.Name..": Uj target beallitva, a regi nil volt")
					luaSetScriptTarget(pPlane, Mission.USN_Sub01[1])
					PilotSetTarget(pPlane, Mission.USN_Sub01[1])
					--[[if (table.getn(GetPayloads(pPlane)) > 0) then
						PilotBomb(pPlane, Mission.USN_Sub01[1])
					end]]--
				end
			end
		else
-- RELEASE_LOGOFF  			luaLog("A Pete-k nem tudjak tamadni a subot")
			for i, pPlane in pairs (Mission.JAP_Planes) do
				local pTarget = luaGetScriptTarget(pPlane)
				if (pTarget ~= nil) then
-- RELEASE_LOGOFF  					luaLog(pPlane.Name..": Nem volt nil a target es nem tamadhat. Target torolve.")
					luaSetScriptTarget(pPlane, nil)
					--[[local nRndX = luaRnd(-1000, 1000)
					local nRndZ = luaRnd(-1000, 1000)
					local nPos = GetPosition(Mission.USN_Sub01[1])
					nPos["x"] = nPos["x"] + nRndX
					nPos["z"] = nPos["z"] + nRndZ
					PilotMoveTo(pPlane, nPos)]]--
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_InitReconListener()
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitReconListener): Listener addolva")
	AddListener("recon", "Listener_SubSpotted", {
		["callback"] = "luaUSN11_SubWasSpotted",  -- callback fuggveny
		["entity"] = Mission.USN_Sub01, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

------------------------------------------------------------------------------
function luaUSN11_PreparingPhase3_Blackout1()
	Blackout(true, "luaUSN11_SaveCheckpoint02", 3, 1)
end

------------------------------------------------------------------------------
function luaUSN11_SaveCheckpoint02()
	--luaCheckpoint(2, nil)
	luaUSN11_PreparingPhase3_BlackOut1End()
end

------------------------------------------------------------------------------
function luaUSN11_Checkpoint02_PreparingPhase3_Blackout1()
	Blackout(true, "", 0, 1)
	luaUSN11_PreparingPhase3_BlackOut1End()
end

------------------------------------------------------------------------------
function luaUSN11_PreparingPhase3_BlackOut1End()
	--japan keszulodes
	--megmaradt PT-k kikillezese
	--[[Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
	for i, pUnit in pairs (Mission.JAP_PT) do
		Kill(Mission.JAP_PT[i])
	end]]--
	Mission.USN_Plane = luaRemoveDeadsFromTable(Mission.USN_Plane)
	if (table.getn(Mission.USN_Plane) > 0) and (not Mission.USN_Plane[1].Dead) then	-- a feltetel csak debug miatt van
		PilotStop(Mission.USN_Plane[1])
		--PlaneForceRelease(GetSquadronPlane(Mission.USN_Plane[1],0))
		local torpTable = GetSquadTorpedoes(Mission.USN_Plane[1],true)
		for idx,unit in pairs(torpTable) do
			Kill(unit)
		end
		SetDeviceReloadEnabled(false)
		PutTo(Mission.USN_Plane[1], GetPosition(Mission.USN_CatalinaWaypoints[5]), 20)
		--RemoveUntouchableUnit(Mission.USN_Plane[1])
		--itt a unit untouchable!!!
	else
		local pUnitClass = luaFindHidden("PBY Catalina 02")
		local pUnit = GenerateObject(pUnitClass.Name, "PBY Catalina 02")
		local torpTable = GetSquadTorpedoes(pUnit,true)
		for idx,unit in pairs(torpTable) do
			Kill(unit)
		end
		SetDeviceReloadEnabled(false)
		table.insert(Mission.USN_Plane, pUnit) --FindEntity("PBY Catalina 02"))	
		--[[Kill(Mission.USN_Plane[1], true)
		Mission.USN_Plane = luaRemoveDeadsFromTable(Mission.USN_Plane)]]--
	end
	
	Mission.JAP_Planes = luaRemoveDeadsFromTable(Mission.JAP_Planes)
	for i, pPlane in pairs (Mission.JAP_Planes) do
		Kill(Mission.JAP_Planes[i], true)
	end
	local pUnitClass = luaFindHidden("Minekaze-class 04")
	local pUnit = GenerateObject(pUnitClass.Name, "Minekaze-class 04")
	SetGuiName(pUnit, "ingame.shipnames_kishinami")
	table.insert(Mission.JAP_CruisersGroup, pUnit)
	table.insert(Mission.JAP_Warships, pUnit)
	--NavigatorSetTorpedoEvasion(pUnit, true)
	--TorpedoEnable(pUnit, true) 
	--SetSkillLevel(pUnit, SKILL_STUN)
	local pUnitClass = luaFindHidden("Minekaze-class 05")
	local pUnit = GenerateObject(pUnitClass.Name, "Minekaze-class 05")
	SetGuiName(pUnit, "ingame.shipnames_hamakaze")
	table.insert(Mission.JAP_CruisersGroup, pUnit)
	table.insert(Mission.JAP_Warships, pUnit)
	--NavigatorSetTorpedoEvasion(pUnit, true)
	--TorpedoEnable(pUnit, true)
	--SetSkillLevel(pUnit, SKILL_STUN)
	local pUnitClass = luaFindHidden("Minekaze-class 06")
	local pUnit = GenerateObject(pUnitClass.Name, "Minekaze-class 06")
	SetGuiName(pUnit, "ingame.shipnames_fujinami")
	table.insert(Mission.JAP_CruisersGroup, pUnit)
	table.insert(Mission.JAP_Warships, pUnit)
	--NavigatorSetTorpedoEvasion(pUnit, true)
	--TorpedoEnable(pUnit, true)
	local pUnitClass = luaFindHidden("Mogami-class 01")
	local pUnit = GenerateObject(pUnitClass.Name, "Mogami-class 01")
	SetGuiName(pUnit, "ingame.shipnames_kumano")
	--table.insert(Mission.JAP_CruisersGroup, pUnit)
	table.insert(Mission.JAP_Cruiser, pUnit)
	table.insert(Mission.JAP_Warships, pUnit)
	table.insert(Mission.Kumano, pUnit)
	SetForcedReconLevel(Mission.Kumano[1], 2, 0)
	
	for i, pUnit in pairs (Mission.JAP_CruisersGroup) do
		if (Mission.difficulty == 0) then
			NavigatorSetTorpedoEvasion(pUnit, false)
			TorpedoEnable(pUnit, false)
			SetSkillLevel(pUnit, SKILL_SPNORMAL)
		elseif (Mission.difficulty == 1) then
			NavigatorSetTorpedoEvasion(pUnit, false)
			TorpedoEnable(pUnit, true)
			SetSkillLevel(pUnit, SKILL_SPNORMAL)
		elseif (Mission.difficulty == 2) then
			NavigatorSetTorpedoEvasion(pUnit, true)
			TorpedoEnable(pUnit, true)
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end
	end
	
	if (Mission.difficulty == 0) or (Mission.difficulty == 1) then
		NavigatorSetTorpedoEvasion(pUnit, true)
		TorpedoEnable(pUnit, false)
		SetSkillLevel(pUnit, SKILL_STUN)
	elseif (Mission.difficulty == 2) then
		NavigatorSetTorpedoEvasion(pUnit, true)
		TorpedoEnable(pUnit, true)
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
	end
	
	--[[local nPos = GetPosition(Mission.JAP_Cruiser[1])
	Mission.JAP_Marker[1]["x"] = nPos["x"]
	Mission.JAP_Marker[1]["y"] = nPos["y"]
	Mission.JAP_Marker[1]["z"] = nPos["z"]
	luaObj_Add("marker3", 1)
	luaObj_AddUnit("marker3", 1, nPos)]]--
	
	--RepairEnable(pUnit, false)
	--[[JoinFormation(Mission.JAP_CruisersGroup[2], Mission.JAP_CruisersGroup[1])
	JoinFormation(Mission.JAP_CruisersGroup[3], Mission.JAP_CruisersGroup[1])
	JoinFormation(Mission.JAP_CruisersGroup[4], Mission.JAP_CruisersGroup[1])
	NavigatorAttackMove(Mission.JAP_CruisersGroup[1], Mission.USN_Sub01[1], {})]]--
	for i, pShip in pairs (Mission.JAP_CruisersGroup) do
		UnitFreeAttack(pShip)
		NavigatorMoveToRange(pShip, Mission.JAP_Navpoint_Cruiser[i])
	end
	UnitFreeAttack(Mission.JAP_Cruiser[1])
	NavigatorMoveToRange(Mission.JAP_Cruiser[1], Mission.JAP_Navpoint_Cruiser[4])
	AddProximityTrigger(Mission.JAP_Cruiser[1], "CruiserReachedNavpoint", "luaUSN11_CruiserReachedNavpoint", Mission.JAP_Navpoint_Cruiser[4], 100)
	--usa keszulodes
	SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_AI)
	SetInvincible(Mission.USN_Sub01[1], 1)
	NavigatorStop(Mission.USN_Sub01[1])
	PutTo(Mission.USN_Sub01[1], GetPosition(Mission.USN_SubWaypoints[2]), 200)
	ShipSetTorpedoStock(Mission.USN_Sub01[1], Mission.TorpedoNumAtReload)
	AddUntouchableUnit(Mission.USN_Sub01[1])
	SetSubmarineDepthLevel(Mission.USN_Sub01[1], 0)
	
	--PilotStop(Mission.USN_Plane[1])
	--[[local tPos = GetPosition(Mission.USN_CatalinaWaypoints[1])
	tPos["y"] = 100
	PutTo(Mission.USN_Plane[1], tPos, 20)]]--
	SquadronSetTravelAlt(Mission.USN_Plane[1], 100)
	SquadronSetAttackAlt(Mission.USN_Plane[1], 100)
	PilotMoveTo(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[2])
	luaObj_Add("marker2", 1)
	luaObj_AddUnit("marker2", 1, GetPosition(Mission.USN_CatalinaWaypoints[2]))
	--SetForcedReconLevel(Mission.JAP_Cruiser[1], 2, PARTY_ALLIED)
	
	SetRoleAvailable(Mission.USN_Plane[1], EROLF_ALL, PLAYER_1)
	OverrideHP(thisTable[GetSquadronPlanes(Mission.USN_Plane[1])[1]], thisTable[GetSquadronPlanes(Mission.USN_Plane[1])[1]].Class.HP*3)
	SetInvincible(Mission.USN_Plane[1], 1)
	if (not IsUnitUntouchable(Mission.USN_Plane[1])) then
		AddUntouchableUnit(Mission.USN_Plane[1])
	end
	--RemoveUntouchableUnit(Mission.USN_Plane[1])
	SetSelectedUnit(Mission.USN_Plane[1])

	Mission.ReloadMarkerPos = GetPosition(Mission.USN_CatalinaWaypoints[2])
	SetSimplifiedReconMultiplier(0.75)
	Mission.EMPlaying = true
	
	Mission.DelayCatalina = luaDelay(luaUSN11_EM02_PreparingCatalina, 13)
	
	Blackout(true, "", 3, 0)
	
	EnableMessages(false)	-- EM miatt
	
	Mission.Delay = luaDelay(luaUSN11_EM02_Dialog01, 1)
	
	Mission.CamScript = luaCamIngameMovieAuto(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 60, ["theta"] = 8, ["rho"] = 70, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 60, ["theta"] = 8, ["rho"] = 70, ["moveTime"] = 6, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Cruiser[1], ["distance"] = 220, ["theta"] = 5, ["rho"] = 150, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_Cruiser[1], ["distance"] = 220, ["theta"] = 5, ["rho"] = 150, ["moveTime"] = 4, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 100, ["theta"] = 5, ["rho"] = 310, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 100, ["theta"] = 5, ["rho"] = 310, ["moveTime"] = 4, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 70, ["theta"] = 8, ["rho"] = 160, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 70, ["theta"] = 8, ["rho"] = 160, ["moveTime"] = 4, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 80, ["theta"] = 5, ["rho"] = 190, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub01[1], ["distance"] = 80, ["theta"] = 5, ["rho"] = 190, ["moveTime"] = 6, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 50, ["theta"] = 5, ["rho"] = 50, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Plane[1], ["distance"] = 50, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 5, ["smoothtime"] = 1},
		},
		luaUSN11_PreparingPhase3_End,
		true)
		
		AddListener("input", "Listener_EM02", {
			["callback"] = "luaUSN11_EM02_Interrupted",  -- callback fuggveny
			["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
			})
			
		Mission.Delay2 = luaDelay(luaUSN11_BlackBarsEnd, 26)
end

------------------------------------------------------------------------------
function luaUSN11_EM02_PreparingCatalina()
	SquadronSetTravelAlt(Mission.USN_Plane[1], 60)
	SquadronSetAttackAlt(Mission.USN_Plane[1], 60)
	SquadronSetTravelSpeed(Mission.USN_Plane[1], 40)
end

------------------------------------------------------------------------------
function luaUSN11_EM02_Dialog01()
	luaUSN11_StartDialog("EM02_01")
	Mission.Delay = luaDelay(luaUSN11_EM02_Dialog02, 4)
end

------------------------------------------------------------------------------
function luaUSN11_EM02_Dialog02()
	luaUSN11_StartDialog("EM02_02")
	luaUSN11_StartDialog("EM02_03")
	luaUSN11_StartDialog("EM02_04")
	luaUSN11_StartDialog("EM02_05")
	--Mission.Delay = luaDelay(luaUSN11_EM02_Dialog03, 6)
end

------------------------------------------------------------------------------
function luaUSN11_EM02_Dialog03()
	luaUSN11_StartDialog("EM02_03")
end

------------------------------------------------------------------------------
function luaUSN11_RefreshMarkerPos()
	Mission.JAP_Cruiser = luaRemoveDeadsFromTable(Mission.JAP_Cruiser)
	if (table.getn(Mission.JAP_Cruiser) > 0) and (not Mission.JAP_Cruiser[1].Dead) then
		local nPos = GetPosition(Mission.JAP_Cruiser[1])
		Mission.JAP_Marker[1]["x"] = nPos["x"]
		Mission.JAP_Marker[1]["y"] = nPos["y"]
		Mission.JAP_Marker[1]["z"] = nPos["z"]
		--luaObj_RemoveUnit("marker3", 1)
		--luaObj_AddUnit("marker3", 1, nPos)
		--luaLog("Marker Pos = "..Mission.JAP_Marker[1]["x"]..", "..Mission.JAP_Marker[1]["z"]..", "..Mission.JAP_Marker[1]["y"])
	end
end

------------------------------------------------------------------------------
function luaUSN11_CruiserReachedNavpoint(pEntity)
	Mission.USN_Sub01 = luaRemoveDeadsFromTable(Mission.USN_Sub01)
	if (table.getn(Mission.USN_Sub01) > 0) and (not Mission.USN_Sub01[1].Dead) then
		Mission.JAP_CruisersGroup = luaRemoveDeadsFromTable(Mission.JAP_CruisersGroup)
		Mission.JAP_Cruiser = luaRemoveDeadsFromTable(Mission.JAP_Cruiser)
		local nLength = table.getn(Mission.JAP_CruisersGroup)
		if (nLength > 0) then
			if (nLength > 1) then
				for i = 2, nLength do
					NavigatorStop(Mission.JAP_CruisersGroup[i])
					JoinFormation(Mission.JAP_CruisersGroup[i], Mission.JAP_CruisersGroup[1])
				end
			end
			NavigatorStop(Mission.JAP_Cruiser[1])
			JoinFormation(Mission.JAP_Cruiser[1], Mission.JAP_CruisersGroup[1])
			NavigatorAttackMove(Mission.JAP_CruisersGroup[1], Mission.USN_Sub01[1], {})
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_EM02_UnitPutTo()
	local nPos = GetPosition(Mission.IngameEM02_WP[1])
	PutTo(Mission.USN_Sub01[1], nPos, 200)
	nPos = GetPosition(Mission.IngameEM02_WP[2])
	PutTo(Mission.USN_Plane[1], nPos, 20)
	nPos = GetPosition(Mission.IngameEM02_WP[3])
	PutTo(Mission.JAP_Cruiser[1], nPos)
	EntityTurnToEntity(Mission.JAP_Cruiser[1], Mission.JAP_Navpoint_Cruiser[4])
	for i, pShip in pairs (Mission.JAP_CruisersGroup) do
		nPos = GetPosition(Mission.IngameEM02_WP[i+3])
		PutTo(pShip, nPos)
		EntityTurnToEntity(pShip, Mission.JAP_Navpoint_Cruiser[i])
	end
end

------------------------------------------------------------------------------
function luaUSN11_EM02_Interrupted()
	if (IsListenerActive("input","Listener_EM02")) then
		RemoveListener("input","Listener_EM02")
	end
	if (Mission.DelayCatalina) and (not Mission.DelayCatalina.Dead) then
		DeleteScript(Mission.DelayCatalina)
	end
	Blackout(true, "luaUSN11_EM02_Interrupted_BlackOutEnd", 0.5)
end

------------------------------------------------------------------------------
function luaUSN11_EM02_Interrupted_BlackOutEnd()
	luaUSN11_EM02_UnitPutTo()
	luaUSN11_PreparingPhase3_End()
	luaUSN11_KillAllDialog()
	Blackout(false, "", 3)
end

------------------------------------------------------------------------------
function luaUSN11_PreparingPhase3_End()
	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end
	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end
	if (Mission.Delay2.Dead == false) then
		DeleteScript(Mission.Delay2)
	end
	if (IsListenerActive("input","Listener_EM02")) then
		RemoveListener("input","Listener_EM02")
	end
	EnableMessages(true)
	if (IsUnitUntouchable(Mission.USN_Plane[1])) then
		RemoveUntouchableUnit(Mission.USN_Plane[1])
	end
	luaSetPartyInvincible(0, PARTY_ALLIED)
	SetInvincible(Mission.USN_Plane[1], 0)
	EnableInput(true)
	SetSelectedUnit(Mission.USN_Plane[1])
	--CheatMaxRepair(Mission.USN_Sub01[1])
	local nHPPercentage = GetHpPercentage(Mission.USN_Sub01[1])
	if (nHPPercentage < 0.3) then
		local nClassHP = Mission.USN_Sub01[1].Class.HP
		nClassHP = nClassHP * 0.3
		SetHP(Mission.USN_Sub01[1], nClassHP)
	end
	ShipSetTorpedoStock(Mission.USN_Sub01[1], Mission.TorpedoNumAtReload)
	luaUSN11_EM02_PreparingCatalina()
	Mission.EMPlaying = false
	Mission.MissionPhase = 3
	Mission.FirstRun = true
	luaDelay(luaUSN11_InitPri03, 3)
end

------------------------------------------------------------------------------
function luaUSN11_InitPri03()
	luaObj_Add("primary", 3, Mission.JAP_Cruiser[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_InitPri03): PRI03 inicializalva")
	local nPos = GetPosition(Mission.JAP_Cruiser[1])
-- RELEASE_LOGOFF  	luaLog("PRI03 Cruiser Pos = "..nPos["x"]..", "..nPos["z"]..", "..nPos["y"])
	Mission.JAP_Marker[1]["x"] = nPos["x"]
	Mission.JAP_Marker[1]["y"] = nPos["y"]
	Mission.JAP_Marker[1]["z"] = nPos["z"]
	--[[luaLog("PRI03 Marker3 Pos = "..Mission.JAP_Marker[1]["x"]..", "..Mission.JAP_Marker[1]["z"]..", "..Mission.JAP_Marker[1]["y"])
	luaObj_Add("marker3", 1)
	luaObj_AddUnit("marker3", 1, nPos)]]--
	AddListener("recon", "Listener_CruiserSpotted", {
		["callback"] = "luaUSN11_CruiserSpotted",  -- callback fuggveny
		["entity"] = Mission.JAP_Cruiser, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {0,1,2}, -- 0: undetected, 1: detected, 2-4: identified
		})
	
	AddListener("kill", "Listener_CruiserDestroyed", 
	{
		["callback"] = "luaUSN11_CruiserDestroyed",
		["entity"] = Mission.JAP_Cruiser,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
	AddListener("kill", "Listener_CatalinaDestroyed", 
	{
		["callback"] = "luaUSN11_CatalinaDestroyed",
		["entity"] = Mission.USN_Plane,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
	AddListener("exitzone", "Listener_CatalinaExit", 
	{ 
		["callback"] = "luaUSN11_CatalinaDestroyed",  -- callback fuggveny
		["entity"] = Mission.USN_Plane, -- entityk akiken a listener aktiv
		["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
	})
	Mission.EnableReload = true
	luaUSN11_DisplayDistanceReload()
	DisplayUnitHP(Mission.JAP_Cruiser, "usn11.obj_p3")
	Mission.SetPeteAvailable = true
	luaDelay(luaUSN11_DialogRadioMessage, 20)
	--luaObj_Add("hidden", 1)
end

------------------------------------------------------------------------------
function luaUSN11_DialogRadioMessage()
	luaUSN11_StartDialog("RadioMessage")
	luaDelay(luaUSN11_DialogCruiserOnHalfway, 10)
end

------------------------------------------------------------------------------
function luaUSN11_DialogCruiserOnHalfway()
	luaUSN11_StartDialog("CruiserOnHalfway")
end

------------------------------------------------------------------------------
function luaUSN11_CruiserSpotted(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_CruiserSpotted): A cruisert eszrevettek")
	if (IsListenerActive("recon", "Listener_CruiserSpotted")) then
		RemoveListener("recon", "Listener_CruiserSpotted")
	end
	--[[local nPos = GetPosition(Mission.JAP_Marker[1])
-- RELEASE_LOGOFF  	luaLog("PRI03 Marker3 Pos = "..Mission.JAP_Marker[1]["x"]..", "..Mission.JAP_Marker[1]["z"]..", "..Mission.JAP_Marker[1]["y"])
	luaObj_Completed("marker3", 1)]]--
end

------------------------------------------------------------------------------
function luaUSN11_DisplayDistanceReload()
	if (table.getn(Mission.USN_Plane) > 0) and (not Mission.USN_Plane[1].Dead) and (Mission.EnableReload) then
		Mission.ReloadDistance = luaGetDistance(Mission.USN_Plane[1], Mission.USN_CatalinaWaypoints[2])
		if GetMeasure() == "globals.mile" then
			Mission.ReloadDistance = Mission.ReloadDistance * 3.2808398950131
			Mission.ReloadDistance = string.format("%.0f", Mission.ReloadDistance)
			DisplayScores(1,0,"usn11.score03", "usn11.score04")
		else
			Mission.ReloadDistance = string.format("%.0f", Mission.ReloadDistance)
			DisplayScores(1,0,"usn11.score03", "usn11.score05")
		end
		luaUSN11_DisplayDistanceReload_Delay()
	end
end


function luaUSN11_DisplayDistanceReload_Delay()
	luaDelay(luaUSN11_DisplayDistanceReload, 1)
end

------------------------------------------------------------------------------
function luaUSN11_CheckReloadArea()
	Mission.USN_Plane = luaRemoveDeadsFromTable(Mission.USN_Plane)
	if (table.getn(Mission.USN_Plane) > 0) and (not Mission.USN_Plane[1].Dead) and (Mission.EnableReload) then
		local nPlanePos = GetPosition(Mission.USN_Plane[1])
		if (luaGetDistance(nPlanePos, Mission.ReloadMarkerPos) < 40) and (nPlanePos["y"] < 5) and (GetEntitySpeed(Mission.USN_Plane[1]) < 20) then
			if GetSelectedUnit() == Mission.USN_Plane[1] then
				SetDeviceReloadEnabled(true)
				SetDeviceReloadTimeMul(20)
				luaDelay(luaUSN11_ReloadTimeSet,5)
			end
			Mission.EnableReload = false
			HideScoreDisplay(1, 0)
			Mission.ReloadNum = Mission.ReloadNum + 1
			--SetDeviceReloadEnabled(true)
			SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_1)
			luaDelay(luaUSN11_HintSubControl, 6)
			SetInvincible(Mission.USN_Sub01[1], 0)
			RemoveUntouchableUnit(Mission.USN_Sub01[1])
			SetSubmarineDepthLevel(Mission.USN_Sub01[1], 1)
			luaUSN11_StartDialog("TorpedosLoaded")
			luaObj_RemoveUnit("marker2", 1, GetPosition(Mission.USN_CatalinaWaypoints[2]))
			if (IsListenerActive("kill", "Listener_CatalinaDestroyed")) then
				RemoveListener("kill", "Listener_CatalinaDestroyed")
			end
		else
			luaUSN11_ShowHint("USN11_Hint_1streload")
		end
	elseif (table.getn(Mission.USN_Plane)> 0) and (not Mission.USN_Plane[1].Dead) and (Mission.ReloadNum > 0) then
		luaUSN11_ShowHint("USN11_Hint_Morereload")
	end
	luaDelay(luaUSN11_CheckReloadArea, 1)
end

function luaUSN11_ReloadTimeSet()
	if Mission.EndMission then
		return
	else
		--SetDeviceReloadTimeMul(1.3)
	end
end

------------------------------------------------------------------------------
function luaUSN11_HintSubControl()
	luaUSN11_ShowHint("USN11_Hint_Subcontrol")
end

------------------------------------------------------------------------------
function luaUSN11_CheckPlayerUnits()
	Mission.JAP_CruisersGroup = luaRemoveDeadsFromTable(Mission.JAP_CruisersGroup)
	Mission.USN_Sub01 = luaRemoveDeadsFromTable(Mission.USN_Sub01)
	Mission.USN_Plane = luaRemoveDeadsFromTable(Mission.USN_Plane)
	if (table.getn(Mission.USN_Sub01) == 0) and (table.getn(Mission.USN_Plane) == 0) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_CheckPlayerUnits): Mission Failed")
		luaUSN11_MissionFailed(Mission.USN_Sub01[1], "usn11.obj_p1_fail") --"All player units have died")
	end
end

------------------------------------------------------------------------------
function luaUSN11_CruiserDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Cruiser = luaRemoveDeadsFromTable(Mission.JAP_Cruiser)
	if (table.getn(Mission.JAP_Cruiser) == 0)  then
		Mission.MissionPhase = 100
		Mission.EndMission = true
		if (IsListenerActive("kill", "Listener_CruiserDestroyed")) then
			RemoveListener("kill", "Listener_CruiserDestroyed")
		end
		luaObj_Completed("primary", 3)
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_CruiserDestroyed): Mission completed")
		luaUSN11_MissionCompleted()
	end
end

------------------------------------------------------------------------------
function luaUSN11_CatalinaDestroyed(pEntity)
	if (IsListenerActive("kill", "Listener_CatalinaDestroyed")) then
		RemoveListener("kill", "Listener_CatalinaDestroyed")
	end
	if (IsListenerActive("exitzone", "Listener_CatalinaExit")) then
		RemoveListener("exitzone", "Listener_CatalinaExit")
	end
	--SetDeviceReloadTimeMul(1.3)
	--luaObj_Failed("hidden", 1)
	pEntity.Dead = true
	Mission.USN_Plane = luaRemoveDeadsFromTable(Mission.USN_Plane)
	--luaDelay(luaUSN11_CatalinaDestroyed_BlackOutStart, 3)
	if (Mission.EnableReload) then
		Mission.EnableReload = false
		luaObj_RemoveUnit("marker2", 1, GetPosition(Mission.USN_CatalinaWaypoints[2]))
		SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_1)
		SetInvincible(Mission.USN_Sub01[1], 0)
		RemoveUntouchableUnit(Mission.USN_Sub01[1])
		SetSubmarineDepthLevel(Mission.USN_Sub01[1], 1)
		HideScoreDisplay(1, 0)
	end
	if (GetSelectedUnit() ~= nil) then
-- RELEASE_LOGOFF  		luaLog("Kiszelektalt unit: "..GetSelectedUnit().Name)
	end
	if (GetSelectedUnit() == nil) and (table.getn(Mission.USN_Sub01) > 0) and (not Mission.USN_Sub01[1].Dead) then
		luaDelay(luaUSN11_ChangeSelectedUnit,3)
	end
end

------------------------------------------------------------------------------
function luaUSN11_ChangeSelectedUnit()
	SetSelectedUnit(Mission.USN_Sub01[1])
	luaUSN11_ShowHint("USN11_Hint_Subcontrol")
end

------------------------------------------------------------------------------
function luaUSN11_CatalinaDestroyed_BlackOutStart()
	Blackout(true, "luaUSN11_CatalinaDestroyed_BlackOut", 3, 1)
end

------------------------------------------------------------------------------
function luaUSN11_CatalinaDestroyed_BlackOut()
	SetRoleAvailable(Mission.USN_Sub01[1], EROLF_ALL, PLAYER_1)
	SetInvincible(Mission.USN_Sub01[1], 0)
	ShipSetTorpedoStock(Mission.USN_Sub01[1], Mission.TorpedoNumAtReload)
	RemoveUntouchableUnit(Mission.USN_Sub01[1])
	SetSelectedUnit(Mission.USN_Sub01[1])
	Blackout(true, "", 3, 0)
end

------------------------------------------------------------------------------
function luaUSN11_MissionCompleted()
	--[[if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		luaObj_Failed("primary", 1)
	end
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		luaObj_Failed("primary", 2)
	end
	if (luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) == nil) then
		luaObj_Failed("primary", 3)
	end]]--
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1)
	end
	--Scoring_RealPlayTimeRunning(false)
	if (not IsUnitUntouchable(Mission.USN_Sub01[1])) then
		AddUntouchableUnit(Mission.USN_Sub01[1])
	end
	if not TrulyDead(Mission.Kumano[1]) then
		luaMissionCompletedNew(Mission.Kumano[1], "usn11.obj_p3_compl") --Mission.Narratives[7])
	else
		luaMissionCompletedNew(Mission.USN_Sub01[1], "usn11.obj_p3_compl") --Mission.Narratives[7])
	end
	local medal = luaGetMedalReward()
	if (medal == MEDAL_GOLD) then
		Scoring_GrantBonus("US11_SCORING_GOLD", "usn11.bonus1_title", "usn11.bonus1_text", 15)
	end
	Mission.MissionPhase = 100
	Mission.EndMission = true
end

------------------------------------------------------------------------------
function luaUSN11_IowaWasHit(pEntity)
	if (IsListenerActive("hit", "Listener_IowaWasHit")) then
		RemoveListener("hit", "Listener_IowaWasHit")
	end
	--luaUSN11_StartDialog("Iowa_Hit")
end

------------------------------------------------------------------------------
function luaUSN11_SubWasSpotted(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_SubWasSpotted): "..pEntity.Name)
	if (not Mission.Sub01Spotted) then
		for i, pUnit in pairs (Mission.JAP_DD) do
			local nMaxSpeed = VehicleClass[pUnit.Class.ID].MaxSpeed
			SetShipMaxSpeed(pUnit, nMaxSpeed) -- * Mission.MPStoKTS)
-- RELEASE_LOGOFF  			luaLog("DD MaxSpeed = "..nMaxSpeed)
			--[[local Temp = GetShipMaxSpeed(pUnit)
-- RELEASE_LOGOFF  			luaLog(" GetShipMaxSpeed = "..Temp)]]--
			luaSetScriptTarget(pUnit, Mission.USN_Sub01[1])
			TorpedoEnable(pUnit, true)
			NavigatorAttackMove(pUnit, Mission.USN_Sub01[1], {})
			Mission.JAP_DD[i].Attacking = true
			luaUSN11_StartDialog("DestroyerThreat")
		end
	--luaUSN11_StartDialog("Destroyers")
	end
end

------------------------------------------------------------------------------
function luaUSN11_CheckDepth()
	if (Mission.USN_Sub01 ~= nil) and (not Mission.USN_Sub01[1].Dead) and (IsPlayerControlled(Mission.USN_Sub01[1])) then
		local nDepth = GetPosition(Mission.USN_Sub01[1])["y"]
		if (nDepth < -29) and (nDepth > -55) then
			AddDamage(Mission.USN_Sub01[1], 40)
			if (Mission.Dialogs["In3rdLevel"].printed == nil) or (not Mission.Dialogs["In3rdLevel"].printed) then
				KillDialog("In3rdLevel")
				luaUSN11_StartDialog("In3rdLevel")
				luaDelay(luaUSN11_EnableDialog_In3rdLevel, 60)
			end
		elseif (nDepth < -54) then
			AddDamage(Mission.USN_Sub01[1], 80)
			if (Mission.Dialogs["In4thLevel"].printed == nil) or (not Mission.Dialogs["In4thLevel"].printed) then
				KillDialog("In4thLevel")
				luaUSN11_StartDialog("In4thLevel")
				luaDelay(luaUSN11_EnableDialog_In4thLevel, 60)
			end
		end
		--LogToConsole(GetHpPercentage(Mission.USN_Sub01[1]))
	end
end

------------------------------------------------------------------------------
function luaUSN11_EnableDialog_In3rdLevel()
	Mission.Dialogs["In3rdLevel"].printed = false
end

------------------------------------------------------------------------------
function luaUSN11_EnableDialog_In4thLevel()
	Mission.Dialogs["In4thLevel"].printed = false
end

------------------------------------------------------------------------------
function luaUSN11_CheckHidden()
	if (Mission.HiddenActive) and (Mission.PeteHijacked[1] ~= nil) and (not Mission.PeteHijacked[1].Dead) then
		if Mission.USN_Sub01[1] ~= nil and not Mission.USN_Sub01[1].Dead then
			local nSubDistance = luaGetDistance(Mission.PeteHijacked[1], Mission.USN_Sub01[1])
			local bHiddenComplete = false
			if (nSubDistance < 250) then
				bHiddenComplete = true
			elseif (Mission.USN_Plane[1] ~= nil) and (not Mission.USN_Plane[1].Dead) then
				local nPlaneDistance = luaGetDistance(Mission.PeteHijacked[1], Mission.USN_Plane[1])
				local nSpeed = GetEntitySpeed(Mission.USN_Plane[1])
				local nPos = GetPosition(Mission.USN_Plane[1])
				if (nPlaneDistance < 250) and (nSpeed < 20) and (nPos["y"] < 2) then
					bHiddenComplete = true
				end
			end
			if (bHiddenComplete) then
				--MissionNarrative("Dialog: Sir, we found an enemy plane. Maybe we can use it.")
				luaUSN11_StartDialog("ReconplaneAcquired")
				if (Mission.MissionPhase < 3) then
					SetRoleAvailable(Mission.PeteHijacked[1], EROLF_ALL, PLAYER_AI)
					SetInvincible(Mission.PeteHijacked[1], 1)
					AddUntouchableUnit(Mission.PeteHijacked[1])
					--MissionNarrative("Dialog: Captain: First concentrate to our main task, later we will check it.")
					luaUSN11_StartDialog("ReconplaneAcquired_2ndPhase")
				end
				luaObj_Completed("hidden", 1, true)
				Mission.HiddenActive = false
-- RELEASE_LOGOFF  				luaLog("(luaUSN11_CheckHidden): Hidden objective completed")
			end
		end
	elseif (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == true) and (Mission.SetPeteAvailable) then
		Mission.SetPeteAvailable = false
		luaUSN11_SetPeteAvailable()
	end
end

------------------------------------------------------------------------------
function luaUSN11_SetPeteAvailable()
	SetRoleAvailable(Mission.PeteHijacked[1], EROLF_ALL, PLAYER_1)
	if (not IsUnitUntouchable(Mission.PeteHijacked[1])) then
		AddUntouchableUnit(Mission.PeteHijacked[1])
	end
	SetInvincible(Mission.PeteHijacked[1], 0)
	AddListener("kill", "Listener_PeteWasKilled", 
	{
			["callback"] = "luaUSN11_PeteWasKilled",
			["entity"] = Mission.PeteHijacked,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
	AddListener("hit", "Listener_JapaneseUnitWasHit", 
		{
			["callback"] = "luaUSN11_JapaneseUnitWasHit",
			["target"] = Mission.JAP_Warships,
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	luaDelay(luaUSN11_ShowHint_PeteAvailable, 5)
end

------------------------------------------------------------------------------
function luaUSN11_PeteWasKilled()
	Mission.PeteHijacked[1].Dead = true
	if (IsListenerActive("kill", "Listener_PeteWasKilled")) then
		RemoveListener("kill", "Listener_PeteWasKilled")
	end
	if (IsListenerActive("hit", "Listener_JapaneseUnitWasHit")) then
		RemoveListener("hit", "Listener_JapaneseUnitWasHit")
	end
end

------------------------------------------------------------------------------
function luaUSN11_JapaneseUnitWasHit(...)
	local pAttacker = arg[3]
	if (pAttacker ~= nil) and (pAttacker.Class.ID == 171) then
		if (IsListenerActive("kill", "Listener_PeteWasKilled")) then
			RemoveListener("kill", "Listener_PeteWasKilled")
		end
		if (IsListenerActive("hit", "Listener_JapaneseUnitWasHit")) then
			RemoveListener("hit", "Listener_JapaneseUnitWasHit")
		end
		if (IsUnitUntouchable(Mission.PeteHijacked[1])) then
			RemoveUntouchableUnit(Mission.PeteHijacked[1])
			--MissionNarrative("Dialog: Sir, the japanese recognize our disguise. Be careful. They shoot us.")
			luaUSN11_StartDialog("DisguiseFall")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_ShowHint_PeteAvailable()
	--MissionNarrative("Hint: Now you can control the hijacked japanese plane.")	-- USN11_Hint_ControlPete
	ShowHint("USN11_Hint_ControlPete")
	--MissionNarrative("Hint: Unless you don't attack a japanese unit with Pete, the enemy think that you're a japanese pilot. Use it to your advantage.")	-- USN11_Hint_AttackWithPete
	ShowHint("USN11_Hint_AttackWithPete")
end

------------------------------------------------------------------------------
function luaUSN11_ShowHint(szHint)
-- RELEASE_LOGOFF  	luaLog("Hint = "..szHint..", EMPlaying = "..tostring(Mission.EMPlaying))
	if (not Mission.EMPlaying) then
		ShowHint(szHint)
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_ShowHint): EM jatszodik, hint kesleltetve. Hint = "..szHint)
		luaDelay(luaUSN11_DelayedHint, 3, "HintText", szHint)
	end
end

------------------------------------------------------------------------------
function luaUSN11_DelayedHint(TimerThis)
	local szHint = TimerThis.ParamTable.HintText
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DelayedHint): Kesleltetes letelt, ujra probalkozok. Hint = "..szHint)
	luaUSN11_ShowHint(szHint)
end

------------------------------------------------------------------------------
function luaUSN11_KillAllDialog()
	local tDialog = GetActDialogIDs()
	for i, pDialog in pairs (tDialog) do
		KillDialog(pDialog)
	end
end

------------------------------------------------------------------------------
function luaUSN11_MissionFailed(pEntity, nText)
	if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		luaObj_Failed("primary", 1)
	end
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		luaObj_Failed("primary", 2)
	end
	if (luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) == nil) then
		luaObj_Failed("primary", 3)
	end
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
		luaObj_Failed("secondary", 1)
	end
	--Scoring_RealPlayTimeRunning(false)
	luaMissionFailedNew(pEntity, nText)
	Mission.EndMission = true
end

------------------------------------------------------------------------------
function luaUS11SetChangeableGUIName(unit)
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

------------------------------------------------------------------------------
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(87)	-- Japan Cargo Transport
	PrepareClass(67)	-- Mogami Class
	PrepareClass(75)	-- Minekaze Class
	PrepareClass(31)	-- Narwhal Class Submarine
	--PrepareClass(15)	-- Iowa Class
	--PrepareClass(93)	-- Submarine TypeB w Jake  --TODO: lecserelni majd sima Type B-re
	PrepareClass(125)	-- PBY Catalina
	PrepareClass(77)	-- Japan PT
	PrepareClass(171)	-- F1M Pete
	PrepareClass(108)	-- Dauntless powerup
	--PrepareClass(159)	-- Dauntless powerup B+ a japant is prekesseld dodi! - rfx
	Loading_Finish()
end

------------------------------------------------------------------------------
function luaUSN11SaveMissionData()
	Mission.Checkpoint.Dialogues = Mission.Dialogues
	Mission.Checkpoint.HiddenActive = Mission.HiddenActive
	Mission.Checkpoint.MissionCounter = Mission.MissionCounter
	Mission.Checkpoint.SetPeteAvailable = Mission.SetPeteAvailable
	if (Mission.MissionPhase == 2) then
		if (Mission.PeteHijacked == nil) or (Mission.PeteHijacked[1].Dead) then
			Mission.Checkpoint.PeteDied = true
		else
			Mission.Checkpoint.PeteDied = false
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11LoadMissionData()
	Mission.Dialogues = Mission.Checkpoint.Dialogues
	Mission.HiddenActive = Mission.Checkpoint.HiddenActive
	Mission.MissionCounter = Mission.Checkpoint.MissionCounter
	Mission.SetPeteAvailable = Mission.Checkpoint.SetPeteAvailable
	MissionNarrativeClear()
	--Mission.MissionPhase = 100
end

------------------------------------------------------------------------------
function luaUSN11_Checkpoint_Cleaning()
	Mission.JAP_DD = luaRemoveDeadsFromTable(Mission.JAP_DD)
	for i, pDD in pairs (Mission.JAP_DD) do
		Kill(pDD, true)
	end
	for i, pShip in pairs (Mission.JAP_Convoy) do
		Kill(pShip, true)
	end
	--local CheckpointNum[1] = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if (Mission.MissionPhase == 2) then		-- (utolso fazis) azert 2, mert csak EM utan allitom at az erteket 3-ra
		--Mission.JAP_Planes-t itt nem kell kitakaritani, mert azt az EM elotti megcsinalom
		for i, pBuilding in pairs (Mission.JAP_Buildings) do
			Kill(pBuilding, true)
		end
		if (Mission.Checkpoint.PeteDied) then
			Kill(Mission.PeteHijacked[1], true)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_Checkpoint_Preparing()
	if (not IsListenerActive("kill", "Listener_SubDied")) then
		AddListener("kill", "Listener_SubDied", 
		{
				["callback"] = "luaUSN11_SubDied",
				["entity"] = Mission.USN_Sub01,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (not IsListenerActive("exitzone", "Listener_SubExited")) then
		AddListener("exitzone", "Listener_SubExited", 
		{
				["callback"] = "luaUSN11_SubDied",
				["entity"] = Mission.USN_Sub01,
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	end
end

------------------------------------------------------------------------------
function luaUSN11_DEBUGPos1()
-- RELEASE_LOGOFF  	luaLog("----- DEBUG Pos 1 -----")
	local tPos = GetPosition(Mission.USN_Sub01[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DEBUGPos1): Sub -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	tPos = GetPosition(Mission.USN_Plane[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DEBUGPos1): Catalina -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	local i
	for i, pPlane in pairs (Mission.JAP_Planes) do
		tPos = GetPosition(pPlane)
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_DEBUGPos1): "..i..". JAP Plane -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	end
-- RELEASE_LOGOFF  	luaLog("-----------------------")
-- RELEASE_LOGOFF  	LogToConsole("DEBUG Pos1 Done.")
end

function luaUSN11_DEBUGPos2()
-- RELEASE_LOGOFF  	luaLog("----- DEBUG Pos 2 -----")
	local tPos = GetPosition(Mission.USN_Sub01[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DEBUGPos2): Sub -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	tPos = GetPosition(Mission.USN_Plane[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DEBUGPos2): Catalina -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	tPos = GetPosition(Mission.JAP_Cruiser[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DEBUGPos2): Kumano -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	local i
	for i, pShip in pairs (Mission.JAP_CruisersGroup) do
		tPos = GetPosition(pShip)
-- RELEASE_LOGOFF  		luaLog("(luaUSN11_DEBUGPos2): "..i..". JAP Cruiser -> x = "..tPos["x"]..", y = "..tPos["y"]..", z = "..tPos["z"])
	end
-- RELEASE_LOGOFF  	luaLog("-----------------------")
-- RELEASE_LOGOFF  	LogToConsole("DEBUG Pos2 Done.")
end


function luaUSN11_LogPos()
	local tUnits = luaGetOwnUnits(nil, PARTY_ALLIED)
	for i, pUnit in pairs (tUnits) do
		local tPos = GetPosition(pUnit)
-- RELEASE_LOGOFF  		luaLog("(LogPos): "..pUnit.Name.." -> [x] = "..tPos["x"]..", [y] = "..tPos["y"]..", [z] = "..tPos["z"])
	end
	tUnits = luaGetOwnUnits(nil, PARTY_JAPANESE)
	for i, pUnit in pairs (tUnits) do
		local tPos = GetPosition(pUnit)
-- RELEASE_LOGOFF  		luaLog("(LogPos): "..pUnit.Name.." -> [x] = "..tPos["x"]..", [y] = "..tPos["y"]..", [z] = "..tPos["z"])
	end
end

------------------------------------------------------------------------------
function d1()
	SetInvincible(Mission.USN_Sub01[1], true)
-- RELEASE_LOGOFF  	LogToConsole("A Sub sebezhetetlen")
end

function luaUSN11Phase()
	luaUSN11_KillAllDialog()
	if (Mission.MissionPhase == 1) then
		for i, pUnit in pairs (Mission.JAP_Convoy) do
			Kill(pUnit)
		end
-- RELEASE_LOGOFF  		LogToConsole("(luaUSN11Phase, Phase = 1): A konvoj hajoi megsemmisitve")
	elseif (Mission.MissionPhase == 2) then
		for i, pUnit in pairs (Mission.JAP_Buildings) do
			Kill(pUnit)
		end
-- RELEASE_LOGOFF  		LogToConsole("(luaUSN11Phase, Phase = 2): Az epuletek megsemmisitve")
	elseif (Mission.MissionPhase == 3) then
		for i, pShip in pairs (Mission.JAP_Cruiser) do
			Kill(pShip)
		end
	end
end
