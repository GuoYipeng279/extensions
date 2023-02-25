---- RAID ON SYDNEY (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- RAID ON SYDNEY (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(77) 	-- Jap PT
	
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
	
	LoadMessageMap("ijndlg",10)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_12_sydney.lua"

	this.Name = "IJN12"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Cruiser",
				["Text"] = "Cripple the enemy cruisers by reducing their integrity to below 50%!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Cap",
				["Text"] = "Capture the crippled enemy cruisers using your Commandos!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Dest",
				["Text"] = "Sink all enemy cargo ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "BB",
				["Text"] = "Sink the enemy battleship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Rocket",
				["Text"] = "Sink the enemy rocket ships!",
				["TextCompleted"] = "You've sunk all enemy rocket ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Surv",
				["Text"] = "Ensure the survival of both captured cruisers!",
				["TextFailed"] = "You've lost one of the captured cruisers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Radar",
				["Text"] = "Retrieve secret plans from the hidden Radar Station by capturing it!",
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
					["type"] = "pause",
					["time"] = 5,
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 9,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "INTRO2",
				},
				{
					["message"] = "INTRO3",
				},
				{
					["type"] = "pause",
					["time"] = 3.5,
				},
				{
					["message"] = "INTRO4",
				},
				{
					["message"] = "INTRO5",
				},
			},
		},
		["TANKER"] = {--
			["sequence"] = {
				{
					["message"] = "TANKER1",
				},
				{
					["message"] = "dlg9",
				},
			},
		},
		["CRUISERS"] = {--
			["sequence"] = {
				{
					["message"] = "CRUISERS1",
				},
			},
		},
		["HERE"] = {--
			["sequence"] = {
				{
					["message"] = "HERE1",
				},
				{
					["message"] = "HERE2",
				},
			},
		},
		["MINES"] = {--
			["sequence"] = {
				{
					["message"] = "MINES1",
				},
			},
		},
		["RADAR1"] = {--
			["sequence"] = {
				{
					["message"] = "RADAR1",
				},
				{
					["message"] = "RADAR2",
				},
			},
		},
		["RADAR2"] = {--
			["sequence"] = {
				{
					["message"] = "RADAR3",
				},
				{
					["message"] = "RADAR4",
				},
			},
		},
		["CARGO"] = {--
			["sequence"] = {
				{
					["message"] = "CARGO1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh3FadeOut",
				},
			},
		},
		["BB"] = {--
			["sequence"] = {
				{
					["message"] = "BB1",
				},
				{
					["message"] = "BB2",
				},
			},
		},
		["ALMOST"] = {--
			["sequence"] = {
				{
					["message"] = "ALMOST1",
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
	
	Mission.AIShips = {}
		table.insert(Mission.AIShips, FindEntity("Ise"))
		table.insert(Mission.AIShips, FindEntity("Tone"))
		table.insert(Mission.AIShips, FindEntity("Chikuma"))
	
	for idx,unit in pairs(Mission.AIShips) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		SetInvincible(unit, 0.8)
		
	end
	
	if Mission.Difficulty < 2 then
		
		Mission.MiniSubs = {}
		
		table.insert(Mission.MiniSubs, GenerateObject("MiniSub-01"))
		table.insert(Mission.MiniSubs, GenerateObject("MiniSub-02"))
		table.insert(Mission.MiniSubs, GenerateObject("MiniSub-03"))
		
		for idx,unit in pairs(Mission.MiniSubs) do
		
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
		
	end
	
	Mission.RaiderPlanes = {}
	Mission.Raiders = {}
	Mission.Commandos = {}
	
	---- USN ----
	
	Mission.RadarStation = FindEntity("RadarStation")
	
	OverrideHP(Mission.RadarStation, 100)
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Cargo-01"))
		table.insert(Mission.Cargos, FindEntity("Cargo-02"))
		table.insert(Mission.Cargos, FindEntity("Cargo-03"))
		table.insert(Mission.Cargos, FindEntity("Cargo-04"))
		table.insert(Mission.Cargos, FindEntity("Cargo-05"))
		table.insert(Mission.Cargos, FindEntity("Cargo-06"))
		table.insert(Mission.Cargos, FindEntity("Cargo-07"))
		table.insert(Mission.Cargos, FindEntity("Cargo-08"))
		table.insert(Mission.Cargos, FindEntity("Cargo-09"))
		table.insert(Mission.Cargos, FindEntity("Cargo-10"))
		table.insert(Mission.Cargos, FindEntity("Tanker-01"))
		table.insert(Mission.Cargos, FindEntity("Tanker-02"))
	
	for idx,unit in pairs(Mission.Cargos) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.LSTs = {}
		table.insert(Mission.LSTs, FindEntity("LST-01"))
		table.insert(Mission.LSTs, FindEntity("LST-02"))
		table.insert(Mission.LSTs, FindEntity("LST-03"))
		table.insert(Mission.LSTs, FindEntity("LST-04"))
		table.insert(Mission.LSTs, FindEntity("LST-05"))
		table.insert(Mission.LSTs, FindEntity("LST-06"))
		table.insert(Mission.LSTs, FindEntity("LST-07"))
		table.insert(Mission.LSTs, FindEntity("LST-08"))
		table.insert(Mission.LSTs, FindEntity("LST-09"))
		table.insert(Mission.LSTs, FindEntity("LST-10"))
		table.insert(Mission.LSTs, FindEntity("LSM-01"))
		table.insert(Mission.LSTs, FindEntity("LSM-02"))
	
	for idx,unit in pairs(Mission.LSTs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.LSMs = {}
		table.insert(Mission.LSMs, FindEntity("LSM-01"))
		table.insert(Mission.LSMs, FindEntity("LSM-02"))
	
	Mission.PTs = {}
		table.insert(Mission.PTs, FindEntity("Elco-01"))
		table.insert(Mission.PTs, FindEntity("Elco-02"))
		table.insert(Mission.PTs, FindEntity("Elco-03"))
		table.insert(Mission.PTs, FindEntity("Elco-04"))
		table.insert(Mission.PTs, FindEntity("Elco-05"))
		table.insert(Mission.PTs, FindEntity("Elco-06"))
		table.insert(Mission.PTs, FindEntity("Elco-07"))
		table.insert(Mission.PTs, FindEntity("Elco-08"))
	
	for idx,unit in pairs(Mission.PTs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.PatrollingAKs = {}
		table.insert(Mission.PatrollingAKs, FindEntity("Tanker-01"))
		table.insert(Mission.PatrollingAKs, FindEntity("Tanker-02"))
	
	Mission.Cruisers = {}
		table.insert(Mission.Cruisers, FindEntity("Shropshire"))
		table.insert(Mission.Cruisers, FindEntity("Hobart"))
	
	for idx,unit in pairs(Mission.Cruisers) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		--SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
		SetInvincible(unit, 0.01)
		
	end
	
	Mission.DDs = {}
		table.insert(Mission.DDs, FindEntity("Nepal"))
		table.insert(Mission.DDs, FindEntity("Voyager"))
		table.insert(Mission.DDs, FindEntity("Norman"))
		table.insert(Mission.DDs, FindEntity("Nizam"))
		table.insert(Mission.DDs, FindEntity("Arunta"))
		table.insert(Mission.DDs, FindEntity("Warramunga"))
	
	for idx,unit in pairs(Mission.DDs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.Yacht1 = FindEntity("Yacht 01")
	Mission.Yacht2 = FindEntity("Yacht 02")
	Mission.Yacht1.Path = FindEntity("CivilPath1")
	Mission.Yacht2.Path = FindEntity("CivilPath2")
	
	Mission.Yachts = {}
		table.insert(Mission.Yachts, Mission.Yacht1)
		table.insert(Mission.Yachts, Mission.Yacht2)
	
	Mission.USUnits = luaSumTablesIndex(Mission.Cargos, Mission.LSTs, Mission.PTs, Mission.Cruisers, Mission.DDs)
	
	---- VAR ----
	
	Mission.CommandoGoTo = FindEntity("CommandoGoTo")
	
	Mission.PatrolPaths = {}
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 01"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 02"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 03"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 04"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 01"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 02"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 03"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath 04"))
	
	Mission.AKPatrolPaths = {}
		table.insert(Mission.AKPatrolPaths, FindEntity("AKMovingInPath"))
		table.insert(Mission.AKPatrolPaths, FindEntity("AKMovingInPath"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Ph1TimeLimit = 180
	Mission.Ph2TimeLimit = 650
	Mission.Ph3TimeLimit = 500
	Mission.CappedCruisers = 0
	Mission.WavesSpawned = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.WavesAllowed = 3
		Mission.PlaneDelay = 220
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.WavesAllowed = 2
		Mission.PlaneDelay = 150
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.WavesAllowed = 1
		Mission.PlaneDelay = 150
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	SetVisibilityTerrainNode("Sydney:zone_01", false)
	
	MissionNarrative("February 1st, 1943 - Sydney Harbor")
	
	Blackout(true, "", true)
	
	--luaInitPortTraffic()
	
	SetSimplifiedReconMultiplier(0.5)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--luaTEST1()
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(Mission.CommandoGoTo)
	
	--luaShowPath(FindEntity("PatrolPath 02"))
	
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
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.LSMs)) == 0 then
				
					luaObj_Completed("secondary",1,true)
				
				end
			
			end
			
			if luaObj_IsActive("secondary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) == 1 then
				
					luaObj_Failed("secondary",2,true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.RadarStation.Party == PARTY_JAPANESE then
				
					luaObj_Completed("hidden",1)
					
					luaStartDialog("RADAR2")
				
				end
			
			end
			
			--if Mission.Difficulty < 2 then
			
				if Mission.MissionPhase > 1 then
				
					local planes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 60000, PARTY_JAPANESE, "own")
					
					if planes and table.getn(luaRemoveDeadsFromTable(planes)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(planes)) do
						
							if unit and not unit.Dead then
							
								if not unit.IJN12_AltSet then
									
									SquadronSetTravelAlt(unit, 80, true)
									SquadronSetAttackAlt(unit, 80, true)
									
									unit.IJN12_AltSet = true
								
								end
							
							end
						
						end
					
					end
					
				end
			
			--end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) < 2 then
				
					luaMissionFailed()
				
				--[[else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.RaiderPlanes)) == 0 then
					
						luaSpawnNextPlaneWave()
					
					end]]
					
				end
				
			end
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) < 2 then
				
					luaMissionFailed()
				
				else
					
					if Mission.CappedCruisers < 2 then
						
						if Mission.WavesSpawned == Mission.WavesAllowed then
						
							if table.getn(luaRemoveDeadsFromTable(Mission.Commandos)) == 0 then
							
								luaMissionFailed()
							
							end
						
						end
						
						local cruiser1percentage = 1.0
						local cruiser2percentage = 1.0
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cruisers)) do
				
							if unit and not unit.Dead then
							
								if not unit.IJN12_Capped then
								
									local shipsAround = luaGetShipsAroundCoordinate(GetPosition(unit), 120, PARTY_JAPANESE, "own")
									local commandoTable = {}
									
									if shipsAround and table.getn(luaRemoveDeadsFromTable(shipsAround)) > 0 then
									
										local commandosAround = 0
										local percentageIncrement = 0.01
										
										for idx2,unit2 in pairs(luaRemoveDeadsFromTable(shipsAround)) do
										
											if unit2.Class.ID == 90 then
											
												commandosAround = commandosAround + percentageIncrement
												
												table.insert(commandoTable, unit2)
												
											end
										
										end
										
										if commandosAround > 0 then
										
											SetHP(unit, (GetHpPercentage(unit) + commandosAround) * unit.Class.HP)
										
										end
										
									end
									
									local percentage = GetHpPercentage(unit)
									
									if percentage == 1.0 then
										
										SetInvincible(unit, false)
										AAEnable(unit, true)
										
										SetHP(unit, (unit.IJN12_PreviousHP * unit.Class.HP))
										
										SetParty(unit, PARTY_JAPANESE)
										
										SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
										NavigatorSetTorpedoEvasion(unit, true)
										NavigatorSetAvoidLandCollision(unit, true)
										RepairEnable(unit, false)
										
										for idx3,commando in pairs(luaRemoveDeadsFromTable(commandoTable)) do
										
											if commando and not commando.Dead then
											
												Kill(commando, true)
											
											end
										
										end
										
										Mission.CappedCruisers = Mission.CappedCruisers + 1
										
										unit.IJN12_Capped = true
									
									end
									
									if idx == 1 then
									
										cruiser1percentage = percentage
									
									else
									
										cruiser2percentage = percentage
									
									end
									
								end
							
							end
							
						end
						
						Mission.C1Status = string.format("%.0f",(cruiser1percentage * 100))
						Mission.C2Status = string.format("%.0f",(cruiser2percentage * 100))
						
						local line1 = "Capture the crippled enemy cruisers using your Commandos!"
						local line2 = "HMAS Shropshire status: #Mission.C1Status#% | HMAS Hobart status: #Mission.C2Status#%"
						luaDisplayScore(1, line1, line2)
						
						--[[Mission.WavesLeft = Mission.WavesAllowed - Mission.WavesSpawned
						
						local line1_2 = "Commando wave(s) left: #Mission.WavesLeft#"
						local line2_2 = ""
						luaDisplayScore(2, line1_2, line2_2)]]
						
					else
						
						--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cruisers)) do
						
							if unit and not unit.Dead then
							
								SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
								NavigatorSetTorpedoEvasion(unit, true)
								NavigatorSetAvoidLandCollision(unit, true)
								RepairEnable(unit, false)
							
							end
						
						end]]
						
						luaDelay(luaHidePh2Scores, 1)
						--luaDelay(luaHidePh2Scores2, 1)
						
						luaObj_Completed("primary", 2, true)
						
						luaMoveToPh3()
						--Blackout(true, "luaMoveToPh3", 3)
					
					end
				
				end
				
			end
		
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) == 0 then
				
					luaMissionFailed()
				
				else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Cargos)) == 0 then
					
						HideUnitHP()
					
						luaObj_Completed("primary", 3, true)
						
						luaStartDialog("CARGO")
						
					end
				
				end
				
			end
		
		elseif Mission.MissionPhase == 4 then
		
			if luaObj_IsActive("primary", 4) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) == 0 then
				
					luaMissionFailed()
				
				else
				
					if Mission.Australia.Dead then
					
						HideUnitHP()
						
						luaObj_Completed("primary", 4)
						
						luaMissionComplete()
						
					else
						
						if not Mission.AlmostDiaPlayed then
						
							local hp = GetHpPercentage(Mission.Australia)
							
							if hp <= 0.1 then
							
								luaStartDialog("ALMOST")
								
								Mission.AlmostDiaPlayed = true
							
							end
						
						end
						
					end
				
				end
				
			end
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 4 ----

