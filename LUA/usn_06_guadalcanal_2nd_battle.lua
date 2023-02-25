--SceneFile="missions\USN\usn_06_Guadalcanal_2nd_battle.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")

--[[Navpoint_East04 - Squad01 csapat
Navpoint_North03 - Squad02 csapat]]--


--Navpoint_East01 - Phase4 South Dakota Spawnpoint
--Navpoint_North03 - Phase4 jap Destroyers Spawnpoint
--Navpoint_East05 - Phase4 USN felmento sereg
--Navpoint_East06 - Phase4 Kirishima es kiserete


--Repair Enable(entityname, boolean)

--	szetloheto transport hajo: 224

--[[
	Mission TODO: 
			- utananezni: ha azelott hal meg a sub mielott eszrevette volna a recon plane, akkor nincs vege a fazisnak
			- (DLG24) luaUSN06_DialogBattleshipOnTheWay()-t bekotni a PT-s fazisba, a battleshipek hamarosan megerkeznek -> meg nincs meg hozza a hang
			  
]]--


function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	--MessageMap betoltese
	LoadMessageMap("usn06dlg",1)
	EnableMessages(false)
	--luaDelay(luaUSN06_DateLocation, 3)
	luaUSN06_DateLocation()
	luaDelay(luaUSN06_Dialog_Intro, 19)

end

function luaUSN06_DateLocation()
	MissionNarrative("usn06.date_location")
end

function luaUSN06_Dialog_Intro()
	local Dialogues = {
		["intro01"] = {
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
				{
					["message"] = "idlg01f",
				},
			},
		},
	}
	StartDialog("intro01", Dialogues["intro01"])
	--luaDelay(luaUSN06_Dialog_Intro2, 9)
end

function luaUSN06_Dialog_Intro2()
	--[[local Dialogues = {
		["intro02"] = {
				["sequence"] = {
					{
						["message"] = "dlg2",
					},
				},
			},
			["intro03"] = {
				["sequence"] = {
					{
						["message"] = "dlg3",
					},
				},
			},
		}
	StartDialog("intro02", Dialogues["intro02"])
	StartDialog("intro03", Dialogues["intro03"])]]--
end

------------------------------------------------------------------------------
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaUSN06Init")
	Scoring_RealPlayTimeRunning(true)
end

------------------------------------------------------------------------------
function luaUSN06Init(this)
	Mission = this
	this.Name = "US06"
	this.ScriptFile = "SCRIPTS/missions/USN/usn_06_guadalcanal_2nd_battle.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	--for debug only--
	--TODO: Veglegesben false-ra rakni
	this.Debug = true
	if (this.Debug) then
