--SceneFile="universe\Scenes\missions\Challenge\java.scn"
--SC2

function luaPrecacheUnits()
	
	PrepareClass(23) -- Fletcher
	PrepareClass(20) -- DeRuyter
	PrepareClass(17) -- Atlanta
	PrepareClass(317) -- Northampton
	
end

function luaStageInit()
	CreateScript("luaInitJavaMission")
end

function luaInitJavaMission(this)
	Mission = this
	this.Name = "Java"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("sc2")
	LoadSelectedPaths()

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)
	
	this.MissionPhase = 0
	this.FirstRun = true
	this.Difficulty = GetDifficulty()

	-- weather
	SetDayTime(6) -- orakor kezdodik
	SetWeather("Clear") -- idoben

	--luaGenerateRandomClouds(40, {{["x"]=-9000, ["y"]=400, ["z"]=-9000}, {["x"]=9000, ["y"]=600, ["z"]=9000}}, 5, 3, 0)

	-- flavor
	--[[Mission.SeagullPositions = {}
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_1")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_2")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_3")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_4")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_5")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_6")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_7")))
		table.insert(Mission.SeagullPositions, GetPosition(FindEntity("Seagull_8")))

	for idx,pos in pairs(Mission.SeagullPositions) do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = pos,
		})
	end]]

	-- fontos koordinatak
	--Mission.InvalidSpawnAreas = {}
	--table.insert(Mission.InvalidSpawnAreas, {GetPosition(FindEntity("InvalidSpawn_NW")), GetPosition(FindEntity("InvalidSpawn_SE"))})

	-- pathok

	-- allied objektumok
	this.AlliedTemplateFletcher = luaFindHidden("Template_Fletcher")
	this.AlliedTemplateSwordfish = luaFindHidden("Template_Swordfish")
	this.AlliedFletcherNames = {
		[1] = "HMS Encounter",
		[2] = "HMS Jupiter",
		[3] = "HNLMS Evertsen",
		[4] = "HNLMS Kortenaer",
		[5] = "HNLMS Witte de With",
		[6] = "HMS Paladin",
		[7] = "USS Case",
		[8] = "USS Hull",
		[9] = "USS Jarvis",
		[10] = "USS Ralph Talbot",
	}

	--this.AlliedBattleShip = FindEntity("Exeter")

	this.AlliedAttackerTemplates = {}
		table.insert(this.AlliedAttackerTemplates, luaFindHidden("DeRuyter"))
		table.insert(this.AlliedAttackerTemplates, luaFindHidden("Perth"))
		table.insert(this.AlliedAttackerTemplates, luaFindHidden("Java"))
		table.insert(this.AlliedAttackerTemplates, luaFindHidden("Chester"))
		table.insert(this.AlliedAttackerTemplates, luaFindHidden("Houston"))
	this.AlliedAttackPhase = 1
	this.AlliedTarget = luaFindHidden("Houston")

	
	--PrepareClass(109) -- Swordfish

	--[[
	this.AlliedDefenderPaths = {}
		table.insert(this.AlliedDefenderPaths, FindEntity("Patrol_1"))
		table.insert(this.AlliedDefenderPaths, FindEntity("Patrol_2"))
		table.insert(this.AlliedDefenderPaths, FindEntity("Patrol_3"))
		table.insert(this.AlliedDefenderPaths, FindEntity("Patrol_4"))
	]]

	this.AlliedAttackers = {}
	this.AlliedAttackerSpawnDelay = 20
	this.AlliedAttackerMaxNumber = 3
	this.AlliedAttackerReadyToSend = true

	this.AlliedPlanes = {}
	this.AlliedPlaneSpawnDelay = 20
	this.AlliedPlaneMaxNumber = 5
	this.AlliedPlaneReadyToSend = false
	
	-- japanese objektumok
	this.JapPlayerUnit = FindEntity("Nachi")

	this.JapPlayerGroup = {}
		table.insert(this.JapPlayerGroup, FindEntity("Nachi"))
		table.insert(this.JapPlayerGroup, FindEntity("Sazanami"))
		table.insert(this.JapPlayerGroup, FindEntity("Ushio"))
	
	for idx, unit in pairs(this.JapPlayerGroup) do
	
		RepairEnable(unit, false)
	
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
				["Text"] = "The Nachi must survive!", --The Nachi must survive.
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
				["ID"] = "KillThemAll",		-- azonosito
				["Text"] = "Eliminate the USS Houston!", --Eliminate the USS Houston.
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,	-- aktiv-e az objektiva
				["Success"] = nil,	-- sikeres-e az objektiva (true/false, ha nem aktiv, nil)
				["Target"] = {},	-- az objektiva celpontja (ha van), itt meg csak ures tablat adunk
				["ScoreCompleted"] = 2000*OBJ_PRIMARY_MULTIPLIER,	-- teljesitesert jaro pontszam
				["ScoreFailed"] = 0	-- bukasert jaro (negativ) pontszam
			}
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
	
	SetCatapultStock(FindEntity("Nachi"), 0)
	
	SetThink(this, "luaJavaMission_think")
	
	if LobbySettings and LobbySettings.GameMode == "globals.gamemode_islandcapture" then
	
		luaCheckSkirmish()
		
		if Mission.Skirmish then
			
			Mission.EndMission = true
			this.MovieSkip = true
			this.JavaInit = true
			
			luaMissionFailedNew(nil, "A Co-Op map only!")
		
		else
		
			Mission.PlayingCOOP = true
			
		end
	
	else
	
		Blackout(true, "", true)
	
	end
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	luaCheckMusic()
	--luaFirstEnterInstant(this.JapPlayerUnit)