function luaMoveToPh4()

	Mission.MissionPhase = 4
	
	Mission.Australia = GenerateObject("Australia")
	
	SetSkillLevel(Mission.Australia, Mission.SkillLevel)
	NavigatorSetTorpedoEvasion(Mission.Australia, true)
	NavigatorSetAvoidLandCollision(Mission.Australia, true)
	
	if Mission.Difficulty == 0 then
		
		TorpedoEnable(Mission.Australia, false)
		RepairEnable(Mission.Australia, false)
	
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		TorpedoEnable(Mission.Australia, true)
		RepairEnable(Mission.Australia, true)
	
	end
	
	Mission.CanMusicCheck = false
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaPh4Dia, 2)
	
	Blackout(false, "", 3)
	
	local trg1 = Mission.Australia
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 10, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	   
	}, luaPh4MovieEnd, true)
	
end

function luaPh4Dia()

	luaStartDialog("BB")

end

function luaPh4MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.Cruisers)))
	
	end
	
	luaAddFinalObjs()

end

function luaAddFinalObjs()

	luaObj_Add("primary", 4, Mission.Australia)
	
	DisplayUnitHP(luaRemoveDeadsFromTable({Mission.Australia}), "Sink the enemy battleship!")
	
end

---- PHASE 3 ----

