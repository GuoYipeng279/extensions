---- GERMAN MISSION #2 (KMS) ----

-- Scripted & Assembled by: Team Wolfpack

---- GERMAN MISSION #2 (KMS) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(109) 	-- Swordfish
	
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
	
	LoadMessageMap("kmsdlg",2)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/KMS/kms_2.lua"

	this.Name = "KMS2"
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
				["Text"] = "Sink all enemy cargo ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "CVs",
				["Text"] = "Sink both of the enemy carriers!",
				["TextCompleted"] = "Both of the enemy carriers are sinking!",
				["TextFailed"] = "One of the carriers has escaped!",
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
				["Text"] = "Ensure the survival of all your submarines!",
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
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO3",
				},
				{
					["type"] = "pause",
					["time"] = 6,
				},
				{
					["message"] = "INTRO4",
				},
			},
		},
		["SUPPLY"] = {--
			["sequence"] = {
				{
					["message"] = "SUPPLY1",
				},
				{
					["message"] = "SUPPLY2",
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
			},
		},
		["MAYDAY"] = {--
			["sequence"] = {
				{
					["message"] = "MAYDAY1",
				},
				{
					["message"] = "MAYDAY2",
				},
			},
		},
		["GERMANS"] = {--
			["sequence"] = {
				{
					["message"] = "GERMANS1",
				},
				{
					["message"] = "GERMANS2",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "SURFACE1",
				},
				{
					["message"] = "SURFACE2",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "SURFACE3",
				},
				{
					["message"] = "SURFACE4",
				},
				{
					["message"] = "SURFACE5",
				},
				{
					["message"] = "SURFACE6",
				},
				{
					["message"] = "SURFACE7",
				},
				{
					["message"] = "SURFACE8",
				},
				{
					["message"] = "SURFACE9",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
			},
		},
		--[[["RAID"] = {
			["sequence"] = {
				{
					["message"] = "RAID1",
				},
				{
					["message"] = "RAID2",
				},
			},
		},]]
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "FINAL3",
				},
				{
					["message"] = "FINAL4",
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
	
	---- KMS ----
	
	Mission.Subs = {}
		table.insert(Mission.Subs, FindEntity("U-53"))
		table.insert(Mission.Subs, FindEntity("U-84"))
		table.insert(Mission.Subs, FindEntity("U-115"))
		table.insert(Mission.Subs, FindEntity("U-69"))
		table.insert(Mission.Subs, FindEntity("U-37"))
	
	for idx,unit in pairs(Mission.Subs) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		EntityTurnToEntity(unit, FindEntity("Cargo-22"))
		
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	Mission.Germans = {}
		table.insert(Mission.Germans, FindEntity("U-53"))
		table.insert(Mission.Germans, FindEntity("U-84"))
		table.insert(Mission.Germans, FindEntity("U-115"))
		table.insert(Mission.Germans, FindEntity("U-69"))
		table.insert(Mission.Germans, FindEntity("U-37"))
	
	Mission.Italians = {}
	
	---- GB ----
	
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
		table.insert(Mission.Cargos, FindEntity("Cargo-11"))
		table.insert(Mission.Cargos, FindEntity("Cargo-12"))
		table.insert(Mission.Cargos, FindEntity("Cargo-13"))
		table.insert(Mission.Cargos, FindEntity("Cargo-14"))
		table.insert(Mission.Cargos, FindEntity("Cargo-15"))
		table.insert(Mission.Cargos, FindEntity("Cargo-16"))
		table.insert(Mission.Cargos, FindEntity("Cargo-17"))
		table.insert(Mission.Cargos, FindEntity("Cargo-18"))
		table.insert(Mission.Cargos, FindEntity("Cargo-19"))
		table.insert(Mission.Cargos, FindEntity("Cargo-20"))
		table.insert(Mission.Cargos, FindEntity("Cargo-21"))
		table.insert(Mission.Cargos, FindEntity("Cargo-22"))
		table.insert(Mission.Cargos, FindEntity("Cargo-23"))
		table.insert(Mission.Cargos, FindEntity("Cargo-24"))
		table.insert(Mission.Cargos, FindEntity("Cargo-25"))
		table.insert(Mission.Cargos, FindEntity("Cargo-26"))
		table.insert(Mission.Cargos, FindEntity("Cargo-27"))
		table.insert(Mission.Cargos, FindEntity("Cargo-28"))
		table.insert(Mission.Cargos, FindEntity("Cargo-29"))
		table.insert(Mission.Cargos, FindEntity("Cargo-30"))
		table.insert(Mission.Cargos, FindEntity("Cargo-31"))
		table.insert(Mission.Cargos, FindEntity("Cargo-32"))
		table.insert(Mission.Cargos, FindEntity("Cargo-33"))
		table.insert(Mission.Cargos, FindEntity("Cargo-34"))
		table.insert(Mission.Cargos, FindEntity("Cargo-35"))
		table.insert(Mission.Cargos, FindEntity("Cargo-36"))
		table.insert(Mission.Cargos, FindEntity("Cargo-37"))
		table.insert(Mission.Cargos, FindEntity("Cargo-38"))
		table.insert(Mission.Cargos, FindEntity("Cargo-39"))
		table.insert(Mission.Cargos, FindEntity("Cargo-40"))
		table.insert(Mission.Cargos, FindEntity("Cargo-41"))
		table.insert(Mission.Cargos, FindEntity("Cargo-42"))
	
	for idx,unit in pairs(Mission.Cargos) do
		
		local pos = GetPosition(unit)
		local offset = 200
		pos.x = pos.x + luaRnd(-(offset), offset)
		pos.z = pos.z + luaRnd(-(offset), offset)
		
		PutTo(unit, pos)
		
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
		table.insert(Mission.CVs, FindEntity("Unicorn"))
		table.insert(Mission.CVs, FindEntity("Eagle"))
	
	for idx,unit in pairs(Mission.CVs) do
		
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
	
	Mission.Runners = luaSumTablesIndex(Mission.Cargos, Mission.CVs)
	
	for idx,unit in pairs(Mission.Runners) do
	
		if Mission.Difficulty == 0 then
		
			SetShipMaxSpeed(unit, 4.5)
			
		elseif Mission.Difficulty == 1 then
		
			SetShipMaxSpeed(unit, 5.5)
			
		elseif Mission.Difficulty == 2 then
		
			SetShipMaxSpeed(unit, 6.5)
			
		end
	
	end
	
	Mission.DDs = {}
	
	if Mission.Difficulty == 0 then
		
		Mission.DDsAllowed = 2
	
	elseif Mission.Difficulty == 1 then
		
		Mission.DDsAllowed = 3
		
	elseif Mission.Difficulty == 2 then
	
		Mission.DDsAllowed = 3
		
	end
	
	local possibleDDPos = {
	
		[1] = {["x"] = -1500, ["y"] = 0, ["z"] = 750},
		
		[2] = {["x"] = -1500, ["y"] = 0, ["z"] = -750},
		
		[3] = {["x"] = -2250, ["y"] = 0, ["z"] = 1750},
		
		[4] = {["x"] = -2250, ["y"] = 0, ["z"] = -1750},
		
	}
	
	local ddNames = {"HMS Bulldog", "HMS Fearless", "HMS Javelin", "HMS Garth"}
	
	for i = 1, Mission.DDsAllowed do
	
		local dd = GenerateObject("Icarus")
		
		local idx = random(1, table.getn(possibleDDPos))
		local pos = possibleDDPos[idx]
		
		PutTo(dd, pos)
		
		SetSkillLevel(dd, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(dd, true)
		NavigatorSetAvoidLandCollision(dd, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(dd, false)
			RepairEnable(dd, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(dd, true)
			RepairEnable(dd, true)
		
		end
		
		SetGuiName(dd, ddNames[i])
		
		table.remove(possibleDDPos, idx)
		
		table.insert(Mission.DDs, dd)
		
	end
	
	Mission.Catalinas = {}
		table.insert(Mission.Catalinas, "Catalina-1")
		table.insert(Mission.Catalinas, "Catalina-2")
		table.insert(Mission.Catalinas, "Catalina-3")
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.CVSlots = 1
		Mission.CatalinaDelay = 200
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.CVSlots = 1
		Mission.CatalinaDelay = 150
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.CVSlots = 2
		Mission.CatalinaDelay = 100
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("October 11th, 1941 - The Mediterranean Sea")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
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
	
	--luaShowPath(FindEntity("PHMovingInPathSouth"))
	
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
			
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cargos)) == 0 then
				
					if Mission.MissionPhase == 2 then
					
						luaStartDialog("FINAL")
					
					else
					
						luaMissionComplete()
					
					end
					
					Mission.EndMission = true
					
				else
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Germans)) == 0 then
					
						luaMissionFailed()
					
					end
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cargos)) do
					
						if unit and not unit.Dead then
						
							local untPos = GetPosition(unit)
					
							if IsInBorderZone(untPos) then
							
								luaMissionFailed()
							
							end
						
						end
					
					end
					
					if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) == 0 then
					
						if luaObj_IsActive("secondary", 1) then
						
							luaObj_Completed("secondary", 1, true)
						
						end
					
					else
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
							
							if unit and not unit.Dead then
								
								local untPos = GetPosition(unit)
								
								if IsInBorderZone(untPos) then
								
									Kill(unit, true)
									
									if luaObj_IsActive("secondary", 1) then
									
										luaObj_Failed("secondary", 1, true)
									
									end
								
								else
								
									local stloPlaneNum, stloPlaneTable= luaGetSlotsAndSquads(unit)
									
									if stloPlaneNum < Mission.CVSlots and IsReadyToSendPlanes(unit) then
										
										local planeTypes = {
										109,
										109,
										}
										
										local plane = luaPickRnd(planeTypes)
										
										local trg
										local ammo
										
										if table.getn(luaRemoveDeadsFromTable(Mission.Italians)) > 0 then
										
											trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Italians))
											
											ammo = 1
											
										else
										
											trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
											
											ammo = 3
											
										end
										
										if trg and not trg.Dead then
										
											local slotIndex = LaunchSquadron(unit,plane,2,ammo)
											local launchedWildcat = thisTable[tostring(GetProperty(unit, "slots")[slotIndex].squadron)]
											
											SetSkillLevel(launchedWildcat, Mission.SkillLevel)
											
											PilotSetTarget(launchedWildcat, trg)
										
										end
										
									end
								
								end
								
							end
							
						end
					
					end
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) < 5 then
				
					luaObj_Failed("hidden", 1)
					
					luaStartDialog("MAYDAY")
					
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

