---- EMPIRE'S FALL (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- EMPIRE'S FALL (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) 	-- Zero
	PrepareClass(163) 	-- Jill
	PrepareClass(159) 	-- Judy
	
	--PrepareClass(167) 	-- Betty
	PrepareClass(134) 	-- Hurricane
	PrepareClass(109) 	-- Swordfish
	PrepareClass(118) 	-- Mitchell
	PrepareClass(125) 	-- Catalina
	
end

---- INITS ----

function luaEngineMovieInit()
	
	Music_Control_SetLevel(MUSIC_CALM)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("ijndlg",5)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_03_emipres_fall.lua"

	this.Name = "IJN03"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Cap",
				["Text"] = "Capture all enemy bases in the area!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Prot",
				["Text"] = "Protect your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "BB",
				["Text"] = "Sink the enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Radar",
				["Text"] = "Take out the enemy radar station!",
				["TextCompleted"] = "The enemy radar station has been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Command",
				["Text"] = "Sink the hidden command ship!",
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
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01b_1",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "idlg01c_1",
				},
				{
					["type"] = "pause",
					["time"] = 8,
				},
				{
					["type"] = "callback",
					["callback"] = "luaMapDia",
				},
			},
		},
		["MAP"] = {--
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg5",
				},
				{
					["message"] = "dlg5_1",
				},
			},
		},
		["BOMBERS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
			},
		},
		["AF"] = {--
			["sequence"] = {
				{
					["message"] = "AF1",
				},
				{
					["message"] = "AF2",
				},
			},
		},
		["AJAX"] = {--
			["sequence"] = {
				{
					["message"] = "AJAX1",
				},
			},
		},
		["FLEET"] = {--
			["sequence"] = {
				{
					["message"] = "FLEET1",
				},
				{
					["message"] = "FLEET2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddReinObjs",
				},
			},
		},
		["RADAR"] = {--
			["sequence"] = {
				{
					["message"] = "RADAR1",
				},
				{
					["message"] = "RADAR2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddRadarObj",
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
	
	Mission.Shinano = FindEntity("Shinano")
	Mission.Zuiho = FindEntity("Zuiho")
	
	Mission.BruhGang = {}
		table.insert(Mission.BruhGang, Mission.Shinano)
		table.insert(Mission.BruhGang, Mission.Zuiho)
		table.insert(Mission.BruhGang, FindEntity("Ashigara"))
		table.insert(Mission.BruhGang, FindEntity("Nachi"))
		table.insert(Mission.BruhGang, FindEntity("Akizuki"))
		table.insert(Mission.BruhGang, FindEntity("Hae"))
		--table.insert(Mission.BruhGang, FindEntity("Otsuki"))
	
	for idx,unit in pairs(Mission.BruhGang) do
		
		JoinFormation(unit, Mission.BruhGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	AddAirBaseStock(Mission.Zuiho, 150, 9)
	AddAirBaseStock(Mission.Zuiho, 163, 9)
	AddAirBaseStock(Mission.Zuiho, 159, 9)
	
	Mission.BrahGang = {}
		table.insert(Mission.BrahGang, FindEntity("Arisan Maru"))
		table.insert(Mission.BrahGang, FindEntity("Asama Maru"))
		table.insert(Mission.BrahGang, FindEntity("Atago Maru"))
		table.insert(Mission.BrahGang, FindEntity("Kochi"))
		table.insert(Mission.BrahGang, FindEntity("Yukigumo"))
	
	for idx,unit in pairs(Mission.BrahGang) do
		
		JoinFormation(unit, Mission.BrahGang[2])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, Mission.Shinano)
		table.insert(Mission.JapGang, Mission.Zuiho)
		table.insert(Mission.JapGang, FindEntity("Ashigara"))
		table.insert(Mission.JapGang, FindEntity("Nachi"))
		table.insert(Mission.JapGang, FindEntity("Akizuki"))
		table.insert(Mission.JapGang, FindEntity("Hae"))
		--table.insert(Mission.JapGang, FindEntity("Otsuki"))
		table.insert(Mission.JapGang, FindEntity("Arisan Maru"))
		table.insert(Mission.JapGang, FindEntity("Asama Maru"))
		table.insert(Mission.JapGang, FindEntity("Atago Maru"))
		table.insert(Mission.JapGang, FindEntity("Kochi"))
		table.insert(Mission.JapGang, FindEntity("Yukigumo"))
	
	Mission.No = {}
		table.insert(Mission.No, FindEntity("Arisan Maru"))
		table.insert(Mission.No, FindEntity("Asama Maru"))
		table.insert(Mission.No, FindEntity("Atago Maru"))
	
	---- USN ----
	
	Mission.FinalHQ = FindEntity("CB7")
	Mission.CommandShip = FindEntity("Command Ship")
	Mission.RadarStation = FindEntity("RadarStation")
	Mission.Shipyard = FindEntity("PTHangar 01")
	
	Mission.CringeGang = {}
		table.insert(Mission.CringeGang, FindEntity("CB2"))
		table.insert(Mission.CringeGang, FindEntity("CB5"))
		table.insert(Mission.CringeGang, FindEntity("CP12 H"))
		table.insert(Mission.CringeGang, FindEntity("CB7"))
	
	for idx,unit in pairs(Mission.CringeGang) do
		
		--SetParty(unit, PARTY_ALLIED)
		SetSkillLevel(unit, Mission.SkillLevel)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		RepairEnable(unit, false)
		
	end
	
	Mission.YoMamma = {}
		table.insert(Mission.YoMamma, FindEntity("CB2"))
		table.insert(Mission.YoMamma, FindEntity("CB5"))
		table.insert(Mission.YoMamma, FindEntity("CP12 H"))
		table.insert(Mission.YoMamma, FindEntity("CB7"))
		
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("CB2"))
		table.insert(Mission.HQs, FindEntity("CB5"))
		table.insert(Mission.HQs, FindEntity("CP12 H"))
		table.insert(Mission.HQs, FindEntity("CB7"))
		
	Mission.BritReinzBeBallinBallin = {}
		table.insert(Mission.BritReinzBeBallinBallin, FindEntity("Multi AirField1"))
		table.insert(Mission.BritReinzBeBallinBallin, FindEntity("Multi AirField2"))
		table.insert(Mission.BritReinzBeBallinBallin, FindEntity("Multi AirField3"))
	
	for idx,unit in pairs(Mission.BritReinzBeBallinBallin) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 4)
		
		end
		
	end
	
	Mission.UrMom = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	--Mission.BaseNum = 4
	Mission.CanSpawnCatalina = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.AFPlanes = 1
		Mission.CatalinaDelay = 160
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.AFPlanes = 1
		Mission.CatalinaDelay = 130
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.AFPlanes = 2
		Mission.CatalinaDelay = 100
		
	end
	
	local commandShipPossiblePos = {
	
		[1] = {["x"] = 4700, ["y"] = 0, ["z"] = 5000},
		
		[2] = {["x"] = -5460, ["y"] = 0, ["z"] = -5200},
		
		[3] = {["x"] = -6000, ["y"] = 0, ["z"] = 6500},
		
		[4] = {["x"] = -1900, ["y"] = 0, ["z"] = 5850},
		
	}
	
	local commandShipPos = luaPickRnd(commandShipPossiblePos)
	
	PutTo(Mission.CommandShip, commandShipPos)
	
	--SetForcedReconLevel(Mission.CommandShip, 1, PARTY_JAPANESE)
	
	luaAddCommandShipHitListener()
	luaAddRadarStationListener()
	--[[luaAddCommandShipListener2()
	luaAddCommandShipListener3()]]
	luaAddAFListener()
	
	---- INIT FUNCT. ----
	
	Blackout(true, "", true)
	
	MissionNarrative("December 23rd, 1941 - Near Ceylon")
	
	if Mission.Difficulty < 2 then
		
		local bomber1 = GenerateObject("Betty_1")
		local bomber2 = GenerateObject("Betty_2")
		
		SetSkillLevel(bomber1, Mission.SkillLevelOwn)
		SetSkillLevel(bomber2, Mission.SkillLevelOwn)
		
		PilotMoveToRange(bomber1, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang)))
		PilotMoveToRange(bomber2, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang)))
		
	end
	
	---- MUSIC SETTING ----
	
	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
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
	
	--luaShowPoint(commandShipPos[4])
	
	--luaShowPath(FindEntity("CVPath"))
	
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
	
		luaIntroMovie()
		
		Mission.MissionPhase = 1
		
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
		
			local music_selectedUnit = GetSelectedUnit()

			if music_selectedUnit then

				luaCheckMusic(music_selectedUnit)

			end
			
			--if luaObj_IsActive("primary", 1) and luaObj_IsActive("primary", 3) then
			
				if Mission.CapsDone and Mission.ReinDead then
					
					if IsListenerActive("recon", "AFListener") then
					
						RemoveListener("recon", "AFListener")
					
					end
					
					if IsListenerActive("recon", "ReinListener") then
					
						RemoveListener("recon", "ReinListener")
					
					end
					
					if IsListenerActive("recon", "AjaxListener") then
					
						RemoveListener("recon", "AjaxListener")
					
					end
					
					if IsListenerActive("recon", "RadarStationListener") then
					
						RemoveListener("recon", "RadarStationListener")
					
					end
					
					if IsListenerActive("hit", "CommandShipHitListener") then
					
						RemoveListener("hit", "CommandShipHitListener")
					
					end
					
					HideUnitHP()
					HideScoreDisplay(1,0)
					
					luaObj_Completed("primary", 2)
					
					if luaObj_IsActive("secondary", 1) then
					
						luaObj_Failed("secondary", 1)
					
					end
					
					if luaObj_IsActive("hidden", 1) then
					
						luaObj_Failed("hidden", 1)
					
					end
					
					luaMissionComplete()
					
					Mission.EndMission = true
					
				end
			
			--end
			
			if luaObj_IsActive("primary", 1) then
				
				Mission.BasesLeft = table.getn(luaRemoveDeadsFromTable(Mission.YoMamma))
				
				local line1 = "Capture all enemy bases in the area!"
				local line2 = "Base(s) left to capture: #Mission.BasesLeft#"
				luaDisplayScore(1, line1, line2)
				
				if FindEntity("CB2").Party == PARTY_JAPANESE and FindEntity("CB5").Party == PARTY_JAPANESE and FindEntity("CP12 H").Party == PARTY_JAPANESE and FindEntity("CB7").Party == PARTY_JAPANESE then
					
					if not Mission.CapsDone then
					
						luaObj_Completed("primary", 1, true)
						
						Mission.CapsDone = true
					
					end
					
				else
				
					Mission.CapsDone = false
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.YoMamma)) > 0 then
				
					for idx,unit in pairs(Mission.YoMamma) do
					
						if unit.Party == PARTY_JAPANESE then
							
							--[[if not Mission.AirfieldSecuredDiaPlayed then
							
								if unit.Name == "CB2" or unit.Name == "CB5" or unit.Name == "CB7" then
									
									-- dia here
									
									Mission.AirfieldSecuredDiaPlayed = true
								
								end
								
							end]]
							
							table.remove(Mission.YoMamma, idx)
							table.insert(Mission.UrMom, unit)
							
						end
					
					end
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.UrMom)) > 0 then
				
					for idx,unit in pairs(Mission.UrMom) do
					
						if unit.Party == PARTY_NEUTRAL or unit.Party == PARTY_ALLIED then
							
							--[[if not Mission.BaseLostDiaPlayed then
							
								-- dia here
								
								Mission.BaseLostDiaPlayed = true
								
							end]]
							
							table.remove(Mission.UrMom, idx)
							table.insert(Mission.YoMamma, unit)
							
						end
					
					end
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.BritReinzBeBallinBallin)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BritReinzBeBallinBallin)) do
						
						if not unit.Dead and unit.Party == PARTY_ALLIED then
							
							--if unit.Name == "CB2" or unit.Name == "CB5" then
							
								local stloPlaneNum, stloPlaneTable= luaGetSlotsAndSquads(unit)
								
								if stloPlaneNum < Mission.AFPlanes and IsReadyToSendPlanes(unit) then
									
									local planeTypes = {
									109,
									118,
									}
									
									local plane = luaPickRnd(planeTypes)
									local ammo = random(1,2)
									local planeNum
									
									if plane == 109 then
									
										planeNum = 3
										
									elseif plane == 118 then
									
										planeNum = 2
									
									end
									
									local slotIndex = LaunchSquadron(unit,plane,planeNum,ammo)
									local launchedWildcat = thisTable[tostring(GetProperty(unit, "slots")[slotIndex].squadron)]
									SetSkillLevel(launchedWildcat, Mission.SkillLevel)
									
									local trg = luaGetPlaneTrg(launchedWildcat.Class.ID)
									PilotSetTarget(launchedWildcat, trg)

								end
							
							--end
						
						end
						
					end
				
				end
				
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.BritRein)) == 0 and not Mission.ReinDead then
					
					luaObj_Completed("primary", 3, true)
					
					Mission.ReinDead = true
				
				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.No)) == 0 then
					
					if IsListenerActive("recon", "AFListener") then
					
						RemoveListener("recon", "AFListener")
					
					end
					
					if IsListenerActive("recon", "ReinListener") then
					
						RemoveListener("recon", "ReinListener")
					
					end
					
					if IsListenerActive("recon", "AjaxListener") then
					
						RemoveListener("recon", "AjaxListener")
					
					end
					
					if IsListenerActive("recon", "RadarStationListener") then
					
						RemoveListener("recon", "RadarStationListener")
					
					end
					
					if IsListenerActive("hit", "CommandShipHitListener") then
					
						RemoveListener("hit", "CommandShipHitListener")
					
					end
					
					HideUnitHP()
					HideScoreDisplay(1,0)
					
					luaObj_Failed("primary", 1)
					luaObj_Failed("primary", 2)
					luaObj_Failed("primary", 3)
					
					if luaObj_IsActive("secondary", 1) then
					
						luaObj_Failed("secondary", 1)
					
					end
					
					if luaObj_IsActive("hidden", 1) then
					
						luaObj_Failed("hidden", 1)
					
					end
					
					luaMissionFailed(unit)
					
					Mission.EndMission = true
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.RadarStation.Dead then
				
					luaObj_Completed("secondary", 1, true)
					
					if not Mission.FirstReinIn then
					
						luaDelay(luaSpawnFirstRein, 20)
						
						Mission.FirstReinIn = true
						
					end
					
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if Mission.CommandShip.Dead then
				
					luaObj_Completed("hidden", 1, true)
				
				end
			
			end
			
			if not Mission.ReinHere then
				
				local shipsAround = luaGetShipsAroundCoordinate(GetPosition(Mission.FinalHQ), 3000, PARTY_JAPANESE, "own")
				
				if shipsAround then
					
					luaSpawnSecondRein()
				
				end
			
			else
			
				if Mission.Indefatigable and not Mission.Indefatigable.Dead then
				
					local fighter = {
						[1] = 134,
					}
					local bombers = {
						[1] = 109,
					}
					
					local trgs
					
					if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
					
						trgs = Mission.JapGang
					
					else
					
						trgs = Mission.No
					
					end
					
					luaAirfieldManager(Mission.Indefatigable, fighter, bombers, luaRemoveDeadsFromTable(trgs))
					
				end
			
			end
			
			if not Mission.Shipyard.Dead and Mission.Shipyard.Party == PARTY_ALLIED then
			
				if Mission.CanSpawnCatalina then
				
					local catalina = GenerateObject("Catalina")
					
					SetSkillLevel(catalina, Mission.SkillLevel)
					
					local trg = luaGetPlaneTrg(catalina.Class.ID)
					PilotSetTarget(catalina, trg)
					
					Mission.CanSpawnCatalina = false
					
					luaDelay(luaAllowCatalinaSpawn, Mission.CatalinaDelay)
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 1 ----

