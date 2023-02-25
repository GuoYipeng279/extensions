---- CRUISER HUNTERS (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- CRUISER HUNTERS (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	--PrepareClass(150) -- Zero
	
	PrepareClass(113) -- TBF
	PrepareClass(112) -- TBD
	PrepareClass(109) -- Swordfish
	
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
	
	LoadMessageMap("ijndlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_04_cruiser_hunters.lua"

	this.Name = "IJN04"
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
				["Text"] = "Sink the ABDACOM cruisers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Sink all enemy transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Repel the air raid!",
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
				["Text"] = "Don't lose any battleships!",
				["TextFailed"] = "One of our battleships is sinking!",
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
					["message"] = "idlg01",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["type"] = "pause",
					["time"] = 8,
				},
				{
					["message"] = "idlg03",
				},
				{
					["type"] = "pause",
					["time"] = 12,
				},
				{
					["message"] = "idlg02_1",
				},
			},
		},
		["PLANES"] = {--
			["sequence"] = {
				{
					["message"] = "PLANES1",
				},
				--[[{
					["message"] = "PLANES2",
				},
				{
					["message"] = "PLANES3",
				},]]
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "dlg16",
				},
				{
					["message"] = "dlg16_1",
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
	
	Mission.Haruna = FindEntity("Haruna")
	Mission.Kirishima = FindEntity("Kirishima")
	
	Mission.BruhGang = {}
		table.insert(Mission.BruhGang, Mission.Haruna)
		table.insert(Mission.BruhGang, FindEntity("Chokai"))
		table.insert(Mission.BruhGang, FindEntity("Tama"))
		table.insert(Mission.BruhGang, FindEntity("Yukikaze"))
	
	for idx,unit in pairs(Mission.BruhGang) do
		
		JoinFormation(unit, Mission.BruhGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		SetCatapultStock(unit, 0)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.BrahGang = {}
		table.insert(Mission.BrahGang, Mission.Kirishima)
		table.insert(Mission.BrahGang, FindEntity("Oi"))
		table.insert(Mission.BrahGang, FindEntity("Yudachi"))
	
	for idx,unit in pairs(Mission.BrahGang) do
		
		JoinFormation(unit, Mission.BrahGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		SetCatapultStock(unit, 0)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.RllyBruh = {}
		table.insert(Mission.RllyBruh, Mission.Haruna)
		table.insert(Mission.RllyBruh, Mission.Kirishima)
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, Mission.Haruna)
		table.insert(Mission.JapGang, FindEntity("Chokai"))
		table.insert(Mission.JapGang, FindEntity("Tama"))
		table.insert(Mission.JapGang, FindEntity("Yukikaze"))
		table.insert(Mission.JapGang, Mission.Kirishima)
		table.insert(Mission.JapGang, FindEntity("Oi"))
		table.insert(Mission.JapGang, FindEntity("Yudachi"))
	
	---- USN ----
	
	Mission.CringeGang = {}
		table.insert(Mission.CringeGang, FindEntity("Salt Lake City"))
		table.insert(Mission.CringeGang, FindEntity("Boston"))
		table.insert(Mission.CringeGang, FindEntity("Houston"))
		table.insert(Mission.CringeGang, FindEntity("Fletcher-class01"))
		table.insert(Mission.CringeGang, FindEntity("Fletcher-class02"))
		table.insert(Mission.CringeGang, FindEntity("Fletcher-class03"))
		table.insert(Mission.CringeGang, FindEntity("Fletcher-class04"))
		table.insert(Mission.CringeGang, FindEntity("Fletcher-class05"))
	
	Mission.CrangeGang = {}
		table.insert(Mission.CrangeGang, FindEntity("Boise"))
		table.insert(Mission.CrangeGang, FindEntity("St. Louis"))
		table.insert(Mission.CrangeGang, FindEntity("Montpellier"))
		table.insert(Mission.CrangeGang, FindEntity("Cleveland"))
		table.insert(Mission.CrangeGang, FindEntity("Fletcher-class06"))
		table.insert(Mission.CrangeGang, FindEntity("Fletcher-class07"))
		table.insert(Mission.CrangeGang, FindEntity("Fletcher-class08"))
		table.insert(Mission.CrangeGang, FindEntity("Fletcher-class09"))
		table.insert(Mission.CrangeGang, FindEntity("Fletcher-class10"))
	
	Mission.NahG = {}
		table.insert(Mission.NahG, FindEntity("Salt Lake City"))
		table.insert(Mission.NahG, FindEntity("Boston"))
		table.insert(Mission.NahG, FindEntity("Houston"))
		table.insert(Mission.NahG, FindEntity("Boise"))
		table.insert(Mission.NahG, FindEntity("St. Louis"))
		table.insert(Mission.NahG, FindEntity("Montpellier"))
		table.insert(Mission.NahG, FindEntity("Cleveland"))
	
	luaMoveUSFleetsRandomly(random(1,2))
	
	for idx,unit in pairs(Mission.CringeGang) do
		
		JoinFormation(unit, Mission.CringeGang[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	for idx,unit in pairs(Mission.CrangeGang) do
		
		JoinFormation(unit, Mission.CrangeGang[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.USGang = {}
		table.insert(Mission.USGang, FindEntity("Salt Lake City"))
		table.insert(Mission.USGang, FindEntity("Boston"))
		table.insert(Mission.USGang, FindEntity("Houston"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class01"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class02"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class03"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class04"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class05"))
		table.insert(Mission.USGang, FindEntity("Boise"))
		table.insert(Mission.USGang, FindEntity("St. Louis"))
		table.insert(Mission.USGang, FindEntity("Montpellier"))
		table.insert(Mission.USGang, FindEntity("Cleveland"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class06"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class07"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class08"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class09"))
		table.insert(Mission.USGang, FindEntity("Fletcher-class10"))
	
	Mission.USAttackers = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.USAttackWaves = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.TorpNum = 5
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.TorpNum = 5
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.TorpNum = 5
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	SetSimplifiedReconMultiplier(10)
	
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
			
			if table.getn(luaRemoveDeadsFromTable(Mission.JapGang)) == 0 then
				
				if luaObj_IsActive("primary", 1) or luaObj_IsActive("primary", 2) or luaObj_IsActive("primary", 3) then
				
					HideUnitHP()
				
				end
				
				luaMissionFailed()
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.RllyBruh)) <= 1 then
				
					luaObj_Failed("secondary", 1, true)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.NahG)) == 0 then
				
					HideUnitHP()
					
					luaObj_Completed("primary", 1, true)
					
					Blackout(true, "luaMoveToPh2", 3)
				
				end
			
			end
			
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CargoGang)) == 0 and not Mission.FuckYou then
				
					HideUnitHP()
					
					luaObj_Completed("primary", 2, true)
					
					Blackout(true, "luaMoveToPh3", 3)
					
					Mission.FuckYou = true
					
				end
			
			end
			
		elseif Mission.MissionPhase == 3 then
		
			if not Mission.OhMyFuckingGOD then
			
				if Mission.USAttackWaves == 3 then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USAttackers)) do
						
							if unit and not unit.Dead then
							
								local ammo = GetProperty(unit, "ammoType")
								
								if ammo == 0 then
								
									table.remove(Mission.USAttackers, idx)
									luaObj_RemoveUnit("primary", 3, unit)
									
								end
								
							end
						
						end
					
					elseif table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) == 0 or Mission.CanComplete then
					
						HideUnitHP()
					
						luaObj_Completed("primary", 3, true)
						
						luaStartDialog("FINAL")
						
						Blackout(true, "luaFinalMovie", 1)
						
						Mission.OhMyFuckingGOD = true
						Mission.EndMission = true
					
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

