--SceneFile="universe\Scenes\missions\IJN\ijn_04_coral_sea.scn"
DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_CALM)
	EnableMessages(false)
	AddUntouchableUnit(FindEntity("PBY Catalina"))

 local pos = {["x"]=0, ["y"] = FindEntity("Zuiho-class 01").Class.Height+3, ["z"]=0 }
 local fx = Effect("SmallFire", pos, FindEntity("Zuiho-class 01"), 20)

	LoadMessageMap("ijndlg",4)

	Dialogues =
	{
		["Intro_A"] = {
			["sequence"] = {
				{
					["message"] = "Idlg01",
				},
				{
					["message"] = "Idlg01_1",
				},
			},
		},
		["Intro_B"] = {
			["sequence"] = {
				{
					["message"] = "Idlg02",
				},
			},
		},
		["Intro_C"] = {
			["sequence"] = {
				{
					["message"] = "Idlg03",
				},
			},
		},
		["Intro_D"] = {
		["sequence"] = {
				{
					["message"] = "Idlg04",
				},
			},
		},
	}

	MissionNarrative("ijn04.date_location")
	luaDelay(luaEngineInit, 8.5, "")

end

function luaEngineInit()
	StartDialog("Intro_dlg1", Dialogues["Intro_A"] );
	StartDialog("Intro_dlg2", Dialogues["Intro_B"] );
	StartDialog("Intro_dlg3", Dialogues["Intro_C"] );
	StartDialog("Intro_dlg4", Dialogues["Intro_D"] );
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitJM4")
	Scoring_RealPlayTimeRunning(true)
end

--ToDos

