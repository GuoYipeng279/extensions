--SceneFile="universe\Scenes\missions\IJN\ijn_03_battle_of_the_java_sea.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	EnableMessages(false)
	LoadMessageMap("ijndlg",3)

	Music_Control_SetLevel(MUSIC_TENSION)

	Dialogues =
	{
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
--				{
--					["type"] = "pause",
--					["time"] = 7,
--				},
				{
					["message"] = "idlg02",
				},
				{
					["message"] = "idlg02_1",
				},
			},
		},
	}

	MissionNarrative("ijn03.date_location")
	luaDelay(luaEngineInit1, 10, "")
end

function luaEngineInit1()
	StartDialog("Intro_dlg", Dialogues["Intro"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM3")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM3(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM03.lua"

	this.Name = "JM3"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	--maptiltas
	--ForceEnableInput(IC_MAP_TOGGLE, false)

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	--enginemovies
	--luaInitJumpinMovies()

	--this.ObjRemindTime = 150

	this.MissionPhase = 0

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_SPVETERAN
	end

	Mission.Debug = true
	Mission.UnlockLvl = 3

	Mission.UnlockPlanes = {}
	Mission.EnemyShips = {}

	--grpoups

	Mission.PlayerUnits = {}
		table.insert(Mission.PlayerUnits, FindEntity("Mogami-class 01"))
		table.insert(Mission.PlayerUnits, FindEntity("Fubuki-class 01"))
		table.insert(Mission.PlayerUnits, FindEntity("Fubuki-class 02"))
		local leader = luaJM3MakeFormation(Mission.PlayerUnits)
		Mission.PlayerUnit = leader

		if IsClassChanged(leader.Class.ID) then
			if leader.Class.ID == 68 then
				SetGuiName(leader, "ingame.shipnames_tone")
			elseif leader.Class.ID == 391 then
				SetGuiName(leader, "ingame.shipnames_abukuma")
			elseif leader.Class.ID == 1311 then
				SetGuiName(leader, "Prinz Eugen")
			else
				SetGuiName(leader, leader.Class.Name)
			end
		else
			SetGuiName(leader, "ingame.shipnames_haguro")
		end


		SetSelectedUnit(leader)
		SetRoleAvailable(Mission.PlayerUnits[2], EROLF_ALL, PLAYER_AI)
		SetRoleAvailable(Mission.PlayerUnits[3], EROLF_ALL, PLAYER_AI)

	Mission.JapTransports = {}
		table.insert(Mission.JapTransports, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.JapTransports, FindEntity("Japan Troop Transport 02"))
		table.insert(Mission.JapTransports, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.JapTransports, FindEntity("Japan Troop Transport 04"))
		--table.insert(Mission.JapTransports, FindEntity("Japan Troop Transport 05"))
		luaJM3MakeFormation(Mission.JapTransports,1,true)
		luaDelay(luaJM3TransportsMove,1)

	Mission.JapSupports = {}
		table.insert(Mission.JapSupports, FindEntity("Fubuki-class 11"))
		table.insert(Mission.JapSupports, FindEntity("Fubuki-class 12"))
		table.insert(Mission.JapSupports, FindEntity("Fubuki-class 13"))
		table.insert(Mission.JapSupports, FindEntity("Fubuki-class 14"))
		luaJM3MakeFormation(Mission.JapSupports,1,true)
		luaDelay(luaJM3SupportsMove,1)

	Mission.IJNStageGroup1 = {}
		table.insert(Mission.IJNStageGroup1, FindEntity("Kuma-class 01"))
		table.insert(Mission.IJNStageGroup1, FindEntity("Mogami-class 02"))
		table.insert(Mission.IJNStageGroup1, FindEntity("Fubuki-class 05"))
		table.insert(Mission.IJNStageGroup1, FindEntity("Fubuki-class 06"))
		SetGuiName(Mission.IJNStageGroup1[1], "ingame.shipnames_naka")

		if IsClassChanged(Mission.IJNStageGroup1[2].Class.ID) then
			if Mission.IJNStageGroup1[2].Class.ID == 68 then  -- Tone
				SetGuiName(Mission.IJNStageGroup1[2], "ingame.shipnames_chikuma")
			elseif Mission.IJNStageGroup1[2].Class.ID == 391 then -- Kuma torpedo
				SetGuiName(Mission.IJNStageGroup1[2], "ingame.shipnames_natori")
			elseif Mission.IJNStageGroup1[2].Class.ID == 1311 then -- Prinz Eugen
				SetGuiName(Mission.IJNStageGroup1[2], "Lutzow")
			else
				SetGuiName(Mission.IJNStageGroup1[2], Mission.IJNStageGroup1[2].Class.Name) -- anything else
			end
		else
			SetGuiName(Mission.IJNStageGroup1[2], "ingame.shipnames_nachi")
		end



		luaJM3MakeFormation(Mission.IJNStageGroup1,2,true)
		luaDelay(luaJM3Stage1Move,1)

	Mission.USNStageGroup1 = {}
		table.insert(Mission.USNStageGroup1, FindEntity("DeRuyter-class 01"))
		table.insert(Mission.USNStageGroup1, FindEntity("DeRuyter-class 02"))
		table.insert(Mission.USNStageGroup1, FindEntity("DeRuyter-class 03"))
		SetGuiName(Mission.USNStageGroup1[1], "ingame.shipnames_deruyter")
		SetGuiName(Mission.USNStageGroup1[2], "ingame.shipnames_java")
		SetGuiName(Mission.USNStageGroup1[3], "ingame.shipnames_perth")
		Mission.DeRuyter = Mission.USNStageGroup1[1]
		luaJM3MakeFormation(Mission.USNStageGroup1)
		luaDelay(luaJM3Stage2Move,1)

		for i,unit in pairs(Mission.USNStageGroup1) do
			SetSkillLevel(unit, Mission.SkillLevel)
			if math.mod(i,table.getn(Mission.USNStageGroup1)) >= Mission.Difficulty then
				TorpedoEnable(unit, false)
			else
				TorpedoEnable(unit, true)
			end
		end

	Mission.IJNStageGroup2 = {}
		table.insert(Mission.IJNStageGroup2, FindEntity("Fubuki-class 07"))
		table.insert(Mission.IJNStageGroup2, FindEntity("Fubuki-class 08"))
		table.insert(Mission.IJNStageGroup2, FindEntity("Fubuki-class 09"))
		table.insert(Mission.IJNStageGroup2, FindEntity("Fubuki-class 10"))


	SetInvincible(Mission.IJNStageGroup2[1], 0.2) --ezt leszedni movie vegen

	Mission.USNStageGroup2 = {}
		--table.insert(Mission.USNStageGroup2, FindEntity("Clemson-class 06"))
		table.insert(Mission.USNStageGroup2, FindEntity("Clemson-class 07"))
		table.insert(Mission.USNStageGroup2, FindEntity("Clemson-class 08"))
		table.insert(Mission.USNStageGroup2, FindEntity("Clemson-class 09"))
		table.insert(Mission.USNStageGroup2, FindEntity("Clemson-class 10"))
		luaJM3MakeFormation(Mission.USNStageGroup2)
		luaDelay(luaJM3Stage4Move,1)

		for i,unit in pairs(Mission.USNStageGroup2) do
			SetSkillLevel(unit, Mission.SkillLevel)
			if math.mod(i,table.getn(Mission.USNStageGroup1)) >= Mission.Difficulty then
				TorpedoEnable(unit, false)
			else
				TorpedoEnable(unit, true)
			end
		end


	Mission.ExeterDecoy = {}
		table.insert(Mission.ExeterDecoy, FindEntity("Kuma-class 02"))
		table.insert(Mission.ExeterDecoy, FindEntity("Fubuki-class 03"))
		table.insert(Mission.ExeterDecoy, FindEntity("Fubuki-class 04"))
		SetGuiName(Mission.ExeterDecoy[1], "ingame.shipnames_jintsu")
		luaJM3MakeFormation(Mission.ExeterDecoy,1,true)
		luaDelay(luaJM3Stage5Move,1)

	Mission.ExeterGroup = {}
		table.insert(Mission.ExeterGroup, FindEntity("Clemson-class 02"))
		table.insert(Mission.ExeterGroup, FindEntity("Northampton-class 01"))
		table.insert(Mission.ExeterGroup, FindEntity("York-class 01"))
		SetGuiName(Mission.ExeterGroup[2], "ingame.shipnames_houston") --30
		SetGuiName(Mission.ExeterGroup[3], "ingame.shipnames_exeter")
		luaJM3MakeFormation(Mission.ExeterGroup)
		Mission.Exeter = Mission.ExeterGroup[3]
		luaDelay(luaJM3Stage6Move,1)

		for i,unit in pairs(Mission.ExeterGroup) do
			SetSkillLevel(unit, Mission.SkillLevel)
			if math.mod(i,table.getn(Mission.ExeterGroup)) >= Mission.Difficulty then
				TorpedoEnable(unit, false)
			else
				TorpedoEnable(unit, true)
			end
		end


	Mission.USNSneakGroup = {}
		table.insert(Mission.USNSneakGroup, FindEntity("Clemson-class 01"))
		--NavigatorAttackMove(Mission.USNSneakGroup[1], GetFormationLeader(Mission.JapTransports[1]), {})
		NavigatorAttackMove(Mission.USNSneakGroup[1], Mission.JapTransports[1], {})

	Mission.USNDDGroup = {}
		table.insert(Mission.USNDDGroup, FindEntity("Clemson-class 03"))
		table.insert(Mission.USNDDGroup, FindEntity("Clemson-class 04"))
		table.insert(Mission.USNDDGroup, FindEntity("Clemson-class 05"))
		luaJM3MakeFormation(Mission.USNDDGroup)
		--TorpedoEnable(Mission.USNDDGroup[1], false)
		--TorpedoEnable(Mission.USNDDGroup[2], false)
		--TorpedoEnable(Mission.USNDDGroup[3], false)
		luaDelay(luaJM3Stage7Move,1)

		for i,unit in pairs(Mission.USNDDGroup) do
			SetSkillLevel(unit, Mission.SkillLevel)
			if math.mod(i,table.getn(Mission.USNDDGroup)) >= Mission.Difficulty then
				TorpedoEnable(unit, false)
			else
				TorpedoEnable(unit, true)
			end
		end

	Mission.JAPDDs = {}
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 01"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 02"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 03"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 04"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 05"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 06"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 07"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 08"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 09"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 10"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 11"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 12"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 13"))
		table.insert(Mission.JAPDDs, FindEntity("Fubuki-class 14"))

	Mission.USNDDs = {}
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 01"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 02"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 03"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 04"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 05"))
		--table.insert(Mission.USNDDs, FindEntity("Clemson-class 06"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 07"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 08"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 09"))
		table.insert(Mission.USNDDs, FindEntity("Clemson-class 10"))

	Mission.Names = {}
		Mission.Names.JAP = {}
			Mission.Names.JAP.Fubuki = {}
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_asagumo")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_yudachi")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_ushio")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_samidare")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_murasame")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_harusame")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_minegumo")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_yukikaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_amatsukaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_tokitsukaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_hatsukaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_yamakaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_kawakaze")
				table.insert(Mission.Names.JAP.Fubuki, "ingame.shipnames_sazanami")

			Mission.Names.JAP.Transports = {}
				table.insert(Mission.Names.JAP.Transports, "ingame.shipnames_horai")
				table.insert(Mission.Names.JAP.Transports, "ingame.shipnames_ryuho")
				table.insert(Mission.Names.JAP.Transports, "ingame.shipnames_sakura")
				--table.insert(Mission.Names.JAP.Transports, "ingame.shipnames_shinshu")
				--table.insert(Mission.Names.JAP.Transports, "ingame.shipnames_tatsuno")

		Mission.Names.USN = {}
			Mission.Names.USN.Clemson = {}
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_electra")
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_encounter")
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_jupiter")
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_kortenaer")
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_witte_de_with")
				--table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_alden") --211
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_john_d_edwards") --216
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_john_d_ford") --228
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_pope") --225
				table.insert(Mission.Names.USN.Clemson, "ingame.shipnames_paul_jones") --230

	Mission.Cleveland = FindEntity("Cleveland-class 01")
	SetGuiName(Mission.Cleveland, "ijn03.ufo") --21
	NavigatorEnable(Mission.Cleveland, false)
	ArtilleryEnable(Mission.Cleveland, false)
	AAEnable(Mission.Cleveland, false)
	AddDamage(Mission.Cleveland, (Mission.Cleveland.Class.HP)*0.6)
	AddUntouchableUnit(Mission.Cleveland)
	luaDelay(luaJm3EfxOnCleveland, 3)
	RepairEnable(Mission.Cleveland, false)

	Mission.StagePlanes = {}
	Mission.MaxStagePlanes = 10
	Mission.StagePlaneReq = "StagePlaneReq"
	Mission.StagePlaneSpawnPoints = {}
		--table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 01")))
		--table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 02")))
		table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 03")))
		table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 04")))
		table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 05")))
		--table.insert(Mission.StagePlaneSpawnPoints, GetPosition(FindEntity("Spawn 06")))
	Mission.StagePlaneRetreatPoints = {}
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 01")))
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 02")))
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 03")))
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 04")))
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 05")))
		table.insert(Mission.StagePlaneRetreatPoints, GetPosition(FindEntity("Retreat 06")))
	Mission.ActPoint = 1

	Mission.IJNUnits = luaSumTablesIndex(Mission.PlayerUnits, Mission.JAPDDs, Mission.JapTransports)
	Mission.USNUnits = luaSumTablesIndex(Mission.ExeterGroup, Mission.USNStageGroup1, Mission.USNStageGroup2, Mission.USNDDGroup, Mission.USNSneakGroup)

	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM3LoadBlackout},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM3SaveMissionData,},
	}

	--this.ObjRemindTime = 150

	--objectives
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "DDs",
				["Text"] = "ijn03.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Assist",
				["Text"] = "ijn03.obj_p2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[[[3] = {
				["ID"] = "Sink",
				["Text"] = "ijn03.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Retreat",
				["Text"] = "ijn03.obj_p4",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]--
			[5] = {
				["ID"] = "Repair",
				["Text"] = "ijn03.obj_p5",
				["TextCompleted"] = "ijn03.obj_p5_comp",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			--[1] = {
			--	["ID"] = "DDs2",
			--	["Text"] = "Destroy the other DDs",
			--	["Active"] = false,
			--	["Success"] = nil,
			--	["Target"] = {},
			--	["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
			--	["ScoreFailed"] = 0
			--},
			--[[[1] = {
				["ID"] = "CA",
				["Text"] = "ijn03.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]--
			[2] = {
				["ID"] = "Torp",
				["Text"] = "ijn03.obj_s2",
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
				["Text"] = "ijn03.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["marker2"] = {
				[1] = {
				["ID"] = "markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		}
	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--dialogues
	Mission.Dialogues = {
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
			},
		},
		["DDSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
				{
					["message"] = "dlg2c",
				},
			},
		},
		["DDsInTrouble"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
			},
		},
		["DDsRetreating"] = {
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
			},
		},
		["DDsReGrouping"] = {
			["sequence"] = {
				{
					["message"] = "dlg5",
				},
			},
		},
		["CASighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
				{
					["message"] = "dlg6c",
				},
			},
		},
		["CAObj"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
			},
		},
		["ExeterSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
				{
					["message"] = "dlg8_1",
				},
			},
		},
		["Exeter"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
			},
		},
		["ExeterSunken"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM3ExeterCamEnd",
				},
			},
		},
		["EnemyRetreats"] = {
			["sequence"] = {
				--[[{
					["message"] = "dlg11a",
				},]]--
				{
					["message"] = "dlg11b",
				},
			},
		},
		["TorpCleveland"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["TorpCleveland2"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
			},
		},
		["TorpCleveland3"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
			},
		},
		["Nells_Arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a",
				},
				{
					["message"] = "dlg15b",
				},
				{
					["message"] = "dlg15c",
				},
				{
					["message"] = "dlg15d",
				},
				{
					["message"] = "dlg15e",
				},
			},
		},
		["Final"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
				{
					["message"] = "dlg16_1",
				},
--				{
--					["type"] = "callback",
--					["callback"] = "luaJM3Final",
--				},
			},
		},
		--radiomessages
		["Radio1"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
				--{
					--["type"] = "callback",
					--["callback"] = "luaJM3DeRuyterCamEnd",
				--},
			},
		},
		["Radio2"] = {
			["sequence"] = {
				{
					["message"] = "dlg18a",
				},
				{
					["message"] = "dlg18b",
				},
			},
		},
		["Radio3"] = {
			["sequence"] = {
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19b",
				},
			},
		},
		["Radio4"] = {
			["sequence"] = {
				{
					["message"] = "dlg20a",
				},
				{
					["message"] = "dlg20b",
				},
				{
					["message"] = "dlg20c",
				},
				{
					["message"] = "dlg20d",
				},
			},
		},
		["RepairTutorial1"] = {
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM3DelayedFailure",
				},
			},
		},
		["RepairTutorial2"] = {
			["sequence"] = {
				{
					["message"] = "dlg21b",
				},
				{
					["message"] = "dlg21c",
				},
				{
					["message"] = "dlg21d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM3RepairDialogEnd",
				},
			},
		},
		["RepairCompleted"] = {
			["sequence"] = {
				{
					["message"] = "dlg22a",
				},
				{
					["message"] = "dlg22b",
				},
				{
					["message"] = "dlg22b_1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM3StepPhase",
				},
			},
		},
	}

	LoadMessageMap("ijndlg",3)

	Blackout(true, "", 0)

	Mission.DialogInterval = 30
	Mission.LastDialog = 0

	--active listeners
	luaJM3AddJapCargoListener()
	luaJM3AddDeRuyterHitListener()
	luaJM3AddExeterHitListener()
	luaJM3AddClevelandHitListener()
	luaJM3AddOwnDamageListener()

	--SoundFade(0,"", 1)
	--luaCheckMusicSetMinLevel()
	Music_Control_SetLevel(MUSIC_ACTION)
	ForceEnableInput(IC_SHIP_LAUNCHUNIT, false)

	luaJM3SetGuiNames()
	luaJM3StoreHints()
	
	luaDelay(luaJM3FadeIn,1)

	--watches
	--AddWatch("Mission.MissionPhase")

	--think
	SetThink(this, "luaJM3_think")