function luaFinalMovie()
	
	Mission.SelUnit = GetSelectedUnit()
	
	Blackout(false, "", 1)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.SelUnit, ["distance"] = 200, ["theta"] = 55, ["rho"] = 100, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = Mission.SelUnit, ["distance"] = 500, ["theta"] = 15, ["rho"] = 70, ["moveTime"] = 17,},
		
	}, luaFinalMovieEnd, true)

end

function luaFinalMovieEnd()

	

end

--[[function luaSpawnRyujo()

	Mission.Ryujo = GenerateObject("Ryujo")
	local ship2 = GenerateObject("Hayate")
	local ship3 = GenerateObject("Abakaze")
	
	Mission.RyujoGang = {}
		table.insert(Mission.RyujoGang, Mission.Ryujo)
		table.insert(Mission.RyujoGang, ship2)
		table.insert(Mission.RyujoGang, ship3)
	
	table.insert(Mission.JapGang, Mission.Ryujo)
	table.insert(Mission.JapGang, ship2)
	table.insert(Mission.JapGang, ship3)
	
	for idx,unit in pairs(Mission.RyujoGang) do
		
		JoinFormation(unit, Mission.RyujoGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		SetCatapultStock(unit, 0)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	AddAirBaseStock(Mission.Ryujo, 150, 9)
	
	LaunchSquadron(Mission.Ryujo, 150, 3)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "camera", ["position"]={["parent"] = Mission.Ryujo, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "target", ["target"] = Mission.Ryujo, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ryujo, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 6, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	  
	}, luaRyujoMovieEnd, true)
	
end

function luaRyujoMovieEnd()

	SetSelectedUnit(Mission.Ryujo)

end]]

