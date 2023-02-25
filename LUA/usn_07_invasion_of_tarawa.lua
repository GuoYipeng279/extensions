--SceneFile="missions\USN\usn_07_invasion_of_tarawa.scn"
DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
--todo: Emily fuggesztmeny - most divebomb
--todo: zerok felszallasa repterrol (ne legyenek szurkek)
--todo: fokozatos AA erosites
--todo: recon butitas delen
--todo: levelbomb swarmolas a vegen
--todo: pete attack legyen elbukhato
--todo: Hq attack legyen veszelyesebb(zero attack)
--todo: Bunkerek fazisa legyen meg a 9 kiloheto bunker ne kevesebb
--todo: transports_lost dialogus bekotes
--todo: jumpto first rocket corsair nem muxik

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	--MessageMap betoltese
	LoadMessageMap("usn07dlg",1)
	Dialogues = {
		["intro1"] = {
			["sequence"] = {
				{
					["message"] = "idlg01", --Transports, release landing boats and form the waves.
				},
			},
		},
		["intro2"] = {
			["sequence"] = {
				{
					["message"] = "idlg02a", --Minefield has been taken care of, Sir! Entrance to the atoll is free.
				},
			},
		},
		["intro3"] = {
			["sequence"] = {
				{
					["message"] = "idlg02b", --Ringgold, move to bombarding position.
				},
			},
		},
		["intro4"] = {
			["sequence"] = {
				{
					["message"] = "idlg02c", --This is USS Ringgold. We're ready and moving.
				},
			},
		},
		["intro5"] = {
			["sequence"] = {
				{
					["message"] = "idlg03a", --Sir, enemy seaplanes incoming.
				},
			},
		},
		["intro6"] = {
			["sequence"] = {
				{
					["message"] = "idlg03b", --Corsairs, you know what to do.
				},
			},
		},
	}
	MissionNarrative("usn07.date_location")
	luaDelay(luaUSN07_Dialog_Intro1, 23)
	luaDelay(luaUSN07_Dialog_Intro5, 52)
	luaDelay(luaUS07_Explosion_1,20)
end

function luaUSN07_Dialog_Intro1()
	StartDialog("intro1", Dialogues["intro1"])
	luaDelay(luaUSN07_Dialog_Intro2, 11)
end

function luaUSN07_Dialog_Intro2()
	StartDialog("intro2", Dialogues["intro2"])
	luaDelay(luaUSN07_Dialog_Intro3, 6)
end

function luaUSN07_Dialog_Intro3()
	StartDialog("intro3", Dialogues["intro3"])
	luaDelay(luaUSN07_Dialog_Intro4, 5)
end

function luaUSN07_Dialog_Intro4()
	StartDialog("intro4", Dialogues["intro4"])
end

function luaUSN07_Dialog_Intro5()
	StartDialog("intro5", Dialogues["intro5"])
	luaDelay(luaUSN07_Dialog_Intro6, 4)
end

function luaUSN07_Dialog_Intro6()
	StartDialog("intro6", Dialogues["intro6"])
end

function luaUS07_Explosion_1()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion1")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion2")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion3")))
	
	luaDelay(luaUS07_Explosion_2,1)
end

function luaUS07_Explosion_2()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion4")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion5")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion6")))
	luaDelay(luaUS07_Explosion_3,0.5)
end

function luaUS07_Explosion_3()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion7")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion8")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion3")))
	luaDelay(luaUS07_Explosion_4,1.8)
end

function luaUS07_Explosion_4()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion1")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion2")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion8")))
	luaDelay(luaUS07_Explosion_5,0.6)
end	

function luaUS07_Explosion_5()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion4")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion5")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion7")))
	luaDelay(luaUS07_Explosion_6,0.9)
end

