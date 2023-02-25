-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(16)	-- Avenger Tiny Tim
	PrepareClass(45)	-- Kamikaze Zero
	PrepareClass(17)	-- Atlanta
	PrepareClass(14)	-- Akizuki
	PrepareClass(75)	-- Akizuki
--]]
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort06")
end

function luaInitEscort06(this)
	Mission = this
	Mission.Name = "Escort06"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort06")
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
	
--	Mission.Yamato = FindEntity("Escort - Yamato")	-- Ez most nincs
	Mission.Fuso = FindEntity("Escort - Fuso")
	Mission.Kongo = FindEntity("Escort - Kongo")
	Mission.JPBB = {}
		table.insert(Mission.JPBB, Mission.Fuso)
		table.insert(Mission.JPBB, Mission.Kongo)
		
	Mission.Atlanta01temp = luaFindHidden("Escort - Atlanta 01")
	Mission.Atlanta02temp = luaFindHidden("Escort - Atlanta 02")
	
	Mission.Akizuki01temp = luaFindHidden("Escort - Akizuki 01")
	Mission.Akizuki02temp = luaFindHidden("Escort - Akizuki 02")
	Mission.Akizuki03temp = luaFindHidden("Escort - Akizuki 03")
	
	Mission.KingGeorge = FindEntity("Escort - KingGeorge")
	Mission.Renown = FindEntity("Escort - Renown")
	--Mission.Repulse = FindEntity("Escort - Repulse")
	Mission.USBB = {}
		table.insert(Mission.USBB, Mission.KingGeorge)
		table.insert(Mission.USBB, Mission.Renown)
		--table.insert(Mission.USBB, Mission.Repulse)
	
	Mission.USReinf = {}
		table.insert(Mission.USReinf, 16)	-- Avenger Tiny Tim
		
	Mission.JPReinf = {}
		table.insert(Mission.JPReinf, 45)		-- Kamikaze Zero
		
	
	Mission.Lexington = FindEntity("Escort - Lexington")
--	AISetHintWeight(Mission.Lexington, 20)
	Mission.Akagi = FindEntity("Escort - Akagi")
--	AISetHintWeight(Mission.Akagi, 20)
	
	Mission.LexingtonT = {}
		table.insert(Mission.LexingtonT, FindEntity("Escort - Lexington"))
	
	Mission.AkagiT = {}
		table.insert(Mission.AkagiT, FindEntity("Escort - Akagi"))
		
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, FindEntity("Escort - Lexington"))
		table.insert(Mission.Keyunits, FindEntity("Escort - Akagi"))		

	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CarrierDead = false
	Mission.USBBisDead = false
	Mission.JPBBisDead = false
	Mission.ReinforcementSpawned = false
	Mission.USReinfSpawned = false
	Mission.JPReinfSpawned = false
	Mission.HPShowFirstTime = true
	Mission.LexingtonTimePassed = 0
	Mission.AkagiTimePassed = 0
	Mission.JPEscort = {}
	Mission.USEscort = {}

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

--Events
	Mission.USReinfPoint = {}
		table.insert(Mission.USReinfPoint, FindEntity("Escort - US Navpoint 01"))
		table.insert(Mission.USReinfPoint, FindEntity("Escort - US Navpoint 02"))
	Mission.JPReinfPoint = {}
		table.insert(Mission.JPReinfPoint, FindEntity("Escort - JP Navpoint 01"))
		table.insert(Mission.JPReinfPoint, FindEntity("Escort - JP Navpoint 02"))
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort06_think")		
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort06_think(this, msg)
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
		luaObj_Add("primary", 1, {Mission.Keyunits[1],Mission.Keyunits[2]})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Keyunits[1],Mission.Keyunits[2]})
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()		
		luaAddAkagiListener()
		luaAddLexingtonListener()
		luaShowMissionHint()
		luaAddBBFleetListener()
		luaKeyUnitsHP(this, msg)
		luaStratDecide()
		luaDelay(luaBBDetected, 20)
	end
					
	Mission.StepCounter = Mission.StepCounter + 1 

	luaCheckReinforcement()

	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaStartKeyUnits()
	local path1 = FindEntity("EACVpath")
	local path2 = FindEntity("EJCVpath")
	local path3 = FindEntity("EABBpath3")
	local path4 = FindEntity("EABBpath2")
	local path5 = FindEntity("EABBpath1")
	local path6 = FindEntity("EJBBpath")
	local path7 = FindEntity("EACLPath1")
	local path8 = FindEntity("EACLPath2")
	
	NavigatorMoveOnPath(Mission.Lexington, path1)
	
	NavigatorMoveOnPath(Mission.Akagi, path2)
		
	NavigatorMoveOnPath(Mission.KingGeorge, path4)	
	SetShipSpeed(Mission.KingGeorge, 10.28888)
	SetShipMaxSpeed(Mission.KingGeorge, 10.28888)
	
	NavigatorMoveOnPath(Mission.Renown, path5)
	SetShipSpeed(Mission.Renown, 10.28888)
	SetShipMaxSpeed(Mission.Renown, 10.28888)
	
	--NavigatorMoveOnPath(Mission.Repulse, path3)
	--SetShipSpeed(Mission.Repulse, 10.28888)
	--SetShipMaxSpeed(Mission.Repulse, 10.28888)
	
	if Mission.Players < 5 then
		Mission.Atlanta01 = GenerateObject(Mission.Atlanta01temp.Name)
		NavigatorMoveOnPath(Mission.Atlanta01, path7)
		SetShipSpeed(Mission.Atlanta01, 10.28888)
		SetShipMaxSpeed(Mission.Atlanta01, 10.28888)
		SetRoleAvailable(Mission.Atlanta01, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.USEscort, Mission.Atlanta01)
