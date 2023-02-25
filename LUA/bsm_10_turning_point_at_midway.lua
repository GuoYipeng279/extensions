---- TURNING POINT AT MIDWAY (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- TURNING POINT AT MIDWAY (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(162) -- Kate
	
	PrepareClass(133) -- Buffalo
	
	PrepareClass(224) -- Jap Troop Transport
	PrepareClass(50) -- Akagi
	PrepareClass(51) -- Kaga
	PrepareClass(90) -- Daihatsu
	
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
	
	LoadMessageMap("bsmdlg",10)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_10_turning_point_at_midway.lua"

	this.Name = "BSM10"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Repel",
				["Text"] = "Repel the air raid!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Trans",
				["Text"] = "Destroy the transport ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Locate",
				["Text"] = "Locate and destroy the Japanese carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Yorktown",
				["Text"] = "Yorktown must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
		},
		["hidden"] = {
			[1] = {
				["ID"] = "DD",
				["Text"] = "Destroy the transport ships before they launch landing boats!",
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
		["INTRO"] = {
			["sequence"] = {
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovieEnd",
				},
			},
		},
		["STRIKE"] = {
			["sequence"] = {
				{
					["message"] = "STRIKE1",
				},
				{
					["message"] = "STRIKE2",
				},
			},
		},
		["WAVE"] = {
			["sequence"] = {
				{
					["message"] = "WAVE1",
				},
				{
					["message"] = "WAVE2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMoveToPh2",
				},
			},
		},
		["RUNWAY1DEAD"] = {
			["sequence"] = {
				{
					["message"] = "RUNWAY1DEAD1",
				},
				{
					["message"] = "RUNWAY1DEAD2",
				},
			},
		},
		["RUNWAY2DEAD"] = {
			["sequence"] = {
				{
					["message"] = "RUNWAY2DEAD1",
				},
				{
					["message"] = "RUNWAY2DEAD2",
				},
			},
		},
		["SHIPYARDDEAD"] = {
			["sequence"] = {
				{
					["message"] = "SHIPYARDDEAD1",
				},
			},
		},
		["INVASION"] = {
			["sequence"] = {
				{
					["message"] = "INVASION1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddPh2Objs",
				},
			},
		},
		["LANDING"] = {
			["sequence"] = {
				{
					["message"] = "LANDING1",
				},
				{
					["message"] = "LANDING2",
				},
			},
		},
		["LANDED"] = {
			["sequence"] = {
				{
					["message"] = "LANDED1",
				},
			},
		},
		["BREAKING"] = {
			["sequence"] = {
				{
					["message"] = "BREAKING1",
				},
			},
		},
		["CARRIERS"] = {
			["sequence"] = {
				{
					["message"] = "CARRIERS1",
				},
				{
					["message"] = "CARRIERS2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddCVObjs",
				},
			},
		},
		["BURNING"] = {
			["sequence"] = {
				{
					["message"] = "BURNING1",
				},
				{
					["message"] = "BURNING2",
				},
			},
		},
		["GOOD"] = {
			["sequence"] = {
				{
					["message"] = "GOOD1",
				},
				{
					["message"] = "GOOD2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddYorkObjs",
				},
			},
		},
		["DMG"] = {
			["sequence"] = {
				{
					["message"] = "DMG1",
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
		Mission.SkillLevel = SKILL_SPVETERAN
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
	
	---- USN ----
	
	Mission.Airfield1 = FindEntity("Airfield")
	Mission.Airfield2 = FindEntity("Airfield 2")
	Mission.Shipyard = FindEntity("Shipyard")
	Mission.RadarStation = FindEntity("RadarStation")
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, Mission.Airfield1)
		table.insert(Mission.Airfields, Mission.Airfield2)
	
	---- IJN ----
	
	Mission.IntroUnits = {}
		table.insert(Mission.IntroUnits, FindEntity("IntroZero"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_2"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_3"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_4"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_5"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_6"))
		table.insert(Mission.IntroUnits, FindEntity("IntroVal_7"))
		table.insert(Mission.IntroUnits, FindEntity("IntroCatalina"))
		
	for key, value in pairs(Mission.IntroUnits) do

		if key < table.getn(Mission.IntroUnits) then

			PilotMoveTo(value, Mission.Airfield1)
			
		else

			local tRefPos = luaMoveCoordinate(GetPosition(value), 10000, luaGetRotation(value))
			
			PilotMoveTo(value, tRefPos)
			
		end

		SquadronSetTravelAlt(value, GetPosition(value).y)
		SquadronSetTravelSpeed(value, 300)
		
	end
	
	Mission.JapCVTrgs = {}
		table.insert(Mission.JapCVTrgs, Mission.Airfield1)
		table.insert(Mission.JapCVTrgs, Mission.Airfield2)
		table.insert(Mission.JapCVTrgs, Mission.Shipyard)
	
	Mission.JapStrikeGang = {}
	Mission.JapValGang = {}
	Mission.LandingBoats = {}
	
	---- VAR ----
	
	Mission.LandingStartPoint =
	{
		["x"] = 1567,
		["y"] = 0,
		["z"] = -2727
	}
	
	Mission.GenPos =
	{
		[1] = 	-- left front
		{["x"]=-30,["y"]=0,["z"]=-20},
		[2] = 	-- left back
		{["x"]=30,["y"]=0,["z"]=-20},
		[3] = 	-- right front
		{["x"]=30,["y"]=0,["z"]=30},
		[4] = 	-- right back
		{["x"]=-30,["y"]=0,["z"]=0}
	}
	
	Mission.LandingPaths = {}
		table.insert(Mission.LandingPaths, FindEntity("path_landing1"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing2"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing3"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing4"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing5"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing6"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing7"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing8"))
		table.insert(Mission.LandingPaths, FindEntity("path_landing9"))
	
	Mission.LandingPathNum = table.getn(Mission.LandingPaths)
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.AirRaidWaves = 0
	Mission.LCVPsOut = 0
	Mission.NextFreighter = 1
	Mission.NextLandingPathNum = 1
	Mission.BoatsLanded = 0
	Mission.ListenerTracker = 0
	Mission.NextPos = 1
	Mission.AirStrikeSpawnAllowed = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	Blackout(true, "", true)
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	MissionNarrative("May 31st, 1942 - Midway Island")
	
	luaIntroMovie1()
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--Mission.Debug = true
	
	if Mission.Debug then
	
		SetInvincible(Mission.Airfield1, 0.4)
		SetInvincible(Mission.Airfield2, 0.4)
	
	end
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh2, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
	--luaMoveToPh2()
	
end

---- THINK ----

function lua_Think(this, msg)

	if luaMessageHandler (this, msg) == "killed" then
		
		return
		
	end

	if Mission.EndMission then
	
		return
	
	end
	
	if Mission.IntroOver then
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
		if Mission.Airfield1.Dead and not Mission.Airfield1DiaPlayed then
		
			luaStartDialog("RUNWAY1DEAD")
			
			Mission.Airfield1DiaPlayed = true
			
		end
		
		if Mission.Airfield2.Dead and not Mission.Airfield2DiaPlayed then
		
			luaStartDialog("RUNWAY2DEAD")
			
			Mission.Airfield2DiaPlayed = true
			
		end
		
		if Mission.Shipyard.Dead and not Mission.ShipyardDiaPlayed then
		
			luaStartDialog("SHIPYARDDEAD")
			
			Mission.ShipyardDiaPlayed = true
			
		end
		
		if Mission.Airfield1.Dead and Mission.Airfield2.Dead and Mission.Shipyard.Dead then
		
			if luaObj_IsActive("primary", 1) then
			
				HideScoreDisplay(1,0)
			
			elseif luaObj_IsActive("primary", 2) then
			
				HideScoreDisplay(2,0)
			
			elseif luaObj_IsActive("primary", 3) then
			
				HideScoreDisplay(3,0)
			
			end
			
			if Mission.YorktownHere then
			
				HideUnitHP()
			
			end
			
			luaMissionFailed(luaPickRnd(Mission.JapCVTrgs))
			
		end
		
	end
	
	if Mission.MissionPhase == 1 then
	
		if Mission.AirRaidWaves < 3 then
		
			if Mission.AirStrikeSpawnAllowed or (table.getn(luaRemoveDeadsFromTable(Mission.JapStrikeGang)) == 0 and Mission.CanCheckForPlanes) then
			
				luaSpawnNextStrikeWave()
			
				Mission.AirRaidWaves = Mission.AirRaidWaves + 1
				Mission.CanCheckForPlanes = false
				Mission.AirStrikeSpawnAllowed = false
				
				luaDelay(luaCheckAllow, 3)
				luaDelay(luaAirRaidAllow, 155)
				
				if Mission.AirRaidWaves == 3 then
				
					luaDelay(luaPhaseMoveAllow, 230)
				
				end
				
			end
			
		else
		
			if Mission.CanMoveToPh2 or table.getn(luaRemoveDeadsFromTable(Mission.JapStrikeGang)) == 0 then
			
				HideScoreDisplay(1,0)
			
				luaObj_Completed("primary", 1)
				
				luaStartDialog("WAVE")
			
			end
			
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapValGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapValGang)) do
			
				if unit and not unit.Dead then
					
					local ammo = GetProperty(unit, "ammoType")
			
					if ammo == 1 then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						
							local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVTrgs))
							
							if trg and not trg.Dead then
							
								luaSetScriptTarget(unit, trg)
								PilotSetTarget(unit, trg)
								
							end
						
						end
					
					else
					
						if not unit.retreating then
						
							PilotRetreat(unit)
							
							unit.retreating = true
						
						end
					
					end
					
				end
				
			end
		
		end
		
	elseif Mission.MissionPhase == 2 then
		
		if luaObj_IsActive("primary", 2) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapCargos)) == 0 then
				
				if Mission.LandingsDead then
					
					HideScoreDisplay(2,0)
				
					luaObj_Completed("primary", 2)
					
					if not Mission.LandingsStarted and luaObj_IsActive("hidden", 1) then
					
						luaObj_Completed("hidden", 1)
					
					end
					
					luaMoveToPh3()
				
				end
			
			else
				
				Mission.TransNum = table.getn(luaRemoveDeadsFromTable(Mission.JapCargos))
				
				local line1 = "Destroy the transport ships!"
				local line2 = "Transport ship(s) left to sink: #Mission.TransNum#"
				luaDisplayScore(2, line1, line2)
				
				if Mission.LandingsStarted then
					
					if Mission.LCVPsOut < 8 then
						
						luaSpawnLCVP()
						
						Mission.LCVPsOut = Mission.LCVPsOut + 1
						
						--luaDelay(luaDecrementLCVPs, 80)
						
					end
					
					if Mission.BoatsLanded >= 1 and not Mission.FirstFightingDiaPlayed then
					
						luaStartDialog("LANDED")
						
						Mission.FirstFightingDiaPlayed = true
					
					end
					
					if Mission.BoatsLanded >= 6 and not Mission.SecondFightingDiaPlayed then
					
						luaStartDialog("BREAKING")
						
						Mission.SecondFightingDiaPlayed = true
					
					end
					
					if Mission.BoatsLanded >= 7 then
						
						HideScoreDisplay(2,0)
						
						luaMissionFailed(luaPickRnd(luaRemoveDeadsFromTable(Mission.LandingBoats)))
					
					end
					
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.LandingBoats)) > 0 then
				
				Mission.LandingsDead = false
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LandingBoats)) do
				
					if unit and not unit.Dead then
						
						if luaGetDistance(unit, unit.landingPoint) <= 50 and not unit.discounted then
						
							Mission.BoatsLanded = Mission.BoatsLanded + 1
							
							unit.discounted = true
						
						end
					
					end
				
				end
			
			else
			
				Mission.LandingsDead = true
			
			end
			
		end
		
	elseif Mission.MissionPhase == 3 then
		
		if luaObj_IsActive("primary", 3) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapCVs)) == 0 then
			
				HideScoreDisplay(3,0)
				HideUnitHP()
				
				luaObj_Completed("primary", 3)
				
				luaMissionComplete(luaPickRnd(Mission.JapCVs))
				
			else
				
				Mission.JapCVs = luaRemoveDeadsFromTable(Mission.JapCVs)
				
				Mission.CVNum = table.getn(luaRemoveDeadsFromTable(Mission.JapCVs))
				
				local line1 = "Locate and destroy the Japanese carriers!"
				local line2 = "Carrier(s) left to sink: #Mission.CVNum#"
				luaDisplayScore(3, line1, line2)
				
				local fighter = {
					[1] = 150,
				}
				
				local bombers
				
				if Mission.YorktownHere and not Mission.Yorktown.Dead then
				
					bombers = {
						[1] = 158,
						[2] = 162,
					}
				
				else
				
					bombers = {
						[1] = 158,
						[2] = 158,
					}
				
				end
				
				if not Mission.Akagi.Dead then
				
					luaAirfieldManager(Mission.Akagi, fighter, bombers, Mission.JapCVTrgs)
				
				else
					
					if not Mission.Mr then
					
						Mission.AkagiDead = true
						
						if not Mission.OneCVDeadDiaPlayed then
						
							luaStartDialog("BURNING")
							
							Mission.OneCVDeadDiaPlayed = true
						
						end
						
						Mission.Mr = true
						
					end
					
				end
				
				if not Mission.Kaga.Dead then
				
					luaAirfieldManager(Mission.Kaga, fighter, bombers, Mission.JapCVTrgs)
				
				else
				
					if not Mission.Bullseye then
					
						Mission.KagaDead = true
						
						if not Mission.OneCVDeadDiaPlayed then
						
							luaStartDialog("BURNING")
							
							Mission.OneCVDeadDiaPlayed = true
						
						end
						
						Mission.Bullseye = true
						
					end
				
				end
			
			end
		
		end
		
		if luaObj_IsActive("primary", 4) then
			
			if Mission.Yorktown.Dead then
			
				HideScoreDisplay(3,0)
				HideUnitHP()
				
				luaMissionFailed(Mission.Yorktown)
				
			else
			
				if GetHpPercentage(Mission.Yorktown) < 0.25 and not Mission.YorkLowDiaPlayed then
					
					luaStartDialog("DMG")
					
					Mission.YorkLowDiaPlayed = true
				
				end
				
			end
		
		end
		
	end
	
	---- TEST ----
	
	--Mission.MissionPhase = 2
	
