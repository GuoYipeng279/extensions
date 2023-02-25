---- GROWLING TIGERES (USN) ----

-- Scripted & Assembled by: Team Wolfpack

---- GROWLING TIGERES (USN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(354) 	-- P40
	PrepareClass(353) 	-- I-16
	
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
	
	--LoadMessageMap("ijndlg",14)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_20_finale.lua"

	this.Name = "USN15"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "AF",
				["Text"] = "Defend your airfield from Japanese dive bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "SB",
				["Text"] = "Defend the supply bases from Japanese level bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Village",
				["Text"] = "Shoot down the Japanese bombers headed for the village!",
				["TextCompleted"] = "The village is saved!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Zero",
				["Text"] = "Chase the fleeing Zeroes! Don't lose them!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Final",
				["Text"] = "Destroy the Japanese invasion before they neutralize the base!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Yat Sen",
				["Text"] = "Ensure the survival of the Yat Sen!",
				["TextFailed"] = "The Yat Sen is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Sec",
				["Text"] = "Destroy the enemy units in the area!",
				["TextCompleted"] = "The secondary units have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Pers",
				["Text"] = "Personally shoot down 50 aircraft!",
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
	
	---- DIFFICULTY SETTING ----
	
	Mission.Difficulty = 1
	
	--if Mission.Difficulty == 0 then
	--	Mission.SkillLevel = SKILL_SPNORMAL
	--elseif Mission.Difficulty == 1 then
		--Mission.SkillLevel = SKILL_SPVETERAN
	--elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	--end
	--if Mission.Difficulty == 0 then
	--	Mission.SkillLevelOwn = SKILL_ELITE
	--elseif Mission.Difficulty == 1 then
		Mission.SkillLevelOwn = SKILL_SPVETERAN
	--[[elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_SPNORMAL
	end]]
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	---- IJA ----
	
	Mission.MovieBombas = {}
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba1"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba2"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba3"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba4"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba5"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba6"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba7"))
		table.insert(Mission.MovieBombas, FindEntity("MovieBomba8"))
	
	for idx,unit in pairs(Mission.MovieBombas) do
		
		SetInvincible(unit, 0.4)
		
		local pos = GetPosition(unit)
		
		SquadronSetTravelAlt(unit, pos.y, true)
		SquadronSetAttackAlt(unit, pos.y, true)	
		
		PilotSetTarget(unit, FindEntity("Airfield1"))
		
	end
	
	Mission.StrikePren = {}
	Mission.VilladgeBombas = {}
	Mission.VilladgeFightas = {}
	
	---- ROC ----
	
	Mission.Airfield = FindEntity("Airfield1")
	
	SetSkillLevel(Mission.Airfield, Mission.SkillLevelOwn)
	
	RepairEnable(Mission.Airfield, false)
	
	AddAirBaseStock(Mission.Airfield, 354, 24)
	AddAirBaseStock(Mission.Airfield, 353, 12)
	
	Mission.SBs = {}
		table.insert(Mission.SBs, FindEntity("SB1"))
		table.insert(Mission.SBs, FindEntity("SB2"))
	
	for idx,unit in pairs(Mission.SBs) do
	
		SetSkillLevel(unit, Mission.SkillLevelOwn)
	
		RepairEnable(unit, false)
	
	end
	
	Mission.Villadge = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if string.find(unit.Name, "Village") then
		
			table.insert(Mission.Villadge, unit)
		
		end
		
	end
	
	---- VAR ----
	
	Mission.CheckPoint = FindEntity("CheckPoint")
	Mission.VilladgePos = GetPosition(FindEntity("VillageCB"))
	Mission.VilladgeBombaPath = FindEntity("BombaPath")
	Mission.VilladgeBombaPathPoints = FillPathPoints(FindEntity("BombaPath"))
	
	SetInvincible(FindEntity("VillageCB"), 0.4)
	
	Mission.EscapePaths = {}
		table.insert(Mission.EscapePaths, FindEntity("EscapePath1"))
		table.insert(Mission.EscapePaths, FindEntity("EscapePath2"))
		table.insert(Mission.EscapePaths, FindEntity("EscapePath3"))
		table.insert(Mission.EscapePaths, FindEntity("EscapePath4"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.StrikeWaves = 0
	Mission.CanWarn = true
	Mission.CalmMusic = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.StrikeDelay = 80
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.StrikeDelay = 60
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.StrikeDelay = 40
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	Blackout(true, "", true)
	
	---- THINK ----
	
	luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh3, 70)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaMoveToPh4, 70)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Val1")
	--PilotSetTarget(FindEntity("Val1"), FindEntity("Airfield1"))
	
	--luaShowPoint(FindEntity("NukeMoveTo"))
	--[[luaShowPoint(FindEntity("FinalSmoke2"))
	luaShowPoint(FindEntity("FinalSmoke3"))
	luaShowPoint(FindEntity("FinalSmoke4"))
	luaShowPoint(FindEntity("FinalSmoke5"))
	luaShowPoint(FindEntity("FinalSmoke6"))
	luaShowPoint(FindEntity("FinalSmoke7"))
	luaShowPoint(FindEntity("FinalSmoke8"))
	luaShowPoint(FindEntity("FinalSmoke9"))
	luaShowPoint(FindEntity("FinalSmoke10"))
	luaShowPoint(FindEntity("FinalSmoke11"))]]
	
	--Mission.EscapingZero = FindEntity("TEST")
	
	--[[PutTo(FindEntity("TEST"), FillPathPoints(FindEntity("BombaPath"))[1])
	
	luaShowPath(FindEntity("BombaPath"))
	luaShowPath(FindEntity("EscapePath1"))
	luaShowPath(FindEntity("EscapePath2"))
	luaShowPath(FindEntity("EscapePath3"))
	luaShowPath(FindEntity("EscapePath4"))
	
	PilotMoveOnPath(FindEntity("TEST"), FindEntity("BombaPath"))]]
	--luaShowPath(FindEntity("BBPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		SetInvincible(Mission.Airfield, 0.4)
		
		for idx,unit in pairs(Mission.SBs) do
			
			SetInvincible(unit, 0.4)
			
		end
		
		--AddAirBaseStock(Mission.Airfield, 354, 50)
		
		SetInvincible(FindEntity("CB"), 0.4)
		
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
	
	--[[if luaObj_IsActive("secondary", 2) then
	
		Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.SecUnits))
		MissionNarrative("#Mission.TEST#")
	
	end]]
	
	--luaPathChecker()
	
	--print("text")
	
	--[[local pos = GetPosition(FindEntity("MovieBomba1"))
	
	Mission.X = string.format("%.f", pos.x)
	Mission.Y = string.format("%.f", pos.y)
	Mission.Z = string.format("%.f", pos.z)
	
	local line1 = "X: #Mission.X# Y: #Mission.Y# Z: #Mission.Z#"
	local line2 = ""
	luaDisplayScore(1, line1, line2)]]
	
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
			
			else
			
				if Mission.CalmMusic then
				
					Music_Control_SetLevel(MUSIC_CALM)
					luaCheckMusicSetMinLevel(MUSIC_CALM)
				
				else
				
					Music_Control_SetLevel(MUSIC_TENSION)
					luaCheckMusicSetMinLevel(MUSIC_TENSION)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 50 then
				
					luaObj_Completed("hidden", 1, true)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
		
			if luaObj_IsActive("primary", 1) then
			
				if Mission.Airfield.Dead then
				
					luaMissionFailed(Mission.Airfield)
				
				else
					
					if Mission.StrikeWaves >= 3 then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.StrikePren)) == 0 then
							
							SetInvincible(Mission.Airfield, 0.01)
							
							HideUnitHP()
						
							luaObj_Completed("primary", 1)
							
							luaMoveToPh2()
					
						end
					
					end
					
				end
			
			end
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
			
				if Mission.SBs[1].Party == PARTY_NEUTRAL or Mission.SBs[2].Party == PARTY_NEUTRAL then
				
					luaMissionFailed(luaPickRnd(Mission.SBs))
				
				else
					
					if Mission.StrikeWaves >= 3 then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.StrikePren)) == 0 then
							
							SetInvincible(Mission.SBs[1], 0.01)
							SetInvincible(Mission.SBs[2], 0.01)
							
							HideUnitHP()
						
							luaObj_Completed("primary", 2)
							
							luaMoveToPh3()
					
						end
					
					end
					
				end
			
			end
		
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 3) and not Mission.BoutToFail then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) == 0 then
					
					Mission.Ph3Over = true
					
					HideUnitHP()
					
					luaObj_Completed("primary", 3, true)
					
					luaPh3Blackout()
				
				else
					
					local ordered = luaSortByDistance(FindEntity("VillageCB"), luaRemoveDeadsFromTable(Mission.VilladgeBombas))
					local closest = ordered[1]
					local dist = luaGetDistance3D(closest, FindEntity("VillageCB"))
					
					if dist < 540 then
						
						if not Mission.BoutToFail then
						
							luaPh3FailMovie()
							
							SetInvincible(FindEntity("VillageCB"), false)
							
							Mission.BoutToFail = true
							
						end
						
					else
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) do
						
							if unit and not unit.Dead then
							
								if not unit.CHG11_VillageClose then
								
									if luaGetDistance3D(unit, Mission.VilladgeBombaPathPoints[6]) < 900 then
									
										PilotSetTarget(unit, luaPickRnd(Mission.Villadge))
										
										unit.CHG11_VillageClose = true
										
									end
								
								end
							
							end
						
						end
					
					end
				
				end
			
			end
			
		elseif Mission.MissionPhase == 4 then
			
			if luaObj_IsActive("primary", 4) then
			
				if Mission.EscapingZero.Dead then
				
					luaMissionComplete()
				
				elseif Mission.ChasingTiger.Dead then
				
					luaMissionFailed(nil)
				
				else
				
					local dist = luaGetDistance3D(Mission.ChasingTiger, Mission.EscapingZero)
					local dist2 = luaGetDistance3D(Mission.ChasingTiger, Mission.CheckPoint)
					
					if dist > 4000 then
					
						luaMissionFailed(Mission.ChasingTiger)
					
					elseif dist2 < 9600 then
					
						HideUnitHP()
					
						luaObj_Completed("primary", 4)
						
						luaPh4FadeOut()
						
					end
					
					if Mission.CanWarn then
					
						if dist > 3200 then
						
							MissionNarrative("You're losing the Zero!")
							
							Mission.CanWarn = false
							
							luaDelay(luaCanWarnAgain, 20)
							
						end
					
					end
					
					if dist <= 1000 and not Mission.TurboActive then
					
						SetCheatTurbo(Mission.EscapingZero, 1.7)
						
						Mission.TurboActive = true
						
					elseif dist > 1000 and Mission.TurboActive then
					
						SetCheatTurbo(Mission.EscapingZero, 1)
						
						Mission.TurboActive = false
					
					end
					
					--[[if not Mission.ZeroInv then
					
						if luaGetSquadronPlaneNum(Mission.EscapingZero) == 1 then
						
							SetInvincible(Mission.EscapingZero, 0.01)
							
							Mission.ZeroInv = true
						
						end
					
					end]]
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.SecUnits)) <= 2 then
				
					luaObj_Completed("secondary", 2, true)
				
				end
			
			end
			
		elseif Mission.MissionPhase == 5 then
			
			if luaObj_IsActive("primary", 5) then
			
				if Mission.HQ.Party == PARTY_NEUTRAL or Mission.HQ.Party == PARTY_JAPANESE then
				
					luaMissionFailed(Mission.HQ)
					
				else
				
					if table.getn(luaRemoveDeadsFromTable(Mission.IJNFleet)) == 0 and not Mission.BoutToComplete then
					
						SetInvincible(Mission.HQ, 0.01)
						
						HideUnitHP()
						
						luaObj_Completed("primary", 5)
						
						luaMissionComplete()
						
						Mission.BoutToComplete = true
						
					end
				
				end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.YatSen.Dead then
				
					luaObj_Failed("secondary", 1)
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 5 ----

