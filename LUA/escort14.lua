-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------

Inputs = nil
function luaPrecacheUnits()
	--PrepareClass(59)		-- Yamato
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort14")
end

function luaInitEscort14(this)
	Mission = this

	--local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5") 
	this.Name = "Escort14"

-- logolasok
--	DamageLog = true
	Mission.HelperLog = false
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort14")

	Mission.Multiplayer = true
	Mission.MultiplayerType = "Escort"
	Mission.MultiplayerNumber = 14

	-- Loc-Kit dolgok
	Music_Control_SetLevel(MUSIC_TENSION)

	--Other stuffs
	Mission.PlayersTable = GetPlayerDetails()
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end

	if LobbySettings.ReloadPayload == "globals.on" then
		Mission.ReloadPayLoad = true
	else
		Mission.ReloadPayLoad = false
	end

	--[[
	 Escort - USN SpawnPoint 01
Escort - USN SpawnPoint 02
Escort - USN SpawnPoint 03
Escort - IJN_BB 01
Escort - IJN_BB 02
Escort - IJNPath
Escort - IJN_CV
Escort - Zero
Escort - Val
Escort - Kate
Escort - USN_BB 01
Escort - USN_BB 02
Escort - USN_CV
Escort - Wildcat
Escort - Avenger
Escort - Dauntless
	]]

	Mission.JPBB1 = FindEntity("Escort - IJN_BB 01")
	SetGuiName(Mission.JPBB1, "ingame.shipnames_fuso")
	Mission.JPBB2 = FindEntity("Escort - IJN_BB 02")
	SetGuiName(Mission.JPBB2, "ingame.shipnames_yamashiro")
	Mission.JPCV = FindEntity("Escort - IJN_CV")
	SetShipMaxSpeed(Mission.JPCV, 8)

	Mission.JPFleet = {}
	table.insert(Mission.JPFleet, Mission.JPBB1)
	table.insert(Mission.JPFleet, Mission.JPBB2)
	table.insert(Mission.JPFleet, Mission.JPCV)

	OverrideHP(Mission.JPBB1, 45000)
	OverrideHP(Mission.JPBB2, 45000)
