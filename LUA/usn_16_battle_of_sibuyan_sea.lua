---- BATTLE OF SIBUYAN SEA (USN) ----

-- Scripted & Assembled by: Team Wolfpack

---- BATTLE OF SIBUYAN SEA (USN) ----

DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")

---- PRECACHE ----

function luaPrecacheUnits()

	--PrepareClass(101) 	-- F4F
	--PrepareClass(108) 	-- TBF
	--PrepareClass(113) 	-- SBD
	--PrepareClass(121) 	-- Kingfisher
	
	--PrepareClass(150) 	-- Zero
	--PrepareClass(151) 	-- Raiden
	--PrepareClass(189) 	-- Shinden
	--PrepareClass(163) 	-- Jill
	PrepareClass(158) 	-- Val
	PrepareClass(159) 	-- Judy
	PrepareClass(162) 	-- Kate
	PrepareClass(167) 	-- Betty
	
	--PrepareClass(53) 	-- Soryu
	--PrepareClass(2) 	-- Yorktown
	--PrepareClass(17) 	-- Atlanta
	--PrepareClass(7) 	-- South Dakota
	--PrepareClass(23) 	-- Fletcher
	--PrepareClass(19) 	-- Northampton
	
	--PrepareClass(73) 	-- Fubuki
	
end

---- INITS ----

function luaEngineMovieInit()
	EnableMessages(false)
	Music_Control_SetLevel(MUSIC_TENSION)
	LoadMessageMap("runsva02dlg",1)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInit")
	Scoring_RealPlayTimeRunning(true)
end

---- MAIN INIT ----

