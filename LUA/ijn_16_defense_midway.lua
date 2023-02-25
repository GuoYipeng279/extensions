---- DEFENSE OF MIDWAY (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- DEFENSE OF MIDWAY (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(26) 	-- F6F
	PrepareClass(38) 	-- SB2C
	PrepareClass(331) 	-- BTD
	--PrepareClass(116) 	-- B17
	--PrepareClass(136) 	-- C47
	
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
	
	LoadMessageMap("ijndlg",8)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_16_defense_midway.lua"

	this.Name = "IJN16"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Raid",
				["Text"] = "Repel the air raid!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "HQ",
				["Text"] = "Ensure both HQs remain in your hands!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Inv",
				["Text"] = "Destroy the enemy invasion force!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Cargos",
				["Text"] = "Ensure the survial of at least half your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "CV",
				["Text"] = "Locate and sink the enemy fleet carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Crago",
				["Text"] = "Ensure the survival of all your troop transports!",
				["TextFailed"] = "One of our troop transports is sinking!",
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
					["message"] = "idlg01a",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["AFHIT"] = {--
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["YARDHIT"] = {--
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
			},
		},
		["AFDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "dlg9",
				},
			},
		},
		["YARDEAD"] = {--
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["PARATROOP"] = {--
			["sequence"] = {
				{
					["message"] = "PARATROOP1",
				},
			},
		},
		["TROOP"] = {--
			["sequence"] = {
				{
					["message"] = "idlg01c",
				},
				{
					["message"] = "dlg1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
			},
		},
		["SUB"] = {--
			["sequence"] = {
				{
					["message"] = "SUB1",
				},
				{
					["message"] = "SUB2",
				},
			},
		},
		["FUCKMEEE"] = {--
			["sequence"] = {
				{
					["message"] = "FUCKMEEE1",
				},
				{
					["message"] = "FUCKMEEE2",
				},
				{
					["message"] = "FUCKMEEE3",
				},
				{
					["message"] = "FUCKMEEE4",
				},
				{
					["message"] = "FUCKMEEE5",
				},
				{
					["message"] = "FUCKMEEE6",
				},
			},
		},
		["HONOURABLE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh2FadeOut",
				},
			},
		},
		["CVE"] = {--
			["sequence"] = {
				{
					["message"] = "CVE1",
				},
				{
					["message"] = "CVE2",
				},
			},
		},
		["CV"] = {--
			["sequence"] = {
				{
					["message"] = "CV1",
				},
				{
					["message"] = "CV2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
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
	
	---- IJN ----
	
	Mission.Radar = FindEntity("CommandBuilding Control Tower 01")
	Mission.HQ = FindEntity("Headquarter 01")
	
	Mission.Shipyard = FindEntity("Shipyard 02")
	
	SetSkillLevel(FindEntity("Mavis"), Mission.SkillLevelOwn)
	
	Mission.HQs = {}
		table.insert(Mission.HQs, Mission.Radar)
		table.insert(Mission.HQs, Mission.HQ)
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.Airfield1 = FindEntity("AirFieldEntity 01")
	Mission.Airfield2 = FindEntity("AirFieldEntity 02")
	--Mission.Airfield3 = FindEntity("AirFieldEntity 03")
	Mission.Airfield1.HangarEntity = FindEntity("Hangar, Large, 08 01")
	Mission.Airfield2.HangarEntity = FindEntity("Hangar, Large, 08 02")
	--Mission.Airfield3.HangarEntity = FindEntity("Hangar, Large, 08 03")
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, Mission.Airfield1)
		table.insert(Mission.Airfields, Mission.Airfield2)
		table.insert(Mission.Airfields, Mission.Airfield3)
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		RepairEnable(unit, false)
		
	end
	
	Mission.JapCVFleet = {}
		table.insert(Mission.JapCVFleet, FindEntity("Hiryu"))
		--table.insert(Mission.JapCVFleet, FindEntity("Soryu"))
		table.insert(Mission.JapCVFleet, FindEntity("Tone"))
		--table.insert(Mission.JapCVFleet, FindEntity("Mikuma"))
		--table.insert(Mission.JapCVFleet, FindEntity("Asashio"))
		--table.insert(Mission.JapCVFleet, FindEntity("Michishio"))
		table.insert(Mission.JapCVFleet, FindEntity("Asagumo"))
		table.insert(Mission.JapCVFleet, FindEntity("Natsugumo"))
	
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
	
	Mission.JapBBFleet = {}
		table.insert(Mission.JapBBFleet, FindEntity("Nagato"))
		table.insert(Mission.JapBBFleet, FindEntity("Oshio"))
		table.insert(Mission.JapBBFleet, FindEntity("Yamagumo"))
	
	for idx,unit in pairs(Mission.JapBBFleet) do
		
		JoinFormation(unit, Mission.JapBBFleet[1])
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
	
	Mission.JapTroopFleetA = {}
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_1")
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_2")
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_3")
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_4")
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_5")
		table.insert(Mission.JapTroopFleetA, "TroopShip_1_6")
		--table.insert(Mission.JapTroopFleetA, "TroopShip_1_7")
		--table.insert(Mission.JapTroopFleetA, "TroopShip_1_8")
	
	Mission.JapTroopFleetB = {}
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_1")
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_2")
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_3")
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_4")
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_5")
		table.insert(Mission.JapTroopFleetB, "TroopShip_2_6")
		--table.insert(Mission.JapTroopFleetB, "TroopShip_2_7")
		--table.insert(Mission.JapTroopFleetB, "TroopShip_2_8")
	
	Mission.JapTrgs = {}
		table.insert(Mission.JapTrgs, Mission.Radar)
		table.insert(Mission.JapTrgs, Mission.HQ)
		table.insert(Mission.JapTrgs, Mission.Shipyard)
		table.insert(Mission.JapTrgs, FindEntity("Hiryu"))
		--table.insert(Mission.JapTrgs, FindEntity("Soryu"))
		table.insert(Mission.JapTrgs, FindEntity("Nagato"))
	
	Mission.JapGround = {}
		table.insert(Mission.JapGround, Mission.Radar)
		table.insert(Mission.JapGround, Mission.HQ)
		table.insert(Mission.JapGround, Mission.Shipyard)
	
	Mission.JapTroopFleet = {}
	Mission.JapTroopTransports = {}
	
	---- USN ----
	
	Mission.CVFleet = {}
		table.insert(Mission.CVFleet, "Bunker Hill")
		table.insert(Mission.CVFleet, "Franklin")
		table.insert(Mission.CVFleet, "Oakland")
		table.insert(Mission.CVFleet, "Atlanta")
		--table.insert(Mission.CVFleet, "Fletcher-class03")
		--table.insert(Mission.CVFleet, "Fletcher-class04")
		--table.insert(Mission.CVFleet, "Fletcher-class05")
		--table.insert(Mission.CVFleet, "Fletcher-class06")
		
	Mission.CVEFleet = {}
		table.insert(Mission.CVEFleet, "Core")
		table.insert(Mission.CVEFleet, "Block Island")
		table.insert(Mission.CVEFleet, "Louisville")
		table.insert(Mission.CVEFleet, "Chicago")
		--table.insert(Mission.CVEFleet, "Fletcher-class07")
		--table.insert(Mission.CVEFleet, "Fletcher-class08")
		--table.insert(Mission.CVEFleet, "Fletcher-class09")
		--table.insert(Mission.CVEFleet, "Fletcher-class10")
		
	Mission.LandingForceA = {}
		table.insert(Mission.LandingForceA, "North Carolina")
		table.insert(Mission.LandingForceA, "San Francisco")
		--table.insert(Mission.LandingForceA, "Fletcher-class01")
		table.insert(Mission.LandingForceA, "LST N. 81")
		table.insert(Mission.LandingForceA, "LST N. 82")
	
	Mission.LandingForceB = {}
		table.insert(Mission.LandingForceB, "South Dakota")
		table.insert(Mission.LandingForceB, "Vincennes")
		--table.insert(Mission.LandingForceB, "Fletcher-class02")
		table.insert(Mission.LandingForceB, "LST N. 84")
		table.insert(Mission.LandingForceB, "LSM N. 26")
	
	Mission.USAF = {}
	Mission.LSTs = {}
	Mission.InvasionForce = {}
	Mission.Strikers = {}
	Mission.USCVs = {}
	Mission.Subs = {}
	
	---- VAR ----
	
	Mission.CVPaths = {}
		table.insert(Mission.CVPaths, FindEntity("CVPath1"))
		table.insert(Mission.CVPaths, FindEntity("CVPath2"))
		table.insert(Mission.CVPaths, FindEntity("CVPath3"))
	
	Mission.SpawnPositions = {1, 2, 3}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Waves = 0
	
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
	
	--[[local deadAf = luaPickRnd(luaRemoveDeadsFromTable(Mission.Airfields))
	
	Kill(deadAf, true)
	Kill(deadAf.HangarEntity, true)]]
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
		
		table.insert(Mission.JapTrgs, unit)
		table.insert(Mission.JapGround, unit)
		
	end
	
	EnableMessages(false)
	
	MissionNarrative("September 9th, 1943 - Midway Atoll")
	
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
	
	--luaShowPath(FindEntity("CVPath3"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapTrgs) do
		
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
	
		luaIntroMovie1()
		
		Mission.Started = true

    else

        if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	

    ---- TEST ----

    --print("text")
	
	--Mission.TEST = table.getn(Mission.SpawnPositions)
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
				
				if (Mission.Radar.Party == PARTY_NEUTRAL or Mission.Radar.Party == PARTY_ALLIED) or (Mission.HQ.Party == PARTY_NEUTRAL or Mission.HQ.Party == PARTY_ALLIED) then
				
					luaMissionFailed()
				
				else
				
					Mission.RadarStatus = string.format("%.0f",(GetHpPercentage(Mission.Radar) * 100))
					Mission.HQStatus = string.format("%.0f",(GetHpPercentage(Mission.HQ) * 100))
					
					local line1 = "Protect your HQs!"
					local line2 = "Radar status: #Mission.RadarStatus#% | HQ status: #Mission.HQStatus#%"
					luaDisplayScore(2, line1, line2)
				
				end
				
			end
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTroopTransports)) < 2 then
				
					luaMissionFailed()
				
				end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTroopTransports)) < 4 then
				
					luaObj_Failed("secondary", 1, true)
				
				end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.USAF)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USAF)) do
				
					if unit and not unit.Dead then
						
						local fighters = {
							[1] = 26,
						}
						local bombers = {
							[1] = 331,
							[2] = 38,
						}
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(Mission.JapTrgs))
						
					end
				
				end
			
			end
			
			if not Mission.LandingsStarted then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.LSTs)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
					
						local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(Mission.LSTs))
						local closest = ordered[1]
						
						if luaGetDistance(unit, closest) < 4000 then
						
							luaStartLandings()
							
							Mission.LandingsStarted = true
						
						end
						
					end
				
				end
			
			end
			
			if not Mission.FieldDiaPlayed then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) < 2 then
				
					luaStartDialog("AFDEAD")
					
					Mission.FieldDiaPlayed = true
				
				end
			
			end
			
			if not Mission.YardDiaPlayed then
			
				if Mission.Shipyard.Dead then
				
					luaStartDialog("YARDEAD")
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Strikers)) == 0 then
				
					if Mission.Waves >= 3 then
					
						luaPh1FadeOut()
					
					end
					
				else
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Strikers)) do
				
						if unit and not unit.Dead then
							
							--[[local ammo = GetProperty(unit, "ammoType")
							
							if ammo == 0 then
							
								table.remove(Mission.Strikers, idx)
							
							else]]
							
								if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
									
									local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(Mission.HQs))
									local closest = ordered[1]
									
									luaSetScriptTarget(unit, closest)
									NavigatorAttackMove(unit, closest)
								
								end
							
							--end
							
						end
					
					end
				
				end
				
			end
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.InvasionForce)) == 0 then
					
					if not Mission.SetToMove3 then
						
						luaDelay(luaHidePh3Score, 1)
						
						luaObj_Completed("primary", 3)
						
						luaStartDialog("HONOURABLE")
						
						Mission.SetToMove3 = true
						
					end
					
				else
				
					Mission.InvasionLeft = table.getn(luaRemoveDeadsFromTable(Mission.InvasionForce))
					
					local line1 = "Destroy the enemy invasion force!"
					local line2 = "Ship(s) left to sink: #Mission.InvasionLeft#"
					luaDisplayScore(3, line1, line2)
				
				end
			
			end
		
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 5) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 0 then
					
					--if not Mission.SetToMove4 then
						
						for idx,unit in pairs(Mission.HQs) do
						
							SetInvincible(unit, 0.01)
							
						end
						
						HideUnitHP()
						HideScoreDisplay(4,0)
						
						luaObj_Completed("primary", 5)
						
						luaMissionComplete()
						
						--Mission.SetToMove4 = true
						
					--end
				
				end
			
			end
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end
	
