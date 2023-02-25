--SceneFile="missions\USN\usn_10_Battle_of_Cape_Engano.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")

--	MineField Pos
--											MineField_Sign02																						MineField_Sign04
--	
--MineField_Sign01																						MineField_Sign03
		
--AddAirBaseStock(airbaseEnt, planeClassID, count)		
--RemoveAirBasePlanes(airbaseEnt)		
--SetAirBaseSlot(airbaseEnt, slotIndex, planeClassID, count [, armament])
--NavigatorCruise(entity)

--[[TODO:
	- softkill-nek utananezni, mert most a Catalina-nal hiaba allitottam true-ra, megis vesztesegnek vette a statisztikaban
	- megnezni mission startkor miert robban fel par bomba
	- meggondolni: esetleg unlock-nak egy ASV Fletcher-t berakni, aminek az elejen van egy DC agyu, es azzal ki lehetne loni az aknakat -> pl. Gold-kor kapja meg
	
Rephyx eszrevetelei:
	- Backgroundot, mission leirast atnezni a wiki alapjan + link, amit Rephyx kuldott levelben
	- kamikaze becsapodas hangjat megnezni, valami furcsa, nem robbano hatasa van
	+ japan carriereket atnezni, mert nem ezek a classok voltak a valosagban
			* valosagban
					- Zuikaku -> Shokaku-class
					- Zuiho -> Zuiho-class
					- Chiyoda -> Chiyoda-class
					- Chitose -> Chitose-class
			* most a jatekban
					+ Zuikaku -> Soryu-class
					+ Zuiho -> Zuiho-class
					+ Chiyoda -> Soryu-class -> legyen Zuiho
					+ Chitose -> Hiryu-class -> legyen Zuiho
	+ battleshipek class-szat is atnezni
			* valosagban
					- BBCV HYUGA -> Ise-class battleship
					- BB Ise -> Ise-class battleship
					- CL OYODO -> Oyodo-class cruiser
					- CL TAMA -> Kuma-class cruiser
					- CL ISUZU -> Nagara-class cruiser
			* jatekban
					+ CA Ise (Takao-class) -> ehelyett lehetne a neve CL OYODO, de az meg CL volt, CA nem volt ebben a csataban -> Agano-class, Isuzu
					+ DD Akizuki (Akizuki-class) -> Akizuki nem volt ebben a csataban, nem tudom milyen nevet adjak neki, mert nem volt tobb akizuki-class-szu
					+ a 2 minekaze-class-szu hajot atnevezni (a mostani nevu hajok Akizuki-k voltak) -> Akikaze lehet az egyik hajo, a masik DE Sugi
					+ nem ujsagiroi verzioban Tone-class-szok es Mogami-class vannak most (CA), a valosagban CL-ek voltak a csataban
					- Kell meg 1 CL nev es 2 oil tanker nev
					+ DD-nek Fubuki, gyengebb hajoknak Destr.Escort -> ezek Minekaze class-ok. A nevek legyen ugyanazok
					
					
		Checkpoint tennivalok:
			- halott unitok kiszedese a visszatoltes utani tablabol (aknak is!)
			- HP? (mas palyakon torpedo ill. bombaszam?)
]]--

------------------------------------------------------------------------------
function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	--MessageMap betoltese
	LoadMessageMap("usn10dlg",1)
	EnableMessages(false)
	--luaDelay(luaUSN10_DateLocation, 2)
	luaUSN10_DateLocation()
	luaDelay(luaUSN10_Dialog_Intro01, 23)
	UnitHoldFire(FindEntity("DummyShip"))
	UnitHoldFire(FindEntity("Iowa Class 01"))
	UnitHoldFire(FindEntity("South Dakota Class 01"))
	UnitHoldFire(FindEntity("Akizuki-class 01"))
	UnitHoldFire(FindEntity("Takao-class 01"))
	UnitHoldFire(FindEntity("Hiryu-class 01"))
	UnitHoldFire(FindEntity("Soryu-class 01"))
end
	
------------------------------------------------------------------------------
function luaUSN10_DateLocation()
	MissionNarrative("usn10.date_location")
end	
	
------------------------------------------------------------------------------
function luaUSN10_Dialog_Intro01()
	local FinalDialogues = {
		["intro01"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
			},
		},
	}
	StartDialog("intro01", FinalDialogues["intro01"])
	luaDelay(luaUSN10_Dialog_Intro02, 9)
end

------------------------------------------------------------------------------
function luaUSN10_Dialog_Intro02()
	local FinalDialogues = {
		["intro02"] = {
			["sequence"] = {
				{
					["message"] = "idlg02",
				},
				{
					["message"] = "idlg02_1",
				},
			},
		},
	}
	StartDialog("intro02", FinalDialogues["intro02"])
	luaDelay(luaUSN10_Dialog_Intro03, 11)
end

------------------------------------------------------------------------------
function luaUSN10_Dialog_Intro03()
	local FinalDialogues = {
		["intro03"] = {
			["sequence"] = {
				{
					["message"] = "idlg03",
				},
			},
		},
	}
	StartDialog("intro03", FinalDialogues["intro03"])
end

------------------------------------------------------------------------------
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaUSN10Init")
	Scoring_RealPlayTimeRunning(true)
end

