-------------------------------------------------------------------
--SceneFile="universe\Scenes\TrainingGrounds\IJN_AirTraining.scn"--
-------------------------------------------------------------------

function luaStageInit()
  CreateScript("luaIJN_AirTraining")
end

function luaPrecacheUnits()
  PrepareClass(150) 	-- Zero
  PrepareClass(151) 	-- Raiden
  PrepareClass(152) 	-- Gekko
  PrepareClass(154) 	-- Oscar
  PrepareClass(189) 	-- Shinden
  
  PrepareClass(158) 	-- Val
  PrepareClass(159) 	-- Judy
  PrepareClass(183) 	-- Kikka
  PrepareClass(162) 	-- Kate
  PrepareClass(163) 	-- Jill
  
  PrepareClass(166) 	-- Nell
  PrepareClass(167) 	-- Betty
  PrepareClass(32) 		-- Ohka Carrier
  PrepareClass(385) 	-- Liz
  
  PrepareClass(45)  	-- Zero Kamikaze
  PrepareClass(100) 	-- Oscar Kamikaze 
  PrepareClass(46)  	-- Val Kamikaze
  PrepareClass(103) 	-- Judy Kamikaze
  
  PrepareClass(186) 	-- Tabby
  
  PrepareClass(2009)	--Essex
  PrepareClass(2)		--Yorktown
  PrepareClass(1)		--Lexington
  PrepareClass(24)		--Bogue
  PrepareClass(3)		--Hermes
	
  PrepareClass(2006)	--North Carolina
  PrepareClass(13)		--New York
  PrepareClass(15)		--Iowa
  PrepareClass(389)		--Montana
  PrepareClass(10)		--Renown	
  PrepareClass(7)		--South Dakota	
  PrepareClass(9)		--KGV
	
  PrepareClass(903)		--Brooklyn
  PrepareClass(21)		--York
  PrepareClass(17)		--Atlanta
  PrepareClass(19)		--Northampton
  PrepareClass(20)		--De Ruyter
  PrepareClass(390)		--Alaska	
  PrepareClass(18)		--Cleveland
	
  PrepareClass(900)		--Luppis
  PrepareClass(901)		--Porter
  PrepareClass(23)		--Fletcher
  PrepareClass(25)		--Clemson
  PrepareClass(11)		--Sumner	
  PrepareClass(48)		--ASW Fletcher	
	
  PrepareClass(30)		--Gato
  PrepareClass(31)		--Narwhal	
	
  PrepareClass(37)		--Cargo
  PrepareClass(35)		--Oiler
  PrepareClass(234)		--Troop Transport (light)
end

function luaIJN_AirTraining(this)

  luaLoadControlFunctionNames()

-- Mission declare
  Mission = this
  Mission.Party = PARTY_JAPANESE
  Mission.Name = "IJN Aerial Training Ground"
  Mission.ScriptFile = "scripts/missions/TrainingGrounds/IJN_AirTraining.lua"
  Mission.CustomLog = true

-- RELEASE_LOGOFF  -- Logging
  SETLOG(Mission, true)
-- RELEASE_LOGOFF    luaLog("Initiating IJN Aearial Training")
-- RELEASE_LOGOFF    luaLog("Init 0 - Mission Declare")

--  Inputs file loaded
  DoFile("scripts/datatables/inputs.lua")
  Inputs = nil

SetDeviceReloadTimeMul(3)

--SM hack
SetBPCsodaSquadMereteHack(1)

-- Music
  luaCheckMusicSetMinLevel(MUSIC_TENSION)
  
