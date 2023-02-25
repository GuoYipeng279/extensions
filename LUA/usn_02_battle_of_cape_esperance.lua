--SceneFile="missions\USN\usn_02_Battle_of_Cape_Esperance.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--event secondary random hely, random tamado
--Cargo maradjon szurke

function luaEngineMovieInit()
	local fleet = luaGetOwnUnits(nil, PARTY_JAPANESE)
	for idx, unit in pairs(fleet) do
		UnitHoldFire(unit)
	end
	fleet = luaGetOwnUnits(nil, PARTY_ALLIED)
	for idx, unit in pairs(fleet) do
		UnitHoldFire(unit)
	end
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("usn02dlg",1)
	MissionNarrative("usn02.date_location")
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
			},
		},
	}
	luaDelay(luaUS02StartIntroDlg, 15)
end

function luaStageInit()
	CreateScript("luaInitUS02")
	Scoring_RealPlayTimeRunning(true)
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaInitUS02(this)
	Mission = this
	this.Name = "US02"
	this.ScriptFile = "scripts/missions/USN/usn_02_Battle_of_Cape_Esperance.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
		
	
	this.Debug = false

	if (this.Debug) then
-- RELEASE_LOGOFF  		luaLog("Mission running in Script DEBUG mode!")
	end

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
		
	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS02Checkpoint1Load},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS02Checkpoint1Save},
	}

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))
	
	this.MissionPhase = 1
	this.FirstRun = true
	
	this.SinkingShip = nil
	this.SinkingShipPos = nil
	this.Szoveg = false
	this.Arrived = false

	this.NavpointP2 = FindEntity("Navpoint_P2")
	this.Phase3NavPoints = {}
		table.insert(this.Phase3NavPoints, FindEntity("NavPhase3 01"))
		table.insert(this.Phase3NavPoints, FindEntity("NavPhase3 02"))
		table.insert(this.Phase3NavPoints, FindEntity("NavPhase3 03"))
		table.insert(this.Phase3NavPoints, FindEntity("NavPhase3 04"))
		table.insert(this.Phase3NavPoints, FindEntity("NavPhase3 05"))
	
	this.Frisco = FindEntity("San Francisco")
	this.Duncan = FindEntity("Duncan")
	this.Helena = FindEntity("Helena")
	this.Farenholt = FindEntity("Farenholt")
	--this.Buchanan = FindEntity("Buchanan")
	--this.Laffey = FindEntity("Laffey")
	
	this.USUnits = {this.Frisco, this.Helena, this.Duncan, this.Farenholt}
   	this.USDestroyers = {this.Duncan, this.Farenholt}
   
	this.USRescuable = {this.Helena, this.Duncan, this.Farenholt}
	this.MaxRescuable = table.getn(this.USRescuable)
	
	this.USStartUnits = {this.Frisco}
	this.JAPFirstWave = {FindEntity("Aoba"), FindEntity("Fubuki"), FindEntity("Hatsuyuki")}
	this.FirstWaveMax = table.getn(Mission.JAPFirstWave)
	this.JAPSecondWave= {"Kinugasa", "Furutaka"}
	this.JAPConvoy = {
		"Japanese Repairship",
		"Asagumo",
		"Natsugumo",
		--"Yamagumo"
	}	
	this.Cargoes = {"Japan Tanker 01", "Japan Tanker 02", "Japan Tanker 03", "Japan Tanker 04", "Japan Tanker 05"}
	this.MaxCargoes = table.getn(this.Cargoes)
	this.JAPUnits = {}
			table.insert(this.JAPUnits, FindEntity("Aoba"))
			table.insert(this.JAPUnits, FindEntity("Fubuki"))
			table.insert(this.JAPUnits, FindEntity("Kinugasa"))
			table.insert(this.JAPUnits, FindEntity("Furutaka"))
			table.insert(this.JAPUnits, FindEntity("Hatsuyuki"))
	this.SecondaryAttackers = {
	FindEntity("Fubuki"), FindEntity("Aoba")
	}
	Mission.JapPTs = {}
	
	for i=1,table.getn(this.JAPUnits) do
		TorpedoEnable(this.JAPUnits[i], false)
	end
	
	this.ActiveEvent = nil
	this.ConvoyPath = FindEntity("convoypath")
	Mission.PatrolPath = FindEntity("patrolpath")
	Mission.TankerPath = FindEntity("tankerpath")
	Mission.PTAttack = false
	local multiplier
	if this.Difficulty == 2 then	-- hard
		Mission.SecondaryTimer = 480
		Mission.mplow = 15
		Mission.mphigh = 25
		Mission.PTnumber = 13
	elseif this.Difficulty == 1	then	-- normal
		Mission.SecondaryTimer = 560
		Mission.mplow = 10
		Mission.mphigh = 25
		Mission.PTnumber = 8
	elseif this.Difficulty == 0	then	-- easy
		Mission.SecondaryTimer = 600
		Mission.mplow = 5
		Mission.mphigh = 15
		Mission.PTnumber = 4
	end

	for idx, unit in pairs(this.USRescuable) do
		AddDamage(unit, unit.Class.HP * random(Mission.mplow,Mission.mphigh)/100)
	end
		
	--EnableMessages(true)
	BannSupportmanager()
	SetCatapultStock(Mission.USStartUnits[1], 0)
	SetCatapultStock(Mission.Helena, 0)
	local endtable = {}
	for idx, unit in pairs(Mission.USStartUnits) do
		table.insert(endtable, unit)
	end
	for idx, unit in pairs(Mission.JAPFirstWave) do
		table.insert(endtable, unit)
		SetShipMaxSpeed(unit, 6)
	end
	AddListener("kill", "EndKillID", {
			["callback"] = "luaUS02EndEntity",  -- callback fuggveny
			["entity"] = endtable, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})	-- endkamera
	
	-- Achievements init
	

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	--SoundFade(0,"", 1)	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(this, "US02Think")
	
	Blackout(true,"",true)
	SetSelectedUnit(Mission.Frisco)
	
		this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "PRI01_DestroyJaps",		-- azonosito
				["Text"] = "usn02.obj_p1",
				["TextCompleted"] = "usn02.obj_p1_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "PRI02_DestroyCruisers",		-- azonosito
				["Text"] = "usn02.obj_p2",
				["TextCompleted"] = "usn02.obj_p2_success" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "PRI03_DestroyCargos",		-- azonosito
				["Text"] = "usn02.obj_p3",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[4] =
			{
				["ID"] = "PRI04_RepairTurret",		-- azonosito
				["Text"] = "usn02.obj_p4",
				["TextCompleted"] = "usn02.obj_p4_comp" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 0 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			}
		},
		
		["secondary"] = {
			[1] =
			{
				["ID"] = "SEC01_HelpUSN",		-- azonosito
				["Text"] = "usn02.obj_s1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "SEC02_HelpShip",		-- azonosito
				["Text"] = "usn02.obj_s2",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["hidden"] = {
			[1] =
			{
				["ID"] = "HID01_KillConvoy",		-- azonosito
				["Text"] = "usn02.obj_h1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},	
}

	luaObj_FillSingleScores()

	if this.Difficulty == 2 then
		for idx, unit in pairs(this.JAPFirstWave) do
			TorpedoEnable(unit, true)
			SetInvincible(unit, 0.5)
		end
	else
		for idx, unit in pairs(this.JAPFirstWave) do
			TorpedoEnable(unit, false)
			SetInvincible(unit, 0.1)
		end
	end
	
	LoadMessageMap("usn02dlg",1)

	this.Dialogues = {
		["dlg_trouble"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["message"] = "dlg1c",
				},
				{
					["message"] = "dlg1d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02AddPrimary1",
				},
			},
		},
		["dlg_secondwave"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
				{
					["message"] = "dlg3c",
				},
				{
					["message"] = "dlg3d",
				},
				{
					["message"] = "dlg3e",
				},
				{
					["message"] = "dlg3f",
				},
				{
					["message"] = "dlg3g",
				},
				{
					["message"] = "dlg3g_1",
				},
			},
		},
		["dlg_cargo_spotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["message"] = "dlg4c",
				},
				{
					["message"] = "dlg4d",
				},
				{
					["message"] = "dlg4e",
				},
				{
					["message"] = "dlg4f",
				},
				{
					["message"] = "dlg4g",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02CargoObjective",
				},
			},
		},
		["dlg_cargo_identified"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5a_1",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["dlg_convoy_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg6",
				},
			},
		},
		["dlg_rescued"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
				{
					["message"] = "dlg9c",
				},
				{
					["message"] = "dlg9d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02GotoRepairTutorial",
				},
			},
		},

		["dlg_convoy_move"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02ConvoyHint",
				},
			},
		},
		
		["dlg_sinking"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["dlg_sinking_comp"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},

		["dlg_sinking_fail"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
			},
		},
		["dlg_repair_turret"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02AddPrimary4",
				},
			},
		},
		["dlg_repair_started"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS02RepairFinished",
				},
			},
		},
}
	--SoundFade(1,"", 0.1)

	SetSimplifiedReconMultiplier(0.8)
	
	Mission.ChangeableNames = {}
	Mission.ChangeableNames[11] = {	-- Allen M. Sumner
		"ingame.shipnames_hank",
		"ingame.shipnames_moale",
		"ingame.shipnames_ingraham",
		"ingame.shipnames_borie",
		"ingame.shipnames_soley"		
	}
	Mission.ChangeableNames[48] ={	-- ASW Fletcher
		"ingame.shipnames_hopewell",
		"ingame.shipnames_melvin",
		"ingame.shipnames_stockham",
		"ingame.shipnames_picking",
		"ingame.shipnames_remey"		
	}
	Mission.ChangeableNames[900] = {	-- Luppis
		"ingame.shipnames_english",
		"ingame.shipnames_john_w_weeks",
		"ingame.shipnames_hugh_purvis",
		"ingame.shipnames_laffey",
		"ingame.shipnames_drexler",		
	}
	Mission.ChangeableNames[17] ={	-- Atlanta
		"ingame.shipnames_tucson"
	}
	Mission.ChangeableNames[390] ={	-- Alaska
		"ingame.shipnames_samoa"
	}
	
	for idx, unit in pairs(Mission.USStartUnits) do
		if IsClassChanged(unit.ClassID) then
			luaSetUnlockName(unit)
		end
	end
	for idx, unit in pairs(Mission.USRescuable) do
		if IsClassChanged(unit.ClassID) then
			luaSetUnlockName(unit)
		end
	end
	
	
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded then
		--luaDelay(luaUS02SetSelectedUnitFukka, 0.5)
		--Blackout(true)
		Mission.USRescuable = luaRemoveDeadsFromTable(Mission.USRescuable)
		for idx, unit in pairs(Mission.USRescuable) do
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	else
		SetInvincible(Mission.Duncan, 0.2)
		luaUS02JoinFormations(this.USStartUnits)
		luaUS02JoinFormations(this.USRescuable)
		Blackout(false, "", 3)
	end
	
	MissionNarrativeClear()
