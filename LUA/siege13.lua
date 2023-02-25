--SceneFile="Missions\Multi\Scene13.scn"

function luaPrecacheUnits()
	--PrepareClass(432)	-- Japanese Troop Transport
	PrepareClass(135)	-- warhawk
	PrepareClass(25)	-- clemson
	PrepareClass(113)	-- avenger
	PrepareClass(163)	-- jill
	PrepareClass(317)	-- northampton
	PrepareClass(14)	-- akizuki
	PrepareClass(68)	-- tone
	PrepareClass(75)	-- minekaze
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS13Mission")
end

function luaInitQAS13Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege13"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 13

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.MissionPhase = 0

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	-- spawn pontok
	DeactivateSpawnpoint(FindEntity("Siege - FakeSpawnPoint 01"))
	DeactivateSpawnpoint(FindEntity("Siege - FakeSpawnPoint 02"))
	
	local index = 8
	
	while (index > 4) do
		index = index - 1
		for slot = 0, 3 do
			ActivateSpawnpoint(FindEntity("Siege - Jap SP 01"), slot+4)
			ActivateSpawnpoint(FindEntity("Siege - Jap SP 02"), slot+4)
			DeactivateSpawnpoint(FindEntity("Siege - Jap SP 01"), slot)
			DeactivateSpawnpoint(FindEntity("Siege - Jap SP 02"), slot)
		end
	end
	while (index > 0) do
		index = index - 1
		for slot = 0, 3 do
			ActivateSpawnpoint(FindEntity("Siege - US SP 01"), slot)
			ActivateSpawnpoint(FindEntity("Siege - US SP 02"), slot)
			DeactivateSpawnpoint(FindEntity("Siege - US SP 01"), slot+4)
			DeactivateSpawnpoint(FindEntity("Siege - US SP 02"), slot+4)
		end
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")
	
	-- objektumok
	Mission.USCarrier = {FindEntity("Siege - Yorktown-class 01"),
	FindEntity("Siege - Yorktown-class 02")}
	for idx, unit in pairs(Mission.USCarrier) do
		RepairEnable(unit, true)
		FailureRepairEnable(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
	end
	Mission.USCarrierPos = {}
	Mission.USScreen = {FindEntity("Siege - Brooklyn-class 01"),
	FindEntity("Siege - Brooklyn-class 02"),
--	FindEntity("Siege - Cleveland-class 03"),
--	FindEntity("Siege - Cleveland-class 04"),
	}
	
	Mission.JapCarrier = {FindEntity("Siege - Kaga-class 01")}
	RepairEnable(Mission.JapCarrier[1], true)
	FailureRepairEnable(Mission.JapCarrier[1], true)
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - Headquarter1 01"))
		table.insert(Mission.HQs, FindEntity("Siege - Headquarter 02"))
		
	Mission.AAs = {}
	local fort = FindEntity("Siege - Light AA, Japanese 01")
	local i = 1
	while fort do
		table.insert(Mission.AAs, fort)
		i = i + 1
		if i < 10 then
			fort = FindEntity("Siege - Light AA, Japanese 0"..tostring(i))
		else
			fort = FindEntity("Siege - Light AA, Japanese "..tostring(i))
		end
	end
	
	Mission.Fortresses = {}
	local fort = FindEntity("Siege - Fortress 01")
	local i = 1
	while fort do
		table.insert(Mission.Fortresses, fort)
		i = i + 1
		if i < 10 then
			fort = FindEntity("Siege - Fortress 0"..tostring(i))
		else
			fort = FindEntity("Siege - Fortress "..tostring(i))
		end
	end
	
	-- pathok, navpontok
	Mission.USNav1 = GetPosition(FindEntity("Siege - USNavpoint 01"))
	Mission.JapNav1 = GetPosition(FindEntity("Siege - JapNavpoint 01"))
	-- egyeb
	
	Mission.USShipSpawnList = {
		{
			{["Type"] = 317, ["Name"] = "Northampton", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 317, ["Name"] = "Northampton", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 25, ["Name"] = "Clemson", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
		},
		{
			{["Type"] = 317, ["Name"] = "Northampton", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 25, ["Name"] = "Clemson", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 25, ["Name"] = "Clemson", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 25, ["Name"] = "Clemson", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI},
		},
	}
	Mission.JapShipSpawnList = {
		{
			{["Type"] = 68, ["Name"] = "Tone", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 68, ["Name"] = "Tone", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 75, ["Name"] = "Minekaze", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
		},
		{
			{["Type"] = 68, ["Name"] = "Tone", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 75, ["Name"] = "Minekaze", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 75, ["Name"] = "Minekaze", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
			{["Type"] = 75, ["Name"] = "Minekaze", ["Crew"] = 1, ["Race"] = JAPAN, ["OwnerPlayer"] = PLAYER_AI},
		},
	}
----- resource dolgok -----

	if Mission.Players <= 2 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 2")
		Mission.ResourcePoolBase = 500
		Mission.ResourceUSPool = 500
		Mission.ResourceJapPool = 500
	elseif Mission.Players <= 4 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 4")
		Mission.ResourcePoolBase = 750
		Mission.ResourceUSPool = 750
		Mission.ResourceJapPool = 750
	elseif Mission.Players <= 6 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 6")
		Mission.ResourcePoolBase = 900
		Mission.ResourceUSPool = 900
		Mission.ResourceJapPool = 900
	elseif Mission.Players <= 8 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 8")
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! unhandled Mission.Players: "..Mission.Players)
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	end
	Mission.Resource = {}
	Mission.Resource.Plane			= 6
	Mission.Resource.KamikazePlane			= 2
	Mission.Resource.JapHQ						= 3
	Mission.Resource.USCarrier					= 1
	Mission.Resource.USScreen = 1
	Mission.Resource.AAGun				= 6
	Mission.Resource.Fort				= 40
	Mission.Resource.Destroyer	=  15
	Mission.Resource.JapCruiser	=  20
	Mission.Resource.USCruiser	=  30

	Mission.SpawnDelay							= 5*60
	--Mission.HP_HQ										= 10000

	Mission.USAIShips = {}
	Mission.JapAIShips = {}
	Mission.USAIPlanes = {}
	Mission.JapAIPlanes = {}
	Mission.JapSpawn = GetPosition(FindEntity("Siege - Jap SP 01"))
	Mission.JapAirSpawn = GetPosition(FindEntity("Siege - Jap SP 01"))
	Mission.JapAirSpawn.y = 600
	Mission.USSpawn = GetPosition(FindEntity("Siege - US SP 01"))
	Mission.USAirSpawn = GetPosition(FindEntity("Siege - US SP 01"))
	Mission.USAirSpawn.y = 600
	
	Mission.JapNav1 = GetPosition(FindEntity("Siege - JapNavpoint 02"))
	for idx, unit in pairs(Mission.USCarrier) do
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		unit.PreviousHPPercentage = 1
	end
	for index, unit in pairs (Mission.HQs) do
		unit.PreviousHPPercentage = 1
	end
	for index, unit in pairs (Mission.USScreen) do
		unit.PreviousHPPercentage = 1
	end
	
	Mission.JapCarrier[1].PreviousHPPercentage = 1
---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_pri_obj_1",
				["Text"] = "mp13.obj_siege_us_p1_text",
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_pri_obj_1",
				["Text"] = "mp13.obj_siege_jap_p1_text",
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec1",
				["Text"] = "mp13.obj_siege_us_s1_text",
				["TextCompleted"] = "mp13.obj_siege_us_s1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--SetRocketAirGroundTypeDifferent(false)

	--AISetSpawnSceneUnitsWeightMul(0)

	AddListener("hit", "Listener_JAPSquadNorthWasHit", 
		{
			["callback"] = "luaHit",
			["target"] = Mission.HQs,
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, --Mission.JAP_Kaitens, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	
	luaInitNewSystems()

    SetThink(this, "luaQAS13Mission_think")
end
function luaHit(...)
-- RELEASE_LOGOFF  	luaLog(arg)
end
function luaQAS13Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")
-- RELEASE_LOGOFF  	luaLog(" Mission.ResourceJapPool: "..tostring(Mission.ResourceJapPool).." | Mission.ResourceUSPool: "..tostring(Mission.ResourceUSPool))

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaQAS13CheckObjUnits()
		luaQAS13AIEvents()
		luaCheckPlayers()
	else
		luaQAS13StartMission()
		luaSetMultiScoreTable()
		luaQAS13SpawnUSShips()
		luaQAS13SpawnJapShips()
	end
end
function luaQAS13StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)
-- fortress 268
-- aa 451
-- hellcat 26
-- Fletcher 23
-- shinden 189
-- raiden 151
-- zero 150
-- kamikaze judy 103
-- kamikaze oscar 100
-- Minekaze 75
-- Cleveland 18
-- US CV 2
-- JP CB 97
-- Clemson 25
-- Warhawk 135
-- Jill 163
-- Fubuki 73
-- Northampton 19
-- Lightning 104

	AISetTargetWeight(150, 2, false, 0) -- Zero vs CV
	AISetTargetWeight(150, 104, false, 1.4) -- Zero vs Lightning
	AISetTargetWeight(104, 451, false, 7) -- Lightning vs AA
	AISetTargetWeight(26, 451, false, 0.8) -- Hellcat vs AA
	AISetTargetWeight(26, 163, false, 0.5) -- Hellcat vs Jill
	AISetTargetWeight(73, 2, false, 0.7) -- Fubuki vs CV
	AISetTargetWeight(73, 25, false, 0.7) -- Fubuki vs Clemson
	AISetTargetWeight(73, 23, false, 0.7) -- Fubuki vs Fletcher
	AISetTargetWeight(73, 316, false, 0.4) -- Fubuki vs Cleveland
	AISetTargetWeight(73, 23, false, 0.8) -- Minekaze vs Fletcher
	AISetTargetWeight(100, 23, false, 1.8) -- Oscar vs Fletcher
	AISetTargetWeight(100, 25, false, 1.8) -- Oscar vs Clemson
	AISetTargetWeight(103, 317, false, 1.7) -- Judy vs Northampton
	
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	for index, unit in pairs (Mission.HQs) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end
	for index, unit in pairs(Mission.USCarrier) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end
	luaObj_Add("secondary", 1)
	for idx, unit in pairs(Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
	end
	Mission.Started = true
end

function luaQAS13CheckObjUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking objective units...")
	--Fortresses
	local index = table.getn(Mission.AAs)
	while (index > 0) do
		local unit = Mission.AAs[index]
		if (unit.Dead) then
			luaResourcePoolReducer("AAGun")
			table.remove(Mission.AAs, index)
		end
		index = index - 1
	end
	
	local index = table.getn(Mission.Fortresses)
	while (index > 0) do
		local unit = Mission.Fortresses[index]
		if (unit.Dead) then
			luaResourcePoolReducer("Fort")
			table.remove(Mission.Fortresses, index)
			if table.getn(Mission.Fortresses) == 0 then
				luaObj_Completed("secondary", 1)
			end
		end
		index = index - 1
	end
	
	if (table.getn(Mission.USScreen) > 0) then
		local index = table.getn(Mission.USScreen)
		while (index > 0) do
			if Mission.USScreen[index].Dead then
				local difference = Mission.USScreen[index].PreviousHPPercentage
				local by = luaRound(difference * 100)
				luaResourcePoolReducer("USScreen", by)
				table.remove(Mission.USScreen, index)
			else
				local threshold = GetHpPercentage(Mission.USScreen[index]) + 0.01
				if threshold < Mission.USScreen[index].PreviousHPPercentage then
					local difference = Mission.USScreen[index].PreviousHPPercentage - GetHpPercentage(Mission.USScreen[index])
					local by = luaRound(difference * 50)
					luaResourcePoolReducer("USScreen", by)
					Mission.USScreen[index].PreviousHPPercentage = GetHpPercentage(Mission.USScreen[index])
				end
			end
			index = index - 1
		end
	end
	if (table.getn(Mission.JapCarrier) > 0) then
		local index = table.getn(Mission.JapCarrier)
		while (index > 0) do
			if Mission.JapCarrier[index].Dead then
				if table.getn(Mission.JapCarrier) > 0 then
					MissionNarrativeParty(0, "mp13.nar_siege_japcv_lost")
					MissionNarrativeParty(1, "mp13.nar_siege_japcv_lost")
				end
				luaResourcePoolReducer("JapCarrier", luaRound(Mission.JapCarrier[index].PreviousHPPercentage * 100))
				Mission.JapCarrierDeadLast = Mission.JapCarrier[index]
				table.remove(Mission.JapCarrier, index)
			else
				local threshold = GetHpPercentage(Mission.JapCarrier[index]) + 0.01
				if threshold < Mission.JapCarrier[index].PreviousHPPercentage then
					local difference = Mission.JapCarrier[index].PreviousHPPercentage - GetHpPercentage(Mission.JapCarrier[index])
					local percentage = difference * 100
					local by = luaRound(percentage)
					luaResourcePoolReducer("JapCarrier", by)
					if Mission.JapCarrier[index].Dead then
						Mission.JapCarrier[index].PreviousHPPercentage = 0
					else
						Mission.JapCarrier[index].PreviousHPPercentage = GetHpPercentage(Mission.JapCarrier[index])
					end
					if Mission.JapCarrier[index].PreviousHPPercentage == 0 then
						Mission.JapCarrierDeadLast = Mission.JapCarrier[index]
						table.remove(Mission.JapCarrier, index)
						if table.getn(Mission.JapCarrier) > 0 then
							MissionNarrativeParty(0, "mp13.nar_siege_cv_lost")
							MissionNarrativeParty(1, "mp13.nar_siege_cv_lost")
						end
					end
				end
			end
			index = index - 1
		end
	end
	
	if (table.getn(Mission.USCarrier) > 0) then
		local index = table.getn(Mission.USCarrier)
		while (index > 0) do
			if Mission.USCarrier[index].Dead then
				if table.getn(Mission.USCarrier) > 0 then
					MissionNarrativeParty(0, "mp13.nar_siege_cv_lost")
					MissionNarrativeParty(1, "mp13.nar_siege_cv_lost")
				end
				luaResourcePoolReducer("USCarrier", luaRound(Mission.USCarrier[index].PreviousHPPercentage * 100))
				Mission.USCarrierDeadLast = Mission.USCarrier[index]
				table.remove(Mission.USCarrier, index)
			else
				local threshold = GetHpPercentage(Mission.USCarrier[index]) + 0.01
				if threshold < Mission.USCarrier[index].PreviousHPPercentage then
					local difference = Mission.USCarrier[index].PreviousHPPercentage - GetHpPercentage(Mission.USCarrier[index])
					local percentage = difference * 100
					local by = luaRound(percentage)
					luaResourcePoolReducer("USCarrier", by)
					if Mission.USCarrier[index].Dead then
						Mission.USCarrier[index].PreviousHPPercentage = 0
					else
						Mission.USCarrier[index].PreviousHPPercentage = GetHpPercentage(Mission.USCarrier[index])
					end
					if Mission.USCarrier[index].PreviousHPPercentage == 0 then
						Mission.USCarrierDeadLast = Mission.USCarrier[index]
						table.remove(Mission.USCarrier, index)
						if table.getn(Mission.USCarrier) > 0 then
							MissionNarrativeParty(0, "mp13.nar_siege_cv_lost")
							MissionNarrativeParty(1, "mp13.nar_siege_cv_lost")
						end
					end
				end
			end
			index = index - 1
		end
	elseif not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  Carriers lost, calling MissionEnd")
		Mission.MissionEndCalled = true
		luaQAS13MissionEnd()
	end
	
	--HQs
	if GameTime() <= 40 then 
		OverrideHP(Mission.HQs[1], Mission.HQs[1].Class.HP)
		OverrideHP(Mission.HQs[2], Mission.HQs[2].Class.HP)
	else
		for index, unit in pairs (Mission.HQs) do
			if unit.Party == PARTY_JAPANESE then
				local threshold = GetHpPercentage(unit) + 0.01
				if threshold < unit.PreviousHPPercentage then
					local difference = unit.PreviousHPPercentage - GetHpPercentage(unit)
					local percentage = difference * 100
					local by = luaRound(percentage)
					luaResourcePoolReducer("HQ", by)
					unit.PreviousHPPercentage = GetHpPercentage(unit)
				end
			elseif not Mission.MissionEndCalled then
	-- RELEASE_LOGOFF  			luaLog("  HQ lost, calling MissionEnd")
				Mission.MissionEndCalled = true
				luaQAS13MissionEnd()
			end
		end	
	end

end
function luaQAS13SpawnUSShips()
	MissionNarrativeParty(0, "mp13.nar_siege_ships_incoming_us")
	MissionNarrativeParty(1, "mp13.nar_siege_ships_incoming_ijn")
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = luaPickRnd(Mission.USShipSpawnList),
		["area"] = {
			["refPos"] = Mission.USSpawn,
			["angleRange"] = { 1, -1 },
			["lookAt"] = GetPosition(Mission.HQs[1]),
		},
		["callback"] = "luaQAS13USSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 133,
			["enemyHorizontal"] = 133,
			["ownVertical"] = 133,
			["formationHorizontal"] = 133,
			["enemyVertical"] = 133,
			["enemyHorizontal"] = 133,
		},
	})
end
function luaQAS13SpawnJapShips()
	--MissionNarrativeParty(0, "mp13.nar_siege_ships_incoming")
	--MissionNarrativeParty(1, "mp13.nar_siege_ships_incoming")
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = luaPickRnd(Mission.JapShipSpawnList),
		["area"] = {
			["refPos"] = Mission.JapSpawn,
			["angleRange"] = { 1, -1 },
			["lookAt"] = GetPosition(luaPickRnd(Mission.USCarrier)),
		},
		["callback"] = "luaQAS13JapSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 133,
			["enemyHorizontal"] = 133,
			["ownVertical"] = 133,
			["formationHorizontal"] = 133,
			["enemyVertical"] = 133,
			["enemyHorizontal"] = 133,
		},
	})