function luaInitJM4(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM04.lua"

	this.Name = "JM4"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	--maptiltas
	--ForceEnableInput(IC_MAP_TOGGLE, false)

	-- mission dolgok
	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.SqLaunched = nil
	--this.ObjRemindTime = 150
	SetSimplifiedReconMultiplier(0.5)

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

	Mission.USNCrewLvl = Mission.SkillLevel

	--reload
	SetDeviceReloadEnabled(true)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM4LoadMissionData, luaJM4GiveShohoDeck, },
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM4SaveMissionData},
	}

	Mission.JapFleet = {}
	Mission.Shoho = FindEntity("Zuiho-class 01")
	table.insert(Mission.JapFleet, Mission.Shoho)
	SetInvincible(Mission.Shoho, 0.1)
	SetAirBaseSlotCount(Mission.Shoho, 2)

	if Mission.Difficulty == 2 then
		Mission.RemainingHits = 16
		Mission.MaxHits = 16
	else
		Mission.RemainingHits = 20
		Mission.MaxHits = 20
	end
	RepairEnable(Mission.Shoho, false)

	table.insert(Mission.JapFleet, FindEntity("Mogami-class 02"))
	table.insert(Mission.JapFleet, FindEntity("Mogami-class 03"))
	table.insert(Mission.JapFleet, FindEntity("Mogami-class 04"))
	SetRoleAvailable(FindEntity("Mogami-class 02"), EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(FindEntity("Mogami-class 03"), EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(FindEntity("Mogami-class 04"), EROLF_ALL, PLAYER_AI)

	JoinFormation(FindEntity("Mogami-class 02"), Mission.Shoho)
	JoinFormation(FindEntity("Mogami-class 03"), Mission.Shoho)
	JoinFormation(FindEntity("Mogami-class 04"), Mission.Shoho)

	--SetSkillLevel(FindEntity("Mogami-class 02"), SKILL_STUN)
	--SetSkillLevel(FindEntity("Mogami-class 03"), SKILL_STUN)
	--SetSkillLevel(FindEntity("Mogami-class 04"), SKILL_STUN)

	Mission.PlayerUnit = FindEntity("Mogami-class 01")
	luaJM4EnableRecons(false)
	Mission.Fubuki = FindEntity("Fubuki-class 01")

	table.insert(Mission.JapFleet, FindEntity("Fubuki-class 01"))
	SetRoleAvailable(FindEntity("Fubuki-class 01"), EROLF_ALL, PLAYER_AI)
	JoinFormation(FindEntity("Fubuki-class 01"), Mission.Shoho)

	JoinFormation(Mission.PlayerUnit, Mission.Shoho)
	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.PlayerUnit, EROLF_AA_FLAK+EROLF_AA_MACHINEGUN+EROLF_CAPTAIN, PLAYER_ANY)
	SetSelectedUnit(Mission.PlayerUnit)
	UnitSetPlayerCommandsEnabled(Mission.PlayerUnit, PCF_NONE)
	UnitSetPlayerCommandsEnabled(Mission.PlayerUnit, PCF_TARGET)
	UnitSetPlayerCommandsEnabled(Mission.Shoho, PCF_NONE)

	luaJM4Blue(false)

	Mission.Pts = {}
		table.insert(Mission.Pts, FindEntity("PT Boat 80' Elco 01"))
		table.insert(Mission.Pts, FindEntity("PT Boat 80' Elco 02"))

	SetSkillLevel(Mission.Pts[1],Mission.SkillLevel)
	SetSkillLevel(Mission.Pts[2],Mission.SkillLevel)

	if Mission.Difficulty == 2 then
		TorpedoEnable(Mission.Pts[1],true)
		TorpedoEnable(Mission.Pts[2],true)
	end

	Mission.Mogamis = {}
		table.insert(Mission.Mogamis, FindEntity("Mogami-class 01"))
		table.insert(Mission.Mogamis, FindEntity("Mogami-class 02"))
		table.insert(Mission.Mogamis, FindEntity("Mogami-class 03"))
		table.insert(Mission.Mogamis, FindEntity("Mogami-class 04"))

	Mission.MogamiNames = {}
		table.insert(Mission.MogamiNames, "ingame.shipnames_myoko")
		table.insert(Mission.MogamiNames, "ingame.shipnames_haguro")
		table.insert(Mission.MogamiNames, "ingame.shipnames_aoba")
		table.insert(Mission.MogamiNames, "ingame.shipnames_furutaka")

	Mission.USNDogs = {}
	Mission.IJNDogs = {}
	Mission.IJNDogSpawnReq = "IJNDogSpawnReq"
	Mission.USNDogSpawnReq = "USNDogSpawnReq"
	Mission.MaxUSNDogs = 6
	Mission.MaxIJNDogs = 6

	Mission.RadarStation = FindEntity("RadarStation 01")

	Mission.Catalina = FindEntity("PBY Catalina")
	PilotRetreat(Mission.Catalina)
	SquadronSetTravelAlt(Mission.Catalina, 300)
	luaJM4AddCatalinaListener()

	Mission.IJNEscapePoint = FindEntity("IJNEscapePoint")

	Mission.USNSpawnPoint = {}
	Mission.USNSPawnDir = {}
	Mission.USAirSpawnReq = "USAirSpawnReq"
	Mission.SpawnedSquadrons = {}
	Mission.MaxUSSquadrons = 4
	Mission.Wave = 1
	--Mission.USSpawnInterval = 30
	Mission.FirstSpawn = true
	Mission.LastSpawn = 0
	--Mission.USNCrewLvl = SKILL_SPVETERAN

	Mission.Subs = {}
	Mission.SubHitByPlayer = 0

	Mission.Phase1Limit = 360
	--Mission.SubSpawnTime = 180

	Mission.PlayerHit = 0

	Mission.MissionPhase = 1
	Mission.FailMsg = ""
	Mission.SuccessMsg = "ijn04.obj_missioncompleted"

	Mission.StageSpawns = {}
		Mission.StageSpawns["IJN"] = {}
		Mission.StageSpawns["USN"] = {}
		table.insert(Mission.StageSpawns["IJN"], FindEntity("IJNPlaneSpawn 01"))
		table.insert(Mission.StageSpawns["IJN"], FindEntity("IJNPlaneSpawn 02"))
		table.insert(Mission.StageSpawns["IJN"], FindEntity("IJNPlaneSpawn 03"))
		table.insert(Mission.StageSpawns["IJN"], FindEntity("IJNPlaneSpawn 04"))

		table.insert(Mission.StageSpawns["USN"], FindEntity("USNPlaneSpawn 01"))
		table.insert(Mission.StageSpawns["USN"], FindEntity("USNPlaneSpawn 02"))
		table.insert(Mission.StageSpawns["USN"], FindEntity("USNPlaneSpawn 03"))
		table.insert(Mission.StageSpawns["USN"], FindEntity("USNPlaneSpawn 04"))

	NavigatorMoveToRange(Mission.Shoho, Mission.IJNEscapePoint)
	SetShipSpeed(Mission.Shoho,10)

	--IJN04 - 5 x Mogami -> Tone
	Mission.Unlockables = {
		["68"] = {
			"ingame.shipnames_tone",
			"ingame.shipnames_chikuma",
			"ingame.shipnames_natori",
			"ingame.shipnames_yura",
			"ingame.shipnames_abukuma",
		},
		["391"] = {
			"ingame.shipnames_tama",
			"ingame.shipnames_yura",
			"ingame.shipnames_kinu",
			"ingame.shipnames_abukuma",
			"ingame.shipnames_kuma",
		},
		["1311"] = {
			"Prinz Eugen",
			"Blucher",
			"Admiral Hippper",
			"Seydlitz",
			"Lutzow",
		},
	}

		this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Shoho",
				["Text"] = "ijn04.obj_p1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Support",
				["Text"] = "ijn04.obj_p2",
				["TextCompleted"] = "ijn04.obj_p2_comp",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Subs",
				["Text"] = "ijn04.obj_s1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "ShohoHP",
				["Text"] = "ijn04.obj_s2",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "ReconPlane",
				["Text"] = "ijn04.obj_s3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Radar",
				["Text"] = "ijn04.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["marker2"] = {
				[1] = {
				["ID"] = "markerz",
				["Text"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 0,
				["ScoreFailed"] = 0
			},
		}
	}

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()

	LoadMessageMap("ijndlg",4)

	this.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
			},
		},
		["FirstAttack"] = {
			["sequence"] = {
				{
					["message"] = "dlg2a",
				},
				{
					["message"] = "dlg2b",
				},
			},
		},
		["Wave"] = {
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
					["message"] = "dlg3e",
				},
			},
		},
		["DeckOperational"] = {
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},
		["RadarSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
			},
		},
		["RadarDestroyed"] = {
			["sequence"] = {
				{
					["message"] = "dlg6",
				},
			},
		},
		["SecFailed"] = {
			["sequence"] = {
				{
					["message"] = "dlg7",
				},
			},
		},
		["Midmission"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
				{
					["message"] = "dlg8c",
				},
			},
		},
		["ShohoDown"] = {
			["sequence"] = {
				{
					["message"] = "dlg9",
				},
			},
		},
		["Final"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},
		["PlayerHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg11",
				},
			},
		},
		["PlayerDown"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["Subs"] = {
			["sequence"] = {
				{
					["message"] = "dlg18a",
				},
				{
					["message"] = "dlg18b",
				},
			},
		},
		--radio
		["CatGotAway"] = {
			["sequence"] = {
				{
					["message"] = "dlg13",
				},
			},
		},
		["ShohoHit"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["ShohoHit2"] = {
			["sequence"] = {
				{
					["message"] = "dlg15a",
				},
				{
					["message"] = "dlg15b",
				},
			},
		},
		["SqLost"] = {
			["sequence"] = {
				{
					["message"] = "dlg16a",
				},
				{
					["message"] = "dlg16b",
				},
			},
		},
		["ShohoKilled"] = {
			["sequence"] = {
				{
					["message"] = "dlg17",
				},
			},
		},
		["LaunchDone"] = {
			["sequence"] = {
				{
					["message"] = "dlg4c",
				},
				{
					["message"] = "dlg4d",
				},
				{
					["message"] = "dlg4d_1",
				},
				--{
				--	["type"] = "callback",
				--	["callback"] = "luaJM4Pri2Completed",
				--},
			},
		},
	}


	-- music
	--SoundFade(0,"", 1)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	luaJM4InitShoho()
	luaJM4AddHitListener()
	luaJM4AddShohoListener()

	luaJM4FadeIn()
	luaJM4SetGuiNames()
	--luaDelay(luaJM4SpawnSubs, Mission.SubSpawnTime)

-- RELEASE_LOGOFF  	AddWatch("Mission.SMAccessHintActive")
-- RELEASE_LOGOFF  	AddWatch("Mission.SMUseHintActive")
	--AddWatch("Mission.RemainingHits")
	--AddWatch("Mission.MaxHits")

	--think
	SetThink(this, "luaJM4_think")

	Mission.Cheat_PhaseShift = false
end

function luaJM4_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	--luaLog(recon[PARTY_JAPANESE].own)

	if not Mission.FirstRun then
		luaJM4StartTimer()
		--luaJM4StartDialog("Recon", true)
		SetWait(this,5)
		luaDelay(luaJM4ShowCtrlHint, 5)
		luaDelay(luaJM4AAHint, 15)
		Mission.FirstRun = true
		return
	end

	Mission.SpawnedSquadrons = luaRemoveDeadsFromTable(Mission.SpawnedSquadrons)
	--luaLog("Squadrons alive "..tostring(table.getn(Mission.SpawnedSquadrons)))
	luaJM4CheckObjectives()

	local time = math.floor(GameTime())
	if Mission.MissionPhase == 1 then
		Mission.USSpawnInterval = random(60,90)
	else
		Mission.USSpawnInterval = random(70,120)
	end

	if not Mission.WaveDlg and (time - Mission.Phase1Limit) >= 60 then
		luaJM4StartDialog("Wave")
		Mission.WaveDlg = true
	end

	--kis ideig csend az elejen
	if Mission.Catalina.Dead or Mission.CatalinaRadio then
		if time - Mission.LastSpawn > Mission.USSpawnInterval or Mission.FirstSpawn then
			Mission.FirstSpawn = false
			if table.getn(Mission.SpawnedSquadrons) < Mission.MaxUSSquadrons then
				luaJM4GetUSNSpawnPoint()
			end
		end
	end

	if Mission.MissionPhase == 1 and not Mission.SubsIn then
		if Mission.Wave >= 3 then
			Mission.SpawnSuspended = true
			if not Mission.SubSpawnInit then
				luaJM4SpawnSubs()
				Mission.SubSpawnInit = true
			end
		end
	end

	if not Mission.RadarStationDetected then
		luaJM4RadarStationDetected()
	end

	if Mission.MissionPhase == 1 then
		luaJM4CheckCatalina()
		luaJM4CheckReconplanes()
		--luaJM4CheckCruiserFormation()
	elseif Mission.MissionPhase == 2 then
		luaJM4CheckReconplanes()
		luaJM4CheckUnitChange()
	elseif Mission.MissionPhase == 3 then
		--luaJM4CheckStageDogfight()
	end

	if Mission.SubsIn then
		luaJM4CheckSubs()
	end

	luaJM4CheckPts()


end

function luaJM4GetUSNSpawnPoint()

	if Mission.Shoho.Dead then
		return
	end

	if Mission.SpawnSuspended or Mission.EndIsNear then
		if SpawnNewIDIsRequested(Mission.USAirSpawnReq) then
			SpawnNewIDRemove(Mission.USAirSpawnReq)
		end

		return
	end

	if SpawnNewIDIsRequested(Mission.USAirSpawnReq) then
		--luaLog("Spawning...")
		return
	end

	local pos = GetPosition(Mission.Shoho)

	local newposTbl,_dummy
	if Mission.MissionPhase == 1 then
		newposTbl,_dummy = luaJM4GetPossiblePositions(pos,3500)
	else
		newposTbl,_dummy = luaJM4GetPossiblePositions(pos,5500)
	end

	for idx,newpos in pairs(newposTbl) do
		if luaIsVisibleCoordinate(Mission.Shoho,newpos,2000) then
			--luaLog("coordinate is visible")
		elseif IsInBorderZone(newpos) then
			--luaLog("coordinate is in borderzone")
		else
			--luaLog("setting usn spawnpoint")
			Mission.USNSpawnPoint = newpos
			--Mission.USNSPawnDir = newDirTbl[idx]
			--luaLog(Mission.USNSpawnPoint)
			--luaLog(Mission.USNSPawnDir)
			luaJM4SpawnNmi()
			return
		end
	end

	--luaLog("Bad spawnpoints, spawning form borderzone")
	Mission.USNSpawnPoint = GetClosestBorderZone(GetPosition(Mission.Shoho))
	luaJM4SpawnNmi()
end

function luaJM4GetPossiblePositions(pos,modifier)
	local tbl = {}
	local tbl2 = {}	--mar nem kell

	local numPoints = 15
	local x
	local z

	for i=1,numPoints do
		x = pos.x + modifier * math.cos(i * (2 * math.pi)/numPoints)
		z = pos.z + modifier * math.sin(i * (2 * math.pi)/numPoints)
		table.insert(tbl, {["x"]=x, ["y"]=100, ["z"]=z})
		table.insert(tbl2, {pos.x-x, pos.z-z})
	end

	return tbl,tbl2
end

function luaJM4SpawnNmi()

	if Mission.TutObjNotCompl then
		Mission.USNCrewLvl = SKILL_ELITE
	else
		Mission.USNCrewLvl = Mission.SkillLevel
	end

	local grpTbl = {
		[1] = {
			["Type"] = 333,
			["Name"] = "TBD Devastator",
			["Crew"] = Mission.USNCrewLvl,
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
		[2] = {
			["Type"] = 332,
			["Name"] = "SBD Dauntless",
			["Crew"] = Mission.USNCrewLvl,
			["Race"] = USA,
			["WingCount"] = 3,
			["Equipment"] = 1,
		},
	}

	local rnd1

	if Mission.Difficulty == 0 then
		rnd1 = random(1,3)
	elseif Mission.Difficulty == 1 then
		rnd1 = random(1,4)
	elseif Mission.Difficulty == 2 then
		rnd1 = random(1,6)
	end
	--luaLog("rnd1: no of squadrons: "..tostring(rnd1))

	local rnd2 = random(1,100)
	--luaLog("rnd2: type of squadrons: "..tostring(rnd2))

	local typeTble = {}
	local spawnTable = {}

	if rnd2 <= 50 then
		typeTble = grpTbl[1]
		Mission.USNSpawnPoint.y = 50
	else
		typeTble = grpTbl[2]
		Mission.USNSpawnPoint.y = 100
	end

	for i=1,rnd1 do
		table.insert(spawnTable, typeTble)
	end

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = spawnTable,
	["area"] = {
		["refPos"] = Mission.USNSpawnPoint,
		["angleRange"] = { luaJM4RAD(0), luaJM4RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = GetPosition(Mission.Shoho),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
	 	["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM4USAirGroupSpawned",
	["id"] = Mission.USAirSpawnReq,
})
end

function luaJM4RAD(x)
	return x *  0.0174532925
end

function luaJM4USAirGroupSpawned(...)
	local i = 0

	for i,v in ipairs(arg) do

		--if Mission.TutObjNotCompl then
		--	SetInvincible(v, 0.1)
		--end

		local trg
		if Mission.MissionPhase < 3 then

			if i == 1 then
				trg = Mission.Shoho
				i = i + 1
			else
				trg = luaPickRnd(luaSumTablesIndex({Mission.Shoho}, {Mission.PlayerUnit}, luaRemoveDeadsFromTable(Mission.JapFleet)))
			end

		else

			trg = Mission.Shoho

		end
		PilotSetTarget(v, trg)

		if v.Class.Type == "TorpedoBomber" then
			SquadronSetTravelAlt(v, 20)
			SquadronSetAttackAlt(v, 20)
			--luaLog("TB spawned")
		elseif v.Class.Type == "DiveBomber" then
			SquadronSetTravelAlt(v, 100)
			SquadronSetAttackAlt(v, 100)
			--luaLog("DB spawned")
		end
		table.insert(Mission.SpawnedSquadrons, v)

		if not Mission.TutObjNotCompl then
			SetSkillLevel(v, Mission.USNCrewLvl)
		else
			SetSkillLevel(v, SKILL_ELITE)
		end
		SetForcedReconLevel(v, 2, PARTY_JAPANESE)

	end
	Mission.LastSpawn = math.floor(GameTime())

	if not Mission.FirstAttack then
		luaJM4StartDialog("FirstAttack")
		Mission.FirstAttack = true
		--luaJumpinMovieSetCurrentMovie("GoAround",Mission.SpawnedSquadrons[1].ID)
		luaJM4AirstrikeMovie(Mission.SpawnedSquadrons[1])
		luaDelay(luaJM4USRadio1, 180)
	end

	Mission.Wave = Mission.Wave + 1
	if Mission.Wave == 2 then
		luaJM4SetMaxSquads(5)
	elseif Mission.Wave == 3 then
		luaJM4SetMaxSquads(6)
	elseif Mission.Wave == 4 then
		luaJM4SetMaxSquads(7)
	elseif Mission.Wave == 5 then
		luaJM4SetMaxSquads(8)
	end
end

function luaJM4StepPhase(phase)
	if phase and type(phase) == "number" then
		Mission.MissionPhase = phase
	elseif not phase then
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
	--MissionNarrativeEnqueue("MissionPhase Step")
end

function luaJM4GiveShohoDeck()
	if not luaObj_IsActive("primary",2) then
		luaObj_Add("primary",2)
    --DisplayScores(666,0,"ijn04.obj_p2","ijn07.hint_6_desc")
    --DisplayScores(666,0,"ijn04.obj_p2","")
    luaJM4Pri2Bubble()
		luaDelay(luaJM4CheckTutCompl, 120)
	end
	luaJM4DestroyShohoEfx()
	PermitSupportmanager()
	--if luaObj_GetSuccess("secondary",1) == nil then
	--luaJM4DCHint()
	luaDelay(luaJM4SMHintDelayed,10)

	--luaDelay(luaJM4SMHint, 90)
	if Mission.SubsIn then
		if next(Mission.Subs) and not Mission.Subs[1].Dead then
			luaDelay(luaJM4DCHint, 60)
		end
	end
end

function luaJM4Pri2Bubble()
	DisplayScores(666,0,"ijn04.obj_p2","")
end

function luaJM4CheckObjectives()

	if Mission.PlayerHit > 3 and not Mission.MissionFailed then
		luaJM4StartDialog("PlayerHit")
		--luaObj_FailedAll()
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn04.hit_own"
		luaJM4StepPhase(99)
	end

	if Mission.PlayerUnit.Dead then
		if Mission.MissionPhase == 1 and not Mission.MissionFailed then
			luaJM4StartDialog("PlayerDown")
			Mission.FailMsg = "ijn04.obj_missionfailed_2"
			--luaObj_FailedAll()
			Mission.PlayerDead = true
			Mission.MissionFailed = true
			luaJM4StepPhase(99)
		elseif Mission.MissionPhase > 2 then

			local planes = luaSumTablesIndex(recon[PARTY_JAPANESE].own.fighter, recon[PARTY_JAPANESE].own.divebomber)
			for idx,unit in pairs(planes) do
				if not unit.Dead and luaGetType(unit) == "plane" then
					if not IsUnitSelectable(unit) then
						SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
					end
					SetSelectedUnit(unit)
					Mission.PlayerUnit = unit
				end
			end

		end
	end

	if Mission.PlayerPlane and Mission.PlayerPlane.Dead then
		--luaJM4ShowTakeOff()

		local squads,squadTbl = luaGetSlotsAndSquads(Mission.Shoho)
		local SMNeeded = true
		if squads and squads > 0 then
			Mission.PlayerPlane = squadTbl[1]
			SMNeeded = false
			luaDelay(luaJM4DelayedSelect, 2)
		end

		if SMNeeded and not Mission.ShohoEnabledForSM and luaJM4StockCheck() then
			luaJM4EnableShohoDeck()
		end

	end

	if not luaJM4StockCheck() and not Mission.MissionFailed then
		Mission.MissionFailed = true
		Mission.ShohoDead = true
		Mission.FailMsg = "ijn04.obj_missionfailed_4"
		luaJM4StepPhase(99)
	end

	if not luaObj_IsActive("primary",1) then
		luaObj_Add("primary",1)
		luaJM4StartDialog("Init")
		luaDelay(luaJM4Pri1Score, 3)
	else
		if luaObj_GetSuccess("primary",1) == nil then
			if Mission.Shoho.Dead then
				luaJM4StartDialog("ShohoDown")
				luaJM4StartDialog("ShohoKilled")
				luaObj_Failed("primary",1,true)
				Mission.MissionFailed = true
				Mission.ShohoDead = true
				Mission.FailMsg = "ijn04.obj_missionfailed_3"
				luaJM4StepPhase(99)
			else

				luaJM4Pri1Score()

				if not Mission.EndIsNear and luaGetDistance(Mission.Shoho, Mission.IJNEscapePoint) < 3500 then
					Mission.EndIsNear = true
					luaJM4EliteFighters()
					--luaLog("endisnear")
				elseif Mission.EndIsNear and luaGetDistance(Mission.Shoho, Mission.IJNEscapePoint) < 2500 then
					if not luaJM4CheckEndConds() then
						luaObj_Completed("primary",1)
						Mission.MissionSuccess = true
						luaJM4StepPhase(99)
					end
				end

			end
		end
	end

	if not luaObj_IsActive("secondary",2) and Mission.FirstAttack then
		luaObj_Add("secondary",2)
	elseif luaObj_IsActive("secondary",2) then
		if luaObj_GetSuccess("secondary",2) == nil and Mission.SecFailed then
			luaObj_Failed("secondary",2)
			luaJM4StartDialog("SecFailed")
			MissionNarrative("ijn04.obj_s2_failed")
		end
	end

	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	end

	if Mission.RadarStation.Dead and luaObj_GetSuccess("hidden",1) == nil then
		luaObj_Completed("hidden",1)
		luaJM4StartDialog("RadarDestroyed")
		luaJM4LowerSpawnCrewLvl()
		MissionNarrative("ijn04.obj_h1_completed")
	end

	if Mission.SubsIn then

		if not luaObj_IsActive("secondary",3) then
			luaObj_Add("secondary",3)
			luaJM4EnableRecons(true)
			--luaJM4CheckMapCmds()
			luaDelay(luaJM4RPHint,15)
			--luaDelay(luaJM4RPHint2,35)
		elseif luaObj_IsActive("secondary",3) and luaObj_GetSuccess("secondary",3) == nil then
			if Mission.MissionPhase == 1 and not Mission.PlayerUnit.Dead then
				local num = GetNumCatapulted(Mission.PlayerUnit)
				if num > 0 then
					luaObj_Completed("secondary",3)
					HideHint()
					if not luaObj_IsActive("secondary",1) then
						luaObj_Add("secondary",1)
						luaJM4RPHint2()
					end

					if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
						for idx,unit in pairs(Mission.Subs) do
							luaObj_AddUnit("secondary",1,unit)
							--SetInvincible(unit, false)
						end
					end

				end
			else
				luaObj_Failed("secondary",3)
			end
		end

			if luaObj_IsActive("secondary",1) then

			if luaObj_GetSuccess("secondary",1) == nil then
				if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 0 then
					if not TrulyDead(Mission.Subs[1]) then
						luaJM4SubDeadMovie(Mission.Subs[1])
					end
					luaObj_Completed("secondary",1)
					luaJM4AddPowerup("evasive_manoeuvre")

				else

					if not Mission.Sec3CheckInProgress and not Mission.PlayerUnit.Dead then

						local num = GetNumCatapulted(Mission.PlayerUnit)
						if num >= 3 then

							local needToCheck = true
							for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
								if not unit.Dead and GetPlaneEquipment(unit) ~= 0 then
									needToCheck = false
									break
								end
							end

							if needToCheck then
								luaDelay(luaJM4Sec3Check, 5)
								Mission.Sec3CheckInProgress = true
							end
						end
					end
				end
			end
		end
	end

	--reminders
	if luaObj_IsActive("secondary",3) and luaObj_GetSuccess("secondary",3) == nil then

		if not Mission.Reminder1Registered then

			if Mission.Reminder3Registered then
				luaObj_RemoveReminder("primary",1)
				Mission.Reminder3Registered = nil
			end
			if Mission.Reminder2Registered then
				luaObj_RemoveReminder("secondary",1)
				Mission.Reminder2Registered = nil
			end

			luaObj_AddReminder("secondary",3)
			Mission.Reminder1Registered = true

		end

	elseif not luaObj_IsActive("secondary",3) or luaObj_GetSuccess("secondary",3) ~= nil then

		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			if Mission.Reminder3Registered then
				luaObj_RemoveReminder("primary",1)
				Mission.Reminder3Registered = nil
			end
			if Mission.Reminder1Registered then
				luaObj_RemoveReminder("secondary",3)
				Mission.Reminder1Registered = nil
			end
			if not Mission.Reminder2Registered then
				luaObj_AddReminder("secondary",1)
				Mission.Reminder2Registered = true
			end
		else
			if Mission.Reminder1Registered then
				luaObj_RemoveReminder("secondary",3)
				Mission.Reminder1Registered = nil
			end
			if Mission.Reminder2Registered then
				luaObj_RemoveReminder("secondary",1)
				Mission.Reminder2Registered = nil
			end
			if not Mission.Reminder3Registered then
				luaObj_AddReminder("primary",1)
				Mission.Reminder3Registered = true
			end
		end

	end

	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		if luaJM4Pri2() then
			luaJM4Pri2Completed()
			luaJM4StartDialog("LaunchDone")
		end
	end

	luaObj_Reminder()

	if Mission.MissionPhase == 99 then
		if Mission.ShohoListenerActive and not Mission.Shoho.Dead then
			RemoveListener("hit", "shohohit")
			Mission.ShohoListenerActive = false
		end
		if Mission.MissionFailed then
			HideUnitHP()
			if Mission.PlayerDead then
				luaMissionFailedNew(Mission.PlayerUnit, Mission.FailMsg)
			elseif Mission.ShohoDead then
				luaMissionFailedNew(Mission.Shoho, Mission.FailMsg)
			end
			luaJM4StepPhase()
		elseif Mission.MissionSuccess then
			luaJM4StepPhase()
			luaJM4StartDialog("Final",true)
			if not Mission.SecFailed and luaObj_GetSuccess("secondary",2) == nil then
				luaObj_Completed("secondary",2)
			elseif Mission.SecFailed then
				luaObj_Failed("secondary",2)
			end

			--if luaObj_GetSuccess("secondary",2) then
				--luaJM4StartDialog("MajorVictory")
			--elseif not luaObj_GetSuccess("secondary",2) then
			--	luaJM4StartDialog("MinorVictory")
			--end

			if Mission.RadarStation.Dead and luaObj_GetSuccess("secondary",2) then
				--luaJM4StartDialog("MajorVictory")
-- RELEASE_LOGOFF  				luaLog("gold")
			elseif not Mission.RadarStation.Dead and luaObj_GetSuccess("secondary",2) then
				--luaJM4StartDialog("MinorVictory")
-- RELEASE_LOGOFF  				luaLog("silver")
			else
-- RELEASE_LOGOFF  				luaLog("bronze")
			end
			luaDelay(luaJM4CompleteMission, 10)
			luaJM4StepPhase()
		end
	end
end

function luaJM4CompleteMission()
	HideUnitHP()
	luaMissionCompletedNew(Mission.Shoho, Mission.SuccessMsg)

	local medal = luaGetMedalReward()
	if medal == MEDAL_SILVER then
		Scoring_GrantBonus("JM4_SCORING_SILVER", "ijn04.bonus1_title", "ijn04.bonus1_text", 158)
	elseif medal == MEDAL_GOLD then
		Scoring_GrantBonus("JM4_SCORING_GOLD", "ijn04.bonus2_title", "ijn04.bonus2_text", 158)
		--Scoring_GrantBonus("JM4_SCORING_GOLD", "ijn04.bonus1_title", "ijn04.bonus1_text", 158)
	end

end

function luaJM4InitShoho()
	SetRoleAvailable(Mission.Shoho, EROLF_ALL, PLAYER_AI)
	BannSupportmanager()
	--local pos = GetPosition(Mission.Shoho)
	--pos.z = pos.z - (Mission.Shoho.Class.Length/4)
	--pos.y = Mission.Shoho.Class.Height
	local pos = {["x"]=0, ["y"] = Mission.Shoho.Class.Height, ["z"]=0 }

	Mission.ShohoEfx = Effect("SmallFire", pos, Mission.Shoho, 60)
end

function luaJM4LowerSpawnCrewLvl()
	Mission.USNCrewLvl = SKILL_SPNORMAL
end

function luaJM4AddHitListener()
	AddListener("hit", "fleethit", {
		["callback"] = "luaJM4FleetHitByPlayer", -- callback fuggveny
		["target"] = Mission.JapFleet, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"HEAVYARTILLERY","TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
		Mission.ListenerActive = true
end

function luaJM4FleetHitByPlayer(...)
	--for i,v in ipairs(arg) do
-- RELEASE_LOGOFF  	--	luaLog("ARG"..tostring(i))
-- RELEASE_LOGOFF  	--	luaLog("Type "..tostring(type(v)))
-- RELEASE_LOGOFF  	--	luaLog(v)
	--end
	if Mission.PlayerHit > 3 then
		if Mission.ListenerActive then
			RemoveListener("hit","fleethit")
			Mission.ListenerActive = false
		end
		return
	end
	--MissionNarrativeEnqueue("ijn04.hit_own")
	Mission.PlayerHit = Mission.PlayerHit + 1
end

function luaJM4SpawnSubs()
	SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = 31,
					["Name"] = "Grunion",--"Nautilus",
					["Crew"] = Mission.SkillLevel,
					["Race"] = USA,
				},
				--{
				--	["Type"] = 31,
				--	["Name"] = "Narwhal",
				--	["Crew"] = 1,
				--	["Race"] = USA,
				--},
			},
			["area"] = {
				["refPos"] = GetPosition(FindEntity("SubSpawnPoint")),
				["angleRange"] = {luaJM4RAD(0),luaJM4RAD(90)},
				["lookAt"] = GetPosition(Mission.Shoho),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM4SubsSpawned",
		})

end

function luaJM4SubsSpawned(unit1)
	SetForcedReconLevel(unit1, 2, PARTY_JAPANESE)
	--SetForcedReconLevel(unit2, 0, PARTY_JAPANESE)
	table.insert(Mission.Subs, unit1)
	--table.insert(Mission.Subs, unit2)
	SetNumbering(unit1, 0)
	SetSubmarineDepthLevel(Mission.Subs[1],1)
	luaJM4AddSubListener()
	SetGuiName(unit1, "ingame.shipnames_grunion")
	NavigatorAttackMove(unit1, Mission.Shoho, {})
	Mission.SubsIn = true
	Mission.SpawnSuspended = false
	luaDelay(luaJM4SubMovie,10)
	luaDelay(luaJM4SubDialog,11.5)
	SetSkillLevel(unit1, Mission.SkillLevel)
	--SetInvincible(unit1, 0.1)
end

function luaJM4CheckSubs()
	Mission.Subs = luaRemoveDeadsFromTable(Mission.Subs)
	if table.getn(Mission.Subs) == 0 then
		return
	end

	if Mission.SubRetreat then

		for idx,unit in pairs(Mission.Subs) do
			if not unit.Dead then
				if GetSubmarineDepthLevel(unit) == 4 then
					Kill(unit, true)
					if luaObj_GetSuccess("secondary",1) == nil then
						luaObj_Failed("secondary",1)
						MissionNarrative("ijn04.obj_s1_failed")
					end
				end
			end
		end

	else

		for idx,unit in pairs(Mission.Subs) do
			if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
				local nmi = luaRemoveDeadsFromTable(Mission.JapFleet)
				local ship = luaPickRnd(nmi)
				luaSetScriptTarget(unit,ship)
				NavigatorAttackMove(unit, ship, {})
			end
		end

	end

end

function luaJM4SetMaxSquads(num)
	Mission.MaxUSSquadrons = num
end

function luaJM4StartDialog(dialogID, log)
-- dialog indito wrapper

	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM4StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM4StartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	if Mission.Dialogues[dialogID].printed then
		return
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])
	Mission.Dialogues[dialogID].printed = true
	Mission.LastDialog = math.floor(GameTime())

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

