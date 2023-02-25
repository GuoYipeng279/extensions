-------------------------------------------------------------------
--SceneFile="universe\Scenes\TrainingGrounds\USN_SeaTraining.scn"--
-------------------------------------------------------------------

function luaStageInit()
	CreateScript("luaUSN_SeaTraining")
end

function luaPrecacheUnits()
	PrepareClass(75)	-- Minekaze
	PrepareClass(60)	--Kongo
	PrepareClass(70)	--Kuma	
	
	
	PrepareClass(27)	-- Elco
	
	PrepareClass(25)	-- Clemson
	PrepareClass(23)	-- Fletcher
	PrepareClass(901)	-- Porter
	PrepareClass(48)	-- ASW Fletcher
	PrepareClass(900)	-- Luppis
	PrepareClass(11)	-- Sumner
	
	PrepareClass(18)	-- Cleveland
	PrepareClass(903)	-- Brooklyn
	PrepareClass(20)	-- De Ruyter	
	PrepareClass(17)	-- Atlanta
	
	PrepareClass(21)	-- York
	PrepareClass(19)	-- Northampton	
	PrepareClass(390)	-- Alaska
	
	PrepareClass(12)	-- LSM (R)
	
	PrepareClass(10)	-- Renown
	PrepareClass(9)		-- KGV
	PrepareClass(13)	-- New York
	PrepareClass(7)		-- South Dakota
	PrepareClass(2006)	-- North Carolina
	PrepareClass(15)	-- Iowa
	PrepareClass(389)	-- Montana
	
	PrepareClass(31)	-- Narwhal
	PrepareClass(30)	-- Gato
	
	PrepareClass(35)	-- FleetOilerUS
	PrepareClass(36)	-- TroopTransUS
	PrepareClass(37)	-- CargoTransUS
	PrepareClass(39)	-- Hospitalship
	PrepareClass(40)	-- Higgins
	PrepareClass(41)	-- LST
	
	PrepareClass(92)	-- Junk
	PrepareClass(246)	-- Fishingboat
	PrepareClass(94)	-- Motorboat
	PrepareClass(95)	-- Yacht
	PrepareClass(96)	-- Rescue

	PrepareClass(50)		--Akagi
	PrepareClass(51)		--Kaga
	PrepareClass(53)		--Soryu
	PrepareClass(52)		--Hiryu
	PrepareClass(2010)		--Zuikaku
	PrepareClass(57)		--Zuiho
		
	PrepareClass(2007)		--Nagato
	PrepareClass(59)		--Yamato
	PrepareClass(61)		--Fuso
	PrepareClass(60)		--Kongo
	PrepareClass(2008)		--Yamato 1945	
	PrepareClass(388)		--Super Yamato
	PrepareClass(1310)		--Bismarck
	
	PrepareClass(70)		--Kuma
	PrepareClass(71)		--Agano
	PrepareClass(391)		--Kuma Torpedo
	PrepareClass(902)		--Early Mogami
	PrepareClass(68)		--Tone
	PrepareClass(69)		--Takao
	PrepareClass(67)		--Mogami	
	PrepareClass(1311)		--Hipper	
	
	PrepareClass(73)		--Fubuki
	PrepareClass(75)		--Minekaze
	PrepareClass(58)		--Shimakaze
	PrepareClass(14)		--Akizuki
		
	PrepareClass(93)		--Type B
	PrepareClass(83)		--Type A	
	PrepareClass(8)			--I-400	
	PrepareClass(81)		--Kaiten Carrier	
		
	PrepareClass(87)		--Cargo
	PrepareClass(85)		--Oiler
	PrepareClass(224)		--Troop Transport (light)
end

function luaUSN_SeaTraining(this)

	luaLoadControlFunctionNames()

-- Mission declare
  Mission = this
  Mission.Party = PARTY_ALLIED
  Mission.Name = "USN Sea Training Ground"
	Mission.ScriptFile = "scripts/missions/TrainingGrounds/USN_SeaTraining.lua"
  Mission.CustomLog = true

-- RELEASE_LOGOFF  -- Logging
  SETLOG(Mission, true)
-- RELEASE_LOGOFF    luaLog("Initiating USN Sea Training")
-- RELEASE_LOGOFF    luaLog("Init 0 - Mission Declare")

--  Inputs file loaded
	DoFile("scripts/datatables/inputs.lua")
	Inputs = nil

	SetForceSellableUnits(true)

-- Music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
-- Target ships
  Mission.CVTarget = {}	
	table.insert(Mission.CVTarget, 50)		--Akagi
	table.insert(Mission.CVTarget, 51)		--Kaga
	table.insert(Mission.CVTarget, 53)		--Soryu
	table.insert(Mission.CVTarget, 52)		--Hiryu
	table.insert(Mission.CVTarget, 2010)	--Zuikaku
	table.insert(Mission.CVTarget, 57)		--Zuiho
	
  Mission.BBTarget = {}	
	table.insert(Mission.BBTarget, 2007)	--Nagato
	table.insert(Mission.BBTarget, 59)		--Yamato
	table.insert(Mission.BBTarget, 61)		--Fuso
	table.insert(Mission.BBTarget, 60)		--Kongo
	table.insert(Mission.BBTarget, 2008)	--Yamato 1945	
	table.insert(Mission.BBTarget, 388)		--Super Yamato
	table.insert(Mission.BBTarget, 1310)	--Bismarck
	
  Mission.CLATarget = {}	
	table.insert(Mission.CLATarget, 70)		--Kuma
	table.insert(Mission.CLATarget, 71)		--Agano
	table.insert(Mission.CLATarget, 391)	--Kuma Torpedo
	table.insert(Mission.CLATarget, 902)	--Early Mogami
	table.insert(Mission.CLATarget, 68)		--Tone
	table.insert(Mission.CLATarget, 69)		--Takao	
	table.insert(Mission.CLATarget, 67)		--Mogami
	table.insert(Mission.CLATarget, 1311)	--Hipper
	
  Mission.DDTarget = {}	
	table.insert(Mission.DDTarget, 73)		--Fubuki
	table.insert(Mission.DDTarget, 75)		--Minekaze
	table.insert(Mission.DDTarget, 58)		--Shimakaze
	table.insert(Mission.DDTarget, 14)		--Akizuki

	
  Mission.SSTarget = {}	
	table.insert(Mission.SSTarget, 93)		--Type B
	table.insert(Mission.SSTarget, 83)		--Type A	
	table.insert(Mission.SSTarget, 8)		--I-400	
	table.insert(Mission.SSTarget, 81)		--Kaiten Carrier		
	
  Mission.AKTarget = {}	
	table.insert(Mission.AKTarget, 87)		--Cargo
	table.insert(Mission.AKTarget, 85)		--Oiler
	table.insert(Mission.AKTarget, 224)		--Troop Transport (light)

