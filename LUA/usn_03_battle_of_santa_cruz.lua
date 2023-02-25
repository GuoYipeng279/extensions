DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--SceneFile="missions\USN\usn_03_Battle_of_Santa_Cruz.scn"
function luaEngineMovieInit()
	local ZuihoGrp = {"Zuiho", "Kumano", "Hamakaze", "Yukikaze", "Hatsukaze"}
	local JunyoGrp = {"Junyo", "Kuroshio", "Hayashio"}
	for idx, unit in pairs(JunyoGrp) do
		GenerateObject(unit)
	end
	for idx, unit in pairs(ZuihoGrp) do
		GenerateObject(unit)
	end
	
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("usn03dlg",1)
	
	Dialogues = {
		["dlg_Idlg"] = {
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
				{
					["message"] = "idlg01_1",
				},
				{
					["message"] = "idlg02",
				},
				{
					["message"] = "idlg03",
				},
			},
		},
		["dlg_Idlg2"] = {
			["sequence"] = {
				{
					["message"] = "idlg04",
				},
			}
		}
	}
	
	MissionNarrative("usn03.date_location")
	luaDelay(luaUS03StartIntroDialog, 16)
	luaDelay(luaUS03StartIntroDialog2, 88)
end
function luaUS03StartIntroDialog()
	StartDialog("dlg_Idlg", Dialogues["dlg_Idlg"])
end
function luaUS03StartIntroDialog2()
	StartDialog("dlg_Idlg2", Dialogues["dlg_Idlg2"])
end
function luaStageInit()
	CreateScript("luaInitUS03")
	Scoring_RealPlayTimeRunning(true)
