--[[
-	Foto: M12_Siege_Duel.jpg
-	US oldal tamad, ezen az oldalon van egy AI iranyitasu CV, mellette spawnpointok, ahonnan a player Advanced DD-ket (Fletcher) es fightereket tud spawnolni
-	A carrier HP-jat override-oljuk
-	Japan oldalnak CB-je, airfieldje es shipyardja van, ahonnan dive bombert, fightert, large reconplane-t es gyengebb DD-t (Minekaze) tud spawnolni
-	Az objektiva akkor complete, ha megsemmisult a HQ vagy a carrier
-	A HQ-k mellett fortressek es bunkerek vannak, az amcsi oldal ezekert kap pontokat
-	US oldalon AI iranyitasu troop transportok folyamatosan kuldik ki a kis foglalo hajokat, amikert pontot kap a japan oldal, ha megsemmisiti (operett harc)
-	A transport hajok ujra spawnolodnak ha megsemmisultek

--warningok ha hq vagy cv hpja kicsi
--hinteket atfogalmazni
--cleveland meg egyeb stuffok pontozasba		DONE
--setweight ai (?)
--final pontszamok
]]
function luaPrecacheUnits()
	PrepareClass(234)	--US Troop Transport
	PrepareClass(23)	--fletcher
	PrepareClass(316)	--cleveland
	PrepareClass(20)	--deruyter
	--PrepareClass(73)	--fubuki
	PrepareClass(70)	--kuma
	PrepareClass(71)	--agano
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitS12Mission")
end

function luaInitS12Mission(this)
	Mission = this

	--local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege12"

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 1

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.MissionPhase = 0

	Mission.AICapturers = {}
	Mission.MaxCapturers = 3

	Mission.USCV = FindEntity("Siege - CV_US 01")
	SetRoleAvailable(Mission.USCV, EROLF_ALL, PLAYER_AI)
	OverrideHP(Mission.USCV, 30000)

	Mission.HQ = FindEntity("Siege - CB4")
	OverrideHP(Mission.HQ, 30000)

	--kiloheto szarok
	Mission.AAs = {}
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 01"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 02"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 03"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 04"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 05"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 06"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 07"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 08"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 09"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 10"))
		table.insert(Mission.AAs, FindEntity("Siege - Heavy AA, Japanese 11"))

	Mission.Coastals = {}
		table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 01"))
		table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 02"))
		table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 03"))
		table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 04"))
		table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 05"))

	Mission.Batteries = {}
		table.insert(Mission.Batteries, FindEntity("Siege - Huge Battery Open 01"))
		table.insert(Mission.Batteries, FindEntity("Siege - Huge Battery Open 02"))

	Mission.MediumBunkers = {}
		table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 01"))
		table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 02"))
		table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 03"))
		table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 04"))

	Mission.Fortersses = {}
		table.insert(Mission.Fortersses, FindEntity("Siege - Fortress element, Large 01"))
		table.insert(Mission.Fortersses, FindEntity("Siege - Fortress element, Large 02"))
		table.insert(Mission.Fortersses, FindEntity("Siege - Fortress element, Large 03"))
		table.insert(Mission.Fortersses, FindEntity("Siege - Fortress element, Large 04"))
		table.insert(Mission.Fortersses, FindEntity("Siege - Fortress element, Large 05"))

	Mission.Airfield = FindEntity("Siege - CB4_AF")
	Mission.Shipyard = FindEntity("CB4_SY")
	SetParty(Mission.Shipyard, PARTY_JAPANESE)

	Mission.AllOtherJPUnits = {}
	Mission.AllOtherUSUnits = {}

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	Mission.Screen = {}

	local j
	if Mission.Players <= 2 then
		j = 1
	elseif Mission.Players > 2 and Mission.Players <=4 then
		j = 2
	else
		j = 4
	end

	for i=1,j do
		table.insert(Mission.Screen, GenerateObject("Siege - DeRuyter 0"..tostring(i)))
		NavigatorSetTorpedoEvasion(Mission.Screen[i], false)
	end

	-- spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint USN 01"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint USN 02"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint USN 03"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint USN 04"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint IJN 01"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint IJN 02"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint IJN 03"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - SpawnPoint IJN 04"))

	Mission.SpawnPoints2 = {}
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - SpawnPoint USN 05"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - SpawnPoint USN 06"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - SpawnPoint USN 07"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - SpawnPoint USN 08"))

	Mission.SpawnPoints3 = {}
		table.insert(Mission.SpawnPoints3, FindEntity("Siege - SpawnPoint IJN 05"))
		table.insert(Mission.SpawnPoints3, FindEntity("Siege - SpawnPoint IJN 06"))
		table.insert(Mission.SpawnPoints3, FindEntity("Siege - SpawnPoint IJN 07"))
		table.insert(Mission.SpawnPoints3, FindEntity("Siege - SpawnPoint IJN 08"))

	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")
	for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end
	end

	for index, entity in pairs (Mission.SpawnPoints2) do
		for i=0,3 do
			if (index - 1) == i then
				ActivateSpawnpoint(entity, i)
			else
				DeactivateSpawnpoint(entity, i)
			end
		end
	end

	for index, entity in pairs (Mission.SpawnPoints3) do
		for i=4,7 do
			if (index + 3 ) == i then
				ActivateSpawnpoint(entity, i)
			else
				DeactivateSpawnpoint(entity, i)
			end
		end
	end