function luaMoveToPh5()

	Mission.MissionPhase = 5
	Mission.IntroRunning = true
	
	if IsListenerActive("recon", "SecListener") then
	
		RemoveListener("recon", "SecListener")
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.SecUnits)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SecUnits)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	if Mission.EscapingZero and not Mission.EscapingZero.Dead then
	
		Kill(Mission.EscapingZero, true)
	
	end
	
	if Mission.ChasingTiger and not Mission.ChasingTiger.Dead then
	
		Kill(Mission.ChasingTiger, true)
	
	end
	
	Mission.HQ = FindEntity("CB")
	
	Mission.YatSen = GenerateObject("Yat Sen")
	
	Mission.ROCFleet = {}
		table.insert(Mission.ROCFleet, Mission.YatSen)
		table.insert(Mission.ROCFleet, GenerateObject("Chao Ho"))
		table.insert(Mission.ROCFleet, GenerateObject("Zhongshan"))
	
	for idx,unit in pairs(Mission.ROCFleet) do
		
		JoinFormation(unit, Mission.ROCFleet[1])
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
	
	Mission.IJNFleet = {}
		table.insert(Mission.IJNFleet, GenerateObject("Ishizuchi"))
		table.insert(Mission.IJNFleet, GenerateObject("Yura"))
		table.insert(Mission.IJNFleet, GenerateObject("Murasame"))
		table.insert(Mission.IJNFleet, GenerateObject("Asagumo"))
		table.insert(Mission.IJNFleet, GenerateObject("Akitsuhima Maru"))
		table.insert(Mission.IJNFleet, GenerateObject("Akebono Maru"))
	
	for idx,unit in pairs(Mission.IJNFleet) do
		
		JoinFormation(unit, Mission.IJNFleet[1])
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
	
	Mission.IJNTransports = {}
		table.insert(Mission.IJNTransports, FindEntity("Akitsuhima Maru"))
		table.insert(Mission.IJNTransports, FindEntity("Akebono Maru"))
	
	NavigatorAttackMove(Mission.IJNFleet[1], Mission.HQ)
	
	luaDelay(luaPh5Text1, 2)
	luaDelay(luaPh5Text2, 6)
	
	Mission.CalmMusic = false
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	local trg1 = Mission.IJNFleet[1]
	Mission.FinalMovieTrg = Mission.ROCFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 8, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieTrg, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.FinalMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	  
	}, luaPh5MovieEnd, true)
	
