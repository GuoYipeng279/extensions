-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
 PrepareClass(32) -- Betty with Ohka
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort05")
end

function luaInitEscort05(this)
	Mission = this
	Mission.Name = "Escort05"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort05")
-- Loc-Kit dolgok
--	AddLockitPathToSelection(this.Name)
--	AddLockitPathToSelection("missionglobals")
--	AddLockitPathToSelection("mm01")
--	LoadSelectedPaths()
	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")
-- mission objectives
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "mp.obj_es_def",
				--["Text"] = "mm01.obj_p1",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "mp.obj_ic_uswon",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "mp.obj_ic_jpwon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "mp.obj_es_des",
				--["Text"] = "mm01.obj_p2",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "mp.obj_ic_jpwon",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "mp.obj_ic_uswon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
	}
	Mission.BettySpawn1 = false
	Mission.BettySpawn2 = false
	Mission.BettySpawn3 = false
	Mission.BettySpawn4 = false
	
	Mission.TempEventPlanes = {}
	
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, FindEntity("Escort - Carrier1"))
		table.insert(Mission.Keyunits, FindEntity("Escort - Carrier2"))
		table.insert(Mission.Keyunits, FindEntity("Escort - Carrier3"))
		table.insert(Mission.Keyunits, FindEntity("Escort - Carrier4"))

	for i = 0, 7 do
		DisplayUnitHP(i, Mission.Keyunits, "mp05.score_us_cv_hp")
	end

	Mission.Carrier1 = FindEntity("Escort - Carrier1")
	Mission.Carrier2 = FindEntity("Escort - Carrier2")
	Mission.Carrier3 = FindEntity("Escort - Carrier3")
	Mission.Carrier4 = FindEntity("Escort - Carrier4")
	
	Mission.Destroyer1 = FindEntity("Escort - Fletcher 01")
	Mission.Destroyer2 = FindEntity("Escort - Fletcher 02")
	Mission.Destroyer3 = FindEntity("Escort - Fletcher 03")
	Mission.Destroyer4 = FindEntity("Escort - Fletcher 04")
	Mission.Destroyer5 = FindEntity("Escort - Fletcher 05")
	Mission.Destroyer6 = FindEntity("Escort - Fletcher 06")
	Mission.Destroyer7 = FindEntity("Escort - Fletcher 07")
	Mission.Destroyer8 = FindEntity("Escort - Fletcher 08")
	
	Mission.USNFleet = {}
		table.insert(Mission.USNFleet, Mission.Carrier1)
		table.insert(Mission.USNFleet, Mission.Carrier2)
		table.insert(Mission.USNFleet, Mission.Carrier3)
		table.insert(Mission.USNFleet, Mission.Carrier4)
		table.insert(Mission.USNFleet, Mission.Destroyer1)
		table.insert(Mission.USNFleet, Mission.Destroyer2)
		table.insert(Mission.USNFleet, Mission.Destroyer3)
		table.insert(Mission.USNFleet, Mission.Destroyer4)
		table.insert(Mission.USNFleet, Mission.Destroyer5)
		table.insert(Mission.USNFleet, Mission.Destroyer6)
		table.insert(Mission.USNFleet, Mission.Destroyer7)
		table.insert(Mission.USNFleet, Mission.Destroyer8)

	Mission.TargetPoint = GetPosition(FindEntity("Escort - Carrier_Exit"))

--[[	
	Mission.TargetPoint = {}
		Mission.TargetPoint.x = 689.6420
		Mission.TargetPoint.y = 0
		Mission.TargetPoint.z = 6310.8901
]]
		--689.6420 150.0000 6310.8901
	Mission.SpawnPoint1 = FindEntity("Escort - SpawnPoint 01")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint1: "..tostring(FindEntity("Escort - SpawnPoint1")))
	
	Mission.SpawnPoint2 = FindEntity("Escort - SpawnPoint 02")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint2")))
	
	Mission.SpawnPoint3 = FindEntity("Escort - SpawnPoint 03")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint3: "..tostring(FindEntity("Escort - SpawnPoint3")))
	
	Mission.SpawnPoint4 = FindEntity("Escort - SpawnPoint 04")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint4: "..tostring(FindEntity("Escort - SpawnPoint4")))

	Mission.SpawnPoint5 = FindEntity("Escort - SpawnPoint 05")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint5: "..tostring(FindEntity("Escort - SpawnPoint5")))
	
	Mission.SpawnPoint6 = FindEntity("Escort - SpawnPoint 06")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint6: "..tostring(FindEntity("Escort - SpawnPoint6")))
	
	Mission.SpawnPoint7 = FindEntity("Escort - SpawnPoint 07")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint7: "..tostring(FindEntity("Escort - SpawnPoint7")))
	
	Mission.SpawnPoint8 = FindEntity("Escort - SpawnPoint 08")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint8: "..tostring(FindEntity("Escort - SpawnPoint8")))
	
