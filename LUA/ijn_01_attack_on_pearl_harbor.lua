---- ATTACK ON PEARL HARBOR (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- ATTACK ON PEARL HARBOR (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	--[[PrepareClass(150) 	-- Zero
	PrepareClass(162) 	-- B5N
	PrepareClass(159) 	-- D4Y]]
	
	PrepareClass(135) 	-- P40
	PrepareClass(325) 	-- SB2U
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("ijndlg",1)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_01_attack_on_pearl_harbor.lua"

	this.Name = "IJN01"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Launch",
				["Text"] = "Launch the first attack wave!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Sink",
				["Text"] = "Sink all capital ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Prot",
				["Text"] = "Repel the enemy counter-attack!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Midget",
				["Text"] = "Protect the midget submarines!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[[[2] = {
				["ID"] = "B17s",
				["Text"] = "Shoot down the enemy B-17s!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},]]
			[3] = {
				["ID"] = "Lose",
				["Text"] = "Don't lose a single ship to the American attack!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Detonate",
				["Text"] = "Detonate the USS Arizona!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Annihilate",
				["Text"] = "Destroy all enemy ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
		["marker2"] = {
			[1] = {
				["ID"] = "Path_markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		}
	}
	
	---- DIALOGUES ----
	
	Mission.Dialogues = {
		["Intro1"] = {--
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "idlg01b",
				},
				--[[{
					["message"] = "idlg01c",
				},]]
			},
		},
		["Intro2"] = {--
			["sequence"] = {
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["message"] = "INTRO3",
				},
				--[[{
					["message"] = "INTRO4",
				},]]
			},
		},
		["Intro3"] = {--
			["sequence"] = {
				{
					["message"] = "idlg01d",
				},
				{
					["message"] = "idlg01e",
				},
				{
					["message"] = "idlg01f",
				},
				{
					["message"] = "idlg01g",
				},
				--{
				--	["message"] = "idlg01c_1",
				--},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecondObjs",
				},
			},
		},
		["EnterpriseDead"] = {--
			["sequence"] = {
				{
					["message"] = "ENTAPRAIS",
				},
			},
		},
		--into fighter
		["Intro_Fighter"] = {--
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
				{
					["message"] = "dlg1c",
				},
				--[[{
					["type"] = "callback",
					["callback"] = "luaAddSecondObjs",
				},]]
				--[[{
					["message"] = "dlg1d",
				},]]
			},
		},
		--entering x range of warhawks (objective reminder)
		["InRange"] = {--
			["sequence"] = {
				{
					["message"] = "dlg32c",
				},
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaTrafficDia"
				},
			},
		},
		--into divebomber
		["Intro_Diver"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		--into torpedobomber
		["Intro_torper"] = {--
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
				{
					["message"] = "dlg16",
				},
			},
		},
		---US RADIO TRAFFIC
		--init - while player flies in2
		["Fly_in_radio2"] = {--
			["sequence"] = {
				{
					["message"] = "dlg33a",
				},
				{
					["message"] = "dlg33b",
				},
				{
					["message"] = "dlg33c",
				},
				{
					["message"] = "dlg33d",
				},
			},
		},
		--radio station killed
		["Radio_destroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg34",
				},
			},
		},
		--first US target destroyed
		["PearlTraffic1"] = {
			["sequence"] = {
				{
					["message"] = "dlg35a",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg35b",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg35c",
				},
			},
		},
		["PearlTraffic2"] = {
			["sequence"] = {
				{
					["message"] = "dlg36a",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "dlg36b",
				},
				{
					["type"] = "pause",
					["time"] = 5,
				},
				{
					["message"] = "dlg37a",
				},
			},
		},
		["PearlTraffic3"] = {--
			["sequence"] = {
				{
					["message"] = "dlg49a",
				},
				{
					["message"] = "dlg49b",
				},
				{
					["message"] = "dlg49c",
				},
				{
					["message"] = "dlg49d",
				},
				{
					["message"] = "dlg49e",
				},
			},
		},
		--firing on US planes on ground
		["Plane_killing"] = {
			["sequence"] = {
				{
					["message"] = "dlg36a",
				},
				{
					["message"] = "dlg36b",
				},
			},
		},
		--x after
		["Nevada_explodes"] = {--
			["sequence"] = {
				{
					["message"] = "dlg38",
				},
				{
					["message"] = "dlg37b",
				},
			},
		},
		--5-10 sec after Nevada exploded
		["Arizona_dead"] = {--
			["sequence"] = {
				{
					["message"] = "dlg40",
				},
			},
		},
		--midget sub event
		["Minisub_init"] = {--
			["sequence"] = {
				{
					["message"] = "dlg44a",
				},
				{
					["message"] = "dlg44b",
				},
				--[[{
					["message"] = "dlg44c",
				},]]
			},
		},
		--Monaghan destroys midget sub
		["Minisub_dead"] = {--
			["sequence"] = {
				{
					["message"] = "dlg46",
				},
			},
		},
		--Monaghan lost
		["Monaghan_lost"] = {--
			["sequence"] = {
				{
					["message"] = "dlg47",
				},
			},
		},
		--Phoenix lost
		["Phoenix_lost"] = {--
			["sequence"] = {
				{
					["message"] = "dlg48",
				},
				{
					["message"] = "dlg29a",
				},
				{
					["message"] = "dlg29b",
				},
			},
		},
		--radio
		["Radio_speech1"] = {
			["sequence"] = {
				{
					["message"] = "dlg49a",
				},
			},
		},
		["Radio_speech2"] = {
			["sequence"] = {
				{
					["message"] = "dlg49b",
				},
			},
		},
		["Radio_speech3"] = {
			["sequence"] = {
				{
					["message"] = "dlg49c",
				},
			},
		},
		["Radio_speech4"] = {
			["sequence"] = {
				{
					["message"] = "dlg49d",
				},
			},
		},
		["Radio_speech4"] = {
			["sequence"] = {
				{
					["message"] = "dlg49e",
				},
			},
		},
		--West Virginia dead
		["WV_dead"] = {--
			["sequence"] = {
				{
					["message"] = "dlg50",
				},
			},
		},
		--Oklahoma dead
		["Oklahoma_dead"] = {--
			["sequence"] = {
				{
					["message"] = "dlg51",
				},
			},
		},
		--20-30 sec after utah hit Message
		["Utah_hit3"] = {--
			["sequence"] = {
				{
					["message"] = "dlg55",
				},
			},
		},
		--radio governor
		["Governor"] = {--
			["defaultPause"] = 0.1,
			["sequence"] = {
				{
					["message"] = "dlg56a",
				},
				{
					["message"] = "dlg56a_1",
				},
				{
					["message"] = "dlg56a_2",
				},
				{
					["message"] = "dlg56b",
				},
			},
		},
		["MicrotutDone"] = {--
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["BANZAI"] = {--
			["sequence"] = {
				{
					["message"] = "BANZAI1",
				},
				{
					["message"] = "BANZAI2",
				},
			},
		},
		["INCOMING"] = {--
			["sequence"] = {
				{
					["message"] = "INCOMING1",
				},
				{
					["message"] = "INCOMING2",
				},
				{
					["message"] = "INCOMING3",
				},
				{
					["message"] = "INCOMING4",
				},
			},
		},
		["RAM"] = {--
			["sequence"] = {
				{
					["message"] = "dlg21a",
				},
			},
		},
		["HOSPITALHIT"] = {--
			["sequence"] = {
				{
					["message"] = "HOSPITAL1",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["type"] = "pause",
					["time"] = 2.5,
				},
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "dlg31a",
				},
				{
					["message"] = "FINAL3",
				},
				{
					["message"] = "dlg31a_1",
				},
				{
					["message"] = "dlg31b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
	}
	
	---- DIFFICULTY SETTING ----
	
	Mission.Difficulty = GetDifficulty()
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_STUN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	end
	if Mission.Difficulty == 0 then
		Mission.SkillLevelOwn = SKILL_ELITE
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevelOwn = SKILL_SPVETERAN
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_SPNORMAL
	end
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- IJN ----
	
	Mission.JapAttackers = {}
	Mission.RetreatingJaps = {}
	Mission.LaunchedPlanes = {}
	Mission.NextAttackWavePlanes = {}
	Mission.NextAttackWaveAmmos = {}
	Mission.MiniSubGang = {}
	Mission.FinalZeros = {}
	
	---- USN ----
	
	Mission.Enterprise = FindEntity("Enterprise")
	Mission.Lexington = FindEntity("Lexington")
	
	--[[local bruh = luaRnd(1, 3)
	
	if bruh == 1 then
	
		local unit1 = Mission.Enterprise
		local unit2 = Mission.Lexington
		local unit3 = FindEntity("New Orleans")
		
		local unitPos1 = GetPosition(unit1)
		local unitPos2 = GetPosition(unit2)
		local unitPos3 = GetPosition(unit3)
		local unitRot1 = GetRotation(unit1)
		local unitRot2 = GetRotation(unit2)
		local unitRot3 = GetRotation(unit3)
		
		unitPos2.z = unitPos2.z + 100
		
		PutTo(unit1, unitPos2, unitRot2)
		
		unitPos2.z = unitPos2.z - 100
		
		PutTo(unit2, unitPos3, unitRot3)
		PutTo(unit3, unitPos1, unitRot1)
		PutTo(unit1, unitPos2, unitRot2)
		
	elseif bruh == 2 then
	
		local unit1 = FindEntity("Phoenix")
		local unit2 = Mission.Lexington
		local unit3 = Mission.Enterprise
		
		local unitPos1 = GetPosition(unit1)
		local unitPos2 = GetPosition(unit2)
		local unitPos3 = GetPosition(unit3)
		local unitRot1 = GetRotation(unit1)
		local unitRot2 = GetRotation(unit2)
		local unitRot3 = GetRotation(unit3)
		
		unitPos2.z = unitPos2.z + 100
		
		PutTo(unit1, unitPos2, unitRot2)
		
		unitPos2.z = unitPos2.z - 100
		
		PutTo(unit2, unitPos3, unitRot3)
		PutTo(unit3, unitPos1, unitRot1)
		PutTo(unit1, unitPos2, unitRot2)
	
	end]]
	
	Mission.USAttackers = {}
	
	---- VAR ----
	
	Mission.JapPh2Spawn = FindEntity("JapPh2Spawn")
	Mission.JapPh2Retreat = FindEntity("JapPh2Retreat")
	Mission.HarborCenter = FindEntity("HarborCenter")
	Mission.BBRowGoTo = FindEntity("BBRowGoTo")
	Mission.HarborEscape = FindEntity("HarborEscape")
	Mission.HarborEntrance = FindEntity("HarborEntrance")
	--Mission.KillerFortressTrg = FindEntity("KillerFortressTrg")
	
	--[[Mission.FirePoints = {}
	
	for i=1,12 do
		
		local point = FindEntity("Boom_"..tostring(i))
		if point then
		
			table.insert(Mission.FirePoints, point)
			
		end
		
	end]]

	Mission.SmokePoints = {}
	
	for i=1,27 do
		
		local point = FindEntity("IslandEffect_"..tostring(i))
		if point then
		
			table.insert(Mission.SmokePoints, point)
			
		end
		
	end
	
	Mission.Efx = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Ph1Counter = 300
	Mission.Ph2AttackWaveDelay = 150
	Mission.Ph2Counter = Mission.Ph2AttackWaveDelay
	Mission.AttackWaves = 0
	Mission.USAttackWaves = 0
	Mission.AttackWaveMax = 5
	Mission.JapAttackerNum = 16
	--Mission.KillerFortressHits = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.AFCapNum = 0
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.AFCapNum = 1
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.AFCapNum = 2
		
	end
	
	---- INIT FUNCT. ----
	
	luaSpawnJapFleet()
	luaIntroText()
	
	Blackout(true, "", true)
	EnableMessages(false)
	
	ForceEnableInput(IC_MAP_TOGGLE, false)
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- THINK ----

    luaInitNewSystems()
    luaCheckObjectives()


    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("PHMovingInPathSouth"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		luaDelay(luaMoveToPh3, 50)
	
	end]]
	
end

---- THINK ----

function lua_Think(this, msg)

	if luaMessageHandler (this, msg) == "killed" then
		
		return
		
	end

	if Mission.EndMission then
	
		return
	
	end
	
	if not Mission.Started then
	
		luaStartMission()
		
		Mission.Started = true

    else

        if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	

    ---- TEST ----

    --print("text")
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.USAttackers))
	--MissionNarrative("#Mission.TEST#")
	
