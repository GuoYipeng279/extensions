---- FINALE (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- FINALE (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(5) 	-- P80
	--PrepareClass(318) 	-- F8F
	PrepareClass(117) 	-- B29
	--PrepareClass(331) 	-- BTD
	PrepareClass(16) 	-- TBM
	
end

---- INITS ----

function luaEngineMovieInit()
	
	--Music_Control_SetLevel(MUSIC_TENSION)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("ijndlg",14)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_20_finale.lua"

	this.Name = "IJN20"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Cap",
				["Text"] = "Capture the bay!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Prot",
				["Text"] = "Protect your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "CV",
				["Text"] = "Destroy the enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Surv",
				["Text"] = "Survive the air raid!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Final",
				["Text"] = "Final Objective: Sink the USS Iowa and USS Enterprise!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Shoot",
				["Text"] = "Shoot down 100 enemy planes!",
				["TextCompleted"] = "You've shot down 100 enemy planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Dest",
				["Text"] = "Shoot down 200 enemy aicraft!",
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
					["message"] = "INTRO1",
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["type"] = "pause",
					["time"] = 4.5,
				},
				{
					["message"] = "INTRO2",
				},
			},
		},
		["CLOSING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["BOMBER"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecondaryObj",
				},
			},
		},
		["HEAVY"] = {--
			["sequence"] = {
				{
					["message"] = "HEAVY1",
				},
				{
					["message"] = "HEAVY2",
				},
				{
					["message"] = "HEAVY3",
				},
			},
		},
		["CARRIER"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "CARRIER2",
				},
				{
					["message"] = "CARRIER3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecondObjs",
				},
			},
		},
		["DESTROYED"] = {--
			["sequence"] = {
				{
					["message"] = "DESTROYED1",
				},
				{
					["message"] = "DESTROYED2",
				},
				--[[{
					["type"] = "callback",
					["callback"] = "luaPh2FadeOut",
				},]]
			},
		},
		["RAID"] = {--
			["sequence"] = {
				{
					["message"] = "RAID1",
				},
				{
					["message"] = "RAID2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddThirdObjs",
				},
			},
		},
		["IOWA"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "dlg8_1",
				},
				{
					["message"] = "dlg8_2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaTADADADADADADADAAAAAAAAAAAAA",
				},
			},
		},
		--[[["NUKEHERE"] = {--
			["sequence"] = {
				{
					["message"] = "NUKEHERE1",
				},
				{
					["message"] = "NUKEHERE2",
				},
				{
					["message"] = "NUKEHERE3",
				},
			},
		},
		["NUKESIGHTED"] = {--
			["sequence"] = {
				{
					["message"] = "NUKESIGHTED1",
				},
				{
					["message"] = "NUKESIGHTED2",
				},
			},
		},
		["NUKEDROPPED"] = {--
			["sequence"] = {
				{
					["message"] = "NUKEDROPPED1",
				},
			},
		},]]
		--[[["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "FINAL2",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "FINAL3",
				},
			},
		},]]
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
	
	Mission.A150 = FindEntity("A-150")
	Mission.Hakuryu = FindEntity("Hakuryu")
	Mission.Kokuryu = FindEntity("Kokuryu")
	Mission.Oryu = FindEntity("Oryu")
	--Mission.Zuiryu = FindEntity("Zuiryu")
	
	Mission.IJNCentralGrp = {}
		table.insert(Mission.IJNCentralGrp, Mission.A150)
		table.insert(Mission.IJNCentralGrp, Mission.Hakuryu)
		table.insert(Mission.IJNCentralGrp, Mission.Kokuryu)
		table.insert(Mission.IJNCentralGrp, Mission.Oryu)
		--table.insert(Mission.IJNCentralGrp, Mission.Zuiryu)
		table.insert(Mission.IJNCentralGrp, FindEntity("Zao"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Senjo"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Sakura"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Tachibana"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Abakaze"))
		--table.insert(Mission.IJNCentralGrp, FindEntity("Hatsuaki"))
		--table.insert(Mission.IJNCentralGrp, FindEntity("Natsukaze"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Brazil Maru"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Edogawa Maru"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Enoura Maru"))
		table.insert(Mission.IJNCentralGrp, FindEntity("Hawaii Maru"))
		
	for idx,unit in pairs(Mission.IJNCentralGrp) do
		
		JoinFormation(unit, Mission.IJNCentralGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	--[[Mission.IJNNorthernGrp = {}
		table.insert(Mission.IJNNorthernGrp, Mission.Oryu)
		table.insert(Mission.IJNNorthernGrp, FindEntity("Tsurugi"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Matsu"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Take"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Ume"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Momo"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Kuwa"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Kiri"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Enoura Maru"))
		table.insert(Mission.IJNNorthernGrp, FindEntity("Hawaii Maru"))
		
	for idx,unit in pairs(Mission.IJNNorthernGrp) do
		
		JoinFormation(unit, Mission.IJNNorthernGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.IJNSouthernGrp = {}
		table.insert(Mission.IJNSouthernGrp, Mission.Zuiryu)
		table.insert(Mission.IJNSouthernGrp, FindEntity("Utsugi"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Sugi"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Maki"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Momi"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Kashi"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Yaezakura"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Yadake"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Kaimei Maru"))
		table.insert(Mission.IJNSouthernGrp, FindEntity("Nojima Maru"))
		
	for idx,unit in pairs(Mission.IJNSouthernGrp) do
		
		JoinFormation(unit, Mission.IJNSouthernGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end]]
	
	Mission.IJNTransports = {}
		table.insert(Mission.IJNTransports, FindEntity("Brazil Maru"))
		table.insert(Mission.IJNTransports, FindEntity("Edogawa Maru"))
		table.insert(Mission.IJNTransports, FindEntity("Enoura Maru"))
		table.insert(Mission.IJNTransports, FindEntity("Hawaii Maru"))
		--table.insert(Mission.IJNTransports, FindEntity("Kaimei Maru"))
		--table.insert(Mission.IJNTransports, FindEntity("Nojima Maru"))
	
	--Mission.IJNShips = luaSumTablesIndex(Mission.IJNCentralGrp, Mission.IJNNorthernGrp, Mission.IJNSouthernGrp)
	Mission.IJNShips = Mission.IJNCentralGrp
	
	---- USN ----
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ1"))
		table.insert(Mission.HQs, FindEntity("HQ2"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB3"))
		table.insert(Mission.HQs, FindEntity("CB4"))
		table.insert(Mission.HQs, FindEntity("SB1"))
		table.insert(Mission.HQs, FindEntity("SB2"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, false)
			
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
			
		end
		
	end
	
	Mission.HQs[1].IJN20_Airfield = FindEntity("AirField3")
	Mission.HQs[2].IJN20_Airfield = FindEntity("AirField6")
	Mission.HQs[3].IJN20_Airfield = FindEntity("Airfield1")
	Mission.HQs[4].IJN20_Airfield = FindEntity("AirField2")
	Mission.HQs[5].IJN20_Airfield = FindEntity("AirField4")
	Mission.HQs[6].IJN20_Airfield = FindEntity("AirField5")
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
		table.insert(Mission.Airfields, FindEntity("Airfield4"))
		table.insert(Mission.Airfields, FindEntity("Airfield5"))
		table.insert(Mission.Airfields, FindEntity("Airfield6"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		SetAirBaseSlotCount(unit, 2)
		
		--[[if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 4)
			
		end]]
		
		--Mission.HQs[idx].IJN20_Airfield = unit
		
	end
	
	Mission.USPlaneSpawns = {}
		table.insert(Mission.USPlaneSpawns, FindEntity("BomberSpawn1"))
		table.insert(Mission.USPlaneSpawns, FindEntity("BomberSpawn2"))
		table.insert(Mission.USPlaneSpawns, FindEntity("BomberSpawn3"))
	
	Mission.IowaSpawns = {}
		table.insert(Mission.IowaSpawns, FindEntity("IowaSpawn1"))
		table.insert(Mission.IowaSpawns, FindEntity("IowaSpawn2"))
	
	Mission.AirfieldManagerFunctionFighterTable = {}
	Mission.AirfieldManagerFunctionBomberTable = {}
	Mission.USAttackers = {}
	Mission.PTs = {}
	
	---- VAR ----
	
	--[[Mission.FinalSmokes = {}
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke1"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke2"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke3"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke4"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke5"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke6"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke7"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke8"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke9"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke10"))
		table.insert(Mission.FinalSmokes, FindEntity("FinalSmoke11"))]]
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.JapBases = 0
	Mission.PTWaves = 0
	Mission.PlaneWaves = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.WaveNum = 1
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.WaveNum = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.WaveNum = 3
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("January 15th, 1944 - San Francisco")
	
	Blackout(true, "", true)
	
	---- THINK ----
	
	luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh3, 70)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaSpawnNuke, 100)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("NukeMoveTo"))
	--[[luaShowPoint(FindEntity("FinalSmoke2"))
	luaShowPoint(FindEntity("FinalSmoke3"))
	luaShowPoint(FindEntity("FinalSmoke4"))
	luaShowPoint(FindEntity("FinalSmoke5"))
	luaShowPoint(FindEntity("FinalSmoke6"))
	luaShowPoint(FindEntity("FinalSmoke7"))
	luaShowPoint(FindEntity("FinalSmoke8"))
	luaShowPoint(FindEntity("FinalSmoke9"))
	luaShowPoint(FindEntity("FinalSmoke10"))
	luaShowPoint(FindEntity("FinalSmoke11"))]]
	
	--luaShowPath(FindEntity("IowaPath"))
	--luaShowPath(FindEntity("BBPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.IJNCentralGrp) do
		
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
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.AirfieldManagerFunctionBomberTable))
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
			
			if not Mission.FirstFewPhasesDone then
		
				if not Mission.Capped and not Mission.CVsDead then
				
					if luaObj_IsActive("primary", 1) then
						
						if Mission.JapBases == 8 then
							
							if not Mission.CVsDead then
							
								luaDelay(luaHidePh1Counter, 1)
								
								luaObj_Completed("primary", 1)
								
								Mission.Capped = true
								
								--Blackout(true, "luaMoveToPh2", 3)
							
							end
							
						else
							
							local capped = 0
							local american = 0
							local canSpawnCVs = false
							
							for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
							
								if unit.Party == PARTY_JAPANESE then
									
									capped = capped + 1
									
									if not unit.IJN20_FirstPhaseDiscounted then
										
										--[[if unit.IJN20_Airfield and not unit.IJN20_Airfield.Dead then
										
											local activeSquads, planeEntTable = luaGetSlotsAndSquads(unit.IJN20_Airfield)
											
											if planeEntTable and table.getn(luaRemoveDeadsFromTable(planeEntTable)) > 0 then
											
												for i,plane in pairs(luaRemoveDeadsFromTable(planeEntTable)) do
													
													if plane and not plane.Dead then
														
														if not plane.retreating then
														
															SquadronSetBaseUnsupported(plane, unit.IJN20_Airfield)
															
															local ammo = GetProperty(plane, "ammoType")
															
															if ammo == 0 then
															
																PilotRetreat(plane)
															
															end
															
															plane.retreating = true
															
														end
														
													end
													
												end
											
											end
											
										end]]
										
										SetInvincible(unit, 0.25)
										
										unit.IJN20_FirstPhaseDiscounted = true
									
									end
									
								elseif unit.Party == PARTY_ALLIED then
									
									american = american + 1
									
								end
							
							end
							
							Mission.JapBases = capped
							
							if capped >= 3 and american <= 2 then
							
								canSpawnCVs = true
							
							end
							
							if canSpawnCVs and not Mission.CVsHere then
							
								luaDelay(luaMoveToPh2, 10)
								
								Mission.CVsHere = true
								
							end
							
							Mission.BasesLeft = 8 - Mission.JapBases
							
							local line1 = "Capture the bay!"
							local line2 = "Enemy base(s) left to capture: #Mission.BasesLeft#"
							luaDisplayScore(1, line1, line2)
							
						end
						
					end
					
					if luaObj_IsActive("primary", 3) then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
							
							luaDelay(luaHidePh2Counter, 1)
							
							luaObj_Completed("primary", 3)
							
							luaStartDialog("DESTROYED")
						
						else
							
							Mission.ShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.USShips))
							
							local line1 = "Destroy the enemy reinforcements!"
							local line2 = "Enemy ship(s) left to sink: #Mission.ShipsLeft#"
							luaDisplayScore(2, line1, line2)
							
							if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) > 0 then
							
								for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USCVs)) do
									
									if unit and not unit.Dead then
										
										local fighters = {
											[1] = 5,
										}
										
										local bombers = {
											[1] = 16,
										}
										
										--[[local wngCount
										
										if Mission.Difficulty == 0 then
											
											wngCount = 3
										
										elseif Mission.Difficulty == 1 then
											
											wngCount = 4
										
										elseif Mission.Difficulty == 2 then
											
											wngCount = 5
										
										end]]
										
										local trgs = luaGetUSPlaneTrg()
										
										luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs), nil, 3)
										
									end
								
								end
							
							end
							
						end
						
					end
					
				else
				
					luaMoveToPh3()
					
				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNTransports)) == 0 then
					
					luaMissionFailed()
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 100 then
				
					luaObj_Completed("secondary", 1)
				
				end
				
				if not Mission.HeavyDiaPlayed then
				
					if sd >= 50 then
					
						luaStartDialog("HEAVY")
						
						Mission.HeavyDiaPlayed = true
						
					end
				
				end
				
			elseif luaObj_IsActive("hidden", 1) then
				
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 200 then
				
					luaObj_Completed("hidden", 1)
				
				end
				
			end
			
		end
		
		if Mission.MissionPhase == 3 then
			
			if luaObj_IsActive("primary", 4) then
			
				if Mission.PlaneWaves >= 3 then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) == 0 or Mission.PlaneWaves == 5 then
						
						HideUnitHP()
						
						luaObj_Completed("primary", 2)
						luaObj_Completed("primary", 4)
						
						Blackout(true, "luaMoveToFinalPh", 1)
					
					end
				
				end
			
			end
			
		elseif Mission.MissionPhase == 4 then
			
			if luaObj_IsActive("primary", 5) then
			
				if Mission.Iowa.Dead and Mission.Enterprise.Dead then
			
					if not Mission.FinallyGodDamnit then
					
						HideUnitHP()
						
						luaObj_Completed("primary", 5, true)
						
						luaDelay(luaFinalDia, 3)
						
						Mission.FinallyGodDamnit = true
						Mission.EndMission = true
						
					end
					
				else
				
					if Mission.Enterprise and not Mission.Enterprise.Dead then
					
						local fighters = {
							[1] = 5,
						}
						
						local bombers = {
							[1] = 16,
						}
						
						if Mission.IJNShips and table.getn(luaRemoveDeadsFromTable(Mission.IJNShips)) > 0 then
						
							local ordered = luaSortByDistance(Mission.Enterprise, luaRemoveDeadsFromTable(Mission.IJNShips))
							local closest = ordered[1]
							
							luaAirfieldManager(Mission.Enterprise, fighters, bombers, {closest})
						
						end
						
					end
				
				end
			
			end
			
			--[[if Mission.NukePlaneHere then
			
				if Mission.NukePlane and not Mission.NukePlane.Dead then
				
					if luaGetDistance(Mission.NukePlane, Mission.NukeMoveTo) < 3000 and not Mission.NukeMovieStarted then
						
						HideUnitHP()
			
						luaObj_Completed("primary", 5)
						
						Blackout(true, "luaNukeMovie", 1)
						
						Mission.NukeMovieStarted = true
					
					end
				
				end
			
			else
			
				if Mission.Iowa and not Mission.Iowa.Dead then
				
					if GetHpPercentage(Mission.Iowa) < 0.5 then
					
						luaSpawnNuke()
					
					end
				
				end
			
			end]]
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- FINAL PHASE ----

