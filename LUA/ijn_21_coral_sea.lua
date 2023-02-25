---- CORAL SEA COUNTERSTRIKE (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- CORAL SEA COUNTERSTRIKE (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	--PrepareClass(163) 	-- B6N
	--PrepareClass(159) 	-- D4Y
	
	PrepareClass(108) 	-- SBD
	PrepareClass(112) 	-- TBD
	PrepareClass(113) 	-- TBF
	
	PrepareClass(27) 	-- Elco
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_CALM)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("ijndlg",4)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_21_coral_sea.lua"

	this.Name = "IJN21"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Sink",
				["Text"] = "Find and sink the enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Protect the Hiryu!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Sink the enemy strike group!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[[[4] = {
				["ID"] = "Escape",
				["Text"] = "Escape the operation area with the Hiryu!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]
		},
		["secondary"] = {
			[1] = {
				["ID"] = "BB",
				["Text"] = "Personally shoot down 30 enemy planes!",
				["TextCompleted"] = "You've shot down 30 enemy planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Bruh",
				["Text"] = "Don't lose any submarines!",
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
		["INTRO"] = {--
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
					["message"] = "INTRO5",
				},
				{
					["type"] = "pause",
					["time"] = 11,
				},
				{
					["message"] = "INTRO6",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "INTRO7",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "INTRO8",
				},
			},
		},
		["COMPROMISED"] = {--
			["sequence"] = {
				{
					["message"] = "COMPROMISED1",
				},
				{
					["message"] = "COMPROMISED2",
				},
			},
		},
		["SIGHTED"] = {--
			["sequence"] = {
				{
					["message"] = "SIGHTED1",
				},
			},
		},
		["DESTROYER"] = {--
			["sequence"] = {
				{
					["message"] = "DESTROYER1",
				},
				{
					["message"] = "DESTROYER2",
				},
				{
					["message"] = "DESTROYER3",
				},
			},
		},
		["HIT"] = {--
			["sequence"] = {
				{
					["message"] = "HIT1",
				},
				{
					["message"] = "HIT2",
				},
			},
		},
		["PLANES"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["DECK"] = {--
			["sequence"] = {
				{
					["message"] = "DECK1",
				},
				{
					["message"] = "DECK2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaCanComplete",
				},
			},
		},
		["SPOTTED"] = {--
			["sequence"] = {
				{
					["message"] = "SPOTTED1",
				},
			},
		},
		["WAVE"] = {--
			["sequence"] = {
				{
					["message"] = "WAVE1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "idlg02",
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
		Mission.SkillLevel = SKILL_ELITE
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
	
	---- IJN ----
	
	Mission.I400 = FindEntity("I-400")
	
	Mission.Subs = {}
		table.insert(Mission.Subs, Mission.I400)
	
	if Mission.Difficulty < 2 then
	
		table.insert(Mission.Subs, GenerateObject("I-52"))
	
	end
	
	for idx,unit in pairs(Mission.Subs) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		SetCatapultStock(unit, 0)
		
	end
	
	---- USN ----
	
	Mission.CVGrp = {}
		table.insert(Mission.CVGrp, FindEntity("San Jacinto"))
		table.insert(Mission.CVGrp, FindEntity("Langley"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class01"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class02"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class03"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class04"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class05"))
	
	for idx,unit in pairs(Mission.CVGrp) do
		
		JoinFormation(unit, Mission.CVGrp[1])
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
	
	Mission.CVs = {}
		table.insert(Mission.CVs, FindEntity("San Jacinto"))
		table.insert(Mission.CVs, FindEntity("Langley"))
	
	for idx,unit in pairs(Mission.CVs) do
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 1)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 2)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
		
		end
		
	end
	
	Mission.USAttackers = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.USAttackWaves = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.CVSlots = 0
		Mission.DDsToAttack = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.CVSlots = 1
		Mission.DDsToAttack = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.CVSlots = 2
		Mission.DDsToAttack = 3
		
	end
	
	---- INIT FUNCT. ----
	
	SetSimplifiedReconMultiplier(0.66)
	
	local moveIdx = random(1,4)
	local move = 3500
	local moveX
	local moveY
	
	if moveIdx == 1 then
	
		moveX = move
		moveY = move
	
	elseif moveIdx == 2 then
	
		moveX = -(move)
		moveY = move
	
	elseif moveIdx == 3 then
	
		moveX = move
		moveY = -(move)
	
	elseif moveIdx == 4 then
	
		moveX = -(move)
		moveY = -(move)
	
	end
	
	for idx,unit in pairs(Mission.CVGrp) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
	end
	
	EnableMessages(false)
	
	MissionNarrative("March 1st, 1942 - In the Coral Sea")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("CVPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--Mission.Debug = true
	
	--[[if Mission.Debug then
		
		for idx,unit in pairs(Mission.RllyBruh) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end]]
	
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
		
		Blackout(false, "", 3)
		
		luaIntroMovie1()
		
		Mission.Started = true

    else

        if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	

    ---- TEST ----

    --print("text")
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.USAttackers))
	--MissionNarrative("#Mission.TEST#")
	
end

---- OBJECTIVE CHECKER ----

function luaCheckObjectives()

	if not Mission.EndMission then
	
		if Mission.MissionPhase > 0 then
		
			if Mission.CanMusicCheck then
			
				local music_selectedUnit = GetSelectedUnit()

				if music_selectedUnit then

					luaCheckMusic(music_selectedUnit)

				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if Mission.Hiryu.Dead then
				
					luaMissionFailed()
				
				end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 10 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) == 0 then
				
					HideUnitHP()
					
					if IsListenerActive("hit", "TroopListener") then
					
						RemoveListener("hit", "TroopListener")
					
					end
					
					if IsListenerActive("hit", "SubHitListener") then
					
						RemoveListener("hit", "SubHitListener")
					
					end
					
					if IsListenerActive("recon", "SubListener") then
					
						RemoveListener("recon", "SubListener")
					
					end
					
					if IsListenerActive("recon", "CVListener") then
					
						RemoveListener("recon", "CVListener")
					
					end
					
					luaObj_Completed("primary", 1, true)
					
					Blackout(true, "luaMoveToPh2", 3)
				
				else
					
					if Mission.CVsAttack then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
						
							local stloPlaneNum, stloPlaneTable= luaGetSlotsAndSquads(unit)
							
							if stloPlaneNum < Mission.CVSlots and IsReadyToSendPlanes(unit) then
								
								local planeTypes = {
								108,
								108,
								}
								
								local plane = luaPickRnd(planeTypes)
								
								local slotIndex = LaunchSquadron(unit,plane,3,3)
								local launchedWildcat = thisTable[tostring(GetProperty(unit, "slots")[slotIndex].squadron)]
								SetSkillLevel(launchedWildcat, Mission.SkillLevel)
								
								local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
								PilotSetTarget(launchedWildcat, trg)

							end
						
						end
					
					end
					
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 0 then
				
					luaMissionFailed()
				
				end
				
				if Mission.I400.Dead and not Mission.Blah then
				
					luaStartDialog("COMPROMISED")
					
					Mission.Blah = true
				
				end
				
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 1 then
				
					luaObj_Failed("hidden",1)
				
				end
			
			end
			
		elseif Mission.MissionPhase == 2 then
			
			if Mission.USAttackWaves >= 3 then
			
				if Mission.CanComplete then
				
					--HideUnitHP()
					
					--luaObj_Completed("primary", 2)
					
					Blackout(true, "luaMoveToPh3", 3)
				
				end
				
			end
			
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.StrikeGrp)) == 0 and not Mission.LastWaveSpawned then
				
					HideUnitHP()
					
					luaObj_Completed("primary", 2)
					luaObj_Completed("primary", 3, true)
					
					--luaDelay(luaMoveToPh4, 3)
					luaDelay(luaMissionComplete, 3)
					
					Mission.LastWaveSpawned = true
					Mission.EndMission = true
					
				end
				
			end
		
		--[[elseif Mission.MissionPhase == 4 then
		
			if luaObj_IsActive("primary", 4) then
			
				if Mission.Hiryu and not Mission.Hiryu.Dead then
				
					local untPos = GetPosition(Mission.Hiryu)
					
					if IsInBorderZone(untPos) then
					
						SetInvincible(Mission.Hiryu, 0.01)
						
						HideUnitHP()
						
						luaObj_Completed("primary", 4)
						
						luaMissionComplete()
						
					end
				
				end
			
			end]]
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 4 ----

