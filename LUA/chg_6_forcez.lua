--SceneFile="universe\Scenes\missions\Challenge\forcez.scn"
--PC3
function luaPrecacheUnits()
	
	PrepareClass(166) 
	PrepareClass(167) 
	
end

function luaStageInit()
	CreateScript("luaInitForceZMission")
end

function luaInitForceZMission(this)
	Mission = this
	this.Name = "ForceZ"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("pc3")
	LoadSelectedPaths()

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	this.MissionPhase = 0
	this.FirstRun = true

	-- weather
	SetDayTime(12) -- 12 orakor kezdodik
	SetWeather("Clear") -- tiszta idoben

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

	-- rnd felhok
	--luaGenerateRandomClouds(25, {{["x"]=-9000, ["y"]=500, ["z"]=-9000}, {["x"]=9000, ["y"]=1000, ["z"]=9000}}, 5, 3, 0)

	-- fontos koordinatak
	
	-- allied objektumok
	this.AlliedCV = FindEntity("Hermes")
	this.AlliedBBs = {}
		table.insert(this.AlliedBBs, FindEntity("Prince of Wales"))
		table.insert(this.AlliedBBs, FindEntity("Repulse"))
	this.AlliedDDs = {}
		table.insert(this.AlliedDDs, FindEntity("Electra"))
		table.insert(this.AlliedDDs, FindEntity("Vampire"))

	this.AlliedFleet = {}
		table.insert(this.AlliedFleet, FindEntity("Hermes"))
		table.insert(this.AlliedFleet, FindEntity("Prince of Wales"))
		table.insert(this.AlliedFleet, FindEntity("Repulse"))
		table.insert(this.AlliedFleet, FindEntity("Electra"))
		table.insert(this.AlliedFleet, FindEntity("Vampire"))

	this.AlliedAirPatrol = {}

	-- japanese objektumok
	Mission.JapAirfields = {}
		table.insert(this.JapAirfields, FindEntity("AirField"))
		table.insert(this.JapAirfields, FindEntity("AirFie1d"))
	SetGuiName(Mission.JapAirfields[1], "globals.unitclass_airfield")
	SetGuiName(Mission.JapAirfields[2], "globals.unitclass_airfield")
	this.PlayerAirbases = {}
		table.insert(this.PlayerAirbases, this.JapAirfields[1])
		table.insert(this.PlayerAirbases, this.JapAirfields[2])
	--luaPlayerAirbaseInit(this.PlayerAirbases)
	SetAirBaseSlot(this.JapAirfields[1], 1, 166, 3, 1)
	SetAirBaseSlot(this.JapAirfields[1], 2, 166, 3, 1)
	SetAirBaseSlot(this.JapAirfields[1], 3, 167, 3, 2)
	SetAirBaseSlot(this.JapAirfields[1], 4, 167, 3, 2)
	SetAirBaseSlot(this.JapAirfields[2], 1, 166, 3, 1)
	SetAirBaseSlot(this.JapAirfields[2], 2, 166, 3, 1)
	SetAirBaseSlot(this.JapAirfields[2], 3, 167, 3, 2)
	SetAirBaseSlot(this.JapAirfields[2], 4, 167, 3, 2)
	
	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
	this.Objectives =
	{
		["primary"] =
		{
			[1] = 
			{
				["ID"] = "DestroyBBs",		-- azonosito
				["Text"] = "Destroy the Prince of Wales and the Repulse!", --Destroy the Prince of Wales and the Repulse.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] =  500*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		},

		["secondary"] =
		{
		},
		
		["hidden"] =
		{
			[1] =
			{
				["ID"] = "DestroyCV",		-- azonosito
				["Text"] = "Destroy the Allied carrier!", --Destroy the allied carrier.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 500*OBJ_HIDDEN_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			},
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	Blackout(true, "", true)

	SetThink(this, "luaForceZMission_think")

	Music_Control_SetLevel(MUSIC_TENSION)
	--luaFirstEnterInstant(Mission.JapAirfields[1])
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
end

function luaForceZMission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	luaForceZCheckConditions(this)

	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

	luaCheckMusic()
	--luaPlayerAirbaseManager(Mission.PlayerAirbases)

-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)

		if this.FirstRun then
			JoinFormation(Mission.AlliedBBs[1], Mission.AlliedCV)
			JoinFormation(Mission.AlliedBBs[2], Mission.AlliedCV)
			JoinFormation(Mission.AlliedDDs[1], Mission.AlliedCV)
			JoinFormation(Mission.AlliedDDs[2], Mission.AlliedCV)
			LaunchAirBaseSlot(Mission.AlliedCV, 1, true)
			LaunchAirBaseSlot(Mission.AlliedCV, 2, true)
			LaunchAirBaseSlot(Mission.AlliedCV, 3, true)
			LaunchAirBaseSlot(Mission.AlliedCV, 4, true)
			local coordinate =
			{
				["x"] = 10000,
				["y"] = 0,
				["z"] = 0
			}
			NavigatorMoveToPos(Mission.AlliedCV, coordinate)
			this.FirstRun = false
			AddListener("exitzone", "exitzone", {
				["callback"] = "luaForceZExitZone",
				["entity"] = Mission.AlliedFleet,
				["exited"] = {false}, -- false: entity entered exit zone, true: entity exited
			})
		end

	if this.MissionPhase == 0 then
		
		if not this.MovieStart then

			Blackout(false,"",2.5)

			luaCrossFade(luaForceIntro)

			this.MovieStart = true
			
		end
	
		luaForceCheckMovieEnd()
	
	end


	if this.MissionPhase == 1 then
		if this.FreeToGo and not luaObj_IsActive("primary", 1) then
			luaObj_Add("primary", 1, Mission.AlliedBBs)
			luaObj_Add("hidden", 1)
			DisplayUnitHP(Mission.AlliedBBs, "Destroy the Prince of Wales and the Repulse!")
		end
		if not Mission.AlliedCV.Dead then
			luaCapManager(Mission.AlliedCV, {134}, 4)
			local activeSquads, planeEntTable = luaGetSlotsAndSquads(Mission.AlliedCV)
			this.AlliedAirPatrol = luaAirPatrol(Mission.AlliedBBs[1], 500, 4000, planeEntTable, this.AlliedAirPatrol)
		elseif not Mission.AlliedPlanesLost then
			local planeEntTable = {}
			ForceRecon()
			for i, unit in pairs(recon[PARTY_ALLIED].own.fighter) do
				if not unit.Dead then
					table.insert(planeEntTable, unit)
				end
			end
			if table.getn(planeEntTable) == 0 then
				Mission.AlliedPlanesLost = true
			else
				this.AlliedAirPatrol = luaAirPatrol(Mission.AlliedBBs[1], 1000, 5000, planeEntTable, this.AlliedAirPatrol)
			end
		end
	end
end

function luaForceZCheckConditions(this)
	if this.EndMission then
		return
	end

	local lastBBs = luaSumTables(Mission.AlliedBBs)
	local lastAirfields = luaSumTables(Mission.JapAirfields)
	Mission.AlliedBBs = luaRemoveDeadsFromTable(Mission.AlliedBBs)
	Mission.JapAirfields = luaRemoveDeadsFromTable(Mission.JapAirfields)

	if Mission.AlliedBBExited then
		luaMissionFailedNew(lastBBs[1], "You have failed to destroy the battleships!") --You have failed to destroy the battleships!
		Mission.EndMission = true
		return
	end

	--local classnum = 0
	--local planesInAir = 0
	--[[for i, airbase in pairs (Mission.JapAirfields) do
		--UpdateUnitTable(airbase)
		for key, value in pairs(airbase.planes) do
			if value.classid == 166 then --Nell
				classnum = classnum + value.number
			elseif value.classid == 167 then --Betty
				classnum = classnum + value.number
			end
		end
		for idx, slotnum in pairs(airbase.slots) do
			if slotnum.squadron ~= nil then
				local planeEnt = thisTable[tostring(slotnum.squadron)]
-- RELEASE_LOGOFF  				luaLog(planeEnt.ClassID)
				if planeEnt.ClassID == 166 then --Nell
					classnum = classnum + 1
				elseif planeEnt.ClassID == 167 then --Betty
					classnum = classnum + 1
				end
			end
		end
	end]]

	--[[if classnum == 0 and not Mission.PlanesLostTime then
		Mission.PlanesLostTime = math.floor(GameTime())
	--[[elseif classnum == 0 and Mission.PlanesLostTime + 5 < math.floor(GameTime()) then
		luaMissionFailedNew(lastBBs[1], "You have lost all your attack planes!") --You have lost all of your attack planes!
		Mission.EndMission = true
		return]]
	end]]

	if table.getn(Mission.AlliedBBs) == 0 then
		if not Mission.AlliedCV.Dead then
			luaObj_Failed("hidden", 1)
		end
		luaObj_CompletedAll()
		HideUnitHP()
		luaMissionCompletedNew(lastBBs[1], "You have destroyed the Allied battleships!") --You have destroyed the allied battleships!
		Mission.EndMission = true
		return
	end

	if Mission.AlliedCV.Dead and luaObj_IsActive("hidden", 1) then
		luaObj_Completed("hidden", 1, true)
	end
end

function luaForceZExitZone()
	Mission.AlliedBBExited = true
end

function luaForceIntro()
	
--[[			TompiAction()
		TSetCamMode(1)

TAddCamPos({["x"]=0.00,["y"]=0.00,["z"]=0.00,},Mission.AlliedCV, 100)
TAddLookatPos({["x"]=1.00,["y"]=1.00,["z"]=1.00,},Mission.AlliedCV, 100) ]]
	
	local blyat = LaunchSquadron(FindEntity("AirField"), 167, 3)
	Mission.InitZero = thisTable[tostring(GetProperty(FindEntity("AirField"), "slots")[blyat].squadron)]
	
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.AlliedCV,
               ["pos"] = { -262.34, 52, 332.12 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
--           ["zoom"] = 3,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.AlliedCV,
               ["pos"] = { -269.42, -9, -67.47, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=13.0,
           ["linearblend"]=1.0,
					--["zoom"] = 3,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=Mission.AlliedCV,
				["pos"] = { -480.78, 6, -203.22 }
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
			--["zoom"]=3,
		}

	MovCamNew_AddPosition(pos0)

	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=Mission.AlliedCV,
				["pos"] = { -531.22, 40, 54.54, }
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=13.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
			--["zoom"]=3,
		}

	MovCamNew_AddPosition(pos0)
  

	SetSkipMovie("luaForceSkipMovie")

end


function luaForceSkipMovie()

	if not Mission.MovieSkip then

		Mission.MovieSkip = true
	
		Mission.FreeToGo = true
		
		Mission.MissionPhase = 1

		SetSkipMovie()
	
		luaCrossFade(luaForceSelectAirfield)
		
	end

end


function luaForceSelectAirfield()

	EnableInput(true)

	SetSelectedUnit(Mission.InitZero)

end


function luaForceCheckMovieEnd()

	if not Mission.MovieSkip and not Mission.MovieEnd and GameTime()>12 then
	
	 Mission.MovieEnd = true

	 luaForceSkipMovie()
	 
	end

end