function luaFinalDia()

	luaStartDialog("FINAL")

end

--[[function luaTheEnd1()
	
	Blackout(true, "luaTheEnd2", 3)

end

function luaTheEnd2()
	
	Mission.MushroomCloud = GenerateObject("MushroomCloud")
	
	Mission.EnterpriseFleet = {}
		table.insert(Mission.EnterpriseFleet, GenerateObject("Enterprise"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("FinalMovieDD1"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("FinalMovieDD2"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("FinalMovieDD3"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("FinalMovieDD4"))
	
	for idx,unit in pairs(Mission.EnterpriseFleet) do
		
		SetInvincible(unit, true)
		UnitHoldFire(unit)
		
		JoinFormation(unit, Mission.EnterpriseFleet[1])
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	luaDelay(luaFinalMusic, 2)
	luaDelay(luaFinalDia, 3)
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.EnterpriseFleet[1]
	
	luaIngameMovie(
	{
		
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=115,["y"]=8,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=50,["z"]=70},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=8,["z"]=70},["parent"] = trg1,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
       {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 260, ["theta"] = 9.5, ["rho"] = 295, ["moveTime"] = 3},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 280, ["theta"] = 9.5, ["rho"] = 295, ["moveTime"] = 6},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 280, ["theta"] = 9.5, ["rho"] = 295, ["moveTime"] = 5},
		
	}, luaTheEnd3, true)
	
end

function luaFinalMusic()

	Music_Control_SetLevel(MUSIC_CUSTOM3)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM3)

end

function luaFinalDia()
	
	luaStartDialog("FINAL")
	
end

function luaTheEnd3()

	Blackout(true, "luaTADADADADADADADAAAAAAAAAAAAA", 3)

end

function luaNukeMovie()
	
	Mission.EndMission = true
	
	--luaAddNukeHitListener()
	
	EnableMessages(false)
	
	luaDelay(luaNukeSightedDia, 6)
	luaDelay(luaNukeMusic, 13)
	luaDelay(luaReleaseNuke, 17)
	luaDelay(luaNukeDetonated, 34)
	
	Blackout(false, "", 1)
	
	local trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
	local trg2 = Mission.NukePlane
	local trg3 = GetPayload(Mission.NukePlane, 1)
	
	luaIngameMovie(
	{
	
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg2,},["moveTime"] = 2,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg2,},["moveTime"] = 4,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 30, ["theta"] = -10, ["rho"] = 35, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 27, ["theta"] = -6, ["rho"] = 62, ["moveTime"] = 3, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 25, ["theta"] = -8, ["rho"] = 80, ["moveTime"] = 5, ["smoothtime"] = 3},
		
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 10, ["theta"] = 10, ["rho"] = 80, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 9, ["theta"] = 6, ["rho"] = 130, ["moveTime"] = 6, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 8, ["theta"] = 8, ["rho"] = 190, ["moveTime"] = 6, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 10000, ["theta"] = 8, ["rho"] = 190, ["moveTime"] = 8, ["smoothtime"] = 3},
		
	}, luaTheEnd1, true)
	