function luaUS07_Explosion_6()
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion1")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion2")))
	Effect("Impact14InchGround", GetPosition(FindEntity("Nav_EM_Explosion5")))
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitUS07")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitUS07(this)
	Mission = this
	this.Name = "US07"
	this.ScriptFile = "scripts/missions/USA/US07.lua"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
				
	-- mission dolgok
	this.Party = SetParty(this, PARTY_ALLIED)
	
	this.MissionPhase = 1
	this.FirstRun = true

	-- Clouds
	this.CloudMedium = luaFindHidden("CloudMedium")
	this.CloudBig = luaFindHidden("CloudBig")
	
	-- allied hajok
	this.Transports = {}
		table.insert(this.Transports,FindEntity("Monrovia"))
		table.insert(this.Transports,FindEntity("Middleton"))
		table.insert(this.Transports,FindEntity("Heywood"))
		table.insert(this.Transports,FindEntity("Zeilin"))
		table.insert(this.Transports,FindEntity("La Salle"))
		table.insert(this.Transports,FindEntity("Doyen"))
		
	this.TargetTransports = {}
		table.insert(this.TargetTransports, this.Transports[1])
		table.insert(this.TargetTransports, this.Transports[2])
		table.insert(this.TargetTransports, this.Transports[3])
		table.insert(this.TargetTransports, this.Transports[4])
		table.insert(this.TargetTransports, this.Transports[5])
		table.insert(this.TargetTransports, this.Transports[6])
		
	this.BunkerHill = FindEntity("BunkerHill") 	-- CV
	this.Dashiell = FindEntity("Dashiell") 			-- DD
	this.Ringgold = FindEntity("Ringgold")			-- DD
	this.Schroeder = FindEntity("Schroeder")		-- DD
	this.UsDestroyers = {}
		table.insert(this.UsDestroyers, this.Ringgold)
		table.insert(this.UsDestroyers, this.Dashiell)
	--this.Birmingham = FindEntity("Birmingham")		-- CL
	this.Mobile = FindEntity("Mobile")				-- CL
	this.SantaFe = FindEntity("Santa Fe")			-- CL
	this.Maryland = FindEntity("Maryland")			-- BB
	this.Colorado = FindEntity("Colorado")			-- BB
			
	this.OperettShips = {
		this.Mobile,
		this.SantaFe,
		this.Maryland,
		this.Colorado,
		}
	this.BoatsRed1 = {}
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 1"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 2"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 3"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 4"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 5"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 6"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 7"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 8"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 9"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 10"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 11"))
		table.insert(this.BoatsRed1, FindEntity("Boat Red 1 12"))
		
	this.BoatsRed2 = {}
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 1"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 2"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 3"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 4"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 5"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 6"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 7"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 8"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 9"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 10"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 11"))
		table.insert(this.BoatsRed2, FindEntity("Boat Red 2 12"))
		
	this.BoatsRed3 = {}
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 1"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 2"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 3"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 4"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 5"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 6"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 7"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 8"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 9"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 10"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 11"))
		table.insert(this.BoatsRed3, FindEntity("Boat Red 3 12"))
	
	-- allied repcsik
	this.Corsair = FindEntity("Corsair")			-- Corsair player
		
	-- Player unitjai
	this.PlayerUnits = {}
	table.insert(this.PlayerUnits, this.Corsair)
	
	-- allied pathok, nav pontok
	this.CheckpointBoatPos_Red1 = {}
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 01"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 02"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 03"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 04"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 05"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 06"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 07"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 08"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 09"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 10"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 11"))
		table.insert(this.CheckpointBoatPos_Red1, FindEntity("Nav_Checkpoint_Red_1 12"))
		
	this.CheckpointBoatPos_Red2 = {}
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 01"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 02"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 03"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 04"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 05"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 06"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 07"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 08"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 09"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 10"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 11"))
		table.insert(this.CheckpointBoatPos_Red2, FindEntity("Nav_Checkpoint_Red_2 12"))
	
	this.CheckpointBoatPos_Red3 = {}
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 01"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 02"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 03"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 04"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 05"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 06"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 07"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 08"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 09"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 10"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 11"))
		table.insert(this.CheckpointBoatPos_Red3, FindEntity("Nav_Checkpoint_Red_3 12"))
	
	this.CheckpointNavRinggold = FindEntity("Nav_Checkpoint_Ringgold")
	this.CheckpointNavDashiell = FindEntity("Nav_Checkpoint_Dashiell")
	this.CheckpointNavCorsair = FindEntity("Nav_Checkpoint_Corsair")
	
	this.DDpath = FindEntity("FS4")					-- DD path
	this.RinggoldOutPath = FindEntity("Ringgold_RETREAT")
	this.SchroederInPath = FindEntity("Schroeder_IN")
	this.NavRinggold = FindEntity("NavRinggold")
	this.ArtilleryTargets = {}
		table.insert(this.ArtilleryTargets, FindEntity("NavArtillery1"))
		table.insert(this.ArtilleryTargets, FindEntity("NavArtillery2"))
		table.insert(this.ArtilleryTargets, FindEntity("NavArtillery3"))
		table.insert(this.ArtilleryTargets, FindEntity("NavArtillery4"))
		table.insert(this.ArtilleryTargets, FindEntity("NavArtillery5"))
		
	this.EMExplosions = {
		FindEntity("Nav_EM_Explosion1"),
		FindEntity("Nav_EM_Explosion2"),
		FindEntity("Nav_EM_Explosion3"),
		FindEntity("Nav_EM_Explosion4"),
		FindEntity("Nav_EM_Explosion5"),
		FindEntity("Nav_EM_Explosion6"),
		FindEntity("Nav_EM_Explosion7"),
		FindEntity("Nav_EM_Explosion8"),
		}
		
	this.GatherPointsRed1 = {}
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red11"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red12"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red13"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red14"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red15"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red16"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red17"))
		table.insert(this.GatherPointsRed1, FindEntity("Nav_Gather_Red18"))
		
	this.GatherPointsRed2 = {}
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red21"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red22"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red23"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red24"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red25"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red26"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red27"))
		table.insert(this.GatherPointsRed2, FindEntity("Nav_Gather_Red28"))
		
	this.GatherPointsRed3 = {}
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red31"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red32"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red33"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red34"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red35"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red36"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red37"))
		table.insert(this.GatherPointsRed3, FindEntity("Nav_Gather_Red38"))
		
	this.DDNav = FindEntity("Nav_DD")
	this.BoatNav = FindEntity("Nav_Boat")
	this.SpawnNav = FindEntity("Nav_OwnSpawn")
			
	-- japanese objektumok
	this.Bunkers = {}
	this.Fubuki = FindEntity("Fubuki")
	this.CoastalGunsRed1 = {}
		table.insert(this.CoastalGunsRed1,FindEntity("Coastal Red 1 1"))
		table.insert(this.CoastalGunsRed1,FindEntity("Coastal Red 1 2"))
		table.insert(this.CoastalGunsRed1,FindEntity("Coastal Red 1 3"))
		table.insert(this.CoastalGunsRed1,FindEntity("Medium Bunker, Concrete Red1 04"))
		table.insert(this.CoastalGunsRed1,FindEntity("Medium Bunker, Concrete Red2 01"))
		table.insert(this.CoastalGunsRed1,FindEntity("Medium Bunker, Concrete Red1 02"))
	
	this.CoastalGunsRed2 = {}
		table.insert(this.CoastalGunsRed2,FindEntity("Coastal Red 2 3"))
		table.insert(this.CoastalGunsRed2,FindEntity("Coastal Red 2 6"))
		table.insert(this.CoastalGunsRed2,FindEntity("Coastal Red 2 7"))
		table.insert(this.CoastalGunsRed2,FindEntity("Coastal Red 2 10"))
		table.insert(this.CoastalGunsRed2,FindEntity("Medium Bunker, Concrete Red2 04"))
		table.insert(this.CoastalGunsRed2,FindEntity("Medium Bunker, Concrete Red2 05"))
		
	this.CoastalGunsRed3 = {}
		table.insert(this.CoastalGunsRed3,FindEntity("Coastal Red 3 1"))
		table.insert(this.CoastalGunsRed3,FindEntity("Coastal Red 3 2"))
		table.insert(this.CoastalGunsRed3,FindEntity("Coastal Red 3 4"))
		table.insert(this.CoastalGunsRed3,FindEntity("Coastal Red 3 5"))
		table.insert(this.CoastalGunsRed3,FindEntity("Medium Bunker, Concrete Red3 02"))
		table.insert(this.CoastalGunsRed3,FindEntity("Medium Bunker, Concrete Red3 01"))
		
	this.HiddenBunkers = {} 
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 3 01"))
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 3 02"))
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 2 01"))
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 2 02"))
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 1 01"))
		table.insert(this.HiddenBunkers, luaFindHidden("Concrete Red 1 02"))
			
	this.FixBunkers = {}
		table.insert(this.FixBunkers, luaFindHidden("New Bunker, Medium Red3 01"))
		table.insert(this.FixBunkers, luaFindHidden("New Bunker, Medium Red2 02"))
		table.insert(this.FixBunkers, luaFindHidden("New Bunker, Medium Red1 01"))
				
	this.AAs = {}
		table.insert(this.AAs, FindEntity("AA 1"))
		table.insert(this.AAs, FindEntity("AA 2"))
		table.insert(this.AAs, FindEntity("AA 3"))
		table.insert(this.AAs, FindEntity("AA 4"))
		table.insert(this.AAs, FindEntity("AA 5"))
		table.insert(this.AAs, FindEntity("AA 6"))
		table.insert(this.AAs, FindEntity("AA 7"))
		table.insert(this.AAs, FindEntity("AA 8"))
		table.insert(this.AAs, FindEntity("AA 9"))
	
		
	this.HQ = FindEntity("HQ")
	
	SetInvincible(Mission.HQ, true)
	
	this.Airfield = FindEntity("AirField")
	this.Hangar = FindEntity("Hangar")
	this.Petes = {}
	this.Faketarget1 = FindEntity("Faketarget1")
	this.Faketarget2 = FindEntity("Faketarget2")
	this.Faketarget3 = FindEntity("Faketarget3")
	this.Faketarget4 = FindEntity("Faketarget4")
	this.Faketargets = {}
		table.insert(this.Faketargets, this.Faketarget1)
		table.insert(this.Faketargets, this.Faketarget2)
		table.insert(this.Faketargets, this.Faketarget3)
		table.insert(this.Faketargets, this.Faketarget4)
	
	-- japanese pathok, nav pontok
	this.EmilySpawnPoints = {}
		table.insert(this.EmilySpawnPoints,FindEntity("Nav_Emily1"))
		table.insert(this.EmilySpawnPoints,FindEntity("Nav_Emily2"))
		table.insert(this.EmilySpawnPoints,FindEntity("Nav_Emily3"))
		table.insert(this.EmilySpawnPoints,FindEntity("Nav_Emily4"))
	
	this.PeteSpawnPoints = {}
		table.insert(this.PeteSpawnPoints,FindEntity("Nav_Pete1"))
		table.insert(this.PeteSpawnPoints,FindEntity("Nav_Pete2"))
		table.insert(this.PeteSpawnPoints,FindEntity("Nav_Pete3"))
	
	this.ZeroNav1 = FindEntity("Nav_Zero_1")
	this.ZeroNav2 = FindEntity("Nav_Zero_2")
	this.KateSpawnPoints = {}
		table.insert(this.KateSpawnPoints, FindEntity("Nav_Kate"))
		table.insert(this.KateSpawnPoints, FindEntity("Nav_Kate 01"))
		table.insert(this.KateSpawnPoints, FindEntity("Nav_Kate 02"))
		table.insert(this.KateSpawnPoints, FindEntity("Nav_Kate 03"))
	this.SubNav = FindEntity("Nav_Sub")
	this.AirstrikeNav = FindEntity("Nav_Airstrike")
	this.Red1a1 = FindEntity("Red 1 a1")
	
	this.Firespot1 = FindEntity("Firespot1")
	this.Firespot2 = FindEntity("Firespot2")
	this.Firespot3 = FindEntity("Firespot3")
	this.Firespot4 = FindEntity("Firespot4")
	this.Firespot5 = FindEntity("Firespot5")
	this.FireSpots = {}
		table.insert(this.FireSpots, this.Firespot1)
		table.insert(this.FireSpots, this.Firespot2)
		table.insert(this.FireSpots, this.Firespot3)
		table.insert(this.FireSpots, this.Firespot4)
		table.insert(this.FireSpots, this.Firespot5)
	this.CounterState= -1
	this.Phase4ThinkCounter = 0
	this.DauntlessEmpty = false
	
	-- Teszt valtozok
			
	-- Player control tiltasok
	for idx,unit in pairs(Mission.Transports) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit,false)
		SetInvincible(unit, 0.2)
	end
	
	-- Operett ships tiltasok
	for idx,unit in pairs(this.OperettShips) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		UnitFreeFire(unit)
		AAEnable(unit, false)
	end
	
	SetRoleAvailable(this.Schroeder, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(this.Ringgold, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(this.Dashiell, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(this.BunkerHill, EROLF_ALL, PLAYER_AI)

	-- Landing boat tiltasok
	for idx,unit in pairs(this.BoatsRed1) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		AAEnable(unit, false)
	end
	
	for idx,unit in pairs(this.BoatsRed2) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		AAEnable(unit, false)
	end
	
	for idx,unit in pairs(this.BoatsRed3) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		AAEnable(unit, false)
	end
	
	-- Misc valtozok
	this.ObjRemindTime = 10
	this.TransportLimit = 3 
	this.MaxTransports = table.getn(this.Transports)
	
	-- Support Manager tiltas
	BannSupportmanager()

	-- BunkerHill tiltas
	SetRoleAvailable(Mission.BunkerHill, EROLF_ALL, PLAYER_AI)
	
	-- PT untouchable
	AddUntouchableUnit(FindEntity("Japanese Patrolboat 01"))
	
	--recon nerf
	SetSimplifiedReconMultiplier(0.7)

	-- DD AA disable	
	--AAEnable(this.Mobile, false)
	--AAEnable(this.Birmingham, false)
	AAEnable(this.Dashiell, false)
			
	-- Achievements init
	

	--reload enable
	SetDeviceReloadEnabled(true)
	SetDeviceReloadTimeMul(1.5)

	-- difficulty
	this.Difficulty = GetDifficulty()
-- RELEASE_LOGOFF  	luaLog("Difficulty: "..tostring(this.Difficulty))		

	-- music
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	-- objektivak
	this.Objectives = {
		["primary"] = {
			[1] =
			{
				["ID"] = "ShootRecons",		-- azonosito
				["Text"] = "usn07.obj_p1",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "usn.obj_p1_failed",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "StrafeTurrets",		-- azonosito
				["Text"] = "usn07.obj_p2",
				["TextCompleted"] = "" ,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "DestroyBunkers",		-- azonosito
				["Text"] = "usn07.obj_p3",
				["TextCompleted"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[4] =
			{
				["ID"] = "StopTorpedoRun",		-- azonosito
				["Text"] = "usn07.obj_p4", --Launch a preemptive strike at the enemy invasion force.
				["TextCompleted"] = "usn07.obj_p4_success",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[5] =
			{
				["ID"] = "DestroyHQ",		-- azonosito
				["Text"] = "usn07.obj_p5", --Launch a preemptive strike at the enemy invasion force.
				["TextCompleted"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[6] =
			{
				["ID"] = "PreventAirstrike",		-- azonosito
				["Text"] = "usn07.obj_p6", --Launch a preemptive strike at the enemy invasion force.
				["TextCompleted"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_SECONDARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			
		},
			
		["hidden"] = {
			[1] =
			{
				["ID"] = "EliminateAAs",		-- azonosito
				["Text"] = "usn07.obj_h1",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			
		},
		["secondary"] = {
			[1] =
			{
				["ID"] = "SaveTransports",		-- azonosito
				["Text"] = "usn07.obj_s1",
				["TextCompleted"] = "usn07.obj_s1_success",	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = "",	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},
	}
	luaObj_FillSingleScores()
	
	LoadMessageMap("usn07dlg",1)

	Mission.Dialogues = {
		["seaplanes_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg01a",
				},
				{
					["message"] = "dlg01b",
				},
			},
		},
		["ringgold_in_position"] = {
			["sequence"] = {
				{
					["message"] = "dlg02a",
				},
				{
					["message"] = "dlg02b",
				},
				{
					["message"] = "dlg02c",
				},
				{
					["message"] = "dlg02d",
				},
			},
		},
		["ships_in_position"] = {
			["sequence"] = {
				{
					["message"] = "dlg03a",
				},
				{
					["message"] = "dlg03b",
				},
			},
		},
		["turrets_killed"] = {
			["sequence"] = {
				{
					["message"] = "dlg04a",
				},
				{
					["message"] = "dlg04b",
				},
				{
					["message"] = "dlg04c",
				},
			},
		},
		["bunkers_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg05a",
				},
				{
					["message"] = "dlg05b",
				},
				{
					["message"] = "dlg05c",
				},
				{
					["message"] = "dlg05d",
				},
				{
					["message"] = "dlg05e",
				},
				{
					["message"] = "dlg05f",
				},
			},
		},
		["landing_success"] = {
			["sequence"] = {
				{
					["message"] = "dlg06a",
				},
				{
					["message"] = "dlg06b",
				},
			},
		},
		["HQ_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg07",
				},
			},
		},
		["HQ_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg08a",
				},
				{
					["message"] = "dlg08b",
				},
				{
					["message"] = "dlg08b_1",
				},
			},
		},
		["vals_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg09a",
				},
				{
					["message"] = "dlg09b",
				},
			},
		},
		["kates_objective"] = {
			["sequence"] = {
				{
					["message"] = "dlg10a",
				},
				{
					["message"] = "dlg10b",
				},
			},
		},
		["victory"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
				{	["type"] = "callback",
					["callback"] = "luaUS07MissionEnd"
				},
			},
		},
		["respawn"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["ringgold_hit"] = {
			["sequence"] = {
				{
					["message"] = "dlg13a",
				},
				{
					["message"] = "dlg13b",
				},
				{
					["message"] = "dlg13c",
				},
				{
					["message"] = "dlg13d",
				},
				{
					["message"] = "dlg13e",
				},
			},
		},
		["transports_lost"] = {
			["sequence"] = {
				{
					["message"] = "dlg14a",
				},
				{
					["message"] = "dlg14b",
				},
				{
					["message"] = "dlg14c",
				},
			},
		},
	}
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	luaInitNewSystems()

    --SetDeviceReloadTimeMul(0)
    SetThink(this, "US07Think")
							
	--Init Functions
	Blackout(false, "", 1)
	EnableMessages(true)
	
	-- SetSelectedUnit
	
	UnitHoldFire(Mission.Corsair)
	SetSelectedUnit(Mission.Corsair)
	SquadronSetTravelAlt(Mission.Corsair, 120)
	SquadronSetAttackAlt(Mission.Corsair, 120)
	SquadronSetSpeed(Mission.Corsair,100)
	PilotMoveToRange(Mission.Corsair, Mission.DDNav, 10)
	if not IsListenerActive("kill","listenerCorsairKill") then
		AddListener("kill", "listenerCorsairKill", {
				["callback"] = "luaUS07CorsairKilled",
				["entity"] = {Mission.Corsair},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
				
-- RELEASE_LOGOFF  		luaLog("Corsair kill listener added")
	end
	--Difficulty settings
	if Mission.Difficulty == 0 then
		Mission.CountDownTime = 480 --360
		Mission.EmilyEquipment = 2
		OverrideHP(Mission.HQ,700)
		Mission.PilotSkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.CountDownTime = 360 --300
		Mission.EmilyEquipment = 1
		OverrideHP(Mission.HQ,1000)
		Mission.PilotSkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.CountDownTime = 300 --240
		Mission.EmilyEquipment = 1
		OverrideHP(Mission.HQ,1500)
		Mission.PilotSkillLevel = SKILL_SPVETERAN
	end
	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaUS07Cp1LoadMissionData,luaUS07Cp1RelocateUnits},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaUS07Cp1SavePositions},
	}
	luaCheckSavedCheckpoint()
	if Mission.CheckpointLoaded == true then
		luaUS07PhaseManager()
	else
		local campos1 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= Mission.Corsair.ID,
				["pos"] = {-5, -15, -80}
			},
			["transformtype"]="keepz",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=0.0,
			["wanderer"]=true,
			["smoothtime"]=1.0,
			["zoom"] = 1.2,
		}

		local campos2 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["terrainavoid"] = true,
				["parentID"]= Mission.Corsair.ID,
				["modifier"] = {
						["name"] = "gamecamera",
					},
				},
			["transformtype"]="keepall",
			["starttime"]=0.0,
			["blendtime"]=4.0,
			["wanderer"]=false,
			["zoom"] = 1,
			["finishscript"] = "luaUS07StartingMovie",
		}
	 	MovCamNew_AddPosition(campos1)
		MovCamNew_AddPosition(campos2)
		BlackBars(false)
	end
