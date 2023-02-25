--SceneFile="universe\Scenes\missions\IJN\ijn_06_prelude_to_midway.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",6)

	Dialogues =
	{
		["Intro_A"] = {
			["sequence"] = {
				--[[
				{
					["message"] = "Submarine captains, it is now us, who really matter in the chain of events.",--"Idlg1a",
				},]]
				{
					["message"] = "Idlg01a",
				},
			},
		},

		["Intro_B"] = {
			["sequence"] = {
				{
				--[[
				{

					["message"] = "A torpedo here is a spark to feed a conflagration.",--"Idlg1b",
				},]]

					["message"] = "Idlg01b",
				},
			},
		},

		["Intro_C"] = {
			["sequence"] = {
				--[[
				{
					["message"] = "Bring the burning Hell upon them!"--"Idlg1c",
				},]]
				{
					["message"] = "Idlg01c",
				},
			},
		},


	}

	MissionNarrative("ijn06.date_location")
	luaDelay(luaEngineInit1, 14, "")
end

function luaEngineInit1()
StartDialog("Intro_dlg1", Dialogues["Intro_A"] );
luaDelay(luaEngineInit2, 9, "")
end

function luaEngineInit2()
StartDialog("Intro_dlg2", Dialogues["Intro_B"] );
luaDelay(luaEngineInit3, 8, "")
end

function luaEngineInit3()
StartDialog("Intro_dlg3", Dialogues["Intro_C"] );
end

function luaStageInitMulti()
	--luaLog("belefut1")
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM6")
	Scoring_RealPlayTimeRunning(true)
end

