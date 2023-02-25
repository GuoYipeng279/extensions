-- Scripted & Assembled by: Team Wolfpack

----  (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(26) 	-- F6F
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
	Mission.ScriptFile = "Scripts/missions/IJN/mt_rng.lua"

	this.Name = "IJN30"
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
				["Text"] = "Sink the enemy blockade!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "CV",
				["Text"] = "Sink all enemy carriers!",
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
		table.insert(Mission.JapFleetA, FindEntity("Azuma"))
		table.insert(Mission.JapFleetA, FindEntity("Yoshino"))
		table.insert(Mission.JapFleetA, FindEntity("Zao"))
		table.insert(Mission.JapFleetA, FindEntity("Senjo"))
		table.insert(Mission.JapFleetA, FindEntity("Gassan"))
		table.insert(Mission.JapFleetA, FindEntity("Adatara"))
		table.insert(Mission.JapFleetA, FindEntity("Haru"))
		table.insert(Mission.JapFleetA, FindEntity("Haru1"))
		table.insert(Mission.JapFleetA, FindEntity("Haru2"))
		table.insert(Mission.JapFleetA, FindEntity("Haru3"))
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
		table.insert(Mission.JapFleetB, FindEntity("Unho"))
		table.insert(Mission.JapFleetB, FindEntity("Shinho"))
		table.insert(Mission.JapFleetB, FindEntity("Azumaya"))
		table.insert(Mission.JapFleetB, FindEntity("Haru4"))
		table.insert(Mission.JapFleetB, FindEntity("Haru5"))
		table.insert(Mission.JapFleetB, FindEntity("Haru6"))
		table.insert(Mission.JapFleetB, FindEntity("Haru7"))
		table.insert(Mission.JapFleetB, FindEntity("Haru8"))
		table.insert(Mission.JapFleetB, FindEntity("Haru9"))
		table.insert(Mission.JapFleetB, FindEntity("Haru10"))
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
	
	Mission.JapFleetC = {}
		table.insert(Mission.JapFleetC, FindEntity("Zuiho"))
		table.insert(Mission.JapFleetC, FindEntity("Zuikaku"))
		table.insert(Mission.JapFleetC, FindEntity("Shokaku"))
		table.insert(Mission.JapFleetC, FindEntity("Mitsune"))
		table.insert(Mission.JapFleetC, FindEntity("Mitsumine"))
		table.insert(Mission.JapFleetC, FindEntity("Musume"))
		table.insert(Mission.JapFleetC, FindEntity("Michi"))
		table.insert(Mission.JapFleetC, FindEntity("Haru11"))
		table.insert(Mission.JapFleetC, FindEntity("Haru12"))
		table.insert(Mission.JapFleetC, FindEntity("Haru13"))
		table.insert(Mission.JapFleetC, FindEntity("Haru14"))
	for idx,unit in pairs(Mission.JapFleetC) do
		
		JoinFormation(unit, Mission.JapFleetC[1])
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
	
	Mission.JapFleetD = {}
		table.insert(Mission.JapFleetD, FindEntity("Yamato"))
		table.insert(Mission.JapFleetD, FindEntity("Musashi"))
		table.insert(Mission.JapFleetD, FindEntity("Shinano"))
		table.insert(Mission.JapFleetD, FindEntity("Hotaka"))
		table.insert(Mission.JapFleetD, FindEntity("Daisen"))
		table.insert(Mission.JapFleetD, FindEntity("Yari"))
		table.insert(Mission.JapFleetD, FindEntity("Yotei"))
		table.insert(Mission.JapFleetD, FindEntity("Haru15"))
		table.insert(Mission.JapFleetD, FindEntity("Haru16"))
		table.insert(Mission.JapFleetD, FindEntity("Haru17"))
		table.insert(Mission.JapFleetD, FindEntity("Haru18"))
		table.insert(Mission.JapFleetD, FindEntity("Haru19"))
		table.insert(Mission.JapFleetD, FindEntity("Haru24"))
		table.insert(Mission.JapFleetD, FindEntity("Haru25"))
	for idx,unit in pairs(Mission.JapFleetD) do
		
		JoinFormation(unit, Mission.JapFleetD[1])
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
	
	Mission.JapFleetE = {}
		table.insert(Mission.JapFleetE, FindEntity("Yashima"))
		table.insert(Mission.JapFleetE, FindEntity("Asahi"))
		table.insert(Mission.JapFleetE, FindEntity("Utsugi"))
		table.insert(Mission.JapFleetE, FindEntity("Asama"))
		table.insert(Mission.JapFleetE, FindEntity("Washiba"))
		table.insert(Mission.JapFleetE, FindEntity("Tsurugi"))
		table.insert(Mission.JapFleetE, FindEntity("Haru20"))
		table.insert(Mission.JapFleetE, FindEntity("Haru21"))
		table.insert(Mission.JapFleetE, FindEntity("Haru22"))
		table.insert(Mission.JapFleetE, FindEntity("Haru23"))
	for idx,unit in pairs(Mission.JapFleetE) do
		
		JoinFormation(unit, Mission.JapFleetE[1])
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
	
	Mission.JapCapitalShips = {}
		table.insert(Mission.JapCapitalShips, FindEntity("Hakuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Kokuryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Oryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Zuiryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Taiho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Shinho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Unho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Zuiho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Shokaku"))
		table.insert(Mission.JapCapitalShips, FindEntity("Zuikaku"))
	
	Mission.IJNShips = luaSumTablesIndex(JapFleetA, JapFleetB, JapFleetC, JapFleetD, JapFleetE)
	
	---- USN ----
	
	Mission.USA = {}
		table.insert(Mission.USA, FindEntity("Alaska7"))
		table.insert(Mission.USA, FindEntity("Alaska8"))
		table.insert(Mission.USA, FindEntity("Alaska9"))
		table.insert(Mission.USA, FindEntity("Somers10"))
		table.insert(Mission.USA, FindEntity("Somers11"))
		table.insert(Mission.USA, FindEntity("Somers12"))
	for idx,unit in pairs(Mission.USA) do

		JoinFormation(unit, Mission.USA[1])
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
	
	NavigatorAttackMove(Mission.USA[1], Mission.JapFleetA[1])
	
	Mission.USB = {}
		table.insert(Mission.USB, FindEntity("Alaska10"))
		table.insert(Mission.USB, FindEntity("Alaska11"))
		table.insert(Mission.USB, FindEntity("Alaska12"))
		table.insert(Mission.USB, FindEntity("Somers13"))
		table.insert(Mission.USB, FindEntity("Somers14"))
		table.insert(Mission.USB, FindEntity("Somers15"))
	for idx,unit in pairs(Mission.USB) do

		JoinFormation(unit, Mission.USB[1])
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
	
	NavigatorAttackMove(Mission.USB[1], Mission.JapFleetC[1])
	
	Mission.USD = {}
		table.insert(Mission.USD, FindEntity("Montana1"))
		table.insert(Mission.USD, FindEntity("Alaska16"))
		table.insert(Mission.USD, FindEntity("Alaska17"))
	for idx,unit in pairs(Mission.USD) do

		JoinFormation(unit, Mission.USD[1])
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
	
	NavigatorAttackMove(Mission.USD[1], Mission.JapFleetA[1])
	
	Mission.USE = {}
		table.insert(Mission.USE, FindEntity("Montana2"))
		table.insert(Mission.USE, FindEntity("Alaska18"))
		table.insert(Mission.USE, FindEntity("Alaska19"))
	for idx,unit in pairs(Mission.USE) do

		JoinFormation(unit, Mission.USE[1])
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
	
	NavigatorAttackMove(Mission.USE[1], Mission.JapFleetC[1])
	
	Mission.Fleet = luaSumTablesIndex(Mission.USA, Mission.USB, Mission.USD, Mission.USE)
	
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
	
	MissionNarrative("Near an undocumented island chain in the pacific....")
	
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
	
	--luaShowPath(FindEntity("CVPath1"))
	
	--luaShowPath(FindEntity("CVPath2"))
	
	--luaShowPath(FindEntity("CVPath3"))
	
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
			
			
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Fleet)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 1, true)
				
					luaPh1FadeOut()				
				
				end
			
			end	
		
		elseif Mission.MissionPhase == 2 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CV)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CV)) do
					
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 26,
						
						}
						local bombers = {
							[1] = 38,
						}
						
						
						local trgs = luaGetUSPlaneTrg()
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CV)) == 0 then
				
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
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Zuiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Zuiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana1"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana1"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Yamato"))
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Fleet)

