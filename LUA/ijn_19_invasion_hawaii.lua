---- INVASION OF HAWAII (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- INVASION OF HAWAII (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(392) 	-- P51
	--PrepareClass(493) 	-- F8F
	PrepareClass(331) 	-- BTD
	PrepareClass(38) 	-- SB2C
	PrepareClass(117) 	-- B29
	
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
	
	LoadMessageMap("ijndlg",14)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_19_invasion_hawaii.lua"

	this.Name = "IJN19"
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
				["Text"] = "Capture the harbor!",
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
			--[[[3] = {
				["ID"] = "Raid",
				["Text"] = "Survive the air raid!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]
		},
		["secondary"] = {
			[1] = {
				["ID"] = "CV",
				["Text"] = "Ensure the survival of all your carriers!",
				["TextFailed"] = "One of your carriers is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Yatamo",
				["Text"] = "Ensure Yamato's survival!",
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
					["message"] = "AYEYO1",
				},
				{
					["message"] = "AYEYO2",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01c",
				},
			},
		},
		["ATTACKS"] = {--
			["sequence"] = {
				{
					["message"] = "AYEYO3",
				},
			},
		},
		["I400"] = {--
			["sequence"] = {
				{
					["message"] = "I4001",
				},
				{
					["message"] = "I4002",
				},
			},
		},
		["BLOCKADE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "BLOCKADE1",
				},
			},
		},
		["CVS"] = {--
			["sequence"] = {
				{
					["message"] = "CVS1",
				},
				{
					["message"] = "CVS2",
				},
				{
					["message"] = "CVS3",
				},
			},
		},
		["LAST"] = {--
			["sequence"] = {
				{
					["message"] = "dlg1c",
				},
				{
					["message"] = "dlg1d",
				},
			},
		},
		["SS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg5",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
				{
					["message"] = "BRUH1",
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
	
	---- IJN ----
	
	Mission.Yamato = FindEntity("Yamato")
	
	Mission.JapFleetA = {}
		table.insert(Mission.JapFleetA, FindEntity("Yamato"))
		--table.insert(Mission.JapFleetA, FindEntity("Zuikaku"))
		--table.insert(Mission.JapFleetA, FindEntity("Shokaku"))
		table.insert(Mission.JapFleetA, FindEntity("Azumaya"))
		table.insert(Mission.JapFleetA, FindEntity("Mitsumine"))
		--table.insert(Mission.JapFleetA, FindEntity("Hae"))
		table.insert(Mission.JapFleetA, FindEntity("Nishikaze"))
		--table.insert(Mission.JapFleetA, FindEntity("Kochi"))
		--table.insert(Mission.JapFleetA, FindEntity("Okaze"))
		--table.insert(Mission.JapFleetA, FindEntity("Asagochi"))
		--table.insert(Mission.JapFleetA, FindEntity("Shimokaze"))
		--table.insert(Mission.JapFleetA, FindEntity("Okitsukaze"))
	
	for idx,unit in pairs(Mission.JapFleetA) do
		
		JoinFormation(unit, Mission.JapFleetA[1])
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
	
	Mission.JapFleetB = {}
		--table.insert(Mission.JapFleetB, FindEntity("Kaga"))
		table.insert(Mission.JapFleetB, FindEntity("Taiho"))
		table.insert(Mission.JapFleetB, FindEntity("Washiba"))
		table.insert(Mission.JapFleetB, FindEntity("Yukigumo"))
		--table.insert(Mission.JapFleetB, FindEntity("Fuyugumo"))
		--table.insert(Mission.JapFleetB, FindEntity("Yaegumo"))
		table.insert(Mission.JapFleetB, FindEntity("Amagumo"))
		table.insert(Mission.JapFleetB, FindEntity("Harugumo"))
		table.insert(Mission.JapFleetB, FindEntity("Uchikaze Maru"))
		table.insert(Mission.JapFleetB, FindEntity("Kimikawa Maru"))
	
	for idx,unit in pairs(Mission.JapFleetB) do
		
		JoinFormation(unit, Mission.JapFleetB[1])
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
	
	Mission.JapFleetC = {}
		--table.insert(Mission.JapFleetC, FindEntity("Akagi"))
		table.insert(Mission.JapFleetC, FindEntity("Ginryu"))
		table.insert(Mission.JapFleetC, FindEntity("Kaikoma"))
		table.insert(Mission.JapFleetC, FindEntity("Urazuki"))
		--table.insert(Mission.JapFleetC, FindEntity("Yamazuki"))
		--table.insert(Mission.JapFleetC, FindEntity("Hazuki"))
		table.insert(Mission.JapFleetC, FindEntity("Otsuki"))
		table.insert(Mission.JapFleetC, FindEntity("Kiyotsuki"))
		table.insert(Mission.JapFleetC, FindEntity("Hawaii Maru"))
		table.insert(Mission.JapFleetC, FindEntity("Miyoda Maru"))
	
	for idx,unit in pairs(Mission.JapFleetC) do
		
		JoinFormation(unit, Mission.JapFleetC[1])
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
	
	Mission.JapSubs = {}
	
	if Mission.Difficulty < 2 then
	
		table.insert(Mission.JapSubs, GenerateObject("I-400"))
	
	end
	
	for idx,unit in pairs(Mission.JapSubs) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("Uchikaze Maru"))
		table.insert(Mission.JapTransports, FindEntity("Kimikawa Maru"))
		table.insert(Mission.JapTransports, FindEntity("Hawaii Maru"))
		table.insert(Mission.JapTransports, FindEntity("Miyoda Maru"))
	
	Mission.JapTransportsLeft = {}
		table.insert(Mission.JapTransportsLeft, FindEntity("Uchikaze Maru"))
		table.insert(Mission.JapTransportsLeft, FindEntity("Kimikawa Maru"))
		
	Mission.JapTransportsRight = {}
		table.insert(Mission.JapTransportsRight, FindEntity("Hawaii Maru"))
		table.insert(Mission.JapTransportsRight, FindEntity("Miyoda Maru"))
	
	Mission.JapCapitalShips = {}
		table.insert(Mission.JapCapitalShips, FindEntity("Yamato"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Zuikaku"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Shokaku"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Kaga"))
		table.insert(Mission.JapCapitalShips, FindEntity("Taiho"))
		--table.insert(Mission.JapCapitalShips, FindEntity("Akagi"))
		table.insert(Mission.JapCapitalShips, FindEntity("Ginryu"))
	
	Mission.JapCVs = {}
		--table.insert(Mission.JapCVs, FindEntity("Zuikaku"))
		--table.insert(Mission.JapCVs, FindEntity("Shokaku"))
		table.insert(Mission.JapCVs, FindEntity("Taiho"))
		table.insert(Mission.JapCVs, FindEntity("Ginryu"))
	
	Mission.JapShips = luaSumTablesIndex(Mission.JapFleetA, Mission.JapFleetB, Mission.JapFleetC)
	Mission.JapUnits = luaSumTablesIndex(Mission.JapFleetA, Mission.JapFleetB, Mission.JapFleetC, Mission.JapSubs)
	
	---- USN ----
	
	Mission.HQs = {}
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
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
		table.insert(Mission.Airfields, FindEntity("Airfield3"))
		table.insert(Mission.Airfields, FindEntity("Airfield4"))
		table.insert(Mission.Airfields, FindEntity("Airfield5"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, true)
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 2)
			
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
		table.insert(Mission.Fortresses, FindEntity("Fortress-13"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-14"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-15"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-16"))
		--[[table.insert(Mission.Fortresses, FindEntity("Fortress-17"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-18"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-19"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-20"))]]
		table.insert(Mission.Fortresses, FindEntity("Fortress-21"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-22"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-23"))
		table.insert(Mission.Fortresses, FindEntity("Fortress-24"))
	
	for idx,unit in pairs(Mission.Fortresses) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.FirstWaveA = {}
		table.insert(Mission.FirstWaveA, "Missouri")
		table.insert(Mission.FirstWaveA, "Saint Paul")
		--table.insert(Mission.FirstWaveA, "Chicago")
		table.insert(Mission.FirstWaveA, "Somers-class01")
		--table.insert(Mission.FirstWaveA, "Somers-class02")
		table.insert(Mission.FirstWaveA, "Somers-class03")
		--table.insert(Mission.FirstWaveA, "Somers-class04")
	
	Mission.FirstWaveB = {}
		table.insert(Mission.FirstWaveB, "Wisconsin")
		table.insert(Mission.FirstWaveB, "Macon")
		--table.insert(Mission.FirstWaveB, "Pittsburgh")
		--table.insert(Mission.FirstWaveB, "Somers-class05")
		table.insert(Mission.FirstWaveB, "Somers-class06")
		--table.insert(Mission.FirstWaveB, "Somers-class07")
		table.insert(Mission.FirstWaveB, "Somers-class08")
	
	Mission.SecondWaveA = {}
		table.insert(Mission.SecondWaveA, "Montana")
		table.insert(Mission.SecondWaveA, "Fall River")
		table.insert(Mission.SecondWaveA, "Somers-class09")
		--table.insert(Mission.SecondWaveA, "Somers-class10")
	
	Mission.SecondWaveB = {}
		table.insert(Mission.SecondWaveB, "Ohio")
		table.insert(Mission.SecondWaveB, "Bremerton")
		--table.insert(Mission.SecondWaveB, "Somers-class11")
		table.insert(Mission.SecondWaveB, "Somers-class12")
	
	Mission.SecondWaveC = {}
		table.insert(Mission.SecondWaveC, "Bataan")
		table.insert(Mission.SecondWaveC, "Somers-class13")
		table.insert(Mission.SecondWaveC, "Somers-class14")
	
	Mission.SecondWaveD = {}
		table.insert(Mission.SecondWaveD, "Belleau Wood")
		table.insert(Mission.SecondWaveD, "Somers-class15")
		table.insert(Mission.SecondWaveD, "Somers-class16")
	
	Mission.ThirdWave = {}
		table.insert(Mission.ThirdWave, "Saratoga")
		table.insert(Mission.ThirdWave, "Colorado-class01")
		--table.insert(Mission.ThirdWave, "Pennsylvania-class01")
		--table.insert(Mission.ThirdWave, "Pennsylvania-class02")
		--table.insert(Mission.ThirdWave, "Somers-class17")
		--table.insert(Mission.ThirdWave, "Somers-class18")
		--table.insert(Mission.ThirdWave, "Somers-class19")
		--table.insert(Mission.ThirdWave, "Somers-class20")
	
	Mission.SubsA = {}
		table.insert(Mission.SubsA, "Growler")
		table.insert(Mission.SubsA, "Gato")
	
	Mission.SubsB = {}
		table.insert(Mission.SubsB, "Albacore")
		table.insert(Mission.SubsB, "Blackfish")
	
	Mission.PHBBNames = {
	
		[1] = {"USS West Virginia", "USS Utah", "USS Maryland", "USS Oklahoma"},
		
		[2] = {"USS Arizona", "USS Nevada"},
		
		[3] = {"USS California", "USS Tennessee"},
		
	}
	
	Mission.USShips = {}
	Mission.Subs = {}
	Mission.Destroyers = {}
	
	---- VAR ----
	
	Mission.HarborEntrance = FindEntity("HarborEntrance")
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Waves = 0
	Mission.Wave2Coutner = 300
	
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
	
	MissionNarrative("December 20th, 1943 - Near Pearl Harbor")
	
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
	
	--luaDelay(luaTest, 30)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("CVPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--SetInvincible(FindEntity("Yamato"), 0.4)
	
	--[[Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and ((string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA")) or (string.find(unit.Name, "Fortress") or string.find(unit.Name, "Bunker"))) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		Kill(unit, true)
		
	end]]
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapUnits) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end]]
	
	--Mission.TEST = 0
	
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
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.USShips))
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
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapTransports)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapCVs)) <= 1 then
				
					luaObj_Failed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.Yamato.Dead then
				
					luaObj_Failed("hidden", 1)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				local capped = 0
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						
					end
				
				end
				
				if capped == 4 then
					
					if not Mission.WhyYouDoThisToMeee then
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
						
							SetInvincible(unit, 0.01)
						
						end
						
						luaDelay(luaHidePh1Score, 1)
						HideUnitHP()
						
						luaObj_Completed("primary", 1)
						luaObj_Completed("primary", 2)
						
						luaStartDialog("FINAL")
						
						Mission.EndMission = true
						Mission.WhyYouDoThisToMeee = true
						
					end
					
				else
				
					Mission.BasesLeft = 4 - capped
				
					local line1 = "Capture all enemy bases!"
					local line2 = "Enemy base(s) left to capture: #Mission.BasesLeft#"
					luaDisplayScore(1, line1, line2)
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
				
					if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
						
						local fighters = {
							[1] = 392,
						}
						local bombers
						
						if unit.Name == "Airfield1" or unit.Name == "AirField2" or unit.Name == "AirField3" then
						
							bombers = {
								[1] = 117,
							}
						
						else
						
							bombers = {
								[1] = 331,
								[2] = 38,
							}
						
						end
						
						--[[local wngCount
						
						if Mission.Difficulty == 0 then
							
							wngCount = 3
							--heavyBomber = false
						
						elseif Mission.Difficulty == 1 then
							
							wngCount = 4
							--heavyBomber = true
						
						elseif Mission.Difficulty == 2 then
							
							wngCount = 5
							--heavyBomber = true
						
						end]]
						
						local trgs = Mission.JapUnits
						
						if Mission.Difficulty == 2 then
						
							trgs = Mission.JapTransports
						
						else
						
							if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
							
								trgs = Mission.JapCapitalShips
							
							end
						
						end
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs), nil, 3)
						
					end
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
				
					if unit and not unit.Dead then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
							local trgs = Mission.JapShips
				
							if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
							
								trgs = Mission.JapCapitalShips
							
							end
							
							local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
							local closest = ordered[1]
							
							luaSetScriptTarget(unit, closest)
							NavigatorAttackMove(unit, closest)
						
						end
						
					end
				
				end
				
			end
			
			if Mission.Waves < 3 then
				
				local canSpawn = false
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
					
					canSpawn = true
				
				end
				
				if Mission.Waves == 2 then
					
					if Mission.Wave2Coutner == 0 then
					
						canSpawn = true
					
					else
					
						Mission.Wave2Coutner = Mission.Wave2Coutner - 1
					
					end
					
					--[[if table.getn(luaRemoveDeadsFromTable(Mission.JapUnits)) > 0 then
						
						local ordered = luaSortByDistance(Mission.HarborEntrance, luaRemoveDeadsFromTable(Mission.JapUnits))
						local closest = ordered[1]
						
						if luaGetDistance(Mission.HarborEntrance, closest) < 3000 then
						
							canSpawn = true
						
						end
					
					end]]
					
				end
				
				if canSpawn then
				
					luaSpawnNextWave(Mission.Waves + 1)
				
				end
				
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- WAVE SPAWNER ----

function luaSpawnNextWave(waveIdx)
	
	if waveIdx <= 3 then
	
		local fleets
		local listenerTbl = {}
		local ddsAttacked = false
		
		if waveIdx == 1 then
		
			fleets = {Mission.FirstWaveA, Mission.FirstWaveB, Mission.SubsA}
			
		elseif waveIdx == 2 then
		
			fleets = {Mission.SecondWaveA, Mission.SecondWaveB, Mission.SecondWaveC, Mission.SecondWaveD}
			
		elseif waveIdx == 3 then
		
			fleets = {Mission.ThirdWave, Mission.SubsB}
			
		end
		
		for idx1,fleet in pairs(fleets) do
			
			local shipGrp = {}
			local canAttack = true
			local carrierHere = false
			local trgs = Mission.JapTransports
			--local destroyers = {}
			local addToTable = false
			
			for idx2,unitName in pairs(fleet) do
			
				table.insert(shipGrp, GenerateObject(unitName))
			
			end
			
			for idx3,unit in pairs(shipGrp) do
			
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
				
				if unit.Class.Type == "Submarine" then
					
					if Mission.Difficulty > 0 then
					
						SetUnlimitedAirSupply(unit, true)
					
					end
					
					TorpedoEnable(unit, true)
					table.insert(Mission.Subs, unit)
					canAttack = false
					
				elseif unit.Class.Type == "MotherShip" then
					
					if Mission.Difficulty == 0 then
					
						SetAirBaseSlotCount(unit, 2)
						
					elseif Mission.Difficulty == 1 then
						
						SetAirBaseSlotCount(unit, 2)
						
					elseif Mission.Difficulty == 2 then
						
						SetAirBaseSlotCount(unit, 2)
						
					end
					
					table.insert(Mission.Airfields, unit)
					table.insert(listenerTbl, unit)
					canAttack = false
					carrierHere = true
					
				else
					
					if unit.Class.Type == "Destroyer" then
					
						table.insert(Mission.Destroyers, unit)
					
					end
					
					UnitSetFireStance(unit, 2)
					
					if waveIdx == 1 or waveIdx == 3 then
					
						table.insert(listenerTbl, unit)
					
					end
					
					if waveIdx == 3 then
					
						if unit.Name == "Colorado-class01" then
						
							SetGuiName(unit, luaPickRnd(Mission.PHBBNames[1]))
						
						elseif unit.Name == "Pennsylvania-class01" then
						
							SetGuiName(unit, luaPickRnd(Mission.PHBBNames[2]))
						
						elseif unit.Name == "Pennsylvania-class02" then
						
							SetGuiName(unit, luaPickRnd(Mission.PHBBNames[3]))
						
						end
					
					end
					
				end
				
			end
			
			if waveIdx == 1 or waveIdx == 2 then
				
				if idx1 == 1 then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.JapTransportsLeft)) > 0 then
					
						trgs = Mission.JapTransportsLeft
					
					end
					
					addToTable = true
					
				elseif idx1 == 2 then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.JapTransportsRight)) > 0 then
					
						trgs = Mission.JapTransportsRight
					
					end
					
					addToTable = true
					
				end
			
			else
			
				if idx1 == 1 then
				
					addToTable = true
				
				end
			
			end
			
			if canAttack then
			
				NavigatorAttackMove(shipGrp[1], luaPickRnd(luaRemoveDeadsFromTable(trgs)))
				
				if not ddsAttacked then
					
					local timer = 120
					
					if waveIdx > 1 then
					
						timer = 200
					
					end
					
					--Mission.CurrentDestroyers = destroyers
					
					luaDelay(luaMakeDestroyersAttack, timer)
					
					ddsAttacked = true
					
				end
				
				--[[if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
			
					local af = luaPickRnd(luaRemoveDeadsFromTable(Mission.Airfields))
					
					if af and not af.Dead and af.Party == PARTY_ALLIED then

						if IsReadyToSendPlanes(af) then
							
							local planeTypes = {
							392,
							392,
							}
							local slotIndex = LaunchSquadron(af,luaPickRnd(planeTypes),3)
							
							ayeyo = thisTable[tostring(GetProperty(af, "slots")[slotIndex].squadron)]
							SetSkillLevel(ayeyo, Mission.SkillLevel)
							
							PilotMoveToRange(ayeyo, shipGrp[1])
							
						end
						
					end
				
				end]]
				
				--[[if Mission.Difficulty > 0 then
				
					if waveIdx == 1 then
						
						local planeName
						
						if idx1 == 1 then
						
							planeName = "Mustang_1"
						
						else
						
							planeName = "Mustang_2"
						
						end
						
						local plane = GenerateObject(planeName)
						
						SetSkillLevel(plane, Mission.SkillLevel)
						
						PilotMoveToRange(plane, shipGrp[1])
						
					end
				
				end]]
				
			elseif carrierHere then
			
				NavigatorMoveOnPath(shipGrp[1], FindEntity("CVPath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			
			end
			
			if addToTable then
			
				for idx3,unit in pairs(shipGrp) do
				
					table.insert(Mission.USShips, unit)
				
				end
				
			end
			
		end
		
		if waveIdx == 1 then
		
			luaAddBlockadeListener(listenerTbl)
			luaAddSubListener()
		
		elseif waveIdx == 2 then
		
			luaAddCVListener(listenerTbl)
			
		elseif waveIdx == 3 then
		
			luaAddPHListener(listenerTbl)
		
		end
		
	end
	
	Mission.Waves = Mission.Waves + 1
	
end

function luaMakeDestroyersAttack()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Destroyers)) > 0 then
	
		if Mission.Difficulty > 0 then
	
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Destroyers)) do
			
				if unit and not unit.Dead then
				
					local trgs = Mission.JapShips
					
					if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
					
						trgs = Mission.JapCapitalShips
					
					end
					
					local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
					local closest = ordered[1]
					
					NavigatorAttackMove(unit, closest)
					
				end
			
			end
			
		end
		
		--if not Mission.AyeYo then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.JapSubs)) > 0 then
				
				local pickedSub = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapSubs))
				
				local ordered = luaSortByDistance(pickedSub, luaRemoveDeadsFromTable(Mission.Destroyers))
				local closest = ordered[1]
				
				NavigatorAttackMove(closest, pickedSub)
			
			end
			
			--Mission.AyeYo = true
			
		--end
		
	end
	