end
function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(150)
	PrepareClass(159)
	PrepareClass(108)
	PrepareClass(113)
	PrepareClass(171)
	--[[
	if Scoring_IsUnlocked("USN02_SILVER") then
		PrepareClass(116) -- B17
	end
	]]
	Loading_Finish()
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaInitUS03(this)
	EnableMessages(true)
	Mission = this
	Mission.Name = "US03"
	Mission.ScriptFile = "scripts/missions/USN/usn_03_battle_of_santa_cruz.lua"
	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false
	
	-- aTom Fix
	Mission.Suspicious = 0
	-- aTom Fix end
		
	SETLOG(Mission, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..Mission.Name.." mission!")
			
	-- mission 
	Mission.Party = SetParty(Mission, PARTY_ALLIED)
	
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS03Checkpoint1Load},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS03Checkpoint1Save},
	}
	
	-- Puffin
	
	Mission.Puffin = FindEntity("Puffin")
	NavigatorMoveOnPath(Mission.Puffin, FindEntity("PuffinPath"), PATH_FM_PINGPONG)
	-- Allied hajok
	
	Mission.Enterprise = FindEntity("Enterprise")
	
	Mission.EnterpriseGrp = {Mission.Enterprise,FindEntity("Maury"),FindEntity("Cushing"), FindEntity("Preston")}
	--[[
	for idx = 2, table.getn(Mission.EnterpriseGrp) do
		SetInvincible(Mission.EnterpriseGrp[idx], 0.1)
	end
	]]
	luaUS03JoinFormations(Mission.EnterpriseGrp)
	
	Mission.JunyoGrp = {}
	Mission.HornetKillers = {}	
	Mission.HornetCAP = {}
	
	-- Navpontok, koordinatak
	
		Mission.Navpoint_Endcamera = FindEntity("Navpoint_Endcamera")
		Mission.Navpoint_North01 = FindEntity("Navpoint_North01")
		Mission.Navpoint_North02 = FindEntity("Navpoint_North02")
	-- Support Manager tiltas
	--BannSupportmanager()

	this.ChangeableNames = {}
	this.ChangeableNames[11] = {	-- AllenMSumner
		"ingame.shipnames_moale",
		"ingame.shipnames_ingraham",
		"ingame.shipnames_hank",
		"ingame.shipnames_borie",
		"ingame.shipnames_hyman",
		"ingame.shipnames_compton",
		"ingame.shipnames_soley"
	}
	this.ChangeableNames[48] = {	-- ASWFletchers
		"ingame.shipnames_melvin",
		"ingame.shipnames_hopewell",
		"ingame.shipnames_wadleigh",
		"ingame.shipnames_mertz",
		"ingame.shipnames_remey",
		"ingame.shipnames_picking",
		"ingame.shipnames_stockham"
	}
	this.ChangeableNames[900] = {	-- Luppis
		"ingame.shipnames_bristol",
		"ingame.shipnames_charles_s_sperry",
		"ingame.shipnames_harlan_r_dickson",
		"ingame.shipnames_walke",
		"ingame.shipnames_de_haven",
		"ingame.shipnames_strong",
		"ingame.shipnames_english",
	}
	this.ChangeableNames[17] ={	-- Atlanta
		"ingame.shipnames_spokane",
		"ingame.shipnames_fresno",
		"ingame.shipnames_tucson"
	}
	this.ChangeableNames[390] ={	-- Alaska
		"ingame.shipnames_puerto_rico",
		"ingame.shipnames_philippine",
		"ingame.shipnames_hawaii",
	}
	
	-- Achievements init
	

	-- difficulty
	Mission.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(Mission.Difficulty))

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	-- dialogusok

	LoadMessageMap("usn03dlg", 1)
	
	Mission.Dialogues = {
		["dlg_Init"] = {
			["sequence"] = {
				{
					["message"] = "Idlg04",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03AddObj1",
				},
			},
		},
		["dlg_Cruiser_to_attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg01",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03CruiserToAttack",
				},
			},
		},
		["dlg_Cruiser_attacked"] = {
			["sequence"] = {
				{
					["message"] = "dlg02",
				},
			},
		},
		["dlg_Enterprise_AA_used"] = {
			["sequence"] = {
				{
					["message"] = "dlg03",
				},
				{
					["message"] = "dlg04",
				},
			},
		},
		["dlg_Anvil_attack"] = {
			["sequence"] = {
				{
					["message"] = "dlg05",
				},
				{
					["message"] = "dlg06",
				},
				{
					["message"] = "dlg07",
				},
				{
					["message"] = "dlg08",
				},
				{
					["message"] = "dlg09",
				},
				{
					["message"] = "dlg10",
				},
				{
					["message"] = "dlg10_1",
				},
				{
					["message"] = "dlg11",
				},
			},
		},
		["dlg_1st_fighters"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
				{
					["message"] = "dlg13",
				},
			},
		},
		["dlg_HornetStarts"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
				{
					["message"] = "dlg15",
				},
			},
		},
		["dlg_EnemyStrikeSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
				{
					["message"] = "dlg17",
				},
			},
		},
		["dlg_Vanguard_on_recon"] = {
			["sequence"] = {
				{
					["message"] = "dlg18",
				},
				{
					["message"] = "dlg19",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03VanguardHint",
				},
			},
		},
		["dlg_Cruisersinrange"] = {
			["sequence"] = {
				{
					["message"] = "dlg20",
				},
				{
					["message"] = "dlg21",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03Primary4Add",
				},
			},
		},
		["dlg_HornetStrike"] = {
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
			},
		},
		["dlg_Hornetcrippled"] = {
			["sequence"] = {
				{
					["message"] = "dlg24",
				},
				{
					["message"] = "dlg25",
				},
				{
					["message"] = "dlg26",
				},
				{
					["message"] = "dlg27",
				},
				{
					["message"] = "dlg28",
				},
				{
					["message"] = "dlg29",
				},
				{
					["message"] = "dlg30",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg31",
				},
			},
		},
		["dlg_Hornetkill"] = {
			["sequence"] = {
				{
					["message"] = "dlg32",
				},
				{
					["message"] = "dlg33",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03AddHornetObjCallback",
				},
			},
		},
		["dlg_HornetKilledByPlayer"] = {
			["sequence"] = {
				{
					["message"] = "dlg37",
				},
				{
					["message"] = "dlg38",
				},
				{
					["type"] = "callback",
					["callback"] = "luaUS03HornetObjCompletedCallback",
				},
			},
		},
		["dlg_USBattleshipsIncoming1"] = {
			["sequence"] = {
				{
					["message"] = "dlg44",
				},
				{
					["message"] = "dlg44_1",
				},
			},
		},
		["dlg_USBattleshipsIncoming2"] = {
			["sequence"] = {
				{
					["message"] = "dlg45",
				},
			},
		},
		["dlg_USBattleshipsArrived"] = {
			["sequence"] = {
				{
					["message"] = "dlg46",
				},
				{
					["message"] = "dlg47",
				},
			},
		},
		["dlg_Vanguardcloses"] = {
			["sequence"] = {
				{
					["message"] = "dlg34",
				},
				{
					["message"] = "dlg35",
				},
			},
		},
		["dlg_Escape"] = {
			["sequence"] = {
				{
					["message"] = "dlg36",
				},
				{
					["message"] = "dlg36_1",
				},
			},
		},
		["dlg_1sthit_Zuiho"] = {
			["sequence"] = {
				{
					["message"] = "dlg39",
				},
			},
		},
		["dlg_vanguard_radio_hint"] = {
			["sequence"] = {
				{
					["message"] = "dlg40",
				},
				{
					["message"] = "dlg41",
				},
			},
		},
	}
	
	-- objektivak
	
	Mission.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "SendCAP",		-- azonosito
				["Text"] = "usn03.obj_p1",
				["TextCompleted"] = nil ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "ProtectEnterprise",		-- azonosito
				["Text"] = "usn03.obj_p2",
				["TextCompleted"] = nil ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "SinkDummyCarrier",		-- azonosito
				["Text"] = "usn03.obj_p3",
				["TextCompleted"] = nil ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = (500)*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[4] =
			{
				["ID"] = "SinkCarrier",		-- azonosito
				["Text"] = "usn03.obj_p4",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
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
				["ID"] = "SinkHornet",		-- azonosito
				["Text"] = "usn03.obj_s1",
				["TextCompleted"] = "usn03.obj_s1_comp",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
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
				["ID"] = "DestroyVanguard",		-- azonosito
				["Text"] = "usn03.obj_h1",
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
	
	luaInitNewSystems()

    SetDeviceReloadTimeMul(0)
    SetThink(Mission, "US03Think")
	
	SetSelectedUnit(Mission.Enterprise)
	--SetRoleAvailable(Mission.Enterprise, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Enterprise, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Enterprise, EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.Enterprise, PCF_NONE)

	--SoundFade(0,"", 1)
	
	Blackout(true, "", 0)
	
-- RELEASE_LOGOFF  	AddWatch("Mission.MissionPhase")

	Mission.HackCounter = 0
	Mission.MaxFirstEnterpriseAttackerWaveNumber = 2
	Mission.FirstEnterpriseAttackerWaveNumber = 0
	Mission.FirstEnterpriseAttackersCooldown = 40
	
	if Mission.Difficulty == 2 then -- hard
		Mission.Phase1AttackersCooldown = 40
		Mission.HornetCAPNumber = 1
		Mission.ConstantAirWaveSpawnCooldown = 20
		
	else							-- normal
		Mission.Phase1AttackersCooldown = 60
		Mission.HornetCAPNumber = 3
		Mission.ConstantAirWaveSpawnCooldown = 30
	end
	
	SetDeviceReloadEnabled(true)
	
	--luaUS03GotoPhase4()	-- CHEAT
	Mission.OutOfPlanesCounter = 0
	
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded then
		Mission.MissionPhase = 4
	else
		Mission.MissionPhase = 0
		SetAirBaseSlotCount(Mission.Enterprise, 2)
	end
	luaObj_Add("hidden",1)
end

function US03Think(this, msg)
	--luaLog(Mission.Name.." mission is thinkin' in phase "..Mission.MissionPhase)
	--luaObj_Reminder()
	
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(Mission.Name.." mission is terminated!")
		return
	end

	luaCheckMusic()
	--luaUS03CheckConditions(this)
	
	if Mission.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	luaCheckMusic()

	if Mission.Puffin.Dead == false then
		ForceFireDepthCharge(Mission.Puffin)
	end
	
-- MissionPhases
	if Mission.MissionPhase == 0 then
		ForceRecon()
		for idx, unit in pairs(luaGetOwnUnits("ship", PARTY_JAPANESE)) do
			Kill(unit, true)
		end
		SetForcedReconLevel(Mission.Enterprise, 2, PARTY_JAPANESE)
		luaDelay(luaUS03StartInitDialog, 7)
		luaDelay(luaUS03USBattleshipsIncoming1, 35)
		-- aTom Fix
		if (not IsListenerActive("kill", "Listener_EnterpriseWasDestroyed")) then
			AddListener("kill", "Listener_EnterpriseWasDestroyed", 
			{
				["callback"] = "luaUS03_EnterpriseWasDestroyed",
				["entity"] = {Mission.Enterprise},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
			})
		end
		-- aTom Fix end
		Mission.MissionPhase = 1
		Mission.Timer = GameTime() + 300	-- 5 minutes
		Blackout(false, "", 3)
		--SoundFade(1, "",0.1)
		
	elseif Mission.MissionPhase == 1 then
		if Mission.Dialogues["dlg_1st_fighters"].printed ~= true then
			activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Enterprise)
			if squadEntTable then
				for idx, unit in pairs (squadEntTable) do
					if unit.Class.Name == "globals.unitclass_wildcat" then
						luaUS03StartDialog("dlg_1st_fighters")
					end
				end
			end
		end
		if luaObj_IsActive("primary", 1) and not luaObj_GetSuccess("primary", 1) then
			DisplayScores(1, 0, "usn03.obj_p1","usn03.obj_p1_wildcat_launched")
		end
		if GameTime() > Mission.Timer then
			HideScoreDisplay(1, 0)
			Mission.MissionPhase = 2
			luaDelay(luaUS03AddObj2, 4)
			RepairEnable(Mission.Enterprise, false)
			for idx, unit in pairs(Mission.EnterpriseGrp) do
				SetSkillLevel(unit, SKILL_STUN)
				RepairEnable(unit, false)
			end
			Mission.MaxFirstEnterpriseAttackerWaveNumber = 120
			Mission.FirstEnterpriseAttackersCooldown = 15
			HideHint()
			luaObj_Failed("primary", 1)
			HideScoreDisplay(1, 0)
			luaUS03SpawnPhase1EnterpriseKillers()
			luaUS03StartDialog("dlg_EnemyStrikeSighted")
		else
			Mission.activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Enterprise)
			if Mission.activeSquads == 2 then
				Mission.MissionPhase = 666
				luaDelay(luaUS03GotoPhase2, 3)
			end
		end
	elseif Mission.MissionPhase == 2 then
		if Mission.Dialogues["dlg_Enterprise_AA_used"].printed == nil then
			if HasFired(Mission.Enterprise,"AAMACHINEGUN",3.0) then
				luaUS03StartDialog("dlg_Enterprise_AA_used")
			end
		end
		-- aTom Fix
		--[[if Mission.Enterprise.Dead then
			luaObj_Failed("primary", 2)
			luaMissionFailedNew(Mission.Enterprise, "usn03.obj_p2_fail", nil, true)
			Mission.EndMission = true
			return
		end]]--
		-- aTom Fix end
		
		--if Mission.FirstEnterpriseAttackerWaveNumber == Mission.MaxFirstEnterpriseAttackerWaveNumber then
		local enemy = luaGetOwnUnits("plane", PARTY_JAPANESE)
		if table.getn(enemy) == 0 then	-- all planes down			
			HideScoreDisplay(1, 0)
			Mission.MissionPhase = 666
			MissionNarrative("usn03.obj_firstwaverepelled")
			luaDelay(luaUS03GotoPhase3Pre, 3)
			return
		end
		
	elseif Mission.MissionPhase == 3 then
		Mission.EnterpriseGrp = luaRemoveDeadsFromTable(Mission.EnterpriseGrp)
		if Mission.Enterprise.Dead then
			luaObj_Failed("primary", 2)
			luaMissionFailedNew(Mission.Enterprise, "usn03.obj_p2_fail", nil, true)
			Mission.EndMission = true
			return
		end
		local EnterpriseOutOfPlanes = true
		local EnterpriseStock = GetProperty(Mission.Enterprise, "stock")
		for idx, unit in pairs(EnterpriseStock) do
			if unit.count ~= 0 then
				EnterpriseOutOfPlanes = false
				break
			end
		end

		-- aTom Fix
		local USNPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)
		local i = table.getn(USNPlanes) + 1
		while (i > 1) do
			i = i - 1
			if (USNPlanes[i].Class.ID == 121) then	--az AI altal iranyitott Kingfishert nem vesszuk figyelembe
				table.remove(USNPlanes, i)
			end
		end
		if (table.getn(USNPlanes) > 0) then
			EnterpriseOutOfPlanes = false
		end
		--[[ez egy kurva fapados megoldas, de mivel a kod bugos, kenytelen voltam igy megcsinalni -> 2 thinkkel kellett kesleltetni a levizsgalast (ha mar 2x egymas utan gyanus hogy a szitu bekovetkezett),
		mert amikor az utolso gepet felkuldi a player, a stock mar kiurul, de a carrier "planes" property-jebe es a GetOwnUnits tablaba csak kb. 2 thinkkel kesobb kerul be a gep.]]--
		if (EnterpriseOutOfPlanes) and (Mission.Suspicious < 2) then
			Mission.Suspicious = Mission.Suspicious + 1
		elseif (not EnterpriseOutOfPlanes) and (Mission.Suspicious ~= 0) then
			Mission.Suspicious = 0
		elseif (EnterpriseOutOfPlanes) and (Mission.Suspicious == 2) then
		-- aTom Fix end
		
			luaObj_Failed("primary", 2)
			luaMissionFailedNew(Mission.Enterprise, "usn03.obj_outofplanes", nil, true)
			Mission.EndMission = true
			return
		end
		if Mission.Junyo.Dead then
			return
		end
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		luaAirfieldManager(Mission.Junyo, {150}, {158, 162}, Mission.USUnits, 700)
		if GetSelectedUnit() == nil then
			ShowHint("USN03_Hint_Reinforce")
		end
	elseif Mission.MissionPhase == 4 then	-- Enterprise is still on the map
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		Mission.EnterpriseGrp = luaRemoveDeadsFromTable(Mission.EnterpriseGrp)
		if Mission.Enterprise.Dead and Mission.Enterprise.KillReason~="exitzone" then
			luaObj_Failed("primary", 2)
			luaMissionFailedNew(Mission.Enterprise, "usn03.obj_p2_fail", nil, true)
			Mission.EndMission = true
			return
		end
		ForceRecon()
		if table.getn(luaGetOwnUnits()) == 1 then	-- Only Enterprise
			local planesremaining = 0
			local stock = GetProperty(Mission.Enterprise, "stock")
			for idx, unit in pairs(stock) do
				planesremaining = planesremaining + unit.count
			end
			if planesremaining == 0 then	-- Out of stock
				Mission.OutOfPlanesCounter = Mission.OutOfPlanesCounter + 1
			else
				Mission.OutOfPlanesCounter = 0
			end
			if Mission.OutOfPlanesCounter > 4 then
				luaObj_Failed("primary", 2)
				luaMissionFailedNew(Mission.Enterprise, "usn03.obj_outofplanes", nil, true)
				Mission.EndMission = true
				return
			end
		end
		Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
		if table.getn(Mission.Vanguard) ~= 0 and Mission.Dialogues["dlg_Vanguardcloses"].printed == nil then
			for idx, unit in pairs(Mission.Vanguard) do
				if luaGetDistance(Mission.Enterprise, unit) < 1200 then
					luaUS03StartDialog("dlg_Vanguardcloses")
					break
				end
			end
		end
		luaUS03HornetManager()
		luaAirfieldManager(Mission.Zuiho, {150}, {158, 162}, Mission.USUnits, 700)
		luaUS03ManageNorth()
		
	elseif Mission.MissionPhase == 5 then	-- Enterprise is out
		Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
		Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
		if table.getn(Mission.USUnits) == 0 then
			Mission.EndMission = true
			if table.getn(Mission.Vanguard) ~= 0 then
				luaMissionFailedNew(Mission.Vanguard[1], "usn03.obj_mission_fail", nil, true)
			else
				luaMissionFailedNew(nil, "usn03.obj_mission_fail", nil, true)
			end
			return
		end
		if table.getn(Mission.Vanguard) ~= 0 and Mission.Dialogues["dlg_Vanguardcloses"].printed == nil and Mission.Enterprise.Dead == false then
			for idx, unit in pairs(Mission.Vanguard) do
				if luaGetDistance(Mission.Enterprise, unit) < 1200 then
					luaUS03StartDialog("dlg_Vanguardcloses")
					break
				end
			end
		end
		luaUS03HornetManager()
		luaAirfieldManager(Mission.Zuiho, {150}, {158, 162}, Mission.USUnits, 700)
		luaUS03ManageNorth()
	end
	
	if Mission.HintDefenceShown == nil and Mission.Enterprise.Dead == false then
		if GetHpPercentage(Mission.Enterprise) < 0.5 then
			ShowHint("USN03_Hint_Defence")
			Mission.HintDefenceShown = true
		end
	end
