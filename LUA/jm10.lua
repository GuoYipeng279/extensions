--SceneFile="universe\Scenes\missions\IJN\ijn_10_sydney.scn"
DoFile("Scripts/datatables/Inputs.lua")
function luaEngineMovieInit()
	EnableMessages(false)
	LoadMessageMap("ijndlg",10)
	Music_Control_SetLevel(MUSIC_TENSION)

	Dialogues =
	{
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
			},
		},
		["Intro_2"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a_1",
				},
			},
		},
		["Intro_3"] = {
			["sequence"] = {
				{
					["message"] = "idlg01b",
				},
			},
		},
	}

	MissionNarrative("ijn10.date_location")
	luaDelay(luaEngineMInit, 6)
end

function luaEngineMInit()
	StartDialog("Intro_dlg", Dialogues["Intro"] );
	luaDelay(luaEngineMInit2, 11)
end

function luaEngineMInit2()
	StartDialog("Intro_dlg2", Dialogues["Intro_2"] );
	luaDelay(luaEngineMInit3, 7.8)
end

function luaEngineMInit3()
	StartDialog("Intro_dlg3", Dialogues["Intro_3"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM10")
	Scoring_RealPlayTimeRunning(true)
end

--ToDos

function luaInitJM10(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM10.lua"

	this.Name = "JM10"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	--enginemovies
	--luaInitJumpinMovies()

	--this.ObjRemindTime = 150

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.Difficulty = GetDifficulty()

	Mission.PlayerUnit = FindEntity("Type A minisub 01")

	AddUntouchableUnit(Mission.PlayerUnit)

	Mission.CheckPoint = GetPosition(FindEntity("MiniSubSpawnPoint"))
	Mission.LookAt = GetPosition(FindEntity("WayPoint6"))
	Mission.WaterMines = {}
	Mission.WaterMinesPos = {}
	for idx,unitTbl in pairs(thisTable) do
		if unitTbl.Type == "WATERMINE" and not unitTbl.Dead then
			table.insert(Mission.WaterMines, thisTable[tostring(unitTbl.ID)])
			table.insert(Mission.WaterMinesPos, GetPosition(thisTable[tostring(unitTbl.ID)]))
			--luaLog("Found a mine")
		end
	end

	SetGuiName(Mission.PlayerUnit, "ingame.shipnames_m|.14")
	SetSubmarineDepthLevel(Mission.PlayerUnit, 1)
	SetUnlimitedAirSupply(Mission.PlayerUnit, true)
	luaDelay(luaJM10RemoveUnlimitedAir, 120, "unitID", Mission.PlayerUnit.ID)
	Mission.IJNSubs = {}
		table.insert(Mission.IJNSubs, FindEntity("Submarine TypeB w Jake 01"))
		table.insert(Mission.IJNSubs, FindEntity("Submarine TypeB w Jake 02"))
		table.insert(Mission.IJNSubs, FindEntity("Submarine TypeB w Jake 03"))
		for idx,unit in pairs(Mission.IJNSubs) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end


	Mission.IJNSubNames = {}
		table.insert(Mission.IJNSubNames, "ingame.shipnames_i|.21")
		table.insert(Mission.IJNSubNames, "ingame.shipnames_i|.22")
		table.insert(Mission.IJNSubNames, "ingame.shipnames_i|.24")

	--traffic init
	Mission.PatrolPath = {}
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 01"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 02"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 03"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 04"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 01"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 02"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 03"))
		table.insert(Mission.PatrolPath, FindEntity("PatrolPath 04"))
	Mission.PatrolBoats = {}
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 01"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 02"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 03"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 04"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 05"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 06"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 07"))
		table.insert(Mission.PatrolBoats, FindEntity("PT Boat 80' Elco 08"))

	Mission.PtNames = {}
		table.insert(Mission.PtNames, "ingame.shipnames_yarroma")
		table.insert(Mission.PtNames, "ingame.shipnames_lolita")
		table.insert(Mission.PtNames, "ingame.shipnames_steady_hour")
		table.insert(Mission.PtNames, "ingame.shipnames_sea_mist")
		table.insert(Mission.PtNames, "ingame.shipnames_marlean")
		table.insert(Mission.PtNames, "ingame.shipnames_toomaree")
		table.insert(Mission.PtNames, "ingame.shipnames_destiny")
		table.insert(Mission.PtNames, "ingame.shipnames_oneone")

	Mission.AKPatrolPath = {}
		table.insert(Mission.AKPatrolPath, FindEntity("AKMovingInPath"))
		table.insert(Mission.AKPatrolPath, FindEntity("AKMovingInPath"))
		table.insert(Mission.AKPatrolPath, FindEntity("AKMovingOutPath"))
		table.insert(Mission.AKPatrolPath, FindEntity("AKMovingOutPath"))
	Mission.AKPatrols = {}
		table.insert(Mission.AKPatrols, FindEntity("US Tanker 01"))
		table.insert(Mission.AKPatrols, FindEntity("US Tanker 02"))
		table.insert(Mission.AKPatrols, FindEntity("Hospital Ship 01"))
		table.insert(Mission.AKPatrols, FindEntity("Fletcher-class 01"))

	Mission.Hospitalship = FindEntity("Hospital Ship 01")
	Mission.Tanker1 = FindEntity("US Tanker 01")
	Mission.Tanker2 = FindEntity("US Tanker 02")

	Mission.AKPatrolNames = {}
		table.insert(Mission.AKPatrolNames, "ingame.shipnames_canberra")
		table.insert(Mission.AKPatrolNames, "ingame.shipnames_whyalla")
		table.insert(Mission.AKPatrolNames, "ingame.shipnames_wanganella")
		table.insert(Mission.AKPatrolNames, "ingame.shipnames_perkins")

	Mission.MaxAttackingPts = 2

	Mission.USNDDs = {}

	Mission.AKTargets = {}
		--table.insert(Mission.AKTargets, FindEntity("US Cargo Transport 01"))
		table.insert(Mission.AKTargets, FindEntity("US Cargo Transport 02"))
		table.insert(Mission.AKTargets, FindEntity("US Cargo Transport 03"))
		table.insert(Mission.AKTargets, FindEntity("US Cargo Transport 04"))
		table.insert(Mission.AKTargets, FindEntity("US Cargo Transport 05"))

	Mission.AKTargetNames = {}
		table.insert(Mission.AKTargetNames, "ingame.shipnames_westralia")
		table.insert(Mission.AKTargetNames, "ingame.shipnames_kanimbla")
		table.insert(Mission.AKTargetNames, "ingame.shipnames_dobbin")
		table.insert(Mission.AKTargetNames, "ingame.shipnames_adelaide")
		--table.insert(Mission.AKTargetNames, "HMAS Bungaree")

	Mission.Reconable = table.getn(Mission.AKTargets)

	Mission.AlertLevel = 0
	Mission.SafeZones = {
		[1] = {GetPosition(FindEntity("SafeZoneA 01")), GetPosition(FindEntity("SafeZoneA 02"))},
		[2] = {GetPosition(FindEntity("SafeZoneB 01")), GetPosition(FindEntity("SafeZoneB 02"))},
		[3] = {GetPosition(FindEntity("SafeZoneC 01")), GetPosition(FindEntity("SafeZoneC 02"))},
	}


	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM10LoadBlackout},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM10SaveMissionData,},
	}


	luaDelay(luaJM10GenerateDDConvoy, 90)

	Mission.PlayerSpawnReq = "PlayerSpawnReq"
	Mission.UsedPlayerUnits = 1

	--hiddenhez dolgok

	Mission.Mavis = FindEntity("Mavis")
	SetGuiName(Mission.Mavis, "ijn10.crashed_plane")
	SetInvincible(Mission.Mavis, true)

	Mission.Cats = {}

	Mission.CivilBoats = {}

	local Yacht1 = FindEntity("Yacht 01")
	Yacht1.Path = FindEntity("CivilPath1")
	SetGuiName(Yacht1, "ingame.shipnames_yacht")

	local Yacht2 = FindEntity("Yacht 02")
	Yacht2.Path = FindEntity("CivilPath2")
	SetGuiName(Yacht2, "ingame.shipnames_yacht")

	table.insert(Mission.CivilBoats,Yacht1)
	table.insert(Mission.CivilBoats,Yacht2)

	--hints
	Mission.RndHints = {}
	table.insert(Mission.RndHints, luaJM10TorpHint)
	--table.insert(Mission.RndHints, luaJM10AmmoHint)
	--table.insert(Mission.RndHints, luaJM10SafeHint)
	table.insert(Mission.RndHints, luaJM10SneakHint)
	table.insert(Mission.RndHints, luaJM10MsubHint)

	Mission.LastHintDisplayed = 120 --ennel elobb nem hivunk rnd hintet
	Mission.HintDisplayInterval = 120

	Mission.WayPoints = {}
	for i=1,6 do
		local point = FindEntity("WayPoint"..tostring(i))
		local tbl = {
			coord = GetPosition(point),
			marked = false
		}
		table.insert(Mission.WayPoints, tbl)
	end


	Mission.WayPointNames = {
		"ijn10.waypoint_a",
		"ijn10.waypoint_b",
		"ijn10.waypoint_c",
		"ijn10.waypoint_d",
		"ijn10.waypoint_e",
		"ijn10.waypoint_f"
	}

	Mission.Ports = {}

	for i=1,9 do
		local port = FindEntity("Port 0"..tostring(i))
		table.insert(Mission.Ports, port)
	end

	Mission.CivilTrafficID = {95,96}
	Mission.CivilTraffic = {}
	Mission.MaxCivilTrafficAllowed = 9

	--objectives
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "sneak",
				["Text"] = "ijn10.obj_p1",
				["TextCompleted"] = "ijn10.obj_p1_comp" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "recon",
				["Text"] = "ijn10.obj_p2",
				["TextCompleted"] = "ijn10.obj_p2_comp" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "kill",
				["Text"] = "ijn10.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "alert",
				["Text"] = "ijn10.obj_s1",
				["TextCompleted"] = "ijn10.obj_s1_comp" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "mavis",
				["Text"] = "ijn10.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
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
		},
		["marker3"] = {
				[1] = {
				["ID"] = "minemarker",
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

	LoadMessageMap("ijndlg",10)

	this.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM10Init"
				},
			},
		},
		["AK_Entrance"] = {
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM10AddSec"
				},
			},
		},
		["Mine_reconned"] = {
			["sequence"] = {
				{
					["message"] = "dlg3",
				},
			},
		},
		["Ships_reconned"] = {
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
			},
		},
		["PlayerSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["PlayerLost"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["Inharbour"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
				{
					["message"] = "dlg7_1",
				},
			},
		},
		["Player_died"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
			},
		},
		["Tanker"] = {
			["sequence"] = {
				{
					["message"] = "dlg9",
				},
			},
		},
		["Hospitalship"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["Civilcargo"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["Ammoship"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["EasterEgg"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
			},
		},
		["hiddencomp"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
				{
					["message"] = "dlg14c",
				},
				{
					["message"] = "dlg14d",
				},
			},
		},

	}

	Mission.MissionPhase = 1

	this.Cheat_PhaseShift = false

	--AddWatch("Mission.AlertLevel")
	--AddWatch("Mission.PlayerDetected")
	--AddWatch("Mission.NoThink")
	--AddWatch("Mission.MissionPhase")
	--AddWatch("Mission.basz")

	luaJM10SetGuiNames()

