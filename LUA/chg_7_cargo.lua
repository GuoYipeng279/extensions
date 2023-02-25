--SceneFile="universe\Scenes\missions\Challenge\crucialcargo.scn"
DoFile("Scripts/datatables/Inputs.lua")
Inputs = nil

function luaPrecacheUnits()
	
	PrepareClass(171)
	
end

function luaStageInit()
	CreateScript("luaInitSubC1")
end


function luaInitSubC1(this)

	SETLOG(this, true)

	Mission = this
	this.Name = "SubC1"

	this.CustomLog = true
	this.HelperLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating Sub Challenge 1 - Crucial Cargo")

	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("subc1")
	LoadSelectedPaths()
	
	SetWeather("clear")
	SetDayTime(17,12)
	local cBox = {
			[1] = {["x"] = -9000, ["y"] = 400, ["z"] = -9000},
			[2] = {["x"] = 9000, ["y"] = 550, ["z"] = 9000},
		}
		--luaGenerateRandomClouds(35,cBox,2,1,0)
	
	this.Party = SetParty(this, PARTY_ALLIED)
	this.MissionPhase = 0
	this.FreeToGo = false

	this.PlayerUnit = FindEntity("Narwhal")
	RepairEnable(FindEntity("Narwhal"), false)
	
	--[[for i=1,4 do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = GetPosition(FindEntity(tostring("gull_"..i))),
			["tempID"] = "siraly"..tostring(i),
		})
	end]]
	
	this.Warships = {}
		table.insert(this.Warships, FindEntity("Mikuma"))
		table.insert(this.Warships, FindEntity("Kitakami"))

	this.Escorts = {}
		table.insert(this.Escorts, FindEntity("Yugiri"))
		table.insert(this.Escorts, FindEntity("Asagiri"))
		table.insert(this.Escorts, FindEntity("Gyoraitei 1"))
		table.insert(this.Escorts, FindEntity("Gyoraitei 2"))

	this.SeaplanesTemplate = {}
		table.insert(this.SeaplanesTemplate, luaFindHidden("F1M Pete"))
	this.Seaplanes = {}

	

	this.Cargos = {}
		table.insert(this.Cargos, FindEntity("Kuryu Maru"))
		table.insert(this.Cargos, FindEntity("Hake Maru"))
		table.insert(this.Cargos, FindEntity("Sado Maru"))
		table.insert(this.Cargos, FindEntity("Yae Maru"))
		table.insert(this.Cargos, FindEntity("Taijun Maru"))
		table.insert(this.Cargos, FindEntity("Shunsei Maru"))
	--if PC or XBOX then
		table.insert(this.Cargos, FindEntity("Ryujin Maru"))
		table.insert(this.Cargos, FindEntity("Komaki Maru"))
		table.insert(this.Cargos, FindEntity("Toba Maru"))
		table.insert(this.Cargos, FindEntity("Uzan Maru"))
		table.insert(this.Cargos, FindEntity("Kinjosan Maru"))
		table.insert(this.Cargos, FindEntity("Kongosan Maru"))
	--end
	
	this.ConvoySpeed = 20
	
	this.SpyShip = {}		-- a kem dzsunka

	-- randomizaljuk a ket fo celpontot
	this.CrucialCargo1 = luaPickRnd(this.Cargos)
	luaRemoveByName(this.Cargos, this.CrucialCargo1.Name)	-- atmenetileg kivenni
	this.CrucialCargo2 = luaPickRnd(this.Cargos)			-- hogy ne lehessen a ket fo celpont ugyanaz
	table.insert(this.Cargos, this.CrucialCargo1)		-- visszatenni

	--this.ConvoyLeader = FindEntity("Mikuma")

	--this.SeaplanesSpawned = false
	this.ReportedUnits = {}			-- a megjegyzett unitok tablaja
	--this.ReportedNum = 0				-- megjegyzett fontos unit szama

	--this.ReconAlert = 2
	--this.AlertLevel = 0

	this.CrucialCargo1.reconned = false
	this.CrucialCargo2.reconned = false

	this.ConvoyTargetPos =
	{
		["x"] = 2000,
		["y"] = 0,
		["z"] = 9000,
	}

	local torpStock = Mission.PlayerUnit.Class.MaxTorpedoStock
	--if PS2 then
	--	torpStock = luaRound(torpStock*0.75)	-- PS2-n kevesebb torpedo
	--end

	this.Diff = GetDifficulty()
	if this.Diff == DIFF_ROOKIE then
		ShipSetTorpedoStock(this.PlayerUnit, luaRound(torpStock*1.5))
	elseif this.Diff == DIFF_REGULAR then
		ShipSetTorpedoStock(this.PlayerUnit, luaRound(torpStock*1.25))
	end

	for key, unittype in pairs(recon[PARTY_JAPANESE]["own"]) do
		for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  			luaLog("Setting "..this.Diff.." as difficulty to "..unit.Name)
			SetCrewLevel(unit, this.Diff)
		end
	end
	
	this.Narratives =
	{
		["warship_reported"] =
		{
			[1] = "Warship position reported!",
		},
		["important_crucial_reported"] =
		{
			[1] = "Crucial cargo ship position reported!",
		},
		["crucial_reported"] =
		{
			[1] = "Cargo ship position reported!",
		},
		["deep_reported"] =
		{
			[1] = "You are too deep to report!",
		},
	}

	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)

	this.Objectives =
	{
		["primary"] =
		{
			[1] = {
				["ID"] = "identify_cargos",
				["Text"] = "Indentify and report the two important cargo ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
				["Remind"] = true
			},
			[2] = {
				["ID"] = "sink_them",
				["Text"] = "The destruction of these two cargo ships is crucial!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 2000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0,
				["Remind"] = true
			},
		},
		["secondary"] = {},
		["hidden"] =
		{
			[1] =
			{
				["ID"] = "kill_warships",
				["Text"] = "Destroy the convoy warship escort!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 3000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
			[2] = {
				["ID"] = "kill_cargos",
				["Text"] = "Sink all cargo ships in the area!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 300 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
				["Remind"] = true
			},
		},
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	-- Scoring = nil
	
	this.Convoyleader1 = FindEntity("Mikuma")
	this.Convoyleader2 = FindEntity("Ryujin Maru")	
	this.Convoyleader3 = FindEntity("Shunsei Maru")
	
	this.Convoy1 = {}
		table.insert(this.Convoy1, FindEntity("Komaki Maru"))
		table.insert(this.Convoy1, FindEntity("Kongosan Maru"))
		table.insert(this.Convoy1, FindEntity("Kinjosan Maru"))
		table.insert(this.Convoy1, FindEntity("Sado Maru"))
		table.insert(this.Convoy1, FindEntity("Gyoraitei 1"))
		table.insert(this.Convoy1, FindEntity("Asagiri"))
	this.Convoy2 = {}
		table.insert(this.Convoy2, FindEntity("Yugiri"))
		table.insert(this.Convoy2, FindEntity("Kuryu Maru"))
		table.insert(this.Convoy2, FindEntity("Uzan Maru"))
		table.insert(this.Convoy2, FindEntity("Yae Maru"))		
	this.Convoy3 = {}
		table.insert(this.Convoy3, FindEntity("Toba Maru"))
		table.insert(this.Convoy3, FindEntity("Hake Maru"))
		table.insert(this.Convoy3, FindEntity("Taijun Maru"))
		table.insert(this.Convoy3, FindEntity("Kitakami"))
		table.insert(this.Convoy3, FindEntity("Gyoraitei 2"))
		
	for idx,unit in pairs(this.Convoy1) do
		JoinFormation(unit,this.Convoyleader1)
	end	
	
	for idx,unit in pairs(this.Convoy2) do
		JoinFormation(unit,this.Convoyleader2)
	end	
	
	for idx,unit in pairs(this.Convoy3) do
		JoinFormation(unit,this.Convoyleader3)
	end	

	--NavigatorMoveToRange(Mission.ConvoyLeader, Mission.ConvoyTargetPos)
	NavigatorMoveOnPath(this.Convoyleader1, FindEntity("convoy_path"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(this.Convoyleader2, FindEntity("convoy_path_2"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(this.Convoyleader3, FindEntity("convoy_path_3"), PATH_FM_SIMPLE, PATH_SM_JOIN)
	
	for idx,unit in pairs(this.Warships) do
		SetShipSpeed(unit, this.ConvoySpeed)
	end
	
	for idx,unit in pairs(this.Escorts) do
		SetShipSpeed(unit, this.ConvoySpeed)
	end
	
	for idx,unit in pairs(this.Cargos) do
		SetShipSpeed(unit, this.ConvoySpeed)
	end
	
	Blackout(true, "", true)
	
	this.CustomStart = 0
	
	SetThink(this,"luaSubC1_think")

	--watches
	AddWatch("Mission.MissionPhase")
	AddWatch("Mission.Attacker.Name")
	AddWatch("Mission.CamState.Zoom")
	AddWatch("Mission.MissionStatus")
end

function luaSubC1_think(this,msg)
	
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	
	if Mission.MissionStatus ~= nil then
-- RELEASE_LOGOFF  		luaLog("MissionStatus not nil")
		return
	end
	
	if this.CustomEnd then
		luaCheckMusic()
	end	
	
	if not this.CustomMusic then	
		this.CustomMusic = true
		Music_Control_SetLevel(MUSIC_CUSTOM3)
		luaDelaySet("CustomEnd",true,15)
	end
	
	--luaSubC1CheckCrucial(this)
	
	
	if this.MissionPhase == 0 then

		EnableInput(false)
		UnitSetFireStance(Mission.PlayerUnit, STANCE_HOLD_FIRE)
		
		Blackout(true, "", true)
		luaDelay(luaSubC1BlackoutEnd, 0.5)
		luaSubC1StartIntroMovie()
		
		luaSubC1StepPhase()

	elseif this.MissionPhase == 1 then

		if not this.FreeToGo then
			return
		end
		
		if not this.CrucialCargo1.reconned and not this.CrucialCargo2.reconned then
			SetWait(this,0.5)
		end
		
		luaSubC1CheckObjectives(this)
		luaSubC1luaReportEnemy(this)
		SubC1Attack()

		if next(luaRemoveDeadsFromTable(this.Warships)) == nil and next(luaRemoveDeadsFromTable(this.Escorts)) == nil then
			luaSubC1StepPhase()
		end

		if this.Cheat_PhaseShift then
			this.Cheat_PhaseShift = false
			local navpoint = GetPosition(FindEntity("NavPoint"))
			navpoint.y = 0
			if not this.CrucialCargo1.Dead then
				LeaveFormation(this.CrucialCargo1)
				navpoint.x = navpoint.x + 500
				PutTo(this.CrucialCargo1, navpoint)
			end
			if not this.CrucialCargo2.Dead then
				LeaveFormation(this.CrucialCargo2)
				navpoint.x = navpoint.x - 1000
				PutTo(this.CrucialCargo2, navpoint)
			end
		end
		--luaSubC1CheckSeaPlanes(this)

	elseif this.MissionPhase == 2 then

		luaSubC1CheckObjectives(this)
		luaSubC1luaReportEnemy(this)
		luaSubC1CheckSeaPlanes(this)
		SubC1Attack()

	end
end

function luaSubC1StartIntroMovie()
	EnableInput(false)
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.PlayerUnit,
               ["pos"] = { 0, 0, 20, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["zoom"] = 0.9,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.PlayerUnit,
               ["pos"] = { 0, 0, 18, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=7.0,
           ["zoom"] = 0.9,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=Mission.PlayerUnit,
				["modifier"] = {
					["name"] = "goaround",
					["radius"] = { 90, 7, 80 },
					["radiuslinearblend"] = 1.0,
					["rho"] = { -35, 7, -42 },
					["rholinearblend"] = 1.0,
					["theta"] = { -5, 7, -10 },
					["thetalinearblend"] = 1.0,
				}
			},
			["transformtype"]="keepy",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["linearblend"]=1.0,
			["wanderer"]=true,
			["smoothtime"]=2.0,
			["zoom"]=0.9,
			--["finishscript"] = "luaSubC1CrossFade"
		}

	MovCamNew_AddPosition(pos0)

	SetSkipMovie("luaSubC1SkipMovie")
	Mission.Delay = luaDelay(luaSubC1CrossFade,15)
end

function luaSubC1CrossFade()
	
	luaCrossFade(luaSubC1EndMovie)

end

function luaSubC1EndMovie()	
	
	--komaki maru
	--asigiri
	--mikuma
	local pos0 = {
			["postype"]="camera",
			["position"]= {
				["parent"]=FindEntity("Mikuma"),
				["pos"] = { 80, 20, 250, },
			},
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["wanderer"]=true,
			["transformtype"]="keepnone",
			["smoothtime"]=0.0,
			["zoom"]=3,
		}

	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
			["postype"]="target",
			["position"]= {
				["parent"]=FindEntity("Komaki Maru"),
				["pos"] = { -80, 0, 0, },
			},
			["transformtype"]="keepnone",
			["starttime"]=0.0,
			["blendtime"]=0.0,
			["zoom"] = 3,
			["wanderer"]=true,
		}
		
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
			["postype"]="target",
			["position"]= {
				["parent"]=FindEntity("Kuryu Maru"),
				["pos"] = { 300, 0, 0, },
			},
			["transformtype"]="keepnone",
			["starttime"]=0.2,
			["blendtime"]=10.0,
			["zoom"] = 3,
			["smoothtime"] = 2.0,
			["wanderer"]=true,
		}
		
	MovCamNew_AddPosition(pos0)
	
	local pos0 = {
			["postype"]="target",
			["position"]= {
			--	["parent"]=FindEntity("Kuryu Maru"),
			--	["pos"] = { 0, 0, 0, },
			},
			["transformtype"]="keepnone",
			["starttime"]=10.1,
			["blendtime"]=0.0,
			["zoom"] = 3,
			["smoothtime"] = 2.0,
			["wanderer"]=true,
			["finishscript"] = "luaSubC1EndIntroMovie",
		}
		
	MovCamNew_AddPosition(pos0)
end

function luaSubC1EndIntroMovie()
	luaCrossFade(luaSubC1Go)
end

function luaSubC1Go()	
	SetSkipMovie()
	Mission.MovieEnd = true
	SetSelectedUnit(Mission.PlayerUnit)
	EnableInput(true)
	Mission.FreeToGo = true	
end

function luaSubC1StepPhase()
	Mission.MissionPhase = Mission.MissionPhase + 1
end

function SubC1Attack()
	
	if next(Mission.Escorts) == nil or Mission.PlayerUnit.Dead then
		return
	end
	
	ForceRecon()
	--local isVisible = next(recon[PARTY_JAPANESE].enemy.submarine)
	local isVisible = Mission.PlayerUnit.reconlevel[PARTY_JAPANESE]
	
	--luaLog("visible?")
	if isVisible == 0 then
		--luaLog("not visible")
		
		if Mission.Attacker and not Mission.Attacker.Dead then
			local next = luaSortByDistance(Mission.Attacker, luaGetShipsAround(Mission.Attacker, 20000, "own"), true)
			--luaLog("next")
			--luaLog(next)
			if IsInFormation(next) then
				JoinFormation(Mission.Attacker, next)
			else
				Mission.Cargos = luaRemoveDeadsFromTable(Mission.Cargos)
				if next(Mission.Cargos) ~= nil then
					JoinFormation(Mission.Attacker, luaPickRnd(Mission.Cargos))
				end
			end
			Mission.Attacker = nil			
		end
		--return
	--else
		--luaLog("inrecon")
		--luaLog(isVisible)
	end
	
	Mission.Escorts = luaRemoveDeadsFromTable(Mission.Escorts)
	
	if Mission.Attacker == nil or Mission.Attacker.Dead then
		for idx,unit in pairs(Mission.Escorts) do
			if unit.Class.Type == "Destroyer" then
				if IsInFormation(unit) then
					LeaveFormation(unit)
				end
				Mission.Attacker = unit
				SetShipSpeed(unit, 20)
				NavigatorAttackMove(unit, Mission.PlayerUnit, {})
				break
			end
		end
		
		--ha meg mindig nincs tamado akkro PTk
		if Mission.Attacker == nil or Mission.Attacker.Dead then
			for idx,unit in pairs(Mission.Escorts) do			
				if IsInFormation(unit) then
					LeaveFormation(unit)
				end
				Mission.Attacker = unit
				SetShipSpeed(unit, 20)
				NavigatorAttackMove(unit, Mission.PlayerUnit, {})
				break
			end		
		end
	end
end

function luaSubC1CheckObjectives(this)
	if this.PlayerUnit.Dead then
		luaObj_FailedAll()
		luaSubC1AddAndFailHiddens()
		luaSubC1ClearRemind()
		luaMissionFailedNew(this.PlayerUnit, "Your unit has been destroyed!")
		return
	end
	
	if this.CrucialCargo1.Dead and this.CrucialCargo1.KillReason == "exitzone" then
-- RELEASE_LOGOFF  		luaLog("Cargo1 exited")
		--Pause(true)
		luaSubC1AddAndFailHiddens()
		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			luaObj_Failed("primary",1)
		end
		luaSubC1ClearRemind()
		luaMissionFailedNew(this.PlayerUnit, "A crucial cargo ship has escaped from the mission area!")		
		return
	end
	if this.CrucialCargo2.Dead and this.CrucialCargo2.KillReason == "exitzone" then
-- RELEASE_LOGOFF  		luaLog("Cargo2 exited")
		--Pause(true)
		luaSubC1AddAndFailHiddens()
		if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			luaObj_Failed("primary",1)
		end
		luaSubC1ClearRemind()
		luaMissionFailedNew(this.PlayerUnit, "subc1.obj_missionfail1")
		return
	end
	
	if not luaObj_IsActive("primary",1) then
		luaObj_Add("primary",1,nil,true)
		--luaObj_AddReminder("primary",1)
		--MissionNarrative("subc1.nar_begin|".." "..Mission.CrucialCargo1.Name..", "..Mission.CrucialCargo2.Name)
		luaSubC1Remind()
	end
	
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		if this.CrucialCargo1.reconned and this.CrucialCargo2.reconned then
			HideScoreDisplay(1,0)
			luaObj_Completed("primary",1)
			if not luaObj_IsActive("primary",2) and not luaObj_GetSuccess("primary",1) then
				luaObj_Add("primary",2,nil,true)
				local cargoTbl = {this.CrucialCargo1, this.CrucialCargo2}
				DisplayUnitHP(luaRemoveDeadsFromTable(cargoTbl), "The destruction of these two cargo ships is crucial!")
				if not this.CrucialCargo1.Dead then
-- RELEASE_LOGOFF  					luaLog("Adding "..this.CrucialCargo1.Name.." to primary target")
					luaObj_AddUnit("primary", 2, this.CrucialCargo1)
				end
				if not this.CrucialCargo2.Dead then
-- RELEASE_LOGOFF  					luaLog("Adding "..this.CrucialCargo2.Name.." to primary target")
					luaObj_AddUnit("primary", 2, this.CrucialCargo2)
				end
			end
		else
			--luaObj_Reminder("primary",1)
		end
	elseif luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) and not luaObj_IsActive("primary",2) then
		luaObj_Add("primary",2)
		local cargoTbl = {this.CrucialCargo1, this.CrucialCargo2}
		DisplayUnitHP(luaRemoveDeadsFromTable(cargoTbl), "The destruction of these two cargo ships is crucial!")
		if not this.CrucialCargo1.Dead then
-- RELEASE_LOGOFF  			luaLog("Adding "..this.CrucialCargo1.Name.." to primary target")
			luaObj_AddUnit("primary", 2, this.CrucialCargo1)
		end
		if not this.CrucialCargo2.Dead then
-- RELEASE_LOGOFF  			luaLog("Adding "..this.CrucialCargo2.Name.." to primary target")
			luaObj_AddUnit("primary", 2, this.CrucialCargo2)
		end
	end	
	
	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		luaObj_Reminder("primary",2)
	end

	if next(luaRemoveDeadsFromTable(this.Warships)) == nil and not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
			luaObj_Completed("hidden",1)
	end

	if next(luaRemoveDeadsFromTable(this.Cargos)) == nil and not luaObj_IsActive("hidden",2) then
		luaObj_Add("hidden",2)
		luaObj_Completed("hidden",2)
	end

	if this.CrucialCargo1.Dead and this.CrucialCargo2.Dead then
		if this.CrucialCargo1.KillReason == "exitzone" or this.CrucialCargo2.KillReason == "exitzone" then
			return
		end
		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
		end
		luaObj_Completed("primary",1)
		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			local cargoTbl = {this.CrucialCargo1, this.CrucialCargo2}
			DisplayUnitHP(luaRemoveDeadsFromTable(cargoTbl), "The destruction of these two cargo ships is crucial!")
		end
		luaObj_Completed("primary",2)
		HideUnitHP()
		luaSubC1AddAndFailHiddens()
		luaMissionCompletedNew(this.PlayerUnit, "Both crucial cargo vessels have been eliminated!")
	end	
end

function luaSubC1Remind()
	if Mission.MissionStatus ~= nil then
		luaSubC1ClearRemind()
		return
	end
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		MissionNarrative("Identify the crucial cargo ships, named|".." "..Mission.CrucialCargo1.Name..", "..Mission.CrucialCargo2.Name)
		local line1 = "Identify the crucial cargo ships, named:"
		local line2 = "#Mission.CrucialCargo1.Name# and #Mission.CrucialCargo2.Name#"
		luaDisplayScore(1, line1, line2)
		Mission.RemindDelay = luaDelay(luaSubC1Remind,30)
	end
end

function luaSubC1luaReportEnemy(this)
	if this.PlayerUnit.Dead or luaObj_IsActive("primary",2) then
		return
	end
	
	if this.CrucialCargo1.Dead and this.CrucialCargo2.Dead then
		return
	end
	
	local unit = UnitGetAttackTarget(this.PlayerUnit)

	if unit ~= nil then
		MissionNarrativeClear()
		if GetSubmarineDepthLevel(this.PlayerUnit) <= 1 then
			if luaGetReconLevel(unit, PARTY_ALLIED) >= 2 then
				if unit.ID == Mission.CrucialCargo1.ID then				
					Mission.CrucialCargo1.reconned = true
					--MissionNarrative(Mission.Narratives.important_crucial_reported[1])
					luaSubC1AddUnit(1)
				elseif unit.ID == Mission.CrucialCargo2.ID then
					Mission.CrucialCargo2.reconned = true
					MissionNarrative(Mission.Narratives.important_crucial_reported[1])
					luaSubC1AddUnit(2)				
				end
			end
		--else
			--if not IsGUIActive("MapGui.All_Group.Map_Model") then
			--	MissionNarrative(Mission.Narratives.deep_reported[1])
			--end
		end
	end
	
	if IsGUIActive("SubmarineControlGui.Periscope_Model") or GetSubmarineDepthLevel(Mission.PlayerUnit) == 0 then
		local trgInfo = GetTargetInfoTarget()
		
		--if trgInfo then
-- RELEASE_LOGOFF  		--	luaLog("info: "..tostring(trgInfo.Name))
		--end
		
		if trgInfo ~= nil then		
			if not this.CrucialCargo1.reconned then
				if this.CrucialCargo1.ID == trgInfo.ID then
					Mission.CrucialCargo1.reconned = true
					MissionNarrative(Mission.Narratives.important_crucial_reported[1])
					luaSubC1AddUnit(1)
				end
			end
			
			if not this.CrucialCargo2.reconned then
				if this.CrucialCargo2.ID == trgInfo.ID then
					Mission.CrucialCargo2.reconned = true
					MissionNarrative(Mission.Narratives.important_crucial_reported[1])
					luaSubC1AddUnit(2)
				end
			end	
		end		
	end
end

function luaSubC1AddUnit(num)
	if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
		if num == 1 then
			if not Mission.C1Added then
				luaObj_AddUnit("primary",1, Mission.CrucialCargo1)
				Mission.C1Added = true
			end
		elseif num == 2 then
			if not Mission.C2Added then
				luaObj_AddUnit("primary",1, Mission.CrucialCargo2)
				Mission.C2Added = true
			end
		end
	else
		return
	end
end

function luaSubC1SpawnSeaPlane()
	luaSpawnDelayed(Mission.SeaplanesTemplate ,ST_ABSANGLE, GetPosition(Mission.PlayerUnit), 5000, 6000, 500, 0, 360, luaSubC1PlanesSpawned)
end

function luaSubC1PlanesSpawned(unit)
	table.insert(Mission.Seaplanes, unit)
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.Cargos))
	if trg ~= nil then
		PilotMoveToRange(unit, trg, 500)
	else
		PilotMoveToRange(unit, Mission.PlayerUnit, 1000)
	end
end

function luaSubC1CheckSeaPlanes(this)
	if this.PlayerUnit.Dead then
		return
	end
	this.Seaplanes = luaRemoveDeadsFromTable(this.Seaplanes)

	if table.getn(this.Seaplanes) <= 2 then
		luaSubC1SpawnSeaPlane()
	elseif table.getn(this.Seaplanes) > 0 then
		for idx,unit in pairs(this.Seaplanes) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("dead plane found in seaplanestable")
				break
			end
			SetForcedReconLevel(unit,4,PARTY_ALLIED)
			--UpdateUnitTable(unit)
			if unit.ammo == 0 and not unit.retreating then
				PilotRetreat(unit)
				unit.retreating = true
			elseif unit.ammo == 0 and unit.retreating then
				if luaGetDistance(this.PlayerUnit, unit) > 6000 then
					Kill(unit, true)
				end
			elseif unit.ammo ~= 0 then
				if GetSubmarineDepthLevel(this.PlayerUnit) == 0 then
					if not unit.attacking then
						PilotSetTarget(unit, this.PlayerUnit)
						unit.attacking = true
					end
				else
					if unit.attacking and not this.CrucialCargo1.Dead then
						PilotMoveToRange(unit,this.CrucialCargo1,500)
						unit.attacking = false
					elseif unit.attacking and not this.CrucialCargo2.Dead then
						PilotMoveToRange(unit,this.CrucialCargo2,500)
						unit.attacking = false
					end
				end
			end
		end
	end
end

function luaSubC1CheckCrucial(this)
	
end

function luaSubC1SkipMovie()
-- RELEASE_LOGOFF  	luaLog("Enginemovie is running")
	luaCrossFade(luaSubC1MovieClean)
end

function luaSubC1MovieClean()	
	
	if not Mission.CustomEnd then
		Mission.CustomEnd = true
	end

	if not Mission.Delay.Dead then
		luaClearDelay(Mission.Delay)
	end
	
	for idx,dlg in pairs(GetActDialogIDs()) do
		if dlg then
			BreakDialog(dlg)
		end
	end
	luaSubC1Go()
end

function luaSubC1AddAndFailHiddens()
	for idx,obj in pairs(Mission.Objectives.hidden) do
		if not luaObj_IsActive("hidden",idx) then
			luaObj_Add("hidden",idx)
			luaObj_Failed("hidden",idx)
		end
	end
end

function luaSubC1ClearRemind()
	if Mission.RemindDelay ~= nil and not Mission.RemindDelay.Dead then
-- RELEASE_LOGOFF  		luaLog("Reminddelay")
		luaClearDelay(Mission.RemindDelay)
	end
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaSubC1BlackoutEnd()
	Blackout(false, "", 1.5)
end