end

---- PHASE 3 ----

function luaMoveToPh3()
	
	Loading_Start()
	
	Mission.MissionPhase = 3
	
	Mission.Akagi = GenerateObject("Akagi")
	Mission.Kaga = GenerateObject("Kaga")
	local japEsc1 = GenerateObject("Hamakaze")
	local japEsc2 = GenerateObject("Kazegumo")
	local japEsc3 = GenerateObject("Makikumo")
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, Mission.Akagi)
		table.insert(Mission.JapGang, Mission.Kaga)
		table.insert(Mission.JapGang, japEsc1)
		table.insert(Mission.JapGang, japEsc2)
		table.insert(Mission.JapGang, japEsc3)
	
	for idx,unit in pairs(Mission.JapGang) do
		
		JoinFormation(unit, Mission.JapGang[2])
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
	
	Mission.JapCVs = {}
		table.insert(Mission.JapCVs, Mission.Akagi)
		table.insert(Mission.JapCVs, Mission.Kaga)
	
	for idx,unit in pairs(Mission.JapCVs) do
	
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 4)
			
		end
	
	end
	
	NavigatorMoveOnPath(Mission.Kaga, FindEntity("path_japcarriers"), PATH_FM_CIRCLE)
	
	if table.getn(luaRemoveDeadsFromTable(Mission.JapCargosEsc)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapCargosEsc)) do
			
			if unit and not unit.Dead then
			
				JoinFormation(unit, Mission.JapGang[2])
				
			end
			
		end
	
	end
	
	Loading_Finish()
	
	luaPlayMovie2()
	
	luaStartDialog("CARRIERS")
	
	luaDelay(luaSpawnYorktown, 300)
	