function luaCatalinaFlow()

	if not Mission.EndMission and table.getn(luaRemoveDeadsFromTable(Mission.Italians)) > 0 then
		
		local spawnIdx = luaRnd(1,3)
		local name
		
		if spawnIdx == 1 then
		
			name = "Catalina-1"
		
		elseif spawnIdx == 2 then
		
			name = "Catalina-2"
		
		elseif spawnIdx == 3 then
		
			name = "Catalina-3"
		
		end
		
		local catalina = GenerateObject(name)
		
		SetSkillLevel(catalina, Mission.SkillLevel)
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Italians))
		
		PilotSetTarget(catalina, trg)
		
		luaDelay(luaCatalinaFlow, Mission.CatalinaDelay)
	
	end

end

function luaScatterConvoy()

	if table.getn(luaRemoveDeadsFromTable(Mission.Runners)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Runners)) do
		
			if unit and not unit.Dead then
			
				NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))
			
			end
		
		end
	
	end

end

function luaMoveToPh2()
	
	if Mission.EndMission then
	
		return
	
	end
	
	Mission.MissionPhase = 2
	
	table.insert(Mission.Italians, GenerateObject("Giulio Cesare"))
	table.insert(Mission.Italians, GenerateObject("Torino"))
	
	for idx,unit in pairs(Mission.Italians) do
		
		JoinFormation(unit, Mission.Italians[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	table.insert(Mission.Germans, FindEntity("Giulio Cesare"))
	table.insert(Mission.Germans, FindEntity("Torino"))
	
	luaDelay(luaItaliansDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.Italians[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 14, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	}, luaPh2MovieEnd, true)
	
end

function luaItaliansDia()

	luaStartDialog("GERMANS")

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.Italians)))
	
	end