--Japanese

	Mission.IJNCarrier = FindEntity("Escort - Kaga")

	Mission.EventSpawnCoords = {}
--		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 01"))
--		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 02"))
		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 03"))
		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 04"))
		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 05"))
		table.insert(Mission.EventSpawnCoords, FindEntity("Escort - EventSpawnCoord 06"))
	
	Mission.EventSpawnCoord1 = FindEntity("Escort - EventSpawnCoord 01")
	Mission.EventSpawnCoord2 = FindEntity("Escort - EventSpawnCoord 02")
	Mission.EventSpawnCoord3 = FindEntity("Escort - EventSpawnCoord 03")
	Mission.EventSpawnCoord4 = FindEntity("Escort - EventSpawnCoord 04")
	Mission.EventSpawnCoord5 = FindEntity("Escort - EventSpawnCoord 05")
	Mission.EventSpawnCoord6 = FindEntity("Escort - EventSpawnCoord 06")
	
	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CarrierDead = false	
--Events
-- Reminder: Event atiras
--	Mission.FirstEvent = 25
--	Mission.SecondEvent = 50
--	Mission.ThirdEvent = 75
--	Mission.FourthEvent = 100
	Mission.EventKamikazePlanes = {}
		table.insert(Mission.EventKamikazePlanes, 32)		-- Betty with Ohka
--		table.insert(Mission.EventKamikazePlanes, 45)		-- Kamikaze Zero
--		table.insert(Mission.EventKamikazePlanes, 100)	-- Kamikaze Oscar
--		table.insert(Mission.EventKamikazePlanes, 46)		-- Kamikaze Val
--		table.insert(Mission.EventKamikazePlanes, 103)	-- Kamikaze Judy
		
	Mission.EventPlanes = {}
	Mission.Event1 = 60
	Mission.Event2 = 110
	Mission.Event3 = 160
	Mission.Event4 = 210
	Mission.Event5 = 260
--	Mission.Event6 = 250
	
--AddWatch("Mission.MusicLevel")
-- RELEASE_LOGOFF  	AddWatch("Mission.StepCounter")

-- Players
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort05_think")
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort05_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end
	if this.MissionStart then
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Adding objectives")
-- RELEASE_LOGOFF  		luaLog("")
		-- allied objs
		luaObj_Add("primary", 1, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4], Mission.TargetPoint})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4], Mission.TargetPoint})
		this.MissionStart = false
		Mission.SpawnCheckNeed = true
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()
		luaShowMissionHint()
	end
	
	luaCheckKeyunits()
	luaCheckExitPoint()
	luaEvents()
	luaSetKamikazeTarget()
	
	Mission.StepCounter = Mission.StepCounter+1 
	
-- objective giving
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------