-- Target ships
  Mission.CVTarget = {}	
	table.insert(Mission.CVTarget, 2009)	--Essex
	table.insert(Mission.CVTarget, 2)		--Yorktown
	table.insert(Mission.CVTarget, 1)		--Lexington
	table.insert(Mission.CVTarget, 24)		--Bogue
	table.insert(Mission.CVTarget, 3)		--Hermes
	
  Mission.BBTarget = {}	
	table.insert(Mission.BBTarget, 2006)	--North Carolina
	table.insert(Mission.BBTarget, 13)		--New York
	table.insert(Mission.BBTarget, 15)		--Iowa
	table.insert(Mission.BBTarget, 389)		--Montana
	table.insert(Mission.BBTarget, 10)		--Renown	
	table.insert(Mission.BBTarget, 7)		--South Dakota	
	table.insert(Mission.BBTarget, 9)		--KGV
	
  Mission.CLATarget = {}	
	table.insert(Mission.CLATarget, 903)	--Brooklyn
	table.insert(Mission.CLATarget, 21)		--York
	table.insert(Mission.CLATarget, 17)		--Atlanta
	table.insert(Mission.CLATarget, 19)		--Northampton
	table.insert(Mission.CLATarget, 20)		--De Ruyter
	table.insert(Mission.CLATarget, 390)	--Alaska	
	table.insert(Mission.CLATarget, 18)		--Cleveland
	
  Mission.DDTarget = {}	
	table.insert(Mission.DDTarget, 900)		--Luppis
	table.insert(Mission.DDTarget, 901)		--Porter
	table.insert(Mission.DDTarget, 23)		--Fletcher
	table.insert(Mission.DDTarget, 25)		--Clemson
	table.insert(Mission.DDTarget, 11)		--Sumner	
	table.insert(Mission.DDTarget, 48)		--ASW Fletcher	
	
  Mission.SSTarget = {}	
	table.insert(Mission.SSTarget, 30)		--Gato
	table.insert(Mission.SSTarget, 31)		--Narwhal	
	
  Mission.AKTarget = {}	
	table.insert(Mission.AKTarget, 37)	--Cargo
	table.insert(Mission.AKTarget, 35)	--Oiler
	table.insert(Mission.AKTarget, 234)	--Troop Transport (light)

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

-- RELEASE_LOGOFF  --  luaLog(Mission.Hints)

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
        ["ID"] = "AirStrike",
        ["Text"] = "Defend the transports from the air strike!",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
        ["ScoreFailed"] = 0
      },
      [3] = {
        ["ID"] = "Parachute",
        ["Text"] = "Shot dowh the targets!",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
        ["ScoreFailed"] = 0
      },
      [4] = {
        ["ID"] = "",
        ["Text"] = "",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
        ["ScoreFailed"] = 0
      },
      [5] = {
        ["ID"] = "",
        ["Text"] = "",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
        ["ScoreFailed"] = 0
      },
    },
    ["secondary"] = {
      [1] = {
        ["ID"] = "AirStrikeNoPlaneLost",
        ["Text"] = "Repell the ar strike without loosing a single plain.",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
        ["ScoreFailed"] = 0
      },
    },
    ["hidden"] = {
      [1] = {
        ["ID"] = "",
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
        ["ID"] = "StuntEvent",
        ["Text"] = "",
        ["Active"] = false,
        ["Success"] = nil,
        ["Target"] = {},
        ["ScoreCompleted"] = 0,
        ["ScoreFailed"] = 0
      },
    },
  }

-- Entities
  Mission.HQ = FindEntity("Headquarters")
    UnitHoldFire(Mission.HQ)
  Mission.AF = FindEntity("Takamoto Approach")
    AddAirBasePlanes(Mission.AF, 150, 20) -- Zero
    AddAirBasePlanes(Mission.AF, 151, 20) -- Raiden
    AddAirBasePlanes(Mission.AF, 152, 20) -- Gekko
    AddAirBasePlanes(Mission.AF, 154, 20) -- Oscar
    AddAirBasePlanes(Mission.AF, 189, 20) -- Shinden
	
    AddAirBasePlanes(Mission.AF, 158, 20) -- Val
    AddAirBasePlanes(Mission.AF, 159, 20) -- Judy
    AddAirBasePlanes(Mission.AF, 183, 20) -- Kikka
    AddAirBasePlanes(Mission.AF, 162, 20) -- Kate
    AddAirBasePlanes(Mission.AF, 163, 20) -- Jill
	
    AddAirBasePlanes(Mission.AF, 166, 20) -- Nell
    AddAirBasePlanes(Mission.AF, 167, 20) -- Betty
    AddAirBasePlanes(Mission.AF, 32, 20) -- Ohka Carrier
    AddAirBasePlanes(Mission.AF, 385, 20) -- Liz
	
    AddAirBasePlanes(Mission.AF, 45, 20) -- Zero Kamikaze
    AddAirBasePlanes(Mission.AF, 100, 20) -- Oscar Kamikaze	
    AddAirBasePlanes(Mission.AF, 46, 20) -- Val Kamikaze
    AddAirBasePlanes(Mission.AF, 103, 20) -- Judy Kamikaze
	
    AddAirBasePlanes(Mission.AF, 186, 20) -- Tabby

  PrepareClass(150) -- Zero
  PrepareClass(151) -- Raiden
  PrepareClass(152) -- Gekko
  PrepareClass(154) -- Oscar
  PrepareClass(189) -- Shinden
  
  PrepareClass(158) -- Val
  PrepareClass(159) -- Judy
  PrepareClass(183) -- Kikka
  PrepareClass(162) -- Kate
  PrepareClass(163) -- Jill
  
  PrepareClass(166) -- Nell
  PrepareClass(167) -- Betty
  PrepareClass(32) 	-- Ohka Carrier
  PrepareClass(385) -- Liz
  
  PrepareClass(45)  -- Zero Kamikaze
  PrepareClass(46)  -- Val Kamikaze
  PrepareClass(100) -- Oscar Kamikaze
  PrepareClass(103) -- Judy Kamikaze

  Mission.SY = FindEntity("Shipyard")
  Mission.CS = FindEntity("CaptureStation")
  Mission.Bomber = FindEntity("Bomber")
    Mission.BomberPlane = GetSquadronPlane(Mission.Bomber, 0)
    Mission.BPath = FindEntity("DakotaPath")
    PilotMoveOnPath(Mission.Bomber, Mission.BPath, PATH_FM_CIRCLE)
    SetInvincible(Mission.Bomber, 0.3)
