---- MEET THE GERMANS (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- MEET THE GERMANS (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(26) 	-- F6F
	PrepareClass(108) 	-- SBD
	--PrepareClass(38) 	-- SB2C
	
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
	
	LoadMessageMap("ijndlg",12)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_13_germans.lua"

	this.Name = "IJN13"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Locate",
				["Text"] = "Locate the German submarine!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Land",
				["Text"] = "Land a seaplane close to the German submarine!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Surv",
				["Text"] = "Ensure the survival of both of your submarines!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Convoy",
				["Text"] = "Destroy the enemy convoy!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Hornet",
				["Text"] = "Sink the USS Hornet!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Message",
				["Text"] = "Transmit an SOS message while surfacing with the German submarine!",
				["TextCompleted"] = "The radio message has been sent!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Esc",
				["Text"] = "Sink the ASW escorts!",
				["TextCompleted"] = "All ASW escorts are sunk!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Bruh",
				["Text"] = "Sink all enemy ships in the area!",
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
		["INTRO"] = {--
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg1",
				},
				{
					["message"] = "INTRO1",
				},
			},
		},
		["QUICK"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["DDS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
				{
					["message"] = "dlg3c",
				},
			},
		},
		["REACHED"] = {--
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
				{
					["message"] = "dlg5c",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddSecObjs",
				},
			},
		},
		["LANDED"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
				{
					["message"] = "dlg6b_1",
				},
				{
					["message"] = "dlg6c",
				},
				{
					["message"] = "dlg6c_1",
				},
				{
					["message"] = "dlg6d",
				},
				{
					["message"] = "dlg6e",
				},
				{
					["message"] = "dlg6f",
				},
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddThirdObjs",
				},
			},
		},
		["WAVES"] = {--
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
				{
					["message"] = "dlg9c",
				},
				{
					["message"] = "dlg9d",
				},
				{
					["message"] = "dlg9e",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh2FadeOut",
				},
			},
		},
		["CARRIER"] = {--
			["sequence"] = {
				{
					["message"] = "CARRIER1",
				},
				{
					["message"] = "dlg9g",
				},
				{
					["message"] = "dlg9h",
				},
				{
					["message"] = "dlg9i",
				},
				{
					["message"] = "dlg10",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["MESSAGE"] = {--
			["sequence"] = {
				{
					["message"] = "MESSAGE1",
				},
				{
					["message"] = "MESSAGE1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMessageSent",
				},
			},
		},
		["INCOMING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
				{
					["message"] = "INCOMING1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddMessageObjs",
				},
			},
		},
		["FINAL1"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "dlg16",
				},
				{
					["message"] = "dlg17a",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["FINAL2"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg9b",
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
		Mission.SkillLevelOwn = SKILL_ELITE
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_ELITE
	end
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- IJN ----
	
	Mission.JapSub = FindEntity("I-111")
	Mission.GermanSub = FindEntity("U-530")
	
	Mission.Subs = {}
		table.insert(Mission.Subs, Mission.JapSub)
		table.insert(Mission.Subs, Mission.GermanSub)
	
	for idx,unit in pairs(Mission.Subs) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		
	end
	
	if Mission.Difficulty < 2 then
	
		SetCatapultStock(Mission.JapSub, 10)
	
	else
	
		SetCatapultStock(Mission.JapSub, 1)
	
	end
	
	---- USN ----
	
	Mission.FirstDDs = {}
		table.insert(Mission.FirstDDs, FindEntity("De Haven"))
	
	if Mission.Difficulty == 0 then
	
		table.insert(Mission.FirstDDs, GenerateObject("Schroeder_Easy"))
	
	else
	
		table.insert(Mission.FirstDDs, GenerateObject("Schroeder_Hard"))
	
	end
	
	for idx,unit in pairs(Mission.FirstDDs) do
		
		JoinFormation(unit, Mission.FirstDDs[2])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.Convoy = {}
		table.insert(Mission.Convoy, FindEntity("Cargo-01"))
		table.insert(Mission.Convoy, FindEntity("Cargo-02"))
		table.insert(Mission.Convoy, FindEntity("Cargo-03"))
		table.insert(Mission.Convoy, FindEntity("Cargo-04"))
		table.insert(Mission.Convoy, FindEntity("Cargo-05"))
		table.insert(Mission.Convoy, FindEntity("Cargo-06"))
		table.insert(Mission.Convoy, FindEntity("Cargo-07"))
		table.insert(Mission.Convoy, FindEntity("Cargo-08"))
		table.insert(Mission.Convoy, FindEntity("George E. Badger"))
		table.insert(Mission.Convoy, FindEntity("Pope"))
		
	for idx,unit in pairs(Mission.Convoy) do
		
		JoinFormation(unit, Mission.Convoy[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.ConvoyEsc = {}
		table.insert(Mission.ConvoyEsc, FindEntity("George E. Badger"))
		table.insert(Mission.ConvoyEsc, FindEntity("Pope"))
	
	Mission.USUnits = luaSumTablesIndex(Mission.Convoy, Mission.FirstDDs)
	
	Mission.AttackingEscorts = {}
	
	--NavigatorMoveToRange(Mission.FirstDDs[2], Mission.GermanSub)
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.AllowedAttackingEscorts = 2
		Mission.CVSlots = 0
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.AllowedAttackingEscorts = 4
		Mission.CVSlots = 1
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.AllowedAttackingEscorts = 6
		Mission.CVSlots = 2
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("June 18th, 1943 - Somewhere in the Atlantic")
	
	Blackout(true, "", true)
	
	SetSimplifiedReconMultiplier(0.8)
	
	luaMoveFirstDDs()
	
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
	
	--luaShowPath(FindEntity("HornetPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.Subs) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
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
	
		luaIntroMovie1()
		
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
		
			if Mission.CanMusicCheck then
			
				local music_selectedUnit = GetSelectedUnit()

				if music_selectedUnit then

					luaCheckMusic(music_selectedUnit)

				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) < 2 then
				
					luaMissionFailed()
				
				else
				
					Mission.JapSubStatus = string.format("%.0f",(GetHpPercentage(Mission.JapSub) * 100))
					Mission.GermanSubStatus = string.format("%.0f",(GetHpPercentage(Mission.GermanSub) * 100))
					
					local line1 = "Ensure the survival of both of your submarines!"
					local line2 = "I-111 status: #Mission.JapSubStatus#% | U-530 status: #Mission.GermanSubStatus#%"
					luaDisplayScore(3, line1, line2)
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if Mission.JapSub.Dead or Mission.GermanSub.Dead then
			
				luaMissionFailed()
			
			end
			
			if luaObj_IsActive("primary", 1) then
				
				--if not Mission.GermanSubSurfaced then
				
				if Mission.GermanSub and not Mission.GermanSub.Dead then
					
					if not Mission.GermansSetToSurface then
					
						local planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.GermanSub), 3600, PARTY_JAPANESE, "own")
						
						if planes and table.getn(luaRemoveDeadsFromTable(planes)) > 0 then
							
							SetSubmarineDepthLevel(Mission.GermanSub, 0)
							
							luaDelay(luaGermansSighted, 10)
							
							Mission.GermansSetToSurface = true
						
						end
					
					end
					
				end
				
				--end
				
			end
			
			if luaObj_IsActive("primary", 2) then
				
				if Mission.GermanSub and not Mission.GermanSub.Dead then
					
					if not Mission.SeaplaneLanded then
					
						local planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.GermanSub), 200, PARTY_JAPANESE, "own")
						
						if planes and table.getn(luaRemoveDeadsFromTable(planes)) > 0 then
							
							local ordered = luaSortByDistance(Mission.GermanSub, luaRemoveDeadsFromTable(planes))
							local closest = ordered[1]
							
							if not closest.Dead and GetPosition(closest).y < 10 and GetEntitySpeed(closest) < 13 then
							
								--HideScoreDisplay(0,0)
								CountdownCancel()
								HideScoreDisplay(2,0)
								
								if IsListenerActive("recon", "DDsListener") then
								
									RemoveListener("recon", "DDsListener")
								
								end
								
								Mission.LandedSeaplane = closest
								
								SetInvincible(Mission.LandedSeaplane, 0.01)
								
								luaObj_Completed("primary", 2)
								
								Blackout(true, "luaPh1EndMovie", 1)
								
								Mission.SeaplaneLanded = true
							
							end
							
						end
					
					end
					
				end
				
			end
			
		elseif Mission.MissionPhase == 2 then
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USUnits)) == 0 and not Mission.SetToMovePh3 then
				
					HideUnitHP()
					
					luaObj_Completed("primary", 4)
					
					luaStartDialog("WAVES")
					
					Mission.SetToMovePh3 = true
					
				end
			
			end
			
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 5) then
			
				if Mission.Hornet.Dead and not Mission.ReadyToFinish then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Subs)) do
					
						SetInvincible(unit, 0.01)
						
					end
					
					HideUnitHP()
					luaDelay(luaHidePh2Scores, 3)
					
					luaObj_Completed("primary", 5)
					luaObj_Completed("primary", 3)
					
					luaDelay(luaFinalDia, 3)
					
					Mission.ReadyToFinish = true
				
				else
					
					if Mission.Hornet and not Mission.Hornet.Dead then
					
						local stloPlaneNum, stloPlaneTable= luaGetSlotsAndSquads(Mission.Hornet)
						
						if stloPlaneNum < Mission.CVSlots and IsReadyToSendPlanes(Mission.Hornet) then
							
							local planeTypes = {
							108,
							108,
							}
							
							local plane = luaPickRnd(planeTypes)
							
							local slotIndex = LaunchSquadron(Mission.Hornet,plane,3,3)
							local launchedWildcat = thisTable[tostring(GetProperty(Mission.Hornet, "slots")[slotIndex].squadron)]
							SetSkillLevel(launchedWildcat, Mission.SkillLevel)
							
							local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
							PilotSetTarget(launchedWildcat, trg)

						end
						
						--[[local fighters = {
							[1] = 26,
						}
						local bombers = {}
						
						if Mission.Difficulty == 2 then
							
							bombers[1] = 38
							
						else
						
							bombers[1] = 108
							
						end
						
						luaAirfieldManager(Mission.Hornet, fighters, bombers, luaRemoveDeadsFromTable(Mission.Subs))]]
						
						--[[if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) > 0 then
							
							if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) < Mission.AllowedAttackingEscorts then
							
								Mission.AllowedAttackingEscorts = table.getn(luaRemoveDeadsFromTable(Mission.Escorts))
							
							end
							
							if table.getn(luaRemoveDeadsFromTable(Mission.AttackingEscorts)) < Mission.AllowedAttackingEscorts then
							
								for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Escorts)) do
									
									if unit and not unit.Dead then
										
										if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
										
											local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs))
											
											luaSetScriptTarget(unit, trg)
											NavigatorAttackMove(unit, trg)
										
										end
										
									end
									
								end
							
							end
							
						end]]
					
					end
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				if Mission.GermanSub and not Mission.GermanSub.Dead then
				
					if GetSubmarineOnSurface(Mission.GermanSub) then
						
						--if not Mission.RadioTemp then
						
							luaStartDialog("MESSAGE")
							--Mission.RadioTemp = true
							
						--end
						
					--[[else
						
						if Mission.RadioTemp then
						
							KillDialog("MESSAGE")
							Mission.RadioTemp = false
							
						end]]
						
					end
				
				end
				
			end
			
			if luaObj_IsActive("secondary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.ASWs)) == 0 then
				
					luaObj_Completed("secondary", 2, true)
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 3 ----

function luaMessageSent()

	luaObj_Completed("secondary", 1, true)
	
	luaDelay(luaReinBlackout, 210)
	Countdown("Reinforcements arrive in: ", 0, 210)
	
end

function luaReinBlackout()

	if not Mission.EndMission then
	
		Blackout(true, "luaSpawnRein", 1)
	
	end

end

function luaSpawnRein()

	Mission.Rein = {}
		table.insert(Mission.Rein, GenerateObject("Rein_1"))
		table.insert(Mission.Rein, GenerateObject("Rein_2"))
		table.insert(Mission.Rein, GenerateObject("Rein_3"))
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Rein)) do
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		
		local unitPos = GetPosition(unit)
		
		SquadronSetTravelAlt(unit, unitPos.y, true)
		
		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.HornetGrp))
		
		EntityTurnToEntity(unit, trg)
		
		PilotSetTarget(unit, trg)
	
	end
	
	Mission.Ph3MovieTrg = Mission.Rein[1]
	SetInvincible(Mission.Ph3MovieTrg, true)
	
	luaIngameMovie(
	{
	
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph3MovieTrg, ["distance"] = 15, ["theta"] = 5, ["rho"] = -200, ["moveTime"] = 0},
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph3MovieTrg, ["distance"] = 15, ["theta"] = 5, ["rho"] = -200, ["moveTime"] = 3},
	  
	  {["postype"] = "cameraandtarget", ["target"] = Mission.Ph3MovieTrg, ["distance"] = 50, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 3},
	  {["postype"] = "cameraandtarget", ["position"]= {
	  		["terrainavoid"] = false,
	  		["parentID"]= Mission.Ph3MovieTrg.ID,
	  		["modifier"] = {
	  		["name"] = "gamecamera",
	  		},
	  	},["moveTime"] = 3
	  },
	  
	}, luaReinMovieEnd, true)
	