end

function luaAddCVObjs()

	luaObj_Add("primary", 3, Mission.JapCVs)

end

function luaSpawnYorktown()

	Mission.YorktownHere = true
	
	Mission.Yorktown = GenerateObject("Yorktown")
	local yorkEsc1 = GenerateObject("Hammann")
	local yorkEsc2 = GenerateObject("Russell")
	
	Mission.YorkGang = {}
		table.insert(Mission.YorkGang, Mission.Yorktown)
		table.insert(Mission.YorkGang, yorkEsc1)
		table.insert(Mission.YorkGang, yorkEsc2)
	
	for idx,unit in pairs(Mission.YorkGang) do
		
		JoinFormation(unit, Mission.YorkGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	table.insert(Mission.JapCVTrgs, Mission.Yorktown)
	
	Mission.no = {}
		table.insert(Mission.no, Mission.Yorktown)
	
	luaPlayMovie3()
	
	luaDelay(luaYorkDia, 2)
	
end

function luaYorkDia()

	luaStartDialog("GOOD")

end

function luaAddYorkObjs()

	luaObj_Add("primary", 4, Mission.Yorktown)
	
	DisplayUnitHP((Mission.no), "Yorktown must survive!")

end

---- PHASE 2 ----

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	if table.getn(luaRemoveDeadsFromTable(Mission.JapStrikeGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapStrikeGang)) do
		
			if unit and not unit.Dead then
				
				Kill(unit, true)
				
			end
			
		end
	
	end
	
	local cargo1 = GenerateObject("Kinugasa Maru")
	local cargo2 = GenerateObject("Okinoshima")
	local cargo3 = GenerateObject("Magane Maru")
	local cargo4 = GenerateObject("Sata")
	local dd1 = GenerateObject("Arashi")
	local dd2 = GenerateObject("Amagiri")
	
	Mission.JapInvasion = {}
		table.insert(Mission.JapInvasion, cargo1)
		table.insert(Mission.JapInvasion, cargo2)
		table.insert(Mission.JapInvasion, cargo3)
		table.insert(Mission.JapInvasion, cargo4)
		table.insert(Mission.JapInvasion, dd1)
		table.insert(Mission.JapInvasion, dd2)
	
	Mission.JapCargos = {}
		table.insert(Mission.JapCargos, cargo1)
		table.insert(Mission.JapCargos, cargo2)
		table.insert(Mission.JapCargos, cargo3)
		table.insert(Mission.JapCargos, cargo4)
		
	Mission.JapCargosEsc = {}
		table.insert(Mission.JapCargosEsc, dd1)
		table.insert(Mission.JapCargosEsc, dd2)
		
	Mission.JapTmpCargos = {}
		table.insert(Mission.JapTmpCargos, cargo1)
		table.insert(Mission.JapTmpCargos, cargo2)
		table.insert(Mission.JapTmpCargos, cargo3)
		table.insert(Mission.JapTmpCargos, cargo4)
	
	for idx,unit in pairs(Mission.JapInvasion) do
		
		JoinFormation(unit, Mission.JapInvasion[1])
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
	
	for idx,unit in pairs(Mission.JapCargos) do
	
		luaCheckDistance(unit, Mission.LandingStartPoint, 1900, luaFreightersArrived)
		
	end
	
	NavigatorMoveToRange(Mission.JapCargos[1], Mission.LandingStartPoint)
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaDelay(luaInvasionDia, 1)
	
end

function luaInvasionDia()

	luaStartDialog("INVASION")

end

function luaAddPh2Objs()

	luaObj_Add("primary", 2, Mission.JapCargos)
	
	luaObj_Add("hidden", 1)

end

function luaFreightersArrived()
	
	if luaObj_IsActive("hidden", 1) then
	
		luaObj_Failed("hidden", 1)
	
	end
	
	if not Mission.LandingsStarted then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCargos)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapCargos)) do
				
				if unit and not unit.Dead then
				
					NavigatorStop(unit)
				
				end
				
			end
			
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JapCargosEsc)) > 0 then
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapCargosEsc)) do
				
				if unit and not unit.Dead then
				
					LeaveFormation(unit)
					
					NavigatorMoveToRange(unit, Mission.LandingStartPoint)
					
					UnitFreeAttack(unit)
					
				end
				
			end
		
		end
		
		--[[for i = 1,8 do
		
			luaSpawnLCVP()
		
		end]]
		
		Mission.LandingsStarted = true
		
	end
	
	if not next(Mission.JapTmpCargos) then
		
		return
		
	end
	
	luaClearCheckDistance(Mission.JapTmpCargos[1], Mission.LandingStartPoint)
	
	table.remove(Mission.JapTmpCargos, 1)
	
	luaDelay(luaFreightersArrived, 0.22)

