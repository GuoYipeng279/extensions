---- SEIZING GUADALCANAL (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- SEIZING GUADALCANAL (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(104) 	-- P38
	PrepareClass(330) 	-- P39
	PrepareClass(102) 	-- F4U
	PrepareClass(108) 	-- SBD
	PrepareClass(113) 	-- TBF
	PrepareClass(323) 	-- B24
	--PrepareClass(118) 	-- B25
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_DEFAULT)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("ijndlg",5)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_09_guadalcanal.lua"

	this.Name = "IJN09"
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
				["Text"] = "Sink the enemy convoy!",
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
			[4] = {
				["ID"] = "Dest",
				["Text"] = "Sink the enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Prot",
				["Text"] = "Don't lose any bases!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "AF",
				["Text"] = "Destroy the Tulagi airfield and shipyard!",
				["TextCompleted"] = "Tulagi airfield and shipyard are destroyed!",
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
				["Text"] = "Ensure the survival of LST N. 46!",
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
					["message"] = "dlg19a",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "LOSE1",
				},
				{
					["type"] = "pause",
					["time"] = 9,
				},
				{
					["message"] = "LOSE2",
				},
				{
					["message"] = "LOSE3",
				},
			},
		},
		["CONVOY"] = {--
			["sequence"] = {
				{
					["message"] = "CONVOY1",
				},
				{
					["message"] = "CONVOY2",
				},
			},
		},
		["SUBS"] = {--
			["sequence"] = {
				{
					["message"] = "SUBS1",
				},
				{
					["message"] = "SUBS2",
				},
			},
		},
		["HOSPITALHIT"] = {--
			["sequence"] = {
				{
					["message"] = "HOSPITAL1",
				},
			},
		},
		["HOSPITALDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "HOSPITAL2",
				},
			},
		},
		["CONVOYDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "dlg19c",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh1FadeOut",
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
		["CARRIER"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "LOSE2",
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
	
	Mission.Subs = {}
		table.insert(Mission.Subs, FindEntity("I-38"))
	
	if Mission.Difficulty < 2 then
	
		table.insert(Mission.Subs, GenerateObject("I-39"))
	
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
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	---- USN ----
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB3"))
		table.insert(Mission.HQs, FindEntity("CB4"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
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
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
	end
	
	Mission.Shipyard = FindEntity("Shipyard")
	
	SetSkillLevel(Mission.Shipyard, Mission.SkillLevel)
	RepairEnable(Mission.Shipyard, false)
	
	Mission.TulagiStuff = {}
		table.insert(Mission.TulagiStuff, FindEntity("Airfield6"))
		table.insert(Mission.TulagiStuff, Mission.Shipyard)
	
	for idx,unit in pairs(Mission.TulagiStuff) do
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	--SetForcedReconLevel(FindEntity("Airfield6"), 2, PARTY_JAPANESE)
	--SetForcedReconLevel(Mission.Shipyard, 2, PARTY_JAPANESE)
	
	Mission.CargoFleet = {}
		table.insert(Mission.CargoFleet, FindEntity("Cargo-01"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-02"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-03"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-04"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-05"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-06"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-07"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-08"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-09"))
		table.insert(Mission.CargoFleet, FindEntity("Cargo-10"))
		table.insert(Mission.CargoFleet, FindEntity("Mason"))
		table.insert(Mission.CargoFleet, FindEntity("Elco-01"))
		table.insert(Mission.CargoFleet, FindEntity("Elco-02"))
		
	for idx,unit in pairs(Mission.CargoFleet) do
		
		JoinFormation(unit, Mission.CargoFleet[1])
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
	
	for idx,unit in pairs(Mission.Cargos) do
		
		SetShipMaxSpeed(unit, 8)
		
	end
	
	Mission.HospitalShip = FindEntity("Cargo-05")
	
	Mission.CargoEsc = {}
		--table.insert(Mission.CargoEsc, FindEntity("Mason"))
		table.insert(Mission.CargoEsc, FindEntity("Elco-01"))
		table.insert(Mission.CargoEsc, FindEntity("Elco-02"))
	
	if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
	
		table.insert(Mission.CargoEsc, GenerateObject("Grunion"))
		
		SetSkillLevel(FindEntity("Grunion"), Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(FindEntity("Grunion"), true)
		NavigatorSetAvoidLandCollision(FindEntity("Grunion"), true)
		TorpedoEnable(FindEntity("Grunion"), true)
		
		luaAddGrunionListener(FindEntity("Grunion"))
		
	end
	
	---- VAR ----
	
	Mission.ConvoyGoTo = FindEntity("ConvoyGoTo")
	
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
	
	NavigatorMoveToRange(Mission.CargoFleet[1], Mission.ConvoyGoTo)
	
	EnableMessages(false)
	
	SetVisibilityTerrainNode("usn06 Second Batt Guadal:mapzone", false)
	
	MissionNarrative("August 14th, 1942 - Guadalcanal Island")
	
	BannSupportmanager()
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_DEFAULT)
	luaCheckMusicSetMinLevel(MUSIC_DEFAULT)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh2, 70)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("PatrolPath3"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.Subs) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		luaDelay(luaMoveToPh3, 50)
		
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
	
		luaIntroMovie()
		
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
			
				if table.getn(luaRemoveDeadsFromTable(Mission.TulagiStuff)) == 0 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.HiddenLST.Dead then
				
					luaObj_Failed("hidden", 1)
				
				end
			
			end
			
			if Mission.MissionPhase > 1 then
			
				if Mission.Airfields and table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
						
						if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
							
							local fighters
							local bombers = {
								[1] = 108,
								[2] = 113,
							}
							
							if unit.Name == "Essex-class01" or unit.Name == "Essex-class02" then
							
								fighters = {
									[1] = 102,
								}
								
							else
							
								fighters = {
									[1] = 104,
									[2] = 330,
								}
								
								if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
									
									if unit.Name == "Airfield1" or unit.Name == "AirField6" or unit.Name == "AirField3" then
									
										bombers[3] = 323
										--bombers[4] = 118
									
									end
									
								end
								
							end
							
							local trgs = luaGetUSPlaneTrg()
							
							luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
							
						end
					
					end
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 0 then
				
					luaMissionFailed()
				
				else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Cargos)) == 0 then
						
						if IsListenerActive("recon", "GrunionListener") then
						
							RemoveListener("recon", "GrunionListener")
						
						end
						
						if IsListenerActive("hit", "HospitalHitListener") then
						
							RemoveListener("hit", "HospitalHitListener")
						
						end
						
						HideUnitHP()
						
						luaObj_Completed("primary", 1)
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
							
							if unit and not unit.Dead then
							
								SetInvincible(unit, 0.01)
							
							end
							
						end
						
						luaStartDialog("CONVOYDEAD")
					
					else
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cargos)) do
						
							if unit and not unit.Dead then
							
								if luaGetDistance(unit, Mission.ConvoyGoTo) < 700 then
								
									luaMissionFailed()
									
								end
							
							end
							
						end
						
						if Mission.EscortsCanSweep then
						
							if table.getn(luaRemoveDeadsFromTable(Mission.CargoEsc)) > 0 then
							
								for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CargoEsc)) do
								
									if unit and not unit.Dead then
							
										if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
										
											local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
											
											luaSetScriptTarget(unit, trg)
											NavigatorAttackMove(unit, trg)
										
										end
										
									end
								
								end
							
							end
						
						end
						
						if not Mission.HospitalDeadDiaPlayed then
							
							if Mission.HospitalShip.Dead then
								
								luaStartDialog("HOSPITALDEAD")
								
								Mission.HospitalDeadDiaPlayed = true
							
							end
							
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
						
					end
				
				end
				
				if capped == 5 then
					
					if not Mission.WhyYouDoThisToMeee then
					
						--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
						
							SetInvincible(unit, 0.01)
						
						end]]
						
						luaDelay(luaHidePh2Score, 1)
						HideUnitHP()
						
						luaObj_Completed("primary", 2, true)
						luaObj_Completed("primary", 3)
						
						Blackout(true, "luaMoveToPh3", 3)
						
						Mission.WhyYouDoThisToMeee = true
						
					end
					
				else
				
					Mission.BasesLeft = 5 - capped
				
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
		
		elseif Mission.MissionPhase == 3 then
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USRein)) == 0 then
					
					if not Mission.SetToEnd then
					
						HideUnitHP()
						
						luaObj_Completed("primary", 4)
						luaObj_Completed("primary", 5)
						
						luaMissionComplete()
						
						Mission.SetToEnd = true
						
					end
					
				--else
				
					--[[if table.getn(luaRemoveDeadsFromTable(Mission.LSTs)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTs)) do
						
							if unit and not unit.Dead then
							
								if not unit.IJN09_LandingStarted then
								
									if luaGetDistance(unit, unit.IJN09_LSTBaseTrg) < 1300 then
									
										StartLanding2(unit)
										
										unit.IJN09_LandingStarted = true
									
									end
								
								end
							
							end
						
						end
					
					end]]
			
				end
			
			end
			
			if luaObj_IsActive("primary", 5) then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_NEUTRAL or unit.Party == PARTY_ALLIED then
						
						luaMissionFailed()
						
					end
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.CVFleet = {}
		table.insert(Mission.CVFleet, GenerateObject("Essex-class01"))
		table.insert(Mission.CVFleet, GenerateObject("Essex-class02"))
		table.insert(Mission.CVFleet, GenerateObject("Kidd-class01"))
		table.insert(Mission.CVFleet, GenerateObject("Kidd-class02"))
		--table.insert(Mission.CVFleet, GenerateObject("Kidd-class03"))
		--table.insert(Mission.CVFleet, GenerateObject("Kidd-class04"))
	
	--Mission.CVs = {}
	
	Mission.USRein = {}
		table.insert(Mission.USRein, FindEntity("Essex-class01"))
		table.insert(Mission.USRein, FindEntity("Essex-class02"))
		table.insert(Mission.USRein, FindEntity("Kidd-class01"))
		table.insert(Mission.USRein, FindEntity("Kidd-class02"))
		--table.insert(Mission.USRein, FindEntity("Kidd-class03"))
		--table.insert(Mission.USRein, FindEntity("Kidd-class04"))
	
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
			
			--table.insert(Mission.USRein, unit)
			table.insert(Mission.Airfields, unit)
			
			--SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
			
		end
		
	end
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVFleet[1], FindEntity("PatrolPath3"), PATH_FM_CIRCLE, pathDir)
	
	Mission.LSTs = {}
	
	if Mission.Difficulty > 0 then
	
		table.insert(Mission.LSTs, GenerateObject("LST-01"))
		table.insert(Mission.USRein, FindEntity("LST-01"))
		
		if Mission.Difficulty > 1 then
		
			table.insert(Mission.LSTs, GenerateObject("LST-02"))
			table.insert(Mission.USRein, FindEntity("LST-02"))
		
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.LSTs)) > 0 then
	
		for idx,unit in pairs(Mission.LSTs) do
		
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
			
			unit.IJN09_LSTBaseTrg = luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs))
			
			NavigatorAttackMove(unit, unit.IJN09_LSTBaseTrg)
			
		end
	
	end
	
	for idx,unit in pairs(Mission.USRein) do
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	luaDelay(luaCVDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.CVFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	  
	}, luaPh3MovieEnd, true)
	