end

function luaReinMovieEnd()
	
	if Mission.Hornet and not Mission.Hornet.Dead then
	
		if IsReadyToSendPlanes(Mission.Hornet) then
			
			local planeTypes = {
			26,
			26,
			}
			
			local plane = luaPickRnd(planeTypes)
			
			local slotIndex = LaunchSquadron(Mission.Hornet,plane,3)
			local launchedWildcat = thisTable[tostring(GetProperty(Mission.Hornet, "slots")[slotIndex].squadron)]
			SetSkillLevel(launchedWildcat, Mission.SkillLevel)
		
		end
	
	end
	
	SetSelectedUnit(Mission.Ph3MovieTrg)
	
	SetInvincible(Mission.Ph3MovieTrg, false)
	
end

function luaFinalDia()

	if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Escorts)) do
		
			if unit and not unit.Dead then
				
				UnitHoldFire(unit)
				
				NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))
			
			end
		
		end
		
		luaStartDialog("FINAL1")
		
	else
		
		luaStartDialog("FINAL2")
	
	end
	
	Mission.EndMission = true
	
end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	--[[PutTo(Mission.JapSub, {["x"]= -200, ["y"]= 0, ["z"]= 0})
	PutTo(Mission.GermanSub, {["x"]= 200, ["y"]= 0, ["z"]= 0})
	
	EntityTurnToEntity(Mission.JapSub, FindEntity("LookAt1"))
	EntityTurnToEntity(Mission.GermanSub, FindEntity("LookAt2"))
	
	SetSubmarineDepthLevel(Mission.JapSub, 0)
	SetSubmarineDepthLevel(Mission.GermanSub, 0)]]
	
	Mission.Hornet = GenerateObject("Hornet")
	
	Mission.HornetGrp = {}
		table.insert(Mission.HornetGrp, Mission.Hornet)
		table.insert(Mission.HornetGrp, GenerateObject("O'Bannon"))
		table.insert(Mission.HornetGrp, GenerateObject("Beale"))
		table.insert(Mission.HornetGrp, GenerateObject("Charrette"))
		table.insert(Mission.HornetGrp, GenerateObject("Newcomb"))
		table.insert(Mission.HornetGrp, GenerateObject("Paul Hamilton"))
		table.insert(Mission.HornetGrp, GenerateObject("Albert W. Grant"))
		
	Mission.ASWs = {}
		table.insert(Mission.ASWs, FindEntity("O'Bannon"))
		table.insert(Mission.ASWs, FindEntity("Beale"))
		
	Mission.Escorts = {}
		table.insert(Mission.Escorts, FindEntity("O'Bannon"))
		table.insert(Mission.Escorts, FindEntity("Beale"))
		table.insert(Mission.Escorts, FindEntity("Charrette"))
		table.insert(Mission.Escorts, FindEntity("Newcomb"))
		table.insert(Mission.Escorts, FindEntity("Paul Hamilton"))
		table.insert(Mission.Escorts, FindEntity("Albert W. Grant"))
		
	if Mission.Difficulty == 2 then
	
		table.insert(Mission.HornetGrp, GenerateObject("Halford_Hard"))
		table.insert(Mission.HornetGrp, GenerateObject("Thatcher_Hard"))
		
		table.insert(Mission.ASWs, FindEntity("Halford_Hard"))
		table.insert(Mission.ASWs, FindEntity("Thatcher_Hard"))
		
		table.insert(Mission.Escorts, FindEntity("Halford_Hard"))
		table.insert(Mission.Escorts, FindEntity("Thatcher_Hard"))
		
	else
	
		table.insert(Mission.HornetGrp, GenerateObject("Halford_Easy"))
		table.insert(Mission.HornetGrp, GenerateObject("Thatcher_Easy"))
		
		table.insert(Mission.Escorts, FindEntity("Halford_Easy"))
		table.insert(Mission.Escorts, FindEntity("Thatcher_Easy"))
	
	end
	
	for idx,unit in pairs(Mission.HornetGrp) do
		
		JoinFormation(unit, Mission.HornetGrp[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	if Mission.Difficulty == 0 then
	
		SetAirBaseSlotCount(Mission.Hornet, 1)
		
	elseif Mission.Difficulty == 1 then
		
		SetAirBaseSlotCount(Mission.Hornet, 2)
		
	elseif Mission.Difficulty == 2 then
		
		SetAirBaseSlotCount(Mission.Hornet, 3)
		
	end
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.HornetGrp[1], FindEntity("HornetPath"), PATH_FM_CIRCLE, pathDir)
	
	--luaDelay(luaPh3Dia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	Blackout(false, "", 1)
	
	local trg1 = Mission.HornetGrp[1]
	local trg2 = Mission.JapSub
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 150, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 50, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 5},
		
	}, luaPh3MovieEnd, true)
	
