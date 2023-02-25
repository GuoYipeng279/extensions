-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(386)	-- Liz
	--PrepareClass(189)	-- Shinden
	--PrepareClass(152)	-- Gekko
	PrepareClass(150)	-- Zero
	PrepareClass(151)	-- Raiden
	PrepareClass(183)	-- Kikka
	PrepareClass(392)	-- Mustang
	PrepareClass(104)	-- Lightning
	PrepareClass(5)		-- Shooting Star
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort903")
end

function luaInitEscort903(this)
	Mission = this
	Mission.Name = "Air Battle over Japan"
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
				["Text"] = "usn08.obj_p1", --Destroy the Japanese planes!
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "",
				--["TextFailed"] = "The USS Lexington has been destoryed",
				["TextFailed"] = "",
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
				["Text"] = "usn12.obj_p2", --Protect the level bombers!
				--["TextCompleted"] = "The enemy Carrier has been destoryed",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our forces have been neutralized",
				["TextFailed"] = "",
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
	
	Mission.TargetPoint = FindEntity("Bomber destination")
	
	Mission.Bomber1 = FindEntity("Bombers")
	Mission.Bomber2 = FindEntity("BBombers")
	Mission.Bomber3 = FindEntity("BBBombers")
	
	--hp = Mission.Bomber1.Class.HP *1.5
	--	OverrideHP(Mission.Bomber1, 1125)

		
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, Mission.Bomber1)
		table.insert(Mission.Keyunits, Mission.Bomber2)
		table.insert(Mission.Keyunits, Mission.Bomber3)
		
	Mission.ActiveBomber = Mission.Keyunits[1]		

	Mission.EventAUnits = {}
	Mission.EventJUnits = {}

	Mission.ShootingSpawn = {}
		Mission.ShootingSpawn.x = 0
		Mission.ShootingSpawn.y = 1000
		Mission.ShootingSpawn.z = 14000	

	Mission.KikkaSpawn = {}
		Mission.KikkaSpawn.x = 0
		Mission.KikkaSpawn.y = 1000
		Mission.KikkaSpawn.z = 2000
		
	--Allied
	Mission.SpawnPoint1 = FindEntity("US Spawn1")
	
-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint1: "..tostring(FindEntity("Escort - SpawnPoint 1")))
	
	--Japanese
	Mission.SpawnPoint2 = FindEntity("Japan Spawn1")

	-- RELEASE_LOGOFF  	luaLog("Mission.SpawnPoint2: "..tostring(FindEntity("Escort - SpawnPoint 2")))
	
	luaStartKeyUnits()	

	Mission.MissionStart = true
	Mission.MissionEnd = false
	this.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.ReinforcementsUS = false
	Mission.ReinforcementsJP = false
	
	--Events
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetRocketAirGroundTypeDifferent(false)
	SetThink(this, "luaEscort903_think")
	
	AddWatch(Mission.MissionTime)
	
-- RELEASE_LOGOFF  	AddWatch("Mission.StepCounter")
	
	--ModifyKeyUnitNumber

	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort903_think(this, msg)
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
		luaObj_Add("primary", 1, Mission.Keyunits)
		luaObj_AddUnit("primary",1,GetPosition(Mission.TargetPoint))
		-- japanese objs
		luaObj_Add("primary", 2, Mission.Keyunits)
		luaObj_AddUnit("primary",2,GetPosition(Mission.TargetPoint))
		this.MissionStart = false
		
		DisplayUnitHP(0,Mission.Keyunits, "usn08.obj_p1")
		DisplayUnitHP(1,Mission.Keyunits, "usn08.obj_p1")
		DisplayUnitHP(2,Mission.Keyunits, "usn08.obj_p1")
		DisplayUnitHP(3,Mission.Keyunits, "usn08.obj_p1")
		DisplayUnitHP(4,Mission.Keyunits, "usn12.obj_p2")
		DisplayUnitHP(5,Mission.Keyunits, "usn12.obj_p2")
		DisplayUnitHP(6,Mission.Keyunits, "usn12.obj_p2")
		DisplayUnitHP(7,Mission.Keyunits, "usn12.obj_p2")		
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		--Countdown(guiName, startLevel, countdownTime[, callback[, params]])		
		--Countdown("mp.nar_jp_reinf_arrives", 0, 180)
	end
	Mission.MissionTime = Mission.MissionTime+1 
	luaCheckBombers()
	luaCheckObjectives()
	
	if Mission.MissionTime == 100 and not Mission.ReinforcementsUS then	
		luaEventSpawnUS()
	end
	if Mission.MissionTime == 105 and not Mission.ReinforcementsJP then	
		luaEventSpawnJP() 
	end	
	
	if Mission.ReinforcementsUS and Mission.ReinforcementsJP then
		luaJetcontroller()
	end
	