end

function luaSpawnLCVP()

	Mission.JapCargos = luaRemoveDeadsFromTable(Mission.JapCargos)
	local freighterNum = table.getn(Mission.JapCargos)
	
	if freighterNum == 0 then
		
		return
		
	end
	
	local boat = GenerateObject("Daihatsu")
	
	NavigatorSetAvoidLandCollision(boat, false)
	
	if Mission.NextFreighter > freighterNum then
	
		Mission.NextFreighter = 1
		
	end
	
	if Mission.NextPos == 5 then
	
		Mission.NextPos = 1
		
	end
	
	PutRelTo(boat, Mission.JapCargos[Mission.NextFreighter], Mission.GenPos[Mission.NextPos], 0)
	Mission.NextFreighter = Mission.NextFreighter + 1
	Mission.NextPos = Mission.NextPos + 1
	
	table.insert(Mission.LandingBoats, boat)
	
	local path = Mission.LandingPaths[Mission.NextLandingPathNum]
	local pathTable = FillPathPoints(path)
	boat.LandingPath = path
	boat.landingPoint = pathTable[table.getn(pathTable)]
	
	NavigatorMoveOnPath(boat, path)
	
	luaObj_AddUnit("primary", 2, boat)
	
	if Mission.NextLandingPathNum == Mission.LandingPathNum then
		
		Mission.NextLandingPathNum = 1
		
	else
		
		Mission.NextLandingPathNum = Mission.NextLandingPathNum + 1
		
	end
	
	if not Mission.LandingStartedDiaPlayed then
	
		luaStartDialog("LANDING")
		
		Mission.LandingStartedDiaPlayed = true
		
	end
	