end

function luaPh3Dia()

	luaStartDialog("CARRIER")

end

function luaPh3MovieEnd()

	--[[if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else]]
	
		SetSelectedUnit(Mission.JapSub)
	
	--end
	
	luaPh3Dia()
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 5, Mission.Hornet)
	luaObj_Add("secondary", 2, Mission.ASWs)
	
	DisplayUnitHP(luaRemoveDeadsFromTable({Mission.Hornet}), "Sink the USS Hornet!")
	
	for i = 1, Mission.AllowedAttackingEscorts do
		
		NavigatorAttackMove(Mission.Escorts[i], luaPickRnd(luaRemoveDeadsFromTable(Mission.Subs)))
		
		UnitSetFireStance(Mission.Escorts[i], 2)
		
	end
	
	luaDelay(luaIncomingDia, 16)
	
end

function luaIncomingDia()

	luaStartDialog("INCOMING")

end

function luaAddMessageObjs()

	luaObj_Add("secondary", 1)

end

---- PHASE 2 ----

function luaPh2FadeOut()

	Blackout(true, "luaMoveToPh3", 3)

end

function luaHidePh2Scores()

	HideScoreDisplay(3,0)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	NavigatorStop(Mission.JapSub)
	PutTo(Mission.JapSub, {["x"]= 1000, ["y"]= -20, ["z"]= 1000})
	SetSubmarineDepthLevel(Mission.JapSub, 1)
	
	NavigatorStop(Mission.GermanSub)
	local pos2 = GetPosition(Mission.GermanSub)
	pos2.y = -20
	PutTo(Mission.GermanSub, pos2)
	SetSubmarineDepthLevel(Mission.GermanSub, 1)
	SetParty(Mission.GermanSub, PARTY_JAPANESE)
	SetRoleAvailable(Mission.GermanSub, EROLF_ALL, PLAYER_ANY)
	
	SetSelectedUnit(Mission.JapSub)
	
	luaDelay(luaPh2FadeIn, 3)
	