end

---- OBJECTIVE CHECKER ----

function luaCheckObjectives()

	if not Mission.EndMission then
	
		if Mission.MissionPhase > 0 then
		
			--[[local music_selectedUnit = GetSelectedUnit()

			if music_selectedUnit then

				luaCheckMusic(music_selectedUnit)

			end]]
			
			if Mission.MusicAction and not Mission.ActionMusicSet then
			
				Music_Control_SetLevel(MUSIC_ACTION)
				luaCheckMusicSetMinLevel(MUSIC_ACTION)
				
				Mission.ActionMusicSet = true
				
			elseif not Mission.MusicAction and Mission.ActionMusicSet then
			
				Music_Control_SetLevel(MUSIC_TENSION)
				luaCheckMusicSetMinLevel(MUSIC_TENSION)
				
				Mission.ActionMusicSet = false
				
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary",1) then
			
				local squads1, planes1 = luaGetSlotsAndSquads(Mission.Taiho)
				local squads2, planes2 = luaGetSlotsAndSquads(Mission.Ginryu)
				local squads3, planes3 = luaGetSlotsAndSquads(Mission.Hiryu)
				local squads4, planes4 = luaGetSlotsAndSquads(Mission.Soryu)
				local squads5, planes5 = luaGetSlotsAndSquads(Mission.Zuikaku)
				local squads6, planes6 = luaGetSlotsAndSquads(Mission.Shokaku)
				
				local squads = squads1 + squads2 + squads3 + squads4 + squads5 + squads6
				
				for idx,cv in pairs(luaRemoveDeadsFromTable(Mission.CVGang)) do
					
					local slotNum
					
					if cv.Name == "Zuikaku" or cv.Name == "Shokaku" then
					
						slotNum = 2
						
					else
					
						slotNum = 3
					
					end
					
					for i = 1, slotNum do
					
						local plane = thisTable[tostring(GetProperty(cv, "slots")[i].squadron)]
						
						if plane and not plane.Dead then
						
							if not plane.madeAI then
							
								SetRoleAvailable(plane, EROLF_ALL, PLAYER_AI)
								table.insert(Mission.LaunchedPlanes, plane)
								
								plane.madeAI = true
							
							end
							
							if plane.Class.ID == 150 and not Mission.ZeroDiaPlayed then
							
								luaStartDialog("Intro_Fighter")
								
								Mission.ZeroDiaPlayed = true
								
							end
							
						end
						
					end
					
				end
				
				if squads == Mission.JapAttackerNum or Mission.CanMoveToPh2 then
					
					if table.getn(luaRemoveDeadsFromTable(Mission.LaunchedPlanes)) > 0 then
					
						for idx,plane in pairs(luaRemoveDeadsFromTable(Mission.LaunchedPlanes)) do
							
							if plane and not plane.Dead then
								
								local planeClass = plane.Class.ID
								local planeAmmo = GetProperty(plane, "ammoType")
								
								table.insert(Mission.NextAttackWavePlanes, planeClass)
								table.insert(Mission.NextAttackWaveAmmos, planeAmmo)
							
								Kill(plane, true)
								
							end
							
						end
					
					end
					
					luaObj_Completed("primary", 1)
					
					Blackout(true, "luaMoveToPh2", 1)
					
				end
			
			end
			
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary",2) or Mission.Phase2Forming then
				
				if not Mission.Phase2Forming then
					
					Mission.CapitalNum = table.getn(luaRemoveDeadsFromTable(Mission.CapitalShipGang))
					
					local line1 = "Sink all capital ships!"
					local line2 = "Capital ship(s) left: #Mission.CapitalNum#"
					luaDisplayScore(2, line1, line2)
					
					Mission.AttackWavesLeft = Mission.AttackWaveMax - Mission.AttackWaves
					
					local line1 = "Attack wave(s) left:"
					local line2 = "#Mission.AttackWavesLeft#"
					luaDisplayScore(3, line1, line2)
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) == 0 then
					
					--HideUnitHP()
					HideScoreDisplay(2,0)
					HideScoreDisplay(3,0)
					
					luaObj_Completed("primary", 2)
					
					Blackout(true, "luaPh2EndMovie", 1)
					
				else
					
					if Mission.AttackWaves < Mission.AttackWaveMax then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.JapAttackers)) == 0 then
						
							luaSpawnNextAttackWave()
							
						else
							
							if Mission.Ph2Counter <= 0 then
							
								luaSpawnNextAttackWave()
							
							end
							
							for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapAttackers)) do
								
								if unit and not unit.Dead then
								
									if unit.Class.ID == 163 or unit.Class.ID == 159 then
									
										if GetProperty(unit, "ammoType") == 0 and not unit.retreating then
											
											SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
											UnitHoldFire(unit)
											PilotMoveToRange(unit, Mission.JapPh2Retreat)
											
											table.insert(Mission.RetreatingJaps, unit)
											
											unit.retreating = true
										
										end
									
									end
								
								end
								
							end
						
						end
					
					else
					
						if table.getn(luaRemoveDeadsFromTable(Mission.JapAttackers)) == 0 then
							
							--HideUnitHP()
							HideScoreDisplay(2,0)
							HideScoreDisplay(3,0)
							
							luaObj_Failed("primary", 2)
							
							luaMissionFailed(unit)
						
						end
					
					end
					
				end
				
				--[[if table.getn(luaRemoveDeadsFromTable(Mission.PlaneGang)) == 0 and not Mission.PlaneGangDiaPlayed then
				
					luaStartDialog("MicrotutDone")
					
					Mission.PlaneGangDiaPlayed = true
				
				end]]
				
			end
			
			if Mission.Difficulty > 0 then
			
				if Mission.AttackWaves == 3 then
					
					if Mission.AF2 and not Mission.AF2.Dead and not Mission.Bruh1 then
						
						if IsReadyToSendPlanes(Mission.AF2) then
						
							--luaCapManager(Mission.AF2, {135}, Mission.AFCapNum)
							LaunchSquadron(Mission.AF2,135,3)
							
							Mission.Bruh1 = true
						
						end
						
					end
					
				elseif Mission.AttackWaves == 4 then
					
					if Mission.AF2 and not Mission.AF2.Dead and not Mission.Bruh2 then
						
						if IsReadyToSendPlanes(Mission.AF2) then
						
							--luaCapManager(Mission.AF2, {135}, Mission.AFCapNum)
							LaunchSquadron(Mission.AF2,135,3)
							
							Mission.Bruh2 = true
						
						end
						
					end
					
				elseif Mission.AttackWaves == 5 then
					
					if Mission.AF2 and not Mission.AF2.Dead and not Mission.Bruh3 then
						
						if IsReadyToSendPlanes(Mission.AF2) then
						
							--luaCapManager(Mission.AF2, {135}, Mission.AFCapNum)
							LaunchSquadron(Mission.AF2,135,3)
							
							Mission.Bruh3 = true
						
						end
						
					end
					
					
				end
			
			end
			
			if Mission.Arizona and not Mission.Arizona.Dead then
			
				if GetHpPercentage(Mission.Arizona) <= 0.7 and not Mission.ArizonaSunk then
					
					luaObj_Completed("hidden", 1)
					
					luaArizonaHit()
					
					Mission.ArizonaSunk = true
					
				end
			
			end
			
			if Mission.WestVirginia and not Mission.WestVirginia.Dead then
			
				if GetHpPercentage(Mission.WestVirginia) <= 0.4 and not Mission.WestVirginiaSunk then
					
					luaWVHit()
					
					Mission.WestVirginiaSunk = true
					
				end
			
			end
			
			if Mission.Nevada and not Mission.Nevada.Dead then
			
				if GetHpPercentage(Mission.Nevada) <= 0.5 and not Mission.NevadaSunk then
					
					luaNevadaHit()
					
					Mission.NevadaSunk = true
					
				end
			
			end
			
			if Mission.Utah and not Mission.Utah.Dead then
			
				if GetHpPercentage(Mission.Utah) <= 0.4 and not Mission.UtahSunk then
					
					luaUtahHit()
					
					Mission.UtahSunk = true
					
				end
			
			end
			
			if Mission.Maryland and not Mission.Maryland.Dead then
			
				if GetHpPercentage(Mission.Maryland) <= 0.6 and not Mission.MarylandSunk then
					
					luaMarylandHit()
					
					Mission.MarylandSunk = true
					
				end
			
			end
			
			if Mission.Oklahoma and not Mission.Oklahoma.Dead then
			
				if GetHpPercentage(Mission.Oklahoma) <= 0.7 and not Mission.OklahomaSunk then
					
					luaOklahomaHit()
					
					Mission.OklahomaSunk = true
					
				end
			
			end
			
			if Mission.Tennessee and not Mission.Tennessee.Dead then
			
				if GetHpPercentage(Mission.Tennessee) <= 0.5 and not Mission.TennesseeSunk then
					
					luaTennesseHit()
					
					Mission.TennesseeSunk = true
					
				end
			
			end
			
			if Mission.California and not Mission.California.Dead then
			
				if GetHpPercentage(Mission.California) <= 0.45 and not Mission.CaliforniaSunk then
					
					luaCaliforniaHit()
					
					Mission.CaliforniaSunk = true
					
				end
			
			end
			
			if Mission.Enterprise and not Mission.Enterprise.Dead then
			
				if GetHpPercentage(Mission.Enterprise) <= 0.38 and not Mission.EnterpriseSunk then
					
					luaEnterpriseHit()
					
					luaStartDialog("EnterpriseDead")
					
					Mission.EnterpriseSunk = true
					
				end
			
			end
			
			if Mission.Lexington and not Mission.Lexington.Dead then
			
				if GetHpPercentage(Mission.Lexington) <= 0.42 and not Mission.LexingtonSunk then
					
					ExplodeToParts(Mission.Lexington)
					SetDeadMeat(Mission.Lexington)
					
					Mission.LexingtonSunk = true
					
				end
			
			end
			
			if Mission.Phoenix.Dead and not Mission.PhoenixSunk then
			
				luaStartDialog("Phoenix_lost")
				
				Mission.PhoenixSunk = true
			
			end
			
			if Mission.Monaghan.Dead and not Mission.MonaghanSunk then
			
				luaStartDialog("Monaghan_lost")
				
				Mission.MonaghanSunk = true
			
			end
			
			if luaObj_IsActive("secondary",1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.MiniSubGang)) == 0 then
				
					luaObj_Failed("secondary", 1)
					
					luaStartDialog("Minisub_dead")
					
				end
				
			end
			
			--[[if luaObj_IsActive("secondary",2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.B17s)) == 0 then
					
					if IsListenerActive("recon", "B17Listener") then
					
						RemoveListener("recon", "B17Listener")
					
					end
					
					--[[if IsListenerActive("hit", "B17HitListener") then
					
						RemoveListener("hit", "B17HitListener")
					
					end]]
					
					luaObj_Completed("secondary", 2)
					
				end
				
			end]]
			
			--[[if luaObj_IsActive("secondary",3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cranes)) == 0 then
					
					luaObj_Completed("secondary", 3, true)
					
				end
				
			end]]
			
			if Mission.RadioStation then
			
				if Mission.RadioStation.Dead and not Mission.RadioStationDiaPlayed and not Mission.USPanic then
				
					luaStartDialog("Radio_destroyed")
					
					Mission.RadioStationDiaPlayed = true
				
				end
			
			end
			
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary",3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CVGang)) == 0 then
					
					HideUnitHP()
					
					luaObj_Failed("primary", 3)
					
					luaMissionFailed(luaPickRnd(Mission.CVGang))
					
				else
					
					if table.getn(luaRemoveDeadsFromTable(Mission.FinalZeros)) == 0 then
					
						local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))
						
						if cv and not cv.Dead then
							
							if IsReadyToSendPlanes(cv) then
								
								local planeTypes = {
													322,
													322,
													}
								local slotIndex = LaunchSquadron(cv,luaPickRnd(planeTypes),3)
								local launchedZero = thisTable[tostring(GetProperty(cv, "slots")[slotIndex].squadron)]
								SetRoleAvailable(launchedZero, EROLF_ALL, PLAYER_ANY)
								SetSkillLevel(launchedZero, Mission.SkillLevelOwn)
								table.insert(Mission.FinalZeros, launchedZero)
							
							end
							
						end
					
					end
					
					--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVGang)) do
						
						if unit and not unit.Dead then
						
							luaCapManager(unit, {322}, 1)
						
						end
						
					end]]
					
					if Mission.USAttackWaves < 3 then
					
						if Mission.CanSpawnNextUSWave then
						
							luaSpawnNextAmericanWave()
						
						end
					
					else
						
						if table.getn(luaRemoveDeadsFromTable(Mission.USAttackers)) == 0 or Mission.CanComplete then
							
							Mission.MusicAction = false
							
							HideUnitHP()
							
							if luaObj_IsActive("secondary",3) then
							
								luaObj_Completed("secondary", 3)
							
							end
							
							if table.getn(luaRemoveDeadsFromTable(Mission.JapGang)) > 0 then
								
								for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapGang)) do
									
									if unit and not unit.Dead then
									
										SetInvincible(unit, 0.01)
									
									end
									
								end
								
							end
							
							luaObj_Completed("primary", 3)
							
							luaStartDialog("FINAL")
							
							Mission.EndMission = true
							
						else
							
							if not Mission.FinalTimerStarted then
							
								luaDelay(luaPh3ForceEnd, 150)
								
								Mission.FinalTimerStarted = true
							
							end
							
							--[[if Mission.KillerFortress and not Mission.KillerFortress.Dead and not Mission.KillerFortressSet then
							
								if luaGetDistance(Mission.KillerFortress, Mission.KillerFortress.cvTrg) < 425 then
								
									SetInvincible(Mission.KillerFortress, 0)
									
									Mission.KillerFortressSet = true
									
								end
							
							elseif Mission.KillerFortress.Dead then
							
								luaDelay(luaKillerFortressDia, 2.5)
							
							end]]
						
						end
					
					end
					
					if luaObj_IsActive("secondary",3) then
					
						if table.getn(luaRemoveDeadsFromTable(Mission.JapGang)) <= 23 then
						
							luaObj_Failed("secondary", 3, true)
						
						end
					
					end
					
				end
				
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 3 ----