--		SetSkillLevel(Mission.Atlanta01, SKILL_MPNORMAL)
	elseif Mission.Players > 4 then
		Mission.Atlanta01 = GenerateObject(Mission.Atlanta01temp.Name)
		NavigatorMoveOnPath(Mission.Atlanta01, path7)
		SetShipSpeed(Mission.Atlanta01, 10.28888)
		SetShipMaxSpeed(Mission.Atlanta01, 10.28888)
		SetRoleAvailable(Mission.Atlanta01, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.USEscort, Mission.Atlanta01)
--		SetSkillLevel(Mission.Atlanta02, SKILL_MPVETERAN)
		Mission.Atlanta02 = GenerateObject(Mission.Atlanta02temp.Name)
		NavigatorMoveOnPath(Mission.Atlanta02, path8)
		SetShipSpeed(Mission.Atlanta02, 10.28888)
		SetShipMaxSpeed(Mission.Atlanta02, 10.28888)
		SetRoleAvailable(Mission.Atlanta02, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.USEscort, Mission.Atlanta02)
--		SetSkillLevel(Mission.Atlanta02, SKILL_MPVETERAN)
	end
	
	local JBBs = {}	
--		table.insert(JBBs, FindEntity("Escort - Yamato"))
		table.insert(JBBs, FindEntity("Escort - Kongo"))
		table.insert(JBBs, FindEntity("Escort - Fuso"))
	if Mission.Players < 3 then
		Mission.Akizuki01 = GenerateObject(Mission.Akizuki01temp.Name)
		table.insert(JBBs, Mission.Akizuki01)
		table.insert(Mission.JPEscort, Mission.Akizuki01)
--		SetSkillLevel(Mission.Akizuki01, SKILL_MPNORMAL)
	elseif Mission.Players < 7 then
		Mission.Akizuki01 = GenerateObject(Mission.Akizuki01temp.Name)
		table.insert(JBBs, Mission.Akizuki01)
		table.insert(Mission.JPEscort, Mission.Akizuki01)
--		SetSkillLevel(Mission.Akizuki01, SKILL_MPVETERAN)
		Mission.Akizuki02 = GenerateObject(Mission.Akizuki02temp.Name)
		table.insert(JBBs, Mission.Akizuki02)
		table.insert(Mission.JPEscort, Mission.Akizuki02)
--		SetSkillLevel(Mission.Akizuki02, SKILL_MPVETERAN)
	elseif Mission.Players > 6 then
		Mission.Akizuki01 = GenerateObject(Mission.Akizuki01temp.Name)
		table.insert(JBBs, Mission.Akizuki01)
		table.insert(Mission.JPEscort, Mission.Akizuki01)
--		SetSkillLevel(Mission.Akizuki01, SKILL_ELITE)
		Mission.Akizuki02 = GenerateObject(Mission.Akizuki02temp.Name)
		table.insert(JBBs, Mission.Akizuki02)
		table.insert(Mission.JPEscort, Mission.Akizuki02)