end
function luaUS07StartingMovie()
	SetSelectedUnit(Mission.Corsair)
end
function US07Think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")
	
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	luaUS07CheckConditions(this)
	
	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	luaCheckMusic()

-- MissionPhase 1
	if this.MissionPhase == 1 then
		--fake targets
		for idx,unit in pairs (Mission.Faketargets) do
			SetForcedReconLevel(unit, 0, 0)
		end		
		
		--HQ set
		AddUntouchableUnit(Mission.HQ)
		SetGuiName(Mission.HQ, "usn07.tarawa_hq")
		
		-- Airfield set to neutral and invincible
		SetParty(Mission.Airfield, 2)
		AddUntouchableUnit(Mission.Airfield)
		SetInvincible(Mission.Hangar, 0.2)
		SetInvincible(Mission.Airfield, 0.2)
		
		-- BunkerHill torpedo avoidance OFF
		NavigatorSetTorpedoEvasion(Mission.BunkerHill, false)
		
		-- DD formation and invincible
		JoinFormation(Mission.Dashiell,Mission.Ringgold)
		--SetInvincible(Mission.Dashiell, 0.2)
		SetInvincible(Mission.Ringgold, 0.4)
		SetFireTarget(Mission.Ringgold, Mission.Fubuki)
		SetFireTarget(Mission.Dashiell, Mission.Fubuki)
		AddProximityTrigger(Mission.Ringgold, "RinggoldProximity", "luaUS07RinggoldArrived", Mission.NavRinggold, 200)
		
		-- AA Kill listener
		AddListener("kill", "listenerAAkilled", {
					["callback"] = "luaUS07AAKilled",
					["entity"] = Mission.AAs,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
					
		luaObj_Add("hidden",1)
		
		-- Landing listener
		AddListener("shipLanded", "landingListener", { 
					["callback"] = "luaUS07BoatsLanded",  -- callback fuggveny
					["entity"] = Mission.BoatsRed2, -- entityk akiken a listener aktiv
					})
		
		-- Movie turrets SetInvincible
		SetInvincible(FindEntity("Coastal Red 1 2"),true)
		SetInvincible(FindEntity("Coastal Red 1 1"),true)
		SetInvincible(FindEntity("Coastal Red 2 7"),true)
		SetInvincible(FindEntity("Coastal Red 3 5"),true)
				
		Mission.MissionPhase = 2					
		
		-- Init functions
		luaUS07JapPeteSpawn()
		luaUS07StartDestroyers()
		luaUS07GenerateTurrets()
		luaUS07OperettArtillery()
		luaDelay(luaUS07HintStall,40)
				
-- MissionPhase 2
	elseif this.MissionPhase == 2 and this.FirstRun then
		luaUS07FireStart()
		this.FirstRun = false
		this.Phase2ThinkCounter = 0
					
-- MissionPhase 3
	elseif this.MissionPhase == 3 and this.FirstRun then
		luaUS07FireStart()
		this.FirstRun = false
		this.Phase3ThinkCounter = 0
		
-- MissionPhase 4
	elseif this.MissionPhase == 4 and this.FirstRun then
		luaUS07FireStart()
		this.FirstRun = false
		Mission.Landed = 0
		
-- MissionPhase 5
	elseif this.MissionPhase == 5 and this.FirstRun then
		luaUS07FireStart()
		this.FirstRun = false
		Mission.Phase5ThinkCounter = 0
		
-- MissionPhase 6
	elseif this.MissionPhase == 6 and this.FirstRun then
		luaUS07FireStart()
		Mission.Phase6ThinkCounter = 0
		this.FirstRun = false
						
-- MissionPhase 7
	elseif this.MissionPhase == 7 and this.FirstRun then
		Mission.FirstRun = false
		SetParty(Mission.HQ, 0)
		SetRace(Mission.HQ, 0)
		SetInvincible(Mission.HQ, true)
		SetRoleAvailable(Mission.HQ, EROLF_ALL, PLAYER_AI)
		SetParty(Mission.Airfield, 0)
		SetRoleAvailable(Mission.Airfield, EROLF_ALL, PLAYER_AI)
-- RELEASE_LOGOFF  		luaLog("HQ and Airfield Party set to Allied")
		--MissionNarrative("Landed forces overran Betio airfield. The island is ours now.")
				
		SetInvincible(Mission.Hangar, 0.75)
		SetInvincible(Mission.Airfield, 0.75)
		AddDamage(Mission.Hangar,5000)		
		SetInvincible(Mission.Hangar, false)
		SetInvincible(Mission.Airfield, false)
		Mission.Phase7ThinkCounter = 0
		AddListener("kill", "airfieldKillListener", 
					{
					["callback"] = "luaUS07AirfieldKilled",
					["entity"] = {Mission.Hangar},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
	end
end
-- Check Conditions
function luaUS07CheckConditions()
-- Phase 1 Check
	if Mission.MissionPhase == 1 and Mission.FirstRun then

	end

-- Phase 2 Check	
	if Mission.MissionPhase == 2 and not Mission.FirstRun then
		Mission.Phase2ThinkCounter = Mission.Phase2ThinkCounter + 1
		if Mission.Phase2ThinkCounter > 2 and Mission.PetesReady and not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1, Mission.Petes, false)
			luaStartDialog("seaplanes_objective")
			DisplayUnitHP({Mission.Dashiell},"usn07.obj_p1")
		end
	end

-- Phase 3 Check
	if Mission.MissionPhase == 3 and not Mission.FirstRun then
		Mission.Phase3ThinkCounter = Mission.Phase3ThinkCounter + 1
							
		if Mission.Phase3ThinkCounter == 2 then
			--[[
			-- 1 turret megjelenitese
			randomturret = luaPickRnd(Mission.CoastalGunsRed2)
			generatedturret = GenerateObject(randomturret.Name)
			luaRemoveByName(Mission.CoastalGunsRed2,randomturret.Name)
			table.insert(Mission.CoastalGuns, generatedturret)
			]]
			local turret = (FindEntity("Coastal Red 2 6"))
			SetInvincible(turret, false)
			luaStartDialog("ships_in_position")
			if GetSelectedUnit() ~= nil then
				SetInvincible(GetSelectedUnit(), 0.3)
			end
			Mission.LastUsed = GetSelectedUnit()
			for idx,unit in pairs (Mission.CoastalGuns) do
				AddUntouchableUnit(unit)
			end
			luaUS07EM_Turrets_Start()
		end

		if Mission.Phase3ThinkCounter > 4 then
			Mission.CoastalGuns = luaRemoveDeadsFromTable(Mission.CoastalGuns)
			Mission.TurretsLeft = table.getn(Mission.CoastalGuns)
			if Mission.BoatsArrivedFlag == 1 then
				if luaObj_GetSuccess("primary",2) ~= true then
					Mission.BoatsArrivedFlag = 2
				end
			end
			
			if Mission.BoatsArrivedFlag == 2 and CountdownTimeLeft() < 120 and Mission.CounterState == 1 then
				Mission.CounterState = -1
				ShowHint("USN07_Hint_Timeup")
			end
			
			if Mission.EMRuns == false and luaObj_IsActive("primary",2) then
				DisplayScores(2,0,"usn07.obj_p2","usn07.obj_p2_display")
			end				
			
			if table.getn(Mission.CoastalGuns) == 0 then
				luaObj_Completed("primary",2,true)
				HideScoreDisplay(2,0)
				MissionNarrative("usn07.obj_p2_success")
				luaStartDialog("turrets_killed")
				CountdownCancel()
				Mission.CounterState = -1
				Mission.MissionPhase = 4
				Mission.FirstRun = true
			end
		end
	end
	
-- Phase 4 Check
	if Mission.MissionPhase == 4 and not Mission.FirstRun then
		Mission.Phase4ThinkCounter = Mission.Phase4ThinkCounter + 1
		if Mission.BoatsArrivedFlag ~= 0 then
			Mission.BoatsArrivedFlag = 3
			-- A csonakok elindulnak a partraszallo pontok fele a gyulekezohelyrol
			for idx,unit in pairs (Mission.BoatsRed1) do
				if not unit.Dead then
					StartLanding2(unit)
					--SetInvincible(unit, true)
				end
			end
			
			for idx,unit in pairs (Mission.BoatsRed2) do
				if not unit.Dead then
					StartLanding2(unit)
					--SetInvincible(unit, true)
				end
			end
			
			for idx,unit in pairs (Mission.BoatsRed3) do
				if not unit.Dead then
					StartLanding2(unit)
					--SetInvincible(unit, true)
				end
			end
			
			-- invincible cheat BoatsRed2[1]
			SetInvincible(Mission.BoatsRed2[1], 0.5)
		end
		
		if Mission.Phase4ThinkCounter == 2 then
			-- Bunkerek spawnolasa
			luaUS07GenerateBunkers()
			
		elseif Mission.Phase4ThinkCounter == 4 then
				
		elseif Mission.Phase4ThinkCounter > 4 then
			Mission.Bunkers = luaRemoveDeadsFromTable(Mission.Bunkers)
			Mission.BunkersLeft = table.getn(Mission.Bunkers)
			if Mission.CounterState == 1 and CountdownTimeLeft() < 120 then
				Mission.CounterState = -1
-- RELEASE_LOGOFF  				luaLog("HINT!!")
				ShowHint("USN07_Hint_Timeup")
			end
			
			if Mission.EMRuns == false and luaObj_IsActive("primary",3) then
				DisplayScores(3,0,"usn07.obj_p3","usn07.obj_p3_display")
			end
			
			if table.getn(Mission.Bunkers) == 0 and not luaObj_GetSuccess("primary", 3) then
				CountdownCancel()
				Mission.CounterState = -1
				luaObj_Completed("primary", 3,true)
				HideScoreDisplay(3,0)
				MissionNarrative("usn07.obj_p3_success")
				--luaCheckpoint(1, nil)
				Mission.FirstRun = true
				Mission.MissionPhase = 5
			end
		end
	end
	
-- Phase 5 Check
	if Mission.MissionPhase == 5 and not Mission.FirstRun then
		Mission.Transports = luaRemoveDeadsFromTable(Mission.Transports)
		Mission.Phase5ThinkCounter = Mission.Phase5ThinkCounter + 1
		if Mission.Phase5ThinkCounter == 1 then
			luaUS07PreparePhase5()
		end
			
		if Mission.Phase5ThinkCounter > 4 and luaObj_IsActive("primary", 4) and Mission.EMRuns == false then
			DisplayScores(4,0,"usn07.obj_p4","usn07.obj_p4_display")
		end
	end
	
-- Phase 6 Check
	if Mission.MissionPhase == 6 and not Mission.FirstRun then
		Mission.Phase6ThinkCounter = Mission.Phase6ThinkCounter + 1
		if Mission.CounterState == 1 and CountdownTimeLeft() < 120 then
			Mission.CounterState = -1
-- RELEASE_LOGOFF  			luaLog("HINT!!")
			ShowHint("USN07_Hint_Timeup")
		end
		if Mission.Phase6ThinkCounter == 1 then
			Mission.HQTimer = 0
			luaUS07EM_HQ_Start()
-- RELEASE_LOGOFF  			luaLog("Inditom a HQ mozit!")
		end
			
		if Mission.HQ.Party == 2 then
			luaUS07HQKilled()
		end
	end
	
-- Phase 7 Check
	if Mission.MissionPhase == 7 and not Mission.FirstRun then
		Mission.Phase7ThinkCounter = Mission.Phase7ThinkCounter + 1
		if Mission.Phase7ThinkCounter == 1 then
			luaUS07AirstrikeSpawn()
			luaUS07Zero3Spawn()
			--luaUS07CorsairSpawn()
		end
	end
	
	-- Ringgold damage check
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == true then
		if not Mission.Ringgold.Dead and GetHpPercentage(Mission.Ringgold) < 0.3 and not Mission.RinggoldRetreated then
			Mission.RinggoldRetreated = true
			SetInvincible(Mission.Ringgold, GetHpPercentage(Mission.Ringgold))
-- RELEASE_LOGOFF  			luaLog("Ringold Retreat meghivva")
			NavigatorMoveOnPath(Mission.Ringgold,Mission.RinggoldOutPath)
			NavigatorMoveOnPath(Mission.Schroeder,Mission.SchroederInPath)
			luaStartDialog("ringgold_hit")
		end
	end

-- Player units check
	Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
	
	if table.getn(Mission.PlayerUnits) == 0 and Mission.MissionPhase < 4 then
		--luaUS07CorsairSpawn()
		
	elseif table.getn(Mission.PlayerUnits) == 0 and Mission.MissionPhase == 4 then
		--luaUS07RocketCorsairSpawn()
		
	elseif table.getn(Mission.PlayerUnits) == 0 and Mission.MissionPhase == 5 then
		--luaUS07CorsairSpawn()
		
	elseif table.getn(Mission.PlayerUnits) == 0 and Mission.MissionPhase == 6 then
		--luaUS07DauntlessSpawn()
		
	elseif table.getn(Mission.PlayerUnits) == 0  and Mission.MissionPhase == 7 then
		--luaUS07CorsairSpawn()
	end
end

-- Mission functions
function luaUS07PreparePhase5()
	Mission.Kates = {}
	luaUS07KateSpawn()
	Mission.DeadTransportNum = 0
	AddListener("kill", "listenerTransportKilled", {
		["callback"] = "luaUS07TransportKilled",
		["entity"] = Mission.Transports,
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
		})			
	--luaUS07LaunchZero()
end

function luaUS07AAKilled()
	-- AA Kill listener callback
	Mission.AAs = luaRemoveDeadsFromTable(Mission.AAs)
	
	if table.getn(Mission.AAs) == 0 then
		RemoveListener("kill", "listenerAAkilled")
		luaObj_Completed("hidden", 1)
	end
	
end

function luaUS07TransportKilled(killedtransport)
	killedtransport.Dead = true
	Mission.KilledTransport = killedtransport
	Mission.DeadTransportNum = Mission.DeadTransportNum + 1
	Mission.Transports = luaRemoveDeadsFromTable(Mission.Transports)
	
	if luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) and table.getn(Mission.Transports) < Mission.MaxTransports then
		luaObj_Failed("secondary",1)
		MissionNarrative("usn07.obj_s1_failed")
	end
	
	if luaObj_GetSuccess("primary",4) == nil and Mission.DeadTransportNum == Mission.TransportLimit then
		luaUS07TransportsLost()
	end
end

function luaUS07CorsairSpawn()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 102,
			["Name"] = "F4U Corsair",
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.SpawnNav),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07CorsairSpawnCallback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100,
		
	},
	})
