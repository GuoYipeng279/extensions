---- GERMAN MISSION #5 (KMS) ----

-- Scripted & Assembled by: Team Wolfpack

---- GERMAN MISSION #5 (KMS) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(134) 	-- Hurricane
	PrepareClass(109) 	-- Swordfish
	PrepareClass(336) 	-- Firefly
	
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
	
	LoadMessageMap("kmsdlg",5)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/KMS/kms_5.lua"

	this.Name = "KMS5"
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
				["Text"] = "Secure all enemy bases!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Prot",
				["Text"] = "Protect your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Key",
				["Text"] = "Destroy the enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Shoot",
				["Text"] = "Shoot down at least 100 enemy aircraft!",
				["TextCompleted"] = "You've shot down 100 enemy aircraft!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Capital",
				["Text"] = "Ensure the survival of all your capital ships!",
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
					["type"] = "pause",
					["time"] = 6,
				},
				--[[{
					["message"] = "INTRO2",
				},]]
				{
					["message"] = "INTRO3",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO4",
				},
				{
					["message"] = "INTRO5",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "INTRO6",
				},
			},
		},
		["HORNET"] = {--
			["sequence"] = {
				{
					["message"] = "HORNET1",
				},
			},
		},
		["STRIKE"] = {--
			["sequence"] = {
				{
					["message"] = "STRIKE1",
				},
				{
					["message"] = "STRIKE2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
			},
		},
		["SUBMARINE"] = {--
			["sequence"] = {
				{
					["message"] = "SUBMARINE1",
				},
				{
					["message"] = "SUBMARINE2",
				},
			},
		},
		["HOLED"] = {--
			["sequence"] = {
				{
					["message"] = "HOLED1",
				},
			},
		},
		["FORCES"] = {--
			["sequence"] = {
				{
					["message"] = "FORCES1",
				},
				{
					["message"] = "FORCES2",
				},
				{
					["message"] = "FORCES3",
				},
				{
					["message"] = "FORCES4",
				},
				{
					["message"] = "FORCES5",
				},
				{
					["message"] = "FORCES6",
				},
				{
					["message"] = "FORCES7",
				},
			},
		},
		["STATUS"] = {--
			["sequence"] = {
				{
					["message"] = "STATUS1",
				},
				{
					["message"] = "STATUS2",
				},
				{
					["message"] = "STATUS3",
				},
				{
					["message"] = "STATUS4",
				},
			},
		},
		["CARRIER"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "CARRIER2",
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
	
	Mission.Bismarck = FindEntity("Bismarck")
	Mission.Scharnhorst = FindEntity("Scharnhorst")
	Mission.GrafSpee = FindEntity("Admiral Graf Spee")
	Mission.GrafZeppelin = FindEntity("Graf Zeppelin")
	
	Mission.Transports = {}
	
	Mission.CVFleet = {}
		table.insert(Mission.CVFleet, Mission.Scharnhorst)
		table.insert(Mission.CVFleet, Mission.GrafZeppelin)
		table.insert(Mission.CVFleet, FindEntity("Z3"))
		table.insert(Mission.CVFleet, FindEntity("Z17"))
		table.insert(Mission.CVFleet, FindEntity("Z10"))
		--table.insert(Mission.CVFleet, FindEntity("Z11"))
		--table.insert(Mission.CVFleet, FindEntity("Z7"))
	
	for idx,unit in pairs(Mission.CVFleet) do
		
		JoinFormation(unit, Mission.CVFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		else
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.BismarckFleet = {}
		table.insert(Mission.BismarckFleet, Mission.Bismarck)
		table.insert(Mission.BismarckFleet, FindEntity("Mackensen"))
		table.insert(Mission.BismarckFleet, FindEntity("Z32"))
		table.insert(Mission.BismarckFleet, FindEntity("Z33"))
		--table.insert(Mission.BismarckFleet, FindEntity("Z34"))
		--table.insert(Mission.BismarckFleet, FindEntity("Z46"))
		table.insert(Mission.BismarckFleet, FindEntity("Bochus"))
		table.insert(Mission.BismarckFleet, FindEntity("Bielefeld"))
	
	for idx,unit in pairs(Mission.BismarckFleet) do
		
		JoinFormation(unit, Mission.BismarckFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		else
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	table.insert(Mission.Transports, FindEntity("Bochus"))
	table.insert(Mission.Transports, FindEntity("Bielefeld"))
	
	Mission.GFFleet = {}
		table.insert(Mission.GFFleet, Mission.GrafSpee)
		table.insert(Mission.GFFleet, FindEntity("Prinz Eugen"))
		table.insert(Mission.GFFleet, FindEntity("Z28"))
		table.insert(Mission.GFFleet, FindEntity("Z23"))
		--table.insert(Mission.GFFleet, FindEntity("Z21"))
		--table.insert(Mission.GFFleet, FindEntity("Z29"))
		table.insert(Mission.GFFleet, FindEntity("Hiddensee"))
		table.insert(Mission.GFFleet, FindEntity("Kassel"))
	
	for idx,unit in pairs(Mission.GFFleet) do
		
		JoinFormation(unit, Mission.GFFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		else
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	table.insert(Mission.Transports, FindEntity("Hiddensee"))
	table.insert(Mission.Transports, FindEntity("Kassel"))
	
	Mission.CapitalShips = {}
		table.insert(Mission.CapitalShips, Mission.Bismarck)
		table.insert(Mission.CapitalShips, Mission.Scharnhorst)
		table.insert(Mission.CapitalShips, Mission.GrafSpee)
		table.insert(Mission.CapitalShips, Mission.GrafZeppelin)
		table.insert(Mission.CapitalShips, FindEntity("Bochus"))
		table.insert(Mission.CapitalShips, FindEntity("Bielefeld"))
		table.insert(Mission.CapitalShips, FindEntity("Hiddensee"))
		table.insert(Mission.CapitalShips, FindEntity("Kassel"))
	
	Mission.GermanShips = luaSumTablesIndex(Mission.CVFleet, Mission.BismarckFleet, Mission.GFFleet)
	
	Mission.AyeYo = {}
		table.insert(Mission.AyeYo, Mission.Bismarck)
		table.insert(Mission.AyeYo, Mission.Scharnhorst)
		table.insert(Mission.AyeYo, Mission.GrafSpee)
		table.insert(Mission.AyeYo, Mission.GrafZeppelin)
	
	Mission.MoviePlanes = {}
	
	---- GB ----
	
	Mission.Targeteers = {}
	Mission.Bombers = {}
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ1"))
		table.insert(Mission.HQs, FindEntity("HQ2"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
		table.insert(Mission.Airfields, FindEntity("Airfield4"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, true)
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
	end
	
	Mission.KGVFleet = {}
		table.insert(Mission.KGVFleet, FindEntity("King George V"))
		table.insert(Mission.KGVFleet, FindEntity("Renown"))
		table.insert(Mission.KGVFleet, FindEntity("Defender"))
		table.insert(Mission.KGVFleet, FindEntity("Delight"))
		
	local move = luaRnd(-2000, 8000)
	
	for idx,unit in pairs(Mission.KGVFleet) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + move
		
		PutTo(unit, pos)
		
		if not Mission.Blyaaat then
		
			pos.y = 1000
			
			PutTo(FindEntity("Hurricane"), pos)
			
			SetSkillLevel(FindEntity("Hurricane"), Mission.SkillLevel)
			
			PilotMoveToRange(FindEntity("Hurricane"), unit)
			
			Mission.Blyaaat = true
		
		end
		
		JoinFormation(unit, Mission.KGVFleet[1])
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
	
	table.insert(Mission.Targeteers, FindEntity("King George V"))
	
	Mission.Subs = {}
		table.insert(Mission.Subs, FindEntity("Unbeaten"))
		table.insert(Mission.Subs, FindEntity("Urchin"))
	
	for idx,unit in pairs(Mission.Subs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
			SetUnlimitedAirSupply(unit, true)
			
		end
		
		table.insert(Mission.Targeteers, unit)
		
	end
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy") or string.find(unit.Name, "Light") or string.find(unit.Name, "Coastal") or string.find(unit.Name, "Fortress")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.LeftMovingCargos = {}
		table.insert(Mission.LeftMovingCargos, FindEntity("Cargo-01"))
		table.insert(Mission.LeftMovingCargos, FindEntity("Cargo-02"))
		table.insert(Mission.LeftMovingCargos, FindEntity("Cargo-03"))
		
	for idx,unit in pairs(Mission.LeftMovingCargos) do
		
		JoinFormation(unit, Mission.LeftMovingCargos[1])
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
	
	Mission.RightMovingCargos = {}
		table.insert(Mission.RightMovingCargos, FindEntity("Cargo-04"))
		table.insert(Mission.RightMovingCargos, FindEntity("Cargo-05"))
		
	for idx,unit in pairs(Mission.RightMovingCargos) do
		
		JoinFormation(unit, Mission.RightMovingCargos[1])
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
	
	Mission.MovingCargos = luaSumTablesIndex(Mission.LeftMovingCargos, Mission.RightMovingCargos)
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.BomberDelay = 300
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		--Mission.BomberDelay = 300
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		--Mission.BomberDelay = 250
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		--Mission.BomberDelay = 200
		
	end
	
	---- INIT FUNCT. ----
	
	SetSkillLevel(FindEntity("Firefly"), Mission.SkillLevel)
	PilotSetTarget(FindEntity("Firefly"), luaPickRnd(luaRemoveDeadsFromTable(Mission.GermanShips)))
	
	NavigatorMoveToRange(Mission.LeftMovingCargos[1], FindEntity("LeftConvoyGoTo"))
	NavigatorMoveToRange(Mission.RightMovingCargos[1], FindEntity("RightConvoyGoTo"))
	
	EnableMessages(false)
	
	MissionNarrative("September 16th, 1943 - Off the British Coast")
	
	Blackout(true, "", true)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--luaMoveToPh2()
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh2, 70)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("RightConvoyGoTo"))
	
	--luaShowPath(FindEntity("CVPath"))
	
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
			
			if luaObj_IsActive("primary", 1) then
				
				local capped = 0
				local allied = 4
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						allied = allied - 1
						
					elseif unit.Party == PARTY_NEUTRAL then
					
						allied = allied - 1
						
					end
				
				end
				
				if capped == 4 then
					
					Mission.Capped = true
					
					Mission.BasesLeft = 4
					
				else
					
					if allied == 0 and not Mission.CVsHere then
					
						luaMoveToPh2()
					
					end
					
					Mission.Capped = false
					
					Mission.BasesLeft = capped
					
					if not Mission.AshoreDiaPlayed then
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
							
							if unit.Party == PARTY_ALLIED or unit.Party == PARTY_NEUTRAL then
							
								local cap = GetCapturePercentage(unit)
								
								if cap > 0 then
								
									luaStartDialog("FORCES")
									
									Mission.AshoreDiaPlayed = true
								
								end
							
							end
							
						end
						
					end
					
					if not Mission.StatusDiaPlayed then
					
						if capped >= 2 then
						
							luaStartDialog("STATUS")
							
							Mission.StatusDiaPlayed = true
						
						end
					
					end
					
				end
				
				local line1 = "Secure all enemy bases!"
				local line2 = "Enemy base(s) captured: #Mission.BasesLeft#"
				luaDisplayScore(1, line1, line2)
				
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Transports)) == 0 then
				
					luaMissionFailed()
				
				else
				
					if not Mission.MaydayDiaPlayed then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.GermanShips)) <= 16 then
							
							luaStartDialog("HOLED")
							
							Mission.MaydayDiaPlayed = true
						
						end
					
					end
				
				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.BritRein)) == 0 then
					
					luaObj_Completed("primary", 3, true)
					
					Mission.Destroyed = true
				
				end
				
			end
			
			if Mission.Capped and Mission.Destroyed then
			
				luaMissionComplete()
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 100 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.AyeYo)) == 0 then
					
					luaObj_Failed("hidden",1)
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Targeteers)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Targeteers)) do
				
					if unit and not unit.Dead then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
							local trgs = Mission.GermanShips
							
							if Mission.Difficulty == 2 then
							
								trgs = Mission.Transports
							
							else
							
								if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) > 0 then
								
									trgs = Mission.CapitalShips
								
								end
							
							end
							
							local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
							local closest = ordered[1]
							
							luaSetScriptTarget(unit, closest)
							NavigatorAttackMove(unit, closest)
						
						end
						
					end
				
				end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
				
					if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
						
						local fighters = {
							[1] = 134,
						}
						local bombers = {
							[1] = 109,
							[2] = 336,
						}
						
						local wngCount = 3
						
						--[[if Mission.Difficulty == 0 then
							
							wngCount = 3
							--heavyBomber = false
						
						elseif Mission.Difficulty == 1 then
							
							wngCount = 4
							--heavyBomber = true
						
						elseif Mission.Difficulty == 2 then
							
							wngCount = 5
							--heavyBomber = true
						
						end]]
						
						local trgs = Mission.GermanShips
						
						if Mission.Difficulty == 2 then
						
							trgs = Mission.Transports
						
						else
						
							if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) > 0 then
							
								trgs = Mission.CapitalShips
							
							end
						
						end
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs), nil, wngCount)
						
					end
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Bombers)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Bombers)) do
				
					if unit and not unit.Dead then
						
						local ammo = GetProperty(unit, "ammoType")
						
						if ammo ~= 0 then
						
							if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
								
								local trgs = Mission.GermanShips
								
								if Mission.Difficulty == 2 then
								
									trgs = Mission.Transports
								
								else
								
									if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) > 0 then
									
										trgs = Mission.CapitalShips
									
									end
								
								end
								
								local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
								local closest = ordered[1]
								
								luaSetScriptTarget(unit, closest)
								NavigatorAttackMove(unit, closest)
							
							end
						
						end
						
					end
				
				end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.MovingCargos)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MovingCargos)) do
					
					if unit and not unit.Dead then
						
						local untPos = GetPosition(unit)
						
						if IsInBorderZone(untPos) then
						
							Kill(unit, true)
						
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

