---- OPERATION DOWNFALL (USN) ----

-- Scripted & Assembled by: Team Wolfpack

---- OPERATION DOWNFALL (USN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(334) 	-- Frank
	PrepareClass(151) 	-- Raiden
	PrepareClass(326) 	-- George
	PrepareClass(152) 	-- Gekko
	--PrepareClass(100) 	-- Kamikaze Oscar
	PrepareClass(45) 	-- Kamikaze Zero
	PrepareClass(46) 	-- Kamikaze Val
	PrepareClass(103) 	-- Kamikaze Judy
	PrepareClass(32) 	-- Betty (Ohka)
	PrepareClass(167) 	-- Betty
	
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
	
	LoadMessageMap("usn14dlg",1)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/USN/usn_17_tokyo.lua"

	this.Name = "USN17"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Bomb",
				["Text"] = "Escort the bomber wing to it's designated target!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Inv",
				["Text"] = "Secure all enemy bases!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Sink",
				["Text"] = "Sink the remaining Japanese capital ships!",
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
				["Text"] = "Ensure the survival of both of your battleships!",
				["TextFailed"] = "One of your battleships is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "AF",
				["Text"] = "Destroy the inland airfields!",
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
					["message"] = "BRAH1",
				},
				{
					["message"] = "BRAH2",
				},
				{
					["message"] = "BRAH3",
				},
				{
					["message"] = "BRAH4",
				},
				{
					["message"] = "BRAH5",
				},
				{
					["message"] = "BRAH6",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "BRAH7",
				},
				{
					["message"] = "BRAH8",
				},
			},
		},
		["ASHORE"] = {--
			["sequence"] = {
				{
					["message"] = "idlg04",
				},
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 5,
				},
				{
					["message"] = "CARRIA1",
				},
				{
					["message"] = "CARRIA2",
				},
				{
					["message"] = "CARRIA3",
				},
			},
		},
		["AIR"] = {--
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["BOATS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg04a",
				},
				{
					["message"] = "dlg04b",
				},
				{
					["message"] = "dlg04c",
				},
				{
					["message"] = "dlg04d",
				},
				{
					["message"] = "dlg04e",
				},
				{
					["message"] = "dlg04f",
				},
				{
					["message"] = "dlg04g",
				},
			},
		},
		["LANDED"] = {--
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
			},
		},
		["LOST"] = {--
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
				{
					["message"] = "dlg10c",
				},
				{
					["message"] = "ITSOVER1",
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
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	---- IJN ----
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB3"))
		table.insert(Mission.HQs, FindEntity("CB4"))
		table.insert(Mission.HQs, FindEntity("CB5"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
		table.insert(Mission.Airfields, FindEntity("Airfield4"))
	
	Mission.InFields = {}
		table.insert(Mission.InFields, FindEntity("Airfield3"))
		table.insert(Mission.InFields, FindEntity("Airfield4"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
	end
	
	Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("Shipyard1"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard2"))
	
	for idx,unit in pairs(Mission.Shipyards) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
	end
	
	Mission.Shipyards[1].USN17_SpawnPoint = FillPathPoints(FindEntity("ShipyardPath CB4"))[3]
	Mission.Shipyards[2].USN17_SpawnPoint = FillPathPoints(FindEntity("ShipyardPath CB5"))[3]
	
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Fortress-01"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-02"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-03"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-04"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-05"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-06"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-07"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-08"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-09"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-10"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-11"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-12"))
	
	for idx,unit in pairs(Mission.Fortresses) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
	end
	
	Mission.Fightas = {[1] = 334, [2] = 151, [3] = 326, [4] = 152}
	Mission.Kamis = {[1] = 45, [2] = 46, [3] = 103}
	Mission.Bettys = {[1] = 32, [2] = 167}
	
	Mission.Fighters = {}
	
	---- USN ----
	
	Mission.MovieBombas = luaSpawnBombers()
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.StrikeDelay = 80
		Mission.CatalinaDelay = 140
		Mission.BomberHealth = 30
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.StrikeDelay = 60
		Mission.CatalinaDelay = 120
		Mission.BomberHealth = 40
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.StrikeDelay = 40
		Mission.CatalinaDelay = 100
		Mission.BomberHealth = 50
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("September 28th, 1945 - Off Tokyo")
	
	Blackout(true, "", true)
	
	---- THINK ----
	
	luaInitNewSystems()
    luaCheckObjectives()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--SetInvincible(FindEntity("TEST"), 0.5)
	
	--luaDelay(luaMoveToPh3, 70)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaMoveToPh4, 70)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Val1")
	--PilotSetTarget(FindEntity("Val1"), FindEntity("Airfield1"))
	
	--luaShowPoint(FindEntity("AggloGoTo"))
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
	--luaShowPath(FindEntity("CVEPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--Mission.Debug = true
	
	--[[if Mission.Debug then
		
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
	
		luaIntroMovie()
		
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
	
	--[[local pos = GetPosition(FindEntity("TEST"))
	
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
			
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Transports)) == 0 then
				
					luaMissionFailed()
				
				else
				
					local capped = 0
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
					
						if unit.Party == PARTY_ALLIED then
							
							capped = capped + 1
							
							if not Mission.AirfieldCappedDiaPlayed then
								
								luaStartDialog("LANDED")
								
								Mission.AirfieldCappedDiaPlayed = true
							
							end
							
						end
					
					end
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
			
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
							
							if unit and not unit.Dead and unit.Party == PARTY_JAPANESE then
								
								local fighters = Mission.Fightas
								local bombers
								
								if unit.Name == "Airfield3" or unit.Name == "Airfield4" then
								
									bombers = Mission.Bettys
									
								else
								
									bombers = Mission.Kamis
									
								end
								
								local trgs = luaGetUSPlaneTrg()
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
								
							end
						
						end
					
					end
					
					if not Mission.LostDiaPlayed then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) < 19 then
							
							luaStartDialog("LOST")
							
							Mission.LostDiaPlayed = true
						
						end
						
					end
					
					Mission.BasesLeft = capped
					
					if capped == 5 and not Mission.Capped then
					
						Mission.Capped = true
						
						if not Mission.Ph3Moved then
						
							luaMoveToPh3()
							
							Mission.Ph3Moved = true
						
						end
						
					elseif capped < 5 and Mission.Capped then
					
						Mission.Capped = false
						
					end
					
					local line1 = "Secure all enemy bases!"
					local line2 = "Base(s) captured: #Mission.BasesLeft#"
					luaDisplayScore(2, line1, line2)
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USBBs)) == 0 then
				
					luaObj_Failed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.InFields)) == 0 then
				
					luaObj_Completed("hidden", 1, true)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
		
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Agglos)) == 0 then
				
					luaMissionFailed()
				
				else
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Fighters)) > 0 then
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Fighters)) do
			
							if unit and not unit.Dead then
						
								if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
									
									local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Agglos))
									
									luaSetScriptTarget(unit, trg)
									NavigatorAttackMove(unit, trg)
								
								end
							
							end
							
						end
						
					end
					
					local ordered = luaSortByDistance(FindEntity("AggloCheck"), luaRemoveDeadsFromTable(Mission.Agglos))
					local closest = ordered[1]
					local dist = luaGetDistance3D(closest, FindEntity("AggloCheck"))
					
					if dist < 2500 then
						
						if not Mission.Ph1Done then
						
							for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Agglos)) do
								
								if unit and not unit.Dead then
								
									SetInvincible(unit, true)
									
									SquadronForceRelease(unit)
								
								end
								
							end
							
							luaDelay(luaHidePh1Score, 1)
							
							luaObj_Completed("primary", 1)
							
							Mission.Ph1EndMovieTrg = closest
							
							Mission.CanMusicCheck = false
							
							luaDelay(luaPh1EndMovie, 3)
							
							Mission.Ph1Done = true
						
						end
						
					else
						
						Mission.planesleft = 0
	
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Agglos)) do
						
							Mission.planesleft = Mission.planesleft + luaGetSquadronPlaneNum(unit)
							
						end
						
						Mission.planesleft = math.floor(Mission.planesleft / Mission.AllB29 * 100)
						
						if Mission.planesleft <= Mission.BomberHealth then
						
							luaMissionFailed()
						
						else
						
							local line1 = "Ensure that #Mission.BomberHealth#% of the bomber wing survives!"
							local line2 = "Wing strength: #Mission.planesleft#%"
							luaDisplayScore(1, line1, line2)
							
						end
					
					end
					
				end
			
			end
			
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Crit)) == 0 then
					
					luaDelay(luaHidePh3Score, 1)
					
					luaObj_Completed("primary", 3, true)
					
					Mission.Sunk = true
					
				else
					
					Mission.Left = table.getn(luaRemoveDeadsFromTable(Mission.Crit))
					
					local line1 = "Sink the remaining Japanese capital ships!"
					local line2 = "Ship(s) left to sink: #Mission.Left#"
					luaDisplayScore(3, line1, line2)
					
				end
				
			end
			
			if Mission.Capped and Mission.Sunk then
		
				if not Mission.Done then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
					
						SetInvincible(unit, 0.01)
					
					end
					
					luaDelay(luaHidePh2Score, 1)
					HideUnitHP()
					
					luaObj_Completed("primary", 2, true)
					
					luaStartDialog("FINAL")
					
					Mission.Done = true
					Mission.EndMission = true
					
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
	
	Mission.NagatoFleet = {}
		table.insert(Mission.NagatoFleet, GenerateObject("Nagato"))
		table.insert(Mission.NagatoFleet, GenerateObject("Suzutsuki"))
		table.insert(Mission.NagatoFleet, GenerateObject("Kiri"))
		
	for idx,unit in pairs(Mission.NagatoFleet) do
		
		JoinFormation(unit, Mission.NagatoFleet[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
		UnitSetFireStance(unit, 2)
		
	end
	
	Mission.CVEFleet = {}
		table.insert(Mission.CVEFleet, GenerateObject("Jun'yo"))
		table.insert(Mission.CVEFleet, GenerateObject("Ryuho"))
		table.insert(Mission.CVEFleet, GenerateObject("Sakawa"))
		table.insert(Mission.CVEFleet, GenerateObject("Sugi"))
		
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
			
			table.insert(Mission.Airfields, unit)
			
		end
		
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	NavigatorAttackMove(Mission.NagatoFleet[1], luaPickRnd(luaRemoveDeadsFromTable(Mission.Transports)))
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVEFleet[1], FindEntity("CVEPath"), PATH_FM_CIRCLE, pathDir)
	
	Mission.Crit = {}
		table.insert(Mission.Crit, FindEntity("Nagato"))
		table.insert(Mission.Crit, FindEntity("Jun'yo"))
		table.insert(Mission.Crit, FindEntity("Ryuho"))
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.NagatoFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 100, ["theta"] = 1, ["rho"] = 5, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 110, ["theta"] = 1, ["rho"] = 3, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
      {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 3, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	}, luaPh3MovieEnd, true)
	