-- RELEASE_LOGOFF  	luaLog("Corsair spawn done")
end

function luaUS07CorsairSpawnCallback(corsair)
	table.insert(Mission.PlayerUnits, corsair)
	SquadronSetTravelAlt(corsair,150)
	SquadronSetAttackAlt(corsair,150)
	SquadronSetSpeed(corsair,100)
	PilotMoveToRange(corsair, Mission.DDNav,10)
	Mission.Corsair = corsair
	--luaJumpToUnit(Mission.ActualCorsair)
-- RELEASE_LOGOFF  	luaLog("spawn callback done")
	if not IsListenerActive("kill","listenerCorsairKill") then
		AddListener("kill","listenerCorsairKill", {
				["callback"] = "luaUS07CorsairKilled",
				["entity"] = {Mission.Corsair},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
				
-- RELEASE_LOGOFF  		luaLog("Rocket corsair kill listener added")
	end
end


function luaUS07RocketCorsairSpawn()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 102,
			["Name"] = "F4U Corsair",
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.SpawnNav),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07RocketCorsairSpawnCallback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100
	},
	})
-- RELEASE_LOGOFF  	luaLog("Rocket Corsair spawn done")
end

function luaUS07RocketCorsairSpawnCallback(corsair)
	SetSkillLevel(corsair,SKILL_SPNORMAL)
	table.insert(Mission.PlayerUnits, corsair)
	SquadronSetTravelAlt(corsair,150)
	SquadronSetAttackAlt(corsair,150)
	SquadronSetSpeed(corsair,100)
	Mission.Bunkers = luaRemoveDeadsFromTable(Mission.Bunkers)
	if table.getn(Mission.Bunkers) ~= 0 then
		local targetbunker = luaPickRnd(Mission.Bunkers)
		PilotMoveToRange(corsair, targetbunker,100)
	end
	Mission.ActualCorsair = corsair
	if Mission.FirstRocketCorsair then
		SetInvincible(Mission.ActualCorsair,true)
		Mission.FirstRocketCorsair = false
	end
	if not IsListenerActive("kill","listenerRocketKill") then
		AddListener("kill", "listenerRocketKill", {
				["callback"] = "luaUS07RocketKilled",
				["entity"] = {Mission.ActualCorsair},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
				
-- RELEASE_LOGOFF  		luaLog("Rocket corsair kill listener added")
	end
end

function luaUS07RocketKilled()
	if IsListenerActive("kill","listenerRocketKill") then
		RemoveListener("kill","listenerRocketKill")
	end
	if Mission.MissionPhase == 4 then
		luaUS07RocketCorsairSpawn()
		luaStartDialog("respawn")
	end
end

function luaUS07DauntlessSpawn()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 108,
			["Name"] = "SBD Dauntless",
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.SpawnNav),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07DauntlessSpawnCallback",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100
	},
	})
-- RELEASE_LOGOFF  	luaLog("Dauntless spawn done")
end

function luaUS07DauntlessSpawnCallback(dauntless)
	SetSkillLevel(dauntless,SKILL_SPNORMAL)
	table.insert(Mission.PlayerUnits, dauntless)
	PilotMoveToRange(dauntless, Mission.HQ,100)
	SquadronSetTravelAlt(dauntless,300)
	SquadronSetAttackAlt(dauntless,300)
	SquadronSetSpeed(dauntless,100)
	Mission.ActualDauntless = dauntless
	if Mission.FirstDauntless then
		Mission.FirstDauntless = false
		SetInvincible(Mission.ActualDauntless, true)
	end
	if not IsListenerActive("kill","listenerDauntlessKill") then
		AddListener("kill", "listenerDauntlessKill", {
				["callback"] = "luaUS07DauntlessKilled",
				["entity"] = {Mission.ActualDauntless},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
				})
				
-- RELEASE_LOGOFF  		luaLog("Dauntless kill listener added")
	end
end

function luaUS07DauntlessKilled(emptyDauntless)
	if IsListenerActive("kill","listenerDauntlessKill") then
		RemoveListener("kill","listenerDauntlessKill")
	end
	if Mission.MissionPhase == 6 then
		luaUS07DauntlessSpawn()
		luaStartDialog("respawn")
	end
end

function luaUS07CorsairKilled()
	if IsListenerActive("kill", "listenerCorsairKill") then
		RemoveListener("kill", "listenerCorsairKill")
	end
	if not Mission.EndMission then 
		luaUS07CorsairSpawn()
		if Mission.MissionPhase < 4 or Mission.MissionPhase > 6 then
			luaStartDialog("respawn")
		end
	end
end
function luaUS07DauntlessEmpty()
	if Mission.HQ.Party == 1 then
		if not Mission.EmptyD.Dead then
		 	
			SetRoleAvailable(Mission.EmptyD, EROLF_ALL, PLAYER_AI)
			PilotLand(Mission.EmptyD, Mission.BunkerHill)
			
			for idx,unit in pairs(Mission.PlayerUnits) do
				if unit == Mission.EmptyD then
					table.remove(Mission.PlayerUnits, idx)
				end
			end
		else 
			Mission.PlayerUnits = luaRemoveDeadsFromTable(Mission.PlayerUnits)
		end
		luaStartDialog("respawn")
		luaUS07DauntlessSpawn()
-- RELEASE_LOGOFF  		luaLog("luaUS07DauntlessSpawn meghivodott")
		Mission.DauntlessEmpty = true
	end
end

function luaUS07AirfieldKilled(entity,lastAttacker) 
	-- Airfield Kill listener callback
	if IsListenerActive("kill", "airfieldKillListener") then
		RemoveListener("kill", "airfieldKillListener")
	end
	
	if luaObj_IsActive("primary", 6) and luaObj_GetSuccess("primary", 6) == nil then
		luaObj_Failed("primary", 6)
		HideUnitHP(0)
		luaMissionFailedNew(Mission.Airfield, "usn07.obj_p6_failed_b")
	end
end

function luaUS07StartDestroyers()
	-- Destroyers moving inside the lagoon
	NavigatorMoveOnPath(Mission.Ringgold, Mission.DDpath)
	luaDelay(luaUS07BoatsMoveToLaunchArea, 35)
end

function luaUS07JapKatesDetected()
	-- Kates detected
	RemoveListener("recon", "JapKatesDetected")
	luaDelay(luaUS07TransportsHint,35)
	luaStartDialog("kates_objective")
	if GetSelectedUnit() ~= nil then
		SetInvincible(GetSelectedUnit(), 0.3)
	end
	Mission.LastUsed = GetSelectedUnit()
	luaUS07EM_Kates_Start()
	luaDelay(luaUS07SecondaryAdd,30)