function luaMoveToPh2()
	
	Mission.CVsHere = true
	
	local spawnIdx = luaRnd(1,2)
	local moveX
	local moveY
	local rot
	
	if spawnIdx == 1 then
	
		moveX = 9000
		moveY = 2000
		rot = 90
	
	else
	
		moveX = -9000
		moveY = -4800
		rot = -90
	
	end
	
	Mission.Illustrious = GenerateObject("Illustrious")
	--Mission.Formidable = GenerateObject("Formidable")
	Mission.ArkRoyal = GenerateObject("Ark Royal")
	
	Mission.BritCVFleet = {}
		table.insert(Mission.BritCVFleet, Mission.Illustrious)
		--table.insert(Mission.BritCVFleet, Mission.Formidable)
		table.insert(Mission.BritCVFleet, Mission.ArkRoyal)
		table.insert(Mission.BritCVFleet, GenerateObject("Dorsetshire"))
		table.insert(Mission.BritCVFleet, GenerateObject("Northumberland"))
		--table.insert(Mission.BritCVFleet, GenerateObject("Gambia"))
		--table.insert(Mission.BritCVFleet, GenerateObject("Bermuda"))
		--table.insert(Mission.BritCVFleet, GenerateObject("Daring"))
		--table.insert(Mission.BritCVFleet, GenerateObject("Duchess"))
		table.insert(Mission.BritCVFleet, GenerateObject("Desperate"))
		table.insert(Mission.BritCVFleet, GenerateObject("Desire"))
	
	for idx,unit in pairs(Mission.BritCVFleet) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos, rot)
		
		JoinFormation(unit, Mission.BritCVFleet[1])
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
	
	table.insert(Mission.Airfields, Mission.Illustrious)
	--table.insert(Mission.Airfields, Mission.Formidable)
	table.insert(Mission.Airfields, Mission.ArkRoyal)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
	
		if unit and not unit.Dead then
		
			if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 3)
				
			end
		
		end
	
	end
	
	Mission.QueenElizabeth = GenerateObject("Queen Elizabeth")
	Mission.Warspite = GenerateObject("Warspite")
	
	Mission.BritBBFleet = {}
		table.insert(Mission.BritBBFleet, Mission.QueenElizabeth)
		table.insert(Mission.BritBBFleet, Mission.Warspite)
		table.insert(Mission.BritBBFleet, GenerateObject("Devonshire"))
		--table.insert(Mission.BritBBFleet, GenerateObject("Sussex"))
		table.insert(Mission.BritBBFleet, GenerateObject("Gloucester"))
		--table.insert(Mission.BritBBFleet, GenerateObject("Sheffield"))
		--table.insert(Mission.BritBBFleet, GenerateObject("Diamond"))
		--table.insert(Mission.BritBBFleet, GenerateObject("Decoy"))
	
	for idx,unit in pairs(Mission.BritBBFleet) do
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos, rot)
		
		JoinFormation(unit, Mission.BritBBFleet[1])
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
	
	Mission.BritRein = luaSumTablesIndex(Mission.BritCVFleet, Mission.BritBBFleet)
	
	table.insert(Mission.Targeteers, Mission.BritBBFleet[1])
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.BritCVFleet[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	--[[if Mission.Difficulty > 0 then
	
		local fighter1 = GenerateObject("Hurricane_1")
		local fighter2 = GenerateObject("Hurricane_2")
		
		local pos1 = GetPosition(fighter1)
		pos1.x = pos1.x + moveX
		pos1.y = 1000
		pos1.z = pos1.z + moveY
		local pos2 = GetPosition(fighter2)
		pos2.x = pos2.x + moveX
		pos2.y = 1000
		pos2.z = pos2.z + moveY
		
		PutTo(fighter1, pos1, rot)
		PutTo(fighter2, pos2, rot)
		
		SetSkillLevel(fighter1, Mission.SkillLevel)
		SetSkillLevel(fighter2, Mission.SkillLevel)
		
		PilotMoveToRange(fighter1, Mission.QueenElizabeth)
		PilotMoveToRange(fighter2, Mission.Warspite)
		
	end]]
	
	luaDelay(luaBBDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.BritCVFleet[1]
	local trg2 = Mission.BritBBFleet[1]
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 400, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 7, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 400, ["theta"] = 10, ["rho"] = -45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 10, ["rho"] = -15, ["moveTime"] = 7, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 10, ["rho"] = -15, ["moveTime"] = 1, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  
	}, luaPh2MovieEnd, true)
	
