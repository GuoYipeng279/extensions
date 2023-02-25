---- TAKING PORT MORESBY (IJN) ----

-- Scripted & Assembled by: Team Wolfpack

---- TAKING PORT MORESBY (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(135) 	-- P40
	PrepareClass(104) 	-- P38
	PrepareClass(102) 	-- F4U
	--PrepareClass(838) 	-- SB2U
	PrepareClass(108) 	-- SBD
	PrepareClass(112) 	-- TBD
	PrepareClass(113) 	-- TBF
	PrepareClass(118) 	-- B25
	PrepareClass(323) 	-- B24
	--PrepareClass(136) 	-- C47
	--PrepareClass(125) 	-- PBY
	
	--PrepareClass(27) 	-- Elco
	
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
	Mission.ScriptFile = "Scripts/missions/IJN/ijn_06_port_moresby.lua"

	this.Name = "IJN06"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Sink",
				["Text"] = "Capture the port!",
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
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Cap2",
				["Text"] = "Secure the two secondary bases!",
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
				["Text"] = "Sink the attacking enemy submarine(s)!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "Brah",
				["Text"] = "Don't lose any of your transports!",
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
					["time"] = 2,
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["type"] = "pause",
					["time"] = 9,
				},
				{
					["message"] = "AF1",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "INTRO2",
				},
			},
		},
		["AFOURS"] = {--
			["sequence"] = {
				{
					["message"] = "AFOURS1",
				},
				{
					["message"] = "dlg8c",
				},
			},
		},
		["SONAR"] = {--
			["sequence"] = {
				{
					["message"] = "dlg25a",
				},
			},
		},
		["ELCO"] = {--
			["sequence"] = {
				{
					["message"] = "dlg22a",
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
		["TROOP"] = {--
			["sequence"] = {
				{
					["message"] = "dlg27a",
				},
				{
					["message"] = "dlg27b",
				},
			},
		},
		["FINAL"] = {--
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
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
	
	Mission.Taiho = FindEntity("Taiho")
	
	Mission.TaihoGrp = {}
		table.insert(Mission.TaihoGrp, FindEntity("Taiho"))
		table.insert(Mission.TaihoGrp, FindEntity("Kumano"))
		table.insert(Mission.TaihoGrp, FindEntity("Shimakaze"))
	
	for idx,unit in pairs(Mission.TaihoGrp) do
		
		JoinFormation(unit, Mission.TaihoGrp[1])
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
	
	Mission.HieiGrp = {}
		table.insert(Mission.HieiGrp, FindEntity("Hiei"))
		table.insert(Mission.HieiGrp, FindEntity("Azumaya"))
		--table.insert(Mission.HieiGrp, FindEntity("Hae"))
		--table.insert(Mission.HieiGrp, FindEntity("Kitakaze"))
	
	for idx,unit in pairs(Mission.HieiGrp) do
		
		JoinFormation(unit, Mission.HieiGrp[1])
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
	
	Mission.TransGrp = {}
		table.insert(Mission.TransGrp, FindEntity("Hawaii Maru"))
		table.insert(Mission.TransGrp, FindEntity("Nojima Maru"))
		table.insert(Mission.TransGrp, FindEntity("Sakito Maru"))
		table.insert(Mission.TransGrp, FindEntity("Teiyo Maru"))
		--table.insert(Mission.TransGrp, FindEntity("Nippon Maru"))
		table.insert(Mission.TransGrp, FindEntity("Natori"))
		table.insert(Mission.TransGrp, FindEntity("Yura"))
		table.insert(Mission.TransGrp, FindEntity("Asashio"))
		table.insert(Mission.TransGrp, FindEntity("Samidare"))
		--table.insert(Mission.TransGrp, FindEntity("Arashi"))
	
	for idx,unit in pairs(Mission.TransGrp) do
		
		JoinFormation(unit, Mission.TransGrp[1])
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
	
	Mission.IJNTrans = {}
		table.insert(Mission.IJNTrans, FindEntity("Hawaii Maru"))
		table.insert(Mission.IJNTrans, FindEntity("Nojima Maru"))
		table.insert(Mission.IJNTrans, FindEntity("Sakito Maru"))
		table.insert(Mission.IJNTrans, FindEntity("Teiyo Maru"))
	
	--[[if Mission.Difficulty < 2 then
	
		Mission.ZaoGrp = {}
			table.insert(Mission.ZaoGrp, GenerateObject("Senjo"))
			table.insert(Mission.ZaoGrp, GenerateObject("Shirayuki"))
			table.insert(Mission.ZaoGrp, GenerateObject("Shinonome"))
		
		for idx,unit in pairs(Mission.ZaoGrp) do
			
			JoinFormation(unit, Mission.ZaoGrp[1])
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
	
	end]]
	
	Mission.IJNShips = luaSumTablesIndex(Mission.TaihoGrp, Mission.HieiGrp, Mission.TransGrp)
	
	---- USN ----
	
	Mission.PortMoresby = FindEntity("MainCommandBuilding 01")
	Mission.AFHQ = FindEntity("SecondaryCommandBuilding 01")
	Mission.RadarStation = FindEntity("RadarStation 01")
	Mission.PrinceWilliam = FindEntity("Prince William")
	
	--Mission.LandConvoy = FindEntity("Event5Convoy")
	
	Mission.HQs = {}
		table.insert(Mission.HQs, Mission.PortMoresby)
		table.insert(Mission.HQs, Mission.AFHQ)
		table.insert(Mission.HQs, Mission.RadarStation)
	
	for idx,unit in pairs(Mission.HQs) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("MainShipyardEntity 01"))
		table.insert(Mission.Shipyards, FindEntity("MainShipyardEntity 02"))
	
	for idx,unit in pairs(Mission.Shipyards) do
	
		RepairEnable(unit, false)
	
	end
	
	Mission.Shipyards[1].spawnPoint = FindEntity("MainShipyard 01 Navpoint 01")
	Mission.Shipyards[2].spawnPoint = FindEntity("MainShipyard 02 Navpoint 01")
	
	Mission.SecHQs = {}
		table.insert(Mission.SecHQs, Mission.AFHQ)
		table.insert(Mission.SecHQs, Mission.RadarStation)
	
	Mission.Airfields = {}
		table.insert(Mission.Airfields, FindEntity("MainAirfieldEntity 01"))
		table.insert(Mission.Airfields, FindEntity("SecondaryAirfieldEntity 01"))
	
	for idx,unit in pairs(Mission.Airfields) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		RepairEnable(unit, false)
		
		if Mission.Difficulty == 0 then
			
			SetAirBaseSlotCount(unit, 2)
			
		elseif Mission.Difficulty == 1 then
			
			SetAirBaseSlotCount(unit, 3)
		
		elseif Mission.Difficulty == 2 then
			
			SetAirBaseSlotCount(unit, 3)
		
		end
		
	end
	
	Mission.CVGrp = {}
		table.insert(Mission.CVGrp, FindEntity("Prince William"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class01"))
		table.insert(Mission.CVGrp, FindEntity("Fletcher-class02"))
		--table.insert(Mission.CVGrp, FindEntity("Fletcher-class03"))
		--table.insert(Mission.CVGrp, FindEntity("Fletcher-class04"))
	
	for idx,unit in pairs(Mission.CVGrp) do
		
		JoinFormation(unit, Mission.CVGrp[1])
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
	
	if Mission.Difficulty == 0 then
		
		SetAirBaseSlotCount(Mission.PrinceWilliam, 2)
		
	elseif Mission.Difficulty == 1 then
		
		SetAirBaseSlotCount(Mission.PrinceWilliam, 3)
	
	elseif Mission.Difficulty == 2 then
		
		SetAirBaseSlotCount(Mission.PrinceWilliam, 3)
	
	end
	
	Mission.CruiserGrp = {}
		table.insert(Mission.CruiserGrp, FindEntity("Perth"))
		table.insert(Mission.CruiserGrp, FindEntity("Sydney"))
		--table.insert(Mission.CruiserGrp, FindEntity("Canberra"))
		--table.insert(Mission.CruiserGrp, FindEntity("Melbourne"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class05"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class06"))
		--[[table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class07"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class08"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class09"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class10"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class11"))
		table.insert(Mission.CruiserGrp, FindEntity("Fletcher-class12"))]]
	
	for idx,unit in pairs(Mission.CruiserGrp) do
		
		JoinFormation(unit, Mission.CruiserGrp[1])
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
		
		UnitSetFireStance(unit, 2)
		
	end
	
	if Mission.Difficulty == 0 then
		
		Mission.SubNum = 1
		
	elseif Mission.Difficulty == 1 then
		
		Mission.SubNum = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.SubNum = 3
		
	end
	
	Mission.Subs = {}
		table.insert(Mission.Subs, GenerateObject("Nautilus"))
	
	if Mission.Difficulty == 1 then
		
		table.insert(Mission.Subs, GenerateObject("Cachalot"))
		
		if Mission.Difficulty == 2 then
		
			table.insert(Mission.Subs, GenerateObject("Salmon"))
		
		end
	
	end
	
	local subMove = 6000
	
	for idx,unit in pairs(Mission.Subs) do
		
		local baseUnit = luaPickRnd(Mission.IJNShips)
		local unitPos = GetPosition(baseUnit)
		local posIdx = random(1,2)
		local moveAxis
		
		if posIdx == 1 then
		
			unitPos.x = unitPos.x + random(-500,2000)
			unitPos.z = unitPos.z + subMove
		
		elseif posIdx == 2 then
		
			unitPos.x = unitPos.x + subMove
			unitPos.z = unitPos.z + random(-500,2000)
		
		end
		
		unitPos.y = -20
		
		PutTo(unit, unitPos)
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
			
			if Mission.Difficulty == 2 then
			
				SetUnlimitedAirSupply(unit, true)
			
			end
			
		end
		
		local trg
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
			trg = luaPickRnd(Mission.IJNShips)
		
		else
		
			trg = luaPickRnd(Mission.IJNTrans)
		
		end
		
		EntityTurnToEntity(unit, trg)
		NavigatorAttackMove(unit, trg)
		UnitSetFireStance(unit, 2)
		
	end
	
	Mission.CounterAttack = {}
	
	---- VAR ----
	
	--Mission.SYSpawn1 = FindEntity("MainShipyard 01 Navpoint 01")
	--Mission.SYSpawn2 = FindEntity("MainShipyard 02 Navpoint 01")
	
	---- VALUES & VARIABLES ----
	
	local pathIdx = luaRnd(1,2)
	local pathDirIdx1 = random(1,2)
	local pathDirIdx2 = random(1,2)
	local path1
	local path2
	local pathDir1
	local pathDir2
	
	if pathIdx == 1 then
	
		path1 = FindEntity("PatrolPath1")
		path2 = FindEntity("PatrolPath2")
	
	elseif pathIdx == 2 then
	
		path1 = FindEntity("PatrolPath2")
		path2 = FindEntity("PatrolPath1")
	
	end
	
	if pathDirIdx1 == 1 then
	
		pathDir1 = PATH_SM_JOIN
	
	elseif pathDirIdx1 == 2 then
	
		pathDir1 = PATH_SM_JOIN_BACKWARDS
	
	end
	
	if pathDirIdx2 == 1 then
	
		pathDir2 = PATH_SM_JOIN
	
	elseif pathDirIdx2 == 2 then
	
		pathDir2 = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.CVGrp[1], path1, PATH_FM_CIRCLE, pathDir1)
	NavigatorMoveOnPath(Mission.CruiserGrp[1], path2, PATH_FM_CIRCLE, pathDir2)
	
	Mission.MissionPhase = 0
	Mission.CanMusicCheck = true
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
		Mission.SYSpawnDelay = 300
		
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		Mission.SYSpawnDelay = 200
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		Mission.SYSpawnDelay = 120
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("February 15, 1942 - Near Port Moresby")
	
	Blackout(true, "", true)
	
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
	
	--luaShowPath(FindEntity("PatrolPath2"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.IJNTrans) do
		
			SetInvincible(unit, 0.4)
			
		end
		
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
				
				local capParty = Mission.PortMoresby.Party
				
				if capParty == PARTY_JAPANESE then
					
					SetInvincible(Mission.PortMoresby, 0.01)
					
					if IsListenerActive("recon", "TroopListener") then
					
						RemoveListener("recon", "TroopListener")
					
					end
					
					if IsListenerActive("recon", "SubListener") then
					
						RemoveListener("recon", "SubListener")
					
					end
					
					if IsListenerActive("recon", "ElcoListener") then
					
						RemoveListener("recon", "ElcoListener")
					
					end
					
					if IsListenerActive("recon", "CVListener") then
					
						RemoveListener("recon", "CVListener")
					
					end
					
					if luaObj_IsActive("primary",1) then
						
						luaObj_Completed("primary",1)
					
					end
					
					if luaObj_IsActive("primary",2) then
						
						luaObj_Completed("primary",2)
					
					end
					
					luaStartDialog("FINAL")
					
					Mission.EndMission = true
					
				else
					
					local cap = GetCapturePercentage(Mission.PortMoresby)
					
					Mission.Cap = string.format("%.0f",(cap * 100))
					
					local line1 = "Capture the port!"
					local line2 = "Capture progress: #Mission.Cap#%"
					luaDisplayScore(2, line1, line2)
					
					if capParty == PARTY_NEUTRAL and not Mission.CounterAttackSpawned then
					
						luaDelay(luaSpawnCounterAttack, 10)
						
						Mission.CounterAttackSpawned = true
					
					end
					
				end
				
			end
			
			if luaObj_IsActive("primary", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNTrans)) == 0 then
				
					luaMissionFailed()
				
				end
				
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.AFHQ.Party == PARTY_JAPANESE and not Mission.AFOursDiaPlayed then
				
					luaStartDialog("AFOURS")
					
					Mission.AFOursDiaPlayed = true
				
				end
			
			end
			
			if luaObj_IsActive("hidden", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 0 then
				
					luaObj_Completed("hidden", 1, true)
				
				end
				
			end
			
			if luaObj_IsActive("hidden", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.IJNTrans)) <= 3 then
				
					luaObj_Failed("hidden",2)
				
				end
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.Airfields)) > 0 then
				
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Airfields)) do
					
					if not unit.Dead and unit.Party == PARTY_ALLIED then
						
						local fighters = {
							[1] = 135,
							[2] = 104,
						}
						
						local bombers = {
							--[1] = 838,
							[1] = 108,
							[2] = 112,
							[3] = 113,
						}
						
						if Mission.Difficulty == 1 or Mission.Difficulty == 2 then
						
							bombers[4] = 118
							
							if unit.Name == "MainAirfieldEntity 01" then
							
								bombers[5] = 323
							
							end
						
						end
						
						local trgs
						
						if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
						
							trgs = Mission.IJNShips
						
						else
						
							trgs = Mission.IJNTrans
						
						end
						
						luaAirfieldManager(unit, fighters, bombers, luaRemoveDeadsFromTable(trgs))
						
					end
				
				end
			
			end
			
			if Mission.PrinceWilliam and not Mission.PrinceWilliam.Dead then
			
				local fighters = {
					[1] = 102,
				}
				
				local bombers = {
					--[1] = 838,
					[1] = 108,
					[2] = 112,
					[3] = 113,
				}
				
				local trgs
				
				if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
				
					trgs = Mission.IJNShips
				
				else
				
					trgs = Mission.IJNTrans
				
				end
				
				luaAirfieldManager(Mission.PrinceWilliam, fighters, bombers, luaRemoveDeadsFromTable(trgs))
			
			end
			
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 1 ----