end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
		
		SetSelectedUnit(luaPickRnd(Mission.USShips))
		
	end
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()
	
	luaObj_Add("primary", 3, Mission.Crit)
	
end

function luaHidePh3Score()

	HideScoreDisplay(3,0)

end

---- PHASE 2 ----

function luaPh2FadeOut()

	Blackout(true, "luaMoveToPh3", 3)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Agglos)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Agglos)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Fighters)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Fighters)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	Mission.USBBFleet = {}
		table.insert(Mission.USBBFleet, GenerateObject("Iowa"))
		table.insert(Mission.USBBFleet, GenerateObject("Massachusetts"))
		table.insert(Mission.USBBFleet, GenerateObject("La Vallette"))
		table.insert(Mission.USBBFleet, GenerateObject("Beale"))
		table.insert(Mission.USBBFleet, GenerateObject("Hutchins"))
		table.insert(Mission.USBBFleet, GenerateObject("Renshaw"))
		
	for idx,unit in pairs(Mission.USBBFleet) do
		
		JoinFormation(unit, Mission.USBBFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		if Mission.Debug then
		
			SetInvincible(unit, 0.4)
			
		end
		
	end
	
	Mission.USCVFleet = {}
		table.insert(Mission.USCVFleet, GenerateObject("Midway"))
		table.insert(Mission.USCVFleet, GenerateObject("Intrepid"))
		table.insert(Mission.USCVFleet, GenerateObject("Lexington"))
		table.insert(Mission.USCVFleet, GenerateObject("Baltimore"))
		table.insert(Mission.USCVFleet, GenerateObject("Charles S. Sperry"))
		table.insert(Mission.USCVFleet, GenerateObject("Haynsworth"))
		table.insert(Mission.USCVFleet, GenerateObject("Wallace L. Lind"))
		table.insert(Mission.USCVFleet, GenerateObject("Hugh Purvis"))
		table.insert(Mission.USCVFleet, GenerateObject("McCawley"))
		table.insert(Mission.USCVFleet, GenerateObject("Hamblen"))
		table.insert(Mission.USCVFleet, GenerateObject("LST-01"))
		table.insert(Mission.USCVFleet, GenerateObject("LST-02"))
		table.insert(Mission.USCVFleet, GenerateObject("LSM-01"))
		
	for idx,unit in pairs(Mission.USCVFleet) do
		
		JoinFormation(unit, Mission.USCVFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		if Mission.Debug then
		
			SetInvincible(unit, 0.4)
			
		end
		
	end
	
	Mission.USShips = luaSumTablesIndex(Mission.USBBFleet, Mission.USCVFleet)
	
	Mission.Transports = {}
		table.insert(Mission.Transports, FindEntity("McCawley"))
		table.insert(Mission.Transports, FindEntity("Hamblen"))
		table.insert(Mission.Transports, FindEntity("LST-01"))
		table.insert(Mission.Transports, FindEntity("LST-02"))
	
	Mission.USBBs = {}
		table.insert(Mission.USBBs, FindEntity("Iowa"))
		table.insert(Mission.USBBs, FindEntity("Massachusetts"))
	
	luaDelay(luaPh2Dia, 2)
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	local kamis = {45, 46, 103}
	local slotIndex = LaunchSquadron(FindEntity("Airfield1"), luaPickRnd(kamis), 3)
	
	local trg1 = Mission.USBBFleet[1]
	local trg2 = FindEntity("Airfield1")
	Mission.FirstKami = thisTable[tostring(GetProperty(FindEntity("Airfield1"), "slots")[slotIndex].squadron)]
	PilotSetTarget(Mission.FirstKami, luaPickRnd(Mission.USBBFleet))
	local trg3 = Mission.USBBFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 8, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 340, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 3, ["smoothtime"] = 0.5},
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 100, ["theta"] = 10, ["rho"] = 192, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.FirstKami, ["distance"] = 60, ["theta"] = 5, ["rho"] = 8, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.FirstKami, ["distance"] = 50, ["theta"] = 5, ["rho"] = 31, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	  {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	  
	}, luaPh2MovieEnd, true)
	
