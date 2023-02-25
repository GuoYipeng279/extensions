--SceneFile="universe\Scenes\missions\IJN\ijn_08_defend_guadalcanal.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",8)

	Dialogues =
	{
		["Intro_A"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01b_1",
				},
			},
		},

		["Intro_B"] = {
			["sequence"] = {
				{
					["message"] = "idlg01c",
				},
			},
		},
	}

	MissionNarrative("ijn08.date_location")
	luaDelay(luaEngineInit1, 4, "")

end

function luaEngineInit1()
	StartDialog("Intro_dlg1", Dialogues["Intro_A"] );
	luaDelay(luaEngineInit2, 15, "")
end

function luaEngineInit2()
	StartDialog("Intro_dlg2", Dialogues["Intro_B"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM8")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM8(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM08.lua"

	this.Name = "JM8"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	--lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	--enginemovies
	--luaInitJumpinMovies()

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_STUN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_SPVETERAN
	end

	--Mission.ObjRemindTime = 150

	--reload
	SetDeviceReloadEnabled(true)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM8SpawnIJNInvasionFleet, luaJM8LoadMissionData, luaJM8Pri1Score},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM8SaveMissionData},
	}

	Mission.PatrolSpawned = 0

	--SetGuiName(FindEntity("H6K Mavis 01"), "H6K Mavis")
	--SetGuiName(FindEntity("H6K Mavis 02"), "H6K Mavis")
	--SetGuiName(FindEntity("H6K Mavis 03"), "H6K Mavis")

	--Mission.Mavises = {}
	--table.insert(Mission.Mavises, FindEntity("H6K Mavis 01"))
	--table.insert(Mission.Mavises, FindEntity("H6K Mavis 02"))
	--table.insert(Mission.Mavises, FindEntity("H6K Mavis 03"))

	Mission.Buffalos = {}
	table.insert(Mission.Buffalos, FindEntity("F2A Buffalo 01"))
	table.insert(Mission.Buffalos, FindEntity("F2A Buffalo 02"))
	--SetGuiName(Mission.Buffalos[1], "F2A Buffalo")
	--SetGuiName(Mission.Buffalos[2], "F2A Buffalo")

	Mission.USNLandingPoint1 = FindEntity("USNLandingNavpoint 01")
	Mission.USNLandingPoint2 = FindEntity("USNLandingNavpoint 02")
	Mission.USNRetreatPoint = FindEntity("RetreatPoint")

	Mission.USNFleet = {}
		table.insert(Mission.USNFleet, FindEntity("Northampton-class 01"))
		table.insert(Mission.USNFleet, FindEntity("Landing Ship, Tank 01"))
		table.insert(Mission.USNFleet, FindEntity("Landing Ship, Tank 02"))
		table.insert(Mission.USNFleet, FindEntity("USTroopTransport 01"))
		table.insert(Mission.USNFleet, FindEntity("USTroopTransport 02"))
		table.insert(Mission.USNFleet, FindEntity("Fletcher-class 01"))
		JoinFormation(Mission.USNFleet[table.getn(Mission.USNFleet)], Mission.USNFleet[1])
		table.insert(Mission.USNFleet, FindEntity("Fletcher-class 02"))
		JoinFormation(Mission.USNFleet[table.getn(Mission.USNFleet)], Mission.USNFleet[1])
		NavigatorMoveOnPath(Mission.USNFleet[1], FindEntity("PatrolPath"), PATH_FM_PINGPONG, PATH_SM_JOIN)

	Mission.USNFleetNames = {}
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_san_francisco", 38}) --ca38
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_lst|.741", 741})
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_lst|.757", 757})
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_capricornus", 000})
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_ogglethorpe", 000})
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_aaron_ward", 483})--dd483
		table.insert(Mission.USNFleetNames, {"ingame.shipnames_obannon", 450})--dd450

	Mission.USNLsts = {}
		table.insert(Mission.USNLsts, FindEntity("Landing Ship, Tank 01"))
		table.insert(Mission.USNLsts, FindEntity("Landing Ship, Tank 02"))

		NavigatorMoveToRange(Mission.USNLsts[1], Mission.USNLandingPoint1)
		Mission.USNLsts[1].LandingPoint = Mission.USNLandingPoint1

		NavigatorMoveToRange(Mission.USNLsts[2], Mission.USNLandingPoint2)
		Mission.USNLsts[2].LandingPoint = Mission.USNLandingPoint2

	Mission.LandingSpawnTime = 60
	Mission.USLandingStarted = false
	Mission.USNCargos = {}
		table.insert(Mission.USNCargos, FindEntity("USTroopTransport 01"))
		table.insert(Mission.USNCargos, FindEntity("USTroopTransport 02"))
		SetSkillLevel(Mission.USNCargos[1], SKILL_STUN)
		SetSkillLevel(Mission.USNCargos[2], SKILL_STUN)

		NavigatorMoveToRange(Mission.USNCargos[1], Mission.USNLandingPoint1)
		Mission.USNCargos[1].LandingPoint = Mission.USNLandingPoint1

		NavigatorMoveToRange(Mission.USNCargos[2], Mission.USNLandingPoint2)
		Mission.USNCargos[2].LandingPoint = Mission.USNLandingPoint2

	Mission.USNPts = {}
		table.insert(Mission.USNPts, FindEntity("PT Boat 80' Elco 02"))
		table.insert(Mission.USNPts, FindEntity("PT Boat 80' Elco 01"))


	Mission.USNPtNames = {}
		table.insert(Mission.USNPtNames, "ingame.shipnames_pt|.432")
		table.insert(Mission.USNPtNames, "ingame.shipnames_pt|.223")

	luaJM8SetDifficulty(luaSumTablesIndex(Mission.USNFleet,Mission.USNLsts,Mission.USNPts))

	Mission.CommandBuilding = FindEntity("Headquarter 01")
	RepairEnable(Mission.CommandBuilding, false)

	Mission.Airfield = FindEntity("MainAirFieldEntity 01")
	SetRoleAvailable(Mission.Airfield, EROLF_ALL, PLAYER_AI)
	SetSkillLevel(Mission.Airfield, SKILL_SPVETERAN)
	--Mission.AirfieldPos = GetPosition(Mission.Airfield)

	Mission.AirPatrolSpawnReq = "AirPatrolSpawnReq"
	Mission.AirPatrol = {}
	Mission.MaxAlliedPlaneSquads = 2

	Mission.Shipyard1 = FindEntity("Shipyard 01")
	Mission.PTsSpawned = 0
	Mission.MavisSpawned = 0
	Mission.SpawnTo = FindEntity("SpawnTo")
	--Mission.Shipyard2 = FindEntity("Shipyard 02")
	SetRoleAvailable(Mission.Shipyard1, EROLF_ALL, PLAYER_AI)
	--SetRoleAvailable(Mission.Shipyard2, EROLF_ALL, PLAYER_AI)

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	this.MissionPhase = 1

	Mission.ScoreDisplay = {}

	--OBJECTIVES
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "landing",
				["Text"] = "ijn08.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "landingships",
				["Text"] = "ijn08.obj_p2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "bombing",
				["Text"] = "ijn08.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "retreat",
				["Text"] = "ijn08.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "LSTKill",
				["Text"] = "ijn08.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		}
	}

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()

	this.Dialogues = {
		["Intro2"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM8SMHint",
				},
			},
		},
		["TransportsDestroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["SecObjAdded"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM8RocketHint",
				},
			},
		},
		["SecObjComplete"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["SecObjFailed"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["IncomPlanes"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["AirfieldHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["ShipyardHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
			},
		},
		["AirfieldDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg9",
				},
			},
		},
		["ShipyardDisabled"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["AirfieldReinstated"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["ShipyardReinstated"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
	}
	LoadMessageMap("ijndlg",8)

	SetThink(this, "luaJM8_think")

	SetSelectedUnit(Mission.CommandBuilding)

	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)

	luaJM8AddGenerateListener()

	luaJM8FadeIn()

	luaJM8SetGuiNames()

	Mission.ThinkNum = 0

	--watch
-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
end

function luaJM8_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.ThinkNum < 2 then		-- Mission - FirstSeconds fakez
		Mission.ThinkNum = Mission.ThinkNum + 1
		return
	end

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	luaJM8DisableDlgTrigger()
	luaJM8CheckObjectives()

	if Mission.MissionPhase == 1 then

	elseif Mission.MissionPhase == 2 then
		luaJM8CheckAirPatrol()
	end

	luaJM8CheckBuffalos()
	luaJM8CheckPlayerPTs()
	luaJM8CheckUSNFleet()
	luaJM8CheckUSNPts()
end

function luaJM8CheckObjectives()

	--secondary
	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		luaJM8CheckSecObj()
		if Mission.SecFailed then
			luaObj_Failed("secondary",1)
			luaJM8RemoveScore(4)
			luaJM8StartDialog("SecObjFailed")
		elseif Mission.SecCompleted then
			luaObj_Completed("secondary",1)
			luaJM8StartDialog("SecObjComplete")
			luaJM8AddPowerup("fearless_defense")
		--	luaJM8RemoveScore(4)
		--else
		--	luaJM8Sec1Score()
		end
	end

	if Mission.CommandBuilding.Party ~= PARTY_JAPANESE and not Mission.MissionFailed then
		if Mission.MissionPhase < 2 then
			Mission.FailMsg = "ijn08.obj_missionfailed1"
		else
			Mission.FailMsg = "ijn08.obj_missionfailed3"
		end
		Mission.MissionFailed = true
		luaJM8StepPhase(99)
	end

	if Mission.MissionPhase == 1 then

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			luaJM8StartDialog("Intro2")
			--luaLog("hmm")
			luaJM8Pri1Score()
			luaDelay(luaJM8CBHint,30)
		end

		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		end

		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			for idx,unit in pairs(Mission.USNLsts) do
				luaObj_AddUnit("primary",2,unit)
			end
			for idx,unit in pairs(Mission.USNCargos) do
				luaObj_AddUnit("primary",2,unit)
			end
			luaJM8Pri2Score()
			--luaJumpinMovieSetCurrentMovie("GoAround", Mission.USNCargos[1].ID)
			luaDelay(luaJM8CargoMovie,30)
			luaObj_AddReminder("primary",2)
		else
			if luaObj_GetSuccess("primary",2) == nil then
				if table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) == 0 then
					luaObj_Completed("primary",2,true)
					luaJM8StartDialog("TransportsDestroyed")
					--luaJM8AddPowerup("torpedo1")
					luaJM8StepPhase()
					luaJM8RemoveScore(2)

					Blackout(true,"luaJM8Checkpoint1",1)

					--luaJM8AddAirfield()
				else
					luaObj_Reminder("primary",2)
					luaJM8Pri2Score()
					--luaLog("pri2 score update")
				end
			end
		end

	elseif Mission.MissionPhase == 2 then

		if not luaObj_IsActive("secondary",1) then
			luaObj_Add("secondary",1)
			luaJM8StartDialog("SecObjAdded")
			--luaJM8Sec1Score()
		end

		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
			luaObj_AddReminder("primary",3)
			--luaJM8Pri3Score()
		else
			if luaObj_GetSuccess("primary",3) == nil then

				if luaJM8AreStocksEmpty() and table.getn(Mission.AirPatrol) > 0 then
					luaObj_Failed("primary",3)
					Mission.MissionFailed = true
					Mission.FailMsg = "ijn08.obj_missionfailed2"
					--luaJM8RemoveScore(3)
					luaJM8StepPhase(99)
				else
					luaObj_Reminder("primary",3)
					--luaJM8Pri3Score()
				end

				if Mission.NoMoreAirSpawn and table.getn(Mission.AirPatrol) == 0 then
					luaObj_Completed("primary",3)
					Mission.MissionCompleted = true
					--luaJM8RemoveScore(3)
					luaJM8StepPhase(99)
				else
					luaObj_Reminder("primary",3)
					--luaJM8Pri3Score()
				end

			end
		end

	elseif Mission.MissionPhase == 99 then

		local endEnt = Mission.CommandBuilding
		if Mission.MissionFailed then
			--luaObj_FailedAll()
			luaMissionFailedNew(endEnt, Mission.FailMsg, nil, true)
		elseif Mission.MissionCompleted then
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				luaObj_Completed("primary",1)
				HideUnitHP()
			end

			if not Mission.USLandingStarted then
				luaObj_Completed("hidden",1)
			end

			luaMissionCompletedNew(endEnt, "ijn08.obj_missioncompleted", nil)

			local medal = luaGetMedalReward()
			--if medal == MEDAL_SILVER then
			--	Scoring_GrantBonus("JM8_SCORING_SILVER", "ijn08.bonus1_title", "ijn08.bonus1_text", 167)
			if medal == MEDAL_GOLD then
				Scoring_GrantBonus("JM8_SCORING_GOLD", "ijn08.bonus1_title", "ijn08.bonus2_text", 167)
				--Scoring_GrantBonus("JM8_SCORING_GOLD", "ijn08.bonus1_title", "ijn08.bonus1_text", 167)
			end

		end

		luaJM8StepPhase()

	end
