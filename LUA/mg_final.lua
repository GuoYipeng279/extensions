-- Scripted & Assembled by: Team Wolfpack

---- Defense of Hokkaido (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(5) 	-- P80
	PrepareClass(331) 	-- BTD
	
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
	Mission.ScriptFile = "Scripts/missions/IJN/mg_final.lua"

	this.Name = "IJN45"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Repel",
				["Text"] = "Repel the enemy air waves!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Sink",
				["Text"] = "Sink all enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Def",
				["Text"] = "Annihalate the allied fleet!",
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
		table.insert(Mission.JapFleetA, FindEntity("Kokuryu"))
		table.insert(Mission.JapFleetA, FindEntity("Zuiryu"))
		table.insert(Mission.JapFleetA, FindEntity("Oryu"))
		table.insert(Mission.JapFleetA, FindEntity("Azuma"))
		table.insert(Mission.JapFleetA, FindEntity("Yoshino"))
		table.insert(Mission.JapFleetA, FindEntity("Azumaya"))
		table.insert(Mission.JapFleetA, FindEntity("Mitsumine"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate1"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate2"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate3"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate4"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate5"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate6"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate7"))
		table.insert(Mission.JapFleetA, FindEntity("Hayate8"))
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
		table.insert(Mission.JapFleetB, FindEntity("Zuikaku"))
		table.insert(Mission.JapFleetB, FindEntity("Shokaku"))
		table.insert(Mission.JapFleetB, FindEntity("Unryu"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma5"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma6"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma7"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma8"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma9"))
		table.insert(Mission.JapFleetB, FindEntity("Azuma10"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate9"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate10"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate11"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate12"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate13"))
		table.insert(Mission.JapFleetB, FindEntity("Hayate14"))
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
		table.insert(Mission.JapCapitalShips, FindEntity("Zuiryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Oryu"))
		table.insert(Mission.JapCapitalShips, FindEntity("Taiho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Unho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Shinho"))
		table.insert(Mission.JapCapitalShips, FindEntity("Zuikaku"))
		table.insert(Mission.JapCapitalShips, FindEntity("Shokaku"))
		table.insert(Mission.JapCapitalShips, FindEntity("Unryu"))
	
	---- USN ----
	
	-- Destroyer Table -- 
	
	Mission.Wave = {}
		table.insert(Mission.Wave, "DestroyerSpawn1")
		table.insert(Mission.Wave, "DestroyerSpawn2")
		table.insert(Mission.Wave, "DestroyerSpawn3")
		table.insert(Mission.Wave, "DestroyerSpawn4")
		table.insert(Mission.Wave, "DestroyerSpawn5")
		table.insert(Mission.Wave, "DestroyerSpawn6")
		table.insert(Mission.Wave, "DestroyerSpawn7")
		table.insert(Mission.Wave, "DestroyerSpawn8")
	
	-- BTD Wave --
	
	Mission.BTD = {}
	
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
	
	MissionNarrative("Somewhere off Hokkaido as the IJN returns from San Francisco....")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(20.0)
	
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
			
			
			
		end
		
		if Mission.MissionPhase == 1 then
			
				if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.BTD)) == 0 then 
				if Mission.AttackWaves == 3 then
				
				luaObj_Completed("primary", 1, true)
				luaPh1FadeOut()
					
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
		
		elseif Mission.MissionPhase == 2 then

			if table.getn(luaRemoveDeadsFromTable(Mission.USCV)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USCV)) do
					
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 5,
						
						}
						local bombers = {
							[1] = 331,
						}
						
						
						local trgs = luaGetUSPlaneTrg()
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
		
			if luaObj_IsActive("primary", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USCV)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 2, true)
				
					luaPh2FadeOut()
				
				end
				
			end
		
		elseif Mission.MissionPhase == 3 then

			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Allies)) == 0 then
				
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
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 450, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Hakuryu"), ["distance"] = 300, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
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
	
	luaSpawnNextAttackWave()
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.BTD)

end

function luaSpawnNextAttackWave()

	if Mission.AttackWaves < 3 then 

		for idx4,unit in pairs(Mission.Wave) do
			local plane = GenerateObject(unit)
			SetSkillLevel(plane, Mission.SkillLevel)
			table.insert(Mission.BTD, plane)
			if luaObj_IsActive("primary", 1) then
			luaObj_AddUnit("primary",1,plane)
			end
			SetForcedReconLevel(plane, 2, PARTY_JAPANESE)
		end
	Mission.AttackWaves = Mission.AttackWaves + 1
	luaDelay(luaSpawnNextAttackWave, 150)
	end
