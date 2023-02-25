---- ATTACK ON THE SOLOMONS (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- ATTACK ON THE SOLOMONS (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(102) 	-- F4U
	--PrepareClass(26) 	-- F6F
	PrepareClass(108) 	-- SBD
	PrepareClass(113) 	-- TBF
	
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
	
	LoadMessageMap("ijndlg",9)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_10_solomons.lua"

	this.Name = "IJN10"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "DDs",
				["Text"] = "Sink the fleeing enemy ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "W8",
				["Text"] = "Wait for reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Sink",
				["Text"] = "Sink all enemy capital ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Shoot",
				["Text"] = "Shoot down 30 enemy aircraft!",
				["TextCompleted"] = "You've shot down 30 enemy aircraft!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Dest",
				["Text"] = "Destroy all enemy ships in the area!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Arashi",
				["Text"] = "Ensure the survival of the destroyer Arashi!",
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
					["time"] = 3,
				},
				{
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 7,
				},
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
			},
		},
		["FLEEING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObjs",
				},
			},
		},
		["INCOMING"] = {--
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
				{
					["message"] = "dlg3d",
				},
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["message"] = "dlg4c",
				},
				{
					["message"] = "dlg4d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaInitReinCounter",
				},
			},
		},
		["HERE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["JAPWINNING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["JAPLOSING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
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
	
	Mission.JapFleet = {}
		table.insert(Mission.JapFleet, FindEntity("Takao"))
		table.insert(Mission.JapFleet, FindEntity("Kiso"))
		table.insert(Mission.JapFleet, FindEntity("Oyodo"))
		table.insert(Mission.JapFleet, FindEntity("Arashi"))
	
	for idx,unit in pairs(Mission.JapFleet) do
		
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
	
	---- USN ----
	
	Mission.USDDs = {}
		table.insert(Mission.USDDs, FindEntity("Kidd"))
		table.insert(Mission.USDDs, FindEntity("McCord"))
		table.insert(Mission.USDDs, FindEntity("Yarnall"))
		table.insert(Mission.USDDs, FindEntity("David W. Taylor"))
		table.insert(Mission.USDDs, FindEntity("Prichett"))
		table.insert(Mission.USDDs, FindEntity("Bell"))
	
	for idx,unit in pairs(Mission.USDDs) do
	
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
		
		SetShipMaxSpeed(unit, 13)
		
		local pos = GetPosition(unit)
		pos.x = random(-4000,4000)
		pos.z = 30000
		
		NavigatorMoveToRange(unit, pos)
		
	end
	
	---- VAR ----
	
	Mission.Ph2Trigger = FindEntity("Ph2Trigger")
	
	Mission.PlaneSpawns = {}
		table.insert(Mission.PlaneSpawns, FindEntity("PlaneSpawn1"))
		table.insert(Mission.PlaneSpawns, FindEntity("PlaneSpawn2"))
		table.insert(Mission.PlaneSpawns, FindEntity("PlaneSpawn3"))
		table.insert(Mission.PlaneSpawns, FindEntity("PlaneSpawn4"))
		table.insert(Mission.PlaneSpawns, FindEntity("PlaneSpawn5"))
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.Ph1CatalinaCanSpawn = true
	--Mission.Ph2CatalinaCanSpawn = false
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.CatalinaDelay = 120
		Mission.ReinDelay = 300
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.CatalinaDelay = 100
		Mission.ReinDelay = 400
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.CatalinaDelay = 80
		Mission.ReinDelay = 500
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("October 26th, 1942 - In the Solomon Islands")
	
	Blackout(true, "", true)
	
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
	
	--luaShowPoint(FindEntity("Ph2Trigger"))
	
	--luaShowPath(FindEntity("CVPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.RllyBruh) do
		
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
	
		luaIntroMovie()
		
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
			
			if luaObj_IsActive("secondary", 1) then
			
				local sd = Scoring_GetPlayerShotDown()
				
				if sd >= 30 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if Mission.CVsHere then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.USBBs)) > 0 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USBBs)) do
					
						if unit and not unit.Dead then
						
							if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
								
								local trgs = luaGetUSPlaneTrg()
								local trg = luaPickRnd(luaRemoveDeadsFromTable(trgs))
								
								luaSetScriptTarget(unit, trg)
								NavigatorAttackMove(unit, trg)
							
							end
							
						end
					
					end
					
				end
				
			end
			
			if Mission.Ph1CatalinaCanSpawn then
				
				luaCatalinaFlow(true)
				
				luaDelay(luaAllowPh1CatalinaSpawn, Mission.CatalinaDelay)
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapFleet)) == 0 then
				
					luaMissionFailed()
				
				else
				
					local ships = luaRemoveDeadsFromTable(Mission.JapFleet)
					
					if ships and table.getn(luaRemoveDeadsFromTable(ships)) > 0 then
					
						--local ordered = luaSortByDistance(Mission.Ph2Trigger, ships)
						local triggerPos = GetPosition(Mission.Ph2Trigger)
						local inPosition = false
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(ships)) do
						
							local shipPos = GetPosition(unit)
							
							if shipPos.z >= triggerPos.z then
						
								inPosition = true
								
								break
								
							end
							
						end
						
						if inPosition or table.getn(luaRemoveDeadsFromTable(Mission.USDDs)) == 0 then
						
							HideUnitHP()
						
							luaObj_Completed("primary", 1)
							
							Blackout(true, "luaMoveToPh2", 1)
							--luaMoveToPh2()
							
						end
						
					end
					
				end
			
			end
		
		else
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.JapFleet)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) == 0 then
					
					if not Mission.ReadyToComplete then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapFleet)) do
							
							if unit and not unit.Dead then
							
								SetInvincible(unit, 0.01)
							
							end
							
						end
						
						HideUnitHP()
						
						luaObj_Completed("primary", 3)
						
						if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
						
							luaObj_Completed("secondary", 2)
						
						end
						
						luaDelay(luaFinalDia, 3)
						
						Mission.ReadyToComplete = true
						
					end
					
				else
				
					if not Mission.NumDiaPlayed then
					
						local japNum = table.getn(luaRemoveDeadsFromTable(Mission.JapFleet))
						local usNum = table.getn(luaRemoveDeadsFromTable(Mission.USShips))
						local canPlay = false
						local dia
						
						if (japNum - usNum) >= 6 then
							
							dia = "JAPWINNING"
							
							canPlay = true
						
						elseif (japNum - usNum) <= -8 then
						
							dia = "JAPLOSING"
						
							canPlay = true
						
						end
						
						if canPlay then
						
							luaStartDialog(dia)
							
							Mission.NumDiaPlayed = true
						
						end
						
					end
					
				end
			
			end
			
			if Mission.MissionPhase == 2 then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
				
					local canBomb = true
					local bb
					
					if table.getn(luaRemoveDeadsFromTable(Mission.USBBs)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USBBs)) do
							
							if unit and not unit.Dead then
							
								if unit.IJN10_FighterCover == nil or unit.IJN10_FighterCover.Dead then
									
									bb = unit
									canBomb = false
								
								end
							
							end
							
						end
					
					end
					
					if canBomb then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
						
							if unit and not unit.Dead then
							
								local fighters = {
									[1] = 102,
									--[2] = 26,
								}
								local bombers = {
									[1] = 113,
									[2] = 108,
								}
								
								local trgs = luaGetUSPlaneTrg()
								
								luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
								
							end
						
						end
					
					else
					
						local cv = luaPickRnd(luaRemoveDeadsFromTable(Mission.CVs))
						
						if cv and not cv.Dead then

							if IsReadyToSendPlanes(cv) then
								
								local planeTypes = {
													102,
													102,
													}
								local slotIndex = LaunchSquadron(cv,luaPickRnd(planeTypes),3)
								
								bb.IJN10_FighterCover = thisTable[tostring(GetProperty(cv, "slots")[slotIndex].squadron)]
								SetSkillLevel(bb.IJN10_FighterCover, Mission.SkillLevel)
								PilotMoveToRange(bb.IJN10_FighterCover, bb)
								
							end
							
						end
					
					end
					
				end
			
			elseif Mission.MissionPhase == 3 then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
					
						if unit and not unit.Dead then
						
							local fighters = {
								[1] = 102,
								--[2] = 26,
							}
							local bombers = {
								[1] = 113,
								[2] = 108,
							}
							
							local trgs = luaGetUSPlaneTrg()
							
							luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
							
						end
					
					end
					
				end
				
			end
			
			--[[if Mission.Ph2CatalinaCanSpawn then
				
				luaCatalinaFlow(true)
				
				luaDelay(luaAllowPh2CatalinaSpawn, Mission.CatalinaDelay)
			
			end]]
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 3 ----