end

function luaNukeDetonated()
	
	Music_Control_SetLevel(MUSIC_CUSTOM1)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM1)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNShips)) do
		
		if unit and not unit.Dead then
			
			Kill(unit, true)
			
		end
		
	end
	
	if Mission.Iowa and not Mission.Iowa.Dead then
		
		Kill(Mission.Iowa, true)
		
	end
	
	--luaInitFinalSmokes()
	
end

--[[function luaInitFinalSmokes()
	
	local pos = {["x"] = -9000, ["y"] = 0, ["z"] = 5000}
	
	for i = 1, 50 do
		
		Effect("GiantSmoke", pos)
		
		pos.z = pos.z - 100
		
	end

end]]

function luaNukeMusic()

	Music_Control_SetLevel(MUSIC_CUSTOM2)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM2)

end

function luaNukeSightedDia()

	luaStartDialog("NUKESIGHTED")

end

function luaReleaseNuke()

	SquadronForceRelease(Mission.NukePlane)
	
	luaStartDialog("NUKEDROPPED")
	
	--luaDelay(luaNukeDetonate, 14)
	
end]]

--[[function luaNukeDetonate()

	--RemoveListener("hit", "nukeHitListener")
	
	
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 35, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 20000, ["theta"] = 6, ["rho"] = 62, ["moveTime"] = 8},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 20000, ["theta"] = 6, ["rho"] = 62, ["moveTime"] = 6},
		
	}, luaTheEnd1, true)
	
