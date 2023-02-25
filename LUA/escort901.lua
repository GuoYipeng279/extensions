-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	PrepareClass(38)	-- Helldiver
	PrepareClass(113)	-- Avenger
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort901")
end

function luaInitEscort901(this)
	Mission = this
	Mission.Name = "Operation Ten-Go"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort06")
	-- Loc-Kit dolgok
--	AddLockitPathToSelection(this.Name)
--	AddLockitPathToSelection("missionglobals")
--	AddLockitPathToSelection("mm01")
--	LoadSelectedPaths()
	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	
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
				["Text"] = "usn14.obj_p2", --Sink the Yamato!
				--["Text"] = "mm01.obj_p1",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj2",
				["Text"] = "usn08.carrier_hp", --Protect your carriers!
				--["Text"] = "mm01.obj_p2",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[3] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "mp07.obj_comp_s1_text", --Protect the Yamato!
				--["Text"] = "mm01.obj_p2",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
			[4] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj2",
				["Text"] = "ijn07.obj_p3_onscreen", --Sink the enemy carriers!
				--["Text"] = "mm01.obj_p2",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},
		},
		["secondary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "usn11.obj_s1", --Sink the escort destroyers!
				--["Text"] = "mm01.obj_p1",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "usn11.obj_s1_compl", --You have sunk the escort destroyers!
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "mp09.obj_comp_p2_fail", --You have failed to destroy the highlighted units!
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0,
			},

		},
	}
	
	Mission.Yamato = FindEntity("Yamato")
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, Mission.Yamato)
		
	Mission.Okinawa = FindEntity("Navpoint_Okinawa")
	Mission.JPFleet = {}
		table.insert(Mission.JPFleet, FindEntity("Yamato"))
		table.insert(Mission.JPFleet, FindEntity("Suzutsuki"))
		table.insert(Mission.JPFleet, FindEntity("Yahagi"))
		table.insert(Mission.JPFleet, FindEntity("Fuyuzuki"))
		table.insert(Mission.JPFleet, FindEntity("Asashimo"))
		table.insert(Mission.JPFleet, FindEntity("Hamakaze"))
		table.insert(Mission.JPFleet, FindEntity("Kasumi"))
		table.insert(Mission.JPFleet, FindEntity("Yukikaze"))
		table.insert(Mission.JPFleet, FindEntity("Hatsushimo"))
		table.insert(Mission.JPFleet, FindEntity("Isokaze"))
		
	for idx, unit in pairs (Mission.JPFleet) do
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	end

	Mission.YamatoEscorts = {}
		table.insert(Mission.YamatoEscorts, FindEntity("Suzutsuki"))
		table.insert(Mission.YamatoEscorts, FindEntity("Yahagi"))
		table.insert(Mission.YamatoEscorts, FindEntity("Fuyuzuki"))
		table.insert(Mission.YamatoEscorts, FindEntity("Asashimo"))
		table.insert(Mission.YamatoEscorts, FindEntity("Hamakaze"))
		table.insert(Mission.YamatoEscorts, FindEntity("Kasumi"))
		table.insert(Mission.YamatoEscorts, FindEntity("Yukikaze"))
		table.insert(Mission.YamatoEscorts, FindEntity("Hatsushimo"))
		table.insert(Mission.YamatoEscorts, FindEntity("Isokaze"))
		
	for idx, unit in pairs (Mission.YamatoEscorts) do
		JoinFormation(unit, Mission.Yamato)
	end

	Mission.Essex = FindEntity("Essex")
	Mission.Belleau = FindEntity("Belleau Wood")
	
	Mission.Essexmsg = false
	Mission.Belleaumsg = false

	Mission.CV = {}
		table.insert(Mission.CV, Mission.Essex)
		table.insert(Mission.CV, Mission.Belleau)
	
	Mission.Iowa = FindEntity("Iowa")
	
	Mission.USFormation = {}
		table.insert(Mission.USFormation, FindEntity("Essex"))	
		table.insert(Mission.USFormation, FindEntity("Belleau Wood"))	
		table.insert(Mission.USFormation, FindEntity("Brush"))	
		table.insert(Mission.USFormation, FindEntity("Taussig"))	
		table.insert(Mission.USFormation, FindEntity("Alaska"))	
		table.insert(Mission.USFormation, FindEntity("Guam"))	
		
	for idx, unit in pairs (Mission.USFormation) do
		JoinFormation(unit, Mission.Iowa)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
	end
	
	Mission.EssexHP = 100
	Mission.BelleauHP = 100
	Mission.YamatoHP = 100
	
	Mission.SpawnTime = 450
	
	Mission.USCoord = {}
		Mission.USCoord.x = -2000
		Mission.USCoord.y = 500
		Mission.USCoord.z = -14000	
	Mission.ReinforcementsUS = false
	Mission.EventAUnits = {}
	
	Mission.WarningMSG = false
	
	AISetTargetWeight(165, 73, false, 0)	--F6F vs Fubuki
	AISetTargetWeight(165, 58, false, 0)	--F6F vs Shimakaze
	AISetTargetWeight(165, 14, false, 0)	--F6F vs Akizuki
	AISetTargetWeight(165, 73, false, 0)	--F6F vs Fubuki
	AISetTargetWeight(165, 386, false, 0)	--F6F vs Yamato
	
	AISetTargetWeight(102, 73, false, 50)	--F4U vs Fubuki
	AISetTargetWeight(102, 58, false, 20)	--F4U vs Shimakaze
	AISetTargetWeight(102, 14, false, 20)	--F4U vs Akizuki
	AISetTargetWeight(102, 386, false, 0)	--F4U vs Yamato
	
	AISetTargetWeight(102, 73, false, 0)	--TBF vs Fubuki
	AISetTargetWeight(113, 58, false, 0)	--TBF vs Shimakaze
	AISetTargetWeight(113, 14, false, 0)	--TBF vs Akizuki
	AISetTargetWeight(113, 386, false, 0)	--TBF vs Yamato
	AISetTargetWeight(113, 71, false, 0)	--TBF vs Agano

	AISetTargetWeight(38, 73, false, 20)	--SB2C vs Fubuki
	AISetTargetWeight(38, 58, false, 20)	--SB2C vs Shimakaze
	AISetTargetWeight(38, 14, false, 20)	--SB2C vs Akizuki
	AISetTargetWeight(38, 386, false, 0)	--SB2C vs Yamato
	AISetTargetWeight(38, 71, false, 20)	--SB2C vs Agano


	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	
	