--[[
	NavigatorSetTorpedoEvasion(Mission.JPBB1, false)
	NavigatorSetTorpedoEvasion(Mission.JPBB2, false)
	NavigatorSetTorpedoEvasion(Mission.JPCV, false)
]]
	SetRepairEffectivity(Mission.JPBB1, 0.3)
	SetRepairEffectivity(Mission.JPBB2, 0.3)

	Mission.JPCV_Planes = {}
	--Mission.JPCV_Cap = {}

	Mission.JPCVPath = FindEntity("Escort - IJNPath 01")
	Mission.BBPath1 = FindEntity("Escort - IJNPath 02")
	Mission.BBPath2 = FindEntity("Escort - IJNPath 03")

	Mission.USBB1 = FindEntity("Escort - USN_BB 01")
	SetGuiName(Mission.USBB1, "ingame.shipnames_iowa")
	Mission.USBB2 = FindEntity("Escort - USN_BB 02")
	SetGuiName(Mission.USBB2, "ingame.shipnames_south_dakota")
	Mission.USCV = FindEntity("Escort - USN_CV")
	Mission.USCV_Planes = {}
	--Mission.USCV_Cap = {}

	Mission.Base1 = {FindEntity("CB7_SY")}
	Mission.Base2 = {FindEntity("CB4_SY")}
	Mission.Base3 = {FindEntity("CB3_SY")}

	OverrideHP(FindEntity("CB7_SY"), 7500)
	OverrideHP(FindEntity("CB4_SY"), 7500)
	OverrideHP(FindEntity("CB3_SY"), 7500)

	for idx,sy in pairs(luaSumTablesIndex(Mission.Base1, Mission.Base2, Mission.Base3)) do
		SetParty(sy, PARTY_ALLIED)
	end

	Mission.BaseUnderSiege = {}

	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, Mission.JPBB1)
		table.insert(Mission.Keyunits, Mission.JPBB2)
		table.insert(Mission.Keyunits, Mission.Base1[1])
		table.insert(Mission.Keyunits, Mission.Base2[1])
		table.insert(Mission.Keyunits, Mission.Base3[1])


	Mission.DistCheckNeeded = true

	Mission.PlaneTemplates = {
		[PARTY_JAPANESE] = {
			["Fighter"] = luaFindHidden("Escort - Zero"),
			["TorpedoBomber"] = luaFindHidden("Escort - Kate"),
			["DiveBomber"] = luaFindHidden("Escort - Val"),
		},
		[PARTY_ALLIED] = {
			["Fighter"] = luaFindHidden("Escort - Wildcat"),
			["TorpedoBomber"] = luaFindHidden("Escort - Avenger"),
			["DiveBomber"] = luaFindHidden("Escort - Dauntless"),
		},
	}

	Mission.USSpawnPoints1 = {}
		table.insert(Mission.USSpawnPoints1, FindEntity("Escort - CB7 SpawnPoint 01"))		--cb7
		table.insert(Mission.USSpawnPoints1, FindEntity("Escort - CB7 SpawnPoint 02"))		--cb7
		table.insert(Mission.USSpawnPoints1, FindEntity("Escort - CB7 SpawnPoint 03"))		--cb7
		table.insert(Mission.USSpawnPoints1, FindEntity("Escort - CB7 SpawnPoint 04"))		--cb7
	Mission.USSpawnPoints2 = {}
		table.insert(Mission.USSpawnPoints2, FindEntity("Escort - CB4 SpawnPoint 01"))		--cb4
		table.insert(Mission.USSpawnPoints2, FindEntity("Escort - CB4 SpawnPoint 02"))		--cb4
		table.insert(Mission.USSpawnPoints2, FindEntity("Escort - CB4 SpawnPoint 03"))		--cb4
		table.insert(Mission.USSpawnPoints2, FindEntity("Escort - CB4 SpawnPoint 04"))		--cb4
	Mission.USSpawnPoints3 = {}
		table.insert(Mission.USSpawnPoints3, FindEntity("Escort - CB3 SpawnPoint 01"))		--cb3
		table.insert(Mission.USSpawnPoints3, FindEntity("Escort - CB3 SpawnPoint 02"))		--cb3
		table.insert(Mission.USSpawnPoints3, FindEntity("Escort - CB3 SpawnPoint 03"))		--cb3
		table.insert(Mission.USSpawnPoints3, FindEntity("Escort - CB3 SpawnPoint 04"))		--cb3

	Mission.JPSpawnPoints1 = {}
		table.insert(Mission.JPSpawnPoints1, FindEntity("Escort - IJN_BB 01 SpawnPoint 01"))
		table.insert(Mission.JPSpawnPoints1, FindEntity("Escort - IJN_BB 01 SpawnPoint 02"))
		table.insert(Mission.JPSpawnPoints1, FindEntity("Escort - IJN_BB 01 SpawnPoint 03"))
		table.insert(Mission.JPSpawnPoints1, FindEntity("Escort - IJN_BB 01 SpawnPoint 04"))

	Mission.JPSpawnPoints2 = {}
		table.insert(Mission.JPSpawnPoints2, FindEntity("Escort - IJN_BB 02 SpawnPoint 01"))
		table.insert(Mission.JPSpawnPoints2, FindEntity("Escort - IJN_BB 02 SpawnPoint 02"))
		table.insert(Mission.JPSpawnPoints2, FindEntity("Escort - IJN_BB 02 SpawnPoint 03"))
		table.insert(Mission.JPSpawnPoints2, FindEntity("Escort - IJN_BB 02 SpawnPoint 04"))


	--Spawnpoints activation
	--US
	for i = 1, table.getn(Mission.USSpawnPoints1) do
		for j = 0,3 do
			if (i-1) == j then
				ActivateSpawnpoint(Mission.USSpawnPoints1[i], j)
			else
				DeactivateSpawnpoint(Mission.USSpawnPoints1[i], j)
			end
		end
	end

	for idx,point in pairs(luaSumTablesIndex(Mission.USSpawnPoints2,Mission.USSpawnPoints3)) do
		for j = 0, 3 do
			DeactivateSpawnpoint(point, j)
		end
	end

	--japanese
	for i = 1, table.getn(Mission.JPSpawnPoints1) do
		for j = 4,7 do
			if (i+3) == j then
				ActivateSpawnpoint(Mission.JPSpawnPoints1[i], j)
			else
				DeactivateSpawnpoint(Mission.JPSpawnPoints1[i], j)
			end
		end
	end

	for idx,point in pairs(Mission.JPSpawnPoints2) do
		for j = 4,7 do
			DeactivateSpawnpoint(point, j)
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
				["Text"] = "mp14.obj_es_us_pri_1",
				["TextCompleted"] = "",
				["TextFailed"] = "",
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
				["Text"] = "mp14.obj_es_jp_pri_1",
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
		["secondary"] =
		{
			--[[
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
			]]
		},
		["hidden"] = {},
	}
