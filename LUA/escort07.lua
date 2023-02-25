-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(70)	-- Kuma
	PrepareClass()	-- 
	PrepareClass()	-- 
	PrepareClass()	-- 
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort07")
end

function luaInitEscort07(this)
	Mission = this
	Mission.Name = "Escort07"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort07")
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
	
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	
	Mission.Keyunits = {}
	table.insert(Mission.Keyunits, FindEntity("Escort - LSM1"))
	table.insert(Mission.Keyunits, FindEntity("Escort - LSM2"))
	table.insert(Mission.Keyunits, FindEntity("Escort - LSM3"))
	table.insert(Mission.Keyunits, FindEntity("Escort - LSM4"))
	
	DisplayUnitHP(0,Mission.Keyunits)
	DisplayUnitHP(1,Mission.Keyunits)
	DisplayUnitHP(2,Mission.Keyunits)
	DisplayUnitHP(3,Mission.Keyunits)
	DisplayUnitHP(4,Mission.Keyunits)
	DisplayUnitHP(5,Mission.Keyunits)
	DisplayUnitHP(6,Mission.Keyunits)
	DisplayUnitHP(7,Mission.Keyunits)
	
	Mission.LSM1 = FindEntity("Escort - LSM1")
	Mission.LSM2 = FindEntity("Escort - LSM2")
	Mission.LSM3 = FindEntity("Escort - LSM3")
	Mission.LSM4 = FindEntity("Escort - LSM4")
	
	Mission.Sumner1 = FindEntity("Escort - Sumner 01")
	Mission.Sumner2 = FindEntity("Escort - Sumner 02")	
	Mission.Sumner3 = FindEntity("Escort - Sumner 03")
	
	Mission.JapTT1 = FindEntity("Escort - TT 01")
	Mission.JapTT2 = FindEntity("Escort - TT 02")
	Mission.Takao = FindEntity("Escort - Takao")
	
	Mission.Kuma1TMP = luaFindHidden("Escort - Kuma 01")
	Mission.Kuma2TMP = luaFindHidden("Escort - Kuma 02")
	
	if Mission.Players == 1 or Mission.Players == 2 or Mission.Players == 3 or Mission.Players == 4 then
		
		Mission.Kuma1 = GenerateObject(Mission.Kuma1TMP.Name)		
		SetRoleAvailable(Mission.Kuma1, EROLF_ALL, PLAYER_AI)
				
		SetShipSpeed(Mission.Kuma1, 15.43332)
		SetShipMaxSpeed(Mission.Kuma1, 15.43332)
		
	end
	
	if Mission.Players == 5 or Mission.Players == 6 or Mission.Players == 7 or Mission.Players == 8 then
	
		Mission.Kuma1 = GenerateObject(Mission.Kuma1TMP.Name)
		Mission.Kuma2 = GenerateObject(Mission.Kuma2TMP.Name)
		
		SetRoleAvailable(Mission.Kuma1, EROLF_ALL, PLAYER_AI)
		SetRoleAvailable(Mission.Kuma2, EROLF_ALL, PLAYER_AI)
		
		SetShipSpeed(Mission.Kuma1, 15.43332)
		SetShipMaxSpeed(Mission.Kuma1, 15.43332)
		
		SetShipSpeed(Mission.Kuma2, 15.43332)
		SetShipMaxSpeed(Mission.Kuma2, 15.43332)
		
	end
	
	Mission.Kuma1 = FindEntity("Escort - Kuma 01")
	Mission.Kuma2 = FindEntity("Escort - Kuma 02")
	
	Mission.Navpoint1 = FindEntity("Navpoint 01")
	Mission.Navpoint2 = FindEntity("Navpoint 02")
	Mission.Navpoint3 = FindEntity("Navpoint 03")
	Mission.Navpoint4 = FindEntity("Navpoint 04")
	
	Mission.Targets	= {}
	table.insert(Mission.Targets, FindEntity("Escort - Hangar01"))
	table.insert(Mission.Targets, FindEntity("Escort - Hangar02"))
	table.insert(Mission.Targets, FindEntity("Escort - Hangar03"))
	table.insert(Mission.Targets, FindEntity("Escort - Hangar04"))
	table.insert(Mission.Targets, FindEntity("Escort - Hangar05"))
	table.insert(Mission.Targets, FindEntity("Escort - Hangar06"))
	--table.insert(Mission.Targets, FindEntity("Escort - Hangar07"))
	--table.insert(Mission.Targets, FindEntity("Escort - Hangar08"))
	--table.insert(Mission.Targets, FindEntity("Escort - Target01"))
	--table.insert(Mission.Targets, FindEntity("Escort - Target02"))
	--table.insert(Mission.Targets, FindEntity("Escort - Target03"))
	--table.insert(Mission.Targets, FindEntity("Escort - Target04"))
	
	Mission.MissionStart = true
	Mission.MissionEnd = false	
		
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort07_think")
			
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort07_think(this, msg)
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
		luaObj_Add("primary", 1, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4],Mission.Targets[1],Mission.Targets[2],Mission.Targets[3],Mission.Targets[4],Mission.Targets[5],Mission.Targets[6]})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Keyunits[1],Mission.Keyunits[2],Mission.Keyunits[3],Mission.Keyunits[4]})
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()
		luaShowMissionHint()		
	end
	
	luaCheckKeyunits()		
	luaCheckArtilleryTargets()
			
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
	local path1 = FindEntity("epath1")
	local path2 = FindEntity("epath2")
	local path3 = FindEntity("epath3")	
	local path4 = FindEntity("epath4")
	
	local pathSumner = FindEntity("epathsumner")
	local pathTakao = FindEntity("epathtakao")
	local pathTT1 = FindEntity("epathjtt2")
	local pathTT2 = FindEntity("epathjtt1")
	
	NavigatorMoveOnPath(Mission.LSM1, path1)	
	--SetFireTarget(Mission.LSM1, Mission.Navpoint1)	
	NavigatorMoveOnPath(Mission.LSM2, path2)
	--SetFireTarget(Mission.LSM2, Mission.Navpoint2)
	NavigatorMoveOnPath(Mission.LSM3, path3)
	--SetFireTarget(Mission.LSM3, Mission.Navpoint3)
	NavigatorMoveOnPath(Mission.LSM4, path4)
	--SetFireTarget(Mission.LSM4, Mission.Navpoint4)
	
	NavigatorMoveOnPath(Mission.Sumner1, pathSumner)
	SetShipSpeed(Mission.Sumner1, 18.00554)
	
	NavigatorMoveOnPath(Mission.Takao, pathTakao)
	SetShipSpeed(Mission.Takao, 15.43332)	
	NavigatorMoveOnPath(Mission.JapTT1, pathTT1)
	SetShipSpeed(Mission.JapTT1, 10.28888)	
	NavigatorMoveOnPath(Mission.JapTT2, pathTT2)
	SetShipSpeed(Mission.JapTT2, 10.28888)	
	NavigatorAttackMove(Mission.Sumner2, Mission.Takao, {})
	
	NavigatorAttackMove(Mission.Sumner3, Mission.Takao, {})
	
	--NavigatorAttackMove(Mission.Kuma1, Mission.Sumner1, {})
	--NavigatorAttackMove(Mission.Kuma2, Mission.Sumner1, {})
	
	--[[
	
	SetShipSpeed( , )
	18.00554 - 35 knots
	15.43332 - 30 knots
	10.28888 - 20 knots
	
	--]]
	
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

function luaChecLSMDistance()
-- RELEASE_LOGOFF  	luaLog("Cheking Exit Point")
	for IDx, unit in pairs (Mission.Keyunits)do 	
		if luaGetDistance(unit, Mission.TargetPoint) < 500 then
-- RELEASE_LOGOFF  			luaLog("Calling Mission Completed")
			-- japanese wins
			luaMissionCompletedNew(Mission.Keyunit, "", nil, nil, nil, PARTY_ALLIED)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
			Mission.MissionEnd = true	
-- RELEASE_LOGOFF  			luaLog("Mission End1")
		end
	end
end

function luaCheckArtilleryTargets()
	if table.getn(luaRemoveDeadsFromTable(Mission.Targets)) == 0 then
		lastbanto = Mission.Targets[1].LastBanto
		luaMissionCompletedNew(lastbanto, "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true
	else
		luaRemoveDeadsFromTable(Mission.Targets)
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort07")
	-- mode description hint overlay
end

-- Takaoe tamadjon ki ha tuleli
-- MissionEnd ne targethez legyen kotve hanem adott pont eleresehez

-- 
--