end

function luaPh5Text1()

	if Mission.IntroRunning then
		
		MissionNarrative("So that's what they were trying to hide...")
	
	end
	
end

function luaPh5Text2()
	
	if Mission.IntroRunning then
	
		MissionNarrative("They're planning a naval invasion!")
	
	end
	
end

function luaPh5MovieEnd()
	
	SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_ANY)
	AddAirBaseStock(FindEntity("Airfield2"), 354, 9)
	
	Mission.IntroRunning = false
	
	SetSelectedUnit(Mission.FinalMovieTrg)
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 5, Mission.IJNFleet)
	luaObj_Add("secondary", 1, Mission.YatSen)
	
	DisplayUnitHP(Mission.IJNFleet, "Destroy the Invasion Fleet!")
	
	luaDelay(luaTransportsAttack, 160)
	
end

function luaTransportsAttack()

	if table.getn(luaRemoveDeadsFromTable(Mission.IJNTransports)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNTransports)) do
		
			if unit and not unit.Dead then
			
				NavigatorAttackMove(unit, Mission.HQ)
			
			end
			
		end
		
	end

end

---- PHASE 4 ----

function luaPh4FadeOut()

	Blackout(true, "luaMoveToPh5", 1)

end

function luaCanWarnAgain()

	Mission.CanWarn = true