end

function luaJM8Checkpoint1()
	--luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM8CheckSecObj()
	if not luaObj_IsActive("secondary",1) or luaObj_GetSuccess("secondary",1) ~= nil then
		return
	end

	if table.getn(Mission.USNFleet) > 0 then
		for idx,unit in pairs(Mission.USNFleet) do
			if unit.Dead and unit.KillReason == "exitzone" then
				Mission.SecFailed = true
			end
		end
	else
		if not Mission.SecFailed then
			Mission.SecCompleted = true
		end
	end
end

function luaJM8CheckUSNFleet()
	Mission.USNFleet = luaRemoveDeadsFromTable(Mission.USNFleet)
	if table.getn(Mission.USNFleet) == 0 then
		--luaLog("no more usn fleet ships")
		return
	end

	--lsts
	if table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) > 0 then

		if not Mission.USLandingStarted then

			for idx,unit in pairs(Mission.USNLsts) do
				if not unit.Dead and not unit.LandingStarted and luaGetDistance(unit,unit.LandingPoint) < 200 then
-- RELEASE_LOGOFF  					luaLog("Landing lsts")
					StartLanding2(unit)
					--unit.LandingStarted = true
				end

				if unit.LandingFinished then
					Mission.USLandingStarted = true
				end
			end


			local landingships = recon[PARTY_ALLIED].own.landingship
			for idx,unit in pairs(landingships) do
				if not unit.Dead and unit.LandingFinished then
					Mission.USLandingStarted = true
					break
				end
			end

		end

	end

	--cargos
	if table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) > 0 and table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) == 0 then
		for idx,unit in pairs(Mission.USNCargos) do
			if not unit.Dead and luaGetDistance(unit,unit.LandingPoint) < 200 then
				if not Mission.TorpHint then
					local PLunit = GetSelectedUnit()
					if PLunit and not PLunit.Dead and PLunit.Class.Type == "TorpedoBoat" then
						luaJM8TorpHint()
						Mission.TorpHint = true
					end
				end
