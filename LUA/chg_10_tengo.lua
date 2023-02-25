---- OPERATION TEN-GO (CHG) ----

-- Scripted & Assembled by: Team Wolfpack

---- OPERATION TEN-GO (CHG) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(102) 	-- F4U
	PrepareClass(26) 	-- F6F
	PrepareClass(113) 	-- TBF
	PrepareClass(38) 	-- SB2C
	--PrepareClass(108) 	-- SBD
	PrepareClass(117) 	-- B29
	
	PrepareClass(7) 	-- South Dakota
	PrepareClass(15) 	-- Iowa
	PrepareClass(11) 	-- AMS
	PrepareClass(390) 	-- Alaska
	PrepareClass(256) 	-- Essex
	PrepareClass(298) 	-- Independence
	PrepareClass(234) 	-- Troop Transport
	
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
	
	LoadMessageMap("usn14dlg", 1)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/CHG/chg_10_tengo.lua"

	this.Name = "CHG10"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Reach",
				["Text"] = "Reach Okinawa!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Yamato",
				["Text"] = "The Yamato must survive!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "CVs",
				["Text"] = "Destroy the enemy carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Trans",
				["Text"] = "Annihilate the enemy landing forces!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
		},
		["hidden"] = {
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
					["message"] = "idlg01b",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "idlg03",
				},
				{
					["message"] = "idlg04",
				},
				{
					["type"] = "pause",
					["time"] = 6,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["type"] = "pause",
					["time"] = 3,
				},
				{
					["message"] = "dlg23a",
				},
				{
					["message"] = "dlg23b",
				},
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07a_1",
				},
				{
					["message"] = "dlg07b",
				},
				{
					["message"] = "dlg24",
				},
				{
					["message"] = "dlg25",
				},
				{
					["message"] = "dlg26",
				},
			},
		},
		--[[["OCEAN"] = {--
			["sequence"] = {
				{
					["message"] = "dlg07a",
				},
				{
					["message"] = "dlg07a_1",
				},
				{
					["message"] = "dlg07b",
				},
			},
		},]]
		["OPERATION"] = {--
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
				{
					["message"] = "dlg11c",
				},
				{
					["message"] = "dlg11d",
				},
				{
					["message"] = "dlg11e",
				},
			},
		},
		["REPORTS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
				{
					["message"] = "dlg12c",
				},
				{
					["message"] = "dlg12d",
				},
				{
					["message"] = "dlg12e",
				},
				{
					["message"] = "dlg12f",
				},
				--[[{
					["message"] = "dlg12g",
				},]]
				--[[{
					["message"] = "dlg13c",
				},]]
				{
					["type"] = "callback",
					["callback"] = "luaAddThirdObjs",
				},
			},
		},
		["MAKE"] = {--
			["sequence"] = {
				{
					["message"] = "dlg14b",
				},
				{
					["message"] = "dlg15b",
				},
				{
					["message"] = "dlg15c",
				},
				{
					["message"] = "dlg15d",
				},
				{
					["message"] = "dlg15e",
				},
				{
					["message"] = "dlg15f",
				},
				{
					["message"] = "CARRIA1",
				},
				{
					["message"] = "CARRIA2",
				},
				{
					["message"] = "CARRIA3",
				},
			},
		},
		["LOSS"] = {--
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
				{
					["message"] = "dlg17b",
				},
				{
					["message"] = "dlg16b",
				},
				{
					["message"] = "dlg16c",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionFailed",
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
	
	Mission.SkillLevel = SKILL_ELITE
	Mission.SkillLevelOwn = SKILL_ELITE
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	if LobbySettings and LobbySettings.GameMode == "globals.gamemode_islandcapture" then
		
		luaCheckSkirmish()
		
		if Mission.Skirmish then
			
			Mission.EndMission = true
			
			luaMissionFailedNew(nil, "A Co-Op map only!")
		
		else
		
			Mission.PlayingCOOP = true
			
		end
	
	else
	
		Blackout(true, "", true)
	
	end
	
	---- IJN ----
	
	Mission.Yamato = FindEntity("Yamato")
	
	Mission.BanzaiGang = {}
		table.insert(Mission.BanzaiGang, Mission.Yamato)
		table.insert(Mission.BanzaiGang, FindEntity("Yahagi"))
		table.insert(Mission.BanzaiGang, FindEntity("Isokaze"))
		table.insert(Mission.BanzaiGang, FindEntity("Hamakaze"))
		table.insert(Mission.BanzaiGang, FindEntity("Yukikaze"))
		table.insert(Mission.BanzaiGang, FindEntity("Asashimo"))
		table.insert(Mission.BanzaiGang, FindEntity("Kasumi"))
		table.insert(Mission.BanzaiGang, FindEntity("Hatsushimo"))
		table.insert(Mission.BanzaiGang, FindEntity("Fuyutsuki"))
		table.insert(Mission.BanzaiGang, FindEntity("Suzutsuki"))
	
	for idx,unit in pairs(Mission.BanzaiGang) do
		
		if not Mission.PlayingCOOP then
		
			JoinFormation(unit, Mission.BanzaiGang[1])
			
		end
		
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		RepairEnable(unit, false)
		SetCatapultStock(unit, 0)
		
	end
	
	Mission.YamiEsc = {}
		table.insert(Mission.YamiEsc, FindEntity("Yahagi"))
		table.insert(Mission.YamiEsc, FindEntity("Isokaze"))
		table.insert(Mission.YamiEsc, FindEntity("Hamakaze"))
		table.insert(Mission.YamiEsc, FindEntity("Yukikaze"))
		table.insert(Mission.YamiEsc, FindEntity("Asashimo"))
		table.insert(Mission.YamiEsc, FindEntity("Kasumi"))
		table.insert(Mission.YamiEsc, FindEntity("Hatsushimo"))
		table.insert(Mission.YamiEsc, FindEntity("Fuyutsuki"))
		table.insert(Mission.YamiEsc, FindEntity("Suzutsuki"))
	
	---- USN ----
	
	Mission.MovieCVs = {}
	
	if not Mission.PlayingCOOP then
		
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV1"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV2"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV3"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV4"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV5"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV6"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV7"))
		table.insert(Mission.MovieCVs, GenerateObject("MovieCV8"))
		
	end	
	
	Mission.MoviePlanes = {}
	
	if not Mission.PlayingCOOP then	
	
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane1"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane2"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane3"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane4"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane5"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane6"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane7"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane8"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane9"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane10"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane11"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane12"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane13"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane14"))
		table.insert(Mission.MoviePlanes, GenerateObject("MoviePlane15"))
	
		for idx,unit in pairs(Mission.MoviePlanes) do
			
			SetInvincible(unit, true)
			PilotSetTarget(unit, Mission.Yamato)
			
		end
	
	end
	
	Mission.PlaneTable = {
	
		[1] = luaFindHidden("Corsair"), 
		[2] = luaFindHidden("Hellcat"), 
		[3] = luaFindHidden("Avenger"), 
		[4] = luaFindHidden("Helldiver"), 
		--[5] = luaFindHidden("Dauntless"), 
	
	}
	
	Mission.AttackPlanes = {}
	Mission.CVs = {}
	Mission.USFleet1 = {}
	Mission.USFleet2 = {}
	Mission.USFleet3 = {}
	Mission.USFleet4 = {}
	
	---- VAR ----
	
	Mission.GoTo = GetPosition(FindEntity("YamatoGoTo1"))
	Mission.GoToZ = Mission.GoTo.z
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	Mission.PlaneNum = 386
	Mission.PlanesSpawned = 0
	Mission.SquadsPerWave = 8
	Mission.WingCount = 3
	Mission.FighterStop = 75
	Mission.PlaneDelay1 = 55
	Mission.PlaneDelay2 = 45
	Mission.PlaneTrgTracker = 0
	Mission.PlaneEscortAttackTime = 5
	Mission.PlaneBombaCode = 1
	
	Mission.JapAI = 3
	Mission.USAI = 3
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	BannSupportmanager()
	
	MissionNarrative("April 7th, 1945 - Off Okinawa")
	
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
	
	--luaDelay(luaMoveToPh2, 70)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("YamatoGoTo1"))
	--luaShowPoint(FindEntity("LandingPoint_South11"))
	--luaShowPoint(FindEntity("LandingPoint_South12"))
	--luaShowPoint(FindEntity("LandingPoint_South15"))
	
	--luaShowPath(FindEntity("CVPath"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--SetInvincible(FindEntity("Yamato"), 0.4)
	
	--[[Mission.LandInstallations = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and ((string.find(unit.Name, "Heavy AA") or string.find(unit.Name, "Light AA")) or (string.find(unit.Name, "Fortress") or string.find(unit.Name, "Bunker"))) then
			
			table.insert(Mission.LandInstallations, unit)
			
		end
		
	end
	
	for idx,unit in pairs(Mission.LandInstallations) do
		
		Kill(unit, true)
		
	end]]
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.JapUnits) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end]]
	
	--Mission.TEST = 0
	
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
	
		luaIntroMovie1()
		
		Mission.Started = true

    else

        if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	

    ---- TEST ----

    --print("text")
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.USShips))
	--MissionNarrative("#Mission.PlanesSpawned#")
	
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
			
			--[[else
			
				Music_Control_SetLevel(MUSIC_ACTION)
				luaCheckMusicSetMinLevel(MUSIC_ACTION)]]
			
			end
			
			if luaObj_IsActive("primary", 1) then
				
				if Mission.Yamato and not Mission.Yamato.Dead then
				
					local pos = GetPosition(Mission.Yamato)
					
					if Mission.GoToZ >= pos.z and not Mission.SetToMoveToPh4 then
						
						luaDelay(luaHidePh1Score, 1)
						luaObj_Completed("primary", 1, true)
						
						luaMoveToPh4()
						
						Mission.SetToMoveToPh4 = true
					
					else
						
						local dist = pos.z - Mission.GoToZ
						local processed = luaMetric(dist)
						Mission.DistanceLeft = string.format("%.1f", processed)
						local mes = GetMeasure()
						local text
						
						if mes == "globals.mile" then
						
							text = "mi"
							
						elseif mes == "globals.kilometer" then
						
							text = "km"
							
						end
						
						if Mission.PlayingCOOP then
							
							MultiScore = {
								[0]= {
									[1] = Mission.DistanceLeft,
								},
								[1]= {
									[1] = Mission.DistanceLeft,
								},
								[2]= {
									[1] = Mission.DistanceLeft,
								},
								[3]= {
									[1] = Mission.DistanceLeft,
								},
								[4]= {
									[1] = Mission.DistanceLeft,
								},
								[5]= {
									[1] = Mission.DistanceLeft,
								},
								[6]= {
									[1] = Mission.DistanceLeft,
								},
								[7]= {
									[1] = Mission.DistanceLeft,
								},
							}
							
							DisplayScores(1, 0, "Reach Okinawa!", "Distance left:".."| #MultiScore.0.1# "..text)
							DisplayScores(1, 1, "Reach Okinawa!", "Distance left:".."| #MultiScore.1.1# "..text)
							DisplayScores(1, 2, "Reach Okinawa!", "Distance left:".."| #MultiScore.2.1# "..text)
							DisplayScores(1, 3, "Reach Okinawa!", "Distance left:".."| #MultiScore.3.1# "..text)
							DisplayScores(1, 4, "Reach Okinawa!", "Distance left:".."| #MultiScore.4.1# "..text)
							DisplayScores(1, 5, "Reach Okinawa!", "Distance left:".."| #MultiScore.5.1# "..text)
							DisplayScores(1, 6, "Reach Okinawa!", "Distance left:".."| #MultiScore.6.1# "..text)
							DisplayScores(1, 7, "Reach Okinawa!", "Distance left:".."| #MultiScore.7.1# "..text)
						
						else
						
							local line1 = "Reach Okinawa!"
							local line2 = "Distance left: #Mission.DistanceLeft# "..text
							luaDisplayScore(1, line1, line2)
						
						end
						
					end
					
				end
			
			end
			
			if luaObj_IsActive("primary", 2) then
				
				if Mission.Yamato.Dead then
					
					if not Mission.AboutToFail then
						
						if not Mission.PlayingCOOP then
						
							luaStartDialog("LOSS")
						
						else
						
							luaMissionFailed()
						
						end
						
						Mission.EndMission = true
						Mission.AboutToFail = true
					
					end
					
				else
					
					local hp = GetHpPercentage(Mission.Yamato)
					local checkHp = hp
					
					if hp < 0.3 then
					
						checkHp = checkHp + 0.1
					
					end
					
					SetShipMaxSpeed(Mission.Yamato, checkHp * Mission.Yamato.Class.MaxSpeed)
					
					--if not Mission.LowMusicSwitched then
					
						if hp <= 0.3 then
							
							Music_Control_SetLevel(MUSIC_ACTION)
							luaCheckMusicSetMinLevel(MUSIC_ACTION)
							
							--Mission.LowMusicSwitched = true
						
						else
						
							Music_Control_SetLevel(MUSIC_TENSION)
							luaCheckMusicSetMinLevel(MUSIC_TENSION)
						
						end
					
					--end
				
				end
			
			end
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if Mission.PlanesSpawned >= Mission.PlaneNum and not Mission.SetToMoveToPh2 then
			
				if table.getn(luaRemoveDeadsFromTable(Mission.AttackPlanes)) == 0 then
				
					luaCheckMoveToPh2()
				
				else
				
					luaDelay(luaCheckMoveToPh2, 95)
				
				end
				
				Mission.SetToMoveToPh2 = true
				
			end
			
			if table.getn(luaRemoveDeadsFromTable(Mission.AttackPlanes)) > 0 then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AttackPlanes)) do
				
					if unit and not unit.Dead then
						
						--if not unit.retreating then
						
							local ammo = GetProperty(unit, "ammoType")
							
							if ammo ~= 0 then
							
								if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
									
									if Mission.Yamato and not Mission.Yamato.Dead then
									
										luaSetScriptTarget(unit, Mission.Yamato)
										PilotSetTarget(unit, Mission.Yamato)
										
									end
								
								end
								
							end
						
						--end
						
					end
					
				end
			
			end
			
		elseif Mission.MissionPhase == 2 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.USFleet1)) == 0 then
			
				luaMoveToPh3()
			
			end
		
		elseif Mission.MissionPhase == 3 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.USFleet2)) == 0 and not Mission.SetToMoveToCvPhase then
			
				luaMoveToPh4()
				
				Mission.SetToMoveToCvPhase = true
			
			end
			
		elseif Mission.MissionPhase == 4 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) == 0 then
			
				luaMoveToPh5()
			
			else

				--if table.getn(luaRemoveDeadsFromTable(Mission.CVs)) > 0 then
			
					for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.CVs)) do
					
						if unit and not unit.Dead then
							
							local fighters = {
								[1] = 26,
							}
							local bombers = {
								[1] = 113,
								[2] = 38,
							}
							
							luaAirfieldManager(unit, fighters, bombers, {Mission.Yamato})
							
						end
					
					end
				
				--end
			
			end
			
		elseif Mission.MissionPhase == 5 then
		
			if table.getn(luaRemoveDeadsFromTable(Mission.USFleet4)) == 0 then
				
				if Mission.PlayingCOOP then
				
					luaMissionComplete()
				
				else
				
					luaFinalDia()
				
				end
				
				Mission.EndMission = true
			
			end
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 5 ----