-- RELEASE_LOGOFF  		luaLog("Mission running in Script DEBUG mode!")
		this.UnlockLvl = 0
	end
	
	--AddWatch("Mission.MissionPhase")
	--for debug only end--
	
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initating "..this.Name.." mission!")
	
	--Mission beallitasok
	this.Party = PARTY_ALLIED
	
	--difficulty
	this.difficulty = GetDifficulty()

	--global Constants
	this.SpeedOfConvoy 					= KTS(22)	--convoy sebessege (a cargoship max sebessege)
	this.SpeedOfEscort					= 40			--a convoy-t kisero hajok sebessege
	this.ConvoyTimeMin 					= 120			--min ennyi ido mulva spawnolodik a kov. convoy hajo
	this.ConvoyTimeMax 					= 170			--max ennyi ido mulva spawnolodik a kov. convoy hajo
	this.ShipsNeedToDestroy 		= 12			--ennyi hajot kell megsemmisiteni a convoy-bol
	this.SubWasSpotted 					= false		--eszrevettek -e mar a tengeralattjarot
	this.SubDeepLevel						= -70			--ilyen melyre kell lemerulni a phase1-ben a sec01 teljesiteshez
	this.TorpedoNumAtStart			= 20			--ennyi torpedoval kezd a player subja
	this.DefaultPTSpeed					= VehicleClass[77].MaxSpeed			--ennyi a JAP PT default max sebessege
	if (this.difficulty == 0) then
		this.MaxJapPTNum = 6
		this.MaxSpeedOfJapPts = 40
	elseif (this.difficulty == 1) then
		this.MaxJapPTNum = 8
		this.MaxSpeedOfJapPts = 40
	elseif (this.difficulty == 2) then
		this.MaxJapPTNum = 10
		this.MaxSpeedOfJapPts = 0
	end
	
	--ReDesign Constants
	this.MaxConvoyNum						= 12			--ennyi convoy hajo jon, ennyibol kell megsemmisiteni 10-et
	
	this.CargoTransportNames 		= {"ingame.shipnames_akebono", "ingame.shipnames_kyokuto", "ingame.shipnames_naruto", "ingame.shipnames_nichei", "ingame.shipnames_nippon", "ingame.shipnames_san_clemente", "ingame.shipnames_satu", "ingame.shipnames_shinkoku", "ingame.shipnames_teiyo", "ingame.shipnames_toa", "ingame.shipnames_toei", "ingame.shipnames_toho", "ingame.shipnames_hayo", "ingame.shipnames_katori", "ingame.shipnames_hie", "ingame.shipnames_fizan", "ingame.shipnames_meiko", "ingame.shipnames_myoken", "ingame.shipnames_fukusei", "ingame.shipnames_harbin", "ingame.shipnames_genyo", "ingame.shipnames_kenyo", "ingame.shipnames_kokyu"}
	this.TroopTransportNames 		= {"ingame.shipnames_argentina", "ingame.shipnames_azuma", "ingame.shipnames_brazil", "ingame.shipnames_goshu", "ingame.shipnames_hakusan", "ingame.shipnames_hokuriku", "ingame.shipnames_kano", "ingame.shipnames_keiyo", "ingame.shipnames_kirisima", "ingame.shipnames_kiyosumi", "ingame.shipnames_nankai", "ingame.shipnames_zenyo", "ingame.shipnames_meiu", "ingame.shipnames_yamafuku",  "ingame.shipnames_kinugasa", "ingame.shipnames_magane", "ingame.shipnames_okinoshima", "ingame.shipnames_sagamai", "ingame.shipnames_sasago", "ingame.shipnames_kumagawa", "ingame.shipnames_kuretake", "ingame.shipnames_sumanoura"}
	this.FubukiNames 						= {"ingame.shipnames_akebono", "ingame.shipnames_amagiri", "ingame.shipnames_asagiri", "ingame.shipnames_ayanami", "ingame.shipnames_fubuki", "ingame.shipnames_isonami", "ingame.shipnames_murakumo", "ingame.shipnames_sagiri", "ingame.shipnames_sazanami", "ingame.shipnames_shikinami", "ingame.shipnames_shirakumo", "ingame.shipnames_uranami", "ingame.shipnames_ushio", "ingame.shipnames_yugiri"}
	this.FletcherNames					= {"ingame.shipnames_walke", "ingame.shipnames_preston", "ingame.shipnames_benham", "ingame.shipnames_gwin"}

	this.ChangeableNames = {}
	this.ChangeableNames[30] = {"ingame.shipnames_growler"}	-- Gato
	this.ChangeableNames[15] = {"ingame.shipnames_missiouri", "ingame.shipnames_wisconsin"}	-- Iowa
	this.ChangeableNames[389] = {"ingame.shipnames_ohio", "ingame.shipnames_maine"}	-- Montana
	
	--global variables
	this.Counter 								= 0				--for debug only
	this.EndMission							= false
	this.MissionPhase 					= 0
	this.FirstRun								= true
	this.ConvoyShipDestroyed 		= 0				--ennyi convoy hajo lett megsemmisitve (csak azokat szamolom, amelyiknek a state-je 0-as vagy 1-es)
	this.JAPSpawnedPTs					= 0				--hany japan PT spawnolt
	this.SubPos									= 0				--a sub legutolso eszlelt pozicioja
	this.SubControlable 				= true		--iranyithato -e a sub
	this.ReconPlane							= false		--spawnolhato -e reconplane (csak akkor spawnolom, amikor eszrevettek a subot, vagy ha az elozot kilottek)
	this.SubSpottedByReconPlane = false		--eszrevette -e mar a recon plane a subot
	this.PTsSpawned							= false		--spawnoltam -e mar japan PT-t, amint az elso spawnolodott, az erteke true lesz
	this.NeedAreaCheck					= false		--kell -e ellenorizni az egyes areakban levo PT-k szamat
	this.nPrevArea 							= 3				--melyik helyre megy majd a soron kovetkezo japan PT
	this.CargoShipNumber				= 7				--sorszamozom a cargo shipeket, csak a nevuk miatt hasznalom. Elsosorban debug miatt kell, de lehet hogy kesobb megtartom
	this.EngineMovie01					= false		--lejatszodott -e mar 1x az 1-es engine movie
	this.PTsDetected_Phase3			=	false		--erteke true lesz, ha a 3-as fazisban az USA PT-ket detektaltak -> ekkor indulnak el a japan PT-k tamadni
	this.Squad01AttackPhase			= false		--akkor lesz true, amikor a squad01-et eszrevette a player egy egysege, vagy ha elerte a path-a veget. Ezutan minden thinkben ellenorzom hogy van -e target, ha nincs vagy messze van, akkor uj targetet valasztok
	this.PowerUp								= false		--erteke true, ha a player a phase01-ben kilo 3 transport hajot. Ekkor kap egy Speed Increased PowerUp-ot
	this.EngineMovie02					= false		--lejatszodott -e mar az engine movie 02
	this.CargoActNumber					= 1				--a Cargo nevtabla ennyiedik eleme az aktualis
	this.TroopActNumber					=	1				--a Troop nevtabla ennyiedik eleme az aktualis
	this.JapPTNumber						= 1				--a JapPT sorszama
	this.FubukiNumber						= 1				--Fubukik sorszama
	this.FletcherNumber					= 1				--a Fletcher tablaba ennyiedik eleme az aktualis
	this.HiddenPlanesActive			= false		--erteke true, ha 1x eltalaltak a hidden plane-eket es Party-t valtottam mar nekik
	this.HintCameraLockTimer 		= 0				--think counter, x thinkenkent megjelenitem ujra a CameraLock countert
	this.HintCameraLockCounter	= 0				--szamolom hanyszor irtam mar ki a CameraLock hintet
	this.HintTurnTimer					= -1			--think counter, x thinkenkent megjelenitem ujra a HintTurn countert
	this.HintTurnCounter				= 0				--szamolom hanyszor irtam mar ki a Turn advanced hintet
	this.HintSonarTimer					= -1
	this.HintSonarCounter				= 0
	this.HintSafeZoneEnabled		= false		--true, ha eszrevettek a subot es le kell merulnie (ekkor mar kiirhato a hint)
	this.AliveJapShips					= 100			--displayscore-hoz kell, ennek a valtozonak az erteket irom bele a lockitbe (ennyi maradt meg)
	this.MaxJapShips						= 100			--displayscore-hoz kell, ennek a valtozonak az erteket irom bele a lockitbe (ennyi az ossz)

	--ReDesign Variables
	this.CountDownTimer					= 300			--ennyi ido alatt kell lemerulni a subbal a legalacsonyabb szintre a phase2-ben
	this.SpawnedConvoyShip			= 6				--ennyi convoy hajo spawnolt eddig. Azert 6-tal kezdodik, mert a Mission elejen mar le van rakva 6.
	this.DockedConvoyShip				= 0				--ennyi hajo kotott mar ki (kikotesnek az szamit, ha elerte a landingpointot, vagyis a state == 1)
	this.PTReinforcement				= false		--kapott -e mar a pleyer PT reinforcementet
	
	--Mission narratives
	this.Narratives = {}
		table.insert(this.Narratives, "The sub was spotted by an enemy unit")
		table.insert(this.Narratives, "The Submarine has destroyed")
		table.insert(this.Narratives, "A reconplane has spotted the submarine. The enemy will send ships surely. To hide we should sink to maximum depth.")
		table.insert(this.Narratives, "We have company! They are stronger than we. We should try to reach the evac zone.")
		table.insert(this.Narratives, "You successfully reached the evac zone")
		table.insert(this.Narratives, "All player unit have died")
		table.insert(this.Narratives, "Mission Completed")
		table.insert(this.Narratives, "You have destroyed the japanese Command Center")
		table.insert(this.Narratives, "usn06.hint_plane_reinforcement")		-- Reinforcement planes have arrived!
	
	--Precache
	
	--allied hajok
	this.USN_Sub = {}
		table.insert(this.USN_Sub, FindEntity("Narwhal-class Submarine 01"))
	ShipSetTorpedoStock(this.USN_Sub[1], Mission.TorpedoNumAtStart)
	if IsClassChanged(this.USN_Sub[1].ClassID) then
		luaSetUnlockName(this.USN_Sub[1])
	end
	
	this.USN_PT = {}
	this.USN_Squad = {}		-- ez a squad csak a phase2-ben jelenik meg, tartalmazza az USN PT-ket es az utolso fazis hajoit
	--TODO: DEL
	--this.USN_NorthSquad = {}
	this.USN_SouthDakota = {}
	this.USN_Washington = {}

	--allied repulok
	this.USN_P38s = {}
	this.USN_BonusUnit = {}
	
	--Level Bomber unlock unit
	--this.USN_LevelBomber = {}
	
	--allied path-ok, navpointok
	this.USN_SpawnPoints = {}
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East02"))
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East03"))
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East01")) --Phase3 start pos a battleshipeknek
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East05")) --Phase3 start pos a megmaradt USN PT-knek
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East06")) --Phase3 start pos a megmaradt USN P38-asoknak
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_East02b")) -- ide PutTo-zom at az usa PT-t a phase03-ban lekrealas utan
	
	this.USN_EvacZone = {}
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint01"))
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint02"))
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint03"))
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint04"))
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint05"))
		table.insert(this.USN_EvacZone, FindEntity("EvacPoint06"))
	--player shipyardok
	
	--japan shipyardok (csak a sebezhetetlenseg miatt)
	this.JAP_ShipyardHangar = {}
		table.insert(this.JAP_ShipyardHangar, FindEntity("PThangar_small_single 01"))
		table.insert(this.JAP_ShipyardHangar, FindEntity("PThangar_small_single 02"))
	SetInvincible(this.JAP_ShipyardHangar[1], 1)
	SetInvincible(this.JAP_ShipyardHangar[2], 1)
	
	--japan hajok
	
	--japan repulok
	this.JAP_ReconPlanes = {}
	
	--japan hajok
	this.Convoy = {}
		table.insert(this.Convoy, FindEntity("Japan Troop Transport 01"))
		this.Convoy[1].LandingPoint = 0
		this.Convoy[1].State = 0		--0: megy a landing point fele, 1: kikotott es varakozik a landing pointon, 2: elindul az evac zone fele
		table.insert(this.Convoy, FindEntity("Japan Cargo Transport 01"))
		this.Convoy[2].LandingPoint = 0
		this.Convoy[2].State = 0
		table.insert(this.Convoy, FindEntity("Japan Cargo Transport 02"))
		this.Convoy[3].LandingPoint = 0
		this.Convoy[3].State = 0
		--[[table.insert(this.Convoy, FindEntity("Japan Troop Transport 03"))
		this.Convoy[4].LandingPoint = 0
		this.Convoy[4].State = 0
		table.insert(this.Convoy, FindEntity("Japan Cargo Transport 03"))
		this.Convoy[5].LandingPoint = 0
		this.Convoy[5].State = 0
		table.insert(this.Convoy, FindEntity("Japan Troop Transport 02"))
		this.Convoy[6].LandingPoint = 0
		this.Convoy[6].State = 0]]--
	--this.ReconTable = {}			-- ebbe tarolom a ForceRecon-nal atallitott transport shipeket -> most nem hasznalom
	
	--[[this.JAP_Destroyer01 = {}
		table.insert(this.JAP_Destroyer01, FindEntity("Fubuki-class 01"))]]--
	
	this.JAPPTs = {}	
	
	this.JAP_Units = {}
	
	this.JAP_Squad01 = {}
	
	this.JAP_Squad02 = {}
	
	this.JAP_Kirishima = {}
	
	this.JAP_EscortGroup = {}
	
	this.CommandCenter = {}
		table.insert(this.CommandCenter, FindEntity("Command Center 01"))
	
	--japan path-ok, navpointok
	this.ConvoyPath = {}
		table.insert(this.ConvoyPath, FindEntity("Navpoint_North01"))
		table.insert(this.ConvoyPath, FindEntity("Navpoint_Convoy_01"))
	this.ConvoyDockPath = {}
		table.insert(this.ConvoyDockPath, FindEntity("Path_Dock01"))
		table.insert(this.ConvoyDockPath, FindEntity("Path_Dock02"))
		table.insert(this.ConvoyDockPath, FindEntity("Path_Dock03"))
		table.insert(this.ConvoyDockPath, FindEntity("Path_Dock04"))
	this.JAP_SpawnPoints = {}
		table.insert(this.JAP_SpawnPoints, FindEntity("Navpoint_North02"))
		table.insert(this.JAP_SpawnPoints, FindEntity("Navpoint_North03"))	--Phase3-ban Squad02 start pos
		table.insert(this.JAP_SpawnPoints, FindEntity("Navpoint_East04"))		--Phase3-ban Squad01 start pos
		table.insert(this.JAP_SpawnPoints, FindEntity("Navpoint_North04"))
	this.ConvoyLandingPoints = {}
		table.insert(this.ConvoyLandingPoints, FindEntity("Navpoint_Convoy_Landing01"))
		this.ConvoyLandingPoints[1].Enable = true
		table.insert(this.ConvoyLandingPoints, FindEntity("Navpoint_Convoy_Landing02"))
		this.ConvoyLandingPoints[2].Enable = true
		table.insert(this.ConvoyLandingPoints, FindEntity("Navpoint_Convoy_Landing03"))
		this.ConvoyLandingPoints[3].Enable = true
		table.insert(this.ConvoyLandingPoints, FindEntity("Navpoint_Convoy_Landing04"))
		this.ConvoyLandingPoints[4].Enable = true
	this.ConvoyExitPoints = {}
		table.insert(this.ConvoyExitPoints, FindEntity("Navpoint_ConvoyExit"))
		
	this.ShipyardSpawnPoints = {}
		table.insert(this.ShipyardSpawnPoints, FindEntity("Navpoint_Shipyard01"))
		table.insert(this.ShipyardSpawnPoints, FindEntity("Navpoint_Shipyard02"))
		--table.insert(this.ShipyardSpawnPoints, FindEntity("Navpoint_Shipyard03"))
	this.LookatPointShipyard = {}
		table.insert(this.LookatPointShipyard, FindEntity("LookatPoint_Shipyard"))
		
	this.OtherPoints = {}
		table.insert(this.OtherPoints, FindEntity("Navpoint_PTTarget"))

	this.Area = {}
		table.insert(this.Area, FindEntity("Navpoint_Area01"))
		table.insert(this.Area, FindEntity("Navpoint_Area02"))
		table.insert(this.Area, FindEntity("Navpoint_Area03"))
	
	this.PatrolPath = {}
		table.insert(this.PatrolPath, FindEntity("Path_Patrol01"))
	
	this.Squad01Path = {}
		table.insert(this.Squad01Path, FindEntity("Path_Squad01"))
	
	this.EscortPath = {}
		table.insert(this.EscortPath, FindEntity("Navpoint_EscortGroup01"))
		table.insert(this.EscortPath, FindEntity("Navpoint_EscortGroup02"))
		table.insert(this.EscortPath, FindEntity("Navpoint_EscortGroup03"))
		table.insert(this.EscortPath, FindEntity("Navpoint_EscortGroup04"))
		
	this.HideNavpoints = {}
		table.insert(this.HideNavpoints, FindEntity("Navpoint_EscapingArea_01"))
		table.insert(this.HideNavpoints, FindEntity("Navpoint_EscapingArea_02"))
		table.insert(this.HideNavpoints, FindEntity("Navpoint_EscapingArea_03"))
		
	this.PlanesHidden = {}
		table.insert(this.PlanesHidden, FindEntity("E13A Jake 01"))
		table.insert(this.PlanesHidden, FindEntity("E13A Jake 02"))
		table.insert(this.PlanesHidden, FindEntity("E13A Jake 03"))
		
	for i, pPlanes in pairs (Mission.PlanesHidden) do
		SetInvincible(pPlanes, 1)
	end
	--Achivements Init
	
	--music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	--engine movie
	--luaInitJumpinMovies()
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUSN06LoadMissionData, luaUSN06_Cleaning, luaUSN06_InitHidden, luaUSN06_Preparing_Phase3},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUSN06SaveMissionData},
	}
	
	--Dialogusok
	LoadMessageMap("usn06dlg",1)
	this.Dialogues = {
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
			},
		},
		["1stTorpedo"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
				{
					["message"] = "dlg02b",
				},
			},
		},
		["JAPPT"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["SubDive"] = {
			["sequence"] = {
				{
					["message"] = "dlg04",
				},
			},
		},
		["1stDepthCharge"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
			},
		},
		["Reminder_4thDepth"] = {
			["sequence"] = {
				{
					["message"] = "dlg06",
				},
			},
		},
		["SubLost"] = {
			["sequence"] = {
				{
					["message"] = "dlg07",
				},
			},
		},
		["USNPT"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
			},
		},
		["SubIn4thDepth"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
				{
					["message"] = "dlg09b",
				},
			},
		},
		["USNPT_Arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["USN_BattleshipOnWay"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["USN_Battleships_Arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg16b",
				},
			},
		},
		["JAP_Warships"] = {
			["sequence"] = {
				{
					["message"] = "dlg17b",
				},
			},
		},
		["B17"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
		["Mission_Complete"] = {
			["sequence"] = {
				{
					["message"] = "dlg19",
				},
				--[[{	["type"] = "callback",
					["callback"] = "" --"luaUSN06_MissionComplete",
				},]]--
			},
		},
		["PTs_Destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg22",
				},
			},
		},
		["Cargos_Add_Primary"] = {
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
				{
					["message"] = "dlg23_1",
				},
			},
		},
		["PT_Reinforcement_Arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
				{
					["message"] = "dlg25",
				},
			},
		},
		["Some_Cargos_Unloaded"] = {
			["sequence"] = {
				{
					["message"] = "dlg26",
				},
			},
		},
		["Many_Cargos_Unloaded"] = {
			["sequence"] = {
				{
					["message"] = "dlg27",
				},
			},
		},
		["Cargos_Failed"] = {
			["sequence"] = {
				{
					["message"] = "dlg28",
				},
				{	["type"] = "callback",
					["callback"] = "luaUSN06_TooManyShipsDocked",
				},
			},
		},
		["Cargos_Success"] = {
			["sequence"] = {
				{
					["message"] = "dlg29",
				},
				{
					["message"] = "dlg29_1",
				},
				{	["type"] = "callback",
					["callback"] = "luaUSN06_FadeInStart_Phase3",
				},
			},
		},
		["South_Dakota_Under_Fire"] = {
			["sequence"] = {
				{
					["message"] = "dlg30a",
				},
				{
					["message"] = "dlg30b",
				},
			},
		},
		["Washington_Reporting"] = {
			["sequence"] = {
				{
					["message"] = "dlg31",
				},
			},
		},
		["Kirishima_Detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg32",
				},
			},
		},
	}
	
	--SoundFade(1, "", 0.1)
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(this, "luaUSN06Think")
	
	--Objectives
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "Convoy",		-- azonosito
				["Text"] = "usn06.obj_p1",									-- "Prevent the unloading of more than 7 japanese transports"
				["TextCompleted"] = "usn06.obj_p1_compl" ,	-- "The cargo convoy suffered fatal losses"
				["TextFailed"] = "usn06.obj_p1_fail",				-- "More than 7 japanese cargo ships unloaded",
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "Battle",		-- azonosito
				["Text"] = "usn06.obj_p2", 									-- "Destroy the enemy warships",
				["TextCompleted"] = "", 	-- Nem irjuk ki ketszer, de "You have destroyed the enemy warships" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn06.obj_p2_fail", 			-- "The US fleet has been annihilated",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "Submarine",		-- azonosito
				["Text"] = "usn06.obj_s1", 									-- "Escape with your submarine",
				["TextCompleted"] = "usn06.obj_s1_compl", 	-- "Your submarine has escaped" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn06.obj_s1_fail", 			-- "Your submarine has been destroyed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["secondary"] = {
			[2] =
			{
				["ID"] = "BBs",		-- azonosito
				["Text"] = 	"usn06.obj_s2", 									-- "Both USS battleships must stay operational",
				["TextCompleted"] = "usn06.obj_s2_compl", 	-- "Our flagships are still up" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", 			-- "One of our Battleships are sunk",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			--[[
			[3] =
			{
				["ID"] = "Retreat",		-- azonosito
				["Text"] = "Reach the evac zone",
				["TextCompleted"] = "You have reached the evac zone" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "You couldn't reach the evac zone",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			]]--
		},
		["hidden"] = 
		{
			[1] =
			{
				["ID"] = "HiddePlanes",		-- azonosito
				["Text"] = "usn06.obj_h1", 	-- "Not even a single japanese cargo managed to unload",
				["TextCompleted"] = "", 		-- "You have successfuly destroyed the japanese Command Center" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", 				-- "You couldn't destroy the japanese Command Center",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["marker2"] = 
		{
			[1] =
			{
				["ID"] = "HidePoint",
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
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetVisibilityTerrainNode("usn06 Second Batt Guadal:mapzone", false)
	
	luaCheckSavedCheckpoint()
	
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		SetSelectedUnit(Mission.USN_Sub[1])
	else
		Mission.MissionPhase = 100
		Blackout(true, "", 0)
		BlackBars(true)
	end
end

------------------------------------------------------------------------------
function luaUSN06Think(this, msg)
	if luaMessageHandler(Mission, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." is terminated!")
		return
	end
	
	if (Mission.EndMission) then
		return
	end
	
	luaCheckMusic()
	if (Mission.Debug) then
		--AddWatch("Mission.Counter")
		--AddWatch("Mission.ConvoyShipDestroyed")
		--AddWatch("Mission.SpawnedConvoyShip")
		--AddWatch("Mission.HintSonarCounter")
		--AddWatch("Mission.HintSonarTimer")
		--AddWatch("Mission.HintTurnCounter")
		--AddWatch("Mission.HintTurnTimer")
	end
	
	Mission.Counter = Mission.Counter + 3
	
	luaUSN06_CheckMissionComplete()
	
	--luaUSN06_CheckHidden()
	
	luaUSN06_RemoveDeadsFromTables()
	
	if (Mission.MissionPhase == 0) then
		--Phase 0 : incializalas
		luaUSN06_StartingBlackout()
		--luaUSN06_TorpedoInit()
		luaUSN06_ConvoyInit()
		luaUSN06_InitHidden()
		--luaUSN06_Timer_ConvoyGenerator(10)
		--luaUSN06_ConvoyGenerator()
		luaUSN06_CheckConvoyHit()
		luaDelay(luaUSN06_CheckSubWasSpotted, 5)
		--luaUSN06_Patrol01()
		luaUSN06_Hidden01_Init()
		luaUSN06_InitPlayerUnits()
		SetDeviceReloadEnabled(true)
		Mission.MissionPhase = 1
		Mission.FirstRun = true
		--[[if (Mission.Debug) then
			SetInvincible(Mission.USN_Sub[1], true)
		end]]--
	elseif (Mission.MissionPhase == 1) then
		--Phase 1 : subbal kell kavarni, addig tart, amig eszre nem veszi valaki a subot
		--TODO: A RemoveDeadsFromTable fv-t ki kell rakni a think gyokerebe, megnezni hogy jo lesz -e ugy + kiegesziteni a tobbivel
		if (Mission.FirstRun) then
			EnableMessages(true)
			luaDelay(luaUSN06_Pri01Init, 2)
			--luaDelay(luaUSN06_Sec01Init, 4)
			luaDelay(luaUSN06_DialogInit, 6)
			--luaDelay(luaUSN06_HintAim, 10)
			Mission.FirstRun = false
		end
		--luaUSN06_Hint_Turn()
		--luaUSN06_Pri01Reminder()
		luaUSN06_Dialog1stTorpedo()
		luaUSN06_CheckSub()
		luaUSN06_CheckPowerUpCondition()
		luaUSN06_CheckPri01()
	elseif (Mission.MissionPhase == 2) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
		end
		--Phase 2 : addig tart, amig a subbal le nem merultunk 4-es szintre
		luaUSN06_Dialog1stTorpedo()
		if (not Mission.ReconPlane) then
			luaUSN06_ReconPlaneSpawn()
			Mission.PTsSpawned = true
			luaUSN06_PTSpawn()
		else
			luaUSN06_ReconPlaneSearching()
		end
		luaUSN06_Hint_Sonar()
		--[[if (not Mission.PTsSpawned) and (Mission.SubSpottedByReconPlane) then
			Mission.PTsSpawned = true
			luaUSN06_PTSpawn()
		end]]--
		if (Mission.PTsSpawned) and (Mission.SubSpottedByReconPlane) then
			luaUSN06_CheckShipsAround()
			luaUSN06_CheckDCFire()
		end
		--luaUSN06_Hint_Turn()
		CheckSubDepth()
		luaUSN06_CheckPowerUpCondition()
		luaUSN06_CheckPri01()
		luaUSN06_Sec01DiveReminder()
	elseif (Mission.MissionPhase == 3) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN06_JAPPts_Listener()
			--luaUSN06_Timer_ConvoyGenerator(1)
			--luaUSN06_Sec02Init()
			--luaDelay(luaUSN06_DialogUSNPT, 5)
			luaDelay(luaUSN06_HintEscort, 30)
			luaDelay(luaUSN06_BonusUnitSpawning, 6)
			--luaUSN06_StartDialog("US_FightersAndPTs")
		end
		luaUSN06_Hint_Cameralock()
		luaUSN06_CheckUSNPlanesNumber()
		luaUSN06_AreaCheck()
		--luaUSN06_CheckSec02()
		--luaUSN06_CheckSec03()
		luaUSN06_CheckPri01()
		luaUSN06_JAPPTs_Attack()
		--luaUSN06_Pri01Reminder()
		luaUSN06_CheckUSNPTsNum()
		luaUSN06_Hint_Turn()
		--[[if (Mission.Squad01AttackPhase) then
			luaUSN06_AttackManager(Mission.JAP_Squad01, Mission.USN_PT)
		end]]--
	elseif (Mission.MissionPhase == 4) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN06_Listener_JapUnits()
		end
		luaUSN06_CheckPri02()
		
		Mission.JAP_Squad02 = luaRemoveDeadsFromTable(Mission.JAP_Squad02)
		if table.getn(Mission.JAP_Squad02) > 0 then
			local leader
			if IsInFormation(Mission.JAP_Squad02[1]) then
				leader = GetFormationLeader(Mission.JAP_Squad02[1])
			else
				leader = Mission.JAP_Squad02[1]
			end
			if leader then
				local target = luaGetNearestEnemy(leader)
				if target then
					NavigatorAttackMove(leader, target)
				end
			end
		end
		if table.getn(Mission.JAP_Squad02) < 4 then
			luaUSN06_DialogWashington()
		end
		--luaUSN06_Pri02Reminder()
		--[[if (table.getn(Mission.USN_NorthSquad) > 0) then	-- ha van meg az eszaki USN unitokbol, akkor azokat tamadjak, egyebkent a megmarado PT-ket es P40-eseket
			luaUSN06_AttackManager(Mission.JAP_Squad01, Mission.USN_NorthSquad)
			luaUSN06_AttackManager(Mission.JAP_Squad02, Mission.USN_NorthSquad)
		else
			luaUSN06_AttackManager(Mission.JAP_Squad01, Mission.USN_Squad)
			luaUSN06_AttackManager(Mission.JAP_Squad02, Mission.USN_Squad)
		end]]--
	end
end

------------------------------------------------------------------------------
function luaUSN06_TorpedoInit()
	ShipSetTorpedoStock(Mission.USN_Sub[1], Mission.TorpedoNumAtStart)
end

------------------------------------------------------------------------------
function luaUSN06_StartingBlackout()
	Blackout(true, "", 0.5, 0)
	--[[local nDEBUGTime = "Blackout_Start = "..GameTime()
	MissionNarrative(nDEBUGTime)]]--
end

------------------------------------------------------------------------------
function luaUSN06_DialogInit()
	luaUSN06_StartDialog("Init")
	luaDelay(luaUSN06_DialogCargos, 15)
end

------------------------------------------------------------------------------
function luaUSN06_DialogCargos()
	--luaUSN06_StartDialog("Cargos_Add_Primary")
	luaDelay(luaUSN06_HintCargo, 15)
end

------------------------------------------------------------------------------
function luaUSN06_HintAim()
	ShowHint("USN06_Hint_Aim")
end

------------------------------------------------------------------------------
function luaUSN06_HintCargo()
	ShowHint("USN06_Hint_Cargo")
	luaDelay(luaUSN06_HintAim, 10)
end

------------------------------------------------------------------------------
function luaUSN06_Dialog1stTorpedo()
	if (Mission.Dialogues["1stTorpedo"].printed == nil) or (not Mission.Dialogues["1stTorpedo"].printed) then
		if (Mission.USN_Sub ~= nil) and (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
			local nActTorpedos = GetProperty(Mission.USN_Sub[1], "TorpedoStock")
-- RELEASE_LOGOFF  			luaLog("TorpedoCheck: Name = "..Mission.USN_Sub[1].Name..", MaxTorpedos = "..Mission.TorpedoNumAtStart..", Torpedos Left = "..nActTorpedos)
			if (nActTorpedos < Mission.TorpedoNumAtStart) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN06_Dialog1stTorpedo): kilotte az elso torpedot a sub")
				luaUSN06_StartDialog("1stTorpedo")
			end
		end
	end
end
------------------------------------------------------------------------------
function luaUSN06_RemoveDeadsFromTables()
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	Mission.JAP_EscortGroup = luaRemoveDeadsFromTable(Mission.JAP_EscortGroup)
	Mission.USN_Squad = luaRemoveDeadsFromTable(Mission.USN_Squad)
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	Mission.USN_P38s = luaRemoveDeadsFromTable(Mission.USN_P38s)
	Mission.USN_BonusUnit = luaRemoveDeadsFromTable(Mission.USN_BonusUnit)
	--Mission.USN_LevelBomber = luaRemoveDeadsFromTable(Mission.USN_LevelBomber)
	Mission.JAP_Squad01 = luaRemoveDeadsFromTable(Mission.JAP_Squad01)
	Mission.JAP_Squad02 = luaRemoveDeadsFromTable(Mission.JAP_Squad02)
	Mission.Convoy = luaRemoveDeadsFromTable(Mission.Convoy)
	Mission.USN_SouthDakota = luaRemoveDeadsFromTable(Mission.USN_SouthDakota)
	Mission.USN_Washington = luaRemoveDeadsFromTable(Mission.USN_Washington)
	Mission.JAP_Units = luaRemoveDeadsFromTable(Mission.JAP_Units)
end

------------------------------------------------------------------------------
function luaUSN06_InitHidden()
	if (not luaObj_IsActive("hidden", 1)) or (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Add("hidden", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_InitHidden): Hidden 01 objektiva addolva")
		if (not IsListenerActive("hit", "Listener_PlanesHiddenHit")) then
			AddListener("hit", "Listener_PlanesHiddenHit", 
				{
					["callback"] = "luaUSN06_PlanesHiddenWasHit",
					["target"] = Mission.PlanesHidden,
					["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
					["attacker"] = {}, -- tamado entityk
					["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY"
					["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
					["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
					["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
					["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
				})
		end
		if (not IsListenerActive("kill", "Listener_PlanesHiddenWasKilled")) then
			AddListener("kill", "Listener_PlanesHiddenWasKilled", 
			{
					["callback"] = "luaUSN06_PlanesHiddenWasDestroyed",
					["entity"] = Mission.PlanesHidden,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}
			})
		end
		if (not IsListenerActive("exitzone", "Listener_HiddenPlaneExit")) then
			AddListener("exitzone", "Listener_HiddenPlaneExit", 
			{ 
				["callback"] = "luaUSN06_PlanesHiddenExit",  -- callback fuggveny
				["entity"] = Mission.PlanesHidden, -- entityk akiken a listener aktiv
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
			})
		end
		for i, pUnit in pairs (Mission.PlanesHidden) do
			AddUntouchableUnit(pUnit)
			--SetForcedReconLevel(pUnit, 0, PARTY_ALLIED)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_PlanesHiddenExit()
	if (IsListenerActive("kill", "Listener_PlanesHiddenWasKilled")) then
		RemoveListener("kill", "Listener_PlanesHiddenWasKilled")
	end
	if (IsListenerActive("hit", "Listener_PlanesHiddenHit")) then
		RemoveListener("hit", "Listener_PlanesHiddenHit")
	end
	RemoveListener("exitzone", "Listener_HiddenPlaneExit")
	luaObj_Failed("hidden", 1)
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_PlanesHiddenWasDestroyed): 1 hidden plane elhagyta a palyat. Hidden failed.")
	--MissionNarrative("1 hidden plane elhagyta a palyat. Hidden failed.")
end

------------------------------------------------------------------------------
function luaUSN06_PlanesHiddenWasHit()
	if (IsListenerActive("hit", "Listener_PlanesHiddenHit")) then
		RemoveListener("hit", "Listener_PlanesHiddenHit")
	end
	if (not Mission.HiddenPlanesActive) then
		for i, pUnit in pairs (Mission.PlanesHidden) do
			SetParty(pUnit, PARTY_JAPANESE)
			PilotRetreat(pUnit)
			SetInvincible(pUnit, 0)
			if (IsUnitUntouchable(pUnit)) then
				RemoveUntouchableUnit(pUnit)
			end
		end
		Mission.HiddenPlanesActive = true
	end
end

------------------------------------------------------------------------------
function luaUSN06_PlanesHiddenWasDestroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_PlanesHiddenWasDestroyed): 1 Hidden plane megsemmisult")
	pEntity.Dead = true
	local bKillListeners = false
-- RELEASE_LOGOFF  	luaLog("KillReason = "..pEntity.KillReason)
	local nCounter = 0
	for i, pUnit in pairs (Mission.PlanesHidden) do
		if (not pUnit.Dead) then
			nCounter = nCounter + 1
		end
	end
	if (nCounter == 0) then
		luaObj_Completed("hidden", 1, true)
		--MissionNarrative("Az osszes hidden plane szet lett love. Hidden complete.")
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_PlanesHiddenWasDestroyed): Az osszes hidden plane szet lett love. Hidden complete.")
		bKillListeners = true
	end
	if (bKillListeners) then
		RemoveListener("kill", "Listener_PlanesHiddenWasKilled")
		if (IsListenerActive("hit", "Listener_PlanesHiddenHit")) then
			RemoveListener("hit", "Listener_PlanesHiddenHit")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyInit()
	for i = 1, table.getn(Mission.Convoy) do
		SetShipMaxSpeed(Mission.Convoy[i], Mission.SpeedOfConvoy)
		AddProximityTrigger(Mission.Convoy[i], "ConvoyReachedPathPoint1", "luaUSN06_ConvoyMove", Mission.ConvoyPath[2], 100)
		NavigatorMoveToRange(Mission.Convoy[i], Mission.ConvoyPath[2])
		SetForcedReconLevel(Mission.Convoy[i], 2, 0)
		--[[if (i > 3) then
			table.insert(Mission.ReconTable, Mission.Convoy[i])
			
		end]]--
	end
	--[[if (IsListenerActive("recon", "Listener_ConvoyForceRecon")) then
		RemoveListener("recon", "Listener_ConvoyForceRecon")
	end
	AddListener("recon", "Listener_ConvoyForceRecon", {
		["callback"] = "luaUSN06_ConvoySpotted_ForceRecon",  -- callback fuggveny
		["entity"] = Mission.ReconTable, -- entityk akiken a listener aktiv
		["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
	})]]--
	if (IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
		RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
	end
	AddListener("kill", "Listener_ConvoyShipWasDestroyed", 
	{
			["callback"] = "luaUSN06_ConvoyShipWasDestroyed",
			["entity"] = Mission.Convoy,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyMove(pEntity)
	RemoveTrigger(pEntity, "ConvoyReachedPathPoint1")
-- RELEASE_LOGOFF  	luaLog("Convoy hajo elerte a PathPoint1-et"..pEntity.Name)
	local nBool = false
	local i = 0
	while (i < table.getn(Mission.ConvoyLandingPoints)) and (not nBool) do
		i = i + 1
		if (Mission.ConvoyLandingPoints[i].Enable) then
			nBool = true
		end
	end
	if (nBool) then
		AddProximityTrigger(pEntity, "ConvoyReachedLandingPoint", "luaUSN06_ConvoyShipReachedLP", Mission.ConvoyLandingPoints[i], 100)
		NavigatorMoveToRange(pEntity, Mission.ConvoyLandingPoints[i])
		Mission.ConvoyLandingPoints[i].Enable = false
		pEntity.LandingPoint = i
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("Kov. szabad landing point: "..i)
		end
	else
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("Nincs szabad landing point")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyShipReachedLP(pEntity)
	RemoveTrigger(pEntity, "ConvoyReachedLandingPoint")
	Mission.DockedConvoyShip = Mission.DockedConvoyShip + 1
	--ModifyKeyUnitNumber(Mission.DockedConvoyShip)
	--[[if ((not luaObj_IsActive("primary", 3)) or ((luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) ~= nil))) then
		DisplayScores(1, 0, "usn06.score01", tostring(Mission.DockedConvoyShip))
	end]]--
	pEntity.State = 1
	luaDelay(luaUSN06_ConvoyShipGoToExitZone, 40, "pEntity", pEntity)
	if (Mission.DockedConvoyShip == 3) then
		luaUSN06_StartDialog("Some_Cargos_Unloaded")
	elseif (Mission.DockedConvoyShip == 6) then
		luaUSN06_StartDialog("Many_Cargos_Unloaded")
	end
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyShipGoToExitZone(TimerThis)
	pEntity = TimerThis.ParamTable.pEntity
	if (not pEntity.Dead) then
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_ConvoyShipGoToExitZone): "..pEntity.Name)
		end
		AddProximityTrigger(pEntity, "ConvoyReachedExitPoint", "luaUSN06_ConvoyReachedExitPoint", Mission.ConvoyExitPoints[1], 100)
		NavigatorMoveToRange(pEntity, Mission.ConvoyExitPoints[1])
		pEntity.State = 2
		nLandingPoint = pEntity.LandingPoint
		Mission.ConvoyLandingPoints[nLandingPoint].Enable = true
		pEntity.LandingPoint = 0
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_ConvoyShipGoToExitZone): A kov. landingPoint felszabaditva: "..nLandingPoint)
		end
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_ConvoyShipGoToExitZone): Egy hajo a kikotoben megsemmisult es a luaDelay lejart")
	end
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyReachedExitPoint(pEntity)
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_ConvoyReachedExitPoint): "..pEntity.Name)
	end
	Kill(pEntity, true)
	Mission.Convoy = luaRemoveDeadsFromTable(Mission.Convoy)
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyGenerator_Ver2()	-- ez a generateobject-es convoygenerator
	luaUSN06_GenerateConvoyShip("Japan Troop Transport 03")
	luaUSN06_GenerateConvoyShip("Japan Cargo Transport 03")
	luaUSN06_GenerateConvoyShip("Japan Troop Transport 02")
	luaUSN06_GenerateConvoyShip("Japan Troop Transport 04")
	luaUSN06_GenerateConvoyShip("Japan Cargo Transport 04")
	luaUSN06_GenerateConvoyShip("Type1 - light 01")
	luaUSN06_GenerateConvoyShip("Type1 - light 02")
	luaUSN06_GenerateConvoyShip("Type1 - light 03")
	luaUSN06_GenerateConvoyShip("Japan Troop Transport 05")
	if (IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
		RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
	end
	AddListener("kill", "Listener_ConvoyShipWasDestroyed", 
	{
			["callback"] = "luaUSN06_ConvoyShipWasDestroyed",
			["entity"] = Mission.Convoy,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

------------------------------------------------------------------------------
function luaUSN06_GenerateConvoyShip(szName)
	local tUnit = luaFindHidden(szName)
	local pEntity = GenerateObject(tUnit.Name, szName)
	SetGuiName(pEntity, Mission.TroopTransportNames[Mission.TroopActNumber])
	Mission.TroopActNumber = Mission.TroopActNumber + 1
	pEntity.LandingPoint = 0
	pEntity.State = 0
	SetShipMaxSpeed(pEntity, Mission.SpeedOfConvoy)
	AddProximityTrigger(pEntity, "ConvoyReachedPathPoint1", "luaUSN06_ConvoyMove", Mission.ConvoyPath[2], 100)
	NavigatorMoveToRange(pEntity, Mission.ConvoyPath[2])
	SetForcedReconLevel(pEntity, 2, 0)
	table.insert(Mission.Convoy, pEntity)
	luaObj_AddUnit("primary", 1, pEntity)
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.Convoy = luaRemoveDeadsFromTable(Mission.Convoy)
	if (pEntity.State == 0) or (pEntity.State == 1) then
		Mission.ConvoyShipDestroyed = Mission.ConvoyShipDestroyed + 1
		if ((not luaObj_IsActive("primary", 3)) or ((luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) ~= nil))) then
			DisplayScores(2, 0, "usn06.score02", tostring(Mission.ConvoyShipDestroyed).."/"..tostring(Mission.MaxConvoyNum))
		end
		nLandingPoint = pEntity.LandingPoint
		if (nLandingPoint ~= 0) then
			Mission.ConvoyLandingPoints[nLandingPoint].Enable = true
		end
		--Mission.ConvoyShipDestroyed = Mission.ConvoyShipDestroyed + 1
		local nConvoyShipsLeft = Mission.ShipsNeedToDestroy - Mission.ConvoyShipDestroyed
		--ModifyKeyUnitNumber(nConvoyShipsLeft)
		--DisplayScores(1, 0, "usn06.score01", tostring(Mission.DockedConvoyShip))
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("Megsemmisult Convoy hajo: "..pEntity.Name..", Kilott hajok szama = "..Mission.ConvoyShipDestroyed)
		end
	else
		if (Mission.Debug) then
-- RELEASE_LOGOFF  			luaLog("Megsemmisult Convoy hajo, ami mar kiarakodott: "..pEntity.Name)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_EscortGenerator_Ver2()
	if (Mission.difficulty == 0) then
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 01", 1)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 04", 2)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 07", 1)
	elseif (Mission.difficulty == 1) then
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 01", 1)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 02", 2)
		luaUSN06_GenerateEscortShip("Fubuki-class 09", 2)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 07", 1)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 06", 2)
	elseif (Mission.difficulty == 2) then
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 01", 1)
		luaUSN06_GenerateEscortShip("Fubuki-class 01", 2)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 05", 1)
		luaUSN06_GenerateEscortShip("Fubuki-class 09", 2)
		luaUSN06_GenerateEscortShip("Japanese Patrolboat 06", 2)
		luaUSN06_GenerateEscortShip("Fubuki-class 10", 1)
	end
end

------------------------------------------------------------------------------
function luaUSN06_GenerateEscortShip(szName, nNavPointNum)
	local tUnit = luaFindHidden(szName)
	local pEntity = GenerateObject(tUnit.Name, szName)
	local nClassID = VehicleClass[pEntity.Class.ID]
	if (nClassID == 77) then
		local nRnd = luaRnd(100, 999)
		local szPTName = "ingame.shipnames_gyoraitei|."..nRnd
		SetGuiName(pEntity, szPTName)
	elseif (nClassID == 73) then
		SetGuiName(pEntity, Mission.FubukiNames[Mission.FubukiNumber])
		if (Mission.FubukiNumber == table.getn(Mission.FubukiNames)) then
			Mission.FubukiNumber = 0
		end
		Mission.FubukiNumber = Mission.FubukiNumber + 1
	end
	UnitFreeAttack(pEntity)
	SetShipMaxSpeed(pEntity, Mission.SpeedOfConvoy)
	table.insert(Mission.JAP_EscortGroup, pEntity)
	local nPos = GetPosition(Mission.EscortPath[nNavPointNum])
	NavigatorMoveToRange(pEntity, nPos)
	if (nNavPointNum == 1) then
		AddProximityTrigger(pEntity, "EscortShipReachedNavpoint01_Ver2", "luaUSN06_EscortShipReachedNavpoint01_Ver2", nPos, 500)
	else
		AddProximityTrigger(pEntity, "EscortShipReachedNavpoint02_Ver2", "luaUSN06_EscortShipReachedNavpoint02_Ver2", nPos, 500)
	end
end

------------------------------------------------------------------------------
function luaUSN06_EscortShipReachedNavpoint01_Ver2(pEntity)
	local nPos = GetPosition(Mission.EscortPath[3])
	NavigatorMoveToRange(pEntity, nPos)
end

------------------------------------------------------------------------------
function luaUSN06_EscortShipReachedNavpoint02_Ver2(pEntity)
	local nPos = GetPosition(Mission.EscortPath[4])
	NavigatorMoveToRange(pEntity, nPos)
end

------------------------------------------------------------------------------
function luaUSN06_Pri01Init()
	if (not luaObj_IsActive("primary", 1)) then
		luaObj_Add("primary", 1, Mission.Convoy, false)
		DisplayScores(2, 0, "usn06.score02", tostring(Mission.ConvoyShipDestroyed).."/"..tostring(Mission.MaxConvoyNum))
-- RELEASE_LOGOFF  		luaLog("Primary 01 objective has added")
	end
end

------------------------------------------------------------------------------
function luaUSN06_Pri01Reminder()
	luaObj_Reminder("primary", 1)
end

------------------------------------------------------------------------------
function luaUSN06_Sec01DiveReminder()
	if (Mission.MissionPhase == 2) and (Mission.HintSafeZoneEnabled) then
		ShowHint("USN06_Hint_Safezone")
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_Sec01DiveReminder): Dive hint kiirva")
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_Sec01DiveReminder): Nincs Dive hint, mert a missionphase ~= 2")
	end
end

------------------------------------------------------------------------------
function luaUSN06_InitPlayerUnits()
	if (IsListenerActive("kill", "Listener_SubmarineWasDestroyed")) then
			RemoveListener("kill", "Listener_SubmarineWasDestroyed")
	end
	AddListener("kill", "Listener_SubmarineWasDestroyed", 
	{
			["callback"] = "luaUSN06_SubmarineWasDestroyed",
			["entity"] = Mission.USN_Sub,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
	if (IsListenerActive("exitzone", "Listener_SubmarineExitZone")) then
			RemoveListener("exitzone", "Listener_SubmarineExitZone")
	end
	AddListener("exitzone", "Listener_SubmarineExitZone", { 
		["callback"] = "luaUSN06_SubmarineWasDestroyed",  -- callback fuggveny
		["entity"] = Mission.USN_Sub, -- entityk akiken a listener aktiv
		["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
end
------------------------------------------------------------------------------
function luaUSN06_Sec01Init()
	if (not luaObj_IsActive("primary", 3)) then
		--luaObj_Add("secondary", 1, {}, false)
		luaObj_Add("primary", 3, {}, false)
		SetVisibilityTerrainNode("usn06 Second Batt Guadal:mapzone", true)
		luaDelay(luaUSN06_HintSafeZone_Enabled, 5)
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_Sec01Init): Primary 03 objective has added")
		HideScoreDisplay(1, 0)
		HideScoreDisplay(2, 0)
		DisplayScores(1, 0, "usn06.obj_s1", "")
		--luaObj_Add("marker2", 1)
		local tPosPoints = {}
		local nPos
		for i, pNavpoint in pairs (Mission.HideNavpoints) do
			nPos = GetPosition(pNavpoint)
			table.insert(tPosPoints, nPos)
		end
		--luaObj_AddUnit("marker2", 1, tPosPoints)
		luaDelay(luaUSN06_Activate_Hint_Turn, 10)
		--Countdown("usn06.obj_s1", 1, Mission.CountDownTimer, "luaUSN06_TimeHasExpired")
		--TODO: markerrel megjelolni par helyet a lemeruleshez
-- RELEASE_LOGOFF  		luaLog("Secondary 01 objective has added")
	end	
end

------------------------------------------------------------------------------
function luaUSN06_Activate_Hint_Turn()
	Mission.HintTurnTimer = 0
end

------------------------------------------------------------------------------
function luaUSN06_Hint_Turn()
	if (Mission.HintTurnTimer > 0) then
		Mission.HintTurnTimer = Mission.HintTurnTimer - 3
		if (Mission.HintTurnTimer < 0) then
			Mission.HintTurnTimer = 0
		end
	end
	if (Mission.HintTurnTimer == 0) and (Mission.HintTurnCounter < 4) then
		local pSelected = GetSelectedUnit()
		if (pSelected ~= nil) and (luaGetType(pSelected) == "plane") then
			ShowHint("Advanced_Hint_Turn")
			Mission.HintTurnTimer = 240
			Mission.HintTurnCounter = Mission.HintTurnCounter + 1
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_TimeHasExpired()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_TimeHasExpired): A Sec01 timere lejart")
	CountdownCancel()
	if (IsListenerActive("kill", "Listener_SubmarineWasDestroyed")) then
		RemoveListener("kill", "Listener_SubmarineWasDestroyed")
	end
	--TODO: dialogust kiirni a failed-re
	Mission.MissionPhase = 100
	Mission.FirstRun = true
	luaObj_Failed("secondary", 1)
	luaUSN06_FadeOut_Phase2()
	Mission.NeedAreaCheck = true
end

------------------------------------------------------------------------------
function luaUSN06_SubmarineWasDestroyed()
-- RELEASE_LOGOFF  	luaLog("A submarine-t kicsinaltak. Szemetek!")
	--CountdownCancel()
	luaUSN06_StartDialog("SubLost")
	if (IsListenerActive("kill", "Listener_SubmarineWasDestroyed")) then
		RemoveListener("kill", "Listener_SubmarineWasDestroyed")
	end
	if (IsListenerActive("exitzone", "Listener_SubmarineExitZone")) then
			RemoveListener("exitzone", "Listener_SubmarineExitZone")
	end
	if (IsListenerActive("hit", "Listener_ConvoyHit")) then
		RemoveListener("hit", "Listener_ConvoyHit")
	end
	--Mission.SubControlable = false
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	if (Mission.MissionPhase < 3) then
		Mission.MissionPhase = 100
		--luaLog("(CheckSubDepth): MissionPhase = "..Mission.MissionPhase)
		Mission.FirstRun = true
		if (luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) == nil) then
			--luaObj_Failed("secondary", 1)
			luaObj_Failed("primary", 3)
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_SubmarineWasDestroyed): Primary 03 objective has failed")
			local tPosPoints = {}
			--[[local nPos
			for i, pNavpoint in pairs (Mission.HideNavpoints) do
				nPos = GetPosition(pNavpoint)
				luaObj_RemoveUnit("marker2", 1, nPos)
			end]]--
			HideScoreDisplay(1, 0)
			if (IsListenerActive("hit", "Listener_ConvoyHit")) then
				RemoveListener("hit", "Listener_ConvoyHit")
			end
		end
		HideScoreDisplay(1, 0)
		
		--luaDelay(luaUSN06_EM01C_Blackout, 5)
		luaUSN06_MissionFailed(pEntity, "usn06.obj_s1_fail")
		--luaUSN06_EM01C_Start()
		
		
		--Mission.NeedAreaCheck = true
	end
end

------------------------------------------------------------------------------
function luaUSN06_EM01C_Blackout()
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	Blackout(true, "", 3, 1)
	--luaUSN06_FadeOut_Phase2()
	luaUSN06_FadeOut_Phase2()
end

------------------------------------------------------------------------------
function luaUSN06_CheckConvoyHit()
	AddListener("hit", "Listener_ConvoyHit", 
		{
			["callback"] = "luaUSN06_ConvoyWasHit",
			["target"] = Mission.Convoy,
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
end

------------------------------------------------------------------------------
function luaUSN06_CheckSubWasSpotted()
	AddListener("recon", "Listener_SubSpotted", {
		["callback"] = "luaUSN06_SubWasSpotted",  -- callback fuggveny
		["entity"] = Mission.USN_Sub, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

------------------------------------------------------------------------------
function luaUSN06_ConvoyWasHit()
	Mission.SubWasSpotted = true
	ShowHint("USN06_Hint_SubSpotted")
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_ConvoyWasHit): A convoy-t talalat erte, a subot eszrevettek")
		Mission.SubPos = GetPosition(Mission.USN_Sub[1])
	end
	--[[if (IsListenerActive("recon", "Listener_SubSpotted")) then
		RemoveListener("recon", "Listener_SubSpotted")
	end]]--
end

------------------------------------------------------------------------------
function luaUSN06_SubWasSpotted()
	Mission.SubWasSpotted = true
	--MissionNarrative(Mission.Narratives[1])
	ShowHint("USN06_Hint_SubSpotted")
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_SubWasSpotted): A subot eszrevettek")
		Mission.SubPos = GetPosition(Mission.USN_Sub[1])
	end
	--[[if (IsListenerActive("hit", "Listener_ConvoyHit")) then
		RemoveListener("hit", "Listener_ConvoyHit")
	end]]--
end

------------------------------------------------------------------------------
function luaUSN06_CheckSub()
	if (Mission.SubWasSpotted) then
		if (IsListenerActive("hit", "Listener_ConvoyHit")) then
			RemoveListener("hit", "Listener_ConvoyHit")
		end
		if (IsListenerActive("recon", "Listener_SubSpotted")) then
			RemoveListener("recon", "Listener_SubSpotted")
		end
		--MissionNarrative(Mission.Narratives[1])
		Mission.SubPos = GetPosition(Mission.USN_Sub[1])
		--luaUSN06_PTSpawn()
		Mission.MissionPhase = 2
		Mission.FirstRun = true
	end
end

------------------------------------------------------------------------------
function luaUSN06_ReconPlaneSpawn()
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_ReconPlaneSpawn): A ReconPlane spawnolt")
	end
	nRnd = luaRnd(0, 100)
	local nSpawnPos
	if (nRnd < 50) then
		nSpawnPos = GetPosition(Mission.ShipyardSpawnPoints[1])
	else
		nSpawnPos = GetPosition(Mission.ShipyardSpawnPoints[2])
	end
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 171,
			--TODO: szoveget lockitelni
			["Name"] = "Pete",
			["Crew"] = 1,
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = nSpawnPos,
		["angleRange"] = { 1, -1},
		["lookAt"] = GetPosition(Mission.LookatPointShipyard[1]),
	},
	["callback"] = "luaUSN06_ReconPlaneWasSpawned",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100
	},
	})
end

------------------------------------------------------------------------------
function luaUSN06_ReconPlaneWasSpawned(pEntity)
	Mission.ReconPlane = true
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	table.insert(Mission.JAP_ReconPlanes, pEntity)
	if (IsListenerActive("kill", "Listener_ReconPlaneWasDestroyed")) then
		RemoveListener("kill", "Listener_ReconPlaneWasDestroyed")
	end
	AddListener("kill", "Listener_ReconPlaneWasDestroyed", 
	{
			["callback"] = "luaUSN06_ReconplaneWasDestroyed",
			["entity"] = Mission.JAP_ReconPlanes,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
	if (Mission.USN_Sub ~= nil) and (table.getn(Mission.USN_Sub) > 0) then
		PilotMoveTo(Mission.JAP_ReconPlanes[1], Mission.USN_Sub[1])
	end
end

------------------------------------------------------------------------------
function luaUSN06_ReconplaneWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_ReconPlanes = luaRemoveDeadsFromTable(Mission.JAP_ReconPlanes)
	RemoveListener("kill", "Listener_ReconPlaneWasDestroyed")
	Mission.ReconPlane = false
end

------------------------------------------------------------------------------
function luaUSN06_ReconPlaneSearching()
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	if (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
		PilotMoveTo(Mission.JAP_ReconPlanes[1], Mission.USN_Sub[1])
		--TODO: Itt meg levizsgalni, hogy a sub nem 4-es szinten van -e. Ha 4-es szinten van, akkor nem kell eszrevenni a reconplane-nek
		if (luaGetDistance(Mission.JAP_ReconPlanes[1], Mission.USN_Sub[1]) < 500) then		
			if (not Mission.SubSpottedByReconPlane) then
				Mission.SubSpottedByReconPlane = true
				--MissionNarrative(Mission.Narratives[3])
				--ShowHint("USN06_Hint_Sonar") -> van helyette altalanos hint
				Mission.HintSonarTimer = 0
				luaDelay(luaUSN06_Sec01Init, 4)
				luaDelay(luaUSN06_EM01, 3)
			end
			Mission.SubPos = GetPosition(Mission.USN_Sub[1])
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_Hint_Sonar()
	if (Mission.HintSonarTimer > 0) then
		Mission.HintSonarTimer = Mission.HintSonarTimer - 3
		if (Mission.HintSonarTimer < 0) then
			Mission.HintSonarTimer = 0
		end
	end
	if (Mission.HintSonarTimer == 0) and (Mission.HintSonarCounter < 4) then
		ShowHint("Advanced_Hint_Sonar")
		Mission.HintSonarTimer = 240
		Mission.HintSonarCounter = Mission.HintSonarCounter + 1
	end
end

------------------------------------------------------------------------------
function luaUSN06_Dialog_PTSwarm()
	luaUSN06_StartDialog("JAPPT")
	luaDelay(luaUSN06_Dialog_DiveWithSub, 5)
end

------------------------------------------------------------------------------
function luaUSN06_Dialog_DiveWithSub()
	luaUSN06_StartDialog("SubDive")
	luaDelay(luaUSN06_HintSubDive, 15)
end

------------------------------------------------------------------------------
function luaUSN06_HintSubDive()
	luaDelay(luaUSN06_Dialog_USN_Reinforcement, 6)
end

------------------------------------------------------------------------------
function luaUSN06_Dialog_USN_Reinforcement()
	luaUSN06_StartDialog("USNPT")
end

------------------------------------------------------------------------------
function luaUSN06_StartDialog(szDialogID)
	if (Mission.Dialogues[szDialogID].printed == nil) then
		Mission.Dialogues[szDialogID].printed = true
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_StartDialog): "..szDialogID)
		StartDialog(szDialogID, Mission.Dialogues[szDialogID])
	end
end

------------------------------------------------------------------------------
function luaUSN06_EM01()
	luaDelay(luaUSN06_Dialog_PTSwarm, 10)
	--luaJumpinMovieSetCurrentMovie("JumpTo",Mission.JAP_ReconPlanes[1].ID)
-- RELEASE_LOGOFF  	luaLog("A 01-es EM lejatszodott")
	Mission.EngineMovie01 = true
end

------------------------------------------------------------------------------
function luaUSN06_PTSpawn()
	if (Mission.JAPSpawnedPTs < Mission.MaxJapPTNum) and (Mission.MissionPhase < 4) then
		local nPos
		nRnd = luaRnd(0, 100)
		if (nRnd < 50) then
			nPos = GetPosition(Mission.ShipyardSpawnPoints[1])
			if (Mission.Debug) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN06_PTSpawn): PT spawnolt az 1-es shipyardhoz")
			end
		else
			nPos = GetPosition(Mission.ShipyardSpawnPoints[2])
			if (Mission.Debug) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN06_PTSpawn): PT spawnolt a 2-es shipyardhoz")
			end
		end
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = 77,
					--TODO: szoveget lockitelni
					["Name"] = "Japanese PT", --TODO: a nevet lokalizalni
					["Crew"] = 2,
					["Race"] = JAPANESE,
				},
			},
			["area"] = {
				["refPos"] = nPos,
				["angleRange"] = { DEG(0),DEG(180)},
				["lookAt"] = GetPosition(Mission.LookatPointShipyard[1])
	
			},
			["callback"] = "luaUSN06_PTMove",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 5,
				["enemyHorizontal"] = 5,
				["ownVertical"] = 5,
				["enemyVertical"] = 5,
				["formationHorizontal"] = 200,
			},
			})
		end
