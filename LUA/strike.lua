-- Scripted & Assembled by: Team Wolfpack

----  (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(26)     -- F6F
	PrepareClass(331)     -- BTD
    PrepareClass(38)     -- SB2C
	
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
	
	--LoadMessageMap("ijndlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/strike.lua"

	this.Name = "IJN25"
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
				["Text"] = "Destroy the enemy convoy and it's escorts!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Eliminate all enemy battleships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "CV",
				["Text"] = "Destroy the enemy carriers!",
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
		table.insert(Mission.JapFleetA, FindEntity("Akatora"))
		table.insert(Mission.JapFleetA, FindEntity("Jinho"))
		table.insert(Mission.JapFleetA, FindEntity("Satsuma"))
		table.insert(Mission.JapFleetA, FindEntity("Yakushi"))
		table.insert(Mission.JapFleetA, FindEntity("Taiga"))
		table.insert(Mission.JapFleetA, FindEntity("Hamasaki"))
		table.insert(Mission.JapFleetA, FindEntity("Nagame"))
		table.insert(Mission.JapFleetA, FindEntity("Keitaro"))
		table.insert(Mission.JapFleetA, FindEntity("Yukimura"))
		table.insert(Mission.JapFleetA, FindEntity("Akiba"))
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
		table.insert(Mission.JapFleetB, FindEntity("Seiryu"))
		table.insert(Mission.JapFleetB, FindEntity("Mikawa"))
		table.insert(Mission.JapFleetB, FindEntity("Tsukuba"))
		table.insert(Mission.JapFleetB, FindEntity("Tone2"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate7"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate8"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate9"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate10"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate11"))
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
	
	Mission.Akatora = {}
		table.insert(Mission.Akatora, FindEntity("Akatora"))
	
	---- USN ----
	Mission.ConvoyA = {}
		table.insert(Mission.ConvoyA, FindEntity("Cargo01"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo02"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo03"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo04"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo05"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo06"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo07"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo08"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo09"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo10"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo11"))
		table.insert(Mission.ConvoyA, FindEntity("Cargo12"))
		table.insert(Mission.ConvoyA, FindEntity("NewYork1"))
		table.insert(Mission.ConvoyA, FindEntity("NewYork2"))
		table.insert(Mission.ConvoyA, FindEntity("NewYork3"))
		table.insert(Mission.ConvoyA, FindEntity("Allen1"))
		table.insert(Mission.ConvoyA, FindEntity("Allen2"))
		table.insert(Mission.ConvoyA, FindEntity("Allen3"))
		table.insert(Mission.ConvoyA, FindEntity("Allen4"))
		table.insert(Mission.ConvoyA, FindEntity("Independence"))
	for idx,unit in pairs(Mission.ConvoyA) do

        JoinFormation(unit, Mission.ConvoyA[1])
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
	
	NavigatorMoveToRange(Mission.ConvoyA[1], FindEntity("ConvoyNav"))
	
	if Mission.Difficulty == 0 then

            SetAirBaseSlotCount(unit, 1)

        elseif Mission.Difficulty == 1 then

            SetAirBaseSlotCount(FindEntity("Independence"), 4)

        elseif Mission.Difficulty == 2 then

            SetAirBaseSlotCount(FindEntity("Independence"), 4)

    end
	
	Mission.Ind = {}
		table.insert(Mission.Ind, FindEntity("Independence"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
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
	
	MissionNarrative("Somewhere in the central pacific...")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	SetSimplifiedReconMultiplier(10.0)
	
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
	
		luaIntroMovie()
		
		Mission.Started = true
		
		else
		
		if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	--luaCheckObjectives()

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
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Ind)) > 0 then

                for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Ind)) do

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

                if table.getn(luaRemoveDeadsFromTable(Mission.ConvoyA)) == 0 then

                    HideUnitHP()

                    luaObj_Completed("primary", 1, true)

                    luaPh1FadeOut()

                end

            end

		elseif Mission.MissionPhase == 2 then

			if luaObj_IsActive("primary", 2) then

                if table.getn(luaRemoveDeadsFromTable(Mission.USBB)) == 0 then

                    HideUnitHP()

                    luaObj_Completed("primary", 2, true)

                    luaPh2FadeOut()

                end

            end
		
		elseif Mission.MissionPhase == 3 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.Carria)) > 0 then

                for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Carria)) do

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
		
			if luaObj_IsActive("primary", 3) then

                if table.getn(luaRemoveDeadsFromTable(Mission.Carria)) == 0 then

                    HideUnitHP()

                    luaObj_Completed("primary", 3, true)

                    luaMissionComplete()

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
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Cargo01"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Cargo01"), ["distance"] = 400, ["theta"] = 10, ["rho"] = 105, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Akatora"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 55, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Akatora"), ["distance"] = 300, ["theta"] = 15, ["rho"] = 55, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
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
	
	SetSelectedUnit(FindEntity("Akatora"))
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.ConvoyA)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.ConvoyA), "Destroy the convoy!")

