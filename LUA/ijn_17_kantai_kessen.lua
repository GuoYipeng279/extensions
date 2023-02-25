---- TAKING THE FIJIS (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- TAKING THE FIJIS (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(392) 	-- P51
	PrepareClass(318) 	-- F8F
	PrepareClass(38) 	-- SB2C
	PrepareClass(331) 	-- BTD
	PrepareClass(116) 	-- B17
	
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
	
	LoadMessageMap("ijndlg",11)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_17_kantai_kessen.lua"

	this.Name = "IJN17"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Crago",
				["Text"] = "Sink the fleeing cargo ships!",
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
				["ID"] = "Trans",
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
				["ID"] = "BB",
				["Text"] = "Sink the enemy escort carriers!",
				["TextCompleted"] = "Enemy carriers are sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "LST",
				["Text"] = "Ensure the survival of LST N. 67!",
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
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "idlg02",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "CARGO1",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "CARGO2",
				},
			},
		},
		["TROOP"] = {--
			["sequence"] = {
				{
					["message"] = "TROOP1",
				},
				{
					["message"] = "TROOP2",
				},
			},
		},
		["RANGE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["SECURED"] = {--
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["ESCORT"] = {--
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["COWARDS"] = {--
			["sequence"] = {
				{
					["message"] = "COWARDS1",
				},
				{
					["message"] = "COWARDS2",
				},
			},
		},
		["HORNET"] = {--
			["sequence"] = {
				{
					["message"] = "HORNET1",
				},
			},
		},
	}
	
	---- DIFFICULTY SETTING ----
	
	Mission.Difficulty = GetDifficulty()
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPVETERAN
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
	
	Mission.Bombers = {}
		table.insert(Mission.Bombers, FindEntity("Bomber_1"))
		table.insert(Mission.Bombers, FindEntity("Bomber_2"))
		table.insert(Mission.Bombers, FindEntity("Bomber_3"))
		table.insert(Mission.Bombers, FindEntity("Bomber_4"))
		table.insert(Mission.Bombers, FindEntity("Bomber_5"))
		table.insert(Mission.Bombers, FindEntity("Bomber_6"))
	
	for idx,unit in pairs(Mission.Bombers) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
	end
	
	Mission.JapShips = {}
	Mission.JapCapitalShips = {}
	
	---- USN ----
	
	Mission.Shipyard = FindEntity("Shipyard 02")
	
	SetSkillLevel(Mission.Shipyard, Mission.SkillLevel)
	RepairEnable(Mission.Shipyard, true)
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ1"))
		table.insert(Mission.HQs, FindEntity("HQ2"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB3"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, true)
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
	end
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA") or string.find(unit.Name, "Coastal Gun") or string.find(unit.Name, "Fortress")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.Convoy = {}
		table.insert(Mission.Convoy, FindEntity("Cargo-01"))
		table.insert(Mission.Convoy, FindEntity("Cargo-02"))
		table.insert(Mission.Convoy, FindEntity("Cargo-03"))
		table.insert(Mission.Convoy, FindEntity("Cargo-04"))
		table.insert(Mission.Convoy, FindEntity("Cargo-05"))
		table.insert(Mission.Convoy, FindEntity("Cargo-06"))
		table.insert(Mission.Convoy, FindEntity("Fletcher-class07"))
		table.insert(Mission.Convoy, FindEntity("Fletcher-class08"))
		
	for idx,unit in pairs(Mission.Convoy) do
		
		JoinFormation(unit, Mission.Convoy[1])
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
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Cargo-01"))
		table.insert(Mission.Cargos, FindEntity("Cargo-02"))
		table.insert(Mission.Cargos, FindEntity("Cargo-03"))
		table.insert(Mission.Cargos, FindEntity("Cargo-04"))
		table.insert(Mission.Cargos, FindEntity("Cargo-05"))
		table.insert(Mission.Cargos, FindEntity("Cargo-06"))
		
	for idx,unit in pairs(Mission.Cargos) do
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.USPatrolA = {}
		table.insert(Mission.USPatrolA, FindEntity("Guam"))
		table.insert(Mission.USPatrolA, FindEntity("Fletcher-class01"))
		table.insert(Mission.USPatrolA, FindEntity("Fletcher-class02"))
		
	for idx,unit in pairs(Mission.USPatrolA) do
		
		JoinFormation(unit, Mission.USPatrolA[1])
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
	
	Mission.USPatrolB = {}
		table.insert(Mission.USPatrolB, FindEntity("Alaska"))
		table.insert(Mission.USPatrolB, FindEntity("Fletcher-class03"))
		table.insert(Mission.USPatrolB, FindEntity("Fletcher-class04"))
		
	for idx,unit in pairs(Mission.USPatrolB) do
		
		JoinFormation(unit, Mission.USPatrolB[1])
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
	
	Mission.USPatrolC = {}
		table.insert(Mission.USPatrolC, FindEntity("Hawaii"))
		table.insert(Mission.USPatrolC, FindEntity("Fletcher-class05"))
		table.insert(Mission.USPatrolC, FindEntity("Fletcher-class06"))
		
	for idx,unit in pairs(Mission.USPatrolC) do
		
		JoinFormation(unit, Mission.USPatrolC[1])
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
	
	Mission.USPatrols = {Mission.USPatrolA, Mission.USPatrolB, Mission.USPatrolC}
	Mission.USInitShips = luaSumTablesIndex(Mission.USPatrolA, Mission.USPatrolB, Mission.USPatrolC)
	
	Mission.USCVs = {}
	Mission.InitMustangs = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
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
	
	local spawnIdx = luaRnd(1,2)
	local planeName
	
	if spawnIdx == 1 then
	
		planeName = "Mustang_1"
	
	elseif spawnIdx == 2 then
	
		planeName = "Mustang_2"
	
	end
	
	local plane = GenerateObject(planeName)
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Bombers))
	
	SetSkillLevel(plane, Mission.SkillLevel)
	EntityTurnToEntity(plane, trg)
	
	luaSetScriptTarget(plane, trg)
	PilotSetTarget(plane, trg)
	
	table.insert(Mission.InitMustangs, plane)
	
	for idx,unit in pairs(Mission.Bombers) do
		
		PilotSetTarget(unit, Mission.Cargos[idx])
		
	end
	
	NavigatorMoveOnPath(Mission.USPatrolA[1], FindEntity("PatrolPath1"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(Mission.USPatrolB[1], FindEntity("PatrolPath2"), PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS)
	NavigatorMoveOnPath(Mission.USPatrolC[1], FindEntity("PatrolPath3"), PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS)
	
	EnableMessages(false)
	
	MissionNarrative("November 15th, 1943 - Fijian Islands")
	
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
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
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
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Cargos)) == 0 then
					
					HideUnitHP()
					
					luaObj_Completed("primary", 1, true)
					
					luaPh1FadeOut()
				
				else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Bombers)) == 0 then
						
						--[[local failure
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cargos)) do
				
							if unit and not unit.Dead then
							
								local fire = GetFailure(unit, "Fire")
								
								if fire then
								
									failure = true
								
								end
								
							end
							
						end
						
						if not failure then]]
						
							luaMissionFailed()
						
						--end
						
					end
				
				end
				
			end
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
			
				local capped = 0
				local canPlayDia
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						
						if unit.Name == "HQ1" or unit.Name == "HQ2" or unit.Name == "CB3" then
						
							canPlayDia = true
						
						end
						
					end
				
				end
				
				if capped == 5 then
					
					if not Mission.WhyYouDoThisToMeee then
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
						
							SetInvincible(unit, 0.01)
						
						end
						
						HideUnitHP()
						luaDelay(luaHidePh1Score, 1)
						
						luaObj_Completed("primary", 2)
						luaObj_Completed("primary", 3)
						
						luaMissionComplete()
						
						Mission.WhyYouDoThisToMeee = true
						
					end
					
				else
				
					Mission.BasesLeft = 5 - capped
				
					local line1 = "Capture all enemy bases!"
					local line2 = "Enemy base(s) left to capture: #Mission.BasesLeft#"
					luaDisplayScore(1, line1, line2)
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
				
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
							
							if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
								
								local fighters
								local bombers = {
									[1] = 38,
									[2] = 331,
								}
								
								if unit.Name == "Vermillion" or unit.Name == "Croatan" then
								
									fighters = {
										[1] = 318,
									}
									
								else
								
									fighters = {
										[1] = 392,
									}
									
									if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
										
										bombers[3] = 116
										
									end
									
								end
								
								local trgs = luaGetUSPlaneTrg()
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
								
							end
						
						end
					
					end
					
					if capped >= 3 then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.USInitShips)) <= 3 and not Mission.USCVsHere then
						
							luaSpawnUSCVs()
						
						end
					
					end
					
					if not Mission.FirstAFDiaPlayed then
					
						if canPlayDia then
							
							luaStartDialog("SECURED")
							
							Mission.FirstAFDiaPlayed = true
						
						end
						
					end
					
				end
				
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTransports)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 0 then
				
					luaObj_Completed("secondary", 1, true)
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Convoy)) do
			
							if unit and not unit.Dead then
								
								NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))
								
							end
						
						end
						
						luaStartDialog("COWARDS")
						
					end
					
				end
			
			end
			
			--[[if luaObj_IsActive("hidden", 1) then
			
				if Mission.CommandSub.Dead then
				
					luaObj_Completed("hidden", 1)
				
				end
			
			end]]
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

