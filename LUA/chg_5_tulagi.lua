--[[
	TODOs:
	- idle unitok lefigyelese
]]

function luaPrecacheUnits()
	
	PrepareClass(116) --B-17
	PrepareClass(150) --Zero
	PrepareClass(108) --Dauntless
	PrepareClass(113) --Avenger
	PrepareClass(75)  --Minekaze
	PrepareClass(234)	-- us troop transport
	PrepareClass(40)	-- higgins
	
end

function luaStageInit()
	CreateScript("luaInitPC2Mission")
end

function luaInitPC2Mission(this)
	Mission = this
	this.Name = "pc2"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("pc2")
	LoadSelectedPaths()

	--unit precache
	

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)
	this.MissionPhase = 1
	AddWatch("Mission.MissionPhase")
	AddWatch("Mission.NextStrikePlane")
	AddWatch("Mission.IntroRunning")
	AddWatch("Mission.SpawnedUnit")
	AddWatch("Mission.TimeToSpawn")

	this.SpawnedUnit = 0	-- listenerID-k kiosztasahoz hasznalt szamozas
	
	-- 1st phase
	this.B17sSpawned = 0
	this.B17Limit = 8
	this.B17sKilled = 0
	AddWatch("Mission.B17sSpawned")
	
	-- 2nd phase
	this.StrikePlaneSpawned = 0
	this.StrikePlaneLimit = 20
	AddWatch("Mission.StrikePlaneSpawned")
	Mission.StrikePlanesKilled = 0	-- itt szamoljuk, a masodik fazisban hany unitot lott le a jatekos oldala
	AddWatch("Mission.StrikePlanesKilled")
	this.StrikePlaneDBLimit = 1	-- ennyi DB jon egyszerre a DD-k ellen
	this.StrikePlaneTBLimit = 1	-- ennyi TB jon egyszerre a DD-k ellen
							-- ezek idovel emelkednek,c sak az elejen ne legyen nagy rush
	
	-- 3rd phase
	this.SYAttackerSpawned = 0
	this.SYAttackerLimit = 15
	this.SYAttackerNum = 1	-- ennyi squad jon egyszerre
	this.SYAttackerKilled = 0	-- itt szamoljuk, a 3. fazisban hany unitot lott le a jatekos oldala
	AddWatch("Mission.SYAttackerSpawned")

	-- 4th phase
	this.LandedBoatNum = 0	-- partraszallt csonakok szama
	this.LandedBoatMaxNum = 5	-- ennyi partraszallo partrajutasanal Mission failed
	AddWatch("Mission.LandedBoatNum")
	this.LandingBoatNum = 0	-- aktualis partraszallok szama
	this.LandingBoatMaxNum = 10	-- ennyi lehet egyidoben vizen
		
	-- weather
	SetDayTime(12) -- 12 orakor kezdodik
	SetWeather("Clear") -- tiszta idoben

	-- fontos koordinatak/pathok
	this.GenPos = 						-- hova generaljuk a nagy hajokhoz kepest a landing boatokat
	{
		[1] = 	-- left front
		{
			["x"]=-30,
			["y"]=10,
			["z"]=30
		},
		[2] = 	-- left back
		{
			["x"]=-30,
			["y"]=10,
			["z"]=-30
		},
		[3] = 	-- right front
		{
			["x"]=30,
			["y"]=10,
			["z"]=30
		},
		[4] = 	-- right back
		{
			["x"]=30,
			["y"]=10,
			["z"]=-30
		}
	}
	this.NextGenPos = 1
	
	this.LandingPaths = {}
		table.insert(this.LandingPaths, FindEntity("path_landing1"))
		table.insert(this.LandingPaths, FindEntity("path_landing2"))
		table.insert(this.LandingPaths, FindEntity("path_landing3"))
		table.insert(this.LandingPaths, FindEntity("path_landing4"))
		table.insert(this.LandingPaths, FindEntity("path_landing5"))
		table.insert(this.LandingPaths, FindEntity("path_landing6"))
	this.NextLandingPath = 1
	
	-- allied objektumok
	this.B17Tmpl = luaFindHidden("B-17")
	this.DauntlessTmpl = luaFindHidden("Dauntless")
	this.AvengerTmpl = luaFindHidden("Avenger")
	this.B17s = {}	-- itt lesznek majd az aktualis B17-esek
	this.StrikePlanes = {}	-- masodik fazis tamadoi kerulnek ide
	this.SYAttackers = {}	-- shipyard tamadoi kerulnek ide

	this.TransportsTmpl = {}
		table.insert(this.TransportsTmpl, luaFindHidden("Sabine"))
		table.insert(this.TransportsTmpl, luaFindHidden("Tippecanoe"))
	this.Transports = {}	-- ide kerulnek majd a transport shipek
		
	this.LCVPTmpl = luaFindHidden("Higgins")
	this.LandingBoats = {}	-- ide kerulnek majd a partraszallok
	
	-- japanese objektumok
	this.Airfield = FindEntity("Airfield")

	SetCrewLevel(this.Airfield, CREW_VETERAN)

	this.DDsTmpl = {}
		table.insert(this.DDsTmpl, luaFindHidden("Kikuzuki"))
		table.insert(this.DDsTmpl, luaFindHidden("Yuzuki"))
	this.DDPath = FindEntity("PathDestroyer")
	this.DDPathStop = {}
		table.insert(this.DDPathStop, FindEntity("ddpathstop1"))
		table.insert(this.DDPathStop, FindEntity("ddpathstop2"))
	this.SYs = {}
		table.insert(this.SYs, FindEntity("Sea Hangar"))
		table.insert(this.SYs, FindEntity("Storage 1"))
		table.insert(this.SYs, FindEntity("Storage 2"))
		table.insert(this.SYs, FindEntity("Storage 3"))
	this.SY1 = FindEntity("Sea Hangar")
	
	-- repter beallitasai
	luaRemoveAllFromStocks(this.Airfield, 150)	-- zerokat kivesszuk
	luaRemoveAllFromStocks(this.Airfield, 158)	-- valokat kivesszuk
	luaRemoveAllFromStocks(this.Airfield, 162)	-- kate-eket kivesszuk
	
	AddAirBasePlanes(this.Airfield, 150, 48)	-- es ennyit rakunk vissza
	SetAirBaseSlot(this.Airfield, 1, 150, 3)	-- slotokba betoltjuk oket
	SetAirBaseSlot(this.Airfield, 2, 150, 3)
	SetAirBaseSlot(this.Airfield, 3, 150, 3)
	SetAirBaseSlot(this.Airfield, 4, 150, 3)

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Airfield",		--added	checked
				--["Text"] = "Protect the hangars",
				["Text"] = "Protect the hangars!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- 
				["ScoreCompleted"] = 8000*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "DDs",		--added	checked
				--["Text"] = "Protect the Destroyers",
				["Text"] = "Protect the destroyers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- 
				["ScoreCompleted"] = 8000*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Jetty",		--added	checked
				--["Text"] = "Protect the Jetty hangars",
				["Text"] = "Protect the Jetty hangars!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- 
				["ScoreCompleted"] = 8000*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "landing",		--added	checked
				--["Text"] = "Eliminate the landing fleet.",
				["Text"] = "Eliminate the landing fleet!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- 
				["ScoreCompleted"] = 8000*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		
		["secondary"] =	{
		},

		["hidden"] = {
		}
	}
	-- Scoring = nil	-- itt toroljuk a Scoring tablat
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	Blackout(true, "", true)

	--luaGenerateRandomClouds(45, {{["x"]=-6000, ["y"]=500, ["z"]=-6000}, {["x"]=6000, ["y"]=700, ["z"]=6000}}, 2, 3, 1)

	SetThink(this, "luaPC2Mission_think")
