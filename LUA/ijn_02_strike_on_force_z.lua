---- STRIKE ON FORCE Z (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- STRIKE ON FORCE Z (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(167) 	-- Betty
	PrepareClass(166) 	-- Nell
	
	PrepareClass(77) 	-- Gyoriatei
	
	PrepareClass(134) 	-- Hurricane
	
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
	
	LoadMessageMap("ijndlg",2)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_02_strike_on_force_z.lua"

	this.Name = "IJN02"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Attack",
				["Text"] = "Attack the enemy fleet!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Dest",
				["Text"] = "Destroy Force Z!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Trans",
				["Text"] = "Destroy the enemy landing force!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Prot",
				["Text"] = "Don't lose any of your transports!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Lose",
				["Text"] = "Don't lose any of your ships!",
				["TextFailed"] = "One of your ships is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Hit",
				["Text"] = "Don't let any of your transports get hit!",
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
					["time"] = 1,
				},
				{
					["message"] = "idlg01c",
				},
				{
					["message"] = "idlg01d",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "idlg01b",
				},
			},
		},
		["BBS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
				{
					["message"] = "dlg13a_1",
				},
				{
					["message"] = "dlg13b",
				},
			},
		},
		["HIT"] = {--
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
			},
		},
		["FIRE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
			},
		},
		["LISTING"] = {--
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["ENGINE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["MAGAZINE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["ALMOST"] = {--
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["BOTTOM"] = {--
			["sequence"] = {
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
			},
		},
		["FIGHTERS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
			},
		},
		["ESCORT"] = {--
			["sequence"] = {
				{
					["message"] = "ESCORT1",
				},
				{
					["message"] = "ESCORT2",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "dlg23",
				},
				{
					["message"] = "dlg23_1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["BUFFALOES1"] = {--
			["sequence"] = {
				{
					["message"] = "dlg30f",
				},
				{
					["message"] = "dlg30g",
				},
				{
					["message"] = "dlg24a",
				},
				{
					["message"] = "dlg24b",
				},
				{
					["message"] = "dlg24c",
				},
			},
		},
		["BUFFALOES2"] = {--
			["sequence"] = {
				{
					["message"] = "dlg31a",
				},
				{
					["message"] = "dlg31b",
				},
			},
		},
		["TRANS"] = {--
			["sequence"] = {
				{
					["message"] = "TRANS1",
				},
				{
					["message"] = "TRANS2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddTransObj",
				},
			},
		},
		["SOS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19a",
				},
				{
					["message"] = "dlg19b",
				},
				{
					["message"] = "dlg19c",
				},
			},
		},
	}
	
	---- DIFFICULTY SETTING ----
	
	Mission.Difficulty = GetDifficulty()
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_ELITE
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
	
	Mission.Airfield = FindEntity("AirField 02")
	
	--[[Mission.Ph1AttackerAmmos = {}
		table.insert(Mission.Ph1AttackerAmmos, 1)
		table.insert(Mission.Ph1AttackerAmmos, 1)
		table.insert(Mission.Ph1AttackerAmmos, 2)
		table.insert(Mission.Ph1AttackerAmmos, 1)
		table.insert(Mission.Ph1AttackerAmmos, 1)
		table.insert(Mission.Ph1AttackerAmmos, 2)
		table.insert(Mission.Ph1AttackerAmmos, 1)
		table.insert(Mission.Ph1AttackerAmmos, 2)]]
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Kamikawa Maru"))
		table.insert(Mission.CargoGang, FindEntity("Kiyokawa Maru"))
		table.insert(Mission.CargoGang, FindEntity("Hirokawa Maru"))
		table.insert(Mission.CargoGang, FindEntity("Kimikawa Maru"))
		
	Mission.CivilGang = {}
		table.insert(Mission.CivilGang, FindEntity("Akitsushima Maru"))
		table.insert(Mission.CivilGang, FindEntity("Nisshin Maru"))
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		UnitSetFireStance(unit, 0)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		
	end
	
	for idx,unit in pairs(Mission.CivilGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		UnitSetFireStance(unit, 0)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		
	end
	
	Mission.JapGang = {}
		table.insert(Mission.JapGang, FindEntity("Kamikawa Maru"))
		table.insert(Mission.JapGang, FindEntity("Kiyokawa Maru"))
		table.insert(Mission.JapGang, FindEntity("Hirokawa Maru"))
		table.insert(Mission.JapGang, FindEntity("Kimikawa Maru"))
		table.insert(Mission.JapGang, FindEntity("Akitsushima Maru"))
		table.insert(Mission.JapGang, FindEntity("Nisshin Maru"))
	
	JoinFormation(FindEntity("Nisshin Maru"), FindEntity("Akitsushima Maru"))
	NavigatorMoveOnPath(FindEntity("Akitsushima Maru"), FindEntity("MaruPath"), PATH_FM_CIRCLE)
	
	Mission.Ph1Attackers = {}
	Mission.Ph1AttackersDead = {}
	
	SetRoleAvailable(FindEntity("Command Station 02"), EROLF_ALL, PLAYER_AI)
	
	---- USN ----
	
	UnitSetFireStance(FindEntity("CB5"), 0)
	SetInvincible(FindEntity("CB5"), 0.4)
	
	Mission.ForceZGang = {}
		table.insert(Mission.ForceZGang, FindEntity("Howe"))
		table.insert(Mission.ForceZGang, FindEntity("Anson"))
		--table.insert(Mission.ForceZGang, FindEntity("Hood"))
		--table.insert(Mission.ForceZGang, FindEntity("Duke of York"))
		table.insert(Mission.ForceZGang, FindEntity("Jamaica"))
		table.insert(Mission.ForceZGang, FindEntity("Zulu"))
		table.insert(Mission.ForceZGang, FindEntity("Mohawk"))
		--table.insert(Mission.ForceZGang, FindEntity("Punjabi"))
	
	for idx,unit in pairs(Mission.ForceZGang) do
		
		JoinFormation(unit, Mission.ForceZGang[1])
		SetShipMaxSpeed(unit, 10)
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
	
	local leader1 = Mission.ForceZGang[1]
	
	if leader1 and not leader1.Dead then
	
		local cringe = luaRnd(1, 3)
		
		local path
		
		if cringe == 1 then
		
			path = FindEntity("ForceZPath2")
			
		elseif cringe == 2 then
		
			path = FindEntity("ForceZPath2")
		
		elseif cringe == 3 then
			
			path = FindEntity("ForceZPath3")
		
		end
		
		Mission.ForceZPath = path
		
		NavigatorMoveOnPath(leader1, path, PATH_FM_SIMPLE)
		
	end
	
	Mission.ForceZBBs = {}
		table.insert(Mission.ForceZBBs, FindEntity("Howe"))
		table.insert(Mission.ForceZBBs, FindEntity("Anson"))
		--table.insert(Mission.ForceZBBs, FindEntity("Hood"))
		--table.insert(Mission.ForceZBBs, FindEntity("Duke of York"))
	
	for idx,unit in pairs(Mission.ForceZGang) do
		
		if not Mission.Realistic then
		
			OverrideHP(unit, (unit.Class.HP * 1.5))
		
		else
		
			OverrideHP(unit, (unit.Class.HP_Realistic * 1.5))
		
		end
		
	end
	
	Mission.BritGang = {}
		table.insert(Mission.BritGang, FindEntity("Howe"))
		table.insert(Mission.BritGang, FindEntity("Anson"))
		--table.insert(Mission.BritGang, FindEntity("Hood"))
		--table.insert(Mission.BritGang, FindEntity("Duke of York"))
		table.insert(Mission.BritGang, FindEntity("Jamaica"))
		table.insert(Mission.BritGang, FindEntity("Zulu"))
		table.insert(Mission.BritGang, FindEntity("Mohawk"))
		table.insert(Mission.BritGang, FindEntity("Punjabi"))
	
	Mission.Buffaloes = {}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.AttackWaves = 0
	Mission.AttackWavesMax = 5
	--Mission.Ph1AttackerAmmoTracker = 1
	Mission.NextWaveCanSpawn = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		--Mission.HermesCPADelay = 450
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		--Mission.HermesCPADelay = 375
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		--Mission.HermesCPADelay = 300
		
	end
	
	---- INIT FUNCT. ----
	
	BannSupportmanager()
	
	SetSimplifiedReconMultiplier(1.2)
	
	Blackout(true, "", true)
	EnableMessages(false)
	
	MissionNarrative("December 12th, 1941 - Near Kota Baru")
	
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
	
	--luaShowPath(FindEntity("ForceZPath1"))
	
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
	
		--luaStartMission()
		
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
		
			if Mission.CanCheckMusic then
			
				local music_selectedUnit = GetSelectedUnit()

				if music_selectedUnit then

					luaCheckMusic(music_selectedUnit)

				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.ForceZBBs)) > 0 then
			
				--[[if not Mission.FireDiaPlayed then
					
					luaCheckFailure(luaRemoveDeadsFromTable(Mission.ForceZBBs), "Fire")
				
				end]]
				
				if not Mission.EngineFailureDiaPlayed then
				
					luaCheckFailure(luaRemoveDeadsFromTable(Mission.ForceZBBs), "EngineJam")
				
				end
				
				if not Mission.MagazineFailurePlayed then
				
					luaCheckFailure(luaRemoveDeadsFromTable(Mission.ForceZBBs), "Explosion")
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.ForceZBBs)) == 1 then
					
					local unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZBBs))
					
					if GetHpPercentage(unit) <= 0.4 and not Mission.ListingDiaPlayed then
					
						luaStartDialog("LISTING")
						
						Mission.ListingDiaPlayed = true
						
					end
					
					--[[if GetHpPercentage(unit) <= 0.1 and not Mission.AlmostDiaPlayed then
					
						luaStartDialog("ALMOST")
						
						Mission.AlmostDiaPlayed = true
						
					end]]
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.ForceZBBs)) == 1 and not Mission.SunkDiaPlayed then
					
					luaStartDialog("BOTTOM")
					
					Mission.SunkDiaPlayed = true
				
				end
				
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				Mission.AttackWavesLeft = Mission.AttackWavesMax - Mission.AttackWaves
				
				local line1 = "Attack the enemy fleet!"
				local line2 = "Attack wave(s) left: #Mission.AttackWavesLeft#"
				luaDisplayScore(1, line1, line2)
			
			end
			
			if Mission.NextWaveCanSpawn or table.getn(luaRemoveDeadsFromTable(Mission.Ph1AttackersDead)) == 0 then
			
				if Mission.AttackWaves < Mission.AttackWavesMax then
				
					luaSpawnNextAttackWave()
					
				else
				
					if not Mission.Bruh then
						
						luaDelay(luaPh1End, 10)
						
						Mission.Bruh = true
						
					end
				
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Ph1Attackers)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Ph1Attackers)) do
					
					if unit and not unit.Dead then
					
						if GetProperty(unit, "ammoType") == 0 and not unit.retreating then
							
							SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
							UnitHoldFire(unit)
							PilotRetreat(unit)
							
							table.remove(Mission.Ph1AttackersDead, idx)
							
							unit.retreating = true
						
						end
					
					end
					
				end
			
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.ForceZBBs)) == 1 and not Mission.SetInvincible then
			
				Mission.InvincibleBB = luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZBBs))
				
				SetInvincible(Mission.InvincibleBB, 0.01)
				
				Mission.SetInvincible = true
			
			end
			
		elseif Mission.MissionPhase == 2 then
			
			Mission.ForceZGang = luaRemoveDeadsFromTable(Mission.ForceZGang)
			
			if luaObj_IsActive("primary", 2) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.ForceZGang)) == 0 then
					
					HideUnitHP()
					
					luaObj_Completed("primary", 2)
					
					Mission.ForceZSunk = true
					
				else
				
					local checkUnit = luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZGang))
					
					if checkUnit and not checkUnit.Dead then
					
						if luaGetDistance(checkUnit, FindEntity("CB5")) < 6000 and not Mission.DDsBruh then
						
							luaDDsAttack()
							
							Mission.DDsBruh = true
						
						end
					
					end
					
				end
				
			end
			
			if luaObj_IsActive("primary", 3) then
				
				Mission.InvasionLeft = table.getn(luaRemoveDeadsFromTable(Mission.InvasionGang))
				
				local line1 = "Destroy the enemy invasion fleet!"
				local line2 = "Invasion ship(s) left: #Mission.InvasionLeft#"
				luaDisplayScore(2, line1, line2)
				
				if Mission.InvasionLeft == 0 then
					
					HideScoreDisplay(2,0)
					
					luaObj_Completed("primary", 3)
					
					Mission.TransportsSunk = true
					
				end
				
			end
			
			if Mission.ForceZSunk and Mission.TransportsSunk then
			
				if IsListenerActive("hit", "CargoHitListener") then
				
					RemoveListener("hit", "CargoHitListener")
				
				end
				
				if IsListenerActive("recon", "FighterListener") then
				
					RemoveListener("recon", "FighterListener")
				
				end
				
				--[[if IsListenerActive("recon", "HermesListener") then
				
					RemoveListener("recon", "HermesListener")
				
				end]]
				
				if IsListenerActive("recon", "TransListener") then
				
					RemoveListener("recon", "TransListener")
				
				end
				
				EnableMessages(false)
				
				--Blackout(true, "luaMissionEndMovie", 1)
				
				luaDelay(luaFinalDia, 3)
				
				if luaObj_IsActive("secondary",1) then
				
					luaObj_Completed("secondary", 1)
				
				end
				
				if luaObj_IsActive("hidden",1) then
				
					luaObj_Completed("hidden", 1)
				
				end
			
			end
			
			if luaObj_IsActive("primary", 4) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.CargoGang)) <= 3 then
					
					if IsListenerActive("hit", "CargoHitListener") then
					
						RemoveListener("hit", "CargoHitListener")
					
					end
					
					if IsListenerActive("recon", "FighterListener") then
					
						RemoveListener("recon", "FighterListener")
					
					end
					
					--[[if IsListenerActive("recon", "HermesListener") then
					
						RemoveListener("recon", "HermesListener")
					
					end]]
					
					HideUnitHP()
					
					luaMissionFailed(luaPickRnd(Mission.CargoGang))
					
					Mission.EndMission = true
					
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
				
				local checkNum
				
				if Mission.BonusHere then
				
					checkNum = 16
				
				else
				
					checkNum = 15
				
				end
				
				if table.getn(luaRemoveDeadsFromTable(Mission.JapGang)) <= checkNum then
					
					luaObj_Failed("secondary", 1, true)
					
				end
			
			end
			
			--[[if Mission.Hermes and not Mission.Hermes.Dead then
			
				luaCapManager(Mission.Hermes, {134}, 1)
				
			else
				
				if not Mission.HermesGangOut then
				
					if table.getn(luaRemoveDeadsFromTable(Mission.HermesGang)) > 0 then
					
						for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HermesGang)) do
							
							if unit and not unit.Dead then
							
								NavigatorMoveToRange(unit, GetClosestBorderZone(GetPosition(unit)))
							
							end
							
						end
					
					end
					
					Mission.HermesGangOut = true
				
				end
				
			end]]
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 2 ----