end
function luaQAS13SpawnUSBomber()
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{["Type"] = 113, ["Name"] = "Avenger", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI, ["Equipment"] = 1},
		},
		["area"] = {
			["refPos"] = Mission.USAirSpawn,
			["angleRange"] = { 1, -1 },
			["lookAt"] = GetPosition(Mission.HQs[1]),
		},
		["callback"] = "luaQAS13USBomberSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 133,
			["enemyHorizontal"] = 133,
			["ownVertical"] = 133,
			["formationHorizontal"] = 133,
			["enemyVertical"] = 133,
			["enemyHorizontal"] = 133,
		},
	})
end
function luaQAS13SpawnJapBomber()
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{["Type"] = 163, ["Name"] = "Jill", ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI, ["Equipment"] = 1},
		},
		["area"] = {
			["refPos"] = Mission.JapAirSpawn,
			["angleRange"] = { 1, -1 },
			["lookAt"] = Mission.USSpawn,
		},
		["callback"] = "luaQAS13JapBomberSpawned",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 133,
			["enemyHorizontal"] = 133,
			["ownVertical"] = 133,
			["formationHorizontal"] = 133,
			["enemyVertical"] = 133,
			["enemyHorizontal"] = 133,
		},
	})
end
function luaQAS13AIEvents()
	Mission.USAIShips = luaRemoveDeadsFromTable(Mission.USAIShips)
	for idx, unit in pairs(Mission.USAIShips) do
		if unit.Status == nil then
			NavigatorMoveToPos(unit, Mission.USNav1)
			if luaGetDistance(unit, Mission.USNav1) < 800 then
				unit.Status = 1
			end
		elseif unit.Status == 1 then
			if GetProperty(unit, "unitcommand") ~= "attackmove" then
				local enemies = luaGetShipsAroundCoordinate(Mission.USNav1, 2000, PARTY_JAPANESE, "own")
				if enemies then
					NavigatorAttackMove(unit, luaGetNearestUnitFromTable(unit, enemies))
				else
					unit.Status = 2
				end
			end
		elseif unit.Status == 2 then
			if table.getn(Mission.Fortresses) > 0 then
				NavigatorAttackMove(unit, Mission.Fortresses[1])
			else
				if GetHpPercentage(Mission.HQs[1]) < GetHpPercentage(Mission.HQs[2]) then
					NavigatorAttackMove(unit, Mission.HQs[1])
				else
					NavigatorAttackMove(unit, Mission.HQs[2])
				end
			end
		end
	end

	Mission.JapAIShips = luaRemoveDeadsFromTable(Mission.JapAIShips)
	for idx, unit in pairs(Mission.JapAIShips) do
		if unit.Status == nil then
			NavigatorMoveToPos(unit, Mission.JapNav1)
			if luaGetDistance(unit, Mission.JapNav1) < 800 then
				unit.Status = 1
			end
		elseif unit.Status == 1 then
			if GetProperty(unit, "unitcommand") ~= "attackmove" then
				local enemies = luaGetShipsAroundCoordinate(Mission.JapNav1, 2000, PARTY_ALLIED, "own")
				if enemies then
					NavigatorAttackMove(unit, luaGetNearestUnitFromTable(unit, enemies))
				else
					unit.Status = 2
				end
			end
		elseif unit.Status == 2 then
			if GetProperty(unit, "unitcommand") ~= "attackmove" then
				if table.getn(Mission.USScreen) > 0 then
					NavigatorAttackMove(unit, luaGetNearestUnitFromTable(unit, Mission.USScreen))
				else
					NavigatorAttackMove(unit, luaPickRnd(Mission.USCarrier))
				end
			end
		end
	end
	
	
	Mission.USAIPlanes = luaRemoveDeadsFromTable(Mission.USAIPlanes)
	if table.getn(Mission.USAIPlanes) == 0 and not Mission.USSpawnPlaneQueue then
		Mission.USSpawnPlaneQueue = true
		luaDelay(luaQAS13SpawnUSBomber, 45)
	else
		for idx, unit in pairs(Mission.USAIPlanes) do
			if not unit.Dead and GetProperty(unit, "unitcommand") ~= "torpedo" then
				local loaded = false
				for i, payload in pairs(GetPayloads(unit)) do
					if payload then
						loaded = true
						break
					end
				end
				if loaded then
					target = luaGetNearestUnitFromTable(unit, luaGetOwnUnits("ship", PARTY_JAPANESE))
					if target then
						PilotSetTarget(unit, target)
					end
				end
			end
		end
	end
	
	Mission.JapAIPlanes = luaRemoveDeadsFromTable(Mission.JapAIPlanes)
	if table.getn(Mission.JapAIPlanes) == 0 and not Mission.JapSpawnPlaneQueue then
		Mission.JapSpawnPlaneQueue = true
		luaDelay(luaQAS13SpawnJapBomber, 45)
	else
		for idx, unit in pairs(Mission.JapAIPlanes) do
			if not unit.Dead and GetProperty(unit, "unitcommand") ~= "torpedo" then
				local loaded = false
				for i, payload in pairs(GetPayloads(unit)) do
					if payload then
						loaded = true
						break
					end
				end
				if loaded then
					target = luaGetNearestUnitFromTable(unit, luaGetOwnUnits("ship", PARTY_ALLIED))
					if target then
						PilotSetTarget(unit, target)
					end
				end
			end
		end
	end