end

function luaJM3_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	--luaCheckMusic()

	--luaLog(recon[PARTY_JAPANESE].own)

	if Mission.EndMission then
		return
	end

	luaJM3CheckObjectives()

	if Mission.MissionPhase < 99 then
		luaJM3CheckSneakGroup()

	--luaJM3TorpCheatOnPlayer()

		luaJM3DDBattle()
		luaJM3CABattle()

	--luaJM3CheckUSNRetreat()
		luaJM3CheckExeterGroup()
		luaJM3CheckPlanes()
		luaJM3CheckJapTransports()
		luaJM3ClevelandSighted()
		--luaJM3CheckStagePlanes()
		luaJM3CheckInvincibleTimer()
		luaJM3CheckPlayerUnits() --hogy ne tudja kiszedni formaciobol

		if Mission.UnlockBeingSpawned then
			luaJM3CheckUnlockPlanes()
		end
	end

end

function luaJM3CheckObjectives()

	if Mission.PlayerUnit.Dead and not Mission.MissionFailed then
		Mission.PlayerDead = true
		Mission.MissionFailed = true
		--Mission.FailMsg = "Your flagship has been killed"
		Mission.FailMsg = "ijn03.obj_missionfailed_1"
		luaJM3StepPhase(99)
	end

	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	elseif luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
		if Mission.HiddenComplete then
			luaObj_Completed("hidden",1)
		end
	end

	if Mission.MissionPhase == 0 then

	elseif Mission.MissionPhase == 1 then

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			luaObj_AddReminder("primary",1)
			luaDelay(luaJM3HiddenDlg, 25)
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNDDGroup)) do
				luaObj_AddUnit("primary",1,unit)
			end
			--movie
			--luaJumpinMovieSetCurrentMovie("LookAt",Mission.USNDDGroup[1].ID)
			luaJM3DDMovie(Mission.USNDDGroup[1])
			luaDelay(luaJM3SetObjOk, 160)
			luaDelay(luaJM3MapHint1, 18)
			--luaJM3AddMapListener()
		else
			if luaObj_GetSuccess("primary",1) == nil then
				if table.getn(luaRemoveDeadsFromTable(Mission.USNDDGroup)) == 0 then
					HideScoreDisplay(1,0)
					--luaLog("hidescore 1")
					luaObj_Completed("primary",1,true)
					luaJM3StartDialog("DDsInTrouble",true)
			--movie
					luaDelay(luaJM3DDTroubleMovie,5)
				  luaDelay(luaJM3StepPhase, 9)
				else
					luaObj_Reminder("primary",1)
					--Mission.MaxShips = "3"
					Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.USNDDGroup))
					DisplayScores(1,0,"ijn03.obj_p1","ijn03.ddtosink")
					--luaLog("displayscore 1")
				end
			end
		end

	elseif Mission.MissionPhase == 2 then

		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			luaObj_AddReminder("primary",2)

			if not IsListenerActive("kill", "drCam") then
				if Mission.DeRuyter and not Mission.DeRuyter.Dead then
					luaJM3DeRuyterCamListener()
				end
			end


			Mission.USNStageGroup1 = luaRemoveDeadsFromTable(Mission.USNStageGroup1)
			Mission.USNStageGroup2 = luaRemoveDeadsFromTable(Mission.USNStageGroup2)
			Mission.ExeterGroup = luaRemoveDeadsFromTable(Mission.ExeterGroup)

			Mission.EnemyShips = luaSumTablesIndex(Mission.USNStageGroup1, Mission.USNStageGroup2, Mission.ExeterGroup)

			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EnemyShips)) do
				luaObj_AddUnit("primary",2,unit)
			end
		elseif luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
			Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.EnemyShips))
			DisplayScores(2,0,"ijn03.obj_p2","ijn03.ddtosink")


			if table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup2)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.EnemyShips)) ~= 0 then
				--[[HideScoreDisplay(2,0)
				--luaLog("hidescore 2")
				luaObj_Completed("primary",2,true)
				luaJM3StepPhase()
				--luaCheckpoint(1,nil)]]
				if not Mission.Chkp1Saved then
					Blackout(true, "luaJM3Checkpoint1", 1)
					Mission.Chkp1Saved = true
				end
			end

			if table.getn(luaRemoveDeadsFromTable(Mission.EnemyShips)) == 0 then
				HideScoreDisplay(2,0)
				--luaLog("hidescore 2")
				luaJM3StartDialog("EnemyRetreats",true)
				luaObj_Completed("primary",2)
				Mission.MissionCompleted = true
				luaJM3StepPhase(99)
			--else
				--luaObj_Reminder("primary",2)
				--Mission.MaxShips = "5"
				--Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.EnemyShips))
				--DisplayScores(2,0,"ijn03.obj_p2","ijn03.ddtosink")
				--luaLog("displayscore 2")
			end
		end

	--[[elseif Mission.MissionPhase == 3 then

		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
			luaObj_AddReminder("primary",3)
			--[[if not IsListenerActive("kill", "drCam") then
				luaJM3DeRuyterCamListener()
			end]]
			DisplayScores(8,0,"ijn03.obj_p3","ijn03.ddtosink")
			--luaLog("displayscore 8")
			for i,v in pairs(luaRemoveDeadsFromTable(Mission.USNStageGroup1)) do
				luaObj_AddUnit("primary",3,v)
				--DisplayUnitHP({Mission.DeRuyter}, "ijn03.obj_p3")
			end
			luaJM3StartDialog("CAObj",true)

			--movie
			--luaJumpinMovieSetCurrentMovie("GoAround",Mission.DeRuyter.ID)
			luaJM3DeruyterMovie(Mission.DeRuyter)

		elseif luaObj_IsActive("primary",3) then
			local ship
			if luaObj_GetSuccess("primary",3) == nil and table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup1)) == 0 then
				--luaLog("hidescore 8")
				--luaJM3DeRuyterCamStart(Mission.LastDeadFromDeRuyterGroup)
				luaJM3DeRuyterCam()
			else
				luaObj_Reminder("primary",3)
				Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup1))
				DisplayScores(8,0,"ijn03.obj_p3","ijn03.ddtosink")
				--luaLog("displayscore 8")
				--[[if Mission.DeRuyter and not Mission.DeRuyter.Dead and not IsInvincible(Mission.DeRuyter) then
					SetInvincible(Mission.DeRuyter, 0.001)
				end]]
			end
		end

	elseif Mission.MissionPhase == 4 then

		if not luaObj_IsActive("primary",4) then
			luaObj_Add("primary",4)
			luaObj_AddReminder("primary",4)
			HideScoreDisplay(8,0)
			if not IsListenerActive("kill","endCam") then
				luaJM3EndCamListener()
			end
			--Mission.Morale = "ijn03.morale_heroic"
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ExeterGroup)) do
				luaObj_AddUnit("primary",4,unit)
			end
			luaJM3StartDialog("Exeter",true)

			--movie
			--luaJumpinMovieSetCurrentMovie("GoAround",Mission.Exeter.ID)
			luaJM3ExeterMovie(Mission.Exeter)
			luaDelay(luaJM3CrossHairHint, 20)
			luaDelay(luaJM3TurnHint, 40)
		elseif luaObj_IsActive("primary",4) then
			--unlock
			--if Mission.UnlockLvl > 1 then
			if Scoring_IsUnlocked("JM2_GOLD") then
				if not Mission.UnlockBeingSpawned then
					luaJM3AddUnlock()
				end
			end

			if luaObj_GetSuccess("primary",4) == nil then
				Mission.ShipsRemaining = table.getn(luaRemoveDeadsFromTable(Mission.ExeterGroup))
				Mission.MaxShips = "3"
				DisplayScores(3,0,"ijn03.obj_p4", "ijn03.abdaships")
				--luaLog("displayscore 3")

				if table.getn(luaRemoveDeadsFromTable(Mission.ExeterGroup)) == 0 then
					luaObj_Completed("primary",4,true)
					HideScoreDisplay(3,0)
					--luaLog("hidescore 3")
					luaJM3StartDialog("EnemyRetreats",true)
					luaJM3StepPhase()
				else
					luaObj_Reminder("primary",4)
				end
			end
		end]]


	elseif Mission.MissionPhase == 99 then

		if Mission.MissionCompleted then
			luaJM3StartDialog("Final",true)
			if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