end]]

function luaMoveToFinalPh()

	Mission.MissionPhase = 4
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNShips)) do
		
		if unit and not unit.Dead then
			
			SetInvincible(unit, true)
			UnitHoldFire(unit)
			
		end
		
	end
	
	Mission.Iowa = GenerateObject("Iowa")
	Mission.Enterprise = GenerateObject("Enterprise")
	
	local spawnIdx = luaRnd(1,2)
	--local spawnIdx = 1
	
	local spawn = GetPosition(Mission.IowaSpawns[spawnIdx])
	
	Mission.EntGoTo = spawn
	
	table.remove(Mission.IowaSpawns, spawnIdx)
	
	PutTo(Mission.Iowa, spawn)
	
	SetSkillLevel(Mission.Iowa, SKILL_ELITE)
	OverrideHP(Mission.Iowa, Mission.Iowa.Class.HP * 3.5)
	
	PutTo(Mission.Enterprise, GetPosition(luaPickRnd(Mission.IowaSpawns)))
	
	SetSkillLevel(Mission.Enterprise, SKILL_ELITE)
	OverrideHP(Mission.Enterprise, Mission.Enterprise.Class.HP * 3.5)
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
	
	EntityTurnToEntity(Mission.Iowa, trg)
	--NavigatorAttackMove(Mission.Iowa, trg)
	--UnitSetFireStance(Mission.Iowa, 2)
	
	UnitHoldFire(Mission.Iowa)
	SetForcedReconLevel(Mission.Iowa, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.Enterprise, 2, PARTY_JAPANESE)
	--SetInvincible(Mission.Iowa, 0.25)
	
	--NavigatorMoveToRange(Mission.Enterprise, Mission.EntGoTo)
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.Iowa, FindEntity("IowaPath"), PATH_FM_CIRCLE, pathDir)
	NavigatorMoveOnPath(Mission.Enterprise, FindEntity("IowaPath"), PATH_FM_CIRCLE, pathDir)
	
	Blackout(false, "", 1)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaIowaDia, 7)
	
	Mission.CanMusicCheck = false
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	local trg1 = Mission.Iowa
	
	luaIngameMovie(
	{
		
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		
       {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 9, ["rho"] = 0, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 9, ["rho"] = 0, ["moveTime"] = 5},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 250, ["theta"] = 12, ["rho"] = 0, ["moveTime"] = 3},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 250, ["theta"] = 12, ["rho"] = 0, ["moveTime"] = 5},
		
	}, luaFinalPhMovie2, true)
	
