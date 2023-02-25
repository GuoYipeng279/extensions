---- INVASION OF NEW CALEDONIA (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- INVASION OF NEW CALEDONIA (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(330) 	-- P39
	PrepareClass(26) 	-- F6F
	PrepareClass(108) 	-- SBD
	PrepareClass(38) 	-- SB2C
	PrepareClass(113) 	-- TBF
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
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_11_caledonia.lua"

	this.Name = "IJN11"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Cap",
				["Text"] = "Capture all enemy bases!",
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
				["ID"] = "Dest",
				["Text"] = "Destroy the invasion force!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Bases",
				["Text"] = "Don't let any of your bases fall to the enemy!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "CV",
				["Text"] = "Sink the enemy carrier and battleship!",
				["TextCompleted"] = "You've sunk the enemy carrier and battleship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Shoot",
				["Text"] = "Find and shoot down Admiral Halsey's plane!",
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
					["message"] = "idlg01_1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO3",
				},
			},
		},
		["BETTY"] = {--
			["sequence"] = {
				{
					["message"] = "BETTY1",
				},
			},
		},
		["SPOTTED"] = {--
			["sequence"] = {
				{
					["message"] = "SPOTTED1",
				},
				{
					["message"] = "SPOTTED2",
				},
				{
					["message"] = "SPOTTED3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
				{
					["message"] = "FORTRESS1",
				},
				{
					["message"] = "FORTRESS2",
				},
			},
		},
		--[[["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},]]
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
	
	Mission.JapFleet = {}
		table.insert(Mission.JapFleet, FindEntity("Soryu"))
		--table.insert(Mission.JapFleet, FindEntity("Zuiho"))
		table.insert(Mission.JapFleet, FindEntity("Mikawa"))
		table.insert(Mission.JapFleet, FindEntity("Takao"))
		table.insert(Mission.JapFleet, FindEntity("Atago"))
		--table.insert(Mission.JapFleet, FindEntity("Myoko"))
		--table.insert(Mission.JapFleet, FindEntity("Harusame"))
		table.insert(Mission.JapFleet, FindEntity("Samidare"))
		table.insert(Mission.JapFleet, FindEntity("Umikaze"))
		--table.insert(Mission.JapFleet, FindEntity("Yamakaze"))
		--table.insert(Mission.JapFleet, FindEntity("Kawakaze"))
		table.insert(Mission.JapFleet, FindEntity("Nojima Maru"))
		table.insert(Mission.JapFleet, FindEntity("Edogawa Maru"))
		--table.insert(Mission.JapFleet, FindEntity("SB-01"))
		--table.insert(Mission.JapFleet, FindEntity("SB-02"))
	
	for idx,unit in pairs(Mission.JapFleet) do
		
		JoinFormation(unit, Mission.JapFleet[1])
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
	
	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("Nojima Maru"))
		table.insert(Mission.JapTransports, FindEntity("Edogawa Maru"))
		--table.insert(Mission.JapTransports, FindEntity("SB-01"))
		--table.insert(Mission.JapTransports, FindEntity("SB-02"))
	
	Mission.JapTroop = {}
		table.insert(Mission.JapTroop, FindEntity("Nojima Maru"))
		table.insert(Mission.JapTroop, FindEntity("Edogawa Maru"))
	
	Mission.JapLSTs = {}
		--table.insert(Mission.JapLSTs, FindEntity("SB-01"))
		--table.insert(Mission.JapLSTs, FindEntity("SB-02"))
	
	--[[if Mission.Difficulty < 2 then
		
		local bomber1 = GenerateObject("Betty_1")
		local bomber2 = GenerateObject("Betty_2")
		
		SetSkillLevel(bomber1, Mission.SkillLevelOwn)
		SetSkillLevel(bomber2, Mission.SkillLevelOwn)
		
		PilotMoveToRange(bomber1, Mission.JapFleet[1])
		PilotMoveToRange(bomber2, Mission.JapFleet[1])
		
		Mission.CanPlayBettyDia = true
		
	end]]
	
	---- USN ----
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB3"))
		table.insert(Mission.HQs, FindEntity("CB4"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		--table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
		table.insert(Mission.Airfields, FindEntity("Airfield4"))
		table.insert(Mission.Airfields, FindEntity("Airfield5"))
	
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
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA") or string.find(unit.Name, "Coastal Gun") or string.find(unit.Name, "Coastal Gun")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
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
	
	MissionNarrative("December 11th, 1942 - Island of New Caledonia")
	
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
	
	--luaShowPath(FindEntity("BBFleetPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapFleet) do
		
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
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.Halsey.Dead then
				
					luaObj_Completed("hidden", 1, true)
					
				else
				
					local untPos = GetPosition(Mission.Halsey)
					
					if IsInBorderZone(untPos) then
						
						SetInvincible(Mission.Halsey, 0.01)
						
						luaObj_Failed("hidden", 1)
					
					end
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				Mission.Capped = 0
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						Mission.Capped = Mission.Capped + 1
						
					end
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
						
						if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
							
							local fighters = {
								[1] = 330,
							}
							local bombers = {
								[1] = 108,
								[2] = 113,
								[3] = 38,
							}
							
							if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
								
								if unit.Name == "Airfield2" or unit.Name == "Airfield4" then
								
									bombers[4] = 116
								
								end
								
							end
							
							local trgs = luaGetUSPlaneTrg()
							
							luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
							
						end
					
					end
				
				end
				
				if Mission.Capped == 5 then
					
					if not Mission.WhyYouDoThisToMeee then
					
						--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
						
							SetInvincible(unit, 0.01)
						
						end]]
						
						luaDelay(luaHidePh1Score, 1)
						HideUnitHP()
						
						luaObj_Completed("primary", 1, true)
						luaObj_Completed("primary", 2)
						
						luaDelay(luaMoveToPh2, 2)
						
						Mission.WhyYouDoThisToMeee = true
						
					end
					
				else
				
					Mission.BasesLeft = 5 - Mission.Capped
				
					local line1 = "Capture all enemy bases!"
					local line2 = "Enemy base(s) left to capture: #Mission.BasesLeft#"
					luaDisplayScore(1, line1, line2)
				
				end
				
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTransports)) == 0 then
					
					luaMissionFailed()
				
				--else
				
					--if table.getn(luaRemoveDeadsFromTable(Mission.JapTroop)) == 0 then
						
						--[[local lstNum = table.getn(luaRemoveDeadsFromTable(Mission.JapLSTs))
						
						if lstNum > 0 then]]
						
							--if Mission.BasesLeft > lstNum then
							
								--luaMissionFailed()
							
							--end
						
						--end
						
					--end
				
				end
			
			end
			
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USTransports)) == 0 then
				
					if not Mission.Bruh then
					
						HideUnitHP()
						
						luaObj_Completed("primary", 3, true)
						luaObj_Completed("primary", 4)
						
						luaMissionComplete()
						--luaStartDialog("FINAL")
						
						Mission.Bruh = true
						
					end
				
				end
				
			end
			
			if luaObj_IsActive("primary", 4) then
				
				local capped = 0
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						
					end
				
				end
				
				if capped < 5 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USSec)) == 0 then
				
					luaObj_Completed("secondary", 1, true)
				
				else
				
					if Mission.Gettysburg and not Mission.Gettysburg.Dead then
						
						local fighters = {
							[1] = 26,
						}
						local bombers = {
							[1] = 108,
							[2] = 113,
							[3] = 38,
						}
						
						local trgs = luaGetUSPlaneTrg()
						
						luaAirfieldManager(Mission.Gettysburg, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
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

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.USFleet = {}
		table.insert(Mission.USFleet, GenerateObject("Gettysburg"))
		table.insert(Mission.USFleet, GenerateObject("Kentucky"))
		table.insert(Mission.USFleet, GenerateObject("Charles S. Sperry"))
		table.insert(Mission.USFleet, GenerateObject("Wiltsie"))
		--table.insert(Mission.USFleet, GenerateObject("Harry F. Bauer"))
		--table.insert(Mission.USFleet, GenerateObject("Taussig"))
		--table.insert(Mission.USFleet, GenerateObject("Lofberg"))
		--table.insert(Mission.USFleet, GenerateObject("Douglas H. Fox"))
	
	Mission.Gettysburg = FindEntity("Gettysburg")
	
	local spawnIdx = luaRnd(1,2)
	
	for idx,unit in pairs(Mission.USFleet) do
		
		local moveX
		local moveY
	
		if spawnIdx == 1 then
		
			moveX = -4500
			moveY = 0
		
		elseif spawnIdx == 2 then
		
			moveX = 0
			moveY = 4500
		
		end
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
		JoinFormation(unit, Mission.USFleet[1])
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
				
				SetAirBaseSlotCount(unit, 4)
				
			end
			
		end
		
	end
	
	Mission.USSec = {}
		table.insert(Mission.USSec, FindEntity("Gettysburg"))
		table.insert(Mission.USSec, FindEntity("Kentucky"))
	
	Mission.USTransports = {}
		table.insert(Mission.USTransports, GenerateObject("Campbridge"))
		table.insert(Mission.USTransports, GenerateObject("Alexandria"))
	
	local spawnIdxTrans = luaRnd(1,2)
	local basesToCap = {}
	
	if spawnIdxTrans == 1 then
		
		--table.insert(basesToCap, FindEntity("HQ"))
		table.insert(basesToCap, FindEntity("CB3"))
		
	elseif spawnIdxTrans == 2 then
		
		--table.insert(basesToCap, FindEntity("HQ"))
		table.insert(basesToCap, FindEntity("CB2"))
		
	end
	
	for idx,unit in pairs(Mission.USTransports) do
		
		local spawnIdx = luaRnd(1,2)
		local moveX
		local moveY
	
		if spawnIdxTrans == 1 then
		
			moveX = -5500
			moveY = 0
			
		elseif spawnIdxTrans == 2 then
		
			moveX = 0
			moveY = 5500
			
		end
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
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
		
		NavigatorAttackMove(unit, luaPickRnd(basesToCap))
		
	end
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.USFleet[1], FindEntity("BBFleetPath"), PATH_FM_CIRCLE, pathDir)
	
	luaStartDialog("SPOTTED")
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 3, Mission.USTransports)
	luaObj_Add("primary", 4)
	luaObj_Add("secondary", 1, Mission.USSec)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.USTransports), "Destroy the invasion force!")
	
