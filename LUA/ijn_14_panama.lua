---- STRIKE ON THE PANAMA CANAL (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- STRIKE ON THE PANAMA CANAL (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(136) 	-- C47
	--PrepareClass(116) 	-- B17
	PrepareClass(135) 	-- P40
	
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
	
	LoadMessageMap("ijndlg",10)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_14_panama.lua"

	this.Name = "IJN14"
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
				["Text"] = "Find and sink the enemy radar ship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Det",
				["Text"] = "Avoid detection at all cost!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Dest",
				["Text"] = "Sink all docked cargo ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Sink",
				["Text"] = "Sink the enemy battleship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Cargo",
				["Text"] = "Ensure the survival of your midget submarine!",
				["TextFailed"] = "You've lost your midget submarine!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Fact",
				["Text"] = "Destroy all enemy factories!",
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
					["message"] = "dlg1",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 6.5,
				},
				{
					["message"] = "AHEAD1",
				},
				{
					["message"] = "idlg01c",
				},
				--[[{
					["message"] = "CRIPPAL1",
				},]]
			},
		},
		["AK"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
			},
		},
		["KILL"] = {--
			["sequence"] = {
				{
					["message"] = "KILL1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh1Blackout",
				},
			},
		},
		["DC"] = {--
			["sequence"] = {
				{
					["message"] = "DC1",
				},
				{
					["message"] = "DC2",
				},
				{
					["message"] = "DC3",
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
					["callback"] = "luaPh2FadeOut",
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
	
	Mission.JapSubs = {}
		table.insert(Mission.JapSubs, FindEntity("I-400"))
		table.insert(Mission.JapSubs, FindEntity("I-501"))
		table.insert(Mission.JapSubs, FindEntity("I-601"))
	
	for idx,unit in pairs(Mission.JapSubs) do
		
		SetUnlimitedAirSupply(unit, true)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		SetInvincible(unit, 0.4)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	Mission.AttackerPlanes = {}
	
	---- USN ----
	
	Mission.TakeOffField = FindEntity("TakeOff_Airfield")
	Mission.LandingField = FindEntity("Landing_Airfield")
	
	local radarShipPossiblePos = {
	
		[1] = {["x"] = 800, ["y"] = 0, ["z"] = 2600},
		
		[2] = {["x"] = -800, ["y"] = 0, ["z"] = 3040},
		
	}
	
	local posIdx = luaRnd(1,2)
	local pos1
	local pos2
	
	if posIdx == 1 then
	
		pos1 = radarShipPossiblePos[1]
		pos2 = radarShipPossiblePos[2]
	
	else
	
		pos1 = radarShipPossiblePos[2]
		pos2 = radarShipPossiblePos[1]
	
	end
	
	Mission.RadarShipPosIdx = posIdx
	
	PutTo(GenerateObject("Newport News"), pos1)
	PutTo(GenerateObject("Cargo-18"), pos2)
	
	Mission.RadarShip = FindEntity("Newport News")
	
	SetSkillLevel(Mission.RadarShip, Mission.SkillLevel)
	NavigatorSetTorpedoEvasion(Mission.RadarShip, false)
	NavigatorSetAvoidLandCollision(Mission.RadarShip, false)
	RepairEnable(Mission.RadarShip, false)
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Cargo-01"))
		table.insert(Mission.Cargos, FindEntity("Cargo-02"))
		table.insert(Mission.Cargos, FindEntity("Cargo-03"))
		table.insert(Mission.Cargos, FindEntity("Cargo-04"))
		table.insert(Mission.Cargos, FindEntity("Cargo-05"))
		table.insert(Mission.Cargos, FindEntity("Cargo-06"))
		table.insert(Mission.Cargos, FindEntity("Cargo-07"))
		table.insert(Mission.Cargos, FindEntity("Cargo-08"))
		table.insert(Mission.Cargos, FindEntity("Cargo-09"))
		table.insert(Mission.Cargos, FindEntity("Cargo-10"))
		table.insert(Mission.Cargos, FindEntity("Cargo-11"))
		table.insert(Mission.Cargos, FindEntity("Cargo-12"))
		table.insert(Mission.Cargos, FindEntity("Cargo-13"))
		table.insert(Mission.Cargos, FindEntity("Cargo-14"))
		table.insert(Mission.Cargos, FindEntity("Cargo-15"))
		table.insert(Mission.Cargos, FindEntity("Cargo-16"))
		table.insert(Mission.Cargos, FindEntity("Cargo-17"))
		table.insert(Mission.Cargos, FindEntity("Cargo-18"))
		table.insert(Mission.Cargos, FindEntity("Cargo-19"))
		table.insert(Mission.Cargos, FindEntity("Cargo-20"))
		table.insert(Mission.Cargos, FindEntity("Cargo-21"))
		
	for idx,unit in pairs(Mission.Cargos) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.LSTs = {}
		table.insert(Mission.LSTs, FindEntity("LST-01"))
		table.insert(Mission.LSTs, FindEntity("LST-02"))
		table.insert(Mission.LSTs, FindEntity("LST-03"))
		table.insert(Mission.LSTs, FindEntity("LST-04"))
		table.insert(Mission.LSTs, FindEntity("LST-05"))
		table.insert(Mission.LSTs, FindEntity("LST-06"))
		--[[table.insert(Mission.LSTs, FindEntity("LST-07"))
		table.insert(Mission.LSTs, FindEntity("LST-08"))
		table.insert(Mission.LSTs, FindEntity("LST-09"))]]
		table.insert(Mission.LSTs, FindEntity("LST-10"))
		table.insert(Mission.LSTs, FindEntity("LST-11"))
		
	for idx,unit in pairs(Mission.LSTs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.LSMs = {}
		table.insert(Mission.LSMs, FindEntity("LSM-01"))
		table.insert(Mission.LSMs, FindEntity("LSM-02"))
		
	for idx,unit in pairs(Mission.LSMs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
		--AAEnable(unit, false)
		
	end
	
	Mission.Destroyers = {}
		--table.insert(Mission.Destroyers, FindEntity("Edwards"))
		table.insert(Mission.Destroyers, FindEntity("Zeilin"))
		
	for idx,unit in pairs(Mission.Destroyers) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		DCEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.Elcos = {}
		table.insert(Mission.Elcos, FindEntity("Elco-01"))
		table.insert(Mission.Elcos, FindEntity("Elco-02"))
		
	for idx,unit in pairs(Mission.Elcos) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		DCEnable(unit, false)
		
	end
	
	Mission.MovingCargos = {}
		table.insert(Mission.MovingCargos, FindEntity("Cargo-19"))
		table.insert(Mission.MovingCargos, FindEntity("Cargo-20"))
		
	for idx,unit in pairs(Mission.MovingCargos) do
		
		JoinFormation(unit, Mission.MovingCargos[1])
		
	end
	
	NavigatorMoveOnPath(Mission.MovingCargos[1], FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN_BACKWARDS)
	NavigatorMoveOnPath(FindEntity("Cargo-21"), FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN_BACKWARDS)
	
	Mission.RadarVessel = {}
		table.insert(Mission.RadarVessel, Mission.RadarShip)
	
	Mission.ItsABC = luaSumTablesIndex(Mission.Cargos, Mission.LSTs)
	Mission.USUnits = luaSumTablesIndex(Mission.Cargos, Mission.LSTs, Mission.LSMs, Mission.Destroyers, Mission.RadarVessel)
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and ((string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA")) or (string.find(unit.Name, "Fortress") or string.find(unit.Name, "Bunker"))) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.PlaneTrgs = {}
	
	--[[for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Hangar, Small") or string.find(unit.Name, "US Barracks")) then
			
			table.insert(Mission.PlaneTrgs, unit)
			
		end
		
	end]]
	
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-01"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-02"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-03"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-04"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-05"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-06"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-07"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-08"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-09"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-10"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-11"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-12"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-13"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-14"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-15"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-16"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-17"))
	table.insert(Mission.PlaneTrgs, FindEntity("Cargo-18"))
	
	Mission.Refineries = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and string.find(unit.Name, "Oil Refinery") then
			
			table.insert(Mission.Refineries, unit)
			
		end
		
	end
	
	Mission.CivilPlanes = {}
	
	---- VAR ----
	
	Mission.SafeZone = FindEntity("SafeZone")
	
	Mission.CivilGoTos = {}
		table.insert(Mission.CivilGoTos, FindEntity("SkytrainGoTo1"))
		table.insert(Mission.CivilGoTos, FindEntity("SkytrainGoTo2"))
		table.insert(Mission.CivilGoTos, FindEntity("SkytrainGoTo3"))
	
	Mission.MovieUnits = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.FuckShitFuck = 0
	
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
	
	MissionNarrative("July 3rd, 1943 - The Panama Canal")
	
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
	
	--luaShowPath(FindEntity("MovingOutPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--Mission.Debug = true
	
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
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.LandInstallations))
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
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.MidgetSub.Dead then
				
					luaObj_Failed("secondary",1,true)
				
				end
				
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Refineries)) == 0 then
				
					luaObj_Completed("hidden", 1)
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.CivilPlanes)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CivilPlanes)) do
				
					if unit and not unit.Dead then
					
						local untPos = GetPosition(unit)
						
						if IsInBorderZone(untPos) then
							
							Kill(unit, true)
							
						end
					
					end
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 2) then
			
				if Mission.MidgetSub and not Mission.MidgetSub.Dead then
					
					--[[local torps = GetProperty(Mission.MidgetSub, "TorpedoStock")
					
					if torps == 0 then
					
						luaMissionFailed()
					
					end]]
					
					if not Mission.Debug then
					
						if luaGetDistance(Mission.MidgetSub, Mission.SafeZone) < 350 then
						
							if not Mission.Invincible then
								
								SetForcedReconLevel(Mission.MidgetSub, 0, PARTY_ALLIED)
								
								Mission.Invincible = true
							
							end
						
						else
						
							if Mission.Invincible then
								
								ClearForcedReconLevel(Mission.MidgetSub, PARTY_ALLIED)
								
								Mission.Invincible = false
								
							end
							
							if GetSubmarineOnSurface(Mission.MidgetSub) then
							
								luaMissionFailed()
							
							end
						
						end
					
					end
					
				end
				
			end
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.ChosenTrgs)) == 0 and not Mission.ReadyToMove then
					
					luaObj_Completed("primary", 3)
					
					luaStartDialog("DESTROYED")
					
					luaDelay(luaHidePh2Scores, 3)
					
					Mission.ReadyToMove = true
					
				else
					
					if table.getn(luaRemoveDeadsFromTable(Mission.AttackerPlanes)) == 0 then
					
						luaMissionFailed()
					
					else
					
						Mission.BasesLeft = table.getn(luaRemoveDeadsFromTable(Mission.ChosenTrgs))
				
						local line1 = "Sink all docked cargo ships!"
						local line2 = "Target(s) left to destroy: #Mission.BasesLeft#"
						luaDisplayScore(2, line1, line2)
					
					end
				
				end
			
			end
		
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 4) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.JapSubs)) == 0 then
				
					luaMissionFailed()
				
				else
				
					if Mission.NewJersey.Dead then
					
						luaObj_Completed("primary", 4)
						
						luaMissionComplete()
						
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

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.NewJersey = GenerateObject("New Jersey")
	
	Mission.BBGroup = {}
		table.insert(Mission.BBGroup, Mission.NewJersey)
		table.insert(Mission.BBGroup, GenerateObject("O'Hare"))
		table.insert(Mission.BBGroup, GenerateObject("Duncan"))
	
	local dds = {}
	
	for idx,unit in pairs(Mission.BBGroup) do
		
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
		
		if unit.Class.Type == "Destroyer" then
		
			table.insert(dds, unit)
		
		end
		
	end
	
	for idx,unit in pairs(dds) do
	
		NavigatorMoveToRange(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapSubs)))
		
		UnitSetFireStance(unit, 2)
		
	end
	
	NavigatorMoveOnPath(Mission.BBGroup[1], FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
	
	Blackout(false, "", 3)
	
	local trg1 = Mission.NewJersey
	
	luaIngameMovie(
	{
	   
	   {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	   
	}, luaPh3MovieEnd, true)
	
end

function luaPh3MovieEnd()
	
	if Mission.TakeOffField and not Mission.TakeOffField.Dead then
	
		if IsReadyToSendPlanes(Mission.TakeOffField) then
			
			local planeTypes = {
			135,
			135,
			}
			
			local plane = luaPickRnd(planeTypes)
			
			local slotIndex = LaunchSquadron(Mission.TakeOffField,plane,2)
			local launchedWildcat = thisTable[tostring(GetProperty(Mission.TakeOffField, "slots")[slotIndex].squadron)]
			SetSkillLevel(launchedWildcat, Mission.SkillLevel)
			
			PilotSetTarget(launchedWildcat, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapSubs)))
			
		end
	
	end
	
	local pickedRunner1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	local pickedRunner2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	local pickedRunner3 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	
	if pickedRunner1 and not pickedRunner1.Dead then
	
		NavigatorMoveOnPath(pickedRunner1, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN_BACKWARDS)
		
	end
	
	if pickedRunner2 and not pickedRunner2.Dead then
	
		NavigatorMoveOnPath(pickedRunner2, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
	
	end
	
	if pickedRunner3 and not pickedRunner3.Dead then
	
		NavigatorMoveOnPath(pickedRunner3, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
		
	end
	
	for idx,unit in pairs(Mission.JapSubs) do
		
		SetUnlimitedAirSupply(unit, false)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		SetInvincible(unit, false)
		
		if Mission.Debug then
			
			SetInvincible(unit, true)
			
		end
		
	end
	
	SetSelectedUnit(Mission.JapSubs[1])
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 4)
	
	--luaObj_AddUnit("primary", 4, {Mission.NewJersey})
	
	DisplayUnitHP(luaRemoveDeadsFromTable({Mission.NewJersey}), "Sink the enemy battleship!")
	
end

---- PHASE 2 ----

function luaPh2FadeOut()

	Blackout(true, "luaMoveToPh3", 3)

end

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	
	Mission.ChosenTrgs = luaRemoveDeadsFromTable(Mission.PlaneTrgs)
	
	--local trgTable = luaRemoveDeadsFromTable(Mission.PlaneTrgs)
	
	--[[Mission.Iterations = 0
	
	if Mission.Difficulty == 0 then
	
		Mission.Iterations = 6
	
	elseif Mission.Difficulty == 1 then
	
		Mission.Iterations = 8
		
	elseif Mission.Difficulty == 2 then

		Mission.Iterations = 10
	
	end
	
	for i = 1, Mission.Iterations do
	
		local idx = random(1, table.getn(trgTable))
		local trg = trgTable[idx]
		
		table.insert(Mission.ChosenTrgs, trg)
		table.remove(trgTable, idx)
		
	end]]
	
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-01"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-02"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-03"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-04"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-05"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-06"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-07"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-08"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-09"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Rufe-10"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Jake-01"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Jake-02"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Jake-03"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Jake-04"))
	table.insert(Mission.AttackerPlanes, GenerateObject("Jake-05"))
	
	for idx,unit in pairs(Mission.AttackerPlanes) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
		local unitPos = GetPosition(unit)
	
		--SquadronSetTravelAlt(unit, unitPos.y, true)
		--SquadronSetAttackAlt(unit, unitPos.y, true)
		
		local trg
		
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.ChosenTrgs))
		
		EntityTurnToEntity(unit, trg)
		PilotSetTarget(unit, trg)
		
		UnitSetFireStance(unit, 1)
		
		if Mission.Debug then
			
			SetInvincible(unit, true)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.JapSubs) do
		
		SetSubmarineDepthLevel(unit, 0)
		
	end
	
	Blackout(false, "", 1)
	
	Mission.Ph2MovieTrg = Mission.AttackerPlanes[1]
	
	SetInvincible(Mission.Ph2MovieTrg, true)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 15, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 15, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 3},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 50, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 3},
	  {["postype"] = "cameraandtarget", ["position"]= {
	  		["terrainavoid"] = false,
	  		["parentID"]= Mission.Ph2MovieTrg.ID,
	  		["modifier"] = {
	  		["name"] = "gamecamera",
	  		},
	  	},["moveTime"] = 3
	  },
	  
	}, luaPh2MovieEnd, true)
	
