--SceneFile="universe\Scenes\missions\Challenge\Periscopes.scn"
--SubC2
DoFile("Scripts/datatables/Inputs.lua")
Inputs = nil

function luaStageInit()
	CreateScript("luaInitPeriscopes")
end

function luaInitPeriscopes(this)
	Mission = this
	this.Name = "Periscopes"
	this.CustomLog = true
	this.HelperLog = true

	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("subc2")
	LoadSelectedPaths()
	
	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "killem",		--added	checked
				["Text"] = "Destroy the whole retreating fleet!", --Destroy the whole retreating fleet.
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- TODO: meeting point coordinates here OK
				["ScoreCompleted"] = 1000*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
				
		["secondary"] =
		{
		},

		["hidden"] =
		{
		}
	}
	-- Scoring = nil	-- itt toroljuk a Scoring tablat

	SetDayTime(5)	-- kora reggel, hajnal
	SetWeather("Clear")
	SETLOG(this, true)

	--luaGenerateRandomClouds(25, {{["x"]=-9000, ["y"]=500, ["z"]=-9000}, {["x"]=9000, ["y"]=700, ["z"]=9000}}, 5, 3, 0)
	
	this.Party = SetParty(this, PARTY_JAPANESE)

-- RELEASE_LOGOFF  	luaLog("Periscopes")	
-- RELEASE_LOGOFF  	luaLog("Starting def mission")
	Mission.HelperLog = true
	Mission.difficulty = GetDifficulty()	

	this.NewYork = FindEntity("New York")
	this.Cruiser = FindEntity("York")
	this.NewYorkShips = {}
		table.insert(this.NewYorkShips, FindEntity("York"))
		table.insert(this.NewYorkShips, FindEntity("Patterson"))
		table.insert(this.NewYorkShips, FindEntity("Barker"))
		table.insert(this.NewYorkShips, FindEntity("Bulmer"))
		
	this.Destroyers = {}
		table.insert(this.Destroyers, FindEntity("Patterson"))
		table.insert(this.Destroyers, FindEntity("Barker"))
		table.insert(this.Destroyers, FindEntity("Bulmer"))
		
	this.allEnemyShip = {
		{ship = FindEntity("New York"), torpBonus = 7},
		{ship = FindEntity("York"), torpBonus = 5},
		{ship = FindEntity("Patterson"), torpBonus = 3},
		{ship = FindEntity("Barker"), torpBonus = 3},
		{ship = FindEntity("Bulmer"), torpBonus = 3},
		
		}
	this.allLivingEnemyShip = {}
		table.insert(this.allLivingEnemyShip, FindEntity("New York"))
		table.insert(this.allLivingEnemyShip, FindEntity("York"))
		table.insert(this.allLivingEnemyShip, FindEntity("Patterson"))
		table.insert(this.allLivingEnemyShip, FindEntity("Barker"))
		table.insert(this.allLivingEnemyShip, FindEntity("Bulmer"))

	this.PlayerSub = FindEntity("I-15")
		