function luaBomberFlow()

	if not Mission.EndMission then
	
		local bruh = random(1,3)
		local planeTable = {}
		local plane1
		local plane2
		local plane3
		
		if bruh == 1 then
		
			plane1 = GenerateObject("B-17 01")
			plane2 = GenerateObject("B-17 02")
			plane3 = GenerateObject("B-17 03")
		
		elseif bruh == 2 then
		
			plane1 = GenerateObject("B-24 01")
			plane2 = GenerateObject("B-24 02")
			plane3 = GenerateObject("B-24 03")
		
		elseif bruh == 3 then
		
			plane1 = GenerateObject("B-25 01")
			plane2 = GenerateObject("B-25 02")
			plane3 = GenerateObject("B-25 03")
		
		end
		
		table.insert(planeTable, plane1)
		table.insert(planeTable, plane2)
		table.insert(planeTable, plane3)
		
		for idx,unit in pairs(planeTable) do
		
			SetSkillLevel(unit, Mission.SkillLevel)
			EntityTurnToEntity(unit, Mission.Hiryu)
			PilotSetTarget(unit, Mission.Hiryu)
			UnitSetFireStance(unit, 2)
			SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
			
		end
		
		luaDelay(luaBomberFlow, 100)
	
	end

end

function luaMoveToPh4()

	Mission.MissionPhase = 4
	
	local ship1 = GenerateObject("Fletcher-class11")
	local ship2 = GenerateObject("Fletcher-class12")
	local ship3 = GenerateObject("Fletcher-class13")
	local ship4 = GenerateObject("Fletcher-class14")
	local ship5 = GenerateObject("Fletcher-class15")
	
	Mission.DDGrp = {}
		table.insert(Mission.DDGrp, ship1)
		table.insert(Mission.DDGrp, ship2)
		table.insert(Mission.DDGrp, ship3)
		table.insert(Mission.DDGrp, ship4)
		table.insert(Mission.DDGrp, ship5)
	
	for idx,unit in pairs(Mission.DDGrp) do
		
		JoinFormation(unit, Mission.DDGrp[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.DDGrp[1], Mission.Hiryu)
	
	local pt1 = GenerateObject("Elco-01")
	local pt2 = GenerateObject("Elco-02")
	local pt3 = GenerateObject("Elco-03")
	local pt4 = GenerateObject("Elco-04")
	local pt5 = GenerateObject("Elco-05")
	local pt6 = GenerateObject("Elco-06")
	local pt7 = GenerateObject("Elco-07")
	local pt8 = GenerateObject("Elco-08")
	local pt9 = GenerateObject("Elco-09")
	local pt10 = GenerateObject("Elco-10")
	local pt11 = GenerateObject("Elco-11")
	local pt12 = GenerateObject("Elco-12")
	local pt13 = GenerateObject("Elco-13")
	local pt14 = GenerateObject("Elco-14")
	local pt15 = GenerateObject("Elco-15")
	
	Mission.PTGrp = {}
		table.insert(Mission.PTGrp, pt1)
		table.insert(Mission.PTGrp, pt2)
		table.insert(Mission.PTGrp, pt3)
		table.insert(Mission.PTGrp, pt4)
		table.insert(Mission.PTGrp, pt5)
		table.insert(Mission.PTGrp, pt6)
		table.insert(Mission.PTGrp, pt7)
		table.insert(Mission.PTGrp, pt8)
		table.insert(Mission.PTGrp, pt9)
		table.insert(Mission.PTGrp, pt10)
		table.insert(Mission.PTGrp, pt11)
		table.insert(Mission.PTGrp, pt12)
		table.insert(Mission.PTGrp, pt13)
		table.insert(Mission.PTGrp, pt14)
		table.insert(Mission.PTGrp, pt15)
	
	for idx,unit in pairs(Mission.PTGrp) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
		NavigatorAttackMove(unit, Mission.Hiryu)
		
	end
	
	luaBomberFlow()
	
	luaAddFinalObjs()
	
	luaStartDialog("WAVE")
	
end

function luaAddFinalObjs()
	
	ForceEnableInput(IC_OVERLAY_BLUE, true)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AIShips)) do
	
		if unit and not unit.Dead then
			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
			
		end
	
	end
	
	luaObj_Add("primary", 4, Mission.Hiryu)
	
	PermitSupportmanager()
	
	--SetAirBaseSlotCount(Mission.Hiryu, 4)
	
	--AddAirBaseStock(Mission.Hiryu, 163, 20)
	--AddAirBaseStock(Mission.Hiryu, 159, 20)
	
	DestroyEffect(Mission.FireEfx.Pointer)
	