function luaSYFlow()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.Shipyards)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Shipyards)) do
			
			if unit and not unit.Dead then
			
				local spawn = GetPosition(unit.spawnPoint)
				local unitIdx = random(1,2)
				local unitToSpawn
				local trg
				
				if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
				
					trg = luaPickRnd(Mission.IJNShips)
				
				else
				
					trg = luaPickRnd(Mission.IJNTrans)
				
				end
				
				if unitIdx == 1 then
				
					unitToSpawn = GenerateObject("Catalina")
					
					PutTo(unitToSpawn, spawn)
					
					PilotSetTarget(unitToSpawn, trg)
					
				elseif unitIdx == 2 then
				
					unitToSpawn = GenerateObject("Elco")
					
					PutTo(unitToSpawn, spawn)
					
					NavigatorAttackMove(unitToSpawn, trg)
					
					NavigatorSetTorpedoEvasion(unitToSpawn, true)
					NavigatorSetAvoidLandCollision(unitToSpawn, true)
					TorpedoEnable(unitToSpawn, true)
					
					if not Mission.ElcoListenerAdded then
					
						luaAddElcoListener(unitToSpawn)
						
						Mission.ElcoListenerAdded = true
					
					end
					
				end
				
				SetSkillLevel(unitToSpawn, Mission.SkillLevel)
				UnitSetFireStance(unitToSpawn, 2)
				
			end
			
		end
		
		luaDelay(luaSYFlow, Mission.SYSpawnDelay)
		
	end
	
