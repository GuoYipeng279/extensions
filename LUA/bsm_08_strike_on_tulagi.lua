---- STRIKE ON TULAGI (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- STRIKE ON TULAGI (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(175) -- Emily
	
	PrepareClass(77) -- Gyio
	PrepareClass(67) -- Mogami
	
	PrepareClass(41) -- LST
	
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
	
	LoadMessageMap("bsmdlg",8)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_08_strike_on_tulagi.lua"

	this.Name = "BSM08"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Airfield",
				["Text"] = "Destroy the airfield hangars!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Shipyard",
				["Text"] = "Destroy the seaplane hangar!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Yorktown",
				["Text"] = "Yorktown must survive the encounter!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "LSTs",
				["Text"] = "Make sure at least three landing ships come ashore!",
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
				["Text"] = "Destroy the fortress protecting the bay!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Supp",
				["Text"] = "Destroy the Japanese support to protect the LSTs!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Cragos",
				["Text"] = "Sink the Japanese cargo ships!",
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
					["type"] = "callback",
					["callback"] = "luaIntroMovie1",
				},
				{
					["message"] = "INTRO1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie3",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie2",
				},
				{
					["message"] = "INTRO3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovie3",
				},
				{
					["message"] = "INTRO4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaIntroMovieEnd",
				},
			},
		},
		["KUMA"] = {
			["sequence"] = {
				{
					["message"] = "KUMA1",
				},
				{
					["message"] = "KUMA2",
				},
			},
		},
		["HOME"] = {
			["sequence"] = {
				{
					["message"] = "HOME1",
				},
			},
		},
		["PLANES"] = {
			["sequence"] = {
				{
					["message"] = "PLANES1",
				},
				{
					["message"] = "PLANES2",
				},
			},
		},
		["BOAT"] = {
			["sequence"] = {
				{
					["message"] = "BOAT1",
				},
			},
		},
		["RECON"] = {
			["sequence"] = {
				{
					["message"] = "RECON1",
				},
			},
		},
		["AIRFIELD"] = {
			["sequence"] = {
				{
					["message"] = "AIRFIELD1",
				},
				{
					["message"] = "AIRFIELD2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAirfieldDead",
				},
			},
		},
		["SHIPYARD"] = {
			["sequence"] = {
				{
					["message"] = "SHIPYARD1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaShipyardDead",
				},
			},
		},
		["RAIDERS"] = {
			["sequence"] = {
				{
					["message"] = "RAIDERS1",
				},
				{
					["message"] = "RAIDERS2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddLSTObj",
				},
			},
		},
		["MOGAMI"] = {
			["sequence"] = {
				{
					["message"] = "MOGAMI1",
				},
				{
					["message"] = "MOGAMI2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddKumanoObj",
				},
			},
		},
		["BATTERY"] = {
			["sequence"] = {
				{
					["message"] = "BATTERY1",
				},
				{
					["message"] = "BATTERY2",
				},
			},
		},
		["ASHORE"] = {
			["sequence"] = {
				{
					["message"] = "ASHORE1",
				},
				{
					["message"] = "ASHORE2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
		["FAILED"] = {
			["sequence"] = {
				{
					["message"] = "FAILED1",
				},
				{
					["message"] = "FAILED2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionFailed",
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
	
	Mission.Yorktown = FindEntity("Yorktown")
	Mission.B17 = FindEntity("B-17")
	
	Mission.HenryGang = {}
		table.insert(Mission.HenryGang, Mission.Yorktown)
		table.insert(Mission.HenryGang, FindEntity("Dewey"))
		table.insert(Mission.HenryGang, FindEntity("Perkins"))
	
	for idx,unit in pairs(Mission.HenryGang) do
		
		JoinFormation(unit, Mission.HenryGang[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.AAAAAGGGGHHHHH = {}
		table.insert(Mission.AAAAAGGGGHHHHH, Mission.Yorktown)
	
	---- IJN ----
	
	Mission.Airfield = FindEntity("AirField")
	Mission.Shipyard = FindEntity("Shipyard")
	Mission.Fortress = FindEntity("Fortress")
	
	if Mission.Difficulty == 0 then
		
		OverrideHP(Mission.Airfield, Mission.Airfield.Class.HP / 1.7)
		OverrideHP(Mission.Shipyard, Mission.Shipyard.Class.HP / 2)
		
	elseif Mission.Difficulty == 1 then
	
		OverrideHP(Mission.Airfield, Mission.Airfield.Class.HP / 1.5)
		OverrideHP(Mission.Shipyard, Mission.Shipyard.Class.HP / 1.75)
		
	elseif Mission.Difficulty == 2 then
	
		OverrideHP(Mission.Airfield, Mission.Airfield.Class.HP / 1.25)
		OverrideHP(Mission.Shipyard, Mission.Shipyard.Class.HP / 1.5)
		
	end
	
	Mission.Tama = FindEntity("Tama")
	
	Mission.TamaGang = {}
		table.insert(Mission.TamaGang, Mission.Tama)
		table.insert(Mission.TamaGang, FindEntity("Yuzuki"))
		table.insert(Mission.TamaGang, FindEntity("Kikuzuki"))
		
	for idx,unit in pairs(Mission.TamaGang) do
		
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
		
		NavigatorAttackMove(unit, Mission.Yorktown)
		
	end
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Koei Maru"))
		table.insert(Mission.CargoGang, FindEntity("Kamikara Maru"))
		table.insert(Mission.CargoGang, FindEntity("Azumasan Maru"))
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 then
			
			RepairEnable(unit, false)
		
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			
			RepairEnable(unit, true)
		
		end
		
	end
	
	NavigatorSetTorpedoEvasion(FindEntity("Kanikawa Maru"), false)
	NavigatorSetAvoidLandCollision(FindEntity("Kanikawa Maru"), false)
	AAEnable(FindEntity("Kanikawa Maru"), false)
	
	if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
		
		SetAirBaseSlotCount(Mission.Airfield, 2)
		
	elseif Mission.Difficulty == 2 then
		
		SetAirBaseSlotCount(Mission.Airfield, 3)
		
	end
	
	---- VAR ----
	
	Mission.KumanoPath = FindEntity("KumanoPath")
	Mission.LandingPoints = FillPathPoints(FindEntity("path_landing"))
	Mission.B17RetreatPoint = {["x"] = -9500, ["y"] = 1423, ["z"] = 0}
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.EmilyDelay = 200
	Mission.PTDelay = 90
	Mission.LandedNum = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapAI = 3
	
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	--EnableInput(false)
	
	MissionNarrative("May 3rd, 1942 - Near Tulagi Island")
	
	luaStartDialog("INTRO")
	
	PilotMoveToRange(Mission.B17, Mission.Yorktown, 300)
	SquadronSetTravelAlt(Mission.B17, GetPosition(Mission.B17).y)
	
	local planeTypes = 
	{
	158,
	158,				
	}
	
	local slotIndex = LaunchSquadron(Mission.Airfield,luaPickRnd(planeTypes),3)
	Mission.FirstBomber = thisTable[tostring(GetProperty(Mission.Airfield, "slots")[slotIndex].squadron)]
	
	PilotSetTarget(Mission.FirstBomber, Mission.Yorktown)
	
	SetForcedReconLevel(Mission.Airfield, 2, PARTY_ALLIED)
	SetForcedReconLevel(Mission.Shipyard, 2, PARTY_ALLIED)
	
	luaAddBomberListener()
	luaAddTamaListener()
	luaAddFortressListener()
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--Mission.Debug = true
	
	if Mission.Debug then
		
		SetInvincible(Mission.Yorktown, 0.4)
		luaDelay(luaMoveToPh2, 20)
	
	end
	
	--SetSimplifiedReconMultiplier(10.85)
	
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
		
		Mission.Started = true
	
	end
	
	if Mission.MissionPhase < 99 then
		
		if luaObj_IsActive("primary",3) then
		
			if Mission.Yorktown.Dead then
			
				luaMissionFailed(Mission.Yorktown)
			
			end
		
		end
		
		if not Mission.B17.Dead and not Mission.B17sRetreating then
		
			local ammo = GetProperty(Mission.B17, "ammoType")
			
			if ammo == 0 then
				
				SetRoleAvailable(Mission.B17, EROLF_ALL, PLAYER_AI)
				
				PilotMoveTo(Mission.B17, Mission.B17RetreatPoint)
				
				luaStartDialog("HOME")
				
				Mission.B17sRetreating = true
				
			end
		
		end
		
		if luaObj_IsActive("secondary",1) then
		
			if Mission.Fortress.Dead then
			
				luaObj_Completed("secondary", 1)
			
			end
		
		end
		
		if luaObj_IsActive("hidden",1) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CargoGang)) == 0 then
			
				luaObj_Completed("hidden", 1, true)
			
			end
		
		end
		
	end
	
	if Mission.MissionPhase == 1 then
	
		if luaObj_IsActive("primary",1) then
		
			if Mission.Airfield.Dead then
			
				luaObj_Completed("primary", 1)
				
				luaStartDialog("AIRFIELD")
			
			else
			
				local Zero = {
					[1] = 150,
				}
				local Val = {
					[1] = 158,
				}
				
				luaAirfieldManager(Mission.Airfield, Zero, Val, Mission.AAAAAGGGGHHHHH)
			
			end
		
		end
		
		if luaObj_IsActive("primary",2) then
		
			if Mission.Shipyard.Dead then
			
				luaObj_Completed("primary", 2)
				
				luaStartDialog("SHIPYARD")
			
			elseif not Mission.Shipyard.Dead and Mission.BomberSighted then
			
				if not Mission.ReconOut then
			
					local emily = GenerateObject("Recon")
					
					SetSkillLevel(emily, Mission.SkillLevel)
					
					PilotSetTarget(emily, Mission.Yorktown)
					
					Mission.ReconOut = true
					
					luaDelay(luaAllowEmilySpawn, Mission.EmilyDelay)
					
					if not Mission.EmilyListenerAdded then
					
						luaAddEmilyListener(emily)
						
						Mission.EmilyListenerAdded = true
					
					end
					
				end
				
				if not Mission.PTOut then
					
					local pt = GenerateObject("PT")
					
					SetSkillLevel(pt, Mission.SkillLevel)
					TorpedoEnable(pt, true)
					
					NavigatorAttackMove(pt, Mission.Yorktown)
					
					Mission.PTOut = true
					
					luaDelay(luaAllowPTSpawn, Mission.PTDelay)
					
					if not Mission.PTListenerAdded then
					
						luaAddPTListener(pt)
						
						Mission.PTListenerAdded = true
					
					end
					
				end
			
			end
		
		end
		
		if Mission.AirfieldDead and Mission.ShipyardDead then
			
			HideScoreDisplay(1,0)
			
			Blackout(true, "luaMoveToPh2", 1)
		
		else
			
			Mission.AirfieldHP = math.floor(GetHpPercentage(Mission.Airfield) * 100.0000)
			Mission.ShipyardHP = math.floor(GetHpPercentage(Mission.Shipyard) * 100.0000)
			
			local line1 = "Destroy the airfield and shipyard hangars!"
			local line2 = "Airfield status: #Mission.AirfieldHP#% | Shipyard status: #Mission.ShipyardHP#%"
			luaDisplayScore(1, line1, line2)
		
		end
		
	elseif Mission.MissionPhase == 2 then
		
		if luaObj_IsActive("primary",4) then
			
			Mission.LSTNum = table.getn(luaRemoveDeadsFromTable(Mission.LSTGang))
			
			local line1 = "Make sure at least three landing ships come ashore!"
			local line2 = "Landing ships remaining: #Mission.LSTNum#"
			luaDisplayScore(2, line1, line2)
			
			if table.getn(luaRemoveDeadsFromTable(Mission.LSTGang)) < 3 then
				
				HideScoreDisplay(2,0)
				
				if table.getn(luaRemoveDeadsFromTable(Mission.LSTGang)) > 0 then
				
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTGang)) do
						
						if unit and not unit.Dead then
						
							local point = GetClosestBorderZone(GetPosition(unit))
							NavigatorMoveToPos(unit, point)
						
						end
						
					end
				
				end
				
				luaStartDialog("FAILED")
				
			else
				
				if Mission.LandedNum >= 3 then
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTGang)) do
						
						if unit and not unit.Dead then
						
							SetInvincible(unit, 0.01)
						
						end
						
					end
					
					SetInvincible(Mission.Yorktown, 0.01)
					
					luaStartDialog("ASHORE")
					
					Mission.EndMission = true
					
				else
					
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.LSTGang)) do
						
						if unit and not unit.Dead then
						
							if luaGetDistance(unit, unit.landingTarget) < 200 and not unit.landed then
								
								NavigatorStop(unit)
								
								Mission.LandedNum = Mission.LandedNum + 1
								
								unit.landed = true
								
							end
						
						end
						
					end
				
				end
				
			end
		
		end
		
		if luaObj_IsActive("secondary",2) then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.BruhGang)) == 0 then
			
				luaObj_Completed("secondary", 2, true)
			
			end
		
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 2 ----

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	
	Mission.Invasion1 = GenerateObject("LST 1")
	Mission.Invasion2 = GenerateObject("LST 2")
	Mission.Invasion3 = GenerateObject("LST 3")
	Mission.Invasion4 = GenerateObject("LST 4")
	Mission.Invasion5 = GenerateObject("LST 5")
	Mission.Invasion6 = GenerateObject("LST 6")
	
	Mission.LSTGang = {}
		table.insert(Mission.LSTGang, Mission.Invasion1)
		table.insert(Mission.LSTGang, Mission.Invasion2)
		table.insert(Mission.LSTGang, Mission.Invasion3)
		table.insert(Mission.LSTGang, Mission.Invasion4)
		table.insert(Mission.LSTGang, Mission.Invasion5)
		table.insert(Mission.LSTGang, Mission.Invasion6)
		
	for idx,unit in pairs(Mission.LSTGang) do
		
		if Mission.Debug then
			
			SetInvincible(unit, 0.4)
		
		end
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
			NavigatorSetTorpedoEvasion(unit, true)
			
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
			NavigatorSetTorpedoEvasion(unit, false)
			
		end
		
		unit.landingTarget = Mission.LandingPoints[idx]
		NavigatorMoveToRange(unit, unit.landingTarget)
		
	end
	
	Mission.Kumano = GenerateObject("Kumano")
	Mission.KumanoEsc = GenerateObject("Mutsuki")
	
	Mission.BruhGang = {}
		table.insert(Mission.BruhGang, Mission.Kumano)
		table.insert(Mission.BruhGang, Mission.KumanoEsc)
		
	for idx,unit in pairs(Mission.BruhGang) do
		
		--JoinFormation(unit, Mission.BruhGang[1])
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
		
		NavigatorMoveOnPath(unit, Mission.KumanoPath, PATH_FM_CIRCLE, PATH_SM_BEGIN)
		
	end
	
	Loading_Finish()
	
	Blackout(false, "", 1)
	
	luaStartDialog("RAIDERS")
	
	luaAddKumanoListener()
	
	if not Mission.Fortress.Dead then
	
		luaAddLSTHitListener()
		
	end
	