end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USAttackers)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	Mission.AIShips = {}
	
	table.insert(Mission.AIShips, Mission.Hiryu)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HiryuGrp)) do
	
		if unit and not unit.Dead then
			
			if unit.Class.Type == "Destroyer" then
			
				table.insert(Mission.AIShips, unit)
				
			end
			
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AIShips)) do
	
		if unit and not unit.Dead then
			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			
			if unit.Class.Type == "Destroyer" then
			
				JoinFormation(unit, Mission.Hiryu)
				
			end
			
		end
	
	end
	
	Mission.HiryuPathIdx = luaRnd(1,2)
	local pathDir
	
	if Mission.HiryuPathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif Mission.HiryuPathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.Hiryu, FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	--local ship1 = GenerateObject("New York")
	local ship2 = GenerateObject("Wyoming")
	--local ship3 = GenerateObject("Toledo")
	--local ship4 = GenerateObject("Los Angeles")
	local ship5 = GenerateObject("Fletcher-class06")
	local ship6 = GenerateObject("Fletcher-class07")
	--local ship7 = GenerateObject("Fletcher-class08")
	--local ship8 = GenerateObject("Fletcher-class09")
	--local ship9 = GenerateObject("Fletcher-class10")
	
	Mission.StrikeGrp = {}
		--table.insert(Mission.StrikeGrp, ship1)
		table.insert(Mission.StrikeGrp, ship2)
		--table.insert(Mission.StrikeGrp, ship3)
		--table.insert(Mission.StrikeGrp, ship4)
		table.insert(Mission.StrikeGrp, ship5)
		table.insert(Mission.StrikeGrp, ship6)
		--table.insert(Mission.StrikeGrp, ship7)
		--table.insert(Mission.StrikeGrp, ship8)
		--table.insert(Mission.StrikeGrp, ship9)
	
	for idx,unit in pairs(Mission.StrikeGrp) do
		
		JoinFormation(unit, Mission.StrikeGrp[1])
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
		
		local move
		
		if Mission.HiryuPathIdx == 1 then
		
			move = -3500
		
		elseif Mission.HiryuPathIdx == 2 then
		
			move = 3500
		
		end
		
		local pos = GetPosition(unit)
		pos.z = pos.z + move
		
		PutTo(unit, pos)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	SetInvincible(Mission.Hiryu, false)
	SetInvincible(Mission.DesignatedSurvivor, false)
	
	local trg1 = ship2
	
	Blackout(false, "", 1)
	
	luaDelay(luaSpottedDia, 3)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.DesignatedSurvivor, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.DesignatedSurvivor, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.DesignatedSurvivor, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	  
	}, luaPh3MovieEnd, true)
	