end

function luaCVDia()

	luaStartDialog("CARRIER")

end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFleet)))
	
	end
	
	luaDelay(luaAddThirdObjs, 3)
	
end

function luaAddThirdObjs()

	luaObj_Add("primary", 4, Mission.USRein)
	luaObj_Add("primary", 5)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.USRein), "Sink the enemy reinforcements!")
	
end

---- PHASE 2 ----

function luaSYFlow()

	if not Mission.EndMission then
		
		if Mission.Shipyard and not Mission.Shipyard.Dead and Mission.Shipyard.Party == PARTY_ALLIED then
		
			local spawnIdx = luaRnd(1,2)
			local trgs = luaGetUSPlaneTrg()
			local pos = GetPosition(Mission.Shipyard)
			pos.x = pos.x + 150
			pos.z = pos.z + 100
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
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.CargoFleet)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CargoFleet)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if FindEntity("Mason") and not FindEntity("Mason").Dead then
	
		Kill(FindEntity("Mason"), true)
	
	end
	
	if FindEntity("Grunion") and not FindEntity("Grunion").Dead then
	
		Kill(FindEntity("Grunion"), true)
	
	end
	
	Mission.JapFleet = {}
		table.insert(Mission.JapFleet, GenerateObject("Hiryu"))
		table.insert(Mission.JapFleet, GenerateObject("Sumida"))
		table.insert(Mission.JapFleet, GenerateObject("Oyabe"))
		--table.insert(Mission.JapFleet, GenerateObject("Shimakaze"))
		table.insert(Mission.JapFleet, GenerateObject("Fuyugumo"))
		table.insert(Mission.JapFleet, GenerateObject("Asagochi"))
		--table.insert(Mission.JapFleet, GenerateObject("Urazuki"))
		--table.insert(Mission.JapFleet, GenerateObject("Kitakaze"))
		--table.insert(Mission.JapFleet, GenerateObject("Akizuki"))
		table.insert(Mission.JapFleet, GenerateObject("Boston Maru"))
		table.insert(Mission.JapFleet, GenerateObject("Kamikawa Maru"))
	
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
		
		if Mission.Debug then
		
			SetInvincible(unit, 0.4)
			
		end
		
	end
	
	Mission.JapFleeB = {}
		table.insert(Mission.JapFleeB, GenerateObject("Harima"))
		--table.insert(Mission.JapFleeB, GenerateObject("Teruzuki"))
		table.insert(Mission.JapFleeB, GenerateObject("Niizuki"))
		table.insert(Mission.JapFleeB, GenerateObject("Shimotsuki"))
		table.insert(Mission.JapFleeB, GenerateObject("SB-01"))
		table.insert(Mission.JapFleeB, GenerateObject("SB-02"))
	
	for idx,unit in pairs(Mission.JapFleeB) do
		
		JoinFormation(unit, Mission.JapFleeB[1])
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
		
	end
	
	Mission.HiddenLST = FindEntity("SB-02")
	
	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("SB-01"))
		table.insert(Mission.JapTransports, FindEntity("SB-02"))
		table.insert(Mission.JapTransports, FindEntity("Boston Maru"))
		table.insert(Mission.JapTransports, FindEntity("Kamikawa Maru"))
	
	Mission.BaltimoreFleet = {}
		table.insert(Mission.BaltimoreFleet, GenerateObject("Baltimore-class01"))
		table.insert(Mission.BaltimoreFleet, GenerateObject("Baltimore-class02"))
		--table.insert(Mission.BaltimoreFleet, GenerateObject("Fletcher-class01"))
		--table.insert(Mission.BaltimoreFleet, GenerateObject("Fletcher-class02"))
		table.insert(Mission.BaltimoreFleet, GenerateObject("Fletcher-class03"))
		table.insert(Mission.BaltimoreFleet, GenerateObject("Fletcher-class04"))
		--table.insert(Mission.BaltimoreFleet, GenerateObject("Fletcher-class05"))
	
	for idx,unit in pairs(Mission.BaltimoreFleet) do
		
		JoinFormation(unit, Mission.BaltimoreFleet[1])
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
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.BaltimoreFleet[1], FindEntity("PatrolPath2"), PATH_FM_CIRCLE, pathDir)
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	luaDelay(luaTroopDia, 2)
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("Boston Maru")
	local trg2 = FindEntity("Hiryu")
	
	luaIngameMovie(
	{
	
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 7},
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	   
	}, luaPh2MovieEnd, true)
	