end

---- PHASE 2 ----

function luaPh2FadeOut()

	Blackout(true, "luaMoveToPh3", 1)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	luaSpawnCV()
	
	luaIngameMovie(
	{
		
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Essex1"), ["distance"] = 1300, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Essex1"), ["distance"] = 1500, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	SetSelectedUnit(Mission.JapFleetA[1])
	
	luaAddSecObjs()

end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.USCV)

end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaSpawnIJN()
	
	luaSpawnBB()
	
	luaIngameMovie(
	{
		
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 300, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 200, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaPh3MovieEnd, true)

end

function luaPh3MovieEnd()

	SetSelectedUnit(Mission.JapFleetC[1])
	
	luaAddThrObjs()

end

function luaAddThrObjs()

	luaObj_Add("primary", 3, Mission.Allies)

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
function luaSpawnIJN()

	Mission.JapFleetC = {}
		table.insert(Mission.JapFleetC, GenerateObject("Yashima"))
		table.insert(Mission.JapFleetC, GenerateObject("Asahi"))
		table.insert(Mission.JapFleetC, GenerateObject("Shikishima"))
		table.insert(Mission.JapFleetC, GenerateObject("Shinano"))
		table.insert(Mission.JapFleetC, GenerateObject("Iwami"))
		table.insert(Mission.JapFleetC, GenerateObject("Azuma11"))
		table.insert(Mission.JapFleetC, GenerateObject("Azuma12"))
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

end

function luaSpawnBB()

	Mission.USSR = {}
		table.insert(Mission.USSR, GenerateObject("Tran1"))
		table.insert(Mission.USSR, GenerateObject("Tran2"))
		table.insert(Mission.USSR, GenerateObject("Tran3"))
		table.insert(Mission.USSR, GenerateObject("Tran4"))
		table.insert(Mission.USSR, GenerateObject("Tran5"))
		table.insert(Mission.USSR, GenerateObject("Tran6"))
		table.insert(Mission.USSR, GenerateObject("Tran7"))
		table.insert(Mission.USSR, GenerateObject("Tran8"))
		table.insert(Mission.USSR, GenerateObject("Kremlin"))
		table.insert(Mission.USSR, GenerateObject("Slava"))
		table.insert(Mission.USSR, GenerateObject("Gromky"))
		table.insert(Mission.USSR, GenerateObject("Grozyashchy"))
		table.insert(Mission.USSR, GenerateObject("Retivy"))
		table.insert(Mission.USSR, GenerateObject("Bezuprechny"))
		table.insert(Mission.USSR, GenerateObject("Uda5"))
		table.insert(Mission.USSR, GenerateObject("Uda6"))
		table.insert(Mission.USSR, GenerateObject("Uda7"))
		table.insert(Mission.USSR, GenerateObject("Uda8"))
		table.insert(Mission.USSR, GenerateObject("Uda9"))
	for idx,unit in pairs(Mission.USSR) do
		
		JoinFormation(unit, Mission.USSR[1])
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

	Mission.UsOne = {}
		table.insert(Mission.UsOne, GenerateObject("Missouri"))
		table.insert(Mission.UsOne, GenerateObject("Iowa"))
		table.insert(Mission.UsOne, GenerateObject("Alaska1"))
		table.insert(Mission.UsOne, GenerateObject("Alaska2"))
		table.insert(Mission.UsOne, GenerateObject("Allen17"))
		table.insert(Mission.UsOne, GenerateObject("Allen18"))
	for idx,unit in pairs(Mission.UsOne) do
		
		JoinFormation(unit, Mission.UsOne[1])
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

	NavigatorAttackMove(Mission.UsOne[1], Mission.JapFleetC[1])

	Mission.UsTwo = {}
		table.insert(Mission.UsTwo, GenerateObject("Montana"))
		table.insert(Mission.UsTwo, GenerateObject("Ohio"))
		table.insert(Mission.UsTwo, GenerateObject("Alaska3"))
		table.insert(Mission.UsTwo, GenerateObject("Alaska4"))
		table.insert(Mission.UsTwo, GenerateObject("Allen19"))
		table.insert(Mission.UsTwo, GenerateObject("Allen20"))
	for idx,unit in pairs(Mission.UsTwo) do
		
		JoinFormation(unit, Mission.UsTwo[1])
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

	NavigatorAttackMove(Mission.UsTwo[1], Mission.JapFleetC[1])

	Mission.Allies = luaSumTablesIndex(Mission.USSR, Mission.UsOne, Mission.UsTwo)

end

function luaSpawnCV()

	Mission.USA = {}
		table.insert(Mission.USA, GenerateObject("Essex1"))
		table.insert(Mission.USA, GenerateObject("Essex2"))
		table.insert(Mission.USA, GenerateObject("Essex3"))
		table.insert(Mission.USA, GenerateObject("Allen1"))
		table.insert(Mission.USA, GenerateObject("Allen2"))
		table.insert(Mission.USA, GenerateObject("Allen3"))
		table.insert(Mission.USA, GenerateObject("Allen4"))
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
	
	Mission.USB = {}
		table.insert(Mission.USB, GenerateObject("Essex4"))
		table.insert(Mission.USB, GenerateObject("Essex5"))
		table.insert(Mission.USB, GenerateObject("Essex6"))
		table.insert(Mission.USB, GenerateObject("Allen5"))
		table.insert(Mission.USB, GenerateObject("Allen6"))
		table.insert(Mission.USB, GenerateObject("Allen7"))
		table.insert(Mission.USB, GenerateObject("Allen8"))
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
	
	Mission.USC = {}
		table.insert(Mission.USC, GenerateObject("Essex7"))
		table.insert(Mission.USC, GenerateObject("Essex8"))
		table.insert(Mission.USC, GenerateObject("Essex9"))
		table.insert(Mission.USC, GenerateObject("Allen9"))
		table.insert(Mission.USC, GenerateObject("Allen10"))
		table.insert(Mission.USC, GenerateObject("Allen11"))
		table.insert(Mission.USC, GenerateObject("Allen12"))
	for idx,unit in pairs(Mission.USC) do
		
		JoinFormation(unit, Mission.USC[1])
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
	
	Mission.USD = {}
		table.insert(Mission.USD, GenerateObject("Essex10"))
		table.insert(Mission.USD, GenerateObject("Essex11"))
		table.insert(Mission.USD, GenerateObject("Essex12"))
		table.insert(Mission.USD, GenerateObject("Allen13"))
		table.insert(Mission.USD, GenerateObject("Allen14"))
		table.insert(Mission.USD, GenerateObject("Allen15"))
		table.insert(Mission.USD, GenerateObject("Allen16"))
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

	Mission.USCV = {}
		table.insert(Mission.USCV, FindEntity("Essex1"))
		table.insert(Mission.USCV, FindEntity("Essex2"))
		table.insert(Mission.USCV, FindEntity("Essex3"))
		table.insert(Mission.USCV, FindEntity("Essex4"))
		table.insert(Mission.USCV, FindEntity("Essex5"))
		table.insert(Mission.USCV, FindEntity("Essex6"))
		table.insert(Mission.USCV, FindEntity("Essex7"))
		table.insert(Mission.USCV, FindEntity("Essex8"))
		table.insert(Mission.USCV, FindEntity("Essex9"))
		table.insert(Mission.USCV, FindEntity("Essex10"))
		table.insert(Mission.USCV, FindEntity("Essex11"))
		table.insert(Mission.USCV, FindEntity("Essex12"))

	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex1"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex1"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex1"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex2"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex2"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex2"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex3"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex3"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex3"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex4"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex4"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex4"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex5"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex5"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex5"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex6"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex6"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex6"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex7"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex7"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex7"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex8"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex8"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex8"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex9"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex9"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex9"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex10"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex10"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex10"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex11"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex11"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex11"), 2)
		
	end
	
	if Mission.Difficulty == 0 then
	
			SetAirBaseSlotCount(FindEntity("Essex12"), 2)
		
		elseif Mission.Difficulty == 1 then
		
			SetAirBaseSlotCount(FindEntity("Essex12"), 2)
		
		elseif Mission.Difficulty == 2 then
		
			SetAirBaseSlotCount(FindEntity("Essex12"), 2)
		
	end

end

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