function luaFinalDia()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
	
		luaStartDialog("FINAL")
	
	else
	
		luaMissionComplete()
	
	end
	
end

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.JapRein = {}
		table.insert(Mission.JapRein, GenerateObject("Oryu"))
		table.insert(Mission.JapRein, GenerateObject("Sagami"))
		--table.insert(Mission.JapRein, GenerateObject("Iyo"))
		--table.insert(Mission.JapRein, GenerateObject("Azumaya"))
		--table.insert(Mission.JapRein, GenerateObject("Mitsumine"))
		table.insert(Mission.JapRein, GenerateObject("Hae"))
		table.insert(Mission.JapRein, GenerateObject("Kochi"))
		table.insert(Mission.JapRein, GenerateObject("Fuyugumo"))
		--table.insert(Mission.JapRein, GenerateObject("Asagochi"))
		--table.insert(Mission.JapRein, GenerateObject("Urazuki"))
	
	--[[if Mission.Difficulty < 2 then
	
		table.insert(Mission.JapRein, GenerateObject("Iyo"))
	
	end]]
	
	for idx,unit in pairs(Mission.JapRein) do
		
		JoinFormation(unit, Mission.JapRein[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
		table.insert(Mission.JapFleet, unit)
		
	end
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	luaDelay(luaHereDia, 2)
	
	local trg1 = FindEntity("Oryu")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		
		--{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    --{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    --{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaPh3MovieEnd, true)
	
end

function luaHereDia()

	luaStartDialog("HERE")

end

function luaPh3MovieEnd()
	
	SetSelectedUnit(FindEntity("Oryu"))
	
	Mission.CanMusicCheck = true
	
	luaDelay(luaAddThirdObjs, 3)
	
end

function luaAddThirdObjs()

	luaObj_Add("primary", 3, Mission.CapitalShips)
	luaObj_Add("secondary", 2)
	
	DisplayUnitHP(Mission.CapitalShips, "Sink all enemy capital ships!")

end

---- PHASE 2 ----

function luaPh2FadeOut()
	
	luaObj_Completed("primary", 2)
	
	Blackout(true, "luaMoveToPh3", 1)

end

function luaGetUSPlaneTrg()
	
	local trgs
	
	if Mission.Difficulty == 0 then
		
		trgs = Mission.JapFleet
		
	else
		
		local tmpTable = {}
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JapFleet)) do
		
			if unit.Class.Type == "MotherShip" or unit.Class.Type == "BattleShip" then
			
				table.insert(tmpTable, unit)
			
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(tmpTable)) > 0 then
		
			trgs = tmpTable
		
		else
		
			trgs = Mission.JapFleet
		
		end
		
	end
	
	return trgs
	
end

function luaMoveToPh2()

	Mission.MissionPhase = 2
	Mission.CVsHere = true
	
	Mission.USBBs = {}
		table.insert(Mission.USBBs, GenerateObject("Massachusetts"))
		table.insert(Mission.USBBs, GenerateObject("Alabama"))
	
	for idx,unit in pairs(Mission.USBBs) do
		
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
		
		local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(Mission.JapFleet))
		local trg = ordered[1]
		
		UnitSetFireStance(unit, 2)
		luaSetScriptTarget(unit, trg)
		NavigatorAttackMove(unit, trg)
		
	end
	
	Mission.USFleet = {}
		table.insert(Mission.USFleet, GenerateObject("Princeton"))
		table.insert(Mission.USFleet, GenerateObject("Belleau Wood"))
		--table.insert(Mission.USFleet, GenerateObject("Block Island"))
		--table.insert(Mission.USFleet, GenerateObject("Copahee"))
		--table.insert(Mission.USFleet, GenerateObject("Kentucky"))
		table.insert(Mission.USFleet, GenerateObject("Juneau"))
		table.insert(Mission.USFleet, GenerateObject("Tucson"))
		table.insert(Mission.USFleet, GenerateObject("Ellyson"))
		table.insert(Mission.USFleet, GenerateObject("Rodman"))
		table.insert(Mission.USFleet, GenerateObject("Macomb"))
		--table.insert(Mission.USFleet, GenerateObject("Corry"))
		--table.insert(Mission.USFleet, GenerateObject("Aaron Ward"))
		--table.insert(Mission.USFleet, GenerateObject("Buchanan"))
		--table.insert(Mission.USFleet, GenerateObject("Lansdowne"))
		--table.insert(Mission.USFleet, GenerateObject("McCalla"))
		--table.insert(Mission.USFleet, GenerateObject("Carmick"))
		--table.insert(Mission.USFleet, GenerateObject("Frankford"))
	
	Mission.CapitalShips = {}
		table.insert(Mission.CapitalShips, FindEntity("Princeton"))
		table.insert(Mission.CapitalShips, FindEntity("Belleau Wood"))
		--table.insert(Mission.CapitalShips, FindEntity("Block Island"))
		--table.insert(Mission.CapitalShips, FindEntity("Copahee"))
		--table.insert(Mission.CapitalShips, FindEntity("Kentucky"))
		table.insert(Mission.CapitalShips, FindEntity("Massachusetts"))
		table.insert(Mission.CapitalShips, FindEntity("Alabama"))
	
	Mission.CVs = {}
	
	for idx,unit in pairs(Mission.USFleet) do
		
		JoinFormation(unit, Mission.USFleet[1])
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
		
		if unit.Class.Type == "MotherShip" then
			
			if Mission.Difficulty == 0 then
		
				SetAirBaseSlotCount(unit, 2)
				
			elseif Mission.Difficulty == 1 then
				
				SetAirBaseSlotCount(unit, 3)
				
			elseif Mission.Difficulty == 2 then
				
				SetAirBaseSlotCount(unit, 3)
				
			end
			
			table.insert(Mission.CVs, unit)
			
		end
		
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.USDDs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.USDDs)) do
			
			if unit and not unit.Dead then
				
				SetShipMaxSpeed(unit, unit.Class.MaxSpeed)
				
				local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFleet))
				
				UnitSetFireStance(unit, 2)
				--luaSetScriptTarget(unit, trg)
				NavigatorAttackMove(unit, trg)
			
			end
			
		end
	
	end
	
	Mission.USShips = luaSumTablesIndex(luaRemoveDeadsFromTable(Mission.USBBs), luaRemoveDeadsFromTable(Mission.USFleet), luaRemoveDeadsFromTable(Mission.USDDs))
	
	local pathDirIdx = luaRnd(1,2)
	local pathDir
	
	if pathDirIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathDirIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.USFleet[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaDelay(luaIncomingDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = FindEntity("Massachusetts")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		
	}, luaPh2MovieEnd, true)
	
