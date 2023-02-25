DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--SceneFile="missions\USN\usn_13_Battle_of_Iwo_Jima.scn"
function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("usn13dlg", 1)

	Dialogues = {
		["intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01c",
				},
				{
					["message"] = "idlg01d",
				},
				{
					["message"] = "idlg01e",
				},
				{
					["message"] = "idlg01f",
				},
				{
					["message"] = "idlg01g",
				},
				{
					["message"] = "idlg01h",
				},
			},
		},
	}
	
	luaDelay(luaUS13Idlg1, 4)
	MissionNarrative("usn13.date_location")
end
function luaUS13Idlg1()
	StartDialog("intro", Dialogues["intro"])
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(32) -- Betty Ohka
	PrepareClass(43) -- Kamikaze PT
	PrepareClass(156) -- Ohka
	PrepareClass(26) -- Hellcat
	--45 kamikaze zero
	PrepareClass(167) -- kulturalt powerup megoldas: Betty
	Loading_Finish()
end
function luaStageInit()
	Scoring_RealPlayTimeRunning(true)
	CreateScript("luaInitUS13")
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaInitUS13(this)
	Blackout(true, "", 0)
	EnableMessages(true)
	Mission = this
	this.Name = "US13"
	this.ScriptFile = "scripts/missions/USN/usn_13_battle_of_iwo_jima.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
		
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	SetDeviceReloadEnabled(true)
	--SetDeviceReloadTimeMul(1.5)
	-- mission dolgok
	
	this.Party = SetParty(this, PARTY_ALLIED)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS13GotoPhase3, luaUS13Checkpoint1Load},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {},
	}

	this.MissionPhase = 0 -- enginemovie hekk
	
	-- Japan repcsik
	Mission.AttackerPlanes = {}
	Mission.JapPlaneTypes = {}
	Mission.JapPlaneTypes[1] = {
				["Type"] = 152,
				["Name"] = "globals.unitclass_gekko",
				["Equipment"] = 0,
			}
	Mission.JapPlaneTypes[2] = {
				["Type"] = 151,
				["Name"] = "globals.unitclass_raiden",
				["Equipment"] = 0,
			}
	Mission.JapPlaneTypes[3] = {
				["Type"] = 154,
				["Name"] = "globals.unitclass_oscar",
				["Equipment"] = 0,
			}
	
	-- Japan hajok
	
	Mission.PT1 = {}
	Mission.Shinyos = {}
	
	-- Japan epulet
	
	Mission.Fortress = FindEntity("Fortress 01")
	Mission.FortressToBomb = FindEntity("FortressToBomb")
	Mission.Airfield1 = FindEntity("AirField 01")
	Mission.Airfield2 = FindEntity("AirField 02")
	Mission.Airfields = {Mission.Airfield1, Mission.Airfield2}
	Mission.PTHangar1 = FindEntity("PTHangar_Shipyard 01")
	Mission.PTHangar2 = FindEntity("PTHangar_Shipyard 02")
	Mission.PTHangar3 = FindEntity("PTHangar_Shipyard 03")
	Mission.PTHangar = {Mission.PTHangar1, Mission.PTHangar2, Mission.PTHangar3}
	Mission.Shipyard1 = FindEntity("Shipyard 01")
	Mission.Shipyard2 = FindEntity("Shipyard 02")
	Mission.Shipyard3 = FindEntity("Shipyard 03")
	Mission.Shipyards = {Mission.Shipyard1, Mission.Shipyard2, Mission.Shipyard3}
	Mission.CommandStation01 = FindEntity("Command Station 01")
	Mission.CommandStation02 = FindEntity("Command Station 02")
	Mission.CommandStation03 = FindEntity("Command Station 03")
	Mission.CommandStations = {Mission.CommandStation01, Mission.CommandStation02, Mission.CommandStation03}
		
	-- Allied hajok
	
	Mission.PlayerShips = {}
	Mission.OhkaPrimaryTargets = {}
	
	-- Allied repcsik
	
	Mission.Hellcats = {"F6F Hellcat 01", "F6F Hellcat 02", "F6F Hellcat 03", "F6F Hellcat 04", "F6F Hellcat 05",}
	
	-- Navpontok, koordinatak
	
	Mission.PTSpawnPoint = {FindEntity("PTSpawnPoint 1"), FindEntity("PTSpawnPoint 2"), FindEntity("PTSpawnPoint 3")}
	Mission.Lookat = {GetPosition(FindEntity("Lookat 01")), GetPosition(FindEntity("Lookat 01")), GetPosition(FindEntity("Lookat 02"))}
	Mission.BomberPath = FindEntity("BomberPath")
	Mission.Hangar1Pos = GetPosition(FindEntity("Hangar_AirField 01"))
	Mission.Hangar2Pos = GetPosition(FindEntity("Hangar_AirField 02"))
	Mission.Hangar1 = FindEntity("Hangar_AirField 01")
	Mission.Hangar2 = FindEntity("Hangar_AirField 02")
	Mission.AirfieldHangars = {Mission.Hangar1, Mission.Hangar2}
	Mission.TransportPath1 = FindEntity("TransportPath1")
	Mission.TransportPath2 = FindEntity("TransportPath2")
	Mission.TransportPath3 = FindEntity("TransportPath3")
	Mission.TransportPath4 = FindEntity("TransportPath4")
	Mission.TransportPaths = {Mission.TransportPath1, Mission.TransportPath2, Mission.TransportPath3, Mission.TransportPath4}
	-- Support Manager tiltas
	BannSupportmanager()

	-- Achievements init
	

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	-- dialogusok

	LoadMessageMap("usn13dlg", 1)
	
	this.Dialogues = {
		["dlg_1st_phase"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a"
				},
				{
					["message"] = "dlg01b"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS13HintAA",
				}
			},
		},
		["dlg_bombed_fortress"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a"
				},
			},
		},
		["dlg_fighters_join"] = {
			["sequence"] = {
				{
					["message"] = "dlg02b"
				},
				{
					["message"] = "dlg02c"
				},
				{
					["message"] = "dlg02d"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS13HintPlanes",
				},
			},
		},
		["dlg_b29_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg03"
				},
			},
		},
		["dlg_bombers_retreat"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a"
				},
				{
					["message"] = "dlg04b"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS13BombersRetreatCallback"
				}
			},
		},
		["dlg_target"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a"
				},
				{
					["message"] = "dlg05b"
				},
				{
					["message"] = "dlg05c"
				},
				{
					["message"] = "dlg05d"
				},
				{
					["message"] = "dlg05e"
				},
			},
		},
		["dlg_phase_3"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a"
				},
				{
					["message"] = "dlg06b"
				},
			},
		},
		["dlg_protecttransports"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a"
				},
				{
					["message"] = "dlg07b"
				},
			},
		},
		["dlg_submarine"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a"
				},
				{
					["message"] = "dlg08b"
				},
				{
					["message"] = "dlg08c"
				},
				{
					["message"] = "dlg08d"
				},
			},
		},
		["dlg_ohkas_incoming"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a"
				},
				{
					["message"] = "dlg09b"
				},
			},
		},
		
		["dlg_ohkas_released"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a"
				},
				{
					["message"] = "dlg10b"
				},
				{
					["message"] = "dlg10c"
				},
				{
					["message"] = "dlg10d"
				},
			},
		},
		["dlg_ohka_explosion"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a"
				},
				{
					["message"] = "dlg11b"
				},
				{
					["message"] = "dlg11c"
				},
			},
		},
		["dlg_ohka_recognize"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a"
				},
				{
					["message"] = "dlg12b"
				},
			},
		},
		["dlg_pt_hangars"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a"
				},
				{
					["message"] = "dlg13b"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS13AddHangarObj"
				}
			},
		},
		["dlg_pt_hangars2"] = {
			["sequence"] = {
				{
					["message"] = "dlg13b"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS13AddHangarObj"
				}
			},
		},
		["dlg_pt_hangars_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a"
				},
				{
					["message"] = "dlg14b"
				},
			},
		},
		["dlg_airfield_destoryed"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a"
				},
				{
					["message"] = "dlg15b"
				},
			},
		},
	}
	-- objektivak
	
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "ObjEscort",		-- azonosito
				["Text"] = "usn13.obj_p1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "Transports",		-- azonosito
				["Text"] = "usn13.obj_p2",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["secondary"] = {
			[1] =
			{
				["ID"] = "PTHangar",		-- azonosito
				["Text"] = "usn13.obj_s1",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "Destroyairfield",		-- azonosito
				["Text"] = "usn13.obj_s2",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["hidden"] = {
			[1] =
			{
				["ID"] = "Savealltransport",		-- azonosito
				["Text"] = "usn13.obj_h1",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	Mission.LandingTime = 510
	Mission.FastPhase1 = 240
	Mission.PTInterval = 100
	Mission.MaxPTSpawn = 4
	
	Mission.NearPlaneTargets1 = {}
	Mission.NearPlaneTargets2 = {}
	Mission.ActualGroupMembers = {}
	
	Mission.OhkaHit = 0
	Mission.BunkerDialogTime = 0
	
	luaInitNewSystems()
	
	--SetDeviceReloadTimeMul(0)
    SetThink(this, "US13Think")
	
	Mission.AttackerPlanes = {FindEntity("Gekko 01"), FindEntity("Ki-43 Oscar 01"), FindEntity("J2M Raiden 01")}
	Mission.B29 = {FindEntity("B-29 Superfortress"),
					FindEntity("B-29 Superfortress 01"),
					FindEntity("B-29 Superfortress 02"),
					FindEntity("B-29 Superfortress 03"),
					FindEntity("B-29 Superfortress 04"),
					FindEntity("B-29 Superfortress 05"),
					FindEntity("B-29 Superfortress 06"),
					FindEntity("B-29 Superfortress 07"),}
	Mission.AllB29 = table.getn(Mission.B29) * 3 - 5
	Mission.USPlanes = {}
	for idx, unit in pairs(Mission.B29) do
		SetRoleAvailable(unit, EROLF_PILOT, PLAYER_AI)
		SquadronForceGunnerMode(unit, true)
		--PilotSetTarget(unit, Mission.FortressToBomb)
		PilotMoveOnPath(unit, Mission.BomberPath)
		SquadronSetAttackAlt(unit, GetPosition(unit).y)
		SquadronSetTravelAlt(unit, GetPosition(unit).y)
		SquadronEnableTerrainAvoidance(unit, false)
		SquadronEnableVehicleAvoidance(unit, false) -- HACK!!!
		table.insert(Mission.USPlanes, unit)
	end
	SetSelectedUnit(FindEntity("B-29 Superfortress 05"))
	
	--SoundFade(0,"", 1)
	
	luaUS13InitShips()
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == false then
		--ForceEnableInput(IC_MAP_TOGGLE, false) -- map tiltas
		ForceEnableInput(IC_CMD_SETTARGET, false)
		ForceEnableInput(IC_CMD_CLEARTARGET, false) 
	end
	
	luaObj_Add("hidden", 1)
-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
end

function US13Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(Mission.Name.." mission is thinkin' in phase "..Mission.MissionPhase)

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." mission is terminated!")
		return
	end
	luaCheckMusic()
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	Mission.PlayerShips = luaRemoveDeadsFromTable(Mission.PlayerShips)
	
	if Mission.MissionPhase == 0 then
		 -- anzsanmovie hekk
		--SoundFade(1, "",0.1)
	
	luaDelay(luaUS13AddFirstObjs, 6)
	
	luaDelay(luaUS13SpawnSecondAttackerWave, 50)
	
	--luaUS13GotoPhase3() -- CHEAT
	--Mission.lastclock = os.clock()
	Blackout(false, "", 3)
	Mission.MissionPhase = 1
	
-- MissionPhase 1 -- B29
	elseif Mission.MissionPhase == 1 then
		Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
		Mission.USPlanes = luaRemoveDeadsFromTable(Mission.USPlanes)
		Mission.planesleft = 0
		for idx, unit in pairs(Mission.B29) do
			PilotMoveOnPath(unit, Mission.BomberPath)
			Mission.planesleft = Mission.planesleft + luaGetSquadronPlaneNum(unit)
		end
		Mission.planesleft = math.floor((Mission.planesleft-5)/Mission.AllB29 * 100 )
		
		if Mission.planesleft < 50 then
			luaUS13StartDialog("dlg_b29_lost")
		end
		
		if Mission.planesleft < 1 then
			luaUS13BombersRetreat()
			HideScoreDisplay(1,0)
			Mission.EndMission = true
			return
		else
			if Mission.PrintObjP1 == true then
				DisplayScores(1,0,"usn13.obj_p1", "usn13.score01")
			end
			luaUS13AttackBombers()
			--luaAirfieldManager(Mission.Airfield1, {150,152,154}, {150}, Mission.B29, 1200)
			if (luaGetDistance(Mission.B29[1], luaGetPathPoint(Mission.BomberPath,2)) < 2000) or (table.getn(Mission.AttackerPlanes) == 0) then
				luaUS13GotoPhase2()
			end
			-- random manouver
			if random(1,5) == 5 then
				Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
				local trg = luaPickRnd(Mission.AttackerPlanes)
				if trg ~= nil then
					PilotRetreat(trg)
				end
			end
			-- random B29 AA disabling because of FPS issues
			local shoot = Mission.AllB29/2
			for idx,unit in pairs(Mission.B29) do
				if shoot == 0 then
					AAEnable(unit, false)
				else
					if random(0,1) == 0 then
						AAEnable(unit, true)
						shoot = shoot - 1
					else
						AAEnable(unit, false)
					end
				end
			end
			
		end
		
	-- MissionPhase 2
	elseif Mission.MissionPhase == 2 then
		Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
		Mission.USPlanes = luaRemoveDeadsFromTable(Mission.USPlanes)
		Mission.planesleft = 0
		for idx, unit in pairs(Mission.B29) do
			Mission.planesleft = Mission.planesleft + luaGetSquadronPlaneNum(unit)
		end
		Mission.planesleft = math.floor((Mission.planesleft-5)/Mission.AllB29 * 100 )
		
		Mission.Hellcats = luaRemoveDeadsFromTable(Mission.Hellcats)
		local attackerplanes = 0
		Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
		for idx, unit in pairs(Mission.AttackerPlanes) do
			attackerplanes = attackerplanes + luaGetSquadronPlaneNum(unit)
		end
		if attackerplanes < 4 then
			if luaGetDistance(Mission.B29[1], luaGetPathPoint(Mission.BomberPath,3)) > 2000 then
				luaUS13SpawnAttackers(1, luaPickRnd(Mission.B29))
			end
		end
		if luaGetDistance(Mission.B29[1], Mission.FortressToBomb) < 3500 then
			luaUS13StartDialog("dlg_target")
		end
		luaUS13AttackBombers()
		if Mission.planesleft < 1 then	-- kevesen vannak
			luaUS13BombersRetreat()
			HideScoreDisplay(1,0)
			Mission.EndMission = true
			return
		elseif table.getn(Mission.Hellcats) == 0 then -- lelõtték az összes fightert
			luaUS13BombersRetreat()
			luaClearDialogs()
			luaMissionFailedNew(Mission.B29[1], "usn13.obj_p1_fail2", nil, true)
			Mission.EndMission = true
			return
		else
			DisplayScores(1,0,"usn13.obj_p1", "usn13.score01")
			for idx, unit in pairs (Mission.B29) do
				if luaGetDistance(unit, luaGetPathPoint(Mission.BomberPath,3)) < 600 then
					HideScoreDisplay(1, 0)
					luaUS13BombingMovie()
					luaObj_Completed("primary", 1, true)
					return
				end
			end
		end

		if Mission.planesleft < 50 then
			luaUS13StartDialog("dlg_b29_lost")
		end
		--luaAirfieldManager(Mission.Airfield1, {150,152,154}, {150}, Mission.B29, 1200)
		--luaAirfieldManager(Mission.Airfield2, {150,152,154}, {150}, Mission.B29, 1200)
	
-- MissionPhase 3 															-- Flying boats
	elseif Mission.MissionPhase == 3 then
		Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
		Mission.TransportFleetsNumber = table.getn(Mission.TransportFleets)
		if Mission.TransportFleetsNumber == 0 then
			luaClearDialogsCallback()
			luaMissionFailedNew(Mission.LastKilledTransport, "usn13.obj_p2_fail", nil, true)
			Mission.EndMission = true
			HideScoreDisplay(1,0)
			return
		end
		luaUS13CheckGuards()
		if (table.getn(luaGetOwnUnits("plane", PARTY_JAPANESE)) == 0) then
			Mission.MissionPhase = -1
			luaDelay(luaUS13GotoPhase4, 3)
			return
		end
		Mission.Emily = luaRemoveDeadsFromTable(Mission.Emily)
		for idx, unit in pairs(Mission.Emily) do
			if (not luaGetScriptTarget(unit)) or (luaGetScriptTarget(unit).Dead) then
				local trg = luaPickRnd(Mission.TransportFleets)
				if trg then
					PilotSetTarget(unit, trg)
					luaSetScriptTarget(unit, trg)
				end
			end
		end
		Mission.Mavis = luaRemoveDeadsFromTable(Mission.Mavis)
		for idx, unit in pairs(Mission.Mavis) do
			if (not luaGetScriptTarget(unit)) or (luaGetScriptTarget(unit).Dead) then
				local trg = luaPickRnd(Mission.TransportFleets)
				if trg then
					PilotSetTarget(unit, trg)
					luaSetScriptTarget(unit, trg)
				end
			end
		end
		if Mission.FlyingBoats2Up then
		Mission.FlyingBoats2 = luaRemoveDeadsFromTable(Mission.FlyingBoats2)
		for idx, unit in pairs(Mission.FlyingBoats2) do
				if (not luaGetScriptTarget(unit)) or (luaGetScriptTarget(unit).Dead) then
				local trg = luaPickRnd(Mission.TransportFleets)
				if trg then
					PilotSetTarget(unit, trg)
						luaSetScriptTarget(unit, trg)
					end
				end
			end
		end
		
		if table.getn(Mission.Mavis) + table.getn(Mission.Emily) < 3 then
			for idx, unit in pairs(Mission.TransportFleets) do
				SetSkillLevel(unit, SKILL_SPVETERAN)
			end
		end
		
		if luaObj_IsActive("primary", 2) then
			DisplayScores(1,0,"usn13.obj_p2","usn13.transportleft")
		end
-- MissionPhase 4 																-- Submarine
	elseif Mission.MissionPhase == 4 then
		Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
		Mission.TransportFleetsNumber = table.getn(Mission.TransportFleets)
		if Mission.TransportFleetsNumber == 0 then
			luaClearDialogsCallback()
			luaMissionFailedNew(Mission.TypeB, "usn13.obj_p2_fail", nil, true)
			Mission.EndMission = true
			HideScoreDisplay(1,0)
			return
		end
		Mission.Reconplanes = luaRemoveDeadsFromTable(Mission.Reconplanes)
		if table.getn(Mission.Reconplanes) == 0 then
			luaMissionFailedNew(Mission.TypeB, "usn13.obj_sub_failed", nil, true)
			Mission.EndMission = true
			return
		end
		if Mission.TypeB.Dead == false then
			if GetProperty(Mission.TypeB, "unitcommand") ~= "attackmove" then
				local trg = luaGetNearestUnitFromTable(Mission.TypeB, Mission.TransportFleets)
				if trg then
					NavigatorAttackMove(Mission.TypeB, trg, {})
				end
			end
		end
		DisplayScores(1,0,"usn13.obj_p2","usn13.transportleft")
		DisplayUnitHP({Mission.TypeB}, "usn13.obj_sub")
-- Phase5																		-- 	Kamikádze
	elseif Mission.MissionPhase == 5 then
		local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
		Mission.Bettys = {}
		for idx, unit in pairs(japplanes) do
			if unit.Class.Type == "LevelBomber" then
				table.insert(Mission.Bettys, unit)
			end
		end
		Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
		Mission.TransportFleetsNumber = table.getn(Mission.TransportFleets)
		if Mission.TransportFleetsNumber == 0 then
			luaClearDialogsCallback()
			
			luaMissionFailedNew(luaPickRnd(Mission.Bettys),"usn13.obj_p2_fail", nil, true)
			Mission.EndMission = true
			HideScoreDisplay(1,0)
			return
		end
		
		if table.getn(Mission.Bettys) == 0 then
			Mission.MissionPhase = -1
			luaDelay(luaUS13GotoPhase6, 4)
			return
		else
			for idx, unit in pairs(Mission.Bettys) do
				if GetProperty(unit, "unitcommand") ~= "dropkamikaze" then
					local trg
					Mission.OhkaPrimaryTargets = luaRemoveDeadsFromTable(Mission.OhkaPrimaryTargets)
					if table.getn(Mission.OhkaPrimaryTargets) > 0 then
						trg = luaPickRnd(Mission.OhkaPrimaryTargets)
					else
						trg = luaPickRnd(Mission.TransportFleets)
					end
					if trg then
						PilotSetTarget(unit, trg)
						luaSetScriptTarget(unit, trg)
					end
				end
			end	
		end
		if Mission.Dialogues["dlg_ohkas_released"].printed ~= true then
			for idx, unit in pairs(recon[PARTY_JAPANESE]["own"]["kamikaze"]) do
				if unit.ClassID == 156 then -- ohka
					luaUS13StartDialog("dlg_ohkas_released")
				end
			end
		end
		luaUS13CheckGuards()
		DisplayScores(1,0,"usn13.obj_p2","usn13.transportleft")-- Phase6																		-- 	Shinyos
	elseif Mission.MissionPhase == 6 then 
		Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
		Mission.TransportFleetsNumber = table.getn(Mission.TransportFleets)
		if Mission.TransportFleetsNumber == 0 then
			luaClearDialogsCallback()
			
			luaMissionFailedNew(Mission.TypeB, "usn13.obj_p2_fail", nil, true)
			Mission.EndMission = true
			HideScoreDisplay(1,0)
			return
		end
		
		if not luaObj_GetSuccess("secondary",1) then	-- pthangar
			--Mission.PTHangar = luaRemoveDeadsFromTable(Mission.PTHangar)
			local comp = true
			for idx,unit in pairs(Mission.PTHangar) do
				if unit.Dead == false then
					comp = false
					break
				end
			end
			if comp then
				if not luaObj_IsActive("secondary",1) then
					luaObj_Add("secondary", 1, Mission.PTHangar)
				end
				luaObj_Completed("secondary", 1, true)
				MissionNarrative("missionglobals.sec_completed")
				luaUS13StartDialog("dlg_pt_hangars_destroyed")
			end
		end
		
		Mission.Shinyos = luaRemoveDeadsFromTable(Mission.Shinyos)
		if table.getn(Mission.Shinyos) == 0 then
			Mission.MissionPhase = -1
			luaDelay(luaUS13LandingMovie, 4)
			return
		else
			for idx, unit in pairs(Mission.Shinyos) do
				if GetProperty(unit, "unitcommand") ~= "attackmove" then
					local trg = luaGetNearestUnitFromTable(unit, Mission.TransportFleets)
					if trg then
						NavigatorAttackMove(unit, trg)
					end
				end
			end
		end
		luaUS13CheckGuards()
		DisplayScores(1,0,"usn13.obj_p2","usn13.transportleft")

		
	end
-- RELEASE_LOGOFF  	luaLog("Think end.")
end

-- Mission functions
	
function luaUS13GotoPhase2()
	Blackout(true, "luaUS13GiveHellcats", 3)
	Mission.MissionPhase = -1
end

function luaUS13BombingMovie()
	Mission.MissionPhase = -1
	Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
	for idx,unit in pairs(Mission.B29) do
		SetInvincible(unit, 0.2)
	end
	BlackBars(true)
	Mission.CamScript = luaCamIngameMovieAuto(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.B29[1], ["distance"] = 30, ["theta"] = -10, ["rho"] = 35, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.B29[1], ["distance"] = 27, ["theta"] = -6, ["rho"] = 62, ["moveTime"] = 3, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = Mission.B29[1], ["distance"] = 25, ["theta"] = -8, ["rho"] = 80, ["moveTime"] = 5, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = Mission.FortressToBomb, ["distance"] = 440, ["theta"] = 15, ["rho"] = 210, ["moveTime"] = 0, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = Mission.FortressToBomb, ["distance"] = 420, ["theta"] = 12, ["rho"] = 200, ["moveTime"] = 5, ["smoothtime"] = 3},
		{["postype"] = "cameraandtarget", ["target"] = Mission.FortressToBomb, ["distance"] = 400, ["theta"] = 10, ["rho"] = 180, ["moveTime"] = 7},
	},
	luaUS13BombingMovieEnd,
	true)
	Mission.MovieDelay = luaDelay(luaUS13ForceRelease, 3)
	AddListener("input", "movielistenerID", {
		["callback"] = "luaUS13BombingMovieEnd",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
	
	Blackout(false, "", 3)
end
function luaUS13ForceRelease()
	Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
	for idx, unit in pairs(Mission.B29) do
		Scoring_IgnoreEntityKill(unit)
		SquadronForceRelease(unit)
	end
	Mission.MovieDelay = luaDelay(luaUS13FakeBombing, 8)
end
function luaUS13FakeBombing()
	luaFakeBombing(Mission.FortressToBomb ,"carpet" ,2 ,200 ,false)
	Mission.MovieDelay = luaDelay(luaUS13FakeBombEffect, 2.5)
end
function luaUS13FakeBombEffect()
	Effect("ExplosionLargeBuilding", GetPosition(Mission.FortressToBomb))
	luaUS13StartDialog("dlg_bombed_fortress")
	Mission.MovieDelay = luaDelay(luaUS13KillFortress, 0.5)
end
function luaUS13KillFortress()
	if Mission.FortressToBomb.Dead == false then
		AddDamage(Mission.FortressToBomb,200000)
	end
	luaObj_Completed("primary", 1, true)
end
function luaUS13BombingMovieEnd()
	RemoveListener("input", "movielistenerID")
	if Mission.FortressToBomb.Dead == false then
		AddDamage(Mission.FortressToBomb,200000)
	end
	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end
	if Mission.MovieDelay.Dead == false then
		DeleteScript(Mission.MovieDelay)
	end
	Blackout(true, "luaUS13SaveCheckpoint", 2)
	
end
function luaUS13SaveCheckpoint()
	for idx, unit in pairs (Mission.Hellcats) do
		if unit.Dead == false then
			Kill(unit,true)
		end
	end
	--luaCheckpoint(1)
	luaUS13GotoPhase3()
end
function luaUS13GotoPhase3()
	HideScoreDisplay(1, 0)
	Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
	for idx, unit in pairs(Mission.B29) do
		Kill(unit, true)
	end
	Mission.B29 = {}
	
	Mission.Mavis = {"H6K Mavis 01", "H6K Mavis 02", "H6K Mavis 03", "H6K Mavis 04", "H6K Mavis 05"}
	luaUS13GenerateObjects(Mission.Mavis)
	Mission.Emily = {"H8K Emily 01","H8K Emily 02","H8K Emily 03","H8K Emily 04","H8K Emily 05"}
	luaUS13GenerateObjects(Mission.Emily)
	Mission.Guardians = {"F6F Hellcat 06", "F4U Corsair 01"}
	luaUS13GenerateObjects(Mission.Guardians)
	for idx, unit in pairs(Mission.Guardians) do
		SquadronSetTravelAlt(unit, 80)
		SquadronSetAttackAlt(unit, 80)
	end
	local trg = {Mission.Mavis[1], Mission.Emily[1]}
	SetInvincible(Mission.Mavis[1], 1)
	SetInvincible(Mission.Emily[1], 1)
	for idx, unit in pairs(Mission.Guardians) do
		PilotMoveTo(unit, luaGetPathPoint(Mission.TransportPaths[idx*2],3))
	end
	
	--[[
	Mission.MavisNumber = 0
	Mission.EmilyNumber = 0
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 1, ["quantity"] = 2}})
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 2, ["quantity"] = 2}})
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 3, ["quantity"] = 2}})
	]]
	
	Mission.MissionPhase = -1
	for idx,unit in pairs(Mission.AttackerPlanes) do
		if unit.Dead ~= true then
			Kill(unit,true)
		end
	end
	Mission.AttackerPlanes = nil
	for idx, unit in pairs(Mission.Airfields) do
		OverrideHP(unit, 350 + Mission.Difficulty * 150)
		SetInvincible(unit, 0.2)
	end
	OverrideHP(FindEntity("Hangar_AirField 01"), 350 + Mission.Difficulty * 150)
	OverrideHP(FindEntity("Hangar_AirField 02"), 350 + Mission.Difficulty * 150)
	for idx, unit in pairs(Mission.PTHangar) do
		OverrideHP(unit, 350 + Mission.Difficulty * 150)
		SetInvincible(unit, 0.2)
	end
	for idx, unit in pairs(Mission.Shipyards) do
		OverrideHP(unit, 350 + Mission.Difficulty * 150)
		SetInvincible(unit, 0.2)
	end
	
	AddListener("kill", "HangarPowerupListenerID", {
		["callback"] = "luaUS13HangarPowerup",  -- callback fuggveny
		["entity"] = Mission.PTHangar, -- entityk akiken a listener aktiv
		["lastAttacker"] = { },  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
	})
	luaDelay(luaUS13KibaszottFormaciosHekkelesBaszdmeg, 1)
