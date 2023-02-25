---- BATTLE OF MIDWAY (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- BATTLE OF MIDWAY (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(104) 	-- P38
	PrepareClass(102) 	-- F4U
	PrepareClass(108) 	-- SBD
	PrepareClass(112) 	-- TBD
	PrepareClass(113) 	-- TBF
	PrepareClass(116) 	-- B17
	--PrepareClass(499) 	-- B24
	
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
	
	LoadMessageMap("ijndlg",7)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_07_battle_of_midway.lua"

	this.Name = "IJN07"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "AF",
				["Text"] = "Destroy all enemy airfields!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Cap",
				["Text"] = "Capture the enemy HQs!",
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
			[4] = {
				["ID"] = "Sink",
				["Text"] = "Find and sink the enemy carriers!",
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
				["Text"] = "Shoot down 50 enemy planes!",
				["TextCompleted"] = "You've shot down 50 enemy planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Oil",
				["Text"] = "Destroy the airfields fuel tanks!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Oil",
				["Text"] = "Sink all enemy ships in the area!",
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
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "idlg01d",
				},
				{
					["type"] = "pause",
					["time"] = 8,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["type"] = "pause",
					["time"] = 7,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "pause",
					["time"] = 7,
				},
				{
					["message"] = "idlg01c",
				},
				{
					["type"] = "pause",
					["time"] = 6,
				},
				{
					["message"] = "idlg01d_1",
				},
			},
		},
		["CRITICAL"] = {--
			["sequence"] = {
				{
					["message"] = "dlg3",
				},
			},
		},
		["PLANES"] = {--
			["sequence"] = {
				{
					["message"] = "PLANES1",
				},
				{
					["message"] = "PLANES2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecondaryObj",
				},
			},
		},
		["AFDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh2Blackout",
				},
			},
		},
		["YAMATO"] = {--
			["sequence"] = {
				--[[{
					["message"] = "YAMATO1",
				},]]
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5c",
				},
			},
		},
		["CARRIER"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["WAVE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["FLEEING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaClearCVs",
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
				{
					["type"] = "callback",
					["callback"] = "luaClearCVs",
				},
			},
		},
		["SUB"] = {--
			["sequence"] = {
				{
					["message"] = "dlg16",
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
	
	Mission.Hakuryu = FindEntity("Hakuryu")
	Mission.Oryu = FindEntity("Oryu")
	Mission.Kokuryu = FindEntity("Kokuryu")
	--Mission.Zuiryu = FindEntity("Zuiryu")
	
	Mission.IJNGrp = {}
		table.insert(Mission.IJNGrp, Mission.Hakuryu)
		table.insert(Mission.IJNGrp, Mission.Oryu)
		table.insert(Mission.IJNGrp, Mission.Kokuryu)
		--table.insert(Mission.IJNGrp, Mission.Zuiryu)
		table.insert(Mission.IJNGrp, FindEntity("Hizen"))
		--table.insert(Mission.IJNGrp, FindEntity("Kii"))
		table.insert(Mission.IJNGrp, FindEntity("Zao"))
		table.insert(Mission.IJNGrp, FindEntity("Mitsumine"))
		table.insert(Mission.IJNGrp, FindEntity("Hayuharu"))
		table.insert(Mission.IJNGrp, FindEntity("Hayakaze"))
		table.insert(Mission.IJNGrp, FindEntity("Fuyukaze"))
		table.insert(Mission.IJNGrp, FindEntity("Natsukaze"))
		--table.insert(Mission.IJNGrp, FindEntity("Hatsuaki"))
		--table.insert(Mission.IJNGrp, FindEntity("Abakaze"))
		--table.insert(Mission.IJNGrp, FindEntity("Tachibana"))
		--table.insert(Mission.IJNGrp, FindEntity("Sakura"))
	
	for idx,unit in pairs(Mission.IJNGrp) do
		
		JoinFormation(unit, Mission.IJNGrp[1])
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
	
	Mission.IJNGrp = {}
		table.insert(Mission.IJNGrp, Mission.Hakuryu)
		table.insert(Mission.IJNGrp, Mission.Oryu)
		table.insert(Mission.IJNGrp, Mission.Kokuryu)
		--table.insert(Mission.IJNGrp, Mission.Zuiryu)
	
	Mission.IJNCVs = {}
		table.insert(Mission.IJNCVs, Mission.Hakuryu)
		table.insert(Mission.IJNCVs, Mission.Oryu)
		table.insert(Mission.IJNCVs, Mission.Kokuryu)
		--table.insert(Mission.IJNCVs, Mission.Zuiryu)
	
	Mission.IJNBBs = {}
		table.insert(Mission.IJNBBs, FindEntity("Hizen"))
		--table.insert(Mission.IJNBBs, FindEntity("Kii"))
	
	Mission.IJNShips = Mission.IJNGrp
	
	--[[if Mission.Difficulty < 2 then
		
		local bomber1 = GenerateObject("Betty_1")
		local bomber2 = GenerateObject("Betty_2")
		
		SetSkillLevel(bomber1, Mission.SkillLevelOwn)
		SetSkillLevel(bomber2, Mission.SkillLevelOwn)
		
		PilotMoveToRange(bomber1, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNGrp)))
		PilotMoveToRange(bomber2, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNGrp)))
		
	end]]
	
	---- USN ----
	
	Mission.Radar = FindEntity("CommandBuilding Control Tower 01")
	Mission.HQ = FindEntity("Headquarter 01")
	
	Mission.Airfield1 = FindEntity("AirFieldEntity 01")
	Mission.Airfield2 = FindEntity("AirFieldEntity 02")
	Mission.Airfield3 = FindEntity("AirFieldEntity 03")
	Mission.Airfield1.HangarEntity = FindEntity("Hangar, Large, 08 01")
	Mission.Airfield2.HangarEntity = FindEntity("Hangar, Large, 08 02")
	Mission.Airfield3.HangarEntity = FindEntity("Hangar, Large, 08 03")
	
	Mission.Shipyard = FindEntity("Shipyard 02")
	
	Mission.HQs = {}
		table.insert(Mission.HQs, Mission.Radar)
		table.insert(Mission.HQs, Mission.HQ)
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, Mission.Airfield1)
		table.insert(Mission.Airfields, Mission.Airfield2)
		table.insert(Mission.Airfields, Mission.Airfield3)
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			--OverrideHP(unit, unit.Class.HP * 1.75)
			--OverrideHP(unit, unit.HangarEntity.Class.HP * 1.75)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			--OverrideHP(unit, unit.Class.HP * 2.0)
			--OverrideHP(unit, unit.HangarEntity.Class.HP * 2.0)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			--OverrideHP(unit, unit.Class.HP * 2.25)
			--OverrideHP(unit, unit.HangarEntity.Class.HP * 2.25)
			
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.OilTanks = {}
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 01"))
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 02"))
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 03"))
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 04"))
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 05"))
		table.insert(Mission.OilTanks, FindEntity("Kerosene Tank 06"))
		table.insert(Mission.OilTanks, FindEntity("Oil Tank, Big 05"))
		table.insert(Mission.OilTanks, FindEntity("Oil Tank, Big 06"))
		table.insert(Mission.OilTanks, FindEntity("Oil Tank, Big 07"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.CVSpawnDelay = 300
		Mission.ShipyardSpawnDelay = 260
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.CVSpawnDelay = 200
		Mission.ShipyardSpawnDelay = 200
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.CVSpawnDelay = 100
		Mission.ShipyardSpawnDelay = 140
		
	end
	
	---- INIT FUNCT. ----
	
	Mission.Narwhal = GenerateObject("Narwhal")
	
	SetSkillLevel(Mission.Narwhal, Mission.SkillLevel)
	NavigatorSetTorpedoEvasion(Mission.Narwhal, true)
	NavigatorSetAvoidLandCollision(Mission.Narwhal, true)
	TorpedoEnable(Mission.Narwhal, true)
	
	if Mission.Difficulty == 0 then
		
		RepairEnable(Mission.Narwhal, false)
	
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		RepairEnable(Mission.Narwhal, true)
		
		if Mission.Difficulty == 2 then
		
			SetUnlimitedAirSupply(Mission.Narwhal, true)
		
		end
		
	end
	
	local trgs = luaGetUSPlaneTrg()
	
	NavigatorAttackMove(Mission.Narwhal, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
	UnitSetFireStance(Mission.Narwhal, 2)
	
	EnableMessages(false)
	
	MissionNarrative("May 27th, 1942 - Midway Atoll")
	
	Blackout(true, "", true)
	
	luaAddSubListener()
	
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
	
	--luaShowPath(FindEntity("PatrolPath2"))
	--luaShowPath(FindEntity("PatrolPath3"))
	
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
			
			if table.getn(luaRemoveDeadsFromTable(Mission.IJNShips)) == 0 then
				
				luaMissionFailed()
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 50 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.OilTanks)) == 0 then
				
					luaObj_Completed("hidden",1,true)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) == 0 then
				
					HideUnitHP()
					
					luaObj_Completed("primary", 1)
					
					luaStartDialog("AFDEAD")
				
				else
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
						
						if not unit.Dead and unit.Party == PARTY_ALLIED then
							
							local fighters = {
								[1] = 102,
								[2] = 104,
							}
							
							local bombers = {
								[1] = 108,
								[2] = 112,
								[3] = 113,
							}
							
							if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
							
								bombers[4] = 116
								--bombers[5] = 499
							
							end
							
							local trgs = luaGetUSPlaneTrg()
							
							luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
							
						end
					
					end
				
				end
				
			end
			
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
			
				if (Mission.Radar.Party == PARTY_JAPANESE and Mission.HQ.Party == PARTY_JAPANESE) and not Mission.Capped then
					
					HideUnitHP()
					HideScoreDisplay(1,0)
					
					SetInvincible(Mission.Radar, 0.3)
					SetInvincible(Mission.HQ, 0.3)
					
					luaObj_Completed("primary", 2, true)
					luaObj_Completed("primary", 3)
					
					Mission.Capped = true
				
				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNTrans)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 0 and not Mission.CVsSetToReady then
					
					luaObj_Completed("primary", 4)
					
					if table.getn(luaRemoveDeadsFromTable(Mission.YorktownGrp)) == 0 then
					
						luaStartDialog("DESTROYED")
					
					else
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.YorktownGrp)) do
						
							if unit and not unit.Dead then
							
								NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))
							
							end
						
						end
						
						luaStartDialog("FLEEING")
					
					end
					
					luaDelay(luaHideCVScoreKeeper, 3)
					
					Mission.CVsSetToReady = true
				
				else
					
					Mission.CVsLeft = table.getn(luaRemoveDeadsFromTable(Mission.USCVs))
					
					local line1 = "Find and sink the enemy carriers!"
					local line2 = "Carrier(s) left to sink: #Mission.CVsLeft#"
					luaDisplayScore(2, line1, line2)
					
				end
			
			end
			
			if Mission.Capped and Mission.CVsSunk then
			
				luaMissionComplete()
			
			else
			
				if Mission.CVsHere then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USCVs)) do
							
							if unit and not unit.Dead then
								
								local fighters = {
									[1] = 102,
								}
								
								local bombers = {
									[1] = 108,
									[2] = 112,
									[3] = 113,
								}
								
								local trgs = luaGetUSPlaneTrg()
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
								
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