function luaMapDia()

	luaStartDialog("MAP")

end

function luaAllowCatalinaSpawn()

	Mission.CanSpawnCatalina = true

end

function luaSpawnSecondRein()

	Mission.ReinHere = true
	
	local bruh = random(1, 2)
	
	local ship1
	local ship2
	local ship3
	local ship4
	local ship5
	local ship6
	local ship7
	local ship8
	
	if bruh == 1 then
	
		ship1 = GenerateObject("Rein_1_1")
		ship2 = GenerateObject("Rein_1_2")
		ship3 = GenerateObject("Rein_1_3")
		--ship4 = GenerateObject("Rein_1_4")
		--ship5 = GenerateObject("Rein_1_5")
		ship6 = GenerateObject("Rein_1_6")
		ship7 = GenerateObject("Rein_1_7")
		ship8 = GenerateObject("Rein_1_8")
	
	elseif bruh == 2 then
	
		ship1 = GenerateObject("Rein_2_1")
		ship2 = GenerateObject("Rein_2_2")
		ship3 = GenerateObject("Rein_2_3")
		--ship4 = GenerateObject("Rein_2_4")
		--ship5 = GenerateObject("Rein_2_5")
		ship6 = GenerateObject("Rein_2_6")
		ship7 = GenerateObject("Rein_2_7")
		ship8 = GenerateObject("Rein_2_8")
	
	end
	
	Mission.BBRein = {}
		table.insert(Mission.BBRein, ship1)
		table.insert(Mission.BBRein, ship2)
		table.insert(Mission.BBRein, ship3)
		--table.insert(Mission.BBRein, ship4)
		--table.insert(Mission.BBRein, ship5)
	
	for idx,unit in pairs(Mission.BBRein) do
		
		JoinFormation(unit, Mission.BBRein[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
		UnitSetFireStance(unit, 2)
		
	end
	
	Mission.Indefatigable = ship6
	
	Mission.CVRein = {}
		table.insert(Mission.CVRein, ship6)
		table.insert(Mission.CVRein, ship7)
		table.insert(Mission.CVRein, ship8)
	
	for idx,unit in pairs(Mission.CVRein) do
		
		JoinFormation(unit, Mission.CVRein[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.BritRein = {}
		table.insert(Mission.BritRein, ship1)
		table.insert(Mission.BritRein, ship2)
		table.insert(Mission.BritRein, ship3)
		--table.insert(Mission.BritRein, ship4)
		--table.insert(Mission.BritRein, ship5)
		table.insert(Mission.BritRein, ship6)
		table.insert(Mission.BritRein, ship7)
		table.insert(Mission.BritRein, ship8)
	
	local trg
	
	if Mission.Difficulty == 0 then
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))
	
	else
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.No))
	
	end
	
	NavigatorAttackMove(Mission.BBRein[1], trg)
	NavigatorMoveOnPath(Mission.CVRein[1], FindEntity("CVPath"), PATH_FM_CIRCLE)
	
	luaAddReinListener()