end
function luaUS03HornetManager()
	if not Mission.HornetStatus then
-- RELEASE_LOGOFF  		AddWatch("Mission.HornetStatus")
		Mission.HornetStatus = 1
		Mission.HornetTimer = GameTime() + 90
	elseif Mission.HornetStatus == 1 then
		if GameTime() > Mission.HornetTimer then
			luaUS03HornetStartsNorth()
			luaUS03SpawnFakeDivebombers()
			Mission.HornetStatus = 2
			Mission.HornetTimer = GameTime() + 200
		end
	elseif Mission.HornetStatus == 3 then
		if GameTime() > Mission.HornetTimer then
			luaUS03AddHornetObj()
			Mission.HornetStatus = 4
		end
	elseif Mission.HornetStatus == 4 then
		Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
		for idx, unit in pairs(Mission.Vanguard) do
			if luaGetDistance(unit, Mission.Hornet) < 800 then
				RemoveListener("kill", "HornetKillListenerID")
				luaObj_Failed("secondary", 1)
				MissionNarrative("usn03.obj_s1_fail")
				HideScoreDisplay(2, 0)
				Mission.HornetTimer = GameTime() + 20
				Mission.HornetStatus = 6
				Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
				if table.getn(Mission.Vanguard) ~= 0 then
					NavigatorAttackMove(Mission.Vanguard[1], Mission.Enterprise)
				end
				SetInvincible(Mission.Hornet, 0)
				AddDamage(Mission.Hornet, 100000)
			end
		end	
	end
end

-- aTom Fix
function luaUS03_EnterpriseWasDestroyed()
	if (IsListenerActive("kill", "Listener_EnterpriseWasDestroyed")) then
		RemoveListener("kill", "Listener_EnterpriseWasDestroyed")
	end
	luaObj_Failed("primary", 2)
	luaMissionFailedNew(Mission.Enterprise, "usn03.obj_p2_fail", nil, true)
	Mission.EndMission = true
end
-- aTom Fix end

function luaUS03VanguardRadioHint()
	luaUS03StartDialog("dlg_vanguard_radio_hint")
end

function luaUS03VanguardHint()
	MissionNarrative("usn03.enterpriseretreats")
	ShowHint("USN03_Hint_Hidden")
end

function luaUS03SpawnFakeDivebombers()
-- RELEASE_LOGOFF  	luaLog("hornetkillers to spawn")
	SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 159,
						["Name"] = "HornetKiller1",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller2",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller3",	
						["Equipment"] = 1,
					},
					--[[
					{
						["Type"] = 159,
						["Name"] = "HornetKiller4",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller5",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller6",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller7",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller8",
						["Equipment"] = 1,
					},
					]]
				},
				["area"] = {
					["refPos"] = GetPosition(Mission.Zuiho),
					["angleRange"] = { -1, 1},
					["lookAt"] =  GetPosition(Mission.Hornet),
				},
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 100,
					["enemyHorizontal"] = 800,
					["ownVertical"] = 75,
					["enemyVertical"] = 150,
					["formationHorizontal"] = 500,
				},
				["callback"] = "luaUS03InitFakeDivebombers",
			})
end

function luaUS03InitFakeDivebombers(...)
-- RELEASE_LOGOFF  	luaLog("hornetkillers spawned")
	for i = 1, arg.n do
		table.insert(Mission.HornetKillers, arg[i])
		--SetInvincible(arg[i], 0.2)
		if (Mission.Hornet.Dead == false) then
			PilotSetTarget(arg[i],Mission.Hornet)
			SetSkillLevel(arg[1], SKILL_ELITE)
		else
			UnitFreeFire(arg[1])
			if Mission.Enterprise.Dead == false then
				PilotSetTarget(arg[i],Mission.Enterprise)
			end
		end
	end
	Mission.HornetKillers = luaRemoveDeadsFromTable(Mission.HornetKillers)
	if IsListenerActive("hit", "FakeDiveBomberHitlistenerID") then
		RemoveListener("hit", "FakeDiveBomberHitlistenerID")
	end
	AddListener("hit", "FakeDiveBomberHitlistenerID", {
		["callback"] = "luaUS03HornetCrippled", -- callback fuggveny
		["target"] = {Mission.Hornet}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = Mission.HornetKillers, -- tamado entityk
		["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	if not Mission.FakeDivebomberCheckDelay then
		luaUS03FakeDivebombersCheck()
		AddProximityTrigger(Mission.Hornet, "FakeDiveBomberReconlistenerIDlistenerID", "luaUS03HornetStrikeIncoming", Mission.HornetKillers[1], 1500)
	end
end
function luaUS03FakeDivebombersCheck()
	if IsListenerActive("hit", "FakeDiveBomberHitlistenerID") then
		Mission.HornetKillers = luaRemoveDeadsFromTable(Mission.HornetKillers)
		if table.getn(Mission.HornetKillers) == 0 then
			luaUS03SpawnFakeDivebombersAgain()
		end
		Mission.FakeDivebomberCheckDelay = luaDelay(luaUS03FakeDivebombersCheck, 5)
	end
end
function luaUS03SpawnFakeDivebombersAgain()
-- RELEASE_LOGOFF  	luaLog("hornetkillers to spawn again")
	SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 159,
						["Name"] = "HornetKiller1",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller2",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller3",	
						["Equipment"] = 1,
					},
					--[[
					{
						["Type"] = 159,
						["Name"] = "HornetKiller4",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller5",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller6",
						["Equipment"] = 1,
					},
					]]
				},
				["area"] = {
					["refPos"] = {["x"] = -9500, ["y"] = 750, ["z"] = -9500},
					["angleRange"] = { -1, 1},
					["lookAt"] =  GetPosition(Mission.Hornet),
				},
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 100,
					["enemyHorizontal"] = 800,
					["ownVertical"] = 75,
					["enemyVertical"] = 150,
					["formationHorizontal"] = 500,
				},
				["callback"] = "luaUS03InitFakeDivebombers",
			})
	SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = 159,
						["Name"] = "HornetKiller11",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller12",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller13",	
						["Equipment"] = 1,
					},
					--[[
					{
						["Type"] = 159,
						["Name"] = "HornetKiller14",
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller15",	
						["Equipment"] = 1,
					},
					{
						["Type"] = 159,
						["Name"] = "HornetKiller16",
						["Equipment"] = 1,
					},
					]]
				},
				["area"] = {
					["refPos"] = {["x"] = -9500, ["y"] = 750, ["z"] = -2500},
					["angleRange"] = { -1, 1},
					["lookAt"] =  GetPosition(Mission.Hornet),
				},
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 100,
					["enemyHorizontal"] = 800,
					["ownVertical"] = 75,
					["enemyVertical"] = 150,
					["formationHorizontal"] = 500,
				},
				["callback"] = "luaUS03InitFakeDivebombers",
			})