------------------------------------------------------------------------------
function luaUSN10Init(this)
	Mission = this
	this.Name = "US10"
	this.ScriptFile = "SCRIPTS/missions/USN/usn_10_Battle_of_Cape_Engano.lua"
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

	--global Constants
	this.MPStoKTS								= 1.94			-- 1 m/s = 1.94 knots
	this.JOURNALIST_VERSION 		= true	-- ezeket a reszeket csak az ujsagioroi verzioban hasznaljuk, Mission konnyites (crewlevel, tobb player unit, stb.)
	this.KamikazeTime				 		= 151		-- Mission start utan ennyi frame-mel indulnak el a kamikaze gepek tamadni
	this.ENABLE_DUMMYSHIP				= true	-- lathato -e a Mission elejen a felrobbano hajo
	
	
	if (this.JOURNALIST_VERSION) then
		this.KamikazeTime = 50
	else
		this.KamikazeTime = 151
	end
	
	--difficulty
	this.difficulty = GetDifficulty()
	
	--global variables
	this.MissionPhase = 1
	this.EndMission = false
	this.FirstRun = 1
	this.PlaneWaves = 1
	this.MissionCounter = 0
	--this.Narrative04 = false		-- kiirtam -e mar a 04-es narrative-ot
	this.Narrative05 = false		-- kiirtam -e mar a 05-os narrative-ot
	this.Phase2Started	= false	-- true, ha mar phase2 megvolt, ha meg nem, akkor Phase3 elott el kell inditani 
	this.WestCarriersAttack = false -- true, ha a nyugati carrierek elkezdik kuldeni a repuloket a player carrierjeire
	this.PowerUp = false						-- a player megszerezte -e mar a powerup-ot. Csak 1 "improved repair team" powerup-ot kap, ha kilo 1 carriert
	this.KaitenSpawned = false			-- lespawnolodtak -e mar a japan Suicide torpedok
	this.KaitenTarget = nil					-- amelyik BB belepett a Kaiten area-jaba, az kerul bele a valtozoba, ez lesz a Kaitenek targetje
	this.DestroyedHiddenTT	= 0			-- ennyi hidden TT-t semmisitett meg a player
	this.DialogMineField01	= false		-- beleert -e mar egyszer a minefield01-nek az area-jaba
	this.DialogMineField02	= false		-- beleert -e mar egyszer a minefield02-nek az area-jaba
	this.JAPSquadNorthChase = false		-- erteke true, ha a japo eszaki squadbol valamelyik kapott egy hitet -> ekkor elkezdik tamadni a hitet lovot, majd a masik battleshipet
	this.CarrierCounter	= 0						-- ebben a valtozoban tarolom, hogy eddig mennyi japo carrier spawnolt, a halalukkor fentmaradt repulok uj celpont valasztasahoz es kitakaritasahoz kell
	this.MaxCarrierCounter = 4				-- ez mutatja, hogy hany carrier jelent mar meg a scene-ben (a fazisokban foyamatosan adom hozza a carrierek szamat)
	this.HintDDJournalist = false			-- true, ha kiirodott mar az ujsagiroi verzioban a DD-be ulse hintje
	this.HintTorpedoJournalist = false -- true, ha a DD-k mar kilottek egy torpedot, ekkor dobok egy hintet
	this.szDisplayUnitHP = "Iowa"			-- azt tarolja eppen melyik hajonak van megjelenitve a HP-ja
	this.EMIsMapViewActive = nil			-- EM-nel hasznalom, eltarolom, hogy EM elot a Map View volt -e aktiv
	this.MCEntity = nil								-- Mission completedkor az entity, akire a kamerat kell dobni (dialog callbackben nem lehet parametert megadni)
	this.MCText = ""									-- Mission completedkor a kiirando szoveg (dialog callbackben nem lehet parametert megadni)
	this.EMLastSelected = nil					-- melyik entity volt kiszelektalva EM elott
	this.IowaHP = 100									-- mennyi a HP-ja az Iowa-nak
	this.EnterpriseHP = 100						-- mennyi a HP-ja az Enterprise-nak
	this.EMPlaying = true							-- kezdetben true-ra allitom, hogy Mission startkor ne jelenjen meg, Init-ben lesz false
	
	this.MineLogNum = 0								-- csak debughoz hasznalom az akna log file neveben

	--Checkpoint hasznalja
	this.CP_USNPositions = {}
	this.CP_IJNPositions = {}
	this.CP_SelectedUnit = {}

	--Precache
	--atrakva a luaPrecacheUnits()-ba
	
	this.ChangeableNames = {}
	Mission.ChangeableNames[11] = {	-- Allen M. Sumner
		"ingame.shipnames_borie",
		"ingame.shipnames_soley",
		"ingame.shipnames_hyman",
		"ingame.shipnames_compton",
		"ingame.shipnames_soley"
	}
	Mission.ChangeableNames[48] = {	-- ASW Fletcher
		"ingame.shipnames_picking",
		"ingame.shipnames_remey",
		"ingame.shipnames_wadleigh",
		"ingame.shipnames_stockham",
		"ingame.shipnames_mertz",
	}
	Mission.ChangeableNames[900] = {	-- Luppis
		"ingame.shipnames_strong",
		"ingame.shipnames_bristol",
		"ingame.shipnames_john_w_weeks",
		"ingame.shipnames_walke",
		"ingame.shipnames_drexler",
	}
	this.ChangeableNames[15] = {"ingame.shipnames_illinois", "ingame.shipnames_wisconsin"}	-- Iowa
	this.ChangeableNames[389] = {"ingame.shipnames_montana", "ingame.shipnames_lousiana"}	-- Montana
	
	--allied hajok
	this.USN_Iowa = {}
		table.insert(this.USN_Iowa, FindEntity("Iowa Class 01"))
	this.USN_Squad01 = {}
		table.insert(this.USN_Squad01, this.USN_Iowa[1])
		table.insert(this.USN_Squad01, FindEntity("South Dakota Class 01"))
	
	if IsClassChanged(FindEntity("South Dakota Class 01").ClassID) then
		luaSetUnlockName(FindEntity("South Dakota Class 01"))
	end
	if (this.ENABLE_DUMMYSHIP) then
		this.DummyShip = {}
			table.insert(this.DummyShip, FindEntity("DummyShip"))
		this.DummyPlanes = {}
			table.insert(this.DummyPlanes, FindEntity("DummyPlanes"))
		AddUntouchableUnit(this.DummyPlanes[1])
		SetRoleAvailable(this.DummyShip[1], EROLF_ALL,PLAYER_AI)
		PilotSetTarget(this.DummyPlanes[1], this.DummyShip[1])
	end
	
	this.USN_Enterprise = {}
	this.USN_Squad02 = {}
	this.USN_Squad02_DD = {}

	this.USN_Units = {}		--ebbe tarolom az osszes USA unitot, az akna figyelmeztetesre es a checkpointoknal hasznalom
		table.insert(this.USN_Units, this.USN_Squad01[1])
		table.insert(this.USN_Units, this.USN_Squad01[2])
		
	--allied repulok
	this.USN_ReconPlane = {}
	
	--Level Bomber unlock unit
	
	--allied path-ok, navpointok
	this.USN_SpawnPoints = {}
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_South01"))
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_West02"))
		table.insert(this.USN_SpawnPoints, FindEntity("Navpoint_North01"))
		
	this.USN_NavpointPlayerStart = {}
		table.insert(this.USN_NavpointPlayerStart, FindEntity("Navpoint_USNSquad01_Start"))
		table.insert(this.USN_NavpointPlayerStart, FindEntity("Navpoint_USNSquad02_Start"))
	
	--player shipyardok
	
	--japan hajok
	this.JAP_SquadNorth = {}
		table.insert(this.JAP_SquadNorth, FindEntity("Soryu-class 01"))	--carrier
		table.insert(this.JAP_SquadNorth, FindEntity("Hiryu-class 01"))	--carrier
		table.insert(this.JAP_SquadNorth, FindEntity("Takao-class 01"))
		TorpedoEnable(Mission.JAP_SquadNorth[3], false)
		table.insert(this.JAP_SquadNorth, FindEntity("Akizuki-class 01"))
		TorpedoEnable(Mission.JAP_SquadNorth[4], false)
		if (Mission.difficulty == 0) then
			for i, pUnit in pairs (Mission.JAP_SquadNorth) do
				SetSkillLevel(pUnit, SKILL_SPNORMAL)
			end
		else
			for i, pUnit in pairs (Mission.JAP_SquadNorth) do
				SetSkillLevel(pUnit, SKILL_SPVETERAN)
			end
		end
		
	this.JAP_SquadNorthAttackers = {}
		table.insert(this.JAP_SquadNorthAttackers, FindEntity("Takao-class 01"))
		table.insert(this.JAP_SquadNorthAttackers, FindEntity("Akizuki-class 01"))

	this.JAP_Carriers = {}
		table.insert(this.JAP_Carriers, FindEntity("Soryu-class 01"))
		table.insert(this.JAP_Carriers, FindEntity("Hiryu-class 01"))
	this.JAP_SquadSouth = {}

	this.JAP_SquadWest = {}	
	
	this.JAP_CarriersWest_ReconTable = {}		--ezt arra hasznalom, hogy elkulonitsem a nyugati csapatbol a 2 carriert, erre vizsgalok a recon listenernel + a kaitenes resznel ezeknek nezem a tavolsagat a player BB-ktol + EM03-ban hasznalom meg
		
	this.JAP_Targets = {}			-- a tablat arra hasznalom, hogy az aifield managernek ebbol a tablabol valasztok randomot celpontnak (Iowa, Enterprise, vagy az Iowa-t kisero hajo)		
		table.insert(this.JAP_Targets, FindEntity("Iowa Class 01"))
		table.insert(this.JAP_Targets, FindEntity("South Dakota Class 01"))
		
	this.JAP_HiddenTT = {}
		table.insert(this.JAP_HiddenTT, FindEntity("Hidden_TroopTransport01"))
		table.insert(this.JAP_HiddenTT, FindEntity("Hidden_TroopTransport02"))
		table.insert(this.JAP_HiddenTT, FindEntity("Hidden_TroopTransport03"))
		table.insert(this.JAP_HiddenTT, FindEntity("Hidden_TroopTransport04"))
		
	this.JAP_HiddenDD = {}
		table.insert(this.JAP_HiddenDD, FindEntity("Hidden_Fubuki01"))
		table.insert(this.JAP_HiddenDD, FindEntity("Hidden_Fubuki02"))
		table.insert(this.JAP_HiddenDD, FindEntity("Hidden_Fubuki03"))
		if (Mission.difficulty == 0) then
			for i, pUnit in pairs (Mission.JAP_HiddenDD) do
				SetSkillLevel(pUnit, SKILL_SPNORMAL)
			end
		else
			for i, pUnit in pairs (Mission.JAP_HiddenDD) do
				SetSkillLevel(pUnit, SKILL_SPVETERAN)
			end
		end
		
	--japan repulok
	this.JAP_StartingPlanes = {}
		table.insert(this.JAP_StartingPlanes, FindEntity("B6N Jill 01"))
		table.insert(this.JAP_StartingPlanes, FindEntity("D4Y Judy 01"))
	--this.JAP_StartingPlane02	= FindEntity("D4Y Judy 01")
	
	this.JAP_ActivePlaneSquadsCarrier01 = {}
	this.JAP_ActivePlaneSquadsCarrier02 = {}
	this.JAP_ActivePlaneSquadsCarrier03 = {}
	this.JAP_ActivePlaneSquadsCarrier04 = {}
	
	--japan hajok
	
	--japan path-ok, navpointok
	this.JAP_PathSquadNorth = {}
		table.insert(this.JAP_PathSquadNorth, FindEntity("Path_JAPSquadNorth"))
	
	this.JAP_PathHidden_TT01 = {}
		table.insert(this.JAP_PathHidden_TT01, FindEntity("Path_HiddenTT01"))
		table.insert(this.JAP_PathHidden_TT01, FindEntity("Path_HiddenTT02"))
	this.JAP_PathHidden_DD01 = {}
		table.insert(this.JAP_PathHidden_DD01, FindEntity("Path_HiddenDD01"))
		table.insert(this.JAP_PathHidden_DD01, FindEntity("Path_HiddenDD02"))
		table.insert(this.JAP_PathHidden_DD01, FindEntity("Path_HiddenDD03"))
	
	this.JAP_SpawnPoints = {}
		table.insert(this.JAP_SpawnPoints, FindEntity("Navpoint_West01"))
		
	this.JAP_MineField01 = {}
		local tPos
		-- 1-es minefield bal also sarka
		tPos = GetPosition(FindEntity("MineField_Sign01"))
		this.JAP_MineField01["x1"] = tPos["x"]
		this.JAP_MineField01["z1"] = tPos["z"]
		-- 1-es minefield jobb felso sarka
		tPos = GetPosition(FindEntity("MineField_Sign02"))
		this.JAP_MineField01["x2"] = tPos["x"]
		this.JAP_MineField01["z2"] = tPos["z"]
		
	this.JAP_MineField02 = {}
		-- 2-es minefield bal also sarka
		tPos = GetPosition(FindEntity("MineField_Sign03"))
		this.JAP_MineField02["x1"] = tPos["x"]
		this.JAP_MineField02["z1"] = tPos["z"]
		-- 2-es minefield jobb felso sarka
		tPos = GetPosition(FindEntity("MineField_Sign04"))
		this.JAP_MineField02["x2"] = tPos["x"]
		this.JAP_MineField02["z2"] = tPos["z"]
		
	this.JAP_MineField_EM = {}
		table.insert(this.JAP_MineField_EM, FindEntity("Navpoint_Minefield01_EM"))
		table.insert(this.JAP_MineField_EM, FindEntity("Navpoint_Minefield02_EM"))
	
	this.JAP_Navpoint_Kaitens = {}
		table.insert(this.JAP_Navpoint_Kaitens, FindEntity("Navpoint_Kaiten_SpawnPoint"))		-- ide spawnolnak a Kaitenek es a sub
		table.insert(this.JAP_Navpoint_Kaitens, FindEntity("Navpoint_Kaiten_Area01"))				-- Kaiten evac pointnak hasznalom
		table.insert(this.JAP_Navpoint_Kaitens, FindEntity("Navpoint_Kaiten_Area02"))				-- Kaiten areacheck jobb felso pointja
	
	this.JAP_Kaiten_Area = {}
		table.insert(this.JAP_Kaiten_Area, GetPosition(this.JAP_Navpoint_Kaitens[2]))
		table.insert(this.JAP_Kaiten_Area, GetPosition(this.JAP_Navpoint_Kaitens[3]))
		
	this.JAP_Kaitens = {}
		
	--Journalist version		
	if (this.JOURNALIST_VERSION) then
		for i, pUnit in pairs (this.JAP_SquadNorth) do
			--SetSkillLevel(pUnit, SKILL_STUN)
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end
		--[[for i, pUnit in pairs (this.USN_Squad01) do
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end]]--
	end
	--Achivements Init
	
	--music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	--engine movie
	--luaInitJumpinMovies()
	
	-- DC plane-ek kuldesenek tiltasa a battleshiperkrol
	--ForceEnableInput(IC_SHIP_LAUNCHUNIT, false)
	SetCatapultStock(Mission.USN_Iowa[1], 0)
	SetCatapultStock(Mission.USN_Squad01[2], 0)	-- South Dakota
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUSN10LoadMissionData, luaUSN10_Checkpoint01_CleaningAndPutToPosition}, --luaUSN10_Checkpoint01_Listeners, luaUSN10_Checkpoint01_Formations},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUSN10SaveMissionData, luaUSN10_Checkpoint01_SavePositions},
	}
	
	--dialogusok
	LoadMessageMap("usn10dlg",1)
	this.FinalDialogues = {
		["Bombers_Coming"] = {
			["sequence"] = {
				{
					["message"] = "dlg01",
				},
			},
		},
		["Allied_Carrier_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg02",
				},
			},
		},
		["Allied_Carrier_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg03",
				},
			},
		},
		["TroopTransport_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg04",
				},
			},
		},
		["TroopTransport_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg05",
				},
			},
		},
		["TroopTransport_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg06",
				},
			},
		},
		["TroopTransport_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg07",
				},
			},
		},
		["TroopTransport_05"] = {

			["sequence"] = {
				{
					["message"] = "dlg08",
				},
			},
		},
		["TroopTransport_06"] = {
			["sequence"] = {
				{
					["message"] = "dlg09",
				},
			},
		},
		["TroopTransport_07"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["TroopTransport_08"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["TroopTransport_09"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["TroopTransport_10"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
			},
		},
		["TroopTransport_11"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["TroopTransport_12"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
			},
		},
		["Hidden_Located_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
			},
		},
		["Hidden_Located_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
			},
		},
		["Hidden_Located_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
		["Hidden_Located_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg19",
				},
			},
		},
		["Hidden_Killed_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg20",
				},
			},
		},
		["Hidden_Killed_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg21",
				},
				{
					["message"] = "dlg21_1",
				},
			},
		},
		["Kamikaze_Attack_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg22",
				},
			},
		},
		["Kamikaze_Hit_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
			},
		},
		["Kamikaze_Hit_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg25",
				},
			},
		},
		["Kamikaze_Hit_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg26",
				},
			},
		},
		["Kamikaze_Hit_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg27",
				},
			},
		},
		["Kamikaze_Hit_05"] = {
			["sequence"] = {
				{
					["message"] = "dlg28",
				},
			},
		},
		["Warship_Attack_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg29",
				},
			},
		},
		["Warship_Attack_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg30",
				},
			},
		},
		["Warship_Attack_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg31",
				},
			},
		},
		["Catalina"] = {
			["sequence"] = {
				{
					["message"] = "dlg32",
				},
			},
		},
		["7th_Fleets_Message_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg33",
				},
			},
		},
		["7th_Fleets_Message_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg34",
				},
				{
					["message"] = "dlg34_1",
				},
			},
		},
		["7th_Fleets_Message_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg35",
				},
			},
		},
		["7th_Fleets_Message_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg36",
				},
			},
		},
		["7th_Fleets_Message_05"] = {
			["sequence"] = {
				{
					["message"] = "dlg37",
				},
			},
		},
		["7th_Fleets_Message_06"] = {
			["sequence"] = {
				{
					["message"] = "dlg38",
				},
			},
		},
		["Carrier_Destroyed_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg44",
				},
			},
		},
		["Carrier_Destroyed_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg45",
				},
			},
		},
		["Iowa_HP_50"] = {
			["sequence"] = {
				{
					["message"] = "dlg46",
				},
			},
		},
		["Iowa_HP_20_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg47",
				},
			},
		},
		["Iowa_HP_20_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg48",
				},
			},
		},
		["Iowa_HP_20_03"] = {
			["sequence"] = {
				{
					["message"] = "dlg49",
				},
			},
		},
		["Iowa_HP_20_04"] = {
			["sequence"] = {
				{
					["message"] = "dlg50",
				},
			},
		},
		["Enterprise_HP_50_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg51",
				},
			},
		},
		["Enterprise_HP_50_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg52",
				},
			},
		},
		["Enterprise_HP_20_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg53",
				},
			},
		},
		["Enterprise_HP_20_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg54",
				},
			},
		},
		["Mission_Complete"] = {
			["sequence"] = {
				{
					["message"] = "dlg55",
				},
				{
					["message"] = "dlg55_1",
				},
				{	["type"] = "callback",
					["callback"] = "luaUSN10_EndMission",
				},
			},
		},
		["Minefield_01"] = {
			["sequence"] = {
				{
					["message"] = "dlg56",
				},
			},
		},
		["Minefield_02"] = {
			["sequence"] = {
				{
					["message"] = "dlg57",
				},
			},
		},
	}
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(this, "luaUSN10Think")
	
	EnableMessages(true)
	
	--SoundFade(1, "", 1)
	
	SetSelectedUnit(Mission.USN_Iowa[1])
	
	--Objectives
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "EnemyCarriers",		-- azonosito
				["Text"] = "usn10.obj_p1",	--"Destroy all enemy carriers",
				["TextCompleted"] = "", -- nem irjuk ki ketszer, hogy --"All enemy carriers have been destroyed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", --"usn10.obj_p1_fail", --"You failed to destroy all enemy carriers",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "Iowa",		-- azonosito
				["Text"] = "usn10.obj_p2", --"Iowa must survive",
				["TextCompleted"] = "usn10.obj_p2_compl", --"usn10.obj_p2_compl", --"Iowa has survived the battle" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn10.obj_p2_fail", --"usn10.obj_p2_fail", --"Iowa has been destroyed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "Enterprise",		-- azonosito
				["Text"] = "usn10.obj_p3", --"Enterprise must survive",
				["TextCompleted"] = "usn10.obj_p3_compl", --"usn10.obj_p3_compl", --"Enterprise has survived the battle" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn10.obj_p3_fail", --"usn10.obj_p3_fail", --"Enterprise has been destroyed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
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
				["ID"] = "PlayerUnits",		-- azonosito
				["Text"] = "usn10.obj_s1", --"Do not lose any of your ships",
				["TextCompleted"] = "usn10.obj_s1_compl", --"usn10.obj_s1_compl", --"You have protected all of your ships successfully" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", --"A task force ship has been lost",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
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
				["ID"] = "HiddenTT",		-- azonosito
				["Text"] = "usn10.obj_h1", -- "Destroy the Japanese Transport Convoy",
				["TextCompleted"] = "usn10.obj_h1_compl", --"You have destroyed the Japanese Transport Convoy" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", --"You have failed to destroy the Japanese Transport Convoy",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	
	--EM hold fire visszaallitasa
	UnitFreeFire(FindEntity("DummyShip"))
	UnitFreeFire(FindEntity("Iowa Class 01"))
	UnitFreeFire(FindEntity("South Dakota Class 01"))
	UnitFreeFire(FindEntity("Akizuki-class 01"))
	UnitFreeFire(FindEntity("Takao-class 01"))
	UnitFreeFire(FindEntity("Hiryu-class 01"))
	UnitFreeFire(FindEntity("Soryu-class 01"))
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetVisibilityTerrainNode("usn10_cape_engano:mapzone", false)
	
	luaCheckSavedCheckpoint()
	if (Mission.CheckpointLoaded ~= nil) and (Mission.CheckpointLoaded) then
		DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
		Mission.EMPlaying = false
		luaUSN10_DisplayHP()
		if (Mission.DialogMineField01) or (Mission.DialogMineField02) then
			SetVisibilityTerrainNode("usn10_cape_engano:mapzone", true)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10Think(this, msg)
	if luaMessageHandler(Mission, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." is terminated!")
		return
	end
	
	if (Mission.EndMission) then
		return
	end
	
	--luaLog("(Think): table length = "..table.getn(Mission.JAP_Targets))
	--debug--
	--AddWatch("Mission.MissionCounter")
	--debug--
	
	Mission.MissionCounter = Mission.MissionCounter + 1
	luaCheckMusic()

	luaUSN10_RemoveDeadsFromTables()

	luaUSN10_CheckMineSurroundings()
	
	--luaUSN10_MissionComplete()
	
	luaUSN10_CheckIowaHP()
	
	luaUSN10_AttackManager()		-- a japan carrierek felkuldott repuloinek tamadasat vezerli
	
	luaUSN10_JAPSquadNorthAttackManager()		-- az eszaki japan carrier kiseretenek tamadasat vezerli
	
	luaUSN10_CheckActiveSquadsOfCarriers()		-- a megsemmisult japan carrierek felkuldott repuloit manage-eli: ha nincs fuggesztmenye vagy fighter akkor kikuldi a borderen kivulre

	luaUSN10_DisplayHP()
	
	--[[if (not Mission.FirstRun) or ((Mission.FirstRun) and (Mission.MissionPhase ~= 1)) then
		luaUSN10_AttackManager()
	end]]--
		
	if (Mission.MissionPhase == 1) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN10_InitPlayerUnits_Phase1()
			luaUSN10_InitJAPUnits_Phase1()
			luaDelay(luaUSN10_InitPRI01, 5)
			luaDelay(luaUSN10_InitPRI02, 7)
			luaUSN10_InitHIDDEN01()
			luaDelay(luaUSN10_InitSEC01, 15)
			--luaUSN10_InitAttack()
			--TODO: megvizsgalni, hogy elofordulhat -e, hogy meg phase2 elott kilovi a player a carriereket
			luaUSN10_StartingBlackout()
			--luaUSN10_InitPowerUp()	--TODO: most a carrierlistener phase1-es es phase3-as helyettesiti, ha nem kell, akkor torolni
			luaUSN10_InitJapaneseCarriersKillListener_Phase1()
			--luaDelay(luaUSN10_StartingPhase2, 450)	-- a valtozoba elrakas csak debug miatt van, a phase valtaskor hasznalom
			if (Mission.ENABLE_DUMMYSHIP) then
				luaDelay(luaUSN10_DummyShipExplode, 12)
			end
			luaDelay(luaUSN10_DialogBombersComing, 16)
			Mission.Delay = luaDelay(luaUSN10_HiddenHint, 30) -- csak debug miatt, a fazis leptetesnel hasznalom a Mission.Delay-t
			luaDelay(luaUSN10_InitJAPSquadNorthHit, 10)
			SetDeviceReloadEnabled(true)
			--luaUSN10_TEST_Hit()
		end
		--luaUSN10_AttackManager()
	elseif (Mission.MissionPhase == 2) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN10_InitPhase2()
			--luaUSN10_InitSquadSouth()
		end
		luaUSN10_HintDDJournalist()
		luaUSN10_HintTorpedoJournalist()
		luaUSN10_CheckEnterpriseHP()
	elseif (Mission.MissionPhase == 3) then
		if (Mission.FirstRun) then
			Mission.FirstRun = false
			luaUSN10_InitPhase3()
			luaDelay(luaUSN10_Dialog_7thFleetsMessage, 300)
		end
		luaUSN10_HintDDJournalist()
		luaUSN10_HintTorpedoJournalist()
		--luaUSN10_Kaiten_AreaCheck()
		luaUSN10_WestCarriersPlanesAttack()
		luaUSN10_CheckEnterpriseHP()
	end
	
end

------------------------------------------------------------------------------
function luaUSN10_StartingBlackout()
	Blackout(true, "", 0.5, 0)
end