-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")
--warnings
	Mission.WarningsShown = {}
		Mission.WarningsShown["CV"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
		}
		Mission.WarningsShown["HQ"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
		}

----- resource dolgok -----

	if Mission.Players <= 2 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 2")
		Mission.ResourcePoolBase = 500
		Mission.ResourceUSPool = 500
		Mission.ResourceJapPool = 500
	elseif Mission.Players <= 4 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 4")
		Mission.ResourcePoolBase = 750
		Mission.ResourceUSPool = 750
		Mission.ResourceJapPool = 750
	elseif Mission.Players <= 6 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 6")
		Mission.ResourcePoolBase = 900
		Mission.ResourceUSPool = 900
		Mission.ResourceJapPool = 900
	elseif Mission.Players <= 8 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 8")
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! unhandled Mission.Players: "..Mission.Players)
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	end

	Mission.Points = {}
		Mission.Points.Fletcher = 10
		Mission.Points.Minekaze = 8
		Mission.Points.Hellcat = 3
		Mission.Points.Zero = 2
		Mission.Points.JPFortressLarge = 20
		Mission.Points.JPFortressMedium = 10
		Mission.Points.Battery = 30
		Mission.Points.CoastalGun = 5
		Mission.Points.HeavyAA = 5
		Mission.Points.Jill = 2
		Mission.Points.Mavis = 4
		Mission.Points.TroopTransport = 10
		Mission.Points.Higgins = 1
		Mission.Points.Airfield = 50
		Mission.Points.Shipyard = 50
		Mission.Points.Kuma = 10
		Mission.Points.Cleveland = 18
		Mission.Points.Deruyter = 25

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri1",
				["Text"] = "mp03.obj_siege_us_p1_text",
				["TextCompleted"] = "mp03.obj_siege_us_p1_comp",
				["TextFailed"] = "mp03.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	luaInitNewSystems()

    SetThink(this, "luaS12Mission_think")
end

function luaS12Mission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(" Mission.ResourceJapPool: "..tostring(Mission.ResourceJapPool).." | Mission.ResourceUSPool: "..tostring(Mission.ResourceUSPool))

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if not Mission.FirstRun then
		--luaS12StartCarrier()
		luaS12SpawnAllTroops()
		luaS12SetMultiScoreTable()
		luaS12AddObj()
		Mission.FirstRun = true
	end

	luaS12CheckLanding()
	luaS12HintManager()
	luaS12Warnings()
	luaS12CheckPoints()
	luaS12CheckObj()
end

function luaS12CheckLanding()

	--Mission.AICapturers = luaRemoveDeadsFromTable(Mission.AICapturers)

	--if table.getn(Mission.AICapturers) < Mission.MaxCapturers then
	--	luaS12SpawnTroopTransport()
	--end

	--for idx,unit in pairs(Mission.AICapturers) do
	local idx = table.getn(Mission.AICapturers)
	while (idx > 0) do
		local unit = Mission.AICapturers[idx]
		if not unit.Dead then
			if luaGetScriptTarget(unit) == nil and Mission.HQ.Party == PARTY_JAPANESE then
				luaSetScriptTarget(unit, Mission.HQ)
				NavigatorAttackMove(unit, Mission.HQ, {})
			end
		else
			if string.find(unit.Name,"01") then
				luaS12SpawnTroopTransport(1)
			elseif string.find(unit.Name,"02") then
				luaS12SpawnTroopTransport(2)
			elseif string.find(unit.Name,"03") then
				luaS12SpawnTroopTransport(3)
			end
			table.remove(Mission.AICapturers, idx)
		end
		idx = idx - 1
	end

