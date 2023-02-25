---- PRELUDE TO HAWAII (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- PRELUDE TO HAWAII (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(26) 	-- F6F
	PrepareClass(331) 	-- BTD
	PrepareClass(38) 	-- SB2C
	
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
	
	LoadMessageMap("ijndlg",7)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_18_prelude_hawaii.lua"

	this.Name = "IJN18"
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
				["Text"] = "Find and sink the enemy capital ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Raid",
				["Text"] = "Repel the air raid!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Carrier",
				["Text"] = "Sink all enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Survive",
				["Text"] = "Ensure survival of the Yamato and all carriers.",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Izumo",
				["Text"] = "Don't loose the Izumo!",
				["TextFailed"] = "The Izumo is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Con",
				["Text"] = "Sink the convoy!",
				["TextFailed"] = "The Izumo is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Escort",
				["Text"] = "Sink the convoys escorts!",
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
					["message"] = "idlg01d",
				},
				{
					["type"] = "pause",
					["time"] = 1,
				},
				{
					["message"] = "dlg6c",
				},
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["BTD"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6b",
				},
				{
					["message"] = "dlg6a",
				},
			},
		},
		["CV"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["END"] = {--
			["sequence"] = {
				{
					["message"] = "dlg10b",
				},
				{
					["message"] = "dlg13",
				},
				{
					["message"] = "dlg13_1",
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
	
	Mission.JapFleetA = {}
		table.insert(Mission.JapFleetA, FindEntity("Hakuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Kokuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Yamato"))
		table.insert(Mission.JapFleetA, FindEntity("Takao"))
		--table.insert(Mission.JapFleetA, FindEntity("Atago"))
		table.insert(Mission.JapFleetA, FindEntity("Harugumo"))
		table.insert(Mission.JapFleetA, FindEntity("Urazaki"))
		--table.insert(Mission.JapFleetA, FindEntity("Kochi"))
		table.insert(Mission.JapFleetA, FindEntity("Hae"))
		--table.insert(Mission.JapFleetA, FindEntity("Fuyugumo"))
	
	for idx,unit in pairs(Mission.JapFleetA) do
		
		JoinFormation(unit, Mission.JapFleetA[1])
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
	
	Mission.JapFleetB = {}
		table.insert(Mission.JapFleetB, FindEntity("Taiho"))
		--table.insert(Mission.JapFleetB, FindEntity("Ginryu"))
		table.insert(Mission.JapFleetB, FindEntity("Izumo"))
		--table.insert(Mission.JapFleetB, FindEntity("Zuiho"))
		table.insert(Mission.JapFleetB, FindEntity("Chokai"))
		--table.insert(Mission.JapFleetB, FindEntity("Maya"))
		--table.insert(Mission.JapFleetB, FindEntity("Minegumo"))
		table.insert(Mission.JapFleetB, FindEntity("Ichigumo"))
		table.insert(Mission.JapFleetB, FindEntity("Yamagumo"))
		table.insert(Mission.JapFleetB, FindEntity("Kyogumo"))
		--table.insert(Mission.JapFleetB, FindEntity("Kitakaze"))
	
	for idx,unit in pairs(Mission.JapFleetB) do
		
		JoinFormation(unit, Mission.JapFleetB[1])
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
	
	Mission.IJNShips = luaSumTablesIndex(Mission.JapFleetA, Mission.JapFleetB)
	
	Mission.JapCapitalShips = {}
		table.insert(Mission.JapCapitalShips, FindEntity("Taiho"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Ginryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Izumo"))
		table.insert(Mission.JapCapitalShips, FindEntity("Hakuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Kokuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Yamato"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Zuiho"))
	
	-- Secondary: Izumo --
	
	Mission.Izumo = {}
		table.insert(Mission.Izumo, FindEntity("Izumo"))
	
	---- USN ----
	
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
	
	Mission.USPatrolA = {}
		table.insert(Mission.USPatrolA, FindEntity("Nimitz"))
		table.insert(Mission.USPatrolA, FindEntity("Illinois"))
		table.insert(Mission.USPatrolA, FindEntity("Bremerton"))
		table.insert(Mission.USPatrolA, FindEntity("Helena"))
		table.insert(Mission.USPatrolA, FindEntity("Somers-class07"))
		table.insert(Mission.USPatrolA, FindEntity("Somers-class08"))
		
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
	
	
		
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(FindEntity("Nimitz"), 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Nimitz"), 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Nimitz"), 3)
				
			end
	
	-- USN CV --
	
	Mission.USNCV = {}
		table.insert(Mission.USNCV, FindEntity("Nimitz"))
	
	
	-- Objective Ship Tables --
	
	Mission.CapitalShips = {}
		table.insert(Mission.CapitalShips, FindEntity("Nimitz"))
		table.insert(Mission.CapitalShips, FindEntity("Illinois"))

	-- cargo table --
	
	Mission.Cargo = {}
		table.insert(Mission.Cargo, FindEntity("Cargo-01"))
		table.insert(Mission.Cargo, FindEntity("Cargo-02"))
		table.insert(Mission.Cargo, FindEntity("Cargo-03"))
		table.insert(Mission.Cargo, FindEntity("Cargo-04"))
		table.insert(Mission.Cargo, FindEntity("Cargo-05"))
		table.insert(Mission.Cargo, FindEntity("Cargo-06"))
	
	-- Destroyer Table -- 
	
	Mission.Wave = {}
		table.insert(Mission.Wave, "Destroyer_Spawn01")
		table.insert(Mission.Wave, "Destroyer_Spawn02")
		table.insert(Mission.Wave, "Destroyer_Spawn03")
		table.insert(Mission.Wave, "Destroyer_Spawn04")
	
	-- BTD Wave --
	
	Mission.BTD = {}
		
	-- Hidden Obj Table --
	Mission.Hidden = {}
		table.insert(Mission.Hidden, FindEntity("Fletcher-class07"))
		table.insert(Mission.Hidden, FindEntity("Fletcher-class08"))	
	
	-- Path --
	
	local pathIdx = luaRnd(1,2)
    local pathDir

    if pathIdx == 1 then

        pathDir = PATH_SM_JOIN

    elseif pathIdx == 2 then

        pathDir = PATH_SM_JOIN_BACKWARDS

    end

    NavigatorMoveOnPath(Mission.USPatrolA[1], FindEntity("CVPath1"), PATH_FM_CIRCLE, pathDir)
	
	--Convoy Nav --
	
	NavigatorMoveToRange(FindEntity("Cargo-01"), FindEntity("ConvoyNav"))
	
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	Mission.AttackWaves = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("December 7th, 1943 - Near Hawaii")
	
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
	
	--luaShowPoint(FindEntity("ConvoyNav"))
	
	--luaShowPath(FindEntity("CVPath2"))
	
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
			
			if luaObj_IsActive("primary", 5) then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) <= 4 then
					
						luaMissionFailed()
				
					end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Izumo)) == 0 then
					
						luaObj_Failed("secondary", 1, true)
				
					end
				
			end
			
			if luaObj_IsActive("secondary", 2) then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Cargo)) == 0 then
					
						HideUnitHP()
					
						luaObj_Completed("secondary", 2, true)				
				
					end
				
			end
			
			if luaObj_IsActive("hidden", 1) then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.Hidden)) == 0 then
					
						HideUnitHP()
					
						luaObj_Completed("hidden", 1, true)				
				
					end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.USNCV)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNCV)) do
					
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 26,
						
						}
						local bombers = {
							[1] = 38,
							[2] = 331,
						}
						
						
						local trgs = luaGetUSPlaneTrg()
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
			
		end
		
			if Mission.MissionPhase == 1 then
			
				if luaObj_IsActive("primary", 1) then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) == 0 then
					
						HideUnitHP()
					
						luaObj_Completed("primary", 1, true)
					
						luaPh1FadeOut()
				
				
					end
				
				end
				
		
		
			elseif Mission.MissionPhase == 2 then
		
		if luaObj_IsActive("primary", 3) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.BTD)) == 0 then 
			if Mission.AttackWaves == 3 then
			
			luaObj_Completed("primary", 3, true)
			luaMoveToPh3()
				
				end
				
				else 
                
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BTD)) do

                    if unit and not unit.Dead then

                        local ammo = GetProperty(unit, "ammoType")

                        if ammo ~= 0 then

                            if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then

                                local trgs = Mission.IJNShips

                                if Mission.Difficulty == 2 then

                                    trgs = Mission.JapCapitalShips

                                

                                end

                              
                                local closest = luaPickRnd(luaRemoveDeadsFromTable(trgs))

                                luaSetScriptTarget(unit, closest)
                                NavigatorAttackMove(unit, closest)

                            end

                        end

                    end

                end

            end
		
		end
		
		elseif Mission.MissionPhase == 3 then
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USNCV)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 4, true)
				
					luaStartDialog("END")

					Mission.EndMission = true
			
				end
			
			end
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 1 ----
function luaPh1FadeOut()
Blackout(true, "luaMoveToPh2", 1)
end