--[[function luaHermesCAP()
	
	if not Mission.EndMission then
	
		if Mission.Hermes and not Mission.Hermes.Dead then

			if IsReadyToSendPlanes(Mission.Hermes) then
				
				local planeTypes = {
									134,
									134,
									}
				local slotIndex = LaunchSquadron(Mission.Hermes,luaPickRnd(planeTypes),3)
				Mission.HermesCAP = thisTable[tostring(GetProperty(Mission.Hermes, "slots")[slotIndex].squadron)]
				SetSkillLevel(Mission.HermesCAP, Mission.SkillLevel)
				PilotMoveToRange(Mission.HermesCAP, luaPickRnd(luaRemoveDeadsFromTable(Mission.BritGang)))
				
				--[[if not Mission.FighterListenerAdded then
				
					luaAddFighterListener()
					
					Mission.FighterListenerAdded = true
					
				end]]
				
			end
			
			luaDelay(luaHermesCAP, Mission.HermesCPADelay)
			
		end
	
	end
	
end]]

--[[function luaMissionEndMovie()
	
	Blackout(false, "", 1)
	
	local trg = luaPickRnd(Mission.ForceZGang)
	
	luaDelay(luaFinalDia, 1)
	
	luaIngameMovie(
	{
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-75,["y"]=44,["z"]=75},["parent"] = trg,},["moveTime"] = 0,["transformtype"] = "keepnone",},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=0,["z"]=0},["parent"] = trg,},["moveTime"] = 0,["transformtype"] = "keepnone",},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-75,["y"]=-100,["z"]=75},["parent"] = trg,},["moveTime"] = 20,["transformtype"] = "keepnone",},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=-100,["z"]=0},["parent"] = trg,},["moveTime"] = 20,["transformtype"] = "keepnone",},
		{["postype"] = "cameraandtarget", ["position"] = {}, ["moveTime"] = 0, ["transformtype"] = "keepall",},
	}, nil)
	