end

---- FLEET SPAWNER ----

function luaSpawnUSFleet(spawnIdx)
	
	if table.getn(Mission.SpawnPositions) > 0 then
	
		local fleets
		local listenerTbl = {}
		
		if spawnIdx == 1 then
		
			fleets = {Mission.CVFleet}
			
		elseif spawnIdx == 2 then
		
			fleets = {Mission.CVEFleet}
			
		elseif spawnIdx == 3 then
		
			fleets = {Mission.LandingForceA, Mission.LandingForceB}
			
		end
		
		local chosenPosIdx = luaPickRnd(Mission.SpawnPositions)
		local move = 7000
		local moveX
		local moveY
		local rot
		
		if chosenPosIdx == 1 then
		
			moveX = -(move)
			moveY = -(move)
			rot = -90
			
		elseif chosenPosIdx == 2 then
		
			moveX = move
			moveY = -(move)
			rot = 90
			
		elseif chosenPosIdx == 3 then
		
			moveX = move
			moveY = move
			rot = 90
			
		end
		
		for idx1,fleet in pairs(fleets) do
			
			local shipGrp = {}
			local canAttack = false
			local carrierHere = false
			
			for idx2,unitName in pairs(fleet) do
			
				table.insert(shipGrp, GenerateObject(unitName))
			
			end
			
			for idx3,unit in pairs(shipGrp) do
				
				if chosenPosIdx == 1 then
				
					local pos = GetPosition(unit)
					pos.x = -(pos.x)
					
					PutTo(unit, pos)
					
				end
				
				JoinFormation(unit, shipGrp[1])
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
				
				if unit.Class.SubType == "LST" or unit.Class.SubType == "LSM" then
					
					table.insert(Mission.LSTs, unit)
					--table.insert(listenerTbl, unit)
					unit.IJN16_HQTarget = Mission.HQs[idx1]
					canAttack = true
					
				elseif unit.Class.Type == "MotherShip" then
					
					if Mission.Difficulty == 0 then
					
						SetAirBaseSlotCount(unit, 2)
						
					elseif Mission.Difficulty == 1 then
						
						SetAirBaseSlotCount(unit, 3)
						
					elseif Mission.Difficulty == 2 then
						
						SetAirBaseSlotCount(unit, 3)
						
					end
					
					table.insert(Mission.USAF, unit)
					table.insert(listenerTbl, unit)
					carrierHere = true
					
					if unit.Class.ID == 256 then
					
						table.insert(Mission.USCVs, unit)
					
					end
					
				end
				
				if spawnIdx == 3 then
					
					--table.insert(listenerTbl, unit)
					table.insert(Mission.InvasionForce, unit)
					
				end
				
			end
			
			for idx4,unit in pairs(shipGrp) do
			
				local pos = GetPosition(unit)
				pos.x = pos.x + moveX
				pos.z = pos.z + moveY
				
				PutTo(unit, pos, rot)
			
			end
			
			if canAttack then
			
				NavigatorAttackMove(shipGrp[1], Mission.HQs[idx1])
				
				if Mission.Difficulty > 0 then
				
					local planeName
					
					if idx1 == 1 then
					
						planeName = "Mustang_1"
					
					else
					
						planeName = "Mustang_2"
					
					end
					
					local plane = GenerateObject(planeName)
					
					local pos = GetPosition(shipGrp[1])
					pos.y = 1000
					
					PutTo(plane, pos)
					
					SetSkillLevel(plane, Mission.SkillLevel)
					
					PilotMoveToRange(plane, shipGrp[1])
				
				end
				
			elseif carrierHere then
				
				local orderedPaths = luaSortByDistance(shipGrp[1], Mission.CVPaths)
				local path = orderedPaths[1]
				
				local pathIdx = luaRnd(1,2)
				local pathDir
				
				if pathIdx == 1 then
				
					pathDir = PATH_SM_JOIN
				
				elseif pathIdx == 2 then
				
					pathDir = PATH_SM_JOIN_BACKWARDS
				
				end
				
				NavigatorMoveOnPath(shipGrp[1], path, PATH_FM_CIRCLE, pathDir)
			
			end
			
		end
		
		table.remove(Mission.SpawnPositions, chosenPosIdx)
		
		if spawnIdx == 2 then
		
			luaAddCVEListener(listenerTbl)
			
		end
	
	end
	