end

function luaSpottedDia()

	luaStartDialog("SPOTTED")

end

function luaPh3MovieEnd()
	
	ForceEnableInput(IC_OVERLAY_BLUE, false)
	
	NavigatorAttackMove(Mission.StrikeGrp[1], Mission.Hiryu)
	
	SetSelectedUnit(Mission.DesignatedSurvivor)
	
	luaObj_Add("primary", 3, Mission.StrikeGrp)
	
	--DisplayUnitHP((luaRemoveDeadsFromTable(Mission.StrikeGrp)), "Sink the enemy strike group!")
	
end

---- PHASE 2 ----

function luaSpawnNextAmericanWave()
	
	--[[if Mission.USAttackWaves == 0 then
	
		luaObj_Add("primary", 2)
		
		DisplayUnitHP((luaRemoveDeadsFromTable(Mission.HiryuGrp)), "Survive the air raid!")
	
	end]]
	
	local planeTypes = {112, 113}
	
	for i = 1, 5 do
		
		luaSpawnAmerican(luaPickRnd(planeTypes), 3, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.HiryuGrp))), 1, random(-2000,2000), random(500,700), random(4500,5000))
		
	end
	
	Mission.USAttackWaves = Mission.USAttackWaves + 1
	
	if Mission.USAttackWaves < 3 then
	
		luaDelay(luaSpawnNextAmericanWave, 85)
	
	else
		
		for i = 1, 3 do
		
			luaSpawnAmerican(108, 5, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.HiryuGrp))), 1, random(-500,500), random(1000,1200), random(5000,5500))
			
		end
		
		--luaDelay(luaCanComplete, 105)
	
	end
	
end

