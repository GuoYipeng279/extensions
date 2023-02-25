---- San Francisco Dash (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- San Francisco (IJN) ----

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
	Mission.ScriptFile = "Scripts/missions/IJN/sf_dash.lua"

	this.Name = "IJN26"
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
				["Text"] = "Sink all enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Don't loose a single transport!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Dont loose a single capital ship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Destroy",
				["Text"] = "Destroy the American Surface Fleet!",
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
		table.insert(Mission.JapFleetA, FindEntity("Hakuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Oryu"))
		table.insert(Mission.JapFleetA, FindEntity("Kokuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Zuiryu"))
		table.insert(Mission.JapFleetA, FindEntity("Yashima"))
		table.insert(Mission.JapFleetA, FindEntity("Yamato"))
		table.insert(Mission.JapFleetA, FindEntity("Izumo"))
		table.insert(Mission.JapFleetA, FindEntity("Hizen"))
		table.insert(Mission.JapFleetA, FindEntity("Azumaya"))
		table.insert(Mission.JapFleetA, FindEntity("Mitsumine"))
		table.insert(Mission.JapFleetA, FindEntity("Haru"))
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
		
	Mission.JapFleetB = {}
		table.insert(Mission.JapFleetB, FindEntity("Azuma"))
		table.insert(Mission.JapFleetB, FindEntity("Zao"))
		table.insert(Mission.JapFleetB, FindEntity("Senjo"))
		table.insert(Mission.JapFleetB, FindEntity("Okinawa Maru"))
		table.insert(Mission.JapFleetB, FindEntity("Nojima Maru"))
		table.insert(Mission.JapFleetB, FindEntity("Brazil Maru"))
		table.insert(Mission.JapFleetB, FindEntity("Kimikawa Maru"))
		table.insert(Mission.JapFleetB, FindEntity("SB01"))
		table.insert(Mission.JapFleetB, FindEntity("SB02"))
		table.insert(Mission.JapFleetB, FindEntity("SB03"))
		table.insert(Mission.JapFleetB, FindEntity("SB04"))
		table.insert(Mission.JapFleetB, FindEntity("Haru9"))
		table.insert(Mission.JapFleetB, FindEntity("Haru10"))
		table.insert(Mission.JapFleetB, FindEntity("Haru11"))
		table.insert(Mission.JapFleetB, FindEntity("Haru12"))
		table.insert(Mission.JapFleetB, FindEntity("Haru13"))
		table.insert(Mission.JapFleetB, FindEntity("Haru14"))
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
		table.insert(Mission.JapCapitalShips, FindEntity("Hakuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Kokuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Oryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Zuiryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Yamato"))
		table.insert(Mission.JapCapitalShips, FindEntity("Yashima"))
	
	Mission.JapTrans = {}
		table.insert(Mission.JapTrans, FindEntity("Okinawa Maru"))
		table.insert(Mission.JapTrans, FindEntity("Nojima Maru"))
		table.insert(Mission.JapTrans, FindEntity("Brazil Maru"))
		table.insert(Mission.JapTrans, FindEntity("Kimikawa Maru"))
		table.insert(Mission.JapTrans, FindEntity("SB01"))
		table.insert(Mission.JapTrans, FindEntity("SB02"))
		table.insert(Mission.JapTrans, FindEntity("SB03"))
		table.insert(Mission.JapTrans, FindEntity("SB04"))
	
	---- USN ----
	
	Mission.USCVA = {}
		table.insert(Mission.USCVA, FindEntity("Coral Sea"))
		table.insert(Mission.USCVA, FindEntity("Champion Hill"))
		table.insert(Mission.USCVA, FindEntity("Midway"))
		table.insert(Mission.USCVA, FindEntity("Somersclass01"))
		table.insert(Mission.USCVA, FindEntity("Somersclass02"))
		table.insert(Mission.USCVA, FindEntity("Somersclass03"))
		table.insert(Mission.USCVA, FindEntity("Somersclass04"))
		table.insert(Mission.USCVA, FindEntity("Somersclass05"))
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
		table.insert(Mission.USCVB, FindEntity("Essex"))
		table.insert(Mission.USCVB, FindEntity("Intrepid"))
		table.insert(Mission.USCVB, FindEntity("Lexington"))
		table.insert(Mission.USCVB, FindEntity("Somersclass06"))
		table.insert(Mission.USCVB, FindEntity("Somersclass07"))
		table.insert(Mission.USCVB, FindEntity("Somersclass08"))
		table.insert(Mission.USCVB, FindEntity("Somersclass09"))
		table.insert(Mission.USCVB, FindEntity("Somersclass10"))
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
	
	Mission.USCAR = {}
		table.insert(Mission.USCAR, FindEntity("Essex"))
		table.insert(Mission.USCAR, FindEntity("Intrepid"))
		table.insert(Mission.USCAR, FindEntity("Lexington"))
		table.insert(Mission.USCAR, FindEntity("Coral Sea"))
		table.insert(Mission.USCAR, FindEntity("Champion Hill"))
		table.insert(Mission.USCAR, FindEntity("Midway"))
	
	if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 1)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(FindEntity("Essex"), 2)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(FindEntity("Essex"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Intrepid"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Intrepid"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Lexington"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Lexington"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Coral Sea"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Coral Sea"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Champion Hill"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Champion Hill"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway"), 2)
				
	end
	
	local pathIdx = luaRnd(1,2)
    local pathDir

    if pathIdx == 1 then

        pathDir = PATH_SM_JOIN

    elseif pathIdx == 2 then

        pathDir = PATH_SM_JOIN_BACKWARDS

    end

    NavigatorMoveOnPath(Mission.USCVA[1], FindEntity("CVPath1"), PATH_FM_CIRCLE, pathDir)
	
	NavigatorMoveOnPath(Mission.USCVB[1], FindEntity("CVPath2"), PATH_FM_CIRCLE, pathDir)
	
	
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
	
	MissionNarrative("January 14, 1944 - Approaching San Francisco")
	
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
	
	--luaShowPath(FindEntity("CVPath2"))
	
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
			
			if table.getn(luaRemoveDeadsFromTable(Mission.USCAR)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USCAR)) do
					
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
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USCAR)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 1, true)
				
					luaPh1FadeOut()				
				
				end
			
			end	
		
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary", 4) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USFleet)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 4, true)
				
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
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 1000, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 1000, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Azuma"), ["distance"] = 2500, ["theta"] = 10, ["rho"] = 90, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Azuma"), ["distance"] = 2500, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 400, ["theta"] = 15, ["rho"] = 45, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
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
	
	SetSelectedUnit(FindEntity("Hakuryu"))
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.USCAR)	
	
