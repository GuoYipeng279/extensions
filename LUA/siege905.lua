function luaPrecacheUnits()
	PrepareClass(102) -- Corsair
	PrepareClass(100) -- Kamikaze Oscar
	PrepareClass(163) -- Jill
	PrepareClass(151) -- Raiden
	PrepareClass(175) -- Emily
	PrepareClass(77) -- Gyoraitei
	PrepareClass(43) -- Shinyo
	PrepareClass(11) -- Allen M. Sumner
	PrepareClass(12) -- LSM(R)
	PrepareClass(239) -- LST (spec QA)
	PrepareClass(32) -- Ohka Carrier
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene905")
end

function luaInitScene905(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Iwo Jima"

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	--precache

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 905

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})


	-- amerikai objektumok
	Mission.LSTs = {}
	Mission.LSTTMPL = luaFindHidden("LST TMPL")

	Mission.OhkaTMPL = luaFindHidden("Ohka TMPL")
	-- japan objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Command Station 02"))
	Mission.HQPreviousHPPercentage = 1		
		
	Mission.HQ = FindEntity("Command Station 02")

	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 01"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 03"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 04"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 05"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 06"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 07"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 08"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 09"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 10"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 11"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 12"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 13"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 14"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 15"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 16"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 17"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 18"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 19"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 20"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 21"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 22"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 23"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 24"))
		table.insert(Mission.Fortresses, FindEntity("Coastal Gun, Japanese 25"))
		table.insert(Mission.Fortresses, FindEntity("Huge Battery Open Strafeable 01"))
		table.insert(Mission.Fortresses, FindEntity("Huge Battery Open Strafeable 02"))		
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 02"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 03"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 04"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 06"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 07"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 09"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 10"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 12"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 14"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 15"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 16"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 17"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 18"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 19"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 20"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 22"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 23"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 24"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 25"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 26"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 27"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 28"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 29"))
		table.insert(Mission.Fortresses, FindEntity("Heavy AA, Japanese 30"))
		table.insert(Mission.Fortresses, FindEntity("Light AA, US 01"))		
		table.insert(Mission.Fortresses, FindEntity("Light AA, US 02"))		
		table.insert(Mission.Fortresses, FindEntity("Light AA, US 03"))		
		table.insert(Mission.Fortresses, FindEntity("Light AA, US 04"))
		
	Mission.LSTSpawnPositions = {}
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("LST Spawnpoint 1")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("LST Spawnpoint 2")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("LST Spawnpoint 3")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("LST Spawnpoint 4")))
		
	Mission.MajorUnits = {}
		table.insert(Mission.MajorUnits, FindEntity("Idaho"))
		table.insert(Mission.MajorUnits, FindEntity("Mississippi"))
		table.insert(Mission.MajorUnits, FindEntity("Louisville"))
		table.insert(Mission.MajorUnits, FindEntity("Abner Read"))
		table.insert(Mission.MajorUnits, FindEntity("Dewey"))
		table.insert(Mission.MajorUnits, FindEntity("Wichita"))
		table.insert(Mission.MajorUnits, FindEntity("Tuscaloosa"))
		table.insert(Mission.MajorUnits, FindEntity("Boston"))
		table.insert(Mission.MajorUnits, FindEntity("White Plains"))
		table.insert(Mission.MajorUnits, FindEntity("Copahee"))
		table.insert(Mission.MajorUnits, FindEntity("AirField 01"))
		table.insert(Mission.MajorUnits, FindEntity("Shipyard 01"))
		table.insert(Mission.MajorUnits, FindEntity("Shipyard 02"))

	Mission.OhkaTargets = {}
		table.insert(Mission.OhkaTargets, FindEntity("Idaho"))
		table.insert(Mission.OhkaTargets, FindEntity("Mississippi"))
		table.insert(Mission.OhkaTargets, FindEntity("Louisville"))
		table.insert(Mission.OhkaTargets, FindEntity("Wichita"))
		table.insert(Mission.OhkaTargets, FindEntity("Tuscaloosa"))
		table.insert(Mission.OhkaTargets, FindEntity("Boston"))
		table.insert(Mission.OhkaTargets, FindEntity("Dewey"))
		table.insert(Mission.OhkaTargets, FindEntity("Abner Read"))
		table.insert(Mission.OhkaTargets, FindEntity("Copahee"))
		table.insert(Mission.OhkaTargets, FindEntity("White Plains"))
	Mission.OhkaTargetNum = 1
	-- figyelesek

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

	Mission.ResourceUSNewYork = 40
	--Mission.ResourceUSCleveland = 5 * Mission.Factor
	Mission.ResourceUSSumner = 20
	Mission.ResourceUSFletcher = 20
	Mission.ResourceUSNorthampton = 30
	Mission.ResourceUSBogue = 100
	Mission.ResourceUSLST = 4
	Mission.ResourceJapCoastalGun = 4
	Mission.ResourceJapFortress = 40
	Mission.ResourceJapHeavyAA = 4
	Mission.ResourceJapBattery = 12
	Mission.ResourceJapLightAA = 4
	Mission.ResourceJapHQ = 1
	Mission.ResourceJapOhka = 4
	Mission.ResourceJapAirfield = 50
	Mission.ResourceJapShipyard = 50
	Mission.ResourcePlayerUnit = 15

	OverrideHP(FindEntity("AirField 01"), 10000)
	OverrideHP(FindEntity("Shipyard 01"), 10000)
	OverrideHP(FindEntity("Shipyard 02"), 10000)
	--OverrideHP(Mission.HQs[1], 16000)

	for r = 1, 10 do
		RepairEnable(Mission.MajorUnits[r], false)
	end

	AISetTargetWeight(175, 11, false, 60) --Emily to Sumner	
	AISetTargetWeight(175, 12, false, 50) --Emily to LSM(R)	
	AISetTargetWeight(163, 11, false, 50) --Jill to Sumner	
	AISetTargetWeight(163, 12, false, 50) --Jill to LSM(R)		
	AISetTargetWeight(151, 102, false, 50) --Raiden to Corsair
	AISetTargetWeight(151, 239, false, 50) --Raiden to LST	
	AISetTargetWeight(151, 12, false, 60) --Raiden to LSM(R)	


	AISetTargetWeight(102, 151, false, 20) --Corsair to Raiden
	AISetTargetWeight(102, 175, false, 20) --Corsair to Emily
	--AISetTargetWeight(102, 239, false, 20) --Corsair to Gyoraitei
	AISetTargetWeight(102, 450, false, 20) --Corsair to Coastal Gun
	AISetTargetWeight(102, 249, false, 20) --Corsair to Long Fortress
	AISetTargetWeight(102, 452, false, 20) --Corsair to Heavy AA
	AISetTargetWeight(102, 276, false, 20) --Corsair to Shipyard
	AISetTargetWeight(102, 197, false, 0) --Corsair to Baka
	AISetTargetWeight(102, 32, false, 20) --Corsair to Ohka Carrier
	AISetTargetWeight(12, 249, false, 20) --LSM(R) to Fortress
	AISetTargetWeight(11, 276, false, 20) --Sumner to Shipyard

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua") -- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_1",
				["Text"] = "mp05.obj_siege_us_p1_text",
				["TextCompleted"] = "mp05.obj_siege_us_p1_comp",
				["TextFailed"] = "mp05.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_2",
				["Text"] = "At least one of carriers should survive!",
				["TextCompleted"] = "You have successfully protected a carrier!",
				["TextFailed"] = "You failed to protect the carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "Destroy all of the carriers!",
				["TextCompleted"] = "You have successfully destroyed the carriers!",
				["TextFailed"] = "You failed destroy the carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] = {