end

function luaAddReinObjs()

	luaObj_Add("primary", 3, Mission.BritRein)

end

function luaSpawnFirstRein()

	local ship1 = GenerateObject("Ajax")
	local ship2 = GenerateObject("Icarus")
	local ship3 = GenerateObject("Antony")
	--local ship4 = GenerateObject("Valkyrie")
	--local ship5 = GenerateObject("Acasta")
	--local ship6 = GenerateObject("Gallant")
	
	Mission.AjaxGang = {}
		table.insert(Mission.AjaxGang, ship1)
		table.insert(Mission.AjaxGang, ship2)
		table.insert(Mission.AjaxGang, ship3)
		--table.insert(Mission.AjaxGang, ship4)
		--table.insert(Mission.AjaxGang, ship5)
		--table.insert(Mission.AjaxGang, ship6)
	
	for idx,unit in pairs(Mission.AjaxGang) do
		
		JoinFormation(unit, Mission.AjaxGang[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
		UnitSetFireStance(unit, 2)
		
	end
	
	local trg
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))
	
	else

		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.No))
	
	end
	
	NavigatorAttackMove(Mission.AjaxGang[1], trg)
	
	luaAddAjaxListener()
	
end

function luaGetPlaneTrg(class)
	
	local trg
	
	if Mission.Difficulty == 0 then
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))
	
	else
	
		if class == 109 then
		
			trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang))
		
		elseif class == 118 or class == 125 then
		
			trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.No))
		
		end
	
	end
	
	return trg
	