end

function luaIowaDia()

	luaStartDialog("IOWA")

end

function luaFinalPhMovie2()
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		Mission.FinalMovieUnit = Mission.SelUnit
	
	else
	
		Mission.FinalMovieUnit = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
	
	end
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieUnit, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieUnit, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieUnit, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIowaMovieEnd, true)

end

function luaIowaMovieEnd()

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNShips)) do
		
		if unit and not unit.Dead then
			
			SetInvincible(unit, false)
			UnitFreeFire(unit)
			
		end
		
	end
	
	--SetInvincible(Mission.Iowa, false)
	UnitFreeFire(Mission.Iowa)
	
	SetSelectedUnit(Mission.FinalMovieUnit)
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 5)
	
	Mission.IowaTbl = {Mission.Iowa, Mission.Enterprise}
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.IowaTbl), "Final Objective: Sink the USS Iowa and USS Enterprise!")
	
	--luaDelay(luaSpawnNuke, 10)
	
end

--[[function luaSpawnNuke()
	
	if Mission.Debug then
	
		Mission.MissionPhase = 4
	
	end
	
	Mission.NukePlaneHere = true
	
	Mission.NukePlane = GenerateObject("Nuke")
	
	SetSkillLevel(Mission.NukePlane, Mission.SkillLevel)
	SetInvincible(Mission.NukePlane, true)
	UnitHoldFire(Mission.NukePlane)
	
	SetForcedReconLevel(Mission.NukePlane, 1, PARTY_JAPANESE)
	
	Mission.NukeMoveTo = GetPosition(FindEntity("NukeMoveTo"))
	
	PilotMoveTo(Mission.NukePlane, Mission.NukeMoveTo)
	
	luaStartDialog("NUKEHERE")
	
	--luaDelay(luaNukeSightedDia, 20)
	
end]]

---- PHASE 3 ----

function luaAddThirdObjs()

	luaObj_Add("primary", 4)

end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	Mission.FirstFewPhasesDone = true
	
	luaSpawnNextRaidWave()
	--luaSpawnPTs()
	
end

function luaPh3Movie(unit)
	
	Blackout(false, "", 1)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaRaidDia, 2)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 25, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 25, ["rho"] = 180, ["moveTime"] = 5},
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 25, ["rho"] = 180, ["moveTime"] = 2,},
	  
	}, luaPh3MovieEnd, true)

end

function luaRaidDia()

	luaStartDialog("RAID")

end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips)))
	
	end
	
end

function luaSpawnNextRaidWave()
	
	if Mission.MissionPhase == 3 then
	
		if Mission.PlaneWaves < 3 then
			
			local planeTypes = {16, 117, 117}
			local planeNum = Mission.Difficulty + 3
			
			for i = 1, 3 do
				
				local plane = planeTypes[Mission.PlaneWaves + 1]
				local blyat = luaRnd(2,3)
				local ammo
				local spawn
				
				spawn = i
				
				local spawnPoint = GetPosition(Mission.USPlaneSpawns[spawn])
				spawnPoint.x = spawnPoint.x - 200
				spawnPoint.z = spawnPoint.z + 200
				
				for j = 1, blyat do
				
					luaSpawnAmerican(plane, spawnPoint)
					
					spawnPoint.x = spawnPoint.x + 200
					spawnPoint.z = spawnPoint.z - 200
					
				end
				
			end
			
			Mission.PlaneWaves = Mission.PlaneWaves + 1
			
			luaDelay(luaSpawnNextRaidWave, 85)
			
		end
		
	end
	
end

function luaSpawnAmerican(class, pos)
	
	--if Mission.PlaneWaves < 3 then
	
		pos.y = 1000
		
		local planeType
		
		if class == 16 then
		
			planeType = "TBM_Spawn"
		
		elseif class == 117 then
		
			planeType = "SuperFortress_Spawn"
		
		end
		
		local plane = GenerateObject(planeType)
		
		PutTo(plane, pos)
		
		luaAmericanSpawned(plane)
		
		--[[SpawnNew({
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
		})]]
		
	--	Mission.PlaneWaves = Mission.PlaneWaves + 1
		
	--end
	
end

function luaAmericanSpawned(unit)

	local trgs = luaGetUSPlaneTrg()
	local trg = luaPickRnd(luaRemoveDeadsFromTable(trgs))
	
	SetSkillLevel(unit, Mission.SkillLevel)
	--SquadronSetSpeed(unit, KMH(150))
	EntityTurnToEntity(unit, trg)
	PilotSetTarget(unit, trg)
	UnitSetFireStance(unit, 2)
	
	SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	
	table.insert(Mission.USAttackers, unit)
	
	if not Mission.FinalMovieSet then
		
		luaPh3Movie(unit)
		
		Mission.FinalMovieSet = true
		
	end
	
end

