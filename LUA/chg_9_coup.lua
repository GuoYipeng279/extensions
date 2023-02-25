function luaStageInit()
	CreateScript("luaInitCDG")
end

function luaInitCDG(this)
	Mission = this
	
	SETLOG(this, true)	
	
	this.Name = "CDG"
	this.CustomLog = true
-- RELEASE_LOGOFF  	luaLog("----------------------")
-- RELEASE_LOGOFF  	luaLog("CDG STARTED")
-- RELEASE_LOGOFF  	luaLog("----------------------")
	
	--this.HelperLog = false
	--this.DamageLog = false
	
	this.MissionPhase = 0

	--Music_Control_SetLevel(MUSIC_TENSION)
	
	-- lokalizacios feltoltesek
	AddLockitPathToSelection("missionglobals")
	AddLockitPathToSelection("subc3")
	LoadSelectedPaths()
	
	this.FireStanceSet = false
	Mission.AlertDistance = 1500
	Mission.OnWay = false
	
	this.Party = SetParty(this, PARTY_JAPANESE)
	
	--PlayerUnits
	
	this.PlayerUnit1 = FindEntity("I-26")
	this.PlayerUnit2 = FindEntity("I-25")
	Mission.P1Dead = false 
	Mission.P2Dead = false
	
	--EnemyUnits
	
	this.PTs = {}
		table.insert(this.PTs, FindEntity("PT-119"))
		table.insert(this.PTs, FindEntity("PT-120"))
		table.insert(this.PTs, FindEntity("PT-121"))
		
	this.Avenger = FindEntity("Avenger")	
	this.Gilmer = FindEntity("Gilmer")
	this.Denver = FindEntity("Denver")
	this.Clark = FindEntity("DeHaven") -- modositva Clark-ról, a lokalizacio miatt
	
	this.Enterprise = FindEntity("Enterprise")
	
	this.Catalinas = {}
		table.insert(this.Catalinas, FindEntity("Catalina"))
		table.insert(this.Catalinas, FindEntity("Catalina"))
	
	this.GilmerDead = false
	this.DenverDead = false	
	this.ClarkDead = false
	this.EnemyShipsDead = false

	this.FleePath = FindEntity("flee_path")
	this.ExitPoint = {["x"] = -1915,	["y"] = 0,	["z"] = 9000}
	this.NextPosition = {["x"] = 0,	["y"] = 0,	["z"] = 0}
	this.Multiplyer = nil

	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
	
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "CV",		--added	checked
				["Text"] = "Destroy the USS Enterprise!",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {}, -- TODO: meeting point coordinates here OK
				["ScoreCompleted"] = 500*OBJ_PRIMARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,,
				["ScoreFailed"] = 0
			},
		},
				
		["secondary"] = {
			[1] = {
				["ID"] = "CL",		--added	checked
				["Text"] = "Destroy the enemy cruiser!",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200*OBJ_SECONDARY_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,,
				["ScoreFailed"] = 0
			},
		},
		
		["hidden"] = {	
			[1] = {
				["ID"] = "DD",		--added	checked
				["Text"] = "Sink the USS DeHaven!",
				["TextCompleted"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha teljesult az objektiva
				["TextFailed"] = nil,	-- szoveg, amit kiirunk a jatekosnak, ha meghiusul az objektiva
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 100*OBJ_HIDDEN_MULTIPLIER*luaGetDifficultyScoreMultiplier(),	-- teljesitesert jaro pontszam,,
				["ScoreFailed"] = 0
			},  
		},
	}

		
	-- Scoring = nil	-- itt toroljuk a Scoring tablat
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	SetCatapultStock(FindEntity("I-26"), 0)
	SetCatapultStock(FindEntity("I-25"), 0)
	
	Blackout(true, "", true)

	--think
	SetThink(this, "luaCDG_think")	
end

function luaCDG_think(this, msg)
	
	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	--SetWait(this, 1)

