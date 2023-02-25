--SceneFile="universe\Scenes\missions\IJN\ijn_09_guadalcanal.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_CALM)
	EnableMessages(false)
	LoadMessageMap("ijndlg",9)

	Dialogues =
	{
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01b",
				},
				{
					["message"] = "idlg01c",
				},
			},
		},
	}

	MissionNarrative("ijn09.date_location")
	luaDelay(luaEngineInit, 6, "")

end
function luaEngineInit()
	StartDialog("Intro_dlg", Dialogues["Intro"] );
end
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitJM09")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM09(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM09.lua"

	this.Name = "JM9"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	Mission.Unlockables = {
		["58"] = {"ingame.shipnames_kitakaze","ingame.shipnames_natsukaze","ingame.shipnames_hatsunatsu","ingame.shipnames_fuyukaze","ingame.shipnames_shimakaze","ingame.shipnames_hayaharu"},
		["14"] = {"ingame.shipnames_natsuzuki","ingame.shipnames_yoizuki","ingame.shipnames_wakatsuki","ingame.shipnames_suzutsuki","ingame.shipnames_teruzuki","ingame.shipnames_niizuki"},
		["59"] = {"ingame.shipnames_musashi"},
		["388"] = {"ingame.shipnames_yashima"},
		["2008"] = {"Musashi"},
		["1310"] = {"Bismarck"},
		["391"] = {"ingame.shipnames_kinu"},
		["68"] = {"ingame.shipnames_tone"},
		["1311"] = {"Prinz Eugen"},
	}


	--enginemovies
	--luaInitJumpinMovies()

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_SPVETERAN
	end

	--Mission.UnlockLvl = 3

	--reload
	SetDeviceReloadEnabled(true)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM9SpawnUSNBBs, luaJM9SpawnUSNDDs, luaJM9SpawnIJNReinf, luaJM9LoadMissionData},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM9SaveMissionData},
	}

	Mission.USNGenericSpawnPoints = {}
		table.insert(Mission.USNGenericSpawnPoints, FindEntity("USNSpawnPoint 01"))
		table.insert(Mission.USNGenericSpawnPoints, FindEntity("USNSpawnPoint 02"))
		table.insert(Mission.USNGenericSpawnPoints, FindEntity("USNSpawnPoint 03"))

	Mission.USNDDSpawnPoints = {}
		table.insert(Mission.USNDDSpawnPoints, FindEntity("USNDDSpawnPoint 01"))
		table.insert(Mission.USNDDSpawnPoints, FindEntity("USNDDSpawnPoint 02"))
		table.insert(Mission.USNDDSpawnPoints, FindEntity("USNDDSpawnPoint 03"))

	Mission.USNBBSpawnPoints = {}
		table.insert(Mission.USNBBSpawnPoints, FindEntity("USNBBSpawnPoint 01"))
		table.insert(Mission.USNBBSpawnPoints, FindEntity("USNBBSpawnPoint 02"))
		table.insert(Mission.USNBBSpawnPoints, FindEntity("USNBBSpawnPoint 03"))

	Mission.USNBBGenerate = {}
		table.insert(Mission.USNBBGenerate, FindEntity("BBGeneratePoint01"))
		Mission.USNBBGenerate[1].BB = "South Dakota Class 01"
		table.insert(Mission.USNBBGenerate, FindEntity("BBGeneratePoint02"))
		Mission.USNBBGenerate[2].BB = "South Dakota Class 02"
		table.insert(Mission.USNBBGenerate, FindEntity("BBGeneratePoint03"))
		Mission.USNBBGenerate[3].BB = "South Dakota Class 03"


	Mission.IJNRetreatPoint = FindEntity("IJNRetreatPoint")

	Mission.PlayerCruiser = FindEntity("Takao-class 01")

	SetSelectedUnit(Mission.PlayerCruiser)
	SetShipSpeed(Mission.PlayerCruiser, 15)

	Mission.AICruisers =  {}
		table.insert(Mission.AICruisers, FindEntity("Kuma-class 01"))
		table.insert(Mission.AICruisers, FindEntity("Kuma-class 02"))
		for idx,unit in pairs(Mission.AICruisers) do
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			NavigatorMoveOnPath(unit, FindEntity("Kuma0"..tostring(idx).."Path"))
		end

	Mission.AICruiserNames = {}
		table.insert(Mission.AICruiserNames, "ingame.shipnames_kiso")
		table.insert(Mission.AICruiserNames, "ingame.shipnames_tama")

	Mission.Clemsons = {}
		table.insert(Mission.Clemsons, FindEntity("Clemson-class 02"))
		Mission.Clemsons[1].Path = FindEntity("Clemson02Path")
		table.insert(Mission.Clemsons, FindEntity("Clemson-class 03"))
		Mission.Clemsons[2].Path = FindEntity("Clemson03Path")
		table.insert(Mission.Clemsons, FindEntity("Clemson-class 04"))
		Mission.Clemsons[3].Path = FindEntity("Clemson04Path")

	Mission.AllClemsons = {}
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 01"))
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 02"))
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 03"))
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 04"))
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 05"))
		table.insert(Mission.AllClemsons, FindEntity("Clemson-class 06"))

	Mission.ClemsonNames = {}
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_alden", 211})		--dd211
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_brooks", 232})	--dd232
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_bulmer", 222})	--dd222
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_gilmer", 233})	--dd233
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_king", 242})		--dd242
		table.insert(Mission.ClemsonNames, {"ingame.shipnames_parrott", 218})	--dd218

	Mission.PatrolClemson = FindEntity("Clemson-class 01")
	if Mission.Difficulty >= 1 then
		TorpedoEnable(Mission.PatrolClemson, true)
	end
	NavigatorMoveOnPath(Mission.PatrolClemson, FindEntity("Clemson01Path0"..tostring(random(1,3))))

	Mission.PlayerOnMap = false

	Mission.USNDDs = {}
	Mission.USNDDReinfReq = "USNDDReinfReq"
	Mission.USNReinf = {}
	Mission.USNBBReinfReq = "USNBBReinfReq"
	Mission.IJNReinf = {}
	Mission.IJNReinfReq = "IJNReinfReq"
	Mission.IJNBBs = {}

	Mission.StageGroup = {}
		table.insert(Mission.StageGroup, FindEntity("Clemson-class 05"))
		table.insert(Mission.StageGroup, FindEntity("Clemson-class 06"))
		for idx,unit in pairs(Mission.StageGroup) do
			NavigatorEnable(unit, false)
			ArtilleryEnable(unit, false)

			if Mission.Difficulty >= 1 then
				TorpedoEnable(unit, false)
			end

			EnableMessages(unit, false)
			SetForcedReconLevel(unit,0,PARTY_JAPANESE)
		end
	Mission.StageTrg = FindEntity("Fubuki-class 01")
		SetParty(Mission.StageTrg, PARTY_NEUTRAL)
		NavigatorEnable(Mission.StageTrg, false)
		ArtilleryEnable(Mission.StageTrg, false)
		TorpedoEnable(Mission.StageTrg, false)
		EnableMessages(Mission.StageTrg, false)
		SetForcedReconLevel(Mission.StageTrg,0,PARTY_JAPANESE)

	Mission.Kingfisher = FindEntity("OS2U Kingfisher 01")
	Mission.KFInvincible = 0.3
	SetInvincible(Mission.Kingfisher, Mission.KFInvincible)

	SquadronSetTravelAlt(Mission.Kingfisher, 550, true)
	PilotMoveOnPath(Mission.Kingfisher, FindEntity("KingfisherPath"))
	UnitSetFireStance(Mission.Kingfisher, STANCE_HOLD_FIRE)

	Mission.USNDDNames = {}
		table.insert(Mission.USNDDNames, {"ingame.shipnames_heywood", 6})		--APA6
		table.insert(Mission.USNDDNames, {"ingame.shipnames_saufley", 465})		--dd465
		table.insert(Mission.USNDDNames, {"ingame.shipnames_strong", 467})		--dd467

	Mission.USNReinfNames = {}
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_indiana", 58})				--bb58
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_massachusetts", 59})	--bb59
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_cleveland", 55})			--cl55
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_columbia", 56})				--cl56
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_english", 696})				--dd696
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_charles_s_sperry", 697}) --dd697
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_john_w_weeks", 701})	--dd701
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_harlan_r_dickson", 708}) --dd708
		table.insert(Mission.USNReinfNames, {"ingame.shipnames_hugh_purvis", 709})		--dd709

	Mission.IJNReinfNames = {}
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_yamashiro")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_hirishima")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_amagiri")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_hatsuyuki")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_isonami")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_sazanami")
		table.insert(Mission.IJNReinfNames, "ingame.shipnames_uranami")

	Mission.NmiAirSpawnDone = 0
	Mission.NmiPlanes = {}

	Mission.UnlockBettys = {}

	Mission.USNFleetSpawnDelay = 90

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)
	this.MissionPhase = 1

	--this.ObjRemindTime = 150

	--objs
	Mission.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "recon",
				["Text"] = "ijn09.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			--[2] = {
			--	["ID"] = "chase",
			--	["Text"] = "ijn09.obj_p2",
			--	["Active"] = false,
			--	["Success"] = nil,
			--	["Target"] = {},
			--	["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
			--	["ScoreFailed"] = 0
			--},
			[3] = {
				["ID"] = "radio",
				["Text"] = "ijn09.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "battle",
				["Text"] = "ijn09.obj_p4",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "reconplane",
				["Text"] = "ijn09.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "allships",
				["Text"] = "ijn09.obj_s2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "chase",
				["Text"] = "ijn09.obj_p2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "bb",
				["Text"] = "ijn09.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
	}

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()

	LoadMessageMap("ijndlg",9)

	this.Dialogues = {
		["DDsSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
			},
		},
		["DDsFlee"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["BBSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},
				{
					["message"] = "dlg3c",
				},
				{
					["message"] = "dlg3d",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM9StartRadioTrafic"
				},
			},
		},
		["Radio"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
				{
					["type"] = "pause",
					["time"] = 2,
				},
				{
					["message"] = "dlg4c",
				},
				{
					["message"] = "dlg4d",
				},
			},
		},
		["ReinfIn"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["BattleStateLoss"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["BattleStateWin"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
			},
		},
		["Unlock"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
			},
		},
		["DDKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
			},
		},
	}

	Mission.ScoreDisplay = {}

	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_CALM)

	luaJM09SetGuiNames()
	luaJM9MapListener()
	luaJM9AddReconListener()
	luaJM9AddReconListener2()
	luaJM9AddReconListener3()
	--luaJM9AddKingfisherListener()
	luaJM9AddKingfisherHitListener()

	luaJM9FadeIn()

	Mission.ThinkNum = 0

	--AddWatch("Mission.MissionPhase")
	--think
	SetThink(this, "luaJM09_think")