end


function luaJavaMission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.PlayingCOOP then
	
		this.MovieSkip = true
		
	else
	
	if not this.JavaInit then
		
		Blackout(true, "", true)
		luaDelay(luaJavaFadeIn, 3)
		EnableInput(false)

		luaJavaIntro()

		Mission.JavaInit = true
	end
	
	end
	
	if this.MovieSkip then
		
		this.MissionPhase = 1
		
		Mission.FreeToGo = true
		
		this.MovieSkip = nil
	
	end

-- RELEASE_LOGOFF  	luaLog("misünféz:"..tostring(this.MissionPhase))

	if not Mission.MissionPreps then
		JoinFormation(this.JapPlayerGroup[2], this.JapPlayerGroup[1])
		JoinFormation(this.JapPlayerGroup[3], this.JapPlayerGroup[1])
		TorpedoEnable(this.JapPlayerGroup[2], false)
		TorpedoEnable(this.JapPlayerGroup[3], false)
		SetFormationShape(this.JapPlayerGroup[1], 4)
		--[[
		for index, unit in pairs (this.AlliedDefenders) do
			NavigatorMoveOnPath(unit, this.AlliedDefenderPaths[index], PATH_FM_PINGPONG, PATH_SM_JOIN_FORWARD)
			TorpedoEnable(unit, true)
			UnitFreeAttack(unit)
		end
		]]
		Mission.MissionPreps = true
	end

	if not Mission.FreeToGo then
		return
	end

	luaJavaCheckConditions(this)

	luaCheckMusic()

	if this.EndMission then
-- RELEASE_LOGOFF  		luaLog("Mission in end state...")
		return
	end

-- RELEASE_LOGOFF  	luaLog("Current missionphase: "..this.MissionPhase)

	if this.MissionPhase == 1 then
		if this.FirstRun then
			luaObj_Add("primary", 1, this.JapPlayerUnit, true)
			luaObj_Add("primary", 2)
			this.FirstRun = false
			--luaDelay(luaJavaSpawnPlanes, 2.55)
		else
			
			if table.getn(this.AlliedAttackers) == 0 and Mission.AlliedAttackPhase < 6 then
				nextEntity = this.AlliedAttackerTemplates[this.AlliedAttackPhase]