function luaPh3Fail()

	if Mission.MissionPhase == 3 then
	
		luaMissionFailed()
	
	end

end

function luaPh3FadeOut()

	Blackout(true, "luaMoveToPh4", 3)

end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaAddThirdObjs()

end

function luaAddThirdObjs()

	luaObj_Add("primary", 3, luaRemoveDeadsFromTable(Mission.Cargos))
	luaObj_Add("secondary", 2, Mission.Cruisers)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Cargos), "Sink all enemy cargo ships!")
	
	luaDelay(luaPh3Fail, Mission.Ph3TimeLimit)
	Countdown("Time left: ", 0, Mission.Ph3TimeLimit)
	
end

---- PHASE 2 ----

function luaPlaneFlow()

	if Mission.MissionPhase > 1 then
		
		local planes = {}
		local trgs
		
		table.insert(planes, GenerateObject("Hurricane-01"))
		--table.insert(planes, GenerateObject("Hurricane-02"))
		
		if Mission.Difficulty > 1 then
		
			table.insert(planes, GenerateObject("Hurricane-03"))
		
		end
		
		if Mission.MissionPhase == 2 then
			
			trgs = Mission.Raiders
			
		else
		
			trgs = Mission.Cruisers
			
		end
		
		for idx,unit in pairs(planes) do
			
			local unitPos = GetPosition(unit)
	
			SquadronSetTravelAlt(unit, unitPos.y, true)
			SquadronSetAttackAlt(unit, unitPos.y, true)
			
			SetSkillLevel(unit, Mission.SkillLevel)
			
			if Mission.MissionPhase == 2 then
			
				PilotMoveToRange(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			else
			
				PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			end
			
			UnitSetFireStance(unit, 2)
			
		end
		
		luaDelay(luaPlaneFlow, Mission.PlaneDelay)
	
	end

end

function luaPh2Fail()

	if Mission.MissionPhase == 2 then
	
		luaMissionFailed()
	
	end

end

function luaHidePh2Scores()

	HideScoreDisplay(1,0)

end

--[[function luaHidePh2Scores2()

	HideScoreDisplay(2,0)

end]]

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	if table.getn(luaRemoveDeadsFromTable(Mission.RaiderPlanes)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.RaiderPlanes)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cruisers)) do
		
		if unit and not unit.Dead then
			
			unit.IJN12_PreviousHP = GetHpPercentage(unit)
			
			SetParty(unit, PARTY_NEUTRAL)
		
		end
	
	end
	
	luaWaveArrived()
	
	luaDelay(luaPh2Dia, 2)
	
	Blackout(false, "", 1)
	
	Mission.Ph2MovieTrg = Mission.FirstWave[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 180, ["theta"] = 15, ["rho"] = 100, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 30, ["theta"] = 7, ["rho"] = 180, ["moveTime"] = 10, ["smoothtime"] = 2},
		
	}, luaPh2MovieEnd, true)
	