end

function luaIncomingDia()

	luaStartDialog("INCOMING")

end

function luaPh2MovieEnd()

	if not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFleet)))
	
	end
	
end

function luaInitReinCounter()
	
	luaObj_Add("primary", 2)
	
	luaDelay(luaPh2FadeOut, Mission.ReinDelay)
	Countdown("Japanese reinforcements arrive in:", 0, Mission.ReinDelay)

end

--[[function luaAllowPh2CatalinaSpawn()

	Mission.Ph2CatalinaCanSpawn = true

end]]

---- PHASE 1 ----

function luaAllowPh1CatalinaSpawn()

	Mission.Ph1CatalinaCanSpawn = true

end

function luaCatalinaFlow(randomSpawn, spawnPosIdx, exception)

	if not Mission.EndMission then
		
		local canSpawn
		
		if not exception then
		
			--if Mission.MissionPhase == 1 then
			
				Mission.Ph1CatalinaCanSpawn = false
				
			--[[elseif Mission.MissionPhase == 2 then
			
				Mission.Ph2CatalinaCanSpawn = false
				
				canSpawn = true
				
			end]]
		
		end
		
		canSpawn = true
		
		if canSpawn then
			
			local pos
			
			if not randomSpawn and spawnPosIdx then
			
				pos = GetPosition(Mission.PlaneSpawns[spawnPosIdx])
				
			else
				
				pos = GetPosition(luaPickRnd(Mission.PlaneSpawns))
				
			end
			
			pos.y = 700
			
			local spawnIdx
			local unit
			
			if Mission.MissionPhase == 1 then
			
				spawnIdx = 1
				
			else
			
				spawnIdx = luaRnd(1,2)
			
			end
			
			if spawnIdx == 1 then
			
				unit = GenerateObject("Catalina")
			
			elseif spawnIdx == 2 then
			
				unit = GenerateObject("B-17")
				
			end
			
			PutTo(unit, pos)
			
			SetSkillLevel(unit, Mission.SkillLevel)
			UnitSetFireStance(unit, 2)
			
			PilotSetTarget(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFleet)))
			
			if not Mission.CatalinaListenerAdded then
			
				luaAddCatalinaListener(unit)
				
				Mission.CatalinaListenerAdded = true
			
			end
		
		end
		
	end