end

---- PHASE 1 ----

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 4)
	
	local trg1 = FindEntity("Taiho")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=13,["y"]=6,["z"]=-11910},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-5,["y"]=6,["z"]=-11760},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-5,["y"]=6,["z"]=-11760},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=9,["y"]=9,["z"]=-11910},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=7,["y"]=14.5,["z"]=17},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=10,["y"]=14.5,["z"]=80},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=60,["y"]=14.5,["z"]=80},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=30,["y"]=10,["z"]=-12000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=4,["z"]=-13000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=4,["z"]=-13000},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=40,["y"]=20,["z"]=-12000},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.JapFleetA[1])
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 3)
	
	luaStartDialog("ATTACKS")
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.HQs)
	luaObj_Add("primary", 2, Mission.JapTransports)
	luaObj_Add("secondary", 1, Mission.JapCVs)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.JapTransports), "Protect your transports!")
	
	if Mission.Difficulty < 2 then
	
		luaStartDialog("I400")
	
	end
	
end

function luaBlockadeDia()

	luaStartDialog("BLOCKADE")

end

function luaPHDia()

	luaStartDialog("LAST")

end

function luaBlockadeMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapUnits)))
	
	end

end

function luaPHMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapUnits)))
	
	end

end

---- LISTENERS ----