-- objective giving
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
	
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaEventSpawnUS() 
	Mission.ReinforcementsUS = true
	
	local SpawnCoord = GetPosition(Mission.ActiveBomber)
	SpawnCoord.x = SpawnCoord.x + 12500 -- horizontal
	SpawnCoord.y = SpawnCoord.y - 0 --Altitude
	SpawnCoord.z = SpawnCoord.z + 6500 -- vertical	
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 5,
				["Name"] = "Falcon Squadron",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 5,
				["Name"] = "Falcon Squadron",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 5,
				["Name"] = "Falcon Squadron",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 5,
				["Name"] = "Falcon Squadron",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnUSCallback",
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

function luaEventSpawnUSCallback(unit1, unit2, unit3, unit4)
	table.insert(Mission.EventAUnits, unit1)
	table.insert(Mission.EventAUnits, unit2)
	table.insert(Mission.EventAUnits, unit3)
	table.insert(Mission.EventAUnits, unit4)

		for idx, unit in pairs (Mission.EventAUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.ActiveBomber)
			EntityTurnToEntity(unit, Mission.ActiveBomber)
			SetGuiName(unit, "Falcon squadron")	
			SetSkillLevel(unit, SKILL_MPNORMAL)
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end	

	--[[AISetTargetWeight(5, 904, false, 100) --P-80 to Kitsuka
	AISetTargetWeight(5, 386, false, 100) --P-80 to Liz
	AISetTargetWeight(392, 386, false, 0) --P-38 to Liz
	AISetTargetWeight(104, 386, false, 0) --P-51 to Liz
	AISetTargetWeight(904, 5, false, 100) --Kitsuka to P-80
	AISetTargetWeight(905, 5, false, 0) --Zero to P-80
	AISetTargetWeight(152, 5, false, 0) --Gekkko to P-80]]
end

function luaEventSpawnJP() 	
	Mission.ReinforcementsJP = true
	
	local SpawnCoord = GetPosition(Mission.ActiveBomber)
	SpawnCoord.x = SpawnCoord.x + 1500 -- horizontal
	SpawnCoord.y = SpawnCoord.y - 0 --Altitude
	SpawnCoord.z = SpawnCoord.z + 1500 -- vertical			
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 183,
				["Name"] = "Tokubetsu-tai",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 183,
				["Name"] = "Tokubetsu-tai",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 183,
				["Name"] = "Tokubetsu-tai",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = 183,
				["Name"] = "Tokubetsu-tai",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnJPCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	MissionNarrativeParty(0, "mp.nar_jp_reinf_arrived")
	MissionNarrativeParty(1, "mp.nar_jp_reinf_arrived")		
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")		
end

function luaEventSpawnJPCallback(unit1, unit2, unit3, unit4)
	table.insert(Mission.EventJUnits, unit1)
	table.insert(Mission.EventJUnits, unit2)
	table.insert(Mission.EventJUnits, unit3)
	table.insert(Mission.EventJUnits, unit4)

		for idx, unit in pairs (Mission.EventJUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.EventAUnits[idx])
			SetGuiName(unit, "Tokubetsu-tai") --Special Squadron
			EntityTurnToEntity(unit, Mission.EventAUnits[idx])
			PilotSetTarget(Mission.EventAUnits[idx], Mission.EventJUnits[idx])
			SetSkillLevel(unit, SKILL_ELITE)
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end
		
