--SceneFile="universe\Scenes\missions\IJN\ijn_11_invasion_of_fiji.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",11)

	Dialogues =
	{
		["Intro_A"] = {
			["sequence"] = {

				{
					["message"] = "Idlg01a",
				},
			},
		},

		["Intro_B"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01b",
				},
				{
					["message"] = "Idlg01b_1",
				},
			},
		},

		["Intro_C"] = {
			["sequence"] = {

				{
					["message"] = "Idlg02",
				},
			},
		},


	}

	MissionNarrative("ijn11.date_location")
	luaDelay(luaEngineInit, 9, "")
end

function luaEngineInit()
	StartDialog("Intro_dlg", Dialogues["Intro_A"] );
	luaDelay(luaEngineInit2, 9, "")
end

function luaEngineInit2()
	StartDialog("Intro_dlg2", Dialogues["Intro_B"] );
	luaDelay(luaEngineInit3, 12, "")
end

function luaEngineInit3()
	StartDialog("Intro_dlg3", Dialogues["Intro_C"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitJM11")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM11(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM11.lua"

	this.Name = "JM11"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	this.Party = SetParty(this, PARTY_JAPANESE)

	SETLOG(this, true)
	--lualog("Initiating "..this.Name.." mission!")

	EnableMessages(true)
	--EnableInput(false)

	--Mission.UnlockLvl = 3

	--enginemovies
	--luaInitJumpinMovies()

	--reload
	--SetDeviceReloadEnabled(true)

	Mission.Difficulty = GetDifficulty()

	local maxplanes = (Mission.Difficulty+1)*5 --10 volt, csak dara

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM11LoadMissionData},
		[2] = {luaJM11LoadMissionData, luaJM11SpawnPara},
		[3] = {luaJM11LoadMissionData},
		[4] = {luaJM11LoadMissionData},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM11SaveMissionData},
		[2] = {luaJM11SaveMissionData},
		[3] = {luaJM11SaveMissionData},
		[4] = {luaJM11SaveMissionData},
	}

	Mission.CheckNavpoints = {
		GetPosition(FindEntity("CheckPutTo1")),
		GetPosition(FindEntity("CheckPutTo2")),
		GetPosition(FindEntity("CheckPutTo3")),
		GetPosition(FindEntity("CheckPutTo4")),
	}

	Mission.SavedChecks = {
		false,
		false,
		false,
		false,
	}

	if Scoring_IsUnlocked("JM10_GOLD") then
		Mission.PlayerSub = GenerateObject("Submarine I-400 01")
		if IsClassChanged(Mission.PlayerSub.Class.ID) then
			if Mission.PlayerSub.Class.ID == 81 then
				SetGuiName(Mission.PlayerSub, "globals.unitclass_typeb_kaiten")
			else
				SetGuiName(Mission.PlayerSub, Mission.PlayerSub.Class.Name)
			end
		else
			SetGuiName(Mission.PlayerSub, "ingame.shipnames_i400")
		end
	end

	Mission.MissionPhase = 1

	Mission.TempTbl = {}
	Mission.PowerUpTbl = {"improved_shells","improved_shells","improved_shells"}

	Mission.FletcherCounter = 1
	Mission.HintTimer = 0
	Mission.HintDelay = 120
	Mission.Captured = 0

	Mission.FletcherNamePool = {}
		Mission.FletcherNamePool.Names = {}
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_fletcher")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_fullam")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_bennett")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_guest")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_beale")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_bache")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_de_haven")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_taylor")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_strong")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_waller")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_saufley")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_chevalier")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_obannon")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_nicholas")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_la_vallette")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_jenkins")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_radford")
			table.insert(Mission.FletcherNamePool.Names, "ingame.shipnames_john_p_holder")

		Mission.FletcherNamePool.Numbers = {}
			table.insert(Mission.FletcherNamePool.Numbers, 445)
			table.insert(Mission.FletcherNamePool.Numbers, 474)
			table.insert(Mission.FletcherNamePool.Numbers, 473)
			table.insert(Mission.FletcherNamePool.Numbers, 472)
			table.insert(Mission.FletcherNamePool.Numbers, 471)
			table.insert(Mission.FletcherNamePool.Numbers, 470)
			table.insert(Mission.FletcherNamePool.Numbers, 469)
			table.insert(Mission.FletcherNamePool.Numbers, 468)
			table.insert(Mission.FletcherNamePool.Numbers, 467)
			table.insert(Mission.FletcherNamePool.Numbers, 466)
			table.insert(Mission.FletcherNamePool.Numbers, 465)
			table.insert(Mission.FletcherNamePool.Numbers, 451)
			table.insert(Mission.FletcherNamePool.Numbers, 450)
			table.insert(Mission.FletcherNamePool.Numbers, 449)
			table.insert(Mission.FletcherNamePool.Numbers, 448)
			table.insert(Mission.FletcherNamePool.Numbers, 447)
			table.insert(Mission.FletcherNamePool.Numbers, 446)
			table.insert(Mission.FletcherNamePool.Numbers, 542)


	Mission.USCargoNames = {
		"ingame.shipnames_heywood",
		"ingame.shipnames_harris",
		"ingame.shipnames_fuller",
		"ingame.shipnames_j_franklin_bell",
		"ingame.shipnames_a_middleton",
		"ingame.shipnames_barnett",
		"ingame.shipnames_monrovia",
		"ingame.shipnames_george_clymer",
	}

	Mission.PlayerFleet = {}
		table.insert(Mission.PlayerFleet, FindEntity("Fuso-class Battleship 01"))

		table.insert(Mission.PlayerFleet, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Japan Troop Transport 02"))
		--table.insert(Mission.PlayerFleet, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.PlayerFleet, FindEntity("Japan Troop Transport 04"))

		table.insert(Mission.PlayerFleet, FindEntity("Takao-class 01"))
		--table.insert(Mission.PlayerFleet, FindEntity("Takao-class 02"))

		table.insert(Mission.PlayerFleet, FindEntity("Akagi-class 01"))

		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 01"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 02"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 03"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 04"))


		for idx,unit in pairs(Mission.PlayerFleet) do
			SetSkillLevel(unit, SKILL_SPVETERAN)
		end

	Mission.Unlockables = {
		["59"] = {"ingame.shipnames_yamato"},
		["2008"] = {"ingame.shipnames_yamato"},
		["1310"] = {"Bismarck"},
		["68"] = {"ingame.shipnames_tone"},
		["1311"] = {"Prinz Eugen"},
		["14"] = {"ingame.shipnames_akizuki","ingame.shipnames_suzutsuki"},
		["58"] = {"ingame.shipnames_shimakaze","ingame.shipnames_hayakaze"},
		["388"] = {"ingame.shipnames_yashima"},
		["391"] = {"ingame.shipnames_abukuma"},
		--["81"] = "ingame.shipnames_kaiten",
	}


	Mission.PlayerTransports = {}
		table.insert(Mission.PlayerTransports, FindEntity("Japan Troop Transport 01"))
		table.insert(Mission.PlayerTransports, FindEntity("Japan Troop Transport 02"))
		--table.insert(Mission.PlayerTransports, FindEntity("Japan Troop Transport 03"))
		--table.insert(Mission.PlayerTransports, FindEntity("Japan Troop Transport 04"))


	Mission.PlayerFleetNames = {}
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_yamashiro")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_nagato")

		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_miharu")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_nikkoku")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_akebono_maru")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_magane")

		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_takao")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_atago")

		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_akagi")

		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_asagiri")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_yugiri")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_amagiri")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_sagiri")

		--2 formacio
		--JoinFormation(Mission.PlayerFleet[6], Mission.PlayerFleet[1])
		--JoinFormation(Mission.PlayerFleet[7], Mission.PlayerFleet[1])
		--JoinFormation(Mission.PlayerFleet[9], Mission.PlayerFleet[1])
		--JoinFormation(Mission.PlayerFleet[11], Mission.PlayerFleet[1])

		JoinFormation(Mission.PlayerFleet[2], Mission.PlayerFleet[1])
		JoinFormation(Mission.PlayerFleet[3], Mission.PlayerFleet[1])
		JoinFormation(Mission.PlayerFleet[4], Mission.PlayerFleet[1])
		JoinFormation(Mission.PlayerFleet[5], Mission.PlayerFleet[1])
		JoinFormation(Mission.PlayerFleet[6], Mission.PlayerFleet[1])
		--JoinFormation(Mission.PlayerFleet[10], Mission.PlayerFleet[8])
		--JoinFormation(Mission.PlayerFleet[12], Mission.PlayerFleet[8])

		SetSelectedUnit(Mission.PlayerFleet[1])

		--SetShipSpeed(Mission.PlayerFleet[1], 10)

	Mission.Shipyards = {}
		--table.insert(Mission.Shipyards, FindEntity("Shipyard 01"))		--destroyers
		table.insert(Mission.Shipyards, FindEntity("Shipyard 02"))		--pts
	Mission.Shipyards[1].MaxShips = 4
	Mission.Shipyards[1].SpawnPoint = FindEntity("Shipyard2SpawnPoint")
	--Mission.Shipyards[2].MaxShips = 4
	--Mission.Shipyards[2].SpawnPoint = FindEntity("Shipyard2SpawnPoint")
	Mission.MaxCargos = 3

	Mission.Shipyards[1].MaxSpawns = 5
	--Mission.Shipyards[2].MaxSpawns = 5
	Mission.Shipyards[1].Spawns = 0
	--Mission.Shipyards[2].Spawns = 0

	Mission.Shipyard1Ships = {}
	--Mission.Shipyard2Ships = {}
	Mission.USCargos = {}
		table.insert(Mission.USCargos, FindEntity("USTroopTransport_light 01"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport_light 02"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport_light 03"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport_light 04"))
		--[[table.insert(Mission.USCargos, FindEntity("USTroopTransport 05"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport 06"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport 07"))
		table.insert(Mission.USCargos, FindEntity("USTroopTransport 08"))]]--


	Mission.Shipyard1Req = "Shipyard1Req"
	--Mission.Shipyard2Req = "Shipyard2Req"
	--Mission.Shipyard1CargoReq = "Shipyard1CargoReq"

	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield 01"))
		table.insert(Mission.Airfields, FindEntity("Airfield 02"))

	Mission.Airfields[1].Maxplanes = maxplanes
	Mission.Airfields[2].Maxplanes = maxplanes

	Mission.AFEnts = {
		[1] = {},
		[2] = {},
	}

	Mission.CLEnts = {}

	Mission.Catalinas = {}
		table.insert(Mission.Catalinas, FindEntity("PBY Catalina 01"))
		table.insert(Mission.Catalinas, FindEntity("PBY Catalina 02"))
		table.insert(Mission.Catalinas, FindEntity("PBY Catalina 03"))
		for idx,unit in pairs(Mission.Catalinas) do
			PilotMoveOnPath(unit, FindEntity("CatalinaPatrolPath"), PATH_FM_CIRCLE)
		end

	Mission.CatalinaName = "PBY Catalina"

	Mission.Shipyard1Ships = {}
		table.insert(Mission.Shipyard1Ships, FindEntity("PT Boat 80' Elco 01"))
		table.insert(Mission.Shipyard1Ships, FindEntity("PT Boat 80' Elco 02"))
		table.insert(Mission.Shipyard1Ships, FindEntity("PT Boat 80' Elco 03"))
		table.insert(Mission.Shipyard1Ships, FindEntity("PT Boat 80' Elco 04"))
		for idx,unit in pairs(Mission.Shipyard1Ships) do
			NavigatorMoveOnPath(unit, FindEntity("PTPatrolPath"), PATH_FM_CIRCLE)
			unit.patroling = true
		end


	Mission.Shipyard1ShipNames = {}
		table.insert(Mission.Shipyard1ShipNames, "ingame.shipnames_pt|.161")
		table.insert(Mission.Shipyard1ShipNames, "ingame.shipnames_pt|.163")
		table.insert(Mission.Shipyard1ShipNames, "ingame.shipnames_pt|.165")
		table.insert(Mission.Shipyard1ShipNames, "ingame.shipnames_pt|.166")

	Mission.PtNum = 167

	Mission.CapPoints = {
		[1] =  {},
		[2] =  {},
		[3] =  {},
		[4] =  {},
	}
		for i=1,4 do
			table.insert(Mission.CapPoints[1], GetPosition(FindEntity("Airfield1CapPoint 0"..tostring(i))))
			table.insert(Mission.CapPoints[2], GetPosition(FindEntity("Shipyard1CapPoint 0"..tostring(i))))
			table.insert(Mission.CapPoints[3], GetPosition(FindEntity("Shipyard2CapPoint 0"..tostring(i))))
			table.insert(Mission.CapPoints[4], GetPosition(FindEntity("Airfield2CapPoint 0"..tostring(i))))
		end

	Mission.CommandBuildings = {}
		table.insert(Mission.CommandBuildings, FindEntity("Headquarter 01"))				--airfield1
		table.insert(Mission.CommandBuildings, FindEntity("Command Station 01"))		--shipyard1
		table.insert(Mission.CommandBuildings, FindEntity("Command Station 02"))		--shipyard2
		table.insert(Mission.CommandBuildings, FindEntity("Headquarter 02"))				--airfield2
		for idx,cb in pairs(Mission.CommandBuildings) do
			cb.CapPoints = Mission.CapPoints[idx]
		end

	Mission.CBNames = {}
		table.insert(Mission.CBNames, "Island A")
		table.insert(Mission.CBNames, "Island B")
		table.insert(Mission.CBNames, "Island C")
		table.insert(Mission.CBNames, "Island D")

	--Mission.Watermines = {}
	--for i=1,13 do
	--	table.insert(Mission.Watermines, FindEntity("WaterMine 0"..tostring(i)))
	--end
	Mission.MineDetectionPoint = FindEntity("MineDetectionPoint")

	Mission.USNSubs = {}
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 01"))
		--[[table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 02"))
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 03"))
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 04"))
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 05"))
		table.insert(Mission.USNSubs, FindEntity("Narwhal-class Submarine 06"))]]
		for idx,unit in pairs(Mission.USNSubs) do
			SetUnlimitedAirSupply(unit, true)
			TorpedoEnable(unit, true)
		end

	Mission.USNSubNames = {}
		--[[table.insert(Mission.USNSubNames, "USS Narwhal")
		table.insert(Mission.USNSubNames, "USS Nautilus")
		table.insert(Mission.USNSubNames, "USS Dolphin")
		table.insert(Mission.USNSubNames, "USS Pike")
		table.insert(Mission.USNSubNames, "USS Tautog")]]--
		table.insert(Mission.USNSubNames, "ingame.shipnames_spearfish")

	Mission.USNCarrierFleet = {}
	Mission.USNCarrier = nil

		--NavigatorMoveOnPath(Mission.USNCarrierFleet[1], FindEntity("CarrierPath"), PATH_FM_PINGPONG)

	Mission.USNCarrierFleetNames = {}
		table.insert(Mission.USNCarrierFleetNames, {"ingame.shipnames_copahee",12})
		table.insert(Mission.USNCarrierFleetNames, {"ingame.shipnames_augusta",31})
		table.insert(Mission.USNCarrierFleetNames, {"ingame.shipnames_allen_m_sumner",692})
		table.insert(Mission.USNCarrierFleetNames, {"ingame.shipnames_bristol", 857})
		table.insert(Mission.USNCarrierFleetNames, {"ingame.shipnames_drexler",741})


	Mission.CarrierPaths = {}
		table.insert(Mission.CarrierPaths, FindEntity("CarrierPathW"))
		table.insert(Mission.CarrierPaths, FindEntity("CarrierPathE"))

	Mission.USNFleetPath = nil
	Mission.NeedToRecap = false
	Mission.CBsToRecap = {}

	Mission.FirstIslandFleet = {}
		table.insert(Mission.FirstIslandFleet, FindEntity("Atlanta-class 01"))
		table.insert(Mission.FirstIslandFleet, FindEntity("Fletcher-class 01"))
		table.insert(Mission.FirstIslandFleet, FindEntity("Fletcher-class 02"))
		table.insert(Mission.FirstIslandFleet, FindEntity("Fletcher-class 03"))

		JoinFormation(Mission.FirstIslandFleet[2], Mission.FirstIslandFleet[1])
		--JoinFormation(Mission.FirstIslandFleet[3], Mission.FirstIslandFleet[1])
		--JoinFormation(Mission.FirstIslandFleet[4], Mission.FirstIslandFleet[1])


	Mission.FirstIslandFleetNames = {
		"ingame.shipnames_atlanta",
		"ingame.shipnames_taylor",
		"ingame.shipnames_strong",
		"ingame.shipnames_waller",
	}

	Mission.FIFNo = {51,468,467,466}

	Mission.USNFleetNames = {}

	for i,v in pairs(Mission.FirstIslandFleet) do
		SetGuiName(v, Mission.FirstIslandFleetNames[i])
		SetNumbering(v, Mission.FIFNo[i])

		if Mission.Difficulty == 2 then
			SetSkillLevel(v, SKILL_SPVETERAN)
		else
			SetSkillLevel(v, SKILL_SPNORMAL)
		end

	end

	--objectives
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "cap1",
				["Text"] = "ijn11.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "bb",
				["Text"] = "ijn11.obj_s1",
				["TextCompleted"] = "ijn11.obj_s1_completed",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

			[2] = {
				["ID"] = "carrier",
				["Text"] = "ijn11.obj_s2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},

		},
		["hidden"] = {
			[1] = {
				["ID"] = "mine",
				["Text"] = "ijn11.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
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
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM11InitDone",
				},

			},
		},
		["JapSighted1"] = {
			["sequence"] = {
				--[[
				{
					["message"] = "Ok, from now on, even these slow people have realized that something is wrong.",
				},
				{
					["message"] = "Prepare for incoming attacks.",
				},
			},
			]]
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
		["BBSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
			},
		},

		["SubAttack1"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
			},
		},
		["SubAttack2"] = {
			["sequence"] = {
				{
					["message"] = "dlg3b",
				},
			},
		},
		["UnlockUnit"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},

			},
		},
		["CarrierSighted1"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
			},
		},
		["CarrierSighted2"] = {
			["sequence"] = {
				{
					["message"] = "dlg5b",
				},
			},
		},
		["HiddenOK"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},

			},
		},
		["HiddenFailed"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["Cargos"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},

			},
		},
		["AirfieldSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},

			},
		},
		["AirfieldOccupied"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["AirfieldTakenBack"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["AirfieldDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
			},
		},
	}

	LoadMessageMap("ijndlg",11)


	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	luaJM11InitBB()

	--listeners
	luaJM11AddBBReconListener()
	luaJM11AddAKKillListener()
	luaJM11AddCBListener()
	luaJM11AddSubListener()


	luaJM11SetGuiNames()
	luaJM11FadeIn()

	--think
	SetThink(this, "luaJM11_think")