--[[function luaSpawnPTs()

	if Mission.MissionPhase == 3 then
		
		if Mission.PTWaves < Mission.WaveNum then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.PTs)) == 0 then
			
				table.insert(Mission.PTs, GenerateObject("Elco-01"))
				table.insert(Mission.PTs, GenerateObject("Elco-02"))
				table.insert(Mission.PTs, GenerateObject("Elco-03"))
				table.insert(Mission.PTs, GenerateObject("Elco-04"))
				table.insert(Mission.PTs, GenerateObject("Elco-05"))
				table.insert(Mission.PTs, GenerateObject("Elco-06"))
				table.insert(Mission.PTs, GenerateObject("Elco-07"))
				table.insert(Mission.PTs, GenerateObject("Elco-08"))
				table.insert(Mission.PTs, GenerateObject("Elco-09"))
				table.insert(Mission.PTs, GenerateObject("Elco-10"))
				table.insert(Mission.PTs, GenerateObject("Elco-11"))
				table.insert(Mission.PTs, GenerateObject("Elco-12"))
				table.insert(Mission.PTs, GenerateObject("Elco-13"))
				table.insert(Mission.PTs, GenerateObject("Elco-14"))
				table.insert(Mission.PTs, GenerateObject("Elco-15"))
				table.insert(Mission.PTs, GenerateObject("Elco-16"))
				table.insert(Mission.PTs, GenerateObject("Elco-17"))
				table.insert(Mission.PTs, GenerateObject("Elco-18"))
				table.insert(Mission.PTs, GenerateObject("Elco-19"))
				table.insert(Mission.PTs, GenerateObject("Elco-20"))
				table.insert(Mission.PTs, GenerateObject("Elco-21"))
				table.insert(Mission.PTs, GenerateObject("Elco-22"))
				table.insert(Mission.PTs, GenerateObject("Elco-23"))
				table.insert(Mission.PTs, GenerateObject("Elco-24"))
				table.insert(Mission.PTs, GenerateObject("Elco-25"))
				table.insert(Mission.PTs, GenerateObject("Elco-26"))
				table.insert(Mission.PTs, GenerateObject("Elco-27"))
				table.insert(Mission.PTs, GenerateObject("Elco-28"))
				table.insert(Mission.PTs, GenerateObject("Elco-29"))
				table.insert(Mission.PTs, GenerateObject("Elco-30"))
				table.insert(Mission.PTs, GenerateObject("Elco-31"))
				table.insert(Mission.PTs, GenerateObject("Elco-32"))
				table.insert(Mission.PTs, GenerateObject("Elco-33"))
				table.insert(Mission.PTs, GenerateObject("Elco-34"))
				table.insert(Mission.PTs, GenerateObject("Elco-35"))
				table.insert(Mission.PTs, GenerateObject("Elco-36"))
				table.insert(Mission.PTs, GenerateObject("Elco-37"))
				table.insert(Mission.PTs, GenerateObject("Elco-38"))
				table.insert(Mission.PTs, GenerateObject("Elco-39"))
				table.insert(Mission.PTs, GenerateObject("Elco-40"))
				table.insert(Mission.PTs, GenerateObject("Elco-41"))
				table.insert(Mission.PTs, GenerateObject("Elco-42"))
				table.insert(Mission.PTs, GenerateObject("Elco-43"))
				table.insert(Mission.PTs, GenerateObject("Elco-44"))
				table.insert(Mission.PTs, GenerateObject("Elco-45"))
				table.insert(Mission.PTs, GenerateObject("Elco-46"))
				table.insert(Mission.PTs, GenerateObject("Elco-47"))
				table.insert(Mission.PTs, GenerateObject("Elco-48"))
				table.insert(Mission.PTs, GenerateObject("Elco-49"))
				table.insert(Mission.PTs, GenerateObject("Elco-50"))
				table.insert(Mission.PTs, GenerateObject("Elco-51"))
				table.insert(Mission.PTs, GenerateObject("Elco-52"))
				table.insert(Mission.PTs, GenerateObject("Elco-53"))
				table.insert(Mission.PTs, GenerateObject("Elco-54"))
				table.insert(Mission.PTs, GenerateObject("Elco-55"))
				table.insert(Mission.PTs, GenerateObject("Elco-56"))
				table.insert(Mission.PTs, GenerateObject("Elco-57"))
				table.insert(Mission.PTs, GenerateObject("Elco-58"))
				table.insert(Mission.PTs, GenerateObject("Elco-59"))
				table.insert(Mission.PTs, GenerateObject("Elco-60"))
				table.insert(Mission.PTs, GenerateObject("Elco-61"))
				table.insert(Mission.PTs, GenerateObject("Elco-62"))
				table.insert(Mission.PTs, GenerateObject("Elco-63"))
				table.insert(Mission.PTs, GenerateObject("Elco-64"))
				table.insert(Mission.PTs, GenerateObject("Elco-65"))
				table.insert(Mission.PTs, GenerateObject("Elco-66"))
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PTs)) do
					
					if unit and not unit.Dead then
						
						SetSkillLevel(unit, Mission.SkillLevel)
						TorpedoEnable(unit, true)
						
						--UnitSetFireStance(unit, 2)
					
					end
					
				end
				
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.PTs)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PTs)) do
				
				if unit and not unit.Dead then
					
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					
						local trgs = luaGetUSPlaneTrg()
						local trg = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs), true)
						
						luaSetScriptTarget(unit, trg)
						NavigatorAttackMove(unit, trg)
					
					end
					
				end
				
			end
		
		end
		
		luaDelay(luaSpawnPTs, 10)
		
	end

end]]

---- PHASE 2 ----

