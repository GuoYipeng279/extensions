--SceneFile="universe\Scenes\missions\Challenge\monstre.scn"

function luaPrecacheUnits()
	
	PrepareClass(25)	-- Clemson
	--PrepareClass(23)	-- Fletcher
	PrepareClass(288)	-- Farragut
	PrepareClass(296)	-- Gleaves
	PrepareClass(265)	-- Icarus
	PrepareClass(11)	-- AMS
	PrepareClass(17)	-- Atlanta
	--PrepareClass(27)	-- Elco
	PrepareClass(9)		-- KGV
	PrepareClass(10)	-- Renown
	PrepareClass(13)	-- NewYork
	PrepareClass(317)	-- Northampton
	
end

function luaStageInit()
	CreateScript("luaInitSCMonstreMission")
end

function luaInitSCMonstreMission(this)
	Mission = this
	this.Name = "scmonstre"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("sc1")
	LoadSelectedPaths()

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)
	this.Tick = 3
	this.PTNum = 0
	this.MissionPhase = 1
	this.SpawnPrevTime = -1000	-- az elozo spawnolas idopontja, kezdetben magas, hogy gyorsan jojjenek
	this.SpawnTimeLimit = 45	-- min ennyi idon tul general uj ellenseget
	this.PrevScore = 0		-- elozo ellenorzesenkenti tickben vizsgalt pontszam
	this.SupportPool = 0		-- ebbol a pontszambol lehet supportalo repuloket spawnolni
	this.SpawnFailed = 0		-- nehanyszor elbukhatja a spawnt, de sokszor nem, mert vegtelen ciklus az eredmenye
	this.PrevWarnTime = 0		-- jegyezzuk, mikor figyelmeztettuk a jatekost a legvegen, ha mar kiert, de van korulotte enemy
	
--	luaGenerateRandomClouds(20, {{["x"]=-7500, ["y"]=1000, ["z"]=-2500}, {["x"]=6000, ["y"]=1200, ["z"]=2500}}, 5, 3, 1)
	
	--this.WaveLimit = 1000		-- ha ennyi pont ala csokken az aktualis hullam osszpontszama, akkor johet az uj hullam (ujhullam, hahahaha !)
	this.WaveLimit = 2		-- ha ennyi darab ala csokken az aktualis hullam unitszama, akkor johet az uj hullam (ujhullam, hahahaha !)
	this.WaveNum = 0		-- inicializalas az aktualis hullam jelzesehez
	this.CurrentWave = {}		-- itt fognak szerepelni az aktualis unitok
	this.CurrentSpawnNum = 0	-- a spawnolt unitokat szamolja

	this.FinalMonsta = {}		-- ez lesz a vegso enemy
	
		-- kezdeti sulyozasok
	this.WeightPT = 0
	this.WeightDD = 0
	this.WeightCL = 0
		-- unitszamhatarok tipusonkent Allied oldalon
	this.PTLimit = 7
	this.DDLimit = 3
	this.CLLimit = 2
		-- unitszamlimitek tipusonkent Japanese oldalon
	this.FighterLimit = 2
	this.DiveBomberLimit = 2
	this.TorpedoBomberLimit = 2
	this.ReconPlaneLimit = 1
	
	--luaSCMonstreInitScoreHandling()

	--[[
	this.ScoreLimit = Mission.Score.BattleShip
-- RELEASE_LOGOFF  	luaLog("Scoringtest BB: "..this.ScoreLimit)
-- RELEASE_LOGOFF  	luaLog("Scoringtest DD: "..Mission.Score.Destroyer)
-- RELEASE_LOGOFF  	luaLog("Scoringtest PT: "..Mission.Score.TorpedoBoat)
	]]
	
	this.TargetPoint = {}
		this.TargetPoint.x = -7000
		this.TargetPoint.y = 0
		this.TargetPoint.z = 5600
	
	-- allied objektumok
	this.Bombers = {}
	
--	PrepareClass(118)	-- B-25

	-- tamadohullamok definialasa
	this.KongoKillers = {}
--		table.insert(this.KongoKillers, luaFindHidden("PT-134"))
--		table.insert(this.KongoKillers, luaFindHidden("PT-135"))
--		table.insert(this.KongoKillers, luaFindHidden("PT-136"))
		table.insert(this.KongoKillers, luaFindHidden("Waters"))
		table.insert(this.KongoKillers, luaFindHidden("Mac Donough"))
		table.insert(this.KongoKillers, luaFindHidden("Ward"))

	this.Waves = {}
	
	local wave1 = {}	-- clemsons, pt
		table.insert(wave1, luaFindHidden("Alden"))		-- DD
		table.insert(wave1, luaFindHidden("Barker"))	-- DD
		table.insert(wave1, luaFindHidden("Pillsbury"))	-- DD
--		table.insert(wave1, luaFindHidden("PT-112"))		-- PT

	
	local wave2 = {}	-- fletchers, pt
		table.insert(wave2, luaFindHidden("John D.Edwards"))	-- DD
		table.insert(wave2, luaFindHidden("Gwin"))	-- DD
		table.insert(wave2, luaFindHidden("Maury"))	-- DD
		table.insert(wave2, luaFindHidden("McCall"))
		--table.insert(wave2, luaFindHidden("PT-113"))		-- PT

	local wave3 = {}	-- fletchers, cls, pt
		table.insert(wave3, luaFindHidden("Oakland"))	-- CL
		table.insert(wave3, luaFindHidden("Atlanta"))	-- CL
		table.insert(wave3, luaFindHidden("Russel"))	-- DD
--		table.insert(wave3, luaFindHidden("PT-114"))		-- PT

	local wave4 = {}	-- fletcher, CAs, pt
		table.insert(wave4, luaFindHidden("Northampton"))	-- CA
		table.insert(wave4, luaFindHidden("Chicago"))	-- CA
		table.insert(wave4, luaFindHidden("Phelps"))	-- DD
		
	local wave5 = {}	-- BB, fletchers
		table.insert(wave5, luaFindHidden("New York"))	-- BB
		table.insert(wave5, luaFindHidden("Schley"))		-- DD
		table.insert(wave5, luaFindHidden("Sims"))		-- DD
		--table.insert(wave5, luaFindHidden("PT-116"))		-- PT

	local wave6 = {}	-- BB, fletchers
		--table.insert(wave6, luaFindHidden("Prince of Wales"))	-- BB	-- a vegen jonne
		table.insert(wave6, luaFindHidden("Repulse"))		-- BB
		table.insert(wave6, luaFindHidden("Arrow"))		-- DD

		-- vegso tablafeltoltes
	table.insert(this.Waves, wave1)
	table.insert(this.Waves, wave2)
	--table.insert(this.Waves, wave3)
	table.insert(this.Waves, wave4)
	table.insert(this.Waves, wave5)
	table.insert(this.Waves, wave6)

	Mission.WaveMaxNum = luaCountTable(Mission.Waves)
	
	-- planes
	--this.StrikerTmpl = luaFindHidden("B-25 Mitchell")
	