end

------------------------------------------------------------------------------
function luaUSN06_PTMove(pEntity)
	local nRnd = luaRnd(100, 999)
	local szPTName = "ingame.shipnames_gyoraitei|."..nRnd
	--SetGuiName(pEntity, "Gyoraitei No."..Mission.JapPTNumber)
	Mission.JapPTNumber = Mission.JapPTNumber + 1
	SetGuiName(pEntity, szPTName)
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	pEntity.Area = 0
	table.insert(Mission.JAPPTs, pEntity)
	local nMaxSpeed = 0
	if (Mission.MaxSpeedOfJapPts ~= 0) then
		nMaxSpeed = KTS(Mission.MaxSpeedOfJapPts)
	else
		nMaxSpeed = Mission.DefaultPTSpeed
	end
	SetShipMaxSpeed(pEntity, nMaxSpeed)
	Mission.JAPSpawnedPTs = Mission.JAPSpawnedPTs + 1
	if (Mission.USN_Sub ~= nil) and (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
		--NavigatorAttackMove(pEntity, Mission.USN_Sub[1], {})
		luaSetScriptTarget(pEntity, Mission.USN_Sub[1])
		NavigatorMoveToRange(pEntity, Mission.SubPos)
	else
		luaUSN06_AreaCheck()
	end
	luaDelay(luaUSN06_PTSpawn, 7)
end

------------------------------------------------------------------------------
function luaUSN06_CheckDCFire()
	if (Mission.Dialogues["1stDepthCharge"].printed == nil) or (not Mission.Dialogues["1stDepthCharge"].printed) then
		local bTorpedoFired = false
		for i, pUnit in pairs (Mission.JAPPTs) do
			if (HasFired(pUnit, "DEPTHCHARGE", 3.0)) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN06_CheckTorpedoFire): Az egyik PT ledobott egy DC-t")
				bTorpedoFired = true
			end
		end
		if (bTorpedoFired) then
			luaUSN06_StartDialog("1stDepthCharge")
			luaUSN06_StartDialog("Reminder_4thDepth")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_CheckShipsAround()