end
function luaUS03HornetCrippled()
	RemoveListener("hit", "FakeDiveBomberHitlistenerID")
	AddDamage(Mission.Hornet, 100000)
	luaDelay(luaUS03HornetCrippledCallback, 8)
end
function luaUS03HornetCrippledCallback()
	Mission.HornetKillers = luaRemoveDeadsFromTable(Mission.HornetKillers)
	for idx, unit in pairs(Mission.HornetKillers) do
		SetInvincible(unit, 0)
	end
	luaUS03StartDialog("dlg_Hornetcrippled")
	Mission.HornetTimer = GameTime() + 50
	Mission.HornetStatus = 3
end
function luaUS03HornetStrikeIncoming()
-- RELEASE_LOGOFF  	luaLog("hornetkillers in recon")
	luaUS03StartDialog("dlg_HornetStrike")
	RemoveTrigger(Mission.Hornet,"FakeDiveBomberReconlistenerIDlistenerID")
end
function luaUS03GotoPhase2()
	selectedunit = GetSelectedUnit()
	HideScoreDisplay(1, 0)
	Mission.MissionPhase = 666
	RepairEnable(Mission.Enterprise, true)
	luaObj_Completed("primary", 1, true)
	Blackout(true, "luaUS03Phase2Movie", 3)
end
function luaUS03Phase2Movie()
	HideUnitHP()
	luaUS03SpawnPhase1EnterpriseAttackers()
	luaUS03StartDialog("dlg_EnemyStrikeSighted")
	Blackout(false, "", 3)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 15, ["theta"] = -25, ["rho"] = 200, ["moveTime"] = 0, ["transformtype"] = "keepnone"},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 17, ["theta"] = -20, ["rho"] = 280, ["moveTime"] = 7, ["nonlinearblend"] = 0.1},
	},
	luaUS03Phase2Movie_end, true)
end
function luaUS03Phase2Movie_end()
	EnableInput(true)
	if selectedunit and selectedunit.Dead == false then
		SetSelectedUnit(selectedunit)
	else
		local selectedunit = luaPickRnd(luaGetOwnUnits("plane"))
		SetSelectedUnit(selectedunit)
	end
	luaDelay(luaUS03AddObj2, 4)
	luaDelay(luaUS03USBattleshipsIncoming2, 30)
	Mission.MissionPhase = 2
end
function luaUS03GotoPhase3Pre()
	Blackout(true,"luaUS03GotoPhase3", 3)
end
function luaUS03GotoPhase3() -- Junyo
	SetAirBaseSlotCount(Mission.Enterprise, 4)
-- RELEASE_LOGOFF  	luaLog("Going to phase 3")
	Mission.JunyoGrp = {"Junyo", "Kuroshio", "Hayashio"}
	for idx, unit in pairs(Mission.JunyoGrp) do
		Mission.JunyoGrp[idx] = GenerateObject(unit)
		RepairEnable(Mission.JunyoGrp[idx], false)
	end
	luaUS03JoinFormations(Mission.JunyoGrp)
	Mission.Junyo = Mission.JunyoGrp[1]
	SetForcedReconLevel(Mission.Junyo, 2, PARTY_ALLIED)
	if Mission.Difficulty == 2 then -- hard
		SetSkillLevel(Mission.Junyo, SKILL_SPNORMAL)
	end
	NavigatorMoveOnPath(Mission.Junyo, FindEntity("JunyoPath"), PATH_FM_CIRCLE)
	Mission.Kingfisher = GenerateObject("Kingfisher")
	SetRoleAvailable(Mission.Kingfisher, EROLF_ALL, PLAYER_AI)
	PilotMoveTo(Mission.Kingfisher, GetPosition(FindEntity("Navpoint_North01")))
	SetInvincible(Mission.Kingfisher, 0.5)
	AddUntouchableUnit(Mission.Kingfisher)
	Scoring_IgnoreEntityKill(Mission.Kingfisher)
	SquadronSetTravelAlt(Mission.Kingfisher, 1100)
	--RemoveAllAirBasePlanes(Mission.Enterprise)
	AddAirBaseStock(Mission.Enterprise,108,30) -- dauntless	- aTom Fix: eredeti darabszam = 6
	AddAirBaseStock(Mission.Enterprise,113,30) -- avenger	- aTom Fix: eredeti darabszam = 24
	PutFormationTo(Mission.Enterprise, GetPosition(FindEntity("NavEnterpriseStart")), 3)
	Mission.EnterpriseGrp = luaRemoveDeadsFromTable(Mission.EnterpriseGrp)
	for idx, unit in pairs(Mission.EnterpriseGrp) do
		EntityTurnToEntity(unit, Mission.Junyo)
	end
	SetShipMaxSpeed(Mission.Enterprise, 5)
	BlackBars(true)
	Blackout(false, "", 3)
	luaSetPartyInvincible(1, PARTY_ALLIED)
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.Kingfisher, ["distance"] = 75, ["theta"] = 15, ["rho"] = 260, ["moveTime"] = 0, ["transformtype"] = "keepnone"},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Kingfisher, ["distance"] = 62, ["theta"] = 9, ["rho"] = 240, ["moveTime"] = 7, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Kingfisher, ["distance"] = 45, ["theta"] = 9, ["rho"] = 234, ["moveTime"] = 2, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Junyo, ["distance"] = 300, ["theta"] = 24, ["rho"] = 320, ["moveTime"] = 0, ["terrainavoid"] = true, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Junyo, ["distance"] = 800, ["theta"] = 20, ["rho"] = 315, ["moveTime"] = 12, ["terrainavoid"] = true, ["nonlinearblend"] = 1},
	},
	luaUS03EndReconMovie, true)
	luaDelay(luaUS03SpawnEnterpriseKillers, 60*20)	-- 20 minutes for this phase