--[[ old scoring

	-- DDs

	this.DDNames = {}
		table.insert(this.DDNames, luaFindHidden("Alden"))
		table.insert(this.DDNames, luaFindHidden("Barken"))
		table.insert(this.DDNames, luaFindHidden("John D. Edwards"))
		table.insert(this.DDNames, luaFindHidden("Pillsbury"))
		table.insert(this.DDNames, luaFindHidden("Gwin"))
		table.insert(this.DDNames, luaFindHidden("Chew"))
		table.insert(this.DDNames, luaFindHidden("Waters"))
		table.insert(this.DDNames, luaFindHidden("Russel"))
		table.insert(this.DDNames, luaFindHidden("Mac Donough"))
		table.insert(this.DDNames, luaFindHidden("Maury"))
		table.insert(this.DDNames, luaFindHidden("Phelps"))
		table.insert(this.DDNames, luaFindHidden("Sands"))
		table.insert(this.DDNames, luaFindHidden("Sims"))
		table.insert(this.DDNames, luaFindHidden("Ward"))
		table.insert(this.DDNames, luaFindHidden("McCall"))
		table.insert(this.DDNames, luaFindHidden("Downes"))
			
	Mission.DDNameTemplate = "Alden"
	
	-- old: TODO -> csak nevvaltas legyen, ne unit - obsolete!
	this.HiddenDDs = {}	-- rejtett objektumok
		table.insert(this.HiddenDDs, luaFindHidden("Alden"))
		table.insert(this.HiddenDDs, luaFindHidden("Barken"))
		table.insert(this.HiddenDDs, luaFindHidden("John D. Edwards"))
		table.insert(this.HiddenDDs, luaFindHidden("Pillsbury"))
		table.insert(this.HiddenDDs, luaFindHidden("Gwin"))
		table.insert(this.HiddenDDs, luaFindHidden("Chew"))
		table.insert(this.HiddenDDs, luaFindHidden("Waters"))
		table.insert(this.HiddenDDs, luaFindHidden("Russel"))
	
	this.DDs = {}	-- mar bent levo objektumok
	
	-- PTs
	this.HiddenPT = luaFindHidden("PT-")
	this.PTs = {}
	
	-- CLs
	this.CLNameTemplate = "Oakland"
	this.CLNames = {}
		table.insert(this.CLNames, luaFindHidden("Oakland"))
		table.insert(this.CLNames, luaFindHidden("Juneau"))
		table.insert(this.CLNames, luaFindHidden("Atlanta"))
		table.insert(this.CLNames, luaFindHidden("Detroit"))
		table.insert(this.CLNames, luaFindHidden("Honolulu"))
		
--	this.HiddenCLs = {}	-- rejtett objektumok	- obsolete!
--		table.insert(this.HiddenCLs, luaFindHidden("Oakland"))
	this.CLs = {}	-- mar bent levo objektumok
	
	this.HiddenBBs = {}
		table.insert(this.HiddenBBs, luaFindHidden("New York"))
		table.insert(this.HiddenBBs, luaFindHidden("Repulse"))
		table.insert(this.HiddenBBs, luaFindHidden("Prince of Wales"))
	
	this.BBs = {}
]]

	-- Japanese objektumok
	this.Fuso = FindEntity("Fuso")
	this.HiddenKongo = luaFindHidden("Yamashiro")
	Mission.YamashiroTime = 540
	AddWatch("Mission.MissionTime")
	
	RepairEnable(FindEntity("Fuso"), false)
	
	SetCatapultStock(FindEntity("Fuso"), 0)
	
	--luaSCMonstreCheckSquadSpeeds()	-- inicializaljuk a bejovo repulok sebesseget figyelo fv-t (kozel a fusohoz lelassitja oket)
	
	-- tmp for debug
	--SetShipMaxSpeed(Mission.Fuso, GetShipMaxSpeed(Mission.Fuso)*10)
	
	-- difficulty settings for Fuso
	local diff = GetDifficulty()
	if diff == DIFF_ROOKIE then
		SetCrewLevel(Mission.Fuso, DIFF_VETERAN)
		SetShipMaxSpeed(Mission.Fuso, GetShipMaxSpeed(Mission.Fuso)*1.2)
	elseif diff == DIFF_REGULAR then
		SetCrewLevel(Mission.Fuso, DIFF_REGULAR)
	elseif diff == DIFF_VETERAN then
		SetCrewLevel(Mission.Fuso, DIFF_REGULAR)
	end
	
	this.OrigDistance = luaGetDistance(this.Fuso, this.TargetPoint)	-- eredeti tavolsag merese
	
	this.Support = {}	-- ezek lesznek a tamogatogepek
	this.HiddenSupport = {}
		table.insert(this.HiddenSupport, luaFindHidden("B5N Kate"))
		table.insert(this.HiddenSupport, luaFindHidden("D3A Val"))
		
	--this.ScoreSupport = {}	-- ezek lesznek a pont alapjan behozott tamogatogepek
	--luaSCMonstreInitSpawnableTypes()
	
	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
	this.Objectives =
	{
		["primary"] =
		{
			[1] = 
			{
				["ID"] = "ReachPoint",		-- azonosito
				["Text"] = "Reach the evac point to escape the area!",		-- sc1-obj_p1
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] =  2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0,	-- bukasert jaro (negativ) pontszam
				["Remind"]= true
			},
			[2] = 
			{
				["ID"] = "Survival",		-- azonosito
				["Text"] = "The Fuso must survive!",		-- sc1-obj_p1
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0,	-- bukasert jaro (negativ) pontszam
			}
		},
		["secondary"] =
		{
			[1] = 
			{
				["ID"] = "SaveKongo",		-- azonosito
				--["Text"] = "Kongo must survive",		-- sc1-obj_p1
				["Text"] = "The Yamashiro must survive!",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0,	-- bukasert jaro (negativ) pontszam
			}
		},
		["hidden"] =
		{
			[1] = 
			{
				["ID"] = "KillemAll",		-- azonosito
				--["Text"] = "Eliminate every Allied wave",
				["Text"] = "Eliminate every allied wave!",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1500*OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0,	-- bukasert jaro (negativ) pontszam
			}
		},
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil

	--AddWatch("Mission.Pool")
	--AddWatch("Mission.SupportPool")
	--AddWatch("Mission.PrevScore")
	AddWatch("Mission.Distance")
	AddWatch("Mission.Music")

