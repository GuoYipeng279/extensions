--SceneFile="Missions\Multi\Scene11.scn"

function luaPrecacheUnits()
	PrepareClass(224)	-- Japanese Troop Transport
	PrepareClass(90)	-- Daihatsu
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS11Mission")
end

function luaInitQAS11Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege11"..dateandtime

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
	Mission.MultiplayerNumber = 11

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
			DeactivateSpawnpoint(FindEntity("Siege - Jap SP 01"), slot)
		end
	end
	while (index > 0) do
		index = index - 1
		for slot = 0, 3 do
			ActivateSpawnpoint(FindEntity("Siege - US SP 01"), slot)
			DeactivateSpawnpoint(FindEntity("Siege - US SP 01"), slot+4)
		end
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")
	
	-- amerikai objektumok
	Mission.JapTTs = {}
	Mission.JapTTTemplates = {}
		table.insert(Mission.JapTTTemplates, luaFindHidden("Siege - Japan Troop Transport 01"))
		table.insert(Mission.JapTTTemplates, luaFindHidden("Siege - Japan Troop Transport 02"))
		table.insert(Mission.JapTTTemplates, luaFindHidden("Siege - Japan Troop Transport 03"))
	Mission.USLandingUnits = {}
	Mission.USLandingUnits[1] = {}
	Mission.USLandingUnits[2] = {}
	Mission.USLandingUnits[3] = {}
	
	Mission.JapLandingTemplate = luaFindHidden("Siege - Daihatsu template")

	Mission.JapCarrier = {FindEntity("Siege - Hiryu-class 01"),
	FindEntity("Siege - Hiryu-class 02")}
	for idx, unit in pairs(Mission.JapCarrier) do
		RepairEnable(unit, true)
	end
	Mission.JapCarrierPos = {}
	Mission.JapDestroyer = {FindEntity("Siege - Akizuki-class 01"),
	FindEntity("Siege - Akizuki-class 02"),
	FindEntity("Siege - Akizuki-class 03"),
	FindEntity("Siege - Akizuki-class 04"),
	}
	
	-- japan objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - HQ 01"))
		table.insert(Mission.HQs, FindEntity("Siege - HQ 02"))
	
	local fort
	Mission.FortArea = {{},{},{}}
	local i = 1
	fort = FindEntity("Siege - Fortress A 0"..i)
	while (fort) do
		table.insert(Mission.FortArea[1], fort)
		i = i + 1
		fort = FindEntity("Siege - Fortress A 0"..i)
	end
	
	i = 1
	fort = FindEntity("Siege - Fortress B 0"..i)
	while (fort) do
		table.insert(Mission.FortArea[2], fort)
		i = i + 1
		fort = FindEntity("Siege - Fortress B 0"..i)
	end
	
	i = 1
	fort = FindEntity("Siege - Fortress C 0"..i)
	while (fort) do
		table.insert(Mission.FortArea[3], fort)
		i = i + 1
		fort = FindEntity("Siege - Fortress C 0"..i)
	end
	
	
	Mission.HeavyAAs = {}
	local istr
	i = 1
	istr = "0"..tostring(i)
	fort = FindEntity("Siege - Heavy AA, US "..istr)
	while (fort) do
		AISetHintWeight(fort, 0)
		table.insert(Mission.HeavyAAs, fort)
		i = i + 1
		if i < 10 then
			istr = "0"..tostring(i)
		else
			istr = tostring(i)
		end
		fort = FindEntity("Siege - Heavy AA, US "..istr)
	end
	
	istr = 0
	for i = 4, 7 do
		if GetPlayerDetails()[i] and not GetPlayerDetails()[i].ai then
			istr = istr + 1
		end
	end
	if istr < 1 then
		for idx, unit in pairs(Mission.HeavyAAs) do
			SetSkillLevel(unit, SKILL_STUN)
		end
	elseif istr < 2 then
		for idx, unit in pairs(Mission.HeavyAAs) do
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	end
	-- pathok, navpontok
	Mission.JapTTPaths = {}
		table.insert(Mission.JapTTPaths, FindEntity("Siege - TTPath 1"))
		table.insert(Mission.JapTTPaths, FindEntity("Siege - TTPath 2"))
		table.insert(Mission.JapTTPaths, FindEntity("Siege - TTPath 3"))
	
	Mission.Navpoints = {
		FindEntity("Siege - Navpoint 01"),
		FindEntity("Siege - Navpoint 02"),
		FindEntity("Siege - Navpoint 03"),
	}
		
	Mission.JapLandingPoints = {}
	Mission.JapLandingPoints[1] = {}
		--table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 01")))
		--table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 02")))
		table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 03")))
		table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 04")))
		table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 05")))
		table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 06")))
		table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 07")))
		--table.insert(Mission.JapLandingPoints[1], GetPosition(FindEntity("Siege - LPB 08")))
	Mission.JapLandingPoints[2] = {}
		--table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 09")))
		--table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 10")))
		table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 11")))
		table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 12")))
		table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 13")))
		table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 14")))
		table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 15")))
		--table.insert(Mission.JapLandingPoints[2], GetPosition(FindEntity("Siege - LPB 16")))
	Mission.JapLandingPoints[3] = {}
		--table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 17")))
		--table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 18")))
		table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 19")))
		table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 20")))
		table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 21")))
		table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 22")))
		table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 23")))
		--table.insert(Mission.JapLandingPoints[3], GetPosition(FindEntity("Siege - LPB 24")))

	
	-- egyeb
	Mission.JapTTTriggerID = {}
		table.insert(Mission.JapTTTriggerID, TT1Watch)
		table.insert(Mission.JapTTTriggerID, TT2Watch)
		table.insert(Mission.JapTTTriggerID, TT3Watch)
	Mission.JapTTTriggerFunction = {}
		table.insert(Mission.JapTTTriggerFunction, "luaQAS11JapTT1InPos")
		table.insert(Mission.JapTTTriggerFunction, "luaQAS11JapTT2InPos")
		table.insert(Mission.JapTTTriggerFunction, "luaQAS11JapTT3InPos")

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
	Mission.Resource.SmallPlane			= 8
	Mission.Resource.LargePlane			= 8
	Mission.Resource.USHQ						= 3
	Mission.Resource.JapCarrier					= 2
	Mission.Resource.JapTT						= 30
	Mission.Resource.JapLandingBoat	= 1
	Mission.Resource.JapDestroyer = 0.8
	Mission.Resource.USAAGun				= 8
	Mission.Resource.USFortBig				= 70
	Mission.Resource.USFortSmall				= 50

	Mission.RespawnTime							= 30
	--Mission.HP_HQ										= 10000

	for idx, unit in pairs(Mission.JapCarrier) do
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		unit.PreviousHPPercentage = 1
	end
	for index, unit in pairs (Mission.HQs) do
		unit.PreviousHPPercentage = 1
	end
	for index, unit in pairs (Mission.JapDestroyer) do
		unit.PreviousHPPercentage = 1
	end
	

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_pri_obj_1",
				["Text"] = "mp11.obj_siege_us_p1_text",
				["TextCompleted"] = "mp11.obj_siege_us_p1_comp",
				["TextFailed"] = "mp11.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_pri_obj_1",
				["Text"] = "mp11.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp11.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp11.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_sec1",
				["Text"] = "mp11.obj_siege_jap_s1_text",
				["TextCompleted"] = "mp11.obj_siege_jap_s1_comp",
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

    SetThink(this, "luaQAS11Mission_think")
