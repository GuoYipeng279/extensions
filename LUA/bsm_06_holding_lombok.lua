---- HOLDING THE LOMBOK STRAIT (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- HOLDING THE LOMBOK STRAIT (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(166) -- Nell
	
	PrepareClass(112) -- Devastator
	PrepareClass(108) -- Dauntless
	PrepareClass(118) -- Micthell
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("bsmdlg",6)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_06_holding_lombok.lua"

	this.Name = "BSM06"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Airfield",
				["Text"] = "Protect the airfield!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "haWeSeeEachOtherAgainHuh",
				["Text"] = "USS John D. Ford must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Invasion",
				["Text"] = "Prevent the invasion force from capturing the island!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Bombers",
				["Text"] = "Shoot down the Japanese medium bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "PreEmptive",
				["Text"] = "Launch a preemptive strike at the enemy invasion force!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Fifty",
				["Text"] = "50% of your air forces must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Supp",
				["Text"] = "Sink the landing support ship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[3] = {
				["ID"] = "Supp",
				["Text"] = "Don't allow any of the bunkers to be captured by the enemy!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["marker2"] = {
			[1] = {
				["ID"] = "Path_markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		}
	}
	
	---- DIALOGUES ----
	
	Mission.Dialogues = {
		["INTRO"] = {
			["sequence"] = {
				{
					["message"] = "INTRO1",
				},
			},
		},
		["CLOSING"] = {
			["sequence"] = {
				{
					["message"] = "CLOSING1",
				},
				{
					["message"] = "CLOSING2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddLevelBomberObj",
				},
			},
		},
		["DIVE"] = {
			["sequence"] = {
				{
					["message"] = "DIVE1",
				},
			},
		},
		["FLEET"] = {
			["sequence"] = {
				{
					["message"] = "FLEET1",
				},
				{
					["message"] = "FLEET2",
				},
				{
					["message"] = "FLEET3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["LANDING"] = {
			["sequence"] = {
				{
					["message"] = "LANDING1",
				},
				{
					["message"] = "LANDING2",
				},
			},
		},
		["ASHORE"] = {
			["sequence"] = {
				{
					["message"] = "ASHORE1",
				},
			},
		},
		["OUTSKIRTS"] = {
			["sequence"] = {
				{
					["message"] = "OUTSKIRTS1",
				},
			},
		},
	}
	
	---- DIFFICULTY SETTING ----
	
	Mission.Difficulty = GetDifficulty()
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_STUN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_SPVETERAN
	end
	if Mission.Difficulty == 0 then
		Mission.SkillLevelOwn = SKILL_ELITE
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevelOwn = SKILL_SPVETERAN
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_SPNORMAL
	end
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- USN ----
	
	Mission.Airfield = FindEntity("Airfield")
	Mission.JohnDFord = FindEntity("John D. Ford")
	
	SetSkillLevel(Mission.JohnDFord, Mission.SkillLevelOwn)
	NavigatorSetTorpedoEvasion(Mission.JohnDFord, true)
	NavigatorSetAvoidLandCollision(Mission.JohnDFord, true)
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		RepairEnable(Mission.JohnDFord, true)
	
	elseif Mission.Difficulty == 2 then
		
		RepairEnable(Mission.JohnDFord, false)
	
	end
	
	SetRoleAvailable(FindEntity("Japan Tanker"), EROLF_ALL, PLAYER_AI)
	SetSkillLevel(FindEntity("Japan Tanker"), Mission.SkillLevelOwn)
	AAEnable(FindEntity("Japan Tanker"), false)
	NavigatorSetTorpedoEvasion(FindEntity("Japan Tanker"), false)
	NavigatorSetAvoidLandCollision(FindEntity("Japan Tanker"), false)
	
	Mission.BunkerGang = {}
		table.insert(Mission.BunkerGang, FindEntity("Command Post 1"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 2"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 3"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 4"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 5"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 6"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 7"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 8"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 9"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 10"))
		table.insert(Mission.BunkerGang, FindEntity("Command Post 11"))
	
	Mission.Bruh = {}
		table.insert(Mission.Bruh, Mission.JohnDFord)
	
	---- IJN -----
	
	Mission.JapCargoPath = FindEntity("cargo_path")
	Mission.JapPatrolPath = FindEntity("warship_path")
	
	Mission.JapApproachPathGang = {}
		table.insert(Mission.JapApproachPathGang, FindEntity("approach_path1"))
		table.insert(Mission.JapApproachPathGang, FindEntity("approach_path2"))
		table.insert(Mission.JapApproachPathGang, FindEntity("approach_path3"))
	
	Mission.JapAttackerGang = {}
	Mission.JapAttackerBomberGang = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.JapAttackWaves = 0
	Mission.PercentageLimit = 50
	Mission.StartingPlanes = 72
	Mission.PlanesOnGround = Mission.StartingPlanes
	Mission.SpawnedInvasionNum = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	--EnableInput(false)
	Blackout(true, "", true)
	
	MissionNarrative("February 20th, 1942 - Island of Bali")
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh2, 5)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(Mission.JapDestination)
	
end

---- THINK ----

function lua_Think(this, msg)

	if luaMessageHandler (this, msg) == "killed" then
		
		return
		
	end

	if Mission.EndMission then
	
		return
	
	end
	
	if not Mission.Started then
		
		Mission.MissionPhase = 1
		
		luaStartMission()
		
		Mission.Started = true
	
	else
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
	
	end
	
	if Mission.MissionPhase < 99 then
		
		if luaObj_IsActive("primary", 2) then
		
			if Mission.JohnDFord.Dead then
			
				luaMissionFailed(Mission.JohnDFord)
			
			end
		
		end
		
		if luaObj_IsActive("hidden", 1) then
		
			if not Mission.Airfield.Dead and Mission.Airfield.Party == PARTY_ALLIED then
			
				local squadNum, squadTbl = luaGetSlotsAndSquads(Mission.Airfield)
				
				if squadNum > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(squadTbl)) do
					
						if unit and not unit.Dead then
						
							if not unit.discounted then
							
								Mission.PlanesOnGround = Mission.PlanesOnGround - table.getn(GetSquadronPlanes(unit))
								
								unit.discounted = true
								
							end
						
						end
					
					end
				
				end
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase == 1 then
	
		if luaObj_IsActive("primary", 1) then
		
			if Mission.Airfield.Dead then
				
				luaMissionFailed(Mission.Airfield)
			
			else
				
				Mission.AirfieldHP = math.floor(GetHpPercentage(Mission.Airfield) * 100.0000)
				
				local line1 = "Protect the airfield!"
				local line2 = "Airfield integrity: #Mission.AirfieldHP#%"
				luaDisplayScore(1, line1, line2)
			
			end
		
		end
		
		if luaObj_IsActive("secondary", 1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapAttackerBomberGang)) == 0 then
			
				luaObj_Completed("secondary", 1, true)
			
			end
		
		end
		
	elseif Mission.MissionPhase == 2 then
		
		if luaObj_IsActive("primary", 3) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapKeyTrgs)) == 0 then
				
				luaMissionComplete(luaPickRnd(Mission.JapKeyTrgs))
			
			else
				
				Mission.JapNum = table.getn(luaRemoveDeadsFromTable(Mission.JapKeyTrgs))
			
				local line1 = "Prevent the invasion force from capturing the island!"
				local line2 = "Enemy key ship(s) left to sink: #Mission.JapNum#"
				luaDisplayScore(2, line1, line2)
				
				if not Mission.LandingStarted then
					
					Mission.JapFleetGang = luaRemoveDeadsFromTable(Mission.JapFleetGang)
					
					if Mission.JapFleetGang[1] and not Mission.JapFleetGang[1].Dead then
						
						if luaGetDistance(Mission.JapFleetGang[1], Mission.JapDestination) < 1000 then
							
							luaCommenceLandings()
							
							Mission.LandingStarted = true
						
						end
					
					end
					
				else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.BunkerGang)) == 1 and not Mission.DesperateDiaPlayed then
						
						luaStartDialog("OUTSKIRTS")
						
						Mission.DesperateDiaPlayed = true
					
					end
					
					if table.getn(luaRemoveDeadsFromTable(Mission.BunkerGang)) == 0 then
						
						luaMissionFailed(Mission.Airfield)
					
					end
					
				end
				
			end
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BunkerGang)) do
			
				local boats = luaGetShipsAround(unit, 190, "enemy")
				
				if boats then
				
					for idx,boat in pairs(luaRemoveDeadsFromTable(boats)) do
					
						if not boat.discounted then
							
							luaGiveRandomBunkerToJaps()
							
							boat.discounted = true
						
						end
					
					end
				
				end
			
			end
			
		end
		
		if luaObj_IsActive("hidden", 2) then
		
			if Mission.Tanker.Dead then
			
				luaObj_Completed("hidden", 2, true)
			
			end
		
		end
		
	end
	
	---- TEST ----
	
	--Mission.TEST = luaCountPlanes(Mission.Airfield, PARTY_ALLIED, 72)
	--MissionNarrative("#Mission.TEST#")
	
