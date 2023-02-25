----	CLASH OF CARRIERS (MULTI) ----

--	Scripted & Assembled by: Team Wolfpack

----	CLASH OF CARRIERS (MULTI) ----

Inputs = nil
function luaPrecacheUnits()

	PrepareClass(9) 	-- KVG
	--PrepareClass(21) 	-- York
	PrepareClass(23) 	-- Fletcher
	PrepareClass(234) 	-- US Troop Transport
	PrepareClass(37) 	-- US Cargo Ship
	PrepareClass(27) 	-- Elco PT Boat
	--PrepareClass(25) 	-- Clemson
	--PrepareClass(20) 	-- DeRuyter
	PrepareClass(3) 	-- Hermes
	--PrepareClass(390) 	-- Alaska
	PrepareClass(389) 	-- Montana
	--PrepareClass(253) 	-- North Carolina
	--PrepareClass(13) 	-- North Carolina
	--PrepareClass(7) 	-- South Dakota
	PrepareClass(317) 	-- Northampton
	--PrepareClass(252) 	-- Brooklyn
	--PrepareClass(11) 	-- Atlanta	
	PrepareClass(11) 	-- Allen M Sumner
	--PrepareClass(48) 	-- ASW Fletcher
	--PrepareClass(30) 	-- Gato
	PrepareClass(17) 	-- Atlanta

	PrepareClass(109) 	-- Fairey Swordfish
	PrepareClass(134) 	-- Hawker Hurricane
	--PrepareClass(116) 	-- Flying Fortress
	--PrepareClass(118) 	-- Mitchell
	PrepareClass(38) 	-- Helldiver
	PrepareClass(113) 	-- Avenger
	PrepareClass(16) 	-- TBM Avenger
	--PrepareClass(104) 	-- Lightning
	PrepareClass(26) 	-- Hellcat
	PrepareClass(27) 	-- Elco
	--PrepareClass(167) 	-- Betty
	--PrepareClass(32) 	-- BettyOhka
	--PrepareClass(166) 	-- Nell
	--PrepareClass(152) 	-- Gekko
	--PrepareClass(171) 	-- Pete
	--PrepareClass(174) 	-- Mavis
	
	PrepareClass(87) 	-- Japanese Cargo Ship
	--PrepareClass(86) 	-- Japanese Troop Transport
	PrepareClass(77) 	-- Japanese PT Boat
	--PrepareClass(70) 	-- Kuma
	PrepareClass(52) 	-- Hiryu
	PrepareClass(14) 	-- Akizuki
	PrepareClass(388) 	-- SY
	--PrepareClass(58) 	-- Shimakaze
	--PrepareClass(59) 	-- Yamato
	--PrepareClass(60) 	-- Kongo
	--PrepareClass(254) 	-- Nagato	
	PrepareClass(67) 	-- Mogami	
	--PrepareClass(68) 	-- Tone	
	--PrepareClass(69) 	-- Takao
	--PrepareClass(71) 	-- Agano
	PrepareClass(73) 	-- Fubuki
	--PrepareClass(75)	-- Minekaze
	--PrepareClass(93)	-- Type B
	PrepareClass(250)	-- Bismarck
	--PrepareClass(251)	-- Hipper
	PrepareClass(391)	-- Kuma Torpedo
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort903")
end

---- MISSION INIT. ----