end
function luaQAS13USSpawned(...)
	DisbandFormation(arg[1])
	for idx = 1, table.getn(arg) do
		table.insert(Mission.USAIShips, arg[idx])
		if table.getn(Mission.Fortresses) > 0 then
			NavigatorAttackMove(arg[1], Mission.Fortresses[1])
		else
			if GetHpPercentage(Mission.HQs[1]) < GetHpPercentage(Mission.HQs[2]) then
				NavigatorAttackMove(unit, Mission.HQs[1])
			else
				NavigatorAttackMove(unit, Mission.HQs[2])
			end
		end
	end
	luaDelay(luaQAS13SpawnUSShips, Mission.SpawnDelay)
end
function luaQAS13JapSpawned(...)
	for idx = 1, table.getn(arg) do
		table.insert(Mission.JapAIShips, arg[idx])
		--UnitFreeAttack(arg[idx])
	end
	luaDelay(luaQAS13SpawnJapShips, Mission.SpawnDelay)
end
function luaQAS13USBomberSpawned(unit)
	UnitFreeAttack(unit)
	local target = luaGetNearestUnitFromTable(unit, luaGetOwnUnits("ship", PARTY_JAPANESE))
	if target then
		PilotSetTarget(unit, target)
	end
	SetSkillLevel(unit, SKILL_SPNORMAL)
	--SquadronSetAttackAlt(unit, 600)
	SquadronSetTravelAlt(unit, 600)
	table.insert(Mission.USAIPlanes, unit)
	Mission.USSpawnPlaneQueue = false