--ToDos
--random levego ai suboknak
function luaInitJM6(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM06.lua"

	this.Name = "JM6"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.ShipsToSink = 2
	elseif Mission.Difficulty == 1 then
		Mission.ShipsToSink = 3
	elseif Mission.Difficulty == 2 then
		Mission.ShipsToSink = 5
	end

	Mission.Escorts = {}

	Mission.EscortTemplate = {}
		table.insert(Mission.EscortTemplate, luaFindHidden("Fletcher-class 01"))
		table.insert(Mission.EscortTemplate, luaFindHidden("Fletcher-class 02"))
		table.insert(Mission.EscortTemplate, luaFindHidden("Fletcher-class 03"))
		table.insert(Mission.EscortTemplate, luaFindHidden("Fletcher-class 04"))
		table.insert(Mission.EscortTemplate, luaFindHidden("Fletcher-class 05"))

	Mission.Catalina = FindEntity("PBY Catalina 01")
	PilotMoveOnPath(Mission.Catalina, FindEntity("CatalinaPatrolPath"))

	Mission.HideZone = {}
		table.insert(Mission.HideZone, GetPosition(FindEntity("Navpoint 01")))
		table.insert(Mission.HideZone, GetPosition(FindEntity("Navpoint 02")))

	--[[Mission.PtPatrols = {}
		table.insert(Mission.PtPatrols, FindEntity("PT Boat 80' Elco 01"))
		table.insert(Mission.PtPatrols, FindEntity("PT Boat 80' Elco 02"))
		table.insert(Mission.PtPatrols, FindEntity("PT Boat 80' Elco 03"))
		table.insert(Mission.PtPatrols, FindEntity("PT Boat 80' Elco 04"))
		for idx,unit in pairs(Mission.PtPatrols) do
			local path
			if idx <= 2 then
				path = FindEntity("PTPatrolPath01")
			else
				path = FindEntity("PTPatrolPath02")
			end
			unit.pathID = path.ID
			NavigatorMoveOnPath(unit, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(5,10))
		end]]--

	Mission.MaxAttackingPts = 2
	Mission.SurfaceTime = 60
	Mission.TorpPoint = FindEntity("TorpPoint")
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("US Tanker 02")) --leader
		table.insert(Mission.Cargos, FindEntity("US Tanker 01"))
		table.insert(Mission.Cargos, FindEntity("US Tanker 03"))
		table.insert(Mission.Cargos, FindEntity("Hospital Ship 01"))
		table.insert(Mission.Cargos, FindEntity("USTroopTransport 01"))
		table.insert(Mission.Cargos, FindEntity("US Cargo Transport 01"))
		table.insert(Mission.Cargos, FindEntity("USTroopTransport 04"))
		table.insert(Mission.Cargos, FindEntity("USTroopTransport 02"))
		table.insert(Mission.Cargos, FindEntity("USTroopTransport 03"))
		table.insert(Mission.Cargos, FindEntity("US Cargo Transport 02"))
		--table.insert(Mission.Cargos, FindEntity("Landing Ship, Tank 01"))
		--table.insert(Mission.Cargos, FindEntity("Landing Ship, Tank 02"))
		for idx,unit in pairs(Mission.Cargos) do
			if Mission.Difficulty <= 1 then
				NavigatorSetTorpedoEvasion(unit, false)
			else
				NavigatorSetTorpedoEvasion(unit, true)
			end
			SetSkillLevel(unit, SKILL_STUN)
			if idx ~= 1 then
				JoinFormation(unit, Mission.Cargos[1])
			end
		end
		NavigatorMoveOnPath(Mission.Cargos[1],FindEntity("TransportPath 01"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.Hospital = FindEntity("Hospital Ship 01")

		Mission.CargoNum = table.getn(Mission.Cargos)

	Mission.CargoEscort = {}
		--[[table.insert(Mission.CargoEscort, FindEntity("Atlanta-class 01"))		--TransportPath 01
		NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 01"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 01").ID
		table.insert(Mission.CargoEscort, FindEntity("Fletcher-class 06"))  --TransportPath 03
		NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 03"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 03").ID
		table.insert(Mission.CargoEscort, FindEntity("Fletcher-class 07"))	--TransportPath 03
		NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 03"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 03").ID]]--
		table.insert(Mission.CargoEscort, FindEntity("Fletcher-class 08"))	--TransportPath 02
		NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 02"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 02").ID
		table.insert(Mission.CargoEscort, FindEntity("Fletcher-class 09"))	--TransportPath 02
		NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 02"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 02").ID
		--table.insert(Mission.CargoEscort, FindEntity("Fletcher-class 10"))	--TransportPath 01
		--NavigatorMoveOnPath(Mission.CargoEscort[table.getn(Mission.CargoEscort)], FindEntity("TransportPath 01"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
		--Mission.CargoEscort[table.getn(Mission.CargoEscort)].pathID = FindEntity("TransportPath 01").ID

		for i,v in pairs(Mission.CargoEscort) do
			if Mission.Difficulty <=1 then
				NavigatorSetTorpedoEvasion(v, false)
				SetSkillLevel(v, SKILL_STUN)
			else
				NavigatorSetTorpedoEvasion(v, true)
				SetSkillLevel(v, SKILL_SPNORMAL)
			end
		end

	Mission.USNSubs = {}
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 01"))
		TorpedoEnable(Mission.USNSubs[1], true)

		
		if Mission.Difficulty == 2 then
			table.insert(Mission.USNSubs, FindEntity("Gato-class Submarine 01"))
			NavigatorMoveOnPath(Mission.USNSubs[2], FindEntity("USNSubPath"))
			TorpedoEnable(Mission.USNSubs[2], true)
		else
			Kill(FindEntity("Gato-class Submarine 01"), true)
		end

	Mission.IJNSubsGrp1 = {}
		table.insert(Mission.IJNSubsGrp1, FindEntity("PlayerSub 01"))
		table.insert(Mission.IJNSubsGrp1, FindEntity("PlayerSub 02"))
		table.insert(Mission.IJNSubsGrp1, FindEntity("PlayerSub 03"))
		for idx,unit in pairs(Mission.IJNSubsGrp1) do
			if idx ~= 1 then
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				--NavigatorMoveOnPath(unit, FindEntity("IJNSubPath1"), PATH_FM_SIMPLE, PATH_SM_JOIN)
				SetUnlimitedAirSupply(unit, true)
			end
			luaJM6SubInit({unit})
			TorpedoEnable(unit, true)

		end

	--[[Mission.IJNSubsGrp2 = {}
		table.insert(Mission.IJNSubsGrp2, FindEntity("Submarine TypeB w Jake 04"))
		table.insert(Mission.IJNSubsGrp2, FindEntity("Submarine TypeB w Jake 05"))
		table.insert(Mission.IJNSubsGrp2, FindEntity("Submarine TypeB w Jake 06"))
		for idx,unit in pairs(Mission.IJNSubsGrp2) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			SetSkillLevel(unit, SKILL_SPVETERAN)
			SetUnlimitedAirSupply(unit, true)
			TorpedoEnable(unit, true)
		end

	Mission.IJNSubsGrp3 = {}
		table.insert(Mission.IJNSubsGrp3, FindEntity("Submarine TypeB w Jake 07"))
		table.insert(Mission.IJNSubsGrp3, FindEntity("Submarine TypeB w Jake 08"))
		table.insert(Mission.IJNSubsGrp3, FindEntity("Submarine TypeB w Jake 09"))
		for idx,unit in pairs(Mission.IJNSubsGrp3) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			SetUnlimitedAirSupply(unit, true)
			TorpedoEnable(unit, true)
		end]]--

	Mission.PlayerUnit = Mission.IJNSubsGrp1[1]
	--SetSubmarineDepthLevel(Mission.PlayerUnit, 1)

	Mission.JAPSubs = {}
		table.insert(Mission.JAPSubs, FindEntity("PlayerSub 01"))
		table.insert(Mission.JAPSubs, FindEntity("PlayerSub 02"))
		table.insert(Mission.JAPSubs, FindEntity("PlayerSub 03"))
		--[[table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 04"))
		table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 05"))
		table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 06"))
		table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 07"))
		table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 08"))
		table.insert(Mission.JAPSubs, FindEntity("Submarine TypeB w Jake 09"))]]--

	Mission.Names = {}
		Mission.Names.JAP = {}
			Mission.Names.JAP.Subs = {}
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.156"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.157"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.158"})
				--[[table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.159"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.121"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.122"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.123"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.162"})
				table.insert(Mission.Names.JAP.Subs, {"ingame.shipnames_i|.165"})]]--

			Mission.Names.JAP.YamatoScreen = {}
				table.insert(Mission.Names.JAP.YamatoScreen, {"ingame.shipnames_hatsuyuki"})
				table.insert(Mission.Names.JAP.YamatoScreen, {"ingame.shipnames_wakatsuki"})
				table.insert(Mission.Names.JAP.YamatoScreen, {"ingame.shipnames_akizuki"})


		Mission.Names.USN = {}
			Mission.Names.USN.CargoEscort = {}
				--table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_atlanta", 51}) 	--CL51
				--table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_phelps", 360})	--DD360
				--table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_worden", 352})	--DD352
				--table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_monaghan", 354})--DD354
				table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_aylwin", 355})	--DD355
				table.insert(Mission.Names.USN.CargoEscort, {"ingame.shipnames_balch", 363})		--DD363

			Mission.Names.USN.Subs = {}
				table.insert(Mission.Names.USN.Subs, {"ingame.shipnames_narwhal"}) --SC1
				table.insert(Mission.Names.USN.Subs, {"ingame.shipnames_gato"})	--SS212

			Mission.Names.USN.Cargos = {}
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_platte",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_cimarron",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_dewey",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_solace",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_skagit",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_libra",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_yancey",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_whiteside",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_todd",0})
				table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_medea",0})
				--table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_lst|.742",742})
				--table.insert(Mission.Names.USN.Cargos, {"ingame.shipnames_lst|.641",641})

			--[[Mission.Names.USN.Pts = {}
				table.insert(Mission.Names.USN.Pts, {"ingame.shipnames_pt|.140"})
				table.insert(Mission.Names.USN.Pts, {"ingame.shipnames_pt|.141"})
				table.insert(Mission.Names.USN.Pts, {"ingame.shipnames_pt|.142"})
				table.insert(Mission.Names.USN.Pts, {"ingame.shipnames_pt|.144"}) ]]--

			Mission.Names.USN.Escorts = {}
				table.insert(Mission.Names.USN.Escorts, {"ingame.shipnames_conyngham", 371})	--DD371
				table.insert(Mission.Names.USN.Escorts, {"ingame.shipnames_benham", 397})		--DD397
				table.insert(Mission.Names.USN.Escorts, {"ingame.shipnames_ellett", 398})			--DD398
				table.insert(Mission.Names.USN.Escorts, {"ingame.shipnames_maury", 16})			--AGS16
				table.insert(Mission.Names.USN.Escorts, {"ingame.shipnames_hughes", 410})		--DD410


			Mission.ReconPath = FindEntity("ReconPath")

	SetSelectedUnit(Mission.PlayerUnit)
	Mission.PlayerSpotted = false

	Mission.HiddenTimer = 300
	Mission.ReloadInProgress = false

	SetDeviceReloadEnabled(true)


	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM6LoadBlackout, luaJM6CheckI400, luaJM6GenerateUSNFleet},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM6SaveMissionData,},
	}


	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Ambush",
				["Text"] = "ijn06.obj_p1",--"Ambush",
				["TextCompleted"] = "ijn06.obj_p1_completed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[2] = {
				["ID"] = "Carrier",
				["Text"] = "ijn06.obj_p2", --"Torpedo the enemy carrier",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[3] = {
				["ID"] = "CallYama",
				["Text"] = "ijn06.obj_s3",
				["TextCompleted"] = "ijn06.obj_s3_completed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[4] = {
				["ID"] = "Carrier3",
				["Text"] = "ijn06.obj_p3",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			--[[[1] = {
				["ID"] = "Reconplane",
				["Text"] = "ijn06.obj_s1",
				["TextCompleted"] = "ijn06.obj_s1_completed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]--
			[2] = {
				["ID"] = "Catalina",
				["Text"] = "ijn06.obj_s2", --"Kill the enemy reconplane",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			--[[[3] = {
				["ID"] = "CallYama",
				["Text"] = "ijn06.obj_s3",
				["TextCompleted"] = "ijn06.obj_s3_completed" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "ijn06.obj_s3_failed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]--
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Detection",
				["Text"] = "ijn06.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		}
	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	this.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",--"Wolfpack leader: Enemy supply convoy is ahead. We all can have a fair share of fresh meat today.",
				},
				{
					["message"] = "dlg2",--"Wolfpack leader: Spread your torpedoes to cause the maximum possible destruction.",
				},
				--[[{
					["type"] = "callback",
					["callback"] = "luaJM6TorpedoDramaInit",
				},]]
			},
		},
		["CVSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg3",--"Sub captain: Enemy carrier sighted... Heading east... Destroyers for escort.",
				},
			},
		},
		["I400Spawn_A"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",--"I400 captain: I400 has entered the area. Hull is vulnerable, direct contact with the enemy recon holds a high risk.",
				},
				{
					["message"] = "dlg4a_1",--"I400 captain: I400 has entered the area. Hull is vulnerable, direct contact with the enemy recon holds a high risk.",
				},
			},
		},
		["I400Spawn_B"] = {
			["sequence"] = {
				{
					["message"] = "dlg4b",--"Wolfpack leader: Captain your task is to neutralize that reconplane!",
				},
			},
		},
		["Catalinadown_A"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",--"I400 captain: Good job, we're on our way up and got some spare torpedoes to reload the needy.",
				},
			},
		},
		["Catalinadown_B"] = {
			["sequence"] = {
				{
					["message"] = "dlg6b",--"Wolfpack leader: You all have heard it! Join our big brother if you want to be rearmed.",
				},
			},
		},
		["I400Airsupply"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",--"I400 captain: We're running out of air and have to emerge to recharge airsupply.",
				},
				{
					["message"] = "dlg7b",--"Take care, surfacing is always a dangerous thing to do.",
				},
			},
		},
		["I400Leaves"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",--"I400 captain: We've received new orders, I400 is leaving the area!",
				},
				{
					["message"] = "dlg8b",--"...And we thank you for your help. Have a safe trip.",
				},
			},
		},
		["I400Destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",--"I400 captain: Too many leaks, I400 goes down.",
				},
				{
					["message"] = "dlg9b",--"It's a critical wound to this operation.",
				},
			},
		},
		["CVHit_A"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",--"We got her, we got her!",
				},
			},
		},
		["CVHit_B"] = {
			["sequence"] = {
				{
					["message"] = "dlg10b",--"Torpedo hit confirmed.",
				},
			},
		},
		["YamatoRadio"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
				{
					["message"] = "dlg11_1",
				},
			},
		},
		["YamatoArrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",--"Admiral: Yamato is here!",
				},
				{
					["message"] = "dlg12b",--"AYour dish is prepared. Ittadakimasu!",
				},
			},
		},
		["IJNSubDead"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",--"Sub captain: <SHIPNAME> has suffered fatal hit, repeat, fatal hit!",
				},
			},
		},
		["USNSubDetected"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",--"Sub captain: We're not alone down here. US submarines creep around.",
				},
				{
					["message"] = "dlg14b",--"Proceed with caution.",
				},
			},
		},
		--new triggers
		["CatalinaReminder"] = {
			["sequence"] = {
				{
					["message"] = "dlg5", --Contacting I400 is still hindered by enemy recon. Destroy that plane!.
				},
			},
		},
		["HornetKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg15", --Looks like we don't need the help of the Yamato. Captain, you've just earned yourself some fame.
				},
			},
		},
		["Final"] = {
			["sequence"] = {
				{
					["message"] = "dlg16", --If not all, but we caught one of the American carriers. It may prove to be the edge we just need in the upcoming battle.
				},
			},
		},
		--nmi radio
		["NmiRadio1"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
			},
		},
		["NmiRadio2"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",--"Enemy captain: We've lost the hospital ship.",
				},
			},
		},
		["NmiRadio3"] = {
			["sequence"] = {
				{
					["message"] = "dlg19",--"There is a submarine nearby we spotted before. We're reconing the area and will attack if we get to see them again.",
				},
			},
		},
		["NmiRadio4"] = {
			["sequence"] = {
				{
					["message"] = "dlg20",--"A damned trap we've walked straight into... Why weren't we informed?... Intelligence, my ass...",
				},
			},
		},
		["NmiRadio5"] = {
			["sequence"] = {
				{
					["message"] = "dlg21",--"...This is a massacre...",
				},
			},
		},
		["PlayerHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg22a",
				},
				{
					["message"] = "dlg22b",
				},
			},
		},
		["Transmit"] = {
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
				{
					["message"] = "dlg23_1",
				},
			},
		},
		["Assist"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
			},
		},
		["RadioMessage"] = {
			["sequence"] = {
				{
					["message"] = "dlg25",
				},
				{
					["message"] = "dlg25_1",
				},
			},
		},
	}

	Mission.ReconIntroEnded = false

	LoadMessageMap("ijndlg",6)

	--luaJM6AddAirstrikePowerUp()

	-- music
	--SoundFade(0,"", 1) -- kell ez ide?
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	--inital liteners

	--luaJM6AddCVKillListener()
	luaJM6SetGuiNames()
	luaJM6PlayerHitListener()

	luaRemoveByName(Mission.Cargos, FindEntity("Hospital Ship 01").Name)

	Mission.CargoTargets = {}
		for i=1,Mission.ShipsToSink do
			local idx = random(1,table.getn(Mission.Cargos))
			table.insert(Mission.CargoTargets, Mission.Cargos[idx])
			table.remove(Mission.Cargos, idx)
		end

	--EnableInput(false)

	--luaDelay(luaJM6HiddenTimerEnd, Mission.HiddenTimer)

	Mission.ScoreDisplay = {}
	Mission.MissionPhase = 1
	Mission.SurfaceCounter = 0