end

function luaPh2Dia()

	luaStartDialog("HERE")

end

function luaPh2MovieEnd()
	
	--if Mission.Difficulty < 2 then
	
		for idx,unit in pairs(Mission.AIShips) do
		
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			SetRoleAvailable(unit, EROLE_CAPTAIN, PLAYER_ANY)
			UnitSetPlayerCommandsEnabled(unit, PCF_NONE)
			
		end
	
	--end
	
	SetSelectedUnit(Mission.Ph2MovieTrg)
	
	luaDelay(luaMinesDia, 10)
	luaDelay(luaPlaneFlow, Mission.PlaneDelay)
	
	luaAddSecObjs()

end

function luaMinesDia()

	luaStartDialog("MINES")

end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.Cruisers)
	
	luaDelay(luaPh2Fail, Mission.Ph2TimeLimit)
	Countdown("Time left: ", 0, Mission.Ph2TimeLimit)
	
	luaAddRadarListener()
	
	--luaSpawnAttackWave()
	
end

function luaWaveArrived()

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CurrentWave)) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		
	end
	
	if Mission.MissionPhase == 2 and Mission.WavesSpawned < Mission.WavesAllowed then
	
		luaSpawnAttackWave()
		
	end
	
	--[[if Mission.Difficulty < 2 then
	
		luaSpawnNextPlaneWave()
	
	end]]
	