-- RELEASE_LOGOFF  				luaLog("Landing cargos")
				NavigatorStop(unit)
				if not unit.Lastlanding or math.floor(GameTime()) - unit.Lastlanding > Mission.LandingSpawnTime then
					local debuginfo = StartLanding2(unit)
					if tonumber(debuginfo) < 0 then
						--luaLog("landing debug")
						--luaLog(debuginfo)
						--unit.Lastlanding = math.floor(GameTime())
					end
				end
			end
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) == 0 then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNFleet)) do
			if not unit.retreating and not unit.Dead then
				NavigatorMoveToRange(unit, GetPosition(Mission.USNRetreatPoint))
				unit.retreating = true
			end
		end
	end

end

function luaJM8GetBuffaloTrg()
	local protship = luaPickRnd(luaSumTablesIndex(luaRemoveDeadsFromTable(Mission.USNLsts), luaRemoveDeadsFromTable(Mission.USNCargos)))
	local shipsAround = luaGetShipsAround(protship, 1500, "enemy")
	local planesAround = luaGetPlanesAround(protship, 1500, "enemy")
	local inRange = {}
	local trg

	if shipsAround ~= nil and planesAround ~= nil then
		inRange = luaSumTablesIndex(shipsAround, planesAround)
	elseif shipsAround == nil and planesAround ~= nil then
		inRange = planesAround
	elseif shipsAround ~= nil and planesAround == nil then
		inRange = shipsAround
	end

	if next(inRange) ~= nil then
		return luaPickRnd(inRange), protship
	else
		return nil, protship
	end
end

function luaJM8CheckBuffalos()
	Mission.Buffalos = luaRemoveDeadsFromTable(Mission.Buffalos)
	if table.getn(Mission.Buffalos) == 0 then
		return
	end

	if Mission.MissionPhase == 1 then

		if table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) > 0 or table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) > 0 then
			for idx,unit in pairs(Mission.Buffalos) do
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					local trg, protship = luaJM8GetBuffaloTrg()
					if trg == nil and protship and not unit.capping then
						PilotMoveToRange(unit, protship)
						unit.capping = true
					elseif trg and protship and unit.capping then
						luaSetScriptTarget(unit, trg)
						PilotSetTarget(unit, trg)
						unit.capping = false
					end
				end
			end
		end
	else
		for idx,unit in pairs(Mission.Buffalos) do
			if not unit.retreating then
				UnitHoldFire(unit)
				PilotRetreat(unit)
				unit.retreating = true
			end
		end
	end

end

function luaJM8CheckUSNPts()
	Mission.USNPts = luaRemoveDeadsFromTable(Mission.USNPts)

	if table.getn(Mission.USNPts) == 0 then
		--luaLog("no more pts")
		return
	end

	local nmiShips = luaGetShipsAround(Mission.USNPts[1], 3000, "enemy")
	--luaLog(nmiShips)

	if nmiShips and next(nmiShips) ~= nil then
		for idx,unit in pairs(Mission.USNPts) do
			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				if IsInFormation(unit) then
					LeaveFormation(unit)
				end
				luaJM8Checktorp(unit)
				local trg = luaPickRnd(nmiShips)
				NavigatorAttackMove(unit, trg, {})
				luaSetScriptTarget(unit, trg)
			end
		end
	else
		for idx,unit in pairs(Mission.USNPts) do
			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				if not IsInFormation(unit) and table.getn(luaRemoveDeadsFromTable(Mission.USNFleet)) > 0 then
					JoinFormation(unit, Mission.USNFleet[1])
				end
			end
		end
	end