end

function luaPC2Mission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.MissionStatus ~= nil then
		return
	end

	if Mission.MissionOver then
-- RELEASE_LOGOFF  		luaLog("Player lost all of his planes!")
		return
	else
		luaPC2CheckPlayerPlanes()
	end

	luaCheckMusic()
	--PerfTimingStart("white")

-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)
	if this.MissionPhase == 1 then	-- B-17 on airfield
		if this.Cheat_PhaseShift then
			this.Cheat_PhaseShift = false
-- RELEASE_LOGOFF  			luaLog("Cheating !")
			Mission.B17sSpawned = Mission.B17Limit
			Mission.B17s = luaRemoveDeadsFromTable(Mission.B17s)
			for idx, value in pairs (Mission.B17s) do
				Kill(value, true)
			end
		end

		if not Mission.AirfieldIntro then
			Mission.AirfieldIntro = true
			Blackout(true, "", true)
			luaPC2AirfieldMovie()

			luaDelaySet("TimeToSpawn", true, 31)
		end

		if Mission.Airfield.Dead then
-- RELEASE_LOGOFF  			luaLog("Airfield has been killed")
			luaMissionFailedNew(Mission.Airfield, "You lost the airfield hangar!")
			--PerfTimingEnd("white")
			return
		end

		Mission.B17s = luaRemoveDeadsFromTable(Mission.B17s)

		if Mission.TimeToSpawn then
			if Mission.B17sSpawned < Mission.B17Limit then	-- folyamatosan jonnek
				luaSquadronSupply(this.B17Tmpl, 2, luaPC2B17Spawned, "ammo", ST_ABSANGLE, Mission.Airfield, 6500, 7500, 1200, -150, -210)
		
			elseif not Mission.B17Finished then	-- mar bejott az utolso squad is, de meg nem dobtak le a bombat/nem haltak meg
				-- itt figyeljuk le, micsinalnak a B17-esek
				--	ha mar ledobtak minden bombat (vagy meghaltak), varunk egy kicsit, hogy le is erjenek
		
--[[
				local ammos = false
				for idx, value in pairs (Mission.B17s) do
					UpdateUnitTable(value)
					if value.ammo == 1 then
						ammos = true
					end
				end
-- RELEASE_LOGOFF  				luaLog("Ammo on B17s: "..tostring(ammos))
	]]			
		--		if (not ammos or table.getn(Mission.B17s) == 0 ) and not Mission.WaitingForAmmo then
				if table.getn(Mission.B17s) == 0 and not Mission.WaitingForAmmo then
					Mission.WaitingForAmmo = true
					luaDelaySet("B17Finished", true, 10)
					--PerfTimingEnd("white")
					return
				end
		
			elseif Mission.B17Finished then	-- endphase, bombak ledobva/repulok megolve
-- RELEASE_LOGOFF  				luaLog("Airfield saved")
				SetInvincible(Mission.Airfield, true)
				Mission.MissionPhase = 99
				luaFadeAway("luaPC2AirfieldEndMovie")
			end
		end

		if next(Mission.B17s) then
			local idles = luaIdleUnitFilter(luaRemoveEmptyPlanes(Mission.B17s))
	
			for idx, value in pairs (idles) do
-- RELEASE_LOGOFF  				luaLog("Idle unit "..value.Name.." (ID "..tostring(value.ID)..") is attacking again")
				if not Mission.Airfield.Dead then
					luaSetScriptTarget(value, Mission.Airfield)
				end
			end
		end
		
		--luaCheckMusic(Mission.Airfield)
		
	elseif this.MissionPhase == 2 then	-- dauntlesses and avengers on destroyers

		if this.Cheat_PhaseShift then
			this.Cheat_PhaseShift = false