function luaInitEscort903(this)
	Mission = this
	Mission.Name = "Clash of Carriers"
	
	SetSimplifiedReconMultiplier(2.0)

	Mission.CustomLog = true
	SETLOG(this, true)

	Mission.Multiplayer = true
	
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")

	-- OBJ.
	
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				--["Text"] = "Escort the USS Lexington!",
				["Text"] = "Sink the Japanese carriers!", --Destroy the Japanese planes!
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "The enemy carriers are sinking!",
				--["TextFailed"] = "The USS Lexington has been destoryed",
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
				--["Text"] = "Destroy the USS Lexington at all costs!",
				["Text"] = "Sink the US carriers!", --Protect the level bombers!
				--["TextCompleted"] = "The enemy Carrier has been destoryed",
				["TextCompleted"] = "The enemy carriers are sinking!",
				--["TextFailed"] = "Our forces have been neutralized",
				["TextFailed"] = "Our carriers are sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
			[3] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "protectus",
				--["Text"] = "Escort the USS Lexington!",
				["Text"] = "Protect your carriers!", --Destroy the Japanese planes!
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "",
				--["TextFailed"] = "The USS Lexington has been destoryed",
				["TextFailed"] = "Our carriers are sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[4] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "protectijn",
				--["Text"] = "Escort the USS Lexington!",
				["Text"] = "Protect your carriers!", --Destroy the Japanese planes!
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "",
				--["TextFailed"] = "The USS Lexington has been destoryed",
				["TextFailed"] = "Our carriers are sinking!",
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
				["ID"] = "trans_us",
				--["Text"] = "Escort the USS Lexington!",
				["Text"] = "Sink the Japanese cargo ships!", --Destroy the Japanese planes!
				--["TextCompleted"] = "The Japanese forces have been neutralized!",
				["TextCompleted"] = "The enemy cargo ships are sinking!",
				--["TextFailed"] = "The USS Lexington has been destoryed",
				["TextFailed"] = "The enemy transports escaped!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "trans_ijn",
				--["Text"] = "Destroy the USS Lexington at all costs!",
				["Text"] = "Sink the US cargo ships!", --Protect the level bombers!
				--["TextCompleted"] = "The enemy Carrier has been destoryed",
				["TextCompleted"] = "The enemy cargo ships are sinking!",
				--["TextFailed"] = "Our forces have been neutralized",
				["TextFailed"] = "The enemy transports escaped!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
	}
	
	Mission.PlayersTable = GetPlayerDetails()

	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
	
	-- MUSIC
	
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	Music_Control_SetLevel(MUSIC_TENSION)
	
	-- ALL PLANE TYPES
	
	Mission.TypeFairey = 109
	Mission.TypeHurricane = 134
	Mission.TypeJ2M = 151
	Mission.TypeB17 = 116
	Mission.TypeB25 = 118
	Mission.TypeSB2C = 38
	Mission.TypeSBD = 108
	Mission.TypeTBF = 113
	Mission.TypeP38 = 104
	Mission.TypeF6F = 26
	Mission.TypeG4M = 167
	Mission.TypeG4MOhka = 32
	Mission.TypeG3M = 166
	Mission.TypeJ1N1 = 152
	Mission.TypeH6K = 174
	Mission.TypeF1M = 171
	Mission.TypeA6M = 150
	Mission.TypeB6N = 163
	Mission.TypeD4Y = 159
	Mission.TypeB5N = 162
	Mission.TypeD3A = 158
	
	-- IND. CVs
	
	Mission.USCV1 = FindEntity("Yorktown-class 01")
	Mission.USCV2 = FindEntity("Yorktown-class 02")
	Mission.USCV3 = FindEntity("Essex-class 01")
	Mission.USCV4 = FindEntity("Essex-class 02")
	--[[Mission.USCV5 = FindEntity("Bogue-class Escort Carrier 01")
	Mission.USCV6 = FindEntity("Bogue-class Escort Carrier 02")
	Mission.USCV7 = FindEntity("Bogue-class Escort Carrier 03")
	Mission.USCV8 = FindEntity("Bogue-class Escort Carrier 04")]]
	
	Mission.IJNCV1 = FindEntity("Zuikaku-class 01")
	Mission.IJNCV2 = FindEntity("Soryu-class 01")
	Mission.IJNCV3 = FindEntity("Akagi-class 01")
	Mission.IJNCV4 = FindEntity("Kaga-class 01")
	--[[Mission.IJNCV5 = FindEntity("Zuiho-class 01")
	Mission.IJNCV6 = FindEntity("Zuiho-class 02")
	Mission.IJNCV7 = FindEntity("Zuiho-class 03")
	Mission.IJNCV8 = FindEntity("Zuiho-class 04")]]

	---- SPAWNS ----
	
	-- US
	
	Mission.SpawnUS1 = FindEntity("US_Spawn1")
	Mission.SpawnUS2 = FindEntity("US_Spawn2")
	Mission.SpawnUS3 = FindEntity("US_Spawn3")
	Mission.SpawnUS4 = FindEntity("US_Spawn4")
	Mission.SpawnUS5 = FindEntity("US_Spawn5")
	Mission.SpawnUS6 = FindEntity("US_Spawn6")
	Mission.SpawnUS7 = FindEntity("US_Spawn7")
	Mission.SpawnUS8 = FindEntity("US_Spawn8")
	
	-- IJN
	
	Mission.SpawnIJN1 = FindEntity("IJN_Spawn1")
	Mission.SpawnIJN2 = FindEntity("IJN_Spawn2")
	Mission.SpawnIJN3 = FindEntity("IJN_Spawn3")
	Mission.SpawnIJN4 = FindEntity("IJN_Spawn4")
	Mission.SpawnIJN5 = FindEntity("IJN_Spawn5")
	Mission.SpawnIJN6 = FindEntity("IJN_Spawn6")
	Mission.SpawnIJN7 = FindEntity("IJN_Spawn7")
	Mission.SpawnIJN8 = FindEntity("IJN_Spawn8")
	
	-- ESCORTS
	
	Mission.Escorts = {}
		table.insert(Mission.Escorts, FindEntity("CVEscort_1"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_2"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_3"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_4"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_5"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_6"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_7"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_8"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_9"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_10"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_11"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_12"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_13"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_14"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_15"))
		table.insert(Mission.Escorts, FindEntity("CVEscort_16"))
	
	Mission.EscortsNames = {}
		table.insert(Mission.EscortsNames, "USS Wallace L. Lind")
		table.insert(Mission.EscortsNames, "USS Strong")
		table.insert(Mission.EscortsNames, "USS Mansfield")
		table.insert(Mission.EscortsNames, "USS Walke")
		table.insert(Mission.EscortsNames, "Teruzuki")
		table.insert(Mission.EscortsNames, "Kiyotsuki ")
		table.insert(Mission.EscortsNames, "Shimotsuki")
		table.insert(Mission.EscortsNames, "Otsuki")
		table.insert(Mission.EscortsNames, "USS James C. Owens")
		table.insert(Mission.EscortsNames, "USS Zellars")
		table.insert(Mission.EscortsNames, "USS Douglas H. Fox")
		table.insert(Mission.EscortsNames, "USS Robert K. Huntington")
		table.insert(Mission.EscortsNames, "Natsuzuki")
		table.insert(Mission.EscortsNames, "Yaegumo ")
		table.insert(Mission.EscortsNames, "Yukigumo")
		table.insert(Mission.EscortsNames, "Kochi")
	
	for idx,unit in pairs(Mission.Escorts) do
		SetGuiName(unit, Mission.EscortsNames[idx])
		--SetShipMaxSpeed(unit, 3)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
	end
	
	-- NAVS
	
	Mission.Center = FindEntity("Center")
	
	Mission.USPath1 = FindEntity("USCV1Nav1")
	Mission.USPath2 = FindEntity("USCV2Nav1")
	Mission.USPath0 = FindEntity("USCV0Nav1")
	
	Mission.IJNPath1 = FindEntity("IJNCV1Nav1")
	Mission.IJNPath2 = FindEntity("IJNCV2Nav1")
	Mission.IJNPath0 = FindEntity("IJNCV0Nav1")
	
	Mission.USConvoyNav1 = FindEntity("USConvoyNav1")
	Mission.USConvoyNav2 = FindEntity("USConvoyNav2")
	Mission.USConvoyNav3 = FindEntity("USConvoyNav3")
	Mission.USConvoyNav4 = FindEntity("USConvoyNav4")
	Mission.USConvoyNav5 = FindEntity("USConvoyNav5")

	Mission.IJNConvoyNav1 = FindEntity("IJNConvoyNav1")
	Mission.IJNConvoyNav2 = FindEntity("IJNConvoyNav2")
	Mission.IJNConvoyNav3 = FindEntity("IJNConvoyNav3")
	Mission.IJNConvoyNav4 = FindEntity("IJNConvoyNav4")
	Mission.IJNConvoyNav5 = FindEntity("IJNConvoyNav5")
	
	Mission.HermesNav = FindEntity("HermesNav")
	Mission.HiryuNav = FindEntity("HiryuNav")
	
	Mission.USDDsNav = FindEntity("USDDsNav")
	Mission.IJNDDsNav = FindEntity("IJNDDsNav")
	
	Mission.EndStat = 0
	
	--[[Mission.USCVPoss = {}
		table.insert(Mission.USCVPoss, FindEntity("Zuikaku-class 01"))
		table.insert(Mission.USCVPoss, FindEntity("Soryu-class 01"))
		table.insert(Mission.USCVPoss, FindEntity("Akagi-class 01"))
		table.insert(Mission.USCVPoss, FindEntity("Kaga-class 01"))
		table.insert(Mission.USCVPoss, FindEntity("Zuiho"))
		table.insert(Mission.USCVPoss, FindEntity("Zuiho"))
		table.insert(Mission.USCVPoss, FindEntity("Zuiho"))
		table.insert(Mission.USCVPoss, FindEntity("Zuiho"))]]
	
	-- SHIP GROUPS
	
	Mission.USShips = {}
		table.insert(Mission.USShips, FindEntity("Yorktown-class 01"))
		table.insert(Mission.USShips, FindEntity("Yorktown-class 02"))
		table.insert(Mission.USShips, FindEntity("Essex-class 01"))
		table.insert(Mission.USShips, FindEntity("Essex-class 02"))
		table.insert(Mission.USShips, FindEntity("Bogue-class Escort Carrier 01"))
		table.insert(Mission.USShips, FindEntity("Bogue-class Escort Carrier 02"))
		table.insert(Mission.USShips, FindEntity("Bogue-class Escort Carrier 03"))
		table.insert(Mission.USShips, FindEntity("Bogue-class Escort Carrier 04"))
		table.insert(Mission.USShips, FindEntity("CVEscort_1"))
		table.insert(Mission.USShips, FindEntity("CVEscort_2"))
		table.insert(Mission.USShips, FindEntity("CVEscort_3"))
		table.insert(Mission.USShips, FindEntity("CVEscort_4"))
		table.insert(Mission.USShips, FindEntity("CVEscort_9"))
		table.insert(Mission.USShips, FindEntity("CVEscort_10"))
		table.insert(Mission.USShips, FindEntity("CVEscort_11"))
		table.insert(Mission.USShips, FindEntity("CVEscort_12"))
	
	Mission.IJNShips = {}
		table.insert(Mission.IJNShips, FindEntity("Zuikaku-class 01"))
		table.insert(Mission.IJNShips, FindEntity("Soryu-class 01"))
		table.insert(Mission.IJNShips, FindEntity("Akagi-class 01"))
		table.insert(Mission.IJNShips, FindEntity("Kaga-class 01"))
		table.insert(Mission.IJNShips, FindEntity("Zuiho-class 01"))
		table.insert(Mission.IJNShips, FindEntity("Zuiho-class 02"))
		table.insert(Mission.IJNShips, FindEntity("Zuiho-class 03"))
		table.insert(Mission.IJNShips, FindEntity("Zuiho-class 04"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_5"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_6"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_7"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_8"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_13"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_14"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_15"))
		table.insert(Mission.IJNShips, FindEntity("CVEscort_16"))
		
	-- CV GROUPS
	
	Mission.USCVs = {}
		table.insert(Mission.USCVs, FindEntity("Yorktown-class 01"))
		table.insert(Mission.USCVs, FindEntity("Yorktown-class 02"))
		table.insert(Mission.USCVs, FindEntity("Essex-class 01"))
		table.insert(Mission.USCVs, FindEntity("Essex-class 02"))
		--[[table.insert(Mission.USCVs, FindEntity("Bogue-class Escort Carrier 01"))
		table.insert(Mission.USCVs, FindEntity("Bogue-class Escort Carrier 02"))
		table.insert(Mission.USCVs, FindEntity("Bogue-class Escort Carrier 03"))
		table.insert(Mission.USCVs, FindEntity("Bogue-class Escort Carrier 04"))]]
	
	Mission.IJNCVs = {}
		table.insert(Mission.IJNCVs, FindEntity("Zuikaku-class 01"))
		table.insert(Mission.IJNCVs, FindEntity("Soryu-class 01"))
		table.insert(Mission.IJNCVs, FindEntity("Akagi-class 01"))
		table.insert(Mission.IJNCVs, FindEntity("Kaga-class 01"))
		--[[table.insert(Mission.IJNCVs, FindEntity("Zuiho-class 01"))
		table.insert(Mission.IJNCVs, FindEntity("Zuiho-class 02"))
		table.insert(Mission.IJNCVs, FindEntity("Zuiho-class 03"))
		table.insert(Mission.IJNCVs, FindEntity("Zuiho-class 04"))]]
	
	Mission.USCVGrp = {}
		table.insert(Mission.USCVGrp, FindEntity("Yorktown-class 01"))
		table.insert(Mission.USCVGrp, FindEntity("Yorktown-class 02"))
		table.insert(Mission.USCVGrp, FindEntity("Essex-class 01"))
		table.insert(Mission.USCVGrp, FindEntity("Essex-class 02"))
		--[[table.insert(Mission.USCVGrp, FindEntity("Bogue-class Escort Carrier 01"))
		table.insert(Mission.USCVGrp, FindEntity("Bogue-class Escort Carrier 02"))
		table.insert(Mission.USCVGrp, FindEntity("Bogue-class Escort Carrier 03"))
		table.insert(Mission.USCVGrp, FindEntity("Bogue-class Escort Carrier 04"))]]
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_1"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_2"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_3"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_4"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_9"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_10"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_11"))
		table.insert(Mission.USCVGrp, FindEntity("CVEscort_12"))
	
	Mission.IJNCVGrp = {}
		table.insert(Mission.IJNCVGrp, FindEntity("Zuikaku-class 01"))
		table.insert(Mission.IJNCVGrp, FindEntity("Soryu-class 01"))
		table.insert(Mission.IJNCVGrp, FindEntity("Akagi-class 01"))
		table.insert(Mission.IJNCVGrp, FindEntity("Kaga-class 01"))
		--[[table.insert(Mission.IJNCVGrp, FindEntity("Zuiho-class 01"))
		table.insert(Mission.IJNCVGrp, FindEntity("Zuiho-class 02"))
		table.insert(Mission.IJNCVGrp, FindEntity("Zuiho-class 03"))
		table.insert(Mission.IJNCVGrp, FindEntity("Zuiho-class 04"))]]
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_5"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_6"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_7"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_8"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_13"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_14"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_15"))
		table.insert(Mission.IJNCVGrp, FindEntity("CVEscort_16"))
	
	-- CV NAMES
	
	Mission.USCVNames = {}
		table.insert(Mission.USCVNames, "USS Yorktown")
		table.insert(Mission.USCVNames, "USS Enterprise")
		table.insert(Mission.USCVNames, "USS Bunker Hill")
		table.insert(Mission.USCVNames, "USS Intrepid")
		table.insert(Mission.USCVNames, "HMS Rajah")
		table.insert(Mission.USCVNames, "HMS Smiter")
		table.insert(Mission.USCVNames, "USS Bismarck Sea")
		table.insert(Mission.USCVNames, "USS Lunga Point")
		
	Mission.IJNCVNames = {}
		table.insert(Mission.IJNCVNames, "Zuikaku")
		table.insert(Mission.IJNCVNames, "Shokaku")
		table.insert(Mission.IJNCVNames, "Akagi")
		table.insert(Mission.IJNCVNames, "Kaga")
		table.insert(Mission.IJNCVNames, "Zuiho")
		table.insert(Mission.IJNCVNames, "Hiyo")
		table.insert(Mission.IJNCVNames, "Shoho")
		table.insert(Mission.IJNCVNames, "Ryujo")
	
	-- PLANE GRP.
	
	Mission.USAIPlanes = {}
	Mission.IJNAIPlanes = {}
	
	Mission.USReinAIPlanes = {}
	Mission.IJNReinAIPlanes = {}
	
	Mission.USReinShips = {}
	Mission.IJNReinShips = {}
	
	-- VALUE GRP.
	
	Mission.ReinValues = {}
		table.insert(Mission.ReinValues, "One")
		table.insert(Mission.ReinValues, "Two")
		table.insert(Mission.ReinValues, "Three")
		--table.insert(Mission.ReinValues, "Four")
		table.insert(Mission.ReinValues, "Five")
		table.insert(Mission.ReinValues, "Six")
		table.insert(Mission.ReinValues, "Seven")
	
	-- CV INIT FUNC.
	
	for idx,unit in pairs(Mission.USCVs) do
		--JoinFormation(unit, Mission.USCVs[1])
		SetGuiName(unit, Mission.USCVNames[idx])
		--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--SetShipMaxSpeed(unit, 3)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	for idx,unit in pairs(Mission.IJNCVs) do
		--JoinFormation(unit, Mission.IJNCVs[1])
		SetGuiName(unit, Mission.IJNCVNames[idx])
		--SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--SetShipMaxSpeed(unit, 3)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		--RepairEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	for idx,unit in pairs(Mission.USCVGrp) do
		JoinFormation(unit, Mission.USCVGrp[6])
	end
	
	for idx,unit in pairs(Mission.IJNCVGrp) do
		JoinFormation(unit, Mission.IJNCVGrp[6])
	end
	
	-- INIT FUNC.
	
	--SetDeviceReloadEnabled(false)
	
	--ForceEnableInput(IC_OVERLAY_BLUE,false)
	
	luaDelay(luaSpawnIJNCV, 10)
	
	luaDelay(luaSpawnUSCV, 10)
	
	-- REINFORCEMENTS GROUPS INIT.
	
	luaDelay(luaSpawnRein, 600)
	
	luaDelay(luaUS20MinReinSpawn, 22000)
	luaDelay(luaIJN20MinReinSpawn, 22000)
	
	--[[luaDelay(luaUS5MinReinSpawn, 600)
	luaDelay(luaIJN5MinReinSpawn, 600)
	
	luaDelay(luaUS10MinReinSpawn, 1200)
	luaDelay(luaIJN10MinReinSpawn, 1200)
	
	luaDelay(luaUS15MinReinSpawn, 1800)
	luaDelay(luaIJN15MinReinSpawn, 1800)

	luaDelay(luaUS20MinReinSpawn, 2400)
	luaDelay(luaIJN20MinReinSpawn, 2400)
	
	luaDelay(luaUS25MinReinSpawn, 3000)
	luaDelay(luaIJN25MinReinSpawn, 3000)
	
	luaDelay(luaUS30MinReinSpawn, 3600)
	luaDelay(luaIJN30MinReinSpawn, 3600)
	
	luaDelay(luaUS35MinReinSpawn, 4200)
	luaDelay(luaIJN35MinReinSpawn, 4200)]]
	
	--luaUS30MinReinSpawn()
	--luaIJN30MinReinSpawn()
	
	-- TEST
	
	--[[for idx,unit in pairs(Mission.USCVs) do
	SetInvincible(unit, 0.2)
	end
	for idx,unit in pairs(Mission.IJNCVs) do
	SetInvincible(unit, 0.2)
	end]]
	
	--luaDelay(luaUS20MinReinSpawn, 20)
	--luaDelay(luaIJN20MinReinSpawn, 20)
	--luaDelay(luaSpawnRein, 40)
	
	--luaDelay(luaUS10MinReinSpawn, 20)
	
	-- REST
	
	SetThink(this, "luaEscort501_think")

	Scoring_RealPlayTimeRunning(true)
end

---- THINK ----

function luaEscort501_think(this, msg)
	
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	
	---- OBJECTIVES ----
	
	-- US
	
	--[[if luaObj_IsActive("secondary",1) then
	luaUSAddSecObj()
	end]]
	
	luaUSAddMainObj()
	--luaIJNAddMainObj()
	
	-- IJN
	
	--[[if luaObj_IsActive("secondary",2) then
	luaIJNAddSecObj()
	end]]
	
	luaIJNAddMainObj()
	--luaIJNAddSecObj()
	
	---- MUSIC ----
	
	luaCheckMusic()
	
	---- VAR. ----
	
	Mission.USShips = luaRemoveDeadsFromTable(Mission.USShips)
	Mission.IJNShips = luaRemoveDeadsFromTable(Mission.IJNShips)
	
	Mission.USCVsNumber = table.getn(luaRemoveDeadsFromTable(Mission.USCVs))
	Mission.IJNCVsNumber = table.getn(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	---- SPAWNERS & POSs ----
	
	-- US
	
	--[[if not Mission.USCV1.Dead then
	Mission.USCV1Pos = GetPosition(Mission.USCV1)
	end
	if not Mission.USCV2.Dead then
	Mission.USCV2Pos = GetPosition(Mission.USCV2)
	end
	if not Mission.USCV3.Dead then
	Mission.USCV3Pos = GetPosition(Mission.USCV3)
	end
	if not Mission.USCV4.Dead then
	Mission.USCV4Pos = GetPosition(Mission.USCV4)
	end
	if not Mission.USCV5.Dead then
	Mission.USCV5Pos = GetPosition(Mission.USCV5)
	end
	if not Mission.USCV6.Dead then
	Mission.USCV6Pos = GetPosition(Mission.USCV6)
	end
	if not Mission.USCV7.Dead then
	Mission.USCV7Pos = GetPosition(Mission.USCV7)
	end
	if not Mission.USCV8.Dead then
	Mission.USCV8Pos = GetPosition(Mission.USCV8)
	end]]
	
	--[[if not Mission.Escorts[1].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[1], Mission.USPath0)
	
	end
	
	if not Mission.Escorts[2].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[2], Mission.USPath0)
	
	end
	
	if not Mission.Escorts[3].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[3], Mission.USPath0)
	
	end
	
	if not Mission.Escorts[4].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[4], Mission.USPath0)
	
	end]]
	
	--[[if not Mission.USCV1.Dead then
	local posUSYorktown = GetPosition(Mission.USCV1)
	posUSYorktown.y = posUSYorktown.y + 1000
	PutTo(Mission.SpawnUS1, posUSYorktown)
	NavigatorMoveToPos(Mission.USCV1, Mission.USPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS1, u)
	end
	end
	
	if not Mission.USCV2.Dead then
	local posUSEnterprise = GetPosition(Mission.USCV2)
	posUSEnterprise.y = posUSEnterprise.y + 1000
	PutTo(Mission.SpawnUS2, posUSEnterprise)
	NavigatorMoveToPos(Mission.USCV2, Mission.USPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS2, u)
	end
	end
	
	if not Mission.USCV3.Dead then
	local posUSIntrepid = GetPosition(Mission.USCV3)
	posUSIntrepid.y = posUSIntrepid.y + 1000
	PutTo(Mission.SpawnUS3, posUSIntrepid)
	NavigatorMoveToPos(Mission.USCV3, Mission.USPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS3, u)
	end
	end
	
	if not Mission.USCV4.Dead then
	local posUSBunker = GetPosition(Mission.USCV4)
	posUSBunker.y = posUSBunker.y + 1000
	PutTo(Mission.SpawnUS4, posUSBunker)
	NavigatorMoveToPos(Mission.USCV4, Mission.USPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS4, u)
	end
	end
	
	if not Mission.USCV5.Dead then
	local posUSSmiter = GetPosition(Mission.USCV5)
	posUSSmiter.y = posUSSmiter.y + 1000
	PutTo(Mission.SpawnUS5, posUSSmiter)
	NavigatorMoveToPos(Mission.USCV5, Mission.USPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS5, u)
	end
	end
	
	if not Mission.USCV6.Dead then
	local posUSRajah = GetPosition(Mission.USCV6)
	posUSRajah.y = posUSRajah.y + 1000
	PutTo(Mission.SpawnUS6, posUSRajah)
	NavigatorMoveToPos(Mission.USCV6, Mission.USPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS6, u)
	end
	end
	
	if not Mission.USCV7.Dead then
	local posUSLunga = GetPosition(Mission.USCV7)
	posUSLunga.y = posUSLunga.y + 1000
	PutTo(Mission.SpawnUS7, posUSLunga)
	NavigatorMoveToPos(Mission.USCV7, Mission.USPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS7, u)
	end
	end
	
	if not Mission.USCV8.Dead then
	local posUSBismarck = GetPosition(Mission.USCV8)
	posUSBismarck.y = posUSBismarck.y + 1000
	PutTo(Mission.SpawnUS8, posUSBismarck)
	NavigatorMoveToPos(Mission.USCV8, Mission.USPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnUS8, u)
	end
	end]]
	
	--[[if Mission.USRein5Min1 and not Mission.USRein5Min1.Dead then
	
	PilotSetTarget(Mission.USRein5Min1, Mission.IJNCVs)
	PilotSetTarget(Mission.USRein5Min2, Mission.IJNCVs)
	
	end
	
	if Mission.USRein10Min1 and not Mission.USRein10Min1.Dead then
	
	NavigatorAttackMove(Mission.USReinGrp10Min[1], Mission.IJNCVs, {})
	
	end
	
	if Mission.USRein15Min1 and not Mission.USRein15Min1.Dead then
	
	NavigatorMoveToRange(Mission.USReinGrp15Min[1], Mission.Center, {})
	
	end
	
	if Mission.USRein25Min1 and not Mission.USRein25Min1.Dead then
	
	NavigatorAttackMove(Mission.USReinGrp25Min[1], Mission.IJNCVs, {})
	
	end
	
	if Mission.USRein30Min1 and not Mission.USRein30Min1.Dead then
	
	NavigatorAttackMove(Mission.USReinGrp30Min1, Mission.IJNCVs, {})
	
	end
	
	if Mission.USRein30Min2 and not Mission.USRein30Min2.Dead then
	
	PilotSetTarget(Mission.USRein30Min2, Mission.IJNCVs)
	
	end
	
	if Mission.USRein30Min3 and not Mission.USRein30Min3.Dead then
	
	PilotSetTarget(Mission.USRein30Min3, Mission.IJNCVs)
	
	end
	
	if Mission.USRein30Min4 and not Mission.USRein30Min4.Dead then
	
	PilotSetTarget(Mission.USRein30Min4, Mission.IJNCVs)
	
	end
	
	if Mission.USRein35Min1 and not Mission.USRein35Min1.Dead then
	
	NavigatorAttackMove(Mission.USReinGrp35Min[1], Mission.IJNCVs, {})
	
	end
	
	for idx,unit in pairs(Mission.USAIPlanes) do
		local cmd = GetProperty(unit, "unitcommand")
		if cmd ~= "moveto" then
			local trg = luaPickRnd(IJNShips)
			PilotSetTarget(unit, trg)
		end
	end]]
	
	-- IJN
	
	--[[if not Mission.Escorts[5].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[5], Mission.IJNPath0)
	
	end
	
	if not Mission.Escorts[6].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[6], Mission.IJNPath0)
	
	end
	
	if not Mission.Escorts[7].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[7], Mission.IJNPath0)
	
	end
	
	if not Mission.Escorts[8].Dead then
	
	NavigatorMoveToPos(Mission.Escorts[8], Mission.IJNPath0)
	
	end]]
	
	--[[if not Mission.IJNCV1.Dead then
	local posIJNZuikaku = GetPosition(Mission.IJNCV1)
	posIJNZuikaku.y = posIJNZuikaku.y + 1000
	PutTo(Mission.SpawnIJN1, posIJNZuikaku)
	NavigatorMoveToPos(Mission.IJNCV1, Mission.IJNPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN1, u)
	end
	end
	
	if not Mission.IJNCV2.Dead then
	local posIJNShokaku = GetPosition(Mission.IJNCV2)
	posIJNShokaku.y = posIJNShokaku.y + 1000
	PutTo(Mission.SpawnIJN2, posIJNShokaku)
	NavigatorMoveToPos(Mission.IJNCV2, Mission.IJNPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN2, u)
	end
	end
	
	if not Mission.IJNCV3.Dead then
	local posIJNKaga = GetPosition(Mission.IJNCV3)
	posIJNKaga.y = posIJNKaga.y + 1000
	PutTo(Mission.SpawnIJN3, posIJNKaga)
	NavigatorMoveToPos(Mission.IJNCV3, Mission.IJNPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN3, u)
	end
	end
	
	if not Mission.IJNCV4.Dead then
	local posIJNAkagi = GetPosition(Mission.IJNCV4)
	posIJNAkagi.y = posIJNAkagi.y + 1000
	PutTo(Mission.SpawnIJN4, posIJNAkagi)
	NavigatorMoveToPos(Mission.IJNCV4, Mission.IJNPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN4, u)
	end
	end
	
	if not Mission.IJNCV5.Dead then
	local posIJNHiyo = GetPosition(Mission.IJNCV5)
	posIJNHiyo.y = posIJNHiyo.y + 1000
	PutTo(Mission.SpawnIJN5, posIJNHiyo)
	NavigatorMoveToPos(Mission.IJNCV5, Mission.IJNPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN5, u)
	end
	end
	
	if not Mission.IJNCV6.Dead then
	local posIJNZuiho = GetPosition(Mission.IJNCV6)
	posIJNZuiho.y = posIJNZuiho.y + 1000
	PutTo(Mission.SpawnIJN6, posIJNZuiho)
	NavigatorMoveToPos(Mission.IJNCV6, Mission.IJNPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN6, u)
	end
	end
	
	if not Mission.IJNCV7.Dead then
	local posIJNRyujo = GetPosition(Mission.IJNCV7)
	posIJNRyujo.y = posIJNRyujo.y + 1000
	PutTo(Mission.SpawnIJN7, posIJNRyujo)
	NavigatorMoveToPos(Mission.IJNCV7, Mission.IJNPath2)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN7, u)
	end
	end
	
	if not Mission.IJNCV8.Dead then
	local posIJNShoho = GetPosition(Mission.IJNCV8)
	posIJNShoho.y = posIJNShoho.y + 1000
	PutTo(Mission.SpawnIJN8, posIJNShoho)
	NavigatorMoveToPos(Mission.IJNCV8, Mission.IJNPath1)
	else
	for u = 0, 8 do 
	DeactivateSpawnpoint(Mission.SpawnIJN8, u)
	end
	end]]
	
	--[[if Mission.IJNRein5Min1 and not Mission.IJNRein5Min1.Dead then
	
	PilotSetTarget(Mission.IJNRein5Min1, Mission.IJNCVs)
	PilotSetTarget(Mission.IJNRein5Min2, Mission.IJNCVs)
	PilotSetTarget(Mission.IJNRein5Min3, Mission.IJNCVs)
	PilotSetTarget(Mission.IJNRein5Min4, Mission.IJNCVs)
	
	end
	
	if Mission.IJNRein10Min1 and not Mission.IJNRein10Min1.Dead then
	
	NavigatorAttackMove(Mission.IJNReinGrp10Min[1], Mission.IJNCVs, {})
	
	end
	
	if Mission.IJNRein15Min1 and not Mission.IJNRein15Min1.Dead then
	
	NavigatorMoveToRange(Mission.IJNReinGrp15Min[1], Mission.Center, {})
	
	end
	
	if Mission.IJNRein25Min1 and not Mission.IJNRein25Min1.Dead then
	
	NavigatorAttackMove(Mission.IJNReinGrp25Min[1], Mission.IJNCVs, {})
	
	end
	
	if Mission.IJNRein30Min1 and not Mission.IJNRein30Min1.Dead then
	
	NavigatorAttackMove(Mission.IJNRein30Min1, Mission.IJNCVs, {})
	
	end
	
	if Mission.IJNRein30Min2 and not Mission.IJNRein30Min2.Dead then
	
	PilotSetTarget(Mission.IJNRein30Min2, Mission.IJNCVs)
	
	end
	
	if Mission.IJNRein30Min3 and not Mission.IJNRein30Min3.Dead then
	
	PilotSetTarget(Mission.IJNRein30Min3, Mission.IJNCVs)
	
	end
	
	if Mission.IJNRein30Min4 and not Mission.IJNRein30Min4.Dead then
	
	PilotSetTarget(Mission.IJNRein30Min4, Mission.IJNCVs)
	
	end
	
	if Mission.IJNRein35Min1 and not Mission.IJNRein35Min1.Dead then
	
	NavigatorAttackMove(Mission.IJNReinGrp35Min[1], Mission.IJNCVs, {})
	
	end
	
	for idx,unit in pairs(Mission.IJNAIPlanes) do
		PilotSetTarget(unit, Mission.USShips)
	end]]
	
	---- CV PATHS ----
	
	-- US
	
	if Mission.USCVGrp[4] and not Mission.USCVGrp[4].Dead then
		NavigatorMoveOnPath(Mission.USCVGrp[4], FindEntity("USCVPath"), PATH_FM_CIRCLE)
	end
	
	-- IJN
	
	if Mission.IJNCVGrp[4] and not Mission.IJNCVGrp[4].Dead then
		NavigatorMoveOnPath(Mission.IJNCVGrp[4], FindEntity("IJNCVPath"), PATH_FM_CIRCLE)
	end
	
	---- PLANE & REIN. TARGETING ----
	
	-- US
	
	--Mission.USAIPlanes = luaRemoveDeadsFromTable(Mission.USAIPlanes)
	for idx,plane in pairs(Mission.USAIPlanes) do
	
		if not plane.Dead then
			
			local ammo = GetProperty(plane, "ammoType")
			local cmd = GetProperty(plane, "unitcommand")
			
			if ammo ~= 0 then
			
				if luaGetScriptTarget(plane) == nil or luaGetScriptTarget(plane).Dead then
					
					--MissionNarrative("b")
					
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
					
					--MissionNarrative("c")
					
					if trg then
						
						--MissionNarrative("d")
						
						luaSetScriptTarget(plane, trg)
						PilotSetTarget(plane, trg)
					
					elseif trg.Dead or trg == nil then
						
						--MissionNarrative("e")
						
						local trgnew = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
						luaSetScriptTarget(plane, trgnew)
						PilotSetTarget(plane, trgnew)
					
					end
				
				end
			
			elseif ammo == 0 then
				
				if cmd ~= "land" then
					
					--local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
					PilotLand(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
				
				end
				
			end
			
		end
	
	end
	
	for idx,plane in pairs(Mission.USReinAIPlanes) do
	
		if not plane.Dead then
			
			local ammo = GetProperty(plane, "ammoType")
			local cmd = GetProperty(plane, "unitcommand")
			
			if ammo ~= 0 then
			
				if luaGetScriptTarget(plane) == nil or luaGetScriptTarget(plane).Dead then
					
					--MissionNarrative("b")
					
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
					
					--MissionNarrative("c")
					
					if trg then
						
						--MissionNarrative("d")
						
						luaSetScriptTarget(plane, trg)
						PilotSetTarget(plane, trg)
					
					elseif trg.Dead or trg == nil then
						
						--MissionNarrative("e")
						
						local trgnew = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
						luaSetScriptTarget(plane, trgnew)
						PilotSetTarget(plane, trgnew)
					
					end
				
				end
			
			elseif ammo == 0 then
				
				if cmd ~= "retreat" then
					
					PilotRetreat(unit)
				
				end
				
			end
			
		end
	
	end
	
	for idx,unit in pairs(Mission.USReinShips) do
	
		if unit and not unit.Dead then
		
			local leader = GetFormationLeader(unit)
			
			if leader and not leader.Dead then
			
				if luaGetScriptTarget(leader) == nil or luaGetScriptTarget(leader).Dead then
				
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
						
					NavigatorAttackMove(leader, trg)
					luaSetScriptTarget(leader, trg)
				
				end
				
			end
		
		end
	
	end
	
	-- IJN
	
	--Mission.IJNAIPlanes = luaRemoveDeadsFromTable(Mission.IJNAIPlanes)
	for idx,plane in pairs(Mission.IJNAIPlanes) do
	
		if not plane.Dead then
			
			local ammo = GetProperty(plane, "ammoType")
			local cmd = GetProperty(plane, "unitcommand")
			
			if ammo ~= 0 then
			
				if luaGetScriptTarget(plane) == nil or luaGetScriptTarget(plane).Dead then
					
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips))
					
					if trg then
						
						luaSetScriptTarget(plane, trg)
						PilotSetTarget(plane, trg)
					
					elseif trg.Dead or trg == nil then
					
						local trgnew = luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips))
						luaSetScriptTarget(plane, trgnew)
						PilotSetTarget(plane, trgnew)
					
					end
				
				end
			
			elseif ammo == 0 then
			
				if cmd ~= "land" then
					
					--local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
					PilotLand(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
				
				end
				
			end
			
		end
	
	end
	
	for idx,plane in pairs(Mission.IJNReinAIPlanes) do
	
		if not plane.Dead then
			
			local ammo = GetProperty(plane, "ammoType")
			local cmd = GetProperty(plane, "unitcommand")
			
			if ammo ~= 0 then
			
				if luaGetScriptTarget(plane) == nil or luaGetScriptTarget(plane).Dead then
					
					--MissionNarrative("targetin")
					
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
					
					--MissionNarrative("c")
					
					if trg then
						
						--MissionNarrative("d")
						
						luaSetScriptTarget(plane, trg)
						PilotSetTarget(plane, trg)
					
					elseif trg.Dead or trg == nil then
						
						--MissionNarrative("e")
						
						local trgnew = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
						luaSetScriptTarget(plane, trgnew)
						PilotSetTarget(plane, trgnew)
					
					end
				
				end
			
			elseif ammo == 0 then
				
				if cmd ~= "retreat" then
					
					PilotRetreat(unit)
				
				end
				
			end
			
		end
	
	end
	
	for idx,unit in pairs(Mission.IJNReinShips) do
	
		if unit and not unit.Dead then
		
			local leader = GetFormationLeader(unit)
		
			if leader and not leader.Dead then
			
				if luaGetScriptTarget(leader) == nil or luaGetScriptTarget(leader).Dead then
				
					local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
						
					NavigatorAttackMove(leader, trg)
					luaSetScriptTarget(leader, trg)
				
				end
				
			end
		
		end
	
	end
	
	---- TEST ----
	
	--[[if table.getn(luaRemoveDeadsFromTable(Mission.ReinValues)) > 0 then
		MissionNarrative("a")
	end]]
	
	--if Mission.USRein10Min1 and not Mission.USRein10Min1.Dead then
		--Mission.TEST = GetOwner(Mission.USRein10Min1)
	--MissionNarrative("#Mission.Players#")
	--end
	
	--[[if Mission.USRein20Min1 and Mission.IJNRein20Min1 then
	
	luaAddSecObjs()
	
	end]]
	
	--[[if table.getn(luaRemoveDeadsFromTable(Mission.USAIPlanes)) > 0 then
		MissionNarrative("omagad")
	end]]
	
end

---- AI SPAWNERS ----

-- US

function luaSpawnUSCV()
	
	if not Mission.USCV1.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV1)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSB2C,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	luaDelay(luaSpawnUSCV, 400)
	end
	
	if not Mission.USCV2.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV2)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSB2C,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.USCV3.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV3)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.USCV4.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV4)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	--[[if not Mission.USCV5.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV5)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.USCV6.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV6)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.USCV7.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV7)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.USCV8.Dead then
	  	local SpawnCoord = GetPosition(Mission.USCV8)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeSBD,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end]]