function luaJM4SubDialog()
	luaJM4StartDialog("Subs",true)
end

function luaJM4StartTimer()
	Countdown("ijn04.hint_timer", 1, Mission.Phase1Limit, "luaJM4Phase1End")
end

function luaJM4Phase1End()
	--luaJM4GiveShohoDeck()
	luaJM4StartDialog("DeckOperational",true)
	luaJM4SetMaxSquads(6)
	HideHint()

	luaJM4StepPhase()
	Mission.SpawnSuspended = true
end

function luaJM4AddCatalinaListener()
AddListener("kill", "CatalinaKill", {
		["callback"] = "luaJM4CatalinaKilled",  -- callback fuggveny
		["entity"] = {Mission.Catalina}, -- entityk akiken a listener aktiv
		["lastAttacker"] = {Mission.PlayerUnit},  -- tamado entitas, vagy entitasok
		["lastAttackerPlayerIndex"] = {PLAYER_1,PLAYER_AI}, -- PLAYER_1..PLAYER_32
		})
		Mission.CatalinaListener = true
end

function luaJM4CatalinaKilled()
	AddPowerup({
		["classID"] = "improved_shells",
		["useLimit"] = 1,
	})
end

function luaJM4AddShohoListener()
	AddListener("hit", "shohohit", {
		["callback"] = "luaJM4ShohoHit", -- callback fuggveny
		["target"] = {Mission.Shoho}, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"BOMB","TORPEDO"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
		Mission.ShohoListenerActive = true
end

function luaJM4ShohoHit()
	if not Mission.ShohoRadio then
		luaJM4StartDialog("ShohoHit",true)
		Mission.ShohoRadio = true
	end

	Mission.RemainingHits = Mission.RemainingHits - 1

	if not Mission.SecFailed and (Mission.RemainingHits / Mission.MaxHits) <= 0.5  then
		luaJM4StartDialog("ShohoHit2",true)
		Mission.SecFailed = true
	end

	--MissionNarrativeUrgent("ijn04.hits_left")
	if Mission.Difficulty == 2 then
		SetInvincible(Mission.Shoho, 0.0625*Mission.RemainingHits)
	else
		SetInvincible(Mission.Shoho, 0.05*Mission.RemainingHits)
	end
	if Mission.RemainingHits == 0 then
		SetInvincible(Mission.Shoho, false)
		SetDeadMeat(Mission.Shoho)
		if Mission.ListenerActive then
			RemoveListener("hit", "fleethit")
			Mission.ListenerActive = false
		end
	end
end

function luaJM4CheckStageDogfight()

	if Mission.EndIsNear then
		return
	end

	Mission.USNDogs = luaRemoveDeadsFromTable(Mission.USNDogs)
	Mission.IJNDogs = luaRemoveDeadsFromTable(Mission.IJNDogs)

	if table.getn(Mission.USNDogs) < Mission.MaxUSNDogs then
		if not SpawnNewIDIsRequested(Mission.USNDogSpawnReq) then
			luaJM4SpawnUSNDog()
		end
	end

	if table.getn(Mission.IJNDogs) < Mission.MaxIJNDogs then
		if not SpawnNewIDIsRequested(Mission.IJNDogSpawnReq) then
			luaJM4SpawnIJNDog()
		end
	end

	local sum = luaSumTables(luaRemoveDeadsFromTable(Mission.USNDogs),luaRemoveDeadsFromTable(Mission.IJNDogs))
	for idx,unit in pairs(sum) do
		if unit and (not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead) then
			luaJM4TargetDogs(unit)
		end
	end
end

function luaJM4SpawnUSNDog()
	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 101,
			["Name"] = "F4F Wildcat",
			["Crew"] = Mission.SkillLevel,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(luaPickRnd(Mission.StageSpawns["USN"])),
		["angleRange"] = { luaJM4RAD(0), luaJM4RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = GetPosition(FindEntity("IJNPlaneSpawn 04")),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM4SpawnUSNDogSpawned",
	["id"] = Mission.USNDogSpawnReq,
})
end

function luaJM4SpawnUSNDogSpawned(unit)
	table.insert(Mission.USNDogs, unit)
	luaJM4TargetDogs(unit)
	SetSkillLevel(unit, Mission.SkillLevel)
end

function luaJM4SpawnIJNDog()
	SpawnNew({
	["party"] = PARTY_JAPANESE,
	["groupMembers"] = {
		{
			["Type"] = 150,
			["Name"] = "A6M Zero",
			["Crew"] = Mission.SkillLevel,
			["Race"] = JAPAN,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(luaPickRnd(Mission.StageSpawns["IJN"])),
		["angleRange"] = { luaJM4RAD(0), luaJM4RAD(180)},
		--["direction"] = Mission.USNSPawnDir,
		["lookAt"] = GetPosition(FindEntity("USNPlaneSpawn 04")),
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM4SpawnIJNDogSpawned",
	["id"] = Mission.IJNDogSpawnReq,
})
end

function luaJM4SpawnIJNDogSpawned(unit)
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	table.insert(Mission.IJNDogs, unit)
	luaJM4TargetDogs(unit)
	SetSkillLevel(unit, Mission.SkillLevel)
end

function luaJM4TargetDogs(unit)

	if unit.Party == PARTY_JAPANESE then

		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USNDogs))
		if trg and not trg.Dead then
			luaSetScriptTarget(unit, trg)
			PilotSetTarget(unit, trg)
		else
			PilotMoveToRange(unit, FindEntity("IJNPlaneSpawn 04"))
		end

	elseif unit.Party == PARTY_ALLIED then

		local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.IJNDogs))
		if trg and not trg.Dead then
			PilotSetTarget(unit, trg)
		else
			PilotMoveToRange(unit, FindEntity("IJNPlaneSpawn 04"))
		end

	end