-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
-- RELEASE_LOGOFF  	AddWatch("Mission.NeedToRecap")
-- RELEASE_LOGOFF  	AddWatch("Mission.HiddenOk")

end

function luaJM11_think(this, msg)
	----lualog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		----lualog(this.Name.." mission is terminated!")
		return
	end

	if Mission.ThinkStop then
-- RELEASE_LOGOFF  		luaLog("thinkstop")
		return
	end

	if Mission.EndMission then
		return
	end

	Mission.HintTimer = Mission.HintTimer + 3

--	luaCheckMusic()

	luaJM11CheckObjectives()
	luaJM11CheckUSNSubs()
	luaJM11HintManager()
	luaJM11CheckLanding()
	luaJM11FPSChecker()

	if Mission.MissionPhase == 1 then

		luaJM11JapsInRecon()
		if Mission.JapsSighted then
			luaJM11StartDialog("JapSighted1",true)
			luaJM11StartFirstAttack()
			luaJM11StepPhase()
		end

	elseif Mission.MissionPhase == 2 then

		luaJM11CheckCaptures()
		--luaJM11CaptureCounter()
		--luaJM11CheckCargos()
		if not Mission.FPSCritical then
			luaJM11CheckAirfields()
		end
		--luaJM11CheckShipyards()
		luaJM11CheckFleetSpawnable()

		--luaJM11CheckUSNSubs()
		--luaJM11CheckUSNFleet()

	elseif Mission.MissionPhase == 3 then
		luaJM11CaptureCounter()
	elseif Mission.MissionPhase == 4 then
		if not Mission.USNFleetSpawned then
