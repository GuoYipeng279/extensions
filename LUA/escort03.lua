-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(117)	-- B29
	PrepareClass(183)	-- Kikka
	PrepareClass(13)	-- New York
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort03")
end

function luaInitEscort03(this)
	Mission = this
	Mission.Name = "Escort03"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort03")
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
				["Text"] = "mp.obj_es_des",
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
				["Text"] = "mp.obj_es_def",
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
	
	Mission.Betty1TMP = luaFindHidden("Escort Betty 01")
	Mission.Betty2TMP = luaFindHidden("Escort Betty 02")
	Mission.Betty3TMP = luaFindHidden("Escort Betty 03")
	Mission.Betty4TMP = luaFindHidden("Escort Betty 04")
	
	Mission.Keyunit = FindEntity("Escort - Yamato")
	
	Mission.Keyunits = {}
	table.insert(Mission.Keyunits,  FindEntity("Escort - Yamato"))
	
	--Mission.DD1 = FindEntity("Escort Akizuki-class 01")
	--Mission.DD2 = FindEntity("Escort Akizuki-class 02")
	
	Mission.DD1 = FindEntity("Escort Akizuki-class 01")
	Mission.DD2 = FindEntity("Escort Akizuki-class 02")
	
	--[[
	Mission.KamikazePlanes = {}
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 01"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 02"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 03"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 04"))
	--]]
	
	Mission.Cleveland = FindEntity("Escort Cleveland")
	
	if Mission.Players == 1 or Mission.Players == 2 then

	Mission.Betty1 = GenerateObject(Mission.Betty1TMP.Name)
	SetRoleAvailable(Mission.Betty1, EROLF_ALL, PLAYER_AI)
	Mission.Betty2 = GenerateObject(Mission.Betty2TMP.Name)
	SetRoleAvailable(Mission.Betty2, EROLF_ALL, PLAYER_AI)
		
	Mission.KamikazePlanes = {}
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 01"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 02"))
	
	for idx, unit in pairs(Mission.KamikazePlanes) do				
		PilotSetTarget(unit, Mission.Cleveland)		
	end
			
	else
	
	Mission.Betty1 = GenerateObject(Mission.Betty1TMP.Name)
	SetRoleAvailable(Mission.Betty1, EROLF_ALL, PLAYER_AI)
	Mission.Betty2 = GenerateObject(Mission.Betty2TMP.Name)
	SetRoleAvailable(Mission.Betty2, EROLF_ALL, PLAYER_AI)
	Mission.Betty3 = GenerateObject(Mission.Betty3TMP.Name)
	SetRoleAvailable(Mission.Betty3, EROLF_ALL, PLAYER_AI)
	Mission.Betty4 = GenerateObject(Mission.Betty4TMP.Name)
	SetRoleAvailable(Mission.Betty4, EROLF_ALL, PLAYER_AI)
	
	Mission.KamikazePlanes = {}
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 01"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 02"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 03"))
	table.insert(Mission.KamikazePlanes,  FindEntity("Escort Betty 04"))
	
	for idx, unit in pairs(Mission.KamikazePlanes) do				
		PilotSetTarget(unit, Mission.Cleveland)		
	end
	
	end	
	
	Mission.NewYorkTMP = luaFindHidden("Escort NewYork")
	
	DisplayUnitHP(0,Mission.Keyunits)
	DisplayUnitHP(1,Mission.Keyunits)
	DisplayUnitHP(2,Mission.Keyunits)
	DisplayUnitHP(3,Mission.Keyunits)
	DisplayUnitHP(4,Mission.Keyunits)
	DisplayUnitHP(5,Mission.Keyunits)
	DisplayUnitHP(6,Mission.Keyunits)
	DisplayUnitHP(7,Mission.Keyunits)
	
	
	Mission.TargetPoint = {}
		Mission.TargetPoint.x = 3533
		Mission.TargetPoint.y = 0
		Mission.TargetPoint.z = 4577
	
	Mission.SpawnPoint1 = FindEntity("Escort - SpawnPoint 01")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint1: "..tostring(FindEntity("Escort - SpawnPoint1")))
	
	Mission.SpawnPoint2 = FindEntity("Escort - SpawnPoint 02")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint2")))

	--Allied
	Mission.EventSpawnCoord1 = FindEntity("Escort - EventSpawnCoord 01")
	Mission.EventSpawnCoord2 = FindEntity("Escort - EventSpawnCoord 02")
	Mission.EventSpawnCoord3 = FindEntity("Escort - EventSpawnCoord 03")
	
	Mission.Event1Units = {}
	Mission.Event2Units = {}
	Mission.Event3Units = {}
	
	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CarrierDead = false	
	--Events
	Mission.FirstEvent = 10
	Mission.SecondEvent = 60
	Mission.ThirdEvent = 100
	Mission.FourthEvent = 130
	Mission.FifthEvent = 150
	Mission.SixthEvent = 175
	Mission.SeventhEvent = 200
	Mission.EighthEvent = 225
	Mission.NinthEvent = 250
	Mission.TenthEvent = 275
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort03_think")
	
	--AddWatch("Mission.MusicLevel")
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort03_think(this, msg)
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
		luaObj_Add("primary", 1, {Mission.Keyunit})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Keyunit, Mission.TargetPoint})
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()
		luaShowMissionHint()
	end
	
	luaCheckKeyunits()
	luaCheckExitPoint()
	luaEvents()
	--luaSetKikkaTarget()
	luaCheckCleveland()
	luaRemoveKamikazePlanes()
	
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
	local path1 = FindEntity("Escort - Path")
	local path2 = FindEntity("Escort - Path 01")	
	local path3 = FindEntity("Escort - Path 02")	
		for idx, unit in pairs (Mission.Keyunits) do			
			NavigatorMoveOnPath(unit, path1)
			--SetShipMaxSpeed(unit, 12.8611)
			SetShipSpeed(unit, 12.8611)
		end
	NavigatorMoveOnPath(Mission.DD1, path2)
	--SetShipMaxSpeed(unit, 12.8611)
	--SetShipSpeed(Mission.DD1, 12.8611)
	NavigatorMoveOnPath(Mission.DD2, path3)
	--SetShipMaxSpeed(unit, 12.8611)
	--SetShipSpeed(Mission.DD2, 12.8611)