function luaIntroMovie()

	
	--local trg1 = Mission.Convoy[1]
	--local trg2 = Mission.Bombers[1]
	
	
	luaDelay(luaIntroDia, 2)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 400, ["theta"] = 12, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 400, ["theta"] = 12, ["rho"] = 45, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 350, ["theta"] = 20, ["rho"] = 180, ["moveTime"] = 3, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 350, ["theta"] = 20, ["rho"] = 180, ["moveTime"] = 3, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Nimitz"), ["distance"] = 1000, ["theta"] = 18, ["rho"] = 70, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Nimitz"), ["distance"] = 1000, ["theta"] = 18, ["rho"] = 70, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 2000, ["theta"] = 20, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 2000, ["theta"] = 20, ["rho"] = 90, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaIntroMovieEnd, true)
	
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(false, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Hakuryu"))
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.CapitalShips)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.CapitalShips), "Sink the enemy capital ships!")
	
	luaObj_Add("primary", 5, Mission.JapCapitalShips)
	
	luaObj_Add("secondary", 1, Mission.Izumo)
	
	luaAddCargoListener()
end


-- Phase 2 --

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	
	Mission.SelUnit = GetSelectedUnit()
	
	--luaDelay(luaPlanesDia, 2)--
	
	luaSpawnNextAttackWave()
	
	luaStartDialog("BTD")
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = Mission.BTD[1], ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.BTD[1], ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 3},
	  
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips)))
		
	end
	
	luaAddSecObjs()
	