-- Mission params
	-- toltes gyorsitas


-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(LobbySettings)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")

	----------------

	Mission.MissionEnd = false
	Mission.MissionTime = 0

	--Events

	-- korulmenyek beallitasa
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort14_think")

	AISetSpawnSceneUnitsWeightMul(0)

	Scoring_RealPlayTimeRunning(true)

	SetSimplifiedReconMultiplier(3)

	Mission.DebugMode = false
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort14_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end

	if not Mission.FirstRun then

		luaE14InitPhase()
		Mission.FirstRun = true

	end

	luaE14CheckObj()
	luaE14CheckStageSpawn(Mission.JPCV)
	luaE14CheckStageSpawn(Mission.USCV)
	luaE14CheckBases()
	luaE14CheckUSBBs()

end

function luaE14InitPhase()

	--JoinFormation(Mission.JPBB2, Mission.JPBB1)
	--JoinFormation(Mission.JPCV, Mission.JPBB1)

	--luaDelay(luaE14StartFleet,1.5)

	if not Mission.JPBB1.Dead then
		Mission.JPBB1HP = luaRound((GetHpPercentage(Mission.JPBB1) * 100 ))
	else
		Mission.JPBB1HP = 0
	end

	if not Mission.JPBB2.Dead then
		Mission.JPBB2HP = luaRound((GetHpPercentage(Mission.JPBB2) * 100 ))
	else
		Mission.JPBB2HP = 0
	end


	if not Mission.Base1Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base1[1]) * 100 ))
	elseif not Mission.Base2Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base2[1]) * 100 ))
	elseif not Mission.Base3Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base3[1]) * 100 ))
	else
		Mission.CurrentBaseHP = 0
	end

	MultiScore=	{
			[0]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[1]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[2]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[3]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[4]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[5]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[6]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[7]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
		}


	DisplayScores(1, 0, "mp14.score_battleship1_hp|".." #MultiScore.0.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.0.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.0.6# %", 1,2)
	DisplayScores(1, 1, "mp14.score_battleship1_hp|".." #MultiScore.1.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.1.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.1.6# %", 1,2)
	DisplayScores(1, 2, "mp14.score_battleship1_hp|".." #MultiScore.2.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.2.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.2.6# %", 1,2)
	DisplayScores(1, 3, "mp14.score_battleship1_hp|".." #MultiScore.3.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.3.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.3.6# %", 1,2)
	DisplayScores(1, 4, "mp14.score_battleship1_hp|".." #MultiScore.4.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.4.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.4.6# %", 1,2)
	DisplayScores(1, 5, "mp14.score_battleship1_hp|".." #MultiScore.5.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.5.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.5.6# %", 1,2)
	DisplayScores(1, 6, "mp14.score_battleship1_hp|".." #MultiScore.6.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.6.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.6.6# %", 1,2)
	DisplayScores(1, 7, "mp14.score_battleship1_hp|".." #MultiScore.7.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.7.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.7.6# %", 1,2)

	luaE14StartFleet()


	luaObj_Add("primary",1,luaSumTablesIndex(Mission.Base1, Mission.Base2, Mission.Base3, {Mission.JPBB1, Mission.JPBB2}))
	luaObj_Add("primary",2,luaSumTablesIndex({Mission.JPBB1, Mission.JPBB2}, Mission.Base1, Mission.Base2, Mission.Base3))

	luaE14GetHps()

	luaE14ShowStartingHints()

	if Mission.DebugMode then