end

--[[function luaSpawnUSCVHermes()

	if Mission.USRein15Min1 and not Mission.USRein15Min1.Dead then
	  	local SpawnCoord = GetPosition(Mission.USRein15Min1)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeHurricane,
				["Name"] = "Hwaker Hurricane",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeFairey,
				["Name"] = "Fairey Swordfish",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCVHermes",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 400)
	end
	
	if Mission.USRein15Min2 and not Mission.USRein15Min2.Dead then
	  	local SpawnCoord = GetPosition(Mission.USRein15Min2)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeHurricane,
				["Name"] = "Hwaker Hurricane",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeFairey,
				["Name"] = "Fairey Swordfish",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaUSAIPlanesSpawnedCVHermes",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	luaDelay(luaSpawnUSCVHermes, 300)
	end

end]]

-- IJN

function luaSpawnIJNCV()
	
	if not Mission.IJNCV1.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV1)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB6N,
				["Name"] = "B6N Jill",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD4Y,
				["Name"] = "D4Y Judy",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	luaDelay(luaSpawnIJNCV, 400)
	end
	
	if not Mission.IJNCV2.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV2)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB6N,
				["Name"] = "B6N Jill",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD4Y,
				["Name"] = "D4Y Judy",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.IJNCV3.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV3)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.IJNCV4.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV4)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end

	--[[if not Mission.IJNCV5.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV5)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.IJNCV6.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV6)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.IJNCV7.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV7)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end
	
	if not Mission.IJNCV8.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNCV8)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeD3A,
				["Name"] = "D3A Val",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCV",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	--luaDelay(luaSpawnUSCV, 180)
	end]]

