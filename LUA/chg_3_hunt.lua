--SceneFile="universe\Scenes\missions\Challenge\hunt.scn"
DoFile("Scripts/datatables/Inputs.lua")
Inputs = nil

function luaPrecacheUnits()
	
	PrepareClass(73)
	PrepareClass(75)
	PrepareClass(70)
	PrepareClass(68)
	
end

function luaStageInit()
	CreateScript("luaInitSC1")
end

function luaInitSC1(this)
	Mission = this

	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("sc3")
	LoadSelectedPaths()

	SETLOG(this, true)

	this.Name = "ShipChallenge1"
	this.CustomLog = true
-- RELEASE_LOGOFF  	luaLog("ShipChallange 1 STARTED")

	this.DamageLog = false
	this.HelperLog = false

	this.FreeToGo = false
	--this.DiffMultiplier = luaGetDifficultyScoreMultiplier()
	--this.Difflvl = GetDifficulty()
	--this.Music = MUSIC_TENSION
	
	--[[for i=1,2 do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = GetPosition(FindEntity(tostring("gull_"..i))),
			["tempID"] = "siraly"..tostring(i),
		})
	end]]
	
	DoFile("scripts/datatables/Scoring.lua")
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "nachi",
				["Text"] = "Find and destroy the Nachi!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 2000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "recon",
				["Text"] = "RV with the reconaissance plane!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "cap",
				["Text"] = "All of your destroyers must survive!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "all",
				["Text"] = "Destroy all enemy ships!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 3000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "cruisers",
				["Text"] = "Destroy all enemy cruisers!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "destroyers",
				["Text"] = "Destroy all enemy destroyers!",
				["Active"] = false,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
	}
	
	--mission specific
	this.MissionPhase = 0
	this.Party = SetParty(this, PARTY_ALLIED)
	this.Cheat_PhaseShift = false

	--if this.Difflvl == DIFF_ROOKIE then
	--	this.SpawnDelay = 180
	--else
	this.SpawnDelay = 120
	--end

	--this.CAListenerHintOffset = 60 --ennyi secenkent iratjuk ki a hintet
	--this.CAListenerHintShowed = 0 --ekkor irattuk utoljara
	--this.CAHintFirstShowed = true
	--this.STAListenerHintOffset = 60
	--this.STAListenerHintShowed = 0
	--this.STAHintFirstShowed = true

	--this.WarningStop = false
	--this.WarningStop2 = false

	--alliedunits
	--this.PlayerUnit = FindEntity("Heywood")
	--this.EscortUnit = FindEntity("Edwards")

	this.PlayerUnits = {}
		table.insert(this.PlayerUnits, FindEntity("Heywood"))
		table.insert(this.PlayerUnits, FindEntity("Edwards"))
		table.insert(this.PlayerUnits, FindEntity("Long"))
		
	JoinFormation(this.PlayerUnits[2],this.PlayerUnits[1])
	JoinFormation(this.PlayerUnits[3],this.PlayerUnits[1])

	this.Catalina = FindEntity("PBY Catalina")
		AddUntouchableUnit(this.Catalina)
		SetInvincible(this.Catalina, 1)
		SetRoleAvailable(this.Catalina, EROLF_ALL, PLAYER_AI)
	this.BombersTmpl = {luaFindHidden("B-25 Mitchell")}

	--luaFadeAway("luaSC1BeginMission")
	if LobbySettings and LobbySettings.GameMode == "globals.gamemode_islandcapture" then
	
		luaCheckSkirmish()
		
		if Mission.Skirmish then
			
			Mission.EndMission = true
			
			luaMissionFailedNew(nil, "A Co-Op map only!")
		
		else
		
			Mission.PlayingCOOP = true
			
		end
	
	else
	
		Blackout(true, "", true)
	
	end

	--japanese units
	this.StrikeForce1 = {}
	this.StrikeForce1Tmpl = {}
		table.insert(this.StrikeForce1Tmpl, luaFindHidden("Hayate"))	 --DD
		table.insert(this.StrikeForce1Tmpl, luaFindHidden("Kisaragi")) --DD
	this.StrikeForce2 = {}
	this.StrikeForce2Tmpl = {}
		table.insert(this.StrikeForce2Tmpl, luaFindHidden("Kako"))	 --CL
		table.insert(this.StrikeForce2Tmpl, luaFindHidden("Sagiri"))	--DD
	this.StrikeForce3 = {}
	this.StrikeForce3Tmpl = {}
		table.insert(this.StrikeForce3Tmpl, luaFindHidden("Oi"))	--CL
	this.StrikeForce4 = {}
	this.StrikeForce4Tmpl = {}
		table.insert(this.StrikeForce4Tmpl, luaFindHidden("Nachi"))	--CL
		table.insert(this.StrikeForce4Tmpl, luaFindHidden("Hayashio"))	--DD

	this.DDs = {}
	this.CLs = {}

	this.LastShip = {}
	
	-- Scoring = nil

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	AddWatch("Mission.StrikeForce1Spawned")
	AddWatch("Mission.StrikeForce2Spawned")
	AddWatch("Mission.StrikeForce3Spawned")
	AddWatch("Mission.StrikeForce4Spawned")
	--AddWatch("Mission.StrikeForce1Spawntime")
	--AddWatch("Mission.StrikeForce2Spawntime")
	--AddWatch("Mission.StrikeForce3Spawntime")
	--AddWatch("Mission.StrikeForce4Spawntime")
	AddWatch("Mission.CAListener")
	AddWatch("Mission.STAListener")
	AddWatch("Mission.SListener")
	AddWatch("Mission.FreeToGo")

	--SetInvincible(FindEntity("Heywood"), 0.5)
	SetInvincible(FindEntity("PBY Catalina"), 0.3)

	SetThink(this, "luaSC1_think")