function luaPh2FadeOut()

	--Blackout(true, "luaMoveToPh3", 3)
	
	Mission.CVsDead = true
	
end

function luaHidePh2Counter()

	HideScoreDisplay(2,0)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	--Mission.CVsHere = true
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
		
		SetInvincible(unit, false)
		
	end
	
	Mission.CVGrp = {}
		table.insert(Mission.CVGrp, GenerateObject("Midway"))
		table.insert(Mission.CVGrp, GenerateObject("Franklin D. Roosevelt"))
		table.insert(Mission.CVGrp, GenerateObject("Theo. E. Chandler"))
		table.insert(Mission.CVGrp, GenerateObject("Maddox"))
		table.insert(Mission.CVGrp, GenerateObject("Shannon"))
		table.insert(Mission.CVGrp, GenerateObject("Adams"))
		--table.insert(Mission.CVGrp, GenerateObject("Johnston"))
		--table.insert(Mission.CVGrp, GenerateObject("Samuel B. Roberts"))
		
	Mission.USCVs = {}
	
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
		
		if unit.Class.Type == "MotherShip" then
			
			SetShipMaxSpeed(unit, 10)
			
			if Mission.Difficulty == 0 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 3)
				
			end
			
			table.insert(Mission.USCVs, unit)
		
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.BBGrp = {}
		table.insert(Mission.BBGrp, GenerateObject("Maine"))
		table.insert(Mission.BBGrp, GenerateObject("Louisiana"))
		table.insert(Mission.BBGrp, GenerateObject("Damato"))
		table.insert(Mission.BBGrp, GenerateObject("Vogelgesang"))
		--table.insert(Mission.BBGrp, GenerateObject("Sarsfield"))
		--table.insert(Mission.BBGrp, GenerateObject("Hanson"))
		--table.insert(Mission.BBGrp, GenerateObject("Glennon"))
		--table.insert(Mission.BBGrp, GenerateObject("Robert A. Owens"))
		
	for idx,unit in pairs(Mission.BBGrp) do
		
		JoinFormation(unit, Mission.BBGrp[1])
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
	
	Mission.USShips = luaSumTablesIndex(Mission.CVGrp, Mission.BBGrp)
	
	local pathIdx1 = luaRnd(1,2)
	local pathDir1
	
	if pathIdx1 == 1 then
	
		pathDir1 = PATH_SM_JOIN
	
	elseif pathIdx1 == 2 then
	
		pathDir1 = PATH_SM_JOIN_BACKWARDS
	
	end
	
	local pathIdx2 = luaRnd(1,2)
	local pathDir2
	
	if pathIdx2 == 1 then
	
		pathDir2 = PATH_SM_JOIN
	
	elseif pathIdx2 == 2 then
	
		pathDir2 = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVGrp[1], FindEntity("BBPath"), PATH_FM_CIRCLE, pathDir1)
	NavigatorMoveOnPath(Mission.BBGrp[1], FindEntity("BBPath"), PATH_FM_CIRCLE, pathDir2)
	
	Blackout(false, "", 1)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaCarrierDia, 2)
	
	local trg1 = Mission.CVGrp[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	  
	}, luaPh2MovieEnd, true)
	
end

function luaCarrierDia()

	luaStartDialog("CARRIER")

end

function luaPh2MovieEnd()
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips)))
	
	end
	
	--luaDelay(luaSpawnPTs, 10)
	
end

function luaAddSecondObjs()

	luaObj_Add("primary", 3, Mission.USShips)

end

---- PHASE 1 ----

function luaCheckAirfields()
	
	if Mission.MissionPhase == 1 or Mission.MissionPhase == 2 then
		
		--local planesUp = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 60000, PARTY_ALLIED, "own")
		
		--local smallBomberPresent = false
		
		if table.getn(luaRemoveDeadsFromTable(Mission.AirfieldManagerFunctionBomberTable)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AirfieldManagerFunctionBomberTable)) do
				
				if unit and not unit.Dead then
					
					--[[if not smallBomberPresent then
					
						if unit.Class.ID == 16 or unit.Class.ID == 331 then
						
							smallBomberPresent = true
						
						end
					
					end]]
					
					if not unit.retreating then
					
						local ammo = GetProperty(unit, "ammoType")
						
						if ammo == 0 then
						
							PilotRetreat(unit)
							
							unit.retreating = true
							
						end
					
					end
					
				end
				
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
				
				if not unit.Dead and unit.Party == PARTY_ALLIED then
					
					local fighters = {
						[1] = 5,
					}
					
					local bombers
					
					if unit.Name == "AirField4" or unit.Name == "AirField5" then
					
						bombers = {
							[1] = 16,
						}
						
					else
					
						bombers = {
							[1] = 117,
						}
						
					end
					
					--[[local wngCount
					--local heavyBomber
					
					if Mission.Difficulty == 0 then
						
						wngCount = 3
						--heavyBomber = false
					
					elseif Mission.Difficulty == 1 then
						
						wngCount = 4
						--heavyBomber = true
					
					elseif Mission.Difficulty == 2 then
						
						wngCount = 5
						--heavyBomber = true
					
					end]]
					
					--[[if not smallBomberPresent then
					
						--if not (unit.Name == "AirField4" or unit.Name == "AirField5") then
					
							bombers[2] = 331
							bombers[3] = 16
						
						--end
					
					end]]
					
					local trgs = luaGetUSPlaneTrg()
					
					luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs), nil, 3)
					
				end
			
			end
			
		end
		
		luaDelay(luaCheckAirfields, 10)
		
	end
	
end

function luaHidePh1Counter()

	HideScoreDisplay(1,0)

end

function luaAddSecondaryObj()

	luaObj_Add("secondary", 1)

