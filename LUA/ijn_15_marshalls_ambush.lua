---- AMBUSHED AT BETIO (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- AMBUSHED AT BETIO (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(108) 	-- SBD
	PrepareClass(38) 	-- SB2C
	PrepareClass(167) 	-- Betty
	PrepareClass(151) 	-- Raiden
	PrepareClass(159) 	-- Judy
	
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
	
	LoadMessageMap("ijndlg",8)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_15_marshalls_ambush.lua"

	this.Name = "IJN15"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Locate",
				["Text"] = "Locate the inbound friendly convoy!",
				["TextCompleted"] = "The friendly convoy has been located!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Submaline",
				["Text"] = "Sink the enemy submarine!",
				["TextCompleted"] = "The enemy submarine is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Sink",
				["Text"] = "Destroy the enemy landing forces!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Cargos",
				["Text"] = "Ensure the survival of all convoy ships!",
				["TextFailed"] = "One of your convoy ships is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "CVs",
				["Text"] = "Sink the enemy aicraft carriers!",
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
			},
		},
		["RADAR"] = {--
			["sequence"] = {
				{
					["message"] = "UNIDENTIFIED1",
				},
				{
					["message"] = "UNIDENTIFIED2",
				},
			},
		},
		["BB"] = {--
			["sequence"] = {
				{
					["message"] = "FLEET1",
				},
				{
					["message"] = "REINFORCEMENTS1",
				},
				{
					["message"] = "REINFORCEMENTS2",
				},
				{
					["message"] = "REINFORCEMENTS3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
			},
		},
		["MESSAGE"] = {--
			["sequence"] = {
				{
					["message"] = "MESSAGE1",
				},
				{
					["message"] = "MESSAGE2",
				},
				{
					["message"] = "MESSAGE3",
				},
				{
					["message"] = "MESSAGE4",
				},
			},
		},
		["RETREATING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg5b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["DESTROYED"] = {--
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
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
	
	Mission.HQ = FindEntity("HQ")
	
	SetSkillLevel(Mission.HQ, Mission.SkillLevelOwn)
	
	--if Mission.Difficulty == 0 then
	
		RepairEnable(Mission.HQ, true)
		
	--[[else
	
		RepairEnable(Mission.HQ, false)
		
	end]]
	
	SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.HQ, EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.HQ, PCF_NONE)
	
	Mission.Airfield = FindEntity("AirField")
	
	SetSkillLevel(Mission.Airfield, Mission.SkillLevelOwn)
	RepairEnable(Mission.Airfield, false)
	
	Mission.Kitakami = FindEntity("Kitakami")
	
	SetSkillLevel(Mission.Kitakami, Mission.SkillLevelOwn)
	NavigatorSetTorpedoEvasion(Mission.Kitakami, true)
	NavigatorSetAvoidLandCollision(Mission.Kitakami, true)
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		RepairEnable(Mission.Kitakami, true)
	
	elseif Mission.Difficulty == 2 then
		
		RepairEnable(Mission.Kitakami, false)
	
	end
	
	SetRoleAvailable(Mission.Kitakami, EROLF_ALL, PLAYER_AI)
	
	Mission.Convoy = {}
		table.insert(Mission.Convoy, FindEntity("Sydney Maru"))
		table.insert(Mission.Convoy, FindEntity("Nagata Maru"))
		table.insert(Mission.Convoy, FindEntity("Canberra Maru"))
		table.insert(Mission.Convoy, FindEntity("Toyama Maru"))
	
	for idx,unit in pairs(Mission.Convoy) do
		
		SetInvincible(unit, 0.5)
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		SetParty(unit, PARTY_NEUTRAL)
		
	end
	
	Mission.IJNUnits = {}
		table.insert(Mission.IJNUnits, Mission.HQ)
		table.insert(Mission.IJNUnits, Mission.Kitakami)
		table.insert(Mission.IJNUnits, FindEntity("Sydney Maru"))
		table.insert(Mission.IJNUnits, FindEntity("Nagata Maru"))
		table.insert(Mission.IJNUnits, FindEntity("Canberra Maru"))
		table.insert(Mission.IJNUnits, FindEntity("Toyama Maru"))
	
	Mission.IJNTrgs = {}
		table.insert(Mission.IJNTrgs, Mission.HQ)
		table.insert(Mission.IJNTrgs, Mission.Airfield)
		table.insert(Mission.IJNTrgs, Mission.Kitakami)
		table.insert(Mission.IJNTrgs, FindEntity("Sydney Maru"))
		table.insert(Mission.IJNTrgs, FindEntity("Nagata Maru"))
		table.insert(Mission.IJNTrgs, FindEntity("Canberra Maru"))
		table.insert(Mission.IJNTrgs, FindEntity("Toyama Maru"))
	
	---- USN ----
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.landfort) do
		
		if not unit.Dead and ((string.find(unit.Name, "AA") or string.find(unit.Name, "Coastal")) or (string.find(unit.Name, "Fortress") or string.find(unit.Name, "Bunker"))) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.DeadInstallations = {}
	Mission.CVs = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Planes = 1
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.RemovedForts = 14
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.RemovedForts = 20
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.RemovedForts = 26
		
	end
	
	---- INIT FUNCT. ----
	
	AddAirBaseStock(Mission.Airfield, 151, 9)
	AddAirBaseStock(Mission.Airfield, 159, 9)
	
	if Mission.Difficulty == 0 then
		
		AddAirBaseStock(Mission.Airfield, 167, 6)
		
	end
	
	for i = 1, Mission.RemovedForts do
	
		local idx = random(1, table.getn(Mission.LandInstallations))
		local trg = Mission.LandInstallations[idx]
		
		table.insert(Mission.DeadInstallations, trg)
		table.remove(Mission.LandInstallations, idx)
		
	end
	
	for idx,unit in pairs(Mission.DeadInstallations) do
		
		AddDamage(unit, 9999)
		
	end
	
	Mission.MoveIdx = luaRnd(1,2)
	
	for idx,unit in pairs(Mission.Convoy) do
	
		if Mission.MoveIdx == 2 then
	
			local pos = GetPosition(unit)
			pos.z = -(pos.z)
			
			PutTo(unit, pos)
			
			EntityTurnToEntity(unit, Mission.HQ)
		
		end
		
		JoinFormation(unit, Mission.Convoy[1])
		
	end
	
	NavigatorMoveToRange(Mission.Convoy[1], Mission.HQ)
	
	EnableMessages(false)
	
	MissionNarrative("September 9th, 1943 - Betio Island")
	
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
			
			if luaObj_IsActive("primary", 2) then
			
				if Mission.Sub.Dead then
					
					if not Mission.FuckYouMotherFucker then
					
						HideUnitHP()
						
						luaObj_Completed("primary", 2, true)
						
						luaMoveToPh2()
						
						Mission.FuckYouMotherFucker = true
						
					end
				
				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USKeyUnits)) == 0 then
					
					SetInvincible(Mission.HQ, 0.01)
					
					HideUnitHP()
					luaDelay(luaHidePh2Score, 1)
					
					luaObj_Completed("primary", 3)
					
					if table.getn(luaRemoveDeadsFromTable(Mission.USUnits)) == 0 then
					
						luaStartDialog("DESTROYED")
					
					else
					
						luaStartDialog("RETREATING")
					
					end
					
					Mission.EndMission = true
					
				else
					
					if Mission.HQ.Party == PARTY_NEUTRAL or Mission.HQ.Party == PARTY_ALLIED then
					
						luaMissionFailed()
					
					else
					
						Mission.InvasionLeft = table.getn(luaRemoveDeadsFromTable(Mission.USKeyUnits))
						
						local line1 = "Destroy the enemy landing forces!"
						local line2 = "Ship(s) left to sink: #Mission.InvasionLeft#"
						luaDisplayScore(2, line1, line2)
						
					end
					
					if not Mission.MessageDiaPlayed then
						
						if table.getn(luaRemoveDeadsFromTable(Mission.USKeyUnits)) <= 2 then
						
							luaStartDialog("MESSAGE")
							
							Mission.MessageDiaPlayed = true
						
						end
						
					end
					
				end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) < 4 then
			
					luaObj_Failed("secondary", 1, true)
			
				end
			
			end
			
			if Mission.CarriersHere then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
					
						if unit and not unit.Dead then
							
							local stloPlaneNum, stloPlaneTable= luaGetSlotsAndSquads(unit)
							
							if IsReadyToSendPlanes(unit) and stloPlaneNum < Mission.Planes then
								
								local planeTypes = {
								108,
								38,
								}
								
								local plane = luaPickRnd(planeTypes)
								
								local slotIndex = LaunchSquadron(unit,plane,3,1)
								local launchedWildcat = thisTable[tostring(GetProperty(unit, "slots")[slotIndex].squadron)]
								SetSkillLevel(launchedWildcat, Mission.SkillLevel)
								
								PilotSetTarget(launchedWildcat, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNTrgs)))

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