------------------------------------------------------------------------------
function luaUSN10_StartDialog(szDialogID)
	if (Mission.FinalDialogues[szDialogID].printed == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = nil")
	elseif (Mission.FinalDialogues[szDialogID].printed == false) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = false")
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID.." = true")
	end
	if (Mission.FinalDialogues[szDialogID].printed == nil) or (Mission.FinalDialogues[szDialogID].printed == false) then
		Mission.FinalDialogues[szDialogID].printed = true
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_StartDialog): "..szDialogID)
		StartDialog(szDialogID, Mission.FinalDialogues[szDialogID])
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitPlayerUnits_Phase1()
	JoinFormation(Mission.USN_Squad01[2], Mission.USN_Iowa[1])
	--SetShipSpeed(Mission.USN_Squad01[1], 10)
	--NavigatorMoveToRange(Mission.USN_Iowa[1], Mission.USN_NavpointPlayerStart[1])
	NavigatorCruise(Mission.USN_Iowa[1])
	SetShipSpeed(Mission.USN_Iowa[1], 10)
	if (Mission.ENABLE_DUMMYSHIP) then
		SetShipSpeed(Mission.DummyShip[1], 10)
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitJAPUnits_Phase1()
	for i, pCarrier in pairs (Mission.JAP_Carriers) do
		pCarrier.Number = i
	end
	Mission.CarrierCounter = 4
	--Mission.MaxCarrierCounter = 4
	for i = 2, table.getn(Mission.JAP_SquadNorth) do
		JoinFormation(Mission.JAP_SquadNorth[i], Mission.JAP_SquadNorth[1])
	end
	NavigatorMoveOnPath(Mission.JAP_SquadNorth[1], Mission.JAP_PathSquadNorth[1], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	--Kezdo gepek tamadasa (Judy, Jill)
	PilotSetTarget(Mission.JAP_StartingPlanes[1], Mission.USN_Units[1])
	PilotSetTarget(Mission.JAP_StartingPlanes[2], Mission.USN_Units[2])
end

------------------------------------------------------------------------------
function luaUSN10_DummyShipExplode()
	BreakShip(Mission.DummyShip[1])
	if (not Mission.DummyPlanes[1].Dead) then
		RemoveUntouchableUnit(Mission.DummyPlanes[1])
	end
end

------------------------------------------------------------------------------
function luaUSN10_DialogBombersComing()
	--MissionNarrative(Mission.Narratives[3])
	luaUSN10_StartDialog("Bombers_Coming")
end

------------------------------------------------------------------------------
function luaUSN10_HiddenHint()
	luaUSN10_StartDialog("TroopTransport_01")
	luaUSN10_StartDialog("TroopTransport_02")
	luaUSN10_StartDialog("TroopTransport_03")
	luaUSN10_StartDialog("TroopTransport_04")
	luaUSN10_StartDialog("TroopTransport_05")
	luaUSN10_StartDialog("TroopTransport_06")
	luaUSN10_StartDialog("TroopTransport_07")
	luaUSN10_StartDialog("TroopTransport_08")
	luaUSN10_StartDialog("TroopTransport_09")
	luaUSN10_StartDialog("TroopTransport_10")
	luaUSN10_StartDialog("TroopTransport_11")
	luaUSN10_StartDialog("TroopTransport_12")
end

------------------------------------------------------------------------------
function luaUSN10_InitJAPSquadNorthHit()
	if (not IsListenerActive("hit", "Listener_JAPSquadNorthWasHit")) then
		AddListener("hit", "Listener_JAPSquadNorthWasHit", 
		{
			["callback"] = "luaUSN10_JAPSquadNorthWasHit",
			["target"] = Mission.JAP_SquadNorth,
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, --Mission.JAP_Kaitens, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
-- RELEASE_LOGOFF  		luaLog("A JAPSquadNorth Listenert beregisztraltam")
	end
end

------------------------------------------------------------------------------
function luaUSN10_JAPSquadNorthWasHit(pTarget, pTargetDevice, pAttacker)
	if (Mission.JAPSquadNorthChase == false) and (pAttacker ~= nil) then	--a masodik feltetel csak a debug miatt kell, ha free kameraval lovom szet a hajot, ne fagyjon szet
		if (IsListenerActive("hit", "Listener_JAPSquadNorthWasHit")) then
			RemoveListener("hit", "Listener_JAPSquadNorthWasHit")
		end
		Mission.JAPSquadNorthChase = true
-- RELEASE_LOGOFF  		luaLog("--North Squad Was Hit--")
-- RELEASE_LOGOFF  		luaLog("Attacker: "..pAttacker.Name)
		for i, pUnit in pairs (Mission.JAP_SquadNorth) do
			luaSetScriptTarget(pUnit, pAttacker)
			NavigatorAttackMove(pUnit, pAttacker, {})
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_JAPSquadNorthAttackManager()
	if (table.getn(Mission.JAP_SquadNorthAttackers) == 0) then
		Mission.JAPSquadNorthChase = false
	end
	if (Mission.JAPSquadNorthChase) then
		Mission.USN_Squad01 = luaRemoveDeadsFromTable(Mission.USN_Squad01)
		local pCurrentTarget
		for i, pUnit in pairs (Mission.JAP_SquadNorthAttackers) do
			pCurrentTarget = luaGetScriptTarget(pUnit)
			--[[luaLog("==ScriptTarget==")
			if (pCurrentTarget ~= nil) then
-- RELEASE_LOGOFF  				luaLog(pCurrentTarget.Name)
			else
-- RELEASE_LOGOFF  				luaLog("Target = nil")
			end]]--
			if (pCurrentTarget == nil) or (pCurrentTarget.Dead) then
				if (table.getn(Mission.USN_Squad01) > 0) then
					luaSetScriptTarget(pUnit, Mission.USN_Squad01[1])
					NavigatorAttackMove(pUnit, Mission.USN_Squad01[1], {})
				else
-- RELEASE_LOGOFF  					luaLog("(luaUSN10_JAPSquadNorthAttackManager): Elvileg MissionFailed")
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitAttack()
	SquadronSetHomeBase(Mission.JAP_StartingPlane01, Mission.JAP_Carriers[1])
	SquadronSetHomeBase(Mission.JAP_StartingPlane02, Mission.JAP_Carriers[2])
	PilotSetTarget(Mission.JAP_StartingPlane01, Mission.USN_Iowa[1])
	PilotBomb(Mission.JAP_StartingPlane01, Mission.USN_Iowa[1])
	PilotSetTarget(Mission.JAP_StartingPlane02, Mission.USN_Iowa[1])
	PilotBomb(Mission.JAP_StartingPlane02, Mission.USN_Iowa[1])
end

------------------------------------------------------------------------------
function luaUSN10_InitPRI01()
	luaObj_Add("primary", 1, Mission.JAP_Carriers)
	DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPRI01): PRI01 ojjekt addolva")
end

------------------------------------------------------------------------------
function luaUSN10_InitPRI02()
	luaObj_Add("primary", 2, Mission.USN_Iowa[1])
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPRI02): PRI02 ojjekt addolva")
	Mission.EMPlaying = false
	if (not IsListenerActive("kill", "Listener_IowaWasDestroyed")) then
		AddListener("kill", "Listener_IowaWasDestroyed", 
		{
				["callback"] = "luaUSN10_IowaWasDestroyed",
				["entity"] = Mission.USN_Iowa,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (not IsListenerActive("exitzone", "Listener_IowaExited")) then
		AddListener("exitzone", "Listener_IowaExited", 
		{
				["callback"] = "luaUSN10_IowaWasDestroyed",
				["entity"] = Mission.USN_Iowa,
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
end
end

------------------------------------------------------------------------------
function luaUSN10_IowaWasDestroyed(pEntity)
	Mission.USN_Squad01 = luaRemoveDeadsFromTable(Mission.USN_Squad01)
	if (IsListenerActive("kill", "Listener_IowaWasDestroyed")) then
		RemoveListener("kill", "Listener_IowaWasDestroyed")
	end
	if (IsListenerActive("exitzone", "Listener_IowaExited")) then
		RemoveListener("exitzone", "Listener_IowaExited")
	end
	luaObj_Failed("primary", 2)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_IowaWasDestroyed): az Iowa megsemmisult, MISSION FAILED")
	luaUSN10_MissionFailed(pEntity, "usn10.obj_p2_fail")
end

------------------------------------------------------------------------------
function luaUSN10_InitHIDDEN01()
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		luaObj_Add("hidden", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitHIDDEN01): Hidden01 addolva")
	end
	--local nMaxSpeed = VehicleClass[Mission.JAP_HiddenTT[1].Class.ID].MaxSpeed
	--luaLog("TTShipSpeed (m/s)   = "..nMaxSpeed)
	--luaLog("TTShipSpeed (knots) = "..(nMaxSpeed * Mission.MPStoKTS))
	--[[for i, pUnit in pairs (Mission.JAP_HiddenDD) do
		SetShipMaxSpeed(pUnit, nMaxSpeed * Mission.MPStoKTS)
	end]]--
	-- TT01
	if (not Mission.JAP_HiddenTT[1].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenTT[1], Mission.JAP_PathHidden_TT01[1], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenTT[1], Mission.JAP_PathHidden_TT01[1])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_TT01[1], 2)
		Mission.JAP_HiddenTT[1].SoftKill = false
		Mission.JAP_HiddenTT[1].TriggerName = "TT01ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenTT[1], "TT01ReachedEndOfPath", "luaUSN10_TTReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- TT02
	if (not Mission.JAP_HiddenTT[2].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenTT[2], Mission.JAP_PathHidden_TT01[2], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenTT[2], Mission.JAP_PathHidden_TT01[2])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_TT01[2], 2)
		Mission.JAP_HiddenTT[2].SoftKill = false
		Mission.JAP_HiddenTT[2].TriggerName = "TT02ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenTT[2], "TT02ReachedEndOfPath", "luaUSN10_TTReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- TT03
	if (not Mission.JAP_HiddenTT[3].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenTT[3], Mission.JAP_PathHidden_TT01[1], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenTT[3], Mission.JAP_PathHidden_TT01[1])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_TT01[1], 2)
		Mission.JAP_HiddenTT[3].SoftKill = false
		Mission.JAP_HiddenTT[3].TriggerName = "TT03ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenTT[3], "TT03ReachedEndOfPath", "luaUSN10_TTReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- TT04
	if (not Mission.JAP_HiddenTT[4].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenTT[4], Mission.JAP_PathHidden_TT01[2], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenTT[4], Mission.JAP_PathHidden_TT01[2])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_TT01[2], 2)
		Mission.JAP_HiddenTT[4].SoftKill = false
		Mission.JAP_HiddenTT[4].TriggerName = "TT04ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenTT[4], "TT04ReachedEndOfPath", "luaUSN10_TTReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- DD01
	if (not Mission.JAP_HiddenDD[1].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenDD[1], Mission.JAP_PathHidden_DD01[1], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenDD[1], Mission.JAP_PathHidden_DD01[1])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_DD01[1], 2)
		Mission.JAP_HiddenDD[1].SoftKill = false
		Mission.JAP_HiddenDD[1].TriggerName = "DD01ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenDD[1], "DD01ReachedEndOfPath", "luaUSN10_DDReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- DD02
	if (not Mission.JAP_HiddenDD[2].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenDD[2], Mission.JAP_PathHidden_DD01[2], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenDD[2], Mission.JAP_PathHidden_DD01[2])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_DD01[2], 2)
		Mission.JAP_HiddenDD[2].SoftKill = false
		Mission.JAP_HiddenDD[2].TriggerName = "DD02ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenDD[2], "DD02ReachedEndOfPath", "luaUSN10_DDReachedEndOfPath", tFarthestPathPoint, 300)
	end
	-- DD03
	if (not Mission.JAP_HiddenDD[3].Dead) then	--checkpoint miatt kell
		NavigatorMoveOnPath(Mission.JAP_HiddenDD[3], Mission.JAP_PathHidden_DD01[3], 1, 5) --PATH_FM_SIMPLE, PATH_SM_JOIN)
		--local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(Mission.JAP_HiddenDD[3], Mission.JAP_PathHidden_DD01[3])
		local tFarthestPathPoint = luaGetPathPoint(Mission.JAP_PathHidden_DD01[3], 2)
		Mission.JAP_HiddenDD[3].SoftKill = false
		Mission.JAP_HiddenDD[3].TriggerName = "DD03ReachedEndOfPath"
		AddProximityTrigger(Mission.JAP_HiddenDD[3], "DD03ReachedEndOfPath", "luaUSN10_DDReachedEndOfPath", tFarthestPathPoint, 300)
	end
	
	local nMaxSpeed = VehicleClass[Mission.JAP_HiddenTT[1].Class.ID].MaxSpeed
	--nMaxSpeed = 11
	--luaLog("TTShipSpeed (m/s)   = "..nMaxSpeed)
	--luaLog("TTShipSpeed (knots) = "..(nMaxSpeed * Mission.MPStoKTS))
	for i, pUnit in pairs (Mission.JAP_HiddenDD) do
		SetShipMaxSpeed(pUnit, nMaxSpeed) --* Mission.MPStoKTS)
	end
	--TT
	for i, pUnit in pairs (Mission.JAP_HiddenTT) do
		SetShipMaxSpeed(pUnit, nMaxSpeed) --* Mission.MPStoKTS)
	end
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		AddListener("kill", "Listener_TTWasDestroyed", 
		{
				["callback"] = "luaUSN10_TTWasDestroyed",
				["entity"] = Mission.JAP_HiddenTT,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
		AddListener("kill", "Listener_DDWasDestroyed", 
		{
				["callback"] = "luaUSN10_DDWasDestroyed",
				["entity"] = Mission.JAP_HiddenDD,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		luaDelay(luaUSN10_InitReconListener_Hidden, 5)
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitSEC01()
	if (not luaObj_IsActive("secondary", 1)) then
		luaObj_Add("secondary", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitSEC01): Sec01 beregisztralva")
	end
	if (IsListenerActive("kill", "Listener_USNShipWasDestroyed")) then
		RemoveListener("kill", "Listener_USNShipWasDestroyed")
	end
	AddListener("kill", "Listener_USNShipWasDestroyed", 
	{
			["callback"] = "luaUSN10_USNShipWasDestroyed",
			["entity"] = Mission.USN_Units,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

------------------------------------------------------------------------------
function luaUSN10_USNShipWasDestroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_USNShipWasDestroyed): egy player unit megsemmisult, a SEC01-et bebuktad ocsi")
	--MissionNarrative("usn10.obj_s1_fail")
	--if (pEntity.Class.ID ~= 2) and (pEntity.Class.ID ~= 15) then	-- Iowa-Class es Yorktown-Class -> ezeknel nem jatszunk fanfart, mert Mission failed
	luaObj_Failed("secondary", 1, true)
	MissionNarrative("usn10.obj_s1_fail")
	if (IsListenerActive("kill", "Listener_USNShipWasDestroyed")) then
		RemoveListener("kill", "Listener_USNShipWasDestroyed")
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitReconListener_Hidden()
	AddListener("recon", "Listener_HiddenTTSpotted", {
		["callback"] = "luaUSN10_HiddenTTSpotted",  -- callback fuggveny
		["entity"] = Mission.JAP_HiddenTT, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

------------------------------------------------------------------------------
function luaUSN10_TTReachedEndOfPath(pEntity)
	RemoveTrigger(pEntity, pEntity.TriggerName)
	pEntity.SoftKill = true
	Kill(pEntity, true)
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1, true)
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_TTReachedEndOfPath): Hidden01 failed")
	end
end

------------------------------------------------------------------------------
function luaUSN10_DDReachedEndOfPath(pEntity)
	pEntity.SoftKill = true
	Kill(pEntity, true)
end

------------------------------------------------------------------------------
function luaUSN10_TTWasDestroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_TTWasDestroyed): 1 TT megsemmisult")
	pEntity.Dead = true
	RemoveTrigger(pEntity, pEntity.TriggerName)
	if (not pEntity.SoftKill) then
		Mission.DestroyedHiddenTT = Mission.DestroyedHiddenTT + 1
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_TTWasDestroyed): Kilott TT-k szama = "..Mission.DestroyedHiddenTT)
	--[[else
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_TTWasDestroyed): Hidden objective failed")
		luaObj_Failed("hidden", 1)]]--
	end
	if (Mission.DestroyedHiddenTT == 4) and (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_TTWasDestroyed): Hidden objective completed")
		--MissionNarrative("usn10.obj_h1_compl")
		luaObj_Completed("hidden", 1, true)
		luaUSN10_StartDialog("Hidden_Killed_01")
		luaUSN10_StartDialog("Hidden_Killed_02")
	end
	Mission.JAP_HiddenTT = luaRemoveDeadsFromTable(Mission.JAP_HiddenTT)
	if (table.getn(Mission.JAP_HiddenTT) == 0) and (IsListenerActive("kill", "Listener_TTWasDestroyed")) then
		RemoveListener("kill", "Listener_TTWasDestroyed")
	end
end

------------------------------------------------------------------------------
function luaUSN10_DDWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_HiddenDD = luaRemoveDeadsFromTable(Mission.JAP_HiddenDD)
	if (table.getn(Mission.JAP_HiddenDD) == 0) and (IsListenerActive("kill", "Listener_DDWasDestroyed")) then
		RemoveListener("kill", "Listener_DDWasDestroyed")
	end
end

------------------------------------------------------------------------------
function luaUSN10_HiddenTTSpotted()
	if (IsListenerActive("recon", "Listener_HiddenTTSpotted")) then
		RemoveListener("recon", "Listener_HiddenTTSpotted")
	end
	luaUSN10_StartDialog("Hidden_Located_01")
	luaUSN10_StartDialog("Hidden_Located_02")
	luaUSN10_StartDialog("Hidden_Located_03")
	luaUSN10_StartDialog("Hidden_Located_04")
end

------------------------------------------------------------------------------
function luaUSN10_AttackManager()
	local nRnd
	local nIndex
	local tFighterClassIDs = {}
	local tOtherClassIDs = {}
	local nPlaneLimit = 9	--veteran
	if (Mission.difficulty == 0) or (Mission.difficulty == 1) then	--rookie, regular
		nPlaneLimit = 6
	end
	
	Mission.JAP_Carriers = luaRemoveDeadsFromTable(Mission.JAP_Carriers)
	--Mission.JAP_Targets = luaRemoveDeadsFromTable(Mission.JAP_Targets)
	if (Mission.MissionPhase == 3) and (Mission.JAP_Carriers ~= nil) and (table.getn(Mission.JAP_Carriers) < 3) then
		if (Mission.difficulty == 2) then
			nPlaneLimit = 12
		elseif (Mission.difficulty == 1) then
			nPlaneLimit = 9
		end
	end
	
	if (Mission.MissionCounter < Mission.KamikazeTime) then
		--GetAirBaseSlotStatus(airbaseEnt, slotIndex)
		--[[SetAirBasePlaneLimit(Mission.JAP_Carriers[1], 12)
		SetAirBasePlaneLimit(Mission.JAP_Carriers[2], 12)]]--
-- RELEASE_LOGOFF  		luaLog("PlaneLimit = "..nPlaneLimit)
		for i, pUnit in pairs (Mission.JAP_Carriers) do
			if (nPlaneLimit == 12) then
-- RELEASE_LOGOFF  				luaLog("AirBaseSlotCount = 4")
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 4)
			elseif (nPlaneLimit == 9) then
-- RELEASE_LOGOFF  				luaLog("AirBaseSlotCount = 3")
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 3)
			elseif (nPlaneLimit == 6) then
