-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(67)	-- Mogami
	PrepareClass(73)	-- Fubuki
	PrepareClass(118)	-- B-25
	PrepareClass(102)	-- Corsair	
	PrepareClass(100)	-- KamikazeOscar
	PrepareClass(151)	-- Raiden	
	PrepareClass(16)	-- TBM-3 Avenger
	PrepareClass(27)	-- Elco PT
	PrepareClass(23)	-- Fletcher
	PrepareClass(14)	-- Akizuki
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort01")
end

function luaInitEscort01(this)
	Mission = this
	Mission.Name = "Escort01"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort01")
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
				--["Text"] = "Escort the USS Lexington!",
				["Text"] = "mp.obj_es_def",
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "mp.obj_ic_uswon",
				--["TextFailed"] = "The USS Lexington has been destoryed",
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
				--["Text"] = "Destroy the USS Lexington at all costs!",
				["Text"] = "mp.obj_es_des",
				--["TextCompleted"] = "The enemy Carrier has been destoryed",
				["TextCompleted"] = "mp.obj_ic_jpwon",
				--["TextFailed"] = "Our forces have been neutralized",
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
	-- toltes gyorsitas
	
	
		
	
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")
	
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	
	Mission.Keyunit = FindEntity("Escort - Lexington 02")
	NavigatorSetTorpedoEvasion(Mission.Keyunit, false)
	
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, FindEntity("Escort - Lexington 02"))
		
	DisplayUnitHP(0,Mission.Keyunits)
	DisplayUnitHP(1,Mission.Keyunits)
	DisplayUnitHP(2,Mission.Keyunits)
	DisplayUnitHP(3,Mission.Keyunits)
	DisplayUnitHP(4,Mission.Keyunits)
	DisplayUnitHP(5,Mission.Keyunits)
	DisplayUnitHP(6,Mission.Keyunits)
	DisplayUnitHP(7,Mission.Keyunits)
	
	Mission.PlanesRemoved = false
	
	Mission.Destroyer1TMP = luaFindHidden("Escort - Fletcher 01")	
 	Mission.Destroyer2TMP = luaFindHidden("Escort - Fletcher 02")
 	Mission.Destroyer3TMP = luaFindHidden("Escort - Fletcher 03")
	Mission.Destroyer4TMP = luaFindHidden("Escort - Fletcher 04")	
	
	Mission.AkizukiTMP = luaFindHidden("Escort - Akizuki")
	Mission.MogamiTMP = luaFindHidden("Escort - Mogami")			
	
	if Mission.Players == 1 or Mission.Players == 2 then
	--[[	
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)	
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)		
		-]]
		Mission.DefDDs = {}
			--table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			--table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))					
		
	elseif Mission.Players == 3 then
		
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)		
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))
		
	elseif Mission.Players == 4 then
		
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.Destroyer3 = GenerateObject(Mission.Destroyer3TMP.Name)
		SetRoleAvailable(Mission.Destroyer3, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep4")	
		NavigatorMoveOnPath(Mission.Destroyer3, path)	
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))

		
	elseif Mission.Players == 5 then
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.Destroyer3 = GenerateObject(Mission.Destroyer3TMP.Name)
		SetRoleAvailable(Mission.Destroyer3, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep4")	
		NavigatorMoveOnPath(Mission.Destroyer3, path)	
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))
			
		
	elseif Mission.Players == 6 then
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")
		NavigatorMoveOnPath(Mission.Destroyer2, path)
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.Destroyer3 = GenerateObject(Mission.Destroyer3TMP.Name)
		SetRoleAvailable(Mission.Destroyer3, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep4")
		NavigatorMoveOnPath(Mission.Destroyer3, path)
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))

		
	elseif Mission.Players == 7 then
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		--JoinFormation(Mission.Destroyer1, Mission.Keyunit)
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.Destroyer3 = GenerateObject(Mission.Destroyer3TMP.Name)
		SetRoleAvailable(Mission.Destroyer3, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep4")	
		NavigatorMoveOnPath(Mission.Destroyer3, path)	
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
				
		Mission.Destroyer4 = GenerateObject(Mission.Destroyer4TMP.Name)
		SetRoleAvailable(Mission.Destroyer4, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep5")	
		NavigatorMoveOnPath(Mission.Destroyer4, path)	
		SetShipSpeed(Mission.Destroyer4, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer4, 10.28888)
		--JoinFormation(Mission.Destroyer4, Mission.Keyunit)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))
		
	elseif Mission.Players == 8 then
		Mission.Destroyer1 = GenerateObject(Mission.Destroyer1TMP.Name)
		SetRoleAvailable(Mission.Destroyer1, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep1")	
		NavigatorMoveOnPath(Mission.Destroyer1, path)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
		
		Mission.Destroyer2 = GenerateObject(Mission.Destroyer2TMP.Name)
		SetRoleAvailable(Mission.Destroyer2, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep2")	
		NavigatorMoveOnPath(Mission.Destroyer2, path)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
		
		Mission.Destroyer3 = GenerateObject(Mission.Destroyer3TMP.Name)
		SetRoleAvailable(Mission.Destroyer3, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep4")	
		NavigatorMoveOnPath(Mission.Destroyer3, path)	
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)		
				
		Mission.Destroyer4 = GenerateObject(Mission.Destroyer4TMP.Name)
		SetRoleAvailable(Mission.Destroyer4, EROLF_ALL, PLAYER_AI)
		local path = FindEntity("ep5")	
		NavigatorMoveOnPath(Mission.Destroyer4, path)	
		SetShipSpeed(Mission.Destroyer4, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer4, 10.28888)
		
		Mission.DefDDs = {}
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 01"))
			table.insert(Mission.DefDDs, FindEntity("Escort - Fletcher 02"))					
		
	end		
	
	Mission.TargetPoint = {}
		Mission.TargetPoint.x = 11973
		Mission.TargetPoint.y = 0
		Mission.TargetPoint.z = 14843
		
	--Allied
	Mission.SpawnPoint1 = FindEntity("Escort - SpawnPoint 1")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint1: "..tostring(FindEntity("Escort - SpawnPoint 1")))
	
	--Japanese
	Mission.SpawnPoint2 = FindEntity("Escort - SpawnPoint 2")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint 2")))
	
	Mission.SpawnPoint3 = FindEntity("Escort - SpawnPoint 3")
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint 3")))
	
	Mission.EventPoint1 = {}
		Mission.EventPoint1.x = 7000
		Mission.EventPoint1.y = 150
		Mission.EventPoint1.z = 1700
	

	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CarrierDead = false	
	Mission.MogamiDead = false
	Mission.AkizukiDead = false
	
	--Events
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort01_think")
	
	--AddWatch("Mission.MusicLevel")
	
-- RELEASE_LOGOFF  	AddWatch("Mission.StepCounter")
	
	--ModifyKeyUnitNumber

	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort01_think(this, msg)
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
		luaAddListeners()
		luaShowMissionHint()		
		--Countdown(guiName, startLevel, countdownTime[, callback[, params]])		
		--Countdown("mp.nar_jp_reinf_arrives", 0, 180)
	end
	
	luaCheckExitPoint()
		
	Mission.StepCounter = Mission.StepCounter+1 
	
	luaEventSpawn1()
	luaEventSpawn2()
	luaRemovePlanes()
	
-- objective giving
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaCheckExitPoint()
-- RELEASE_LOGOFF  	luaLog("Cheking Exit Point")
	if not Mission.CarrierDead == true and luaGetDistance(Mission.Keyunit, Mission.TargetPoint) < 500 then
-- RELEASE_LOGOFF  		luaLog("Calling Mission Completed")
		-- japanese wins
		luaMissionCompletedNew(Mission.Keyunit, "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true	
-- RELEASE_LOGOFF  		luaLog("Mission End1")
	end
end

function luaStartMissionEnd1()
-- RELEASE_LOGOFF  	luaLog("Start MissionEnd1")
	Mission.CarrierDead = true
-- RELEASE_LOGOFF  	luaLog("Carrier dead")
	-- allied wins
-- RELEASE_LOGOFF  	luaLog("Mission End2")
	if not TrulyDead(Mission.Keyunit) then
		luaMissionCompletedNew(Mission.Keyunit, "", nil, nil, nil, PARTY_JAPANESE)
	else
		luaMissionCompletedNew(Mission.Keyunit.LastBanto, "", nil, nil, nil, PARTY_JAPANESE)
	end
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 2)
	luaObj_Failed("primary", 1)
	Mission.MissionEnd = true	
end

function luaEventSpawn1()	
	if Mission.Players == 1 or Mission.Players == 2 or Mission.Players == 3 then
		if Mission.StepCounter == 40 then
			Mission.EventSpawn1 = true
			Mission.Akizuki = GenerateObject(Mission.AkizukiTMP.Name)
			Mission.JapaneseDestroyer = {}
			table.insert(Mission.JapaneseDestroyer, FindEntity("Escort - Akizuki"))
			luaAddAkizukiListener()
			NavigatorAttackMove(Mission.Akizuki, Mission.Keyunit, {})
			TorpedoEnable(Mission.Akizuki, true)
			
			Mission.Attackers = {}
				table.insert(Mission.Attackers, FindEntity("Escort - Akizuki"))
			
			MissionNarrativeClear()
			MissionNarrativeParty(0, "mp.nar_jp_reinf_arrived")		
			MissionNarrativeParty(1, "mp.nar_jp_reinf_arrived")
-- RELEASE_LOGOFF  			luaLog("Japanese Force spawned")
			luaDelay(luaSetDef(), 40)
--			CountdownCancel()
--			Countdown("mp.nar_us_reinf_arrives", 0, 150)
		end
	elseif Mission.Players == 4 or Mission.Players == 5 or Mission.Players == 6 or Mission.Players == 7 or Mission.Players == 8 then
		if Mission.StepCounter == 40 then
			Mission.EventSpawn1 = true
			Mission.Mogami = GenerateObject(Mission.MogamiTMP.Name)
			Mission.JapaneseCruiser = {}
			table.insert(Mission.JapaneseCruiser, FindEntity("Escort - Mogami"))
			luaAddMogamiListener()
			Mission.Akizuki = GenerateObject(Mission.AkizukiTMP.Name)
			Mission.JapaneseDestroyer = {}
			table.insert(Mission.JapaneseDestroyer, FindEntity("Escort - Akizuki"))
			luaAddAkizukiListener()
			JoinFormation(Mission.Akizuki, Mission.Mogami)
			NavigatorAttackMove(Mission.Mogami, Mission.Keyunit, {})
			
			Mission.Attackers = {}
				table.insert(Mission.Attackers, FindEntity("Escort - Akizuki"))
				table.insert(Mission.Attackers, FindEntity("Escort - Mogami"))
				
			MissionNarrativeClear()
			MissionNarrativeParty(0, "mp.nar_jp_reinf_arrived")
			MissionNarrativeParty(1, "mp.nar_jp_reinf_arrived")
-- RELEASE_LOGOFF  			luaLog("Japanese Force spawned")
			luaDelay(luaSetDef(), 45)
--			CountdownCancel()
--			Countdown("mp.nar_us_reinf_arrives", 0, 120)
		end
	end	
end

function luaEventSpawn2()  	
	if Mission.EventSpawn1 == true and Mission.StepCounter == 80 then								 		 		
  	if Mission.Players == 1 or Mission.Players == 2 or Mission.Players == 3 then
	  	local SpawnCoord = Mission.EventPoint1		
			SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 16,
					["Name"] = "TBM-3 Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = 16,
					["Name"] = "TBM-3 Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaEventSpawn2BCallback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
			
			MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
			MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")
			
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
  	else
			--US
			local SpawnCoord = Mission.EventPoint1		
			SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 118,
					["Name"] = "B-25 Mitchell",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 2,
				},
				{
					["Type"] = 118,
					["Name"] = "B-25 Mitchell",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 2,
				},
				{
					["Type"] = 16,
					["Name"] = "TBM-3 Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = 16,
					["Name"] = "TBM-3 Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaEventSpawn2Callback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
			
			MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
			MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")
			
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
		end
	end
end

function luaEventSpawn2Callback(unit1, unit2, unit3, unit4)
  local EventAUnits = {}
	table.insert(EventAUnits, unit1)
	table.insert(EventAUnits, unit2)
	table.insert(EventAUnits, unit3)
	
	local EventBUnits = {}
	table.insert(EventBUnits, unit4)
	--[[
	Mission.Planes = {}
		table.insert(Mission.Planes, unit1)
		table.insert(Mission.Planes, unit2)
		table.insert(Mission.Planes, unit3)
		table.insert(Mission.Planes, unit4)
	--]]
	if not Mission.MogamiDead then
		for idx, unit in pairs (EventAUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.Mogami)
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	elseif not Mission.AkizukiDead then
		for idx, unit in pairs (EventAUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.Akizuki)			
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	else
		for idx, unit in pairs (EventAUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)	
			PilotRetreat(unit)			
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	end
	
	if not Mission.AkizukiDead then
		for idx, unit in pairs (EventBUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.Akizuki)						
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	elseif not Mission.MogamiDead then
		for idx, unit in pairs (EventBUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.Mogami)
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	else
		for idx, unit in pairs (EventBUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)	
			PilotRetreat(unit)			
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end	
	end	
end

function luaEventSpawn2BCallback(unit1, unit2)
  local EventAUnits = {}
	table.insert(EventAUnits, unit1)
	table.insert(EventAUnits, unit2)
	
	Mission.Planes = {}
		table.insert(Mission.Planes, unit1)
		table.insert(Mission.Planes, unit2)
	
	if not Mission.AkizukiDead then
		for idx, unit in pairs (EventAUnits) do			
			PilotSetTarget(unit, Mission.Akizuki)
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
	else
		for idx, unit in pairs (EventAUnits) do			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end
	end
end

function luaRemovePlanes()
	if Mission.Players == 1 or Mission.Players == 2 then
		if Mission.AkizukiDead then
			if Mission.PlanesRemoved then
-- RELEASE_LOGOFF  				luaLog("Planes are already removed")
			else
				luaRemoveDeadsFromTable(Mission.Planes)
				for idx, unit in pairs (Mission.Planes) do				
					PilotRetreat(unit)
-- RELEASE_LOGOFF  					luaLog("Removing Planes from the mission")
				end
				Mission.PlanesRemoved = true
			end
		end
	end
end

function luaStartKeyUnits()	
	local path1 = FindEntity("ep1")	
	local path2 = FindEntity("ep2")	
	local path3 = FindEntity("ep3")	
	local path4 = FindEntity("ep4")	
	local path5 = FindEntity("ep5")					
		
	NavigatorMoveOnPath(Mission.Keyunit, path3) 	
	SetShipMaxSpeed(Mission.Keyunit, 10.28888)
	SetShipSpeed(Mission.Keyunit, 10.28888)
	
	if not Mission.Destroyer1 == nil then
		NavigatorMoveOnPath(Mission.Destroyer1, path1)	
		SetShipSpeed(Mission.Destroyer1, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer1, 10.28888)
	end
	
	if not Mission.Destroyer2 == nil then
		NavigatorMoveOnPath(Mission.Destroyer2, path2)	
		SetShipSpeed(Mission.Destroyer2, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer2, 10.28888)
	end
	if not Mission.Destroyer3 == nil then
		NavigatorMoveOnPath(Mission.Destroyer3, path4)	
		SetShipSpeed(Mission.Destroyer3, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer3, 10.28888)
	end
	
	if not Mission.Destroyer4 == nil then
		NavigatorMoveOnPath(Mission.Destroyer4, path5)	
		SetShipSpeed(Mission.Destroyer4, 10.28888)
		SetShipMaxSpeed(Mission.Destroyer4, 10.28888)
	end
				
end

function luaEventUnit1Dead()
-- RELEASE_LOGOFF  	luaLog("")
	Mission.MogamiDead = true
-- RELEASE_LOGOFF  	luaLog("Mogami dead")
end

function luaEventUnit2Dead()
-- RELEASE_LOGOFF  	luaLog("")
	Mission.AkizukiDead = true
-- RELEASE_LOGOFF  	luaLog("Akizuki dead")
end

function luaAddListeners()
	AddListener("kill", "Listener01", {
			["callback"] = "luaStartMissionEnd1",
			["entity"] = Mission.Keyunits,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active1")
end

function luaAddMogamiListener()
	AddListener("kill", "Listener02", {
			["callback"] = "luaEventUnit1Dead",
			["entity"] = Mission.JapaneseCruiser,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active2")
end

function luaAddAkizukiListener()
	AddListener("kill", "Listener03", {
			["callback"] = "luaEventUnit2Dead",
			["entity"] = Mission.JapaneseDestroyer,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active3")	
end
function luaShowMissionHint()
	ShowHint("ID_Hint_Escort01")	
	-- mode description hint overlay
end

function luaSetDef()
		Mission.DefDDs = luaRemoveDeadsFromTable(Mission.DefDDs)
		Mission.Attackers = luaRemoveDeadsFromTable(Mission.Attackers)
		if table.getn(Mission.DefDDs) == 0 then
-- RELEASE_LOGOFF  			luaLog("skipping defensive manouvers")
		else
			for IDx, unit in pairs (Mission.DefDDs) do
				if table.getn(Mission.Attackers) == 0 then
-- RELEASE_LOGOFF  					luaLog("skipping defensive manouvers")
				else
					for IDx, target in pairs (Mission.Attackers) do				
							NavigatorAttackMove(unit, target, {})
							SetShipSpeed(unit, 18.00554)
							SetShipMaxSpeed(unit, 18.00554)
					end
				end
			end
		end
end