end
function luaHit(...)
-- RELEASE_LOGOFF  	luaLog(arg)
end
function luaQAS11Mission_think(this, msg)
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
		luaQAS11CheckObjUnits()
		luaQAS11CheckLanding()
		luaCheckPlayers()

	elseif not Mission.Started then
		luaQAS11StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS11StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)
-- fortress 65
-- bigfortress 249
-- warhawk 135
-- mitchell 118
-- avenger 113
-- shinden 189
-- raiden 151
-- judy 159
-- nell 166
-- betty 167
-- Jap Troop Transport 86
-- Akizuki 14
-- Jap CV 52
-- Jap CV 53
-- US CB 241
-- Daihatsu 90
-- heavy aa 463

	AISetTargetWeight(135, 151, false, 9) -- Warhawk vs Raiden
	AISetTargetWeight(151, 135, false, 0.5) -- Raiden vs Warhawk 
	--AISetTargetWeight(135, 159, false, 1) -- Warhawk vs Judy
	--AISetTargetWeight(135, 90, false, 1) -- Warhawk vs Daihatsu
	
	AISetTargetWeight(135, 167, false, 2) -- Warhawk vs Betty	
	AISetTargetWeight(135, 166, false, 2) -- Warhawk vs Nell
	AISetTargetWeight(118, 151, false, 0.5) -- Mitchell vs Raiden
	AISetTargetWeight(118, 159, false, 0.5) -- Mitchell vs Judy
	AISetTargetWeight(118, 86, false, 1.2) -- Mitchell vs TT
	AISetTargetWeight(118, 14, false, 0.2) -- Mitchell vs Akizuki
	AISetTargetWeight(118, 52, false, 0.02) -- Mitchell vs CV
	AISetTargetWeight(118, 53, false, 0.012) -- Mitchell vs CV
	AISetTargetWeight(113, 86, false, 1.7) -- Avenger vs TT
	AISetTargetWeight(113, 14, false, 1.6) -- Avenger vs Akizuki
	AISetTargetWeight(113, 52, false, 1.65) -- Avenger vs CV
	AISetTargetWeight(113, 53, false, 1.65) -- Avenger vs CV
	AISetTargetWeight(151, 463, false, 1.0) -- Raiden vs Heavy AA
	AISetTargetWeight(151, 118, false, 0.5) -- Raiden vs Mitchell
	AISetTargetWeight(159, 65, false, 1.8) -- Judy vs Fortress
	AISetTargetWeight(159, 249, false, 1.5) -- Judy vs BigFortress
	AISetTargetWeight(167, 135, false, 0.5) -- Betty vs Warhawk
	AISetTargetWeight(167, 113, false, 0.5) -- Betty vs Avenger
	AISetTargetWeight(167, 118, false, 0.7) -- Betty vs Mitchell
	AISetTargetWeight(167, 65, false, 1.5) -- Betty vs Fortress
	AISetTargetWeight(167, 249, false, 1.7) -- Betty vs BigFortress
	
	AISetTargetWeight(166, 135, false, 0.5) -- Nell vs Warhawk
	AISetTargetWeight(166, 113, false, 0.5) -- Nell vs Avenger
	AISetTargetWeight(166, 118, false, 0.7) -- Nell vs Mitchell
	AISetTargetWeight(166, 65, false, 1.5) -- Nell vs Fortress
	AISetTargetWeight(166, 249, false, 1.7) -- Nell vs BigFortress

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	for index, unit in pairs (Mission.HQs) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end
	
	--[[for i, grp in pairs(Mission.FortArea) do
		for index, unit in pairs (grp) do
			AISetHintWeight(unit, 2)
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	end]]
	
	luaObj_Add("secondary", 1)
	for idx, unit in pairs(Mission.FortArea) do
		for i,j in pairs(unit) do
			luaObj_AddUnit("secondary", 1, j)
		end
	end
	--Mission.ChosenArea = random(1, table.getn(Mission.FortArea))
	
	--[[for index, unit in pairs (Mission.FortArea[Mission.ChosenArea]) do
		luaObj_AddUnit("secondary", 1, unit)
		AISetHintWeight(unit, 2.5)
	end]]
	
	for index, unit in pairs (Mission.JapTTTemplates) do