end
function luaUS13KibaszottFormaciosHekkelesBaszdmeg()
	PutFormationTo(Mission.TransportFleet1[1], luaGetPathPoint(Mission.TransportPath1,1),1)
	PutFormationTo(Mission.TransportFleet2[1], luaGetPathPoint(Mission.TransportPath2,1),1)
	PutFormationTo(Mission.TransportFleet3[1], luaGetPathPoint(Mission.TransportPath3,1),1)
	NavigatorMoveToPos(Mission.TransportFleet1[1], luaGetPathPoint(Mission.TransportPath1, 2))
	NavigatorMoveToPos(Mission.TransportFleet2[1], luaGetPathPoint(Mission.TransportPath2, 2))
	NavigatorMoveToPos(Mission.TransportFleet3[1], luaGetPathPoint(Mission.TransportPath3, 2))
	luaUS13FlyingBoatsMovie()
end
function luaUS13FlyingBoatsMovie()
	Blackout(false, "", 3)
	Mission.MavisNumber = 0
	Mission.EmilyNumber = 0
	luaDelay(luaUS13SendOutFlyingBoats, 7)
	luaDelay(luaUS13SecDialog, 6+7)
	local transport = luaPickRnd(Mission.TransportFleets)
	
	BlackBars(true)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = GetFormationLeader(Mission.TransportFleet2[1]), ["distance"] = 340, ["theta"] = 11, ["rho"] = 147, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = GetFormationLeader(Mission.TransportFleet2[1]), ["distance"] = 240, ["theta"] = 8, ["rho"] = 87, ["moveTime"] = 6},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Emily[1], ["distance"] = 340, ["theta"] = 15, ["rho"] = 57, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Emily[1], ["distance"] = 400, ["theta"] = 5, ["rho"] = 51, ["moveTime"] = 12, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Mavis[1], ["distance"] = 560, ["theta"] = 4, ["rho"] = -40, ["moveTime"] = 4, ["smoothtime"] = 1, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Mavis[1], ["distance"] = 680, ["theta"] = -3, ["rho"] = -65, ["moveTime"] = 4, ["smoothtime"] = 1, ["nonlinearblend"] = 0.5},
	},
	luaUS13FlyingBoatsMovieEnd,
	true, nil, false)