end]]

function luaFinalDia()

	luaStartDialog("FINAL", nil, nil, true)

end

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	if IsListenerActive("hit", "BBHitListener") then
	
		RemoveListener("hit", "BBHitListener")
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Ph1Attackers)) > 0 then
	
		for idx,plane in pairs(luaRemoveDeadsFromTable(Mission.Ph1Attackers)) do
			
			if plane and not plane.Dead then
			
				Kill(plane, true)
				
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Buffaloes)) > 0 then
	
		for idx,plane in pairs(luaRemoveDeadsFromTable(Mission.Buffaloes)) do
			
			if plane and not plane.Dead then
			
				Kill(plane, true)
				
			end
			
		end
	
	end
	
	--Mission.JapGang = {}
		table.insert(Mission.JapGang, GenerateObject("Furutaka"))
		table.insert(Mission.JapGang, GenerateObject("Miya"))
		table.insert(Mission.JapGang, GenerateObject("Yugumo"))
		table.insert(Mission.JapGang, GenerateObject("Onami"))
		table.insert(Mission.JapGang, GenerateObject("Akigumo"))
		table.insert(Mission.JapGang, GenerateObject("Fujinami"))
		table.insert(Mission.JapGang, GenerateObject("Umidori"))
		table.insert(Mission.JapGang, GenerateObject("Mizutori"))
		table.insert(Mission.JapGang, GenerateObject("Natori"))
		table.insert(Mission.JapGang, GenerateObject("Minekaze"))
	
	Mission.JapFighters = {}
		table.insert(Mission.JapFighters, FindEntity("Furutaka"))
		table.insert(Mission.JapFighters, FindEntity("Miya"))
		table.insert(Mission.JapFighters, FindEntity("Yugumo"))
		table.insert(Mission.JapFighters, FindEntity("Onami"))
		table.insert(Mission.JapFighters, FindEntity("Akigumo"))
		table.insert(Mission.JapFighters, FindEntity("Fujinami"))
		table.insert(Mission.JapFighters, FindEntity("Umidori"))
		table.insert(Mission.JapFighters, FindEntity("Mizutori"))
		table.insert(Mission.JapFighters, FindEntity("Natori"))
		table.insert(Mission.JapFighters, FindEntity("Minekaze"))
	
	if Mission.Difficulty < 2 then
		
		table.insert(Mission.JapGang, GenerateObject("Ishizuchi"))
		table.insert(Mission.JapFighters, FindEntity("Ishizuchi"))
		
		Mission.BonusHere = true
		
	end
	
	for idx,unit in pairs(Mission.JapGang) do
		
		--JoinFormation(unit, Mission.JapGang[1])
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
	
	JoinFormation(FindEntity("Onami"), FindEntity("Furutaka"))
	JoinFormation(FindEntity("Yugumo"), FindEntity("Furutaka"))
	
	Mission.InvasionGang = {}
		--table.insert(Mission.InvasionGang, GenerateObject("King Goerge V"))
		table.insert(Mission.InvasionGang, GenerateObject("Nigeria"))
		table.insert(Mission.InvasionGang, GenerateObject("Newfoundland"))
		table.insert(Mission.InvasionGang, GenerateObject("Ceylon"))
		table.insert(Mission.InvasionGang, GenerateObject("Trinidad"))
		table.insert(Mission.InvasionGang, GenerateObject("Loyal"))
		table.insert(Mission.InvasionGang, GenerateObject("Legion"))
		table.insert(Mission.InvasionGang, GenerateObject("Laforey"))
		table.insert(Mission.InvasionGang, GenerateObject("Lightning"))
		table.insert(Mission.InvasionGang, GenerateObject("Fort Victoria"))
		table.insert(Mission.InvasionGang, GenerateObject("Wave Ruler"))
		table.insert(Mission.InvasionGang, GenerateObject("Fort Austin"))
		table.insert(Mission.InvasionGang, GenerateObject("Fort Rosalie"))
	
		--table.insert(Mission.BritGang, FindEntity("King Goerge V"))
		table.insert(Mission.BritGang, FindEntity("Nigeria"))
		table.insert(Mission.BritGang, FindEntity("Newfoundland"))
		table.insert(Mission.BritGang, FindEntity("Ceylon"))
		table.insert(Mission.BritGang, FindEntity("Trinidad"))
		table.insert(Mission.BritGang, FindEntity("Loyal"))
		table.insert(Mission.BritGang, FindEntity("Legion"))
		table.insert(Mission.BritGang, FindEntity("Laforey"))
		table.insert(Mission.BritGang, FindEntity("Lightning"))
		table.insert(Mission.BritGang, FindEntity("Fort Victoria"))
		table.insert(Mission.BritGang, FindEntity("Wave Ruler"))
		table.insert(Mission.BritGang, FindEntity("Fort Austin"))
		table.insert(Mission.BritGang, FindEntity("Fort Rosalie"))
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ForceZGang)) do
		
		SetShipMaxSpeed(unit, unit.Class.MaxSpeed)
		
	end
	
	for idx,unit in pairs(Mission.InvasionGang) do
		
		JoinFormation(unit, Mission.InvasionGang[1])
		SetShipMaxSpeed(unit, 7)
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
	
	--[[if not Mission.Realistic then
	
		OverrideHP(FindEntity("King Goerge V"), (FindEntity("King Goerge V").Class.HP * 1.5))
	
	else
	
		OverrideHP(FindEntity("King Goerge V"), (FindEntity("King Goerge V").Class.HP_Realistic * 1.5))
	
	end]]
	
	--[[Mission.Hermes = GenerateObject("Hermes")
	
	SetShipMaxSpeed(Mission.Hermes, 5)
	
	Mission.HermesGang = {}
		table.insert(Mission.HermesGang, Mission.Hermes)
		table.insert(Mission.HermesGang, GenerateObject("Cossack"))
		table.insert(Mission.HermesGang, GenerateObject("Haida"))
		table.insert(Mission.HermesGang, GenerateObject("Tribal"))
	
	for idx,unit in pairs(Mission.HermesGang) do
		
		JoinFormation(unit, Mission.HermesGang[1])
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
		
	end]]
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Loading_Finish()
	
	luaPh2Movie()
	
