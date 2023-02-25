---- GERMAN MISSION #1 (KMS) ----

-- Scripted & Assembled by: Team Wolfpack

---- GERMAN MISSION #1 (KMS) ----

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
	
	LoadMessageMap("kmsdlg",1)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/KMS/kms_1.lua"

	this.Name = "KMS1"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Conv",
				["Text"] = "Sink the French convoy!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "BMP",
				["Text"] = "Ensure Bismarck's survival!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Rein",
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
				["ID"] = "CA",
				["Text"] = "Ensure Tirpitz's survival!",
				["TextFailed"] = "The Tirpitz is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Dest",
				["Text"] = "Destroy all the reinforcements!",
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
				{
					["type"] = "pause",
					["time"] = 6,
				},
				{
					["message"] = "INTRO3",
				},
				{
					["message"] = "INTRO4",
				},
			},
		},
		["SUNK"] = {--
			["sequence"] = {
				{
					["message"] = "SUNK1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaPh1FadeOut",
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
		["SPOTTED"] = {--
			["sequence"] = {
				{
					["message"] = "SPOTTED1",
				},
			},
		},
		["OBEY"] = {--
			["sequence"] = {
				{
					["message"] = "OBEY1",
				},
			},
		},
		["FIRING"] = {--
			["sequence"] = {
				{
					["message"] = "FIRING1",
				},
				{
					["message"] = "FIRING2",
				},
			},
		},
		["UNDER"] = {--
			["sequence"] = {
				{
					["message"] = "UNDER1",
				},
				{
					["message"] = "UNDER2",
				},
				{
					["message"] = "UNDER3",
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
	
	Mission.Bismarck = FindEntity("Bismarck")
	Mission.Tirpitz = FindEntity("Tirpitz")
	
	Mission.BismarckFleet = {}
		table.insert(Mission.BismarckFleet, Mission.Bismarck)
		table.insert(Mission.BismarckFleet, Mission.Tirpitz)
		table.insert(Mission.BismarckFleet, FindEntity("Admiral Hipper"))
		table.insert(Mission.BismarckFleet, FindEntity("Seydlitz"))
		table.insert(Mission.BismarckFleet, FindEntity("Z3"))
		table.insert(Mission.BismarckFleet, FindEntity("Z10"))
		table.insert(Mission.BismarckFleet, FindEntity("Z8"))
		table.insert(Mission.BismarckFleet, FindEntity("Z14"))
	
	for idx,unit in pairs(Mission.BismarckFleet) do
		
		JoinFormation(unit, Mission.BismarckFleet[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.Cruisers = {}
		table.insert(Mission.Cruisers, FindEntity("Admiral Hipper"))
		table.insert(Mission.Cruisers, FindEntity("Seydlitz"))
	
	---- GB ----
	
	Mission.Destroyers = {}
	
	Mission.Convoy = {}
		table.insert(Mission.Convoy, FindEntity("Cargo-01"))
		table.insert(Mission.Convoy, FindEntity("Cargo-02"))
		table.insert(Mission.Convoy, FindEntity("Cargo-03"))
		table.insert(Mission.Convoy, FindEntity("Cargo-04"))
		table.insert(Mission.Convoy, FindEntity("Cargo-05"))
		table.insert(Mission.Convoy, FindEntity("Cargo-06"))
		table.insert(Mission.Convoy, FindEntity("Kenya"))
		table.insert(Mission.Convoy, FindEntity("Vercingetorix"))
		table.insert(Mission.Convoy, FindEntity("Brennus"))
		table.insert(Mission.Convoy, FindEntity("Icarus"))
		table.insert(Mission.Convoy, FindEntity("Imogen"))
		table.insert(Mission.Convoy, FindEntity("Imperial"))
		table.insert(Mission.Convoy, FindEntity("Impulsive"))
		table.insert(Mission.Convoy, FindEntity("Intrepid"))
		
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
		
		if unit.Class.Type == "Destroyer" or unit.Class.Type == "Cruiser" then
		
			table.insert(Mission.Destroyers, unit)
		
		end
		
	end
	
	Mission.Cargos = {}
		table.insert(Mission.Cargos, FindEntity("Cargo-01"))
		table.insert(Mission.Cargos, FindEntity("Cargo-02"))
		table.insert(Mission.Cargos, FindEntity("Cargo-03"))
		table.insert(Mission.Cargos, FindEntity("Cargo-04"))
		table.insert(Mission.Cargos, FindEntity("Cargo-05"))
		table.insert(Mission.Cargos, FindEntity("Cargo-06"))
	
	for idx,unit in pairs(Mission.Cargos) do
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
		if Mission.Difficulty == 0 then
		
			SetShipMaxSpeed(unit, 7)
			
		elseif Mission.Difficulty == 1 then
		
			SetShipMaxSpeed(unit, 8)
			
		elseif Mission.Difficulty == 2 then
		
			SetShipMaxSpeed(unit, 9)
			
		end
		
	end
	
	---- VAR ----
	
	Mission.CargoEscapes = {}
		table.insert(Mission.CargoEscapes, FindEntity("CargoEscape1"))
		table.insert(Mission.CargoEscapes, FindEntity("CargoEscape2"))
		table.insert(Mission.CargoEscapes, FindEntity("CargoEscape3"))
	
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
	
	--SetSimplifiedReconMultiplier(1.3)
	
	EnableMessages(false)
	
	MissionNarrative("May 17th, 1940 - Off the French coast")
	
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
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("PHMovingInPathSouth"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--DisplayUnitHP({FindEntity("Cargo-01")}, "Protect your transports!")
	
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
			
			if luaObj_IsActive("primary", 2) then
			
				if Mission.Bismarck.Dead then
				
					luaMissionFailed()
				
				end
			
			end
			
			if luaObj_IsActive("secondary", 1) then
			
				if Mission.Tirpitz.Dead then
				
					luaObj_Failed("secondary", 1, true)
				
				end
			
			end
			
			if not Mission.MaydayDiaPlayed then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.BismarckFleet)) <= 7 then
				
					luaStartDialog("MAYDAY")
					
					Mission.MaydayDiaPlayed = true
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.Cargos)) == 0 then
					
					HideUnitHP()
					
					luaObj_Completed("primary", 1)
					
					luaStartDialog("SUNK")
				
				else
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Convoy)) do
					
						if unit and not unit.Dead then
						
							local untPos = GetPosition(unit)
					
							if IsInBorderZone(untPos) then
							
								luaMissionFailed()
							
							end
						
						end
					
					end
				
				end
			
			end
		
		else
		
			if luaObj_IsActive("primary", 3) then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.BCFleet)) == 0 then
				
					if not Mission.BBsHere then
					
						CountdownCancel()
					
					else
					
						luaObj_Completed("hidden",1)
					
					end
					
					HideUnitHP()
					
					luaMissionComplete()
					
					Mission.SetToComplete = true
					
				else
					
					if Mission.DDsCanAttack then
						
						local fleet
						
						if Mission.MissionPhase == 2 then
						
							fleet = Mission.BCFleet
						
						elseif Mission.MissionPhase == 3 then
						
							fleet = Mission.BBFleet
						
						end
						
						local ordered = luaSortByDistance(Mission.Bismarck, luaRemoveDeadsFromTable(fleet))
						local closest = ordered[1]
						
						if luaGetDistance(Mission.Bismarck, closest) < 3000 then
						
							luaMakeDDsAttack()
						
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

function luaMoveToPh3()
	
	if not Mission.SetToComplete then
	
		Mission.BBsHere = true
		Mission.MissionPhase = 3
	
		Mission.BBFleet = {}
			table.insert(Mission.BBFleet, GenerateObject("Barham"))
			table.insert(Mission.BBFleet, GenerateObject("Malaya"))
			table.insert(Mission.BBFleet, GenerateObject("York"))
			table.insert(Mission.BBFleet, GenerateObject("Berwick"))
			table.insert(Mission.BBFleet, GenerateObject("Lagos"))
			table.insert(Mission.BBFleet, GenerateObject("Trafalgar"))
			table.insert(Mission.BBFleet, GenerateObject("Cadiz"))
		
		for idx,unit in pairs(Mission.BBFleet) do
			
			JoinFormation(unit, Mission.BBFleet[1])
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
			
			if unit.Class.Type == "Destroyer" or unit.Class.Type == "Cruiser" then
			
				table.insert(Mission.Destroyers, unit)
			
			end
			
			table.insert(Mission.BCFleet, unit)
			
			SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
			
		end
		
		NavigatorAttackMove(Mission.BBFleet[1], Mission.Bismarck)
		
		Mission.DDsCanAttack = true
	
		if Mission.Difficulty > 0 then
		
			luaDelay(luaMakeDDsAttack, 120)
		
		end
		
		DisplayUnitHP(luaRemoveDeadsFromTable(Mission.BCFleet), "Sink the enemy reinforcements!")
		
		luaStartDialog("OBEY")
		
	end

end

---- PHASE 2 ----

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.BCFleet = {}
		table.insert(Mission.BCFleet, GenerateObject("Anson"))
		table.insert(Mission.BCFleet, GenerateObject("Repulse"))
		table.insert(Mission.BCFleet, GenerateObject("London"))
		table.insert(Mission.BCFleet, GenerateObject("Kent"))
		table.insert(Mission.BCFleet, GenerateObject("Bedouin"))
		table.insert(Mission.BCFleet, GenerateObject("Mohawk"))
		table.insert(Mission.BCFleet, GenerateObject("Ivanhoe"))
	
	for idx,unit in pairs(Mission.BCFleet) do
		
		JoinFormation(unit, Mission.BCFleet[1])
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
		
		if unit.Class.Type == "Destroyer" or unit.Class.Type == "Cruiser" then
		
			table.insert(Mission.Destroyers, unit)
		
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.BCFleet[1], Mission.Bismarck)
	
	luaDelay(luaBCDia, 2)
	
	Mission.SelUnit = GetSelectedUnit()
	
	local trg1 = Mission.BCFleet[1]
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera", ["position"]={["parent"] = trg1, ["pos"] = {["x"] = 160, ["z"] = 170, ["y"] = 60 }}, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "target", ["target"] = trg1, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 4, ["rho"] = 348, ["moveTime"] = 8, ["smoothtime"] = 1, ["nonlinearblend"] = 1},
		
	}, luaReinMovieEnd, true)
	