end
function luaQAS13JapBomberSpawned(unit)
	UnitFreeAttack(unit)
	local target = luaGetNearestUnitFromTable(unit, luaGetOwnUnits("ship", PARTY_ALLIED))
	if target then
		PilotSetTarget(unit, target)
	end
	SetSkillLevel(unit, SKILL_SPNORMAL)
	--SquadronSetAttackAlt(unit, 600)
	--SquadronSetTravelAlt(unit, 600)
	table.insert(Mission.JapAIPlanes, unit)
	Mission.JapSpawnPlaneQueue = false
end
function luaQAS13MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Scoring_RealPlayTimeRunning(false)
	MissionNarrativeClear()
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.USCarrier = luaRemoveDeadsFromTable(Mission.USCarrier)
		if table.getn(Mission.USCarrier) > 0 then
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
		else
			local units = luaGetOwnUnits("ship", PARTY_JAPANESE)
			if table.getn(units) > 0 then
				luaMissionCompletedNew(luaPickRnd(units), "", nil, nil, nil, PARTY_JAPANESE)
			else
				luaMissionCompletedNew(luaPickRnd(luaGetOwnUnits(nil, PARTY_JAPANESE)), "", nil, nil, nil, PARTY_JAPANESE)
			end
		end
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins1")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		--[[Mission.Transports = {FindEntity("Siege - USTroopTransport 01"), FindEntity("Siege - USTroopTransport 02")}
		for idx, unit in pairs(Mission.Transports) do
			NavigatorMoveToRange(unit, Mission.HQs[1])
		end
		]]
		luaMissionCompletedNew(luaPickRnd(Mission.USCarrier), "", nil, nil, nil, PARTY_ALLIED)
	elseif (Mission.HQs[1].Party ~= PARTY_JAPANESE) or (Mission.HQs[2].Party ~= PARTY_JAPANESE) then