end

function luaPh2Movie()

	Blackout(false, "", 1)
	
	Mission.Ph2MovieTrg = luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFighters))
	
	luaIngameMovie(
	{
	 
	 {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	 {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	 {["postype"] = "cameraandtarget", ["target"] = Mission.Ph2MovieTrg, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
	 
	}, luaPh2MovieEnd, true)
	
end

function luaPh2MovieEnd()
	
	HideScoreDisplay(1,0)
	
	if Mission.SetInvincible and Mission.InvincibleBB and not Mission.InvincibleBB.Dead then
	
		SetInvincible(Mission.InvincibleBB, 0.0)
	
	end
	
	--NavigatorMoveOnPath(Mission.Hermes, Mission.ForceZPath, PATH_FM_SIMPLE)
	
	Mission.InvasionGang = luaRemoveDeadsFromTable(Mission.InvasionGang)
	
	local leader2 = GetFormationLeader(Mission.InvasionGang[1])
	
	if leader2 and not leader2.Dead then
		
		NavigatorMoveOnPath(leader2, FindEntity("ForceZPath2"), PATH_FM_SIMPLE)
		
	end
	
	--[[for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ForceZGang)) do
		
		if unit and not unit.Dead then
		
			luaCheckDistance(unit, GetPosition(FindEntity("Command Station 02")), 4000, luaDDsAttack)
		
		end
		
	end]]
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		StartLanding2(unit)
		
	end
	
	PermitSupportmanager()
	
	SetSelectedUnit(Mission.Ph2MovieTrg)
	
	Mission.CanCheckMusic = true
	
	luaAddSecObjs()
	
end

function luaDDsAttack()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.ForceZGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ForceZGang)) do
			
			if unit and not unit.Dead then
			
				--luaClearCheckDistance(unit, GetPosition(FindEntity("Command Station 02")))
				
				if Mission.Difficulty > 0 then
				
					if unit.Class.Type == "Destroyer" then
					
						LeaveFormation(unit)
						
						NavigatorAttackMove(unit, luaPickRnd(luaRemoveDeadsFromTable(Mission.JapGang)))
						
						UnitSetFireStance(unit, 2)
					
					end
				
				end
				
			end
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.CivilGang)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CivilGang)) do
			
			if unit and not unit.Dead then
			
				NavigatorMoveToRange(unit, FindEntity("MaruEscape"))
				
			end
			
		end
	
	end
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.ForceZGang)
	luaObj_Add("primary", 4)
	luaObj_Add("secondary", 1, Mission.CargoGang)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.ForceZGang)), "Destroy Force Z!")
	
	--luaAddHermesListener()
	luaAddTransListener()
	
	--luaDelay(luaHermesCAP, 20)
	