function luaHidePh2Score()

	HideScoreDisplay(2,0)

end

function luaBBMovie()
	
	Mission.CarriersHere = true
	
	Mission.SelUnit = GetSelectedUnit()
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaDelay(luaBBDia, 2)
	
	local trg1 = FindEntity("Texas")
	local trg2 = FindEntity("West Point")
	local trg3 = FindEntity("Bastian")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 10, ["rho"] = 200, ["moveTime"] = 0, ["transformtype"] = "keepnone"},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 200, ["moveTime"] = 6, ["nonlinearblend"] = 0.1},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 17, ["rho"] = 260, ["moveTime"] = 0, ["terrainavoid"] = true, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 580, ["theta"] = 20, ["rho"] = 200, ["moveTime"] = 6, ["terrainavoid"] = true, ["nonlinearblend"] = 0.5},
		
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 150, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 250, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 6},
		
	}, luaBBMovieEnd, true)

end

function luaBBDia()

	luaStartDialog("BB")

end

function luaBBMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNUnits)))
	
	end
	
	for idx,unit in pairs(Mission.Convoy) do
		
		SetInvincible(unit, false)
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		
	end
	
	SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_ANY)
	SetRoleAvailable(Mission.Kitakami, EROLF_ALL, PLAYER_ANY)
	
	--luaAddSecObjs()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 3, Mission.USKeyUnits)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP({Mission.HQ}, "HQ status:")
	