end

function luaJM4CheckPts()
	if Mission.PtsDead then
		return
	end

	Mission.Pts = luaRemoveDeadsFromTable(Mission.Pts)
	local num = table.getn(Mission.Pts)
	if num == 0 then
		Mission.PtsDead = true
		return
	end

	local nmi = luaGetShipsAround(Mission.Pts[1], 2500, "enemy")
	local nmi2 = luaGetPlanesAround(Mission.Pts[1], 2500, "enemy")

	if nmi and next(nmi) ~= nil then
		local _dummy,trg = next(nmi)
		for idx,unit in pairs(Mission.Pts) do
			if not luaGetScriptTarget(unit) or luaGetScriptTarget(unit).Dead then
				TorpedoEnable(unit, true)
				NavigatorAttackMove(unit, trg, {})
				luaSetScriptTarget(unit, trg)
				unit.attacking = true
			end
		end
	elseif not nmi or nm2 then
		for idx,unit in pairs(Mission.Pts) do
			if unit.attacking or unit.attacking == nil then
				local path = {"pt_path1","pt_path2"}
				NavigatorMoveOnPath(unit, FindEntity(luaPickRnd(path)), PATH_FM_CIRCLE, PATH_SM_JOIN)
				unit.attacking = false
			end
		end
	end
