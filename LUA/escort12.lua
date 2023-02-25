--SceneFile="Missions\Multi\Scene12.scn"

--[[
TODO:
		- objective score-t beallitani
		+ secondary ojj. complete
		- a South Dakota vedoinek sebesseget beallitani SD speedre
		- marker tablat csinalni es mind2 ojjektivara rarakni mindegyik markert (2 cv + SD)
		+ ha meghal a carrier kiserete, joinolni a masikhoz
		+ scn file-ban meg 1 tanker kisero DD-t berakni + skill levelt allitani SPVeteranra
		+ ha meghal a carrier leadere, tamadjak a South Dakotat (akkor nem joinol a masik carrierhez)
		+ repair javitani ugy, hogy ha beer egy repair ship, akkor egybol kezdje el javitani
		+ South Dakotahoz joinoljon a repairt kisero hajok is a Phase02-ben
		+ US_Carrier Spawnpointjat elforgatni
		+ hintek:
			bekotni:
			+ hint_escort_sd_damaged_desc_us (ID_Hint_Escort12_SD_Damaged)
			+ hint_escort_sd_repairships (ID_Hint_Escort12_SD_Repairships)
			+ hint_escort_sd_damaged_desc_ijn (ID_Hint_Escort12_SD_Damaged)
			kikotni:
			+ hint_escort_tanker_desc_ijn
			+ hint_escort_tanker_desc_title
			+ hint_escort_tanker_desc_us

		+ narrativak
			bekotni:
			+ nar_escort_sd_hplow_us
			+ nar_escort_carrierhplow_ijn
			+ nar_escort_carrierdestroyed

		+ displayscore-ok
			bekotni:
			+ score_escort_repairships



]]--

-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(59)		-- Yamato
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort12")
end

