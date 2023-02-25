function luaPrecacheUnits()
	PrepareClass(19)	-- Northampton
	PrepareClass(21)	-- York
	PrepareClass(18)	-- Cleveland
	PrepareClass(17)	-- Atlanta
	PrepareClass(13)	-- New York
	PrepareClass(9)		-- King George V
	PrepareClass(68)	-- Tone
	PrepareClass(69)	-- Takao
	PrepareClass(67)	-- Mogami
	PrepareClass(70)	-- Kuma
	PrepareClass(60)	-- Kongo
	PrepareClass(61)	-- Fuso
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene160")
end

function luaInitScene160(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Steel Monsters"

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
	Mission.MultiplayerNumber = 907
	
	Music_Control_SetLevel(MUSIC_TENSION)

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})


	Mission.USFleetTMPL = {}
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Warspite"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - York"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - New York"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Cleveland"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Prince of Wales"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Atlanta"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Pennsylvania"))
		table.insert(Mission.USFleetTMPL, luaFindHidden("Siege - Northampton"))
		
	Mission.USFleet = {}

	Mission.IJNFleetTMPL = {}
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Haruna"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Kuma"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Fuso"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Takao"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Kongo"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Mogami"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Yamashiro"))	
		table.insert(Mission.IJNFleetTMPL, luaFindHidden("Siege - Tone"))	

	Mission.IJNFleet = {}		

	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 5"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 6"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 7"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Player 8"))
		
		for n = 0, 7 do
			for o = 1, 8 do
				DeactivateSpawnpoint(Mission.SpawnPoints[o], n)
			end
		end
		
		for p = 1, 8 do
			q =  p - 1
			ActivateSpawnpoint(Mission.SpawnPoints[p], q)
		end
		

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

	Mission.ResourcePlayer = 40
	Mission.ResourceYork = 30
	Mission.ResourceNorthampton = 30
	Mission.ResourceCleveland = 20
	Mission.ResourceAtlanta = 20
	Mission.ResourceNewYork = 40
	Mission.ResourceKGV = 40
	Mission.ResourceTone = 30
	Mission.ResourceTakao = 30
	Mission.ResourceMogami = 30
	Mission.ResourceKuma = 20
	Mission.ResourceKongo = 40
	Mission.ResourceFuso = 40


---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua") -- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri1",
				["Text"] = "mp03.obj_siege_us_p1_text",
				["TextCompleted"] = "mp03.obj_siege_us_p1_comp",
				["TextFailed"] = "mp03.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri1",
				["Text"] = "mp01.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp01.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp01.obj_siege_jap_p1_fail",
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

	--AISetSpawnSceneUnitsWeightMul(0)

	SetThink(this, "luaScene907_think")
end

function luaScene907_think(this, msg)
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
		luaCheckFleets()
	elseif not Mission.Started then
		luaScene907StartMission()
		luaSetMultiScoreTable()
	end
end

function luaScene907StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaMultiVoiceOverHandler()


	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	
	luaGenerateShips()
		
	Mission.Started = true
end

function luaGenerateShips()
local WarspiteTMPL = luaFindHidden("Siege - Warspite")
local YorkTMPL = luaFindHidden("Siege - York")
local NewYorkTMPL = luaFindHidden("Siege - New York")
local ClevelandTMPL = luaFindHidden("Siege - Cleveland")
local PoWTMPL = luaFindHidden("Siege - Prince of Wales")
local AtlantaTMPL = luaFindHidden("Siege - Atlanta")
local PennsylvaniaTMPL = luaFindHidden("Siege - Pennsylvania")
local NorthamptonTMPL = luaFindHidden("Siege - Northampton")