--TODO: ebben a fuggvenyben a kov. NavigatorMoveToRange-ben script hibat dobott. Meg kell nezni miert.
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	if (table.getn(Mission.USN_Sub) > 0) and (Mission.SubControlable) and (not Mission.USN_Sub[1].Dead) then
		local tTempTable = Mission.JAPPTs
		--local tTempTable2 = {}
		local tPos = Mission.SubPos  --GetPosition(Mission.USN_Sub[1])
		local nRndX = 0
		local nRndY = 0
		local tTempPos
-- RELEASE_LOGOFF  		luaLog("(CheckShipsAround): TableLength = "..table.getn(tTempTable))
		--tTempTable2 = luaGetShipsAroundCoordinate(tPos, 1000, PARTY_ALLIED, "enemy", nil, nil, nil)
		--[[if (tTempTable2 ~= nil) and (table.getn(tTempTable2) > 0) then
			for i = 1, table.getn(tTempTable2) do
				if (tTempTable2[i].Class.ID == 77) then
					table.insert(tTempTable, tTempTable2[i])
				end
			end
		end]]--
		--if (table.getn(tTempTable) ~= nil) and (table.getn(tTempTable) > 0) then
			if (GetSubmarineDepthLevel(Mission.USN_Sub[1]) == 3) then
				if (Mission.Debug) then