-- RELEASE_LOGOFF  		AddWatch("Mission.SiegeOnGoing")
-- RELEASE_LOGOFF  		AddWatch("Mission.Base1Destroyed")
-- RELEASE_LOGOFF  		AddWatch("Mission.Base2Destroyed")
-- RELEASE_LOGOFF  		AddWatch("Mission.Base3Destroyed")

	end

end

function luaE14GetHps()

	--luaLog("luaE14GetHps called")

	if not Mission.JPBB1.Dead then
		Mission.JPBB1HP = luaRound((GetHpPercentage(Mission.JPBB1) * 100 ))
	else
		luaE14ShipLossNarrative()
		Mission.JPBB1HP = 0
	end

	if not Mission.JPBB2.Dead then
		Mission.JPBB2HP = luaRound((GetHpPercentage(Mission.JPBB2) * 100 ))
	else
		luaE14ShipLossNarrative()
		Mission.JPBB2HP = 0
	end

	if not Mission.Base1Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base1[1]) * 100 ))
	elseif not Mission.Base2Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base2[1]) * 100 ))
	elseif not Mission.Base3Destroyed then
		Mission.CurrentBaseHP = luaRound((GetHpPercentage(Mission.Base3[1]) * 100 ))
	else
		Mission.CurrentBaseHP = 0
	end

	MultiScore=	{
			[0]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[1]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[2]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[3]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[4]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[5]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[6]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
			[7]= {
				[1] = Mission.JPBB1HP,
				[2] = Mission.JPBB2HP,
				--[3] = Mission.Base1HP,
				--[4] = Mission.Base2HP,
				--[5] = Mission.Base3HP,
				[6] = Mission.CurrentBaseHP,
			},
		}

	if not Mission.Base1Destroyed then
		DisplayScores(1, 0, "mp14.score_battleship1_hp|".." #MultiScore.0.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.0.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.0.6# %", 1,2)
		DisplayScores(1, 1, "mp14.score_battleship1_hp|".." #MultiScore.1.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.1.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.1.6# %", 1,2)
		DisplayScores(1, 2, "mp14.score_battleship1_hp|".." #MultiScore.2.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.2.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.2.6# %", 1,2)
		DisplayScores(1, 3, "mp14.score_battleship1_hp|".." #MultiScore.3.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.3.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.3.6# %", 1,2)
		DisplayScores(1, 4, "mp14.score_battleship1_hp|".." #MultiScore.4.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.4.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.4.6# %", 1,2)
		DisplayScores(1, 5, "mp14.score_battleship1_hp|".." #MultiScore.5.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.5.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.5.6# %", 1,2)
		DisplayScores(1, 6, "mp14.score_battleship1_hp|".." #MultiScore.6.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.6.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.6.6# %", 1,2)
		DisplayScores(1, 7, "mp14.score_battleship1_hp|".." #MultiScore.7.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.7.2# %", "mp14.score_firstbombardedbase_hp|".." #MultiScore.7.6# %", 1,2)
	elseif Mission.Base1Destroyed and not Mission.Base2Destroyed then
		DisplayScores(1, 0, "mp14.score_battleship1_hp|".." #MultiScore.0.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.0.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.0.6# %", 1,2)
		DisplayScores(1, 1, "mp14.score_battleship1_hp|".." #MultiScore.1.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.1.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.1.6# %", 1,2)
		DisplayScores(1, 2, "mp14.score_battleship1_hp|".." #MultiScore.2.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.2.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.2.6# %", 1,2)
		DisplayScores(1, 3, "mp14.score_battleship1_hp|".." #MultiScore.3.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.3.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.3.6# %", 1,2)
		DisplayScores(1, 4, "mp14.score_battleship1_hp|".." #MultiScore.4.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.4.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.4.6# %", 1,2)
		DisplayScores(1, 5, "mp14.score_battleship1_hp|".." #MultiScore.5.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.5.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.5.6# %", 1,2)
		DisplayScores(1, 6, "mp14.score_battleship1_hp|".." #MultiScore.6.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.6.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.6.6# %", 1,2)
		DisplayScores(1, 7, "mp14.score_battleship1_hp|".." #MultiScore.7.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.7.2# %", "mp14.score_secondbombardedbase_hp|".." #MultiScore.7.6# %", 1,2)
	elseif Mission.Base2Destroyed and not Mission.Base3Destroyed then
		DisplayScores(1, 0, "mp14.score_battleship1_hp|".." #MultiScore.0.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.0.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.0.6# %", 1,2)
		DisplayScores(1, 1, "mp14.score_battleship1_hp|".." #MultiScore.1.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.1.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.1.6# %", 1,2)
		DisplayScores(1, 2, "mp14.score_battleship1_hp|".." #MultiScore.2.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.2.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.2.6# %", 1,2)
		DisplayScores(1, 3, "mp14.score_battleship1_hp|".." #MultiScore.3.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.3.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.3.6# %", 1,2)
		DisplayScores(1, 4, "mp14.score_battleship1_hp|".." #MultiScore.4.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.4.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.4.6# %", 1,2)
		DisplayScores(1, 5, "mp14.score_battleship1_hp|".." #MultiScore.5.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.5.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.5.6# %", 1,2)
		DisplayScores(1, 6, "mp14.score_battleship1_hp|".." #MultiScore.6.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.6.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.6.6# %", 1,2)
		DisplayScores(1, 7, "mp14.score_battleship1_hp|".." #MultiScore.7.1# %".." - ".."|mp14.score_battleship2_hp|".." #MultiScore.7.2# %", "mp14.score_thirdbombardedbase_hp|".." #MultiScore.7.6# %", 1,2)
	end

	--DisplayUnitHP(Mission.Base3, "UNLOCALIZED")

	luaDelay(luaE14GetHps, 1)