-- HintReset
	Mission.Hints = {}
		table.insert(Mission.Hints, "LST")
		table.insert(Mission.Hints, "TROOP_TRANSPORT")
		table.insert(Mission.Hints, "PT")
		table.insert(Mission.Hints, "DESTROYER")
		table.insert(Mission.Hints, "CRUISER")
		table.insert(Mission.Hints, "BATTLESHIP")
		table.insert(Mission.Hints, "MOTHERSHIP")
		table.insert(Mission.Hints, "KAMIKAZE")
		table.insert(Mission.Hints, "OHKA")
		table.insert(Mission.Hints, "OHKA_PAYLOAD")
		table.insert(Mission.Hints, "PARATROOPER")
		table.insert(Mission.Hints, "RECONPLANE")
		table.insert(Mission.Hints, "LEVELBOMBER")
		table.insert(Mission.Hints, "DIVEBOMBER")
		table.insert(Mission.Hints, "TORPEDOBOMBER")
		table.insert(Mission.Hints, "FIGHTER")
		table.insert(Mission.Hints, "SUBMARINE")
		table.insert(Mission.Hints, "COMMANDBUILDING")
		table.insert(Mission.Hints, "AAFLAK")
		table.insert(Mission.Hints, "LVLAA")
		table.insert(Mission.Hints, "ARTILLERY")
		table.insert(Mission.Hints, "MACHINEGUN")
		table.insert(Mission.Hints, "BOMB")
		table.insert(Mission.Hints, "ROCKET")
		table.insert(Mission.Hints, "TORPEDO_SHIP")
		table.insert(Mission.Hints, "TORPEDO_PLANE")
		table.insert(Mission.Hints, "DC_SHIP")
		table.insert(Mission.Hints, "DC_PLANE")
		table.insert(Mission.Hints, "MAP1STUSE")
		table.insert(Mission.Hints, "WATER")
		table.insert(Mission.Hints, "FIRE")
		table.insert(Mission.Hints, "ENGINE")
		table.insert(Mission.Hints, "ARMAMENT")
		table.insert(Mission.Hints, "PERISCOPE")
		table.insert(Mission.Hints, "LANDING1STGET")
		table.insert(Mission.Hints, "CAPTURE1STGET")
		table.insert(Mission.Hints, "BASICPLANE")
		table.insert(Mission.Hints, "BASICSHIP")
		table.insert(Mission.Hints, "BASICSUB")
		table.insert(Mission.Hints, "SM1STGET")
		table.insert(Mission.Hints, "SM1STUSE")
		table.insert(Mission.Hints, "PUM1STGET")
		table.insert(Mission.Hints, "PUM1STUSE")

	for idx, hint in pairs(Mission.Hints) do
		RemoveStoredHint(hint)
	end

-- Objectives
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Fun",
				["Text"] = "trn.nar_pri1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "PTRace",
				["Text"] = "Win the Race!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Parachutes",
				["Text"] = "Shot down the Parachutes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "FleetAttack",
				["Text"] = "Destroy the incoming enemy units!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "AirStrike",
				["Text"] = "Survive the air strike!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "TargetKill",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["marker2"] = {
			[1] = {
				["ID"] = "RandomEvent",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		},
	}

-- RELEASE_LOGOFF  --	luaLog(Mission.Hints)

