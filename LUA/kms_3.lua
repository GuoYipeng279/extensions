---- GERMAN MISSION #3 (KMS) ----

-- Scripted & Assembled by: Team Wolfpack

---- GERMAN MISSION #3 (KMS) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	
	
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
	
	LoadMessageMap("kmsdlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/KMS/kms_3.lua"

	this.Name = "KMS3"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Fort",
				["Text"] = "Strike the enemy land installations!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Schrn",
				["Text"] = "Ensure Scharnhorst's survival!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Sink the Soviet fleet!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "GZ",
				["Text"] = "Ensure Graf Zeppelin's survival!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "DD",
				["Text"] = "Prevent the loss of 3 or more destroyers!",
				["TextFailed"] = "3 of our destroyers have been sunk!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Dest",
				["Text"] = "Destroy all fortresses in the area!",
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
				{
					["message"] = "INTRO4",
				},
				{
					["message"] = "INTRO5",
				},
			},
		},
		["MINES"] = {--
			["sequence"] = {
				{
					["message"] = "MINES1",
				},
				{
					["message"] = "MINES2",
				},
			},
		},
		["EXPLOSION"] = {--
			["sequence"] = {
				{
					["message"] = "EXPLOSION1",
				},
				{
					["message"] = "EXPLOSION2",
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
				{
					["message"] = "MESSAGE5",
				},
				{
					["message"] = "MESSAGE6",
				},
				--[[{
					["message"] = "MESSAGE7",
				},
				{
					["message"] = "MESSAGE8",
				},
				{
					["message"] = "MESSAGE9",
				},]]
				{
					["message"] = "MESSAGE10",
				},
				{
					["message"] = "MESSAGE11",
				},
				{
					["message"] = "MESSAGE12",
				},
				{
					["type"] = "callback",
					["callback"] = "luaSpawnKrijemljin",
				},
			},
		},
		["BB"] = {--
			["sequence"] = {
				{
					["message"] = "BB1",
				},
				{
					["message"] = "BB2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
				{
					["message"] = "RUSSIAN1",
				},
				{
					["message"] = "RUSSIAN2",
				},
				{
					["message"] = "RUSSIAN3",
				},
			},
		},
		["CRITICAL"] = {--
			["sequence"] = {
				{
					["message"] = "CRITICAL1",
				},
				{
					["message"] = "CRITICAL2",
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
	
	Mission.Scharnhorst = FindEntity("Scharnhorst")
	
	Mission.ScharnhorstFleet = {}
		table.insert(Mission.ScharnhorstFleet, Mission.Scharnhorst)
		table.insert(Mission.ScharnhorstFleet, FindEntity("Z5"))
		table.insert(Mission.ScharnhorstFleet, FindEntity("Z7"))
		table.insert(Mission.ScharnhorstFleet, FindEntity("Z11"))
		table.insert(Mission.ScharnhorstFleet, FindEntity("Z9"))
		table.insert(Mission.ScharnhorstFleet, FindEntity("Z16"))
	
	for idx,unit in pairs(Mission.ScharnhorstFleet) do
		
		JoinFormation(unit, Mission.ScharnhorstFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		UnitHoldFire(unit)
		
	end
	
	Mission.GermanDDs = {}
		table.insert(Mission.GermanDDs, FindEntity("Z5"))
		table.insert(Mission.GermanDDs, FindEntity("Z7"))
		table.insert(Mission.GermanDDs, FindEntity("Z11"))
		table.insert(Mission.GermanDDs, FindEntity("Z9"))
		table.insert(Mission.GermanDDs, FindEntity("Z16"))
	
	---- USSR ----
	
	Mission.LandInstallations = {}
		table.insert(Mission.LandInstallations, FindEntity("Shipyard02"))
		table.insert(Mission.LandInstallations, FindEntity("Shipyard03"))
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and ((string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Coastal Gun")) or (string.find(unit.Name, "Medium Bunker") or string.find(unit.Name, "New Bunker"))) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LandInstallations)) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		UnitHoldFire(unit)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	--[[for i = 1, 2 do
		
		local X1
		local Y1
		local X2
		local Y2
		
		if i == 1 then
		
			X1 = -3000
			Y1 = -3000
			X2 = -2000
			Y2 = -2000
		
		else
		
			X1 = 0
			Y1 = -1000
			X2 = 2000
			Y2 = 0
		
		end
		
		for j = 1, 20 do
		
			local mine = GenerateObject("WaterMine")
			
			local pos = {["x"] = 0, ["y"] = 0, ["z"] = 0}
			
			PutTo(FindEntity("WaterMine-01"), pos)
		
		end
	
	end]]
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.GZDelay = 200
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.GZDelay = 300
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.GZDelay = 400
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("February 1st, 1942 - Off the Soviet Coast")
	
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
	
	--luaShowPoint(FindEntity("TEST1"))
	--luaShowPoint(FindEntity("TEST2"))
	
	--luaShowPath(FindEntity("BBPath"))
	
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
	
	--Mission.TEST = table.getn(Mission.Mines)
	--MissionNarrative("#Mission.TEST#")
	
end

---- OBJECTIVE CHECKER ----

function luaCheckObjectives()

	if not Mission.EndMission then
	
		if Mission.MissionPhase > 0 then
			
			if luaObj_IsActive("primary",2) then
			
				if Mission.Scharnhorst.Dead then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("primary",3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.KremlinFleet)) == 0 then
					
					HideUnitHP()
					
					luaMissionComplete()
				
				else
				
					if not Mission.CriticalDiaPlayed then
					
						if Mission.Kremlin and not Mission.Kremlin.Dead then
						
							if GetHpPercentage(Mission.Kremlin) <= 0.1 then
							
								luaStartDialog("CRITICAL")
								
								Mission.CriticalDiaPlayed = true
							
							end
						
						end
					
					end
				
				end
			
			end
			
			if luaObj_IsActive("primary",4) then
			
				if Mission.GZ.Dead then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("secondary",1) then
				
				local checkNum = 2
				
				if Mission.GZHere then
				
					checkNum = 4
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.GermanDDs)) <= checkNum then
				
					luaObj_Failed("secondary", 1, true)
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

function luaSpawnGZ()
	
	if Mission.EndMission then
	
		return
	
	end
	
	Mission.GZHere = true
	
	Mission.GZ = GenerateObject("Graf Zeppelin")
	
	Mission.GZFleet = {}
		table.insert(Mission.GZFleet, Mission.GZ)
		table.insert(Mission.GZFleet, GenerateObject("Z17"))
		table.insert(Mission.GZFleet, GenerateObject("Z20"))
	
	for idx,unit in pairs(Mission.GZFleet) do
		
		JoinFormation(unit, Mission.GZFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	table.insert(Mission.GermanDDs, FindEntity("Z17"))
	table.insert(Mission.GermanDDs, FindEntity("Z20"))
	
	if luaObj_IsActive("secondary",1) then
	
		luaObj_AddUnit("secondary", 1, FindEntity("Z17"))
		luaObj_AddUnit("secondary", 1, FindEntity("Z20"))
	
	end
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.GZFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		
	}, luaGZMovieEnd, true)
	
end

function luaGZMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.GZFleet)))
	
	end
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 4, Mission.GZ)
	
	if table.getn(luaRemoveDeadsFromTable(Mission.SovietDDs)) > 0 then
	
		local unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.SovietDDs))
		
		if unit and not unit.Dead then
		
			NavigatorAttackMove(unit, Mission.GZ)
			
		end
		
	end
	