-- RELEASE_LOGOFF  				luaLog("AirBaseSlotCount = 2")
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 2)
			else
-- RELEASE_LOGOFF  				luaLog("AirBaseSlotCount = nincs allitva")
			end
			SetAirBasePlaneLimit(Mission.JAP_Carriers[i], nPlaneLimit)
		end
		--tFighterClassIDs[1] = 151 -- Raiden
		tFighterClassIDs[1] = 150 -- Zero
		tOtherClassIDs[1] = 159 -- Judy
		tOtherClassIDs[2] = 163 -- Jill
	else
		--[[SetAirBasePlaneLimit(Mission.JAP_Carriers[1], 20)
		SetAirBasePlaneLimit(Mission.JAP_Carriers[2], 20)]]--
		--tFighterClassIDs[1] = 151 -- Raiden
		tFighterClassIDs[1] = 150 -- Zero
		if (Mission.MissionPhase < 3) then
			if (Mission.difficulty == 1) or (Mission.difficulty == 2) then
				tOtherClassIDs[1] = 45 -- Zero Kamikaze
				tOtherClassIDs[2] = 46 -- Val Kamikaze
				--[[if (Mission.difficulty == 2) then
					nPlaneLimit = 15
				end]]--
			else
				tOtherClassIDs[1] = 45 -- Zero Kamikaze Modified
				tOtherClassIDs[2] = 46 -- Val Kamikaze Modified
			end
		else
			--nPlaneLimit = 12
			tOtherClassIDs[1] = 159 -- Judy
			if (Mission.difficulty == 1) or (Mission.difficulty == 2) then
				tOtherClassIDs[2] = 46 -- Val Kamikaze
			else
				tOtherClassIDs[2] = 46 -- Val Kamikaze Modified
			end
		end
		for i, pUnit in pairs (Mission.JAP_Carriers) do
			if (nPlaneLimit == 12) then
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 4)
			elseif (nPlaneLimit == 9) then
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 3)
			elseif (nPlaneLimit == 6) then
				SetAirBaseSlotCount(Mission.JAP_Carriers[i], 2)
			end
			SetAirBasePlaneLimit(Mission.JAP_Carriers[i], nPlaneLimit)
		end
		--[[if (not Mission.Narrative04) then		-> mar nem irok ki MissionNarrative-ot, csak dialogot hasznalok helyette
			Mission.Narrative04 = true
			MissionNarrative(Mission.Narratives[4])
-- RELEASE_LOGOFF  			luaLog("elindultak a kamikaze gepek az Iowa-t tamadni")
		end]]--
	end
	Mission.PlaneWaves = Mission.PlaneWaves + 1
	for i, pUnit in pairs (Mission.JAP_Carriers) do
		--[[nRnd = luaRnd(0, 100)
		if (nRnd < 50) then
			nIndex = 1
		else
			nIndex = 2
		end]]--
		local pTarget = luaPickRnd(Mission.JAP_Targets)
		--[[if (pTarget == nil) then
-- RELEASE_LOGOFF  			luaLog("pTarget = nil")
		else
-- RELEASE_LOGOFF  			luaLog("pTarget = "..pTarget.Name)
		end]]--
		if (Mission.JOURNALIST_VERSION) then
			if (Mission.MissionCounter < Mission.KamikazeTime) then --or (Mission.MissionPhase > 2) then
				luaCapManager(pUnit, tFighterClassIDs, 2)
			end
		end
		luaAirfieldManager(pUnit, tFighterClassIDs, tOtherClassIDs, Mission.JAP_Targets) --{Mission.USN_Squad01[nIndex]})
		if (table.getn(Mission.JAP_Targets) > 0) then
			local nActiveSquads, tEntities = luaGetSlotsAndSquads(pUnit)
			for j, pEntity in pairs (tEntities) do
				local pPlaneTarget = luaGetScriptTarget(pEntity)
				if (pPlaneTarget ~= nil) and (pPlaneTarget.Dead) then
					pPlaneTarget = nil
				end
				--luaLog("Type = "..VehicleClass[pEntity.Class.ID].Type)
				if (VehicleClass[pEntity.Class.ID].Type == "Fighter") and (pPlaneTarget == nil) then
					pPlaneTarget = luaPickRnd(Mission.JAP_Targets)
					--[[if (pPlaneTarget == nil) then
-- RELEASE_LOGOFF  						luaLog("pPlaneTarget = nil")
					else
-- RELEASE_LOGOFF  						luaLog("pPlaneTarget = "..pPlaneTarget.Name)
					end]]--
					SquadronSetAttackAlt(pEntity, 150)
					PilotSetTarget(pEntity, pPlaneTarget)
				elseif (VehicleClass[pEntity.Class.ID].Type == "Kamikaze") then
					SquadronSetTravelAlt(pEntity, 800)
					SquadronSetAttackAlt(pEntity, 300)
					local pKamikazeTarget = UnitGetAttackTarget(pEntity)
					local bStartDialog_Attack = false
					local bStartDialog_Hit = false
					if (pKamikazeTarget ~= nil) then
						if (luaGetDistance(pEntity, pKamikazeTarget) < 200) then
							bStartDialog_Hit = true
						elseif (luaGetDistance(pEntity, pKamikazeTarget) < 1000) then
							bStartDialog_Attack = true
						end
					end
					if (Mission.FinalDialogues["Kamikaze_Attack_01"].printed == nil) and (bStartDialog_Attack) then
						luaUSN10_Dialog_KamikazeAttack()
					end
					if (Mission.FinalDialogues["Kamikaze_Hit_01"].printed == nil) and (bStartDialog_Hit) then
						luaUSN10_Dialog_KamikazeHit()
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_Dialog_KamikazeAttack()
	luaUSN10_StartDialog("Kamikaze_Attack_01")
	if (Mission.JOURNALIST_VERSION) then
		luaDelay(luaUSN10_HintKamikaze, 8)
	end
end

------------------------------------------------------------------------------
function luaUSN10_HintKamikaze()
	ShowHint("USN10_Hint_Kamikaze")
end

------------------------------------------------------------------------------
function luaUSN10_Dialog_KamikazeHit()
	luaUSN10_StartDialog("Kamikaze_Hit_01")
	luaUSN10_StartDialog("Kamikaze_Hit_02")
	luaUSN10_StartDialog("Kamikaze_Hit_03")
	luaUSN10_StartDialog("Kamikaze_Hit_04")
	luaUSN10_StartDialog("Kamikaze_Hit_05")
end

------------------------------------------------------------------------------
function luaUSN10_StartingPhase2()
	Mission.MissionPhase = 2
	Mission.FirstRun = true
	--luaCheckpoint(1, nil)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_SquadSouthShipWasDestroyed): CHECKPOINT01 ELMENTVE")
-- RELEASE_LOGOFF  	luaLog("Phase2 indul")
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_SavePositions()
	local tUSUnits = luaGetOwnUnits("ship", PARTY_ALLIED)
	local tPosTable = {}
	for i, pUnit in pairs (tUSUnits) do
		if (not pUnit.Dead) then
			local nPos = GetPosition(pUnit)
			local nRot = GetRotation(pUnit)
			table.insert(tPosTable, {pUnit.Name, nPos, nRot})
		end
	end
	Mission.Checkpoint.USNPositions = tPosTable
	local tIJNUnits = luaGetOwnUnits("ship", PARTY_JAPANESE)
	local tPosTable = {}
	for i, pUnit in pairs (tIJNUnits) do
		if (not pUnit.Dead) then
			local nPos = GetPosition(pUnit)
			local nRot = GetRotation(pUnit)
			table.insert(tPosTable, {pUnit.Name, nPos, nRot})
		end
	end
	Mission.Checkpoint.IJNPositions = tPosTable
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_CleaningAndPutToPosition()
-- RELEASE_LOGOFF  	luaLog("------CHECKPOINT01: A unitok takaritasa es pozicionalasa kezdodik...------")
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_Checkpoint01_CleaningAndPutToPosition): USN Unitok")
	local tUSNUnits = luaGetCheckpointData("Units", "USUnits")
	tUSNUnits = tUSNUnits[1]
	--luaLog("(luaUSN10_Checkpoint01_CleaningAndPutToPosition): table hossz = "..table.getn(tUSNUnits))
	
	-- Mission.USN_Units tabla kitakaritasa
	for i, pShip in pairs (Mission.USN_Units) do
		local bIsUnitAlive, j = luaUSN10_Checkpoint01_SearchInTable(pShip.Name, tUSNUnits)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN10_Checkpoint01_GetUnitPos(pShip.Name, Mission.CP_USNPositions)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
	Mission.USN_Units = luaRemoveDeadsFromTable(Mission.USN_Units)
	Mission.USN_Squad01 = luaRemoveDeadsFromTable(Mission.USN_Squad01)
	
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_Checkpoint01_CleaningAndPutToPosition): IJN Unitok")
	local tIJNUnits = luaGetCheckpointData("Units", "JapUnits")
	tIJNUnits = tIJNUnits[1]
	
	--Kezdo japan repulok	
	for i, pPlane in pairs (Mission.JAP_StartingPlanes) do
		Kill(pPlane, true)
	end
	Mission.JAP_StartingPlanes = luaRemoveDeadsFromTable(Mission.JAP_StartingPlanes)
	if (Mission.ENABLE_DUMMYSHIP) then
		Kill(Mission.DummyShip[1], true)
		Kill(Mission.DummyPlanes[1], true)
	end

	-- Eszaki carrier es groupja
	for i, pShip in pairs (Mission.JAP_SquadNorth) do
		local bIsUnitAlive, j = luaUSN10_Checkpoint01_SearchInTable(pShip.Name, tIJNUnits)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN10_Checkpoint01_GetUnitPos(pShip.Name, Mission.CP_IJNPositions)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
	Mission.JAP_SquadNorth = luaRemoveDeadsFromTable(Mission.JAP_SquadNorth)
	Mission.JAP_SquadNorthAttackers = luaRemoveDeadsFromTable(Mission.JAP_SquadNorthAttackers)
	Mission.JAP_Carriers = luaRemoveDeadsFromTable(Mission.JAP_Carriers)
	Mission.JAP_Targets = luaRemoveDeadsFromTable(Mission.JAP_Targets)
	
	-- Hidden Unitok
	-- Transport hajok
	for i, pShip in pairs (Mission.JAP_HiddenTT) do
		local bIsUnitAlive, j = luaUSN10_Checkpoint01_SearchInTable(pShip.Name, tIJNUnits)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN10_Checkpoint01_GetUnitPos(pShip.Name, Mission.CP_IJNPositions)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
	-- Transport kisero hajok
	for i, pShip in pairs (Mission.JAP_HiddenDD) do
		local bIsUnitAlive, j = luaUSN10_Checkpoint01_SearchInTable(pShip.Name, tIJNUnits)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN10_Checkpoint01_GetUnitPos(pShip.Name, Mission.CP_IJNPositions)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
	luaUSN10_InitHIDDEN01()
	
	-- Aknak
	luaUSN10_Checkpoint_LoadMines(Mission.Checkpoint.DeadMines)
	SetSelectedUnit(Mission.USN_Iowa[1])
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_SearchInTable(szName, tTable)
	local j = 0
	local bIsUnitAlive = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUSN10_Checkpoint01_SearchInTable): szName = "..szName)
	--luaLog("(luaUSN10_Checkpoint01_SearchInTable): table hossz = "..nLength)
	while (j < nLength) and (not bIsUnitAlive) do
		j = j + 1
		--luaLog("(luaUSN10_Checkpoint01_SearchInTable): US tablaban az akt nev = "..tTable[j].Name)
		--luaLog(tTable[j][1])
		if (szName == tTable[j][1]) then
			bIsUnitAlive = true
		end
	end
	--luaLog("(luaUSN10_Checkpoint01_SearchInTable): Visszatero boolean = ")
	--luaLog(bIsUnitAlive)
	return bIsUnitAlive, j
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_GetUnitPos(szName, tTable)
	local j = 0
	local bFound = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUSN10_Checkpoint01_GetUnitPos): Table hossz = ")
	--luaLog(nLength)
	while (j < nLength) and (not bFound) do
		j = j + 1
		if (szName == tTable[j][1]) then
			bFound = true
		end
	end
	return tTable[j][2], tTable[j][3]
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_Listeners()
	if (not IsListenerActive("kill", "Listener_IowaWasDestroyed")) then
		AddListener("kill", "Listener_IowaWasDestroyed", 
		{
				["callback"] = "luaUSN10_IowaWasDestroyed",
				["entity"] = Mission.USN_Iowa,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_Checkpoint01_Listeners): Listener_IowaWasDestroyed addolva")
	end
	if (not IsListenerActive("exitzone", "Listener_IowaExited")) then
		AddListener("exitzone", "Listener_IowaExited", 
		{
				["callback"] = "luaUSN10_IowaWasDestroyed",
				["entity"] = Mission.USN_Iowa,
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	end
	if (not IsListenerActive("kill", "Listener_USNShipWasDestroyed")) then
		AddListener("kill", "Listener_USNShipWasDestroyed", 
		{
				["callback"] = "luaUSN10_USNShipWasDestroyed",
				["entity"] = Mission.USN_Units,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_Checkpoint01_Listeners): Listener_USNShipWasDestroyed addolva")
	end
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint01_Formations()
	-- USN formations
	if (table.getn(Mission.USN_Squad01) > 1) then
		JoinFormation(Mission.USN_Squad01[2], Mission.USN_Squad01[1])
	end
end

------------------------------------------------------------------------------
function luaUSN10_HintDDJournalist()
	if (not Mission.HintDDJournalist) then
		local pUnit = GetSelectedUnit()
		if (pUnit ~= nil) and (VehicleClass[pUnit.Class.ID].Type == "Destroyer") then
			Mission.HintDDJournalist = true
			luaDelay(luaUSN10_HintTorpedo_1, 3)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_HintTorpedo_1()
	ShowHint("USN10_Hint_Torpedo_1")
end

------------------------------------------------------------------------------
function luaUSN10_HintTorpedoJournalist()
	if (not Mission.HintTorpedoJournalist) then
		for i, pUnit in pairs (Mission.USN_Squad02_DD) do
			local nMaxTorpedos = pUnit.Class.MaxTorpedoStock
			local nActTorpedos = GetProperty(pUnit, "TorpedoStock")
			--luaLog("TorpedoCheck: Name = "..pUnit.Name..", MaxTorpedos = "..nMaxTorpedos..", Torpedos Left = "..nActTorpedos)
			if (nActTorpedos < nMaxTorpedos) then
				Mission.HintTorpedoJournalist = true
				luaDelay(luaUSN10_HintTorpedo_2, 3)
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_HintTorpedo_2()
	ShowHint("USN10_Hint_Torpedo_2")
end

------------------------------------------------------------------------------
function luaUSN10_InitPhase2()
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPhase2): Generating Squad02 for Phase02")
	Mission.Phase2Started = true
	local tPlaneNumbers = {15, 9, 15, 12, 9, 9}
	if (Mission.JOURNALIST_VERSION) then
		tPlaneNumbers[1] = 24
		tPlaneNumbers[2] = 18
		tPlaneNumbers[3] = 24
		tPlaneNumbers[4] = 18
		tPlaneNumbers[5] = 15
		tPlaneNumbers[6] = 15
	end
	local tUnit
	local pUnit
	local pLeader
	--USN units
	tUnit = luaFindHidden("Yorktown-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_enterprise")
	table.insert(Mission.USN_Squad02, pUnit)
	table.insert(Mission.USN_Enterprise, pUnit)
	table.insert(Mission.USN_Units, pUnit)
	table.insert(Mission.JAP_Targets, pUnit)
	RemoveAllAirBasePlanes(Mission.USN_Enterprise[1])
	--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	------ korabbi valtozat -------
	-- Hellcat
	AddAirBasePlanes(Mission.USN_Enterprise[1], 26, tPlaneNumbers[1])
	-- Dauntless	
	--AddAirBasePlanes(Mission.USN_Enterprise[1], 108, tPlaneNumbers[2])
	-------------------------------
	-- Helldiver
	AddAirBasePlanes(Mission.USN_Enterprise[1], 38, tPlaneNumbers[2])
	-- a kov. if csak debug miatt volt bent
	--if (Mission.UnlockLvl ~= nil ) and (Mission.UnlockLvl > 2) then --(Mission.UnlockLvl > 1) then
	--if (Scoring_IsUnlocked("US09_GOLD")) then
		-- Avenger Tiny Tim
		--if (Mission.UnlockLvl > 2) then
			-- Avenger Tiny Tim
			--AddAirBasePlanes(Mission.USN_Enterprise[1], 16, tPlaneNumbers[4])
			-- Hellcat
			--tPlaneNumbers[1] = 24
			--AddAirBasePlanes(Mission.USN_Enterprise[1], 26, tPlaneNumbers[1])
		--end
	--else
		-- Hellcat
		--AddAirBasePlanes(Mission.USN_Enterprise[1], 26, tPlaneNumbers[1])
	--end
	-- Avenger
	AddAirBasePlanes(Mission.USN_Enterprise[1], 113, tPlaneNumbers[3])
	tUnit = luaFindHidden("Fletcher-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_izard")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	table.insert(Mission.USN_Squad02, pUnit)
	table.insert(Mission.USN_Squad02_DD, pUnit)
	table.insert(Mission.USN_Units, pUnit)
	--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	tUnit = luaFindHidden("Fletcher-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_charrette")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	pLeader = pUnit
	table.insert(Mission.USN_Squad02, pUnit)
	table.insert(Mission.USN_Squad02_DD, pUnit)
	table.insert(Mission.USN_Units, pUnit)
	tUnit = luaFindHidden("Fletcher-class 03")
	--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_conner")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	table.insert(Mission.USN_Squad02, pUnit)
	table.insert(Mission.USN_Squad02_DD, pUnit)
	table.insert(Mission.USN_Units, pUnit)
	--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
	--IJN Units
	tUnit = luaFindHidden("Mogami-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_tama")
	if IsClassChanged(pUnit.ClassID) then
		luaSetUnlockName(pUnit)
	end
	table.insert(Mission.JAP_SquadSouth, pUnit)
	luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
	--local nSpeed = VehicleClass[Mission.JAP_SquadSouth[1].Class.ID].MaxSpeed
	if (Mission.JOURNALIST_VERSION) then
		tUnit = luaFindHidden("Minekaze-class 01")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_akikaze")
		table.insert(Mission.JAP_SquadSouth, pUnit)
		--SetShipMaxSpeed(pUnit, nSpeed * Mission.MPStoKTS)
		JoinFormation(pUnit, Mission.JAP_SquadSouth[1])
		--luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
		--NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
		if (Mission.difficulty == 0) then
			TorpedoEnable(pUnit, false)
		else
			TorpedoEnable(pUnit, true)
		end
		
		tUnit = luaFindHidden("Minekaze-class 02")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_sugi")
		table.insert(Mission.JAP_SquadSouth, pUnit)
		JoinFormation(pUnit, Mission.JAP_SquadSouth[1])
		--SetShipMaxSpeed(pUnit, nSpeed * Mission.MPStoKTS)
		--luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
		--NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
		if (Mission.difficulty == 0) or (Mission.difficulty == 1) then
			TorpedoEnable(pUnit, false)
		else
			TorpedoEnable(pUnit, true)
		end
		
	else
		tUnit = luaFindHidden("Tone-class 01")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_oyodo")
		table.insert(Mission.JAP_SquadSouth, pUnit)
		luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
		NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
		--a kovetkezot mar kitoroltem a scn file-bol, ha megis kell, akkor ujra lerakni, de nevet is kell neki keresni
		--[[tUnit = luaFindHidden("Tone-class 02")
		pUnit = GenerateObject(tUnit.Name, "Tone-class 02")
		table.insert(Mission.JAP_SquadSouth, pUnit)
		luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
		NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})]]--
	end
	Mission.JAP_SquadSouthNumber = table.getn(Mission.JAP_SquadSouth)
	for i, pUnit in pairs (Mission.JAP_SquadSouth) do
		if (Mission.difficulty == 0) then
			SetSkillLevel(pUnit, SKILL_SPNORMAL)
		else
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end
	end
	
	if (Mission.JOURNALIST_VERSION) then
		--playernek cruiser
		tUnit = luaFindHidden("Northampton-class 01")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_boston")
		table.insert(Mission.USN_Squad02, pUnit)
		table.insert(Mission.USN_Units, pUnit)
		SetCatapultStock(pUnit, 0)
		--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
		--if (Scoring_IsUnlocked("US09_GOLD")) then
			tUnit = luaFindHidden("Northampton-class 02")
			pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_chester")
			table.insert(Mission.USN_Squad02, pUnit)
			table.insert(Mission.USN_Units, pUnit)
			SetCatapultStock(pUnit, 0)
		--end
		--playernek destroyer
		tUnit = luaFindHidden("Fletcher-class 04")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_bell")
		if IsClassChanged(pUnit.ClassID) then
			luaSetUnlockName(pUnit)
		end
		table.insert(Mission.USN_Squad02, pUnit)
		table.insert(Mission.USN_Squad02_DD, pUnit)
		table.insert(Mission.USN_Units, pUnit)
		--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
		tUnit = luaFindHidden("Fletcher-class 05")
		pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_burns")
		if IsClassChanged(pUnit.ClassID) then
			luaSetUnlockName(pUnit)
		end
		table.insert(Mission.USN_Squad02, pUnit)
		table.insert(Mission.USN_Squad02_DD, pUnit)
		table.insert(Mission.USN_Units, pUnit)
		--SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_AI)
		--japo crew level gyengebbre
		for i, pUnit in pairs (Mission.JAP_SquadSouth) do
			--SetCrewLevel(pUnit, 0)
			--SetSkillLevel(pUnit, SKILL_STUN)
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end
		--[[for i, pUnit in pairs (Mission.USN_Squad02) do
			--SetCrewLevel(pUnit, 2)
			SetSkillLevel(pUnit, SKILL_SPVETERAN)
		end]]--
	end
	
	for i, pUnit in pairs (Mission.USN_Squad02) do
		if (pUnit.Name ~= pLeader.Name) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN10_InitPhase2): JoinFormation -> Act Unit = "..pUnit.Name.." (Leader = "..pLeader.Name..")")
			JoinFormation(pUnit, pLeader)
		else