end

--[[function luaSpawnIJNCVUnryu()

	if Mission.IJNRein15Min1 and not Mission.IJNRein15Min1.Dead then
	  	local SpawnCoord = GetPosition(Mission.IJNRein15Min1)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeJ2M,
				["Name"] = "B6N Jill",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeB5N,
				["Name"] = "B5N Kate",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaIJNAIPlanesSpawnedCVUnryu",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	luaDelay(luaSpawnIJNCVUnryu, 150)
	end

end]]

---- TEST FUNCT. ----

function luaTEST()

	

end

---- AI PLANE CALLBACKS ----

-- US

function luaUSAIPlanesSpawnedCV(unit1,unit2)
	
	-- ROLE SETTING
	
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	--[[SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit4, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit5, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit6, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit7, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit8, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit9, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit10, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit11, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit12, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit13, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit14, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit15, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit16, EROLF_ALL, PLAYER_AI)]]
	
	-- FACING
	
	EntityTurnToPosition(unit1, Mission.Center)
	EntityTurnToPosition(unit2, Mission.Center)
	--[[EntityTurnToPosition(unit3, Mission.Center)
	EntityTurnToPosition(unit4, Mission.Center)
	EntityTurnToPosition(unit5, Mission.Center)
	EntityTurnToPosition(unit6, Mission.Center)
	EntityTurnToPosition(unit7, Mission.Center)
	EntityTurnToPosition(unit8, Mission.Center)
	EntityTurnToPosition(unit9, Mission.Center)
	EntityTurnToPosition(unit10, Mission.Center)
	EntityTurnToPosition(unit11, Mission.Center)
	EntityTurnToPosition(unit12, Mission.Center)
	EntityTurnToPosition(unit13, Mission.Center)
	EntityTurnToPosition(unit14, Mission.Center)
	EntityTurnToPosition(unit15, Mission.Center)
	EntityTurnToPosition(unit16, Mission.Center)]]
	
	-- MOVING & TARGETING
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
	local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips))
	
	PilotSetTarget(unit1, trg)
	PilotSetTarget(unit2, trg2)
	
	luaSetScriptTarget(unit1, trg)
	luaSetScriptTarget(unit2, trg2)
	
	--UnitSetFireStance(unit1, 2)
	--UnitSetFireStance(unit2, 2)
	
	--PilotMoveToRange(unit1, luaPickRnd(Mission.IJNCVs))
	--PilotMoveToRange(unit2, luaPickRnd(Mission.IJNCVs))
	
	--[[PilotMoveToRange(unit3, Mission.IJNCVs)
	PilotMoveToRange(unit4, Mission.IJNCVs)
	PilotMoveToRange(unit5, Mission.IJNCVs)
	PilotMoveToRange(unit6, Mission.IJNCVs)
	PilotMoveToRange(unit7, Mission.IJNCVs)
	PilotMoveToRange(unit8, Mission.IJNCVs)
	PilotMoveToRange(unit9, Mission.IJNCVs)
	PilotMoveToRange(unit10, Mission.IJNCVs)
	PilotMoveToRange(unit11, Mission.IJNCVs)
	PilotMoveToRange(unit12, Mission.IJNCVs)
	PilotMoveToRange(unit13, Mission.IJNCVs)
	PilotMoveToRange(unit14, Mission.IJNCVs)
	PilotMoveToRange(unit15, Mission.IJNCVs)
	PilotMoveToRange(unit16, Mission.IJNCVs)]]
	
	-- TESTING PURPOSES
	
	--SetInvincible(unit1, 0.5)
	--SetInvincible(unit2, 0.5)
	
	-- GROUP INSERTING
	
	table.insert(Mission.USAIPlanes, unit1)
	table.insert(Mission.USAIPlanes, unit2)

end

--[[function luaUSAIPlanesSpawnedCVHermes(unit1,unit2)
	
	-- ROLE SETTING
	
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	
	-- FACING
	
	EntityTurnToPosition(unit1, Mission.Center)
	EntityTurnToPosition(unit2, Mission.Center)
	
	-- MOVING & TARGETING

	PilotMoveToRange(unit1, Mission.Center)
	UnitSetFireStance(unit1, 2)
	PilotSetTarget(unit2, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNShips)))
	--UnitSetFireStance(unit2, 2)

	-- TESTING PURPOSES
	
	--SetInvincible(unit1, 0.5)
	--SetInvincible(unit2, 0.5)
	
	-- GROUP INSERTING
	
	--table.insert(Mission.USAIPlanes, unit1)
	table.insert(Mission.USAIPlanes, unit2)

end]]

-- IJN

function luaIJNAIPlanesSpawnedCV(unit1,unit2)
	
	-- ROLE SETTING
	
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	--[[SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit4, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit5, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit6, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit7, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit8, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit9, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit10, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit11, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit12, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit13, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit14, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit15, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit16, EROLF_ALL, PLAYER_AI)]]
	
	-- FACING
	
	EntityTurnToPosition(unit1, Mission.Center)
	EntityTurnToPosition(unit2, Mission.Center)
	--[[EntityTurnToPosition(unit3, Mission.Center)
	EntityTurnToPosition(unit4, Mission.Center)
	EntityTurnToPosition(unit5, Mission.Center)
	EntityTurnToPosition(unit6, Mission.Center)
	EntityTurnToPosition(unit7, Mission.Center)
	EntityTurnToPosition(unit8, Mission.Center)
	EntityTurnToPosition(unit9, Mission.Center)
	EntityTurnToPosition(unit10, Mission.Center)
	EntityTurnToPosition(unit11, Mission.Center)
	EntityTurnToPosition(unit12, Mission.Center)
	EntityTurnToPosition(unit13, Mission.Center)
	EntityTurnToPosition(unit14, Mission.Center)
	EntityTurnToPosition(unit15, Mission.Center)
	EntityTurnToPosition(unit16, Mission.Center)]]
	
	-- MOVING & TARGETING
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips))
	local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips))
	
	PilotSetTarget(unit1, trg)
	PilotSetTarget(unit2, trg2)
	
	luaSetScriptTarget(unit1, trg)
	luaSetScriptTarget(unit2, trg2)
	
	--UnitSetFireStance(unit1, 2)
	--UnitSetFireStance(unit2, 2)
	
	-- TESTING PURPOSES
	
	--SetInvincible(unit1, 0.5)
	--SetInvincible(unit2, 0.5)
	
	-- GROUP INSERTING
	
	table.insert(Mission.IJNAIPlanes, unit1)
	table.insert(Mission.IJNAIPlanes, unit2)

end

--[[function luaIJNAIPlanesSpawnedCVUnryu(unit1,unit2)
	
	-- ROLE SETTING
	
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	
	-- FACING
	
	EntityTurnToPosition(unit1, Mission.Center)
	EntityTurnToPosition(unit2, Mission.Center)
	
	-- MOVING & TARGETING

	PilotMoveToRange(unit1, Mission.Center)
	UnitSetFireStance(unit1, 2)
	PilotSetTarget(unit2, luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips)))
	--UnitSetFireStance(unit2, 2)

	-- TESTING PURPOSES
	
	--SetInvincible(unit1, 0.5)
	--SetInvincible(unit2, 0.5)
	
	-- GROUP INSERTING
	
	--table.insert(Mission.IJNAIPlanes, unit1)
	table.insert(Mission.IJNAIPlanes, unit2)

end]]