end

function luaKremlinMovieEnd()
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.ScharnhorstFleet)))
	
	end
	
end

function luaAddSecObjs()
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaObj_Add("primary", 3, Mission.KremlinFleet)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.KremlinFleet), "Sink the Soviet fleet!")
	
	luaDelay(luaSpawnGZ, Mission.GZDelay)
	Countdown("Reinforcements arrive in: ", 0, Mission.GZDelay)
	
	if Mission.Difficulty > 0 then
	
		luaDelay(luaMakeDDsAttack, 80)
	
	end
	
end

function luaKremlinDia()

	luaStartDialog("BB")

end

function luaMakeDDsAttack()

	if table.getn(luaRemoveDeadsFromTable(Mission.SovietDDs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SovietDDs)) do
		
			if unit and not unit.Dead then
			
				local trg
				
				if Mission.Difficulty == 2 then
				
					trg = Mission.Scharnhorst
				
				else
				
					trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.ScharnhorstFleet))
				
				end
				
				NavigatorAttackMove(unit, trg)
				
				UnitSetFireStance(unit, 2)
				
			end
			
		end
		
	end
	
end

---- PHASE 1 ----

function luaSpawnKrijemljin()
	
	Mission.KremlinHere = true
	
	Mission.Kremlin = GenerateObject("Kremlin")
	
	Mission.KremlinFleet = {}
		table.insert(Mission.KremlinFleet, Mission.Kremlin)
		table.insert(Mission.KremlinFleet, GenerateObject("Gromky"))
		table.insert(Mission.KremlinFleet, GenerateObject("Grozyashchy"))
		table.insert(Mission.KremlinFleet, GenerateObject("Retivy"))
		table.insert(Mission.KremlinFleet, GenerateObject("Bezuprechny"))
	
	for idx,unit in pairs(Mission.KremlinFleet) do
		
		JoinFormation(unit, Mission.KremlinFleet[1])
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
	
	Mission.SovietDDs = {}
		table.insert(Mission.SovietDDs, FindEntity("Gromky"))
		table.insert(Mission.SovietDDs, FindEntity("Grozyashchy"))
		table.insert(Mission.SovietDDs, FindEntity("Retivy"))
		table.insert(Mission.SovietDDs, FindEntity("Bezuprechny"))
	
	SetSkillLevel(Mission.Kremlin, SKILL_ELITE)
	
	--NavigatorAttackMove(Mission.KremlinFleet[1], Mission.Scharnhorst)
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.KremlinFleet[1], FindEntity("BBPath"), PATH_FM_CIRCLE, pathDir)
	
	luaAddKremlinListener()
	