end

---- PHASE 2 ----

function luaGiveRandomBunkerToJaps()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.BunkerGang)) > 0 then
	
		local bunkerLost = luaPickRnd(luaRemoveDeadsFromTable(Mission.BunkerGang))
		
		SetParty(bunkerLost, PARTY_JAPANESE)
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BunkerGang)) do
		
			if bunkerLost == unit then
			
				table.remove(Mission.BunkerGang, idx)
			
			end
		
		end
		
		if not Mission.FightingDiaPlayed then
			
			luaStartDialog("ASHORE")
			
			if luaObj_IsActive("hidden", 3) then
			
				luaObj_Failed("hidden", 3)
			
			end
			
			Mission.FightingDiaPlayed = true
		
		end
		
		luaDelay(luaGiveRandomBunkerToJaps, 30)
	
	end
	
end

function luaCommenceLandings()

	if IsListenerActive("hit", "JapFleetHitListener") then
	
		RemoveListener("hit", "JapFleetHitListener")
		
		luaObj_Failed("secondary",2)
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapLSTGang)) do
		
		if unit and not unit.Dead then
			
			local ignoredIndeces = {}
			local nearestCoordinate
			
			nearestCoordinate, ignoredIndeces = luaGetNearestPathPointCoordinate(unit, Mission.JapCargoPath, ignoredIndeces)
			
			NavigatorMoveToRange(unit, nearestCoordinate)
			
			luaCheckDistance(unit, nearestCoordinate, 200, luaTransportsInPosition)
			
		end
		
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.JapEscortGang)) > 0 then
		
		Mission.JapEscortGang = luaRemoveDeadsFromTable(Mission.JapEscortGang)
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapEscortGang)) do
			
			if unit and not unit.Dead then
				
				local brah
				local bruh = random(1,2)
				
				if bruh == 1 then
				
					brah = PATH_SM_JOIN
				
				elseif bruh == 2 then
				
					brah = PATH_SM_JOIN_BACKWARDS
				
				end
				
				NavigatorMoveOnPath(unit, Mission.JapPatrolPath, PATH_FM_CIRCLE, brah)
			
			end
			
		end
		
	end
	