--[[			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "jap_obj_sec1",
				["Text"] = "mp01.obj_siege_jap_s1_text",
				["TextCompleted"] = "mp01.obj_siege_jap_s1_comp",
				["TextFailed"] = "mp01.obj_siege_jap_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},

			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "At least one of the landing ships should survive!",
				["TextCompleted"] = "You have successfully protected some of the landing ships!",
				["TextFailed"] = "You failed to protect the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "Destroy the landing ships before they reach the shore!",
				["TextCompleted"] = "Your forces have successfully destroyed the landing boats!",
				["TextFailed"] = "Your forces have failed to destroy the landing boats!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	SetThink(this, "luaScene905_think")
end

function luaScene905_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaCheckPlayers()
		luaCheckUSFleet()
		luaCheckLSTs()
		luaOhka()
		luaCheckJapSpawns()
		luaCheckForts()
		luaCheckMissionEnd()

	elseif not Mission.Started then

		luaScene905StartMission()
		luaSetMultiScoreTable()
	end
end

function luaScene905StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)


	--[[ fortress long
	AISetTargetWeight(23, 66, false, 4)
	AISetTargetWeight(25, 66, false, 4)
	-- fortress left tower
	AISetTargetWeight(23, 84, false, 5)
	AISetTargetWeight(25, 84, false, 5)]]

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQs[1])
	luaObj_AddUnit("primary", 2, Mission.HQs[1])