end

function luaAddLSTObj()

	luaObj_Add("primary", 4, Mission.LSTGang)

end

function luaAddKumanoObj()

	luaObj_Add("secondary", 2, Mission.BruhGang)

end

---- PHASE 1 ----

function luaAirfieldDead()

	Mission.AirfieldDead = true

end

function luaShipyardDead()

	Mission.ShipyardDead = true

end

function luaAllowEmilySpawn()

	Mission.ReconOut = false

end

function luaAllowPTSpawn()

	Mission.PTOut = false

end

function luaIntroMovie1()
	
	local cam =
	{
		["postype"] = "camera",
		["position"] =
		{
			["parent"] = Mission.B17,
			["pos"] = {19.5, 3.5, 25}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = false,
		["transformtype"] = "keepy",
		["zoom"] = 1.2,
	}

	MovCamNew_AddPosition(cam)

	local target =
	{
		["postype"] = "target",
		["position"] =
		{
			["parent"] = GetSquadronPlane(Mission.B17, 1),
			["pos"] = {0, 0, 0}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = false,
		["transformtype"] = "keepy",
		["zoom"] = 1.2,
	}

	MovCamNew_AddPosition(target)

end

function luaIntroMovie2()

	local cam =
	{
		["postype"] = "camera",
		["position"] =
		{
			["parent"] = Mission.B17,
			["pos"] = {10, 22, -42}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = false,
		["transformtype"] = "keepall"
	}

	MovCamNew_AddPosition(cam)

	local target =
	{
		["postype"] = "target",
		["position"] =
		{
			["parent"] = Mission.Yorktown,
			["pos"] = {-100, 0, 0}
		},
		["starttime"] = 0,
		["blendtime"] = 0,
		["wanderer"] = false,
		["transformtype"] = "keepall"
	}

	MovCamNew_AddPosition(target)

end

function luaIntroMovie3()

	local cam =
			{
				["postype"] = "camera",
				["position"] =
				{
					["parent"] = Mission.Yorktown,
					["pos"] = {0, 17, 60}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["wanderer"] = false,
				["transformtype"] = "keepall"
			}
	MovCamNew_AddPosition(cam)
		
	local target =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = Mission.B17,
					["pos"] = {150, 0, 0}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["wanderer"] = true,
				["transformtype"] = "keepall"
			}
	MovCamNew_AddPosition(target)

end

function luaIntroMovieEnd()
	
	Blackout(true, "luaIn", 1)

end

function luaIn()
	
	EnableMessages(true)
	--EnableInput(true)
	
	SetSelectedUnit(Mission.Yorktown)
	
	Blackout(false, "luaAddFirstObjs", 1)
	
end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.Airfield)
	luaObj_Add("primary", 2, Mission.Shipyard)
	luaObj_Add("primary", 3, Mission.Yorktown)
	
	DisplayUnitHP((Mission.AAAAAGGGGHHHHH), "Yorktown must survive the encounter!")
	
	luaObj_Add("hidden", 1)
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)

end

---- LISTENERS ----

function luaAddLSTHitListener()

	AddListener("hit", "LSTHitListener", {
		["callback"] = "luaLSTHit",
		["target"] = Mission.LSTGang,
		["targetDevice"] = {},
		["attacker"] = {Mission.Fortress},
		["attackType"] = {},
		["attackerPlayerIndex"] = {},
		["damageCaused"] = {},
		["fireCaused"] = {},
		["leakCaused"] = {},
	})

end

function luaAddKumanoListener()

	AddListener("recon", "KumanoListener", {
		["callback"] = "luaKumanoSighted",
		["entity"] = Mission.BruhGang,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddFortressListener()

	AddListener("recon", "FortressListener", {
		["callback"] = "luaFortressSighted",
		["entity"] = {Mission.Fortress},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddTamaListener()

	AddListener("recon", "TamaListener", {
		["callback"] = "luaTamaSighted",
		["entity"] = {Mission.Tama},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddBomberListener()

	AddListener("recon", "BomberListener", {
		["callback"] = "luaBomberSighted",
		["entity"] = {Mission.FirstBomber},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddEmilyListener(unit)

	AddListener("recon", "EmilyListener", {
		["callback"] = "luaEmilySighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

function luaAddPTListener(unit)

	AddListener("recon", "PTListener", {
		["callback"] = "luaPTSighted",
		["entity"] = {unit},
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
	})

end

---- LISTENER CALLBACKS ----

function luaLSTHit()

	RemoveListener("hit", "LSTHitListener")
	
	luaStartDialog("BATTERY")

end

function luaKumanoSighted()

	RemoveListener("recon", "KumanoListener")
	
	luaStartDialog("MOGAMI")

end

function luaFortressSighted()

	RemoveListener("recon", "FortressListener")
	
	luaObj_Add("secondary", 1, Mission.Fortress)

end

function luaTamaSighted()

	RemoveListener("recon", "TamaListener")
	
	luaStartDialog("KUMA")
	
end

function luaBomberSighted()

	RemoveListener("recon", "BomberListener")
	
	luaStartDialog("PLANES")
	
	Mission.BomberSighted = true
	
end

function luaEmilySighted()

	RemoveListener("recon", "EmilyListener")
	
	luaStartDialog("BOAT")

end

function luaPTSighted()

	RemoveListener("recon", "PTListener")
	
	luaStartDialog("RECON")

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	Mission.EndMission = true
	
	HideUnitHP()
	
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
	
	if luaObj_IsActive("secondary",2) then
		
		luaObj_Failed("secondary",2)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Completed("hidden",1)
	
	end
	
	luaMissionCompletedNew(luaPickRnd(luaRemoveDeadsFromTable(Mission.LSTGang)), "Tulagi has been captured - Mission Complete", "campaigns/BSM/m0803.bik")
	
end

function luaMissionFailed(unit)
	
	Mission.EndMission = true
	
	if unit == nil then
	
		unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.LSTGang))
	
	end
	
	HideUnitHP()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Failed("primary",4)
	
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