end

function luaPh2MovieEnd()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Elcos)) > 0 then
		
		local pts = {}
		
		if Mission.Difficulty == 1 then
		
			table.insert(pts, luaPickRnd(luaRemoveDeadsFromTable(Mission.Elcos)))
			
		elseif Mission.Difficulty == 2 then
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Elcos)) do
			
				table.insert(pts, unit)
			
			end
			
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(pts)) do
		
			NavigatorAttackMove(unit, Mission.MidgetSub)
		
		end
		
		luaDelay(luaDCDia, 10)
		
	end
	
	local pickedRunner1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	local pickedRunner2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	local pickedRunner3 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USUnits))
	
	if pickedRunner1 and not pickedRunner1.Dead then
	
		NavigatorMoveOnPath(pickedRunner1, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN_BACKWARDS)
		
	end
	
	if pickedRunner2 and not pickedRunner2.Dead then
	
		NavigatorMoveOnPath(pickedRunner2, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
	
	end
	
	if pickedRunner3 and not pickedRunner3.Dead then
	
		NavigatorMoveOnPath(pickedRunner3, FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
		
	end
	
	--[[if FindEntity("Edwards") and not FindEntity("Edwards").Dead then
		
		NavigatorMoveOnPath(FindEntity("Edwards"), FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN_BACKWARDS)
		
	end]]
	
	if FindEntity("Zeilin") and not FindEntity("Zeilin").Dead then
		
		NavigatorMoveOnPath(FindEntity("Zeilin"), FindEntity("MovingOutPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)
		
	end
	
	if Mission.TakeOffField and not Mission.TakeOffField.Dead then
	
		if IsReadyToSendPlanes(Mission.TakeOffField) then
			
			local planeTypes = {
			135,
			135,
			}
			
			local plane = luaPickRnd(planeTypes)
			
			local slotIndex = LaunchSquadron(Mission.TakeOffField,plane,2)
			local launchedWildcat = thisTable[tostring(GetProperty(Mission.TakeOffField, "slots")[slotIndex].squadron)]
			SetSkillLevel(launchedWildcat, Mission.SkillLevel)
		
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Elcos)) do
		
		DCEnable(unit, true)
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Destroyers)) do
		
		DCEnable(unit, true)
		
	end
	
	local its
	
	if Mission.Difficulty == 0 then
	
		its = 5
	
	elseif Mission.Difficulty == 1 then
	
		its = 10
		
	elseif Mission.Difficulty == 2 then

		its = 15
	
	end
	
	for i = 1, its do
	
		local ship = luaPickRnd(luaRemoveDeadsFromTable(Mission.ItsABC))
		
		AAEnable(ship, true)
		
	end
	
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Mission.CanMusicCheck = true
	
	EnableMessages(true)
	
	SetSelectedUnit(Mission.Ph2MovieTrg)
	
	SetInvincible(Mission.Ph2MovieTrg, false)
	SetInvincible(Mission.MidgetSub, false)
	
	luaAddSecObjs()
	