--	luaObj_Add("secondary", 1)
	for index, unit in pairs (Mission.Fortresses) do
--		luaObj_AddUnit("secondary", 1, unit)
		SetSkillLevel(unit, SKILL_ELITE)
	end

	for i = 1, 4 do
-- RELEASE_LOGOFF  		luaLog(" generating LST")
		local lst = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[i])
		NavigatorSetTorpedoEvasion(lst, false)
		NavigatorSetAvoidLandCollision(lst, false)
		NavigatorMoveToRange(lst, Mission.HQs[1])
		table.insert(Mission.LSTs, lst)
	end
	
	luaRespawnOhka()
	
	Mission.Started = true
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
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.1#", "mp01.score_siege_resource_def".."| #MultiScore.4.2#", 2, 1)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.1#", "mp01.score_siege_resource_def".."| #MultiScore.5.2#", 2, 1)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.1#", "mp01.score_siege_resource_def".."| #MultiScore.6.2#", 2, 1)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.1#", "mp01.score_siege_resource_def".."| #MultiScore.7.2#", 2, 1)
--[[
	DisplayScores(1, 0, "mp01.score_siege_resource".."| #MultiScore.0.1#", "mp01.score_siege_resource".."| #MultiScore.0.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 1, "mp01.score_siege_resource".."| #MultiScore.1.1#", "mp01.score_siege_resource".."| #MultiScore.1.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 2, "mp01.score_siege_resource".."| #MultiScore.2.1#", "mp01.score_siege_resource".."| #MultiScore.2.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 3, "mp01.score_siege_resource".."| #MultiScore.3.1#", "mp01.score_siege_resource".."| #MultiScore.3.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 4, "mp01.score_siege_resource".."| #MultiScore.4.1#", "mp01.score_siege_resource".."| #MultiScore.4.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 5, "mp01.score_siege_resource".."| #MultiScore.5.1#", "mp01.score_siege_resource".."| #MultiScore.5.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 6, "mp01.score_siege_resource".."| #MultiScore.6.1#", "mp01.score_siege_resource".."| #MultiScore.6.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 7, "mp01.score_siege_resource".."| #MultiScore.7.1#", "mp01.score_siege_resource".."| #MultiScore.7.2#", PARTY_ALLIED, PARTY_JAPANESE)
]]
end

function luaCheckLSTs()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if table.getn(Mission.LSTs) ~= 0 then
		for index, unit in pairs (Mission.LSTs) do
			if unit.Dead then
				Mission.LSTs[index] = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[index])
				luaResourcePoolReducer("LST")
				NavigatorMoveToRange(Mission.LSTs[index], Mission.HQs[1])
				NavigatorSetTorpedoEvasion(Mission.LSTs[index], false)
				NavigatorSetAvoidLandCollision(Mission.LSTs[index], false)
			elseif not unit.landing then
				if luaGetDistance(unit, Mission.HQs[1]) < 1000 then
					unit.landing = true
					StartLanding2(unit)
				end
			elseif not unit.landed and luaGetDistance(unit, Mission.HQs[1]) < 300 then
				unit.landed = true
				--luaResourcePoolReducer("landing")
			end
		end
	end
