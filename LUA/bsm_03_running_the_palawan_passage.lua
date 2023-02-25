---- RUNNING THE PALAWAN PASSAGE (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- RUNNING THE PALAWAN PASSAGE (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(172) 	-- Jake
	PrepareClass(174) 	-- Mavis
	PrepareClass(77) 	-- Gyoriatei
	
end

---- INITS ----

function luaEngineMovieInit()
	
	--Music_Control_SetLevel(MUSIC_ACTION)
	
end

function luaStageInitMulti()
	
	luaLoadControlFunctionNames()
	
end

function luaStageInit()
	
	CreateScript("luaInit")
	
	Scoring_RealPlayTimeRunning(true)
	
	LoadMessageMap("bsmdlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_03_running_the_palawan_passage.lua"

	this.Name = "BSM03"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Reach",
				["Text"] = "Reach the other side of the strait!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "DD",
				["Text"] = "Your unit must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "COMPLETEFUCKINGANNIHILATION",
				["Text"] = "Annihilate the enemy destroyer!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Seaplane",
				["Text"] = "Destroy the Japanese recon base!",
				["TextCompleted"] = "The Japanese recon base has been destroyed!" ,
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "PT",
				["Text"] = "Take out the PT boat base!",
				["TextCompleted"] = "The Japanese PT Boat base has been destroyed!" ,
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Meet",
				["Text"] = "Meet with the Allied submarine within 17 minutes.",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Crago",
				["Text"] = "Destroy all cargo ships!",
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
			},
		},
		["MAVIS"] = {
			["sequence"] = {
				{
					["message"] = "MAVIS1",
				},
				{
					["message"] = "MAVIS2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddPlaneBaseObj",
				},
			},
		},
		["INCOMING"] = {
			["sequence"] = {
				{
					["message"] = "INCOMING1",
				},
				{
					["message"] = "INCOMING2",
				},
			},
		},
		["CARGO"] = {
			["sequence"] = {
				{
					["message"] = "CARGO1",
				},
				{
					["message"] = "CARGO2",
				},
			},
		},
		["DESTROYED"] = {
			["sequence"] = {
				{
					["message"] = "DESTROYED1",
				},
				{
					["message"] = "DESTROYED2",
				},
			},
		},
		["CRAFT"] = {
			["sequence"] = {
				{
					["message"] = "CRAFT1",
				},
				{
					["message"] = "CRAFT2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddPTBaseObj",
				},
			},
		},
		["THROUGH"] = {
			["sequence"] = {
				{
					["message"] = "THROUGH1",
				},
				{
					["message"] = "THROUGH2",
				},
				{
					["message"] = "THROUGH3",
				},
				{
					["message"] = "THROUGH4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObj",
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
	
	Mission.Henry = FindEntity("Kane")
	
	--RepairEnable(Mission.Henry, false)
	
	Mission.HenryGoTo = FindEntity("checkpoint")
	
	---- IJN ----
	
	Mission.Hatsushimo = FindEntity("Hatsushimo")
	
	SetSkillLevel(Mission.Hatsushimo, Mission.SkillLevel)
	
	SetInvincible(Mission.Hatsushimo, true)
	RepairEnable(Mission.Hatsushimo, false)
	
	Mission.TypeJake = 172
	Mission.TypeMavis = 174
	Mission.TypeGyo = 77
	
	Mission.ReconBase = FindEntity("Reconbase_Hangar")
	Mission.PTBase = FindEntity("PTHangar_Hangar")
	
	Mission.ReconBaseHangar = FindEntity("Reconbase")
	Mission.PTBaseHangar = FindEntity("PTHangar")
	
	OverrideHP(Mission.ReconBaseHangar, Mission.ReconBaseHangar.Class.HP / 1.38)
	OverrideHP(Mission.PTBaseHangar, Mission.PTBaseHangar.Class.HP / 1.38)
	
	Mission.IHateMyFuckingLife = {}
		table.insert(Mission.IHateMyFuckingLife, FindEntity("Hatsushimo"))
	
	Mission.FortressGang = {}
		table.insert(Mission.FortressGang, FindEntity("Fortress"))
		table.insert(Mission.FortressGang, FindEntity("Fortress 1"))
		table.insert(Mission.FortressGang, FindEntity("Fortress 2"))
		table.insert(Mission.FortressGang, FindEntity("Fortress 3"))
		table.insert(Mission.FortressGang, FindEntity("Fortress 4"))
		table.insert(Mission.FortressGang, FindEntity("Fortress 5"))
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Hayo Maru"))
		table.insert(Mission.CargoGang, FindEntity("Katori Maru"))
		table.insert(Mission.CargoGang, FindEntity("Hie Maru"))
		
	Mission.CargoBruh = {}
		table.insert(Mission.CargoBruh, FindEntity("Hayo Maru"))
		table.insert(Mission.CargoBruh, FindEntity("Katori Maru"))
		table.insert(Mission.CargoBruh, FindEntity("Hie Maru"))
		table.insert(Mission.CargoBruh, FindEntity("Tsuruga Maru"))
		table.insert(Mission.CargoBruh, FindEntity("Toa Maru"))
	
	Mission.ICantEvenGang = {}
		table.insert(Mission.ICantEvenGang, FindEntity("Gyoraitei No. 113"))
		table.insert(Mission.ICantEvenGang, FindEntity("Gyoraitei No. 114"))
	
	Mission.StrikePlanes = {
		["Jakes"] = {},
		["Mavises"] = {},
		["AttackPath"] = {
			[1] = FindEntity("plane_path1"),
			[2] = FindEntity("plane_path2"),
		}
	}
	Mission.Pts = {
		["PtBoats"] = {},
		["AttackPath"] = {
			[1] = FindEntity("pt_path1"),
			[2] = FindEntity("pt_path2"),
		},
	}
	
	Mission.MavisGang = {}
	Mission.JakeGang = {}
	Mission.GyioGang = {}
	
	---- VAR ----
	
	Mission.Zone1Bottom = GetPosition(FindEntity("zone1bottom")) 
	Mission.Zone1Top = GetPosition(FindEntity("zone1top")) 
	Mission.Zone2Bottom = GetPosition(FindEntity("zone2bottom")) 
	Mission.Zone3Top = GetPosition(FindEntity("zone3top")) 
	Mission.Zone4Top = GetPosition(FindEntity("zone4top")) 
	Mission.Zone5Top = GetPosition(FindEntity("zone5top")) 
	
	Mission.Zones = {}
		table.insert(Mission.Zones, {Mission.Zone1Bottom,Mission.Zone1Top})
		table.insert(Mission.Zones, {Mission.Zone2Bottom,Mission.Zone1Top})
		table.insert(Mission.Zones, {Mission.Zone1Top,Mission.Zone3Top})
		table.insert(Mission.Zones, {Mission.Zone1Top,Mission.Zone4Top})
		table.insert(Mission.Zones, {Mission.Zone3Top,Mission.Zone5Top})
		table.insert(Mission.Zones, {Mission.Zone4Top,Mission.Zone5Top})
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.MavisSpawned = 0
	Mission.JakeSpawned = 0
	Mission.GyioSpawned = 0
	Mission.PtSpawnDelay = 60
	Mission.PtLastSpawned = 0
	
	if Mission.Difficulty == 0 then
		
		OverrideHP(Mission.Henry, Mission.Henry.Class.HP * 2.3)
		Mission.JapAI = 1
		Mission.MaxJakeNum = 1
		Mission.MaxGyioNum = 3
	
	elseif Mission.Difficulty == 1 then
		
		OverrideHP(Mission.Henry, Mission.Henry.Class.HP * 2.15)
		Mission.JapAI = 2
		Mission.MaxJakeNum = 2
		Mission.MaxGyioNum = 4
	
	elseif Mission.Difficulty == 2 then
		
		OverrideHP(Mission.Henry, Mission.Henry.Class.HP * 2.0)
		Mission.JapAI = 3
		Mission.MaxJakeNum = 3
		Mission.MaxGyioNum = 4
	
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	Blackout(true, "", true)
	
	SetRoleAvailable(Mission.Henry, EROLF_DEPTHCHARGE, PLAYER_AI)
	
	--Effect("EnvironmentWaterfall", GetPosition(FindEntity("wf")))
	
	SetSimplifiedReconMultiplier(0.85)
	
	MissionNarrative("December 20th, 1941 - The Palawan Passage")
	
	---- THINK ----
	
	luaInitNewSystems()

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
		
	end
	
	if Mission.MissionPhase < 99 then
		
		if Mission.Henry.Dead then
		
			luaMissionFailed(Mission.Henry)
		
		end
		
		Mission.MavisGang = luaRemoveDeadsFromTable(Mission.MavisGang)
		Mission.JakeGang = luaRemoveDeadsFromTable(Mission.JakeGang)
		Mission.GyioGang = luaRemoveDeadsFromTable(Mission.GyioGang)
		Mission.CargoGang = luaRemoveDeadsFromTable(Mission.CargoGang)
		Mission.ICantEvenGang = luaRemoveDeadsFromTable(Mission.ICantEvenGang)
		
		Mission.HenryPos = GetPosition(Mission.Henry)
		
		if table.getn(luaRemoveDeadsFromTable(Mission.MavisGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MavisGang)) do
			
				if unit and not unit.Dead then
					
					local ammo = GetProperty(unit, "ammoType")
				
					if ammo == 0 and not unit.retreating then
					
						PilotRetreat(unit)
						
						unit.retreating = true
						
					end
				
				end
			
			end
			
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.JakeGang)) > 0 then
		
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.JakeGang)) do
			
				if unit and not unit.Dead then
					
					local ammo = GetProperty(unit, "ammoType")
				
					if ammo == 0 and not unit.retreating then
					
						PilotRetreat(unit)
						
						unit.retreating = true
						
					end
				
				end
			
			end
			
		end
		
		if not Mission.FortressDiaPlayed then
			
			local GunsFired
			
			for idx, gun in pairs(Mission.FortressGang) do
				
				if HasFired(gun, "MEDIUMARTILLERY", GameTime()) then
					
					GunsFired = true
					
				end
				
			end
			
			if GunsFired then
			
				luaStartDialog("INCOMING")
				
				Mission.FortressDiaPlayed = true
				
			end
			
		end
		
		if luaObj_IsActive("secondary",1) then
		
			if Mission.ReconBaseHangar.Dead then
			
				luaObj_Completed("secondary",1, true)
			
			end
		
		end
		
		if luaObj_IsActive("secondary",2) then
			
			if not Mission.weezer and luaGetDistance(Mission.Henry, Mission.PTBase) < 2000 then
				local path = FillPathPoints(FindEntity("ptbase_exit"))
				for idx,unit in pairs(this.ICantEvenGang) do
					luaSetScriptTarget(unit, Mission.Henry)
					unit.lastpoint = path[table.getn(path)]
					NavigatorMoveOnPath(unit, FindEntity("ptbase_exit"))
				end
				Mission.weezer = true
			elseif Mission.weezer then
				for idx,unit in pairs(this.ICantEvenGang) do
					if not unit.newpath and luaGetDistance(unit, unit.lastpoint) < 200 then
						local rnd = luaRnd(0,100)
						if rnd <= 50 then
							NavigatorMoveOnPath(unit, FindEntity("pt_path2"), PATH_FM_CIRCLE, PATH_SM_JOIN)
							unit.newpath = true
						else
							NavigatorMoveOnPath(unit, FindEntity("pt_path2"), PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS)
							unit.newpath = true
						end
					end
				end
			end
			
			if Mission.PTBaseHangar.Dead then
			
				luaObj_Completed("secondary",2, true)
				
				Mission.PTSStopSpawning = true
				
			end
		
		end
		
		if Mission.CargosRunning then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CargoGang)) == 0 and not Mission.DestroyedDiaPlayed then
				
				luaStartDialog("DESTROYED")
				
				Mission.DestroyedDiaPlayed = true
			
			end
		
		end
		
		if luaObj_IsActive("hidden",2) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CargoBruh)) == 0 then
			
				luaObj_Completed("hidden",2)
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase == 1 then
	
		if not Mission.MavisFlowStarted and Mission.MavisCanSpawn then
		
			luaMavisFlow()
			
			Mission.MavisFlowStarted = true
		
		end
	
		if not Mission.JakeFlowStarted then
		
			luaJakeFlow()
			
			Mission.JakeFlowStarted = true
		
		end
		
		if not Mission.GyioFlowStarted then
			
			luaGyioFlow()
			
			Mission.GyioFlowStarted = true
		
		end
		
		if luaObj_IsActive("primary",1) then
			
			luaDistanceCounter(Mission.Henry, Mission.HenryGoTo, 1, "Reach the other side of the strait!", "ijn14.distance")
			
			if luaGetDistance(Mission.Henry, Mission.HenryGoTo) < 1650 then
				
				HideScoreDisplay(1,0)
				luaObj_Completed("primary",1)
				luaMoveToPh2()
			
			end
		
		end
		
	elseif Mission.MissionPhase == 2 then
	
		if luaObj_IsActive("primary",3) then
		
			if Mission.Hatsushimo.Dead then
			
				HideUnitHP()
				luaObj_Completed("primary", 3)
				
				luaMissionComplete(Mission.Hatsushimo)
			
			end
		
		end
		
	end
	
	---- TEST ----
	