-- RELEASE_LOGOFF  	luaLog("Zene")
	luaCheckMusicSetMinLevel(MUSIC_CALM)
-- RELEASE_LOGOFF  	luaLog("SetSelectedUnit")
	SetSelectedUnit(Mission.PlayerUnit)
	if Mission.Difficulty == 2 then
		ShipSetTorpedoStock(Mission.PlayerUnit, 4)
	else
		ShipSetTorpedoStock(Mission.PlayerUnit, 8)
	end

	luaCheckSavedCheckpoint()

-- RELEASE_LOGOFF  	luaLog("Blackout")


	if not Mission.CheckpointLoaded then
		Blackout(false, "", 1.5)
		luaJM10StartDialog("Init")
		luaDelay(luaJM10SafeHint, 10)
	end
	--think
-- RELEASE_LOGOFF  	luaLog("Think")
	SetThink(this, "luaJM10_think")
end

function luaJM10_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")
	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end


	if Mission.EndMission then
		return
	end

	--debug
	Mission.basz = luaJM10IsPlayerInSafeZone()

	luaJM10CheckPlayer()

	--luaJM10CivilTraffic() -- because of performance

	if Mission.NoThink then
-- RELEASE_LOGOFF  		luaLog("NoThink")
		return
	end

	--luaCheckMusic()  -- because of performance
	--luaJM10SubtitleChecker()

	if Mission.Init then
		luaJM10CheckObjectives()
		luaJM10Hidden()
	--luaJM10MarkWaterMines()
	end

	--luaJM10CheckCivilTraffic()  -- because of performance
	luaJM10CheckCatalinas()
	luaJM10RndHint()

	if Mission.MissionPhase == 1 then

		if this.Cheat_PhaseShift then
			local point = GetPosition(FindEntity("WayPoint6"))
			point.y = -15
			PutTo(Mission.PlayerUnit, point)
			this.Cheat_PhaseShift = false
		end

		luaJM10CheckWayPoints()
		luaJM10GetAlertLvl()

	elseif Mission.MissionPhase == 2 then

		luaJM10ReconUnit()
		luaJM10CheckDeadAK()

	elseif Mission.MissionPhase == 3 then


	end

	if Mission.MissionPhase < 99 then
		--luaJM10GetAlertLvl()
		luaJM10Traffic()
		--luaJM10CheckWayPoints()
	end
