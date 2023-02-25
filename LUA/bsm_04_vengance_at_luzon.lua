---- VENGANCE AT LUZON (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- VENGANCE AT LUZON (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	
	PrepareClass(108) -- Dauntless
	PrepareClass(113) -- Avenger
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("bsmdlg",4)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_04_vengance_at_luzon.lua"

	this.Name = "BSM04"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)
	
	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Donald",
				["Text"] = "Donald must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "B17",
				["Text"] = "Defend the B-17 bomber squad!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Sink",
				["Text"] = "Sink the anchored Japanese battleship in the harbor!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Retreat",
				["Text"] = "Retreat to the navigation point with your squadron!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Fuso",
				["Text"] = "Destroy the attacking Japanese battleship!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[6] = {
				["ID"] = "Lex",
				["Text"] = "The USS Lexington must not sink!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Tanker",
				["Text"] = "Destroy the Japanese oil tanker!",
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
				["Text"] = "Eliminate all destroyers!",
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
					["type"] = "callback",
					["callback"] = "luaIntroMovieB",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovieC",
				},
				{
					["message"] = "INTRO3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaZekesDia",
				},
			},
		},
		["ZEKES"] = {
			["sequence"] = {
				{
					["message"] = "ZEKES1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovieD",
				},
				{
					["message"] = "ZEKES2",
				},
			},
		},
		["UNDERATTACK"] = {
			["sequence"] = {
				{
					["message"] = "UNDERATTACK1",
				},
			},
		},
		["RESPOND"] = {
			["sequence"] = {
				{
					["message"] = "RESPOND1",
				},
			},
		},
		["GOTONE"] = {
			["sequence"] = {
				{
					["message"] = "GOTONE1",
				},
				{
					["message"] = "GOTONE2",
				},
			},
		},
		["PAYLOAD"] = {
			["sequence"] = {
				{
					["message"] = "PAYLOAD1",
				},
			},
		},
		["FAILED1"] = {
			["sequence"] = {
				{
					["message"] = "FAILED1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionFailed",
				},
			},
		},
		["FAILED2"] = {
			["sequence"] = {
				{
					["message"] = "FAILED2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionFailed",
				},
			},
		},
		["SMOKED"] = {
			["sequence"] = {
				{
					["message"] = "SMOKED1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaExitedDia",
				},
			},
		},
		["EXITED"] = {
			["sequence"] = {
				{
					["message"] = "EXITED1",
				},
				{
					["message"] = "EXITED2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh2Blackout",
				},
			},
		},
		["TIGER1"] = {
			["sequence"] = {
				{
					["message"] = "TIGER1",
				},
				{
					["message"] = "TIGER2",
				},
			},
		},
		["TIGER2"] = {
			["sequence"] = {
				{
					["message"] = "TIGER3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecondObjs",
				},
			},
		},
		["NAVPOINT"] = {
			["sequence"] = {
				{
					["message"] = "TIGER4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddAttackerRetreatObj",
				},
			},
		},
		["BOBCAT"] = {
			["sequence"] = {
				{
					["message"] = "BOBCAT1",
				},
			},
		},
		["PANTHER"] = {
			["sequence"] = {
				{
					["message"] = "PANTHER1",
				},
			},
		},
		["COUGAR"] = {
			["sequence"] = {
				{
					["message"] = "COUGAR1",
				},
			},
		},
		["TANKER"] = {
			["sequence"] = {
				{
					["message"] = "TANKER1",
				},
			},
		},
		["JOB"] = {
			["sequence"] = {
				{
					["message"] = "JOB1",
				},
				{
					["message"] = "JOB2",
				},
				{
					["message"] = "JOB3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObj",
				},
			},
		},
		["HORNETS"] = {
			["sequence"] = {
				{
					["message"] = "HORNETS1",
				},
				{
					["message"] = "HORNETS2",
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
	
	Mission.Donald = FindEntity("Donald")
	
	SetGuiName(Mission.Donald, "Donald")
	SetSkillLevel(Mission.Donald, SKILL_ELITE)
	
	Mission.FortressRed = FindEntity("B-17")
	Mission.Cat = FindEntity("Wildcat")
	
	SetSkillLevel(Mission.FortressRed, Mission.SkillLevelOwn)
	SetSkillLevel(Mission.Cat, Mission.SkillLevelOwn)
	
	Mission.FortressGang = {}
		table.insert(Mission.FortressGang, FindEntity("B-17"))
	
	Mission.AttackerRetreat = FindEntity("RetreatPoint")
	
	Mission.AttackerGang = {}
	Mission.LexGang = {}
	
	---- IJN ----
	
	Mission.TypeA6M = 150
	
	Mission.Airfield = FindEntity("AirField")
	--Mission.AirfieldHangar = FindEntity("Hangar1")
	
	--OverrideHP(Mission.Airfield, Mission.Airfield.Class.HP / 2.2)
	--OverrideHP(Mission.AirfieldHangar, Mission.AirfieldHangar.Class.HP / 2.2)
	
	Mission.BruhThisAintABBlol = FindEntity("Tone")
	
	Mission.BruhCanIPleaseDieBruh = {}
		table.insert(Mission.BruhCanIPleaseDieBruh, Mission.BruhThisAintABBlol)
	
	SetSkillLevel(Mission.BruhThisAintABBlol, Mission.SkillLevel)
	
	if Mission.Difficulty == 2 then
		
		AAEnable(Mission.BruhThisAintABBlol, true)
	
	else
	
		AAEnable(Mission.BruhThisAintABBlol, false)
	
	end
	
	RepairEnable(Mission.BruhThisAintABBlol, false)
	
	SetSkillLevel(Mission.BruhThisAintABBlol, Mission.SkillLevel)
	
	Mission.Tanker = FindEntity("Horai Maru")
	
	Mission.GyioGang = {}
		table.insert(Mission.GyioGang, FindEntity("Gyoraitei No 7"))
		table.insert(Mission.GyioGang, FindEntity("Gyoraitei No 8"))
		table.insert(Mission.GyioGang, FindEntity("Gyoraitei No 10"))
	
	for idx,unit in pairs(Mission.GyioGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		AAEnable(unit, true)
		
	end
	
	Mission.DDGang = {}
		table.insert(Mission.DDGang, FindEntity("Sazanami"))
		table.insert(Mission.DDGang, FindEntity("Nenohi"))
	
	for idx,unit in pairs(Mission.DDGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		if Mission.Difficulty == 0 then
			
			AAEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 then
			
			AAEnable(unit, true)
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
			
			AAEnable(unit, true)
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Kanikawa Maru"))
		table.insert(Mission.CargoGang, FindEntity("Fizan Maru"))
		table.insert(Mission.CargoGang, FindEntity("Kuretake Maru"))
		table.insert(Mission.CargoGang, FindEntity("Taishu Maru"))
		table.insert(Mission.CargoGang, FindEntity("Horai Maru"))
		
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
	end
	
	Mission.ZeroGang = {}
	Mission.FusoGang = {}
	Mission.FusoEscGang = {}
	Mission.ZeroEscGang = {}
	Mission.FuckinHell = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.AttackPhase = 0
	Mission.MaryAnneCounter = 0
	
	Mission.CurrentAttacker = nil
	Mission.AttackerPresent = false
	
	if Mission.Difficulty == 0 then
		
		Mission.DonaldHPFactor = 2.7
		Mission.JapAI = 1
		Mission.AFZeroNum = 0
	
	elseif Mission.Difficulty == 1 then
		
		Mission.DonaldHPFactor = 2.3
		Mission.JapAI = 2
		Mission.AFZeroNum = 1
	
	elseif Mission.Difficulty == 2 then
		
		Mission.DonaldHPFactor = 2
		Mission.JapAI = 3
		Mission.AFZeroNum = 2
	
	end
	
	---- INIT FUNCT. ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	Blackout(true, "", true)
	
	MissionNarrative("January 20th, 1942 - Luzon Island")
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--Mission.Debug = false
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPoint(FindEntity("AttackersSpawn"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
	--luaMoveToPh2()
	
	--luaMoveToPh2()
	
	--luaStartDialog("PANTHER")
	
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
		
		if Mission.CanMusicCheck then
		
			local music_selectedUnit = GetSelectedUnit()

			if music_selectedUnit then

				luaCheckMusic(music_selectedUnit)

			end
		
		end
		
		if Mission.DonaldsPart then
		
			if not Mission.Donald or Mission.Donald.Dead then
			
				luaMissionFailed(nil)
			
			end
			
			if Mission.CatChasin then
			
				if Mission.Cat and not Mission.Cat.Dead then
				
					if luaGetScriptTarget(Mission.Cat) == nil or luaGetScriptTarget(Mission.Cat).Dead then
					
						local trg = luaGetCatTrg()
						
						if trg == nil then
						
							PilotMoveToRange(Mission.Cat, Mission.Donald)
						
						else
							
							luaSetScriptTarget(Mission.Cat, trg)
							PilotSetTarget(Mission.Cat, trg)
						
						end
					
					end
				
				end	
			
			end
			
		end
		
		if luaObj_IsActive("secondary",1) then
		
			if Mission.Tanker.Dead then
			
				luaObj_Completed("secondary", 1)
				
				luaStartDialog("TANKER")
			
			end
		
		end
		
		if luaObj_IsActive("hidden",1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.DDGang)) == 0 and not Mission.HarborDDsDead then
			
				Mission.HarborDDsDead = true
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase == 1 then
		
		if Mission.Difficulty > 0 then
		
			if not Mission.Airfield.Dead then
				
				local zero = {
				
					[1] = Mission.TypeA6M,
					
				}
				
				luaCapManager(Mission.Airfield, zero, Mission.AFZeroNum)
			
			end
		
		end
		
		if not Mission.FortressRed or Mission.FortressRed.Dead then
			
			if not Mission.Donald.Dead then
			
				luaMissionFailed(Mission.Donald)
			
			else
			
				luaMissionFailed(nil)
			
			end
			
		end
		
		if luaObj_IsActive("primary",2) then
		
			if Mission.Airfield.Dead then
				
				luaDelay(luaDelayedSmokedDia, 4)
				
			end
		
		end
		
	elseif Mission.MissionPhase == 2 then
		
		if luaObj_IsActive("primary",3) then
		
			if Mission.BruhThisAintABBlol.Dead then
				
				HideUnitHP()
				luaObj_Completed("primary", 3)
				luaObj_Completed("primary", 1)
				
				if Mission.AttackerReatreating then
				
					HideScoreDisplay(2,0)
					
					Mission.AttackerReatreating = false
				
				end
				
				if not luaObj_IsActive("primary",4) then
				
					luaObj_Add("primary", 4, GetPosition(Mission.AttackerRetreat))
				
				end
				
				luaObj_Completed("primary", 4)
				
				luaMoveToPh3()
				
			end
			
			if Mission.AttackerReatreating then
				
				if Mission.CurrentAttacker and not Mission.CurrentAttacker.Dead then
				
					luaDistanceCounter(Mission.CurrentAttacker, Mission.AttackerRetreat, 2, "Retreat to the navigation point with your squadron!", "ijn14.distance")
				
					if luaGetDistance(Mission.CurrentAttacker, Mission.AttackerRetreat) < 1500 then
						
						if Mission.AttackPhase == 4 then
							
							if not Mission.BruhThisAintABBlol.Dead then
							
								HideScoreDisplay(2,0)
								
								Mission.AttackerReatreating = false
								
								luaBombFailedDia()
							
							end
							
						else
						
							HideScoreDisplay(2,0)
							
							Mission.AttackerReatreating = false
							
							Mission.PrevAttacker = Mission.CurrentAttacker
							
							luaDelay(luaKillPreviousAttacker, 1)
							
							Blackout(true, "luaTickNextAttacker", 1)
							
						end
						
					end
				
				elseif Mission.CurrentAttacker.Dead then
					
					if Mission.AttackPhase == 4 then
					
						HideScoreDisplay(2,0)
						
						Mission.AttackerReatreating = false
						
						luaBombFailedDia()
					
					else
					
						HideScoreDisplay(2,0)
					
						Mission.AttackerReatreating = false
						
						Blackout(true, "luaTickNextAttacker", 1)
						
					end
					
				end
			
			else
		
				if Mission.CurrentAttacker.Dead then
					
					if Mission.AttackPhase == 4 then
						
						if Mission.LastSquadDropped then
							
							luaDelay(luaCheckBombFailed, 20)
							
						else
						
							luaBombFailedDia()
						
						end
						
					else
					
						Blackout(true, "luaTickNextAttacker", 1)
					
					end
					
				end
			
			end
		
		end
		
	elseif Mission.MissionPhase == 3 then
		
		if luaObj_IsActive("primary",5) then
			
			if Mission.Lex.Dead then
			
				luaMissionFailed(Mission.Lex)
			
			end
			
			if Mission.BruhReallySheDiedInSurigaoStrait.Dead then
			
				HideUnitHP()
				luaObj_Completed("primary", 5)
				luaObj_Completed("primary", 6)
				
				luaMissionComplete(Mission.BruhReallySheDiedInSurigaoStrait)
				
			end
		
		end
		
		if luaObj_IsActive("hidden",1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.FusoEscGang)) == 0 and Mission.HarborDDsDead then
			
				luaObj_Completed("hidden", 1)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.ZeroEscGang)) == 0 and not Mission.HornetDiaPlayed then
		
			luaStartDialog("HORNETS")
			
			Mission.HornetDiaPlayed = true
		
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 3 ----

function luaMoveToPh3()
	
	Loading_Start()
	
	Mission.MissionPhase = 3
	Mission.DonaldsPart = false
	
	if table.getn(luaRemoveDeadsFromTable(Mission.AttackerGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AttackerGang)) do
		
			if unit and not unit.Dead then
			
				Kill(unit,true)
			
			end
		
		end
	
	end
	
	if Mission.Cat and not Mission.Cat.Dead then
	
		Kill(Mission.Cat, true)
	
	end
	
	if Mission.Donald and not Mission.Donald.Dead then
	
		Kill(Mission.Donald, true)
	
	end
	
	Mission.Lex = GenerateObject("Lexington")
	Mission.LexEsc1 = GenerateObject("Brooks")
	
	SetRoleAvailable(Mission.LexEsc1, EROLF_ALL, PLAYER_AI)
	PutRelTo(Mission.LexEsc1, Mission.Lex, {["x"]=-300,["y"]=0,["z"]=-300})
	JoinFormation(Mission.LexEsc1, Mission.Lex)
	
	UnitSetPlayerCommandsEnabled(Mission.Lex, PCF_NONE)
	SetRoleAvailable(Mission.Lex, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Lex, EROLF_SPECIAL+EROLF_CAPTAIN, PLAYER_ANY)
	NavigatorMoveOnPath(Mission.Lex, FindEntity("carrier_path"), PATH_FM_CIRCLE, PATH_SM_BEGIN)
	
	table.insert(Mission.LexGang, Mission.Lex)
	table.insert(Mission.LexGang, Mission.LexEsc1)
	
	for idx,unit in pairs(Mission.LexGang) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		
	end
	
	Mission.BruhReallySheDiedInSurigaoStrait = GenerateObject("Fuso")
	Mission.Esc1 = GenerateObject("Yamakaze")
	Mission.Esc2 = GenerateObject("Yudachi")
	
	table.insert(Mission.FusoGang, FindEntity("Fuso"))
	table.insert(Mission.FusoGang, FindEntity("Yamakaze"))
	table.insert(Mission.FusoGang, FindEntity("Yudachi"))
	
	table.insert(Mission.FusoEscGang, FindEntity("Yamakaze"))
	table.insert(Mission.FusoEscGang, FindEntity("Yudachi"))
	
	table.insert(Mission.FuckinHell, FindEntity("Fuso"))
	
	for idx,unit in pairs(Mission.FusoGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		JoinFormation(unit, Mission.FusoGang[1])
		
		if Mission.Difficulty == 0 then
			
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 then
			
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
			
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	if Mission.Difficulty == 0 then
	
		NavigatorMoveOnPath(Mission.BruhReallySheDiedInSurigaoStrait, FindEntity("bb_path"), PATH_FM_SIMPLE, PATH_SM_JOIN, 3)
	
	elseif Mission.Difficulty == 1 then
	
		SetShipMaxSpeed(Mission.BruhReallySheDiedInSurigaoStrait, 5)
		NavigatorMoveToRange(Mission.BruhReallySheDiedInSurigaoStrait, Mission.Lex)
	
	elseif Mission.Difficulty == 2 then
	
		SetShipMaxSpeed(Mission.BruhReallySheDiedInSurigaoStrait, 8)
		NavigatorMoveToRange(Mission.BruhReallySheDiedInSurigaoStrait, Mission.Lex)
	
	end
	
	local pos = {["x"]=0, ["y"] = Mission.BruhReallySheDiedInSurigaoStrait.Class.Height+3, ["z"]=0 }
	Effect("RealGiantSmoke", pos, Mission.BruhReallySheDiedInSurigaoStrait, 20)
	
	Mission.ZeroEsc1 = GenerateObject("BB_Fighter1")
	Mission.ZeroEsc2 = GenerateObject("BB_Fighter2")
	
	table.insert(Mission.ZeroEscGang, FindEntity("BB_Fighter1"))
	table.insert(Mission.ZeroEscGang, FindEntity("BB_Fighter2"))
	
	for idx,unit in pairs(Mission.ZeroEscGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		PilotMoveTo(unit, Mission.BruhReallySheDiedInSurigaoStrait)
		
	end
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaPh3MovieEnd()
	
end

function luaPh3MovieEnd()

	SetSelectedUnit(Mission.Lex)
	
	luaDelay(luaJobDia, 1)
	
end

function luaJobDia()

	luaStartDialog("JOB")

end

function luaAddFinalObj()

	luaObj_Add("primary", 5, Mission.BruhReallySheDiedInSurigaoStrait)
	luaObj_Add("primary", 6, Mission.Lex)
	
	DisplayUnitHP((Mission.FuckinHell), "Destroy the attacking Japanese battleship!")

end

---- PHASE 2 ----

function luaPh2Blackout()

	Blackout(true, "luaMoveToPh2", 1)

end

function luaMoveToPh2()
	
	Mission.MissionPhase = 2
	--Mission.DonaldsPart = false
	
	if IsListenerActive("hit", "FortressHitListener") then
	
		RemoveListener("hit", "FortressHitListener")
	
	end
	
	if IsListenerActive("kill", "CatKillListener") then
	
		RemoveListener("kill", "CatKillListener")
	
	end
	
	if IsListenerActive("recon", "SecondZeroListener") then
	
		RemoveListener("recon", "SecondZeroListener")
	
	end
	
	if Mission.FortressRed and not Mission.FortressRed.Dead then
	
		Kill(Mission.FortressRed, true)
	
	end
	
	--[[if Mission.Cat and not Mission.Cat.Dead then
	
		Kill(Mission.Cat, true)
	
	end]]
	
	if table.getn(luaRemoveDeadsFromTable(Mission.ZeroGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ZeroGang)) do
		
			if unit and not unit.Dead then
			
				Kill(unit,true)
			
			end
		
		end
	
	end
	
	if Mission.GyioGang[2] and not Mission.GyioGang[2].Dead then
		
		NavigatorMoveOnPath(Mission.GyioGang[2], FindEntity("pt_path3"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	
	end
	
	if Mission.GyioGang[3] and not Mission.GyioGang[3].Dead then
		
		NavigatorMoveOnPath(Mission.GyioGang[3], FindEntity("pt_path1"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	
	end	
	
	UnitHoldFire(Mission.Donald)
	
	luaTickNextAttacker()
	
end

function luaTickNextAttacker()

	Mission.AttackPhase = Mission.AttackPhase + 1
	
	luaSpawnNextAttacker()

end

function luaSpawnNextAttacker()

	if Mission.AttackPhase == 1 or Mission.AttackPhase == 3 then
	
		Mission.Diver = true
		
		Mission.CurrentAttacker = GenerateObject("Dauntless")
		
		SquadronSetTravelAlt(Mission.CurrentAttacker, 900)
		SquadronSetAttackAlt(Mission.CurrentAttacker, 900)	
		
	elseif Mission.AttackPhase == 2 or Mission.AttackPhase == 4 then
	
		Mission.Diver = false
		
		Mission.CurrentAttacker = GenerateObject("Avenger")
		
		SquadronSetTravelAlt(Mission.CurrentAttacker, 400)
		
	end
	
	luaNextAttackerSpawned()
	
end

function luaNextAttackerSpawned()
	
	SetSkillLevel(Mission.CurrentAttacker, Mission.SkillLevelOwn)
	--PutTo(Mission.CurrentAttacker, FindEntity("AttackersSpawn"))
	
	table.insert(Mission.AttackerGang, Mission.CurrentAttacker)
	
	AddSquadOrdnanceDroppedTrigger(Mission.CurrentAttacker, nil, "luaAttackerRetreat")
	
	if not Mission.TigerMoviePlayed then
		
		--Blackout(true, "luaPlayTigerMovie", 1)
		
		SetInvincible(Mission.CurrentAttacker, 0.5)
		
		luaPlayTigerMovie()
		
	else
		
		PilotSetTarget(Mission.CurrentAttacker, Mission.BruhThisAintABBlol)
		
		if Mission.AttackPhase == 2 then
		
			luaDelay(luaBobcatDia, 1.5)
		
		elseif Mission.AttackePhase == 3 then
		
			luaDelay(luaPantherDia, 1.5)
		
		elseif Mission.AttackPhase == 4 then
			
			AddSquadOrdnanceDroppedTrigger(Mission.CurrentAttacker, nil, "luaLastAttackerDropped")
			
			luaDelay(luaCougarDia, 1.5)
		
		end
		
		SetSelectedUnit(Mission.CurrentAttacker)
		
		Blackout(false, "", 1)
		
	end
	
	PilotMoveTo(Mission.Donald, Mission.CurrentAttacker)
	
end

function luaAttackerRetreat()
	
	--[[if Mission.AttackPhase == 4 then
	
		luaDelay(luaCheckBombFailed, 30)
	
	else]]
	
		if Mission.AttackPhase == 1 and not Mission.TigerDroppedDiaPlayed then
		
			luaStartDialog("NAVPOINT")
			
			Mission.TigerDroppedDiaPlayed = true
		
		else
		
			luaAddAttackerRetreatObj()
		
		end
		
	--end

end

function luaLastAttackerDropped()

	Mission.LastSquadDropped = true

end

function luaAddAttackerRetreatObj()
	
	if Mission.CurrentAttacker and not Mission.CurrentAttacker.Dead then
	
		local ammo = GetProperty(Mission.CurrentAttacker, "ammoType")
		
		if ammo == 0 then
		
			if not Mission.RetreatObjAdded then
			
				luaObj_Add("primary", 4, GetPosition(Mission.AttackerRetreat))
				
				Mission.RetreatObjAdded = true
			
			else
			
				MissionNarrative("Retreat to the navigation point with your squadron!")
			
			end
		
			PilotMoveToRange(Mission.CurrentAttacker, Mission.AttackerRetreat)
		
			Mission.AttackerReatreating = true
		
		end
		
	end
	
end

function luaPlayTigerMovie()

	local trg = Mission.CurrentAttacker
	
	--SquadronSetTravelAlt(trg, 400)
	PilotMoveToRange(trg, Mission.BruhThisAintABBlol, 500)
	
	local pos0 = {
		["postype"]="cameraandtarget",
		["position"]= {
			["parent"]=trg,
			["modifier"] = {
				["name"] = "goaround",
				["radius"] = { 30, 5, 20, 8, 25, },
				["radiuslinearblend"] = 0.3,
				["theta"] = {0, 6, 5, 12, 10, },
				["thetalinearblend"] = 0.3,
				["rho"] = {180, 13, -130  },
				["rholinearblend"] = 0.5,
			}
		},
		["transformtype"]="keepz",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["finishscript"] = "luaTigerMovieRun",
	}
	
	MovCamNew_AddPosition(pos0)
	
	luaStartDialog("TIGER1")
	
end

function luaTigerMovieRun()
	
	Blackout(false, "", 1)
	
	luaDelay(luaTigerMovieEnd, 12)
	
end

function luaTigerMovieEnd()
	
	Blackout(true, "luaTigerSelect", 1)
	
end

function luaTigerSelect()
	
	SetSelectedUnit(Mission.CurrentAttacker)
	PilotSetTarget(Mission.CurrentAttacker, Mission.BruhThisAintABBlol)
	
	PilotMoveTo(Mission.Donald, Mission.CurrentAttacker)
	
	Blackout(false, "", 1)
	
	Mission.TigerMoviePlayed = true
	
	luaDelay(luaTigerDia, 1)
	
end

function luaCheckBombFailed()

	if not Mission.BruhThisAintABBlol.Dead then
	
		luaBombFailedDia()
	
	end

end

function luaBombFailedDia()
	
	SetInvincible(Mission.BruhThisAintABBlol, 0.01)
	
	luaStartDialog("FAILED2")

end

function luaCougarDia()

	luaStartDialog("COUGAR")

end

function luaPantherDia()

	luaStartDialog("PANTHER")

end

function luaBobcatDia()

	luaStartDialog("BOBCAT")

end

function luaTigerDia()

	luaStartDialog("TIGER2")

end

function luaKillPreviousAttacker()

	if Mission.PrevAttacker and not Mission.PrevAttacker.Dead then
	
		Kill(Mission.PrevAttacker, true)
	
	end

end

function luaAddSecondObjs()
	
	SetInvincible(Mission.CurrentAttacker, 0.0)
	
	luaObj_Add("primary", 3, Mission.BruhThisAintABBlol)
	
	DisplayUnitHP((Mission.BruhCanIPleaseDieBruh), "Sink the anchored Japanese battleship in the harbor!")

end

function luaGetCatTrg()
	
	if Mission.Cat and not Mission.Cat.Dead then
	
		local trgs = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 400000, PARTY_ALLIED, "enemy")
		
		if trgs then
		
			local sortedTrgs = luaSortByDistance(Mission.Cat, trgs)
			
			local trg = sortedTrgs[1]
			
			return trg
		
		else
		
			return nil
		
		end
		
	end
	
end

---- PHASE 1 ----

function luaStartMission()
	
	Mission.DonaldsPart = true
	
	SetRoleAvailable(Mission.Cat, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.FortressRed, EROLF_ALL, PLAYER_AI)
	
	SetInvincible(Mission.FortressRed, 1.0)
	SetInvincible(Mission.Cat, 0.4)
	
	--OverrideHP(Mission.Donald, Mission.Donald.Class.HP * Mission.DonaldHPFactor)
	
	SquadronSetSpeed(Mission.Cat, KMH(150))
	SquadronSetSpeed(Mission.FortressRed, KMH(150))
	SquadronSetTravelSpeed(Mission.Cat, KMH(150))	
	SquadronSetTravelSpeed(Mission.FortressRed, KMH(150))
	SquadronSetWandererMul(Mission.Cat, 0.1)
	SquadronSetWandererMul(Mission.FortressRed, 0)
	
	UnitHoldFire(Mission.Donald)
	SquadronSetTravelAlt(Mission.Donald, 1220)
	UnitHoldFire(Mission.Cat)
	
	NavigatorMoveOnPath(FindEntity("Gyoraitei No 7"), FindEntity("pt_path2"), PATH_FM_CIRCLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(FindEntity("Cutter"),FindEntity("pt_path3"),PATH_FM_CIRCLE,PATH_SM_JOIN)
	NavigatorMoveOnPath(FindEntity("Fishingboat"),FindEntity("fishing"),PATH_FM_CIRCLE,PATH_SM_JOIN)
	
	SquadronSetTravelAlt(Mission.Cat, 1185)
	SquadronSetTravelAlt(Mission.FortressRed, 1200)
	SquadronSetAttackAlt(Mission.FortressRed, 1200)		
	SquadronSetSpeed(Mission.Donald, 50)
	SquadronSetTravelSpeed(Mission.Donald, 50)
	
	PilotSetTarget(Mission.FortressRed, Mission.Airfield)
	PilotMoveToRange(Mission.Donald, Mission.Airfield, 1000)
	PilotMoveToRange(Mission.Cat, Mission.Airfield, 1000)
	
	AddSquadOrdnanceDroppedTrigger(Mission.FortressRed, nil, "luaFortressDroppedBombs")
	luaAddFortressListener()
	luaAddMaryAnneListener()
	luaAddAFListener()
	
	Blackout(false, "", 1)
	
	luaIntroMovieA()
	
	luaDelay(luaIntroDia, 2)
	
end

function luaFortressDroppedBombs()
	
	HideUnitHP()
	luaObj_Completed("primary", 2)
	
	SetInvincible(Mission.FortressRed, 0.01)
	
	--PilotRetreat(Mission.FortressRed)
	--UnitHoldFire(Mission.Cat)
	--PilotRetreat(Mission.Cat)
	
	luaStartDialog("PAYLOAD")
	
	luaDelay(luaCheckAirfield, 45)
	
	Mission.FortressRedCleared = true
	
end

function luaCheckAirfield()
	
	if luaObj_IsActive("primary",2) then
	
		if not Mission.Airfield.Dead then
			
			SetInvincible(Mission.Airfield, 0.01)
			
			luaStartDialog("FAILED1")
		
		end
		
	end

end

function luaSpawnFirstZeros()
	
	--if not Mission.ZeroFlowStarted then
	
		luaSpawnJap(Mission.TypeA6M, 5, GetPosition(FindEntity("FirstZeroSpawn")), 0, 0, 1200, 0)
		luaSpawnJap(Mission.TypeA6M, 5, GetPosition(FindEntity("SecondZeroSpawn")), 0, 0, 1200, 0)
	
		--Mission.ZeroFlowStarted = true
	
	--[[else
	
		luaSpawnJap(Mission.TypeA6M, 5, GetPosition(FindEntity("SecondZeroSpawn")), 0, 0, 1200, 0)
	
	end]]
	
	--[[if Mission.ZeroFlowStarted and Mission.ZerosCanSpawn then
	
		luaDelay(luaSpawnFirstZeros, 50)
	
	end]]
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 2, Mission.FortressGang)
	luaObj_Add("primary", 1, Mission.Donald)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP((Mission.FortressGang), "Defend the B-17 bomber squad!")

end

function luaDelayedSmokedDia()

	luaSmokedDia()

end

function luaSmokedDia()
	
	--Mission.ZerosCanSpawn = false
	
	if not Mission.FortressRedCleared then
	
		luaFortressDroppedBombs()
	
	end
	
	luaObj_Add("secondary", 1)
	
	if Mission.Tanker and not Mission.Tanker.Dead then
	
		luaObj_AddUnit("secondary", 1, Mission.Tanker)
	
	end
	
	luaStartDialog("SMOKED")

end

function luaExitedDia()

	luaStartDialog("EXITED")

end

---- LISTENERS ----

function luaAddAFListener()

	AddListener("hit", "AFHitListener", {
		["callback"] = "luaAFHit",
		["target"] = {Mission.Airfield},
		["targetDevice"] = {},
		["attacker"] = {Mission.FortressRed},
		["attackType"] = {"BOMB"},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddSecondZeroListener()

	AddListener("recon", "SecondZeroListener", {
		["callback"] = "luaSecondZeroSighted",
		["entity"] = {Mission.ZeroGang[2]},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddMaryAnneListener()

	AddListener("kill", "CatKillListener", {
		["callback"] = "luaSweetMaryAnne",
		["entity"] = Mission.ZeroGang,
		["lastAttacker"] = {Mission.Cat},
		["lastAttackerPlayerIndex"] = {},
	})

end

function luaAddFortressListener()

	AddListener("hit", "FortressHitListener", {
		["callback"] = "luaFortressHit",
		["target"] = {Mission.FortressRed},
		["targetDevice"] = {},
		["attacker"] = Mission.ZeroGang,
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

---- LISTENER CALLBACKS ----

function luaAFHit()
	
	RemoveListener("hit", "AFHitListener")
	
	AddDamage(Mission.Airfield, 9999)

end

function luaSecondZeroSighted()

	RemoveListener("recon", "SecondZeroListener")
	
	luaStartDialog("RESPOND")

end

function luaSweetMaryAnne()
	
	Mission.MaryAnneCounter = Mission.MaryAnneCounter + 1
	
	if Mission.MaryAnneCounter >= 3 then
		
		RemoveListener("kill", "CatKillListener")
		
		luaStartDialog("GOTONE")
	
	end
	
end

function luaFortressHit()
	
	RemoveListener("hit", "FortressHitListener")
	
	luaStartDialog("UNDERATTACK")

end

---- JAP SPAWNERS ----

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
		
		SquadronSetTravelAlt(unit, 1200)
		SquadronSetAttackAlt(unit, 1200)	
		
		PilotSetTarget(unit, Mission.FortressRed)
		
		table.insert(Mission.ZeroGang, unit)
		
	end
	
end

---- INTRO MOVIE ----

function luaIntroMovieA()

	local camTrg = GetSquadronPlanes(Mission.Cat)
	local camUnit = thisTable[tostring(camTrg[1])]
	
	local b17squad = GetSquadronPlanes(Mission.FortressRed)
	local b17plane = thisTable[tostring(b17squad[2])]

	SquadronSetWandererMul(Mission.Cat, 0)
	SquadronSetWandererMul(Mission.FortressRed, 0)				

	local pos0 = {
        ["postype"]="cameraandtarget",
        ["position"]= {
            ["parent"]= b17plane,
            ["pos"] = { 33.74, 5, 162.13 },
        },
        ["transformtype"]="keepy",
        ["starttime"]=0.0,
        ["blendtime"]=0.0,
	  		 ["linearblend"]=1.0,
				 ["wanderer"]=true,
        ["zoom"] = 1.25,
    }
    
    MovCamNew_AddPosition(pos0) 

	local pos1 = {
		["postype"]="cameraandtarget",
		["position"]= {
			["parent"]= b17plane,
			["pos"] = { 13.74, -27, -172.13 }
		},
		["transformtype"]="keepy",
		["starttime"]=0.0,
		["blendtime"]=13,
		["linearblend"]=1.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["zoom"]=1.25,
	}

	MovCamNew_AddPosition(pos1)

end

function luaIntroMovieB()

	local camTrg = GetSquadronPlanes(Mission.Cat)
	local camUnit = thisTable[tostring(camTrg[1])]
	
	local b17squad = GetSquadronPlanes(Mission.FortressRed)
	local b17plane = thisTable[tostring(b17squad[4])]

	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=GetSquadronPlane(Mission.Cat, 1),
			["pos"] = { 30.94, 0.30, -19.50 },
			--["relativetotarget"] = true,
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["wanderer"] = false,
		["transformtype"]="keepy",
		["zoom"]=1.75,
	}

	MovCamNew_AddPosition(pos0)

	local pos1 = {
		["postype"]="target",
		["position"]= {
			["parent"]=GetSquadronPlane(Mission.Cat, 1),
			["pos"] = { -23.45, 3.00, 15.66, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["transformtype"]="keepy",
		["zoom"]=1.75,
	}

	MovCamNew_AddPosition(pos1)

end

function luaIntroMovieC()

	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]= GetSquadronPlane(Mission.FortressRed, 2),
			["pos"] = { 4.23, 7.50, 34.97 },
--			["pos"] = { -40.23, 11.00, 4.97 },
			--["relativetotarget"] = true,
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["transformtype"]="keepy",
		["wanderer"] = false,
		["zoom"]=1.2,
	}

	MovCamNew_AddPosition(pos0)

	local pos1 = {
		["postype"]="target",
		["position"]= {
			["parent"]= GetSquadronPlane(Mission.Cat, 0), --GetSquadronPlane(Mission.B17s, 2),
			["pos"] = { 0.00, 0.00, 0.00, },
--			["pos"] = { 24.60, -3, -5.15, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["wanderer"] = false,
		["transformtype"]="keepy",
		["zoom"]=1.2,
	}	

	MovCamNew_AddPosition(pos1)

	local pos1 = {
		["postype"]="target",
		["position"]= {
			["parent"]= GetSquadronPlane(Mission.FortressRed, 2), --GetSquadronPlane(Mission.B17s, 2),
			["pos"] = { -5.00, 0.00, 0.00, },
--			["pos"] = { 24.60, -3, -5.15, },
		},
		["starttime"]=0.0,
		["blendtime"]=20.0,
		["linearblend"]=1.0,
		["wanderer"] = false,
		["transformtype"]="keepy",
		["zoom"]=1.2,
	}	

	MovCamNew_AddPosition(pos1)

end

function luaIntroMovieD()
	
	Mission.CanMusicCheck = true
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=GetSquadronPlane(Mission.Cat,2),
			["pos"] = { 4, 1, -20 },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["transformtype"]="keepy",
		["zoom"]=1.15,
	}

	MovCamNew_AddPosition(pos0)

	local pos1 = {
		["postype"]="target",
		["position"]= {
			["parent"]=GetSquadronPlane(Mission.Cat,2),
			["pos"] = { 0.00, 5.00, 30.00, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["transformtype"]="keepy",
		["zoom"]=1.15,
	}

	MovCamNew_AddPosition(pos1)
	
	--Mission.ZerosCanSpawn = true
	
	luaSpawnFirstZeros()
	
	luaDelay(luaIntroMovieEnd, 8)
	
end

function luaIntroMovieEnd()
	
	SetInvincible(Mission.FortressRed, 0.0)
	
	SetSelectedUnit(Mission.Donald)
	
	UnitSetFireStance(Mission.Donald, 1)
	--UnitSetFireStance(Mission.Cat, 1)
	luaSetScriptTarget(Mission.Cat, Mission.ZeroGang[1])
	PilotSetTarget(Mission.Cat, Mission.ZeroGang[1])
	Mission.CatChasin = true
	
	luaAddFirstObjs()
	
	luaAddSecondZeroListener()
	
end

function luaZekesDia()

	luaStartDialog("ZEKES")

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

---- MOVIES -----

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m0403.bik")

end

---- MISSION ENDERS ----

function luaMissionComplete(unit)
	
	Mission.EndMission = true
	
	luaStopDialogues()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
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
	
	if luaObj_IsActive("primary",6) then
		
		luaObj_Completed("primary",6)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(unit, "The enemy battleship is sinking! - Mission Complete", "campaigns/BSM/m0404.bik")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true
	
	luaStopDialogues()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
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
	
	if luaObj_IsActive("primary",6) then
		
		luaObj_Failed("primary",6)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if Mission.DonaldsPart and not Mission.Donald.Dead then
		
		SetInvincible(Mission.Donald, 0.01)
		
		luaMissionFailedNew(Mission.Donald, "Game Over")
		
	else
	
		luaMissionFailedNew(unit, "Game Over")
	
	end
	
end

---- SUPPPORT FUNCTIONS ----

function luaStopDialogues()

	local dlg = GetActDialogIDs()
	
	if next(dlg) ~= nil then
	
		for idx,actdlg in pairs(dlg) do
		
			KillDialog(actdlg)
			
		end
		
	end

end

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
	
	if not Mission.EndMission then
	
		if type(dialogID) ~= "string" then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue not a string! Dialogue ID: #Mission.DialogID#")
			end
			error("***ERROR: luaStartDialog's param must be a string!", 2)
		end

		if Mission.Dialogues[dialogID] == nil then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue non-existent! Dialogue ID: #Mission.DialogID#")
			end
			error("***ERROR: luaStartDialog cannot continue, non existing dialog: "..dialogID, 2)
		end

		if Mission.Dialogues[dialogID].printed and not ignorePrinted then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue already printed! Dialogue ID: #Mission.DialogID#")
			end
			return
		end

		StartDialog(dialogID, Mission.Dialogues[dialogID])
		Mission.Dialogues[dialogID].printed = true
		Mission.LastDialog = math.floor(GameTime())

		if log then
		end

	end

end

function luaAddPowerup(type)
	
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
	
end