-- RELEASE_LOGOFF  				luaLog("New enemy leader: "..nextEntity.Name)
				tempEntity = luaSpawn(nextEntity.Name, ST_ABSANGLE, Mission.JapPlayerUnit, 4000, 10000, 0, 20, 70)
				UnitFreeAttack(tempEntity)
				TorpedoEnable(tempEntity, true)
				table.insert(this.AlliedAttackers, tempEntity)
				if this.AlliedAttackPhase == 5 then
					luaObj_AddUnit("primary", 2, tempEntity)
					Mission.AlliedTarget = tempEntity
				end

				--[[local entNameTable = {}
					table.insert(entNameTable, this.AlliedTemplateFletcher)
					table.insert(entNameTable, this.AlliedTemplateFletcher)]]

				local newNameTable = {}
					table.insert(newNameTable, this.AlliedFletcherNames[this.AlliedAttackPhase])
					table.insert(newNameTable, this.AlliedFletcherNames[this.AlliedAttackPhase+5])
				
				local ddFinalTable = {}
				
				for i = 1, 2 do
				
					local ship = GenerateObject("Template_Fletcher")
					SetGuiName(ship, newNameTable[i])
					
					table.insert(ddFinalTable, ship)
					
				end
				
				luaJavaFollowersReady(ddFinalTable)
				
				this.AlliedAttackPhase = this.AlliedAttackPhase + 1
			end
			--luaJavaSpawnAttackers()
		end
	end
	
	Mission.NachiStat = string.format("%.0f",(GetHpPercentage(this.JapPlayerUnit) * 100))
	
	if Mission.PlayingCOOP then
	
		MultiScore = {
			[0]= {
				[1] = Mission.NachiStat,
			},
			[1]= {
				[1] = Mission.NachiStat,
			},
			[2]= {
				[1] = Mission.NachiStat,
			},
			[3]= {
				[1] = Mission.NachiStat,
			},
			[4]= {
				[1] = Mission.NachiStat,
			},
			[5]= {
				[1] = Mission.NachiStat,
			},
			[6]= {
				[1] = Mission.NachiStat,
			},
			[7]= {
				[1] = Mission.NachiStat,
			},
		}
		
		DisplayScores(1, 0, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.0.1#%")
		DisplayScores(1, 1, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.1.1#%")
		DisplayScores(1, 2, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.2.1#%")
		DisplayScores(1, 3, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.3.1#%")
		DisplayScores(1, 4, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.4.1#%")
		DisplayScores(1, 5, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.5.1#%")
		DisplayScores(1, 6, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.6.1#%")
		DisplayScores(1, 7, "Eliminate the USS Houston!", "The Nachi must survive! Nachi status:".."| #MultiScore.7.1#%")
	
	else
		
		local line1 = "Eliminate the USS Houston!"
		local line2 = "The Nachi must survive! Nachi status: #Mission.NachiStat#%"
		luaDisplayScore(1, line1, line2)
	
	end
	
end

function luaJavaCheckConditions(this)
	if this.EndMission then
		return
	end

	if this.MissionPhase == 1 and this.FirstRun then
		AddWatch("Mission.AlliedSpawnPhase")
		AddWatch("Mission.Difficulty")
		return
	end

	this.JapPlayerGroup = luaRemoveDeadsFromTable(this.JapPlayerGroup)
	--this.AlliedDefenders = luaRemoveDeadsFromTable(this.AlliedDefenders)
	this.AlliedAttackers = luaRemoveDeadsFromTable(this.AlliedAttackers)
	this.AlliedPlanes = luaRemoveDeadsFromTable(this.AlliedPlanes)

	if this.JapPlayerUnit.Dead then
-- RELEASE_LOGOFF  		luaLog("Key unit lost! Mission Failed!")
		luaClearDialogs()
		luaObj_FailedAll(true)
		this.EndMission = true
		luaMissionFailedNew(Mission.JapPlayerUnit, "Nachi is lost!") --Nachi is lost!
		return
	end

	if this.AlliedTarget.Dead then
-- RELEASE_LOGOFF  		luaLog("Target Destroyed! Mission Success!")
		luaClearDialogs()
		luaObj_CompletedAll(true)
		HideScoreDisplay(1,0)
		this.EndMission = true
		luaMissionCompletedNew(Mission.AlliedTarget, "You have destroyed the USS Houston!") --You have destroyed the USS Houston!
		return
	end

	--[[
	local playerFireTarget = GetFireTarget(this.JapPlayerUnit)
	if playerFireTarget then
		for index, unit in pairs (Mission.JapPlayerGroup) do
			if index ~= 1 then
				SetFireTarget(unit, playerFireTarget)
			end
		end
	end
	]]

	--[[
	for index, bomber in pairs (this.AlliedPlanes) do
		UpdateUnitTable(bomber)
		if luaGetScriptTarget(bomber) == nil then
-- RELEASE_LOGOFF  			luaLog(bomber.Name.." has no script target!")
		else
-- RELEASE_LOGOFF  			luaLog(bomber.Name.."'s target: "..luaGetScriptTarget(bomber).Name)
		end
-- RELEASE_LOGOFF  		luaLog(bomber.Name.."'s ammo: "..tostring(bomber.ammo))
-- RELEASE_LOGOFF  		luaLog(bomber.Name.."'s botcommand: "..tostring(bomber.botcommand))
		if luaGetScriptTarget(bomber) == nil and bomber.ammo ~= 0 then
			luaSetScriptTarget(bomber, luaPickRnd(this.JapPlayerGroup))
-- RELEASE_LOGOFF  			luaLog(bomber.Name.."'s new target: "..luaGetScriptTarget(bomber).Name)
		end
	end
	]]
end

function luaJavaSetFletcherRace(unit)
	for i, template in pairs (Mission.AlliedFletcherNames) do
		if template.Name == unit.Name then
			if template.Race == "UK" then
			elseif template.Race == "NL" then
			end
			SetNumbering(unit, template.Numbering)
			return
		end
	end
end

function luaJavaFollowersReady(entityTable)
	if entityTable then
		for index, unit in pairs (entityTable) do
			local move = 200
			if index == 1 then
			
				move = -200
			
			end
			UnitFreeAttack(unit)
			TorpedoEnable(unit, true)
			table.insert(Mission.AlliedAttackers, unit)
			PutRelTo(unit, Mission.AlliedAttackers[1], {["x"] = move, ["y"] = 0, ["z"] = 0})
			SetFireTarget(unit, Mission.JapPlayerUnit)
		end
	end

	for index, unit in pairs (Mission.AlliedAttackers) do
		NavigatorAttackMove(unit, Mission.JapPlayerUnit, {})
	end

	--[[
	if not Mission.ActionMusic then
		Music_Control_SetLevel(MUSIC_ACTION)
		Mission.ActionMusic = true
	end
	]]
end

function luaJavaSpawnAttackers()
	if not Mission.JapPlayerUnit.Dead then
		if Mission.AlliedAttackerReadyToSend then
			Mission.AlliedAttackers = luaRemoveDeadsFromTable(Mission.AlliedAttackers)
			if table.getn(Mission.AlliedAttackers) < Mission.AlliedAttackerMaxNumber then
				local lastIndex = 1
				local lastCount = 0
				local lastName = ""
				for index, unitTemplate in pairs (Mission.AlliedFletcherNames) do
					if unitTemplate.Count == 0 then
						lastIndex = index
						lastCount = 0
						lastName = unitTemplate.Name
						break
					elseif index == 1 or unitTemplate.Count < lastCount then
						lastIndex = index
						lastCount = unitTemplate.Count
						lastName = unitTemplate.Name
					end
				end
				Mission.AlliedFletcherNames[lastIndex].Count = Mission.AlliedFletcherNames[lastIndex].Count + 1

				tempEntity = luaSpawn(Mission.AlliedTemplateFletcher.Name, ST_ABSANGLE, Mission.JapPlayerUnit, 6000, 40000, 0, 0, 90, lastName)

				UnitFreeAttack(tempEntity)
				NavigatorAttackMove(tempEntity, Mission.JapPlayerUnit, {})
				TorpedoEnable(tempEntity, true)
				table.insert(Mission.AlliedAttackers, tempEntity)
				Mission.AlliedAttackerReadyToSend = false
				luaDelaySet("AlliedAttackerReadyToSend", true, Mission.AlliedAttackerSpawnDelay)
			end
		end
	end
end

--[[
function luaJavaSpawnPlanes()
	if not Mission.JapPlayerUnit.Dead then
		if Mission.AlliedPlaneReadyToSend then
			Mission.AlliedPlanes = luaRemoveDeadsFromTable(Mission.AlliedPlanes)
			local shipsAround = luaGetShipsAround(Mission.JapPlayerUnit, 2000, "enemy")
			if not shipsAround and table.getn(Mission.AlliedPlanes) < Mission.AlliedPlaneMaxNumber then
				local tempEntity = luaSpawn(Mission.AlliedTemplateSwordfish.Name, ST_ABSANGLE, Mission.JapPlayerUnit, 4000, 40000, 50, 0, 359, "Swordfish")
				PilotSetTarget(tempEntity, Mission.JapPlayerUnit)
				table.insert(Mission.AlliedPlanes, tempEntity)
				Mission.AlliedPlaneReadyToSend = false
				luaDelay(luaJavaAttackCommand, 1, "entity", tempEntity)
				luaDelaySet("AlliedPlaneReadyToSend", true, Mission.AlliedPlaneSpawnDelay)
			end
		end
		luaDelay(luaJavaSpawnPlanes, 2.55)
	end
end

function luaJavaAttackCommand(timerEnt)
	--luaLog(timerEnt.ParamTable.entity)
	if not Mission.JapPlayerUnit.Dead and not timerEnt.ParamTable.entity.Dead then
		SquadronSetTravelAlt(timerEnt.ParamTable.entity, 50)
	end
end
]]

function luaJavaFadeIn()
	Blackout(false, "", 1.5)
end

function luaJavaIntro()
	
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.JapPlayerUnit,
               ["pos"] = { 1.32, -10, 0.05 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
           ["zoom"] = 1.75,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.JapPlayerUnit,
               ["pos"] = { 19.27, 30, 238.19, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
					 ["zoom"] = 1.75,
       }
  
  MovCamNew_AddPosition(pos0)

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.JapPlayerUnit,
               ["pos"] = { 3, 30, 188.83, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=11.0,
           ["linearblend"]=1.0,
				   ["finishscript"] = "luaJavaSkipMovie",
			 		 ["zoom"] = 1.75,
       }
  
  MovCamNew_AddPosition(pos0)

	

	SetSkipMovie("luaJavaSkipMovie")

end

function luaJavaSkipMovie()

-- RELEASE_LOGOFF  	luaLog("Skipmovie initiated")
	
	if not Mission.MovieSkip then

		
		Mission.MovieSkip = true
	
		SetSkipMovie()
	
		luaCrossFade(luaJavaSelectNachi)
		
-- RELEASE_LOGOFF  		luaLog("Movie Skipped")
	
	end

end

function luaJavaSelectNachi()

	EnableInput(true)

	SetSelectedUnit(Mission.JapPlayerUnit)

-- RELEASE_LOGOFF  	luaLog("unit selected")
	
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end