--[[

	-- ha valaki ralott a jatekosra, akkor valtunk action musicra
	AddListener("hit", "playerHit", {
		["callback"] = "luaMonstrePlayerHit",
		["bantott"] = {this.Fuso},
		["banto"] = {},
		["bantas"] = {}, -- "MACHINEGUN", "AAMACHINEGUN", "LIGHTARTILLERY", "MEDIUMARTILLERY", "HEAVYARTILLERY", "BOMB", "TORPEDO", "DEPTHCHARGE", "DUMMYTARGET", "FLAK"
		["bantoPlayerIndex"] = {}, -- [PLAYER_1..PLAYER_32]
	})
]]

	-- music
	Music_Control_SetLevel(MUSIC_CALM)
	Mission.Music = MUSIC_CALM

	local gullPts = {
			GetPosition(FindEntity("Navpoint")),
			GetPosition(FindEntity("Navpoint_2")),
			GetPosition(FindEntity("Navpoint_3")),
		}

	for idx,pos in pairs(gullPts) do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = pos,
			["tempID"] = "siraly"..tostring(idx),
		})
		--table.insert(this.Gulls, "siraly"..tostring(idx))
	end
	
	-- tiltozonak
	-- 	parosaval kell berakni, a masodik tablaban az ugyanazon key-u zonatol mert tavolsagot kell megadni
	--	ha ezen belul poppol egy unit, akkor odebb lesz pakolva
	this.RestrictionZones = {}
	this.RestrictionZoneDistances = {}
	table.insert(this.RestrictionZones, FindEntity("RestrictionZone1"))
	table.insert(this.RestrictionZoneDistances, 650)
	
	--SetInvincible(FindEntity("Fuso"))
	
	Blackout(true, "", true)
	
	SetThink(this, "luaSCMonstre_think")
end

function luaSCMonstre_think(this, msg)
-- RELEASE_LOGOFF  	luaLog("-------------------------------------------")
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")
	
	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)
-- RELEASE_LOGOFF  	luaLog("-------------------------------------------")
	
	if this.MissionEnd then
		return
	end
	
	if this.Cheat_PhaseShift then
		this.Cheat_PhaseShift = false
-- RELEASE_LOGOFF  		luaLog("Cheating wavekill")
		
		for key, value in pairs(Mission.CurrentWave) do
			Kill(value)
		end
	end
	
	this.Tick = this.Tick + 1
	
	this.MissionTime = GameTime()
	
	--if this.Fuso.Dead and this.Fuso.KillReason ~= "exitzone" then
	if this.Fuso.Dead then
-- RELEASE_LOGOFF  		luaLog("-->> Fuso has been destroyed, mission failed!")
		this.MissionEnd = true
		--MissionNarrative("Fuso has been destroyed. Mission failed.", "EndScene")
		if this.Fuso.KillReason == "exitzone" then
			local enemy = luaGetShipsAroundCoordinate(this.Fuso.LastPosition, 3000, PARTY_ALLIED, "enemy")
			if enemy ~= nil then
-- RELEASE_LOGOFF  				luaLog(" enemy around when exit...")
				luaSCMonstreAddAndFailHiddens()
				luaMissionFailedNew(luaPickRnd(enemy), "The Fuso was unable to flee due to enemy shipping.")	-- sc1-fail_exit
			else
-- RELEASE_LOGOFF  				luaLog(" no enemy around when exit...")
				luaSCMonstreAddAndFailHiddens()
				luaMissionFailedNew(this.Fuso, "The Fuso was unable to flee due to enemy shipping.")	-- sc1-fail_exit
			end
		else
			luaSCMonstreAddAndFailHiddens()
			luaMissionFailedNew(this.Fuso, "The Fuso is sinking.")	-- sc1-fail_destroyed
		end
		return
	end
	
	if this.Kongo and this.Kongo.Dead and not this.KongoDeath then
-- RELEASE_LOGOFF  		luaLog("Kongo killed")
		MissionNarrative("The Yamashiro is sinking!")	-- sc1-nar_KongoKilled
		HideUnitHP()
		luaObj_Failed("secondary", 1, true)
		this.KongoDeath = true
		this.KongoKillers = luaRemoveDeadsFromTable(this.KongoKillers)
		for key, value in pairs(this.KongoKillers) do
-- RELEASE_LOGOFF  			luaLog(value.Name.." is attacking Fuso")
			NavigatorAttackMove(value, this.Fuso, {})
			SetFireTarget(value, this.Fuso)
		end
	end
	
	this.Distance = luaGetDistance(this.Fuso, this.TargetPoint)
	
	Mission.Enemies = luaGetShipsAround(this.Fuso, 3000, "enemy")
	
	if (this.Distance < this.OrigDistance*2/3 or GameTime() > Mission.YamashiroTime) and not this.Kongo then
-- RELEASE_LOGOFF  		luaLog("Kongo distance reached or time limit reached...")
		luaSCMonstreKongoSpawn()
		luaDelay(luaSCMonstreSpawnKongoKillers, 60)
	elseif this.Distance < 500 and this.FinalMonsta.Dead and not Mission.Enemies then
-- RELEASE_LOGOFF  		luaLog("-->> Targetpoint reached, mission succeeded!")
		this.MissionEnd = true
		--Scoring_SetRanking(MEDAL_GOLD)
		
		if not this.Kongo.Dead then
			luaObj_Completed("secondary", 1)
		end
		
		if this.WavesKilled then
			luaObj_Add("hidden", 1)
			luaObj_Completed("hidden", 1)
		end
		
		HideScoreDisplay(1,0)
		luaObj_Completed("primary", 1)
		luaObj_Completed("primary", 2)
		
		luaSCMonstreAddAndFailHiddens()
		luaMissionCompletedNew(this.Fuso, "Meeting zone has been reached!")	-- sc1-obj_p1_comp
		return
	elseif this.Distance < 500 and (not this.FinalMonsta.Dead or enemy) and GameTime()-this.PrevWarnTime > 20 then
		MissionNarrative("Clear the area before leaving!")	-- sc1-nar_ClrArea
		this.PrevWarnTime = GameTime()
	end
	
	--luaSCMonstreCheckEnemies(this)
	
	luaSCMonstreCheckAllied(this)
	
	if this.MissionPhase == 1 then
		if not this.FirstNarr then
-- RELEASE_LOGOFF  			luaLog("Blackout called")
			Blackout(true, "", true)
			luaSCMonstreShowNarr1()
			luaSCMonstreIntro()	-- cam kezelese
			
			--EnableInput(false)
			
			this.FirstNarr = true
		end
	elseif this.MissionPhase == 2 then
-- RELEASE_LOGOFF  		luaLog("Adding objective")
		luaObj_Add("primary", 1, this.TargetPoint)
		luaObj_Add("primary", 2, this.Fuso, true)
		luaDistanceCounter(this.Fuso, this.TargetPoint, 1, "Reach the evac point to escape the area!", "ijn14.distance")
		--luaSCMonstreCheckSupport()	-- ezt kell aktivalni es a regi poolos modszerrel spawnolodnak az enemyk
		luaSCMonstreCheckWaves()	-- ez az uj hullamos Spawn alapja
		
		if Mission.Enemies then
			Mission.EnemiesBefore = luaSumTables(Mission.Enemies)
		end
	end
	
	--luaSCMonstreCheckMusic()
	luaCheckMusic(Mission.Fuso, 2500)
end

function luaSCMonstreCheckEnemies(this)
-- RELEASE_LOGOFF  	luaLog("Checking enemies...")
	this.DDs = luaRemoveDeadsFromTable(this.DDs)
	this.PTs = luaRemoveDeadsFromTable(this.PTs)
	this.CLs = luaRemoveDeadsFromTable(this.CLs)

	local score = luaSCMonstreGetScore(this.DDs) + luaSCMonstreGetScore(this.PTs) + luaSCMonstreGetScore(this.CLs)