-- RELEASE_LOGOFF  			luaLog("FLOTTA GENERALAST PROBALOK")
			luaJM11GenerateUSNFleet()
		else
-- RELEASE_LOGOFF  			luaLog("FLOTTA CSEKKOLAS")
			luaJM11CheckUSNFleet()
		end

		luaJM11CheckCaptures()
		--luaJM11CaptureCounter()
		--luaJM11CheckCargos()
		if not Mission.FPSCritical then
			luaJM11CheckAirfields()
		end
		--luaJM11CheckShipyards()
	end

	luaJM11CheckSave()

end

function luaJM11CheckObjectives()

	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerFleet)) == 0 then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn11.obj_missionfailed_npu"
		luaJM11StepPhase(99)
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerTransports)) == 0 then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn11.obj_missionfailed_nak"
		luaJM11StepPhase(99)
	end


	if Mission.MissionPhase < 99 then
		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		end

		if not luaObj_IsActive("primary",1) then
			if Mission.InitDone then
					luaObj_Add("primary",1,Mission.CommandBuildings)

					for i,cb in pairs(Mission.CommandBuildings) do
						SetForcedReconLevel(cb, 2, PARTY_JAPANESE)
						--luaObj_AddUnit("primary", 1, GetPosition(cb))
					end

					ShowHint("IJN11_CBDestroy")


				--luaObj_Add("primary",1, Mission.CommandBuildings)
-- RELEASE_LOGOFF  				luaLog("MOVIE BAZZEG")
				Mission.Pri1MovieDone = true
				--luaDelay(luaJM11Pri1Movie, 10)
			end
			--luaJumpinMovieSetCurrentMovie("GoAround", Mission.CommandBuildings[1].ID)
		elseif luaObj_IsActive("primary",1) and not luaObj_GetSuccess("primary",1) then
			luaJM11CaptureCounter()
			local captured = true
			for idx,cb in pairs(Mission.CommandBuildings) do
				if cb.Party ~= PARTY_JAPANESE then
					captured = false
					break
				end
			end
			if captured then
				Mission.Captured = 4
				--luaJM11CaptureCounter()
				luaObj_Completed("primary",1)
				Mission.MissionSuccess = true
				luaJM11StepPhase(99)
			--else
				--luaObj_Reminder("primary",1)
				--luaJM11CaptureCounter()
			end
		end

		if Mission.BBSighted and not luaObj_IsActive("secondary",1) then
			luaJM11StartDialog("BBSpotted")
			luaJM11IngameMovie(Mission.USBB)
			--luaJumpinMovieSetCurrentMovie("LookAt", Mission.USBB.ID)
			luaObj_Add("secondary",1,Mission.USBB)
			--SetInvincible(Mission.USBB, 0.001)
			DisplayUnitHP({Mission.USBB}, "ijn11.obj_s1")
		end

		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if Mission.USBB.Dead then
				HideUnitHP()
				--luaJM11DeadCam(Mission.USBB)
				luaObj_Completed("secondary",1)
				--luaJM11AddPowerup("full_throttle")
			end
		end

		luaJM11CheckHidden()

		if Mission.HiddenOk then
			--luaObj_Add("hidden",1)
			if luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
				luaObj_Completed("hidden",1)
				if not luaObj_IsActive("marker2",1) then
					luaObj_Add("marker2",1,GetPosition(Mission.MineDetectionPoint))
					Mission.HiddenMarker = true
				end
				--luaJM11AddPowerup("fierce_assault")
				luaJM11StartDialog("HiddenOK",true)
			end
		end

	elseif Mission.MissionPhase == 99 then
		luaJM11CheckCaptures()
		luaJM11CaptureCounter()
		if Mission.MissionSuccess then
			luaDelay(luaJM11EndMovie, 5)
		elseif Mission.MissionFailed then
		    local lastbanto
			local endEnt


			if GetSelectedUnit() and not GetSelectedUnit().Dead then
				lastbanto = GetSelectedUnit().LastBanto
			end

			if lastbanto and not lastbanto.Dead then
				endEnt = lastbanto
			else
				endEnt = nil
			end

			luaMissionFailedNew(endEnt, Mission.FailMsg)
			Mission.EndMission = true
		end
		luaJM11StepPhase()
	end
end

function luaJM11Checkpoint1()
	luaJM11AddPowerup(Mission.PowerUpTbl[1])
	--luaCheckpoint(1,102)
	Blackout(false, "", 1)
end

function luaJM11Checkpoint2()
	luaJM11AddPowerup(Mission.PowerUpTbl[2])
	--luaCheckpoint(2,102)
	luaJM11SpawnPara()
	Blackout(false, "", 1)
end

function luaJM11Checkpoint3()
	luaJM11AddPowerup(Mission.PowerUpTbl[3])
	--luaCheckpoint(3,102)
	Blackout(false, "", 1)
end

function luaJM11Checkpoint4()
	--luaCheckpoint(4,102)
	Blackout(false, "", 1)
end

function luaJM11CheckHidden()
	if Mission.HiddenOk or Mission.HiddenFailed then
-- RELEASE_LOGOFF  		luaLog("returning from hidden")
		return
	end

-- RELEASE_LOGOFF  	luaLog("hidden running")
	ForceRecon()

	local ships = luaGetShipsAroundCoordinate(GetPosition(Mission.MineDetectionPoint), 2000, PARTY_JAPANESE, "own")
	local planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.MineDetectionPoint), 2000, PARTY_JAPANESE, "own", nil, nil, "SmallReconPlane")

	if ships and not planes then
		Mission.HiddenFailed = true
		luaJM11StartDialog("HiddenFailed",true)
		if not luaObj_IsActive("marker2",1) then
			luaObj_Add("marker2",1,GetPosition(Mission.MineDetectionPoint))	
			Mission.HiddenMarker = true
		end

			ships = luaGetShipsAroundCoordinate(GetPosition(Mission.MineDetectionPoint), 4000, PARTY_JAPANESE, "own")
			for i,v in pairs(luaRemoveDeadsFromTable(ships)) do
-- RELEASE_LOGOFF  				luaLog("hajotabla")
-- RELEASE_LOGOFF  				luaLog(ships)
				local rnd = random(1,3)
				luaDelay(luaJM11DelayedEffect, rnd, "ship", v)
				--AddDamage(v, random(1000,2000))
			end

		return
	end

	if (not ships and planes) or (ships and planes) then
		Mission.HiddenOk = true
	end
end

function luaJM11DelayedEffect(timerThis)
-- RELEASE_LOGOFF  	luaLog("aknara fut")
	local v = timerThis.ParamTable.ship
	AddDamage(v, random(2000,3000))
	Effect("MuzzleTorpedoExplosionArmour", ORIGO, v)
end

function luaJM11JapsInRecon()
	for idx,unitTbl in pairs(recon[PARTY_ALLIED].enemy) do
		for idx2,unit in pairs(unitTbl) do
			if unit then
				Mission.JapsSighted = true
				break
			end
		end
	end
end

function luaJM11StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM11CheckMaxplanes(airfield)
	--maxplanes check
	for idx,slot in pairs(GetProperty(airfield,"slots")) do
		if GetAirBaseSlotStatus(airfield,idx) == 5 then
			if airfield.Maxplanes == 0 then
				--MissionNarrativeEnqueue(airfield.Name.." has no more planes")
				--lualog("no more planes")
			else
				airfield.Maxplanes = airfield.Maxplanes - 1
				--lualog("Removing squadron from stock "..airfield.Name)
			end
		end
	end
end

