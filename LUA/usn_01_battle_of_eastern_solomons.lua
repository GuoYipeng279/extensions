--SceneFile="missions\USN\usn_01_Battle_of_Eastern_Solomons.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
function luaEngineMovieInit()
	Music_Control_SetLevel(0)
	EnableMessages(false)
	Blackout(true, "", 0)
	Blackout(false, "", 2)
	LoadMessageMap("usn01dlg", 1)

	Dialogues = {
		["intro1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
			},
		},
		["intro2"] = {
			["sequence"] = {
				{
					["message"] = "idlg02",
				},
			},
		},
		["intro3"] = {
			["sequence"] = {
				{
					["message"] = "idlg03",
				},
			},
		},
		["intro4"] = {
			["sequence"] = {
				{
					["message"] = "idlg04",
				},
			},
		},
	}

	MissionNarrative("usn01.date_location")
	luaDelay(luaUS01StartIntro1,24 )
	luaDelay(luaUS01StartIntro2,29 )
	luaDelay(luaUS01StartIntro3,33 )
	luaDelay(luaUS01StartIntro4,35 )
end
function luaUS01StartIntro1()
	StartDialog("intro1", Dialogues["intro1"])
end
function luaUS01StartIntro2()
	StartDialog("intro2", Dialogues["intro2"])
end
function luaUS01StartIntro3()
	StartDialog("intro3", Dialogues["intro3"])
end
function luaUS01StartIntro4()
	StartDialog("intro4", Dialogues["intro4"])
end
function luaStageInit()
	CreateScript("luaInitUS01")
	Scoring_RealPlayTimeRunning(true)