function luaMoveToPh3()
	
	--Loading_Start()
	
	Mission.MissionPhase = 3
	
	Mission.SelUnit = GetSelectedUnit()
	
	--if not Mission.Debug then
	
		if table.getn(luaRemoveDeadsFromTable(Mission.ConvoyGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ConvoyGang)) do
				
				if unit and not unit.Dead then
					
					Kill(unit, true)
					
				end
				
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				luaObj_Failed("hidden",1)
			
			end
			
		else
		
			if luaObj_IsActive("hidden", 1) and Mission.FirstPhaseAllKilled then
			
				luaObj_Completed("hidden",1)
			
			end
			
		end
	
	--end
	
	luaSpawnNextAmericanWave()
	
	--[[if Mission.Difficulty < 2 then
		
		local ship1 = GenerateObject("Harugumo")
		local ship2 = GenerateObject("Kitakaze")
		
		SetSkillLevel(ship1, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(ship1, true)
		NavigatorSetAvoidLandCollision(ship1, true)
		SetSkillLevel(ship2, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(ship2, true)
		NavigatorSetAvoidLandCollision(ship2, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(ship1, true)
			RepairEnable(ship2, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(ship1, false)
			RepairEnable(ship2, false)
		
		end
		
		JoinFormation(ship2, ship1)
		
		table.insert(Mission.JapGang, ship1)
		table.insert(Mission.JapGang, ship2)
		
	end]]
	
	--Loading_Finish()
	
end

function luaPh3Movie(unit)
	
	Blackout(false, "", 3)
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	luaDelay(luaPlanesDia, 2)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 8},
	  
	}, luaPh3MovieEnd, true)

end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang)))
		
	end
	
end

function luaSpawnNextAmericanWave()
	
	if Mission.USAttackWaves == 0 then
	
		luaObj_Add("primary", 3)
		
		DisplayUnitHP((luaRemoveDeadsFromTable(Mission.JapGang)), "Repel the air raid!")
	
	elseif Mission.USAttackWaves == 1 then
	
		--luaSpawnRyujo()
	
	end
	
	local planeTypes = {109, 112, 113}
	
	for i = 1, Mission.TorpNum do
		
		luaSpawnAmerican(luaPickRnd(planeTypes), 3, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))), 1, random(-6000,-4500), random(500,700), random(-2000,2000))
		
	end
	
	Mission.USAttackWaves = Mission.USAttackWaves + 1
	
	if Mission.USAttackWaves < 3 then
	
		luaDelay(luaSpawnNextAmericanWave, 105)
	
	else
	
		luaDelay(luaCanComplete, 105)
	
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

	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))
	local unitPos = GetPosition(unit)
	
	SetSkillLevel(unit, Mission.SkillLevel)
	SquadronSetSpeed(unit, KMH(150))
	EntityTurnToEntity(unit, trg)
	SquadronSetTravelAlt(unit, unitPos.y, true)
	PilotSetTarget(unit, trg)
	UnitSetFireStance(unit, 2)
	
	table.insert(Mission.USAttackers, unit)
	
	if luaObj_IsActive("primary",3) then
	
		luaObj_AddUnit("primary", 3, unit)
	
	end
	
	if not Mission.FinalMovieSet then
		
		luaPh3Movie(unit)
		
		Mission.FinalMovieSet = true
		
	end
	
end

function luaCanComplete()

	Mission.CanComplete = true

end

function luaPlanesDia()

	luaStartDialog("PLANES")

end

---- PHASE 2 ----