-- RELEASE_LOGOFF  			luaLog("Cheating !")
			Mission.StrikePlaneSpawned = Mission.StrikePlaneLimit
			Mission.StrikePlanes = luaRemoveDeadsFromTable(Mission.StrikePlanes)
			for idx, value in pairs (Mission.StrikePlanes) do
				Kill(value, true)
			end
		end

		if not Mission.DDIntro then
			Mission.DDIntro = true
			Mission.IntroRunning = true
			luaFadeAway("luaPC2DDMovie")
			Mission.CurrentUnit = GetSelectedUnit()
			luaDelaySet("StrikePlaneDBLimit", 2, 40)
			luaDelaySet("StrikePlaneDBLimit", 3, 100)
			luaDelaySet("StrikePlaneTBLimit", 2, 60)
			luaDelaySet("StrikePlaneTBLimit", 3, 120)
		end
		
		if Mission.IntroRunning then
			--PerfTimingEnd("white")
			return
		end
		
		Mission.DDs = luaRemoveDeadsFromTable(Mission.DDs)
		if not next(Mission.DDs) then
-- RELEASE_LOGOFF  			luaLog("DDs killed!")
			luaMissionFailedNew(luaPickRnd(Mission.PrevDDs), "The destroyers are sinking!")
			--PerfTimingEnd("white")
			return
		end
		Mission.PrevDDs = luaSumTables(Mission.DDs)
		
		--[[
		Mission.StrikePlanes = luaRemoveDeadsFromTable(Mission.StrikePlanes)
		if table.getn(Mission.StrikePlanes) < table.getn(Mission.PrevStrikePlanes) then
			MissionNarrative("pc2.nar_remaining|."..tostring(Mission.StrikePlaneLimit - Mission.StrikePlaneSpawned))
		end
		Mission.PrevStrikePlanes = luaSumTables(Mission.StrikePlanes)
		]]
		
		if Mission.StrikePlaneSpawned < Mission.StrikePlaneLimit then	-- folyamatosan jonnek, amig el nem erjuk a limitet
			if Mission.NextStrikePlane == "diver" then
				luaSquadronSupply(this.DauntlessTmpl, this.StrikePlaneDBLimit, luaPC2StrikePlaneSpawned, "ammo", ST_ABSANGLE, luaPickRnd(Mission.DDs), 12000, 16000, 150, -247, -290)
				Mission.NextStrikePlane = "torpedoer"
			else
				luaSquadronSupply(this.AvengerTmpl, this.StrikePlaneTBLimit, luaPC2StrikePlaneSpawned, "ammo", ST_ABSANGLE, luaPickRnd(Mission.DDs), 12000, 16000, 150, -247, -290)
				Mission.NextStrikePlane = "diver"
			end
		else
-- RELEASE_LOGOFF  			luaLog("All strikeplanes have been spawned, awaiting for their death...")
			Mission.StrikePlanesFinished = true
			Mission.StrikePlanes = luaRemoveDeadsFromTable(Mission.StrikePlanes)
			if not next(Mission.StrikePlanes) then
				Mission.MissionPhase = 99
				
				for idx, value in pairs (Mission.DDs) do
					SetInvincible(value, true)
				end
				luaFadeAway("luaPC2DDEndMovie")
			end
		end
		
		local idles = luaIdleUnitFilter(luaRemoveDeadsFromTable(Mission.StrikePlanes))
		for idx, value in pairs (idles) do
-- RELEASE_LOGOFF  			luaLog("Idle unit "..value.Name.." (ID "..tostring(value.ID)..") is attacking again")
			local striketarget = luaPickRnd(Mission.DDs)
			if not striketarget.Dead then
				luaSetScriptTarget(value, striketarget)
			end
		end
		
		--luaCheckMusic(Mission.DDs[1])
		
	elseif this.MissionPhase == 3 then	-- dauntlesses on shipyard

		if this.Cheat_PhaseShift then
			this.Cheat_PhaseShift = false
-- RELEASE_LOGOFF  			luaLog("Cheating !")
			Mission.SYAttackerSpawned = Mission.SYAttackerLimit
			Mission.SYAttackers = luaRemoveDeadsFromTable(Mission.SYAttackers)
			for idx, value in pairs (Mission.SYAttackers) do
				Kill(value, true)
			end
		end

		if not Mission.SYIntro then
			Mission.SYIntro = true
			Mission.IntroRunning = true
			luaFadeAway("luaPC2SYMovie")
			Mission.CurrentUnit = GetSelectedUnit()
			
			luaDelaySet("SYAttackerNum", 2, 30)
			luaDelaySet("SYAttackerNum", 3, 60)
			luaDelaySet("SYAttackerNum", 4, 90)
			luaDelaySet("SYAttackerNum", 5, 120)
		end

		if Mission.IntroRunning then
			--PerfTimingEnd("white")
			return
		end
		
		Mission.SYs = luaRemoveDeadsFromTable(Mission.SYs)

		if not next(Mission.SYs) then
-- RELEASE_LOGOFF  			luaLog("Shipyard entities")
			luaMissionFailedNew(Mission.SY1, "You lost the hangars!")
			--PerfTimingEnd("white")
			return
		end

		luaDelay(luaP3SpawnDelay, 9)

		if Mission.P3StartSpawning and Mission.SYAttackerSpawned < Mission.SYAttackerLimit then	-- folyamatosan jonnek, amig el nem erjuk a limitet
			luaSquadronSupply(this.DauntlessTmpl, Mission.SYAttackerNum, luaPC2SYAttackerSpawned, "ammo", ST_ABSANGLE, luaPickRnd(Mission.SYs), 6000, 7000, 1000, -92, -112)
		elseif Mission.P3StartSpawning then
			Mission.SYAttackers = luaRemoveDeadsFromTable(Mission.SYAttackers)
			if not next (Mission.SYAttackers) then
				Mission.MissionPhase = 99
				luaPC2SYEndMovie()
			end
		end
		
		local idles = luaIdleUnitFilter(luaRemoveDeadsFromTable(Mission.SYAttackers))
		for idx, value in pairs (idles) do