end

function luaSC1_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	
	if this.MissionStatus ~= nil then
		return
	end

	luaCheckMusic()

	for idx,unit in pairs(this.PlayerUnits) do
		if unit.Dead then
			this.LastDead = unit
			table.remove(this.PlayerUnits, idx)
		end
	end
	
	luaSC1CheckMovie()
	luaSC1CheckMovieEnd()

	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) then
		if next(luaRemoveDeadsFromTable(this.DDs)) == nil and this.StrikeForce4Spawned and this.Hidden3Completed == nil then
			luaObj_Add("hidden",3)
			luaObj_Completed("hidden",3)
			this.Hidden3Completed = true
		end
		if next(luaRemoveDeadsFromTable(this.CLs)) == nil and this.StrikeForce4Spawned and this.Hidden2Completed == nil then
			luaObj_Add("hidden",2)
			luaObj_Completed("hidden",2)
			this.Hidden2Completed = true
		end
		if next(luaRemoveDeadsFromTable(this.StrikeForce1)) == nil and next(luaRemoveDeadsFromTable(this.StrikeForce2)) == nil and next(luaRemoveDeadsFromTable(this.StrikeForce3)) == nil and next(luaRemoveDeadsFromTable(this.StrikeForce4)) == nil and this.StrikeForce4Spawned and this.Hidden1Completed == nil then
			luaObj_Add("hidden",1)
			luaObj_Completed("hidden",1)
			this.Hidden1Completed = true
		end
		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if table.getn(luaRemoveDeadsFromTable(this.PlayerUnits)) == 3 then
				luaObj_Completed("secondary",1)
			end
		end
		luaSC1AddAndFailHiddens()
		if not Mission.PlayingCOOP then
		
		HideUnitHP()
		
		end
		
		luaMissionCompletedNew(this.Nachi, "The Nachi has been eliminated!")
		return
	end

	if table.getn(this.PlayerUnits) == 0 then
		--if this.SListener then
		--	RemoveListener("input", "Surrender")
		--	HideHint("All")
		--	this.SListener = false
		--end
		luaSC1AddAndFailHiddens()
		luaMissionFailedNew(this.LastDead, "Your units have been destroyed!")
		return
	else
		if not this.StrikeForce4Spawned then
			--[[local lowTorp = 0
			for idx,unit in pairs(this.PlayerUnits) do
				--UpdateUnitTable(unit)
				if unit.TorpedoStock >= 4 then
					break
				else
					lowTorp = lowTorp + 1
				end
			end]]
			--[[if lowTorp == table.getn(this.PlayerUnits) then
				local selUnit = GetSelectedUnit()
				if selUnit == nil or selUnit.Dead then
					selUnit = this.PlayerUnits[1]
				end
				luaSC1AddAndFailHiddens()
				luaMissionFailedNew(selUnit, "sc3.nar_failed")
			end]]
		else
			--luaLog("Checking torpstock, Nachi is in")
			local lowTorp = 0
			for idx,unit in pairs(this.PlayerUnits) do
				--UpdateUnitTable(unit)
				if unit.TorpedoStock == 0 then
					lowTorp = lowTorp + 1
				end
			end

			--[[if lowTorp == table.getn(this.PlayerUnits) then
				if not this.TorpTimerStarted then
					this.TorpTimer = math.floor(GameTime())
					this.TorpTimerStarted = true
-- RELEASE_LOGOFF  					luaLog("starting torp timer")
					--listener
					--ShowHint("Black_Icon", "Press the 'Black' button to surrender.", 0)
					--AddListener("input", "Surrender", {
					--	["callback"] = "luaSC1FinishOff",
					--	["inputID"] = {IC_WARNING_SHORTCUT},
					--})
					--this.SListener = true
				else
					--ha mar nem elnek a torpedok
					--[[if math.floor(GameTime()) - this.TorpTimer > 150 then
-- RELEASE_LOGOFF  						luaLog("timer ok")
						local selUnit = GetSelectedUnit()
						if selUnit == nil or selUnit.Dead then
							selUnit = this.PlayerUnits[1]
						end
						luaSC1AddAndFailHiddens()
						luaMissionFailedNew(selUnit, "sc3.nar_failed")
						return
					end]]
				end
			end]]
		end
	end

	--luaSC1CheckMusic()

	if this.MissionPhase == 0 then
		
		if Mission.PlayingCOOP then
		
			Mission.FreeToGo = true
			Mission.MovieSkip = true
			
		else
		
			luaDelay(luaSC1BeginMission, 2)
	
		end
	
		--felok ido ilyesmi
		--enviroment
		SetWeather("clear")
		SetDayTime(17,12)
		local cBox = {
			[1] = {["x"] = -9000, ["y"] = 400, ["z"] = -9000},
			[2] = {["x"] = 9000, ["y"] = 600, ["z"] = 9000},
		}
		--luaGenerateRandomClouds(35,cBox,2,1,0)
		--SetRoleAvailable(this.EscortUnit,EROLF_ALL,PLAYER_AI)

		--listener CA
		--if not this.CAListener then
		--	luaSC1AddCallAirstrikeListener()
		--end

		this.MissionPhase = 1

	elseif this.MissionPhase == 1 then

		if not this.FreeToGo then
			return
		end

			
		--objs
		luaSC1CheckObjectives(this)
		--Catalina
		--[[if this.FoundRecon then
			luaSC1CheckReconplane(this)
		end]]

		--SF1
		if this.StrikeForce1Spawned == nil then
			luaSC1SpawnStrikeForces(1)
		end

		--SF2
		if this.StrikeForce2Spawned == nil and this.StrikeForce1Spawned then
			if math.floor(GameTime()) - this.StrikeForce1Spawntime > this.SpawnDelay then
				luaSC1SpawnStrikeForces(2)
			else