--[[	this.AirStrikeSquad = {}
		table.insert(this.AirStrikeSquad,luaFindHidden("D3A Val"))]]
	
	RepairEnable(FindEntity("I-15"), false)
	
	SetCatapultStock(FindEntity("I-15"), 0)
	
	if Mission.difficulty == DIFF_ROOKIE then
		this.DestroyerTurnbackTime = 20
		this.DestroyerReactionDist = 800
		this.PTSpawnTime = 1200
		this.LastPTSpawnTime = -1200
		
		this.AirstrikeDelay = 120
	elseif Mission.difficulty == DIFF_REGULAR then
		this.DestroyerTurnbackTime = 40
		this.DestroyerReactionDist = 1200
		this.PTSpawnTime = 600
		this.LastPTSpawnTime = -600
		
		this.AirstrikeDelay = 180
	elseif Mission.difficulty == DIFF_VETERAN then
		this.DestroyerTurnbackTime = 60
		this.DestroyerReactionDist = 1600
		this.PTSpawnTime = 240
		this.LastPTSpawnTime = -240
		
		this.AirstrikeDelay = 240
	end
	

	this.PTSpawnBool = true
	--this.EnemyPT = {}	
	--this.EnemyPTHidden = {}
		--table.insert(this.EnemyPTHidden, luaFindHidden("PT Boat"))
		--table.insert(this.EnemyPTHidden, luaFindHidden("PT Boat"))
	
	this.DCSpawnTime = 360
	this.LastDCSpawnTime = 0
	this.EnemyDC = {}	
	this.EnemyDCHidden = {}
		table.insert(this.EnemyDCHidden, luaFindHidden("OS2U Kingfisher"))
	
	this.MissionPhase = 0
	this.AmmoOutTime = 0

	this.Evacpoint = {["x"]=5000,["y"]=0,["z"]=7000,}
	
	--SALA
	this.DestroyerAttackOut = nil
	--SetInvincible(this.PlayerSub,true)
	
	--SALA
	
	AddWatch("Mission.Game_Time")
	AddWatch("Mission.MissionPhase")
	AddWatch("Mission.Detected")

	--AddWatch("Mission.TorpOut")
	
	--PrepareClass(121) --OS2U Kingfisher
	--PrepareClass(27) --PT Boat

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	Blackout(true, "", true)
	
	SetThink(this, "luaPeriscopes_think")
end