end

function luaDCDia()

	luaStartDialog("DC")

end

function luaAddSecObjs()
	
	luaObj_Add("primary", 3, Mission.ChosenTrgs)
	luaObj_Add("secondary", 1, Mission.MidgetSub)
	luaObj_Add("hidden", 1)
	--luaObj_Add("hidden", 2)

end

function luaHidePh2Scores()

	HideScoreDisplay(2,0)
	
	if Mission.FuckShitFuck < 3 then
	
		Mission.FuckShitFuck = Mission.FuckShitFuck + 1
		
		luaDelay(luaHidePh2Scores, 2)
		
	end
	
end

---- PHASE 1 ----

function luaPh1FadeOut()
	
	--[[local lookAt = GetPosition(Mission.RadarShip)
	
	local lookFrom = lookAt
	lookFrom.y = 25
	
	if Mission.RadarShipPosIdx == 1 then
	
		lookFrom.x = lookFrom.x + 200
	
	else
	
		lookFrom.x = lookFrom.x - 200
	
	end]]
	
	ExplodeToParts(Mission.RadarShip)
	SetDeadMeat(Mission.RadarShip)
	--BreakShip(Mission.RadarShip)
	
	luaDelay(luaKillDia, 2)
	
	--[[luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=lookFrom.x,["y"]=lookFrom.y,["z"]=lookFrom.z},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=lookAt.x,["y"]=lookAt.y,["z"]=lookAt.z},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=lookAt.x,["y"]=lookAt.y,["z"]=lookAt.z},["parent"] = nil,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
	}, luaPh1Blackout, true)]]
	