end

function luaJM10GetAlertLvl()
	if Mission.PlayerDetected or Mission.PlayerUnit.Dead then
		return
	end

	local surface = luaJM10IsPlayerOnSurface()
	local inZone = luaJM10IsPlayerInSafeZone()
	local near = luaJM10IsUnitNear()

	if not inZone then
		if surface and near then
			Mission.PlayerDetected = true
			if IsUnitUntouchable(Mission.PlayerUnit) then
				RemoveUntouchableUnit(Mission.PlayerUnit)
			end

			luaDelay(luaJM10PlayerDetected, 45)
			luaJM10StartDialog("PlayerSpotted")
			luaObj_Failed("secondary",1)
			MissionNarrative("ijn10.obj_s1_fail")
			HideScoreDisplay(3,0)

			if not Mission.CatSpawn then
				luaJM10SpawnCatalinas()
				Mission.CatSpawn = true
			end

			Mission.AlertLevel = 1
			return
		else
			if Mission.AlertLevel == 1 then
				luaJM10StartDialog("PlayerLost")
			end
			Mission.AlertLevel = 0
		end
	else
		if not IsUnitUntouchable(Mission.PlayerUnit) then
			AddUntouchableUnit(Mission.PlayerUnit)
		end

		Mission.AlertLevel = 0
	end
end

function luaJM10PlayerDetected()
	Mission.PlayerDetected = false
	luaJM10GetAlertLvl()
end

function luaJM10IsPlayerOnSurface()
	--if GetSubmarineDepthLevel(Mission.PlayerUnit) == 0 then
	if GetSubmarineOnSurface(Mission.PlayerUnit) then
		return true
	end
	return false
end

function luaJM10IsPlayerInSafeZone()
	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead then
		return
	end

	for idx,zone in pairs(Mission.SafeZones) do
		if luaIsInArea(zone, GetPosition(Mission.PlayerUnit)) then
			return true
		end
	end
	return false
end

function luaJM10IsUnitNear()
	local ships = luaGetShipsAround(Mission.PlayerUnit, 1500, "enemy")
	if ships then
		return true
	else
		return false
	end
end

function luaJM10Traffic()
	--init
	if not Mission.TrafficInitDone then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PatrolBoats)) do
			NavigatorMoveOnPath(unit, Mission.PatrolPath[idx], PATH_FM_CIRCLE, PATH_SM_JOIN, random(5,10))
			unit.patrolID = Mission.PatrolPath[idx].ID
		end

		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AKPatrols)) do
			NavigatorMoveOnPath(unit, Mission.AKPatrolPath[idx], PATH_FM_SIMPLE, PATH_SM_JOIN)
		end

		Mission.TrafficInitDone = true
	end
	--
	if Mission.AlertLevel > 0 then

		if not Mission.UnitsAttacking then
			local enemies = luaJM10GetNearestPT()
			if next(enemies) ~= nil then
				for idx,unit in pairs(enemies) do
					NavigatorAttackMove(unit, Mission.PlayerUnit, {})
					unit.attacking = true
				end
				Mission.UnitsAttacking = true
			end
		end

	else

		if Mission.UnitsAttacking then
			for idx,unit in pairs(luaRemoveDeadsFromTable(recon[PARTY_ALLIED].own.torpedoboat)) do
				if unit.attacking then
					NavigatorMoveOnPath(unit, thisTable[tostring(unit.patrolID)], PATH_FM_CIRCLE, PATH_SM_JOIN, random(5,10))
					unit.attacking = nil
				end
			end
			Mission.UnitsAttacking = false
		end

	end
end

function luaJM10GetNearestPT()
	local nearest = {}
	local sorted = luaSortByDistance(Mission.PlayerUnit, luaRemoveDeadsFromTable(recon[PARTY_ALLIED].own.torpedoboat))
	for idx,unit in ipairs(sorted) do
		table.insert(nearest, unit)
		if table.getn(nearest) == Mission.MaxAttackingPts then
			return nearest
		end
	end
end