end

function luaJM4NoShips()
	SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.PlayerPlane, EROLF_ALL, PLAYER_1)
	SetSelectedUnit(Mission.PlayerPlane)
	SetInvincible(Mission.PlayerPlane, false)
	JoinFormation(Mission.PlayerUnit, Mission.Shoho)
	luaJM4StepPhase()
	luaJM4GiveShohoDeck()
	EnableInput(true)
	Mission.SpawnSuspended = false

	Blackout(true, "luaJM4Checkpoint1", 1)
end

function luaJM4Checkpoint1()
	luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM4CheckUnitChange()
	if Mission.ChangeReady and Mission.PlayerPlane then
		--luaLog("return")
		return
	end

	local squads,squadTbl = luaGetSlotsAndSquads(Mission.Shoho)
	--luaLog("-----------")
	--luaLog(squads)
	--luaLog(squadTbl)

	if squads < 1 then
		if IsReadyToSendPlanes(Mission.Shoho) and GetAirBaseStatus(Mission.Shoho) == 0 then
			LaunchSquadron(Mission.Shoho, 150, 3)
		end
	elseif squads == 1 and not Mission.PlayerPlane then
		Mission.PlayerPlane = squadTbl[1]
		SetInvincible(Mission.PlayerPlane, true)
	end

	--luaLog(Mission.PlayerPlane)

	--local planes = luaGetPlanesAround(Mission.PlayerUnit, 2500, "enemy")
	--luaLog("----")
	--luaLog(planes)

	--if table.getn(luaRemoveDeadsFromTable(Mission.SpawnedSquadrons)) == 0 or not planes then
		luaJM4StartDialog("Midmission",true)
		Mission.ChangeReady = true
	--end

	if Mission.ChangeReady and Mission.PlayerPlane then
		luaDelay(luaJM4ShowPlane,3)
		luaJM4Blue(true)
		--luaJM4RestrictReconplanes()
	end