end

--[[function luaDecrementLCVPs()

	Mission.LCVPsOut = Mission.LCVPsOut - 1

end]]

---- PHASE 1 ----

function luaSpawnNextStrikeWave()
	
	local zero = GenerateObject("Zero")
	local val1 = GenerateObject("Val")
	local val2 = GenerateObject("Val_2")
	local val3 = GenerateObject("Val_3")
	local val4 = GenerateObject("Val_4")
	local val5 = GenerateObject("Val_5")
	local val6 = GenerateObject("Val_6")
	local val7 = GenerateObject("Val_7")
	
	table.insert(Mission.JapStrikeGang, zero)
	table.insert(Mission.JapStrikeGang, val1)
	table.insert(Mission.JapStrikeGang, val2)
	table.insert(Mission.JapStrikeGang, val3)
	table.insert(Mission.JapStrikeGang, val4)
	table.insert(Mission.JapStrikeGang, val5)
	table.insert(Mission.JapStrikeGang, val6)
	table.insert(Mission.JapStrikeGang, val7)
	table.insert(Mission.JapValGang, val1)
	table.insert(Mission.JapValGang, val2)
	table.insert(Mission.JapValGang, val3)
	table.insert(Mission.JapValGang, val4)
	table.insert(Mission.JapValGang, val5)
	table.insert(Mission.JapValGang, val6)
	table.insert(Mission.JapValGang, val7)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapStrikeGang)) do
		
		if unit and not unit.Dead then
			
			SetSkillLevel(unit, Mission.SkillLevel)
			luaObj_AddUnit("primary", 1, unit)
			
			if unit.Class.Name == "globals.unitclass_zero" then
			
				if not Mission.RadarStation.Dead then
				
					PilotSetTarget(unit, Mission.RadarStation)
				
				else
				
					PilotMoveToRange(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.Airfields)))
				
				end
			
			elseif unit.Class.Name == "globals.unitclass_val" then
				
				local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapCVTrgs))
				
				luaSetScriptTarget(unit, trg)
				PilotSetTarget(unit, trg)
			
			end
			
		end
		
	end
	