end
function luaUS03EndReconMovie()
	BlackBars(false)
	luaSetPartyInvincible(0, PARTY_ALLIED)
	Mission.MissionPhase = 3
	luaDelay(luaUS03AddObj3, 6)
	EnableInput(true)
	SetRoleAvailable(Mission.Enterprise, EROLF_ALL, PLAYER_ANY)
	SetSelectedUnit(Mission.Enterprise)
	SetRoleAvailable(Mission.Enterprise, EROLF_ALL, PLAYER_AI)
	activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Enterprise)
	for idx, unit in pairs(squadEntTable) do
		if idx > 2 then
			--Kill(unit, true)
			SquadronLandAndKill(unit)
		end
	end
	Mission.Timer = GameTime() + 1200
	PilotMoveToRange(Mission.Kingfisher, Mission.Junyo, 2500)
	AddListener("kill", "JunyolistenerID", {
		["callback"] = "luaUS03JunyoKilled", -- callback fuggveny
		["entity"] = {Mission.Junyo}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	AddListener("kill", "ReinforcementHintlistenerID", {
		["callback"] = "luaUS03HintReinforcement", -- callback fuggveny
		["entity"] = {}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
	})
	Mission.USUnits = luaGetOwnUnits()
	luaDelay(luaUS03AnvilAttack, 25)
	luaDelay(luaUS03JunyoAngry, 600)
end
function luaUS03GotoPhase4()
-- RELEASE_LOGOFF  	luaLog("Going to phase 4")
	HideScoreDisplay(1, 0)
	
	local japs = luaGetOwnUnits("plane", PARTY_JAPANESE)
	for idx, unit in pairs(japs) do
		PilotRetreat(unit)
	end
	
	PutFormationTo(Mission.Enterprise, luaGetPathPoint(FindEntity("EnterprisePath"), 1),3)
	Mission.ZuihoGrp = {"Zuiho", "Kumano", "Hamakaze", "Yukikaze", "Hatsukaze"}
	Mission.SouthDakotaGrp = {"South Dakota", "San Juan", "Smith"}
	Mission.HornetGrp = {"Hornet", "Russell", "Morris"}
	Mission.NorthamptonGrp = {"Northampton", "San Diego", "Juneau", "Mustin", "Anderson"}
	Mission.TakaoGrp = {"Takao", "Tone"}
	Mission.ChikumaGrp = {"Chikuma", "Isuzu"}
	Mission.Vanguard = {"Kongo", "Hiei", "Haruna", "Kagero", "Oyashio"}
	--[[
	if Scoring_IsUnlocked("USN02_GOLD") then 
		--(Mission.UnlockLvl == 3) then
		table.insert(Mission.Vanguard, "Kirishima")
	end
	]]
	luaUS03GenerateObjects(Mission.Vanguard)
	luaUS03JoinFormations(Mission.Vanguard)
	--[[
	if Mission.Difficulty == 0 then	-- slow in rookie
		SetShipMaxSpeed(Mission.Vanguard[1], 5)
	end
	]]
	luaUS03GenerateObjects(Mission.TakaoGrp)
	luaUS03JoinFormations(Mission.TakaoGrp)
	Mission.Takao = Mission.TakaoGrp[1]
	NavigatorMoveToRange(Mission.Takao, Mission.Enterprise)
	luaUS03GenerateObjects(Mission.ZuihoGrp)
	luaUS03JoinFormations(Mission.ZuihoGrp)
	Mission.Zuiho = FindEntity("Zuiho")
	NavigatorMoveOnPath(Mission.Zuiho, FindEntity("ZuihoPath"), PATH_FM_CIRCLE)
	luaUS03GenerateObjects(Mission.ChikumaGrp)
	
	luaUS03GenerateObjects(Mission.SouthDakotaGrp)
	luaUS03JoinFormations(Mission.SouthDakotaGrp)
	Mission.SouthDakota = FindEntity("South Dakota")
	luaUS03GenerateObjects(Mission.HornetGrp)
	luaUS03JoinFormations(Mission.HornetGrp)
	Mission.Hornet = FindEntity("Hornet")
	SupportManagerEnable(Mission.Hornet, false)
	RepairEnable(Mission.Hornet, false)
	SetInvincible(Mission.Hornet, 0.3)
	luaUS03GenerateObjects(Mission.NorthamptonGrp)
	luaUS03JoinFormations(Mission.NorthamptonGrp)
	Mission.Northampton = FindEntity("Northampton")
	--NavigatorAttackMove(Mission.SouthDakota, Mission.Takao)
	--NavigatorMoveOnPath(Mission.Enterprise, FindEntity("EnterprisePath"))
	luaUS03CarrierMoveHack()
	Mission.JunyoGrp = luaRemoveDeadsFromTable(Mission.JunyoGrp)
	if table.getn(Mission.JunyoGrp) ~= 0 then
		for idx, unit in pairs(Mission.JunyoGrp) do
			PutRelTo(unit, Mission.ChikumaGrp[1], {["x"] = 250 * idx, ["y"] = 0, ["z"] = 250 * idx})
			table.insert(Mission.ChikumaGrp, unit)
		end
	end
	luaUS03JoinFormations(Mission.ChikumaGrp)
	NavigatorAttackMove(Mission.ChikumaGrp[1], Mission.SouthDakota)
	if Mission.Difficulty == 2 then -- hard
		for idx, unit in pairs(Mission.ZuihoGrp) do
			SetSkillLevel(unit, SKILL_SPNORMAL)
			TorpedoEnable(unit, true)
		end
		for idx, unit in pairs(Mission.ChikumaGrp) do
			TorpedoEnable(unit, true)
			SetSkillLevel(unit, SKILL_SPVETERAN)
		end
	end	
	
	for idx, unit in pairs(luaGetOwnUnits("ship")) do
		if IsClassChanged(unit.ClassID) then
			luaSetUnlockName(unit)
		end
	end
	
	BlackBars(true)
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.SouthDakota, ["distance"] = 400, ["theta"] = 18, ["rho"] = 25, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.SouthDakota, ["distance"] = 92, ["theta"] = 2, ["rho"] = 4, ["moveTime"] = 12},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Hornet, ["distance"] = 300, ["theta"] = 17, ["rho"] = 260, ["moveTime"] = 0, ["terrainavoid"] = true, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Hornet, ["distance"] = 580, ["theta"] = 20, ["rho"] = 200, ["moveTime"] = 12, ["terrainavoid"] = true, ["nonlinearblend"] = 0.5},
	},
	luaUS03EndReinforcementMovie, true)
	luaUS03StartDialog("dlg_USBattleshipsArrived")
end
function luaUS03EndReinforcementMovie()
	local actdialog = GetActDialogIDs()
	for idx, unit in pairs(actdialog) do
		KillDialog(unit)
	end
	BlackBars(false)
	if Mission.Kingfisher and not Mission.Kingfisher.Dead then
		SetInvincible(Mission.Kingfisher, 0)
		PilotMoveToRange(Mission.Kingfisher, Mission.Zuiho, 1500)
		SquadronSetTravelAlt(Mission.Kingfisher, 1400)
		--[[
		if IsUnitUntouchable(Mission.Kingfisher) then
			RemoveUntouchableUnit(Mission.Kingfisher)
		end
		]]
	end
	AddListener("recon", "VanguardReconlistenerID", {
		["callback"] = "luaUS03VanguardRecon",  -- callback fuggveny
		["entity"] = Mission.Vanguard, -- entityk akiken a listener aktiv
		["oldLevel"] = {1}, -- 0: undetected, 1: detected, 2: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2: identified
		["party"] = { PARTY_ALLIED },
	})
	
	AddListener("hit","ZuihoHitlistenerID", {
		["callback"] = "luaUS03ZuihoHitlistener",
		["target"] = {Mission.Zuiho},	
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {},	
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	
	AddListener("kill", "ZuihoKillListenerID", {
		["callback"] = "luaUS03ZuihoKilled",  -- callback fuggveny
		["entity"] = {Mission.Zuiho}, -- entityk akiken a listener aktiv
		["lastAttacker"] = { },  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
		})
	Mission.battleships = {FindEntity("Kongo"), FindEntity("Hiei"), FindEntity("Haruna"), FindEntity("Kirishima")}
	AddListener("Kill","VanguardlistenerID", {
		["callback"] = "luaUS03VanguardDead",  -- callback fuggveny
		["entity"] = Mission.battleships, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
		})
		
	EnableInput(true)
	SetSelectedUnit(Mission.SouthDakota)
	luaDelay(luaUS03CruisersInRange, 3)
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EnterpriseGrp)) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		UnitSetPlayerCommandsEnabled(unit, PCF_ALL)
	end
	if Mission.Kingfisher.Dead == false then
		SetRoleAvailable(Mission.Kingfisher, EROLF_ALL, PLAYER_AI)
		if IsUnitUntouchable(Mission.Kingfisher) then
			RemoveUntouchableUnit(Mission.Kingfisher)
		end
	end
	--[[
	Mission.USUnits = luaGetOwnUnits()
	for idx,unit in pairs (Mission.USUnits) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		UnitHoldFire(unit)
	end
	]]
	--SetRoleAvailable(Mission.SouthDakota, EROLF_ARTILLERY+EROLE_CAPTAIN, PLAYER_ANY)
	--UnitSetPlayerCommandsEnabled(Mission.SouthDakota, PCF_NONE+PCF_TARGET)
	--ArtilleryEnable(Mission.SouthDakotaGrp[2], false)
	--ArtilleryEnable(Mission.SouthDakotaGrp[3], false)
	--AddUntouchableUnit(Mission.Takao)
	--SetInvincible(Mission.Takao, 0.3)
	--BannSupportmanager()
	--ForceEnableInput(IC_SHIP_LAUNCHUNIT,false)
	--ForceEnableInput(IC_OVERLAY_BLUE, false)
	--ForceEnableInput(IC_CMD_SETTARGET,false)
	--ForceEnableInput(IC_GUN_FIRE,false)
	--ForceEnableInput(IC_MAP_TOGGLE,false)
	--HackPressInput(IC_CMD_CLEARTARGET)
	--Order(Mission.SouthDakota, "cleartarget")
end
function luaUS03CruisersInRange()
	if Mission.EndMission then
		return
	else
		luaUS03StartDialog("dlg_Cruisersinrange")
	end
end
function luaUS03CruiserToAttack()
	luaUS03StartDialog("dlg_Cruiser_to_attack")
