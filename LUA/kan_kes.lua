-- Scripted & Assembled by: Team Wolfpack

---- Kantai Kessen (IJN) ----

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
	
	--LoadMessageMap("ijndlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/kan_kes.lua"

	this.Name = "IJN35"
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
				["Text"] = "Find and sink the USS Enterprise and it's escorting carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Cap",
				["Text"] = "Find and sink the rest of the American capitals ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Do not loose any carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "CV",
				["Text"] = "Keep all carriers alive!",
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
				["Text"] = "Admiral Ozawa's flagship Yamato must survive!",
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
				["Text"] = "Do not loose a single battleship!",
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
		table.insert(Mission.JapFleetA, FindEntity("Hakuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Kokuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Zuiryu"))
		table.insert(Mission.JapFleetA, FindEntity("Oryu"))
		table.insert(Mission.JapFleetA, FindEntity("Yamato"))
		table.insert(Mission.JapFleetA, FindEntity("Azuma"))
		table.insert(Mission.JapFleetA, FindEntity("Yoshino"))
		table.insert(Mission.JapFleetA, FindEntity("Zao"))
		table.insert(Mission.JapFleetA, FindEntity("Senjo"))
		table.insert(Mission.JapFleetA, FindEntity("Adatara"))
		table.insert(Mission.JapFleetA, FindEntity("Haru1"))
		table.insert(Mission.JapFleetA, FindEntity("Haru2"))
		table.insert(Mission.JapFleetA, FindEntity("Haru3"))
		table.insert(Mission.JapFleetA, FindEntity("Haru4"))
		table.insert(Mission.JapFleetA, FindEntity("Haru5"))
		table.insert(Mission.JapFleetA, FindEntity("Haru6"))
		table.insert(Mission.JapFleetA, FindEntity("Haru7"))
		table.insert(Mission.JapFleetA, FindEntity("Haru8"))
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
	
	Mission.JapCapital = {}
		table.insert(Mission.JapCapital, FindEntity("Hakuryu"))
		table.insert(Mission.JapCapital, FindEntity("Kokuryu"))
		table.insert(Mission.JapCapital, FindEntity("Zuiryu"))
		table.insert(Mission.JapCapital, FindEntity("Oryu"))
		table.insert(Mission.JapCapital, FindEntity("Yamato"))
	
	Mission.JapCV = {}
		table.insert(Mission.JapCV, FindEntity("Hakuryu"))
		table.insert(Mission.JapCV, FindEntity("Kokuryu"))
		table.insert(Mission.JapCV, FindEntity("Zuiryu"))
		table.insert(Mission.JapCV, FindEntity("Oryu"))
	
	Mission.Ozawa = {}
		table.insert(Mission.Ozawa, FindEntity("Yamato"))
	
	---- USN ----
	
	-- fleets
	
	Mission.BigE = {}
		table.insert(Mission.BigE, FindEntity("Enterprise"))
		table.insert(Mission.BigE, FindEntity("Bunker Hill"))
		table.insert(Mission.BigE, FindEntity("Bonne Homme Richard"))
		table.insert(Mission.BigE, FindEntity("Boston1"))
		table.insert(Mission.BigE, FindEntity("Boston2"))
		table.insert(Mission.BigE, FindEntity("Allen1"))
		table.insert(Mission.BigE, FindEntity("Allen2"))
		table.insert(Mission.BigE, FindEntity("Allen3"))
	for idx,unit in pairs(Mission.BigE) do
		
		JoinFormation(unit, Mission.BigE[1])
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
	
	Mission.Enterprise = {}
		table.insert(Mission.Enterprise, FindEntity("Enterprise"))
		table.insert(Mission.Enterprise, FindEntity("Bunker Hill"))
		table.insert(Mission.Enterprise, FindEntity("Bonne Homme Richard"))
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Enterprise"), 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Enterprise"), 3)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Bunker Hill"), 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Bunker Hill"), 3)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Bonne Homme Richard"), 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Bonne Homme Richard"), 3)
				
	end
	
	-- path
	
    if pathIdx == 1 then

        pathDir = PATH_SM_JOIN

    elseif pathIdx == 2 then

        pathDir = PATH_SM_JOIN_BACKWARDS

    end

    NavigatorMoveOnPath(Mission.BigE[1], FindEntity("CVPath1"), PATH_FM_CIRCLE, pathDir)
	
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
	
	MissionNarrative("Somewhere in the South Pacifc....")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(15.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("CVPath1"))
	
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
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Enterprise)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Enterprise)) do
					
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 26,
						
						}
						local bombers = {
							[1] = 38,
							[2] = 331,
						}
						
						
						local trgs = luaGetUSPlaneOneTrg()
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Enterprise)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 1, true)
				
					luaPh1FadeOut()			
				
				end
			
			end	
		
		elseif Mission.MissionPhase == 2 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.Essex)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Essex)) do
					
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 26,
						
						}
						local bombers = {
							[1] = 38,
							[2] = 331,
						}
						
						
						local trgs = luaGetUSPlaneTwoTrg()
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
		
			if luaObj_IsActive("primary", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 2, true)
				
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
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Enterprise"), ["distance"] = 400, ["theta"] = 10, ["rho"] = 72, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Enterprise"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 72, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 35, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 300, ["theta"] = 15, ["rho"] = 35, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.JapFleetA[1])
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Enterprise)