-- RELEASE_LOGOFF  			--	luaLog("luaSC1Think: waiting for spawning the 2. strike force.")
			end
		end

		--SF3
		if this.StrikeForce3Spawned == nil and this.StrikeForce2Spawned then
			if math.floor(GameTime()) - this.StrikeForce2Spawntime > this.SpawnDelay then
				luaSC1SpawnStrikeForces(3)
			else
				--luaLog("luaSC1Think: waiting for spawning the 3. strike force.")
			end
		end

		--SF4
		if this.StrikeForce4Spawned == nil and this.StrikeForce3Spawned and this.FoundRecon then --csak akkor jon ha megcsinaltuk a p2-t
			if math.floor(GameTime()) - this.StrikeForce3Spawntime > this.SpawnDelay then
				luaSC1SpawnStrikeForces(4)
			else
				--luaLog("luaSC1Think: waiting for spawning the 4. strike force.")
			end
		end

		luaSC1CheckStrikeForces(this)

	end --missionphases
end --think

function luaSC1SpawnStrikeForces(num)
-- RELEASE_LOGOFF  luaLog("luaSC1SpawnStrikeForces spawned with param "..tostring(num))
PerfTimingStart("_blue")
	local selUnit = GetSelectedUnit()
	if selUnit == nil or selUnit.Dead then
		return
	end
	if num == 1 then
		if not Mission.StrikeForce1Spawned then
			Mission.StrikeForce1Spawned = true
			luaGoFuckYourself(Mission.StrikeForce1Tmpl, selUnit, 4000, 4500, 0, -185, -107)
			Mission.StrikeForce1Spawntime = math.floor(GameTime())