end

function luaSpawnCounterAttack()

	local tooper1 = GenerateObject("Paratrooper-01")
	local tooper2 = GenerateObject("Paratrooper-02")
	
	local tempTbl = {tooper1, tooper2}
	
	if Mission.Difficulty > 0 then
	
		local tooperesc1 = GenerateObject("ParatrooperEsc-01")
		local tooperesc2 = GenerateObject("ParatrooperEsc-02")
		
		table.insert(tempTbl, tooperesc1)
		table.insert(tempTbl, tooperesc2)
		
	end
	
	table.insert(Mission.CounterAttack, tooper1)
	table.insert(Mission.CounterAttack, tooper2)
	
	for idx,unit in pairs(tempTbl) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		
		local trg
		
		if unit.Class.Type == "Fighter" then
			
			trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.CounterAttack))
			
			PilotMoveToRange(unit, trg)
		
		elseif unit.Class.Type == "LevelBomber" then
			
			trg = Mission.PortMoresby
			
			PilotSetTarget(unit, trg)
		
		end
		
	end
	
	if not Mission.ListenerSet then
	
		luaAddTroopListener()
		
		luaDelay(luaSpawnCounterAttack, 20)
		
		Mission.ListenerSet = true
	
	end
	
end

function luaIntroMovie()
	
	Blackout(false, "", 1)
	
	luaDelay(luaIntroDia, 4)
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-7825,["y"]=11,["z"]=-6400},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-7700,["y"]=11,["z"]=-6500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-7700,["y"]=11,["z"]=-6500},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-7825,["y"]=15,["z"]=-6350},["parent"] = nil,},["moveTime"] = 18,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-5650,["y"]=11,["z"]=-8250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-6000,["y"]=11,["z"]=-8250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-6000,["y"]=11,["z"]=-8250},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-5550,["y"]=15,["z"]=-8220},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 4000, ["theta"] = 8, ["rho"] = 250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 4000, ["theta"] = 8, ["rho"] = 250, ["moveTime"] = 2,},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 2000, ["theta"] = 9, ["rho"] = 250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 2000, ["theta"] = 9, ["rho"] = 250, ["moveTime"] = 2,},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 600, ["theta"] = 10, ["rho"] = 250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("SecondaryAirfieldEntity 01"), ["distance"] = 600, ["theta"] = 10, ["rho"] = 250, ["moveTime"] = 6,},
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Taiho"), ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIntroMovieEnd, true)
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Taiho"))
	
	EnableMessages(true)
	
	luaDelay(luaAddFirstObjs, 3)
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.PortMoresby)
	luaObj_Add("primary", 2, Mission.IJNTrans)
	luaObj_Add("secondary", 1, Mission.SecHQs)
	luaObj_Add("hidden", 1)
	luaObj_Add("hidden", 2)
	
	DisplayUnitHP((luaRemoveDeadsFromTable(Mission.IJNTrans)), "Protect your transports!")
	
	luaSYFlow()
	luaAddSubListener()
	luaAddCVListener()
	--luaAddJapFleetListener()