end

function luaS12SpawnTroopTransport(i)
	local unit = GenerateObject("Siege - USTroopTransport 0"..tostring(i))
	--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	table.insert(Mission.AICapturers, unit)
end

function luaS12SpawnAllTroops()
	table.insert(Mission.AICapturers, GenerateObject("Siege - USTroopTransport 01"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - USTroopTransport 02"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - USTroopTransport 03"))

	--for idx,unit in pairs(Mission.AICapturers) do
		--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	--end
end

function luaS12StartCarrier()
	NavigatorMoveOnPath(Mission.USCV, FindEntity("Siege - CVPath"))
end

function luaS12HintManager()

	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 120 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege12_Landing")
			--ShowHint("ID_Hint_Siege12_Landing_JP")
			Mission.Hint1Shown = true
		elseif GameTime() > 240 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint5Shown")
			ShowHint("ID_Hint_Siege12_TroopTR")
			Mission.Hint2Shown = true
		end
	end
end

function luaS12SetMultiScoreTable()
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	MultiScore=	{
		[0]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[1]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[2]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[3]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[4]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[5]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[6]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[7]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
	}

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.1#", "mp01.score_siege_resource_def".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.1#", "mp01.score_siege_resource_def".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.1#", "mp01.score_siege_resource_def".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.1#", "mp01.score_siege_resource_def".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.1#", "mp01.score_siege_resource_def".."| #MultiScore.4.2#", 2, 1)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.1#", "mp01.score_siege_resource_def".."| #MultiScore.5.2#", 2, 1)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.1#", "mp01.score_siege_resource_def".."| #MultiScore.6.2#", 2, 1)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.1#", "mp01.score_siege_resource_def".."| #MultiScore.7.2#", 2, 1)
--[[
	DisplayScores(1, 0, "mp01.score_siege_resource".."| #MultiScore.0.1#", "mp01.score_siege_resource".."| #MultiScore.0.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 1, "mp01.score_siege_resource".."| #MultiScore.1.1#", "mp01.score_siege_resource".."| #MultiScore.1.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 2, "mp01.score_siege_resource".."| #MultiScore.2.1#", "mp01.score_siege_resource".."| #MultiScore.2.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 3, "mp01.score_siege_resource".."| #MultiScore.3.1#", "mp01.score_siege_resource".."| #MultiScore.3.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 4, "mp01.score_siege_resource".."| #MultiScore.4.1#", "mp01.score_siege_resource".."| #MultiScore.4.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 5, "mp01.score_siege_resource".."| #MultiScore.5.1#", "mp01.score_siege_resource".."| #MultiScore.5.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 6, "mp01.score_siege_resource".."| #MultiScore.6.1#", "mp01.score_siege_resource".."| #MultiScore.6.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 7, "mp01.score_siege_resource".."| #MultiScore.7.1#", "mp01.score_siege_resource".."| #MultiScore.7.2#", PARTY_ALLIED, PARTY_JAPANESE)
]]
end

function luaS12CheckPoints()
	--japan szarok
	--for idx,unit in pairs(Mission.AAs) do
	local idx = table.getn(Mission.AAs)
	while (idx > 0) do
		local unit = Mission.AAs[idx]
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.HeavyAA
			table.remove(Mission.AAs, idx)
		end
		idx = idx - 1
	end

	--for idx,unit in pairs(Mission.Coastals) do
	local idx = table.getn(Mission.Coastals)
	while (idx > 0) do
		local unit = Mission.Coastals[idx]
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.CoastalGun
			table.remove(Mission.Coastals, idx)
		end
		idx = idx - 1
	end

	--for idx,unit in pairs(Mission.Batteries) do
	local idx = table.getn(Mission.Batteries)
	while (idx > 0) do
		local unit = Mission.Batteries[idx]
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Battery
			table.remove(Mission.Batteries, idx)
		end
		idx = idx - 1
	end

	--for idx,unit in pairs(Mission.Fortersses) do
	local idx = table.getn(Mission.Fortersses)
	while (idx > 0) do
		local unit = Mission.Fortersses[idx]
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.JPFortressLarge
			table.remove(Mission.Fortersses, idx)
		end
		idx = idx - 1
	end

	--for idx,unit in pairs(Mission.MediumBunkers) do
	local idx = table.getn(Mission.MediumBunkers)
	while (idx > 0) do
		local unit = Mission.MediumBunkers[idx]
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.JPFortressMedium
			table.remove(Mission.MediumBunkers, idx)
		end
		idx = idx - 1
	end

	if Mission.Airfield.Dead and not Mission.AirfieldPointsCounted then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Airfield
		Mission.AirfieldPointsCounted = true
	end

	if Mission.Shipyard.Dead and not Mission.ShipyardPointsCounted then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Shipyard
		Mission.ShipyardPointsCounted = true
	end

	Mission.AllOtherJPUnits = luaC12GetUnits(PARTY_JAPANESE)
	Mission.AllOtherUSUnits = luaC12GetUnits(PARTY_ALLIED)

	--for idx,unit in pairs(Mission.AllOtherJPUnits) do
	local idx = table.getn(Mission.AllOtherJPUnits)
	while (idx > 0) do
		local unit = Mission.AllOtherJPUnits[idx]
		if unit and unit.Dead then

			if unit.Class.Type == "Destroyer" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Minekaze
			elseif unit.Class.Type == "Fighter" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Zero
			elseif unit.Class.Type == "DiveBomber" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Jill
			elseif unit.Class.Type == "LargeReconPlane" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Mavis
			elseif unit.Class.Type == "Cruiser" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Kuma
			end

			table.remove(Mission.AllOtherJPUnits, idx)
		else

			if luaGetType(unit) == "plane" then
				local lastNum = luaC12GetSqMultiplier(unit)
				local actNum = table.getn(GetSquadronPlanes(unit))

				if lastNum > actNum then
					unit.sqadnumchecked = actNum
				end

				if unit.Class.Type == "Fighter" then
					Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Zero
				elseif unit.Class.Type == "DiveBomber" then
					Mission.ResourceJapPool = Mission.ResourceJapPool - (Mission.Points.Jill * (lastNum - actNum))
				end
			end
		end
		idx = idx - 1
	end

	--for idx,unit in pairs(Mission.AllOtherUSUnits) do
	local idx = table.getn(Mission.AllOtherUSUnits)
	while (idx > 0) do
		local unit = Mission.AllOtherUSUnits[idx]
		if unit and unit.Dead then

			if unit.Class.Type == "Destroyer" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Fletcher
			elseif unit.Class.Type == "Fighter" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Hellcat
			elseif unit.Class.Type == "Cargo" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.TroopTransport
			elseif unit.Class.Type == "LandingShip" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Higgins
			elseif unit.Class.Type == "Cruiser" then
				local point = 0
				if unit.Class.ID == 316 then
					point = Mission.Points.Cleveland
				elseif unit.Class.ID == 20 then
					point = Mission.Points.Deruyter
				end
				Mission.ResourceUSPool = Mission.ResourceUSPool - point
			end

			table.remove(Mission.AllOtherUSUnits, idx)

		else

			if luaGetType(unit) == "plane" then
				local lastNum = luaC12GetSqMultiplier(unit)
				local actNum = table.getn(GetSquadronPlanes(unit))

				if lastNum > actNum then
					unit.sqadnumchecked = actNum
				end

				if unit.Class.Type == "Fighter" then
					Mission.ResourceUSPool = Mission.ResourceUSPool - (Mission.Points.Hellcat * (lastNum - actNum))
				end
			end
		end
		idx = idx - 1
	end

	if Mission.ResourceUSPool > 0 and Mission.ResourceJapPool > 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" US pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.MissionEndCalled = true
		luaS12MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaS12MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaS12MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaS12MissionEnd()
		end
	end

end

function luaC12GetUnits(Party)

	if Party == PARTY_JAPANESE then

		--local unitsTbl = luaSumTablesIndex(recon[Party].own.destroyer,recon[Party].own.fighter,recon[Party].own.divebomber,recon[Party].own.reconplane,recon[Party].own.cruiser)
		local unitsTbl = luaSumTablesIndex(recon[Party].own.fighter,recon[Party].own.divebomber,recon[Party].own.reconplane,recon[Party].own.cruiser)

		for idx,unit in pairs(unitsTbl) do
			if not unit.Dead and not luaIsInside(unit, Mission.AllOtherJPUnits) then
				table.insert(Mission.AllOtherJPUnits, unit)
			end
		end

		return Mission.AllOtherJPUnits

	elseif Party == PARTY_ALLIED then

		--local unitsTbl = luaSumTablesIndex(recon[Party].own.destroyer,recon[Party].own.fighter,recon[Party].own.cargo,recon[Party].own.landingship,recon[Party].own.cruiser)
		local unitsTbl = luaSumTablesIndex(recon[Party].own.fighter,recon[Party].own.cargo,recon[Party].own.landingship,recon[Party].own.cruiser)

		for idx,unit in pairs(unitsTbl) do
			if not unit.Dead and not luaIsInside(unit, Mission.AllOtherUSUnits) then
				table.insert(Mission.AllOtherUSUnits, unit)
			end
		end

		return Mission.AllOtherUSUnits

	end

end

function luaC12GetSqMultiplier(unit)
	if not unit.sqadnumchecked then
		return 3
	else
		return unit.sqadnumchecked
	end
end

function luaS12MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Scoring_RealPlayTimeRunning(false)

	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.USCV, "", nil, nil, nil, PARTY_ALLIED)
	end