function luaInitEscort12(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "DLC-Escort12_"..dateandtime
-- logolasok
--	DamageLog = true
	Mission.HelperLog = false
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort12")
	-- Loc-Kit dolgok
	Music_Control_SetLevel(MUSIC_TENSION)

	--globalis konstansok
	this.Multiplayer 										= true
	this.MultiplayerType 								= "Escort"
	this.CompetitiveParty 							= PARTY_ALLIED
	this.ThinkCounter										= 0
	this.SpeedOfCarrier									= 7								-- m/s
	this.SpeedOfTanker									= 15							-- m/s
	this.SpeedOfTankerDefender					= 12							-- m/s
	this.SpeedOfSD											= 15							-- m/s (30 knots)
	this.SDBaseRepairEffectivity				= 0.33
	this.SDHP														= 30000
	this.IJNCarrierHP										= 16000
	this.IJNCarrierRepairEffectivity		= 0.5

	-- fine tune-hoz global valtozok


	--globalis valtozok
	this.MissionPhase									= 1
	this.NeedCarrierDistanceCheck			= false							-- kell csekkolni a carrier tavolsagat az 5. pathpointtol (phase valtas, South Dakota elindul)
	this.EnableAttackManager					= false
	this.DockingFinished							= false							-- a South Dakota elindulasahoz kell
	this.CarrierReachedNavpoint				= false							-- a South Dakota elindulasahoz kell
	this.Phase02Started								= false
	this.SouthDakotaHP								= 100
	this.Carrier01HP									= 100
	this.Carrier02HP									= 100
	this.NumberOfTTs									= 0									-- % szamitas miatt kell az SD HP-jahoz (kesobb kapja meg ertekul)
	this.EnableImprovedRepair					= false							-- a phase02-ben meddig kell improved repair
	this.ImprovedMaxHPPercentage			= 0									-- max ennyi HP %-ig lehet aktiv az improved repair fv.
	this.StartingHPPercentage					= 0									-- ennyi %-rol indul a south dakota HP-ja (kesobb kapja meg ertekul)
	this.DockedRepairShips						= 0									-- bonuszok miatt
	this.NextSDHPNarrative						= 0									-- ennyi think elteltevel kell a kov. hp figyelmezteto narrativat dobni
	this.NextCarrierHPNarrative				= 0									-- ennyi think elteltevel kell a kov. hp figyelmezteto narrativat dobni
	this.ImprovedRepairTable					= {}								-- ebbe rakom bele mennyivel kell megnovelni a repairt improved-nal
	this.EnableDisplayDockedShips			= true							-- meg kell -e jeleniteni a kikotott repair shipek displayscore-jat

	this.AchievementReached						= false							-- elerte -e az Achievementet a player (mind2 carrier eletben maradt japo oldalon)


	--US tables
	Mission.SouthDakota = {}
		table.insert(Mission.SouthDakota, FindEntity("Escort - South Dakota Class 01"))

	Mission.SouthDakotaPath = {}
		table.insert(Mission.SouthDakotaPath, FindEntity("Escort - SDPath"))

	Mission.US_SpawnPoints = {}
		table.insert(Mission.US_SpawnPoints, FindEntity("Escort - SpawnPoint Large"))
		table.insert(Mission.US_SpawnPoints, FindEntity("Escort - CV_US 01 SP"))

	Mission.US_Airfield = {}
		table.insert(Mission.US_Airfield, FindEntity("Escort - CB4_AF"))
		table.insert(Mission.US_Airfield, FindEntity("Escort - CB4_AF_Hangar"))

	Mission.US_Defenders = {}
		table.insert(Mission.US_Defenders, FindEntity("Escort - Fletcher-class 01"))
		table.insert(Mission.US_Defenders, FindEntity("Escort - Fletcher-class 02"))
		--table.insert(Mission.US_Defenders, FindEntity("Escort - Fletcher-class 03"))

	Mission.US_Tankers = {}	-- State: 0 = meg nem indult el, 1 = megy a pathon, 2 = vegigment a pathon
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 01"))
		Mission.US_Tankers[1].State = 0
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 02"))
		Mission.US_Tankers[2].State = 0
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 03"))
		Mission.US_Tankers[3].State = 0
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 04"))
		Mission.US_Tankers[4].State = 0
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 05"))
		Mission.US_Tankers[5].State = 0
		table.insert(Mission.US_Tankers, FindEntity("Escort - US Tanker 06"))
		Mission.US_Tankers[6].State = 0
	Mission.NumberOfTTs = table.getn(Mission.US_Tankers)


	Mission.US_TankerPath = {}
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath01"))
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath02"))
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath03"))
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath04"))
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath05"))
		table.insert(Mission.US_TankerPath, FindEntity("Escort - TankerPath06"))

	Mission.US_TankerDefenders = {}
		table.insert(Mission.US_TankerDefenders, FindEntity("Escort - Fletcher-class 04"))
		table.insert(Mission.US_TankerDefenders, FindEntity("Escort - Fletcher-class 05"))
		--table.insert(Mission.US_TankerDefenders, FindEntity("Escort - Fletcher-class 06"))

	--[[for i, pShip in pairs (Mission.US_TankerDefenders) do
		SetRoleAvailable(pShip, EROLF_ALL, PLAYER_AI)
	end]]--

	Mission.US_TankerDefendersPath = {}	-- a tankerek vedoinek path-ai
		table.insert(Mission.US_TankerDefendersPath, FindEntity("Escort - DefenderPath01"))
		table.insert(Mission.US_TankerDefendersPath, FindEntity("Escort - DefenderPath02"))
		table.insert(Mission.US_TankerDefendersPath, FindEntity("Escort - DefenderPath03"))

	--[[Mission.US_HQ = {}
		table.insert(Mission.US_HQ, FindEntity("CB4"))]]--

	Mission.US_Shipyard = {}
		table.insert(Mission.US_Shipyard, FindEntity("CB4_SY_Hangar"))

	Mission.US_Carrier = {}
		table.insert(Mission.US_Carrier, FindEntity("Escort - CV_US 01"))

	Mission.US_Carrier_Path = {}
		table.insert(Mission.US_Carrier_Path, FindEntity("Escort - USCarrierPath01"))
		table.insert(Mission.US_Carrier_Path, FindEntity("Escort - USCarrierPath02"))

	--IJN tables
	Mission.IJN_Carriers = {}
		table.insert(Mission.IJN_Carriers, FindEntity("Escort - CV_IJN 01"))
		Mission.IJN_Carriers[1].Number = 1			-- halalkori formacio valtas miatt kell
		table.insert(Mission.IJN_Carriers, FindEntity("Escort - CV_IJN 02"))
		Mission.IJN_Carriers[2].Number = 2

	Mission.IJN_CarrierPath = {}
		table.insert(Mission.IJN_CarrierPath, FindEntity("Escort - CarrierPath01"))
		table.insert(Mission.IJN_CarrierPath, FindEntity("Escort - CarrierPath02"))

	Mission.IJN_CarrierEscapePath = {}
		table.insert(Mission.IJN_CarrierEscapePath, FindEntity("Escort - CarrierEscapePath01"))
		table.insert(Mission.IJN_CarrierEscapePath, FindEntity("Escort - CarrierEscapePath02"))

	Mission.IJN_CarrierEscort01 = {}
		table.insert(Mission.IJN_CarrierEscort01, FindEntity("Escort - Akizuki-class 01"))
		table.insert(Mission.IJN_CarrierEscort01, FindEntity("Escort - Akizuki-class 02"))
	Mission.IJN_CarrierEscort02 = {}
		table.insert(Mission.IJN_CarrierEscort02, FindEntity("Escort - Akizuki-class 03"))
		table.insert(Mission.IJN_CarrierEscort02, FindEntity("Escort - Akizuki-class 04"))

	--[[Mission.PhasePathPoints = {}
		table.insert(Mission.PhasePathPoints, (luaGetPathPoint(Mission.IJN_CarrierPath[1], 4)))
		table.insert(Mission.PhasePathPoints, (luaGetPathPoint(Mission.IJN_CarrierPath[2], 4)))]]--
	Mission.PhasePathPoint = {}
		table.insert(Mission.PhasePathPoint, FindEntity("Escort - Pityu"))

	Mission.IJN_SpawnPoints01 = {}
		table.insert(Mission.IJN_SpawnPoints01, FindEntity("Escort - CV_IJN 01 SP 01"))
		table.insert(Mission.IJN_SpawnPoints01, FindEntity("Escort - CV_IJN 02 SP 01"))
	Mission.IJN_SpawnPoints02 = {}
		table.insert(Mission.IJN_SpawnPoints02, FindEntity("Escort - CV_IJN 01 SP 02"))
		table.insert(Mission.IJN_SpawnPoints02, FindEntity("Escort - CV_IJN 02 SP 02"))

	Mission.Yamato = {}
	Mission.YamatoPath = {}
		table.insert(Mission.YamatoPath, FindEntity("Escort - PathYamato"))

	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, Mission.SouthDakota[1])
		table.insert(Mission.Keyunits, Mission.IJN_Carriers[1])
		table.insert(Mission.Keyunits, Mission.IJN_Carriers[2])


	Mission.Markers = {}
		table.insert(Mission.Markers, Mission.SouthDakota[1])
		table.insert(Mission.Markers, Mission.IJN_Carriers[1])
		table.insert(Mission.Markers, Mission.IJN_Carriers[2])

	--Other stuffs
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	--LOGOFF luaLog("  -> Players total: "..Mission.Players)

	--Party, invincible allitasok
	--[[SetRoleAvailable(Mission.SouthDakota[1], EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.US_Defenders[1], EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.US_Defenders[2], EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.US_Defenders[3], EROLF_ALL, PLAYER_AI)
	for i, pShip in pairs (Mission.US_Tankers) do
		SetRoleAvailable(pShip, EROLF_ALL, PLAYER_AI)
	end]]--
	--SetInvincible(Mission.US_Shipyard[1], 1)
	SetInvincible(Mission.US_Airfield[1], 1)
	SetInvincible(Mission.US_Airfield[2], 1)

	--South Dakota
	--RepairEnable(Mission.SouthDakota[1], false)
	OverrideHP(Mission.SouthDakota[1], Mission.SDHP)
	SetRepairEffectivity(Mission.SouthDakota[1], 0)
	AddDamage(Mission.SouthDakota[1], luaRound(Mission.SDHP / 2))
	Mission.StartingHPPercentage = (GetHpPercentage(Mission.SouthDakota[1]) * 100)

	-- IJN Carriers
	for i, pShip in pairs (Mission.IJN_Carriers) do
		OverrideHP(pShip, Mission.IJNCarrierHP)
		SetRepairEffectivity(pShip, Mission.IJNCarrierRepairEffectivity)
	end

	--japan role allitas
	--[[for i, pShip in pairs (Mission.IJN_Carriers) do
		SetRoleAvailable(pShip, EROLF_ALL, PLAYER_AI)
	end]]--

	--Spawnpoints activation
	--US
	for i = 1, table.getn(Mission.US_SpawnPoints) do
		for j = 0, 7 do
			if (j < 4) then
				ActivateSpawnpoint(Mission.US_SpawnPoints[i], j)
			else
				DeactivateSpawnpoint(Mission.US_SpawnPoints[i], j)
			end
		end
	end
	--japanese
	for i = 1, 2 do
		for j = 0, 7 do
			if (j > 3) then
				ActivateSpawnpoint(Mission.IJN_SpawnPoints01[i], j)
			else
				DeactivateSpawnpoint(Mission.IJN_SpawnPoints01[i], j)
			end
		end
	end
	for i = 1, 2 do
		for j = 0, 7 do
			DeactivateSpawnpoint(Mission.IJN_SpawnPoints02[i], j)
		end
	end


	--Surrender
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")

	-- mission objectives
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "mp12.obj_escort_p1_text",
				["TextCompleted"] = "mp12.obj_escort_p1_comp",
				["TextFailed"] = "mp12.obj_escort_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "mp12.obj_escort_p2_text",
				["TextCompleted"] = "mp12.obj_escort_p2_comp",
				["TextFailed"] = "mp12.obj_escort_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
		["secondary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj1",
				["Text"] = "mp12.obj_escort_s1_text",
				["TextCompleted"] = "mp12.obj_escort_s1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 300,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_sec_obj1",
				["Text"] = "mp12.obj_escort_s2_text",
				["TextCompleted"] = "mp12.obj_escort_s2_comp",
				["TextFailed"] = "mp12.obj_escort_s2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 300,
				["ScoreFailed"] = 0,
			},
		},
	}
-- Mission params
	-- toltes gyorsitas