function luaSpawnAmerican(class, wngCount, pos, equipment, spawnDelta, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = spawnpos.y + alt
	spawnpos.z = spawnpos.z + spawnDelta
	
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = class,
				["Name"] = "American",
				["Crew"] = Mission.USAI,
				["Race"] = USA,
				["WingCount"] = wngCount,
				["Equipment"] = equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaAmericanSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})

end

function luaAmericanSpawned(unit)
	
	local trg
	
	if unit.Class.ID == 112 or unit.Class.ID == 113 then
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.HiryuGrp))
	
	else
	
		trg = Mission.Hiryu
		
		SetInvincible(unit, 0.35)
		
	end
	
	local unitPos = GetPosition(unit)
	
	SetSkillLevel(unit, Mission.SkillLevel)
	SquadronSetSpeed(unit, KMH(150))
	EntityTurnToEntity(unit, trg)
	SquadronSetTravelAlt(unit, unitPos.y, true)
	PilotSetTarget(unit, trg)
	UnitSetFireStance(unit, 2)
	
	table.insert(Mission.USAttackers, unit)
	
	--[[if luaObj_IsActive("primary",2) then
	
		luaObj_AddUnit("primary", 2, unit)
	
	end]]
	
	if not Mission.FinalMovieSet then
		
		luaPh2Movie(unit)
		
		Mission.FinalMovieSet = true
		
	end
	
end

function luaCanComplete()

	Mission.CanComplete = true

end

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.CVGrp)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVGrp)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	local ship1 = GenerateObject("Hiryu")
	local ship2 = GenerateObject("Yoshino")
	local ship3 = GenerateObject("Senjo")
	--local ship4 = GenerateObject("Hiruzen")
	--local ship5 = GenerateObject("Unzen")
	local ship6 = GenerateObject("Kirisame")
	local ship7 = GenerateObject("Aokaze")
	
	Mission.HiryuGrp = {}
		table.insert(Mission.HiryuGrp, ship1)
		table.insert(Mission.HiryuGrp, ship2)
		table.insert(Mission.HiryuGrp, ship3)
		--table.insert(Mission.HiryuGrp, ship4)
		--table.insert(Mission.HiryuGrp, ship5)
		table.insert(Mission.HiryuGrp, ship6)
		table.insert(Mission.HiryuGrp, ship7)
	
	for idx,unit in pairs(Mission.HiryuGrp) do
		
		JoinFormation(unit, Mission.HiryuGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		SetCatapultStock(unit, 0)
		AAEnable(unit, false)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.Escorts = {}
		table.insert(Mission.Escorts, ship2)
		table.insert(Mission.Escorts, ship3)
		table.insert(Mission.Escorts, ship4)
		table.insert(Mission.Escorts, ship5)
	
	Mission.DesignatedSurvivor = luaPickRnd(luaRemoveDeadsFromTable(Mission.Escorts))
	
	SetInvincible(Mission.DesignatedSurvivor, 0.3)
	
	Mission.Hiryu = ship1
	
	SetInvincible(Mission.Hiryu, 0.2)
	
	Mission.Bruh = {}
		table.insert(Mission.Bruh, ship1)
	
	luaSpawnNextAmericanWave()
	
end

function luaPh2Movie(unit)
	
	Blackout(false, "", 1)
	
	luaDelay(luaPlanesDia, 9)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "camera", ["position"]={["parent"] = Mission.Hiryu, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "target", ["target"] = Mission.Hiryu, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Hiryu, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Hiryu, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Hiryu, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Hiryu, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	  
	}, luaPh2MovieEnd, true)

end

function luaPlanesDia()

	luaStartDialog("PLANES")

end

function luaPh2MovieEnd()

	SetSelectedUnit(Mission.HiryuGrp[1])
	
	luaObj_Add("primary", 2, Mission.Hiryu)
	luaObj_Add("secondary", 1)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.Bruh)), "Protect the Hiryu!")
	
	luaAddHiryuHitListener()
	
	for idx,unit in pairs(Mission.HiryuGrp) do
		
		AAEnable(unit, true)
		
	end
	
	--[[if Mission.Debug then
	
		luaDelay(luaMoveToPh3, 20)
	
	end]]
	
end

function luaHiryuDia()
	
	luaStartDialog("DECK")
	
end

---- PHASE 1 ----

function luaDDDia()

	luaStartDialog("DESTROYER")

end