end

function luaPh1Blackout()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaKillDia()

	luaStartDialog("KILL")

end

function luaIntroMovie1()
	
	PilotMoveToRange(FindEntity("MovieSkytrain"), FindEntity("MovieSkytrainGoTo"))
	
	table.insert(Mission.MovieUnits, FindEntity("MovieSkytrain"))
	table.insert(Mission.MovieUnits, FindEntity("MovieMidget"))
	table.insert(Mission.MovieUnits, FindEntity("MovieI400"))
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("Cargo-01")
	local trg2 = FindEntity("MovieSkytrain")
	
	luaDelay(luaIntroDia, 3.5)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=75,["y"]=16,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=11,["z"]=25},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=11,["z"]=25},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=13,["z"]=35},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 100, ["theta"] = 23, ["rho"] = 210, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 70, ["theta"] = 23, ["rho"] = 230, ["moveTime"] = 12},
		
	}, luaIntroMovie2, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()
	
	DisablePhysics(FindEntity("MovieMidget"))
	
	local trg1 = FindEntity("MovieI400")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-20,["y"]=9,["z"]=49},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=20,["z"]=32},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=32},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=32},["parent"] = trg1,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.MovieUnits)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MovieUnits)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	luaDelay(luaInZeMission, 2)
	
end

function luaInZeMission()

	Mission.MissionPhase = 1
	
	luaPlaneFlow()
	
	Mission.MidgetSub = GenerateObject("Ha-21")
	
	--ShipSetTorpedoStock(Mission.MidgetSub, 4)
	
	SetSelectedUnit(Mission.MidgetSub)
	
	--SetSubmarineAirSupply(Mission.MidgetSub, 5.0)
	SetSkillLevel(Mission.MidgetSub, Mission.SkillLevelOwn)
	
	SetForcedReconLevel(Mission.MidgetSub, 2, PARTY_ALLIED)
	
	if Mission.Debug then
		
		--for idx,unit in pairs(Mission.RllyBruh) do
			
			SetUnlimitedAirSupply(Mission.MidgetSub, true)
			SetInvincible(Mission.MidgetSub, true)
			
		--end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end
	
	--EnableMessages(true)
	
	Blackout(false, "", 3)
	
	--luaDelay(luaAddFirstObjs, 3)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.RadarShip)
	luaObj_Add("primary", 2)
	
	luaAddUSShipsHitListener()
	
	local line1 = "Find and sink the enemy radar ship!"
	local line2 = "Avoid detection! Surface only in the designated zone."
	luaDisplayScore(1, line1, line2)
	
	luaShowPoint(Mission.SafeZone)
	
	luaDelay(luaAKDia, 10)
	