function luaStartKeyUnits()

	local path1 = FindEntity("Escort - US Fleet Path 01")
	local path2 = FindEntity("Escort - US Fleet Path 02")
	local path3 = FindEntity("Escort - US Fleet Path 03")
	local path4 = FindEntity("Escort - US Fleet Path 04")
	local path5 = FindEntity("Escort - US Fleet Path 05")
	local path6 = FindEntity("Escort - US Fleet Path 06")
	local path7 = FindEntity("Escort - US Fleet Path 07")
	local path8 = FindEntity("Escort - US Fleet Path 08")	
	local path9 = FindEntity("Escort - US Fleet Path 09")
	local path10 = FindEntity("Escort - US Fleet Path 10")
	local path11 = FindEntity("Escort - US Fleet Path 11")
	local path12 = FindEntity("Escort - US Fleet Path 12")
	
	local ijncvpath = FindEntity("Escort - IJN Carrier Path")
	
	NavigatorMoveOnPath(Mission.IJNCarrier, ijncvpath)
	SetShipMaxSpeed(Mission.IJNCarrier, 10.28888)
	
	AddListener("kill", "carrierdied", {
		["callback"] = "luaIJNCarrierDied",  -- callback fuggveny
		["entity"] = {Mission.IJNCarrier}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	
  NavigatorMoveOnPath(Mission.Carrier1, path1)
	NavigatorMoveOnPath(Mission.Carrier2, path2)
	NavigatorMoveOnPath(Mission.Carrier3, path3)
	NavigatorMoveOnPath(Mission.Carrier4, path4)
	
	NavigatorMoveOnPath(Mission.Destroyer1, path5)
	NavigatorMoveOnPath(Mission.Destroyer2, path6)
	NavigatorMoveOnPath(Mission.Destroyer3, path7)
	NavigatorMoveOnPath(Mission.Destroyer4, path8)
	NavigatorMoveOnPath(Mission.Destroyer5, path9)
	NavigatorMoveOnPath(Mission.Destroyer6, path10)
	NavigatorMoveOnPath(Mission.Destroyer7, path11)
	NavigatorMoveOnPath(Mission.Destroyer8, path12)	
	
	local DDs = {}
	
	table.insert(DDs, FindEntity("Escort - Fletcher 01"))
	table.insert(DDs, FindEntity("Escort - Fletcher 02"))
	table.insert(DDs, FindEntity("Escort - Fletcher 03"))
	table.insert(DDs, FindEntity("Escort - Fletcher 04"))
	table.insert(DDs, FindEntity("Escort - Fletcher 05"))
	table.insert(DDs, FindEntity("Escort - Fletcher 06"))
	table.insert(DDs, FindEntity("Escort - Fletcher 07"))
	table.insert(DDs, FindEntity("Escort - Fletcher 08"))
	
	for idx, unit in pairs (DDs) do
		SetShipSpeed(unit, 10.28888)
		SetShipMaxSpeed(unit, 10.28888)
	end

-- Formacio egyben tartas hack
--	SetShipSpeed(DDs[3], 13)
--	SetShipSpeed(DDs[5], 13)
--	SetShipSpeed(DDs[4], 10)
--	SetShipSpeed(DDs[6], 10)
--	SetShipSpeed(DDs[1], 11.5)
--	SetShipSpeed(DDs[7], 11.5)
	
	local CVs = {}
	
	table.insert(CVs, FindEntity("Escort - Carrier1"))
	table.insert(CVs, FindEntity("Escort - Carrier2"))
	table.insert(CVs, FindEntity("Escort - Carrier3"))
	table.insert(CVs, FindEntity("Escort - Carrier4"))
	
	for idx, unit in pairs (CVs) do
		SetShipSpeed(unit, 10.28888)
		SetShipMaxSpeed(unit, 10.28888)
	end	

-- Formacio egyben tartas hack
--	SetShipSpeed(CVs[2], 10)
--	SetShipSpeed(CVs[4], 10)

end

function luaIJNCarrierDied()

	for i = 0, 7 do
		MissionNarrativePlayer(i, "mp05.nar_es_jpcv_lost")
	end

end

function luaCheckKeyunits()
	if table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) == 0 then
		lastbanto = Mission.Keyunits[1].LastBanto
		luaMissionCompletedNew(lastbanto, "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.MissionEnd = true
	else
		luaRemoveDeadsFromTable(Mission.Keyunits)
	end
end

function luaCheckExitPoint()
-- RELEASE_LOGOFF  --	luaLog("Cheking Exit Point")
	Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
	for IDx, unit in pairs (Mission.Keyunits) do
		if luaGetDistance(unit, Mission.TargetPoint) < 500 then
			luaMissionCompletedNew(unit, "", nil, nil, nil, PARTY_ALLIED)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
			Mission.MissionEnd = true	
-- RELEASE_LOGOFF  			luaLog("Mission End1")
-- RELEASE_LOGOFF  			luaLog("Calling Mission Completed")
			-- allied wins
		end
	end
end

-- random segitseg
function luaEvents()

	if Mission.StepCounter == Mission.Event1 then
		luaEventSpawn()
	elseif Mission.StepCounter == Mission.Event2 then
		luaEventSpawn()
	elseif Mission.StepCounter == Mission.Event3 then
		luaEventSpawn()
	elseif Mission.StepCounter == Mission.Event4 then
		luaEventSpawn()
	elseif Mission.StepCounter == Mission.Event5 then
		luaEventSpawn()
	elseif Mission.StepCounter == Mission.Event6 then
		luaEventSpawn()
	end

end

function luaEventSpawn()

	Mission.SpawnCoord = luaPickRnd(Mission.EventSpawnCoords)

	Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
	Mission.USNFleet = luaRemoveDeadsFromTable(Mission.USNFleet)

	if Mission.Players > 4 then	
		local spawncoordpos = GetPosition(Mission.SpawnCoord)
		Mission.Kamikaze01temp = luaFindHidden("Escort - BettyTemp")
		Mission.Kamikaze01 = GenerateObject(Mission.Kamikaze01temp.Name)
		PutTo(Mission.Kamikaze01, spawncoordpos)
		UnitFreeFire(Mission.Kamikaze01)
		local trg1 = luaPickRnd(Mission.USNFleet)
		PilotSetTarget(Mission.Kamikaze01, trg1)
		EntityTurnToEntity(Mission.Kamikaze01, trg1)
		table.insert(Mission.EventPlanes, Mission.Kamikaze01)
		
		local vector = {["x"] = spawncoordpos.x+100, ["y"] = spawncoordpos.y-100, ["z"] = spawncoordpos.z+100}
		Mission.Kamikaze02temp = luaFindHidden("Escort - BettyTemp")
		Mission.Kamikaze02 = GenerateObject(Mission.Kamikaze02temp.Name)
		PutTo(Mission.Kamikaze02, vector)
		UnitFreeFire(Mission.Kamikaze02)
		local trg2 = luaPickRnd(Mission.USNFleet)
		PilotSetTarget(Mission.Kamikaze02, trg2)
		EntityTurnToEntity(Mission.Kamikaze02, trg2)
		table.insert(Mission.EventPlanes, Mission.Kamikaze02)
	else
		local spawncoordpos = GetPosition(Mission.SpawnCoord)
		Mission.Kamikaze01temp = luaFindHidden("Escort - BettyTemp")
		Mission.Kamikaze01 = GenerateObject(Mission.Kamikaze01temp.Name)
		PutTo(Mission.Kamikaze01, spawncoordpos)
		UnitFreeFire(Mission.Kamikaze01)
		local trg1 = luaPickRnd(Mission.USNFleet)
		PilotSetTarget(Mission.Kamikaze01, trg1)
		EntityTurnToEntity(Mission.Kamikaze01, trg1)
		table.insert(Mission.EventPlanes, Mission.Kamikaze01)
	end

	for i = 0, 7 do
		MissionNarrativePlayer(i, "mp.nar_jp_reinf_arrived")
	end

-- RELEASE_LOGOFF  	luaLog("Kamikaze spawn done")	

end

function luaSetKamikazeTarget()

	Mission.USNFleet = luaRemoveDeadsFromTable(Mission.USNFleet)
	Mission.EventPlanes = luaRemoveDeadsFromTable(Mission.EventPlanes)

	if luaCountTable(Mission.EventPlanes) ~= 0 and luaCountTable(Mission.USNFleet) ~= 0 then
		for idx, unit in pairs(Mission.EventPlanes) do
			if GetPayload(unit, 1) ~= nil and UnitGetAttackTarget(unit) == nil or unit.Class.ID ~= 32 and UnitGetAttackTarget(unit) == nil then
				local trg = luaPickRnd(Mission.USNFleet)
				PilotSetTarget(unit, trg)
-- RELEASE_LOGOFF  				luaLog(unit.Name .."Got New Target: ".. trg.Name)
			elseif GetPayload(unit, 1) == nil then
				PilotRetreat(unit)
			end
		end
	end

end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort05")
	-- mode description hint overlay
end