end

function luaPh2FadeIn()
	
	SetInvincible(Mission.LandedSeaplane, false)
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Convoy)) do
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Blackout(false, "", 1)

end

function luaAddThirdObjs()

	luaObj_Add("primary", 4, Mission.USUnits)
	luaObj_Add("primary", 3)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.USUnits), "Destroy the enemy convoy!")
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.FirstDDs)) do
	
		if unit and not unit.Dead then
			
			local trg = Mission.Subs[idx]
			
			if trg and not trg.Dead then
			
				NavigatorAttackMove(unit, trg)
			
			end
			
		end
	
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ConvoyEsc)) do
	
		if unit and not unit.Dead then
			
			local trg = Mission.Subs[idx]
			
			if trg and not trg.Dead then
			
				NavigatorAttackMove(unit, trg)
			
			end
			
		end
	
	end
	
end

---- PHASE 1 ----

function luaGermansSighted()

	HideScoreDisplay(1,0)
	
	luaObj_Completed("primary", 1)
	
	luaStartDialog("REACHED")

end

function luaPh1EndMovie()
	
	luaDelay(luaLandedDia, 2)
	
	Blackout(false, "", 1)
	
	luaDelay(luaPh1FadeOut, 14)
	
	local trg1 = Mission.GermanSub
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 120, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 15},
		
	}, nil, true)