end

function luaUS07BoatsLanded(landedboat)
	-- Boats landed on the beach
-- RELEASE_LOGOFF  	luaLog("Boats landed")
	if IsListenerActive("shipLanded", "landingListener") then
		RemoveListener("shipLanded", "landingListener")
	end
	--[[
	Mission.EMHiggins = landedboat
	SetInvincible(Mission.EMHiggins, true)
	SetWait(Mission,1)
	luaStartDialog("landing_success")
	luaUS07EM_Landing_Start()
	]]--
	Mission.Landed = 1
end

function luaUS07JapPeteSpawn()
	local position = luaPickRnd(Mission.PeteSpawnPoints)
-- RELEASE_LOGOFF  	luaLog("Petespawnpos:  "..position.Name)

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 171,
			["Name"] = "F1M Pete",
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 2,
		},
		{
			["Type"] = 171,
			["Name"] = "F1M Pete",
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 2,
		},
		{
			["Type"] = 171,
			["Name"] = "F1M Pete",
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 2,
		},
	
	},
	["area"] = {
		["refPos"] = GetPosition(position),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.Dashiell)
	},
	["callback"] = "luaUS07JapPeteSpawned",
	["excludeRadiusOverride"] = {
			["ownHorizontal"] = 5,
			["enemyHorizontal"] = 5,
			["ownVertical"] = 5,
			["enemyVertical"] = 5,
			["formationHorizontal"] = 350,
			
		},
	})
-- RELEASE_LOGOFF  	luaLog("Pete spawn done")
		
end

function luaUS07JapPeteSpawned(pete1,pete2,pete3)
	table.insert(Mission.Petes, pete1)
	table.insert(Mission.Petes, pete2)
	table.insert(Mission.Petes, pete3)
	for idx,unit in pairs(Mission.Petes) do
		PilotSetTarget(unit, Mission.Dashiell)
		SetSkillLevel(unit,Mission.PilotSkillLevel)
	end
-- RELEASE_LOGOFF  	luaLog("Pete spawncallback done - starting bomb run on Dashiell")
	
	luaDelay(luaUS07EmilySpawn, 1)
end

function luaUS07EmilySpawn()
	local position = luaPickRnd(Mission.EmilySpawnPoints)
	luaRemoveByName(Mission.EmilySpawnPoints, position.Name)
	
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 175,
			["Name"] = "H8K Emily",
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = Mission.EmilyEquipment,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(position),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.Dashiell)
	},
	["callback"] = "luaUS07EmilySpawned",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 300,
	},
	})
		
end

function luaUS07EmilySpawned(emily1)
	table.insert(Mission.Petes, emily1)
	PilotSetTarget(emily1, Mission.Dashiell)
	SetSkillLevel(emily1, Mission.PilotSkillLevel)
-- RELEASE_LOGOFF  	luaLog("Emily 1st group spawncallback done - starting bomb run on Dashiell")
	
	luaDelay(luaUS07EmilyTorpedoSpawn, 1)
	
end

function luaUS07EmilyTorpedoSpawn()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 175,
			["Name"] = "H8K Emily",
			["Race"] = JAPANESE,
			["WingCount"] = 1,
			["Equipment"] = 2,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(luaPickRnd(Mission.EmilySpawnPoints)),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.Dashiell)
	},
	["callback"] = "luaUS07EmilyTorpedoSpawned",
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 5,
		["enemyHorizontal"] = 5,
		["ownVertical"] = 5,
		["enemyVertical"] = 5,
		["formationHorizontal"] = 100,
	},
	})

end

function luaUS07EmilyTorpedoSpawned(emily3)
	table.insert(Mission.Petes, emily3)
	PilotSetTarget(emily3, Mission.Dashiell)
	SetSkillLevel(emily3, Mission.PilotSkillLevel)
	for idx,unit in pairs(Mission.Petes) do
		--AddUntouchableUnit(unit)
		SquadronSetTravelAlt(unit,150)
		if GetProperty(unit, "AmmoType") ~= 2 then
			--ha torpedos akkor nem allitunk release altot
			SquadronSetReleaseAlt(unit,400)
			SquadronSetAttackAlt(unit,400)
		end
		
		PutTo(unit, {["x"]=GetPosition(unit).x, ["y"]=400, ["z"]=GetPosition(unit).z})
	end
	
	Mission.PetesSpawned = table.getn(Mission.Petes)
	Mission.PetesReady = true
	Mission.PetesDropped = 0
		
	AddListener("kill", "listenerPeteKilled", {
			["callback"] = "luaUS07PeteKilled",
			["entity"] = Mission.Petes,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
			})
			
	AddListener("kill", "listenerDashiellKilled", {
			["callback"] = "luaUS07DashiellKilled",
			["entity"] = {Mission.Dashiell},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
			})
		
-- RELEASE_LOGOFF  	luaLog("Emily spawncallback done - starting torpedo run on Dashiell")
			
end

function luaUS07KateSpawn()
	-- Kate Spawn
	local spawnPos = GetPosition(luaPickRnd(Mission.KateSpawnPoints))
	
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 162,
			["Name"] = "B5N Kate",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
		
	},
	["area"] = {
		["refPos"] = spawnPos,
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07JapKateSpawned",
	["excludeRadiusOverride"] = {
		["formationHorizontal"] = 150,	
		["enemyVertical"] = 1,
		["enemyHorizontal"] = 1,	
	},
	})
-- RELEASE_LOGOFF  	luaLog("Kate spawn done")
end

function luaUS07JapKateSpawned(spawnedKate)
	table.insert(Mission.Kates, spawnedKate)
	SquadronSetTravelAlt(spawnedKate,200)
	SetSkillLevel(spawnedKate,Mission.PilotSkillLevel)
	local target = luaPickRnd(Mission.TargetTransports)
	luaRemoveByName(Mission.TargetTransports, target.Name)
	PilotSetTarget(spawnedKate, target)
	
	if table.getn(Mission.Kates) ~= 4 then
		luaUS07KateSpawn()
-- RELEASE_LOGOFF  		luaLog("kate callback done calling new spawn")
	else
		luaUS07KateStrafe()
		for idx,unit in pairs(Mission.Kates) do
			--AddUntouchableUnit(unit)
		end
		for idx,unit in pairs(Mission.Transports) do
			SetInvincible(unit, false)
			NavigatorSetTorpedoEvasion(unit,true)
		end
		Mission.KatesDropped = 0
		AddListener("recon", "JapKatesDetected", {
					["callback"] = "luaUS07JapKatesDetected",
					["entity"] = Mission.Kates,
					["oldLevel"] = {},
					["newLevel"] = {2},
					["party"] = { PARTY_ALLIED},
					})
				
		AddListener("kill", "listenerKateKilled", {
					["callback"] = "luaUS07KateKilled",
					["entity"] = Mission.Kates,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
			
-- RELEASE_LOGOFF  		luaLog("All Kates spawned - starting torpedo run on Transport Ships")
	end
end

function luaUS07KateKilled(entity)
	-- Kate Kill szamlalo
	Mission.Kates = luaRemoveDeadsFromTable(Mission.Kates)
	
	if table.getn(Mission.Kates) == 0 then
		luaDelay(luaUS07TransportsDelayedCheck, 6)
-- RELEASE_LOGOFF  		luaLog("Kates killed ezerrel!")
		if IsListenerActive("kill", "listenerKateKilled") then
			RemoveListener("kill", "listenerKateKilled")
		end
		if IsListenerActive("ammoType", "listenerKateAmmo") then
			RemoveListener("ammoType", "listenerKateAmmo")
		end
		if IsListenerActive("exitzone", "listenerKateExited") then
			RemoveListener("exitzone", "listenerKateExited")
		end
	end
end

function luaUS07KateStrafe()
	Mission.Kates = luaRemoveDeadsFromTable(Mission.Kates)
	for idx,unit in pairs(Mission.Kates) do
		if GetProperty(unit, "unitcommand") == "moveto" or GetProperty(unit, "unitcommand") == "retreat" then
			local target = luaPickRnd(luaRemoveDeadsFromTable(Mission.Transports))
			PilotSetTarget(unit,target)
		end
	end
	luaDelay(luaUS07KateStrafe,3)
end

function luaUS07TransportsDelayedCheck()
	if Mission.EndMission then
		return
	else
		Mission.Transports = luaRemoveDeadsFromTable(Mission.Transports)
			if IsListenerActive("ammoType", "listenerKateAmmo") then
				RemoveListener("ammoType", "listenerKateAmmo")
			end
			if IsListenerActive("kill", "listenerKateKilled") then
				RemoveListener("kill", "listenerKateKilled")
			end
			if IsListenerActive("exitzone", "listenerKateExited") then
				RemoveListener("exitzone", "listenerKateExited")
			end
			if IsListenerActive("kill", "listenerTransportKilled") then
				RemoveListener("kill", "listenerTransportKilled")
			end
			if table.getn(Mission.Transports) == Mission.MaxTransports then
				luaObj_Completed("secondary",1,true)
			end
		if luaObj_GetSuccess("primary", 4) == nil and table.getn(Mission.Transports) + Mission.TransportLimit > Mission.MaxTransports then
			luaObj_Completed("primary", 4,true)
			HideScoreDisplay(4,0)
			for idx,unit in pairs(Mission.Transports) do
				local percentage = GetHpPercentage(unit)
				SetInvincible(unit, percentage)
			end
			Mission.MissionPhase = 6
			Mission.FirstRun = true
		end
	end
end

function luaUS07TransportsLost()
	-- Transports lost - game over
	Mission.EndMission = true
	HideScoreDisplay(4,0)
	luaObj_Failed("primary", 4)
	Mission.Transports = luaRemoveDeadsFromTable(Mission.Transports)
	luaMissionFailedNew(Mission.KilledTransport, "usn07.obj_p4_failed")
end

function luaUS07PeteStrafe(entity,ammoType)
	-- Pete-ek strafe-elnek bombazas utan
	Mission.PetesDropped = Mission.PetesDropped + 1
	PilotSetTarget(entity, Mission.Dashiell)
-- RELEASE_LOGOFF  	luaLog("Pete Strafing")
		
	if Mission.PetesDropped == Mission.PetesSpawned then
		if IsListenerActive("ammoType", "listenerPeteAmmo") then
			RemoveListener("ammoType", "listenerPeteAmmo")
		end
	end
end

function luaUS07PeteKilled(entity)
	entity.Dead = true
	Mission.Petes = luaRemoveDeadsFromTable(Mission.Petes)
	if table.getn(Mission.Petes) == 0 then
		if IsListenerActive("kill", "listenerPeteKilled") then
			RemoveListener("kill", "listenerPeteKilled")
		end
		
		if IsListenerActive("ammoType", "listenerPeteAmmo") then
			RemoveListener("ammoType", "listenerPeteAmmo")
		end
		
		if IsListenerActive("kill", "listenerDashiellKilled") then
			RemoveListener("kill", "listenerDashiellKilled")
		end
		
		-- Dashiell meguszta a tamadast, Petek meghaltak, primary 1 complete
		luaObj_Completed("primary",1,true)
		HideUnitHP(0)
		SetInvincible(Mission.Ringgold, false)
		AddPowerup({
				["classID"] = "evasive_manoeuvre",	
				["useLimit"]	 = 1,
				})
				
		-- pahase change
		Mission.MissionPhase = 3
		Mission.FirstRun = true

	end
end

function luaUS07DashiellKilled(target,lastattacker)
	if IsListenerActive("ammoType", "listenerPeteAmmo") then
		RemoveListener("ammoType", "listenerPeteAmmo")
	end
	if IsListenerActive("kill", "listenerPeteKilled") then
		RemoveListener("kill", "listenerPeteKilled")
	end
	if IsListenerActive("kill", "listenerDashiellKilled") then
		RemoveListener("kill", "listenerDashiellKilled")
	end
	-- Dashiellt kibombaztak a Petek, primary 1 failed -> game over
	luaObj_Failed("primary",1)
	HideUnitHP(0)
	Mission.EndMission = true
	luaMissionFailedNew(Mission.Dashiell, "usn07.obj_p1_failed")
end

function luaUS07DashiellDamaged()
	-- Dashiell megserult, lebenul
	NavigatorStop(Mission.Dashiell)
	SetRepairEffectivity(Mission.Dashiell, 0)
	tempPercent = GetHpPercentage(Mission.Dashiell)
	tempPos = GetPosition(Mission.Dashiell)
	SetInvincible(Mission.Dashiell, tempPercent)
	Effect("GiantSmoke", tempPos, Mission.Dashiell)
	Mission.DashiellDamaged = 1
	
end

function luaUS07BoatsMoveToLaunchArea()
	-- Elindulnak a partraszallok a gyujtopont fele
	for i=1,8 do
		NavigatorMoveToRange(Mission.BoatsRed1[i], Mission.GatherPointsRed1[i])
		SetInvincible(Mission.BoatsRed1[i], true)
	end
	for i=1,8 do
		NavigatorMoveToRange(Mission.BoatsRed2[i], Mission.GatherPointsRed2[i])
		SetInvincible(Mission.BoatsRed2[i], true)
	end
	for i=1,8 do
		NavigatorMoveToRange(Mission.BoatsRed3[i], Mission.GatherPointsRed3[i])
		SetInvincible(Mission.BoatsRed3[i], true)
	end
			
	Mission.BoatsArrivedFlag = 0
	AddProximityTrigger(Mission.BoatsRed3[1], "BoatTrigger", "luaUS07BoatsArrived", Mission.BoatNav, 350)
end

function luaUS07HQKilled()
	-- HQ killed, objektiva complete
	luaObj_Completed("primary", 5,true)
	HideUnitHP(0)
	MissionNarrative("usn07.obj_p5_success")
	luaStartDialog("HQ_destroyed")
-- RELEASE_LOGOFF  	luaLog("HQ objektiva complete")
	if Mission.HQTimer == 1 then
		CountdownCancel()
		Mission.CounterState = -1
-- RELEASE_LOGOFF  		luaLog("HQ timer cancelled")
	end
	if IsListenerActive("ammoType", "listenerDauntlessAmmo") then
		RemoveListener("ammoType", "listenerDauntlessAmmo")
	end
	Mission.MissionPhase = 7
	Mission.FirstRun = true
end

function luaUS07HQTimerExpired()
	-- Primary 3 failed - Game Over
	Mission.CounterState = -1 
	luaObj_Failed("primary", 5)
	
	luaMissionFailedNew(Mission.HQ, "usn07.obj_p5_failed")
end

function luaUS07BoatsArrived()
	-- Boats are at the launch position
	RemoveTrigger(Mission.BoatsRed3[1], "BoatTrigger")
	Mission.BoatsArrivedFlag = 1
end

function luaUS07TurretTimerExpired()
	-- Primary 1 failed - Game Over
	luaObj_Failed("primary",2)
	HideScoreDisplay(2,0)
	local cameraturret = luaPickRnd(Mission.CoastalGuns)
	
	luaMissionFailedNew(cameraturret, "usn07.obj_p2_failed")
end

function luaUS07BunkerTimerExpired()
	-- Primary 3 failed - Game Over
	Mission.CounterState = -1
	luaObj_Failed("primary", 3)
	bunker = luaPickRnd(Mission.Bunkers)
	
	-- Bunkers have not been destroyed our Marines suffered heavy casualties!
	luaMissionFailedNew(bunker, "usn07.obj_p3_failed")
end

function luaUS07AirstrikeSpawn()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 158,
			["Name"] = "D3A Val",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
		{
			["Type"] = 158,
			["Name"] = "D3A Val",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.AirstrikeNav),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07AirstrikeSpawned",
	["excludeRadiusOverride"] = {
		["formationHorizontal"] = 150,	
		["enemyVertical"] = 1,
		["enemyHorizontal"] = 1,	
	},
	})