end

function luaCheckFailure(units, failure)
	
	if table.getn(luaRemoveDeadsFromTable(units)) > 0 then
		
		for idx,unit in pairs(luaRemoveDeadsFromTable(units)) do
			
			local failureState = GetFailure(unit, failure)
			
			--[[if failureState == false and failure == "Fire" then
				
				luaStartDialog("FIRE")
				
				Mission.FireDiaPlayed = true
			
			else]]if failureState == true and failure == "EngineJam" then
				
				luaStartDialog("ENGINE")
				
				Mission.EngineFailureDiaPlayed = true
				
			elseif failureState == true and failure == "Explosion" then
			
				luaStartDialog("MAGAZINE")
				
				luaDelay(luaFireDia, 12)
				
				Mission.MagazineFailurePlayed = true
			
			end
		
		end
		
	end
	
end

function luaFireDia()

	luaStartDialog("FIRE")

end

function luaAddTransObj()

	luaObj_Add("primary", 3, Mission.InvasionGang)

end

---- PHASE 1 ----

function luaPh1End()

	luaObj_Completed("primary", 1)
	
	Blackout(true, "luaMoveToPh2", 1)

end

function luaIntroMovie()
	
	Blackout(false, "", 3)
	
	local trg = Mission.ForceZGang[1]
	
	luaDelay(luaIntroDia, 3)
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 70, ["theta"] = -3, ["rho"] = 30, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 70, ["theta"] = 4, ["rho"] = 42, ["moveTime"] = 5},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 70, ["theta"] = 4, ["rho"] = 42, ["moveTime"] = 5},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-250,["y"]=14,["z"]=-200},["parent"] = trg,},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=2,},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=50,["y"]=12,["z"]=100},["parent"] = trg,},["moveTime"] = 0,["transformtype"] = "keepnone",["zoom"]=2,},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-250,["y"]=14,["z"]=-200},["parent"] = trg,},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=2,},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=50,["y"]=12,["z"]=100},["parent"] = trg,},["moveTime"] = 4,["transformtype"] = "keepnone",["zoom"]=2,},
		
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 100, ["theta"] = 2, ["rho"] = -245, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 250, ["theta"] = 3, ["rho"] = -270, ["moveTime"] = 6},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 600, ["theta"] = 3, ["rho"] = -270, ["moveTime"] = 6},
		
		--[[{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 50, ["theta"] = 5, ["rho"] = 255, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = Mission.MovieTrg, ["distance"] = 43, ["theta"] = 5, ["rho"] = 195, ["moveTime"] = 6},
		{["postype"]="cameraandtarget",
		["position"]= {
			["terrainavoid"] = true,
			["parentID"]= Mission.MovieTrg.ID,
			["modifier"] = {
					["name"] = "gamecamera",
				},
			},
		["transformtype"]="keepall",
		["starttime"]=0.0,
		["blendtime"]=1.5,
		["wanderer"]=false,
		["zoom"] = 1,},]]
    },
	luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()
	
	SetSelectedUnit(Mission.MovieTrg)
	
	SetInvincible(Mission.MovieTrg, 0.0)
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.ForceZGang)
	
	EnableMessages(true)
	
	luaStartDialog("BBS")
	
	luaAddBBHitListener()
	