end

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer: "..unit)
	if unit == "usplayer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourcePlayerUnit
	elseif unit == "japplayer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourcePlayerUnit
	elseif unit == "LST" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLST
	elseif unit == "newyork" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSNewYork
	elseif unit == "fletcher" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFletcher
	elseif unit == "sumner" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSSumner
	elseif unit == "northampton" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSNorthampton
	elseif unit == "bogue" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSBogue
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceJapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "coastalgun" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapCoastalGun
	elseif unit == "fortress" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortress
	elseif unit == "heavyaa" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapHeavyAA
	elseif unit == "battery" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapBattery
	elseif unit == "lightaa" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapLightAA
	elseif unit == "ohka" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapOhka
	elseif unit == "landing" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - (Mission.ResourceUSLST * 2)
	elseif unit == "airfield" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapAirfield
	elseif unit == "shipyard" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapShipyard
	end

	Mission.ResourceUSPool = luaRound(Mission.ResourceUSPool)
	Mission.ResourceJapPool = luaRound(Mission.ResourceJapPool)

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
		luaScene905MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaScene905MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaScene905MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaScene905MissionEnd()
		end
	end
end

function luaScene905MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Mission.Completed = true
	Scoring_RealPlayTimeRunning(false)

	--[[local fortalive = 0
	if not Mission.AllFortsDown then
		for index, unit in pairs (Mission.Fortresses) do
			if not unit.Dead then
				fortalive = fortalive + 1
			end
		end	
		if fortalive == 0 then
			Mission.AllFortsDown = true
			luaObj_Completed("secondary", 1)
		else
			luaObj_Failed("secondary", 1)
		end
	end]]

	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog(" Japanese side wins!")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	elseif Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if Mission.HQs[1].Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  the HQ is still in Japanese hands, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaObj_Failed("secondary", 1)
		luaObj_Completed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQ is neutral, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaObj_Completed("secondary", 1)
		luaObj_Failed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaCheckForts()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
	local fortalive = 0
	for index, unit in pairs (Mission.Fortresses) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found ID: "..tostring(unit.Class.ID))
			if unit.Class.ID == 450 then
				luaResourcePoolReducer("coastalgun")
			elseif unit.Class.ID == 249 then
				luaResourcePoolReducer("fortress")
			elseif unit.Class.ID == 452 then
				luaResourcePoolReducer("heavyaa")
			elseif unit.Class.ID == 384 then
				luaResourcePoolReducer("battery")
			elseif unit.Class.ID == 461 then
				luaResourcePoolReducer("lightaa")
			end
			unit.ignore = true
		else
			fortalive = fortalive + 1
		end
	end

	--[[if fortalive == 0 and not Mission.AllFortsDown then
		Mission.AllFortsDown = true
		luaObj_Completed("secondary", 1)
	end]]
if GameTime() <= 40 then OverrideHP(Mission.HQs[1], 12000)
elseif GameTime() > 40 then
	local threshold = GetHpPercentage(Mission.HQ) + 0.01
	if threshold < Mission.HQPreviousHPPercentage then
		local difference = Mission.HQPreviousHPPercentage - GetHpPercentage(Mission.HQ)
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.HQPreviousHPPercentage = GetHpPercentage(Mission.HQ)
	end
end

	if not Mission.MissionEndCalled then
		if Mission.HQs[1].Party ~= PARTY_JAPANESE then
			Mission.ResourceJapPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = Mission.ResourceUSPool
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaMissionEnd()
		end
	end
end

function luaCheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission end conditions...")
	if not Mission.MissionEndCalled then
		if Mission.HQs[1].Party ~= PARTY_JAPANESE then -- or Mission.KeyUnitCounter == 0 then
