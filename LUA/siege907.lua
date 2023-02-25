function luaPrecacheUnits()
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(162) -- Kate
	PrepareClass(133) -- Buffalo
	PrepareClass(101) -- Wildcat
	PrepareClass(112) -- Devastator
	PrepareClass(113) -- Avenger
	PrepareClass(108) -- Dauntless
	PrepareClass(116) -- Flying Fortress
	PrepareClass(27)  -- Elco
	PrepareClass(23)  -- Fletcher
	PrepareClass(90)  -- Daihatsu
	PrepareClass(86)  -- Troop Transport J
	PrepareClass(85)  -- Fleet Oiler J
	PrepareClass(73)  -- Fubuki
	PrepareClass(75)  -- Minekaze
	PrepareClass(58)  -- Shimakaze
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene907")
end

function luaInitScene907(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Operation Midway"

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

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})


	-- amerikai objektumok
	Mission.SpawnTime = 60
	Mission.EventAUnits = {}
	Mission.EventJUnits = {}
	
	Mission.HQ = FindEntity("Headquarter 01")
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Headquarter 01"))		
	Mission.HQPreviousHPPercentage = 1
	RepairEnable(Mission.HQ, false)
	--[[DisplayUnitHP(0,Mission.HQs)
	DisplayUnitHP(1,Mission.HQs)
	DisplayUnitHP(2,Mission.HQs)
	DisplayUnitHP(3,Mission.HQs)
	DisplayUnitHP(4,Mission.HQs)
	DisplayUnitHP(5,Mission.HQs)
	DisplayUnitHP(6,Mission.HQs)
	DisplayUnitHP(7,Mission.HQs)]]
	
	Mission.Shipyard = FindEntity("Shipyard 02")

	Mission.Guns = {}
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 01"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 02"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 03"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 04"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 05"))
		table.insert(Mission.Guns, FindEntity("Fortress 01"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 01"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 02"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 03"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 04"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 05"))
		table.insert(Mission.Guns, FindEntity("AA Gun, US 06"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 13"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 14"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 15"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 16"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 17"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 18"))
		table.insert(Mission.Guns, FindEntity("Coastal Gun, US 19"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 01"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 02"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 03"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 04"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 05"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 06"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 07"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 08"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 09"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 10"))
		table.insert(Mission.Guns, FindEntity("Heavy AA, US Big Platform 11"))
		
	for index, unit in pairs (Mission.Guns) do
		SetSkillLevel(unit, SKILL_ELITE)
	end

		Mission.USCV = {}
		table.insert(Mission.USCV, FindEntity("AirFieldEntity 01"))
		table.insert(Mission.USCV, FindEntity("Yorktown"))	
		table.insert(Mission.USCV, FindEntity("Enterprise"))	
		table.insert(Mission.USCV, FindEntity("Hornet"))	

	Mission.USEscorts = {}
		table.insert(Mission.USEscorts, FindEntity("Astoria"))	
		table.insert(Mission.USEscorts, FindEntity("Portland"))	
		table.insert(Mission.USEscorts, FindEntity("Hammann"))	
		table.insert(Mission.USEscorts, FindEntity("Anderson"))	
		table.insert(Mission.USEscorts, FindEntity("Gwin"))	
		table.insert(Mission.USEscorts, FindEntity("Huges"))	
		table.insert(Mission.USEscorts, FindEntity("Morris"))	
		table.insert(Mission.USEscorts, FindEntity("Russell"))	
		table.insert(Mission.USEscorts, FindEntity("Atlanta"))	
		table.insert(Mission.USEscorts, FindEntity("Minneapolis"))	
		table.insert(Mission.USEscorts, FindEntity("New Orleans"))	
		table.insert(Mission.USEscorts, FindEntity("Northampton"))	
		table.insert(Mission.USEscorts, FindEntity("Benham"))		
		table.insert(Mission.USEscorts, FindEntity("Maury"))	
		table.insert(Mission.USEscorts, FindEntity("Phelps"))	
		table.insert(Mission.USEscorts, FindEntity("Worden"))	
		table.insert(Mission.USEscorts, FindEntity("Monaghan"))	
		table.insert(Mission.USEscorts, FindEntity("Alwin"))	
		table.insert(Mission.USEscorts, FindEntity("Balch"))	
		table.insert(Mission.USEscorts, FindEntity("Conyngham"))	
		table.insert(Mission.USEscorts, FindEntity("Pensacola"))
		
	Mission.USCAReinf = {}
		table.insert(Mission.USCAReinf, FindEntity("Astoria"))		
		table.insert(Mission.USCAReinf, FindEntity("Portland"))		
		table.insert(Mission.USCAReinf, FindEntity("Pensacola"))		

	for r = 1, 21 do
		RepairEnable(Mission.USEscorts[r], false)
	end
					
	Mission.ElcoTMPL = {}
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco TEMPL1"))
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco TEMPL2"))
		
	Mission.Elco = {}
	
	Mission.PTNames = {}
		table.insert(Mission.PTNames, "PT-20")
		table.insert(Mission.PTNames, "PT-21")
		table.insert(Mission.PTNames, "PT-22")
		table.insert(Mission.PTNames, "PT-24")
		table.insert(Mission.PTNames, "PT-25")
		table.insert(Mission.PTNames, "PT-26")
		table.insert(Mission.PTNames, "PT-27")
		table.insert(Mission.PTNames, "PT-28")
		table.insert(Mission.PTNames, "PT-29")
		table.insert(Mission.PTNames, "PT-30")
		
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Airfield"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Yorktown"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Enterprise"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Hornet"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Akagi"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Kaga"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Soryu"))
		table.insert(Mission.SpawnPoints, FindEntity("SpawnPoint Hiryu"))
		
		--[[for n = 0, 3 do
			DeactivateSpawnpoint(Mission.SpawnPoints[1], n)
			DeactivateSpawnpoint(Mission.SpawnPoints[2], n)
			DeactivateSpawnpoint(Mission.SpawnPoints[3], n)
			DeactivateSpawnpoint(Mission.SpawnPoints[4], n)
		end]]

		for o = 4, 7 do
			DeactivateSpawnpoint(Mission.SpawnPoints[5], o)
			DeactivateSpawnpoint(Mission.SpawnPoints[6], o)
			DeactivateSpawnpoint(Mission.SpawnPoints[7], o)
			DeactivateSpawnpoint(Mission.SpawnPoints[8], o)
		end
		
		--[[for p = 1, 8 do
			q =  p - 1
			ActivateSpawnpoint(Mission.SpawnPoints[p], q)
		end	]]	
		for p = 5, 8 do
			q =  p - 1
			ActivateSpawnpoint(Mission.SpawnPoints[p], q)
		end
		

	Mission.JPCV = {}
		table.insert(Mission.JPCV, FindEntity("Akagi"))
		table.insert(Mission.JPCV, FindEntity("Kaga"))	
		table.insert(Mission.JPCV, FindEntity("Soryu"))	
		table.insert(Mission.JPCV, FindEntity("Hiryu"))	

	for r = 1, 4 do
		RepairEnable(Mission.USCV[r], false)
		RepairEnable(Mission.JPCV[r], false)
	end
		
	Mission.JPEscorts = {}
		table.insert(Mission.JPEscorts, FindEntity("Kirishima"))	
		table.insert(Mission.JPEscorts, FindEntity("Hiei"))	
		table.insert(Mission.JPEscorts, FindEntity("Yukaze"))	
		table.insert(Mission.JPEscorts, FindEntity("Isonami"))	
		table.insert(Mission.JPEscorts, FindEntity("Fubuki"))	
		table.insert(Mission.JPEscorts, FindEntity("Shikinami"))	
		table.insert(Mission.JPEscorts, FindEntity("Ayanami"))	
		table.insert(Mission.JPEscorts, FindEntity("Uranami"))	
		table.insert(Mission.JPEscorts, FindEntity("Shirayuki"))	
		table.insert(Mission.JPEscorts, FindEntity("Hatsuyuki"))

	for r = 1, 10 do
		RepairEnable(Mission.JPEscorts[r], false)
		SetSkillLevel(Mission.JPEscorts[r], SKILL_MPNORMAL)
	end	
	
	Mission.Daihatsus = {}
	Mission.FirstSpawn = true
	
	Mission.DaihatsuTMPL = {}
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL1"))
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL2"))
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL3"))
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL4"))
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL5"))
		table.insert(Mission.DaihatsuTMPL, luaFindHidden("Daihatsu LCVP TEMPL6"))
	
	Mission.LandedLCVP = {}
	
	Mission.JTTTMPL = luaFindHidden("TroopTrans TEMPL")
	Mission.JTTNavPoint = FindEntity("Navpoint JTT 1")
	Mission.JTTNavPoint2 = FindEntity("Navpoint JTT 2")
		
	Mission.JTTNames = {}
		table.insert(Mission.JTTNames, "Kiyosumi Maru")
		table.insert(Mission.JTTNames, "Keiyo Maru")
		table.insert(Mission.JTTNames, "Zenyo Maru")
		table.insert(Mission.JTTNames, "Goshu Maru")
		table.insert(Mission.JTTNames, "Toa Maru")
		table.insert(Mission.JTTNames, "Kano Maru")
		table.insert(Mission.JTTNames, "Argentina Maru")
		table.insert(Mission.JTTNames, "Hokuriku Maru")
		table.insert(Mission.JTTNames, "Brazil Maru")
		table.insert(Mission.JTTNames, "Kirishima Maru")
		table.insert(Mission.JTTNames, "Azuma Maru")
		table.insert(Mission.JTTNames, "Nankai Maru")
		table.insert(Mission.JTTNames, "Akebono Maru")
		
	Mission.OilersTMPL = {}
		table.insert(Mission.OilersTMPL, luaFindHidden("Kokyuto Maru TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Kokuyo Maru TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Nippon Maru TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Toho Maru TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Akigumo TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Tanikaze TMPL"))
		table.insert(Mission.OilersTMPL, luaFindHidden("Makigumo TMPL"))
		
	Mission.Oilers = {}
		
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

	Mission.USReinfThreshold = Mission.ResourceUSPool / 2
	Mission.USReinf = false
	Mission.JPReinfThreshold = Mission.ResourceJapPool / 2
	Mission.JPReinf = false
	
	Mission.ResourceUSAtlanta = 30
	Mission.ResourceUSClemson = 20
	Mission.ResourceUSFletcher = 20
	Mission.ResourceUSNorthampton = 30
	Mission.ResourceUSCoastalGun = 4
	Mission.ResourceUSFortress = 40
	Mission.ResourceUSHeavyAA = 4
	Mission.ResourceUSLightAA = 4
	Mission.ResourceUSPT = 10
	Mission.ResourceUSHQ = 5
	Mission.ResourceJapKongo = 40
	Mission.ResourceJapMinekaze = 20
	Mission.ResourceJapFubuki = 20
	Mission.ResourceJapJTT = 10
	Mission.ResourceJapDaihatsu = 2
	Mission.ResourcePlayerUnit = 15


---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua") -- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
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
		["secondary"] =	{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "ijn06.obj_p1", --Ambush the supply convoy and sink the designated ships!
				["TextCompleted"] = "ijn06.obj_p1_completed", --Your ambush was successful!
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "usn03.obj_p5", --Target the incoming cruisers!
				["TextCompleted"] = "ingame.warning_nmy_ship_ship_dest_dispatcher2_jap", --Success. The enemy is now sinking.
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
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
		luaCheckGuns()
		luaCheckPlayers()
		luaCheckUSEscorts()
		luaCheckJPEscorts()
		luaCheckJTT()
		luaCheckLCVP()
		luaLCVPLanding()
		luaCheckPT()
		luaCheckCVHQ()
		luaCheckReinforcements()
		Mission.SpawnTime = Mission.SpawnTime + 1
		if Mission.SpawnTime >= 120 then
			for i = 1, 4 do
				luaEventSpawnUS(i)
				luaEventSpawnJP(i)		
			end

			Mission.SpawnTime = 0
		end
	elseif not Mission.Started then
		luaScene907StartMission()
		luaSetMultiScoreTable()
	end
end

function luaScene907StartMission()
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
	
	Mission.JTT = GenerateObject(Mission.JTTTMPL.Name)
	local rnd = random(1,13)
	SetGuiName(Mission.JTT, Mission.JTTNames[rnd])
	NavigatorSetTorpedoEvasion(Mission.JTT, false)
	NavigatorSetAvoidLandCollision(Mission.JTT, false)
	NavigatorSetAvoidShipCollision(Mission.JTT, false)
	NavigatorMoveToRange(Mission.JTT, Mission.JTTNavPoint2)
	Mission.JTT.InPosition = false
	
	for j = 1, 2 do
		local pt = GenerateObject(Mission.ElcoTMPL[j].Name)
		local rnda = random(1,5)
		local rndb = random(6,10)
			if j == 1 then
				SetGuiName(pt, Mission.PTNames[rnda])
			elseif j == 2 then
				SetGuiName(pt, Mission.PTNames[rndb])
			end
		--NavigatorSetAvoidShipCollision(pt, false)
		NavigatorMoveToRange(pt, Mission.JTTNavPoint)
		TorpedoEnable(pt, true)
		table.insert(Mission.Elco, pt)
	end	
	
	AISetTargetWeight(101, 150, false, 20)	--Wildcat to Zero
	AISetTargetWeight(133, 150, false, 20)	--Buffalo to Zero
	AISetTargetWeight(101, 158, false, 20)	--Wildcat to Val
	AISetTargetWeight(133, 158, false, 20)	--Buffalo to Val
	AISetTargetWeight(101, 162, false, 20)	--Wildcat to Kate
	AISetTargetWeight(133, 162, false, 20)	--Buffalo to Kate
	--[[AISetTargetWeight(112, 50, false, 5)	--Devastator to Akagi
	AISetTargetWeight(108, 50, false, 5)	--Dauntless to Akagi]]
	AISetTargetWeight(116, 86, false, 5)	--Flying Fortress to Troop Transport
	AISetTargetWeight(101, 90, false, 5)	--Wildcat to Daihatsu
	AISetTargetWeight(133, 90, false, 5)	--Buffalo to Daihatsu
	AISetTargetWeight(116, 90, false, 0)	--Flying Fortress to Daihatsu
	
	AISetTargetWeight(150, 101, false, 20)	--Zero to Wildcat
	AISetTargetWeight(150, 133, false, 20)	--Zero to Buffalo
	AISetTargetWeight(150, 116, false, 20)	--Zero to Flying Fortress
	AISetTargetWeight(150, 116, false, 20)	--Zero to Flying Fortress
	AISetTargetWeight(150, 112, false, 20)	--Zero to Devastator
	AISetTargetWeight(150, 108, false, 20)	--Zero to Dauntless
--[[	AISetTargetWeight(162, 2, false, 5)	--Kate to Yorktown
	AISetTargetWeight(158, 97, false, 5)	--Val to Headquarter
	AISetTargetWeight(158, 2, false, 5)	--Val to Yorktown]]
	AISetTargetWeight(150, 27, false, 0)	--Zero to Elco
	
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
	if unit == "usplayer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourcePlayerUnit
	elseif unit == "japplayer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourcePlayerUnit
	elseif unit == "northampton" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSNorthampton
	elseif unit == "clemson" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSClemson
	elseif unit == "fletcher" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFletcher
	elseif unit == "atlanta" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSAtlanta
	elseif unit == "coastalgun" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSCoastalGun
	elseif unit == "fortress" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortress
	elseif unit == "heavyaa" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSHeavyAA	
	elseif unit == "lightaa" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLightAA	
	elseif unit == "PT" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSPT	
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceUSHQ * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "kongo" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapKongo
	elseif unit == "minekaze" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapMinekaze
	elseif unit == "fubuki" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFubuki
	elseif unit == "JTT" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapJTT
	elseif unit == "LCVP" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapDaihatsu
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
		luaScene907MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaScene907MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaScene907MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaScene907MissionEnd()
		end
	end
end

function luaCheckGuns()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
	for index, unit in pairs (Mission.Guns) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found ID: "..tostring(unit.Class.ID))
			if unit.Class.ID == 460 then
				luaResourcePoolReducer("coastalgun")
			elseif unit.Class.ID == 249 then
				luaResourcePoolReducer("fortress")
			elseif unit.Class.ID == 629 then
				luaResourcePoolReducer("lightaa")
			elseif unit.Class.ID == 62 then
				luaResourcePoolReducer("heavyaa")
			end
			unit.ignore = true
		end
	end

	local threshold = GetHpPercentage(Mission.HQ) + 0.01
	if threshold < Mission.HQPreviousHPPercentage then
		local difference = Mission.HQPreviousHPPercentage - GetHpPercentage(Mission.HQ)
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.HQPreviousHPPercentage = GetHpPercentage(Mission.HQ)
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

	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if GetRoleAvailable(unit)[1] <= 7 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end	
			end
		end
	end
	
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if GetRoleAvailable(unit)[1] <= 7 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end	
			end
		end
	end
	
end

function luaCheckUSEscorts()
-- RELEASE_LOGOFF  	luaLog(" Checking carriers...")
	if table.getn(Mission.USEscorts) ~= 0 then
		for index, unit in pairs (Mission.USEscorts) do
			if unit.Dead and not unit.ignore then
				if unit.Class.ID == 19 then
					luaResourcePoolReducer("northampton")
				elseif unit.Class.ID == 25 then
					luaResourcePoolReducer("clemson")
				elseif unit.Class.ID == 23 then
					luaResourcePoolReducer("fletcher")
				elseif unit.Class.ID == 17 then
					luaResourcePoolReducer("atlanta")
				end
				unit.ignore = true
			end
		end
	end
end

function luaCheckJPEscorts()
-- RELEASE_LOGOFF  	luaLog(" Checking carriers...")
	if table.getn(Mission.JPEscorts) ~= 0 then
		for index, unit in pairs (Mission.JPEscorts) do
			if unit.Dead and not unit.ignore then
				if unit.Class.ID == 60 then
					luaResourcePoolReducer("kongo")
				elseif unit.Class.ID == 75 then
					luaResourcePoolReducer("minekaze")
				elseif unit.Class.ID == 73 then
					luaResourcePoolReducer("fubuki")
				end
				unit.ignore = true
			end
		end
	end
end

function luaCheckJTT()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if Mission.JTT.Dead then
		local rnd = random(1,13)
		Mission.JTT = GenerateObject(Mission.JTTTMPL.Name)
		SetGuiName(Mission.JTT, Mission.JTTNames[rnd])
		MissionNarrativeParty(0, "mp01.nar_siege_us_tr_arrive")
		MissionNarrativeParty(1, "mp01.nar_siege_jap_tr_arrive")
		luaResourcePoolReducer("JTT")
		NavigatorMoveToRange(Mission.JTT, Mission.JTTNavPoint2)
		NavigatorSetTorpedoEvasion(Mission.JTT, false)
		NavigatorSetAvoidLandCollision(Mission.JTT, false)
		NavigatorSetAvoidShipCollision(Mission.JTT, false)
		Mission.JTT.InPosition = false
	elseif not Mission.JTT.InPosition then
		if luaGetDistance(Mission.JTT, Mission.JTTNavPoint) < 50 then
			NavigatorMoveToRange(Mission.JTT, Mission.JTTNavPoint)
			--NavigatorStop(Mission.JTT)
			--NavigatorEnable(Mission.JTT, false)
			--SetShipMaxSpeed(Mission.JTT, 0)
			--SetShipSpeed(Mission.JTT, 0)
			Mission.JTT.InPosition = true
		end					
	elseif Mission.JTT.InPosition and Mission.FirstSpawn then
		Mission.FirstSpawn = false
		for i = 1, 6 do
			local lcvp = GenerateObject(Mission.DaihatsuTMPL[i].Name)
			NavigatorMoveToRange(lcvp, Mission.HQs[1])
			NavigatorSetAvoidLandCollision(lcvp, false)
			NavigatorSetAvoidShipCollision(lcvp, false)
			lcvp.LandingInProgress = false
			lcvp.ignore = false
			table.insert(Mission.Daihatsus, lcvp)
		end	
	end
	
--[[Mission.eee = luaGetDistance(Mission.JTT, Mission.JTTNavPoint)
		MissionNarrativeParty(0, "#Mission.eee#")
		MissionNarrativeParty(1, "#Mission.eee#")]]

end

function luaCheckLCVP()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if table.getn(Mission.Daihatsus) ~= 0 then
		for index = 1, 6 do
			if Mission.Daihatsus[index].Dead then
				if Mission.Daihatsus[index].LandingInProgress == false and Mission.Daihatsus[index].ignore == false then
					luaResourcePoolReducer("LCVP")
					Mission.Daihatsus[index].ignore = true				
				elseif Mission.JTT.InPosition then 
					Mission.Daihatsus[index] = GenerateObject(Mission.DaihatsuTMPL[index].Name)
					NavigatorMoveToRange(Mission.Daihatsus[index], Mission.HQs[1])
					Mission.Daihatsus[index].ignore = false
					Mission.Daihatsus[index].LandingInProgress = false
					NavigatorSetAvoidLandCollision(Mission.Daihatsus[index], false)
					NavigatorSetAvoidShipCollision(Mission.Daihatsus[index], false)	
				end
			elseif luaGetDistance(Mission.Daihatsus[index], Mission.HQ) < 910 and Mission.Daihatsus[index].LandingInProgress == false then
				StartLanding2(Mission.Daihatsus[index])
				Mission.Daihatsus[index].LandingInProgress = true
			elseif Mission.Daihatsus[index].LandingInProgress then
				table.insert(Mission.LandedLCVP, Mission.Daihatsus[index])
			end
		end
	end
end

function luaLCVPLanding()
	if table.getn(Mission.LandedLCVP) ~= 0 then
		for index, unit in pairs (Mission.LandedLCVP) do
			if unit.landedtime == nil then
				unit.landedtime = Mission.ElapsedTime
			end
			
			if unit.Dead then
				unit.landedtime = nil
				table.remove(Mission.LandedLCVP, index)
			elseif Mission.ElapsedTime - unit.landedtime > 25 then
				Kill(unit, true)
				unit.landedtime = nil
				table.remove(Mission.LandedLCVP, index)
			else
				AddDamage(Mission.HQ, 8)
			end
		end
	end	
end

function luaCheckPT()
	if table.getn(Mission.Elco) ~= 0 then
		for index, unit in pairs (Mission.Elco) do
			if unit.Dead then
				luaResourcePoolReducer("PT")
				if not Mission.Shipyard.Dead then
					Mission.Elco[index] = GenerateObject(Mission.ElcoTMPL[index].Name)
					local rnda = random(1,5)
					local rndb = random(6,10)
					if index == 1 then
					SetGuiName(Mission.Elco[index], Mission.PTNames[rnda])
				elseif index == 2 then
					SetGuiName(Mission.Elco[index], Mission.PTNames[rndb])
				end
					--NavigatorSetAvoidShipCollision(Mission.Elco[index], false)
					NavigatorMoveToRange(Mission.Elco[index], Mission.JTTNavPoint)	
					TorpedoEnable(Mission.Elco[index], true)	
					MissionNarrativeParty(0, "mp01.nar_siege_us_pt_arrive")
					MissionNarrativeParty(1, "mp01.nar_siege_jap_pt_arrive")
				end								
			elseif not unit.Dead and not Mission.JTT.Dead then
				NavigatorAttackMove(unit, Mission.JTT, {})
			end
		end
	end
end

function luaScene907MissionEnd()
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
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		--luaObj_Completed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	elseif Mission.HQ.Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.ResourceUSPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		--luaObj_Failed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	end
end

function luaEventSpawnUS(id) 
	local SpawnCoord = GetPosition(Mission.SpawnPoints[id])
	SpawnCoord.y = 500
	if id == 1 then
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			
			{
				["Type"] = 116,
				["Name"] = "B17 Flying Fortress",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 3,
				["Equipment"] = 1,
			},
			{
				["Type"] = 113,
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
		["callback"] = "luaEventSpawnUSCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})	
	else
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = 108,
				["Name"] = "SBD Dauntless",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 2,
				["Equipment"] = 1,
			},
			{
				["Type"] = 112,
				["Name"] = "TBD Devastator",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 2,
				["Equipment"] = 1,
			},			
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnUSCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	end
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
	
end

function luaEventSpawnUSCallback(unit1, unit2)
	table.insert(Mission.EventAUnits, unit1)
	table.insert(Mission.EventAUnits, unit2)
	local t1 = luaRnd(1, 4)
	local t2 = luaRnd(1, 4)
	
	if not unit1.Dead then
		SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
		if not Mission.JPCV[t1].Dead then
			PilotSetTarget(unit1, Mission.JPCV[t1])
			EntityTurnToEntity(unit1, Mission.JPCV[t1])	
		end
	end	
	if not unit2.Dead then
		SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
		if not Mission.JPCV[t2].Dead then
			PilotSetTarget(unit2, Mission.JPCV[t2])
			EntityTurnToEntity(unit2, Mission.JPCV[t2])	
		end
	end				
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
end

function luaEventSpawnJP(id) 	
	local SpawnCoord = GetPosition(Mission.SpawnPoints[id+4])
	SpawnCoord.y = 500		
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 158,
			["Name"] = "D3A Val",
			["Crew"] = 3,
			["Race"] = Japan,
			["WingCount"] = 2,
			["Equipment"] = 1,
		},
		{
			["Type"] = 162,
			["Name"] = "B5N Kate",
			["Crew"] = 3,
			["Race"] = Japan,
			["WingCount"] = 2,
			["Equipment"] = 1,
		},

	},
	["area"] = {
		["refPos"] = SpawnCoord,
		["angleRange"] = { DEG(-10),DEG(10)},
	},
	["callback"] = "luaEventSpawnJPCallback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	})
		
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
			
end

function luaEventSpawnJPCallback(unit1, unit2)
	table.insert(Mission.EventJUnits, unit1)
	table.insert(Mission.EventJUnits, unit2)
	local t1 = luaRnd(2, 4)--USCV[1] is airfield and Kate will not attack
	local t2 = luaRnd(2, 4)--USCV[1] is airfield and Kate will not attack
	
	if not unit1.Dead then
		SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
		if not Mission.USCV[t1].Dead then
			PilotSetTarget(unit1, Mission.USCV[t1])
			EntityTurnToEntity(unit1, Mission.USCV[t1])	
		end
	end	
	if not unit2.Dead then
		SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
		if not Mission.USCV[t2].Dead then
			PilotSetTarget(unit2, Mission.USCV[t2])
			EntityTurnToEntity(unit2, Mission.USCV[t2])	
		end
	end
end

function luaCheckCVHQ()
	if not Mission.MissionEndCalled then
		for i = 1, 4 do
			if Mission.USCV[i].Dead then
				Mission.ResourceUSPool = 0
				Mission.MissionEndCalled = true
				luaScene907MissionEnd()	
			elseif Mission.JPCV[i].Dead then
				Mission.ResourceJapPool = 0
				Mission.MissionEndCalled = true
				luaScene907MissionEnd()					
			end
		end
		if Mission.HQ.Party ~= PARTY_ALLIED then
			Mission.ResourceUSPool = 0
			Mission.MissionEndCalled = true
			luaScene907MissionEnd()			
		end
	end
end

function luaCheckReinforcements()
	if not Mission.MissionEndCalled then
		if Mission.ResourceUSPool <= Mission.USReinfThreshold and not Mission.USReinf then
			for idx, unit in pairs (Mission.USCAReinf) do
				luaObj_Add("secondary",2)
				if not unit.Dead then
					NavigatorAttackMove(unit, Mission.JPCV[2], {})
					luaObj_AddUnit("secondary",2,unit)
				end
			end
			Mission.USReinf = true
		elseif luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.USCAReinf)) == 0 then
				luaObj_Completed("secondary", 2)
			end
		end

		if Mission.ResourceJapPool <= Mission.JPReinfThreshold and not Mission.JPReinf then
			luaObj_Add("secondary",1)
			for i = 1, 7 do
				local ship = GenerateObject(Mission.OilersTMPL[i].Name)
				if i <= 4 then
					NavigatorMoveToRange(ship, GetPosition(Mission.JPCV[i]))
				else
					NavigatorAttackMove(ship, Mission.HQ, {})
					table.insert(Mission.JPEscorts, ship)	
				end			
				luaObj_AddUnit("secondary",1,ship)
				table.insert(Mission.Oilers, ship)
			end
			Mission.JPReinf = true
		elseif luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			if table.getn(luaRemoveDeadsFromTable(Mission.Oilers)) == 0 then
				luaObj_Completed("secondary", 1)
			end
		end
	end
end