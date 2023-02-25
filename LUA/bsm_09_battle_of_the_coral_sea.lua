---- BATTLE OF THE CORAL SEA (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- BATTLE OF THE CORAL SEA (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(162) -- Kate
	
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
	
	LoadMessageMap("bsmdlg",9)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_09_battle_of_the_coral_sea.lua"

	this.Name = "BSM09"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Defeat",
				["Text"] = "Defeat the Japanese carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Yorktown",
				["Text"] = "Protect the Yorktown from sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Donald",
				["Text"] = "Ensure Donald's survival!",
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
				["ID"] = "Shoot",
				["Text"] = "Shoot down 30 Japanese planes!",
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
					["type"] = "pause",
					["time"] = 6,
				},
				{
					["message"] = "STAND1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie2",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "TENNOHEKA1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie3",
				},
			},
		},
		["LEX"] = {
			["sequence"] = {
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie8",
				},
				{
					["message"] = "LEX1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie7",
				},
				{
					["message"] = "LEX2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovieEnd",
				},
			},
		},
		["BLOWN"] = {
			["sequence"] = {
				{
					["message"] = "BLOWN1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaLexSink",
				},
				{
					["message"] = "BLOWN2",
				},
			},
		},
		["INCOMING"] = {
			["sequence"] = {
				{
					["message"] = "INCOMING1",
				},
			},
		},
		["LOCATED"] = {
			["sequence"] = {
				{
					["message"] = "LOCATED1",
				},
				{
					["message"] = "LOCATED2",
				},
			},
		},
		["DMG"] = {
			["sequence"] = {
				{
					["message"] = "DMG1",
				},
				{
					["message"] = "DMG2",
				},
			},
		},
		["RETREATING"] = {
			["sequence"] = {
				{
					["message"] = "RETREATING1",
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
	
	Mission.Yorktown = FindEntity("Yorktown")
	Mission.Lexington = FindEntity("Lexington")
	
	Mission.Donald = FindEntity("Donald")
	
	SetGuiName(Mission.Donald,"Donald",true) 
	UnitSetPlayerCommandsEnabled(Mission.Donald, PCF_MOVE+PCF_TARGET+PCF_JOIN_LEAVE+PCF_CHANGE_FORMATION+PCF_ORDERS+PCF_REPAIR)
	SquadronSetBaseUnsupported(Mission.Donald, Mission.Yorktown)
	SquadronSetBaseUnsupported(Mission.Donald, Mission.Lexington)
	SetInvincible(Mission.Lexington, 0.01)
	
	Scoring_IgnoreEntityKill(Mission.Lexington)
	
	Mission.YorktownGang = {}
		table.insert(Mission.YorktownGang, Mission.Yorktown)
		table.insert(Mission.YorktownGang, FindEntity("Cleveland"))
		table.insert(Mission.YorktownGang, FindEntity("Fletcher"))
		table.insert(Mission.YorktownGang, FindEntity("Jenkins"))
	
	for idx,unit in pairs(Mission.YorktownGang) do
		
		JoinFormation(unit, Mission.YorktownGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.USDDs = {}
		table.insert(Mission.USDDs, FindEntity("Fletcher"))
		table.insert(Mission.USDDs, FindEntity("Jenkins"))
	
	Mission.ayyycykablyat = {}
		table.insert(Mission.ayyycykablyat, Mission.Yorktown)
	
	---- IJN ----
	
	Mission.LexKillerGang = {}
		table.insert(Mission.LexKillerGang, GenerateObject("D3A Val 1", "D3A Val"))
		table.insert(Mission.LexKillerGang, GenerateObject("D3A Val 2", "D3A Val"))
		table.insert(Mission.LexKillerGang, GenerateObject("D3A Val 3", "D3A Val"))
		table.insert(Mission.LexKillerGang, GenerateObject("D3A Val 4", "D3A Val"))
		table.insert(Mission.LexKillerGang, GenerateObject("D3A Val 5", "D3A Val"))
	
	SetVisibility(Mission.LexKillerGang[5], false)
	
	for index, squad in pairs (Mission.LexKillerGang) do
		AddUntouchableUnit(squad)
		SquadronEnableVehicleAvoidance(squad, false)
		if index == 5 then
			SquadronSetTravelAlt(squad, 1500)
		else
			SquadronSetTravelAlt(squad, 1200)
		end
		SquadronSetAttackAlt( squad, 1000 + math.mod(index, 2)*100 )
		SquadronSetReleaseAlt( squad, 220 )
		PilotSetTarget(squad, Mission.Lexington)
		SquadronSetTravelSpeed(squad, KMH(200))
	end
	
	Mission.Zuikaku = FindEntity("Zuikaku")
	Mission.Shokaku = FindEntity("Shokaku")
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, FindEntity("Zuikaku"))
		table.insert(Mission.JapGang, FindEntity("Shokaku"))
		table.insert(Mission.JapGang, FindEntity("Kiso"))
		table.insert(Mission.JapGang, FindEntity("Akebono"))
		table.insert(Mission.JapGang, FindEntity("Ushio"))
		table.insert(Mission.JapGang, FindEntity("Asagiri"))
		
	for idx,unit in pairs(Mission.JapGang) do
		
		JoinFormation(unit, Mission.Shokaku)
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
	
	Mission.JapEscorts = {}
		table.insert(Mission.JapEscorts, FindEntity("Kiso"))
		table.insert(Mission.JapEscorts, FindEntity("Akebono"))
		table.insert(Mission.JapEscorts, FindEntity("Ushio"))
		table.insert(Mission.JapEscorts, FindEntity("Asagiri"))
	
	NavigatorMoveOnPath(Mission.Shokaku, FindEntity("path1"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	
	Mission.JapCVs = {}
		table.insert(Mission.JapCVs, FindEntity("Zuikaku"))
		table.insert(Mission.JapCVs, FindEntity("Shokaku"))
	
	for idx,unit in pairs(Mission.JapCVs) do
		
		SetInvincible(unit, 0.05)
		
		if Mission.Difficulty == 0 then
			
			SetShipMaxSpeed(unit, 5)
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetShipMaxSpeed(unit, 8)
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetShipMaxSpeed(unit, 11)
			SetAirBaseSlotCount(unit, 4)
			
		end
		
	end
	
	Mission.InitialBombers = {}
		table.insert(Mission.InitialBombers, FindEntity("D3A Val"))
		table.insert(Mission.InitialBombers, FindEntity("B5N Kate"))
	
	for idx,unit in pairs(Mission.InitialBombers) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.LexHits = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	Blackout(true, "", true)
	EnableMessages(false)
	--EnableInput(false)
	
	MissionNarrative("May 8th, 1942 - Coral Sea")
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	AddListener("exitzone", "ExitZone", {
		["callback"] = "luaJapsEscaped",
		["entity"] = Mission.JapCVs,
		["exited"] = {false}, -- false: entity entered exit zone, true: entity exited
	})
	
	luaStartMission()
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
	--luaMoveToPh2()
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.YorktownGang) do
		
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
		
		Mission.MissionPhase = 1
		
		Mission.Started = true
		
	end
	
	if Mission.IntroOver then
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
		if luaObj_IsActive("primary", 1) then
			
			local fighter = {
				[1] = 150,
			}
			local bombers = {
				[1] = 158,
				[2] = 162,
			}
			
			local hplimit = 0.1
			
			if not Mission.Zuikaku.Dead then
				
				luaAirfieldManager(Mission.Zuikaku, fighter, bombers, Mission.ayyycykablyat)
				
				if GetHpPercentage(Mission.Zuikaku) <= hplimit then
					
					luaObj_Completed("primary", 1)
					
					luaStartDialog("RETREATING")
					
					luaJapsRetreat()
					
					Mission.ZuikakuDmg = true
					Mission.EndMission = true
					
				end
				
			end
			
			if not Mission.Shokaku.Dead then
			
				luaAirfieldManager(Mission.Shokaku, fighter, bombers, Mission.ayyycykablyat)
				
				if GetHpPercentage(Mission.Shokaku) <= hplimit then
				
					luaObj_Completed("primary", 1)
					
					luaStartDialog("RETREATING")
					
					luaJapsRetreat()
					
					Mission.ShokakuDmg = true
					Mission.EndMission = true
					
				end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.JapEscorts)) > 0 then
			
				--if not Mission.EscortsAttacking then
					
					local cv = Mission.Shokaku
					local ordered = luaSortByDistance(cv, luaRemoveDeadsFromTable(Mission.YorktownGang))
					local closest = ordered[1]
					
					if closest and not closest.Dead then
						
						if luaGetDistance(cv, closest) < 3000 and not Mission.EscortsAttacking then
							
							luaEscortsAttack(closest)
						
						elseif Mission.EscortsAttacking then
							
							if luaGetDistance(cv, closest) >= 3000 or (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
							
								luaEscortsRetreat(Mission.Shokaku)
							
							--[[else
							
								if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
									Mission.EscortsAttacking = false
							
								end]]
							
							end
							
						end
					
					end
					
				--end
			
			end
			
		end
		
		if luaObj_IsActive("primary", 2) then
			
			if Mission.Yorktown.Dead then
			
				luaMissionFailed(Mission.Yorktown)
			
			end
			
		end
		
		if luaObj_IsActive("primary", 3) then
			
			if Mission.Donald.Dead then
			
				luaMissionFailed(Mission.Yorktown)
			
			end
			
		end
		
		if luaObj_IsActive("hidden", 1) then
			
			local sd = Scoring_GetPlayerShotDown()
			
			if sd >= 30 then
			
				luaObj_Completed("hidden", 1)
			
			end
			
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 1 ----

function luaEscortsAttack(trg)

	if table.getn(luaRemoveDeadsFromTable(Mission.JapEscorts)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapEscorts)) do
			
			if unit and not unit.Dead then
				
				luaSetScriptTarget(unit, trg)
				NavigatorAttackMove(unit, trg)
				
			end
			
		end
		
		Mission.EscortsAttacking = true
		
	end
	
end

function luaEscortsRetreat(cv)

	if table.getn(luaRemoveDeadsFromTable(Mission.JapEscorts)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapEscorts)) do
			
			if unit and not unit.Dead then
			
				JoinFormation(unit, cv)
				
			end
			
		end
		
		Mission.EscortsAttacking = false
		
	end

end

function luaJapsRetreat()

	local exitpos = GetClosestBorderZone(GetPosition(Mission.Shokaku), PARTY_JAPANESE)
	NavigatorMoveToRange(Mission.Shokaku, exitpos)

end

function luaJapsEscaped()

	luaMissionFailed(luaPickRnd(Mission.JapCVs))

end

function luaStartMission()
	
	luaIntroMovie1()
	
	luaAddLexingtonHitListener()
	
	luaStartDialog("INTRO")
	
end

function luaIntroMovie1()
	
	Blackout(false, "", 1)
	
	local coordinate =
	{
		["x"] = 259,
		["y"] = -4,
		["z"] = 610
	}
	
	local deviation =
	{
		["x"] = 0,
		["y"] = 40,
		["z"] = -120
	}
	
	local movCamPos

	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1.8, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1.8, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)

	coordinate =
	{
		["x"] = -10,---6
		["y"] = 9,
		["z"] = 60--55
	}
	
	deviation =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = -500
	}

	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 4.5,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.LexKillerGang[5],
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 4.5,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
end