-- RELEASE_LOGOFF  					luaLog("---A sub a 3-as szinten van, nincs tamadas---")
				end
				for i = 1, table.getn(tTempTable) do
					nRndX = luaRnd(-50, 50)
					nRndY = luaRnd(-50, 50)
					tTempPos = tPos
					tTempPos["x"] = tTempPos["x"] + nRndX
					tTempPos["y"] = tTempPos["y"] + nRndY
					--luaSetScriptTarget(tTemptTable[i], nil)
-- RELEASE_LOGOFF  					luaLog("(CheckShipsAround) 3-as Sub szint: PT Name = "..tTempTable[i].Name..", TargetPos = "..tPos["x"]..","..tPos["y"]..","..tPos["z"])
					NavigatorMoveToRange(tTempTable[i], tPos)
					--[[if (Mission.Debug) then
-- RELEASE_LOGOFF  						luaLog(tTempTable[i].Name..": Sub Pos-ra megy")
					end]]--
				end
			elseif (GetSubmarineDepthLevel(Mission.USN_Sub[1]) == 0) then
				if (Mission.Debug) then
-- RELEASE_LOGOFF  					luaLog("---A sub a 0-as szinten van, tamadas torpedoval---")
				end
				for i = 1, table.getn(tTempTable) do
					local pTarget = luaGetScriptTarget(tTempTable[i])
					--[[if (pTarget ~= nil) then
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 0-as Sub szint: PT Name = "..tTempTable[i]..", Target = "..pTarget.Name)
					else
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 0-as Sub szint: PT Name = "..tTempTable[i]..", Target = nil")
					end]]--
					if (pTarget == nil) or (pTarget ~= Mission.USN_Sub) then
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 0-as Sub szint: "..tTempTable[i].Name..", Target = nil")
						luaSetScriptTarget(tTempTable[i], Mission.USN_Sub[1])
					else
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 0-as Sub szint: "..tTempTable[i].Name..", Target = "..pTarget.Name)
					end
					TorpedoEnable(tTempTable[i], true)
					NavigatorAttackMove(tTempTable[i], Mission.USN_Sub[1], {})
					if (Mission.Debug) then
-- RELEASE_LOGOFF  						luaLog(tTempTable[i].Name..": Sub-ot tamad torpedoval")
					end
				end
			else
				if (Mission.Debug) then
-- RELEASE_LOGOFF  					luaLog("---A sub a 1-es vagy 2-es szinten van, tamadas depth charge-zsal---")
				end
				for i = 1, table.getn(tTempTable) do
					local pTarget = luaGetScriptTarget(tTempTable[i])
					--[[if (pTarget ~= nil) then
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 1-es vagy 2-es Sub szint: PT Name = "..tTempTable[i]..", Target = "..pTarget.Name)
					else
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 1-es vagy 2-es Sub szint: PT Name = "..tTempTable[i]..", Target = nil")
					end]]--
					if  (pTarget == nil) or (pTarget ~= Mission.USN_Sub[1]) then
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 1-es vagy 2-es Sub szint: "..tTempTable[i].Name..", Target = nil")
						luaSetScriptTarget(tTempTable[i], Mission.USN_Sub[1])
					else
-- RELEASE_LOGOFF  						luaLog("(CheckShipsAround) 1-es vagy 2-es Sub szint: "..tTempTable[i].Name..", Target = "..pTarget.Name)
					end
					--TorpedoEnable(tTempTable[i], false)
					--ForceFireDepthCharge(tTempTable[i])
					NavigatorAttackMove(tTempTable[i], Mission.USN_Sub[1], {})
					--TorpedoEnable(tTempTable[i], true)
					--[[if (luaGetDistance(tTempTable[i], Mission.USN_Sub[1]) < 50) then
						ForceFireDepthCharge(tTempTable[i])
					else
						nRndX = luaRnd(10, 10)
						nRndY = luaRnd(10, 10)
						tTempPos = tPos
						tTempPos["x"] = tTempPos["x"] + nRndX
						tTempPos["y"] = tTempPos["y"] + nRndY
						NavigatorMoveToRange(tTempTable[i], tPos)
					end]]--
					if (Mission.Debug) then
-- RELEASE_LOGOFF  						luaLog(tTempTable[i].Name..": Sub-ot tamad depth charge-zsal")
					end
				end
			end
		--end
	end
end

------------------------------------------------------------------------------
function CheckSubDepth()
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	Mission.JAP_ReconPlanes = luaRemoveDeadsFromTable(Mission.JAP_ReconPlanes)
	if (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
		local tPos = GetPosition(Mission.USN_Sub[1])
		--if (GetSubmarineDepthLevel(Mission.USN_Sub[1]) == 3) then
		if (tPos["y"] < Mission.SubDeepLevel) then --and ((luaGetDistance(Mission.USN_Sub[1], Mission.HideNavpoints[1]) < 500) or (luaGetDistance(Mission.USN_Sub[1], Mission.HideNavpoints[2]) < 500) or (luaGetDistance(Mission.USN_Sub[1], Mission.HideNavpoints[3]) < 500)) then
			SetInvincible(Mission.USN_Sub[1], 1)
			--SetRoleAvailable(Mission.USN_Sub[1], EROLF_ALL, PLAYER_AI)
-- RELEASE_LOGOFF  			luaLog("(CheckSubDepth): A sub lemerult a legmelyebb szintre")
			CountdownCancel()
			--luaObj_Completed("secondary", 1)
			luaObj_Completed("primary", 3, true)
			SetVisibilityTerrainNode("usn06 Second Batt Guadal:mapzone", false)
-- RELEASE_LOGOFF  			luaLog("(CheckSubDepth): Primary 03 objective has completed")
			--[[local tPosPoints = {}
			local nPos
			for i, pNavpoint in pairs (Mission.HideNavpoints) do
				nPos = GetPosition(pNavpoint)
				luaObj_RemoveUnit("marker2", 1, nPos)
			end]]--
			HideScoreDisplay(1, 0)
			luaUSN06_StartDialog("SubIn4thDepth")
			if (Mission.Debug) then
-- RELEASE_LOGOFF  				luaLog("Sec01 Obj Completed")
			end
			if (Mission.JAP_ReconPlanes ~= nil) and (table.getn(Mission.JAP_ReconPlanes) > 0) then
				PilotMoveTo(Mission.JAP_ReconPlanes[1], Mission.ConvoyExitPoints[1])
				AddProximityTrigger(Mission.JAP_ReconPlanes[1], "ReconPlaneReachedEvacZone", "luaUSN06_ReconPlaneReachedEvacZone", Mission.ConvoyExitPoints[1], 100)
			end
			Mission.HintSafeZoneEnabled = false
			Mission.MissionPhase = 100
			--luaLog("(CheckSubDepth): MissionPhase = "..Mission.MissionPhase)
			--[[Mission.FirstRun = true
			Mission.NeedAreaCheck = true]]--
			--luaDelay(luaUSN06_BlackOut_Phase2, 14)
			luaUSN06_EM01A_Sub()
		else
-- RELEASE_LOGOFF  			luaLog("Sub depth = "..tPos["y"])
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_BlackOut_Phase2()
	Blackout(true, "", 3, 1)
end

------------------------------------------------------------------------------
function luaUSN06_EM01A_Sub()
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	BlackBars(true)
	Mission.CamScript = luaCamIngameMovieAuto(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub[1], ["distance"] = 100, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub[1], ["distance"] = 70, ["theta"] = 0, ["rho"] = 80, ["moveTime"] = 18, ["smoothtime"] = 2},
		},
		luaUSN06_EM01A_End)
	
	--[[Mission.CamScript = luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub[1], ["distance"] = 100, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Sub[1], ["distance"] = 70, ["theta"] = 0, ["rho"] = 80, ["moveTime"] = 18, ["smoothtime"] = 2},
	},
	luaUSN06_EM01A_End,
	false)
	]]--
	AddListener("input", "Listener_EM01A", {
			["callback"] = "luaUSN06_EM01A_End",  -- callback fuggveny
			["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
			})
	
end

------------------------------------------------------------------------------
--[[function luaUSN06_EM01A_Interrupted()
	if (IsListenerActive("input","Listener_EM01A")) then
		RemoveListener("input","Listener_EM01A")
	end
	if (Mission.CamScript ~= nil) and (Mission.CamScript.Dead == false) then
			DeleteScript(Mission.CamScript)
	end
	luaUSN06_EM01A_End()
-- RELEASE_LOGOFF  	luaLog("#1 BlackOut")
end
]]--
------------------------------------------------------------------------------
function luaUSN06_EM01A_End()
	if (IsListenerActive("input","Listener_EM01A")) then
		RemoveListener("input","Listener_EM01A")
	end
	if (Mission.CamScript ~= nil) and (Mission.CamScript.Dead == false) then
			DeleteScript(Mission.CamScript)
	end
	Blackout(true, "", 0.5)
	luaUSN06_KillAllDialog()
	EnableMessages(true)
	--EnableInput(true)
	luaUSN06_FadeOut_Phase2()
end

------------------------------------------------------------------------------
function luaUSN06_FadeOut_Phase2()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_FadeOut_Phase2): meghivodtam")
	--Blackout(true, "luaUSN06_FadeOut_Phase2_End", 3, 1)
	--Blackout(true, "", 2)
	luaDelay(luaUSN06_FadeOut_Phase2_End, 3)
	luaUSN06_ConvoyGenerator_Ver2()
	luaUSN06_EscortGenerator_Ver2()
	--luaDelay(luaUSN06_FadeInStart_Phase2, 6)
	luaUSN06_USNPT_Spawning()
	luaUSN06_P38Spawning()
	--if (Mission.UnlockLvl ~= nil) and (Mission.UnlockLvl > 1) then
	--[[if (Scoring_IsUnlocked("USN_04_SILVER")) then
		luaUSN06_UnlockLevelBomber()
	end]]--
	--luaUSN06_JAPPT_Teleport()
	luaUSN06_JAPPTSpawn_Phase2()
	--luaUSN06_SpawnSquad01()
end

------------------------------------------------------------------------------
function luaUSN06_JAPPTSpawn_Phase2()
	local nNumberOfSpawn = 10 - table.getn(Mission.JAPPTs)
	local nPos = GetPosition(Mission.ShipyardSpawnPoints[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_JAPPTSpawn_Phase2): Phase2 elott spawnolni valo PT-k szama = "..nNumberOfSpawn)
	if (nNumberOfSpawn > 0) then
		for i = 1, nNumberOfSpawn do
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 77,
						--TODO: szoveget lockitelni
						["Name"] = "Japanese PT", --TODO: a nevet lokalizalni
						["Crew"] = 2,
						["Race"] = JAPANESE,
					},
				},
				["area"] = {
					["refPos"] = nPos,
					["angleRange"] = { DEG(0),DEG(180)},
					["lookAt"] = GetPosition(Mission.LookatPointShipyard[1])
		
				},
				["callback"] = "luaUSN06_JAPPTSpawned_Phase2",
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
		luaUSN06_JAPPT_Teleport()
	end
end

------------------------------------------------------------------------------
function luaUSN06_JAPPTSpawned_Phase2(pEntity)
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	local nRnd = luaRnd(100, 999)
	local szPTName = "ingame.shipnames_gyoraitei|."..nRnd
	SetGuiName(pEntity, szPTName)
	pEntity.Area = 0
	table.insert(Mission.JAPPTs, pEntity)
	if (table.getn(Mission.JAPPTs) == 10) then
		luaUSN06_JAPPT_Teleport()
	end
end

------------------------------------------------------------------------------
function luaUSN06_FadeOut_Phase2_End()
	--phase1 takaritasa
	local DialogIDs = GetActDialogIDs()
	for i, nID in pairs (DialogIDs) do
		KillDialog(nID)
	end
	--SetSelectedUnit(Mission.USN_PT[1])
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	if (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
		Kill(Mission.USN_Sub[1], true)
		Mission.USN_Sub[1].Dead = true
	end
	if (Mission.JAP_ReconPlanes ~= nil) and (table.getn(Mission.JAP_ReconPlanes) > 0) and (not Mission.JAP_ReconPlanes[1].Dead) then
		Kill(Mission.JAP_ReconPlanes[1], true)
	end
	--luaDelay(luaUSN06_FadeInStart_Phase2, 4)
	luaUSN06_FadeInStart_Phase2()
end

------------------------------------------------------------------------------
function luaUSN06_FadeInStart_Phase2()
	PutFormationTo(Mission.USN_PT[1], GetPosition(Mission.USN_PT[1]), 3)
	--Blackout(true, "", 1.5, 0)
-- RELEASE_LOGOFF  	luaLog("#2 BlackOut")
	EnableMessages(false)
	luaUSN06_EM01B_Start()
	luaDelay(luaUSN06_DialogUSNPT, 5)
end

------------------------------------------------------------------------------
function luaUSN06_EM01B_Start()
	--BlackBars(true)
	--[[Mission.CamScript = luaCamIngameMovieAuto(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_PT[1], ["distance"] = 180, ["theta"] = 15, ["rho"] = 100, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_PT[1], ["distance"] = 30, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 10, ["smoothtime"] = 2},
		},
		luaUSN06_FadeInEnd_Phase2)
	]]--
	BlackBars(true)
	Mission.CamScript = luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_PT[1], ["distance"] = 180, ["theta"] = 15, ["rho"] = 100, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_PT[1], ["distance"] = 30, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 10, ["smoothtime"] = 2},
		},
		luaUSN06_FadeInEnd_Phase2,
		true)
end

------------------------------------------------------------------------------
function luaUSN06_FadeInEnd_Phase2()
	--[[SetSelectedUnit(Mission.USN_PT[1])
	Mission.USN_Sub = luaRemoveDeadsFromTable(Mission.USN_Sub)
	if (table.getn(Mission.USN_Sub) > 0) and (not Mission.USN_Sub[1].Dead) then
		Kill(Mission.USN_Sub[1], true)
		Mission.USN_Sub[1].Dead = true
	end]]--
	BlackBars(false)
	EnableInput(true)
	EnableMessages(true)
	SetSelectedUnit(Mission.USN_PT[1])
	--DisplayScores(1, 0, "usn06.score01", tostring(Mission.DockedConvoyShip))
	DisplayScores(2, 0, "usn06.score02", tostring(Mission.ConvoyShipDestroyed).."/"..tostring(Mission.MaxConvoyNum))
	Mission.FirstRun = true
	Mission.NeedAreaCheck = true
	Mission.MissionPhase = 3
end
------------------------------------------------------------------------------
function luaUSN06_ReconPlaneReachedEvacZone(pEntity)
	RemoveTrigger(pEntity, "ReconPlaneReachedEvacZone")
	PilotRetreat(Mission.JAP_ReconPlanes[1])
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("A ReconPlane evakualt")
	end
end

------------------------------------------------------------------------------
function luaUSN06_AreaCheck()
	local nNumOfPTs = table.getn(Mission.JAPPTs)
	local nPos
	local nPosX
	local nPosZ
	local nRnd
	if (Mission.NeedAreaCheck) then
		for i = 1, nNumOfPTs do
			if (Mission.JAPPTs ~= nil) and (Mission.JAPPTs[i].Area == 0) then --and (luaGetDistance(Mission.JAPPTs[i], Mission.Area[2]) > 2000) and (luaGetDistance(Mission.JAPPTs[i], Mission.Area[3]) > 2000) then
				nPosX = luaRnd(-800, 800)
				nPosZ = luaRnd(-800, 800)
-- RELEASE_LOGOFF  				luaLog("nPrevArea = "..Mission.nPrevArea)
				if (Mission.nPrevArea == 3) then
					nPos = GetPosition(Mission.Area[2])
					Mission.nPrevArea = 2
					Mission.JAPPTs[i].Area = 2
					if (Mission.Debug) then
-- RELEASE_LOGOFF  						luaLog(Mission.JAPPTs[i].Name.." megy a 2. area-ba")
					end
				else
					nPos = GetPosition(Mission.Area[3])
					Mission.JAPPTs[i].Area = 3
					Mission.nPrevArea = 3
					if (Mission.Debug) then
-- RELEASE_LOGOFF  						luaLog(Mission.JAPPTs[i].Name.." megy a 3. area-ba")
					end
				end
				nPos["x"] = nPos["x"] + nPosX
				nPos["z"] = nPos["z"] + nPosZ
				--NavigatorMoveToPos(Mission.JAPPTs[i], nPos)
				NavigatorMoveToRange(Mission.JAPPTs[i], nPos)
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_CheckMissionComplete()
		
	if (luaObj_IsActive("primary", 2) and luaObj_GetSuccess("primary", 2)) then
		--luaUSN06_EM03_Start()
		Mission.EndMission = true
		luaUSN06_EM03_MissionComplete()
		luaDelay(luaUSN06_Dialog_MissionComplete, 2)
	end
end

------------------------------------------------------------------------------
function luaUSN06_Dialog_MissionComplete()
	luaUSN06_StartDialog("Mission_Complete")
end