---- PHASE 2 ----

function luaHideCVScoreKeeper()

	HideScoreDisplay(2,0)

end

function luaClearCVs()

	Mission.CVsSunk = true

end

function luaPh2Blackout()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	
	--local ship1 = GenerateObject("Yamato")
	local ship2 = GenerateObject("Kirisame")
	local ship3 = GenerateObject("Benigumo")
	local ship4 = GenerateObject("Tsuruga Maru")
	local ship5 = GenerateObject("Shimakaze Maru")
	local ship6 = GenerateObject("Brazil Maru")
	local ship7 = GenerateObject("Ashitaka Maru")
	
	Mission.LandingGrp = {}
		--table.insert(Mission.LandingGrp, ship1)
		table.insert(Mission.LandingGrp, ship2)
		table.insert(Mission.LandingGrp, ship3)
		table.insert(Mission.LandingGrp, ship4)
		table.insert(Mission.LandingGrp, ship5)
		table.insert(Mission.LandingGrp, ship6)
		table.insert(Mission.LandingGrp, ship7)
	
	for idx,unit in pairs(Mission.LandingGrp) do
		
		JoinFormation(unit, Mission.LandingGrp[1])
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
	
	Mission.IJNTrans = {}
		table.insert(Mission.IJNTrans, ship4)
		table.insert(Mission.IJNTrans, ship5)
		table.insert(Mission.IJNTrans, ship6)
		table.insert(Mission.IJNTrans, ship7)
	
	--table.insert(Mission.IJNShips, ship1)
	table.insert(Mission.IJNShips, ship2)
	table.insert(Mission.IJNShips, ship3)
	table.insert(Mission.IJNShips, ship4)
	table.insert(Mission.IJNShips, ship5)
	table.insert(Mission.IJNShips, ship6)
	table.insert(Mission.IJNShips, ship7)
	
	--local ship21 = GenerateObject("Arkansas")
	local ship22 = GenerateObject("Washington")
	local ship23 = GenerateObject("Florida")
	local ship24 = GenerateObject("Lang")
	local ship25 = GenerateObject("Ellet")
	--local ship26 = GenerateObject("Trippe")
	--local ship27 = GenerateObject("Mayrant")
	--local ship28 = GenerateObject("Rhind")
	
	Mission.BBGrp = {}
		--table.insert(Mission.BBGrp, ship21)
		table.insert(Mission.BBGrp, ship22)
		table.insert(Mission.BBGrp, ship23)
		table.insert(Mission.BBGrp, ship24)
		table.insert(Mission.BBGrp, ship25)
		--table.insert(Mission.BBGrp, ship26)
		--table.insert(Mission.BBGrp, ship27)
		--table.insert(Mission.BBGrp, ship28)
	
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
		
	end
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.BBGrp[1], FindEntity("PatrolPath1"), PATH_FM_CIRCLE, pathDir)
	
	luaDelay(luaYamatoDia, 2)
	
	Blackout(false, "", 1)
	
	luaIngameMovie(
	{
	
	   {["postype"] = "cameraandtarget", ["target"] = ship4, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
	   {["postype"] = "cameraandtarget", ["target"] = ship4, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
	   
	}, luaPh2MovieEnd, true)
	
end

function luaYamatoDia()

	luaStartDialog("YAMATO")

end

function luaPh2MovieEnd()

	SetSelectedUnit(FindEntity("Tsuruga Maru"))
	
	luaAddSecondObjs()
	
	luaDelay(luaSpawnCVs, Mission.CVSpawnDelay)
	
end

function luaAddSecondObjs()

	luaObj_Add("primary", 2, Mission.HQs)
	luaObj_Add("primary", 3, Mission.IJNTrans)
	
	local line1 = "Capture the enemy HQs!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.IJNTrans), "Protect your transports!")
	
end

function luaSpawnCVs()
	
	Mission.CVsHere = true
	
	local ship1 = GenerateObject("Yorktown")
	local ship2 = GenerateObject("Intrepid")
	--local ship3 = GenerateObject("Haven")
	--local ship4 = GenerateObject("Newark")
	--local ship5 = GenerateObject("Buffalo")
	--local ship6 = GenerateObject("Vallejo")
	--local ship7 = GenerateObject("Norfolk")
	local ship8 = GenerateObject("Rowan")
	local ship9 = GenerateObject("Stack")
	local ship10 = GenerateObject("Sterett")
	local ship11 = GenerateObject("Wilson")
	--local ship12 = GenerateObject("Blue")
	--local ship13 = GenerateObject("Helm")
	
	Mission.YorktownGrp = {}
		table.insert(Mission.YorktownGrp, ship1)
		table.insert(Mission.YorktownGrp, ship2)
		--table.insert(Mission.YorktownGrp, ship3)
		--table.insert(Mission.YorktownGrp, ship4)
		--table.insert(Mission.YorktownGrp, ship5)
		--table.insert(Mission.YorktownGrp, ship6)
		--table.insert(Mission.YorktownGrp, ship7)
		table.insert(Mission.YorktownGrp, ship8)
		table.insert(Mission.YorktownGrp, ship9)
		table.insert(Mission.YorktownGrp, ship10)
		table.insert(Mission.YorktownGrp, ship11)
		--table.insert(Mission.YorktownGrp, ship12)
		--table.insert(Mission.YorktownGrp, ship13)
	
	for idx,unit in pairs(Mission.YorktownGrp) do
		
		JoinFormation(unit, Mission.YorktownGrp[1])
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
	
	Mission.USCVs = {}
		table.insert(Mission.USCVs, ship1)
		table.insert(Mission.USCVs, ship2)
		table.insert(Mission.USCVs, ship3)
	
	for idx,unit in pairs(Mission.USCVs) do
	
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
		
		end
	
	end
	
	Mission.USCVSpawnIdx = random(1,3)
	local move = 16000
	local moveX
	local moveY
	local path
	
	if Mission.USCVSpawnIdx == 1 then
	
		moveX = 0
		moveY = 0
		path = FindEntity("PatrolPath3")
		
	elseif Mission.USCVSpawnIdx == 2 then
	
		moveX = -(move)
		moveY = 0
		path = FindEntity("PatrolPath3")
	
	elseif Mission.USCVSpawnIdx == 3 then
	
		moveX = 0
		moveY = move
		path = FindEntity("PatrolPath2")
	
	end
	
	for idx,unit in pairs(Mission.YorktownGrp) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
	end
	
	NavigatorMoveOnPath(Mission.YorktownGrp[1], path, PATH_FM_CIRCLE)
	
	luaAddCVListener()
	luaDelay(luaAddPlaneListener2, 2)
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 4, Mission.USCVs)
	
end

---- PHASE 1 ----

function luaSYFlow()

	if Mission.Shipyard and not Mission.Shipyard.Dead and Mission.Shipyard.Party == PARTY_ALLIED then
	
		--local spawnIdx = luaRnd(1,2)
		local spawn = FindEntity("Shipyard2SpawnPoint")
		local unit
		
		--[[if spawnIdx == 1 then
		
			unit = GenerateObject("Catalina")
			
			PutTo(unit, spawn)
			
			local trgs = luaGetUSPlaneTrg()
			
			PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
		
		elseif spawnIdx == 2 then]]
		
			unit = GenerateObject("Elco")
			
			PutTo(unit, spawn)
			
			local trgs = luaGetUSPlaneTrg()
			
			NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			NavigatorSetTorpedoEvasion(unit, true)
			NavigatorSetAvoidLandCollision(unit, true)
			TorpedoEnable(unit, true)
		
		--end
		
		luaDelay(luaSYFlow, Mission.ShipyardSpawnDelay)
	
	end

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.MissionPhase == 0 or Mission.MissionPhase == 1 then
	
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			trgs = Mission.IJNGrp
			
		elseif Mission.Difficulty == 2 then
			
			if table.getn(luaRemoveDeadsFromTable(Mission.IJNCVs)) > 0 then
			
				trgs = Mission.IJNCVs
			
			elseif table.getn(luaRemoveDeadsFromTable(Mission.IJNBBs)) > 0 then
			
				trgs = Mission.IJNBBs
			
			else
			
				trgs = Mission.IJNGrp
			
			end
		
		end
	
	elseif Mission.MissionPhase == 2 then
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			trgs = Mission.IJNShips
			
		elseif Mission.Difficulty == 2 then
			
			if not Mission.Capped then
			
				trgs = Mission.IJNTrans
			
			else
		
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNCVs)) > 0 then
				
					trgs = Mission.IJNCVs
				
				elseif table.getn(luaRemoveDeadsFromTable(Mission.IJNBBs)) > 0 then
				
					trgs = Mission.IJNBBs
				
				else
				
					trgs = Mission.IJNShips
				
				end
		
			end
			
		end
		
	end
	
	return trgs
	