end

function luaJM4ShowPlane()
	EnableInput(false)
	luaJM4DestroyShohoEfx()

	local pos1 =  {
		["postype"]="cameraandtarget",
			["position"]= {
			["terrainavoid"] = true,
			["parentID"] = Mission.PlayerPlane.ID,
			["modifier"] = {
				["name"] = "goaround",
				["radius"] = {24, 8, 18, 12, 9},
				["radiuslinearblend"] = 0.3,
				["theta"] = {15, 8, 10, 12, 5, },
				["thetalinearblend"] = 0.3,
				["rho"] = {180, 12, -130,  },
				["rholinearblend"] = 0.5,
			}
		},
		["transformtype"]="keepz",
		["starttime"]=0.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["zoom"] = 0.8,
		}
	MovCamNew_AddPosition(pos1)

	local pos2 =  {
		["postype"]="cameraandtarget",
		["position"]= {
			["terrainavoid"] = true,
		},
		["transformtype"]="keepz",
		["starttime"]=10.0,
		["blendtime"]=0.0,
		["linearblend"]=0.0,
		["wanderer"]=true,
		["smoothtime"]=2.0,
		["zoom"] = 1,
		["finishscript"] = "luaJM4NoShips",
	}
	MovCamNew_AddPosition(pos2)
end

function luaJM4AddSubListener()
	AddListener("hit", "subhit", {
		["callback"] = "luaJM4Subhit", -- callback fuggveny
		["target"] = Mission.Subs, -- entityk akiken a listener aktiv
		["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
		["attacker"] = {}, -- tamado entityk
		["attackType"] = {"DEPTHCHARGE"}, -- BulletClasses.lua-ban a "Type" kulcsnal lathato pl Artillery ("" nelkul)
		["attackerPlayerIndex"] = {PLAYER_1}, -- PLAYER_1..PLAYER_32
		["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
		["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
		["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM4Subhit()
	Mission.SubHitByPlayer = Mission.SubHitByPlayer + 1
	if Mission.SubHitByPlayer == 2 then
		RemoveListener("hit", "subhit")
		--SetDamagedGFXLevel(Mission.Subs[1], 1)
		ExplodeToParts(Mission.Subs[1])
		SetDeadMeat(Mission.Subs[1])
	end
end

function luaJM4AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
end

function luaJM4FadeIn()
	luaCheckSavedCheckpoint()

	if not Mission.CheckpointLoaded then
		--SoundFade(1, "",0.1)
		Blackout(false, "", 0.5)
	end
end

function luaJM4RadarStationDetected()
	if Mission.RadarStationDetected then
		return
	end
	for idx,unit in pairs(recon[PARTY_JAPANESE].enemy.landfort) do
		if unit.ID == Mission.RadarStation.ID then
			Mission.RadarStationDetected = true
			luaJM4StartDialog("RadarSpotted")
			luaDelay(luaJM4RadarMovie,10)
			break
		end
	end
end

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(31)
	PrepareClass(101)
	--PrepareClass(112)
	PrepareClass(171)
	PrepareClass(150)
	PrepareClass(332)
	PrepareClass(333)
	Loading_Finish()
end

function luaJM4SetGuiNames()
	--luaLog("allitom a guineveket")

	--SetGuiName(Mission.Catalina, "PBY Catalina")
	SetGuiName(Mission.Fubuki, "ingame.shipnames_fubuki")
	SetGuiName(Mission.Pts[1], "ingame.shipnames_pt|.19")
	SetGuiName(Mission.Pts[2], "ingame.shipnames_pt|.24")
	SetGuiName(Mission.Shoho, "ingame.shipnames_shoho")

	for idx, unit in pairs(Mission.Mogamis) do

		--local oldID = unit.Class.ID
		--luaLog("----------")
		--luaLog(oldID)
		--luaLog(unlID)

		if IsClassChanged(unit.Class.ID) then
-- RELEASE_LOGOFF  			luaLog("changed class :"..tostring(unit.Class.ID))
			for idx2,unl in pairs(Mission.Unlockables) do
-- RELEASE_LOGOFF  				luaLog("unlock id "..tostring(idx2))
				if tostring(unit.Class.ID) == idx2 then
					SetGuiName(unit,unl[idx])
					break
				else
					SetGuiName(unit, unit.Class.Name)
				end
			end

		else
			SetGuiName(unit, Mission.MogamiNames[idx])
		end

	end
end

function luaJM4AAHint()
	--local str ="HINT: The more guns are able to fire the more effective your AA is.  Turn to broad side."
	--MissionNarrativeUrgent(str)
	ShowHint("IJN04_Hint01")
end

function luaJM4RPHint()
	ShowHint("IJN04_Hint02")
end

function luaJM4RPHint2()
	ShowHint("Advanced_Hint_Sonar")
end

function luaJM4DCHint()
	ShowHint("IJN04_Hint03")
end

function luaJM4SMHint()
	RemoveStoredHint("IJN04_Hint04")
	ShowHintForced("IJN04_Hint04")
	--luaDelay(luaJM4SMHint, random(60,90))
end

function luaJM4SMHintDelayed()
	if luaObj_GetSuccess("primary",2) == nil then
		RemoveStoredHint("IJN04_Hint04")
		ShowHintForced("IJN04_Hint04")
	end
end

function luaJM4CheckCatalina()
	if Mission.Catalina.Dead or Mission.CatalinaRadio then
		return
	end

	local shipsAround = luaGetShipsAround(Mission.Catalina, 2500, "enemy")
	if not shipsAround then
		luaJM4StartDialog("CatGotAway")
		Mission.CatalinaRadio = true
	end
end

function luaJM4USRadio1()
	luaJM4StartDialog("SqLost",true)
end

function luaJM4EnableRecons(enable)
	ForceEnableInput(IC_SHIP_LAUNCHUNIT, enable)
end

function luaJM4RestrictReconplanes()
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
		if not unit.Dead then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
			if not Mission.Shoho.Dead then
				PilotMoveToRange(unit, Mission.Shoho)
			end
		end
	end
end

function luaJM4Sec3Check()
	Mission.Sec3CheckInProgress = nil
	if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) ~= 0 and luaObj_GetSuccess("secondary",3) == nil then
		luaObj_Failed("secondary",3)
	end
	luaDelay(luaJM4SubRetreat, 60)
end

function luaJM4SubRetreat()

	for idx,unit in pairs(Mission.Subs) do
		if not unit.Dead then
			UnitSetFireStance(unit, STANCE_HOLDFIRE)
			SetUnlimitedAirSupply(unit, true)
			SetSubmarineDepthLevel(unit, 4)
			ClearForcedReconLevel(unit, PARTY_JAPANESE)
		end
	end
	Mission.SubRetreat = true
end

function luaJM4StockCheck()
	if not Mission.Shoho or Mission.Shoho.Dead then
		return false
	end

	if next(GetProperty(Mission.Shoho,"stock")) then
		return true
	end
	return false
end

function luaJM4Pri1Score()
	DisplayUnitHP({Mission.Shoho}, "ijn04.obj_p1")
end

function luaJM4SubMovieEnd()
	EnableInput(true)

	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetSelectedUnit(Mission.MovieUnit)
	else
		if Mission.MissionPhase == 1 then
			SetSelectedUnit(Mission.PlayerUnit)
		else
			luaJM4CheckUnitChange()
		end
	end
end

--[[
function luaJM4ShowTakeOff()
	AddListener("input", "movielistenerID", {
		["callback"] = "luaJM4EndTakeOff",  -- callback fuggveny
		["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
		["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
	})

	if luaJM4StockCheck() and IsReadyToSendPlanes(Mission.Shoho) then
		LaunchSquadron(Mission.Shoho, 150, 3)
	end

	luaCamOnTargetFree(Mission.Shoho, 30, 90, 300, false, "noupdate", 3, nil)

end

function luaJM4EndTakeOff()
	RemoveListener("input", "movielistenerID")

	local squads,squadTbl = luaGetSlotsAndSquads(Mission.Shoho)
	if squads and squads > 0 then
		Mission.PlayerPlane = squadTbl[1]
		SetInvincible(Mission.PlayerPlane, true)
	end

	luaJM4ShowToggleSM()
	Mission.SMon = false

	luaDelay(luaJM4SelectPlane, 2)
end
]]
function luaJM4SelectPlane()
	if not Mission.PlayerPlane.Dead then
		SetRoleAvailable(Mission.PlayerPlane, EROLF_ALL, PLAYER_1)
	end

	if not Mission.PlayerPlane.Dead and IsUnitSelectable(Mission.PlayerPlane) then
		SetSelectedUnit(Mission.PlayerPlane)
		EnableInput(true)
	else
		luaDelay(luaJM4SelectPlane, 1)
	end
end

-------------moviez----------------------
function luaJM4MovieInit()
	Mission.MovieUnit = GetSelectedUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, 0.1)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead and not Mission.PlayerPlane then
		SetInvincible(Mission.PlayerUnit, 0.1)
	elseif Mission.PlayerPlane and not Mission.PlayerPlane.Dead then
		SetInvincible(Mission.PlayerPlane, 0.1)
	end
end

function luaJM4SelectUnit()
	if Mission.MovieUnit and not Mission.MovieUnit.Dead then
		SetInvincible(Mission.MovieUnit, false)
		SetSelectedUnit(Mission.MovieUnit)
	elseif Mission.PlayerUnit and not Mission.PlayerUnit.Dead and not Mission.PlayerPlane then
		SetInvincible(Mission.PlayerUnit, false)
		SetSelectedUnit(Mission.PlayerUnit)
	elseif Mission.PlayerPlane and not Mission.PlayerPlane.Dead then
		SetInvincible(Mission.PlayerPlane, false)
		SetSelectedUnit(Mission.PlayerPlane)
	end
	EnableInput(true)
end

--------------------moviez-----------------------

function luaJM4AirstrikeMovie(unit)

	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM4MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 40, ["theta"] = 15, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 15, ["theta"] = 38, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM4SelectUnit, true)
end

function luaJM4SubMovie()
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	local unit = Mission.Subs[1]

	luaJM4MovieInit()
	luaIngameMovie(
		{
		 {["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-40,["y"]=8,["z"]=60},["parent"] = unit,},["moveTime"] = 0,["transformtype"] = "keepnone",},
		 {["postype"] = "cameraandtarget",["position"] = {["pos"] = {["x"]=-5,["y"]=5,["z"]=50},["parent"] = unit,},["moveTime"] = 10,["transformtype"] = "keepnone", ["zoom"] = 1.5},

		}, luaJM4SelectUnit, true)
end

function luaJM4SubDeadMovie(unit)
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	luaJM4MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 100, ["theta"] = -8, ["rho"] = 205, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 65, ["theta"] = -5, ["rho"] = 225, ["moveTime"] = 10},
		}, luaJM4SubMovieEnd, true)
end

function luaJM4RadarMovie()
	if not luaGetMovieOption() or IsListenerActive("input", "IngameMovieInputListenerID") then
-- RELEASE_LOGOFF  		luaLog("Movie skipped: optional movie or movie already playing")
		return
	end

	local unit = Mission.RadarStation

	luaJM4MovieInit()
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 120, ["theta"] = 10, ["rho"] = 50, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = unit, ["distance"] = 80, ["theta"] = 15, ["rho"] = 60, ["moveTime"] = 10},
		}, luaJM4SelectUnit, true)
end

function luaJM4SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)
	luaRegisterCheckpointData("NavPoints", "NavpointTbl", GetPosition(FindEntity("ShohoCheck")))
	luaRegisterCheckpointData("NavPoints", "NavpointTbl", GetPosition(FindEntity("MogamiCheck")))
	Mission.Checkpoint.Radar = Mission.RadarStationDetected
	Mission.Checkpoint.RemainingHits = Mission.RemainingHits

	if Mission.ReconPlane and not Mission.ReconPlane.Dead then
		Mission.Checkpoint.Reconplane = true
	end