function luaMoveToPh5()

	Mission.MissionPhase = 5
	
	Mission.USFleet4 = {}
		table.insert(Mission.USFleet4, GenerateObject("Cargo-01"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-02"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-03"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-04"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-05"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-06"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-07"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-08"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-09"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-10"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-11"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-12"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-13"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-14"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-15"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-16"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-17"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-18"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-19"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-20"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-21"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-22"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-23"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-24"))
		table.insert(Mission.USFleet4, GenerateObject("Cargo-25"))
	
	local usPos = GetPosition(Mission.USFleet4[1])
	local japPos = GetPosition(Mission.Yamato)
	local dist = japPos.z - usPos.z
	local move = dist + 2500
	
	for idx,unit in pairs(Mission.USFleet4) do
		
		local pos = GetPosition(unit)
		pos.z = pos.z + move
		
		PutTo(unit, pos)
		
		JoinFormation(unit, Mission.USFleet4[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		RepairEnable(unit, true)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	luaAddFinalObjs()
	
end

function luaFinalDia()

	luaStartDialog("FINAL")

end

function luaAddFinalObjs()

	luaObj_Add("primary", 4, Mission.USFleet4)

end

---- PHASE 4 ----

function luaMoveToPh4()

	Mission.MissionPhase = 4
	
	Mission.USFleet3 = {}
		table.insert(Mission.USFleet3, GenerateObject("Hornet"))
		table.insert(Mission.USFleet3, GenerateObject("Bennington"))
		table.insert(Mission.USFleet3, GenerateObject("Belleau Wood"))
		table.insert(Mission.USFleet3, GenerateObject("San Jacinto"))
		table.insert(Mission.USFleet3, GenerateObject("Essex"))
		table.insert(Mission.USFleet3, GenerateObject("Bunker Hill"))
		table.insert(Mission.USFleet3, GenerateObject("Hancock"))
		table.insert(Mission.USFleet3, GenerateObject("Bataan"))
		table.insert(Mission.USFleet3, GenerateObject("Alaska"))
		table.insert(Mission.USFleet3, GenerateObject("Guam"))
	
	local usPos = GetPosition(Mission.USFleet3[1])
	local japPos = GetPosition(Mission.Yamato)
	local dist = japPos.z - usPos.z
	local move = dist - 7000
	
	for idx,unit in pairs(Mission.USFleet3) do
		
		local pos = GetPosition(unit)
		pos.z = pos.z + move
		
		PutTo(unit, pos)
		
		JoinFormation(unit, Mission.USFleet3[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		RepairEnable(unit, true)
		
		if unit.Class.Type == "MotherShip" then
		
			table.insert(Mission.CVs, unit)
			
			SetAirBaseSlotCount(unit, 3)
			
		end
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	local pathIdx = luaRnd(1,2)
	local pathDir
	
	if pathIdx == 1 then
	
		pathDir = PATH_SM_JOIN
	
	elseif pathIdx == 2 then
	
		pathDir = PATH_SM_JOIN_BACKWARDS
	
	end
	
	NavigatorMoveOnPath(Mission.USFleet3[1], FindEntity("CVPath"), PATH_FM_CIRCLE, pathDir)
	
	NavigatorAttackMove(FindEntity("Alaska"), Mission.Yamato)
	NavigatorAttackMove(FindEntity("Guam"), Mission.Yamato)
	
	if not Mission.PlayingCOOP then
	
		luaPh4Dia()
	
	end
	
	PermitSupportmanager()
	
end

function luaPh4Dia()

	luaStartDialog("MAKE")

end

function luaAddThirdObjs()

	luaObj_Add("primary", 3, Mission.CVs)

end

---- PHASE 3 ----

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	Mission.USFleet2 = {}
		table.insert(Mission.USFleet2, GenerateObject("Massachusetts"))
		table.insert(Mission.USFleet2, GenerateObject("New Jersey"))
		table.insert(Mission.USFleet2, GenerateObject("Wisconsin"))
		table.insert(Mission.USFleet2, GenerateObject("Missouri"))
		table.insert(Mission.USFleet2, GenerateObject("De Haven"))
		table.insert(Mission.USFleet2, GenerateObject("Mansfield"))
	
	local usPos = GetPosition(Mission.USFleet2[1])
	local japPos = GetPosition(Mission.Yamato)
	local dist = japPos.z - usPos.z
	local move = dist - 5000
	
	for idx,unit in pairs(Mission.USFleet2) do
		
		local pos = GetPosition(unit)
		pos.z = pos.z + move
		
		PutTo(unit, pos)
		
		JoinFormation(unit, Mission.USFleet2[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		RepairEnable(unit, true)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.USFleet2[1], Mission.Yamato)
	
	if not Mission.PlayingCOOP then
	
		luaPh3Dia()
	
	end
	
end

function luaPh3Dia()

	luaStartDialog("REPORTS")

end

---- PHASE 2 ----

function luaMoveToPh2()

	Mission.MissionPhase = 2
	
	Mission.USFleet1 = {}
		table.insert(Mission.USFleet1, GenerateObject("South Dakota"))
		table.insert(Mission.USFleet1, GenerateObject("Indiana"))
		table.insert(Mission.USFleet1, GenerateObject("English"))
	
	local usPos = GetPosition(Mission.USFleet1[1])
	local japPos = GetPosition(Mission.Yamato)
	local dist = japPos.z - usPos.z
	local move = dist - 5500
	
	for idx,unit in pairs(Mission.USFleet1) do
		
		local pos = GetPosition(unit)
		pos.z = pos.z + move
		
		PutTo(unit, pos)
		
		JoinFormation(unit, Mission.USFleet1[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		TorpedoEnable(unit, true)
		RepairEnable(unit, true)
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.USFleet1[1], Mission.Yamato)
	
	if Mission.PlayingCOOP then
	
		--luaAddSecObjs()
	
	else
		
		luaDelay(luaPh2Dia, 2)
		
		Mission.SelUnit = GetSelectedUnit()
		
		local trg1 = Mission.USFleet1[1]
		
		luaIngameMovie(
		{
			
			{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 500, ["theta"] = 5, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 355, ["moveTime"] = 8},
			
		}, luaPh2MovieEnd, true)
		
	end
	
end

function luaPh2Dia()

	luaStartDialog("OPERATION")

end

function luaPh2MovieEnd()

	if Mission.SelUnit and not Mission.SelUnit.Dead then
	
		SetSelectedUnit(Mission.SelUnit)
	
	else
	
		SetSelectedUnit(Mission.Yamato)
	
	end

end

---- PHASE 1 ----

function luaCheckMoveToPh2()

	if Mission.MissionPhase == 1 then
	
		luaMoveToPh2()
	
	end

end

function luaHidePh1Score()
	
	if Mission.PlayingCOOP then
	
		HideScoreDisplay(1,0)
		HideScoreDisplay(1,1)
		HideScoreDisplay(1,2)
		HideScoreDisplay(1,3)
		HideScoreDisplay(1,4)
		HideScoreDisplay(1,5)
		HideScoreDisplay(1,6)
		HideScoreDisplay(1,7)
	
	else
	
		HideScoreDisplay(1,0)
	
	end
	
end

function luaIntroMovie1()
	
	if Mission.PlayingCOOP then
	
		luaIntroMovieEnd()
	
	else
		
		luaDelay(luaIntroDia, 3)
		
		local trg1 = FindEntity("MovieCV1")
		
		luaIngameMovie(
		{
			
			{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=6,["z"]=105},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
			{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=105},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
			{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=6,["z"]=105},["parent"] = trg1,},["moveTime"] = 4,["transformtype"] = "keepall"},
	 
			{["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=18,["z"]=105},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
			{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=18,["z"]=105},["parent"] = trg1,},["moveTime"] = 4,["transformtype"] = "keepall"},
			{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=18,["z"]=105},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
			
		}, luaIntroMovie2, true)
		
	end
	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovie2()

	Blackout(true, "luaIntroMovie3", 1)

end

function luaIntroMovie3()

	local trg1 = FindEntity("Yamato")
	local trg2 = FindEntity("MoviePlane6")
	local trg3 = FindEntity("MoviePlane10")
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 160, ["theta"] = -1, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 160, ["theta"] = 1, ["rho"] = 0, ["moveTime"] = 4},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 4000, ["theta"] = 13, ["rho"] = -250, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 4000, ["theta"] = 13, ["rho"] = -250, ["moveTime"] = 0.2,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 170, ["theta"] = 1, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 170, ["theta"] = 3, ["rho"] = 0, ["moveTime"] = 4},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 14, ["rho"] = -50, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 2000, ["theta"] = 14, ["rho"] = -50, ["moveTime"] = 0.2,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 180, ["theta"] = 3, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 180, ["theta"] = 5, ["rho"] = 0, ["moveTime"] = 4},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 600, ["theta"] = 15, ["rho"] = 150, ["moveTime"] = 0,},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 600, ["theta"] = 15, ["rho"] = 150, ["moveTime"] = 0.2,},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 6, ["rho"] = 0, ["moveTime"] = 4},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 6, ["rho"] = 0, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 6, ["rho"] = 0, ["moveTime"] = 2},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 6, ["rho"] = 0, ["moveTime"] = 6},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 6, ["rho"] = 0, ["moveTime"] = 7},
		
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 1, ["rho"] = 20, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 300, ["theta"] = 1, ["rho"] = 20, ["moveTime"] = 13},
		
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 300, ["theta"] = 5, ["rho"] = 170, ["moveTime"] = 0},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 6},
	    {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 180, ["moveTime"] = 1},
		
	}, luaIntroMovieEnd, true)

