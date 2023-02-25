--SceneFile="missions\USN\usn_04_Defend_Guadalcanal.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")


--[[
TODO: 
	- support managerese usa pt-knek nem lehet kulon nevet adni, mindegyiknek ugyanaz a neve -> luaUSN04_ObjectGenerated() fv-ben megcsinalni, hogy FindEntity-vel megkeresni a lekrealtat, atnevezni a name-jet, majd beallitani GuiName-et
	- "Carrier_Withdraws" szoveg mar nem biztos hogy jo helyen van, ahol most van
	
	hintek:
		- checkpoint visszatoltes utan azokat a tipusu repuloket felkuldeni, amik fent voltak menteskor
		- command centert elforgatni 90 fokkal az oramutato jarasaval ellenkezoleg, hogy a gunjai a part fele nezzenek
		- underwatert lejjebb tolni a kikotonel
		- Indulaskor a jatekos legyen szemtanuja egy Val attacknak aminek a PT hangarok latjak karat -> nem mukodik a shipyard ezert. A javitasat egy szovegbuborek jelezze, ami mondjuk 5%-onkent ugrik ahogy telik az ido (ki kell szamolni mikor kell ogy elerhetoek legyenek a PTk). Uj dialogus nem lesz.
		- a nyito EM-ben ott egy Fletcher
		- checkpoint visszatoltes utan a kispawolt usa PT-ket berakni a shipyardok ala
		- checkpoint visszatoltes utan a levegoben annyi repulo kezdjen es abban a pos-ban, ahol elmenteskor volt, ne akkor szalljanak fel az airfieldrol

	Low priority
		- ema-ban ugyanolyan repcsi formaciot mutassunk amit a [player iranyitani fog
		- CV-rol felszallo gepeket ne tamadja mar meg az ai vezette amcsi vadaszgep (tul messzirol bevalasztja oket celpontnak)
		- dialogus a northampton elsullyedesekor szar (zero erzelmi tobblet)

	----------
		- Kikoto hajok melle kis hajok szallitsak a cuccot a partra
		
		
	Difficulty:
		+ Hard
			+ Japan carrier: cruiser nem jelent meg -> plane number: 15, cruiser megjelent -> plane number: 6
			+ timer: 300 mp
			+ max PT number: 8
		+ Normal
			+ Japan carrier: cruiser nem jelent meg -> plane number: 12, cruiser megjelent -> plane number: 6
			+ timer: 240 mp
			+ max PT number: 6
		+ Easy
			+ Japan carrier: cruiser nem jelent meg -> plane number: 9, cruiser megjelent -> plane number: 6
			+ timer: 180 mp -> 240 mp
			+ max PT number: 4
]]

--[[1, a GetProperty shipyard-ra mar feldolgozza a "stock" parametert (az airfield
				is: ugyanazt adja vissza, mint eddig a "planes")
		2, AddShipyardStock(shipyardEntity, shipClassID/planeClassID, count [,names])-al feltölthetõ egy shipyard stockja. 
]]--
------------------------------------------------------------------------------
function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	--MessageMap betoltese
	LoadMessageMap("usn04dlg",1)
	MissionNarrative("usn04.date_location")			-- 8th November 1942 - Guadalcanal
	luaDelay(luaUSN04_EMDialog01, 12)
end


function luaUSN04_EMDialog01()
	local Dialogues = {
		["intro01"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
			},
		},
	}
	StartDialog("intro01", Dialogues["intro01"])
	luaDelay(luaUSN04_EMDialog02, 9)
end

------------------------------------------------------------------------------
function luaUSN04_EMDialog02()
	local Dialogues = {
		["intro02"] = {
			["sequence"] = {
				{
					["message"] = "idlg02a",
				},
			},
		},
	}
	StartDialog("intro02", Dialogues["intro02"])
	luaDelay(luaUSN04_EMDialog03, 6)
end

------------------------------------------------------------------------------
function luaUSN04_EMDialog03()
	local Dialogues = {
		["intro03"] = {
			["sequence"] = {
				{
					["message"] = "idlg02b",
				},
			},
		},
	}
	StartDialog("intro03", Dialogues["intro03"])
	luaDelay(luaUSN04_EMDialog04, 3)
end

------------------------------------------------------------------------------
function luaUSN04_EMDialog04()
	local Dialogues = {
		["intro04"] = {
			["sequence"] = {
				{
					["message"] = "idlg02c",
				},
			},
		},
	}
	StartDialog("intro04", Dialogues["intro04"])
	luaDelay(luaUSN04_EMDialog05, 8)
end

------------------------------------------------------------------------------
function luaUSN04_EMDialog05()
	local Dialogues = {
		["intro05"] = {
			["sequence"] = {
				{
					["message"] = "idlg03",
				},
			},
		},
	}
	StartDialog("intro05", Dialogues["intro05"])
end

------------------------------------------------------------------------------
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaUSN04Init")
	Scoring_RealPlayTimeRunning(true)
end

------------------------------------------------------------------------------
function luaUSN04Init(this)
	Mission = this
	this.Name = "US04"
	this.ScriptFile = "SCRIPTS/missions/USN/usn_04_Defend_Guadalcanal.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	--for debug only--
	--TODO: Veglegesben false-ra rakni
-- RELEASE_LOGOFF  	AddWatch("Mission.NumberOfAirfieldHit")
	this.Debug = false
	if (this.Debug) then
-- RELEASE_LOGOFF  		luaLog("Mission running in Script DEBUG mode!")
		this.UnlockLvl = 0
	end
	--for debug only end--
	
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initating "..this.Name.." mission!")
	
	--Mission beallitasok
	this.Party = PARTY_ALLIED

	--difficulty
	this.difficulty = GetDifficulty()
	
	
	--global Constants
	this.SpeedOfConvoy = 22						--in KTS
	if (this.difficulty == 0) then
		this.NumberOfMaxPTs = 3
	elseif (this.difficulty == 1) then
		this.NumberOfMaxPTs = 5
	elseif (this.difficulty == 2) then
		this.NumberOfMaxPTs = 7						--az elso japan PT tamadaskor ennyi PT jon (eloszor a cruisert tamadjak, majd a convoy-t)
	end
	this.AirBaseSlotCount1stHard = 5	--hany repulo lehet maximum a levegoben mielott eszrevettek volna a convoy-t (csak az airfield-et tamadjak)
	this.AirBaseSlotCount1stNormal = 4
	this.AirBaseSlotCount2nd = 3			--hany repulo lehet maximum a levegoben mielott eszrevettek volna a convoy-t (az airfieldet es a convoy-t is tamadjak)
	this.MaxNumberOfPTsPhase2 = 3 		--egyszerre maximum ennyi JAP PT-t spawnolok a phase2-ben, ennyi tamadja a convoy-t
	this.ShipsNeedToSurvive = 4				--a convoy hany hajojank kell tulelni a Mission-t
	if (this.difficulty == 0) then
		this.TimeNeedToConvoyUnload = 240
	elseif (this.difficulty == 1) then
		this.TimeNeedToConvoyUnload = 240
	elseif (this.difficulty == 2) then
		this.TimeNeedToConvoyUnload = 300	--azt mutatja, hogy mennyi ido kell amig a convoy hajoi kirakodnak. Eddig az ideig kell megvedeni a convoy-t, ha letelik azutan vege a missionnek
	end
	this.MaxNumberOfLevelBombers = 7 --6	--maximum hany level bomber fog erkezni, hogy megsemmisitse az airfieldet
	this.NumberOfMaxAirfieldHit	= 9		--maximum ennyi hitet kaphat az airfield, ezutan Mission failed
	this.Alt = 300										--ennyire allitom be a repulok attack es travel altjat
	
	if (this.difficulty == 0) then
		this.AirFieldHP = 3500						--ennyire override-olom az Airfield es a Hangar HP-jat
	elseif (this.difficulty == 1) then
		this.AirFieldHP = 2800						--ennyire override-olom az Airfield es a Hangar HP-jat
	elseif (this.difficulty == 2) then
		this.AirFieldHP = 2200						--ennyire override-olom az Airfield es a Hangar HP-jat
	end
	
	--this.SpeedOfPTs = 40							--PT-k sebessege override-olva

	this.Narratives = {}
		table.insert(this.Narratives, "One of the cargo ship has been destroyed, Sir! We must protect the others.")	--mindenegyes convoy hajo megsemmisuleskor
		table.insert(this.Narratives, "The convoy has reached the beach. Protect it until the ships unload the supply.")	--ha a convoy egyik hajoja elerte az utolso checkpointot
		table.insert(this.Narratives, "Our Convoy has spotted by an enemy unit. The enemy will surely attack them. Defend the convoy!")	--a convoy egyik hajojat eszrevette az enemy
		table.insert(this.Narratives, "Our recons have reported that destroyers are heading to the convoy. Stop them!")	--a destroyerek elindultak a convoy fele
		table.insert(this.Narratives, "Japan PTs coming from west, Sir. We must prepare to defend the convoy!")	--a japan PT-k elindultak a convoy fele
		table.insert(this.Narratives, "Elco PTs available")	--a jatekos innentol kezdve tud PT-ket spawnolni
		table.insert(this.Narratives, "The Convoy has successfully unload the supply")

	--global variables
	this.EndMission = false
	this.MissionPhase = 0
	this.FirstRun = true
	this.ConvoyWasSpotted = false
	this.DelayOfConvoyAttacking = 90 		--eszleles utan 0,5 perc mulva kezdik el tamadni a Kate-ek a convoy-t. Ha letelt ez az ido, akkor a valtozo erteket 0-ra allitom
	this.DestroyersAttack = false				--akkor lesz true, amikor a destroyerek levalnak a carriertol es elkezdik tamadni a convoy-t
	this.CarrierEvacEnable = false			--true, ha a convoy mar kikotott es a carrier elhagyhatja a palyat
	this.CarrierEvacState = 0						--a carrier evakual, ha a convoy mar kikotott, ertekei: (0: a carrier meg nem evakualt, 1: a carrier megkapta az evac commandot)
	this.ConvoyDocking = false					--true, ha a convoy kikotott
	this.ConvoyReachedHarbour = 0				--szamolom hany convoy tag erte el a kikotot
	this.NumberOfJapPt = 0
	this.CargoEnteredArea = false				--erteke true lesz, ha a convoy egyik tagja beert a Navpoint_Area_Convoy entity 1600m-es sugaru korebe
	this.LevelBombersSpawned = 0				--ebben szamolom, hogy hany level bomber spawnolt
	this.TimeLeft = 0										--mennyi a timerbol a hatralevo ido
	this.DummyCruiserSpawned = false		--igaz lesz, ha lespawnolodott a dummy cruiser. Amint megsemmisul, ujra false lesz az erteke
	this.JAPPTCount = 1									--a cruisereket tamado jappt-k sorszama, ezt csak az entity nevehez hasznalom, Gui kiirasra a "Gyoraitei No."+random sorszamot hasznalok
	this.JAPPTNames	= {}
	this.NumberOfAirfieldHit	= 0				--ebben szamolom hogy az airfield mennyi talalatot kapott
	this.USNPTNames = {}								--ebben tarolom, hogy a player altal spawnolt PT-knek milyen sorszamot osztottam mar ki
	this.JAPFightersSpawn	=	0						--erteke 1, ha spawnolhat a carrierrol japo fighter (van egy cooldownja, ha letelik, akkor lesz az erteke 1)
	this.ConvoyDestroyed = 0						--hany hajo semmisult meg a konvojbol
	this.EnableHintSupportPlanes = 0		--ki kell -e irni a supportplane-es hintet
	--this.NeedUSNPTNamesCheck = false		--support manageres spawnolaskor kell -e az USN PT nevet ellenorizni
	this.EMLastSelected = nil						--ebbe a valtozoba mentem el, hogy melyik unit volt utoljara kivalasztva eM elott
	this.ConvoyLength = 0								--ez a displayscore-hoz kell, a lockit ebbol a valtozobol olvassa ki a convoy hosszat
	this.EM04Played	= false							--erteke true, ha lejatszodott az EM04
	this.NeedDDDistanceCheck = false		--erteke addig true, amig vizsgalni kell, hogy mikor valjanak le a carriert kisero DD-k
	this.PTAvailable = false						--ertek true, ha a player tud spawnolni PT-ket a support manageren keresztul
	this.EMIsMapViewActive = false			--erteke true, ha ingame movie-k elott map view-ban volt a player
	this.CP_USNPTs = 0									--csak checkpointhoz kell, ebben szamolom ossze, hogy hany USN PT-t spawnoltam le reload utan. Ennyivel csokkentem a shipyardstock-ot
	this.EMSpottedPlane = nil						--EM01 elott melyik repulo vette eszre a konvojt, csak ingame EM miatt hasznalom												
	this.JAPUnitsEvacuating = false			--akkor lesz true, amikor mar megsemmisult az osszes transport ship, ekkor a meg megmaradt japan PT-k es repulok elkezdik az evakualast
	this.ThrottlePowerUp = false				--akkor lesz true, amikor a player lelotte az elso Jake ugy hogy az meg nem spottolta a convoyt -> kap egy Full Throttle powerupot
		
	--Checkpoint hasznalja
	this.CP_USNPositions = {}
	this.CP_IJNPositions = {}
	
	--allied hajok
	this.USNConvoy = {}
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 01"))
		this.USNConvoy[1].PathIndex = 1
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 02"))
		this.USNConvoy[2].PathIndex = 2
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 03"))
		this.USNConvoy[3].PathIndex = 3
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 01"))
		this.USNConvoy[4].PathIndex = 4
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 02"))
		this.USNConvoy[5].PathIndex = 5
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 03"))
		this.USNConvoy[6].PathIndex = 6
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 04"))
		this.USNConvoy[7].PathIndex = 7
	
	this.CommandCenter = {}
		table.insert(this.CommandCenter, FindEntity("Command Center 01"))
		
	--[[this.USNConvoy = {}
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 01"))
		this.USNConvoy[1].PathIndex = 4
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 02"))
		this.USNConvoy[2].PathIndex = 5
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 03"))
		this.USNConvoy[3].PathIndex = 6
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 04"))
		this.USNConvoy[4].PathIndex = 7
		table.insert(this.USNConvoy, FindEntity("US Cargo Transport 01"))
		this.USNConvoy[5].PathIndex = 1
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 02"))
		this.USNConvoy[6].PathIndex = 2
		table.insert(this.USNConvoy, FindEntity("USTroopTransport 03"))
		this.USNConvoy[7].PathIndex = 3
	]]--

	--letiltja a convoy iranyitasat -> nem lehet beszallni
	if (not Mission.Debug) then
		for i = 1, table.getn(Mission.USNConvoy) do
			SetRoleAvailable(Mission.USNConvoy[i], EROLF_ALL, PLAYER_AI)
			NavigatorForceMoveCloseToTarget(Mission.USNConvoy[i], true)	-- beallitja, hogy kozel is mehetnek egymashoz a hajok
		end
	end

	this.USN_DummyCruiser = {}	-- csak dummy	cruiser, a 10 JapPT szetlovi, a jatekos nem tudja iranyitani

	--allied repulok
	this.USN_P40s = {} -- a player kezdo repulo squadja
		table.insert(this.USN_P40s, FindEntity("F4F Wildcat 01"))		--P-40 Warhawk 01
		SetSkillLevel(this.USN_P40s[1], SKILL_SPVETERAN) --Normal
		table.insert(this.USN_P40s, FindEntity("F4F Wildcat 02"))		--P-40 Warhawk 02
		SetSkillLevel(this.USN_P40s[2], SKILL_SPVETERAN) --Normal
	
	
	--allied path-ok, navpointok
	this.NavpointConvoy01 = FindEntity("Navpoint_ConvoySplit01")
	this.NavpointConvoy02 = FindEntity("Navpoint_ConvoySplit02")
	this.NavpointCruiser = FindEntity("Navpoint_Area_Cruiser")
	this.USN_AirfieldHangar = {}
		table.insert(this.USN_AirfieldHangar, FindEntity("Hangar Airfield 01"))
	this.USN_Airfield = {}
		table.insert(this.USN_Airfield, FindEntity("AirField 01"))
	
	SquadronSetHomeBase(this.USN_P40s[1], this.USN_Airfield[1])
	SquadronSetHomeBase(this.USN_P40s[2], this.USN_Airfield[1])
		
	OverrideHP(this.USN_AirfieldHangar[1], this.AirFieldHP)
	OverrideHP(this.USN_Airfield[1], this.AirFieldHP)
	SetSkillLevel(this.USN_Airfield[1], SKILL_SPVETERAN) --Normal
	SetSkillLevel(this.USN_AirfieldHangar[1], SKILL_SPVETERAN) --Normal
	
	this.NavpointAreaConvoy = FindEntity("Navpoint_Area_Convoy")

	if (Mission.Debug) then
		SetInvincible(this.USN_AirfieldHangar[1], 1)
	end
	this.ConvoyLandingPoints = {}
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint01"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint02"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint03"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint04"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint05"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint06"))
		table.insert(this.ConvoyLandingPoints, FindEntity("LandingPoint07"))
		
	this.ConvoyPathPoints = {}
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking01"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking02"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking03"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking04"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking05"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking06"))
		table.insert(this.ConvoyPathPoints, FindEntity("Path_Docking07"))
	
	
	this.EM_Navpoints = {}
		table.insert(this.EM_Navpoints, FindEntity("Navpoint_EM"))
		
	--player shipyardok
	this.USN_Shipyard = {}
		table.insert(this.USN_Shipyard, FindEntity("Shipyard 01"))
		table.insert(this.USN_Shipyard, FindEntity("Shipyard 02"))
		SetSkillLevel(this.USN_Shipyard[1], SKILL_MPNORMAL) --Normal
		SetSkillLevel(this.USN_Shipyard[2], SKILL_MPNORMAL) --Normal
	
	--japan hajok
	this.JAP_PT = {}
	this.JAP_PT_Phase2 = {}
	
	--japan repulok
	this.JAP_A6M = {}	-- japok tamado squadja, az elejen megtamadja a player egyseget
		table.insert(this.JAP_A6M, FindEntity("A6M Zero 01"))
	this.JAP_Bombers = {}	-- japo bombazo squadja, az airfieldet tamadja az elejen
		table.insert(this.JAP_Bombers, FindEntity("D3A Val 01"))
	this.JAP_LevelBombers = {}
			
	--japan hajok
	this.JAP_Carrier = FindEntity("Soryu-class 01")
	this.JAP_CarrierGroup = {}
		table.insert(this.JAP_CarrierGroup, FindEntity("Tone-class 01"))
		table.insert(this.JAP_CarrierGroup, this.JAP_Carrier)
		table.insert(this.JAP_CarrierGroup, FindEntity("Akizuki-class 01"))
		table.insert(this.JAP_CarrierGroup, FindEntity("Akizuki-class 02"))
		
	for idx,unit in pairs(Mission.JAP_CarrierGroup) do
		
		SetShipMaxSpeed(unit, 10)
	
	end
	
	this.JAP_DestroyerGroup = {}
		table.insert(this.JAP_DestroyerGroup, FindEntity("Akizuki-class 01"))
		table.insert(this.JAP_DestroyerGroup, FindEntity("Akizuki-class 02"))
	this.JAP_PowerUpUnits = {}
		table.insert(this.JAP_PowerUpUnits, this.JAP_CarrierGroup[1])
		table.insert(this.JAP_PowerUpUnits, this.JAP_CarrierGroup[2])
		table.insert(this.JAP_PowerUpUnits, this.JAP_CarrierGroup[3])
		table.insert(this.JAP_PowerUpUnits, this.JAP_CarrierGroup[4])
		table.insert(this.JAP_PowerUpUnits, this.JAP_DestroyerGroup[1])
		table.insert(this.JAP_PowerUpUnits, this.JAP_DestroyerGroup[2])
	
	this.JAP_DummyDD = {}
		
	--japan path-ok, navpointok
	this.JAP_Navpoints = {}
		this.JAP_Navpoints["North01"] = FindEntity("Navpoint_North01")
		this.JAP_Navpoints["North02"] = FindEntity("Navpoint_North02")
		this.JAP_Navpoints["North03"] = FindEntity("Navpoint_North03")
		this.JAP_Navpoints["North04"] = FindEntity("Navpoint_North04")
		this.JAP_Navpoints["West01"] = FindEntity("Navpoint_West01")
		this.JAP_Navpoints["West02"] = FindEntity("Navpoint_West02")	--Convoy attacker PT spawn point 
		this.JAP_Navpoints["West03"] = FindEntity("Navpoint_West03")	--Convoy attacker PT spawn point 
		this.JAP_Navpoints["West04"] = FindEntity("Navpoint_West04")	--Convoy attacker PT spawn point 
		this.JAP_Navpoints["West05"] = FindEntity("Navpoint_West05")	--Convoy attacker PT spawn point 
		this.JAP_Navpoints["West06"] = FindEntity("Navpoint_West06")	--Convoy attacker PT spawn point 
		this.JAP_Navpoints["West07"] = FindEntity("Navpoint_West07")	--DummyCruisert tamado DD spawn point
	
	this.JAP_Navpoints_LB = {}	-- levelbombers navpoints
		this.JAP_Navpoints_LB["LB01"] = FindEntity("Navpoint_LB01")
		this.JAP_Navpoints_LB["LB02"] = FindEntity("Navpoint_LB02")
		this.JAP_Navpoints_LB["LB03"] = FindEntity("Navpoint_LB03")
		this.JAP_Navpoints_LB["LB04"] = FindEntity("Navpoint_LB04")
	this.JAP_Navpoints_LB_Index_Original = {"LB01", "LB02", "LB03", "LB04"}
	this.JAP_Navpoints_LB_Index = {"LB01", "LB02", "LB03", "LB04"}
		
		--[[table.insert(this.JAP_Navpoints, FindEntity("Navpoint_North01"))
		table.insert(this.JAP_Navpoints, FindEntity("Navpoint_North02"))
		table.insert(this.JAP_Navpoints, FindEntity("Navpoint_West01")) --ezt a navpointot hasznalja a Jake spawn-ra es a palya elhagyasara
		table.insert(this.JAP_Navpoints, FindEntity("Navpoint_West02"))
		table.insert(this.JAP_Navpoints, FindEntity("Navpoint_North03")) --erre a navpointra megy a japo carrier es kiserete, majd elhagyja a palyat
		]]--
		
		
	SquadronSetAttackAlt(this.USN_P40s[1], 300)
	SquadronSetTravelAlt(this.USN_P40s[1], 300)
	PilotSetTarget(Mission.USN_P40s[1], Mission.JAP_Bombers[1])
	SquadronSetAttackAlt(this.USN_P40s[2], 300)
	SquadronSetTravelAlt(this.USN_P40s[2], 300)
	PilotSetTarget(Mission.USN_P40s[2], Mission.JAP_A6M[1])
		
	--Achivements Init
	
	--music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	--engine movie
	--luaInitJumpinMovies()
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUSN04LoadMissionData, luaUSN04_Checkpoint01_CleaningAndPutToPosition, luaUSN04_InitStart, luaUSN04_Checkpoint01_Prepare},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUSN04SaveMissionData, luaUSN04_Checkpoint01_SavePositions},
	}
	
	LoadMessageMap("usn04dlg",1)
	
	--dialogusok
	this.Dialogues = {
		["BomberAttack"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
			},
		},
		["CarrierInRange"] = {
			["sequence"] = {
				{
					["message"] = "dlg02",
				},
			},
		},
		["P40_Attacking"] = {
			["sequence"] = {
				{
					["message"] = "dlg03",
				},
			},
		},
		["Support_Convoy"] = {
			["sequence"] = {
				{
					["message"] = "dlg04",
				},
			},
		},
		["Airfield_Attacked"] = {
			["sequence"] = {
				{
					["message"] = "dlg05",
				},
			},
		},
		["Convoy_Attacked"] = {
			["sequence"] = {
				{
					["message"] = "dlg06",
				},
			},
		},
		["Carrier_Withdraws"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07b",
				},
			},
		},
		["Screen_Airfield"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
			},
		},
		["PT_Boats"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
				{
					["message"] = "dlg09b",
				},
			},
		},
		["Dummy_Cruiser"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["Dummy_Cruiser_Attacked"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["DummyCruiser_Sink"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["Levelbomber_Attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				--[[{
					["message"] = "dlg13b",
				},]]--
			},
		},
		["ConvoyGetsRecon"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["1stConvoyShipKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a",
				},
				{
					["message"] = "dlg15b",
				},
			},
		},
		["2ndConvoyShipKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
			},
		},
		["3rdConvoyShipKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg16b",
				},
			},
		},
		["UnloadingStart"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
			},
		},
		["UnloadingFinished"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
			},
		},
	}
	
	--SoundFade(1, "", 1)
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(this, "luaUSN04Think")
	
	--Objectives
	--TODO: szovegeket lockitelni
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "HendersonAirfield",		-- azonosito
				["Text"] = "usn04.obj_p1", --"Henderson Airfield must survive",
				["TextCompleted"] = "usn04.obj_p1_compl", --"Bombers have been eliminated" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn04.obj_p1_fail", --"The Airfield was destroyed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "DefendConvoy",		-- azonosito
				["Text"] = "usn04.obj_p2", --"Protect the support convoy (At least 4 ships must reach the harbour)",
				["TextCompleted"] = "usn06.score01" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn04.obj_p2_fail", --"The convoy had got too many casualties!",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			}
		},
		
		["secondary"] = {
			[1] =
			{
				["ID"] = "AllTransportsSurvive",		-- azonosito
				["Text"] = "usn04.obj_s1", --"All transports must survive"
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "", --"A US transport ship has been destroyed!"
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			}
		},
		
		["hidden"] = {
			[1] =
			{
				["ID"] = "Destroyer",		-- azonosito
				["Text"] = "usn04.obj_h1", 	-- "Eliminate the destroyers Ikachuki and Inazuma!",
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			}
		},
	}
	luaObj_FillSingleScores()
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	luaCheckSavedCheckpoint()
	if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
		SetSelectedUnit(this.USN_P40s[1])
	else
		SetSelectedUnit(Mission.CommandCenter[1])
		Mission.MissionPhase = 2
		Blackout(false, "", 3)
	end
	
	--------------for debug Only----------------
	--[[AddWatch("Mission.CarrierEvacEnable")
-- RELEASE_LOGOFF  	AddWatch("Mission.CarrierEvacState")
-- RELEASE_LOGOFF  	AddWatch("Mission.ConvoyDocking")]]--
	--------------for debug Only end------------