-- RELEASE_LOGOFF  	luaLog(" Current score: "..tostring(score))

	-- itt csekkeljuk, mennyi pontszam esett ki (lotte ki a jatekos)
	if score < this.PrevScore then
		this.SupportPool = this.PrevScore - score
-- RELEASE_LOGOFF  		luaLog("Score decreased by "..tostring(this.SupportPool))
	else
		this.SupportPool = 0
	end
	
	this.PrevScore = score
	
	if GameTime() - this.SpawnPrevTime < this.SpawnTimeLimit then
		return
	else
		this.SpawnPrevTime = GameTime()
-- RELEASE_LOGOFF  		luaLog("Time to spawn something...")
	end

	if score < this.ScoreLimit then
-- RELEASE_LOGOFF  		luaLog("Enemy numbers under limit!")
		this.Pool = this.ScoreLimit - score
-- RELEASE_LOGOFF  		luaLog(" Pool: "..this.Pool)
	else
		return
	end
	
	local ptNum = luaCountTable(this.PTs)
	if ptNum >= this.PTLimit or this.Pool - Mission.Score.TorpedoBoat < 0 then
-- RELEASE_LOGOFF  		luaLog("No chance to spawn Torpedoboat")
		this.WeightPT = 0
	else
		if ptNum == 0 then
			ptNum = nil
		end
		this.WeightPT = Mission.Score.TorpedoBoat*5 / (ptNum or 1)
-- RELEASE_LOGOFF  		luaLog("Weight to spawn torpedoboat: "..this.WeightPT)
	end

	local ddNum = luaCountTable(this.DDs)
	if ddNum >= this.DDLimit or this.Pool - Mission.Score.Destroyer < 0 or luaCountTable(this.HiddenDDs) == 0 then
-- RELEASE_LOGOFF  		luaLog("No chance to spawn Destroyer")
		this.WeightDD = 0
	else
		if ddNum == 0 then
			ddNum = nil
		end
		this.WeightDD = Mission.Score.Destroyer / (ddNum or 1)
-- RELEASE_LOGOFF  		luaLog("Weight to spawn destroyer: "..this.WeightDD)
	end
	
	local clNum = luaCountTable(this.CLs)
	--if clNum >= this.CLLimit or this.Pool - Mission.Score.Cruiser < 0 or luaCountTable(this.HiddenCLs) == 0 then
	if clNum >= this.CLLimit or this.Pool - Mission.Score.Cruiser < 0 or luaCountTable(this.CLNames) == 0 then
-- RELEASE_LOGOFF  		luaLog("No chance to spawn Cruiser")
		this.WeightCL = 0
	else
		if clNum == 0 then
			clNum = nil
		end
		this.WeightCL = Mission.Score.Cruiser / (clNum or 1)
-- RELEASE_LOGOFF  		luaLog("Weight to spawn cruiser: "..this.WeightCL)
	end
	
	luaPickInRange(luaSCMonstreSpawnPT, this.WeightPT, luaSCMonstreSpawnDD, this.WeightDD, luaSCMonstreSpawnCL, this.WeightCL)()
end

function luaSCMonstreInitScoreHandling()
-- RELEASE_LOGOFF  	luaLog("Initializing scorehandling")
	
	DoFile("scripts/datatables/Scoring.lua")
	Mission.Score = {}
	Mission.Score.BattleShip = Scoring.kill.battleship
	Mission.Score.MotherShip = Scoring.kill.mothership
	Mission.Score.Cruiser = Scoring.kill.cruiser
	Mission.Score.Destroyer = Scoring.kill.destroyer
	Mission.Score.Submarine = Scoring.kill.submarine
	Mission.Score.TorpedoBoat = Scoring.kill.torpedoboat
	
	Mission.Score.DiveBomber = Scoring.kill.divebomber
	Mission.Score.TorpedoBomber = Scoring.kill.torpedobomber
	Mission.Score.Fighter = Scoring.kill.fighter
	Mission.Score.ReconPlane = Scoring.kill.reconplane
	-- todo: es a tobbi....
	-- Scoring = nil
end

function luaSCMonstreGetScore(targettable)
-- RELEASE_LOGOFF  	luaLog("Getting scores for units")

	local score = 0
	for key, value in pairs(targettable) do
		score = score + Mission.Score[value.Class.Type]
-- RELEASE_LOGOFF  		luaLog(" Current result: "..score)
	end
	
-- RELEASE_LOGOFF  	luaLog("Final score reached: "..score)
	
	return score
end

function luaSCMonstreSpawnPT()
-- RELEASE_LOGOFF  	luaLog("Spawning PTBoat")
	local unit = Spawn(Mission.HiddenPT.Name, ST_ABSANGLE, Mission.Fuso, 3000, 5000, 0, 0, -180, "PT-"..(100+Mission.PTNum))
	if unit == nil then
-- RELEASE_LOGOFF  		luaLog("++Unable to spawn PT++")
		return
	end
-- RELEASE_LOGOFF  	luaLog(" Unit spawned, distance: "..tostring(luaGetDistance(Mission.Fuso, unit)))
	NavigatorAttackMove(unit, Mission.Fuso, {})
	SetFireTarget(unit, Mission.Fuso)
	Mission.PTNum = Mission.PTNum + 1
	table.insert(Mission.PTs, unit)
-- RELEASE_LOGOFF  	luaLogElementNames(Mission.PTs, "PT-Boats!")
end

function luaSCMonstreSpawnDD()
-- RELEASE_LOGOFF  	luaLog("Spawning DD")
	
	--local spawnable = luaPickRnd(Mission.HiddenDDs)			-- veletlenszeruen kivalasztunk egyet a meg nem begeneraltak kozul
	--luaLog(" Spawnable unit: "..spawnable.Name)
	--spawnable = Spawn(spawnable.Name, ST_ABSANGLE, Mission.Fuso, 4000, 5000, 0, 170, 200, nil)
	local spawnableName = luaPickRnd(Mission.DDNames)			-- veletlenszeruen kivalasztunk egyet a meg nem begeneraltak kozul
-- RELEASE_LOGOFF  	luaLog(" Spawnable name: "..spawnableName.Name)
	local spawnable = Spawn(Mission.DDNameTemplate, ST_ABSANGLE, Mission.Fuso, 4000, 5000, 0, 170, 200, spawnableName.Name)
	if spawnable == nil then
-- RELEASE_LOGOFF  		luaLog("++Unable to spawn DD++")
		return
	end
	ShipSetTorpedoStock(spawnable, 8)
-- RELEASE_LOGOFF  	luaLog(" Unit spawned, distance: "..tostring(luaGetDistance(Mission.Fuso, spawnable)))
	NavigatorAttackMove(spawnable, Mission.Fuso, {})
	SetFireTarget(spawnable, Mission.Fuso)

	--luaRemoveByName(Mission.HiddenDDs, spawnable.Name)
	luaRemoveByName(Mission.DDNames, spawnableName.Name)
	
	table.insert(Mission.DDs, spawnable)				-- berakjuk az elok koze
