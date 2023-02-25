---- STRIKE ON THE ALEUTIANS (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- STRIKE ON THE ALEUTIANS (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(104) 	-- P38
	PrepareClass(330) 	-- P39
	PrepareClass(102) 	-- F4U
	PrepareClass(108) 	-- SBD
	PrepareClass(113) 	-- TBF
	PrepareClass(323) 	-- B24
	PrepareClass(118) 	-- B25
	--PrepareClass(125) 	-- PBY
	
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
	
	LoadMessageMap("ijndlg",2)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_08_aleutians.lua"

	this.Name = "IJN08"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Escort",
				["Text"] = "Escort the bomber wing to the target!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Cap",
				["Text"] = "Capture all enemy bases!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Protect your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Wing",
				["Text"] = "Don't lose half of the bomber wing!",
				["TextFailed"] = "You've lost half of your bomber wing!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Fast",
				["Text"] = "The mission must not last longer than 30 minutes!",
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
		["INTRO_1"] = {--
			["sequence"] = {
				{
					["message"] = "MIDWAY1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "MIDWAY2",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "MIDWAY3",
				},
			},
		},
		["INTRO_2"] = {--
			["sequence"] = {
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie3",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg30a_1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "dlg30a_1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg30b",
				},
				{
					["message"] = "dlg30c",
				},
				{
					["message"] = "AIR1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "AIR2",
				},
			},
		},
		["LOST_1"] = {--
			["sequence"] = {
				{
					["message"] = "dlg20a",
				},
				{
					["message"] = "dlg20b",
				},
			},
		},
		["LOST_2"] = {--
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
				{
					["message"] = "dlg21b",
				},
			},
		},
		["HERE"] = {--
			["sequence"] = {
				{
					["message"] = "HERE1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "HERE2",
				},
			},
		},
		["SHIPYARD"] = {--
			["sequence"] = {
				{
					["message"] = "SHIPYARD1",
				},
				{
					["message"] = "SHIPYARD2",
				},
			},
		},
		["AIRFIELD"] = {--
			["sequence"] = {
				{
					["message"] = "AIRFIELD1",
				},
				{
					["message"] = "AIRFIELD2",
				},
			},
		},
		["SECURED"] = {--
			["sequence"] = {
				{
					["message"] = "SECURED1",
				},
				{
					["message"] = "SECURED2",
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
	
	---- USN ----
	
	Mission.Shipyard = FindEntity("Shipyard")
	
	SetSkillLevel(Mission.Shipyard, Mission.SkillLevel)
	RepairEnable(Mission.Shipyard, false)
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("CB9"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB5"))
		table.insert(Mission.HQs, FindEntity("CB6"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("CB9_AF"))
		table.insert(Mission.Airfields, FindEntity("CB1_AF"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
	end
	
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Fortress element, Large 01"))
		table.insert(Mission.Fortresses, FindEntity("Fortress element, Large 02"))
		table.insert(Mission.Fortresses, FindEntity("Fortress element, Large 03"))
		table.insert(Mission.Fortresses, FindEntity("Fortress element, Large 04"))
		--table.insert(Mission.Fortresses, FindEntity("Fortress element, Large 05"))
	
	for idx,unit in pairs(Mission.Fortresses) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
	end
	
	---- IJN ----
	
	Mission.Bombers = {}
		table.insert(Mission.Bombers, FindEntity("Bomber_1"))
		table.insert(Mission.Bombers, FindEntity("Bomber_2"))
		table.insert(Mission.Bombers, FindEntity("Bomber_3"))
		table.insert(Mission.Bombers, FindEntity("Bomber_4"))
	
	for idx,unit in pairs(Mission.Bombers) do
		
		local pos = GetPosition(unit)
		pos.y = luaRnd(1100,1200)
		
		PutTo(unit, pos)
		
		SquadronSetTravelAlt(unit, pos.y, true)
		SquadronSetAttackAlt(unit, pos.y, true)	
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		SetRoleAvailable(unit, EROLF_PILOT, PLAYER_AI)
		SquadronForceGunnerMode(unit, true)
		UnitSetPlayerCommandsEnabled(unit, PCF_NONE)
		
		unit.IJN08_Phase1Target = Mission.Fortresses[idx]
		
		PilotSetTarget(unit, unit.IJN08_Phase1Target)
		
	end
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	--Mission.BomberNum = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.CatalinaDelay = 160
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.CatalinaDelay = 130
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.CatalinaDelay = 100
		
	end
	
	---- INIT FUNCT. ----
	
	--[[if table.getn(luaRemoveDeadsFromTable(Mission.Bombers)) > 0 then
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
		
			if unit and not unit.Dead then
			
				if not unit.IJN08_Discounted then
				
					Mission.BomberNum = Mission.BomberNum + luaGetSquadronPlaneNum(unit)
					
					unit.IJN08_Discounted = true
				
				end
			
			end
		
		end
	
	end]]
	
	EnableMessages(false)
	
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
	
	--luaShowPath(FindEntity("CVPath2"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
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
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				Mission.BomberNum = 0
				
				for idx, unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
					
					if unit and not unit.Dead then
					
						Mission.BomberNum = Mission.BomberNum + luaGetSquadronPlaneNum(unit)
					
					end
					
				end
				
				if Mission.BomberNum == 0 then
				
					luaMissionFailed()
				
				else
					
					if not Mission.Ph1ScoreOver then
					
						local line1 = "Escort the bomber wing to the target!"
						local line2 = "Bomber plane(s) left: #Mission.BomberNum#"
						luaDisplayScore(1, line1, line2)
					
					end
					
					if luaObj_IsActive("secondary", 1) then
					
						if Mission.BomberNum < 6 then
						
							luaObj_Failed("secondary", 1, true)
						
						end
					
					end
					
					for idx, unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
						
						if unit and not unit.Dead then
						
							if luaGetDistance(unit, unit.IJN08_Phase1Target) < 1100 and not Mission.CanMoveToPh2 then
							
								luaDelay(luaHidePh1Score, 1)
								
								luaObj_Completed("primary", 1, true)
								
								if luaObj_IsActive("secondary",1) then
									
									luaObj_Completed("secondary",1)
								
								end
								
								luaPh1EndMovie(unit, unit.IJN08_Phase1Target)
								
								Mission.PrepareToEnd = true
								Mission.Ph1ScoreOver = true
								Mission.CanMoveToPh2 = true
								
							end
						
						end
						
					end
					
					if not Mission.PrepareToEnd then
					
						if Mission.BomberNum < 12 and not Mission.Plane1LostDiaPlayed then
							
							luaStartDialog("LOST_1")
							
							Mission.Plane1LostDiaPlayed = true
						
						elseif Mission.BomberNum < 11 and not Mission.Plane2LostDiaPlayed then
							
							luaStartDialog("LOST_2")
							
							Mission.Plane2LostDiaPlayed = true
							
						end
					
					end
					
				end
				
			end
		
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary", 2) then
			
				local capped = 0
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						
						if not Mission.AirfieldCappedDiaPlayed then
						
							if unit.Name == "CB9" or unit.Name == "CB1" then
							
								luaStartDialog("SECURED")
								
								Mission.AirfieldCappedDiaPlayed = true
								
							end
						
						end
						
					end
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
						
						if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
							
							local fighters
							local bombers = {
								[1] = 108,
								[2] = 113,
							}
							
							if unit.Name == "Bon Homme Richard" then
							
								fighters = {
									[1] = 102,
								}
								
							else
							
								fighters = {
									[1] = 104,
									[2] = 330,
								}
								
								if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
								
									bombers[3] = 323
									bombers[4] = 118
								
								end
								
							end
							
							local trgs = luaGetUSPlaneTrg()
							
							luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
							
						end
					
					end
				
				end
				
				if capped == 4 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
					
						SetInvincible(unit, 0.01)
					
					end
					
					luaDelay(luaHidePh2Score, 1)
					HideUnitHP()
					
					luaObj_Completed("primary", 2)
					luaObj_Completed("primary", 3)
					
					luaMissionComplete()
					
				else
				
					Mission.BasesLeft = 4 - capped
				
					local line1 = "Capture all enemy bases!"
					local line2 = "Enemy base(s) left to capture: #Mission.BasesLeft#"
					luaDisplayScore(1, line1, line2)
				
				end
				
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTransports)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

function luaSYFlow()

	if Mission.MissionPhase == 2 then
		
		if Mission.Shipyard and not Mission.Shipyard.Dead and Mission.Shipyard.Party == PARTY_ALLIED then
		
			local spawnIdx = luaRnd(1,2)
			local trgs = luaGetUSPlaneTrg()
			local pos = GetPosition(FindEntity("ShipyardSpawn"))
			local unit
			
			if spawnIdx == 1 then
			
				unit = GenerateObject("Elco")
				
				NavigatorSetAvoidLandCollision(unit, true)
				TorpedoEnable(unit, true)
				
				NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
				
				UnitSetFireStance(unit, 2)
				
			elseif spawnIdx == 2 then
				
				unit = GenerateObject("Catalina")
				
				PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			end
			
			PutTo(unit, pos)
			
			SetSkillLevel(unit, Mission.SkillLevel)
			
			luaDelay(luaSYFlow, Mission.CatalinaDelay)
		
		end
		
	end

end

function luaHidePh2Score()

	HideScoreDisplay(1,0)

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.JapFleet
		
	elseif Mission.Difficulty == 2 then
		
		trgs = Mission.JapTransports
		
	end
	
	return trgs
	
end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
	
		if unit and not unit.Dead then
		
			Kill(unit, true)
		
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Fortresses)) do
	
		if unit and not unit.Dead then
		
			Kill(unit, true)
		
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.FirstFighters)) do
	
		if unit and not unit.Dead then
		
			Kill(unit, true)
		
		end
	
	end
	
	Mission.JapFleet = {}
		table.insert(Mission.JapFleet, GenerateObject("Ryujo"))
		table.insert(Mission.JapFleet, GenerateObject("Yamashiro"))
		--table.insert(Mission.JapFleet, GenerateObject("Hyuga"))
		table.insert(Mission.JapFleet, GenerateObject("Senjo"))
		table.insert(Mission.JapFleet, GenerateObject("Ibuki"))
		table.insert(Mission.JapFleet, GenerateObject("Kagero"))
		table.insert(Mission.JapFleet, GenerateObject("Yukikaze"))
		table.insert(Mission.JapFleet, GenerateObject("Arashi"))
		--table.insert(Mission.JapFleet, GenerateObject("Nowaki"))
		--table.insert(Mission.JapFleet, GenerateObject("Tanikaze"))
		--table.insert(Mission.JapFleet, GenerateObject("Hatsukaze"))
		--table.insert(Mission.JapFleet, GenerateObject("Maikaze"))
		--table.insert(Mission.JapFleet, GenerateObject("Akigumo"))
		table.insert(Mission.JapFleet, GenerateObject("Hawaii Maru"))
		table.insert(Mission.JapFleet, GenerateObject("Kitakami Maru"))
	
	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("Hawaii Maru"))
		table.insert(Mission.JapTransports, FindEntity("Kitakami Maru"))
		
	for idx,unit in pairs(Mission.JapFleet) do
		
		JoinFormation(unit, Mission.JapFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	if Mission.Difficulty < 2 then
		
		local sub = GenerateObject("I-48")
		
		SetSkillLevel(sub, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(sub, true)
		NavigatorSetAvoidLandCollision(sub, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(sub, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(sub, false)
		
		end
		
	end
	
	local pathIdx = luaRnd(1,2)
	local pathDirIdx = luaRnd(1,2)
	local path
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	Mission.BBFleet = {}
		table.insert(Mission.BBFleet, GenerateObject("Indiana"))
		--table.insert(Mission.BBFleet, GenerateObject("Mississippi"))
		--table.insert(Mission.BBFleet, GenerateObject("Boston"))
		table.insert(Mission.BBFleet, GenerateObject("Kenneth D. Bailey"))
		table.insert(Mission.BBFleet, GenerateObject("Epperson"))
		--table.insert(Mission.BBFleet, GenerateObject("Meredith"))
		--table.insert(Mission.BBFleet, GenerateObject("Robert H. Smith"))
		
	for idx,unit in pairs(Mission.BBFleet) do
		
		JoinFormation(unit, Mission.BBFleet[1])
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
	
	NavigatorMoveOnPath(Mission.BBFleet[1], FindEntity("BBPath"), PATH_FM_CIRCLE, pathDir)
	
	Mission.CVFleet = {}
		table.insert(Mission.CVFleet, GenerateObject("Bon Homme Richard"))
		table.insert(Mission.CVFleet, GenerateObject("Reno"))
		table.insert(Mission.CVFleet, GenerateObject("Frank E. Evans"))
		
	table.insert(Mission.Airfields, FindEntity("Bon Homme Richard"))
	
	for idx,unit in pairs(Mission.CVFleet) do
		
		JoinFormation(unit, Mission.CVFleet[1])
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
	
	if Mission.Difficulty == 0 then
	
		SetAirBaseSlotCount(Mission.CVFleet[1], 2)
		
	elseif Mission.Difficulty == 1 then
		
		SetAirBaseSlotCount(Mission.CVFleet[1], 3)
		
	elseif Mission.Difficulty == 2 then
		
		SetAirBaseSlotCount(Mission.CVFleet[1], 3)
		
	end
	
	local moveX
	local moveY
	
	if pathIdx == 1 then
		
		moveX = 0
		moveY = 7000
		path = FindEntity("CVPath1")
	
	elseif pathIdx == 2 then
		
		moveX = 7000
		moveY = 0
		path = FindEntity("CVPath2")
	
	end
	
	for idx,unit in pairs(Mission.CVFleet) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
	end
	
	NavigatorMoveOnPath(Mission.CVFleet[1], path, PATH_FM_CIRCLE, pathDir)
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapFleet) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end]]
	
	luaDelay(luaHereDia, 2)
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.JapFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaPh2MovieEnd, true)
	
end

function luaHereDia()

	luaStartDialog("HERE")

end

function luaPh2MovieEnd()
	
	SetSelectedUnit(Mission.JapFleet[1])
	
	Mission.CanMusicCheck = true
	
	luaDelay(luaAddSecondObjs, 3)
	
end

function luaAddSecondObjs()

	luaObj_Add("primary", 2, Mission.HQs)
	luaObj_Add("primary", 3, Mission.JapTransports)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTransports), "Protect your transports!")
	
	luaAddShipyardListener()
	luaAddAirfieldListener()
	
	luaSYFlow()
	
end

function luaFailHidden()

	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end

end

---- PHASE 1 ----

function luaPh1EndMovie(unit, fortress)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 30, ["theta"] = -10, ["rho"] = 35, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 27, ["theta"] = -6, ["rho"] = 62, ["moveTime"] = 3, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 25, ["theta"] = -8, ["rho"] = 80, ["moveTime"] = 5, ["smoothtime"] = 3},
		
		{["postype"] = "cameraandtarget", ["target"] = fortress, ["distance"] = 440, ["theta"] = 15, ["rho"] = 210, ["moveTime"] = 0, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = fortress, ["distance"] = 420, ["theta"] = 12, ["rho"] = 200, ["moveTime"] = 5, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = fortress, ["distance"] = 400, ["theta"] = 10, ["rho"] = 180, ["moveTime"] = 7},
		
	}, luaPh1EndMovieEnd, true)