------------------------------------------------------------------------------
function luaUSN06_EM03_MissionComplete()
	luaUSN06_AllUnitHoldFire()
	Mission.CamTarget = GetSelectedUnit()
	if (Mission.CamTarget == nil) then
		Mission.CamTarget = Mission.USN_Squad[1]
	end
	Mission.CamScript = luaCamIngameMovieAuto(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.CamTarget, ["distance"] = 180, ["theta"] = 8, ["rho"] = 180, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.CamTarget, ["distance"] = 280, ["theta"] = 8, ["rho"] = 40, ["moveTime"] = 10, ["smoothtime"] = 2},
		},
		luaUSN06_MissionComplete,
		true)
		
	--[[Mission.CamScript = luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.CamTarget, ["distance"] = 180, ["theta"] = 8, ["rho"] = 180, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.CamTarget, ["distance"] = 280, ["theta"] = 8, ["rho"] = 40, ["moveTime"] = 10, ["smoothtime"] = 2},
		},
		luaUSN06_MissionComplete,
		true)]]--
end

------------------------------------------------------------------------------
function luaUSN06_AllUnitHoldFire()
	local tUSNUnits = luaGetOwnUnits("ship", PARTY_ALLIED)
	for i, tUnit in pairs (tUSNUnits) do
		UnitHoldFire(tUnit)
	end
end

------------------------------------------------------------------------------
--[[function luaUSN06_Patrol01()
	NavigatorMoveOnPath(Mission.JAP_Destroyer01[1], Mission.PatrolPath[1], PATH_FM_PINGPONG)
end]]--

------------------------------------------------------------------------------
function luaUSN06_CheckUSNPTsNum()
	if (not Mission.PTReinforcement) and (table.getn(Mission.USN_PT) < 3) and (luaObj_IsActive("primary", 1) ~= nil) and (luaObj_GetSuccess("primary", 1) == nil) then			-- ez csak biztonsagi ellenorzes
		--TODO: lecserelni hintre
		--MissionNarrative("Reinforcement PTs have arrived")
		luaUSN06_StartDialog("PT_Reinforcement_Arrived")
		Mission.PTReinforcement = true
		luaUSN06_USNPT_Spawning()
	end
end

------------------------------------------------------------------------------
function luaUSN06_USNPT_Spawning()
	local nShipName = ""
	local nSpawnPos = GetPosition(Mission.USN_SpawnPoints[1])
	local nLookAtPos = GetPosition(Mission.OtherPoints[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_USNPT_Spawning): meghivodtam")
	--[[AddListener("kill", "Listener_USNPT_Killed", 
	{
			["callback"] = "luaUSN06_USNPTWasDestroyed",
			["entity"] = Mission.USN_PT,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})]]--
	for i = 1, 6 do
		nShipName = "PT Boat '80 Elco 0"..i
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 27,
					["Name"] = nShipName,
					["Crew"] = 2,
					["Race"] = USN,
				},
			},
			["area"] = {
				["refPos"] = nSpawnPos,
				["angleRange"] = {-1,1},
				["lookAt"] = nLookAtPos
	
			},
			["callback"] = "luaUSN06_USNPT_Spawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 100,
				["enemyHorizontal"] = 5,
				["ownVertical"] = 100,
				["enemyVertical"] = 5,
				["formationHorizontal"] = 600,
			},
		})
	end
	--luaDelay(luaUSN06_FadeInStart_Phase2, 6)
end

------------------------------------------------------------------------------
function luaUSN06_USNPT_Spawned(pEntity)
	local nNumber = luaRnd(100, 999)
	SetGuiName(pEntity, "ingame.shipnames_pt|."..nNumber)
	table.insert(Mission.USN_PT, pEntity)
	table.insert(Mission.USN_Squad, pEntity)
	SetRoleAvailable(pEntity, EROLF_ALL, PLAYER_1)
	SetSkillLevel(pEntity, SKILL_MPNORMAL)
	if (table.getn(Mission.USN_PT) == 1) then
		--SetSelectedUnit(Mission.USN_PT[1])
		local nPutPos = GetPosition(Mission.USN_SpawnPoints[6])
		PutTo(Mission.USN_PT[1], nPutPos, 320)
		NavigatorMoveToRange(pEntity, Mission.OtherPoints[1])
		--[[if (table.getn(Mission.USN_Sub) > 0) then --(not Mission.USN_Sub[1].Dead) then
			Kill(Mission.USN_Sub[1], true)
		end]]--
	elseif (table.getn(Mission.USN_PT) > 1) then
		--JoinFormation(pEntity, Mission.USN_PT[1])
		if (table.getn(Mission.USN_PT) == 6) then
			if (IsListenerActive("kill", "Listener_USNPT_Killed")) then
				RemoveListener("kill", "Listener_USNPT_Killed")
			end
			AddListener("kill", "Listener_USNPT_Killed", 
			{
					["callback"] = "luaUSN06_USNPTWasDestroyed",
					["entity"] = Mission.USN_PT,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}
			})
			luaUSN06_USNPTs_Listener()	--ez a listener figyeli, hogy eszrevettek -e valamelyik USA PT-t
			for i = 2, table.getn(Mission.USN_PT) do
				JoinFormation(Mission.USN_PT[i], Mission.USN_PT[1])
			end
		end
	end
	EntityTurnToPosition(pEntity, GetPosition(Mission.OtherPoints[1]))
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("USN PT lekrealva: "..pEntity.Name)
	end
end

------------------------------------------------------------------------------
function luaUSN06_USNPTWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	if (table.getn(Mission.USN_PT) == 0) then
		if (Mission.PTReinforcement) then
-- RELEASE_LOGOFF  			luaLog("Az osszes USN PT megsemmisult az utanpotlasbol is")
			luaUSN06_StartDialog("PTs_Destroyed")
			if (IsListenerActive("kill", "Listener_USNPT_Killed")) then
				RemoveListener("kill", "Listener_USNPT_Killed")
			end
		else
-- RELEASE_LOGOFF  			luaLog("Az osszes USN PT megsemmisult, jon meg reinforcement")
		end
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_USNPTWasDestroyed): Egy USN PT megsemmisult: "..pEntity.Name)
	end
end

------------------------------------------------------------------------------
function luaUSN06_Hint_Cameralock()
	if (Mission.HintCameraLockTimer > 0) then
		Mission.HintCameraLockTimer = Mission.HintCameraLockTimer - 3
		if (Mission.HintCameraLockTimer < 0) then
			Mission.HintCameraLockTimer = 0
		end
	end
	local pUnit = GetSelectedUnit()
	if (pUnit ~= nil) and (luaGetType(pUnit) == "plane") then
		if (Mission.HintCameraLockTimer == 0) and (Mission.HintCameraLockCounter < 4) then
			ShowHint("Advanced_Hint_Cameralock")
			Mission.HintCameraLockTimer = 300
			Mission.HintCameraLockCounter = Mission.HintCameraLockCounter + 1
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_CheckUSNPlanesNumber()
	if  (luaObj_IsActive("primary", 1) ~= nil) and (luaObj_GetSuccess("primary", 1) == nil) then		-- ez csak biztonsagi ellenorzes
		local nWingCount = 0
		local nActWingCount
		local bNeedSpawn = false
		if (table.getn(Mission.USN_P38s) > 0) then
			for i, pPlane in pairs (Mission.USN_P38s) do
				nActWingCount = luaGetSquadronPlaneNum(pPlane) --GetProperty(pPlane, "WingCount")
				if (nActWingCount ~= nil) then
					nWingCount = nWingCount + nActWingCount
-- RELEASE_LOGOFF  					luaLog("PlaneName = "..pPlane.Name..", WingCount = "..nActWingCount)
				else
-- RELEASE_LOGOFF  					luaLog("nActWingCount = nil")
				end
			end
		else
			bNeedSpawn = true
		end
		if (nWingCount < 3) then
			bNeedSpawn = true
		end
		if (bNeedSpawn) then
			luaUSN06_P38Spawning(true)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_BonusUnitSpawning()
	--if (Scoring_IsUnlocked("US04_SILVER")) or (Scoring_IsUnlocked("US04_GOLD")) then
		local nSpawnPos = GetPosition(Mission.USN_SpawnPoints[2])
		local nLookAtPos = GetPosition(Mission.OtherPoints[1])
		local nClassID = 118
	
		local szName = "B-25 Mitchell"
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = nClassID,
				--TODO: szoveget lockitelni
				["Name"] = szName,
				["Crew"] = 1,
				["Race"] = USN,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = nSpawnPos,
			["angleRange"] = { 1, -1},
			["lookAt"] = nLookAtPos,
		},
		["callback"] = "luaUSN06_BonusUnitSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100
		},
		})
	--end
end

------------------------------------------------------------------------------
function luaUSN06_BonusUnitSpawned(pEntity)
	table.insert(Mission.USN_BonusUnit, pEntity)
	SetRoleAvailable(pEntity, EROLF_ALL, PLAYER_1)
	local nTargetPos = GetPosition (Mission.OtherPoints[1])
	nRndX = luaRnd(-50, 50)
	nRndZ = luaRnd(-50, 50)
	nTargetPos["x"] = nTargetPos["x"] + nRndX
	nTargetPos["z"] = nTargetPos["z"] + nRndZ
	SquadronSetTravelAlt(pEntity, 200)
	--SquadronSetAttackAlt(pEntity, 50)
	PilotMoveTo(pEntity, nTargetPos)
end

------------------------------------------------------------------------------
function luaUSN06_P38Spawning(bReinforcement)
	--TODO: szoveget lokalizalni
	if (bReinforcement ~= nil) then
		--TODO: lecserelni majd Hintre
		--MissionNarrative(Mission.Narratives[9])
		ShowHint("USN06_Hint_Plane_Reinforcement")
	end
	local szPlaneName = ""
	local szPlaneNumber = ""
	local nSpawnPos = GetPosition(Mission.USN_SpawnPoints[2])
	local nLookAtPos = GetPosition(Mission.OtherPoints[1])
	local nClassID
	--[[AddListener("kill", "Listener_P38_Killed", 
	{
			["callback"] = "luaUSN06_P38WasDestroyed",
			["entity"] = Mission.USN_P38s,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})]]--
	--if (Mission.UnlockLvl ~= nil) and (Mission.UnlockLvl > 2) then
	nClassID = 135
	--TODO: szoveget lokalizalni
	szPlaneName = "P40 Warhawk0"
	--for i = 1, 2 do  --> ideiglenesen csak 1 p38-asat spawnolok, 
		local szName = szPlaneName--..i
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = nClassID,
				--TODO: szoveget lockitelni
				["Name"] = szName,
				["Crew"] = 1,
				["Race"] = USN,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},
		},
		["area"] = {
			["refPos"] = nSpawnPos,
			["angleRange"] = { 1, -1},
			["lookAt"] = nLookAtPos,
		},
		["callback"] = "luaUSN06_P38Spawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 100
		},
		})
	--end
end

------------------------------------------------------------------------------
function luaUSN06_P38Spawned(pEntity)
	table.insert(Mission.USN_P38s, pEntity)
	SetRoleAvailable(pEntity, EROLF_ALL, PLAYER_1)
	local nTargetPos = GetPosition (Mission.OtherPoints[1])
	local nRndX = luaRnd(-50, 50)
	local nRndZ = luaRnd(-50, 50)
	nTargetPos["x"] = nTargetPos["x"] + nRndX
	nTargetPos["z"] = nTargetPos["z"] + nRndZ
	SquadronSetTravelAlt(pEntity, 50)
	SquadronSetAttackAlt(pEntity, 50)
	PilotMoveTo(pEntity, nTargetPos)
	--if (table.getn(Mission.USN_P38s) == 2) then
		if (IsListenerActive("kill", "Listener_P38_Killed")) then
			RemoveListener("kill", "Listener_P38_Killed")
		end
		AddListener("kill", "Listener_P38_Killed", 
		{
				["callback"] = "luaUSN06_P38WasDestroyed",
				["entity"] = Mission.USN_P38s,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	--end
end

------------------------------------------------------------------------------
function luaUSN06_P38WasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.USN_P38s = luaRemoveDeadsFromTable(Mission.USN_P38s)
	if (table.getn(Mission.USN_P38s) == 0) then
-- RELEASE_LOGOFF  		luaLog("Az osszes P38-as megsemmisult")
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_P38WasDestroyed): Egy P38-as megsemmisult: "..pEntity.Name)
	end
end

------------------------------------------------------------------------------
function luaUSN06_JAPPT_Teleport()
	for i = 1, table.getn(Mission.JAPPTs) do
		if (not Mission.JAPPTs[i].Dead) and (Mission.JAPPTs[i].Area == 0) then
			NavigatorStop(Mission.JAPPTs[i])
			local tDirection = GetPosition(Mission.USN_SpawnPoints[2])
			if (Mission.nPrevArea == 2) then
				local tPosition = GetPosition(Mission.Area[3])
-- RELEASE_LOGOFF  				luaLog("valtoztatas elott")
-- RELEASE_LOGOFF  				luaLog(tPosition["x"]..", "..tPosition["z"])
				nRndX = luaRnd(-800, 800)
				nRndZ = luaRnd(-800, 800)
				tPosition["x"] = tPosition["x"] + nRndX
				tPosition["z"] = tPosition["z"] + nRndZ
				tPosition["y"] = 1
				--[[luaLog("valtoztatas utan")
-- RELEASE_LOGOFF  				luaLog(tPosition["x"]..", "..tPosition["z"])
-- RELEASE_LOGOFF  				luaLog(Mission.JAPPTs[i].Name)]]--
				PutTo(Mission.JAPPTs[i], tPosition, 270)--, tDirection)
				Mission.JAPPTs[i].Area = 3
				Mission.nPrevArea = 3
			elseif (Mission.nPrevArea == 3) then
				local tPosition = GetPosition(Mission.Area[2])
-- RELEASE_LOGOFF  				luaLog("valtoztatas elott")
-- RELEASE_LOGOFF  				luaLog(tPosition["x"]..", "..tPosition["z"])
				nRndX = luaRnd(-800, 800)
				nRndZ = luaRnd(-800, 800)
				tPosition["x"] = tPosition["x"] + nRndX
				tPosition["z"] = tPosition["z"] + nRndZ
				tPosition["y"] = 1
				--[[luaLog("valtoztatas utan")
-- RELEASE_LOGOFF  				luaLog(tPosition["x"]..", "..tPosition["z"])
-- RELEASE_LOGOFF  				luaLog(Mission.JAPPTs[i].Name)]]--
				PutTo(Mission.JAPPTs[i], tPosition, 250)--, tDirection)
				Mission.JAPPTs[i].Area = 2
				Mission.nPrevArea = 2
			end
			local nMaxSpeed = Mission.DefaultPTSpeed
			SetShipMaxSpeed(Mission.JAPPTs[i], nMaxSpeed)
		end
	end
end
------------------------------------------------------------------------------
function luaUSN06_DialogUSNPT()
	luaUSN06_StartDialog("USNPT_Arrived")
end

------------------------------------------------------------------------------
function luaUSN06_HintEscort()
	ShowHint("USN06_Hint_Escort")
end