function luaInit(this)
	Mission = this
	this.Name = "US16"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_16_battle_of_sibuyan_sea.lua"

	DoFile("scripts/datatables/Scoring.lua")
			
	SETLOG(this, true)

	this.Party = SetParty(this, PARTY_ALLIED)
	
	EnableMessages(true)
	
	--SetDeviceReloadEnabled(true)
	
	---- DIFFICULTY SETTING ----
	
	this.Difficulty = GetDifficulty()
	
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

	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	luaInitNewSystems()

    SetThink(this, "Think")

	SetSimplifiedReconMultiplier(1.3)
	
	---- ALL PLANE TYPES ----
	
	Mission.TypeFisher = 121
	Mission.TypeFairey = 109
	Mission.TypeHurricane = 134
	Mission.TypeJ2M = 151
	Mission.TypeB17 = 116
	Mission.TypeB25 = 118
	Mission.TypeSB2C = 38
	Mission.TypeSBD = 108
	Mission.TypeTBF = 113
	Mission.TypeP38 = 104
	Mission.TypeF6F = 26
	Mission.TypeG4M = 167
	Mission.TypeG4MOhka = 32
	Mission.TypeG3M = 166
	Mission.TypeJ1N1 = 152
	Mission.TypeH6K = 174
	Mission.TypeF1M = 171
	Mission.TypeA6M = 150
	Mission.TypeB6N = 163
	Mission.TypeD4Y = 159
	Mission.TypeB5N = 162
	Mission.TypeD3A = 158
	Mission.TypeJ2M = 151
	Mission.TypeShinden = 189
	
	---- SHIP TYPES ----
	
	Mission.TypeNarwhal = 31
	
	---- USN ----
	
	Mission.TGOne = {}
		table.insert(Mission.TGOne, FindEntity("Essex-class01"))
		table.insert(Mission.TGOne, FindEntity("Essex-class02"))
		--table.insert(Mission.TGOne, FindEntity("Yorktown-class01"))
		table.insert(Mission.TGOne, FindEntity("Iowa Class01"))
		table.insert(Mission.TGOne, FindEntity("Cleveland-class01"))
		table.insert(Mission.TGOne, FindEntity("Fletcher-class01"))
		table.insert(Mission.TGOne, FindEntity("Fletcher-class02"))
		
	Mission.TGOneNames = {}
		table.insert(Mission.TGOneNames, {"USS Lexington", 19})
		table.insert(Mission.TGOneNames, {"USS Essex", 15})
		--table.insert(Mission.TGOneNames, {"USS Langley", 44})
		table.insert(Mission.TGOneNames, {"USS Massachusetts", 59})
		table.insert(Mission.TGOneNames, {"USS Mobile", 63})
		table.insert(Mission.TGOneNames, {"USS Dortch", 670})
		table.insert(Mission.TGOneNames, {"USS Cassin Young", 793})
		
	for idx,unit in pairs(Mission.TGOne) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		JoinFormation(unit, Mission.TGOne[3])
		SetGuiName(unit, Mission.TGOneNames[idx][1])
		if Mission.TGOneNames[idx][2] then
			SetNumbering(unit, Mission.TGOneNames[idx][2])
		end
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end
	
	Mission.TGTwo = {}
		table.insert(Mission.TGTwo, FindEntity("Essex-class03"))
		table.insert(Mission.TGTwo, FindEntity("Bogue-class01"))
		--table.insert(Mission.TGTwo, FindEntity("Essex-class04"))
		table.insert(Mission.TGTwo, FindEntity("Iowa Class02"))
		table.insert(Mission.TGTwo, FindEntity("Northampton-class01"))
		table.insert(Mission.TGTwo, FindEntity("Atlanta-class01"))
		table.insert(Mission.TGTwo, FindEntity("Fletcher-class03"))
		table.insert(Mission.TGTwo, FindEntity("Fletcher-class04"))
	
	Mission.TGTwoNames = {}
		table.insert(Mission.TGTwoNames, {"USS Intrepid", 18})
		table.insert(Mission.TGTwoNames, {"USS Bunker Hill", 8})
		--table.insert(Mission.TGTwoNames, {"USS Independence", 22})
		table.insert(Mission.TGTwoNames, {"USS Iowa", 61})
		table.insert(Mission.TGTwoNames, {"USS Vincennes", 44})
		table.insert(Mission.TGTwoNames, {"USS Oakland", 95})
		table.insert(Mission.TGTwoNames, {"USS Colahan", 658})
		table.insert(Mission.TGTwoNames, {"USS Hickox", 673})
		
	for idx,unit in pairs(Mission.TGTwo) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		JoinFormation(unit, Mission.TGTwo[3])
		SetGuiName(unit, Mission.TGTwoNames[idx][1])
		if Mission.TGTwoNames[idx][2] then
			SetNumbering(unit, Mission.TGTwoNames[idx][2])
		end
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end
	
	Mission.USCVs = {}
		table.insert(Mission.USCVs, FindEntity("Essex-class01"))
		table.insert(Mission.USCVs, FindEntity("Essex-class02"))
		--table.insert(Mission.USCVs, FindEntity("Yorktown-class01"))
		table.insert(Mission.USCVs, FindEntity("Essex-class03"))
		table.insert(Mission.USCVs, FindEntity("Bogue-class01"))
		--table.insert(Mission.USCVs, FindEntity("Essex-class04"))
	
	for idx,unit in pairs(Mission.USCVs) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetRoleAvailable(unit, EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLE_CAPTAIN, PLAYER_ANY)
		UnitSetPlayerCommandsEnabled(unit, PCF_NONE+PCF_TARGET)
	end
	
	SetRoleAvailable(Mission.TGOne[3], EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.TGOne[3], EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLF_ARTILLERY+EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.TGOne[3], PCF_NONE+PCF_TARGET)
		
	SetRoleAvailable(Mission.TGTwo[3], EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.TGTwo[3], EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLF_ARTILLERY+EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.TGTwo[3], PCF_NONE+PCF_TARGET)
	
	SetInvincible(Mission.TGOne[3], 0.4)
	SetInvincible(Mission.TGTwo[3], 0.4)
	
	---- IJN ----
	
	Mission.Musashi = FindEntity("Yamato-class01")
	Mission.Yamato = FindEntity("Yamato-class02")
	
	Mission.CenterForceNorth = {}
		table.insert(Mission.CenterForceNorth, FindEntity("Yamato-class01"))
		table.insert(Mission.CenterForceNorth, FindEntity("Kongo-class01"))
		--table.insert(Mission.CenterForceNorth, FindEntity("Kongo-class02"))
		table.insert(Mission.CenterForceNorth, FindEntity("Takao-class01"))
		--table.insert(Mission.CenterForceNorth, FindEntity("Mogami-class01"))
		--table.insert(Mission.CenterForceNorth, FindEntity("Mogami-class02"))
		--table.insert(Mission.CenterForceNorth, FindEntity("Kuma-class01"))
		table.insert(Mission.CenterForceNorth, FindEntity("Shimakaze-class01"))
		table.insert(Mission.CenterForceNorth, FindEntity("Shimakaze-class02"))
		table.insert(Mission.CenterForceNorth, FindEntity("Shimakaze-class03"))
		table.insert(Mission.CenterForceNorth, FindEntity("Shimakaze-class04"))
	
	Mission.CenterForceNorthNames = {}
		table.insert(Mission.CenterForceNorthNames, "Musashi")
		table.insert(Mission.CenterForceNorthNames, "Kongo")
		--table.insert(Mission.CenterForceNorthNames, "Haruna")
		table.insert(Mission.CenterForceNorthNames, "Chokai")
		--table.insert(Mission.CenterForceNorthNames, "Haguro")
		--table.insert(Mission.CenterForceNorthNames, "Kumano")
		--table.insert(Mission.CenterForceNorthNames, "Yahagi")
		table.insert(Mission.CenterForceNorthNames, "Shimakaze")
		table.insert(Mission.CenterForceNorthNames, "Hayashimo")
		table.insert(Mission.CenterForceNorthNames, "Akishimo")
		table.insert(Mission.CenterForceNorthNames, "Kishinami")
		
	for idx,unit in pairs(Mission.CenterForceNorth) do
		JoinFormation(unit, Mission.CenterForceNorth[1])
		SetGuiName(unit, Mission.CenterForceNorthNames[idx])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			RepairEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, true)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			RepairEnable(unit, true)
			NavigatorSetTorpedoEvasion(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	Mission.CenterForceSouth = {}
		table.insert(Mission.CenterForceSouth, FindEntity("Yamato-class02"))
		table.insert(Mission.CenterForceSouth, FindEntity("Nagato-class01"))
		table.insert(Mission.CenterForceSouth, FindEntity("Mogami-class03"))
		--table.insert(Mission.CenterForceSouth, FindEntity("Tone-class01"))
		--table.insert(Mission.CenterForceSouth, FindEntity("Tone-class02"))
		--table.insert(Mission.CenterForceSouth, FindEntity("Kuma-class02"))
		table.insert(Mission.CenterForceSouth, FindEntity("Shimakaze-class05"))
		table.insert(Mission.CenterForceSouth, FindEntity("Shimakaze-class06"))
		table.insert(Mission.CenterForceSouth, FindEntity("Shimakaze-class07"))
		table.insert(Mission.CenterForceSouth, FindEntity("Shimakaze-class08"))
		
	Mission.CenterForceSouthNames = {}
		table.insert(Mission.CenterForceSouthNames, "Yamato")
		table.insert(Mission.CenterForceSouthNames, "Nagato")
		table.insert(Mission.CenterForceSouthNames, "Suzuya")
		--table.insert(Mission.CenterForceSouthNames, "Chikuma")
		--table.insert(Mission.CenterForceSouthNames, "Tone")
		--table.insert(Mission.CenterForceSouthNames, "Noshiro")
		table.insert(Mission.CenterForceSouthNames, "Okinami")
		table.insert(Mission.CenterForceSouthNames, "Hamanami")
		table.insert(Mission.CenterForceSouthNames, "Fujinami")
		table.insert(Mission.CenterForceSouthNames, "Nowake")
		
	for idx,unit in pairs(Mission.CenterForceSouth) do
		JoinFormation(unit, Mission.CenterForceSouth[1])
		SetGuiName(unit, Mission.CenterForceSouthNames[idx])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			RepairEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, true)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			RepairEnable(unit, true)
			NavigatorSetTorpedoEvasion(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	---- VAR ----

	Mission.CapsizedShips = {}
	Mission.IJNBombers = {}
	
	Mission.Leyte = FindEntity("Leyte")
	Mission.MusashiGoTo = FindEntity("MusashiGoTo")
	Mission.IJNPlaneSpawn1 = FindEntity("IJNPlaneSpawn1")
	Mission.MusashiRetreat = FindEntity("MusashiRetreat")
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.DeadFlagShips = 0
	Mission.BomberWave = 0
	Mission.Started = false
	Mission.Critical = false
	Mission.Lost = false
	Mission.MusashiKiller = false
	Mission.IJNSighted = false
	Mission.EndMission = false
	Mission.YamatoRetreating = false
	Mission.YamatoMarked = false
	Mission.MusashiMarked = false
	Mission.Ace = nil
	Mission.AceHere = false
	Mission.BomersMoviePlayed = false
	Mission.BANZAI = false
	Mission.BombersHere = false
	
	---- OBJECTIVES ----
	
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "DDs",
				["Text"] = "Locate the Japanese Fleet!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Assist",
				["Text"] = "Sink the Musashi!",
				["TextCompleted"] = "The Musashi is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "1",
				["Text"] = "Damage the Yamato to 50%!",
				["TextCompleted"] = "The Yamato is retreating!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "2",
				["Text"] = "Ensure the survival of at least 4 of your carriers!",
				["TextCompleted"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Torp",
				["Text"] = "Personally shoot down 15 bombers!",
				["TextCompleted"] = "You've shot down 15 enemy bombers!",
				["TextFailed"] = "Some enemy bombers have escaped!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Cargo",
				["Text"] = "Make sure all your carriers survive the battle!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
	}
	
	---- DIALOGUE ----
	
	Mission.Dialogues = {
		["INTRO"] = {
			["sequence"] = {
				{
					["message"] = "IDLG01",
				},
				{
					["message"] = "IDLG02",
				},
				{
					["message"] = "IDLG03",
				},
				{
					["message"] = "IDLG04",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObj",
				},
			},
		},
		["JAPSIGHTED"] = {
			["sequence"] = {
				{
					["message"] = "JAPSIGHTED1",
				},
				{
					["message"] = "JAPSIGHTED2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaYamatoSightedDiaObj",
				},
			},
		},
		["PLANESSIGHTED"] = {
			["sequence"] = {
				{
					["message"] = "PLANESSIGHTED1",
				},
				{
					["message"] = "PLANESSIGHTED2",
				},
				{
					["message"] = "PLANESSIGHTED3",
				},
			},
		},
		["MUSASHISIGHTED"] = {
			["sequence"] = {
				{
					["message"] = "MUSASHISIGHTED1",
				},
				{
					["message"] = "MUSASHISIGHTED2",
				},
				{
					["message"] = "MUSASHISIGHTED3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMusashiSightedDiaObj",
				},
			},
		},
		["MUSASHIISLAND"] = {
			["sequence"] = {
				{
					["message"] = "MUSASHIISLAND1",
				},
				{
					["message"] = "MUSASHIISLAND2",
				},
			},
		},
		["MUSASHINEAR"] = {
			["sequence"] = {
				{
					["message"] = "MUSASHINEAR1",
				},
				{
					["message"] = "MUSASHINEAR2",
				},
			},
		},
		["MUSASHIDEAD1"] = {
			["sequence"] = {
				{
					["message"] = "MUSASHIDEAD1",
				},
				{
					["message"] = "MUSASHIDEAD2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPlayVictorySpeech",
				},
			},
		},
		["MUSASHIDEAD2"] = {
			["sequence"] = {
				{
					["message"] = "MUSASHIDEAD1",
				},
				{
					["message"] = "MUSASHIDEAD3",
				},
			},
		},
		["YAMATORETREATING1"] = {
			["sequence"] = {
				{
					["message"] = "YAMATORETREATING1",
				},
				{
					["message"] = "YAMATORETREATING2",
				},
				{
					["message"] = "YAMATORETREATING3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPlayVictorySpeech",
				},
			},
		},
		["YAMATORETREATING2"] = {
			["sequence"] = {
				{
					["message"] = "YAMATORETREATING1",
				},
				{
					["message"] = "YAMATORETREATING2",
				},
				{
					["message"] = "YAMATORETREATING3",
				},
			},
		},
		["VICTORY"] = {
			["sequence"] = {
				{
					["message"] = "VICTORY1",
				},
				{
					["message"] = "VICTORY2",
				},
				{
					["message"] = "VICTORY3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["LOOKSBAD"] = {
			["sequence"] = {
				{
					["message"] = "LOOKSBAD1",
				},
				{
					["message"] = "LOOKSBAD2",
				},
			},
		},
		["BANZAI"] = {
			["sequence"] = {
				{
					["message"] = "BANZAI1",
				},
				{
					["message"] = "BANZAI2",
				},
			},
		},
		["BOMBERSHERE"] = {
			["sequence"] = {
				{
					["message"] = "BOMBERSHERE1",
				},
				{
					["message"] = "BOMBERSHERE2",
				},
			},
		},
	}
	
	---- INIT FUNCT ----
	
	if Mission.Yamato and not Mission.Yamato.Dead then
		NavigatorMoveToRange(Mission.Yamato, FindEntity("Leyte"))
	end
	
	if Mission.Musashi and not Mission.Musashi.Dead then
		NavigatorMoveToRange(Mission.Musashi, FindEntity("MusashiGoTo"))
	end
	
	luaAddMusashiListener()
	luaAddYamatoListener()
	
	SetInvincible(Mission.Yamato, 0.4)
	SetInvincible(Mission.Musashi, 0.01)
	
	luaDelay(luaSpawnBombers, 500)
	luaDelay(luaSpawnSub, 400)
	
end

---- THNK ----

function Think(this, msg)
	
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	
	if Mission.EndMission then
		return
	end

	if Mission.Started then
	
	elseif not Mission.Started then
	
	Mission.Started = true
	
	luaIntroMovie()
	
	end
	
	if Mission.MissionPhase < 99 then
		
		luaCheckMusic()
		
		Mission.PlayerUnit = GetSelectedUnit()
		
		if Mission.TGOne[3] and not Mission.TGOne[3].Dead then
			NavigatorMoveOnPath(Mission.TGOne[3], FindEntity("TGOnePath"), PATH_FM_CIRCLE)
		end
		
		if Mission.TGTwo[3] and not Mission.TGTwo[3].Dead then
			NavigatorMoveOnPath(Mission.TGTwo[3], FindEntity("TGTwoPath"), PATH_FM_CIRCLE)
		end
		
		if Mission.Yamato and not Mission.Yamato.Dead then
			if luaGetDistance(Mission.Yamato, Mission.Leyte) < 2000 and not Mission.Lost then
				Mission.Lost = true
				luaMissionFailedYama()
			end
		end
		
		if luaObj_IsActive("primary",4) then
			if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 3 then
				Mission.Lost = true
				luaMissionFailedCV()
			end
		end
		
		if Mission.Musashi and not Mission.Musashi.Dead and Mission.MusashiKiller then
			if Mission.Difficulty == 0 then	
				NavigatorMoveOnPath(Mission.Musashi, FindEntity("TGOnePath"), PATH_FM_SIMPLE, PATH_SM_JOIN)
			elseif Mission.Difficulty == 1 then
				NavigatorMoveOnPath(Mission.Musashi, FindEntity("TGOnePath"), PATH_FM_SIMPLE, PATH_SM_JOIN)
			elseif Mission.Difficulty == 2 then
				for idx,unit in pairs(Mission.CenterForceNorth) do
					if unit and not unit.Dead then
						NavigatorMoveToRange(unit, Mission.TGOne[3])
					end
				end
			end
		end
		
		if GetHpPercentage(Mission.Yamato) <= 0.5 then
			HideScoreDisplay(1,0)
			luaYamatoRetreat()
			luaCheckYamatoDia()
		end
		
		if GetHpPercentage(Mission.Musashi) <= 0.05 and not Mission.Musashi.Dead then
			HideUnitHP()
			if IsInvincible(Mission.Musashi) then
				SetInvincible(Mission.Musashi, false)
			end
			SetDeadMeat(Mission.Musashi)
			luaDelay(luaHoldUpMusashi, 6)
			luaCheckMusashiDia()
			luaRetreatMusashiFleet()
		end
		
		if luaObj_IsActive("secondary",1) then
			local sd = Scoring_GetPlayerShotDown()
			if sd == 15 then
				if luaObj_IsActive("secondary",1) then
					luaObj_Completed("secondary",1,true)
					if not Mission.PowerUpAdded then
						--luaAddPowerup("divebomb2")
						Mission.PowerUpAdded = true
					end
				end
			elseif Mission.BomberWave > 2 and table.getn(luaRemoveDeadsFromTable(Mission.IJNBombers)) == 0 and sd < 15 then
				luaObj_Failed("secondary",1,true)
			end
		end
		
		if Mission.Sub and not Mission.Sub.Dead then
			if Mission.CenterForceSouth[10] and not Mission.CenterForceSouth[10].Dead and not Mission.YamatoRetreating then
				if luaGetDistance(Mission.Sub, Mission.Yamato) < 2500 then
					NavigatorAttackMove(Mission.CenterForceSouth[10], Mission.Sub, {})
				elseif luaGetDistance(Mission.Sub, Mission.Yamato) > 2500 then
					JoinFormation(Mission.CenterForceSouth[10], Mission.CenterForceSouth[1])
				elseif Mission.Sub.Dead then
					JoinFormation(Mission.CenterForceSouth[10], Mission.CenterForceSouth[1])
				end
			end
		elseif not Mission.ChasingDDBack then
			if Mission.CenterForceSouth[10] and not Mission.CenterForceSouth[10].Dead and not Mission.YamatoRetreating then
				JoinFormation(Mission.CenterForceSouth[10], Mission.CenterForceSouth[1])
				Mission.ChasingDDBack = true
			end
		end
		
	end
	
	if Mission.MissionPhase == 1 then
	
		if Mission.Musashi and not Mission.Musashi.Dead then
			if luaGetDistance(Mission.Musashi, Mission.MusashiGoTo) < 2000 and not Mission.Critical then
				luaMusashiAttack()
				Mission.Critical = true
			end
		end
		
		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		else
			if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) < 6 then
				luaObj_Failed("hidden",1)
			end
		end
	
	end
	
end

---- MUSASHI ----

function luaHoldUpMusashi()

	if Mission.Musashi.Dead then
		DisablePhysics(Mission.Musashi)
		AddMatrixInterpolator(Mission.Musashi, {["x"]=0, ["y"]=-10, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-5)}, 30)
		table.insert(Mission.CapsizedShips, Mission.Musashi)
	end

end

function luaRetreatMusashiFleet()
	
	for idx,unit in pairs(Mission.CenterForceNorth) do
		if unit and not unit.Dead then
		local point = FindEntity("MusashiRetreat")
		NavigatorMoveToRange(unit, point)
		end
	end

end

function luaCheckMusashiDia()

	if Mission.YamatoRetreating then
		if not Mission.MusashiDeadDia then
		luaStartDialog("MUSASHIDEAD1")
		Mission.MusashiDeadDia = true
		end
	elseif not Mission.YamatoRetreating then
		if not Mission.MusashiDeadDia then
		luaStartDialog("MUSASHIDEAD2")
		Mission.MusashiDeadDia = true
		end
	end

end

---- YAMATO ----

function luaYamatoRetreat()

	if not Mission.YamatoRetreating then
		
		Mission.YamatoRetreating = true
		luaObj_Completed("primary",3,true)
	
		local retreatpoint = FindEntity("YamatoRetreat")
		NavigatorMoveToRange(Mission.Yamato, retreatpoint)
		
	end
	
end

function luaCheckYamatoDia()

	if Mission.Musashi.Dead then
		if not Mission.YamatoDeadDia then
		luaStartDialog("YAMATORETREATING1")
		Mission.YamatoDeadDia = true
		end
	elseif not Mission.Musashi.Dead then
		if not Mission.YamatoDeadDia then
		luaStartDialog("YAMATORETREATING2")
		Mission.YamatoDeadDia = true
		end
	end

end

---- LISTENERS ----

function luaAddMusashiListener()

	if Mission.Musashi and not Mission.Musashi.Dead then
		AddListener("recon", "MusashiListener", {
			["callback"] = "luaMusashiSighted",
			["entity"] = {Mission.Musashi},
			["oldLevel"] = {0,1},
			["newLevel"] = {2},
			["party"] = {PARTY_ALLIED},
		})
	end
	
end

function luaAddYamatoListener()

	if Mission.Yamato and not Mission.Yamato.Dead then
		AddListener("recon", "YamatoListener", {
			["callback"] = "luaYamatoSighted",
			["entity"] = {Mission.Yamato},
			["oldLevel"] = {0,1},
			["newLevel"] = {2},
			["party"] = {PARTY_ALLIED},
		})
	end
	
end

---- LISTENER CALLBACKS ----

function luaMusashiSighted()
	
	if not Mission.IJNSighted then
	
		HideScoreDisplay(1,0)
		Mission.IJNSighted = true
	
	end
	
	luaObj_Completed("primary",1,true)
	RemoveListener("recon", "MusashiListener")
	
	luaStartDialog("MUSASHISIGHTED")
	
end

function luaYamatoSighted()
	
	if not Mission.IJNSighted then
		
		HideScoreDisplay(1,0)
		Mission.IJNSighted = true
	
	end
	
	luaObj_Completed("primary",1,true)
	RemoveListener("recon", "YamatoListener")
	
	luaStartDialog("JAPSIGHTED")

end

---- IJN BOMBERS ----

function luaSpawnBombers()
	
	if Mission.BomberWave < 3 then
	
		if Mission.Difficulty == 0 then
		
			local SpawnCoord = GetPosition(Mission.TGOne[3])
			SpawnCoord.x = SpawnCoord.x - 3000
			SpawnCoord.y = SpawnCoord.y + 2000
			SpawnCoord.z = SpawnCoord.z + 3000
			
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.TypeD3A,
					["Name"] = "D3A Val",
					["Crew"] = 1,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeD3A,
					["Name"] = "D3A Val",
					["Crew"] = 1,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B5N Kate",
					["Crew"] = 1,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B5N Kate",
					["Crew"] = 1,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaBombersSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
			
			
		elseif Mission.Difficulty == 1 then
			
			local SpawnCoord = GetPosition(Mission.TGOne[3])
			SpawnCoord.x = SpawnCoord.x - 3000
			SpawnCoord.y = SpawnCoord.y + 2000
			SpawnCoord.z = SpawnCoord.z + 3000
			
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.TypeD3A,
					["Name"] = "D3A Val",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeD3A,
					["Name"] = "D3A Val",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B5N Kate",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B5N Kate",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeG4M,
					["Name"] = "G4M Betty",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeG4M,
					["Name"] = "G4M Betty",
					["Crew"] = 2,
					["Race"] = Japan,
					["WingCount"] = 3,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaBombersSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
			
		elseif Mission.Difficulty == 2 then
		
			local SpawnCoord = GetPosition(Mission.TGOne[3])
			SpawnCoord.x = SpawnCoord.x - 3000
			SpawnCoord.y = SpawnCoord.y + 2000
			SpawnCoord.z = SpawnCoord.z + 3000
			
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.TypeD4Y,
					["Name"] = "D4Y Judy",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeD4Y,
					["Name"] = "D4Y Judy",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B6N Jill",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeB5N,
					["Name"] = "B6N Jill",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeG4M,
					["Name"] = "G4M Betty",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeG4M,
					["Name"] = "G4M Betty",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaBombersSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})

		end
		
		if not Mission.PlaneDiaPlayed then
		
			luaObj_Add("secondary",1)
			luaStartDialog("PLANESSIGHTED")
			
			Mission.PlaneDiaPlayed = true
		
		end
		
		luaDelay(luaSpawnBombers, 100)
		Mission.BomberWave = Mission.BomberWave + 1
		
		if Mission.BomberWave == 3 and not luaObj_GetSuccess("secondary",1) == nil then
		
			luaObj_Failed("secondary",1)
		
		end
		
	end