end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 4)
	
	local trg1 = FindEntity("Takao")
	local trg2 = FindEntity("Kiso")
	local trg3 = FindEntity("Kidd")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-1,["y"]=4,["z"]=85},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=4,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=4,["z"]=0},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=-11,["y"]=13,["z"]=0},["parent"] = trg1,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-20,["y"]=6,["z"]=55},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=55},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=55},["parent"] = trg2,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=59},["parent"] = trg2,},["moveTime"] = 10,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=5,["y"]=5,["z"]=75},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=2,["y"]=5,["z"]=0},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=2,["y"]=5,["z"]=0},["parent"] = trg3,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-1,["y"]=8.5,["z"]=0},["parent"] = trg3,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Takao"))
	
	EnableMessages(true)
	
	--Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaStartDialog("FLEEING")
	
	--luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.USDDs)
	
	DisplayUnitHP(Mission.USDDs, "Sink the fleeing enemy ships!")
	
	--luaCatalinaFlow()
	
end

---- LISTENERS ----

function luaAddCatalinaListener(unit)

	AddListener("recon", "CatalinaListener", {
		["callback"] = "luaCatalinaSighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaCatalinaSighted()

	RemoveListener("recon", "CatalinaListener")
	
	luaObj_Add("secondary", 1)

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	Mission.EndMission = true
	
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
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFleet)), "The enemy fleet has been annihilated - Mission Complete")
	
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
		
		luaObj_Failed("primary",3)
	
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