-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(116) -- B17
	PrepareClass(135)	-- Warhawk
	PrepareClass(151)	-- Zero
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort04")
end

function luaInitEscort04(this)
	Mission = this
	Mission.Name = "Escort04"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort04")
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
		
	-- TODO PLAYERNUMBER SPECIFIC TARGET!!!!!!
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
		
	Mission.BomberSpawn = false
	Mission.Airfield = FindEntity("Multi Airfield")
	
	Mission.Keyunits = {}
	
	table.insert(Mission.Keyunits, FindEntity("Escort - Dakota1"))
	table.insert(Mission.Keyunits, FindEntity("Escort - Dakota2"))
	table.insert(Mission.Keyunits, FindEntity("Escort - Dakota3"))
	table.insert(Mission.Keyunits, FindEntity("Escort - Dakota4"))
	
	
	DisplayUnitHP(0,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(1,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(2,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(3,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(4,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(5,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(6,Mission.Keyunits, "globals.unitclass_douglas")
	DisplayUnitHP(7,Mission.Keyunits, "globals.unitclass_douglas")
	
	Mission.SouthDakota = FindEntity("Escort South Dakota")
	Mission.Cargo1 = FindEntity("Escort Cargo")
	Mission.Cargo2 = FindEntity("Escort Cargo 01")
	Mission.Clemson = FindEntity("Escort Clemson")
	Mission.Minekaze1 = FindEntity("Escort - Minekaze")
	Mission.Minekaze1 = FindEntity("Escort - Minekaze 01")
	Mission.Minekaze1 = FindEntity("Escort - Minekaze 02")
	Mission.Minekaze1 = FindEntity("Escort - Minekaze 03")
		
	Mission.EscortF1TMP = luaFindHidden("Escort P-40 01")
	Mission.EscortF2TMP = luaFindHidden("Escort P-40 02")
	Mission.EscortF3TMP = luaFindHidden("Escort P-40 03")
	Mission.EscortF4TMP = luaFindHidden("Escort P-40 04")
	Mission.EscortF5TMP = luaFindHidden("Escort P-40 05")
	Mission.EscortF6TMP = luaFindHidden("Escort P-40 06")
	Mission.EscortF7TMP = luaFindHidden("Escort P-40 07")
	Mission.EscortF8TMP = luaFindHidden("Escort P-40 08")
	
	Mission.Dakota1 = FindEntity("Escort - Dakota1")
	Mission.Dakota2 = FindEntity("Escort - Dakota2")
	Mission.Dakota3 = FindEntity("Escort - Dakota3")
	Mission.Dakota4 = FindEntity("Escort - Dakota4")
	
	AISetHintWeight(Mission.Dakota1, 8)
	AISetHintWeight(Mission.Dakota2, 8)
	AISetHintWeight(Mission.Dakota3, 8)
	AISetHintWeight(Mission.Dakota4, 8)
		
	Mission.Carrier1 = FindEntity("Escort - Akagi")
	Mission.Carrier2 = FindEntity("Escort - Zuiho")
	Mission.Carrier3 = FindEntity("Escort - Soryu")
	Mission.Carrier4 = FindEntity("Escort - Hiryu")
		
	Mission.EscortPath1 = FindEntity("escortpath 01")
	Mission.EscortPath2 = FindEntity("escortpath 02")
	Mission.EscortPath3 = FindEntity("escortpath 03")
	Mission.EscortPath4 = FindEntity("escortpath 04")
	
	Mission.Raidens = {}
	
	if Mission.Players == 1 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)	
	elseif Mission.Players == 2 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
	elseif Mission.Players == 3 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
	elseif Mission.Players == 4 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
		Mission.EscortF4 = GenerateObject(Mission.EscortF4TMP.Name)
	elseif Mission.Players == 5 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
		Mission.EscortF4 = GenerateObject(Mission.EscortF4TMP.Name)
		Mission.EscortF5 = GenerateObject(Mission.EscortF5TMP.Name)
	elseif Mission.Players == 6 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
		Mission.EscortF4 = GenerateObject(Mission.EscortF4TMP.Name)
		Mission.EscortF5 = GenerateObject(Mission.EscortF5TMP.Name)
		Mission.EscortF6 = GenerateObject(Mission.EscortF6TMP.Name)
	elseif Mission.Players == 7 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
		Mission.EscortF4 = GenerateObject(Mission.EscortF4TMP.Name)
		Mission.EscortF5 = GenerateObject(Mission.EscortF5TMP.Name)
		Mission.EscortF6 = GenerateObject(Mission.EscortF6TMP.Name)
		Mission.EscortF7 = GenerateObject(Mission.EscortF7TMP.Name)		
	elseif Mission.Players == 8 then
		Mission.EscortF1 = GenerateObject(Mission.EscortF1TMP.Name)
		Mission.EscortF2 = GenerateObject(Mission.EscortF2TMP.Name)
		Mission.EscortF3 = GenerateObject(Mission.EscortF3TMP.Name)
		Mission.EscortF4 = GenerateObject(Mission.EscortF4TMP.Name)
		Mission.EscortF5 = GenerateObject(Mission.EscortF5TMP.Name)
		Mission.EscortF6 = GenerateObject(Mission.EscortF6TMP.Name)
		Mission.EscortF7 = GenerateObject(Mission.EscortF7TMP.Name)
		Mission.EscortF8 = GenerateObject(Mission.EscortF8TMP.Name)
	end	
	
	Mission.TargetPoint = {}
		Mission.TargetPoint.x = 1645
		Mission.TargetPoint.y = 150
		Mission.TargetPoint.z = -9646
		
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
	
	--Events
	Mission.FirstEvent = 1
	Mission.SecondEvent = 80
	Mission.ThirdEvent = 180
	
	Mission.RaidenSpawn = false
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort04_think")
	
	--AddWatch("Mission.MusicLevel")
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort04_think(this, msg)
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
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")		
		luaSetObjectives()
		luaStartKeyUnits()
		luaShowMissionHint()		
	end
	
	luaCheckKeyunits()
	luaCheckExitPoint()
	luaCheckCargos()
	luaSetRaidenTargets()
	luaEvents()
	luaSetBomberTarget()
	
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
function luaSetObjectives()
		-- allied objs		
			luaObj_Add("primary", 1, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4]})
			-- japanese objs
			luaObj_Add("primary", 2, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4]})
end

function luaStartKeyUnits()
	local path1 = FindEntity("escortpath1")
	
	local Cpath1 = FindEntity("escort allipath1")
	local Cpath2 = FindEntity("escort allipath2")
	local Cpath3 = FindEntity("escort jappath1")
	local Cpath4 = FindEntity("escort jappath2")

	--NavigatorMoveOnPath(Mission.Carrier1, Cpath1)
	
		NavigatorMoveOnPath(Mission.Cargo1, Cpath2)
		NavigatorMoveOnPath(Mission.Cargo2, Cpath2)
		NavigatorMoveOnPath(Mission.SouthDakota, Cpath3)
		JoinFormation(Mission.Clemson, Mission.SouthDakota)		
		
	--NavigatorMoveOnPath(Mission.Carrier4, Cpath4)

	--[[
	local number = luaRnd(1,1)
	if number == 1 then
		for idx, unit in pairs (Mission.Keyunits) do
			PilotMoveOnPath(unit, path1)
		end
	end
	--]]
	
	if Mission.Players == 1 then
	
	PilotMoveToRange(Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
--	TODO local megoldas
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
	
	elseif Mission.Players == 2 then
	
	PilotMoveToRange(Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange(Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)

--	TODO local megoldas
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
		
	elseif Mission.Players == 3 then
		
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)

--	TODO local megoldas
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
		
	elseif Mission.Players == 4 then
		
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	
	PilotMoveToRange (Mission.EscortF4, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF4, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF4, 2)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
		
		
	elseif Mission.Players == 5 then
	
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	
	PilotMoveToRange (Mission.EscortF4, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF4, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF4, 2)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
	
	PilotMoveToRange (Mission.EscortF5, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF5, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF5, 2)
	
						
	elseif Mission.Players == 6 then
	
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	
	PilotMoveToRange (Mission.EscortF4, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF4, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF4, 2)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
	
	PilotMoveToRange (Mission.EscortF5, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF5, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF5, 2)
	
	
	PilotMoveToRange (Mission.EscortF6, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF6, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF6, 2)
	
		
	elseif Mission.Players == 7 then
		
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	
	PilotMoveToRange (Mission.EscortF4, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF4, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF4, 2)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
		
	PilotMoveToRange (Mission.EscortF5, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF5, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF5, 2)

	
	PilotMoveToRange (Mission.EscortF6, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF6, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF6, 2)

	
	PilotMoveToRange (Mission.EscortF7, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF7, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF7, 2)

	
	elseif Mission.Players == 8 then	
	
	PilotMoveToRange (Mission.EscortF1, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF1, 2)
	PilotMoveOnPath(Mission.Dakota1, Mission.EscortPath1)
	
	PilotMoveToRange (Mission.EscortF2, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF2, 2)
	PilotMoveOnPath(Mission.Dakota2, Mission.EscortPath2)
	
	PilotMoveToRange (Mission.EscortF3, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF3, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF3, 2)
	PilotMoveOnPath(Mission.Dakota3, Mission.EscortPath3)
	
	PilotMoveToRange (Mission.EscortF4, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF4, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF4, 2)
	PilotMoveOnPath(Mission.Dakota4, Mission.EscortPath4)
	
	PilotMoveToRange (Mission.EscortF5, Mission.Dakota1)
	SetRoleAvailable(Mission.EscortF5, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF5, 2)

	
	PilotMoveToRange (Mission.EscortF6, Mission.Dakota2)
	SetRoleAvailable(Mission.EscortF6, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF6, 2)

	
	PilotMoveToRange (Mission.EscortF7, Mission.Dakota3)
	SetRoleAvailable(Mission.EscortF7, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF7, 2)

	
	PilotMoveToRange (Mission.EscortF8, Mission.Dakota4)
	SetRoleAvailable(Mission.EscortF8, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.EscortF8, 2)
	
	
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

function luaEventSpawn1()
--US
	local SpawnCoord = GetPosition(Mission.EventSpawnCoord1)
	
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 116,
			["Name"] = "B-17",
			["Crew"] = 3,
			["Race"] = USA,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-180),DEG(180)},
	},
	["callback"] = "luaEventSpawn1Callback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 15,
		["enemyHorizontal"] = 15,
		["ownVertical"] = 15,
		["enemyVertical"] = 15,
		["formationHorizontal"] = 100,
	},
	})