end

function luaJetcontroller()
	for idx, unit in pairs(Mission.EventAUnits) do
		if not unit.Dead then
			if Mission.EventJUnits[idx].Dead then
				local planes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
				local newTarget = luaSortByDistance(Mission.EventAUnits[idx], planes, true)
				PilotSetTarget(unit, newTarget)
			end
		end
	end
	
	for idx, unit in pairs(Mission.EventJUnits) do
		if not unit.Dead then
			if Mission.EventAUnits[idx].Dead then
				local planes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
				local newTarget = luaSortByDistance(Mission.EventJUnits[idx], planes, true)
				PilotSetTarget(unit, newTarget)
			end
		end
	end	
end

function luaCheckBombers()
	luaRemoveDeadsFromTable(Mission.Keyunits)
	if table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) ~= 0 then
		if not Mission.Bomber1.Dead then
			Mission.ActiveBomber = Mission.Bomber1
		elseif not Mission.Bomber2.Dead then
			Mission.ActiveBomber = Mission.Bomber2
		elseif not Mission.Bomber3.Dead then
			Mission.ActiveBomber = Mission.Bomber3
		end

		USspawn = GetPosition(Mission.ActiveBomber)
		USspawn.x = USspawn.x + 12000 -- horizontal
		USspawn.y = USspawn.y - 0 --Altitude
		USspawn.z = USspawn.z + 6000 -- vertical
		PutTo(Mission.SpawnPoint1, USspawn)
	
		JPspawn = GetPosition(Mission.ActiveBomber)
		JPspawn.x = JPspawn.x + 2000 -- horizontal
		JPspawn.y = JPspawn.y - 0 --Altitude
		JPspawn.z = JPspawn.z + 2000 -- vertical
		PutTo(Mission.SpawnPoint2, JPspawn)	
	
		local dist = luaMetric(luaGetDistance3D(Mission.ActiveBomber, Mission.TargetPoint))
		Mission.Measure = GetMeasure()
		Mission.Distance = string.format("%.1f",dist)
		local line2 = "#Mission.Distance# #Mission.Measure#"

		DisplayScores(0,0,"usn01.distance",line2)
		DisplayScores(0,1,"usn01.distance",line2)
		DisplayScores(0,2,"usn01.distance",line2)
		DisplayScores(0,3,"usn01.distance",line2)
		DisplayScores(0,4,"usn01.distance",line2)
		DisplayScores(0,5,"usn01.distance",line2)
		DisplayScores(0,6,"usn01.distance",line2) 
		DisplayScores(0,7,"usn01.distance",line2)	
	end
end

function luaCheckObjectives()
--objective watching
	luaRemoveDeadsFromTable(Mission.Keyunits)
	if table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) == 0 then
		-- allied wins
		luaMissionCompletedNew(Mission.ActiveBomber.LastBanto, "", nil, nil, nil, PARTY_ALLIED)
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)			
		Mission.MissionEnd = true	
	elseif table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) ~= 0 then
		if luaGetDistance(Mission.ActiveBomber, Mission.TargetPoint) < 600 then
			-- japan wins
			luaMissionCompletedNew(Mission.ActiveBomber, "", nil, nil, nil, PARTY_JAPANESE)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)				
			Mission.MissionEnd = true
		end
	end
end

function luaStartKeyUnits()
	for idx, unit in pairs (Mission.Keyunits) do
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		EntityTurnToEntity(unit, Mission.TargetPoint)
		NavigatorMoveToPos(unit, Mission.TargetPoint)
		SquadronSetTravelAlt(unit, 1000)	
		SquadronSetTravelSpeed(unit, 50)
		SetSkillLevel(unit, SKILL_ELITE)
	end
		SquadronSetTravelAlt(Mission.Keyunits[2], 1150)	
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function luaMetric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		--return dist * 0.621371192
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end

end