end

function luaAKDia()

	luaStartDialog("AK")
	
	--luaObj_RemoveUnit("marker2", 1, GetPosition(Mission.SafeZone))
	
end

function luaPlaneFlow()

	if Mission.MissionPhase == 1 then
	
		if Mission.TakeOffField and not Mission.TakeOffField.Dead then
	
			if IsReadyToSendPlanes(Mission.TakeOffField) then
				
				local planeTypes = {
				136,
				136,
				}
				
				local plane = luaPickRnd(planeTypes)
				
				local slotIndex = LaunchSquadron(Mission.TakeOffField,plane,1,1)
				local launchedWildcat = thisTable[tostring(GetProperty(Mission.TakeOffField, "slots")[slotIndex].squadron)]
				SetSkillLevel(launchedWildcat, Mission.SkillLevel)
				
				PilotMoveToRange(launchedWildcat, luaPickRnd(Mission.CivilGoTos))
				
				table.insert(Mission.CivilPlanes, launchedWildcat)
				
			end
		
		end
		
		if Mission.LandingField and not Mission.LandingField.Dead then
			
			local plane = GenerateObject("Skytrain")
			
			PilotLand(plane, Mission.LandingField)
		
		end
		
		luaDelay(luaPlaneFlow, 200)
	
	end