end
function luaUS03TargetObjective()
	HackPressInput(IC_CMD_CLEARTARGET)
	luaObj_Add("primary",5,Mission.Takao)
	
	if PC and not X360COMP then
		luaSetNarrativeParam(IC_CMD_SETTARGET,55)
		Mission.TargetButton = Control.NarrativeParam55
	else
		Mission.TargetButton = ICON_A
	end
	DisplayScores(5,0,"usn03.obj_p5", "usn03.obj_p5_display")
	ForceEnableInput(IC_CMD_SETTARGET,true)
	AddListener("input", "inputListener", {
				["callback"] = "luaUS03TargetCallback",  -- callback fuggveny
				["inputID"] = {IC_CMD_SETTARGET}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
				["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
				})
end
function luaUS03TargetCallback()
	SetFireTarget(Mission.SouthDakota, Mission.Takao)
	RemoveListener("input", "inputListener")
	ForceEnableInput(IC_CMD_SETTARGET,false)
	ForceEnableInput(IC_CMD_CLEARTARGET,false)
	
	luaObj_Completed("primary",5)
	HideScoreDisplay(5,0)
	luaDelay(luaUS03AttackObjective,3)
end
function luaUS03AttackObjective()
	luaObj_Add("primary",6,Mission.Targeted)
	if PC and not X360COMP then
		luaSetNarrativeParam(IC_OVERLAY_BLUE,66)
		Mission.OrdersButton = Control.NarrativeParam66
	else
		Mission.OrdersButton = ICON_X
	end
	DisplayScores(6,0,"usn03.obj_p6", "usn03.obj_p6_display")
	UnitSetPlayerCommandsEnabled(Mission.SouthDakota, PCF_NONE+PCF_TARGET+PCF_ATTACK+PCF_MOVE)
	ForceEnableInput(IC_OVERLAY_BLUE, true)
	AddListener("target", "attackListener", { 
			["callback"] = "luaUS03AttackCallback",  -- callback fuggveny
			["entity"] = {Mission.SouthDakota}, -- entityk akiken a listener aktiv
			["target"] = {Mission.Takao}, -- entityk akik targetkent szerepelnek
			})
end
function luaUS03AttackCallback()
	luaDelay(luaUS03AttackCompleteDelayed,3)
	luaUS03EnableInputs()
end
function luaUS03EnableInputs()
	for idx,unit in pairs (luaGetOwnUnits()) do
		UnitFreeFire(unit)
	end
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SouthDakotaGrp)) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		UnitSetPlayerCommandsEnabled(unit, PCF_ALL)
	end
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EnterpriseGrp)) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		UnitSetPlayerCommandsEnabled(unit, PCF_ALL)
	end
	local usPlanes = luaGetOwnUnits("plane")
	for idx,unit in pairs (usPlanes) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
	end
	if Mission.Kingfisher.Dead == false then
		SetRoleAvailable(Mission.Kingfisher, EROLF_ALL, PLAYER_AI)
		if IsUnitUntouchable(Mission.Kingfisher) then
			RemoveUntouchableUnit(Mission.Kingfisher)
		end
	end
	ForceEnableInput(IC_SHIP_LAUNCHUNIT,true)
	ForceEnableInput(IC_OVERLAY_BLUE, true)
	ForceEnableInput(IC_CMD_SETTARGET,true)
	ForceEnableInput(IC_CMD_CLEARTARGET,true)
	ForceEnableInput(IC_GUN_FIRE,true)
	ForceEnableInput(IC_MAP_TOGGLE,true)
	PermitSupportmanager()
	for idx,unit in pairs(Mission.SouthDakotaGrp) do
		if not unit.Dead then
			ArtilleryEnable(unit, true)
		end
	end
	if IsUnitUntouchable(Mission.Takao) then
		RemoveUntouchableUnit(Mission.Takao)
	end
	SetInvincible(Mission.Takao,false)
end
function luaUS03AttackCompleteDelayed()
	luaUS03StartDialog("dlg_Cruiser_attacked")
	luaObj_Completed("primary",6)
	luaDelay(luaUS03Primary4Add,4)
	HideScoreDisplay(6,0)
end
function luaUS03Primary4Add()
	luaDelay(luaUS03AddObj4, 6)
	luaDelay(luaUS03VanguardRadioHint, 150)
	SetShipMaxSpeed(Mission.Enterprise, Mission.Enterprise.Class.MaxSpeed)
	luaUS03SpawnConstantAirWaves()
	RemoveAllAirBasePlanes(Mission.Enterprise)
	RemoveAllAirBasePlanes(Mission.Enterprise)
	AddAirBaseStock(Mission.Enterprise,101,20) -- wildcat
	AddAirBaseStock(Mission.Enterprise,113,30) -- avenger
	AddAirBaseStock(Mission.Enterprise,108,30) -- dauntless
	Mission.MissionPhase = 4
	SetRoleAvailable(Mission.Enterprise, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Enterprise, EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLE_CAPTAIN, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.Enterprise, PCF_NONE+PCF_TARGET)
end
function luaUS03JunyoAngry()
	if Mission.MissionPhase == 3 then
		if Mission.Junyo.Dead == false then
			SetSkillLevel(Mission.Junyo, SKILL_ELITE)
			SetAirBaseSlotCount(Mission.Junyo, 8)
			for idx, unit in pairs(Mission.EnterpriseGrp) do
				SetSkillLevel(unit, SKILL_STUN)
			end
		end
	end
end
function luaUS03JunyoKilled()
	Effect("ExplosionBigShip", GetPosition(Mission.Junyo))
	RemoveListener("kill", "JunyolistenerID")
	luaObj_Completed("primary", 3, true)
	HideScoreDisplay(1, 0)
	HideUnitHP()
	Mission.MissionPhase = 666
	MissionNarrative("usn03.junyokilled")
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.Junyo, ["distance"] = 500, ["theta"] = 17, ["rho"] = 285, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Junyo, ["distance"] = 300, ["theta"] = 8, ["rho"] = 275, ["moveTime"] = 4, ["nonlinearblend"] = 0.8},
		{["postype"] = "cameraandtarget", ["target"] = Mission.Junyo, ["distance"] = 250, ["theta"] = 7, ["rho"] = 272, ["moveTime"] = 8, ["nonlinearblend"] = 0.7},
	},
	luaUS03EndJunyoKilledMovie)
end
function luaUS03EndJunyoKilledMovie()
	Blackout(true,"luaUS03SaveCheckpoint1", 3)
	Mission.JunyoGrp = luaRemoveDeadsFromTable(Mission.JunyoGrp)
	if table.getn(Mission.JunyoGrp) ~= 0 then
		DisbandFormation(Mission.JunyoGrp[1])
	end
end
function luaUS03SaveCheckpoint1()
	--luaCheckpoint(1, 150)
	if not TrulyDead(Mission.Junyo)	then
		Kill(Mission.Junyo)
	end
	RemoveWrecks()
	luaDelay(luaUS03BlackoutDelay, 1)
end
	
function luaUS03BlackoutDelay()
	MissionNarrative("usn03.timepasses")
	luaUS03GotoPhase4()
end
function luaUS03ZuihoKilled()
	RemoveListener("kill", "ZuihoKillListenerID")
	Mission.EndMission = true
	luaClearDialogs()
	if Mission.Enterprise ~=nil and not Mission.Enterprise.Dead then
		SetInvincible(Mission.Enterprise, 0.1)
	end
	luaObj_Completed("primary", 2)
	luaObj_Completed("primary", 4)
	luaMissionCompletedNew(Mission.Zuiho, "usn03.obj_mission_comp")
	if Mission.Difficulty == 2 then
		local japs = luaGetOwnUnits("ship", PARTY_JAPANESE)
		japs = luaRemoveDeadsFromTable(japs)
		if table.getn(japs) == 0 then
			SetAchievements("AO_MOH")
		end
	end
end
function luaUS03GotoPhase5() -- Hornet sunk
-- RELEASE_LOGOFF  	luaLog("Going to phase 5")
end
function luaUS03HintReload()
	ShowHint("USN03_Hint_Reload")
end
function luaUS03HintReinforcement(...)
-- RELEASE_LOGOFF  	luaLog("luaUS03HintReinforcement")
	if arg[1] then
		if arg[1].Party == PARTY_ALLIED and arg[1].Type == "PLANESQUADRON" then
			RemoveListener("kill", "ReinforcementHintlistenerID")
			ShowHint("USN03_Hint_Reinforce")
		end
	end