end

function luaBCDia()

	luaStartDialog("SPOTTED")

end

function luaReinMovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(luaPickRnd(luaRemoveDeadsFromTable(Mission.BismarckFleet)))
	
	end
	
	luaAddFinalObjs()

end

function luaAddFinalObjs()
	
	luaObj_Add("primary", 3)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.BCFleet), "Sink the enemy reinforcements!")
	
	luaDelay(luaMoveToPh3, 120)
	Countdown("British reinforcements arrive in: ", 0, 120)
	
	Mission.DDsCanAttack = true
	
	if Mission.Difficulty > 0 then
	
		luaDelay(luaMakeDDsAttack, 120)
	
	end
	
end

---- PHASE 1 ----

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 3)

end

function luaMakeDDsAttack()

	if table.getn(luaRemoveDeadsFromTable(Mission.Destroyers)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Destroyers)) do
		
			if unit and not unit.Dead then
			
				local trg
				
				if Mission.Difficulty == 2 then
				
					trg = Mission.Bismarck
				
				else
				
					trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.BismarckFleet))
				
				end
				
				NavigatorAttackMove(unit, trg)
				
				UnitSetFireStance(unit, 2)
				
			end
			
		end
		
	end
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Cargos)) do
		
		if unit and not unit.Dead then
		
			NavigatorMoveToRange(unit, luaPickRnd(Mission.CargoEscapes))
		
		end
		
	end
	
	Mission.DDsCanAttack = false
	
