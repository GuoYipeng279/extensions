---- ENDGAME AT MIDWAY (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- ENDGAME AT MIDWAY (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(162) -- Kate
	
	PrepareClass(101) -- Wildcat
	PrepareClass(108) -- Dauntless
	PrepareClass(113) -- Avenger
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("bsmdlg",11)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_11_endgame_at_midway.lua"

	this.Name = "BSM11"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "CV",
				["Text"] = "One of our carriers has to survive the encounter!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Find",
				["Text"] = "Find the Japanese carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "DD",
				["Text"] = "Destroy the Japanese carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "CA",
				["Text"] = "Destroy the patrolling Japanese cruisers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "SS",
				["Text"] = "Destroy the attacking Japanese submarine!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Launch",
				["Text"] = "Launch an air strike on the enemy CVs before our position is reported!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Rein",
				["Text"] = "Destroy the Japanese reinforcements!",
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
				{
					["message"] = "INTRO2",
				},
				{
					["message"] = "INTRO3",
				},
				{
					["message"] = "INTRO4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["CRUISER"] = {
			["sequence"] = {
				{
					["message"] = "CRUISER1",
				},
				{
					["message"] = "CRUISER2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddCruiserObj",
				},
			},
		},
		["SONAR"] = {
			["sequence"] = {
				{
					["message"] = "SONAR1",
				},
				{
					["message"] = "SONAR2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSubObj",
				},
			},
		},
		["RECON"] = {
			["sequence"] = {
				{
					["message"] = "RECON1",
				},
				{
					["message"] = "RECON2",
				},
			},
		},
		["LOCATED"] = {
			["sequence"] = {
				{
					["message"] = "LOCATED1",
				},
				{
					["message"] = "LOCATED2",
				},
			},
		},
		["SINKING"] = {
			["sequence"] = {
				{
					["message"] = "SINKING1",
				},
			},
		},
		["DETATCHMENT"] = {
			["sequence"] = {
				{
					["message"] = "DETATCHMENT1",
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
	
	Mission.Enterprise = FindEntity("Enterprise")
	Mission.Hornet = FindEntity("Hornet")
	
	Mission.HenryGang = {}
		table.insert(Mission.HenryGang, Mission.Enterprise)
		table.insert(Mission.HenryGang, Mission.Hornet)
		table.insert(Mission.HenryGang, FindEntity("Houston"))
		table.insert(Mission.HenryGang, FindEntity("Hughes"))
		table.insert(Mission.HenryGang, FindEntity("Morris"))
		
	for idx,unit in pairs(Mission.HenryGang) do
		
		JoinFormation(unit, Mission.HenryGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.CVGang = {}
		table.insert(Mission.CVGang, Mission.Enterprise)
		table.insert(Mission.CVGang, Mission.Hornet)
	
	for idx,unit in pairs(Mission.CVGang) do
		
		if Mission.Difficulty == 0 then
			
			AddAirBasePlanes(unit, 101, 16)
			AddAirBasePlanes(unit, 113, 16)
			AddAirBasePlanes(unit, 108, 16)
			
		elseif Mission.Difficulty == 1 then
			
			AddAirBasePlanes(unit, 101, 13)
			AddAirBasePlanes(unit, 113, 13)
			AddAirBasePlanes(unit, 108, 13)
		
		elseif Mission.Difficulty == 2 then
			
			AddAirBasePlanes(unit, 101, 10)
			AddAirBasePlanes(unit, 113, 10)
			AddAirBasePlanes(unit, 108, 10)
		
		end
		
	end
	
	---- IJN ----
	
	Mission.Hiryu = FindEntity("Hiryu")
	Mission.Soryu = FindEntity("Soryu")
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, Mission.Hiryu)
		table.insert(Mission.JapGang, Mission.Soryu)
		table.insert(Mission.JapGang, FindEntity("Atago"))
		table.insert(Mission.JapGang, FindEntity("Sazanami"))
		table.insert(Mission.JapGang, FindEntity("Shikinami"))
	
	for idx,unit in pairs(Mission.JapGang) do
		
		JoinFormation(unit, Mission.JapGang[2])
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
	
	Mission.JapCVs = {}
		table.insert(Mission.JapCVs, Mission.Hiryu)
		table.insert(Mission.JapCVs, Mission.Soryu)
	
	for idx,unit in pairs(Mission.JapCVs) do
		
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 4)
		
		end
		
	end
	
	Mission.JapCruisers = {}
		table.insert(Mission.JapCruisers, FindEntity("Tone"))
		table.insert(Mission.JapCruisers, FindEntity("Maya"))
	
	for idx,unit in pairs(Mission.JapCruisers) do
	
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
	
	Mission.JapSubs = {}
		table.insert(Mission.JapSubs, FindEntity("I-25"))
		--table.insert(Mission.JapSubs, FindEntity("I-26"))
	
	for idx,unit in pairs(Mission.JapSubs) do
	
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		if Mission.Difficulty == 0 then
			
			SetShipMaxSpeed(unit, 5)
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 then
			
			SetShipMaxSpeed(unit, 10)
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			SetShipMaxSpeed(unit, 15)
			
			RepairEnable(unit, true)
			
		end
		
	end
	
	Mission.JapCAP = {}
	Mission.EmilyGang = {}
	
	---- VAR ----
	
	Mission.JapPatrolPath = FindEntity("PatrolPath")

	Mission.JapCVFleetStartPos = 
	{
		[1] = 
		{
			["x"] = -8000,
			["y"] = 0,
			["z"] = 8000,
		},
		[2] = 
		{
			["x"] = 8000,
			["y"] = 0,
			["z"] = -8000,
		},
		[3] = 
		{
			["x"] = 7000,
			["y"] = 0,
			["z"] = 7000,
		},
		[4] = 
		{
			["x"] = 7000,
			["y"] = 0,
			["z"] = 7000,
		},
	}

	Mission.JapCVFleetTargetPos = 
	{
		[1] = 
		{
			["x"] = 7000,
			["y"] = 0,
			["z"] = 7000,
		},
		[2] = 
		{
			["x"] = 7000,
			["y"] = 0,
			["z"] = 7000,
		},
		[3] = 
		{
			["x"] = -7000,
			["y"] = 0,
			["z"] = 7000,
		},
		[4] = 
		{
			["x"] = 7000,
			["y"] = 0,
			["z"] = -7000,
		},
	}
	
	Mission.EmilySpawns = 
	{
		[1] = 
		{
			["x"] = -8500,
			["y"] = 500,
			["z"] = 6500,
		},
		[2] = 
		{
			["x"] = -4000,
			["y"] = 500,
			["z"] = 8500,
		},
		[3] = 
		{
			["x"] = 4000,
			["y"] = 500,
			["z"] = 8500,
		},
		[4] = 
		{
			["x"] = 8500,
			["y"] = 500,
			["z"] = 6500,
		},
	}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.LastEmilySpawn = 1
	Mission.CanSpawnEmily = true
	Mission.TimeToReshuffleEmilys = true
	
	if Mission.Difficulty == 0 then
		
		Mission.MaxCAPNum = 1
		Mission.MaxEmilyNum = 1
		Mission.EmilySpawnDelay = 60
	
	elseif Mission.Difficulty == 1 then
		
		Mission.MaxCAPNum = 2
		Mission.MaxEmilyNum = 2
		Mission.EmilySpawnDelay = 40
	
	elseif Mission.Difficulty == 2 then
		
		Mission.MaxCAPNum = 3
		Mission.MaxEmilyNum = 3
		Mission.EmilySpawnDelay = 20
	
	end
	
	---- INIT FUNCT. ----
	
	Blackout(true, "", true)
	
	luaDelay(luaStartMission, 1)
	
	MissionNarrative("June 4th, 1942 - Somewhere near Midway")
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
	--luaMoveToPh2()
	
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
		
		Mission.Started = true
		
	else
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
	end
	
	if Mission.MissionPhase < 99 then
		
		if luaObj_IsActive("primary",1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CVGang)) == 0 then
				
				if Mission.MissionPhase == 1 then
				
					HideScoreDisplay(1,0)
				
				elseif Mission.MissionPhase == 2 then
				
					HideScoreDisplay(2,0)
				
				end
				
				HideUnitHP()
				
				luaMissionFailed(luaPickRnd(Mission.CVGang))
				
			else
			
				Mission.CVGang = luaRemoveDeadsFromTable(Mission.CVGang)
				
			end
		
		end
		
		if not luaObj_IsActive("primary",3) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.EmilyGang)) < Mission.MaxEmilyNum and Mission.CanSpawnEmily then
				
				local bruh = random(1,2)
				--local brah = random(1,4)
				
				if Mission.LastEmilySpawn >= 5 then
				
					Mission.LastEmilySpawn = 1
				
				end
				
				local emily
				local spawnPoint = Mission.EmilySpawns[Mission.LastEmilySpawn]
				
				if bruh == 1 then
				
					emily = GenerateObject("H8K Emily 1")
				
				elseif bruh == 2 then
				
					emily = GenerateObject("H8K Emily 2")
				
				end
				
				Mission.LastEmilySpawn = Mission.LastEmilySpawn + 1
				
				table.insert(Mission.EmilyGang, emily)
				
				luaDelay(luaAllowEmilySpawn, Mission.EmilySpawnDelay)
				
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCVs)) == 0 then
		
			HideScoreDisplay(2,0)
			HideUnitHP()
			
			luaObj_Completed("primary", 3)
			
			luaMissionComplete(luaPickRnd(Mission.JapCVs))
			
		else
			
			Mission.JapCVs = luaRemoveDeadsFromTable(Mission.JapCVs)
			Mission.JapCVNum = table.getn(luaRemoveDeadsFromTable(Mission.JapCVs))
			
			if luaObj_IsActive("primary",3) then
			
				local line1 = "Destroy the Japanese carriers!"
				local line2 = "Carrier(s) left to sink: #Mission.JapCVNum#"
				luaDisplayScore(2, line1, line2)
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.JapCVs)) == 1 and not Mission.OneCVDeadDiaPlayed then
				
				luaStartDialog("SINKING")
				
				Mission.OneCVDeadDiaPlayed = true
			
			end
			
			if Mission.USFleetSighted then
				
				local fighter = {
					[1] = 150,
				}
				local bombers = {
					[1] = 158,
					[2] = 162,
				}
				
				if not Mission.Hiryu.Dead then
					
					luaAirfieldManager(Mission.Hiryu, fighter, bombers, Mission.CVGang)
					
				end
				
				if not Mission.Soryu.Dead then
				
					luaAirfieldManager(Mission.Soryu, fighter, bombers, Mission.CVGang)
					
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.EmilyGang)) > 0 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EmilyGang)) do
					
						if unit and not unit.Dead then
					
							local ammo = GetProperty(unit, "ammoType")
				
							if ammo == 1 or ammo == 2 then
							
								if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
								
									local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))
								
									luaSetScriptTarget(unit, trg)
									PilotSetTarget(unit, trg)
								
								end
							
							else
							
								if not unit.retreating then
								
									PilotRetreat(unit)
									
									unit.retreating = true
								
								end
							
							end
						
						end
						
					end
					
				end
				
			else
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapCAP)) < Mission.MaxCAPNum then
					
					local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVs))
					
					if cv and not cv.Dead then
					
						if IsReadyToSendPlanes(cv) then
							
							local planeTypes = 
							{
							150,
							150,
							}
							
							local slotIndex = LaunchSquadron(cv,luaPickRnd(planeTypes),3)
							local launchedCAP = thisTable[tostring(GetProperty(cv, "slots")[slotIndex].squadron)]
							
							table.insert(Mission.JapCAP, launchedCAP)
							
							PilotMoveTo(launchedCAP, {["x"]=luaRnd(-6500, 6500), ["y"]=500, ["z"]=luaRnd(-5500, 6500)})
							UnitFreeAttack(launchedCAP)
							
						end
					
					end
					
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.EmilyGang)) > 0 then
					
					if Mission.TimeToReshuffleEmilys then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EmilyGang)) do
						
							if unit and not unit.Dead then
							
								PilotMoveTo(unit, {["x"]=luaRnd(-6500, 6500), ["y"]=400, ["z"]=luaRnd(-5500, 6500)})
								
							end
						
						end
					
						Mission.TimeToReshuffleEmilys = false
						
						luaDelay(luaEmilyReshuffle, 150)
						
					end
				
				end
			
			end
		
		end
		
		if luaObj_IsActive("secondary",1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapCruisers)) == 0 then
			
				luaObj_Completed("secondary", 1, true)
			
			end
		
		end
		
		if luaObj_IsActive("secondary",2) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapSubs)) == 0 then
			
				luaObj_Completed("secondary", 2, true)
			
			end
		
		end
		
		if luaObj_IsActive("hidden",2) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.BruhGang)) == 0 then
			
				luaObj_Completed("hidden", 2)
			
			end
		
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 2 ----