-- RELEASE_LOGOFF  		luaLog("  generating TT "..index.."...")
		local transport = GenerateObject(unit.Name)
		transport.group = index
		transport.waiting = true
		NavigatorSetAvoidLandCollision(transport, false)
		NavigatorSetTorpedoEvasion(transport, false)
		NavigatorSetAvoidShipCollision(transport, false)
		NavigatorMoveToPos(transport, luaGetPathPoint(Mission.JapTTPaths[index], 2))
		table.insert(Mission.JapTTs, transport)
	end
	
--[[
	for index, unit in pairs (Mission.HQs) do
		OverrideHP(unit, Mission.HP_HQ)
	end
]]
	Mission.Started = true
end

function luaQAS11CheckObjUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking objective units...")
	--Fortresses
	local index = table.getn(Mission.HeavyAAs)
	while (index > 0) do
		local unit = Mission.HeavyAAs[index]
		if (unit.Dead) then
			luaResourcePoolReducer("AAGun")
			table.remove(Mission.HeavyAAs, index)
		end
		index = index - 1
	end

	for i, grp in pairs(Mission.FortArea) do
		if table.getn(grp) ~= 0 then
			local index = table.getn(grp)
			while (index > 0) do
				local unit = grp[index]
				if (unit.Dead) then
					if unit.ClassID == 249 then
-- RELEASE_LOGOFF  						luaLog("a bigfortress is down, reducing japanese pool")
						luaResourcePoolReducer("bigfortress")
					else