end
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(150) -- Zero
	PrepareClass(171) -- Tone
	Loading_Finish()
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaInitUS01(this)
	Mission = this
	this.Name = "US01"
	this.ScriptFile = "scripts/missions/USN/usn_01_battle_of_eastern_solomons.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
		
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
			
	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS01Checkpoint1Load},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS01Checkpoint1Save},
	}

	-- Allied hajok - Enterprise grp
	this.Balch = FindEntity("Balch")
	this.Maur = FindEntity("Maur")
	this.Ellett = FindEntity("Ellett")
	this.Benham = FindEntity("Benham")
	this.Enterprise = FindEntity("Enterprise")
	
	-- Allied hajok - Saratoga grp
	this.Farragut = FindEntity("Farragut")
	this.Worden = FindEntity("Worden")
	this.MacDonough = FindEntity("MacDonough")
	this.Dale = FindEntity("Dale")
	this.Saratoga = FindEntity("Saratoga")
	
	SetInvincible(this.Enterprise, 0.5)
	
	-- Allied repcsik
	this.Wildcat1 = GenerateObject("Wildcat")
	local operettval = FindEntity("OperettVal 02")
	PutTo(this.Wildcat1, {["x"] = -7500, ["y"] = 100, ["z"] = 9500})
	EntityTurnToEntity(this.Wildcat1, operettval)
	SquadronSetTravelAlt(this.Wildcat1, 100)
	
	this.Wildcat2 = FindEntity("Wildcat2")
	
	-- Japan repcsik
	this.JapBomberWave = {}
		table.insert(this.JapBomberWave, FindEntity("Oscar 1"))
		table.insert(this.JapBomberWave, FindEntity("Val 1"))
		table.insert(this.JapBomberWave, FindEntity("Kate 1"))
	Mission.JapaneseAttackers = {}
	-- Navpontok, koordinatak
	this.NavJapSpawn = FindEntity("NavJapSpawn")
	this.NavEscort1 = FindEntity("NavEscort1")
	this.EnterprisePath = FindEntity("EnterprisePath")
	this.HendersonField = FindEntity("Hendersonfield")
	-- Support Manager tiltas
	BannSupportmanager()

	-- Achievements init
	

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))
	
	-- music
	--luaCheckMusicSetMinLevel(MUSIC_TENSION)

	-- dialogusok

	LoadMessageMap("usn01dlg", 1)
	
	this.Dialogues = {
		["dlg_Protect_Enterprise"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a"
				},
				{
					["message"] = "dlg01a1"
				},
				{
					["message"] = "dlg01b"
				},
				{
					["message"] = "dlg01c"
				},
				{
					["message"] = "dlg01d"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS01TargetHint",
				}
			},
		},
		["dlg_Saratoga_Needs_Status"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a"
				},
				{
					["message"] = "dlg02b"
				},
				{
					["message"] = "dlg02c"
				},
				{
					["message"] = "dlg02d"
				},
			},
		},
		["dlg_Scout_Plane"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a"
				},
				{
					["message"] = "dlg03b"
				},
				{
					["message"] = "dlg03c"
				},
			},
		},
		["dlg_Fires_Put_Out"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a"
				},
				{
					["message"] = "dlg04b"
				},
			},
		},
		["dlg_Listing_Corrected"] = {
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
			},
		},
		["dlg_Hit_On_Enterprise"] = {
			["sequence"] = {
				{
					["message"] = "dlg06"
				},
			},
		},
		["dlg_Almost_Hit_USS_Balch"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a"
				},
				{
					["message"] = "dlg07b"
				},
			},
		},
		["dlg_5-10_sec_pause"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a"
				},
				{
					["message"] = "dlg08b"
				},
			},
		},
		["dlg_Rudder_Jammed"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a"
				},
				{
					["message"] = "dlg09b"
				},
				{
					["message"] = "dlg09c"
				},
			},
		},
		["dlg_Listing_Again"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a"
				},
				{
					["message"] = "dlg10b"
				},
			},
		},
		["dlg_USS_Wasp"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a"
				},
				{
					["message"] = "dlg11b"
				},
			},
		},
		["dlg_Enterprise_Manouverable"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a"
				},
				{
					["message"] = "dlg12b"
				},
			},
		},
		["dlg_EnterpriseTakeOff"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a"
				},
				{
					["message"] = "dlg13b"
				},
			},
		},
		["dlg_Attackerplanes_Need_Escort"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a"
				},
				{
					["message"] = "dlg14b"
				},
				{
					["message"] = "dlg14c"
				},
			},
		},
		["dlg_Almost_there"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a"
				},
				{
					["message"] = "dlg15b"
				},
			},
		},
		["dlg_Under_attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a"
				},
				{
					["message"] = "dlg16b"
				},
			},
		},
		["dlg_Lost_a_lot_of_planes"] = {
			["sequence"] = {
				{
					["message"] = "dlg17a"
				},
				{
					["message"] = "dlg17b"
				},
				{
					["message"] = "dlg17c"
				},
			},
		},
		["dlg_Arrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg18a"
				},
				{
					["message"] = "dlg18b"
				},
				{
					["message"] = "dlg18c"
				},
				{
					["message"] = "dlg18d"
				},
				{
					["message"] = "dlg18e"
				},
			},
		},
		["dlg_Tanker_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg19a"
				},
				{
					["message"] = "dlg19b"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS01CargoesCompleted"
				}
			},
		},
		["dlg_Enemy_carrier_visual"] = {
			["sequence"] = {
				{
					["message"] = "dlg20a"
				},
				{
					["message"] = "dlg20b"
				},
			},
		},
		["dlg_Mission_completed"] = {
			["sequence"] = {
				{
					["message"] = "dlg23"
				},
				{
					["message"] = "dlg21a"
				},
				{
					["message"] = "dlg21b"
				},
				{
					["message"] = "dlg21c"
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS01RyujoComplete"
				}
			},
		},
		["dlg_Ryujo_hurt"] = {
			["sequence"] = {
				{
					["message"] = "dlg22"
				},
			},
		},
		--[[ 
		["dlg_Ryujo_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg23"
				},
			},
		},
		]]
	}
	
	-- objektivak
	
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "EnterpriseSurvive",		-- azonosito
				["Text"] = "usn01.obj_p1",
				["TextCompleted"] = nil ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "EscortAttackers",		-- azonosito
				["Text"] = "usn01.obj_p2",
				["TextCompleted"] = "usn01.obj_p2_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "SinkCargoes",		-- azonosito
				["Text"] = "usn01.obj_p3",
				["TextCompleted"] = "usn01.obj_p3_success",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[4] =
			{
				["ID"] = "SinkRyujo",		-- azonosito
				["Text"] = "usn01.obj_p4",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
			
		["secondary"] = {
			[1] =
			{
				["ID"] = "Destroytankers",		-- azonosito
				["Text"] = "usn01.obj_s1",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		
		["hidden"] = {
			[1] =
			{
				["ID"] = "SinkFleet",		-- azonosito
				["Text"] = "usn01.obj_h1",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_Add("hidden", 1)
	Mission.farthest = 10000
	Mission.ShootDown = 0
	Mission.HintCounter = 0
	Mission.FirstPhaseKillPlanes = {}
	Mission.RemainingPlanesToShoot = 10
	Mission.BomberPlanesToSave = 4
	if Mission.Difficulty == 2 then --hard
		Mission.JapBomberWaveTime = 35
		Mission.JapAttackerSpawnDelay = 50
	elseif Mission.Difficulty == 1 then	--normal
		Mission.JapBomberWaveTime = 50
		Mission.JapAttackerSpawnDelay = 70
	elseif Mission.Difficulty == 0 then	-- easy
		Mission.JapBomberWaveTime = 65
		Mission.JapAttackerSpawnDelay = 80
	end
	
	--reload enable
	SetDeviceReloadEnabled(true)
	
	luaInitNewSystems()

    --SetDeviceReloadTimeMul(0)
    SetThink(this, "US01Think")
	
	--SoundFade(0,"", 1)
	
	Blackout(true, "", 0)
	
	luaCheckSavedCheckpoint()
	
-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
	
	AddListener("kill", "EnterpriseKillID", { 
		["callback"] = "luaUS01EnterpriseDead",  -- callback fuggveny
		["entity"] = {Mission.Enterprise}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	--AddStoredHint("BASICPLANE2")
	--AddStoredHint("BASICPLANE3")
	
	if not Mission.CheckpointLoaded then
		AddDamage(this.Enterprise, 10000)
		
		Mission.EnterpriseInvincible = GetHpPercentage(Mission.Enterprise)
		
-- RELEASE_LOGOFF  		AddWatch("Mission.JapBomberWaveNumber")
		
		SetSelectedUnit(Mission.Wildcat1)
		ForceRecon()
		local target = luaGetNearestEnemy(Mission.Wildcat1)
		if target then
			PilotSetTarget(Mission.Wildcat1, target)
		end
		UnitHoldFire(Mission.Wildcat1)
		SquadronSetTravelAlt(Mission.Wildcat1, GetPosition(Mission.Wildcat1).y - 25)
		--ForceEnableInput(IC_MAP_TOGGLE, false) -- map tiltas
		Mission.MissionPhase = 0 -- enginemovie hekk
	else
		Mission.MissionPhase = 666
	end
	EnableMessages(true)
end

function US01Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(Mission.Name.." mission is thinkin' in phase "..Mission.MissionPhase)
	
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." mission is terminated!")
		return
	end
	luaCheckMusic()
	--luaUS01CheckConditions(this)
	
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end
	local getsel = GetSelectedUnit()
	if getsel then
		if luaGetType(getsel) == "plane" then
			if GetSquadronLanded(getsel) then
				luaMissionFailedNew(GetSquadronLandedBase(getsel), "usn01.obj_failed_landed", nil, true)
				Mission.EndMission = true
			end
		end
	end
	
	luaUS01CheckEnterpriseDialogues()
	
-- MissionPhase 1
	if Mission.MissionPhase == 0 then
		Mission.MissionPhase = 1 -- anzsanmovie hekk
		luaDelay(luaUS01SaratogaNeedsStatus, 70)
		luaDelay(luaUS01InterceptHint, 60)
		--luaDelay(luaUS01BasicPlanehint2,30)
-- RELEASE_LOGOFF  		luaLog("zero")
		--SoundFade(1, "",0.1)
		Blackout(false, "", 3)
-- RELEASE_LOGOFF  		luaLog("Világos")
		--kezdeti repcsik setalt
		local initialJapPlanes = {FindEntity("Val 1"), FindEntity("Val 2")}
		for idx, unit in pairs(initialJapPlanes) do
			SquadronSetTravelAlt(unit, 700, true)
			SquadronSetAttackAlt(unit, 700, true)
			SquadronSetReleaseAlt(unit, 700, true)
		end
		
	elseif Mission.MissionPhase == 1 then
		Mission.MissionPhase = 2
		Mission.shiptable = {}
				
		Mission.AlliedPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)
		
		JoinFormation(Mission.Balch, Mission.Enterprise)
		JoinFormation(Mission.Maur, Mission.Enterprise)
		JoinFormation(Mission.Ellett, Mission.Enterprise)
		JoinFormation(Mission.Benham, Mission.Enterprise)
		
		JoinFormation(Mission.Farragut, Mission.Saratoga)
		JoinFormation(Mission.Worden, Mission.Saratoga)
		JoinFormation(Mission.MacDonough, Mission.Saratoga)
		JoinFormation(Mission.Dale, Mission.Saratoga)
		
		SetShipMaxSpeed(Mission.Enterprise, 5)
		NavigatorMoveOnPath(Mission.Enterprise, Mission.EnterprisePath)
		
		Mission.shiptable = luaGetShipsAround(Mission.Enterprise, 10000, "own")
		
		for idx,unit in pairs (Mission.shiptable) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		end
		
		Mission.WildcatsSpawned = 1
		Mission.JapBomberWaveNumber = 0
		luaUS01BombersSelectTarget()
		
		luaDelay(luaUS01FirstPrimaryObjective,10)
		AddListener("kill", "FirstPhaseKills", { -- 
			["callback"] = "luaUS01PlaneKilled",  -- callback fuggveny
			["entity"] = {},--Mission.FirstPhaseKillPlanes, -- entityk akiken a listener aktiv
			["lastAttacker"] = {Mission.Wildcat1},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
		AddProximityTrigger(Mission.Enterprise, "EnterpriseProximityID1", "luaUS01EnterpriseHit", luaGetPathPoint(Mission.EnterprisePath,"first"), 100)
		
		RepairEnable(Mission.Enterprise, false)
		
		luaDelay(luaUS01ProtectEnterprise, 7)
		luaDelay(luaUS01SpawnBomberWave, 20) -- first spawn
		--StartDialog("dlg_Protect_Enterprise",Mission.Dialogues["dlg_Protect_Enterprise"])
		
		--luaUS01GotoPhase3() -- CHEAT!!!
		
-- MissionPhase 2
	elseif Mission.MissionPhase == 2 then
		if (Mission.Wildcat1.Dead) then
			luaUS01Wildcat1Dead()
		end
		if (Mission.Wildcat2.Dead) then
			luaUS01Wildcat2Dead()
		end
		if Mission.RemainingPlanesToShoot < 1 then
			if IsListenerActive("kill", "FirstPhaseKills") then
				RemoveListener("kill", "FirstPhaseKills")
			end
			Mission.RemainingPlanesToShoot = 0
			if Mission.BomberSpawnDelay.Dead == false then
				DeleteScript(Mission.BomberSpawnDelay)
			end
			local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
			for idx, unit in pairs(japplanes) do
				PilotRetreat(unit)
			end
			luaDelay(luaUS01Movie01, 3)
			Mission.MissionPhase = 666
		else
			luaUS01BombersSelectTarget()
			Mission.RemainingPlanesToShootScoreDisplay = Mission.RemainingPlanesToShoot
			if luaObj_IsActive("primary", 1) then
				if Mission.RemainingPlanesToShootScoreDisplay > 1 then
					DisplayScores(1,0,"usn01.obj_p1","usn01.obj_p1_counter")
				elseif Mission.RemainingPlanesToShootScoreDisplay == 1 then
					DisplayScores(1,0,"usn01.obj_p1","usn01.obj_p1_counter1")
				end
			end
		end

		
-- MissionPhase 3 -- escort to navpoint
	elseif Mission.MissionPhase == 3 then
		luaUS01RefreshAttackerPlaneTable()
		
-- RELEASE_LOGOFF  		luaLog("!!!fighter"..table.getn(Mission.FighterPlanes))
-- RELEASE_LOGOFF  		luaLog("!!!allied"..table.getn(Mission.AlliedPlanes))
-- RELEASE_LOGOFF  		luaLog("!!!bomber"..table.getn(Mission.BomberPlanes))
		
		Mission.squad = 0
		for idx, unit in pairs(Mission.BomberPlanes) do
			Mission.squad = Mission.squad + 1
		end
		DisplayScores(1,0,"usn01.obj_p2", "usn01.attackersremaining")
		
		if (table.getn(Mission.BomberPlanes) < Mission.BomberPlanesToSave + 2) then
			luaUS01StartDialog("dlg_Lost_a_lot_of_planes")
		end
		
		if (table.getn(Mission.BomberPlanes) < Mission.BomberPlanesToSave) then
			luaClearDialogs()
			luaMissionFailedNew(luaPickRnd(Mission.AlliedPlanes), "usn01.obj_p2_fail1", nil, true)
			luaObj_Failed("primary",2)
			Mission.EndMission = true
-- RELEASE_LOGOFF  			luaLog("elfogytak a bombázók")
			return
		end
		--[[
		if Mission.PlayerUnit.Dead then
			luaClearDialogs()
			Mission.AlliedPlanes = luaRemoveDeadsFromTable(Mission.AlliedPlanes)
			for idx, unit in pairs(Mission.AlliedPlanes) do
				PilotRetreat(unit)
			end
			luaObj_Failed("primary",2)
			Mission.EndMission = true
			luaMissionFailedNew(luaPickRnd(Mission.JapaneseAttackers), "usn01.obj_p2_fail2", nil, true)
			return
		end
		]]
		Mission.planesInPosition = 0
		Mission.farthest = 0
		for idx, unit in pairs (Mission.BomberPlanes) do
			local dist = luaGetDistance(Mission.NavEscort1, unit)
			if dist > Mission.farthest then
				Mission.farthest = dist
			end
			if dist < 800 then
				Mission.planesInPosition = Mission.planesInPosition + 1
			elseif dist < 1500 then
				luaUS01StartDialog("dlg_Almost_there")
			end
		end
		--[[ distance jelzés
		Mission.farthest = Mission.farthest /1000
		if GetMeasure() == "globals.mile" then
			Mission.farthest = Mission.farthest * 0.621371192
			Mission.farthest = math.floor(Mission.farthest)
			DisplayScores(2,0,"usn01.distance", "usn01.distancemiles")
		else
			Mission.farthest = math.floor(Mission.farthest)
			DisplayScores(2,0,"usn01.distance", "usn01.distancekm")
		end
		]]
		luaUS01ManageJapaneseAttackers()
		if Mission.planesInPosition == table.getn(Mission.BomberPlanes) then
			if IsListenerActive("kill", "EscortKillID") then
				RemoveListener("kill", "EscortKillID")
			end
			luaObj_Completed("primary", 2, true)
			HideScoreDisplay(1, 0)
			HideScoreDisplay(2, 0)
			Blackout(true, "luaUS01SaveCheckpoint", 2)
			Mission.MissionPhase = -1
		end
-- MissionPhase 4
	elseif Mission.MissionPhase == 4 then -- Sink Cargos
		Mission.JapaneseFleet = luaRemoveDeadsFromTable(Mission.JapaneseFleet)
		Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
		if (table.getn(Mission.BomberPlanes) == 0) then
			luaClearDialogsCallback()
			luaMissionFailedNew(luaPickRnd(Mission.AlliedPlanes), "usn01.obj_p3_fail1", nil, true)
			luaObj_Failed("primary", 3)
			Mission.EndMission = true
			return
		elseif table.getn(Mission.Cargoes) == 0 then	-- phase win
			CountdownCancel()
			HideUnitHP()
			Mission.MissionPhase = 666
			if IsListenerActive("input", "RetreatListenerID") then
				RemoveListener("input", "RetreatListenerID")
			end
			luaDelay(luaUS01CargoesSunk,3)
			return
		end
		if Mission.Ammolistener == true then
			if Mission.SelectedBomber.Dead == true then
				Mission.Ammolistener = false
			elseif (table.getn(GetPayloads(GetSquadronPlane(Mission.SelectedBomber,0))) == 0) and (table.getn(Mission.BomberPlanes) > 1) then	-- aTom Fix
				Mission.Ammolistener = false
				if Mission.FirstRetreatListenerAdded then
					if table.getn(Mission.BomberPlanes) < 2 then
						luaUS01LastPlaneAmmoListener()
					else
						luaUS01AddRetreatListener()
					end
				else
					luaUS01AddFirstRetreatListener()
				end
			end
		end
		Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
		PutRelTo(Mission.NavEscort1, Mission.JapaneseFleet[1], {["x"] = -3000, ["y"] = 400, ["z"] = 0})
		if table.getn(Mission.BomberPlanes) > 1 then
			for idx, unit in pairs(Mission.BomberPlanes) do
				if unit ~= GetSelectedUnit() then
					PilotMoveTo(unit, GetPosition(Mission.NavEscort1))
				end
			end
		end
	elseif Mission.MissionPhase == 5 then
		if not Mission.Ryujo.Dead then
			--US plane manager
			local enterprisePlaneNum, enterprisePlaneTable= luaGetSlotsAndSquads(Mission.Enterprise)
			local saratogaPlaneNum, saratogaPlaneTable= luaGetSlotsAndSquads(Mission.Saratoga)
			if enterprisePlaneNum < 4 and IsReadyToSendPlanes(Mission.Enterprise) then
				local planeTypes = {
									108, --dauntless
									113, --avenger					
									}
				local slotIndex = LaunchSquadron(Mission.Enterprise,luaPickRnd(planeTypes),3)
				local launchedAttacker = thisTable[tostring(GetProperty(Mission.Enterprise, "slots")[slotIndex].squadron)]
				SetRoleAvailable(launchedAttacker, EROLF_ALL, PLAYER_ANY)
				SquadronSetTravelAlt(launchedAttacker,150)
				SetSkillLevel(launchedAttacker, SKILL_STUN)
				Mission.CVScreen = luaRemoveDeadsFromTable(Mission.CVScreen)
				if table.getn(Mission.CVScreen) ~= 0 then
					local target = luaPickRnd(Mission.CVScreen)
					PilotSetTarget(launchedAttacker, target)
				else
					PilotMoveToRange(launchedAttacker, Mission.Ryujo)
				end
			end
			if saratogaPlaneNum < 2 and IsReadyToSendPlanes(Mission.Saratoga) then
				local slotIndex = LaunchSquadron(Mission.Saratoga,101,3)
				local launchedWildcat = thisTable[tostring(GetProperty(Mission.Saratoga, "slots")[slotIndex].squadron)]
				SetRoleAvailable(launchedWildcat, EROLF_ALL, PLAYER_AI)
				SquadronSetTravelAlt(launchedWildcat,150)
				SetSkillLevel(launchedWildcat, SKILL_STUN)
			end
			--Japan plane manager
			local ryujoPlaneNum, ryujoPlaneTable = luaGetSlotsAndSquads(Mission.Ryujo)
			if ryujoPlaneNum < 3 and IsReadyToSendPlanes(Mission.Ryujo) then
				local slotIndex = LaunchSquadron(Mission.Ryujo,150,3)
				local launchedZero = thisTable[tostring(GetProperty(Mission.Ryujo, "slots")[slotIndex].squadron)]
				SquadronSetTravelAlt(launchedZero,150)
				SetSkillLevel(launchedZero, SKILL_SPNORMAL)
				PilotMoveToRange(launchedZero, Mission.Enterprise)
			end
			if (GetSelectedUnit() == nil) or (table.getn(GetPayloads(GetSelectedUnit())) == 0) then
				ShowHint("USN01_Hint_Switch_unit")
			elseif IsHintActive("USN01_Hint_Switch_unit") then
				HideHint()
			end
			
			if (GetHpPercentage(Mission.Ryujo) < 0.3) and (Mission.Almostdoneflag == nil) then
				MissionNarrative("usn01.ryujoalmostsank")
				Mission.Almostdoneflag = true
			end
		end
	end
	
end

-- Mission functions

function luaUS01CargoesSunk()
	luaUS01StartDialog("dlg_Tanker_destroyed")
	HideHint()
end
function luaUS01CargoesCompleted()
	luaObj_Completed("primary", 3, true)	
	Blackout(true,"luaUS01PreparePhase5", 3)
end

function luaUS01PreparePhase5()
	-- remaining attacker from phase4
	local planes = luaGetOwnUnits("plane")
	for idx,unit in pairs(planes) do
		Kill(unit, true)
	end
	--Ryujo fleet generate
	Mission.Ryujo = GenerateObject("Ryujo")
	Mission.Tone = GenerateObject("Tone")
	Mission.Amatsukaze = GenerateObject("Amatsukaze")
	Mission.CVScreen = {Mission.Tone, Mission.Amatsukaze}
	Mission.JapaneseFleet = {Mission.Ryujo, Mission.Tone, Mission.Amatsukaze}
	JoinFormation(Mission.Tone, Mission.Ryujo)
	JoinFormation(Mission.Amatsukaze, Mission.Ryujo)
	
	AddListener("kill", "ListenerRyujoKill", { -- WildcatSurvive
		["callback"] = "luaUS01RyujoKilled",  -- callback fuggveny
		["entity"] = {Mission.Ryujo},--Mission.FirstPhaseKillPlanes, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})

	AddListener("kill", "ListenerEnterpriseKill", { -- WildcatSurvive
		["callback"] = "luaUS01EnterpriseDead",  -- callback fuggveny
		["entity"] = {Mission.Enterprise},--Mission.FirstPhaseKillPlanes, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	
	AddListener("hit", "RyujoHitID", {
		["callback"] = "luaUS01JapFleetHit",	-- callback fv
		["target"] = Mission.JapaneseFleet,	-- kit bántottunk
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMBPLATFORM","TORPEDO"},	-- bombával vagy torpillével
		["attackerPlayerIndex"] = {},	-- sk
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	Mission.Phase5PlaneTemplates = {"Phase5_Avenger 01", "Phase5_Avenger 02", "Phase5_Avenger 03", "Phase5_Avenger 04"}
	
	--US attacker planes generate
	for idx,unit in pairs(Mission.Phase5PlaneTemplates) do
		local generatedPlane = GenerateObject(unit)
		if idx == 1 then
			Mission.FirstAvenger = generatedPlane
			PilotSetTarget(Mission.FirstAvenger, Mission.Ryujo)
		else
			PilotSetTarget(generatedPlane, Mission.Tone)
		end
	end
	
	SetInvincible(Mission.Enterprise, 0)
	NavigatorAttackMove(Mission.Ryujo, Mission.Enterprise)
	--SetShipMaxSpeed(Mission.Ryujo, 6)
	luaDelay(luaUS01RyujoAngry, 250)
	luaUS01_EM_Ryujo()
end

function luaUS01RyujoKilled()
	SetInvincible(Mission.Enterprise, GetHpPercentage(Mission.Enterprise))
	--luaDelay(luaUS01RyujoComplete,3)
	luaUS01StartDialog("dlg_Mission_completed")
	Mission.EndMission = true
	HideUnitHP(0)
	luaObj_Completed("primary", 4)
end

function luaUS01RyujoComplete()
	if luaObj_GetSuccess("secondary", 1) == true then
		Mission.CVScreen = luaRemoveDeadsFromTable(Mission.CVScreen)
		if table.getn(Mission.CVScreen) == 0 then
			luaObj_Completed("hidden", 1)
		end
	end
	luaMissionCompletedNew(Mission.Ryujo, "usn01.obj_p4_success", nil)
end

function luaUS01SpawnBomberWave()
	if Mission.EndMission then
		return
	end
	Mission.EnterpriseInvincible = math.max(0, Mission.EnterpriseInvincible - 0.05)
	if Mission.EnterpriseInvincible == 0 then
		RepairEnable(Mission.Enterprise, false)
		local USUnits = luaGetOwnUnits()
		for idx, unit in pairs(USUnits) do
			SetSkillLevel(unit, SKILL_STUN)
		end
	end
	SetInvincible(Mission.Enterprise, Mission.EnterpriseInvincible)
	Mission.JapBomberWaveNumber = Mission.JapBomberWaveNumber + 1
-- RELEASE_LOGOFF  	luaLog("Spawning bomber wave"..Mission.JapBomberWaveNumber)
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		
		--[[{
			["Type"] = 158,
			["Name"] = "Val2 "..Mission.JapBomberWaveNumber,
			["Equipment"] = 1,
		},]]
		{
			["Type"] = 162,
			["Name"] = "Kate1 "..Mission.JapBomberWaveNumber,
			["Equipment"] = 1,
		},
		{
			["Type"] = 158,
			["Name"] = "Val1 "..Mission.JapBomberWaveNumber,
			["Equipment"] = 1,
		},
		--[[{
			["Type"] = 162,
			["Name"] = "Kate2 "..Mission.JapBomberWaveNumber,
			["Equipment"] = 1,
		},
		{
			["Type"] = 162,
			["Name"] = "Kate3 "..Mission.JapBomberWaveNumber,
			["Equipment"] = 1,
		},]]
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.NavJapSpawn),
		["angleRange"] = { -1, 1},
		["lookAt"] = GetPosition(Mission.Enterprise),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 300,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 90,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 300,
	},
	["callback"] = "luaUS01RefreshBomberTable",
})
	if (Mission.JapBomberWaveNumber > 1) and (Mission.RemainingPlanesToShoot > 5) then
		Mission.HintCounter = Mission.HintCounter + 1
		if math.mod(Mission.HintCounter, 2) == 1 then
			ShowHint("USN01_Hint_Shoot_Please")
		else
			ShowHint("USN01_Hint_Aiming")
		end
	end
end

function luaUS01RefreshBomberTable(...)
	if Mission.MissionPhase ~= 2 then
		for i = 1,arg.n do
			Kill(arg[i], true)
		end
		return
	end
	if Mission.EndMission then
		return
	end
	for idx = 1, table.getn(arg) do
		table.insert(Mission.JapBomberWave, arg[idx])
		if arg[idx].Class.ShortName == "Kate" then
			--luaLog("Set speed:"..arg[idx].Name)
			--SquadronSetSpeed(arg[idx], arg[idx].Class.MaxSpd / 2)
		else
			SquadronSetTravelAlt(arg[idx], 700, true)
			SquadronSetAttackAlt(arg[idx], 700, true)
			SquadronSetReleaseAlt(arg[idx], 700, true)
		end
	end
	if luaObj_IsActive("primary", 1) and not luaObj_GetSuccess("primary", 1) then
		for i=1,arg.n do
			luaObj_AddUnit("primary", 1, arg[i])
		end
-- RELEASE_LOGOFF  		luaLog("Next spawn in "..Mission.JapBomberWaveTime)
		Mission.BomberSpawnDelay = luaDelay(luaUS01SpawnBomberWave, Mission.JapBomberWaveTime)
	else
		for i=1,arg.n do
			Kill(arg[i],true)
		end
	end
	
	if IsListenerActive("kill", "FirstPhaseKills") then
		RemoveListener("kill", "FirstPhaseKills")
	end
	if IsListenerActive("hit", "HitID") then
		RemoveListener("hit", "HitID")
	end
	
	--[[
	Mission.FirstPhaseKillPlanes = luaRemoveDeadsFromTable(Mission.FirstPhaseKillPlanes)
	for i = 1, arg.n do
		local squad = GetSquadronPlanes(arg[i])
		for idx, unit in pairs(squad) do
			table.insert(Mission.FirstPhaseKillPlanes, thisTable[tostring(unit)])
		end
	end
	]]
	if Mission.Wildcat1.Dead == false then
		AddListener("kill", "FirstPhaseKills", { -- WildcatSurvive
			["callback"] = "luaUS01PlaneKilled",  -- callback fuggveny
			["entity"] = {},--Mission.FirstPhaseKillPlanes, -- entityk akiken a listener aktiv
			["lastAttacker"] = {Mission.Wildcat1},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	end
end
function luaUS01PlaneKilled(...)
	if luaObj_IsActive("primary", 1) then
-- RELEASE_LOGOFF  		luaLog(arg[1].Type)
		if (not arg[1].Type) or (arg[1].Type == "PLANESQUADRON") or (arg[1].Party ~= PARTY_JAPANESE) then
			return
		end
		Mission.RemainingPlanesToShoot = Mission.RemainingPlanesToShoot - 1
		if Mission.RemainingPlanesToShoot == 0 then
			RemoveListener("kill", "FirstPhaseKills")
			luaObj_Completed("primary", 1, true)
			MissionNarrative("usn01.obj_p1_success")
			HideScoreDisplay(1,0)
			HideUnitHP()
			SetInvincible(Mission.Enterprise, GetHpPercentage(Mission.Enterprise))
			RepairEnable(Mission.Enterprise, true)
		elseif Mission.RemainingPlanesToShoot == 1 then
			MissionNarrative("usn01.onemore")
		elseif Mission.RemainingPlanesToShoot == 5 then
			MissionNarrative("usn01.fivemore")
		--[[
		elseif Mission.RemainingPlanesToShoot == 3 then
			MissionNarrativeEnqueue("missionglobals.newpowerup")
			AddPowerup({
				["classID"] = "evasive_manoeuvre",
				["useLimit"] = 1,
			})
		]]
		end
	end
end

function luaUS01BombersSelectTarget()
	Mission.JapBomberWave = luaRemoveDeadsFromTable(Mission.JapBomberWave)
	for idx,unit in pairs (Mission.JapBomberWave) do
		if unit.Dead == false then
			if unit.Class.ShortName ~= "Oscar" then 
				PilotSetTarget(unit, Mission.Enterprise)
			else
				if GetSelectedUnit() ~= nil then
					PilotSetTarget(unit, GetSelectedUnit())
				else
					PilotMoveTo(unit, Mission.Enterprise)
				end
			end
		end
	end
end

function luaUS01EnterpriseDead()
-- RELEASE_LOGOFF  	luaLog("Enterprise died")
	Mission.EndMission = true
	if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil then
		--Enterprise sunk in the first phase
		luaObj_Failed("primary", 1)
	elseif luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
		--Enterprise sunk in the last phase
		HideUnitHP(0)
		luaObj_Failed("primary", 4)
	end
	luaClearDialogsCallback()
	luaMissionFailedNew(Mission.Enterprise, "usn01.obj_p1_fail1", nil, true)
end

function luaUS01Wildcat1Dead()
-- RELEASE_LOGOFF  	luaLog("Wildcat 1 died")
	luaUS01GiveNewWildcat(1)
end
function luaUS01Wildcat2Dead()
-- RELEASE_LOGOFF  	luaLog("Wildcat 2 died")
	luaUS01GiveNewWildcat(2)
end

function luaUS01GiveNewWildcat(id)
-- RELEASE_LOGOFF  	luaLog("New Wildcat "..id)
	Mission.WildcatsSpawned = Mission.WildcatsSpawned + 1
	local wildcat = {}
	if id == 1 then
		Mission.Wildcat1 = LaunchAirBaseSlot(Mission.Saratoga, 1, true)
		SetRoleAvailable(Mission.Wildcat1, EROLF_ALL, PLAYER_ANY)
		wildcat = Mission.Wildcat1
	else
		Mission.Wildcat2 = LaunchAirBaseSlot(Mission.Saratoga, 2, true)
		SetRoleAvailable(Mission.Wildcat2, EROLF_ALL, PLAYER_AI)
		wildcat = Mission.Wildcat2
	end
	
	SquadronSetTravelAlt(wildcat, 400)
	SetSkillLevel(wildcat, SKILL_SPVETERAN)
	local nearenemy = luaGetNearestEnemy(wildcat)
	if nearenemy then
		EntityTurnToEntity(wildcat, nearenemy)
	end
	
	if (id == 1) and (Mission.RemainingPlanesToShoot > 1) then
		SetSelectedUnit(Mission.Wildcat1)
		luaIngameMovie({
			{["postype"] = "cameraandtarget", ["position"]= {}, ["moveTime"] = 3},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Wildcat1, ["distance"] = 250, ["theta"] = -26, ["rho"] = 198, ["moveTime"] = 0, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
			{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.Wildcat1.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},["moveTime"] = 5},
		{["postype"] = "cameraandtarget", ["moveTime"] = 1},
		},
		luaUS01SetSelectedWildcat
		)
		if IsListenerActive("kill", "FirstPhaseKills") then
			RemoveListener("kill", "FirstPhaseKills")
			AddListener("kill", "FirstPhaseKills", { -- 
				["callback"] = "luaUS01PlaneKilled",  -- callback fuggveny
				["entity"] = {},	-- entityk akiken a listener aktiv
				["lastAttacker"] = {Mission.Wildcat1},  -- tamado entitas, vagy entitasok
				["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			})
		end
	end
end
function luaUS01SetSelectedWildcat()
	SetSelectedUnit(Mission.Wildcat1)
	EnableInput(true)
end

function luaUS01RefreshAttackerPlaneTable()
	luaUS01RefreshUSPlaneTables()
	
	for idx,unit in pairs (Mission.BomberPlanes) do
		PilotMoveTo(unit, Mission.NavEscort1)
		SquadronSetTravelSpeed(unit, 40)
-- RELEASE_LOGOFF  		luaLog("Unit "..unit.Class.ShortName.." is on the way")	
	end
end
function luaUS01RefreshUSPlaneTables()
	Mission.AlliedPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)
	Mission.FighterPlanes = {}
	Mission.BomberPlanes = {}
	
	for idx, unit in pairs(Mission.AlliedPlanes) do
		if unit.Class.Type == "Fighter" then
			table.insert(Mission.FighterPlanes,unit)
		else
			table.insert(Mission.BomberPlanes,unit)
		end
	end
	
-- RELEASE_LOGOFF  	luaLog("Fighters: "..table.getn(Mission.FighterPlanes))
-- RELEASE_LOGOFF  	luaLog("Bombers: "..table.getn(Mission.BomberPlanes))
	
end
function luaUS01GenerateEscortPlanes(relativeto)
	Mission.planestogenerate = { "Wildcat 01", "Wildcat 02", "Wildcat 03", "TBF Avenger 01", "TBF Avenger 02", "TBF Avenger 03", "TBF Avenger 04",
	"SDB Dauntless 01", "SDB Dauntless 02", "SDB Dauntless 03", "SDB Dauntless 04"
	}
	for idx, unit in pairs(Mission.planestogenerate) do
		Mission.planestogenerate[idx] = GenerateObject(unit)
	end
	
	local originalpos = GetPosition(Mission.planestogenerate[1])
	local moveto = GetPosition(relativeto)
	moveto.x = moveto.x - originalpos.x
	moveto.z = moveto.z - originalpos.z
	local navpoint = GetPosition(Mission.NavEscort1)
	navpoint.z = navpoint.z + 1000
	for idx, unit in pairs(Mission.planestogenerate) do
		local pos = GetPosition(unit)
		pos.x = pos.x + moveto.x
		pos.z = pos.z + moveto.z
		PutTo(unit, pos)
		EntityTurnToPosition(unit, navpoint)
	end
	luaUS01RefreshAttackerPlaneTable()
	for idx,unit in pairs (Mission.BomberPlanes) do
-- RELEASE_LOGOFF  		luaLog("Bomber:"..unit.Name)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		UnitHoldFire(unit)
		SquadronSetBaseUnsupported(unit, Mission.Saratoga)
		SquadronSetBaseUnsupported(unit, Mission.Enterprise)
		SquadronSetAIRetreatEnabled(unit, false)
		SetForcedReconLevel(unit, 2,PARTY_JAPANESE)
	end
	if Mission.CheckpointLoaded ~= 1 then
-- RELEASE_LOGOFF  		luaLog("OSZKAR 1 *******************************************")
		local spawnpos = GetPosition(Mission.NavJapSpawn)
		spawnpos.z = spawnpos.z - 1000
		
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = 154, --Oscar
					["Name"] = "Oscar 1",
				},
			},
			["area"] = {
				["refPos"] = spawnpos,
				["angleRange"] = { -1, 1},
				["lookAt"] = GetPosition(Mission.Enterprise),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 1000,
				["ownVertical"] = 50,
				["enemyVertical"] = 1000,
				["formationHorizontal"] = 500,
			},
			--["callback"] = "luaUS01FirstJapaneseFighterSpawn",
		})
		ForceRecon()
		luaDelay(luaUS01FirstJapaneseFighterSpawn, 5)
	end
	luaUS01RefreshAttackerPlaneTable()
end
function luaUS01FirstJapaneseFighterSpawn()
	local oszi = FindEntity("Oscar 1")
	AddListener("recon", "JapFighterReconlistenerID", {
		["callback"] = "luaUS01Under_attack",  -- callback fuggveny
		["entity"] = {oszi}, -- entityk akiken a listener aktiv
		["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = { PARTY_ALLIED },
		})
	local nearenemy = GetSelectedUnit()
	if nearenemy == nil then
		nearenemy = luaPickRnd(Mission.BomberPlanes)
	end
	if nearenemy then
-- RELEASE_LOGOFF  		luaLog(oszi.Name.." is going to attack "..nearenemy.Name)
		PilotSetTarget(oszi, nearenemy)
	end
	UnitFreeFire(oszi)
end
function luaUS01EscortRespawn()
-- RELEASE_LOGOFF  	luaLog("luaUS01EscortRespawn")
	if IsListenerActive("kill", "EscortKillID") then
		RemoveListener("kill", "EscortKillID")
	end
	if Mission.EndMission == true then
		return
	end
	Mission.PlayerUnit = GenerateObject("Wildcat")
	PutRelTo(Mission.PlayerUnit, Mission.BomberPlanes[1], {["x"] = 300, ["y"] = 100, ["z"] = -700})
	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_ANY)
	EntityTurnToPosition(Mission.PlayerUnit, GetPosition(Mission.NavEscort1))
	PilotMoveTo(Mission.PlayerUnit, Mission.NavEscort1)
	SquadronSetTravelAlt(Mission.PlayerUnit, GetPosition(Mission.PlayerUnit).y)
	luaIngameMovie({
	{["postype"] = "target", ["target"] = Mission.PlayerUnit, ["position"]= {}, ["moveTime"] = 3},
	{["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 1000, ["theta"] = 16, ["rho"] = 189, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.PlayerUnit.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},["moveTime"] = 5},
	{["postype"] = "cameraandtarget", ["moveTime"] = 1},
	},
	luaUS01EscortRespawnCallback
	)
-- RELEASE_LOGOFF  	luaLog("luaUS01EscortRespawn movie started")
end
function luaUS01EscortRespawnCallback()
-- RELEASE_LOGOFF  	luaLog("luaUS01EscortRespawnCallback")
	SetSelectedUnit(Mission.PlayerUnit)
	EnableInput(true)
	AddListener("kill", "EscortKillID", { 
		["callback"] = "luaUS01EscortRespawn",  -- callback fuggveny
		["entity"] = {Mission.PlayerUnit}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
-- RELEASE_LOGOFF  	luaLog("luaUS01EscortRespawnCallback done")
end

function luaUS01Under_attack()
	luaUS01StartDialog("dlg_Under_attack")
	RemoveListener("recon", "JapFighterReconlistenerID")
end
function luaUS01GotoPhase3()
-- RELEASE_LOGOFF  	luaLog("Phase 3 is coming")
	Mission.MissionPhase = 666 -- phase completed
	HideScoreDisplay(1, 0)
	Scoring_RealPlayTimeRunning(true)
	if IsListenerActive("kill", "FirstPhaseKills") then
		RemoveListener("kill", "FirstPhaseKills")
	end
	HideUnitHP()
	Blackout(true, "", 0)
-- RELEASE_LOGOFF  	luaLog("Sötét")
	
	for idx,unit in pairs(luaGetOwnUnits("plane", PARTY_JAPANESE)) do
		Kill(unit, true)
	end
	for idx,unit in pairs(luaGetOwnUnits("plane"), PARTY_ALLIED) do
		Kill(unit, true)
	end
	if IsListenerActive("kill","EnterpriseKillID")then
		RemoveListener("kill", "EnterpriseKillID")
-- RELEASE_LOGOFF  		luaLog("Enterprise listener removed")
	end
	luaUS01GenerateEscortPlanes(Mission.Saratoga)
	luaDelay(luaUS01GotoPhase3_1, 0.5)
end
function luaUS01GotoPhase3_1()
	luaUS01SpawnJapAttackers()
	GenerateObject("HiddenOscar 01")
	GenerateObject("HiddenOscar 02")
	luaDelay(luaUS01SecondPrimaryObjective, 6)
	luaDelay(luaUS01TurboHint, 10)
	luaDelay(luaUS01WaspMessage, 47)
	
	luaUS01RefreshUSPlaneTables()
	for idx,unit in pairs (Mission.FighterPlanes) do
		PilotMoveTo(unit, Mission.NavEscort1)
		SquadronSetTravelAlt(unit, GetPosition(unit).y)
		SquadronSetTravelSpeed(unit, 40)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetForcedReconLevel(unit, 2,PARTY_JAPANESE)
-- RELEASE_LOGOFF  		luaLog("Unit "..unit.Name.." is on the way")	
	end
	--Mission.PlayerUnit = Mission.FighterPlanes[1]
	Mission.PlayerUnit = FindEntity("Wildcat 01")
	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_ANY)
	EntityTurnToPosition(Mission.PlayerUnit, GetPosition(Mission.NavJapSpawn))
	AddListener("kill", "EscortKillID", { 
		["callback"] = "luaUS01EscortRespawn",  -- callback fuggveny
		["entity"] = {Mission.PlayerUnit}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	
-- RELEASE_LOGOFF  	luaLog(Mission.PlayerUnit.Name)
	SetSelectedUnit(Mission.PlayerUnit)	
	EnableInput(true)
	Blackout(false, "", 3)
	Mission.MissionPhase = 3
end

function luaUS01GotoPhase4()
-- RELEASE_LOGOFF  	luaLog("Going to phase 4")
	Mission.EndMission = false
	AddListener("kill", "BomberKillID", {
		["callback"] = "luaUS01FirstDiveBomberRetreats",  -- callback fuggveny
		["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	Mission.Ammolistener = true
	AddListener("exitzone", "CargoesExitID", { 
		["callback"] = "luaUS01CargoesExited",  -- callback fuggveny
		["entity"] = Mission.Cargoes, -- entityk akiken a listener aktiv
		["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	AddListener("kill", "SecondaryKilledID", { 
		["callback"] = "luaUS01CheckSecondary",  -- callback fuggveny
		["entity"] = Mission.SecondaryTargets, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})	

	luaObj_Add("primary", 3, Mission.Cargoes)
	Mission.MissionPhase = 4
	Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
	luaObj_Add("secondary", 1, Mission.SecondaryTargets)
	luaDelay(luaUS01StrafeHint, 25)
	Mission.AlliedPlanes = luaRemoveDeadsFromTable(Mission.AlliedPlanes)
	Mission.JapaneseFleet = luaRemoveDeadsFromTable(Mission.JapaneseFleet)
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
	Mission.FighterPlanes = luaRemoveDeadsFromTable(Mission.FighterPlanes)
	for idx,unit in pairs(Mission.FighterPlanes) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		PilotLand(unit, Mission.Saratoga)
	end
	for idx,unit in pairs(Mission.BomberPlanes) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		SetInvincible(unit, 0.5)
	end
	SetRoleAvailable(Mission.SelectedBomber, EROLF_ALL, PLAYER_ANY)
	SetSelectedUnit(Mission.SelectedBomber)
	local target = luaGetNearestEnemy(Mission.SelectedBomber)
	if target then
		PilotMoveTo(Mission.SelectedBomber, target)
-- RELEASE_LOGOFF  		luaLog(target.Name.." attacked by "..Mission.SelectedBomber.Name)
	end
	luaDelay(luaUS01DisplayCargoesHP, 3)
	for idx, unit in pairs(Mission.Cargoes) do
		SetInvincible(unit, 0)
	end
end
function luaUS01ShowTorpedoHint()
	if Mission.Ammolistener == true then
		ShowHint("USN01_Hint_Torpedo")
	end
end
function luaUS01FirstDiveBomberRetreats()
-- RELEASE_LOGOFF  	luaLog("luaUS01FirstDiveBomberRetreats")
	if IsListenerActive("input", "RetreatListenerID") then
		RemoveListener("input", "RetreatListenerID")
	end
	RemoveListener("kill", "BomberKillID")
	HideHint()
	luaUS01RemovePlaneFromTable()
	Mission.JapaneseFleet = luaRemoveDeadsFromTable(Mission.JapaneseFleet)
	local sel = GetSelectedUnit()
	if sel then
		SetInvincible(sel, 0)
	end
	for idx, unit in pairs(Mission.BomberPlanes) do
		if unit.Class.Type == "TorpedoBomber" then
			-- aTom Fix
-- RELEASE_LOGOFF  			luaLog("SelectedUnit = "..unit.Name)
			-- aTom Fix end
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
			Mission.SelectedBomber = unit
			-- aTom Fix
-- RELEASE_LOGOFF  			luaLog("SelectedBomber = "..Mission.SelectedBomber.Name)
			-- aTom Fix end
			Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
			if table.getn(Mission.Cargoes) ~= 0 then
				PilotSetTarget(Mission.SelectedBomber, Mission.Cargoes[1])
			end
			break
		end
	end
	luaIngameMovie({
	{["postype"] = "cameraandtarget", ["position"]= {}, ["moveTime"] = 1},
	{["postype"] = "cameraandtarget", ["target"] = Mission.SelectedBomber, ["distance"] = 1000, ["theta"] = 16, ["rho"] = 189, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.SelectedBomber.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},["moveTime"] = 3},
	{["postype"] = "cameraandtarget", ["moveTime"] = 1},
	},
	luaUS01FirstDiveBomberRetreatsCallback
	)
end
function luaUS01FirstDiveBomberRetreatsCallback()
	EnableInput(true)
	SetSelectedUnit(Mission.SelectedBomber)
	local target = luaGetNearestEnemy(Mission.SelectedBomber)
	if target then
		PilotMoveTo(Mission.SelectedBomber, target)
-- RELEASE_LOGOFF  		luaLog(target.Name.." attacked by "..Mission.SelectedBomber.Name)
	end
	
	AddListener("kill", "BomberKillID", { 
		["callback"] = "luaUS01GiveNextPlane",  -- callback fuggveny
		["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	--[[
	AddListener("ammoType", "BomberAmmoID", {
		["callback"] = "luaUS01AddRetreatListener",  -- callback fuggveny
		["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv 
		["ammoType"] = {0}, -- 0-none, 1-bomb, 2-torpedo, 3-dc, 4-rocket
	})
	]]
	Mission.Ammolistener = true
	luaDelay(luaUS01ShowTorpedoHint, 5)
end
function luaUS01AddFirstRetreatListener()
-- RELEASE_LOGOFF  	luaLog("luaUS01AddFirstRetreatListener")
	HideHint()
	ShowHint("USN01_Hint_Switch_unit")
	AddListener("input", "RetreatListenerID", {
		["callback"] = "luaUS01FirstDiveBomberRetreats",  -- callback fuggveny
		["inputID"] = {IC_SEL_NEXT_ITEM, IC_SEL_PREV_ITEM}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	Mission.FirstRetreatListenerAdded = true
end
function luaUS01AddRetreatListener()
-- RELEASE_LOGOFF  	luaLog("luaUS01AddRetreatListener")
	HideHint()	
	ShowHint("USN01_Hint_Switch_unit")
	-- aTom Fix
	if (IsListenerActive("input", "RetreatListenerID")) then
		RemoveListener("input", "RetreatListenerID")
	end
	-- aTom Fix end
	AddListener("input", "RetreatListenerID", {
		["callback"] = "luaUS01GiveNextPlane",  -- callback fuggveny
		["inputID"] = {IC_SEL_NEXT_ITEM, IC_SEL_PREV_ITEM}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
end
function luaUS01GiveNextPlane()
-- RELEASE_LOGOFF  	luaLog("luaUS01GiveNextPlane")
	HideHint()
	if IsListenerActive("input", "RetreatListenerID") then
		RemoveListener("input", "RetreatListenerID")
	end
	RemoveListener("kill", "BomberKillID")
	luaUS01RemovePlaneFromTable()
	if Mission.SelectedBomber.Dead == false then
		SetInvincible(Mission.SelectedBomber, 0.5)
	end
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
	Mission.SelectedBomber = Mission.BomberPlanes[1]
	Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
	if table.getn(Mission.Cargoes) == 0 then
		return
	end
	if table.getn(Mission.BomberPlanes) == 0 then
		luaUS01CountdownExpired()
		return
	end
	local y = GetPosition(Mission.SelectedBomber).y
	SquadronSetTravelAlt(Mission.SelectedBomber, y)
	if Mission.SelectedBomber.Type == "DiveBomber" then
			SquadronSetAttackAlt(Mission.SelectedBomber, y)
	end
	luaDelay(luaUS01GiveNextPlaneMovie, 1.5)
end
function luaUS01ShowBombcameraHint()
	ShowHint("Advanced_Hint_Bombcamera")
end
function luaUS01GiveNextPlaneMovie()
	if Mission.EndMission == false then
	local target = luaGetNearestEnemy(Mission.SelectedBomber)
	if target then
		PilotMoveTo(Mission.SelectedBomber, target)
-- RELEASE_LOGOFF  		luaLog(target.Name.." attacked by "..Mission.SelectedBomber.Name)
	end
	luaIngameMovie({
	{["postype"] = "target", ["target"] = Mission.SelectedBomber, ["moveTime"] = 2},
	{["postype"] = "cameraandtarget", ["target"] = Mission.SelectedBomber, ["distance"] = 1000, ["theta"] = 16, ["rho"] = 189, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.SelectedBomber.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},
		["moveTime"] = 3
	},
	{["postype"] = "cameraandtarget", ["moveTime"] = 1},
	},
	luaUS01GiveNextPlaneCallback
	)
	end
end
function luaUS01GiveNextPlaneCallback()
	EnableInput(true)
-- RELEASE_LOGOFF  	luaLog("luaUS01GiveNextPlaneCallback")
	SetRoleAvailable(Mission.SelectedBomber, EROLF_ALL, PLAYER_ANY)
	SetSelectedUnit(Mission.SelectedBomber)
	SetInvincible(Mission.SelectedBomber, 0)
	
	if table.getn(Mission.BomberPlanes) == 1 then -- this is the last plane
		--[[
		AddListener("ammoType", "BomberAmmoID", { 
			["callback"] = "luaUS01LastPlaneAmmoListener",  -- callback fuggveny
			["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv 
			["ammoType"] = {0}, -- 0-none, 1-bomb, 2-torpedo, 3-dc, 4-rocket
		})
		]]
		Mission.Ammolistener = true
		AddListener("kill", "BomberKillID", { 
			["callback"] = "luaUS01OutOfPlanes",  -- callback fuggveny
			["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
		MissionNarrative("usn01.lastplane")
-- RELEASE_LOGOFF  		luaLog("Last Plane")
	else -- not the last plane
		--[[
		AddListener("ammoType", "BomberAmmoID", { 
				["callback"] = "luaUS01AddRetreatListener",  -- callback fuggveny
				["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv 
				["ammoType"] = {0}, -- 0-none, 1-bomb, 2-torpedo, 3-dc, 4-rocket
			})
		]]
		Mission.Ammolistener = true
		AddListener("kill", "BomberKillID", { 
			["callback"] = "luaUS01GiveNextPlane",  -- callback fuggveny
			["entity"] = {Mission.SelectedBomber}, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	end
end
function luaUS01LastPlaneAmmoListener()	
	if Mission.SelectedBomber.Type == "TorpedoBomber" then
		Countdown("usn01.counter", 0, 30, "luaUS01CountdownExpired")
	else
		Countdown("usn01.counter", 0, 15, "luaUS01CountdownExpired")
	end
end
function luaUS01CountdownExpired()
	HideHint()
	if IsListenerActive("input", "RetreatListenerID") then
		RemoveListener("input", "RetreatListenerID")
	end
	if IsListenerActive("kill", "BomberKillID") then
		RemoveListener("kill", "BomberKillID")
	end
	if luaObj_GetSuccess("primary", 3) == nil then
		luaMissionFailedNew(Mission.JapaneseFleet[1], "usn01.obj_p3_fail1", nil, true)
		Mission.EndMission = true
	end
end
function luaUS01OutOfPlanes()
	if CountdownTimeLeft() ~= 0 then
		CountdownCancel()
	end
	HideHint()
	if IsListenerActive("input", "RetreatListenerID") then
		RemoveListener("input", "RetreatListenerID")
	end
	RemoveListener("kill", "BomberKillID")
	luaMissionFailedNew(Mission.JapaneseFleet[1], "usn01.obj_p3_fail1", nil, true)
	Mission.EndMission = true
end

function luaUS01DisplayCargoesHP()
	DisplayUnitHP(Mission.Cargoes, "usn01.obj_p3")
	luaDelay(luaUS01BombHint, 2)
end
function luaUS01RyujoAngry()
	if Mission.Ryujo.Dead == false then
		SetSkillLevel(Mission.Ryujo, SKILL_ELITE)
		if Mission.Enterprise.Dead == false then
			NavigatorAttackMove(Mission.Ryujo, Mission.Enterprise)
			RepairEnable(Mission.Enterprise, false)
		end
	end
end
function luaUS01BombHint()
	if Mission.Ammolistener == true then
		ShowHint("USN01_Hint_Bomb")
	end
end
function luaUS01JapFleetHit()
	RemoveListener("hit", "RyujoHitID")
	luaUS01StartDialog("dlg_Ryujo_hurt")
end
function luaUS01TurboHint()
	ShowHint("USN01_Hint_Turbo")
	AddListener("input", "turbolistenerID", {
		["callback"] = "luaUS01RemoveTurboHint",  -- callback fuggveny
		["inputID"] = {IC_PLANE_TURBO}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	ForceEnableInput(IC_MAP_TOGGLE, true) -- map tiltas
	luaDelay(luaUS01RemoveTurboHint2, 20)
end
function luaUS01RemoveTurboHint2()
	if IsHintActive("USN01_Hint_Turbo") then
		RemoveListener("input", "turbolistenerID")
		HideHint()
		luaDelay(luaUS01MapHint, 10)
	end	
end
function luaUS01RemoveTurboHint()
	RemoveListener("input", "turbolistenerID")
	HideHint()
	luaDelay(luaUS01MapHint, 10)
end
function luaUS01MapHint()
	if IsGUIActive("GUI_map") == false then
		ShowHint("USN01_Hint_Map")
		AddListener("input", "maplistenerID", {
			["callback"] = "luaUS01RemoveMapHint",  -- callback fuggveny
			["inputID"] = {IC_MAP_TOGGLE}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})
	end
	luaDelay(luaUS01RemoveMapHint2, 20)
end
function luaUS01RemoveMapHint2()
	if IsHintActive("USN01_Hint_Map") then
		RemoveListener("input", "maplistenerID")
		HideHint()
	end	
end
function luaUS01RemoveMapHint()
	RemoveListener("input", "maplistenerID")
	HideHint()
end
function luaUS01ManageJapaneseAttackers()
-- RELEASE_LOGOFF  	luaLog("Managing Japanese Attackers")
	Mission.JapaneseAttackers = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx, unit in pairs(Mission.JapaneseAttackers) do
		if (unit.Dead == false) and (UnitGetAttackTarget(unit) == nil) then
			local trg
			if Mission.JapEscortTargetSelect == 1 then
				trg = GetSelectedUnit()
				Mission.JapEscortTargetSelect = 0
			else
				trg = luaPickRnd(Mission.BomberPlanes)
				Mission.JapEscortTargetSelect = 1
			end
			--trg = luaPickRnd(Mission.BomberPlanes)
			if trg then
				PilotSetTarget(unit, trg)
			end
		end
	end
end

function luaUS01SpawnJapAttackers()
	local spawnpos = GetPosition(Mission.NavJapSpawn)
-- RELEASE_LOGOFF  	luaLog("Spawning Oscar")
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = 154, --Oscar
				["Name"] = "Oscar",
				["Skill"] = SKILL_SPNORMAL,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { -1, 1},
			["lookAt"] = GetPosition(Mission.Enterprise),
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 1000,
			["ownVertical"] = 50,
			["enemyVertical"] = 1000,
			["formationHorizontal"] = 500,
		},
		--["callback"] = "luaUS01RefreshAttackerPlaneTable",
	})
	if Mission.farthest > 1200 then
		Mission.SpawnJapDelay = luaDelay(luaUS01SpawnJapAttackers, Mission.JapAttackerSpawnDelay)
	end
end
function luaUS01CheckSecondary()
	Mission.SecondaryTargets = luaRemoveDeadsFromTable(Mission.SecondaryTargets)
-- RELEASE_LOGOFF  	luaLog("Secondary targets left:"..table.getn(Mission.SecondaryTargets))
	if table.getn(Mission.SecondaryTargets) == 0 then
		RemoveListener("kill", "SecondaryKilledID")
		luaObj_Completed("secondary", 1, true)
		--MissionNarrativeEnqueue("missionglobals.newpowerup")
		--[[
		AddPowerup({
			["classID"] = "evasive_manoeuvre",
			["useLimit"] = 1,
		})
		]]
	end
end
function luaUS01ProtectEnterprise()
	luaUS01StartDialog("dlg_Protect_Enterprise")
end
function luaUS01StrafeHint()
	ShowHint("USN01_Hint_Strafe")
end
function luaUS01CargoesExited()
	Mission.EndMission = true
	if (luaObj_IsActive("primary", 3)) and not luaObj_GetSuccess("primary", 3) then
		luaObj_Failed("primary", 3)
	end
	luaClearDialogsCallback()
	luaMissionFailedNew(luaPickRnd(Mission.AlliedPlanes), "usn01.obj_p3_fail2", nil, true)
	Mission.EndMission = true
end
function luaUS01StartDialog(dialogID)
	if Mission.EndMission ~= true then
		if (Mission.Dialogues[dialogID].printed == nil) then
			StartDialog(dialogID, Mission.Dialogues[dialogID])
			Mission.Dialogues[dialogID].printed = true
-- RELEASE_LOGOFF  			luaLog("Dialog started. ID: "..dialogID)
		end
	end
end
function luaUS01CheckEnterpriseDialogues()
--[[
	["dlg_Fires_Put_Out"]
	["dlg_Listing_Corrected"]
	["dlg_Hit_On_Enterprise"]
	["dlg_Almost_Hit_USS_Balch"]
	["dlg_5-10_sec_pause"]
	["dlg_Rudder_Jammed"]
	["dlg_Listing_Again"]
	["dlg_Enterprise_Manouverable"]
	]]
	if Mission.RemainingPlanesToShoot < 7 then
		luaUS01StartDialog("dlg_Fires_Put_Out")
	elseif Mission.RemainingPlanesToShoot < 4 then
		luaUS01StartDialog("dlg_Listing_Corrected")
	end
end
function luaUS01FirstPrimaryObjective()
	EnableMessages(true)
	luaDelay(luaUS01FirstPrimaryObjective2, 2.8)
end
function luaUS01FirstPrimaryObjective2()
	--DisplayUnitHP({Mission.Enterprise}, "USN01.obj_p1")
	luaObj_Add("primary", 1)
	local units = luaGetOwnUnits("plane", PARTY_JAPANESE)
	luaObj_AddUnit("primary", 1, units)
	luaDelay(luaUS01HintHint, 6)
end
function luaUS01HintHint()
	ShowHint("Advanced_Hint_Hinthistory")
end
function luaUS01SecondPrimaryObjective()
	luaObj_Add("primary",2,GetPosition(Mission.NavEscort1))
end
function luaUS01TargetHint()
	if GetTargetInfoTarget() == nil then -- no target yet
		ShowHint("USN01_Hint_Target")
		AddListener("input", "targetinputlistenerID", {
		["callback"] = "luaUS01HideTargetHint",  -- callback fuggveny
		["inputID"] = {IC_CMD_SETTARGET}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
	end
end
function luaUS01HideTargetHint()
	RemoveListener("input", "targetinputlistenerID")
	HideHint()
end
function luaUS01SaratogaNeedsStatus()
	luaUS01StartDialog("dlg_Saratoga_Needs_Status")
	luaDelay(luaUS01ScoutComesIn,80)
end
function luaUS01ScoutComesIn()
	if Mission.MissionPhase == 2 then
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 108, --Dauntless
				["Name"] = "Scout",
			},
		},
		["area"] = {
			["refPos"] = GetClosestBorderZone(GetPosition(Mission.Enterprise)),
			["angleRange"] = { -1, 1},
			["lookAt"] = GetPosition(Mission.Enterprise),
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 1000,
			["ownVertical"] = 50,
			["enemyVertical"] = 1000,
			["formationHorizontal"] = 500,
		},
		["callback"] = "luaUS01ScoutCameIn",
	})
	end
end
function luaUS01ScoutCameIn(unit)
	Mission.Scout = FindEntity("Scout")
	if Mission.MissionPhase == 2 then
		SetInvincible(Mission.Scout, 0.1)
		SetRoleAvailable(Mission.Scout, EROLF_ALL, PLAYER_AI)
		PilotMoveTo(Mission.Scout,Mission.Enterprise)
		UnitFreeAttack(Mission.Scout)
		Scoring_IgnoreEntityKill(Mission.Scout)
		luaUS01StartDialog("dlg_Scout_Plane")
	else
		Kill(Mission.Scout, true)
	end
end

function luaUS01EnterpriseHit()
-- RELEASE_LOGOFF  	luaLog("Enterprise hit")
	luaUS01StartDialog("dlg_Hit_On_Enterprise")
	luaDelay(luaUS01AlmostHitBalch,35)
	RemoveTrigger(Mission.Enterprise,"EnterpriseProximityID1")
----------------
end
function luaUS01AlmostHitBalch()
	luaUS01StartDialog("dlg_Almost_Hit_USS_Balch")
	NavigatorMoveToPos(Mission.Balch, GetPosition(Mission.NavJapSpawn))
	luaDelay(luaUS01GetBalchBack,100)
	luaDelay(luaUS01TurningRight,55)
	AddProximityTrigger(Mission.Enterprise, "EnterpriseProximityID2", "luaUS01RudderJammed", luaGetPathPoint(Mission.EnterprisePath,3), 300)
end
function luaUS01TurningRight()
	luaUS01StartDialog("dlg_5-10_sec_pause")
end
function luaUS01RudderJammed()
	luaUS01StartDialog("dlg_Rudder_Jammed")
	AddListener("hit", "EnterpriseHitID", {
		["callback"] = "luaUS01EnterpriseListing",	-- callback fv
		["target"] = {Mission.Enterprise},	-- kit bántottunk
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMBPLATFORM","TORPEDO"},	-- bombával vagy torpillével
		["attackerPlayerIndex"] = {},	-- player
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	luaDelay(luaUS01Manouverable,50)
end
function luaUS01Manouverable()
	luaUS01StartDialog("dlg_Enterprise_Manouverable")
	NavigatorMoveToPos(Mission.Enterprise, FindEntity("NavCar 01"))
	NavigatorMoveToPos(Mission.Saratoga, FindEntity("NavCar 02"))
end
function luaUS01EnterpriseListing()
	luaUS01StartDialog("dlg_Listing_Again")
	Mission.Listing = true
-- RELEASE_LOGOFF  	luaLog("Listing")
end
function luaUS01GetBalchBack()
	NavigatorMoveToRange(Mission.Balch, Mission.Enterprise)
	JoinFormation(Mission.Balch, Mission.Enterprise)
end
function luaUS01WaspMessage()
	luaUS01StartDialog("dlg_USS_Wasp")
end
function luaUS01InterceptHint()
	if Mission.MissionPhase == 2 then
		if table.getn(GetActDialogIDs()) == 0 then
			ShowHint("USN01_Hint_Intercept")
			luaDelay(luaUS01BombersHint, 20)
		else
			luaDelay(luaUS01InterceptHint, 2)
		end
	end
end
function luaUS01BombersHint()
	if Mission.MissionPhase == 2 then
		if table.getn(GetActDialogIDs()) == 0 then
			ShowHint("USN01_Hint_Priority")
		else
			luaDelay(luaUS01BombersHint, 2)
		end
	end
end

function luaUS01ShowAirHint()
	ShowHint("USN01_Hint_Checkpoint")
end
function luaUS01Movie01()
	if IsListenerActive("kill", "FirstPhaseKills") then
		RemoveListener("kill", "FirstPhaseKills")
	end
	EnableMessages(false)
	Mission.MissionPhase = 666
	RepairEnable(Mission.Enterprise, true)
	Scoring_RealPlayTimeRunning(false)
	Mission.camtrg1 = LaunchAirBaseSlot(Mission.Enterprise, 3, false)
	LaunchAirBaseSlot(Mission.Saratoga, 3, false)
	if Mission.Scout == nil then
		luaUS01ScoutComesIn()
	end
	SetInvincible(Mission.camtrg1, 1)
	Blackout(true, "luaUS01Movie01_1", 2)
	luaClearDialogs()
-- RELEASE_LOGOFF  	luaLog("Sötét")
end
function luaUS01Movie01_1()
	local plane = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx, unit in pairs(plane) do
		Kill(unit, true)
	end
	HideUnitHP()
	
	if Mission.Scout then
		PutRelTo(Mission.Scout, Mission.Enterprise, {["x"]= 100,["z"]= -50,["y"]=60}, 270)
		SquadronSetTravelAlt(Mission.Scout,120)
		PilotMoveTo(Mission.Scout, Mission.Saratoga)
	end
	StartDialog("dlg_EnterpriseTakeOff", Mission.Dialogues["dlg_EnterpriseTakeOff"])
	Blackout(false, "", 1.5)
-- RELEASE_LOGOFF  	luaLog("Világos")
	--[[
	luaCamOnTargetFree(Mission.Enterprise, 1, 2, 350, false, nil , 0, luaUS01Movie01_2)
	luaCamOnTargetFree(Mission.Enterprise, 15, 25, 250, false, nil , 5)
	luaCamOnTargetFree(Mission.camtrg1, 15, 70, 150, false, nil , 8)
	]]
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.Enterprise, ["distance"] = 350, ["theta"] = 1, ["rho"] = 2, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Enterprise, ["distance"] = 150, ["theta"] = 10, ["rho"] = 25, ["moveTime"] = 8, ["smoothtime"] = 2, ["nonlinearblend"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = Mission.camtrg1, ["distance"] = 80, ["theta"] = 5, ["rho"] = 100, ["moveTime"] = 3, ["smoothtime"] = 2, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.camtrg1, ["distance"] = 20, ["theta"] = 5, ["rho"] = 155, ["moveTime"] = 5, ["smoothtime"] = 2, ["nonlinearblend"] = 1},
	},
	luaUS01Movie01_end)
end
function luaUS01Movie01_end()
	luaUS01StartDialog("dlg_Attackerplanes_Need_Escort")
	luaDelay(luaUS01GotoPhase3,3)
	Blackout(true, "", 3)
-- RELEASE_LOGOFF  	luaLog("Sötét")
	BlackBars(false)
	EnableMessages(true)
end
function luaUS01BombersMovie_Start()
	Mission.MissionPhase = 666
	if Mission.SpawnJapDelay ~= nil then
		luaClearDelay(Mission.SpawnJapDelay)
	end
	Mission.FighterPlanes = luaRemoveDeadsFromTable(Mission.FighterPlanes)
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
	Mission.AlliedPlanes = luaRemoveDeadsFromTable(Mission.AlliedPlanes)
	HideScoreDisplay(1, 0)
	HideScoreDisplay(2, 0)
	for idx, unit in pairs(Mission.AlliedPlanes) do
		SquadronSetHomeBase(unit, Mission.Saratoga)
	end
	for idx, unit in pairs(Mission.FighterPlanes) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--SetInvincible(unit, random(4, 8)/10)
	end
	-- aTom Fix
	--[[for idx, unit in pairs(Mission.BomberPlanes) do
		if unit.Class.Type == "DiveBomber" then
			Mission.SelectedBomber = unit
			SetInvincible(Mission.SelectedBomber, 1)
			break
		end
	end]]--
	Mission.SelectedBomber = Mission.BomberPlanes[1]
	SetInvincible(Mission.SelectedBomber, 1)
	-- aTom Fix end
	Blackout(true,"luaUS01BombersMovie_Generate",1.5)
end
	
function luaUS01BombersMovie_Generate()
	Mission.TransportFormationTemplate = {"Cargo1", "Cargo2", "Cargo3", "Tokitsukaze"}
	for idx,unit in pairs(Mission.TransportFormationTemplate) do
		local generatedShip = GenerateObject(unit)
	end
	Mission.Tokitsukaze = FindEntity("Tokitsukaze")
	Mission.Cargo1 = FindEntity("Cargo1")
	Mission.Cargo2 = FindEntity("Cargo2")
	Mission.Cargo3 = FindEntity("Cargo3")
	Mission.Cargoes = {Mission.Cargo1, Mission.Cargo2, Mission.Cargo3}
	Mission.JapaneseFleet = {Mission.Tokitsukaze, Mission.Cargo1, Mission.Cargo2, Mission.Cargo3}
	Mission.SecondaryTargets = {Mission.Tokitsukaze}	
	for idx, unit in pairs(Mission.JapaneseFleet) do
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	luaUS01JoinFormations(Mission.JapaneseFleet)
	SetShipMaxSpeed(Mission.JapaneseFleet[1],6)
	NavigatorMoveOnPath(Mission.JapaneseFleet[1], FindEntity("Jappath"))
	if Mission.Difficulty == 2 then --hard
		SetSkillLevel(Mission.Tokitsukaze, SKILL_SPVETERAN)
	elseif Mission.Difficulty == 1 then
		SetSkillLevel(Mission.Tokitsukaze, SKILL_SPNORMAL)
	elseif Mission.Difficulty == 0 then
		SetSkillLevel(Mission.Tokitsukaze, SKILL_STUN)
	end
	luaDelay(luaUS01BombersMovie,0.5)
end

function luaUS01BombersMovie()
	luaIngameMovie(
	{
		{["postype"] = "camera", ["position"]={["parent"] = Mission.Cargoes[1], ["pos"] = {["x"] = 100, ["z"] = 140, ["y"] = 25 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "target", ["target"] = Mission.Cargoes[1], ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "target", ["target"] = Mission.Cargoes[1], ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "target", ["target"] = Mission.SelectedBomber, ["moveTime"] = 2, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.SelectedBomber, ["distance"] = 300, ["theta"] = -24, ["rho"] = 18, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.SelectedBomber, ["distance"] = 70, ["theta"] = -4, ["rho"] = 178, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.SelectedBomber.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},["moveTime"] = 3
		},
		{["postype"] = "cameraandtarget", ["moveTime"] = 1},
	},
	luaUS01BombersMovie_end)
	Blackout(false,"",1)
	luaUS01StartDialog("dlg_Arrived")
	PilotSetTarget(Mission.SelectedBomber, Mission.Cargoes[1])
	local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)	-- kill jap planes
	for idx, unit in pairs(japplanes) do
		Kill(unit, true)
	end
end
function luaUS01BombersMovie_end()
	SetInvincible(Mission.SelectedBomber, 0)
	AddListener("exitzone", "exitlistenerID", { 
		["callback"] = "luaUS01BomberExited",  -- callback fuggveny
		["entity"] = Mission.AlliedPlanes, -- entityk akiken a listener aktiv
		["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
	EnableInput(true)
	luaUS01GotoPhase4()
end
function luaUS01BomberExited()
	Mission.MissionPhase = 666
	luaMissionFailedNew(luaPickRnd(luaGetOwnUnits("ship", PARTY_JAPANESE)), "usn01.obj_failed_landed", nil, true)
end
function luaUS01_EM_Ryujo()
	Blackout(false, "", 2)
	luaIngameMovie(
		{
			{["postype"] = "camera", ["position"]={["parent"] = Mission.Ryujo, ["pos"] = {["x"] = 120, ["z"] = 170, ["y"] = 35 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			{["postype"] = "target", ["target"] = Mission.Ryujo, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			--[[
			{["postype"] = "target", ["target"] = Mission.Ryujo, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			]]
			{["postype"] = "cameraandtarget", ["target"] = Mission.Ryujo, ["distance"] = 150, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 10, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		},
		luaUS01_EM_Ryujo_End1)
	luaUS01StartDialog("dlg_Enemy_carrier_visual")
end

function luaUS01_EM_Ryujo_End1()
	Blackout(true,"luaUS01_EM_Ryujo_End2",1.5)
end

function luaUS01_EM_Ryujo_End2()
	Blackout(false,"",1.5)
	SetSelectedUnit(Mission.FirstAvenger)
	EnableInput(true)
	luaDelay(luaUS01RyujoAdd,3)
end

function luaUS01RyujoAdd()
	Mission.MissionPhase = 5
	luaObj_Add("primary", 4, Mission.Ryujo)
	DisplayUnitHP({Mission.Ryujo},"usn01.obj_p4")
	luaDelay(luaUS01ShowBombcameraHint, 14)
end


function logDead()
	for idx, plane in pairs (Mission.BomberPlanes) do
		local szName = plane.Name
		if (plane.dead) then
			szName = szName.." -> dead"
		else
			szName = szName.." -> not dead"
		end
-- RELEASE_LOGOFF  		luaLog(szName)
	end
end
	
function luaUS01RemovePlaneFromTable()
	-- aTom Fix
-- RELEASE_LOGOFF  	luaLog("luaUS01RemovePlaneFromTable")
-- RELEASE_LOGOFF  	luaLog("----remove elott -> "..table.getn(Mission.BomberPlanes))
	logDead()
	table.remove(Mission.BomberPlanes,1)
-- RELEASE_LOGOFF  	luaLog("----remove utan -> "..table.getn(Mission.BomberPlanes))
	logDead()
	table.insert(Mission.BomberPlanes, Mission.SelectedBomber)
-- RELEASE_LOGOFF  	luaLog("----insert utan -> "..table.getn(Mission.BomberPlanes))
	logDead()
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
-- RELEASE_LOGOFF  	luaLog("----remove dead utan -> "..table.getn(Mission.BomberPlanes))
	logDead()
	-- aTom Fix end
	if Mission.SelectedBomber.Dead == false then
		SetRoleAvailable(Mission.SelectedBomber, EROLF_ALL, PLAYER_AI)
	end
	--[[
	for idx = 1, table.getn(Mission.BomberPlanes) do
		if Mission.BomberPlanes[idx] == Mission.SelectedBomber then
			if Mission.BomberPlanes[idx].Dead == false then
				--PilotLand(Mission.BomberPlanes[idx], Mission.Saratoga)
				SetRoleAvailable(Mission.BomberPlanes[idx], EROLF_ALL, PLAYER_AI)
			end
			table.remove(Mission.BomberPlanes, idx)
			return
		end
	end
	]]
end
function luaUS01JoinFormations(tab)
	local idx = 1
	while idx < table.getn(tab) do
	 idx = idx + 1
	 JoinFormation(tab[idx], tab[1])
	end
end

function luaPhase()
	if Mission.MissionPhase == 2 then
		Mission.RemainingPlanesToShoot = 1
	elseif Mission.MissionPhase == 3 then
		if GetSelectedUnit() ~= nil then
			PutTo(Mission.NavEscort1, GetPosition(GetSelectedUnit()))
		end
	elseif Mission.MissionPhase == 4 then
		for idx,unit in pairs(Mission.Cargoes) do
			AddDamage(unit,10000)
		end
	end
end

function luaUS01SaveCheckpoint()
	--luaCheckpoint(1)
	luaUS01BombersMovie_Start()
end
	
function luaUS01Checkpoint1Load()
	--local usn = luaGetCheckpointData("Units", "USUnits")
	Kill(FindEntity("Wildcat"), true)
	Mission.CheckpointLoaded = 1.0
	luaUS01GenerateEscortPlanes(Mission.NavEscort1)
	Mission.AlliedPlanes = Mission.planestogenerate
	Mission.FighterPlanes = {}
	Mission.BomberPlanes = {}
	for idx, unit in pairs(Mission.AlliedPlanes) do
		if unit.Class.Type == "Fighter" then
			--table.insert(Mission.FighterPlanes,unit)
			Kill(unit, true)
		else
			table.insert(Mission.BomberPlanes,unit)
		end
	end
	local torp = {}
	local dive = {}
	for idx, unit in pairs(Mission.BomberPlanes) do
		if unit.Class.Type == "TorpedoBomber" then
			table.insert(torp, unit)
		else
			table.insert(dive, unit)
		end
	end
	Mission.BomberPlanes = {}
	local num = (table.getn(dive) + table.getn(torp)) / 2 + 1
	for i = 1,num do
		if table.getn(dive) >= i then
			table.insert(Mission.BomberPlanes, dive[i])
		end
		if table.getn(torp) >= i then
			table.insert(Mission.BomberPlanes, torp[i])
		end
	end
	
	local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx, unit in pairs(japplanes) do
		Kill(unit, true)
	end
	JoinFormation(Mission.Balch, Mission.Enterprise)
	JoinFormation(Mission.Maur, Mission.Enterprise)
	JoinFormation(Mission.Ellett, Mission.Enterprise)
	JoinFormation(Mission.Benham, Mission.Enterprise)
	
	JoinFormation(Mission.Farragut, Mission.Saratoga)
	JoinFormation(Mission.Worden, Mission.Saratoga)
	JoinFormation(Mission.MacDonough, Mission.Saratoga)
	JoinFormation(Mission.Dale, Mission.Saratoga)
	
	SetShipMaxSpeed(Mission.Enterprise, 5)
	Blackout(true,"luaUS01BombersMovie_Start",0.5)
	--SoundFade(1, "",0.1)
end
function luaUS01Checkpoint1Save()
	--[[
	local postab = {}
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
	for idx, unit in pairs(Mission.BomberPlanes) do
		table.insert(postab, GetPosition(unit))
	end
	luaRegisterCheckpointData("positions", "bombers", postab)
	]]
end
function luaUS01BasicPlanehint2()
	if Mission.EndMission then
		return
	else
-- RELEASE_LOGOFF  		luaLog("egy")
		RemoveStoredHint("BASICPLANE2")
-- RELEASE_LOGOFF  		luaLog("ket")
		ShowHint("BASICPLANE2")
-- RELEASE_LOGOFF  		luaLog("ha")
		luaDelay(luaUS01BasicPlanehint3,20)
	end
end
function luaUS01BasicPlanehint3()
	if Mission.EndMission then
		return
	else
-- RELEASE_LOGOFF  		luaLog("negy")
		RemoveStoredHint("BASICPLANE3")
		ShowHint("BASICPLANE3")
	end
end