--				luaDelay(luaJM3Final, 17)
			else
				luaJM3MovieInit()

				luaIngameMovie(
					{
						{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 200, ["theta"] = 55, ["rho"] = 100, ["moveTime"] = 0,},
						{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 500, ["theta"] = 15, ["rho"] = 70, ["moveTime"] = 17,},
					}, luaJM3Final, true, 17, false)
			end

		elseif Mission.MissionFailed then
			luaJM3StepPhase()
			local endEnt

			if Mission.PlayerDead and Mission.PlayerUnit.LastBanto and not Mission.PlayerUnit.LastBanto.Dead then
				endEnt = Mission.PlayerUnit.LastBanto
			else
				endEnt = nil
			end
			
			luaMissionFailedNew(endEnt, Mission.FailMsg)

			Mission.EndMission = true
		end

	end

	if not luaObj_IsActive("secondary",2) and Mission.ClevelandSighted then
		luaObj_Add("secondary",2)
		if Mission.Cleveland and not Mission.Cleveland.Dead then
			if luaObj_IsActive("secondary",2) then
				luaObj_AddUnit("secondary",2,Mission.Cleveland)
			end
		end
		luaJM3StartDialog("TorpCleveland",true)
	elseif luaObj_IsActive("secondary",2) then
		if luaObj_GetSuccess("secondary",2) == nil and Mission.CleveObjOk then
			luaObj_Completed("secondary",2)
			luaJM3AddPowerUp("improved_shells")
		elseif luaObj_GetSuccess("secondary",2) == nil and Mission.Cleveland.Dead then
			luaObj_Failed("secondary",2)
		end
	end
end

function luaJM3ExeterDlg()
	luaJM3StartDialog("Exeter",true)
end

function luaJM3CheckSneakGroup()
	if Mission.HiddenComplete == nil and table.getn(luaRemoveDeadsFromTable(Mission.USNSneakGroup)) == 0 then
		Mission.HiddenComplete = true
	end
end

function luaJM3Checkpoint1()
	luaCheckpoint(1,nil)
	Blackout(false, "", 1)
	luaJM3StartDialog("CAObj",true)

	if Scoring_IsUnlocked("JM2_GOLD") or Scoring_IsUnlocked("JM2_SILVER") then
		if not Mission.UnlockBeingSpawned then
			luaJM3AddUnlock()
		end
	end
	--luaDelay(luaJM3ExeterDlg, 30)
end

function luaJM3MakeFormation(unitTable,leaderIndx,aiCtrl)
	if not leaderIndx or type(leaderIndx) ~= "number" then
		leaderIndx = 1
	end
	for idx,unit in pairs(unitTable) do
		if aiCtrl then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end
		if idx ~= leaderIndx then
			JoinFormation(unit, unitTable[leaderIndx])
		end
	end
	return unitTable[leaderIndx]
end

function luaJM3StartMsg()
	EnableInput(false)
	--Blackout(true,"",true)
  luaDelay(luaJM3StartMsgClb, 1.5)
end

function luaJM3StartMsgClb()
	--SoundFade(1, "",0.1)
	--Blackout(false, "", 1.5)
  EnableInput(true)
  luaJM3StartDialog("Intro",true)
  --luaJM3ShipHint()
end

--------------------------------------- DIALOGS---------------------------------------
function luaJM3StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM3StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM3StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
		--luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM3HiddenDlg()
	luaJM3StartDialog("DDSighted", true)
	--AddPlayerObjective(PLAYER_1, Mission.USNSneakGroup[1])
	--Objectives_Add(nil, PLAYER_1, "USNSneakGroup", "x", "marker1",Mission.USNSneakGroup[1])
	if Mission.USNSneakGroup[1] then
		--luaObj_Add("marker2",1,Mission.USNSneakGroup[1])
	end

	luaDelay(luaJM3BinocHint,60)
	--luaDelay(luaJM3SeaPlaneHint,120)
end
-----------------------------------------------------------------------------------------
function luaJM3DDBattle()

	local isNear = luaJM3IsPlayerInVicinity(Mission.USNStageGroup2)

	if not isNear and not Mission.DDGroupInvincible then
		if not Mission.HiddenTimer1Up then
			--luaJM3SetInvincible(Mission.IJNStageGroup2,"rnd")
			Mission.IJNGroup2Invincible = true
		end
		luaJM3SetInvincible(Mission.USNStageGroup2,0.6)
		Mission.DDGroupInvincible = true
	elseif isNear and Mission.DDGroupInvincible then
		luaJM3SetInvincible(Mission.IJNStageGroup2,false)
		luaJM3SetInvincible(Mission.USNStageGroup2,false)
		Mission.DDGroupInvincible = false
		Mission.IJNGroup2Invincible = false
	end

	if Mission.HiddenTimer1Up and Mission.IJNGroup2Invincible then
		luaJM3SetInvincible(Mission.IJNStageGroup2,false)
		Mission.IJNGroup2Invincible = false
	end

	if not Mission.DDBattleStarted then
		Mission.IJNStageGroup2 = luaRemoveDeadsFromTable(Mission.IJNStageGroup2)
		Mission.USNStageGroup2 = luaRemoveDeadsFromTable(Mission.USNStageGroup2)
		local shipsJ
		local shipsA

		if Mission.IJNStageGroup2[1] then
			shipsJ = luaGetShipsAround(Mission.IJNStageGroup2[1], 1000, "enemy")
		end

		if Mission.USNStageGroup2[1] then
			shipsA = luaGetShipsAround(Mission.USNStageGroup2[1], 1000, "enemy")
		end

		if (shipsA and next(shipsA)) and (shipsJ and next(shipsJ)) then
			Mission.DDBattleStarted = true
		end
	end

	--IJNGRP
	if Mission.DDBattleStarted then

		Mission.IJNStageGroup2 = luaRemoveDeadsFromTable(Mission.IJNStageGroup2)
		if not Mission.DDRegroupDone and table.getn(luaRemoveDeadsFromTable(Mission.IJNStageGroup2)) > 0 then
			for idx,unit in pairs(Mission.IJNStageGroup2) do
				--if not Mission.DDGroupInvincible then
					if not unit.retreating and GetHpPercentage(unit) < 0.3 then
						--luaLog("Retreat")
						--NavigatorMoveToRange(unit,GetClosestBorderZone(GetPosition(unit)))
						unit.retreating = true
						--Mission.Dialogues["DDsRetreating"]["sequence"][1]["message"] = string.gsub(Mission.Dialogues["DDsRetreating"]["sequence"][1]["message"], "<SHIPNAME>", GetGuiName(unit))
						luaJM3StartDialog("DDsRetreating",true,false)
					elseif not unit.retreating and GetHpPercentage(unit) > 0.3 then
						--luaLog("Attack")
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USNStageGroup2))
							if trg and not trg.Dead then
								if IsInFormation(unit) then
									DisbandFormation(unit)
								end
								luaSetScriptTarget(unit, trg)
								NavigatorAttackMove(unit, trg, {})
								--luaLog("Attack	 "..unit.Name)
							end
						end
					end
				end
			--end
		end

		--USNGRP
		Mission.USNStageGroup2 = luaRemoveDeadsFromTable(Mission.USNStageGroup2)
		if table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup2)) > 0 then

			for idx,unit in pairs(Mission.USNStageGroup2) do
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead or luaGetScriptTarget(unit).retreating then
					--debug
					--luaLog(unit.Name.."'s target")
					--local ize = luaGetScriptTarget(unit)
					--if ize == nil then