-- RELEASE_LOGOFF  			luaLog("Idle unit "..value.Name.." (ID "..tostring(value.ID)..") is attacking again")
			local systoattack = luaPickRnd(Mission.SYs)
			if not systoattack.Dead then
				luaSetScriptTarget(value, systoattack)
			end
		end
		
		--luaCheckMusic(Mission.SYs[1])
	
	elseif this.MissionPhase == 4 then	-- landing operation
		if not Mission.LOIntro then
			Mission.LOIntro = true
			Mission.IntroRunning = true
			luaFadeAway("luaPC2LOMovie")
			Mission.CurrentUnit = GetSelectedUnit()
		end
		
		if Mission.IntroRunning then
			--PerfTimingEnd("white")
			return
		end
		
		luaPC2CheckLandings()
		
		if not next (Mission.Transports) and Mission.LandingBoatNum == 0 then
			luaObj_Completed("primary", 4)
			HideScoreDisplay(1,0)
			
			if not Mission.Airfield.Dead then
				luaMissionCompletedNew(Mission.Airfield, "You successfully saved the island!")
			else
				luaMissionCompletedNew(luaPickRnd(Mission.PrevLandingBoats), "You successfully saved the island!")
			end
			--PerfTimingEnd("white")
			return
		else
			
			if Mission.Transports and Mission.LandingBoatNum then
			
				Mission.InvLeft = table.getn(luaRemoveDeadsFromTable(Mission.Transports)) + Mission.LandingBoatNum
				local line1 = "Eliminate the landing fleet!"
				local line2 = "Landing ship(s) left: #Mission.InvLeft#"
				luaDisplayScore(1, line1, line2)
			
			end
			
		end
		
		--luaCheckMusic(Mission.Airfield)
		
	elseif this.MissionPhase == 99 then	-- pihenopalya
		
-- RELEASE_LOGOFF  		luaLog("\n...Hangup...\n")
	end
	--PerfTimingEnd("white")
end

function luaPC2StepPhase()
-- RELEASE_LOGOFF  	luaLog("Stepping missionphase")
	Mission.MissionPhase = Mission.MissionPhase + 1
end