end

function luaE14CheckObj()

	if Mission.JPBB1.Dead and not Mission.JPSp2Activated then
		luaE14ActivateJPSpawnPoints2()
		Mission.JPSp2Activated = true
	end

	if Mission.JPBB1.Dead and Mission.JPBB2.Dead then
		luaObj_Completed("primary",1)
		Scoring_RealPlayTimeRunning(false)
		luaDelay(luaE14USNComplete, 2)
	end

	if table.getn(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.Base1, Mission.Base2, Mission.Base3))) == 0 then
		luaObj_Completed("primary",2)
		Scoring_RealPlayTimeRunning(false)
		luaDelay(luaE14IJNComplete, 2)
	end
end

function luaE14USNComplete()

	local endEnt
	if not Mission.USBB1.Dead then
		endEnt = Mission.USBB1
	elseif not Mission.USBB2.Dead then
		endEnt = Mission.USBB2
	else

		endEnt = luaPickRnd(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.Base1, Mission.Base2, Mission.Base3)))

	end

	luaMissionCompletedNew(endEnt, "", nil, nil, nil, PARTY_ALLIED)
	Mission.MissionEnd = true
end

function luaE14IJNComplete()

	local endEnt
	if not Mission.JPBB1.Dead then
		endEnt = Mission.JPBB1
	elseif not Mission.JPBB2.Dead then
		endEnt = Mission.JPBB2
	end

	luaMissionCompletedNew(endEnt, "", nil, nil, nil, PARTY_JAPANESE)
	Mission.MissionEnd = true
end

function luaE14StartFleet()
	NavigatorMoveOnPath(Mission.JPCV, Mission.JPCVPath)
end