-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
-- RELEASE_LOGOFF  	AddWatch("Mission.FleetSpotted")
-- RELEASE_LOGOFF  	AddWatch("Mission.USNFleetGenerated")

	--think
	luaJM6InitStoredHints()
	luaJM6FadeIn()

	SetThink(this, "luaJM6_think")

	Mission.Cheat_PhaseShift = false
end

function luaJM6_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.EndMission then
		return
	end

	luaCheckMusic()

	luaJM6CheckObjectives()

	luaJM6PlayerSubChecker()

	if Mission.ReconIntroEnded then
		luaJM6CheckCargoEscorts()
	end

	--luaJM6PeriscopeCheck()

	if Mission.IJNSubsGrp1[1] and not Mission.IJNSubsGrp1[1].Dead then
		if not Mission.TorpedoDrama then
			if Mission.FleetSpotted then
				luaJM6StartDialog("Init",true)
				Mission.TorpedoDrama = true
			end
		end
	end

	if Mission.MissionPhase == 1 then
	elseif Mission.MissionPhase == 2 then
		if Mission.USNFleetGenerated then
			luaJM6CheckCarrier()
			--luaJM6CheckI400()
		end
	elseif Mission.MissionPhase == 3 then
			--luaJM6CheckI400()
	elseif Mission.MissionPhase == 4 then
		if not Mission.JapFleetInit then
			luaJM6SpawnJapFleet()
			luaJM6SittingDucks()
		else
			if not Mission.YamatoMovieDone then
				luaJM6YamatoMovie(Mission.Yamato)
			end
			luaJM6LetsHitTheYamato()
		end

	end

	if Mission.MissionPhase < 99 then
		--luaJM6CheckPts()
		luaJM6CheckUSNSubs()
		luaJM6CheckIJNSubs()
		luaJM6CheckHiddenObj()
		luaJM6CatalinaObjChecker()
		--luaJM6CargoDlgs()
	end

end

function luaJM6IsInZone()
	if Mission.PlayerUnit.Dead then
		return
	end
	if luaIsInArea(Mission.HideZone, GetPosition(Mission.PlayerUnit)) then
		--if GetSubmarineDepthLevel(Mission.PlayerUnit) > 0 then
		if not GetSubmarineOnSurface(Mission.PlayerUnit) then
			return false
		else
			return true
		end
	else
		if luaJM6IsInRecon(Mission.PlayerUnit) then
			return true
		end
	end
end

function luaJM6CatalinaObjChecker()
	if Mission.Catalina2 and Mission.AmbushMovieDone then
		if not luaObj_IsActive("secondary",2) then
			luaObj_Add("secondary",2)
			--luaJM6Sec2Score()
			if not Mission.Catalina2.Dead then
				luaObj_AddUnit("secondary",2, Mission.Catalina2)
				luaDelay(luaJM6CatReminderDlg,60)
				--luaJumpinMovieSetCurrentMovie("LookAt",Mission.Catalina2.ID)
				--luaJM6CatalinaMovie(Mission.Catalina2)
			end
		else
			if luaObj_GetSuccess("secondary",2) == nil then
				if Mission.Catalina2.Dead and not Mission.I400Timer then
					luaObj_Completed("secondary",2)
					luaJM6StartDialog("Catalinadown_A",true)
					luaJM6StartDialog("Catalinadown_B",true)
					--HideUnitHp({Mission.Catalina2})
					--CountdownCancel()
					--luaJM6AddPowerup("playerspeedtest")
				elseif not Mission.Catalina2.Dead and Mission.I400Timer then
					luaObj_Failed("secondary",2)
					if not Mission.I400Gone then
						luaJM6StartDialog("I400Airsupply",true)
					end
				end
			end
		end
	end
end

function luaJM6CheckObjectives()
	if Mission.MissionPhase == 1 then

		if Mission.Hospital.Dead then
			luaJM6StartDialog("NmiRadio2",true)
		end

		if not luaObj_IsActive("primary",1) then
			if Mission.TorpedoDrama then
				luaObj_Add("primary",1,Mission.CargoTargets)
				luaJM6Pri1Score()
			end
		elseif luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			local exited
			if table.getn(luaRemoveDeadsFromTable(Mission.CargoTargets)) == 0 then
				for i,v in pairs(Mission.CargoTargets) do
					if v.KillReason == "exitzone" then
						exited = true
					end
				end

				if not exited then
					luaObj_Completed("primary",1,true)
					luaJM6CheckI400()
					luaJM6GenerateUSNFleet()
					luaJM6RemoveScore(1)
					luaJM6AddPowerup("automatic_reloader")
					luaJM6AddPowerup("improved_ship_manoeuvreability")
					Blackout(true, "luaJM6ConvoyDestroyedMovie", 1)
				else
					Mission.FailMsg = "usn01.obj_p3_fail2"
					Mission.MissionFailed = true
					luaJM6StepPhase(99)
				end
			else
				luaJM6Pri1Score()
			end
		end

	elseif Mission.MissionPhase == 2 then
		if not Mission.FirstRun then
			--luaJM6GenerateUSNFleet()
			--luaJM6CVListener()
			--luaJM6StartDialog("CVSpotted",true)
			--luaJM6LexMovie(Mission.Lex)
			Mission.FirstRun = true
		end

		if not luaObj_IsActive("primary",3) and Mission.AmbushMovieDone then
			luaObj_Add("primary",3)
		elseif luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
			if Mission.MessageTransmitted then
				luaObj_Completed("primary",3,true)
				luaJM6StartDialog("YamatoRadio",true)
				luaJM6StepPhase()
			else
				luaJM6CheckSurface()
				luaDelay(luaJM6SafeHint, 10)
				--luaJM6StepPhase()
			end
		end

	elseif Mission.MissionPhase == 3 then
		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2,Mission.Lex)
			luaJM6Pri2Score()
		elseif luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
			if Mission.CVHitByPlayer then
				luaObj_Completed("primary",2,true)
				luaJM6StartDialog("CVHit_A",true)
				luaJM6StartDialog("CVHit_B",true)
				luaJM6RemoveScore(2)
				luaJM6StepPhase()
			end
		end
	elseif Mission.MissionPhase == 4 then
		if not luaObj_IsActive("primary",4) then
			luaObj_Add("primary",4)
			luaJM6Pri3Score()
			for i,v in pairs(luaRemoveDeadsFromTable(Mission.Escorts)) do
				luaObj_AddUnit("primary",4,v)
			end

			if Mission.Lex and not Mission.Lex.Dead then
				luaObj_AddUnit("primary",4,Mission.Lex)
			end

		elseif luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) == 0 and Mission.Lex.Dead then
				luaObj_Completed("primary",4)
				Mission.MissionCompleted = true
				luaJM6StepPhase(99)
			else
				luaJM6Pri3Score()
			end
		end
	elseif Mission.MissionPhase == 99 then
		if Mission.MissionCompleted then
			luaJM6StartDialog("Final",true)
			luaDelay(luaJM6FinishMission, 8)
			luaJM6StepPhase(100)
		elseif Mission.MissionFailed then
			local banto = Mission.PlayerUnit.LastBanto

			if not banto or not luaIsEntityOrCoordinateTable({banto}) or banto.Dead then
				banto = nil
			end

			luaMissionFailedNew(banto, Mission.FailMsg)
			Mission.EndMission = true
			luaJM6StepPhase(100)
		end
	end
end

function luaJM6FinishMission()
	if not TrulyDead(Mission.Yamato) then
		Mission.EndMission = true
		luaMissionCompletedNew(Mission.Yamato, "ijn06.obj_missioncompleted")
	else
		Mission.EndMission = true
		luaMissionCompletedNew(Mission.PlayerUnit, "ijn06.obj_missioncompleted")
	end

	local medal = luaGetMedalReward()
	if medal == MEDAL_SILVER then
		Scoring_GrantBonus("JM6_SCORING_SILVER", "ijn06.bonus1_title", "ijn06.bonus1_text", "globals.powerup_active_improved_shells_name")
	elseif medal == MEDAL_GOLD then
		Scoring_GrantBonus("JM6_SCORING_SILVER", "ijn06.bonus1_title", "ijn06.bonus1_text", "globals.powerup_active_improved_shells_name")
		Scoring_GrantBonus("JM6_SCORING_GOLD", "ijn06.bonus2_title", "ijn06.bonus2_text", 93)
	end

end