-- RELEASE_LOGOFF  		luaLog("  US side wins by killing HQ")
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		local pTarget
		if (Mission.HQs[1].Party ~= PARTY_JAPANESE) then
			pTarget = Mission.HQs[1]
		else
			pTarget = Mission.HQs[2]
		end
		luaMissionCompletedNew(pTarget, "", nil, nil, nil, PARTY_ALLIED)
	elseif table.getn(Mission.USCarrier) == 0 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins by killing carrier")
		Mission.ResourceUSPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.Completed = true
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)		
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege13")
	-- mode description hint overlay
end

function luaCheckPlayers()
-- RELEASE_LOGOFF  	luaLog(" Checking players...")
	if not Mission.IDTableInitiated then
		Mission.USTable = {}
		Mission.JapTable = {}
		Mission.IDTableInitiated = true
	end

	if table.getn(Mission.USTable) ~= 0 then
		local by
		for index, unit in pairs (Mission.USTable) do
			if unit.Type == "PLANESQUADRON" then	-- plane
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead player unit found in Mission.USTable")
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("usplane", by)
					table.remove(Mission.USTable, index)
				else
					local previouscheck = luaCheckPlaneNumber(unit)
					local planesinsquad = table.getn(GetSquadronPlanes(unit))
					if planesinsquad < previouscheck then
						by = previouscheck - planesinsquad
						unit.checkednumber = planesinsquad
						luaResourcePoolReducer("usplane", by)
					elseif planesinsquad == 3 then
						unit.checkednumber = planesinsquad
					end
				end
			else
				if unit.Dead then
					if unit.Class.Type == "Cruiser" then
						luaResourcePoolReducer("uscruiser", 1)
					elseif unit.Class.Type == "Destroyer" then
						luaResourcePoolReducer("usdestroyer", 1)
					end
					table.remove(Mission.USTable, index)
				end
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		local by
		for index, unit in pairs (Mission.JapTable) do
			if unit.Type == "PLANESQUADRON" then	-- plane
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead player unit found in Mission.JapTable")
					by = luaCheckPlaneNumber(unit)
					if unit.Class.Type == "Kamikaze" then
						luaResourcePoolReducer("japkamikazeplane", by)
					else
						luaResourcePoolReducer("japplane", by)
					end
					table.remove(Mission.JapTable, index)
				else
					local previouscheck = luaCheckPlaneNumber(unit)
					local planesinsquad = table.getn(GetSquadronPlanes(unit))
					if planesinsquad < previouscheck then
						by = previouscheck - planesinsquad
						unit.checkednumber = planesinsquad
						if unit.Class.Type == "Kamikaze" then
							luaResourcePoolReducer("japkamikazeplane", by)
						else
							luaResourcePoolReducer("japplane", by)
						end
					elseif planesinsquad == 3 then
						unit.checkednumber = planesinsquad
					end
				end
			else
				if unit.Dead then
					if unit.Class.Type == "Cruiser" then
						luaResourcePoolReducer("japcruiser", 1)
					elseif unit.Class.Type == "Destroyer" then
						luaResourcePoolReducer("japdestroyer", 1)
					end
					table.remove(Mission.JapTable, index)
				end
			end
		end
	end

	local japplanes = luaGetOwnUnits("plane", PARTY_JAPANESE)
	local usplanes = luaGetOwnUnits("plane", PARTY_ALLIED)
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
				luaCheckPlaneNumber(unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
				luaCheckPlaneNumber(unit)
			end
		end
	end
	local japships = luaGetOwnUnits("ship", PARTY_JAPANESE)
	local usships = luaGetOwnUnits("ship", PARTY_ALLIED)
	if usships ~= nil then
		for idx, unit in pairs(usships) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japships ~= nil then
		for idx, unit in pairs(japships) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
end

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer called | unit: "..tostring(unit).." | by: "..tostring(by))
	if unit == "usplane" then
		local todeduct = Mission.Resource.Plane * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplane" then
		local todeduct = Mission.Resource.Plane * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "japkamikazeplane" then
		local todeduct = Mission.Resource.KamikazePlane * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "usdestroyer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.Destroyer
	elseif unit == "uscruiser" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USCruiser
	elseif unit == "japdestroyer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.Destroyer
	elseif unit == "japcruiser" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JapCruiser
	elseif unit == "HQ" then
		local todeduct = Mission.Resource.JapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "USCarrier" then
		local todeduct = Mission.Resource.USCarrier * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "JapCarrier" then
		local todeduct = Mission.Resource.USCarrier * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "USScreen" then
		local todeduct = Mission.Resource.USScreen * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "AAGun" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.AAGun
	elseif unit == "Fort" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.Fort
	end

	if Mission.ResourceUSPool > 0 and Mission.ResourceJapPool > 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" US pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.MissionEndCalled = true
		luaQAS13MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS13MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS13MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS13MissionEnd()
		end
	end
end

function luaCheckPlaneNumber(unit)
	if unit.checkednumber == nil then
		if unit.Dead then
			by = 1
		else
			by = table.getn(GetSquadronPlanes(unit))
		end
	else
		by = unit.checkednumber
	end
	return by
end

function luaSetMultiScoreTable()
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	MultiScore=	{
		[0]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[1]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[2]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[3]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[4]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[5]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[6]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[7]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
	}

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.1#", "mp01.score_siege_resource_def".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.1#", "mp01.score_siege_resource_def".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.1#", "mp01.score_siege_resource_def".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.1#", "mp01.score_siege_resource_def".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_def".."| #MultiScore.4.2#", "mp01.score_siege_resource_att".."| #MultiScore.4.1#", 1, 2)
	DisplayScores(1, 5, "mp01.score_siege_resource_def".."| #MultiScore.5.2#", "mp01.score_siege_resource_att".."| #MultiScore.5.1#", 1, 2)
	DisplayScores(1, 6, "mp01.score_siege_resource_def".."| #MultiScore.6.2#", "mp01.score_siege_resource_att".."| #MultiScore.6.1#", 1, 2)
	DisplayScores(1, 7, "mp01.score_siege_resource_def".."| #MultiScore.7.2#", "mp01.score_siege_resource_att".."| #MultiScore.7.1#", 1, 2)
end