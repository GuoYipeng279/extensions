---- INVADING TARAWA (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- INVADING TARAWA (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(321) 	-- P47
	PrepareClass(26) 	-- F6F
	PrepareClass(38) 	-- SB2C
	--PrepareClass(113) 	-- TBF
	PrepareClass(331) 	-- BTD
	PrepareClass(116) 	-- B17
	
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
	
	LoadMessageMap("ijndlg",13)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_22_new_zealand.lua"

	this.Name = "IJN22"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "PT",
				["Text"] = "Destroy all enemy PT boats!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Protect your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "HQ",
				["Text"] = "Capture the Tarawa HQ!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[[[4] = {
				["ID"] = "CV",
				["Text"] = "Attack the enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Hizen",
				["Text"] = "Ensure the survival of the battleship Hizen!",
				["TextFailed"] = "The Hizen is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Esc",
				["Text"] = "Sink both enemy escort carriers!",
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
					["message"] = "ELCO1",
				},
				{
					["type"] = "pause",
					["time"] = 8,
				},
				{
					["message"] = "DESPERATE1",
				},
				{
					["message"] = "SPOTTED3",
				},
			},
		},
		["DESTROYED"] = {--
			["sequence"] = {
				{
					["message"] = "DESTROYED1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh1FadeOut",
				},
			},
		},
		["MUSASHI1"] = {--
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
			},
		},
		["MUSASHI2"] = {--
			["sequence"] = {
				{
					["message"] = "MUSASHI1",
				},
				{
					["message"] = "dlg4a",
				},
			},
		},
		["ENTERPRISE"] = {--
			["sequence"] = {
				{
					["message"] = "ENTERPRISE1",
				},
				{
					["message"] = "ENTERPRISE2",
				},
			},
		},
		["CARRIERS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
			},
		},
		["FINAL1"] = {--
			["sequence"] = {
				{
					["message"] = "BASES1",
				},
				{
					["message"] = "BASES2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["FINAL2"] = {--
			["sequence"] = {
				{
					["message"] = "FLEEING1",
				},
				{
					["message"] = "FLEEING2",
				},
				{
					["message"] = "FLEEING3",
				},
				{
					["message"] = "FLEEING4",
				},
				{
					["message"] = "BASES1",
				},
				{
					["message"] = "BASES2",
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
	
	Mission.Musashi = FindEntity("Musashi")
	Mission.Hizen = FindEntity("Hizen")
	
	Mission.JapCVFleet = {}
		table.insert(Mission.JapCVFleet, FindEntity("Zuikaku"))
		--table.insert(Mission.JapCVFleet, FindEntity("Shokaku"))
		table.insert(Mission.JapCVFleet, FindEntity("Mikuma"))
		table.insert(Mission.JapCVFleet, FindEntity("Hayaharu"))
		--table.insert(Mission.JapCVFleet, FindEntity("Hatsuaki"))
		--table.insert(Mission.JapCVFleet, FindEntity("Hatsunatsu"))
	
	if Mission.Difficulty < 2 then
	
		table.insert(Mission.JapCVFleet, GenerateObject("Akagi"))
	
	end
	
	for idx,unit in pairs(Mission.JapCVFleet) do
		
		JoinFormation(unit, Mission.JapCVFleet[1])
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
	
	Mission.JapTroopFleet = {}
		table.insert(Mission.JapTroopFleet, FindEntity("Mikawa Maru"))
		table.insert(Mission.JapTroopFleet, FindEntity("Nagoya Maru"))
		table.insert(Mission.JapTroopFleet, FindEntity("SB-01"))
		table.insert(Mission.JapTroopFleet, FindEntity("SB-02"))
		table.insert(Mission.JapTroopFleet, FindEntity("Kuma"))
		table.insert(Mission.JapTroopFleet, FindEntity("Kiso"))
		table.insert(Mission.JapTroopFleet, FindEntity("Hakaze"))
		table.insert(Mission.JapTroopFleet, FindEntity("Shiokaze"))
		--table.insert(Mission.JapTroopFleet, FindEntity("Sawakaze"))
		--table.insert(Mission.JapTroopFleet, FindEntity("Okikaze"))
	
	for idx,unit in pairs(Mission.JapTroopFleet) do
		
		JoinFormation(unit, Mission.JapTroopFleet[1])
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
	
	Mission.JapTroops = {}
		table.insert(Mission.JapTroops, FindEntity("Mikawa Maru"))
		table.insert(Mission.JapTroops, FindEntity("Nagoya Maru"))
		table.insert(Mission.JapTroops, FindEntity("SB-01"))
		table.insert(Mission.JapTroops, FindEntity("SB-02"))
	
	Mission.IJNUnits = luaSumTablesIndex(Mission.JapCVFleet, Mission.JapTroopFleet)
	
	Mission.JapAIShips = {}
		table.insert(Mission.JapAIShips, FindEntity("Musashi"))
		table.insert(Mission.JapAIShips, FindEntity("Hizen"))
	
	Mission.JapKeyTrgs = {}
		table.insert(Mission.JapKeyTrgs, FindEntity("Mikawa Maru"))
		table.insert(Mission.JapKeyTrgs, FindEntity("Nagoya Maru"))
		table.insert(Mission.JapKeyTrgs, FindEntity("SB-01"))
		table.insert(Mission.JapKeyTrgs, FindEntity("SB-02"))
		table.insert(Mission.JapKeyTrgs, FindEntity("Hizen"))
	
	for idx,unit in pairs(Mission.JapAIShips) do
		
		AAEnable(unit, false)
		SetInvincible(unit, 0.7)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
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
	
	---- USN ----
	
	Mission.HQ = FindEntity("HQ")
	
	SetSkillLevel(Mission.HQ, Mission.SkillLevel)
	RepairEnable(Mission.HQ, true)
	SetForcedReconLevel(Mission.HQ, 2, PARTY_JAPANESE)
	
	Mission.Airfield = FindEntity("AirField")
	
	SetSkillLevel(Mission.Airfield, Mission.SkillLevel)
	RepairEnable(Mission.Airfield, true)
	
	if Mission.Difficulty == 0 then
	
		SetAirBaseSlotCount(Mission.Airfield, 3)
		
	elseif Mission.Difficulty == 1 then
		
		SetAirBaseSlotCount(Mission.Airfield, 5)
		
	elseif Mission.Difficulty == 2 then
		
		SetAirBaseSlotCount(Mission.Airfield, 7)
		
	end
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA") or string.find(unit.Name, "Coastal Gun") or string.find(unit.Name, "Bunker")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.PTs = {}
	Mission.TinyTims = {}
	Mission.CVs = {}
	Mission.USCap = {}
	
	---- VAR ----
	
	--[[Mission.ArtilleryTargets = {}
		table.insert(Mission.ArtilleryTargets, FindEntity("NavArtillery1"))
		table.insert(Mission.ArtilleryTargets, FindEntity("NavArtillery2"))
		table.insert(Mission.ArtilleryTargets, FindEntity("NavArtillery3"))
		table.insert(Mission.ArtilleryTargets, FindEntity("NavArtillery4"))
		table.insert(Mission.ArtilleryTargets, FindEntity("NavArtillery5"))]]
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.WavesSpawned = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.USFighterDelay = 140
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.USFighterDelay = 100
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.USFighterDelay = 60
		
	end
	
	---- INIT FUNCT. ----
	
	--[[for idx,unit in pairs(Mission.JapAIShips) do
		
		local actTarget = luaPickRnd(Mission.ArtilleryTargets)
		
		SetFireTarget(unit, actTarget)
		
	end]]
	
	EnableMessages(false)
	
	MissionNarrative("March 4th, 1943 - Betio Island")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
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
		
		for idx,unit in pairs(Mission.JapTroops) do
		
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
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTroops)) == 0 then
				
					luaMissionFailed()
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.Hizen.Dead then
				
					luaObj_Failed("secondary", 1, true)
					
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CVEs)) == 0 then
				
					luaObj_Completed("hidden", 1)
					
				end
			
			end
			
			if Mission.Airfield and not Mission.Airfield.Dead and Mission.Airfield.Party == PARTY_ALLIED then
			
				local fighters = {
					[1] = 321,
				}
				local bombers = {
					[1] = 38,
					--[2] = 113,
				}
				
				if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
				
					bombers[2] = 116
				
				end
				
				local trgs = luaGetUSPlaneTrg()
				
				luaAirfieldManager(Mission.Airfield, fighters, bombers, luaRemoveDeadsFromTable(trgs))
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				if Mission.WavesSpawned == 2 then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.PTs)) == 0 then
					
						luaObj_Completed("primary", 1)
						
						luaStartDialog("DESTROYED")
					
					end
					
				end
			
			end
		
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary", 3) then
			
				if Mission.HQ.Party == PARTY_JAPANESE then
				
					SetInvincible(Mission.HQ, 0.3)
					
					HideUnitHP()
					luaDelay(luaHidePh2Scores, 1)
					
					luaObj_Completed("primary", 2)
					luaObj_Completed("primary", 3)
					
					if Mission.Enterprise and not Mission.Enterprise.Dead then
					
						luaStartDialog("FINAL2")
					
					else
					
						luaStartDialog("FINAL1")
					
					end
					
					Mission.EndMission = true
					
				else
				
					local cap = GetCapturePercentage(Mission.HQ)
					
					Mission.Cap = string.format("%.0f",(cap * 100))
					
					local line1 = "Capture the Tarawa HQ!"
					local line2 = "Capture progress: #Mission.Cap#%"
					luaDisplayScore(1, line1, line2)
					
					if Mission.CVs and table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
							
							if unit and not unit.Dead then
								
								local fighters = {
									[1] = 26,
								}
								local bombers = {
									[1] = 38,
									[2] = 331,
								}
								
								local trgs
								
								if Mission.Difficulty == 0 then
									
									trgs = Mission.IJNUnits
									
								elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
									
									trgs = Mission.JapKeyTrgs
									
								end
								
								local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
								local newTrgs = {ordered[1]}
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(newTrgs))
								
							end
						
						end
						
						if Mission.Enterprise and not Mission.Enterprise.Dead then
							
							if not Mission.EnterpriseSetToKill then
							
								local untPos = GetPosition(Mission.Enterprise)
						
								if IsInBorderZone(untPos) then
									
									luaDelay(luaKillEnterprise, 180)
									
									Mission.EnterpriseSetToKill = true
									
								end
							
							end
							
						end
						
					end
					
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