end

function luaJM4LoadMissionData()
-- RELEASE_LOGOFF  	luaLog("luaJM4LoadMissionData called")
	EnableInput(false)

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.RadarStationDetected = Mission.Checkpoint.Radar
	Mission.RemainingHits = Mission.Checkpoint.RemainingHits
	Mission.FirstRun = true

	--shoho hp
	SetInvincible(Mission.Shoho, 0.05*Mission.RemainingHits)
	AddDamage(Mission.Shoho, 10000)

	luaDelay(luaJM4Pri2Bubble,3)

	Blackout(true, "", 0)
	luaJM4StartPutTo()
end

function luaJM4StartPutTo()
-- RELEASE_LOGOFF  	luaLog("luaJM4StartPutTo called")
	Mission.FirstAttack = true

	luaJM4KillCat()
	luaJM4LaunchPlane()
	luaJM4restoreJapUnits()
end

function luaJM4restoreJapUnits()

	local japUnits = luaGetCheckpointData("Units", "JapUnits")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking japanese player units")
	local leader
	for idx,unit in pairs(Mission.JapFleet) do
		local found = false
		for idx2,unitTbl in pairs(japUnits[1]) do
			if unit.Name == unitTbl[1] then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
				found = true
				break
			end
		end

		if not found then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Unit not found, killing her "..unit.Name)
			Kill(unit, true)
		end
	end

	if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
		if table.getn(luaRemoveDeadsFromTable(Mission.Subs)) == 0 then
			luaJM4SpawnSubs()
		end
	elseif not luaObj_IsActive("secondary",1) then
		luaObj_Add("secondary",1)
		luaJM4SpawnSubs()
	end

	--PutTo
	luaDelay(luaJM4PutUnits,2)
end

function luaJM4PutUnits()

-- RELEASE_LOGOFF  	luaLog("luaJM4PutUnits called")
	local tbl = luaGetCheckpointData("NavPoints", "NavpointTbl")
	local navPoint = tbl[1]
	PutTo(Mission.Shoho, navPoint)

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
	--	local x = luaGetCheckpointData("NavPoints", "NavpointTbl")
	--	PutTo(Mission.PlayerUnit, x[2])
	--	JoinFormation(Mission.PlayerUnit, Mission.Shoho)
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_AI)
	end

	if Mission.Checkpoint.Reconplane then
		Mission.ReconPlane = GenerateObject("F1M Pete 01")

		local ship = FindEntity("Mogami-class 01")
		if not ship or ship.Dead then
			ship = Mission.Shoho
		else
			return
		end

		local coord = GetPosition(ship)
		coord.y = 150

		PutTo(Mission.ReconPlane, coord)
		PilotMoveToRange(Mission.ReconPlane, ship)

		SetRoleAvailable(Mission.ReconPlane, EROLF_ALL, PLAYER_ANY)
	end
end

function luaJM4LaunchPlane()
	Mission.PlayerPlane = GenerateObject("A6M Zero 01")
	 SetAirBaseSlotReady(Mission.Shoho, 1)
	SquadronSetHomeBase(Mission.PlayerPlane, Mission.Shoho)
	SetSelectedUnit(Mission.PlayerPlane)
	--SoundFade(1, "",0.5)
	Blackout(false, "luaJM4AddInput", 1)
end

function luaJM4AddInput()
	EnableInput(true)
end

function luaJM4KillCat()
	if Mission.CatalinaListener then
		RemoveListener("kill", "CatalinaKill")
		Mission.CatalinaListener = nil
	end

	if Mission.Catalina	and not Mission.Catalina.Dead then
		Kill(Mission.Catalina, true)
	end
end