function luaJM11CheckAirfields()

	for idx,airfield in pairs(Mission.Airfields) do

		if airfield.Dead or luaJM11IsDisabled(airfield) or airfield.Party ~= PARTY_ALLIED or airfield.Maxplanes <= 0 then
			----lualog(airfield.Name.." is dead or disabled or captured, turning AI off")
			if luaJM11IsDisabled(airfield) then
				luaJM11StartDialog("AirfieldDisabled",true)
			end
			if not airfield.capturedbyplayer then
				airfield.capturedbyplayer = true
				luaJM11StartDialog("AirfieldOccupied",true)
			end
			if not airfield.emptiedstock then
				luaJM11EmptyStock(airfield)
			end
		else
			--luaJM11CheckMaxplanes(airfield)

			if Mission.Difficulty == 0 and not airfield.emptiedstock then
				if idx == 2 then
					luaJM11EmptyStock(airfield)
				end
			end

			if not Mission.AFSightedDlg and luaJM11IsInRecon(airfield) then
				luaJM11StartDialog("AirfieldSighted",true)
				Mission.AFSightedDlg = true
			end

			if airfield.capturedbyplayer then
				airfield.capturedbyplayer = false
				luaJM11AddStock(airfield)
				luaJM11StartDialog("AirfieldTakenBack",true)
			end

			local fighterClassIDs = {}
			local otherClassIDs = {}
			local equipments = {}
				table.insert(equipments, 1)
				table.insert(equipments, 1)
				table.insert(equipments, 1)

			local phase
			local errorLvl

			if idx == 1 then
				table.insert(fighterClassIDs, 102)
				table.insert(otherClassIDs, 38)
				table.insert(otherClassIDs, 113)
				table.insert(otherClassIDs, 113)
				--table.insert(otherClassIDs, 102) -- corsair, majd visszatenni
			elseif idx == 2 then
				table.insert(fighterClassIDs, 26)
				table.insert(otherClassIDs, 38)
				table.insert(otherClassIDs, 113)
				table.insert(otherClassIDs, 102)
			end

			--luaAirfieldManager(airfield, fighterClassIDs, otherClassIDs, targetList)
			luaCapManager(airfield, fighterClassIDs, 1)
			phase, Mission.AFEnts[idx], errorLvl = luaLaunchAirstrike(1, 3, {airfield}, otherClassIDs, Mission.AFEnts[idx], equipments)



			if errorLvl == 3 then
				local targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
				if next(targetList) == nil then
					targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM11GetUnits("cargo",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM11GetUnits("battleship",PARTY_JAPANESE)
				else
					targetList = luaJM11GetUnits(nil,PARTY_JAPANESE)
				end

				local trg = luaPickRnd(targetList)
				for idx2,squadron in pairs(Mission.AFEnts[idx]) do
					if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
						--lualog("-------------")
						--lualog(squadron)
						local ammo = GetProperty(squadron, "ammoType")
						if ammo ~= 0 then
							luaSetScriptTarget(squadron, trg)
							PilotSetTarget(squadron, trg)
						end
					end
				end
			end
		end
	end

end

function luaJM11ResetSYFlags(timerthis)
	local ID = timerthis.ParamTable.SYID
	local shipyard = thisTable[tostring(ID)]
	if not shipyard.Dead then
		shipyard.Spawns = 0
		shipyard.Suspended = false
	end
end

function luaJM11CheckShipyards()
	for idx,shipyard in pairs(Mission.Shipyards) do
		if shipyard.Dead or luaJM11IsDisabled(shipyard) or shipyard.Party ~= PARTY_ALLIED then
			----lualog(shipyard.Name.." is disabled, dead or captured")
		else
			if shipyard.Spawns >= shipyard.MaxSpawns then
				if not shipyard.Suspended then
					luaDelay(luaJM11ResetSYFlags, 300, "SYID", shipyard.ID)
					shipyard.Suspended = true
				end
			else
				if idx == 2 then --shipyard1
					if table.getn(luaRemoveDeadsFromTable(Mission.Shipyard1Ships)) < shipyard.MaxShips then
						if not SpawnNewIDIsRequested(Mission.Shipyard1Req) then
							--lualog("Requesting fletcher spawn")
							if not luaJM11FleetNear(idx) then
								luaJM11ShipyardSpawn(1)
							end
						end
					end
					for idx2,unit in pairs(luaRemoveDeadsFromTable(Mission.Shipyard1Ships)) do
						if unit.Class.Type ~= "Cargo" then
							if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
								local targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
								if next(targetList) == nil then
									targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
								end
								if next(targetList) == nil then
									targetList = luaJM11GetUnits("cargo",PARTY_JAPANESE)
								end
								if next(targetList) == nil then
									targetList = luaJM11GetUnits("battleship",PARTY_JAPANESE)
								end
								if next(targetList) == nil then
									targetList = luaJM11GetUnits("submarine",PARTY_JAPANESE)
								else
									targetList = luaJM11GetUnits(nil,PARTY_JAPANESE)
								end
								if next(targetList) then
									local trg = luaPickRnd(targetList)
									luaSetScriptTarget(unit, trg)
									TorpedoEnable(unit, true)
									NavigatorAttackMove(unit, trg, {})
								end
							end
						end
						--cargos
						if Mission.NeedToRecap then
							luaJM11DeadCargos()
							if table.getn(Mission.USCargos) < Mission.MaxCargos then
								if not SpawnNewIDIsRequested(Mission.Shipyard1Req) then
									--lualog("Requesting cargo spawn")
									luaJM11CargoSpawn()
								end
							end
							luaJM11DeadCargos()
							for idx2,unit in pairs(Mission.USCargos) do
								if not Mission.CargoDlg then
									if luaJM11IsInRecon(unit) then
										luaJM11StartDialog("Cargos",true)
										Mission.CargoDlg = true
									end
								end

								if unit and not unit.Dead then

									if not unit.toCapTrg then
										luaJM11GetCapTrg(unit)
									else
										if luaGetDistance(unit, unit.toCapTrg) < 200 then
											--lualog("Start cargo landing")
											NavigatorStop(unit)
											local err = StartLanding2(unit)
											local errTbl = {}
												errTbl["0"] = "Big landing ship elindult partraszállni"
												errTbl["1"] = "1 kislandig elindult"
												errTbl["2"] = "2 kislandig elindult"
												errTbl["3"] = "3 kislandig elindult"
												errTbl["4"] = "4 kislandig elindult"
												errTbl["5"] = "5 kislandig elindult"
												errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
												errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
												errTbl["-3"] = "Nemrég indított már, és még cooldown van"
												errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
												errTbl["-5"] = "Nincs command building a pályán"
												errTbl["-6"] = "Csak saját command building van a pályán"
												errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
												--lualog(errTbl[tostring(err)])
												----lualog(err)
										else
											local cmd = GetProperty(unit, "unitcommand")
											if cmd ~= "moveto" then
												NavigatorMoveToRange(unit, unit.toCapTrg)
											end
										end
									end

								end
							end
						else
							luaJM11DeadCargos()
							for idx,unit in pairs(Mission.USCargos) do

								if unit.toCapTrg then
									--lualog("captrg")
									--lualog(unit.toCapTrg)
									luaJM11ActiveDestFlag(unit.toCapTrg, false)
									unit.toCapTrg = nil
									NavigatorStop(unit)
								end

								local ownCbs = {}
								for idx2,cb in pairs(Mission.CommandBuildings) do
									if cb.Party == PARTY_ALLIED then
										table.insert(ownCbs, cb)
									end
								end

								local nearestTrg = luaSortByDistance(unit, ownCbs, true)
								if nearestTrg and GetProperty(unit, "unitcommand") ~= "moveto" then
									NavigatorMoveToRange(unit, nearestTrg)
								end

							end
						end
					end
				elseif idx == 1 then --shipyard2
					if table.getn(luaRemoveDeadsFromTable(Mission.Shipyard2Ships)) < shipyard.MaxShips then
						if not SpawnNewIDIsRequested(Mission.Shipyard2Req) then
							--lualog("Requesting elco spawn")
							if not luaJM11FleetNear(idx) then
								--luaJM11ShipyardSpawn(2)
							end
						end
					end
					for idx2,unit in pairs(luaRemoveDeadsFromTable(Mission.Shipyard2Ships)) do
						if unit.patroling or luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							local trgL1 = luaJM11GetUnits(nil,PARTY_JAPANESE)
							local trgL2 = luaJM11GetUnits("submarine",PARTY_JAPANESE)

							local targetList = luaSumTables(trgL1, trgL2)

							----lualog("Getting trg for pts")
							if next(targetList) then
								----lualog("trg list not empty")
								local nearestTrg, dist = luaSortByDistance(unit, targetList, true)
								if nearestTrg and dist < 2000 then
									----lualog("trg in range initiationg attack")
									luaSetScriptTarget(unit, nearestTrg)
									TorpedoEnable(unit, true)
									NavigatorAttackMove(unit, nearestTrg, {})
									unit.patroling = false
								else
									----lualog("no trg for pt")
									NavigatorMoveOnPath(unit, FindEntity("PTPatrolPath"), PATH_FM_CIRCLE)
									unit.patroling = true
								end
							end
						end
					end
				end
			end
		end
	end
end

function luaJM11ShipyardSpawn(num)
	local grpTbl = {}
	local cb = {"luaJM11Shipyard1ShipSpawned"}
	local SID = {Mission.Shipyard1Req}
	local lookAt = {FindEntity("Sh1Lookat"), FindEntity("Shipyard2CapPoint 03")}

	if num == 2 then --SY1
		table.insert(grpTbl, {["Type"] = 23,["Name"] = "Fletcher",["Crew"] = 1,["Race"] = USA,} )
	elseif num == 1 then --SY2
		table.insert(grpTbl, {["Type"] = 27,["Name"] = "Elco PT 80'",["Crew"] = 1,["Race"] = USA,} )
	end

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = GetPosition(Mission.Shipyards[num].SpawnPoint),
		["angleRange"] = { luaJM11RAD(45), luaJM11RAD(155) },
		["lookAt"] = GetPosition(lookAt[num])
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = cb[num],
	["id"] = SID[num],
	})
end

function luaJM11Shipyard2ShipSpawned(unit)
	table.insert(Mission.Shipyard1Ships, unit)
	SetGuiName(unit, Mission.FletcherNamePool.Names[Mission.FletcherCounter])
	SetNumbering(unit, Mission.FletcherNamePool.Numbers[Mission.FletcherCounter])

	if Mission.FletcherCounter < 17 then
		Mission.FletcherCounter = Mission.FletcherCounter + 1
	else
		Mission.FletcherCounter = 1
	end
	Mission.Shipyards[1].Spawns = Mission.Shipyards[1].Spawns + 1
end

function luaJM11Shipyard1ShipSpawned(unit)
	table.insert(Mission.Shipyard2Ships, unit)
	SetGuiName(unit, "ingame.shipnames_pt|."..tostring(Mission.PtNum))
	Mission.PtNum = Mission.PtNum + 1
	Mission.Shipyards[2].Spawns = Mission.Shipyards[2].Spawns + 1
end

function luaJM11CargoSpawn()
	local grpTbl = {}
	table.insert(grpTbl, {["Type"] = 36,["Name"] = "US Troop Transport",["Crew"] = 1,["Race"] = USA,} )

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl,
	["area"] = {
		["refPos"] = GetPosition(Mission.Shipyards[1].SpawnPoint),
		["angleRange"] = { luaJM11RAD(45), luaJM11RAD(155) },
		["lookAt"] = GetPosition(FindEntity("Shipyard1CapPoint 02"))
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM11Shipyard1CargosSpawned",
	["id"] = Mission.Shipyard1CargoReq,
	})
end

function luaJM11Shipyard1CargosSpawned(unit)
	table.insert(Mission.USCargos, unit)
	SetGuiName(unit, "US Troop Transport") -- nem hivodik!
end

function luaJM11DeadCargos()
	for idx,unit in pairs(Mission.USCargos) do
		if unit.Dead then
			if unit.toCapTrg then
				luaJM11ActiveDestFlag(unit.toCapTrg,false)
			end
			table.remove(Mission.USCargos, idx)
		end
	end
end

function luaJM11GetCapTrg(unit)
	--megkeresni a legkozelebbi cap pointot
	local capPoints = {}
	for idx,cb in pairs(Mission.CBsToRecap) do
		for idx2,point in pairs(cb.CapPoints) do
			table.insert(capPoints, point)
		end
	end

	local dist = 10000000
	local point

	for idx,cpoint in pairs(capPoints) do
		if not cpoint.activeDest and luaGetDistance(cpoint, unit) < dist then
			point = cpoint
		end
	end

	if point then
		unit.toCapTrg = point
		luaJM11ActiveDestFlag(point,true)
		NavigatorMoveToRange(unit, point)
	end