end

------------------------------------------------------------------------------
function luaUSN04Think(this, msg)
	--luaLog(Mission.Name.." mission is thinking...")

	if luaMessageHandler(Mission, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." is terminated!")
		return
	end
	
	if (Mission.EndMission) then
		return
	end
	
	luaCheckMusic()
	
	luaUSN04_RemoveDeadsFromTables()
	
	luaUSN04_CheckPlayerPlanesNum()
	
	--luaUSN04_CheckUSNPTNames()
	
	luaUSN04_SetOwnPlaneAlt()
	
	--luaUSN04_CheckHidden()
	luaUSN11_DDInDistance()
	
	luaUSN04_CheckAirfieldHP()
	
	--luaUSN04_SetTargetUSNPT()
	
	if (Mission.MissionPhase == 0) then	--elinditom a hajokat, repuloket
		--tiltasok
		--SetRoleAvailable(Mission.USN_Shipyard[1], EROLF_ALL, PLAYER_AI)
		--SetRoleAvailable(Mission.USN_Shipyard[2], EROLF_ALL, PLAYER_AI)
		SupportManagerEnable(Mission.USN_Shipyard[1], false)
		SupportManagerEnable(Mission.USN_Shipyard[2], false)

		luaUSN04_InitStart()
				
		-- tamadasok beallitasa --
		-- repulok elinditasa
		SquadronSetAttackAlt(Mission.JAP_A6M[1], 300)
		SquadronSetTravelAlt(Mission.JAP_A6M[1], 300)
		PilotSetTarget(Mission.JAP_A6M[1], Mission.USN_P40s[1])
		
		for i = 1, table.getn(Mission.JAP_Bombers) do
			--PilotBomb(Mission.JAP_Bombers[i], Mission.USN_AirfieldHangar[1])
			SquadronSetAttackAlt(Mission.JAP_Bombers[i], 300)
			SquadronSetTravelAlt(Mission.JAP_Bombers[i], 300)
			PilotSetTarget(Mission.JAP_Bombers[i], Mission.USN_AirfieldHangar[1])
		end

		LaunchAirBaseSlot(Mission.USN_Airfield[1], 3, true)
		
		--convoy elinditasa
		NavigatorMoveOnPath(FindEntity("Junk 01"), FindEntity("junk_01_path"))
		NavigatorMoveOnPath(FindEntity("Junk 02"), FindEntity("junk_02_path"), PATH_FM_CIRCLE)
		local nMinSpeed = KTS(Mission.SpeedOfConvoy) --SpeedOfConvoy sebesseggel fognak szaguldozni
		for i = 1, table.getn(Mission.USNConvoy) do
			SetShipMaxSpeed(Mission.USNConvoy[i], nMinSpeed)
			if (Mission.Debug) then
				SetInvincible(Mission.USNConvoy[i], 1)
			end
			if (i<4) then
				NavigatorMoveToRange(Mission.USNConvoy[i], Mission.NavpointConvoy01)
				AddProximityTrigger(Mission.USNConvoy[i], "ConvoyReachedSplitNavpoint", "luaUSN04_ConvoyMove", Mission.NavpointConvoy01, 100)
			else
				NavigatorMoveToRange(Mission.USNConvoy[i], Mission.NavpointConvoy02)
				AddProximityTrigger(Mission.USNConvoy[i], "ConvoyReachedSplitNavpoint", "luaUSN04_ConvoyMove", Mission.NavpointConvoy02, 100)
			end
		end
		--Mindenegyes convoy destroynal kap a player egy Message-et

		--japan recon plane elinditasa
		luaUSN04_LaunchReconPlane()
		
		--japan carrier group elinditasa
		for i = 2, table.getn(Mission.JAP_CarrierGroup) do
			JoinFormation(Mission.JAP_CarrierGroup[i], Mission.JAP_CarrierGroup[1])
		end
		NavigatorMoveToRange(Mission.JAP_CarrierGroup[1], Mission.JAP_Navpoints["North03"])
		--azert inditok mindegyik unitra ProximityTriggert, mert ha a teljes groupra adtam ki,
		--akkor script hibat dobott, es mindegyik hajora kell, mert ha a leader kinyiffan,
		--akkor mas lesz a leader es akkor arra kell vizsgalni, hogy az elerte -e a navpointot
		for i = 1, table.getn(Mission.JAP_CarrierGroup) do
			if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
				AddProximityTrigger(Mission.JAP_CarrierGroup[i], "JAP_CarrierGroupReachedNavPoint", "luaUSN04_CarrierGroupReachedNavPoint", Mission.JAP_Navpoints["North03"], 100)
			end
		end
		
		Mission.NeedDDDistanceCheck = true
		
		--objective inicializalas
		luaDelay(luaUSN04_InitObjectives, 5)

		--Carrier es kiseroinek figyelese, midenegyes killre, kap plane speeed power upot
		
		luaDelay(luaUSN04_Dialog_BomberAttack, 10)
		luaDelay(luaUSN04_InitDialog_CarrierInRange, 7)
		luaDelay(luaUSN04_Dialog_P40, 17)
		luaDelay(luaUSN04_Hint_SupportPlanes, 22)

		luaDelay(luaUSN04_SupportConvoy, 32)
		luaDelay(luaUSN04_Hint_DefendTransport, 42)
		luaDelay(luaUSN04_Hint_DefendAirfield, 60)
		
		luaUSN04_StartingBlackout()
		
		--luaLog("#2 Mission Phase = "..Mission.MissionPhase)
		Mission.MissionPhase = 1
		--luaLog("#3 Mission Phase = "..Mission.MissionPhase)
		Mission.FirstRun = false

	elseif (Mission.MissionPhase == 1) then
		
		if (not Mission.CargoEnteredArea) then
			luaUSN04_ConvoyEnterArea()
		else
			luaUSN04_CheckConvoyArrived()
		end
		
		if (Mission.DummyCruiserSpawned) then
			luaUSN04_CheckCruiserEnterArea()		--ez csak egy biztonsagi megoldas, hogy a cruiser amelyet a japan PT-k uldoznek, mindenkeppen megsemmisuljon
		end
		
		-- a kov. feltetel azert kell, mert egy ido utan elhagyja a palyat a carrier (kikillezem)
		if (not Mission.ConvoyWasSpotted) then
			
			luaUSN04_CheckConvoyPlanesAround()
			
			--itt meg csak Val-okat kuldok fel, ezek a repteret tamadjak
			luaUSN04_JAPAirfieldManager(1)
		else
			luaUSN04_CheckNumberOfConvoys()
			if ((Mission.DelayOfConvoyAttacking == 0) and (not Mission.JAP_Carrier.Dead)) then
				--luaUSN04_AttackingTheConvoy()
				luaUSN04_JAPAirfieldManager(2)
			end
			--ha a destroyerek mar levaltak, akkor elindulnak tamadni a convoy-t
			luaUSN04_DestroyersAttack()
		end
		
		if (Mission.ConvoyDocking and Mission.CarrierEvacEnable and Mission.CarrierEvacState == 0) then
-- RELEASE_LOGOFF  			luaLog("A Carrier elkezdi az evac-ot")
			Mission.CarrierEvacState = 1
			luaUSN04_CarrierGroupEvac()
		end
	elseif (Mission.MissionPhase == 2) then
		--luaUSN04_Pri01Reminder()
		--luaUSN04_Pri02Reminder()
		luaUSN04_CheckNumberOfConvoys()
		luaUSN04_JAPAirfieldManager(2)
		Mission.TimeLeft = CountdownTimeLeft()
		--AddWatch("Mission.TimeLeft") 		
		if (Mission.TimeLeft > 10) then
			CheckNumberOfJapPTs()
		end
		if (Mission.DummyCruiserSpawned) then --phase1-ben lekrealodik a Dummy cruiser (amikor a convoy belep az egyik area-ba), de phase2 is meg elhet (amikor a convoy mar kikot) ezert kell ide is
			luaUSN04_CheckCruiserEnterArea()		--ez csak egy biztonsagi megoldas, hogy a cruiser amelyet a japan PT-k uldoznek, mindenkeppen megsemmisuljon
		end
		if (Mission.ConvoyWasSpotted) then
			luaUSN04_DestroyersAttack()
		end
		if (Mission.ConvoyDocking and Mission.CarrierEvacEnable and Mission.CarrierEvacState == 0) then