-- RELEASE_LOGOFF  	luaLog("Airstrike spawn done")	
end

function luaUS07AirstrikeSpawned(val1, val2)
	Mission.Vals = {val1, val2}
	for idx,unit in pairs(Mission.Vals) do
		--AddUntouchableUnit(unit)
		PilotSetTarget(unit, Mission.Hangar)
		SquadronSetTravelAlt(unit, 300)
		SquadronSetAttackAlt(unit, 300)
		SetSkillLevel(unit,Mission.PilotSkillLevel)
	end
	
	Mission.ValsDropped = 0
	AddListener("kill", "listenerValKilled", {
			["callback"] = "luaUS07ValKilled",
			["entity"] = Mission.Vals,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
			})
	AddListener("recon", "JapValsDetected", {
			["callback"] = "luaUS07ValsDetected",
			["entity"] = {Mission.Vals[1]},
			["oldLevel"] = {},
			["newLevel"] = {2},
			["party"] = { PARTY_ALLIED},
			})
			
-- RELEASE_LOGOFF  	luaLog("Airstrike spawncallback done - starting bomb run against Airfield")

end

function luaUS07ValsDetected()
	luaStartDialog("vals_objective")
	if GetSelectedUnit() ~= nil then
		SetInvincible(GetSelectedUnit(), 0.3)
	end
	Mission.LastUsed = GetSelectedUnit()
	luaUS07EM_Vals_Start()
	luaDelay(luaUS07HintVals,35)
	if IsListenerActive("recon", "JapValsDetected") then
		RemoveListener("recon", "JapValsDetected")
	end
end

function luaUS07ValStrafe(entity)
	Mission.ValsDropped = Mission.ValsDropped + 1
	PilotSetTarget(entity, Mission.Airfield)
	if Mission.ValsDropped == 2 then
		if IsListenerActive("ammoType", "listenerValAmmo") then
			RemoveListener("ammoType", "listenerValAmmo")
		end
	end
end

function luaUS07ValKilled()
	Mission.Vals = luaRemoveDeadsFromTable(Mission.Vals)
	if table.getn(Mission.Vals) == 0 then
		if IsListenerActive("kill", "listenerValKilled") then
			RemoveListener("kill", "listenerValKilled")
		end
		if IsListenerActive("ammoType", "listenerValAmmo") then
			RemoveListener("ammoType", "listenerValAmmo")
		end
		luaDelay(luaUS07AirfieldDelayCheck, 5)
		
	end
end

function luaUS07AirfieldDelayCheck()
	if luaObj_IsActive("primary", 6) and luaObj_GetSuccess("primary", 6) == nil then
		if not Mission.Hangar.Dead then
			if IsListenerActive("kill", "airfieldKillListener") then
				RemoveListener("kill", "airfieldKillListener")
			end
			luaObj_Completed("primary", 6,true)
			HideUnitHP(0)
			luaStartDialog("victory")
			--SetWait(Mission, 8)
		end
	end
end

function luaUS07MissionEnd()
	luaMissionCompletedNew(Mission.Hangar, "usn07.obj_p6_success")
	local medal = luaGetMedalReward()
	if (medal == MEDAL_SILVER) then
		Scoring_GrantBonus("US07_SCORING_SILVER", "usn07.bonus1_title", "usn07.bonus1_text", 101)
	end
	if (medal == MEDAL_GOLD) then
		Scoring_GrantBonus("US07_SCORING_SILVER", "usn07.bonus1_title", "usn07.bonus1_text", 101)
		Scoring_GrantBonus("US07_SCORING_GOLD", "usn07.bonus2_title", "usn07.bonus2_text", 102)
	end
end

function luaUS07Zero2Spawn()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
		
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.ZeroNav2),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07Zero2SpawnCallback",
	["excludeRadiusOverride"] = {
		["formationHorizontal"] = 300,	
		["enemyVertical"] = 1,
		["enemyHorizontal"] = 1,	
	},
	})
-- RELEASE_LOGOFF  	luaLog("Zero2 spawn done")	      
end

function luaUS07Zero2SpawnCallback(zero)
	PilotSetTarget(zero, Mission.ActualDauntless)
	SetSkillLevel(zero,Mission.PilotSkillLevel)
	Mission.Zeros2 = {}
	table.insert (Mission.Zeros2, zero)
	SquadronSetTravelAlt(zero,200)
	SquadronSetAttackAlt(zero,200)
	SquadronSetSpeed(zero,100)
	AddListener("kill", "listenerZeros2Killed", {
			["callback"] = "luaUS07Zeros2Killed",
			["entity"] = Mission.Zeros2,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
			})
-- RELEASE_LOGOFF  	luaLog("Zero 2 spawn callback done")
end

function luaUS07Zeros2Killed()
	RemoveListener("kill", "listenerZeros2Killed")
	if Mission.HQ.Party == 1 then
		--luaStartDialog("HQ_objective")
	end
end

function luaUS07Zero3Spawn()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},
		{
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Race"] = JAPANESE,
			["WingCount"] = 3,
			["Equipment"] = 0,
		},	
	},
	["area"] = {
		["refPos"] = GetPosition(Mission.ZeroNav2),
		["angleRange"] = {-1,1},
		["lookAt"] = GetPosition(Mission.HQ)
	},
	["callback"] = "luaUS07Zero3SpawnCallback",
	["excludeRadiusOverride"] = {
		["formationHorizontal"] = 400,
		["enemyVertical"] = 1,
		["enemyHorizontal"] = 1,	
	},
	})
-- RELEASE_LOGOFF  	luaLog("Zero3 spawn done")	
end

function luaUS07Zero3SpawnCallback(zero1,zero2)
	Mission.Zeros3 = {}
	table.insert(Mission.Zeros3, zero1)
	table.insert(Mission.Zeros3, zero2)
	for idx,unit in pairs(Mission.Zeros3) do
		SetSkillLevel(unit,Mission.PilotSkillLevel)
		PilotMoveToRange(unit, Mission.Airfield, 50)
		SquadronSetTravelAlt(unit,200)
		SquadronSetAttackAlt(unit,200)
		SquadronSetSpeed(unit,100)
	end
end

function luaUS07GenerateTurrets()
	SetInvincible(FindEntity("Coastal Red 2 6"), 0.5)
	Mission.CoastalGuns = {}
	for i=1,6 do
		table.insert(Mission.CoastalGuns, Mission.CoastalGunsRed1[i])
	end
	for i=1,6 do
		table.insert(Mission.CoastalGuns, Mission.CoastalGunsRed2[i])
	end
	
	for i=1,6 do
		table.insert(Mission.CoastalGuns, Mission.CoastalGunsRed3[i])
	end	
	Mission.MaxTurrets = table.getn(Mission.CoastalGuns)
	Mission.TurretsLeft = table.getn(Mission.CoastalGuns)
end