function luaJM10SetAKTarget()
	Mission.AKTarget = luaPickRnd(luaRemoveDeadsFromTable(Mission.AKTargets))
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.AKTarget.ID)
	SetInvincible(Mission.AKTarget, 0.0001)	---hekk by bp, meghalt es szetesett a luaCheckObj teszt needed
	Mission.CamScript = luaCamOnTargetFree(Mission.AKTarget, 15, 1, 250, false, "noupdate", 0, nil)
	if not IsListenerActive("input", "movielistenerID") then
		AddListener("input", "movielistenerID", {
			["callback"] = "luaJM10AKCamEnd",  -- callback fuggveny
			["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
	end

	Mission.AmmoshipName = GetGuiName(Mission.AKTarget)
	SetInvincible(Mission.PlayerUnit, true)
	Mission.Delay = luaDelay(luaJM10AKCam, 1)
	luaJM10StartDialog("Ammoship")
	DisplayUnitHP({Mission.AKTarget}, "ijn10.obj_p3")
end

function luaJM10AKCam()
	Mission.CamScript = luaCamOnTargetFree(Mission.AKTarget, 20, 359, 400, false, "noupdate", 10, luaJM10AKCamEnd)
end

function luaJM10AKCamEnd()
	if IsListenerActive("input", "movielistenerID") then
		RemoveListener("input", "movielistenerID")
	end

	if Mission.CamScript.Dead == false then
		DeleteScript(Mission.CamScript)
	end

	if Mission.Delay.Dead == false then
		DeleteScript(Mission.Delay)
	end

	SetSelectedUnit(Mission.PlayerUnit)
	SetInvincible(Mission.PlayerUnit, false)
	EnableInput(true)
end

function luaJM10CheckObjectives()

	if not luaObj_IsActive("marker2",1) then
		luaObj_Add("marker2",1)
	end

	if not luaObj_IsActive("marker3",1) and Mission.MissionPhase == 1 then
		luaObj_Add("marker3",1)
		luaJM10ADDWayPointMarkerz(1)
	end

	if Mission.UsedPlayerUnits > 2 and (Mission.PlayerUnit.Dead or GetProperty(Mission.PlayerUnit, "TorpedoStock") == 0) and Mission.MissionPhase < 99 then
		--luaLog(Mission.PlayerUnit)
		Mission.FailMsg = "ijn10.obj_missionfailed"
		Mission.MissionFailed = true
		luaJM10StepPhase(99)
	end

	if Mission.MissionPhase == 1 then
		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			--luaJM10DistCounter()
			--luaObj_AddUnit("primary",1,GetPosition(FindEntity("WayPoint6")))
			--luaObj_AddReminder("primary",1)

			--[[if not luaObj_IsActive("secondary",1) then
				luaObj_Add("secondary",1)
				DisplayScores(3,0,"ijn10.obj_s1","")
			end]]

			--luaJM10StartDialog("Init")
			luaDelay(luaJM10AkDlg, 10)
		else
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				if luaIsInArea({GetPosition(FindEntity("PortArea1 01")), GetPosition(FindEntity("PortArea1 02"))}, GetPosition(Mission.PlayerUnit)) then
					luaObj_Completed("primary",1,true)
					luaObj_Completed("secondary",1)
					HideScoreDisplay(1,0)
					HideScoreDisplay(3,0)
					--luaJM10AddPowerup("improved_ship_manoeuvreability")
					luaJM10StepPhase()
					luaJM10RemoveWayPointMarkerz()
					Mission.NoWayPoints = true
					Blackout(true, "luaJM10Checkpoint1", 1)
				else
					--luaObj_Reminder()
					luaJM10DistCounter()
				end
			end
		end
	elseif Mission.MissionPhase == 2 then
		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)

			if Mission.CheckpointLoaded then
				Blackout(false, "", 1)
			end

			for i,v in pairs(luaRemoveDeadsFromTable(Mission.AKTargets)) do
				--local coord = GetPosition(v)
				luaObj_AddUnit("primary",2,v)
			end

			--luaObj_AddReminder("primary",2)
			Mission.MaxShips = table.getn(luaRemoveDeadsFromTable(Mission.AKTargets))
			luaJM10IdentifyHint()
			luaJM10AKIngame()
			luaDelay(luaJM10HarborDlg, 15)
		else
			if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil and Mission.AllAKsReconned and not Mission.DelayInProgress then
				luaObj_Completed("primary",2,true)
				luaJM10StartDialog("Ships_reconned")
				--luaJM10AddPowerup("hardened_armour")
				HideScoreDisplay(2,0)
				luaJM10SetAKTarget()
				--luaJM10RemoveMarker()
				luaJM10StepPhase()
			else
				--luaObj_Reminder()
				luaJM10ReconCounter()
			end
		end
	elseif Mission.MissionPhase == 3 then
		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3,Mission.AKTarget)
			--luaObj_AddReminder("primary",3)
			luaJM10AmmoHint()
		else
			if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil and (Mission.AKTarget.Dead or GetHpPercentage(Mission.AKTarget) < 0.001) then
				HideUnitHP()
				luaObj_Completed("primary",3)
				luaJM10EndCam()
				--Mission.MissionCompleted = true
				--luaJM10StepPhase(99)
			--else
				--luaObj_Reminder()
			end
		end
	elseif Mission.MissionPhase == 99 then
		if Mission.MissionFailed then
			lastbanto = Mission.PlayerUnit.LastBanto
			if not lastbanto or lastbanto.Dead then
				lastbanto = nil
			end
			luaMissionFailedNew(lastbanto, Mission.FailMsg, nil, true)
			luaJM10StepPhase()
			Mission.EndMission = true
		elseif Mission.MissionCompleted then
			luaMissionCompletedNew(nil, "ijn10.obj_missioncompleted", nil)

			local medal = luaGetMedalReward()
			if medal == MEDAL_GOLD then
				Scoring_GrantBonus("JM10_SCORING_GOLD", "ijn10.bonus1_title", "ijn10.bonus1_text", 8)
			end

			luaJM10StepPhase()
			Mission.EndMission = true
		end
	end
end

function luaJM10Checkpoint1()
	--luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM10StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM10ReconUnit()
	--local unit = GetFireTarget(Mission.PlayerUnit)
	local unit = GetTargetInfoTarget()
	if Mission.ReconInProgress then
		if not unit or unit.Dead then
			Mission.ReconInProgress = false
		else
			return
		end
	end

	if unit and not unit.Dead and not unit.reconned then
		if luaIsInside(unit, Mission.AKTargets) and luaGetDistance(Mission.PlayerUnit, unit) < 800 then
			luaDelay(luaJM10SetReconned, 5, "unit", unit)
			Mission.ReconInProgress = true
			Mission.DelayInProgress = true
		end
	end
end

function luaJM10SetReconned(timerthis)
	local unit = timerthis.ParamTable.unit
	local guiUnitName
	if unit and not unit.Dead and not unit.reconned then


		--[[if unit.Name == "US Cargo Transport 01" then
			guiUnitName = "USS Torrance"
		elseif unit.Name == "US Cargo Transport 02" then
			guiUnitName = "USS Washburn"
		elseif unit.Name == "US Cargo Transport 03" then
			guiUnitName = "USS Starr"
		elseif unit.Name == "US Cargo Transport 04" then
			guiUnitName = "USS Union"
		elseif unit.Name == "US Cargo Transport 05" then
			guiUnitName = "USS Sylvania"
		end]]--

		Mission.GuiName = GetGuiName(unit)
		MissionNarrativeUrgent("ijn10.reconned")
		luaObj_RemoveUnit("primary",2,unit)
		--MissionNarrativeEnqueue(guiUnitName.." is reconned")

		if unit.ID == Mission.Hospitalship.ID then
			luaJM10StartDialog("Hospital")
		elseif unit.ID == Mission.Tanker1.ID or unit.ID == Mission.Tanker2.ID then
			luaJM10StartDialog("Tanker")
		else
			if not Mission.Civildlg then
				luaJM10StartDialog("Civilcargo")
				Mission.Civildlg = true
			end
		end

-- RELEASE_LOGOFF  		luaLog(unit.Name.." added to marker obj")
		--luaObj_AddUnit("marker2",1,unit)
		unit.reconned = true
		Mission.Reconable = Mission.Reconable - 1
	end
	Mission.DelayInProgress = false
	Mission.ReconInProgress = false

	for idx,ak in pairs(luaRemoveDeadsFromTable(Mission.AKTargets)) do
		if not ak.reconned then
			return
		end
	end
	Mission.AllAKsReconned = true
end

function luaJM10RemoveMarker()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AKTargets)) do
		if not unit.Dead and unit.reconned and unit.ID ~= Mission.AKTarget.ID then
			luaObj_RemoveUnit("marker2", 1, unit)
		end
	end