function luaIntroMovie2()
	
	JoinFormation(Mission.USDDs[2],Mission.Yorktown)
	
	for key, value in pairs (Mission.LexKillerGang) do
		RemoveUntouchableUnit(value)
		SetInvincible(value, 0.1)
	end
	
	SetVisibility(Mission.LexKillerGang[5], true)
	
	local coordinate =
	{
		["x"] = 35,
		["y"] = 400,
		["z"] = -400
	}
	
	local deviation =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 100
	}
	
	local movCamPos

	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.LexKillerGang[5],
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 5, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.Lexington,
			--["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
	}
	
	MovCamNew_AddPosition(movCamPos)

end

function luaIntroMovie3()
	
	local coordinate =
	{
		["x"] = -14,
		["y"] = 0,
		["z"] = -14
	}
	
	local deviation =
	{
		["x"] = -14,
		["y"] = -0,
		["z"] = -100
	}
	
	local movCamPos

	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.USDDs[2],
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.USDDs[2],
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepy",
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
		
	for key, value in pairs (Mission.LexKillerGang) do
		if key ~= 5 then
			--squadPos[key].y = 1000 + math.mod(key, 2)*100
			--PutTo(value, squadPos[key])
			SetCheatTurbo(value, 8)
			--SquadronEnableVehicleAvoidance(value, true)
			--luaSetScriptTarget(value, Mission.Lexington)
			--EntityTurnToEntity(value, Mission.Lexington)
		else
			Kill(value, true)
		end
	end

	luaDelay(luaResetTurbo, 1.0)
	local livingAttackers = luaRemoveDeadsFromTable(Mission.LexKillerGang)

	deviation =
	{
		["x"] = 70,
		["y"] = 50,
		["z"] = -400
	}
	
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.USDDs[2],
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 2,
		["transformtype"] = "keepy",
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	
	MovCamNew_AddPosition(movCamPos)
	
	luaDelay(luaIntroMovie4, 2)
	luaDelay(luaIntroMovie5, 5)
	