-- RELEASE_LOGOFF  					--	luaLog("\tEMPTY")
					--else
-- RELEASE_LOGOFF  					--	luaLog("\t"..ize.Name)
-- RELEASE_LOGOFF  					--	luaLog("\tDead: "..tostring(ize.Dead))
-- RELEASE_LOGOFF  					--	luaLog("\tRetreats: "..tostring(ize.retreating))
					--end

					local trgTbl = luaJM3RemoveRetreaters(luaRemoveDeadsFromTable(Mission.IJNStageGroup2))
					local trg

					--luaLog("targetTbl")
					--luaLog(trgTbl)

					if table.getn(trgTbl) == 0 then
						trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.PlayerUnits))
						--luaLog("All jap DDs are dead or retreating")
					else
						trg = luaPickRnd(trgTbl)
					end
					if trg and not trg.Dead then
						if IsInFormation(unit) then
							DisbandFormation(unit)
						end
						luaSetScriptTarget(unit, trg)
						NavigatorAttackMove(unit, trg, {})
						--luaLog("Attack2 "..unit.Name)
					end
				end
			end

		elseif table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup2)) == 0 then

			if table.getn(luaRemoveDeadsFromTable(Mission.IJNStageGroup2)) > 0 and not Mission.DDRegroupDone then
				luaJM3StartDialog("DDsReGrouping",true)
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNStageGroup2)) do
					local leader = GetSelectedUnit()
					if not leader or leader.Dead then
						leader = Mission.PlayerUnits[1]
					end
					if IsInFormation(unit) then
						DisbandFormation(unit)
					end
					SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
					JoinFormation(unit, leader)
				end
				Mission.DDRegroupDone = true
			end

		end
	end
end

function luaJM3CABattle()
	if Mission.CABattleEnded then
		if Mission.CAGroupInvincible then
			luaJM3SetInvincible(Mission.IJNStageGroup1,false)
			luaJM3SetInvincible(Mission.USNStageGroup1,false)
			Mission.CAGroupInvincible = false
			Mission.IJNStage2Invincible = false
		end
		return
	end

	local isNear = luaJM3IsPlayerInVicinity(Mission.IJNStageGroup1,Mission.USNStageGroup1)

	if not isNear and not Mission.CAGroupInvincible then
		if not Mission.HiddenTimer2Up then
			luaJM3SetInvincible(Mission.IJNStageGroup1,"rnd")
			Mission.IJNStage2Invincible = true
		end
		luaJM3SetInvincible(Mission.USNStageGroup1,0.6)
		Mission.CAGroupInvincible = true
	elseif isNear and Mission.CAGroupInvincible then --and Mission.MissionPhase >= 3 then
		luaJM3SetInvincible(Mission.IJNStageGroup1,false)
		luaJM3SetInvincible(Mission.USNStageGroup1,false)
		Mission.CAGroupInvincible = false
		Mission.IJNStage2Invincible = false
	end

	if Mission.HiddenTimer2Up and Mission.IJNStage2Invincible then
		luaJM3SetInvincible(Mission.IJNStageGroup1, false)
		Mission.IJNStage2Invincible = false
	end

	if not Mission.CABattleStarted then
		--local pos = FillPathPoints(FindEntity(""))
		local shipsJ = luaGetShipsAroundCoordinate(GetPosition(FindEntity("CANavpoint 02")), 500, PARTY_JAPANESE, "own")
		local shipsA = luaGetShipsAroundCoordinate(GetPosition(FindEntity("CANavpoint 02")), 500, PARTY_ALLIED, "own")
		if (shipsA and next(shipsA)) and (shipsJ and next(shipsJ)) then
			Mission.CABattleStarted = true
			luaJM3SetFreeAttack(Mission.USNStageGroup1, Mission.IJNStageGroup1)
		end
	end

	--USNGRP
	Mission.USNStageGroup1 = luaRemoveDeadsFromTable(Mission.USNStageGroup1)
	if table.getn(luaRemoveDeadsFromTable(Mission.USNStageGroup1)) == 0 then
		Mission.CABattleEnded = true
	end

	--IJNGRP
	Mission.IJNStageGroup1 = luaRemoveDeadsFromTable(Mission.IJNStageGroup1)
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNStageGroup1)) > 0 then
		if Mission.CABattleEnded then
			local leader = GetFormationLeader(Mission.PlayerUnit)
			if not leader or leader.Dead then
				leader = Mission.PlayerUnits[1]
			end
			for idx,unit in pairs(Mission.IJNStageGroup1) do
				JoinFormation(unit, leader)
			end
		end
	end
end

function luaJM3IsPlayerInVicinity2(...)
	for i,v in ipairs(arg) do
		if type(v) ~= "table" then
			--luaLog("luaJM3IsPlayerInVicinity "..tostring(i)..". param is not a table")
			return
		end
		for idx,unit in pairs(luaRemoveDeadsFromTable(v)) do --unit tabla
			for idx2,player in pairs(luaRemoveDeadsFromTable(Mission.PlayerUnits)) do --playerunits
				if luaGetDistance(player,unit) < 2000 then
					return true
				end
			end
		end
	end

	return false
end

function luaJM3IsPlayerInVicinity(...)
	local selected = GetSelectedUnit()
	if selected == nil or selected.Dead then
		--luaLog("No Selected player in the vicinity")
		return false
	elseif selected then
		if  selected.Class.Type == "SmallReconPlane" then
			--luaLog("NearUnit is an airplane")
			return false
		end
	end

	for i,v in ipairs(arg) do
		if type(v) ~= "table" then
			--luaLog("luaJM3IsPlayerInVicinity "..tostring(i)..". param is not a table")
			return
		end
		for idx,unit in pairs(luaRemoveDeadsFromTable(v)) do --unit tabla
			if luaGetDistance(selected,unit) < 2200 then --vajh milyen messze lo el max a unitunk?
				return true
			end
		end
	end

	return false
end

function luaJM3SetInvincible(unitTbl,ratio,rnd)
	if ratio == "rnd" then
		local _dummy = random(1,6)
		ratio = (_dummy * 10)/100
	end
	for idx,unit in pairs(unitTbl) do
		--ha serult a unit ne javuljon... kell ez?
		if not unit.Dead then
			local hp = GetHpPercentage(unit)
			if hp ~= 1 and ratio then
				SetInvincible(unit,hp)
			else
				SetInvincible(unit,ratio)
			end
		end
	end
end

function luaJM3SetFreeAttack(...)
	for i,v in ipairs(arg) do
		if type(v) ~= "table" then
			--luaLog("luaJM3SetFreeAttack "..tostring(i)..". param is not a table")
			return
		end
		for idx,unit in pairs(luaRemoveDeadsFromTable(v)) do --unit tabla
			UnitFreeAttack(unit)
		end
	end
end