-- Players
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	
-- korulmenyek beallitasa
	AddWatch(Mission.MissionTime)
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	OverrideHP(Mission.Yamato, Mission.Yamato.Class.HP*1.25)
	
	SetThink(this, "luaEscort901_think")		
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort901_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end
	if this.MissionStart then
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Adding objectives")
-- RELEASE_LOGOFF  		luaLog("")
		-- allied objs
		luaObj_Add("primary", 1, Mission.Yamato)
		luaObj_AddUnit("primary",1,GetPosition(Mission.Okinawa))
		luaObj_Add("primary", 2, Mission.CV)
		luaObj_Add("secondary", 1, {Mission.YamatoEscorts[1], Mission.YamatoEscorts[2], Mission.YamatoEscorts[3], Mission.YamatoEscorts[4], Mission.YamatoEscorts[5], Mission.YamatoEscorts[6], Mission.YamatoEscorts[7], Mission.YamatoEscorts[8], Mission.YamatoEscorts[9]})
		-- japanese objs
		luaObj_Add("primary", 3, Mission.Yamato)
		luaObj_AddUnit("primary",3,GetPosition(Mission.Okinawa))
		luaObj_Add("primary", 4, Mission.CV)
		
--[[	luaObj_Add("primary", 1, {Mission.Yamato})
		luaObj_AddUnit("primary",1,GetPosition(Mission.Okinawa))
		luaObj_Add("primary", 2, {Mission.Essex, Mission.Belleau})
		-- japanese objs
		luaObj_Add("primary", 3, {Mission.Yamato})
		luaObj_AddUnit("primary",3,GetPosition(Mission.Okinawa))
		luaObj_Add("primary", 4, {Mission.Essex, Mission.Belleau})]]
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()	
	end
					
	Mission.StepCounter = Mission.StepCounter + 1
	Mission.MissionTime = Mission.MissionTime+1 
	luaRemoveDeadsFromTable(Mission.JPFleet)
	luaEventSpawnUS()	
	luaDestroyers()
	luaListener()
	luaHP()
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end