---- OBJECTIVES ----

function luaCheckConvoys()

	if luaObj_IsActive("secondary",1) then
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNReinGrp20MinCargos)) == 0 then
	luaObj_Completed("secondary",1,true)
	end
	--[[local leader = luaPickRnd(Mission.USReinGrp20Min)
	if luaGetDistance(leader, Mission.USConvoyNav3) < 2000 then
	luaObj_Failed("secondary",1,nil,true)
	for idx,unit in pairs(Mission.USReinGrp20Min) do
	if not Mission.unit.Dead then
	SetDeadMeat(unit)
	end
	end
	end]]
	end
	
	if luaObj_IsActive("secondary",2) then
	if table.getn(luaRemoveDeadsFromTable(Mission.USReinGrp20MinCargos)) == 0 then
	luaObj_Completed("secondary",2,true)
	end
	--[[local leader = luaPickRnd(Mission.IJNReinGrp20Min)
	if luaGetDistance(leader, Mission.IJNConvoyNav3) < 2000 then
	luaObj_Failed("secondary",2,nil,true)
	for idx,unit in pairs(Mission.IJNReinGrp20Min) do
	if not Mission.unit.Dead then
	SetDeadMeat(unit)
	end
	end
	end]]
	end
	
	luaDelay(luaCheckConvoys, 25)
	
end

-- US

function luaUSAddMainObj()

	if not luaObj_IsActive("primary",1) then
		luaObj_Add("primary",1,Mission.IJNCVs)
		--DisplayUnitHP(1,(Mission.USCVs), "US carrier status")
		luaObj_Add("primary",3,Mission.USCVs)
	--[[if luaObj_IsActive("primary",1) then
		DisplayScores(1,0,"Sink all Japanese carriers!","")
	end]]
	else
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNCVs)) == 0 then
	if Mission.EndStat == 0 then
	Mission.EndStat = 1
	luaObj_Completed("primary",1,true)
	luaObj_Completed("primary",3,true)
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)), "", nil, nil, nil, PARTY_ALLIED)
	end
	end
	if table.getn(luaRemoveDeadsFromTable(Mission.IJNCVs)) == 2 and not Mission.abc then
	MissionNarrative("Half of the Japanese carriers have been sunk!")
	Mission.abc = true
	end
	end

end

function luaUSAddSecObj()

	if not luaObj_IsActive("secondary",1) then
	luaObj_Add("secondary",1,Mission.IJNReinGrp20MinCargos)
	luaCheckConvoys()
	--[[for idx,unit in pairs(Mission.IJNReinGrp20MinCargos) do
	luaObj_AddUnit("secondary",1,unit)
	end]]
	end
end

-- IJN

function luaIJNAddMainObj()

	if not luaObj_IsActive("primary",2) then
	luaObj_Add("primary",2,Mission.USCVs)
	--DisplayUnitHP(2,(Mission.IJNCVs), "Japanese carrier status")
	luaObj_Add("primary",4)
	for idx,unit in pairs(Mission.IJNCVs) do
	luaObj_AddUnit("primary",4,unit)
	end
	--[[if luaObj_IsActive("primary",2) then
		DisplayScores(2,0,"Sink all American carriers!","")
	end]]
	else
	if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 0 then
	if Mission.EndStat == 0 then
	Mission.EndStat = 1
	luaObj_Completed("primary",2,true)
	luaObj_Completed("primary",4,true)
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs)), "", nil, nil, nil, PARTY_JAPANESE)
	end
	end
	if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 2 and not Mission.bcd then
	MissionNarrative("Half of the American carriers have been sunk!")
	Mission.bcd = true
	end
	end

end

function luaIJNAddSecObj()

	if not luaObj_IsActive("secondary",2) then
	luaObj_Add("secondary",2,Mission.USReinGrp20MinCargos)
	luaCheckConvoys()
	end

end

---- REINFORCEMENT GROUPS ----

function luaSpawnRein()

	--local reinvalue = random(1,2,3,4,5,6,7)
	local reinvalue = luaPickRnd(Mission.ReinValues)
	
	if reinvalue == "One" then
	
		table.remove(Mission.ReinValues, 1)
		
		luaUS5MinReinSpawn()
		luaIJN5MinReinSpawn()
		
	elseif reinvalue == "Two" then
	
		table.remove(Mission.ReinValues, 2)
		
		luaUS10MinReinSpawn()
		luaIJN10MinReinSpawn()
		
	elseif reinvalue == "Three" then
	
		table.remove(Mission.ReinValues, 3)
		
		luaUS15MinReinSpawn()
		luaIJN15MinReinSpawn()
		
	--[[elseif reinvalue == "Four" then
	
		table.remove(Mission.ReinValues, 4)
		
		luaUS20MinReinSpawn()
		luaIJN20MinReinSpawn()]]
		
	elseif reinvalue == "Five" then
	
		table.remove(Mission.ReinValues, 5)
		
		luaUS25MinReinSpawn()
		luaIJN25MinReinSpawn()
		
	elseif reinvalue == "Six" then
	
		table.remove(Mission.ReinValues, 6)
		
		luaUS30MinReinSpawn()
		luaIJN30MinReinSpawn()
		
	elseif reinvalue == "Seven" then
	
		table.remove(Mission.ReinValues, 7)
		
		luaUS35MinReinSpawn()
		luaIJN35MinReinSpawn()
	
	end
	
	if table.getn(Mission.ReinValues) > 0 then
		luaDelay(luaSpawnRein, 600)
	end
	
end

-- US

function luaUS5MinReinSpawn()

	Mission.USRein5Min1 = GenerateObject("USRein_Min5_1")
	Mission.USRein5Min2 = GenerateObject("USRein_Min5_2")

	EntityTurnToPosition(Mission.USRein5Min1, Mission.Center)
	EntityTurnToPosition(Mission.USRein5Min2, Mission.Center)
	
	--SetForcedReconLevel(Mission.USRein5Min1, 2, PARTY_JAPANESE)
	--SetForcedReconLevel(Mission.USRein5Min2, 2, PARTY_JAPANESE)
	
	local trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	PilotSetTarget(Mission.USRein5Min1, trg1)
	PilotSetTarget(Mission.USRein5Min2, trg2)
	
	luaSetScriptTarget(Mission.USRein5Min1, trg1)
	luaSetScriptTarget(Mission.USRein5Min2, trg2)
	
	--UnitSetFireStance(Mission.USRein5Min1, 2)
	--UnitSetFireStance(Mission.USRein5Min2, 2)
	
	table.insert(Mission.USReinAIPlanes, Mission.USRein5Min1)
	table.insert(Mission.USReinAIPlanes, Mission.USRein5Min2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			--for idx,unit in pairs(Mission.USReinGrp10Min) do
				if Mission.USRein5Min1 and not Mission.USRein5Min1.Dead then
					local unitpos = GetPosition(Mission.USRein5Min1)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 12000
					PutTo(Mission.USRein5Min1, unitpos)
				end
				if Mission.USRein5Min2 and not Mission.USRein5Min2.Dead then
					local unitpos = GetPosition(Mission.USRein5Min2)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 12000
					PutTo(Mission.USRein5Min2, unitpos)
				end
			--end
		end
	end
	
	MissionNarrative("Reinforcements are here!")
	
end

function luaUS10MinReinSpawn()

	Mission.USRein10Min1 = GenerateObject("USRein_Min10_1")
	Mission.USRein10Min2 = GenerateObject("USRein_Min10_2")
	Mission.USRein10Min3 = GenerateObject("USRein_Min10_3")
	Mission.USRein10Min4 = GenerateObject("USRein_Min10_4")
	Mission.USRein10Min5 = GenerateObject("USRein_Min10_5")
	
	Mission.USReinGrp10Min = {}
		table.insert(Mission.USReinGrp10Min, FindEntity("USRein_Min10_1"))
		table.insert(Mission.USReinGrp10Min, FindEntity("USRein_Min10_2"))
		table.insert(Mission.USReinGrp10Min, FindEntity("USRein_Min10_3"))
		table.insert(Mission.USReinGrp10Min, FindEntity("USRein_Min10_4"))
		table.insert(Mission.USReinGrp10Min, FindEntity("USRein_Min10_5"))
	
	Mission.USReinGrp10MinNames = {}
		table.insert(Mission.USReinGrp10MinNames, {"USS New Hampshire", 25})
		table.insert(Mission.USReinGrp10MinNames, {"USS Alaska", 1})
		table.insert(Mission.USReinGrp10MinNames, {"USS Meredith", 434})
		table.insert(Mission.USReinGrp10MinNames, {"USS De Haven", 727})
		table.insert(Mission.USReinGrp10MinNames, {"USS Lofberg", 759})
	
	for idx,unit in pairs(Mission.USReinGrp10Min) do
		JoinFormation(unit, Mission.USReinGrp10Min[1])
		SetGuiName(unit, Mission.USReinGrp10MinNames[idx][1])
		if Mission.USReinGrp10MinNames[idx][2] then
			SetNumbering(unit, Mission.USReinGrp10MinNames[idx][2])
		end
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		--UnitSetFireStance(unit, 2)
	end
	
	table.insert(Mission.USShips, FindEntity("USRein_Min10_1"))
	table.insert(Mission.USShips, FindEntity("USRein_Min10_2"))
	table.insert(Mission.USShips, FindEntity("USRein_Min10_3"))
	table.insert(Mission.USShips, FindEntity("USRein_Min10_4"))
	table.insert(Mission.USShips, FindEntity("USRein_Min10_5"))
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.USReinGrp10Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 12000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if Mission.USReinGrp10Min[1] and not Mission.USReinGrp10Min[1].Dead then
		NavigatorAttackMove(Mission.USReinGrp10Min[1], trg)
		luaSetScriptTarget(Mission.USReinGrp10Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.USReinGrp10Min) do
		table.insert(Mission.USReinShips, unit)
	end
	
	MissionNarrative("Reinforcements are here!")
	
end

function luaUS15MinReinSpawn()

	Mission.USRein15Min1 = GenerateObject("USRein_Min15_1")
	Mission.USRein15Min2 = GenerateObject("USRein_Min15_2")
	Mission.USRein15Min3 = GenerateObject("USRein_Min15_3")
	Mission.USRein15Min4 = GenerateObject("USRein_Min15_4")
	Mission.USRein15Min5 = GenerateObject("USRein_Min15_5")
	Mission.USRein15Min6 = GenerateObject("USRein_Min15_6")
	Mission.USRein15Min7 = GenerateObject("USRein_Min15_7")
	
	Mission.USReinGrp15Min = {}
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_1"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_2"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_3"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_4"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_5"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_6"))
		table.insert(Mission.USReinGrp15Min, FindEntity("USRein_Min15_7"))
	
	Mission.USReinGrp15MinNames = {}
		table.insert(Mission.USReinGrp10MinNames, {"HMS Hermes", 95})
		table.insert(Mission.USReinGrp10MinNames, {"HMS Eagle", 5})
		table.insert(Mission.USReinGrp10MinNames, {"HNLMS DeRuyter", 0})
		table.insert(Mission.USReinGrp10MinNames, {"USS Allen M. Sumner", 692})
		table.insert(Mission.USReinGrp10MinNames, {"USS Abel P. Upshur", 193})
		table.insert(Mission.USReinGrp10MinNames, {"USS Welborn C. Wood", 195})
		table.insert(Mission.USReinGrp10MinNames, {"USS George E. Badger", 196})
	
	for idx,unit in pairs(Mission.USReinGrp15Min) do
		JoinFormation(unit, Mission.USReinGrp15Min[3])
		SetGuiName(unit, Mission.USReinGrp15Min[idx][1])
		if Mission.USReinGrp15Min[idx][2] then
			SetNumbering(unit, Mission.USReinGrp15Min[idx][2])
		end
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	table.insert(Mission.USShips, FindEntity("USRein_Min15_1"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_2"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_3"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_4"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_5"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_6"))
	table.insert(Mission.USShips, FindEntity("USRein_Min15_7"))
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.USReinGrp15Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if Mission.USReinGrp15Min[3] and not Mission.USReinGrp15Min[3].Dead then
		NavigatorAttackMove(Mission.USReinGrp15Min[3], trg)
		luaSetScriptTarget(Mission.USReinGrp15Min[3], trg)
	end
	
	for idx,unit in pairs(Mission.USReinGrp15Min) do
		table.insert(Mission.USReinShips, unit)
	end
	
	MissionNarrative("Reinforcements are here!")
	
	--luaDelay(luaSpawnUSCVHermes, 10)
	
end

function luaUS20MinReinSpawn()

	Mission.USRein20Min1 = GenerateObject("USRein_Min20_1")
	Mission.USRein20Min2 = GenerateObject("USRein_Min20_2")
	Mission.USRein20Min3 = GenerateObject("USRein_Min20_3")
	Mission.USRein20Min4 = GenerateObject("USRein_Min20_4")
	Mission.USRein20Min5 = GenerateObject("USRein_Min20_5")
	Mission.USRein20Min6 = GenerateObject("USRein_Min20_6")
	Mission.USRein20Min7 = GenerateObject("USRein_Min20_7")
	Mission.USRein20Min8 = GenerateObject("USRein_Min20_8")
	Mission.USRein20Min9 = GenerateObject("USRein_Min20_9")
	Mission.USRein20Min10 = GenerateObject("USRein_Min20_10")
	Mission.USRein20Min11 = GenerateObject("USRein_Min20_11")
	Mission.USRein20Min12 = GenerateObject("USRein_Min20_12")
	Mission.USRein20Min13 = GenerateObject("USRein_Min20_13")
	Mission.USRein20Min14 = GenerateObject("USRein_Min20_14")
	Mission.USRein20Min15 = GenerateObject("USRein_Min20_15")
	Mission.USRein20Min16 = GenerateObject("USRein_Min20_16")
	Mission.USRein20Min17 = GenerateObject("USRein_Min20_17")
	Mission.USRein20Min18 = GenerateObject("USRein_Min20_18")
	Mission.USRein20Min19 = GenerateObject("USRein_Min20_19")
	Mission.USRein20Min20 = GenerateObject("USRein_Min20_20")
	Mission.USRein20Min21 = GenerateObject("USRein_Min20_21")
	Mission.USRein20Min22 = GenerateObject("USRein_Min20_22")
	Mission.USRein20Min23 = GenerateObject("USRein_Min20_23")
	
	Mission.USReinGrp20Min = {}
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_1"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_2"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_3"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_4"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_5"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_6"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_7"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_8"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_9"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_10"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_11"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_12"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_13"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_14"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_15"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_16"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_17"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_18"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_19"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_20"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_21"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_22"))
		table.insert(Mission.USReinGrp20Min, FindEntity("USRein_Min20_23"))
	
	Mission.USReinGrp20MinCargos = {}
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_1"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_2"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_3"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_4"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_5"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_6"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_7"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_8"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_9"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_10"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_11"))
		table.insert(Mission.USReinGrp20MinCargos, FindEntity("USRein_Min20_12"))
	
	Mission.USReinGrp20MinNames = {}
		table.insert(Mission.USReinGrp20MinNames, "USS Jeremiah O'Brien")
		table.insert(Mission.USReinGrp20MinNames, "USS John W. Brown")
		table.insert(Mission.USReinGrp20MinNames, "USS Arthur M. Huddell")
		table.insert(Mission.USReinGrp20MinNames, "USS Patrick Henry")
		table.insert(Mission.USReinGrp20MinNames, "USS James Eagan Layne")
		table.insert(Mission.USReinGrp20MinNames, "USS James H. Kimball")
		table.insert(Mission.USReinGrp20MinNames, "USS J. H. Drummond")
		table.insert(Mission.USReinGrp20MinNames, "USS Charles H. Cugle")
		table.insert(Mission.USReinGrp20MinNames, "USS Garry C. Lauter")
		table.insert(Mission.USReinGrp20MinNames, "USS Ruben Englebrecht")
		table.insert(Mission.USReinGrp20MinNames, "USS Aucilla")
		table.insert(Mission.USReinGrp20MinNames, "USS Chipola")
		table.insert(Mission.USReinGrp20MinNames, "USS Pope")
		table.insert(Mission.USReinGrp20MinNames, "USS Sands")
		table.insert(Mission.USReinGrp20MinNames, "USS Colhoun")
		table.insert(Mission.USReinGrp20MinNames, "USS Clemson")
		table.insert(Mission.USReinGrp20MinNames, "USS Dahlgren")
		table.insert(Mission.USReinGrp20MinNames, "USS Goldsborough")
		table.insert(Mission.USReinGrp20MinNames, "USS Southard")
		table.insert(Mission.USReinGrp20MinNames, "USS Riddle")
		table.insert(Mission.USReinGrp20MinNames, "USS Wingfield")
		table.insert(Mission.USReinGrp20MinNames, "USS Samuel S. Miles")
		table.insert(Mission.USReinGrp20MinNames, "USS Clarence")
	
	for idx,unit in pairs(Mission.USReinGrp20Min) do
		--JoinFormation(unit, Mission.USReinGrp20Min[19])
		--SetInvincible(unit, 1.0)
		SetShipMaxSpeed(unit, 10)
		SetGuiName(unit, Mission.USReinGrp20MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
		TorpedoEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	table.insert(Mission.USShips, FindEntity("USRein_Min20_1"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_2"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_3"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_4"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_5"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_6"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_7"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_8"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_9"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_10"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_12"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_13"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_14"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_15"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_16"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_17"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_18"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_19"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_20"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_21"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_22"))
	table.insert(Mission.USShips, FindEntity("USRein_Min20_23"))
	
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[1].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[1], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[2].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[2], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[3].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[3], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[4].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[4], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[5].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[5], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[6].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[6], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[7].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[7], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[8].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[8], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[9].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[9], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[10].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[10], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[11].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[11], Mission.USConvoyNav4, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[12].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[12], Mission.USConvoyNav2, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[13].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[13], Mission.USConvoyNav3, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[14].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[14], Mission.USConvoyNav5, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[15].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[15], Mission.USConvoyNav1, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[16].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[16], Mission.USConvoyNav5, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[17].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[17], Mission.USConvoyNav1, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[18].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[18], Mission.USConvoyNav5, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[19].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[19], Mission.USConvoyNav1, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[20].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[20], Mission.USConvoyNav5, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[21].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[21], Mission.USConvoyNav1, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[22].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[22], Mission.USConvoyNav5, {})
	end
	if Mission.USReinGrp20Min[23] and not Mission.USReinGrp20Min[23].Dead then
	NavigatorMoveToRange(Mission.USReinGrp20Min[23], Mission.USConvoyNav1, {})
	end
	
	luaDelay(luaUSAddSecObj, 3)
	