-- RELEASE_LOGOFF  	luaLog("----CDG is thinking----")

	luaCheckMusic()

	if not this.FirstThink then
		this.FirstThink = true
		Blackout(false, "", 2.5)
-- RELEASE_LOGOFF  		luaLog("FirstThink")
		SetForcedReconLevel(this.Enterprise, 4, Mission.Party)
		luaObj_Add("primary",1, {this.Enterprise,this.PlayerUnit1,this.PlayerUnit2})
		DisplayUnitHP({this.Enterprise}, "Destroy the USS Enterprise!")		
		luaObj_Add("secondary",1, {this.Denver})
		luaObj_Add("hidden",1, {this.Clark})
--[[		
		Mission.difficulty = GetDifficulty()	
		
		if Mission.difficulty == DIFF_ROOKIE then
			SetCrewLevel(this.Gilmer , CREW_ROOKIE)
			SetCrewLevel(this.Denver, CREW_ROOKIE)
			SetCrewLevel(this.Clark , CREW_ROOKIE)			
			SetCrewLevel(this.Enterprise , CREW_ROOKIE)			
			SetCrewLevel(this.PTs[1], CREW_ROOKIE)
			SetCrewLevel(this.PTs[2], CREW_ROOKIE)
			SetCrewLevel(this.PTs[3], CREW_ROOKIE)	
			TorpedoEnable(this.PTs[1], true)
			TorpedoEnable(this.PTs[2], true)
			TorpedoEnable(this.PTs[3], true)
			ShipSetTorpedoStock(this.PlayerUnit1,30)
			ShipSetTorpedoStock(this.PlayerUnit2,30)
			
		elseif Mission.difficulty == DIFF_REGULAR then
			SetCrewLevel(this.Gilmer , CREW_REGULAR)		
			SetCrewLevel(this.Denver, CREW_REGULAR)	
			SetCrewLevel(this.Clark , CREW_REGULAR)
			SetCrewLevel(this.Enterprise , CREW_REGULAR)		
			SetCrewLevel(this.PTs[1], CREW_REGULAR)
			SetCrewLevel(this.PTs[2], CREW_REGULAR)
			SetCrewLevel(this.PTs[3], CREW_REGULAR)
			TorpedoEnable(this.PTs[1], true)
			TorpedoEnable(this.PTs[2], true)
			TorpedoEnable(this.PTs[3], true)		
			ShipSetTorpedoStock(this.PlayerUnit1,24)
			ShipSetTorpedoStock(this.PlayerUnit2,24)
			
		elseif Mission.difficulty == DIFF_VETERAN then
			SetCrewLevel(this.Gilmer , CREW_VETERAN)
			SetCrewLevel(this.Denver, CREW_VETERAN)
			SetCrewLevel(this.Clark , CREW_VETERAN)
			SetCrewLevel(this.PTs[1], CREW_VETERAN)
			SetCrewLevel(this.PTs[2], CREW_VETERAN)
			SetCrewLevel(this.PTs[3], CREW_VETERAN)	
			TorpedoEnable(this.PTs[1], true)
			TorpedoEnable(this.PTs[2], true)
			TorpedoEnable(this.PTs[3], true)	
			ShipSetTorpedoStock(this.PlayerUnit1,18)
			ShipSetTorpedoStock(this.PlayerUnit2,18)
			SetCrewLevel(this.Enterprise , CREW_VETERAN)
		end
	end
]]
		SetCrewLevel(this.Gilmer, CREW_ROOKIE)
		SetCrewLevel(this.Denver, CREW_ROOKIE)
		SetCrewLevel(this.Clark, CREW_ROOKIE)
		SetCrewLevel(this.Enterprise, CREW_VETERAN)
		SetCrewLevel(this.PTs[1], CREW_ROOKIE)
		SetCrewLevel(this.PTs[2], CREW_ROOKIE)
		SetCrewLevel(this.PTs[3], CREW_ROOKIE)
		TorpedoEnable(this.PTs[1], true)
		TorpedoEnable(this.PTs[2], true)
		TorpedoEnable(this.PTs[3], true)
		ShipSetTorpedoStock(this.PlayerUnit1, 24)
		ShipSetTorpedoStock(this.PlayerUnit2, 24)
		
		
	--mozi cuccok
		
		EnableInput(false)


		luaCDGIntro()

	end


	if not this.MovieSkip and not this.MovieEnd and GameTime()>8 then
		
		this.MovieEnd = true
		
		luaCDGSkipMovie()
		
	end

	luaCDGCheckGameOver(this)
	luaCheckUnits(this)
	luaCheckHiddenObjCompleted(this)
	luaCheckSecondaryObjCompleted(this)
	luaCheckEscortEnterprise(this)
	luaCheckCarrierExitzoneDistance(this)

	if not this.GameOver then
		if this.MissionPhase == 0 then
			NavigatorMoveOnPath(this.Denver, FindEntity("cl_path"), PATH_FM_CIRCLE, PATH_SM_JOIN)	
			NavigatorMoveOnPath(this.Gilmer, FindEntity("dd_path1"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			--NavigatorMoveOnPath(this.Clark, FindEntity("dd_path2"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			NavigatorMoveOnPath(this.PTs[1], FindEntity("path 1"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			--NavigatorMoveOnPath(this.PTs[2], FindEntity("path 2"),PATH_FM_CIRCLE, PATH_SM_JOIN)
			NavigatorMoveOnPath(this.PTs[3], FindEntity("path 3"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			PilotMoveOnPath(this.Catalinas[1], FindEntity("cat_path"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			PilotMoveOnPath(this.Avenger, FindEntity("av_path"), PATH_FM_CIRCLE, PATH_SM_JOIN)
			JoinFormation(this.Clark, this.Enterprise)
			NavigatorEnable(this.Clark, false)
			NavigatorEnable(this.Enterprise, true)
			NavigatorSetTorpedoEvasion(this.Enterprise, true)

			Mission.MissionPhase = 1

		elseif this.MissionPhase == 1 then
			luaCheckSubDistance(this)
		end
	end
end

function luaCheckSubDistance(this)
-- RELEASE_LOGOFF  	luaLog("--Checking subdistance--")
	if not Mission.Enterprise.Dead and not Mission.OnWay then
		if GetShipSpeed(Mission.Enterprise) > 1 then
-- RELEASE_LOGOFF  			luaLog("Torpedoes spotted, carrier has to flee!")
			NavigatorMoveOnPath(Mission.Enterprise, this.FleePath, PATH_FM_SIMPLE, PATH_SM_JOIN)
			Mission.OnWay = true
			Mission.EscortNeeded = true
		end
	end

	if not Mission.P1Dead and not Mission.Enterprise.Dead and not Mission.OnWay then
		if luaGetDistance(Mission.PlayerUnit1, Mission.Enterprise) < Mission.AlertDistance then
-- RELEASE_LOGOFF  			luaLog("P1 spotted, carrier has to flee!")
			NavigatorMoveOnPath(Mission.Enterprise, this.FleePath, PATH_FM_SIMPLE, PATH_SM_JOIN)
			Mission.OnWay = true
			Mission.EscortNeeded = true
		end
	end
	
	if not Mission.P2Dead and not Mission.Enterprise.Dead and not Mission.OnWay then
		if luaGetDistance(Mission.PlayerUnit2, Mission.Enterprise) < Mission.AlertDistance then
-- RELEASE_LOGOFF  			luaLog("P2 spotted, carrier has to flee!")
			NavigatorMoveOnPath(Mission.Enterprise, this.FleePath, PATH_FM_SIMPLE, PATH_SM_JOIN)
			Mission.OnWay = true
			Mission.EscortNeeded = true
		end
	end

	if this.EnemyShipsDead and not Mission.Enterprise.Dead and not Mission.OnWay then
-- RELEASE_LOGOFF  		luaLog("Enemy ships dead, carrier has to flee!")
		NavigatorMoveOnPath(Mission.Enterprise, this.FleePath, PATH_FM_SIMPLE, PATH_SM_JOIN)
		Mission.OnWay = true
		Mission.EscortNeeded = true
	end
end

function luaCheckEscortEnterprise(this)
-- RELEASE_LOGOFF  	luaLog("--Checking escort--")
	if not Mission.ClarkIsActive then
		if not this.PlayerUnit1.Dead and not this.Clark.Dead then
			if luaGetDistance(this.PlayerUnit1, this.Clark) < 2400 then
-- RELEASE_LOGOFF  				luaLog("Activating DeHaven")
				Mission.ClarkIsActive = true
				NavigatorEnable(this.Clark, true)
			end
		end

		if not this.PlayerUnit2.Dead and not this.Clark.Dead then
			if luaGetDistance(this.PlayerUnit2, this.Clark) < 2400 then
-- RELEASE_LOGOFF  				luaLog("Activating DeHaven")
				Mission.ClarkIsActive = true
				NavigatorEnable(this.Clark, true)
			end
		end
	end

	if Mission.EscortNeeded then
		if not Mission.PlanesEscorting and not Mission.Enterprise.Dead and Mission.Enterprise ~= nil then
-- RELEASE_LOGOFF  			luaLog("Ordering planes to escort carrier...")
			Mission.PlanesEscorting = true
			local planes = luaGetOwnUnits("plane", PARTY_ALLIED)

			if planes ~= nil then
				for index, unit in pairs(planes) do
					if not unit.Dead then
-- RELEASE_LOGOFF  						luaLog("Plane escorting carrier:")
-- RELEASE_LOGOFF  						luaLog(unit.Name)
-- RELEASE_LOGOFF  						luaLog("-----------------------")
						PilotMoveToRange(unit, Mission.Enterprise, 6000)
					end
				end
			end
		end

		if not Mission.Enterprise.Dead and Mission.Enterprise ~= nil then
-- RELEASE_LOGOFF  			luaLog("Checking carrierposition:")
			local carrierposition	= GetPosition(Mission.Enterprise)
-- RELEASE_LOGOFF  			luaLog(carrierposition)
-- RELEASE_LOGOFF  			luaLog("-------------------------")
			local ships = luaGetOwnUnits("ship", PARTY_ALLIED)
			if not this.Clark.Dead then
				NavigatorEnable(this.Clark, true)
			end

			if ships ~= nil then
				for index, unit in pairs(ships) do
					if not unit.Dead and unit ~= Mission.Enterprise and unit ~= Mission.Gilmer and unit ~= Mission.Denver and unit ~= Mission.Clark then
						if GetPrimaryTarget(unit) ~= Mission.PlayerUnit1 and GetPrimaryTarget(unit) ~= Mission.PlayerUnit2 then
-- RELEASE_LOGOFF  							luaLog("Ship escorting carrier:")
-- RELEASE_LOGOFF  							luaLog(unit.Name)
-- RELEASE_LOGOFF  							luaLog("-----------------------")

							for i, v in pairs(carrierposition) do
								if Mission.Multiplyerx == nil then
									Mission.Multiplyerx = 1
								end

								if Mission.Multiplyerz == nil then
									Mission.Multiplyerz = 1
								end

								if i == "x" then
									Mission.NextPosition[i] = carrierposition[i] + -500 * Mission.Multiplyerx
								elseif i == "z" then
									Mission.NextPosition[i] = carrierposition[i] + -800 * Mission.Multiplyerz
								end
							end
							Mission.Multiplyerx = Mission.Multiplyerx * 1.5
							Mission.Multiplyerz = Mission.Multiplyerz * 1.5
-- RELEASE_LOGOFF  							luaLog("-NextPosition:-")
-- RELEASE_LOGOFF  							luaLog(Mission.NextPosition)
-- RELEASE_LOGOFF  							luaLog("---------------")

							NavigatorMoveToPos(unit, Mission.NextPosition)
							UnitSetFireStance(unit, STANCE_FREE_ATTACK)
							
							if luaGetDistance(unit, Mission.NextPosition) < 150 then
								SetShipSpeed(unit, GetShipSpeed(Mission.Enterprise))
-- RELEASE_LOGOFF  								luaLog("-Speed:-")
-- RELEASE_LOGOFF  								luaLog(GetShipSpeed(Mission.Enterprise))
-- RELEASE_LOGOFF  								luaLog("--------")

							else
								SetShipSpeed(unit, GetShipMaxSpeed(unit))
-- RELEASE_LOGOFF  								luaLog("-Speed:-")
-- RELEASE_LOGOFF  								luaLog(GetShipMaxSpeed(unit))
-- RELEASE_LOGOFF  								luaLog("--------")
							end

						else
-- RELEASE_LOGOFF  							luaLog("Ship attacking sub:")
-- RELEASE_LOGOFF  							luaLog(unit.Name)
-- RELEASE_LOGOFF  							luaLog("-----------------------")
							SetShipSpeed(unit, GetShipMaxSpeed(unit))
-- RELEASE_LOGOFF  							luaLog("-Speed:-")
-- RELEASE_LOGOFF  							luaLog(GetShipMaxSpeed(unit))
-- RELEASE_LOGOFF  							luaLog("--------")
						end

					elseif not unit.Dead and unit ~= Mission.Enterprise and not Mission.InFormation then
						if unit == Mission.Gilmer or unit == Mission.Denver or unit == Mission.Clark then
							if not IsInFormation(unit) then
-- RELEASE_LOGOFF  								luaLog("Ship joining formation:")
-- RELEASE_LOGOFF  								luaLog(unit.Name)
-- RELEASE_LOGOFF  								luaLog("-----------------------")
								JoinFormation(unit, Mission.Enterprise)
								UnitSetFireStance(unit, STANCE_FREE_ATTACK)
							end
						end
					end
				end

				Mission.Multiplyerx = nil
				Mission.Multiplyerz = nil
				SetFormationShape(Mission.Enterprise, 4)
				Mission.InFormation = true
			end
		end
	end
end

function luaCheckCarrierExitzoneDistance(this)
-- RELEASE_LOGOFF  	luaLog("--Checking exitzone distance--")
	if Mission.OnWay and not Mission.Enterprise.Dead and Mission.Enterprise ~= nil and not Mission.EnterpriseExited then
		Mission.Distance = luaGetDistance(Mission.Enterprise, Mission.ExitPoint)

		if Mission.Distance < 500 then
			Mission.EnterpriseExited = true
		end
	end
end

function luaCDGCheckGameOver(this)
-- RELEASE_LOGOFF  	luaLog("--Checking gameover--")
	if not this.PlayerUnit1.Dead then
		--UpdateUnitTable(this.PlayerUnit1)
	end

	if not this.PlayerUnit2.Dead then
		--UpdateUnitTable(this.PlayerUnit2)
	end

	if this.PlayerUnit1.Dead and this.PlayerUnit2.Dead and not this.GameOver then
		this.GameOver = true
		luaCDGMissionFail(this)
	end
		
	if not Mission.P1Dead and not Mission.P2Dead then
		if this.PlayerUnit1.TorpedoStock == 0 and this.PlayerUnit2.TorpedoStock == 0 and not this.Low_Ammo then
			this.Low_Ammo = true
			if not this.Enterprise.Dead then
				luaDelay(luaCDGMissionFail_LowAmmo, 80)
			end
		end
	end
		
	if this.Enterprise.Dead and not this.GameOver and not Mission.EnterpriseExited then
		this.GameOver = true
		luaCDGMissionSucces(this)
	elseif Mission.EnterpriseExited and not this.GameOver then
		this.GameOver = true
		luaCDGMissionFail_Exited()
	end
end

function luaCheckHiddenObjCompleted(this)
-- RELEASE_LOGOFF  	luaLog("--Checking hidden objective--")
	if not this.ClarkDead then
		if this.Clark.Dead then
			luaObj_Completed("hidden",1)
			this.ClarkDead = true
		end
	end
end

function luaCheckSecondaryObjCompleted(this)
-- RELEASE_LOGOFF  	luaLog("--Checking secondary objective--")
	if not this.DenverDead then
		if this.Denver.Dead then
			luaObj_Completed("secondary",1)
			this.DenverDead = true
		end
	end
end

function luaCDGMissionFail()
-- RELEASE_LOGOFF  	luaLog("<---- Mission failed ---->")
	luaObj_Failed("primary",1)
	--Your units are destroyed
	luaMissionFailedNew(Mission.Enterprise, "Your units have been destroyed!")
end

function luaCDGMissionFail_LowAmmo()
-- RELEASE_LOGOFF  	luaLog("<---- Mission failed ---->")
	luaObj_Failed("primary", 1)
	--You wasted your torpedos
	luaMissionFailedNew(Mission.Enterprise, "You've wasted your torpedoes!")
end

function luaCDGMissionSucces()
-- RELEASE_LOGOFF  	luaLog("<---- Mission was a success ---->")
	luaObj_Completed("primary", 1)
	HideUnitHP()
	--Target destroyed
	luaMissionCompletedNew(Mission.Enterprise, "Target destroyed!")
end

function luaCDGMissionFail_Exited()
-- RELEASE_LOGOFF  	luaLog("<---- Mission failed ---->")
	luaObj_Failed("primary", 1)
	--Carrier exited
	luaMissionFailedNew(Mission.Enterprise, "The Enterprise has escaped!")
end

function luaCheckUnits(this)
-- RELEASE_LOGOFF  	luaLog("--Checking units--")
	if this.PlayerUnit1.Dead then
		this.P1Dead = true
	end
	
	if this.PlayerUnit2.Dead then
		this.P2Dead = true
	end

	if this.Gilmer.Dead then
		this.GilmerDead = true
	end

	if this.GilmerDead and this.DenverDead and this.ClarkDead then
		this.EnemyShipsDead = true
	end						
end

function luaCDGIntro()
	
	
	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.Enterprise,
               ["pos"] = { 23.43, 1, -60.11 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
           ["zoom"] = 1.25,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="target",
           ["position"]= {
               ["parent"]=Mission.Enterprise,
               ["pos"] = { 35.74, 1, 27.21 },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=11.0,
           ["linearblend"]=1.0,
           ["zoom"] = 1.25,
       }
  
  MovCamNew_AddPosition(pos0) 

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.Enterprise,
               ["pos"] = { -111.15, 40, 65.17, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=0.0,
           ["linearblend"]=1.0,
					 ["zoom"] = 1.25,
       }
  
  MovCamNew_AddPosition(pos0)

	local pos0 = {
           ["postype"]="camera",
           ["position"]= {
               ["parent"]=Mission.Enterprise,
               ["pos"] = { -99.39, 40, 152.54, },
           },
           ["transformtype"]="keepy",
           ["starttime"]=0.0,
           ["blendtime"]=11.0,
           ["linearblend"]=1.0,
			 		 ["zoom"] = 1.25,
       }
  
  MovCamNew_AddPosition(pos0)

	SetSkipMovie("luaCDGSkipMovie")

end

function luaCDGSkipMovie()

	if not Mission.MovieSkip then

		
		Mission.MovieSkip = true
	
		SetSkipMovie()
	
		luaCrossFade(luaCDGSelectSub)
		
	end

end

function luaCDGSelectSub()

	EnableInput(true)

	SetSelectedUnit(Mission.PlayerUnit1)

end