-- RELEASE_LOGOFF  	luaLogElementNames(Mission.DDs, "Destroyers!")
end

function luaSCMonstreSpawnCL()
-- RELEASE_LOGOFF  	luaLog("Spawning CL")
	
--	local spawnable = luaPickRnd(Mission.HiddenCLs)			-- veletlenszeruen kivalasztunk egyet a meg nem begeneraltak kozul
-- RELEASE_LOGOFF  --	luaLog(" Spawnable unit: "..spawnable.Name)
--	spawnable = Spawn(spawnable.Name, ST_ABSANGLE, Mission.Fuso, 3500, 5000, 0, 50, 100, nil)
	
	local spawnableName = luaPickRnd(Mission.CLNames)			-- veletlenszeruen kivalasztunk egyet a meg nem begeneraltak kozul
	
	if not spawnableName then
-- RELEASE_LOGOFF  		luaLog("***Empty CL list!")
		return
	end
	
-- RELEASE_LOGOFF  	luaLog(" Spawnable name: "..spawnableName.Name)
	local spawnable = Spawn(Mission.CLNameTemplate, ST_ABSANGLE, Mission.Fuso, 3500, 5000, 0, 50, 100, spawnableName.Name)
	
	if spawnable == nil then
-- RELEASE_LOGOFF  		luaLog("++Unable to spawn CL++")
		return
	end
	ShipSetTorpedoStock(spawnable, 4)
-- RELEASE_LOGOFF  	luaLog(" Unit spawned, distance: "..tostring(luaGetDistance(Mission.Fuso, spawnable)))
	NavigatorAttackMove(spawnable, Mission.Fuso, {})
	SetFireTarget(spawnable, Mission.Fuso)
	
	--luaRemoveByName(Mission.HiddenCLs, spawnableName.Name)
	luaRemoveByName(Mission.CLNames, spawnableName.Name)
	table.insert(Mission.CLs, spawnable)				-- berakjuk az elok koze	
-- RELEASE_LOGOFF  	luaLogElementNames(Mission.CLs, "Cruisers!")
end

function luaSCMonstreStepPhase()
	Mission.MissionPhase = Mission.MissionPhase + 1
end

--[[
function luaSCMonstreCheckSupport()
-- RELEASE_LOGOFF  	luaLog("Checking support...")
	
	Mission.ScoreSupport = luaRemoveDeadsFromTable(Mission.ScoreSupport, "Dead scoresupport")
	
	for key, value in pairs(Mission.ScoreSupport) do
		UpdateUnitTable(value)
		if value.Class.Type ~= "Fighter" and value.ammo == 0 then
-- RELEASE_LOGOFF  			luaLog(" evacuating "..value.Name.." because of ammo.")
			UnitHoldFire(value)
			PilotRetreat(value)
		end
	end
	
	if luaGetDistance(Mission.Fuso, Mission.TargetPoint) < 2500 then
-- RELEASE_LOGOFF  		luaLog(" Fuso in range, checking reinforcements")
		Mission.Support = luaRemoveDeadsFromTable(Mission.Support)
		
		if luaCountTable(Mission.Support) == 0 then
 			if not Mission.FirstEntered then
				Mission.FirstEntered = true
			end
-- RELEASE_LOGOFF  			luaLog("  Everyone is missing!")
			luaSCMonstreSpawnSupport("all")
		elseif luaCountTable(luaTypeFilter(Mission.Support, "DiveBomber")) == 0 then
-- RELEASE_LOGOFF  			luaLog("  Divebomber is missing!")
			luaSCMonstreSpawnSupport("divebomber")
		elseif luaCountTable(luaTypeFilter(Mission.Support, "TorpedoBomber")) == 0 then
-- RELEASE_LOGOFF  			luaLog("  Torpedobomber is missing!")
			luaSCMonstreSpawnSupport("torpedobomber")
		end
	end
	
	-- itt csekkolodik, hogy mennyi unitot spawnolhatunk a kilott pontokbol
	if Mission.SupportPool ~= 0 then
		local exit = false
		while not exit do
-- RELEASE_LOGOFF  			luaLog("W-> Filtering spawnables...")
			local spawnables = luaSCMonstreFilterSpawnables()
			
			if next(spawnables) ~= nil then
-- RELEASE_LOGOFF  				luaLog("W->  Spawnables found!")
				local rndSpawnable = luaPickRnd(spawnables)
-- RELEASE_LOGOFF  				luaLog("W->  RndSpawnable tpye: "..rndSpawnable)
				local size = luaSCMonstreGetMaxSpawnableSize(rndSpawnable)
				
				if luaSCMonstreSpawnSupportByScore(rndSpawnable, size) == "spawnfailed" then
					Mission.SpawnedFailed = 0
					exit = true
				end
			else
-- RELEASE_LOGOFF  				luaLog("W->  Spawnables NOT found!")
				Mission.SpawnedFailed = 0
				exit = true
			end
			
		end
	end
end

function luaSCMonstreSpawnSupport(planetype)
-- RELEASE_LOGOFF  	luaLog("Generating support...")
-- RELEASE_LOGOFF  	luaLog(" Calling "..tostring(planetype))
	if planetype == "all" then
		Mission.Support = luaGenerateObjects(Mission.HiddenSupport)
	elseif planetype == "divebomber" then
		local unit = GenerateObject(Mission.HiddenSupport[2])
		table.insert(Mission.Support, unit)
		UnitFreeFire(unit)
		PilotMoveToRange(unit, Mission.Fuso)
	elseif planetype == "torpedobomber" then
		local unit = GenerateObject(Mission.HiddenSupport[1])
		table.insert(Mission.Support, unit)
		UnitFreeFire(unit)
		PilotMoveToRange(unit, Mission.Fuso)		
	end
end
]]
function luaSCMonstreFilterSpawnables()
-- RELEASE_LOGOFF  	luaLog("Checking spawnable supportunits...")
	local spawnables = {}
	
	for key, value in pairs(Mission.SpawnableTypes) do
		if Mission.Score[value] < Mission.SupportPool then
			if luaCountTable(luaTypeFilter(Mission.ScoreSupport, value)) >= Mission[value.."Limit"] then	-- a globalis limitet ellenorzi adott squadra (nem planeszamra!)
-- RELEASE_LOGOFF  				luaLog("Too much "..value..", unable to insert...")
			else
				table.insert(spawnables, value)
-- RELEASE_LOGOFF  				luaLog(value.." inserted")
			end
		end
	end
	
	return spawnables
end