end

function luaJM8Checktorp(unit)
	if unit.Dead then
		return
	end
	local torp = GetProperty(unit, "TorpedoStock")
	TorpedoEnable(unit, true)
	if torp < 12 then
		ReloadTorpedoes(unit, unit.Class.MaxTorpedostock)
	end
end

function luaJM8CheckAirPatrol()
-- RELEASE_LOGOFF  	luaLog("luaJM8CheckAirPatrol()")
	Mission.AirPatrol = luaRemoveDeadsFromTable(Mission.AirPatrol)

	--if not Mission.Airfield or Mission.Airfield.Dead then
		--return
	--end

	if table.getn(Mission.AirPatrol) < Mission.MaxAlliedPlaneSquads and not SpawnNewIDIsRequested(Mission.AirPatrolSpawnReq) then
-- RELEASE_LOGOFF  		luaLog("Spawn initiated")
		luaJM8SpawnAirPatrol()
	end

	local landFortTbl = luaJM8GetRocketTarget()
	local emptyStock = luaJM8AreStocksEmpty()

	for idx,unit in pairs(Mission.AirPatrol) do

		local sqType = unit.Class.Type
		local eq = GetProperty(unit, "ammoType")
		local cmd = GetProperty(unit, "unitcommand")

		if sqType == "Fighter" and eq ~= 0 then

			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then

				if next(landFortTbl) ~= nil then
					local key,trg = luaPickRnd(landFortTbl,true)
-- RELEASE_LOGOFF  					luaLog("landfort trg")
-- RELEASE_LOGOFF  					luaLog(trg.Name)
-- RELEASE_LOGOFF  					luaLog(unit.Name)
					PilotSetTarget(unit, trg)
					luaSetScriptTarget(unit, trg)
					table.remove(landFortTbl, key)
				else
					local cmd = GetProperty(unit, "unitcommand")
					if unit.moveonTrg == nil then
						PilotMoveToRange(unit, Mission.CommandBuilding)
						unit.moveonTrg = "cmdBuilding"
						UnitFreeAttack(unit)
					end
				end

			else

				if not Mission.AttackMovie and luaGetDistance(unit, luaGetScriptTarget(unit)) <  1800 then
					luaJM8AttackMovie(unit)
					Mission.AttackMovie = true
				end

			end

		elseif sqType == "Fighter" and eq == 0 then

			if emptyStock then
				UnitHoldFire(unit)
				PilotRetreat(unit)
			else

				local planes = luaGetPlanesAround(unit, 12000, "enemy")
				local ships = luaGetShipsAround(unit, 12000, "enemy", nil, nil, "torpedoboat")

				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					local trg
					if planes and next(planes) then
						trg = luaPickRnd(planes)
					else
						if ships and next(ships) then
							trg = luaPickRnd(ships)
						end
					end
					if trg and not trg.Dead then
						luaSetScriptTarget(unit, trg)
						PilotSetTarget(unit, trg)
					else
						if cmd == "moveto" and unit.moveonTrg ~= "cmdBuilding" then
-- RELEASE_LOGOFF  							luaLog(unit.Name.." moves to cmdbuilding")
							PilotMoveToRange(unit, Mission.CommandBuilding)
							unit.moveonTrg = "cmdBuilding"
						end
					end
				end

			end

		elseif sqType == "DiveBomber" then

			if eq ~= 0 and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
				luaJM8GetBombTarget(unit)
			elseif eq == 0 and not unit.retreating then
				PilotRetreat(unit)
				unit.retreating = true
			end

		end
	end
end

function luaJM8GetRocketTarget(unit)
	local landFortTbl = {}
	if not Mission.CommandBuilding.Dead and Mission.CommandBuilding.Party == PARTY_JAPANESE then
		table.insert(landFortTbl, Mission.CommandBuilding)

		--local AF = FindEntity("MainAirFieldEntity 01")
		--local SY = FindEntity("Shipyard 01")

		--if AF and not AF.Dead and not GetFailure(AF, "InferiorFailure") then
		if not Mission.Airfield.Dead and not GetFailure(Mission.Airfield, "InferiorFailure") then
			table.insert(landFortTbl, Mission.Airfield)
-- RELEASE_LOGOFF  			luaLog("Adding AF to rocket target")
		end

		--if SY and not SY.Dead and not GetFailure(SY, "InferiorFailure") then
		if Mission.Shipyard1.Dead and not GetFailure(Mission.Shipyard1, "InferiorFailure") then
			table.insert(landFortTbl, Mission.Shipyard1)
-- RELEASE_LOGOFF  			luaLog("Adding SY to bomb target")
		end

	end
	for idx,landfort in pairs(recon[PARTY_JAPANESE].own.landfort) do
		if not landfort.Dead then
			if (string.find(landfort.Name, "Bunker") or string.find(landfort.Name, "Gun") or string.find(landfort.Name, "AA")) then
				table.insert(landFortTbl, landfort)
			end
		end
	end
	return landFortTbl
end

function luaJM8GetBombTarget(unit)
	local landFortTbl = {}
	local seclandFortTbl = {}
	for idx,landfort in pairs(recon[PARTY_JAPANESE].own.landfort) do
		if not landfort.Dead and string.find(landfort.Name, "Headquarter") then
			table.insert(landFortTbl, landfort)
		end
		if not landfort.Dead and (string.find(landfort.Name, "Hangar") or string.find(landfort.Name, "Shipyard")) then
			table.insert(seclandFortTbl, landfort)
		end
	end

	if next(landFortTbl) ~= nil then
		local trg = luaPickRnd(landFortTbl)
		PilotSetTarget(unit, trg)
		luaSetScriptTarget(unit, trg)
	elseif next(seclandFortTbl) ~= nil then
		local trg = luaPickRnd(seclandFortTbl)
		PilotSetTarget(unit, trg)
		luaSetScriptTarget(unit, trg)
	else
		local cmd = GetProperty(unit, "unitcommand")
		if cmd ~= "moveto" then
			PilotMoveToRange(unit, Mission.CommandBuilding)
		end
	end
end

function luaJM8SpawnAirPatrol()
	--102 corsair, 108 dauntless
	if Mission.NoMoreAirSpawn then
-- RELEASE_LOGOFF  		luaLog("No more spawn needed")
		return
	end