local HarunaTMPL = luaFindHidden("Siege - Haruna")
local KumaTMPL = luaFindHidden("Siege - Kuma")
local FusoTMPL = luaFindHidden("Siege - Fuso")
local TakaoTMPL = luaFindHidden("Siege - Takao")
local KongoTMPL = luaFindHidden("Siege - Kongo")
local MogamiTMPL = luaFindHidden("Siege - Mogami")
local YamashiroTMPL = luaFindHidden("Siege - Yamashiro")
local ToneTMPL = luaFindHidden("Siege - Tone")

	Mission.USFleet = {}
	Mission.IJNFleet = {}

	Mission.Warspite = GenerateObject(WarspiteTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Warspite)
	luaObj_AddUnit("primary", 2, Mission.Warspite)
	table.insert(Mission.USFleet, Mission.Warspite)	
	
	Mission.York = GenerateObject(YorkTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.York)
	luaObj_AddUnit("primary", 2, Mission.York)
	table.insert(Mission.USFleet, Mission.York)	
	
	Mission.NewYork = GenerateObject(NewYorkTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.NewYork)
	luaObj_AddUnit("primary", 2, Mission.NewYork)
	table.insert(Mission.USFleet, Mission.NewYork)	
	
	Mission.Cleveland = GenerateObject(ClevelandTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Cleveland)
	luaObj_AddUnit("primary", 2, Mission.Cleveland)
	table.insert(Mission.USFleet, Mission.Cleveland)	
	
	Mission.PoW = GenerateObject(PoWTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.PoW)
	luaObj_AddUnit("primary", 2, Mission.PoW)
	table.insert(Mission.USFleet, Mission.PoW)	
	
	Mission.Atlanta = GenerateObject(AtlantaTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Atlanta)
	luaObj_AddUnit("primary", 2, Mission.Atlanta)
	table.insert(Mission.USFleet, Mission.Atlanta)	
	
	Mission.Pennsylvania = GenerateObject(PennsylvaniaTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Pennsylvania)
	luaObj_AddUnit("primary", 2, Mission.Pennsylvania)
	table.insert(Mission.USFleet, Mission.Pennsylvania)	
	
	Mission.Northampton = GenerateObject(NorthamptonTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Northampton)
	luaObj_AddUnit("primary", 2, Mission.Northampton)
	table.insert(Mission.USFleet, Mission.Northampton)
	
	Mission.Haruna = GenerateObject(HarunaTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Haruna)
	luaObj_AddUnit("primary", 2, Mission.Haruna)
	table.insert(Mission.IJNFleet, Mission.Haruna)	
		
	Mission.Kuma = GenerateObject(KumaTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Kuma)
	luaObj_AddUnit("primary", 2, Mission.Kuma)
	table.insert(Mission.IJNFleet, Mission.Kuma)	
		
	Mission.Fuso = GenerateObject(FusoTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Fuso)
	luaObj_AddUnit("primary", 2, Mission.Fuso)
	table.insert(Mission.IJNFleet, Mission.Fuso)	
		
	Mission.Takao = GenerateObject(TakaoTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Takao)
	luaObj_AddUnit("primary", 2, Mission.Takao)
	table.insert(Mission.IJNFleet, Mission.Takao)	
		
	Mission.Kongo = GenerateObject(KongoTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Kongo)
	luaObj_AddUnit("primary", 2, Mission.Kongo)
	table.insert(Mission.IJNFleet, Mission.Kongo)	
		
	Mission.Mogami = GenerateObject(MogamiTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Mogami)
	luaObj_AddUnit("primary", 2, Mission.Mogami)
	table.insert(Mission.IJNFleet, Mission.Mogami)	
		
	Mission.Yamashiro = GenerateObject(YamashiroTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Yamashiro)
	luaObj_AddUnit("primary", 2, Mission.Yamashiro)
	table.insert(Mission.IJNFleet, Mission.Yamashiro)	
		
	Mission.Tone = GenerateObject(ToneTMPL.Name)
	luaObj_AddUnit("primary", 1, Mission.Tone)
	luaObj_AddUnit("primary", 2, Mission.Tone)
	table.insert(Mission.IJNFleet, Mission.Tone)

	NavigatorAttackMove(Mission.Warspite, Mission.Haruna, {})	
	NavigatorAttackMove(Mission.York, Mission.Kuma, {})	
	NavigatorAttackMove(Mission.NewYork, Mission.Fuso, {})	
	NavigatorAttackMove(Mission.Cleveland, Mission.Takao, {})	
	NavigatorAttackMove(Mission.PoW, Mission.Kongo, {})	
	NavigatorAttackMove(Mission.Atlanta, Mission.Mogami, {})	
	NavigatorAttackMove(Mission.Pennsylvania, Mission.Yamashiro, {})	
	NavigatorAttackMove(Mission.Northampton, Mission.Tone, {})	
	
	NavigatorAttackMove(Mission.Haruna, Mission.Warspite, {})	
	NavigatorAttackMove(Mission.Kuma, Mission.York, {})	
	NavigatorAttackMove(Mission.Fuso, Mission.NewYork, {})	
	NavigatorAttackMove(Mission.Takao, Mission.Cleveland, {})	
	NavigatorAttackMove(Mission.Kongo, Mission.PoW, {})	
	NavigatorAttackMove(Mission.Mogami, Mission.Atlanta, {})	
	NavigatorAttackMove(Mission.Yamashiro, Mission.Pennsylvania, {})	
	NavigatorAttackMove(Mission.Tone, Mission.Northampton, {})		
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

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.2#", "mp01.score_siege_resource_def".."| #MultiScore.0.1#", 1, 2)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.2#", "mp01.score_siege_resource_def".."| #MultiScore.1.1#", 1, 2)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.2#", "mp01.score_siege_resource_def".."| #MultiScore.2.1#", 1, 2)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.2#", "mp01.score_siege_resource_def".."| #MultiScore.3.1#", 1, 2)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.2#", "mp01.score_siege_resource_def".."| #MultiScore.4.1#", 1, 2)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.2#", "mp01.score_siege_resource_def".."| #MultiScore.5.1#", 1, 2)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.2#", "mp01.score_siege_resource_def".."| #MultiScore.6.1#", 1, 2)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.2#", "mp01.score_siege_resource_def".."| #MultiScore.7.1#", 1, 2)