end

function luaJM11ActiveDestFlag(point,add)
	--lualog("activate dest flag")
	--lualog(point)
	for idx,cb in pairs(Mission.CommandBuildings) do
		local inside = luaJM11IsInsideCoord(point, cb.CapPoints)
		if inside then
			if add then
				cb.CapPoints[inside].activeDest = true
			else
				cb.CapPoints[inside].activeDest = false
			end
			return
		end
	end
end

function luaJM11CheckCaptures()
	for idx,cb in pairs(Mission.CommandBuildings) do
		if cb.Party == PARTY_JAPANESE then
			if not luaIsInside(cb, Mission.CBsToRecap) then
				table.insert(Mission.CBsToRecap, cb)
--				if not Mission.SavedCheckpoint then
					--luaJM11AddPowerup(luaPickRnd(Mission.PowerUpTbl))
				--end
			end
		elseif cb.Party ~= PARTY_JAPANESE then
			local idx2 = luaIsInside(cb, Mission.CBsToRecap)
			if idx2 then
				table.remove(Mission.CBsToRecap, idx2)
			end
		end
	end

	if Mission.NeedToRecap and table.getn(Mission.CBsToRecap) == 0 then
		Mission.NeedToRecap = false
	elseif not Mission.NeedToRecap and table.getn(Mission.CBsToRecap) > 0 then
		Mission.NeedToRecap = true
	end
end

function luaJM11RAD(x)
	return x *  0.0174532925
end

function luaJM11IsDisabled(ent)
	if not luaIsEntityTable({ent},false) then
		--lualog("luaJM11IsDisabled got a wrong param")
		--lualog(ent.Name)
		return
	end

	if GetFailure(ent, "InferiorFailure") then
		return true
	end

	return false
end

function luaJM11GetUnits(searchedType,searchedParty)
	local returnTbl = {}

	if type(searchedType) == "string" then --and recon[PARTY_JAPANESE].own.searchedType then
		for idx,unit in pairs(recon[searchedParty].own[searchedType]) do
			if not unit.Dead then
				----lualog("Inserting "..unit.Name.." intotargetlist")
				table.insert(returnTbl, unit)
			end
		end
	else
		----lualog("No param or wrong param returning all jap ships")
		for idx,unitTbl in pairs(recon[searchedParty].own) do
			for idx2,unit in pairs(unitTbl) do
				if not unit.Dead and luaGetType(unit) == "ship" then-- or luaGetType(unit) == "sub" then
					----lualog("Inserting "..unit.Name.." intotargetlist")
					table.insert(returnTbl, unit)
				end
			end
		end
	end

	----lualog("Getunits return tbl")
	----lualog(returnTbl)
	return returnTbl
end

function luaJM11IsInsideCoord(trg, tbl)
	local x = trg.x
	local y = trg.y
	local z = trg.z
	for idx,coordTbl in pairs(tbl) do
		if coordTbl.x == x and coordTbl.y == y and coordTbl.z == z then
			return idx
		end
	end
	return false
end

function luaJM11InitBB()
	Mission.USBB = FindEntity("BB")
	NavigatorStop(Mission.USBB)
	NavigatorSetTorpedoEvasion(Mission.USBB, false)
	RepairEnable(Mission.USBB, false)
	--SetInvincible(Mission.USBB, 0.001)
	AddDamage(Mission.USBB, Mission.USBB.Class.HP*0.32)
	SetGuiName(Mission.USBB, "ingame.shipnames_south_dakota")
	Effect("GiantSmoke", {["x"]=0,["y"]=0,["z"]=0}, Mission.USBB)
end

function luaJM11CheckUSNFleet()

	if luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil then
		if Mission.USNCarrier.Dead then
			HideUnitHP()
			--luaJM11DeadCam(Mission.USNCarrier)
			luaObj_Completed("secondary",2)
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.USNCarrierFleet)) == 0 then
		return
	else
		if Mission.CarriersDead then

			Mission.USNCarrierFleet = luaRemoveDeadsFromTable(Mission.USNCarrierFleet)

			for idx,unit in pairs(Mission.USNCarrierFleet) do
				targetList = luaJM11GetUnits(nil,PARTY_JAPANESE)
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					local trg = luaPickRnd(targetList)
					if trg then
						luaSetScriptTarget(unit, trg)
						NavigatorAttackMove(unit, trg, {})
					else
						if GetProperty(unit, "unitcommand") ~= "moveonpath" then
							NavigatorMoveOnPath(unit, Mission.USNFleetPath, PATH_FM_PINGPONG)
						end
					end
				end
			end

		else

			local carriers = false
			--local checkDone = false

			Mission.USNCarrierFleet = luaRemoveDeadsFromTable(Mission.USNCarrierFleet)

			for idx,unit in pairs(Mission.USNCarrierFleet) do
				SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
				carriers = true
				if unit.Class.Type == "MotherShip" then

					if not Mission.CarrierDlg then
						--if luaJM11IsInRecon(unit) then
							luaJM11StartDialog("CarrierSighted1",true)
							luaJM11StartDialog("CarrierSighted2",true)
							if not luaObj_IsActive("secondary",2) then
								luaObj_Add("secondary",2,Mission.USNCarrier)
								luaJM11IngameMovie(Mission.USNCarrier)
								--SetInvincible(Mission.USNCarrier, 0.001)
								DisplayUnitHP({Mission.USNCarrier}, "ijn11.obj_s2")
							end
						--end
						Mission.CarrierDlg = true
					end

					Mission.CarriersDead = false

					if GetProperty(unit, "unitcommand") ~= "moveonpath" then
						NavigatorMoveOnPath(unit, Mission.USNFleetPath, PATH_FM_PINGPONG)
					end

					local fighterClassIDs = {}
					local otherClassIDs = {}
					local phase
					local errorLvl

					table.insert(fighterClassIDs, 102)
					table.insert(otherClassIDs, 38)
					table.insert(otherClassIDs, 113)

					--luaAirfieldManager(airfield, fighterClassIDs, otherClassIDs, targetList)
					luaCapManager(unit, fighterClassIDs, 1)
					phase, Mission.CLEnts, errorLvl = luaLaunchAirstrike(1, 2, {unit}, otherClassIDs, Mission.CLEnts)

					if errorLvl == 3 then
						local targetList = luaJM11GetUnits("cargo",PARTY_JAPANESE)
						if next(targetList) == nil then
							targetList = luaJM11GetUnits("cargo",PARTY_JAPANESE)
						end
						if next(targetList) == nil then
							targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
						end
						if next(targetList) == nil then
							targetList = luaJM11GetUnits("battleship",PARTY_JAPANESE)
						else
							targetList = luaJM11GetUnits(nil,PARTY_JAPANESE)
						end

						local trg = luaPickRnd(targetList)
						for idx2,squadron in pairs(Mission.CLEnts) do
							if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
								local ammo = GetProperty(unit, "ammoType")
								if ammo ~= 0 then
									luaSetScriptTarget(squadron, trg)
									PilotSetTarget(squadron, trg)
								end
							end
						end
					end

				else -- if mothership

					--if not checkDone then

						local leader = GetFormationLeader(Mission.USNCarrierFleet[1])
						if not leader or leader.Dead then
							if Mission.USNCarrierFleet[1] and not Mission.USNCarrierFleet[1].Dead then
								leader = Mission.USNCarrierFleet[1]
							else
								--lualog("valami gaz van se leader se semmi")
								return
							end
						end

						local shipsaround = luaGetShipsAround(unit, 3200, "enemy")

						if shipsaround then
							if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
								if IsInFormation(unit) then
									LeaveFormation(unit)
								end
								local trg = luaPickRnd(shipsaround)
								luaSetScriptTarget(unit, trg)
								NavigatorAttackMove(unit, trg, {})
								if unit.Class.Type == "Destroyer" then
									luaJM11CheckTorps(unit)
									TorpedoEnable(unit, true)
								end
							end
						else
							if not IsInFormation(unit) and unit.ID ~= leader.ID then
								JoinFormation(unit, leader)
							else
								--[[if GetProperty(unit, "unitcommand") ~= "moveonpath" then
									NavigatorMoveOnPath(unit, Mission.USNFleetPath, PATH_FM_PINGPONG)
								end]]--
							end
						end
						--checkDone = true

					--end
				end
			end --for

			if carriers and Mission.CarriersDead then
				Mission.CarriersDead = false
			elseif not carriers then
				Mission.CarriersDead = true
			end

		end
	end
end

function luaJM11CheckUSNSubs()
	if Mission.SubSighted then

		if table.getn(luaRemoveDeadsFromTable(Mission.USNSubs)) == 0 then
			return
		end
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNSubs)) do

			if not Mission.SubDlg then
				if luaJM11IsInRecon(unit) then
					luaJM11StartDialog("SubAttack1",true)
					luaJM11StartDialog("SubAttack2",true)
					Mission.SubDlg = true
				end
			end

			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				local targetList = luaJM11GetUnits("battleship",PARTY_JAPANESE)
				if next(targetList) == nil then
					targetList = luaJM11GetUnits("battleship",PARTY_JAPANESE)
				end
				if next(targetList) ~= nil then
					targetList = luaJM11GetUnits("mothership",PARTY_JAPANESE)
				end
				if next(targetList) ~= nil then
					targetList = luaJM11GetUnits("cargo",PARTY_JAPANESE)
				else
					targetList = luaJM11GetUnits(nil,PARTY_JAPANESE)
				end
				local trg = luaPickRnd(targetList)
				if trg then
					--TorpedoEnable(unit, true) --inittime megvolt
					luaJM11CheckTorps(unit)
					luaSetScriptTarget(unit, trg)
					NavigatorAttackMove(unit, trg, {})
				end
			end
		end
	end
end

function luaJM11CheckTorps(unit)
	local torps = GetProperty(unit, "TorpedoStock")
	if torps == 0 then
		ReloadTorpedoes(unit, unit.Class.MaxTorpedoStock)
	end