-- Entities
	Mission.HQ = FindEntity("Headquarters")
		UnitHoldFire(Mission.HQ)
	Mission.AF = FindEntity("Nelson Field")
	Mission.SY = FindEntity("Shipyard")
		AddShipyardStock(Mission.SY, 27, 20, "Elco")
		
		AddShipyardStock(Mission.SY, 25, 20, "Clemson")
		AddShipyardStock(Mission.SY, 23, 20, "Fletcher")
		AddShipyardStock(Mission.SY, 901, 20, "Porter")
		AddShipyardStock(Mission.SY, 48, 20, "ASW Fletcher")
		AddShipyardStock(Mission.SY, 900, 20, "Luppis")
		AddShipyardStock(Mission.SY, 11, 20, "Sumner")
		
		AddShipyardStock(Mission.SY, 18, 20, "Cleveland")
		AddShipyardStock(Mission.SY, 903, 20, "Brooklyn")
		AddShipyardStock(Mission.SY, 20, 20, "De Ruyter")
		AddShipyardStock(Mission.SY, 17, 20, "Atlanta")
		
		AddShipyardStock(Mission.SY, 21, 20, "York")
		AddShipyardStock(Mission.SY, 19, 20, "Northampton")
		AddShipyardStock(Mission.SY, 390, 20, "Alaska")
		
		AddShipyardStock(Mission.SY, 12, 20, "LSM (R)")
		
		AddShipyardStock(Mission.SY, 10, 20, "Renown")		
		AddShipyardStock(Mission.SY, 9, 20, "KGV")
		AddShipyardStock(Mission.SY, 13, 20, "New York")
		AddShipyardStock(Mission.SY, 7, 20, "South Dakota")
		AddShipyardStock(Mission.SY, 2006, 20, "North Carolina")
		AddShipyardStock(Mission.SY, 15, 20, "Iowa")
		AddShipyardStock(Mission.SY, 389, 20, "Montana")
		
		AddShipyardStock(Mission.SY, 31, 20, "Narwhal")
		AddShipyardStock(Mission.SY, 30, 20, "Gato")
		
		AddShipyardStock(Mission.SY, 36, 20, "TroopTransUS")
		AddShipyardStock(Mission.SY, 40, 20, "Higgins")				
		AddShipyardStock(Mission.SY, 41, 20, "LST")				
		AddShipyardStock(Mission.SY, 35, 20, "FleetOilerUS")
		AddShipyardStock(Mission.SY, 37, 20, "CargoTransUS")
		AddShipyardStock(Mission.SY, 39, 20, "Hospitalship")

		AddShipyardStock(Mission.SY, 92, 20, "Junk")
		AddShipyardStock(Mission.SY, 246, 20, "Fishingboat")
		AddShipyardStock(Mission.SY, 94, 20, "Motorboat")
		AddShipyardStock(Mission.SY, 95, 20, "Yacht")
		AddShipyardStock(Mission.SY, 96, 20, "Rescue")

	Mission.Bomber = FindEntity("Bomber")
		Mission.BomberPlane = GetSquadronPlane(Mission.Bomber, 0)
		Mission.BPath = FindEntity("DakotaPath")
		PilotMoveOnPath(Mission.Bomber, Mission.BPath, PATH_FM_CIRCLE)
		SetInvincible(Mission.Bomber, 0.3)
--		SetGuiName(Mission.Bomber, "Douglas C-47")
	Mission.CurrentPlayerSquad = nil
	Mission.AirTargets = {}
	Mission.TargetAK = FindEntity("Captured Cargo") -- 37
	SetGuiName(Mission.TargetAK, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetAK.Class.ID)
	Mission.TargetDD = FindEntity("Decomissioned DD") -- 75
	SetGuiName(Mission.TargetDD, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetDD.Class.ID)
	Mission.TargetCA = FindEntity("Decomissioned CA") -- 68
	SetGuiName(Mission.TargetCA, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetCA.Class.ID)
	Mission.TargetSS = FindEntity("Decomissioned SS") -- 81
	SetGuiName(Mission.TargetSS, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetSS.Class.ID)
	Mission.TargetBB = FindEntity("Decomissioned BB") -- 61
	SetGuiName(Mission.TargetBB, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetBB.Class.ID)
	Mission.TargetCV = FindEntity("Decomissioned CV") -- 51
	SetGuiName(Mission.TargetCV, "globals.practicetarget")
-- RELEASE_LOGOFF  --	luaLog(Mission.TargetCV.Class.ID)
	Mission.TargetS = {}
		table.insert(Mission.TargetS, FindEntity("Captured Cargo"))
			Mission.S1Pos = GetPosition(Mission.TargetS[1])
		table.insert(Mission.TargetS, FindEntity("Decomissioned DD"))
			Mission.S2Pos = GetPosition(Mission.TargetS[2])
		table.insert(Mission.TargetS, FindEntity("Decomissioned CA"))
			Mission.S3Pos = GetPosition(Mission.TargetS[3])
		table.insert(Mission.TargetS, FindEntity("Decomissioned SS"))
			Mission.S4Pos = GetPosition(Mission.TargetS[4])
		table.insert(Mission.TargetS, FindEntity("Decomissioned BB"))
			Mission.S5Pos = GetPosition(Mission.TargetS[5])
		table.insert(Mission.TargetS, FindEntity("Decomissioned CV"))
			Mission.S6Pos = GetPosition(Mission.TargetS[6])

	Mission.RespawnPoint = FindEntity("ShipSpawn")
	Mission.RespawnPoints = {}
		table.insert(Mission.RespawnPoints, FindEntity("ShipSpawn01"))
		table.insert(Mission.RespawnPoints, FindEntity("ShipSpawn02"))
	Mission.RespawnPointNum = 1
	Mission.Replenish = FindEntity("Replenish")
	Mission.MoveToPoint = 0
	Mission.NavLookat = FindEntity("LookAt")

-- Mission Variables
	Mission.ViolatedFF = 0
	Mission.maxViolateFF = 5
	Mission.PlayerNotReady = 0
	Mission.PlayerIsInUnit = true
	Mission.DeadTargetShip = 0
	Mission.Event1Start = 0
	Mission.Event2Start = 0
	Mission.Event3Start = 0

	Mission.exitlistener = 0
	Mission.killlistener = 0

-- RELEASE_LOGOFF  	luaLog("Init 1 - Inputs / Mission Entities / Mission Variables")

----------------------------
----- Events Variables -----
----------------------------

-- General
	Mission.Event = false
	Mission.MovieCamOnMove = false

-- DD Attack
	Mission.DDAttackFirstTime = true
	Mission.DDAttackEvent = false
	Mission.EnemyDDSpawnPoints = {}
		table.insert(Mission.EnemyDDSpawnPoints, FindEntity("EnemyDDSpawnPoint01"))
		table.insert(Mission.EnemyDDSpawnPoints, FindEntity("EnemyDDSpawnPoint02"))
		table.insert(Mission.EnemyDDSpawnPoints, FindEntity("EnemyDDSpawnPoint03"))
	Mission.DDAttackNavpoint = FindEntity("DDAttackNavpoint")


-- Roles
	SetRoleAvailable(Mission.Bomber, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.SY, EROLF_ALL, PLAYER_AI)

