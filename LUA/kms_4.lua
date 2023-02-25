---- GERMAN MISSION #4 (KMS) ----

-- Scripted & Assembled by: Team Wolfpack

---- GERMAN MISSION #4 (KMS) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(134) 	-- Hurricane
	PrepareClass(109) 	-- Swordfish
	PrepareClass(336) 	-- Firefly
	
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
	
	LoadMessageMap("kmsdlg",4)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/KMS/kms_4.lua"

	this.Name = "KMS4"
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
				["Text"] = "Secure all enemy bases!",
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
				["ID"] = "GZ",
				["Text"] = "Ensure the survival of your capital ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Key",
				["Text"] = "Destroy the enemy key units!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "CA",
				["Text"] = "Sink at least 3 enemy cruisers!",
				["TextCompleted"] = "You've sunk 3 enemy cruisers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Snik",
				["Text"] = "Ensure the survival of all your ships!",
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
					["message"] = "INTRO1",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "INTRO2",
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
		["ASHORE"] = {--
			["sequence"] = {
				{
					["message"] = "ASHORE1",
				},
				{
					["message"] = "ASHORE2",
				},
			},
		},
		["MAYDAY"] = {--
			["sequence"] = {
				{
					["message"] = "MAYDAY1",
				},
				{
					["message"] = "MAYDAY2",
				},
			},
		},
		--[[["ESCORT"] = {
			["sequence"] = {
				{
					["message"] = "ESCORT1",
				},
				{
					["message"] = "ESCORT2",
				},
			},
		},]]
		["VESSEL"] = {--
			["sequence"] = {
				{
					["message"] = "VESSEL1",
				},
				{
					["message"] = "VESSEL2",
				},
				{
					["message"] = "VESSEL3",
				},
				{
					["message"] = "VESSEL4",
				},
				{
					["message"] = "VESSEL5",
				},
				{
					["message"] = "VESSEL6",
				},
				{
					["message"] = "ISLANDS1",
				},
				{
					["message"] = "ISLANDS2",
				},
				{
					["message"] = "ISLANDS3",
				},
			},
		},
		["SUNK"] = {--
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "FINAL3",
				},
				{
					["message"] = "FINAL4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAllowEnd",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "SWIFTLY1",
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
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPVETERAN
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
	
	---- KMS ----
	
	Mission.GrafSpee = FindEntity("Admiral Graf Spee")
	Mission.GrafZeppelin = FindEntity("Graf Zeppelin")
	
	Mission.CVFleet = {}
		table.insert(Mission.CVFleet, Mission.GrafSpee)
		table.insert(Mission.CVFleet, Mission.GrafZeppelin)
		table.insert(Mission.CVFleet, FindEntity("Z7"))
		table.insert(Mission.CVFleet, FindEntity("Z29"))
		table.insert(Mission.CVFleet, FindEntity("Z21"))
		table.insert(Mission.CVFleet, FindEntity("Z10"))
		table.insert(Mission.CVFleet, FindEntity("Z16"))
	
	for idx,unit in pairs(Mission.CVFleet) do
		
		JoinFormation(unit, Mission.CVFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.InvasionFleet = {}
		table.insert(Mission.InvasionFleet, FindEntity("Hindenburg"))
		table.insert(Mission.InvasionFleet, FindEntity("Z12"))
		table.insert(Mission.InvasionFleet, FindEntity("Z14"))
		table.insert(Mission.InvasionFleet, FindEntity("Emechtron"))
		table.insert(Mission.InvasionFleet, FindEntity("Gottingen"))
		table.insert(Mission.InvasionFleet, FindEntity("Erna"))
	
	for idx,unit in pairs(Mission.InvasionFleet) do
		
		JoinFormation(unit, Mission.InvasionFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.Transports = {}
		table.insert(Mission.Transports, FindEntity("Emechtron"))
		table.insert(Mission.Transports, FindEntity("Gottingen"))
		table.insert(Mission.Transports, FindEntity("Erna"))
	
	Mission.CapitalShips = {}
		table.insert(Mission.CapitalShips, Mission.GrafSpee)
		table.insert(Mission.CapitalShips, Mission.GrafZeppelin)
	
	Mission.GermanShips = luaSumTablesIndex(Mission.CVFleet, Mission.InvasionFleet)
	
	---- GB ----
	
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("HQ1"))
		table.insert(Mission.HQs, FindEntity("HQ2"))
		table.insert(Mission.HQs, FindEntity("CB1"))
		table.insert(Mission.HQs, FindEntity("CB2"))
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("Airfield1"))
		table.insert(Mission.Airfields, FindEntity("Airfield2"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, true)
		
	end
	
	Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Heavy") or string.find(unit.Name, "Light") or string.find(unit.Name, "Coastal") or string.find(unit.Name, "Coastal")) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
	end
	
	Mission.Richelieu = FindEntity("Richelieu")
	
	Mission.RichelieuFleet = {}
		table.insert(Mission.RichelieuFleet, Mission.Richelieu)
		table.insert(Mission.RichelieuFleet, FindEntity("Diana"))
		table.insert(Mission.RichelieuFleet, FindEntity("Demon"))
		
	for idx,unit in pairs(Mission.RichelieuFleet) do
		
		JoinFormation(unit, Mission.RichelieuFleet[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.BCFleet = {}
		table.insert(Mission.BCFleet, FindEntity("Colossus"))
		table.insert(Mission.BCFleet, FindEntity("Furious"))
		table.insert(Mission.BCFleet, FindEntity("Fiji"))
		table.insert(Mission.BCFleet, FindEntity("Mauritius"))
		table.insert(Mission.BCFleet, FindEntity("Vimiera"))
		table.insert(Mission.BCFleet, FindEntity("Oudenarde"))
		table.insert(Mission.BCFleet, FindEntity("Camperdown"))
		table.insert(Mission.BCFleet, FindEntity("St. Kitts"))
		
	for idx,unit in pairs(Mission.BCFleet) do
		
		JoinFormation(unit, Mission.BCFleet[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.FuckMeInTheAss = {}
		table.insert(Mission.FuckMeInTheAss, FindEntity("Renown"))
		table.insert(Mission.FuckMeInTheAss, FindEntity("Belle Isle"))
		table.insert(Mission.FuckMeInTheAss, FindEntity("Trincomalee"))
	
	for idx,unit in pairs(Mission.FuckMeInTheAss) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			TorpedoEnable(unit, false)
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 2 then
			
			TorpedoEnable(unit, true)
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.KeyUnits = {}
		table.insert(Mission.KeyUnits, FindEntity("Colossus"))
		table.insert(Mission.KeyUnits, FindEntity("Furious"))
		table.insert(Mission.KeyUnits, FindEntity("Renown"))
		table.insert(Mission.KeyUnits, FindEntity("Richelieu"))
	
	Mission.BlyatCVs = {}
		table.insert(Mission.BlyatCVs, FindEntity("Colossus"))
		table.insert(Mission.BlyatCVs, FindEntity("Furious"))
		table.insert(Mission.BlyatCVs, FindEntity("Airfield1"))
		table.insert(Mission.BlyatCVs, FindEntity("Airfield2"))
	
	for idx,unit in pairs(Mission.BlyatCVs) do
		
		if Mission.Difficulty == 0 then
		
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
			
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 4)
			
		end
		
	end
	
	Mission.CAFleet = {}
		table.insert(Mission.CAFleet, FindEntity("Cumberland"))
		table.insert(Mission.CAFleet, FindEntity("Gabbard"))
		table.insert(Mission.CAFleet, FindEntity("Alamein"))
		
	for idx,unit in pairs(Mission.CAFleet) do
		
		JoinFormation(unit, Mission.CAFleet[1])
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
	
	Mission.Cruisers = {}
		table.insert(Mission.Cruisers, FindEntity("Fiji"))
		table.insert(Mission.Cruisers, FindEntity("Mauritius"))
		table.insert(Mission.Cruisers, FindEntity("Cumberland"))
	
	Mission.Targeteers = {}
	
	if Mission.Difficulty > 0 then
		
		--LeaveFormation(FindEntity("Renown"))
		
		table.insert(Mission.Targeteers, FindEntity("Renown"))
		
		JoinFormation(FindEntity("Belle Isle"), FindEntity("Renown"))
		JoinFormation(FindEntity("Trincomalee"), FindEntity("Renown"))
	
	else
		
		JoinFormation(FindEntity("Renown"), FindEntity("Colossus"))
		JoinFormation(FindEntity("Belle Isle"), FindEntity("Colossus"))
		JoinFormation(FindEntity("Trincomalee"), FindEntity("Colossus"))
	
	end
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("April 28th, 1943 - The Azore Islands")
	
	Blackout(true, "", true)
	
	for idx,unit in pairs(Mission.Airfields) do

		local planeTypes = {
		134,
		134,
		}
		local slotIndex = LaunchSquadron(unit,luaPickRnd(planeTypes),3)
		
		ayeyo = thisTable[tostring(GetProperty(unit, "slots")[slotIndex].squadron)]
		
		SetSkillLevel(ayeyo, Mission.SkillLevel)
		
	end
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.BCFleet[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	NavigatorMoveOnPath(Mission.CAFleet[1], FindEntity("CAPath"), PATH_FM_CIRCLE, pathDir)
	
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
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("CAPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.GermanShips) do
		
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
			
			if luaObj_IsActive("primary", 1) then
				
				local capped = 0
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
				
					if unit.Party == PARTY_JAPANESE then
						
						capped = capped + 1
						
					end
				
				end
				
				if capped == 4 then
					
					Mission.Capped = true
					
				else
					
					Mission.Capped = false
					
					Mission.BasesLeft = capped
				
					local line1 = "Secure all enemy bases!"
					local line2 = "Enemy base(s) captured: #Mission.BasesLeft#"
					luaDisplayScore(1, line1, line2)
					
					if not Mission.AshoreDiaPlayed then
						
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HQs)) do
							
							if unit.Party == PARTY_ALLIED or unit.Party == PARTY_NEUTRAL then
							
								local cap = GetCapturePercentage(unit)
								
								if cap > 0 then
								
									luaStartDialog("ASHORE")
									
									Mission.AshoreDiaPlayed = true
								
								end
							
							end
							
						end
						
					end
					
				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Transports)) == 0 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) <= 1 then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.KeyUnits)) == 0 then
					
					luaDelay(luaHidePh2Score, 1)
					
					luaObj_Completed("primary", 4, true)
					
					Mission.Destroyed = true
					
				else
				
					Mission.TrgsLeft = table.getn(luaRemoveDeadsFromTable(Mission.KeyUnits))
				
					local line1 = "Destroy all enemy key units!"
					local line2 = "Key unit(s) left: #Mission.TrgsLeft#"
					luaDisplayScore(2, line1, line2)
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cruisers)) == 0 then
				
					luaObj_Completed("secondary", 1, true)
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.GermanShips)) <= 12 then
					
					luaObj_Failed("hidden",1)
					
					luaStartDialog("MAYDAY")
				
				end
			
			end
			
			if Mission.Capped and Mission.Destroyed then
			
				if Mission.Richie and not Mission.SetToComplete then
					
					if table.getn(luaRemoveDeadsFromTable(Mission.Transports)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Transports)) do
							
							if unit and not unit.Dead then
							
								SetInvincible(unit, 0.01)
							
							end
							
						end
					
					end
					
					HideUnitHP()
					luaDelay(luaHidePh1Score, 1)
					luaDelay(luaHidePh2Score, 1)
					
					luaObj_Completed("primary",1)
					luaObj_Completed("primary",2)
					luaObj_Completed("primary",3)
					
					luaStartDialog("FINAL")
					
					Mission.SetToComplete = true
					Mission.EndMission = true
					
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.BlyatCVs)) > 0 then
				
				local afs = {}
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.BlyatCVs)) do
					
					if unit and not unit.Dead then
					
						if idx == 1 or idx == 2 then
						
							table.insert(afs, unit)
						
						end
					
					end
					
				end
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(afs)) do
				
					if unit and not unit.Dead and unit.Party == PARTY_ALLIED then
						
						local fighters = {
							[1] = 134,
						}
						local bombers = {
							[1] = 109,
							[2] = 336,
						}
						
						local wngCount = 3
						
						--[[if Mission.Difficulty == 0 then
							
							wngCount = 3
							--heavyBomber = false
						
						elseif Mission.Difficulty == 1 then
							
							wngCount = 4
							--heavyBomber = true
						
						elseif Mission.Difficulty == 2 then
							
							wngCount = 5
							--heavyBomber = true
						
						end]]
						
						local trgs
						
						if Mission.Difficulty == 2 then
						
							trgs = Mission.Transports
						
						else
						
							--if table.getn(luaRemoveDeadsFromTable(Mission.JapCapitalShips)) > 0 then
							
								trgs = Mission.GermanShips
							
							--end
						
						end
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs), nil, wngCount)
						
					end
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Targeteers)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Targeteers)) do
				
					if unit and not unit.Dead then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
							local trgs = Mission.GermanShips
							
							if Mission.Difficulty == 2 then
							
								trgs = Mission.Transports
							
							else
							
								if table.getn(luaRemoveDeadsFromTable(Mission.CapitalShips)) > 0 then
								
									trgs = Mission.CapitalShips
								
								end
							
							end
							
							local ordered = luaSortByDistance(unit, luaRemoveDeadsFromTable(trgs))
							local closest = ordered[1]
							
							luaSetScriptTarget(unit, closest)
							NavigatorAttackMove(unit, closest)
						
						end
						
					end
				
				end
				
			end
			
			if not Mission.SunkDiaPlayed then
			
				if Mission.Richelieu.Dead then
				
					luaStartDialog("SUNK")
					
					Mission.SunkDiaPlayed = true
				
				end
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 1 ----