--    SetGuiName(Mission.Bomber, "Douglas L2D")
  Mission.CurrentPlayerSquad = nil
  Mission.AirTargets = {}
  Mission.TargetAK = FindEntity("Captured Cargo") -- 37
  SetGuiName(Mission.TargetAK, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetAK.Class.ID)
  Mission.TargetDD = FindEntity("Decomissioned DD") -- 75
  SetGuiName(Mission.TargetDD, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetDD.Class.ID)
  Mission.TargetCA = FindEntity("Decomissioned CA") -- 68
  SetGuiName(Mission.TargetCA, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetCA.Class.ID)
  Mission.TargetSS = FindEntity("Decomissioned SS") -- 81
  SetGuiName(Mission.TargetSS, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetSS.Class.ID)
  Mission.TargetBB = FindEntity("Decomissioned BB") -- 61
  SetGuiName(Mission.TargetBB, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetBB.Class.ID)
  Mission.TargetCV = FindEntity("Decomissioned CV") -- 51
  SetGuiName(Mission.TargetCV, "globals.practicetarget")
-- RELEASE_LOGOFF  --  luaLog(Mission.TargetCV.Class.ID)
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

--  Mission.RespawnPoint = FindEntity("ShipSpawn")
  Mission.RespawnPoints = {}
    table.insert(Mission.RespawnPoints, FindEntity("ShipSpawn01"))
    table.insert(Mission.RespawnPoints, FindEntity("ShipSpawn02"))
  Mission.RespawnPointNum = 1
  Mission.Replenish = FindEntity("Replenish")
  Mission.MoveToPoint = 0
  Mission.NavLookat = FindEntity("LookAt")
  Mission.MapCordinates = GetBorderZone()

-- Mission Variables
  Mission.ViolatedFF = 0
  Mission.maxViolateFF = 5
  Mission.PlayerNotReady = 0
  Mission.PlayerIsInUnit = true
  Mission.PlayerUnit = nil
  Mission.DeadTargetShip = 0

  Mission.exitlistener = 0
  Mission.killlistener = 0

----------------------------
----- Events Variables -----
----------------------------

-- Events table
  Mission.TimedEvents = {}
    table.insert(Mission.TimedEvents, luaStrikePlanesEvent)
    table.insert(Mission.TimedEvents, luaIslandCaptureEvent)
    table.insert(Mission.TimedEvents, luaAirStrikeEvent)

  Mission.TriggerEvents = {}
    table.insert(Mission.TriggerEvents, luaStuntsEvent)
    table.insert(Mission.TriggerEvents, luaParachutesEvent)

-- Events Variables
  Mission.Event = false
  Mission.MovieCamOnMove = false

-- Sink the Cargo
  Mission.SinktheCargo = false
  Mission.PlayerSpawnFirstTime = true
  Mission.DeadEventCargo = 0

-- Air Strike
  Mission.FighterFirstTime = true
  Mission.AirStrikeEvent = false
  Mission.AirStrikeCargos = {}
  Mission.AirStrikeDefenderPlanes = {}
  Mission.AirStrikePlanes = {}

-- Parachutes
  Mission.Parachutes = {}
  Mission.ParachuteEvent = false
  Mission.ParachutesMarkersReady = false