-- RELEASE_LOGOFF  			luaLog("(luaUSN10_InitPhase2):  Nem volt JoinFormation -> ActUnit = "..pUnit.Name.." (Leader = "..pLeader.Name..")")
		end
	end
	--NavigatorMoveToRange(pLeader, Mission.USN_NavpointPlayerStart[2])
	NavigatorCruise(pLeader)
	--SetShipSpeed(pLeader, 14)
	if (luaObj_GetSuccess("secondary", 1) == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitPhase2): Sec01 meg nem teljesult, listener ujra addolva")
		luaUSN10_InitSEC01()
	end
	
	luaUSN10_InitSquadSouth()
	
	luaDelay(luaUSN10_InitPri03, 6)
	luaUSN10_StartDialog("Allied_Carrier_01")
	luaUSN10_StartDialog("Allied_Carrier_02")
	
	--luaDelay(luaUSN10_HintEnterprise, 15)
	
	--[[if (Mission.JOURNALIST_VERSION) then
		luaDelay(luaUSN10_JournalistHint_SupportManager, 15)
	end]]--
	
	--luaDelay(luaUSN10_DialogWarshipAttack, 30)
	luaDelay(luaUSN10_EM02_Preparing, 30)
end

------------------------------------------------------------------------------
function luaUSN10_HintEnterprise()
	ShowHint("USN10_Hint_Enterprise")
end

------------------------------------------------------------------------------
function luaUSN10_DialogWarshipAttack()
	--[[if (Mission.JOURNALIST_VERSION) then
		luaDelay(luaUSN10_HintCruisers, 8)
	end]]--
	luaUSN10_StartDialog("Warship_Attack_01")
	luaUSN10_StartDialog("Warship_Attack_02")
	luaUSN10_StartDialog("Warship_Attack_03")
end

------------------------------------------------------------------------------
function luaUSN10_HintCruisers()
	ShowHint("USN10_Hint_Cruisers")
end

------------------------------------------------------------------------------
function luaUSN10_InitSquadSouth()
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitSquadSouth): A SquadSouth listener-e addolva. JAP_SquadSouth Length = "..table.getn(Mission.JAP_SquadSouth))
	if (not IsListenerActive("kill", "Listener_SquadSouthShipWasDestroyed")) then
		AddListener("kill", "Listener_SquadSouthShipWasDestroyed", 
		{
				["callback"] = "luaUSN10_SquadSouthShipWasDestroyed",
				["entity"] = Mission.JAP_SquadSouth,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN10_SquadSouthShipWasDestroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_SquadSouthShipWasDestroyed): SquadSouth-bol megsemmisult egy hajo")
	if (pEntity ~= nil) then
		pEntity.Dead = true
	end
	Mission.JAP_SquadSouth = luaRemoveDeadsFromTable(Mission.JAP_SquadSouth)
	if (table.getn(Mission.JAP_SquadSouth) == 0) then
		RemoveListener("kill", "Listener_SquadSouthShipWasDestroyed")
		Mission.MissionPhase = 3
		Mission.FirstRun = true
	end
	if table.getn(Mission.JAP_SquadSouth) == Mission.JAP_SquadSouthNumber -2 then
		AddPowerup(
	{
			["classID"] = "radar_sweep",
			["useLimit"] = 1,
	})
	end
end

------------------------------------------------------------------------------
function luaUSN10_EM02_Preparing()
	Blackout(true, "luaUSN10_EM02", 2, 1)
end

------------------------------------------------------------------------------
function luaUSN10_EM02()
	Blackout(true, "", 3, 0)
	--[[if (table.getn(Mission.JAP_SquadSouth) > 0) then
		luaJumpinMovieSetCurrentMovie("GoAround", Mission.JAP_SquadSouth[1].ID)
	end]]--
	luaSetPartyInvincible(1, PARTY_ALLIED)
	Mission.EMLastSelected = GetSelectedUnit()
	EnableMessages(false)	-- EM miatt
	luaDelay(luaUSN10_DialogWarshipAttack, 2)
	BlackBars(true)
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	Mission.EMPlaying = true
	--HideUnitHP()
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Enterprise[1], ["distance"] = 180, ["theta"] = 5, ["rho"] = 190, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_Enterprise[1], ["distance"] = 180, ["theta"] = 5, ["rho"] = 190, ["moveTime"] = 8, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_SquadSouth[1], ["distance"] = 200, ["theta"] = 5, ["rho"] = 10, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_SquadSouth[1], ["distance"] = 450, ["theta"] = 5, ["rho"] = 70, ["moveTime"] = 8, ["smoothtime"] = 2},
	},
	luaUSN10_EM02_PreparingEnd,
	true, nil, false)
		
	--luaDelay(luaUSN10_EM02_StartingBlackout_End, 0.5)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_EM02): EM02 lejatszodott")
end

------------------------------------------------------------------------------
function luaUSN10_EM02_StartingBlackout_End()
	Blackout(false, "", 1)
end

------------------------------------------------------------------------------
function luaUSN10_EM02_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN10_EM02_End_BlackOut", 3)
end

------------------------------------------------------------------------------
function luaUSN10_EM02_End_BlackOut()
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
	--TODO: lekerdezni EM elott hogy melyikben ul a player es EM utan arra visszavaltani
	--[[for i, pUnit in pairs (Mission.USN_Squad02) do
		SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_1)
	end]]--
	
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN10_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		else
			SetSelectedUnit(Mission.USN_Iowa[1])
		end
	end
	EnableInput(true)
	Mission.EMPlaying = false
	DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
	luaUSN10_DisplayHP()
	--DisplayUnitHP(Mission.USN_Iowa)
	Blackout(false, "luaUSN10_EM02_End", 3)
end