end

function luaJM10GenerateDDConvoy()
-- RELEASE_LOGOFF  	luaLog("luaJM10GenerateDDConvoy called")

	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET
	---EZT MAJD LECSERELNI EGY GECINAGY GENERATEOBJECTRE, EDITORBAN MEG LERAKNI A TEMPLATEKET

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 23,
			["Name"] = "USS Walke",
			["Crew"] = 2,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "USS Farragut",
			["Crew"] = 2,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(FindEntity("DDSpawnPoint")),
		--["angleRange"] = { -1, 1 },
		["angleRange"] = { luaJM10RAD(180), luaJM10RAD(270)},
		["lookAt"] = GetPosition(FindEntity("MiniSubSpawnPoint")), -- only for position vector refPos
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 30,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 250,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 30,
	},
	["callback"] = "luaJM10FleetSpawned",
	})
end

function luaJM10FleetSpawned(dest1,dest2)
	--JoinFormation(dest2, dest1)
	SetGuiName(dest1, "ingame.shipnames_walke")
	SetNumbering(dest1, 723)
	SetGuiName(dest2, "ingame.shipnames_farragut")
	SetNumbering(dest2, 300)
	table.insert(Mission.USNDDs, dest1)
	table.insert(Mission.USNDDs, dest2)
	--NavigatorMoveOnPath(dest1, FindEntity("AKMovingInPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, random(8,10))
	if not Mission.FleetSpawned then
		Mission.FleetSpawned = true
		luaDelay(luaJM10DelayedFormationHack, 1)
	end
	--Pause(true)
end

function luaJM10DelayedFormationHack()
	Mission.USNDDs = luaRemoveDeadsFromTable(Mission.USNDDs)
	DisbandFormation(Mission.USNDDs[1])

	NavigatorMoveOnPath(Mission.USNDDs[1], FindEntity("AKMovingInPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, random(8,10))
	NavigatorMoveOnPath(Mission.USNDDs[2], FindEntity("AKMovingInPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, random(8,10))


end

function luaJM10CheckPlayer()
	if Mission.NoThink or Mission.UsedPlayerUnits > 2 then
		return
	end

	local torp

	if Mission.PlayerUnit.Dead then
		--enginemovie?
		luaJM10StartDialog("Player_died")
		if not SpawnNewIDIsRequested(Mission.PlayerSpawnReq) then
			Mission.NoThink = true
			luaJM10SpawnPlayerUnit()
		end
	else
		if not Mission.EasterDlg then
			if luaIsInArea({GetPosition(FindEntity("Egg1")), GetPosition(FindEntity("Egg2"))}, GetPosition(Mission.PlayerUnit)) then
				luaJM10StartDialog("EasterEgg")
				SetAchievements("SA_UH")
				Mission.EasterDlg = true
			end
		end

		if GetProperty(Mission.PlayerUnit, "TorpedoStock") == 0 then
			torp = GetShipTorpedoes(Mission.PlayerUnit)

			--if torp and table.getn(torp) == 0 then
				luaDelay(luaJM10IsObjDead, 3)
			--end
			--Mission.Delay = luaDelay(luaJM10IsObjDead, 70)
			Mission.NoThink = true
		end
	end

end

function luaJM10IsObjDead()
	if Mission.AKTarget and Mission.AKTarget.Dead then
		Mission.NoThink = false
	else
		if not SpawnNewIDIsRequested(Mission.PlayerSpawnReq) then
			MissionNarrative("ijn10.nomoretorp")
			luaJM10SpawnPlayerUnit()
		end
	end
end

function luaJM10SpawnPlayerUnit()
	--luaJM10Blackout(1)
-- RELEASE_LOGOFF  	luaLog("hivta: "..debug.traceback())
-- RELEASE_LOGOFF  	luaLog("Lookat")
-- RELEASE_LOGOFF  	luaLog(Mission.LookAt)
	local pos
	local lookAt

	if Mission.MissionPhase == 1 then
		pos = Mission.CheckPoint
		lookAt = Mission.LookAt
	else
		pos = Mission.LookAt
		lookAt = GetPosition(luaRemoveDeadsFromTable(Mission.AKTargets)[1])
	end

	pos.y = -15
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 83,
			["Name"] = "Minisub Type A",
			["Crew"] = 1,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = pos,
		["angleRange"] = { luaJM10RAD(180), luaJM10RAD(0)},
		["lookAt"] = lookAt, -- only for position vector refPos
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM10PlayerSpawned",
	})
end

function luaJM10PlayerSpawned(unit)
	--luaJM10Blackout(1)
	--luaDelay(luaJM10fadeIn, 2)
	local prevUnit = Mission.PlayerUnit
	Mission.PlayerUnit = unit
	Mission.NoThink = false
	Mission.UsedPlayerUnits = Mission.UsedPlayerUnits + 1
	SetSelectedUnit(Mission.PlayerUnit)

	SetUnlimitedAirSupply(Mission.PlayerUnit, true)

	if Mission.Difficulty == 2 then
		ShipSetTorpedoStock(Mission.PlayerUnit, 4)
	else
		ShipSetTorpedoStock(Mission.PlayerUnit, 8)
	end

	luaDelay(luaJM10RemoveUnlimitedAir, 60, "unitID", Mission.PlayerUnit.ID)

	if Mission.UsedPlayerUnits == 2 then
		SetGuiName(Mission.PlayerUnit, "ingame.shipnames_m|.24")
	elseif Mission.UsedPlayerUnits == 3 then
		SetGuiName(Mission.PlayerUnit, "ingame.shipnames_m|.21")
	end

	if prevUnit and not prevUnit.Dead then
		SetRoleAvailable(prevUnit, EROLF_ALL, PLAYER_AI)
		NavigatorMoveOnPath(prevUnit, FindEntity("AKMovingOutPath"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	end

	--luaJM10ADDWayPointMarkerz(1)
	Mission.NoWayPoints = false
end

function luaJM10Blackout(time)
	if time then
		Blackout(true,"",time)
	else
		Blackout(true,"",true)
	end
end

function luaJM10fadeIn()
	Blackout(false, "", 1.5)
	luaDelay(luaJM10WayPointHint, 5)
end

function luaJM10RAD(x)
	return x *  0.0174532925
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(23)
	PrepareClass(83)
	PrepareClass(96)
	PrepareClass(125)
	Loading_Finish()
end

function luaJM10StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM10StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM10StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM10AkDlg()
	luaJM10StartDialog("AK_Entrance")
	--[[if not luaObj_IsActive("secondary",1) then
				luaObj_Add("secondary",1)
				DisplayScores(3,0,"ijn10.obj_s1","")
	end]]

end

function luaJM10AddSec()
	if not luaObj_IsActive("secondary",1) then
		luaObj_Add("secondary",1)
		DisplayScores(3,0,"ijn10.obj_s1","")
	end
end

function luaJM10AddPowerup(type)
-- RELEASE_LOGOFF  	luaLog("powerup granted "..tostring(type))
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrativeEnqueue("missionglobals.newpowerup")
end

function luaJM10Hidden()
	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	else
		if not Mission.PlayerUnit.Dead then
			local dist = luaGetDistance(Mission.PlayerUnit, Mission.Mavis)
			if luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil and (dist < 200) then
				luaJM10StartDialog("hiddencomp")
				luaObj_Completed("hidden",1)
				if not Mission.PowerUpAdded then
					luaJM10AddPowerup("radar_sweep")
					luaJM10AddPowerup("improved_ship_manoeuvreability")
					Mission.PowerUpAdded = true
				end

			end
		end
	end
end

function luaJM10SetGuiNames()
-- RELEASE_LOGOFF  	luaLog("allitom a guineveket")

	for idx, unit in pairs(Mission.IJNSubs) do
		SetGuiName(unit, Mission.IJNSubNames[idx])
	end

	for idx, unit in pairs(Mission.PatrolBoats) do
		SetGuiName(unit, Mission.PtNames[idx])
	end

	for idx, unit in pairs(Mission.AKPatrols) do
		SetGuiName(unit, Mission.AKPatrolNames[idx])
	end

	for idx, unit in pairs(Mission.AKTargets) do
		SetGuiName(unit, Mission.AKTargetNames[idx])
	end
end

function luaJM10MarkWaterMines()
	if Mission.PlayerUnit.Dead then
		return
	end

	local mineTbl = luaSortByDistance2(Mission.PlayerUnit, Mission.WaterMinesPos)

	for idx,mine in pairs(Mission.WaterMinesPos) do
		if Mission.WaterMines[idx].marked then
-- RELEASE_LOGOFF  			luaLog(mine)
			luaObj_RemoveUnit("marker3",1,mine)
			Mission.WaterMines[idx].marked = false
		end
	end
	if mineTbl and next(mineTbl) ~= nil then
		for idx,mine in pairs(mineTbl) do
			if not Mission.WaterMines[idx].marked and luaGetDistance(Mission.PlayerUnit, mine) <= 350 then
				luaObj_AddUnit("marker3",1,mine)
				Mission.WaterMines[idx].marked = true
				if not Mission.MineHint then
					luaJM10MineHint()
					Mission.MineHint = true
				end
			end
		end
	end
end

function luaJM10CheckCivilTraffic()
	if Mission.PlayerUnit.Dead then
		return
	end

	for idx,unit in pairs(Mission.CivilBoats) do
		if not unit.Dead and not unit.onMove and luaGetDistance(Mission.PlayerUnit,unit) < 1000 then
			NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN)
			unit.onMove = true
		end
	end
end

function luaJM10RemoveUnlimitedAir(timerThis)
	local unitID = timerThis.ParamTable.unitID
	local unit = thisTable[tostring(unitID)]

	if not unit or unit.Dead then
		return
	end

	SetUnlimitedAirSupply(unit, false)
end

function luaJM10SpawnCatalinas()
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 125,
				["Name"] = "PBY Catalina",
				["Crew"] = 1,
				["Race"] = USA,
				["WingCount"] = 1,
				["Equipment"] = 2,
			},
			{
				["Type"] = 125,
				["Name"] = "PBY Catalina",
				["Crew"] = 1,
				["Race"] = USA,
				["WingCount"] = 1,
				["Equipment"] = 2,
			},
			{
				["Type"] = 125,
				["Name"] = "PBY Catalina",
				["Crew"] = 1,
				["Race"] = USA,
				["WingCount"] = 1,
				["Equipment"] = 2,
			},
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		["area"] = {
			["refPos"] = GetPosition(FindEntity("CatalinaSpawnPoint")),
			--["angleRange"] = { -1, 1 },
			["angleRange"] = { luaJM10RAD(180), luaJM10RAD(270)},
			["lookAt"] = GetPosition(FindEntity("WayPoint6"))
		},
		["callback"] = "luaJM10CatsSpawned",
		["id"] = "CatSpawn",
	})
end

function luaJM10CatsSpawned(...)
	for idx,unit in ipairs(arg) do
		if Mission.Difficulty == 2 then
			SetSkillLevel(unit, SKILL_SPVETERAN)
		else
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end

		table.insert(Mission.Cats, unit)
	end
end

function luaJM10CheckCatalinas()
	Mission.Cats = luaRemoveDeadsFromTable(Mission.Cats)
	if table.getn(Mission.Cats) == 0 or Mission.PlayerUnit.Dead then
		return
	end

	if Mission.AlertLevel == 1 then

		if Mission.AttackingCat and not Mission.AttackingCat.Dead then
-- RELEASE_LOGOFF  			luaLog("Catalina attacking")
			local eq = GetProperty(Mission.AttackingCat, "ammoType")

			if eq == 0 then
				Mission.AttackingCat = nil
				return
			else
				if luaGetScriptTarget(Mission.AttackingCat) and luaGetScriptTarget(Mission.AttackingCat).Dead then
					PilotSetTarget(Mission.AttackingCat, Mission.PlayerUnit)
					luaSetScriptTarget(Mission.AttackingCat, Mission.PlayerUnit)
				end
			end

		else

			if table.getn(Mission.Cats) > 0 then
				local idx,unit = luaPickRnd(Mission.Cats,true)
				table.remove(Mission.Cats, idx)
				Mission.AttackingCat = unit
				PilotSetTarget(Mission.AttackingCat, Mission.PlayerUnit)
				luaSetScriptTarget(Mission.AttackingCat, Mission.PlayerUnit)
			end

		end
	end
end

function luaJM10IsHintActive(hintID)
	local hintTbl = IsHintActive()
	if hintTbl == nil then
		return false
	else
		for idx,hint in pairs(hintTbl) do
			if string.find(hintTbl.HintID,"IJN10") or IsHintCritical(hintTbl.HintID) then
				return true
			end
		end
		return false
	end
	return true
end

function luaJM10IsDlgRunning()
	if next(GetActDialogIDs()) == nil then
		return false
	else
		return true
	end
end

function luaJM10RndHint()

	if table.getn(Mission.RndHints) == 0 or Mission.NoThink or Mission.PlayerUnit.Dead then
		return
	end

	local time2Display = math.floor(GameTime()) - Mission.LastHintDisplayed
	local dlgActive = luaJM10IsDlgRunning()
	local hintActive = luaJM10IsHintActive()

	if time2Display > Mission.HintDisplayInterval and not dlgActive and not hintActive then
		local tablekey,hintfunction = luaPickRnd(Mission.RndHints,true)
		hintfunction()
		table.remove(Mission.RndHints, tablekey)
	end

end

function luaJM10MsubHint()
	ShowHint("IJN10_Hint01")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10TorpHint()
	ShowHint("IJN10_Hint02")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10MineHint()
	ShowHint("IJN10_Hint03")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10IdentifyHint()
	ShowHint("IJN10_Hint04")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10AmmoHint()
	ShowHint("IJN10_Hint05")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10SafeHint()
	ShowHint("IJN10_Hint06")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10SneakHint()
	ShowHint("IJN10_Hint07")
	Mission.LastHintDisplayed = math.floor(GameTime())
end

function luaJM10SubsleftHint()
	ShowHint("IJN10_Hint08")
end

function luaJM10WayPointHint()
	ShowHint("IJN10_Hint09")
end

function luaJM10CheckWayPoints()

	if Mission.NoWayPoints or Mission.PlayerUnit.Dead then
		return
	end

	if Mission.UsedPlayerUnits > 1 then
		local inPort = luaIsInArea({GetPosition(FindEntity("PortArea1 01")), GetPosition(FindEntity("PortArea1 02"))}, GetPosition(Mission.PlayerUnit))
		if inPort then
			luaJM10RemoveWayPointMarkerz()
			Mission.NoWayPoints = true
		end
	end

	for idx,pointTbl in pairs(Mission.WayPoints) do

		if pointTbl.marked then
			Mission.PointName = Mission.WayPointNames[idx]
			Mission.Distance = luaGetDistance3D(Mission.PlayerUnit, pointTbl.coord)
			if Mission.Distance < 200 then
				Mission.CheckPoint = pointTbl.coord
				local x, y = next(Mission.WayPoints,idx)
				if y then
					Mission.LookAt = y.coord
				else
					Mission.LookAt = GetPosition(FindEntity("WayPoint6"))
				end

				luaJM10RemoveWayPointMarkerz()

				if idx <=2 and not Mission.MineHint then
					luaJM10MineHint()
					luaJM10StartDialog("Mine_reconned")
					Mission.MineHint = true
				end

				if idx <= (table.getn(Mission.WayPoints)-1) then
					luaJM10ADDWayPointMarkerz(idx+1)
				end
			end

		end
	end

end

function luaJM10RemoveWayPointMarkerz()
	for idx,pointTbl in pairs(Mission.WayPoints) do
		if pointTbl.marked then
			luaObj_RemoveUnit("marker3",1,pointTbl.coord)
			Mission.WayPoints[idx].marked = false
		end
	end
end

function luaJM10ADDWayPointMarkerz(idx)
	--[[
	for idx,pointTbl in pairs(Mission.WayPoints) do
		if not pointTbl.marked then
			luaObj_AddUnit("marker3",1,pointTbl.coord)
			Mission.WayPoints[idx].marked = true
		end
	end
	]]
	luaObj_AddUnit("marker3",1,Mission.WayPoints[idx].coord)
	Mission.WayPoints[idx].marked = true
end

function luaJM10HarborDlg()
	luaJM10StartDialog("Inharbour")
end

function luaJM10Metric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end

end

function luaJM10DistCounter()
	local dist = luaJM10Metric(Mission.Distance)
	Mission.Measure = GetMeasure()
	Mission.MetricDistance = string.format("%.1f",dist)
	DisplayScores(1,0,"ijn10.obj_p1","ijn10.distance")
end

function luaJM10ReconCounter()
	DisplayScores(2,0,"ijn10.obj_p2","ijn10.reconable")
end

function luaJM10Init()
	Mission.Init = true
end

function luaJM10EndCam()
	Mission.CamScript = luaCamOnTargetFree(Mission.AKTarget, 15, 1, 250, false, "noupdate", 0, nil)

	if Mission.AKTarget and not Mission.AKTarget.Dead then
		SetDeadMeat(Mission.AKTarget)
	end

	Mission.Delay = luaDelay(luaJM10AKEndCam, 1)
end

function luaJM10AKEndCam()
	Mission.CamScript = luaCamOnTargetFree(Mission.AKTarget, 20, 359, 400, false, "noupdate", 10, luaJM10Final)
end

function luaJM10Final()
	Mission.MissionCompleted = true
	luaJM10StepPhase(99)
end

function luaJM10AKIngame()
	Mission.MovieInProgress = true

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, true)
	end

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 259, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 10, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[2], ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[2], ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[3], ["distance"] = 200, ["theta"] = 15, ["rho"] = 20, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[3], ["distance"] = 200, ["theta"] = 15, ["rho"] = 300, ["moveTime"] = 5},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[4], ["distance"] = 500, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.AKTargets[4], ["distance"] = 200, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 5},
		},	luaJM10MovieEnd)

	luaDelay(luaJM10SubtitleChecker, 1)