end

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer: "..unit)
	if unit == "playerUS" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourcePlayer
	elseif unit == "york" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceYork
	elseif unit == "northampton" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceNorthampton
	elseif unit == "cleveland" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceCleveland
	elseif unit == "atlanta" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceAtlanta
	elseif unit == "newyork" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceNewYork
	elseif unit == "kinggeorge" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceKGV
	elseif unit == "playerJP" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourcePlayer
	elseif unit == "tone" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceTone	
	elseif unit == "takao" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceTakao	
	elseif unit == "mogami" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceMogami	
	elseif unit == "kuma" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceKuma	
	elseif unit == "kongo" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceKongo
	elseif unit == "fuso" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceFuso	
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
		luaScene160MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaScene160MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaScene160MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaScene160MissionEnd()
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
				luaResourcePoolReducer("playerUS")
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				luaResourcePoolReducer("playerJP")
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if GetRoleAvailable(unit)[1] <= 7 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end	
			end
		end
	end
	
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if GetRoleAvailable(unit)[1] <= 7 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end	
			end
		end
	end
	
end

function luaCheckFleets()
	Mission.USFleet = {}
	Mission.IJNFleet = {}

	if Mission.Warspite.Dead then
		luaResourcePoolReducer("kinggeorge")
		local WarspiteTMPL = luaFindHidden("Siege - Warspite")
		Mission.Warspite = GenerateObject(WarspiteTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Warspite)
		luaObj_AddUnit("primary", 2, Mission.Warspite)
		table.insert(Mission.USFleet, Mission.Warspite)		
	end

	if Mission.York.Dead then
		luaResourcePoolReducer("york")
		local YorkTMPL = luaFindHidden("Siege - York")	
		Mission.York = GenerateObject(YorkTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.York)
		luaObj_AddUnit("primary", 2, Mission.York)
		table.insert(Mission.USFleet, Mission.York)			
	end

	if Mission.NewYork.Dead then
		luaResourcePoolReducer("newyork")
		local NewYorkTMPL = luaFindHidden("Siege - New York")	
		Mission.NewYork = GenerateObject(NewYorkTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.NewYork)
		luaObj_AddUnit("primary", 2, Mission.NewYork)
		table.insert(Mission.USFleet, Mission.NewYork)			
	end

	if Mission.Cleveland.Dead then
		luaResourcePoolReducer("cleveland")
		local ClevelandTMPL = luaFindHidden("Siege - Cleveland")	
		Mission.Cleveland = GenerateObject(ClevelandTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Cleveland)
		luaObj_AddUnit("primary", 2, Mission.Cleveland)
		table.insert(Mission.USFleet, Mission.Cleveland)				
	end

	if Mission.PoW.Dead then
		luaResourcePoolReducer("kinggeorge")
		local PoWTMPL = luaFindHidden("Siege - Prince of Wales")	
		Mission.PoW = GenerateObject(PoWTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.PoW)
		luaObj_AddUnit("primary", 2, Mission.PoW)
		table.insert(Mission.USFleet, Mission.PoW)			
	end

	if Mission.Atlanta.Dead then
		luaResourcePoolReducer("atlanta")
		local AtlantaTMPL = luaFindHidden("Siege - Atlanta")	
		Mission.Atlanta = GenerateObject(AtlantaTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Atlanta)
		luaObj_AddUnit("primary", 2, Mission.Atlanta)
		table.insert(Mission.USFleet, Mission.Atlanta)				
	end

	if Mission.Pennsylvania.Dead then
		luaResourcePoolReducer("newyork")
		local PennsylvaniaTMPL = luaFindHidden("Siege - Pennsylvania")	
		Mission.Pennsylvania = GenerateObject(PennsylvaniaTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Pennsylvania)
		luaObj_AddUnit("primary", 2, Mission.Pennsylvania)
		table.insert(Mission.USFleet, Mission.Pennsylvania)			
	end

	if Mission.Northampton.Dead then
		luaResourcePoolReducer("northampton")
		local NorthamptonTMPL = luaFindHidden("Siege - Northampton")	
		Mission.Northampton = GenerateObject(NorthamptonTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Northampton)
		luaObj_AddUnit("primary", 2, Mission.Northampton)
		table.insert(Mission.USFleet, Mission.Northampton)		
	end

	if Mission.Haruna.Dead then
		luaResourcePoolReducer("kongo")
		local HarunaTMPL = luaFindHidden("Siege - Haruna")	
		Mission.Haruna = GenerateObject(HarunaTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Haruna)
		luaObj_AddUnit("primary", 2, Mission.Haruna)
		table.insert(Mission.IJNFleet, Mission.Haruna)			
	end

	if Mission.Kuma.Dead then
		luaResourcePoolReducer("kuma")
		local KumaTMPL = luaFindHidden("Siege - Kuma")		
		Mission.Kuma = GenerateObject(KumaTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Kuma)
		luaObj_AddUnit("primary", 2, Mission.Kuma)
		table.insert(Mission.IJNFleet, Mission.Kuma)		
	end

	if Mission.Fuso.Dead then
		luaResourcePoolReducer("fuso")
		local FusoTMPL = luaFindHidden("Siege - Fuso")		
		Mission.Fuso = GenerateObject(FusoTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Fuso)
		luaObj_AddUnit("primary", 2, Mission.Fuso)
		table.insert(Mission.IJNFleet, Mission.Fuso)			
	end

	if Mission.Takao.Dead then
		luaResourcePoolReducer("takao")
		local TakaoTMPL = luaFindHidden("Siege - Takao")		
		Mission.Takao = GenerateObject(TakaoTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Takao)
		luaObj_AddUnit("primary", 2, Mission.Takao)
		table.insert(Mission.IJNFleet, Mission.Takao)		
	end

	if Mission.Kongo.Dead then
		luaResourcePoolReducer("kongo")
		local KongoTMPL = luaFindHidden("Siege - Kongo")		
		Mission.Kongo = GenerateObject(KongoTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Kongo)
		luaObj_AddUnit("primary", 2, Mission.Kongo)
		table.insert(Mission.IJNFleet, Mission.Kongo)				
	end

	if Mission.Mogami.Dead then
		luaResourcePoolReducer("mogami")
		local MogamiTMPL = luaFindHidden("Siege - Mogami")		
		Mission.Mogami = GenerateObject(MogamiTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Mogami)
		luaObj_AddUnit("primary", 2, Mission.Mogami)
		table.insert(Mission.IJNFleet, Mission.Mogami)		
	end

	if Mission.Yamashiro.Dead then
		luaResourcePoolReducer("fuso")
		local YamashiroTMPL = luaFindHidden("Siege - Yamashiro")		
		Mission.Yamashiro = GenerateObject(YamashiroTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Yamashiro)
		luaObj_AddUnit("primary", 2, Mission.Yamashiro)
		table.insert(Mission.IJNFleet, Mission.Yamashiro)			
	end

	if Mission.Tone.Dead then
		luaResourcePoolReducer("tone")
		local ToneTMPL = luaFindHidden("Siege - Tone")		
		Mission.Tone = GenerateObject(ToneTMPL.Name)
		luaObj_AddUnit("primary", 1, Mission.Tone)
		luaObj_AddUnit("primary", 2, Mission.Tone)
		table.insert(Mission.IJNFleet, Mission.Tone)		
	end
	
	
	if not Mission.Warspite.Dead and not Mission.Kongo.Dead then
		NavigatorAttackMove(Mission.Warspite, Mission.Kongo, {})	
		NavigatorAttackMove(Mission.Kongo, Mission.Warspite, {})
	end
	
	if not Mission.York.Dead and not Mission.Mogami.Dead then
		NavigatorAttackMove(Mission.York, Mission.Mogami, {})
		NavigatorAttackMove(Mission.Mogami, Mission.York, {})
	end
	
	if not Mission.NewYork.Dead and not Mission.Fuso.Dead then
		NavigatorAttackMove(Mission.NewYork, Mission.Fuso, {})
		NavigatorAttackMove(Mission.Fuso, Mission.NewYork, {})	
	end
	
	if not Mission.Cleveland.Dead and not Mission.Takao.Dead then
		NavigatorAttackMove(Mission.Cleveland, Mission.Takao, {})
		NavigatorAttackMove(Mission.Takao, Mission.Cleveland, {})	
	end
	
	if not Mission.PoW.Dead and not Mission.Yamashiro.Dead then
		NavigatorAttackMove(Mission.PoW, Mission.Yamashiro, {})
		NavigatorAttackMove(Mission.Yamashiro, Mission.PoW, {})
	end
	
	if not Mission.Atlanta.Dead and not Mission.Tone.Dead then
		NavigatorAttackMove(Mission.Atlanta, Mission.Tone, {})
		NavigatorAttackMove(Mission.Tone, Mission.Atlanta, {})
	end
	
	if not Mission.Pennsylvania.Dead and not Mission.Haruna.Dead then
		NavigatorAttackMove(Mission.Pennsylvania, Mission.Haruna, {})
		NavigatorAttackMove(Mission.Haruna, Mission.Pennsylvania, {})
	end
	
	if not Mission.Northampton.Dead and not Mission.Kuma.Dead then
		NavigatorAttackMove(Mission.Northampton, Mission.Kuma, {})
		NavigatorAttackMove(Mission.Kuma, Mission.Northampton, {})
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if GetRoleAvailable(unit)[1] > 7 then
				if not luaIsInside(unit, Mission.USFleet) then
					table.insert(Mission.USFleet, unit)
				end	
			end
		end
	end
	
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if GetRoleAvailable(unit)[1] > 7 then
				if not luaIsInside(unit, Mission.IJNFleet) then
					table.insert(Mission.IJNFleet, unit)
				end	
			end
		end
	end
end

function luaScene160MissionEnd()
	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
--[[
	if Mission.KeyUnitCounter == 0 and not Mission.ObjectivesSet then
		Mission.ObjectivesSet = true
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
	elseif not Mission.ObjectivesSet then
		Mission.ObjectivesSet = true
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
	end
]]
	Scoring_RealPlayTimeRunning(false)
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		--luaObj_Failed("secondary", 1)
		luaMissionCompletedNew(japships[1], "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		--luaObj_Completed("secondary", 1)
		luaMissionCompletedNew(usships[1], "", nil, nil, nil, PARTY_ALLIED)
	end
end