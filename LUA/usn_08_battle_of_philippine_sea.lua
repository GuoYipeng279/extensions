--SceneFile="missions\USN\usn_08_Battle_of_Philippine_Sea.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--[[todo:
--Hint ne zerot lojjed
--sub engine movie
--BB HP meg nev legyen
	- carriers: Taiho, Shokaku, Zuikaku, Ryuho (Soryu, Hiryu class)
	- DDs: Wakatsuki, Hatsuyuki, Akizuki, Shimotsuki (Akizuki class)
	       Asagumo, Urakaze, Isokaze, Yamagumo
	- BBs: Kongo, Haruna, Nagato, Arigato (Kongo-class)


]]--
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(101) -- wildcat
	PrepareClass(102) -- corsair
	PrepareClass(113) -- avenger
	PrepareClass(150) -- zero
	PrepareClass(158) -- val
	PrepareClass(272) -- akizuki
	PrepareClass(30) -- gato
	PrepareClass(162) -- Kate
	PrepareClass(60) -- Kongo
	PrepareClass(271) -- Taiho
	PrepareClass(257) -- Shokaku
	PrepareClass(300) -- Ryujo
	PrepareClass(163) -- jill
	PrepareClass(159) -- judy
	PrepareClass(154) -- oscar
	PrepareClass(167) -- betty
	PrepareClass(26) -- F6F Hellcat
	PrepareClass(38) -- SB2C Helldiver
	--PrepareClass(108) -- SBD Dauntless
	PrepareClass(166) -- Nell
	PrepareClass(152) -- Gekko
	Loading_Finish()
	-- B6N Jill - 163  Carrierbased, D4Y Judy - 159 Carrierbased, D3A Val - 158 CB, B5N Kate - 162 misc
	-- Ki-43 Oscar Land, G4M Betty Land, 
end

function luaEngineMovieInit()
	Music_Control_SetLevel(0)
	EnableMessages(false)
	LoadMessageMap("usn08dlg",1)

	Dialogues = {
		["intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["message"] = "idlg01c",
				},
			},
		},
	}

	MissionNarrative("usn08.date_location")
	luaDelay(luaUS08StartIntroDlg, 4)
end

function luaStageInit()
	CreateScript("luaInitUS08")
	Scoring_RealPlayTimeRunning(true)
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaInitUS08(this)
	Mission = this
	this.Name = "US08"
	this.ScriptFile = "scripts/missions/USN/usn_08_Battle_of_Philippine_Sea.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	-----------------------DEBUGHELPER----------------------
	this.Debug = false
    --------------------------------------------------------

	if (this.Debug) then