end

function luaMoveToPh4()

	Mission.MissionPhase = 4
	Mission.IntroRunning = true
	
	if table.getn(luaRemoveDeadsFromTable(Mission.VilladgeFightas)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.VilladgeFightas)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Villadge)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Villadge)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	--[[if Mission.Airfield and not Mission.Airfield.Dead then
	
		Kill(Mission.Airfield, true)
	
	end
	
	if Mission.SBs[1] and not Mission.SBs[1].Dead then
	
		Kill(Mission.SBs[1], true)
	
	end
	
	if Mission.SBs[2] and not Mission.SBs[2].Dead then
	
		Kill(Mission.SBs[2], true)
	
	end]]
	
	luaRemoveAllFromStocks(Mission.Airfield, 354)
	luaRemoveAllFromStocks(Mission.Airfield, 353)
	
	local usPlanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 900000, PARTY_ALLIED, "own")
	
	if usPlanes and table.getn(luaRemoveDeadsFromTable(usPlanes)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(usPlanes)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	for idx,unit in pairs(Mission.SBs) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
	end
	
	Mission.EscapePath = luaPickRnd(Mission.EscapePaths)
	Mission.EscapePathPoints = FillPathPoints(Mission.EscapePath)
	
	local firstPos = Mission.EscapePathPoints[1]
	
	Mission.EscapingZero = GenerateObject("EscapingZero")
	
	SetInvincible(Mission.EscapingZero, 0.4)
	
	PutTo(Mission.EscapingZero, firstPos)
	
	PilotMoveOnPath(Mission.EscapingZero, Mission.EscapePath)
	
	Mission.SecUnits = {}
		table.insert(Mission.SecUnits, GenerateObject("Tabby1"))
		table.insert(Mission.SecUnits, GenerateObject("Tabby2"))
		table.insert(Mission.SecUnits, GenerateObject("Kitakami Maru"))
		table.insert(Mission.SecUnits, GenerateObject("Nisshin Maru"))
	
	for idx,unit in pairs(Mission.SecUnits) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.Tabbys = {}
		table.insert(Mission.Tabbys, FindEntity("Tabby1"))
		table.insert(Mission.Tabbys, FindEntity("Tabby2"))
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Kitakami Maru"))
		table.insert(Mission.Cargos, FindEntity("Nisshin Maru"))
	
	for idx,unit in pairs(Mission.Cargos) do
		
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
		DisablePhysics(unit)
		
	end
	
	SquadronSetTravelAlt(Mission.Tabbys[1], 1900, true)
	SquadronSetTravelAlt(Mission.Tabbys[2], 1900, true)
	
	PilotMoveTo(Mission.Tabbys[1], Mission.VilladgeBombaPathPoints[5])
	PilotMoveTo(Mission.Tabbys[2], Mission.VilladgeBombaPathPoints[6])
	
	local spawnpos = firstPos
	spawnpos.z = spawnpos.z + 800
	
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 354,
				["Name"] = "Tiger",
				["Crew"] = Mission.JapAI,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaTigerSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})
	
	luaDelay(luaPh4Text, 2)
	
	local trg1 = Mission.EscapingZero
	local trg2 = Mission.ChasingTiger
	
	luaIngameMovie(
	{
	    
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 3, ["rho"] = -20, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 3, ["rho"] = -20, ["moveTime"] = 8, ["smoothtime"] = 2},
	   
	   --{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 50, ["theta"] = 6, ["rho"] = 180, ["moveTime"] = 4},	
	   --{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 20, ["theta"] = 1, ["rho"] = 180, ["moveTime"] = 3},	
		
	}, luaPh4MovieEnd, true)
	