end

function luaMakeWaveAttack()
	
	Mission.CurrentWave = luaRemoveDeadsFromTable(Mission.CurrentWave)
	
	NavigatorMoveToRange(Mission.CurrentWave[1], Mission.CommandoGoTo)

end

function luaSpawnAttackWave()
	
	local tmpTable = {}
	
	table.insert(tmpTable, GenerateObject("PT-01"))
	table.insert(tmpTable, GenerateObject("PT-02"))
	table.insert(tmpTable, GenerateObject("PT-03"))
	table.insert(tmpTable, GenerateObject("PT-04"))
	table.insert(tmpTable, GenerateObject("PT-05"))
	table.insert(tmpTable, GenerateObject("PT-06"))
	table.insert(tmpTable, GenerateObject("PT-07"))
	table.insert(tmpTable, GenerateObject("Commando-01"))
	table.insert(tmpTable, GenerateObject("Commando-02"))
	table.insert(tmpTable, GenerateObject("Commando-03"))
	table.insert(tmpTable, GenerateObject("Commando-04"))
	table.insert(tmpTable, GenerateObject("Commando-05"))
	table.insert(tmpTable, GenerateObject("Commando-06"))
	table.insert(tmpTable, GenerateObject("Commando-07"))
	table.insert(tmpTable, GenerateObject("Commando-08"))
	table.insert(tmpTable, GenerateObject("Commando-09"))
	table.insert(tmpTable, GenerateObject("Commando-10"))
	table.insert(tmpTable, GenerateObject("Commando-11"))
	table.insert(tmpTable, GenerateObject("Commando-12"))
	table.insert(tmpTable, GenerateObject("Commando-13"))
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(tmpTable)) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		JoinFormation(unit, tmpTable[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		table.insert(Mission.Raiders, unit)
		
		if unit.Class.ID == 90 then
		
			table.insert(Mission.Commandos, unit)
		
		end
		
	end
	
	Mission.CurrentWave = tmpTable
	
	if not Mission.IntroMovieUnitSet then
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Raiders)) do
		
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
		end]]
		
		Mission.IntroUnit = Mission.Raiders[1]
		
		Mission.FirstWave = tmpTable
		
		Mission.IntroMovieUnitSet = true
		
	else
	
		luaMakeWaveAttack()
		
		luaDelay(luaWaveArrived, 180)
		
	end
	
	--NavigatorMoveToRange(tmpTable[1], Mission.CommandoGoTo)
	
	--local nRnd = luaRnd(100, 999)
	--local szPTName = "ingame.shipnames_gyoraitei|."..nRnd
	
	Mission.WavesSpawned = Mission.WavesSpawned + 1
	