end

function luaSpawnNextAttackWave()
	
	if Mission.AttackWaves < Mission.AttackWavesMax then
		
		local bomberNum = 3
		local ammos = {1, 1, 2}
		
		--local pos = GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZGang)))
		--pos.z = pos.z - 500
		
		for i = 1, bomberNum do
			
			--pos.z = pos.z + 500
			
			local bomberTypes = {167, 166}
			local chosenBomber = luaPickRnd(bomberTypes)
			--local ammo = Mission.Ph1AttackerAmmos[Mission.Ph1AttackerAmmoTracker]
			
			luaSpawnJap(chosenBomber, 3, GetPosition(luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZGang))), ammos[i], random(-1000,0), random(1000,1300), random(-7000,-8500))
			
			--table.remove(Mission.Ph1AttackerAmmos, Mission.Ph1AttackerAmmoTracker)
			
			--Mission.Ph1AttackerAmmoTracker = Mission.Ph1AttackerAmmoTracker + 1
			
		end
		
		Mission.AttackWaves = Mission.AttackWaves + 1
		Mission.NextWaveCanSpawn = false
		
		if Mission.AttackWaves == 3 then
		
			luaStartDialog("SOS")
		
		end
		
		luaDelay(luaSpawnBuffaloes, 2)
		luaDelay(luaAllowNextWave, 90)
		
	end
	
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
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.ForceZBBs))
	local unitPos = GetPosition(unit)
	
	SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
	EntityTurnToEntity(unit, trg)
	SquadronSetTravelAlt(unit, unitPos.y, true)
	SquadronSetSpeed(unit, KMH(150))
	PilotSetTarget(unit, trg)
	
	--SquadronSetBaseUnsupported(unit, Mission.Airfield)
	
	table.insert(Mission.Ph1Attackers, unit)
	table.insert(Mission.Ph1AttackersDead, unit)
	
	if not Mission.FirstFighterSet then
		
		Mission.MovieTrg = unit
		
		SetInvincible(Mission.MovieTrg, 0.01)
		
		luaIntroMovie()
		
		Mission.FirstFighterSet = true
	
	end
	
