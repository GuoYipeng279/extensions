-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
--[[
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
--]]
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort08")
end

function luaInitEscort08(this)
	Mission = this
	Mission.Name = "Escort08"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort08")
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
				["Text"] = "mp.obj_es_def",
				--["Text"] = "mm01.obj_p1",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "mp.obj_ic_uswon",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "mp.obj_ic_jpwon",
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
				["Text"] = "mp.obj_es_def",
				--["Text"] = "mm01.obj_p2",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "mp.obj_ic_jpwon",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "mp.obj_ic_uswon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
	}
-- Mission params
	Mission.Yamato = FindEntity("Escort - Yamato")
	Mission.Iowa = FindEntity("Escort - Iowa")
	
	Mission.YamatoT =  {}
	table.insert(Mission.YamatoT, FindEntity("Escort - Yamato"))
	Mission.IowaT = {} 
	table.insert(Mission.IowaT,FindEntity("Escort - Iowa"))
		
	Mission.AlliedDD1 = FindEntity("Escort - Allen M. Sumner 01")
	Mission.AlliedDD2 = FindEntity("Escort - Allen M. Sumner 02")
	
	Mission.JapaneseDD1 = FindEntity("Escort - Akizuki 01")
	Mission.JapaneseDD2 = FindEntity("Escort - Akizuki 02")
	
	Mission.Carrier1 = FindEntity("Escort - Lexington")
	Mission.Carrier2 = FindEntity("Escort - Yorktown")
	Mission.Carrier3 = FindEntity("Escort - Shokaku")
	Mission.Carrier4 = FindEntity("Escort - Zuikaku")
	
	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	Mission.KeyUnitCounters = false
	--Events

	-- korulmenyek beallitasa
	
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort08_think")	
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------

function luaEscort08_think(this, msg)
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
		luaObj_Add("primary", 1, {Mission.Yamato, Mission.Iowa})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Yamato, Mission.Iowa})
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
		luaStartKeyUnits()
		luaAddYamatoListener()
		luaAddIowaListener()
		luaKeyUnitCounters()
		luaShowMissionHint()		
	end	
	
	luaSetTarget()
	
-- objective giving
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaKeyUnitCounters()

	if Mission.MissionEnd == true then
		return
	end

		MultiScore=	{
		[0]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[1]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[2]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[3]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.AkagiHPPercent,
		},
		[4]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[5]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[6]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
		[7]= {
			[1] = Mission.IowaHPPercent,
			[2] = Mission.YamatoHPPercent,
		},
	}

	DisplayScores(1, 0,"mp08.score_us_bb_hp|".." #MultiScore.0.1# %","mp08.score_jp_bb_hp|".." #MultiScore.0.2# %",2,1)
	DisplayScores(1, 1,"mp08.score_us_bb_hp|".." #MultiScore.1.1# %","mp08.score_jp_bb_hp|".." #MultiScore.1.2# %",2,1)
	DisplayScores(1, 2,"mp08.score_us_bb_hp|".." #MultiScore.2.1# %","mp08.score_jp_bb_hp|".." #MultiScore.2.2# %",2,1)
	DisplayScores(1, 3,"mp08.score_us_bb_hp|".." #MultiScore.3.1# %","mp08.score_jp_bb_hp|".." #MultiScore.3.2# %",2,1)
	DisplayScores(1, 4,"mp08.score_us_bb_hp|".." #MultiScore.4.1# %","mp08.score_jp_bb_hp|".." #MultiScore.4.2# %",2,1)
	DisplayScores(1, 5,"mp08.score_us_bb_hp|".." #MultiScore.5.1# %","mp08.score_jp_bb_hp|".." #MultiScore.5.2# %",2,1)
	DisplayScores(1, 6,"mp08.score_us_bb_hp|".." #MultiScore.6.1# %","mp08.score_jp_bb_hp|".." #MultiScore.6.2# %",2,1)
	DisplayScores(1, 7,"mp08.score_us_bb_hp|".." #MultiScore.7.1# %","mp08.score_jp_bb_hp|".." #MultiScore.7.2# %",2,1)
	
	if not Mission.Iowa.Dead then
			Mission.IowaHPPercent = luaRound(GetHpPercentage(Mission.Iowa)*100)
	else
			Mission.IowaHPPercent = 0
	end
	
	if not Mission.Yamato.Dead then
			Mission.YamatoHPPercent = luaRound(GetHpPercentage(Mission.Yamato)*100)
	else
			Mission.YamatoHPPercent = 0
	end
	
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.IowaHPPercent
			MultiScore[i][2] = Mission.YamatoHPPercent
		end
	end	
	
	luaDelay(luaKeyUnitCounters, 1)
	
end