end
function luaUS13FlyingBoatsMovieEnd()
	BlackBars(false)
	Blackout(true,"luaUS13GonePhase3",2)
end
function luaUS13GonePhase3()
	Mission.MissionPhase = 3
	SetInvincible(Mission.Mavis[1], 0)
	SetInvincible(Mission.Emily[1], 0)
	Mission.Emily = luaRemoveDeadsFromTable(Mission.Emily)
	for idx, unit in pairs(Mission.Emily) do
		local pos = GetPosition(unit)
		pos.z = pos.z - 3000
		PutTo(unit, pos)
	end
	Mission.Mavis = luaRemoveDeadsFromTable(Mission.Mavis)
	for idx, unit in pairs(Mission.Mavis) do
		local pos = GetPosition(unit)
		pos.z = pos.z - 3000
		PutTo(unit, pos)
	end
	
	Mission.FlyingBoats2 = {"H6K Mavis 01", "H6K Mavis 02", "H6K Mavis 03", "H6K Mavis 04", "H6K Mavis 05", "H8K Emily 01","H8K Emily 02","H8K Emily 03","H8K Emily 04","H8K Emily 05"}
	luaUS13GenerateObjects(Mission.FlyingBoats2)
	luaDelay(luaUS13SendOutFlyingBoats2, 60)

	SetSelectedUnit(Mission.Guardians[1])
	EnableInput(true)
	Blackout(false,"",2)