function luaPh3ForceEnd()

	if not Mission.EndMission then
	
		Mission.CanComplete = true
	
	end

end

--[[function luaKillerFortressDia()

	luaStartDialog("RAM")
	
	Mission.KillerFortressDead = true

end]]

function luaMoveToPh3()
	
	Loading_Start()
	
	Mission.MissionPhase = 3
	
	if not Mission.Debug then
		
		if IsListenerActive("hit", "HospitalHitListener") then
		
			RemoveListener("hit", "HospitalHitListener")
		
		end
		
		if Mission.Enterprise and not Mission.Enterprise.Dead then
		
			Kill(Mission.Enterprise, true)
		
		end
		
		if Mission.AF1 and not Mission.AF1.Dead then
			
			AddDamage(Mission.AF1, 9999)
		
		end
		
		if Mission.AF2 and not Mission.AF2.Dead then
		
			AddDamage(Mission.AF2, 9999)
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
		
			if luaObj_IsActive("hidden",2) then
				
				luaObj_Completed("hidden",2)
			
			end
		
		end
		
		--[[SetInvincible(Mission.Arizona, 0)
		SetInvincible(Mission.WestVirginia, 0)
		SetInvincible(Mission.Nevada, 0)
		SetInvincible(Mission.Utah, 0)
		SetInvincible(Mission.Maryland, 0)
		SetInvincible(Mission.Oklahoma, 0)
		SetInvincible(Mission.Tennessee, 0)
		SetInvincible(Mission.California, 0)
		SetInvincible(Mission.Enterprise, 0)]]
		
		if table.getn(luaRemoveDeadsFromTable(Mission.MiniSubGang)) > 0 then
		
			if luaObj_IsActive("secondary",1) then
				
				luaObj_Completed("secondary",1)
			
			end
			
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MiniSubGang)) do
				
				Kill(unit, true)
			
			end
			
		end
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BBRowGang)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
			
			end
			
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.LesserShipGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LesserShipGang)) do
				
				Kill(unit, true)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.CargoGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CargoGang)) do
				
				Kill(unit, true)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.SubGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SubGang)) do
				
				Kill(unit, true)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.PTGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PTGang)) do
				
				Kill(unit, true)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.Efx)) > 0 then
		
			for idx,efx in pairs(luaRemoveDeadsFromTable(Mission.Efx)) do
				
				StopEffect(efx.Pointer)
			
			end
		
		end
		
		if not Mission.Lexington then
		
			UnloadClass(1001)		 -- Lexington
		
		end
		
		UnloadClass(466)	 -- Colorado
		UnloadClass(467) 	-- New Mexico
		UnloadClass(468) 	-- Pennsylvania
		UnloadClass(1002) 	-- Enterprise
		UnloadClass(1019) 	-- Northampton
		UnloadClass(1018)	 	-- Cleveland
		UnloadClass(25)		 -- Clemson
	
		luaSpawnJapFleet()
		
		for idx,unit in pairs(Mission.CVGang) do
			
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			
		end
		
	end
	
	--[[for i = 1, 4 do
		
		luaSpawnJap(159, 3, GetPosition(luaPickRnd(Mission.CVGang)), 0, random(1500,3500), random(500,900), random(-2000,2000))
		
		luaSpawnJap(163, 3, GetPosition(luaPickRnd(Mission.CVGang)), 0, random(1500,3500), random(500,900), random(-2000,2000))
		
	end]]
	
	Mission.MovieKate = GenerateObject("MovieKate")
	
	EntityTurnToEntity(Mission.MovieKate, Mission.Taiho)
	PilotLand(Mission.MovieKate, Mission.Taiho)
	
	luaSpawnNextAmericanWave()
	
	Loading_Finish()
	
	MissionNarrative("A few hours later...")

	--luaDelay(luaPh3Movie, 3)

end

function luaPh3Movie()
	
	if not Mission.Debug then
	
		Blackout(false, "", 2)
	
	end
	
	local attacker = luaPickRnd(luaRemoveDeadsFromTable(Mission.USAttackers))
	
	local slotIndex = LaunchSquadron(Mission.Ginryu,322,3)
	Mission.LaunchedZero = thisTable[tostring(GetProperty(Mission.Ginryu, "slots")[slotIndex].squadron)]
	SetRoleAvailable(Mission.LaunchedZero, EROLF_ALL, PLAYER_ANY)
	SetSkillLevel(Mission.LaunchedZero, Mission.SkillLevelOwn)
	
	table.insert(Mission.FinalZeros, Mission.LaunchedZero)
	
	luaDelay(luaBanzaiDia, 4)
	luaDelay(luaSwitchMusic, 14)
	luaDelay(luaIncomingDia, 15)
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieKate, ["distance"] = 50, ["theta"] = 5, ["rho"] = 355, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieKate, ["distance"] = 25, ["theta"] = 5, ["rho"] = 40, ["moveTime"] = 13},
		
		{["postype"] = "cameraandtarget", ["target"] = attacker, ["distance"] = 100, ["theta"] = 3, ["rho"] = 125, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = attacker, ["distance"] = 100, ["theta"] = 3, ["rho"] = 125, ["moveTime"] = 8},
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.LaunchedZero, ["distance"] = 50, ["theta"] = 5, ["rho"] = 255, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.LaunchedZero, ["distance"] = 43, ["theta"] = 5, ["rho"] = 195, ["moveTime"] = 6},
		{["postype"]="cameraandtarget",
		["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.LaunchedZero.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},
		["transformtype"]="keepall",
		["starttime"]=0.0,
		["blendtime"]=1.5,
		["wanderer"]=false,
		["zoom"] = 1,},
    },
	luaPh3MovieEnd, true)

end

function luaSwitchMusic()

	Mission.MusicAction = true

end

function luaBanzaiDia()

	luaStartDialog("BANZAI")

end

function luaIncomingDia()

	luaStartDialog("INCOMING")

end

function luaPh3MovieEnd()

	SetSelectedUnit(Mission.LaunchedZero)
	
	luaAddFinalObjs()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 3, Mission.USAttackers)
	luaObj_Add("secondary", 3)
	
	DisplayUnitHP((Mission.JapGang), "Protect your fleet!")
	
end