end

function luaBombersSpawned(unit1,unit2,unit3,unit4,unit5,unit6)
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.TGOne))
	
	EntityTurnToEntity(unit1, trg)
	PilotSetTarget(unit1, trg)
	UnitSetFireStance(unit1, 2)
	
	EntityTurnToEntity(unit2, trg)
	PilotSetTarget(unit2, trg)
	UnitSetFireStance(unit2, 2)
	
	EntityTurnToEntity(unit3, trg)
	PilotSetTarget(unit3, trg)
	UnitSetFireStance(unit3, 2)
	
	EntityTurnToEntity(unit4, trg)
	PilotSetTarget(unit4, trg)
	UnitSetFireStance(unit4, 2)
	
	EntityTurnToEntity(unit5, trg)
	PilotSetTarget(unit5, trg)
	UnitSetFireStance(unit5, 2)
	
	EntityTurnToEntity(unit6, trg)
	PilotSetTarget(unit6, trg)
	UnitSetFireStance(unit6, 2)
	
	
	
	table.insert(Mission.IJNBombers, unit1)
	table.insert(Mission.IJNBombers, unit2)
	table.insert(Mission.IJNBombers, unit3)
	table.insert(Mission.IJNBombers, unit4)
	table.insert(Mission.IJNBombers, unit5)
	table.insert(Mission.IJNBombers, unit6)
	
	if luaObj_IsActive("secondary",1) then
		luaObj_AddUnit("secondary",1,unit1)
		luaObj_AddUnit("secondary",1,unit2)
		luaObj_AddUnit("secondary",1,unit3)
		luaObj_AddUnit("secondary",1,unit4)
		luaObj_AddUnit("secondary",1,unit5)
		luaObj_AddUnit("secondary",1,unit6)
	end
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	for idx,unit in pairs(Mission.CapsizedShips) do
		if idx > 0 then
		
			AddMatrixInterpolator(unit, {["x"]=0, ["y"]=-50, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-5)}, 30)

		end
	end
	
	if luaObj_IsActive("primary",1) then
	if luaObj_GetSuccess("primary",1) == nil then
	luaObj_Completed("primary",1)
	end
	end
	
	if luaObj_IsActive("hidden",1) then
	if luaObj_GetSuccess("hidden",1) == nil then
	luaObj_Completed("hidden",1)
	end
	end
	
	if luaObj_IsActive("primary",2) then
	if luaObj_GetSuccess("primary",2) == nil then
	luaObj_Completed("primary",2)
	end
	end
	
	if luaObj_IsActive("primary",3) then
	if luaObj_GetSuccess("primary",3) == nil then
	luaObj_Completed("primary",3)
	end
	end
	
	if luaObj_IsActive("primary",4) then
	if luaObj_GetSuccess("primary",4) == nil then
	luaObj_Completed("primary",4)
	end
	end
	
	luaMissionCompletedNew(Mission.Musashi, "The Musashi is sinking - Mission Complete")