-- RELEASE_LOGOFF  	luaLog("PT spawn done")
end

function luaEventSpawn2()
--US

	local SpawnCoord = GetPosition(Mission.EventSpawnCoord1)
	

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 116,
			["Name"] = "B-17",
			["Crew"] = 3,
			["Race"] = USA,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-180),DEG(180)},
	},
	["callback"] = "luaEventSpawn2Callback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100,
	},
	})
-- RELEASE_LOGOFF  	luaLog("Wildcat spawn done")

end

function luaEventSpawn1Callback(unit1)
	
	Mission.Bomber1 = unit1
	
	local Event1Units = {}
	table.insert(Event1Units, unit1)
	
	for idx,unit in pairs (Event1Units) do
	if not Mission.Carrier2.Dead then
		PilotSetTarget(unit, Mission.Carrier2)
		--PilotRetreat(unit)
	end
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end
	Mission.BomberSpawn = true
-- RELEASE_LOGOFF  	luaLog("spawn1 callback done")
end

function luaEventSpawn2Callback(unit1)
	
	Mission.Bomber1 = unit1
	
	local Event1Units = {}
	table.insert(Event1Units, unit1)
	
	
	for idx,unit in pairs (Event1Units) do
	if not Mission.Carrier1.Dead then
		PilotSetTarget(unit, Mission.Carrier1)
	end
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end
	Mission.BomberSpawn = true