function luaAddBlockadeListener(tbl)
	
	AddListener("recon", "BlockadeListener", {
		["callback"] = "luaBlockadeSighted",
		["entity"] = tbl,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddCVListener(tbl)

	AddListener("recon", "CVListener", {
		["callback"] = "luaCVSighted",
		["entity"] = tbl,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddPHListener(tbl)

	AddListener("recon", "PHListener", {
		["callback"] = "luaPHSighted",
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

---- LISTENER CALLBACKS ----

function luaBlockadeSighted()

	RemoveListener("recon", "BlockadeListener")
	
	luaDelay(luaBlockadeDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = FindEntity("Missouri")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 500, ["theta"] = 5, ["rho"] = 15, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 355, ["moveTime"] = 8},
		
	}, luaBlockadeMovieEnd, true)
	
end

function luaCVSighted()

	RemoveListener("recon", "CVListener")
	
	luaStartDialog("CVS")

end

function luaPHSighted()

	RemoveListener("recon", "PHListener")
	
	luaDelay(luaPHDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()

	local trg1 = FindEntity("Saratoga")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 500, ["theta"] = 5, ["rho"] = -15, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = -355, ["moveTime"] = 8},
		
	}, luaPHMovieEnd, true)

end

function luaSubSighted()

	RemoveListener("recon", "SubListener")
	
	luaStartDialog("SS")

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	--[[if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end]]
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "Hawaii has been conquered - Mission Complete")
	
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
	
	--[[if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end]]
	
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