function luaSYFlow()

	if not Mission.EndMission then
		
		if Mission.Shipyard and not Mission.Shipyard.Dead and Mission.Shipyard.Party == PARTY_ALLIED then
		
			local spawnIdx = 2
			local trgs = luaGetUSPlaneTrg()
			local pos = GetPosition(Mission.Shipyard)
			pos.x = pos.x - 150
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

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.JapShips
		
	elseif Mission.Difficulty == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
		
			trgs = Mission.JapCapitalShips
		
		else
		
			trgs = Mission.JapShips
		
		end
		
	end
	
	return trgs
	
end

function luaAddFinalObjs()

	luaObj_Add("secondary", 1, Mission.USCVs)

end

function luaSpawnUSCVs()

	Mission.USCVsHere = true
	
	Mission.CVFleet = {}
		--table.insert(Mission.CVFleet, GenerateObject("Illinois"))
		table.insert(Mission.CVFleet, GenerateObject("Vermillion"))
		table.insert(Mission.CVFleet, GenerateObject("Croatan"))
		table.insert(Mission.CVFleet, GenerateObject("Fletcher-class09"))
		table.insert(Mission.CVFleet, GenerateObject("Fletcher-class10"))
		--table.insert(Mission.CVFleet, GenerateObject("Fletcher-class11"))
		--table.insert(Mission.CVFleet, GenerateObject("Fletcher-class12"))
	
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
		
		if unit.Class.Type == "MotherShip" then
			
			if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 3)
				
			end
			
			table.insert(Mission.USCVs, unit)
			table.insert(Mission.Airfields, unit)
			
		end
		
	end
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVFleet[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	luaAddCVEListener()
	
end

function luaSpawnRein()

	Mission.InvasionHere = true
	
	Mission.JapInvasionFleet = {}
		table.insert(Mission.JapInvasionFleet, GenerateObject("Izumo"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Maya"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Atago"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Chokai"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Suzukaze"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Kawakaze"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Yamakaze"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Umikaze"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Samidare"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Harusame"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Yudachi"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Murasame"))
		--table.insert(Mission.JapInvasionFleet, GenerateObject("Shigure"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Brazil Maru"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("Nojima Maru"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("SB-01"))
		table.insert(Mission.JapInvasionFleet, GenerateObject("SB-02"))
	
	for idx,unit in pairs(Mission.JapInvasionFleet) do
		
		JoinFormation(unit, Mission.JapInvasionFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		if Mission.Debug then
		
			SetInvincible(unit, 0.4)
			
		end
		
		table.insert(Mission.JapShips, unit)
		
	end
	
	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("Brazil Maru"))
		table.insert(Mission.JapTransports, FindEntity("Nojima Maru"))
		table.insert(Mission.JapTransports, FindEntity("SB-01"))
		table.insert(Mission.JapTransports, FindEntity("SB-02"))
	
	table.insert(Mission.JapCapitalShips, FindEntity("Izumo"))
	table.insert(Mission.JapCapitalShips, FindEntity("Brazil Maru"))
	table.insert(Mission.JapCapitalShips, FindEntity("Nojima Maru"))
	table.insert(Mission.JapCapitalShips, FindEntity("SB-01"))
	table.insert(Mission.JapCapitalShips, FindEntity("SB-02"))
	
	Mission.HiddenLST = FindEntity("SB-02")
	
	SetSkillLevel(GenerateObject("Tabby"), Mission.SkillLevelOwn)
	PilotMoveToRange(FindEntity("Tabby"), Mission.JapInvasionFleet[1])
	
	luaDelay(luaReinDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.JapInvasionFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		
	}, luaReinMovieEnd, true)
	
end

function luaReinDia()

	luaStartDialog("TROOP")

end

function luaReinMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapInvasionFleet)))
	
	end
	
	luaAddThirdObjs()
	
end

function luaAddThirdObjs()

	luaObj_Add("primary", 3, Mission.JapTransports)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTransports), "Protect your transports!")
	
	luaAddAFListener()
	
