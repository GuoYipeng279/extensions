---- OPERATION NARAI (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- OPERATION NARAI (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(135) 	-- P40
	PrepareClass(104) 	-- P38
	PrepareClass(325) 	-- SB2U
	PrepareClass(108) 	-- SBD
	PrepareClass(112) 	-- TBD
	PrepareClass(113) 	-- TBF
	PrepareClass(118) 	-- B25
	
	PrepareClass(27) 	-- Elco
	
	PrepareClass(167) 	-- G4M
	
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
	
	LoadMessageMap("ijndlg",13)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_05_operation_narai.lua"

	this.Name = "IJN05"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Dest",
				["Text"] = "Crush all enemy forces in the area!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Cap",
				["Text"] = "Capture the enemy headquarters!",
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
				["ID"] = "Inst",
				["Text"] = "Destroy all land installations!",
				["TextCompleted"] = "All enemy land installations have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "1",
				["Text"] = "Take out the passing enemy command plane!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "2",
				["Text"] = "The mission must last at least 15 minutes!",
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
					["message"] = "idlg01",
				},
				{
					["type"] = "pause",
					["time"] = 2.5,
				},
				{
					["message"] = "idlg01_1",
				},
				{
					["type"] = "pause",
					["time"] = 9,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
			},
		},
		["AFDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "AFDEAD1",
				},
			},
		},
		["ELCO"] = {--
			["sequence"] = {
				{
					["message"] = "ELCO1",
				},
			},
		},
		["CARGO"] = {--
			["sequence"] = {
				{
					["message"] = "CARGO1",
				},
			},
		},
		["CRUISER"] = {--
			["sequence"] = {
				{
					["message"] = "CRUISER1",
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
	
	Mission.HQ = FindEntity("HQ")
	
	SetSkillLevel(Mission.HQ, Mission.SkillLevel)
	RepairEnable(Mission.HQ, false)
	SetForcedReconLevel(Mission.HQ, 2, PARTY_JAPANESE)
	
	Mission.JapAirfield = FindEntity("Jap_Airfield")
	
	SetSkillLevel(Mission.JapAirfield, Mission.SkillLevelOwn)
	
	Mission.KongoGrp = {}
		table.insert(Mission.KongoGrp, FindEntity("Kongo"))
		table.insert(Mission.KongoGrp, FindEntity("Shirayuki"))
		table.insert(Mission.KongoGrp, FindEntity("Shiratsuyu"))
		table.insert(Mission.KongoGrp, FindEntity("Niyodo Maru"))
	
	for idx,unit in pairs(Mission.KongoGrp) do
		
		JoinFormation(unit, Mission.KongoGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		--SetCatapultStock(unit, 0)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.MayaGrp = {}
		table.insert(Mission.MayaGrp, FindEntity("Maya"))
		table.insert(Mission.MayaGrp, FindEntity("Kiso"))
		table.insert(Mission.MayaGrp, FindEntity("Hagekaze"))
		table.insert(Mission.MayaGrp, FindEntity("Ikazuchi Maru"))
	
	for idx,unit in pairs(Mission.MayaGrp) do
		
		JoinFormation(unit, Mission.MayaGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		--SetCatapultStock(unit, 0)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.IJNTrans = {}
		table.insert(Mission.IJNTrans, FindEntity("Niyodo Maru"))
		table.insert(Mission.IJNTrans, FindEntity("Ikazuchi Maru"))
	
	Mission.IJNShips = luaSumTablesIndex(Mission.KongoGrp, Mission.MayaGrp)
	
	---- USN ----
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("US_Airfield_01"))
		table.insert(Mission.Airfields, FindEntity("US_Airfield_02"))
		table.insert(Mission.Airfields, FindEntity("US_Airfield_03"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
		
		end
		
	end
	
	Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("US_Shipyard_01"))
		table.insert(Mission.Shipyards, FindEntity("US_Shipyard_02"))
		table.insert(Mission.Shipyards, FindEntity("US_Shipyard_03"))
	
	for idx,unit in pairs(Mission.Shipyards) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.USKeyTrgs = luaSumTablesIndex(Mission.Airfields, Mission.Shipyards)
	
	Mission.USGrp1 = {}
		table.insert(Mission.USGrp1, FindEntity("Helena"))
		table.insert(Mission.USGrp1, FindEntity("Fletcher-class01"))
		table.insert(Mission.USGrp1, FindEntity("Fletcher-class02"))
		--[[table.insert(Mission.USGrp1, FindEntity("Fletcher-class03"))
		table.insert(Mission.USGrp1, FindEntity("Fletcher-class04"))
		table.insert(Mission.USGrp1, FindEntity("Fletcher-class05"))]]
	
	for idx,unit in pairs(Mission.USGrp1) do
		
		JoinFormation(unit, Mission.USGrp1[1])
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
	
	Mission.USGrp2 = {}
		table.insert(Mission.USGrp2, FindEntity("Fletcher-class06"))
		table.insert(Mission.USGrp2, FindEntity("Fletcher-class07"))
		table.insert(Mission.USGrp2, FindEntity("Fletcher-class08"))
		table.insert(Mission.USGrp2, FindEntity("Fletcher-class09"))
		--table.insert(Mission.USGrp2, FindEntity("Fletcher-class10"))
		--table.insert(Mission.USGrp2, FindEntity("Fletcher-class11"))
		--table.insert(Mission.USGrp2, FindEntity("Fletcher-class12"))
	
	for idx,unit in pairs(Mission.USGrp2) do
		
		JoinFormation(unit, Mission.USGrp2[1])
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
	
	--[[Mission.USGrp3 = {}
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class13"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class14"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class15"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class16"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class17"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class18"))
		table.insert(Mission.USGrp3, FindEntity("Fletcher-class19"))
	
	for idx,unit in pairs(Mission.USGrp3) do
		
		JoinFormation(unit, Mission.USGrp3[1])
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
		
	end]]
	
	Mission.USGrps = {Mission.USGrp1, Mission.USGrp2}
	Mission.USGroups = luaSumTablesIndex(Mission.USGrp1, Mission.USGrp2)
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Cargo-01"))
		table.insert(Mission.Cargos, FindEntity("Cargo-02"))
		table.insert(Mission.Cargos, FindEntity("Cargo-03"))
		--table.insert(Mission.Cargos, FindEntity("Cargo-04"))
		--table.insert(Mission.Cargos, FindEntity("Cargo-05"))
		--table.insert(Mission.Cargos, FindEntity("Cargo-06"))
		table.insert(Mission.Cargos, FindEntity("Cargo-07"))
		table.insert(Mission.Cargos, FindEntity("Cargo-08"))
		--table.insert(Mission.Cargos, FindEntity("Cargo-09"))
		--table.insert(Mission.Cargos, FindEntity("Cargo-10"))
	
	for idx,unit in pairs(Mission.Cargos) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorEnable(unit, false)
		AAEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.MovingCargos = {}
		table.insert(Mission.MovingCargos, FindEntity("Cargo-07"))
		table.insert(Mission.MovingCargos, FindEntity("Cargo-08"))
		--table.insert(Mission.MovingCargos, FindEntity("Cargo-09"))
		--table.insert(Mission.MovingCargos, FindEntity("Cargo-10"))
	
	for idx,unit in pairs(Mission.MovingCargos) do
		
		SetShipMaxSpeed(unit, 5)
		JoinFormation(unit, Mission.MovingCargos[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorEnable(unit, true)
		AAEnable(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
		
		end
		
	end
	
	NavigatorMoveOnPath(Mission.MovingCargos[1], FindEntity("CargoPath"), PATH_FM_SIMPLE)
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA") or string.find(unit.Name, "Coastal Gun") or string.find(unit.Name, "Coastal Gun")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.Elcos = {}
	
	---- VAR ----
	
	Mission.PatrolPath1 = FindEntity("PatrolPath1")
	Mission.PatrolPath2 = FindEntity("PatrolPath2")
	Mission.PatrolPath3 = FindEntity("PatrolPath3")
	
	Mission.PatrolPaths = {}
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath1"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath2"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPath3"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.ElcoDelay = 400
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.ElcoDelay = 300
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.ElcoDelay = 200
		
	end
	
	---- INIT FUNCT. ----
	
	local posIdx = random(1,6)
	local move = 5000
	
	if posIdx == 1 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp2)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp3)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end]]
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath1
		Mission.USGrp2.chosenPath = Mission.PatrolPath3
		--Mission.USGrp3.chosenPath = Mission.PatrolPath2
		
	elseif posIdx == 2 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp2)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp3)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end]]
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath1
		Mission.USGrp2.chosenPath = Mission.PatrolPath2
		--Mission.USGrp3.chosenPath = Mission.PatrolPath3
		
	elseif posIdx == 3 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp1)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp2)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath3
		Mission.USGrp2.chosenPath = Mission.PatrolPath2
		--Mission.USGrp3.chosenPath = Mission.PatrolPath1
		
	elseif posIdx == 4 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp1)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp2)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath2
		Mission.USGrp2.chosenPath = Mission.PatrolPath3
		--Mission.USGrp3.chosenPath = Mission.PatrolPath1
		
	elseif posIdx == 5 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp1)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp3)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end]]
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath3
		Mission.USGrp2.chosenPath = Mission.PatrolPath1
		--Mission.USGrp3.chosenPath = Mission.PatrolPath2
		
	elseif posIdx == 6 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp1)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x - move
			
			PutTo(unit, unitPos)
		
		end
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGrp3)) do
		
			local unitPos = GetPosition(unit)
			
			unitPos.x = unitPos.x + move
			
			PutTo(unit, unitPos)
		
		end]]
		
		Mission.USGrp1.chosenPath = Mission.PatrolPath2
		Mission.USGrp2.chosenPath = Mission.PatrolPath1
		--Mission.USGrp3.chosenPath = Mission.PatrolPath3
		
	end
	
	for i = 1, 2 do
		
		local pathWay = random(1,2)
		local pathDir
		
		if pathWay == 1 then
		
			pathDir = PATH_SM_JOIN
		
		elseif pathWay == 2 then
		
			pathDir = PATH_SM_JOIN_BACKWARDS
		
		end
		
		local grp = Mission.USGrps[i]
		
		NavigatorMoveOnPath(grp[1], grp.chosenPath, PATH_FM_CIRCLE, pathDir)
		
	end
	
	EnableMessages(false)
	
	luaDelay(luaSpawnCommandPlane, random(250,500))
	
	MissionNarrative("January 27th, 1942 - In the Philippines")
	
	Blackout(true, "", true)
	
	luaSpawnElcos()
	
	luaDelay(luaTimeOut, 900)
	
	if Mission.Difficulty < 2 then
		
		AddAirBaseStock(Mission.JapAirfield, 167, 10)
		
	end
	
	---- MUSIC SETTING ----
	
	Mission.CanMusicCheck = true
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaSpawnCommandPlane, 60)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("CargoPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.KongoGrp) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		for idx,unit in pairs(Mission.MayaGrp) do
		
			SetInvincible(unit, 0.4)
			
		end
		
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
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.LandInstallations))
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
			
			if luaObj_IsActive("primary", 1) then
				
				if Mission.AirfieldsDead and Mission.ShipyardsDead then
				
					luaObj_Completed("primary", 1, true)
					
					Mission.TrgsDead = true
				
				else
					
					Mission.Airfields = luaRemoveDeadsFromTable(Mission.Airfields)
					Mission.Shipyards = luaRemoveDeadsFromTable(Mission.Shipyards)
					
					--Mission.TrgsLeft = luaSumTablesIndex(Mission.Airfields, Mission.Shipyards)
					--Mission.TrgsLeft1 = table.getn(luaRemoveDeadsFromTable(Mission.TrgsLeft))
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Shipyards)) == 0 then
					
						Mission.ShipyardsDead = true
					
					end
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) == 0 then
						
						Mission.AirfieldsDead = true
						
						if not Mission.AirfieldsDeadDiaPlayed then
						
							luaStartDialog("AFDEAD")
							
							Mission.AirfieldsDeadDiaPlayed = true
						
						end
					
					else
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
							
							if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
								
								local fighters = {
									[1] = 135,
									[2] = 104,
								}
								local bombers = {
									[1] = 325,
									[2] = 108,
									[3] = 112,
									[4] = 113,
								}
								
								if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
								
									bombers[5] = 118
								
								end
								
								local trgs
								
								if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
								
									trgs = Mission.IJNShips
								
								else
								
									trgs = Mission.IJNTrans
								
								end
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
								
							end
						
						end
					
					end
				
				end
				
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if Mission.HQ.Party == PARTY_ALLIED or Mission.HQ.Party == PARTY_NEUTRAL then
					
					--[[Mission.Cap = GetCapturePercentage(Mission.HQ)
				
					local line1 = "Capture the enemy headquarters!"
					local line2 = "HQ capture progress: #Mission.Cap# %"
					luaDisplayScore(2, line1, line2)]]
					
				else
					
					--HideScoreDisplay(2,0)
					
					luaObj_Completed("primary", 2, true)
					
					SetInvincible(Mission.HQ, 0.01)
					
					Mission.Capped = true
					
				end
				
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNTrans)) == 0 then
					
					HideUnitHP()
					
					HideScoreDisplay(1,0)
					
					luaMissionFailed()
				
				end
				
			end
			
			if Mission.TrgsDead and Mission.Capped then
				
				HideScoreDisplay(1,0)
				
				luaMissionComplete()
			
			--[[else
			
				local line1 = "Crush all enemy forces in the area!"
				local line2 = "Capture the enemy headquarters!"
				luaDisplayScore(1, line1, line2)]]
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.LandInstallations)) == 0 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.CommandPlane.Dead then
				
					luaObj_Completed("hidden", 1, true)
				
				else
				
					local untPos = GetPosition(Mission.CommandPlane)
					
					if IsInBorderZone(untPos) then
						
						SetInvincible(Mission.CommandPlane, 0.01)
						
						luaObj_Failed("hidden", 1)
					
					end
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Elcos)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Elcos)) do
					
					if unit and not unit.Dead then
						
						local torps = GetProperty(unit, "TorpedoStock")
						local torpStock
						
						if Mission.Realistic then
						
							torpStock = unit.Class.MaxTorpedoStock_Realistic
							
						else
							
							torpStock = unit.Class.MaxTorpedoStock
						
						end
						
						if torps == 0 then
							
							ShipSetTorpedoStock(unit, torpStock)
						
						end
						
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						
							local trgs
					
							if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
							
								trgs = Mission.IJNShips
							
							else
							
								trgs = Mission.IJNTrans
							
							end
							
							local trg = luaPickRnd(luaRemoveDeadsFromTable(trgs))
							
							luaSetScriptTarget(unit, trg)
							NavigatorAttackMove(unit, trg)
						
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