end

function luaBBDia()

	luaStartDialog("CARRIER")

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.GermanShips)))
	
	end
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 3, Mission.BritRein)

end

---- PHASE 1 ----

function luaHidePh2Score()

	HideScoreDisplay(2,0)

end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

function luaBomberFlow()

	if not Mission.EndMission then
		
		local spawnIdx = luaRnd(1,3)
		local name
		
		if spawnIdx == 1 then
		
			name = "B-24 01"
		
		elseif spawnIdx == 2 then
		
			name = "B-24 02"
		
		elseif spawnIdx == 3 then
		
			name = "B-24 03"
		
		end
		
		local catalina = GenerateObject(name)
		
		SetSkillLevel(catalina, Mission.SkillLevel)
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CapitalShips))
		
		--PilotSetTarget(catalina, trg)
		
		table.insert(Mission.Bombers, catalina)
		
		luaDelay(luaBomberFlow, Mission.BomberDelay)
		
	end

end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 3)
	luaDelay(luaIntroPlanes, 18)
	
	local trg1 = FindEntity("Graf Zeppelin")
	local trg2 = FindEntity("Hiddensee")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=8445,["y"]=7,["z"]=-4980},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=8345,["y"]=6,["z"]=-5035},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=8345,["y"]=6,["z"]=-5035},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=8445,["y"]=9,["z"]=-4960},["parent"] = nil,},["moveTime"] = 14,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=11.5,["y"]=7.5,["z"]=80},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=11.5,["y"]=7.5,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=7,["y"]=7.5,["z"]=0},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 100, ["theta"] = 5, ["rho"] = 155, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 155, ["moveTime"] = 8},
	    {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 155, ["moveTime"] = 4},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroPlanes()

	if Mission.MissionPhase < 1 then
	
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane1"))
		
		SquadronSetTravelAlt(Mission.MoviePlanes[1], 70, true)
		
		PilotMoveToRange(Mission.MoviePlanes[1], FindEntity("MoviePlaneGoTo"))
	
	end

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.MoviePlanes)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MoviePlanes)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.BismarckFleet[1])
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	if Mission.Difficulty < 2 then
		
		local submarine = GenerateObject("U-530")
		
		SetSkillLevel(submarine, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(submarine, true)
		NavigatorSetAvoidLandCollision(submarine, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(submarine, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(submarine, false)
		
		end
		
		SetForcedReconLevel(submarine, 2, PARTY_ALLIED)
		
		luaStartDialog("HORNET")
		
	end
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.HQs)
	luaObj_Add("primary", 2, Mission.Transports)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Transports), "Protect your transports!")
	
	luaAddSubListener()
	luaAddPlaneListener()
	luaBomberFlow()
	
end

function luaAddSecObjs()

	luaObj_Add("secondary", 1)

end

---- LISTENERS ----

function luaAddPlaneListener()

	AddListener("recon", "PlaneListener", {
		["callback"] = "luaPlaneSighted",
		["entity"] = {FindEntity("Firefly")},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddSubListener()

	AddListener("recon", "SubListener", {
		["callback"] = "luaSubSighted",
		["entity"] = Mission.Subs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaPlaneSighted()
	
	RemoveListener("recon", "PlaneListener")
	
	luaStartDialog("STRIKE")
	
end

function luaSubSighted()
	
	RemoveListener("recon", "SubListener")
	
	luaStartDialog("SUBMARINE")
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	Mission.EndMission = true
	
	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Score, 1)
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh2Score, 1)
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "The landings are successful - Mission Complete")
	
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
		
		luaDelay(luaHidePh2Score, 1)
		
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