function luaSpawnJapRein()

	Mission.JapReinHere = true
	
	local rein1 = GenerateObject("Mogami")
	local rein2 = GenerateObject("Mikuma")
	local rein3 = GenerateObject("Ushio")
	local rein4 = GenerateObject("Arashio")
	
	Mission.BruhGang = {}
		table.insert(Mission.BruhGang, rein1)
		table.insert(Mission.BruhGang, rein2)
		table.insert(Mission.BruhGang, rein3)
		table.insert(Mission.BruhGang, rein4)
	
	for idx,unit in pairs(Mission.BruhGang) do
		
		JoinFormation(unit, Mission.BruhGang[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		UnitSetFireStance(unit, 2)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	local cvPos = GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVs)))
	local spawnPos = cvPos
	
	if cvPos.x >= 6500 then
	
		spawnPos.x = spawnPos.x + 2000
	
	else
	
		spawnPos.z = spawnPos.z + 2000
	
	end
	
	PutTo(Mission.BruhGang[1], spawnPos)
	
	PutRelTo(Mission.BruhGang[2], Mission.BruhGang[1], {["x"]=0, ["y"]=0, ["z"]=-500,})
	PutRelTo(Mission.BruhGang[3], Mission.BruhGang[1], {["x"]=500, ["y"]=0, ["z"]=0,})
	PutRelTo(Mission.BruhGang[4], Mission.BruhGang[1], {["x"]=-500, ["y"]=0, ["z"]=0,})
	
	--NavigatorAttackMove(Mission.BruhGang[1], luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang)))
	NavigatorMoveOnPath(Mission.BruhGang[1], Mission.JapPatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN, 10)
	
	luaObj_Add("hidden", 2)
	
	luaAddJapReinListener()
	