end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.BBGrpA = {}
		table.insert(Mission.BBGrpA, GenerateObject("Texas"))
		--table.insert(Mission.BBGrpA, GenerateObject("Augusta"))
		table.insert(Mission.BBGrpA, GenerateObject("Fletcher-class01"))
		table.insert(Mission.BBGrpA, GenerateObject("Fletcher-class02"))
	
	for idx,unit in pairs(Mission.BBGrpA) do
	
		JoinFormation(unit, Mission.BBGrpA[1])
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
	
	Mission.BBGrpB = {}
		table.insert(Mission.BBGrpB, GenerateObject("Wyoming"))
		--table.insert(Mission.BBGrpB, GenerateObject("Northampton"))
		table.insert(Mission.BBGrpB, GenerateObject("Fletcher-class03"))
		table.insert(Mission.BBGrpB, GenerateObject("Fletcher-class04"))
	
	for idx,unit in pairs(Mission.BBGrpB) do
	
		JoinFormation(unit, Mission.BBGrpB[1])
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
	
	Mission.CVGrp = {}
		table.insert(Mission.CVGrp, GenerateObject("Bastian"))
		table.insert(Mission.CVGrp, GenerateObject("St. Simon"))
		table.insert(Mission.CVGrp, GenerateObject("Perdido"))
		--table.insert(Mission.CVGrp, GenerateObject("Keweenaw"))
		table.insert(Mission.CVGrp, GenerateObject("Fletcher-class05"))
		table.insert(Mission.CVGrp, GenerateObject("Fletcher-class06"))
		table.insert(Mission.CVGrp, GenerateObject("Fletcher-class07"))
		table.insert(Mission.CVGrp, GenerateObject("Fletcher-class08"))
		--table.insert(Mission.CVGrp, GenerateObject("Fletcher-class09"))
		--table.insert(Mission.CVGrp, GenerateObject("Fletcher-class10"))
		--table.insert(Mission.CVGrp, GenerateObject("Fletcher-class11"))
		--table.insert(Mission.CVGrp, GenerateObject("Fletcher-class12"))
	
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
			
			if Mission.Difficulty == 0 then
			
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 2)
				
			end
			
			table.insert(Mission.CVs, unit)
	
		end
		
	end
	
	Mission.LandingGrp = {}
		table.insert(Mission.LandingGrp, GenerateObject("West Point"))
		table.insert(Mission.LandingGrp, GenerateObject("LST N. 144"))
		
	if Mission.Difficulty == 2 then
	
		table.insert(Mission.LandingGrp, GenerateObject("LSM N. 15"))
	
	end
	
	for idx,unit in pairs(Mission.LandingGrp) do
	
		--JoinFormation(unit, Mission.LandingGrp[1])
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
	
	Mission.USKeyUnits = {}
		table.insert(Mission.USKeyUnits, FindEntity("Texas"))
		--table.insert(Mission.USKeyUnits, FindEntity("Augusta"))
		table.insert(Mission.USKeyUnits, FindEntity("Fletcher-class01"))
		table.insert(Mission.USKeyUnits, FindEntity("Fletcher-class02"))
		table.insert(Mission.USKeyUnits, FindEntity("Wyoming"))
		--table.insert(Mission.USKeyUnits, FindEntity("Northampton"))
		table.insert(Mission.USKeyUnits, FindEntity("Fletcher-class03"))
		table.insert(Mission.USKeyUnits, FindEntity("Fletcher-class04"))
		table.insert(Mission.USKeyUnits, FindEntity("West Point"))
		table.insert(Mission.USKeyUnits, FindEntity("LST N. 144"))
		
	if Mission.Difficulty == 2 then
		
		table.insert(Mission.USKeyUnits, FindEntity("LSM N. 15"))
	
	end
	
	Mission.USUnits = luaSumTablesIndex(Mission.BBGrpA, Mission.BBGrpB, Mission.CVGrp, Mission.LandingGrp)
	
	if Mission.MoveIdx == 2 then
	
		for idx,unit in pairs(Mission.USUnits) do
	
			local pos = GetPosition(unit)
			pos.x = -(pos.x)
			
			PutTo(unit, pos)
		
		end
		
	end
	
	NavigatorAttackMove(Mission.BBGrpA[1], Mission.HQ)
	NavigatorAttackMove(Mission.BBGrpB[1], Mission.HQ)
	
	for idx,unit in pairs(Mission.LandingGrp) do
	
		NavigatorAttackMove(unit, Mission.HQ)
	
	end
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	else
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVGrp[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	luaAddBBListener()
	luaAddBBRadarListener()
	
end

---- PHASE 1 ----

function luaSpawnSub()

	local submarine = GenerateObject("Argonaut")
	
	local pos = GetPosition(Mission.Convoy[1])
	pos.x = pos.x + 1700
	pos.y = -20
	
	PutTo(submarine, pos)
	
	SetSkillLevel(submarine, Mission.SkillLevel)
	NavigatorSetTorpedoEvasion(submarine, true)
	NavigatorSetAvoidLandCollision(submarine, true)
	TorpedoEnable(submarine, true)
	
	if Mission.Difficulty == 0 then
		
		RepairEnable(submarine, false)
	
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		RepairEnable(submarine, true)
		SetUnlimitedAirSupply(submarine, true)
		
	end
	
	SetForcedReconLevel(submarine, 2, PARTY_JAPANESE)
	
	local trg = Mission.Convoy[1]
	
	EntityTurnToEntity(submarine, trg)
	NavigatorAttackMove(submarine, trg)
	
	UnitSetFireStance(submarine, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	Mission.Sub = submarine
	
	local trg1 = submarine
	local trg2 = Mission.Convoy[1]
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 210, ["theta"] = 6, ["rho"] = 20, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 190, ["theta"] = 6, ["rho"] = 20, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 100, ["theta"] = -5, ["rho"] = 348, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 95, ["theta"] = -1, ["rho"] = 318, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 90, ["theta"] = -5, ["rho"] = 260, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 95, ["theta"] = -10, ["rho"] = 211, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 110, ["theta"] = -20, ["rho"] = 201, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	   
	}, luaSubMovieEnd, true)