function luaKillEnterprise()

	if table.getn(luaRemoveDeadsFromTable(Mission.EnterpriseFleet)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EnterpriseFleet)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	Mission.CanMusicCheck = true
	
end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.HQ
	
	luaIngameMovie(
	{
		
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 260, ["theta"] = 15, ["rho"] = 40, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
       {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 120, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 7, ["smoothtime"] = 0, ["nonlinearblend"] = 0.0},
		
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNUnits)))
	
	end
	
	luaAddSecObjs()
	--luaDelay(luaAddSecObjs, 3)
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 3, Mission.HQ)
	
	luaDelay(luaSpawnCVAirstrike, 100)
	
end

function luaSpawnCVAirstrike()
	
	local tbl = {}
	
	table.insert(tbl, GenerateObject("TBM-01"))
	table.insert(tbl, GenerateObject("TBM-02"))
	table.insert(tbl, GenerateObject("TBM-03"))
	table.insert(tbl, GenerateObject("TBM-04"))
	
	local trg = FindEntity("Musashi")
	
	for idx,unit in pairs(tbl) do
		
		SetInvincible(unit, 0.5)
		
		PilotSetTarget(unit, trg)
		
		table.insert(Mission.TinyTims, unit)
		
	end
	
	if not Mission.StrikeMovieSet then
	
		luaDelay(luaStrikeMovieBlackout, 20)
		
		Mission.StrikeMovieSet = true
	
	end
	