end

function luaMissionFailedCV()

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
	
	luaMissionFailedNew(nil, "All of our carriers are sinking - Game Over")
	
	if not Mission.Yamato.Dead then
		luaMissionFailedNew(Mission.Yamato, "All of our carriers are sinking - Game Over")
	elseif not Mission.Musashi.Dead then
		luaMissionFailedNew(Mission.Musashi, "All of our carriers are sinking - Game Over")
	else
		luaMissionFailedNew(nil, "All of our carriers are sinking - Game Over")
	end
	
end

function luaMissionFailedYama()

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
	
	if not Mission.Yamato.Dead then
		luaMissionFailedNew(Mission.Yamato, "The Japanese Fleet broke through - Game Over")
	elseif not Mission.Musashi.Dead then
		luaMissionFailedNew(Mission.Musashi, "The Japanese Fleet broke through - Game Over")
	else
		luaMissionFailedNew(nil, "The Japanese Fleet broke through - Game Over")
	end

end

function luaCheckCompleteCriteria()

	if Mission.YamatoRetreating and not Mission.YamatoMarked then
		
		Mission.YamatoMarked = true
		
		Mission.DeadFlagShips = Mission.DeadFlagShips + 1
	
	end

	if Mission.Musashi.Dead and not Mission.MusashiMarked then
		
		Mission.MusashiMarked = true
		
		Mission.DeadFlagShips = Mission.DeadFlagShips + 1
	
	end
	
	if Mission.DeadFlagShips == 2 then
	
		luaMissionComplete()
	
	end
	