end

function luaIntroMovie4()
	
	local closestPlane
	local distance

	for index, squad in pairs (Mission.LexKillerGang) do
		if not squad.Dead then
			for i=0, 2 do
				local plane = GetSquadronPlane(squad, i)
				if plane then
					local currentDistance = luaGetDistance3D(Mission.Lexington, plane)
	
					if not closestPlane then
						closestPlane = plane
						distance = currentDistance
					elseif currentDistance < distance then
						closestPlane = plane
						distance = currentDistance
					end
				end
			end
		end
	end

	local coordinate =
	{
		["x"] = -14,
		["y"] = 0,
		["z"] = -14
	}
	local deviation =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 0
	}
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = closestPlane,
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 3,
		["transformtype"] = "keepy",
	}
	MovCamNew_AddPosition(movCamPos)

	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.USDDs[2],
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 1,
		["blendtime"] = 2,
		["transformtype"] = "keepy",
		["zoom"] = 2.0, -- FOV-ot leosztja ezzel a szammal
	}
	MovCamNew_AddPosition(movCamPos)
end

function luaIntroMovie5()
	
	local sortedPlanes = {}

	for index, squad in pairs (Mission.LexKillerGang) do
		if not squad.Dead then
			for i=0, 2 do
				local plane = GetSquadronPlane(squad, i)
				if plane then
					local tempTable = {
						["UnitID"] = plane,
						["Distance"] = luaGetDistance3D(Mission.Lexington, plane),
					}

					local newIndex = 1
					if table.getn(sortedPlanes) ~= 0 then
						for key, value in pairs (sortedPlanes) do
							if tempTable.Distance >= value.Distance then
								newIndex = newIndex + 1
							else
								break
							end
						end
					end
					table.insert(sortedPlanes, newIndex, tempTable)
				end
			end
		end
	end

	local selectedPlane = sortedPlanes[math.min(math.max(math.floor(table.getn(sortedPlanes)*0.7), 1), table.getn(sortedPlanes))].UnitID

	local movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = selectedPlane,
			["pos"] = { 0.3, -1.8, -6 },
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["transformtype"] = "keepall",
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	MovCamNew_AddPosition(movCamPos)
	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.Lexington,
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	MovCamNew_AddPosition(movCamPos)

	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = selectedPlane,
			["pos"] = { 0, -4.5, -20 },
		},
		["starttime"] = 1,
		["blendtime"] = 3,
		["transformtype"] = "keepz",
		["nonlinearblend"] = 0.5,
		["zoom"] = 1.0, -- FOV-ot leosztja ezzel a szammal
	}
	MovCamNew_AddPosition(movCamPos)
	
	luaDelay(luaIntroMovie6, 4)
	