end

function luaS12AddObj()
	Scoring_RealPlayTimeRunning(true)

	luaS12ShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	luaObj_Add("primary", 1, {Mission.USCV, Mission.HQ})
	luaObj_Add("primary", 2, {Mission.USCV, Mission.HQ})
end

function luaS12CheckObj()
	if Mission.HQ.Party ~= PARTY_JAPANESE then
		luaObj_Completed("primary",1)
		luaObj_Failed("primary",2)

		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end

		Mission.ResourceJapPool = 0

		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.USCV, "", nil, nil, nil, PARTY_ALLIED)

		--MissionNarrativeParty(PARTY_JAPANESE, "Sic transit gloria mundi!")
		--MissionNarrativeParty(PARTY_ALLIED, "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit!")

		--luaDelay(luaS12MissionEndUsWon,5)

		Mission.Completed = true

	end

	if Mission.USCV.Dead then
		luaObj_Failed("primary",1)
		luaObj_Completed("primary",2)

		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end

		Mission.ResourceUSPool = 0

		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)

		--MissionNarrativeParty(PARTY_ALLIED, "Sic transit gloria mundi!")
		--MissionNarrativeParty(PARTY_JAPANESE, "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit!")

		--luaDelay(luaS12MissionEndJPWon,5)

		Mission.Completed = true
	end