-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(LobbySettings)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")

	----------------

	Mission.PhaseStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol

	MultiScore=	{
			[0]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[1]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[2]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[3]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[4]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[5]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[6]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
			[7]= {
				[1] = Mission.SouthDakotaHP,
				[2] = Mission.Carrier01HP,
				[3] = Mission.Carrier02HP,
				[4] = Mission.DockedRepairShips,
				[5] = Mission.NumberOfTTs,
			},
		}

	--Events

	-- korulmenyek beallitasa
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort12_think")

	AISetSpawnSceneUnitsWeightMul(0)

	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort12_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end
	Mission.ThinkCounter = Mission.ThinkCounter + 1
	if (Mission.MissionPhase == 1) then
		if (Mission.PhaseStart) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("")
-- RELEASE_LOGOFF  			--LOGOFF luaLog("Adding objectives")
-- RELEASE_LOGOFF  			--LOGOFF luaLog("")
			-- allied objs
			luaObj_Add("primary", 1, Mission.Markers)	-- Mission.IJN_Carriers)
			-- japanese objs
			luaObj_Add("primary", 2, Mission.Markers) -- Mission.SouthDakota)
			this.PhaseStart = false
			luaDelay(luaEscort12_InitSecondary, 3)
			luaEscort12_InitUSUnits()
			luaEscort12_InitIJNUnits()
			luaShowStartingHint()
			luaDelay(luaEscort12_InitDistanceCheck, 3)
			luaEscort12_DisplayUnitHPs()
			luaDelay(luaEscort12_DisplayRepairshipsNum, 3)
			luaEscort12_ImprovedRepair()
			luaEscort12_DisplayDockedShips()
		end
		luaEscort12_CheckingPhase01()
	elseif (Mission.MissionPhase == 2) then
		if (Mission.PhaseStart) then
			Mission.PhaseStart = false
			Mission.EnableAttackManager = true
			luaEscort12_Phase02Start()
		end
		luaEscort12_AttackManager()
	end
	--luaEscort12_CheckPhaseDistance()
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------

function luaShowStartingHint()
	ShowHint("ID_Hint_Escort12")
	luaDelay(luaEscort12_Hint_DamagedSD, 12)
end

---------------------------------------------------------------------------------------------
function luaEscort12_Hint_DamagedSD()
	ShowHint("ID_Hint_Escort12_SD_Damaged")
	luaDelay(luaEscort12_Hint_RepairShips, 20)
end

function luaEscort12_Hint_RepairShips()
	ShowHint("ID_Hint_Escort12_SD_Repairships")
end
---------------------------------------------------------------------------------------------
function luaEscort12_InitDistanceCheck()
	Mission.NeedCarrierDistanceCheck = true
end

---------------------------------------------------------------------------------------------
function luaEscort12_InitSecondary()
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_InitSecondary): Secondary ojjektiva init")
	luaObj_Add("secondary", 1, Mission.US_Tankers)
	luaObj_Add("secondary", 2, Mission.US_Tankers)
	luaDelay(luaEscort12_HintTanker, 30)
	AddListener("kill", "Listener_Tanker",
	{
			["callback"] = "luaEscort12_Tanker_Destroyed",
			["entity"] = Mission.US_Tankers,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end

---------------------------------------------------------------------------------------------
function luaEscort12_HintTanker()
	--ShowHint("ID_Hint_Escort12_Tanker_US")
	--ShowHint("ID_Hint_Escort12_Tanker_IJN")
end

---------------------------------------------------------------------------------------------
function luaEscort12_Tanker_Destroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_Tanker_Destroyed): egy tanker megsemmisult")
	--[[if (pEntity.State == 1) then
		RemoveTrigger(pEntity, "TankerReachedEndPoint")
	end]]--
	--Mission.US_Tankers = luaRemoveDeadsFromTable(Mission.US_Tankers)
	if ((luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil)) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_Tanker_Destroyed): Sec01 failed")
		luaObj_Failed("secondary", 1)
	end

	local bBool = false
	for i, pShip in pairs (Mission.US_Tankers) do
		if (not pShip.Dead) then
			bBool = true
		end
	end
	if (not bBool) then
		Mission.EnableDisplayDockedShips = false
		for i = 0, 7 do
			HideScoreDisplay(2, i)
		end
	end
	--[[if (not bBool) and (luaObj_IsActive("secondary", 2)) and (luaObj_GetSuccess("secondary", 2) == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_Tanker_Destroyed): Az osszes tanker megsemmisult, sec02 complete")
		if (IsListenerActive("kill", "Listener_Tanker")) then
			RemoveListener("kill", "Listener_Tanker")
		end
		luaObj_Completed("secondary", 2)
		if (not Mission.DockingFinished) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Tanker_Destroyed): Az osszes tanker halal miatt a dokkolasnak vege")
			Mission.DockingFinished = true
		end
	end]]--
end

---------------------------------------------------------------------------------------------
function luaEscort12_InitUSUnits()
	for i, pShip in pairs (Mission.US_Tankers) do
		SetShipMaxSpeed(pShip, Mission.SpeedOfTanker)
		NavigatorMoveOnPath(pShip, Mission.US_TankerPath[i], PATH_FM_SIMPLE, PATH_SM_BEGIN)
		pShip.State = 1
		local szID = "TankerReachedEndPoint"..tostring(i)
		AddProximityTrigger(pShip, szID, "luaEscort12_TankerReachedEndPoint", luaGetPathPoint(Mission.US_TankerPath[i], "last"), 1000)
		--[[local nSpeed = Mission.SpeedOfTanker * 1.4
		SetShipMaxSpeed(pShip, nSpeed)]]--
		--SetShipSpeed(pShip, nSpeed)
		--SetShipSpeed(pShip, Mission.SpeedOfTanker)
		NavigatorSetTorpedoEvasion(pShip, false)
		--AISetHintWeight(pShip, 10)
		SetGuiName(pShip, "mp12.hint_escort_repair_desc_title")
	end

	local nSpeedOfTankers = GetShipMaxSpeed(Mission.US_Tankers[1])
	for i, pShip in pairs (Mission.US_TankerDefenders) do
		SetShipMaxSpeed(pShip, nSpeedOfTankers)
		NavigatorMoveOnPath(pShip, Mission.US_TankerDefendersPath[i])
		--SetShipMaxSpeed(pShip, Mission.SpeedOfTankerDefender)
		--SetShipSpeed(pShip, Mission.SpeedOfTankerDefender)
	end

	--SetShipMaxSpeed(Mission.US_Carrier[1], nSpeedOfTankers)
	NavigatorMoveOnPath(Mission.US_Carrier[1], Mission.US_Carrier_Path[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	SetShipMaxSpeed(Mission.US_Carrier[1], Mission.SpeedOfTanker)
	SetShipSpeed(Mission.US_Carrier[1], Mission.SpeedOfTanker)

	NavigatorSetTorpedoEvasion(Mission.SouthDakota[1], false)
	AAEnable(Mission.SouthDakota[1], false)
	ArtilleryEnable(Mission.SouthDakota[1], false)
	SetShipMaxSpeed(Mission.SouthDakota[1], Mission.SpeedOfSD)
	--AISetHintWeight(Mission.SouthDakota[1], 20)

	for i, pShip in pairs (Mission.US_Defenders) do
		NavigatorSetTorpedoEvasion(pShip, false)
		--local nSpeed = GetShipMaxSpeed(Mission.SouthDakota[1])
		SetShipMaxSpeed(pShip, Mission.SpeedOfTanker)
	end

	--[[for i = 0, 7 do
		DisplayUnitHP(i, Mission.SouthDakota, "")
	end]]--


	if (not IsListenerActive("kill", "Listener_SouthDakota")) then
		AddListener("kill", "Listener_SouthDakota",
		{
				["callback"] = "luaEscort12_SouthDakota_Destroyed",
				["entity"] = Mission.SouthDakota,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_TankerReachedEndPoint(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_TankerReachedEndPoint): egy tanker elerte az utso pathpointot")
	pEntity.State = 2
	Mission.DockedRepairShips = Mission.DockedRepairShips + 1
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) and (not pEntity.Dead) then
		luaObj_RemoveUnit("secondary", 1, pEntity)
	end
	local nHPPercentage = luaEscort12_GetRepairPercentage(Mission.NumberOfTTs)
	table.insert(Mission.ImprovedRepairTable, nHPPercentage)
	Mission.EnableImprovedRepair = true

	local bBool = true
	for i, pShip in pairs (Mission.US_Tankers) do
		if (pShip.State ~= 2) and (not pShip.Dead) then
			bBool = false
		end
	end
	if (bBool) then
		Mission.EnableDisplayDockedShips = false
		for i = 0, 7 do
			HideScoreDisplay(2, i)
		end
	end

	--RemoveTrigger(pEntity, "TankerReachedEndPoint")
	if (luaObj_IsActive("secondary", 2)) and (luaObj_GetSuccess("secondary", 2) == nil) then
		luaObj_Failed("secondary", 2)
	end
	--[[if (not Mission.SouthDakota[1].Dead) then
		if (Mission.DockedTankers == 0) then
			Mission.DockedTankers = Mission.DockedTankers + 1
			AAEnable(Mission.SouthDakota[1], true)
			MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_escort_aaenable")
		elseif (Mission.DockedTankers == 1) then
			Mission.DockedTankers = Mission.DockedTankers + 1
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer.party == PARTY_ALLIED) then
					local szPowerUp = "evasive_manoeuvre"
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp12.nar_new_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckShipyard): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
		elseif (Mission.DockedTankers == 2) then
			Mission.DockedTankers = Mission.DockedTankers + 1
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer.party == PARTY_ALLIED) then
					local szPowerUp = "full_throttle"
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp12.nar_new_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckShipyard): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
			if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort12_TankerReachedEndPoint): az osszes tanker kikotott, sec01 complete")
				luaObj_Completed("secondary", 1)
			end

		end

		if (not Mission.DockingFinished) then
			local bBool = false
			for i, pShip in pairs (Mission.US_Tankers) do
				if (not pShip.Dead) and (pShip.State ~= 2) then
					bBool = true
				end
			end
			if (not bBool) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort12_TankerReachedEndPoint): mindegyik tanker dokkolt")
				Mission.DockingFinished = true
			end
		end
	end]]--