function luaPeriscopes_think(this, msg)

	if not Mission.EndMission then

		if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  			luaLog("Def mission killed")
			return
		end
	
		if not this.FirstThink then
			this.FirstThink = true
		--	MovCam_TompiModeWeak(Mission.NewYork, {["x"]=-200, ["y"]=50, ["z"]=0}, Mission.NewYork, {["x"]=0, ["y"]=50, ["z"]=0}, true)
		--	MovCam_TompiModeWeak(Mission.NewYork, {["x"]=-1000, ["y"]=400, ["z"]=0}, Mission.NewYork, {["x"]=0, ["y"]=50, ["z"]=0}, false, 8)

			Blackout(true, "", true)
			luaDelay(luaPeriscopesBlackoutEnd, 0.5)

			local introPath = FillPathPoints(FindEntity("intro_path"))
	
			local movCamPos
			movCamPos = {
				["postype"] = "target",
				["position"] = {
					["pos"] = luaConvertXYZTo123(introPath[2]),
				},
				["starttime"] = 0,
				["blendtime"] = 0,
			}
			MovCamNew_AddPosition(movCamPos)
			movCamPos = {
				["postype"] = "camera",
				["position"] = {
					["pos"] = luaConvertXYZTo123(introPath[1]),
				},
				["starttime"] = 0,
				["blendtime"] = 0,
			}
			MovCamNew_AddPosition(movCamPos)
			movCamPos = {
				["postype"] = "camera",
				["position"] = {
					["pos"] = luaConvertXYZTo123(introPath[2]),
				},
				["starttime"] = 0.5,
				["blendtime"] = 5,
				["finishscript"] = "luaPeriscopesIntro",
			}
			MovCamNew_AddPosition(movCamPos)
			movCamPos = {
				["postype"] = "target",
				["position"] = {
					["pos"] = luaConvertXYZTo123(GetPosition(Mission.NewYork)),
				},
				["starttime"] = 0.5,
				["blendtime"] = 5,
			}
			MovCamNew_AddPosition(movCamPos)

			--MovCam_PathWalk(FindEntity("intro_path"),1 ,2 ,0.5, true, nil, "luaPeriscopesIntro")
			--Blackout( false, "luaPeriscopesIntro")
			--luaPeriscopesIntro()

			if Mission.difficulty == DIFF_ROOKIE then
				ShipSetTorpedoStock(this.PlayerSub,44)
				SetCrewLevel(this.NewYork, DIFF_ROOKIE)
			elseif Mission.difficulty == DIFF_REGULAR then
				ShipSetTorpedoStock(this.PlayerSub,40)
				SetCrewLevel(this.NewYork, CREW_VETERAN)
			elseif Mission.difficulty == DIFF_VETERAN then
				ShipSetTorpedoStock(this.PlayerSub,28)
				SetCrewLevel(this.NewYork, CREW_VETERAN)
			end
	
			--SetForcedReconLevel(this.NewYork, 4, Mission.Party)
			for idx,unit in pairs(this.NewYorkShips) do
				--SetForcedReconLevel(unit, 4, Mission.Party)
				JoinFormation(unit, this.NewYork)
				if Mission.difficulty == DIFF_ROOKIE then
					SetCrewLevel(unit, CREW_ROOKIE)
				elseif Mission.difficulty == DIFF_REGULAR then
					SetCrewLevel(unit, CREW_REGULAR)
				elseif Mission.difficulty == DIFF_VETERAN then
					SetCrewLevel(unit, CREW_VETERAN)
				end
			end
			for idx,unit in pairs(this.Destroyers) do
				if Mission.difficulty == DIFF_ROOKIE then
					SetShipMaxSpeed(unit, unit.Class.MaxSpeed*0.5)
				elseif Mission.difficulty == DIFF_REGULAR then
					SetShipMaxSpeed(unit, unit.Class.MaxSpeed*0.6)
				elseif Mission.difficulty == DIFF_VETERAN then
					SetShipMaxSpeed(unit, unit.Class.MaxSpeed*0.7)
				end
			end
			NavigatorMoveToRange(this.NewYork, this.Evacpoint)
				
			SetShipSpeed(this.NewYork,5)
		end
	end
	
	if next(recon[PARTY_ALLIED].enemy.submarine) ~= nil then
		Mission.Detected = true
	--[[	if not Mission.ShowHint then
			Mission.ShowHint = true
			luaDisruptionAirstrikeHint()
		end]]
	else
		Mission.Detected = false
		--Mission.ShowHint = false
		--if IsListenerActive("input", "AirStrike") then
		--	RemoveListener("input", "AirStrike")
		--	HideHint("Black_Icon")
		--end
	end
	
	this.Game_Time = math.floor(GameTime())
	
	if not Mission.FailedInit and this.MissionPhase == 1 then
		luaPeriscopesCheckGameOver(this)
		--luaPeriscopesCheckPTs(this)
		luaPeriscopesCheckDCs(this)
		luaPeriscopesCheckDestroyers(this)
		luaPeriscopesCheckEnemyCondition(this)
		if not this.Cruiser.Dead then
			luaPeriscopesCheckCruiser(this.Cruiser)
		end
	end
end

function luaPeriscopesBlackoutEnd()
	Blackout(false, "", 1.5)
end

--[[function luaPeriscopesIntro()
-- RELEASE_LOGOFF  	luaLog("luaPeriscopesIntro")
	--luaDelay(luaPeriscopesIntroEnd, 10)
	
	luaPeriscopesIntroEnd()
end]]
function luaPeriscopesIntro()
-- RELEASE_LOGOFF  	luaLog("luaPeriscopesIntroEnd")
	Blackout( true, "luaPeriscopesIntroEndFade")
end

function luaPeriscopesIntroEndFade()
	luaObj_Add("primary",1, Mission.allLivingEnemyShip)
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.allLivingEnemyShip), "Destroy the whole retreating fleet!")
-- RELEASE_LOGOFF  	luaLog("luaPeriscopesIntroEndFade")
	SetSelectedUnit(Mission.PlayerSub)
	--luaDelay(luaPeriscopesStopSub, 5)
	Blackout( false, "luaPeriscopesIntroEndFade2")
end

function luaPeriscopesIntroEndFade2()
-- RELEASE_LOGOFF  	luaLog("luaPeriscopesIntroEndFade2")
	Mission.MissionPhase = 1
end