function luaMoveToPh2()

	--Loading_Start()
	
	Mission.MissionPhase = 2
	
	Mission.SelUnit = GetSelectedUnit()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.USGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGang)) do
			
			if unit and not unit.Dead then
				
				Kill(unit, true)
				
			end
			
		end
	
	else
	
		Mission.FirstPhaseAllKilled = true
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapGang)) do
		
		if unit and not unit.Dead then
			
			local unitPos = GetPosition(unit)
			
			if unitPos.z > 0 then
			
				unitPos.z = unitPos.z - 3000
				
				if IsLandscape(unitPos) then
				
					unitPos.z = unitPos.z - 2000
				
				end
				
				PutTo(unit, unitPos)
				
			end
			
		end
		
	end
	
	local ship1 = GenerateObject("Cargo-01")
	local ship2 = GenerateObject("Cargo-02")
	local ship3 = GenerateObject("Cargo-03")
	local ship4 = GenerateObject("Cargo-04")
	local ship5 = GenerateObject("Cargo-05")
	local ship6 = GenerateObject("Cargo-06")
	local ship7 = GenerateObject("Cargo-07")
	local ship8 = GenerateObject("Cargo-08")
	local ship9 = GenerateObject("Cargo-09")
	local ship10 = GenerateObject("Cargo-10")
	local ship11 = GenerateObject("DeRuyter")
	local ship12 = GenerateObject("Sumatra")
	local ship13 = GenerateObject("Java")
	local ship14 = GenerateObject("ConvoyEsc-01")
	local ship15 = GenerateObject("ConvoyEsc-02")
	local ship16 = GenerateObject("ConvoyEsc-03")
	local ship17 = GenerateObject("ConvoyEsc-04")
	local ship18 = GenerateObject("ConvoyEsc-05")
	local ship19 = GenerateObject("ConvoyEsc-06")
	
	Mission.ConvoyGang = {}
		table.insert(Mission.ConvoyGang, ship1)
		table.insert(Mission.ConvoyGang, ship2)
		table.insert(Mission.ConvoyGang, ship3)
		table.insert(Mission.ConvoyGang, ship4)
		table.insert(Mission.ConvoyGang, ship5)
		table.insert(Mission.ConvoyGang, ship6)
		table.insert(Mission.ConvoyGang, ship7)
		table.insert(Mission.ConvoyGang, ship8)
		table.insert(Mission.ConvoyGang, ship9)
		table.insert(Mission.ConvoyGang, ship10)
		table.insert(Mission.ConvoyGang, ship11)
		table.insert(Mission.ConvoyGang, ship12)
		table.insert(Mission.ConvoyGang, ship13)
		table.insert(Mission.ConvoyGang, ship14)
		table.insert(Mission.ConvoyGang, ship15)
		table.insert(Mission.ConvoyGang, ship16)
		table.insert(Mission.ConvoyGang, ship17)
		table.insert(Mission.ConvoyGang, ship18)
		table.insert(Mission.ConvoyGang, ship19)
		
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, ship1)
		table.insert(Mission.CargoGang, ship2)
		table.insert(Mission.CargoGang, ship3)
		table.insert(Mission.CargoGang, ship4)
		table.insert(Mission.CargoGang, ship5)
		table.insert(Mission.CargoGang, ship6)
		table.insert(Mission.CargoGang, ship7)
		table.insert(Mission.CargoGang, ship8)
		table.insert(Mission.CargoGang, ship9)
		table.insert(Mission.CargoGang, ship10)
		
	local bruh = random(1,2)
	local moveIdx
	
	if bruh == 1 then
	
		moveIdx = 3500
	
	elseif bruh == 2 then
	
		moveIdx = -3500
	
	end
	
	for idx,unit in pairs(Mission.ConvoyGang) do
		
		local unitPos = GetPosition(unit)
		unitPos.x = unitPos.x + moveIdx
		
		PutTo(unit, unitPos)
		
	end
	
	for idx,unit in pairs(Mission.ConvoyGang) do
		
		JoinFormation(unit, Mission.ConvoyGang[2])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	--Loading_Finish()
	
	luaPh2Movie()
	
end

function luaPh2Movie()

	Blackout(false, "", 3)
	
	local trg1 = FindEntity("Sumatra")
	local trg2 = FindEntity("Cargo-02")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 5, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 15, ["moveTime"] = 14, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
    	
		--{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 15, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		--{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 5, ["rho"] = 195, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	},	
	luaPh2MovieEnd, true)
	
end

function luaPh2MovieEnd()
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang)))
		
	end
	
	luaAddSecondObjs()

end

function luaAddSecondObjs()

	luaObj_Add("primary", 2, Mission.CargoGang)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.CargoGang)), "Sink all enemy transports!")
	
	luaDelay(luaConvoyScatter, 60)
	