end

function luaJM11AddBBReconListener()
	AddListener("recon", "BBrecon", {
		["callback"] = "luaJM11BBSighted",  -- callback fuggveny
		["entity"] = {Mission.USBB}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})
end

function luaJM11BBSighted()
	RemoveListener("recon", "BBrecon")
	Mission.BBSighted = true
	ShowHint("IJN11_BB")
	ShowHint("IJN11_Torp")
end

function luaJM11AddSubListener()
	AddListener("recon", "Subrecon", {
		["callback"] = "luaJM11SubSighted",  -- callback fuggveny
		["entity"] = {Mission.USNSubs[1]}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})
end

function luaJM11SubSighted()
	RemoveListener("recon", "Subrecon")
	Mission.SubSighted = true
	ShowHint("IJN11_SubDC")
end


function luaJM11AddCVListener()
	AddListener("recon", "CVrecon", {
		["callback"] = "luaJM11CVSighted",  -- callback fuggveny
		["entity"] = {Mission.USNCarrier}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})
end

function luaJM11CVSighted()
	RemoveListener("recon", "CVrecon")
	Mission.CVSighted = true
	--ShowHint("IJN11_SubDC")
end

function luaJM11AddAKKillListener()
	AddListener("kill", "AKKilled", {
		["callback"] = "luaJM11AKKilled",  -- callback fuggveny
		["entity"] = Mission.PlayerTransports, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM11AKKilled()
	RemoveListener("kill","AKKilled")
	ShowHint("IJN11_AK")
end


function luaJM11AddCBListener()
	AddListener("recon", "CBrecon", {
		["callback"] = "luaJM11CBSighted",  -- callback fuggveny
		["entity"] = Mission.CommandBuildings, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE},
		})
end

function luaJM11CBSighted()
	RemoveListener("recon", "CBrecon")
	Mission.CBSighted = true
end


function luaJM11EmptyStock(airfield)
	airfield.emptiedstock = true
	RemoveAllAirBasePlanes(airfield)
end

function luaJM11AddStock(airfield)
	AddAirBasePlanes(airbase, 102, 12)
	AddAirBasePlanes(airbase, 113, 12)
	AddAirBasePlanes(airbase, 38, 12)
	AddAirBasePlanes(airbase, 26, 12)
end

function luaJM11AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM11FadeIn()
	luaCheckSavedCheckpoint()

	if not Mission.CheckpointLoaded then
		--SoundFade(1, "",0.1)
		Blackout(false, "", 2)
		luaDelay(luaJM11InitDlg, 1)
		if Mission.PlayerSub then
			luaDelay(luaJM11SubDlg, 3)
		end
--		EnableInput(true)
	else
		Mission.ThinkStop = true
		Blackout(true, "", 0)
	end
end

function luaJM11InitDlg()
	luaJM11StartDialog("Init",true)
	--EnableInput(true)
	luaJM11AddPowerup("fierce_assault")
end

function luaJM11StartDialog(dialogID, log, ignorePrinted)
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
		--lualog("Dialog started. ID: "..dialogID)
	end
end

function luaJM11IsInRecon(unit)
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

function luaJM11SubDlg()
	luaJM11StartDialog("UnlockUnit",true)
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(8)
	PrepareClass(11)
	PrepareClass(19)
	PrepareClass(23)
	PrepareClass(24)
	PrepareClass(26)
	PrepareClass(27)
	PrepareClass(234)
	PrepareClass(38)
	PrepareClass(102)
	PrepareClass(108)
	PrepareClass(113)
	PrepareClass(116)
	PrepareClass(118)
	PrepareClass(150)
	PrepareClass(158)
	PrepareClass(163)
	PrepareClass(167)
	PrepareClass(159)
	Loading_Finish()
end

function luaJM11SetGuiNames()
	--lualog("allitom a guineveket")

	--[[for idx, cb in pairs(Mission.Airfields) do
		--SetGuiName(cb, "Airfield "..tostring(idx))
	end

	for idx, cb in pairs(Mission.Shipyards) do
		--SetGuiName(cb, "Shipyard "..tostring(idx))
	end]]


	for idx, unit in pairs(Mission.PlayerFleet) do
		if IsClassChanged(unit.Class.ID) then
			luaSetUnlockName(unit)
		else
-- RELEASE_LOGOFF  			luaLog("or else, not changed... "..unit.Class.Name)
			SetGuiName(unit, Mission.PlayerFleetNames[idx])
		end
		
		--SetInvincible(unit, true)
		
		--SetGuiName(unit, Mission.PlayerFleetNames[idx])
	end

	for idx, unit in pairs(Mission.USCargos) do
		SetGuiName(unit, Mission.USCargoNames[idx])
		SetNumbering(unit, 0)
	end

	--[[for idx, unit in pairs(Mission.Catalinas) do
		--SetGuiName(unit, Mission.CatalinaName)
	end]]

	--[[for idx, unit in pairs(Mission.Shipyard2Ships) do
		SetGuiName(unit, Mission.Shipyard2ShipNames[idx])
-- RELEASE_LOGOFF  		luaLog(unit.Name.." "..tostring(Mission.Shipyard2ShipNames[idx]))
	end]]

	for idx, unit in pairs(Mission.USNSubs) do
		SetGuiName(unit, Mission.USNSubNames[idx])
	end
end

function luaJM11GenerateUSNFleet()
		if Mission.CommandBuildings[2].Party == PARTY_JAPANESE or Mission.CommandBuildings[3].Party == PARTY_JAPANESE then

-- RELEASE_LOGOFF  			luaLog("GENERALOM A CARRIERFLOTTAT")
			local lookAt = FindEntity("LookAt")
			local spawnPoint

			if Mission.CommandBuildings[2].Party == PARTY_JAPANESE then
				spawnPoint = FindEntity("Spawn 02")
				Mission.USNFleetPath = Mission.CarrierPaths[2]
			elseif Mission.CommandBuildings[3].Party == PARTY_JAPANESE then
				spawnPoint = FindEntity("Spawn 01")
				Mission.USNFleetPath = Mission.CarrierPaths[1]
			end

-- RELEASE_LOGOFF  			luaLog(spawnPoint)

			local fighterType = 102
			local bomberType = 38
			local tBomberType = 113

			local fighterStock = {["Type"] = fighterType, ["Count"] = 12, ["SquadLimit"] = 3}
			local fighterSlot = {["Type"] = fighterType, ["Arm"] = 0, ["Count"] = 3}
			local bomberStock = {["Type"] = bomberType, ["Count"] = 12, ["SquadLimit"] = 3}
			local bomberSlot = {["Type"] = bomberType, ["Arm"] = 1, ["Count"] = 3}
			local tBomberStock = {["Type"] = tBomberType, ["Count"] = 12, ["SquadLimit"] = 3}
			local tBomberSlot = {["Type"] = tBomberType, ["Arm"] = 1, ["Count"] = 3}

			local carrier = {
					["Type"] = 24,
					["Name"] = "USS Copahee",
					["Crew"] = 2,
					["Race"] = JAPAN,
					["NumSlots"] = 4,
					["MaxInAirPlanes"] = 12,
							["PlaneStock 1"] = fighterStock,
							["Slot 1"] = fighterSlot,
							["PlaneStock 2"] = tBomberStock,
							["Slot 2"] = tBomberSlot,
							["PlaneStock 3"] = tBomberStock,
							["Slot 3"] = tBomberSlot,
							["PlaneStock 4"] = bomberStock,
							["Slot 4"] = bomberSlot,
				}

			local grpTbl = {}
				table.insert(grpTbl, carrier )
				table.insert(grpTbl, {["Type"] = 19,["Name"] = "USS Augusta",["Crew"] = 2,["Race"] = USA,} )
				table.insert(grpTbl, {["Type"] = 11,["Name"] = "USS Allen M. Sumner",["Crew"] = 2,["Race"] = USA,} )
				--table.insert(grpTbl, {["Type"] = 11,["Name"] = "USS Bristol",["Crew"] = 2,["Race"] = USA,} )
				--table.insert(grpTbl, {["Type"] = 11,["Name"] = "USS Drexler",["Crew"] = 2,["Race"] = USA,} )


		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = grpTbl,
			["area"] = {
				["refPos"] = GetPosition(spawnPoint),
				["angleRange"] = { luaJM11RAD(45), luaJM11RAD(155) },
				["lookAt"] = GetPosition(lookAt)
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM11USNFleetSpawned",
			--["id"] = SID[num],
			})
	end
end

function luaJM11USNFleetSpawned(...)
	for idx,unit in ipairs(arg) do
		table.insert(Mission.USNCarrierFleet, unit)

		if Mission.Difficulty == 2 then
			SetSkillLevel(unit, SKILL_SPVETERAN)
		else
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end

		if unit.Class.ID == 24 then
			Mission.USNCarrier = unit
--			SetGuiName(unit, Mission.USNCarrierFleetNames[1])
--			SetNumbering(unit, 12)
			NavigatorMoveOnPath(unit, Mission.USNFleetPath, PATH_FM_PINGPONG)
		end
	end


	--meg kell nezni, hogy a lespawnolas sorrendje jo-e

	for idx, unit in pairs(Mission.USNCarrierFleet) do
		SetGuiName(unit, Mission.USNCarrierFleetNames[idx][1])
		if Mission.USNCarrierFleetNames[idx][2] then
			SetNumbering(unit, Mission.USNCarrierFleetNames[idx][2])
		end
	end


	Mission.USNFleetSpawned = true
end

function luaJM11CheckFleetSpawnable()
	local cbCapt = 0
	for idx,cb in pairs(Mission.CommandBuildings) do
		if cb.Party == PARTY_JAPANESE then
			cbCapt = cbCapt + 1
		end
	end

	if cbCapt == 3 then
		luaJM11StepPhase(4)
	end
end

