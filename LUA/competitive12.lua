--todo:
--tobb hpt a cargoknak, playernum fuggvenyeben (?) DONE
--highlighted unit killre narrativa	DONE
--db mindig a llegmagasabb pontszamut lojje DONE
--fletcher crew level (?)
--cv hp playerszamra		DONE
--powerup jon e?			DONE
--raketas corsair (1 fos sq. par darab)		DONE?
--missionhint
function luaPrecacheUnits()
	PrepareClass(37) -- US Cargo
	PrepareClass(23) -- Fletcher
	PrepareClass(48) -- ASWFletcher
	PrepareClass(93) -- TypeB
	PrepareClass(38) -- Heldiver
	PrepareClass(35) -- Fleet oiler
	PrepareClass(102) --corsair
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitC12Mission")
end

function luaInitC12Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp12"

	Mission.ScriptFile = "Scripts/missions/multi/Competitive12.lua"

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 1
	Mission.CompetitiveParty = PARTY_JAPANESE

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	if LobbySettings.TimeLimit == "globals.none" then
		Mission.LobbyCountDown = 0
	elseif LobbySettings.TimeLimit == "globals.5m" then
		Mission.LobbyCountDown = 5 * 60
	elseif LobbySettings.TimeLimit == "globals.10m" then
		Mission.LobbyCountDown = 10 * 60
	elseif LobbySettings.TimeLimit == "globals.15m" then
		Mission.LobbyCountDown = 15 * 60
	elseif LobbySettings.TimeLimit == "globals.20m" then
		Mission.LobbyCountDown = 20 * 60
	elseif LobbySettings.TimeLimit == "globals.25m" then
		Mission.LobbyCountDown = 25 * 60
	elseif LobbySettings.TimeLimit == "globals.30m" then
		Mission.LobbyCountDown = 30 * 60
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.TimeLimit contains non-handled string | LobbySettings.TimeLimit: "..LobbySettings.TimeLimit)
		Mission.LobbyCountDown = 0
	end

	if Mission.LobbyCountDown == 0 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
		Mission.FourthWarningDone = true
	elseif Mission.LobbyCountDown <= 900 and Mission.LobbyCountDown >= 601 then
		Mission.FirstWarningDone = true
	elseif Mission.LobbyCountDown <= 600 and Mission.LobbyCountDown >= 301 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
	elseif Mission.LobbyCountDown <= 300 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
	end

	if LobbySettings.PointLimit == "globals.none" then
		Mission.PointLimit = 0
	elseif LobbySettings.PointLimit == "500" then
		Mission.PointLimit = 500
	elseif LobbySettings.PointLimit == "1000" then
		Mission.PointLimit = 1000
	elseif LobbySettings.PointLimit == "2000" then
		Mission.PointLimit = 2000
	elseif LobbySettings.PointLimit == "3000" then
		Mission.PointLimit = 3000
	elseif LobbySettings.PointLimit == "4000" then
		Mission.PointLimit = 4000
	elseif LobbySettings.PointLimit == "5000" then
		Mission.PointLimit = 5000
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.PointLimit contains non-handled string | LobbySettings.PointLimit: "..LobbySettings.PointLimit)
		Mission.PointLimit = 0
	end

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 0,
				["ID"] = "jap_obj_primary_1_player_1",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 1,
				["ID"] = "jap_obj_primary_1_player_2",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 2,
				["ID"] = "jap_obj_primary_1_player_3",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 3,
				["ID"] = "jap_obj_primary_1_player_4",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[5] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 4,
				["ID"] = "jap_obj_primary_1_player_5",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[6] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 5,
				["ID"] = "jap_obj_primary_1_player_6",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[7] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 6,
				["ID"] = "jap_obj_primary_1_player_7",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[8] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 7,
				["ID"] = "jap_obj_primary_1_player_8",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	Mission.Digit4 = 8888

	MultiScore =	{
		[0]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
	}

	if Mission.PointLimit == 0 then
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1#", "mp01.score_comp_high".."| #MultiScore.0.5#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1#", "mp01.score_comp_high".."| #MultiScore.1.5#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1#", "mp01.score_comp_high".."| #MultiScore.2.5#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1#", "mp01.score_comp_high".."| #MultiScore.3.5#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1#", "mp01.score_comp_high".."| #MultiScore.4.5#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1#", "mp01.score_comp_high".."| #MultiScore.5.5#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1#", "mp01.score_comp_high".."| #MultiScore.6.5#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1#", "mp01.score_comp_high".."| #MultiScore.7.5#")
	else
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.7#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.7#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.7#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.7#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.7#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.7#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.7#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.7#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.7#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.7#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.7#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.7#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.7#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.7#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.7#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.7#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][7] = Mission.PointLimit
		end
	end

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	local numPlayers = table.getn(PlayersInGame)

	Mission.KillScore = 200

	Mission.DDPath = {}
		table.insert(Mission.DDPath, FindEntity("Competitive - ASWPath1"))
		table.insert(Mission.DDPath, FindEntity("Competitive - ASWPath2"))
		table.insert(Mission.DDPath, FindEntity("Competitive - DDPath1"))
		table.insert(Mission.DDPath, FindEntity("Competitive - DDPath2"))

	Mission.ASWs = {}
		--table.insert(Mission.ASWs, GenerateObject("Competitive - ASW Fletcher 01"))
		--table.insert(Mission.ASWs, FindEntity("Competitive - ASW Fletcher 01"))
		--Mission.ASWs[1].Path = FindEntity("Competitive - ASWPath1")
		--table.insert(Mission.ASWs, GenerateObject("Competitive - ASW Fletcher 02"))
		--table.insert(Mission.ASWs, FindEntity("Competitive - ASW Fletcher 02"))
		--Mission.ASWs[2].Path = FindEntity("Competitive - ASWPath2")

		--luaLog("aaa")

		local j
		if numPlayers <= 2 then
			j = 1
		elseif numPlayers > 2 and numPlayers <=4 then
			j = 2
		else
			j = 4
		end

		for i=1,j do
			table.insert(Mission.ASWs, GenerateObject("Competitive - ASW Fletcher 0"..tostring(i)))
			Mission.ASWs[i].Path = Mission.DDPath[i]
		end

	--luaLog("aaaaa")

	for idx,unit in pairs(Mission.ASWs) do
		SetSkillLevel(unit, SKILL_MPVETERAN)
	end

	Mission.DDs = {}
		--table.insert(Mission.DDs, GenerateObject("Competitive - Fletcher-class 01"))
		--table.insert(Mission.DDs, FindEntity("Competitive - Fletcher-class 01"))
		--Mission.DDs[1].Path = FindEntity("Competitive - DDPath1")
		--table.insert(Mission.DDs, GenerateObject("Competitive - Fletcher-class 02"))
		--table.insert(Mission.DDs, FindEntity("Competitive - Fletcher-class 02"))
		--Mission.DDs[2].Path = FindEntity("Competitive - DDPath2")

	Mission.ConvoyPath = {}
		table.insert(Mission.ConvoyPath, FindEntity("Competitive - BoguePath"))
		table.insert(Mission.ConvoyPath, FindEntity("Competitive - AKPath1"))
		table.insert(Mission.ConvoyPath, FindEntity("Competitive - AKPath2"))

	Mission.MaxDDAttackRange = 2000
	--Mission.DDSpeedBackRange = 500

	Mission.MinShipSpeed = 8
	Mission.MaxShipSpeed = 20

	Mission.USNCarrier = FindEntity("Competitive - CVE")
	Mission.BaseCVHP = 16000
	Mission.BonusCVHP = 500
	OverrideHP(Mission.USNCarrier, Mission.BaseCVHP + (numPlayers * Mission.BonusCVHP))
	Mission.DiverName = "Competitive - Helldiver"
	Mission.USNCarrierPlanes = {}
	Mission.RecentlyGenerated = true
	Mission.GenerateDelay = 45
	Mission.MaxDivers = 2

	Mission.Corsairs = {}
	Mission.MaxCorsairs = 2
	Mission.CorsairName = "Competitive - Corsair"

	if LobbySettings.ReloadPayload == "globals.on" then
		Mission.ReloadPayLoad = true
	else
		Mission.ReloadPayLoad = false
	end

	Mission.BaseCargoHP = 2400
	Mission.BonusCargoHP = 500

	Mission.Convoy = {}
	--[[	table.insert(Mission.Convoy, GenerateObject("Competitive - US Cargo Transport 01"))
		table.insert(Mission.Convoy, GenerateObject("Competitive - US Cargo Transport 02"))
		table.insert(Mission.Convoy, GenerateObject("Competitive - US Tanker 01"))
		table.insert(Mission.Convoy, GenerateObject("Competitive - US Tanker 02"))
	]]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Cargo Transport 01"))
		Mission.Convoy[1].Path = Mission.ConvoyPath[2]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Cargo Transport 04"))
		Mission.Convoy[2].Path = Mission.ConvoyPath[2]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Cargo Transport 02"))
		Mission.Convoy[3].Path = Mission.ConvoyPath[3]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Cargo Transport 03"))
		Mission.Convoy[4].Path = Mission.ConvoyPath[3]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Tanker 01"))
		Mission.Convoy[5].Path = Mission.ConvoyPath[2]
		table.insert(Mission.Convoy, FindEntity("Competitive - US Tanker 02"))
		Mission.Convoy[6].Path = Mission.ConvoyPath[3]

	for idx,unit in pairs(Mission.Convoy) do
		AAEnable(unit, false)
		OverrideHP(unit, (Mission.BaseCargoHP + numPlayers * Mission.BonusCargoHP))
	end

	--[[
	Mission.SpawnPointsNav = {}
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP1"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP2"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP3"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP4"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP5"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP6"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP7"))
		table.insert(Mission.SpawnPointsNav, FindEntity("Competitive - SP8"))
]]
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 01"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 02"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 03"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 04"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 05"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 06"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 07"))
		table.insert(Mission.SpawnPoints, FindEntity("Competitive - SpawnPoint 08"))

	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

	for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end
	end

	Mission.Units2Respawn = {}
	Mission.RecentRespawn = false
	Mission.RespawnTemplates = {}
		Mission.RespawnTemplates[23] = {"Competitive - Fletcher Respawn", Mission.DDs}
		Mission.RespawnTemplates[48] = {"Competitive - ASW Fletcher Respawn", Mission.ASWs}
		Mission.RespawnTemplates[35] = {"Competitive - Tanker Respawn", Mission.Convoy}
		Mission.RespawnTemplates[37] = {"Competitive - Cargo Respawn", Mission.Convoy}

	Mission.RespawnMaxUnits = {
		[37] = 4,
		[23] = 2,
		[48] = 4,
		[35] = 2,
	}

	Mission.SpawnPointGap = 500
	Mission.SpawnPointDistFromPath = 2800
	Mission.PossibleSpawnPoints = {}
	Mission.ActualPosNum = 1

	local tmp = FillPathPoints(Mission.ConvoyPath[1])
	for idx,point in pairs(tmp) do
		if idx > 1 and idx < 7 then
			table.insert(Mission.PossibleSpawnPoints, point)
		end
	end

	Mission.AchievemntTbl = {
		[0] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[1] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[2] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[3] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[4] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[5] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[6] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
		[7] = {
			["lastUnitID"] = -1,
			["check_needed"] = true,
		},
	}


	luaInitNewSystems()

    SetThink(this, "luaC12Mission_think")