function luaE14CheckBases()

	if Mission.SiegeOnGoing then
		luaE14CheckSiege()
		return
	end

	Mission.JPFleet = luaRemoveDeadsFromTable(Mission.JPFleet)
	Mission.Base1 = luaRemoveDeadsFromTable(Mission.Base1)
	Mission.Base2 = luaRemoveDeadsFromTable(Mission.Base2)
	Mission.Base3 = luaRemoveDeadsFromTable(Mission.Base3)

	--[[luaLog("(luaE14CheckBases): Think Start")
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): SiegeOnGoing = "..tostring(Mission.SiegeOnGoing))
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): BB1 command = "..GetProperty(Mission.JPBB1, "unitcommand"))
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): BB2 command = "..GetProperty(Mission.JPBB2, "unitcommand"))]]--

	if not Mission.Base1Destroyed and table.getn(Mission.Base1) > 0 then

		for idx,unit in pairs(Mission.JPFleet) do
			local dist =	luaGetDistance(unit, Mission.Base1[1])
			if dist < 5000 then
				--luaLog("(luaE14CheckBases): Base1 distance < 5000"..tostring(dist))
				Mission.SiegeOnGoing = true
				luaE14CheckSiege(Mission.Base1)
				return
			end
		end

	elseif not Mission.Base1Destroyed and table.getn(Mission.Base1) == 0 then
		--luaLog("(luaE14CheckBases): a Base1 megsemmisult, a hajok elindulnak a path1-en")
		Mission.Base1Destroyed = true
		Mission.SiegeOnGoing = false
		if (not Mission.JPBB1.Dead) then
			NavigatorMoveOnPath(Mission.JPBB1, Mission.BBPath1)
		end
		if (not Mission.JPBB2.Dead) then
			NavigatorMoveOnPath(Mission.JPBB2, Mission.BBPath1)
		end
		luaE14ActivateUSSpawnPoints2()
		luaE14BaseLossNarrative()

	end

	if not Mission.Base2Destroyed and table.getn(Mission.Base2) > 0 then
		for idx,unit in pairs(Mission.JPFleet) do
			local dist =	luaGetDistance(unit, Mission.Base2[1])
			if dist < 3500 then		-- aTom fix: nagy volt az 5000-es tavolsag
				--luaLog("(luaE14CheckBases): Base2 distance < 5000"..tostring(dist))
				Mission.SiegeOnGoing = true
				luaE14CheckSiege(Mission.Base2)
				return
			end
		end


	elseif not Mission.Base2Destroyed and table.getn(Mission.Base2) == 0 then
		--luaLog("(luaE14CheckBases): a Base2 megsemmisult, a hajok elindulnak a path2-on")
		Mission.Base2Destroyed = true
		Mission.SiegeOnGoing = false
		if (not Mission.JPBB1.Dead) then
			NavigatorMoveOnPath(Mission.JPBB1, Mission.BBPath2)
		end
		if (not Mission.JPBB2.Dead) then
			NavigatorMoveOnPath(Mission.JPBB2, Mission.BBPath2)
		end
		if (not Mission.USBB1.Dead) then
			NavigatorMoveOnPath(Mission.USBB1, FindEntity("Escort - USNPath 01"))
		end
		if (not Mission.USBB2.Dead) then
			NavigatorMoveOnPath(Mission.USBB2, FindEntity("Escort - USNPath 01"))
		end
		luaE14ActivateUSSpawnPoints3()
		luaE14BaseLossNarrative()

	end

	if not Mission.Base3Destroyed and table.getn(Mission.Base3) > 0 then

		for idx,unit in pairs(Mission.JPFleet) do
			local dist =	luaGetDistance(unit, Mission.Base3[1])
			if dist < 3500 then		-- aTom fix: nagy volt az 5000-es tavolsag
				--luaLog("(luaE14CheckBases): Base2 distance < 5000"..tostring(dist))
				Mission.SiegeOnGoing = true
				luaE14CheckSiege(Mission.Base3)
				return
			end
		end

	elseif not Mission.Base3Destroyed and table.getn(Mission.Base3) == 0 then
		--luaLog("(luaE14CheckBases): a Base2 megsemmisult, a hajok elindulnak a path2-on")
		Mission.Base3Destroyed = true
		Mission.SiegeOnGoing = false

	end
	--[[luaLog("(luaE14CheckBases): SiegeOnGoing = "..tostring(Mission.SiegeOnGoing))
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): BB1 command = "..GetProperty(Mission.JPBB1, "unitcommand"))
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): BB2 command = "..GetProperty(Mission.JPBB2, "unitcommand"))
-- RELEASE_LOGOFF  	luaLog("(luaE14CheckBases): Think End")]]--
end

function luaE14CheckSiege(baseTbl)

	--luaLog("luaE14CheckSiege called")

	Mission.JPFleet = luaRemoveDeadsFromTable(Mission.JPFleet)
	Mission.BaseUnderSiege = luaRemoveDeadsFromTable(Mission.BaseUnderSiege)

	if table.getn(Mission.BaseUnderSiege) == 0 and baseTbl then

		baseTbl = luaRemoveDeadsFromTable(baseTbl)

		for idx,entity in pairs(baseTbl) do
			table.insert(Mission.BaseUnderSiege, entity)
		end