function luaSpawnNextAmericanWave()
	
	for i = 1, 2 do
		
		luaSpawnAmerican(116, 2, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))), 1, random(5000,7500), random(500,1200), random(-2000,2000))
		
		--luaSpawnAmerican(163, 3, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))), 0, random(-1500,-3500), random(500,900), random(-2000,2000))
		
	end
	
	for i = 1, 2 do
		
		luaSpawnAmerican(325, 3, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))), 1, random(5000,7500), random(500,1200), random(-2000,2000))
		
	end
	
	Mission.USAttackWaves = Mission.USAttackWaves + 1
	
	if Mission.USAttackWaves == 3 then
	
		--[[Mission.KillerFortress = GenerateObject("KillerFortress")
		
		SetSkillLevel(Mission.KillerFortress, SKILL_ELITE)
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))
		local pos = GetPosition(trg)
		pos.y = pos.y + 2000
		pos.z = pos.z + 9500
		
		PutTo(Mission.KillerFortress, pos)
		EntityTurnToEntity(Mission.KillerFortress, trg)
		
		--[[local trgPos = GetPosition(trg)
		trgPos.y = 0
		trgPos.z = trgPos.z + 35
		
		PutTo(Mission.KillerFortressTrg, trgPos)]]
		
		--SquadronSetTravelSpeed(Mission.KillerFortress, KMH(300))
		
		--PilotMoveTo(Mission.KillerFortress, trgPos)
		PilotSetTarget(Mission.KillerFortress, trg)
		Mission.KillerFortress.cvTrg = trg
		
		SetInvincible(Mission.KillerFortress, 0.3)
		
		table.insert(Mission.USAttackers, Mission.KillerFortress)
		
		if luaObj_IsActive("primary",3) then
		
			luaObj_AddUnit("primary", 3, Mission.KillerFortress)
		
		end]]
		
		--luaAddKillerFortressHitListener()
		
	else
	
		luaDelay(luaAllowNextUSWave, 63)
		
	end
	
	Mission.CanSpawnNextUSWave = false
	
end

function luaSpawnAmerican(class, wngCount, pos, equipment, spawnDelta, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = spawnpos.y + alt
	spawnpos.z = spawnpos.z + spawnDelta
	
	SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = class,
				["Name"] = "American",
				["Crew"] = Mission.USAI,
				["Race"] = USA,
				["WingCount"] = wngCount,
				["Equipment"] = equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaAmericanSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})

end

function luaAmericanSpawned(unit)

	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVGang))
	local unitPos = GetPosition(unit)
	
	SetSkillLevel(unit, Mission.SkillLevel)
	SquadronSetSpeed(unit, KMH(150))
	EntityTurnToEntity(unit, trg)
	SquadronSetTravelAlt(unit, unitPos.y, true)
	PilotSetTarget(unit, trg)
	UnitSetFireStance(unit, 2)
	
	table.insert(Mission.USAttackers, unit)
	
	if luaObj_IsActive("primary",3) then
	
		luaObj_AddUnit("primary", 3, unit)
	
	end
	
	if not Mission.FinalMovieSet then
		
		--Mission.MovieAttacker = unit
		
		luaDelay(luaPh3Movie, 2)
		--luaPh3Movie(unit)
		
		Mission.FinalMovieSet = true
	
	end
	
end

function luaAllowNextUSWave()

	Mission.CanSpawnNextUSWave = true

end

---- PHASE 2 ----

function luaSpawnB17s()

	Mission.B17s = {}
		table.insert(Mission.B17s, GenerateObject("B-17 01"))
		table.insert(Mission.B17s, GenerateObject("B-17 02"))
	
	for idx,unit in pairs(Mission.B17s) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		UnitHoldFire(unit)
		AAEnable(unit, false)
		PilotLand(unit, Mission.AF2)
		
	end
	
	--luaAddB17Listener()
	
end

function luaPh2EndMovie()
	
	Mission.MissionPhase = 2.5
	
	if table.getn(luaRemoveDeadsFromTable(Mission.JapAttackers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapAttackers)) do
			
			if unit and not unit.Dead then
			
				Kill(unit, true)
				
			end
			
		end
	
	end
	
	--[[if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end]]
	
	--[[local debrisTbl = {
	
		[1] = {GetPosition(FindEntity("Debris1_1")), GetPosition(FindEntity("Debris1_2")),},
		[2] = {GetPosition(FindEntity("Debris2_1")), GetPosition(FindEntity("Debris2_2")),},
	
	}]]
	
	--[[for i = 1, 6 do
		
		local pt = GenerateObject("PT")
		--[[local bbPos = GetPosition(luaPickRnd(Mission.BBRowGang))
		local bbRot = GetRotation(luaPickRnd(Mission.BBRowGang))
		
		local bruh = random(1,2)
		
		local deltaX
		local deltaY
		
		if bruh == 1 then
		
			deltaX = random(120,300)
			deltaY = random(-200,200)
		
		elseif bruh == 2 then
		
			deltaX = random(-200,200)
			deltaY = random(-120,-300)
		
		end
		
		bbPos.x = bbPos.x + deltaX
		bbPos.z = bbPos.z + deltaY]]
		
		local pos = GetPosition(Mission.HarborCenter)
		pos.x = pos.x + random(-1000,1000)
		pos.y = 0
		pos.z = pos.z + random(-1000,1000)
		
		PutTo(pt, pos)
		AddDamage(pt, 9999)
		
	end]]
	
	Blackout(false, "", 1)
	
	local trg1 = luaPickRnd(Mission.BBRowGang)
	local trg2 = luaPickRnd(Mission.BBRowGang)
	local trg3 = luaPickRnd(Mission.BBRowGang)
	
	Mission.MusicAction = false
	
	luaDelay(luaGovernorDia, 5)
	
	luaIngameMovie(
	{
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 20, ["moveTime"] = 5},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 10, ["rho"] = 220, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 10, ["rho"] = 220, ["moveTime"] = 6},
	 
	 {["postype"] = "cameraandtarget", ["target"] = Mission.Enterprise, ["distance"] = 200, ["theta"] = 7, ["rho"] = 135, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = Mission.Enterprise, ["distance"] = 200, ["theta"] = 7, ["rho"] = 135, ["moveTime"] = 6},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 45, ["rho"] = 167, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 200, ["theta"] = 45, ["rho"] = 167, ["moveTime"] = 9},
	 {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 1475, ["theta"] = 45, ["rho"] = 167, ["moveTime"] = 7},
	 {["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 1475, ["theta"] = 45, ["rho"] = 167, ["moveTime"] = 8},
	 
	}, luaPh2EndMovieEnd, true)
	
end

function luaPh2EndMovieEnd()

	--Blackout(true, "luaMoveToPh3", 3)
	
	luaMissionComplete()

end

function luaGovernorDia()

	luaStartDialog("Governor")