end

function luaJM10MovieEnd()
	Mission.MovieInProgress = false

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end

	EnableInput(true)
end

function luaJM10SubtitleChecker()
	if Mission.MovieInProgress then
		local unit = luaGetCamTargetEnt()
		if unit and not unit.Dead and not unit.NameWritten then
			MissionNarrativeUrgent(GetGuiName(unit))
			unit.NameWritten = true
		end

	luaDelay(luaJM10SubtitleChecker, 1)
	end
end


function luaJM10CivilTraffic()
	if not Mission.GotoCopied then
		Mission.Goto = copy_table(Mission.Ports)
		Mission.GotoCopied = true
	end

	if Mission.Goto and table.getn(Mission.Goto) ~= 0 then

		local cType = Mission.CivilTrafficID[random(1,table.getn(Mission.CivilTrafficID))]
		local key, sPoint = luaPickRnd(Mission.Goto,true)
-- RELEASE_LOGOFF  		luaLog(tostring(key)..". port picked")


		SpawnNew({
			["party"] = PARTY_NEUTRAL,
			["groupMembers"] = {
				{
					["Type"] = cType,
					["Name"] = "Civilian vessel",
					["Crew"] = 1,
					["Race"] = AUSTRALIAN,
				},
			},
			["area"] = {
				["refPos"] = GetPosition(sPoint),
				--["angleRange"] = { -1, 1 },
				["angleRange"] = { luaJM10RAD(180), luaJM10RAD(270)},
				["lookAt"] = GetPosition(FindEntity("WayPoint6")), -- only for position vector refPos
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 25,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 45,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM10CivilTrafficCB",
		})

		table.remove(Mission.Goto, key)
	else
			luaJM10MoveCivilTraffic()
	end


end

function luaJM10CivilTrafficCB(unit)
-- RELEASE_LOGOFF  	luaLog("spawned civil traffic")
	table.insert(Mission.CivilTraffic, unit)
end

function luaJM10MoveCivilTraffic()
-- RELEASE_LOGOFF  	luaLog("civilian cruisin")
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CivilTraffic)) do
		if GetProperty(unit, "unitcommand") == "stop" then
			local goto = Mission.Ports[random(1,table.getn(Mission.Ports))]
			NavigatorMoveToRange(unit, GetPosition(goto))