end
function luaUS13GotoPhase4()
	Mission.MissionPhase = -1
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.TransportFleets) do
		ClearAllShipFailure(unit)
	end
	Blackout(true, "luaUS13GotoPhase4_1", 3)
end
function luaUS13GotoPhase4_1()
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	local planes = luaGetOwnUnits("plane")
	for idx, unit in pairs(planes) do
		Kill(unit, true)
	end
	for idx, unit in pairs(Mission.TransportFleets) do
		SetSkillLevel(unit, SKILL_STUN)
	end
	luaUS13RelocateTransports(2)
	luaUS13InitSub()
end
function luaUS13GotoPhase5()
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.TransportFleets) do
		ClearAllShipFailure(unit)
	end
	for idx, unit in pairs(Mission.Airfields) do
		SetInvincible(unit, 0)
		LaunchSquadron(unit, 32, 3, 1)
	end
	
	Mission.Reconplanes = luaRemoveDeadsFromTable(Mission.Reconplanes)
	if table.getn(Mission.Reconplanes) ~= 0 then
		for idx, unit in pairs(Mission.Reconplanes) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotRetreat(unit)
		end
	end
	
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	AddListener("hit", "OhkaHitID", {
		["callback"] = "luaUS13OhkaRecognize",	-- callback fv
		["target"] = Mission.TransportFleets,	-- kit bántottunk
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {KAMIKAZE},	-- bombával vagy torpillével
		["attackerPlayerIndex"] = {},	-- sk
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Airfield1)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield1, ["distance"] = 370, ["theta"] = 32, ["rho"] = 35, ["moveTime"] = 0},
	{["postype"] = "cameraandtarget", ["target"] = Mission.Airfield1, ["distance"] = 430, ["theta"] = 27, ["rho"] = 25, ["moveTime"] = 7},
		{["postype"] = "cameraandtarget", ["target"] = squadEntTable[1], ["distance"] = 16, ["theta"] = 3, ["rho"] = 27, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = squadEntTable[1], ["distance"] = 40, ["theta"] = 12, ["rho"] = 340, ["moveTime"] = 8},
	{["postype"] = "cameraandtarget", ["target"] = squadEntTable[1], ["distance"] = 80, ["theta"] = 17, ["rho"] = 300, ["moveTime"] = 8},
	},
	luaUS13GotoPhase5_1,
	true)
end
function luaUS13GotoPhase5_1()
	luaDelay(luaUS13RevertReloadMultiplier, 30)
	Blackout(true, "luaUS13GonePhase5", 3)
end
function luaUS13RevertReloadMultiplier()
	--SetDeviceReloadTimeMul(1.5)
end
function luaUS13GonePhase5()
	Mission.MissionPhase = 5
	luaUS13RelocateTransports(3)
	local bettytogenerate = {"G4M Betty - Ohka 01", "G4M Betty - Ohka 02", "G4M Betty - Ohka 03", "G4M Betty - Ohka 04", "G4M Betty - Ohka 05", }
	luaUS13GenerateObjects(bettytogenerate)
	
	Mission.Guardians = {"F6F Hellcat 06", "F4U Corsair 01", "F4U Corsair 02", "F4U Corsair 03"}
	luaUS13GenerateObjects(Mission.Guardians)
	for idx, unit in pairs(Mission.Guardians) do
		SquadronSetTravelAlt(unit, 250)
		SquadronSetAttackAlt(unit, 250)
	end
	Mission.Bettys = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx, unit in pairs(Mission.Guardians) do
		PilotMoveTo(unit, luaPickRnd(Mission.Bettys))
	end
	Blackout(false, "", 3)
	EnableInput(true)
	SetSelectedUnit(Mission.Guardians[1])
	luaObj_Add("secondary", 2, Mission.AirfieldHangars)
	--luaObj_AddUnit("secondary", 2, Mission.Hangar1)
	--luaObj_AddUnit("secondary", 2, Mission.Hangar2)
	AddListener("kill", "AirfieldKillID", { -- 
		["callback"] = "luaUS13AirfieldKilled",  -- callback fuggveny
		["entity"] = Mission.Airfields, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	local usunits = luaGetOwnUnits("ship")
	Mission.OhkaPrimaryTargets = {}
	for idx, unit in pairs(usunits) do
		if unit.Type ~= "CARGO" then
			table.insert(Mission.OhkaPrimaryTargets, unit)
		end
	end
end
function luaUS13GotoPhase6()
	Mission.MissionPhase = -1
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 1, ["quantity"] = 5}})
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 2, ["quantity"] = 5}})
	luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 3, ["quantity"] = 5}})
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.TransportFleets) do
		ClearAllShipFailure(unit)
	end
	Blackout(true, "luaUS13GotoPhase6_1", 3)