-- RELEASE_LOGOFF  		luaLog("Mission running in Script DEBUG mode!")
	end

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS08Checkpoint1Load},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS08Checkpoint1Save},
	}
	
	this.Party = SetParty(this, PARTY_ALLIED)

	this.MissionPhase = 1
	this.FirstRun = true
	this.EmptySlots = 0
	this.PlaneAIPhase01FirstRun = true
	this.ListenerRemoved = false
	this.Counter = 0
	this.JAPCarriersSpawned = 0

	this.SPos = FindEntity("Navpoint_Planes_01")
	this.Carrier01 = FindEntity("Yorktown-class 01")
	this.Carrier02 = FindEntity("Yorktown-class 02")
	this.SlotMaxStatus = 0
	
	Mission.AchievementPlanes = 0

	this.Navpoints = {}
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP01"))
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP02"))
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP03"))
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP04"))
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP05"))
		table.insert(this.Navpoints, FindEntity("Navpoint_JAP06"))

	this.RadioPoints = {}
		table.insert(this.RadioPoints, FindEntity("Navpoint_Radio_01"))
		table.insert(this.RadioPoints, FindEntity("Navpoint_Radio_02"))
		table.insert(this.RadioPoints, FindEntity("Navpoint_Radio_03"))

	this.RadioPos = luaPickRnd(this.RadioPoints)
	this.USUnits = {}
		table.insert(this.USUnits, FindEntity("Yorktown-class 01"))
		table.insert(this.USUnits, FindEntity("Yorktown-class 02"))
		table.insert(this.USUnits, FindEntity("Fletcher-class 01"))
		table.insert(this.USUnits, FindEntity("Fletcher-class 02"))
		table.insert(this.USUnits, FindEntity("Fletcher-class 03"))
		table.insert(this.USUnits, FindEntity("Atlanta-class 01"))

	this.USUnitNames = {}
		table.insert(this.USUnitNames, "ingame.shipnames_bunker_hill")
		table.insert(this.USUnitNames, "ingame.shipnames_enterprise")
		table.insert(this.USUnitNames, "ingame.shipnames_izard")
		table.insert(this.USUnitNames, "ingame.shipnames_charrette")
		table.insert(this.USUnitNames, "ingame.shipnames_conner")
		table.insert(this.USUnitNames, "ingame.shipnames_san_diego")

	this.Form1 = {}
		table.insert(this.Form1, FindEntity("Fletcher-class 01"))
		table.insert(this.Form1, FindEntity("Fletcher-class 02"))

	this.Form2 = {}
		table.insert(this.Form2, FindEntity("Fletcher-class 03"))
		table.insert(this.Form2, FindEntity("Atlanta-class 01"))

	this.USCarriers = {}
		table.insert(this.USCarriers, FindEntity("Yorktown-class 01"))
		table.insert(this.USCarriers, FindEntity("Yorktown-class 02"))

	this.USPlanes = {}

	this.JAPPlanes = {}
		
	this.JAPAttackerPlanes = {}
		
	this.JAPCarrierNames = {}
		table.insert(this.JAPCarrierNames, "ingame.shipnames_taiho")
		table.insert(this.JAPCarrierNames, "ingame.shipnames_shokaku")
		table.insert(this.JAPCarrierNames, "ingame.shipnames_zuikaku")
		table.insert(this.JAPCarrierNames, "ingame.shipnames_ryuho_cc")

	this.JAPDD1Names = {}
		table.insert(this.JAPDD1Names, "ingame.shipnames_wakatsuki")
		table.insert(this.JAPDD1Names, "ingame.shipnames_akizuki")
		table.insert(this.JAPDD1Names, "ingame.shipnames_asagumo")
		table.insert(this.JAPDD1Names, "ingame.shipnames_isokaze")

	this.JAPDD2Names = {}
		table.insert(this.JAPDD2Names, "ingame.shipnames_hatsuyuki")
		table.insert(this.JAPDD2Names, "ingame.shipnames_shimotsuki")

	Mission.ChangeableNames = {}
	Mission.ChangeableNames[30] = {	-- Gato
		"ingame.shipnames_blackfish"
	}
	Mission.ChangeableNames[11] = {	-- Allen M. Sumner
		"ingame.shipnames_moale",
		"ingame.shipnames_ingraham",
		"ingame.shipnames_hank",
	}

	Mission.ChangeableNames[48] = {	-- ASW Fletcher
		"ingame.shipnames_hopewell",
		"ingame.shipnames_melvin",
		"ingame.shipnames_stockham",
	}
	Mission.ChangeableNames[900] = {	-- Luppis
		"ingame.shipnames_laffey",
		"ingame.shipnames_de_haven",
		"ingame.shipnames_drexler",
	}
	--[[
	this.CurrentDate = os.date("*t")

		if (this.CurrentDate.month == 6) and (this.CurrentDate.day == 19) then
-- RELEASE_LOGOFF  			luaLog("Easter egg called.")
			table.insert(this.JAPDD2Names, "ingame.shipnames_inikamoze")
		else
			table.insert(this.JAPDD2Names, "ingame.shipnames_urakaze")
		end
		]]
		table.insert(this.JAPDD2Names, "ingame.shipnames_urakaze")
		table.insert(this.JAPDD2Names, "ingame.shipnames_yamagumo")

	this.JAPCarriers = {}
	this.CarrierScreens = {}
	this.JAPBBs = {}
	this.JAPSecondWave = {}
	this.Narwhal = nil
	this.TestUnit = nil
	this.SpawnedGecok = {}

	this.PlanePath = FindEntity("PlanePath")
	this.StartPoint = FindEntity("Navpoint_Start")
	this.SubSpawnPoint = FindEntity("Navpoint_Sub")

	this.PRI01Failed = nil
	this.PRI02Failed = nil
	this.PRI03Failed = nil

	this.DeadCarrier = nil
	--this.DeadPlane = nil
	this.SpawnEnded = false

	

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()
	
	SetDeviceReloadTimeMul(0)
    SetThink(this, "US08Think")

	for i=1,table.getn(this.USUnits) do
		SetGuiName(this.USUnits[i], this.USUnitNames[i])
		luaSetUnlockName(this.USUnits[i])
	end

	if Mission.Debug then
		AddPowerup({
			["classID"] = "radar_sweep",
			["useLimit"] = 10,
		})
	end

	Blackout(true,"",true)
	SetSelectedUnit(this.USUnits[1])

	Mission.USStartingPos = GetPosition(Mission.USUnits[1])

	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "PRI01_DestroyPlanes",		-- azonosito
				["Text"] = "usn08.obj_p1",
				["TextCompleted"] = "usn08.obj_p1_compl" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn08.obj_p1_fail",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "PRI02_Survive",		-- azonosito
				["Text"] = "usn08.obj_p2",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn08.obj_p2_fail",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "PRI03_DestroyCarriers",		-- azonosito
				["Text"] = "usn08.obj_p3",
				["TextCompleted"] = "usn08.obj_p1_compl" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},

		["secondary"] = {
			[1] =
			{
				["ID"] = "SEC01_DestroyAllBBs",		-- azonosito
				["Text"] = "usn08.obj_s1",
				["TextCompleted"] = "usn08.obj_s1_compl" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
		["hidden"] = {
			[1] =
			{
				["ID"] = "HID01_Sub",		-- azonosito
				["Text"] = "usn08.obj_h1",
				["TextCompleted"] = "usn08.obj_h1_compl" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				--TODO: score-t majd beallitani, ha ki lesz dolgozva
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
}
	luaObj_FillSingleScores()
	LoadMessageMap("usn08dlg",1)

	this.Dialogues = {
		["planes_detected"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
				{
					["message"] = "dlg01c",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS08AddFirstObjs"
				},
			},
		},
		["corsairs_ready"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
			},
		},
		["emily_incoming"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["sub_report"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a",
				},
				{
					["message"] = "dlg04b",
				},
			},
		},
		["turkey_shot"] = {
			["sequence"] = {
				{
					["message"] = "dlg05",
				},
			},
		},
		["screen_move"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
			},
		},
		["second_air_strike"] = {
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07b",
				},
				{
					["message"] = "dlg07b_1",
				},
			},
		},
		["bunker_hill_50"] = {
			["sequence"] = {
				{
					["message"] = "dlg08",
				},
			},
		},
		["bunker_hill_25"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
				{
					["message"] = "dlg09b",
				},
			},
		},
		["enterprise_50"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["enterprise_25"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["kill_30"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["kill_50"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
				{
					["message"] = "dlg13b_1",
				},
			},
		},
		["valamikor"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
				{
					["message"] = "dlg14b_1",
				},
				{
					["message"] = "dlg14c",
				},
				{
					["message"] = "dlg14d",
				},
				{
					["message"] = "dlg14e",
				},
			},
		},
}

--	--SoundFade(0,"", 1)


	for i = 1, table.getn(this.Form1) do
		JoinFormation(this.Form1[i], this.USCarriers[1])
	end

	for i = 1, table.getn(this.Form2) do
		JoinFormation(this.Form2[i], this.USCarriers[2])
	end

	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded then
		luaUS08Movie1_Pre()
	end
	EnableMessages(true)
	--Blackout(false, "", 3)
	SetDeviceReloadEnabled(true)
	luaObj_Add("hidden", 1)
end

function US08Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	--ANTICHEAT MECHANISM--
--[[	if Mission.Debug == false then
		local ownUnits = luaGetOwnUnits()
		for i=1,table.getn(ownUnits) do
			SetInvincible(ownUnits[i], false)
		end
	end ]]--

	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	
	luaUS08CheckConditions(this)
	
	if not Mission.TurkeyDone then
		luaUS08TurkeyShotAchievementChecker()
	end
	
	luaCheckMusic()
-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)

-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")
end

function luaUS08CheckConditions()
		if Mission.MissionPhase == 1 then
			luaUS08MissionPhase01()
		elseif Mission.MissionPhase == 2 then
			luaUS08MissionPhase02()
		end
end

function luaUS08MissionPhase01()	
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	Mission.JAPAttackerPlanes = luaRemoveDeadsFromTable(Mission.JAPAttackerPlanes)
	ForceRecon()
	Mission.JAPPlanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