end
function luaUS03HintSupportManager()
-- RELEASE_LOGOFF  	luaLog("luaUS03HintSupportManager")
	activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Enterprise)
	if IsGUIActive("GUI_support_full") ~= true and activeSquads == 0 then
		ShowHint("USN03_Hint_Supportmanager")
		--[[
		AddListener("gui", "listenerID", { 
			["callback"] = "luaUS03HideSupportManagerHint",  -- callback fuggveny
			["guiName"] = {"GUI_support_full"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
			["enter"] = {true}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
		})
-- RELEASE_LOGOFF  		luaLog("guilistener added")
		]]
	end
end
--[[
function luaUS03HideSupportManagerHint()
	RemoveListener("gui", "listenerID")
	HideHint()
end
]]
function luaUS03HintSendAvengers()
	ShowHint("USN03_Hint_Sendtorpedobombers")
	luaDelay(luaUS03SendGroups, 20)
end
function luaUS03HintHornet()
	ShowHint("USN03_Hint_Hornet")
end
function luaUS03SendGroups()
	ShowHint("USN03_Hint_Sendgroups")
	luaDelay(luaUS03HintReload, 25)
end
function luaUS03HintSendAvengers()
	ShowHint("USN03_Hint_Sendtorpedobombers")
end
function luaUS03SpawnPhase1EnterpriseAttackers()
	for FirstEnterpriseAttackerWaveNumber = 1,Mission.MaxFirstEnterpriseAttackerWaveNumber do
		local planes = {GenerateObject("Kate1"),GenerateObject("Val1")}
		for idx, unit in pairs(planes) do
			SetSkillLevel(unit, SKILL_STUN)
			local pos = GetPosition(Mission.Enterprise)
			pos.y = 750
			pos.x = pos.x - 1500 - idx * 1200
			pos.z = pos.z + 1500 + FirstEnterpriseAttackerWaveNumber * 4000
			SquadronSetTravelAlt(unit, pos.y)
			PutTo(unit, pos)
			EntityTurnToEntity(unit, Mission.Enterprise)
			SquadronSetSpeed(unit, 300)
			PilotSetTarget(unit, Mission.Enterprise)
			Mission.MovieUnit = unit
		end
	end
end
function luaUS03SpawnPhase1EnterpriseKillers()
	Mission.FirstEnterpriseAttackerWaveNumber = Mission.FirstEnterpriseAttackerWaveNumber + 1
-- RELEASE_LOGOFF  	luaLog("Spawning wave"..Mission.FirstEnterpriseAttackerWaveNumber)
	local planes = {GenerateObject("Kate1"),GenerateObject("Val1")}
	--luaLog(planes)
	for idx, unit in pairs(planes) do
		luaPutToRecon(unit, Mission.Enterprise, -idx * 5)
		EntityTurnToEntity(unit, Mission.Enterprise)
		PilotSetTarget(unit, Mission.Enterprise)
	end
-- RELEASE_LOGOFF  	luaLog("set")
	if (Mission.FirstEnterpriseAttackerWaveNumber < Mission.MaxFirstEnterpriseAttackerWaveNumber) then
		luaDelay(luaUS03SpawnPhase1EnterpriseKillers, Mission.FirstEnterpriseAttackersCooldown)	-- spann
-- RELEASE_LOGOFF  		luaLog("Spawning in "..Mission.FirstEnterpriseAttackersCooldown.." seconds.")
	end
end
function luaUS03SpawnEnterpriseKillers()
	if Mission.MissionPhase == 3 then
		local planes = {GenerateObject("Kate1"),GenerateObject("Val1")}
		for idx, unit in pairs(planes) do
			PutTo(unit, GetPosition(FindEntity("Navpoint_North01")))
			EntityTurnToEntity(unit, Mission.Enterprise)
			PilotSetTarget(unit, Mission.Enterprise)
		end
		luaDelay(luaUS03SpawnEnterpriseKillers, 25)	-- spann
	end
end
function luaUS03InsertPhase1AttackersA()
	table.insert(Mission.Phase1AttackersA, FindEntity("Val A"..Mission.Phase1BomberWave))
	table.insert(Mission.Phase1AttackersA, FindEntity("Kate A"..Mission.Phase1BomberWave))
	Mission.Phase1AttackersA = luaRemoveDeadsFromTable(Mission.Phase1AttackersA)
	for idx, unit in pairs(Mission.Phase1AttackersA) do
		if UnitGetAttackTarget(unit) == nil then
			PilotSetTarget(unit, Mission.Hornet)
-- RELEASE_LOGOFF  			luaLog(unit.Name.." is attacking")
		end
	end
end
function luaUS03SpawnConstantAirWaves()
	local japs = luaGetOwnUnits("plane", PARTY_JAPANESE)
	if table.getn(japs) < 9 then
		if Mission.Enterprise.Dead == false then
			SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						{
						["Type"] = 158,
						["Name"] = "Val",	
						["Equipment"] = 1
					},
					{
						["Type"] = 162,
						["Name"] = "Kate",
						["Equipment"] = 1
					},
					},
					["area"] = {
						["refPos"] = GetPosition(Mission.Navpoint_North01),
						["angleRange"] = { -1, 1},
						["lookAt"] =  GetPosition(Mission.Enterprise),
					},
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 100,
						["enemyHorizontal"] = 800,
						["ownVertical"] = 75,
						["enemyVertical"] = 150,
						["formationHorizontal"] = 500,
					},
					--["callback"] = "luaUS03ManageNorth1",
			})
			SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						{
						["Type"] = 158,
						["Name"] = "Val",
						["Equipment"] = 1
					},
					{
						["Type"] = 162,
						["Name"] = "Kate",
						["Equipment"] = 1
					},
					},
					["area"] = {
						["refPos"] = GetPosition(Mission.Navpoint_North02),
						["angleRange"] = { -1, 1},
						["lookAt"] =  GetPosition(Mission.Enterprise),
					},
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 100,
						["enemyHorizontal"] = 800,
						["ownVertical"] = 75,
						["enemyVertical"] = 150,
						["formationHorizontal"] = 500,
					},
					--["callback"] = "luaUS03ManageNorth2",
			})
		end
		luaDelay(luaUS03SpawnConstantAirWaves, Mission.ConstantAirWaveSpawnCooldown)
	end
end
function luaUS03ManageNorth()
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	local North1Planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.Navpoint_North01), 1500, PARTY_JAPANESE, "own")
	if North1Planes ~= nil then 
		for idx, unit in pairs(North1Planes) do
			if Mission.Enterprise.Dead == false then
				PilotSetTarget(unit, luaPickRnd(Mission.USUnits))
-- RELEASE_LOGOFF  				luaLog(unit.Name.." is attacking Enterprise")
			end
		end
	end
	North2Planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.Navpoint_North02), 1500, PARTY_JAPANESE, "own")
	if North2Planes ~= nil then
		for idx, unit in pairs(North2Planes) do
			if Mission.Enterprise.Dead == false then
				PilotSetTarget(unit, luaPickRnd(Mission.USUnits))
-- RELEASE_LOGOFF  				luaLog(unit.Name.." is attacking Enterprise")
			end
		end
	end
end
function luaUS03ManageHornetCAP()
	if (Mission.Hornet.Dead == false) and (Mission.Hornet.Party == PARTY_ALLIED) then
		Mission.HornetCAP = luaRemoveDeadsFromTable(Mission.HornetCAP)
		if table.getn(Mission.HornetCAP) < Mission.HornetCAPNumber then
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = {
					{
						["Type"] = 101,
						["Name"] = "Wildcat CAP",
						["Equipment"] = 0
					},
				},
				["area"] = {
					["refPos"] = GetPosition(Mission.Hornet),
					["angleRange"] = { -1, 1},
					["lookAt"] =  GetPosition(Mission.Enterprise),
				},
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 100,
					["enemyHorizontal"] = 800,
					["ownVertical"] = 75,
					["enemyVertical"] = 150,
					["formationHorizontal"] = 500,
				},
				["callback"] = "luaUS03GoCAP",
			})
		end
	end
end
function luaUS03GoCAP(...)
-- RELEASE_LOGOFF  	luaLog("New CAP Plane")
	table.insert(Mission.HornetCAP, arg[1])
	if (Mission.Enterprise.Dead == false) then
		PilotMoveTo(arg[1], Mission.Enterprise)
	end
end
function luaUS03EnterpriseExits()
-- RELEASE_LOGOFF  	luaLog("Enterprise exited")
	RemoveListener("exitzone", "EnterpriseExitlistenerID")
	Mission.MissionPhase = 5
	Mission.USUnits = luaRemoveDeadsFromTable(Mission.USUnits)
	Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
	if table.getn(Mission.Vanguard) ~= 0 then
		if table.getn(Mission.USUnits) > 0 then
			NavigatorAttackMove(Mission.Vanguard[1], luaGetNearestUnitFromTable(Mission.Vanguard[1], Mission.USUnits))
		end
	end
end

function luaUS03AnvilAttack()
	activeSquads, squadEntTable = luaGetSlotsAndSquads(Mission.Enterprise)
	if squadEntTable then
		for idx, unit in pairs (squadEntTable) do
			if unit.Class.Name == "globals.unitclass_avenger" then
				luaUS03StartDialog("dlg_Anvil_attack")
				return
			end
		end
	end
	luaDelay(luaUS03AnvilAttack, 10)
end
function luaUS03VanguardDead()
-- RELEASE_LOGOFF  	luaLog("Vanguard dead:")
	Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
	RemoveListener("Kill","VanguardlistenerID")
	luaObj_Completed("hidden",1, true)
	--[[
	AddPowerup({
			["classID"] = "improved_repair_team",
			["useLimit"] = 1,
		})
		]]
end

function luaUS03ZuihoHitlistener(...)
	if arg[3] and arg[3].Party == PARTY_ALLIED then
		luaUS03StartDialog("dlg_1sthit_Zuiho")
		RemoveListener("hit","ZuihoHitlistenerID")
-- RELEASE_LOGOFF  		luaLog("Zuiho hit.")
	end
end
function luaUS03HornetStartsNorth()
	luaUS03StartDialog("dlg_HornetStarts")
	NavigatorMoveToRange(Mission.Hornet, Mission.Vanguard[1])
	NavigatorMoveToRange(Mission.Northampton, Mission.Vanguard[1])
end
function luaUS03VanguardRecon()
-- RELEASE_LOGOFF  	luaLog("A reconlistener callbackje.")
	for idx,unit in pairs (Mission.Vanguard) do