end

---- PHASE 1 ----

function luaStartMission()

	Mission.InitPosIdx = luaRnd(1,4)

	local spawnXPos = 0
	
	if Mission.InitPosIdx == 1 or Mission.InitPosIdx == 4 then
		
		spawnXPos = 250
		
	elseif Mission.InitPosIdx == 2 or Mission.InitPosIdx == 3 then
		
		spawnXPos = -250
		
	end

	PutTo(Mission.Soryu, Mission.JapCVFleetStartPos[Mission.InitPosIdx])

	PutRelTo(Mission.Hiryu, Mission.Soryu, {["x"]=0, ["y"]=0, ["z"]=-600})
	PutRelTo(Mission.JapGang[3], Mission.Soryu, {["x"]=0, ["y"]=0, ["z"]=500})
	PutRelTo(Mission.JapGang[4], Mission.Soryu, {["x"]=spawnXPos, ["y"]=0, ["z"]=-300})
	PutRelTo(Mission.JapGang[5], Mission.Soryu, {["x"]=spawnXPos, ["y"]=0, ["z"]=-900})

	NavigatorMoveToRange(Mission.Soryu, Mission.JapCVFleetTargetPos[Mission.InitPosIdx])
	SetShipSpeed(Mission.Soryu, 6)

	NavigatorMoveOnPath(Mission.JapCruisers[1], Mission.JapPatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN, 10)
	NavigatorMoveOnPath(Mission.JapCruisers[2], Mission.JapPatrolPath, PATH_FM_CIRCLE, PATH_SM_JOIN, 10)
	
	UnitSetFireStance(Mission.JapCruisers[1], 2)
	UnitSetFireStance(Mission.JapCruisers[2], 2)

	for idx,unit in pairs(Mission.JapSubs) do
	
		local trg = luaPickRnd(Mission.CVGang)
		
		NavigatorAttackMove(unit, trg)
		
		if Mission.Difficulty == 0 then
		
			NavigatorAllowMaxDepth(unit, false)
		
		elseif Mission.Difficulty == 2 then
		
			SetUnlimitedAirSupply(unit, true)
		
		end
		
	end
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	luaIn()