function luaJM3AddDeruyterListener()
	AddListener("hit", "deruyterhit", {
		["callback"] = "luaJM3DeRuyterHitByPlayer", -- callback fuggveny
		["target"] = { Mission.DeRuyter }, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	--Mission.ListenerActive = true
end

function luaJM3DeRuyterHitByPlayer()
	Mission.DeRuyterHit = true
	RemoveListener("hit", "deruyterhit")
end

function luaJM3AddJapCargoListener()
	Mission.JapTransports = luaRemoveDeadsFromTable(Mission.JapTransports)
	
	AddListener("hit", "cargohit", {
		["callback"] = "luaJM3CargosHit", -- callback fuggveny
		["target"] = Mission.JapTransports, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = Mission.USNSneakGroup, -- tamado entityk
		["attackType"] = {}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_AI}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.CargoListenerActive = true
end

function luaJM3CargosHit()
	if Mission.CargoListenerActive then
		RemoveListener("hit","cargohit")
		Mission.CargoListenerActive = false
	end
	Mission.HiddenComplete = false
end

function luaJM3TorpCheatOnPlayer()
	Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
	for idx,unit in pairs(Mission.PlayerUnits) do
		local stock = GetProperty(unit, "TorpedoStock")
		if stock == 0 and not unit.reloading then
			luaDelay(luaJM3ReloadTorp, 15, "unit", unit)
			Mission.UnitName = GetGuiname(unit)
			--MissionNarrativeEnqueue("Starting torpedo reload on "..unit.Name)
			MissionNarrativeEnqueue("ijn03.hint_2_dec") -- nincs hozza lockit!
			unit.reloading = true
		end
	end
end

function luaJM3ReloadTorp(timerthis)
	local unit = timerthis.ParamTable.unit
	if unit.Dead then
		return
	end
	ReloadTorpedoes(unit, 5)
	unit.reloading = nil
end

function luaJM3CheckUSNRetreat()

	if not Mission.USNFleetRetreats then

		if luaObj_GetSuccess("primary",1) == true and luaObj_GetSuccess("primary",2) == true and luaObj_GetSuccess("primary",3) == true and luaObj_GetSuccess("primary",4) == true then
			Mission.USNFleetRetreats = true
		end
	end
end

function luaJM3StepPhase(phase)
	--luaLog("luaJM3StepPhase "..debug.traceback())
	if phase ~= nil and type(phase) == "number" then
		--luaLog("Setting phase to "..tostring(phase))
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end
--[[
function luaJM3AddEndListener()
	AddListener("input", "EndInput",{
		["callback"] = "luaJM3EndScene",  -- callback fuggveny
		["inputID"] = {IC_CMD_JUMPIN}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Mission.EndListener = true
	MissionNarrativeEnqueue("You may pursuit the retreating fleet, but at anytime you may end this mission by pressing the JUMPIN key.")
end

function luaJM3EndScene()
	if Mission.EndListener then
		RemoveListener("input", "EndInput")
		Mission.EndListener = false
		luaJM3SpawnEndPlanes()
	end
end
]]
function luaJM3CheckEndConds()
	--if table.getn(luaRemoveDeadsFromTable(Mission.ExeterGroup)) == 0 then
	for idx,objtbl in pairs(Mission.Objectives.primary) do
		if not objtbl.Active or not objtbl.Success then
			return
		end
	end

	if Mission.MissionPhase < 99 then
		if Mission.USNFleetRetreats then
		--if table.getn(luaRemoveDeadsFromTable(Mission.ExeterGroup)) == 0 then
			Mission.MissionCompleted = true
			luaJM3StepPhase(99)
		end
	end
end

function luaJM3GetPlayerPlanes()
	Mission.PlayerPlanes = {}
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
		if not unit.Dead then
			table.insert(Mission.PlayerPlanes, unit)
		end
	end
	return Mission.PlayerPlanes
end

function luaJM3GetAIPlanes()
	Mission.AIPlanes = {}
	for idx,unit in pairs(recon[PARTY_ALLIED].own.reconplane) do
		if not unit.Dead then
			table.insert(Mission.AIPlanes, unit)
		end
	end
	return Mission.AIPlanes
end

function luaJM3CheckPlanes()
	local playerPlanes = luaRemoveDeadsFromTable(luaJM3GetPlayerPlanes())

	if table.getn(playerPlanes) == 0 then
		return
	end

	local aiPlanes = luaRemoveDeadsFromTable(luaJM3GetAIPlanes())

	if table.getn(aiPlanes) > 0 then
		local trgTbl = playerPlanes
		local trg
		for idx,unit in pairs(aiPlanes) do
			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then

				if table.getn(trgTbl) > 0 then
					trg = luaPickRnd(trgTbl)
				end

				if trg and not trg.Dead then
					luaSetScriptTarget(unit, trg)
					PilotSetTarget(unit, trg)
				else

					local cmd = GetProperty(unit, "unitcommand")
					if cmd ~= "moveto" or cmd ~= "retreat" then
						local trg
						for idx2,cruiser in pairs(recon[PARTY_ALLIED].own.cruiser) do
							if not cruiser.Dead then
								local inAir = GetLastCatapulted(cruiser)
								if inAir and inAir.ID == unit.ID then
									trg = cruiser
								end
							end
						end
						if trg then
							PilotMoveToRange(unit, trg)
						else
							PilotRetreat(unit)
							--luaLog("Meghalt a szulocruiser")
						end
					end
				end

			end
		end
	elseif table.getn(aiPlanes) == 0 then
		luaJM3SendPlanes()
	end
end

function luaJM3SendPlanes()
	--luaLog("luaJM3SendPlanes called")
	for idx,unit in pairs(recon[PARTY_ALLIED].own.cruiser) do
		if unit and not unit.Dead then
			local rnd = random(1,100)
			local num = GetNumCatapulted(unit)
			local inAir = GetLastCatapulted(unit)
			if rnd >= 80 and num < 4 and not inAir then
				--luaLog(unit.Name.." is sending out a reconplane")
				--luaLog("randomroll: "..tostring(rnd).." sent out planes "..tostring(num))
				ShipUseCatapult(unit)
			end
		end
	end
end

function luaJM3CheckExeterGroup()
	if table.getn(luaRemoveDeadsFromTable(Mission.ExeterGroup)) == 0 then
		return
	end

	local isNear = luaJM3IsPlayerInVicinity(Mission.ExeterGroup)

	if Mission.ExeterGroupInvincible and Mission.USNFleetRetreats then
		luaJM3SetInvincible(Mission.ExeterDecoy,false)
		luaJM3SetInvincible(Mission.ExeterGroup,false)
		Mission.ExeterGroupInvincible = false
		Mission.DecoyInvincible = false
	end

	if isNear and Mission.ExeterGroupInvincible and not Mission.USNFleetRetreats then
		luaJM3SetInvincible(Mission.ExeterDecoy,false)
		luaJM3SetInvincible(Mission.ExeterGroup,false)
		Mission.ExeterGroupInvincible = false
		Mission.DecoyInvincible = false
	elseif not isNear and not Mission.ExeterGroupInvincible and not Mission.USNFleetRetreats then
		if not Mission.HiddenTimer3Up then
			luaJM3SetInvincible(Mission.ExeterDecoy,"rnd")
			Mission.DecoyInvincible = true
		end
		luaJM3SetInvincible(Mission.ExeterGroup,0.7)
		Mission.ExeterGroupInvincible = true
	end

	if Mission.DecoyInvincible and Mission.HiddenTimer2Up then
		luaJM3SetInvincible(Mission.ExeterDecoy, false)
		Mission.DecoyInvincible = false
	end

	if not Mission.ExeterBattle then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ExeterGroup)) do
			for idx2,unit2 in pairs(luaRemoveDeadsFromTable(Mission.ExeterDecoy)) do
				if luaGetDistance(unit,unit2) > 2200 then
					Mission.ExeterBattle = true
					return
				end
			end
		end

	else

		if not Mission.USNFleetRetreats then
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ExeterGroup)) do
				if IsFormationLeader(unit) then
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						local trg
						--if table.getn(luaRemoveDeadsFromTable(Mission.ExeterDecoy)) == 0 then
							trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.PlayerUnits))
						--else
							--trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.ExeterDecoy))
						--end
						if trg and not trg.Dead then
							luaSetScriptTarget(unit, trg)
							NavigatorAttackMove(unit, trg, {})
						end
					end
				end
			end
		end

		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ExeterDecoy)) do
			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.ExeterGroup))
				if trg and not trg.Dead then
					luaSetScriptTarget(unit, trg)
					NavigatorAttackMove(unit, trg, {})
				end
			end
		end

	end
end