end

function luaHidePh1Scores()

	HideScoreDisplay(1,0)

end

---- LISTENERS ----

function luaAddUSShipsHitListener()

	AddListener("hit", "USShipsHitListener", {
		["callback"] = "luaUSHit",
		["target"] = Mission.USUnits,
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"TORPEDO"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

---- LISTENER CALLBACKS ----

function luaUSHit(unit)
	
	RemoveListener("hit", "USShipsHitListener")
	
	if unit.Class.ID == 295 then
		
		luaDelay(luaHidePh1Scores, 1)
		
		luaObj_RemoveUnit("marker2", 1, GetPosition(Mission.SafeZone))
		
		SetInvincible(Mission.MidgetSub, true)
		
		luaObj_Completed("primary", 1, true)
		luaObj_Completed("primary", 2)
		
		luaPh1FadeOut()
	
	else
	
		luaMissionFailed()
	
	end

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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	--[[if luaObj_IsActive("hidden",2) then
		
		if Mission.MidgetSub and not Mission.MidgetSub.Dead then
		
			luaObj_Completed("hidden",2)
		
		else
		
			luaObj_Failed("hidden",2)
		
		end
		
	end]]
	
	luaMissionCompletedNew(Mission.NewJersey, "Panama lies in ruins - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Scores, 1)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh2Scores, 1)
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	--[[if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end]]
	
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