end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaStartKeyUnits()
	NavigatorMoveOnPath(Mission.Yamato, FindEntity("Yamato_Path"))
	NavigatorMoveOnPath(Mission.Iowa, FindEntity("Carriers_Path"))
end

function luaListener()
	if Mission.Yamato.Dead then
		luaBBDead()	
	elseif Mission.Essex.Dead and not Mission.Essexmsg then
		luaCVDead()
		Mission.Essexmsg = true
	elseif Mission.Belleau.Dead and not Mission.Belleaumsg then
		Mission.Belleaumsg = true
		luaCVDead()
	end
end

function luaCVDead()
	MissionNarrativeParty(0, "ingame.warning_own_cv_lost_dispatcher_jap") 	--Carrier lost, repeat carrier lost!
	MissionNarrativeParty(1, "ingame.warning_nmy_cv_dest_dispatcher")	--Sir, an enemy carrier has been destroyed.
	if Mission.Essex.Dead and Mission.Belleau.Dead then
		luaDelay(luaMissionEndCV, 3)
	end
end

function luaMissionEndCV()
	Mission.MissionEnd = true
	SetInvincible(Mission.Yamato, 1)
	luaObj_Completed("primary", 3)
	luaObj_Completed("primary", 4)
	luaObj_Failed("primary", 1)
	luaObj_Failed("primary", 2)
	Scoring_RealPlayTimeRunning(false)
	luaMissionCompletedNew(Mission.Yamato, "", nil, nil, nil, PARTY_JAPANESE)
end

function luaBBDead()
	if not Mission.Essex.Dead then
		SetInvincible(Mission.Essex, 1)
	end
	if not Mission.Belleau.Dead then
		SetInvincible(Mission.Belleau, 1)
	end	
	luaObj_Completed("primary", 1)
	luaObj_Completed("primary", 2)
	luaObj_Failed("primary", 3)
	luaObj_Failed("primary", 4)
	Mission.MissionEnd = true
	Scoring_RealPlayTimeRunning(false)
	if not TrulyDead(Mission.Yamato) then
		luaMissionCompletedNew(Mission.Yamato, "", nil, nil, nil, PARTY_ALLIED)
	else
		luaMissionCompletedNew(Mission.Yamato.LastBanto, "", nil, nil, nil, PARTY_ALLIED)
	end
end

function luaEventSpawnUS() 
	local prespawn = Mission.SpawnTime - 60
	if Mission.MissionTime >= prespawn and not Mission.WarningMSG then
		MissionNarrativeParty(0, "usn12.dlg_24a_frag1") --Bombers will be overhead in one minute. Hurry things up, boys.
		MissionNarrativeParty(1, "ijn07.dlg_4a_frag1")	--Another attack wave incoming, sir!
		Mission.WarningMSG = true
	elseif Mission.MissionTime == Mission.SpawnTime and not Mission.ReinforcementsUS then	
		Mission.ReinforcementsUS = true
	  	local SpawnCoord = Mission.USCoord		
			SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 113,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = 113,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = 113,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = 113,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = 38,
					["Name"] = "SB2C Helldiver",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = 38,
					["Name"] = "SB2C Helldiver",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = 5,
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
		MissionNarrativeParty(0, "mp.nar_us_reinf_arrived")
		MissionNarrativeParty(1, "mp.nar_us_reinf_arrived")		
		
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
			
	end
end