-- Default Unit(s)
-- RELEASE_LOGOFF  	luaLog("Init 2 - Roles / Default Unit(s)")

-- Listeners + watches
-- RELEASE_LOGOFF  	luaLog("Init 3 - Listeners / Watches")
	AddListener("generate", "Spawned", {
		["callback"] = "luaSpawnedPlayer",  -- callback fuggveny
		["entityName"] = {}, -- string, a generalt template neve
		["entityType"] = {}, -- vehicleclasses.lua-bol a type parameter pl torpedoboat
		})

	AddListener("hit", "BomberHitListener", {
		["callback"] = "luaBomberHit",
		["target"] = {Mission.Bomber},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
		})

	AddListener("kill", "TargetShipDeadListener", {
		["callback"] = "luaTargetShipDeficit",
		["entity"] = Mission.TargetS,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
		})

  AddListener("entityKilled", "PlayerUnitSold", {
    ["callback"] = "luaPlayerUnitSold",
    ["entity"] = {},
    ["killReason"] = {"sell"},
  	})

--[[
	AddListener("input", "EndInput", {	--	IDeiglenes Ship Kill Hack! TODO
		["callback"] = "luaKillSelectedUnit",
		["inputID"] = {IC_CMD_JUMPIN}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
]]

-- Shipyard Manager

	Mission.Shipyards = {}
	table.insert(Mission.Shipyards, FindEntity("Shipyard"))

	luaShipyardManagerInit(Mission.Shipyards)

-- Sell Enable
	SetForceSellableUnits(true)

--AF minek???
	luaSTNoAirfield()

-- Setting think
  SetThink(Mission, "luaUSN_SeaTraining_think")
-- RELEASE_LOGOFF    luaLog("Init 4 - Think setting")

-- Orders Hack
--	ForceEnableInput(IC_OVERLAY_BLUE, false)	-- Ez meg elromolhat.
--	ForceEnableInput(IC_CHEAT_NOFIRE, false)
--	ForceEnableInput(IC_GUN_FIRE, false)

end


----------------------------------------
--  			  Think               --
----------------------------------------
function luaUSN_SeaTraining_think(this, msg)
	-- Think init

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if not Mission.Init then
		Mission.Init = true
-- RELEASE_LOGOFF  		luaLog("Thinking...")
		ShowHint("usnsea_01")

		luaSTInitBomber()

		luaDelay(luaSTShowToggleSM,1)
	  luaDelay(luaSTSMHintShow,1)

		Mission.CurrentPhase = 0
		Mission.TargetPhase = 3
		if Mission.CurrentPhase == 0 then
			Mission.PhaseProgress = 0
		else
			Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
		end


		MultiScore=	{
			[0]= {
				[1] = Mission.PhaseProgress,
				[2] = Mission.PhaseProgress,
			},
		}

		luaSTDisplayScore()

	luaCheckMusic() -- Music
	elseif Mission.Phase == 1 then
		if Mission.CurrentPlayerSquad and Mission.CurrentPlayerSquad.Dead and Mission.CurrentPlayerSquad.KillReason == "landed" and Mission.PlayerNotReady == 0 then
			luaNoPlayer(Mission.CurrentPlayerSquad)
			Mission.PlayerNotReady = 1
		end
	elseif Mission.Phase == 2 then

	elseif Mission.Phase == 3 then

	elseif Mission.Phase == 4 then

	elseif Mission.Phase == 5 then
			EndScene()
	end

	if not luaObj_IsActive("primary", 1) then
		luaObj_Add("primary", 1)
	end

	if Mission.PlayerIsInUnit == false then -- Playert ulteti bele a spawnolt unitba.
		luaDelay(luaSetPlayerUnit, 1)
	end

----- DDAttackEvent -----

	if Mission.DDAttackFirstTime == true and Mission.Event == false and Mission.PlayerUnit ~= nil and not Mission.PlayerUnit.Dead and Mission.PlayerUnit.Class.ID ~= 121 then
		luaDDAttack()
	end


	luaSTCheckTorpedoes()
end


----------------------------------------
-- 			  Functions               --
----------------------------------------

-- Player spawn -> Adding listeners for watching no player unit situations
function luaSpawnedPlayer(unit)

	local playerunit = FindEntity(unit)

-- RELEASE_LOGOFF  	luaLog(unit)
-- RELEASE_LOGOFF  	luaLog(type(playerunit))

	if  type(playerunit) == "table" then
		if playerunit.Party == PARTY_JAPANESE then
			return
		elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			return
		elseif playerunit.Class.ID ~=121 then
-- RELEASE_LOGOFF  			luaLog("Player unit spawnolt!")
			SetRoleAvailable(playerunit, EROLF_ALL, PLAYER_1)
			BannSupportmanager()
			luaBannHQ(playerunit)
			if Mission.killlistener == 1 then
				RemoveListener("entityKilled", "PlayerDeadListener")
				Mission.killlistener = 0
			end
			if Mission.exitlistener == 1 then
				RemoveListener("exitzone", "PlayerExitListener")
				Mission.exitlistener = 0
			end
			AddListener("entityKilled", "PlayerDeadListener", {
				["callback"] = "luaNoPlayer",
				["entity"] = {playerunit},
				["killReason"] = {},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
				Mission.killlistener = 1
			AddListener("exitzone", "PlayerExitListener", {
				["callback"] = "luaNoPlayer",
				["entity"] = {playerunit},
				["exited"] = {true},
				})
				Mission.exitlistener = 1
--			UnitSetPlayerCommandsEnabled(playerunit, PCF_RETREAT)
			Mission.CurrentPlayerSquad = playerunit
			Mission.PlayerNotReady = 0
		end
		SetRoleAvailable(playerunit, EROLF_ALL, PLAYER_1)
	end

end


function luaBomberHit()

	CheatMaxRepair(Mission.Bomber)
	Mission.ViolatedFF = Mission.ViolatedFF+1

	if (Mission.maxViolateFF-Mission.ViolatedFF) > 0 then
--		MissionNarrative("You've hit our own unit!  Remaining friendly fire: "..Mission.maxViolateFF-Mission.ViolatedFF)
	elseif (Mission.maxViolateFF-Mission.ViolatedFF) == 0 then
--		MissionNarrative("STOP IT RIGHT NOW!")
	else
--		MissionNarrative("FAILED")
	end

end


function luaBannHQ(playerunit)

-- RELEASE_LOGOFF  	luaLog(playerunit.Name)
-- RELEASE_LOGOFF  	luaLog(type(playerunit.Name))
	AddShipyardStock(Mission.SY, playerunit.Class.ID, 1)
	SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_AI)
	UnitHoldFire(Mission.HQ)
	Mission.PlayerIsInUnit = false

end


function luaSetPlayerUnit()

-- RELEASE_LOGOFF  	luaLog("Playert beleultetjuk a spawnolt unitba.")
	ForceSelectUnit()

	local x = GetSelectedUnit()
	if x and x.Class.Type == "CommandBuilding" then
		return
	end

	luaDelay(luaSTShowToggleSM,1)
  luaDelay(luaSTSMHintHide,1)

	Mission.PlayerIsInUnit = true
	Mission.PlayerUnit = GetSelectedUnit()
	luaDelay(luaOrdersEnableHack, 3)

	if Mission.DDAttackPhase and Mission.DDAttackPhase > 1 then
		if Mission.Attacker and not Mission.Attacker.Dead then
			NavigatorAttackMove(Mission.Attacker, Mission.PlayerUnit,  {})
		end
	end

end

function luaOrdersEnableHack()

	ForceEnableInput(IC_OVERLAY_BLUE, true)

end

function luaNoPlayer(lastunit)
	if lastunit.Class.ID ~=121  then
		if Mission.killlistener == 1 then
			RemoveListener("entityKilled", "PlayerDeadListener")
			Mission.killlistener = 0
		end
		if Mission.exitlistener == 1 then
			RemoveListener("exitzone", "PlayerExitListener")
			Mission.exitlistener = 0
		end
		SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_1)
	--	HackPressInput(IC_LIMBO_CONTINUE,1)

		luaDelay(luaSTShowToggleSM,1)
  	luaDelay(luaSTSMHintShow,1)

		SetSelectedUnit(Mission.HQ)
		ForceEnableInput(IC_OVERLAY_BLUE, false)
		ForceSelectUnit()
		Mission.DeadTargetShip = 0
		PermitSupportmanager()
	end
end

function luaSTInitBomber()
	PilotMoveOnPath(Mission.Bomber, Mission.BPath, PATH_FM_CIRCLE)
end

function luaTargetShipDeficit(deadtarget)
	RemoveListener("generate", "Spawned")	-- Listener Ideiglenes hack TODO
	local deadtargetID = deadtarget.Class.ID
	local deadtargettype


	if deadtarget.Type == "CARGO" then
		deadtargettype = "Captured Cargo"
		Mission.MoveToPoint = Mission.S1Pos
	elseif deadtarget.Type == "DESTROYER" then
		deadtargettype = "Decomissioned DD"
		Mission.MoveToPoint = Mission.S2Pos
	elseif deadtarget.Type == "CRUISER" then
		deadtargettype = "Decomissioned CL"
		Mission.MoveToPoint = Mission.S3Pos
	elseif deadtarget.Type == "SUBMARINE" then
		deadtargettype = "Decomissioned SS"
		Mission.MoveToPoint = Mission.S4Pos
	elseif deadtarget.Type == "BATTLESHIP" then
		deadtargettype = "Decomissioned BB"
		Mission.MoveToPoint = Mission.S5Pos
	elseif deadtarget.Type == "MOTHERSHIP" then
		deadtargettype = "Decomissioned CV"
		Mission.MoveToPoint = Mission.S6Pos
	end

-- RELEASE_LOGOFF  	luaLog(deadtargetID)
-- RELEASE_LOGOFF  	luaLog(deadtarget.Type)
-- RELEASE_LOGOFF  	luaLog(deadtargettype)

-- RELEASE_LOGOFF  	luaLog("Initiating Spawn")
-- RELEASE_LOGOFF  	luaLog("Spawn.ID: "..deadtargetID)
-- RELEASE_LOGOFF  	luaLog("Spawn.type: "..deadtargettype)
-- RELEASE_LOGOFF  --	luaLog("Spawn.pos: "..Mission.RespawnPoint.Name)

	if Mission.RespawnPointNum == 1 then
		Mission.RespawnPoint = Mission.RespawnPoints[1]
		Mission.RespawnPointNum = 2
	else
		Mission.RespawnPoint = Mission.RespawnPoints[2]
		Mission.RespawnPointNum = 1
	end

  if deadtarget.Type == "MOTHERSHIP" then
	local the_id = luaRnd(1, table.getn(Mission.CVTarget))
	local deadtargetID = Mission.CVTarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
          ["NumSlots"] = 1,
          ["MaxInAirPlanes"] = 12,
          ["PlaneStock 1"] = {
            ["Type"] = 134,
            ["Count"] = 20,
            ["SquadLimit"] = 5,
            },
          ["Slot 1"] = {
            ["Type"] = 134,
            ["Arm"] = 1,
            ["Count"] = 3,
            },
          },
        },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { -1, 1 },
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  elseif deadtarget.Type == "BATTLESHIP" then
	local the_id = luaRnd(1, table.getn(Mission.BBTarget))
	local deadtargetID = Mission.BBTarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
                  },
          },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { DEG(10),DEG(11)},
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  elseif deadtarget.Type == "CRUISER" then
	local the_id = luaRnd(1, table.getn(Mission.CLATarget))
	local deadtargetID = Mission.CLATarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
                  },
          },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { DEG(10),DEG(11)},
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  elseif deadtarget.Type == "DESTROYER" then
	local the_id = luaRnd(1, table.getn(Mission.DDTarget))
	local deadtargetID = Mission.DDTarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
                  },
          },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { DEG(10),DEG(11)},
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  elseif deadtarget.Type == "SUBMARINE" then
	local the_id = luaRnd(1, table.getn(Mission.SSTarget))
	local deadtargetID = Mission.SSTarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
                  },
          },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { DEG(10),DEG(11)},
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  elseif deadtarget.Type == "CARGO" then
	local the_id = luaRnd(1, table.getn(Mission.AKTarget))
	local deadtargetID = Mission.AKTarget[the_id]
    SpawnNew({
        ["party"] = PARTY_JAPANESE,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = Japan,
                  },
          },
        ["area"] = {
          ["refPos"] = GetPosition(Mission.RespawnPoint),
          ["angleRange"] = { DEG(10),DEG(11)},
          ["lookAt"] = GetPosition(Mission.NavLookat)
        },
        ["callback"] = "luaShipSpawned",
        ["excludeRadiusOverride"] = {
          ["ownHorizontal"] = 5,
          ["enemyHorizontal"] = 5,
          ["ownVertical"] = 5,
          ["enemyVertical"] = 5,
          ["formationHorizontal"] = 100,
        },
      })
  end