end

function luaIntroMovieEnd()
	
	if table.getn(luaRemoveDeadsFromTable(Mission.MovieCVs)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MovieCVs)) do
			
			Kill(unit, true)
			
		end
	
	end
	
	if table.getn(luaRemoveDeadsFromTable(Mission.MoviePlanes)) > 0 then
	
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.MoviePlanes)) do
			
			Kill(unit, true)
			
		end
	
	end
	
	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	if not Mission.PlayingCOOP then
	
		SetSelectedUnit(Mission.Yamato)
	
	end
	
	--Mission.CanMusicCheck = true
	
	--luaStartDialog("ATTACKS")
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2, Mission.Yamato)
	
	DisplayUnitHP({Mission.Yamato}, "The Yamato must survive!")
	
	luaDelay(luaPreparePlaneWave, 20)
	luaDelay(luaPh1Dia, 15)
	
end

function luaPh1Dia()

	--luaStartDialog("OCEAN")

end

function luaPreparePlaneWave()

	if Mission.Yamato and not Mission.Yamato.Dead then
	
		if Mission.PlanesSpawned < Mission.PlaneNum then
		
			local planeTbl = {}
			
			while table.getn(planeTbl) < Mission.SquadsPerWave do
				
				local idx
				
				if Mission.PlanesSpawned < Mission.FighterStop then
				
					idx = luaRnd(1,2)
					
				else
					
					if Mission.PlaneBombaCode == 1 then
					
						idx = 3
						
					else
					
						idx = 4
					
					end
				
				end
				
				table.insert(planeTbl, Mission.PlaneTable[idx])
				
				Mission.PlanesSpawned = Mission.PlanesSpawned + Mission.WingCount
			
			end
			
			luaSpawnPlaneWave(planeTbl, Mission.Yamato, 6500, 7000, 1000, 125, 245)
			
			Mission.PlaneBombaCode = -(Mission.PlaneBombaCode)
			
			local delay
			
			if Mission.PlanesSpawned < Mission.FighterStop then
			
				delay = Mission.PlaneDelay1
				
			else
			
				delay = Mission.PlaneDelay2
			
			end
			
			luaDelay(luaPreparePlaneWave, delay)
			
		end
	
	end