end

function luaC12Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
	--luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if not Mission.FirstRun then
		luaC12StartMission()
		luaAddCVListener()
		Mission.FirstRun = true
	end

	luaC12CheckAchievement()
	luaC12CheckRespawn()
	luaC12ASWAI()
	luaC12CheckNmiCarrier()
	luaC12CheckTorpedoReload()
	luaC12CheckListeners()
	luaC12CheckSpawnPoints()
	luaC12CheckCorsairs()
	luaC12CheckEndConds()
end

function luaC12ASWAI()

		--todo: Dead checking, spawn enemies if need
		--unit flagek
		--unit.attackngNmi: van ervenyes tamadas parancsa
		--unit.onPath: pathon mozog
		--unit.maxSpeed: maxspeeden mozog
		--nmi.beingAttacked: ennek az nminek van mar attackerje

	for idx,unit in pairs(luaSumTablesIndex(luaRemoveDeadsFromTable(Mission.ASWs),luaRemoveDeadsFromTable(Mission.DDs))) do

		local actualTrg = luaGetScriptTarget(unit)
		local possibleTargets = luaC12GetPossibleTrgs(unit)
		local visibleTrg = luaC12IsVisibleEnemy(actualTrg, possibleTargets)

		if actualTrg and not actualTrg.Dead and visibleTrg then -- van trg, nem halott es lathato reconban
			--luaLog(unit.Name.." has an actual target")

		elseif actualTrg and not actualTrg.Dead and not visibleTrg then	--van trg, nem halott, de nem latszik