end

---------------------------------------------------------------------------------------------
function luaEscort12_DisplayDockedShips()
	if (Mission.EnableDisplayDockedShips) then
		if table.getn(MultiScore) ~= 0 then
			for i = 0, 7 do
				MultiScore[i][4] = Mission.DockedRepairShips
				MultiScore[i][5] = Mission.NumberOfTTs
			end
		end

		DisplayScores(2, 0,"mp12.score_escort_repairships|", "#MultiScore.0.4# / #MultiScore.0.5#")
		DisplayScores(2, 1,"mp12.score_escort_repairships|", "#MultiScore.1.4# / #MultiScore.1.5#")
		DisplayScores(2, 2,"mp12.score_escort_repairships|", "#MultiScore.2.4# / #MultiScore.2.5#")
		DisplayScores(2, 3,"mp12.score_escort_repairships|", "#MultiScore.3.4# / #MultiScore.3.5#")
		DisplayScores(2, 4,"mp12.score_escort_repairships|", "#MultiScore.4.4# / #MultiScore.4.5#")
		DisplayScores(2, 5,"mp12.score_escort_repairships|", "#MultiScore.5.4# / #MultiScore.5.5#")
		DisplayScores(2, 6,"mp12.score_escort_repairships|", "#MultiScore.6.4# / #MultiScore.6.5#")
		DisplayScores(2, 7,"mp12.score_escort_repairships|", "#MultiScore.7.4# / #MultiScore.7.5#")
	end
	luaDelay(luaEscort12_DisplayDockedShips, 1)
end

---------------------------------------------------------------------------------------------
function luaEscort12_CarrierReachedEndPoint(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_CarrierReachedEndPoint): egy carrier kozel van az utso pathpointhoz, indul a phase02")
	for i, pShip in pairs (Mission.IJN_Carriers) do
		if (not pShip.Dead) then
			RemoveTrigger(pShip, "CarrierReachedEndPoint")
		end
	end
	--luaEscort12_GenerateYamato()
end

---------------------------------------------------------------------------------------------
function luaEscort12_GenerateYamato()
	local tUnitTemplate = luaFindHidden("Escort - Yamato")
	szName = "Escort - Yamato"
	pUnit = GenerateObject(tUnitTemplate.Name, szName)
	table.insert(Mission.Yamato, pUnit)
	luaDelay(luaEscort12_YamatoStartingTomove, 2)
end