end

function luaPh4Text()
	
	if Mission.IntroRunning then
	
		MissionNarrative("What cowards... The Japanese are running!")
	
	end
	
end

function luaPh4MovieEnd()
	
	Mission.IntroRunning = false
	
	SetSelectedUnit(Mission.ChasingTiger)
	
	luaAddFourthObjs()
	
end

function luaAddFourthObjs()

	luaObj_Add("primary", 4, Mission.EscapingZero)
	
	DisplayUnitHP({Mission.EscapingZero}, "Chase down the Zeroes!")
	
	luaAddSecListener()
	
end

function luaTigerSpawned(unit)
	
	Mission.ChasingTiger = unit
	
	EntityTurnToEntity(Mission.ChasingTiger, Mission.EscapingZero)
	
	PilotSetTarget(Mission.ChasingTiger, Mission.EscapingZero)

end

---- PHASE 3 ----

function luaPh3Debug()

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) do
	
		if unit and not unit.Dead then
		
			Kill(unit, true)
		
		end
	
	end

end

function luaPh3FailMovie()
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) do
		
		if unit and not unit.Dead then
		
			SetInvincible(unit, 0.01)
		
		end
		
	end
	
	local trg1 = FindEntity("VillageCB")
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 1, ["rho"] = 150, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 1, ["rho"] = 150, ["moveTime"] = 8},
		
	}, luaPh3FailMovieEnd, true)
	