-- RELEASE_LOGOFF  	luaLog("spawn1 callback done")
end

-- random segitseg
function luaEvents()
	if Mission.StepCounter == Mission.FirstEvent then
		luaEventSpawn1()
	--[[
	elseif
		Mission.StepCounter == Mission.SecondEvent then
		luaEventSpawn1()
	elseif
		Mission.StepCounter == Mission.ThirdEvent then
		luaEventSpawn1()
	--]]
	end
end

function luaSetBomberTarget()
	if Mission.BomberSpawn == true then
		if not Mission.Bomber1.Dead and not Mission.Carrier2.Dead then
			if not GetPayload(Mission.Bomber1, 1) == nil  then
				PilotSetTarget(Mission.Bomber1 , Mission.Carrier2)			
			end
		end
		if Mission.Carrier2.Dead and not Mission.Bomber1.Dead then
			PilotRetreat(Mission.Bomber1)
		end			
	end
end
function luaCheckCargos()
	if Mission.Cargo1.Dead and Mission.Cargo2.Dead then
		if not Mission.RaidenSpawn then
			luaJpBrutalForceSpawn()
			Mission.RaidenSpawn = true
		end
	end
end
function luaShowMissionHint()
	ShowHint("ID_Hint_Escort04")
	-- mode description hint overlay