end

function luaSpawnNextAttackWave()

	if Mission.AttackWaves < 3 then 

		for idx4,unit in pairs(Mission.Wave) do
			local plane = GenerateObject(unit)
			SetSkillLevel(plane, Mission.SkillLevel)
			table.insert(Mission.BTD, plane)
			if luaObj_IsActive("primary", 3) then
			luaObj_AddUnit("primary",3,plane)
			end
		end
	Mission.AttackWaves = Mission.AttackWaves + 1
	luaDelay(luaSpawnNextAttackWave, 200)
	end
end

function luaAddSecObjs()

	luaObj_Add("primary", 3, Mission.BTD)
	
end

-- Phase 3 --

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.USPatrolB = {}
		table.insert(Mission.USPatrolB, GenerateObject("Essex"))
		table.insert(Mission.USPatrolB, GenerateObject("Intrepid"))
		table.insert(Mission.USPatrolB, GenerateObject("Lexington"))
		table.insert(Mission.USPatrolB, GenerateObject("Boston"))
		table.insert(Mission.USPatrolB, GenerateObject("Canberra"))
		table.insert(Mission.USPatrolB, GenerateObject("Somers-class09"))
		table.insert(Mission.USPatrolB, GenerateObject("Somers-class10"))
	
	Mission.CVs = {}
	
	
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
		
		if unit.Class.Type == "MotherShip" then
			
			if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 3)
				
			end
			
			SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
			
			--table.insert(Mission.USRein, unit)
			table.insert(Mission.USNCV, unit)
			
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
	
	NavigatorMoveOnPath(Mission.USPatrolB[1], FindEntity("CVPath2"), PATH_FM_CIRCLE, pathDir)
	

	
	
	Mission.SelUnit = GetSelectedUnit()
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.USPatrolB[1]
	
	--luaStartDialog("CV")
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = Mission.USPatrolB[1], ["distance"] = 400, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.USPatrolB[1], ["distance"] = 400, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 5},
	  
	}, luaPh3MovieEnd, true)
	
end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(FindEntity("Hakuryu"))
	
	end
	
	luaDelay(luaAddThirdObjs, 3)
	
end

function luaAddThirdObjs()

	luaObj_Add("primary", 4, Mission.USNCV)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.USNCV), "Sink the enemy carriers!")
	
end
---- LISTENERS ----

function luaAddCargoListener()

	AddListener("recon", "CargoListener", {
		["callback"] = "luaCargoSighted",
		["entity"] = Mission.Cargo,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaCargoSighted()

	RemoveListener("recon", "CargoListener")
	
	luaObj_Add("secondary", 2, Mission.Cargo)
	luaObj_Add("hidden", 1, Mission.Hidden)
	--luaStartDialog("RANGE")
	
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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Completed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(nil, "The American carrier fleet is no more - Mission Complete")
	
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
function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.IJNShips
		
	elseif Mission.Difficulty == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
		
			trgs = Mission.JapCapitalShips
		
		else
		
			trgs = Mission.IJNShips
		
		end
		
	end
	
	return trgs
	
end

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