function luaJM3AddExeterListener()
	if Mission.Exeter and not Mission.Exeter.Dead then
		AddListener("recon", "exeterListener", {
			["callback"] = "luaJM3ExeterSighted",  -- callback fuggveny
			["entity"] = {Mission.Exeter}, -- entityk akiken a listener aktiv
			["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
			["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
			["party"] = {PARTY_JAPANESE},
			})
	end
end

function luaJM3ExeterSighted(...)
	--luaLog("luaJM3ExeterSighted")
	--for idx,x in ipairs(arg) do
		--luaLog("id: "..tostring(idx))
		--luaLog(x)
	--end
	RemoveListener("recon", "exeterListener")
	luaJM3StartDialog("ExeterSighted",true)
	luaJM3StartDialog("Exeter",true)
	Mission.ExeterSighted = true
end

function luaJM3AddCAListener()
	--luaLog("CA recon listener added")
	if Mission.DeRuyter and not Mission.DeRuyter.Dead then
		AddListener("recon", "caListener", {
			["callback"] = "luaJM3CASighted",  -- callback fuggveny
			["entity"] = {Mission.DeRuyter}, -- entityk akiken a listener aktiv
			["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
			["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
			["party"] = {PARTY_JAPANESE},
			})
	end
end

function luaJM3CASighted(...)
	for idx,x in ipairs(arg) do
		--luaLog("idx: ")
		--luaLog(x)
	end
	RemoveListener("recon", "caListener")
	luaJM3StartDialog("CASighted",true)
	luaJM3StartDialog("Radio2",true)
	Mission.CASighted = true
end

function luaJM3SetObjOk()
	Mission.DDObjOk = true
end

function luaJM3AddDeRuyterHitListener()
	if Mission.DeRuyter and not Mission.DeRuyter.Dead then
		AddListener("hit", "deruyterhit2", {
			["callback"] = "luaJM3DeRuyterHit", -- callback fuggveny
			["target"] = { Mission.DeRuyter }, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
			["attackerPlayerIndex"] = {PLAYER_AI,PLAYER_1}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end
end

function luaJM3DeRuyterHit(...)
	--luaLog("DeRuyterhit table")
	--for idx,akarmi in ipairs(arg) do
-- RELEASE_LOGOFF  	--	luaLog(akarmi)
	--end
	local hp = GetHpPercentage(Mission.DeRuyter)
	if hp <= 0.3 and not Mission.DeRuyter.Dead then
		--SetInvincible(Mission.DeRuyter, 0.2)
		AddUntouchableUnit(Mission.DeRuyter)
		RemoveListener("hit", "deruyterhit2")
	end
	--[[if arg[5] == PLAYER_1 then
		SetInvincible(Mission.DeRuyter, false)
		RemoveListener("hit", "deruyterhit2")
		Effect("SecondaryExplosion", GetPosition(Mission.DeRuyter), Mission.DeRuyter)
		SetDeadMeat(Mission.DeRuyter)
	end]]
end

function luaJM3AddExeterHitListener()
	if Mission.Exeter and not Mission.Exeter.Dead then
		AddListener("hit", "exeterhit", {
			["callback"] = "luaJM3ExeterHit", -- callback fuggveny
			["target"] = { Mission.Exeter }, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
			["attackerPlayerIndex"] = {PLAYER_AI,PLAYER_1}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end
end

function luaJM3ExeterHit(...)
	--luaLog("Exeterhit table")
	local hp = GetHpPercentage(Mission.Exeter)
	if hp <= 0.3 and not Mission.Exeter.Dead then
		--SetInvincible(Mission.Exeter, 0.2)
		AddUntouchableUnit(Mission.Exeter)
		RemoveListener("hit", "exeterhit")
	end
	--[[if arg[5] == PLAYER_1 and hp <= 0.3 then
		SetInvincible(Mission.Exeter, false)
		RemoveListener("hit", "exeterhit")
		Effect("SecondaryExplosion", GetPosition(Mission.Exeter), Mission.Exeter)
		SetDeadMeat(Mission.Exeter)
	end]]
end

function luaJM3CheckJapTransports()
	if Mission.NoNeedToCheckTransports then
		return
	end

	local killed = 0
	local retreated = 0
	local died = 0

	for idx,unit in pairs(Mission.JapTransports) do
		if unit.Dead then
			died = died + 1
			if unit.KillReason == "exitzone" then
				retreated = retreated + 1
			else
				killed = killed + 1
			end
		end
	end

	local num = math.floor(table.getn(luaRemoveDeadsFromTable(Mission.JapTransports))/2)
	if num < killed then
		Mission.MissionFailed = true
		--Mission.FailMsg = "Too many japanese transport ships are sunken"
		Mission.FailMsg = "ijn03.obj_missionfailed_2"
		Mission.NoNeedToCheckTransports = true
		luaJM3StepPhase(99)
	elseif num < retreated then
		Mission.NoNeedToCheckTransports = true
	end
end

function luaJM3AddClevelandHitListener()
	--if Mission.ClevelandFirstHit then
	--	luaJM3StartDialog("TorpCleveland3")
	--end
	if Mission.Cleveland and not Mission.Cleveland.Dead then
		AddListener("hit", "clevelandhit", {
			["callback"] = "luaJM3ClevelandHit", -- callback fuggveny
			["target"] = { Mission.Cleveland }, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {"TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
			["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end
end

function luaJM3ClevelandHit()
--	if not Mission.ClevelandFirstHit then
--		Mission.ClevelandFirstHit = true
		RemoveListener("hit", "clevelandhit")
--		luaDelay(luaJM3AddClevelandHitListener, 30)
		NavigatorEnable(Mission.Cleveland, true)
		NavigatorMoveToRange(Mission.Cleveland,GetClosestBorderZone(GetPosition(Mission.Cleveland)))
		luaJM3StartDialog("TorpCleveland2",true)
--	else
--		SetInvincible(Mission.Cleveland, false)
--		RemoveListener("hit", "clevelandhit")
--		Effect("SecondaryExplosion", GetPosition(Mission.Cleveland), Mission.Cleveland)
--		SetDeadMeat(Mission.Cleveland)
		Mission.CleveObjOk = true
--	end
end

function luaJM3ClevelandSighted()
	if Mission.ClevelandSighted or Mission.Cleveland.Dead then
		return
	end

	for idx, unit in pairs(Mission.PlayerUnits) do
		if not unit.Dead and luaGetDistance(unit, Mission.Cleveland) < 2500 then
			Mission.ClevelandSighted = true
			return
		end
	end
end

function luaJM3CheckStagePlanes()

	if table.getn(luaRemoveDeadsFromTable(Mission.StagePlanes)) < Mission.MaxStagePlanes then
		if not SpawnNewIDIsRequested(Mission.StagePlaneReq) then
			luaJM3SpawnStagePlanes()
		end
	end

end

function luaJM3SpawnStagePlanes()
	local grpTbl = {
		[1] = {
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Crew"] = 1,
			["Race"] = JAPAN,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
		[2] = {
			["Type"] = 162,
			["Name"] = "B5N Kate",
			["Crew"] = 1,
			["Race"] = JAPAN,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
	}

	local rnd1 = random(10,15)
	--luaLog("rnd1: no of squadrons: "..tostring(rnd1))

	local rnd2 = random(1,100)
	--luaLog("rnd2: type of squadrons: "..tostring(rnd2))

	local typeTble = {}
	local spawnTable = {}

	if Mission.ActPoint == 3 then
		Mission.ActPoint = 1
	else
		Mission.ActPoint = Mission.ActPoint + 1
	end

	local spawnPoint = Mission.StagePlaneSpawnPoints[Mission.ActPoint]

	if rnd2 <= 50 then
		typeTble = grpTbl[1]
		spawnPoint.y = 120
	else
		typeTble = grpTbl[2]
		spawnPoint.y = 120
	end

	for i=1,rnd1 do
		table.insert(spawnTable, typeTble)
	end

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = spawnTable,
	["area"] = {
		["refPos"] = spawnPoint,
		["angleRange"] = { luaJM3RAD(0), luaJM3RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = Mission.StagePlaneRetreatPoints[Mission.ActPoint],
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM3StagePlaneSpawned",
	["id"] = Mission.StagePlaneReq,
})
end

function luaJM3StagePlaneSpawned(...)
	for i,v in ipairs(arg) do
		SetRoleAvailable(v, EROLF_ALL, PLAYER_AI)
		SquadronSetTravelAlt(v, random(50,60))
		--SquadronSetAttackAlt(v, random(50,60))
		table.insert(Mission.StagePlanes, v)
		PilotMoveToRange(v, Mission.StagePlaneRetreatPoints[Mission.ActPoint])
		SetInvincible(v, 0.1)
	end
-- RELEASE_LOGOFF  	luaLog("planes spawned")
end

function luaJM3RAD(x)
	return x *  0.0174532925
end

function luaJM3CheckInvincibleTimer()
	local time = math.floor(GameTime())

	if time >= 300 and not Mission.HiddenTimer1Up then
		Mission.HiddenTimer1Up = true
	end
	if time >= 600 and not Mission.HiddenTimer2Up then
		Mission.HiddenTimer2Up = true
	end
	if time >= 900 and not Mission.HiddenTimer3Up then
		Mission.HiddenTimer3Up = true
	end
end

function luaJM3CheckPlayerUnits()
	--Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerUnits)) == 0 then
		return
	end

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerUnits)) do
		if not IsInFormation(unit) and unit.Class.Type == "Destroyer" then
			JoinFormation(unit, Mission.PlayerUnit)
		end
	end
end


function luaJM3AddPowerUp(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrativeUrgent("missionglobals.newpowerup")

	luaDelay(luaJM3PowerUpHint, 3)
end

--unlock
function luaJM3GetPossiblePositions(pos,modifier)
	local tbl = {}
	local tbl2 = {}	--mar nem kell

	local numPoints = 15
	local x
	local z

	for i=1,numPoints do
		x = pos.x + modifier * math.cos(i * (2 * math.pi)/numPoints)
		z = pos.z + modifier * math.sin(i * (2 * math.pi)/numPoints)
		table.insert(tbl, {["x"]=x, ["y"]=1500, ["z"]=z})
		table.insert(tbl2, {pos.x-x, pos.z-z})
	end

	return tbl,tbl2
end

function luaJM3AddUnlock()

	local refUnit = GetSelectedUnit()
	local pos
	local spawnPos

	if not refUnit or refUnit.Dead then
		refUnit = Mission.PlayerUnits[1]
	end

	newposTbl,_dummy = luaJM3GetPossiblePositions(GetPosition(refUnit),4200)

	for idx,newpos in pairs(newposTbl) do
		--if luaIsVisibleCoordinate(refUnit,newpos,4000) then
-- RELEASE_LOGOFF  		--	luaLog("coordinate is visible")
		if IsInBorderZone(newpos) then
			--luaLog("coordinate is in borderzone")
		else
			spawnPos = newpos
			break
		end
	end

	if spawnPos then
		Mission.UnlockBeingSpawned = true
		luaJM3SpawnUnlockUnits(spawnPos,refUnit)
	else
		return
	end
end

function luaJM3SpawnUnlockUnits(spawnPos,refUnit)
	local lookAt = GetPosition(refUnit)
	local grpTbl = {}
	local unitTbl =
		{
			["Type"] = 166,
			["Name"] = "G3M Nell",
			["Crew"] = 1,
			["Race"] = JAPAN,
			["WingCount"] = 3,
			["Equipment"] = 1,
		}

	if Scoring_IsUnlocked("JM2_GOLD") then
		table.insert(grpTbl, unitTbl)
		table.insert(grpTbl, unitTbl)
	elseif Scoring_IsUnlocked("JM2_SILVER") then
		table.insert(grpTbl, unitTbl)
	else
		return
	end

	

	--luaLog(grpTbl)

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = spawnPos,
		["angleRange"] = { luaJM3RAD(0), luaJM3RAD(180)},
		["lookAt"] = lookAt,
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM3UnlockPlanesSpawned",
	["id"] = "EndPlaneReq",
})
end

function luaJM3UnlockPlanesSpawned(...)
	--luaLog("Unlockunits spawned")
	local nmi = {}

	for idx,unit in pairs(Mission.ExeterGroup,Mission.ExeterGroup) do
		if not unit.Dead then
			table.insert(nmi, unit)
		end
	end

	local trg = luaPickRnd(nmi)

	if trg and not trg.Dead then
		for i,v in ipairs(arg) do
			table.insert(Mission.UnlockPlanes, v)
			SetRoleAvailable(v, EROLF_ALL, PLAYER_AI)
			luaSetScriptTarget(v, trg)
			PilotSetTarget(v, trg)
		end
	end
	luaJM3StartDialog("Nells_Arrived",true)
end

function luaJM3CheckUnlockPlanes()
	if table.getn(luaRemoveDeadsFromTable(Mission.UnlockPlanes)) == 0 then
		return
	end
	for idx,unit in pairs(Mission.UnlockPlanes) do
		local ammo = GetProperty(unit, "ammoType")
		if ammo == 0 then
			PilotRetreat(unit)
			table.remove(Mission.UnlockPlanes, idx)
		end
		if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
			PilotRetreat(unit)
			table.remove(Mission.UnlockPlanes, idx)
		end
	end
end

function luaJM3AddMapListener()
	--luaLog("maplistener added")
	AddListener("gui", "IJN3MapListener", {
		["callback"] = "luaJM3OnMap",  -- callback fuggveny
		["guiName"] = {"GUI_Map"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
		["enter"] = {true}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
		})
		--luaJM5StartDialog("Map_hint1",true)
		--luaJM5ShowHintorDlg("Map_hint1",0,true)
end

function luaJM3FadeIn()
	--Loading_Finish()
	luaCheckSavedCheckpoint()
	--SoundFade(1, "",0.1)

-- RELEASE_LOGOFF  	luaLog(Mission.SavedCheckpoint)
	if Mission.SavedCheckpoint then
		luaJM3MakeFormation(Mission.IJNStageGroup2,1,false)
-- RELEASE_LOGOFF  		luaLog("YOU TAKE MY SELF CONTROL")
	else
		luaJM3MakeFormation(Mission.IJNStageGroup2,1,true)
		luaDelay(luaJM3Stage3Move,1)
-- RELEASE_LOGOFF  		luaLog("AI CONTROL AZZEG DE MIERT")
	end


	if not Mission.CheckpointLoaded then
		--[[luaDelay(luaJM3RndDlg1, random(300,360))
		luaDelay(luaJM3RndDlg2, random(240,260))
		luaDelay(luaJM3StartMsg, 6)
		luaDelay(luaJM3StepPhase, 15)
		luaJM3AddSpeedPowerUp()
		luaJM3AddRepairListener()]]
		Blackout(false, "", 1)
		RemoveStoredHint("BASICSHIP")
		ShowHintForced("BASICSHIP")
		luaDelay(luaJM3MasodikHint, 15)
		luaDelay(luaJM3RepairMicroTutorial, 20)
	else
		luaDelay(luaJM3RndDlg1, random(300,360))
		luaDelay(luaJM3RndDlg2, random(240,260))
		luaDelay(luaJM3StartMsg, 6)
		luaDelay(luaJM3HintHistoryHint, 30)
		--luaDelay(luaJM3StepPhase, 15)
		--luaJM3AddSpeedPowerUp()
		--luaJM3StepPhase()
	end

	luaJM3AddExeterListener()
	luaJM3AddCAListener()
	luaCheckMusic()
end

function luaJM3MasodikHint()
	RemoveStoredHint("BASICSHIP2")
	ShowHintForced("BASICSHIP2")
end

function luaJM3OnMap()
	--luaLog("onmap")
	if not Mission.MapHint2Done then
		luaJM3HideActHint()
		luaJM3MapHint2()
		--luaLog("Showhint MapHint2")
		Mission.MapHint2Done = true
	elseif not Mission.MapHint3Done then
		luaJM3HideActHint()
		luaJM3MapHint3()
		--luaLog("Showhint MapHint3")
		Mission.MapHint3Done = true
	elseif not Mission.MapHint4Done then
		luaJM3HideActHint()
		luaJM3MapHint4()
		--luaLog("Showhint MapHint4")
		Mission.MapHint4Done = true
	elseif not Mission.MapHint5Done then
		luaJM3HideActHint()
		luaJM3MapHint5()
		--luaLog("Showhint MapHint5")
		Mission.MapHint5Done = true
	else
		RemoveListener("gui", "IJN3MapListener")
		--luaLog("Removing map listener")
	end

end

function luaJM3MapHint1()
	--local str = "HINT: Press <back button icon> to enter the map screen."
	--MissionNarrativeUrgent(str)
	--luaJM5ShowHintorDlg("IJN05_Hint04",1)
	if not IsGUIActive("GUI_map") then
		ShowHint("IJN05_Hint04")
		--table.insert(Mission.HintsShowed, "IJN05_Hint04")
	end
end

function luaJM3MapHint2()
	--local str = "HINT: The light areas of the map are within visual range of your units, the green areas are within sonar range (the only way to detect submerged submarines), everything else is covered by radar and shows only the enemy presence not their composition.<LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint05")
end

function luaJM3MapHint3()
	--local str = "HINT: <LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint06")
end

function luaJM3MapHint4()
	--local str = "HINT: Move the crosshair over a unit to see its details. Use the d-pad as normal to cycle through your own units or press <A button icon> to select a friendly unit under the crosshair. Pressing <A button icon> or <Y button icon> while over an enemy unit will order the currently selected friendly unit to attack that enemy unit.Press <Y button icon> while the crosshair is over empty ocean or sky to set that point as a destination for your currently selected unit. Press <Y button icon> while the crosshair is over a friendly unit to follow that unit with your currently selected unit (this causes a ship to join a formation).Press <B button icon> to cancel orders."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint07")
end

function luaJM3MapHint5()
	--local str = "HINT: Y - select unit A - issue order B - cancel order LB - objectives menu"
	--MissionNarrativeUrgent(str)
	ShowHint("IJN05_Hint08")
end

function luaJM3RemoveRetreaters(tbl)
	local newTbl = {}
	for idx,unit in pairs(tbl) do
		if not unit.Dead and not unit.retreating then
			table.insert(newTbl, unit)
			--luaLog("inserting "..unit.Name.." to new tbl")
		--else
			--luaLog(unit.Name.." is retreating or dead")
		end
	end
	return newTbl
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(166)
	PrepareClass(162)
	PrepareClass(150)
	PrepareClass(113)
	Loading_Finish()
end

function luaJm3EfxOnCleveland()
	Effect("GiantSmoke", ORIGO, Mission.Cleveland)
end

function luaJM3SetGuiNames()
	--luaLog("allitom a guineveket")

	for idx, unit in pairs(Mission.JAPDDs) do
		SetGuiName(unit, Mission.Names.JAP.Fubuki[idx])
	end

	for idx, unit in pairs(Mission.JapTransports) do
		SetGuiName(unit, Mission.Names.JAP.Transports[idx])
	end

	for idx, unit in pairs(Mission.USNDDs) do
		SetGuiName(unit, Mission.Names.USN.Clemson[idx])
	end

end

function luaJM3SeaPlaneHint()
	local str = "HINT: felküldhetõ seaplane"
	MissionNarrativeUrgent(str)
end

function luaJM3BinocHint()
	--local str = "HINT: Click in <right stick icon> to access binoculars, click in <right stick icon> again to leave binocular view. While in binocular view press <Y button icon> to zoom in and <B button icon> to zoom out."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN03_Hint01")
end

function luaJM3ShipHint()
	local str = "HINT: Use up and down on <left stick icon> to set your speed and left and right to set your heading.Move the <right stick icon> to look around. Press <LT icon> to cycle through your weapons. When the target under your crosshair is in range the [reload and range] icon will turn yellow as the guns move into position then green. Press <RT icon> to fire your weapon when the [reload and range] icon is green. A flashing [reload and range] icon indicates the weapon is reloading."
	MissionNarrativeUrgent(str)
end

function luaJM3RndDlg1()
	luaJM3StartDialog("Radio3",true)
end

function luaJM3RndDlg2()
	luaJM3StartDialog("Radio4",true)
end

function luaJM3TransportsMove()
	local leader = GetFormationLeader(Mission.JapTransports[1])
	NavigatorMoveOnPath(leader, FindEntity("IJNAKPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
end

function luaJM3SupportsMove()
	local leader = GetFormationLeader(Mission.JapSupports[1])
	NavigatorMoveOnPath(leader, FindEntity("IJNSupportGroupPath"))
end

function luaJM3Stage1Move()
	local leader = GetFormationLeader(Mission.IJNStageGroup1[1])
	NavigatorMoveOnPath(leader, FindEntity("IJNCAStagePath"))
end

function luaJM3Stage2Move()
	NavigatorMoveOnPath(Mission.DeRuyter, FindEntity("USNCAStagePath"))
end

function luaJM3Stage3Move()
	local leader = GetFormationLeader(Mission.IJNStageGroup2[1])
	NavigatorMoveToRange(leader, FindEntity("DDNavpoint 01"))
end

function luaJM3Stage4Move()
	local leader = GetFormationLeader(Mission.USNStageGroup2[1])
	NavigatorMoveToRange(leader, FindEntity("DDNavpoint 01"))
end

function luaJM3Stage5Move()
	local leader = GetFormationLeader(Mission.ExeterDecoy[1])
	NavigatorMoveOnPath(leader, FindEntity("IJNExeterPath"))
end

function luaJM3Stage6Move()
	local leader = GetFormationLeader(Mission.ExeterGroup[1])
	--luaLog("LEADER")
	--luaLog(GetGuiName(leader))
	NavigatorMoveOnPath(leader, FindEntity("ExeterPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
end

function luaJM3Stage7Move()
	local leader = GetFormationLeader(Mission.USNDDGroup[1])
	NavigatorAttackMove(leader, Mission.PlayerUnits[1], {})
end

function luaJM3DeRuyterCamStart(ship)
	Mission.CamScript = luaCamOnTargetFree(ship, 10, 60, 300, false, "noupdate", 0, luaJM3DeRuyterCam)
	--Blackout(false, "luaJM3DeRuyterCam",1)
end

function luaJM3DeRuyterCam()
	--SetInvincible(Mission.DeRuyter, false)
	--AddDamage(Mission.DeRuyter, 999999)
	luaObj_Completed("primary",3,true)
	luaJM3StartDialog("Radio1",true)
	if IsListenerActive("kill", "drCam") then
		RemoveListener("kill", "drCam")
	end
	--luaJM3StepPhase()
end

function luaJM3DeRuyterCamEnd()
	--Blackout(true, "luaJM3ReselectPlayer", 1)
	EnableInput(true)
	SetSelectedUnit(Mission.PlayerUnit)
	luaJM3StepPhase()
	--Blackout(false, "luaJM3StepPhase", 1)
end

function luaJM3Final()
	Mission.EndMission = true
	HideScoreDisplay(3,0)
	--luaLog("hidescore 3")
	luaJM3StepPhase()
	luaMissionCompletedNew(nil, "ijn03.obj_missioncompleted", nil)
end

function luaJM3ExeterCamStart()
	Mission.CamScript = luaCamOnTargetFree(Mission.Exeter, 10, 60, 300, false, "noupdate", 0, luaJM3ExeterCam)
	--Blackout(false, "luaJM3DeRuyterCam",1)
end

function luaJM3ExeterCam()
	SetInvincible(Mission.Exeter, false)
	AddDamage(Mission.Exeter, 99999)
	--luaObj_Completed("secondary",1,true)
	--luaJM3AddPowerUp("hardened_armour")
	luaJM3StartDialog("ExeterSunken",true)
end

function luaJM3ExeterCamEnd()
	--Blackout(true, "luaJM3ReselectPlayer", 1)
	EnableInput(true)
	SetSelectedUnit(Mission.PlayerUnit)
	--luaJM3StepPhase()
	--Blackout(false, "luaJM3StepPhase", 1)
end

function luaJM3DeRuyterCamListener()
	if Mission.DeRuyter and not Mission.DeRuyter.Dead then
		AddListener("kill", "drCam", {
			["callback"] = "luaJM3DeRuyterCamListenerCB",  -- callback fuggveny
			["entity"] = {Mission.DeRuyter}, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			})
	end
end

function luaJM3DeRuyterCamListenerCB()
	--Mission.LastDeadFromDeRuyterGroup = unit
	luaJM3StartDialog("Radio1")

	if IsListenerActive("kill", "drCam") then
		RemoveListener("kill", "drCam")
	end

end


function luaJM3EndCamListener()
	Mission.ExeterGroup = luaRemoveDeadsFromTable(Mission.ExeterGroup)

	AddListener("kill", "endCam", {
		["callback"] = "luaJM3EndCamListenerCB",  -- callback fuggveny
		["entity"] = Mission.ExeterGroup, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM3EndCamListenerCB(unit)
	Mission.LastDead = unit
end


-------------moviez----------------------
function luaJM3MovieInit()
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, 0.1)
	end
end

function luaJM3SelectUnit()
	Blackout(true, "luaJM3SelUnit", 0.5)
end

function luaJM3SelUnit()
	Blackout(false, "", 0.5)
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end
	EnableInput(true)
end

function luaJM3RemoveInvFromMovieUnit()
	local movieUnit = FindEntity("Fubuki-class 07")
	if movieUnit and not movieUnit.Dead then
		if IsInvincible(movieUnit) then
			SetInvincible(movieUnit, false)
		end
	end
end

--------------------moviez-----------------------

function luaJM3DDMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM3MovieInit()
	luaIngameMovie(
		{
		 {["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=9.5164489746094,["y"]=3.351701259613,["z"]=70.146362304688},["parent"] = FindEntity("Clemson-class 03"),},["moveTime"] = 0,["transformtype"] = "keepnone",},
		 {["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=60.608520507813,["y"]=4.4714579582214,["z"]=318.57684326172},["parent"] = FindEntity("Clemson-class 04"),},["moveTime"] = 8,["transformtype"] = "keepnone", ["zoom"] = 1.5},
		}, luaJM3SelectUnit, true)
end

function luaJM3DDTroubleMovie()
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM3MovieInit()
	luaIngameMovie(
		{
		  {["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=3,["z"]=40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 0,["transformtype"] = "keepall", ["zoom"] = 2},
		  {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 0,["transformtype"] = "keepall", ["zoom"] = 2},

		  {["postype"] = "camera",["position"] = {["pos"] = {["x"]=120,["y"]=10,["z"]=40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 2,["transformtype"] = "keepall", ["zoom"] = 2},
		  {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 2,["transformtype"] = "keepall", ["zoom"] = 2},

		  --{["postype"] = "camera",["position"] = {["pos"] = {["x"]=120,["y"]=10,["z"]=-40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 2,["transformtype"] = "keepall",},
		  ---{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=-40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 0.1,["transformtype"] = "keepall",},

			{["postype"] = "cameraandtarget", ["position"] = {}, ["moveTime"] = 0, ["transformtype"] = "keepall",},

			{["postype"] = "camera",["position"] = {["pos"] = {["x"]=120,["y"]=3,["z"]=-40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 2,["transformtype"] = "keepall", ["zoom"] = 2},
		  {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=-40},["parent"] = FindEntity("Fubuki-class 07"),},["moveTime"] = 2,["transformtype"] = "keepall", ["zoom"] = 2},


		}, luaJM3SelectUnit, true, 6)
		luaDelay(luaJM3RemoveInvFromMovieUnit, 8)
end

function luaJM3DeruyterMovie(unit)
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM3MovieInit()
	luaIngameMovie(
		{
		  {["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=119.55883789063,["y"]=3.0278685092926,["z"]=35.539184570313},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 0,["transformtype"] = "keepnone",},

		  {["postype"] = "camera",["position"] = {["pos"] = {["x"]=10,["y"]=35,["z"]=60},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 5,["transformtype"] = "keepall",},
		  {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=60},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 5,["transformtype"] = "keepall",},

		}, luaJM3DeruyterMovie2, true, 4)
end

function luaJM3DeruyterMovie2()
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM3MovieInit()

	luaIngameMovie(
		{
			--{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=24.82275390625,["y"]=79.588317871094,["z"]=66.507568359375},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 0.09,["transformtype"] = "keepnone",},
			{["postype"] = "camera",["position"] = {["pos"] = {["x"]=10,["y"]=40,["z"]=70},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 0.09,["transformtype"] = "keepall",},
		  {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=70},["parent"] = FindEntity("DeRuyter-class 01"),},["moveTime"] = 0.09,["transformtype"] = "keepall",},

		  {["postype"] = "cameraandtarget", ["position"] = {}, ["moveTime"] = 0, ["transformtype"] = "keepall",},
		}, luaJM3SelectUnit, true, 6)

end

function luaJM3ExeterMovie(unit)
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM3MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 100, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 10, ["zoom"] = 1.5},
		}, luaJM3SelectUnit, true)
end

function luaJM3SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	Mission.Checkpoint.DDRegroupDone = Mission.DDRegroupDone
	Mission.Checkpoint.Chkp1Saved = Mission.Chkp1Saved
end

function luaJM3LoadMissionData()
	MissionNarrativeClear()
	ForceEnableInput(IC_SHIP_LAUNCHUNIT, true)

	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.DDRegroupDone = Mission.Checkpoint.DDRegroupDone
	Mission.Chkp1Saved = Mission.Checkpoint.Chkp1Saved

	Mission.EnemyShips = luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.USNStageGroup1, Mission.USNStageGroup2, Mission.ExeterGroup))
	for i,v in pairs(Mission.EnemyShips) do
		luaObj_AddUnit("primary",2,v)
	end

	if Mission.Cleveland and not Mission.Cleveland.Dead then
		if luaObj_IsActive("secondary",2) then
			luaObj_AddUnit("secondary",2,Mission.Cleveland)
		end
	end
	--SetSelectedUnit(FindEntity("Mogami-class 01"))
	luaDelay(luaJM3Restore, 1)
end

function luaJM3LoadBlackout()
	Blackout(true, "", 0)
	luaJM3LoadMissionData()
end

function luaJM3Restore()
	luaJM3RestoreUnits(num)
end

function luaJM3RestoreUnits(chkPointNum)

	local usnunits = luaGetCheckpointData("Units", "USUnits")
	local ijnunits = luaGetCheckpointData("Units", "JapUnits")

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNUnits)) do
		local found = false
		for idx2,unitTbl in pairs(ijnunits[1]) do
			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNUnits)) do
		local found = false
		for idx2,unitTbl in pairs(usnunits[1]) do
			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	Mission.IJNUnits = luaRemoveDeadsFromTable(Mission.IJNUnits)
	Mission.USNUnits = luaRemoveDeadsFromTable(Mission.USNUnits)

	luaDelay(luaJM3ArrabbBaszo, 1)
end

function luaJM3ArrabbBaszo()
	for i,v in pairs(Mission.Checkpoint.Units.JapUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end

	for i,v in pairs(Mission.Checkpoint.Units.USUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.IJNStageGroup2)) > 0 and not Mission.DDRegroupDone then
		luaJM3StartDialog("DDsReGrouping",true)
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNStageGroup2)) do
			local leader = GetSelectedUnit()
			if not leader or leader.Dead then
				leader = Mission.PlayerUnits[1]
			end
			if IsInFormation(unit) then
				DisbandFormation(unit)
			end
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
			JoinFormation(unit, leader)
		end
		Mission.DDRegroupDone = true
	end

	Blackout(false, "", 2)
end

function luaJM3PutUnits(timerThis)

-- RELEASE_LOGOFF  	luaLog("Enemy ships")
-- RELEASE_LOGOFF  	luaLog(Mission.EnemyShips)
	--luaLog(timerThis.ParamTable.lookAt)

	local leader = timerThis.ParamTable.leader
	local unitTbl = timerThis.ParamTable.unitTbl
	local navPoint = timerThis.ParamTable.navPoint
	local angle = luaGetAngle("world", navPoint, timerThis.ParamTable.lookAt)


	--luaLog("------------------")
	--luaLog(leader)
	--luaLog(navPoint)
	--luaLog(angle)
	--luaLog(-angle)
	--luaLog("------------------")

	if leader and not leader.Dead then
		PutTo(leader, navPoint, -angle)
	end

--[[	local i = 1
	local x = 100
	local z = -100
	local multi = {[1] = 1, [2] = -1,}

	for idx,unit in pairs(unitTbl) do

		if unit and not unit.Dead and unit.ID ~= leader.ID then
			--luaLog("unit: "..unit.Name)
			if IsInFormation(unit) then
				LeaveFormation(unit)
			end

			local relTbl = {
				["x"] = x * i * multi[math.fmod(i,2)+1],
				["y"] = 0,
				["z"] = z * i,
			}

			if unit and leader and not unit.Dead and not leader.Dead then
				PutRelTo(unit, leader, relTbl)
				JoinFormation(unit, leader)
				i = i + 1
			end
		end
	end]]

end

function killemall()
	if Mission.Debug then
			for i,v in pairs(Mission.USNDDGroup) do
				Kill(v)
			end
	luaDelay(killemall2, 30)
	end
end

function killemall2()
	for i,v in pairs(Mission.USNStageGroup2) do
		Kill(v)
	end
end

function luaJM3PowerUpHint()
	ShowHint("PUM1STGET")
end

function luaJM3HintHistoryHint()
	ShowHint("Advanced_Hint_Hinthistory")
end

function luaJM3AddOwnDamageListener()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		AddListener("hit", "ownHitListener", {
				["callback"] = "luaJM3OwnDamageListenerCB", -- callback fuggveny
				["target"] = {Mission.PlayerUnit}, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {}, -- tamado entityk
				["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end
end

function luaJM3OwnDamageListenerCB()
	RemoveListener("hit","ownHitListener")
	ShowHint("REPPERMANENT")
end

function luaJM3CrossHairHint()
	ShowHint("Advanced_Hint_Crosshair")
end

function luaJM3TurnHint()
	ShowHint("Advanced_Hint_Turn")
end

function luaJM3MapHint1CleanUp()
	luaJM3HideActHint()
	luaJM3MapHint1()
end

function luaJM3HideActHint()
	local hintTbl = IsHintActive()

	if hintTbl then
		if not IsHintCritical(hintTbl.HintID) then
			HideHint()
		else
			--luaLog("Cant hide hints cos its critical")
		end
	end

end

function luaJM3AddRepairListener()
	--SetFailure(Mission.PlayerUnit, "EngineJam")
	--RepairEnable(Mission.PlayerUnit, false)

	AddListener("repair", "repairListener", {
		["callback"] = "luaJM3RepairPressed",  -- callback fuggveny
		["entity"] = {Mission.PlayerUnit}, -- entityk akiken a listener aktiv
		["repairSetting"] = {}, -- 1-Fire, 2-Pump, 3-Failure, 4-Armament ("" jel nelkul)
	})

end

function luaJM3RepairPressed(...)

	if arg[2] == 1 then
		RemoveListener("repair", "repairListener")
		--luaJM3StartDialog("RepairCompleted")
		FailureRepairEnable(Mission.PlayerUnit, true)
		luaDelay(luaJM3RepairCompleted, 4)
	end
end

function luaJM3RepairMicroTutorial()
	--luaJM3AddRepairListener()
	luaJM3StartDialog("Intro")
	luaJM3StartDialog("RepairTutorial1")
end

function luaJM3RepairMicroTutorial2()
	SetFailure(Mission.PlayerUnit, "EngineJam", 10)
	FailureRepairEnable(Mission.PlayerUnit, false)
	luaDelay(luaJM3DelayedSlowingDownDialogueOhWaitThisFunctionNameIsTheLongestInAllOfTheMissionScriptsIThinkAndItsTrue, 2)
end

function luaJM3RepairDialogEnd()
	if not luaObj_IsActive("primary",5) then
		luaObj_Add("primary",5)
		luaJM3AddRepairListener()
		--luaDelay(luaJM3NeszeHint, 2)
		DisplayScores(666,0,"ijn03.obj_p5", "ijn03.repair_bubbletext2")
		if IsGUIActive("GUI_repair") ~= true then
			ShowHint("IJN03_Hint02")
			AddListener("gui", "listenerID", {
				["callback"] = "luaJM3HideRepairHint",  -- callback fuggveny
				["guiName"] = {"GUI_repair"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
				["enter"] = {true}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
			})
		end
	end
end

function luaJM3HideRepairHint()
	--RepairEnable(Mission.PlayerUnit, true)
	RemoveListener("gui", "listenerID")
	HideHint()
	luaJM3NeszeHint()
	--ShowHint("REPPERMANENT")
end

function luaJM3RepairCompleted()
	--ClearFailure(Mission.PlayerUnit, "EngineJam")
	--ClearAllShipFailure(Mission.PlayerUnit)
	luaJM3StartDialog("RepairCompleted")
	if luaObj_IsActive("primary",5) and luaObj_GetSuccess("primary",5) == nil then
		HideScoreDisplay(666,0)
		luaObj_Completed("primary",5)
		StopEffect(Mission.FX.Pointer)
		luaDelay(luaJM3HintHistoryHint, 30)
		ForceEnableInput(IC_SHIP_LAUNCHUNIT, true)
		--luaJM3StepPhase()
	end
end

function luaJM3DelayedFailure()
	luaDelay(luaJM3RepairMicroTutorial2, 5)
end

function luaJM3DelayedSlowingDownDialogueOhWaitThisFunctionNameIsTheLongestInAllOfTheMissionScriptsIThinkAndItsTrue()
	luaJM3StartDialog("RepairTutorial2")
	Mission.FX = Effect("GiantSmoke", ORIGO, Mission.PlayerUnit)
end

function luaJM3NeszeHint()
	--luaLog("hint itt")
	--ShowHintForced("IJN03_REPAIR1STUSE_CLONE")
	RemoveStoredHint("REPAIR1STUSE")
	ShowHint("REPAIR1STUSE")
end

function luaJM3StoreHints()
	AddStoredHint("BASICSHIP")
	AddStoredHint("BASICSHIP2")
	AddStoredHint("REPAIR1STUSE")
end