function luaJM6StepPhase(phase)
-- RELEASE_LOGOFF  	luaLog("phase shift: "..debug.traceback())

	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM6CheckCarrier()
	local spotted_units = luaJM6AiSubSpotted()
	local nearestDD
	local nearestTrg
	Mission.PlayerSpotted = luaJM6IsInZone()
	Mission.Escorts = luaRemoveDeadsFromTable(Mission.Escorts)

	if Mission.PlayerSpotted then
		table.insert(spotted_units, Mission.PlayerUnit)
	end

	if table.getn(spotted_units) > 0 then
		--Carrier
		if not Mission.Lex.Dead then
			local inBorderZone = IsInBorderZone(Mission.Lex)

			if inBorderZone then
				Mission.MissionFailed = true
				Mission.FailMsg = "ijn06.obj_missionfailed_hornetexited"
				luaJM6StepPhase(99)
				return
			end

			local squadNum, squadTbl = luaGetSlotsAndSquads(Mission.Lex)
			if squadNum < 2 then
				if IsReadyToSendPlanes(Mission.Lex) then
					LaunchSquadron(Mission.Lex, 38, Mission.Difficulty+1, 2)
				end
			end
			if squadTbl then
				for idx,unit in pairs(squadTbl) do
					local ammo = GetProperty(unit, "ammoType")
					if unit and not unit.Dead and luaGetScriptTarget(unit) == nil and ammo ~= 0 then
						local trgTbl = luaSortByDistance(unit, spotted_units)
						local num = table.getn(trgTbl)
						if trgTbl[num] and not trgTbl[num].Dead then
							if luaGetType(trgTbl[num]) == "sub" then
								if GetSubmarineOnSurface(trgTbl[num]) then
									PilotSetTarget(unit, trgTbl[num])
									luaSetScriptTarget(unit, trgTbl[num])
								end
							else
								PilotSetTarget(unit, trgTbl[num])
								luaSetScriptTarget(unit, trgTbl[num])
							end
						end
					end
				end
			end
		end

		if table.getn(Mission.Escorts) > 0 then
			--Escorts
			if Mission.AttackingDD and not Mission.AttackingDD.Dead then
				--luaLog("Attack against subs")
			else
					nearestTrg = luaSortByDistance(Mission.Lex, spotted_units, true)
				if luaGetDistance(Mission.Lex, nearestTrg) < 4000 then
					nearestDD = luaSortByDistance(nearestTrg, Mission.Escorts, true)
					Mission.AttackingDD = nearestDD
					if IsInFormation(Mission.AttackingDD) then
						LeaveFormation(Mission.AttackingDD)
					end
					NavigatorAttackMove(Mission.AttackingDD, nearestTrg, {})
				end
			end
		end

	else

		--Carrier
		local squadNum, squadTbl = luaGetSlotsAndSquads(Mission.Lex)
		if squadTbl then
			for idx,unit in pairs(squadTbl) do
				local cmd = GetProperty(unit, "unitcommand")
				local ammo = GetProperty(unit, "ammoType")
				if unit and not unit.Dead and ammo == 0 and cmd ~= "land" then
					PilotLand(unit, Mission.Lex)
				elseif unit and not unit.Dead and ammo > 0 and cmd == "moveto" then
					PilotMoveToRange(unit, Mission.Lex)
				end
			end
		end
		--Escorts
		if Mission.AttackingDD and not Mission.AttackingDD.Dead then
			if luaGetScriptTarget(Mission.AttackingDD) and not luaGetScriptTarget(Mission.AttackingDD).Dead and luaJM6IsInRecon(unit) then
				--luaLog("Attacker DD has its target")
			else
				JoinFormation(Mission.AttackingDD, Mission.Lex)
				Mission.AttackingDD = nil
			end
		elseif Mission.AttackingDD and Mission.AttackingDD.Dead then
			--luaLog("AttackerDD died")
			Mission.AttackingDD = nil
		end
	end
end

function luaJM6IsInRecon(unit)
	local nmiParty
	if unit.Party == PARTY_JAPANESE then
		nmiParty = PARTY_ALLIED
	else
		nmiParty = PARTY_JAPANESE
	end
	for idx,unitTbl in pairs(recon[nmiParty].enemy) do
		for idx2,nmiUnit in pairs(unitTbl) do
			if nmiUnit.ID == unit.ID then
				return true
			end
		end
	end
	return false
end

function luaJM6CheckPts()

	local spotted_units = luaJM6AiSubSpotted()
	Mission.PlayerSpotted = luaJM6IsInZone()
	Mission.PtPatrols = luaRemoveDeadsFromTable(Mission.PtPatrols)

	if Mission.PlayerSpotted then
		table.insert(spotted_units, Mission.PlayerUnit)
	end

	if table.getn(spotted_units) > 0 then

		for idx,spottedUnit in pairs(spotted_units) do
			local enemies = luaJM6GetNearestPT(spottedUnit)
			if enemies and next(enemies) then
				for idx,unit in pairs(enemies) do
					if not unit.attacking then
						NavigatorAttackMove(unit, spottedUnit, {})
						luaSetScriptTarget(unit, spottedUnit)
						unit.attacking = true
					end
				end
			end
		end

	else

		for idx,unit in pairs(Mission.PtPatrols) do
			if unit.attacking then
				local trg = luaGetScriptTarget(unit)
				if trg and not trg.Dead and luaJM6IsInRecon(trg) then
					--luaLog("PTs target still visible")
				else
					NavigatorMoveOnPath(unit, thisTable[tostring(unit.pathID)], PATH_FM_CIRCLE, PATH_SM_JOIN, random(5,10))
					unit.attacking = nil
				end
			end
		end

	end
end

function luaJM6GetNearestPT(unit)
	local nearest = {}
	local allPts = recon[PARTY_ALLIED].own.torpedoboat
	local allPts = luaRemoveDeadsFromTable(allPts)
	local sorted = luaSortByDistance(unit, allPts)

	if not sorted then
		sorted = {}
		return sorted
	end

	for idx,unit in ipairs(sorted) do
		table.insert(nearest, unit)
		if table.getn(nearest) == Mission.MaxAttackingPts then
			return nearest
		end
	end
end

function luaJM6CheckUSNSubs()
	Mission.USNSubs = luaRemoveDeadsFromTable(Mission.USNSubs)
	for idx,unit in pairs(Mission.USNSubs) do
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			if luaGetDistance(unit, Mission.PlayerUnit) <= 3000 and GetProperty(unit,"unitcommand") ~= "attackmove" then
				NavigatorAttackMove(unit, Mission.PlayerUnit, {})
				--luaLog(unit.Name.." tamadja playerunitot")
			end
		end
	end
end

function luaJM6CheckHiddenObj()
	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	else
		if luaObj_GetSuccess("hidden",1) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.CargoEscort)) == 0 then
				luaObj_Completed("hidden",1)
				--luaJM6AddPowerup("hardened_armour")
			end
		end
	end
end

function luaJM6CheckIJNSubs()
	local trgTbl
	Mission.IJNSubsGrp1 = luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)
	if Mission.PathEnd then
		for idx,unit in pairs(Mission.IJNSubsGrp1) do
			if idx ~= 1 and not unit.Dead and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
				trgTbl = luaRemoveDeadsFromTable(Mission.Cargos)
			end

			trg = luaSortByDistance2(unit, trgTbl, true)

			if trg and not trg.Dead then
				NavigatorAttackMove(unit, trg, {})
				luaSetScriptTarget(unit, trg)
			else
				--luaLog("nincse celpont subgrp1")
			end
		end
	end
end

function luaJM6SubPathListener()
	AddListener("command", "submove", {
		["callback"] = "luaJM6StartSubAttack",  -- callback fuggveny
		["entity"] = Mission.IJNSubsGrp1, -- entityk akiken a listener aktiv
		["target"] = {}, -- a vizsgalt command celpontja
		["command"] = {"moveonpath"}, -- vizsgalt command pl. "moveonpath" (string)
		["status"] = {"finish"}, -- lehet "start", vagy "finish" (ez utobbi csak moveonpathra mukodik egyelore)
		})
		Mission.PathListener = true
end

function luaJM6StartSubAttack(...)
	--luaLog("listener callback")
	for i,v in ipairs(arg) do
		--luaLog(v)
	end
	if Mission.PathListener then
		RemoveListener("command","submove")
		Mission.PathListener = false
	end
	Mission.PathEnd = true
end

function luaJM6AiSubSpotted()
	Mission.IJNSubs = luaJM6GetIJNSubs()
	local spotted_units = {}
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNSubs)) do
		if luaIsInArea(Mission.HideZone, GetPosition(unit)) then
			--if GetSubmarineDepthLevel(unit) == 0 then
			if GetSubmarineOnSurface(unit) then
				table.insert(spotted_units, unit)
			end
		else
			if luaJM6IsInRecon(unit) then
				table.insert(spotted_units, unit)
			end
		end
	end

	return spotted_units
end

function luaJM6GetIJNSubs()
	local actDlg = GetActDialogIDs()
	local dlgRunning = false
	for idx,dlgID in pairs(actDlg) do
		if dlgID == "IJNSubDead" then
			dlgRunning = true
			break
		end
	end

	local alive = {}
	--local all = luaSumTablesIndex(Mission.IJNSubsGrp1,Mission.IJNSubsGrp2,Mission.IJNSubsGrp3)
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)) do
		if unit.Dead and not dlgRunning then
			--Mission.Dialogues["IJNSubDead"]["sequence"][1]["message"] = string.gsub(Mission.Dialogues["IJNSubDead"]["sequence"][1]["message"], "<SHIPNAME>", unit.Name)
			luaJM6StartDialog("IJNSubDead", true)
		else
			table.insert(alive, unit)
		end
	end
	return alive
	--return luaRemoveDeadsFromTable(luaSumTables(Mission.IJNSubsGrp1,Mission.IJNSubsGrp2,Mission.IJNSubsGrp3))
end

function luaJM6HiddenTimerEnd()
	--luaLog("HiddenTimerEnd")
	luaJM6StepPhase()
end

function luaJM6SpawnJapFleet()
	SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = 59,
					["Name"] = "Yamato",
					["Crew"] = 1,
					["Race"] = Japan,
				},
				{
					["Type"] = 14,
					["Name"] = "Placeholder",
					["Crew"] = 1,
					["Race"] = Japan,
				},
				{
					["Type"] = 14,
					["Name"] = "Placeholder",
					["Crew"] = 1,
					["Race"] = Japan,
				},
			},
			["area"] = {
				["refPos"] = GetPosition(FindEntity("IJNFleetSpawn")),
				["angleRange"] = {luaJM6RAD(0),luaJM6RAD(90)},
				["lookAt"] = GetPosition(Mission.Lex),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM6FleetSpawned",
		})
end