-- RELEASE_LOGOFF  			luaLog("Spawning SF1 at "..tostring(Mission.StrikeForce1Spawned))
		end
	elseif num == 2 then
		if not Mission.StrikeForce2Spawned then
			Mission.StrikeForce2Spawned = true
			luaGoFuckYourself(Mission.StrikeForce2Tmpl, selUnit, 4000, 4500, 0, -185, -107)
			Mission.StrikeForce2Spawntime = math.floor(GameTime())
-- RELEASE_LOGOFF  			luaLog("Spawning SF2 at "..tostring(Mission.StrikeForce2Spawned))
		end
	elseif num == 3 then
		if not Mission.StrikeForce3Spawned then
			Mission.StrikeForce3Spawned = true
			luaGoFuckYourself(Mission.StrikeForce3Tmpl, selUnit, 4000, 4500, 0, -185, -107)
			Mission.StrikeForce3Spawntime = math.floor(GameTime())
-- RELEASE_LOGOFF  			luaLog("Spawning SF3 at "..tostring(Mission.StrikeForce3Spawned))
		end
	elseif num == 4 then
		if not Mission.StrikeForce4Spawned then
			Mission.StrikeForce4Spawned = true
			luaGoFuckYourself(Mission.StrikeForce4Tmpl, selUnit, 4000, 4500, 0, -185, -107)
			Mission.StrikeForce4Spawntime = math.floor(GameTime())
-- RELEASE_LOGOFF  			luaLog("Spawning SF4 at "..tostring(Mission.StrikeForce4Spawned))
		end
	end
PerfTimingEnd("_blue")
end

function luaSC1StrikeforceSpawned(unit)
	if unit.Name == "Hayate" then
		Mission.Hayate = unit
		table.insert(Mission.StrikeForce1, unit)
		table.insert(Mission.DDs, unit)
	elseif  unit.Name == "Kisaragi" then
		Mission.Kisaragi = unit
		table.insert(Mission.StrikeForce1, unit)
		table.insert(Mission.DDs, unit)
	elseif unit.Name == "Kako" then
		Mission.Kako = unit
		table.insert(Mission.StrikeForce2, unit)
		table.insert(Mission.CLs, unit)
	elseif unit.Name == "Sagiri" then
		Mission.Sagiri = unit
		table.insert(Mission.StrikeForce2, unit)
		table.insert(Mission.DDs, unit)
	elseif unit.Name == "Oi" then
		Mission.Terutsukoi = unit
		table.insert(Mission.StrikeForce3, unit)
		table.insert(Mission.CLs, unit)
	elseif unit.Class.ID == 68 then
		Mission.Nachi = unit
		table.insert(Mission.StrikeForce4, unit)
		table.insert(Mission.CLs, unit)
		
		if Mission.PlayingCOOP then
		
			DisplayScores(1, 0, "Destroy the Nachi!", "")
			DisplayScores(1, 1, "Destroy the Nachi!", "")
			DisplayScores(1, 2, "Destroy the Nachi!", "")
			DisplayScores(1, 3, "Destroy the Nachi!", "")
			DisplayScores(1, 4, "Destroy the Nachi!", "")
			DisplayScores(1, 5, "Destroy the Nachi!", "")
			DisplayScores(1, 6, "Destroy the Nachi!", "")
			DisplayScores(1, 7, "Destroy the Nachi!", "")
		
		else
		
		DisplayUnitHP({unit}, "Destroy the Nachi!")
		
		
		end
		--luaObj_AddUnit("primary",1, unit)
	elseif unit.Name == "Hayashio" then
		Mission.Hayashio = unit
		table.insert(Mission.StrikeForce4, unit)
		table.insert(Mission.DDs, unit)
	end
	
	NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.PlayerUnits)))
	
	UnitSetFireStance(unit, 2)
	
	--if Mission.Difflvl == DIFF_ROOKIE then
	--	ShipSetTorpedoStock(unit, 5)
	--	SetCrewLevel(unit, CREW_ROOKIE)
	--elseif Mission.Difflvl == DIFF_REGULAR then
		--SetCrewLevel(unit, CREW_REGULAR)
	--elseif Mission.Difflvl == DIFF_VETERAN then
		SetCrewLevel(unit, CREW_VETERAN)
	--end