end

function luaStrikeMovieBlackout()
	
	Blackout(true, "luaStrikeMovie", 1)

end

function luaStrikeMovie()
	
	Mission.CanMusicCheck = false
	
	EnableMessages(false)
	
	UnitSetFireStance(Mission.Musashi, 0)
	
	for idx,unit in pairs(Mission.JapAIShips) do
		
		AAEnable(unit, true)
		SetInvincible(unit, false)
		
	end
	
	Mission.EnterpriseFleet = {}
		table.insert(Mission.EnterpriseFleet, GenerateObject("Enterprise"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("Maine"))
		table.insert(Mission.EnterpriseFleet, GenerateObject("Louisiana"))
	
	for idx,unit in pairs(Mission.EnterpriseFleet) do
		
		JoinFormation(unit, Mission.EnterpriseFleet[1])
		SetSkillLevel(unit, SKILL_ELITE)
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
			
			table.insert(Mission.CVs, unit)
			
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorMoveToRange(Mission.EnterpriseFleet[1], FindEntity("CVGoTo1"))
	
	Mission.CVEFleet = {}
		table.insert(Mission.CVEFleet, GenerateObject("Cowpens"))
		table.insert(Mission.CVEFleet, GenerateObject("Cabot"))
		table.insert(Mission.CVEFleet, GenerateObject("Minneapolis"))
		--table.insert(Mission.CVEFleet, GenerateObject("Pensacola"))
		table.insert(Mission.CVEFleet, GenerateObject("Mannert L. Abele"))
		--table.insert(Mission.CVEFleet, GenerateObject("Drexler"))
		table.insert(Mission.CVEFleet, GenerateObject("Harry E. Hubbard"))
		--table.insert(Mission.CVEFleet, GenerateObject("Henley"))
	
	for idx,unit in pairs(Mission.CVEFleet) do
		
		JoinFormation(unit, Mission.CVEFleet[1])
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
			
			table.insert(Mission.CVs, unit)
			
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.CVEs = {}
		table.insert(Mission.CVEs, FindEntity("Cowpens"))
		table.insert(Mission.CVEs, FindEntity("Cabot"))
	
	NavigatorMoveToRange(Mission.CVEFleet[1], FindEntity("CVGoTo2"))
	
	Mission.Enterprise = FindEntity("Enterprise")
	
	Mission.SelUnit = GetSelectedUnit()
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaAddMusashiHitListener()
	
	Blackout(false, "", 1)
	
	luaDelay(luaStrikeDia, 2)
	
	local trg1 = Mission.TinyTims[1]
	local trg2 = FindEntity("Musashi")
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 35, ["theta"] = 6, ["rho"] = -78, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 35, ["theta"] = 6, ["rho"] = -78, ["moveTime"] = 8},
	  
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 12, ["rho"] = 180, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 12, ["rho"] = 180, ["moveTime"] = 16},
	  
	}, luaCVMovieFade, true)