end

function luaCheckKeyunits()
	if table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) == 0 then
		lastbanto = Mission.Keyunits[1].LastBanto
		luaMissionCompletedNew(lastbanto, "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true
	else
		luaRemoveDeadsFromTable(Mission.Keyunits)
	end
end

function luaCheckExitPoint()
-- RELEASE_LOGOFF  	luaLog("Cheking Exit Point")
	Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
	for IDx, unit in pairs (Mission.Keyunits) do
		if luaGetDistance(unit, Mission.TargetPoint ) < 200 then
			luaMissionCompletedNew(unit, "", nil, nil, nil, PARTY_JAPANESE)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)
			Mission.MissionEnd = true	
-- RELEASE_LOGOFF  			luaLog("Mission End1")
-- RELEASE_LOGOFF  			luaLog("Calling Mission Completed")
			-- allied wins
		end
	end
end

function luaGetParty(unit)
	if unit.Party == PARTY_ALLIED then
		return PARTY_ALLIED
	elseif unit.Party == PARTY_JAPANESE then
		return PARTY_JAPANESE
	else
		return PARTY_NEUTRAL
	end
end

function luaGetPlayers()
	local MPlayers = Multi_GetPlayers()
-- RELEASE_LOGOFF  	luaLog("Multi player dump")
	for IDx, player in pairs (MPlayers) do
-- RELEASE_LOGOFF  			luaLog("Index: "..IDx..", "..tostring(player))
	end
end

function luaEventSpawn1()
--US
	local SpawnCoord = GetPosition(Mission.EventSpawnCoord1)
	
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 117,
			["Name"] = "B-29 Superfortress",
			["Crew"] = 2,
			["WingCount"] = 3,
			["Race"] = USA,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-120),DEG(-30)},
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
-- RELEASE_LOGOFF  	luaLog("B29 spawn done")
end

function luaEventSpawn1Callback(unit1, unit2)
	
	Mission.Event1Units = {}
	table.insert(Mission.Event1Units, unit1)
	--table.insert(Mission.Event1Units, unit2)
	
	--local pos = GetPosition(Mission.Keyunits[1])
	for idx,unit in pairs (Mission.Event1Units) do
		PilotSetTarget(unit, Mission.Keyunit)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		AISetHintWeight(unit, 4, 200)		
	end
-- RELEASE_LOGOFF  	luaLog("spawn1 callback done")
	MissionNarrativeClear()
	MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
	MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")
	
end

function luaEventSpawn2()
--US
	local SpawnCoord = GetPosition(Mission.EventSpawnCoord2)
	
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 117,
			["Name"] = "B-29 Superfortress",
			["Crew"] = 2,
			["WingCount"] = 3,
			["Race"] = USA,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-120),DEG(-30)},
	},
	["callback"] = "luaEventSpawn2Callback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 15,
		["enemyHorizontal"] = 15,
		["ownVertical"] = 15,
		["enemyVertical"] = 15,
		["formationHorizontal"] = 100,
	},
	})