-- RELEASE_LOGOFF  		luaLog("Updating current base tbl")

	elseif table.getn(Mission.BaseUnderSiege) > 0 then

		for idx,unit in pairs(Mission.JPFleet) do
			if unit.Class.Type == "BattleShip" then
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					NavigatorAttackMove(unit, Mission.BaseUnderSiege[1])
					luaSetScriptTarget(unit, Mission.BaseUnderSiege[1])
-- RELEASE_LOGOFF  					luaLog("Fleet initiates attackmove")
				end
			end
		end

	elseif table.getn(Mission.BaseUnderSiege) == 0 and not baseTbl then

		Mission.SiegeOnGoing = false
		Mission.BaseUnderSiege = {}
-- RELEASE_LOGOFF  		luaLog("Fleet has destoyed a base")

	end


end

function luaE14ActivateUSSpawnPoints2()
	for i = 1, table.getn(Mission.USSpawnPoints2) do
		for j = 0,3 do
			if (i-1) == j then
				ActivateSpawnpoint(Mission.USSpawnPoints2[i], j)
			else
				DeactivateSpawnpoint(Mission.USSpawnPoints2[i], j)
			end
		end
	end
end

function luaE14ActivateUSSpawnPoints3()
	for i = 1, table.getn(Mission.USSpawnPoints3) do
		for j = 0,3 do
			if (i-1) == j then
				ActivateSpawnpoint(Mission.USSpawnPoints3[i], j)
			else
				DeactivateSpawnpoint(Mission.USSpawnPoints3[i], j)
			end
		end
	end
end

function luaE14ActivateJPSpawnPoints2()
	if not Mission.JPBB2.Dead then
		for i = 1, table.getn(Mission.JPSpawnPoints2) do
			for j = 4,7 do
				if (i+3) == j then
					ActivateSpawnpoint(Mission.JPSpawnPoints2[i], j)
				else
					DeactivateSpawnpoint(Mission.JPSpawnPoints2[i], j)
				end
			end
		end
	end
end



function luaE14CheckStageSpawn(CV)

	--payload nincse azt meg kell meg irni

	Mission.USCV_Planes = luaRemoveDeadsFromTable(Mission.USCV_Planes)
	Mission.JPCV_Planes = luaRemoveDeadsFromTable(Mission.JPCV_Planes)

	local planeTbl = {}
	local nmiParty

	if CV.Party == PARTY_JAPANESE then
		planeTbl = Mission.JPCV_Planes
		nmiParty = PARTY_ALLIED
	else
		planeTbl = Mission.USCV_Planes
		nmiParty = PARTY_JAPANESE
	end

	local capSpawn = true
	local tbSpawn = true
	local dbSpawn = true

	for idx,sq in pairs(planeTbl) do

		if sq.Dead then
			table.remove(planeTbl, idx)
		else
			if sq.Class.Type == "Fighter" then
				capSpawn = false
			elseif sq.Class.Type == "TorpedoBomber" then

				local ammo = GetProperty(sq, "ammoType")

				if ammo == 0 and not Mission.ReloadPayLoad then
					PilotRetreat(sq)
					table.remove(planeTbl, idx)
				else
					if luaGetScriptTarget(sq) == nil or luaGetScriptTarget(sq).Dead then
						local trg = luaPickRnd(luaRemoveDeadsFromTable(luaSumTablesIndex(recon[nmiParty].own.destroyer, recon[nmiParty].own.cruiser)))
						if trg and not trg.Dead then
							PilotSetTarget(sq, trg)
							luaSetScriptTarget(sq, trg)
						end
					end
					tbSpawn = false
				end

			elseif sq.Class.Type == "DiveBomber" then

				if ammo == 0 and not Mission.ReloadPayLoad then
					PilotRetreat(sq)
					table.remove(planeTbl, idx)
				else
					if luaGetScriptTarget(sq) == nil or luaGetScriptTarget(sq).Dead then
						local trg = luaPickRnd(luaRemoveDeadsFromTable(luaSumTablesIndex(recon[nmiParty].own.destroyer, recon[nmiParty].own.cruiser)))
						if trg and not trg.Dead then
							PilotSetTarget(sq, trg)
							luaSetScriptTarget(sq, trg)
						end
					end
					dbSpawn = false
				end

			end
		end
	end


	if not CV.Dead then
		if capSpawn then
			luaE14SpawnCap(CV)
			return
		elseif tbSpawn then
			luaE14SpawnTB(CV)
			return
		elseif dbSpawn then
			luaE14SpawnDB(CV)
			return
		end
	end