function luaJM4CheckEndConds()

	if Mission.Shoho.Dead then
		return true
	end

	--local pUnit = GetSelectedUnit()
	--local CA = Mission.Shoho
	--local onMap = IsGUIActive("GUI_map")
	local planes = luaSumTablesIndex(recon[PARTY_ALLIED].own.torpedobomber,recon[PARTY_ALLIED].own.divebomber,recon[PARTY_ALLIED].own.fighter)
	local vicinity = false

	for idx,unit in pairs(luaRemoveDeadsFromTable(planes)) do

		local rcnLvl = unit.reconlevel
		--luaLog(rcnLvl)

		if rcnLvl[1] and rcnLvl[1] >= 2 then --latszik a japan reconban
			vicinity = true
		elseif not rcnLvl[1] or rcnLvl[1] < 2 then
			Kill(unit, true)
		end

	end

	return vicinity
	--[[
		if not vicinity then
			local dist1 = luaGetDistance(unit, Mission.Shoho)

			if dist1 < 2500 then
-- RELEASE_LOGOFF  				luaLog("Unit is near "..unit.Name)
				vicinity = true
			end

		end

		--Kill
		if not onMap and pUnit and not pUnit.Dead then
			local dist2 = luaGetDistance(pUnit, unit)

			if dist2 > 2500 then
-- RELEASE_LOGOFF  				luaLog("Killing unit "..unit.Name)
				Kill(unit, true)
			end

			if not vicinity then
				if dist2 < 2500 then
-- RELEASE_LOGOFF  					luaLog("Unit is near "..unit.Name)
					vicinity = true
				end
			end
		elseif onMap then
			return true
		end

	end

	return vicinity
	]]
end

function luaJM4CheckReconplanes()
	local planes = recon[PARTY_JAPANESE].own.reconplane
	for idx,unit in pairs(planes) do
		if not unit.pCtrl then
			SetRoleAvailable(unit, EROLF_ALL, PLAYER_ANY)
			UnitSetPlayerCommandsEnabled(unit, PCF_ALL)
			Mission.ReconPlane = unit
			unit.pCtrl = true
		end
	end
end

function luaJM4EliteFighters()
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNDogs)) do
		SetSkillLevel(unit,SKILL_ELITE)
	end
end

function luaJM4DestroyShohoEfx()
	if Mission.ShohoEfx then
		DestroyEffect(Mission.ShohoEfx.Pointer)
		Mission.ShohoEfx = nil
	end
end

function luaJM4Pri2()
	local numsquads = 0

	if not Mission.Shoho.Dead then
		_, sq = luaGetSlotsAndSquads(Mission.Shoho)
		if sq then
			numsquads = (numsquads + table.getn(sq))
		end
	end

	if not Mission.SqLaunched then
		Mission.SqLaunched = numsquads
	else

		if numsquads > 0 then
			if numsquads > Mission.SqLaunched then
				return true
			end
		elseif numsquads == 0 then
			Mission.SqLaunched = 0
		end

	end

	return false

end

function luaJM4Pri2Completed()
	HideScoreDisplay(666,0)
	luaObj_Completed("primary",2)
end

function luaJM4CheckTutCompl()
	if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
		Mission.TutObjNotCompl = true
		for idx,unit in pairs(luaSumTablesIndex(Mission.JapFleet, {Mission.PlayerUnit})) do
			SetSkillLevel(unit, SKILL_STUN)
		end
	end
end

function luaJM4Blue(x)
	ForceEnableInput(IC_OVERLAY_BLUE,x)
end

function luaJM4MapRestrict(x)
	--ForceEnableInput(IC_CMD_MAP_TARGET, x)
	--ForceEnableInput(IC_CMD_MAP_MOVE, x)
	--ForceEnableInput(IC_CMD_MAP_JOIN, x)
end

function luaJM4ShowCtrlHint()
	ShowHint("USN09_Hint_Control")
end

function luaJM4CheckMapCmds()
	local unit = GetSelectedUnit()
	if unit.ID ~= Mission.PlayerUnit.ID then
		luaJM4MapRestrict(true)
	elseif unit.ID == Mission.PlayerUnit.ID then
		luaJM4MapRestrict(false)
	end

	if Mission.MissionPhase < 3 then
		luaDelay(luaJM4CheckMapCmds, 0.5)
	end
end

function luaJM4ShowToggleSM()
-- RELEASE_LOGOFF  	luaLog("luaJM4ShowToggleSM called")
	ShowHideSupportManager()
end

function luaJM4SMHintShow()
	--luaLog("luaATSMHintShow called")
	--HideHint()
	RemoveStoredHint("SMPERMANENTPLANE")
	ShowHintForced("SMPERMANENTPLANE")
end

function luaJM4EnableShohoDeck()
-- RELEASE_LOGOFF  	luaLog("luaJM4EnableShohoDeck called")
	SetRoleAvailable(Mission.Shoho, EROLF_SPECIAL, PLAYER_ANY)
	SetSelectedUnit(Mission.Shoho)

	--luaJM4AddSpawnListner()

	luaDelay(luaJM4ShowToggleSM,1)
	--luaDelay(luaJM4SMHintShow,1)

	luaJM4AddGuiListener()

	Mission.ShohoEnabledForSM = true
end

function luaJM4RestrictShoho()
	SetRoleAvailable(Mission.Shoho, EROLF_ALL, PLAYER_AI)
	Mission.ShohoEnabledForSM = false
end

function luaJM4AddSpawnListner()

	if IsListenerActive("generate", "Spawned") then
		return
	end

	AddListener("generate", "Spawned", {
    ["callback"] = "luaJM4SpawnedPlayer",  -- callback fuggveny
    ["entityName"] = {}, -- string, a generalt template neve
    ["entityType"] = {}, -- vehicleclasses.lua-bol a type parameter pl torpedoboat
    })
end

function luaJM4SpawnedPlayer(unit)

	local playerunit = FindEntity(unit)

	if not playerunit then
		return
	end

	--luaLog("spawned")
	--luaLog(playerunit)
	--luaLog(playerunit.Type)

	if type(playerunit) == "table" then
  	if Mission.PlayerPlane and not Mission.PlayerPlane.Dead or Mission.MegvanMarCsakSzar then
    	return
    elseif playerunit.Type == "PLANESQUADRON" then
    	--if IsUnitSelectable(playerunit) then
    	Mission.PlayerPlane = playerunit
    	Mission.MegvanMarCsakSzar = true
    	luaDelay(luaJM4DelayedSelect, 1)
    	--luaDelay(luaJM4RestrictShoho,1.5)
    end
  end

end

function luaJM4DelayedSelect()

	--if Mission.MegvanMarCsakSzar then
	--	luaDelay(luaJM4SzeddLeASzart,3)
	--	return
	--end

	SetRoleAvailable(Mission.PlayerPlane, EROLF_ALL, PLAYER_ANY)
	if IsUnitSelectable(Mission.PlayerPlane) then
		SetSelectedUnit(Mission.PlayerPlane)
		luaJM4RestrictShoho()
	else
		luaDelay(luaJM4DelayedSelect, 1)
	end
end

function luaJM4SzeddLeASzart()
	Mission.MegvanMarCsakSzar = false
	luaJM4DelayedSelect()
end

function luaJM4AddGuiListener()
	if IsListenerActive("gui", "SMLGuiListener") then
		return
	end
	AddListener("gui", "SMLGuiListener", {
		["callback"] = "luaJM4IsSMActive",  -- callback fuggveny
		["guiName"] = {"GUI_support_full"}, -- gui folderben levo lua file-ok neve pl ShipControlGui
		["enter"] = {}, -- attol fuggoen hogy megjelenitesre, vagy eltunesre akarunk vizsgalni
		})
end

function luaJM4IsSMActive(...)

	HideHint()
	if not IsSMVisible() then
		return
	end

-- RELEASE_LOGOFF  	luaLog("luaJM4IsSMActive called")
	for i,v in ipairs(arg) do
-- RELEASE_LOGOFF  		luaLog(tostring(i).." "..tostring(v))
	end
	Mission.IsSMActivated = arg[2]

	if not Mission.IsSMActivated and not Mission.SMAccessHintActive then
		luaJM4SMHint()
		Mission.SMAccessHintActive = true
		Mission.SMUseHintActive = false
	elseif Mission.IsSMActivated and not Mission.SMUseHintActive then
		luaJM4SMHintShow()
		Mission.SMUseHintActive = true
		Mission.SMAccessHintActive = false
	end

end

--[[
function luaJM4CheckCruiserFormation()
	if Mission.PlayerUnit.Dead then
		return
	end

	if not IsInFormation(Mission.PlayerUnit) then
-- RELEASE_LOGOFF  		luaLog("itt")
		if not Mission.Shoho.Dead then
			UnitSetPlayerCommandsEnabled(Mission.PlayerUnit, PCF_ALL)
			JoinFormation(Mission.PlayerUnit, Mission.Shoho)
			UnitSetPlayerCommandsEnabled(Mission.PlayerUnit, PCF_NONE)
-- RELEASE_LOGOFF  			luaLog("join")
		end

	end
end
]]