end

function luaPh2Dia()

	luaStartDialog("ASHORE")

end

function luaPh2MovieEnd()

	SetSelectedUnit(Mission.USBBFleet[1])
	
	Mission.CanMusicCheck = true
	
	luaAddSecObjs()
	
end

function luaAddSecObjs()
	
	luaObj_Add("primary", 2, luaSumTablesIndex(Mission.HQs, Mission.Transports))
	luaObj_Add("secondary", 1, Mission.USBBs)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Transports), "Protect your transports!")
	
	luaDelay(luaSYFlow, Mission.CatalinaDelay)
	
	luaAddPlaneListener()
	
end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.USShips
		
	elseif Mission.Difficulty == 2 then
		
		trgs = Mission.Transports
		
	end
	
	return trgs
	
end

function luaHidePh2Score()

	HideScoreDisplay(2,0)

end

function luaSYFlow()

	if Mission.MissionPhase == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.Shipyards)) > 0 then
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Shipyards)) do
		
				if unit and not unit.Dead and unit.Party == PARTY_JAPANESE then
					
					local spawnIdx
					
					if not Mission.BlyatCyka then
						
						spawnIdx = 1
						
						Mission.BlyatCyka = true
						
					else
					
						spawnIdx = luaRnd(1,2)
						
					end
					
					local trgs = luaGetUSPlaneTrg()
					local pos = unit.USN17_SpawnPoint
					local unit
					
					if spawnIdx == 1 then
					
						unit = GenerateObject("Shinyo")
						
						if not Mission.BoatListenerAdded then
						
							luaAddBoatListener(unit)
							
							Mission.BoatListenerAdded = true
						
						end
						
					elseif spawnIdx == 2 then
						
						unit = GenerateObject("Kaiten")
						
						SetUnlimitedAirSupply(unit, true)
						
						pos.y = -10
						
					end
					
					PutTo(unit, pos)
					
					NavigatorSetAvoidLandCollision(unit, true)
					TorpedoEnable(unit, true)
					
					NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(trgs)))
					
					UnitSetFireStance(unit, 2)
					
					SetSkillLevel(unit, Mission.SkillLevel)
					
				end
			
			end
			
		end
		
		luaDelay(luaSYFlow, Mission.CatalinaDelay)
		
	end