end

---- PHASE 1 ----

function luaPh1CompleteCheck()

	if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) > 0 then
	
		local crippled = 0
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cruisers)) do
		
			if unit and not unit.Dead then
			
				if GetHpPercentage(unit) < 0.5 then
				
					crippled = crippled + 1
				
				end
			
			end
		
		end
		
		if crippled == 2 or Mission.Debug then
			
			--[[if Mission.Debug then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cruisers)) do
			
					if unit and not unit.Dead then
				
						SetHP(unit, 100)
				
					end
				
				end
			
			end]]
			
			HideUnitHP()
			
			luaObj_Completed("primary", 1, true)
			
			Blackout(true, "luaMoveToPh2", 3)
			
		else
		
			luaMissionFailed()
		
		end
		
	end

end

function luaSpawnNextPlaneWave()
	
	local tmpTable = {}
	
	table.insert(tmpTable, GenerateObject("Emily-01"))
	table.insert(tmpTable, GenerateObject("Emily-02"))
	table.insert(tmpTable, GenerateObject("Emily-03"))
	table.insert(tmpTable, GenerateObject("Rufe-01"))
	table.insert(tmpTable, GenerateObject("Rufe-02"))
	table.insert(tmpTable, GenerateObject("Rufe-03"))
	
	for idx,unit in pairs(tmpTable) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
		local unitPos = GetPosition(unit)
	
		SquadronSetTravelAlt(unit, unitPos.y, true)
		SquadronSetAttackAlt(unit, unitPos.y, true)
		
		local trg
		
		if Mission.MissionPhase == 1 then
		
			trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cruisers))
			
		else
			
			trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
		
		end
		
		EntityTurnToEntity(unit, trg)
		PilotSetTarget(unit, trg)
		--PilotMoveToRange(unit, trg)
		
		table.insert(Mission.RaiderPlanes, unit)
		
	end
	
	if not Mission.FirstIn then
		
		SetSelectedUnit(Mission.RaiderPlanes[1])
		
		luaMakeWaveAttack()
		
		Blackout(false, "", 2)
		
		luaAddFirstObjs()
		
		Mission.FirstIn = true
		
	end
	
