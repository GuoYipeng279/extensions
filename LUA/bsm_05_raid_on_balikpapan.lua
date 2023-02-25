---- RAID ON BALIKPAPAN (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- RAID ON BALIKPAPAN (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	
	
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
	
	LoadMessageMap("bsmdlg",5)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_05_raid_on_balikpapan.lua"

	this.Name = "BSM05"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Crago",
				["Text"] = "Destroy all Japanese cargo ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "haGAYYYY",
				["Text"] = "The USS John D. Ford must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "lolgay",
				["Text"] = "Eliminate the enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Fortress",
				["Text"] = "Destroy the Japanese fortress!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Fast",
				["Text"] = "Finish the mission before reinforcements arrive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Surv",
				["Text"] = "Both of your destroyers must survive!",
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
		["INTRO"] = {
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
				{
					["message"] = "INTRO4",
				},
				{
					["message"] = "INTRO5",
				},
			},
		},
		["BOATS"] = {
			["sequence"] = {
				{
					["message"] = "BOATS1",
				},
				{
					["message"] = "BOATS2",
				},
			},
		},
		["DD"] = {
			["sequence"] = {
				{
					["message"] = "DD1",
				},
				{
					["message"] = "DD2",
				},
			},
		},
		["CL"] = {
			["sequence"] = {
				{
					["message"] = "CL1",
				},
				{
					["message"] = "CL2",
				},
				{
					["message"] = "RETREAT1",
				},
				{
					["message"] = "RETREAT2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddReinObj",
				},
			},
		},
		--[[["RETREAT"] = {
			["sequence"] = {
				{
					["message"] = "RETREAT1",
				},
				{
					["message"] = "RETREAT2",
				},
			},
		},]]
		["FINAL"] = {
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
		["BOTTOM"] = {
			["sequence"] = {
				{
					["message"] = "BOTTOM1",
				},
			},
		},
		["PARROT"] = {
			["sequence"] = {
				{
					["message"] = "PARROT1",
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
		Mission.SkillLevel = SKILL_SPVETERAN
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
	
	---- USN ----
	
	Mission.Henry = FindEntity("John D. Ford")
	Mission.Parrot = FindEntity("Parrot")
	
	Mission.HenryGang = {}
		table.insert(Mission.HenryGang, Mission.Henry)
		table.insert(Mission.HenryGang, Mission.Parrot)
		
	for idx,unit in pairs(Mission.HenryGang) do
		
		JoinFormation(unit, Mission.HenryGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.AreYouFuckingKiddingMe = {}
		table.insert(Mission.AreYouFuckingKiddingMe, Mission.Henry)
	
	---- IJN ----
	
	Mission.Kawakaze = FindEntity("Kawakaze")
	Mission.PatrollingDD = Mission.Kawakaze
	
	Mission.NavalBase = FindEntity("PTHangar")
	Mission.Fortress = FindEntity("Fortress")
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Unkai Maru"))
		table.insert(Mission.CargoGang, FindEntity("Kuretake Maru"))
		table.insert(Mission.CargoGang, FindEntity("Meiko Maru"))
		table.insert(Mission.CargoGang, FindEntity("Nana Maru"))
		table.insert(Mission.CargoGang, FindEntity("Myoken Maru"))
		table.insert(Mission.CargoGang, FindEntity("Fukusei Maru"))
		table.insert(Mission.CargoGang, FindEntity("Harbin Maru"))
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
		
		end
		
	end
	
	Mission.DDGang = {}
		table.insert(Mission.DDGang, FindEntity("Kawakaze"))
		table.insert(Mission.DDGang, FindEntity("Natsugumo"))
	
	for idx,unit in pairs(Mission.DDGang) do
		
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
	
	Mission.PTGang = {}
		table.insert(Mission.PTGang, FindEntity("Gyoraitei No. 13"))
		table.insert(Mission.PTGang, FindEntity("Gyoraitei No. 14"))
	
	for idx,unit in pairs(Mission.PTGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, false)
		TorpedoEnable(unit, true)
		
	end
	
	Mission.SpawnedPTGang = {}
	
	---- VAR ----
	
	
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.PatrollingDDCounter = 0
	Mission.JapReinTimer = 300
	Mission.PTSpawnedTracker = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.PatrollingPTCounter = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.PatrollingPTCounter = 1
	
	elseif Mission.Difficulty == 2 then
		
		Mission.PatrollingPTCounter = 2
	
	end
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	--EnableInput(false)
	Blackout(true, "", true)
	
	MissionNarrative("January 24th, 1942 - Near Balikpapan")
	
	luaInitNewSystems()
	
	luaIntroMovie()
	
	luaAddFortressListener()
	
	---- THINK ----
	
    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetInvincible(Mission.Henry, 0.4)
	
	--SetSimplifiedReconMultiplier(10.85)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--luaShowPath(FindEntity("path_TP2"))
	--luaShowPath(FindEntity("path_TP3"))
	--luaShowPath(FindEntity("path_Patrol 2"))
	--luaShowPoint(FindEntity("KennedyGoTo"))
	
	--luaMoveToPh2()
	
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
		
		Mission.MissionPhase = 1
		
		luaStartMission()
		
		Mission.Started = true
		
	else

		local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end
		
		if Mission.MissionPhase == 1 and not Mission.Final then
		
			if Mission.JapReinTimer == 0 then
				
				if luaObj_IsActive("hidden", 1) then
				
					luaObj_Failed("hidden", 1)
				
				end
				
				luaMoveToPh2()
				
			else
			
				Mission.JapReinTimer = Mission.JapReinTimer - 1
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase < 99 then
	
		if Mission.Henry.Dead then
			
			HideUnitHP()
			
			luaMissionFailed(Mission.Henry)
		
		end
		
		if luaObj_IsActive("hidden", 2) then
		
			if Mission.Parrot.Dead then
			
				luaObj_Failed("hidden", 2)
				
				luaStartDialog("PARROT")
				
			end
			
		end
		
		if not Mission.NavalBase.Dead then
			
			local henrys = luaGetShipsAround(Mission.NavalBase, 1000, "enemy")
			
			if henrys == nil and table.getn(luaRemoveDeadsFromTable(Mission.SpawnedPTGang)) < Mission.PatrollingPTCounter then
				
				local spawnedPT
				
				if Mission.PTSpawnedTracker == 0 then
					
					local bruh = random(1,2)
					local path
					
					if bruh == 1 then
					
						path = "pt_patrol_1a"
					
					elseif bruh == 2 then
					
						path = "pt_patrol_1b"
					
					end
					
					spawnedPT = GenerateObject("Gyoraitei No. 42")
					
					NavigatorMoveOnPath(spawnedPT, FindEntity(path), PATH_FM_CIRCLE, PATH_SM_BEGIN)
					
					Mission.PTSpawnedTracker = 1
					
				elseif Mission.PTSpawnedTracker == 1 then
					
					local bruh = random(1,2)
					local path
					
					if bruh == 1 then
					
						path = "pt_patrol_1a"
					
					elseif bruh == 2 then
					
						path = "pt_patrol_1b"
					
					end
					
					spawnedPT = GenerateObject("Gyoraitei No. 44")
					
					NavigatorMoveOnPath(spawnedPT, FindEntity(path), PATH_FM_CIRCLE, PATH_SM_BEGIN)
					
					Mission.PTSpawnedTracker = 2
					
				elseif Mission.PTSpawnedTracker == 2 then
					
					local bruh = random(1,2)
					local path
					
					if bruh == 1 then
					
						path = "pt_patrol_1a"
					
					elseif bruh == 2 then
					
						path = "pt_patrol_1b"
					
					end
					
					spawnedPT = GenerateObject("Gyoraitei No. 45")
					
					NavigatorMoveOnPath(spawnedPT, FindEntity(path), PATH_FM_CIRCLE, PATH_SM_BEGIN)
					
					Mission.PTSpawnedTracker = 0
					
				end
				
				table.insert(Mission.SpawnedPTGang, spawnedPT)
				
				if Mission.JapReinTimer < 280 and not Mission.BoatsDiaPlayed then
				
					luaStartDialog("BOATS")
					
					Mission.BoatsDiaPlayed = true
				
				end
				
			end
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.SpawnedPTGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.SpawnedPTGang)) do
				
				if unit and not unit.Dead then
				
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				
						local henrys = luaGetShipsAround(unit, 2000, "enemy")
						
						if henrys then
						
							luaSetScriptTarget(unit, henrys[1])
							NavigatorAttackMove(unit, henrys[1])
						
						end
					
					end
				
				end
				
			end
		
		end
		
		if Mission.PatrollingDD and not Mission.PatrollingDD.Dead then
			
			if luaGetScriptTarget(Mission.PatrollingDD) == nil or luaGetScriptTarget(Mission.PatrollingDD).Dead then
			
				local henrys = luaGetShipsAround(Mission.PatrollingDD, 2000, "enemy")
				
				if henrys then
				
					luaSetScriptTarget(Mission.PatrollingDD, henrys[1])
					NavigatorAttackMove(Mission.PatrollingDD, henrys[1])
				
				else
				
					if Mission.PatrollingDDCounter == 0 then
					
						NavigatorMoveOnPath(Mission.PatrollingDD, FindEntity("dest_patrol_1a"), PATH_FM_CIRCLE, PATH_SM_BEGIN)
						
					elseif Mission.PatrollingDDCounter == 1 then
						
						NavigatorMoveOnPath(Mission.PatrollingDD, FindEntity("dest_patrol_1b"), PATH_FM_CIRCLE, PATH_SM_BEGIN)
					
					end
				
				end
			
			end
			
		else
			
			if Mission.PatrollingDDCounter < 1 then
			
				luaSpawnNextDD()
				
				Mission.PatrollingDDCounter = Mission.PatrollingDDCounter + 1
				
				Mission.NextDDSpawned = true
			
			end
			
		end
		
		if Mission.PTGang[1] and not Mission.PTGang[1].Dead then
		
			if luaGetScriptTarget(Mission.PTGang[1]) == nil or luaGetScriptTarget(Mission.PTGang[1]).Dead then
			
				local henrys = luaGetShipsAround(Mission.PTGang[1], 2000, "enemy")
				
				if henrys then
				
					luaSetScriptTarget(Mission.PTGang[1], henrys[1])
					NavigatorAttackMove(Mission.PTGang[1], henrys[1])
				
				else
					
					NavigatorMoveOnPath(Mission.PTGang[1], FindEntity("pt_patrol_1a"), PATH_FM_CIRCLE, PATH_SM_BEGIN)
				
				end
			
			end
		
		end
		
		if Mission.PTGang[2] and not Mission.PTGang[2].Dead then
		
			if luaGetScriptTarget(Mission.PTGang[2]) == nil or luaGetScriptTarget(Mission.PTGang[2]).Dead then
			
				local henrys = luaGetShipsAround(Mission.PTGang[2], 2000, "enemy")
				
				if henrys then
				
					luaSetScriptTarget(Mission.PTGang[2], henrys[1])
					NavigatorAttackMove(Mission.PTGang[2], henrys[1])
				
				else
					
					NavigatorMoveOnPath(Mission.PTGang[2], FindEntity("pt_patrol_1b"), PATH_FM_CIRCLE, PATH_SM_BEGIN)
				
				end
			
			end
		
		end
		
		Mission.CargosLeft = table.getn(luaRemoveDeadsFromTable(Mission.CargoGang))
		
		if Mission.CargosLeft == 0 then
			
			HideScoreDisplay(1,0)
			
			if Mission.MissionPhase == 1 then
				
				Mission.Final = true
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HenryGang)) do
					
					if unit and not unit.Dead then
					
						SetInvincible(unit, 0.01)
					
					end
					
				end
				
				if luaObj_IsActive("hidden", 1) then
				
					luaObj_Completed("hidden", 1)
				
				end
				
				HideUnitHP()
				
				luaStartDialog("FINAL")
				
				--luaMissionComplete(Mission.Henry)
				
			elseif Mission.MissionPhase == 2 then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.KumaGang)) == 0 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.HenryGang)) do
					
						if unit and not unit.Dead then
						
							SetInvincible(unit, 0.01)
						
						end
						
					end
					
					HideUnitHP()
					
					luaObj_Completed("primary", 3, true)
					
					luaStartDialog("BOTTOM")
					luaStartDialog("FINAL")
					
					--luaMissionComplete(Mission.Henry)
				
				end
			
			end
		
		else
		
			local line1 = "Destroy all Japanese cargo ships!"
			local line2 = "Cargo(s) left: #Mission.CargosLeft#"
			luaDisplayScore(1, line1, line2)
		
		end
		
		if luaObj_IsActive("secondary", 1) then
		
			if Mission.Fortress.Dead then
			
				luaObj_Completed("secondary", 1, true)
			
			end
		
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 2 ----

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.JapRein1 = GenerateObject("Naka")
	Mission.JapRein2 = GenerateObject("Harusame")
	
	Mission.KumaGang = {}
		table.insert(Mission.KumaGang, Mission.JapRein1)
		table.insert(Mission.KumaGang, Mission.JapRein2)
	
	for idx,unit in pairs(Mission.KumaGang) do
		
		JoinFormation(unit, Mission.KumaGang[1])
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
	
	PutTo(Mission.JapRein1, GetPosition(FindEntity("CLSpawnArea")))
	PutRelTo(Mission.JapRein2, Mission.JapRein1, {["x"]=0,["y"]=0,["z"]=-500})
	
	NavigatorAttackMove(Mission.KumaGang[1], Mission.Henry)
	
	luaStartDialog("CL")
	