-- RELEASE_LOGOFF  	luaLog("Spawn function")

	local grpTbl = {}

	local rocketTmpl = {
		["Type"] = 102,
		["Name"] = "F4U Corsair",
		["Crew"] = Mission.SkillLevel,
		["Race"] = USA,
		["Equipment"] = 1,
	}

	local fighterTmpl = {
		["Type"] = 102,
		["Name"] = "F4U Corsair",
		["Crew"] = Mission.SkillLevel,
		["Race"] = USA,
		["Equipment"] = 0,
	}

	local diverTmpl = {
		["Type"] = 108,
		["Name"] = "SBD Dauntless",
		["Crew"] = Mission.SkillLevel,
		["Race"] = USA,
		["Equipment"] = 1,
	}

	local rocketNum
	local fighterNum
	local diverNum

	if Mission.Difficulty == 0 then
		rocketNum = 1
		fighterNum = 1
		diverNum = 1
	elseif Mission.Difficulty == 1 then
		rocketNum = 1
		fighterNum = 2
		diverNum = 1
	elseif Mission.Difficulty == 2 then
		rocketNum = 2
		fighterNum = 2
		diverNum = 1
	end

	for i=1,rocketNum do
		table.insert(grpTbl, rocketTmpl)
	end

	for i=1,fighterNum do
		table.insert(grpTbl, fighterTmpl)
	end

	for i=1,diverNum do
		table.insert(grpTbl, diverTmpl)
	end

	local positions = luaJM8GetPossiblePositions()

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl,
	["area"] = {
		--["refPos"] = GetPosition(FindEntity("USNReinforcement")),
		["refPos"] = positions[1],
		["angleRange"] = { luaJM8RAD(45), luaJM8RAD(155) },
		["lookAt"] = GetPosition(Mission.CommandBuilding)
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM8AirpatrolSpawned",
	["id"] = Mission.AirPatrolSpawnReq,
	})
end

function luaJM8GetPossiblePositions()
	local tbl = {}

	local spwnPoint = GetPosition(FindEntity("USNReinforcement"))
	local ownUnits = luaGetOwnUnits(nil,PARTY_JAPANESE)
	local dist = 0
	local newpos

	for idx,unit in pairs(ownUnits) do
		local p = GetPosition(unit)
		if luaGetDistance(spwnPoint, p) > dist then
			newpos = p
			--luaLog("found a possible pos")
			--luaLog(newpos)
		end
	end

	local numPoints = 5
	local x
	local z
	local modifier = 4200

	for i=1,numPoints do
		x = newpos.x + modifier * math.cos(i * (2 * math.pi)/numPoints)
		z = newpos.z + modifier * math.sin(i * (2 * math.pi)/numPoints)
		table.insert(tbl, {["x"]=x, ["y"]=100, ["z"]=z})
	end

	if table.getn(tbl) == 0 then
		table.insert(tbl, GetPosition(FindEntity("USNReinforcement")))
	end
	return tbl
end

function luaJM8AirpatrolSpawned(...)

	if Mission.PatrolSpawned == 0 then
		luaDelay(luaJM8IncomPlanesDlg,6)
	end

	Mission.AirPatrol = luaRemoveDeadsFromTable(Mission.AirPatrol)
	for idx,unit in ipairs(arg) do
		SetSkillLevel(unit, Mission.SkillLevel)
		table.insert(Mission.AirPatrol, unit)
	end
	Mission.PatrolSpawned = Mission.PatrolSpawned + 1

	Mission.ASLeft = 4 - Mission.PatrolSpawned
	--local str

	--if spawnsLeft == 1 then
	--	str = "ijn08.hint_lastairstrike"
	--else
	--	str = tostring(Mission.ASLeft).." ijn08.hint_airstrikeleft"
	--end

	--MissionNarrativeUrgent(str)

	if Mission.PatrolSpawned == 3 then
		Mission.NoMoreAirSpawn = true
	end
end

function luaJM8RAD(x)
	return x *  0.0174532925
end

function luaJM8StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM8AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM8AddAirfield()
end

function luaJM8StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM8StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM8StartDialog cannot continue, non existing dialog: "..dialogID, 2)
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

function luaJM8IncomPlanesDlg()
	luaJM8StartDialog("IncomPlanes")
end