-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
-- RELEASE_LOGOFF  	luaLog("Prepared class "..AttackerShipName)
	luaObj_Add("hidden", 1)
end
function luaUS02SetSelectedUnitFukka()
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)

	if Mission.SelectedUnit then
-- RELEASE_LOGOFF  		luaLog("** SetSelectedUnit 1 **")
-- RELEASE_LOGOFF  		luaLog(FindEntity(Mission.SelectedUnit[1]))
		SetSelectedUnit(FindEntity(Mission.SelectedUnit[1][1]))
	else
-- RELEASE_LOGOFF  		luaLog("** SetSelectedUnit 2 **")
-- RELEASE_LOGOFF  		luaLog(Mission.USUnits[1])
		SetSelectedUnit(Mission.USUnits[1])
	end
	Blackout(false, "", 3)
end
function luaUS02InitWave2()
-- RELEASE_LOGOFF  	luaLog("luaUS02InitWave2")
	Mission.USUnits = {}
	Mission.USStartUnits = luaRemoveDeadsFromTable(Mission.USStartUnits)
	Mission.USRescuable = luaRemoveDeadsFromTable(Mission.USRescuable)
	for idx, unit in pairs(Mission.USStartUnits) do
		table.insert(Mission.USUnits, unit)
	end
	for idx, unit in pairs(Mission.USRescuable) do
		table.insert(Mission.USUnits, unit)
	end
	local degree = 240
	for idx, unit in pairs(Mission.JAPSecondWave) do
		Mission.JAPSecondWave[idx] = GenerateObject(unit)
		local enemy = luaGetNearestUnitFromTable(Mission.JAPSecondWave[idx], Mission.USUnits)
		if idx == 1 then
			Mission.Kinugasa = Mission.JAPSecondWave[idx]
		else
			Mission.Furutaka = Mission.JAPSecondWave[idx]
		end
		luaPutToRecon(Mission.JAPSecondWave[idx], enemy, degree)
		degree = degree + 10
	end