end

function luaAddReinObj()

	luaObj_Add("primary", 3, Mission.KumaGang)

end

---- PHASE 1 ----

function luaStartMission()
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	luaStartDialog("INTRO")
	
	--luaIntroMovie()

end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	local fletcher = FindEntity("John D. Ford")
	local clemson = FindEntity("Parrot")
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=clemson,
			["pos"] = { 40, 6, -35, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["wanderer"]=true,
		["transformtype"]="keepall",
	}

	MovCamNew_AddPosition(pos0)

	local pos0 = {
		["postype"]="target",
		["position"]= {
			["parent"]=fletcher,
			["pos"] = { 0, 0, 0, },
		},
		["transformtype"]="keepall",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
	}

	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
		["postype"]="cameraandtarget",
		["position"]= {
			["parent"]=fletcher,
			["modifier"] = {
				["name"] = "gamecamera",
			}
		},
		["transformtype"]="keepy",
		["starttime"]=0.5,
		["blendtime"]=20.0,
		["zoom"]=1,
		["finishscript"] = "luaIntroMovieEnd",
	}

	MovCamNew_AddPosition(pos0)

end

function luaIntroMovieEnd()

	SetSelectedUnit(FindEntity("John D. Ford"))
	
	--EnableInput(true)
	
	luaAddFirstObjs()
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.CargoGang)
	luaObj_Add("primary", 2, Mission.Henry)
	
	DisplayUnitHP((Mission.AreYouFuckingKiddingMe), "The USS John D. Ford must survive!")
	
	luaObj_Add("hidden", 1)
	luaObj_Add("hidden", 2)

end

function luaSpawnNextDD()

	Mission.Natsugumo = GenerateObject("Natsugumo")
	Mission.PatrollingDD = Mission.Natsugumo
	
	AddLineOfSightTrigger(Mission.Natsugumo, nil, "luaNextDDDia", Mission.Henry, 10000)
	
end

function luaNextDDDia()

	luaStartDialog("DD")

end

---- LISTENERS ----

function luaAddFortressListener()

	AddListener("recon", "FortressListener", {
		["callback"] = "luaFortressSighted",
		["entity"] = {Mission.Fortress},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

---- LISTENER CALLBACKS ----

function luaFortressSighted()

	RemoveListener("recon", "FortressListener")
	
	luaObj_Add("secondary", 1, Mission.Fortress)

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
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Completed("hidden",2)
	
	end
	
	luaMissionCompletedNew(Mission.Henry, "All enemy units destroyed - Mission Complete", "campaigns/BSM/m0503.bik")
	
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
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionFailedNew(Mission.Henry, "Game Over")
	
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