end

function luaTroopDia()

	luaStartDialog("TROOP")

end

function luaPh2MovieEnd()

	SetSelectedUnit(Mission.JapFleet[1])
	
	PermitSupportmanager()
	
	Mission.CanMusicCheck = true
	
	luaDelay(luaAddSecondObjs, 3)
	
end

function luaAddSecondObjs()

	luaObj_Add("primary", 2, Mission.HQs)
	luaObj_Add("primary", 3, Mission.JapTransports)
	luaObj_Add("secondary", 1, Mission.TulagiStuff)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTransports), "Protect your transports!")
	
	luaSYFlow()
	
end

---- PHASE 1 ----

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("I-38")
	
	luaDelay(luaIntroDia, 7)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-230,["y"]=18,["z"]=350},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-180,["y"]=15,["z"]=500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-180,["y"]=15,["z"]=500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-240,["y"]=25,["z"]=350},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=900,["y"]=10,["z"]=1020},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=650,["y"]=5,["z"]=1000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=650,["y"]=5,["z"]=1000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=900,["y"]=13,["z"]=1070},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-25,["y"]=2,["z"]=76},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-15,["y"]=4,["z"]=76},["parent"] = trg1,},["moveTime"] = 7,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=25,["y"]=4,["z"]=-85},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=20,["y"]=4,["z"]=-110},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("I-38"))
	
	EnableMessages(true)
	
	Blackout(false, "", 1)
	
	luaDelay(luaAddFirstObjs, 3)
	