---------------------------------------------------------------------------------------------
function luaEscort12_YamatoStartingTomove()
	NavigatorMoveOnPath(Mission.Yamato[1], Mission.YamatoPath[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.Yamato[1], "YamatoReachedEndPoint", "luaEscort12_EndMission", luaGetPathPoint(Mission.YamatoPath[1], "last"), 500)
end

---------------------------------------------------------------------------------------------
function luaEscort12_EndMission()
	luaObj_Failed("primary", 1)
	luaObj_Completed("primary", 2)
	luaDelay(luaMissionEnd_IJN, 3)
	Scoring_RealPlayTimeRunning(false)
	local bBool = true
	for i, pUnit in pairs (Mission.IJN_Carriers) do
		if (not pUnit.Dead) then
			SetInvincible(pUnit, 1)
		else
			bBool = false
		end
	end
	if (bBool) then
		Mission.AchievementReached = true
		for i = 4, 7 do
-- RELEASE_LOGOFF  			luaLog("Player0"..tostring(i)..": Le Protector ACHIEVEMENT UNLOCKED")
			SetAchievements(i, "MA_DLC03TP")
		end
	end
	SetInvincible(Mission.SouthDakota[1], 1)
end

---------------------------------------------------------------------------------------------
function luaEscort12_InitIJNUnits()

	AISetTargetWeight("DIVEBOMBER", "MOTHERSHIP", false, 50)
	AISetTargetWeight("TORPEDOBOMBER", "MOTHERSHIP", false, 50)
	AISetTargetWeight("DIVEBOMBER", "BATTLESHIP", false, 50)
	AISetTargetWeight("TORPEDOBOMBER", "BATTLESHIP", false, 50)
	AISetTargetWeight("KAMIKAZEPLANE", "BATTLESHIP", false, 55)
	AISetTargetWeight("KAMIKAZEPLANE", "BATTLESHIP", false, 55)

	--[[AISetTargetWeight(151, 26, false, 0)	-- Raiden vs. Hellcat
	AISetTargetWeight(151, 38, false, 0)	-- Raiden vs. Helldiver
	AISetTargetWeight(151, 113, false, 0)	-- Raiden vs. Avenger
	AISetTargetWeight(163, 26, false, 0)	-- Jill vs. Hellcat
	AISetTargetWeight(163, 38, false, 0)	-- Jill vs. Helldiver
	AISetTargetWeight(163, 113, false, 0)	-- Jill vs. Avenger
	AISetTargetWeight(159, 26, false, 0)	-- Judy vs. Hellcat
	AISetTargetWeight(159, 38, false, 0)	-- Judy vs. Helldiver
	AISetTargetWeight(159, 113, false, 0)	-- Judy vs. Avenger

	AISetTargetWeight(26, 151, false, 0)	-- Hellcat vs. Raiden
	AISetTargetWeight(26, 163, false, 0)	-- Hellcat vs. Jill
	AISetTargetWeight(26, 159, false, 0)	-- Hellcat vs. Judy
	AISetTargetWeight(38, 151, false, 0)	-- Helldiver vs. Raiden
	AISetTargetWeight(38, 163, false, 0)	-- Helldiver vs. Jill
	AISetTargetWeight(38, 159, false, 0)	-- Helldiver vs. Judy
	AISetTargetWeight(113, 151, false, 0)	-- Avenger vs. Raiden
	AISetTargetWeight(113, 163, false, 0)	-- Avenger vs. Jill
	AISetTargetWeight(113, 159, false, 0)	-- Avenger vs. Judy]]--

	for i, pShip in pairs (Mission.IJN_Carriers) do
-- RELEASE_LOGOFF  		luaLog("(Trigger init): "..pShip.Name)
		SetShipMaxSpeed(pShip, Mission.SpeedOfCarrier)
		NavigatorMoveOnPath(pShip, Mission.IJN_CarrierPath[i], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		--AddProximityTrigger(pShip, "CarrierReachedEndPoint", "luaEscort12_CarrierReachedEndPoint", luaGetPathPoint(Mission.IJN_CarrierPath[i], "last"), 1000)
		--AISetHintWeight(pShip, 20)
	end

	for i, pShip in pairs (Mission.IJN_CarrierEscort01) do
		JoinFormation(pShip, Mission.IJN_Carriers[1])
	end
	for i, pShip in pairs (Mission.IJN_CarrierEscort02) do
		JoinFormation(pShip, Mission.IJN_Carriers[2])
	end


	if (not IsListenerActive("kill", "Listener_Carrier")) then
		AddListener("kill", "Listener_Carrier",
		{
				["callback"] = "luaEscort12_Carrier_Destroyed",
				["entity"] = Mission.IJN_Carriers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_DisplayUnitHPs()
	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.MissionEnd == true then
		return
	end

	if (not Mission.SouthDakota[1].Dead) then
		Mission.SouthDakotaHP = luaRound((GetHpPercentage(Mission.SouthDakota[1]) * 100 ))
		if (Mission.SouthDakotaHP < 26) and (Mission.ThinkCounter > Mission.NextSDHPNarrative) then
			for i = 0, 3 do
				MissionNarrativePlayer(i, "mp12.nar_escort_sd_hplow_us")
			end
			Mission.NextSDHPNarrative = Mission.ThinkCounter + 40		-- 40 thinkcounter mulva a kov. (120 mp)
		end
	else
		Mission.SouthDakotaHP = 0
	end
	if (not Mission.IJN_Carriers[1].Dead) then
		Mission.Carrier01HP = luaRound((GetHpPercentage(Mission.IJN_Carriers[1]) * 100))
		if (Mission.Carrier01HP < 26) and (Mission.ThinkCounter > Mission.NextCarrierHPNarrative) then
			for i = 4, 7 do
				MissionNarrativePlayer(i, "mp12.nar_escort_carrierhplow_ijn")
			end
			Mission.NextCarrierHPNarrative = Mission.ThinkCounter + 40		-- 40 thinkcounter mulva a kov. (120 mp)
		end
	else
		Mission.Carrier01HP = 0
	end
	if (not Mission.IJN_Carriers[2].Dead) then
		Mission.Carrier02HP = luaRound((GetHpPercentage(Mission.IJN_Carriers[2]) * 100))
		if (Mission.Carrier02HP < 26) and (Mission.ThinkCounter > Mission.NextCarrierHPNarrative) then
			for i = 4, 7 do
				MissionNarrativePlayer(i, "mp12.nar_escort_carrierhplow_ijn")
			end
			Mission.NextCarrierHPNarrative = Mission.ThinkCounter + 40		-- 40 thinkcounter mulva a kov. (120 mp)
		end
	else
		Mission.Carrier02HP = 0
	end

	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.SouthDakotaHP
			MultiScore[i][2] = Mission.Carrier01HP
			MultiScore[i][3] = Mission.Carrier02HP
		end
	end

	--[[DisplayScores(1, 0,"mp12.score_escort_sd_hp|".." #MultiScore.0.1# %","")
	DisplayScores(1, 1,"mp12.score_escort_sd_hp|".." #MultiScore.1.1# %","")
	DisplayScores(1, 2,"mp12.score_escort_sd_hp|".." #MultiScore.2.1# %","")
	DisplayScores(1, 3,"mp12.score_escort_sd_hp|".." #MultiScore.3.1# %","")
	DisplayScores(1, 4,"mp12.score_escort_sd_hp|".." #MultiScore.4.1# %","")
	DisplayScores(1, 5,"mp12.score_escort_sd_hp|".." #MultiScore.5.1# %","")
	DisplayScores(1, 6,"mp12.score_escort_sd_hp|".." #MultiScore.6.1# %","")
	DisplayScores(1, 7,"mp12.score_escort_sd_hp|".." #MultiScore.7.1# %","")

	DisplayScores(2, 0,"mp12.score_escort_cv01_hp|".." #MultiScore.0.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.0.3# %",1,1)
	DisplayScores(2, 1,"mp12.score_escort_cv01_hp|".." #MultiScore.1.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.1.3# %",1,1)
	DisplayScores(2, 2,"mp12.score_escort_cv01_hp|".." #MultiScore.2.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.2.3# %",1,1)
	DisplayScores(2, 3,"mp12.score_escort_cv01_hp|".." #MultiScore.3.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.3.3# %",1,1)
	DisplayScores(2, 4,"mp12.score_escort_cv01_hp|".." #MultiScore.4.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.4.3# %",1,1)
	DisplayScores(2, 5,"mp12.score_escort_cv01_hp|".." #MultiScore.5.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.5.3# %",1,1)
	DisplayScores(2, 6,"mp12.score_escort_cv01_hp|".." #MultiScore.6.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.6.3# %",1,1)
	DisplayScores(2, 7,"mp12.score_escort_cv01_hp|".." #MultiScore.7.2# %","mp12.score_escort_cv02_hp|".." #MultiScore.7.3# %",1,1)]]--

	DisplayScores(1, 0, "mp12.score_escort_sd_hp|".." #MultiScore.0.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.0.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.0.3# %",2,1)
	DisplayScores(1, 1, "mp12.score_escort_sd_hp|".." #MultiScore.1.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.1.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.1.3# %",2,1)
	DisplayScores(1, 2, "mp12.score_escort_sd_hp|".." #MultiScore.2.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.2.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.2.3# %",2,1)
	DisplayScores(1, 3, "mp12.score_escort_sd_hp|".." #MultiScore.3.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.3.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.3.3# %",2,1)
	DisplayScores(1, 4, "mp12.score_escort_sd_hp|".." #MultiScore.4.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.4.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.4.3# %",2,1)
	DisplayScores(1, 5, "mp12.score_escort_sd_hp|".." #MultiScore.5.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.5.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.5.3# %",2,1)
	DisplayScores(1, 6, "mp12.score_escort_sd_hp|".." #MultiScore.6.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.6.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.6.3# %",2,1)
	DisplayScores(1, 7, "mp12.score_escort_sd_hp|".." #MultiScore.7.1# %", "mp12.score_escort_cv01_hp|".." #MultiScore.7.2# %".." - ".."|mp12.score_escort_cv02_hp|".." #MultiScore.7.3# %",2,1)

	luaDelay(luaEscort12_DisplayUnitHPs, 1)

end

---------------------------------------------------------------------------------------------
function luaEscort12_DisplayRepairshipsNum()
	DisplayScores(2, 0,"mp12.score_escort_repairships|", "#MultiScore.0.4# / #MultiScore.0.5#")
	DisplayScores(2, 1,"mp12.score_escort_repairships|", "#MultiScore.1.4# / #MultiScore.1.5#")
	DisplayScores(2, 2,"mp12.score_escort_repairships|", "#MultiScore.2.4# / #MultiScore.2.5#")
	DisplayScores(2, 3,"mp12.score_escort_repairships|", "#MultiScore.3.4# / #MultiScore.3.5#")
	DisplayScores(2, 4,"mp12.score_escort_repairships|", "#MultiScore.4.4# / #MultiScore.4.5#")
	DisplayScores(2, 5,"mp12.score_escort_repairships|", "#MultiScore.5.4# / #MultiScore.5.5#")
	DisplayScores(2, 6,"mp12.score_escort_repairships|", "#MultiScore.6.4# / #MultiScore.6.5#")
	DisplayScores(2, 7,"mp12.score_escort_repairships|", "#MultiScore.7.4# / #MultiScore.7.5#")
end

---------------------------------------------------------------------------------------------
function luaEscort12_SouthDakota_Destroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_SouthDakota_Destroyed): a South Dakota megmurdalt")
	if (IsListenerActive("kill", "Listener_SouthDakota")) then
		RemoveListener("kill", "Listener_SouthDakota")
	end
	Mission.NeedCarrierDistanceCheck = false
	Mission.EnableAttackManager = false
	luaObj_Failed("primary", 1)
	luaObj_Completed("primary", 2)
	luaDelay(luaMissionEnd_IJN, 3)
	Scoring_RealPlayTimeRunning(false)
	local bBool = true
	for i, pUnit in pairs (Mission.IJN_Carriers) do
		if (not pUnit.Dead) then
			SetInvincible(pUnit, 1)
		else
			bBool = false
		end
	end
	if (bBool) then
		Mission.AchievementReached = true
		for i = 4, 7 do
-- RELEASE_LOGOFF  			luaLog("Player0"..tostring(i)..": Le Protector ACHIEVEMENT UNLOCKED")
			SetAchievements(i, "MA_DLC03TP")
		end
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_Carrier_Destroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_Carrier_Destroyed): egy carrier megsemmisult")
	--Mission.IJN_Carriers = luaRemoveDeadsFromTable(Mission.IJN_Carriers)
	pEntity.Dead = true
	--Attackmanagernek kell
	if (Mission.EnableAttackManager) and (pEntity == (luaGetScriptTarget(Mission.SouthDakota[1]))) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_Carrier_Destroyed): A SouthDakota Targete megsemmisult, ideiglenesen nil lesz")
		luaSetScriptTarget(Mission.SouthDakota[1], nil)
	end

	if (Mission.EnableAttackManager) then
		for i, pShip in pairs (Mission.US_Defenders) do
			if (not pShip.Dead) then
				if  (pEntity == (luaGetScriptTarget(pShip))) then
-- RELEASE_LOGOFF  					luaLog("(luaEscort12_Carrier_Destroyed): Az egyik SD defender Targete megsemmisult, ideiglenesen nil lesz")
					luaSetScriptTarget(pShip, nil)
				end
			end
		end
	end

	local bBool = false
	local nIndex = 1
	for i, pUnit in pairs (Mission.IJN_Carriers) do
		if (not pUnit.Dead) then
			bBool = true
		end
		if (pEntity == pUnit) then
			nIndex = i
		end
	end
	if (not bBool) then
		if (IsListenerActive("kill", "Listener_Carrier")) then
			RemoveListener("kill", "Listener_Carrier")
		end
		Mission.NeedCarrierDistanceCheck = false
		Mission.EnableAttackManager = false
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 1)
		
		local bObj02 = true
		local nDocked = 0