function luaPeriscopesStopSub()
	NavigatorStop(Mission.PlayerSub)
end

function luaPeriscopesCheckEnemyCondition(this)
	for idx,unit in pairs(this.allEnemyShip) do
		if unit.ship.Dead and not unit.ship.Sunk then
			unit.ship.Sunk = true
			if table.getn(luaRemoveDeadsFromTable(this.allLivingEnemyShip)) > 0 then
				MissionNarrativeEnqueue("Well done. An enemy has been sunk.") --Well done. An enemy has been sunk.
				--luaPeriscopesAddTorpedoes(this.PlayerSub, unit.torpBonus)
				--luaPeriscopesRepairSingleUnit(this.PlayerSub)
			end
		end
	end
end

function luaPeriscopesCheckCruiser(unit)
	if Mission.NewYork.Dead and not unit.Dead and not Mission.PlayerSub.Dead then
		NavigatorAttackMove(unit,Mission.PlayerSub,{})
	end
end

function luaPeriscopesCheckDestroyers(this)
--SALA
	local tempDest = luaRemoveDeadsFromTable(this.Destroyers)
	if table.getn(tempDest) > 0 and not Mission.PlayerSub.Dead  then
		if Mission.Detected then
			if not this.NewYork.Dead then
				if Mission.DestroyerAttackOut~=nil and Mission.DestroyerAttackOut.Dead then
					Mission.DestroyerAttackOut=nil
				end
				
				if not Mission.DestroyerAttackOut~=nil then -- ha range-en belül van és nem támadott még ki rá más akkor
					-- kiválasztom a legközelebbi destroyer-t
					local mindist=40000
					for idx,unit in pairs(tempDest) do
						if luaGetDistance(Mission.PlayerSub, unit)<mindist then
							mindist=luaGetDistance(Mission.PlayerSub, unit)
-- RELEASE_LOGOFF  							luaLog(mindist)
							Mission.DestroyerAttackOut=unit
-- RELEASE_LOGOFF  							luaLog("Mission.DestroyerAttackOut.Name:"..Mission.DestroyerAttackOut.Name)
						end
					end
					-- a kiválasztott Destroyer-t ráküldöm a SubMarine-ra
					if Mission.DestroyerAttackOut~=nil and not Mission.DestroyerAttackOut.Dead then
-- RELEASE_LOGOFF  						luaLog("5**********************Kitámadt : "..Mission.DestroyerAttackOut.Name)
						LeaveFormation(Mission.DestroyerAttackOut)
						NavigatorAttackMove(Mission.DestroyerAttackOut,Mission.PlayerSub,{})
						SetFireTarget(Mission.DestroyerAttackOut,Mission.PlayerSub)
						UnitFreeFire(Mission.DestroyerAttackOut)
						if not Mission.MusicAction then
							Mission.MusicAction = true
							Music_Control_SetLevel(MUSIC_ACTION)
						end
					end
				end		
			else
			-- ha NewYor kipurgált, akkor mindenki, aki van rá a célra	
				for idx,unit in pairs(tempDest) do
-- RELEASE_LOGOFF  					luaLog("3******************Mindenki támad!!!!!!")
					LeaveFormation(unit)
					NavigatorAttackMove(unit,Mission.PlayerSub,{})
					SetFireTarget(unit,Mission.PlayerSub)
					UnitFreeFire(unit)
					if not Mission.MusicAction then
						Mission.MusicAction = true
						Music_Control_SetLevel(MUSIC_ACTION)
					end
				end
			end
		else	
			if Mission.DestroyerAttackOut~=nil and  not Mission.DestroyerAttackOut.Dead then
				if not this.NewYork.Dead then
-- RELEASE_LOGOFF  					luaLog("1**********************Vissza : "..Mission.DestroyerAttackOut.Name)
					JoinFormation(Mission.DestroyerAttackOut, this.NewYork)
					--Music_Control_SetLevel(MUSIC_TENSION)
					Mission.DestroyerAttackOut=nil
				else