function luaJM11HintManager()

	Mission.Hints = {
		[1] = "IJN11_CarrierCAP",
		[2] = "IJN11_FormationShape",
		[3] = "IJN11_CleverBB",
		[4] = "IJN11_Island",
	}

	if not Mission.CBRecapHint then
		for idx, cb in pairs(Mission.CommandBuildings) do
			if cb.Party ~= PARTY_ALLIED then
				Mission.CBRecapHint = true
				ShowHint("IJN11_CBRecap")
			end
		end
	end

	if table.getn(Mission.Hints) ~= 0 and Mission.HintTimer > 59 then
		if math.fmod(Mission.HintTimer, Mission.HintDelay) == 0 then
			local hintidx = random(1,table.getn(Mission.Hints))
			ShowHint(Mission.Hints[hintidx])
			table.remove(Mission.Hints, hintidx)
		end
	end

end


function luaJM11CaptchaE()
	Mission.CommandBuildings[1].Party = PARTY_JAPANESE
	Mission.CommandBuildings[2].Party = PARTY_JAPANESE
	Mission.CommandBuildings[4].Party = PARTY_JAPANESE
end

function luaJM11CaptchaW()
	Mission.CommandBuildings[1].Party = PARTY_JAPANESE
	Mission.CommandBuildings[3].Party = PARTY_JAPANESE
	Mission.CommandBuildings[4].Party = PARTY_JAPANESE
end

function luaJM11Pri1Movie()
-- RELEASE_LOGOFF  	luaLog("ELSO MOVIE HIVAS")
-- RELEASE_LOGOFF  	luaLog("HIVTA: "..debug.traceback())

	Mission.MovieInProgress = true
	Mission.SelectedUnit = GetSelectedUnit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 259, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 10, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.CommandBuildings[2], ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.CommandBuildings[2], ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Shipyards[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 20, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Shipyards[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 300, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[2], ["distance"] = 500, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[2], ["distance"] = 200, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 5},
		},	luaJM11MovieEnd )

	--luaDelay(luaJM11SubtitleChecker, 1)
end

function luaJM11EndMovie()
	Mission.MovieInProgress = true
	Mission.SelectedUnit = GetSelectedUnit()

	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		luaIngameMovie(
			{
			   {["postype"] = "cameraandtarget", ["target"] = Mission.SelectedUnit, ["distance"] = 200, ["theta"] = 15, ["rho"] = 150, ["moveTime"] = 0},
			   {["postype"] = "cameraandtarget", ["target"] = Mission.SelectedUnit, ["distance"] = 500, ["theta"] = 75, ["rho"] = 50, ["moveTime"] = 15},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.CommandBuildings[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 350, ["moveTime"] = 0,},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.CommandBuildings[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 10, ["moveTime"] = 5},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.Shipyards[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 350, ["moveTime"] = 0,},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.Shipyards[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 10, ["moveTime"] = 5},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 350, ["moveTime"] = 0},
			   --{["postype"] = "cameraandtarget", ["target"] = Mission.Airfields[2], ["distance"] = 300, ["theta"] = 45, ["rho"] = 10, ["moveTime"] = 5},
			},	luaJM11EndMovieEnd )
	else
		luaJM11EndMovieEnd()
	end

	--luaDelay(luaJM11SubtitleChecker, 1)
end

function luaJM11MovieEnd()
-- RELEASE_LOGOFF  	luaLog("ELSO MOVIE ELNYOMAS")


	Mission.MovieInProgress = false
	SetSelectedUnit(Mission.SelectedUnit)
	EnableInput(true)
	luaObj_Add("primary",1,Mission.CommandBuildings)

	for i,cb in pairs(Mission.CommandBuildings) do
		SetForcedReconLevel(cb, 2, PARTY_JAPANESE)
		--luaObj_AddUnit("primary", 1, GetPosition(cb))
	end

	ShowHint("IJN11_CBDestroy")

end

function luaJM11SubtitleChecker()
	if Mission.MovieInProgress then
		local unit = luaGetCamTargetEnt()
		if luaIsInside(unit, Mission.Airfields) or luaIsInside(unit, Mission.Shipyards) then
			if not unit.NameWritten then
				MissionNarrativeUrgent(GetGuiName(unit))
				unit.NameWritten = true
			end
		end

	luaDelay(luaJM11SubtitleChecker, 1)
	end
end

function luaJM11CaptureCounter()
	Mission.Captured = table.getn(Mission.CBsToRecap)
	DisplayScores(1,0,"ijn11.obj_p1","ijn11.captured")
end

function luaJM11InitDone()
	Mission.InitDone = true
end

function luaJM11IngameMovie(target)
	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end

	luaIngameMovie(
		{
--		   {["postype"] = "cameraandtarget", ["target"] = target, ["distance"] = 1500, ["theta"] = 5, ["rho"] = 105, ["moveTime"] = 10},
		   {["postype"] = "cameraandtarget", ["target"] = target, ["distance"] = 400, ["theta"] = 5, ["rho"] = 105, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = target, ["distance"] = 200, ["theta"] = 5, ["rho"] = 105, ["moveTime"] = 5},
		},	luaJM11IngameMovieEnd )
end

function luaJM11IngameMovieEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, false)
		SetSelectedUnit(Mission.SelectedUnit)
	else
		Mission.PlayerFleet = luaRemoveDeadsFromTable(Mission.PlayerFleet)
		if Mission.PlayerFleet[1] and not Mission.PlayerFleet[1].Dead then
			SetSelectedUnit(Mission.PlayerFleet[1])
		end
	end
	EnableInput(true)
end

function luaJM11EndMovieEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, false)
		--SetSelectedUnit(Mission.SelectedUnit)
	end
	EnableInput(true)
	luaMissionCompletedNew(nil, "ijn11.obj_missioncompleted")
	luaJM11StepPhase()
	Mission.EndMission = true
end

function luaJM11CheckLanding()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerTransports)) do
		for idx2,cb in pairs(Mission.CommandBuildings) do
			if cb and not cb.Dead and unit and not unit.Dead then
				if luaGetDistance(cb, unit) < 1600 then
					local err = StartLanding2(unit)

					if err > 0 then
-- RELEASE_LOGOFF  						luaLog("landing indul")
						if not cb.LandingCam then
							cb.LandingCam = true
							--luaDelay(luaJM11AddLandingListener, 3)
						end
					end
				end
			end
		end
	end
end

function luaJM11AddLandingListener()
	local lShips = luaGetShipsAround(GetSelectedUnit(), 25000, "own", nil, nil, "landingship", nil)

	if not IsListenerActive("shipLanded", "landingListener") then
-- RELEASE_LOGOFF  		luaLog("izzitom a listenert")
-- RELEASE_LOGOFF  		luaLog(lShips)
-- RELEASE_LOGOFF  		luaLog("-------------------")
		AddListener("shipLanded", "landingListener", {
			["callback"] = "luaJM11ShipsLanded",  -- callback fuggveny
			["entity"] = lShips, -- entityk akiken a listener aktiv
		})
	end

end

function luaJM11ShipsLanded(ship)
-- RELEASE_LOGOFF  	luaLog("landing callback")
	RemoveListener("shipLanded", "landingListener")

	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end

	local nearest = luaSortByDistance2(ship, Mission.CommandBuildings)[1]

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 350, ["theta"] = 15, ["rho"] = 145, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 100, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = nearest, ["distance"] = 500, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 10},
		},	luaJM11IngameMovieEnd )

end

function luaJM11FleetNear(idx)
	for i,unit in pairs(luaRemoveDeadsFromTable(Mission.PlayerFleet)) do
		if luaGetDistance(unit, Mission.Shipyards[idx]) > 1000 then
			return false
		else
			return true
		end
	end
end

function luaJM11DeadCam(ship)
	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end

	if ship and not ship.Dead then
		SetInvincible(ship, false)
		AddDamage(ship, 9999999)

		luaIngameMovie(
			{
			   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 300, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			   {["postype"] = "cameraandtarget", ["target"] = ship, ["distance"] = 300, ["theta"] = 5, ["rho"] = 305, ["moveTime"] = 8},
			},	luaJM11DeadCamEnd )
	else
		luaJM11DeadCamEnd()
	end

end

function luaJM11DeadCamEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, false)
		SetSelectedUnit(Mission.SelectedUnit)
	end

	EnableInput(true)
end

function luaJM11CheckCargos()
	if table.getn(luaRemoveDeadsFromTable(Mission.USCargos)) == 0 then
		return
	end

	for idx2,unit in pairs(luaRemoveDeadsFromTable(Mission.USCargos)) do
		if not Mission.CargoDlg then
			if luaJM11IsInRecon(unit) then
				luaJM11StartDialog("Cargos",true)
				Mission.CargoDlg = true
			end
		end

		if unit and not unit.Dead then

			if not unit.toCapTrg then
				luaJM11GetCapTrg(unit)
			else
				if luaGetDistance(unit, unit.toCapTrg) < 500 then
					--lualog("Start cargo landing")
					NavigatorStop(unit)
					local err = StartLanding2(unit)
					local errTbl = {}
						errTbl["0"] = "Big landing ship elindult partraszállni"
						errTbl["1"] = "1 kislandig elindult"
						errTbl["2"] = "2 kislandig elindult"
						errTbl["3"] = "3 kislandig elindult"
						errTbl["4"] = "4 kislandig elindult"
						errTbl["5"] = "5 kislandig elindult"
						errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
						errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
						errTbl["-3"] = "Nemrég indított már, és még cooldown van"
						errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
						errTbl["-5"] = "Nincs command building a pályán"
						errTbl["-6"] = "Csak saját command building van a pályán"
						errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
						--lualog(errTbl[tostring(err)])
						----lualog(err)
				else
					local cmd = GetProperty(unit, "unitcommand")
					if cmd ~= "moveto" then
						NavigatorMoveToRange(unit, unit.toCapTrg)
					end
				end
			end
	end
end
end

function luaJM11StartFirstAttack()
	local trg = Mission.PlayerFleet[random(1,table.getn(luaRemoveDeadsFromTable(Mission.PlayerFleet)))]
	NavigatorAttackMove(Mission.FirstIslandFleet[1], trg, {})
end