-- RELEASE_LOGOFF  			luaLog(unit.Name.." has an actual target but its not visible")
			luaSetScriptTarget(unit, nil)
			unit.attackingNmi = false
			actualTrg.beingAttacked = false

			luaC12DDBackOnPath(unit)

		elseif actualTrg and actualTrg.Dead then	--van trg, de mar halott

-- RELEASE_LOGOFF  			luaLog(unit.Name.." has an actual target but it is dead")
			luaSetScriptTarget(unit, nil)
			unit.attackingNmi = false

			luaC12DDBackOnPath(unit)


		elseif (not actualTrg or actualTrg.Dead) and table.getn(possibleTargets) > 0 then -- akkor keresunk targetet ha van is ertelme

-- RELEASE_LOGOFF  			luaLog(unit.Name.." has no actual target but there are enemies around")

			local nmi
			local attackedNmis = {}

			for idx2,sub in pairs(possibleTargets) do
				if sub and not sub.Dead and not sub.beingAttacked then
					nmi = sub
					break
				end
			end

			if nmi and not nmi.Dead then
				luaSetScriptTarget(unit, nmi)
				SetShipMaxSpeed(unit, Mission.MaxShipSpeed)
				NavigatorAttackMove(unit, nmi, {})
				nmi.beingAttacked = true
				unit.attackingNmi = true
				unit.maxSpeed = true
				unit.onPath = false
-- RELEASE_LOGOFF  				luaLog(unit.Name.." found a visible enemy "..nmi.Name.." commencing attackrun")
			elseif not nmi or nmi.Dead then
				luaC12DDBackOnPath(unit)
			end

		elseif (not actualTrg or actualTrg.Dead) and table.getn(possibleTargets) == 0 then