end

function luaJM09_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.ThinkStop then
		return
	end

	if Mission.ThinkNum < 2 then		-- Mission - FirstSeconds fakez
		Mission.ThinkNum = Mission.ThinkNum + 1
		return
	end

	luaJM9CheckObjectives()

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	if Mission.MissionPhase == 1 then

		luaJM9CheckPatrolClemson()
		luaJM9CheckStageGroup()

	elseif Mission.MissionPhase == 2 then

		if not Mission.Dakota then
			luaJM9CheckPatrolClemson()
			luaJM9CheckKiteEvent()
		end
		luaJM9CheckStageGroup()

	elseif Mission.MissionPhase == 3 then

		luaJM9ClemsonsAttack()
		luaJM9CheckDakota()
		luaJM9CheckUSNDDs()
		luaJM9CheckUSNReinf()
		luaJM9CheckStageGroup()
		luaJM9CheckCatalinas()

	elseif Mission.MissionPhase == 4 then

		luaJM9CheckCatalinas()
		luaJM9ClemsonsAttack()
		luaJM9CheckDakota()
		luaJM9CheckUSNDDs()
		luaJM9CheckUSNReinf()
		luaJM9CheckStageGroup()

	end

end

--objs
function luaJM9CheckObjectives()

	if not Mission.IJNReinfIn then
		if Mission.PlayerCruiser.Dead then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn09.obj_missionfailed1"
-- RELEASE_LOGOFF  			luaLog("Setting MissionFailed")
			luaJM9StepPhase(99)
		end
	else
		if table.getn(luaRemoveDeadsFromTable(Mission.IJNReinf)) == 0 then
			Mission.MissionFailed = true
			Mission.FailMsg = "ijn09.obj_missionfailed2"
-- RELEASE_LOGOFF  			luaLog("Setting MissionFailed")
			luaJM9StepPhase(99)
		end
	end

	if not luaObj_IsActive("secondary",1) and Mission.KingfisherSighted then
		luaObj_Add("secondary",1,Mission.Kingfisher)
		--luaJM9KingfisherCamera()
		luaJM9Sec1Score()
	else
		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if Mission.Kingfisher.Dead then
				if Mission.Kingfisher.KillReason == "exitzone" then
					--if IsListenerActive("kill", "KingFListener") then
						--RemoveListener("kill", "KingFListener")
						HideUnitHP()
						luaObj_Failed("secondary",1)
					--end
				else
					luaObj_Completed("secondary",1)
					HideUnitHP()
					luaJM9AddPowerup("improved_ship_manoeuvreability")
				end
			end
		end
	end

	if luaObj_IsActive("secondary",3) and luaObj_GetSuccess("secondary",3) == nil and Mission.PCLemsonSighted then
		if not Mission.PatrolClemson.Dead then
			--luaObj_Reminder("secondary",3)
		else
			luaObj_Completed("secondary",3)
			luaJM9AddPowerup("improved_repair_team")
			HideUnitHP()
		end
	end

	if Mission.MissionPhase == 1 then

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			luaObj_AddUnit("primary",1,GetPosition(FindEntity("ReconPoint")))
			luaObj_AddReminder("primary",1)
			luaJM9Pri1Score()
			luaJM9ReconplaneHint()
		elseif luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			if Mission.ClemsonSighted then
				luaJM9StartDialog("DDsSpotted",true)
				luaJM9StepPhase()
			else
				luaObj_Reminder("primary",1)
			end
			luaJM9Pri1Score()
		end

	elseif Mission.MissionPhase == 2 then

		if not luaObj_IsActive("secondary",3) and Mission.PCLemsonSighted then
			luaObj_Add("secondary",3)
			luaObj_AddUnit("secondary",3,Mission.PatrolClemson)
			luaObj_AddReminder("secondary",3)
			luaJM9Pri2Score()
			luaJM9AICruiserAttack()
		end

		if Mission.Dakota then
			luaObj_Completed("primary",1,true)
			luaJM9RemoveScore(1)
			--if not Mission.PatrolClemson.Dead and luaObj_IsActive("secondary",3) then
			--	luaObj_Failed("secondary",3)
			--	HideUnitHP()
			--end
			luaJM9SumClemsons()
			luaJM9CruisersRetreat()
			luaJM9StartDialog("BBSpotted",true)
			luaJM9StepPhase()
		else
			luaObj_Reminder("primary",1)
			luaJM9Pri1Score()
		end

	elseif Mission.MissionPhase == 3 then

		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
			--luaObj_AddUnit("primary",3,GetPosition(Mission.IJNRetreatPoint))
			luaJM9Pri3Score()
			--if Scoring_IsUnlocked("JM8_SILVER") or Scoring_IsUnlocked("JM8_GOLD") then
			if Scoring_IsUnlocked("JM8_GOLD") then
				luaJM9SpawnUnlockPlanes()
			end
		elseif luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
			--if luaGetDistance(Mission.PlayerCruiser, Mission.IJNRetreatPoint) < 1000 then

			if Mission.TimerStarted then
				luaJM9Pri3Score()
				if CountdownTimeLeft() < 200 and not Mission.CAHint then
					luaJM9RetreatHint()
					Mission.CAHint = true
				end
			end

			if Mission.RadioTransmitted then
				luaObj_Completed("primary",3,true)
				luaJM9RemoveScore(3)
				luaJM9SpawnIJNReinf()
				luaJM9RestoreSkill()
				luaJM9AddPowerup("improved_ship_manoeuvreability")
				luaJM9StepPhase()
			else
				luaObj_Reminder("primary",3)
				--luaJM9Pri3Score()
			end

		end

	elseif Mission.MissionPhase == 4 then

		if not luaObj_IsActive("primary",4) and Mission.USNReinfSpawned then
			luaObj_Add("primary",4)
			luaJM9Pri4Score()
			luaObj_AddReminder("primary",4)
		elseif luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then

			luaJM9CheckBattleState()

			if table.getn(luaRemoveDeadsFromTable(Mission.nmiTbl)) == 0 then
				luaObj_Completed("primary",4,true)
				HideUnitHP()
			else
				luaObj_Reminder("primary",4)
				--luaJM9Pri4Score()
			end
		elseif luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) then
			luaJM9USNRetreat()
			luaJM9StepPhase()
		end

	elseif Mission.MissionPhase == 5 then

		if not luaObj_IsActive("secondary",2) then
			luaObj_Add("secondary",2)
			luaJM9Sec2Score()
		end

		luaJM9CheckBattleState()

		luaJM9CheckWinConds()
		if Mission.MissionCompleted then
			if luaObj_IsActive("secondary",2) and luaObj_GetSuccess("secondary",2) == nil then
				HideUnitHP()
				if Mission.Sec2Done then
					luaObj_Completed("secondary",2,nil,true)
				else
					luaObj_Failed("secondary",2,nil,true)
				end
			end
			luaJM9StepPhase(99)
		end

	elseif Mission.MissionPhase == 99 then