-- RELEASE_LOGOFF  	luaLog("*** JAPPLANES ***")
-- RELEASE_LOGOFF  	luaLog(Mission.JAPPlanes)
	if Mission.FirstRun then
		Mission.FirstRun = false
		Mission.PlanesNotWritten = true
		Blackout(false, "", 3)
		if Scoring_IsUnlocked("US07_GOLD") then
			luaUS08Gold()
		end
		luaUS08Bronze()	-- nem igaz

		AddListener("recon", "recon_japplanes", {
				["callback"] = "luaUS08JAPPlanesDetected",  -- callback fuggveny
				["entity"] = Mission.JAPAttackerPlanes, -- entityk akiken a listener aktiv
				["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
				["party"] = { PARTY_ALLIED },
		})
		AddListener("hit", "listenerCarrierHit", {
				["callback"] = "luaUS08HintRepair", -- callback fuggveny
				["target"] = Mission.USCarriers, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {}, -- tamado entityk
				["attackType"] = {"TORPEDO", "BOMB"}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
		AddListener("hpEvent", "BunkerhillDamageListener" , {
    	           	["callback"] = "luaUS08BunkerHill50",
                 	["entity"] = {Mission.Carrier01},
               		["reason"] = {"damage"}, --„repair” eseten gyogyulasra szol
	                ["hp"] = 0.5,
      				})
		AddListener("hpEvent", "EnterpriseDamageListener" , {
    	           	["callback"] = "luaUS08Enterprise50",
                 	["entity"] = {Mission.Carrier02},
               		["reason"] = {"damage"}, --„repair” eseten gyogyulasra szol
	                ["hp"] = 0.5,
      				})
		AddListener("kill", "EndCarrierlistenerID", {
		["callback"] = "luaUS08EndCameraCarrier",  -- callback fuggveny
		["entity"] = Mission.USCarriers, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
		luaDelay(luaUS08CheckLazyPlayer, 50)
	end
		luaUS08PlaneAIPhase01()
		luaUS08Phase01BringOutTheDead()
		luaUS08Phase01ObjectiveChecker()

--[[		local howManyPlanes, whatPlanes = luaGetSlotsAndSquads(FindEntity("Yorktown-class 02"))
		if howManyPlanes == 4 then
			table.insert(Mission.USPlanes, whatPlanes)
		end]]--

end
function luaUS08CheckLazyPlayer()
	if Mission.MissionPhase == 1 then
		local usplanes = luaGetOwnUnits("plane")
		if table.getn(usplanes) == 0 then
			local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
			for idx, unit in pairs(japplanes) do
				SetSkillLevel(unit, SKILL_ELITE)
			end
		end
	end
end
function luaUS08BunkerHill50()
	RemoveListener("hpEvent", "BunkerhillDamageListener")
	luaUS08StartDialog("bunker_hill_50")
	AddListener("hpEvent", "BunkerhillDamageListener" , {
    	           	["callback"] = "luaUS08BunkerHill25",
                 	["entity"] = {Mission.Carrier01},
               		["reason"] = {"damage"}, --„repair” eseten gyogyulasra szol
	                ["hp"] = 0.25,
      				})
end
function luaUS08BunkerHill25()
	RemoveListener("hpEvent", "BunkerhillDamageListener")
	luaUS08StartDialog("bunker_hill_25")
end
function luaUS08Enterprise50()
	RemoveListener("hpEvent", "EnterpriseDamageListener")
	luaUS08StartDialog("enterprise_50")
	AddListener("hpEvent", "EnterpriseDamageListener" , {
    	           	["callback"] = "luaUS08Enterprise25",
                 	["entity"] = {Mission.Carrier02},
               		["reason"] = {"damage"}, --„repair” eseten gyogyulasra szol
	                ["hp"] = 0.25,
      				})
end
function luaUS08Enterprise25()
	RemoveListener("hpEvent", "EnterpriseDamageListener")
	luaUS08StartDialog("enterprise_25")
end
function luaUS08JAPPlanesDetected()
	RemoveListener("recon", "recon_japplanes")
	luaUS08StartDialog("planes_detected")
	--		StartDialog("planedetected", Mission.Dialogues["planes_detected"])	
end
function luaUS08AddFirstObjs()
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2, Mission.USCarriers)
	luaDelay(luaUS08CarrierHP, 3)
	luaDelay(luaUS08HintCAP, 8)
end
function luaUS08CarrierHP()
	Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
	DisplayUnitHP(Mission.USCarriers, "usn08.carrier_hp")
end
function luaUS08HintCAP()
	ShowHint("USN08_Hint_CAP")
	luaDelay(luaUS08HintShootbombers, 10)
end
function luaUS08HintShootbombers()
	ShowHint("USN08_Hint_ShootBombers")
end
function luaUS08HintAttackerPlanes()
	ShowHint("USN08_Hint_Attackerplanes")
end
function luaUS08HintRepair()
	RemoveListener("hit", "listenerCarrierHit")
	ShowHint("USN08_Hint_Repair")
end

function luaUS08HintSubSneak()
	if GetSelectedUnit() == Mission.Narwhal then
		ShowHint("USN08_Hint_Sub_Sneak")
	else
		luaDelay(luaUS08HintSubSneak, 10)
	end
end
function luaUS08HintSubDive()
	if GetSelectedUnit() == Mission.Narwhal then
		ShowHint("USN08_Hint_Sub_Dive")
		luaDelay(luaUS08HintSubSneak, 30)
	else
		luaDelay(luaUS08HintSubDive, 10)
	end
end
function luaUS08Phase01ObjectiveChecker()

		if Mission.PRI02Failed == true then
			Mission.EndMission = true
			Mission.MissionPhase = 666
			luaClearDialogsCallback()
			luaMissionFailedNew(Mission.DeadCarrier, "usn08.obj_nomorecarriers")
		elseif Mission.PRI01Failed == false and Mission.PRI02Failed == false then
			Blackout(true, "luaUS08SaveCheckpoint", 3)
			Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
			for i=1,table.getn(Mission.USCarriers) do
				SetAirBaseSlotCount(Mission.USCarriers[i], 4)
				AddAirBaseStock(Mission.USCarriers[i],26,15) -- F6F Hellcat
				AddAirBaseStock(Mission.USCarriers[i],113,45) -- TBF Avenger
				AddAirBaseStock(Mission.USCarriers[i],38,18) -- SB2C Helldiver
				--AddAirBaseStock(Mission.USCarriers[i],108,12) -- SBD Dauntless
			end
			Mission.MissionPhase = 666
		end

end
function luaUS08SaveCheckpoint()
	--luaCheckpoint(1)
	luaUS08Movie1_Pre()
	HideUnitHP()
end
function luaUS08Movie1_Pre()
	luaUS08Phase02RandomSpawner()
	luaDelay(luaUS08Movie1_Start, 2)
	Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
	if (Mission.Difficulty < 2) and (table.getn(Mission.USCarriers) == 1) then	-- only one carrier
		local gettounits = luaGetOwnUnits("ship")
		for idx, unit in pairs(gettounits) do
			SetSkillLevel(unit, SKILL_MPVETERAN)
		end
	end
end
function luaUS08Movie1_Start()
	if Mission.JAPCarriersSpawned ~= 4 then
		luaDelay(luaUS08Movie1_Start, 0.5)
		return
	end
	luaUS08RelocateFleet()
	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit == nil then
		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
		Mission.SelectedUnit = Mission.USCarriers[1]
	end
	BlackBars(true)
	Blackout(false, "", 3)
	Mission.camtrg1 = LaunchAirBaseSlot(Mission.JAPCarriers[1], 1, false)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAPCarriers[1], ["distance"] = 340, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAPCarriers[1], ["distance"] = 200, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 3, ["smoothtime"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.JAPCarriers[1], ["distance"] = 100, ["theta"] = 10, ["rho"] = 192, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.camtrg1, ["distance"] = 60, ["theta"] = 5, ["rho"] = 8, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.camtrg1, ["distance"] = 50, ["theta"] = 5, ["rho"] = 31, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	},
	luaUS08Movie1_End)
end
function luaUS08Movie1_End()
	BlackBars(false)
	Blackout(true, "luaUS08GotoPhase2", 3)
end

function luaUS08GotoPhase2()
	if Mission.SelectedUnit.Dead == false then
		SetSelectedUnit(Mission.SelectedUnit)
	else
		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
		Mission.SelectedUnit = Mission.USCarriers[1]
		SetSelectedUnit(Mission.SelectedUnit)
	end
	EnableInput(true)
	luaUS08CarrierHP()
	Blackout(false, "", 3)
	if Mission.MissionPhase ~= 666 then
		luaUS08Phase02RandomSpawner()	-- cheat esetere
	end
	Mission.MissionPhase = 2
	Mission.PRI03Failed = nil
	Mission.FirstRun = true
	luaDelay(luaUS08AddPrimary2, 7)
	luaDelay(luaUS08Phase02SpawnSub, 360)
end
function luaUS08PlaneAIPhase01()

		Mission.JAPPlanes = luaRemoveDeadsFromTable(Mission.JAPPlanes)
		Mission.JAPSecondWave = luaRemoveDeadsFromTable(Mission.JAPSecondWave)

		if Mission.PlaneAIPhase01FirstRun then

			Mission.PlaneAIPhase01FirstRun = false

			Mission.JAPAttackerPlanes = luaGetOwnUnits("plane", PARTY_JAPANESE)

			for i=1,table.getn(Mission.JAPAttackerPlanes) do
				PilotMoveOnPath(Mission.JAPAttackerPlanes[i], Mission.PlanePath, PATH_FM_PINGPONG)
			end
			
			luaDelay(luaUS08KateAttack, 40)
			luaDelay(luaUS08LargeTorpedoAttack, 75)
		end

--itt jön, amikor beröccen az akcijó
		if table.getn(Mission.JAPPlanes) ~= 0 then
			for idx, unit in pairs(Mission.JAPPlanes) do
				if GetProperty(unit, "unitcommand") == "moveto" then
					if unit.Class.Type == "LargeReconPlane" then
						PilotRetreat(unit)
					else
						local targetCarrier = luaPickRnd(Mission.USCarriers)
						PilotSetTarget(unit, targetCarrier)
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaLog("elfogytak a japo repulok")
			luaObj_Completed("primary", 1, true)
			Mission.PRI01Failed = false
		end
end
function luaUS08KateAttack()
	if Mission.MissionPhase == 1 then
		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
		for idx, unit in pairs(Mission.JAPPlanes) do
			PilotSetTarget(unit, luaPickRnd(Mission.USCarriers))
		end
	end
end
function luaUS08LargeTorpedoAttack()
	if Mission.MissionPhase == 1 then
		Mission.JAPSecondWave = luaRemoveDeadsFromTable(Mission.JAPSecondWave)
		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
		for i=1,table.getn(Mission.JAPSecondWave) do
			local targetCarrier = luaPickRnd(Mission.USCarriers)
			PilotSetTarget(Mission.JAPSecondWave[i], targetCarrier)
		end
	end
end
-- PHASE 2 fv-ei
function luaUS08EndCameraCarrier(...)
	Mission.DeadCarrier = arg[1]
end
function luaUS08MissionPhase02()
-- RELEASE_LOGOFF  		luaLog("kettes fazis bassszki")

		Mission.JAPCarriers = luaRemoveDeadsFromTable(Mission.JAPCarriers)
		Mission.JAPBBs = luaRemoveDeadsFromTable(Mission.JAPBBs)

		if Mission.FirstRun then
			Mission.FirstRun = false
			--Mission.USUnits = luaGetOwnUnits()
			luaDelay(luaUS08SpawnSecondAirStrike, random(100,300))
			luaDelay(luaUS08HintAttackerPlanes, 10)
			AddPowerup({
				["classID"] = "radar_sweep",
				["useLimit"] = 1,
			})
		end
		
		if Mission.JAPCarriersSpawned == 4 then
			Mission.japcarnum = 2 - (4 - table.getn(Mission.JAPCarriers))
			DisplayScores(1,0,"usn08.obj_p3", "usn08.carrierstosink")
		end
		--[[
		if luaObj_IsActive("secondary", 1) then
			if luaObj_GetSuccess("secondary", 1) == nil then
				DisplayScores(2,0,"usn08.obj_s1", "")
			else
				HideScoreDisplay(2,0)
			end
		end
		]]
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		for i=1,table.getn(Mission.JAPCarriers) do
			luaAirfieldManager(Mission.JAPCarriers[i], {150}, {162,158}, Mission.USUnits, 200)
			luaCapManager(Mission.JAPCarriers[i], {150}, 2)
		end

		luaUS08Phase02ScreenChecker()
		luaUS08Phase02BringOutTheDead()
		luaUS08Phase02ObjectiveChecker()
		end

function luaUS08Phase02SpawnSub()
		local hdnName = luaFindHidden("Gato")
		Mission.Narwhal = GenerateObject(hdnName.Name, "Narwhal")
-- RELEASE_LOGOFF  		luaLog("Sub Generated")
		if IsClassChanged(Mission.Narwhal.ClassID) then
			luaSetUnlockName(Mission.Narwhal)
		else
			SetGuiName(Mission.Narwhal, "ingame.shipnames_albacore")
		end
		SetRoleAvailable(Mission.Narwhal, EROLF_ALL, PLAYER_AI)
		ShipSetTorpedoStock(Mission.Narwhal, 64)
--		local rndCarrier = luaPickInRange(Mission.JAPCarriers[1], 40, Mission.JAPCarriers[2], 40, Mission.JAPCarriers[3], 10, Mission.JAPCarriers[4], 10)
--		local pos = GetPosition(FindEntity("Taiho"))
		if Mission.Kongo and not Mission.Kongo.Dead then
			Mission.SubFirstTarget = Mission.Kongo
		else
			Mission.SubFirstTarget = luaPickRnd(Mission.JAPCarriers)
		end
-- RELEASE_LOGOFF  		luaLog("Sub taret:")
-- RELEASE_LOGOFF  		luaLog(Mission.SubFirstTarget.Name)
		SetSubmarineDepthLevel(Mission.Narwhal, 1)
		PutRelTo(Mission.Narwhal, Mission.SubFirstTarget, {["x"]=-1200,["y"]=-50,["z"]=-1200},0)
		EntityTurnToEntity(Mission.Narwhal, Mission.SubFirstTarget)
		luaUS08Sub()
		luaUS08SubMovie()
-- RELEASE_LOGOFF  		luaLog("Sub spawning over")
end
function luaUS08KongoKilled()
	RemoveListener("kill", "KongolistenerID")
	luaObj_Completed("secondary", 1, true)
	--[[AddPowerup({
		["classID"] = "torpedo1",
		["useLimit"] = 1,
	})]]
end
function movietest()
	luaClearDialogs()
	luaUS08Phase02RandomSpawner()
	luaDelay(luaUS08Phase02SpawnSub,4)
end
function luaUS08SubMovie()
	if Mission.EndMission ~= true then
		Mission.SelectedUnit = GetSelectedUnit()
		BlackBars(true)
		luaUS08StartDialog("sub_report")
		--local cv = luaPickRnd(Mission.USCarriers)
-- RELEASE_LOGOFF  		luaLog("Submovie**********************")
		luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.Narwhal, ["distance"] = 100, ["theta"] = 5, ["rho"] = 158, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Narwhal, ["distance"] = 110, ["theta"] = 15, ["rho"] = 178, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.SubFirstTarget, ["distance"] = 1200, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		}
		, luaUS08SubMovie_End)
	end
end

function luaUS08SubMovie_End()
	BlackBars(false)
	if Mission.SelectedUnit ~= nil then
		if Mission.SelectedUnit.Dead == false then
			SetSelectedUnit(Mission.SelectedUnit)
		end
	else
		SetSelectedUnit(Mission.Narwhal)
	end
	EnableInput(true)
	luaUS08ShowSubJoinedHint()
end


function luaUS08Phase02RandomSpawner()
		local carrierTbl = {271,257,257,300}
		local carrier = {}
		local groupTbl = {}
		local rndTbl = {}

		--if (Mission.Difficulty == 0) or (Mission.Difficulty == 1) then

			rndTbl = {
				[1] = {["Name"] = "T"},
				[2] = {["Name"] = "F"},
				[3] = {["Name"] = "F"},
				[4] = {["Name"] = "F"},
			}

		--elseif Mission.Difficulty == 2 then
--[[
			rndTbl = {
				[1] = {["Name"] = "T"},
				[2] = {["Name"] = "T"},
				[3] = {["Name"] = "F"},
				[4] = {["Name"] = "F"},
			}
	
		end
]]
		Mission.spawnPoints = {}
			for i=1,table.getn(Mission.Navpoints) do
				table.insert(Mission.spawnPoints, Mission.Navpoints[i])
			end

--		local carriersToSpawn = 4
--		local spawnMit = nil
		local spawnIde = nil
		Mission.BBSpawned = 0

		for i=1,table.getn(carrierTbl) do
			spawnIde = luaPickRnd(Mission.spawnPoints)
-- RELEASE_LOGOFF  			luaLog("*** SpawnPoints ***")
-- RELEASE_LOGOFF  			luaLog(spawnIde)
--			spawnMit = luaPickRnd(carrierTbl)
-- RELEASE_LOGOFF  --			luaLog(spawnMit..": "..spawnIde.Name)
			luaRemoveByName(Mission.spawnPoints, spawnIde.Name)

			local carrierName = Mission.JAPCarrierNames[i]

			local Skill
			local numSlots
			local maxInAirPlanes
			local fighterType
			local bomberType
			local tBomberType
			local fighterStockCount
			local tBomberStockCount
			local bomberStockCount
			local battleShipType = 60
			local destroyerType = 272



			if (Mission.Difficulty < 2) then
				Skill = SKILL_SPNORMAL
				numSlots = 3
				maxInAirPlanes = 10
				fighterType = 150
				tBomberType = 162
				bomberType = 158
				fighterStockCount = 20
				bomberStockCount = 20
				tBomberStockCount = 20
			elseif Mission.Difficulty == 2 then
				Skill = SKILL_SPVETERAN
				numSlots = 4
				maxInAirPlanes = 20
				fighterType = 150
				tBomberType = 162
				bomberType = 158
				fighterStockCount = 40
				tBomberStockCount = 40
				bomberStockCount = 40
			end

			local fighterStock = {["Type"] = fighterType, ["Count"] = fighterStockCount, ["SquadLimit"] = 5}
			local fighterSlot = {["Type"] = fighterType, ["Arm"] = 0, ["Count"] = 3}
			local bomberStock = {["Type"] = bomberType, ["Count"] = bomberStockCount, ["SquadLimit"] = 5}
			local bomberSlot = {["Type"] = bomberType, ["Arm"] = 1, ["Count"] = 3}
			local tBomberStock = {["Type"] = tBomberType, ["Count"] = tBomberStockCount, ["SquadLimit"] = 5}
			local tBomberSlot = {["Type"] = tBomberType, ["Arm"] = 1, ["Count"] = 3}

			local destroyer1 = {["Type"] = destroyerType, ["Name"] = Mission.JAPDD1Names[i], ["GuiName"] = Mission.JAPDD1Names[i], ["Race"] = Japan}
			
			local destroyer2 = {["Type"] = destroyerType, ["Name"] = Mission.JAPDD2Names[i], ["GuiName"] = Mission.JAPDD2Names[i], ["Race"] = Japan}
			
			local battleShip = {["Type"] = battleShipType, ["Name"] = "Kongo", ["GuiName"] = "ingame.shipnames_kongo", ["Race"] = Japan}
			
			carrier = {
				["Type"] = carrierTbl[i],
				["Name"] = Mission.JAPCarrierNames[i],
				["GuiName"] = Mission.JAPCarrierNames[i],
				["Race"] = JAPAN,
				["NumSlots"] = numSlots,
				["MaxInAirPlanes"] = maxInAirPlanes,
						["PlaneStock 1"] = fighterStock,
						["Slot 1"] = fighterSlot,
						["PlaneStock 2"] = fighterStock,
						["Slot 2"] = fighterSlot,
						["PlaneStock 3"] = tBomberStock,
						["Slot 3"] = tBomberSlot,
						["PlaneStock 4"] = bomberStock,
						["Slot 4"] = bomberSlot,
			}


			local rnd = luaPickRnd(rndTbl)

			if (rnd.Name == "T") then
-- RELEASE_LOGOFF  				luaLog("RANDOM: TRUE")
			else
-- RELEASE_LOGOFF  				luaLog("RANDOM: FASLE")
			end

			if (rnd.Name == "T") then
				groupTbl = {carrier, destroyer1, destroyer2, battleShip}
				luaRemoveByName(rndTbl, rnd.Name)
-- RELEASE_LOGOFF  				luaLog("BB SPAWNOLVA")
			else
				groupTbl = {carrier, destroyer1, destroyer2}
				luaRemoveByName(rndTbl, rnd.Name)
-- RELEASE_LOGOFF  				luaLog("BB nem spawnolva.")
			end
--[[
-- RELEASE_LOGOFF  			luaLog("-------------------------------------")
-- RELEASE_LOGOFF  			luaLog(groupTbl)
-- RELEASE_LOGOFF  			luaLog("-------------------------------------")
]]
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = groupTbl,
			["area"] = {
				["refPos"] = GetPosition(spawnIde),
				["angleRange"] = {-1, 1},
				["lookAt"] = GetPosition(Mission.StartPoint),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 150,
			},
			["callback"] = "luaUS08Phase02RandomSpawnReady",
		})
		
		end