------------------------------------------------------------------------------
function luaUSN10_EM02_End()
	EnableMessages(true)
	luaSetPartyInvincible(0, PARTY_ALLIED)
	if (Mission.JOURNALIST_VERSION) then
		luaDelay(luaUSN10_JournalistHint_SupportManager, 15)
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitPri03()
	if (not luaObj_IsActive("primary", 3)) then
		luaObj_Add("primary", 3, Mission.USN_Enterprise)
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitPri03): Pri03 ojjekt addolva")
		luaDelay(luaUSN10_HintEnterprise, 3)
		--TODO: lecserelni a jumpin EM-et IngameEM-re
		--luaJumpinMovieSetCurrentMovie("GoAround", Mission.USN_Enterprise[1].ID)
	end
	if (not IsListenerActive("kill", "Listener_EnterpriseWasDestroyed")) then
		AddListener("kill", "Listener_EnterpriseWasDestroyed", 
		{
				["callback"] = "luaUSN10_EnterpriseWasDestroyed",
				["entity"] = Mission.USN_Enterprise,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (not IsListenerActive("exitzone", "Listener_EnterpriseExited")) then
		AddListener("exitzone", "Listener_EnterpriseExited", 
		{
				["callback"] = "luaUSN10_EnterpriseWasDestroyed",
				["entity"] = Mission.USN_Enterprise,
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	end
end

------------------------------------------------------------------------------
function luaUSN10_JournalistHint_SupportManager()
	ShowHint("USN10_Hint_Support_1")
	luaDelay(luaUSN10_JournalistHint_SupportManager, 16)
end

------------------------------------------------------------------------------
function luaUSN10_JournalistHint_SupportManager()
	ShowHint("USN10_Hint_Support_2")
end

------------------------------------------------------------------------------
function luaUSN10_EnterpriseWasDestroyed(pEntity)
	Mission.USN_Enterprise[1].Dead = true
	luaObj_Failed("primary", 3)
	luaUSN10_MissionFailed(pEntity, "usn10.obj_p3_fail")
end

------------------------------------------------------------------------------
function luaUSN10_CheckMineSurroundings()
	if (not Mission.Narrative05) then
		local tPos
		for i, pUnit in pairs (Mission.USN_Units) do
			tPos = GetPosition(pUnit)
			if (tPos["x"] > Mission.JAP_MineField01["x1"] and tPos["x"] < Mission.JAP_MineField01["x2"] and tPos["z"] > Mission.JAP_MineField01["z1"] and tPos["z"] < Mission.JAP_MineField01["z2"]) and (not Mission.DialogMineField01) then 
				--MissionNarrative(Mission.Narratives[5])
				SetVisibilityTerrainNode("usn10_cape_engano:mapzone", true)
				Mission.DialogMineField01 = true
				KillDialog("Minefield_01")
				Mission.FinalDialogues["Minefield_01"].printed = false
				KillDialog("Minefield_02")
				Mission.FinalDialogues["Minefield_02"].printed = false
				luaUSN10_StartDialog("Minefield_01")
				luaUSN10_StartDialog("Minefield_02")
				if (Mission.JOURNALIST_VERSION) then
					luaDelay(luaUSN10_HintMinefield, 5)
				end
				--luaJumpinMovieSetCurrentMovie("GoAround", Mission.JAP_MineField_EM[1].ID)
				--[[luaLog("--Minefield01--")
-- RELEASE_LOGOFF  				luaLog("x  = "..tPos["x"]..", z  = "..tPos["z"])
-- RELEASE_LOGOFF  				luaLog("x1 = "..Mission.JAP_MineField01["x1"]..", z1 = "..Mission.JAP_MineField01["z1"])
-- RELEASE_LOGOFF  				luaLog("x2 = "..Mission.JAP_MineField01["x2"]..", z2 = "..Mission.JAP_MineField01["z2"])]]--
			elseif (tPos["x"] > Mission.JAP_MineField02["x1"] and tPos["x"] < Mission.JAP_MineField02["x2"] and tPos["z"] > Mission.JAP_MineField02["z1"] and tPos["z"] < Mission.JAP_MineField02["z2"]) and (not Mission.DialogMineField02) then
				SetVisibilityTerrainNode("usn10_cape_engano:mapzone", true)
				Mission.DialogMineField02 = true
				KillDialog("Minefield_01")
				Mission.FinalDialogues["Minefield_01"].printed = false
				KillDialog("Minefield_02")
				Mission.FinalDialogues["Minefield_02"].printed = false
				luaUSN10_StartDialog("Minefield_01")
				luaUSN10_StartDialog("Minefield_02")
				if (Mission.JOURNALIST_VERSION) then
					luaDelay(luaUSN10_HintMinefield, 8)
				end
				--luaJumpinMovieSetCurrentMovie("GoAround", Mission.JAP_MineField_EM[2].ID)
				--[[luaLog("--Minefield02--")
-- RELEASE_LOGOFF  				luaLog("x  = "..tPos["x"]..", z  = "..tPos["z"])
-- RELEASE_LOGOFF  				luaLog("x1 = "..Mission.JAP_MineField02["x1"]..", z1 = "..Mission.JAP_MineField02["z1"])
-- RELEASE_LOGOFF  				luaLog("x2 = "..Mission.JAP_MineField02["x2"]..", z2 = "..Mission.JAP_MineField02["z2"])]]--
			end
		end
		if (Mission.DialogMineField01 and Mission.DialogMineField02) then
			Mission.Narrative05 = true
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_HintMinefield()
	ShowHint("USN10_Hint_Minefield")
end

------------------------------------------------------------------------------
function luaUSN10_InitJapaneseCarriersKillListener_Phase1()
	if (not IsListenerActive("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1")) then
		AddListener("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1", 
		{
				["callback"] = "luaUSN10_JapaneseCarrierWasDestroyed_Phase1",
				["entity"] = Mission.JAP_Carriers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN10_JapaneseCarrierWasDestroyed_Phase1(pEntity)
	local nSquadNum
	pEntity.Dead = true
	Mission.JAP_Carriers = luaRemoveDeadsFromTable(Mission.JAP_Carriers)
	luaUSN10_StartDialog("Carrier_Destroyed_01")
	luaUSN10_StartDialog("Carrier_Destroyed_02")
	Mission.CarrierCounter = Mission.CarrierCounter - 1
	if (Mission.CarrierCounter == 0) then
		HideScoreDisplay(1, 0)
	else
		DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
	end
	if (not Mission.PowerUp) then
		Mission.PowerUp = true
		AddPowerup(
		{
				["classID"] = "improved_repair_team",
				["useLimit"] = 1,
		})
		--MissionNarrative(Mission.Narratives[7])
	end
	if (table.getn(Mission.JAP_Carriers) == 0) and (IsListenerActive("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1")) then
		RemoveListener("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1")
		Mission.JAP_ActivePlaneSquadsCarrier01 = luaGetOwnUnits("plane", PARTY_JAPANESE)
		luaDelay(luaUSN10_StartingPhase2, 10)
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitPhase3_ver2()	--TODO: jelenleg nem hasznalom, megoldottam mashogy. Ha nem kell, torolni!
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPhase3): Phase3-hoz a SquadWest generalasa")
	local tShipClass = {57, 53, 14, 14, 14}
	local szShipName = ""
	local tSpawnPos = GetPosition(Mission.JAP_SpawnPoints[1])
	local tLookAtPos = GetPosition(Mission.USN_SpawnPoints[1])
	for i = 1, table.getn(tShipClass) do
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitPhase3): Generalas "..i)
		if (i == 1) then
			szShipName = "Amagi"
		elseif (i == 2) then
			szShipName = "Zuikaku"
		else
			szShipName = "Akizuki0"..i
		end
		SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = tShipClass[i],
						["Name"] = szShipName,
						["Crew"] = 2,
						["Race"] = JAPANESE,
					},
				},
				["area"] = {
					["refPos"] = tSpawnPos,
					["angleRange"] = {DEG(0),DEG(180)},
					["lookAt"] = tLookAtPos,
		
				},
				["callback"] = "luaUSN10_SquadWestShipGenerated",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 400,
				},
			})
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_InitPhase3): Generalas Vege"..i)
	end
end

------------------------------------------------------------------------------
function luaUSN10_SquadWestShipGenerated(pEntity)		--TODO: jelenleg nem hasznalom, megoldottam mashogy. Ha nem kell, torolni!
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_SquadWestShipGenerated): "..pEntity.Name)
	if (pEntity.Type == "CARRIER") then
		--Mission.CarrierCounter = Mission.CarrierCounter + 1
		pEntity.Number = Mission.CarrierCounter
		table.insert(Mission.JAP_Carriers, pEntity)
		luaObj_AddUnit("primary", 1, pEntity)
	end
	table.insert(Mission.JAP_SquadWest, pEntity)
	if (not Mission.USN_Enterprise.Dead) then
		luaSetScriptTarget(pEntity, Mission.USN_Enterprise)
		NavigatorAttackMove(pEntity, Mission.USN_Enterprise, {})
	end
	if (table.getn(Mission.JAP_SquadWest) > 4) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_SquadWestShipGenerated): A SquadWest legeneralva")
		--a kov. azert kell, mert innentol mar nem ebben a listenerben nezem a powerupot, hanem luaUSN10_InitJAPCarrierListener()-ben
		if (IsListenerActive("kill", "Listener_PowerUp")) then
			RemoveListener("kill", "Listener_PowerUp")
		end
		luaUSN10_InitJAPCarrierListener()
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitPhase3()
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPhase3): Generating Squad03 for Phase03")
	local tUnit
	local pUnit
	local nCarrierMaxSpeed
	tUnit = luaFindHidden("Zuiho-class 01")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_amagi")
	table.insert(Mission.JAP_SquadWest, pUnit)
	table.insert(Mission.JAP_Carriers, pUnit)
	table.insert(Mission.JAP_CarriersWest_ReconTable, pUnit)
	--Mission.CarrierCounter = Mission.CarrierCounter + 1
	--Mission.MaxCarrierCounter = Mission.MaxCarrierCounter + 1
	--[[luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})]]--
	NavigatorMoveToRange(pUnit, Mission.USN_Enterprise[1])
	nCarrierMaxSpeed = GetShipMaxSpeed(pUnit)
	tUnit = luaFindHidden("Soryu-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_zuikaku")
	table.insert(Mission.JAP_SquadWest, pUnit)
	table.insert(Mission.JAP_Carriers, pUnit)
	table.insert(Mission.JAP_CarriersWest_ReconTable, pUnit)
	--Mission.CarrierCounter = Mission.CarrierCounter + 1
	--Mission.MaxCarrierCounter = Mission.MaxCarrierCounter + 1
	DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
	--[[luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})]]--
	NavigatorMoveToRange(pUnit, Mission.USN_Enterprise[1])
	SetShipMaxSpeed(pUnit, nCarrierMaxSpeed)
	
	--luaUSN10_InitJapaneseCarriersKillListener()
	
	tUnit = luaFindHidden("Akizuki-class 02")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_hatsuzuki")
	table.insert(Mission.JAP_SquadWest, pUnit)
	luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
	SetShipMaxSpeed(pUnit, nCarrierMaxSpeed)
	if (Mission.difficulty == 0) or (Mission.difficulty == 1) then
		TorpedoEnable(pUnit, false)
	else
		TorpedoEnable(pUnit, true)
	end
	
	tUnit = luaFindHidden("Akizuki-class 03")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_wakatsuki")
	table.insert(Mission.JAP_SquadWest, pUnit)
	luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
	SetShipMaxSpeed(pUnit, nCarrierMaxSpeed)
	if (Mission.difficulty == 0) then
		TorpedoEnable(pUnit, false)
	else
		TorpedoEnable(pUnit, true)
	end
	
	tUnit = luaFindHidden("Akizuki-class 04")
	pUnit = GenerateObject(tUnit.Name, "ingame.shipnames_shimotsuki")
	table.insert(Mission.JAP_SquadWest, pUnit)
	luaSetScriptTarget(pUnit, Mission.USN_Enterprise[1])
	NavigatorAttackMove(pUnit, Mission.USN_Enterprise[1], {})
	SetShipMaxSpeed(pUnit, nCarrierMaxSpeed)
	if (Mission.difficulty == 0) or (Mission.difficulty == 1) then
		TorpedoEnable(pUnit, false)
	else
		TorpedoEnable(pUnit, true)
	end
	
	if (Mission.JOURNALIST_VERSION) then
		for i, pUnit in pairs (Mission.JAP_SquadWest) do
			if (Mission.difficulty == 0) then
				SetSkillLevel(pUnit, SKILL_SPNORMAL)
			else
				SetSkillLevel(pUnit, SKILL_SPVETERAN)
			end
		end
	end
	
	--TORO: a kov. azert kell, mert innentol mar nem ebben a listenerben nezem a powerupot, hanem luaUSN10_InitJAPCarrierListener()-ben
	--TODO: a kov. mar kiszedve, ha nem kell, akkor torolni
	--[[if (IsListenerActive("kill", "Listener_PowerUp")) then
		RemoveListener("kill", "Listener_PowerUp")
	end]]--
	--Kill listener init a MissionCompletedhez
	luaUSN10_InitJAPCarrierListener_Phase3()
	
	Mission.WestCarriersAttack = true
	luaDelay(luaUSN10_CatalinaSpawning, 5)
end

------------------------------------------------------------------------------
function luaUSN10_KaitenDestroyed(pEntity, pTargetDevice, pAttacker)
	--[[TODO: utananezni mivel lehet megoldani ezt a dialogot
			- assertal a GetDistance-re, mert olyankor a Target mar halott
			- Hit listenerre nem adja vissza a pAttacker-t ha a kaiten csapodott a targetba
			- Kill listernerrel nem tudom vizsgalni, hogy amiatt semmisult meg, hogy becsapodott, vagy szetlottek, vagy csak letelt az ido, amig el
			- jelenleg nem mukodik a Kaiten, ha megjavul visszaterni ra. Problema: a minimapen ugy jeleniti meg, mintha a sajat tengelye korul forogna egyfolytaban, raadasul nem talalja el a targetet,
				nem koveti, hanem csak egyenes iranyba megy. Megsemmisul, mert elfogy a levegoje.
	]]--
-- RELEASE_LOGOFF  	luaLog("-----Hit Listener-----")
-- RELEASE_LOGOFF  	luaLog("-- pEntity Class ID --")
-- RELEASE_LOGOFF  	luaLog(pEntity.ClassID)
-- RELEASE_LOGOFF  	luaLog("-- pTargetDevice --")
-- RELEASE_LOGOFF  	luaLog(pTargetDevice)
-- RELEASE_LOGOFF  	luaLog("-- pAttacker --")
-- RELEASE_LOGOFF  	luaLog(pAttacker)
-- RELEASE_LOGOFF  	luaLog("---Hit Listener End---")
	--[[if (pAttacker.ClassID == 81) then
		if (IsListenerActive("hit", "Listener_BBWasHitByKaiten")) then
			RemoveListener("hit", "Listener_BBWasHitByKaiten")
		end
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_KaitenDestroyed): Az egyik Kaiten megsemmisult")
		luaUSN10_StartDialog("Kaiten_Hit_01")
		luaUSN10_StartDialog("Kaiten_Hit_02")
	end]]--
	--[[local pTarget = UnitGetAttackTarget(pEntity)
	if (luaGetDistance(pEntity, pTarget) < 300) then
		luaUSN10_StartDialog("Kaiten_Hit_01")
		luaUSN10_StartDialog("Kaiten_Hit_02")
		if (IsListenerActive("kill", "Listener_KaitenDestroyed")) then
			RemoveListener("kill", "Listener_KaitenDestroyed")
		end
	end]]--
end

------------------------------------------------------------------------------
function luaUSN10_WestCarriersPlanesAttack()
	if (Mission.WestCarriersAttack) then
		local tFighterClassIDs = 
		{
			--[1] = 151 	-- Raiden
			[1] = 150 	-- Zero
		}
		local tOtherClassIDs = 
		{
			[1] = 159, 	-- Judy
			[2] = 163 	-- Jill
		}
		for i, pUnit in pairs (Mission.JAP_Carriers) do
			SetAirBasePlaneLimit(Mission.JAP_Carriers[i], 12)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_CatalinaSpawning()
	local tSpawnPos = GetPosition(Mission.USN_SpawnPoints[2])
	local tLookAtPos = GetPosition(Mission.JAP_SpawnPoints[1])
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 125,
				--TODO: szoveget lockitelni
				["Name"] = "Catalina",
				["Crew"] = 1,
				["Race"] = USA,
				["WingCount"] = 1,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = tSpawnPos,
			["angleRange"] = { 1, -1},
			["lookAt"] = tLookAtPos,
		},
		["callback"] = "luaUSN10_CatalinaSpawned",
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
function luaUSN10_CatalinaSpawned(pEntity)
	table.insert(Mission.USN_ReconPlane, pEntity)
	SetRoleAvailable(pEntity, EROLF_ALL, PLAYER_AI)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_CatalinaSpawned): "..pEntity.Name)
	PilotMoveTo(pEntity, Mission.USN_SpawnPoints[3])
	AddProximityTrigger(pEntity, "ReconPlaneReachedEnd", "luaUSN10_ReconPlaneReachedEnd", Mission.USN_SpawnPoints[3], 100)
	AddListener("recon", "Listener_JAP_SquadWest", {
		["callback"] = "luaUSN10_SquadWestSpotted",  -- callback fuggveny
		["entity"] = Mission.JAP_CarriersWest_ReconTable, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
end

------------------------------------------------------------------------------
function luaUSN10_SquadWestSpotted(pEntity)
-- RELEASE_LOGOFF  	luaLog("A Catalina-t eszrevettek!")
	if (IsListenerActive("recon", "Listener_JAP_SquadWest")) then
		RemoveListener("recon", "Listener_JAP_SquadWest")
	end
	--MissionNarrative(Mission.Narratives[6])
	
	luaDelay(luaUSN10_EM03_Preparing, 3)

	--luaUSN10_StartDialog("Catalina")
	--luaJumpinMovieSetCurrentMovie("LookAt", Mission.JAP_CarriersWest_ReconTable[1].ID)
end

------------------------------------------------------------------------------
function luaUSN10_HintCarriers()
	ShowHint("USN10_Hint_Carriers")
end

------------------------------------------------------------------------------
function luaUSN10_DialogCatalina()
	luaUSN10_StartDialog("Catalina")
end

------------------------------------------------------------------------------
function luaUSN10_EM03_Preparing()
	Blackout(true, "luaUSN10_EM03", 2, 1)
end

------------------------------------------------------------------------------
function luaUSN10_EM03()
	Blackout(true, "", 3, 0)
	--[[if (table.getn(Mission.JAP_SquadSouth) > 0) then
		luaJumpinMovieSetCurrentMovie("GoAround", Mission.JAP_SquadSouth[1].ID)
	end]]--
	luaSetPartyInvincible(1, PARTY_ALLIED)
	Mission.EMLastSelected = GetSelectedUnit()
	EnableMessages(false)	-- EM miatt
	BlackBars(true)
	luaDelay(luaUSN10_DialogCatalina, 2)
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	Mission.EMPlaying = true
	--HideUnitHP()
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_ReconPlane[1], ["distance"] = 40, ["theta"] = 13, ["rho"] = 180, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.USN_ReconPlane[1], ["distance"] = 40, ["theta"] = 13, ["rho"] = 180, ["moveTime"] = 6, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_CarriersWest_ReconTable[1], ["distance"] = 300, ["theta"] = 12, ["rho"] = 120, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAP_CarriersWest_ReconTable[1], ["distance"] = 300, ["theta"] = 12, ["rho"] = 120, ["moveTime"] = 8, ["smoothtime"] = 2},
	},
	luaUSN10_EM03_PreparingEnd,
	true, nil, false)
	
	--luaDelay(luaUSN10_EM03_StartingBlackout_End, 0.5)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_EM03): EM03 lejatszodott")