end

---- PHASE 1 ----

function luaPh1EndMovie()
	
	local trg1
	
	if Mission.Ph1EndMovieTrg and not Mission.Ph1EndMovieTrg.Dead then
	
		trg1 = Mission.Ph1EndMovieTrg
	
	else
	
		trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.Agglos))
	
	end
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 40, ["rho"] = -20, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 80, ["theta"] = 40, ["rho"] = -20, ["moveTime"] = 4},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 130, ["theta"] = 85, ["rho"] = -20, ["moveTime"] = 6, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 130, ["theta"] = 85, ["rho"] = -20, ["moveTime"] = 8, ["smoothtime"] = 2},
		
	}, luaPh1FadeOut, true)

end

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaSpawnBombers()

	local bombas = {}
		table.insert(bombas, GenerateObject("Agglo-01"))
		table.insert(bombas, GenerateObject("Agglo-02"))
		table.insert(bombas, GenerateObject("Agglo-03"))
		table.insert(bombas, GenerateObject("Agglo-04"))
		table.insert(bombas, GenerateObject("Agglo-05"))
		table.insert(bombas, GenerateObject("Agglo-06"))
		table.insert(bombas, GenerateObject("Agglo-07"))
		table.insert(bombas, GenerateObject("Agglo-08"))
		table.insert(bombas, GenerateObject("Agglo-09"))
	
	local leaderPos = GetPosition(bombas[1])
	
	for idx,unit in pairs(bombas) do
		
		local pos = GetPosition(unit)
		
		SquadronSetTravelAlt(unit, pos.y, true)
		SquadronSetAttackAlt(unit, pos.y, true)	
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		SetRoleAvailable(unit, EROLF_PILOT, PLAYER_AI)
		SquadronForceGunnerMode(unit, true)
		UnitSetPlayerCommandsEnabled(unit, PCF_NONE)
		
		local deltaX = -1.5 * (leaderPos.x - pos.x)
		local deltaY = -1.5 * (leaderPos.z - pos.z)
		local goTo = GetPosition(FindEntity("AggloGoTo"))
		goTo.x = goTo.x + deltaX
		goTo.z = goTo.z + deltaY
		
		EntityTurnToEntity(unit, FindEntity("AggloGoTo"))
		PilotMoveTo(unit, goTo)
		
	end
	
	return bombas
	