end

function luaSubMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNUnits)))
	
	end
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	luaAddSubObjs()
	
end

function luaAddSubObjs()

	luaObj_Add("primary", 2, Mission.Sub)
	luaObj_Add("secondary", 1, Mission.Convoy)
	
	DisplayUnitHP({Mission.Sub}, "Sink the enemy submarine!")
	
end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 3)
	
	local trg1 = FindEntity("Kitakami")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-20,["y"]=8,["z"]=130},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=20,["y"]=8,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=20,["y"]=8,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-10,["y"]=12,["z"]=130},["parent"] = trg1,},["moveTime"] = 21,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.HQ)
	
	Blackout(false, "", 2)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)

	local line1 = "Locate the inbound friendly convoy!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	luaAddConvoyListener()
	
end

---- LISTENERS ----

function luaAddConvoyListener()

	AddListener("recon", "ConvoyListener", {
		["callback"] = "luaConvoySighted",
		["entity"] = Mission.Convoy,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddBBListener()

	AddListener("recon", "BBListener", {
		["callback"] = "luaBBSighted",
		["entity"] = Mission.USUnits,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddBBRadarListener()

	AddListener("recon", "BBRadarListener", {
		["callback"] = "luaBBRadarSighted",
		["entity"] = Mission.USUnits,
		["oldLevel"] = {0},
		["newLevel"] = {1},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaConvoySighted()

	RemoveListener("recon", "ConvoyListener")
	
	for idx,unit in pairs(Mission.Convoy) do
		
		SetParty(unit, PARTY_JAPANESE)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		
	end
	
	HideScoreDisplay(1,0)
	
	luaObj_Completed("primary", 1, true)
	
	luaSpawnSub()
	
	--luaMoveToPh2()
	
end

function luaBBSighted()
	
	if IsListenerActive("recon", "BBRadarListener") then
	
		RemoveListener("recon", "BBRadarListener")
	
	end
	
	RemoveListener("recon", "BBListener")
	
	Blackout(true, "luaBBMovie", 1)
	
end

function luaBBRadarSighted()
	
	RemoveListener("recon", "BBRadarListener")
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	luaStartDialog("RADAR")
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
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
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) == 0 then
			
			luaObj_Completed("hidden",1)
	
		else
		
			luaObj_Failed("hidden",1)
		
		end
	
	end
	
	luaMissionCompletedNew(Mission.HQ, "The Americans have been repelled - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		luaDelay(luaHidePh2Score, 1)
		
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