end

-- Phase 2

function luaMoveToPh2()

	Mission.MissionPhase = 2

	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)

	luaSpawnIJN()
	
	luaSpawnUSN()

	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 500, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Kansas"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Kansas"), ["distance"] = 300, ["theta"] = 15, ["rho"] = 45, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Essex1"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Essex1"), ["distance"] = 400, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	SetSelectedUnit(FindEntity("Hakuryu"))
	
	luaAddSecObjs()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.CapitalShips)
	
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
function luaGetUSPlaneOneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.JapFleetA
		
	elseif Mission.Difficulty == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCapital)) > 0 then
		
			trgs = Mission.JapCapital
		
		else
		
			trgs = Mission.JapFleetA
		
		end
		
	end
	
	return trgs
	
end

function luaGetUSPlaneTwoTrg()
	
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

function luaSpawnUSN()

	Mission.USCVA = {}
		table.insert(Mission.USCVA, GenerateObject("Essex1"))
		table.insert(Mission.USCVA, GenerateObject("Essex2"))
		table.insert(Mission.USCVA, GenerateObject("Essex3"))
		table.insert(Mission.USCVA, GenerateObject("Boston3"))
		table.insert(Mission.USCVA, GenerateObject("Allen4"))
		table.insert(Mission.USCVA, GenerateObject("Allen5"))
		table.insert(Mission.USCVA, GenerateObject("Allen6"))
		table.insert(Mission.USCVA, GenerateObject("Allen7"))
	for idx,unit in pairs(Mission.USCVA) do
		
		JoinFormation(unit, Mission.USCVA[1])
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
	
	Mission.USCVB = {}
		table.insert(Mission.USCVB, GenerateObject("Essex5"))
		table.insert(Mission.USCVB, GenerateObject("Essex6"))
		table.insert(Mission.USCVB, GenerateObject("Essex7"))
		table.insert(Mission.USCVB, GenerateObject("Boston4"))
		table.insert(Mission.USCVB, GenerateObject("Allen11"))
		table.insert(Mission.USCVB, GenerateObject("Allen12"))
		table.insert(Mission.USCVB, GenerateObject("Allen13"))
		table.insert(Mission.USCVB, GenerateObject("Allen14"))
	for idx,unit in pairs(Mission.USCVB) do
		
		JoinFormation(unit, Mission.USCVB[1])
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
	
	Mission.USBB = {}
		table.insert(Mission.USBB, GenerateObject("Kansas"))
		table.insert(Mission.USBB, GenerateObject("Nebraska"))
		table.insert(Mission.USBB, GenerateObject("Vermont"))
		table.insert(Mission.USBB, GenerateObject("Boston5"))
		table.insert(Mission.USBB, GenerateObject("Boston6"))
		table.insert(Mission.USBB, GenerateObject("Allen18"))
		table.insert(Mission.USBB, GenerateObject("Allen19"))
		table.insert(Mission.USBB, GenerateObject("Allen20"))
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end

	NavigatorAttackMove(Mission.USBB[1], Mission.JapFleetA[1])
	
	Mission.CapitalShips = {}
		table.insert(Mission.CapitalShips, FindEntity("Essex1"))
		table.insert(Mission.CapitalShips, FindEntity("Essex2"))
		table.insert(Mission.CapitalShips, FindEntity("Essex3"))
		table.insert(Mission.CapitalShips, FindEntity("Essex5"))
		table.insert(Mission.CapitalShips, FindEntity("Essex6"))
		table.insert(Mission.CapitalShips, FindEntity("Essex7"))
		table.insert(Mission.CapitalShips, FindEntity("Kansas"))
		table.insert(Mission.CapitalShips, FindEntity("Nebraska"))
		table.insert(Mission.CapitalShips, FindEntity("Vermont"))
		table.insert(Mission.CapitalShips, FindEntity("Rhode Island"))

	Mission.Essex = {}
		table.insert(Mission.Essex, FindEntity("Essex1"))
		table.insert(Mission.Essex, FindEntity("Essex2"))
		table.insert(Mission.Essex, FindEntity("Essex3"))
		table.insert(Mission.Essex, FindEntity("Essex5"))
		table.insert(Mission.Essex, FindEntity("Essex6"))
		table.insert(Mission.Essex, FindEntity("Essex7"))


	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex1"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex1"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex2"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex2"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex3"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex3"), 2)
				
	end
	

	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex5"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex5"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex6"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex6"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Essex7"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Essex7"), 2)
				
	end
	