-- RELEASE_LOGOFF  					luaLog("2******************Mission.DestroyerAttackOut Evakuál!!!!!!")
					NavigatorMoveToRange(Mission.DestroyerAttackOut, this.Evacpoint)					
				end
			end	
		end
	end

--SALA
end

--[[
function luaPeriscopesAddTorpedoes(unit, torpNum)
	MissionNarrativeEnqueue("You got extra torpedoes.")
	UpdateUnitTable(unit)
-- RELEASE_LOGOFF  	luaLog("Extra torp! "..unit.TorpedoStock.." +"..torpNum)
	ShipSetTorpedoStock(unit,unit.TorpedoStock + torpNum)
end
]]

--[[
function luaPeriscopesRepairSingleUnit(unit)
	MissionNarrativeEnqueue("Your ship is repaired.")
	CheatMaxRepair(unit)
end
]]

function luaPeriscopesCheckPTs(this)

	for idx,unit in pairs(this.EnemyPT	) do
		if unit.Dead then
-- RELEASE_LOGOFF  			luaLog("DEAD PT!"..unit.Name)
		end
	end
	
	--PT Spawn check
	this.EnemyPT = luaRemoveDeadsFromTable(this.EnemyPT)
	if this.Detected and not this.NewYork.Dead then
	--	if (this.LastPTSpawnTime + this.PTSpawnTime) < math.floor(GameTime()) then
			--if table.getn(this.EnemyPT) < 2 then
			if table.getn(this.EnemyPT) == 0 then
-- RELEASE_LOGOFF  				luaLog("NumofPT:"..table.getn(this.EnemyPT).."  PT spawn begins...")
				--UpdateUnitTable(this.NewYork)
				--luaSpawnDelayed(this.EnemyPTHidden, ST_ABSANGLE, GetPosition(this.NewYork), 100, 200, 0,  10, 20,  luaPeriscopesPTSpawned)
				--luaSpawnDelayed(this.EnemyPTHidden, ST_ABSANGLE, GetPosition(this.NewYork), 400, 500, 0, 110, 145, luaPeriscopesPTSpawned)
				--luaSpawnDelayed(this.EnemyPTHidden, ST_ABSANGLE, this.NewYork, 400, 500, 0, 110, 145, luaPeriscopesPTSpawned)
			end
	--	end
	end
	
	--Pt AI check
	local livingPTs = luaRemoveDeadsFromTable(this.EnemyPT)
	for idx,unit in pairs(livingPTs) do
		if not unit.Dead then
			if this.Detected then
-- RELEASE_LOGOFF  				luaLog("PT atackmove...")
				NavigatorAttackMove(unit, Mission.PlayerSub, {})
				SetFireTarget(unit,Mission.PlayerSub)
				UnitFreeFire(unit)
				if not Mission.MusicAction then
					Mission.MusicAction = true
					Music_Control_SetLevel(MUSIC_ACTION)
				end
			else
				local livingEnemy = luaRemoveDeadsFromTable(this.allLivingEnemyShip) 
				if not this.NewYork.Dead then
-- RELEASE_LOGOFF  					luaLog("PT retreat to NY...")
					NavigatorMoveToRange(unit,Mission.NewYork)
				elseif table.getn(livingEnemy) > 0 then
-- RELEASE_LOGOFF  					luaLog("PT moveto fiendship...")
					NavigatorMoveToRange(unit,livingEnemy[1])
				end
				UnitHoldFire(unit)		
			end
		end
	end	
end