end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	local trg1 = FindEntity("Multi AirField1")
	local trg2 = FindEntity("Shinano")
	
	luaDelay(luaIntroDia, 3.5)
	
	luaIngameMovie(
	{
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 70, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 70, ["theta"] = 10, ["rho"] = 0, ["moveTime"] = 5},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 12, ["rho"] = 0, ["moveTime"] = 3},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 250, ["theta"] = 12, ["rho"] = 0, ["moveTime"] = 8},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 150, ["theta"] = 6, ["rho"] = 42, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 6, ["rho"] = 42, ["moveTime"] = 8},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 9, ["rho"] = 75, ["moveTime"] = 4},
	 {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 9, ["rho"] = 75, ["moveTime"] = 4},
	 
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	 {["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	 
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	SetSelectedUnit(FindEntity("Shinano"))
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.YoMamma)
	luaObj_Add("primary", 2, Mission.No)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.No)), "Protect your transports!")
	
	luaStartDialog("BOMBERS")
	
end

function luaAddRadarObj()

	luaObj_Add("secondary", 1, Mission.RadarStation)

end

---- LISTENERS ----

function luaAddAFListener()

	AddListener("recon", "AFListener", {
		["callback"] = "luaAFSighted",
		["entity"] = Mission.BritReinzBeBallinBallin,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddReinListener()

	AddListener("recon", "ReinListener", {
		["callback"] = "luaReinSighted",
		["entity"] = Mission.BritRein,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddAjaxListener()

	AddListener("recon", "AjaxListener", {
		["callback"] = "luaAjaxSighted",
		["entity"] = Mission.AjaxGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddRadarStationListener()

	AddListener("recon", "RadarStationListener", {
		["callback"] = "luaRadarStationSighted",
		["entity"] = {Mission.RadarStation},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddCommandShipHitListener()

	AddListener("hit", "CommandShipHitListener", {
		["callback"] = "luaCommandShipHit",
		["target"] = {Mission.CommandShip},
		["targetDevice"] = {},
		["attacker"] = {},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

---- LISTENER CALLBACKS ----

function luaAFSighted()

	RemoveListener("recon", "AFListener")
	
	luaStartDialog("AF")
	
end

function luaReinSighted()

	RemoveListener("recon", "ReinListener")
	
	luaStartDialog("FLEET")
	
end

function luaAjaxSighted()

	RemoveListener("recon", "AjaxListener")
	
	luaStartDialog("AJAX")
	
end

function luaRadarStationSighted()

	RemoveListener("recon", "RadarStationListener")
	
	luaStartDialog("RADAR")
	
end

function luaCommandShipHit()

	RemoveListener("hit", "CommandShipHitListener")
	
	SetParty(Mission.CommandShip, PARTY_ALLIED)
	SetGuiName(Mission.CommandShip, "Command Ship")
	
	NavigatorMoveToRange(Mission.CommandShip, GetClosestBorderZone(GetPosition(Mission.CommandShip)))
	
end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "Ceylon is ours - Mission Complete")
	
end

function luaMissionFailed()
	
	luaMissionFailedNew(unit, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

function luaShowPoint(point)
	
	luaObj_Add("marker2",1)
	
	luaObj_AddUnit("marker2",1,point)

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