end

function luaCVMovieFade()

	Blackout(true, "luaCVMovie", 2)

end

function luaCVMovie()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.TinyTims)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.TinyTims)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	luaEnterpriseTheme()
	
	luaDelay(luaEnterpriseDia, 2)
	luaDelay(luaCarriersDia, 10)
	
	Blackout(false, "", 5)
	
	local trg1 = Mission.EnterpriseFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 14, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	}, luaCVMovieEnd, true)
	
end

function luaStrikeDia()

	luaStartDialog("MUSASHI1")

end

function luaEnterpriseDia()

	luaStartDialog("ENTERPRISE")

end

function luaCarriersDia()

	luaStartDialog("CARRIERS")

end

function luaEnterpriseTheme()

	Music_Control_SetLevel(MUSIC_CUSTOM3)
	luaCheckMusicSetMinLevel(MUSIC_CUSTOM3)

end

function luaCVMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNUnits)))
	
	end
	
	EnableMessages(true)
	
	SetRoleAvailable(FindEntity("Hizen"), EROLF_ALL, PLAYER_ANY)
	
	luaAddCVObjs()

end

function luaAddCVObjs()
	
	luaObj_Add("secondary", 1, FindEntity("Hizen"))
	luaObj_Add("hidden", 1)
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaDelay(luaSpawnFighter, Mission.USFighterDelay)
	