--[[
function luaSCMonstreInitSpawnableTypes()
	Mission.SpawnableTypes = {}
		table.insert(Mission.SpawnableTypes, "DiveBomber")
		table.insert(Mission.SpawnableTypes, "TorpedoBomber")
		table.insert(Mission.SpawnableTypes, "Fighter")
		table.insert(Mission.SpawnableTypes, "ReconPlane")
end

function luaSCMonstreGetMaxSpawnableSize(spType)
-- RELEASE_LOGOFF  	luaLog("Getting spawnable size")
	
	local squadSize = math.floor(Mission.SupportPool / Mission.Score[spType])
-- RELEASE_LOGOFF  	luaLog(" Squadsize: "..tostring(squadSize))
	
	if squadSize > 5 then
-- RELEASE_LOGOFF  		luaLog(" ->Exceeding limit (5) !")
		squadSize = 5
	end
	
	return squadSize
end

function luaSCMonstreSpawnSupportByScore(rndSpawnable, size)
-- RELEASE_LOGOFF  	luaLog("Spawning score-support: "..rndSpawnable..", squadsize: "..size)
	
	local spawned = Spawn(rndSpawnable..size, ST_ABSANGLE, Mission.Fuso, 3000, 5000, 1000, 0, 55)
	
	if spawned == nil then
-- RELEASE_LOGOFF  		luaLog("Fakk, spawn failed!!!")
		Mission.SpawnFailed = Mission.SpawnFailed + 1
		if Mission.SpawnFailed >= 3 then
-- RELEASE_LOGOFF  			luaLog("+++ Spawn failed too many times!")
			return "spawnfailed"
		end
		return
	end
	
	PilotMoveTo(spawned, Mission.Fuso)
	UnitFreeFire(spawned)
	
	-- tmp test only !!!!!!
	--SetRoleAvailable(spawned, EROLF_ALL, PLAYER_ANY)
	
	table.insert(Mission.ScoreSupport, spawned)
	
	--levonjuk a poolbol
-- RELEASE_LOGOFF  	luaLog(" Pool before: "..Mission.SupportPool)
	Mission.SupportPool = Mission.SupportPool - Mission.Score[rndSpawnable]*size
-- RELEASE_LOGOFF  	luaLog(" Pool after: "..Mission.SupportPool)
end
]]
function luaSCMonstreShowNarr1()
	--Blackout(false, "", 3)
	luaDelay(luaSCMontreFadeIn, 2)
	MissionNarrative("Somewhere on the Java Sea, a long battleship races to escape an ambush")		-- sc1-nar_Intro1
	MissionNarrative("The Yamashiro has been sent to assist you...", "luaSCMonstreShowNarr1_2")	-- sc1-nar_Intro2
end

function luaSCMonstreShowNarr1_2()
	--Blackout(false, "luaSCMonstreStepPhase")
	--luaCamOnTarget(Mission.Fuso)
	
	luaDelay(luaSCMonstreStepPhase, 3.43)
	--EnableInput(true)
end

function luaSCMonstreKongoSpawn()
-- RELEASE_LOGOFF  	luaLog("Spawning Kongo to Fuso...")
	
	Mission.Kongo = luaSpawn(Mission.HiddenKongo.Name, ST_ABSANGLE, Mission.Fuso, 2500, 3500, 0, 20, 100)
	
	local diff = GetDifficulty()
	if diff == DIFF_ROOKIE then
		SetCrewLevel(Mission.Kongo, DIFF_VETERAN)
		SetShipMaxSpeed(Mission.Kongo, GetShipMaxSpeed(Mission.Kongo)*1.25)
	elseif diff == DIFF_REGULAR then
		SetCrewLevel(Mission.Kongo, DIFF_REGULAR)
	elseif diff == DIFF_VETERAN then
		SetCrewLevel(Mission.Kongo, DIFF_ROOKIE)
	end
	
	RepairEnable(Mission.Kongo, false)
	
	JoinFormation(Mission.Kongo, Mission.Fuso)
	SetFormationShape(Mission.Fuso, 2)
	MissionNarrative("We have spotted the Yamashiro, she will join us soon.")	-- sc1-nar_KongoSpotted
	luaObj_Add("secondary", 1, Mission.Kongo)
	DisplayUnitHP({Mission.Kongo}, "Secondary: The Yamashiro must survive!")
	
	luaSCMonstreAllowFormationCheck()
end

function luaSCMonstreAllowFormationCheck()
	if Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("Mission is at the end, restricting formationcheck")
		return
	end
	
	if not IsInFormation(Mission.Kongo) then
-- RELEASE_LOGOFF  		luaLog(" Formation disbanded, new order to be given")
		if not Mission.Fuso.Dead then
-- RELEASE_LOGOFF  			luaLog("MoveToRange initiated")
			NavigatorMoveToRange(Mission.Kongo, Mission.Fuso)
		else
-- RELEASE_LOGOFF  			luaLog("Fuso is dead, move wherever you want...")
		end
	else
		luaDelay(luaSCMonstreAllowFormationCheck, 4)
	end
end

-- ellenseges hullamok ellenorzese
function luaSCMonstreCheckWaves()
-- RELEASE_LOGOFF  	luaLog("Checking attack waves...")
	
	if Mission.WavesOver and luaCountTable(Mission.CurrentWave) == 0 then
		Mission.WavesKilled = true
	end
	
	if Mission.WaveNum == Mission.WaveMaxNum and not Mission.WaveLimit == 1 then
-- RELEASE_LOGOFF  		luaLog(" Final wave reached, setting wavelimit to 1")
		Mission.WaveLimit = 1
	end
	
	if not Mission.SpawnOngoing and luaCountTable(Mission.CurrentWave) < Mission.WaveLimit then
-- RELEASE_LOGOFF  		luaLog("+ Time to release the next wave of attackers!")
		Mission.WaveNum = Mission.WaveNum + 1
		Mission.SpawnOngoing = true
		
		if Mission.WaveNum > Mission.WaveMaxNum then
-- RELEASE_LOGOFF  			luaLog(" Final wave is over.")
			Mission.WavesOver = true
			--Mission.MissionEnd = true
			--Scoring_SetMissionCompleted(true)
			--MissionNarrative("All of the American forces have been destroyed.")
			--MissionNarrative("Mission accomplished.", "EndScene")
			return
		end
		
		luaSCMonstreSpawnWave(Mission.WaveNum)
	end
	
	if not Mission.FinalMonsta.ID and (luaGetDistance(Mission.Fuso, Mission.TargetPoint) < 4000 or Mission.WavesOver) then
-- RELEASE_LOGOFF  		luaLog(" Time to come, monsta!")
		luaSCMonstreFinalSpawn()
	end
	
	if Mission.WavesKilled and Mission.FinalMonsta.Dead then
-- RELEASE_LOGOFF  		luaLog(" + Allied forces have been destroyed. Mission success.")
		--MissionNarrative("All of the American forces have been destroyed.")
		--MissionNarrative("Mission accomplished.", "EndScene")
		--Scoring_SetMissionCompleted(true)
		
		--Scoring_SetRanking(MEDAL_GOLD)
		if (Mission.Kongo and not Mission.Kongo.Dead) or not Mission.Kongo then
			luaObj_Add("secondary", 1)
			luaObj_Completed("secondary", 1)
			HideUnitHP()
		end
		
		luaObj_Add("hidden", 1)
		luaObj_Completed("hidden", 1)
		luaObj_Completed("primary", 1)
		luaObj_Completed("primary", 2)

		-- news
		local camDropEnt
		if Mission.EnemiesBefore then
			for idx, value in pairs (Mission.EnemiesBefore) do
				if value.Dead and not TrulyDead(value) then
					camDropEnt = value
				end
			end
		end
		
		if camDropEnt then			
			luaSCMonstreAddAndFailHiddens()