-- RELEASE_LOGOFF  		luaLog("Spawn finished.")

end


function luaShipSpawned(ship)
-- RELEASE_LOGOFF  	luaLog("Spawn Callback...")
-- RELEASE_LOGOFF  	luaLog("Spawned Ship: "..ship.Type)
-- RELEASE_LOGOFF  	luaLog("Spawned unit name"..ship.Name)
	SetGuiName(ship, "globals.practicetarget")
	for idx, unit in pairs(Mission.TargetS) do
		if unit.Type == ship.Type then
-- RELEASE_LOGOFF  			luaLog("Match found! Replacing Dead unit in Mission.TargetS.")
			Mission.TargetS[idx] = ship
		end
	end
--	if Mission.DeadTargetShip < 5 then
		UnitHoldFire(ship)
--	end
	NavigatorMoveToPos(ship, Mission.MoveToPoint)
	if ship.Type == "SUBMARINE" then
		SetSubmarineDepthLevel(ship, 0)
		--ForceSubmarinePeriscope(ship, true)
		SetForcedReconLevel(ship, 2, 0)
	end
	if ship.Type == "DESTROYER" then
		Mission.TargetDD = FindEntity("Decomissioned DD")
	elseif ship.Type == "CRUISER"	 then
		Mission.TargetCA = FindEntity("Decomissioned CA")
	elseif ship.Type == "SUBMARINE" then
		Mission.TargetSS =	FindEntity("Decomissioned SS")
	elseif ship.Type == "BATTLESHIP" then
		Mission.TargetBB = FindEntity("Decomissioned BB")
	elseif ship.Type == "MOTHERSHIP" then
		Mission.TargetCV = FindEntity("Decomissioned CV")
	elseif ship.Type == "CARGO" then
		Mission.TargetAK = FindEntity("Captured Cargo")
	end
	RemoveListener("kill", "TargetShipDeadListener")