-- RELEASE_LOGOFF  		luaLog("MissionFailed")

			local endEnt
			if Mission.MissionFailed then

				if not Mission.IJNReinfIn then

					if Mission.PlayerCruiser.Dead and not Mission.PlayerCruiser.TrulyDead then
						endEnt = Mission.PlayerCruiser
					else
						if Mission.Dakota and not Mission.Dakota.Dead then
							endEnt = Mission.Dakota
						else
							if Mission.PlayerCruiser.LastBanto and not Mission.PlayerCruiser.LastBanto.Dead then
								endEnt = Mission.PlayerCruiser.LastBanto
							end
						end
					end
					if not endEnt then
						endEnt = luaPickRnd(luaRemoveDeadsFromTable(Mission.AICruisers))
					end

				else

					if not endEnt then
						for idx,unit in pairs(Mission.IJNReinf) do
							if not TrulyDead(unit) then
								endEnt = unit
								break
							end
						end
					end

					if not endEnt then
						endEnt = luaPickRnd(luaRemoveDeadsFromTable(Mission.USNReinf))
					end

				end

				luaMissionFailedNew(endEnt, Mission.FailMsg, nil, true)

			luaJM9StepPhase()

		elseif Mission.MissionCompleted then

			if table.getn(luaRemoveDeadsFromTable(Mission.IJNBBs)) == 2 then
				luaObj_Completed("hidden", 1)
			end

			endEnt = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNReinf))
			luaMissionCompletedNew(endEnt, "ijn09.obj_missioncompleted", nil)
			luaJM9StepPhase()

		end

	end
end

function luaJM9CheckWinConds()
	if Mission.MissionCompleted then
		return
	end

	local exited = false

	for idx,unit in pairs(Mission.USNReinf) do
		if unit.Dead and unit.KillReason == "exitzone" then
			exited = true
			break
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.USNReinf)) == 0 then
		Mission.MissionCompleted = true

		if exited then
			Mission.Sec2Done = false
		else
			Mission.Sec2Done = true
		end

		HideUnitHP()

	else

		if table.getn(luaRemoveDeadsFromTable(Mission.nmiTbl)) == 0 then
			local near
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNReinf)) do
				nearShips = luaGetShipsAround(unit, 3500, "enemy")
				if nearShips and next(nearShips) ~= nil then
					near = true
					break
				end
			end
			if not near then
				Mission.MissionCompleted = true
				Mission.Sec2Done = false
			end
		end

	end

	--[[
	if table.getn(luaRemoveDeadsFromTable(Mission.USNReinf)) == 0 then
		Mission.MissionCompleted = true
		Mission.Sec2Done = true
		HideUnitHP()
	else
		if table.getn(luaRemoveDeadsFromTable(Mission.nmiTbl)) == 0 then
			local near
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNReinf)) do
				nearShips = luaGetShipsAround(unit, 3500, "enemy")
				if nearShips and next(nearShips) ~= nil then
					near = true
					break
				end
			end
			if not near then
				Mission.MissionCompleted = true
				Mission.Sec2Done = false
			end
		end
	end
	]]
end

function luaJM9AICruiserAttack()
	local nmi = luaGetNearestEnemy(Mission.PatrolClemson, "Cruiser")
	if nmi then
		luaSetScriptTarget(nmi, Mission.PatrolClemson)
		NavigatorAttackMove(nmi, Mission.PatrolClemson, {})
		TorpedoEnable(nmi, true)
	end
end

function luaJM9CheckPatrolClemson()
	if Mission.PatrolClemson.Dead then
		return
	end

	if not Mission.PatrolClemson.retreating then
		local ships = luaGetShipsAround(Mission.PatrolClemson, 2500, "enemy")
		if ships and next(ships) ~= nil or Mission.MissionPhase == 2 then
			local point = luaJM9GetClosestEventPoint()
			NavigatorMoveToRange(Mission.PatrolClemson, point)
			Mission.PatrolClemson.retreating = true
			luaJM9StartDialog("DDsFlee",true)
		end
	else
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Clemsons)) do
			if GetProperty(unit, "unitcommand") ~= "moveonpath" and luaGetDistance(unit, Mission.PatrolClemson) < 1500 then
				NavigatorMoveOnPath(unit, unit.Path)
			end
		end
	end
end

function luaJM9GetClosestEventPoint()
	local point
	local dist = 100000
	local postbl = {}

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Clemsons)) do
		table.insert(postbl, GetPosition(unit))
	end

	for idx,pos in pairs(postbl) do
		local dist2 = luaGetDistance(Mission.PlayerCruiser,pos)
		if dist2 < dist then
			point = pos
			dist = dist2
		end
	end

	return point
end

function luaJM9CheckKiteEvent()
	local spawndist = 100000
	local generatePoint
	local unitsToWatch = {}

		table.insert(unitsToWatch, Mission.PlayerCruiser)
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AICruisers)) do
			table.insert(unitsToWatch, unit)
		end
		for idx,unit in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.reconplane)) do
			--luaLog("reconplane")
			--luaLog(unit)
			table.insert(unitsToWatch, unit)
		end

	for idx,point in pairs(Mission.USNBBGenerate) do
		--for idx2,unit in pairs(unitsToWatch) do
			--local dist = luaGetDistance(point, unit)
			local dist = luaGetDistance(point, Mission.PlayerCruiser)
			if dist < spawndist then
				spawndist = dist
				generatePoint = point
				Mission.GeneratePoint = idx
			end
		--end
	end

	if spawndist < 4100 and not Mission.Dakota then
		if Mission.PlayerOnMap then
-- RELEASE_LOGOFF  			luaLog("No spawn player on map")
			if spawndist < 3500 then --itt mar muszaj
				Mission.Dakota = GenerateObject(generatePoint.BB)
				SetGuiName(Mission.Dakota, "ingame.shipnames_south_dakota")
				SetNumbering(Mission.Dakota, 57)
				Mission.DakotaSpawnTime = math.floor(GameTime())
				luaDelay(luaJM9DodiDakota, 3)
				--luaLog("muszaj")
			end
		else
			Mission.Dakota = GenerateObject(generatePoint.BB)
			SetGuiName(Mission.Dakota, "ingame.shipnames_south_dakota")
			SetNumbering(Mission.Dakota, 57)
			Mission.DakotaSpawnTime = math.floor(GameTime())
			luaDelay(luaJM9DodiDakota, 3)
		end
	end