-- RELEASE_LOGOFF  			luaLog("A Carrier elkezdi az evac-ot")
			Mission.CarrierEvacState = 1
			luaUSN04_CarrierGroupEvac()
		end
	elseif (Mission.MissionPhase == 3) then
		--luaUSN04_Pri01Reminder()
		if (Mission.LevelBombersSpawned >= Mission.MaxNumberOfLevelBombers) then
			luaUSN04_CheckNumberOfLevelBombers()
		end
		luaUSN04_CheckNumberOfTransportShips()
		luaUSN04_CheckLevelBomberEvacuating()
	end
	--Mission.JAP_A6M = luaRemoveDeadsFromTable(Mission.JAP_A6M)
	--luaUSN04_CheckAirfieldKilled()
end

------------------------------------------------------------------------------
function luaUSN04_InitStart()
	EnableMessages(true)
	SetDeviceReloadEnabled(true)
	--SetDeviceReloadTimeMul(2.0)
	if (not IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
		AddListener("kill", "Listener_ConvoyShipWasDestroyed", 
		{
			["callback"] = "luaUSN04_ConvoyShipWasDestroyed",
			["entity"] = Mission.USNConvoy,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	end
	
	--Airfield Hit figyeles dialogushoz
	luaUSN04_HendersonFieldListener()
	RepairEnable(Mission.CommandCenter[1], false)
	
	--USN Convoy Hit figyeles dialogushoz
	luaUSN04_ConvoyListener()
		
end

------------------------------------------------------------------------------
function luaUSN04_StartingBlackout()
	Blackout(false, "", 3)
end

------------------------------------------------------------------------------
function luaUSN04_InitObjectives()
	luaObj_Add("primary", 1, Mission.USN_AirfieldHangar[1], false)
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	Mission.ObjRemindTime = 40
	--luaObj_AddReminder("primary", 1)
-- RELEASE_LOGOFF  	luaLog("PRI01 objective has added...")
-- RELEASE_LOGOFF  	luaLog("PRI01 reminder has added...")
	luaObj_Add("primary", 2)
-- RELEASE_LOGOFF  	luaLog("PRI02 objective has added...")
	--luaDelay(luaUSN04_Pri02AddReminder, 20)
	luaObj_Add("secondary", 1, nil, false)
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
-- RELEASE_LOGOFF  	luaLog("SEC01 objective has added...")
	luaObj_Add("hidden", 1, {}, true)
	AddListener("kill", "Listener_DestroyerKilled", 
		{
			["callback"] = "luaUSN04_DestroyerKilled",
			["entity"] = Mission.JAP_DestroyerGroup,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
-- RELEASE_LOGOFF  	luaLog("HID01 objective has added...")
end

------------------------------------------------------------------------------
function luaUSN04_DestroyerKilled(pEntity)
	pEntity.Dead = true
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_DestroyerKilled): 1 destroyer megsemmisult")
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		if (table.getn(Mission.JAP_DestroyerGroup) == 0) then
			luaObj_Completed("hidden", 1, true)
-- RELEASE_LOGOFF  			luaLog("(luaUSN04_DestroyerKilled): Hidden objective Completed")
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Pri01Reminder()
	luaObj_Reminder("primary", 1)
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_Pri01Reminder): A fv. meghivodott")
end

------------------------------------------------------------------------------
function luaUSN04_Pri02AddReminder()
	luaObj_AddReminder("primary", 2)
-- RELEASE_LOGOFF  	luaLog("PRI02 reminder has added...")
end

------------------------------------------------------------------------------
function luaUSN04_Pri02Reminder()
	luaObj_Reminder("primary", 2)
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_Pri02Reminder): A fv. meghivodott")
end

------------------------------------------------------------------------------
function luaUSN04_HendersonFieldListener()
	--Mission.Dialogues["Airfield_Attacked"].printed = false
	if (not IsListenerActive("hit", "Listener_Airfield")) then
		--SetInvincible(Mission.USN_AirfieldHangar[1], true)
		AddListener("hit", "Listener_Airfield", {
			["callback"] = "luaUSN04_AirfieldHit", --"luaUSN04_HendersonFieldWasAttacked", -- callback fuggveny
			["target"] = Mission.USN_Airfield, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
	end
end

------------------------------------------------------------------------------
function luaUSN04_AirfieldHit(...)
	local pEntity = arg[1]
-- RELEASE_LOGOFF  	luaLog("Hit Listener: Name = "..pEntity.Name)
-- RELEASE_LOGOFF  	luaLog("Hit Listener: ClassID ="..pEntity.Class.ID)
	if (arg[3] ~= nil) then
-- RELEASE_LOGOFF  		luaLog("Hit Listener: Attacker = "..arg[3].Name)
	end
	if (arg[4] ~= nil) then
-- RELEASE_LOGOFF  		luaLog("Hit Listener: AttackerType = "..arg[4])
	end
	--if (string.find(pEntity.Name, "AirField") and (arg[4] == "BOMB")) then		-- arg[4] -> AttackType
	if ((pEntity.Class.ID == Mission.USN_Airfield[1].Class.ID)  and (arg[4] == "BOMB")) then
		--LogToConsole(arg[3])
		--LogToConsole(arg[4])
		--LogToConsole(GetHpPercentage(Mission.USN_AirfieldHangar[1]))
		--LogToConsole("----------------")
		if (Mission.Dialogues["Airfield_Attacked"].printed ~= true) then
			luaUSN04_StartDialog("Airfield_Attacked")
			luaDelay(luaUSN04_DialogAirfieldAttack_Printed, 120)
		end
		Mission.NumberOfAirfieldHit = Mission.NumberOfAirfieldHit + 1
		--[[local nDamage = (Mission.USN_AirfieldHangar[1].Class.HP)/Mission.NumberOfMaxAirfieldHit
		local nPercentage = 1 - (Mission.NumberOfAirfieldHit / Mission.NumberOfMaxAirfieldHit)
		if (nPercentage < 0) then
			nPercentage = 0
		end
		local nHP = Mission.USN_AirfieldHangar[1].Class.HP
		AddDamage(Mission.USN_AirfieldHangar[1], 100000)
-- RELEASE_LOGOFF  		luaLog("AirField HP = "..GetHpPercentage(Mission.USN_AirfieldHangar[1]))]]--
		
		--[[luaLog("Airfield MaxHP = "..nHP)
-- RELEASE_LOGOFF  		luaLog("Airfield ActHP = "..GetHpPercentage(pEntity)*100)
-- RELEASE_LOGOFF  		luaLog("Attacker = "..arg[3].Name)
-- RELEASE_LOGOFF  		luaLog("AttackType = "..arg[4])
-- RELEASE_LOGOFF  		luaLog("DamageCaused = "..arg[6])]]--
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_Hit): Airfield talalatok = "..Mission.NumberOfAirfieldHit)
		
		--a kov. sor a Nell-ek bombajanak alacsony sebzese miatt lett megfake-zva
		--[[if (Mission.MissionPhase == 3) and (arg[3] ~= nil) and (arg[3].ClassID == 166) then
			AddDamage(Mission.USN_AirfieldHangar[1], Mission.LevelBomberDamage)
		end]]--
	end
end

------------------------------------------------------------------------------
function luaUSN04_CheckAirfieldHP()
	local nHP = GetHpPercentage(Mission.USN_Airfield[1])		--Mission.USN_AirfieldHangar[1])
	if (nHP < 0.01) then
		luaObj_Failed("primary", 1)
-- RELEASE_LOGOFF  		luaLog("US Airfield was killed! Mission failed!")
		luaUSN04_MissionFailed(Mission.USN_AirfieldHangar[1], "usn04.obj_p1_fail")
		Mission.MissionPhase = 100
	end
end

------------------------------------------------------------------------------
function luaUSN04_DialogAirfieldAttack_Printed()
	KillDialog("Airfield_Attacked")
	Mission.Dialogues["Airfield_Attacked"].printed = false
end

------------------------------------------------------------------------------
function luaUSN04_HendersonFieldWasAttacked()
	RemoveListener("hit", "Listener_Airfield")
	-- luaUSN04_StartDialog("Airfield_Attacked")
	luaDelay(luaUSN04_HendersonFieldListener, 120)
end


------------------------------------------------------------------------------
function luaUSN04_ConvoyListener()
	--[[if (Mission.Dialogues["Convoy_Attacked"].printed ~= true) then
		KillDialog("Convoy_Attacked")
		Mission.Dialogues["Convoy_Attacked"].printed = false
	end]]--
	if (not IsListenerActive("hit", "Listener_ConvoyWasHit")) then
		AddListener("hit", "Listener_ConvoyWasHit", {
			["callback"] = "luaUSN04_ConvoyWasHit", -- callback fuggveny
			["target"] = Mission.USNConvoy, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyWasHit()
	--RemoveListener("hit", "Listener_ConvoyWasHit")
	if (Mission.Dialogues["Convoy_Attacked"].printed ~= true) then
		luaUSN04_StartDialog("Convoy_Attacked")
		luaDelay(luaUSN04_ConvoyDialogAvailable, 120)
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyDialogAvailable()
	KillDialog("Convoy_Attacked")
	Mission.Dialogues["Convoy_Attacked"].printed = false
end

------------------------------------------------------------------------------
function luaUSN04_StartDialog(szDialogID)
	if (Mission.Dialogues[szDialogID].printed == nil) or (Mission.Dialogues[szDialogID].printed == false) then
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_StartDialog): "..szDialogID)
		if (Mission.Dialogues[szDialogID].printed == nil) then
-- RELEASE_LOGOFF  			luaLog("Allitas elott printed = nil")
		elseif (Mission.Dialogues[szDialogID].printed == false) then
-- RELEASE_LOGOFF  			luaLog("Allitas elott printed = false")
		else
-- RELEASE_LOGOFF  			luaLog("Allitas elott printed = true")
		end
		Mission.Dialogues[szDialogID].printed = true
		if (Mission.Dialogues[szDialogID].printed == nil) then
-- RELEASE_LOGOFF  			luaLog("Allitas utan printed = nil")
		elseif (Mission.Dialogues[szDialogID].printed == false) then
-- RELEASE_LOGOFF  			luaLog("Allitas utan printed = false")
		else
-- RELEASE_LOGOFF  			luaLog("Allitas utan printed = true")
		end
		StartDialog(szDialogID, Mission.Dialogues[szDialogID])
	end
end

------------------------------------------------------------------------------
function luaUSN04_Dialog_BomberAttack()
	luaUSN04_StartDialog("BomberAttack")
end

------------------------------------------------------------------------------
function luaUSN04_InitDialog_CarrierInRange()
	AddListener("recon", "Listener_CarrierSpotted", {
		["callback"] = "luaUSN04_CarrierSpotted",  -- callback fuggveny
		["entity"] = {Mission.JAP_Carrier}, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
	})
end

------------------------------------------------------------------------------
function luaUSN04_CarrierSpotted()
	if (IsListenerActive("recon", "Listener_CarrierSpotted")) then
		RemoveListener("recon", "Listener_CarrierSpotted")
	end
	luaUSN04_StartDialog("CarrierInRange")
end

------------------------------------------------------------------------------
function luaUSN04_Dialog_P40()
	luaUSN04_StartDialog("P40_Attacking")
end

------------------------------------------------------------------------------
function luaUSN04_Hint_SupportPlanes()
	ShowHint("USN04_Hint_SupportPlanes")
end

------------------------------------------------------------------------------
function luaUSN04_SupportConvoy()
	luaUSN04_StartDialog("Support_Convoy")
end

------------------------------------------------------------------------------
function luaUSN04_Hint_DefendAirfield()
	ShowHint("USN04_Hint_DefendAirfield")
end

------------------------------------------------------------------------------
function luaUSN04_Hint_DefendTransport()
	ShowHint("USN04_Hint_DefendTransport")
end

------------------------------------------------------------------------------
function luaUSN04_RemoveDeadsFromTables()
	Mission.JAP_A6M = luaRemoveDeadsFromTable(Mission.JAP_A6M)
	Mission.JAP_Bombers =luaRemoveDeadsFromTable(Mission.JAP_Bombers)
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	Mission.JAP_CarrierGroup = luaRemoveDeadsFromTable(Mission.JAP_CarrierGroup)
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
end

------------------------------------------------------------------------------
--[[function luaUSN04_PowerUpUnitDied(pEntity)
	pEntity.Dead = true
	Mission.JAP_PowerUpUnits = luaRemoveDeadsFromTable(Mission.JAP_PowerUpUnits)
	AddPowerup(
	{
			["classID"] = "full_throttle",
			["useLimit"] = 1,
	})
end
]]--
------------------------------------------------------------------------------
function luaUSN04_CheckAirfieldKilled()
	--RemoveListener("kill", "listener_AirfieldKilled")
	--if (GetFailure(Mission.USN_AirfieldHangar[1], "InferiorFailure")) then
	local nHPPercentage = GetHpPercentage(Mission.USN_AirfieldHangar[1])
-- RELEASE_LOGOFF  	luaLog("Airfield HP% = "..nHPPercentage)
	if (nHPPercentage < 0.5) then
		luaObj_Failed("primary", 1)
		--MissionNarrative("US Airfield was killed! Mission failed!") 
		--TODO: szoveget lockitelni
		luaMissionFailedNew(Mission.USN_AirfieldHangar[1], "US Airfield has been destroyed!")
-- RELEASE_LOGOFF  		luaLog("US Airfield was killed! Mission failed!")
		Mission.EndMission = true
		Mission.MissionPhase = 100
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyShipWasDestroyed(pEntity)
	pEntity.Dead = true
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	Mission.ConvoyDestroyed = Mission.ConvoyDestroyed + 1
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	if (Mission.ConvoyDestroyed == 1) then
		luaUSN04_StartDialog("1stConvoyShipKilled")
	elseif (Mission.ConvoyDestroyed == 3) then
		local tDialogs = GetActDialogIDs()
		local bDialog = false
		for i, pDialog in pairs (tDialogs) do
			if (pDialog == "2ndConvoyShipKilled") then
				bDialog = true
			end
		end
		if (not bDialog) then
			Mission.Dialogues["2ndConvoyShipKilled"].printed = false
			luaUSN04_StartDialog("2ndConvoyShipKilled")
		end
		luaUSN04_StartDialog("3rdConvoyShipKilled")
	else
		luaUSN04_StartDialog("2ndConvoyShipKilled")
	end
	--MissionNarrative(Mission.Narratives[1])	--a convoy egyik hajoja megsemmisult
	--Ha a destroyerek levaltak mar, akkor uj celpontot valasztunk annak, amelyiknek epp a halott volt a celpontja
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	if (Mission.DestroyersAttack) then
		for i = 1, table.getn(Mission.JAP_DestroyerGroup) do
			pTarget = luaGetScriptTarget(Mission.JAP_DestroyerGroup[i])
			if (pTarget == nil) or (pTarget == pEntity) then
				pTarget = luaPickRnd(Mission.USNConvoy)
				luaSetScriptTarget(Mission.JAP_DestroyerGroup[i], pTarget)
				NavigatorAttackMove(Mission.JAP_DestroyerGroup[i], pTarget, {})
			end
		end
	end
	--Uj celpont valasztas a japan PT-knek, ha kell
	Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
	if (Mission.CargoEnteredArea) then
-- RELEASE_LOGOFF  		luaLog("CargoEnteredArea")
		for i = 1, table.getn(Mission.JAP_PT) do
			pTarget = luaGetScriptTarget(Mission.JAP_PT[i])
			if (pTarget == nil) or (pTarget == pEntity) then
				pTarget = luaPickRnd(Mission.USNConvoy)
				luaSetScriptTarget(Mission.JAP_PT[i], pTarget)
				NavigatorAttackMove(Mission.JAP_PT[i], pTarget, {})
			end
		end
	end
	if (luaObj_GetSuccess("secondary", 1) == nil) then
		luaObj_Failed("secondary", 1)
		MissionNarrative("usn04.obj_s1_fail")
	end
	if (table.getn(Mission.USNConvoy) < Mission.ShipsNeedToSurvive) then
		RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyMove(entity)
	--luaLog(entity.PathIndex)
	Mission.ConvoyReachedHarbour = Mission.ConvoyReachedHarbour + 1	
	--a kov. sor a navpointos dokkolashoz kellett, ehelyett a hajok mar pathon mennek
	--NavigatorStop(entity)
	NavigatorMoveOnPath(entity, Mission.ConvoyPathPoints[entity.PathIndex], PATH_FM_SIMPLE, PATH_SM_JOIN)
	--NavigatorMoveToRange(entity, Mission.ConvoyLandingPoints[entity.PathIndex])
	NavigatorSetTorpedoEvasion(entity, false)
	RemoveTrigger(entity, "ConvoyReachedSplitNavpoint")
	if (not Mission.ConvoyDocking) then	--elerte -e mar 1 hajo a docking reszt. Ha igen, akkor jonnek balrol az ellenseges PT Boatok
		Mission.ConvoyDocking = true
-- RELEASE_LOGOFF  		luaLog("A convoy egyik tagja elindul a landing point fele")
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyEnterArea()
	local tPos = GetPosition(Mission.NavpointAreaConvoy)
	local tTempTable = {}
	tTempTable = luaGetShipsAroundCoordinate(tPos, 1600, PARTY_ALLIED, "own", nil, nil, nil)
	local bCargoEntered = false
	if (tTempTable ~= nil) and (table.getn(tTempTable) > 0) then
		nLength = table.getn(tTempTable)
		for i = 1, nLength do
			if ((not bCargoEntered) and (tTempTable[i].Class.Type == Mission.USNConvoy[1].Class.Type)) then
				bCargoEntered = true
			end
		end
		if (bCargoEntered) then
-- RELEASE_LOGOFF  			luaLog("Az egyik cargo beert az Area-ba, a japan PT-k spawnolnak")
			Mission.CargoEnteredArea = true
			luaUSN04_JapPT_CruiserSpawn()
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_CheckConvoyArrived()
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	local nTableLength = table.getn(Mission.USNConvoy)
	if (nTableLength > 3) and (Mission.ConvoyReachedHarbour >= nTableLength) then
		--luaCheckpoint(1, nil)
		luaUSN04_ConvoyUnloaded()	-- a checkpoint miatt raktam kulon fv-be, ezt hivodik meg CP visszatolteskor is
	end
end

------------------------------------------------------------------------------
function luaUSN04_ConvoyUnloaded()
	Mission.MissionPhase = 2
	local nTime = Mission.TimeNeedToConvoyUnload/60
	--MissionNarrative(Mission.Narratives[2])	--a convoy kikotott, indul a visszaszamlalas
	luaUSN04_StartDialog("UnloadingStart")
	luaUSN04_TimerStarts_ConvoyDefend()
end

------------------------------------------------------------------------------
function luaUSN04_CheckCruiserEnterArea()
	nAreaPos = GetPosition(Mission.NavpointCruiser)
	--TODO: hack: leveszem a tavolsagot a felere, ha a scene file-t tudom szerkeszteni, akkor ott kell eltolni
	nAreaPos["x"] = -2200  -- -2700
	tEntityTable = luaGetShipsAroundCoordinate(nAreaPos, 2000, PARTY_ALLIED, "own")
	local bCruiserEnteredArea = false
	if (tEntityTable ~= nil) and (table.getn(tEntityTable) > 0) then
		for i = 1, table.getn(tEntityTable) do
			if (not bCruiserEnteredArea) and (tEntityTable[i] == Mission.USN_DummyCruiser[1]) then
				bCruiserEnteredArea =  true
-- RELEASE_LOGOFF  				luaLog("A Dummy Cruiser belepett a halalzonaba")
			end
		end
		if (bCruiserEnteredArea) and (not Mission.USN_DummyCruiser.Dead) and (not Mission.EM04Played) then
			Mission.EM04Played = true
			Blackout(true, "luaUSN04_EM04_StartingBlackout", 0.5)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_EM04_StartingBlackout()
	BlackBars(true)
	Mission.EMLastSelected = nil
	Mission.EMLastSelected = GetSelectedUnit()
	if (Mission.MissionPhase == 2) then
		Mission.TimeLeft = CountdownTimeLeft()
-- RELEASE_LOGOFF  		luaLog("TimeLeft EM04 elott = "..Mission.TimeLeft)
		if (Mission.TimeLeft > 0) then
			CountdownCancel()
		end
	end
	HideScoreDisplay(1, 0)
	HideUnitHP()
	
	SetInvincible(Mission.USN_DummyCruiser[1], 0.2)
	AddDamage(Mission.USN_DummyCruiser[1], 10000)
	luaDelay(luaUSN04_DummyDDFiring_Gun1, 1)
	luaDelay(luaUSN04_DummyDDFiring_Gun2, 1)
	luaDelay(luaUSN04_CruiserBlowingUp, 3)
	luaUSN04_DummyDDBurning()
	
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	DisablePhysics(Mission.USN_DummyCruiser[1])
	local trTbl = {["x"] = 0, ["y"] = -10, ["z"] = 200}
	local rotTbl = {["x"] = -0.2, ["y"] = 0, ["z"] = 1}
	AddMatrixInterpolator(Mission.USN_DummyCruiser[1], trTbl, rotTbl, 20)
	
	luaIngameMovie(
     {
       --{["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 170, ["theta"] = 8, ["rho"] = 15, ["moveTime"] = 0},
       --{["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 170, ["theta"] = 8, ["rho"] = 60, ["moveTime"] = 10},
       {["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 170, ["theta"] = 8, ["rho"] = 345, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 170, ["theta"] = 8, ["rho"] = 315, ["moveTime"] = 10},
  	},
  	luaUSN04_EM04_PreparingEnd,
  	true, nil, false
	)
	--Blackout(false, "", 2)
	--luaDelay(luaUSN04_EM04_StartingBlackout_End, 0.5)
end

------------------------------------------------------------------------------
function luaUSN04_DummyDDBurning()
	SetInvincible(Mission.JAP_DummyDD[1], 0)
	SetFireDamage(Mission.JAP_DummyDD[1], 100)
	Effect("SmallFire", ORIGO, Mission.JAP_DummyDD[1])
end

------------------------------------------------------------------------------
function luaUSN04_DummyDDFiring_Gun1()
	GunForceFireWithAngle(GetGun(Mission.JAP_DummyDD[1], 1), 0, 0)
end

------------------------------------------------------------------------------
function luaUSN04_DummyDDFiring_Gun2()
	GunForceFireWithAngle(GetGun(Mission.JAP_DummyDD[1], 2), 0, 0)
end

------------------------------------------------------------------------------
function luaUSN04_CruiserBlowingUp()
	luaUSN04_StartDialog("DummyCruiser_Sink")
	SetInvincible(Mission.USN_DummyCruiser[1], 0)
	--AddDamage(Mission.USN_DummyCruiser[1], 10000)
	--BreakShip(Mission.USN_DummyCruiser[1])
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	for i, pShip in pairs (Mission.JAP_DestroyerGroup) do
		NavigatorStop(pShip)
		luaSetScriptTarget(pShip, nil)
	end
-- RELEASE_LOGOFF  	luaLog("A Dummy Cruisert kicsinaltak. Szemetek!")
end
------------------------------------------------------------------------------
function luaUSN04_EM04_StartingBlackout_End()
	
end

------------------------------------------------------------------------------
function luaUSN04_EM04_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN04_EM04_End_BlackOut", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM04_End_BlackOut()
	AddDamage(Mission.USN_DummyCruiser[1], 10000)
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN04_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		end
	end
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
-- RELEASE_LOGOFF  	luaLog("TimeLeft EM04 utan = "..Mission.TimeLeft)
	if ((Mission.TimeLeft - 10) > 15) then
		Mission.TimeLeft = Mission.TimeLeft - 10
	end
	if (Mission.MissionPhase == 2) then
		Countdown("usn04.timer01", 1, Mission.TimeLeft, "luaUSN04_TimerEnd_ConvoyDefend")
	end
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	EnableInput(true)
	Blackout(false, "luaUSN04_EM04_End", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM04_End()
	EnableMessages(true)
	luaUSN04_DamagableUSNUnits()
	luaUSN04_DamagableJAPUnits()
end

------------------------------------------------------------------------------
function luaUSN04_LaunchReconPlane(pEntity)
	if (pEntity ~= nil) and (not Mission.ThrottlePowerUp) then
		Mission.ThrottlePowerUp = true
		AddPowerup(
		{
				["classID"] = "full_throttle",
				["useLimit"] = 2,
		})
	end
	--luaLog("ReconPlane Spawn elott")
	--Mission.JAP_ReconPlane = LaunchAirBaseSlot(Mission.JAP_Carrier,1)
	local nPosNavpoint = GetPosition(Mission.JAP_Navpoints["West01"])
	local nPosConvoy = GetPosition(Mission.USNConvoy[1])
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 172,
			--TODO: szoveget lockitelni
			["Name"] = "Jake",
			["Crew"] = 1,
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 0,
		},
	},
	["area"] = {
		["refPos"] = nPosNavpoint,
		["angleRange"] = { 1, -1},
		["lookAt"] = nPosConvoy,
	},
	["callback"] = "luaUSN04_ReconPlaneWasLaunched",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100
	},
	})
	
	--luaLog("Reconplane spawn vege")
end

------------------------------------------------------------------------------
function luaUSN04_ReconPlaneWasLaunched(pPlane)
	--remove-olom az elozo Listener-t
	--SetGuiName(pPlane, "E13A Jake")
-- RELEASE_LOGOFF  	luaLog("Reconaplane was launched")
	if (Mission.JAP_ReconPlane ~= nil) then
		RemoveListener("kill", "Listener_Reconplane")
	end
	Mission.JAP_ReconPlane = pPlane
	if (not IsListenerActive("kill", "Listener_Reconplane")) then
		AddListener("kill", "Listener_Reconplane", 
		{
			["callback"] = "luaUSN04_LaunchReconPlane",
			["entity"] = {Mission.JAP_ReconPlane},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	end
			
	PilotMoveTo(Mission.JAP_ReconPlane, Mission.USNConvoy[1])
	-- azert hivom ujra az AddListener-t, mert ujra generalodik egy masik reconplane
	--luaLog(Mission.JAP_ReconPlane)
end

------------------------------------------------------------------------------
function luaUSN04_CheckConvoyPlanesAround()
	local nSpottedPlane = nil
	local nPlanesAround = false
	local i = 0
	while (i < table.getn(Mission.USNConvoy)) and (not nPlanesAround) do
		i = i + 1
		tTable = luaGetPlanesAround(Mission.USNConvoy[i], 1300, "enemy")	--last: 1100
		if (tTable ~= nil) then
			nPlanesAround = true
			nSpottedPlane = tTable[1]
		end
	end
	if (nPlanesAround) then
		Mission.ConvoyWasSpotted = true
		Mission.EMSpottedPlane = nSpottedPlane
		Blackout(true, "luaUSN04_EM01_Start", 0.5)
	end
end

------------------------------------------------------------------------------
function luaUSN04_EM01_Start()
	if (Mission.JAP_ReconPlane ~= nil) then
		RemoveListener("kill", "Listener_Reconplane")
		PilotMoveTo(Mission.JAP_ReconPlane, Mission.JAP_Navpoints["West01"])
		AddProximityTrigger(Mission.JAP_ReconPlane, "ReconPlaneReachedHome", "luaUSN04_ReconPlaneReachedHome", Mission.JAP_Navpoints["West01"], 100)
-- RELEASE_LOGOFF  		luaLog("Convoy Was Spotted! Reconplane go home")
	end
	--luaLog("Mission.USNConvoy[1].ID:")
	--luaLog(Mission.USNConvoy[1].ID)
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.USNConvoy[1].ID)
	luaUSN04_InvincibleUSNUnits()
	luaUSN04_InvincibleJAPUnits()
	luaUSN04_KillAllDialog()
	HideScoreDisplay(1, 0)
	HideUnitHP()
	BlackBars(true)
	Mission.EMLastSelected = GetSelectedUnit()
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	luaIngameMovie(
     {
       {["postype"] = "cameraandtarget", ["target"] = Mission.EMSpottedPlane, ["distance"] = 30, ["theta"] = 30, ["rho"] = 300, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.EMSpottedPlane, ["distance"] = 30, ["theta"] = 30, ["rho"] = 300, ["moveTime"] = 6, ["smoothtime"] = 2},
       {["postype"] = "cameraandtarget", ["target"] = Mission.USNConvoy[1], ["distance"] = 300, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.USNConvoy[1], ["distance"] = 300, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 6, ["smoothtime"] = 2},
  	},
  	luaUSN04_EM01_PreparingEnd,
  	true, nil, false
	)
	--Blackout(false, "", 2)
	luaDelay(luaUSN04_ActivateObjectiveConvoyDefend, 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM01_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN04_EM01_End_BlackOut", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM01_End_BlackOut()
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN04_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		end
	end
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	EnableInput(true)
	Blackout(false, "luaUSN04_EM01_End", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM01_End()
	EnableMessages(true)
	luaUSN04_DamagableUSNUnits()
	luaUSN04_DamagableJAPUnits()
	luaDelay(luaUSN04_Hint_TransportSpotted, 6)
-- RELEASE_LOGOFF  	luaLog("Delaying of launching bombers (Convoy attack)")
	luaDelay(luaUSN04_AttackingTheConvoy, Mission.DelayOfConvoyAttacking)
end

------------------------------------------------------------------------------
function luaUSN04_ReconPlaneReachedHome(pEntity)
-- RELEASE_LOGOFF  	luaLog("ReconPlane reached the endpoint")
	RemoveTrigger(pEntity, "ReconPlaneReachedHome")
	PilotRetreat(pEntity)
end

------------------------------------------------------------------------------
function luaUSN04_JAPAirfieldManager(nState)	-- 1: meg nem vettek eszre a konvojt, 2: eszrevettek mar
	if (Mission.JAP_Carrier ~= nil) and (not Mission.JAP_Carrier.Dead) then
		local tFighterClassIDs = {}
		if (Mission.JAPFightersSpawn == 0) then
			tFighterClassIDs[1] = 150 -- Zero
		else
			if (nState == 2) and (not Mission.DummyCruiserSpawned) then
				tFighterClassIDs[1] = 162 -- Kate
			else
				tFighterClassIDs[1] = 158 -- Val
			end
		end
		local tOtherClassIDs = 
		{
			[1] = 158, -- Val
		}
		if (nState == 2) and (not Mission.DummyCruiserSpawned) then
			tOtherClassIDs[2] = 162		-- Kate
		end
		--luaLog("Airfield Manager has started...")
		--SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount1st)
		nActiveSquads, tEntities = luaGetSlotsAndSquads(Mission.JAP_Carrier)
		if (tEntities == nil) then
			local tEntities = {}
			local nActiveSquads = 0
		end
		SetAirBasePlaneLimit(Mission.JAP_Carrier, 15)
		if (not Mission.DummyCruiserSpawned) then
			if (Mission.difficulty == 0) then	-- easy mode, slot count = 2 -> plane number = 9
				SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount2nd)
			elseif (Mission.difficulty == 1) then	-- medium mode, slot count = 3 -> plane number = 12
				SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount1stNormal)
			elseif (Mission.difficulty == 2) then	-- hard mode, slot count = 4 -> plane number = 15
				SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount1stHard)
			end
		else
			--[[if (nActiveSquads < 7) then	-- a SetAirBasePlaneLimit miatt kell, mert ha tobb gep van fent mint amire beallitom, akkor a script beszol
				for i, pUnit in pairs (tEntities) do
					if (pEntity.Class.ID ~= 150) then 		--Zero
						SquadronSetBaseUnsupported(pEntity, Mission.JAP_Carrier)
					end
				end
			end]]--
			SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount2nd)
			--SetAirBasePlaneLimit(Mission.JAP_Carrier, 6)
		end
		--LaunchAirStrike -> AirfieldManager helyett
		luaAirfieldManager(Mission.JAP_Carrier, tFighterClassIDs, tOtherClassIDs, Mission.USN_AirfieldHangar)
		nActiveSquads, tEntities = luaGetSlotsAndSquads(Mission.JAP_Carrier)
		for j, pEntity in pairs (tEntities) do
			if (pEntity.Class.ID ~= 162) then
				SquadronSetAttackAlt(pEntity, 300)
				SquadronSetTravelAlt(pEntity, 300)
			end
			if (VehicleClass[pEntity.Class.ID].Type == "Fighter") then
				if (Mission.JAPFightersSpawn == 0) then
					Mission.JAPFightersSpawn = 1
-- RELEASE_LOGOFF  					luaLog("(luaUSN04_JAPAirfieldManager): Egy fighter mar spawnolt a carrierrol, mostantol nem spawnolhat ujabb")
					luaDelay(luaUSN04_FighterEnable_JAPAirfieldManager, 120)
				end
				local pPlaneTarget = luaGetScriptTarget(pEntity)
				if (pPlaneTarget ~= nil) and (pPlaneTarget.Dead) then
					pPlaneTarget = nil
				end
				local tPlayerPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)
				if (tPlayerPlanes ~= nil) and (table.getn(tPlayerPlanes) > 0) and (pPlaneTarget == nil) then
					local pTarget = luaPickRnd(tPlayerPlanes)
					luaSetScriptTarget(pEntity, pTarget)
				end
			elseif (VehicleClass[pEntity.Class.ID].Type == "TorpedoBomber") then
				local pPlaneTarget = luaGetScriptTarget(pEntity)
				if (pPlaneTarget ~= nil) and (pPlaneTarget.Dead) then
					pPlaneTarget = nil
				end
				if (pPlaneTarget == nil) then
					Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
					local pTarget = luaPickRnd(Mission.USNConvoy)
					luaSetScriptTarget(pEntity, pTarget)
				end
			elseif (VehicleClass[pEntity.Class.ID].Type == "DiveBomber") then
				local pPlaneTarget = luaGetScriptTarget(pEntity)
				if (pPlaneTarget ~= nil) and (pPlaneTarget.Dead) then
					pPlaneTarget = nil
				end
				if (pPlaneTarget == nil) then
					--[[local nRnd = luaRnd(1, 100)
					if (nRnd < 21) then
						Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
						local pTarget = luaPickRnd(Mission.USNConvoy)
						luaSetScriptTarget(pEntity, pTarget)
					else]]--
						Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
						local pTarget = Mission.USN_AirfieldHangar[1]
						luaSetScriptTarget(pEntity, pTarget)
					--end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_FighterEnable_JAPAirfieldManager()
	Mission.JAPFightersSpawn = 0
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_FighterEnable_JAPAirfieldManager): Ujra spawnolhat fighter a japan carrierrol")
end

------------------------------------------------------------------------------
function luaUSN04_ActivateObjectiveConvoyDefend()
	--MissionNarrative(Mission.Narratives[3])	--a convoy-t eszrevette az enemy
	luaUSN04_StartDialog("ConvoyGetsRecon")
end

------------------------------------------------------------------------------
function luaUSN04_Hint_TransportSpotted()
	ShowHint("USN04_Hint_TransportSpotted")
end

------------------------------------------------------------------------------
function luaUSN04_CheckNumberOfConvoys()
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	if (table.getn(Mission.USNConvoy) < Mission.ShipsNeedToSurvive) then
		luaObj_Failed("primary", 2)
		pEntity = luaPickRnd(Mission.USNConvoy)
		--luaMissionFailedNew(pEntity, "The convoy had too many casualties!")
-- RELEASE_LOGOFF  		luaLog("The convoy has less than "..Mission.ShipsNeedToSurvive.." transport ships! Mission failed!")
		--Mission.EndMission = true
		luaUSN04_MissionFailed(pEntity, "usn04.obj_p2_fail")
		Mission.MissionPhase = 100
	end
end

------------------------------------------------------------------------------
function luaUSN04_AttackingTheConvoy()
	--luaLog("The Kates attacking the Convoy")
	--if (Mission.DelayOfConvoyAttacking > 0) then
		Mission.DelayOfConvoyAttacking = 0
	--[[end
	local tFighterClassIDs = 
	{
		--[1] = 150 -- Zero
		[1] = 158, -- Val
		[2] = 162 -- Kate
	}
	local tOtherClassIDs = 
	{
		[1] = 158, -- Val
		[2] = 162  -- Kate
	}
	--luaLog("Airfield Manager has started...")
	SetAirBaseSlotCount(Mission.JAP_Carrier, Mission.AirBaseSlotCount2nd)
	luaAirfieldManager(Mission.JAP_Carrier, tFighterClassIDs, tOtherClassIDs, Mission.USN_AirfieldHangar)]]--
end

------------------------------------------------------------------------------
function luaUSN04_CarrierGroupReachedNavPoint(pEntity)
-- RELEASE_LOGOFF  	luaLog("CarrierGroup has reached the Navpoint. They will be evacuated.")
	--luaLog("Length of CarrierGroup table = "..table.getn(Mission.JAP_CarrierGroup))
	--luaLog("Length of DestroyerGroup table = "..table.getn(Mission.JAP_DestroyerGroup))
	
	--itt a teljes CarrierGroupbol kitakaritom a triggereket, mert csak az szamit, hogy 1 elerje a navpointot
	Mission.JAP_CarrierGroup = luaRemoveDeadsFromTable(Mission.JAP_CarrierGroup)
	for i = 1, table.getn(Mission.JAP_CarrierGroup) do
		if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
			RemoveTrigger(Mission.JAP_CarrierGroup[i], "JAP_CarrierGroupReachedNavPoint")
		end
	end
	-- a carrier evakualhat
	Mission.CarrierEvacEnable = true
end

------------------------------------------------------------------------------
function luaUSN11_DDInDistance()
	if (Mission.NeedDDDistanceCheck) then
		Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
		local bDDInDistance = false
		for i, pShip in pairs (Mission.JAP_DestroyerGroup) do
			nDistance = luaGetDistance(pShip, Mission.JAP_Navpoints["North03"])
			if (nDistance < 2750) then
-- RELEASE_LOGOFF  				luaLog("(luaUSN11_DDInDistance): A DD-k tavolsaga < 2750m")
				bDDInDistance = true
			end
		end
		if (bDDInDistance) then
			Mission.NeedDDDistanceCheck = false
			luaUSN11_DDSplit()
		end
	end
end

------------------------------------------------------------------------------
function luaUSN11_DDSplit()
	--kivalik a carrier groupbol a 2 destroyer (ha meg megmaradtak)
-- RELEASE_LOGOFF  	luaLog("(luaUSN11_DDSplit): A DD-k levalnak a carrier grouprol")
	for i, pShip in pairs (Mission.JAP_DestroyerGroup) do
		RemoveTrigger(pShip, "JAP_DDReachedNavPoint")
	end
	local tTempTable = {}
	local nActIndex = 0
	if (table.getn(Mission.JAP_DestroyerGroup) > 0) then
		for i = 1, table.getn(Mission.JAP_CarrierGroup) do
			--felbontom a formaciot
			DisbandFormation(Mission.JAP_CarrierGroup[i])
			local bBoolean = false
			for j = 1, table.getn(Mission.JAP_DestroyerGroup) do
				if (Mission.JAP_CarrierGroup[i] == Mission.JAP_DestroyerGroup[j]) then
					bBoolean = true
				end
			end
			if (not bBoolean) then
				nActIndex = nActIndex + 1
				tTempTable[nActIndex] = Mission.JAP_CarrierGroup[i]
			end
		end
	end
	if (table.getn(tTempTable) > 0) then
		--luaLog("Length of TempTable = "..table.getn(tTempTable))
		Mission.JAP_CarrierGroup = tTempTable
	end
	--meg nem kotott ki a convoy, a carrier es a megmaradt kiserete megy az evac pont fele
	if (not Mission.ConvoyDocking) or (not Mission.CarrierEvacEnable) or (Mission.CarrierEvacState == 0) then
		--luaUSN04_Checkpoint01_CarrierGroupMove()
		
		for i = 1, table.getn(Mission.JAP_CarrierGroup) do
			if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
				NavigatorMoveToRange(Mission.JAP_CarrierGroup[i], Mission.JAP_Navpoints["North03"])
				AddProximityTrigger(Mission.JAP_CarrierGroup[i], "JAP_CarrierGroupReachedNavPoint", "luaUSN04_CarrierGroupReachedNavPoint", Mission.JAP_Navpoints["North03"], 100)
			end
		end
	end
		
	--luaLog("NEW Length of CarrierGroup table = "..table.getn(Mission.JAP_CarrierGroup))
	-- a destroyerek elindulnak megtamadni a convoy-t
	Mission.DestroyersAttack = true
	--luaDelay(luaUSN04_DestroyersAttack_EngineMovie, 10)
	--MissionNarrative("Na most valnak le a Destroyerek")
	if (table.getn(Mission.JAP_DestroyerGroup)> 0) then
		Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
		AddListener("recon", "Listener_DestroyersSpotted", {
			["callback"] = "luaUSN04_DestroyersAttack_EngineMovie",  -- callback fuggveny
			["entity"] = Mission.JAP_DestroyerGroup, -- entityk akiken a listener aktiv
			["oldLevel"] = {0, 1, 2}, -- 0: undetected, 1: detected, 2-4: identified
			["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		})
		luaUSN04_StartDialog("Carrier_Withdraws")
	end
end

------------------------------------------------------------------------------
function luaUSN04_CarrierMemberReachedEvacZone(pEntity)
	RemoveTrigger(pEntity, "CarrierMemberReachedEvacZone")
	--luaLog("A csonak elerte az evac pointot, Class ID = "..pEntity.Class.ID)
	--luaLog("Name = "..pEntity.Name)
	Kill(pEntity, true)
end

------------------------------------------------------------------------------
function luaUSN04_DestroyersAttack_EngineMovie()
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_DestroyersSpotted): A Destroyer groupot eszrevettek a levalasuk utan")
	RemoveListener("recon", "Listener_DestroyersSpotted")
	--MissionNarrative("A destroyerek kepbe kerultek")
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	if (table.getn(Mission.JAP_DestroyerGroup) > 0) then
		--MissionNarrative(Mission.Narratives[4])	--a destroyerek elindulnak a convoy fele
		luaUSN04_StartDialog("Screen_Airfield")			--a destroyerek elindulnak a convoy fele
		luaDelay(luaUSN04_Hint_Torpedo, 6)
		--pEntity = luaPickRnd(Mission.JAP_DestroyerGroup)
		--[[if (table.getn(Mission.JAP_DestroyerGroup)>1) and (not Mission.JAP_DestroyerGroup[2].Dead) then --azert a 2-esre rakom az EM-et, mert az jobb szituban van. Az 1-esbe legtobszor belemegy a Carrier :)
			luaJumpinMovieSetCurrentMovie("LookAt", Mission.JAP_DestroyerGroup[2].ID)
		else
			luaJumpinMovieSetCurrentMovie("LookAt", Mission.JAP_DestroyerGroup[1].ID)
		end]]--
	end
end

------------------------------------------------------------------------------
function luaUSN04_Hint_Torpedo()
	ShowHint("USN04_Hint_Torpedo")
end

------------------------------------------------------------------------------
function luaUSN04_DestroyersAttack()
	if (Mission.DestroyersAttack) and (table.getn(Mission.JAP_DestroyerGroup) > 0) then
		Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
		for i = 1, table.getn(Mission.JAP_DestroyerGroup) do
			if (not Mission.JAP_DestroyerGroup[i].Dead) and (luaGetScriptTarget(Mission.JAP_DestroyerGroup[i]) == nil) then
				if (table.getn(Mission.USN_DummyCruiser)>0) and (not Mission.USN_DummyCruiser[1].Dead) then
					luaSetScriptTarget(Mission.JAP_DestroyerGroup[i], Mission.USN_DummyCruiser[1])
					NavigatorAttackMove(Mission.JAP_DestroyerGroup[i], Mission.USN_DummyCruiser[1], {})
-- RELEASE_LOGOFF  					luaLog("(luaUSN04_DestroyersAttack): "..Mission.JAP_DestroyerGroup[i].Name.." megkapta az attackot a Northamptonra")
				else
					nRnd = luaRnd(1, table.getn(Mission.USNConvoy))
					luaSetScriptTarget(Mission.JAP_DestroyerGroup[i], Mission.USNConvoy[nRnd])
					NavigatorAttackMove(Mission.JAP_DestroyerGroup[i], Mission.USNConvoy[nRnd], {})
-- RELEASE_LOGOFF  					luaLog("(luaUSN04_DestroyersAttack): "..Mission.JAP_DestroyerGroup[i].Name.." megkapta az attackot a konvojra")
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_CarrierGroupEvac()
	for i = 1, table.getn(Mission.JAP_CarrierGroup) do
		if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
			NavigatorMoveToRange(Mission.JAP_CarrierGroup[i], Mission.JAP_Navpoints["North04"])
			AddProximityTrigger(Mission.JAP_CarrierGroup[i], "CarrierMemberReachedEvacZone", "luaUSN04_CarrierMemberReachedEvacZone", Mission.JAP_Navpoints["North04"], 50)
		end
	end
	--luaUSN04_StartDialog("Carrier_Withdraws")
end

------------------------------------------------------------------------------
function luaUSN04_JapPT_CruiserSpawn()
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_JapPT_CruiserSpawn() START--")
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 317,
				["Name"] = "Northampton",
				["Crew"] = 2,
				["Race"] = USA,
			},
		},
		["area"] = {
			["refPos"] = GetPosition(Mission.JAP_Navpoints["West04"]),
			["angleRange"] = { DEG(0),DEG(180)},
			["lookAt"] = GetPosition(Mission.NavpointConvoy01)

		},
		["callback"] = "luaUSN04_CruiserStartToMove",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 200,
		},
		})