end

---- PHASE 3 ----

function luaHidePh3Score()

	HideScoreDisplay(3,0)

end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaSpawnUSFleet(1)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaCVDia, 2)
	
	local trg1 = FindEntity("Bunker Hill")
	
	luaIngameMovie(
	{
		
	   {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	   
	}, luaPh3MovieEnd, true)

end

function luaCVDia()

	luaStartDialog("CV")

end

function luaPh3MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)))
	
	end

end

function luaAddFinalObjs()

	luaObj_Add("primary", 5, Mission.USCVs)
	
	local line1 = "Locate and sink the enemy fleet carriers!"
	local line2 = ""
	luaDisplayScore(4, line1, line2)
	
	luaDelay(luaFuckDia, 80)
	
end

function luaFuckDia()

	luaStartDialog("FUCKMEEE")

end

---- PHASE 2 ----

function luaHidePh2Score()

	HideScoreDisplay(2,0)

end

function luaPh2FadeOut()

	if Mission.MissionPhase == 2 then
		
		Blackout(true, "luaMoveToPh3", 3)
		
		Mission.MissionPhase = 2.5
		
	end

end

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	
	if IsListenerActive("hit", "YardHitListener") then
	
		RemoveListener("hit", "YardHitListener")
	
	end
	
	if IsListenerActive("hit", "AFHitListener") then
	
		RemoveListener("hit", "AFHitListener")
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Strikers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Strikers)) do
		
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
		
		end
	
	end
	
	luaSpawnUSFleet(2)
	luaSpawnUSFleet(3)
	
	local spawnIdx = luaRnd(1,2)
	local troopFleet
	
	if spawnIdx == 1 then
	
		troopFleet = Mission.JapTroopFleetA
	
	elseif spawnIdx == 2 then
	
		troopFleet = Mission.JapTroopFleetB
	
	end
	
	for idx,unitName in pairs(troopFleet) do
	
		table.insert(Mission.JapTroopFleet, GenerateObject(unitName))
	
	end
	
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
		
		if unit.Class.SubType == "TroopTransport" then
		
			table.insert(Mission.JapTroopTransports, unit)
		
		end
		
	end
	
	table.insert(Mission.Subs, GenerateObject("Dace"))
	table.insert(Mission.Subs, GenerateObject("Pompon"))
	
	for idx,unit in pairs(Mission.Subs) do
		
		local subSpawnIdx = luaRnd(1,2)
		local move = 3000
		local moveX
		local moveY
		
		if subSpawnIdx == 1 then
		
			moveX = move
			
		
		elseif subSpawnIdx == 2 then
		
			moveX = -(move)
		
		end
		
		if idx == 1 then
		
			moveY = -(move)
		
		elseif idx == 2 then
		
			moveY = move
		
		end
		
		local pos = GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapTroopTransports)))
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
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
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapTroopTransports))
		
		EntityTurnToEntity(unit, trg)
		NavigatorAttackMove(unit, trg)
		
		UnitSetFireStance(unit, 2)
		
	end
	
	--[[if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapTroopTransports) do
		
			SetInvincible(unit, 0.4)
			
		end
		
	end]]
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaDelay(luaTroopDia, 2)
	
	local trg1 = FindEntity("North Carolina")
	local trg2 = Mission.JapTroopFleet[1]
	
	luaIngameMovie(
	{
		
	   {["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	   {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
	   
	}, luaPh2MovieEnd, true)
	
end

function luaTroopDia()

	luaStartDialog("TROOP")

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)))
	
	end
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 3, Mission.InvasionForce)
	luaObj_Add("primary", 4)
	luaObj_Add("secondary", 1, Mission.JapTroopTransports)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTroopTransports), "Protect your transports!")
	
	luaAddSubListener()
	