end

function luaJM9DodiDakota()
	SetSkillLevel(Mission.Dakota, SKILL_STUN)
	NavigatorSetTorpedoEvasion(Mission.Dakota, false)
end

function luaJM9CruisersRetreat()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AICruisers)) do
		NavigatorMoveToRange(unit, Mission.IJNRetreatPoint)
		TorpedoEnable(unit, true)
	end
end

function luaJM9ClemsonsAttack()
	Mission.Clemsons = luaRemoveDeadsFromTable(Mission.Clemsons)
	for idx,unit in pairs(Mission.Clemsons) do
		if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
			local nmi = luaGetNearestEnemy(unit)
			if nmi and luaGetType(nmi) == "ship" then
				if Mission.Difficulty >= 1 then
					TorpedoEnable(unit, true)
				end
				NavigatorAttackMove(unit, nmi, {})
				luaSetScriptTarget(unit, nmi)
			else
				if not IsInFormation(unit) and Mission.Dakota and not Mission.Dakota.Dead then
					JoinFormation(unit, Mission.Dakota)
				end
			end
		end
	end
end

function luaJM9CheckDakota()
	if Mission.Dakota.Dead then
		if not Mission.IJNReinfIn and not Mission.AchievementAdded then
-- RELEASE_LOGOFF  			luaLog("Achievement added")
			SetAchievements("MA_PS")
			luaJM9AddPowerup("improved_shells")
			Mission.AchievementAdded = true
		end
		return
	end

	if luaGetScriptTarget(Mission.Dakota) == nil or luaGetScriptTarget(Mission.Dakota).Dead then
		local ships = luaGetShipsAround(Mission.Dakota, 40000, "enemy")
		if ships and next(ships) ~= nil then
			local nmi = luaSortByDistance(Mission.Dakota, ships, true)
			if nmi and not nmi.Dead then
				NavigatorAttackMove(Mission.Dakota, nmi, {})
				luaGetScriptTarget(Mission.Dakota, nmi)
			end
		end
	end

	if not Mission.DakotaMovie then
		--luaJumpinMovieSetCurrentMovie("LookAt", Mission.Dakota.ID)
		luaJM9AddDamCamera()
		Mission.DakotaMovie = true
	end
end

function luaJM9SumClemsons()
	if not Mission.PatrolClemson.Dead then
		table.insert(Mission.Clemsons, Mission.PatrolClemson)
	end
end

function luaJM9CheckUSNDDs()
	if not Mission.USNDDsSpawned and not SpawnNewIDIsRequested(Mission.USNDDReinfReq) then
		luaJM9SpawnUSNDDs()
	end

	Mission.USNDDs = luaRemoveDeadsFromTable(Mission.USNDDs)
	for idx,unit in pairs(Mission.USNDDs) do
		if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
			local ships = luaGetShipsAround(unit, 20000, "enemy")
			if ships and next(ships) ~= nil then
				local trg = luaSortByDistance(unit, ships, true)
				--luaLog("-----")
				--luaLog(trg)
				NavigatorAttackMove(unit, trg, {})
				luaSetScriptTarget(unit, trg)
			end
		end
	end
end

function luaJM9CheckUSNReinf()
	if not Mission.USNReinfSpawned and not SpawnNewIDIsRequested(Mission.USNBBReinfReq) then
		if math.floor(GameTime()) - Mission.DakotaSpawnTime > Mission.USNFleetSpawnDelay then
			luaJM9SpawnUSNBBs()
		else
			return
		end
	end

	Mission.USNReinf = luaRemoveDeadsFromTable(Mission.USNReinf)
	if table.getn(Mission.USNReinf) == 0 then
		return
	end

	local leader = GetFormationLeader(Mission.USNReinf[1])
	if not leader then
		leader = Mission.USNReinf[1]
	end

	if luaGetScriptTarget(leader) == nil or luaGetScriptTarget(leader).Dead then
		local ships = luaGetShipsAround(leader, 20000, "enemy")
		if ships and next(ships) ~= nil then
			local trg = luaSortByDistance(leader, ships, true)
			NavigatorAttackMove(leader, trg, {})
			luaSetScriptTarget(leader, trg)
		end
	end

end

---listeners
function luaJM9MapListener()
	AddListener("gui", "MapListener", {
		["callback"] = "luaJM9EnterMap",  -- callback fuggveny
		["guiName"] = {"GUI_map"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
		["enter"] = {true,false}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
		})
end

function luaJM9EnterMap(guiname,enter)
	Mission.PlayerOnMap = enter
end

-----
function luaJM9StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
-- RELEASE_LOGOFF  	luaLog("new phase "..tostring(Mission.MissionPhase))
end

function luaJM9SpawnUSNDDs()
-- RELEASE_LOGOFF  	luaLog("luaJM9SpawnUSNDDs")

	local refPos = luaPickRnd(Mission.USNDDSpawnPoints)

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 23,
			["Name"] = "Fletcher1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Fletcher2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 23,
			["Name"] = "Fletcher3",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(refPos),
		["angleRange"] = { luaJM9RAD(0), luaJM9RAD(180)},
		["lookAt"] = GetPosition(Mission.IJNRetreatPoint),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM9USNDDsSpawned",
	["id"] = Mission.USNDDReinfReq,
})
end

function luaJM9USNDDsSpawned(...)
-- RELEASE_LOGOFF  	luaLog("luaJM9USNDDsSpawned")
	for idx,unit in ipairs(arg) do
		SetSkillLevel(unit, Mission.SkillLevel)
		table.insert(Mission.USNDDs, unit)
		SetGuiName(unit, Mission.USNDDNames[idx][1])
		SetNumbering(unit, Mission.USNDDNames[idx][2])

		if Mission.Difficulty >= 1 then
			TorpedoEnable(unit, true)
		end
	end
	Mission.USNDDsSpawned = true
end