end

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapGang)) do
		
		if unit and not unit.Dead then
		
			Kill(unit, true)
			
		end
		
	end
	
	--[[UnloadClass(496)	 -- Taiho
	UnloadClass(52) 	-- Hiryu
	UnloadClass(53) 	-- Soryu
	UnloadClass(491)	 -- Zuikaku
	UnloadClass(59) 	-- Yamato
	UnloadClass(60) 	-- Kongo
	UnloadClass(481)	 -- Zao
	UnloadClass(14)		 -- Akizuki]]
	
	--PrepareClass(113)
	--PrepareClass(466)	 -- Colorado
	--PrepareClass(467) 	-- New Mexico
	--PrepareClass(468) 	-- Pennsylvania
	
	--[[Mission.BBRowTypes = {}
		table.insert(Mission.BBRowTypes, 467)
		table.insert(Mission.BBRowTypes, 467)
		table.insert(Mission.BBRowTypes, 468)
		table.insert(Mission.BBRowTypes, 466)
		table.insert(Mission.BBRowTypes, 466)
		table.insert(Mission.BBRowTypes, 468)
		table.insert(Mission.BBRowTypes, 466)
		table.insert(Mission.BBRowTypes, 468)
	
	Mission.BBRowNames = {}
		table.insert(Mission.BBRowNames, "USS California")
		table.insert(Mission.BBRowNames, "USS Tennessee")
		table.insert(Mission.BBRowNames, "USS Oklahoma")
		table.insert(Mission.BBRowNames, "USS Maryland")
		table.insert(Mission.BBRowNames, "USS Utah")
		table.insert(Mission.BBRowNames, "USS Nevada")
		table.insert(Mission.BBRowNames, "USS West Virginia")
		table.insert(Mission.BBRowNames, "USS Arizona")
	
	local california = {["Type"] = Mission.BBRowTypes[1], ["Name"] = "California", ["GuiName"] = Mission.BBRowNames[1], ["Race"] = USA}
	local tennessee = {["Type"] = Mission.BBRowTypes[2], ["Name"] = "Tennessee", ["GuiName"] = Mission.BBRowNames[2], ["Race"] = USA}
	local oklahoma = {["Type"] = Mission.BBRowTypes[3], ["Name"] = "Oklahoma", ["GuiName"] = Mission.BBRowNames[3], ["Race"] = USA}
	local maryland = {["Type"] = Mission.BBRowTypes[4], ["Name"] = "Maryland", ["GuiName"] = Mission.BBRowNames[4], ["Race"] = USA}
	local utah = {["Type"] = Mission.BBRowTypes[5], ["Name"] = "Utah", ["GuiName"] = Mission.BBRowNames[5], ["Race"] = USA}
	local nevada = {["Type"] = Mission.BBRowTypes[6], ["Name"] = "Nevada", ["GuiName"] = Mission.BBRowNames[6], ["Race"] = USA}
	local westvirginia = {["Type"] = Mission.BBRowTypes[7], ["Name"] = "West Virginia", ["GuiName"] = Mission.BBRowNames[7], ["Race"] = USA}
	local arizona = {["Type"] = Mission.BBRowTypes[8], ["Name"] = "Arizona", ["GuiName"] = Mission.BBRowNames[8], ["Race"] = USA}
	
	local shipTable = {california, tennessee, oklahoma, maryland, utah, nevada, westvirginia, arizona}]]
	
	--[[for idx,ship in pairs(shipTable) do
		
		local lookAt
		
		if idx == 1 then
		
			lookAt = GetPosition(Mission.BBRowPos0)
		
		else
		
			lookAt = GetPosition(Mission.BBRowPos[idx - 1])
		
		end
		
		luaSpawnShip(ship, GetPosition(Mission.BBRowPos[idx]), lookAt, PARTY_ALLIED)
		
	end]]
	
	Mission.AF1 = FindEntity("Airfield 01")
	Mission.AF2 = FindEntity("Airfield 02")
	
	Mission.Arizona = GenerateObject("Arizona")
	Mission.WestVirginia = GenerateObject("West Virginia")
	Mission.Nevada = GenerateObject("Nevada")
	Mission.Utah = GenerateObject("Utah")
	Mission.Maryland = GenerateObject("Maryland")
	Mission.Oklahoma = GenerateObject("Oklahoma")
	Mission.Tennessee = GenerateObject("Tennessee")
	Mission.California = GenerateObject("California")
	
	--[[SetInvincible(Mission.Arizona, 0.01)
	SetInvincible(Mission.WestVirginia, 0.01)
	SetInvincible(Mission.Nevada, 0.01)
	SetInvincible(Mission.Utah, 0.01)
	SetInvincible(Mission.Maryland, 0.01)
	SetInvincible(Mission.Oklahoma, 0.01)
	SetInvincible(Mission.Tennessee, 0.01)
	SetInvincible(Mission.California, 0.01)
	SetInvincible(Mission.Enterprise, 0.01)]]
	
	Mission.Phoenix = FindEntity("Phoenix")
	Mission.Monaghan = FindEntity("Shaw")
	
	Mission.HospitalShip = FindEntity("Vestal")
	
	Mission.RadioStation = FindEntity("DLRadioTower 01")
	
	Mission.BBRowGang = {}
		table.insert(Mission.BBRowGang, Mission.Arizona)
		table.insert(Mission.BBRowGang, Mission.WestVirginia)
		table.insert(Mission.BBRowGang, Mission.Nevada)
		table.insert(Mission.BBRowGang, Mission.Utah)
		table.insert(Mission.BBRowGang, Mission.Maryland)
		table.insert(Mission.BBRowGang, Mission.Oklahoma)
		table.insert(Mission.BBRowGang, Mission.Tennessee)
		table.insert(Mission.BBRowGang, Mission.California)
	
	for idx,unit in pairs(Mission.BBRowGang) do
		
		--JoinFormation(unit, Mission.BBRowGang[8])
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		--NavigatorMoveOnPath(unit, FindEntity("PHMovingInPathSouth"), PATH_FM_SIMPLE)
		--NavigatorMoveToPos(unit, Mission.HarborEntrance)
		SetShipMaxSpeed(unit, 3)
		
	end
	
	Mission.CapitalShipGang = {}
		table.insert(Mission.CapitalShipGang, FindEntity("Enterprise"))
		table.insert(Mission.CapitalShipGang, FindEntity("Lexington"))
		table.insert(Mission.CapitalShipGang, FindEntity("Arizona"))
		table.insert(Mission.CapitalShipGang, FindEntity("West Virginia"))
		table.insert(Mission.CapitalShipGang, FindEntity("Nevada"))
		table.insert(Mission.CapitalShipGang, FindEntity("Utah"))
		table.insert(Mission.CapitalShipGang, FindEntity("Maryland"))
		table.insert(Mission.CapitalShipGang, FindEntity("Oklahoma"))
		table.insert(Mission.CapitalShipGang, FindEntity("Tennessee"))
		table.insert(Mission.CapitalShipGang, FindEntity("California"))
	
	for idx,unit in pairs(Mission.CapitalShipGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		
	end
	
	Mission.LesserShipGang = {}
		table.insert(Mission.LesserShipGang, FindEntity("Phoenix"))
		table.insert(Mission.LesserShipGang, FindEntity("Sacramento"))
		--table.insert(Mission.LesserShipGang, FindEntity("Raleigh"))
		table.insert(Mission.LesserShipGang, FindEntity("Downes"))
		table.insert(Mission.LesserShipGang, FindEntity("Cassin"))
		table.insert(Mission.LesserShipGang, FindEntity("Shaw"))
	
	for idx,unit in pairs(Mission.LesserShipGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		
	end
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Whitney"))
		--table.insert(Mission.CargoGang, FindEntity("Castor"))
		--table.insert(Mission.CargoGang, FindEntity("Antares"))
		table.insert(Mission.CargoGang, FindEntity("Neosho"))
		table.insert(Mission.CargoGang, FindEntity("Medusa"))
		table.insert(Mission.CargoGang, FindEntity("Vestal"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 157"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 156"))
		--table.insert(Mission.CargoGang, FindEntity("LST No. 158"))
		--table.insert(Mission.CargoGang, FindEntity("LST No. 256"))
		--table.insert(Mission.CargoGang, FindEntity("LST No. 257"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 258"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 290"))
		--table.insert(Mission.CargoGang, FindEntity("LST No. 291"))
		--table.insert(Mission.CargoGang, FindEntity("LST No. 292"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 122"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 123"))
		table.insert(Mission.CargoGang, FindEntity("LST No. 124"))
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		
	end
	
	Mission.LSTGang = {}
		table.insert(Mission.LSTGang, FindEntity("LST No. 157"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 156"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 158"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 256"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 257"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 258"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 290"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 291"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 292"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 122"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 123"))
		table.insert(Mission.LSTGang, FindEntity("LST No. 124"))
	
	Mission.SubGang = {}
		table.insert(Mission.SubGang, FindEntity("Tautog"))
		table.insert(Mission.SubGang, FindEntity("Cachalot"))
	
	for idx,unit in pairs(Mission.SubGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		RepairEnable(unit, false)
		
	end
	
	Mission.PTGang = {}
	
	local PTNames = {
		
		[1] = "PT-20",
		[2] = "PT-21",
		[3] = "PT-22",
		[4] = "PT-24",
		
	}
	
	local paths = {FindEntity("pt_path1"),FindEntity("pt_path2"),FindEntity("pt_path3"),FindEntity("pt_path4")}
	
	for idx,path in pairs(paths) do
		
		local pathTbl = FillPathPoints(path)
		local pt = GenerateObject("PT", PTNames[idx])
		local rescue = GenerateObject("Rescue")
		
		SetGuiName(pt, PTNames[idx])
		table.insert(Mission.PTGang, pt)
		AAEnable(pt, false)
		
		if idx > 1 and idx < 4 then
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
		else
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
		end
		
	end
	
	--local bruh = GenerateObject("Rescue")
	--NavigatorMoveOnPath(bruh, FindEntity("henry_path"), PATH_FM_SIMPLE, PATH_SM_JOIN, 8)
	
	--Mission.Cranes = {}
	
	Mission.GroundTargetGang = {}
		table.insert(Mission.GroundTargetGang, FindEntity("Neosho"))
		table.insert(Mission.GroundTargetGang, FindEntity("Medusa"))
		table.insert(Mission.GroundTargetGang, FindEntity("Vestal"))
		--table.insert(Mission.GroundTargetGang, FindEntity("Castor"))
		--table.insert(Mission.GroundTargetGang, FindEntity("Antares"))
		table.insert(Mission.GroundTargetGang, FindEntity("Whitney"))
		
	--[[Mission.PlaneGang = {}
		
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Static warhawk") or string.find(unit.Name, "Static B")) then
			
			table.insert(Mission.GroundTargetGang, unit)
			table.insert(Mission.PlaneGang, unit)
			
		end
		
		--[[if not unit.Dead and string.find(unit.Name, "Crane ") then
			
			table.insert(Mission.Cranes, unit)
			
		end]]
		
	end]]
	
	Mission.USUnits = luaSumTablesIndex(Mission.CapitalShipGang, Mission.LesserShipGang, Mission.CargoGang, Mission.SubGang)
	Mission.USShips = luaSumTablesIndex(Mission.CapitalShipGang, Mission.LesserShipGang, Mission.CargoGang, Mission.SubGang)
	
	luaAddUSHitListener()
	
	--luaSpawnNextAttackWave()
	
	Mission.Phase2Forming = true
	
	luaDelay(luaPh2Counter, 1)
	luaDelay(luaSpawnB17s, 40)
	luaDelay(luaCheckPanic, 200)
	luaDelay(luaSpawnMiniSub, 200)
	
	Loading_Finish()

end

function luaPh2Movie(unit)
	
	Blackout(false, "", 1)
	
	Mission.MovieUnit = unit
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 5, ["rho"] = 200, ["moveTime"] = 6},
	  
	  {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 50, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 10},
	  {["postype"] = "cameraandtarget", ["position"]= {
	  		["terrainavoid"] = false,
	  		["parentID"]= unit.ID,
	  		["modifier"] = {
	  		["name"] = "gamecamera",
	  		},
	  	},["moveTime"] = 5
	  },
	  
	}, luaPh2MovieEnd, true)
	
	luaDelay(luaPlaneDia, 1.5)
	
end

function luaPlaneDia()

	luaStartDialog("Intro3")

end

function luaPh2MovieEnd()
	
	--ForceEnableInput(IC_MAP_TOGGLE, true)
	
	HideScoreDisplay(1,0)
	
	SetSelectedUnit(Mission.MovieUnit)
	
	--luaAddSecondObjs()
	
	luaDelay(luaKillOffJaps, 25)
	luaDelay(luaApproachingDia, 16)
	--luaDelay(luaCheckPlaneType, 35)
	--luaDelay(luaAddCraneObjs, 50)
	
end

function luaCheckPanic()

	if not Mission.USPanic then
	
		luaGeneratePanicTraffic()
		
		Mission.USPanic = true
	
	end

end

function luaGeneratePanicTraffic()
	
	--[[local PTNames = {
		
		[1] = "PT-25",
		[2] = "PT-26",
		[3] = "PT-27",
		[4] = "PT-28",
		
	}
	
	local paths = {FindEntity("pt_path1"),FindEntity("pt_path2"),FindEntity("pt_path3"),FindEntity("pt_path4")}
	
	for idx,path in pairs(paths) do
		
		local pathTbl = FillPathPoints(path)
		local pt = GenerateObject("PT", PTNames[idx])
		local rescue = GenerateObject("Rescue")
		
		--SetRoleAvailable(pt, EROLF_ALL, PLAYER_AI)
		SetGuiName(pt, PTNames[idx])
		table.insert(Mission.PTGang, pt)
		AAEnable(pt, true)
		
		--SetRoleAvailable(rescue, EROLF_ALL, PLAYER_AI)
		
		if idx > 1 and idx < 4 then
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
		else
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
		end
		
	end]]
	
	luaAddEfx()
	
	luaDelay(luaInitFirstRunners, 60)
	luaDelay(luaInitSecondRunners, 120)
	luaDelay(luaInitThirdRunners, 150)
	
	luaStartDialog("PearlTraffic1")
	
end

function luaInitFirstRunners()
	
	if FindEntity("Neosho") and not FindEntity("Neosho").Dead then
	
		NavigatorMoveOnPath(FindEntity("Neosho"), FindEntity("NeoshoPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
	
	end
	
	if FindEntity("Shaw") and not FindEntity("Shaw").Dead then
	
		NavigatorMoveOnPath(FindEntity("Shaw"), FindEntity("pt_path3"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	end
	
	local pickedRunner1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.LSTGang))
	local pickedRunner2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.LSTGang))
	local pickedRunner3 = luaPickRnd(luaRemoveDeadsFromTable(Mission.LSTGang))
	
	if pickedRunner1 and not pickedRunner1.Dead then
	
		NavigatorMoveToPos(pickedRunner1, Mission.HarborEscape)
		
	end
	
	if pickedRunner2 and not pickedRunner2.Dead then
	
		NavigatorMoveToPos(pickedRunner2, Mission.HarborEscape)
	
	end
	
	if pickedRunner3 and not pickedRunner3.Dead then
	
		NavigatorMoveToPos(pickedRunner3, Mission.HarborEscape)
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.PTGang)) do
		
		if unit and not unit.Dead then
		
			AAEnable(unit, true)
		
		end
		
	end
	
	local pickedShip1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	local pickedShip2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	
	AAEnable(pickedShip1, true)
	AAEnable(pickedShip2, true)
	
	luaStartDialog("PearlTraffic2")
	
	if Mission.HospitalShip and not Mission.HospitalShip.Dead then
	
		luaAddHospitalHitListener()
	
	end
	