end

function luaIn()
	
	SetSelectedUnit(Mission.Enterprise)
	
	Blackout(false, "", 2)
	
	luaDelay(luaIntroDia, 3.7)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaAddFirstObjs()

	luaObj_Add("primary", 2)
	luaObj_Add("primary", 1, Mission.CVGang)
	
	local line1 = "Find the Japanese carriers!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	DisplayUnitHP((Mission.CVGang), "One of our carriers has to survive the encounter!")
	
	luaObj_Add("hidden", 1)
	
	luaAddJapFleetListener()
	luaAddJapFleetHitListener()
	luaAddUSFleetListener()
	luaAddJapSubListener()
	luaAddJapCruiserListener()
	luaAddEmilyListener()
	
end

function luaAddSubObj()

	luaObj_Add("secondary", 2, Mission.JapSubs)

end

function luaAddCruiserObj()

	luaObj_Add("secondary", 1, Mission.JapCruisers)

end

function luaAllowEmilySpawn()

	Mission.CanSpawnEmily = true

end

function luaEmilyReshuffle()

	Mission.TimeToReshuffleEmilys = true

end

---- LISTENERS ----

function luaAddJapReinListener()

	AddListener("recon", "JapReinListener", {
		["callback"] = "luaJapReinSighted",
		["entity"] = Mission.BruhGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddJapFleetHitListener()

	AddListener("hit", "JapFleetHitListener", {
		["callback"] = "luaJapFleetHit",
		["target"] = Mission.JapGang,
		["targetDevice"] = {"LIGHTARTILLERY", "MEDIUMARTILLERY", "HEAVYARTILLERY", "BOMB", "TORPEDO", "FLAK"},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddJapCruiserListener()

	AddListener("recon", "JapCruiserListener", {
		["callback"] = "luaJapCruiserSighted",
		["entity"] = Mission.JapCruisers,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddEmilyListener()

	AddListener("recon", "EmilyListener", {
		["callback"] = "luaEmilySighted",
		["entity"] = Mission.EmilyGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddJapSubListener()

	AddListener("recon", "JapSubListener", {
		["callback"] = "luaJapSubSighted",
		["entity"] = Mission.JapSubs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddJapFleetListener()

	AddListener("recon", "JapFleetListener", {
		["callback"] = "luaJapFleetSighted",
		["entity"] = Mission.JapCVs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddUSFleetListener()

	AddListener("recon", "USFleetListener", {
		["callback"] = "luaUSFleetSighted",
		["entity"] = Mission.CVGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaJapReinSighted()

	RemoveListener("recon", "JapReinListener")
	
	luaStartDialog("DETATCHMENT")

end

function luaJapFleetHit()

	RemoveListener("hit", "JapFleetHitListener")
	
	if luaObj_IsActive("hidden",1) then
	
		luaObj_Completed("hidden",1)
	
	end
	
	luaDelay(luaSpawnJapRein, 100)
	
end

function luaJapCruiserSighted()

	RemoveListener("recon", "JapCruiserListener")
	
	luaStartDialog("CRUISER")

end

function luaJapCruiserSighted()

	RemoveListener("recon", "JapCruiserListener")
	
	luaStartDialog("CRUISER")

end

function luaEmilySighted()

	RemoveListener("recon", "EmilyListener")
	
	luaStartDialog("RECON")

end

function luaJapSubSighted()

	RemoveListener("recon", "JapSubListener")
	
	luaStartDialog("SONAR")

end

function luaJapFleetSighted()

	RemoveListener("recon", "JapFleetListener")
	
	Mission.MissionPhase = 2
	
	HideScoreDisplay(1,0)
	
	luaObj_Completed("primary", 2, true)
	luaObj_Add("primary", 3, Mission.JapCVs)
	
	luaStartDialog("LOCATED")
	
	--[[if not Mission.USFleetSighted then
	
		luaAddJapFleetHitListener()
	
	end]]
	
end

function luaUSFleetSighted()

	RemoveListener("recon", "USFleetListener")
	
	if luaObj_IsActive("hidden",1) then
	
		luaObj_Failed("hidden",1)
	
	end
	
	Mission.USFleetSighted = true
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
	
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCAP)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapCAP)) do
				
				local trgcv = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVs))
				
				PilotLand(unit, trgcv)
			
			end
		
		end
	
	end
	
end

---- MISSION ENDERS ----

function luaMissionComplete(unit)
	
	Mission.EndMission = true
	
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
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionCompletedNew(unit, "All enemy carriers are sinking - Mission Complete", "campaigns/BSM/m1102.bik")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true

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
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionFailedNew(unit, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

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