end

------------------------------------------------------------------------------
function luaUSN10_EM03_StartingBlackout_End()
	Blackout(false, "", 1)
end

------------------------------------------------------------------------------
function luaUSN10_EM03_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN10_EM03_End_BlackOut", 3)
end

------------------------------------------------------------------------------
function luaUSN10_EM03_End_BlackOut()
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
	--TODO: lekerdezni EM elott hogy melyikben ul a player es EM utan arra visszavaltani
	--[[for i, pUnit in pairs (Mission.USN_Squad02) do
		SetRoleAvailable(pUnit, EROLF_ALL, PLAYER_1)
	end]]--
	
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN10_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		else
			SetSelectedUnit(Mission.USN_Iowa[1])
		end
	end
	EnableInput(true)
	Mission.EMPlaying = false
	DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
	luaUSN10_DisplayHP()
	--DisplayUnitHP(Mission.USN_Iowa)
	Blackout(false, "luaUSN10_EM03_End", 3)
end

------------------------------------------------------------------------------
function luaUSN10_EM03_End()
	EnableMessages(true)
	luaSetPartyInvincible(0, PARTY_ALLIED)
	--if (Scoring_IsUnlocked("US09_SILVER")) or (Scoring_IsUnlocked("US09_GOLD"))then
		luaDelay(luaUSN10_BonusPowerUp, 4)
	--end
	if (Mission.JOURNALIST_VERSION) then
		luaDelay(luaUSN10_HintCarriers, 8)
	end
end

------------------------------------------------------------------------------
function luaUSN10_BonusPowerUp()
	--[[AddPowerup(
		{
				["classID"] = "divebomb2",
				["useLimit"] = 1,
		})]]
end

------------------------------------------------------------------------------
function luaUSN10_ReconPlaneReachedEnd(pEntity)
	RemoveTrigger(pEntity, "ReconPlaneReachedEnd")
	Kill(pEntity, true)
end

------------------------------------------------------------------------------
function luaUSN10_InitPowerUp()	--Most ez a fv. ki van kotve, van helyette masik Kill listener kulon az 1. es a 3. fazisban
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitPowerUp): A PowerUp figyelese beregisztralva")
	if (not IsListenerActive("kill", "Listener_PowerUp")) then
		AddListener("kill", "Listener_PowerUp", 
		{
				["callback"] = "luaUSN10_GettingPowerUp",
				["entity"] = Mission.JAP_Carriers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN10_GettingPowerUp()
	if (not Mission.PowerUp) then
		Mission.PowerUp = true
		AddPowerup(
		{
				["classID"] = "improved_repair_team",
				["useLimit"] = 1,
		})
		RemoveListener("kill", "Listener_PowerUp")
		--MissionNarrative(Mission.Narratives[7])
	end
end

------------------------------------------------------------------------------
function luaUSN10_InitJAPCarrierListener_Phase3()
	if (IsListenerActive("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1")) then
		RemoveListener("kill", "Listener_JapaneseCarrierWasDestroyed_Phase1")
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_InitJAPCarrierListener): A japan carrier listenerje addolva")
	if (not IsListenerActive("kill", "Listener_JAPCarrierWasDestroyed_Phase3")) then
		AddListener("kill", "Listener_JAPCarrierWasDestroyed_Phase3", 
		{
				["callback"] = "luaUSN10_JAPCarrierWasDestroyed_Phase3",
				["entity"] = Mission.JAP_Carriers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaUSN10_JAPCarrierWasDestroyed_Phase3(pEntity)
	pEntity.Dead = true
	Mission.JAP_Carriers = luaRemoveDeadsFromTable(Mission.JAP_Carriers)
	luaUSN10_StartDialog("Carrier_Destroyed_01")
	luaUSN10_StartDialog("Carrier_Destroyed_02")
	Mission.CarrierCounter = Mission.CarrierCounter - 1
	if (Mission.CarrierCounter == 0) then
		HideScoreDisplay(1, 0)
	else
		DisplayScores(1,0,"usn10.score01", tostring(Mission.CarrierCounter).."/"..tostring(Mission.MaxCarrierCounter))
	end
	if (not Mission.PowerUp) then
		Mission.PowerUp = true
		AddPowerup(
		{
				["classID"] = "improved_repair_team",
				["useLimit"] = 1,
		})
	end
	if (table.getn(Mission.JAP_Carriers) == 0) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN10_JAPCarrierWasDestroyed): Az osszes japo carrier megsemmisitve. Mission Complete.")
		luaObj_Completed("primary", 1)
		Mission.MCEntity = pEntity
		Mission.MCText = "usn10.obj_p1_compl"
		luaUSN10_MissionComplete()
		--[[Mission.USN_Enterprise[1].Invincible = true
		Mission.USN_Iowa[1].Invincible = true]]--
	end
end

------------------------------------------------------------------------------
function luaUSN10_RemoveDeadsFromTables()
	Mission.USN_Units = luaRemoveDeadsFromTable(Mission.USN_Units)
	Mission.USN_Squad01 = luaRemoveDeadsFromTable(Mission.USN_Squad01)	
	Mission.USN_Squad02 = luaRemoveDeadsFromTable(Mission.USN_Squad02)	
	Mission.USN_Squad02_DD = luaRemoveDeadsFromTable(Mission.USN_Squad02_DD)
	Mission.JAP_SquadNorth = luaRemoveDeadsFromTable(Mission.JAP_SquadNorth)	
	Mission.JAP_SquadNorthAttackers = luaRemoveDeadsFromTable(Mission.JAP_SquadNorthAttackers)
	Mission.JAP_SquadSouth = luaRemoveDeadsFromTable(Mission.JAP_SquadSouth)	
	Mission.JAP_Carriers = luaRemoveDeadsFromTable(Mission.JAP_Carriers)	
	Mission.JAP_Targets = luaRemoveDeadsFromTable(Mission.JAP_Targets)
	Mission.JAP_CarriersWest_ReconTable = luaRemoveDeadsFromTable(Mission.JAP_CarriersWest_ReconTable)
end

------------------------------------------------------------------------------
function luaUSN10_MissionFailed(pEntity, szMessage)
	if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		luaObj_Failed("primary", 1)
	end
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		luaObj_Failed("primary", 2)
	end
	 if (luaObj_IsActive("primary", 3)) and (luaObj_GetSuccess("primary", 3) == nil) then
		luaObj_Failed("primary", 3)
	end
	if (luaObj_IsActive("secondary", 1) and (luaObj_GetSuccess("secondary", 1) == nil)) then
		luaObj_Failed("secondary", 1)
	end
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	--HideUnitHP()
	--az eppen futo dialogusok kikillezese
	local tDialogIDs = GetActDialogIDs()
	for i, pDialogID in pairs (tDialogIDs) do
		KillDialog(pDialogID)
	end
	Mission.EndMission = true
	luaMissionFailedNew(pEntity, szMessage)
end

------------------------------------------------------------------------------
function luaUSN10_MissionComplete()
	if (luaObj_IsActive("primary", 1) and (luaObj_GetSuccess("primary", 1))) then
		SetInvincible(Mission.USN_Iowa[1], 1)
		SetInvincible(Mission.USN_Enterprise[1], 1)
		for i, pShip in pairs (Mission.USN_Squad01) do
			if (not pShip.Dead) then
				SetInvincible(pShip, 1)
			end
		end
		for i, pShip in pairs (Mission.USN_Squad02) do
			if (not pShip.Dead) then
				SetInvincible(pShip, 1)
			end
		end
		--az eppen futo dialogusok kikillezese
		--[[local tDialogIDs = GetActDialogIDs()
		for i, pDialogID in pairs (tDialogIDs) do
			KillDialog(pDialogID)
		end]]--
		luaUSN10_StartDialog("Mission_Complete")
		-- A Mission completed-et a dialog callback-je hivja
		--luaDelay(luaUSN10_EndMission, 10, "EndEntity", pEntity, "EndMessage", szMessage)
	end
end

------------------------------------------------------------------------------
function luaUSN10_EndMission()
	if (luaObj_IsActive("primary", 2) and (luaObj_GetSuccess("primary", 2) == nil)) then
		luaObj_Completed("primary", 2)
	end
	if (luaObj_IsActive("primary", 3) and (luaObj_GetSuccess("primary", 3) == nil)) then
		luaObj_Completed("primary", 3)
	end
	if (luaObj_IsActive("secondary", 1) and (luaObj_GetSuccess("secondary", 1) == nil)) then
		luaObj_Completed("secondary", 1)
	end
	if (luaObj_IsActive("hidden", 1) and (luaObj_GetSuccess("hidden", 1) == nil)) then
		luaObj_Failed("hidden", 1)
	end
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	--HideUnitHP()
	Mission.EndMission = true
	luaMissionCompletedNew(Mission.MCEntity, Mission.MCText)
end

------------------------------------------------------------------------------
--[[function luaUSN10_EndMission(TimerThis)
	local pEntity = TimerThis.ParamTable.EndEntity
	local szMessage = TimerThis.ParamTable.EndMessage
	Mission.EndMission = true
	luaMissionCompletedNew(pEntity, szMessage) --Mission.Narratives[7])
end]]--

------------------------------------------------------------------------------
function luaUSN10_CheckIowaHP()
	local nHPPercent
	if (table.getn(Mission.USN_Iowa) > 0) and (not Mission.USN_Iowa[1].Dead) then
		nHPPercent = GetHpPercentage(Mission.USN_Iowa[1])
		if (nHPPercent < 0.2) then
			--luaLog("(luaUSN10_CheckIowaHP): HP < 20%, MissionCounter = "..Mission.MissionCounter)
			local tDialogIDs = GetActDialogIDs()
			local bDialog = false
			for i, pDialogID in pairs (tDialogIDs) do
				if (pDialogID == "Iowa_HP_20_01") or (pDialogID == "Iowa_HP_20_02") or (pDialogID == "Iowa_HP_20_03") or (pDialogID == "Iowa_HP_20_04") then
					bDialog = true
				end
			end
			if (not bDialog) then
				KillDialog("Iowa_HP_20_01")
				luaUSN10_StartDialog("Iowa_HP_20_01")
				KillDialog("Iowa_HP_20_02")
				luaUSN10_StartDialog("Iowa_HP_20_02")
				KillDialog("Iowa_HP_20_03")
				luaUSN10_StartDialog("Iowa_HP_20_03")
				KillDialog("Iowa_HP_20_04")
				luaUSN10_StartDialog("Iowa_HP_20_04")
			else
				--luaLog("(luaUSN10_CheckIowaHP): Az egyik HP_20-as dialog bent van a queue-ban, most nem jatszodik le")
			end
		elseif (nHPPercent < 0.5) then
			--luaLog("(luaUSN10_CheckIowaHP): HP < 50%, MissionCounter = "..Mission.MissionCounter)
			local tDialogIDs = GetActDialogIDs()
			local bDialog = false
			for i, pDialogID in pairs (tDialogIDs) do
				if (pDialogID == "Iowa_HP_50") then
					bDialog = true
				end
			end
			if (not bDialog) then
				KillDialog("Iowa_HP_50")
				luaUSN10_StartDialog("Iowa_HP_50")
			else
				--luaLog("(luaUSN10_CheckIowaHP): Az HP_50-es dialog bent van a queue-ban, most nem jatszodik le")
			end
			if (nHPPercent >= 0.2) and (Mission.FinalDialogues["Iowa_HP_20_01"].printed ~= nil) then
				--luaLog("(luaUSN10_CheckIowaHP): 20% < HP < 50%, MissionCounter = "..Mission.MissionCounter)
				Mission.FinalDialogues["Iowa_HP_20_01"].printed = false
				Mission.FinalDialogues["Iowa_HP_20_02"].printed = false
				Mission.FinalDialogues["Iowa_HP_20_03"].printed = false
				Mission.FinalDialogues["Iowa_HP_20_04"].printed = false
			end
		else
			if (nHPPercent >= 0.5) and (Mission.FinalDialogues["Iowa_HP_50"].printed ~= nil) then
				--luaLog("(luaUSN10_CheckIowaHP): HP > 50%, MissionCounter = "..Mission.MissionCounter)
				Mission.FinalDialogues["Iowa_HP_50"].printed = false
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_CheckEnterpriseHP()
	local nHPPercent
	if (table.getn(Mission.USN_Enterprise) > 0) and (not Mission.USN_Enterprise[1].Dead) then
		nHPPercent = GetHpPercentage(Mission.USN_Enterprise[1])
		if (nHPPercent < 0.2) then
			local tDialogIDs = GetActDialogIDs()
			local bDialog = false
			for i, pDialogID in pairs (tDialogIDs) do
				if (pDialogID == "Enterprise_HP_20_01") or (pDialogID == "Enterprise_HP_20_02") then
					bDialog = true
				end
			end
			if (not bDialog) then
				KillDialog("Enterprise_HP_20_01")
				luaUSN10_StartDialog("Enterprise_HP_20_01")
				KillDialog("Enterprise_HP_20_02")
				luaUSN10_StartDialog("Enterprise_HP_20_02")
			else
-- RELEASE_LOGOFF  				luaLog("(luaUSN10_CheckEnterpriseHP): Az egyik HP_20-as dialog bent van a queue-ban, most nem jatszodik le")
			end
		elseif (nHPPercent < 0.5) then
			local tDialogIDs = GetActDialogIDs()
			local bDialog = false
			for i, pDialogID in pairs (tDialogIDs) do
				if (pDialogID == "Enterprise_HP_50_01") or (pDialogID == "Enterprise_HP_50_02") then
					bDialog = true
				end
			end
			if (not bDialog) then
				KillDialog("Enterprise_HP_50_01")
				luaUSN10_StartDialog("Enterprise_HP_50_01")
				KillDialog("Enterprise_HP_50_02")
				luaUSN10_StartDialog("Enterprise_HP_50_02")
			else
-- RELEASE_LOGOFF  				luaLog("(luaUSN10_CheckEnterpriseHP): Az egyik HP_50-es dialog bent van a queue-ban, most nem jatszodik le")
			end
			if (nHPPercent >= 0.2) and (Mission.FinalDialogues["Enterprise_HP_20_01"].printed ~= nil) then
				Mission.FinalDialogues["Enterprise_HP_20_01"].printed = false
				Mission.FinalDialogues["Enterprise_HP_20_02"].printed = false
			end
		else
			if (nHPPercent >= 0.5) and (Mission.FinalDialogues["Enterprise_HP_50_01"].printed ~= nil) then
				Mission.FinalDialogues["Enterprise_HP_50_01"].printed = false
				Mission.FinalDialogues["Enterprise_HP_50_02"].printed = false
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_CheckActiveSquadsOfCarriers()
	--luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): Checking Planes of Carriers...")
	if (Mission.MissionPhase < 3) then
		--luaLog("MissionPhase < 3")
		local bEvacuate
		if (Mission.JAP_ActivePlaneSquadsCarrier01 ~= nil) and (table.getn(Mission.JAP_ActivePlaneSquadsCarrier01) > 0) then
-- RELEASE_LOGOFF  			luaLog("Plane table nem ures, mehet a csekk, table hossz = "..table.getn(Mission.JAP_ActivePlaneSquadsCarrier01))
			Mission.JAP_ActivePlaneSquadsCarrier01 = luaRemoveDeadsFromTable(Mission.JAP_ActivePlaneSquadsCarrier01)
			--for i = table.getn(Mission.JAP_ActivePlaneSquadsCarrier01), 1, -1 do
			local i = table.getn(Mission.JAP_ActivePlaneSquadsCarrier01)
			while (i > 0) do
				local pPlane = Mission.JAP_ActivePlaneSquadsCarrier01[i]
-- RELEASE_LOGOFF  				luaLog("Plane in table = "..Mission.JAP_ActivePlaneSquadsCarrier01[i].Name)
-- RELEASE_LOGOFF  				luaLog("pPlane = "..pPlane.Name)
				bEvacuate = luaUSN10_CheckActiveSquadsOfCarriers_NewTargetAndCleaning(pPlane)
				if (bEvacuate) then