-- RELEASE_LOGOFF  	luaLog("ForceRecon")
	ForceRecon()
	
	for idx, unit in pairs(Mission.USStartUnits) do
		table.insert(Mission.USUnits, unit)
		EntityTurnToEntity(unit, Mission.JAPSecondWave[1])
	end
	for idx, unit in pairs(Mission.USRescuable) do
		table.insert(Mission.USUnits, unit)
		EntityTurnToEntity(unit, Mission.JAPSecondWave[1])
	end
	NavigatorMoveToRange(Mission.JAPSecondWave[1], luaPickRnd(Mission.USUnits))
	NavigatorMoveToRange(Mission.JAPSecondWave[2], luaPickRnd(Mission.USUnits))
	luaDelay(luaUS02SecondJapWaveAngry, 650 - Mission.Difficulty*25)
end
function luaUS02InitWave3()
	for idx, unit in pairs(Mission.Cargoes) do
		Mission.Cargoes[idx] = GenerateObject(unit)
		AddUntouchableUnit(Mission.Cargoes[idx])
		SetShipMaxSpeed(Mission.Cargoes[idx], 7)
	end
	luaUS02JoinFormations(Mission.Cargoes)
	NavigatorMoveOnPath(Mission.Cargoes[1], Mission.TankerPath, PATH_FM_CIRCLE)
	local i
	for idx = 1,Mission.PTnumber do
		if idx < 10 then
			i = "0"..idx
		else
			i = idx
		end
		Mission.JapPTs[idx] = GenerateObject("Japanese Patrolboat "..i)
		NavigatorMoveOnPath(Mission.JapPTs[idx], Mission.PatrolPath, PATH_FM_CIRCLE)
	end
-- RELEASE_LOGOFF  	luaLog("generate")
	for idx, unit in pairs(Mission.JAPConvoy) do
		Mission.JAPConvoy[idx] = GenerateObject(unit)
	end
	luaUS02JoinFormations(Mission.JAPConvoy)
	SetShipMaxSpeed(Mission.JAPConvoy[1], 7)
	NavigatorMoveOnPath(Mission.JAPConvoy[1], Mission.ConvoyPath)
end
function luaUS02RemoveUntouchableIfNeeded()
	if luaObj_GetSuccess("secondary", 2) ~= nil and luaObj_GetSuccess("hidden", 1) ~= nil then
		Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
		for idx, unit in pairs(Mission.Cargoes) do
			RemoveUntouchableUnit(unit)
		end
	end