end

function luaConvoyScatter()
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ConvoyGang)) do
		
		if unit and not unit.Dead then
			
			if unit.Class.Type == "Destroyer" and Mission.Difficulty > 0 then
			
				local trgs
	
				if table.getn(luaRemoveDeadsFromTable(Mission.RllyBruh)) > 0 then
				
					trgs = luaRemoveDeadsFromTable(Mission.RllyBruh)
				
				else
				
					trgs = luaRemoveDeadsFromTable(Mission.JapGang)
				
				end
				
				local ordered1 = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
				local trg1 = ordered1[1]
				
				NavigatorAttackMove(unit, trg1)
				
			--[[else
			
				NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))]]
			
			end
			
		end
		
	end

end

---- PHASE 1 ----

function luaIntroMovie1()
	
	Blackout(false, "", 1)
	
	Mission.MovieSub = FindEntity("MovieSub")
	
	UnitSetFireStance(Mission.MovieSub, 0)
	ForceSubmarinePeriscope(Mission.MovieSub, true)
	SetForcedReconLevel(Mission.MovieSub, 0, PARTY_ALLIED)
	
	local subPosTrg
	local subPosDelta
	
	local fleetCam = 1500
	
	if Mission.BruhMoment == 1 then
	
		subPosTrg = Mission.CringeGang[1]
		subPosDelta = {fleetCam, fleetCam}
		
	elseif Mission.BruhMoment == 2 then
	
		subPosTrg = Mission.CrangeGang[1]
		subPosDelta = {-(fleetCam), fleetCam}
		
	end
	
	local subPos = GetPosition(subPosTrg)
	subPos.x = subPos.x + subPosDelta[1]
	subPos.y = subPos.y - 20
	subPos.z = subPos.z + subPosDelta[2]
	
	Mission.MovieTrg = subPosTrg
	
	PutTo(Mission.MovieSub, subPos)
	EntityTurnToEntity(Mission.MovieSub, Mission.MovieTrg)
	
	local trg1 = FindEntity("TempEnt1")
	local trg2 = FindEntity("TempEnt2")
	
	NavigatorEnable(trg1, false)
	NavigatorEnable(trg2, false)
	
	luaDelay(luaIntroText, 4)
	luaDelay(luaIntroDia, 10)
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=200,["z"]=105},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=200,["z"]=105},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=200,["z"]=105},["parent"] = nil,},["moveTime"] = 9,["transformtype"] = "keepall"},
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 11500, ["theta"] = 15, ["rho"] = 60, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 11500, ["theta"] = 15, ["rho"] = 80, ["moveTime"] = 13},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 11500, ["theta"] = 15, ["rho"] = 120, ["moveTime"] = 8},
	   
	}, luaIntroMovie2, true)
	
end

function luaIntroText()

	MissionNarrative("January 5th, 1942 - In the Sunda Strait")

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	Blackout(true, "luaIntroMovie3", 1)

end

function luaIntroMovie3()
	
	Blackout(false, "", 1)
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=0,["z"]=30},["parent"] = Mission.MovieSub,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=30},["parent"] = Mission.MovieSub,},["moveTime"] = 0,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=30},["parent"] = Mission.MovieSub,},["moveTime"] = 6,["transformtype"] = "keepall"},
	   
	   {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=25,["z"]=30},["parent"] = Mission.MovieSub,},["moveTime"] = 5,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=25,["z"]=5000},["parent"] = Mission.MovieSub,},["moveTime"] = 4,["transformtype"] = "keepall"},
	   {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=25,["z"]=5000},["parent"] = Mission.MovieSub,},["moveTime"] = 2,["transformtype"] = "keepall"},
	   
	   {["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 250, ["theta"] = 8, ["rho"] = 370, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 200, ["theta"] = 7, ["rho"] = 355, ["moveTime"] = 6},
	   {["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 150, ["theta"] = 6.5, ["rho"] = 355, ["moveTime"] = 4},
	   
	}, luaIntroMovie4, true)

end

function luaIntroMovie4()

	Blackout(true, "luaIntroMovieEnd", 3)

end

function luaIntroMovieEnd()
	
	SetSimplifiedReconMultiplier(1.5)
	
	Kill(FindEntity("TempEnt1"), true)
	Kill(FindEntity("TempEnt2"), true)
	Kill(Mission.MovieSub, true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Haruna"))
	
	EnableMessages(true)
	
	Blackout(false, "luaAddFirstObjs", 3)
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.NahG)
	luaObj_Add("secondary", 1, Mission.RllyBruh)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.NahG)), "Sink the ABDACOM cruisers!")
	
	--luaAddJapListener()
	
	Mission.CanMusicCheck = true
	
	--Music_Control_SetLevel(MUSIC_CALM)
	--luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	luaDelay(luaCAsAttack, 95)
	