-- Stunts
  Mission.StuntsEvent = false
  Mission.StuntsEventFirstTime = true
  Mission.Stunts = {}
    table.insert(Mission.Stunts, FindEntity("Stunt 01"))
    table.insert(Mission.Stunts, FindEntity("Stunt 02"))
    table.insert(Mission.Stunts, FindEntity("Stunt 03"))
    table.insert(Mission.Stunts, FindEntity("Stunt 04"))
    table.insert(Mission.Stunts, FindEntity("Stunt 05"))
    table.insert(Mission.Stunts, FindEntity("Stunt 06"))
    table.insert(Mission.Stunts, FindEntity("Stunt 07"))

-- IslandCaptureEvent
  Mission.IslandCaptureFirstTime = true
  Mission.IslandCaptureEvent = false
  Mission.IslandCaptured = false
  Mission.IslandCaptureFleet = {}
  Mission.IslandCaptureEnemy = {}

-- IslandDepartureEvent
  Mission.IslandDepartureFirstTime = true
  Mission.IslandDepartureEvent = false
  Mission.IslandDepartureFleet = {}
  Mission.IslandDepartureEnemy = {}

-- StrikePlanes
  Mission.StrikePlanesFirstTime = true
  Mission.StrikePlanesEvent = false
  Mission.StrikePlanes = {}

-- RELEASE_LOGOFF    luaLog("Init 1 - Inputs / Mission Entities / Mission Variables")

-- Roles
  SetRoleAvailable(Mission.Bomber, EROLF_ALL, PLAYER_AI)
  SetRoleAvailable(Mission.AF, EROLF_ALL, PLAYER_AI)
  SetRoleAvailable(Mission.SY, EROLF_ALL, PLAYER_AI)
--  SetRoleAvailable(Mission.CS, EROLF_ALL, PLAYER_AI)

-- Default Unit(s)

-- RELEASE_LOGOFF    luaLog("Init 2 - Roles / Default Unit(s)")

-- Listeners + watches
-- RELEASE_LOGOFF    luaLog("Init 3 - Listeners / Watches")
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

-- RELEASE_LOGOFF    AddWatch("Mission.DeadTargetShip")

-- Sell Enable
--  SetForceSellableUnits(true)

-- Reload
  SetDeviceReloadEnabled(true)

-- Setting think
  SetThink(Mission, "luaIJN_AirTraining_think")
-- RELEASE_LOGOFF    luaLog("Init 4 - Think setting")

end


----------------------------------------
--               Think                --
----------------------------------------
function luaIJN_AirTraining_think(this, msg)
  -- Think init

  if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF      luaLog(this.Name.." mission is terminated!")
    return
  end

  if not Mission.Init then
    Mission.Init = true
-- RELEASE_LOGOFF      luaLog("Thinking...")
    ShowHint("ijnair_01")

    Mission.CurrentPhase = 0
    Mission.TargetPhase = 3
    if Mission.CurrentPhase == 0 then
      Mission.PhaseProgress = 0
    else
      Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
    end

    MultiScore= {
      [0]= {
        [1] = Mission.PhaseProgress,
        [2] = Mission.PhaseProgress,
      },
    }

    luaATShowScore()
    luaATBomberInit()
    luaDelay(luaATSetParachuteFlag, 10)

    luaDelay(luaATShowToggleSM,1)
	  luaDelay(luaATSMHintShow,1)
  luaCheckMusic() -- Music
  elseif Mission.Phase == 1 then

  elseif Mission.Phase == 2 then

  elseif Mission.Phase == 3 then

  elseif Mission.Phase == 4 then

  elseif Mission.Phase == 5 then
      EndScene()
  end

-- RELEASE_LOGOFF  --  luaLog("Primary 1-et kap a player!")
  if not luaObj_IsActive("primary", 1) then
    luaObj_Add("primary", 1)
  end

  if Mission.PlayerIsInUnit == false and Mission.PlayerDead == false then
    luaDelay(luaSetPlayerUnit, 3)
  end

	if Mission.CurrentPlayerSquad and Mission.CurrentPlayerSquad.Dead and (Mission.CurrentPlayerSquad.KillReason == "landed" or Mission.CurrentPlayerSquad.KillReason == "harm") and Mission.PlayerNotReady == 0 then
    luaNoPlayer(Mission.CurrentPlayerSquad)
    Mission.PlayerNotReady = 1
  end