-- RELEASE_LOGOFF  		luaLog("------------Mission End----------")
		for i, pShip in pairs (Mission.US_Tankers) do
-- RELEASE_LOGOFF  			luaLog("pShip.Dead = "..tostring(pShip.Dead))
-- RELEASE_LOGOFF  			luaLog("pShip.State = "..pShip.State)
			if ((pShip.Dead) and (pShip.State < 2)) then
				bObj02 = false
			end
		end
		if (bObj02) and (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_CheckingPhase01): Sec02 completed")
			luaObj_Completed("secondary", 1)
		end
		
		luaDelay(luaMissionEnd_USN, 3, "nIndex", nIndex)
		Scoring_RealPlayTimeRunning(false)
		SetInvincible(Mission.SouthDakota[1], 1)
	else
		-- a kiseroinek formaciot valtunk
		if (pEntity.Number == 1) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Carrier_Destroyed): Az 1-es carrier semmisult, kiserete formaciot valt")
			for i, pShip in pairs (Mission.IJN_CarrierEscort01) do
				if (not pShip.Dead) and (not Mission.SouthDakota[1].Dead) then
					--DisbandFormation(pShip)
					--JoinFormation(pShip, Mission.IJN_Carriers[2])
					NavigatorAttackMove(pShip, Mission.SouthDakota[1], {})
				end
			end
		elseif (pEntity.Number == 2) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Carrier_Destroyed): Az 2-es carrier semmisult, kiserete formaciot valt")
			for i, pShip in pairs (Mission.IJN_CarrierEscort02) do
				if (not pShip.Dead) and (not Mission.SouthDakota[1].Dead) then
					--DisbandFormation(pShip)
					--JoinFormation(pShip, Mission.IJN_Carriers[1])
					NavigatorAttackMove(pShip, Mission.SouthDakota[1], {})
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_CheckingPhase01()
	local bBool = false
	local bObj02 = true
	local nDocked = 0

-- RELEASE_LOGOFF  	luaLog("------------")
	for i, pShip in pairs (Mission.US_Tankers) do
-- RELEASE_LOGOFF  		luaLog("pShip.Dead = "..tostring(pShip.Dead))
-- RELEASE_LOGOFF  		luaLog("pShip.State = "..pShip.State)
		if (not pShip.Dead) and (pShip.State < 2) then
			bBool = true
			bObj02 = false
		end
-- RELEASE_LOGOFF  		luaLog("bBool = "..tostring(bBool))
		if (pShip.State == 2) then
			bObj02 = false
			nDocked = nDocked + 1
		end
	end

-- RELEASE_LOGOFF  	luaLog("nDocked "..tostring(nDocked))

	if (bObj02) and (luaObj_IsActive("secondary", 2)) and (luaObj_GetSuccess("secondary", 2) == nil) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_CheckingPhase01): Sec02 completed")
		luaObj_Completed("secondary", 2)
	end

	if (nDocked == Mission.NumberOfTTs) and (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
		luaObj_Completed("secondary", 1)
		Mission.EnableDisplayDockedShips = false
		for i = 0, 7 do
			HideScoreDisplay(2, i)
		end
	end

-- RELEASE_LOGOFF  	luaLog("************")
-- RELEASE_LOGOFF  	luaLog("*bBool = "..tostring(bBool))
	if (not bBool) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_CheckingPhase01): Phase02 indul")
		Mission.MissionPhase = 2
		Mission.PhaseStart = true
	end