end

function luaInitSecondRunners()
	
	if FindEntity("Whitney") and not FindEntity("Whitney").Dead then
	
		NavigatorMoveOnPath(FindEntity("Whitney"), FindEntity("pt_path4"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SubGang)) do
		
		if unit and not unit.Dead then
			
			AAEnable(unit, true)
		
		end
		
	end
	
	local a = luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	--local aa = luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	
	AAEnable(a, true)
	--AAEnable(aa, true)
	
	local pickedShip1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.LesserShipGang))
	local pickedShip2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	local pickedShip3 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	local pickedShip4 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	local pickedShip5 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	--local pickedShip6 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	--local pickedShip7 = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	
	AAEnable(pickedShip1, true)
	AAEnable(pickedShip2, true)
	AAEnable(pickedShip3, true)
	AAEnable(pickedShip4, true)
	AAEnable(pickedShip5, true)
	--AAEnable(pickedShip6, true)
	--AAEnable(pickedShip7, true)
	
end

function luaInitThirdRunners()
	
	--luaSinkRaleigh()
	
	if FindEntity("Enterprise") and not FindEntity("Enterprise").Dead then
	
		NavigatorMoveToPos(FindEntity("Enterprise"), Mission.HarborEscape)
	
	end
	
	--luaDelay(luaSinkRaleigh, 30)
	
	luaStartDialog("PearlTraffic3")
	
end

--[[function luaSinkRaleigh()
	
	if FindEntity("New Orleans") and not FindEntity("New Orleans").Dead then
	
		DisablePhysics(FindEntity("New Orleans"))
		
		local trTbl = {["x"] = 0, ["y"] = -10, ["z"] = 200}
		local rotTbl = {["x"] = -0.2, ["y"] = 0, ["z"] = 1}
		
		AddMatrixInterpolator(FindEntity("New Orleans"), trTbl, rotTbl, 20)
	
	end
	
end]]

function luaAddEfx()

	luaDelay(luaInitFirstEfx, 60)
	--luaDelay(luaInitSecondEfx, 185)
	--luaDelay(luaInitThirdEfx, 115)

end

function luaInitFirstEfx()
	
	if table.getn(Mission.SmokePoints) > 0 then
	
		local point = luaPickRnd(Mission.SmokePoints)
		
		local efx = Effect("GiantSmoke", GetPosition(point))
		
		for idx,point2 in pairs(Mission.SmokePoints) do
			
			if point == point2 then
			
				table.remove(Mission.SmokePoints, idx)
			
				break
			
			end
			
		end
		
		table.insert(Mission.Efx, efx)
		
		luaDelay(luaInitFirstEfx, 20)
		
	end
	
	--[[if table.getn(Mission.FirePoints) > 0 then
	
		local point = luaPickRnd(Mission.FirePoints)
		
		local efx = Effect("BigFire", GetPosition(point))
		
		for idx,point2 in pairs(Mission.FirePoints) do
			
			if point == point2 then
			
				table.remove(Mission.FirePoints, idx)
			
				break
			
			end
			
		end
		
		table.insert(Mission.Efx, efx)
		
	end]]

end

--[[function luaInitSecondEfx()

	for idx,point in pairs(Mission.FirePoints) do
		
		local efx

		if not Mission.BigFire then
			
			efx = Effect("BigFire", GetPosition(point))
			
			Mission.BigFire = true
			
		else
			
			efx = Effect("BigFire", GetPosition(point))
		
		end
		
	end

end]]

--[[function luaInitThirdEfx()
	
	for i = 1,4 do
	
		local efx1 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke1")))
		local efx2 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke2")))
		local efx2 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke3")))
	
	end
	
	--[[local debrisTbl = {
	
		[1] = {GetPosition(FindEntity("Debris1_1")), GetPosition(FindEntity("Debris1_2")),},
		[2] = {GetPosition(FindEntity("Debris2_1")), GetPosition(FindEntity("Debris2_2")),},
	
	}

	for idx,tbl in pairs(debrisTbl) do
		
		TempAddFloatsam({
			["topBox"] = {
				["minCorner"] = tbl[1],
				["maxCorner"] = tbl[2],
			},
			["buoyClassNames"] = { "Debrish_01", "Debrish_02", "Debrish_03", "Debrish_04", "Vizihulla_01", "Vizihulla_02", "Mentoov", "Box", },
			["buoyTypeWeights"] = { 3, 3, 3, 3, 2, 2, 1, 2, },
			["buoyGap"] = 40,
			["buoyDev"] = 20,
		})
	
	end]]

end]]

--[[function luaCheckPlaneType()

	local selUnit = GetSelectedUnit()
	
	if selUnit and not selUnit.Dead then
	
		if selUnit.Class.ID == 163 then
		
			luaStartDialog("Intro_torper")
			
		elseif selUnit.Class.ID == 159 then
		
			luaStartDialog("Intro_Diver")
		
		end
	
	end
	
end]]

function luaSpawnMiniSub()

	Mission.MiniSub1 = GenerateObject("MiniSub1")
	
	local unitpos1 = GetPosition(FindEntity("MiniSubSpawn"))
	unitpos1.x = unitpos1.x + 0
	unitpos1.y = unitpos1.y - 30
	unitpos1.z = unitpos1.z + 0
	
	PutTo(Mission.MiniSub1, unitpos1)
	
	SetShipMaxSpeed(Mission.MiniSub1, 15)
	SetUnlimitedAirSupply(Mission.MiniSub1, true)
	SetSubmarineDepthLevel(Mission.MiniSub1, 1)
	--ForceSubmarinePeriscope(Mission.MiniSub1, true)
	--SetSubmarineUseSubSurfaces(Mission.MiniSub1, false)
	SetForcedReconLevel(Mission.MiniSub1, 2, PARTY_ALLIED)
	SetSkillLevel(Mission.MiniSub1, Mission.SkillLevelOwn)
	SetRoleAvailable(Mission.MiniSub1, EROLF_ALL, PLAYER_AI)
	
	Mission.MiniSub2 = GenerateObject("MiniSub2")
	
	local unitpos2 = GetPosition(FindEntity("MiniSubSpawn"))
	unitpos2.x = unitpos2.x + 0
	unitpos2.y = unitpos2.y - 30
	unitpos2.z = unitpos2.z - 100
	
	PutTo(Mission.MiniSub2, unitpos2)
	
	SetShipMaxSpeed(Mission.MiniSub2, 15)
	SetUnlimitedAirSupply(Mission.MiniSub2, true)
	SetSubmarineDepthLevel(Mission.MiniSub2, 1)
	--ForceSubmarinePeriscope(Mission.MiniSub2, true)
	--SetSubmarineUseSubSurfaces(Mission.MiniSub2, false)
	SetForcedReconLevel(Mission.MiniSub2, 2, PARTY_ALLIED)
	SetSkillLevel(Mission.MiniSub2, Mission.SkillLevelOwn)
	SetRoleAvailable(Mission.MiniSub2, EROLF_ALL, PLAYER_AI)
	
	NavigatorAttackMove(Mission.MiniSub1, luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang)))
	NavigatorAttackMove(Mission.MiniSub2, luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang)))
	--UnitSetFireStance(Mission.MiniSub1, 2)
	--UnitSetFireStance(Mission.MiniSub2, 2)
	
	table.insert(Mission.MiniSubGang, Mission.MiniSub1)
	table.insert(Mission.MiniSubGang, Mission.MiniSub2)
	
	luaAddMiniSubObjs()
	
end

function luaKillOffJaps()
	
	if Mission.MissionPhase == 2 then
	
		if table.getn(luaRemoveDeadsFromTable(Mission.RetreatingJaps)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.RetreatingJaps)) do
				
				if unit and not unit.Dead then
				
					Kill(unit, true)
				
				end
				
			end
		
		end
	
		luaDelay(luaKillOffJaps, 25)
	
	end
	
end

function luaPh2Counter()

	if Mission.MissionPhase == 2 then
	
		Mission.Ph2Counter = Mission.Ph2Counter - 1
		
		luaDelay(luaPh2Counter, 1)
		
	end

end

--[[function luaSpawnShip(shipTable, pos, lookAt, party)
	
	SpawnNew({
		["party"] = party,
		["groupMembers"] = shipTable,
		["area"] = {
			["refPos"] = pos,
			["angleRange"] = {-1, 1},
			["lookAt"] = lookAt,
		},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 150,
		},
		["callback"] = "luaShipSpawned",
	})

end

function luaShipSpawned(unit)
	
	SetSkillLevel(unit, Mission.SkillLevel)
	SetShipMaxSpeed(unit, 5)
	AAEnable(unit, false)

end]]

function luaSpawnNextAttackWave()
	
	if Mission.Phase2Forming then
	
		Mission.Phase2Forming = false
	
	end
	
	--if Mission.AttackWaves < 5 then
		
		--MissionNarrative("bruh")
		
		while table.getn(Mission.NextAttackWavePlanes) < Mission.JapAttackerNum do
			
			local planeTypes = {322, 163, 159}
			local pickedPlane = luaPickRnd(planeTypes)
			local pickedAmmo
			
			if pickedPlane == 322 then
			
				pickedAmmo = random(0, 1)
				
			elseif pickedPlane == 163 then
			
				pickedAmmo = random(1, 2)
			
			elseif pickedPlane == 159 then
			
				pickedAmmo = 1
			
			end
			
			table.insert(Mission.NextAttackWavePlanes, pickedPlane)
			table.insert(Mission.NextAttackWaveAmmos, pickedAmmo)
		
		end
		
		local spawnDeltaX = 1500
		local spawnDeltaY = -1000
		
		for i = 1, Mission.JapAttackerNum do
			
			if Mission.NextAttackWavePlanes[i] == 163 then
			
				if Mission.NextAttackWaveAmmos[i] == 1 then
				
					Mission.NextAttackWaveAmmos[i] = 2
					
				elseif Mission.NextAttackWaveAmmos[i] == 2 then
				
					Mission.NextAttackWaveAmmos[i] = 1
				
				end
			
			end
			
			luaSpawnJap(Mission.NextAttackWavePlanes[i], 3, GetPosition(Mission.JapPh2Spawn), Mission.NextAttackWaveAmmos[i], spawnDeltaY, 0, spawnDeltaX)
			
			if spawnDeltaX <= -500 then
			
				spawnDeltaX = 1500
				spawnDeltaY = spawnDeltaY + 1000
				
			else
			
				spawnDeltaX = spawnDeltaX - 500
			
			end
			
		end
		
		for idx,plane in pairs(Mission.NextAttackWavePlanes) do
			
			table.remove(Mission.NextAttackWavePlanes, idx)
			table.remove(Mission.NextAttackWaveAmmos, idx)
			
		end
		
		Mission.AttackWaves = Mission.AttackWaves + 1
		Mission.Ph2Counter = Mission.Ph2AttackWaveDelay
		
		--[[if luaObj_IsActive("primary",2) then
		
			MissionNarrative("A new attack wave has arrived!")
		
		end]]
		
		--luaDelay(luaSpawnNextAttackWave, 120)
		
	--end
	