-- RELEASE_LOGOFF  			luaLog("  HQ party "..tostring(Mission.HQs[1].Party).." | key unit counter: "..tostring(Mission.KeyUnitCounter))
			Mission.ResourceJapPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = Mission.ResourceUSPool
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			for index, unit in pairs (Mission.LSTs) do
				if not unit.Dead then
					NavigatorMoveToRange(unit, Mission.CVSpawnPositions[2])
				end
			end
			luaMissionEnd()
		end
	end
end

function luaCheckPlayers()
-- RELEASE_LOGOFF  	luaLog(" Checking players...")
	if not Mission.IDTableInitiated then
		Mission.USTable = {}
		Mission.JapTable = {}
		Mission.IDTableInitiated = true
	end

	if table.getn(Mission.USTable) ~= 0 then
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.USTable")
				luaResourcePoolReducer("usplayer")
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				luaResourcePoolReducer("japplayer")
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if unit.Class.ID == 18 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if unit.Class.ID == 77 or unit.Class.ID == 43 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
			end
		end
	end
	
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if unit.Class.ID == 102 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if unit.Class.ID == 151 or unit.Class.ID == 163 or unit.Class.ID == 100 or unit.Class.ID == 175 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
			end
		end
	end

end

function luaCheckUSFleet()
-- RELEASE_LOGOFF  	luaLog(" Checking carriers...")
	if table.getn(Mission.MajorUnits) ~= 0 then
		for index, unit in pairs (Mission.MajorUnits) do
			if unit.Dead and not unit.ignore then
				if unit.Class.ID == 13 then
					luaResourcePoolReducer("newyork")
				elseif unit.Class.ID == 18 then
					luaResourcePoolReducer("fletcher")
				elseif unit.Class.ID == 11 then
					luaResourcePoolReducer("sumner")
				elseif unit.Class.ID == 19 then
					luaResourcePoolReducer("northampton")
				elseif unit.Class.ID == 24 then
					luaResourcePoolReducer("bogue")
				elseif unit.Class.ID == 200 then
					luaResourcePoolReducer("airfield")
				elseif unit.Class.ID == 205 then
					luaResourcePoolReducer("shipyard")
				end
				unit.ignore = true
			end
		end
	end
end

function luaMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Mission.Completed = true
	Scoring_RealPlayTimeRunning(false)

--[[	local fortalive = 0
	if not Mission.AllFortsDown then
		for index, unit in pairs (Mission.Fortresses) do
			if not unit.Dead then
				fortalive = fortalive + 1
			end
		end	
		if fortalive == 0 then
			Mission.AllFortsDown = true
			luaObj_Completed("secondary", 1)
		else
			luaObj_Failed("secondary", 1)
		end
	end]]

	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog(" Japanese side wins!")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  the HQ is still in Japanese hands, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaObj_Failed("secondary", 1)
		luaObj_Completed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQ is neutral, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaObj_Completed("secondary", 1)
		luaObj_Failed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaOhka()
	if Mission.OhkaTargetNum <= 10 and Mission.Ohka.Dead then
		if Mission.OhkaSpawnCalled == false then
			luaResourcePoolReducer("ohka")
			luaDelay(luaRespawnOhka, 30)
			Mission.OhkaSpawnCalled = true
		end	
	elseif Mission.OhkaTargets[Mission.OhkaTargetNum].Dead then
		Mission.OhkaTargetNum = Mission.OhkaTargetNum + 1
		if Mission.OhkaTargetNum <= 10 then		
			PilotSetTarget(Mission.Ohka, Mission.OhkaTargets[Mission.OhkaTargetNum])
		end
	end
end

function luaRespawnOhka()
	if Mission.OhkaTargetNum <= 10 then
		Mission.OhkaSpawnCalled = false
		MissionNarrativeParty(0, "mp02.nar_comp_ohka")
		Mission.Ohka = GenerateObject(Mission.OhkaTMPL.Name)
		PilotSetTarget(Mission.Ohka, Mission.OhkaTargets[Mission.OhkaTargetNum])
	end
end

function luaCheckJapSpawns()
	if Mission.MajorUnits[11].Dead and Mission.MajorUnits[12].Dead and Mission.MajorUnits[13].Dead then
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaMissionEnd()
	end
end