function luaJM6FleetSpawned(...)
	Mission.IJNFleet = {}
	for idx,unit in ipairs(arg) do
		table.insert(Mission.IJNFleet, unit)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		if unit.Class.Type == "BattleShip" then
			Mission.Yamato = unit
			SetGuiName(Mission.Yamato, "ingame.shipnames_yamato")
		end
	end

	for idx,unit in pairs(Mission.IJNFleet) do
		if unit.Class.Type == "Destroyer" then
			JoinFormation(unit, Mission.Yamato)
			SetGuiName(unit, Mission.Names.JAP.YamatoScreen[idx][1])
		end
	end

	--todo: mivan ha lex halott?
	if not Mission.Lex.Dead then
		NavigatorAttackMove(Mission.Yamato, Mission.Lex, {})
	end
	luaJM6StartDialog("YamatoArrived",true)
	--luaJumpinMovieSetCurrentMovie("GoAround", Mission.Yamato.ID)
	--luaJM6YamatoCamera()
	--luaJM6StepPhase()
	Mission.JapFleetInit = true
end

function luaJM6SpawnI400()

	luaJM6SpawnCatalina()

	Mission.I400SpawnInit = true
	local pos = GetPosition(FindEntity("IJNSubSpawn"))
	pos.y = -50
	SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = 8,
					["Name"] = "I-400",
					["Crew"] = 1,
					["Race"] = Japan,
				},
			},
			["area"] = {
				["refPos"] = pos,
				["angleRange"] = {luaJM6RAD(0),luaJM6RAD(90)},
				["lookAt"] = GetPosition(Mission.PlayerUnit),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM6I400Spawned",
		})
end

function luaJM6I400Spawned(unit)
	Mission.I400 = unit
	SetGuiName(Mission.I400, "ingame.shipnames_i|.400")
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	SetSubmarineDepthLevel(unit, 3)
	Mission.I400Time = math.floor(GameTime())
	--SetCounterTimer(300, true)
	--Countdown("Airsupply left", 1, 300, "luaJM6AirSupplyLeft")
end

function luaJM6SpawnCatalina()

	local pos = GetPosition(FindEntity("CatalinaSpawn"))
	pos.y = 50
	
	SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 125,
					["Name"] = "PBY Catalina",
					["Crew"] = 1,
					["Race"] = USA,
					["WingCount"] = 1,
					["Equipment"] = 0,
				},
			},
			["area"] = {
				["refPos"] = pos,
				["angleRange"] = {luaJM6RAD(0),luaJM6RAD(90)},
				["lookAt"] = GetPosition(Mission.PlayerUnit),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM6CatalinaSpawned",
		})
end

function luaJM6CatalinaSpawned(unit)
	SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	Mission.Catalina2 = unit
	--SetGuiName(Mission.Catalina2, "PBY Catalina")
	PilotMoveToRange(unit, FindEntity("IJNSubSpawn"))
	SquadronSetTravelAlt(unit, 50)
	--luaDelay(luaJM6ClearCatalinaReconCheat, 30)
end

function luaJM6ClearCatalinaReconCheat()
	ClearForcedReconLevel(Mission.Catalina2, PARTY_JAPANESE)
end

function luaJM6AirSupplyLeft()
	if Mission.I400.Dead then
		return
	end
	if Mission.Catalina2.Dead then
		AddUntouchableUnit(Mission.I400)
	end
	SetSubmarineDepthLevel(Mission.I400, 0)
end

function luaJM6CheckI400()
	if not Mission.I400SpawnInit then
		luaJM6SpawnI400()
	end
	if not Mission.I400 then
		return
	end

	if Mission.Catalina2 and not Mission.Subhint3 then
		luaJM6StartDialog("I400Spawn_A",true)
 		luaJM6StartDialog("I400Spawn_B",true)
 		--luaJM6SubHint3()
		--ShowHint("IJN06_Hint04")
 		Mission.Subhint3 = true
 	end


	if Mission.I400.Dead then
		luaJM6StartDialog("I400Destroyed",true)
		return
	end

	--if not Mission.I400Timer then
		--SetCounterTimer(600,true)
		--Countdown("ijn06.i400", 1, 600, "luaJMI400Away")
		--Mission.I400Timer = true
	--end
	if not Mission.I400Timer and math.floor(GameTime()) - Mission.I400Time > 300 then
		luaJMI400Away()
		Mission.I400Timer = true
	end

	if luaGetDistance3D(Mission.I400, Mission.PlayerUnit) < 300 then
		if not Mission.ReloadInProgress then
			luaJM6AddTorp()
		end
	end
end

function luaJM6AddTorp()
	local numTorps = GetProperty(Mission.PlayerUnit, "TorpedoStock")
	local maxTorps = Mission.PlayerUnit.Class.MaxTorpedoStock

	if numTorps < maxTorps then
		ShipSetTorpedoStock(Mission.PlayerUnit, numTorps+1)
		Mission.ReloadInProgress = true
		luaDelaySet("ReloadInProgress", false, 5)
	else
		MissionNarrativeEnqueue("ijn06.max_torp_reached")
	end
end

function luaJMI400Away()
	NavigatorMoveToRange(Mission.I400, GetClosestBorderZone(GetPosition(Mission.I400)))
	luaJM6StartDialog("I400Leaves",true)
	Mission.I400Gone = true
	--luaJM6StepPhase()
end

function luaJM6RAD(x)
	return x *  0.0174532925
end

