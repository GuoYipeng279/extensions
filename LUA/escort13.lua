--SceneFile="Missions\Multi\Scene13.scn"

function luaPrecacheUnits()
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort13")
end

function luaInitEscort13(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Escort13"..dateandtime -- a vegen atallitom 06-ra a commandhelpers miatt

	DamageLog = false
	Mission.HelperLog = false
	Mission.CustomLog = true

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating Escort13... the logs name is fake!")

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	this.ThinkCounter = 0

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- tablak
	Mission.US = {}
	Mission.Jap = {}

	-- kulcs egysegek es kiseriok
	Mission.Keyunits = {}
	Mission.Akagi = FindEntity("Escort - Akagi")
	Mission.AkagiPath = FindEntity("Escort - Akagi Path")
	Mission.AkagiPath2= FindEntity("Escort - Akagi Path 2")
	Mission.Lexington = FindEntity("Escort - Lexington")
	Mission.LexingtonPath = FindEntity("Escort - Lexington Path")
	Mission.LexingtonPath2 = FindEntity("Escort - Lexington Path 2")
	Mission.US.EscortShips = {}
		table.insert(Mission.US.EscortShips, FindEntity("Escort - Clemson 01"))
	Mission.Jap.EscortShips = {}
		table.insert(Mission.Jap.EscortShips, FindEntity("Escort - Minekaze 01"))

	-- amerikai egysegek
	Mission.US.HQs = {}
		table.insert(Mission.US.HQs, FindEntity("Escort - US CC 01"))
		table.insert(Mission.US.HQs, FindEntity("Escort - US CC 02"))
		table.insert(Mission.US.HQs, FindEntity("Escort - US CC 03"))
	Mission.US.CCLandforts = {}
	Mission.US.CCLandforts[1] = {}
	Mission.US.CCLandforts[2] = {}
	Mission.US.CCLandforts[3] = {}
		--1
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 1"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 2"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 3"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 1"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 2"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 3"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 F 1"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 F 2"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 4"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 5"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 HAA 6"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 4"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 5"))
		table.insert(Mission.US.CCLandforts[1], FindEntity("Escort - US CC 1 CG 6"))
		--2
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 1"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 2"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 3"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 1"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 2"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 3"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 F 1"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 4"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 5"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 HAA 6"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 4"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 5"))
		table.insert(Mission.US.CCLandforts[2], FindEntity("Escort - US CC 2 CG 6"))
		--3
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 1"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 2"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 3"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 1"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 2"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 3"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 F 1"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 4"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 5"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 HAA 6"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 4"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 5"))
		table.insert(Mission.US.CCLandforts[3], FindEntity("Escort - US CC 3 CG 6"))

	-- spawn pontok, pathok
	Mission.Jap.HQs = {}
		table.insert(Mission.Jap.HQs, FindEntity("Escort - Jap CC 01"))
		table.insert(Mission.Jap.HQs, FindEntity("Escort - Jap CC 02"))
		table.insert(Mission.Jap.HQs, FindEntity("Escort - Jap CC 03"))
	Mission.Jap.CCLandforts = {}
	Mission.Jap.CCLandforts[1] = {}
	Mission.Jap.CCLandforts[2] = {}
	Mission.Jap.CCLandforts[3] = {}
		--1
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 1"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 2"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 3"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 1"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 2"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 3"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 F 1"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 F 2"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 4"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 5"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 HAA 6"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 4"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 5"))
		table.insert(Mission.Jap.CCLandforts[1], FindEntity("Escort - Jap CC 1 CG 6"))
		--2
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 1"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 2"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 3"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 1"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 2"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 3"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 F 1"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 4"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 5"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 HAA 6"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 4"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 5"))
		table.insert(Mission.Jap.CCLandforts[2], FindEntity("Escort - Jap CC 2 CG 6"))
		--3
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 1"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 2"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 3"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 1"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 2"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 3"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 4"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 5"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 HAA 6"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 4"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 5"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 CG 6"))
		table.insert(Mission.Jap.CCLandforts[3], FindEntity("Escort - Jap CC 3 F 1"))

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "mp13.obj_es_us_pri_1",
				["TextCompleted"] = "mp.obj_ic_uswon",
				["TextFailed"] = "mp.obj_ic_jpwon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "mp13.obj_es_jp_pri_1",
				["TextCompleted"] = "mp.obj_ic_jpwon",
				["TextFailed"] = "mp.obj_ic_uswon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[3] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj2",
				["Text"] = "mp11.obj_comp_p2_text",
				["TextCompleted"] = "mp11.obj_comp_p2_comp",
				["TextFailed"] = "mp11.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[4] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj2",
				["Text"] = "mp07.obj_comp_p2_text",
				["TextCompleted"] = "mp07.obj_comp_p2_comp",
				["TextFailed"] = "mp07.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
		},
		["secondary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec_1",
				["Text"] = "mp13.obj_es_sec_1_text", -- destroy at least 2
				["TextCompleted"] = "mp13.obj_es_sec_1_comp",
				["TextFailed"] = "mp13.obj_es_sec_1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_sec_1",
				["Text"] = "mp13.obj_es_sec_1_text", -- destroy at least 2
				["TextCompleted"] = "mp13.obj_es_sec_1_comp",
				["TextFailed"] = "mp13.obj_es_sec_1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[3] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec_2",
				["Text"] = "mp13.obj_es_sec_2_text", -- defend at least 2
				["TextCompleted"] = "mp13.obj_es_sec_2_comp",
				["TextFailed"] = "mp13.obj_es_sec_2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[4] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_sec_2",
				["Text"] = "mp13.obj_es_sec_2_text", -- defend at least 2
				["TextCompleted"] = "mp13.obj_es_sec_2_comp",
				["TextFailed"] = "mp13.obj_es_sec_2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
		},
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	Mission.MissionEnd = false	
		
	--idojaras
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben

	luaInitNewSystems()

    SetThink(this, "luaEscort13_think")

	MultiScore =	{
		[0]= {
			[1] = 100,
			[2] = 100,
		},
		[1]= {
			[1] = 100,
			[2] = 100,
		},
		[2]= {
			[1] = 100,
			[2] = 100,
		},
		[3]= {
			[1] = 100,
			[2] = 100,
		},
		[4]= {
			[1] = 100,
			[2] = 100,
		},
		[5]= {
			[1] = 100,
			[2] = 100,
		},
		[6]= {
			[1] = 100,
			[2] = 100,
		},
		[7]= {
			[1] = 100,
			[2] = 100,
		},
	}

	DisplayScores(1, 0,"mp13.score_lexi_hp".."| |#MultiScore.0.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.0.2#| |%", 2, 1)
	DisplayScores(1, 1,"mp13.score_lexi_hp".."| |#MultiScore.1.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.1.2#| |%", 2, 1)
	DisplayScores(1, 2,"mp13.score_lexi_hp".."| |#MultiScore.2.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.2.2#| |%", 2, 1)
	DisplayScores(1, 3,"mp13.score_lexi_hp".."| |#MultiScore.3.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.3.2#| |%", 2, 1)
	DisplayScores(1, 4,"mp13.score_lexi_hp".."| |#MultiScore.4.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.4.2#| |%", 2, 1)
	DisplayScores(1, 5,"mp13.score_lexi_hp".."| |#MultiScore.5.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.5.2#| |%", 2, 1)
	DisplayScores(1, 6,"mp13.score_lexi_hp".."| |#MultiScore.6.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.6.2#| |%", 2, 1)
	DisplayScores(1, 7,"mp13.score_lexi_hp".."| |#MultiScore.7.1#| |%", "mp13.score_akagi_hp".."| |#MultiScore.7.2#| |%", 2, 1)

	Scoring_RealPlayTimeRunning(true)