end

function luaSpawnIJN()

	Mission.JapFleetB = {}
		table.insert(Mission.JapFleetB, GenerateObject("Taiho"))
		table.insert(Mission.JapFleetB, GenerateObject("Shinho"))
		table.insert(Mission.JapFleetB, GenerateObject("Unho"))
		table.insert(Mission.JapFleetB, GenerateObject("Zuikaku"))
		table.insert(Mission.JapFleetB, GenerateObject("Shokaku"))
		table.insert(Mission.JapFleetB, GenerateObject("Zuiho"))
		table.insert(Mission.JapFleetB, GenerateObject("Yashima"))
		table.insert(Mission.JapFleetB, GenerateObject("Akagi"))
		table.insert(Mission.JapFleetB, GenerateObject("Kaga"))
		table.insert(Mission.JapFleetB, GenerateObject("Mitsumine"))
		table.insert(Mission.JapFleetB, GenerateObject("Mitsune"))
		table.insert(Mission.JapFleetB, GenerateObject("Musume"))
		table.insert(Mission.JapFleetB, GenerateObject("Michi"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru9"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru10"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru11"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru12"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru13"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru14"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru15"))
		table.insert(Mission.JapFleetB, GenerateObject("Haru16"))
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

	Mission.Ships = {}
		table.insert(Mission.Ships, FindEntity("Taiho"))
		table.insert(Mission.Ships, FindEntity("Shinho"))
		table.insert(Mission.Ships, FindEntity("Unho"))
		table.insert(Mission.Ships, FindEntity("Zuikaku"))
		table.insert(Mission.Ships, FindEntity("Shokaku"))
		table.insert(Mission.Ships, FindEntity("Zuiho"))

	Mission.JapCapitalShips = luaSumTablesIndex(Mission.JapCapital, Mission.Ships)

	Mission.IJNShips = luaSumTablesIndex(Mission.JapFleetA, Mission.JapFleetB)

	Mission.IJNBB = {}
		table.insert(Mission.IJNBB, FindEntity("Yashima"))
		table.insert(Mission.IJNBB, FindEntity("Akagi"))
		table.insert(Mission.IJNBB, FindEntity("Kaga"))

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