-- RELEASE_LOGOFF  			luaLog(unit.Name.." has no target, and there are no visible targets")

			if unit.attackingNmi then		-- nincse trg, lathato nmi sem, vissza pathra
				luaC12DDBackOnPath(unit)
-- RELEASE_LOGOFF  				luaLog(unit.Name.." goes back to path")
			end

		end --end if,elseif

	end --end for

end --end function

function luaC12DDBackOnPath(unit)

	if unit.onPath then
		return
	end

	unit.attackingNmi = false
	--NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN, Mission.MaxShipSpeed)
	NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN, Mission.MinShipSpeed)
	unit.onPath = true
	--unit.maxSpeed = true
-- RELEASE_LOGOFF  	luaLog(unit.Name.." goes back to path")
end

function luaC12GetPossibleTrgs(unit)
	local knownEnemies = {}

	if unit.Dead then
		return knownEnemies
	end

	for idx, sub in pairs (luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) do
		if sub and not sub.Dead and luaGetDistance(unit, sub) <= Mission.MaxDDAttackRange then
			table.insert(knownEnemies, sub)
		end
	end

	if table.getn(knownEnemies) > 0 then
		return luaSortByDistance2(unit, knownEnemies)
	else
		return knownEnemies
	end
end

function luaC12IsVisibleEnemy(unit, trgTbl)

	if not unit or unit.Dead then
		return false
	end

	if luaIsInside(unit, trgTbl) then
		return true
	else
		return false
	end

end

function luaC12GetHighestScoreOwner()

	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaC12AddInitalObjs()
	for idx,tbl in pairs(Mission.Objectives.primary) do
		luaObj_Add("primary",idx)
	end
end

function luaC12UpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
		--luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaC12GetHighestScoreOwner()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end

		luaDelay(luaC12UpdateCounters, 0.7)
	end
end

function luaC12CheckCorsairs()
	if table.getn(Mission.Corsairs) < Mission.MaxCorsairs then
		local refUnit = luaPickRnd(luaRemoveDeadsFromTable(luaSumTablesIndex(Mission.ASWs, Mission.DDs, Mission.Convoy)))
		if refUnit and not refUnit.Dead then
			local pos = GetPosition(refUnit)
			pos.y = 250
			local corsair = GenerateObject(Mission.CorsairName, pos)
			SetSkillLevel(corsair, SKILL_MPVETERAN)
			UnitFreeAttack(corsair)
			table.insert(Mission.Corsairs, corsair)
		end
	end

	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Corsairs)) do
		for idx2, sub in pairs (luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) do

			local diverTrg = luaGetScriptTarget(unit)
			--local ammo = GetProperty(unit, "ammoType")
			--luaC12GotRocket(unit)

			--if ammo == 0 and not Mission.ReloadPayLoad then
			--	if not unit.retreating then
			--		PilotRetreat(unit)
			--		unit.retreating = true
			--	end
			--else
				if diverTrg and not diverTrg.Dead and GetSubmarineOnSurface(diverTrg) then
-- RELEASE_LOGOFF  					luaLog("orulunk van corsair trg")
				elseif diverTrg and not diverTrg.Dead and not GetSubmarineOnSurface(diverTrg) then
					if sub and not sub.Dead and GetSubmarineOnSurface(sub) then

						local pos = GetPosition(sub)
						if pos.y < 0.01 then
							return
						end

-- RELEASE_LOGOFF  						luaLog("uj corsair trg")
						luaSetScriptTarget(unit, sub)
						PilotSetTarget(unit, sub)
					else
						luaSetScriptTarget(unit, nil)
						local pos = GetPosition(diverTrg)
						PilotMoveToRange(corsair, pos, 100)
					end
				elseif not diverTrg or diverTrg.Dead then
					if sub and not sub.Dead and GetSubmarineOnSurface(sub) then

						local pos = GetPosition(sub)
						if pos.y < 0.01 then
							return
						end

-- RELEASE_LOGOFF  						luaLog("uj corsair trg")
						luaSetScriptTarget(unit, sub)
						PilotSetTarget(unit, sub)
					end
				end
			--end
		end
	end
end

function luaC12CheckNmiCarrier()
	--CV

	Mission.USNCarrierPlanes = luaRemoveDeadsFromTable(Mission.USNCarrierPlanes)

	if not Mission.USNCarrier.Dead then
		if not Mission.RecentlyGenerated then
			if table.getn(Mission.USNCarrierPlanes) < Mission.MaxDivers then