end

function luaSC1CheckStrikeForces(this)
	luaSC1CheckDeads()

	local trgTbl = this.PlayerUnits

	if table.getn(trgTbl) == 0 then
-- RELEASE_LOGOFF  		luaLog("luaSC1CheckStrikeForces: no trget found")
		return
	end

	--SF1
	if table.getn(this.StrikeForce1) ~= 0 then
		for idx,unit in pairs(this.StrikeForce1) do
			if unit.TrgID == nil or thisTable[unit.TrgID].Dead then
				local Trg = luaPickRnd(trgTbl)
				SetFireTarget(unit,Trg)
				NavigatorAttackMove(unit,Trg,{})
				unit.TrgID = Trg.ID
-- RELEASE_LOGOFF  				luaLog("luaSC1CheckStrikeForces: "..tostring(unit.Name).." received a new target "..tostring(Trg.Name))
			end
		end
	else
-- RELEASE_LOGOFF  	--	luaLog("luaSC1CheckStrikeForces: strikeforce1 is deadmeat.")
	end
	--SF2
	if table.getn(this.StrikeForce2) ~= 0 then
		for idx,unit in pairs(this.StrikeForce2) do
			if unit.TrgID == nil or thisTable[unit.TrgID].Dead then
				local Trg = luaPickRnd(trgTbl)
				SetFireTarget(unit,Trg)
				NavigatorAttackMove(unit,Trg,{})
				unit.TrgID = Trg.ID
-- RELEASE_LOGOFF  				luaLog("luaSC1CheckStrikeForces: "..tostring(unit.Name).." received a new target "..tostring(Trg.Name))
			end
		end
	else
-- RELEASE_LOGOFF  	--	luaLog("luaSC1CheckStrikeForces: strikeforce2 is deadmeat.")
	end
	--SF3
	if table.getn(this.StrikeForce3) ~= 0 then
		for idx,unit in pairs(this.StrikeForce3) do
			if unit.TrgID == nil or thisTable[unit.TrgID].Dead then
				local Trg = luaPickRnd(trgTbl)
				SetFireTarget(unit,Trg)
				NavigatorAttackMove(unit,Trg,{})
				unit.TrgID = Trg.ID
-- RELEASE_LOGOFF  				luaLog("luaSC1CheckStrikeForces: "..tostring(unit.Name).." received a new target "..tostring(Trg.Name))
			end
		end
	else
-- RELEASE_LOGOFF  	--	luaLog("luaSC1CheckStrikeForces: strikeforce2 is deadmeat.")
	end
	--SF4
	if table.getn(this.StrikeForce4) ~= 0 then
		for idx,unit in pairs(this.StrikeForce4) do
			if unit.TrgID == nil or thisTable[unit.TrgID].Dead then
				local Trg = luaPickRnd(trgTbl)
				SetFireTarget(unit,Trg)
				NavigatorAttackMove(unit,Trg,{})
				unit.TrgID = Trg.ID