function luaJM9SpawnUSNBBs()
-- RELEASE_LOGOFF  	luaLog("luaJM9SpawnUSNBBs")
	--3BB, 3CA, 8DD
	local validTbl = {}
	for idx,point in pairs(Mission.USNBBSpawnPoints) do
		if luaGetDistance(Mission.PlayerCruiser, point) > 4500 then
			table.insert(validTbl, point)
		end
	end
	local refPos = luaPickRnd(validTbl)


	local grpTbl = {
		{
			["Type"] = 7,
			["Name"] = "SD",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 7,
			["Name"] = "SD2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 18,
			["Name"] = "Cleveland1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 11,
			["Name"] = "Allen M. Sumner1",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 11,
			["Name"] = "Allen M. Sumner2",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 11,
			["Name"] = "Allen M. Sumner3",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
	}

	local veteranTbl = {
		{
			["Type"] = 11,
			["Name"] = "Allen M. Sumner4",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 11,
			["Name"] = "Allen M. Sumner5",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
		{
			["Type"] = 18,
			["Name"] = "Cleveland3",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
	}

	if Mission.Difficulty == 2 then
		for idx, tbl in pairs(veteranTbl) do
			table.insert(grpTbl, tbl)
		end
	end


	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl,

	["area"] = {
		["refPos"] = GetPosition(refPos),
		["angleRange"] = { luaJM9RAD(0), luaJM9RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = GetPosition(Mission.IJNRetreatPoint),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM7USNBBsSpawned",
	["id"] = Mission.USNBBReinfReq,
})
end

function luaJM7USNBBsSpawned(...)
-- RELEASE_LOGOFF  	luaLog("luaJM7USNBBsSpawned")
	local SD
	for idx,unit in ipairs(arg) do
		SetSkillLevel(unit, Mission.SkillLevel)
		table.insert(Mission.USNReinf, unit)
		if unit.Class.Type == "Destroyer" and Mission.Difficulty >= 1 then
			TorpedoEnable(unit, true)
		end
		if string.find(unit.Name, "SD2") then
			SD = unit
		end
	end

	for idx,unit in pairs(Mission.USNReinf) do
		if unit.ID ~= SD.ID then
			JoinFormation(unit, SD)
		end
	end

	for idx,unit in pairs(Mission.USNReinf) do
		SetGuiName(unit, Mission.USNReinfNames[idx][1])
		SetNumbering(unit, Mission.USNReinfNames[idx][2])
	end

	Mission.USNReinfSpawned = true
end

function luaJM9SpawnIJNReinf()
-- RELEASE_LOGOFF  	luaLog("luaJM9SpawnIJNReinf")
	--2BBc 1BB, 5DD
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 61,
			["Name"] = "Fuso1",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 60,
			["Name"] = "Kongo1",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 73,
			["Name"] = "Fubuki1",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 73,
			["Name"] = "Fubuki2",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 73,
			["Name"] = "Fubuki3",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 73,
			["Name"] = "Fubuki4",
			["Crew"] = 1,
			["Race"] = Japan,
		},
		{
			["Type"] = 73,
			["Name"] = "Fubuki5",
			["Crew"] = 1,
			["Race"] = Japan,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(FindEntity("IJNReinforcementSpawnPoint")),
		["angleRange"] = { luaJM9RAD(0), luaJM9RAD(180)},
		["lookAt"] = GetPosition(Mission.USNBBSpawnPoints[2]),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM9IJNReinfSpawned",
	["id"] = Mission.IJNReinfReq,
})
end

function luaJM9IJNReinfSpawned(...)
-- RELEASE_LOGOFF  	luaLog("luaJM9IJNReinfSpawned")
	local leader
	for idx,unit in ipairs(arg) do
		table.insert(Mission.IJNReinf,unit)
		if unit.Class.Type == "BattleShip" then
			table.insert(Mission.IJNBBs,unit)
		end
		if string.find(unit.Name,"Fuso") then
			leader = unit
		end
	end

	for idx,unit in pairs(Mission.IJNReinf) do
		if unit.ID ~= leader.ID then
			JoinFormation(unit, leader)
		end

-- RELEASE_LOGOFF  		luaLog("reinf names")
-- RELEASE_LOGOFF  		luaLog(Mission.IJNReinfNames[idx])

		local i = 1
		if IsClassChanged(unit.Class.ID) then
			if unit.Class.ID == 14 then
				SetGuiName(unit, Mission.Unlockables["14"][i])
				i = i + 1
			elseif unit.Class.ID == 58 then
				SetGuiName(unit, Mission.Unlockables["58"][i])
				i = i + 1
			elseif unit.Class.ID == 59 then
				SetGuiName(unit, Mission.Unlockables["59"][1])
			elseif unit.Class.ID == 391 then
				SetGuiName(unit, Mission.Unlockables["391"][1])
			elseif unit.Class.ID == 388 then
				SetGuiName(unit, Mission.Unlockables["388"][1])
			elseif unit.Class.ID == 1310 then
				SetGuiName(unit, Mission.Unlockables["1310"][1])
			else
				SetGuiName(unit, unit.Class.Name)
			end
		else
			SetGuiName(unit, Mission.IJNReinfNames[idx])
		end
	end

	SetShipSpeed(leader, 10)

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.AICruisers)) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_1)
		JoinFormation(unit, leader)
	end
	--luaJumpinMovieSetCurrentMovie("GoAround", leader.ID)

	luaJM9CruiserMovie(leader)

	Mission.IJNReinfIn = true
	luaJM9StartDialog("ReinfIn",true)
	luaObj_Add("hidden", 1)
end

function luaJM9AddReconListener()
-- RELEASE_LOGOFF  	luaLog("reconlistener added")
	AddListener("recon", "ClemsonListener", {
		["callback"] = "luaJM9ClemsonSighted",  -- callback fuggveny
		["entity"] = Mission.Clemsons, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = { PARTY_JAPANESE },
		})
end

function luaJM9ClemsonSighted(entity, oldlevel, newlevel)
-- RELEASE_LOGOFF  	luaLog("luaJM9ClemsonSighted")
	--luaLog(oldlevel)
	--luaLog(newlevel)
	Mission.ClemsonSighted = true
	RemoveListener("recon", "ClemsonListener")
end

function luaJM9RAD(x)
	return x *  0.0174532925
end

function luaJM9USNRetreat()
	for idx,unitTbl in pairs(recon[PARTY_ALLIED].own) do
		for idx2,unit in pairs(unitTbl) do
			if unit and not unit.Dead and luaGetType(unit) == "ship" then
				local point = GetClosestBorderZone(GetPosition(unit))
				SetShipMaxSpeed(unit, 10)
				NavigatorMoveToRange(unit, point)
			end
		end
	end
end

function luaJM9SpawnUnlockPlanes()


	--if not Scoring_IsUnlocked("JM8_SILVER") and not Scoring_IsUnlocked("JM8_GOLD") then
	if not Scoring_IsUnlocked("JM8_GOLD") then
-- RELEASE_LOGOFF  		luaLog("no medal")
		Mission.UnlockPlanesIn = true
		return
	end

-- RELEASE_LOGOFF  	luaLog("luaJM9SpawnUnlockPlanes")
	local grpTbl = {}
	local unitTbl = {
		["Type"] = 167,
		["Name"] = "G4M Betty",
		["Crew"] = 3,
		["Race"] = JAPANESE,
		["WingCount"] = 1,
		["Equipment"] = 1,
	}

	--if Scoring_IsUnlocked("JM8_SILVER") then
	--	table.insert(grpTbl, unitTbl)
	--end
	if Scoring_IsUnlocked("JM8_GOLD") then
		table.insert(grpTbl, unitTbl)
		table.insert(grpTbl, unitTbl)
	end

	local spawnPos = GetPosition(FindEntity("IJNReinforcementSpawnPoint"))
	spawnPos.y = 1000

	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = grpTbl,
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = spawnPos,
		["angleRange"] = { luaJM9RAD(0), luaJM9RAD(180)},
		["lookAt"] = GetPosition(Mission.USNBBSpawnPoints[2]),
	},
	["callback"] = "luaJM9UnlockGroupSpawned",
	["id"] = "JapAirSpawnReq",
})

end

function luaJM9UnlockGroupSpawned(...)
-- RELEASE_LOGOFF  	luaLog("luaJM9UnlockGroupSpawned")
	for idx,unit in ipairs(arg) do
		if not Mission.PlayerCruiser.Dead then
			PilotMoveToRange(unit, Mission.PlayerCruiser)
		end
		table.insert(Mission.UnlockBettys, unit)
	end
-- RELEASE_LOGOFF  	luaLog("UnlockPlanes in")
	luaDelay(luaJM9BomberHint,30)

	luaJM9StartDialog("Unlock",true)
	Mission.UnlockPlanesIn = true
end

function luaJM9AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--luaLog("powerup added: "..debug.traceback())
	--MissionNarrativeEnqueue("missionglobals.newpowerup")
end

function luaJM9FadeIn()
	luaCheckSavedCheckpoint()

	if not Mission.CheckpointLoaded then
		--SoundFade(1, "",0.1)
		Blackout(false, "", 0.5)
	else
		EnableInput(false)
		Blackout(true, "", 0)
		Mission.ThinkStop = true
	end
end