end

function luaAddSecObjs()

	luaObj_Add("secondary", 1, Mission.CVs)
	
	luaScatterConvoy()
	
	luaDelay(luaCatalinaFlow, Mission.CatalinaDelay)
	
end

---- PHASE 1 ----

function luaIntroMovie1()

	luaDelay(luaIntroDia, 5)
	
	local trg1 = FindEntity("U-53")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 100, ["theta"] = -4, ["rho"] = -325, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = -4, ["rho"] = -325, ["moveTime"] = 12},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5,["y"]=2,["z"]=10},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=200},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=2,["z"]=200},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5,["y"]=2,["z"]=-20},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-800,["y"]=200,["z"]=-200},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3000,["y"]=0,["z"]=0},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3000,["y"]=0,["z"]=0},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-800,["y"]=200,["z"]=-50},["parent"] = nil,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Subs[1])
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Cargos)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Cargos), "Sink all enemy cargo ships!")
	
	luaDelay(luaSupplyDia, 4)
	luaDelay(luaMakeDDsAttack, 20)
	luaDelay(luaMoveToPh2, 360)
	
end

function luaSupplyDia()

	luaStartDialog("SUPPLY")

end

function luaMakeDDsAttack()

	if table.getn(luaRemoveDeadsFromTable(Mission.DDs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.DDs)) do
		
			if unit and not unit.Dead then
			
				UnitSetFireStance(unit, 2)
				
			end
			
		end
		
	end
	
	luaStartDialog("DESTROYER")
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	local unit
	
	if Mission.MissionPhase == 2 then
	
		unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.Italians))
	
	else
	
		unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
	
	end
	
	luaMissionCompletedNew(unit, "The convoy has been decimated - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
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