-- RELEASE_LOGOFF  				luaLog("luaSC1CheckStrikeForces: "..tostring(unit.Name).." received a new target "..tostring(Trg.Name))
			end
		end
	else
-- RELEASE_LOGOFF  	--	luaLog("luaSC1CheckStrikeForces: strikeforce2 is deadmeat.")
	end
end

function luaSC1CheckDeads()
	Mission.LastShip = luaSumTables(Mission.StrikeForce1, Mission.StrikeForce2, Mission.StrikeForce3, Mission.StrikeForce4)
	Mission.StrikeForce1 = luaRemoveDeadsFromTable(Mission.StrikeForce1)
	Mission.StrikeForce2 = luaRemoveDeadsFromTable(Mission.StrikeForce2)
	Mission.StrikeForce3 = luaRemoveDeadsFromTable(Mission.StrikeForce3)
	Mission.StrikeForce4 = luaRemoveDeadsFromTable(Mission.StrikeForce4)
end

function luaSC1CheckObjectives(this)
	--obj
	if not luaObj_IsActive("primary",2) then
		luaObj_Add("primary",2,this.Catalina)
		
		if Mission.PlayingCOOP then
		
			DisplayScores(1, 0, "RV with the reconaissance plane!", "")
			DisplayScores(1, 1, "RV with the reconaissance plane!", "")
			DisplayScores(1, 2, "RV with the reconaissance plane!", "")
			DisplayScores(1, 3, "RV with the reconaissance plane!", "")
			DisplayScores(1, 4, "RV with the reconaissance plane!", "")
			DisplayScores(1, 5, "RV with the reconaissance plane!", "")
			DisplayScores(1, 6, "RV with the reconaissance plane!", "")
			DisplayScores(1, 7, "RV with the reconaissance plane!", "")
		
		else
			
			local line1 = "RV with the reconaissance plane!"
			local line2 = ""
			luaDisplayScore(1, line1, line2)
		
		end
	end

	if not Mission.CatalinaObjOk then
		return
	end

	if luaObj_GetSuccess("primary",2) == nil then
		local inRange = false
		for idx,unit in pairs(this.PlayerUnits) do
			if not unit.Dead and luaGetDistance(unit, this.Catalina) < 1250 then
				inRange = true
				HideScoreDisplay(1,0)
				SetInvincible(this.Catalina, false)
				SetRoleAvailable(this.Catalina, EROLF_ALL, PLAYER_ANY)
				break
			end
		end
		if inRange then
			luaObj_Completed("primary",2)
			
			this.FoundRecon = true
		else
			luaObj_Reminder("primary",2)
		end
	else
		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)			
		else
			if luaObj_GetSuccess("primary",1) == nil then
				
				--Mission.TEST = Mission.Nachi
				--MissionNarrative("#Mission.TEST#")
				if this.Nachi ~= nil and this.Nachi.Dead then
					luaObj_Completed("primary",1)
				else
					if not this.NachiAdded and this.StrikeForce4Spawned then
						
						--if Mission.Nachi and not Mission.Nachi.Dead then
						
							luaObj_AddUnit("primary",1, this.Nachi)
							this.NachiAdded = true
							
						--end
					end
					luaObj_Reminder("primary",1)
				end
			end
		end
	end

	if not luaObj_IsActive("secondary",1) then
		luaObj_Add("secondary",1,nil,true)
	end
end

function luaSC1CheckMusic()
	if table.getn(Mission.PlayerUnits) == 0 then
		return
	end

	if Mission.MissionPhase == 0 then
		Music_Control_SetLevel(MUSIC_TENSION)
	else		
		enemyShip = luaGetShipsAround(Mission.PlayerUnits[1], 2000, "enemy")		
		if Mission.Music == MUSIC_TENSION and enemyShip ~= nil then
			--luaLog("Switching to action music")
			Music_Control_SetLevel(MUSIC_ACTION)
			Mission.Music = MUSIC_ACTION
		--elseif Mission.Music == MUSIC_ACTION and (enemyShip == nil and enemyShip2 == nil) then
			--luaLog("Switching to tension music")
			--Music_Control_SetLevel(MUSIC_TENSION)
			--Mission.Music = MUSIC_TENSION
		end
	end