end
function luaUS13GotoPhase6_1()
	luaUS13RelocateTransports(4)
	for idx, unit in pairs(Mission.PTHangar) do
		SetInvincible(unit, 0)
	end
	for idx, unit in pairs(Mission.Shipyards) do
		SetInvincible(unit, 0)
	end
	luaUS13InitShinyos()
	luaDelay(luaUS13ShinyoSecondWave, 100)
end
function luaUS13ShinyoSecondWave()
	if Mission.MissionPhase == 6 then
		if Mission.Shipyard1.Dead == false then
			luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 1, ["quantity"] = 5}})
		end
		if Mission.Shipyard2.Dead == false then
			luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 2, ["quantity"] = 5}})
		end
		if Mission.Shipyard3.Dead == false then
			luaUS13SpawnPT1({["ParamTable"] = {["spawnpoint"] = 3, ["quantity"] = 5}})
		end
	end
	luaDelay(luaUS13ShinyoSecondWaveInit, 4)
end
function luaUS13ShinyoSecondWaveInit()
	Mission.Shinyos = luaGetOwnUnits("ship", PARTY_JAPANESE)
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.Shinyos) do
		if not unit.AddedToObjective then
			unit.AddedToObjective = true
			luaObj_AddUnit("primary", 2, unit)
		end
		trg = luaGetNearestUnitFromTable(unit, Mission.TransportFleets)
		if trg then
			NavigatorAttackMove(unit, trg)
		end
	end
end
function luaUS13RelocateTransports(point)
	Mission.TransportFleet1 = luaRemoveDeadsFromTable(Mission.TransportFleet1)
	Mission.TransportFleet2 = luaRemoveDeadsFromTable(Mission.TransportFleet2)
	Mission.TransportFleet3 = luaRemoveDeadsFromTable(Mission.TransportFleet3)
	if table.getn(Mission.TransportFleet1) > 0 then
		if IsInFormation(Mission.TransportFleet1[1]) then
			PutTo(GetFormationLeader(Mission.TransportFleet1[1]), luaGetPathPoint(Mission.TransportPath1,point))
			NavigatorMoveToPos(GetFormationLeader(Mission.TransportFleet1[1]), luaGetPathPoint(Mission.TransportPath1,point+1))
		else
			PutTo(Mission.TransportFleet1[1], luaGetPathPoint(Mission.TransportPath1,point))
			NavigatorMoveToPos(Mission.TransportFleet1[1], luaGetPathPoint(Mission.TransportPath1,point+1))
		end
	end
	if table.getn(Mission.TransportFleet2) > 0 then
		if IsInFormation(Mission.TransportFleet2[1]) then
			PutTo(GetFormationLeader(Mission.TransportFleet2[1]), luaGetPathPoint(Mission.TransportPath2,point))
			NavigatorMoveToPos(GetFormationLeader(Mission.TransportFleet2[1]), luaGetPathPoint(Mission.TransportPath2,point+1))
		else
			PutTo(Mission.TransportFleet2[1], luaGetPathPoint(Mission.TransportPath2,point))
			NavigatorMoveToPos(Mission.TransportFleet2[1], luaGetPathPoint(Mission.TransportPath2,point+1))
		end
	end
	if table.getn(Mission.TransportFleet3) > 0 then
		if IsInFormation(Mission.TransportFleet3[1]) then
			PutTo(GetFormationLeader(Mission.TransportFleet3[1]), luaGetPathPoint(Mission.TransportPath3,point))
			NavigatorMoveToPos(GetFormationLeader(Mission.TransportFleet3[1]), luaGetPathPoint(Mission.TransportPath3,point+1))
		else
			PutTo(Mission.TransportFleet3[1], luaGetPathPoint(Mission.TransportPath3,point))
			NavigatorMoveToPos(Mission.TransportFleet3[1], luaGetPathPoint(Mission.TransportPath3,point+1))
		end
	end
end
function luaUS13AirfieldKilled(...)
	--[[
	if arg[1] == Mission.Airfield1 then 
		luaObj_RemoveUnit("secondary", 2, Mission.Hangar1)
	elseif arg[1] == Mission.Airfield2 then
		luaObj_RemoveUnit("secondary", 2, Mission.Hangar2)
	end
	]]
	Mission.Airfields = luaRemoveDeadsFromTable(Mission.Airfields)
	if table.getn(Mission.Airfields) == 0 then
		RemoveListener("kill", "AirfieldKillID")
		luaObj_Completed("secondary", 2, true)
		MissionNarrative("missionglobals.sec_completed")
		luaUS13StartDialog("dlg_airfield_destoryed")
	end
end
function luaUS13InitShinyos()
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.Guardians) do
		if unit.Dead == false then
			local trg = luaPickRnd(Mission.TransportFleets)
			if trg then
				PilotMoveTo(unit, trg)
			end
			--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end
	end
	Mission.Shinyos = luaGetOwnUnits("ship", PARTY_JAPANESE)
	if table.getn(Mission.Shinyos) == 0 then
		luaDelay(luaUS13InitShinyos, 1)
		return
	end
	Blackout(false, "", 3)
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	for idx, unit in pairs(Mission.Shinyos) do
		luaObj_AddUnit("primary", 2, unit)
		unit.AddedToObjective = true
		trg = luaGetNearestUnitFromTable(unit, Mission.TransportFleets)
		if trg then
			NavigatorAttackMove(unit, trg)
		end
	end
	luaIngameMovie(
	{
	    {["postype"] = "cameraandtarget", ["target"] = Mission.Shinyos[1], ["distance"] = 250, ["theta"] = 31, ["rho"] = 27, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Shinyos[1], ["distance"] = 150, ["theta"] = 31, ["rho"] = 51, ["moveTime"] = 4,["smoothtime"] = 2, ["nonlinearblend"] = 0.5},
        {["postype"] = "cameraandtarget", ["target"] = Mission.Shinyos[1], ["distance"] = 100, ["theta"] = 17, ["rho"] = 10, ["moveTime"] = 4},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Shinyos[1], ["distance"] = 20, ["theta"] = 1, ["rho"] = 10, ["moveTime"] = 2,["smoothtime"] = 1, ["nonlinearblend"] = 0.5},
                },
	luaUS13GonePhase6, true)
end
function luaUS13GonePhase6()
	luaDelay(luaUS13TransportNotKilled, 40)
	EnableInput(true)
	luaUS13CheckGuards()
	for idx, unit in pairs(Mission.Guardians) do
		PilotMoveTo(unit, luaPickRnd(Mission.Shinyos))
	end
	SetSelectedUnit(Mission.Guardians[1])
	Mission.MissionPhase = 6
end

function luaUS13AddFirstObjs()
	luaObj_Add("primary", 1)
	luaDelay(luaUS13B29Dialog,3)
end
function luaUS13B29Dialog()
	Mission.PrintObjP1 = true
	luaUS13StartDialog("dlg_1st_phase")
end
function luaUS13HintAA()
	ShowHint("USN13_Hint_AA")
end
function luaUS13OhkaRecognize(...)
-- RELEASE_LOGOFF  	luaLog("****************************************************")
	--luaLog(arg)
	if arg[3] then
		if arg[3].ClassID == 156 then
			luaUS13StartDialog("dlg_ohka_explosion")	
			Mission.OhkaHit = Mission.OhkaHit + 1
			if Mission.OhkaHit > 4 then
				RemoveListener("hit", "OhkaHitID")
				luaUS13StartDialog("dlg_ohka_recognize")
			end
		end
	end
end
function luaUS13SecDialog()
	luaUS13StartDialog("dlg_protecttransports")
end
function luaUS13HintPlanes()
	ShowHint("USN13_Hint_Planes")
end
function luaUS13CheckGuards()
	for idx, unit in pairs(Mission.Guardians) do
		if unit.Dead == true then
			Mission.Guardians[idx] = GenerateObject(Mission.Guardians[idx].Name)
			if Mission.MissionPhase == 6 then
				local pos = luaGetPathPoint(Mission.TransportPaths[idx], 4)
				pos.y = 500
				PutTo(Mission.Guardians[idx], pos)
				SquadronSetTravelAlt(Mission.Guardians[idx], 250)
				SquadronSetAttackAlt(Mission.Guardians[idx], 250)
			elseif Mission.MissionPhase == 5 then
				local pos = luaGetPathPoint(Mission.TransportPaths[idx], 4)
				pos.y = 500
				PutTo(Mission.Guardians[idx], pos)
				SquadronSetTravelAlt(Mission.Guardians[idx], GetPosition(Mission.Guardians[idx]).y)
				SquadronSetAttackAlt(Mission.Guardians[idx], GetPosition(Mission.Guardians[idx]).y)
			else
				local pos = luaGetPathPoint(Mission.TransportPaths[idx], 2)
				pos.y = 100
				PutTo(Mission.Guardians[idx], pos)
				SquadronSetTravelAlt(Mission.Guardians[idx], 80)
				SquadronSetAttackAlt(Mission.Guardians[idx], 80)
			end
			SetRoleAvailable(Mission.Guardians[idx], EROLF_ALL, PLAYER_ANY)
		end
	end