end

function luaTransportsInPosition()

	if not Mission.LandingDiaPlayed then
		
		luaSpawnLandingWave()
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapTankGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapTankGang)) do
			
				NavigatorMoveToRange(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.BunkerGang)))
			
			end
			
		end
		
		if Mission.Tanker and not Mission.Tanker.Dead then
		
			NavigatorStop(Mission.Tanker)
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapTransGang)) > 0 then
		
			luaStartDialog("LANDING")
		
		end
		
		Mission.LandingDiaPlayed = true
	
	end
	
end

function luaSpawnLandingWave()

	if table.getn(luaRemoveDeadsFromTable(Mission.JapTransGang)) > 0 then
		
		Mission.Landing1 = GenerateObject("Invasion 1")
		Mission.Landing2 = GenerateObject("Invasion 2")
		Mission.Landing3 = GenerateObject("Invasion 3")
		Mission.Landing4 = GenerateObject("Invasion 4")
		Mission.Landing5 = GenerateObject("Invasion 5")
		
		luaInvasionWaveSpawned(Mission.Landing1)
		luaInvasionWaveSpawned(Mission.Landing2)
		luaInvasionWaveSpawned(Mission.Landing3)
		luaInvasionWaveSpawned(Mission.Landing4)
		luaInvasionWaveSpawned(Mission.Landing5)
		
		luaDelay(luaSpawnLandingWave, 80)
		
	end