end

-- Phase 2

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	luaSpawnCV()
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = FindEntity("Midway1"), ["distance"] = 300, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = FindEntity("Midway1"), ["distance"] = 300, ["theta"] = 6, ["rho"] = 78, ["moveTime"] = 4},
	  
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	SetSelectedUnit(FindEntity("Hakuryu"))
	
	luaAddSecObjs()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.CV)
	
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

function luaSpawnCV()

	Mission.USCVA = {}
		table.insert(Mission.USCVA, GenerateObject("Midway1"))
		table.insert(Mission.USCVA, GenerateObject("Midway2"))
		table.insert(Mission.USCVA, GenerateObject("Midway3"))
		table.insert(Mission.USCVA, GenerateObject("Alaska1"))
		table.insert(Mission.USCVA, GenerateObject("Alaska2"))
		table.insert(Mission.USCVA, GenerateObject("Somers1"))
		table.insert(Mission.USCVA, GenerateObject("Somers2"))
		table.insert(Mission.USCVA, GenerateObject("Somers3"))
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
		table.insert(Mission.USCVB, GenerateObject("Midway4"))
		table.insert(Mission.USCVB, GenerateObject("Midway5"))
		table.insert(Mission.USCVB, GenerateObject("Midway6"))
		table.insert(Mission.USCVB, GenerateObject("Alaska3"))
		table.insert(Mission.USCVB, GenerateObject("Alaska4"))
		table.insert(Mission.USCVB, GenerateObject("Somers4"))
		table.insert(Mission.USCVB, GenerateObject("Somers5"))
		table.insert(Mission.USCVB, GenerateObject("Somers6"))
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
	
	Mission.USCVC = {}
		table.insert(Mission.USCVC, GenerateObject("Midway7"))
		table.insert(Mission.USCVC, GenerateObject("Midway8"))
		table.insert(Mission.USCVC, GenerateObject("Midway9"))
		table.insert(Mission.USCVC, GenerateObject("Alaska5"))
		table.insert(Mission.USCVC, GenerateObject("Alaska6"))
		table.insert(Mission.USCVC, GenerateObject("Somers7"))
		table.insert(Mission.USCVC, GenerateObject("Somers8"))
		table.insert(Mission.USCVC, GenerateObject("Somers9"))
	for idx,unit in pairs(Mission.USCVC) do
		
		JoinFormation(unit, Mission.USCVC[1])
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

	Mission.CV = {}
		table.insert(Mission.CV, FindEntity("Midway1"))
		table.insert(Mission.CV, FindEntity("Midway2"))
		table.insert(Mission.CV, FindEntity("Midway3"))
		table.insert(Mission.CV, FindEntity("Midway4"))
		table.insert(Mission.CV, FindEntity("Midway5"))
		table.insert(Mission.CV, FindEntity("Midway6"))
		table.insert(Mission.CV, FindEntity("Midway7"))
		table.insert(Mission.CV, FindEntity("Midway8"))
		table.insert(Mission.CV, FindEntity("Midway9"))

	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway1"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway1"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway2"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway2"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway3"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway3"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway4"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway4"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway5"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway5"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway6"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway6"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway7"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway7"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway8"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway8"), 2)
				
	end
	
	if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 1)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(FindEntity("Midway9"), 2)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(FindEntity("Midway9"), 2)
				
	end

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