end

function luaLandedDia()

	luaStartDialog("LANDED")

end

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 2)

end

function luaAddSecObjs()

	luaObj_Add("primary", 2, GetPosition(Mission.GermanSub))
	
	local line1 = "Land a seaplane close to the German submarine!"
	local line2 = ""
	luaDisplayScore(2, line1, line2)
	
end

function luaMoveFirstDDs()
	
	PutTo(Mission.GermanSub, {["x"]= luaRnd(3300, 4800), ["y"]= -20, ["z"]= luaRnd(3300, 4800)})
	
	local moveIdx = 2
	local moveX
	local moveY
	
	if moveIdx == 1 then
	
		moveX = -3000
		moveY = 2250
	
	else
	
		moveX = 2250
		moveY = -3000
	
	end
	
	for idx,unit in pairs(Mission.FirstDDs) do
		
		--SetShipMaxSpeed(unit, 10)
		
		local pos = GetPosition(unit)
		pos.x = pos.x + moveX
		pos.z = pos.z + moveY
		
		PutTo(unit, pos)
		
		EntityTurnToEntity(unit, Mission.GermanSub)
		
	end
	
	NavigatorMoveToRange(Mission.FirstDDs[2], Mission.GermanSub)
	
	if moveIdx == 2 then
	
		for idx,unit in pairs(Mission.Convoy) do
			
			local pos = GetPosition(unit)
			pos.x = pos.x + 9000
			pos.z = pos.z - 5000
			
			PutTo(unit, pos)
			
		end
	
	end
	
	--local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if moveIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	else
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.Convoy[1], FindEntity("HornetPath"), PATH_FM_CIRCLE, pathDir)
	