end

function luaIntroMovie6()
	
	local relPos = luaGetCamRelPos(Mission.Lexington)
	relPos.y = relPos.y - 140
	movCamPos = {
		["postype"] = "cameraandtarget",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(relPos),
		},
		["starttime"] = 0,
		["blendtime"] = 4,
		["transformtype"] = "keepall",
		["zoom"] = 1.3, -- FOV-ot leosztja ezzel a szammal
		["nonlinearblend"] = 1.9,
	}
	MovCamNew_AddPosition(movCamPos)
end

function luaIntroMovie7()
	
	GenerateObject("NEW_Cloud 01")
	GenerateObject("NEW_Cloud 02")
	GenerateObject("NEW_Cloud 03")
	GenerateObject("NEW_Cloud 04")
	GenerateObject("NEW_Cloud 05")
	GenerateObject("NEW_Cloud 06")
	GenerateObject("NEW_Cloud 07")
	GenerateObject("NEW_Cloud 08")
	GenerateObject("NEW_Cloud 09")
	GenerateObject("NEW_Cloud 10")
	GenerateObject("NEW_Cloud 11")
	GenerateObject("NEW_Cloud 12")
	GenerateObject("NEW_Cloud 13")
	GenerateObject("NEW_Cloud 14")
	GenerateObject("NEW_Cloud 15")
	GenerateObject("NEW_Cloud 16")
	GenerateObject("NEW_Cloud 17")
	GenerateObject("NEW_Cloud 18")
	GenerateObject("NEW_Cloud 19")
	GenerateObject("NEW_Cloud 20")
	GenerateObject("NEW_Cloud 21")
	GenerateObject("NEW_Cloud 22")
	GenerateObject("NEW_Cloud 23")
	GenerateObject("NEW_Cloud 24")
	GenerateObject("NEW_Cloud 25")
	GenerateObject("NEW_Cloud 26")
	GenerateObject("NEW_Cloud 27")
	GenerateObject("NEW_Cloud 28")
	GenerateObject("NEW_Cloud 29")
	GenerateObject("NEW_Cloud 30")
	GenerateObject("NEW_Cloud 31")
	GenerateObject("NEW_Cloud 32")
	GenerateObject("NEW_Cloud 33")
	GenerateObject("NEW_Cloud 34")
	GenerateObject("NEW_Cloud 35")
	GenerateObject("NEW_Cloud 36")
	GenerateObject("NEW_Cloud 37")
	GenerateObject("NEW_Cloud 38")
	GenerateObject("NEW_Cloud 39")
	GenerateObject("NEW_Cloud 40")
	GenerateObject("NEW_Cloud 41")
	GenerateObject("NEW_Cloud 42")
	GenerateObject("NEW_Cloud 43")
	GenerateObject("NEW_Cloud 44")
	GenerateObject("NEW_Cloud 45")
	GenerateObject("NEW_Cloud 46")
	GenerateObject("NEW_Cloud 47")
	GenerateObject("NEW_Cloud 48")
	GenerateObject("NEW_Cloud 49")
	GenerateObject("NEW_Cloud 50")
	GenerateObject("NEW_Cloud 51")
	GenerateObject("NEW_Cloud 52")
	GenerateObject("NEW_Cloud 53")
	GenerateObject("NEW_Cloud 54")
	GenerateObject("NEW_Cloud 55")
	GenerateObject("NEW_Cloud 56")
	GenerateObject("NEW_Cloud 57")
	GenerateObject("NEW_Cloud 58")
	GenerateObject("NEW_Cloud 59")
	GenerateObject("NEW_Cloud 60")
	GenerateObject("NEW_Cloud 61")
	GenerateObject("NEW_Cloud 62")
	GenerateObject("NEW_Cloud 63")
	GenerateObject("NEW_Cloud 64")
	GenerateObject("NEW_Cloud 65")
	GenerateObject("NEW_Cloud 66")
	GenerateObject("NEW_Cloud 67")
	GenerateObject("NEW_Cloud 68")
	GenerateObject("NEW_Cloud 69")
	GenerateObject("NEW_Cloud 70")
	GenerateObject("NEW_Cloud 71")
	GenerateObject("NEW_Cloud 72")
	
	local movCamPos
	movCamPos = {
		["postype"] = "cameraandtarget",
		["position"] = 
		{
			["parent"] = Mission.Yorktown,
			["modifier"] = 
				{
					["name"] = "gamecamera"
				},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
	}
	MovCamNew_AddPosition(movCamPos)

	NavigatorStop(Mission.Lexington)
	--[[AddPartDamage(Mission.Lexington, DAM_BODY, 0, 1000000)
	AddPartDamage(Mission.Lexington, DAM_ENGINEROOM, 0, 1000000)
	AddPartDamage(Mission.Lexington, DAM_FUELTANK, 0, 1000000)
	AddPartDamage(Mission.Lexington, DAM_STEERING, 0, 1000000)
	AddPartDamage(Mission.Lexington, DAM_MAGAZINE, 0, 1000000)]]
	AddWaterLoad(Mission.Lexington, 0, 1000000)
	AddWaterLoad(Mission.Lexington, 1, 1000000)
	AddWaterLoad(Mission.Lexington, 2, 1000000)
	AddWaterLoad(Mission.Lexington, 3, 1000000)
	AddWaterLoad(Mission.Lexington, 4, 1000000)
	AddWaterLoad(Mission.Lexington, 5, 1000000)
	SetFailure(Mission.Lexington, "RunwayFailure", 180)
	OverrideHP(Mission.Lexington, 0.01)
	
	local pos = {["x"]=0, ["y"] = Mission.Lexington.Class.Height+3, ["z"]=0 }
	Effect("RealGiantSmoke", pos, Mission.Lexington, 20)
	
	luaDelay(luaLexLost, luaRnd(80, 120))
	
end

function luaIntroMovie8()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.LexKillerGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LexKillerGang)) do
			
			if unit and not unit.Dead then
				
				local point = GetClosestBorderZone(GetPosition(unit))
				PilotMoveTo(unit, point)
			
			end
			
		end
	
	end
	
	local coordinate =
	{
		["x"] = -16,
		["y"] = 8,
		["z"] = 180
	}
	local deviation =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 0
	}
	local movCamPos

	movCamPos = {
		["postype"] = "target",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(deviation),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1, -- FOV-ot leosztja ezzel a szammal
		["transformtype"] = "keepall",
	}
	MovCamNew_AddPosition(movCamPos)
	movCamPos = {
		["postype"] = "camera",
		["position"] = {
			["parent"] = Mission.Lexington,
			["pos"] = luaConvertXYZTo123(coordinate),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1, -- FOV-ot leosztja ezzel a szammal
		["transformtype"] = "keepall",
	}
	MovCamNew_AddPosition(movCamPos)
end

function luaIntroMovieEnd()

	if IsListenerActive("hit", "LexingtonHitListener") then
	
		RemoveListener("hit", "LexingtonHitListener")
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.LexKillerGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LexKillerGang)) do
			
			if unit and not unit.Dead then
				
				Kill(unit, true)
			
			end
			
		end
	
	end
	
	if not Mission.LexBlownUp then
	
		ExplodeToParts(Mission.Lexington)
	
	end
	
	NavigatorSetTorpedoEvasion(Mission.Lexington, false)
	NavigatorSetAvoidLandCollision(Mission.Lexington, false)
	AAEnable(Mission.Lexington, false)
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	EnableMessages(true)
	--EnableInput(true)
	
	SetSelectedUnit(Mission.Yorktown)
	
	Mission.IntroOver = true
	
	luaAddFirstObjs()
	
	luaAddCVListener()
	luaAddBomberListener()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.JapCVs)
	luaObj_Add("primary", 2, Mission.Yorktown)
	luaObj_Add("primary", 3, Mission.Donald)
	
	DisplayUnitHP((Mission.ayyycykablyat), "Protect the Yorktown from sinking!")
	
	luaObj_Add("hidden", 1)