function luaIntroMovie1()

	local trg1 = FindEntity("Langley")
	
	luaDelay(luaIntroDia, 4)
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 8, ["rho"] = 50, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 325, ["theta"] = 6, ["rho"] = 35, ["moveTime"] = 15},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 325, ["theta"] = 6, ["rho"] = 35, ["moveTime"] = 10},
	   
	}, luaIntroMovie2, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	Blackout(true, "luaIntroMovie3", 3)

end

function luaIntroMovie3()
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=400,["y"]=-15,["z"]=300},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=-15,["z"]=250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=-15,["z"]=250},["parent"] = nil,},["moveTime"] = 16.5,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=500,["y"]=-15,["z"]=250},["parent"] = nil,},["moveTime"] = 8,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=500,["y"]=-15,["z"]=250},["parent"] = nil,},["moveTime"] = 6,["transformtype"] = "keepall"},
	   
	}, luaIntroMovie4, true)
	
end

function luaIntroMovie4()
	
	Blackout(true, "luaIntroMovieEnd", 3)
	
end

function luaIntroMovieEnd()
	
	Mission.MissionPhase = 1
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVGrp[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	SetSelectedUnit(FindEntity("I-400"))
	
	Blackout(false, "", 3)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()
	
	luaObj_Add("primary", 1, Mission.CVs)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.CVs)), "Find and sink the enemy carriers!")
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Mission.CanMusicCheck = true
	
	EnableMessages(true)
	
	luaAddCVListener()
	luaAddSubHitListener()
	luaAddCVHitListener()
	luaAddSubListener()
	
	if Mission.Debug then
	
		luaDelay(luaMoveToPh2, 20)
	
	end
	
end

---- LISTENERS ----

function luaAddHiryuHitListener()

	AddListener("hit", "HiryuHitListener", {
		["callback"] = "luaHiryuHit",
		["target"] = {Mission.Hiryu},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"BOMB"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddCVHitListener()

	AddListener("hit", "CVHitListener", {
		["callback"] = "luaCVHit",
		["target"] = Mission.CVs,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"TORPEDO"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddSubHitListener()

	AddListener("hit", "SubHitListener", {
		["callback"] = "luaSubHit",
		["target"] = Mission.Subs,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"DEPTHCHARGE"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddSubListener()

	AddListener("recon", "SubListener", {
		["callback"] = "luaCVHit",
		["entity"] = Mission.Subs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddCVListener()

	AddListener("recon", "CVListener", {
		["callback"] = "luaCVSighted",
		["entity"] = Mission.CVGrp,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaHiryuHit()

	RemoveListener("hit", "HiryuHitListener")
	
	if table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USAttackers)) do
		
			if unit and not unit.Dead then
			
				if IsInvincible(unit) then
				
					SetInvincible(unit, false)
					
				end
			
			end
		
		end
	
	end
	
	BannSupportmanager()
	
	local pos = {["x"]=0, ["y"] = (Mission.Hiryu.Class.Height - 3), ["z"]=0 }

	Mission.FireEfx = Effect("SmallFire", pos, Mission.Hiryu, 60)
	
	luaDelay(luaHiryuDia, 5)
	
end

function luaCVHit()

	RemoveListener("recon", "SubListener")
	RemoveListener("hit", "CVHitListener")
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
	
		if unit and not unit.Dead then
		
			SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
		end
	
	end
	
	local tempTable = {}
	local tracker = 0
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVGrp)) do
	
		if unit and not unit.Dead then
			
			if unit.Class.Type == "Destroyer" and tracker < Mission.DDsToAttack then
			
				table.insert(tempTable, unit)
				
				tracker = tracker + 1
				
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(tempTable)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(tempTable)) do
		
			local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
	
			NavigatorAttackMove(unit, trg)
			
			UnitSetFireStance(unit, 2)
			
		end
	
	end
	
	Mission.CVsAttack = true
	
	luaDelay(luaDDDia, 20)
	
end

function luaSubHit()

	RemoveListener("hit", "SubHitListener")
	
	luaStartDialog("HIT")

end

function luaCVSighted()
	
	RemoveListener("recon", "CVListener")
	
	luaStartDialog("SIGHTED")

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	luaMissionCompletedNew(Mission.Hiryu, "The Hiryu has survived - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true
	
	HideUnitHP()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	--[[if luaObj_IsActive("primary",4) then
		
		luaObj_Failed("primary",4)
	
	end]]
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(nil, "Game Over")
	
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
	
	ExplodeToParts(ship)
	
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