-- RELEASE_LOGOFF  				luaLog("generating hellcat")
				local cvPos = GetPosition(Mission.USNCarrier)
				cvPos.y = 150
				local diver = GenerateObject(Mission.DiverName)
				table.insert(Mission.USNCarrierPlanes, diver)
				PutTo(diver, cvPos)
				Mission.RecentlyGenerated = true
				luaDelay(luaC12ResetGeneratedFlag, Mission.GenerateDelay)
			end
		end
	end

	if table.getn(Mission.USNCarrierPlanes) > 0 then

		for idx,unit in pairs(Mission.USNCarrierPlanes) do

			local pos = GetPosition(unit) --faszom kod fagyas miatt
			if pos.x > 25000 or pos.x < -25000 or pos.z > 25000 or pos.z < -25000 then
				Kill(unit,true)
				return
			end

			--[[
			for idx2, sub in pairs (luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) do
				if sub and not sub.Dead then

					local diverTrg = luaGetScriptTarget(unit)
					if diverTrg and not diverTrg.Dead then

						--pos update
						if diverTrg.ID == sub.ID then
							unit.lastKnownPos = GetPosition(sub)
							--luaLog("--updating target pos info--")
							--luaLog(unit.lastKnownPos)
							--latszik e reconban
							if not luaC12IsVisibleEnemy(sub, luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) then
								--elmegyunk az utolso ismert helyere
								if unit.lastKnownPos and not unit.movingToPos then
									PilotMoveToRange(unit, unit.lastKnownPos)
									unit.movingToPos = true
-- RELEASE_LOGOFF  									luaLog("target not in recon, diver moves to pos")
								end
							end
						end

					else -- ha nincse target v halott
					]]
						local ammo = GetProperty(unit, "ammoType")
						--local reloading = GetPlaneIsReloading(unit)

						if ammo ~= 0 or Mission.ReloadPayLoad then

							local highscoreSub = luaC12GetHighScoreSub()
							local trg

							if highscoreSub and not highscoreSub.Dead and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead or luaGetScriptTarget(unit).ID ~= highscoreSub.ID ) then --and table.getn(luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) and luaIsInside(highscoreSub, luaRemoveDeadsFromTable(recon[PARTY_ALLIED].enemy.submarine)) then
								trg = highscoreSub
							--else
							--	trg = sub
							--end

								PilotSetTarget(unit, trg)
								luaSetScriptTarget(unit, trg)
								unit.movingToPos = false
-- RELEASE_LOGOFF  								luaLog("diver gets a new target")
							end
						else
							PilotRetreat(unit)
							unit.retreating = true
-- RELEASE_LOGOFF  							luaLog("diver retreats")
						end

					--end

				--end
			--end
		end
	end
end

function luaC12StartNmi()
	for idx,unit in pairs(luaSumTablesIndex(Mission.ASWs, Mission.DDs, Mission.Convoy)) do
		NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN, Mission.MinShipSpeed)
	end
	--all other
	NavigatorMoveOnPath(Mission.USNCarrier, Mission.ConvoyPath[1], PATH_FM_SIMPLE, PATH_SM_JOIN, Mission.MinShipSpeed)
end

function luaC12ResetGeneratedFlag()
	Mission.RecentlyGenerated = false
-- RELEASE_LOGOFF  	luaLog("reseting recently generated flag")
end

function luaC12GetHighScoreSub()

	local highscoreOwner, _dummy = luaC12GetHighestScoreOwner()
	local sub

	for idx,unit in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.submarine)) do
		if GetRoleAvailable(unit)[1] == highscoreOwner then
			sub = unit
			break
		end
	end

	if sub then
		return sub
	else
		return nil
	end
end

function luaC12StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaC12ShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaC12MissionEndTimeIsUp")
	end

	luaC12StartNmi() --hajok indulnak
	luaC12AddInitalObjs()		--obj
	luaC12UpdateCounters()	--counter update

	luaDelay(luaC12ResetGeneratedFlag, Mission.GenerateDelay)
end

function luaC12MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaC12GetHighestScoreOwner()
	local PlayersInGame = GetPlayerDetails()
	local playerwhowon

	if highestplayerscore > 0 then
		playerwhowon = PlayersInGame[highestindex]
	else
		_, playerwhowon = next(PlayersInGame)
	end

	for index, value in pairs (PlayersInGame) do
		if playerwhowon.playerName ~= "" then
			MultiScore[index][4] = playerwhowon.playerName
			Mission.WinnerPlayer = playerwhowon.playerName
		else
			Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
			Mission.WinnerPlayerAILevel = playerwhowon.ailevel
			if playerwhowon.ailevel == 3 then
				MultiScore[index][4] = "FE.easy"
			elseif playerwhowon.ailevel == 4 then
				MultiScore[index][4] = "FE.normal"
			elseif playerwhowon.ailevel == 5 then
				MultiScore[index][4] = "FE.hard"
			end
		end
	end
	Mission.MissionEndCalled = true
	Mission.TimeIsUp = true
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaC12MissionEnd, 0.5)
end

function luaC12MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true

		local highestindex, highestplayerscore = luaC12GetHighestScoreOwner()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for idx,tbl in pairs(Mission.Objectives.primary) do
			if idx ~= objindex then
				luaObj_Failed("primary", idx)
			end
		end

		luaC12EndMovie()
	end