end

function luaMissionCompleteMovie()

	Mission.EndMission = true
	
	for idx,unit in pairs(Mission.CapsizedShips) do
		if idx > 0 then
		
			Mission.lastmovietrg = luaPickRnd(Mission.CapsizedShips)
			Blackout(true, "", 2)
			BlackBars(true)
				
			luaIngameMovie(
			{
				{["postype"] = "cameraandtarget", ["target"] = Mission.lastmovietrg, ["distance"] = 100, ["theta"] = 1, ["rho"] = 50, ["moveTime"] = 0, ["transformtype"] = "keepnone"},
				{["postype"] = "cameraandtarget", ["target"] = Mission.lastmovietrg, ["distance"] = 100, ["theta"] = 1, ["rho"] = 50, ["moveTime"] = 50, ["nonlinearblend"] = 0.1},
			}, luaHold, true)

		end
	end

end

function luaPlayVictorySpeech()
	
	luaMissionCompleteMovie()
	luaStartDialog("VICTORY")

end

function luaHold()



end

---- SUB ----

function luaSpawnSub()

	local SpawnCoord = GetPosition(Mission.Yamato)
	SpawnCoord.x = SpawnCoord.x + 2000
	SpawnCoord.y = SpawnCoord.y + 0
	SpawnCoord.z = SpawnCoord.z - 2500
	
	Mission.Sub = GenerateObject("Narwhal class Sub")
	PutTo(Mission.Sub, SpawnCoord)
	EntityTurnToEntity(Mission.Sub, Mission.Yamato)
	SetGuiName(Mission.Sub, "USS Dace")
	
	SetSkillLevel(Mission.Sub, Mission.SkillLevelOwn)
	NavigatorSetAvoidLandCollision(Mission.Sub, true)
	NavigatorSetTorpedoEvasion(Mission.Sub, true)
	if Mission.Difficulty == 0 then
		RepairEnable(Mission.Sub, true)
	elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
		RepairEnable(Mission.Sub, false)
	end
	