end

function luaPh3FailMovieEnd()

	luaMissionFailed(nil)

end

function luaPh3Blackout()

	Blackout(true, "luaMoveToPh4", 3)

end

function luaVilladgeFightaFlow()

	if Mission.MissionPhase == 3 and not Mission.EndMission and not Mission.Ph3Over then
		
		local fighterIdx = luaRnd(1,3)
		
		local fighta = GenerateObject("Fighta"..fighterIdx)
		
		local bomba = luaPickRnd(luaRemoveDeadsFromTable(Mission.VilladgeBombas))
		local bombaPos = GetPosition(bomba)
		
		bombaPos.x = bombaPos.x + 200
		bombaPos.y = 1600
		bombaPos.z = bombaPos.z - 600
		
		PutTo(fighta, bombaPos)
		
		SetSkillLevel(fighta, Mission.SkillLevel)
		
		EntityTurnToEntity(fighta, bomba)
		PilotMoveToRange(fighta, bomba)
		
		table.insert(Mission.VilladgeFightas, fighta)
		
		luaDelay(luaVilladgeFightaFlow, (Mission.StrikeDelay + 20))
	
	end

end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	Mission.IntroRunning = true
	
	local bombaPos = Mission.VilladgeBombaPathPoints[1]
	local offset = 0
	
	for i = 1, (Mission.Difficulty + 2) do
	
		local bomba = GenerateObject("ReverBomba1")
		
		bombaPos.x = bombaPos.x + offset
		bombaPos.y = bombaPos.y - (offset / 2)
		bombaPos.z = bombaPos.z + offset
		
		PutTo(bomba, bombaPos)
		
		SquadronSetTravelAlt(bomba, bombaPos.y, true)
		SquadronSetAttackAlt(bomba, bombaPos.y, true)	
		
		SetSkillLevel(bomba, Mission.SkillLevel)
		
		EntityTurnToEntity(bomba, FindEntity("VillageCB"))
		PilotMoveOnPath(bomba, Mission.VilladgeBombaPath)
		
		offset = offset - 100
		
		SetForcedReconLevel(bomba, 2, PARTY_ALLIED)
		
		table.insert(Mission.VilladgeBombas, bomba)
		
	end
	
	luaDelay(luaPh3Text1, 3)
	luaDelay(luaPh3Text2, 10)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.VilladgeBombas[1]
	local trg2 = FindEntity("VillageCB")
	
	luaIngameMovie(
	{
	    
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 10, ["rho"] = 170, ["moveTime"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 10, ["rho"] = 170, ["moveTime"] = 8, ["smoothtime"] = 2},
	   
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 100, ["theta"] = 1, ["rho"] = 170, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 100, ["theta"] = 2, ["rho"] = 150, ["moveTime"] = 8},
		
	}, luaPh3MovieEnd, true)

end

function luaPh3Text1()
	
	if Mission.IntroRunning then
	
		MissionNarrative("The Japanese are looking for revenge after their failed attack...")
	
	end
	
end

function luaPh3Text2()
	
	if Mission.IntroRunning then
	
		MissionNarrative("They're attacking a civillian village!")
	
	end
	
end

function luaPh3MovieEnd()
	
	Mission.IntroRunning = false
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
		
		--[[if Mission.Airfield and not Mission.Airfield.Dead then
		
			local planes = luaGetPlanesAround(Mission.Airfield, 900000, "own")
		
			if planes and table.getn(luaRemoveDeadsFromTable(planes)) > 0 then
			
				SetSelectedUnit(luaPickRnd(planes))
			
			else
			
				local slotIndex = LaunchSquadron(Mission.Airfield, 354, 5, 0)
				local plane = thisTable[tostring(GetProperty(Mission.Airfield, "slots")[slotIndex].squadron)]
				
				SetSelectedUnit(plane)
				
			end
			
		end]]
		
		SetSelectedUnit(luaPickRnd(Mission.SBs))
		
	end
	
	luaAddThirdObjs()
	