end

function luaEscort13_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Started and not Mission.MissionEnd then
		luaQAE13CheckHQs()
		luaQAE13CheckKeyUnits()

	elseif not Mission.Started then
		luaQAE13StartMission()
		luaQAE13CheckLandforts()
	end
end

function luaQAE13StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	luaShowMissionHint()

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, {Mission.Akagi})
	luaObj_AddUnit("primary", 2, {Mission.Lexington})
	luaObj_Add("primary", 3)
	luaObj_Add("primary", 4)
	luaObj_AddUnit("primary", 3, {Mission.Lexington})
	luaObj_AddUnit("primary", 4, {Mission.Akagi})
	luaObj_Add("secondary", 1)
	luaObj_Add("secondary", 2)
	luaObj_Add("secondary", 3)
	luaObj_Add("secondary", 4)
	for i = 1, 3 do
		luaObj_AddUnit("secondary", 1, Mission.Jap.HQs[i])
		luaObj_AddUnit("secondary", 2, Mission.US.HQs[i])
		luaObj_AddUnit("secondary", 3, Mission.US.HQs[i])
		luaObj_AddUnit("secondary", 4, Mission.Jap.HQs[i])
		Mission.Jap.HQs[i].markedUS = true
		Mission.US.HQs[i].markedUS = true
		Mission.Jap.HQs[i].markedJP = true
		Mission.US.HQs[i].markedJP = true
	end

	JoinFormation(Mission.US.EscortShips[1], Mission.Lexington)
	JoinFormation(Mission.Jap.EscortShips[1], Mission.Akagi)

	NavigatorMoveOnPath(Mission.Lexington, Mission.LexingtonPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.LexingtonPath)
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Lexington, "LexiTrg", "luaQAE13ShipsInPos", pathpoints[pathpointsnumber], 700)
	NavigatorMoveOnPath(Mission.Akagi, Mission.AkagiPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.AkagiPath)
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Akagi, "AkagiTrg", "luaQAE13ShipsInPos", pathpoints[pathpointsnumber], 700)

	SetShipMaxSpeed(Mission.Lexington, GetShipMaxSpeed(Mission.Lexington)*0.9)
	SetShipMaxSpeed(Mission.Akagi, GetShipMaxSpeed(Mission.Akagi)*0.88)

	NavigatorSetTorpedoEvasion(Mission.US.EscortShips[1], false)
	NavigatorSetTorpedoEvasion(Mission.Jap.EscortShips[1], false)

	if Mission.Players < 3 then
		SetSkillLevel(Mission.Lexington, SKILL_SPVETERAN)
		SetSkillLevel(Mission.Akagi, SKILL_SPVETERAN)
		for index, unit in pairs (Mission.US.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for index, unit in pairs (Mission.Jap.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for idx, value in pairs (Mission.US.CCLandforts) do
			for index, unit in pairs (value) do
				SetSkillLevel(unit, SKILL_STUN)
			end
		end
		for idx, value in pairs (Mission.Jap.CCLandforts) do
			for index, unit in pairs (value) do
				SetSkillLevel(unit, SKILL_STUN)
			end
		end
	elseif Mission.Players < 5 then
		SetSkillLevel(Mission.Lexington, SKILL_MPNORMAL)
		SetSkillLevel(Mission.Akagi, SKILL_MPNORMAL)
		for index, unit in pairs (Mission.US.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for index, unit in pairs (Mission.Jap.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for idx, value in pairs (Mission.US.CCLandforts) do
			for index, unit in pairs (value) do
				if idx == 3 then
					SetSkillLevel(unit, SKILL_STUN)
				else
					SetSkillLevel(unit, SKILL_SPNORMAL)
				end
			end
		end
		for idx, value in pairs (Mission.Jap.CCLandforts) do
			for index, unit in pairs (value) do
				SetSkillLevel(unit, SKILL_SPNORMAL)
			end
		end
	else
		SetSkillLevel(Mission.Lexington, SKILL_MPVETERAN)
		SetSkillLevel(Mission.Akagi, SKILL_MPVETERAN)
		for index, unit in pairs (Mission.US.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for index, unit in pairs (Mission.Jap.HQs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
		for idx, value in pairs (Mission.US.CCLandforts) do
			for index, unit in pairs (value) do
				if idx == 3 then
					SetSkillLevel(unit, SKILL_STUN)
				else
					SetSkillLevel(unit, SKILL_SPNORMAL)
				end
			end
		end
		for idx, value in pairs (Mission.Jap.CCLandforts) do
			for index, unit in pairs (value) do
				SetSkillLevel(unit, SKILL_SPNORMAL)
			end
		end
	end

	AISetHintWeight(Mission.US.HQs[3], 180)
	AISetHintWeight(Mission.US.HQs[2], 150)
	AISetHintWeight(Mission.US.HQs[1], 120)
	AISetHintWeight(Mission.Jap.HQs[3], 180)
	AISetHintWeight(Mission.Jap.HQs[2], 150)
	AISetHintWeight(Mission.Jap.HQs[1], 120)
	AISetHintWeight(Mission.Akagi, 0)
	AISetHintWeight(Mission.Lexington, 0)
	AISetTargetWeight(101, 159, false, 62) -- Wildcat vs Judy
	AISetTargetWeight(101, 163, false, 62) -- Wildcat vs Jill
	AISetTargetWeight(101, 150, false, 10) -- Wildcat vs Zero
	AISetTargetWeight(150, 38, false, 62) -- Zero vs Hellcat
	AISetTargetWeight(150, 113, false, 62) -- Zero vs Avenger
	AISetTargetWeight(150, 101, false, 10) -- Zero vs Wildcat

	Mission.Started = true
end

function luaQAE13CheckKeyUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking key units...")
	local PlayersInGame = GetPlayerDetails()
	if Mission.Lexington.Dead then
-- RELEASE_LOGOFF  		luaLog("  the Lexington is sinking")
		for index, value in pairs (PlayersInGame) do
			MultiScore[index][1] = 0
		end
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 4)
		luaObj_Failed("primary", 3)
		luaQAE13FinalObjCheck()
		Mission.Name = "Escort06" -- mivel ugyanazok a key unitok, mint a 6-oson
		Mission.MissionEnd = true
		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.Lexington, "", nil, nil, nil, PARTY_JAPANESE)
	else
		local unitHP = GetHpPercentage(Mission.Lexington) * 100
		unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  		luaLog("  the Lexington on "..tostring(unitHP).."% HP")
		for index, value in pairs (PlayersInGame) do
			MultiScore[index][1] = unitHP
		end
	end
	if Mission.Akagi.Dead then
-- RELEASE_LOGOFF  		luaLog("  the Akagi is sinking")
		for index, value in pairs (PlayersInGame) do
			MultiScore[index][2] = 0
		end
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaQAE13FinalObjCheck()
		Mission.Name = "Escort06" -- mivel ugyanazok a key unitok, mint a 6-oson
		Mission.MissionEnd = true
		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.Akagi, "", nil, nil, nil, PARTY_ALLIED)
	else
		local unitHP = GetHpPercentage(Mission.Akagi) * 100
		unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  		luaLog("  the Akagi on "..tostring(unitHP).."% HP")
		for index, value in pairs (PlayersInGame) do
				MultiScore[index][2] = unitHP
		end
	end
end

function luaQAE13CheckHQs()
-- RELEASE_LOGOFF  	luaLog(" Checking HQs...")
	if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
		local japHQs = 0
		for index, unit in pairs (Mission.Jap.HQs) do
			if unit.Party == PARTY_JAPANESE then
				japHQs = japHQs + 1
			elseif unit.markedUS then
				luaObj_RemoveUnit("secondary", 1, unit)
				unit.markedUS = false
			end
		end
		if japHQs < 2 then
-- RELEASE_LOGOFF  			luaLog("  Japanese HQs are down")
			luaObj_Completed("secondary", 1)
		end
	end
	if luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
		local USHQs = 0
		for index, unit in pairs (Mission.US.HQs) do
			if unit.Party == PARTY_ALLIED then
				USHQs = USHQs + 1
			elseif unit.markedJP then
				luaObj_RemoveUnit("secondary", 2, unit)
				unit.markedJP = false
			end
		end
		if USHQs < 2 then
-- RELEASE_LOGOFF  			luaLog("  US HQs are down")
			luaObj_Completed("secondary", 2)
		end
	end
	if luaObj_IsActive("secondary", 4) and luaObj_GetSuccess("secondary", 4) == nil then
		local japHQs = 0
		for index, unit in pairs (Mission.Jap.HQs) do
			if unit.Party == PARTY_JAPANESE then
				japHQs = japHQs + 1
			elseif unit.markedJP then
				luaObj_RemoveUnit("secondary", 4, unit)
				unit.markedJP = false
			end
		end
		if japHQs < 1 then
-- RELEASE_LOGOFF  			luaLog("  Japanese HQs are down")
			luaObj_Failed("secondary", 4)
		end
	end
	if luaObj_IsActive("secondary", 3) and luaObj_GetSuccess("secondary", 3) == nil then
		local USHQs = 0
		for index, unit in pairs (Mission.US.HQs) do
			if unit.Party == PARTY_ALLIED then
				USHQs = USHQs + 1
			elseif unit.markedUS then
				luaObj_RemoveUnit("secondary", 3, unit)
				unit.markedUS = false
			end
		end
		if USHQs < 1 then
-- RELEASE_LOGOFF  			luaLog("  US HQs are down")
			luaObj_Failed("secondary", 3)
		end
	end

	if Mission.US.HQs[1].Party ~= PARTY_ALLIED and not Mission.US.HQ1Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.US.HQ1Down")
		AISetHintWeight(Mission.Lexington, 150)
		Mission.US.HQ1Down = true
	end
	if Mission.US.HQs[2].Party ~= PARTY_ALLIED and not Mission.US.HQ2Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.US.HQ2Down")
		AISetHintWeight(Mission.Jap.HQs[1], 500)
		Mission.US.HQ2Down = true
	end
	if Mission.US.HQs[3].Party ~= PARTY_ALLIED and not Mission.US.HQ3Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.US.HQ3Down")
		AISetHintWeight(Mission.Jap.HQs[2], 210)
		AISetHintWeight(Mission.Jap.HQs[1], 180)
		Mission.US.HQ3Down = true
	end
	if Mission.Jap.HQs[1].Party ~= PARTY_JAPANESE and not Mission.Jap.HQ1Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.Jap.HQ1Down")
		AISetHintWeight(Mission.Akagi, 150)
		Mission.Jap.HQ1Down = true
	end
	if Mission.Jap.HQs[2].Party ~= PARTY_JAPANESE and not Mission.Jap.HQ2Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.Jap.HQ2Down")
		AISetHintWeight(Mission.US.HQs[1], 500)
		Mission.Jap.HQ2Down = true
	end
	if Mission.Jap.HQs[3].Party ~= PARTY_JAPANESE and not Mission.Jap.HQ3Down then
-- RELEASE_LOGOFF  		luaLog("  Mission.Jap.HQ3Down")
		AISetHintWeight(Mission.US.HQs[2], 210)
		AISetHintWeight(Mission.US.HQs[1], 180)
		Mission.Jap.HQ3Down = true
	end
end

function luaQAE13ShipsInPos()
-- RELEASE_LOGOFF  	luaLog(" a CV reached the end of the path")
	if not Mission.Akagi.Dead then
		NavigatorMoveOnPath(Mission.Akagi, Mission.AkagiPath2, PATH_FM_CIRCLE, PATH_SM_JOIN)
	end
	Mission.US.EscortShips = luaRemoveDeadsFromTable(Mission.US.EscortShips)
	if table.getn(Mission.US.EscortShips) ~= 0 then
		for index, unit in pairs (Mission.US.EscortShips) do
-- RELEASE_LOGOFF  			luaLog(" ordering "..tostring(unit.Name).." to attack the Akagi")
			NavigatorAttackMove(unit, Mission.Akagi, {})
		end
	end
	if not Mission.Lexington.Dead then
		NavigatorMoveOnPath(Mission.Lexington, Mission.LexingtonPath2, PATH_FM_CIRCLE, PATH_SM_JOIN)
	end
	Mission.Jap.EscortShips = luaRemoveDeadsFromTable(Mission.Jap.EscortShips)
	if table.getn(Mission.Jap.EscortShips) ~= 0 then
		for index, unit in pairs (Mission.Jap.EscortShips) do
-- RELEASE_LOGOFF  			luaLog(" ordering "..tostring(unit.Name).." to attack the Lexington")
			NavigatorAttackMove(unit, Mission.Lexington, {})
		end
	end
end

function luaQAE13CheckLandforts()
	if not Mission.MissionEnd then
		for index, unit in pairs (Mission.US.HQs) do
			if unit.Party ~= PARTY_ALLIED and not unit.landfortsOff then
-- RELEASE_LOGOFF  				luaLog(" Neutralizing landforts of US CB "..tostring(index))
				Mission.US.CCLandforts[index] = luaRemoveDeadsFromTable(Mission.US.CCLandforts[index])
				for index2, unit2 in pairs (Mission.US.CCLandforts[index]) do
					SetParty(unit2, PARTY_NEUTRAL)
				end
				unit.landfortsOff = true
			end
		end
		for index, unit in pairs (Mission.Jap.HQs) do
			if unit.Party ~= PARTY_JAPANESE and not unit.landfortsOff then
-- RELEASE_LOGOFF  				luaLog(" Neutralizing landforts of Jap CB "..tostring(index))
				Mission.Jap.CCLandforts[index] = luaRemoveDeadsFromTable(Mission.Jap.CCLandforts[index])
				for index2, unit2 in pairs (Mission.Jap.CCLandforts[index]) do
					SetParty(unit2, PARTY_NEUTRAL)
				end
				unit.landfortsOff = true
			end
		end
		luaDelay(luaQAE13CheckLandforts, 0.8)
	end
end

function luaQAE13FinalObjCheck()
-- RELEASE_LOGOFF  	luaLog(" Checking final HQ objectives...")
	if luaObj_IsActive("secondary", 4) and luaObj_GetSuccess("secondary", 4) == nil then
		local japHQs = 0
		for index, unit in pairs (Mission.Jap.HQs) do
			if unit.Party == PARTY_JAPANESE then
				japHQs = japHQs + 1
			elseif unit.markedJP then
				luaObj_RemoveUnit("secondary", 4, unit)
				unit.markedJP = false
			end
		end
		if japHQs < 1 then
-- RELEASE_LOGOFF  			luaLog("  Obj failed: secondary, 4")
			luaObj_Failed("secondary", 4)
		else
-- RELEASE_LOGOFF  			luaLog("  Obj completed: secondary, 4")
			luaObj_Completed("secondary", 4)
		end
	end
	if luaObj_IsActive("secondary", 3) and luaObj_GetSuccess("secondary", 3) == nil then
		local USHQs = 0
		for index, unit in pairs (Mission.US.HQs) do
			if unit.Party == PARTY_ALLIED then
				USHQs = USHQs + 1
			elseif unit.markedUS then
				luaObj_RemoveUnit("secondary", 3, unit)
				unit.markedUS = false
			end
		end
		if USHQs < 1 then
-- RELEASE_LOGOFF  			luaLog("  Obj failed: secondary, 3")
			luaObj_Failed("secondary", 3)
		else
-- RELEASE_LOGOFF  			luaLog("  Obj completed: secondary, 3")
			luaObj_Completed("secondary", 3)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort13")
end