---- PHASE 1 ----

function luaTimeOut()

	if luaObj_IsActive("hidden", 2) then
	
		luaObj_Completed("hidden", 2)
	
	end

end

function luaSpawnCommandPlane()

	Mission.CommandPlaneHere = true
	
	Mission.CommandPlane = GenerateObject("CommandPlane")
	
	SetGuiName(Mission.CommandPlane, "Unknown", true)
	
	local possiblePos = {
	
		[1] = {["x"] = 9500, ["y"] = 1000, ["z"] = random(-2000,4000)},
		
		[2] = {["x"] = -9500, ["y"] = 1000, ["z"] = random(-2000,4000)},
		
	}
	local possibleTrgPos = {
	
		[1] = {["x"] = 11000, ["y"] = 1000, ["z"] = random(-2000,500)},
		
		[2] = {["x"] = -11000, ["y"] = 1000, ["z"] = random(-2000,500)},
		
	}
	
	local chosenPos = luaPickRnd(possiblePos)
	local trgPos
	
	if chosenPos.x == 9500 then
	
		trgPos = possibleTrgPos[2]
	
	elseif chosenPos.x == -9500 then
	
		trgPos = possibleTrgPos[1]
	
	end
	
	PutTo(Mission.CommandPlane, chosenPos)
	PilotMoveTo(Mission.CommandPlane, trgPos)
	
	luaObj_Add("hidden", 1)