end

function luaAddFirstObjs()

	Music_Control_SetLevel(MUSIC_CUSTOM3)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM3)
	
	luaObj_Add("primary", 1, Mission.Cargos)
	
	DisplayUnitHP(Mission.Cargos, "Sink the enemy convoy!")
	
	--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CargoEsc)) do
	
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
	
		NavigatorAttackMove(unit, trg)
		
		UnitSetFireStance(unit, 2)
		
	end]]
	
	Mission.EscortsCanSweep = true
	
	NavigatorAttackMove(FindEntity("Mason"), FindEntity("I-38"))
	UnitSetFireStance(FindEntity("Mason"), 2)
	
	luaAddHospitalHitListener()
	
	luaDelay(luaConvoyDia, 2)
	
end

function luaConvoyDia()

	luaStartDialog("CONVOY")

end

---- LISTENERS ----

function luaAddHospitalHitListener()

	AddListener("hit", "HospitalHitListener", {
		["callback"] = "luaHospitalHit",
		["target"] = {Mission.HospitalShip},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddGrunionListener(unit)

	AddListener("recon", "GrunionListener", {
		["callback"] = "luaGrunionSighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaHospitalHit()

	RemoveListener("hit", "HospitalHitListener")
	
	luaStartDialog("HOSPITALHIT")

end

function luaGrunionSighted()

	RemoveListener("recon", "GrunionListener")
	
	luaStartDialog("SUBS")

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
		
		HideUnitHP()
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "Guadalcanal has been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh2Score, 1)
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
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