end

function luaIntroMovie1()
	
	EnableInput(false)
	
	luaDelay(luaIntroDia, 4)
	
	local trg = Mission.Radar
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 220, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
    	{["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 1000, ["theta"] = 10, ["rho"] = 300, ["moveTime"] = 28, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-6800,["y"]=6,["z"]=8020},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-6550,["y"]=6,["z"]=7920},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-6550,["y"]=6,["z"]=7920},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-6800,["y"]=15,["z"]=8045},["parent"] = nil,},["moveTime"] = 22,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-7730,["y"]=13,["z"]=6650},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-7830,["y"]=13,["z"]=6700},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-7830,["y"]=13,["z"]=6700},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=-7730,["y"]=13,["z"]=6700},["parent"] = nil,},["moveTime"] = 14,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Kokuryu"), ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
    	{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hizen"), ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 16, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Hakuryu"))
	
	EnableMessages(true)
	
	luaDelay(luaAddFirstObjs, 3)
	
	luaSYFlow()
	
	Mission.CanMusicCheck = true
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Airfields)
	luaObj_Add("hidden", 1)
	luaObj_Add("hidden", 2)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Airfields), "Destroy all enemy airfields!")
	
	SetSkillLevel(FindEntity("Avenger"), Mission.SkillLevel)
	PilotSetTarget(FindEntity("Avenger"), luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNGrp)))
	
	luaStartDialog("CRITICAL")
	
	luaAddPlaneListener1()
	