end

---- DIALOGUES ----

function luaMusashiSightedDiaObj()

	SetForcedReconLevel(Mission.Musashi, 2, PARTY_ALLIED)
	
	luaObj_Add("primary",2,Mission.Musashi)
	
	DisplayUnitHP({Mission.Musashi}, "Sink the Musashi!")
	
end

function luaYamatoSightedDiaObj()

	SetForcedReconLevel(Mission.Yamato, 2, PARTY_ALLIED)
	
	luaObj_Add("primary",3,Mission.Yamato)
	
	DisplayScores(1,0,"Damage the Yamato to 50%!","")

end

function luaMusashiAttack()
	
	luaStartDialog("MUSASHIISLAND")
	luaDelay(luaMusahsiNear, 200)
	
	Mission.MusashiKiller = true
	
end

function luaMusahsiNear()

	luaStartDialog("MUSASHINEAR")

end

---- INTRO MOVIE ----

function luaIntroMovie()

	luaDelay(luaIntroText, 3)
	Blackout(true, "", 1)
	BlackBars(true)
	luaIngameMovie(
	{
  	    {["postype"] = "cameraandtarget", ["target"] = Mission.TGOne[3], ["distance"] = 250, ["theta"] = 1, ["rho"] = 200, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TGOne[3], ["distance"] = 250, ["theta"] = 3, ["rho"] = 200, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	{["postype"] = "cameraandtarget", ["target"] = Mission.TGOne[3], ["distance"] = 400, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 7, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
        {["postype"] = "cameraandtarget", ["target"] = Mission.TGOne[3], ["distance"] = 400, ["theta"] = 10, ["rho"] = 200, ["moveTime"] = 10, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
    }, luaIntroMovieEnd,true)
	
end

function luaIntroText()

	MissionNarrative("October 24th, 1944 - In the Sibuyan Sea")
	luaStartDialog("INTRO")
	
end

function luaIntroMovieEnd()

	SetSelectedUnit(Mission.TGOne[3])
	BlackBars(false)
	Blackout(false, "", 1)
	Mission.MissionPhase = 1
	
end

function luaAddFirstObj()

	luaObj_Add("primary",1)
	DisplayScores(1,0,"Locate the Japanese Fleet!","")
	luaObj_Add("primary",4)

end

---- SUPPORT FUNCTIONS ----

function luaRAD(x)
	return x *  0.0174532925
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaStartDialog(dialogID, log, ignorePrinted)

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