end

-- Phase 2

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	luaSpawnUSBB()

	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 35, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 4},
	  
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	SetSelectedUnit(FindEntity("Hakuryu"))
	
	luaAddSecObjs()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 4, Mission.USFleet)
	
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

function luaSpawnUSBB()

	Mission.ForceA = {}
		table.insert(Mission.ForceA, GenerateObject("Missouri"))
		table.insert(Mission.ForceA, GenerateObject("Iowa"))
		table.insert(Mission.ForceA, GenerateObject("Hawaii"))
	for idx,unit in pairs(Mission.ForceA) do
		
		JoinFormation(unit, Mission.ForceA[1])
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
	
	NavigatorAttackMove(Mission.ForceA[1], Mission.JapFleetA[1])
	
	Mission.ForceB = {}
		table.insert(Mission.ForceB, GenerateObject("Montana"))
		table.insert(Mission.ForceB, GenerateObject("Ohio"))
		table.insert(Mission.ForceB, GenerateObject("Puerto Rico"))
	for idx,unit in pairs(Mission.ForceB) do
		
		JoinFormation(unit, Mission.ForceB[1])
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
	
	NavigatorAttackMove(Mission.ForceB[1], Mission.JapFleetA[1])
	
	Mission.ForceC = {}
		table.insert(Mission.ForceC, GenerateObject("Saratoga"))
		table.insert(Mission.ForceC, GenerateObject("Guam"))
		table.insert(Mission.ForceC, GenerateObject("Alaska"))
		table.insert(Mission.ForceC, GenerateObject("Alabama"))
		table.insert(Mission.ForceC, GenerateObject("South Dakota"))
	for idx,unit in pairs(Mission.ForceC) do
		
		JoinFormation(unit, Mission.ForceC[1])
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

	NavigatorAttackMove(Mission.ForceC[1], Mission.JapFleetA[1])

	Mission.USFleet = luaSumTablesIndex(Mission.ForceA, Mission.ForceB, Mission.ForceC)

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.JapCapitalShips
		
	elseif Mission.Difficulty == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapTrans)) > 0 then
		
			trgs = Mission.JapTrans
		
		else
		
			trgs = Mission.JapCapitalShips
		
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