end

function luaUS25MinReinSpawn()

	Mission.USRein25Min1 = GenerateObject("USRein_Min25_1")
	Mission.USRein25Min2 = GenerateObject("USRein_Min25_2")
	Mission.USRein25Min3 = GenerateObject("USRein_Min25_3")
	
	Mission.USReinGrp25Min = {}
		table.insert(Mission.USReinGrp25Min, FindEntity("USRein_Min25_1"))
		table.insert(Mission.USReinGrp25Min, FindEntity("USRein_Min25_2"))
		table.insert(Mission.USReinGrp25Min, FindEntity("USRein_Min25_3"))
	
	Mission.USReinGrp25MinNames = {}
		table.insert(Mission.USReinGrp25MinNames, "HMS Duke of York")
		table.insert(Mission.USReinGrp25MinNames, "HMS Surrey")
		table.insert(Mission.USReinGrp25MinNames, "HMS Northumberland")
	
	for idx,unit in pairs(Mission.USReinGrp25Min) do
		JoinFormation(unit, Mission.USReinGrp25Min[1])
		SetGuiName(unit, Mission.USReinGrp25MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	table.insert(Mission.USShips, FindEntity("USRein_Min25_1"))
	table.insert(Mission.USShips, FindEntity("USRein_Min25_2"))
	table.insert(Mission.USShips, FindEntity("USRein_Min25_3"))
	
	--NavigatorMoveToRange(Mission.USReinGrp25Min[1], Mission.HermesNav)
	--UnitSetFireStance(Mission.USReinGrp25Min[1], 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.USReinGrp25Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if Mission.USReinGrp25Min[1] and not Mission.USReinGrp25Min[1].Dead then
		NavigatorAttackMove(Mission.USReinGrp25Min[1], trg)
		luaSetScriptTarget(Mission.USReinGrp25Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.USReinGrp25Min) do
		table.insert(Mission.USReinShips, unit)
	end
	
	MissionNarrative("Reinforcements are here!")
	
end

function luaUS30MinReinSpawn()

	Mission.USRein30Min1 = GenerateObject("USRein_Min30_1")
	Mission.USRein30Min2 = GenerateObject("USRein_Min30_2")
	Mission.USRein30Min3 = GenerateObject("USRein_Min30_3")
	Mission.USRein30Min4 = GenerateObject("USRein_Min30_4")
	Mission.USRein30Min5 = GenerateObject("USRein_Min30_5")
	Mission.USRein30Min6 = GenerateObject("USRein_Min30_6")
	Mission.USRein30Min7 = GenerateObject("USRein_Min30_7")
	
	Mission.USReinGrp30Min = {}
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_1"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_2"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_3"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_4"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_5"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_6"))
		table.insert(Mission.USReinGrp30Min, FindEntity("USRein_Min30_7"))
	
	--[[SetForcedReconLevel(Mission.USRein30Min1, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min2, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min3, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min4, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min5, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min6, 2, PARTY_JAPANESE)
	SetForcedReconLevel(Mission.USRein30Min7, 2, PARTY_JAPANESE)]]
	
	PilotMoveTo(Mission.USRein30Min5, Mission.Center)
	PilotMoveTo(Mission.USRein30Min6, Mission.Center)
	PilotMoveTo(Mission.USRein30Min7, Mission.Center)
	
	PilotSetTarget(Mission.USRein30Min1, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs)))
	PilotSetTarget(Mission.USRein30Min2, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs)))
	PilotSetTarget(Mission.USRein30Min3, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs)))
	PilotSetTarget(Mission.USRein30Min4, luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs)))
	
	table.insert(Mission.USReinAIPlanes, Mission.USRein30Min1)
	table.insert(Mission.USReinAIPlanes, Mission.USRein30Min2)
	table.insert(Mission.USReinAIPlanes, Mission.USRein30Min3)
	table.insert(Mission.USReinAIPlanes, Mission.USRein30Min4)
	
	--[[UnitSetFireStance(Mission.USRein30Min1, 2)
	UnitSetFireStance(Mission.USRein30Min2, 2)
	UnitSetFireStance(Mission.USRein30Min3, 2)
	UnitSetFireStance(Mission.USRein30Min4, 2)
	
	UnitSetFireStance(Mission.USRein30Min5, 2)
	UnitSetFireStance(Mission.USRein30Min6, 2)
	UnitSetFireStance(Mission.USRein30Min7, 2)]]
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.USReinGrp30Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	MissionNarrative("Reinforcements are here!")
	
end