-- RELEASE_LOGOFF  		luaLog("--luaUSN04_JapPT_CruiserSpawn() END--")
end
------------------------------------------------------------------------------
function luaUSN04_CruiserStartToMove(pEntity)
	SetGuiName(pEntity, "ingame.shipnames_northampton")	--USS Northampton
	SetNumbering(pEntity, 26)
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() START--")
	table.insert(Mission.USN_DummyCruiser, pEntity)
	Mission.DummyCruiserSpawned = true
	if (not Mission.Debug) then
		SetRoleAvailable(Mission.USN_DummyCruiser[1], EROLF_ALL, PLAYER_AI)
		--SetInvincible(Mission.USN_DummyCruiser[1], 1)
	end
	RepairEnable(pEntity, false)
	SetInvincible(Mission.USN_DummyCruiser[1], 0.5)
	--AddDamage(pEntity, 10000)
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() Invincible--")
	NavigatorSetTorpedoEvasion(Mission.USN_DummyCruiser[1], false)
	ArtilleryEnable(Mission.USN_DummyCruiser[1], false)
	NavigatorSetTorpedoEvasion(Mission.USN_DummyCruiser[1], false)
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() AddListener Cruiser Destroyed--")
	AddListener("kill", "Listener_DummyCruiserWasDestroyed", 
		{
			["callback"] = "luaUSN04_DummyCruiserWasDestroyed",
			["entity"] = Mission.USN_DummyCruiser,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	NavigatorMoveToRange(Mission.USN_DummyCruiser[1], Mission.NavpointConvoy01)
	--ha egy talalatot kap a cruiser, akkor kapja meg a jatekos az engine movie-t es a Message-et a japan PT-krol
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() AddListener PTs Coming--")
	
	--a DD-k levalnak a carrierrol
	Mission.NeedDDDistanceCheck = false
	luaUSN11_DDSplit()
	
	--[[AddListener("hit", "Listener_PTsComing", 
		{
			["callback"] = "luaUSN04_MessagePTsComing",
			["target"] = Mission.USN_DummyCruiser,
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})]]--
	luaDelay(luaUSN04_MessagePTsComing, 60)
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() JapPT Delay--")
	luaDelay(luaUSN04_Dialog_DummyCruiser, 10)
	luaUSN04_JapPT_Delay()
	luaDelay(luaUSN04_DummyDD_Spawning, 20)
-- RELEASE_LOGOFF  	luaLog("--luaUSN04_CruiserStartToMove() END--")
end

------------------------------------------------------------------------------
function luaUSN04_DummyDD_Spawning()
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 275,
				--TODO: szoveget lockitelni
				["Name"] = "DummyDD", --TODO: a nevet lokalizalni
				["Crew"] = 2,
				["Race"] = JAPANESE,
			},
		},
		["area"] = {
			["refPos"] = GetPosition(Mission.JAP_Navpoints["West07"]),
			["angleRange"] = { DEG(0),DEG(180)},
			["lookAt"] = GetPosition(Mission.NavpointConvoy01)

		},
		["callback"] = "luaUSN04_DummyDD_Spawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 200,
		},
		})