end

function luaResetTurbo()
	for key, value in pairs (Mission.LexKillerGang) do
		if not value.Dead then
			SetCheatTurbo(value, 1)
		end
	end
end

function luaLexLost()

	luaStartDialog("BLOWN")

end

function luaLexSink()

	SetInvincible(Mission.Lexington, 0)
	EnableMessages(Mission.Lexington, false)
	SetDeadMeat(Mission.Lexington)
	Scoring_AddPartyLoss(PARTY_ALLIED, "Lexington")

end

---- LISTENERS ----

function luaAddCVHitListener()

	AddListener("hit", "CVHitListener", {
		["callback"] = "luaCVHit",
		["target"] = Mission.JapCVs,
		["targetDevice"] = {"LIGHTARTILLERY", "MEDIUMARTILLERY", "HEAVYARTILLERY", "BOMB", "TORPEDO", "FLAK"},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddCVListener()

	AddListener("recon", "CVListener", {
		["callback"] = "luaCVSighted",
		["entity"] = Mission.JapGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddBomberListener()

	AddListener("recon", "BomberListener", {
		["callback"] = "luaBomberSighted",
		["entity"] = Mission.InitialBombers,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddLexingtonHitListener()
	
	AddListener("hit", "LexingtonHitListener", {
		["callback"] = "luaLexingtonHit",
		["target"] = {Mission.Lexington},
		["targetDevice"] = {},
		["attacker"] = Mission.LexKillerGang,
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

---- LISTENER CALLBACKS ----

function luaCVHit()

	RemoveListener("hit", "CVHitListener")
	
	luaStartDialog("DMG")

end

function luaCVSighted()

	RemoveListener("recon", "CVListener")
	
	luaStartDialog("LOCATED")
	
	luaAddCVHitListener()
	
end

function luaBomberSighted()

	RemoveListener("recon", "BomberListener")
	
	luaStartDialog("INCOMING")

end

function luaLexingtonHit()
	
	if Mission.LexHits < 4 then
		
		Mission.LexHits = Mission.LexHits + 1
	
	else
		
		RemoveListener("hit", "LexingtonHitListener")
		
		luaBlowUp(Mission.Lexington)
		
		Mission.LexBlownUp = true
		
	end
	
	if not Mission.LexDiaStarted then
	
		luaStartDialog("LEX")
		
		Mission.LexDiaStarted = true
	
	end
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	Mission.EndMission = true
	
	HideUnitHP()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	local trg
	
	if Mission.ZuikakuDmg then
	
		trg = Mission.Zuikaku
	
	elseif Mission.ShokakuDmg then
	
		trg = Mission.Shokaku
	
	end
	
	luaMissionCompletedNew(trg, "Enemy carriers are retreating - Mission Complete", "campaigns/BSM/m0902.bik")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true
	
	HideUnitHP()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
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