----- Nem loheti az AI a dummy targeteket -----

-- RELEASE_LOGOFF  --  luaLog("AI Nem Loheti a Dummy Targeteket!")
--  for idx, unit in pairs(Mission.TargetS) do
--    if not unit.Dead then
--      if not IsUnitUntouchable(unit) then
--        if not unit.Dead then
--          AddUntouchableUnit(unit)
 --       end
--      end
--    end
--  end

----- Sink the Cargo -----

  if Mission.PlayerUnit ~= nil and Mission.PlayerSpawnFirstTime == true and Mission.Event == false and not Mission.PlayerUnit.Dead and Mission.SinktheCargo == false then
--    Mission.PlayerSpawnFirstTime = false
    luaSinktheCargo()
  end

  luaATDummyTrgShooting()
end

----------------------------------------
--        Functions               --
----------------------------------------

-- Stage start
function luaStageStart()

  Mission.Phase = 1
  luaDelay(luaCheckAirTargets, 10)

end


-- Player spawn -> Adding listeners for watching no player unit situations
function luaSpawnedPlayer(unit)

  local playerunit = FindEntity(unit)

  if type(playerunit) == "table" then
    if playerunit.Party == PARTY_ALLIED then
      return
    elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
      return
    elseif playerunit.Type == "PLANESQUADRON" then
      if playerunit.Class.ID ~=156  then
        SetRoleAvailable(playerunit, EROLF_ALL, PLAYER_1)
        BannSupportmanager()
        luaATRestrictHQ()
        if Mission.killlistener == 1 then
          RemoveListener("kill", "PlayerDeadListener")
          Mission.killlistener = 0
        end
        if Mission.exitlistener == 1 then
          RemoveListener("exitzone", "PlayerExitListener")
          Mission.exitlistener = 0
        end
        AddListener("kill", "PlayerDeadListener", {
          ["callback"] = "luaNoPlayer",
          ["entity"] = {playerunit},
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
--        UnitSetPlayerCommandsEnabled(playerunit, PCF_RETREAT)
        Mission.CurrentPlayerSquad = playerunit
        Mission.PlayerNotReady = 0
        Mission.PlayerDead = false
        Mission.PlayerUnit = playerunit
        if Mission.SinktheCargo == true then
        	if IsListenerActive("entityKilled", "SinktheCargoPlayerDead") then
        		RemoveListener("entityKilled", "SinktheCargoPlayerDead")
        	end
          AddListener("entityKilled", "SinktheCargoPlayerDead", {
			    ["callback"] = "luaSinktheCargoEndPlayerDead",
    			["entity"] = {Mission.PlayerUnit},
    			["killReason"] = {},
    			})
    		end
      end
    end
  end

end

function luaBomberHit()

  CheatMaxRepair(Mission.Bomber)
  Mission.ViolatedFF = Mission.ViolatedFF+1

  if (Mission.maxViolateFF-Mission.ViolatedFF) > 0 then
--    MissionNarrative("You've hit our own unit!  Remaining friendly fire: "..Mission.maxViolateFF-Mission.ViolatedFF)
  elseif (Mission.maxViolateFF-Mission.ViolatedFF) == 0 then
--    MissionNarrative("STOP IT RIGHT NOW!")
  else
--    MissionNarrative("FAILED")
  end

end

function luaATRestrictHQ()
  SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_AI)
  UnitHoldFire(Mission.HQ)
  Mission.PlayerIsInUnit = false
end


function luaSetPlayerUnit()

  if Mission.PlayerIsInUnit == true then
    return
  end

  if Mission.PlayerDead == true then
    return
  end

-- RELEASE_LOGOFF  	luaLog("Playert beleultetjuk a spawnolt unitba.")

  ForceSelectUnit()

	local x = GetSelectedUnit()
	if x and x.Class.Type == "CommandBuilding" then
		return
	end

  luaDelay(luaATShowToggleSM,1)
  luaDelay(luaATSMHintHide,1)

  Mission.PlayerIsInUnit = true
  --Mission.PlayerUnit = GetSelectedUnit()
  Mission.PlayerUnit = x
  Mission.PlayerEquipment = GetPlaneEquipment(Mission.PlayerUnit)
  Mission.IslandDeparturePlayerPayload = GetPayload(Mission.PlayerUnit, 1)

  luaDelay(luaOrdersEnableHack, 3)

end

function luaOrdersEnableHack()

  if Mission.Event == false then
-- RELEASE_LOGOFF      luaLog(Mission.Event)
    ForceEnableInput(IC_OVERLAY_BLUE, true)
  end

end

function luaNoPlayer(lastunit)

	--luaLog("es itt")
	--luaLog(lastunit.Class.ID)

  if lastunit.Class.ID ~=156  then
  	--luaLog("itten")
    if Mission.killlistener == 1 then
      RemoveListener("kill", "PlayerDeadListener")
      Mission.killlistener = 0
    end
    if Mission.exitlistener == 1 then
      RemoveListener("exitzone", "PlayerExitListener")
      Mission.exitlistener = 0
    end
--    SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_1)
--    HackPressInput(IC_LIMBO_CONTINUE,1)
    Mission.DeadTargetShip = 0