end
function luaUS13SendOutFlyingBoats()
	if not luaObj_IsActive("primary", 2) then
		luaUS13StartDialog("dlg_phase_3")
		luaObj_Add("primary", 2)
	end

	Mission.MavisNumber = Mission.MavisNumber + 1
	if Mission.Mavis[Mission.MavisNumber] and (Mission.Mavis[Mission.MavisNumber].Dead == false) then
		local trg = luaPickRnd(Mission.TransportFleets)
		PilotSetTarget(Mission.Mavis[Mission.MavisNumber], trg)
		luaSetScriptTarget(Mission.Mavis[Mission.MavisNumber], trg)
		SquadronSetAttackAlt(Mission.Mavis[Mission.MavisNumber], 25)
		SquadronSetTravelAlt(Mission.Mavis[Mission.MavisNumber], 50)
		luaObj_AddUnit("primary", 2, Mission.Mavis[Mission.MavisNumber])
	end
	Mission.EmilyNumber = Mission.EmilyNumber + 1
	if Mission.Emily[Mission.EmilyNumber] and (Mission.Emily[Mission.EmilyNumber].Dead == false) then
		local trg = luaPickRnd(Mission.TransportFleets)
		PilotSetTarget(Mission.Emily[Mission.EmilyNumber], trg)
		luaSetScriptTarget(Mission.Emily[Mission.MavisNumber], trg)
		SquadronSetAttackAlt(Mission.Emily[Mission.EmilyNumber], 25)
		SquadronSetTravelAlt(Mission.Emily[Mission.EmilyNumber], 50)
		luaObj_AddUnit("primary", 2, Mission.Emily[Mission.EmilyNumber])
	end
	if Mission.MavisNumber < table.getn(Mission.Mavis) or Mission.EmilyNumber < table.getn(Mission.Emily) then
		luaDelay(luaUS13SendOutFlyingBoats, random(4,8))
	end
end
function luaUS13SendOutFlyingBoats2()
	Mission.FlyingBoats2 = luaRemoveDeadsFromTable(Mission.FlyingBoats2)
	Mission.FlyingBoats2Up = true
	for idx, unit in pairs(Mission.FlyingBoats2) do
		local trg = luaPickRnd(Mission.TransportFleets)
		PilotSetTarget(Mission.FlyingBoats2[idx], trg)
		luaSetScriptTarget(Mission.FlyingBoats2[idx], trg)
		SquadronSetAttackAlt(Mission.FlyingBoats2[idx], 25)
		SquadronSetTravelAlt(Mission.FlyingBoats2[idx], 50)
		luaObj_AddUnit("primary", 2, Mission.FlyingBoats2[idx])
	end
end
function luaUS13GiveHellcats()
	Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
	for idx, unit in pairs(Mission.Hellcats) do
		Mission.Hellcats[idx] = GenerateObject(unit)
		--local trg = luaGetNearestUnitFromTable(Mission.Hellcats[idx],Mission.B29)
		local cap = luaPickRnd(Mission.B29)
		EntityTurnToEntity(Mission.Hellcats[idx], cap)
		PilotMoveTo(Mission.Hellcats[idx], cap)
		table.insert(Mission.USPlanes, Mission.Hellcats[idx])
		SquadronSetAttackAlt(Mission.Hellcats[idx], GetPosition(Mission.Hellcats[idx]).y)
		SquadronSetTravelAlt(Mission.Hellcats[idx], GetPosition(Mission.Hellcats[idx]).y)
	end
	for idx, unit in pairs(Mission.B29) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end
	
	luaUS13SpawnAttackers(1, luaPickRnd(Mission.B29))
	luaUS13SpawnAttackers(1, luaPickRnd(Mission.B29))
	luaUS13SpawnAttackers(1, luaPickRnd(Mission.Hellcats))
	BlackBars(true)
	HideScoreDisplay(1, 0)
	luaIngameMovie(
	{
	    {["postype"] = "cameraandtarget", ["target"] = Mission.Hellcats[2], ["distance"] = 250, ["theta"] = 31, ["rho"] = 27, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Hellcats[2], ["distance"] = 150, ["theta"] = 31, ["rho"] = 51, ["moveTime"] = 4,["smoothtime"] = 2, ["nonlinearblend"] = 1},
        {["postype"] = "cameraandtarget", ["target"] = Mission.Hellcats[1], ["distance"] = 100, ["theta"] = 17, ["rho"] = 190, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Hellcats[1], ["distance"] = 20, ["theta"] = 1, ["rho"] = 180, ["moveTime"] = 6,["smoothtime"] = 1, ["nonlinearblend"] = 1},
                },
	luaUS13GiveHellcats2, true)
	luaDelay(luaUS13HellcatsDialog, 3)
end
function luaUS13HellcatsDialog()
	luaUS13StartDialog("dlg_fighters_join")
end
function luaUS13GiveHellcats2()
	Mission.MissionPhase = 2
	BlackBars(false)
	EnableInput(true)
	ForceEnableInput(IC_CMD_SETTARGET, true)
	ForceEnableInput(IC_CMD_CLEARTARGET, true)
	if Mission.Hellcats[1].Dead == false then
		SetSelectedUnit(Mission.Hellcats[1])
	end
end
function luaUS13ManagePTs()
-- RELEASE_LOGOFF  	luaLog("Manage PTs")
	Mission.PT1 = luaRemoveDeadsFromTable(Mission.PT1)
	
	for idx, unit in pairs(Mission.PT1) do
		--luaLog("unit:")
		--luaLog(unit.Name)
		--luaLog(GetProperty(unit, "unitcommand"))
		if GetProperty(unit, "unitcommand") ~= "attackmove" then
			local trg = luaGetNearestUnitFromTable(unit, Mission.TransportFleets)
			--luaLog("target:")
			--luaLog(trg.Name)
			NavigatorAttackMove(unit, trg,{})
		end
	end
end

function luaUS13SpawnPT1(par)
-- RELEASE_LOGOFF  	luaLog("luaUS13SpawnPT1")
	if table.getn(Mission.PT1) < 15 then
		local spawnpoint = par.ParamTable.spawnpoint
		local quantity = par.ParamTable.quantity
		if (Mission.PTHangar[spawnpoint].Dead == false) and (Mission.PTHangar[spawnpoint].Party == PARTY_JAPANESE) then
			local grpmemb = {}	
			for i = 1, quantity do
				local toinsert = {
						["Type"] = 43,
						["Name"] = "ingame.shipnames_shinyo|."..luaRnd(12,985),
					}
				--luaLog(toinsert)
				table.insert(grpmemb, toinsert)
			end
			--luaLog(grpmemb)
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = grpmemb,
				["area"] = {
					["refPos"] = GetPosition(Mission.PTSpawnPoint[spawnpoint]),
					["angleRange"] = { -1, 1},
					["lookAt"] = Mission.Lookat[spawnpoint],
				},
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 10,
					["enemyHorizontal"] = 20,
					["ownVertical"] = 75,
					["enemyVertical"] = 50,
					["formationHorizontal"] = 20,
				},
				["callback"] = "luaUS13RefreshPT",
			})
			--luaLog("PTSpawn from")
			--luaLog(spawnpoint)
			--luaDelay(luaUS13SpawnPT1, Mission.PTInterval + random(1, 10) - 5 , "spawnpoint", spawnpoint, "quantity", random(1, Mission.MaxPTSpawn))
		end
	end
end
function luaUS13RefreshPT(...)
	for idx=1,arg["n"] do
		UnitFreeAttack(arg[idx])
		SetGuiName(arg[idx], arg[idx].Name)
	end
end
function luaUS13SpawnAttackers(quantity, relativeto)
-- RELEASE_LOGOFF  	luaLog(" --- Spawning attacker ---")
	local grpmemb = {}
	repeat
		table.insert(grpmemb, luaPickRnd(Mission.JapPlaneTypes))
		quantity = quantity - 1
	until quantity < 1
	local spawnpos = GetPosition(relativeto)
	local dist = ReconClass[relativeto.Class.ReconClass].Details.ObserverAir.GUIRange[1].Range
	local rot = GetRotation(relativeto).y
	rot = rot + random(-35, 35)
	rot = math.pi * rot /180
	spawnpos.x = spawnpos.x + math.sin(rot) * dist
	spawnpos.z = spawnpos.z + math.cos(rot) * dist
	spawnpos.y = 1400
	if Mission.Difficulty > 1 then
		skill = SKILL_SPVETERAN
	else
		skill = SKILL_SPNORMAL
	end
-- RELEASE_LOGOFF  --	luaLog(skill)
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = grpmemb,
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { -1, 1},
			["lookAt"] = GetPosition(relativeto),
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 550,
			["enemyHorizontal"] = 100,
			["ownVertical"] = 175,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 250,
		},
		["callback"] = "luaUS13AttackerSpawned",
	})