end

function luaInvasionWaveSpawned(unit)
	
	Mission.JapTransGang = luaRemoveDeadsFromTable(Mission.JapTransGang)
	
	Mission.SpawnedInvasionNum = Mission.SpawnedInvasionNum + 1
	
	NavigatorSetAvoidLandCollision(unit, false)
	NavigatorSetAvoidShipCollision(unit, false)
	
	if Mission.SpawnedInvasionNum == 1 then

		PutRelTo(unit,Mission.JapTransGang[1],{["x"]=-30,["y"]=0,["z"]=-20})
		
	elseif Mission.SpawnedInvasionNum == 2 then

		PutRelTo(unit,Mission.JapTransGang[1],{["x"]=30,["y"]=0,["z"]=-20})

	elseif Mission.SpawnedInvasionNum == 3 then

		PutRelTo(unit,Mission.JapTransGang[1],{["x"]=30,["y"]=0,["z"]=30})

	elseif Mission.SpawnedInvasionNum == 4 then

		if Mission.JapTransGang[2] ~= nil then
			
			PutRelTo(unit,Mission.JapTransGang[2],{["x"]=-30,["y"]=0,["z"]=0})
			
		else
			
			PutRelTo(unit,Mission.JapTransGang[1],{["x"]=-50,["y"]=0,["z"]=0})
			
		end

	elseif Mission.SpawnedInvasionNum == 5 then

		if Mission.JapTransGang[2] ~= nil then
			
			PutRelTo(unit,Mission.JapTransGang[2],{["x"]=30,["y"]=0,["z"]=0})
			
		else
			
			PutRelTo(unit,Mission.JapTransGang[1],{["x"]=50,["y"]=0,["z"]=0})
			
		end

	end
	
	NavigatorMoveToRange(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.BunkerGang)))
	
	if Mission.SpawnedInvasionNum == 5 then
		
		Mission.SpawnedInvasionNum = 0

	end
	
end