-- RELEASE_LOGOFF  						luaLog("a smallfortress is down, reducing japanese pool")
						luaResourcePoolReducer("smallfortress")
					end
					table.remove(Mission.FortArea[i], index)
				end
				index = index - 1
			end
			if table.getn(grp) == 0 then
				MissionNarrativeParty(0, "mp11.nar_siege_area_cleared")
				MissionNarrativeParty(1, "mp11.nar_siege_area_cleared")
			end
		--[[elseif luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) and i == Mission.ChosenArea then
-- RELEASE_LOGOFF  			luaLog(" secondary 1 completed")
			luaObj_Completed("secondary", 1)]]
		end
	end
	
	if (table.getn(Mission.JapDestroyer) > 0) then
		local index = table.getn(Mission.JapDestroyer)
		while (index > 0) do
			if Mission.JapDestroyer[index].Dead then
				local difference = Mission.JapDestroyer[index].PreviousHPPercentage
				local by = luaRound(difference * 100)
				luaResourcePoolReducer("JapDestroyer", by)
				table.remove(Mission.JapDestroyer, index)
			else
				local threshold = GetHpPercentage(Mission.JapDestroyer[index]) + 0.01
				if threshold < Mission.JapDestroyer[index].PreviousHPPercentage then
					local difference = Mission.JapDestroyer[index].PreviousHPPercentage - GetHpPercentage(Mission.JapDestroyer[index])
					local by = luaRound(difference * 100)
					luaResourcePoolReducer("JapDestroyer", by)
					Mission.JapDestroyer[index].PreviousHPPercentage = GetHpPercentage(Mission.JapDestroyer[index])
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
					MissionNarrativeParty(0, "mp11.nar_siege_cv_lost")
					MissionNarrativeParty(1, "mp11.nar_siege_cv_lost")
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
							MissionNarrativeParty(0, "mp11.nar_siege_cv_lost")
							MissionNarrativeParty(1, "mp11.nar_siege_cv_lost")
						end
					end
				end
			end
			index = index - 1
		end
	elseif not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  Carriers lost, calling MissionEnd")
		Mission.MissionEndCalled = true
		luaQAS11MissionEnd()
	end
	
	--HQs
	for index, unit in pairs (Mission.HQs) do
		if unit.Party == PARTY_ALLIED then
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
			luaQAS11MissionEnd()
		end
	end
end

function luaQAS11CheckLanding()
-- RELEASE_LOGOFF  	luaLog(" Checking landing units...")
	if table.getn(Mission.JapTTs) ~= 0 then
		for index, unit in pairs (Mission.JapTTs) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead transport found index "..tostring(index))
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
				luaResourcePoolReducer("transport")
				--table.remove(Mission.JapTTs, index)
			elseif unit.respawnset and unit.respawntime < GameTime() then
-- RELEASE_LOGOFF  				luaLog("  replacing dead transport "..tostring(index))
				Mission.JapTTs[index] = GenerateObject(Mission.JapTTTemplates[index].Name)
				MissionNarrativeParty(1, "mp11.nar_siege_tr_arrive")
				MissionNarrativeParty(0, "mp11.nar_siege_tr_arrive")
				Mission.JapTTs[index].group = index
				unit.respawnset = false
				NavigatorSetAvoidLandCollision(Mission.JapTTs[index], false)
				NavigatorSetTorpedoEvasion(Mission.JapTTs[index], false)
				NavigatorSetAvoidShipCollision(Mission.JapTTs[index], false)
				NavigatorMoveToPos(Mission.JapTTs[index], luaGetPathPoint(Mission.JapTTPaths[index], 2))
				Mission.JapTTs[index].waiting = true
			elseif unit.waiting then
-- RELEASE_LOGOFF  				luaLog("  transport is waiting"..tostring(index))
				if table.getn(Mission.FortArea[index]) == 0 then
					NavigatorMoveOnPath(Mission.JapTTs[index], Mission.JapTTPaths[index])
					local pathpoints = FillPathPoints(Mission.JapTTPaths[index])
					AddProximityTrigger(Mission.JapTTs[index], Mission.JapTTTriggerID[index], Mission.JapTTTriggerFunction[index], pathpoints[3], 200)
					unit.waiting = false
				end
			elseif not unit.Dead and unit.inpos and not unit.landingalive then