function luaJM8AddAirfieldHitListener()
	AddListener("hit", "airfieldhit", {
		["callback"] = "luaJM8AirfieldHitByAI", -- callback fuggveny
		["target"] = { Mission.Airfield }, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = Mission.AirPatrol, -- tamado entityk
		["attackType"] = {"BOMB","ROCKET"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_AI}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM8AirfieldHitByAI()
	RemoveListener("hit", "airfieldhit")
end

function luaJM8AddShipyardHitListener()
	AddListener("hit", "shipyardhit", {
		["callback"] = "luaJM8ShipyardHitByAI", -- callback fuggveny
		--["target"] = { Mission.Shipyard1, Mission.Shipyard2 }, -- entityk akiken a listener aktiv
		["target"] = { Mission.Shipyard1 }, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = Mission.AirPatrol, -- tamado entityk
		["attackType"] = {"BOMB","ROCKET"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_AI}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM8ShipyardHitByAI()
	RemoveListener("hit", "shipyardhit")
end

function luaJM8IsDisabled(ent)
	if not luaIsEntityTable({ent},false) then
		--luaLog("luaJM8IsDisabled got a wrong param")
		--luaLog(ent.Name)
		return
	end

	if GetFailure(ent, "InferiorFailure") then
		if ent.ID == Mission.Airfield.ID then
			--luaJM5StartDialog("ValSuccess",true)
		end
		return true
	end

	return false
end

function luaJM8DisableDlgTrigger()
	if Mission.Airfield.WasDisabled == nil then
		if luaJM8IsDisabled(Mission.Airfield) then
			Mission.Airfield.WasDisabled = true
			luaJM8StartDialog("AirfieldDisabled")
		end
	else
		if not luaJM8IsDisabled(Mission.Airfield) then
			luaJM8StartDialog("AirfieldReinstated")
		end
	end

	if Mission.Shipyard1.WasDisabled == nil then
		if luaJM8IsDisabled(Mission.Shipyard1) then
			Mission.Shipyard1.WasDisabled = true
			luaJM8StartDialog("ShipyardDisabled")
		end
	else
		if not luaJM8IsDisabled(Mission.Shipyard1) then
			luaJM8StartDialog("ShipyardReinstated")
		end
	end

	--[[
	if Mission.Shipyard2.WasDisabled == nil then
		if luaJM8IsDisabled(Mission.Shipyard2) then
			Mission.Shipyard2.WasDisabled = true
			luaJM8StartDialog("ShipyardDisabled")
		end
	else
		if not luaJM8IsDisabled(Mission.Shipyard2) then
			luaJM8StartDialog("ShipyardReinstated")
		end
	end
	]]
end

function luaJM8FadeIn()
	luaCheckSavedCheckpoint()

	--SoundFade(1, "",0.1)

	if not Mission.CheckpointLoaded then
		Blackout(false, "", 1.5)
	else
		Blackout(true, "", 0)
	end
end

function luaJM8AddGenerateListener()
-- RELEASE_LOGOFF  	luaLog("luaJM8AddGenerateListener called")
	AddListener("generate", "luaJM8PTGenerated", {
		["callback"] = "luaJM8PTGenerated",  -- callback fuggveny
		["entityName"] = {"Gyoraitei","Mavis"}, -- string, a generalt template neve
		["entityType"] = {}, -- vehicleclasses.lua-bol a type parameter pl torpedoboat
		})
end

function luaJM8PTGenerated(unitName)
-- RELEASE_LOGOFF  	luaLog("luaJM8PTGenerated called")
-- RELEASE_LOGOFF  	luaLog(unitName)

	--ForceRecon()

	if string.find(unitName, "Gyoraitei") then
		for idx,unit in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
			if not unit.Dead and not unit.PlayerCtrl and unit.Name == unitName then
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
				unit.PlayerCtrl = true
			end
		end
		Mission.PTsSpawned = Mission.PTsSpawned + 1
	end

	if string.find(unitName, "Mavis") then
		for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
			if not unit.Dead and not unit.PlayerCtrl and unit.Name == unitName then
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
				PilotMoveToRange(unit, Mission.SpawnTo)
				unit.PlayerCtrl = true
			end
		end
		Mission.MavisSpawned = Mission.MavisSpawned + 1
	end
end

function luaJM8CheckPlayerPTs()
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
		if not unit.Dead and not unit.PlayerCtrl then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
			unit.PlayerCtrl = true
		end
	end

	for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
		if not unit.Dead and not unit.PlayerCtrl then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
			PilotMoveToRange(unit, Mission.SpawnTo)
			unit.PlayerCtrl = true
		end
	end
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(102)
	PrepareClass(108)
	PrepareClass(113)
	PrepareClass(162)
	Loading_Finish()
end

function luaJM8SetGuiNames()
-- RELEASE_LOGOFF  	luaLog("allitom a guineveket")

	for idx, unit in pairs(Mission.USNFleet) do
		SetGuiName(unit, Mission.USNFleetNames[idx][1])
		if Mission.USNFleetNames[idx][2] then
			SetNumbering(unit, Mission.USNFleetNames[idx][2])
		end
	end

	for idx, unit in pairs(Mission.USNPts) do
		SetGuiName(unit, Mission.USNPtNames[idx])
	end

end

function luaJM8SMHint()
	ShowHint("IJN08_Hint01")
end

function luaJM8CBHint()
	ShowHint("IJN08_Hint02")
end

function luaJM8TorpHint()
	ShowHint("IJN08_Hint03")
end

function luaJM8RocketHint()
	ShowHint("IJN08_Hint04")
end

function luaJM8AreStocksEmpty()
	local AFStockTbl
	local SYStockTbl

	if not Mission.Airfield or Mission.Airfield.Dead then
		return
	end

	if not Mission.Airfield.Dead then
	 AFStockTbl = GetProperty(Mission.Airfield, "Stock")
	end

	if not Mission.Shipyard1.Dead then
	 SYStockTbl = GetProperty(Mission.Shipyard1, "Stock")
	end

	--luaLog(AFStockTbl)
	--luaLog(SYStockTbl)

	if not AFStockTbl and not SYStockTbl then
		return true
	end

	if AFStockTbl and type(AFStockTbl) == "table" then
		for idx,slot in pairs(AFStockTbl) do
			if slot.count > 0 then
				return false
			end
		end
	end
	if SYStockTbl and type(SYStockTbl) == "table" then
		for idx,slot in pairs(SYStockTbl) do
			if slot.count > 0 then
				return false
			end
		end
	end
	return true
end

function luaJM8Pri1Score()
	--local hp = GetCapturePercentage(Mission.CommandBuilding) * 100
	--Mission.CaptureProgress = string.format("%.0f",hp)
	--local hp = GetHpPercentage(cb) * 100
	--local line1 = "ijn08.obj_p1"
	--local line2 = "Capture progress "..hp.."%"
	--luaJM8DisplayScore(1,line1,line2)
	DisplayUnitHP({Mission.CommandBuilding}, "ijn08.obj_basestatus")
end

function luaJM8Pri2Score()
	Mission.LShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) + table.getn(luaRemoveDeadsFromTable(Mission.USNLsts))
	local line1 = "ijn08.obj_p2"
	local line2 = "ijn08.hint_landingships"
	luaJM8DisplayScore(2,line1,line2)
end

function luaJM8Pri3Score()
	local line1 = "ijn08.obj_p1"
	local line2 = "ijn08.hint_airstrikeleft"
	luaJM8DisplayScore(3,line1,line2)
end

function luaJM8Sec1Score()
	Mission.WShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.USNFleet))
	local line1 = "ijn08.obj_s1"
	local line2 = "ijn08.hint_warships"
	luaJM8DisplayScore(4,line1,line2)
end

function luaJM8DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM8RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

-----------------------------moviez----------------------------
function luaJM8MovieInit()
	Mission.MovieUnitPL = GetSelectedUnit()
	if Mission.MovieUnitPL then
		SetInvincible(Mission.MovieUnitPL, 0.1)
	end
end

function luaJM8SelectUnit()
	if Mission.MovieUnitPL then
		SetSelectedUnit(Mission.MovieUnitPL)
		SetInvincible(Mission.MovieUnitPL, false)
		Mission.MovieUnitPL = nil
	else
		if Mission.CommandBuilding.Party == PARTY_JAPANESE then
			SetSelectedUnit(Mission.CommandBuilding)
		end
	end
	EnableInput(true)
end

function luaJM8CargoMovie()
	luaJM8MovieInit()
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNLsts[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 259, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNLsts[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 10, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNLsts[2], ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNLsts[2], ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNCargos[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 20, ["moveTime"] = 0,},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNCargos[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 300, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNCargos[2], ["distance"] = 500, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.USNCargos[2], ["distance"] = 200, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 5},
		},	luaJM8SelectUnit )
end

function luaJM8AttackMovie(unit)
	luaJM8MovieInit()
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 25, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 25, ["rho"] = 180, ["moveTime"] = 5},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 25, ["rho"] = 180, ["moveTime"] = 10,},
		},	luaJM8SelectUnit )
