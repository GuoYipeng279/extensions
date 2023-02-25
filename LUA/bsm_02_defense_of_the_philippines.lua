---- DEFENCE OF THE PHILIPPINES (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- DEFENCE OF THE PHILIPPINES (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(154) 	-- Ki-43
	PrepareClass(158) 	-- D3A
	PrepareClass(162) 	-- B5N
	PrepareClass(167) 	-- G4M
	
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
	
	LoadMessageMap("bsmdlg",2)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_02_defense_of_the_philippines.lua"

	this.Name = "BSM02"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Boat",
				["Text"] = "Your boat must not sink!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Leave",
				["Text"] = "Leave the harbor!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Land",
				["Text"] = "The Japanese must not land more than five boats!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Trans",
				["Text"] = "Sink the Japanese transport ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Destroy",
				["Text"] = "Destroy all Japanese landing craft!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Compl",
				["Text"] = "Completely destroy the first wave of landing boats!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "DD",
				["Text"] = "Sink the enemy destroyer!",
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
			},
		},
		["MOVING"] = {
			["sequence"] = {
				{
					["message"] = "MOVING1",
				},
				{
					["message"] = "MOVING2",
				},
				{
					["message"] = "MOVING3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["JUICE"] = {
			["sequence"] = {
				{
					["message"] = "JUICE1",
				},
				{
					["message"] = "JUICE2",
				},
			},
		},
		["CLEARED"] = {
			["sequence"] = {
				{
					["message"] = "CLEARED1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaDelayedPh2Move",
				},
			},
		},
		["EARS"] = {
			["sequence"] = {
				{
					["message"] = "EARS1",
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
				{
					["type"] = "callback",
					["callback"] = "luaAddLandingObj",
				},
			},
		},
		["BIGBOYS"] = {
			["sequence"] = {
				{
					["message"] = "BIGBOYS1",
				},
				{
					["message"] = "BIGBOYS2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddBigBoysObj",
				},
			},
		},
		["KENNEDY1"] = {
			["sequence"] = {
				{
					["message"] = "KENNEDY1",
				},
			},
		},
		["KENNEDY2"] = {
			["sequence"] = {
				{
					["message"] = "KENNEDY2",
				},
			},
		},
		["OUT"] = {
			["sequence"] = {
				{
					["message"] = "OUT1",
				},
			},
		},
		["OUTSTANDING"] = {
			["sequence"] = {
				{
					["message"] = "OUTSTANDING1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObj",
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
	
	---- MUSIC ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- USN ----
	
	Mission.Henry = FindEntity("HenryPT")
	
	ShipSetTorpedoStock(Mission.Henry, 12)
	OverrideHP(Mission.Henry, Mission.Henry.Class.HP * 2)
	
	Mission.Kennedy = FindEntity("PT-109")
	
	ShipSetTorpedoStock(Mission.Kennedy, 12)
	
	SetRoleAvailable(FindEntity("Platte"), EROLF_ALL, PLAYER_AI)
	AAEnable(FindEntity("Platte"), false)
	
	Mission.Cat = FindEntity("F4F Wildcat")
	
	Mission.AmmoPoint = GetPosition(FindEntity("HenryPT"))
	
	Mission.PTGang = {}
		table.insert(Mission.PTGang, FindEntity("PT-109"))
		table.insert(Mission.PTGang, FindEntity("PT-110"))
	
	for idx,unit in pairs(Mission.PTGang) do
		
		SetInvincible(unit, 0.4)
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
	end
	
	Mission.RescueGang = {}
		table.insert(Mission.RescueGang, FindEntity("Rescue 1"))
		table.insert(Mission.RescueGang, FindEntity("Rescue 2"))
	
	for idx,unit in pairs(Mission.RescueGang) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
	end
	
	Mission.BruhGang = {}
		table.insert(Mission.BruhGang, FindEntity("Bon Adventure"))
		table.insert(Mission.BruhGang, FindEntity("Shark Chaser"))
	
	for idx,unit in pairs(Mission.BruhGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
	end
	
	Mission.PatrolLines = {}
		table.insert(Mission.PatrolLines, FindEntity("path_Patrol 1"))
		table.insert(Mission.PatrolLines, FindEntity("path_Patrol 2"))
	
	Mission.JapBombTrgGang = {}
		table.insert(Mission.JapBombTrgGang, FindEntity("Platte"))
		table.insert(Mission.JapBombTrgGang, FindEntity("Rescue 1"))
		table.insert(Mission.JapBombTrgGang, FindEntity("Rescue 2"))
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do

		if not unit.Dead and (string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Coastal Gun")) then
			
			table.insert(Mission.JapBombTrgGang, unit)
			
		end
		
	end
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do

		if not unit.Dead and (string.find(unit.Name, "Static B-25") or string.find(unit.Name, "Static warhawk")) then
			
			table.insert(Mission.JapBombTrgGang, unit)
			
		end
		
	end
	
	Mission.JapTorpTrgGang = {}
		table.insert(Mission.JapTorpTrgGang, FindEntity("Platte"))
		table.insert(Mission.JapTorpTrgGang, FindEntity("Bon Adventure"))
		table.insert(Mission.JapTorpTrgGang, FindEntity("Shark Chaser"))
	
	Mission.PlayerEvacPoint = {}
		Mission.PlayerEvacPoint.x = 1270
		Mission.PlayerEvacPoint.y = 0
		Mission.PlayerEvacPoint.z = -646
	
	---- IJN ----
	
	Mission.TypeKi43 = 154
	Mission.TypeD3A = 158
	Mission.TypeB5N = 162
	Mission.TypeG4M = 167
	
	Mission.JapSpawn = FindEntity("JapSpawn")
	
	Mission.InvasionMain = {}
		table.insert(Mission.InvasionMain, luaFindHidden("Miharu Maru"))
		table.insert(Mission.InvasionMain, luaFindHidden("Nikkoku Maru"))
		table.insert(Mission.InvasionMain, luaFindHidden("Akebono Maru"))
	
	Mission.InvasionTemplates = {}
		table.insert(Mission.InvasionTemplates, luaFindHidden("Invasion 1"))
		table.insert(Mission.InvasionTemplates, luaFindHidden("Invasion 2"))
		table.insert(Mission.InvasionTemplates, luaFindHidden("Invasion 3"))
		table.insert(Mission.InvasionTemplates, luaFindHidden("Invasion 4"))
		table.insert(Mission.InvasionTemplates, luaFindHidden("Invasion 5"))
	
	Mission.InvasionMainPathGang = {}
		table.insert(Mission.InvasionMainPathGang, FindEntity("path_TP1"))
		table.insert(Mission.InvasionMainPathGang, FindEntity("path_TP2"))
		table.insert(Mission.InvasionMainPathGang, FindEntity("path_TP3"))
	
	Mission.JapInvasionPathGang = {}
		table.insert(Mission.JapInvasionPathGang, FindEntity("path_Invasion 1"))
		table.insert(Mission.JapInvasionPathGang, FindEntity("path_Invasion 2"))
		table.insert(Mission.JapInvasionPathGang, FindEntity("path_Invasion 3"))
		table.insert(Mission.JapInvasionPathGang, FindEntity("path_Invasion 4"))
		table.insert(Mission.JapInvasionPathGang, FindEntity("path_Invasion 5"))
	
	Mission.Invasion = {}
	Mission.InvasionFirstWave = {}
	Mission.InvasionTotal = {}
	
	Mission.JapBomberGang = {}
	Mission.JapBombBomberGang = {}
	Mission.JapTorpBomberGang = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.SpawnedInvasionNum = 0
	Mission.SpawnedInvasionWave = 0
	Mission.JapBoatsLanded = 0
	
	Mission.BettyCanSpawn = true
	Mission.NoTorpCanSpeak = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapFighterNum = 2
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapFighterNum = 2
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapFighterNum = 3
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	ForceEnableInput(IC_MAP_TOGGLE, false)
	
	Blackout(true, "", true)
	
	MissionNarrative("December 13th, 1941 - The Philippine Islands")
	luaStartDialog("INTRO")
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPath(FindEntity("AvoidZoneG all 0 #003"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
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
		
		luaStartMission()
		
		Mission.Started = true
		
	end
	
	if Mission.MissionPhase < 99 then
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
		Mission.HenryTorps = GetProperty(Mission.Henry, "TorpedoStock")
		
		if Mission.Henry.Dead then
		
			luaMissionFailed(Mission.Henry)
		
		end
		
		if luaObj_IsActive("primary",3) then
		
			local line1 = "The Japanese must not land more than 5 boats!"
			local line2 = "Japanese boats landed: #Mission.JapBoatsLanded#"
			luaDisplayScore(1, line1, line2)
			
			if Mission.JapBoatsLanded >= 5 then
			
				luaMissionFailed(luaPickRnd(Mission.Invasion))
			
			end
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Invasion)) do
			
				if unit.LandingStarted and not unit.counted then
				
					Mission.JapBoatsLanded = Mission.JapBoatsLanded + 1
					
					unit.counted = true
					
				end
				
			end
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTGang)) do
			
				if unit.LandingStarted and not unit.counted then
				
					Mission.JapBoatsLanded = Mission.JapBoatsLanded + 1
					
					unit.counted = true
					
				end
				
			end
			
		else
		
			HideScoreDisplay(1,0)
		
		end
		
		if luaObj_IsActive("hidden",1) then
		
			if Mission.Kasumi.Dead then
			
				luaObj_Completed("hidden", 1)
			
			end
		
		end
		
		if Mission.HenryTorps == 0 and not Mission.NoTorpSpoke and Mission.NoTorpCanSpeak then
		
			luaNoTorpsDia()
			
			Mission.NoTorpSpoke = true
			Mission.NoTorpCanSpeak = false
			
			luaDelay(luaResetNoTorpDia, 60)
			
		end
		
		if luaGetDistance(Mission.Henry, Mission.AmmoPoint) < 250 and Mission.HenryTorps < 12 then

			MissionNarrative("Your torpedoes have been reloaded")
			ShipSetTorpedoStock(Mission.Henry, 12)
			
			Mission.NoTorpCanSpeak = true
			
		end
		
	end
	
	if Mission.MissionPhase == 1 then
		
		if luaObj_IsActive("primary",2) then
		
			luaDistanceCounter(Mission.Henry, Mission.PlayerEvacPoint, 1, "Leave the harbor!", "ijn14.distance")
			
			if luaGetDistance(Mission.Henry, Mission.PlayerEvacPoint) < 450 then
			
				luaObj_Completed("primary", 2)
				HideScoreDisplay(1,0)
				
				luaStartDialog("CLEARED")
			
			end
			
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapBombBomberGang)) do
			
			if unit and not unit.Dead then
				
				local ammo = GetProperty(unit, "ammoType")
				
				if ammo == 1 then
				
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					
						local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapBombTrgGang))
						
						if trg and not trg.Dead then
						
							luaSetScriptTarget(unit, trg)
							PilotSetTarget(unit, trg)
						
						elseif trg == nil then
						
							if not unit.retreating then
							
								PilotRetreat(unit)
								
								unit.retreating = true
							
							end
						
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
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapTorpBomberGang)) do
			
			if unit and not unit.Dead then
				
				local ammo = GetProperty(unit, "ammoType")
				
				if ammo == 2 then
				
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					
						local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapTorpTrgGang))
						
						if trg and not trg.Dead then
						
							luaSetScriptTarget(unit, trg)
							PilotSetTarget(unit, trg)
						
						elseif trg == nil then
						
							if not unit.retreating then
							
								PilotRetreat(unit)
								
								unit.retreating = true
							
							end
						
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
	
	elseif Mission.MissionPhase == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.InvasionFirstWave)) == 0 then
			
			luaObj_Completed("secondary", 1)
			luaMoveToPh3()
		
		end
	
	elseif Mission.MissionPhase == 3 then
	
		if table.getn(luaRemoveDeadsFromTable(Mission.InvasionMain)) == 0 then
			
			HideUnitHP()
			luaObj_Completed("primary", 4)
			luaMoveToPh4()
		
		end
		
		if Mission.KennedyAttacking then
		
			if Mission.KennedyTarget.Dead then
			
				luaStartDialog("KENNEDY2")
				
				NavigatorMoveOnPath(Mission.Kennedy, Mission.PatrolLines[1], PATH_FM_CIRCLE)
				
				Mission.KennedyAttacking = false
			
			end
		
		end
		
	elseif Mission.MissionPhase == 4 then
		
		Mission.InvasionTotal = luaRemoveDeadsFromTable(Mission.InvasionTotal)
		
		if table.getn(luaRemoveDeadsFromTable(Mission.InvasionTotal)) == 0 then
		
			HideUnitHP()
			luaObj_Completed("primary", 5)
			
			luaMissionComplete(luaPickRnd(Mission.Invasion))
		
		end
		
	end
	
	---- TEST ----
	