--		SetSkillLevel(Mission.Akizuki02, SKILL_ELITE)
		Mission.Akizuki03 = GenerateObject(Mission.Akizuki03temp.Name)
		table.insert(JBBs, Mission.Akizuki03)
		table.insert(Mission.JPEscort, Mission.Akizuki03)
--		SetSkillLevel(Mission.Akizuki03, SKILL_ELITE)
	end

	for idx, unit in pairs (JBBs) do
		NavigatorMoveOnPath(unit, path6)
		SetShipSpeed(unit, 10.28888)
		SetShipMaxSpeed(unit, 10.28888)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)	
	end	
			
end

function luaAddAkagiListener()
	AddListener("kill", "Listener01", {
			["callback"] = "luaAkagiDead",
			["entity"] = Mission.AkagiT,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active1")
end

function luaAddLexingtonListener()
	AddListener("kill", "Listener02", {
			["callback"] = "luaLexingtonDead",
			["entity"] = Mission.LexingtonT,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active2")	
end

function luaLexingtonDead ()
	if not TrulyDead(Mission.Lexington) then
		luaMissionCompletedNew(Mission.Lexington, "", nil, nil, nil, PARTY_JAPANESE)
	else
		luaMissionCompletedNew(Mission.Lexington.LastBanto, "", nil, nil, nil, PARTY_JAPANESE)
	end
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 2)
	luaObj_Failed("primary", 1)
	Mission.MissionEnd = true
	
	Mission.LexingtonHPPercent = 0
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.LexingtonHPPercent
			MultiScore[i][2] = Mission.AkagiHPPercent
		end
	end
		
end

function luaAkagiDead ()
	if not TrulyDead(Mission.Akagi) then
		luaMissionCompletedNew(Mission.Akagi, "", nil, nil, nil, PARTY_ALLIED)
	else
		luaMissionCompletedNew(Mission.Akagi.LastBanto, "", nil, nil, nil, PARTY_ALLIED)
	end
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 1)
	luaObj_Failed("primary", 2)
	Mission.MissionEnd = true
	
	Mission.AkagiHPPercent = 0
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.LexingtonHPPercent
			MultiScore[i][2] = Mission.AkagiHPPercent
		end
	end
	
end

function luaAddBBFleetListener()

	AddListener("kill", "USBB", {
			["callback"] = "luaBBDead",
			["entity"] = Mission.USBB,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})

	AddListener("kill", "JPBB", {
			["callback"] = "luaBBDead",
			["entity"] = Mission.JPBB,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})

end

function luaBBDead()

-- RELEASE_LOGOFF  	luaLog("BB died!")
	Mission.USBB = luaRemoveDeadsFromTable(Mission.USBB)
	Mission.JPBB = luaRemoveDeadsFromTable(Mission.JPBB)
	Mission.USEscort = luaRemoveDeadsFromTable(Mission.USEscort)
	Mission.JPEscort = luaRemoveDeadsFromTable(Mission.JPEscort)

	if luaCountTable(Mission.USBB) == 0 then
		Mission.USBBisDead = true
-- RELEASE_LOGOFF  		luaLog("All US BB Died!")
		if luaCountTable(Mission.JPBB) ~= 0 then
			for idx, unit in pairs(Mission.JPBB) do
				NavigatorAttackMove(unit, Mission.Lexington, {})
				AISetHintWeight(unit, 10)
			end
-- RELEASE_LOGOFF  			luaLog("JPBBs Goes for US Carrier!")
		end
		if luaCountTable(Mission.JPEscort) ~= 0 then
			for idx, unit in pairs(Mission.JPEscort) do
				NavigatorAttackMove(unit, Mission.Lexington, {})
				AISetHintWeight(unit, 5)
			end
-- RELEASE_LOGOFF  			luaLog("JPEscort Goes for US Carrier!")
		end
		if Mission.JPBBisDead ~= true then
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp06.nar_es_jp_bb_inc")
			end
		end
	end
	
	if luaCountTable(Mission.JPBB) == 0 then
		Mission.JPBBisDead = true
-- RELEASE_LOGOFF  		luaLog("All JP BB Died!")
		if luaCountTable(Mission.USBB) ~= 0 then
			for idx, unit in pairs(Mission.USBB) do
				NavigatorAttackMove(unit, Mission.Akagi, {})
				AISetHintWeight(unit, 10)
			end
-- RELEASE_LOGOFF  			luaLog("USBBs Goes for IJN Carrier!")
		end
		if luaCountTable(Mission.USEscort) ~= 0 then
			for idx, unit in pairs(Mission.USEscort) do
				NavigatorAttackMove(unit, Mission.Akagi, {})
				AISetHintWeight(unit, 5)
			end
-- RELEASE_LOGOFF  			luaLog("USEscort Goes for IJN Carrier!")
		end
		if Mission.USBBisDead ~= true then
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp06.nar_es_us_bb_inc")
			end
		end
	end

end

function luaSpawnReinforcement()

	if Mission.MissionEnd == true then
		return
	end

-- RELEASE_LOGOFF  	luaLog("Spawning Reinforcement!")

	Mission.UnitSpawn = nil

	if Mission.USBBisDead == true and not Mission.JPReinfSpawned then
		Mission.UnitSpawn = luaPickRnd(Mission.JPReinf)
		Mission.Navpoint = luaPickRnd(Mission.JPReinfPoint)
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
					{
						["Type"] = Mission.UnitSpawn,
						["Name"] = VehicleClass[Mission.UnitSpawn].ShortName,
						["Skill"] = SKILL_MPNORMAL,
						["Race"] = Japan,
						["WingCount"] = 3,
						["Equipment"] = 2,
					},
				},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 200,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["area"] = {
				["refPos"] = GetPosition(Mission.Navpoint),
				["angleRange"] = { DEG(-10),DEG(10)},
				["lookAt"] = GetPosition(Mission.Lexington)
			},
			["callback"] = "luaJPReinforcementSpawned",
		})		