end

function luaC12EndMovie()
	local endEnt = GenerateObject("Competitive - MovieSub")
	SetSubmarineDepthLevel(endEnt, 1)
	NavigatorForceTorpedo(endEnt,true)
	luaC12AddAchievements()
	luaMissionCompletedNew(endEnt, "", nil, nil, nil, PARTY_JAPANESE)
	Mission.MissionEnd = true
end

function luaC12ShowMissionHint()
	ShowHint("ID_Hint_Competitive12")
end

function luaC12CheckTorpedoReload()
	for idx,unit in pairs(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.submarine)) do
		 if not unit.reloadInProgress then
		 	local torpnum = GetProperty(unit, "TorpedoStock")
		 	if torpnum == 0 then
		 		luaDelay(luaSC12SetMaxTorps, 15, "unitID", unit.ID)
		 		unit.reloadInProgress = true
		 		local playerIDx = GetRoleAvailable(unit)
		 		MissionNarrativePlayer(playerIDx[1], "mp12.nar_comp_reload")
		 	end
		end
	end
end

function luaSC12SetMaxTorps(timerThis)
	local ID = timerThis.ParamTable.unitID
	local unit = thisTable[tostring(ID)]

	--luaLog("luaSC12SetMaxTorps called")
	--luaLog(ID)
	--luaLog(unit)

	if unit and not unit.Dead then
		ShipSetTorpedoStock(unit, unit.Class.MaxTorpedoStock)
		unit.reloadInProgress = false
	end
end

function luaC12SelectRndTrg()

end

function luaC12AddRndKillListener(target)
	AddListener("kill", "TargetKill", {
				["callback"] = "luaC12TargetKill",
				["entity"] = {target},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
			})
		Mission.ListenerActive = true
end