end

---- OSCAR FLOW -----

function luaInitOscarFlow()

	if Mission.OscarsFlowing then
		
		if not Mission.HuntingOscar or Mission.HuntingOscar.Dead then
			
			local whyareyougay = random(1,2)
			
			local posx
			local posy = -2700
			
			if whyareyougay == 1 then
			
				posx = -2700
			
			elseif whyareyougay == 2 then
			
				posx = 2700
			
			end
			
			luaSpawnJap(Mission.TypeKi43, Mission.JapFighterNum, GetPosition(Mission.Henry), 0, posy, 100, posx)
		
		end
		
		luaDelay(luaInitOscarFlow, 8)
		
	end

end

---- PHASE 4 ----

function luaMoveToPh4()

	Mission.MissionPhase = 4
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Invasion)) do
	
		if unit and not unit.Dead then
		
			table.insert(Mission.InvasionTotal, unit)
		
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTGang)) do
	
		if unit and not unit.Dead then
		
			table.insert(Mission.InvasionTotal, unit)
		
		end
	
	end
	
	luaStartDialog("OUTSTANDING")

end

function luaAddFinalObj()
	
	Mission.InvasionTotal = luaRemoveDeadsFromTable(Mission.InvasionTotal)
	
	luaObj_Add("primary", 5, Mission.InvasionTotal)
	
	DisplayUnitHP((Mission.InvasionTotal), "Destroy all Japanese landing craft!")
	