end

function luaSpawnFighters()
	
	if Mission.MissionPhase == 1 and not Mission.EndMission then
		
		local prenTbl = {}
		
		for i = 1, 3 do
			
			local pren = GenerateObject("Fighta"..luaRnd(1,4))
			
			local pos = GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.Agglos)))
			pos.x = pos.x - luaRnd(4000, 4500)
			pos.z = pos.z + luaRnd(4000, 4500)
			
			PutTo(pren, pos)
			
			table.insert(prenTbl, pren)
		
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(prenTbl)) do
		
			if unit and not unit.Dead then
			
				SetSkillLevel(unit, Mission.SkillLevel)
				
				table.insert(Mission.Fighters, unit)
				
			end
		
		end
		
		luaDelay(luaSpawnFighters, 45)
	
	end
	
end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 3)
	luaDelay(luaSpawnIntroFighters, 29)
	
	local trg1 = Mission.MovieBombas[1]
	local trg2 = Mission.MovieBombas[7]
	
	luaIngameMovie(
	{
	    
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-0.5,["y"]=1.25,["z"]=14.7},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 3,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-2,["y"]=3,["z"]=60},["parent"] = trg1,},["moveTime"] = 13,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-2,["y"]=3,["z"]=60},["parent"] = trg1,},["moveTime"] = 4,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 65, ["theta"] = 4, ["rho"] = 220, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 65, ["theta"] = 5, ["rho"] = 190, ["moveTime"] = 8},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-4000,["y"]=180,["z"]=2500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3500,["y"]=180,["z"]=2500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-3500,["y"]=180,["z"]=2500},["parent"] = nil,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaSpawnIntroFighters()

	if Mission.MissionPhase == 0 then
		
		local offset = 0
		
		for i = 1, 3 do
		
			local pren = GenerateObject("Fighta"..luaRnd(1,4))
			
			local pos = {}
			pos.x = -4400 - offset
			pos.y = luaRnd(160, 200)
			pos.z = 2500
			
			PutTo(pren, pos)
			
			offset = offset - 200
			
			SquadronSetTravelAlt(pren, pos.y, true)
			SquadronSetAttackAlt(pren, pos.y, true)	
			
			local goTo = pos
			goTo.x = 0
			
			PilotMoveTo(pren, goTo)
			
			table.insert(Mission.MovieBombas, pren)
		
		end
		
	end

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

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	Mission.MissionPhase = 1
	
	Mission.CanMusicCheck = true
	
	EnableMessages(true)
	
	luaKillIntroPlanes()
	
	Mission.Agglos = luaSpawnBombers()
	
	Mission.AllB29 = table.getn(luaRemoveDeadsFromTable(Mission.Agglos)) * 5
	
	SetSelectedUnit(Mission.Agglos[1])
	
	Blackout(false, "", 3)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, GetPosition(FindEntity("AggloCheck")))
	
	luaDelay(luaSpawnFighters, 10)
	
end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

---- LISTENERS ----

function luaAddBoatListener(unit)
	
	AddListener("recon", "BoatListener", {
		["callback"] = "luaBoatSighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})
	
end

function luaAddPlaneListener()
	
	if Mission.FirstKami and not Mission.FirstKami.Dead then
	
		AddListener("recon", "PlaneListener", {
			["callback"] = "luaPlaneSighted",
			["entity"] = {Mission.FirstKami},
			["oldLevel"] = {0,1},
			["newLevel"] = {2},
			["party"] = {PARTY_ALLIED},
		})
	
	end
	
end

---- LISTENER CALLBACKS ----

function luaBoatSighted()

	RemoveListener("recon", "BoatListener")
	
	luaStartDialog("BOATS")

end

function luaPlaneSighted()

	RemoveListener("recon", "PlaneListener")
	
	luaStartDialog("AIR")

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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "The mainland has been invaded - Mission Complete")

end

function luaMissionFailed()
	
	if Mission.Debug then
	
		return
	
	end
	
	Mission.EndMission = true
	
	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Score, 1)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh2Score, 1)
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh3Score, 1)
		
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