function luaPeriscopesPTSpawned(unit)
	if not Mission.NewYork.Dead then
		if Mission.PTSpawnBool then
			Mission.PTSpawnBool = false
			PutRelTo(unit, Mission.NewYork, {["x"]=20,["y"]=0,["z"]=-100,})
		else
			Mission.PTSpawnBool = true
			PutRelTo(unit, Mission.NewYork, {["x"]=-20,["y"]=0,["z"]=-100,})
		end
	end
	
	if Mission.difficulty == DIFF_ROOKIE then
		SetCrewLevel(unit, CREW_ROOKIE)
	elseif Mission.difficulty == DIFF_REGULAR then
		SetCrewLevel(unit, CREW_REGULAR)
	elseif Mission.difficulty == DIFF_VETERAN then
		SetCrewLevel(unit, CREW_VETERAN)
	end
	
	pos = GetPosition(unit)
-- RELEASE_LOGOFF  	luaLog("...PT spawned. x:"..pos.x.." y:"..pos.y.." z:"..pos.z)
	table.insert(Mission.EnemyPT, unit)
	Mission.LastPTSpawnTime = math.floor(GameTime())
	--NavigatorAttackMove(unit, Mission.PlayerSub, {})
	--luaSetScriptTarget(unit,Mission.PlayerSub)
	--UnitFreeFire(unit)
	UnitFreeAttack(unit)
end

function luaPeriscopesCheckDCs(this)
	--[[
	this.EnemyDC = luaRemoveDeadsFromTable(this.EnemyDC)
	local enemyforce = luaRemoveDeadsFromTable(this.allLivingEnemyShip)

	if (this.LastDCSpawnTime + this.DCSpawnTime) < math.floor(GameTime()) and table.getn(enemyforce) < 4 then
		if table.getn(this.EnemyDC) < 2 then
			luaSpawnDelayed(this.EnemyDCHidden, ST_ABSANGLE, GetPosition(Mission.PlayerSub), 4000, 5000, 0,  10, 20,  luaPeriscopesDCSpawned)
		end
	end
	
	if table.getn(this.EnemyDC) > 0 then
		for idx,unit in pairs(this.EnemyDC) do
			if unit.Ammo == 0 then
				PilotRetreat(entity)
			else
				PilotSetTarget(unit, Mission.PlayerSub)
			end
		end
	end
	]]
end

function luaPeriscopesDCSpawned(unit)
	table.insert(Mission.EnemyDC, unit)
	Mission.LastDCSpawnTime = math.floor(GameTime())
	PilotSetTarget(unit, Mission.PlayerSub)
	--NavigatorAttackMove(unit, Mission.PlayerSub, {})
end
------------------------------------------------------------------------------------

function luaPeriscopesCheckGameOver(this)
	if Mission.FailedInit or Mission.SuccesInit then
		return
	end

	if Mission.PlayerSub.Dead then
		luaPeriscopesMissionFailed(this)
		return
	end
	--luaLog("living num:"..table.getn(this.allLivingEnemyShip))

	if table.getn(this.allLivingEnemyShip) > 0 then
		if table.getn(luaRemoveDeadsFromTable(this.allLivingEnemyShip)) == 0 then
			local lastship = this.allLivingEnemyShip[1]
-- RELEASE_LOGOFF  			luaLog("The last ship is:"..lastship.Name)
			luaPeriscopesMissionSucces(lastship)
			return
		end
		--luaLog("luaRemoveDeadsFromTable")
		this.allLivingEnemyShip = luaRemoveDeadsFromTable(this.allLivingEnemyShip)
		--luaLog("living num2:"..table.getn(this.allLivingEnemyShip))
	end

	--UpdateUnitTable(this.PlayerSub)
	local torpout = false
	if this.PlayerSub.TorpedoStock == 0 then
		torpout = true
	end
	
	if torpout and this.AmmoOutTime == 0 then
		this.AmmoOutTime = math.floor(GameTime())
		--MissionNarrative("subc2.nar_ammo") --You are out of torpedoes. You have (%) seconds to destroy a ship.
	elseif not torpout then
		this.AmmoOutTime = 0
	end
	if torpout and this.AmmoOutTime > 0 and this.AmmoOutTime + 60 < math.floor(GameTime()) then
		MissionNarrativeClear()
		luaPeriscopesMissionFailed(this)
	--elseif torpout and this.AmmoOutTime > 0 then
		--MissionNarrativeClear()
		--Mission.AmmoTime = tostring((Mission.AmmoOutTime + 90) - math.floor(GameTime()))
		--Mission.NarrativeParam = Mission.AmmoTime
		--MissionNarrative("subc2.nar_ammo") --You are out of torpedoes. You have (%) seconds to destroy a ship.
	end
	