end
function luaUS13SpawnSecondAttackerWave()
	if Mission.MissionPhase == 1 then
		if table.getn(Mission.B29) ~= nil then
			luaUS13SpawnAttackers(1, luaPickRnd(Mission.B29))
			luaUS13SpawnAttackers(1, luaPickRnd(Mission.B29))
		end
	end
end
function luaUS13AttackBombers()
	Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
	--LogToConsole(GameTime())
	for idx, unit in pairs(Mission.AttackerPlanes) do
		--LogToConsole(unit.Name)
		--LogToConsole(GetProperty(unit, "unitcommand"))
		if GetProperty(unit, "unitcommand") ~= "dogfight" then
			local trg = luaPickRnd(Mission.USPlanes)
			if trg ~= nil then
				PilotSetTarget(unit, trg)
				local y = GetPosition(trg).y + 200
				SquadronSetAttackAlt(unit, y)
				SquadronSetTravelAlt(unit, y)
-- RELEASE_LOGOFF  				luaLog(unit.Name.." attacks "..trg.Name)
			end
		end
	end
end
function luaUS13AttackerSpawned(...)
-- RELEASE_LOGOFF  	luaLog(" *** Attacker Spawned *** ")
	--luaLog(arg["n"])
	for i = 1, arg["n"] do
		table.insert(Mission.AttackerPlanes, arg[i])
		local trg = luaGetNearestEnemy(arg[i])
		if Mission.Difficulty > 0 then
			skill = SKILL_SPVETERAN
		else
			skill = SKILL_SPNORMAL
		end
		if trg then
-- RELEASE_LOGOFF  			luaLog(trg.Name)
			local y = GetPosition(trg).y + 200
			SquadronSetAttackAlt(arg[i], y)
			SquadronSetTravelAlt(arg[i], y)
			PilotSetTarget(arg[i], trg)
			SetSkillLevel(arg[i], skill)
-- RELEASE_LOGOFF  			luaLog(GetSkillLevel(arg[i]))
		end
	end
end

function luaUS13ManagePlanes1()
	for idx, unit in pairs(Mission.Airfields) do
		if (unit.Dead == false) then
			luaAirfieldManager(unit, {150,152,154}, {150, 32}, Mission.TransportFleets, 500)
			
			activeSquads, squadEntTable = luaGetSlotsAndSquads(unit)
			if activeSquads ~= 0 then
				for idx, unit in pairs(squadEntTable) do
					if unit.ClassID == 32 then
						luaUS13StartDialog("dlg_ohkas_incoming")
					end
					if GetProperty(unit, "unitcommand") == "moveto" then
						local tg = luaPickRnd(Mission.TransportFleets)
						if tg.Dead == false then
							PilotSetTarget(unit, tg)
						end
					end
				end
			end
		end
	end
end
function luaUS13StartDialog(dialogID)
	if Mission.EndMission ~= true then
		if (Mission.Dialogues[dialogID].printed == nil) then
			StartDialog(dialogID, Mission.Dialogues[dialogID])
			Mission.Dialogues[dialogID].printed = true
			--luaLog("Dialog started. ID: "..dialogID)
		end
	end
end
function luaUS13JoinFormations(tab)
	local idx = 1
	while idx < table.getn(tab) do
	 idx = idx + 1
	 JoinFormation(tab[idx], tab[1])
	end
end
function luaUS13GenerateObjects(objtab)
	for idx, unit in pairs(objtab) do
		objtab[idx] = GenerateObject(unit)
	end
end
function luaUS13BombersRetreat()
	luaUS13StartDialog("dlg_bombers_retreat")
end
function luaUS13BombersRetreatCallback()
	luaClearDialogs()
	Mission.USPlanes = luaRemoveDeadsFromTable(Mission.USPlanes)
	for idx, unit in pairs(Mission.USPlanes) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		PilotRetreat(unit)
	end
	Mission.B29 = luaRemoveDeadsFromTable(Mission.B29)
	luaMissionFailedNew(Mission.B29[1], "usn13.obj_p1_fail", nil, true)
end
function luaUS13InitSub()
	SetSimplifiedSonarMultiplier(3)
	--SetDeviceReloadTimeMul(3)
	--[[
	Mission.Guardians = luaRemoveDeadsFromTable(Mission.Guardians)
	for idx, unit in pairs(Mission.Guardians) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		PilotMoveTo(unit, luaPickRnd(Mission.TransportFleets))
	end
	]]
	Mission.TypeB = GenerateObject("Type B")
	AddUntouchableUnit(Mission.TypeB)
	RepairEnable(Mission.TypeB, false)
	luaObj_AddUnit("primary", 2, Mission.TypeB)
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	
	Mission.ShipToDie = FindEntity("Northampton-class 01")
	
	PutRelTo(Mission.TypeB, Mission.ShipToDie, {["x"] = -450, ["y"] = -5, ["z"] = 950})
	EntityTurnToEntity(Mission.TypeB, Mission.ShipToDie)
	NavigatorMoveToPos(Mission.TypeB, GetPosition(Mission.ShipToDie))
	ShipSetTorpedoStock(Mission.TypeB, 3000)
	SetSubmarineDepthLevel(Mission.TypeB, 0)
	local planes = luaGetOwnUnits("plane")
	for idx, unit in pairs(planes) do
		Kill(unit, true)
	end
	Mission.Reconplane = GenerateObject("OS2U Kingfisher")
	Mission.Reconplane2 = GenerateObject("OS2U Kingfisher2")
	Mission.Reconplanes = {Mission.Reconplane, Mission.Reconplane2}
	PutRelTo(Mission.Reconplane, Mission.ShipToDie, {["x"] = -40, ["y"] = 200, ["z"] = -1500})
	PutRelTo(Mission.Reconplane2, Mission.ShipToDie, {["x"] = 120, ["y"] = 200, ["z"] = -1800})
	for idx, unit in pairs(Mission.Reconplanes) do
		SquadronSetTravelAlt(unit, 75 + idx * 50, true)
		SquadronSetAttackAlt(unit, 75 + idx * 50, true)
	end
	BlackBars(true)
	Blackout(false, "", 2)
	luaIngameMovie(
	{
		{["postype"] = "camera", ["target"] = Mission.ShipToDie, ["distance"] = 100, ["theta"] = 40, ["rho"] = 348, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "target", ["target"] = Mission.TypeB, ["moveTime"] = 0},
		{["postype"] = "target", ["target"] = Mission.TypeB, ["moveTime"] = 5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 100, ["theta"] = -5, ["rho"] = 348, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 95, ["theta"] = -1, ["rho"] = 318, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 90, ["theta"] = -5, ["rho"] = 260, ["moveTime"] = 3, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 95, ["theta"] = -10, ["rho"] = 211, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 110, ["theta"] = -20, ["rho"] = 201, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		}
	, luaUS13SubMovie_End, true)
	
	luaDelay(luaUS13DlgSubmarine, 4)
end
function luaUS13DlgSubmarine()
	luaUS13StartDialog("dlg_submarine")
	SetSubmarineDepthLevel(Mission.TypeB, 1)
	NavigatorAttackMove(Mission.TypeB, Mission.ShipToDie, {})
	SetInvincible(Mission.ShipToDie, 0)
	for idx, unit in pairs(Mission.Reconplanes) do
		--EntityTurnToEntity(unit, Mission.ShipToDie)
		PilotMoveTo(unit, Mission.TypeB)
	end
end
function luaUS13SubMovie_End()
	BlackBars(false)
	EnableInput(true)
	EntityTurnToEntity(Mission.TypeB, Mission.ShipToDie)
	SetSelectedUnit(luaPickRnd(Mission.Reconplanes))
	AddListener("kill", "SubKillListenerID", {
		["callback"] = "luaUS13SubKilled",  -- callback fuggveny
		["entity"] = {Mission.TypeB}, -- entityk akiken a listener aktiv
		["lastAttacker"] = { },  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
	})
	
	Mission.MissionPhase = 4
end
function luaUS13SubKilled()
	HideScoreDisplay(1, 0)
	HideUnitHP()
	RemoveListener("kill", "SubKillListenerID")
	Mission.MissionPhase = -1
	--[[
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 200, ["theta"] = 20, ["rho"] = 181, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.TypeB, ["distance"] = 200, ["theta"] = 12, ["rho"] = 151, ["moveTime"] = 8, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0.5},
	}, luaUS13GotoPhase5, false)
	]]
	MissionNarrative("usn13.obj_sub_comp")
	Blackout(true, "luaUS13GotoPhase5", 3)
end