end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Bombers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Convoy)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.InitMustangs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.InitMustangs)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	Mission.JapCVFleet = {}
		table.insert(Mission.JapCVFleet, GenerateObject("Kokuryu"))
		table.insert(Mission.JapCVFleet, GenerateObject("Shoho"))
		table.insert(Mission.JapCVFleet, GenerateObject("Yoshino"))
		table.insert(Mission.JapCVFleet, GenerateObject("Nowaki"))
		table.insert(Mission.JapCVFleet, GenerateObject("Kagero"))
		table.insert(Mission.JapCVFleet, GenerateObject("Hamakaze"))
		--table.insert(Mission.JapCVFleet, GenerateObject("Isokaze"))
		--table.insert(Mission.JapCVFleet, GenerateObject("Arashi"))
	
	for idx,unit in pairs(Mission.JapCVFleet) do
		
		JoinFormation(unit, Mission.JapCVFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		if Mission.Debug then
		
			SetInvincible(unit, 0.4)
			
		end
		
		table.insert(Mission.JapShips, unit)
		
	end
	
	Mission.JapCVs = {}
		table.insert(Mission.JapCVs, FindEntity("Kokuryu"))
		table.insert(Mission.JapCVs, FindEntity("Shoho"))
		
	table.insert(Mission.JapCapitalShips, FindEntity("Kokuryu"))
	table.insert(Mission.JapCapitalShips, FindEntity("Shoho"))
	
	if Mission.Difficulty < 2 then
	
		Mission.Sub = GenerateObject("I-111")
		
		SetSkillLevel(Mission.Sub, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(Mission.Sub, true)
		NavigatorSetAvoidLandCollision(Mission.Sub, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(Mission.Sub, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(Mission.Sub, false)
		
		end
		
		SetForcedReconLevel(Mission.Sub, 2, PARTY_ALLIED)
	
	end
	
	Mission.Subs = {}
		table.insert(Mission.Subs, GenerateObject("Flier"))
		table.insert(Mission.Subs, GenerateObject("Snook"))
	
	for idx,unit in pairs(Mission.Subs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
			SetUnlimitedAirSupply(unit, true)
			
		end
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVs))
		
		NavigatorAttackMove(unit, trg)
		
		UnitSetFireStance(unit, 2)
		
	end
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	local trg1 = Mission.JapCVFleet[1]
	
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

function luaPh2MovieEnd()

	SetSelectedUnit(Mission.JapCVFleet[1])
	
	Mission.CanMusicCheck = true
	
	luaAddSecObjs()
	luaSYFlow()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.HQs)
	
	luaDelay(luaSpawnRein, 300)
	Countdown("The Invasion Fleet arrives in: ", 0, 300)
	
	if Mission.Difficulty < 2 then
	
		luaStartDialog("HORNET")
	
	end
	
end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

---- PHASE 1 ----

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaIntroMovie1()

	luaDelay(luaIntroDia, 3)
	
	local trg1 = FindEntity("HQ1")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=900,["y"]=30,["z"]=4000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=30,["z"]=3800},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=700,["y"]=27,["z"]=3800},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=220,["y"]=25,["z"]=100},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=25,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=25,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=200,["y"]=30,["z"]=100},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	Music_Control_SetLevel(MUSIC_CUSTOM3)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM3)
	
	local trg1 = Mission.Convoy[1]
	local trg2 = Mission.Bombers[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 7, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 65, ["theta"] = 4, ["rho"] = 190, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 65, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 7},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Bombers[1])
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Cargos)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Cargos), "Sink the fleeing cargo ships!")

end

---- LISTENERS ----

function luaAddAFListener()

	AddListener("recon", "AFListener", {
		["callback"] = "luaAFSighted",
		["entity"] = Mission.Airfields,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddCVEListener()

	AddListener("recon", "CVEListener", {
		["callback"] = "luaCVESighted",
		["entity"] = Mission.USCVs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaAFSighted()

	RemoveListener("recon", "AFListener")
	
	luaStartDialog("RANGE")
	
end

function luaCVESighted()

	RemoveListener("recon", "CVEListener")
	
	luaStartDialog("ESCORT")
	
end

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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if Mission.HiddenLST and not Mission.HiddenLST.Dead then
		
			luaObj_Completed("hidden",1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
		
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "The Fijis have been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh1Score, 1)
		
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