end

---- PHASE 1 ----

function luaSpawnHalsey()

	Mission.HalseyGang = {}
		table.insert(Mission.HalseyGang, GenerateObject("PossibleHalsey1"))
		table.insert(Mission.HalseyGang, GenerateObject("PossibleHalsey2"))
		table.insert(Mission.HalseyGang, GenerateObject("PossibleHalsey3"))
	
	for idx,unit in pairs(Mission.HalseyGang) do
		
		local moveX
		local moveY
		
		local spawnIdxTrans = luaRnd(1,2)
		
		if spawnIdxTrans == 1 then
		
			moveX = -4000
			moveY = 0
			
		elseif spawnIdxTrans == 2 then
		
			moveX = 0
			moveY = 4000
			
		end
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		local trgPos = {["x"] = -9000, ["y"] = 1000, ["z"] = 9000}
		
		PilotMoveTo(unit, trgPos)
		
	end
	
	Mission.Halsey = luaPickRnd(Mission.HalseyGang)
	
	luaObj_Add("hidden", 1)

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		trgs = Mission.JapFleet
		
	elseif Mission.Difficulty == 2 then
		
		trgs = Mission.JapTransports
		
	end
	
	return trgs
	
end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

function luaIntroMovie()

	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 2)
	
	local trg1 = FindEntity("Fortress 2")
	local trg2 = FindEntity("CB2")
	local trg3 = Mission.JapFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=0,["y"]=12,["z"]=-150},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-15,["y"]=25,["z"]=-150},["parent"] = trg1,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=10,["y"]=12,["z"]=150},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=0},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=35,["y"]=5,["z"]=0},["parent"] = trg2,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.JapFleet[1])
	
	EnableMessages(true)
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	if Mission.CanPlayBettyDia then
	
		luaStartDialog("BETTY")
	
	end
	
	luaDelay(luaAddFirstObjs, 3)

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.HQs)
	luaObj_Add("primary", 2, Mission.JapTransports)
	--luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTransports), "Protect your transports!")
	
	luaDelay(luaSpawnHalsey, random(150,400))
	
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
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "New Caledonia has been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Score, 1)
		
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