end

function luaSpawnBuffaloes()

	if Mission.AttackWaves == 4 and not Mission.BruhGang then
		
		local buffalo1 = GenerateObject("Buffalo_1")
		local buffalo2 = GenerateObject("Buffalo_2")
		
		local trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.Ph1AttackersDead))
		local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.Ph1AttackersDead))
		
		SetSkillLevel(buffalo1, Mission.SkillLevel)
		PilotSetTarget(buffalo1, trg1)
		--UnitSetFireStance(buffalo1, 2)
		
		SetSkillLevel(buffalo2, Mission.SkillLevel)
		PilotSetTarget(buffalo2, trg2)
		--UnitSetFireStance(buffalo2, 2)
		
		table.insert(Mission.Buffaloes, buffalo1)
		table.insert(Mission.Buffaloes, buffalo2)
		
		luaBuffalo1Dia()
		
		Mission.BruhGang = true
	
	--[[elseif Mission.AttackWaves == 5 and not Mission.BrahGang then
		
		local buffalo1 = GenerateObject("Buffalo_1")
		local buffalo2 = GenerateObject("Buffalo_2")
		
		--local trg1 = luaPickRnd(luaRemoveDeadsFromTable(Mission.Ph1AttackersDead))
		--local trg2 = luaPickRnd(luaRemoveDeadsFromTable(Mission.Ph1AttackersDead))
		
		SetSkillLevel(buffalo1, Mission.SkillLevel)
		--PilotSetTarget(buffalo1, trg1)
		UnitSetFireStance(buffalo1, 2)
		
		SetSkillLevel(buffalo2, Mission.SkillLevel)
		--PilotSetTarget(buffalo2, trg2)
		UnitSetFireStance(buffalo2, 2)
		
		table.insert(Mission.Buffaloes, buffalo1)
		table.insert(Mission.Buffaloes, buffalo2)
		
		luaBuffalo2Dia()
		
		Mission.BrahGang = true]]
		
	end