-- RELEASE_LOGOFF  		luaLog("US Side need reinforcement!")
	end
	if Mission.JPBBisDead == true and not Mission.USReinfSpawned then
		Mission.UnitSpawn = luaPickRnd(Mission.USReinf)
		Mission.Navpoint = luaPickRnd(Mission.USReinfPoint)
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
					{
						["Type"] = Mission.UnitSpawn,
						["Name"] = VehicleClass[Mission.UnitSpawn].ShortName,
						["Skill"] = SKILL_MPNORMAL,
						["Race"] = USA,
						["WingCount"] = 3,
						["Equipment"] = 1,
					},
				},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 200,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["area"] = {
				["refPos"] = GetPosition(Mission.Navpoint),
				["angleRange"] = { DEG(-10),DEG(10)},
				["lookAt"] = GetPosition(Mission.Akagi)
			},
			["callback"] = "luaUSReinforcementSpawned",
		})		
-- RELEASE_LOGOFF  		luaLog("JP Side need reinforcement!")
	end

-- RELEASE_LOGOFF  	luaLog("Spawn Set!")

end

function luaUSReinforcementSpawned(unit)

-- RELEASE_LOGOFF  	luaLog("US Reinforcement Spawned!")
	AISetHintWeight(unit, 10)
	PilotSetTarget(unit, Mission.Akagi)
	EntityTurnToEntity(unit, Mission.Akagi)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)

	if Mission.USReinfSpawned == false then
		for i = 0, 7 do
			MissionNarrativePlayer(i, "mp.nar_us_reinf_arrived")
		end
		Mission.USReinfSpawned = true
	end

end

function luaJPReinforcementSpawned(unit)

-- RELEASE_LOGOFF  	luaLog("JP Reinforcement Spawned!")
	AISetHintWeight(unit, 10)
	PilotSetTarget(unit, Mission.Lexington)
	EntityTurnToEntity(unit, Mission.Lexington)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)

	if Mission.JPReinfSpawned == false then
		for i = 0, 7 do
			MissionNarrativePlayer(i, "mp.nar_jp_reinf_arrived")
		end
		Mission.JPReinfSpawned = true
	end

end

function luaCheckReinforcement()
	if Mission.USBBisDead == true or Mission.JPBBisDead == true then
		local trg = luaRound(Mission.Players / 2)
-- RELEASE_LOGOFF  			luaLog(trg)
		for i = 1, trg do
			luaDelay(luaSpawnReinforcement, 30)
--				luaDelay(luaReinforcementIncoming, 15)
			i = i + 1
		end
	end
end