end

function luaSC1FinishOff()
	local selUnit = GetSelectedUnit()
	if selUnit == nil or selUnit.Dead then
		selUnit = Mission.PlayerUnits[1]
	end
	luaSC1AddAndFailHiddens()
	luaMissionFailedNew(selUnit, "You have surrendered.")
	RemoveListener("input", "Surrender")
	HideHint("All")
	Mission.Listener = false
end

function luaSC1DialogueFinished()
	local dialogNum = table.getn(GetActDialogIDs())

	if dialogNum == 0 then
		return true
	else
		return false
	end
end

function luaSC1CheckReconplane(this)
	if this.Catalina.Dead then
		return
	end
	if this.Catalina.Trg == nil or this.Catalina.Trg.Dead then
		luaSC1SelectTrg4Catalina()
	end
end

function luaSC1SelectTrg4Catalina()
	--[[local C = Mission.Catalina
	local CTrg = C.Trg

	if Mission.Nachi == nil then
		if Mission.StrikeForce1Spawned and not Mission.StrikeForce2Spawned then
			if CTrg == nil or CTrg.Dead or not Mission.FirstSel then
				local trgTbl = luaRemoveDeadsFromTable(Mission.StrikeForce1)
				local trg
				if table.getn(trgTbl) > 0 then
					trg = luaPickRnd(trgTbl)
					PilotMoveToRange(C, trg)
					C.Trg = trg
					MissionNarrative("b")
				end
				Mission.FirstSel = true
			end
		elseif Mission.StrikeForce2Spawned and not Mission.StrikeForce3Spawned then
			if CTrg == nil or CTrg.Dead and not Mission.SecondSel then
				local trgTbl = luaRemoveDeadsFromTable(Mission.StrikeForce2)
				local trg
				if table.getn(trgTbl) > 0 then
					trg = luaPickRnd(trgTbl)
					PilotMoveToRange(C, trg)
					C.Trg = trg
					MissionNarrative("c")
				end
				Mission.SecondSel = true
			end
		elseif Mission.StrikeForce3Spawned and not Mission.StrikeForce4Spawned then
			if CTrg == nil or CTrg.Dead and not Mission.ThirdSel then
				local trgTbl = luaRemoveDeadsFromTable(Mission.StrikeForce3)
				local trg
				if table.getn(trgTbl) > 0 then
					trg = luaPickRnd(trgTbl)
					PilotMoveToRange(C, trg)
					C.Trg = trg
					MissionNarrative("d")
				end
				Mission.ThiredSel = true
			end
		end
	else
		if CTrg ~= Mission.Nachi then
			PilotMoveToRange(C, Mission.Nachi)
			C.Trg = Mission.Nachi
			MissionNarrative("e")
		end
	end
	
	MissionNarrative("a")]]
	
end

function luaGoFuckYourself(unitTable, trg, dist1, dist2, alt, angle1, angle2)
	
	for idx,unit in pairs(unitTable) do
		
		--Mission.TEST = unit.Name
		--MissionNarrative("#Mission.TEST#")
		
		local spawned = Spawn(unit.Name, ST_ABSANGLE, GetPosition(trg), dist1, dist2, alt, angle1, angle2, "", true)

		luaSC1StrikeforceSpawned(spawned)
	
	end
	
end

function luaSC1IsBurning(ent)
-- RELEASE_LOGOFF  	luaLog("Name: "..ent.Name)
	local dam = luaGetDamageSections(ent)
	for idx,secIdx in pairs(dam) do
-- RELEASE_LOGOFF  		luaLog("Cat: "..secIdx.Category)
-- RELEASE_LOGOFF  		luaLog("Idx: "..tostring(secIdx.Index))
		if GetFire(ent, secIdx.Category, secIdx.Index) > 0 then
			return true
		end
	end
	return false