end

function luaJpBrutalForceSpawn()
--JP
	local SpawnCoord = GetPosition(Mission.EventSpawnCoord2)
	
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 151,
			["Name"] = "J2M Raiden",
			["Crew"] = 3,
			["Race"] = Japanese,
			["Equipment"] = 0,
		},
		{
			["Type"] = 151,
			["Name"] = "J2M Raiden",
			["Crew"] = 3,
			["Race"] = Japanese,
			["Equipment"] = 0,
		},
		{
		["Type"] = 151,
			["Name"] = "J2M Raiden",
			["Crew"] = 3,
			["Race"] = Japanese,
			["Equipment"] = 0,
		},
		{
			["Type"] = 151,
			["Name"] = "J2M Raiden",
			["Crew"] = 3,
			["Race"] = Japanese,
			["Equipment"] = 0,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-180),DEG(180)},
	},
	["callback"] = "luaEventJPCallback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 15,
		["enemyHorizontal"] = 15,
		["ownVertical"] = 15,
		["enemyVertical"] = 15,
		["formationHorizontal"] = 100,
	},
	})
-- RELEASE_LOGOFF  	luaLog("Raiden spawn done")
end

function luaEventJPCallback(unit1, unit2, unit3, unit4)
--todo jp event callback, target
	
	
	Mission.Raidens = {}
	table.insert(Mission.Raidens, unit1)
	table.insert(Mission.Raidens, unit2)
	table.insert(Mission.Raidens, unit3)
	table.insert(Mission.Raidens, unit4)
	
	
	
	for idx,unit in pairs (Mission.Raidens) do
		if not Mission.Dakota1.Dead then
			PilotSetTarget(unit, Mission.Dakota1)			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			UnitFreeAttack(unit)
		elseif not Mission.Dakota2.Dead then
			PilotSetTarget(unit, Mission.Dakota2)			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			UnitFreeAttack(unit)
		elseif not Mission.Dakota3.Dead then
			PilotSetTarget(unit, Mission.Dakota3)			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			UnitFreeAttack(unit)
		elseif not Mission.Dakota4.Dead then
			PilotSetTarget(unit, Mission.Dakota4)			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			UnitFreeAttack(unit)
		end	
	end
-- RELEASE_LOGOFF  	luaLog("Raiden spawn callback done")
end

function luaSetRaidenTargets()
	if Mission.RaidenSpawn == true then
		Mission.Raidens = luaRemoveDeadsFromTable(Mission.Raidens)
		for idx,unit in pairs (Mission.Raidens) do
			if not Mission.Dakota1.Dead then
				PilotSetTarget(unit, Mission.Dakota1)
				
			elseif not Mission.Dakota2.Dead then
				PilotSetTarget(unit, Mission.Dakota2)
				
			elseif not Mission.Dakota3.Dead then
				PilotSetTarget(unit, Mission.Dakota3)
				
			elseif not Mission.Dakota4.Dead then
				PilotSetTarget(unit, Mission.Dakota4)
				
			end
		end
	end
end