end

function luaInitPanic1()

	for idx,unit in pairs(Mission.PTs) do
		
		AAEnable(unit, true)
		
	end
	
	local dd = luaPickRnd(luaRemoveDeadsFromTable(Mission.DDs))
	local path = luaPickRnd(Mission.PatrolPaths)
	
	NavigatorMoveOnPath(dd, path, PATH_FM_CIRCLE, PATH_SM_JOIN)
	AAEnable(dd, true)
	
	for i = 1,2 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end
	
	for i = 1,2 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end
	
end

function luaInitPanic2()
	
	if Mission.Difficulty > 0 then
		
		local iterations
		
		if Mission.Difficulty == 1 then
		
			iterations = 1
		
		else
		
			iterations = 2
		
		end
		
		for i = 1,iterations do
		
			local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.DDs))
			local path = luaPickRnd(Mission.PatrolPaths)
			
			NavigatorMoveOnPath(ship, path, PATH_FM_CIRCLE, PATH_SM_JOIN)
			AAEnable(ship, true)
			
		end
	
	end
	
	for i = 1,3 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end
	
	for i = 1,3 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end

end

function luaInitPanic3()

	for i = 1,4 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end
	
	for i = 1,4 do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
		
		AAEnable(ship, true)
		
	end

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Cruisers)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Cruisers), "Cripple the enemy cruisers by reducing their integrity to below 50%!")
	
	luaDelay(luaPh1CompleteCheck, Mission.Ph1TimeLimit)
	Countdown("Time left: ", 0, Mission.Ph1TimeLimit)
	
	luaAddUSShipsHitListener()
	luaAddLSMListener()
	luaAddCruiserListener()
	--luaAddRadarListener()

end

function luaInitPortTraffic()

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PTs)) do
	
		NavigatorMoveOnPath(unit, Mission.PatrolPaths[idx], PATH_FM_CIRCLE, PATH_SM_JOIN)
		
	end

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PatrollingAKs)) do
	
		NavigatorMoveOnPath(unit, Mission.AKPatrolPaths[idx], PATH_FM_SIMPLE, PATH_SM_JOIN)
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Yachts)) do
	
		NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN)
		
	end
	
end