function luaJM6AddCVHitListener()
	AddListener("hit", "cvhit", {
		["callback"] = "luaJM6CVHitByPlayer", -- callback fuggveny
		["target"] = {Mission.Lex}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {Mission.PlayerUnit}, -- tamado entityk
		["attackType"] = {}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.CVHitListener = true
end

function luaJM6CVHitByPlayer(...)
-- RELEASE_LOGOFF  	luaLog("HORNET HIT CALLBACK")

-- RELEASE_LOGOFF  	luaLog(arg)
	if arg[4] == "TORPEDO" then
		Mission.CVHitByPlayer = true
		luaDelay(luaJM6DelayedListenerRemove, 2)
	end
	--RemoveListener("hit", "cvhit")
	--luaJM6StepPhase()
end

function luaJM6DelayedListenerRemove()
	if IsListenerActive("hit", "cvhit") then
		RemoveListener("hit", "cvhit")
	end
end

function luaJM6AddHospitalShipHitListener()
	AddListener("hit", "hshit", {
		["callback"] = "luaJM6HospitalShipHitByPlayer", -- callback fuggveny
		["target"] = {Mission.Hospital}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"TORPEDO","ARTILLERY"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM6HospitalShipHitByPlayer()
luaJM6StartDialog("NmiRadio1", true)
	RemoveListener("hit", "hshit")
end

function luaJM6StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM6StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM6StartDialog cannot continue, non existing dialog: "..dialogID, 2)
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

function luaJM6CVListener()
	--luaLog("Cv recon listener added")
	AddListener("recon", "cvListener", {
		["callback"] = "luaJM6CVSighted",  -- callback fuggveny
		["entity"] = {Mission.Lex}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM6CVSighted(cb,entity,old,new)
	RemoveListener("recon", "cvListener")
	Mission.CVSpotted = true
	--luaJM6LexMovie(Mission.Lex)
end

function luaJM6USNSubListener()
	--luaLog("SUB recon listener added")
	Mission.USNSubs = luaRemoveDeadsFromTable(Mission.USNSubs)
	
	AddListener("recon", "usnsubListener", {
		["callback"] = "luaJM6USNSubSighted",  -- callback fuggveny
		["entity"] = Mission.USNSubs, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})
end

function luaJM6USNSubSighted()
	RemoveListener("recon", "usnsubListener")
	luaJM6StartDialog("USNSubDetected",true)
	luaDelay(luaJM6DelayedSubHint, 6)
end

function luaJM6DelayedSubHint()
	ShowHint("IJN06_Hint05")
end

function luaJM6CatalinaSpeech()
	luaJM6StartDialog("NmiRadio3",true)
end

function luaJM6CheckCargoEscorts()
-- RELEASE_LOGOFF  	luaLog("CargoEscort checker fut.")
	Mission.CargoEscort = luaRemoveDeadsFromTable(Mission.CargoEscort)
	local spotted_units = luaGetOwnUnits("sub", PARTY_JAPANESE)
	spotted_units = luaRemoveDeadsFromTable(spotted_units)

	local trg
	local rndTrg

--[[	for idx,unit in pairs(spotted_units) do
-- RELEASE_LOGOFF  		luaLog("XXXXXXXXXXXXXX "..unit.Name)
	end]]

		for idx,ship in pairs(Mission.CargoEscort) do
			--luaLog("TAMADO TIPUS: "..tostring(ship.Type))
			if ship.Type == "DESTROYER" then

					if IsInFormation(ship) then
						LeaveFormation(ship)
					end

					rndTrg = spotted_units[random(1,table.getn(spotted_units))]
					trg = luaPickInRange(Mission.PlayerUnit, 60, rndTrg, 40)

					if ship and not ship.Dead and trg and not trg.Dead then
-- RELEASE_LOGOFF  					--[[	luaLog("OOOOOOOOOOOOOOOOOOOOO")
-- RELEASE_LOGOFF  						luaLog(ship.Name)
-- RELEASE_LOGOFF  						luaLog(trg.Name)]]--
						NavigatorAttackMove(ship, trg, {})
					end
			end
		end
end

function luaJM6AddPowerup(type)
	--luaLog("powerup granted "..tostring(type))

	--MissionNarrativeEnqueue("Powerup awarded.")

	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM6FadeIn()
	--SoundFade(1, "",0.1)
	luaCheckSavedCheckpoint()
	if not Mission.CheckpointLoaded then
		luaJM6AddHospitalShipHitListener()
		luaJM6USNSubListener()
		--luaJM6AddAmbushListener()
		luaDelay(luaJM6EndReconIntro, 2)
		Blackout(false, "", 3)
	end
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(14)
	PrepareClass(59)
	PrepareClass(38)
	PrepareClass(8)
	PrepareClass(172)
	PrepareClass(150)
	PrepareClass(125)
	Loading_Finish()
end

function luaJM6SetGuiNames()
	--luaLog("allitom a guineveket")

	--SetGuiName(Mission.Catalina, "PBY Catalina")

	for idx, unit in pairs(Mission.JAPSubs) do
		if IsClassChanged(unit.Class.ID) then
			if unit.Class.ID == 8 then
				SetGuiName(unit, "ingame.shipnames_i|.40"..tostring(idx))
			elseif unit.Class.ID == 81 then
				SetGuiName(unit, "globals.unitclass_typeb_kaiten")
			else
				SetGuiName(unit, unit.Class.Name)
			end
		else
			SetGuiName(unit, Mission.Names.JAP.Subs[idx][1])
		end
	end

	--[[for idx, unit in pairs(Mission.Escorts) do
		SetGuiName(unit, Mission.Names.USN.Escorts[idx][1])
		if Mission.Names.USN.Escorts[idx][2] then
			SetNumbering(unit, Mission.Names.USN.Escorts[idx][2])
		end
	end]]

	--[[for idx, unit in pairs(Mission.PtPatrols) do
		SetGuiName(unit, Mission.Names.USN.Pts[idx][1])
		if Mission.Names.USN.Pts[idx][2] then
			SetNumbering(unit, Mission.Names.USN.Pts[idx][2])
		end
	end]]

	for idx, unit in pairs(Mission.Cargos) do
-- RELEASE_LOGOFF  		luaLog(idx)
-- RELEASE_LOGOFF  		luaLog(GetGuiName(unit))
		SetGuiName(unit, Mission.Names.USN.Cargos[idx][1])
		if Mission.Names.USN.Cargos[idx][2] then
			SetNumbering(unit, Mission.Names.USN.Cargos[idx][2])
		end
-- RELEASE_LOGOFF  		luaLog(GetGuiName(unit))
	end

	for idx, unit in pairs(Mission.CargoEscort) do
		SetGuiName(unit, Mission.Names.USN.CargoEscort[idx][1])
		if Mission.Names.USN.CargoEscort[idx][2] then
			SetNumbering(unit, Mission.Names.USN.CargoEscort[idx][2])
		end
	end

	for idx, unit in pairs(Mission.USNSubs) do
		SetGuiName(unit, Mission.Names.USN.Subs[idx][1])
		if Mission.Names.USN.Subs[idx][2] then
			SetNumbering(unit, Mission.Names.USN.Subs[idx][2])
		end
	end

end

function luaJM6CatReminderDlg()
	if Mission.Catalina2 and not Mission.Catalina2.Dead then
		if luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil then
			luaJM6StartDialog("CatalinaReminder",true)
		end
	end
end

function luaJM6AddCVKillListener()
	AddListener("kill", "CVKill", {
		["callback"] = "luaJM6HornetDeadDlg",  -- callback fuggveny
		["entity"] = {Mission.Lex}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM6HornetDeadDlg()
	RemoveListener("kill", "CVKill")
	--luaJM6StartDialog("HornetKilled",true)
end

function luaJM6SubHint1()
	local str = "HINT: Submarines control much like ships, however pressing up and down on the d-pad will cause the submarine to move between depth levels. When just under the surface you can fire torpedos and press <binocular button icon> to use your periscope, any deeper and you can't do either."
	MissionNarrativeUrgent(str)
end

function luaJM6SubHint2()
	local str = "HINT: Submarines are invisible to radar and cannot be seen from the depth charge camera when at the deepest depth level, however remaining at this level damages the sub."
	MissionNarrativeUrgent(str)
end

function luaJM6SubHint3()
	local str = "HINT: An oxygen indicator in the bottom right of the screen indicates your remaining oxygen when this runs out the submarine will automatically rise to the surface. While on the surface oxygen is automatically replenished."
	MissionNarrativeUrgent(str)
end

function luaJM6SubInit(subTable)
	local pos = {}

	for idx, sub in pairs(subTable) do
		pos.x = GetPosition(sub).x
		pos.y = -20
		pos.z = GetPosition(sub).z
		SetSubmarineDepthLevel(sub, 1)
		PutTo(sub, pos)
	end
end


function luaJM6ShowReconHint()
-- RELEASE_LOGOFF  	luaLog("reconhint")
	ShowHint("IJN06_Hint01")
	Mission.ReconHintShown = true
	--EnableInput(true)
end


function luaJM6MasodikHint()
	RemoveStoredHint("BASICSUB2")
	ShowHintForced("BASICSUB2")
	if Mission.IJNSubsGrp1[1] and not Mission.IJNSubsGrp1[1].Dead and not IsClassChanged(Mission.IJNSubsGrp1[1].Class.ID) then
		luaDelay(luaJM6ShowReconHint, 25)
	end
end


function luaJM6EndReconIntro()

	--SetSimplifiedReconMultiplier(1)
	if not Mission.ReconHintShown then
		--if Mission.IJNSubsGrp1[1] and not Mission.IJNSubsGrp1[1].Dead and not IsClassChanged(Mission.IJNSubsGrp1[1].Class.ID) then
			RemoveStoredHint("BASICSUB")
			ShowHintForced("BASICSUB")
			luaDelay(luaJM6MasodikHint, 25)
			--ShowHint("IJN06_Hint01")
		--else
			--ShowHint("IJN06_Hint01_Kaiten")
		--end
		Mission.ReconHintShown = true
	end

	EnableInput(true)
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetSelectedUnit(Mission.PlayerUnit)
	end

	for idx, unit in pairs(luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)) do
		if idx ~= 1 then
			NavigatorMoveOnPath(unit, FindEntity("IJNSubPath1"), PATH_FM_SIMPLE, PATH_SM_JOIN)
			SetSubmarineDepthLevel(unit, 1)
		end

		--luaLog("megyek melyre")
	end

	Mission.Cargos = luaRemoveDeadsFromTable(Mission.Cargos)
	
	AddListener("recon", "fleetrecon", {
		["callback"] = "luaJM6FleetSpotted",  -- callback fuggveny
		["entity"] = Mission.Cargos, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})

	Mission.ReconIntroEnded = true
end

function luaJM6FleetSpotted()
	RemoveListener("recon", "fleetrecon")
	for idx, sub in pairs(luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)) do
		if idx ~= 1 then
			local rndTrg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
			if rndTrg and not rndTrg.Dead then
				NavigatorAttackMove(sub, rndTrg, {})
			end
		end
	end

	Mission.FleetSpotted = true
end

function luaJM6CarrierReminder()
	if IsListenerActive("recon", "cvListener") then
		--luaJM6StartDialog("NoCarrier")
		--StartDialog("Still no sign of the carrier. Keep on searching!")
	end
end


function luaJM6PlayerHitListener()
	AddListener("hit", "playerHit", {
		["callback"] = "luaJM6PlayerHit", -- callback fuggveny
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


function luaJM6PlayerHit()
		RemoveListener("hit", "playerHit")
		--MissionNarrativeUrgent("We've been hit! DIVE!!! DIVE!!!!")
		luaJM6StartDialog("PlayerHit")
end

function luaJM6EnemyHitListener()
	AddListener("hit", "nmeHit", {
		["callback"] = "luaJM6EnemyHit", -- callback fuggveny
		["target"] = Mission.Cargos, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {Mission.PlayerUnit}, -- tamado entityk
		["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
end

function luaJM6EnemyHit(...)
	--luaLog("ARG: ")
	--luaLog(arg)
	--luaLog("---------------")
	for idx,value in ipairs(arg) do
		if idx == "target" then
			--luaLog("IDE TALALT: ")
			--luaLog(target)
		end
	end
end

function luaJM6PeriscopeCheck()
	if not Mission.PeriscopeHintShowed then
		if Mission.Lex and not Mission.Lex.Dead and Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			local dist = luaGetDistance(Mission.PlayerUnit, Mission.Lex)
			local failure = nil
			if dist < 3000 and not GetSubmarineOnSurface(Mission.PlayerUnit) then
				--luaJM6StartDialog("HornetNear")
				ShowHint("IJN06_Hint02")
				Mission.PeriscopeHintShowed = true
			end
		end
	end
end

function luaJM6CheckSurface()
	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead then
		return
	end

	if GetSubmarineOnSurface(Mission.PlayerUnit) then
		if not Mission.RadioTemp then
			luaJM6StartDialog("RadioMessage", false, true)
			Mission.RadioTemp = true
		end

		if not Mission.SurfaceTimer then
			luaJM6Sec3Score()
			HideScoreDisplay(99,0)
			Mission.SurfaceTimer = true
		end
	else
		CountdownCancel()
		Mission.SurfaceTimer = false
		Mission.SurfaceCounter = 0
		--Mission.RadioTemp = false
		DisplayScores(99,0,"ijn06.obj_s3","")

		if Mission.RadioTemp then
			KillDialog("RadioMessage")
			Mission.RadioTemp = false
			--luaObj_Failed("secondary",3)
		end
	end
end

function luaJM6IsInRange(unit, target, distance)
	if unit and not unit.Dead and target and not target.Dead then
		local dist = luaGetDistance(unit, target)
		if dist < distance then
			return true
		else
			return false
		end
	end
end

function luaJM6SittingDucks()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, 0.1)
	end
	
	if Mission.Lex and not Mission.Lex.Dead then
		SetFailure(Mission.Lex, "EngineJam", 600)
		SetFailure(Mission.Lex, "SteeringJam", 600)
		RepairEnable(Mission.Lex, false)
		SetInvincible(Mission.Lex, 0.2)
	end
end

function luaJM6Assist()
	Mission.YamatoMovieDone = true
	luaDelay(luaJM6EndGame, 3)
	--luaJM6SelectUnit()
	if Mission.Lex and not Mission.Lex.Dead then
		NavigatorAttackMove(Mission.Yamato, Mission.Lex, {})
	end

	SetRoleAvailable(Mission.Yamato, EROLF_ALL, PLAYER_1)
	SetSelectedUnit(Mission.Yamato)
	EnableInput(true)

	luaJM6StartDialog("Assist")
end

function luaJM6EndGame()
	luaJM6YamatoEnrage(false)
	--luaCamOnTargetFree(Mission.PlayerUnit, 30, 100, 100, true, "noupdate", 3, nil)
	--EnableInput(true)
	if Mission.Lex and not Mission.Lex.Dead then
		SetInvincible(Mission.Lex, false)
	end

end

function luaJM6YamatoCamera()
	luaCamOnTargetFree(Mission.Yamato, 10, 180, 200, false, "noupdate", 3, luaJM6YamatoDelayedShown)

--[[theta: függõleges forgásszög. 0 - vízszintes, 90 - felülrõl
rho: vízszintes forgásszög. 0 - szembõl, 90 - balról, 180 - hátulról, 270 – jobbról
distance: kamera távolsága a targettõl]]
end

function luaJM6YamatoDelayedShown()
	luaDelay(luaJM6YamatoShown, 6)
end

function luaJM6YamatoShown()
	luaCamOnTargetFree(Mission.PlayerUnit, 30, 100, 100, true, "noupdate", 3, nil)
	EnableInput(true)
end

function luaJM6AddAmbushListener()
-- RELEASE_LOGOFF  	luaLog("Ambush listener added")
	AddListener("kill", "ambush", {
		["callback"] = "luaJM6FleetAmbushed",  -- callback fuggveny
		["entity"] = Mission.Cargos, -- entityk akiken a listener aktiv
		["lastAttacker"] = {Mission.PlayerUnit},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM6FleetAmbushed(...)
-- RELEASE_LOGOFF  	luaLog("AMBUSH DONE")
-- RELEASE_LOGOFF  	luaLog(arg)
	Mission.AmbushTarget = arg[1]
	Mission.Ambush = true
	RemoveListener("kill", "ambush")
end

function luaJM6YamatoEnrage(flag)
	if Mission.Yamato and not Mission.Yamato.Dead then
		if flag then
			SetSkillLevel(Mission.Yamato, SKILL_ELITE)
		else
			SetSkillLevel(Mission.Yamato, SKILL_SPNORMAL)
		end
	end
end

function luaJM6YamatoMovieTargeting()
	local trgList = luaRemoveDeadsFromTable(Mission.Escorts)
	if trgList and table.getn(trgList) > 0 then
		local trg = luaPickRnd(trgList)
		NavigatorAttackMove(Mission.Yamato, trg, {})
		--[[for idx,unit in pairs(trgList) do
			if unit.ID ~= trg.ID then
				luaDelay(luaJM6Dmg2Ships, random(1,3), "unit", unit)
			end
		end]]
	end
end

function luaJM6Dmg2Ships(timerThis)
	local unit = timerThis.ParamTable.unit
	if unit and not unit.Dead then
		AddDamage(unit, 3500)
		Effect("ExplosionBigShip", GetPosition(unit))
	end
end

function luaJM6Pri1Score()
	Mission.ShipsToSink = tostring(table.getn(luaRemoveDeadsFromTable(Mission.CargoTargets)))
	local line1 = "ijn06.obj_p1"
	local line2 = "ijn06.shipstosink"
	luaJM6DisplayScore(1,line1,line2)
end

function luaJM6Pri2Score()
	local line1 = "ijn06.obj_p2"
	luaJM6DisplayScore(2,line1,"")
end

function luaJM6Pri3Score()
	--DisplayUnitHP({Mission.Lex}, "ijn06.obj_p3")
	local tbl = luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.Escorts, {Mission.Lex}))
	Mission.ShipsToSink = tostring(table.getn(tbl))
	local line1 = "ijn06.obj_p3"
	local line2 = "ijn06.shipstosink" --tostring(table.getn(tbl)).." ships remaining"
	luaJM6DisplayScore(3, line1, line2)
end

function luaJM6Sec1Score()
	local line1 = "ijn06.obj_s1"
	luaJM6DisplayScore(3,line1,"")
end

function luaJM6Sec2Score()
	DisplayUnitHP({Mission.Catalina2}, "ijn06.obj_s2")
end

function luaJM6Sec3Score()
	Countdown("ijn06.obj_s3", 1, 24, "luaJM6MessageTransmitted")
end

function luaJM6MessageTransmitted()
	Mission.MessageTransmitted = true
end

function luaJM6DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM6RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

--------------------moviez-----------------------
function luaJM6MovieInit()
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, 0.1)
	end
end

function luaJM6SelectUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end
	
	EnableInput(true)
end

function luaJM6CatalinaMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM6MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM6SelectUnit, true)
end

function luaJM6LexMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM6MovieInit()
	
	LaunchSquadron(Mission.Lex, 38, 1, 2)
	
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 150, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 300, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 10},
		}, luaJM6LexMovieDone, true)
end

function luaJM6LexMovieDone()
	Mission.LexMovieDone = true

	--[[if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	else
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end

	EnableInput(true)]]--

	luaJM6CheckI400()

end

function luaJM6YamatoMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM6YamatoEnrage(true)
	luaJM6YamatoMovieTargeting()

	luaJM6MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM6Assist, true)
end

function luaJM6SubMovie()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.IJNSubsGrp1[1], ["distance"] = 100, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.IJNSubsGrp1[1], ["distance"] = 250, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 8},
		}, luaJM6EndReconIntro)

	ShipUseCatapult(Mission.IJNSubsGrp1[1])
	if not Mission.IJNSubsGrp1[1].Class.Platforms[110] then
		luaDelay(luaJM6ShowReconHint, 5)
	end
	--SetSimplifiedReconMultiplier(1)
end

function luaJM6SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	Mission.Checkpoint.CVSpotted = Mission.CVSpotted
	Mission.Checkpoint.AmbushMovieDone = Mission.AmbushMovieDone
	Mission.Checkpoint.JapCoords = {}
	Mission.Checkpoint.Reconplanes = {}
	Mission.Checkpoint.ReconCoords = {}
	Mission.Checkpoint.JapSubs = {}

	--local subs = luaSumTablesIndex(Mission.IJNSubsGrp1,Mission.IJNSubsGrp2,Mission.IJNSubsGrp3,{Mission.PlayerUnit})


	for i,v in pairs(luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)) do
		table.insert(Mission.Checkpoint.JapCoords, GetPosition(v))
		table.insert(Mission.Checkpoint.JapSubs, v.Name)

	end

	Mission.Checkpoint.PlayerCoord = GetPosition(Mission.PlayerUnit)

	local planes = luaGetOwnUnits("plane", PARTY_JAPANESE)

	for i,v in pairs(luaRemoveDeadsFromTable(planes)) do
		table.insert(Mission.Checkpoint.Reconplanes, v.Name)
		table.insert(Mission.Checkpoint.ReconCoords, GetPosition(v))
	end