function luaUS13InitShips()
	Mission.TransportFleet1 = {
		FindEntity("USTroopTransport 01"),
		FindEntity("USTroopTransport 02"),
		FindEntity("USTroopTransport 03"),
		FindEntity("Northampton-class 01"),
	FindEntity("LSM 02"),
		FindEntity("Cleveland-class 03"),
		FindEntity("Cleveland-class 04"),
		FindEntity("Cleveland-class 05"),
		FindEntity("Cleveland-class 06")
}
	luaUS13JoinFormations(Mission.TransportFleet1)
	Mission.TransportFleet2 = {
		FindEntity("USTroopTransport 04"),
		FindEntity("USTroopTransport 05"),
		FindEntity("USTroopTransport 06"),
		FindEntity("USTroopTransport 07"),
		FindEntity("LSM 05"),
	FindEntity("South Dakota Class 02"),
		FindEntity("Cleveland-class 02"),
		FindEntity("Northampton-class 03"),
}
	luaUS13JoinFormations(Mission.TransportFleet2)
	Mission.TransportFleet3 = {
		FindEntity("USTroopTransport 08"),
		FindEntity("USTroopTransport 09"),
		FindEntity("USTroopTransport 10"),
		FindEntity("USTroopTransport 11"),
		FindEntity("Northampton-class 02"),
		FindEntity("LSM 04"),
	FindEntity("Northampton-class 04"),
		FindEntity("South Dakota Class 01"),
		FindEntity("Cleveland-class 01"),
		FindEntity("LSM 01"),
		FindEntity("LSM 03")
}
	luaUS13JoinFormations(Mission.TransportFleet3)
	
	Mission.TransportFleets = {
		FindEntity("USTroopTransport 01"),
		FindEntity("USTroopTransport 02"),
		FindEntity("USTroopTransport 03"),
		FindEntity("USTroopTransport 04"),
		FindEntity("USTroopTransport 05"),
		FindEntity("USTroopTransport 06"),
		FindEntity("USTroopTransport 07"),
		FindEntity("USTroopTransport 08"),
		FindEntity("USTroopTransport 09"),
		FindEntity("USTroopTransport 10"),
		FindEntity("USTroopTransport 11"),
	}
	Mission.MaxTransportFleets = table.getn(Mission.TransportFleets)
	--[[Mission.LSM01Fleet = {
		"LSM 01",
		"Fletcher-class 09",
		"Fletcher-class 11",
		"Fletcher-class 12",
		"Atlanta-class 01",
		"Atlanta-class 02",
		"Atlanta-class 03",
	}]]
	
	AddListener("kill", "TransportKillListenerID", {
		["callback"] = "luaUS13TransportKilled",  -- callback fuggveny
		["entity"] = Mission.TransportFleets, -- entityk akiken a listener aktiv
		["lastAttacker"] = { },  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
	})
	
	for i = 1, 5 do
		SetGuiName(FindEntity("LSM 0"..i), tostring("ingame.shipnames_lsm|.0"..41+i))
	end
end
function luaUS13TransportKilled(unit, lastAttacker)
	--RemoveListener("kill", "TransportKillListenerID")
	Mission.LastKilledTransport = unit
	if lastAttacker then -- kamikaze nem megy HACK
		if lastAttacker.Type == "TORPEDOBOAT" then
			--RemoveListener("kill", "TransportKillListenerID")
			if luaObj_IsActive("secondary", 1) == false then
				luaUS13StartDialog("dlg_pt_hangars")
			end
		end
	end
end
function luaUS13TransportNotKilled()
	if IsListenerActive("kill", "TransportKillListenerID") then
		RemoveListener("kill", "TransportKillListenerID")
		luaUS13StartDialog("dlg_pt_hangars2")
	end
end
function luaUS13AddHangarObj()
	luaObj_Add("secondary", 1, Mission.PTHangar)
	--[[
	for idx, unit in pairs(Mission.PTHangar) do
		if unit.Dead == false then
			luaObj_AddUnit("secondary", 1, unit)
		end
	end
	]]
end
function luaUS13HangarPowerup()
	RemoveListener("kill", "HangarPowerupListenerID")
	--[[AddPowerup(
		{
				["classID"] = "levelbomb1",
				["useLimit"] = 1,
		})]]
end
function luaUS13LandingMovie()
	Mission.EndMission = true
	HideScoreDisplay(1,0)
	Mission.TransportFleets = luaRemoveDeadsFromTable(Mission.TransportFleets)
	Mission.TransportFleet1 = luaRemoveDeadsFromTable(Mission.TransportFleet1)
	Mission.TransportFleet2 = luaRemoveDeadsFromTable(Mission.TransportFleet2)
	Mission.TransportFleet3 = luaRemoveDeadsFromTable(Mission.TransportFleet3)
	
	Blackout(true,"luaUS13LandingMovie_1", 3)
end
function luaUS13LandingMovie_1()
	Mission.MovieHiggins = {}
	for i = 1,28 do
		local higgins
		if i < 10 then
			higgins = GenerateObject("Higgins LCVP 0"..i)
		else
			higgins = GenerateObject("Higgins LCVP "..i)
		end
		if higgins ~= nil then
			StartLanding2(higgins)
			table.insert(Mission.MovieHiggins, higgins)
		end
	end
	BlackBars(true)
	local japs = luaGetOwnUnits(nil, PARTY_JAPANESE)
	for idx, unit in pairs(japs) do
		if unit.Dead == false then
			if not luaIsInside(unit, Mission.CommandStations) then
				Kill(unit, true)
			end
		end
	end
	japs = nil
	Mission.CommandStations = luaRemoveDeadsFromTable(Mission.CommandStations)
	Mission.TransportFleet1 = luaRemoveDeadsFromTable(Mission.TransportFleet1)
	Mission.TransportFleet2 = luaRemoveDeadsFromTable(Mission.TransportFleet2)
	Mission.TransportFleet3 = luaRemoveDeadsFromTable(Mission.TransportFleet3)
	
	local x = -1500
	local z = -1500
	if table.getn(Mission.TransportFleet1) ~= 0 then
		local leader = GetFormationLeader(Mission.TransportFleet1[1])
		if not leader then
			leader = Mission.TransportFleet1[1]
		end
		if leader then
			EntityTurnToEntity(leader, Mission.CommandStation01)
			NavigatorAttackMove(leader, Mission.CommandStation01,{})
			PutFormationTo(leader, luaGetPathPoint(Mission.TransportPath1,5), 3)
		end
	end	
	x = -1350
	z = 1800
	if table.getn(Mission.TransportFleet2) ~= 0 then
		leader = GetFormationLeader(Mission.TransportFleet2[1])
		if not leader then
			leader = Mission.TransportFleet2[1]
		end
		if leader then
			EntityTurnToEntity(leader, Mission.CommandStation02)
			NavigatorAttackMove(leader, Mission.CommandStation02,{})
			PutFormationTo(leader, luaGetPathPoint(Mission.TransportPath2,5), 3)
		end
	end
	x = -1800
	z = -1300
	if table.getn(Mission.TransportFleet3) ~= 0 then
		leader = GetFormationLeader(Mission.TransportFleet3[1])
		if not leader then
			leader = Mission.TransportFleet3[1]
		end
		if leader then
			EntityTurnToEntity(leader, Mission.CommandStation03)
			NavigatorAttackMove(leader, Mission.CommandStation03,{})
			PutFormationTo(leader, luaGetPathPoint(Mission.TransportPath3,5), 3)
		end
	end
	
	Mission.EndMovieTransport = luaPickRnd(Mission.MovieHiggins)
	Mission.MovieCB = luaGetNearestUnitFromTable(Mission.EndMovieTransport, Mission.CommandStations)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.EndMovieTransport, ["distance"] = 540, ["theta"] = 15, ["rho"] = 75, ["moveTime"] = 0, ["terrainavoid"] = true},
		{["postype"] = "cameraandtarget", ["target"] = Mission.EndMovieTransport, ["distance"] = 440, ["theta"] = 10, ["rho"] = 75, ["moveTime"] = 8, ["terrainavoid"] = true},
		{["postype"] = "target", ["target"] = Mission.MovieCB, ["moveTime"] = 16, ["smoothtime"] = 2, ["nonlinearblend"] = 0.1, ["terrainavoid"] = true},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieCB, ["distance"] = 400, ["theta"] = 25, ["rho"] = 145, ["moveTime"] = 0, ["terrainavoid"] = true, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieCB, ["distance"] = 500, ["theta"] = 8, ["rho"] = 215, ["moveTime"] = 15, ["terrainavoid"] = true, ["nonlinearblend"] = 0.1},
	},
	luaUS13LandingMovieEnd)
	Blackout(false, "", 3)
end

function luaUS13LandingMovieEnd()
	EnableInput(true)
	local medal = luaGetMedalReward()
	if (medal == MEDAL_GOLD) then
		Scoring_GrantBonus("US13_SCORING_GOLD", "usn13.bonus1_title", "usn13.bonus1_text", 12)
	end
	if table.getn(Mission.TransportFleets) == Mission.MaxTransportFleets then
		luaObj_Completed("hidden", 1)
	end
	luaObj_Completed("primary", 2)
	luaMissionCompletedNew(nil, "usn13.obj_p2_comp", nil)
end
function luaUS13Checkpoint1Load()
	--SoundFade(1, "",0.1)
	AddDamage(Mission.FortressToBomb,200000)
	MissionNarrativeClear()
end
function luaUS13Phase()
	if Mission.MissionPhase < 3 then
		luaUS13GotoPhase3()
	elseif Mission.MissionPhase == 3 then
		luaUS13GotoPhase4()
		for idx, unit in pairs(luaGetOwnUnits("plane", PARTY_JAPANESE)) do
			Kill(unit)
		end
	elseif Mission.MissionPhase == 4 then
		AddDamage(Mission.TypeB, 10000)
	end
end
function lose()
	luaMissionFailedNew(nil, "szevasz", nil, true)
end