-- RELEASE_LOGOFF  			luaLog("Found last enemy unit: "..camDropEnt.Name)
			luaMissionCompletedNew(camDropEnt, "sc1.obj_comp_kill")
		else
			luaSCMonstreAddAndFailHiddens()
-- RELEASE_LOGOFF  			luaLog("Last enemy unit not found")
			luaMissionCompletedNew(Mission.Fuso, "sc1.obj_comp_kill")
		end
		
		Mission.MissionEnd = true
	end
end

function luaSCMonstreSpawnWave(waveNum)
-- RELEASE_LOGOFF  	luaLog("Spawning wave "..waveNum)
	
	-- itt behuzunk egy adag B-25-ot is
--[[
	
	local plane = luaSpawn(Mission.StrikerTmpl.Name, ST_ABSANGLE, GetPosition(Mission.Fuso), 4000, 4200, 100, 180, 225)
	if plane ~= nil then
-- RELEASE_LOGOFF  		luaLog(" Plane generated")
		local diff = GetDifficulty()
		if diff == DIFF_ROOKIE then
			SetCrewLevel(plane, DIFF_ROOKIE)
		elseif diff == DIFF_REGULAR then
			SetCrewLevel(plane, DIFF_ROOKIE)
		elseif diff == DIFF_VETERAN then
			SetCrewLevel(plane, DIFF_ROOKIE)
		end
		
		PilotSetTarget(plane, Mission.Fuso)
		Mission.CurrentPlane = plane
		table.insert(Mission.Bombers, plane)
		
		luaDelay(luaSCMonstreSetAlt, 1)
		
		SetCheatTurbo(plane, 1.7)
	else
-- RELEASE_LOGOFF  		luaLog(" Plane cannot be generated - why the fucking hell?")
	end	
]]

-- RELEASE_LOGOFF  	luaLogTableNames(Mission.Waves[waveNum], " Attackwave num "..waveNum)
	luaGoFuckYourself(Mission.Waves[waveNum], Mission.Fuso, 3500, 4000, 0, 110, 145, 1)

--[[
	-- WARNING: only temporary Spawn
	for key, value in pairs(Mission.Waves[waveNum]) do
-- RELEASE_LOGOFF  		luaLog("  currently at "..value.Name)
		local unit = luaSpawn(value.Name, ST_ABSANGLE, Mission.Fuso, 4000, 5000, 0, 110, 145)
		table.insert(Mission.CurrentWave, unit)
		luaSCMonstreWaveUnitSpawned(unit)
	end
]]
	-- ha kell valami hullamspecifikus dolog...
	if waveNum == 1 then
		MissionNarrative("Americans to the east-southwest!")		-- sc1-nar_Wave1
		MissionNarrative("Clemson class destroyers incoming!")	-- sc1-nar_Wave1_2
	elseif waveNum == 2 then
		MissionNarrative("American reinforcements! Fletcher class destroyers!")-- sc1-nar_Wave2
	elseif waveNum == 3 then
--		MissionNarrative("sc1.nar_Wave3")	-- sc1-nar_Wave3
		MissionNarrative("American heavy cruisers on their way!")	-- sc1-nar_Wave6
	elseif waveNum == 4 then
		MissionNarrative("Watch out, American battleship approaching!")	-- sc1-nar_Wave4
	elseif waveNum == 5 then
		MissionNarrative("Another BB incoming!")	-- sc1-nar_Wave5
--	elseif waveNum == 6 then
--		MissionNarrative("sc1.nar_Wave6")	-- sc1-nar_Wave6
	end

end

function luaGoFuckYourself(unitTable, trg, dist1, dist2, alt, angle1, angle2, spawnIdx)
	
	for idx,unit in pairs(unitTable) do
	
		local unit = Spawn(unit.Name, ST_ABSANGLE, GetPosition(trg), dist1, dist2, alt, angle1, angle2, "", true)
		
		if spawnIdx == 1 then
		
			luaSCMonstreWaveUnitSpawned(unit)
			
		elseif spawnIdx == 2 then
		
			luaSCMonstreKongoKillerSpawned(unit)
			
		end
	
	end
	
end

--[[
function luaSCMonstreSetAlt()
-- RELEASE_LOGOFF  	luaLog("Setting altitude for B-25")
	SquadronSetTravelAlt(Mission.CurrentPlane, 150)
	SquadronSetAttackAlt(Mission.CurrentPlane, 150)
end
]]

function luaSCMonstreWaveUnitSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("Waveunit "..unit.Name.." spawned")
	
	if Mission.Fuso.Dead then
-- RELEASE_LOGOFF  		luaLog("Fuso is already dead")
		return
	end
	
	luaSCMonstreCheckSpawnPos(unit)
	
	Mission.CurrentSpawnNum = Mission.CurrentSpawnNum + 1
	NavigatorAttackMove(unit, Mission.Fuso, {})
	SetFireTarget(unit, Mission.Fuso)
	table.insert(Mission.CurrentWave, unit)

	local diff = GetDifficulty()
	if diff == DIFF_ROOKIE then
		SetCrewLevel(unit, DIFF_ROOKIE)
	elseif diff == DIFF_REGULAR then
		SetCrewLevel(unit, DIFF_VETERAN)
	elseif diff == DIFF_VETERAN then
		SetCrewLevel(unit, DIFF_REGULAR)
	end
	
	if Mission.CurrentSpawnNum == luaCountTable(Mission.Waves[Mission.WaveNum]) then
		Mission.SpawnOngoing = false
		Mission.CurrentSpawnNum = 0
	end
end

function luaSCMonstreCheckSpawnPos(unit)
-- RELEASE_LOGOFF  	luaLog("Checking whether spawned unit is in a restricted zone")
	
	for i, v in pairs (Mission.RestrictionZones) do
		local curDist = luaGetDistance(unit, v)
-- RELEASE_LOGOFF  		luaLog(" Distance from restriction zone "..tostring(i)..": "..tostring(curDist)..", limit is "..tostring(Mission.RestrictionZoneDistances[i]))
		
		if curDist < Mission.RestrictionZoneDistances[i] then
-- RELEASE_LOGOFF  			luaLog(" >> Unit is in restricted zone! Putting away...")
			PutRelTo(unit, unit, {["x"]=0, ["y"]=0, ["z"]=-1000})
		end
	end
end

function luaSCMonstreCheckAllied(this)
-- RELEASE_LOGOFF  	luaLog("Checking allied forces...")
	this.CurrentWave = luaRemoveDeadsFromTable(this.CurrentWave)
end