end

function luaJM6LoadBlackout()
	Blackout(true, "", 0)
	--Loading_Start()
	luaJM6LoadMissionData()
end

function luaJM6LoadMissionData()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	MissionNarrativeClear()

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	--SetSelectedUnit(FindEntity("Mogami-class 01"))
	--PutRelTo(Mission.PlayerUnit, Mission.Lex, {["x"]=2000,["y"]=-20,["z"]=2000}, 180)
	--Mission.CVSpotted = true

	--PutTo(Mission.PlayerUnit, Mission.Checkpoint.PlayerCoord)
	Mission.CVSpotted = Mission.Checkpoint.CVSpotted
	Mission.AmbushMovieDone = Mission.Checkpoint.AmbushMovieDone
	luaDelay(luaJM6Restore, 1)
end

function luaJM6Restore()
	luaJM6RestoreUnits(num)
end

function luaJM6RestoreUnits(chkPointNum)

	local ijn = {}

	for i,v in pairs(Mission.Checkpoint.JapSubs) do
		table.insert(ijn, FindEntity(v))
	end

	if Mission.Catalina2 and not Mission.Catalina2.Dead then
		luaObj_AddUnit("secondary", 2, Mission.Catalina2)
	end
	
	local usn = luaGetCheckpointData("Units", "USUnits")

	local ijnnow = luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)
--	local ijnnow = luaGetOwnUnits(nil, PARTY_JAPANESE)
	local usnnow = luaGetOwnUnits(nil, PARTY_ALLIED)


	for idx,unit in pairs(usnnow) do
		local found = false
		for idx2,unitTbl in pairs(usn[1]) do
			if unit.Name == unitTbl[1] then
				--luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
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

	for idx,unit in pairs(ijnnow) do
		local found = false
		for idx2,unitTbl in pairs(ijn) do
			if unit.Name == unitTbl.Name then
				local torp = GetProperty(unitTbl, "TorpedoStock")
				if torp and torp >= 0 then
					ShipSetTorpedoStock(unit, torp)
				end
				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			--if unit.Name ~= "PlayerSub 01" then
--				if unit.Class.ID ~= 172 then
					Kill(unit, true)
				--end
			--end
		end

	end


	luaDelay(luaJM6ArrabbBaszo, 1)

end