end

------checkpoint----------------
function luaJM8SaveMissionData()
	--hp
	Mission.Checkpoint.CBHP = GetHpPercentage(Mission.CommandBuilding)
	Mission.Checkpoint.AFHP = GetHpPercentage(FindEntity("MainHangar, Large, 07 01"))
	Mission.Checkpoint.SYHP = GetHpPercentage(Mission.Shipyard1)

	--Mission.Checkpoint.SYStock = luaJM8GetSYStockNum()
	Mission.Checkpoint.PTsSpawned = Mission.PTsSpawned
	Mission.Checkpoint.MavisSpawned = Mission.MavisSpawned
	--Mission.Checkpoint.MavisTbl = {}
	Mission.Checkpoint.PlaneTbl = {}
	Mission.Checkpoint.Pts = {}

	--for idx,unit in pairs(Mission.Mavises) do
	--	if not unit.Dead then
	--		table.insert(Mission.Checkpoint.MavisTbl, {unit.Name, GetPosition(unit)})
	--	end
	--end

	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_JAPANESE].own.fighter,recon[PARTY_JAPANESE].own.levelbomber)) do
		if not unit.Dead then
			table.insert(Mission.Checkpoint.PlaneTbl, {unit.Name, unit.Class.ID, GetPosition(unit), GetProperty(unit, "ammoType")})
		end
	end

	for idx,unit in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
		if not unit.Dead then
			table.insert(Mission.Checkpoint.Pts, {unit.Name, GetGuiName(unit), GetPosition(unit), GetProperty(unit, "TorpedoStock")})
		end
	end

	--dlg
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
end

function luaJM8LoadMissionData()
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	--cb hp
-- RELEASE_LOGOFF  	luaLog("hp add")
-- RELEASE_LOGOFF  	luaLog(Mission.CommandBuilding.Class.HP)
-- RELEASE_LOGOFF  	luaLog(Mission.Checkpoint.CBHP)

	local hp = (Mission.CommandBuilding.Class.HP - (Mission.CommandBuilding.Class.HP * Mission.Checkpoint.CBHP))
	if hp > 0 then
		AddDamage(Mission.CommandBuilding, hp)
	end

	if not Mission.Airfield.Dead then
		local hangar = FindEntity("MainHangar, Large, 07 01")
		local hp = (hangar.Class.HP - (hangar.Class.HP * Mission.Checkpoint.AFHP))
		if hp > 0 then
			AddDamage(Mission.Airfield, hp)
		end
	end

	if not Mission.Shipyard1.Dead then
		local hp = (Mission.Shipyard1.Class.HP - (Mission.Shipyard1.Class.HP * Mission.Checkpoint.SYHP))
		if hp > 0 then
			AddDamage(Mission.Shipyard1, hp)
		end
	end

	luaJM8RestoreUSUnits()
end

function luaJM8RestoreUSUnits()

	local landing = false
	local landingstarted = false
	local landingpoints = {GetPosition(Mission.USNLandingPoint1), GetPosition(Mission.USNLandingPoint2)}
	local leader
	local leadername
	local leaderpos

	local USUnits = luaGetCheckpointData("Units", "USUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking allied units")
	for idx,unit in pairs(Mission.USNFleet) do
		local found = false
		for idx2,unitTbl in pairs(USUnits[1]) do

			--landingboat check
			if not landing and unit.Class.ID == 40 then
				landing = true
			end

			--StartLanding
			if not landingstarted and unit.Class.Type == "Cargo" then
				PutTo(unit, luaPickRnd(landingpoints))
				local err = StartLanding2(unit)
				if tonumber(err) > 0 then
					landingstarted = true
				end
			end

			if unitTbl[5] and not leadername then
				leadername = unitTbl[5]
				leaderpos = unitTbl[6]
			end

			if not leader and unit.Name == leadername then
				leader = unit
			end

			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end

				found = true
				break
			end
		end

		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	luaDelay(luaJM8USFormation, 1)

	luaJM8RestoreJapUnits()

	luaDelay(luaJM8AddInput,1)
	--luaJM8AddInput()
end

function luaJM8USFormation(timerThis)
	local leader = timerThis.ParamTable.leader
	local leaderpos = timerThis.ParamTable.leaderpos

	if leader and leaderpos then
		local angle
		if table.getn(luaRemoveDeadsFromTable(Mission.USNLsts)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.USNCargos)) == 0 then
			angle = luaGetAngle("world", leaderpos, GetPosition(Mission.USNRetreatPoint))
		end
		if angle then
			PutTo(leader, leaderpos, -angle)
		else
			PutTo(leader, leaderpos)
		end

		local i = 1
		local x = 100
		local z = -100
		local multi = {[1] = 1, [2] = -1,}
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USNFleet)) do

	 		local relTbl = {
				["x"] = x * i * multi[math.fmod(i,2)+1],
				["y"] = 0,
				["z"] = z * i,
			}

			PutRelTo(unit, leader, relTbl)
			JoinFormation(unit, leader)
			i = i + 1

	 	end

	end

end