-- RELEASE_LOGOFF  				luaLog("  transport in position, sending landing units "..tostring(index))
				unit.landingalive = true
				for i = 1, table.getn(Mission.JapLandingPoints[index]) do
					local landingunit = GenerateObject(Mission.JapLandingTemplate.Name, Mission.JapLandingPoints[index][i])
					if unit.group == 1 then
						EntityTurnToEntity(landingunit, Mission.Navpoints[1])
						NavigatorMoveToRange(landingunit, Mission.Navpoints[1])
					elseif unit.group == 2 then
						EntityTurnToEntity(landingunit, Mission.Navpoints[2])
						NavigatorMoveToRange(landingunit, Mission.Navpoints[2])
					elseif unit.group == 3 then
						EntityTurnToEntity(landingunit, Mission.Navpoints[3])
						NavigatorMoveToRange(landingunit, Mission.Navpoints[3])
					end
					NavigatorSetAvoidLandCollision(landingunit, false)
					NavigatorSetTorpedoEvasion(landingunit, false)
					NavigatorSetAvoidShipCollision(landingunit, false)
					ArtilleryEnable(landingunit, false)
					AAEnable(landingunit, false)
					table.insert(Mission.USLandingUnits[index], landingunit)
				end
			end
		end
	end

	for idx, tbl in pairs (Mission.USLandingUnits) do
		if table.getn(Mission.USLandingUnits[idx]) ~= 0 then
			--for index, unit in pairs (Mission.USLandingUnits[idx]) do
			local index = table.getn(Mission.USLandingUnits[idx])
			while (index > 0) do
				local unit = Mission.USLandingUnits[idx][index]
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead landing boat found")
					luaResourcePoolReducer("landingboat")
					table.remove(Mission.USLandingUnits[idx], index)
				end
				index = index - 1
			end
		else
-- RELEASE_LOGOFF  			luaLog("  no more landing boats alive of the previous wave...")
			Mission.JapTTs[idx].landingalive = false
		end
	end
	
	if (not Mission.HQs[1].Dead) and (not Mission.HQs[2].Dead) then
		local tLandingBoats01 = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[1]), 2400, PARTY_JAPANESE, "own")
		local tLandingBoats02 = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[2]), 2400, PARTY_JAPANESE, "own")
		if (tLandingBoats01 ~= nil) and (table.getn(tLandingBoats01) > 0) then
			for i, pBoat in pairs (tLandingBoats01) do
				if (not pBoat.Dead) and (pBoat.IsLanding == nil) then
					local err = StartLanding2(pBoat)
-- RELEASE_LOGOFF  					luaLog("(luaQAS11CheckLanding): elkezdte a landinget: "..pBoat.Name)
					pBoat.IsLanding = true
				end
			end
		end
		if (tLandingBoats02 ~= nil) and (table.getn(tLandingBoats02) > 0) then
			for i, pBoat in pairs (tLandingBoats02) do
				if (not pBoat.Dead) and (pBoat.IsLanding == nil) then
					local err = StartLanding2(pBoat)
-- RELEASE_LOGOFF  					luaLog("(luaQAS11CheckLanding): elkezdte a landinget: "..pBoat.Name)
					pBoat.IsLanding = true
				end
			end
		end
	end
end

function luaQAS11MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Scoring_RealPlayTimeRunning(false)
	MissionNarrativeClear()
	local fortressesdead = true
	for index = 1, table.getn(Mission.FortArea) do
		Mission.FortArea[index] = luaRemoveDeadsFromTable(Mission.FortArea[index])
		if table.getn(Mission.FortArea[index]) > 0 then
			fortressesdead = false
			break
		end
	end
	--if table.getn(Mission.FortArea[Mission.ChosenArea]) == 0 and luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) then
	if fortressesdead then
-- RELEASE_LOGOFF  		luaLog("  fortresses down, secondary 1 completed")
		luaObj_Completed("secondary", 1)
	elseif luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) then
		luaObj_Failed("secondary", 1)
	end
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.JapCarrier = luaRemoveDeadsFromTable(Mission.JapCarrier)
		if table.getn(Mission.JapCarrier) > 0 then
			luaMissionCompletedNew(luaPickRnd(Mission.JapCarrier), "", nil, nil, nil, PARTY_JAPANESE)
			luaQAS11Achievement(PARTY_JAPANESE)
		else
			local units = luaGetOwnUnits("ship", PARTY_JAPANESE)
			if table.getn(units) > 0 then
				luaMissionCompletedNew(luaPickRnd(units), "", nil, nil, nil, PARTY_JAPANESE)
				luaQAS11Achievement(PARTY_JAPANESE)
			else
				luaMissionCompletedNew(luaPickRnd(luaGetOwnUnits(nil, PARTY_JAPANESE)), "", nil, nil, nil, PARTY_JAPANESE)
				luaQAS11Achievement(PARTY_JAPANESE)
			end
		end
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins1")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
		luaQAS11Achievement(PARTY_ALLIED)
	elseif (Mission.HQs[1].Party ~= PARTY_ALLIED) or (Mission.HQs[2].Party ~= PARTY_ALLIED) then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins by killing HQ")
		Mission.ResourceUSPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		local pTarget
		if (Mission.HQs[1].Party ~= PARTY_ALLIED) then
			pTarget = Mission.HQs[1]
		else
			pTarget = Mission.HQs[2]
		end
		luaMissionCompletedNew(pTarget, "", nil, nil, nil, PARTY_JAPANESE)
		luaQAS11Achievement(PARTY_JAPANESE)
	elseif table.getn(Mission.JapCarrier) == 0 then