end

function luaIntroMovie1()
	
	--EnableInput(false)
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("I-111")
	
	luaDelay(luaSurfaceSub, 1)
	luaDelay(luaIntroDia, 10)
	luaDelay(luaLaunchSeaplane, 27)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-4300,["y"]=5,["z"]=-4550},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4400,["y"]=5,["z"]=-4450},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-4400,["y"]=5,["z"]=-4450},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-4300,["y"]=8,["z"]=-4500},["parent"] = nil,},["moveTime"] = 18,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-50,["y"]=5,["z"]=-70},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-35,["y"]=6,["z"]=-70},["parent"] = trg1,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=13,["y"]=20,["z"]=170},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=8,["y"]=25,["z"]=170},["parent"] = trg1,},["moveTime"] = 8,["transformtype"] = "keepall"},
		
	}, luaIntroMovie2, true)

end

function luaSurfaceSub()

	SetSubmarineDepthLevel(Mission.JapSub, 0)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaLaunchSeaplane()
	
	--SetCatapultStock(Mission.JapSub, 1)
	
	ShipUseCatapult(Mission.JapSub)
	
	luaDelay(luaSeaplaneGoTo, 4)
	
end

function luaSeaplaneGoTo()

	local plane = GetLastCatapulted(Mission.JapSub)
	
	PilotMoveToRange(plane, FindEntity("SeaplaneGoTo"))
	