function luaJM8RestoreJapUnits()
	--todo: shipyard es stock
	local japUnits = luaGetCheckpointData("Units", "JapUnits")

	if not Mission.Shipyard1.Dead then

		local stock = GetProperty(Mission.Shipyard1, "Stock")
		local PtCount = stock[1].count
		local MavisCount = stock[2].count

		if Mission.Checkpoint.PTsSpawned < PtCount then
			RemoveShipyardStock(Mission.Shipyard1, 77, Mission.Checkpoint.PTsSpawned)
		else
			RemoveShipyardStock(Mission.Shipyard1, 77, PtCount)
		end

		if Mission.Checkpoint.MavisSpawned < MavisCount then
			RemoveShipyardStock(Mission.Shipyard1, 174, Mission.Checkpoint.MavisSpawned)
		else
			RemoveShipyardStock(Mission.Shipyard1, 174, MavisCount)
		end

		--Mission.Checkpoint.PTsSpawned
		--Mission.Checkpoint.MavisSpawned

		--[[
-- RELEASE_LOGOFF  		luaLog(Mission.ChckLogPrefix.."Checking japanese player units")
		local savedPts = 0
		for idx2,unitTbl in pairs(japUnits[1]) do
			if unit.Tbl[3] == 77 then
				savedPts = savedPts + 1
			end
		end

		--saved ptket vissza a stockba
		local origstock = luaJM8GetSYStockNum()
		local savedstock = Mission.Checkpoint.SYStock
		local diff = (origstock - savedstock) + savedPts

		if origstock > savedstock and diff > 0 then
			for i=1,diff do
				RemoveShipyardStock(Mission.Shipyard1, 77, 1)
			end
		end
	]]
	--	local origstock = luaJM8GetSYStockNum()
	--	local savedstock = Mission.Checkpoint.SYStock
	--	local diff = origstock - savedstock

		--if origstock > savedstock and diff > 0 then
		--	for i=1,diff do
		--		RemoveShipyardStock(Mission.Shipyard1, 77, 1)
		--	end
		--end
	end

	--restore planes
	--for idx,unit in pairs(Mission.Mavises) do
	--	local found = false
	--	for idx,savedTbl in pairs(Mission.Checkpoint.MavisTbl) do
	--		if unit.Name == savedTbl[1] then
	--			PutTo(unit, savedTbl[2])
	--			found = true
	--			break
	--		end
	--	end
	--	if not found then
	--		Kill(unit, true)
	--	end
	--end

	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_JAPANESE].own.fighter, recon[PARTY_JAPANESE].own.levelbomber)) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end


	--[[
	1 "hidden_oscar"
	2 "hidden_oscar_bomb"
	3 "hidden_gekko"
	4 "hidden_gekko_bomb"
	5 "hidden_betty"
	6 "hidden_betty_torp"
	7 "hidden_shinden"
	8 "hidden_shinden_bomb"
	9 "hidden_kikka"
	10 "hidden_kikka_rocket"
	 ]]


	for idx,savedTbl in pairs(Mission.Checkpoint.PlaneTbl) do
		AddAirBasePlanes(Mission.Airfield, savedTbl[2], 3)
		--[[
		if string.find(savedTbl[1], "Oscar") then
			if savedTbl[4] and savedTbl[4] ~= 0 then
				luaJM8GeneratePlane(2,savedTbl[3])		--bomb
			else
				luaJM8GeneratePlane(1,savedTbl[3])		--no ammo
			end
		elseif string.find(savedTbl[1], "Gekko") then
			if savedTbl[4] and savedTbl[4] ~= 0 then
				luaJM8GeneratePlane(4,savedTbl[3])		--bomb
			else
				luaJM8GeneratePlane(3,savedTbl[3])		--no ammo
			end
		elseif string.find(savedTbl[1], "Betty") then
			if savedTbl[4] and savedTbl[4] ~= 1 then
				luaJM8GeneratePlane(6,savedTbl[3])		--torp
			else
				luaJM8GeneratePlane(5,savedTbl[3])		--bomb
			end
		elseif string.find(savedTbl[1], "Shinden") then
			if savedTbl[4] and savedTbl[4] ~= 0 then
				luaJM8GeneratePlane(8,savedTbl[3])		--bomb
			else
				luaJM8GeneratePlane(9,savedTbl[3])		--no ammo
			end
		elseif string.find(savedTbl[1], "Kikka") then
			if savedTbl[4] and savedTbl[4] ~= 1 then
				luaJM8GeneratePlane(10,savedTbl[3])		--rocket
			else
				luaJM8GeneratePlane(9,savedTbl[3])		--bomb
			end
			elseif string.find(savedTbl[1], "Okha") then
			if savedTbl[4] then
				luaJM8GeneratePlane(11,savedTbl[3])
			end
		end
		]]
	end

	--restore pts
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end

	for idx,savedTbl in pairs(Mission.Checkpoint.Pts) do
		luaJM8GeneratePt(savedTbl[2],savedTbl[3],savedTbl[4])
	end
end

function luaJM8GeneratePt(guiName,pos,stock)
	local pt = GenerateObject("hidden_pt")
	SetGuiName(pt, guiName)
	PutTo(pt, pos)
	ShipSetTorpedoStock(pt, stock)
end

function luaJM8GeneratePlane(type, pos)
	local planes = {"hidden_oscar", "hidden_oscar_bomb", "hidden_gekko", "hidden_gekko_bomb", "hidden_betty", "hidden_betty_torp", "hidden_shinden", "hidden_shinden_bomb", "hidden_kikka", "hidden_kikka_rocket", "hidden_okha"}
	local squad = GenerateObject(planes[type])
	PutTo(squad, pos)

	if not Mission.Airfield.Dead and not GetFailure(Mission.Airfield, "InferiorFailure") then
		SquadronSetHomeBase(squad, Mission.Airfield)
	end
end

function luaJM8AddInput()
-- RELEASE_LOGOFF  	luaLog("addinput")
	Blackout(false, "", 0.5)
	EnableInput(true)
end

function luaJM8GetSYStockNum()
	local SYStockTbl
	local count = 0

	if not Mission.Shipyard1.Dead then
	 SYStockTbl = GetProperty(Mission.Shipyard1, "Stock")
	end

	if SYStockTbl and type(SYStockTbl) == "table" then
		for idx,slot in pairs(SYStockTbl) do
			if slot.count > 0 then
				count = count + slot.count
			end
		end
	end

	return count
end

function luaJM8SetDifficulty(tbl)
	for idx,unit in pairs(tbl) do

		SetSkillLevel(unit, Mission.SkillLevel)

	end
end