end

------------------------------------------------------------------------------
function luaUSN04_DummyDD_Spawned(pEntity)
	SetGuiName(pEntity, "Shigure")
	table.insert(Mission.JAP_DummyDD, pEntity)
	SetShipSpeed(pEntity, Mission.USN_DummyCruiser[1].Class.MaxSpeed)
	TorpedoEnable(pEntity, false)
	RepairEnable(pEntity, false)
	SetInvincible(pEntity, 0.2)
	--NavigatorAttackMove(Mission.JAP_DummyDD[1], Mission.USN_DummyCruiser[1], {})
	UnitFreeFire(Mission.JAP_DummyDD[1])
	NavigatorMoveToRange(Mission.JAP_DummyDD[1], Mission.NavpointConvoy01)
end

------------------------------------------------------------------------------
function luaUSN04_Dialog_DummyCruiser()
	luaUSN04_StartDialog("Dummy_Cruiser")
end

------------------------------------------------------------------------------
function luaUSN04_MessagePTsComing()
	--SetInvincible(Mission.USN_DummyCruiser[1], 0)
	if (IsListenerActive("hit", "Listener_PTsComing")) then
		RemoveListener("hit", "Listener_PTsComing")
	end
	SetInvincible(Mission.USN_DummyCruiser[1], 0.5)
	--nDamage = pEntity.Class.HP/2
	--AddDamage(pEntity, nDamage)
	AddDamage(Mission.USN_DummyCruiser[1], 10000)	-- 50%-ig lesebzem (invincible = 0.5)
	--MissionNarrative(Mission.Narratives[5])	--a japan PT-k elindulnak a cruiser fele

	--luaJumpinMovieSetCurrentMovie("Forward",Mission.USN_DummyCruiser[1].ID)
	luaUSN04_InvincibleUSNUnits()
	luaUSN04_InvincibleJAPUnits()
	luaUSN04_KillAllDialog()
	--luaUSN04_TorpedoEnable(Mission.JAP_PT, false)
	NavigatorSetTorpedoEvasion(Mission.USN_DummyCruiser[1], false)
	
	Blackout(true, "luaUSN04_EM02_StartingBlackout", 0.5)
	
end

------------------------------------------------------------------------------
function luaUSN04_EM02_StartingBlackout()
	BlackBars(true)
	Mission.EMLastSelected = nil
	Mission.EMLastSelected = GetSelectedUnit()
	if (Mission.MissionPhase == 2) then
		Mission.TimeLeft = CountdownTimeLeft()