-- RELEASE_LOGOFF  	luaLog("------------")
end

---------------------------------------------------------------------------------------------
--[[function luaEscort12_CheckPhaseDistance()
	if (Mission.NeedCarrierDistanceCheck) then
		local bBool = false
		local nDistance = 100000
		if (not Mission.IJN_Carriers[1].Dead) then
-- RELEASE_LOGOFF  			luaLog("nDistance #1 = ")
-- RELEASE_LOGOFF  			luaLog(nDistance)
			nDistance = luaGetDistance(Mission.IJN_Carriers[1], Mission.PhasePathPoint[1])
-- RELEASE_LOGOFF  			luaLog("Distance #2 = ")
-- RELEASE_LOGOFF  			luaLog(nDistance)
			if (nDistance < 600) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_CheckPhaseDistance): carrier01 elerte a phase pathpointot, phase valtas kezdodik")
				bBool = true
			end
		end
		if (not bBool) and (not Mission.IJN_Carriers[2].Dead) then
			nDistance = luaGetDistance(Mission.IJN_Carriers[2], Mission.PhasePathPoint[1])
			if (nDistance < 600) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_CheckPhaseDistance): carrier02 elerte a phase pathpointot, phase valtas kezdodik")
				bBool = true
			end
		end
		if (bBool) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort10_CheckPhaseDistance): a Carrier elerte a Phase02-es navpointot")
			Mission.NeedCarrierDistanceCheck = false
			Mission.CarrierReachedNavpoint = true
			--luaEscort12_Phase02Start()
		end
	end
end]]--

---------------------------------------------------------------------------------------------
function luaEscort12_AttackManager()
	if (Mission.EnableAttackManager) and (not Mission.SouthDakota[1].Dead) then
		local pActTarget = luaGetScriptTarget(Mission.SouthDakota[1])
		if (pActTarget == nil) or ((pActTarget ~= nil) and (pActTarget.Dead)) then
			local pTarget = luaEscort12_GetNearestEnemy(Mission.SouthDakota[1], Mission.IJN_Carriers)
			if (pTarget ~= nil) then
				luaSetScriptTarget(Mission.SouthDakota[1], pTarget)
				NavigatorAttackMove(Mission.SouthDakota[1], pTarget, {})
			end
		end
		--[[for i, pShip in pairs (Mission.US_Defenders) do
			if (not pShip.Dead) then
				local pActTarget = luaGetScriptTarget(pShip)
				if (pActTarget == nil) or ((pActTarget ~= nil) and (pActTarget.Dead)) then
					local pTarget = luaEscort12_GetNearestEnemy(pShip, Mission.IJN_Carriers)
					if (pTarget ~= nil) then
						luaSetScriptTarget(pShip, pTarget)
						NavigatorAttackMove(pShip, pTarget, {})
					end
				end
			end
		end]]--
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_Phase02Start()
	--[[local pTarget = nil
	local nDistance = 1000000
	for i, pShip in pairs (Mission.IJN_Carriers) do
		local nActDistance = luaGetDistance(Mission.SouthDakota[1], pShip)
		if (nActDistance < nDistance) then
			nDistance = nActDistance
			pTarget = pShip
		end
	end]]--
	--if (not Mission.Phase02Started) and (Mission.CarrierReachedNavpoint) and (Mission.DockingFinished) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_Phase02Start): A South Dakota elindul")
		Mission.Phase02Started = true
		local pTarget = luaEscort12_GetNearestEnemy(Mission.SouthDakota[1], Mission.IJN_Carriers)
		if (pTarget ~= nil) and (not Mission.SouthDakota[1].Dead) then
			luaSetScriptTarget(Mission.SouthDakota[1], pTarget)
			NavigatorAttackMove(Mission.SouthDakota[1], pTarget, {})
			NavigatorSetTorpedoEvasion(Mission.SouthDakota[1], true)
			--AAEnable(Mission.SouthDakota[1], true)
			ArtilleryEnable(Mission.SouthDakota[1], true)
			if (Mission.DockedRepairShips == 0) then
				SetRepairEffectivity(Mission.SouthDakota[1], Mission.SDBaseRepairEffectivity)
			end

			Mission.EnableAttackManager = true

			Mission.US_Defenders = luaRemoveDeadsFromTable(Mission.US_Defenders)
			for i, pShip in pairs (Mission.US_Defenders) do
				if (not pShip.Dead) then
					NavigatorSetTorpedoEvasion(pShip, true)
					--[[luaSetScriptTarget(pShip, pTarget)
					NavigatorAttackMove(pShip, pTarget, {})]]--
					JoinFormation(pShip, Mission.SouthDakota[1])
				end
			end

			Mission.US_TankerDefenders = luaRemoveDeadsFromTable(Mission.US_TankerDefenders)
			for i, pShip in pairs (Mission.US_TankerDefenders) do
				NavigatorSetTorpedoEvasion(pShip, true)
				JoinFormation(pShip, Mission.SouthDakota[1])
			end

			--[[NavigatorMoveOnPath(Mission.US_Carrier[1], Mission.US_Carrier_Path[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
			AddProximityTrigger(Mission.US_Carrier[1], "CarrierReachedEndPath01", "luaEscort12_CarrierReachedEndPath01", luaGetPathPoint(Mission.US_Carrier_Path[1], "last"), 500)]]--
			luaDelay(luaEscort12_HintSouthDakota, 5)
		end


		if (not Mission.US_Carrier[1].Dead) then
			for j = 0, 3 do
				DeactivateSpawnpoint(Mission.US_SpawnPoints[2], j)
			end
		end

		--IJN carrierek elinditasa
		for i, pShip in pairs (Mission.IJN_Carriers) do
			if (not pShip.Dead) then
				NavigatorMoveOnPath(pShip, Mission.IJN_CarrierEscapePath[i], PATH_FM_SIMPLE, PATH_SM_BEGIN)
			end
		end

		-- South Dakota HP-janak initje
		--[[local nTTDockedNum = 0
		for i, pShip in pairs (Mission.US_Tankers) do
			if (pShip.State == 2) then
				nTTDockedNum = nTTDockedNum + 1
			end
		end
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_Phase02Start): dokkolt hajok szama = "..nTTDockedNum)
		if (nTTDockedNum ~= 0) then
			local nHPPercentage = luaEscort12_GetRepairPercentage(Mission.NumberOfTTs)
			Mission.StartingHPPercentage = luaRound(GetHpPercentage(Mission.SouthDakota[1]) * 100)
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Phase02Start): Most ennyin all = "..tostring(Mission.StartingHPPercentage))
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Phase02Start): Ennyivel novelem = "..(nHPPercentage * nTTDockedNum))
			Mission.ImprovedMaxHPPercentage = Mission.StartingHPPercentage + luaRound(nHPPercentage * nTTDockedNum)
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_Phase02Start): Ennyire novelem = "..Mission.ImprovedMaxHPPercentage)
			if (Mission.ImprovedMaxHPPercentage > 99) then
				Mission.ImprovedMaxHPPercentage = 100
			end
			SetRepairEffectivity(Mission.SouthDakota[1], 8)
			Mission.EnableImprovedRepair = true
			luaEscort12_ImprovedRepair()
		end]]--
	--end