function luaJM9StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM6StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM6StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed and not ignorePrinted then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM9CheckBattleState()
	local USNReinfNum = table.getn(luaRemoveDeadsFromTable(Mission.USNReinf))
	local IJNReinfNum = table.getn(luaRemoveDeadsFromTable(Mission.IJNReinf))

	if Mission.MissionPhase < 5 then
		if USNReinfNum/IJNReinfNum >= 1.4 then
			luaJM9StartDialog("BattleStateLoss",true)
		elseif USNReinfNum/IJNReinfNum <= 0.4 then
			luaJM9StartDialog("BattleStateWin",true)
		end
	end

	if not Mission.BBHint then
		local unit = GetSelectedUnit()
		if unit and not unit.Dead and unit.Class.Type == "BattleShip" then
			luaJM9BBHint()
			Mission.BBHint = true
		end
	end

end

function luaJM9CheckStageGroup()
	if not Mission.StageInit then
		local shipsAround = luaGetShipsAround(Mission.StageGroup[1], 4200, "enemy")
		local planesAround = luaGetPlanesAround(Mission.StageGroup[1], 4200, "enemy")

		if planesAround or shipsAround then
			luaJM9InitStageBattle()
		end
	else
		if table.getn(luaRemoveDeadsFromTable(Mission.StageGroup)) > 0 then
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.StageGroup)) do
				if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
					if not Mission.IJNReinfIn then
						NavigatorAttackMove(unit, Mission.PlayerCruiser, {})
						luaSetScriptTarget(unit, Mission.PlayerCruiser)
					else
						local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNReinf))
						if trg and not trg.Dead then
							NavigatorAttackMove(unit, trg, {})
							luaSetScriptTarget(unit, trg)
						end
					end
				end
			end
		end
	end
end

function luaJM9InitStageBattle()
	SetDamagedGFXLevel(Mission.StageTrg, 1)
	SetForcedReconLevel(Mission.StageTrg, 2, PARTY_JAPANESE)
	SetInvincible(Mission.StageTrg, 0.1)
	--luaJumpinMovieSetCurrentMovie("GoAround", Mission.StageTrg.ID)

	luaJM9StageBattleMovie(Mission.StageTrg)

	luaJM9AddEfxToStageUnit2()
	luaDelay(luaJM9AddEfxToStageUnit1,5)
	luaDelay(luaJM9KillStageShip,20)
	luaDelay(luaJM9DDDialog,1)
	for idx,unit in pairs(Mission.StageGroup) do
		ArtilleryEnable(unit, true)
		NavigatorEnable(unit, true)
		ClearForcedReconLevel(unit,PARTY_JAPANESE)
		if Mission.Difficulty >= 1 then
			TorpedoEnable(unit, true)
		end
	end
	Mission.StageInit = true
end

function luaJM9KillStageShip()
	SetInvincible(Mission.StageTrg, false)
	--Kill(Mission.StageTrg, true)
	SetDeadMeat(Mission.StageTrg)
end

function luaJM9AddEfxToStageUnit1()
	if Mission.StageTrg.Dead then
		return
	end
	--Effect("SecondaryExplosion", GetPosition(Mission.StageTrg))
	Effect("ExplosionBigShip", {["x"]=0,["y"]=0,["z"]=0}, Mission.StageTrg)
	luaDelay(luaJM9AddEfxToStageUnit1,random(1,5))
end

function luaJM9AddEfxToStageUnit2()
	Effect("BigFire", {["x"]=0,["y"]=0,["z"]=0}, Mission.StageTrg)
end

function luaJM9AddKingfisherListener()
	AddListener("kill", "KingFListener", {
		["callback"] = "luaJM9KingfisherDead",  -- callback fuggveny
		["entity"] = {Mission.Kingfisher}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		})
end

function luaJM9KingfisherDead()
-- RELEASE_LOGOFF  	luaLog("callback bazzeg")
	RemoveListener("kill", "KingFListener")
	if Mission.Kingfisher.KillReason == "harm" then
		Mission.SecSuccess = true
	else
		Mission.SecFailed = true
	end
end