-- RELEASE_LOGOFF  			luaLog(unit.Name.."megy ide: "..goto.Name)
		end
	end
end

function luaJM10SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	Mission.Checkpoint.UsedPlayerUnits = Mission.UsedPlayerUnits
	Mission.Checkpoint.PlayerUnit = Mission.PlayerUnit.Name
	Mission.Checkpoint.PlayerCoord = GetPosition(Mission.PlayerUnit)
	Mission.Checkpoint.Depthlevel = GetSubmarineDepthLevel(Mission.PlayerUnit)
	Mission.Checkpoint.Air = GetSubmarineAirSupply(Mission.PlayerUnit)
	--Mission.Checkpoint.TrafficInitDone = Mission.TrafficInitDone
	Mission.Checkpoint.Init = Mission.Init
end

function luaJM10LoadBlackout()
	Blackout(true, "", 0)
	Mission.CheckPoint = Mission.LookAt
	luaJM10LoadMissionData()
end

function luaJM10LoadMissionData()

	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	MissionNarrativeClear()

	Mission.Init = Mission.Checkpoint.Init
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	--Mission.TrafficInitDone = Mission.Checkpoint.TrafficInitDone
	Mission.UsedPlayerUnits = Mission.Checkpoint.UsedPlayerUnits
	luaDelay(luaJM10Restore, 1)

	luaDelay(luaJM10SetActionMusic,1)
