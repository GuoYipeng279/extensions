---- RENDEZVOUS IN THE JAVA SEA (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- RENDEZVOUS IN THE JAVA SEA (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(158) -- Val
	PrepareClass(162) -- Kate
	
	PrepareClass(31) -- Narwhal
	
	PrepareClass(93) -- Type B
	PrepareClass(60) -- Kongo
	
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
	
	LoadMessageMap("bsmdlg",7)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_07_rand_java_sea.lua"

	this.Name = "BSM07"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Meet",
				["Text"] = "Meet with Royal Navy forces at the given coordinates ASAP!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Houston",
				["Text"] = "The Houston must not sink!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "BB",
				["Text"] = "Sink the battleship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Sub",
				["Text"] = "Destroy the enemy submarine!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Exeter",
				["Text"] = "HMS Exeter must survive!",
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
				["Text"] = "Destroy all enemy ships!",
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
		["GANG"] = {
			["sequence"] = {
				{
					["message"] = "GANG1",
				},
				{
					["message"] = "GANG2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["KATE"] = {
			["sequence"] = {
				{
					["message"] = "KATE1",
				},
				{
					["message"] = "KATE2",
				},
			},
		},
		["PERISCOPE"] = {
			["sequence"] = {
				{
					["message"] = "PERISCOPE1",
				},
				{
					["message"] = "PERISCOPE2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSubObj",
				},
			},
		},
		["HUNTING"] = {
			["sequence"] = {
				{
					["message"] = "HUNTING1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMoveToPh2",
				},
			},
		},
		["EXETER"] = {
			["sequence"] = {
				{
					["message"] = "EXETER1",
				},
				{
					["message"] = "EXETER2",
				},
				{
					["message"] = "EXETER3",
				},
				{
					["message"] = "EXETER4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["BRUH"] = {
			["sequence"] = {
				{
					["message"] = "BRUH1",
				},
				{
					["message"] = "BRUH2",
				},
				{
					["message"] = "BRUH3",
				},
				{
					["message"] = "BRUH4",
				},
			},
		},
		["SMOKE"] = {
			["sequence"] = {
				{
					["message"] = "SMOKE1",
				},
				{
					["message"] = "SMOKE2",
				},
				{
					["message"] = "SMOKE3",
				},
				{
					["message"] = "SMOKE4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddHarunaObj",
				},
			},
		},
		["FINAL"] = {
			["sequence"] = {
				{
					["message"] = "FINAL1",
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
	
	Mission.Houston = FindEntity("Houston")
	Mission.Worden = FindEntity("Worden")
	Mission.Walker = FindEntity("Walker")
	
	SetCatapultStock(Mission.Houston, 0)
	
	Mission.HenryGang = {}
		table.insert(Mission.HenryGang, Mission.Houston)
		table.insert(Mission.HenryGang, FindEntity("Worden"))
		table.insert(Mission.HenryGang, FindEntity("Walker"))
		
	for idx,unit in pairs(Mission.HenryGang) do
		
		JoinFormation(unit, Mission.HenryGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.Criiiiinge = {}
		table.insert(Mission.Criiiiinge, Mission.Houston)
	
	---- IJN ----
	
	Mission.TypeD3A = 158
	Mission.TypeB5N = 162
	
	Mission.ValGang = {}
	Mission.K8Gang = {}
	Mission.BomberGang = {}
	
	---- VAR ----
	
	Mission.MeetingPoint = FindEntity("MeetingPoint")
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	Blackout(true, "", true)
	--EnableInput(false)
	
	MissionNarrative("March 24th, 1942 - Java Sea")
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Houston, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh4, 10)
	
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
	
	if not Mission.Started then
		
		Mission.MissionPhase = 1
		
		luaStartMission()
		
		Mission.Started = true
		
	else
	
		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
	end
	
	if Mission.MissionPhase < 99 then
		
		if luaObj_IsActive("primary", 2) then
		
			if Mission.Houston.Dead then
			
				luaMissionFailed(Mission.Houston)
			
			end
		
		end
		
		if luaObj_IsActive("secondary", 2) then
		
			if Mission.Exeter.Dead then
			
				luaObj_Failed("secondary", 2, true)
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase == 1 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.BomberGang)) > 0 then
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BomberGang)) do
				
				if unit and not unit.Dead then
					
					local ammo = GetProperty(unit, "ammoType")
			
					if ammo == 1 or ammo == 2 then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						
							local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.HenryGang))
							
							luaSetScriptTarget(unit, trg)
							PilotSetTarget(unit, trg)
						
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
		
		if luaObj_IsActive("primary", 1) then
			
			if luaGetDistance(Mission.Houston, Mission.MeetingPoint) < 500 or Mission.SubKilled then
				
				HideScoreDisplay(1,0)
				
				luaObj_Completed("primary", 1)
				
				if Mission.SubKilled then
				
					luaStartDialog("HUNTING")
				
				else
				
					luaMoveToPh2()
				
				end
				
			else
			
				luaDistanceCounter(Mission.Houston, Mission.MeetingPoint, 1, "Meet with Royal Navy forces at the given coordinates ASAP!", "ijn14.distance")
			
			end
			
		end
		
		if luaObj_IsActive("secondary", 1) then
		
			if Mission.Sub.Dead then
				
				luaObj_Completed("secondary",1)
				
				Mission.SubKilled = true
				
			end
		
		end
		
	elseif Mission.MissionPhase == 2 then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.HaguroGang)) == 0 and not Mission.Proceeding then
		
			luaDelay(luaMoveToPh3, 5)
			
			Mission.Proceeding = true
			
		end
		
	elseif Mission.MissionPhase == 3 then

		if luaObj_IsActive("primary", 3) then
		
			if Mission.Haruna.Dead then
				
				SetInvincible(Mission.Houston, 0.01)
				
				if Mission.Exeter and not Mission.Exeter.Dead then
					
					SetInvincible(Mission.Exeter, 0.01)
					
					luaObj_Completed("secondary",2)
					
				end
				
				HideUnitHP()
				
				luaObj_Completed("primary", 3)
				
				luaStartDialog("FINAL")
				
				Mission.EndMission = true
				
			end
		
		end
	
	end
	
	---- TEST ----
	
end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.Haruna = GenerateObject("Haruna")
	Mission.HarunaEsc1 = GenerateObject("Suzukaze")
	Mission.HarunaEsc2 = GenerateObject("Oshio")
	Mission.HarunaEsc3 = GenerateObject("Natsushio")
	
	Mission.HarunaGang = {}
		table.insert(Mission.HarunaGang, Mission.Haruna)
		table.insert(Mission.HarunaGang, Mission.HarunaEsc1)
		table.insert(Mission.HarunaGang, Mission.HarunaEsc2)
		table.insert(Mission.HarunaGang, Mission.HarunaEsc3)
		
	for idx,unit in pairs(Mission.HarunaGang) do
		
		EntityTurnToEntity(unit, Mission.Houston)
		JoinFormation(unit, Mission.HarunaGang[1])
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
	
	local spawn
	local bruh = random(1,2)
	
	if bruh == 1 then
	
		spawn = FindEntity("HarunaSpawn1")
	
	elseif bruh == 2 then
	
		spawn = FindEntity("HarunaSpawn2")
	
	end
	
	PutTo(Mission.Haruna, GetPosition(spawn))
	
	PutRelTo(Mission.HarunaEsc1, Mission.Haruna, {["x"]=0, ["y"]=0, ["z"]=-500,})
	PutRelTo(Mission.HarunaEsc2, Mission.Haruna, {["x"]=500, ["y"]=0, ["z"]=0,})
	PutRelTo(Mission.HarunaEsc3, Mission.Haruna, {["x"]=-500, ["y"]=0, ["z"]=0,})
	
	NavigatorAttackMove(Mission.Haruna, Mission.Houston, {["OptimalRange"]=2000,})
	
	luaStartDialog("SMOKE")
	
	luaDelay(luaSpawnNautilus, 30)
	
end

function luaSpawnNautilus()
	
	local pos = GetPosition(Mission.Houston)	
	pos.y = -50
	Mission.Nautilus = GenerateObject("Nautilus")
	PutTo(Mission.Nautilus, pos, luaGetRotation(Mission.Houston))
	SetSubmarineDepthLevel(Mission.Nautilus, 2)
	
	luaStartDialog("BRUH")

end

function luaAddHarunaObj()

	luaObj_Add("primary", 3, Mission.Haruna)

end

---- PHASE 2 ----

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	if not Mission.SubKilled then
		
		luaObj_Failed("secondary", 1)
		
		local unitpos = GetPosition(Mission.Sub)
		unitpos.x = unitpos.x + 0
		unitpos.y = unitpos.y + 0
		unitpos.z = unitpos.z + 40000
		PutTo(Mission.Sub, unitpos)
		SetDeadMeat(Mission.Sub)
	
	end
	
	PutTo(Mission.Houston, {["x"]=1620, ["y"]=0, ["z"]=-1200,}, 0)
	
	if not Mission.Walker.Dead then
	
		PutTo(Mission.Walker, {["x"]=1550, ["y"]=0, ["z"]=-1611,}, 0)
		JoinFormation(Mission.Walker, Mission.Houston)
		
	end
	
	if not Mission.Worden.Dead then
		
		PutTo(Mission.Worden, {["x"]=1880, ["y"]=0, ["z"]=-1560,},0)
		JoinFormation(Mission.Worden, Mission.Houston)
		
	end
	
	Mission.Exeter = GenerateObject("Exeter")
	Mission.Decoy = GenerateObject("Decoy")
	Mission.Hotspur = GenerateObject("Hotspur")
	
	Mission.ExeterGang = {}
		table.insert(Mission.ExeterGang, Mission.Exeter)
		table.insert(Mission.ExeterGang, Mission.Decoy)
		table.insert(Mission.ExeterGang, Mission.Hotspur)
		
	for idx,unit in pairs(Mission.ExeterGang) do
		
		JoinFormation(unit, Mission.ExeterGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.FirstWave1 = GenerateObject("Haguro")
	Mission.FirstWave2 = GenerateObject("Amagiri")
	Mission.FirstWave3 = GenerateObject("Akigumo")
	
	Mission.HaguroGang = {}
		table.insert(Mission.HaguroGang, Mission.FirstWave1)
		table.insert(Mission.HaguroGang, Mission.FirstWave2)
		table.insert(Mission.HaguroGang, Mission.FirstWave3)
	
	for idx,unit in pairs(Mission.HaguroGang) do
		
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
	
	NavigatorAttackMove(Mission.FirstWave1, Mission.Exeter)
	NavigatorAttackMove(Mission.FirstWave2, Mission.Houston)
	NavigatorAttackMove(Mission.FirstWave3, Mission.Houston)
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaDelay(luaExeterDia, 1)
	
end

function luaExeterDia()

	luaStartDialog("EXETER")

end

function luaAddFinalObjs()

	luaObj_Add("secondary", 2, Mission.Exeter)
	
	luaObj_Add("hidden", 1)
	
end

---- PHASE 1 ----

function luaSpawnFirstAttackWave()

	local spawnDeltaY = 4700
	
	for i = 1,7 do
		
		luaSpawnJap(Mission.TypeD3A, 3, GetPosition(Mission.Houston), 1, spawnDeltaY, random(50, 100), random(-300, 700))
		
		spawnDeltaY = spawnDeltaY + 650
		
	end

end

function luaSpawnSecondAttackWave()

	local spawnDeltaX = -3800
	
	for i = 1,6 do
		
		luaSpawnJap(Mission.TypeB5N, 3, GetPosition(Mission.Houston), 1, random(400, 1200), 100, spawnDeltaX)
		
		spawnDeltaX = spawnDeltaX - 650
		
	end
	
	luaStartDialog("KATE")
	
end

function luaSpawnSub()

	Mission.Sub = GenerateObject("I-23")
	
	SetSkillLevel(Mission.Sub, Mission.SkillLevel)
	NavigatorSetTorpedoEvasion(Mission.Sub, true)
	NavigatorSetAvoidLandCollision(Mission.Sub, true)
	TorpedoEnable(Mission.Sub, true)
	
	if Mission.Difficulty == 0 then
		
		RepairEnable(Mission.Sub, false)
	
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		
		RepairEnable(Mission.Sub, true)
	
	end
	
	NavigatorAllowMaxDepth(Mission.Sub, false)
	SetUnlimitedAirSupply(Mission.Sub, true)
	SetSubmarineDepthLevel(Mission.Sub, 1)
	NavigatorAttackMove(Mission.Sub, Mission.Houston)
	SetForcedReconLevel(Mission.Sub, 2, PARTY_ALLIED)
	
	luaStartDialog("PERISCOPE")
	
end

function luaAddSubObj()

	luaObj_Add("secondary", 1, Mission.Sub)

end

function luaSpawnJap(class, wngCount, pos, equipment, spawnDeltaY, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = alt
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
	
	local unitpos = GetPosition(unit)
	local alt = unitpos.y
	
	SquadronSetTravelAlt(unit, alt, true)
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.HenryGang))
	
	EntityTurnToEntity(unit, trg)
	luaSetScriptTarget(unit, trg)
	PilotSetTarget(unit, trg)
	
	table.insert(Mission.BomberGang, unit)
	
	if unit.Class.Name == "globals.unitclass_val" then
		
		SquadronSetAttackAlt(unit, alt, true)
		
		table.insert(Mission.ValGang, unit)
		
	elseif unit.Class.Name == "globals.unitclass_kate" then
		
		table.insert(Mission.K8Gang, unit)
	
	end
	
end

function luaStartMission()
	
	luaSpawnFirstAttackWave()
	luaDelay(luaSpawnSecondAttackWave, 100)
	luaDelay(luaSpawnSub, 147)
	
	luaIntroMovie()
	
end

function luaIntroMovie()
	
	local houston = FindEntity("Houston")
	local worden = FindEntity("Walker")
	
	Blackout(false, "", 1)
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=houston,
			["pos"] = { 30, 3, 180, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["wanderer"]=false,
		["transformtype"]="keepall",
		["smoothtime"]=1.0,
		["zoom"]=2.5,
	}

	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="target",
		["position"]= {
			["parent"]=worden,
			["pos"] = { 0, 35, 0, },
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["zoom"] = 2.5,
	}
		
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="target",
		["position"]= {
		},
		["transformtype"]="keepy",
		["starttime"]=0.1,
		["blendtime"]=0.0,
		["zoom"] =2.5,
	}
	
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=houston,
			["pos"] = { 80, 3, -80, },
		},
		["starttime"]=0.1,
		["blendtime"]=16.0,
		["wanderer"]=false,
		["transformtype"]="keepy",
		["zoom"]=2.5,
	}
	
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="target",
		["position"]= {
			["parent"]=houston,
			["pos"] = { -30, 15, -80, },
		},
		["transformtype"]="keepy",
		["starttime"]=0.2,
		["blendtime"]=14.0,
		["zoom"] = 2.5,
		["finishscript"] = "luaIntroClose",
	}
	
	MovCamNew_AddPosition(pos0)

end

function luaIntroClose()

	Blackout(true, "luaIntroMovieEnd", 1)

end

function luaIntroMovieEnd()
	
	SetSelectedUnit(Mission.Houston)
	
	--EnableInput(true)
	
	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 1)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")
	
	luaDelay(luaGangGang, 13)
	
end

function luaGangGang()

	luaStartDialog("GANG")
	
	EnableMessages(true)
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, GetPosition(Mission.MeetingPoint))
	luaObj_Add("primary", 2, Mission.Houston)
	
	DisplayUnitHP((Mission.Criiiiinge), "The Houston must not sink!")

end

---- MOVIES ----

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m0702.bik")

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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Completed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.HaguroGang)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.HarunaGang)) == 0 then
		
			luaObj_Completed("hidden",1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
		
	end
	
	luaMissionCompletedNew(Mission.Haruna, "The Haruna is sinking - Mission Complete", "campaigns/BSM/m0703.bik")
	
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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
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