-- RELEASE_LOGOFF  					luaLog(pPlane.Name..": A Plane evakual")
				else
-- RELEASE_LOGOFF  					luaLog(pPlane.Name..": A Plane nem evakual")
				end
				if (bEvacuate) then
					--for debug only--
					luaUSN10_Debug_LogTable("JAP_ActivePlaneSquadsCarrier01", Mission.JAP_ActivePlaneSquadsCarrier01)
					--for debug only--
					--table.remove(Mission.JAP_ActivePlaneSquadsCarrier01, i)
					--for debug only--
					luaUSN10_Debug_LogTable("JAP_ActivePlaneSquadsCarrier01", Mission.JAP_ActivePlaneSquadsCarrier01)
					--for debug only--
				end
				i = i - 1
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_Debug_LogTable(szTableName, tTable)
	local szMessage = "(luaUSN10_Debug_LogTable): "..szTableName.." = {'"
	for j, tTemp in pairs (tTable) do
		szMessage = szMessage..tTable[j].Name.."', "
	end
	szMessage = szMessage.."}"
-- RELEASE_LOGOFF  	luaLog(szMessage)
end

------------------------------------------------------------------------------
function luaUSN10_DisplayHP()
	if (not Mission.EMPlaying) then
		if (table.getn(Mission.USN_Iowa) > 0) and (not Mission.USN_Iowa[1].Dead) then
			Mission.IowaHP = math.floor(GetHpPercentage(Mission.USN_Iowa[1])* 100)
			if (table.getn(Mission.USN_Enterprise) > 0) and (not Mission.USN_Enterprise[1].Dead) then
				Mission.EnterpriseHP = math.floor(GetHpPercentage(Mission.USN_Enterprise[1])* 100)
				DisplayScores(2,0,"usn10.score03", "")
			else
				DisplayScores(2,0,"usn10.score02", "")
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_DisplayHP_HPBar()
	if (luaObj_IsActive("primary", 3)) then
		local pSelectedUnit = GetSelectedUnit()
		if (pSelectedUnit ~= nil) and (pSelectedUnit.Class.ID == 15) and (Mission.szDisplayUnitHP == "Iowa") and  (not Mission.USN_Enterprise[1].Dead) then
-- RELEASE_LOGOFF  			luaLog("Cserelodott a HP kijelzes, most az Enterprise-nak van kint")
			DisplayUnitHP(Mission.USN_Enterprise)
			Mission.szDisplayUnitHP = "Enterprise"
		elseif (pSelectedUnit ~= nil) and (pSelectedUnit.Class.ID == 2) and (Mission.szDisplayUnitHP == "Enterprise") and (not Mission.USN_Iowa[1].Dead) then
			DisplayUnitHP(Mission.USN_Iowa)
			Mission.szDisplayUnitHP = "Iowa"
-- RELEASE_LOGOFF  			luaLog("Cserelodott a HP kijelzes, most az Iowa-nak van kint")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN10_CheckActiveSquadsOfCarriers_NewTargetAndCleaning(pPlane)
--[[
	return :
			- true, ha a plane evakualt
			- false, ha a plane uj celpontot kapott es meg kapott ujat
]]--
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_CheckActiveSquadsOfCarriers_NewTargetAndCleaning): pPlane = "..pPlane.Name)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_CheckActiveSquadsOfCarriers_NewTargetAndCleaning): Type = "..VehicleClass[pPlane.Class.ID].Type)
	local bNeedEvacuate = false
-- RELEASE_LOGOFF  	luaLog(pPlane.Name.." commandja "..GetProperty(pPlane, "unitcommand"))
	local szType = VehicleClass[pPlane.Class.ID].Type
	local szCommand = (GetProperty(pPlane, "unitcommand"))
	if ((szType == "Kamikaze") and (szCommand ~= "strafe")) or ((szType == "Fighter") and (szCommand ~= "strafe")) then
		local pNearestEnemy = luaGetNearestEnemy(pPlane)
		--[[luaLog("--Nearest Enemy Table--")
-- RELEASE_LOGOFF  		luaLog("Name = "..pNearestEnemy.Name)
-- RELEASE_LOGOFF  		luaLog(pNearestEnemy)]]--
		if (pNearestEnemy ~= nil) then
-- RELEASE_LOGOFF  			luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): A kamikaze, vagy fighter elozo celpontja megsemmisult, uj celpontot kapott")
-- RELEASE_LOGOFF  			luaLog("Kamikaze v. Fighter NearestEnemy = "..pNearestEnemy.Name)
			PilotSetTarget(pPlane, pNearestEnemy)
		else
-- RELEASE_LOGOFF  			luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): A kamikazenek, vagy fighternek nem talaltam uj celpontot") 
			bNeedEvacuate = true
		end
	elseif ((szType == "DiveBomber") and (szCommand ~= "divebomb")) or ((szType == "TorpedoBomber") and (szCommand ~= "torpedo")) then
		if (GetProperty(pPlane,"ammoType") ~= 0) then
			--if ((pActTarget == nil) or (pActTarget.Dead))  then
			local pNearestEnemy = luaGetNearestEnemy(pPlane)
			if (pNearestEnemy ~= nil) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): A DiveBomber, vagy TorpedoBomber elozo celpontja megsemmisult, uj celpontot kapott")
-- RELEASE_LOGOFF  				luaLog("DiveBomber v. TorpedoBomber NearestEnemy = "..pNearestEnemy.Name)
				PilotSetTarget(pPlane, pNearestEnemy)
			else
-- RELEASE_LOGOFF  				luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): a Divebombernek v. TorpedoBombernek nem talaltam uj celpontot")
				bNeedEvacuate = true
			end
		else
			bNeedEvacuate = true
		end
	end
	if (bNeedEvacuate) then
		--[[luaLog("(luaUSN10_CheckActiveSquadsOfCarriers): "..pPlane.Name.." elindul az evac pont fele")
		PilotMoveTo(pPlane, Mission.JAP_SpawnPoints[1])
		AddProximityTrigger(pPlane, "CarrierPlaneEvac", "luaUSN10_CarrierPlaneReachedEvacPoint", Mission.JAP_SpawnPoints[1], 800)]]--
		return true
	else
		return false
	end
end

------------------------------------------------------------------------------
function luaUSN10_CarrierPlaneReachedEvacPoint(pPlane)
	RemoveTrigger(pPlane, "CarrierPlaneEvac")
	PilotRetreat(pPlane)
-- RELEASE_LOGOFF  	luaLog("(luaUSN10_CarrierPlaneReachedEvacPoint): "..pPlane.Name.." evakualt")
end

------------------------------------------------------------------------------
function luaUSN10_CarrierPlanesEvacuate(pCarrier)
	local nActiveSquads, tEntities = luaGetSlotsAndSquads(pCarrier)
	for i, pPlane in pairs (tEntities) do
		PilotMoveTo(pPlane, Mission.JAP_SpawnPoints[1])
		local tFarthestPathPoint = luaGetFarthestPathPointCoordinate(pPlane, Mission.JAP_SpawnPoints[1])
		AddProximityTrigger(pPlane, "CarrierPlaneEvac", "luaUSN10_CarrierPlaneReachedEvacPoint", tFarthestPathPoint, 800)
	end
end


------------------------------------------------------------------------------
function luaUSN10_Dialog_7thFleetsMessage()
	luaUSN10_StartDialog("7th_Fleets_Message_01")
	luaUSN10_StartDialog("7th_Fleets_Message_02")
	luaUSN10_StartDialog("7th_Fleets_Message_03")
	luaUSN10_StartDialog("7th_Fleets_Message_04")
	luaUSN10_StartDialog("7th_Fleets_Message_05")
	luaUSN10_StartDialog("7th_Fleets_Message_06")
end

------------------------------------------------------------------------------
function luaUSN10_FindSelectableUnit()
	local tUnits = luaGetOwnUnits("", PARTY_ALLIED)
	local i = 0
	local l = false
	while (i < table.getn(tUnits)) and (not l) do
		i = i + 1
		if (IsUnitSelectable(tUnits[i])) and (not tUnits[i].Dead) then
			l = true
		end
	end
	if (not l) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_FindSelectableUnit): Nem talaltam szelektalhato unitot")
		-- return nil
		return nil
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_FindSelectableUnit): A legelso szelektalhato unitot = "..tUnits[i].Name)
		return tUnits[i]
	end
end

------------------------------------------------------------------------------
function luaUSN10_KillAllDialog()
	local DialogIDs = GetActDialogIDs()
	for i, IDs in pairs (DialogIDs) do
		KillDialog(IDs)
	end
end

------------------------------------------------------------------------------
function luaUSN10LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	Mission.FinalDialogues = Mission.Checkpoint.FinalDialogues
	Mission.MissionCounter = Mission.Checkpoint.MissionCounter
	Mission.Narrative05 = Mission.Checkpoint.Narrative05
	Mission.FirstRun = Mission.Checkpoint.FirstRun
	Mission.CP_USNPositions = Mission.Checkpoint.USNPositions
	Mission.CP_IJNPositions = Mission.Checkpoint.IJNPositions
	Mission.CP_SelectedUnit = Mission.Checkpoint.SelectedUnit
	Mission.CarrierCounter = Mission.Checkpoint.CarrierCounter
	Mission.DialogMineField01 = Mission.Checkpoint.DialogMineField01
	Mission.DialogMineField02 = Mission.Checkpoint.DialogMineField02
end

------------------------------------------------------------------------------
function luaUSN10SaveMissionData()
	Mission.Checkpoint.PlaneWaves = Mission.PlaneWaves						-- nem talaltam meg hogy mire hasznalom, ezert elmentettem :)
	Mission.Checkpoint.MissionCounter = Mission.MissionCounter		-- Think counter
	Mission.Checkpoint.Narrative05 = Mission.Narrative05					-- kiirtam -e mar az aknas figyelmezteto narrativat
	Mission.Checkpoint.FinalDialogues = Mission.FinalDialogues		-- dialogus tabla elmentese
	Mission.Checkpoint.FirstRun = Mission.FirstRun								-- fazis init van -e
	Mission.Checkpoint.CarrierCounter	= Mission.CarrierCounter		-- ebben a valtozoban tarolom, hogy eddig mennyi japo carrier spawnolt, a halalukkor fentmaradt repulok uj celpont valasztasahoz es kitakaritasahoz kell
	Mission.Checkpoint.SelectedUnit = GetSelectedUnit().Name			-- melyik unit volt kiszelektalva checkpoint elott
	Mission.Checkpoint.DeadMines = luaUSN10_Checkpoint_CheckMines()	-- kigyujtom a felrobbant aknakat
	Mission.Checkpoint.DialogMineField01 = Mission.DialogMineField01
	Mission.Checkpoint.DialogMineField02 = Mission.DialogMineField02
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint_CheckMines()
	local tDeadMines = {}
	for i, pEntity in pairs (thisTable) do
		if (pEntity.Type == "WATERMINE") then
			if (pEntity.Dead) then
				table.insert(tDeadMines, pEntity.Name)
-- RELEASE_LOGOFF  				luaLog("(luaUSN10_Checkpoint_CheckMines): "..pEntity.Name.." = Dead akna")
			end
		end
	end
	return tDeadMines
end

------------------------------------------------------------------------------
function luaUSN10_Checkpoint_LoadMines(tDeadMines)
-- RELEASE_LOGOFF  	luaLog("DeadMines hossz = "..table.getn(tDeadMines))
	for i, pEntity in pairs (thisTable) do
		if (pEntity.Type == "WATERMINE") then
			local j = 0
			local nLength = table.getn(tDeadMines)
			local bIsMineDead = false
			--luaLog(j..". WATERMINE = "..pEntity.Name)
			while (j < nLength) and (not IsMineDead) do
				j = j + 1
				if (pEntity.Name == tDeadMines[j]) then
					bIsMineDead = true
				end
			end
			if (bIsMineDead) then
-- RELEASE_LOGOFF  				luaLog("KILL: Halott akna eltavolitva es killezve")
				table.remove(tDeadMines, j)
				Kill(pEntity, true)
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUS10SetChangeableGUIName(unit)
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
	--PrepareClass(151)	-- J2M Raiden
	PrepareClass(150)	-- A6M Zero
	PrepareClass(159)	-- D4Y Judy		-> DiveBomber
	PrepareClass(163)	-- B6N Jill		-> TorpedoBomber
	--PrepareClass(45)	-- A6M Zero Kamikaze (modified Damage) /45/
	PrepareClass(45)	-- A6M Zero Kamikaze
	--PrepareClass(46)	-- D3A Val Kamikaze (modified Damage) /46/
	PrepareClass(46)	-- D3A Val Kamikaze
	PrepareClass(2)		-- Yorktown Class
	PrepareClass(23)	-- Fletcher Class
	--PrepareClass(67)	-- Mogami Class
	--PrepareClass(68)	-- Tone Class
	PrepareClass(71)	-- Agano Class
	PrepareClass(57)	-- Zuiho Class
	PrepareClass(14)	-- Akizuki Class
	PrepareClass(53)	-- Soryu Class
	--PrepareClass(108)	-- SBD Dauntless		-> DiveBomber
	PrepareClass(113)	-- TBF Avenger		-> TorpedoBomber
	--PrepareClass(16)	-- TBM-3 Avenger Tiny Tim
	--PrepareClass(101)	-- F4F Wildcat		-> Fighter
	PrepareClass(26)	-- F6F Hellcat		-> Fighter
	PrepareClass(38)	-- SB2C Helldiver		-> DiveBomber	--powerup
	PrepareClass(125)	-- PBY Catalina
	--PrepareClass(81)	-- Submarine TypeB w Kaiten
	--PrepareClass(4)		-- Kaiten Suicide Torpedo
	PrepareClass(85)	-- Japan Tanker
	PrepareClass(75)	-- Minekaze Class
	PrepareClass(7)		-- South Dakota Class
	PrepareClass(15)	-- Iowa Class
	PrepareClass(19)	-- Northampton Class
	PrepareClass(162)	-- B5N Kate
	PrepareClass(158) -- D3A Val
	--PrepareClass(116) -- B-17 Flying Fortress (Bonus Powerup)
	--PrepareClass(167) -- G4M Betty (Bonus Powerup -> beszol ha nem veszem fel)
	Loading_Finish()
end

------------------------------------------------------------------------------

--debug fv-ek
function d1()
	for i, unit in pairs (Mission.JAP_SquadSouth) do
		Kill(unit)
	end
end
function d2()
	for i, unit in pairs (Mission.JAP_Carriers) do
		Kill(unit)
	end
end
function d3()
	SetInvincible(Mission.USN_Iowa[1], true)
end
function d4()
	SetInvincible(Mission.USN_Enterprise[1], true)
end
function d5()
	for i, pUnit in pairs (Mission.JAP_SquadNorthAttackers) do
		Kill(pUnit)
	end
end

function luaUSN10Phase()
	if (Mission.MissionPhase == 1) then
		DeleteScript(Mission.Delay)
		luaUSN10_KillAllDialog()
		--luaUSN10_StartingPhase2()
		for i, pUnit in pairs (Mission.JAP_Carriers) do
			Kill(pUnit)
		end
	elseif (Mission.MissionPhase == 2) then
		for i, pShip in pairs (Mission.JAP_SquadSouth) do
			Kill(pShip)
		end
		luaUSN10_KillAllDialog()
		luaUSN10_SquadSouthShipWasDestroyed()
	elseif (Mission.MissionPhase == 3) then
		local pEntity = Mission.JAP_Carriers[1]
		for i, pShip in pairs (Mission.JAP_Carriers) do
			Kill(pShip)
		end
		Mission.MCEntity = pEntity
		Mission.MCText = "usn10.obj_p1_compl"
		luaUSN10_MissionComplete()
	end
end


function LogMines()
	local MineDead = 0
	local MineAlive = 0
	Mission.MineLogNum = Mission.MineLogNum + 1
	local filename = "Mines_"..tostring(Mission.MineLogNum)..".log"
	local log = io.open(filename, "w+")
	for i, pEntity in pairs (thisTable) do
		if (pEntity.Type == "WATERMINE") then
			if (pEntity.Dead) then
				log:write(pEntity.Name.." = Dead\n")
				MineDead = MineDead + 1
			else
				log:write(pEntity.Name.." = Alive\n")
				MineAlive = MineAlive + 1
			end
		end
	end
	log:write(tostring(MineDead).." db Dead Mine\n")
	log:write(tostring(MineAlive).." db Alive Mine\n")
	log:close()
end