function luaMoveToPh2()

	Loading_Start()
	
	Mission.MissionPhase = 2
	
	if luaObj_IsActive("secondary", 1) then
	
		luaObj_Failed("secondary",1)
	
	end
	
	Mission.JapFleet1 = GenerateObject("Sagami Maru")
	Mission.JapFleet2 = GenerateObject("Sasago Maru")
	Mission.JapFleet3 = GenerateObject("LST 1")
	Mission.JapFleet4 = GenerateObject("LST 2")
	Mission.JapFleet5 = GenerateObject("Tatsuno Maru")
	Mission.JapFleet6 = GenerateObject("Nagara")
	Mission.JapFleet7 = GenerateObject("Akebono")
	Mission.JapFleet8 = GenerateObject("Michishio")
	Mission.JapFleet9 = GenerateObject("Hatsushimo")
	
	Mission.Tanker = Mission.JapFleet5
	
	Mission.JapFleetGang = {}
		table.insert(Mission.JapFleetGang, Mission.JapFleet1)
		table.insert(Mission.JapFleetGang, Mission.JapFleet2)
		table.insert(Mission.JapFleetGang, Mission.JapFleet3)
		table.insert(Mission.JapFleetGang, Mission.JapFleet4)
		table.insert(Mission.JapFleetGang, Mission.JapFleet5)
		table.insert(Mission.JapFleetGang, Mission.JapFleet6)
		table.insert(Mission.JapFleetGang, Mission.JapFleet7)
		table.insert(Mission.JapFleetGang, Mission.JapFleet8)
		table.insert(Mission.JapFleetGang, Mission.JapFleet9)
	
	Mission.JapKeyTrgs = {}
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet1)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet2)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet3)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet4)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet6)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet7)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet8)
		table.insert(Mission.JapKeyTrgs, Mission.JapFleet9)
	
	Mission.JapLSTGang = {}
		table.insert(Mission.JapLSTGang, Mission.JapFleet1)
		table.insert(Mission.JapLSTGang, Mission.JapFleet2)
		table.insert(Mission.JapLSTGang, Mission.JapFleet3)
		table.insert(Mission.JapLSTGang, Mission.JapFleet4)
	
	Mission.JapTransGang = {}
		table.insert(Mission.JapTransGang, Mission.JapFleet1)
		table.insert(Mission.JapTransGang, Mission.JapFleet2)
		
	Mission.JapTankGang = {}
		table.insert(Mission.JapTankGang, Mission.JapFleet3)
		table.insert(Mission.JapTankGang, Mission.JapFleet4)
	
	Mission.JapEscortGang = {}
		table.insert(Mission.JapEscortGang, Mission.JapFleet6)
		table.insert(Mission.JapEscortGang, Mission.JapFleet7)
		table.insert(Mission.JapEscortGang, Mission.JapFleet8)
		table.insert(Mission.JapEscortGang, Mission.JapFleet9)
	
	for idx,unit in pairs(Mission.JapFleetGang) do
		
		JoinFormation(unit, Mission.JapFleetGang[6])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	local bruhgang = random(1,3)
	local path = Mission.JapApproachPathGang[bruhgang]
	local pathTable = FillPathPoints(path)
	local spawnPoint = pathTable[1]
	Mission.JapDestination = pathTable[table.getn(pathTable)]
	
	PutTo(Mission.JapFleetGang[6], spawnPoint)
	
	PutRelTo(Mission.JapFleetGang[1], Mission.JapFleetGang[6], {["x"]=200, ["y"]=0, ["z"]=-600,})
	PutRelTo(Mission.JapFleetGang[2], Mission.JapFleetGang[6], {["x"]=-200, ["y"]=0, ["z"]=-600,})
	PutRelTo(Mission.JapFleetGang[3], Mission.JapFleetGang[6], {["x"]=200, ["y"]=0, ["z"]=-300,})
	PutRelTo(Mission.JapFleetGang[4], Mission.JapFleetGang[6], {["x"]=-200, ["y"]=0, ["z"]=-300,})
	PutRelTo(Mission.JapFleetGang[5], Mission.JapFleetGang[6], {["x"]=0, ["y"]=0, ["z"]=-450,})
	PutRelTo(Mission.JapFleetGang[7], Mission.JapFleetGang[6], {["x"]=-500, ["y"]=0, ["z"]=-450,})
	PutRelTo(Mission.JapFleetGang[8], Mission.JapFleetGang[6], {["x"]=0, ["y"]=0, ["z"]=-900,})
	PutRelTo(Mission.JapFleetGang[9], Mission.JapFleetGang[6], {["x"]=500, ["y"]=0, ["z"]=-450,})
	
	NavigatorMoveOnPath(Mission.JapFleetGang[6], path)
	
	AddAirBaseStock(Mission.Airfield, 112, 20)
	AddAirBaseStock(Mission.Airfield, 108, 20)
	AddAirBaseStock(Mission.Airfield, 118, 2)
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaDelay(luaInvasionDia, 1)
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 3, Mission.JapKeyTrgs)
	luaObj_Add("secondary", 2)
	luaObj_Add("hidden", 2)
	luaObj_Add("hidden", 3)
	
	luaAddJapFleetHitListener()
	
end

function luaInvasionDia()

	luaStartDialog("FLEET")

end

---- PHASE 1 ----