--[[
	local enemy = luaRemoveDeadsFromTable(this.NewYorkShips)
	if table.getn(enemy) == 0 and this.NewYork.Dead then
		luaPeriscopesMissionSucces(this)
	end]]
end

function luaPeriscopesMissionFailed(this)
	if not Mission.FailedInit then
		Mission.FailedInit = true
		CountdownCancel()
		--MissionNarrative("Mission Failed!")
		--luaObj_Failed("primary",1)
		--luaDelay(EndScene, 5)
		if this.PlayerSub.Dead then
			luaMissionFailedNew(this.PlayerSub, "You have been defeated.") --You have been defeated.
		else
			luaMissionFailedNew(this.PlayerSub, "You have wasted your torpedos.") --You have wasted your torpedos.
		end
	end
end

function luaPeriscopesMissionSucces(lastUnit)
	if not Mission.SuccesInit then
		Mission.SuccesInit = true
		CountdownCancel()
-- RELEASE_LOGOFF  		luaLog("<---- Mission was a success ---->")
		HideUnitHP()
		luaObj_Completed("primary",1)
		luaMissionCompletedNew(lastUnit, "You have succesfully eliminated the convoy!") --You have succesfully eliminated the convoy!
		--luaDelay(EndScene, 5)
	end
end


--[[
function luaDisruptionAirstrikeHint()

	MissionNarrative("Press the 'Black' button to call the air strike.")
	AddListener("input", "AirStrike", {
		["callback"] = "luaAirStikeStart",
		["inputID"] = {IC_WARNING_SHORTCUT},
	})

	Mission.ReadyToSend = true
end
]]

--[[
function luaAirStikeStart()
-- RELEASE_LOGOFF  	luaLog("luaDisruptionAirstrike Called!")

	if Mission.ReadyToSend then
		Mission.ReadyToSend = false
		
		MissionNarrativeOverride("Launching the air strike!")
-- RELEASE_LOGOFF  		luaLog("Launching the air strike!")
		luaSpawnDelayed(Mission.AirStrikeSquad, ST_ABSANGLE, GetPosition(Mission.PlayerSub), 1000, 2000, 500,  10, 20,  luaD3ASpawned)
		
		
		RemoveListener("input", "AirStrike")
		--HideHint("Black_Icon")
		MissionNarrativeClear()
		
		
		Countdown("Air strike countdown", 1, Mission.AirstrikeDelay, "luaDistruptionReadyToSend")
		
	end
	
end
]]

function luaD3ASpawned(unit)
	if Mission.difficulty == DIFF_ROOKIE then
		SetCrewLevel(unit, CREW_VETERAN)
	elseif Mission.difficulty == DIFF_REGULAR then
		SetCrewLevel(unit, CREW_REGULAR)
	elseif Mission.difficulty == DIFF_VETERAN then
		SetCrewLevel(unit, DIFF_ROOKIE)
	end
	local enemies=luaRemoveDeadsFromTable(Mission.allLivingEnemyShip)
-- RELEASE_LOGOFF  	luaLog(Mission.allLivingEnemyShip)
	if table.getn(enemies)>0 then
		local dest = luaPickRnd(enemies)
-- RELEASE_LOGOFF  		luaLog("dest.Name"..dest.Name)
		--NavigatorAttackMove(unit, dest, {})
		--SetFireTarget(unit,dest)
		luaSetScriptTarget(unit,dest)
		UnitFreeFire(unit)
	end
end

function luaDistruptionReadyToSend()
	Mission.ShowHint = false
end