end

---- OBJECTIVES ----

function luaAddPTBaseObj()

	luaObj_Add("secondary", 2, Mission.PTBase)

end

function luaAddPlaneBaseObj()

	luaObj_Add("secondary", 1, Mission.ReconBase)

end

function luaCheckSecObjAdded2()
	
	if not Mission.GyioSpotted then
	
		Mission.GyioSpotted = true
		
		luaAddPTBaseObj()
		
	end
	
end

function luaCheckSecObjAdded()

	if not Mission.MavisSpotted then
	
		Mission.MavisSpotted = true
		
		luaAddPlaneBaseObj()
	
	end

end

function luaCheckHiddenTimer()

	if luaObj_IsActive("hidden",1) then
	
		luaObj_Failed("hidden",1)
	
	end

end

---- PHASE 2 ----

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	SetInvincible(Mission.Hatsushimo, false)
	
	NavigatorAttackMove(Mission.Hatsushimo, Mission.Henry)
	
	luaDelay(luaMinekazeDia, 2)

end

function luaAddFinalObj()

	luaObj_Add("primary", 3, Mission.Hatsushimo)
	
	DisplayUnitHP(Mission.IHateMyFuckingLife, "Annihilate the enemy destroyer!")

end

---- CARGOS ----

function luaHenrySpotsTheGang()

	for idx,unit in pairs(Mission.CargoGang) do
		
		JoinFormation(unit, Mission.CargoGang[1])
		
	end
	
	NavigatorMoveOnPath(Mission.CargoGang[1], FindEntity("cargo_path1"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	
	Mission.CargosRunning = true
	
	luaStartDialog("CARGO")

end

--[[function luaCheckCargos()

	if Mission.MissionPhase == 1 then

		if (luaGetZone() == 3 or luaGetZone() == 6) and not Mission.CargosRunning then
			
			for idx,unit in pairs(Mission.CargoGang) do
				
				JoinFormation(unit, Mission.CargoGang[1])
				SetSkillLevel(unit, Mission.SkillLevel)
				
			end
			
			NavigatorMoveOnPath(Mission.CargoGang[1], FindEntity("cargo_path1"), PATH_FM_SIMPLE, PATH_SM_JOIN)
			
			Mission.CargosRunning = true
			
			luaStartDialog("CARGO")
			
		end
		
		luaDelay(luaCheckCargos, 5)
		
	end
	
end]]

---- ATTACKERS FLOW -----

-- GYIO

function luaGyioFlow()

	if Mission.MissionPhase == 1 and not Mission.PTSStopSpawning then
	
		luaDelay(luaSpawnGyio, 3)
		
		luaDelay(luaCheckSecObjAdded2, 450)
		
		luaDelay(luaGyioFlow, 3)
		
	end

end

function luaSpawnGyio()

	if table.getn(Mission.GyioGang) < Mission.MaxGyioNum then

		if math.floor(GameTime()) - Mission.PtLastSpawned < Mission.PtSpawnDelay and table.getn(Mission.GyioGang) ~= 0 then
			
			return
		
		end

		local zone = luaGetZone()

		if zone ~= 3 and zone ~= 4 and zone~= 5 and zone ~= 6 then
			
			return
			
		end

		local path, rot, back = luaSelectAttackPath(1,zone)
		
		if not path then
			
			return
			
		end

		table.insert(Mission.GyioGang, GenerateObject("Gyoraitei No. 112"))
		local Pt = Mission.GyioGang[table.getn(Mission.GyioGang)]
		
		SetSkillLevel(Pt, Mission.SkillLevel)
		
		if Mission.Difficulty == 0 then
		
			ShipSetTorpedoStock(Pt, 2)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			ShipSetTorpedoStock(Pt, 4)
		
		end
		
		Mission.GyioSpawned = Mission.GyioSpawned + 1
		Mission.PtLastSpawned = math.floor(GameTime())

		if not back then
			local attackPath = FillPathPoints(path)
			PutTo(Pt, attackPath[1], rot)

			NavigatorMoveOnPath(Pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN)
			Pt.pathname = path.Name
		else
			local attackPath = FillPathPoints(path)
			PutTo(Pt, attackPath[table.getn(attackPath)], rot)

			NavigatorMoveOnPath(Pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS)
			Pt.pathname = path.Name
		end

		luaSetScriptTarget(Pt, Mission.Henry)
		
		if not Mission.GyioListenerAdded then
		
			AddLineOfSightTrigger(Pt, nil, "luaHenrySpotsGyio", Mission.Henry, 2000)
			
			Mission.GyioListenerAdded = true
			
		end
		
	end

	if table.getn(Mission.GyioGang) ~= 0 then
		for idx,unit in pairs(Mission.GyioGang) do
			if unit.pathname == "pt_path1" and (zone == 5 or zone == 6) then
				if luaGetDistance(unit, Mission.Henry) > 2000 then
					
					Kill(unit,true)

				end
			elseif unit.pathname == "pt_path2" and (zone == 3 or zone == 4) then
				if luaGetDistance(unit, Mission.Henry) > 2000 then
					
					Kill(unit,true)

				end
			end
		end
	end

end

function luaHenrySpotsGyio()
	
	if not Mission.GyioSpotted then
	
		Mission.GyioSpotted = true
	
	end
	
	if not Mission.GyioDiaPlayed then
	
		luaStartDialog("CRAFT")
		
		Mission.GyioDiaPlayed = true
	
	end

end

-- JAKE

function luaJakeFlow()

	if Mission.MissionPhase == 1 and Mission.JakeSpawned < 5 then
	
		luaDelay(luaSpawnJake, 20)
		
		luaDelay(luaJakeFlow, 70)
	
	end

end

function luaSpawnJake()

	if table.getn(luaRemoveDeadsFromTable(Mission.JakeGang)) < Mission.MaxJakeNum then

		local zone = luaGetZone()

		if (zone == 1 and Mission.MavisSpawned >= 3) or (zone == 2 and Mission.MavisSpawned >= 3) or zone == 3 then
			
			table.insert(Mission.JakeGang, GenerateObject("E13A Jake "))
			local jake = Mission.JakeGang[table.getn(Mission.JakeGang)]

			SetSkillLevel(jake, Mission.SkillLevel)

			PilotSetTarget(jake, Mission.Henry)
			SquadronSetAttackAlt(jake, 600)
			SquadronSetTravelAlt(jake, 600)
			
			Mission.JakeSpawned = Mission.JakeSpawned + 1
			
		end
		
	end

end

-- MAVIS

function luaMavisFlow()

	if Mission.MissionPhase == 1 and Mission.MavisSpawned < 6 then
	
		luaSpawnMavis()
		
		luaDelay(luaMavisFlow, 110)
	
	end

end

function luaSpawnMavis()
	
	local zone = luaGetZone()
	
	if zone ~= 1 and zone ~= 2 then
		
		return
		
	end
	
	table.insert(Mission.MavisGang, GenerateObject("H6K Mavis"))
	local mavis = Mission.MavisGang[table.getn(Mission.MavisGang)]
	
	SetSkillLevel(mavis, Mission.SkillLevel)
	
	local path, rot = luaSelectAttackPath(0, zone)
	local attackPath
	
	attackPath = FillPathPoints(path)
	
	PutTo(mavis, attackPath[1], rot)
	
	PilotMoveOnPath(mavis, path)
	
	Mission.MavisSpawned = Mission.MavisSpawned + 1
	
	AddLineOfSightTrigger(mavis, nil, "luaHenrySpotsMavis", Mission.Henry, 2500)
	
end

function luaHenrySpotsMavis(mavis)
	
	if not Mission.MavisSpotted then
	
		Mission.MavisSpotted = true
	
	end
	
	if not Mission.MavisDiaPlayed then
	
		luaStartDialog("MAVIS")
		
		Mission.MavisDiaPlayed = true
		
		luaDelay(luaSpawnMavis, 8)
		
	end
	
	PilotSetTarget(mavis, Mission.Henry)

end

---- ATTACKERS SUPPORT ----

function luaSelectAttackPath(attackertype, zone)
	
	if zone == nil then

		return
	end
	if type(zone) ~= "number" then

		return
	end

	local path
	local rot
	local back

	if attackertype == 0 then
		if zone == 1 then

			path = Mission.StrikePlanes.AttackPath[1]
			
			rot = -105
			return path, rot
		elseif zone == 2 then

			path = Mission.StrikePlanes.AttackPath[2]
			
			rot = 128
			return path, rot
		end


		return false

	elseif attackertype == 1 then
		
		if zone == 3 then

			path = Mission.Pts.AttackPath[1]
			rot = 74
			back = false
			return path, rot, back
		elseif zone == 4 then

			path = Mission.Pts.AttackPath[1]
			rot = -115
			back = true
			return path, rot, back
		elseif zone == 5 then

			path = Mission.Pts.AttackPath[2]
			rot = 97
			back = false
			return path, rot, back
		elseif zone == 6 then

			path = Mission.Pts.AttackPath[2]
			rot = -102
			back = true
			return path, rot, back
		end
	else

		return false
	end

end

function luaGetZone()
	
	local pPos = Mission.HenryPos

	for idx,zone in pairs(Mission.Zones) do
		
		if luaIsInArea(zone, pPos) then
			
			return idx
			
		end
		
	end

	return false
	
end

---- DIALOGUES ----

function luaIntroDia()
	
	luaStartDialog("INTRO")
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)

end

function luaMinekazeDia()

	luaStartDialog("THROUGH")

end

---- MISSION START ----

function luaStartMission()
	
	Blackout(false, "", 1)
	
	local pos0 = {
		["postype"]="camera",
		["position"]= {
			["parent"]=Mission.Henry,
			["pos"] = { -50, 3, 40, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["wanderer"]=false,
		["transformtype"]="keepall",
		["smoothtime"]=0.0,
		["zoom"]=1,
		
	}
	local pos1 = {
		["postype"]="target",
		["position"]= {
			["parent"]=Mission.Henry,
			["pos"] = { 0, 15, 40, },
		},
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["wanderer"]=false,
		["transformtype"]="keepall",
		["zoom"] = 1.5
	}
	local pos3 = {
		["postype"]="cameraandtarget",
		["position"]= {
			["parent"]=Mission.Henry,
			["modifier"] = {
				["name"] = "gamecamera",
			}
		},
		["transformtype"]="keepall",
		["starttime"]=0.0,
		["blendtime"]=15.0,
		["zoom"]=1,
		["finishscript"] = "luaEndIntroMovie",
	}
	
	MovCamNew_AddPosition(pos0)
	MovCamNew_AddPosition(pos1)		
	MovCamNew_AddPosition(pos3)
	
	luaDelay(luaIntroDia, 1.6)
	
end

function luaEndIntroMovie()
	
	EnableMessages(true)
	
	SetSelectedUnit(Mission.Henry)
	
	luaObj_Add("primary", 1, GetPosition(Mission.HenryGoTo))
	luaObj_Add("primary", 2)
	luaObj_Add("hidden", 1)
	luaObj_Add("hidden", 2)
	
	AddLineOfSightTrigger(Mission.CargoGang[1], nil, "luaHenrySpotsTheGang", Mission.Henry, 2000)
	AddLineOfSightTrigger(Mission.CargoGang[2], nil, "luaHenrySpotsTheGang", Mission.Henry, 2000)
	AddLineOfSightTrigger(Mission.CargoGang[3], nil, "luaHenrySpotsTheGang", Mission.Henry, 2000)
	
	luaDelay(luaEnableMavisSpawn, 5)
	luaDelay(luaCheckHiddenTimer, 1020)
	
end

function luaEnableMavisSpawn()

	Mission.MavisCanSpawn = true
	
	luaDelay(luaCheckSecObjAdded, 120)
	
end

---- MISSION ENDERS ----

function luaMissionComplete(unit)
	
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
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionCompletedNew(unit, "All enemy units destroyed - Mission Complete", "campaigns/BSM/m0302.bik")
	
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
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
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