end
function US02Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' in phase:"..this.MissionPhase)

	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	luaCheckMusic()
	
	if Mission.PTAttack == true then
		Mission.JapPTs = luaRemoveDeadsFromTable(Mission.JapPTs)
		for idx, unit in pairs(Mission.JapPTs) do
			if GetProperty(unit, "unitcommand") ~= "attackmove" then
				local trg = luaGetNearestEnemy(unit)
				if trg ~= nil  then
					NavigatorAttackMove(unit,trg,{})
				end
			end
		end
	end
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	if Mission.ShallowHintDisplayed == nil then
		for idx, unit in pairs(Mission.USUnits) do
			if luaIsInArea({{["x"] = -6400,["y"] = 0,["z"] = 500}, {["x"] = -3000,["y"] = 0,["z"] = -5250}}, GetPosition(unit)) then
				ShowHint("USN02_Hint_Shallow")
				luaDelay(luaUS02PTrecon, 15)
				Mission.ShallowHintDisplayed = true
				break
			end
		end
	end
	
	if Mission.MissionPhase == 1 and Mission.FirstRun then
		Mission.FirstRun = false
		AddListener("kill", "FirstPhaseKillsID", { -- 
				["callback"] = "luaUS02FirstJapWaveKilled",  -- callback fuggveny
				["entity"] = Mission.JAPFirstWave,	-- entityk akiken a listener aktiv
				["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
				["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			})
		luaDelay(luaUS02FirstDialog,2)
		AddListener("hit", "firstwavehitlistenerID", {
			["callback"] = "luaUS02FirstJapWaveHit", -- callback fuggveny
			["target"] = Mission.JAPFirstWave, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
		luaDelay(luaUS02FirstJapWaveAngry,250)
		luaDelay(luaUS02FirstJapWaveDDAngry,120)
	end
	
	if Mission.MissionPhase == 1 and not Mission.FirstRun then
		Mission.JAPFirstWave = luaRemoveDeadsFromTable(Mission.JAPFirstWave)
		Mission.USStartUnits = luaRemoveDeadsFromTable(Mission.USStartUnits)
		Mission.USRescuable = luaRemoveDeadsFromTable(Mission.USRescuable)
		Mission.RemainingFirstWaveShips = table.getn(Mission.JAPFirstWave)
		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1)==nil then
			DisplayScores(1,0,"usn02.obj_p1","usn02.obj_p1_display")
		else
			HideScoreDisplay(1,0)
		end
		if table.getn(Mission.USStartUnits) == 0 then -- player ships gone
			luaClearDialogs()
			luaMissionFailedNew(Mission.EndEntity, "usn02.obj_nomoreunits")
			Mission.EndMission = true
			return
		end
		--[[
		for idx, unit in pairs(Mission.USStartUnits) do
			if not luaIsInArea({{["x"] = 0,["y"] = 0,["z"] = 500}, {["x"] = 7500,["y"] = 0,["z"] = 7500}}, GetPosition(unit)) then
			-- wandering away
			end
		end
		]]
			
	elseif Mission.MissionPhase == 2 and Mission.FirstRun then
		Mission.FirstRun = false
	elseif Mission.MissionPhase == 2 and not Mission.Firstrun then
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		Mission.JAPSecondWave = luaRemoveDeadsFromTable(Mission.JAPSecondWave)
		if luaObj_IsActive("primary", 2) and luaObj_GetSuccess("primary", 2)==nil then
			if not Mission.Kinugasa.Dead then 
				Mission.KinugasaState = math.floor(GetHpPercentage(Mission.Kinugasa)*100)
			else
				Mission.KinugasaState = 0
			end
			if not Mission.Furutaka.Dead then 
				Mission.FurutakaState = math.floor(GetHpPercentage(Mission.Furutaka)*100)
			else
				Mission.FurutakaState = 0
			end
			DisplayScores(2,0,"usn02.obj_p2","usn02.obj_p2_display")
		else
			HideScoreDisplay(2,0)
		end
		if table.getn(Mission.USUnits) == 0 then
			luaClearDialogs()
			luaMissionFailedNew(Mission.EndEntity, "usn02.obj_nomoreunits")
			Mission.EndMission = true
			return
		end
		Mission.JAPSecondWave = luaRemoveDeadsFromTable(Mission.JAPSecondWave)
		if table.getn(Mission.JAPSecondWave) == 0 then
			Mission.MissionPhase = 666
			luaDelay(luaUS02Primary2Complete,4)
		end
	elseif Mission.MissionPhase == 3 then
		Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
		Mission.JapPTs = luaRemoveDeadsFromTable(Mission.JapPTs)
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3)==nil then
			Mission.CargoesRemaining = table.getn(Mission.Cargoes)
			DisplayScores(3,0,"usn02.obj_p3","usn02.obj_p3_display")
		else
			HideScoreDisplay(3,0)
		end
		if table.getn(Mission.USUnits) == 0 then
			luaClearDialogs()
			luaMissionFailedNew(Mission.EndEntity, "usn02.obj_nomoreunits")
			Mission.EndMission = true
			return
		end
		luaUS02CheckConditions()
	end
end


function luaUS02AddPrimary2()
	luaObj_Add("primary", 2, Mission.JAPSecondWave)
end
function luaUS02FirstJapWaveHit(...)
-- RELEASE_LOGOFF  	luaLog("luaUS02FirstJapWaveHit")
	if arg[1].Dead == false then
		SetSkillLevel(arg[1], SKILL_SPVETERAN)
		SetInvincible(arg[1], 0)
		if arg[3] then
			if arg[3].Dead == false then
				NavigatorAttackMove(arg[1], arg[3])
			end
		end
	end
end
function luaUS02FirstJapWaveKilled()
	Mission.JAPFirstWave = luaRemoveDeadsFromTable(Mission.JAPFirstWave)
	if table.getn(Mission.JAPFirstWave) == 0 then -- no more enemy units
		if IsListenerActive("hit", "firstwavehitlistenerID") then
			RemoveListener("hit", "firstwavehitlistenerID")
		end
		Mission.MissionPhase = 666
		luaUS02Primary1Complete()
	end
end
function luaUS02FirstJapWaveDDAngry()
	if Mission.MissionPhase == 1 and Mission.EndMission ~= true then
		Mission.SecondaryAttackers = luaRemoveDeadsFromTable(Mission.SecondaryAttackers)
		for idx, unit in pairs(Mission.SecondaryAttackers) do 
			SetSkillLevel(unit, SKILL_SPVETERAN)
		end
	end
end
function luaUS02FirstJapWaveAngry()
-- RELEASE_LOGOFF  	luaLog("luaUS02FirstJapWaveAngry")
	if Mission.MissionPhase == 1 and Mission.EndMission ~= true then
		if table.getn(Mission.USRescuable) < Mission.MaxRescuable then
			Mission.JAPFirstWave = luaRemoveDeadsFromTable(Mission.JAPFirstWave)
			Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
			Mission.USStartUnits = luaRemoveDeadsFromTable(Mission.USStartUnits)
			local player = GetSelectedUnit()
			for idx, unit in pairs(Mission.JAPFirstWave) do
				SetSkillLevel(unit, SKILL_ELITE)
				SetShipMaxSpeed(unit, GetShipMaxSpeed(unit)*1.5)
				UnitFreeAttack(unit)
				if player then
					NavigatorAttackMove(unit, player)
				else
					NavigatorAttackMove(unit, luaPickRnd(Mission.USStartUnits))
				end
			end
		else
			luaDelay(luaUS02FirstJapWaveAngry, 20)
		end
	end
end

function luaUS02SecondJapWaveAngry()
-- RELEASE_LOGOFF  	luaLog("luaUS02SecondJapWaveAngry")
	if Mission.MissionPhase == 2 then
		Mission.JAPSecondWave = luaRemoveDeadsFromTable(Mission.JAPSecondWave)
		Mission.USUnits = luaGetOwnUnits()
		local player = GetSelectedUnit()
		for idx, unit in pairs(Mission.JAPSecondWave) do
			SetSkillLevel(unit, SKILL_ELITE)
			TorpedoEnable(unit, true)
			SetShipMaxSpeed(unit, GetShipMaxSpeed(unit)*1.5)
			UnitFreeAttack(unit)
			if player then
				NavigatorAttackMove(unit, player)
			else
				NavigatorAttackMove(unit, luaPickRnd(Mission.USUnits))
			end
		end
	end
end

function luaUS02Primary1Complete()
-- RELEASE_LOGOFF  	luaLog("Primary completed")
	HideScoreDisplay(1,0)
	--luaDelay(luaUS02GotoPhase2,3)
	luaUS02StartDialog("dlg_rescued")
end
function luaUS02GotoRepairTutorial()
	Mission.USStartUnits = luaRemoveDeadsFromTable(Mission.USStartUnits)
	Mission.USRescuable = luaRemoveDeadsFromTable(Mission.USRescuable)
	RemoveListener("kill", "EndKillID")
	if IsListenerActive("kill", "SecondaryKillID") then
		RemoveListener("kill", "SecondaryKillID")
		luaObj_Completed("secondary", 1)
	end
	luaObj_Completed("primary",1,true)
	luaDelay(luaUS02MovieToDamagedShip, 3)
end
function luaUS02MovieToDamagedShip()
	BlackBars(true)
	local ships = luaGetOwnUnits()
	for idx, unit in pairs(ships) do
		if IsInFormation(unit) then
			--NavigatorStop(GetFormationLeader(unit))
			NavigatorMoveToPos(GetFormationLeader(unit) ,GetPosition(Mission.NavpointP2))
		end
	end
	Effect("SmallSmoke", GetPosition(Mission.Duncan))
	luaIngameMovie(
	{
		{["postype"] = "target", ["target"] = Mission.Duncan, ["moveTime"] = 3},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.Duncan, ["distance"] = 350, ["theta"] = 20, ["rho"] = 107, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Duncan, ["distance"] = 180, ["theta"] = 12, ["rho"] = 168, ["moveTime"] = 4, ["nonlinearblend"] = 0.7},
		{["postype"] = "cameraandtarget", ["position"]= {
			["terrainavoid"] = false,
			["parentID"]= Mission.Duncan.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},["moveTime"] = 5
		},
    },
	luaUS02RepairTutorial1)
	SetInvincible(Mission.Duncan, 0)
	local i = 1
	local gun
	while i < 3 do
		gun = GetGun(Mission.Duncan, i)
		AddDamage(gun, 65535)
		RepairEnable(gun, false)
		i = i + 1
	end
	
end
function luaUS02RepairTutorial1()
	EnableInput(true)
	local usunits = luaGetOwnUnits()
	for idx, unit in pairs(usunits) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end
	SetRoleAvailable(Mission.Duncan, EROLF_CAPTAIN + EROLF_AA_MACHINEGUN + EROLF_AA_FLAK + EROLF_ARTILLERY + EROLF_TORPEDO, PLAYER_ANY)
	SetSelectedUnit(Mission.Duncan)
	
	ForceEnableInput(IC_MAP_TOGGLE, false) -- map tiltas

	AddListener("repair", "RepairlistenerID", {
               ["callback"] = "luaUS02RepairArmament",  -- callback fuggveny
               ["entity"] = {Mission.Duncan}, -- entityk akiken a listener aktiv
               ["repairSetting"] = {2},
	})
	luaUS02StartDialog("dlg_repair_turret")
end
function luaUS02HintRepair()
	if IsListenerActive("repair", "RepairlistenerID") then
		RemoveStoredHint("REPAIR1STUSE")
		ShowHint("REPAIR1STUSE")
	end
end
function luaUS02RepairArmament(...)
	ForceEnableInput(IC_REPAIR, false) -- repair tiltas
	KillDialog("dlg_repair_turret")
	RemoveListener("repair", "RepairlistenerID")
	if not luaObj_IsActive("primary", 4) then
		luaObj_Add("primary", 4, true)
	end
	
	HideHint()
	HideScoreDisplay(1,0)
	
	local i = 1
	local gun
	while i < 3 do
		gun = GetGun(Mission.Duncan, i)
		RepairEnable(gun, true)
		i = i + 1
	end
	ForceEnableInput(IC_MAP_TOGGLE, true) -- map tiltas
	MissionNarrative("usn02.obj_p4_start")
	luaDelay(luaUS02RepairStarted, 10)
end
function luaUS02RepairStarted()
	luaUS02StartDialog("dlg_repair_started")
end
function luaUS02RepairFinished()
	ForceEnableInput(IC_REPAIR, true) -- repair tiltas
	luaObj_Completed("primary", 4)
	luaDelay(luaUS02RepairEnd, 4)
end
function luaUS02RepairEnd()
	Blackout(true, "luaUS02GotoPhase2", 2)
end
function luaUS02AddPrimary4()
	luaUS02HintRepair()
	luaObj_Add("primary", 4)
	DisplayScores(1,0,"usn02.obj_p4_1","usn02.obj_p4_2")
end
function luaUS02GotoPhase2()
	local pos = GetPosition(Mission.NavpointP2)
	if Mission.Frisco.Dead == false then
		NavigatorStop(Mission.Frisco)
		PutTo(Mission.Frisco, pos, 120)
		NavigatorCruise(Mission.Frisco)
		SetShipSpeed(Mission.Frisco, 5)
	end
	
	pos.z = pos.z + 850
	pos.x = pos.x - 500
	Mission.USRescuable = luaRemoveDeadsFromTable(Mission.USRescuable)
	--PutTo(Mission.USRescuable[1], pos)
	--[[
	local pos = GetPosition(Mission.NavpointP2)
	PutFormationTo(GetFormationLeader(Mission.Frisco), pos,1, 120)
	]]
	
	if table.getn(Mission.USRescuable) ~= 0 then
		if IsInFormation(Mission.USRescuable[1]) then
			PutFormationTo(GetFormationLeader(Mission.USRescuable[1]), pos ,3, 120)
		else
			PutFormationTo(Mission.USRescuable[1], pos ,3, 120)
		end
	end
	for idx, unit in pairs(Mission.USRescuable) do
		NavigatorStop(unit)
		NavigatorCruise(unit)
		SetShipSpeed(unit, 5)
		SetSkillLevel(unit, SKILL_SPVETERAN)
	end
	luaUS02JoinFormations(Mission.USRescuable)
	local usunits = luaGetOwnUnits()
	for idx, unit in pairs(usunits) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		--EntityTurnToEntity(unit, Mission.JAPSecondWave[1])
	end
	
	luaUS02InitWave2()
	
	luaStartDialog("dlg_secondwave")
	luaIngameMovie(
	{
	    {["postype"] = "cameraandtarget", ["target"] = Mission.JAPSecondWave[2], ["distance"] = 250, ["theta"] = 2, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAPSecondWave[2], ["distance"] = 120, ["theta"] = 5, ["rho"] = 38, ["moveTime"] = 7},
                },
	luaUS02GotoPhase2_1, true)
	Mission.MissionPhase = 2
	Mission.FirstRun = true
end
function luaUS02GotoPhase2_1()
--[[
	if Mission.USStartUnits[1].Dead == false then
		if IsInFormation(Mission.USStartUnits[1]) then
			NavigatorMoveToRange(GetFormationLeader(Mission.USStartUnits[1]), Mission.JAPSecondWave[1])
		else
			NavigatorMoveToRange(Mission.USStartUnits[1], Mission.JAPSecondWave[1])
		end
	end
	if Mission.USRescuable[1].Dead == false then
		if IsInFormation(Mission.USRescuable[1]) then
			NavigatorMoveToRange(GetFormationLeader(Mission.USRescuable[1]), Mission.JAPSecondWave[2])
		else
			NavigatorMoveToRange(Mission.USRescuable[1], Mission.JAPSecondWave[2])
		end
	end
	]]
	Mission.USStartUnits = luaRemoveDeadsFromTable(Mission.USStartUnits)
	if (table.getn(Mission.USStartUnits)>0) and (Mission.USStartUnits[1].Dead == false) then
		SetSelectedUnit(Mission.USStartUnits[1])
	else
		SetSelectedUnit(Mission.Duncan)
	end
	EnableInput(true)
	luaDelay(luaUS02HintWeapon, 50)
	luaUS02NewshipsHint()
	luaDelay(luaUS02AddPrimary2, 4)
end
function luaUS02Primary2Complete()
	luaObj_Completed("primary",2,true)
	HideScoreDisplay(2,0)
	luaDelay(luaUS02Phase3Delay,3)
end
function luaUS02Phase3Delay()
	Blackout(true,"luaUS02SaveCheckpoint1", 2)
end
function luaUS02SaveCheckpoint1()
	--luaCheckpoint(1)
	luaUS02GotoPhase3()
	Mission.SelectedUnit = GetSelectedUnit()
end
function luaUS02GotoPhase3()
	for idx, unit in pairs(luaGetOwnUnits("ship")) do
		LeaveFormation(unit)
	end
	luaDelay(luaUS02GotoPhase3_1, 1.5)
end
function luaUS02GotoPhase3_1()
	luaUS02InitWave3()
	AddListener("recon", "id_convoy", {
				["callback"] = "luaUS02ConvoyIdentified",  -- callback fuggveny
				["entity"] = Mission.JAPConvoy, -- entityk akiken a listener aktiv
				["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
				["party"] = { PARTY_ALLIED },
		})

	AddListener("recon", "detect_convoy", {
				["callback"] = "luaUS02ConvoyDetected",  -- callback fuggveny
				["entity"] = Mission.JAPConvoy, -- entityk akiken a listener aktiv
				["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
				["party"] = { PARTY_ALLIED },
		})
	
	local endtable = {}
	for idx, unit in pairs(Mission.USStartUnits) do
		table.insert(endtable, unit)
	end
	for idx, unit in pairs(Mission.JapPTs) do
		table.insert(endtable, unit)
	end
	for idx, unit in pairs(Mission.Cargoes) do
		table.insert(endtable, unit)
	end
	
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)

	AddListener("kill", "EndKillID", {
			["callback"] = "luaUS02EndEntity",  -- callback fuggveny
			["entity"] = Mission.USUnits, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})	-- endkamera
	AddListener("recon", "recon_pt", {
				["callback"] = "luaUS02PTHint",  -- callback fuggveny
				["entity"] = Mission.JapPTs, -- entityk akiken a listener aktiv
				["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
				["party"] = { PARTY_ALLIED },
		})
	luaDelay(luaUS02EventSinking, 40)
	Mission.USUnits = luaGetOwnUnits()
	for idx, unit in pairs(Mission.USUnits) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		--SetSkillLevel(unit, SKILL_SPNORMAL)
	end
	luaDelay(luaUS02HintSwitchUnit, 10)
	if not Mission.Duncan.Dead then
		SetInvincible(Mission.Duncan, 0)
	end
	Blackout(false, "", 3)
	luaUS02TransportMovie()
end
function luaUS02TransportMovie()
	luaIngameMovie(
	{
	    {["postype"] = "cameraandtarget", ["target"] = Mission.Cargoes[1], ["distance"] = 100, ["theta"] = 7, ["rho"] = 18, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Cargoes[1], ["distance"] = 140, ["theta"] = 8, ["rho"] = 38, ["moveTime"] = 18},
    },
	luaUS02GotoPhase3_end, true)
	luaUS02StartDialog("dlg_cargo_spotted")
	luaUS02RelocatePlayerPhase3()
end

function luaUS02GotoPhase3_end()
	if Mission.SelectedUnit then
		SetSelectedUnit(Mission.SelectedUnit)
	else
		local unit = luaPickRnd(luaGetOwnUnits("ship"))
		if GetFormationLeader(unit) then
			SetSelectedUnit(GetFormationLeader(unit))
		else
			SetSelectedUnit(unit)
		end
	end
	
	Mission.MissionPhase = 3
	Blackout(false, "", 3)
end

function luaUS02RelocatePlayerPhase3()
	Mission.USUnits = luaGetOwnUnits()
	local dd = {}
	local ca = {}
	for idx, unit in pairs(Mission.USUnits) do
		if unit.Type == "DESTROYER" then
			table.insert(dd, unit)
		else
			table.insert(ca, unit)
		end
	end
	Mission.UnitsToRelocate = {}
	for i = 1, math.max(table.getn(dd), table.getn(ca)) do
		if ca[i] then
			table.insert(Mission.UnitsToRelocate, ca[i])
		end
		if dd[i] then
			table.insert(Mission.UnitsToRelocate, dd[i])
		end
	end
	
	for i = 1,table.getn(Mission.UnitsToRelocate) do
		PutTo(Mission.UnitsToRelocate[i], GetPosition(Mission.Phase3NavPoints[i]), 130)
		EntityTurnToEntity(Mission.UnitsToRelocate[i], Mission.Cargoes[1])
		NavigatorCruise(Mission.UnitsToRelocate[i])
		SetShipSpeed(Mission.UnitsToRelocate[i], 7.5)
	end
	
	local i = 2
	
	while i <= table.getn(Mission.UnitsToRelocate) do
		JoinFormation(Mission.UnitsToRelocate[i], Mission.UnitsToRelocate[i-1])
		i = i + 2
	end
end
function luaUS02EndEntity(...)
-- RELEASE_LOGOFF  	luaLog("*** End Entity ***")
-- RELEASE_LOGOFF  	luaLog(arg[1].Name)
	Mission.EndEntity = arg[1]
end


function luaUS02FirstDialog()
	luaStartDialog("dlg_trouble")
end

function luaUS02CheckConditions()
		
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		Mission.JAPUnits  = luaRemoveDeadsFromTable(Mission.JAPUnits)
		
		if luaObj_IsActive("secondary", 2) then
			if luaObj_GetSuccess("secondary", 2) == nil then
				for i,unit in pairs(Mission.USUnits) do
					local dist = luaGetDistance(unit, Mission.SinkingShip)
					if dist < 750 or Mission.AttackerShip.Dead then
						luaUS02EventSinkingCompleted()
-- RELEASE_LOGOFF  						luaLog("sinking completed")
						break
					end
				end
			end
		end

		for i, unit in pairs (Mission.JAPUnits) do
			if table.getn(luaRemoveDeadsFromTable(Mission.USUnits)) ~= 0 then
				if (GetProperty(unit, "unitcommand") == "stop") then
					local newTarget = luaSortByDistance(unit, Mission.USUnits)
-- RELEASE_LOGOFF  					luaLog("NEW TARGET: "..newTarget[1].Name)
					NavigatorAttackMove(unit, newTarget[1], {})
				end
			end
		end
end
function luaUS02PTrecon()
	Mission.PTAttack = true
-- RELEASE_LOGOFF  	luaLog("PTs in recon")
end

function luaUS02ConvoyDetected()
		RemoveListener("recon", "detect_convoy")
		luaUS02StartDialog("dlg_convoy_move")
end

function luaUS02ConvoyIdentified()
	RemoveListener("recon", "id_convoy")
	LeaveFormation(Mission.JAPConvoy[2])
	ddTarget = luaGetNearestEnemy(Mission.JAPConvoy[2])
-- RELEASE_LOGOFF  	luaLog("luaUS02ConvoyIdentified")
-- RELEASE_LOGOFF  	luaLog("***UNIT***")
-- RELEASE_LOGOFF  	luaLog(unit)
-- RELEASE_LOGOFF  	luaLog("***TARGET***")
-- RELEASE_LOGOFF  	luaLog(ddTarget)
	UnitFreeAttack(Mission.JAPConvoy[2])
	if ddTarget then
		NavigatorAttackMove(Mission.JAPConvoy[2], ddTarget, {})
	end
	AddListener("kill", "ConvoyDead", {
		["callback"] = "luaUS02ConvoyDead",  -- callback fuggveny
		["entity"] = Mission.JAPConvoy, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
end

function luaUS02ConvoyDead()
-- RELEASE_LOGOFF  	luaLog("luaUS02ConvoyDead")
	Mission.JAPConvoy = luaRemoveDeadsFromTable(Mission.JAPConvoy)
	if table.getn(Mission.JAPConvoy) == 0 then
		luaObj_Completed("hidden", 1,true)
-- RELEASE_LOGOFF  		luaLog("convoybol mindenki meghalt, HIDDEN kesz.")
		RemoveListener("kill", "ConvoyDead")
		luaUS02StartDialog("dlg_convoy_destroyed")
		luaUS02RemoveUntouchableIfNeeded()
	end
end

function luaUS02CargoObjective()
	luaObj_Add("primary", 3, Mission.Cargoes)
	
	AddListener("kill", "CargoDead", {
			["callback"] = "luaUS02CargoDead",  -- callback fuggveny
			["entity"] = Mission.Cargoes, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	luaDelay(luaUS02CargoIdentified, 15)
end
function luaUS02CargoIdentified()
	luaUS02StartDialog("dlg_cargo_identified")
end
function luaUS02ConvoyHint()
		ShowHint("USN02_Hint_Convoy")
end
function luaUS02CargoDead(...)
	Effect("ExplosionMagazine", GetPosition(arg[1]))
	Effect("ExplosionBigShip", GetPosition(arg[1]))
	Mission.EndEntity = arg[1]
	Mission.Cargoes = luaRemoveDeadsFromTable(Mission.Cargoes)
	if table.getn(Mission.Cargoes) == 0 then
		RemoveListener("kill", "CargoDead")
		luaClearDialogs()
		--luaDelay(luaUS02Win,4)
		luaUS02Win()
	end
-- RELEASE_LOGOFF  	luaLog("megdoglott egy Cargo")
end

function luaUS02EventSinking()
		luaUS02StartDialog("dlg_sinking")
		local SinkNavpoints = {FindEntity("SinkNavpoint 01"), FindEntity("SinkNavpoint 02") }
		local sinknavpoint = luaPickRnd(SinkNavpoints)
		Mission.SinkingShipPos = GetPosition(sinknavpoint)
		local hdnName = luaFindHidden("Cleveland-class 01")
		Mission.SinkingShip = GenerateObject(hdnName.Name, "Cleveland-class 01")
		PutTo(Mission.SinkingShip, Mission.SinkingShipPos)
		SetParty(Mission.SinkingShip, PARTY_NEUTRAL)
		local spawnpos = GetPosition(sinknavpoint)
		spawnpos.x = spawnpos.x - 800
		if sinknavpoint == SinkNavpoints[1] then
			spawnpos.z = spawnpos.z - 1500
		else
			spawnpos.z = spawnpos.z + 1500
		end
		spawnpos.y = 0
-- RELEASE_LOGOFF  		luaLog(spawnpos)
-- RELEASE_LOGOFF  		luaLog(Mission.SinkingShipPos)
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = AttackerShipClass,
					["Name"] = AttackerShipName,
					["GuiName"] = AttackerShipGuiName,
					["Command"] = "FREEMOVE"
				},
			},
			["area"] = {
				["refPos"] = spawnpos,
				["angleRange"] = { -1, 1},
				["lookAt"] = Mission.SinkingShipPos,
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 1,
				["enemyHorizontal"] = 1,
				["ownVertical"] = 1,
				["enemyVertical"] = 1,
				["formationHorizontal"] = 1,
			},
			["callback"] = "luaUS02InitAttackerShip",
		})
		
		SetRoleAvailable(Mission.SinkingShip, EROLF_ALL, PLAYER_AI)
		RepairEnable(Mission.SinkingShip, false)
		NavigatorEnable(Mission.SinkingShip, false)
		SetInvincible(Mission.SinkingShip, 0.1)
		AddDamage(Mission.SinkingShip, Mission.SinkingShip.Class.HP * 0.9)
		
		--SetForcedReconLevel(Mission.SinkingShip, 1, 0)
		
		AttackerShipClass = nil
		AttackerShipGuiName = nil
		AttackerShipName = nil
end

function luaUS02InitAttackerShip(...)
	Mission.AttackerShip = arg[1]
	local hp = random(40, 80) / 100
-- RELEASE_LOGOFF  	luaLog(hp)
	SetInvincible(Mission.AttackerShip, hp)
	AddDamage(Mission.AttackerShip, 100000)
	SetInvincible(Mission.AttackerShip, 0)
	SetSkillLevel(Mission.AttackerShip, SKILL_SPVETERAN)
	if Mission.Difficulty ~= 2 then
		TorpedoEnable(Mission.AttackerShip, false)
	end
	NavigatorMoveToRange(Mission.AttackerShip, Mission.SinkingShipPos)
	UnitFreeAttack(Mission.AttackerShip)
	luaObj_Add("secondary", 2, GetPosition(Mission.SinkingShip))
	Countdown("usn02.obj_s2", 0, Mission.SecondaryTimer, "luaUS02TimeOver")
	--luaDelay(luaUS02HintFormation, 15)
end
function luaUS02EventSinkingCompleted()
-- RELEASE_LOGOFF  		luaLog("Sinkingcompleted")
		CountdownCancel()
		luaUS02StartDialog("dlg_sinking_comp")
		--[[
		AddPowerup({
			["classID"] = "improved_ship_manoeuvreability",
			["useLimit"] = 1,
		})
		]]
		--MissionNarrative("missionglobals.newpowerup")
		luaObj_Completed("secondary", 2, true)
		SetInvincible(Mission.SinkingShip, 0)
		AddDamage(Mission.SinkingShip, 10000)
		luaUS02RemoveUntouchableIfNeeded()
end

function luaUS02TimeOver()
	local timeLeft = CountdownTimeLeft()
-- RELEASE_LOGOFF  	luaLog("EVENT: sinking failed, remaining time: "..timeLeft)
	CountdownCancel()
	luaObj_Failed("secondary", 2)
	MissionNarrative("usn02.obj_s2_fail")
	luaUS02StartDialog("dlg_sinking_fail")
	SetInvincible(Mission.SinkingShip, 0)
	AddDamage(Mission.SinkingShip, 10000)
	luaUS02RemoveUntouchableIfNeeded()
end

function luaUS02Cheat()
	for i=1,table.getn(Mission.JAPUnits) do
		Kill(Mission.JAPUnits[i])
	end
	Mission.JAPUnits = luaRemoveDeadsFromTable(Mission.JAPUnits)
end

function luaUS02Win()
	Mission.EndMission = true
	luaObj_Completed("primary", 3)
	if luaObj_GetSuccess("hidden", 1) ~= true then
		luaObj_Failed("hidden", 1)
	end
	SetAchievements("MA_FD")
	HideScoreDisplay(1, 0)
	luaDelay(luaUS02MissionCompleted, 3)
end
function luaUS02MissionCompleted()
	local entity = GetSelectedUnit()
	if entity == nil then
		entity = luaPickRnd(luaGetOwnUnits())
	end
	if entity then
		luaMissionCompletedNew(Mission.EndEntity, "usn02.obj_p3_success")
	else
		luaMissionCompletedNew(nil, "usn02.obj_p3_success")
	end
end

function luaUS02AddPrimary1()
	--[[for i=1,table.getn(Mission.JAPUnits) do
		UnitFreeAttack(Mission.JAPUnits[i])
	end
	]]
	luaObj_Add("primary", 1, Mission.JAPFirstWave)
	EnableMessages(true)
	luaObj_Add("secondary", 1, Mission.USRescuable)
--	luaObj_Add("hidden", 1)
	AddListener("kill", "SecondaryKillID", {
			["callback"] = "luaUS02SaveAllShipsFailed",  -- callback fuggveny
			["entity"] = Mission.USRescuable, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	luaDelay(luaUS02HintHint, 5)
end
function luaUS02SaveAllShipsFailed()
	if IsListenerActive("kill", "SecondaryKillID") then
		RemoveListener("kill", "SecondaryKillID")
	end
	luaObj_Failed("secondary", 1)
	MissionNarrative("usn02.obj_s1_fail")
end
function luaUS02NewshipsHint()
	ShowHint("USN02_Hint_Newships")
	Mission.SelectedUnit = GetSelectedUnit()
	luaDelay(luaUS02NewshipsHintAgain, 1)
end
function luaUS02NewshipsHintAgain()
	if GetSelectedUnit() == Mission.SelectedUnit and table.getn(Mission.USRescuable) ~= 0 then
		ShowHint("USN02_Hint_Newships")
		luaDelay(luaUS02NewshipsHintAgain, 1)
	end
end
function luaUS02PTHint()
	RemoveListener("recon", "recon_pt")
	ShowHint("USN02_Hint_Ptboats")
	luaDelay(luaUS02HintDodge, 10)
end
function luaUS02HintDodge()
	ShowHint("USN02_Hint_Dodge")
end
function luaUS02HintFormation()
	ShowHint("USN02_Hint_Formation")
end
function luaUS02HintShipControl()
	ShowHint("USN02_Hint_Shipcontrol")
end
function luaUS02HintSwitchUnit()
	ShowHint("USN02_Hint_Switchunit")
end
function luaUS02HintWeapon()
	ShowHint("USN02_Hint_Weapon")
end
function luaUS02HintHint()
	ShowHint("Advanced_Hint_Hinthistory")
	luaDelay(luaUS02HintShipControl, 5)
end
function luaUS02StartIntroDlg()
	StartDialog("Intro_dlg", Dialogues["intro"]);
end

function luaUS02StartDialog(dialogID)
	if Mission.EndMission ~= true then
		if (Mission.Dialogues[dialogID].printed == nil) then
			StartDialog(dialogID, Mission.Dialogues[dialogID])
			Mission.Dialogues[dialogID].printed = true
		end
	end
end

function luaUS02JoinFormations(tab)
	local idx = 1
	while idx < table.getn(tab) do
	 idx = idx + 1
	 JoinFormation(tab[idx], tab[1])
	end
end

function luaPrecacheUnits()
	Loading_Start()
	local attackership = {
		Class = {73, 75}, -- fubuki, minekaze
		Name = {"Fubuki", "Minekaze"},
		GuiName = {"ingame.shipnames_fubuki", "ingame.shipnames_minekaze"}
		}
	local pick = random(1,2)
	AttackerShipClass = attackership.Class[pick]
	AttackerShipName = attackership.Name[pick]
	AttackerShipGuiName = attackership.GuiName[pick]
	PrepareClass(attackership.Class[pick])
	PrepareClass(77)
	Loading_Finish()
end
function luaUS02Checkpoint1Load()
	Mission.USUnits = luaGetOwnUnits()
	local usn = Mission.Checkpoint.Units.USUnits[1]
-- RELEASE_LOGOFF  	luaLog("USN Checkpointdata")
-- RELEASE_LOGOFF  	luaLog(usn)
	for idx, unit in pairs(usn) do
		usn[idx] = unit[1]
	end
-- RELEASE_LOGOFF  	luaLog("USN Checkpointdata")
-- RELEASE_LOGOFF  	luaLog(usn)
	for idx, unit in pairs(Mission.USUnits) do
		if not luaUS02IsInside(unit.Name, usn) then
-- RELEASE_LOGOFF  			luaLog("Kill")
-- RELEASE_LOGOFF  			luaLog(unit.Name)
			Kill(FindEntity(unit.Name), true)
		end
	end
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	for idx, unit in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
		Kill(unit, true)
	end
	RemoveListener("kill", "EndKillID")
	luaUS02GotoPhase3()
end
function luaUS02IsInside(find, tab)
	for idx, unit in pairs(tab) do
		if find == unit then
			return true
		end
	end
	return false
end
function luaUS02Checkpoint1Save()
	Mission.SelectedUnit = GetSelectedUnit()
end
function luaUS02SetChangeableGUIName(unit)
	if Mission.ChangeableNames[unit.ClassID] then
		if Mission.ChangeableNames[unit.ClassID].Counter ==  nil then
			Mission.ChangeableNames[unit.ClassID].Counter = 1
		end
		SetGuiName(unit, Mission.ChangeableNames[unit.ClassID][Mission.ChangeableNames[unit.ClassID].Counter])
-- RELEASE_LOGOFF  		luaLog("GUIName set for " .. unit.Name .. ", class " .. tostring(unit.ClassID) .. " : " .. Mission.ChangeableNames[unit.ClassID][Mission.ChangeableNames[unit.ClassID].Counter].." number "..tostring(Mission.ChangeableNames[unit.ClassID].Counter))
		Mission.ChangeableNames[unit.ClassID].Counter = Mission.ChangeableNames[unit.ClassID].Counter + 1
		if table.getn(Mission.ChangeableNames[unit.ClassID]) < Mission.ChangeableNames[unit.ClassID].Counter then
			Mission.ChangeableNames[unit.ClassID].Counter = 1
		end
	else
		SetGuiName(unit, "")
	end
end