end

function luaE14SpawnCap(CV)

	local pos = GetPosition(CV)
	pos.y = 150
	local sq = GenerateObject(Mission.PlaneTemplates[CV.Party]["Fighter"].Name, pos)
	--SetSkillLevel(sq, SKILL_MPVETERAN)
	SetSkillLevel(sq, SKILL_STUN)
	PilotMoveToRange(sq, CV)

	if CV.Party == PARTY_JAPANESE then
		table.insert(Mission.JPCV_Planes, sq)
	else
		table.insert(Mission.USCV_Planes, sq)
	end

end

function luaE14SpawnTB(CV)

	local pos = GetPosition(CV)
	pos.y = 100
	local sq = GenerateObject(Mission.PlaneTemplates[CV.Party]["TorpedoBomber"].Name, pos)
	--SetSkillLevel(sq, SKILL_MPVETERAN)
	SetSkillLevel(sq, SKILL_STUN)

	if CV.Party == PARTY_JAPANESE then
		table.insert(Mission.JPCV_Planes, sq)
	else
		table.insert(Mission.USCV_Planes, sq)
	end

end

function luaE14SpawnDB(CV)

	local pos = GetPosition(CV)
	pos.y = 200
	local sq = GenerateObject(Mission.PlaneTemplates[CV.Party]["DiveBomber"].Name, pos)
	--SetSkillLevel(sq, SKILL_MPVETERAN)
	SetSkillLevel(sq, SKILL_STUN)

	if CV.Party == PARTY_JAPANESE then
		table.insert(Mission.JPCV_Planes, sq)
	else
		table.insert(Mission.USCV_Planes, sq)
	end


end

function luaE14CheckUSBBs()
	if Mission.USBB1.Dead and Mission.USBB2.Dead then
		return
	end

	Mission.JPFleet = luaRemoveDeadsFromTable(Mission.JPFleet)

	if table.getn(Mission.JPFleet) == 0 then
		return
	end

	if Mission.DistCheckNeeded then

		local dist1 = luaGetDistance(Mission.USBB1, Mission.JPFleet[1])
		local dist2 = luaGetDistance(Mission.USBB2, Mission.JPFleet[1])

		if dist1 < 5000 or dist2 < 5000 then
			Mission.DistCheckNeeded = false
		else
			return
		end

	end

	if not Mission.USBB1.Dead then
		luaE14GetUSBBTrg(Mission.USBB1)
	end

	if not Mission.USBB2.Dead then
		luaE14GetUSBBTrg(Mission.USBB2)
	end

end

function luaE14GetUSBBTrg(BB)
	if not BB.Dead then
		if luaGetScriptTarget(BB) == nil or luaGetScriptTarget(BB).Dead then

			local trg = luaPickRnd(Mission.JPFleet)
			if trg and not trg.Dead then
				NavigatorAttackMove(BB, trg, {})
			end

		end
	end
end

function luaE14BaseLossNarrative()
	MissionNarrativeParty(PARTY_JAPANESE,"mp14.nar_usbaselost")
	MissionNarrativeParty(PARTY_ALLIED,"mp14.nar_usbaselost")
end

function luaE14ShipLossNarrative()
	if not Mission.ShipWarning then
		MissionNarrativeParty(PARTY_JAPANESE,"mp14.nar_ijnbblost")
		MissionNarrativeParty(PARTY_ALLIED,"mp14.nar_ijnbblost")
		Mission.ShipWarning = true
	end
end

function luaE14ShowStartingHints()
	ShowHint("ID_Hint_Escort14")
	--ShowHint("ID_Hint_Escort14_IJN")
end