end

function luaStartLandings()

	if table.getn(luaRemoveDeadsFromTable(Mission.LSTs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTs)) do
		
			if unit and not unit.Dead then
				
				if unit.Class.SubType == "LSM" then
				
					local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(Mission.HQs))
					local closest = ordered[1]
					
					NavigatorAttackMove(unit, closest)
				
				else
				
					NavigatorAttackMove(unit, unit.IJN16_HQTarget)
				
				end
				
			end
		
		end
		
	end

end

---- PHASE 1 ----

function luaPh1FadeOut()

	if Mission.MissionPhase == 1 then
		
		HideScoreDisplay(1,0)
		
		luaObj_Completed("primary", 1, true)
		
		Blackout(true, "luaMoveToPh2", 3)
		
		Mission.MissionPhase = 1.5
		
	end

end

function luaSpawnBomberWave()

	if Mission.Waves < 3 then
		
		local spawnIdx = luaRnd(1,3)
		local listenerTbl = {}
		local planeName
		local trgs
		
		if Mission.Waves < 2 then
		
			planeName = "B-17"
			
			trgs = Mission.JapGround
			
		else
		
			planeName = "Skytrain"
			
			trgs = Mission.HQs
			
		end
		
		for i = 1, 4 do
			
			local plane = GenerateObject(planeName)
			local trg = luaPickRnd(luaRemoveDeadsFromTable(trgs))
			local moveX
			local moveY
			local diffX
			local diffY
			
			if spawnIdx == 1 then
			
				moveX = -10000
				moveY = -10000
			
			elseif spawnIdx == 2 then
			
				moveX = 10000
				moveY = 10000
			
			elseif spawnIdx == 3 then
			
				moveX = 10000
				moveY = -10000
			
			end
			
			if i == 1 then
			
				diffX = random(100, 500)
				diffY = random(100, 500)
			
			elseif i == 2 then
			
				diffX = -(random(100, 500))
				diffY = random(100, 500)
			
			elseif i == 3 then
			
				diffX = random(100, 500)
				diffY = -(random(100, 500))
			
			elseif i == 4 then
			
				diffX = -(random(100, 500))
				diffY = -(random(100, 500))
			
			end
			
			if Mission.Waves == 2 then
			
				if i == 1 or i == 2 then
				
					trg = trgs[1]
				
				else
				
					trg = trgs[2]
				
				end
				
				table.insert(listenerTbl, plane)
				
			end
			
			local pos = GetPosition(plane)
			pos.x = (pos.x + moveX) + diffX
			pos.y = 1500
			pos.z = (pos.z + moveY) + diffY
			
			PutTo(plane, pos)
			
			SetSkillLevel(plane, Mission.SkillLevel)
			EntityTurnToEntity(plane, trg)
			
			luaSetScriptTarget(plane, trg)
			PilotSetTarget(plane, trg)
			
			table.insert(Mission.Strikers, plane)
			
		end
		
		if Mission.Difficulty > 0 then
		
			local fighter = GenerateObject("Mustang")
			
			local bomber = luaPickRnd(luaRemoveDeadsFromTable(Mission.Strikers))
			
			local pos = GetPosition(bomber)
			pos.y = 2000
			
			PutTo(fighter, pos)
			
			SetSkillLevel(fighter, Mission.SkillLevel)
			
			EntityTurnToEntity(fighter, luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)))
			PilotMoveToRange(fighter, luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)))
			
			--UnitSetFireStance(fighter, 2)
			
			table.insert(Mission.Strikers, fighter)
			
		end
		
		Mission.Waves = Mission.Waves + 1
		
		if Mission.Waves == 3 then
		
			luaDelay(luaPh1FadeOut, 300)
		
			luaAddTroopListener(listenerTbl)
		
		end
		
		luaDelay(luaSpawnBomberWave, 200)
		
	end