function luaAllowEnd()

	Mission.Richie = true

end

function luaRichelieuMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.GermanShips)))
	
	end

end

function luaRichelieuDia()

	luaStartDialog("VESSEL")

end

function luaHidePh2Score()

	HideScoreDisplay(2,0)

end

function luaHidePh1Score()

	HideScoreDisplay(1,0)

end

function luaIntroMovie()
	
	luaDelay(luaIntroDia, 3)
	
	local trg1 = FindEntity("CB1")
	local trg2 = FindEntity("HQ1")
	local trg3 = FindEntity("HQ2")
	Mission.IntroMovieTrg = FindEntity("Admiral Graf Spee")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 7, ["rho"] = -250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 7, ["rho"] = -250, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 200, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 7, ["rho"] = 200, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 7, ["rho"] = 300, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 7, ["rho"] = 300, ["moveTime"] = 7,},
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = Mission.IntroMovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIn, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIn()
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.IntroMovieTrg)
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()
	
	luaObj_Add("primary", 1, Mission.HQs)
	luaObj_Add("primary", 2, Mission.Transports)
	luaObj_Add("primary", 3, Mission.CapitalShips)
	luaObj_Add("primary", 4, Mission.KeyUnits)
	luaObj_Add("secondary", 1)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Transports), "Protect your transports!")
	
	luaAddAFListener()
	luaAddRichelieuListener()
	