end

function luaBomberDia()

	luaStartDialog("BOMBER")

end

function luaBomberMovieEnd()

	SetSelectedUnit(Mission.SelUnit)

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.IJNShips
		
	elseif Mission.Difficulty == 2 then
		
		trgs = Mission.IJNTransports
	
	end
	
	return trgs
	
end

function luaIntroMovie1()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Blackout(false, "", 3)
	
	luaDelay(luaIntroDia, 10)
	luaDelay(luaInitFakeLanding, 20.5)
	
	local trg1 = FindEntity("CB1")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-3196,["y"]=39.6,["z"]=232},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3193,["y"]=39.6,["z"]=234},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3193,["y"]=39.6,["z"]=234},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-3200,["y"]=39.6,["z"]=234},["parent"] = nil,},["moveTime"] = 9,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=350,["y"]=4,["z"]=-200},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=13,["z"]=-250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=13,["z"]=-250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=400,["y"]=20,["z"]=-260},["parent"] = nil,},["moveTime"] = 8.5,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5775,["y"]=40,["z"]=1140},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=40,["z"]=-13000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=40,["z"]=-13000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5785,["y"]=55,["z"]=1140},["parent"] = nil,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-30,["y"]=4,["z"]=-100},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-20,["y"]=4,["z"]=-50},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-20,["y"]=4,["z"]=-50},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-36,["y"]=7,["z"]=-100},["parent"] = trg1,},["moveTime"] = 7,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaInitFakeLanding()
	
	if Mission.MissionPhase == 0 then
	
		Mission.MovieGuns = {FindEntity("CB1"), FindEntity("MovieGun1"), FindEntity("MovieGun2"), FindEntity("MovieGun3"), FindEntity("MovieGun4"), FindEntity("MovieGun5")}
		
		for idx,unit in pairs(Mission.MovieGuns) do
			
			ArtilleryEnable(unit, false)
			
		end
		
		Mission.MovieTransport = GenerateObject("MovieTransport")
		
		StartLanding2(Mission.MovieTransport)
	
	end
	
end

function luaIntroMovie2()

	Blackout(true, "luaIntroMovie3", 2)

end

function luaIntroMovie3()
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("A-150")
	--local trg2 = FindEntity("GoldenGate")
	
	luaIngameMovie(
	{
	
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5,["y"]=7.3,["z"]=-134},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=9.1,["z"]=-134},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=9.1,["z"]=-134},["parent"] = trg1,},["moveTime"] = 4.5,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=155,["y"]=36,["z"]=-255},["parent"] = trg1,},["moveTime"] = 29,["transformtype"] = "keepall", ["smoothtime"] = 2},
		
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=32,["z"]=250},["parent"] = trg1,},["moveTime"] = 4,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=32,["z"]=250},["parent"] = trg1,},["moveTime"] = 2,["transformtype"] = "keepall"},
		
	},
	luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()
	
	Blackout(true, "luaIn", 3)

end

function luaIn()

	Mission.MissionPhase = 1
	
	local shipsAround = luaGetShipsAroundCoordinate(GetPosition(FindEntity("CB1")), 3000, PARTY_JAPANESE, "own")
	
	if shipsAround and table.getn(luaRemoveDeadsFromTable(shipsAround)) > 0 then
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(shipsAround)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if Mission.MovieGuns and table.getn(luaRemoveDeadsFromTable(Mission.MovieGuns)) > 0 then
	
		for idx,unit in pairs(Mission.MovieGuns) do
			
			ArtilleryEnable(unit, true)
			
		end
	
	end
	
	luaCheckAirfields()
	
	SetSelectedUnit(FindEntity("A-150"))
	
	Blackout(false, "", 3)
	
	EnableMessages(true)
	
	SetSkillLevel(GenerateObject("SuperFortress"), Mission.SkillLevel)
	PilotSetTarget(FindEntity("SuperFortress"), luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips)))
	
	luaAddPlaneListener()
	
	luaStartDialog("CLOSING")
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.HQs)
	luaObj_Add("primary", 2, Mission.IJNTransports)
	luaObj_Add("hidden", 1)
	
	--[[local line1 = "Capture the bay!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)]]
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.IJNTransports), "Protect your transports!")
	
	Mission.CanMusicCheck = true
	
end

---- LISTENERS ----

--[[function luaAddNukeHitListener()

	AddListener("hit", "nukeHitListener", {
		["callback"] = "luaNukeDetonate",
		["target"] = {},
		["targetDevice"] = {},
		["attacker"] = {Mission.NukePlane},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end]]

function luaAddPlaneListener()

	AddListener("recon", "PlaneListener", {
		["callback"] = "luaPlaneSighted",
		["entity"] = {FindEntity("SuperFortress")},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaPlaneSighted()

	RemoveListener("recon", "PlaneListener")
	
	luaDelay(luaBomberDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = FindEntity("SuperFortress")
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 100, ["theta"] = 10, ["rho"] = 179, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 10, ["rho"] = 179, ["moveTime"] = 5},
	  
	}, luaBomberMovieEnd, true)
	
end

---- MISSION ENDERS ----

function luaTADADADADADADADAAAAAAAAAAAAA()

	luaMissionCompletedNew(nil, "", "jp_outro.bik", false, true)

end

function luaMissionFailed()
	
	Mission.EndMission = true
	
	Mission.MissionPhase = 666
	
	if luaObj_IsActive("primary",1) then
		
		HideScoreDisplay(1,0)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideScoreDisplay(2,0)
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",5)
	
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
	
	--[[if Mission.EndMission then
	
		return
	
	end]]
	
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