end

function luaPh1EndMovieEnd()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

function luaIntroMovie1()

	Blackout(false, "", 1)
	
	local trg1 = FindEntity("CB9")
	
	luaDelay(luaIntroText, 4)
	luaDelay(luaIntroDia1, 11)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=2000,["y"]=250,["z"]=8000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=7500,["y"]=250,["z"]=6000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=7500,["y"]=250,["z"]=6000},["parent"] = nil,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 4000, ["theta"] = 10, ["rho"] = 255, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 25, ["rho"] = 235, ["moveTime"] = 16},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 10, ["rho"] = 170, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 280, ["moveTime"] = 16},
		
	}, luaIntroMovie2, true)
	
end

function luaIntroText()

	MissionNarrative("June 6th, 1942 - Aleutian Islands")

end

function luaIntroDia1()

	luaStartDialog("INTRO_1")

end

function luaIntroMovie2()

	Blackout(true, "luaIntroDia2", 1)
	
	--luaDelay(luaIntroDia2, 2)
	
end

function luaIntroDia2()

	luaStartDialog("INTRO_2")

end

function luaIntroMovie3()
	
	Blackout(false, "", 0.1)
	
	local trg1 = FindEntity("Bomber_1")
	
	Music_Control_SetLevel(MUSIC_CUSTOM3)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM3)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 45, ["theta"] = -2, ["rho"] = 20, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 45, ["theta"] = -2, ["rho"] = 30, ["moveTime"] = 9},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 65, ["theta"] = 4, ["rho"] = 220, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 65, ["theta"] = 5, ["rho"] = 240, ["moveTime"] = 9},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 65, ["theta"] = 5, ["rho"] = 240, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 120, ["theta"] = 5, ["rho"] = 240, ["moveTime"] = 9},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Bomber_1"))
	
	Blackout(false, "", 2)
	
	EnableMessages(true)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)
	luaObj_Add("secondary", 1, Mission.Bombers)
	luaObj_Add("hidden", 1)
	
	Mission.FirstFighters = {}
		table.insert(Mission.FirstFighters, FindEntity("US_Fighter_1"))
		table.insert(Mission.FirstFighters, FindEntity("US_Fighter_2"))
		table.insert(Mission.FirstFighters, FindEntity("US_Fighter_3"))
		table.insert(Mission.FirstFighters, FindEntity("US_Fighter_4"))
	
	for idx,unit in pairs(Mission.FirstFighters) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.Bombers)))
		
	end
	
	LaunchSquadron(FindEntity("CB9_AF"), 330, 3)
	
	--luaAddBomberKillListener()
	--luaAddShipyardListener()
	--luaAddAirfieldListener()
	
	luaDelay(luaFailHidden, 1800)
	
end

---- LISTENERS ----

function luaAddAirfieldListener()

	AddListener("recon", "AirfieldListener", {
		["callback"] = "luaAirfieldSighted",
		["entity"] = Mission.Airfields,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddShipyardListener()

	AddListener("recon", "ShipyardListener", {
		["callback"] = "luaShipyardSighted",
		["entity"] = {Mission.Shipyard},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

--[[function luaAddBomberKillListener()

	AddListener("kill", "BomberKillListener", {
		["callback"] = "luaBomberKilled",
		["entity"] = Mission.Bombers,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})

end]]

---- LISTENER CALLBACKS ----

function luaAirfieldSighted()

	RemoveListener("recon", "AirfieldListener")
	
	luaStartDialog("AIRFIELD")

end

function luaShipyardSighted()

	RemoveListener("recon", "ShipyardListener")
	
	luaStartDialog("SHIPYARD")

end

--[[function luaBomberKilled()

	Mission.BomberNum = Mission.BomberNum - 1

end]]

---- MISSION ENDERS ----

function luaMissionComplete()
	
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
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "The Aleutians have been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Score, 1)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh2Score, 1)
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
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