-- RELEASE_LOGOFF  		luaLog("TimeLeft EM02 elott = "..Mission.TimeLeft)
		if (Mission.TimeLeft > 0) then
			CountdownCancel()
		end
	end
	HideScoreDisplay(1, 0)
	HideUnitHP()
	--[[local nShipPos = GetPosition(Mission.USN_DummyCruiser[1])
-- RELEASE_LOGOFF  	luaLog("Dummy Cruiser Position: x = "..nShipPos["x"]..", y = "..nShipPos["y"]..", z = "..nShipPos["z"])
	Mission.EM_Navpoints[1]["x"] = nShipPos["x"] + 200
	Mission.EM_Navpoints[1]["z"] = nShipPos["z"]
	Mission.EM_Navpoints[1]["y"] = 4 --nShipPos["y"]
-- RELEASE_LOGOFF  	luaLog("Navpoint Position: x = "..Mission.EM_Navpoints[1]["x"]..", y = "..Mission.EM_Navpoints[1]["y"]..", z = "..Mission.EM_Navpoints[1]["z"])]]--
	
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	luaIngameMovie(
     {
     	--[[
     	{["postype"] = "cameraandtarget", ["target"] = Mission.EM_Navpoints[1], ["distance"] = 150, ["theta"] = 180, ["rho"] = 15, ["moveTime"] = 0},
      {["postype"] = "cameraandtarget", ["target"] = Mission.EM_Navpoints[1], ["distance"] = 150, ["theta"] = 180, ["rho"] = 15, ["moveTime"] = 8},
     	]]--
       
       {["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 150, ["theta"] = 8, ["rho"] = 25, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.USN_DummyCruiser[1], ["distance"] = 150, ["theta"] = 8, ["rho"] = 25, ["moveTime"] = 8},
  	},
  	luaUSN04_EM02_PreparingEnd,
  	true, nil, false
	)
		
	luaDelay(luaUSN04_Dialog_Dummy_Cruiser_Attacked, 3)
	--Blackout(false, "", 2)
	--luaDelay(luaUSN04_EM02_StartingBlackout_End, 0.5)
	
end

------------------------------------------------------------------------------
function luaUSN04_EM02_StartingBlackout_End()
	Blackout(false, "", 1)
end

------------------------------------------------------------------------------
function luaUSN04_Dialog_Dummy_Cruiser_Attacked()
	luaUSN04_StartDialog("Dummy_Cruiser_Attacked")	--a japan PT-k lovik a cruisert
	AddDamage(Mission.JAP_DummyDD[1], 10000)
end

------------------------------------------------------------------------------
function luaUSN04_EM02_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN04_EM02_End_BlackOut", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM02_End_BlackOut()
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN04_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		end
	end
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
-- RELEASE_LOGOFF  	luaLog("TimeLeft EM02 utan = "..Mission.TimeLeft)
	if ((Mission.TimeLeft - 10) > 15) then
		Mission.TimeLeft = Mission.TimeLeft - 10
	end
	if (Mission.MissionPhase == 2) then
		Countdown("usn04.timer01", 1, Mission.TimeLeft, "luaUSN04_TimerEnd_ConvoyDefend")
	end
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	EnableInput(true)
	Blackout(false, "luaUSN04_EM02_End", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM02_End()
	EnableMessages(true)
	luaUSN04_DamagableUSNUnits()
	luaUSN04_DamagableJAPUnits()
	--luaUSN04_TorpedoEnable(Mission.JAP_PT, true)
	NavigatorSetTorpedoEvasion(Mission.USN_DummyCruiser[1], true)
	SetInvincible(Mission.USN_DummyCruiser[1], 0.5)		-- visszaallitom, hogy csak felig tudjak lesebezni, itt meg nem szabad megsemmisulnie
	
	luaDelay(luaUSN04_MessagePTAvailable, 20)
	luaUSN04_PlayerPTsSpawnShipyard1()
	--luaUSN04_PlayerPTsSpawnShipyard2()
end

------------------------------------------------------------------------------
function luaUSN04_MessagePTAvailable()
	--MissionNarrative(Mission.Narratives[6])	--a jatekos spawnolhat PT-ket
	ShowHint("USN04_Hint_PTsAvailable")
end

------------------------------------------------------------------------------
function luaUSN04_JapPT_Delay()
	Mission.NumberOfJapPt = Mission.NumberOfJapPt + 1
	if (Mission.NumberOfJapPt < Mission.NumberOfMaxPTs + 1) then
		if (Mission.NumberOfJapPt == 1) then
			nRnd = 20
		else
			local nRnd = luaRnd(6, 14)
		end
		luaDelay(luaUSN04_JapPT_Spawn, nRnd, "szFunction", "luaUSN04_JapPT_Move")
	end
end

------------------------------------------------------------------------------
function luaUSN04_JapPT_Spawn(TimeThis)
	local szFunction = TimeThis.ParamTable.szFunction
	local tNavPointTable = {"West02", "West03", "West05", "West06"}
	nKey, nVal = luaPickRnd(tNavPointTable)
	--LogToConsole(Mission.JAP_Navpoints[nKey])
	--LogToConsole("Table Length = "..table.getn(tNavPointTable))
	--LogToConsole("Key = "..nKey)--..", Val = "..nVal)
	--luaLog(Mission.NumberOfJapPt..". Jap PT spawnol a "..nKey.." navpointra")
	--luaLog("SpawnNew Callback function: "..szFunction)
	
	local bNeedGenerate = true
	local nPTNumber
	local szPTName = "Gyoraitei No."
		while bNeedGenerate do
		nPTNumber = luaRnd(1, 999)
-- RELEASE_LOGOFF  		luaLog("JAPPT - Dobott random = "..nPTNumber)
		local bMatch = false
		for i, nNumber in pairs (Mission.JAPPTNames) do
			if (nNumber == nPTNumber) then
				bMatch = true
			end
		end
		if (not bMatch) then
			bNeedGenerate = false
-- RELEASE_LOGOFF  			luaLog("JAPPT - Nem volt sorszam egyezes")
		end
	end
	table.insert(Mission.JAPPTNames, nPTNumber)
-- RELEASE_LOGOFF  	luaLog("JAPPT - Sorszam beillesztve: "..nPTNumber)
	if (nPTNumber < 10) then
		szPTName = szPTName.."00"
	elseif (nPTNumber < 100) then
		szPTName = szPTName.."0"
	end
	szPTName = szPTName..nPTNumber
-- RELEASE_LOGOFF  	luaLog("JAPPT - PTName = "..szPTName)
	--pEntity.GuiName = szPTName
	--local szEntityName = "JAPPT"..Mission.JAPPTCount
	local szEntityName = szPTName
	Mission.JAPPTCount = Mission.JAPPTCount + 1
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 77,
				--TODO: szoveget lockitelni
				["Name"] = szEntityName, --TODO: a nevet lokalizalni
				["Crew"] = 2,
				["Race"] = JAPANESE,
			},
		},
		["area"] = {
			["refPos"] = GetPosition(Mission.JAP_Navpoints[nKey]),
			["angleRange"] = { DEG(0),DEG(180)},
			["lookAt"] = GetPosition(Mission.NavpointConvoy01)

		},
		["callback"] = szFunction, --"luaUSN04_JapPT_Move",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 200,
		},
	})
end

------------------------------------------------------------------------------
function luaUSN04_JapPT_Move(pEntity)
	--[[local bNeedGenerate = true
	local nPTNumber
	local szPTName = "Gyoraitei No."
-- RELEASE_LOGOFF  	luaLog("JAPPT - pEntity Name = "..pEntity.Name)
-- RELEASE_LOGOFF  	luaLog(pEntity)
	while bNeedGenerate do
		nPTNumber = luaRnd(1, 999)
-- RELEASE_LOGOFF  		luaLog("JAPPT - Dobott random = "..nPTNumber)
		local bMatch = false
		for i, nNumber in pairs (Mission.JAPPTNames) do
			if (nNumber == nPTNumber) then
				bMatch = true
			end
		end
		if (not bMatch) then
			bNeedGenerate = false
-- RELEASE_LOGOFF  			luaLog("JAPPT - Nem volt sorszam egyezes")
		end
	end
	table.insert(Mission.JAPPTNames, nPTNumber)
-- RELEASE_LOGOFF  	luaLog("JAPPT - Sorszam beillesztve: "..nPTNumber)
	if (nPTNumber < 10) then
		szPTName = szPTName.."00"
	elseif (nPTNumber < 100) then
		szPTName = szPTName.."0"
	end
	szPTName = szPTName..nPTNumber
-- RELEASE_LOGOFF  	luaLog("JAPPT - PTName = "..szPTName)
	pEntity.GuiName = szPTName]]--
	table.insert(Mission.JAP_PT, pEntity)
	TorpedoEnable(pEntity, true)
	--[[local nMaxSpeed = KTS(Mission.SpeedOfPTs)
	SetShipMaxSpeed(pEntity, nMaxSpeed)]]--
	if (not Mission.USN_DummyCruiser[1].Dead) then
		luaSetScriptTarget(pEntity, Mission.USN_DummyCruiser[1])
		NavigatorAttackMove(pEntity, Mission.USN_DummyCruiser[1], {})
	else
		Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
		--[[nRnd = luaRnd(1, table.getn(Mission.USNConvoy))
		luaSetScriptTarget(pEntity, Mission.USNConvoy[nRnd])
		NavigatorAttackMove(pEntity, Mission.USNConvoy[nRnd], {})]]--
		local pTarget = luaUSN04_GetNearestConvoyShip(pEntity)
		luaSetScriptTarget(pEntity, pTarget)
		NavigatorAttackMove(pEntity, pTarget, {})
	end
	luaUSN04_JapPT_Delay()
end

------------------------------------------------------------------------------
function luaUSN04_DummyCruiserWasDestroyed()
	RemoveListener("kill", "Listener_DummyCruiserWasDestroyed")
	Mission.DummyCruiserSpawned = false
-- RELEASE_LOGOFF  	luaLog("Dummy Cruiser was destroyed")
	Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
	for i = 1, table.getn(Mission.JAP_PT) do
		if (luaGetScriptTarget(Mission.JAP_PT[i]) == nil) then
			Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
			nRnd = luaRnd(1, table.getn(Mission.USNConvoy))
			luaSetScriptTarget(Mission.JAP_PT[i], Mission.USNConvoy[nRnd])
			NavigatorAttackMove(Mission.JAP_PT[i], Mission.USNConvoy[nRnd], {})
		end
	end
	luaDelay(luaUSN04_Hint_AttackPTs, 10)
end

------------------------------------------------------------------------------
function luaUSN04_Hint_AttackPTs()
	ShowHint("USN04_Hint_AttackPTs")
end

------------------------------------------------------------------------------
function luaUSN04_TimerStarts_ConvoyDefend()
	HideUnitHP()
	Countdown("usn04.timer01", 1, Mission.TimeNeedToConvoyUnload, "luaUSN04_TimerEnd_ConvoyDefend")
	--[[AddPowerup(
	{
			["classID"] = "rocket1",
			["useLimit"] = 1,
	})]]
	--luaDelay(luaUSN04_JapPT_Spawn, 3, "szFunction", "luaUSN04_JapPT_Move_Phase2")
	--luaLog("function t() meghivodott. Kov. Spawn 3 mp mulva")
end

------------------------------------------------------------------------------
function luaUSN04_CheckNumberOfTransportShips()
	if (not Mission.JAPUnitsEvacuating) and (table.getn(Mission.USNConvoy) == 0) then
		luaUSN04_JAPUnitsEvacuate()
	end
end

------------------------------------------------------------------------------
function luaUSN04_TimerEnd_ConvoyDefend()
	--MissionNarrative(Mission.Narratives[7])	--a convoy tagjai kirakodtak az utanpotlast
	HideScoreDisplay(1, 0)
	luaUSN04_StartDialog("UnloadingFinished")
	luaUSN04_TransportShipsSurvived()
	Mission.MissionPhase = 3
	--[[for i = 1, table.getn(Mission.TEST_HiddenPTs) do
		GenerateObject(Mission.TEST_HiddenPTs[i].Name)
	end]]--
	--luaUSN04_JAPUnitsEvacuate()
	--DD-k tamadjak az airfieldet
	luaUSN04_DestroyersAttackingTheAirfield()
	luaDelay(luaUSN04_LevelBombersSpawn, 5)
end

------------------------------------------------------------------------------
function luaUSN04_TransportShipsSurvived()
	--ezek csak biztonsagi lepesek, mert itt mar teljesitette az ojjektet a player, de a kiiras csak 3mp mulva tortenik meg. Ezalatt ne semmisuljon meg tobb hajo
	for i, pShip in pairs (Mission.USNConvoy) do
		SetInvincible(pShip, 1)
	end
	if (IsListenerActive("hit", "Listener_ConvoyWasHit")) then
		RemoveListener("hit", "Listener_ConvoyWasHit")
	end
	if (IsListenerActive("kill", "Listener_ConvoyShipWasDestroyed")) then
		RemoveListener("kill", "Listener_ConvoyShipWasDestroyed")
	end
	luaDelay(luaUSN04_Pri02Completed, 3)
end

------------------------------------------------------------------------------
function luaUSN04_Pri02Completed()
	luaObj_Completed("primary", 2)
	--luaObj_RemoveReminder("primary", 2)
	for i, pShip in pairs (Mission.USNConvoy) do
		SetInvincible(pShip, 0)
	end
end

------------------------------------------------------------------------------
function luaUSN04_JAPUnitsEvacuate()
	Mission.JAPUnitsEvacuating = true
	Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
	for i, pUnit in pairs (Mission.JAP_PT) do
		UnitHoldFire(pUnit)
		NavigatorMoveToRange(pUnit, Mission.JAP_Navpoints["West04"])
		AddProximityTrigger(pUnit, "PTReachedEvacZone", "luaUSN04_PTReachedEvacZone", Mission.JAP_Navpoints["West04"], 100)
		--NavigatorMoveToRange(pUnit, GetClosestBorderZone(GetPosition(pUnit)))
	end
	--[[Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	for i, pUnit in pairs (Mission.JAP_DestroyerGroup) do
		UnitHoldFire(pUnit)
		NavigatorMoveToRange(pUnit, GetClosestBorderZone(GetPosition(pUnit)))
	end]]--
	--repcsik evakualnak
	local tPlanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
	tPlanes = luaRemoveDeadsFromTable(tPlanes)
	for i, pPlane in pairs (tPlanes) do
		if (pPlane.Class.ID ~= 166) then
			PilotRetreat(pPlane)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_DestroyersAttackingTheAirfield()
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	for i, pUnit in pairs (Mission.JAP_DestroyerGroup) do
		if (Mission.difficulty == 0) then
			SetSkillLevel(pUnit, SKILL_STUN)
		end
		NavigatorAttackMove(pUnit, Mission.USN_AirfieldHangar[1], {})
	end
end

------------------------------------------------------------------------------
function luaUSN04_PTReachedEvacZone(pUnit)
	RemoveTrigger(pUnit, "PTReachedEvacZone")
	NavigatorMoveToRange(pUnit, GetClosestBorderZone(GetPosition(pUnit)))
end

------------------------------------------------------------------------------
function CheckNumberOfJapPTs()
	Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
	--Checking target
	for i, pUnit in pairs (Mission.JAP_PT) do
		local pTarget = luaGetScriptTarget(pUnit)
		if (pTarget == nil) or ((pTarget ~= nil) and (pTarget.Dead)) then
			pTarget = luaUSN04_GetNearestConvoyShip(pUnit)
			luaSetScriptTarget(pUnit, pTarget)
			NavigatorAttackMove(pUnit, pTarget, {})
		end
	end
	nLength = table.getn(Mission.JAP_PT)
	if (nLength < Mission.NumberOfMaxPTs) then	-- MaxNumberOfPTsPhase2 volt korabban lecsereltem a kezdetire. Ha sok visszarakni.
-- RELEASE_LOGOFF  		luaLog("Keves volt a japan PT-k szama, feltoltottem +1-el")
		luaDelay(luaUSN04_JapPT_Spawn, 1, "szFunction", "luaUSN04_JapPT_Move_Phase2")
	end
end

------------------------------------------------------------------------------
function luaUSN04_JapPT_Move_Phase2(pEntity)
	if (pEntity ~= nil) then
		table.insert(Mission.JAP_PT, pEntity)
		TorpedoEnable(pEntity, true)
		--[[local nMaxSpeed = KTS(Mission.SpeedOfPTs)
		SetShipMaxSpeed(pEntity, nMaxSpeed)]]--
		Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
		--[[nRnd = luaRnd(1, table.getn(Mission.USNConvoy))
		luaSetScriptTarget(pEntity, Mission.USNConvoy[nRnd])]]--
		pTarget = luaUSN04_GetNearestConvoyShip(pEntity)
		luaSetScriptTarget(pEntity, pTarget)
		NavigatorAttackMove(pEntity, pTarget, {})
		--NavigatorAttackMove(pEntity, Mission.USNConvoy[nRnd], {})
	end
end

------------------------------------------------------------------------------
function luaUSN04_GetNearestConvoyShip(pEntity)
	local nMinDistance = 1000000
	local pTarget = nil
	for i, pUnit in pairs (Mission.USNConvoy) do
		local nActDistance = luaGetDistance(pUnit, pEntity)
		if (nActDistance < nMinDistance) and (not pUnit.Dead) then
			nMinDistance = nActDistance
			pTarget = pUnit
		end
	end
	return pTarget
end