end

function luaS12ShowMissionHint()
	ShowHint("ID_Hint_Siege12")
end

function luaS12Warnings()

	if Mission.WarningsShown["HQ"][4] and Mission.WarningsShown["CV"][4] then
		return
	end

	local hpCV = GetHpPercentage(Mission.USCV)
	local hpHQ = GetHpPercentage(Mission.HQ)

	if hpCV <= 0.75 and not Mission.WarningsShown["CV"][1] then
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_cvhp_75")
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_cvhp_75")
		Mission.WarningsShown["CV"][1] = true
	elseif hpCV <= 0.5 and not Mission.WarningsShown["CV"][2] then
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_cvhp_50")
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_cvhp_50")
		Mission.WarningsShown["CV"][2] = true
	elseif hpCV <= 0.25 and not Mission.WarningsShown["CV"][3] then
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_cvhp_25")
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_cvhp_25")
		Mission.WarningsShown["CV"][3] = true
	elseif hpCV <= 0.1 and not Mission.WarningsShown["CV"][3] then
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_cvhp_10")
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_cvhp_10")
		Mission.WarningsShown["CV"][4] = true
	end

	if hpHQ <= 0.75 and not Mission.WarningsShown["HQ"][1] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_75")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_75")
		Mission.WarningsShown["HQ"][1] = true
	elseif hpHQ <= 0.5 and not Mission.WarningsShown["HQ"][2] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_50")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_50")
		Mission.WarningsShown["HQ"][2] = true
	elseif hpHQ <= 0.25 and not Mission.WarningsShown["HQ"][3] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_25")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_25")
		Mission.WarningsShown["HQ"][3] = true
	elseif hpHQ <= 0.1 and not Mission.WarningsShown["HQ"][3] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_10")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_10")
		Mission.WarningsShown["HQ"][4] = true
	end

end