------------------------------------------------------------------------------
function luaUSN06_JAPPts_Listener()
	AddListener("kill", "Listener_JAPPT_Killed", 
	{
			["callback"] = "luaUSN06_JAPPTWasDestroyed",
			["entity"] = Mission.JAPPTs,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

------------------------------------------------------------------------------
function luaUSN06_JAPPTWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	if (Mission.Debug) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_JAPPts_Listener): Megsemmisult egy japan PT")
		if (table.getn(Mission.JAPPTs) == 0) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_JAPPts_Listener): Az osszes JapPT megsemmisult")
			Mission.NeedAreaCheck = false
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_JAPPTs_Attack()
	local pTarget
	local nDistance
	local pNewTarget = nil
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	if ((Mission.PTsDetected_Phase3) and (table.getn(Mission.JAPPTs) ~= 0)) then
		for i = 1, table.getn(Mission.JAPPTs) do
			if (not Mission.JAPPTs[i].Dead) then
				pTarget = luaGetScriptTarget(Mission.JAPPTs[i])
				if (pTarget == nil) or (pTarget.Dead) then
					nDistance = 999999
					pNewTarget = nil
					for j = 1, table.getn(Mission.USN_PT) do
						nTempDistance = luaGetDistance(Mission.JAPPTs[i], Mission.USN_PT[j])
						if (nTempDistance < nDistance) then
							nDistance = nTempDistance
							pNewTarget = Mission.USN_PT[j]
						end
					end
					if (pNewTarget ~= nil) then
						NavigatorStop(Mission.JAPPTs[i])
						luaSetScriptTarget(Mission.JAPPTs[i], pNewTarget)
						NavigatorAttackMove(Mission.JAPPTs[i], pNewTarget, {})
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_USNPTs_Listener()
-- RELEASE_LOGOFF  	luaLog("Az USA PT-k figyelesenek listener-et beregisztraltam")
	AddListener("recon", "Listener_USNPTs", {
		["callback"] = "luaUSN06_USNPTsWasSpotted",  -- callback fuggveny
		["entity"] = Mission.USN_PT, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

------------------------------------------------------------------------------
function luaUSN06_USNPTsWasSpotted()
-- RELEASE_LOGOFF  	luaLog("Az USA PT-ket eszrevettek")
	RemoveListener("recon", "Listener_USNPTs")
	Mission.PTsDetected_Phase3 = true
end

------------------------------------------------------------------------------
function luaUSN06_CruiserAttack_Phase3()
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	if (table.getn(Mission.USN_PT) ~= 0) then
		for i, pUnit in pairs (Mission.JAP_Squad01) do
			local nMinDistance = 9999999
			local pTarget = nil
			for i = 1, table.getn(Mission.USN_PT) do
				nDistance = luaGetDistance(pUnit, Mission.USN_PT[i])
				if (nDistance < nMinDistance) then
					nMinDistance = nDistance
					pTarget = Mission.USN_PT[i]
				end
			end
			if (pTarget ~= nil) then
				luaSetScriptTarget(pUnit, pTarget)
				NavigatorAttackMove(pUnit, pTarget, {})
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN_EM02()
	if (not Mission.EngineMovie02) then
		Mission.EngineMovie02 = true
		luaJumpinMovieSetCurrentMovie("GoAround",Mission.JAP_Squad01[1].ID)
	end
end

------------------------------------------------------------------------------
function luaUSN06_DialogBattleshipOnTheWay()
	luaUSN06_StartDialog("USN_BattleshipOnWay")
end

------------------------------------------------------------------------------
function luaUSN06_FadeInStart_Phase3()
	Blackout(true, "luaUSN06_SaveCheckpoint", 3, 1)
	--luaDelay(luaUSN06_FadeInEnd_Phase3, 6)
	--azert most bontom fel a formaciot, mert a fadeout utan a PutTo-val egy frame-ben beszol
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
-- RELEASE_LOGOFF  	luaLog("DEBUG: luaUSN06_FadeInStart_Phase3()")
	for i, pUnit in pairs (Mission.USN_PT) do
		DisbandFormation(pUnit)
	end
-- RELEASE_LOGOFF  	luaLog("DEBUG: luaUSN06_FadeInStart_Phase3() end")
end

------------------------------------------------------------------------------
function luaUSN06_SaveCheckpoint()
	--luaCheckpoint(1, nil)
	luaUSN06_Preparing_Phase3()
end

------------------------------------------------------------------------------
function luaUSN06_Preparing_Phase3()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_Preparing_Phase3): CHECKPOINT ELMENTVE")
	--luaLog("DEBUG: luaUSN06_Preparing_Phase3() #1")
	if (IsListenerActive("kill", "Listener_USNPT_Killed")) then
		RemoveListener("kill", "Listener_USNPT_Killed")
	end
	local nRndX
	local nRndY
	local nSpawnPos
	local nSpawnPos
	--TODO: Torlendo
	-- a megmaradt USA PT-k teleportalasa a startpos-ra
	--[[Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	for i, pUnit in pairs (Mission.USN_PT) do
		if (not pUnit.Dead) then
			nSpawnPos = GetPosition(Mission.USN_SpawnPoints[4])
			nRndX = luaRnd(-300, 300)
			nRndZ = luaRnd(-300, 300)
			nSpawnPos["x"] = nSpawnPos["x"] + nRndX
			nSpawnPos["z"] = nSpawnPos["z"] + nRndZ
			nSpawnPos["y"] = 1
			PutTo(pUnit, nSpawnPos)
			--luaLog(nSpawnPos["x"]..", "..nSpawnPos["z"]..", "..nSpawnPos["y"])
			--Kill(pUnit, true)
		end
	end]]--
	-- formacioba rakas
	--[[if (table.getn(Mission.USN_PT) > 1) then
		for i = 2, table.getn(Mission.USN_PT) do
			JoinFormation(Mission.USN_PT[i], Mission.USN_PT[1])
		end
		NavigatorMoveToRange(Mission.USN_PT[1], Mission.Area[3])
	end
-- RELEASE_LOGOFF  	luaLog("DEBUG: luaUSN06_Preparing_Phase3() #2")]]--
	-- a megmaradt USA P38-asok kikillezese
	--[[Mission.USN_P38s = luaRemoveDeadsFromTable(Mission.USN_P38s)
	for i, pUnit in pairs (Mission.USN_P38s) do
		if (not pUnit.Dead) then
			--Kill(pUnit, true)
			nSpawnPos = GetPosition(Mission.USN_SpawnPoints[5])
			nRndX = luaRnd(-300, 300)
			nRndZ = luaRnd(-300, 300)
			nSpawnPos["x"] = nSpawnPos["x"] + nRndX
			nSpawnPos["z"] = nSpawnPos["z"] + nRndZ
			PutTo(pUnit, nSpawnPos)
		end
	end
	local nTargetPos
	if (table.getn(Mission.USN_P38s) > 0) then
		for i, pUnit in pairs (Mission.USN_P38s) do
			nTargetPos = GetPosition (Mission.Area[3])
			nRndX = luaRnd(-50, 50)
			nRndZ = luaRnd(-50, 50)
			nTargetPos["x"] = nTargetPos["x"] + nRndX
			nTargetPos["z"] = nTargetPos["z"] + nRndZ
			PilotMoveTo(pUnit, nTargetPos)
		end
	end
-- RELEASE_LOGOFF  	luaLog("DEBUG: luaUSN06_Preparing_Phase3() #3")]]--
	-- a megmaradt USN PT-k kikillezes
	for i, pUnit in pairs (Mission.USN_PT) do
		Kill(pUnit, true)
		pUnit.Dead = true
	end
	Mission.USN_PT = luaRemoveDeadsFromTable(Mission.USN_PT)
	-- a megmaradt p38-asok/p40-esek kikillezese
	for i, pUnit in pairs (Mission.USN_P38s) do
		Kill(pUnit, true)
		pUnit.Dead = true
	end
	Mission.USN_P38s = luaRemoveDeadsFromTable(Mission.USN_P38s)
	-- a megmaradt BonusUnitok kikillezese
	for i, pUnit in pairs (Mission.USN_BonusUnit) do
		Kill(pUnit, true)
		pUnit.Dead = true
	end
	Mission.USN_BonusUnit = luaRemoveDeadsFromTable(Mission.USN_BonusUnit)
	-- a megmaradt transport hajok kikillezese
	for i, pUnit in pairs (Mission.Convoy) do
		Kill(pUnit, true)
		pUnit.Dead = true
	end
	Mission.Convoy = luaRemoveDeadsFromTable(Mission.Convoy)
	-- a megmaradt japo PT-k kikillezese
	for i, pUnit in pairs (Mission.JAPPTs) do
		if (not pUnit.Dead) then
			Kill(pUnit, true)
		end
	end
	Mission.JAPPTs = luaRemoveDeadsFromTable(Mission.JAPPTs)
	-- a megamaradt transport kisero hajok kikillezese
	for i, pUnit in pairs (Mission.JAP_EscortGroup) do
		if (not pUnit.Dead) then
			Kill(pUnit, true)
		end
	end
	Mission.JAP_EscortGroup = luaRemoveDeadsFromTable(Mission.JAP_EscortGroup)
	--uj egysegek lekrealasa
	--TODO: DEL
	--luaUSN06_PlayerSquads()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_Preparing_Phase3): felkeszules a 4-es fazisra")
	--[[if (Scoring_IsUnlocked("USN_04_SILVER")) then
		luaUSN06_UnlockLevelBomber()
	end]]--
	luaUSN06_InitPlayerUnits_Phase4()
end

------------------------------------------------------------------------------
function luaUSN06_InitPlayerUnits_Phase4()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitPlayerUnits_Phase4): Na most kezdem a player unitok generalasat")
	local tUnit
	local pUnit
	Mission.USN_Squad = {}
	tUnit = luaFindHidden("South Dakota Class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_south_dakota")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	SetCatapultStock(pUnit, 0)
	table.insert(Mission.USN_SouthDakota, pUnit)
	table.insert(Mission.USN_Squad, pUnit)
	--SetRoleAvailable(Mission.USN_Washington[1], EROLF_ALL, PLAYER_AI)
	--[[for i = 3, table.getn(Mission.USN_Squad) do 		-- azert 3-tol kezdodik, mert az elso a South Dakota, a 2. a Washington, es az azutaniak allnak csak formacioba a washingtonnal
		JoinFormation(Mission.USN_Squad[i], Mission.USN_Washington[1])
		SetRoleAvailable(Mission.USN_Squad[i], EROLF_ALL, PLAYER_AI)
	end]]--
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitPlayerUnits_Phase4): Player unitok legeneralva")
	luaDelay(luaUSN06_InitJapanUnits_Phase4, 1)
end

------------------------------------------------------------------------------
function luaUSN06_InitJapanUnits_Phase4()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitJapanUnits_Phase4): Kezdodik a japo squad01 generalasa")
	local tUnit
	local pUnit
	-- Squad01
	tUnit = luaFindHidden("Fubuki-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_shirayuki")
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 1) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 2) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	table.insert(Mission.JAP_Squad01, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	
	tUnit = luaFindHidden("Fubuki-class 03")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_hatsuyuki")
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	table.insert(Mission.JAP_Squad01, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	
	tUnit = luaFindHidden("Fubuki-class 04")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_teruzuki")
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 1) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 2) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	table.insert(Mission.JAP_Squad01, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	
	tUnit = luaFindHidden("Fubuki-class 05")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_asagumo")
	TorpedoEnable(pUnit, true)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
	end
	table.insert(Mission.JAP_Squad01, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	
	tUnit = luaFindHidden("Takao-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_takao")
	table.insert(Mission.JAP_Squad01, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
	end
	
	
	for i, pUnit in pairs (Mission.JAP_Squad01) do
		UnitFreeAttack(pUnit)
		luaSetScriptTarget(pUnit, Mission.USN_SouthDakota[1])
		NavigatorAttackMove(pUnit, Mission.USN_SouthDakota[1], {})
	end
	
	-- Squad02
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitJapanUnits_Phase4): Kezdodik a japo squad02 generalasa")
	tUnit = luaFindHidden("Kongo-class Battleship 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_kirishima")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	table.insert(Mission.JAP_Kirishima, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
	end
	
	tUnit = luaFindHidden("Takao-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_atago")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
	end
	
	tUnit = luaFindHidden("Akizuki-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_inazuma")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	
	tUnit = luaFindHidden("Akizuki-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_ayanami")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 1) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 2) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	
	tUnit = luaFindHidden("Fubuki-class 06")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_shikinami")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	else
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	
	tUnit = luaFindHidden("Fubuki-class 07")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_samidare")
	table.insert(Mission.JAP_Squad02, pUnit)
	table.insert(Mission.JAP_Units, pUnit)
	if (Mission.difficulty == 0) then
		SetSkillLevel(pUnit, SKILL_SPNORMAL)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 1) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, false)
	elseif (Mission.difficulty == 2) then
		SetSkillLevel(pUnit, SKILL_SPVETERAN)
		TorpedoEnable(pUnit, true)
	end
	
	for i, pUnit in pairs (Mission.JAP_Squad02) do
		UnitFreeAttack(pUnit)
		TorpedoEnable(pUnit, true)
	end
	for i = 2, table.getn(Mission.JAP_Squad02) do
		JoinFormation(Mission.JAP_Squad02[i], Mission.JAP_Squad02[1])
	end
	luaSetScriptTarget(Mission.JAP_Squad02[1], Mission.USN_SouthDakota[1])
	NavigatorAttackMove(Mission.JAP_Squad02[1], Mission.USN_SouthDakota[1], {})
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitJapanUnits_Phase4): Generalasok keszen vannak")
	luaUSN06_FadeInEnd_Phase3()
end

------------------------------------------------------------------------------

function luaUSN06_FadeInEnd_Phase3()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_FadeInEnd_Phase3): Blackout hivodik")
	Blackout(true, "", 2, 0)
	luaUSN06_BlackOutEnd_Phase3()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_FadeInEnd_Phase3): Blackout meghivva")
end

------------------------------------------------------------------------------
function luaUSN06_TeleportSquad01()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_TeleportSquad01) indul")
	local tTeleportPos --= GetPosition(Mission.JAP_SpawnPoints[3])
	--luaLog("(luaUSN06_TeleportSquad01): TeleportPos = "..tTeleportPos["x"]..", "..tTeleportPos["y"]..", "..tTeleportPos["z"])
	Mission.JAP_Squad01 = luaRemoveDeadsFromTable(Mission.JAP_Squad01)
	for i, pUnit in pairs (Mission.JAP_Squad01) do
		tTeleportPos = GetPosition(Mission.JAP_SpawnPoints[3])
		local nRndX = luaRnd(-400, 400)
		local nRndZ = luaRnd(-400, 400)
		tTeleportPos["x"] = tTeleportPos["x"] + nRndX
		tTeleportPos["z"] = tTeleportPos["z"] + nRndZ
		tTeleportPos["y"] = 1
		PutTo(pUnit, tTeleportPos, 340)
		TorpedoEnable(pUnit, false)
		local pTarget = nil
		local nMinDistance = 999999
		for j, pPlayerUnit in pairs (Mission.USN_NorthSquad) do
			nTempDistance = luaGetDistance(pUnit, pPlayerUnit)
			if (nTempDistance < nMinDistance) then
				pTarget = pPlayerUnit
				nMinDistance = nTempDistance
			end
		end
		if (pTarget ~= nil) then
			luaSetScriptTarget(pUnit, pTarget)
			NavigatorAttackMove(pUnit, pTarget, {})
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_BlackOutEnd_Phase3()
	--EM02--
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_SouthDakota[1], ["distance"] = 500, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_SouthDakota[1], ["distance"] = 180, ["theta"] = 12, ["rho"] = 180, ["moveTime"] = 6, ["smoothtime"] = 2},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USN_SouthDakota[1], ["distance"] = 180, ["theta"] = 14, ["rho"] = 180, ["moveTime"] = 3, ["smoothtime"] = 2},
		},
		luaUSN06_StartingPhase4,
		true)
		
	luaDelay(luaUSN06_DialogSouthDakota,1)
		--luaUSN06_StartingPhase4()
end

------------------------------------------------------------------------------
function luaUSN06_StartingPhase4()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_BlackOutEnd_Phase3): FadeIn utan, ojjektiv hozzaadas")
	BlackBars(false)
	EnableMessages(true)
	EnableInput(true)
	SetSelectedUnit(Mission.USN_SouthDakota[1])
	local tTempTable = {}
	for i, pUnit in pairs (Mission.JAP_Squad01) do
		table.insert(tTempTable, pUnit)
	end
	for i, pUnit in pairs (Mission.JAP_Squad02) do
		table.insert(tTempTable, pUnit)
	end
	luaDelay(luaUSN06_InitPri02, 2)
	luaUSN06_KirishimaListener()
	Mission.FirstRun = true
	Mission.MissionPhase = 4
end

------------------------------------------------------------------------------
function luaUSN06_InitPri02()
	local tTempTable = {}
	for i, pUnit in pairs (Mission.JAP_Squad01) do
		table.insert(tTempTable, pUnit)
	end
	for i, pUnit in pairs (Mission.JAP_Squad02) do
		table.insert(tTempTable, pUnit)
	end
	luaObj_Add("primary", 2, tTempTable)
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitPri02): Primary 02 obejctive has added")
	--DisplayUnitHP(Mission.JAP_Units, "usn06.obj_p2")
	Mission.MaxJapShips = table.getn(Mission.JAP_Units)
	Mission.AliveJapShips = table.getn(Mission.JAP_Units)
	DisplayScores(1, 0, "usn06.obj_p2", "usn06.score03")
	--luaDelay(luaUSN06_DialogBattleshipsArrived, 6)
	luaDelay(luaUSN06_DialogWashington, 420)
	AddListener("hpEvent", "DakotaHPlistenerID", { 
		["callback"] = "luaUSN06_DialogWashington",  -- callback fuggveny
		["entity"] = Mission.USN_SouthDakota, -- entityk akiken a listener aktiv
		["reason"] = {"damage"}, -- "damage"/"repair"
		["hp"] = 0.5, -- ennek a hp erteknek az atlepeset vizsgalja
	})
end