end

---- LISTENERS ----

function luaAddRichelieuListener()

	AddListener("recon", "RichelieuListener", {
		["callback"] = "luaRichelieuSighted",
		["entity"] = {Mission.Richelieu},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddAFListener()

	AddListener("recon", "AFListener", {
		["callback"] = "luaAFSighted",
		["entity"] = Mission.Airfields,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

---- LISTENER CALLBACKS ----

function luaRichelieuSighted()
	
	RemoveListener("recon", "RichelieuListener")
	
	table.insert(Mission.Targeteers, Mission.Richelieu)
	
	luaDelay(luaRichelieuDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.Richelieu, ["distance"] = 100, ["theta"] = 1, ["rho"] = 5, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	{["postype"] = "cameraandtarget", ["target"] = Mission.Richelieu, ["distance"] = 110, ["theta"] = 1, ["rho"] = 3, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
        {["postype"] = "cameraandtarget", ["target"] = Mission.Richelieu, ["distance"] = 200, ["theta"] = 5, ["rho"] = 3, ["moveTime"] = 6, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		
	}, luaRichelieuMovieEnd, true)
	
end

function luaAFSighted()
	
	RemoveListener("recon", "AFListener")
	
	luaStartDialog("AF")
	
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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.HQs)), "The Azores have been conquered - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaDelay(luaHidePh1Score, 1)
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		luaDelay(luaHidePh2Score, 1)
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
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