function luaSpawnNextJapAttackWave()

	if Mission.JapAttackWaves < 4 then
		
		local bomberTemplate
		local fighterTemplate
		local canAddToObj = false
		
		if Mission.JapAttackWaves == 0 then
		
			bomberTemplate = "Template_Nell2"
			fighterTemplate = "Template_Zero2"
			
			canAddToObj = true
			
			luaAddLevelBomberListener(bomberTemplate)
			
		elseif Mission.JapAttackWaves == 1 then
		
			bomberTemplate = "Template_Nell3"
			fighterTemplate = "Template_Zero3"
			
			canAddToObj = true
			
		elseif Mission.JapAttackWaves == 2 then
		
			bomberTemplate = "Template_Val4"
			fighterTemplate = "Template_Zero4"
			
			luaAddDiveBomberListener(bomberTemplate)
			
		elseif Mission.JapAttackWaves == 3 then
		
			bomberTemplate = "Template_Val5"
			fighterTemplate = "Template_Zero5"
		
		end
		
		local bomber = GenerateObject(bomberTemplate)
		local fighter = GenerateObject(fighterTemplate)
		
		SetSkillLevel(bomber, Mission.SkillLevel)
		SetSkillLevel(fighter, Mission.SkillLevel)
		
		PilotSetTarget(bomber, Mission.Airfield)
		PilotMoveToRange(fighter, bomber, 500)
		
		table.insert(Mission.JapAttackerGang, bomber)
		table.insert(Mission.JapAttackerGang, fighter)
		
		if canAddToObj then
			
			table.insert(Mission.JapAttackerBomberGang, bomber)
			
			if luaObj_IsActive("secondary", 1) then
			
				luaObj_AddUnit("secondary", 1, bomber)
				
			end
			
		end
		
		Mission.JapAttackWaves = Mission.JapAttackWaves + 1
		
		luaDelay(luaSpawnNextJapAttackWave, 120)
		
	else
		
		if not Mission.Phase2TimerSet then
			
			luaDelay(luaPhase2ForceMove, 50)
			
			Mission.Phase2TimerSet = true
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapAttackerGang)) == 0 or Mission.Phase2ForceMove then
			
			HideScoreDisplay(1,0)
			
			luaObj_Completed("primary", 1)
			
			luaMoveToPh2()
		
		else
		
			luaDelay(luaSpawnNextJapAttackWave, 1)
		
		end
		
	end
	
end

function luaPhase2ForceMove()

	Mission.Phase2ForceMove = true

end

function luaStartMission()

	luaIntroMovie()
	
end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 1)
	
	local pos0 = {
		["postype"]="target",
		["position"]= {
			["parent"]=nil,
			["pos"] = { -1402.58, 20, 5607.70 },
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=1.0,
		["zoom"] = 1.1,
	}
	
	MovCamNew_AddPosition(pos0) 
	
	local pos0 = {
		["postype"]="target",
		["position"]= {
			["parent"]=nil,
			["pos"] = { -1111.88, 20, 5741.18, },
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=18.0,
		["linearblend"]=1.0,
		["zoom"] = 1.1,
	}
	
	MovCamNew_AddPosition(pos0) 
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=nil,
			["pos"] = { -1434.22, 60, 5367.44 }
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=1.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["zoom"]=1.1,
	}
	
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=nil,
			["pos"] = { -948.24, 60, 5517.98, }
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=18.0,
		["linearblend"]=1.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["zoom"]=1.1,
		["finishscript"] = "luaIntroMovieEnd",
	}
	
	MovCamNew_AddPosition(pos0)

end

function luaIntroMovieEnd()

	SetSelectedUnit(Mission.JohnDFord)
	
	--EnableInput(true)
	
	luaAddFirstObjs()
	luaSpawnNextJapAttackWave()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Airfield)
	luaObj_Add("primary", 2, Mission.JohnDFord)
	
	DisplayUnitHP((Mission.Bruh), "USS John D. Ford must survive!")
	
	luaObj_Add("hidden", 1)
	
end

function luaAddLevelBomberObj()

	luaObj_Add("secondary", 1, Mission.JapAttackerBomberGang)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

---- LISTENERS ----