end

function luaAddSecondaryObj()

	luaObj_Add("secondary", 1)

end

---- LISTENERS ----

function luaAddSubListener()

	AddListener("recon", "SubListener", {
		["callback"] = "luaSubSighted",
		["entity"] = {Mission.Narwhal},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddPlaneListener2()
	
	if not Mission.USCVsSighted then
		
		local plane = GenerateObject("Avenger2")
		
		local move = 16000
		local moveX
		local moveY
		
		if Mission.USCVSpawnIdx == 1 then
		
			moveX = 0
			moveY = 0
			
		elseif Mission.USCVSpawnIdx == 2 then
		
			moveX = -(move)
			moveY = 0
		
		elseif Mission.USCVSpawnIdx == 3 then
		
			moveX = 0
			moveY = move
		
		end
		
		local pos = GetPosition(plane)
		pos.x = pos.x + moveX
		pos.y = 400
		pos.z = pos.z + moveY
		
		PutTo(plane, pos)
		
		local trgs = luaGetUSPlaneTrg()
		
		PilotSetTarget(plane, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
		
		AddListener("recon", "PlaneListener2", {
			["callback"] = "luaPlaneSighted2",
			["entity"] = {plane},
			["oldLevel"] = {0,1},
			["newLevel"] = {2},
			["party"] = {PARTY_JAPANESE},
		})
	
	end
	
end

function luaAddCVListener()

	AddListener("recon", "USCVListener", {
		["callback"] = "luaUSCVsSighted",
		["entity"] = Mission.YorktownGrp,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddPlaneListener1()

	AddListener("recon", "PlaneListener1", {
		["callback"] = "luaPlaneSighted1",
		["entity"] = {FindEntity("Avenger")},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaSubSighted()
	
	RemoveListener("recon", "SubListener")
	
	luaStartDialog("SUB")
	
end

function luaPlaneSighted2()
	
	RemoveListener("recon", "PlaneListener2")
	
	if not Mission.USCVsSighted then
	
		luaStartDialog("WAVE")
		
		Mission.USCVsSighted = true
		
	end
	
end

function luaUSCVsSighted()
	
	RemoveListener("recon", "USCVListener")
	
	if not Mission.USCVsSighted then
	
		luaStartDialog("CARRIER")
		
		Mission.USCVsSighted = true
	
	end
	
end

function luaPlaneSighted1()

	RemoveListener("recon", "PlaneListener1")
	
	luaStartDialog("PLANES")
	
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
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		local shipsAround = luaGetShipsAroundCoordinate(GetPosition(Mission.HQ), 300000, PARTY_ALLIED, "own")
		
		if shipsAround and table.getn(luaRemoveDeadsFromTable(shipsAround)) > 0 then
			
			luaObj_Failed("hidden",2)
		
		else
		
			luaObj_Completed("hidden",2)
		
		end
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "Midway is ours - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideScoreDisplay(1,0)
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideScoreDisplay(2,0)
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
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