end

function luaHidePh2Scores()

	HideScoreDisplay(1,0)

end

function luaSpawnFighter()

	if Mission.CVs and table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.USCap)) < 2 then
		
			local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVs))
			
			if cv and not cv.Dead then
			
				if IsReadyToSendPlanes(cv) then
					
					local planeTypes = 
					{
					26,
					26,
					}
					
					local slotIndex = LaunchSquadron(cv,luaPickRnd(planeTypes),3)
					local launchedCAP = thisTable[tostring(GetProperty(cv, "slots")[slotIndex].squadron)]
					
					SetSkillLevel(launchedCAP, Mission.SkillLevel)
					PilotMoveToRange(launchedCAP, Mission.HQ)
					UnitFreeAttack(launchedCAP)
					table.insert(Mission.USCap, launchedCAP)
					
				end
			
			end
			
			luaDelay(luaSpawnFighter, Mission.USFighterDelay)
		
		end
		
	end
	
end

---- PHASE 1 ----

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaSpawnNextPTWave()

	local leftWave = {}
	
	table.insert(leftWave, GenerateObject("Elco-01"))
	table.insert(leftWave, GenerateObject("Elco-02"))
	table.insert(leftWave, GenerateObject("Elco-03"))
	table.insert(leftWave, GenerateObject("Elco-04"))
	--table.insert(leftWave, GenerateObject("Elco-05"))
	--table.insert(leftWave, GenerateObject("Elco-06"))
	--[[table.insert(leftWave, GenerateObject("Elco-07"))
	table.insert(leftWave, GenerateObject("Elco-08"))
	table.insert(leftWave, GenerateObject("Elco-09"))
	table.insert(leftWave, GenerateObject("Elco-10"))
	table.insert(leftWave, GenerateObject("Elco-11"))
	table.insert(leftWave, GenerateObject("Elco-12"))]]
	
	local rightWave = {}
	
	table.insert(rightWave, GenerateObject("Elco-13"))
	table.insert(rightWave, GenerateObject("Elco-14"))
	table.insert(rightWave, GenerateObject("Elco-15"))
	table.insert(rightWave, GenerateObject("Elco-16"))
	--table.insert(rightWave, GenerateObject("Elco-17"))
	--table.insert(rightWave, GenerateObject("Elco-18"))
	--[[table.insert(rightWave, GenerateObject("Elco-19"))
	table.insert(rightWave, GenerateObject("Elco-20"))
	table.insert(rightWave, GenerateObject("Elco-21"))
	table.insert(rightWave, GenerateObject("Elco-22"))
	table.insert(rightWave, GenerateObject("Elco-23"))
	table.insert(rightWave, GenerateObject("Elco-24"))]]
	
	local tables = {leftWave, rightWave}
	
	for idx1,unitTable in pairs(tables) do
		
		for idx2,unit in pairs(luaRemoveDeadsFromTable(unitTable)) do
		
			JoinFormation(unit, unitTable[2])
			SetSkillLevel(unit, Mission.SkillLevel)
			NavigatorSetTorpedoEvasion(unit, true)
			NavigatorSetAvoidLandCollision(unit, true)
			TorpedoEnable(unit, true)
			
			if Mission.Difficulty == 0 then
				
				RepairEnable(unit, false)
			
			elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
				
				RepairEnable(unit, true)
			
			end
			
			table.insert(Mission.PTs, unit)
			
			if luaObj_IsActive("primary", 1) then
			
				luaObj_AddUnit("primary", 1, unit)
			
			end
			
		end
		
	end
	
	Mission.CurrentLeftLeader = leftWave[10]
	Mission.CurrentRightLeader = rightWave[10]
	Mission.CurrentLeftWave = leftWave
	Mission.CurrentRightWave = rightWave
	Mission.CurrentWaves = tables
	
	if not Mission.IntroMovieUnitSet then
		
		Mission.IntroUnit = leftWave[10]
		
		Mission.IntroMovieUnitSet = true
		
	else
	
		luaMakeWaveAttack()
		
	end
	
	Mission.WavesSpawned = Mission.WavesSpawned + 1

	if Mission.WavesSpawned < 2 then
	
		luaDelay(luaSpawnNextPTWave, 100)
	
	else
	
		luaMakeWaveAttack()
	
	end