end

function luaSpawnElcos()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Shipyards)) > 0 then
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Shipyards)) do
			
			if not unit.Dead and unit.Party == PARTY_ALLIED then
				
				local pt = GenerateObject("Elco")
				
				SetSkillLevel(pt, Mission.SkillLevel)
				NavigatorSetTorpedoEvasion(pt, true)
				NavigatorSetAvoidLandCollision(pt, true)
				TorpedoEnable(pt, true)
				
				local pos = GetPosition(unit)
				pos.y = 0
				
				if unit.Name == "US_Shipyard_01" then
				
					pos.x = pos.x + 250
					pos.z = pos.z - 250
				
				elseif unit.Name == "US_Shipyard_02" then
				
					pos.x = pos.x - 250
					pos.z = pos.z + 250
				
				elseif unit.Name == "US_Shipyard_03" then
				
					pos.x = pos.x + 250
				
				end
				
				PutTo(pt, pos)
				
				table.insert(Mission.Elcos, pt)
				
			end
		
		end
	
	end
	
	luaDelay(luaSpawnElcos, Mission.ElcoDelay)
	
end

function luaIntroMovie()
	
	Mission.MissionPhase = 1
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.HQ
	local trg2 = luaPickRnd(Mission.Airfields)
	local trg3 = luaPickRnd(Mission.Airfields)
	Mission.IntroMovieTrg = luaPickRnd(Mission.IJNShips)
	
	luaDelay(luaIntroDia, 3)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 7, ["rho"] = 250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 7, ["rho"] = 250, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 200, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 200, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 7, ["rho"] = 300, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 7, ["rho"] = 300, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	SetSelectedUnit(Mission.IntroMovieTrg)
	
	EnableMessages(true)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.USKeyTrgs)
	luaObj_Add("primary", 2, Mission.HQ)
	luaObj_Add("primary", 3, Mission.IJNTrans)
	luaObj_Add("secondary", 1)
	luaObj_Add("hidden", 2)
	
	local line1 = "Crush all enemy forces in the area!"
	local line2 = "Capture the enemy headquarters!"
	luaDisplayScore(1, line1, line2)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.IJNTrans)), "Protect your transports!")
	
	luaAddElcoListener()
	luaAddCargoListener()
	luaAddCruiserListener()
	--luaAddCommandPlaneHitListener()
	