------------------------------------------------------------------------------
function luaUSN04_LevelBombersSpawn()
	--local tNavpointTable = {"West02", "West03", "West05", "West06"}
	--[[local tNavpointTable = {"LB01", "LB02", "LB03"}
	nKey, nVal = luaPickRnd(tNavpointTable)]]
	local nKey = luaPickRnd(Mission.JAP_Navpoints_LB_Index)
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_LevelBombersSpawn): Spawnpoint Value = "..nKey)
	for i, pValue in pairs (Mission.JAP_Navpoints_LB_Index) do
		if (pValue == nKey) then
			table.remove(Mission.JAP_Navpoints_LB_Index, i)
		end
	end
	
	--local nPos = GetPosition(Mission.JAP_Navpoints_LB[nKey])
	local nPos = GetPosition(Mission.JAP_Navpoints_LB[nKey])
	nPos["y"] = 500
	local nLookAtPos = GetPosition(Mission.USN_AirfieldHangar[1])
	nLookAtPos["y"] = 500
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 166,
				["Name"] = "G3M Nell",
				["Crew"] = 1,
				["Race"] = JAPANESE,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = nPos,
			["angleRange"] = { 1, -1},
			["lookAt"] = nLookAtPos,
		},
		["callback"] = "luaUSN04_DelayLevelBomber",
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
function luaUSN04_DelayLevelBomber(pEntity)
	--SetGuiName(pEntity, "G3M Nell")
	SetPlaneGears(pEntity, GEARS_UP)
	SetSkillLevel(pEntity, SKILL_ELITE)
	local nRnd = 0
	Mission.LevelBombersSpawned = Mission.LevelBombersSpawned + 1
	if (Mission.LevelBombersSpawned == 1) then
		luaDelay(luaUSN04_EngineMovie_LevelBomberStart, 7)
	end
	table.insert(Mission.JAP_LevelBombers, pEntity)
	PilotSetTarget(pEntity, Mission.USN_AirfieldHangar[1])
	local altitude = luaPickRnd({370,420,470})
	SquadronSetTravelAlt(pEntity, altitude)
	SquadronSetAttackAlt(pEntity, altitude)
	SquadronSetReleaseAlt(pEntity, altitude)
	--PilotSetTarget(pEntity, Mission.SN_Airfield[1])
	Mission.JAP_LevelBombers = luaRemoveDeadsFromTable(Mission.JAP_LevelBombers)
	if (Mission.LevelBombersSpawned < Mission.MaxNumberOfLevelBombers) then
		--nRnd = luaRnd(16, 32)
		--nRnd = 35
		if (math.mod(Mission.LevelBombersSpawned, 4) == 0) then
			nRnd = luaRnd(25, 50)
			for i, pIndex in pairs (Mission.JAP_Navpoints_LB_Index_Original) do
				Mission.JAP_Navpoints_LB_Index[i] = pIndex
			end
		else
			nRnd = luaRnd(20, 35)
		end
		luaDelay(luaUSN04_LevelBombersSpawn, nRnd)
	end
end

------------------------------------------------------------------------------
function luaUSN04_EngineMovie_LevelBomberStart()
	Blackout(true, "luaUSN04_EngineMovie_LevelBomber", 0.5)
end

------------------------------------------------------------------------------
function luaUSN04_EngineMovie_LevelBomber()
	Mission.JAP_LevelBombers = luaRemoveDeadsFromTable(Mission.JAP_LevelBombers)
	luaUSN04_InvincibleUSNUnits()
	luaUSN04_InvincibleJAPUnits()
	luaUSN04_KillAllDialog()
	BlackBars(true)
	HideUnitHP()
	Mission.EMLastSelected = nil
	Mission.EMLastSelected = GetSelectedUnit()
	
	if (IsGUIActive("GUI_map")) then
		Mission.EMIsMapViewActive = true
	else
		Mission.EMIsMapViewActive = false
	end
	
	luaIngameMovie(
     {
     	--[[
       {["postype"] = "cameraandtarget", ["target"] = Mission.JAP_LevelBombers[1], ["distance"] = 50, ["theta"] = -50, ["rho"] = 180, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.JAP_LevelBombers[1], ["distance"] = 50, ["theta"] = -50, ["rho"] = 180, ["moveTime"] = 10, ["smoothtime"] = 2},
       ]]--
       {["postype"] = "cameraandtarget", ["target"] = Mission.JAP_LevelBombers[1], ["distance"] = 30, ["theta"] = 10, ["rho"] = 170, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = Mission.JAP_LevelBombers[1], ["distance"] = 30, ["theta"] = 10, ["rho"] = 170, ["moveTime"] = 10, ["smoothtime"] = 2},
  	},
  	luaUSN04_EM03_PreparingEnd,
  	true, nil, false
	)
	--Blackout(false, "", 2)
	luaDelay(luaUSN04_Dialog_Levelbomber_Attack, 2)
	--luaJumpinMovieSetCurrentMovie("JumpTo",Mission.JAP_LevelBombers[1].ID)
end

------------------------------------------------------------------------------
function luaUSN04_Dialog_Levelbomber_Attack()
	luaUSN04_StartDialog("Levelbomber_Attack")
end

------------------------------------------------------------------------------
function luaUSN04_CheckLevelBomberEvacuating()
	--Mission.JAP_LevelBombers = luaRemoveDeadsFromTable(Mission.JAP_LevelBombers)
	if (table.getn(Mission.JAP_LevelBombers) > 0) then
		for i, pBomber in pairs (Mission.JAP_LevelBombers) do
			if (not pBomber.Dead) and (pBomber.Retreat == nil) and (table.getn(GetPayloads(pBomber)) == 0) then
				pBomber.Retreat = true
				PilotRetreat(pBomber)
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_EM03_PreparingEnd()
	BlackBars(false)
	Blackout(true, "luaUSN04_EM03_End_BlackOut", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM03_End_BlackOut()
	if (Mission.EMLastSelected ~= nil) and (not Mission.EMLastSelected.Dead) then
		SetSelectedUnit(Mission.EMLastSelected)
	else
		local tTarget = luaUSN04_FindSelectableUnit()
		if (tTarget ~= nil) then
			SetSelectedUnit(tTarget)
		end
	end
	if (Mission.EMIsMapViewActive) then
		HackPressInput(IC_MAP_TOGGLE)
	end
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	EnableInput(true)
	Blackout(false, "luaUSN04_EM03_End", 2)
end

------------------------------------------------------------------------------
function luaUSN04_EM03_End()
	
	EnableMessages(true)
	luaUSN04_DamagableUSNUnits()
	luaUSN04_DamagableJAPUnits()

end

------------------------------------------------------------------------------
function luaUSN04_CheckNumberOfLevelBombers()
	Mission.JAP_LevelBombers = luaRemoveDeadsFromTable(Mission.JAP_LevelBombers)
	if (table.getn(Mission.JAP_LevelBombers) == 0) then
		Mission.MissionPhase = 100
		luaUSN04_LevelBombersEliminated()
	end
end

------------------------------------------------------------------------------
function luaUSN04_LevelBombersEliminated()
	--TODO: szoveget lockitbe felvenni
	luaObj_Completed("primary", 1)
	if (luaObj_IsActive("primary", 2) and (luaObj_GetSuccess("primary", 2) == nil)) then
		luaObj_Completed("primary", 2)
	end
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
		luaObj_Completed("secondary", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_LevelBombersEliminated): Secondary01 objective was completed")
	end
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_LevelBombersEliminated): hidden01 objective completed")
	end
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	for i, pShip in pairs (Mission.JAP_DestroyerGroup) do
		UnitHoldFire(pShip)
	end
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	for i = 1, table.getn(Mission.USNConvoy) do
		SetInvincible(Mission.USNConvoy[i], 1)
	end
	SetInvincible(Mission.USN_AirfieldHangar[1], 1)
	luaMissionCompletedNew(Mission.USN_AirfieldHangar[1], "usn04.obj_p1_compl")
	Mission.EndMission = true
	local medal = luaGetMedalReward()
	if (medal == MEDAL_SILVER) then
		Scoring_GrantBonus("US04_SCORING_GOLD", "usn04.bonus2_title", "usn04.bonus2_text", 118)
	end
	if (medal == MEDAL_GOLD) then
		Scoring_GrantBonus("US04_SCORING_GOLD", "usn04.bonus2_title", "usn04.bonus2_text", 118)
	end
end

------------------------------------------------------------------------------
function luaUSN04_PlayerPTsSpawnShipyard1()
	--TODO: nem spawnolni kell az amcsi PT-ket, hanem elerhetove tenni a shipyardban. Utananezni hogy kell.
-- RELEASE_LOGOFF  	luaLog("Shipyardoknal elerhetoek a PT-k")
	--[[AddShipyardStock(Mission.USN_Shipyard[1], 27, 6, "USN-PT, USN-PT2, USN-PT3, USN-PT4, USN-PT5, USN-PT6")
	AddShipyardStock(Mission.USN_Shipyard[2], 27, 6, "USN-PT7, USN-PT8, USN-PT9, USN-PT10, USN-PT11, USN-PT12")]]--
	--Mission.NeedUSNPTNamesCheck = true
	SupportManagerEnable(Mission.USN_Shipyard[1], true)
	SupportManagerEnable(Mission.USN_Shipyard[2], true)
	AddListener("generate", "Listener_ObjectGenerated", {
		["callback"] = "luaUSN04_ObjectGenerated",  -- callback fuggveny
		["entityName"] = {}, --{"USN-PT"}, -- string, a generalt template neve
		["entityType"] = {}, -- vehicleclasses.lua-bol a type parameter pl torpedoboat
	})
	luaUSN04_StartDialog("PT_Boats")
	Mission.PTAvailable = true
end

------------------------------------------------------------------------------
function luaUSN04_SetTargetUSNPT()
	if (Mission.PTAvailable) then
		Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
		Mission.JAP_PT = luaRemoveDeadsFromTable(Mission.JAP_PT)
		local tUnits = luaGetOwnUnits("ship", PARTY_ALLIED)
		for i, pShip in pairs (tUnits) do
			if (pShip.Class.ID == 27) and (pShip.FirstTarget == nil) then
				if (table.getn(Mission.JAP_DestroyerGroup) > 0) then
					local nIndex = luaUSN04_FindNearestTarget(pShip, Mission.JAP_DestroyerGroup)
					if (nIndex ~= 0) then
-- RELEASE_LOGOFF  						luaLog("(luaUSN04_SetTargetUSNPT): A spawnolt USN PT-nek talaltam DD targetet")
						NavigatorAttackMove(pShip, Mission.JAP_DestroyerGroup[nIndex])
						pShip.FirstTarget = true
					end
				elseif (table.getn(Mission.JAP_PT) > 0) then
					local nIndex = luaUSN04_FindNearestTarget(pShip, Mission.JAP_PT)
					if (nIndex ~= 0) then
-- RELEASE_LOGOFF  						luaLog("(luaUSN04_SetTargetUSNPT): A spawnolt USN PT-nek talaltam PT targetet")
						NavigatorAttackMove(pShip, Mission.JAP_PT[nIndex])
						pShip.FirstTarget = true
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_FindNearestTarget(pEntity, tTable)
	local nNearest = 100000
	local nIndex = 0
	for j, pTarget in pairs (tTable) do
		local nDistance = luaGetDistance(tTable[j], pEntity)
		if (nDistance < nNearest) then
			nNearest = nDistance
			nIndex = j
		end
	end
	return nIndex
end

------------------------------------------------------------------------------
function luaUSN11_ObjectGenerated_Delay()
	luaDelay(luaUSN04_SetTargetUSNPT, 1)
end

------------------------------------------------------------------------------
function luaUSN04_ObjectGenerated(...)
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_ObjectGenerated): USN PT was spawned")
	--[[if (string.find(arg[1], "PT-")) then
		Mission.PTAvailable = true
	end]]--
	
end

------------------------------------------------------------------------------
function luaUSN04_ObjectGenerated_Delayed()
end

------------------------------------------------------------------------------
function luaUSN04_PlayerPTsSpawnEndShipyard1()
-- RELEASE_LOGOFF  	luaLog("Shipyard 1-hez a player PT-k lespawnolodtak")
	-- luaUSN04_StartDialog("PT_Boats")
end

------------------------------------------------------------------------------
function luaUSN04_PlayerPTsSpawnShipyard2()
	for i = 1, 7 do
		local nRndPosX = luaRnd(-30, 30)
		local nRndPosY = luaRnd(-30, 30)
		local nSpawnPos = GetPosition(Mission.USN_Shipyard[2])
		nSpawnPos["x"] = nSpawnPos["x"] + nRndPosX
		nSpawnPos["y"] = nSpawnPos["y"] + nRndPosY
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 27,
					--TODO: szoveget lockitelni
					["Name"] = "Elco PT 80'",
					["Crew"] = 2,
					["Race"] = USA,
				},
			},
			["area"] = {
				["refPos"] = nSpawnPos,
				["angleRange"] = { DEG(0),DEG(180)},
				["lookAt"] = GetPosition(Mission.JAP_Navpoints["North02"])
			},
			["callback"] = "luaUSN04_PlayerPTsSpawnEndShipyard2",
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
function luaUSN04_CheckPlayerPlanesNum()
	if (Scoring_GetRealPlayTime() > 30) then
		local tPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)
		--luaLog("(luaUSN04_CheckPlayerPlanesNum): #1 Table Length = "..table.getn(tPlanes)..", Boolean = "..Mission.EnableHintSupportPlanes)
		if (table.getn(tPlanes) > 2) and (Mission.EnableHintSupportPlanes == 1) then
			--luaLog("(luaUSN04_CheckPlayerPlanesNum): Van repuloje a playernek es a boolean 1-es volt, atallitottam 0-ra")
			Mission.EnableHintSupportPlanes = 0
		end
		if (table.getn(tPlanes) < 3) and (Mission.EnableHintSupportPlanes == 0) then
			--luaLog("(luaUSN04_CheckPlayerPlanesNum): Nincs repuloje a playernek es a boolean 0-as volt, atallitottam 1-re")
			Mission.EnableHintSupportPlanes = 1
		end
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_CheckPlayerPlanesNum): #2 Table Length = "..table.getn(tPlanes)..", Boolean = "..Mission.EnableHintSupportPlanes)
		if (Mission.EnableHintSupportPlanes == 1) then
			--luaLog("(luaUSN04_CheckPlayerPlanesNum): Nincs repuloje a playernek, a hint megjelenik ha letelt a cooldown ( "..Mission.EnableHintSupportPlanes..")")
			ShowHint("USN04_Hint_SupportPlanes")
		else
			--luaLog("(luaUSN04_CheckPlayerPlanesNum): Van meg repuloje a playernek, a hint nem jelenik meg ( "..Mission.EnableHintSupportPlanes..")")
		end
	end
end

------------------------------------------------------------------------------
--[[function luaUSN04_CheckHidden()
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		if (table.getn(Mission.JAP_DestroyerGroup) == 0) then
			luaObj_Completed("hidden", 1)
-- RELEASE_LOGOFF  			luaLog("(luaUSN04_CheckHidden): Hidden objective Completed")
		end
	end
end]]--

------------------------------------------------------------------------------
function luaUSN04_FindSelectableUnit()
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
		return Mission.CommandCenter[1]
	else
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_FindSelectableUnit): A legelso szelektalhato unitot = "..tUnits[i].Name)
		return tUnits[i]
	end
end

------------------------------------------------------------------------------
function luaUSN04_InvincibleUSNUnits()
	local tUSNUnits = luaGetOwnUnits("", PARTY_ALLIED)
	for i, pUnit in pairs (tUSNUnits) do
		SetInvincible(pUnit, 1)
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_InvincibleUSNUnits): Az Allied egysegekre a sebezhetetlenseg rarakva")
end

------------------------------------------------------------------------------
function luaUSN04_DamagableUSNUnits()
	local tUSNUnits = luaGetOwnUnits("", PARTY_ALLIED)
	for i, pUnit in pairs (tUSNUnits) do
		SetInvincible(pUnit, 0)
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_DamagableUSNUnits): Az Allied egysegekrol a sebezhetetlenseg leszedve")
end

------------------------------------------------------------------------------
function luaUSN04_InvincibleJAPUnits()
	local tJAPUnits = luaGetOwnUnits("", PARTY_JAPANESE)
	for i, pUnit in pairs (tJAPUnits) do
		SetInvincible(pUnit, 1)
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_InvincibleUSNUnits): A Japan egysegekre a sebezhetetlenseg rarakva")
end

------------------------------------------------------------------------------
function luaUSN04_DamagableJAPUnits()
	local tJAPUnits = luaGetOwnUnits("", PARTY_JAPANESE)
	for i, pUnit in pairs (tJAPUnits) do
		SetInvincible(pUnit, 1)
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_DamagableJAPUnits): A Japan egysegekrol a sebezhetetlenseg leszedve")
end

------------------------------------------------------------------------------
function luaUSN04_KillAllDialog()
	local tDialogues = GetActDialogIDs()
	for i, pDialog in pairs (tDialogues) do
		KillDialog(pDialog)
	end
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_KillAllDialog): A queue-ban levo osszes dialog kinyirva")
end

------------------------------------------------------------------------------
function luaUSN04_TorpedoEnable(tShips, bBoolean)
	for i, pShip in (tShips) do
		TorpedoEnable(pShip, bBoolean)
	end
end