end

function luaPhaseMoveAllow()

	Mission.CanMoveToPh2 = true

end

function luaCheckAllow()

	Mission.CanCheckForPlanes = true

end

function luaAirRaidAllow()

	Mission.AirStrikeSpawnAllowed = true

end

function luaIntroMovie1()
	
	Blackout(false, "", 1)
	
	local tRefPos = {}
		tRefPos.x = 0
		tRefPos.y = 0
		tRefPos.z = 0
	
	local sRefPos = {}
		sRefPos.x = 0
		sRefPos.y = 0
		sRefPos.z = 0

	local campos =
		{
			["postype"] = "cameraandtarget",
			["position"] = 
			{
				["parent"] = Mission.IntroUnits[table.getn(Mission.IntroUnits)],	-- Catalinan
--[[
				["modifier"] = {
					["name"] = "goaround",
					["radius"] = { 60, 8, 125, },
					["radiuslinearblend"] = 0.3,
					["theta"] = { 1, 9, 13,},
					["thetalinearblend"] = 0.3,
					["rho"] = {70, 8, 150, },
					["rholinearblend"] = 0.5,
				}
]]
				--["polar"] = {60, 5, 150},
				["pos"] = {-15, 4, -40},
			},
			["starttime"] = 0,
			["blendtime"] = 0,
			["wanderer"] = true,
			["transformtype"] = "keepall",
			["zoom"] = 1.5	-- 20-as FOV!
		}
	MovCamNew_AddPosition(campos)

	local campos =
		{
			["postype"] = "target",
			["position"] = 
			{
				["parent"] = Mission.IntroUnits[2],			-- Jap as target
				["pos"] = {0, 0, 0},
			},
			["starttime"] = 0,
			["blendtime"] = 0,
			["linearblend"]= 0,
			["zoom"] = 1.5	-- 20-as FOV!
		}
	MovCamNew_AddPosition(campos)

	-- rafordulas az elso celpontra (camera)
	local campos =
		{
			["postype"] = "camera",
			["position"] = 
			{
				["parent"] = Mission.IntroUnits[table.getn(Mission.IntroUnits)],	-- Catalinan
				["pos"] = {-20, 7, -30},
			},
			["starttime"] = 0,
			["blendtime"] = 6,
			["wanderer"] = false,
			["transformtype"] = "keepall",
			["zoom"] = 1.5	-- 20-as FOV!
		}
	MovCamNew_AddPosition(campos)

	-- rafordulas az elso celpontra (target)
	local campos =
		{
			["postype"] = "target",
			["position"] = 
			{
				["parent"] = Mission.IntroUnits[5],
				["pos"] = {0, 0, 0},
			},
			["starttime"] = 0,
			["blendtime"] = 6,
			["linearblend"]= 0,
			["zoom"] = 1.5	-- 20-as FOV!
		}
	MovCamNew_AddPosition(campos)
	
	luaStartDialog("INTRO")
	
	luaDelay(luaIntroMovie2, 6)
	