end

function luaSpawnPlaneWave(unitTable, trg, dist1, dist2, alt, angle1, angle2)
	
	for idx,unit in pairs(unitTable) do
		
		--Mission.TEST = unit.Name
		--MissionNarrative("#Mission.TEST#")
		
		local spawned = Spawn(unit.Name, ST_ABSANGLE, GetPosition(trg), dist1, dist2, alt, angle1, angle2, "", true)
		
		local canAttackEscorts = true
		
		if spawned.Class.ID == 102 or spawned.Class.ID == 26 then
		
			canAttackEscorts = false
		
		end
		
		luaPlaneSpawned(spawned, canAttackEscorts)
	
	end
	
end

function luaPlaneSpawned(unit, canAttackEscorts)

	SetSkillLevel(unit, Mission.SkillLevel)
	
	local trg = Mission.Yamato
	
	if Mission.PlaneTrgTracker >= Mission.PlaneEscortAttackTime and canAttackEscorts then
	
		trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.YamiEsc))
		
		Mission.PlaneTrgTracker = 0
	
	else
		
		Mission.PlaneTrgTracker = Mission.PlaneTrgTracker + 1
	
	end
	
	luaSetScriptTarget(unit, trg)
	PilotSetTarget(unit, trg)
	
	table.insert(Mission.AttackPlanes, unit)

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		HideUnitHP()
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	luaMissionCompletedNew(Mission.Yamato, "The enemy has been crushed - Mission Complete")
	
end

function luaMissionFailed()

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
	
	luaMissionFailedNew(Mission.Yamato, "Game Over")
	
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
	
	--[[if Mission.EndMission then
	
		return
	
	end]]
	
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