function luaJM6ArrabbBaszo()
	for i,v in pairs(Mission.Checkpoint.JapSubs) do
		local ent = FindEntity(v)
		if ent and not ent.Dead and not ent.Put then
			PutTo(ent, Mission.Checkpoint.JapCoords[i])
			SetSubmarineDepthLevel(ent, 1)
			ent.Put = true
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

	for i,v in pairs(Mission.Checkpoint.Reconplanes) do
		local ent = FindEntity(v)
		if ent and not ent.Dead and not ent.Put then
			PutTo(ent, Mission.Checkpoint.ReconCoords[i])
			PilotMoveOnPath(ent, Mission.ReconPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
			ent.Put = true
		end
	end

	--luaJM6StepPhase(3)
	Blackout(false, "", 2)
	--Loading_Finish()
end

function luaJM6AddSec()
	if not luaObj_IsActive("secondary",3) then
		luaJM6StartDialog("Transmit",true)
		luaObj_Add("secondary",3)
		DisplayScores(99,0,"ijn06.obj_s3","")
		--luaObj_AddReminder("secondary",3)
	end
end

function luaJM6LoadingEnd()
end

function luaJM6PlayerSubChecker()
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)) == 0 then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn06.obj_missionfailed"
		--Mission.EndMission = true
		luaJM6StepPhase(99)
	else
		--if not GetSelectedUnit() or GetSelectedUnit().Dead then
		if not Mission.IJNSubsGrp1[1] or Mission.IJNSubsGrp1[1].Dead then
			Mission.IJNSubsGrp1 = luaRemoveDeadsFromTable(Mission.IJNSubsGrp1)
			Mission.PlayerUnit = Mission.IJNSubsGrp1[1]
			SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_1)
			SetUnlimitedAirSupply(Mission.PlayerUnit, false)
			if not GetSelectedUnit() or GetSelectedUnit().Dead then
				SetSelectedUnit(Mission.PlayerUnit)
			end
			
			if IsListenerActive("hit", "cvhit") then
				RemoveListener("hit", "cvhit")
				Mission.CVHitListener = false
				luaDelay(luaJM6AddCVHitListener, 1)
			end
		end
	end
end

function luaJM6GenerateUSNFleet()
	local lex = luaFindHidden("Lexington-class 01")
	Mission.Lex = GenerateObject(lex.Name, lex.Name)
	SetGuiName(Mission.Lex, "ingame.shipnames_hornet")
	SetNumbering(Mission.Lex, 8)
	SetForcedReconLevel(Mission.Lex, 2, PARTY_JAPANESE)

	for i,v in pairs(Mission.EscortTemplate) do
		local w = GenerateObject(v.Name, v.Name)
		SetGuiName(w, Mission.Names.USN.Escorts[i][1])
		SetForcedReconLevel(w, 2, PARTY_JAPANESE)
		if Mission.Names.USN.Escorts[i][2] then
			SetNumbering(w, Mission.Names.USN.Escorts[i][2])
		end

		table.insert(Mission.Escorts, w)

		if Mission.Difficulty <= 1 then
			SetSkillLevel(w, SKILL_STUN)
			NavigatorSetTorpedoEvasion(w, false)
		else
			SetSkillLevel(w, SKILL_SPNORMAL)
			NavigatorSetTorpedoEvasion(w, true)
		end

		JoinFormation(w, Mission.Lex)
		SetForcedReconLevel(w, 2, PARTY_JAPANESE)
	end

	NavigatorMoveOnPath(Mission.Lex, FindEntity("CarrierFleetPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)

	SetInvincible(Mission.Lex, 0.1)

	luaJM6AddCVKillListener()

	if not Mission.CVHitListener then
		luaJM6AddCVHitListener()
	end

	Mission.USNFleetGenerated = true

-- RELEASE_LOGOFF  	luaLog("lex fleet generated")
end

function luaJM6ConvoyDestroyedMovie()

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
		--luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM6MovieInit()

	Mission.Cargos = luaRemoveDeadsFromTable(Mission.Cargos)

	Mission.TrgTbl = {}
		table.insert(Mission.TrgTbl, luaPickRnd(Mission.Cargos))
		table.insert(Mission.TrgTbl, luaPickRnd(Mission.Cargos))
		table.insert(Mission.TrgTbl, luaPickRnd(Mission.Cargos))
		table.insert(Mission.TrgTbl, luaPickRnd(Mission.Cargos))


	for i,v in pairs(luaRemoveDeadsFromTable(Mission.Cargos)) do
		SetForcedReconLevel(v, 2, PARTY_ALLIED)
		if v.ID ~= Mission.TrgTbl[1].ID then
			AddDamage(v, random(1400, 1600))
		end
	end

	local trg

	if Mission.IJNSubsGrp1[2] and not Mission.IJNSubsGrp1[2].Dead then
		trg = Mission.IJNSubsGrp1[2]
	elseif Mission.IJNSubsGrp1[1] and not Mission.IJNSubsGrp1[1].Dead then
		trg = Mission.IJNSubsGrp1[1]
	else
		luaJM6AmbushMovieDone()
		return
	end

	if Mission.TrgTbl[1] then
		Mission.BreakDelay1 = luaDelay(luaJM6BreakShips, 9, "target", Mission.TrgTbl[1], "dlg", "NmiRadio4")
		Mission.SubShotDelay1 = luaDelay(luaJM6SubShot, 3, "unit", trg)
		Mission.SubShotDelay2 = luaDelay(luaJM6SubShot, 5, "unit", trg)
	else
		luaJM6AmbushMovieDone()
		return
	end

	luaDelay(luaJM6CarrierDlg, 14)
	luaDelay(luaJM6CatDlg, 24)

	LaunchSquadron(Mission.Lex, 38, 1, 2)
	
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=30.55502319336,["y"]=16.170705795288,["z"]=85.76416015625},["parent"] = trg,},["moveTime"] = 0,["transformtype"] = "keepnone",},
			{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=120.55502319336,["y"]=0.170705795288,["z"]=100.76416015625},["parent"] = trg,},["moveTime"] = 6,["transformtype"] = "keepnone",},
			{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=323.86614990234,["y"]=93.082595825195,["z"]=-689.47406005859},["parent"] = Mission.TrgTbl[1],},["moveTime"] = 0,["transformtype"] = "keepnone",},
			{["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=323.86614990234,["y"]=93.082595825195,["z"]=-189.47406005859},["parent"] = Mission.TrgTbl[1],},["moveTime"] = 8,["transformtype"] = "keepnone",},
            {["postype"] = "cameraandtarget", ["target"] = Mission.Lex, ["distance"] = 200, ["theta"] = 15, ["rho"] = 215, ["moveTime"] = 0,},
		    {["postype"] = "cameraandtarget", ["target"] = Mission.Lex, ["distance"] = 500, ["theta"] = 15, ["rho"] = 220, ["moveTime"] = 6},
            {["postype"] = "cameraandtarget", ["target"] = Mission.I400, ["distance"] = 100, ["theta"] = -5, ["rho"] = 95, ["moveTime"] = 0,},
		    {["postype"] = "cameraandtarget", ["target"] = Mission.I400, ["distance"] = 170, ["theta"] = 5, ["rho"] = 135, ["moveTime"] = 6},
            {["postype"] = "cameraandtarget", ["target"] = Mission.Catalina2, ["distance"] = 40, ["theta"] = 5, ["rho"] = 5, ["moveTime"] = 0,},
		    {["postype"] = "cameraandtarget", ["target"] = Mission.Catalina2, ["distance"] = 100, ["theta"] = 5, ["rho"] = 25, ["moveTime"] = 8},
		}, luaJM6AmbushMovieDone, true)

end

function luaJM6CatDlg()
	luaJM6StartDialog("CatalinaReminder",true)
--	if Mission.Catalina2 and not Mission.Catalina2.Dead then
	--	PlaneForceRelease(thisTable[GetSquadronPlanes(Mission.Catalina2)[1]])
--	end
end

function luaJM6CarrierDlg()
	luaJM6StartDialog("CVSpotted",true)
end

function luaJM6BreakShips(timerThis)
	local trg = timerThis.ParamTable.target
	local dlg = timerThis.ParamTable.dlg

	if dlg then
		luaJM6StartDialog(dlg, true)
	end

	ForceRecon()

	if trg and not trg.Dead then
		Effect("MuzzleTorpedoSplash", ORIGO, trg)
		DisablePhysics(trg)
		BreakShip(trg)
	end
end

function luaJM6SubShot(timerThis)
	local unit = timerThis.ParamTable.unit

	if unit and not unit.Dead then
		NavigatorForceTorpedo(unit, true)
	end
end

function luaJM6ForcePeriscope()
	HackPressInput(IC_ZOOM_ROLE_SWITCH)
end

function luaJM6AmbushMovieDone()
	if Mission.BreakDelay1 and not Mission.BreakDelay1.Dead then
		DeleteScript(Mission.BreakDelay1)
	end

	if Mission.SubShotDelay1 and not Mission.SubShotDelay1.Dead then
		DeleteScript(Mission.SubShotDelay1)
	end

	if Mission.SubShotDelay2 and not Mission.SubShotDelay2.Dead then
		DeleteScript(Mission.SubShotDelay2)
	end


	Mission.AmbushMovieDone = true

	--Blackout(true, "luaJM6Checkpoint1", 1)

	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	else
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end

	EnableInput(true)
	luaJM6StepPhase()
	Blackout(true, "luaJM6Checkpoint1", 1)
end

function luaJM6Checkpoint1()
	--luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM6LetsHitTheYamato()
	if not Mission.JapFleetInit then
		return
	end

	local nmi = recon[PARTY_JAPANESE].enemy.destroyer

	for i,v in pairs(luaRemoveDeadsFromTable(nmi)) do
		if Mission.Yamato and not Mission.Yamato.Dead then
			NavigatorAttackMove(v, Mission.Yamato, {})
		end
	end

end

function c()
	for i,x in pairs(luaRemoveDeadsFromTable(Mission.CargoTargets)) do
		AddDamage(x, 99999)
	end
	Mission.Ambush = true
end

function luaJM6SafeHint()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		if not GetSubmarineOnSurface(Mission.PlayerUnit) and not Mission.MessageTransmitted then
			ShowHint("IJN06_Hint03")
		end
	end
end

function luaJM6InitStoredHints()
	--AddStoredHint("BASICSUB")
	AddStoredHint("BASICSUB2")
end