-----------------checkpoint-----------------
function luaJM11CheckSave()
	--Command Station 01 - 1
	--Headquarter 01 - 2
	--Headquarter 02 - 3
	--Command Station 02 - 4

	if Mission.MissionPhase >= 99 then
		return
	end

	if not Mission.SavedChecks[1] and FindEntity("Command Station 01").Party == PARTY_JAPANESE then
		Mission.SavedChecks[1] = true
		Blackout(true, "luaJM11Checkpoint1", 1)
	end

	if not Mission.SavedChecks[2] and FindEntity("Headquarter 01").Party == PARTY_JAPANESE then
		Mission.SavedChecks[2] = true
		Blackout(true, "luaJM11Checkpoint2", 1)
	end

	if not Mission.SavedChecks[3] and FindEntity("Headquarter 02").Party == PARTY_JAPANESE then
		Mission.SavedChecks[3] = true
		Blackout(true, "luaJM11Checkpoint3", 1)
	end

	if not Mission.SavedChecks[4] and FindEntity("Command Station 02").Party == PARTY_JAPANESE then
		Mission.SavedChecks[4] = true
		Blackout(true, "luaJM11Checkpoint4", 1)
	end
end

function luaJM11SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)

	Mission.Checkpoint.SavedChecks = Mission.SavedChecks
	Mission.Checkpoint.HiddenOk = Mission.HiddenOk
	Mission.Checkpoint.HiddenMarker = Mission.HiddenMarker

	Mission.Checkpoint.Cats = {}
	for idx,unit in pairs(Mission.Catalinas) do
		if unit.Dead then
			table.insert(Mission.Checkpoint.Cats, unit.Name)
		end
	end
	--ijn sub + pos
	if Mission.PlayerSub and not Mission.PlayerSub.Dead then
		Mission.Checkpoint.IJNSub = {Mission.PlayerSub.Name, GetPosition(Mission.PlayerSub), GetProperty(Mission.PlayerSub, "TorpedoStock")}
	end
end

function luaJM11LoadMissionData()

	Mission.SavedChecks = Mission.Checkpoint.SavedChecks
-- RELEASE_LOGOFF  	luaLog("------")
-- RELEASE_LOGOFF  	luaLog(Mission.SavedChecks)

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.HiddenOk = Mission.Checkpoint.HiddenOk
	Mission.HiddenMarker = Mission.Checkpoint.HiddenMarker
	
	for idx,unitName in pairs(Mission.Checkpoint.Cats) do
		local unit = FindEntity(unitName)
		if unit and not unit.Dead then
			Kill(unit, true)
		end
	end

	luaDelay(luaJM11RestoreJapUnits,1)
	luaDelay(luaJM11RestoreUSUnits,1)
	luaDelay(luaJM11AddInput, 3)

end

function luaJM11RestoreJapUnits()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	local navPoint
	local lookAt
	if num == 1 then
		navPoint = Mission.CheckNavpoints[1]
		lookAt = GetPosition(FindEntity("Headquarter 01"))
	elseif num == 2 then
		navPoint = Mission.CheckNavpoints[2]
		lookAt = GetPosition(FindEntity("Headquarter 02"))
	elseif num == 3 then
		navPoint = Mission.CheckNavpoints[3]
		lookAt = GetPosition(FindEntity("Command Station 02"))
	elseif num == 4 then
		navPoint = Mission.CheckNavpoints[4]
		lookAt = GetPosition(FindEntity("Command Station 01"))
	end

	luaDelay(luaJM11PutUnits2, 1, "navPoint", navPoint, "lookAt", lookAt)
end

function luaJM11RemoveDeads()
	local japUnits = luaGetCheckpointData("Units", "JapUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units")
	--Mission.ChckFormation = {}
	--Mission.NumFormation = 0
	for idx,unit in pairs(luaSumTablesIndex(Mission.PlayerFleet,{Mission.PlayerSub})) do
		local found = false
		for idx2,unitTbl in pairs(japUnits[1]) do
			if unit.Name == unitTbl[1] then

				--luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end

				--formation
				--if unitTbl[5] and not luaIJN12IsLeaderRegistered(unitTbl[5]) then
				--	Mission.ChckFormation[unitTbl[5]] = {}
				--	table.insert(Mission.ChckFormation[unitTbl[5]], unit)
				--	Mission.NumFormation = Mission.NumFormation + 1
				--elseif unitTbl[5] and luaIJN12IsLeaderRegistered(unitTbl[5]) then
				--	table.insert(Mission.ChckFormation[unitTbl[5]], unit)
				--end

				--if IsInFormation(unit) then
				--	LeaveFormation(unit)
				--end

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

	if Mission.Checkpoint.IJNSub then
		if Mission.PlayerSub and not Mission.PlayerSub.Dead then
			PutTo(Mission.PlayerSub, Mission.Checkpoint.IJNSub[2])
			ShipSetTorpedoStock(Mission.PlayerSub, Mission.Checkpoint.IJNSub[3])
		end
	end

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units done")
end

--[[
function luaIJN12IsLeaderRegistered(lname)
	for idx,tbl in pairs(Mission.ChckFormation) do
		if idx == lname then
			return true
		end
	end
	return false
end
]]
function luaJM11RestoreUSUnits()
	local usUnits = luaGetCheckpointData("Units", "USUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking us units")
	local leader
	for idx,unit in pairs(luaSumTablesIndex({Mission.USBB},Mission.USNSubs,Mission.USNCarrierFleet,Mission.FirstIslandFleet,Mission.USCargos,Mission.Shipyard1Ships,Mission.Shipyard2Ships)) do
		local found = false
		for idx2,unitTbl in pairs(usUnits[1]) do
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
	
	ForceRecon()
	for i,cb in pairs(Mission.CommandBuildings) do
		SetForcedReconLevel(cb, 2, PARTY_JAPANESE)
		if cb.Party == PARTY_ALLIED then
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				luaObj_AddUnit("primary",1,cb)
-- RELEASE_LOGOFF  				luaLog(cb.Name.." kapott markert")
			end
		end
	end

	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		if Mission.USBB and not Mission.USBB.Dead then
			luaObj_AddUnit("secondary",1,Mission.USBB)
		end
	end
	
	if Mission.HiddenMarker then
		if not luaObj_IsActive("marker2",1) then
			luaObj_Add("marker2",1,GetPosition(Mission.MineDetectionPoint))
			Mission.HiddenMarker = true
		else
			luaObj_AddUnit("marker2",1,GetPosition(Mission.MineDetectionPoint))
			Mission.HiddenMarker = true
		end
	end

end

--[[
function luaJM11PutUnits(timerThis)

	local navPoint = timerThis.ParamTable.navPoint
	local angle = luaGetAngle("world", navPoint, timerThis.ParamTable.lookAt)
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."luaJM11PutUnits:")


	local x = 100
	local z = -100
	local multi = {[1] = 1, [2] = -1,}

	local i = 1

	for idx,fTbl in pairs(Mission.ChckFormation) do
		local leader = FindEntity(idx)

-- RELEASE_LOGOFF  		luaLog("Leader "..leader.Name)

		if leader.Class.Type ~= "MotherShip" then
			if num[1] == 1 then
				navPoint.x = navPoint.x + (i * 800)
			else
				navPoint.z = navPoint.z + (i * 800)
			end
			i = i + 1
		else
			if num[1] == 1 then
				navPoint.x = navPoint.x + (Mission.NumFormation * 800)
			else
				navPoint.z = navPoint.z + (Mission.NumFormation * 800)
			end
		end

-- RELEASE_LOGOFF  		luaLog("NavPoint")
-- RELEASE_LOGOFF  		luaLog(navPoint)

		PutTo(leader, navPoint, -angle)

		local k = 1

		for idx2,unit in pairs(fTbl) do
			if unit.ID ~= leader.ID then
-- RELEASE_LOGOFF  				luaLog("Unit in formation "..unit.Name)

				local relTbl =	{
					["x"] = x * k * multi[math.fmod(k,2)+1],
					["y"] = 0,
					["z"] = z * k,
				}

				PutRelTo(unit, leader, relTbl)
				JoinFormation(unit, leader)

				k = k + 1
			end
		end
	end
end
]]

function luaJM11PutUnits2(timerThis)
	local navPoint = timerThis.ParamTable.navPoint
	local angle = luaGetAngle("world", navPoint, timerThis.ParamTable.lookAt)
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	--preset form
	--local BB = FindEntity("Fuso-class Battleship 01")
	local CV = FindEntity("Fuso-class Battleship 01")--FindEntity("Akagi-class 01")

	if num == 1 then
--		PutTo(BB, navPoint, -angle)
		navPoint.z = navPoint.z - 1200
		if CV and not CV.Dead then
			PutTo(CV, navPoint, -angle)
		end
	elseif num == 2 or num == 3 then
	--	PutTo(BB, navPoint, -angle)
		navPoint.x = navPoint.x - 1200
		if CV and not CV.Dead then
			PutTo(CV, navPoint, -angle)
		end
	elseif num == 4 then
--		PutTo(BB, navPoint, -angle)
		navPoint.x = navPoint.x + 1200
		if CV and not CV.Dead then
			PutTo(CV, navPoint, -angle)
		end
	end

	luaDelay(luaJM11RemoveDeads,1)
end


function luaJM11AddInput()
	Blackout(false, "", 0.5)
	--SoundFade(1, "",0.1)
	EnableInput(true)
	Mission.ThinkStop = false
end

function luaJM11FPSChecker()
	local f = luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].enemy.fighter)
	local db = luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].enemy.divebomber)
	local planes = luaSumTablesIndex(f,db)

	if table.getn(planes) > 1 then
		Mission.FPSCritical = true
	else
		Mission.FPSCritical = false
	end

end

function luaJM11SpawnPara()
	local unit = luaFindHidden("Douglas L2D Transport 01")
	if unit and not unit.Dead then
		Mission.Paratrooper = GenerateObject(unit.Name, unit.Name)
	
		if Mission.Paratrooper and not Mission.Paratrooper.Dead then
			if Mission.CommandBuildings[4] and not Mission.CommandBuildings[4].Dead then
				PilotMoveToRange(Mission.Paratrooper, Mission.CommandBuildings[4])
			end
			
			SetRoleAvailable(Mission.Paratrooper, EROLF_ALL, PLAYER_1)
		end
	end
	--SetSelectedUnit(Mission.Paratrooper)
end

-- Douglas L2D Transport 01