function luaKeyUnitsHP(this, msg)

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.MissionEnd == true then
		return
	end

	if Mission.HPShowFirstTime == true then
		Mission.LexingtonHPPercent = 100
		Mission.AkagiHPPercent = 100

		MultiScore=	{
			[0]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[1]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[2]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[3]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[4]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[5]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[6]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
			[7]= {
				[1] = Mission.LexingtonHPPercent,
				[2] = Mission.AkagiHPPercent,
			},
		}
		
		DisplayScores(1, 0,"mp06.score_es_us_cv_hp|".." #MultiScore.0.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.0.2# %",2,1)
		DisplayScores(1, 1,"mp06.score_es_us_cv_hp|".." #MultiScore.1.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.1.2# %",2,1)
		DisplayScores(1, 2,"mp06.score_es_us_cv_hp|".." #MultiScore.2.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.2.2# %",2,1)
		DisplayScores(1, 3,"mp06.score_es_us_cv_hp|".." #MultiScore.3.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.3.2# %",2,1)
		DisplayScores(1, 4,"mp06.score_es_us_cv_hp|".." #MultiScore.4.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.4.2# %",2,1)
		DisplayScores(1, 5,"mp06.score_es_us_cv_hp|".." #MultiScore.5.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.5.2# %",2,1)
		DisplayScores(1, 6,"mp06.score_es_us_cv_hp|".." #MultiScore.6.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.6.2# %",2,1)
		DisplayScores(1, 7,"mp06.score_es_us_cv_hp|".." #MultiScore.7.1# %","mp06.score_es_jp_cv_hp|".." #MultiScore.7.2# %",2,1)
	end
	
	if not Mission.Lexington.Dead then
			Mission.LexingtonHPPercent = luaRound(GetHpPercentage(Mission.Lexington)*100)
			Mission.LexingtonTimePassed = Mission.LexingtonTimePassed + 1/3
			if Mission.LexingtonHPPercent < 25 and Mission.LexingtonTimePassed > 20 then
				Mission.LexingtonTimePassed = 0
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp06.nar_es_uscv_lowhp")
				end
			end
	else
			Mission.LexingtonHPPercent = 0
	end
	
	if not Mission.Akagi.Dead then
			Mission.AkagiHPPercent = luaRound(GetHpPercentage(Mission.Akagi)*100)
			Mission.AkagiTimePassed = Mission.AkagiTimePassed + 1/3
			if Mission.AkagiHPPercent < 25 and Mission.AkagiTimePassed > 20 then
				Mission.AkagiTimePassed = 0
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp06.nar_es_jpcv_lowhp")
				end
			end
	else
			Mission.AkagiHPPercent = 0
	end
	
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.LexingtonHPPercent
			MultiScore[i][2] = Mission.AkagiHPPercent
		end
	end
	
	luaDelay(luaKeyUnitsHP, 1)

end

function luaStratDecide()

	local strat = luaRnd(1,4)
	if strat == 1 then
		AISetHintWeight(Mission.Lexington, 50)
		AISetHintWeight(Mission.Akagi, 50)
-- RELEASE_LOGOFF  		luaLog("----- AI STRAT DECISION -----")
-- RELEASE_LOGOFF  		luaLog("AI Decided to kill CVs!")
	elseif strat == 2 then
		for idx, unit in pairs (Mission.JPBB) do
			AISetHintWeight(unit, 50)
		end
		for idx, unit in pairs (Mission.JPEscort) do
			AISetHintWeight(unit, 50)
		end		
		for idx, unit in pairs (Mission.USBB) do
			AISetHintWeight(unit, 50)
		end
		for idx, unit in pairs (Mission.USEscort) do
			AISetHintWeight(unit, 50)
		end
-- RELEASE_LOGOFF  		luaLog("----- AI STRAT DECISION -----")
-- RELEASE_LOGOFF  		luaLog("AI Decided to kill BBs!")
	elseif strat == 3 then
		AISetHintWeight(Mission.Akagi, 50)
		for idx, unit in pairs (Mission.USBB) do
			AISetHintWeight(unit, 50)
		end		
-- RELEASE_LOGOFF  		luaLog("----- AI STRAT DECISION -----")
-- RELEASE_LOGOFF  		luaLog("US AI Decided to kill CVs, JP goes for BBs!")
	elseif strat == 4 then
		AISetHintWeight(Mission.Lexington, 50)
		for idx, unit in pairs (Mission.JPBB) do
			AISetHintWeight(unit, 50)
		end
-- RELEASE_LOGOFF  		luaLog("----- AI STRAT DECISION -----")
-- RELEASE_LOGOFF  		luaLog("JP AI Decided to kill CVs, US goes for BBs!")
	end

end

function luaBBDetected()

	for i = 0, 7 do
		MissionNarrativePlayer(i, "mp.nar_fleet_det")
	end

end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort06")
	-- mode description hint overlay
end