end

function luaJM10Restore()
	luaJM10RestoreUnits(num, PARTY_JAPANESE)
	luaJM10RestoreUnits(num, PARTY_ALLIED)
end

function luaJM10SetActionMusic()
	Music_Control_SetLevel(MUSIC_ACTION)
end

function luaJM10RestoreUnits(chkPointNum, party)

	local uParty
	local navPoint
	local lookAt

	if party == PARTY_ALLIED then
		uParty = "USUnits"
		--navPoint = Mission.Checkpoint.Navpoints[1]
		--lookAt = GetPosition(Mission.PlayerUnit)
	elseif party == PARTY_JAPANESE then
		uParty = "JapUnits"
		--navPoint = Mission.Checkpoint.Navpoints[2]
		--lookAt = GetPosition(Mission.DeRuyter)
	end

	local units = luaGetCheckpointData("Units", uParty)
	local wtf = luaGetOwnUnits(nil, party)

	local leader
	for idx,unit in pairs(wtf) do
		local found = false
		for idx2,unitTbl in pairs(units[1]) do
			if unit.Name == unitTbl[1] then
				--luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					--ShipSetTorpedoStock(unit, unitTbl[4])
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


	luaDelay(luaJM10ArrabbBaszo, 1)


end

function luaJM10ArrabbBaszo()
	for i,v in pairs(Mission.Checkpoint.Units.USUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end

	local sub = FindEntity(Mission.Checkpoint.PlayerUnit)

	if sub and not sub.Dead then
		PutTo(sub, Mission.LookAt, 135)
		SetSubmarineDepthLevel(sub, Mission.Checkpoint.Depthlevel)
		SetSubmarineAirSupply(sub, Mission.Checkpoint.Air)
		NavigatorStop(sub)
		--return
	end

end

function luaJM10CheckDeadAK()
	for i, unit in pairs(Mission.AKTargets) do
		if unit.Dead and not unit.reconned then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn10.obj_missionfailed_2"
			luaJM10StepPhase(99)
		end
	end
end