function luaUS07GenerateBunkers()
	--fix Bunkerek
	Mission.Fixbunker1 = GenerateObject(Mission.FixBunkers[1].Name)
	Mission.Fixbunker2 = GenerateObject(Mission.FixBunkers[2].Name)
	Mission.Fixbunker3 = GenerateObject(Mission.FixBunkers[3].Name)
	table.insert(Mission.Bunkers, Mission.Fixbunker1)
	table.insert(Mission.Bunkers, Mission.Fixbunker2)
	table.insert(Mission.Bunkers, Mission.Fixbunker3)
	for i=1,4 do
		randomBunker = luaPickRnd(Mission.HiddenBunkers)
		generatedBunker = GenerateObject(randomBunker.Name)
		luaRemoveByName(Mission.HiddenBunkers,randomBunker.Name)
		table.insert(Mission.Bunkers, generatedBunker)
	end
	for idx,unit in pairs(Mission.Bunkers) do
		AddUntouchableUnit(unit)
	end
	Mission.MaxBunkers = table.getn(Mission.Bunkers)
	luaStartDialog("bunkers_objective")
	--[[
	if GetSelectedUnit() ~= nil then
		SetInvincible(GetSelectedUnit(), 0.3)
	end
	]]
	Mission.LastUsed = GetSelectedUnit()
	luaUS07EM_Bunkers_Start()
end

function luaUS07SecondaryAdd()
	luaObj_Add("secondary",1)
end

function luaUS07HintRocketSquad()
	if not Mission.EndMission then
		ShowHint("USN07_Hint_Rocketsquad")
	end
end

function luaUS07HintStall()
	if not Mission.StallHintShowed then
		Mission.StallHintShowed = 0
	end
	ShowHint("Advanced_Hint_Stall")
	Mission.StallHintShowed = Mission.StallHintShowed + 1
	if Mission.StallHintShowed < 3 then
		luaDelay(luaUS07HintStall,180)
	end
end

function luaUS07HintVals()
	if not Mission.EndMission then
		ShowHint("USN07_Hint_Attackplanes")
	end
end

function luaUS07HintStrafeBunkers()
	if not Mission.EndMission then
		ShowHint("USN07_Hint_Strafebunkers")
	end
end

function luaUS07HintAA()
	if not Mission.EndMission then
		ShowHint("USN07_Hint_Aahint")
	end
end

function luaUS07TransportsHint()
	if not Mission.EndMission then
		ShowHint("USN07_Hint_Transports")
	end
end

-- Misc functuions
function teszt1()
	
end

function luaUS07MovCam() 
      local pos0 = {
           ["postype"]="target", 
           ["position"]= { 
               ["parent"]=nil, 
               ["pos"] = { -378.95, 9.30, -374.37 }, 
           }, 
           ["transformtype"]="keepy", 
           ["starttime"]=0.0, 
           ["blendtime"]=0.0, 
           ["linearblend"]=1.0, 
           ["zoom"] = 1.15, 
       } 
   
  MovCamNew_AddPosition(pos0)  
      local pos0 = { 
           ["postype"]="camera", 
           ["position"]= { 
               ["parent"]=nil, 
               ["pos"] = { -1983.43, 600, -314.81, }, 
           }, 
           ["transformtype"]="keepy", 
           ["starttime"]=0.0, 
           ["blendtime"]=0.0, 
           ["linearblend"]=1.0, 
                          ["zoom"] = 1.15, 
       } 
   
  MovCamNew_AddPosition(pos0) 
      
end

function luaUS07FireStart()
	local fireSpot = luaPickRnd(Mission.FireSpots)
	luaRemoveByName(Mission.FireSpots, fireSpot.Name)
	local effectTypes = {
						"EnvironmentSmoke",
						"SmallFire",
						"WreckSmoke",
						"WreckFire",
						}
						
	local effectName = luaPickRnd(effectTypes)
		
	Effect(effectName,GetPosition(fireSpot))
end

function luaUS07RinggoldArrived()
	luaStartDialog("ringgold_in_position")
end

function killturrets()
	for idx,unit in pairs (Mission.CoastalGuns) do
		Kill(unit)
	end
end

function killbunkers()
	for idx,unit in pairs (Mission.Bunkers) do
		Kill(unit)
	end
end

function killpetes()
	for idx,unit in pairs (Mission.Petes) do
		Kill(unit)
	end
end

function killkates()
	for idx,unit in pairs (Mission.Kates) do
		Kill(unit)
	end
end

function landingxx()
	for idx,unit in pairs (Mission.BoatsRed1) do
		StartLanding2(unit)
		SetInvincible(unit, false)
	end
	
	for idx,unit in pairs (Mission.BoatsRed2) do
		StartLanding2(unit)
		SetInvincible(unit, false)
	end
	
	for idx,unit in pairs (Mission.BoatsRed3) do
		StartLanding2(unit)
		SetInvincible(unit, false)
	end

end

function luaUS07LaunchZero()
	local zero = LaunchAirBaseSlot(Mission.Airfield, 1)
	zero.Party = "PARTY_JAPANESE"
end

function luaUS07OperettArtillery()
	--[[
	for idx,unit in pairs(Mission.OperettShips) do
		local actTarget = luaPickRnd(Mission.ArtilleryTargets)
		SetFireTarget(unit, actTarget)
		--luaLog("operett target valasztas: "..unit.Name.."  lovi  "..actTarget.Name)
	end
	luaDelay(luaUS07OperettArtillery,15)
	]]
end

--[[
*****************************************************************************************
**                         		INGAME ENGINE MOVIES                                   **
*****************************************************************************************
]]

function luaUS07EM_Turrets_Start()
	if Mission.EndMission then
		return
	else
		Mission.EMRuns = true
		Blackout(true, "luaUS07EM_Turrets", 0.5)
	end
end

function luaUS07EM_Turrets()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = FindEntity("Coastal Red 1 2"), ["distance"] = 300, ["theta"] = 13, ["rho"] = 140, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("Coastal Red 1 1"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 110, ["moveTime"] = 5, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("Coastal Red 2 7"), ["distance"] = 200, ["theta"] = 7, ["rho"] = 90, ["moveTime"] = 10, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = FindEntity("Coastal Red 3 5"), ["distance"] = 200, ["theta"] = 6, ["rho"] = 90, ["moveTime"] = 17, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
			    },
    			luaUS07EM_Turrets_Fade
   				)
end

function luaUS07EM_Turrets_Fade()
-- RELEASE_LOGOFF  	luaLog("Turrets fade meghivodott")
	Blackout(true, "luaUS07EM_Turrets_End", 0.5)
end

function luaUS07EM_Turrets_End()
-- RELEASE_LOGOFF  	luaLog("Turrets end meghivodott")
	if Mission.LastUsed ~= nil and not Mission.LastUsed.Dead then
		SetSelectedUnit(Mission.LastUsed)
		SetInvincible(Mission.LastUsed,false)
		EnableInput(true)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
	luaDelay(luaUS07P2Add,2)
end

function luaUS07EM_Bunkers_Start()
	if Mission.EndMission then
		return
	else
		Mission.EMRuns = true
		Blackout(true, "luaUS07EM_Bunkers", 0.5)
	end
end

function luaUS07EM_Bunkers()
	Mission.FirstRocketCorsair = true
	luaUS07RocketCorsairSpawn()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Fixbunker1, ["distance"] = 300, ["theta"] = 10, ["rho"] = 30, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0.5},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Fixbunker2, ["distance"] = 200, ["theta"] = 9, ["rho"] = 10, ["moveTime"] = 6, ["smoothtime"] = 1, ["nonlinearblend"] = 0.5},
			   {["postype"] = "cameraandtarget", ["target"] = Mission.Fixbunker2, ["distance"] = 180, ["theta"] = 9, ["rho"] = 12, ["moveTime"] = 2, ["smoothtime"] = 1, ["nonlinearblend"] = 0.0},
			    },
    			luaUS07EM_Bunkers_Fade
	)
end

function luaUS07EM_Bunkers_Fade()
-- RELEASE_LOGOFF  	luaLog("Bunkers fade meghivodott")	
	Blackout(true, "luaUS07EM_Bunkers_End", 0.5)
end

function luaUS07EM_Bunkers_End()
-- RELEASE_LOGOFF  	luaLog("Bunkers end meghivodott")	
	if Mission.ActualCorsair ~= nil and not Mission.ActualCorsair.Dead then
		SetSelectedUnit(Mission.ActualCorsair)
		SetInvincible(Mission.ActualCorsair,false)
		EnableInput(true)
		luaDelay(luaUS07HintRocketSquad,20)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
	luaDelay(luaUS07P3Add,2)
end

function luaUS07EM_Kates_Start()
	if Mission.EndMission then
		return
	else
		Mission.EMRuns = true
		if (Mission.CheckpointLoaded == nil) or (not Mission.CheckpointLoaded) then
			Blackout(true, "luaUS07_CheckpointSave", 0.5)
		else
			Blackout(true, "luaUS07EM_Kates", 0.5)
		end
	end
end

function luaUS07_CheckpointSave()
	--luaCheckpoint(1, nil)
	luaUS07EM_Kates()
end

function luaUS07EM_Kates()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Kates[1], ["distance"] = 70, ["theta"] = -9, ["rho"] = 60, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Kates[1], ["distance"] = 40, ["theta"] = -7, ["rho"] = 10, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Kates[1], ["distance"] = 20, ["theta"] = -4, ["rho"] = 4, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
			    },
    			luaUS07EM_Kates_Fade
				)
end

function luaUS07EM_Kates_Fade()
	Blackout(true, "luaUS07EM_Kates_End", 0.5)
end

function luaUS07EM_Kates_End()
	if Mission.Corsair ~= nil and not Mission.Corsair.Dead then
		SetSelectedUnit(Mission.Corsair)
		SetInvincible(Mission.Corsair,false)
		EnableInput(true)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
	luaDelay(luaUS07P4Add,2)
	
end

function luaUS07EM_Landing_Start()
	if Mission.EndMission then
		return
	else
		if not Mission.EMRuns then
			if GetSelectedUnit() ~= nil then
				SetInvincible(GetSelectedUnit(), 0.3)
			end
			Mission.LastUsed = GetSelectedUnit()
			Mission.EMRuns = true
			Blackout(true, "luaUS07EM_Landing", 0.5)
		else
			luaDelay(luaUS07EM_Landing_Start,5)
		end
	end
end

function luaUS07EM_Landing()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.EMHiggins, ["distance"] = 100, ["theta"] = 130, ["rho"] = 60, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.EMHiggins, ["distance"] = 70, ["theta"] = 150, ["rho"] = 10, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.EMHiggins, ["distance"] = 40, ["theta"] = 170, ["rho"] = 10, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
			    },
    			luaUS07EM_Landing_Fade
				)
end

function luaUS07EM_Landing_Fade()
	Blackout(true, "luaUS07EM_Landing_End", 0.5)
end

function luaUS07EM_Landing_End()
	if Mission.LastUsed ~= nil and not Mission.LastUsed.Dead then
		SetSelectedUnit(Mission.LastUsed)
		SetInvincible(Mission.LastUsed,false)
		EnableInput(true)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
end

function luaUS07EM_HQ_Start()
	if Mission.EndMission then
		return
	else
		Mission.FirstDauntless = true
		luaUS07DauntlessSpawn()
		luaUS07Zero2Spawn()
		Mission.EMRuns = true
		Blackout(true, "luaUS07EM_HQ", 0.5)
-- RELEASE_LOGOFF  		luaLog("belefutottam a moziba")
	end
end

function luaUS07EM_HQ()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.HQ, ["distance"] = 260, ["theta"] = 15, ["rho"] = 40, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.HQ, ["distance"] = 120, ["theta"] = 5, ["rho"] = 145, ["moveTime"] = 7, ["smoothtime"] = 0, ["nonlinearblend"] = 0.0},
			    },
    			luaUS07EM_HQ_Fade
				)