function luaPC2B17Spawned(unit)
-- RELEASE_LOGOFF  	luaLog("B17 spawned!")
	table.insert(Mission.B17s, unit)
	Mission.B17sSpawned = Mission.B17sSpawned + 1

	if not Mission.Airfield.Dead then
		luaSetScriptTarget(unit, Mission.Airfield)
	end

	AddListener("kill", "strikerKill"..Mission.SpawnedUnit, {
		["callback"] = "luaPC2B17Killed",
		["entity"] = {unit},
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
	Mission.SpawnedUnit = Mission.SpawnedUnit + 1
end

function luaPC2B17Killed()
-- RELEASE_LOGOFF  	luaLog("Enemy B17 shot down")
	Mission.B17sKilled = Mission.B17sKilled + 1
	if Mission.B17Limit - Mission.B17sKilled > 0 then
		MissionNarrative("Enemy squadrons remaining: |."..tostring(Mission.B17Limit - Mission.B17sKilled))
	end
end

function luaPC2StrikePlaneSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("Strikeplane spawned! "..unit.Name)
	table.insert(Mission.StrikePlanes, unit)
	Mission.StrikePlaneSpawned = Mission.StrikePlaneSpawned + 1

	local striketarget = luaPickRnd(Mission.DDs)
	if not striketarget.Dead then
		luaSetScriptTarget(unit, striketarget)
	end

	AddListener("kill", "strikerKill"..Mission.SpawnedUnit, {
		["callback"] = "luaPC2StrikePlaneKilled",
		["entity"] = {unit},
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
	Mission.SpawnedUnit = Mission.SpawnedUnit + 1
end

function luaPC2StrikePlaneKilled()
-- RELEASE_LOGOFF  	luaLog("Enemy strike plane shot down")
	Mission.StrikePlanesKilled = Mission.StrikePlanesKilled + 1
	if Mission.StrikePlaneLimit - Mission.StrikePlanesKilled > 0 then
		MissionNarrative("Enemy squadrons remaining: |."..tostring(Mission.StrikePlaneLimit - Mission.StrikePlanesKilled))
	end
end

function luaPC2SYAttackerSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("SYAttacker spawned: "..unit.Name)
	table.insert(Mission.SYAttackers, unit)
	Mission.SYAttackerSpawned = Mission.SYAttackerSpawned + 1
	
	local systoattack = luaPickRnd(Mission.SYs)
	if not systoattack.Dead then
		luaSetScriptTarget(unit, systoattack)
	end

--	AddListener("kill", "strikerKill"..tostring(unit.ID), {
	AddListener("kill", "strikerKill"..Mission.SpawnedUnit, {
		["callback"] = "luaPC2SYAttackerKilled",
		["entity"] = {unit},
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
	Mission.SpawnedUnit = Mission.SpawnedUnit + 1
end

function luaPC2SYAttackerKilled()
-- RELEASE_LOGOFF  	luaLog("Enemy SYAttacker shot down")
	Mission.SYAttackerKilled = Mission.SYAttackerKilled + 1
	if Mission.SYAttackerLimit - Mission.SYAttackerKilled > 0 then
		MissionNarrative("Enemy squadrons remaining: |."..tostring(Mission.SYAttackerLimit - Mission.SYAttackerKilled))
	end
end

function luaPC2SpawnDDs()	-- LOADING SCREEN HERE
-- RELEASE_LOGOFF  	luaLog("Spawning DDs")
	Loading_Start()
	Loading_Progress(0.1)

	--UnloadClass(116)		-- B17 out

	Loading_Progress(0.25)
	
	Mission.DDs = luaGenerateObjects(Mission.DDsTmpl)
	local loading = 0.7
	Loading_Progress(loading)
	for idx, value in pairs (Mission.DDs) do
		local shipspeed = GetShipMaxSpeed(value)/5
		SetShipSpeed(value, shipspeed)
-- RELEASE_LOGOFF  		luaLog("Ship max speed: "..shipspeed)
		SetRoleAvailable(value, EROLF_ALL, PLAYER_AI)
		NavigatorMoveOnPath(value, Mission.DDPath, PATH_FM_CIRCLE, PATH_SM_BEGIN)
		
		Loading_Progress(loading)
		loading = loading + 0.1
	end
	Loading_Progress(1)
	Loading_Finish()
end

function luaPC2SpawnTransports()
-- RELEASE_LOGOFF  	luaLog("Spawning transport ships")

	--UnloadClass(108)		-- Dauntless
--[[	
	PrepareClass(36)	-- us troop transport
	PrepareClass(40)	-- higgins
]]
	Mission.Transports = luaGenerateObjects(Mission.TransportsTmpl)
end

function luaPC2CheckLandings()
-- RELEASE_LOGOFF  	luaLog("Checking landings...")
	
	-- partraszalltak szurese
	local furtherLanding = {}
	
	Mission.PrevLandingBoats = luaSumTables(Mission.LandingBoats)
	Mission.LandingBoats = luaRemoveDeadsFromTable(Mission.LandingBoats, "dead landing boats")
	
	for key, value in pairs(Mission.LandingBoats) do
		--UpdateUnitTable(value)
		if value.LandingStarted then
			Mission.LandedBoatNum = Mission.LandedBoatNum + 1

			luaKillDelayed(value, 10)
		else
			table.insert(furtherLanding, value)
		end
	end
	
	Mission.LandingBoats = furtherLanding
	Mission.LandingBoatNum = luaCountTable(Mission.LandingBoats)
	
	-- checking final landing num
	if Mission.LandedBoatNum > Mission.LandedBoatMaxNum then
-- RELEASE_LOGOFF  		luaLog("Too much landing boats landed. Mission failed.")
		
		luaMissionFailedNew(luaPickRnd(Mission.LandingBoats), "Too many landing boats landed!")
		return
	end
	
	Mission.Transports = luaRemoveDeadsFromTable(Mission.Transports)
	
	if next(Mission.Transports) then	-- ha meg elnek a transportok, spawnolunk
		-- szuksegesek bespawnolasa
		if Mission.LandingBoatNum < Mission.LandingBoatMaxNum then
			local unit = GenerateObject(Mission.LCVPTmpl.Name)
			
-- RELEASE_LOGOFF  			luaLog("GENPOS: "..Mission.NextGenPos)
			PutRelTo(unit, luaPickRnd(Mission.Transports), Mission.GenPos[Mission.NextGenPos])
			if Mission.NextGenPos == 4 then
				Mission.NextGenPos = 1
			else
				Mission.NextGenPos = Mission.NextGenPos + 1
			end
			
-- RELEASE_LOGOFF  			luaLog("LANDING PATH: "..Mission.NextLandingPath)
			NavigatorMoveOnPath(unit, Mission.LandingPaths[Mission.NextLandingPath], PATH_FM_SIMPLE)
			NavigatorSetAvoidLandCollision(unit, false)
			table.insert(Mission.LandingBoats, unit)
			
			if Mission.NextLandingPath == table.getn(Mission.LandingPaths) then
				Mission.NextLandingPath = 1
			else
				Mission.NextLandingPath = Mission.NextLandingPath + 1
			end
		end
	else
		if not Mission.ObjModded then
			Mission.ObjModded = true
-- RELEASE_LOGOFF  			luaLog("Adding landing boats markers")
			luaObj_AddUnit("primary", 4, Mission.LandingBoats)
			
		end
	end
end

--------------------------------------------------
-- MOVIES start
function luaPC2AirfieldMovie()
	
	local blyat = LaunchSquadron(Mission.Airfield, 150, 3)
	Mission.InitZero = thisTable[tostring(GetProperty(Mission.Airfield, "slots")[blyat].squadron)]
	
	luaFadeIn()

	local pos0 = {
			["postype"]="target",
			["position"]= {
				["parent"]=Mission.Airfield,
				["pos"] = { 0, 0, 100, },
			},
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["zoom"]=1.0,
		}
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
			["postype"]="target",
			["position"]= {
				["parent"]=Mission.Airfield,
				["pos"] = { 0, 0, -100, },
			},
			["starttime"]=0.0,
			["blendtime"]=15.0,
			["zoom"]=1.0,
		}
	MovCamNew_AddPosition(pos0)

	local movCamPos = {
		["postype"] = "camera", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.Airfield,
			["modifier"] = { -- opcionalis
				["name"] = "goaround", -- "goaround" 
				["radius"] = {600},
				["theta"] = {20},
				["rho"] = {0, 80, 300},
			},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["nonlinearblend"] = 5, -- 0..n, 0 a linear, 1 az S gorbe
		["zoom"] = 1	-- 15-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)

	luaObj_Add("primary", 1, Mission.Airfield)
	DisplayUnitHP({Mission.Airfield}, "Save the airfield hangar!")
	
	--Mission.AirfieldSelectDelay = luaJumpToUnit(Mission.Airfield, SetSkipMovie, 5)
	Mission.AirfieldSelectDelay = luaDelay(luaPC2IntroSkip, 7)
	SetSkipMovie("luaPC2IntroSkip")
end

function luaPC2IntroSkip()
	SetSkipMovie()
	luaCrossFade(luaPC2IntroSitInUnit)
end

function luaPC2IntroSitInUnit()
-- RELEASE_LOGOFF  	luaLog("Skipping intro movie !!!")
	SetSelectedUnit(Mission.InitZero)
	
	if not Mission.AirfieldSelectDelay.Dead then
		luaClearDelay(Mission.AirfieldSelectDelay)
	end
end

function luaPC2AirfieldEndMovie()
-- RELEASE_LOGOFF  	luaLog("Airfield end movie")
	SetSkipMovie("luaPC2AirfieldEndSkip")
	
	luaFadeIn()
	luaObj_Completed("primary", 1)
	HideUnitHP()

---------------------------------------------------------------------------------------
-- AIRFIELD CAMERA PAN
	local camPosition = {
			["x"] = 656,
			["y"] = 45,
			["z"] = 1834
			}

	local movCamPos = {
		["postype"] = "camera", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			--["parent"] = Mission.Airfield,
			["pos"] = luaConvertXYZTo123(camPosition)
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["nonlinearblend"] = 0, -- 0..n, 0 a linear, 1 az S gorbe
		["zoom"] = 1.5,	-- 20-os FOV!
		["smoothtime"] = 0
		-- korbekorbe/csuszasmaszas
	}
	MovCamNew_AddPosition(movCamPos)

	local targetPosition = luaMoveCoordinate(camPosition, 100, 98)
		targetPosition.y = 30
	local movCamPos = {
		["postype"] = "target", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			--["parent"] = Mission.Airfield,
			["pos"] = luaConvertXYZTo123(targetPosition)
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["nonlinearblend"] = 0, -- 0..n, 0 a linear, 1 az S gorbe
		["zoom"] = 1.5,	-- 20-os FOV!
		["smoothtime"] = 0
	}
	MovCamNew_AddPosition(movCamPos)

-----------

	--local camPosition2 = luaMoveCoordinate(camPosition, 400, 12.5)
	local camPosition2 = {
			["x"] = 1050,
			["y"] = 45,
			["z"] = 1364
			}
			
	--local targetPosition2 = luaMoveCoordinate(targetPosition, 400, 12.5)
	local targetPosition2 = luaMoveCoordinate(camPosition2, 100, 98)
		targetPosition2.y = 30

	local movCamPos = {
		["postype"] = "camera", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			--["parent"] = Mission.Airfield,
			["pos"] = luaConvertXYZTo123(camPosition2)
		},
		["starttime"] = 0,
		["blendtime"] = 10,
		["nonlinearblend"] = 0, -- 0..n, 0 a linear, 1 az S gorbe
		["zoom"] = 1.5,	-- 20-os FOV!
		["smoothtime"] = 0
	}
	MovCamNew_AddPosition(movCamPos)
	
	local movCamPos = {
		["postype"] = "target", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			--["parent"] = Mission.Airfield,
			["pos"] = luaConvertXYZTo123(targetPosition2)
		},
		["starttime"] = 0,
		["blendtime"] = 10,
		["nonlinearblend"] = 0, -- 0..n, 0 a linear, 1 az S gorbe
		["zoom"] = 1.5,	-- 20-os FOV!
		["smoothtime"] = 0
	}
	MovCamNew_AddPosition(movCamPos)
-- CAMERA PAN end
---------------------------------------------------------------------------------------	
	
	MissionNarrative("You saved the airfield hangar!")
	
	Mission.PhaseStepDelay = luaDelaySet("MissionPhase", 2, 7)
	--Mission.MissionPhase = 2
end

function luaPC2AirfieldEndSkip()
-- RELEASE_LOGOFF  	luaLog("Skipping Airfield end movie !!!")
	if not Mission.PhaseStepDelay.Dead then
		luaClearDelay(Mission.PhaseStepDelay)
	end
	
	Mission.MissionPhase = 2
	SetWait(Mission, 0.1)
end

function luaPC2DDMovie()
	luaPC2SpawnDDs()
	luaFadeIn()
	
	local movCamPos = {
		["postype"] = "camera", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.DDs[1],
			["pos"] = {20, 10, 150},
			--["pos"] = {35, 3, 300},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = true,
		["transformtype"] = "keepy",
		["zoom"] = 2	-- nem -- 5-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)

	local movCamPos = {
		["postype"] = "target", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.DDs[2],
			--["pos"] = {50, 5, 0},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = true,
		["transformtype"] = "keepy",
		["zoom"] = 2	-- nem -- 5-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)

	local movCamPos = {
		["postype"] = "target", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.DDs[2],
			["pos"] = {75, 5, 0},
		},
		["starttime"] = 0,
		["blendtime"] = 7.5,
		["wanderer"] = true,
		["transformtype"] = "keepy",
		["zoom"] = 2	-- nem -- 5-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)

	Mission.DDMovieDelay = luaDelay(luaPC2DDMovieSitInUnit, 10)

	Mission.IntroRunning = false
	luaObj_Add("primary", 2, Mission.DDs, true)
	MissionNarrative("Now protect the destroyers at all costs!")
	DisplayUnitHP(Mission.DDs, "Save the destroyers!")
	
	SetSkipMovie("luaPC2DDMovieSitInUnit")
end

--[[
function luaPC2DDMovie2()
	Mission.IntroRunning = false
	luaObj_Add("primary", 2, Mission.DDs, true)
	MissionNarrative("pc2.nar_ddsave")
end
]]

function luaPC2DDMovieSitInUnit()
	luaCrossFade(luaPC2DDMovie2)
end

function luaPC2DDMovie2()
	SetSkipMovie()
	if not Mission.DDMovieDelay.Dead then
		luaClearDelay(Mission.DDMovieDelay)
	end

	if Mission.CurrentUnit == nil or (Mission.CurrentUnit and Mission.CurrentUnit.Dead) then
-- RELEASE_LOGOFF  		luaLog("No unit selected or unit is dead. Jumping to airfield")
		--SetSelectedUnit(Mission.Airfield)
		--luaJumpToUnit(Mission.Airfield, nil, 9)
	elseif IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("Jumping to unit "..Mission.CurrentUnit.Name)
		SetSelectedUnit(Mission.CurrentUnit)
	elseif not IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("The Unit is not selectable, forcing Airfield selection")
		--SetSelectedUnit(Mission.Airfield)
	end

	for idx, value in pairs (Mission.DDs) do
		SetShipSpeed(value, GetShipMaxSpeed(value))
 		NavigatorMoveOnPath(value, Mission.DDPath, PATH_FM_CIRCLE, PATH_SM_BEGIN)
	end
end

function luaPC2DDEndMovie()
-- RELEASE_LOGOFF  	luaLog("DDend movie")
	
	luaFadeIn()
	
	local movCamPos = {
		["postype"] = "cameraandtarget", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.DDs[1],
			["modifier"] = { -- opcionalis
				["name"] = "goaround",
				["radius"] = {300, 30, 1000},
				["theta"] = {10},
				["rho"] = {0, 30, 300},
			},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)
	
	if table.getn(Mission.DDs) > 1 then
		MissionNarrative("You saved the destroyers!")
	else
		MissionNarrative("You saved one destroyer!")
	end
	
	luaObj_Completed("primary", 2)
	HideUnitHP()
	
	luaDelay(luaPC2DDEndMovie2, 7)
	--luaDelaySet("MissionPhase", 3, 7)
	SetSkipMovie("luaPC2DDEndMovie2")
end

function luaPC2DDEndMovie2()
	Mission.MissionPhase = 3
	SetWait(Mission, 0.1)
	SetSkipMovie()
end

function luaPC2SYMovie()
	--UnloadClass(113)		-- Avenger out
	
	luaFadeIn()
	local movCamPos = {
		["postype"] = "cameraandtarget", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.SYs[1],
			["modifier"] = { -- opcionalis
				["name"] = "goaround",
				["radius"] = {300, 30, 1000},
				["theta"] = {10},
				["rho"] = {0, 30, -300},
			},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)
	
	luaObj_Add("primary", 3, Mission.SYs)
	DisplayUnitHP(Mission.SYs, "Save the jetty hangars!")
	Mission.IntroRunning = false

	Mission.SYMovieDelay = luaDelay(luaPC2SYMovieSitInUnit, 10)
	SetSkipMovie("luaPC2SYMovieSitInUnit")
end

function luaPC2SYMovieSitInUnit()
	SetSkipMovie()
	luaCrossFade(luaPC2SYMovie2)
end

function luaPC2SYMovie2()
	if not Mission.SYMovieDelay.Dead then
		luaClearDelay(Mission.SYMovieDelay)
	end

	Mission.DDs = luaRemoveDeadsFromTable(Mission.DDs)
	if table.getn(Mission.DDs) ~= 0 then
		for idx, value in pairs (Mission.DDs) do
			NavigatorSetAvoidLandCollision(value, false)
			SetShipSpeed(value, GetShipMaxSpeed(value))
 			NavigatorMoveOnPath(value, Mission.DDPathStop[idx], PATH_FM_SIMPLE, PATH_SM_BEGIN)
		end
	end

	if Mission.CurrentUnit == nil or (Mission.CurrentUnit and Mission.CurrentUnit.Dead) then
-- RELEASE_LOGOFF  		luaLog("No unit selected or unit is dead. Jumping to airfield")
		--SetSelectedUnit(Mission.Airfield)
	elseif IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("Jumping to unit "..Mission.CurrentUnit.Name)
		SetSelectedUnit(Mission.CurrentUnit)
	elseif not IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("The Unit is not selectable, forcing Airfield selection")
		--SetSelectedUnit(Mission.Airfield)
	end
end

--[[
function luaPC2SYMovie2()
	luaObj_Add("primary", 3, Mission.SYs)
	Mission.IntroRunning = false
	
	if Mission.CurrentUnit == nil or (Mission.CurrentUnit and Mission.CurrentUnit.Dead) then
-- RELEASE_LOGOFF  		luaLog("No unit selected or unit is dead. Jumping to airfield")
		luaJumpToUnit(Mission.Airfield, nil, 8)
	else
-- RELEASE_LOGOFF  		luaLog("Jumping to unit "..Mission.CurrentUnit.Name)
		luaJumpToUnit(Mission.CurrentUnit, nil, 8)
	end
end
]]

function luaPC2SYEndMovie()
-- RELEASE_LOGOFF  	luaLog("SYEnd movie")
	luaObj_Completed("primary", 3)
	HideUnitHP()
	
	luaFadeIn()
	local movCamPos = {
		["postype"] = "cameraandtarget", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.SYs[1],
			["modifier"] = { -- opcionalis
				["name"] = "goaround",
				["radius"] = {300, 30, 1000},
				["theta"] = {10},
				["rho"] = {0, 30, 300},
			},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)
	
	MissionNarrative("You saved your hangar facilities!")
	
	--luaDelaySet("MissionPhase", 4, 7)
	Mission.SYEndMovieDelay = luaDelay(luaPC2SYEndMovie2, 7)
-- RELEASE_LOGOFF  	luaLog("SY Delay ID : "..Mission.SYEndMovieDelay.ID)
	SetSkipMovie("luaPC2SYEndMovie2")
end

function luaPC2SYEndMovie2()
	SetSkipMovie()
	
	if not Mission.SYEndMovieDelay.Dead then
-- RELEASE_LOGOFF  		luaLog("SY delay is not dead")
		luaClearDelay(Mission.SYEndMovieDelay)
	end

	Mission.MissionPhase = 4
	MissionNarrativeClear()
	SetWait(Mission, 0.1)
end

function luaPC2LOMovie()
-- RELEASE_LOGOFF  	luaLog("Transport movie called")
	
	luaPC2SpawnTransports()
	luaFadeIn()

--[[
	
	local movCamPos = {
		["postype"] = "cameraandtarget", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["parent"] = Mission.Transports[1],
			["modifier"] = { -- opcionalis
				["name"] = "goaround",
				["radius"] = {300, 30, 1000},
				["theta"] = {10},
				["rho"] = {0, 30, 300},
			},
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)
]]

	-- ket transport kozott nezunk a szigetre

	local pos1 = GetPosition(Mission.Transports[1])
	local pos2 = GetPosition(Mission.Transports[2])
	
	local posBetween = {
		["x"] = (pos1.x + pos2.x)/2,
		["z"] = (pos1.z + pos2.z)/2,
		}	
		posBetween.y = 200
	
	local rot = luaGetRotation(Mission.Transports[1])

	
	--local camPos = {["x"] = -1800, ["y"] = 217, ["z"] = -1529}
	local camPos = luaMoveCoordinate(posBetween, 1200, rot+180)
	
	local movCamPos = {
		["postype"] = "camera", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			["pos"] = luaConvertXYZTo123(camPos),
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)

	--local targetCoord = luaMoveCoordinate(camPos, 10000, rot)
	local movCamPos = {
		["postype"] = "target", -- "camera", "target" vagy "cameraandtarget"
		["position"] = {
			--["pos"] = {luaConvertXYZTo123(targetCoord)},
			["parent"] = FindEntity("Fortress"),
			["pos"] = {0, 0, 0}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["zoom"] = 1.5	-- 20-os FOV!
	}
	MovCamNew_AddPosition(movCamPos)
		
	Mission.IntroRunning = false	-- itt elobb hivjuk, hogy ne bukjon le a Higgins-Spawn
	
	Mission.LOMovieDelay = luaDelay(luaPC2LOMovieSitInUnit, 9)
	luaObj_Add("primary", 4, Mission.Transports, true)
	MissionNarrative("The invasion has begun. Stop those landing boats!")

	Mission.DDs = luaRemoveDeadsFromTable(Mission.DDs)
	if table.getn(Mission.DDs) ~= 0 then
		for idx, value in pairs (Mission.DDs) do
			SetShipSpeed(value, 0)
			NavigatorEnable(value, false)
		end
	end

	SetSkipMovie("luaPC2LOMovieSitInUnit")
end

function luaPC2LOMovieSitInUnit()
	SetSkipMovie()
	luaCrossFade(luaPC2LOMovie2)
end

function luaPC2LOMovie2()
	if not Mission.LOMovieDelay.Dead then
		luaClearDelay(Mission.LOMovieDelay)
	end
	
	if Mission.CurrentUnit == nil or (Mission.CurrentUnit and Mission.CurrentUnit.Dead) then
-- RELEASE_LOGOFF  		luaLog("No unit selected or unit is dead. Jumping to airfield")
		--SetSelectedUnit(Mission.Airfield)
	elseif IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("Jumping to unit "..Mission.CurrentUnit.Name)
		SetSelectedUnit(Mission.CurrentUnit)
	elseif not IsUnitSelectable(Mission.CurrentUnit) then
-- RELEASE_LOGOFF  		luaLog("The Unit is not selectable, forcing Airfield selection")
		--SetSelectedUnit(Mission.Airfield)
	end
end
-- MOVIES end
--------------------------------------------------

-- ha elfogyott a jatekos repuloje, vege a dalnak
function luaPC2CheckPlayerPlanes()
-- RELEASE_LOGOFF  	luaLog("Checking player's planestock...")
	local planes = {}
	--stock = 0

--[[	
	-- levegoben levok elenorzese
	for idx, value in pairs (recon[PARTY_JAPANESE].own.fighter) do
-- RELEASE_LOGOFF  		luaLog(" Found plane in air with ID: "..tostring(value.ID))
		table.insert(planes, value)
	end
]]

	-- stockon levok ellenorzese, airbase status es aktiv repulok ellenorzese
	if not Mission.Airfield.Dead then
		--UpdateUnitTable(Mission.Airfield)

		--[[for idx, value in pairs (Mission.Airfield.planes) do
			stock = stock + value.number
		end]]

		Mission.AirbaseStatus = GetAirBaseStatus(Mission.Airfield)
		Mission.ActivePlanes = luaGetSlotsAndSquads(Mission.Airfield)
	end
	
	--luaDelay(luaCheckZeroes, 1)
end

function luaCheckZeroes()
-- RELEASE_LOGOFF  	luaLog("-stock: "..tostring(stock))
-- RELEASE_LOGOFF  	luaLog("-airbasestatus: "..tostring(Mission.AirbaseStatus))
-- RELEASE_LOGOFF  	luaLog("-activeplanes: "..tostring(Mission.ActivePlanes))
	if Mission.AirbaseStatus == 0 and Mission.ActivePlanes == 0 then
-- RELEASE_LOGOFF  		luaLog("No more Zeroes")
		Mission.MissionOver = true
		Mission.MissionPhase = 99
		luaMissionFailedNew(Mission.Airfield, "You ran out of Zeroes!")
	end
end

function luaP3SpawnDelay()
	Mission.P3StartSpawning = true
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end