end

function luaMakeWaveAttack()

	if Mission.Difficulty == 0 then
	
		local leaderTbl = {Mission.CurrentLeftLeader, Mission.CurrentRightLeader}
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(leaderTbl)) do
			
			local trgs = luaGetUSPlaneTrg()
			
			NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			UnitSetFireStance(unit, 2)
			
		end
		
	else
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CurrentLeftWave)) do
			
			local trgs = luaGetUSPlaneTrg()
			
			NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			UnitSetFireStance(unit, 2)
			
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CurrentRightWave)) do
			
			local trgs = luaGetUSPlaneTrg()
			
			NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
			
			UnitSetFireStance(unit, 2)
			
		end
	
	end

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.IJNUnits
		
	elseif Mission.Difficulty == 2 then
		
		trgs = Mission.JapTroops
		
	end
	
	return trgs
	
end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	luaSpawnNextPTWave()
	
	local trg1 = FindEntity("Musashi")
	local trg2 = FindEntity("Hizen")
	local trg3 = FindEntity("Zuikaku")
	
	luaDelay(luaMakeMusashiShoot, 2)
	luaDelay(luaMakeHizenShoot, 12)
	luaDelay(luaIntroDia, 25)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-50,["y"]=7,["z"]=-110},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-20,["y"]=7,["z"]=-75},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-20,["y"]=7,["z"]=-75},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-40,["y"]=9,["z"]=-110},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-10,["y"]=7,["z"]=125},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=7,["z"]=85},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=7,["z"]=85},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-5,["y"]=9,["z"]=125},["parent"] = trg2,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-107,["y"]=4,["z"]=935},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-100,["y"]=4,["z"]=900},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-94,["y"]=5,["z"]=900},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-20,["y"]=5,["z"]=120},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=140},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=140},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-20,["y"]=10,["z"]=0},["parent"] = trg3,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaMakeMusashiShoot()

	UnitSetFireStance(FindEntity("Musashi"), 1)

end

function luaMakeHizenShoot()

	UnitSetFireStance(FindEntity("Hizen"), 1)

end

function luaIntroMovieEnd()
	
	Blackout(true, "luaIn", 3)
	
end

function luaIn()
	
	Mission.MissionPhase = 1
	
	luaMakeWaveAttack()
	
	EnableMessages(true)
	
	Mission.CanMusicCheck = true
	
	SetSelectedUnit(Mission.JapCVFleet[1])
	
	Blackout(false, "", 3)
	
	luaAddFirstObjs()
	
	--luaDelay(luaAddFirstObjs, 3)

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.PTs)
	luaObj_Add("primary", 2, Mission.JapTroops)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTroops), "Protect your transports!")

end

---- LISTENERS ----

function luaAddMusashiHitListener()

	AddListener("hit", "MusashiHitListener", {
		["callback"] = "luaMusashiHit",
		["target"] = {Mission.Musashi},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

---- LISTENER CALLBACKS ----

function luaMusashiHit()

	RemoveListener("hit", "MusashiHitListener")
	
	local pos = {["x"]=0, ["y"] = Mission.Musashi.Class.Height+3, ["z"]=0 }
	Effect("ExplosionMagazine", pos, Mission.Musashi, 20)
	
	SetDamagedGFXLevel(Mission.Musashi, 1)
	SetDeadMeat(Mission.Musashi)
	
	luaStartDialog("MUSASHI2")
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh2Scores, 1)
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(Mission.HQ, "Tarawa has been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh2Scores, 1)
		
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