function luaEventSpawnUSCallback(unit1, unit2, unit3, unit4, unit5, unit6)
	table.insert(Mission.EventAUnits, unit1)
	table.insert(Mission.EventAUnits, unit2)
	table.insert(Mission.EventAUnits, unit3)
	table.insert(Mission.EventAUnits, unit4)
	table.insert(Mission.EventAUnits, unit5)
	table.insert(Mission.EventAUnits, unit6)
	if not Mission.Yamato.Dead then
		for idx, unit in pairs (Mission.EventAUnits) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			PilotSetTarget(unit, Mission.Yamato)
			EntityTurnToEntity(unit, Mission.Yamato)
			SetForcedReconLevel(unit, 2, PARTY_JAPANESE)			
			if unit.Class.ID == 38 then
				local coord = GetPosition(unit)
				coord.y = 1300 --Altitude
				PutTo(unit, coord)			
			end
		end
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
	end	
	AISetTargetWeight(165, 58, false, 0)	--F6F vs Shimakaze
	AISetTargetWeight(165, 14, false, 0)	--F6F vs Akizuki
	AISetTargetWeight(165, 386, false, 0)	--F6F vs Yamato
	
	AISetTargetWeight(102, 58, false, 0)	--F4U vs Shimakaze
	AISetTargetWeight(102, 14, false, 0)	--F4U vs Akizuki
	AISetTargetWeight(102, 386, false, 0)	--F4U vs Yamato
	
	AISetTargetWeight(113, 58, false, 0)	--TBF vs Shimakaze
	AISetTargetWeight(113, 14, false, 0)	--TBF vs Akizuki
	AISetTargetWeight(113, 386, false, 100)--TBF vs Yamato
	AISetTargetWeight(113, 71, false, 100)	--TBF vs Agano

	AISetTargetWeight(38, 58, false, 0)		--SB2C vs Shimakaze
	AISetTargetWeight(38, 14, false, 0)		--SB2C vs Akizuki
	AISetTargetWeight(38, 386, false, 0)	--SB2C vs Yamato
	AISetTargetWeight(38, 71, false, 0)	--SB2C vs Agano
end

function luaDestroyers()
	luaRemoveDeadsFromTable(Mission.YamatoEscorts)
	if not Mission.ReinforcementsUS then
		if (table.getn(luaRemoveDeadsFromTable(Mission.YamatoEscorts))) == 0 then
			luaObj_Completed("secondary", 1)
		end
	else
		luaObj_Failed("secondary", 1)
	end
end

function luaYamatoReachedOkinawa()
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 3)
	luaObj_Completed("primary", 4)
	luaObj_Failed("primary", 1)
	luaObj_Failed("primary", 2)
	Mission.MissionEnd = true
	luaMissionCompletedNew(Mission.Yamato, "", nil, nil, nil, PARTY_JAPANESE)	
end

function luaHP()
	if not Mission.End then
	if not Mission.Essex.Dead then
		Mission.EssexHP = luaRound(GetHpPercentage(Mission.Essex)*100)
	else
		Mission.EssexHP = 0
	end
	if not Mission.Belleau.Dead then
		Mission.BelleauHP = luaRound(GetHpPercentage(Mission.Belleau)*100)
	else
		Mission.BelleauHP = 0
	end
		MultiScore=	{
			[0]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[1]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[2]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[3]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[4]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[5]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[6]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
			[7]= {
				[1] = Mission.EssexHP,
				[2] = Mission.BelleauHP,
			},
		}
		
		DisplayUnitHP(0,Mission.Keyunits)
		DisplayUnitHP(1,Mission.Keyunits)
		DisplayUnitHP(2,Mission.Keyunits)
		DisplayUnitHP(3,Mission.Keyunits)
		DisplayUnitHP(4,Mission.Keyunits)
		DisplayUnitHP(5,Mission.Keyunits)
		DisplayUnitHP(6,Mission.Keyunits)
		DisplayUnitHP(7,Mission.Keyunits)		
		DisplayScores(1, 0,"USS Essex|".." #MultiScore.0.1# %","USS Belleau Wood|".." #MultiScore.0.2# %",2,2)
		DisplayScores(1, 1,"USS Essex|".." #MultiScore.1.1# %","USS Belleau Wood|".." #MultiScore.1.2# %",2,2)
		DisplayScores(1, 2,"USS Essex|".." #MultiScore.2.1# %","USS Belleau Wood|".." #MultiScore.2.2# %",2,2)
		DisplayScores(1, 3,"USS Essex|".." #MultiScore.3.1# %","USS Belleau Wood|".." #MultiScore.3.2# %",2,2)
		DisplayScores(1, 4,"USS Essex|".." #MultiScore.4.1# %","USS Belleau Wood|".." #MultiScore.4.2# %",2,2)
		DisplayScores(1, 5,"USS Essex|".." #MultiScore.5.1# %","USS Belleau Wood|".." #MultiScore.5.2# %",2,2)
		DisplayScores(1, 6,"USS Essex|".." #MultiScore.6.1# %","USS Belleau Wood|".." #MultiScore.6.2# %",2,2)
		DisplayScores(1, 7,"USS Essex|".." #MultiScore.7.1# %","USS Belleau Wood|".." #MultiScore.7.2# %",2,2)
	end
end