-- RELEASE_LOGOFF  	luaLog("lement a mozi")
	luaStartDialog("HQ_objective")	
end

function luaUS07EM_HQ_Fade()
	Blackout(true, "luaUS07EM_HQ_End", 0.5)
end

function luaUS07EM_HQ_End()
	if Mission.ActualDauntless ~= nil and not Mission.ActualDauntless.Dead then
		SetSelectedUnit(Mission.ActualDauntless)
		SetInvincible(Mission.ActualDauntless,false)
		EnableInput(true)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
	luaDelay(luaUS07P5Add,2)
	SetInvincible(Mission.HQ, false)
	luaObj_Add("primary", 5, Mission.HQ, false)
-- RELEASE_LOGOFF  	luaLog("lefutott a 	luaDelay(luaUS07P5Add,3)!!!")
end

function luaUS07EM_Vals_Start()
	if Mission.EndMission then
		return
	else
		Mission.EMRuns = true
		Blackout(true, "luaUS07EM_Vals", 0.5)
	end
end

function luaUS07EM_Vals()
	Blackout(false, "", 0.5)
	luaIngameMovie(
                {
	  	       {["postype"] = "cameraandtarget", ["target"] = Mission.Vals[1], ["distance"] = 70, ["theta"] = 10, ["rho"] = 60, ["moveTime"] = 0, ["smoothtime"] = 0, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Vals[1], ["distance"] = 40, ["theta"] = 7, ["rho"] = 10, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
               {["postype"] = "cameraandtarget", ["target"] = Mission.Vals[1], ["distance"] = 15, ["theta"] = 4, ["rho"] = 4, ["moveTime"] = 6, ["smoothtime"] = 2, ["nonlinearblend"] = 0},
			    },
    			luaUS07EM_Vals_Fade
				)
end

function luaUS07EM_Vals_Fade()
	Blackout(true, "luaUS07EM_Vals_End", 0.5)
end

function luaUS07EM_Vals_End()
	if Mission.Corsair ~= nil and not Mission.Corsair.Dead then
		SetSelectedUnit(Mission.Corsair)
		SetInvincible(Mission.Corsair,false)
		EnableInput(true)
	else
		luaUS07CheckPlane()
	end
	Blackout(false, "", 0.5)
	Mission.EMRuns = false
	luaDelay(luaUS07P6Add,2)
end

function luaUS07P6Add()
	luaObj_Add("primary", 6, Mission.Vals, false)
	SetRace(Mission.Airfield, 2)
	luaDelay(luaUS07DispalyHPDelay,0.5)
end

function luaUS07DispalyHPDelay()
	DisplayUnitHP({Mission.Airfield},"usn07.obj_p6")
end
function luaUS07P5Add()
	Countdown("usn07.obj_hq_counter", 1, Mission.CountDownTime, "luaUS07HQTimerExpired")
	DisplayUnitHP({Mission.HQ},"usn07.obj_p5")
	Mission.CounterState = 1
	Mission.HQTimer = 1
	AddPowerup({
				["classID"] = "full_throttle",	
				["useLimit"]	 = 1,
				})
end

function luaUS07P4Add()
	luaObj_Add("primary", 4, Mission.Kates, false)
end

function luaUS07P3Add()
	luaObj_Add("primary", 3, Mission.Bunkers, false)
	Countdown("usn07.obj_bunker_counter", 1, Mission.CountDownTime, "luaUS07BunkerTimerExpired")
	Mission.CounterState = 1
end

function luaUS07P2Add()
	for idx,unit in pairs(Mission.CoastalGuns) do
		SetInvincible(unit, false)
	end
	luaObj_Add("primary",2, Mission.CoastalGuns, false)
	Countdown("usn07.obj_turret_counter", 1, Mission.CountDownTime, "luaUS07TurretTimerExpired")
	Mission.CounterState = 1
	DisplayScores(2,0,"usn07.obj_p2","usn07.obj_p2_display")
end

function luaUS07CheckPlane()
	local planeTable = luaGetOwnUnits("plane", PARTY_ALLIED)
	if table.getn(planeTable) > 0 then
		SetSelectedUnit(planeTable[1])
		SetInvincible(planeTable[1],false)
		EnableInput(true)
	else
		luaDelay(luaUS07CheckPlane, 1)
	end
end

--[[
*****************************************************************************************
**                         			  CHECKPOINT FUNCTIONS							   **
*****************************************************************************************
]]
function luaUS07PhaseManager()
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)
	if num[1] == 1 then
		Mission.MissionPhase = 5
		Mission.FirstRun = false
		Mission.Phase5ThinkCounter = 0
		for i=1,(Mission.MissionPhase-1) do
			luaUS07FireStart()
		end
		for idx,unit in pairs (Mission.Faketargets) do
			SetForcedReconLevel(unit, 0, 0)
		end		
		
		--HQ set
		AddUntouchableUnit(Mission.HQ)
		SetGuiName(Mission.HQ, "usn07.tarawa_hq")
		
		-- Airfield set to neutral and invincible
		SetParty(Mission.Airfield, 2)
		AddUntouchableUnit(Mission.Airfield)
		SetInvincible(Mission.Hangar, 0.2)
		SetInvincible(Mission.Airfield, 0.2)
		-- AA Kill listener
		AddListener("kill", "listenerAAkilled", {
					["callback"] = "luaUS07AAKilled",
					["entity"] = Mission.AAs,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
					})
					
		luaObj_Add("hidden",1)
		luaUS07OperettArtillery()
		
		--coastal gunok es bunkerek generalasa, killezese
		Mission.Fixbunker1 = GenerateObject(Mission.FixBunkers[1].Name)
		Mission.Fixbunker2 = GenerateObject(Mission.FixBunkers[2].Name)
		Mission.Fixbunker3 = GenerateObject(Mission.FixBunkers[3].Name)
		Mission.Bunkers = {}
		table.insert(Mission.Bunkers, Mission.Fixbunker1)
		table.insert(Mission.Bunkers, Mission.Fixbunker2)
		table.insert(Mission.Bunkers, Mission.Fixbunker3)
		for i=1,4 do
			randomBunker = luaPickRnd(Mission.HiddenBunkers)
			generatedBunker = GenerateObject(randomBunker.Name)
			luaRemoveByName(Mission.HiddenBunkers,randomBunker.Name)
			table.insert(Mission.Bunkers, generatedBunker)
		end
		luaDelay(luaUS07Cp1DelayedKill,2)
	end
end

function luaUS07Cp1DelayedKill()
	if Mission.EndMission then 
		return
	else
		for idx,unit in pairs(Mission.CoastalGunsRed1) do
			AddDamage(unit,10000)
		end
		for idx,unit in pairs(Mission.CoastalGunsRed2) do
			AddDamage(unit,10000)
		end
		for idx,unit in pairs(Mission.CoastalGunsRed3) do
			AddDamage(unit,10000)
		end
		
		for idx,unit in pairs(Mission.Bunkers) do
			AddDamage(unit,10000)
		end
	end
end

function luaUS09_Checkpoint01_SearchInTable(szName, tTable)
	local j = 0
	local bIsUnitAlive = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUS09_Checkpoint01_SearchInTable): szName = "..szName)
	--luaLog("(luaUS09_Checkpoint01_SearchInTable): table hossz = "..nLength)
	while (j < nLength) and (not bIsUnitAlive) do
		j = j + 1
		--luaLog("(luaUS09_Checkpoint01_SearchInTable): US tablaban az akt nev = "..tTable[j].Name)
		--luaLog(tTable[j][1])
		if (szName == tTable[j][1]) then
			bIsUnitAlive = true
		end
	end
	--luaLog("(luaUS09_Checkpoint01_SearchInTable): Visszatero boolean = ")
	--luaLog(bIsUnitAlive)
	return bIsUnitAlive, j
end

function luaUS09_Checkpoint01_GetUnitPos(szName, tTable)
	local j = 0
	local bFound = false
	local nLength = table.getn(tTable)
	--luaLog("(luaUS09_Checkpoint01_GetUnitPos): Table hossz = ")
	--luaLog(nLength)
	while (j < nLength) and (not bFound) do
		j = j + 1
		if (szName == tTable[j][1]) then
			bFound = true
		end
	end
	return tTable[j][2], tTable[j][3]
end

function luaUS07Cp1SavePositions()
	-- Ringgold & Dashiell positions
	--local tUSUnits = luaGetOwnUnits("ship", PARTY_ALLIED)
	local tUSUnits = Mission.UsDestroyers
	local tPosTable = {}
	for i, pUnit in pairs (tUSUnits) do
		if (not pUnit.Dead) then
			local nPos = GetPosition(pUnit)
			local nRot = GetRotation(pUnit)
			table.insert(tPosTable, {pUnit.Name, nPos, nRot})
		end
	end
	Mission.Checkpoint.USNPositions = tPosTable
end

function luaUS07Cp1LoadMissionData()
	Mission.Cp1DestroyerPos = Mission.Checkpoint.USNPositions
end

function luaUS07Cp1RelocateUnits()
-- RELEASE_LOGOFF  	luaLog(">>>>>>>>>>>>>>>>>>>LANDINGSTART<<<<<<<<<<<<<<<<<<<<<<<<<<")
	for idx,unit in pairs(Mission.BoatsRed1) do
		PutTo(unit, GetPosition(Mission.CheckpointBoatPos_Red1[idx]),180)
		local error = StartLanding2(unit)
-- RELEASE_LOGOFF  		luaLog(tostring(error))
	end
	for idx,unit in pairs(Mission.BoatsRed2) do
		PutTo(unit, GetPosition(Mission.CheckpointBoatPos_Red2[idx]),180)
		local error = StartLanding2(unit)
-- RELEASE_LOGOFF  		luaLog(tostring(error))
	end
	for idx,unit in pairs(Mission.BoatsRed3) do
		PutTo(unit, GetPosition(Mission.CheckpointBoatPos_Red3[idx]),180)
		local error = StartLanding2(unit)
-- RELEASE_LOGOFF  		luaLog(tostring(error))
	end
-- RELEASE_LOGOFF  	luaLog(">>>>>>>>>>>>>>>>>>>LANDINGEND<<<<<<<<<<<<<<<<<<<<<<<<<<")
	local tUSNUnits = luaGetCheckpointData("Units", "USUnits")
	tUSNUnits = tUSNUnits[1]
	for i, pShip in pairs (Mission.UsDestroyers) do
		local bIsUnitAlive, j = luaUS09_Checkpoint01_SearchInTable(pShip.Name, tUSNUnits)
		if (not bIsUnitAlive) then
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." unit mar halott, kitakaritom")
			Kill(pShip, true)
		else
-- RELEASE_LOGOFF  			luaLog("CHECKPOINT01: "..pShip.Name.." el, pozicionalom")
			local tPos = {}
			local tRot = {}
			tPos, tRot = luaUS09_Checkpoint01_GetUnitPos(pShip.Name, Mission.Cp1DestroyerPos)
			local tRotation = 360 - tRot["y"]
			PutTo(pShip, tPos, tRotation)
		end
	end
	Kill(Mission.Fubuki,true)
	Kill(FindEntity"Japanese Patrolboat 01",true)
	PilotMoveToRange(Mission.Corsair, Mission.KateSpawnPoints[1],10)
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(150)
	PrepareClass(158)
	PrepareClass(162)
	PrepareClass(171)
	PrepareClass(154)
	PrepareClass(175)
	Loading_Finish()
end