-- RELEASE_LOGOFF  		luaLog(luaGetReconLevel(unit, PARTY_ALLIED))
	end
	RemoveListener("recon","VanguardReconlistenerID")
	luaUS03StartDialog("dlg_Vanguard_on_recon")
	Mission.EnterpriseEscapes = true
	AddListener("exitzone", "EnterpriseExitlistenerID", { 
		["callback"] = "luaUS03EnterpriseExits",  -- callback fuggveny
		["entity"] = {Mission.Enterprise}, -- entityk akiken a listener aktiv
		["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
		})
		--[[
		AddProximityTrigger(Mission.Enterprise, "EnterpriseProximityID1", "luaUS03EnterpriseGroupStop", FindEntity("NavEnterpriseStart"), 1000)
		]]
end
function luaUS03CarrierMoveHack()
	if Mission.Enterprise.Dead == false then
		if Mission.EnterpriseEscapes then
			NavigatorStop(Mission.Enterprise)
			NavigatorMoveOnPath(Mission.Enterprise, FindEntity("EscapePath"), PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			NavigatorStop(Mission.Enterprise)
			NavigatorMoveOnPath(Mission.Enterprise, FindEntity("EnterprisePath"))
		end
		luaDelay(luaUS03CarrierMoveHack, 5)
	end
end
function luaUS03StartDialog(dialogID)
	if Mission.EndMission ~= true then
		if (Mission.Dialogues[dialogID].printed == nil) then
			StartDialog(dialogID, Mission.Dialogues[dialogID])
			Mission.Dialogues[dialogID].printed = true
-- RELEASE_LOGOFF  			luaLog("Dialog started. ID: "..dialogID)
		end
	end
end
function luaUS03StartInitDialog()	
	luaUS03StartDialog("dlg_Init")
-- RELEASE_LOGOFF  	luaLog("luaUS03StartInitDialog")
end
function luaUS03AddObj1()
	luaObj_Add("primary", 1)
	luaDelay(luaUS03HintSupportManager, 4)
end
function luaUS03AddObj2()
	luaObj_Add("primary", 2)
	luaDelay(luaUS03ShowEnterpriseHP, 4)
end
function luaUS03AddObj3()
	luaObj_Add("primary", 3, Mission.Junyo)
	luaDelay(luaUS03AddJunyoHP, 4)
end
function luaUS03AddJunyoHP()
	DisplayUnitHP({Mission.Junyo}, "usn03.obj_p3")
	luaDelay(luaUS03HintSendAvengers, 3)
end
function luaUS03AddObj4()
	luaObj_Add("primary", 4, Mission.Zuiho)
	DisplayUnitHP({Mission.Zuiho}, "usn03.obj_p4")
	luaDelay(luaUS03HintBattleship, 20)
end
function luaUS03AddHornetObj()
	luaUS03StartDialog("dlg_Hornetkill")
	Mission.HornetKillers = luaRemoveDeadsFromTable(Mission.HornetKillers)
	for idx, unit in pairs(Mission.HornetKillers) do
		PilotLand(unit,Mission.Zuiho)
	end
	NavigatorStop(Mission.Hornet)
end
function luaUS03ShowEnterpriseHP()
	DisplayUnitHP({Mission.Enterprise}, "usn03.obj_p2")
end
function luaUS03AddHornetObjCallback()
	luaObj_Add("secondary", 1)
	Mission.NorthamptonGrp = luaRemoveDeadsFromTable(Mission.NorthamptonGrp)
	for idx, unit in pairs (Mission.NorthamptonGrp) do	-- you are in charge of Hornet's screen
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
	end
	Mission.HornetGrp = luaRemoveDeadsFromTable(Mission.HornetGrp)
	for idx, unit in pairs (Mission.HornetGrp) do	-- you are in charge of Hornet's screen
		if unit.Name ~= "Hornet" then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
		else
			LeaveFormation(unit)
		end
	end
	luaDelay(luaUS03AddHornetDisplay, 4)
	RepairEnable(Mission.Hornet, false)
	ClearAllShipFailure(Mission.Hornet)
	SetInvincible(Mission.Hornet, 0.05)
	AddListener("hit","HornetHitlistenerID", {
		["callback"] = "luaUS03HornetHitlistener",
		["target"] = {Mission.Hornet},	
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {},	
		["attackerPlayerIndex"] = {PLAYER_1},
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
	
	Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
	if table.getn(Mission.Vanguard) ~= 0 then
		NavigatorMoveToPos(Mission.Vanguard[1], GetPosition(Mission.Hornet))
	end
	SetParty(Mission.Hornet, PARTY_NEUTRAL)
	SetForcedReconLevel(Mission.Hornet, 2, PARTY_ALLIED)
	AddUntouchableUnit(Mission.Hornet)
	Mission.USUnits = luaGetOwnUnits()
	luaRemoveByName(Mission.USUnits, "Hornet")
	local neutralplanesofhornet = luaGetOwnUnits("plane",PARTY_NEUTRAL)
	for idx,unit in pairs(neutralplanesofhornet) do
		SetParty(unit, PARTY_ALLIED)
	end
	AddListener("kill", "HornetKillListenerID", {
		["callback"] = "luaUS03HornetObjCompleted",  -- callback fuggveny
		["entity"] = {Mission.Hornet}, -- entityk akiken a listener aktiv
		["lastAttacker"] = { },  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = { }, -- PLAYER_1..PLAYER_32
	})
end
function luaUS03AddHornetDisplay()
	DisplayScores(2, 0, "usn03.obj_sinkhornet_1", "usn03.obj_sinkhornet_2")
	luaDelay(luaUS03HintHornet, 3)
end
function luaUS03HornetHitlistener()
	RemoveListener("hit","HornetHitlistenerID")
	SetInvincible(Mission.Hornet, 0)
end
function luaUS03HornetObjCompleted()
-- RELEASE_LOGOFF  	luaLog("hornet sunk")
	RemoveListener("kill", "HornetKillListenerID")
	luaUS03StartDialog("dlg_HornetKilledByPlayer")
	HideScoreDisplay(2, 0)
	Mission.HornetStatus = 5
end
function luaUS03HornetObjCompletedCallback()
	luaObj_Completed("secondary", 1)
	SetAchievements("MA_QS")
	Mission.Vanguard = luaRemoveDeadsFromTable(Mission.Vanguard)
	if table.getn(Mission.Vanguard) ~= 0 then
		NavigatorAttackMove(Mission.Vanguard[1], Mission.Enterprise)
	end
end
function luaUS03USBattleshipsIncoming1()
	luaUS03StartDialog("dlg_USBattleshipsIncoming1")
end
function luaUS03USBattleshipsIncoming2()
	luaUS03StartDialog("dlg_USBattleshipsIncoming2")
end
function luaUS03HintBattleship()
	ShowHint("USN03_Hint_Battleship")
end
function luaUS03JoinFormations(tab)
	local idx = 1
	while idx < table.getn(tab) do
	 idx = idx + 1
	 JoinFormation(tab[idx], tab[1])
	end
end
function luaUS03GenerateObjects(tab)
	for idx, unit in pairs(tab) do
		tab[idx] = GenerateObject(unit)
	end
end
function luaUS03SetChangeableGUIName(unit)
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
function c1()
	Mission.FirstEnterpriseAttackerWaveNumber = Mission.MaxFirstEnterpriseAttackerWaveNumber
	local a = luaGetOwnUnits(nil, PARTY_JAPANESE)
	for idx, unit in pairs(a) do
		Kill(unit)
	end
end
function luaUS03Checkpoint1Load()
	Mission.Kingfisher = GenerateObject("Kingfisher")
	SetRoleAvailable(Mission.Kingfisher, EROLF_ALL, PLAYER_AI)
	SetForcedReconLevel(Mission.Enterprise, 2, PARTY_JAPANESE)
	-- aTom Fix
	if (not IsListenerActive("kill", "Listener_EnterpriseWasDestroyed")) then
		AddListener("kill", "Listener_EnterpriseWasDestroyed", 
		{
			["callback"] = "luaUS03_EnterpriseWasDestroyed",
			["entity"] = {Mission.Enterprise},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
		})
	end
	-- aTom Fix end
	Mission.MissionPhase = 1
	--SoundFade(1, "",0.1)
	local japs = Mission.Checkpoint.Units.JapUnits[1]
	local us = Mission.Checkpoint.Units.USUnits[1]
	local tempgrp = {"Kuroshio", "Hayashio"}
	for idx, unit in pairs(tempgrp) do
		if luaUS03IsInside(unit, japs) then
			local generatedunit = GenerateObject(unit)
			table.insert(Mission.JunyoGrp, generatedunit)
		end
	end
	for idx, unit in pairs(Mission.EnterpriseGrp) do
		if luaUS03IsInside(unit.Name, us) == false then
-- RELEASE_LOGOFF  			LogToConsole(unit.Name)
			Kill(unit, true)
		end
	end
	luaDelay(luaUS03Checkpoint1LoadDelay, 0.5)
end
function luaUS03Checkpoint1LoadDelay()
	if IsInFormation(Mission.Enterprise) then
		luaUS03GotoPhase4()
		Mission.USUnits = luaGetOwnUnits("ship")
	else
		luaDelay(luaUS03Checkpoint1LoadDelay, 0.5)
	end
end
function luaUS03IsInside(searched, inthis)
	for idx, unit in pairs(inthis) do
		if unit[1] == searched then
			return true
		end
	end
	return false
end
function luaUS03Checkpoint1Save()
end
