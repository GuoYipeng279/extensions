--SceneFile="universe\Scenes\missions\Challenge\might.scn"
--SC5

function luaPrecacheUnits()
	
	PrepareClass(108) -- Dauntless
	PrepareClass(112) -- Devastator
	
end

function luaStageInit()
	CreateScript("luaInitMightMission")
end

function luaInitMightMission(this)
	Mission = this
	this.Name = "Might"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("sc5")
	LoadSelectedPaths()

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)
	
	this.MissionPhase = 0
	this.FirstRun = true

	-- weather
	SetDayTime(12) -- 12 orakor kezdodik
	SetWeather("Clear") -- tiszta idoben

	--no clouds
	--luaGenerateRandomClouds(40, {{["x"]=-9000, ["y"]=800, ["z"]=-9000}, {["x"]=9000, ["y"]=2000, ["z"]=9000}}, 5, 3, 0)

	-- flavor
	--[[Mission.SeagullPositions = {}
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_1")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_2")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_3")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_4")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_5")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_6")))

	for idx,pos in pairs(Mission.SeagullPositions) do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = pos,
		})
	end]]

	-- fontos koordinatak
	this.NavPoint = FindEntity("Navpoint")
	
	-- allied objektumok
	this.AlliedFleet = {}
	this.AlliedPlanes = {}

	this.AlliedCVs = {}
		table.insert(this.AlliedCVs, FindEntity("Hornet"))
		table.insert(this.AlliedCVs, FindEntity("Enterprise"))

	this.AlliedCAs = {}
		table.insert(this.AlliedCAs, FindEntity("Northampton"))
		table.insert(this.AlliedCAs, FindEntity("Astoria"))
		table.insert(this.AlliedCAs, FindEntity("Minneapolis"))
	
	this.TemplateFletcher = luaFindHidden("TemplateFletcher")
	this.FletcherNames = {}
		table.insert(this.FletcherNames, luaFindHidden("Phelps"))
		table.insert(this.FletcherNames, luaFindHidden("Worden"))
		table.insert(this.FletcherNames, luaFindHidden("Monaghan"))
		table.insert(this.FletcherNames, luaFindHidden("Aylwin"))
		table.insert(this.FletcherNames, luaFindHidden("Balch"))
		table.insert(this.FletcherNames, luaFindHidden("Conyngham"))
		table.insert(this.FletcherNames, luaFindHidden("Benham"))
		table.insert(this.FletcherNames, luaFindHidden("Ellet"))
		table.insert(this.FletcherNames, luaFindHidden("Maury"))
		table.insert(this.FletcherNames, luaFindHidden("Dewey"))
		table.insert(this.FletcherNames, luaFindHidden("Monssen"))
	this.FletcherName = luaFindHidden("Fletcher")

	this.AlliedFirstStrikeCA = FindEntity("Houston")
	this.AlliedFirstStrikeDDs = {}
		table.insert(this.AlliedFirstStrikeDDs, FindEntity("Worden"))
		table.insert(this.AlliedFirstStrikeDDs, FindEntity("Monssen"))
		table.insert(this.AlliedFirstStrikeDDs, FindEntity("Monaghan"))
		table.insert(this.AlliedFirstStrikeDDs, FindEntity("Benham"))

	this.AlliedSubs = {}
		table.insert(this.AlliedSubs, FindEntity("Narwhal"))
		table.insert(this.AlliedSubs, FindEntity("Nautilus"))

	--TorpedoBomber
	this.TemplateDevastator = {}
		table.insert(this.TemplateDevastator, luaFindHidden("TemplateDevastator1"))
		table.insert(this.TemplateDevastator, luaFindHidden("TemplateDevastator2"))
		table.insert(this.TemplateDevastator, luaFindHidden("TemplateDevastator3"))
		table.insert(this.TemplateDevastator, luaFindHidden("TemplateDevastator4"))
		table.insert(this.TemplateDevastator, luaFindHidden("TemplateDevastator5"))
	this.TemplateDevastatorName = "Devastator"
	this.NextDevastator = 1

	--DiveBomber
	this.TemplateDauntless = {}
		table.insert(this.TemplateDauntless, luaFindHidden("TemplateDauntless1"))
		table.insert(this.TemplateDauntless, luaFindHidden("TemplateDauntless2"))
		table.insert(this.TemplateDauntless, luaFindHidden("TemplateDauntless3"))
		table.insert(this.TemplateDauntless, luaFindHidden("TemplateDauntless4"))
		table.insert(this.TemplateDauntless, luaFindHidden("TemplateDauntless5"))
	this.TemplateDauntlessName = "Dauntless"
	this.NextDauntless = 1
	
	-- japanese objektumok
	this.JapPlayerUnit = FindEntity("Yamato")

	this.JapFleet = {}
		table.insert(this.JapFleet, FindEntity("Yamato"))
		table.insert(this.JapFleet, FindEntity("Sendai"))
		table.insert(this.JapFleet, FindEntity("Fubuki"))
		table.insert(this.JapFleet, FindEntity("Shirayuki"))

	this.JapFollowers = {}
		table.insert(this.JapFollowers, FindEntity("Sendai"))
		table.insert(this.JapFollowers, FindEntity("Fubuki"))
		table.insert(this.JapFollowers, FindEntity("Shirayuki"))
	
	for idx, unit in pairs(this.JapFleet) do
	
		RepairEnable(unit, false)
		SetCatapultStock(unit, 0)
	
	end
	
	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
	this.Objectives =
	{
		["primary"] =
		{
			[1] = 
			{
				["ID"] = "MustSurvive",		-- azonosito
				["Text"] = "The Yamato must survive the battle!", --The Yamato must survive the battle.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[2] =
			{
				["ID"] = "LocateCarriers",		-- azonosito
				["Text"] = "Locate the allied carrier group near the island to the north before they escape!", --Locate the allied carrier group near the island to the north before they escape.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
			[3] =
			{
				["ID"] = "DestroyCarriers",		-- azonosito
				["Text"] = "Destroy the Hornet and the Enterprise before they escape!", --Destroy the Hornet and the Enterprise before they escape.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] =  2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},

		["secondary"] =
		{
		},
		
		["hidden"] =
		{
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	SetThink(this, "luaMightMission_think")

	PrepareClass(108) -- Dauntless
	PrepareClass(112) -- Devastator
	--PrepareClass(23) -- Fletcher

	Blackout(true, "", true)
	
	--SetInvincible(FindEntity("Yamato"), 0.5)
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	--luaFirstEnterInstant(this.JapFleet[1])
end

function luaMightMission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	luaMightCheckConditions(this)

	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	luaCheckMusic()

-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)

	if not this.MightInit then

		EnableInput(false)

		Blackout(false,"",2.5)

		luaMightIntro()

		Mission.MightInit = true
		
	end

	if not this.MovieSkip and not this.MovieEnd and GameTime()>12 then
		
		this.MovieEnd = true
		
		luaMightSkipMovie()
		
	end

	
	if this.MovieSkip then
		
		this.MissionPhase = 1
		
		Mission.FreeToGo = true
		
		this.MovieSkip = nil
	
	end
	

		

	if this.MissionPhase == 1 then
		if not this.FormationInitiated then
			for i, unit in pairs (Mission.AlliedSubs) do
				SetForcedReconLevel(unit, 0, PARTY_JAPANESE)
				SetUnlimitedAirSupply(unit, true)
				SetInvincible(unit, 1)
				UnitHoldFire(unit)
			end
			JoinFormation(this.JapFleet[2], this.JapFleet[1])
			JoinFormation(this.JapFleet[3], this.JapFleet[1])
			JoinFormation(this.JapFleet[4], this.JapFleet[1])
			SetFormationShape(this.JapFleet[1], 3)
			--TorpedoEnable(this.JapFleet[2], true)
			--TorpedoEnable(this.JapFleet[3], true)
			--TorpedoEnable(this.JapFleet[4], true)
			JoinFormation(this.AlliedCVs[2], this.AlliedCVs[1])
			JoinFormation(this.AlliedCAs[1], this.AlliedCVs[1])
			JoinFormation(this.AlliedCAs[2], this.AlliedCVs[1])
			JoinFormation(this.AlliedCAs[3], this.AlliedCVs[1])
			AddListener("recon", "LocateCarriers", {
				["callback"] = "luaMightCarriersLocated",
				["entity"] = this.AlliedCVs,
				["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
				["newLevel"] = {2, 3, 4}, -- 0: undetected, 1: detected, 2-4: identified
			})
			AddListener("exitzone", "CheckCarriers", {
				["callback"] = "luaMightCarriersExited",
				["entity"] = this.AlliedCVs,
				["exited"] = {false}, -- false: entity entered exit zone, true: entity exited
			})
			this.FormationInitiated = true
			luaSetScriptTarget(this.AlliedFirstStrikeCA, this.JapFollowers[1])
			NavigatorAttackMove(this.AlliedFirstStrikeCA, this.JapFollowers[1], {})
			for i, unit in pairs (this.AlliedFirstStrikeDDs) do
				--JoinFormation(unit, this.AlliedFirstStrikeCA)
				TorpedoEnable(unit, true)
				luaSetScriptTarget(unit, this.JapPlayerUnit)
				--NavigatorMoveToRange(unit, this.JapPlayerUnit)
				--luaLog("ScriptTarget: "..tostring(luaGetScriptTarget(unit)))
				NavigatorAttackMove(unit, this.JapPlayerUnit, {})
				--UnitFreeAttack(unit)
				ShipSetTorpedoStock(unit, 3)
			end
		end
		if not Mission.FreeToGo then
			return
		end
		luaObj_Add("primary", 1, Mission.JapPlayerUnit, true)
		luaObj_Add("primary", 2, GetPosition(Mission.NavPoint))
		Countdown("Locate the allied carrier group before they escape!", 1, 839, "luaMightCountdownExpired")
		this.MissionPhase = 2
	elseif this.MissionPhase == 2 then
		for i, unit in pairs (this.AlliedCVs) do
			luaCapManager(unit, {108})
		end
	elseif this.MissionPhase == 3 then
		if not Mission.AlliedSubsActivated then
			Mission.AlliedSubsActivated = true
			local angle = luaGetAngle("world", GetPosition(Mission.AlliedCVs[1]), GetPosition(Mission.JapPlayerUnit))
			local coordinate = luaMoveCoordinate(GetPosition(Mission.JapPlayerUnit), 2000, 180+angle+20)
			local tempPos = GetPosition(Mission.AlliedSubs[1])
			coordinate.y = tempPos.y
			PutTo(Mission.AlliedSubs[1], coordinate)
			coordinate = luaMoveCoordinate(GetPosition(Mission.JapPlayerUnit), 4000, 180+angle-20)
			tempPos = GetPosition(Mission.AlliedSubs[2])
			coordinate.y = tempPos.y
			PutTo(Mission.AlliedSubs[2], coordinate)
			for i, unit in pairs (this.AlliedSubs) do
				ClearForcedReconLevel(unit, PARTY_JAPANESE)
				SetUnlimitedAirSupply(unit, false)
				SetInvincible(unit, 0)
				TorpedoEnable(unit, true)
				luaSetScriptTarget(unit, this.JapPlayerUnit)
				--NavigatorMoveToRange(unit, this.JapPlayerUnit)
				--luaLog("ScriptTarget: "..tostring(luaGetScriptTarget(unit)))
				NavigatorAttackMove(unit, this.JapPlayerUnit, {})
				--UnitFreeAttack(unit)
			end
		end
		for i, unit in pairs (this.AlliedCVs) do
			luaAirfieldManager(unit, {108, 112}, {108, 112}, {Mission.JapPlayerUnit}, 600)
		end
	end
end

function luaMightCheckConditions(this)
	if this.EndMission then
		return
	end

	if this.MissionPhase == 1 and this.FirstRun then
		AddWatch("Mission.MissionPhase")
		--AddWatch("Mission.SpawnPhase")
		return
	end

	this.LastRoundAlliedCVs = luaSumTables(this.AlliedCVs)

	this.JapFleet = luaRemoveDeadsFromTable(this.JapFleet)
	this.JapFollowers = luaRemoveDeadsFromTable(this.JapFollowers)
	this.AlliedFirstStrikeDDs = luaRemoveDeadsFromTable(this.AlliedFirstStrikeDDs)
	this.AlliedFleet = luaRemoveDeadsFromTable(this.AlliedFleet)
	this.AlliedPlanes = luaRemoveDeadsFromTable(this.AlliedPlanes)
	this.AlliedCVs = luaRemoveDeadsFromTable(this.AlliedCVs)
	this.AlliedCAs = luaRemoveDeadsFromTable(this.AlliedCAs)

	if this.JapPlayerUnit.Dead then
-- RELEASE_LOGOFF  		luaLog("Key unit lost! Mission Failed!")
		luaClearDialogs()
		luaObj_FailedAll(true)
		this.EndMission = true
		luaMissionFailedNew(Mission.JapPlayerUnit, "Yamato is lost!") --Yamato lost!
		return
	end

	if not this.AlliedFirstStrikeCA.Dead then
		if not luaGetScriptTarget then
			if table.getn(this.JapFollowers) ~= 0 then
				luaSetScriptTarget(this.AlliedFirstStrikeCA, this.JapFollowers[1])
			else
				luaSetScriptTarget(this.AlliedFirstStrikeCA, this.JapPlayerUnit)
			end
		end
	else
		if this.MissionPhase == 2 then
			if table.getn(this.AlliedFirstStrikeDDs) == 0 then
				this.MissionPhase = 3
			end
		end
	end

	if this.MissionPhase == 3 and table.getn(this.AlliedCVs) == 0 then
-- RELEASE_LOGOFF  		luaLog("Mission Successful!")
		luaClearDialogs()
		luaObj_CompletedAll(true)
		HideUnitHP()
		this.EndMission = true
		local lastDead
		for index, unit in pairs (this.LastRoundAlliedCVs) do
			if unit.Dead then
				lastDead = unit
				break
			end
		end
		luaMissionCompletedNew(lastDead, "You have eliminated the Allied carriers!") --You have eliminated the Allied carriers!
		return
	end

	if this.CarriersExited then
-- RELEASE_LOGOFF  		luaLog("Carriers have exited! Mission Failed!")
		luaClearDialogs()
		luaObj_Completed("primary", 1)
		luaObj_FailedAll(true)
		this.EndMission = true
		luaMissionFailedNew(Mission.JapPlayerUnit, "You have failed to eliminate the allied carrier group in time!") --You have failed to eliminate the allied carrier group in time!
		return
	end
end

function luaMightCarriersLocated()
	if IsListenerActive("recon", "LocateCarriers") then
		RemoveListener("recon", "LocateCarriers")
	end
	local timer = CountdownCancel()
-- RELEASE_LOGOFF  	luaLog("Countdown finished at: "..timer)

	luaObj_Completed("primary", 2)
	luaObj_Add("primary", 3, Mission.AlliedCVs)
	DisplayUnitHP(Mission.AlliedCVs, "Destroy the Hornet and the Enterprise before they escape!")
	if Mission.MissionPhase == 2 then
		Mission.MissionPhase = 3
	end

	local coordinate =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 10000
	}
	NavigatorMoveToPos(Mission.AlliedCVs[1], coordinate)
	SetShipSpeed(Mission.AlliedCVs[1], KTS(10))

	LeaveFormation(Mission.AlliedCAs[1])
	luaSetScriptTarget(Mission.AlliedCAs[1], Mission.JapPlayerUnit)
	NavigatorAttackMove(Mission.AlliedCAs[1], Mission.JapPlayerUnit, {})

	Mission.AlliedBBActivated = true
end

function luaMightCarriersExited()
	if IsListenerActive("recon", "CheckCarriers") then
		RemoveListener("recon", "CheckCarriers")
	end
	Mission.CarriersExited = true
end

function luaMightCountdownExpired()
-- RELEASE_LOGOFF  	luaLog("Countdown expired! Mission failed!")
	if IsListenerActive("recon", "LocateCarriers") then
		RemoveListener("recon", "LocateCarriers")
	end
	if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil then
		if not Mission.JapPlayerUnit.Dead then
			luaObj_Completed("primary", 1)
		end
	end
	luaObj_FailedAll(true)
	Mission.EndMission = true
	luaMissionFailedNew(Mission.JapPlayerUnit, "You have failed to locate the allied carrier group in time!") --You have failed to locate the allied carrier group in time!
end

function luaMightIntro()
	
	
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.JapPlayerUnit,
               ["pos"] = { -39.41, 17, 170.67 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
			 		 ["zoom"] = 1.0,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.JapPlayerUnit,
               ["pos"] = { -34.52, 17, -33.25, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=14.0,
           ["linearblend"]=1.0,
			 		 ["zoom"] = 1.0,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=Mission.JapPlayerUnit,
				["pos"] = { 56.33, 1, 175.01 }
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
  		["zoom"] = 1.0,
		}

	MovCamNew_AddPosition(pos0)

	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=Mission.JapPlayerUnit,
				["pos"] = { 63.25, 1, -28.81, }
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=14.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
	--    ["finishscript"] = "luaMightSkipMovie",
  		["zoom"] = 1.0,
		}

	MovCamNew_AddPosition(pos0)

	SetSkipMovie("luaMightSkipMovie")

end

function luaMightSkipMovie()

-- RELEASE_LOGOFF  	luaLog("Skipmovie initiated")
	
	if not Mission.MovieSkip then

		Mission.MovieSkip = true
		
		Mission.MovieEnd = true
	
		SetSkipMovie()
	
		luaCrossFade(luaJavaSelectYamato)
		
-- RELEASE_LOGOFF  		luaLog("Movie Skipped")
	
	end

end

function luaJavaSelectYamato()

	EnableInput(true)

	SetSelectedUnit(Mission.JapPlayerUnit)

-- RELEASE_LOGOFF  	luaLog("unit selected")
	
end