end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaStartDialog("BIGBOYS")

end

function luaAddBigBoysObj()

	luaObj_Add("primary", 4, Mission.InvasionMain)
	
	DisplayUnitHP((Mission.InvasionMain), "Sink the Japanese transport ships!")
	
	SetRoleAvailable(Mission.Henry, EROLF_TORPEDO, PLAYER_ANY)
	
	luaDelay(luaKennedyAttack, 2)
	
end

function luaKennedyAttack()
	
	NavigatorAttackMove(Mission.Kennedy, Mission.KennedyTarget)
	
	luaStartDialog("KENNEDY1")
	
	Mission.KennedyAttacking = true

end

function luaNoTorpsDia()

	luaStartDialog("OUT")

end

function luaResetNoTorpDia()

	Mission.NoTorpSpoke = false

end

---- PHASE 2 ----

function luaDelayedPh2Move()

	luaDelay(luaMoveToPh2, 1.2)

end

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	luaKillOffJaps()
	
	if Mission.Cat and not Mission.Cat.Dead then
	
		Kill(Mission.Cat,true)
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.RescueGang)) do
	
		if unit and not unit.Dead then
		
			Kill(unit,true)
		
		end
	
	end
	
	Mission.InvasionMain = luaGenerateObjects(Mission.InvasionMain)
	Mission.KennedyTarget = FindEntity("Akebono Maru")
	
	NavigatorMoveToRange(Mission.Kennedy, FindEntity("KennedyGoTo"))
	
	for idx,unit in pairs(Mission.InvasionMain) do
		
		OverrideHP(unit, unit.Class.HP / 2)
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorEnable(unit, true)
		ArtilleryEnable(unit, false)
		AAEnable(unit, false)
		UnitHoldFire(unit)
		
		if Mission.Difficulty == 0 then
			
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 then
		
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
		
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	--PutTo(FindEntity("Miharu Maru"), FillPathPoints(FindEntity("TransGoTo1"))[3])
	--PutTo(FindEntity("Nikkoku Maru"), FillPathPoints(FindEntity("TransGoTo2"))[4])
	--PutTo(FindEntity("Akebono Maru"), FillPathPoints(FindEntity("TransGoTo3"))[4])
	
	PutTo(FindEntity("Miharu Maru"), FillPathPoints(FindEntity("path_TP1"))[1])
	--NavigatorMoveOnPath(FindEntity("Miharu Maru"), FindEntity("path_TP1"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveToPos(FindEntity("Miharu Maru"), luaGetPathPoint(FindEntity("path_TP1"), "last"))
	PutTo(FindEntity("Nikkoku Maru"), FillPathPoints(FindEntity("path_TP2"))[1])
	--NavigatorMoveOnPath(FindEntity("Nikkoku Maru"), FindEntity("path_TP2"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveToPos(FindEntity("Nikkoku Maru"), luaGetPathPoint(FindEntity("path_TP2"), "last"))
	PutTo(FindEntity("Akebono Maru"), FillPathPoints(FindEntity("path_TP3"))[1])
	--NavigatorMoveOnPath(FindEntity("Akebono Maru"), FindEntity("path_TP3"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	NavigatorMoveToPos(FindEntity("Akebono Maru"), luaGetPathPoint(FindEntity("path_TP3"), "last"))
	
	Mission.LST1 = GenerateObject("Type1")
	Mission.LST2 = GenerateObject("Type1_2")
	
	Mission.LSTGang = {}
		table.insert(Mission.LSTGang, FindEntity("Type1"))
		table.insert(Mission.LSTGang, FindEntity("Type1_2"))
	
	for idx,unit in pairs(Mission.LSTGang) do
		
		SetShipMaxSpeed(unit, 6)
		SetGuiName(unit, "globals.unitclass_lst")
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		AAEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
			ArtilleryEnable(unit, false)
		
		elseif Mission.Difficulty == 1 then
		
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			ArtilleryEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
		
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			ArtilleryEnable(unit, true)
		
		end
		
		NavigatorMoveOnPath(unit, luaPickRnd(Mission.JapInvasionPathGang))
		
	end
	
	Mission.Kasumi = GenerateObject("Kasumi")
	
	NavigatorMoveOnPath(Mission.PTGang[2], Mission.PatrolLines[2], PATH_FM_CIRCLE)
	
	NavigatorSetTorpedoEvasion(Mission.Kasumi, false)
	RepairEnable(Mission.Kasumi, false)
	ArtilleryEnable(Mission.Kasumi, false)
	AAEnable(Mission.Kasumi, false)
	
	luaSpawnLandingWave()
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaDelay(luaLandingDia, 2)
	
end

function luaSpawnLandingWave()

	if table.getn(luaRemoveDeadsFromTable(Mission.InvasionMain)) > 0 then
		
		Mission.Landing1 = GenerateObject("Invasion 1")
		Mission.Landing2 = GenerateObject("Invasion 2")
		Mission.Landing3 = GenerateObject("Invasion 3")
		Mission.Landing4 = GenerateObject("Invasion 4")
		Mission.Landing5 = GenerateObject("Invasion 5")
		
		luaInvasionWaveSpawned(Mission.Landing1)
		luaInvasionWaveSpawned(Mission.Landing2)
		luaInvasionWaveSpawned(Mission.Landing3)
		luaInvasionWaveSpawned(Mission.Landing4)
		luaInvasionWaveSpawned(Mission.Landing5)
		
		luaDelay(luaSpawnLandingWave, 80)
		
	end

end

function luaInvasionWaveSpawned(unit)
	
	Mission.InvasionMain = luaRemoveDeadsFromTable(Mission.InvasionMain)
	
	Mission.SpawnedInvasionNum = Mission.SpawnedInvasionNum + 1
	
	table.insert(Mission.Invasion, unit)
	
	if Mission.SpawnedInvasionWave == 0 then
	
		table.insert(Mission.InvasionFirstWave, unit)
	
	end
	
	NavigatorSetAvoidLandCollision(unit, false)
	NavigatorSetAvoidShipCollision(unit, false)
	SetShipMaxSpeed(unit, luaRnd(3*unit.Class.MaxSpeed/4, unit.Class.MaxSpeed))
	
	if Mission.SpawnedInvasionNum == 1 then

		PutRelTo(unit,Mission.InvasionMain[1],{["x"]=-30,["y"]=0,["z"]=-20})
		
	elseif Mission.SpawnedInvasionNum == 2 then

		PutRelTo(unit,Mission.InvasionMain[1],{["x"]=30,["y"]=0,["z"]=-20})

	elseif Mission.SpawnedInvasionNum == 3 then

		PutRelTo(unit,Mission.InvasionMain[1],{["x"]=30,["y"]=0,["z"]=30})

	elseif Mission.SpawnedInvasionNum == 4 then

		if Mission.InvasionMain[2] ~= nil then
			
			PutRelTo(unit,Mission.InvasionMain[2],{["x"]=-30,["y"]=0,["z"]=0})
			
		else
			
			PutRelTo(unit,Mission.InvasionMain[1],{["x"]=-50,["y"]=0,["z"]=0})
			
		end

	elseif Mission.SpawnedInvasionNum == 5 then

		if Mission.InvasionMain[2] ~= nil then
			
			PutRelTo(unit,Mission.InvasionMain[2],{["x"]=30,["y"]=0,["z"]=0})
			
		else
			
			PutRelTo(unit,Mission.InvasionMain[1],{["x"]=50,["y"]=0,["z"]=0})
			
		end

	end
	
	NavigatorMoveOnPath(unit, Mission.JapInvasionPathGang[Mission.SpawnedInvasionNum], PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	
	if Mission.SpawnedInvasionNum == 5 then
		
		Mission.SpawnedInvasionNum = 0
		Mission.SpawnedInvasionWave = Mission.SpawnedInvasionWave + 1

	end
	
end

function luaAddLandingObj()

	luaObj_Add("primary", 3)
	luaObj_Add("secondary", 1, Mission.InvasionFirstWave)
	luaObj_Add("hidden", 1)
	
	Mission.OscarsFlowing = true
	luaDelay(luaInitOscarFlow, 8)
	
end

function luaLandingDia()

	luaStartDialog("LANDING")

end

---- PHASE 1 ----

function luaStartMission()
	
	luaGenerateJapBomberTraffic()
	
	SetRoleAvailable(Mission.Henry, EROLF_PILOT, PLAYER_AI)
	SetRoleAvailable(Mission.Henry, EROLF_TORPEDO, PLAYER_AI)
	SetRoleAvailable(Mission.Henry, EROLF_DEPTHCHARGE, PLAYER_AI)
	NavigatorEnable(Mission.Henry, false)
	EnableEngineSound(Mission.Henry, false)
	
	luaDelay(luaEngineFail, 9)
	luaDelay(luaEngineFail, 11)
	luaDelay(luaMovingDia, 10)
	
	Blackout(false, "", 1)
	
	local target =
	{
		["postype"] = "cameraandtarget",
		["position"] = 
		{
			["parent"] = Mission.Henry,
			--["polar"] = {900, 20, -40}
			["polar"] = {1200, 10, 160}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
	}
	
	MovCamNew_AddPosition(target)

	local target =
	{
		["postype"] = "cameraandtarget",
		["position"] = 
		{
			["parent"] = Mission.Henry,
			["modifier"] =
			{
				["name"] = "gamecamera"
			}
			--["polar"] = {70, 10, -40}
		},
		["starttime"] = 0,
		["blendtime"] = 21,
		["nonlinearblend"] = 3,
		["finishscript"] = "luaStartMissionMovieEnd"
	}
	
	MovCamNew_AddPosition(target)

end

function luaStartMissionMovieEnd()

	SetSelectedUnit(Mission.Henry)

end

function luaGenerateJapBomberTraffic()
	
	if Mission.MissionPhase == 1 then
		
		luaSpawnJap(Mission.TypeD3A, 3, GetPosition(Mission.JapSpawn), 1, -4000, 80, 50)
		luaSpawnJap(Mission.TypeD3A, 3, GetPosition(Mission.JapSpawn), 1, -4000, 80, -50)
		luaSpawnJap(Mission.TypeD3A, 3, GetPosition(Mission.JapSpawn), 1, -4000, 80, -150)
		
		if Mission.BettyCanSpawn then
			
			local hellohowareyou = random(0, -1500)
			local imgoodhowareyou = random(1, 2)
			
			luaSpawnJap(Mission.TypeG4M, 2, GetPosition(Mission.JapSpawn), imgoodhowareyou, -4000, 125, hellohowareyou)
			
			Mission.BettyCanSpawn = false
			
		elseif not Mission.BettyCanSpawn then
			
			luaSpawnJap(Mission.TypeKi43, Mission.JapFighterNum, GetPosition(Mission.JapSpawn), 0, -4000, 100, -350)
			
			Mission.BettyCanSpawn = true
			
		end
		
		luaDelay(luaGenerateJapBomberTraffic, 33)
	
	end

end

function luaSpawnJap(class, wngCount, pos, equipment, spawnDeltaY, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = spawnpos.y + alt
	spawnpos.z = spawnpos.z + spawnDeltaY
	
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = class,
				["Name"] = "Jap",
				["Crew"] = Mission.JapAI,
				["Race"] = Japan,
				["WingCount"] = wngCount,
				["Equipment"] = equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaJapSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})

end

function luaJapSpawned(unit)
	
	if Mission.MissionPhase == 1 then
	
		local unitpos = GetPosition(unit)
		local alt = unitpos.y
		
		if unit.Class.Name == "globals.unitclass_oscar" then
			
			PilotSetTarget(unit, Mission.Henry)
			
			table.insert(Mission.JapBomberGang, unit)
			
		elseif unit.Class.Name == "globals.unitclass_val" then
			
			SquadronSetTravelAlt(unit, alt, true)
			SquadronSetAttackAlt(unit, alt, true)
			
			table.insert(Mission.JapBombBomberGang, unit)
			table.insert(Mission.JapBomberGang, unit)
			
		elseif unit.Class.Name == "globals.unitclass_betty" then
			
			SquadronSetTravelAlt(unit, 200, true)
			
			local ammo = GetProperty(unit, "ammoType")
			
			if ammo == 1 then
			
				SquadronSetAttackAlt(unit, 200, true)
			
				table.insert(Mission.JapBombBomberGang, unit)
				
			elseif ammo == 2 then
				
				SquadronSetAttackAlt(unit, 30, true)
				
				table.insert(Mission.JapTorpBomberGang, unit)
			
			end
			
			table.insert(Mission.JapBomberGang, unit)
		
		end
	
	elseif Mission.MissionPhase > 1 then
		
		PilotSetTarget(unit, Mission.Henry)
		
		Mission.HuntingOscar = unit
		
	end
	
end

function luaKillOffJaps()

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapBomberGang)) do
	
		if unit and not unit.Dead then
		
			Kill(unit,true)
		
		end
	
	end

end

function luaMovingDia()

	luaStartDialog("MOVING")
	
end

function luaEngineFail()
	
	if not Mission.EngineStarted then
	
		Effect("BoatEngineStartFail", GetPosition(Mission.Henry))
	
	end
	
	if Mission.EngineStarting then
	
		luaDelay(luaEngineFail, 5)
	
	end
	
end

function luaEngineStart()
	
	Mission.EngineStarting = false
	Mission.EngineStarted = true
	
	Effect("BoatEngineStart", GetPosition(Mission.Henry))
	
	luaDelay(luaEngineOn, 1.2)
	
end

function luaEngineOn()

	EnableEngineSound(Mission.Henry, true)
	SetRoleAvailable(Mission.Henry, EROLF_PILOT, PLAYER_ANY)
	NavigatorEnable(Mission.Henry, true)
	
	luaStartDialog("JUICE")

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2, Mission.PlayerEvacPoint)
	
	luaDelay(luaPatrol1On, 2)
	luaDelay(luaPatrol2On, 8)
	luaStartRescues()
	
	EnableMessages(true)
	
	Mission.EngineStarting = true
	
	luaDelay(luaEngineFail, 2)
	luaDelay(luaEngineStart, 75)
	
end

function luaPatrol1On()
	
	if Mission.PTGang[1] and not Mission.PTGang[1].Dead then
		
		NavigatorEnable(Mission.PTGang[1], true)
		NavigatorMoveToRange(Mission.PTGang[1], luaGetPathPoint(Mission.PatrolLines[1], "last"))
	
	end
	
end

function luaPatrol2On()
	
	if Mission.PTGang[2] and not Mission.PTGang[2].Dead then
		
		NavigatorEnable(Mission.PTGang[2], true)
		NavigatorMoveToRange(Mission.PTGang[2], luaGetPathPoint(Mission.PatrolLines[2], "last"))
	
	end
	
end

function luaStartRescues()

	NavigatorMoveOnPath(Mission.RescueGang[1], FindEntity("path_rescue"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	
	luaDelay(luaStartRescues2, 8)
	
end

function luaStartRescues2()

	NavigatorMoveOnPath(Mission.RescueGang[2], FindEntity("path_rescue"), PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
	
end

---- MOVIES ----

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m0202.bik")

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
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(unit, "Enemy Forces have been destroyed - Mission Complete", "campaigns/BSM/m0203.bik")
	
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
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Failed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
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