end

function luaIntroMovie()

	luaDelay(luaIntroDia, 6)
	
	local trg1 = FindEntity("Bismarck")
	
	luaIngameMovie(
	{
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-1225,["y"]=10,["z"]=-1876},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-1250,["y"]=10,["z"]=-1776},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-1250,["y"]=10,["z"]=-1776},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-1219,["y"]=12,["z"]=-1876},["parent"] = nil,},["moveTime"] = 12,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-430,["y"]=8,["z"]=-1580},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-450,["y"]=8,["z"]=-1680},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=-450,["y"]=8,["z"]=-1680},["parent"] = nil,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-430,["y"]=10,["z"]=-1580},["parent"] = nil,},["moveTime"] = 9,["transformtype"] = "keepall"},
		
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=14,["y"]=5,["z"]=80},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=200},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
	    {["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=5,["z"]=200},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "camera",["position"] = {["pos"] = {["x"]=14,["y"]=7,["z"]=10},["parent"] = trg1,},["moveTime"] = 15,["transformtype"] = "keepall"},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroDia()

	luaStartDialog("INTRO")

end

--[[function luaIntroText1()

	MissionNarrative("The battle of France is almost over.\n The last few French ships stationed in France are escaping for the UK.")

end

function luaIntroText2()

	MissionNarrative("The British have provided cover for the escaping French convoys,/n although they are no match for the Bismarck!")

end]]

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	Mission.MissionPhase = 1
	
	SetSelectedUnit(Mission.Bismarck)
	
	Mission.CanMusicCheck = true
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Cargos)
	luaObj_Add("primary", 2, Mission.Bismarck)
	luaObj_Add("secondary", 1, Mission.Tirpitz)
	luaObj_Add("hidden", 1)
	
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.Cargos), "Sink the French convoy!")
	
	if Mission.Difficulty > 0 then
	
		luaDelay(luaMakeDDsAttack, 30)
	
	end
	
	luaDelay(luaFiringDia, 60)
	
	luaAddConvoyHitListener()
	
end

function luaFiringDia()

	luaStartDialog("FIRING")

end

---- LISTENERS ----

function luaAddConvoyHitListener()

	AddListener("hit", "ConvoyHitListener", {
		["callback"] = "luaConvoyHit",
		["target"] = Mission.Convoy,
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

function luaConvoyHit()

	RemoveListener("hit", "ConvoyHitListener")
	
	luaStartDialog("UNDER")

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
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(Mission.Bismarck, "The convoy has been destryed - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		HideUnitHP()
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(Mission.Bismarck, "Game Over")
	
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