end

---------------------------------------------------------------------------------------------
--[[function luaEscort12_ImprovedRepairInit()
	local nHPPercentage = luaEscort12_GetRepairPercentage(Mission.NumberOfTTs)
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_Phase02Start): Most ennyin all = "..tostring(GetHpPercentage(Mission.SouthDakota[1])))
	--luaLog("(luaEscort12_Phase02Start): Ennyivel novelem #1 = "..((nHPPercentage * nTTDockedNum) / 2))
	Mission.StartingHPPercentage = GetHpPercentage(Mission.SouthDakota[1])
	Mission.ImprovedMaxHPPercentage = Mission.ImprovedMaxHPPercentage + nHPPercentage
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_Phase02Start): Ennyivel novelem #2 = "..Mission.ImprovedMaxHPPercentage)
	if (Mission.ImprovedMaxHPPercentage > 99) then
		Mission.ImprovedMaxHPPercentage = 100
	end
	SetRepairEffectivity(Mission.SouthDakota[1], 8)
	Mission.EnableImprovedRepair = true
end]]--

---------------------------------------------------------------------------------------------
function luaEscort12_ImprovedRepair()
	if (Mission.EnableImprovedRepair) and (not Mission.SouthDakota[1].Dead) then
		local nActHP = (GetHpPercentage(Mission.SouthDakota[1]) * 100)
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_ImprovedRepair): nActHP = "..nActHP)
-- RELEASE_LOGOFF  		luaLog("(luaEscort12_ImprovedRepair): ImprovedMaxHPPercentage = "..Mission.ImprovedMaxHPPercentage)
		if (nActHP >= Mission.ImprovedMaxHPPercentage) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort12_ImprovedRepair): a South Dakota felrepairelodott")
			if (table.getn(Mission.ImprovedRepairTable) > 0) then
				Mission.ImprovedMaxHPPercentage = (GetHpPercentage(Mission.SouthDakota[1]) * 100) + Mission.ImprovedRepairTable[1]
				if (Mission.ImprovedMaxHPPercentage > 99) then
					Mission.ImprovedMaxHPPercentage = 100
				end
				table.remove(Mission.ImprovedRepairTable, 1)
				SetRepairEffectivity(Mission.SouthDakota[1], 8)
			else
				Mission.EnableImprovedRepair = false
				SetRepairEffectivity(Mission.SouthDakota[1], Mission.SDBaseRepairEffectivity)
			end
		end
	end
	luaDelay(luaEscort12_ImprovedRepair, 1)
end

---------------------------------------------------------------------------------------------
function luaEscort12_HintSouthDakota()
	if (not Mission.MissionEnd) then
		ShowHint("ID_Hint_Escort12_SD")
		--ShowHint("ID_Hint_Escort12_SD_IJN")
		luaDelay(luaEscort12_KamikazeEnable, 5)
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_KamikazeEnable()
	if (not Mission.MissionEnd) then
		for i = 1, 2 do
			if (Mission.IJN_Carriers[i] ~= nil) and (not Mission.IJN_Carriers[i].Dead) then
				for j = 0, 7 do
					DeactivateSpawnpoint(Mission.IJN_SpawnPoints01[i], j)
				end
			end
		end
		for i = 1, 2 do
			if (Mission.IJN_Carriers[i] ~= nil) and (not Mission.IJN_Carriers[i].Dead) then
				for j = 0, 7 do
					if (j > 3) then
						ActivateSpawnpoint(Mission.IJN_SpawnPoints02[i], j)
					else
						DeactivateSpawnpoint(Mission.IJN_SpawnPoints02[i], j)
					end
				end
			end
		end
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_escort_kamikaze")
	end
end

---------------------------------------------------------------------------------------------
function luaEscort12_CarrierReachedEndPath01(pEntity)
	RemoveTrigger(pEntity, "CarrierReachedEndPath01")
-- RELEASE_LOGOFF  	luaLog("(luaEscort12_CarrierReachedEndPath01): Az US carrier elerte az 1. path utso pontjat, elindul a 2. path-on")
	NavigatorMoveOnPath(Mission.US_Carrier[1], Mission.US_Carrier_Path[2], PATH_FM_CIRCLE, PATH_SM_BEGIN)
end

---------------------------------------------------------------------------------------------
function luaEscort12_GetNearestEnemy(pUnit, tTable)
	local nDistance = 1000000
	local pTarget = nil
	for i, pEntity in pairs (tTable) do
		if (not pEntity.Dead) then
			local nActDistance = luaGetDistance(pUnit, pEntity)
			if (nActDistance < nDistance) then
				nDistance = nActDistance
				pTarget = pEntity
			end
		end
	end
	return pTarget
end

---------------------------------------------------------------------------------------------
function luaEscort12_GetRepairPercentage(nLength)
	--local nLength = table.getn(tTable)
	--local nMaxHP = pEntity.HP
	local nHPPercentage = luaRound((100 / nLength) / 2)
	return nHPPercentage
end

---------------------------------------------------------------------------------------------
function luaMissionEnd_IJN()
	local pTarget = nil
	if (not TrulyDead(Mission.SouthDakota[1])) then
		pTarget = Mission.SouthDakota[1]
	elseif (not Mission.IJN_Carriers[1].Dead) then
		pTarget = Mission.IJN_Carriers[1]
	else
		pTarget = Mission.IJN_Carriers[2]
	end
	luaMissionCompletedNew(pTarget, "", nil, nil, nil, PARTY_JAPANESE)
	Mission.MissionEnd = true
end

---------------------------------------------------------------------------------------------
function luaMissionEnd_USN(TimeThis)
	local nIndex = TimeThis.ParamTable.nIndex
	local pTarget = nil
	if (not TrulyDead(Mission.IJN_Carriers[nIndex])) then
		pTarget = Mission.IJN_Carriers[nIndex]
	else
		pTarget = Mission.SouthDakota[1]
	end
	luaMissionCompletedNew(pTarget, "", nil, nil, nil, PARTY_ALLIED)
	Mission.MissionEnd = true
end


---------------------------------------------------------------------------------------------
-- Cheat Fv-ek
---------------------------------------------------------------------------------------------
function d1()
	for i, pShip in pairs (Mission.IJN_Carriers) do
		SetShipMaxSpeed(pShip, 99)
	end
	for i, pShip in pairs (Mission.US_Tankers) do
		SetShipMaxSpeed(pShip, 99)
		SetShipSpeed(pShip, 99)
	end
	SetShipMaxSpeed(Mission.US_Carrier[1], 99)
	SetShipMaxSpeed(Mission.SouthDakota[1], 99)
	for i, pShip in pairs (Mission.US_Defenders) do
		SetShipMaxSpeed(pShip, 99)
	end
end

function d2()
	for i, pShip in pairs (Mission.IJN_Carriers) do
		SetShipMaxSpeed(pShip, Mission.SpeedOfCarrier)
	end
	for i, pShip in pairs (Mission.US_Tankers) do
		SetShipMaxSpeed(pShip, Mission.SpeedOfTanker)
	end
end

function c()
	for i, pShip in pairs (Mission.IJN_Carriers) do
		SetInvincible(pShip, 1)
	end
end

function b()
	for i, pShip in pairs (Mission.US_Tankers) do
		Kill(pShip)
	end
end

function a()
	Mission.NeedCarrierDistanceCheck = false
	luaEscort12_Phase02Start()
end