end

function luaIntroMovie2()

	local campos =
	{
		["postype"] = "cameraandtarget",
		["position"] = 
		{
			["parent"] = Mission.IntroUnits[1],
			["modifier"] = {
				["name"] = "goaround",
				["radius"] = { 25 },
				["radiuslinearblend"] = 0.3,
				["theta"] = { 5, 9, 10},
				["thetalinearblend"] = 0.3,
				["rho"] = {165, 9, 200, },
				["rholinearblend"] = 0.5,
			}
			--["polar"] = {60, 20, 180},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["nonlinearblend"] = 3,
		["transformtype"] = "keepy",
		["zoom"] = 1.2	-- 25-os FOV!
	}
	
	MovCamNew_AddPosition(campos)

end

function luaIntroMovieEnd()
	
	local planeTypes = 
	{
	133,
	133,				
	}
	
	local slotIndex = LaunchSquadron(Mission.Airfield1,luaPickRnd(planeTypes),3)
	Mission.Bruh = thisTable[tostring(GetProperty(Mission.Airfield1, "slots")[slotIndex].squadron)]
	
	luaAddFirstObjs()
	
	Blackout(true, "luaIn", 1)
	
end

function luaIn()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.IntroUnits)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IntroUnits)) do
			
			if unit and not unit.Dead then
				
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	Mission.MissionPhase = 1
	Mission.IntroOver = true
	
	SetSelectedUnit(Mission.Bruh)
	
	local line1 = "Repel the air raid!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	Blackout(false, "", 1)
	
	luaDelay(luaStrikeDia, 4)
	
end

function luaAddFirstObjs()
	
	luaObj_Add("primary", 1)
	
end

function luaStrikeDia()

	luaStartDialog("STRIKE")

end

---- MOVIES -----

function luaPlayMovie3()

	PlayBinkMovie("campaigns/BSM/m1002d.bik")

end

function luaPlayMovie2()

	PlayBinkMovie("campaigns/BSM/m1002c.bik")

end

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m1002b.bik")

end

---- MISSION ENDERS ----

function luaMissionComplete(unit)
	
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
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(unit, "Enemy carriers are sinking - Mission Complete", "campaigns/BSM/m1003.bik")
	
end

function luaMissionFailed(unit)
	
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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(unit, "Game Over")
	
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