end

---- PHASE 2 ----

function luaPh2FadeOut()

Blackout(true, "luaMoveToPh3", 1)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	luaSpawnBB()
	
	luaIngameMovie(
    {

      {["postype"] = "cameraandtarget", ["target"] = FindEntity("Lexington1"), ["distance"] = 200, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
      {["postype"] = "cameraandtarget", ["target"] = FindEntity("Lexington1"), ["distance"] = 300, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 4},

    }, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

    SetSelectedUnit(FindEntity("Akatora"))

    luaAddSecObjs()

end

function luaAddSecObjs()

    luaObj_Add("primary", 2, Mission.USBB)

end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaSpawnCV()

	luaIngameMovie(
    {

      {["postype"] = "cameraandtarget", ["target"] = FindEntity("Midway1"), ["distance"] = 300, ["theta"] = 6, ["rho"] = 45, ["moveTime"] = 0},
      {["postype"] = "cameraandtarget", ["target"] = FindEntity("Midway1"), ["distance"] = 200, ["theta"] = 6, ["rho"] = 90, ["moveTime"] = 6},

    }, luaPh3MovieEnd, true)

end

function luaPh3MovieEnd()

    SetSelectedUnit(FindEntity("Akatora"))

    luaAddThrObjs()

end

function luaAddThrObjs()

    luaObj_Add("primary", 3, Mission.Carria)

end

---- LISTENERS ----



---- LISTENER CALLBACKS ----



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

function luaSpawnCV()

	Mission.USCV = {}
		table.insert(Mission.USCV, GenerateObject("Midway1"))
		table.insert(Mission.USCV, GenerateObject("Midway2"))
		table.insert(Mission.USCV, GenerateObject("Alaska3"))
		table.insert(Mission.USCV, GenerateObject("Alaska4"))
		table.insert(Mission.USCV, GenerateObject("Allen11"))
		table.insert(Mission.USCV, GenerateObject("Allen12"))
		table.insert(Mission.USCV, GenerateObject("Allen13"))
		table.insert(Mission.USCV, GenerateObject("Allen14"))
		table.insert(Mission.USCV, GenerateObject("Allen15"))
		table.insert(Mission.USCV, GenerateObject("Allen16"))
	for idx,unit in pairs(Mission.USCV) do
	
		JoinFormation(unit, Mission.USCV[1])
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

            SetAirBaseSlotCount(unit, 1)

        elseif Mission.Difficulty == 1 then

            SetAirBaseSlotCount(FindEntity("Midway1"), 3)

        elseif Mission.Difficulty == 2 then

            SetAirBaseSlotCount(FindEntity("Midway1"), 3)

    end
	
	if Mission.Difficulty == 0 then

            SetAirBaseSlotCount(unit, 1)

        elseif Mission.Difficulty == 1 then

            SetAirBaseSlotCount(FindEntity("Midway2"), 3)

        elseif Mission.Difficulty == 2 then

            SetAirBaseSlotCount(FindEntity("Midway2"), 3)

    end

	Mission.Carria = {}
		table.insert(Mission.Carria, FindEntity("Midway1"))
		table.insert(Mission.Carria, FindEntity("Midway2"))

end

function luaSpawnBB()
	
	Mission.USBB = {}
		table.insert(Mission.USBB, GenerateObject("Lexington1"))
		table.insert(Mission.USBB, GenerateObject("Lexington2"))
		table.insert(Mission.USBB, GenerateObject("Lexington3"))
		table.insert(Mission.USBB, GenerateObject("Alaska1"))
		table.insert(Mission.USBB, GenerateObject("Alaska2"))
		table.insert(Mission.USBB, GenerateObject("Allen5"))
		table.insert(Mission.USBB, GenerateObject("Allen6"))
		table.insert(Mission.USBB, GenerateObject("Allen7"))
		table.insert(Mission.USBB, GenerateObject("Allen8"))
		table.insert(Mission.USBB, GenerateObject("Allen9"))
		table.insert(Mission.USBB, GenerateObject("Allen10"))
	for idx,unit in pairs(Mission.USBB) do
	
		JoinFormation(unit, Mission.USBB[1])
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

	NavigatorAttackMove(Mission.USBB[1], Mission.JapFleetA[1])

end

function luaGetUSPlaneTrg()

    local trgs

    if Mission.Difficulty == 0 or Mission.Difficulty == 1 then

        trgs = Mission.IJNShips

    elseif Mission.Difficulty == 2 then

        if table.getn(luaRemoveDeadsFromTable(Mission.Akatora)) > 0 then

            trgs = Mission.Akatora

        else

            trgs = MissionIJNShips

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