function luaStartKeyUnits()
	local path1 = FindEntity("ep1")
	local path2 = FindEntity("ep2")
	local path3 = FindEntity("ep3")
	local path4 = FindEntity("ep4")
	local path5 = FindEntity("ep5")
	local path6 = FindEntity("ep6")
	
	local cpath1 = FindEntity("cpath1")
	local cpath2 = FindEntity("cpath2")
	local cpath3 = FindEntity("cpath3")
	local cpath4 = FindEntity("cpath4")

	NavigatorMoveOnPath(Mission.Carrier1, cpath1)
	NavigatorMoveOnPath(Mission.Carrier2, cpath2)
	NavigatorMoveOnPath(Mission.Carrier3, cpath3)
	NavigatorMoveOnPath(Mission.Carrier4, cpath4)	
	
	NavigatorMoveOnPath(Mission.Iowa, path1)
	NavigatorMoveOnPath(Mission.AlliedDD1, path3)	
	NavigatorMoveOnPath(Mission.AlliedDD2, path2)	
	NavigatorMoveOnPath(Mission.Yamato, path4)
	NavigatorMoveOnPath(Mission.JapaneseDD1, path5)	
	NavigatorMoveOnPath(Mission.JapaneseDD2, path6)
		
end


function luaAddYamatoListener()
	AddListener("kill", "Listener01", {
			["callback"] = "luaYamatoDead",
			["entity"] = Mission.YamatoT,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active1")
end

function luaAddIowaListener()
	AddListener("kill", "Listener02", {
			["callback"] = "luaIowaDead",
			["entity"] = Mission.IowaT,
			["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
			["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_8
			})
-- RELEASE_LOGOFF  	luaLog("Listener Active2")	
end

function luaIowaDead ()
	if not TrulyDead(Mission.Iowa) then
		luaMissionCompletedNew(Mission.Iowa, "", nil, nil, nil, PARTY_JAPANESE)
	else
		luaMissionCompletedNew(Mission.Iowa.LastBanto, "", nil, nil, nil, PARTY_JAPANESE)
	end
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 2)
	luaObj_Failed("primary", 1)
	Mission.MissionEnd = true
end

function luaYamatoDead ()
	if not TrulyDead(Mission.Yamato) then
		luaMissionCompletedNew(Mission.Yamato, "", nil, nil, nil, PARTY_ALLIED)
	else
		luaMissionCompletedNew(Mission.Yamato.LastBanto, "", nil, nil, nil, PARTY_ALLIED)
	end
	Scoring_RealPlayTimeRunning(false)
	luaObj_Completed("primary", 1)
	luaObj_Failed("primary", 2)
	Mission.MissionEnd = true
end

function luaSetTarget()
	if not Mission.Yamato.Dead or not Mission.Iowa.Dead then
		if luaGetDistance(Mission.Yamato, Mission.Iowa ) < 3300 then
			NavigatorAttackMove(Mission.Yamato, Mission.Iowa, {})			
			NavigatorAttackMove(Mission.Iowa, Mission.Yamato, {})
		end
	end						
	--[[
	if not Mission.AlliedDD1.Dead or not Mission.Yamato.Dead then
		if luaGetDistance(Mission.AlliedDD1, Mission.Yamato ) < 3000 then
			NavigatorAttackMove(Mission.AlliedDD1, Mission.Yamato, {})			
		end			
	end								
	if not Mission.AlliedDD2.Dead or not Mission.Yamato.Dead then
		if luaGetDistance(Mission.AlliedDD2, Mission.Yamato ) < 3000 then
			NavigatorAttackMove(Mission.AlliedDD2, Mission.Yamato, {})			
		end			
	end						
	
	if not Mission.JapaneseDD1.Dead or not Mission.Iowa.Dead then
		if luaGetDistance(Mission.JapaneseDD1, Mission.Iowa) < 3000 then
			NavigatorAttackMove(Mission.JapaneseDD1, Mission.Iowa, {})			
		end
	end		
	if not Mission.JapaneseDD2.Dead or not Mission.Iowa.Dead then
		if luaGetDistance(Mission.JapaneseDD2, Mission.Iowa) < 3000 then
			NavigatorAttackMove(Mission.JapaneseDD2, Mission.Iowa, {})			
		end
	end									
	--]]
	
	if not Mission.AlliedDD1.Dead and not Mission.JapaneseDD1.Dead then
		if luaGetDistance(Mission.AlliedDD1, Mission.JapaneseDD1) < 3000 then
			NavigatorAttackMove(Mission.AlliedDD1, Mission.JapaneseDD1, {})			
			NavigatorAttackMove(Mission.JapaneseDD1, Mission.AlliedDD1, {})			
			
		end			
	end									
	if not Mission.JapaneseDD2.Dead and not Mission.AlliedDD2.Dead then
		if luaGetDistance(Mission.JapaneseDD2, Mission.AlliedDD2) < 3000 then
			NavigatorAttackMove(Mission.AlliedDD2, Mission.JapaneseDD2, {})			
			NavigatorAttackMove(Mission.JapaneseDD2, Mission.AlliedDD2, {})			
		end
	end		
end
function luaShowMissionHint()
	ShowHint("ID_Hint_Escort08")
	-- mode description hint overlay
end