end

function luaIntroMovie2()
	
	Mission.Seaplane = GetLastCatapulted(Mission.JapSub)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.Seaplane, ["distance"] = 20, ["theta"] = 2, ["rho"] = -5, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.Seaplane, ["distance"] = 30, ["theta"] = 8, ["rho"] = -15, ["moveTime"] = 10},
		
	}, luaIntroMovieEnd)

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	Mission.MissionPhase = 1
	
	if Mission.Seaplane and not Mission.Seaplane.Dead then
	
		SetSelectedUnit(Mission.Seaplane)
	
	else
	
		SetSelectedUnit(Mission.JapSub)
	
	end
	
	EnableMessages(true)
	
	--EnableInput(true)
	
	Blackout(false, "", 1)
	
	Mission.CanMusicCheck = true
	
	luaStartDialog("QUICK")
	
	--luaAddFirstObjs()
	
end

function luaAddFirstObjs()
	
	luaObj_Add("primary", 1, GetPosition(FindEntity("SeaplaneGoTo")))
	luaObj_Add("hidden", 1)
	
	local line1 = "Locate the German submarine!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	luaDelay(luaPh1Fail, 215)
	Countdown("Time left: ", 0, 215)
	
	luaAddDDsListener()
	
end

function luaPh1Fail()

	if Mission.MissionPhase == 1 and not Mission.SeaplaneLanded then
	
		if luaObj_IsActive("primary", 1) then
		
			luaMissionFailed()
		
		end
	
	end

end

function luaDDsMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(Mission.JapSub)
	
	end

end

---- LISTENERS ----

function luaAddDDsListener()

	AddListener("recon", "DDsListener", {
		["callback"] = "luaDDsSighted",
		["entity"] = Mission.USUnits,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaDDsSighted(unit)

	RemoveListener("recon", "DDsListener")
	
	luaStartDialog("DDS")
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = unit
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 250, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 450, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 6},
		
	}, luaDDsMovieEnd, true)

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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) == 0 then
		
			luaObj_Completed("hidden",1)
		
		else
		
			luaObj_Failed("hidden",1)
		
		end
		
	end
	
	luaMissionCompletedNew(Mission.Hornet, "The Hornet is sinking - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaDelay(luaHidePh2Scores, 3)
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(nil, "Game Over")
	
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