-- RELEASE_LOGOFF  			luaLog("---------------------------")
end

function luaUS08Phase02RandomSpawnReady(...)
	Mission.SpawnEnded = true
	local fLeader = nil
	local formationTbl = {}

	for i,v in ipairs(arg) do
		UnitFreeAttack(v)
		if v.Class.Type == "MotherShip" then
			table.insert(Mission.JAPCarriers, v)
			fLeader = v
		elseif v.Class.Type == "BattleShip" then
				Mission.BBSpawned = Mission.BBSpawned + 1
				table.insert(Mission.JAPBBs, v)
				table.insert(Mission.CarrierScreens, v)
		else
				table.insert(Mission.CarrierScreens, v)
		end

		table.insert(formationTbl, v)
	end
	SetFormationShape(fLeader, 3)
	SetShipMaxSpeed(fLeader, Mission.JAPCarriersSpawned*3 + 10)
	
	Mission.JAPCarriersSpawned = Mission.JAPCarriersSpawned + 1

	if Mission.JAPCarriersSpawned == 4 then
		AddListener("kill", "CarrierlistenerID", {
		["callback"] = "luaUS08CarrierDead",  -- callback fuggveny
		["entity"] = Mission.JAPCarriers, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
		AddListener("recon", "BBReconlistenerID", {
		["callback"] = "luaUS08BBRecon",  -- callback fuggveny
		["entity"] = Mission.JAPBBs, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = { PARTY_ALLIED },
		})
		
		Mission.Kongo = FindEntity("Kongo")
		AddListener("kill", "KongolistenerID", {
			["callback"] = "luaUS08KongoKilled",  -- callback fuggveny
			["entity"] = {Mission.Kongo}, -- entityk akiken a listener aktiv
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
	end
	local usunits = luaGetOwnUnits()
	usunits = luaRemoveDeadsFromTable(usunits)
	for idx, unit in pairs(usunits) do
		SetForcedReconLevel(unit, 2,PARTY_JAPANESE)
	end
end
function luaUS08CarrierDead(...)
	luaUS08StartDialog("screen_move")
	Mission.LastSinkCarrier = arg[1]
end
function luaUS08BBRecon()
	RemoveListener("recon", "BBReconlistenerID")
	luaDelay(luaUS08AddSecondary, 10)
end
function luaUS08AddSecondary()
	luaObj_Add("secondary", 1, Mission.JAPBBs)
end
function luaUS08AddPrimary2()
	local paths = {FindEntity("CarrierPath1"), FindEntity("CarrierPath2"), FindEntity("CarrierPath3"), FindEntity("CarrierPath4")}
	local i = 4
	for idx, unit in pairs(Mission.JAPCarriers) do
		--NavigatorAttackMove(GetFormationLeader(unit), luaPickRnd(Mission.USCarriers),{})
		local num = random(1,i)
-- RELEASE_LOGOFF  		luaLog("Move on Path")
-- RELEASE_LOGOFF  		luaLog(num)
-- RELEASE_LOGOFF  		luaLog(GetFormationLeader(unit).Name)
		NavigatorMoveOnPath(GetFormationLeader(unit), paths[num], PATH_FM_CIRCLE, PATH_SM_JOIN)
		table.remove(paths, num)
		i = i - 1
	end
		luaObj_Add("primary", 3, Mission.JAPCarriers)
end
function luaUS08Phase02ScreenChecker()

	if Mission.SpawnEnded then
-- RELEASE_LOGOFF  		luaLog("Screenchk fut")
		
		Mission.CarrierScreens = luaRemoveDeadsFromTable(Mission.CarrierScreens)

		local newTarget

		for idx, unit in pairs(Mission.CarrierScreens) do
			local wtf = luaGetShipsAround(unit, 1500, "own", nil, nil, "mothership")
			 if not wtf then

				Mission.JAPCarriers = luaRemoveDeadsFromTable(Mission.JAPCarriers)
				newTarget = luaSortByDistance(unit, Mission.JAPCarriers, true)
-- RELEASE_LOGOFF  				luaLog("NEUES ZIEL: ")
-- RELEASE_LOGOFF  				luaLog(newTarget.Name)
-- RELEASE_LOGOFF  				luaLog("_-_-_-_-_-_-_-_-_-")

-- RELEASE_LOGOFF  				luaLog("menes van")

					local screenPos = GetPosition(newTarget)
					local modPos = ({["x"]=(screenPos.x-700),["y"]=screenPos.y,["z"]=screenPos.z-700})

					if (Mission.Difficulty ~= 0) and (unit.Class.Type == "BattleShip") then
						local bbTarget = luaPickRnd(Mission.USCarriers)
-- RELEASE_LOGOFF  						luaLog(unit.Name.." tamadja ot: "..bbTarget.Name)
						if IsInFormation(unit) then
							LeaveFormation(unit)
						end
						NavigatorAttackMove(unit, bbTarget, {})
					else
						NavigatorMoveToPos(unit, modPos)
						JoinFormation(unit, newTarget)
					end
			end
		end
	end
end

function luaUS08Cheat()
	if Mission.MissionPhase == 1 then
		for i=1,table.getn(Mission.JAPPlanes) do
			Kill(Mission.JAPPlanes[i])
		end
	elseif Mission.MissionPhase == 2 then
		for i=1,table.getn(Mission.JAPCarriers) do
			Kill(Mission.JAPCarriers[i])
		end
	end
end

function luaUS08Phase02ObjectiveChecker()
		if Mission.PRI02Failed == true or Mission.PRI03Failed == true then
			Mission.EndMission = true
			Mission.MissionPhase = 666

			if Mission.PRI02Failed == true then
				Mission.EndMission = true
				Mission.MissionPhase = 666
				luaObj_Failed("secondary", 1)
				luaClearDialogsCallback()
				luaMissionFailedNew(Mission.DeadCarrier, "usn08.obj_nomorecarriers")
				HideScoreDisplay(1, 0)
			elseif Mission.PRI03Failed == true then
				Mission.EndMission = true
				Mission.MissionPhase = 666
				luaObj_Failed("secondary", 1)
				pEntity = luaPickRnd(Mission.JAPCarriers)
				luaClearDialogsCallback()
				luaMissionFailedNew(pEntity, "usn08.obj_carrierssurvived")
				HideScoreDisplay(1, 0)
			end

		elseif (Mission.PRI02Failed == false) and (Mission.PRI03Failed == false) then
			if (Mission.Narwhal == nil) or (not Mission.Narwhal.Dead) then
				luaObj_Completed("hidden", 1, true)
			end

			Mission.EndMission = true
			Mission.MissionPhase = 666
			luaMissionCompletedNew(Mission.LastSinkCarrier, "usn08.obj_p3_compl")
			HideScoreDisplay(1, 0)
		end
end

function luaUS08Phase01BringOutTheDead()

		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)

		if table.getn(Mission.USCarriers) == 0 then
			luaObj_Failed("primary", 3)
			luaObj_Failed("primary", 2)
			Mission.PRI02Failed = true
		else
			Mission.PRI02Failed = false
		end
end

function luaUS08Phase02BringOutTheDead()

	if Mission.SpawnEnded then
		Mission.USCarriers = luaRemoveDeadsFromTable(Mission.USCarriers)
		Mission.JAPCarriers = luaRemoveDeadsFromTable(Mission.JAPCarriers)

		if table.getn(Mission.USCarriers) ~= 0 then
			if table.getn(Mission.JAPCarriers) == 2 then
-- RELEASE_LOGOFF  				luaLog("ITT A NAGY SZOPAS")
-- RELEASE_LOGOFF  				luaLog("Ennyi a szopas: "..table.getn(Mission.JAPCarriers))
				luaObj_Completed("primary", 2, true)
				luaObj_Completed("primary", 3)
				Mission.PRI02Failed = false
				Mission.PRI03Failed = false
			end
		else
			luaObj_Failed("primary", 3)
			luaObj_Failed("primary", 2)
			Mission.PRI02Failed = true
			Mission.PRI03Failed = true
		end
	else
		return
	end
end

function luaUS08Bronze()

		local hdnTbl = {}
-- RELEASE_LOGOFF  		luaLog("BRONZ FUT, FAZIS: "..Mission.MissionPhase)
		for i=1,4 do
			table.insert(hdnTbl, luaFindHidden("H8K Emily 0"..i))
			Mission.JAPSecondWave[i] = GenerateObject(hdnTbl[i].Name, "H8K Emily 0"..i)
			table.insert(Mission.JAPPlanes, Mission.JAPSecondWave[i])
		end

		AddListener("recon", "recon_emily", {
				["callback"] = "luaUS08EmilyDetected",  -- callback fuggveny
				["entity"] = {Mission.JAPSecondWave[1]}, -- entityk akiken a listener aktiv
				["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {1}, -- 0: undetected, 1: detected, 2-4: identified
				["party"] = { PARTY_ALLIED },
		})
		
end

function luaUS08Gold()
		for i=1,table.getn(Mission.USCarriers) do
			AddAirBaseStock(Mission.USCarriers[i],102,6)
			luaUS08StartDialog("corsairs_ready")
			--StartDialog("crs_rdy", Mission.Dialogues["corsairs_ready"])
		end
end
function luaUS08StartIntroDlg()
		--luaUS08StartDialog("intro")
	    StartDialog("Intro_dlg", Dialogues["intro"]);
end


function luaUS08EmilyDetected()
		RemoveListener("recon", "recon_emily")
		luaUS08StartDialog("emily_incoming")
		--luaJumpinMovieSetCurrentMovie("JumpTo", Mission.JAPSecondWave[1].ID)
end

function luaUS08StartDialog(dialogID)
	if (Mission.Dialogues[dialogID].printed == nil) then
		StartDialog(dialogID, Mission.Dialogues[dialogID])
		Mission.Dialogues[dialogID].printed = true
	end
end
function luaUS08ShowSubJoinedHint()
	if GetSelectedUnit() ~= Mission.Narwhal and Mission.Narwhal.Dead == false then
		ShowHint("USN08_Hint_Sub_Joined")
		luaDelay(luaUS08ShowSubJoinedHint, 2)
	end
end
function luaUS08Sub()
		--luaJumpinMovieSetCurrentMovie("JumpTo", Mission.JAPCarriers[1].ID)
		luaDelay(luaUS08HintSubDive, 32)
		--[[
		if (Mission.Difficulty == 0) or (Mission.Difficulty == 1) then
			ShipSetTorpedoStock(Mission.Narwhal, 24)
		elseif Mission.Difficulty == 2 then
			ShipSetTorpedoStock(Mission.Narwhal, 24)
			AddListener("hit", "listenerTaihoHit", {
				["callback"] = "luaUS08Jammed", -- callback fuggveny
				["target"] = {Mission.JAPCarriers[1]}, -- entityk akiken a listener aktiv
				["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
				["attacker"] = {Mission.Narwhal}, -- tamado entityk
				["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
				["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
				["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
				["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
				["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
			})
		end
		]]
		SetRoleAvailable(Mission.Narwhal, EROLF_ALL, PLAYER_ANY)

		if Mission.Difficulty > 0 then
--			LeaveFormation(Mission.CarrierScreens[2])
			NavigatorAttackMove(Mission.CarrierScreens[2], Mission.Narwhal, {})
		end
		if Mission.Difficulty > 1 then
--			LeaveFormation(Mission.CarrierScreens[3])
			NavigatorAttackMove(Mission.CarrierScreens[3], Mission.Narwhal, {})
		end	
end
--[[
function luaUS08Jammed()
		RemoveListener("hit", "listenerTaihoHit")
		TorpedoEnable(Mission.Narwhal, false)
		--luaUS08StartDialog("computer_broken")
end
]]
function luaUS08SpawnSecondAirStrike()
-- RELEASE_LOGOFF  	luaLog("-------------------------------------")
	local Jill = {
			["Type"] = 163,
			["Name"] = "B6N Jill",
			["Equipment"] = 1,
			}
	local Judy = {
			["Type"] = 159,
			["Name"] = "D4Y Judy",
			["Equipment"] = 1,
			}
	local Oscar = {
			["Type"] = 154,
			["Name"] = "Ki-43 Oscar",
			["Equipment"] = 1,
			}
	local Betty = {
			["Type"] = 167,
			["Name"] = "G4M Betty",
			["Equipment"] = 1,
			}
	local Nell = {
			["Type"] = 166,
			["Name"] = "G3M Nell",
			["Equipment"] = 1,
			}
	local Gekko = {
			["Type"] = 152,
			["Name"] = "J1N1 Gekko",
			["Equipment"] = 1,
			}
	local alltypes = {Jill, Judy, Oscar, Betty, Nell, Gekko}
	local tospawn = (Mission.Difficulty + 1) * 3
	
	local groupTbl = {}
	for i = 1,tospawn do
		table.insert(groupTbl, luaPickRnd(alltypes))
	end
	local spawnIde = GetPosition(luaPickRnd(Mission.RadioPoints))
	spawnIde = GetClosestBorderZone(spawnIde)
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	if table.getn(Mission.USUnits) > 0 then
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = groupTbl,
		["area"] = {
			["refPos"] = spawnIde,
			["angleRange"] = {-1, 1},
			["lookAt"] = GetPosition(Mission.USUnits[1]),
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		["callback"] = "luaUS08SecondAirStrikeSpawnReady",
	})
	end
end
function luaUS08SecondAirStrikeSpawnReady(...)
-- RELEASE_LOGOFF  	luaLog("Second strike")
	Mission.SecondAirStrike = {}
	local trg = luaGetOwnUnits("ship")
	for i = 1, table.getn(arg) do
		PilotSetTarget(arg[i], luaPickRnd(trg))
		SquadronSetTravelSpeed(arg[i],66)
		table.insert(Mission.SecondAirStrike, arg[i])
	end
	AddListener("recon", "SecondairreconID", {
		["callback"] = "luaUS08AirStrikeSighted",  -- callback fuggveny
		["entity"] = Mission.SecondAirStrike, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = { PARTY_ALLIED },
		})
end
function luaUS08AirStrikeSighted()
	RemoveListener("recon", "SecondairreconID")
	luaUS08StartDialog("second_air_strike")
	luaDelay(luaUS08ValamikorDlg, 150)
end
function luaUS08ValamikorDlg()
	luaUS08StartDialog("valamikor")
end

function luaUS08AddPowerup(type)
-- RELEASE_LOGOFF  	luaLog("powerup granted "..tostring(type))
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrativeEnqueue("missionglobals.newpowerup")
end
function luaUS08RelocateFleet()
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	local unitstorelocate = {}
	for idx, unit in pairs(Mission.USUnits) do
		if IsInFormation(unit) then
			if IsFormationFollower(unit) == false then
				table.insert(unitstorelocate, unit)
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog(unitstorelocate)
	
	local pos = GetPosition(Mission.StartPoint)
	pos.x = pos.x - 1200
	pos.z = pos.z + 1200
	pos.y = 0
	for idx, unit in pairs(unitstorelocate) do
		PutTo(unit, pos)
		pos.x = pos.x + 1200
		pos.z = pos.z - 1200
	end
end
function luaUS08TurkeyShotAchievementChecker()
	local sd = Scoring_GetPlayerShotDown()
	if sd > 19 then
		SetAchievements("MA_MT")
		luaUS08StartDialog("turkey_shot")
		Mission.TurkeyDone = true
-- RELEASE_LOGOFF  		luaLog(" *** achievement *** ")
	elseif sd > 14 then
		luaUS08StartDialog("kill_50")
	elseif sd > 8 then
		luaUS08StartDialog("kill_30")
	end
end
function luaUS08Checkpoint1Load()
	Blackout(true, "", 0)
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
		if not luaUS08IsInside(unit.Name, usn) then
-- RELEASE_LOGOFF  			luaLog("Kill")
-- RELEASE_LOGOFF  			luaLog(unit.Name)
			Kill(FindEntity(unit.Name), true)
		end
		--SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
	end
	for idx, unit in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
		Kill(unit, true)
	end
	for idx, unit in pairs(Mission.USCarriers) do
		SetAirBaseSlotCount(unit, 4)
	end
end
function luaUS08SetChangeableGUIName(unit)
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
function luaUS08IsInside(find, tab)
	
	for idx, unit in pairs(tab) do
		if find == unit then
			return true
		end
	end
	return false
end
function luaUS08Checkpoint1Save()
end