end

function luaAddThirdObjs()

	luaObj_Add("primary", 3, Mission.VilladgePos)
	
	if table.getn(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.VilladgeBombas)) do
		
			if unit and not unit.Dead then
			
				luaObj_AddUnit("primary", 3, unit)
			
			end
			
		end
		
	end
	
	DisplayUnitHP(Mission.VilladgeBombas, "Shoot down the bombers headed for the village!")
	
	luaDelay(luaVilladgeFightaFlow, Mission.StrikeDelay)
	
	if Mission.Debug then
	
		luaDelay(luaPh3Debug, 50)
	
	end
	
end

---- PHASE 2 ----

function luaMoveToPh2()

	Mission.MissionPhase = 2
	Mission.StrikeWaves = 0
	
	local fuckingPieceOfFuckingShit = luaSpawnAttackerWave()
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaPh2Text, 2)
	
	local trg1 = fuckingPieceOfFuckingShit
	local trg2 = Mission.SBs[1]
	
	luaIngameMovie(
	{
	    
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 15, ["theta"] = -25, ["rho"] = 200, ["moveTime"] = 0, ["transformtype"] = "keepnone"},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 17, ["theta"] = -20, ["rho"] = 280, ["moveTime"] = 7, ["nonlinearblend"] = 0.1},
		
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 8, ["rho"] = -170, ["moveTime"] = 0},
	   {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 8, ["rho"] = -280, ["moveTime"] = 6},
		
	}, luaPh2MovieEnd, true)

end

function luaPh2Text()

	MissionNarrative("Eenemy level bombers! They're targeting the supply bases!")

end

function luaPh2MovieEnd()
	
	for idx,unit in pairs(Mission.SBs) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		
	end
	
	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
		
		--[[if Mission.Airfield and not Mission.Airfield.Dead then
		
			local planes = luaGetPlanesAround(Mission.Airfield, 900000, "own")
		
			if planes and table.getn(luaRemoveDeadsFromTable(planes)) > 0 then
			
				SetSelectedUnit(luaPickRnd(planes))
			
			else
			
				local slotIndex = LaunchSquadron(Mission.Airfield, 354, 5, 0)
				local plane = thisTable[tostring(GetProperty(Mission.Airfield, "slots")[slotIndex].squadron)]
				
				SetSelectedUnit(plane)
				
			end
			
		end]]
		
		SetSelectedUnit(luaPickRnd(Mission.SBs))
		
	end
	
	luaDelay(luaAddSecObjs, 3)
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.SBs)
	
	DisplayUnitHP(Mission.SBs, "Protect your supply bases!")

end

---- PHASE 1 ----

function luaSpawnAttackerWave()
	
	if Mission.MissionPhase <= 2 then
	
		if Mission.StrikeWaves < 3 then
		
			local prenTbl = {}
			local bombaTbl = {}
			local fighterIdx = luaRnd(1,3)
			local trgs
			
			if Mission.MissionPhase == 1 then
				
				for i = 1, 4 do
					
					local bomba = GenerateObject("Val"..i)
					
					table.insert(prenTbl, bomba)
					table.insert(bombaTbl, bomba)
				
				end
				
				trgs = {Mission.Airfield}
				
			elseif Mission.MissionPhase == 2 then
			
				for i = 1, 2 do
					
					local bomba = GenerateObject("ReverBomba"..i)
					
					table.insert(prenTbl, bomba)
					table.insert(bombaTbl, bomba)
				
				end
				
				trgs = Mission.SBs
				
			end
			
			local fighta = GenerateObject("Fighta"..fighterIdx)
			
			table.insert(prenTbl, fighta)
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(prenTbl)) do
			
				if unit and not unit.Dead then
				
					SetSkillLevel(unit, Mission.SkillLevel)
					
				end
			
			end
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(bombaTbl)) do
			
				if unit and not unit.Dead then
					
					local trg = luaPickRnd(trgs)
					
					EntityTurnToEntity(unit, trg)
					PilotSetTarget(unit, trg)
					
					table.insert(Mission.StrikePren, unit)
					
				end
			
			end
			
			PilotMoveToRange(fighta, Mission.Airfield)
			
			Mission.StrikeWaves = Mission.StrikeWaves + 1
			
			if Mission.StrikeWaves < 3 then
			
				luaDelay(luaSpawnAttackerWave, Mission.StrikeDelay)
			
			end
			
			if Mission.MissionPhase == 2 and not Mission.MovieBombaDeclared then
				
				Mission.MovieBombaDeclared = true
				
				return prenTbl[1]
				
			end
			
		end
	
	end
	