end

---- LISTENERS ----

function luaAddTroopListener()

	AddListener("recon", "TroopListener", {
		["callback"] = "luaTroopSighted",
		["entity"] = Mission.CounterAttack,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddSubListener()

	AddListener("recon", "SubListener", {
		["callback"] = "luaSubSighted",
		["entity"] = Mission.Subs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddElcoListener(unit)

	AddListener("recon", "ElcoListener", {
		["callback"] = "luaElcoSighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

function luaAddCVListener()

	AddListener("recon", "CVListener", {
		["callback"] = "luaCVSighted",
		["entity"] = {Mission.PrinceWilliam},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_JAPANESE},
	})

end

--[[function luaAddJapFleetListener()

	AddListener("recon", "JapFleetListener", {
		["callback"] = "luaJapFleetSighted",
		["entity"] = Mission.IJNShips,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end]]

---- LISTENER CALLBACKS ----

function luaTroopSighted()
	
	RemoveListener("recon", "TroopListener")
	
	luaStartDialog("TROOP")

end

function luaSubSighted()
	
	RemoveListener("recon", "SubListener")
	
	luaStartDialog("SONAR")

end

function luaElcoSighted()
	
	RemoveListener("recon", "ElcoListener")
	
	luaStartDialog("ELCO")

end

function luaCVSighted()
	
	RemoveListener("recon", "CVListener")
	
	luaStartDialog("ESCORT")

end

--[[function luaJapFleetSighted()
	
	RemoveListener("recon", "JapFleetListener")
	
	MissionNarrative("sited")

end]]

---- MISSION ENDERS ----

function luaMissionComplete()
	
	HideUnitHP()
	
	if luaObj_IsActive("secondary",1) then
		
		if Mission.AFHQ.Party == PARTY_JAPANESE and Mission.RadarStation.Party == PARTY_JAPANESE then
		
			luaObj_Completed("secondary",1)
		
		else
		
			luaObj_Failed("secondary",1)
		
		end
		
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("hidden",2) then
		
		luaObj_Failed("hidden",2)
	
	end
	
	luaMissionCompletedNew(Mission.PortMoresby, "Port Moresby is ours - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true
	
	HideUnitHP()
	
	if IsListenerActive("recon", "TroopListener") then
	
		RemoveListener("recon", "TroopListener")
	
	end
	
	if IsListenerActive("recon", "SubListener") then
	
		RemoveListener("recon", "SubListener")
	
	end
	
	if IsListenerActive("recon", "ElcoListener") then
	
		RemoveListener("recon", "ElcoListener")
	
	end
	
	if IsListenerActive("recon", "CVListener") then
	
		RemoveListener("recon", "CVListener")
	
	end
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
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