function luaC12TargetKill(target, lastAttacker)
	--luaLog("faszomat ma bazzeg kibaszott listenere a vilagnak")
	--luaLog(lastAttacker)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
		--luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)

		if lastAttackerPlayerIndex ~= nil and lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
			for i = 0, 7 do
				if i == lastAttackerPlayerIndex then
					MissionNarrativePlayer(i, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
				end
			end
			--luaLog(" lastAttackerPlayerIndex "..tostring(i))

		else
			--luaLog(" FAIL!!! lastAttackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! lastAttacker")
	end
	if IsListenerActive("kill", "TargetKill") then
		RemoveListener("kill", "TargetKill")
		Mission.ListenerActive = false
	end

	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

function luaC12CheckListeners()
-- RELEASE_LOGOFF  	luaLog(" Checking Listeners...")
	if not Mission.ListenerTimerSet then
-- RELEASE_LOGOFF  		luaLog("  setting listener timer")
		Mission.ListenerTimerSet = true
		Mission.ListenerTimer = 30
		Mission.ReminderTimer = 0
	end

	if GameTime() > Mission.ListenerTimer and not Mission.ListenerActive then

		Mission.RandomTarget = luaPickRnd(luaRemoveDeadsFromTable(Mission.Convoy))

		if not Mission.RandomTarget then
			return
		end

		for idx,tbl in pairs (Mission.Objectives["primary"]) do
			luaObj_AddUnit("primary", idx, Mission.RandomTarget)
		end
		if Mission.RandomTarget and not Mission.RandomTarget.Dead then
			AISetHintWeight(Mission.RandomTarget, 300)
			SetSkillLevel(Mission.RandomTarget, SKILL_SPNORMAL)
			luaC12AddRndKillListener(Mission.RandomTarget)
		end
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")

	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then

		Mission.ReminderTimer = GameTime() + 22
		if not Mission.RandomTarget.Dead then
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
		else
-- RELEASE_LOGOFF  			luaLog("  ERROR!!! Mission.ListenerActive was wrong")
			Mission.ListenerActive = false
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
		end
	end
end

function luaC12CheckEndConds()
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaC12GetHighestScoreOwner()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
			--luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
			local PlayersInGame = GetPlayerDetails()
			local playerwhowon = PlayersInGame[highestindex]
			for index, value in pairs (PlayersInGame) do
				if playerwhowon.playerName ~= "" then
					MultiScore[index][4] = playerwhowon.playerName
					Mission.WinnerPlayer = playerwhowon.playerName
				else
					Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
					Mission.WinnerPlayerAILevel = playerwhowon.ailevel
					if playerwhowon.ailevel == 3 then
						MultiScore[index][4] = "FE.easy"
					elseif playerwhowon.ailevel == 4 then
						MultiScore[index][4] = "FE.normal"
					elseif playerwhowon.ailevel == 5 then
						MultiScore[index][4] = "FE.hard"
					end
				end
			end
			Mission.MissionEndCalled = true
			Mission.PointLimitReached = true
			CountdownCancel()
			ForceMultiScoreSend()
			luaDelay(luaC12MissionEnd, 0.5)
		end
	end
end


function luaC12CheckSpawnPoints()
--[[
	Mission.SpawnPointGap = 500
	Mission.SpawnPointDistFromPath = 2800
	Mission.SpawnPoints = {}
	Mission.ActualPosNum = 1
]]

	local mostShipsAround
	local shipsAroundNum = 0

	for idx,point in pairs(Mission.PossibleSpawnPoints) do

		local _dummy = luaGetShipsAroundCoordinate(point, 2000, PARTY_ALLIED, "own")

		if type(_dummy) == "table" and (table.getn(_dummy) > shipsAroundNum) then
			mostShipsAround = idx
			shipsAroundNum = table.getn(_dummy)
		end

	end

	if not mostShipsAround then
		return
	end

	if Mission.ActualPosNum ~= mostShipsAround then
-- RELEASE_LOGOFF  		luaLog("found a new possible spawnpoint")
		local pos = Mission.PossibleSpawnPoints[mostShipsAround]

		local i=1
		local j=1

		for idx,point in pairs(Mission.SpawnPoints) do
			local newpos = pos
			local origPos = GetPosition(point)
			if idx <= 4 then
				newpos.z = origPos.z
				newpos.x = newpos.x + i*(Mission.SpawnPointGap)
				i = i + 1
			else
				newpos.z = origPos.z
				newpos.x = newpos.x + j*(Mission.SpawnPointGap)
				j = j + 1
			end
			if not IsInBorderZone(newpos) then
				PutTo(point, newpos)
			end
		end

	end

end

function luaC12CheckRespawn()
	for idx,unit in pairs(luaSumTablesIndex(Mission.Convoy, Mission.ASWs, Mission.DDs)) do
		if unit.Dead and luaC12NeedToRespawn(unit) then
			table.insert(Mission.Units2Respawn, {unit.ID, unit.Class.ID, unit.Path})
		end
	end

	--if Mission.RecentShipRespawn then
	--	return
	--end

	if table.getn(Mission.Units2Respawn) > 0 then
		local ID = Mission.Units2Respawn[1][2]

-- RELEASE_LOGOFF  		luaLog(Mission.Units2Respawn)

		if Mission.RespawnTemplates[ID][1] then
			local template = luaFindHidden(Mission.RespawnTemplates[ID][1])
			local pos, newpath = luaC12GetSpawnPos(Mission.Units2Respawn[1][3])

			if not pos then
				return
			end

			local unit = GenerateObject(template.Name, pos)
			--local unit = GenerateObject(templateName)
			table.insert(Mission.RespawnTemplates[ID][2], unit)

			if newpath then
				unit.Path = newpath
			else
				unit.Path = Mission.Units2Respawn[1][3]
			end

			NavigatorMoveOnPath(unit, unit.Path, PATH_FM_SIMPLE, PATH_SM_JOIN, Mission.MinShipSpeed)
			table.remove(Mission.Units2Respawn, 1)
			Mission.RecentShipRespawn = true
			--luaDelay(luaC12ResetShipSpawnFlag, 5)

		end
	end

end

function luaC12ResetShipSpawnFlag()
	Mission.RecentShipRespawn = false
end

function luaC12NeedToRespawn(unit)

	local currentNum = 0
	for idx,ship in pairs(luaSumTablesIndex(Mission.DDs, Mission.ASWs, Mission.Convoy)) do
		if ship and not ship.Dead and ship.Class.ID == unit.Class.ID then
			currentNum = currentNum + 1
		end
	end

	local inQ = 0
	for idx,tbl in pairs(Mission.Units2Respawn) do
		if unit.ID == tbl[1] then
			return false
		end
		if unit.Class.ID == tbl[2] then
			inQ = inQ + 1
		end
	end

	if currentNum + inQ >= Mission.RespawnMaxUnits[unit.Class.ID] then
		return false
	end

	return true
end

function luaC12GetSpawnPos(path)

	local pathTbl = FillPathPoints(path)
	local startPt = pathTbl[1]
	local refUnit
	local onPath = 0
	local isDD = false

	if string.find(path.Name, "DDPath") or string.find(path.Name, "ASWPath") then
		isDD = true
	end

	local dist = 10000
	local minDist = 10000

	if not isDD then
		for idx,unit in pairs(luaSumTablesIndex(Mission.DDs, Mission.ASWs, Mission.Convoy)) do
			if not unit.Dead and unit.Path.ID == path.ID then
				if luaGetDistance(unit, startPt) < dist then
					refUnit = unit
				end
				onPath = onPath + 1
			elseif not unit.Dead then
				local dist2 = luaGetDistance(unit, startPt)
				if dist2 < minDist then
					minDist = dist2
				end
			end
		end

		if refUnit and onPath < 3 then

			--return GetPosition(refUnit)
			local pos = GetPosition(refUnit)
			pos.x = pos.x + 400
			pos.y = 0

-- RELEASE_LOGOFF  			luaLog("returning unitref pos")
			local returnPos = {["x"]=pos.x, ["y"]=pos.y, ["z"]=pos.z}

			if IsInBorderZone(returnPos) then
				return nil
			end
			return returnPos

		else

			--path parja kell
			local startPt
			local newpath

			if luaIsInside(path, Mission.ConvoyPath) and onPath >= 3 then
				if path.Name == Mission.ConvoyPath[2].Name then
					startPt = FillPathPoints(Mission.ConvoyPath[3])[1]
					newpath = Mission.ConvoyPath[3]
				elseif path.Name == Mission.ConvoyPath[3].Name then
					startPt = FillPathPoints(Mission.ConvoyPath[2])[1]
					newpath = Mission.ConvoyPath[2]
				end
			end

			if not startPt then
				startPt = FillPathPoints(path)[1]
			end

			startPt.x = (startPt.x - minDist) + 400
			startPt.y = 0

			local returnPos = {["x"]=startPt.x, ["y"]=startPt.y, ["z"]=startPt.z}
-- RELEASE_LOGOFF  			luaLog("returning absolute pos")
			if IsInBorderZone(returnPos) then
				return nil
			end
			return returnPos, newpath

		end

	else

-- RELEASE_LOGOFF  		luaLog("isDD")
-- RELEASE_LOGOFF  		luaLog(path)
		local dist = 10000
		local minDist = 10000

		local DDPathTbl = {Mission.DDPath[1],Mission.DDPath[2],Mission.DDPath[3],Mission.DDPath[4]}

		for idx,unit in pairs(luaSumTablesIndex(Mission.DDs, Mission.ASWs, Mission.Convoy)) do
			if not unit.Dead then
				local dist2 = luaGetDistance(unit, startPt)
				if dist2 < minDist then
					minDist = dist2
				end
				local key = luaIsInside(unit.Path, DDPathTbl)
				if key then
					table.remove(DDPathTbl, key)
				end
			end
		end

		local newpath
		if table.getn(DDPathTbl) > 0 then
			newpath = luaPickRnd(DDPathTbl)
		else
			newpath = luaPickRnd(Mission.DDPath)
		end

		local startPt = FillPathPoints(newpath)[1]
		startPt.x = (startPt.x - minDist) + 400
		startPt.y = 0

		local returnPos = {["x"]=startPt.x, ["y"]=startPt.y, ["z"]=startPt.z}
		if IsInBorderZone(returnPos) then
			return nil
		end
		return returnPos, newpath

	end

end

function luaAddCVListener()
	AddListener("kill", "BogueKill", {
		["callback"] = "luaC12BogueKill",
		["entity"] = {Mission.USNCarrier},
		["lastAttacker"] = {},
		["lastAttackerPlayerIndex"] = {},
	})
end

function luaC12BogueKill(target, lastAttacker)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(" LISTENER: Bogue killed by player "..lastAttackerPlayerIndex)

		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			AddPowerup(lastAttackerPlayerIndex , {["classID"] = "automatic_reloader",["useLimit"] = 1})
			MissionNarrativePlayer(lastAttackerPlayerIndex, "mp12.nar_new_supply")
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! Bogue lastAttackerPlayerIndex")
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! Bogue lastAttacker")
	end
end

function luaC12GotRocket(unit)
	if unit and not unit.Dead then
		if table.getn(GetPayloads(unit)) == 0 then
      PlaneReloadBombPlatforms(unit)
  	end
	end
end

function luaC12CheckAchievement()

	local ownSubs = luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.submarine)

	for idx,unit in pairs(ownSubs) do

		local playerIdx = GetRoleAvailable(unit)[1]
		local unitID = unit.ID

		if Mission.AchievemntTbl[playerIdx]["check_needed"] then

			if Mission.AchievemntTbl[playerIdx]["lastUnitID"] == -1 then
				Mission.AchievemntTbl[playerIdx]["lastUnitID"] = unitID
			else
				if Mission.AchievemntTbl[playerIdx]["lastUnitID"] ~= unitID then
					Mission.AchievemntTbl[playerIdx]["check_needed"] = false
				end
			end

		end

	end

end

function luaC12AddAchievements()

	local MPlayers = GetPlayerDetails()
	local highestindex, highestplayerscore = luaC12GetHighestScoreOwner()

	for idx,playerTbl in pairs(MPlayers) do

		if playerTbl["party"] == PARTY_JAPANESE and not playerTbl["ai"] then
			--local pIdx = playerTbl["playerindex"]
			local pIdx = playerTbl["playerslot"]
			if Mission.AchievemntTbl[pIdx]["check_needed"] and pIdx == highestindex then
				--SetAchievements(playerTbl["playerindex"],"MA_DLC03TS")
				SetAchievements(pIdx,"MA_DLC03TS")
-- RELEASE_LOGOFF  				luaLog("Achievement NAME added to playerindex "..tostring(playerTbl["playerindex"]))
			end
		end

	end
end