function luaJM9AddKingfisherHitListener()
	AddListener("hit", "kingfisherhit", {
		["callback"] = "luaJM9KingfisherHit", -- callback fuggveny
		["target"] = { Mission.Kingfisher }, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM9KingfisherHit()
-- RELEASE_LOGOFF  	luaLog("KFHitByPlayer")
-- RELEASE_LOGOFF  	luaLog(Mission.KFInvincible)

	if Mission.KFInvincible > 0.1 then
		Mission.KFInvincible = Mission.KFInvincible - 0.1
		SetInvincible(Mission.Kingfisher, Mission.KFInvincible)
	else
		SetInvincible(Mission.Kingfisher, false)
		RemoveListener("hit", "kingfisherhit")
	end
end

function luaJM9AddReconListener3()
	AddListener("recon", "PClSighted", {
		["callback"] = "luaJM9PatrolClemsonSighted",  -- callback fuggveny
		["entity"] = {Mission.PatrolClemson}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0,1}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM9PatrolClemsonSighted()
	Mission.PCLemsonSighted = true
	RemoveListener("recon", "PClSighted")
end

function luaJM9AddReconListener2()
	AddListener("recon", "KFSighted", {
		["callback"] = "luaJM9KingFisherSighted",  -- callback fuggveny
		["entity"] = {Mission.Kingfisher}, -- entityk akiken a listener aktiv
		["oldLevel"] = {0,1}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM9KingFisherSighted()
	RemoveListener("recon", "KFSighted")
	Mission.KingfisherSighted = true
end

function luaJM9SpawnNmiAirStrike()
	local grpTbl = {}

	local unitTbl = {
		[1] = {
			["Type"] = 125,
			["Name"] = "PBY Catalina",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
			["WingCount"] = 1,
			["Equipment"] = 1,
		},
		[2] = {
			["Type"] = 135,
			["Name"] = "P40 Warhawk",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
	}

	for i=1,random(2,3) do
		table.insert(grpTbl, unitTbl)
	end

	local spawnPos = GetPosition(FindEntity("USNBBSpawnPoint 02"))
	spawnPos.y = 550

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = grpTbl[random(1,2)],
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["area"] = {
		["refPos"] = spawnPos,
		["angleRange"] = { luaJM9RAD(0), luaJM9RAD(180)},
		["lookAt"] = GetPosition(FindEntity("IJNReinforcementSpawnPoint")),
	},
	["callback"] = "luaJM9AirGroupSpawned",
	["id"] = "USNAirSpawnReq",
})
end

function luaJM9AirGroupSpawned(...)
	Mission.NmiAirSpawnDone = Mission.NmiAirSpawnDone + 1
	for i,v in ipairs(arg) do
		SetSkillLevel(v, Mission.SkillLevel)
		--luaLog("Catalina name "..v.Name)
		--luaLog("Equipment: "..tostring(GetProperty(v, "ammoType")))
		table.insert(Mission.NmiPlanes, v)
	end
end

function luaJM9CheckCatalinas()
	if Mission.NmiAirSpawnDone < 5 then
		Mission.NmiPlanes = luaRemoveDeadsFromTable(Mission.NmiPlanes)
		if Mission.MissionPhase == 3 and table.getn(Mission.NmiPlanes) < 3 and not SpawnNewIDIsRequested("USNAirSpawnReq") then
			luaJM9SpawnNmiAirStrike()
		end
		for idx,plane in pairs(Mission.NmiPlanes) do
			local ammo = GetProperty(plane, "ammoType")
			if ammo ~= 0 and (luaGetScriptTarget(plane) == nil or luaGetScriptTarget(plane).Dead) then
				local trgTbl = {}
				local trg

				trgTbl = luaRemoveDeadsFromTable(Mission.AICruisers)

				if not Mission.PlayerCruiser.Dead then
					table.insert(trgTbl, Mission.PlayerCruiser)
				end

				trg = luaPickRnd(trgTbl)

				if trg and not trg.Dead then
					PilotSetTarget(plane, trg)
					luaSetScriptTarget(plane, trg)
				end

			elseif ammo == 0 then
				if plane.Class.Type ~= "Fighter" then
					if GetProperty(plane, "unitcommand") ~= "retreat" then
						PilotRetreat(plane)
					end
				else
					if GetProperty(plane, "unitcommand") ~= "strafe" then
						local trg
						if luaGetScriptTarget(plane) and not luaGetScriptTarget(plane).Dead then
							trg = luaGetScriptTarget(plane)
						else
							trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.AICruisers))
						end
						if trg then
							PilotSetTarget(plane, trg)
							luaSetScriptTarget(plane, trg)
						end
					end
				end
			end
		end
	end
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(7)
	PrepareClass(11)
	PrepareClass(15)
	PrepareClass(18)
	PrepareClass(23)
	PrepareClass(60)
	PrepareClass(61)
	PrepareClass(73)
	PrepareClass(125)
	PrepareClass(135)
	PrepareClass(167)
	Loading_Finish()
end

function luaJM09SetGuiNames()
-- RELEASE_LOGOFF  	luaLog("allitom a guineveket")

	for idx, unit in pairs(Mission.AICruisers) do
		SetGuiName(unit, Mission.AICruiserNames[idx])
	end

	for idx, unit in pairs(Mission.AllClemsons) do
		SetGuiName(unit, Mission.ClemsonNames[idx][1])
		SetNumbering(unit, Mission.ClemsonNames[idx][2])
	end

	for idx, unit in pairs(Mission.AICruisers) do
		SetGuiName(unit, Mission.AICruiserNames[idx])
	end

	if IsClassChanged(Mission.PlayerCruiser.Class.ID) then
		if Mission.PlayerCruiser.Class.ID == 68 then
			SetGuiName(Mission.PlayerCruiser, Mission.Unlockables["68"][1])
		elseif Mission.PlayerCruiser.Class.ID == 391 then
			SetGuiName(Mission.PlayerCruiser, Mission.Unlockables["391"][1])
		elseif Mission.PlayerCruiser.Class.ID == 1311 then
			SetGuiName(Mission.PlayerCruiser, Mission.Unlockables["1311"][1])
		else
			SetGuiName(Mission.PlayerCruiser, Mission.PlayerCruiser.Class.Name)
		end
	else
		SetGuiName(Mission.PlayerCruiser, "ingame.shipnames_takao")
	end

	if IsClassChanged(Mission.StageTrg.Class.ID) then
		if Mission.StageTrg.Class.ID == 14 then
			SetGuiName(Mission.StageTrg, Mission.Unlockables["14"][6])
		elseif Mission.StageTrg.Class.ID == 58 then
			SetGuiName(Mission.StageTrg, Mission.Unlockables["58"][6])
		else
			SetGuiName(Mission.StageTrg, Mission.StageTrg.Class.Name)
		end
	else
		SetGuiName(Mission.StageTrg, "ingame.shipnames_akebono")
	end
	--SetGuiName(Mission.Kingfisher, "OS2U Kingfisher")
end

function luaJM9SelectUnit()
	SetInvincible(Mission.PlayerCruiser, false)
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	else
		SetSelectedUnit(Mission.PlayerCruiser)
	end
	EnableInput(true)

	if Mission.ChckNeeded and not Mission.CheckpointLoaded then
		Blackout(true, "luaJM9Checkpoint1", 1)
		Mission.ChckNeeded = false
	end

end

function luaJM9Checkpoint1()
	luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM9StartRadioTimer()
	Countdown("ijn09.radio", 1, 300, "luaJM9TimerFinished")
	Mission.TimerStarted = true
end

function luaJM9TimerFinished()
	Mission.RadioTransmitted = true
	Mission.TimerStarted = nil
end

function luaJM9ReconplaneHint()
	ShowHint("IJN09_Hint01")
end

function luaJM9RetreatHint()
	ShowHint("IJN09_Hint02")
end

function luaJM9BomberHint()
	ShowHint("IJN09_Hint03")
end

function luaJM9BBHint()
	ShowHint("IJN09_Hint04")
end

function luaJM9DDDialog()
	luaJM9StartDialog("DDKilled",true)
end

function luaJM9StartRadioTrafic()
	luaJM9StartRadioTimer()
	luaDelay(luaJM9RadioMsg,5)
end

function luaJM9RadioMsg()
	luaJM9StartDialog("Radio",true)
end

function luaJM9Metric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		--return dist * 0.621371192
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end

end

function luaJM9Pri1Score()
	local dist = luaJM9Metric(luaGetDistance3D(Mission.PlayerCruiser, FindEntity("ReconPoint")))
	Mission.Distance = string.format("%.2f",dist)
	Mission.Measure = GetMeasure()
	local line1 = "ijn09.obj_p1"
	local line2 = "ijn09.hint_6_desc"
	luaJM9DisplayScore(1,line1,line2)
end

function luaJM9Pri2Score()
	DisplayUnitHP({Mission.PatrolClemson}, "ijn09.obj_p2")
end

function luaJM9Pri3Score()

end

function luaJM9Pri4Score()
	Mission.nmiTbl = {}
	for idx,unit in pairs(Mission.USNReinf) do
		if unit.Class.Type == "BattleShip" then
			table.insert(Mission.nmiTbl, unit)
		end
	end
	if Mission.Dakota and not Mission.Dakota.Dead then
		table.insert(Mission.nmiTbl, Mission.Dakota)
	end
	for idx,unit in pairs(Mission.nmiTbl) do
		luaObj_AddUnit("primary",4,unit)
	end
	DisplayUnitHP(luaRemoveDeadsFromTable(Mission.nmiTbl), "ijn09.obj_p4")
end

function luaJM9Sec1Score()
	DisplayUnitHP({Mission.Kingfisher}, "ijn09.obj_s1")
end

function luaJM9Sec2Score()
	if table.getn(luaRemoveDeadsFromTable(Mission.USNReinf)) > 0 then
		DisplayUnitHP(luaRemoveDeadsFromTable(Mission.USNReinf), "ijn09.obj_s2")
	end
end

function luaJM9DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM9RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

function luaJM9RestoreSkill()
	if Mission.Dakota and not Mission.Dakota.Dead then
		SetSkillLevel(Mission.Dakota, SKILL_SPNORMAL)
		NavigatorSetTorpedoEvasion(Mission.Dakota, true)
	end
end

------------------------MOVIEZ-----------------------------
function luaJM9MovieInit()
	SetInvincible(Mission.PlayerCruiser, 0.1)
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	end
end

function luaJM9CruiserMovie(unit)
	if Mission.CheckpointLoaded then
		return
	end

	luaJM9MovieInit()

	Mission.ChckNeeded = true

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 340, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM9SelectUnit, true)
end

function luaJM9AddDamCamera()
	if Mission.CheckpointLoaded then
		return
	end

	luaJM9MovieInit()


	local movieTbl = {
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 250, ["theta"] = 5, ["rho"] = -80, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 250, ["theta"] = 5, ["rho"] = -80, ["moveTime"] = 10},
		}
	--local movieTbl2 = {
	--	   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 250, ["theta"] = 5, ["rho"] = -80, ["moveTime"] = 0},
	--	   {["postype"] = "cameraandtarget", ["target"] = Mission.Dakota, ["distance"] = 250, ["theta"] = 5, ["rho"] = -80, ["moveTime"] = 10},
	--	}


	--if string.find(Mission.Dakota.Name, "02") == nil then
		luaIngameMovie(movieTbl, luaJM9SelectUnit, true)
	--else
	--	luaIngameMovie(movieTbl2, luaJM9SelectUnit, true)
	--end

end

function luaJM9StageBattleMovie(unit)
	if Mission.CheckpointLoaded then
		return
	end

	luaJM9MovieInit()
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 500, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 200, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 10},
		}, luaJM9SelectUnit, true )
end

function luaJM9KingfisherCamera()
	luaJM9MovieInit()
	luaIngameMovie(
		{
			{["postype"] = "cameraandtarget", ["target"] = Mission.Kingfisher, ["distance"] = 25, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0},
			{["postype"] = "cameraandtarget", ["target"] = Mission.Kingfisher, ["distance"] = 75, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 5},
		}, luaJM9SelectUnit, true)
end