function luaAddJapFleetHitListener()

	AddListener("hit", "JapFleetHitListener", {
		["callback"] = "luaJapFleetHit",
		["target"] = Mission.JapFleetGang,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"LIGHTARTILLERY", "MEDIUMARTILLERY", "HEAVYARTILLERY", "BOMB", "TORPEDO", "FLAK"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddLevelBomberListener(bomberTemplate)

	AddListener("recon", "LevelBomberListener", {
		["callback"] = "luaLevelBomberSighted",
		["entity"] = {FindEntity(bomberTemplate)},
		["oldLevel"] = {0},
		["newLevel"] = {1,2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddDiveBomberListener(bomberTemplate)

	AddListener("recon", "DiveBomberListener", {
		["callback"] = "luaDiveBomberSighted",
		["entity"] = {FindEntity(bomberTemplate)},
		["oldLevel"] = {0},
		["newLevel"] = {1,2},
		["party"] = {PARTY_ALLIED},
	})

end

---- LISTENER CALLBACKS -----

function luaJapFleetHit()

	RemoveListener("hit", "JapFleetHitListener")
	
	luaObj_Completed("secondary", 2)

end

function luaLevelBomberSighted()

	RemoveListener("recon", "LevelBomberListener")
	
	luaStartDialog("CLOSING")

end

function luaDiveBomberSighted()

	RemoveListener("recon", "DiveBomberListener")
	
	luaStartDialog("DIVE")

end

---- MOVIES -----

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m0602.bik")

end

---- MISSION ENDERS ----

function luaMissionComplete(unit)
	
	Mission.EndMission = true
	
	SetInvincible(Mission.JohnDFord, 0.01)
	
	HideUnitHP()
	
	HideScoreDisplay(2,0)
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if Mission.StartingPlanes >= luaCountPlanes(Mission.Airfield, PARTY_ALLIED, 72) then

			luaObj_Completed("hidden", 1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		if Mission.Tanker and not Mission.Tanker.Dead then
		
			luaObj_Failed("hidden",2)
		
		elseif Mission.Tanker.Dead then

			luaObj_Completed("hidden", 2)
		
		end
		
	end
	
	if luaObj_IsActive("hidden",3) then
		
		luaObj_Completed("hidden",3)
	
	end
	
	luaMissionCompletedNew(unit, "Enemy forces have been repelled - Mission Complete", "campaigns/BSM/m0603.bik")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true
	
	HideUnitHP()
	
	if Mission.MissionPhase == 1 then
	
		HideScoreDisplay(1,0)
		
	elseif Mission.MissionPhase == 2 then
		
		HideScoreDisplay(2,0)
		
	end
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if Mission.StartingPlanes >= luaCountPlanes(Mission.Airfield, PARTY_ALLIED, 72) then

			luaObj_Completed("hidden", 1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		if Mission.Tanker and not Mission.Tanker.Dead then
		
			luaObj_Failed("hidden",2)
		
		elseif Mission.Tanker.Dead then

			luaObj_Completed("hidden", 2)
		
		end
	
	end
	
	if luaObj_IsActive("hidden",3) then
		
		luaObj_Failed("hidden",3)
	
	end
	
	luaMissionFailedNew(unit, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

function luaCountPlanes(airbase, party, planesGrounded)

	if airbase and not airbase.Dead then
		
		local result
		
		local planesInAir = 0
		
		local planesAround = luaGetPlanesAroundCoordinate(airbase, 40000, party, "own")
		
		if planesAround then
			
			for index, squadron in pairs (planesAround) do
				
				planesInAir = planesInAir + table.getn(GetSquadronPlanes(squadron))
			
			end
			
			result = planesInAir + Mission.PlanesOnGround
			
		else
		
			result = Mission.PlanesOnGround
			
		end
		
		return result
		
	end
	
end

function luaShowPoint(point)
	
	luaObj_Add("marker2",1)
	
	luaObj_AddUnit("marker2",1,GetPosition(point))

end

function luaShowPath(path)
	
	luaObj_Add("marker2",1)
	
	local points = FillPathPoints(path)
	
	for idx, point in pairs(points) do
	
		luaObj_AddUnit("marker2",1,point)
	
	end

end

function luaBlowUp(ship)
	
	local pos = GetPosition(ship)	
	local i = random(1,9)
	
	if i == 1 then
		pos.x = pos.x - 110	
	elseif i == 2 then
		pos.x = pos.x - 80
	elseif i == 3 then
		pos.x = pos.x - 50
	elseif i == 4 then
		pos.x = pos.x  - 20
	elseif i == 5 then
		pos.x = pos.x + 20
	elseif i == 6 then
		pos.x = pos.x + 50
	elseif i == 7 then
		pos.x = pos.x + 80
	elseif i == 8 then
		pos.x = pos.x + 110
	elseif i == 9 then
		pos.x = pos.x + 0
	else
		pos.x = pos.x + 0
	end
	
	Effect("ExplosionBigShip", pos)	
	
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

function luaRAD(x)
	return x *  0.0174532925
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaStartDialog(dialogID, log, ignorePrinted)
	
	if Mission.EndMission then
	
		return
	
	end
	
	if type(dialogID) ~= "string" then
		error("***ERROR: luaStartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaStartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
	end
end

function luaAddPowerup(type)
	
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
	
end