end

---- LISTENERS ----

--[[function luaAddCommandPlaneHitListener()

	AddListener("hit", "CommandPlaneHitListener", {
		["callback"] = "luaCommandPlaneHit",
		["target"] = {Mission.CommandPlane},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end]]

function luaAddCruiserListener()

	AddListener("recon", "CruiserListener", {
		["callback"] = "luaCruiserSighted",
		["entity"] = Mission.USGroups,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddCargoListener()

	AddListener("recon", "CargoListener", {
		["callback"] = "luaCargoSighted",
		["entity"] = Mission.MovingCargos,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddElcoListener()

	AddListener("recon", "ElcoListener", {
		["callback"] = "luaElcoSighted",
		["entity"] = Mission.Elcos,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

--[[function luaCommandPlaneHit()

	RemoveListener("hit", "CommandPlaneHitListener")
	
	SetGuiName(Mission.CommandPlane, "Command Plane", true)

end]]

function luaCruiserSighted()
	
	RemoveListener("recon", "CruiserListener")
	
	luaStartDialog("CRUISER")

end

function luaCargoSighted()
	
	RemoveListener("recon", "CargoListener")
	
	luaStartDialog("CARGO")

end

function luaElcoSighted()
	
	RemoveListener("recon", "ElcoListener")
	
	luaStartDialog("ELCO")

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
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionCompletedNew(Mission.HQ, "Enemy resistance has been crushed - Mission Complete")
	
end

function luaMissionFailed()
	
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