function pocs()
-- RELEASE_LOGOFF  LogToConsole("--JAP UNITS--")
	for idx,x in pairs(recon[PARTY_JAPANESE].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead then
-- RELEASE_LOGOFF  				LogToConsole(unit.Name)
			end
		end
	end
-- RELEASE_LOGOFF  	LogToConsole("--ALLIED UNITS--")
	for idx,x in pairs(recon[PARTY_ALLIED].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead then
-- RELEASE_LOGOFF  				LogToConsole(unit.Name)
			end
		end
	end
-- RELEASE_LOGOFF  	LogToConsole("--NEUTRAL UNITS--")
	for idx,x in pairs(recon[PARTY_NEUTRAL].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead then
-- RELEASE_LOGOFF  				LogToConsole(unit.Name)
			end
		end
	end
end

----------------chck------------------
function luaJM9SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	Mission.Checkpoint.NmiAirSpawnDone = Mission.NmiAirSpawnDone

	local usPlanes = {}
	local usShips = {}
	local japPlanes = {}
	local japShips = {}

	--us
	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_ALLIED].own.fighter, recon[PARTY_ALLIED].own.reconplane)) do
		if unit and not unit.Dead then
			table.insert(usPlanes, {unit.Name, unit.Class.ID, GetPosition(unit)})
		end
	end

	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_ALLIED].own.destroyer, recon[PARTY_ALLIED].own.cruiser, recon[PARTY_ALLIED].own.battleship)) do
		if unit and not unit.Dead then
			if IsInFormation(unit) then
				local leaderName = GetFormationLeader(unit).Name
				table.insert(usShips, {unit.Name, unit.Class.ID, GetPosition(unit), GetProperty(unit, "TorpedoStock"), leaderName})
			else
				table.insert(usShips, {unit.Name, unit.Class.ID, GetPosition(unit), GetProperty(unit, "TorpedoStock")})
			end
		end
	end

	--jap
	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_JAPANESE].own.reconplane, recon[PARTY_JAPANESE].own.levelbomber)) do
		if unit and not unit.Dead then
			table.insert(japPlanes, {unit.Name, unit.Class.ID, GetPosition(unit)})
		end
	end

	for idx,unit in pairs(luaSumTablesIndex(recon[PARTY_JAPANESE].own.destroyer, recon[PARTY_JAPANESE].own.cruiser, recon[PARTY_JAPANESE].own.battleship)) do
		if unit and not unit.Dead then
			if IsInFormation(unit) then
				local leaderName = GetFormationLeader(unit).Name
				table.insert(japShips, {unit.Name, unit.Class.ID, GetPosition(unit), GetProperty(unit, "TorpedoStock"), leaderName})
			else
				table.insert(japShips, {unit.Name, unit.Class.ID, GetPosition(unit), GetProperty(unit, "TorpedoStock")})
			end
		end
	end

	Mission.Checkpoint.UsShips = usShips
	Mission.Checkpoint.UsPlanes = usPlanes
	Mission.Checkpoint.JapPlanes = japPlanes
	Mission.Checkpoint.JapShips = japShips

	--luaLog("Saved tema")
	--luaLog(usShips)
	--luaLog(japShips)
	--luaLog(usPlanes)
	--luaLog(japPlanes)

	--kingfisher
	if Mission.Kingfisher and not Mission.Kingfisher.Dead then
		Mission.Checkpoint.Kingfisher = {GetPosition(Mission.Kingfisher)}
	else
		Mission.Checkpoint.Kingfisher = false
	end

	Mission.Checkpoint.GeneratePoint = Mission.GeneratePoint

end

function luaJM9LoadMissionData()

	if not Mission.Returns then
		Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
		luaJM9SpawnUnlockPlanes()
	end

	if not Mission.USNReinfSpawned or not Mission.USNDDsSpawned or not Mission.IJNReinfIn or not Mission.UnlockPlanesIn then
		luaDelay(luaJM9LoadMissionData,1)
		Mission.Returns = true
		return
	end

	Mission.NmiAirSpawnDone = Mission.Checkpoint.NmiAirSpawnDone

	--local USUnits = luaGetCheckpointData("Units", "USUnits")
	--local JapUnits = luaGetCheckpointData("Units", "JapUnits")

	--restore japUnits
	for idx,unit in pairs(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.IJNReinf,Mission.IJNBBs,Mission.AICruisers,{Mission.PlayerCruiser}))) do
		local found = false
		for idx2,savedTbl in pairs(Mission.Checkpoint.JapShips) do
			if unit.Name == savedTbl[1] then
				if savedTbl[4] and savedTbl[4] >= 0 then
					ShipSetTorpedoStock(unit, savedTbl[4])
				end
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Unit found "..unit.Name)

				if IsInFormation(unit) then
					LeaveFormation(unit)
				end
				luaDelay(luaJM9PutUnit2Coord, 1, "unit", unit, "coord", savedTbl[3], "leaderName", savedTbl[5])

				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	Mission.Dakota = GenerateObject(Mission.USNBBGenerate[Mission.Checkpoint.GeneratePoint].BB)
	--restore us units
	for idx,unit in pairs(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.AllClemsons,Mission.USNDDs,Mission.USNReinf,Mission.StageGroup,{Mission.Dakota}))) do
		local found = false
		for idx2,savedTbl in pairs(Mission.Checkpoint.UsShips) do
			if unit.Name == savedTbl[1] then
				if savedTbl[4] and savedTbl[4] >= 0 then
					ShipSetTorpedoStock(unit, savedTbl[4])
				end
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Unit found "..unit.Name)

				if IsInFormation(unit) then
					LeaveFormation(unit)
				end
				luaDelay(luaJM9PutUnit2Coord, 1, "unit", unit, "coord", savedTbl[3], "leaderName", savedTbl[5])

				found = true
				break
			end
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	--restore japplanes
	for idx,unit in pairs(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.UnlockBettys,recon[PARTY_JAPANESE].own.reconplane))) do
		local found = false
		for idx2,savedTbl in pairs(Mission.Checkpoint.JapPlanes) do
			if unit.Name == savedTbl[1] and unit.Class.Type ~= "LevelBomber" then
				luaDelay(luaJM9PutUnit2Coord, 1, "unit", unit, "coord", savedTbl[3])
			end

			found = true
			break
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	--restore usplanes
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.NmiPlanes)) do
		local found = false
		for idx2,savedTbl in pairs(Mission.Checkpoint.UsPlanes) do
			if unit.Name == savedTbl[1] then
				luaDelay(luaJM9PutUnit2Coord, 1, "unit", unit, "coord", savedTbl[3])
			end

			found = true
			break
		end

		--Kill
		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	if Mission.Checkpoint.Kingfisher and type(Mission.Checkpoint.Kingfisher) == "table" then
		PutTo(Mission.Kingfisher, Mission.Checkpoint.Kingfisher[1])
	else
		if not Mission.Kingfisher.Dead then
			Kill(Mission.Kingfisher, true)
		end
	end

	Mission.StageInit = true
	Mission.ChckNeeded = false
	Mission.DakotaMovie = true

	luaJM9Pri4Score()
	luaDelay(luaJM9AddInput, 2.5)
end

function luaJM9PutUnit2Coord(timerThis)
-- RELEASE_LOGOFF  	luaLog("luaJM9PutUnit2Coord called")
	local unit = timerThis.ParamTable.unit
	local coord = timerThis.ParamTable.coord
	local leaderName = timerThis.ParamTable.leaderName
	--luaLog(unit.Name)
	--luaLog(coord)
	--luaLog(leaderName)
	--luaLog("\n")

	if unit and not unit.Dead then
		PutTo(unit, coord)
		if leaderName then
			local leader = FindEntity(leaderName)
			if leader and not leader.Dead then
				JoinFormation(unit, leader)
			end
		end
	end
end

function luaJM9AddInput()
	Mission.ThinkStop = false
	--SoundFade(1, "",0.1)
	Blackout(false, "", 0.5)
	EnableInput(true)
end