-- RELEASE_LOGOFF  	luaLog("Kill listener removed!")
	AddListener("kill", "TargetShipDeadListener", {
		["callback"] = "luaTargetShipDeficit",
		["entity"] = Mission.TargetS,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
		})
-- RELEASE_LOGOFF  	luaLog("Kill listener added!")
	AddListener("generate", "Spawned", {	-- Listener Ideiglenes hack TODO
	["callback"] = "luaSpawnedPlayer",  -- callback fuggveny
	["entityName"] = {}, -- string, a generalt template neve
	["entityType"] = {}, -- vehicleclasses.lua-bol a type parameter pl torpedoboat
	})
-- RELEASE_LOGOFF  	luaLog("Generate listener added!")
end


function luaPlayerUnitSold(playerunit, killReason)
-- RELEASE_LOGOFF  	luaLog("Eladtunk.")
-- RELEASE_LOGOFF  	luaLog("Ezt a unitot adjuk el:"..playerunit.Class.ID)
	RemoveListener("entityKilled", "PlayerUnitSold")
  AddListener("entityKilled", "PlayerUnitSold", {
  ["callback"] = "luaPlayerUnitSold",
  ["entity"] = {},
  ["killReason"] = {"sell"},
	})

-- RELEASE_LOGOFF  	luaLog(IsListenerActive("entityKilled", "PlayerUnitSold"))

	if playerunit.Class.ID == 121 then
		Kill(playerunit)
		return
	else
-- RELEASE_LOGOFF  		luaLog("Recon tabla check hogy a nem kello elemeket ki killezzuk.")
		for idx, unit in pairs((recon[PARTY_ALLIED].own.reconplane)) do
-- RELEASE_LOGOFF  			luaLog("Recon tabla ezen elemenel tartunk:"..unit.Class.ID)
			if unit.Dead then
				return
			else
				if unit.Class.ID == 121 then
-- RELEASE_LOGOFF  					luaLog("Na ezt most kikillezzuk mert meghalt a parent vagy o maga.")
					Kill(unit)
				end
			end
		end
	end

end

----------------------------
---------- EVENTS ----------
----------------------------


----- DD Attack -----

function luaDDAttack()

-- RELEASE_LOGOFF  	luaLog("DDAttackEvent")

	luaDelay(luaShowHint01, 5)