-- RELEASE_LOGOFF  		luaLog("  US side wins by killing carrier")
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
		luaQAS11Achievement(PARTY_ALLIED)
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege11")
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
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.USTable")
				if unit.ClassID == 118 then	-- mitchell
					luaResourcePoolReducer("uslargeplane", 1)
				else
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("ussmallplane", by)
				end
				table.remove(Mission.USTable, index)
			else
				local previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("ussmallplane", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		local by
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				if unit.ClassID == 167 then	-- betty
					luaResourcePoolReducer("japlargeplane", 1)
				else
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("japsmallplane", by)
				end
				table.remove(Mission.JapTable, index)
			else
				local previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("japsmallplane", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_ALLIED, "own")
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
end

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer called | unit: "..tostring(unit).." | by: "..tostring(by))
	if unit == "ussmallplane" then
		local todeduct = Mission.Resource.SmallPlane * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "uslargeplane" then
		local todeduct = Mission.Resource.LargePlane * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japsmallplane" then
		local todeduct = Mission.Resource.SmallPlane * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "japlargeplane" then
		local todeduct = Mission.Resource.LargePlane * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "transport" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JapTT
	elseif unit == "landingboat" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JapLandingBoat
	elseif unit == "HQ" then
		local todeduct = Mission.Resource.USHQ * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "JapCarrier" then
		local todeduct = Mission.Resource.JapCarrier * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "JapDestroyer" then
		local todeduct = luaRound(Mission.Resource.JapDestroyer * by)
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "AAGun" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USAAGun
	elseif unit == "bigfortress" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USFortBig
	elseif unit == "smallfortress" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USFortSmall
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
		luaQAS11MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS11MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS11MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS11MissionEnd()
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

	DisplayScores(1, 0, "mp01.score_siege_resource_def".."| #MultiScore.0.1#", "mp01.score_siege_resource_att".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_def".."| #MultiScore.1.1#", "mp01.score_siege_resource_att".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_def".."| #MultiScore.2.1#", "mp01.score_siege_resource_att".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_def".."| #MultiScore.3.1#", "mp01.score_siege_resource_att".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.2#", "mp01.score_siege_resource_def".."| #MultiScore.4.1#", 1, 2)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.2#", "mp01.score_siege_resource_def".."| #MultiScore.5.1#", 1, 2)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.2#", "mp01.score_siege_resource_def".."| #MultiScore.6.1#", 1, 2)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.2#", "mp01.score_siege_resource_def".."| #MultiScore.7.1#", 1, 2)
end

function luaQAS11JapTT1InPos()
-- RELEASE_LOGOFF  	luaLog(" JapTT 1 pulled the trigger!")
	if not Mission.JapTTs[1].Dead then
		Mission.JapTTs[1].inpos = true
	end
end

function luaQAS11JapTT2InPos()
-- RELEASE_LOGOFF  	luaLog(" JapTT 2 pulled the trigger!")
	if not Mission.JapTTs[2].Dead then
		Mission.JapTTs[2].inpos = true
	end
end

function luaQAS11JapTT3InPos()
-- RELEASE_LOGOFF  	luaLog(" JapTT 3 pulled the trigger!")
	if not Mission.JapTTs[3].Dead then
		Mission.JapTTs[3].inpos = true
	end
end
function luaQAS11Achievement(party)
	local i
	if party == PARTY_ALLIED then
		i = 0
	elseif party == PARTY_JAPANESE then
		i = 4
	end
	for player = i, i+3 do
-- RELEASE_LOGOFF  		luaLog("Achievement to player "..player)
		SetAchievements(player,"MA_DLC03SM")
	end
end