--[[
    SetSelectedUnit(Mission.HQ)
    ForceSelectUnit()
    PermitSupportmanager()
]]
    Mission.PlayerDead = true
    luaDelay(luaSetHQ, 3)
  end
end

function luaSetHQ()

  SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_1)
  SetSelectedUnit(Mission.HQ)
  ForceSelectUnit()
  PermitSupportmanager()
  luaDelay(luaATShowToggleSM,1)
  luaDelay(luaATSMHintShow,1)

end

function luaATBomberInit()
  PilotMoveOnPath(Mission.Bomber, Mission.BPath, PATH_FM_CIRCLE)
end

function luaTargetShipDeficit(deadtarget)
  local deadtargettype
  Mission.DeadTargetShip = Mission.DeadTargetShip + 1
-- RELEASE_LOGOFF    luaLog("Mission.DeadTargetShip")

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

-- RELEASE_LOGOFF    luaLog(deadtargetID)
-- RELEASE_LOGOFF    luaLog(deadtarget.Type)
-- RELEASE_LOGOFF    luaLog(deadtargettype)

-- RELEASE_LOGOFF    luaLog("Initiating Spawn")
-- RELEASE_LOGOFF    luaLog("Spawn.ID: "..deadtargetID)
-- RELEASE_LOGOFF    luaLog("Spawn.type: "..deadtargettype)
-- RELEASE_LOGOFF  --  luaLog("Spawn.pos: "..Mission.RespawnPoint.Name)

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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
        ["party"] = PARTY_ALLIED,
        ["groupMembers"] = {
          {
          ["Type"] = deadtargetID,
          ["Name"] = deadtargettype,
          ["Skill"] = SKILL_SPNORMAL,
          ["Race"] = USA,
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
-- RELEASE_LOGOFF      luaLog("Spawn finished.")

end

function luaShipSpawned(ship)
-- RELEASE_LOGOFF    luaLog("Spawn Callback...")
-- RELEASE_LOGOFF    luaLog("Spawned Ship: "..ship.Type)
  SetGuiName(ship, "globals.practicetarget")
  for idx, unit in pairs(Mission.TargetS) do
    if unit.Type == ship.Type then
-- RELEASE_LOGOFF        luaLog("Match found! Replacing Dead unit in Mission.TargetS.")
      Mission.TargetS[idx] = ship
    end
  end
  UnitHoldFire(ship)
  NavigatorMoveToPos(ship, Mission.MoveToPoint)
  if ship.Type == "SUBMARINE" then
    SetSubmarineDepthLevel(ship, 0)
    --ForceSubmarinePeriscope(ship, true)
    SetForcedReconLevel(ship, 2, 0)
  end
  if ship.Type == "DESTROYER" then
    Mission.TargetDD = FindEntity("Decomissioned DD")
  elseif ship.Type == "CRUISER"  then
    Mission.TargetCA = FindEntity("Decomissioned CA")
  elseif ship.Type == "SUBMARINE" then
    Mission.TargetSS =  FindEntity("Decomissioned SS")
  elseif ship.Type == "BATTLESHIP" then
    Mission.TargetBB = FindEntity("Decomissioned BB")
  elseif ship.Type == "MOTHERSHIP" then
    Mission.TargetCV = FindEntity("Decomissioned CV")
  elseif ship.Type == "CARGO" then
    Mission.TargetAK = FindEntity("Captured Cargo")
  end
  RemoveListener("kill", "TargetShipDeadListener")
  AddListener("kill", "TargetShipDeadListener", {
    ["callback"] = "luaTargetShipDeficit",
    ["entity"] = Mission.TargetS,
    ["lastAttacker"] = {},
    ["lastAttackerPlayerIndex"] = {},
    })
end



----------------------------
---------- EVENTS ----------
----------------------------



----- Sink the Cargo -----

function luaSinktheCargo()

  if not luaObj_IsActive("marker2", 1) then
    luaObj_Add("marker2", 1)
  end

  if Mission.PlayerUnit.Dead then
    return
  else
    Mission.PlayerPayload = GetPayload(Mission.PlayerUnit, 1)
-- RELEASE_LOGOFF  --  luaLog(Mission.PlayerPayload)
  end

  Mission.Event = true
  Mission.SinktheCargo = true
  Mission.SinktheCargoResetNeed = false

  if Mission.PlayerPayload ~= nil and Mission.PlayerPayload.Type == "DEPTHCHARGE" then
    if not Mission.TargetSS.Dead then
      luaObj_AddUnit("marker2", 1, Mission.TargetSS)
      luaDelay(luaShowHint01, 5)
--      ShowHint("ijnair_event01hint01")
      Mission.Target = Mission.TargetSS
    else
-- RELEASE_LOGOFF        luaLog("Nem El az AK inditasnal")
      Mission.PlayerSpawnFirstTime = false
      Mission.Event = false
      return
    end
  else
    if not Mission.TargetAK.Dead then
      luaObj_AddUnit("marker2", 1, Mission.TargetAK)
      luaDelay(luaShowHint01, 5)
--      ShowHint("ijnair_event01hint01")
      Mission.Target = Mission.TargetAK
    else
-- RELEASE_LOGOFF        luaLog("Nem El az AK inditasnal")
      Mission.PlayerSpawnFirstTime = false
      Mission.Event = false
      return
    end
  end

  if Mission.PlayerSpawnFirstTime == true then
    AddListener("entityKilled", "TargetDead", {
    ["callback"] = "luaSinktheCargoEnd",
    ["entity"] = {Mission.Target},
    ["killReason"] = {},
    })
    AddListener("entityKilled", "CameraDropNeed", {
    ["callback"] = "luaCameraDrop",
    ["entity"] = {Mission.Target},
    ["killReason"] = {},
    })
    AddListener("entityKilled", "SinktheCargoPlayerDead", {
    ["callback"] = "luaSinktheCargoEndPlayerDead",
    ["entity"] = {Mission.PlayerUnit},
    ["killReason"] = {},
    })
  end

  Mission.PlayerSpawnFirstTime = false

  luaSinktheCargoPayloadCheck()

end

function luaShowHint01()
  ShowHint("ijnair_event01hint01")
end

function luaSinktheCargoPayloadCheck()

  if Mission.PlayerUnit ~= nil then
    if not Mission.PlayerUnit.Dead then
      if table.getn(GetPayloads(Mission.PlayerUnit)) == 0 then
        PlaneReloadBombPlatforms(Mission.PlayerUnit)
      end
    end
  end

end

function luaSinktheCargoEndPlayerDead(unit)

-- RELEASE_LOGOFF  --  luaLog(Mission.PlayerUnit)
-- RELEASE_LOGOFF    luaLog("Dead unit Type in Event:".. unit.Class.ID)
  if unit.Class.ID ~= 45 and unit.Class.ID ~= 46 and unit.Class.ID ~= 100 and unit.Class.ID ~= 156 then --unit.Class.ID ~= 103 and unit.Class.ID ~= 156 then
    Mission.SinktheCargoResetNeed = true
    Mission.DeadEventCargo = Mission.DeadEventCargo
    luaSinktheCargoEnd()
  else
    RemoveListener("entityKilled", "SinktheCargoPlayerDead")
  end

end

function luaSinktheCargoEnd()

  Mission.SinktheCargo = false
  Mission.PlayerSpawnFirstTime = true
  Mission.Event = false

  if not Mission.SinktheCargoResetNeed then
  	Mission.DeadEventCargo = Mission.DeadEventCargo + 1
  end

  if IsListenerActive("entityKilled", "TargetDead") then
    RemoveListener("entityKilled", "TargetDead")
  end
  if IsListenerActive("entityKilled", "CameraDropNeed") then
    RemoveListener("entityKilled", "CameraDropNeed")
  end
  if IsListenerActive("entityKilled", "SinktheCargoPlayerDead") then
    RemoveListener("entityKilled", "SinktheCargoPlayerDead")
  end

-- RELEASE_LOGOFF  --  luaLog(Mission.PlayerUnit)

  if Mission.DeadEventCargo > 2 then
    Mission.SinktheCargo = true   -- Nem indul el tobbet az event.
    Mission.CurrentPhase = Mission.CurrentPhase + 1
    Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
    Mission.PhaseProgress = luaRound(Mission.PhaseProgress)

    luaDelay(luaATEndMovie, 1.5)

  elseif Mission.SinktheCargoResetNeed == true then
    MissionNarrative("trn.nar_tryagain")
    --Mission.PhaseProgress = 0
    --Mission.CurrentPhase = 0
    --Mission.DeadEventCargo = 0
    --RemoveStoredHint("ijnair_event01hint01")
  else
    MissionNarrative("trn.nar_enemysunk")
    Mission.CurrentPhase = Mission.CurrentPhase + 1
    Mission.PhaseProgress = Mission.CurrentPhase / Mission.TargetPhase * 100
    Mission.PhaseProgress = luaRound(Mission.PhaseProgress)
  end

-- Score Update
  MultiScore[0][1] = Mission.PhaseProgress
  MultiScore[0][2] = Mission.PhaseProgress

  if not Mission.PlayerUnit.Dead then
    PlaneReloadBombPlatforms(Mission.PlayerUnit)
  end

  if Mission.SinktheCargoResetNeed == true then
    luaObj_RemoveUnit("marker2", 1, Mission.Target)
  end

end



------------------------------------------------------------------------------------------------------
----------------------------------------      CAMERA DROP     ----------------------------------------
------------------------------------------------------------------------------------------------------

function luaCameraDrop()

-- RELEASE_LOGOFF  	luaLog("izeeee")
-- RELEASE_LOGOFF  	luaLog(Mission.DeadEventCargo)

	if Mission.DeadEventCargo == 2 then
		return
	end

  Mission.MovieCamOnMove = true
--  EnableInput(false)
--  ForceSelectUnit()
  SetInvincible(Mission.PlayerUnit, 0.1)
  Mission.MovieUnit = Mission.Target
  if Mission.MovieUnit and not Mission.MovieUnit.Dead then
--    SetInvincible(Mission.MovieUnit, 0.1)
  end
-- RELEASE_LOGOFF    luaLog(TrulyDead(Mission.MovieUnit))
  luaIngameMovie(
    {
       {["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
       {["postype"] = "cameraandtarget", ["target"] = Mission.MovieUnit, ["distance"] = 240, ["theta"] = 20, ["rho"] = 260, ["moveTime"] = 10},
    }, luaSelectUnitAfterCameraDrop, true)

end

function luaSelectUnitAfterCameraDrop()

  if not Mission.PlayerUnit.Dead then
    SetInvincible(Mission.PlayerUnit, false)
    SetSelectedUnit(Mission.PlayerUnit)
  end

  EnableInput(true)
  Mission.MovieCamOnMove = false
  luaATShowScore()

end

function luaATShowToggleSM()
	--luaLog("luaATShowToggleSM called")
	ShowHideSupportManager()
end

function luaATSMHintShow()
	--luaLog("luaATSMHintShow called")
	ShowHint("SMPERMANENTPLANE")
end

function luaATSMHintHide()
	--luaLog("luaATSMHintHide called")
	HideHint()
end

function luaATShowScore()
	DisplayScores(1, 0,"trn.score_progress","#Mission.CurrentPhase# / #Mission.TargetPhase#")
end

function luaATEndMovie()
	MissionNarrative("trn.nar_allenemysunk")
	local unit = GetSelectedUnit()
	if unit and not unit.Dead then
		SetInvincible(unit, 0.1)
		EnableInput(false)
		luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 25, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 75, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 10},
		}, luaATEndScene, true)
	else
		unit = Mission.HQ
		EnableInput(false)
		luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 75, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 150, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 10},
		}, luaATEndScene, true)
	end

end

function luaATEndScene()
	--EndScene()
	TraingingGroundEndScene()
end

---parachute
function luaATDummyTrgShooting()

	if table.getn(GetPayloads(Mission.Bomber)) == 0 then
    PlaneReloadBombPlatforms(Mission.Bomber)
    Mission.ParachuteBombRelease = false
    luaDelay(luaATSetParachuteFlag, 300)
  end

  if Mission.ParachuteBombRelease then
  	PlaneForceRelease(Mission.BomberPlane)
  end

end

function luaATSetParachuteFlag()
	Mission.ParachuteBombRelease = true
end