end

function luaSpawnJap(class, wngCount, pos, equipment, spawnDelta, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = spawnpos.y + alt
	spawnpos.z = spawnpos.z + spawnDelta
	
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = class,
				["Name"] = "Jap",
				["Crew"] = Mission.JapAI,
				["Race"] = Japan,
				["WingCount"] = wngCount,
				["Equipment"] = equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaJapSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})

end

function luaJapSpawned(unit)
	
	--if Mission.MissionPhase == 2 then
	
		local unitClass = unit.Class.ID
		local unitAmmo = GetProperty(unit, "ammoType")
		local unitPos = GetPosition(unit)
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		EntityTurnToEntity(unit, Mission.HarborCenter)
		SquadronSetTravelAlt(unit, unitPos.y, true)
		
		SquadronSetSpeed(unit, KMH(150))
		
		if unitClass == 322 then
		
			if unitAmmo == 0 then
			
				luaStrafe(unit)
			
			elseif unitAmmo == 1 then
			
				luaBomb(unit)
			
			end
		
		elseif unitClass == 163 then
			
			if unitAmmo == 0 then
			
				luaStrafe(unit)
			
			elseif unitAmmo == 1 then
			
				luaTorpedo(unit)
				
			elseif unitAmmo == 2 then
			
				luaBomb(unit)
			
			end
			
		elseif unitClass == 159 then
			
			if unitAmmo == 0 then
			
				luaStrafe(unit)
			
			elseif unitAmmo == 1 or unitAmmo == 2 then
			
				luaBomb(unit)
				
			end
		
		end
		
		--[[for idx,cv in pairs(Mission.CVGang) do
			
			SquadronSetBaseUnsupported(unit, cv)
			
		end]]
		
		table.insert(Mission.JapAttackers, unit)
		
		if not Mission.FirstFighterSet then
			
			luaPh2Movie(unit)
			
			Mission.FirstFighterSet = true
		
		end
	
	
	--[[elseif Mission.MissionPhase == 3 then
		
		local trgcv = luaPickRnd(Mission.CVGang)
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		EntityTurnToEntity(unit, trgcv)
		PilotLand(unit, trgcv)]]
	
	--end
	
end

function luaStrafe(unit)
	
	if table.getn(luaRemoveDeadsFromTable(Mission.GroundTargetGang)) > 0 then
	
		PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.GroundTargetGang)))
		
	else
		
		PilotMoveToRange(unit, Mission.HarborCenter)
	
	end
	
	UnitSetFireStance(unit, 2)
	
end

function luaTorpedo(unit)
	
	if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) > 0 then
	
		PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.CapitalShipGang)))
		
	else
		
		PilotMoveToRange(unit, Mission.HarborCenter)
	
	end
	
	UnitSetFireStance(unit, 2)
	
end

function luaBomb(unit)

	if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) > 0 then
	
		PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.CapitalShipGang)))
		
	else
		
		PilotMoveToRange(unit, Mission.HarborCenter)
	
	end
	
	UnitSetFireStance(unit, 2)
	
end

function luaApproachingDia()

	luaStartDialog("InRange")

end

function luaTrafficDia()

	luaStartDialog("Fly_in_radio2")

end

function luaAddSecondObjs()

	luaObj_Add("primary", 2, Mission.CapitalShipGang)
	luaObj_Add("hidden", 1)
	luaObj_Add("hidden", 2)
	
	--DisplayUnitHP(Mission.CapitalShipGang, "Sink all capital ships!")
	
	Mission.MusicAction = true
	
end

function luaAddMiniSubObjs()

	luaObj_Add("secondary", 1, Mission.MiniSubGang)
	
	--[[if Mission.Monaghan and not Mission.Monaghan.Dead then
	
		NavigatorAttackMove(Mission.Monaghan, luaPickRnd(luaRemoveDeadsFromTable(Mission.MiniSubGang)))
	
	end]]
	
	luaStartDialog("Minisub_init")
	
end

--[[function luaAddCraneObjs()

	luaObj_Add("secondary", 3, Mission.Cranes)
	
end]]

function luaArizonaHit()
	
	--[[if Mission.ArizonaHits < 3 then
	
		Mission.ArizonaHits = Mission.ArizonaHits + 1
	
	else
	
		RemoveListener("hit", "ArizonaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Arizona == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		for i = 1,3 do
		
			luaBlowUp(Mission.Arizona)
		
		end
		
		local pos = {["x"]=0, ["y"] = Mission.Arizona.Class.Height+3, ["z"]=0 }
		Effect("ExplosionMagazine", pos, Mission.Arizona, 20)
		--Effect("GiantSmoke", pos, Mission.Arizona, 20)
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Arizona.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Arizona, 20)]]
		
		SetDamagedGFXLevel(Mission.Arizona, 1)
		SetDeadMeat(Mission.Arizona)
		DisablePhysics(Mission.Arizona)
		AddMatrixInterpolator(Mission.Arizona, {["x"]=0, ["y"]=-15, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-5)}, 30)
		
		luaStartDialog("Arizona_dead")
		
	--end

end

function luaWVHit()
	
	--[[if Mission.WestVirginiaHits < 3 then
	
		Mission.WestVirginiaHits = Mission.WestVirginiaHits + 1
	
	else
	
		RemoveListener("hit", "WestVirginiaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.WestVirginia == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.WestVirginia)
		
		--local pos = {["x"]=0, ["y"] = Mission.WestVirginia.Class.Height+3, ["z"]=0 }
		--Effect("GiantSmoke", pos, Mission.WestVirginia, 20)
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.WestVirginia.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.WestVirginia, 20)]]
		
		SetDamagedGFXLevel(Mission.WestVirginia, 1)
		SetDeadMeat(Mission.WestVirginia)
		DisablePhysics(Mission.WestVirginia)
		AddMatrixInterpolator(Mission.WestVirginia, {["x"]=0, ["y"]=-10, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(30),}, 45)
		
		luaStartDialog("WV_dead")
		
	--end

end