end

function luaIntroMovie1()
	
	Blackout(false, "", 1)
	
	luaDelay(luaIntroText1, 5)
	luaDelay(luaIntroText2, 10)
	luaDelay(luaIntroText3, 18)
	luaDelay(luaKillIntroPlanes, 22)
	luaLaunchFirstPren()
	
	local trg1 = Mission.Airfield
	
	luaIngameMovie(
	{
	    
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-5400,["y"]=800,["z"]=5600},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-5400,["y"]=1300,["z"]=5600},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-5400,["y"]=1300,["z"]=5600},["parent"] = nil,},["moveTime"] = 14,["transformtype"] = "keepall"},
		
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 3,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 4,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroPlane, ["distance"] = 30, ["theta"] = 6, ["rho"] = 40, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroPlane, ["distance"] = 40, ["theta"] = 6, ["rho"] = 30, ["moveTime"] = 6},	
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroPlane, ["distance"] = 50, ["theta"] = 6, ["rho"] = 180, ["moveTime"] = 3},	
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroPlane, ["distance"] = 20, ["theta"] = 1, ["rho"] = 180, ["moveTime"] = 3},	
		
	}, luaIn)
	
	--luaIntroMovieEnd()
	
end

function luaIntroText1()
	
	if Mission.MissionPhase == 0 then
	
		MissionNarrative("July 1941 - China")
	
	end
	
end

function luaIntroText2()
	
	if Mission.MissionPhase == 0 then
	
		MissionNarrative("The Chinese mainlaind is under a barbaric Japanese onslaught.")
	
	end
	
end

function luaIntroText3()
	
	if Mission.MissionPhase == 0 then
	
		MissionNarrative("The Flying Tigers have been assigned to protect China from the vicious attack.")
	
	end
	
end

function luaLaunchFirstPren()

	local slotIndex = LaunchSquadron(Mission.Airfield, 354, 5, 0)
	LaunchSquadron(Mission.Airfield, 353, 5, 0)
	Mission.IntroPlane = thisTable[tostring(GetProperty(Mission.Airfield, "slots")[slotIndex].squadron)]
	SetInvincible(Mission.IntroPlane, true)

end

function luaKillIntroPlanes()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.MovieBombas)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MovieBombas)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
end

function luaIn()
	
	Mission.MissionPhase = 1
	
	luaKillIntroPlanes()
	
	SetInvincible(Mission.IntroPlane, false)
	
	SetSelectedUnit(Mission.IntroPlane)
	
	Blackout(false, "", 3)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Airfield)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP({Mission.Airfield}, "Protect your airfield!")
	
	luaSpawnAttackerWave()
	
end

---- LISTENERS ----

function luaAddSecListener()

	AddListener("recon", "SecListener", {
		["callback"] = "luaSecSighted",
		["entity"] = Mission.SecUnits,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

---- LISTENER CALLBACKS ----

function luaSecSighted(unit)

	RemoveListener("recon", "SecListener")
	
	luaObj_Add("secondary", 2, Mission.SecUnits)

end

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
	
	luaMissionCompletedNew(Mission.HQ, "The Tigers have prevailed - Mission Complete")

end

function luaMissionFailed(unit)
	
	Mission.EndMission = true
	
	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	local focus
	
	if unit then
	
		focus = unit
		
	else
	
		focus = nil
	
	end
	
	luaMissionFailedNew(focus, "Game Over")
	
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
	
	--[[if Mission.EndMission then
	
		return
	
	end]]
	
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