end

function luaMessageDia()

	luaStartDialog("MESSAGE")

end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 3)
	
	local trg1 = FindEntity("Scharnhorst")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-45,["y"]=5,["z"]=55},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=15,["z"]=75},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=75},["parent"] = trg1,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 2},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIn, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIn()
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LandInstallations)) do
		
		UnitFreeFire(unit)
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ScharnhorstFleet)) do
		
		UnitFreeFire(unit)
		
	end
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Scharnhorst)
	
	--Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.LandInstallations)
	luaObj_Add("primary", 2, Mission.Scharnhorst)
	luaObj_Add("secondary", 1, Mission.GermanDDs)
	luaObj_Add("hidden", 1)
	
	local line1 = "Strike the enemy land installations!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	luaDelay(luaSpotMines, 100)
	luaDelay(luaMessageDia, 210)
	
end

function luaSpotMines()
	
	--if IsListenerActive("hit", "MineHitListener") then
	
		--RemoveListener("hit", "MineHitListener")
		
		luaStartDialog("MINES")
		
	--end
	
end

---- LISTENERS ----

function luaAddKremlinListener()

	AddListener("recon", "KremlinListener", {
		["callback"] = "luaKremlinSighted",
		["entity"] = Mission.KremlinFleet,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

--[[function luaAddMineHitListener()

	AddListener("hit", "MineHitListener", {
		["callback"] = "luaMineHit",
		["target"] = Mission.ScharnhorstFleet,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end]]

---- LISTENER CALLBACKS ----

function luaKremlinSighted()
	
	RemoveListener("recon", "KremlinListener")
	
	HideScoreDisplay(1,0)
	
	luaObj_Completed("primary",1)
	
	luaDelay(luaKremlinDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.KremlinFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		
	}, luaKremlinMovieEnd, true)
	
end

--[[function luaMineHit(unit, bruh, attacker)

	if attacker.Type == "WATERMINE" then
		
		RemoveListener("hit", "MineHitListener")
		
		luaStartDialog("EXPLOSION")
		
	end

end]]

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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.LandInstallations)) == 0 then
		
			luaObj_Completed("hidden",1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
		
	end
	
	luaMissionCompletedNew(Mission.Scharnhorst, "The Soviets have been crushed - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideScoreDisplay(1,0)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Failed("primary",4)
	
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