function luaSCMonstreSpawnKongoKillers()
-- RELEASE_LOGOFF  	luaLog("Spawning Kongo-killer DDs")
	
	luaGoFuckYourself(Mission.KongoKillers, Mission.Fuso, 4000, 5000, 0, 140, 170, 2)
	Mission.KongoKillers = {}
end

function luaSCMonstreKongoKillerSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("Kongo killer "..unit.Name.." spawned")
	
	NavigatorAttackMove(unit, Mission.Kongo, {})
	SetFireTarget(unit, Mission.Kongo)
	--table.insert(Mission.KongoKillers, unit)
	table.insert(Mission.CurrentWave, unit)

	local diff = GetDifficulty()
	if diff == DIFF_ROOKIE then
		SetCrewLevel(unit, DIFF_ROOKIE)
	elseif diff == DIFF_REGULAR then
		SetCrewLevel(unit, DIFF_REGULAR)
		SetShipMaxSpeed(unit, GetShipMaxSpeed(unit)*1.1)
	elseif diff == DIFF_VETERAN then
		SetCrewLevel(unit, DIFF_VETERAN)
		SetShipMaxSpeed(unit, GetShipMaxSpeed(unit)*1.2)
	end
end

function luaSCMonstreFinalSpawn()
-- RELEASE_LOGOFF  	luaLog("Spawning KGV...")
	if Mission.WavesOver then
-- RELEASE_LOGOFF  		luaLog(" Real spawning")
		Mission.FinalMonsta = luaSpawn("Prince of Wales", ST_ABSANGLE, Mission.Fuso, 2500, 3500, 0, 80, 100)
	else
-- RELEASE_LOGOFF  		luaLog(" Generating")
		Mission.FinalMonsta = GenerateObject("Prince of Wales")
	end
	
	local diff = GetDifficulty()
	if diff == DIFF_ROOKIE then
		SetCrewLevel(Mission.FinalMonsta, DIFF_ROOKIE)
	elseif diff == DIFF_REGULAR then
		SetCrewLevel(Mission.FinalMonsta, DIFF_REGULAR)
	elseif diff == DIFF_VETERAN then
		SetCrewLevel(Mission.FinalMonsta, DIFF_REGULAR)
	end
	
	NavigatorAttackMove(Mission.FinalMonsta, Mission.Fuso, {})
	SetFireTarget(Mission.FinalMonsta, Mission.Fuso)
	
	MissionNarrative("Enemy battleship to the west! The final barrier in our way.")	-- sc1-nar_FinalShip
end

function luaMonstrePlayerHit()
	Music_Control_SetLevel(MUSIC_ACTION)
	--RemoveListener("hit", "playerHit")
end

function luaSCMonstreCheckSquadSpeeds()
-- RELEASE_LOGOFF  	luaLog("Checking bombers' speed...")
	
	if Mission.MissionEnd or Mission.Fuso.Dead then
		return
	end
	
	local bombers = {}
	
	for key, value in pairs(Mission.Bombers) do
		if luaGetDistance(value, Mission.Fuso) > 1000 then
			table.insert(bombers, value)
		else
			SetCheatTurbo(value, 1)
		end
	end
	
	Mission.Bombers = bombers
-- RELEASE_LOGOFF  	luaLog("- Recall")
	luaDelay(luaSCMonstreCheckSquadSpeeds, 1.35)
end

function luaSCMonstreIntro()
-- RELEASE_LOGOFF  	luaLog("initiating intro...")
	
	-- korbemegyunk kamera
	local target =
		{
			["postype"] = "cameraandtarget",
			["position"] = 
			{
				["parent"] = Mission.Fuso,
				["modifier"] =
				{
					["name"] = "goaround",
					["radius"] = { 135 },
					["radiuslinearblend"] = 0.3,
					["theta"] = {2},	-- vertical
					["thetalinearblend"] = 0.3,
					["rho"] = { 10, 60, -165 },	-- horizontal
					["rholinearblend"] = 0.5,
				}
			},
			["starttime"] = 0,
			["blendtime"] = 0,
			["nonlinearblend"] = 3,
		}
	MovCamNew_AddPosition(target)

	-- beleulunk a unitba
	local target =
		{
			["postype"] = "cameraandtarget",
			["position"] = 
			{
				["parent"] = Mission.Fuso,
				["modifier"] =
				{
					["name"] = "gamecamera"
				}
			},
			["starttime"] = 13,
			["blendtime"] = 7,
			["nonlinearblend"] = 5,
			["finishscript"] = "luaSCMonstreSelectFuso"
		}
	MovCamNew_AddPosition(target)
	
	--SetSkipMovie("luaSCMonstreSelectFuso")
	SetSkipMovie("luaSCMonstreSkipIntro")
end

function luaSCMonstreSkipIntro()
	Mission.IntroSkipped = true
	SetSkipMovie()
	luaCrossFade(luaSCMonstreSelectFuso)
end

function luaSCMonstreSelectFuso()
	SetSkipMovie()
	SetSelectedUnit(Mission.Fuso)
end

function luaSCMontreFadeIn()
	if not Mission.IntroSkipped then
		Blackout(false, "", 3.5)
	end
end

function luaSCMonstreCheckMusic()
-- RELEASE_LOGOFF  	luaLog("Checking music change...")
	
	local units1 = luaGetShipsAround(Mission.Fuso, 2700, "enemy")
	local units2
	if units1 then
		local dummy, dist = luaSortByDistance(Mission.Fuso, units1, true)
		if dist and dist < 2000 then
			units2 = true
		end
		--units2 = luaGetShipsAround(Mission.Fuso, 1800, "enemy")
	end
	
	if units1 == nil and Mission.Music ~= MUSIC_CALM then
-- RELEASE_LOGOFF  		luaLog(" Setting to CALM")
		Music_Control_SetLevel(MUSIC_CALM)
		Mission.Music = MUSIC_CALM
	elseif units1 ~= nil and units2 == nil and Mission.Music ~= MUSIC_TENSION then
-- RELEASE_LOGOFF  		luaLog(" Setting to tension")
		Music_Control_SetLevel(MUSIC_TENSION)
		Mission.Music = MUSIC_TENSION
	elseif units2 ~= nil and Mission.Music ~= MUSIC_ACTION then
-- RELEASE_LOGOFF  		luaLog(" Setting to action")
		Music_Control_SetLevel(MUSIC_ACTION)
		Mission.Music = MUSIC_ACTION
	end
end

function luaSCMonstreAddAndFailHiddens()
	for idx,obj in pairs(Mission.Objectives.hidden) do
		if not luaObj_IsActive("hidden",idx) then
			luaObj_Add("hidden",idx)
			luaObj_Failed("hidden",idx)
		end
	end
end

function luaDistanceCounter(unit, trg, id, obj, txt)
	if unit and trg and not unit.Dead and not trg.Dead then
		local dist = luaMetric(luaGetDistance3D(unit, trg))
		Mission.Measure = GetMeasure()
		Mission.Distance = string.format("%.1f",dist)
		DisplayScores(id,0,obj,txt)

		if dist < luaMetric(1000) then
			Mission.PlayerNear = true
		end
	end
end

function luaMetric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end
end