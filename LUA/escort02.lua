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
	CreateScript("luaInitEscort02")
end

function luaInitEscort02(this)
	Mission = this
	Mission.Name = "Escort02"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort02")
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
-- Mission params
	
	--TODO
	
	--Eliminite the convoy before the enemy reiforcements arrive
	--Kamikaze planes, Submarines, fighters on the japanese side
	
	--DD-s, Pt-boats, Fighters on the allied side
	
	-- reiforcements (CA, DD, Fighters)
	-- Camera on the incoming units at MissionEnd or on the last sinking unit
	
	Mission.BettySpawn = false
	
	Mission.TT1 = FindEntity("Troop Transport 1")
	Mission.TT2 = FindEntity("Troop Transport 2")
	Mission.TT3 = FindEntity("Troop Transport 3")
	Mission.TT4 = FindEntity("Troop Transport 4")
	Mission.TT5 = FindEntity("Troop Transport 5")
	
	Mission.Keyunits = {}
	table.insert(Mission.Keyunits, FindEntity("Troop Transport 1"))
	table.insert(Mission.Keyunits, FindEntity("Troop Transport 2"))	
	table.insert(Mission.Keyunits, FindEntity("Troop Transport 3"))
	table.insert(Mission.Keyunits, FindEntity("Troop Transport 4"))
	table.insert(Mission.Keyunits, FindEntity("Troop Transport 5"))
	
	DisplayUnitHP(0,Mission.Keyunits)
	DisplayUnitHP(1,Mission.Keyunits)
	DisplayUnitHP(2,Mission.Keyunits)
	DisplayUnitHP(3,Mission.Keyunits)
	DisplayUnitHP(4,Mission.Keyunits)
	DisplayUnitHP(5,Mission.Keyunits)
	DisplayUnitHP(6,Mission.Keyunits)
	DisplayUnitHP(7,Mission.Keyunits)
	
	Mission.Destroyer1 = FindEntity("Fletcher 01")
	Mission.Destroyer2 = FindEntity("Fletcher 02")
	Mission.Destroyer3 = FindEntity("Fletcher 03")
	Mission.Destroyer4 = FindEntity("Fletcher 04")
	Mission.Destroyer5 = FindEntity("Fletcher 05")
	Mission.Destroyer6 = FindEntity("Fletcher 06")
	
	Mission.TargetPoint = {}
		Mission.TargetPoint.x = 2472.26
		Mission.TargetPoint.y = 0
		Mission.TargetPoint.z = 695.58
		
	Mission.SpawnPoint1 = FindEntity("Escort - SpawnPoint 01")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint1: "..tostring(FindEntity("Escort - SpawnPoint1")))
	
	Mission.SpawnPoint2 = FindEntity("Escort - SpawnPoint 02")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint2")))
	
	Mission.SpawnPoint3 = FindEntity("Escort - SpawnPoint 03")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint3")))
	--Japanese
	Mission.EventSpawnCoord1 = FindEntity("Escort - EventSpawnCoord 01")
	Mission.EventSpawnCoord2 = FindEntity("Escort - EventSpawnCoord 02")
	--Allied 
	Mission.EventSpawnCoord3 = FindEntity("Escort - EventSpawnCoord 03")
	Mission.EventSpawnCoord4 = FindEntity("Escort - EventSpawnCoord 04")
	
	Mission.CB = FindEntity("Escort CB")
	
	--[[
	Mission.TestTargetPoint = {}	
		Mission.TestTargetPoint.x = 9540
		Mission.TestTargetPoint.y = 0
		Mission.TestTargetPoint.z = 6902
	--]]

	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CarrierDead = false	
	--Events
	Mission.FirstEvent = 50
	--[[
	Mission.SecondEvent = 25
	Mission.ThirdEvent = 50
	Mission.FourthEvent = 75
	Mission.FifthEvent = 100
	Mission.SixthEvent = 125
	Mission.SeventhEvent = 150
	Mission.EighthEvent = 175
	Mission.NinthEvent = 200
	Mission.TenthEvent = 225
	--]]
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort02_think")
	
	--AddWatch("Mission.MusicLevel")
		
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort02_think(this, msg)
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
		luaObj_Add("primary", 1, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4],Mission.Keyunits[5], Mission.TargetPoint})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4],Mission.Keyunits[5], Mission.TargetPoint})
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()
		luaShowMissionHint()		
	end
	
	luaCheckKeyunits()
	--luaCheckExitPoint()
	luaCheckLanding()
	--luaEvents()
	--luaSetKamikazeTarget()
	
	
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
	--todo hajo ai javitas utan megvizsgalni pathon haladast esetleg formacioban kezelni
	
	local ttpath1 = FindEntity("escortpathtt 01")
	local ttpath2 = FindEntity("escortpathtt 02")
	local ttpath3 = FindEntity("escortpathtt 03")
	local ttpath4 = FindEntity("escortpathtt 04")
	local ttpath5 = FindEntity("escortpathtt 05")	
		
	local path2 = FindEntity("escortpath 02")
	local path3 = FindEntity("escortpath 03")	
	local path4 = FindEntity("escortpath 04")	
	local path5 = FindEntity("escortpath 05")	
	local path6 = FindEntity("escortpath 06")	
		
		for idx, unit in pairs (Mission.Keyunits) do
			SetShipMaxSpeed(unit, 10.28888)							
		end		
		
		NavigatorMoveOnPath(Mission.TT1, ttpath1)
		NavigatorMoveOnPath(Mission.TT2, ttpath2)
		NavigatorMoveOnPath(Mission.TT3, ttpath3)
		NavigatorMoveOnPath(Mission.TT4, ttpath4)
		NavigatorMoveOnPath(Mission.TT5, ttpath5)
		
		
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer1, path6)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer2, path2)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer3, path3)
		SetShipMaxSpeed(Mission.Destroyer4, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer4, path4)
		SetShipMaxSpeed(Mission.Destroyer5, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer5, path5)
		SetShipMaxSpeed(Mission.Destroyer6, 10.28888)
		NavigatorMoveOnPath(Mission.Destroyer6, path6)
	
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
-- RELEASE_LOGOFF  	luaLog("Cheking Exit Point")
	Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
	for IDx, unit in pairs (Mission.Keyunits) do
		if luaGetDistance(unit, Mission.TargetPoint ) < 500 then
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

function luaGetPlayers()
	local MPlayers = Multi_GetPlayers()
-- RELEASE_LOGOFF  	luaLog("Multi player dump")
	for IDx, player in pairs (MPlayers) do
-- RELEASE_LOGOFF  			luaLog("Index: "..IDx..", "..tostring(player))
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort02")
	-- mode description hint overlay
end

function luaCheckLanding()
-- RELEASE_LOGOFF  	luaLog("Landing Range")
	Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
	for IDx, unit in pairs (Mission.Keyunits) do
		if luaGetDistance(unit, Mission.CB ) < 1900 then
			--Startlanding
				StartLanding2(unit)
				luaCheckExitPoint()
		end
	end
end