function luaNevadaHit()
	
	--[[if Mission.NevadaHits < 3 then
	
		Mission.NevadaHits = Mission.NevadaHits + 1
	
	else
	
		RemoveListener("hit", "NevadaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Nevada == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		luaBlowUp(Mission.Nevada)
		
		--[[local pos = {["x"]=0, ["y"] = Mission.Nevada.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Nevada, 20)]]
		
		--local randomposX = random(-8,8)
		--local randomposY = random(-10,10)
		--local pos2 = {["x"]=randomposX, ["y"] = Mission.Nevada.Class.Height+3, ["z"]=randomposY }
		--Effect("BigFire", pos2, Mission.Nevada, 20)
		
		SetDamagedGFXLevel(Mission.Nevada, 1)
		SetDeadMeat(Mission.Nevada)
		DisablePhysics(Mission.Nevada)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Nevada, {["x"]=0, ["y"]=-7, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, 1)
		
		luaStartDialog("Nevada_explodes")
		
	--end

end

function luaUtahHit()

	--[[if Mission.UtahHits < 3 then
	
		Mission.UtahHits = Mission.UtahHits + 1
	
	else
	
		RemoveListener("hit", "UtahHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Utah == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.Utah)
		
		--local pos = {["x"]=0, ["y"] = Mission.Utah.Class.Height+3, ["z"]=0 }
		--Effect("GiantSmoke", pos, Mission.Utah, 20)
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Utah.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Utah, 20)]]
		
		SetDamagedGFXLevel(Mission.Utah, 1)
		SetDeadMeat(Mission.Utah)
		DisablePhysics(Mission.Utah)
		local x = random(-5,35)
		AddMatrixInterpolator(Mission.Utah, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
		
		luaStartDialog("Utah_hit3")
		
	--end

end

function luaMarylandHit()
	
	--[[if Mission.MarylandHits < 3 then
	
		Mission.MarylandHits = Mission.MarylandHits + 1
	
	else
	
		RemoveListener("hit", "MarylandHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Maryland == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.Maryland)
		
		--local pos = {["x"]=0, ["y"] = Mission.Maryland.Class.Height+3, ["z"]=0 }
		--Effect("GiantSmoke", pos, Mission.Maryland, 20)
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Maryland.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Maryland, 20)]]
		
		SetDamagedGFXLevel(Mission.Maryland, 1)
		SetDeadMeat(Mission.Maryland)
		DisablePhysics(Mission.Maryland)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Maryland, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
	
	--end

end

function luaOklahomaHit()
	
	--[[if Mission.OklahomaHits < 3 then
	
		Mission.OklahomaHits = Mission.OklahomaHits + 1
	
	else
	
		RemoveListener("hit", "OklahomaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Oklahoma == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.Oklahoma)
		
		--[[local pos = {["x"]=0, ["y"] = Mission.Oklahoma.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Oklahoma, 20)]]
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Oklahoma.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Oklahoma, 20)]]
		
		SetDamagedGFXLevel(Mission.Oklahoma, 1)
		SetDeadMeat(Mission.Oklahoma)
		DisablePhysics(Mission.Oklahoma)
		local x = random(-5,35)
		AddMatrixInterpolator(Mission.Oklahoma, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
		
		luaDelay(luaOklahomaRoll, 36)
		
	--end

end

function luaOklahomaRoll()

	AddMatrixInterpolator(Mission.Oklahoma, {["x"]=0, ["y"]=-4, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(25),}, 30)
	
	luaStartDialog("Oklahoma_dead")
	
end

function luaTennesseHit()
	
	--[[if Mission.TennesseHits < 3 then
	
		Mission.TennesseHits = Mission.TennesseHits + 1
	
	else
	
		RemoveListener("hit", "TennesseHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Tennessee == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.Tennessee)
		
		--[[local pos = {["x"]=0, ["y"] = Mission.Tennessee.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Tennessee, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Tennessee.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Tennessee, 20)]]
		
		SetDamagedGFXLevel(Mission.Tennessee, 1)
		SetDeadMeat(Mission.Tennessee)
		DisablePhysics(Mission.Tennessee)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Tennessee, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
	
	--end

end

function luaCaliforniaHit()
	
	--[[if Mission.CaliforniaHits < 3 then
	
		Mission.CaliforniaHits = Mission.CaliforniaHits + 1
	
	else
	
		RemoveListener("hit", "CaliforniaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.California == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		--luaBlowUp(Mission.California)
		
		--[[local pos = {["x"]=0, ["y"] = Mission.California.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.California, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.California.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.California, 20)]]
		
		SetDamagedGFXLevel(Mission.California, 1)
		SetDeadMeat(Mission.California)
		DisablePhysics(Mission.California)
		AddMatrixInterpolator(Mission.California, {["x"]=0, ["y"]=-6, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-35)}, 10)
	
	--end

end

function luaEnterpriseHit()
	
	--[[if Mission.CaliforniaHits < 3 then
	
		Mission.CaliforniaHits = Mission.CaliforniaHits + 1
	
	else
	
		RemoveListener("hit", "CaliforniaHitListener")]]
		
		--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CapitalShipGang)) do
			
			if unit and not unit.Dead then
			
				if Mission.Enterprise == unit then
				
					table.remove(Mission.CapitalShipGang, idx)
					
					break
				
				end
			
			end
			
		end]]
		
		luaBlowUp(Mission.Enterprise)
		
		local pos = {["x"]=0, ["y"] = Mission.Enterprise.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Enterprise, 20)
		
		--[[local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Enterprise.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Enterprise, 20)]]
		
		SetDamagedGFXLevel(Mission.Enterprise, 1)
		SetDeadMeat(Mission.Enterprise)
		DisablePhysics(Mission.Enterprise)
		AddMatrixInterpolator(Mission.Enterprise, {["x"]=0, ["y"]=-10, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(30),}, 45)
	
	--end

end

---- PHASE 1 ----

function luaStartMission()
	
	Blackout(false, "", 3)
	
	luaIntroMovie1()
	
end

function luaSpawnJapFleet()

	Mission.Taiho = GenerateObject("Taiho")
	Mission.Ginryu = GenerateObject("Ginryu")
	Mission.Hiryu = GenerateObject("Hiryu")
	Mission.Soryu = GenerateObject("Soryu")
	Mission.Zuikaku = GenerateObject("Zuikaku")
	Mission.Shokaku = GenerateObject("Shokaku")
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, Mission.Taiho)
		table.insert(Mission.JapGang, Mission.Ginryu)
		table.insert(Mission.JapGang, Mission.Hiryu)
		table.insert(Mission.JapGang, Mission.Soryu)
		table.insert(Mission.JapGang, Mission.Zuikaku)
		table.insert(Mission.JapGang, Mission.Shokaku)
		table.insert(Mission.JapGang, GenerateObject("Yamato"))
		table.insert(Mission.JapGang, GenerateObject("Kirishima"))
		table.insert(Mission.JapGang, GenerateObject("Hiei"))
		--table.insert(Mission.JapGang, GenerateObject("Zao"))
		--table.insert(Mission.JapGang, GenerateObject("Senjo"))
		--table.insert(Mission.JapGang, GenerateObject("Azuma"))
		--table.insert(Mission.JapGang, GenerateObject("Yoshino"))
		table.insert(Mission.JapGang, GenerateObject("Haurugumo-class01"))
		table.insert(Mission.JapGang, GenerateObject("Haurugumo-class02"))
		table.insert(Mission.JapGang, GenerateObject("Haurugumo-class03"))
		table.insert(Mission.JapGang, GenerateObject("Akizuki-class01"))
		table.insert(Mission.JapGang, GenerateObject("Akizuki-class02"))
		table.insert(Mission.JapGang, GenerateObject("Akizuki-class03"))
		table.insert(Mission.JapGang, GenerateObject("Akizuki-class04"))
		table.insert(Mission.JapGang, GenerateObject("Hayate-class01"))
		table.insert(Mission.JapGang, GenerateObject("Hayate-class02"))
		table.insert(Mission.JapGang, GenerateObject("Hayate-class03"))
		table.insert(Mission.JapGang, GenerateObject("Hayate-class04"))
	
	for idx,unit in pairs(Mission.JapGang) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		--JoinFormation(unit, Mission.JapGang[7])
		SetShipMaxSpeed(unit, 5)
		SetInvincible(unit, 0.4)
		
	end
	
	Mission.CVGang = {}
		table.insert(Mission.CVGang, Mission.Taiho)
		table.insert(Mission.CVGang, Mission.Ginryu)
		table.insert(Mission.CVGang, Mission.Hiryu)
		table.insert(Mission.CVGang, Mission.Soryu)
		table.insert(Mission.CVGang, Mission.Zuikaku)
		table.insert(Mission.CVGang, Mission.Shokaku)
	
	for idx,unit in pairs(Mission.CVGang) do
		
		SetRoleAvailable(unit, EROLE_CAPTAIN, PLAYER_ANY)
		UnitSetPlayerCommandsEnabled(unit, PCF_NONE)
		
	end

end

function luaIntroMovie1()
	
	--luaDelay(luaIntroText, 2)
	
	local trg1 = FindEntity("Enterprise")
	local trg2 = FindEntity("Lexington")
	
	luaIngameMovie(
	{
	 
	 {["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=3,["z"]=105},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=105},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=105},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
	 
	 {["postype"] = "camera",["position"] = {["pos"] = {["x"]=80,["y"]=12,["z"]=105},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=12,["z"]=105},["parent"] = trg1,},["moveTime"] = 2,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=12,["z"]=105},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
	 
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=-15,["y"]=10,["z"]=50},["parent"] = trg1,},["moveTime"] = 8,["transformtype"] = "keepall"},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 150, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 4},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 5},
	 
	}, luaIntroMovie1End, true)
	
	luaDelay(luaIntroDia1, 4)
	
end

function luaIntroDia1()

	luaStartDialog("Intro1")

end

function luaIntroMovie1End()

	Blackout(true, "luaIntroMovie2", 1)

end

function luaIntroMovie2()
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.Ginryu
	
	MissionNarrative("A few hundred miles away...")
	
	luaIngameMovie(
	{
	 
	 {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=3,["z"]=170},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=262},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
	 {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 7},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 5},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	 
	}, luaIntroMovieEnd, true)
	
	luaDelay(luaIntroDia2, 4)
	
end

function luaIntroDia2()

	luaStartDialog("Intro2")

end

function luaIntroText()

	MissionNarrative("December 8th, 1941 - Pearl Harbor")

end

function luaIntroMovieEnd()
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Ginryu)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)
	
	--[[local line1 = "Launch the first attack wave!"
	local line2 = "Time left: #Mission.Ph1Counter#"
	luaDisplayScore(1, line1, line2)]]
	
	luaDelay(luaDecrenentPh1Counter, 1)
	
end

function luaDecrenentPh1Counter()
	
	if Mission.MissionPhase == 1 then
	
		if Mission.Ph1Counter > 0 then
		
			Mission.Ph1Counter = Mission.Ph1Counter - 1
			
			local line1 = "Launch the first attack wave!"
			local line2 = "Time left: #Mission.Ph1Counter#"
			luaDisplayScore(1, line1, line2)
			
			luaDelay(luaDecrenentPh1Counter, 1)
		
		else
		
			luaForceMovePh2()
		
		end
	
	end
	
end

function luaForceMovePh2()

	Mission.CanMoveToPh2 = true

end

---- LISTENERS ----

function luaAddHospitalHitListener()

	AddListener("hit", "HospitalHitListener", {
		["callback"] = "luaHospitalHit",
		["target"] = {Mission.HospitalShip},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

--[[function luaAddKillerFortressHitListener()

	AddListener("hit", "KillerFortressHitListener", {
		["callback"] = "luaKillerFortressHit", 
		["target"] = {Mission.KillerFortress},
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end]]

--[[function luaAddB17Listener()

	AddListener("recon", "B17Listener", {
		["callback"] = "luaB17Sighted",
		["entity"] = Mission.B17s,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end]]

--[[function luaAddB17HitListener()

	AddListener("hit", "B17HitListener", {
		["callback"] = "luaB17Hit", 
		["target"] = Mission.B17s, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end]]

function luaAddUSHitListener()

	AddListener("hit", "USHitListener", {
		["callback"] = "luaUSHit", 
		["target"] = Mission.USUnits, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end

---- LISTENER CALLBACK ----

function luaHospitalHit()

	RemoveListener("hit", "HospitalHitListener")
	
	luaStartDialog("HOSPITALHIT")

end

--[[function luaKillerFortressHit()
	
	if Mission.KillerFortressHits < 20 then
	
		Mission.KillerFortressHits = Mission.KillerFortressHits + 1
	
	else
	
		RemoveListener("hit", "KillerFortressHitListener")
		
		SetFailure(Mission.KillerFortress, "enginefire 1")
		
	end
	
end]]

--[[function luaB17Sighted()

	RemoveListener("recon", "B17Listener")
	
	luaObj_Add("secondary", 2, Mission.B17s)
	
	--luaAddB17HitListener()
	
end]]

--[[function luaB17Hit()
	
	RemoveListener("hit", "B17HitListener")
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.B17s)) do
	
		UnitFreeFire(unit)
		
	end
	
end]]

function luaUSHit()
	
	RemoveListener("hit", "USHitListener")
	
	if not Mission.USPanic then
	
		luaDelay(luaGeneratePanicTraffic, 37)

		Mission.USPanic = true
	
	end
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	--[[if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end]]
	
	if luaObj_IsActive("secondary",3) then
		
		luaObj_Failed("secondary",3)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionCompletedNew(nil, "Pearl Harbor lies in ruins - Mission Complete")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	--[[if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end]]
	
	if luaObj_IsActive("secondary",3) then
		
		luaObj_Failed("secondary",3)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionFailedNew(unit, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

function luaShowPoint(point)
	
	luaObj_Add("marker2",1)
	
	luaObj_AddUnit("marker2",1,GetPosition(point))

end

function luaShowPath(path)
	
	luaObj_Add("marker2",1)
	
	local points = FillPathPoints(path)
	
	for idx, point in pairs(points) do
	
		luaObj_AddUnit("marker2",1,point)
	
	end

end

function luaBlowUp(ship)
	
	local pos = GetPosition(ship)	
	local i = random(1,9)
	
	if i == 1 then
		pos.x = pos.x - 110	
	elseif i == 2 then
		pos.x = pos.x - 80
	elseif i == 3 then
		pos.x = pos.x - 50
	elseif i == 4 then
		pos.x = pos.x  - 20
	elseif i == 5 then
		pos.x = pos.x + 20
	elseif i == 6 then
		pos.x = pos.x + 50
	elseif i == 7 then
		pos.x = pos.x + 80
	elseif i == 8 then
		pos.x = pos.x + 110
	elseif i == 9 then
		pos.x = pos.x + 0
	else
		pos.x = pos.x + 0
	end
	
	Effect("ExplosionBigShip", pos)
	
	ExplodeToParts(ship)
	
end

function luaDistanceCounter(unit, trg, id, obj, txt)
	if unit and trg and not unit.Dead and not trg.Dead then
		local dist = luaMetric(luaGetDistance3D(unit, trg))
		Mission.Measure = GetMeasure()
		Mission.Distance = string.format("%.1f",dist)
		DisplayScores(id,0,obj,txt)

		if dist < luaMetric(1000) then
			Mission.PlayerNear = true
		end
	end
end

function luaMetric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end
end

function luaRAD(x)
	return x *  0.0174532925
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaStartDialog(dialogID, log, ignorePrinted)
	
	if Mission.EndMission then
	
		return
	
	end
	
	if type(dialogID) ~= "string" then
		error("***ERROR: luaStartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaStartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
	end
end

function luaAddPowerup(type)
	
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
	
end