-- RELEASE_LOGOFF  	luaLog("B29 spawn done")
end

function luaEventSpawn2Callback(unit1, unit2)
	
	Mission.Event2Units = {}
	table.insert(Mission.Event2Units, unit1)
	--table.insert(Mission.Event2Units, unit2)		
	
	--local pos = GetPosition(Mission.Keyunits[1])
	for idx,unit in pairs (Mission.Event2Units) do
		PilotSetTarget(unit, Mission.Keyunit)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
		AISetHintWeight(unit, 4, 200)
	end
-- RELEASE_LOGOFF  	luaLog("spawn1 callback done")
	MissionNarrativeClear()
	MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
	MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")
	
end

--[[
	Mission.FirstEvent = 10
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

-- random segitseg
function luaEvents()
	if not Mission.Keyunit.Dead then
		if Mission.StepCounter == Mission.FirstEvent then
			luaRandomSpawn()		
		elseif
			Mission.StepCounter == Mission.SecondEvent then
			luaRandomSpawn()		
		elseif
			Mission.StepCounter == Mission.ThirdEvent then
			luaRandomSpawn()
		elseif
			Mission.StepCounter == Mission.FourthEvent then
			luaRandomSpawn()
			luaJapaneseSpawn()
		elseif
			Mission.StepCounter == Mission.FifthEvent then
			luaRandomSpawn()		
		elseif
			Mission.StepCounter == Mission.SixthEvent then
			luaRandomSpawn()	
		elseif
			Mission.StepCounter == Mission.SeventhEvent then
			luaRandomSpawn()	
			luaJapaneseSpawn()	
		elseif
			Mission.StepCounter == Mission.EighthEvent then
			luaRandomSpawn()
			
		elseif
			Mission.StepCounter == Mission.NinthEvent then
			luaRandomSpawn()
			luaJapaneseSpawn()
		elseif
			Mission.StepCounter == Mission.TenthEvent then
			luaRandomSpawn()
			luaJapaneseSpawn()
		end
	end
end

function luaRandomSpawn()
	local number = luaRnd(1,2)
	if number == 1 then
		luaEventSpawn1()
	else
		luaEventSpawn2()
	end
end

function luaJapaneseSpawn()
	--Japanese
	local SpawnCoord = GetPosition(Mission.EventSpawnCoord3)
	
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 183,
			["Name"] = "Ki-205 Kikka",
			["Crew"] = 2,
			["WingCount"] = 3,
			["Race"] = USA,
			["Equipment"] = 2,
		},
		{
			["Type"] = 183,
			["Name"] = "Ki-205 Kikka",
			["Crew"] = 2,
			["WingCount"] = 3,
			["Race"] = USA,
			["Equipment"] = 2,
		},
	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-120),DEG(-30)},
	},
	["callback"] = "luaEventSpawn3Callback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 15,
		["enemyHorizontal"] = 15,
		["ownVertical"] = 15,
		["enemyVertical"] = 15,
		["formationHorizontal"] = 100,
	},
	})
-- RELEASE_LOGOFF  	luaLog("B29 spawn done")
end

function luaEventSpawn3Callback(unit1, unit2)	
	--UnitFreeFire(unit1)
	PilotMoveToRange (unit1, Mission.Keyunits[1])
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)						
	UnitSetFireStance(unit1, 2)
	
	PilotMoveToRange (unit2, Mission.Keyunits[1])
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)						
	UnitSetFireStance(unit2, 2)
	
-- RELEASE_LOGOFF  	luaLog("spawn1 callback done")
	MissionNarrativeClear()
	MissionNarrativeParty(0, "mp.nar_jp_reinf_arrived")
	MissionNarrativeParty(1, "mp.nar_jp_reinf_arrived")
	
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort03")
	-- mode description hint overlay
end

function luaCheckCleveland()
	if not Mission.Cleveland.Dead then
		--luaAlliedReiforcement()
		if Mission.StepCounter == 75 then
			Mission.NewYork = GenerateObject(Mission.NewYorkTMP.Name)
			SetRoleAvailable(Mission.NewYork, EROLF_ALL, PLAYER_AI)
			NavigatorAttackMove(Mission.NewYork, Mission.Keyunit, {})
			MissionNarrativeClear()
			MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
			MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
		end
	end
end

function luaRemoveKamikazePlanes()
	
	Mission.KamikazePlanes = luaRemoveDeadsFromTable(Mission.KamikazePlanes)

	if luaCountTable(Mission.KamikazePlanes) ~= 0 then
		for idx, unit in pairs(Mission.KamikazePlanes) do				
			if GetPayload(unit, 1) == nil then
				PilotRetreat(unit)
			end
		end
	end
	
end