end

function luaCAsAttack()

	local escorts = {}
	local trgs
	
	if Mission.Difficulty == 0 then
	
		trgs = luaRemoveDeadsFromTable(Mission.JapGang)
	
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.RllyBruh)) > 0 then
		
			trgs = luaRemoveDeadsFromTable(Mission.RllyBruh)
		
		else
		
			trgs = luaRemoveDeadsFromTable(Mission.JapGang)
		
		end
	
	end
	
	if Mission.Difficulty == 1 then
		
		local attackingEscorts
		local bruhMomentum = random(1,2)
		
		if bruhMomentum == 1 then
		
			attackingEscorts = Mission.CringeGang
		
		elseif bruhMomentum == 2 then
		
			attackingEscorts = Mission.CrangeGang
		
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(attackingEscorts)) do
		
			if unit and not unit.Dead then
			
				if unit.Class.Type == "Destroyer" then
					
					table.insert(escorts, unit)
					
				end
			
			end
		
		end
	
	elseif Mission.Difficulty == 2 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGang)) do
		
			if unit and not unit.Dead then
			
				if unit.Class.Type == "Destroyer" then
				
					table.insert(escorts, unit)
				
				end
			
			end
		
		end
	
	end
	
	if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(escorts)) do
			
			if unit and not unit.Dead then
				
				LeaveFormation(unit)
				
				local ordered1 = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
				local trg1 = ordered1[1]
				
				NavigatorAttackMove(unit, trg1)
				
			end
			
		end
	
	end
	
	local ordered2 = luaSortByDistance(Mission.CringeGang[1], luaRemoveDeadsFromTable(trgs))
	local trg2 = ordered2[1]
	
	NavigatorAttackMove(Mission.CringeGang[1], trg2)
	
	local ordered3 = luaSortByDistance(Mission.CrangeGang[1], luaRemoveDeadsFromTable(trgs))
	local trg3 = ordered3[1]
	
	NavigatorAttackMove(Mission.CrangeGang[1], trg3)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USGang)) do
		
		if unit and not unit.Dead then
		
			UnitSetFireStance(unit, 2)
		
		end
		
	end

end

function luaMoveUSFleetsRandomly(bruh)
	
	local moveIdx1
	local moveIdx2
	
	if bruh == 1 then
	
		moveIdx1 = random(-5500, 0)
		moveIdx2 = random(0, 5500)
	
	elseif bruh == 2 then
		
		for idx,unit in pairs(Mission.CringeGang) do
			
			local unitPos = GetPosition(unit)
			unitPos.x = -(unitPos.x)
			
			PutTo(unit, unitPos)
		
		end
		
		for idx,unit in pairs(Mission.CrangeGang) do
			
			local unitPos = GetPosition(unit)
			unitPos.x = -(unitPos.x)
			
			PutTo(unit, unitPos)
		
		end
		
		moveIdx1 = random(0, 5500)
		moveIdx2 = random(-5500, 0)
	
	end
	
	Mission.BruhMoment = bruh
	
	for idx,unit in pairs(Mission.CringeGang) do
		
		local unitPos = GetPosition(unit)
		unitPos.x = unitPos.x + moveIdx1
		
		PutTo(unit, unitPos)
	
	end
	
	for idx,unit in pairs(Mission.CrangeGang) do
		
		local unitPos = GetPosition(unit)
		unitPos.x = unitPos.x + moveIdx2
		
		PutTo(unit, unitPos)
	
	end
	
end

---- LISTENERS ----

--[[function luaAddJapListener()

	AddListener("recon", "JapListener", {
		["callback"] = "luaJapSighted",
		["entity"] = Mission.JapGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end]]

---- LISTENER CALLBACKS ----

--[[function luaJapSighted()

	RemoveListener("recon", "JapListener")
	
	luaDelay(luaCAsAttack, 13)
	
end]]

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
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(nil, "ABDACOM is no more - Mission Complete")
	
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