------------------------------------------------------------------------------
function luaUSN04_SetOwnPlaneAlt()
	local tOwnUnits = luaGetOwnUnits("plane", PARTY_ALLIED)
	for i, pPlane in pairs (tOwnUnits) do
		if (pPlane.SetAlt == nil) then
			SquadronSetAttackAlt(pPlane, Mission.Alt)
			SquadronSetTravelAlt(pPlane, Mission.Alt)
			pPlane.SetAlt = true
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_MissionFailed(pEntity, szMessage)
	if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) then
		luaObj_Failed("primary", 1)
	end
	if (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
		luaObj_Failed("primary", 2)
	end
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
		luaObj_Failed("secondary", 1)
	end
	if (luaObj_IsActive("hidden", 1)) and (luaObj_GetSuccess("hidden", 1) == nil) then
		luaObj_Failed("hidden", 1)
-- RELEASE_LOGOFF  		luaLog("(luaUSN04_MissionFailed): Hidden01 objective failed")
	end
	Mission.EndMission = true
	luaMissionFailedNew(pEntity, szMessage)
end

------------------------------------------------------------------------------
function luaUSN04SaveMissionData()
	Mission.Checkpoint.Dialogues = Mission.Dialogues
	Mission.Checkpoint.ConvoyWasSpotted = Mission.ConvoyWasSpotted
	Mission.Checkpoint.DelayOfConvoyAttacking = Mission.DelayOfConvoyAttacking
	Mission.Checkpoint.DestroyersAttack = Mission.DestroyersAttack
	Mission.Checkpoint.CarrierEvacEnable = Mission.CarrierEvacEnable
	Mission.Checkpoint.CarrierEvacState = Mission.CarrierEvacState
	Mission.Checkpoint.ConvoyDocking = Mission.ConvoyDocking
	Mission.Checkpoint.ConvoyReachedHarbour = Mission.ConvoyReachedHarbour
	Mission.Checkpoint.NumberOfJapPt = Mission.NumberOfJapPt
	Mission.Checkpoint.CargoEnteredArea = Mission.CargoEnteredArea
	Mission.Checkpoint.DummyCruiserSpawned = Mission.DummyCruiserSpawned
	Mission.Checkpoint.JAPPTCount = Mission.JAPPTCount
	Mission.Checkpoint.JAPPTNames = Mission.JAPPTNames
	Mission.Checkpoint.NumberOfAirfieldHit = Mission.NumberOfAirfieldHit
	Mission.Checkpoint.ConvoyDestroyed = Mission.ConvoyDestroyed
	Mission.Checkpoint.EnableHintSupportPlanes = Mission.EnableHintSupportPlanes
	Mission.Checkpoint.NeedDDDistanceCheck = Mission.NeedDDDistanceCheck
	Mission.Checkpoint.PTAvailable = Mission.PTAvailable
	Mission.Checkpoint.AirFieldHP = GetHpPercentage(Mission.USN_AirfieldHangar[1])
end

------------------------------------------------------------------------------
function luaUSN04LoadMissionData()
	Mission.Dialogues = Mission.Checkpoint.Dialogues
	Mission.ConvoyWasSpotted = Mission.Checkpoint.ConvoyWasSpotted
	Mission.DelayOfConvoyAttacking = Mission.Checkpoint.DelayOfConvoyAttacking
	Mission.DestroyersAttack = Mission.Checkpoint.DestroyersAttack
	Mission.CarrierEvacEnable = Mission.Checkpoint.CarrierEvacEnable
	Mission.CarrierEvacState = Mission.Checkpoint.CarrierEvacState
	--Mission.ConvoyDocking = Mission.Checkpoint.ConvoyDocking
	Mission.ConvoyDocking = true
	Mission.ConvoyReachedHarbour = Mission.Checkpoint.ConvoyReachedHarbour
	Mission.NumberOfJapPt = Mission.Checkpoint.NumberOfJapPt
	Mission.CargoEnteredArea = Mission.Checkpoint.CargoEnteredArea
	Mission.DummyCruiserSpawned = Mission.Checkpoint.DummyCruiserSpawned
	Mission.JAPPTCount = Mission.Checkpoint.JAPPTCount
	Mission.JAPPTNames = Mission.Checkpoint.JAPPTNames
	--Mission.JAP_PT = Mission.Checkpoint.JAP_PT
	Mission.NumberOfAirfieldHit = Mission.Checkpoint.NumberOfAirfieldHit
	Mission.ConvoyDestroyed = Mission.Checkpoint.ConvoyDestroyed
	Mission.EnableHintSupportPlanes = Mission.Checkpoint.EnableHintSupportPlanes
	Mission.NeedDDDistanceCheck = Mission.Checkpoint.NeedDDDistanceCheck
	Mission.PTAvailable = Mission.Checkpoint.PTAvailable
	Mission.CP_USNPositions = Mission.Checkpoint.USNPositions
	Mission.CP_IJNPositions = Mission.Checkpoint.IJNPositions
	MissionNarrativeClear()
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_SavePositions()
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
function luaUSN04_Checkpoint01_CleaningAndPutToPosition()
-- RELEASE_LOGOFF  	luaLog("------CHECKPOINT01: A unitok takaritasa es pozicionalasa kezdodik...------")
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_Checkpoint01_CleaningAndPutToPosition): USN Unitok")
	local tUSNUnits = luaGetCheckpointData("Units", "USUnits")
	tUSNUnits = tUSNUnits[1]
	--luaLog("(luaUSN04_Checkpoint01_CleaningAndPutToPosition): table hossz = "..table.getn(tUSNUnits))
	
	-- Mission.USN_Units tabla kitakaritasa
	--luaUSN04_Checkpoint01_CleanOrPut(Mission.USNConvoy, tUSNUnits, Mission.CP_USNPositions)
	luaUSN04_Checkpoint01_ConvoyCleanOrPut(tUSNUnits)
	Mission.USNConvoy = luaRemoveDeadsFromTable(Mission.USNConvoy)
	--Mission.ConvoyLength = table.getn(Mission.USNConvoy)
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	for i = 1, table.getn(Mission.USNConvoy) do
		SetRoleAvailable(Mission.USNConvoy[i], EROLF_ALL, PLAYER_AI)
	end
	
	--PETYA OPTIMALIZALAS ON
	--[[
	for i, pUnit in pairs (Mission.USN_P40s) do
		Kill(pUnit, true)
	end
	Mission.USN_P40s = luaRemoveDeadsFromTable(Mission.USN_P40s)
	
	--luaUSN04_Checkpoint01_PutToUSNPTs(tUSNUnits)
	]] 
	--PETYA OPTIMALIZALAS OFF
	
-- RELEASE_LOGOFF  	luaLog("(luaUSN04_Checkpoint01_CleaningAndPutToPosition): IJN Unitok")
	local tIJNUnits = luaGetCheckpointData("Units", "JapUnits")
	tIJNUnits = tIJNUnits[1]
	
	--Kezdo japan repulok	
	for i, pPlane in pairs (Mission.JAP_A6M) do
		Kill(pPlane, true)
	end
	Mission.JAP_A6M = luaRemoveDeadsFromTable(Mission.JAP_A6M)
	for i, pPlane in pairs (Mission.JAP_Bombers) do
		Kill(pPlane, true)
	end
	Mission.JAP_Bombers = luaRemoveDeadsFromTable(Mission.JAP_Bombers)
	
	-- Eszaki carrier es groupja
	--JAP_Carrier-re is
	local tTempTable = {}
	table.insert(tTempTable, Mission.JAP_Carrier)
	luaUSN04_Checkpoint01_CleanOrPut(tTempTable, tIJNUnits, Mission.CP_IJNPositions)
	luaUSN04_Checkpoint01_CleanOrPut(Mission.JAP_CarrierGroup, tIJNUnits, Mission.CP_IJNPositions)
	luaUSN04_Checkpoint01_CleanOrPut(Mission.JAP_DestroyerGroup, tIJNUnits, Mission.CP_IJNPositions)
	luaUSN04_Checkpoint01_PutToJapPTs(tIJNUnits)
	--Mission.JAP_Carrier = luaRemoveDeadsFromTable(Mission.JAP_Carrier)
	Mission.JAP_CarrierGroup = luaRemoveDeadsFromTable(Mission.JAP_CarrierGroup)
	Mission.JAP_DestroyerGroup = luaRemoveDeadsFromTable(Mission.JAP_DestroyerGroup)
	luaUSN04_Checkpoint01_CarrierGroupMove()
-- RELEASE_LOGOFF  	luaLog("------CHECKPOINT01: A unitok takaritasa es pozicionalasa Vege...------")
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_CarrierGroupMove()
	--[[luaLog(table.getn(Mission.JAP_DestroyerGroup))
-- RELEASE_LOGOFF  	luaLog(table.getn(Mission.JAP_CarrierGroup))]]--
-- RELEASE_LOGOFF  	luaLog("CarrierGroupMove meghivodott")
	if (table.getn(Mission.JAP_CarrierGroup) > 1) then
		for i = 2, table.getn(Mission.JAP_CarrierGroup) do
			if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
				JoinFormation(Mission.JAP_CarrierGroup[i], Mission.JAP_CarrierGroup[1])
-- RELEASE_LOGOFF  				luaLog("Carrier csatlakozott a formaciohoz")
			end
		end
	end
	NavigatorMoveToRange(Mission.JAP_CarrierGroup[1], Mission.JAP_Navpoints["North03"])
	for i = 1, table.getn(Mission.JAP_CarrierGroup) do
		if (Mission.JAP_CarrierGroup[i].Class.ID ~= 275) then
			AddProximityTrigger(Mission.JAP_CarrierGroup[i], "JAP_CarrierGroupReachedNavPoint", "luaUSN04_CarrierGroupReachedNavPoint", Mission.JAP_Navpoints["North03"], 100)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_ConvoyCleanOrPut(tNationTable)
	for i, pShip in pairs (Mission.USNConvoy) do
		local bIsUnitAlive, j = luaUSN04_Checkpoint01_SearchInTable(pShip.Name, tNationTable)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos = GetPosition(Mission.ConvoyLandingPoints[i])
			PutTo(pShip, tPos, 180)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_PutToUSNPTs(tUSNUnits)
	Mission.CP_USNPTs = 0
	for i, tUnit in pairs (tUSNUnits) do
		if (tUnit[3] == 27) then
			--luaLog(tUnit[1])
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN04_Checkpoint01_GetUnitPos(tUnit[1], Mission.CP_USNPositions)
			local tRotation = 360 - tRot["y"]
			tUnitTemplate = luaFindHidden("CP_USNPT")
			pUnit = GenerateObject(tUnitTemplate.Name, tUnit[1])
			PutTo(pUnit, tPos, tRotation)
			TorpedoEnable(pUnit, true)
			Mission.CP_USNPTs = Mission.CP_USNPTs + 1
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_MoveUSNPTs(pEntity)
	TorpedoEnable(pEntity, true)
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_PutToJapPTs(tIJNUnits)
	for i, tUnit in pairs (tIJNUnits) do
		if (tUnit[3] == 77) then
			--luaLog("CP_PT: "..i)
			tUnitTemplate = luaFindHidden("CP_PT")
			pUnit = GenerateObject(tUnitTemplate.Name, tUnit[1])
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN04_Checkpoint01_GetUnitPos(tUnit[1], Mission.CP_IJNPositions)
			local tRotation = 360 - tRot["y"]
			PutTo(pUnit, tPos, tRotation)
			table.insert(Mission.JAP_PT, pUnit)
			TorpedoEnable(pUnit, true)
			nRnd = luaRnd(1, table.getn(Mission.USNConvoy))
			luaSetScriptTarget(pUnit, Mission.USNConvoy[nRnd])
			NavigatorAttackMove(pUnit, Mission.USNConvoy[nRnd], {})
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_CleanOrPut(tUnitTable, tNationTable, tPositionTable)
	for i, pShip in pairs (tUnitTable) do
		local bIsUnitAlive, j = luaUSN04_Checkpoint01_SearchInTable(pShip.Name, tNationTable)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUSN04_Checkpoint01_GetUnitPos(pShip.Name, tPositionTable)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_SearchInTable(szName, tTable)
	local j = 0
	local bIsUnitAlive = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUSN04_Checkpoint01_SearchInTable): szName = "..szName)
	--luaLog("(luaUSN04_Checkpoint01_SearchInTable): table hossz = "..nLength)
	while (j < nLength) and (not bIsUnitAlive) do
		j = j + 1
		--luaLog("(luaUSN04_Checkpoint01_SearchInTable): US tablaban az akt nev = "..tTable[j].Name)
		--luaLog(tTable[j][1])
		if (szName == tTable[j][1]) then
			bIsUnitAlive = true
		end
	end
	--luaLog("(luaUSN04_Checkpoint01_SearchInTable): Visszatero boolean = ")
	--luaLog(bIsUnitAlive)
	return bIsUnitAlive, j
end

------------------------------------------------------------------------------
function luaUSN04_Checkpoint01_GetUnitPos(szName, tTable)
	local j = 0
	local bFound = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUSN04_Checkpoint01_GetUnitPos): Table hossz = ")
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
function luaUSN04_Checkpoint01_Prepare()
	if (Mission.CP_USNPTs > 0) then
		local nMod = math.mod(Mission.CP_USNPTs, 2)
		local nHalf = math.floor(Mission.CP_USNPTs / 2)
		if (nMod == 0) then
			RemoveShipyardStock(Mission.USN_Shipyard[1], 27, nHalf)
			RemoveShipyardStock(Mission.USN_Shipyard[2], 27, nHalf)
		else
			RemoveShipyardStock(Mission.USN_Shipyard[1], 27, (nHalf+1))
			if (nHalf > 0) then
				RemoveShipyardStock(Mission.USN_Shipyard[2], 27, nHalf)
			end
		end
	end

	SetAirBaseSlotReady(Mission.USN_Airfield[1], 1)
	SetAirBaseSlotReady(Mission.USN_Airfield[1], 2)
	
	
	local nDamage = Mission.AirFieldHP * (1 - Mission.Checkpoint.AirFieldHP)
	if (nDamage ~= 0) then
		AddDamage(Mission.USN_AirfieldHangar[1], nDamage)
	end
	
	--DisplayUnitHP(Mission.USN_AirfieldHangar, "usn04.unithp01")
	DisplayUnitHP(Mission.USN_Airfield, "usn04.unithp01")
	Mission.ConvoyLength = 7 - Mission.ConvoyDestroyed
	--DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	DisplayScores(1, 0, "usn04.score02", "usn04.score01")
	luaUSN04_TimerStarts_ConvoyDefend()
	--hidden listener
	if (not IsListenerActive("kill", "Listener_DestroyerKilled")) and (table.getn(Mission.JAP_DestroyerGroup) > 0) then
		AddListener("kill", "Listener_DestroyerKilled", 
		{
			["callback"] = "luaUSN04_DestroyerKilled",
			["entity"] = Mission.JAP_DestroyerGroup,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	end
	Blackout(true, "", 0)
end

------------------------------------------------------------------------------
function luaUSN04_PlayerPTsSpawnEndShipyard2()
-- RELEASE_LOGOFF  	luaLog("Shipyard 2-hoz a player PT-k lespawnolodtak")
end

------------------------------------------------------------------------------
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(172)		-- Jake
	PrepareClass(162)		-- Kate
	PrepareClass(317)		-- Northampton
	PrepareClass(77)		-- Japanese Light PT
	PrepareClass(166)		-- G3M Nell
	PrepareClass(27)		-- Elco PT 80'
	PrepareClass(150)		-- Zero
	PrepareClass(158)		-- Val
	--PrepareClass(135)		-- P40 Warhawk
	PrepareClass(101)		-- F4F Wildcat
	--PrepareClass(102)		-- F4U Corsair (rocket1 powerupnak)
	--PrepareClass(45)		-- Kamikaze A6M Zero (rocket1 powerup-nak kell, mert egyebkent fagy)
	--PrepareClass(104)		-- P38 Lightning
	PrepareClass(68)		-- Tone-Class
	PrepareClass(275)		-- Akizuki-Class
	PrepareClass(37)		-- US Cargo Transport
	PrepareClass(234)		-- US Troop Transport
	--PrepareClass(154)		-- Ki-43 Oscar
	--PrepareClass(152)		-- Gekko
	--PrepareClass(167)		-- G4M Betty
	Loading_Finish()
end

------------------------------------------------------------------------------
function test1()
	for i = 1, table.getn(Mission.USNConvoy) do
		SetInvincible(Mission.USNConvoy[i], true)
	end
-- RELEASE_LOGOFF  	LogToConsole("A convoy sebezhetetlen")
-- RELEASE_LOGOFF  	luaLog("A convoy sebezhetetlen")
end
function test2()
	for i = 1, table.getn(Mission.USNConvoy) do
		SetInvincible(Mission.USNConvoy[i], false)
	end
-- RELEASE_LOGOFF  	LogToConsole("A convoy sebezheto")
-- RELEASE_LOGOFF  	luaLog("A convoy sebezheto")
end
function test3()
	SetInvincible(Mission.USN_AirfieldHangar[1], 1)
	SetInvincible(Mission.USN_Airfield[1], 1)
	--Mission.NumberOfMaxAirfieldHit = 100
end
function test4()
	SetInvincible(Mission.USN_AirfieldHangar[1], 0)
	SetInvincible(Mission.USN_Airfield[1], 0)
	--Mission.NumberOfMaxAirfieldHit = 9
end
function luaUSN04Phase()
	Mission.CargoEnteredArea = true
	Mission.ConvoyReachedHarbour = table.getn(Mission.USNConvoy)
	luaUSN04_JapPT_CruiserSpawn()
end