function luaUS35MinReinSpawn()

	Mission.USRein35Min1 = GenerateObject("USRein_Min35_1")
	Mission.USRein35Min2 = GenerateObject("USRein_Min35_2")
	Mission.USRein35Min3 = GenerateObject("USRein_Min35_3")
	Mission.USRein35Min4 = GenerateObject("USRein_Min35_4")
	Mission.USRein35Min5 = GenerateObject("USRein_Min35_5")
	Mission.USRein35Min6 = GenerateObject("USRein_Min35_6")
	Mission.USRein35Min7 = GenerateObject("USRein_Min35_7")
	Mission.USRein35Min8 = GenerateObject("USRein_Min35_8")
	Mission.USRein35Min9 = GenerateObject("USRein_Min35_9")
	Mission.USRein35Min10 = GenerateObject("USRein_Min35_10")
	Mission.USRein35Min11 = GenerateObject("USRein_Min35_11")
	Mission.USRein35Min12 = GenerateObject("USRein_Min35_12")
	Mission.USRein35Min13 = GenerateObject("USRein_Min35_13")
	Mission.USRein35Min14 = GenerateObject("USRein_Min35_14")
	Mission.USRein35Min15 = GenerateObject("USRein_Min35_15")
	
	Mission.USReinGrp35Min = {}
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_1"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_2"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_3"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_4"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_5"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_6"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_7"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_8"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_9"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_10"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_11"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_12"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_13"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_14"))
		table.insert(Mission.USReinGrp35Min, FindEntity("USRein_Min35_15"))
	
	Mission.USReinGrp35MinNames = {}
		table.insert(Mission.USReinGrp35MinNames, "USS Juneau")
		table.insert(Mission.USReinGrp35MinNames, "USS Stormes")
		table.insert(Mission.USReinGrp35MinNames, "USS Bristol")
		table.insert(Mission.USReinGrp35MinNames, "USS Luppis")
		table.insert(Mission.USReinGrp35MinNames, "USS Frazier")
		table.insert(Mission.USReinGrp35MinNames, "USS Farenholt")
		table.insert(Mission.USReinGrp35MinNames, "USS Parker")
		table.insert(Mission.USReinGrp35MinNames, "USS Ringgold")
		table.insert(Mission.USReinGrp35MinNames, "USS Converse")
		table.insert(Mission.USReinGrp35MinNames, "USS Anthony")
		table.insert(Mission.USReinGrp35MinNames, "USS Gatling")
		table.insert(Mission.USReinGrp35MinNames, "USS Svarun Soda")
		table.insert(Mission.USReinGrp35MinNames, "USS Colin D. Glenn")
		table.insert(Mission.USReinGrp35MinNames, "USS Syed Yasir Acktar")
		table.insert(Mission.USReinGrp35MinNames, "USS Aleks Myszkier")
	
	for idx,unit in pairs(Mission.USReinGrp35Min) do
		JoinFormation(unit, Mission.USReinGrp35Min[1])
		SetGuiName(unit, Mission.USReinGrp35MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	table.insert(Mission.USShips, FindEntity("USRein_Min35_1"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_2"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_3"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_4"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_5"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_6"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_7"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_8"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_9"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_10"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_11"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_12"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_13"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_14"))
	table.insert(Mission.USShips, FindEntity("USRein_Min35_15"))
	
	--NavigatorMoveToRange(Mission.USReinGrp35Min[1], Mission.USDDsNav)
	--UnitSetFireStance(Mission.USReinGrp35Min[1], 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("USCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.USReinGrp35Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z - 18000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if Mission.USReinGrp35Min[1] and not Mission.USReinGrp35Min[1].Dead then
		NavigatorAttackMove(Mission.USReinGrp35Min[1], trg)
		luaSetScriptTarget(Mission.USReinGrp35Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.USReinGrp35Min) do
		table.insert(Mission.USReinShips, unit)
	end
	
	MissionNarrative("Reinforcements are here!")
	
end

-- IJN

function luaIJN5MinReinSpawn()

	Mission.IJNRein5Min1 = GenerateObject("IJNRein_Min5_1")
	Mission.IJNRein5Min2 = GenerateObject("IJNRein_Min5_2")
	Mission.IJNRein5Min3 = GenerateObject("IJNRein_Min5_3")
	Mission.IJNRein5Min4 = GenerateObject("IJNRein_Min5_4")

	--[[SetForcedReconLevel(Mission.IJNRein5Min1, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein5Min2, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein5Min3, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein5Min4, 2, PARTY_ALLIED)]]
	
	EntityTurnToPosition(Mission.IJNRein5Min1, Mission.Center)
	EntityTurnToPosition(Mission.IJNRein5Min2, Mission.Center)
	EntityTurnToPosition(Mission.IJNRein5Min3, Mission.Center)
	EntityTurnToPosition(Mission.IJNRein5Min4, Mission.Center)
	
	local trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	local trg3 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	local trg4 = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	PilotSetTarget(Mission.IJNRein5Min1, trg1)
	PilotSetTarget(Mission.IJNRein5Min2, trg2)
	PilotSetTarget(Mission.IJNRein5Min3, trg3)
	PilotSetTarget(Mission.IJNRein5Min4, trg4)
	
	luaSetScriptTarget(Mission.IJNRein5Min1, trg1)
	luaSetScriptTarget(Mission.IJNRein5Min2, trg2)
	luaSetScriptTarget(Mission.IJNRein5Min3, trg3)
	luaSetScriptTarget(Mission.IJNRein5Min4, trg4)
	
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein5Min1)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein5Min2)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein5Min3)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein5Min4)
	
	--UnitSetFireStance(Mission.IJNRein5Min1, 2)
	--UnitSetFireStance(Mission.IJNRein5Min2, 2)
	--UnitSetFireStance(Mission.IJNRein5Min3, 2)
	--UnitSetFireStance(Mission.IJNRein5Min4, 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			--for idx,unit in pairs(Mission.USReinGrp10Min) do
				if Mission.IJNRein5Min1 and not Mission.IJNRein5Min1.Dead then
					local unitpos = GetPosition(Mission.IJNRein5Min1)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 12000
					PutTo(Mission.IJNRein5Min1, unitpos)
				end
				if Mission.IJNRein5Min2 and not Mission.IJNRein5Min2.Dead then
					local unitpos = GetPosition(Mission.IJNRein5Min2)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 12000
					PutTo(Mission.IJNRein5Min2, unitpos)
				end
				if Mission.IJNRein5Min3 and not Mission.IJNRein5Min3.Dead then
					local unitpos = GetPosition(Mission.IJNRein5Min3)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 12000
					PutTo(Mission.IJNRein5Min3, unitpos)
				end
				if Mission.IJNRein5Min4 and not Mission.IJNRein5Min4.Dead then
					local unitpos = GetPosition(Mission.IJNRein5Min4)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 12000
					PutTo(Mission.IJNRein5Min4, unitpos)
				end
			--end
		end
	end
	
	--MissionNarrative("Japanese reinforcements are here!")
	
end

function luaIJN10MinReinSpawn()

	Mission.IJNRein10Min1 = GenerateObject("IJNRein_Min10_1")
	Mission.IJNRein10Min2 = GenerateObject("IJNRein_Min10_2")
	Mission.IJNRein10Min3 = GenerateObject("IJNRein_Min10_3")
	Mission.IJNRein10Min4 = GenerateObject("IJNRein_Min10_4")
	Mission.IJNRein10Min5 = GenerateObject("IJNRein_Min10_5")
	
	Mission.IJNReinGrp10Min = {}
		table.insert(Mission.IJNReinGrp10Min, FindEntity("IJNRein_Min10_1"))
		table.insert(Mission.IJNReinGrp10Min, FindEntity("IJNRein_Min10_2"))
		table.insert(Mission.IJNReinGrp10Min, FindEntity("IJNRein_Min10_3"))
		table.insert(Mission.IJNReinGrp10Min, FindEntity("IJNRein_Min10_4"))
		table.insert(Mission.IJNReinGrp10Min, FindEntity("IJNRein_Min10_5"))
	
	Mission.IJNReinGrp10MinNames = {}
		table.insert(Mission.IJNReinGrp10MinNames, "Izumo")
		table.insert(Mission.IJNReinGrp10MinNames, "Suzuya")
		table.insert(Mission.IJNReinGrp10MinNames, "Fuyutsuki")
		table.insert(Mission.IJNReinGrp10MinNames, "Niizuki")
		table.insert(Mission.IJNReinGrp10MinNames, "Yoizuki")
	
	for idx,unit in pairs(Mission.IJNReinGrp10Min) do
		JoinFormation(unit, Mission.IJNReinGrp10Min[1])
		SetGuiName(unit, Mission.IJNReinGrp10MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min10_1"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min10_2"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min10_3"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min10_4"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min10_5"))
	
	--NavigatorMoveToRange(Mission.IJNReinGrp10Min[1], Mission.HiryuNav)
	--UnitSetFireStance(Mission.IJNReinGrp10Min[1], 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.IJNReinGrp10Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 12000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if Mission.IJNReinGrp10Min[1] and not Mission.IJNReinGrp10Min[1].Dead then
		NavigatorAttackMove(Mission.IJNReinGrp10Min[1], trg)
		luaSetScriptTarget(Mission.IJNReinGrp10Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.IJNReinGrp10Min) do
		table.insert(Mission.IJNReinShips, unit)
	end
	
	--MissionNarrative("Japanese reinforcements are here!")
	
end

function luaIJN15MinReinSpawn()

	Mission.IJNRein15Min1 = GenerateObject("IJNRein_Min15_1")
	Mission.IJNRein15Min2 = GenerateObject("IJNRein_Min15_2")
	Mission.IJNRein15Min3 = GenerateObject("IJNRein_Min15_3")
	Mission.IJNRein15Min4 = GenerateObject("IJNRein_Min15_4")
	Mission.IJNRein15Min5 = GenerateObject("IJNRein_Min15_5")
	Mission.IJNRein15Min6 = GenerateObject("IJNRein_Min15_6")
	
	Mission.IJNReinGrp15Min = {}
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_1"))
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_2"))
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_3"))
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_4"))
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_5"))
		table.insert(Mission.IJNReinGrp15Min, FindEntity("IJNRein_Min15_6"))
	
	Mission.IJNReinGrp15MinNames = {}
		table.insert(Mission.IJNReinGrp15MinNames, "Unryu")
		table.insert(Mission.IJNReinGrp15MinNames, "Tama")
		table.insert(Mission.IJNReinGrp15MinNames, "Natsuzuki")
		table.insert(Mission.IJNReinGrp15MinNames, "Kawakaze")
		table.insert(Mission.IJNReinGrp15MinNames, "Sawakaze")
		table.insert(Mission.IJNReinGrp15MinNames, "Minekaze")
	
	for idx,unit in pairs(Mission.IJNReinGrp15Min) do
		JoinFormation(unit, Mission.IJNReinGrp15Min[2])
		SetGuiName(unit, Mission.IJNReinGrp15MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_1"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_2"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_3"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_4"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_5"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min15_6"))
	
	--NavigatorMoveToRange(Mission.IJNReinGrp15Min[1], Mission.HiryuNav, {})
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.IJNReinGrp15Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if Mission.IJNReinGrp15Min[2] and not Mission.IJNReinGrp15Min[2].Dead then
		NavigatorAttackMove(Mission.IJNReinGrp15Min[2], trg)
		luaSetScriptTarget(Mission.IJNReinGrp15Min[2], trg)
	end
	
	for idx,unit in pairs(Mission.IJNReinGrp15Min) do
		table.insert(Mission.IJNReinShips, unit)
	end
	
	--MissionNarrative("Japanese reinforcements are here!")
	
	--luaDelay(luaSpawnIJNCVUnryu, 10)
	
end

function luaIJN20MinReinSpawn()

	Mission.IJNRein20Min1 = GenerateObject("IJNRein_Min20_1")
	Mission.IJNRein20Min2 = GenerateObject("IJNRein_Min20_2")
	Mission.IJNRein20Min3 = GenerateObject("IJNRein_Min20_3")
	Mission.IJNRein20Min4 = GenerateObject("IJNRein_Min20_4")
	Mission.IJNRein20Min5 = GenerateObject("IJNRein_Min20_5")
	Mission.IJNRein20Min6 = GenerateObject("IJNRein_Min20_6")
	Mission.IJNRein20Min7 = GenerateObject("IJNRein_Min20_7")
	Mission.IJNRein20Min8 = GenerateObject("IJNRein_Min20_8")
	Mission.IJNRein20Min9 = GenerateObject("IJNRein_Min20_9")
	Mission.IJNRein20Min10 = GenerateObject("IJNRein_Min20_10")
	Mission.IJNRein20Min11 = GenerateObject("IJNRein_Min20_11")
	Mission.IJNRein20Min12 = GenerateObject("IJNRein_Min20_12")
	Mission.IJNRein20Min13 = GenerateObject("IJNRein_Min20_13")
	Mission.IJNRein20Min14 = GenerateObject("IJNRein_Min20_14")
	Mission.IJNRein20Min15 = GenerateObject("IJNRein_Min20_15")
	Mission.IJNRein20Min16 = GenerateObject("IJNRein_Min20_16")
	Mission.IJNRein20Min17 = GenerateObject("IJNRein_Min20_17")
	Mission.IJNRein20Min18 = GenerateObject("IJNRein_Min20_18")
	Mission.IJNRein20Min19 = GenerateObject("IJNRein_Min20_19")
	Mission.IJNRein20Min20 = GenerateObject("IJNRein_Min20_20")
	Mission.IJNRein20Min21 = GenerateObject("IJNRein_Min20_21")
	Mission.IJNRein20Min22 = GenerateObject("IJNRein_Min20_22")
	Mission.IJNRein20Min23 = GenerateObject("IJNRein_Min20_23")
	
	Mission.IJNReinGrp20Min = {}
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_1"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_2"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_3"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_4"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_5"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_6"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_7"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_8"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_9"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_10"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_11"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_12"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_13"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_14"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_15"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_16"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_17"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_18"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_19"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_20"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_21"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_22"))
		table.insert(Mission.IJNReinGrp20Min, FindEntity("IJNRein_Min20_23"))
	
	Mission.IJNReinGrp20MinCargos = {}
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_1"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_2"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_3"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_4"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_5"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_6"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_7"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_8"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_9"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_10"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_11"))
		table.insert(Mission.IJNReinGrp20MinCargos, FindEntity("IJNRein_Min20_12"))
	
	Mission.IJNReinGrp20MinNames = {}
		table.insert(Mission.IJNReinGrp20MinNames, "Saisho")
		table.insert(Mission.IJNReinGrp20MinNames, "Ni-Banme")
		table.insert(Mission.IJNReinGrp20MinNames, "San")
		table.insert(Mission.IJNReinGrp20MinNames, "Dai")
		table.insert(Mission.IJNReinGrp20MinNames, "Go-Banme")
		table.insert(Mission.IJNReinGrp20MinNames, "Dairoku")
		table.insert(Mission.IJNReinGrp20MinNames, "Dainana")
		table.insert(Mission.IJNReinGrp20MinNames, "Aizu")
		table.insert(Mission.IJNReinGrp20MinNames, "Nagaoka")
		table.insert(Mission.IJNReinGrp20MinNames, "Satsuma")
		table.insert(Mission.IJNReinGrp20MinNames, "Aomori")
		table.insert(Mission.IJNReinGrp20MinNames, "Iwate")
		table.insert(Mission.IJNReinGrp20MinNames, "Asashio")
		table.insert(Mission.IJNReinGrp20MinNames, "Arashi")
		table.insert(Mission.IJNReinGrp20MinNames, "Sazanami")
		table.insert(Mission.IJNReinGrp20MinNames, "Tsuga")
		table.insert(Mission.IJNReinGrp20MinNames, "Nire")
		table.insert(Mission.IJNReinGrp20MinNames, "Kuri")
		table.insert(Mission.IJNReinGrp20MinNames, "Kiku")
		table.insert(Mission.IJNReinGrp20MinNames, "Hato")
		table.insert(Mission.IJNReinGrp20MinNames, "Sagi")
		table.insert(Mission.IJNReinGrp20MinNames, "Kari")
		table.insert(Mission.IJNReinGrp20MinNames, "Kiji")
	
	for idx,unit in pairs(Mission.IJNReinGrp20Min) do
		--JoinFormation(unit, Mission.IJNReinGrp20Min[19])
		--SetInvincible(unit, 1.0)
		SetShipMaxSpeed(unit, 10)
		SetGuiName(unit, Mission.IJNReinGrp20MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		RepairEnable(unit, false)
		TorpedoEnable(unit, true)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_1"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_2"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_3"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_4"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_5"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_6"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_7"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_8"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_9"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_10"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_11"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_12"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_13"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_14"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_15"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_16"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_17"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_18"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_19"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_20"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_21"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_22"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min20_23"))
	
	if Mission.IJNReinGrp20Min[1] and not Mission.IJNReinGrp20Min[1].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[1], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[2] and not Mission.IJNReinGrp20Min[2].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[2], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[3] and not Mission.IJNReinGrp20Min[3].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[3], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[4] and not Mission.IJNReinGrp20Min[4].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[4], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[5] and not Mission.IJNReinGrp20Min[5].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[5], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[6] and not Mission.IJNReinGrp20Min[6].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[6], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[7] and not Mission.IJNReinGrp20Min[7].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[7], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[8] and not Mission.IJNReinGrp20Min[8].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[8], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[9] and not Mission.IJNReinGrp20Min[9].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[9], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[10] and not Mission.IJNReinGrp20Min[10].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[10], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[11] and not Mission.IJNReinGrp20Min[11].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[11], Mission.IJNConvoyNav4, {})
	end
	if Mission.IJNReinGrp20Min[12] and not Mission.IJNReinGrp20Min[12].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[12], Mission.IJNConvoyNav2, {})
	end
	if Mission.IJNReinGrp20Min[13] and not Mission.IJNReinGrp20Min[13].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[13], Mission.IJNConvoyNav3, {})
	end
	if Mission.IJNReinGrp20Min[14] and not Mission.IJNReinGrp20Min[14].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[14], Mission.IJNConvoyNav1, {})
	end
	if Mission.IJNReinGrp20Min[15] and not Mission.IJNReinGrp20Min[15].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[15], Mission.IJNConvoyNav5, {})
	end
	if Mission.IJNReinGrp20Min[16] and not Mission.IJNReinGrp20Min[16].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[16], Mission.IJNConvoyNav1, {})
	end
	if Mission.IJNReinGrp20Min[17] and not Mission.IJNReinGrp20Min[17].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[17], Mission.IJNConvoyNav5, {})
	end
	if Mission.IJNReinGrp20Min[18] and not Mission.IJNReinGrp20Min[18].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[18], Mission.IJNConvoyNav1, {})
	end
	if Mission.IJNReinGrp20Min[19] and not Mission.IJNReinGrp20Min[19].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[19], Mission.IJNConvoyNav5, {})
	end
	if Mission.IJNReinGrp20Min[20] and not Mission.IJNReinGrp20Min[20].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[20], Mission.IJNConvoyNav1, {})
	end
	if Mission.IJNReinGrp20Min[21] and not Mission.IJNReinGrp20Min[21].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[21], Mission.IJNConvoyNav5, {})
	end
	if Mission.IJNReinGrp20Min[22] and not Mission.IJNReinGrp20Min[22].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[22], Mission.IJNConvoyNav1, {})
	end
	if Mission.IJNReinGrp20Min[23] and not Mission.IJNReinGrp20Min[23].Dead then
	NavigatorMoveToRange(Mission.IJNReinGrp20Min[23], Mission.IJNConvoyNav5, {})
	end
	
	luaDelay(luaIJNAddSecObj, 3)
	