--	ShowHint("usnsea_event01hint01")

	Mission.Event = true
	Mission.DDAttackFirstTime = false
	Mission.DDAttackEvent = true
	Mission.DDAttackEnemy = {}
	Mission.DDAttackEnemyNum = 0
	Mission.DDAttackPhase = 0
	Mission.DDAttackEnemySpawning = false
	Mission.DDAttackPlayerDead = false

	if not luaObj_IsActive("marker2", 1) then
		luaObj_Add("marker2", 1)
	end

	if Mission.PlayerUnit.Type == "DESTROYER" then
		Mission.DDAttackEnemyNum = 1
	elseif Mission.PlayerUnit.Type == "CRUISER" then
		Mission.DDAttackEnemyNum = 2
	elseif Mission.PlayerUnit.Type == "BATTLESHIP" then
		Mission.DDAttackEnemyNum = 3
	elseif Mission.PlayerUnit.Type == "SUBMARINE" then
		Mission.DDAttackEnemyNum = 1
	elseif Mission.PlayerUnit.Type == "TORPEDOBOAT" then
		Mission.DDAttackEnemyNum = 1
	else
		Mission.DDAttackEnemyNum = 1
	end

	AddListener("entityKilled", "DDAttackPlayerDeadListener", {
		["callback"] = "luaDDAttackEndPlayerDead",
		["entity"] = {Mission.PlayerUnit},
		["killReason"] = {},
		})

	luaDDAttackThink()

end

function luaShowHint01()

	ShowHint("usnsea_event01hint01")

end

function luaDDAttackThink()

	if Mission.DDAttackEvent == false then
		return
	end

	if Mission.DDAttackPhase == 0 then
-- RELEASE_LOGOFF  		luaLog("DDAttackEvent Thinking!")
	end

	Mission.DDAttackEnemy = luaRemoveDeadsFromTable(Mission.DDAttackEnemy)

	if luaCountTable(Mission.DDAttackEnemy) == 0 and Mission.DDAttackEnemySpawning == false and Mission.DDAttackPhase < 3 and Mission.MovieCamOnMove == false then
		Mission.DDAttackPhase = Mission.DDAttackPhase + 1
		if Mission.DDAttackPhase == 1 then
			for i=1,Mission.DDAttackEnemyNum do
				luaDDAttackSpawn()
			end
		else
			luaDDAttackSpawn()
		end
	end

	if luaCountTable(Mission.DDAttackEnemy) == 0 and Mission.DDAttackPhase == 3 and Mission.DDAttackEnemySpawning == false then
		luaDDAttackEventEnd()
	end

	luaDelay(luaDDAttackThink, 3)

end

function luaDDAttackSpawn()

	if Mission.DDAttackEvent == false then
		return
	end

-- RELEASE_LOGOFF  	luaLog("Spawning Enemy!")

	Mission.DDAttackEnemySpawning = true
	local spawnpoint = luaPickRnd(Mission.EnemyDDSpawnPoints)
--	luaRemoveByName(Mission.EnemyDDSpawnPoints, spawnpoint.Name)
	local navpoint = GetPosition(spawnpoint)
	local navpointlookat = GetPosition(Mission.PlayerUnit)
	local type
	local Name


	if Mission.DDAttackPhase == 1 then
		rand = luaRnd(1, table.getn(Mission.DDTarget))
		type = Mission.DDTarget[rand]
		Name = VehicleClass[Mission.DDTarget[1]].Name
	elseif Mission.DDAttackPhase == 2 then
		rand = luaRnd(1, table.getn(Mission.CLATarget))
		type = Mission.CLATarget[rand]
		Name = VehicleClass[Mission.CLATarget[1]].Name
	elseif Mission.DDAttackPhase == 3 then
		rand = luaRnd(1, table.getn(Mission.BBTarget))
		type = Mission.BBTarget[rand]
		Name = VehicleClass[Mission.BBTarget[1]].Name
	end

	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
				{
					["Type"] = type,
					["Name"] = Name,
					["Skill"] = SKILL_SPNORMAL,
					["Race"] = Japan,
				},
			},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 200,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		["area"] = {
			["refPos"] = navpoint,
			["angleRange"] = { DEG(-10),DEG(10)},
--			["distRange"] = { 4500, 5500 },
			["lookAt"] = navpointlookat
		},
		["callback"] = "luaDDAttackEnemySpawned",
		})


end

function luaDDAttackEnemySpawned(unit)

	if Mission.DDAttackEvent == false then
		return
	end

-- RELEASE_LOGOFF  	luaLog("Enemy Unit Spawned!")

	luaObj_AddUnit("marker2", 1, unit)
	Mission.Attacker = unit

-- RELEASE_LOGOFF  --	luaLog(unit)

	table.insert(Mission.DDAttackEnemy, unit)

	if Mission.DDAttackPhase == 1 then
		UnitHoldFire(unit)
		TorpedoEnable(unit, false)
	elseif Mission.DDAttackPhase == 2 then
		UnitFreeFire(unit)
		TorpedoEnable(unit, false)
	elseif Mission.DDAttackPhase == 3 then
		UnitFreeFire(unit)
		TorpedoEnable(unit, true)
	end

	if Mission.DDAttackPhase == 1 then
		NavigatorMoveToRange(unit, Mission.DDAttackNavpoint)
	else
		NavigatorAttackMove(unit, Mission.PlayerUnit, {})
	end

	Mission.DDAttackEnemySpawning = false

	Mission.MovieUnit = unit

	if not IsListenerActive("entityKilled", "CameraDropNeed") then
		AddListener("entityKilled", "CameraDropNeed", {
		["callback"] = "luaEnemyDDDead",
		["entity"] = Mission.DDAttackEnemy,
		["killReason"] = {},
		})
	else
		RemoveListener("entityKilled", "CameraDropNeed")
		AddListener("entityKilled", "CameraDropNeed", {
		["callback"] = "luaEnemyDDDead",
		["entity"] = Mission.DDAttackEnemy,
		["killReason"] = {},
		})
	end

	Mission.CurrentPhase = Mission.DDAttackPhase - 1	-- -1 kell mert el van tolodva a ketto egymashoz kepest.
	Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
	Mission.PhaseProgress = luaRound(Mission.PhaseProgress)