------------------------------------------------------------------------------
function luaUSN06_KirishimaListener()
	if (not IsListenerActive("recon", "Listener_KirishimaSpotted")) then
		AddListener("recon", "Listener_KirishimaSpotted", {
		["callback"] = "luaUSN06_KirishimaSpotted",  -- callback fuggveny
		["entity"] = Mission.JAP_Kirishima, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
	end
end

------------------------------------------------------------------------------
function luaUSN06_KirishimaSpotted()
	if (IsListenerActive("recon", "Listener_KirishimaSpotted")) then
		RemoveListener("recon", "Listener_KirishimaSpotted")
	end
	luaUSN06_StartDialog("Kirishima_Detected")
end

------------------------------------------------------------------------------
function luaUSN06_DialogSouthDakota()
	luaUSN06_StartDialog("South_Dakota_Under_Fire")
end

------------------------------------------------------------------------------
function luaUSN06_DialogWashington()
	if IsListenerActive("hpEvent", "DakotaHPlistenerID") then
-- RELEASE_LOGOFF  		luaLog("(luaUSN06_DialogWashington): HpListener ha")
		RemoveListener("hpEvent", "DakotaHPlistenerID")
	end
	if Mission.WashingtonSpawned then	-- already has been called
		return
	end
	Mission.WashingtonSpawned = true
	luaDelay(luaUSN06_DialogWashington_hack, 0.5)	
end
function luaUSN06_DialogWashington_hack()
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_DialogWashington): A fv. kezdodik")
	
	tUnit = luaFindHidden("South Dakota Class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_washington")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	SetCatapultStock(pUnit, 0)
	table.insert(Mission.USN_Washington, pUnit)
	table.insert(Mission.USN_Squad, pUnit)
	SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	tUnit = luaFindHidden("Fletcher-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_walke")
	table.insert(Mission.USN_Squad, pUnit)
	SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	JoinFormation(pUnit, Mission.USN_Washington[1])
	tUnit = luaFindHidden("Fletcher-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_preston")
	table.insert(Mission.USN_Squad, pUnit)
	SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	JoinFormation(pUnit, Mission.USN_Washington[1])
	tUnit = luaFindHidden("Fletcher-class 03")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_benham")
	table.insert(Mission.USN_Squad, pUnit)
	SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	JoinFormation(pUnit, Mission.USN_Washington[1])
	tUnit = luaFindHidden("Fletcher-class 04")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_gwin")
	table.insert(Mission.USN_Squad, pUnit)
	SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	JoinFormation(pUnit, Mission.USN_Washington[1])
	
	Mission.USN_Squad = luaRemoveDeadsFromTable(Mission.USN_Squad)
	for i, pUnit in pairs (Mission.USN_Squad) do
		local nClassID = VehicleClass[pUnit.Class.ID]
		if (nClassID ~= 487) then
			SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_1)
		end
		SetForcedReconLevel(pUnit, 2, PARTY_JAPANESE)
	end
	
	local japo = luaGetOwnUnits("ship", PARTY_JAPANESE)
	if table.getn(japo) > 0 then
		local target = luaGetNearestUnitFromTable(Mission.USN_Washington[1], japo)
		if target then
			NavigatorAttackMove(Mission.USN_Washington[1], target)
		end
	end
	
	luaDelay(luaUSN06_InitSec02, 10)
	
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_DialogWashington): Role allitas vege")
	luaUSN06_StartDialog("Washington_Reporting")
	luaDelay(luaUSN06_HintWashington, 6)
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_DialogWashington): Dialogus addolva")
	luaUSN06_Listener_PlayerSquad_Init()
end

------------------------------------------------------------------------------
function luaUSN06_HintWashington()
	ShowHint("USN06_Hint_Washington")
	luaDelay(luaUSN06_ShipPowerUp, 5)
	luaDelay(luaUSN06_HintTorpedo, 10)
end

------------------------------------------------------------------------------
function luaUSN06_ShipPowerUp()
	
	AddPowerup(
	{
		["classID"] = "improved_shells",
		["useLimit"] = 1,
	})
	--[[
	if (Scoring_IsUnlocked("US04_SILVER")) then
		AddPowerup(
		{
			["classID"] = "automatic_reloader",
			["useLimit"] = 1,
		})
	end
	--MissionNarrative("missionglobals.newpowerup")
	]]
end

------------------------------------------------------------------------------
function luaUSN06_InitSec02()
	local tTempTable = {}
	tTempTable[1] = Mission.USN_SouthDakota[1]
	tTempTable[2] = Mission.USN_Washington[1]
	luaObj_Add("secondary", 2, tTempTable)
-- RELEASE_LOGOFF  	luaLog("(luaUSN06_InitSec02): Secondary 01 objective has added")
	if (not IsListenerActive("kill", "Listener_BBDestroyed")) then
		AddListener("kill", "Listener_BBDestroyed", 
		{
			["callback"] = "luaUSN06_BBDestroyed",
			["entity"] = tTempTable,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN06_BBDestroyed()
	if (IsListenerActive("kill", "Listener_BBDestroyed")) then
		RemoveListener("kill", "Listener_BBDestroyed")
	end
	luaObj_Failed("secondary", 2)
	MissionNarrative("usn06.obj_s2_fail")
end

------------------------------------------------------------------------------
function luaUSN06_DialogBattleshipsArrived()
	luaUSN06_StartDialog("USN_Battleships_Arrived")
	luaDelay(luaUSN06_DialogWarshipsAhead, 7)
end

------------------------------------------------------------------------------
function luaUSN06_DialogWarshipsAhead()
	luaUSN06_StartDialog("JAP_Warships")
	luaDelay(luaUSN06_HintTorpedo, 5)
end

------------------------------------------------------------------------------
function luaUSN06_HintTorpedo()
	ShowHint("USN06_Hint_Torpedo")
	--luaDelay(luaUSN06_DialogJAPSquadSouth, 10)
end

------------------------------------------------------------------------------
function luaUSN06_Listener_PlayerSquad_Init()
	if (not IsListenerActive("kill", "Listener_PlayerSquad")) then
		AddListener("kill", "Listener_PlayerSquad", 
		{
				["callback"] = "luaUSN06_PlayerSquad_UnitDestroyed",
				["entity"] = Mission.USN_Squad,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN06_PlayerSquad_UnitDestroyed(pEntity)
	pEntity.Dead = true
	Mission.USN_Squad = luaRemoveDeadsFromTable(Mission.USN_Squad)
	if (table.getn(Mission.USN_Squad) == 0) then
		if (IsListenerActive("kill", "Listener_PlayerSquad")) then
			RemoveListener("kill", "Listener_PlayerSquad")
		end
		luaObj_Failed("primary", 2)
		luaUSN06_MissionFailed(pEntity, "usn06.obj_p2_fail")
	end
end

------------------------------------------------------------------------------
function luaUSN06_MissionFailed(pEntity, szMessage)
	if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		luaObj_Failed("primary", 1)
	end
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		luaObj_Failed("primary", 2)
	end
	if (luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) == nil) then
		luaObj_Failed("primary", 3)
	end
	if (luaObj_IsActive("secondary", 2)) and (luaObj_GetSuccess("secondary", 2) == nil) then
		luaObj_Failed("secondary", 2)
	end
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1)
	end
	--[[if (luaObj_IsActive("secondary", 3)) and (luaObj_GetSuccess("secondary", 3) == nil) then
		luaObj_Failed("secondary", 3)
	end]]--
	luaMissionFailedNew(pEntity, szMessage) --"All player unit have died") --MissionNarrative(Mission.Narratives[6]))
	Mission.EndMission = true
end

------------------------------------------------------------------------------
function luaUSN06_AttackManager(tAttackers, tTargets)
	if (table.getn(tAttackers) == 0) or (table.getn(tTargets) == 0) then
		return
	end
	local nMaxChaseDistance = 3000
	tAttackers = luaRemoveDeadsFromTable(tAttackers)
	tTargets = luaRemoveDeadsFromTable(tTargets)
	for i, pAttacker in pairs (tAttackers) do
		local nMinDistance = 999999
		local pTarget = nil
		local pTempTarget = luaGetScriptTarget(pAttacker)
		if (pTempTarget ~= nil) and (not pTempTarget.Dead) then
			local nTargetDistance = luaGetDistance(pAttacker, pTempTarget)
			nMinDistance = nTargetDistance
			pTarget = pTempTarget
		end
		if (pTarget == nil) or (nMinDistance > nMaxChaseDistance) then
			for j, pUnit in pairs (tTargets) do
				nTempDistance = luaGetDistance(pAttacker, pUnit)
				if (nTempDistance < nMinDistance) then
					nMinDistance = nTempDistance
					pTarget = pUnit
				end
			end
			luaSetScriptTarget(pAttacker, pTarget)
			NavigatorAttackMove(pAttacker, pTarget, {})
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_Squad02ShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Squad02 = luaRemoveDeadsFromTable(Mission.JAP_Squad02)
end

------------------------------------------------------------------------------
function luaUSN06_Squad01ShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Squad01 = luaRemoveDeadsFromTable(Mission.JAP_Squad01)
end

------------------------------------------------------------------------------
function luaUSN06_Listener_JapUnits()
	if (not IsListenerActive("kill", "Listener_JapShipWasKilled")) then
		AddListener("kill", "Listener_JapShipWasKilled", 
		{
				["callback"] = "luaUSN06_JapaneseShipWasDestroyed",
				["entity"] = Mission.JAP_Units,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN06_JapaneseShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_Units = luaRemoveDeadsFromTable(Mission.JAP_Units)
	Mission.AliveJapShips = table.getn(Mission.JAP_Units)
	DisplayScores(1, 0, "usn06.obj_p2", "usn06.score03")
	if (table.getn(Mission.JAP_Units) == 0) then
		if (IsListenerActive("kill", "Listener_JapShipWasKilled")) then
			RemoveListener("kill", "Listener_JapShipWasKilled")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_CheckPri02()
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		if (table.getn(Mission.JAP_Units) == 0) then
			luaObj_Completed("primary", 2)
			HideScoreDisplay(1, 0)
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_CheckPri02): Primary 02 objective has completed")
		elseif (table.getn(Mission.USN_Squad) == 0) then
			luaObj_Failed("primary", 2)
			HideScoreDisplay(1, 0)
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_CheckPri02): Primary 02 objective has failed")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_Pri02Reminder()
	luaObj_AddReminder("primary", 2)
end

------------------------------------------------------------------------------
function luaUSN06_Hidden01_Init()
	luaObj_Add("hidden", 1)
-- RELEASE_LOGOFF  	luaLog("Hidden ojjektiva addolva")
	--[[if (not luaObj_IsActive("hidden", 1)) then
		luaObj_Add("hidden", 1)
		AddListener("kill", "Listener_CommandCenter", 
		{
				["callback"] = "luaUSN06_CommandCenterWasDestroyed",
				["entity"] = Mission.CommandCenter,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end]]--
end

------------------------------------------------------------------------------
function luaUSN06_CommandCenterWasDestroyed()
	if (IsListenerActive("kill", "Listener_CommandCenter")) then
		RemoveListener("kill", "Listener_CommandCenter")
	end
	luaObj_Completed("hidden", 1, true)
	--MissionNarrative(Mission.Narratives[8])
end

------------------------------------------------------------------------------
function luaUSN06_CheckPowerUpCondition()
	--[[if (not Mission.PowerUp) then
-- RELEASE_LOGOFF  		luaLog("PowerUp: false")
	else
-- RELEASE_LOGOFF  		luaLog("PowerUp: true")
	end
-- RELEASE_LOGOFF  	luaLog("Ship Destroyed: "..Mission.ConvoyShipDestroyed)]]--
	if (not Mission.PowerUp) and (Mission.ConvoyShipDestroyed > 2) then
		AddPowerup(
		{
				["classID"] = "improved_ship_manoeuvreability",
				["useLimit"] = 1,
		})
		Mission.PowerUp = true
		--MissionNarrative("missionglobals.newpowerup")
	end
end

------------------------------------------------------------------------------
function luaUSN06_CheckPri01()
	if (luaObj_IsActive("primary", 1) and (luaObj_GetSuccess("primary", 1) == nil)) then
		--if (Mission.DockedConvoyShip > (Mission.MaxConvoyNum - Mission.ShipsNeedToDestroy)) then
		if (Mission.DockedConvoyShip > 0) then
			luaObj_Failed("primary", 1)
			if (IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
				RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
			end
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_CheckPri01): Primary 01 Failed, 10-nel tobb hajo kotott ki")
			luaUSN06_StartDialog("Cargos_Failed")
			HideScoreDisplay(1, 0)
			HideScoreDisplay(2, 0)
		--elseif (Mission.ConvoyShipDestroyed > (Mission.ShipsNeedToDestroy - 1)) then
	elseif (Mission.ConvoyShipDestroyed == Mission.MaxConvoyNum) then
			luaObj_Completed("primary", 1, true)
			if (IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
				RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
			end
-- RELEASE_LOGOFF  			luaLog("(luaUSN06_CheckPri01): Primary 01 Completed, 10-nel tobb hajot semmisitett meg a player")
			-- TODO: dialogust bekotni hozza
			luaUSN06_StartDialog("Cargos_Success")
			--luaCheckpoint(1, nil)
			HideScoreDisplay(1, 0)
			HideScoreDisplay(2, 0)
			--luaDelay(luaUSN06_FadeInStart_Phase3, 8)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN06_HintSafeZone_Enabled()
	Mission.HintSafeZoneEnabled = true
end

------------------------------------------------------------------------------
function luaUSN06_TooManyShipsDocked()
	-- megkeresem az egyik kikotoben levo hajot
	local nShipInHarbor = 0
	for i, pShip in pairs (Mission.Convoy) do
		if (pShip.State == 1) and (nShipInHarbor == 0) then
			nShipInHarbor = i
		end
	end
	luaUSN06_MissionFailed(Mission.Convoy[nShipInHarbor], "usn06.obj_p1_fail")
end

------------------------------------------------------------------------------
function luaUSN06_MissionComplete()
	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end
	if not (luaObj_IsActive("secondary", 2)) then
		luaObj_Add("secondary", 2, nil, true)
	end
	if luaObj_GetSuccess("secondary", 2) == nil then
		luaObj_Completed("secondary", 2)
	end
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1)
	end
	luaMissionCompletedNew(Mission.CamTarget, "usn06.obj_p2_compl") --Mission.Narratives[7])
	Mission.EndMission = true
end

------------------------------------------------------------------------------
function luaUSN06SetChangeableGUIName(unit)
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
function luaUSN06_KillAllDialog()
	local tDialog = GetActDialogIDs()
	for i, pDialog in pairs (tDialog) do
		KillDialog(pDialog)
	end
end

------------------------------------------------------------------------------
function luaUSN06SaveMissionData()
	Mission.Checkpoint.Dialogues = Mission.Dialogues
	Mission.Checkpoint.Counter = Mission.Counter
	Mission.Checkpoint.HiddenPlanesActive = Mission.HiddenPlanesActive
end

------------------------------------------------------------------------------
function luaUSN06LoadMissionData()
	Mission.Dialogues = Mission.Checkpoint.Dialogues
	Mission.HiddenPlanesActive = Mission.Checkpoint.HiddenPlanesActive
	MissionNarrativeClear()
	--Mission.MissionPhase = 100
end

------------------------------------------------------------------------------
function luaUSN06_Cleaning()
	Kill(Mission.USN_Sub[1], true)
	for i, pUnit in pairs (Mission.Convoy) do
		Kill(pUnit, true)
	end
	--[[for i, pUnit in pairs (Mission.JAP_Destroyer01) do
		Kill(pUnit, true)
	end]]--
	if (luaObj_GetSuccess("hidden", 1) ~= nil) then
		for i, pPlane in pairs (Mission.PlanesHidden) do
			Kill(pPlane, true)
		end
	end
end

------------------------------------------------------------------------------
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(73)	-- Fubuki
	PrepareClass(224)	-- Japan Troop Transport
	PrepareClass(87)	-- Japan Cargo Transport
	PrepareClass(31)	-- Narwahl Class Submarine
	PrepareClass(27)	-- Elco PT Boat
	PrepareClass(70)	-- Kuma
	PrepareClass(60)	-- Kongo
	PrepareClass(69)	-- Takao
	PrepareClass(14)	-- Akizuki
	PrepareClass(7)		-- South Dakota
	PrepareClass(253)	-- North Carolina
	--PrepareClass(13)	-- New York
	PrepareClass(23)	-- Fletcher
	PrepareClass(135)	-- P-40 Warhawk
	PrepareClass(104)	-- P-38 Lightning
	PrepareClass(118)	-- B-25 Mitchell
	--PrepareClass(116)	-- B-17
	PrepareClass(77)	-- Japan PT
	PrepareClass(171)	-- Japan recon Plane
	PrepareClass(91) -- strafe-elheto Japan LST
	Loading_Finish()
end

---------debug fv-ek----------
function luaUSN06_Phase()
	local IDs = GetActDialogIDs()
	if (Mission.MissionPhase == 1) or (Mission.MissionPhase == 2) then
		for i, nID in pairs (IDs) do
			KillDialog(nID)
		end
		Mission.SubDeepLevel = 20
		--luaUSN06_SubmarineWasDestroyed()
	elseif (Mission.MissionPhase == 3) then
		for i, nID in pairs (IDs) do
			KillDialog(nID)
		end
		Mission.ConvoyShipDestroyed = 12
	elseif (Mission.MissionPhase == 4) then
		for i, nID in pairs (IDs) do
			KillDialog(nID)
		end
		for i, pShip in pairs (Mission.JAP_Units) do
			Kill(pShip)
		end
	end
end