end

function luaIJN25MinReinSpawn()

	Mission.IJNRein25Min1 = GenerateObject("IJNRein_Min25_1")
	Mission.IJNRein25Min2 = GenerateObject("IJNRein_Min25_2")
	Mission.IJNRein25Min3 = GenerateObject("IJNRein_Min25_3")
	
	Mission.IJNReinGrp25Min = {}
		table.insert(Mission.IJNReinGrp25Min, FindEntity("IJNRein_Min25_1"))
		table.insert(Mission.IJNReinGrp25Min, FindEntity("IJNRein_Min25_2"))
		table.insert(Mission.IJNReinGrp25Min, FindEntity("IJNRein_Min25_3"))
	
	Mission.IJNReinGrp25MinNames = {}
		table.insert(Mission.IJNReinGrp25MinNames, "Tirpitz")
		table.insert(Mission.IJNReinGrp25MinNames, "Admiral Hipper")
		table.insert(Mission.IJNReinGrp25MinNames, "Lutzow")
	
	for idx,unit in pairs(Mission.IJNReinGrp25Min) do
		JoinFormation(unit, Mission.IJNReinGrp25Min[1])
		SetGuiName(unit, Mission.IJNReinGrp25MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min25_1"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min25_2"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min25_3"))
	
	--NavigatorMoveToRange(Mission.IJNReinGrp25Min[1], Mission.HiryuNav)
	--UnitSetFireStance(Mission.IJNReinGrp25Min[1], 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.IJNReinGrp25Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if Mission.IJNReinGrp25Min[1] and not Mission.IJNReinGrp25Min[1].Dead then
		NavigatorAttackMove(Mission.IJNReinGrp25Min[1], trg)
		luaSetScriptTarget(Mission.IJNReinGrp25Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.IJNReinGrp25Min) do
		table.insert(Mission.IJNReinShips, unit)
	end
	
	--MissionNarrative("German reinforcements are here!")
	
end

function luaIJN30MinReinSpawn()

	Mission.IJNRein30Min1 = GenerateObject("IJNRein_Min30_1")
	Mission.IJNRein30Min2 = GenerateObject("IJNRein_Min30_2")
	Mission.IJNRein30Min3 = GenerateObject("IJNRein_Min30_3")
	Mission.IJNRein30Min4 = GenerateObject("IJNRein_Min30_4")
	Mission.IJNRein30Min5 = GenerateObject("IJNRein_Min30_5")
	Mission.IJNRein30Min6 = GenerateObject("IJNRein_Min30_6")
	Mission.IJNRein30Min7 = GenerateObject("IJNRein_Min30_7")
	
	Mission.IJNReinGrp30Min = {}
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_1"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_2"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_3"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_4"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_5"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_6"))
		table.insert(Mission.IJNReinGrp30Min, FindEntity("IJNRein_Min30_7"))
	
	PilotMoveTo(Mission.IJNRein30Min5, Mission.Center)
	PilotMoveTo(Mission.IJNRein30Min6, Mission.Center)
	PilotMoveTo(Mission.IJNRein30Min7, Mission.Center)
	
	PilotMoveTo(Mission.IJNRein30Min1, Mission.IJNDDsNav)
	PilotMoveTo(Mission.IJNRein30Min2, Mission.IJNDDsNav)
	PilotMoveTo(Mission.IJNRein30Min3, Mission.IJNDDsNav)
	PilotMoveTo(Mission.IJNRein30Min4, Mission.IJNDDsNav)
	
	--[[SetForcedReconLevel(Mission.IJNRein30Min1, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min2, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min3, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min4, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min5, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min6, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.IJNRein30Min7, 2, PARTY_ALLIED)]]
	
	PilotMoveTo(Mission.IJNRein30Min5, Mission.Center)
	PilotMoveTo(Mission.IJNRein30Min6, Mission.Center)
	PilotMoveTo(Mission.IJNRein30Min7, Mission.Center)
	
	UnitSetFireStance(Mission.IJNRein30Min5, STANCE_FREE_FIRE)
	UnitSetFireStance(Mission.IJNRein30Min6, STANCE_FREE_FIRE)
	UnitSetFireStance(Mission.IJNRein30Min7, STANCE_FREE_FIRE)
	
	PilotSetTarget(Mission.IJNRein30Min1, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
	PilotSetTarget(Mission.IJNRein30Min2, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
	PilotSetTarget(Mission.IJNRein30Min3, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
	PilotSetTarget(Mission.IJNRein30Min4, luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs)))
	
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein30Min1)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein30Min2)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein30Min3)
	table.insert(Mission.IJNReinAIPlanes, Mission.IJNRein30Min4)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.IJNReinGrp30Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 14000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	--MissionNarrative("Japanese reinforcements are here!")
	
end

function luaIJN35MinReinSpawn()

	Mission.IJNRein35Min1 = GenerateObject("IJNRein_Min35_1")
	Mission.IJNRein35Min2 = GenerateObject("IJNRein_Min35_2")
	Mission.IJNRein35Min3 = GenerateObject("IJNRein_Min35_3")
	Mission.IJNRein35Min4 = GenerateObject("IJNRein_Min35_4")
	Mission.IJNRein35Min5 = GenerateObject("IJNRein_Min35_5")
	Mission.IJNRein35Min6 = GenerateObject("IJNRein_Min35_6")
	Mission.IJNRein35Min7 = GenerateObject("IJNRein_Min35_7")
	Mission.IJNRein35Min8 = GenerateObject("IJNRein_Min35_8")
	Mission.IJNRein35Min9 = GenerateObject("IJNRein_Min35_9")
	Mission.IJNRein35Min10 = GenerateObject("IJNRein_Min35_10")
	Mission.IJNRein35Min11 = GenerateObject("IJNRein_Min35_11")
	Mission.IJNRein35Min12 = GenerateObject("IJNRein_Min35_12")
	Mission.IJNRein35Min13 = GenerateObject("IJNRein_Min35_13")
	Mission.IJNRein35Min14 = GenerateObject("IJNRein_Min35_14")
	Mission.IJNRein35Min15 = GenerateObject("IJNRein_Min35_15")
	
	Mission.IJNReinGrp35Min = {}
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_1"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_2"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_3"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_4"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_5"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_6"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_7"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_8"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_9"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_10"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_11"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_12"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_13"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_14"))
		table.insert(Mission.IJNReinGrp35Min, FindEntity("IJNRein_Min35_15"))
	
	Mission.IJNReinGrp35MinNames = {}
		table.insert(Mission.IJNReinGrp35MinNames, "Kitakami")
		table.insert(Mission.IJNReinGrp35MinNames, "Michitsuki")
		table.insert(Mission.IJNReinGrp35MinNames, "Harutsuki")
		table.insert(Mission.IJNReinGrp35MinNames, "Shimakaze")
		table.insert(Mission.IJNReinGrp35MinNames, "Fubuki")
		table.insert(Mission.IJNReinGrp35MinNames, "Ushio")
		table.insert(Mission.IJNReinGrp35MinNames, "Shirayuki")
		table.insert(Mission.IJNReinGrp35MinNames, "Samidare")
		table.insert(Mission.IJNReinGrp35MinNames, "Oite")
		table.insert(Mission.IJNReinGrp35MinNames, "Kamikaze")
		table.insert(Mission.IJNReinGrp35MinNames, "Mutsuki")
		table.insert(Mission.IJNReinGrp35MinNames, "Yayoi")
		table.insert(Mission.IJNReinGrp35MinNames, "Fuyo")
		table.insert(Mission.IJNReinGrp35MinNames, "Sanae")
		table.insert(Mission.IJNReinGrp35MinNames, "Nashi")
	
	for idx,unit in pairs(Mission.IJNReinGrp35Min) do
		JoinFormation(unit, Mission.IJNReinGrp35Min[1])
		SetGuiName(unit, Mission.IJNReinGrp35MinNames[idx])
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, true)
		TorpedoEnable(unit, true)
		--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end
	
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_1"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_2"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_3"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_4"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_5"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_6"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_7"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_8"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_9"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_10"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_11"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_12"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_13"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_14"))
	table.insert(Mission.IJNShips, FindEntity("IJNRein_Min35_15"))
	
	--NavigatorMoveToRange(Mission.IJNReinGrp35Min[1], Mission.IJNDDsNav)
	--UnitSetFireStance(Mission.IJNReinGrp35Min[1], 2)
	
	local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNCVs))
	
	if cv and not cv.Dead then
		if luaGetDistance(cv, FindEntity("IJNCVHalfWay")) < 11000 then
			for idx,unit in pairs(Mission.IJNReinGrp35Min) do
				if unit and not unit.Dead then
					local unitpos = GetPosition(unit)
					unitpos.x = unitpos.x + 0
					unitpos.y = unitpos.y + 0
					unitpos.z = unitpos.z + 18000
					PutTo(unit, unitpos)
				end
			end
		end
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USCVs))
	
	if Mission.IJNReinGrp35Min[1] and not Mission.IJNReinGrp35Min[1].Dead then
		NavigatorAttackMove(Mission.IJNReinGrp35Min[1], trg)
		luaSetScriptTarget(Mission.IJNReinGrp35Min[1], trg)
	end
	
	for idx,unit in pairs(Mission.IJNReinGrp35Min) do
		table.insert(Mission.IJNReinShips, unit)
	end
	
	--MissionNarrative("Japanese reinforcements are here!")
	
end

---- SUPPORT FUNCT. ----

-- OWNER GETTING

function GetOwner(unit)
	if unit.Dead or unit == nil then
		return nil
	else
		return GetRoleAvailable(unit)[1]
	end
end