end

function luaAllowNextWave()

	Mission.NextWaveCanSpawn = true

end

function luaBuffalo1Dia()

	luaStartDialog("BUFFALOES1")

end

function luaBuffalo2Dia()

	luaStartDialog("BUFFALOES2")

end

---- LISTENERS ----

function luaAddTransListener()

	AddListener("recon", "TransListener", {
		["callback"] = "luaTransSighted",
		["entity"] = Mission.InvasionGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

--[[function luaAddFighterListener()

	AddListener("recon", "FighterListener", {
		["callback"] = "luaFighterSighted",
		["entity"] = {Mission.HermesCAP},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end]]

--[[function luaAddHermesListener()

	AddListener("recon", "HermesListener", {
		["callback"] = "luaHermesSighted",
		["entity"] = {Mission.Hermes},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end]]

function luaAddBBHitListener()

	AddListener("hit", "BBHitListener", {
		["callback"] = "luaBBHit", 
		["target"] = Mission.ForceZBBs, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end

function luaAddCargoHitListener()

	AddListener("hit", "CargoHitListener", {
		["callback"] = "luaCargoHit", 
		["target"] = Mission.CargoGang, 
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

function luaTransSighted()

	RemoveListener("recon", "TransListener")
	
	luaStartDialog("TRANS")

end

--[[function luaFighterSighted()

	RemoveListener("recon", "FighterListener")
	
	luaStartDialog("FIGHTERS")
	
end]]

--[[function luaHermesSighted()

	RemoveListener("recon", "HermesListener")
	
	luaStartDialog("ESCORT")
	
end]]

function luaBBHit()

	RemoveListener("hit", "BBHitListener")
	
	luaStartDialog("HIT")

end

function luaCargoHit()

	RemoveListener("hit", "CargoHitListener")
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary", 4) then
	
		luaObj_Completed("primary", 4)
	
	end
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CargoGang))
	
	luaMissionCompletedNew(trg, "Force Z is no more - Mission Complete")
	
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
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
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

function luaStartDialog(dialogID, log, ignorePrinted, ignoreBlock)
	
	if not ignoreBlock then
	
		if Mission.EndMission then
		
			return
		
		end
	
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