function luaIntroMovie1()
	
	luaSpawnAttackWave()

	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 4)
	
	-- Fort Dension: X -3575 Y -1425
	-- Sydney Bridge: X -4780 Y -1487
	
	--local trg1 = FindEntity("Sydney_Bridge 01")
	--local trg2 = FindEntity("CB2")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-3500,["y"]=8,["z"]=-1410},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4500,["y"]=5,["z"]=-1425},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4500,["y"]=5,["z"]=-1425},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-3500,["y"]=12,["z"]=-1425},["parent"] = nil,},["moveTime"] = 15,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-4740,["y"]=35,["z"]=-1150},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4720,["y"]=35,["z"]=-1237},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4730,["y"]=37.5,["z"]=-1237},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	Blackout(true, "luaIntroMovie3", 1)

end

function luaIntroMovie3()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Mission.MoviePlanes = {}
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane-01"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane-02"))
	
	PilotMoveToRange(Mission.MoviePlanes[1], FindEntity("MoviePlaneGoTo-01"))
	PilotMoveToRange(Mission.MoviePlanes[2], FindEntity("MoviePlaneGoTo-02"))
	
	local unitPos1 = GetPosition(Mission.MoviePlanes[1])
	local unitPos2 = GetPosition(Mission.MoviePlanes[2])
	
	SquadronSetTravelAlt(Mission.MoviePlanes[1], unitPos1.y, true)
	SquadronSetTravelAlt(Mission.MoviePlanes[2], unitPos2.y, true)
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("Tone")
	local trg2 = Mission.MoviePlanes[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=0,["y"]=10,["z"]=105},["parent"] = Mission.IntroUnit,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=105},["parent"] = Mission.IntroUnit,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=10,["z"]=0},["parent"] = Mission.IntroUnit,},["moveTime"] = 10,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=10,["z"]=0},["parent"] = Mission.IntroUnit,},["moveTime"] = 1,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=12,["y"]=7,["z"]=72},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=7,["z"]=68},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=7,["z"]=72},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 73, ["theta"] = -5, ["rho"] = 30, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
        {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 73, ["theta"] = -5, ["rho"] = 40, ["moveTime"] = 10, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()
	
	Blackout(true, "luaIn", 3)
	
end

function luaIn()
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MoviePlanes)) do
		
		if unit and not unit.Dead then
		
			Kill(unit, true)
		
		end
		
	end
	
	Mission.MissionPhase = 1
	
	EnableMessages(true)
	
	Mission.CanMusicCheck = true
	
	luaInitPortTraffic()
	
	luaSpawnNextPlaneWave()
	
	luaDelay(luaTankerDia, 25)
	
	--luaDelay(luaAddFirstObjs, 3)

end

function luaTankerDia()

	luaStartDialog("TANKER")

end

---- LISTENERS ----

function luaAddRadarListener()

	AddListener("recon", "RadarListener", {
		["callback"] = "luaRadarSighted",
		["entity"] = {Mission.RadarStation},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})
	
end

function luaAddCruiserListener()

	AddListener("recon", "CruiserListener", {
		["callback"] = "luaCruiserSighted",
		["entity"] = Mission.Cruisers,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddUSShipsHitListener()

	AddListener("hit", "USShipsHitListener", {
		["callback"] = "luaUSHit",
		["target"] = Mission.USUnits,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddLSMListener()

	AddListener("recon", "LSMListener", {
		["callback"] = "luaLSMSighted",
		["entity"] = Mission.LSMs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaRadarSighted()

	RemoveListener("recon", "RadarListener")
	
	luaObj_Add("hidden", 1)
	
	luaStartDialog("RADAR1")
	
end

function luaCruiserSighted()

	RemoveListener("recon", "CruiserListener")
	
	luaStartDialog("CRUISERS")

end

function luaUSHit()

	RemoveListener("hit", "USShipsHitListener")
	
	luaDelay(luaInitPanic1, 20)
	luaDelay(luaInitPanic2, 40)
	luaDelay(luaInitPanic3, 60)

end

function luaLSMSighted()

	RemoveListener("recon", "LSMListener")
	
	luaObj_Add("secondary", 1, Mission.LSMs)

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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Completed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(Mission.Australia, "Sydney lies in ruin - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh2Scores, 1)
		--luaDelay(luaHidePh2Scores2, 1)
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
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