end

function luaSC1ShowCatalina(unit)
	Mission.FreeToGo = true
	EnableInput(false)
	
	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=unit,
				["pos"] = { -25, 2, 65, },
			},
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["zoom"]=1.0,
		}
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
			["postype"]="target",
			["position"]= {
				["parent"]=unit,
				["pos"] = { 0, 0, 0, },
			},
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["zoom"]=1.0,
		}
	MovCamNew_AddPosition(pos0)
	
	SetSkipMovie("luaSC1SkipMovie")	
	
	local pos0 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["parent"]=unit,
				["modifier"] = {
					["name"] = "goaround",
					["radius"] = { 75, },
					["radiuslinearblend"] = 0.3,
					["theta"] = {7.5},
					["thetalinearblend"] = 0.3,
					["rho"] = { 50 },
					["rholinearblend"] = 0.5,
				}
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=13.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
		}

	MovCamNew_AddPosition(pos0)
end

function luaSC1ShowDests()	
	
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.PlayerUnits[1],
               ["pos"] = { -87.3, 20, 15.0 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
           ["zoom"] = 2.5,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.PlayerUnits[1],
               ["pos"] = { -73.32, 20, 104.21 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=12.0,
           ["linearblend"]=1.0,
	         ["zoom"] = 2.5,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.PlayerUnits[1],
               ["pos"] = { -347.99, 44, 39.45, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
					 ["zoom"] = 2.5,
       }
  
  MovCamNew_AddPosition(pos0)

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.PlayerUnits[1],
               ["pos"] = { -196.33, 44, 290.93, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=12.0,
           ["linearblend"]=1.0,
					 ["zoom"] = 2.5,
       }
  
  MovCamNew_AddPosition(pos0)

end

--[[function luaSC1CamRoundDests()
	
	local pos0 = {
			["postype"]="cameraandtarget",
			["position"]= {
				["parent"]=Mission.PlayerUnits[1],
				["modifier"] = {
					["name"] = "gamecamera",
				}
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=10.0,
			["zoom"]=1,
			["finishscript"] = "luaSC1EnableInput",
	}

	MovCamNew_AddPosition(pos0)
	
end]]

function luaSC1EnableInput()
	SetSkipMovie()
	Mission.CatalinaObjOk = true
	EnableInput(true)
	SetSelectedUnit(Mission.PlayerUnits[1])
end

function luaSC1BeginMission()
	--luaFadeIn()
	Blackout(false,"",3.5)
	luaSC1ShowCatalina(Mission.Catalina)
end

function luaSC1SkipMovie()
	if not Mission.MovieSkip then
-- RELEASE_LOGOFF  			luaLog("Enginemovie running")
			luaCrossFade(luaSC1MovieClean)
			Mission.MovieSkip = true
	end
end

function luaSC1MovieClean()
	SetSkipMovie()
	for idx,dlg in pairs(GetActDialogIDs()) do
		if dlg then
			BreakDialog(dlg)
-- RELEASE_LOGOFF  			luaLog("Dlg ID: "..tostring(dlg))				
			if Mission.Dialogues[tonumber(dlg)] then
				Mission.Dialogues[tonumber(dlg)].printed = true
			end
		end
	end
	SetSelectedUnit(Mission.PlayerUnits[1])
	Mission.CatalinaObjOk = true
	EnableInput(true)
end

function luaSC1AddAndFailHiddens()
	for idx,obj in pairs(Mission.Objectives.hidden) do
		if not luaObj_IsActive("hidden",idx) then
			luaObj_Add("hidden",idx)
			luaObj_Failed("hidden",idx)
		end
	end
end

function luaSC1CheckMovie()

  if not Mission.MovieSkip and not Mission.SecondCut and GameTime()>9 then
  	
  	luaSC1ShowDests()

		Mission.SecondCut = true
	
	end
	
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaSC1CheckMovieEnd()

	if not Mission.MovieSkip and not Mission.MovieEnd and GameTime()>18 then
	
	 Mission.MovieEnd = true

	 luaSC1SkipMovie()
	 
	end

end