end

function luaIntroMovie1()
	
	luaSpawnBomberWave()
	
	luaDelay(luaIntroDia, 4)
	
	local trg1 = Mission.Radar
	local trg2 = FindEntity("Mavis")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=290,["y"]=3,["z"]=190},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=250,["y"]=3,["z"]=150},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=250,["y"]=3,["z"]=150},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=285,["y"]=5,["z"]=190},["parent"] = trg1,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5,["y"]=8,["z"]=-50},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-12,["y"]=8,["z"]=10},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-2,["y"]=8,["z"]=10},["parent"] = trg2,},["moveTime"] = 11,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()
	
	local trg1 = Mission.Strikers[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 45, ["theta"] = 2, ["rho"] = -20, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 45, ["theta"] = 2, ["rho"] = -30, ["moveTime"] = 8},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Radar)
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2, Mission.HQs)
	
	local line1 = "Repel the air raid!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	--DisplayUnitHP(luaRemoveDeadsFromTable(Mission.HQs), "Ensure both HQs remain in your hands!")
	
	luaAddYardHitListener()
	luaAddAFHitListener()
	
end

---- LISTENERS ----

function luaAddTroopListener(tbl)

	AddListener("recon", "TroopListener", {
		["callback"] = "luaTroopSighted",
		["entity"] = tbl,
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

function luaAddYardHitListener()

	AddListener("hit", "YardHitListener", {
		["callback"] = "luaYardHit",
		["target"] = {Mission.Shipyard},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"BOMB"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddAFHitListener()

	AddListener("hit", "AFHitListener", {
		["callback"] = "luaAFHit",
		["target"] = luaRemoveDeadsFromTable(Mission.Airfields),
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {"BOMB"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

--[[function luaAddCVListener(tbl)

	AddListener("recon", "CVListener", {
		["callback"] = "luaCVSighted",
		["entity"] = tbl,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end]]

function luaAddCVEListener(tbl)

	AddListener("recon", "CVEListener", {
		["callback"] = "luaCVESighted",
		["entity"] = tbl,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

--[[function luaAddBBListener(tbl)

	AddListener("recon", "BBListener", {
		["callback"] = "luaBBSighted",
		["entity"] = tbl,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end]]

---- LISTENER CALLBACKS ----

function luaTroopSighted()

	RemoveListener("recon", "TroopListener")
	
	luaStartDialog("PARATROOP")

end

function luaSubSighted()

	RemoveListener("recon", "SubListener")
	
	luaStartDialog("SUB")

end

function luaYardHit()

	RemoveListener("hit", "YardHitListener")
	
	luaStartDialog("YARDHIT")

end

function luaAFHit()

	RemoveListener("hit", "AFHitListener")
	
	luaStartDialog("AFHIT")

end

--[[function luaCVSighted()

	RemoveListener("recon", "CVListener")

end]]

function luaCVESighted()

	RemoveListener("recon", "CVEListener")
	
	luaStartDialog("CVE")

end

--[[function luaBBSighted()

	RemoveListener("recon", "BBListener")

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
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		local shipsAround = luaGetShipsAroundCoordinate(GetPosition(Mission.HQ), 300000, PARTY_ALLIED, "own")
		
		if shipsAround and table.getn(luaRemoveDeadsFromTable(shipsAround)) > 0 then
			
			luaObj_Failed("hidden",1)
		
		else
		
			luaObj_Completed("hidden",1)
		
		end
	
	end
	
	luaMissionCompletedNew(luaPickRnd(Mission.HQs), "Midway remains in our hands - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaDelay(luaHidePh2Score, 1)
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh3Score, 1)
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		HideScoreDisplay(4,0)
		
		luaObj_Failed("primary",5)
	
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