-- Score Update
	MultiScore[0][1] = Mission.PhaseProgress
	MultiScore[0][2] = Mission.PhaseProgress

end

function luaDDAttackEndPlayerDead()

	--Mission.DDAttackEvent = false
	Mission.DDAttackPlayerDead = true
	luaDDAttackEventEnd()

end

function luaDDAttackEventEnd()

	Mission.DDAttackEnemy = luaRemoveDeadsFromTable(Mission.DDAttackEnemy)

	if Mission.DDAttackPlayerDead == true then
		MissionNarrative("trn.nar_tryagain")
		--Mission.DDAttackFirstTime = true	-- Elolrol indul az event.
		--Mission.Event = false
		--Mission.PhaseProgress = 0
		--Mission.CurrentPhase = 0
		--RemoveStoredHint("usnsea_event01hint01")
	-- Score Update
		MultiScore[0][1] = Mission.PhaseProgress
		MultiScore[0][2] = Mission.PhaseProgress
	elseif Mission.DDAttackPhase == 3 and luaCountTable(Mission.DDAttackEnemy) == 0 then
		MissionNarrative("trn.nar_allenemysunk")
		Mission.Event = false
	--	Mission.DDAttackFirstTime = false
		Mission.DDAttackEvent = false
		Mission.DDAttackEnemyNum = nil
		Mission.DDAttackPhase = nil
		Mission.DDAttackEnemySpawning = nil
		Mission.DDAttackPlayerDead = nil
		ForceEnableInput(IC_OVERLAY_BLUE, true)
		Mission.CurrentPhase = 3
		Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
		Mission.PhaseProgress = luaRound(Mission.PhaseProgress)
	-- Score Update
		MultiScore[0][1] = Mission.PhaseProgress
		MultiScore[0][2] = Mission.PhaseProgress
	end

	--[[
	if Mission.DDAttackEvent == false then
		if IsListenerActive("entityKilled", "DDAttackPlayerDeadListener") then
			RemoveListener("entityKilled", "DDAttackPlayerDeadListener")
		end
		if IsListenerActive("entityKilled", "CameraDropNeed") then
			RemoveListener("entityKilled", "CameraDropNeed")
		end
		if luaCountTable(Mission.DDAttackEnemy) ~= 0 then
			for idx, unit in pairs(Mission.DDAttackEnemy) do
				SetDeadMeat(unit)
			end
		end
		Mission.DDAttackEnemy = {}
	end
	]]
end

function luaEnemyDDDead()

	if luaRemoveDeadsFromTable(Mission.DDAttackEnemy) ~= 0 then
		MissionNarrative("trn.nar_enemysunk")
	--else
		--MissionNarrative("trn.nar_allenemysunk")
	end

	if luaCountTable(Mission.DDAttackEnemy) == 1 then
		if Mission.DDAttackPhase < 3 then
			Mission.MovieUnit = Mission.DDAttackEnemy[1]
			luaCameraDrop()
		else
			luaDelay(luaSTEndMovie,1)
		end
	end

	Mission.DDAttackEnemy = luaRemoveDeadsFromTable(Mission.DDAttackEnemy)

end


------------------------------------------------------------------------------------------------------
----------------------------------------			CAMERA DROP			----------------------------------------
------------------------------------------------------------------------------------------------------

function luaCameraDrop()

	Mission.MovieCamOnMove = true
	SetInvincible(Mission.PlayerUnit, 0.1)
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
--		SetInvincible(Mission.MovieUnit, 0.1)
	end

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 240, ["theta"] = 20, ["rho"] = 260, ["moveTime"] = 6},
		}, luaSelectUnitAfterCameraDrop, true)

end

function luaSelectUnitAfterCameraDrop()

	if not Mission.PlayerUnit.Dead then
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	end

	EnableInput(true)
	Mission.MovieCamOnMove = false

	luaSTDisplayScore()

end

-----------------
function luaSTDisplayScore()
	DisplayScores(1, 0,"trn.score_progress","#Mission.CurrentPhase# / #Mission.TargetPhase#")
end

function luaSTShowToggleSM()
-- RELEASE_LOGOFF  	luaLog("luaSTShowToggleSM called")
	ShowHideSupportManager()
end

function luaSTSMHintShow()
-- RELEASE_LOGOFF  	luaLog("luaSTSMHintShow called")
	ShowHint("SMPERMANENTPLANE")
end

function luaSTSMHintHide()
-- RELEASE_LOGOFF  	luaLog("luaSTSMHintHide called")
	HideHint()
end

function luaSTEndMovie()
	MissionNarrative("trn.nar_allenemysunk")
	local unit = GetSelectedUnit()
	if unit and not unit.Dead then
		SetInvincible(unit, 0.1)
		EnableInput(false)
		luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 75, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 150, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 10},
		}, luaSTEndScene, true)
	else
		unit = Mission.HQ
		EnableInput(false)
		luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 75, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 150, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 10},
		}, luaSTEndScene, true)
	end

end

function luaSTEndScene()
	--EndScene()
	TraingingGroundEndScene()
end

function luaSTNoAirfield()
	SupportManagerEnable(Mission.AF, false)
end

--
function luaSTCheckTorpedoes()
	local unit = GetSelectedUnit()

	if unit and not unit.Dead then
		local torp = GetProperty(unit, "TorpedoStock")
		if torp and torp == 0 then
			local max = unit.Class.MaxTorpedoStock
			if max and max > 0 then
				ShipSetTorpedoStock(unit, max)
				MissionNarrative("ijn06.max_torp_reached")
			end
		end
	end
end