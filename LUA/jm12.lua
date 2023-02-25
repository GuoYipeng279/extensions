--SceneFile="universe\Scenes\missions\IJN\ijn_12_havaii_2.scn"

--KIBASZOTT TODO:
--dialogok
--nemhasznalt fv-k
--kibaszott hajonevek es szamok
--ojjektiva kiiras veglegesitese


DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",12)

	Dialogues = {
		["Intro"] = {
			["sequence"] = {
				{
					["message"] = "idlg01a",
				},
				{
					["message"] = "idlg01a_1",
				},
				{
					["message"] = "idlg01b",
				},
			},
		},
	}

	MissionNarrative("ijn12.date_location")
	luaDelay(luaJM12EMDlg, 14.5)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitJM12")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM12(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM12.lua"

	this.Name = "JM12"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	this.Party = SetParty(this, PARTY_JAPANESE)

	Mission.Difficulty = GetDifficulty()

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)

	luaLoadControlFunctionNames()

	--reload
	SetDeviceReloadEnabled(true)

	--checkpoints
	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM12LoadMissionData},
	}
	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM12SaveMissionData},
	}

	Mission.CVEnts = {}
	Mission.ScoreDisplay = {}

	Mission.ConvoyNames = {"ingame.shipnames_hatfield","ingame.shipnames_knox", "ingame.shipnames_ormsby", "ingame.shipnames_windsor"}

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "meeting",
				["Text"] = "ijn12.obj_p1", --Fly to the navigation point to locate the german submarine
				["TextCompleted"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "land",
				["Text"] = "ijn12.obj_p2", --Land on the water near the german submarnie
				["TextCompleted"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "convoy",
				["Text"] = "ijn12.obj_p3",	--Sink all ships of the convoy
				["TextCompleted"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "cvgroup",
				["Text"] = "ijn12.obj_p4",	--Sink the submarine hunting group
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "killemall",
				["Text"] = "ijn12.obj_s1", --Eliminate all ships in the area
				["TextCompleted"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "subkill",
				["Text"] = "ijn12.obj_h1", --Kill at least one ship with both submarines
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		}
	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")


	--dialogues
	LoadMessageMap("ijndlg",12)

	Mission.Dialogues = {
		["Init"] = {
			["sequence"] = {
				{
					["message"] = "dlg1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM12InitDone",
				},

			},
		},
		["Init2"] = {
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
			},
		},

		["ConvoySighted"] = {
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
			},
		},

		["NavpointReached"] = {
			["sequence"] = {
				{
					["message"] = "dlg4",
				},
				{
					["message"] = "dlg5a",
				},
				{
					["message"] = "dlg5b",
				},
				{
					["message"] = "dlg5c",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM12NavpointReached",
				},
			},
		},

		["Landed"] = {
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
				{
					["message"] = "dlg6b_1",
				},
				{
					["message"] = "dlg6c",
				},
				{
					["message"] = "dlg6c_1",
				},
				{
					["message"] = "dlg6d",
				},
				{
					["message"] = "dlg6e",
				},
				{
					["message"] = "dlg6f",
				},
			},
		},

		["Phase2Start"] = {
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM12Phase2Started",
				},
			},
		},

		["Phase2End"] = {
			["sequence"] = {
				{
					["message"] = "dlg8a",
				},
				{
					["message"] = "dlg8b",
				},
			},
		},

		["CVSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg11a",
				},
				{
					["message"] = "dlg11b",
				},
			},
		},
		["AvengerSighted"] = {
			["sequence"] = {
				{
					["message"] = "dlg12",
				},
			},
		},
		["CrewSpeech1"] = {
			["sequence"] = {
				{
					["message"] = "dlg12a",
				},
				{
					["message"] = "dlg12b",
				},
			},
		},
		["GermanSpeech1"] = {
			["sequence"] = {
				{
					["message"] = "dlg9a",
				},
				{
					["message"] = "dlg9b",
				},
				{
					["message"] = "dlg9c",
				},
				{
					["message"] = "dlg9d",
				},
				{
					["message"] = "dlg9e",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM12JumpToCarrier",
				},
			},
		},
		["GermanSpeech2"] = {
			["sequence"] = {
				{
					["message"] = "dlg9f",
				},
				{
					["message"] = "dlg9g",
				},
				{
					["message"] = "dlg9h",
				},
				{
					["message"] = "dlg9i",
				},
				{
					["type"] = "callback",
					["callback"] = "luaJM12CVStep",
				},
			},
		},
		["TorpReload1"] = {
			["sequence"] = {
				{
					["message"] = "dlg14",
				},
			},
		},
		["TorpReload2"] = {
			["sequence"] = {
				{
					["message"] = "dlg15",
				},
			},
		},
		["HiddenComplete"] = {
			["sequence"] = {
				{
					["message"] = "dlg10",
				},
			},
		},

		["End"] = {
			["sequence"] = {
				{
					["message"] = "dlg16",
				},
				{
					["message"] = "dlg17a",
				},
				{
					["message"] = "dlg17b",
				},
			},
		},

	}

	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	Mission.MissionPhase = 1

	luaJM12InitGermanSub()
	luaJM12InitConvoy()

	Mission.PlayerUnit = FindEntity("I-52")
	--SetSelectedUnit(Mission.PlayerUnit)

	if Mission.Difficulty == 2 then
		Mission.Stock = 2
	else
		Mission.Stock = 4
	end

	SetCatapultStock(Mission.PlayerUnit, Mission.Stock)
	Mission.PlayerJake = FindEntity("E13A Jake 01")
	SetSelectedUnit(FindEntity("E13A Jake 01"))
	PilotMoveToRange(FindEntity("E13A Jake 01"), Mission.GermanSub)

	Mission.JakeRespawn = 0
	luaJM12SetGuiNames()

	--think
	SetThink(this, "luaJM12_think")

	MissionNarrativeClear()
	--SetForcedReconLevel(Mission.PlayerUnit, 2, PARTY_ALLIED)
	luaJM12FadeIn()
	luaJM12StartDialog("Init")
	luaDelay(luaJM12DelayedInitDlg, 30)
	luaDelay(luaJM12OxygeneHint, 180)

	luaJM12ShipListener()

end

function luaJM12_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")
	--luaLog("PHASE: "..tostring(Mission.MissionPhase))

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.CheckpointLoads then
		return
	end

	if Mission.EndMission then
		return
	end

	if Mission.StopThink then
		if Mission.Relocate then
			Mission.StopThink = nil
			luaJM12Back2Mission()
		else
			return
		end
	end

	luaJM12CheckObjectives()

	if Mission.MissionPhase < 99 then
		luaCheckMusic()
	end

	if Mission.MissionPhase == 1 then

		luaJM12CheckConvoy()
		--luaJM12CheckTorps()

	elseif Mission.MissionPhase == 2 then

		luaJM12CheckConvoy()
		--luaJM12CheckTorps()

	elseif Mission.MissionPhase == 3 then

		luaJM12CheckConvoy()
		luaJM12EzmegbenaHPkiiratasdemajdleszjobb()
		--luaJM12CheckTorps()

	elseif Mission.MissionPhase == 4 then

		--luaJM12CheckTorps()

	elseif Mission.MissionPhase == 5 then
		if Mission.CVInitDone then
			if not Mission.AirSquadSpawnInit then
				luaJM12SpawnNmiPlanes()
				luaJM12AddCVReconListener()
			end

			luaJM12CheckUSNGroup()
		end

		luaJM12EzmegbenaHPkiiratasdemajdleszjobb()
		--luaJM12CheckTorps()

	elseif Mission.MissionPhase == 99 then


	end

end

----objectives-----
function luaJM12DisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
	Mission.ScoreDisplay[scoreID] = true
end

function luaJM12RemoveScore(scoreID)
	HideScoreDisplay(scoreID,0)
	Mission.ScoreDisplay[scoreID] = false
end

function luaJM12Pri1Score()
	local line1 = "ijn12.obj_p1"

	local unit = GetSelectedUnit()
	if not unit then
		unit = Mission.PlayerUnit
	end

	local dist = luaJM12Metric(luaGetDistance3D(unit, Mission.GermanSub))
	Mission.Measure = GetMeasure()
	Mission.Distance = string.format("%.1f",dist)

	local line2 = "ijn12.subdistance"
	luaJM12DisplayScore(1, line1, line2)
end

function luaJM12Pri2Score()
	local line1 = "ijn12.obj_p2"
	local line2 = ""
	luaJM12DisplayScore(2, line1, line2)
end

function luaJM12Pri3Score()
	Mission.ShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.Convoy))

	local line1 = "ijn12.obj_p3"
	local line2 = "ijn12.shipsleft"
	luaJM12DisplayScore(3, line1, line2)
end

function luaJM12Pri4Score()

	if not Mission.TargetsAdded then
		for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.ASW)) do
			if not unit.Dead then
				luaObj_AddUnit("primary",4,unit)
			end
		end
		luaObj_AddUnit("primary",4,Mission.USNCarrier)

		--sec
		if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
			for idx,unit in pairs(Mission.Escorts) do
				if not unit.Dead then
					luaObj_AddUnit("secondary",1,unit)
				end
			end
		end

		Mission.TargetsAdded = true
	end

	Mission.MaxShips = 4

	if not Mission.USNCarrier.Dead then
		Mission.ShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.ASW)) + 1
	else
		Mission.ShipsLeft = table.getn(luaRemoveDeadsFromTable(Mission.ASW))
	end

	local line1 = "ijn12.obj_p4"
	local line2 = "ijn12.shipsleft"
	luaJM12DisplayScore(4, line1, line2)
end

function luaJM12Metric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		--return dist * 0.621371192
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end

end


function luaJM12CheckStock()

	ForceRecon()

	local stock = GetCatapultStock(Mission.PlayerUnit)
	local planes = recon[PARTY_JAPANESE].own.reconplane
	local sentUnits = {}

	for idx,unit in pairs(planes) do
		--luaLog(unit)
		if unit and not unit.Dead then
			table.insert(sentUnits, unit)
		end
	end

	if next(sentUnits) ~= nil then
		return true, sentUnits
	else
		if stock > 0 then
			return true, nil
		end
	end

	return false
end

function luaJM12CheckPri3()

	for idx,unit in pairs(Mission.Convoy) do
		if not unit.Dead then
			return false
		end
	end

	return true

end

function luaJM12CheckPri4()
	if Mission.USNCarrier.Dead and table.getn(luaRemoveDeadsFromTable(Mission.ASW)) == 0 then
		if table.getn(luaRemoveDeadsFromTable(Mission.Escorts)) == 0 then
			Mission.SecDone = true
		end
		return true
	else
		return false
	end
end

function luaJM12CheckObjectives()

	if Mission.PlayerUnit.Dead then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn12.obj_missionfailed_pu"
		Mission.Failent = Mission.PlayerUnit
-- RELEASE_LOGOFF  		luaLog("99es fazis, mert meghalt a player")
		luaJM12StepPhase(99)
	end

	if Mission.GermanSub.Dead then
		Mission.MissionFailed = true
		Mission.FailMsg = "ijn12.obj_missionfailed_germans"
		Mission.Failent = Mission.GermanSub
-- RELEASE_LOGOFF  		luaLog("99es fazis, mert meghalt a player")
		luaJM12StepPhase(99)
	end

	if not luaObj_IsActive("hidden",1) then
		luaObj_Add("hidden",1)
	elseif luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
		if Mission.IJNSubOK and Mission.GermanSubOK then
			luaObj_Completed("hidden",1,true)
			luaJM12AddPowerup("automatic_reloader")
		end
	end

	if Mission.MissionPhase == 1 and Mission.InitDone then

		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1)
			local coord = GetPosition(Mission.GermanSub)
			luaObj_AddUnit("primary",1,coord)
			luaObj_AddReminder("primary",1)
			luaJM12Pri1Score()
		elseif luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
			local avail,sentUnits = luaJM12CheckStock()
			if avail then
				--complete check
				if sentUnits then
					for idx,unit in pairs(sentUnits) do
						if luaGetDistance(unit, Mission.GermanSub) < 1200 then
							luaObj_Completed("primary",1,true)
							luaJM12StartDialog("NavpointReached")
							luaJM12RemoveScore(1)
							luaJM12StepPhase()
							break
						end
					end
				end
				--reminder check
				if luaObj_GetSuccess("primary",1) == nil then
					luaObj_Reminder("primary",1)
					luaJM12Pri1Score()
				else

				end
			else
				luaObj_Failed("primary",1)
				Mission.MissionFailed = true
				Mission.FailMsg = "ijn12.obj_missionfailed_nomoreplanes"
				Mission.Failent = Mission.GermanSub
				luaJM12StepPhase(99)
			end

		end

	elseif Mission.MissionPhase == 2 and Mission.Reached then

		if not luaObj_IsActive("primary",2) then
			luaObj_Add("primary",2)
			local coord = GetPosition(Mission.GermanSub)
			luaObj_AddUnit("primary",2,coord)
			luaObj_AddReminder("primary",2)
			luaJM12Pri2Score()
			luaJM12HintLand()
		elseif luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
			local avail,_dummy = luaJM12CheckStock()
			if avail then
				local unit = GetSelectedUnit()
				if unit and luaGetType(unit) == "plane" and luaGetDistance(Mission.GermanSub,unit) < 200 and IsUnitSelectable(unit) and GetPosition(unit).y < 10 and GetEntitySpeed(unit) < 30 then
					luaObj_Completed("primary",2,true)
					luaJM12RemoveScore(2)
					luaJM12StartEmovie()
					luaJM12StepPhase()
					Mission.StopThink = true
				else
					luaObj_Reminder("primary",2)
				end
			else
				luaObj_Failed("primary",2)
				Mission.MissionFailed = true
				Mission.FailMsg = "ijn12.obj_missionfailed_nomoreplanes"
				Mission.Failent = Mission.GermanSub
				luaJM12StepPhase(99)
			end
		end

	elseif Mission.MissionPhase == 3 and Mission.Phase2Started then

		if not luaObj_IsActive("primary",3) then
			luaObj_Add("primary",3)
			luaObj_Add("secondary",1)
			for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.Convoy)) do
				luaObj_AddUnit("primary",3,unit)
			end
			luaObj_AddReminder("primary",3)
			luaJM12Pri3Score()
			luaJM12AddPowerup("hardened_armour")
		elseif luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
			local success = luaJM12CheckPri3()
			if success then
				luaObj_Completed("primary",3,true)
				luaJM12StartDialog("Phase2End")
				luaJM12RemoveScore(3)
				luaJM12StartEmovie2()
				luaJM12StepPhase()
			elseif not success and table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) > 0 then
				luaJM12Pri3Score()
				luaObj_Reminder("primary",3)
			elseif not success and table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) == 0 then
				luaObj_Failed("primary",3)
				luaJM12RemoveScore(3)
				Mission.MissionFailed = true

				for idx,unit in pairs(Mission.Convoy) do
					if unit and not TrulyDead(unit) then
						Mission.Failent = unit
						break
					end
				end

				Mission.FailMsg = "ijn12.obj_missionfailed_convoy"
				luaJM12StepPhase(99)
			end
		end

	elseif Mission.MissionPhase == 4 then

	elseif Mission.MissionPhase == 5 then

		if not luaObj_IsActive("primary",4) then
			luaObj_Add("primary",4)
			luaObj_AddReminder("primary",4)
			luaJM12Pri4Score()

		elseif luaObj_IsActive("primary",4) and luaObj_GetSuccess("primary",4) == nil then
			if luaJM12CheckPri4() then
				luaObj_Completed("primary",4)
				luaJM12RemoveScore(4)

				if Mission.SecDone then
					luaObj_Completed("secondary",1)
				else
					luaObj_Failed("secondary",1)
				end

				for idx,unit in pairs(luaSumTablesIndex({Mission.USNCarrier}, Mission.Escorts)) do
					if not TrulyDead(unit) then
						Mission.Compent = unit
						break
					end
				end

				Mission.MissionCompleted = true
				luaJM12StepPhase(99)
			else
				luaObj_Reminder("primary",4)
				luaJM12Pri4Score()
			end
		end

	elseif Mission.MissionPhase == 99 then

		if Mission.MissionFailed then
			if Mission.Failent and not TrulyDead(Mission.Failent) then
				luaMissionFailedNew(Mission.Failent, Mission.FailMsg)
			else
				if Mission.PlayerUnit.Dead then
					if Mission.PlayerUnit.LastBanto and not Mission.PlayerUnit.LastBanto.Dead then
						luaMissionFailedNew(Mission.PlayerUnit.LastBanto, Mission.FailMsg)
					else
						luaMissionFailedNew(nil, Mission.FailMsg)
					end
				elseif Mission.GermanSub.Dead then
					if Mission.GermanSub.LastBanto and not Mission.GermanSub.LastBanto.Dead then
						luaMissionFailedNew(Mission.GermanSub.LastBanto, Mission.FailMsg)
					else
						luaMissionFailedNew(nil, Mission.FailMsg)
					end
				else
					--na itt mi van kimentek a hajok?
					luaMissionFailedNew(nil, Mission.FailMsg)
				end
			end
		end

		if Mission.MissionCompleted then
			if Mission.Compent and not TrulyDead(Mission.Compent) then
				luaMissionCompletedNew(Mission.Compent, "ijn12.obj_missioncompleted")
			else
				luaMissionCompletedNew(Mission.PlayerUnit, "ijn12.obj_missioncompleted")
			end

			local medal = luaGetMedalReward()
			if medal == MEDAL_GOLD then
				Scoring_GrantBonus("JM12_SCORING_GOLD1", "ijn12.bonus1_title", "ijn12.bonus1_text", 14)
				--Scoring_GrantBonus("JM12_SCORING_GOLD1", "ijn12.bonus1_title", "ijn12.bonus1_text", 14)
			end

		end

		Mission.EndMission = true
		luaJM12StepPhase()
	end
end

function luaJM12IsPlayerInRecon()
	if luaGetReconLevel(Mission.PlayerUnit, PARTY_ALLIED) == 2 then
		return true, GetPosition(Mission.PlayerUnit), Mission.PlayerUnit
	elseif luaGetReconLevel(Mission.GermanSub, PARTY_ALLIED) == 2 then
		return true, GetPosition(Mission.GermanSub), Mission.GermanSub
	end

	return false, false
end

function luaJM12AvengerReturns()
	if not Mission.Avenger.Dead then
		UnitSetFireStance(Mission.Avenger,STANCE_HOLD_FIRE)
		if not Mission.USNCarrier.Dead then
			PilotLand(Mission.Avenger, Mission.USNCarrier)
		else
			PilotRetreat(Mission.Avenger)
		end
	end
end

function luaJM12CheckMaxplanes()
	if not Mission.USNCarrier or Mission.USNCarrier.Dead then
		return
	end

	--maxplanes check
	for idx,slot in pairs(GetProperty(Mission.USNCarrier,"slots")) do
		if GetAirBaseSlotStatus(Mission.USNCarrier,idx) == 5 then
			if Mission.USNCarrier.Maxplanes == 0 then
				--MissionNarrativeEnqueue(airfield.Name.." has no more planes")
-- RELEASE_LOGOFF  				luaLog("no more planes")
			else
				Mission.USNCarrier.Maxplanes = Mission.USNCarrier.Maxplanes - 1
-- RELEASE_LOGOFF  				luaLog("Removing squadron from stock "..Mission.USNCarrier.Name)
			end
		end
	end
end


function luaJM12CheckUSNGroup()

		luaJM12CheckMaxplanes()

		--spawned avenger
		if Mission.Avenger and not Mission.Avenger.Dead then
			local unitcmd = GetProperty(Mission.Avenger, "unitcommand")
			local y = math.ceil(GetPosition(Mission.PlayerUnit).y)
			if GetSubmarineDepthLevel(Mission.PlayerUnit) == 0 and y == 0 and unitcmd ~= "strafe" then
				PilotSetTarget(Mission.Avenger,Mission.PlayerUnit)
				UnitFreeFire(Mission.Avenger)
				luaJM12StartDialog("AvengerSighted")
				ShowHint("IJN12_Fido")
				luaDelay(luaJM12AvengerReturns,360)
			end
		end

		--CV
		if not Mission.USNCarrier.Dead then
			local slots,squads = luaGetSlotsAndSquads(Mission.USNCarrier)
			if slots == 0 then

				if IsReadyToSendPlanes(Mission.USNCarrier) then
					LaunchSquadron(Mission.USNCarrier, 102, 3)
				end

			elseif slots > 0 and slots < 3 then

				local cap
				for idx,unit in pairs(squads) do
					if unit.Class.Type == "Fighter" then
						cap = true
						break
					end
				end
				if IsReadyToSendPlanes(Mission.USNCarrier) then
					if not cap then
						LaunchSquadron(Mission.USNCarrier, 102, 3)
					else
						LaunchSquadron(Mission.USNCarrier, 38, 1, 2)
					end
				end

			elseif slots >= 3 then

				Mission.inRecon, Mission.inReconPos, Mission.ReconTrg = luaJM12IsPlayerInRecon()

				if Mission.inRecon then

					for idx,unit in pairs(squads) do
						local ammo = GetProperty(unit, "ammoType")
						if unit.Class.Type ~= "Fighter" and ammo ~= 0 and luaGetScriptTarget(unit) == nil then
							PilotSetTarget(unit, Mission.ReconTrg)
							luaSetScriptTarget(unit, Mission.ReconTrg)
							if unit.movingToPos then
								unit.movingToPos = false
							end
						end
					end
					Mission.LastKnownPos = Mission.inReconPos

				else

					for idx,unit in pairs(squads) do
						if unit.Class.Type ~= "Fighter" then
							if luaGetScriptTarget(unit) and not luaGetScriptTarget(unit).Dead then
								unit.ScriptTarget = nil
							end
							if Mission.LastKnownPos then
								if not unit.movingToPos then
									unit.movingToPos = true
									PilotMoveToRange(unit, Mission.LastKnownPos)
								end
							end
						end
					end

				end
			end

		else

			if not Mission.NoMorePlanes then
				local planes = luaSumTablesIndex(recon[PARTY_ALLIED].own.fighter, recon[PARTY_ALLIED].own.divebomber, recon[PARTY_ALLIED].own.torpedobomber)

				if table.getn(luaRemoveDeadsFromTable(planes)) == 0 then
					Mission.NoMorePlanes = true
				end

				for idx,unit in pairs(planes) do
					if not unit.Dead and not unit.retreating then
						if unit.Class.Type == "Fighter" then
							PilotRetreat(unit)
							unit.retreating = true
						else
							if GetProperty(unit,"ammoType") ~= 0 then
								Mission.inRecon, Mission.inReconPos, Mission.ReconTrg = luaJM12IsPlayerInRecon()
								if Mission.inRecon and (luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead) then
									PilotSetTarget(unit, Mission.ReconTrg)
									luaSetScriptTarget(unit, Mission.ReconTrg)
									Mission.LastKnownPos = Mission.inReconPos
									unit.movingToPos = false
								else
									if not unit.movingToPos then
										PilotMoveToRange(unit, Mission.LastKnownPos)
									end
								end
							else
								PilotRetreat(unit)
								unit.retreating = true
							end
						end
					end
				end

			end

		end

		--Escort
		Mission.Escorts = luaRemoveDeadsFromTable(Mission.Escorts)
		if table.getn(Mission.Escorts) ~= 0 then

			local ships
			if not Mission.USNCarrier.Dead then
				ships = luaGetShipsAround(Mission.USNCarrier, 2000, "enemy", nil, nil, "submarine")
			else
				ships = luaGetShipsAround(Mission.Escorts[1], 20000, "enemy", nil, nil, "submarine")
			end

			if ships then
				if not Mission.AttackingDD or Mission.AttackingDD.Dead then
					Mission.AttackingDD	= luaPickRnd(Mission.Escorts)
					if IsInFormation(Mission.AttackingDD) then
						LeaveFormation(Mission.AttackingDD)
					end
					luaSetScriptTarget(Mission.AttackingDD, Mission.PlayerUnit)
					NavigatorAttackMove(Mission.AttackingDD, Mission.PlayerUnit, {})
					luaJM12StartDialog("CrewSpeech1")
					if not luaObj_IsActive("secondary", 1) then
						luaObj_Add("secondary",1,Mission.ASW)
						ShowHint("IJN12_ASW")
						ShowHint("IJN12_Dive")
					end
				end
			else
				if Mission.AttackingDD and not Mission.AttackingDD.Dead then
					if not IsInFormation(Mission.AttackingDD) then
						if not Mission.USNCarrier.Dead then
							JoinFormation(Mission.AttackingDD, Mission.USNCarrier)
						else
							local leader
							for idx,unit in pairs(Mission.Escorts) do
								if IsInFormation(unit) then
									JoinFormation(Mission.AttackingDD, GetFormationLeader(unit))
									break
								end
							end
						end
					end
					if luaGetScriptTarget(Mission.AttackingDD) then
						Mission.AttackingDD.ScriptTarget = nil
					end
					Mission.AttackingDD = nil
				end
			end
		end

	--end
end

function luaJM12SpawnNmiPlanes()

	local point,_dummy = luaJM12GetSpawnPoint(GetPosition(Mission.PlayerUnit),4000)
	point = luaPickRnd(point)

	if point and not point.Dead then
	--if point and not luaIsVisibleCoordinate(Mission.PlayerUnit,point,4000) and not IsInBorderZone(point) then
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				[1] = {
					["Type"] = 38,
					["Name"] = "SB2C Helldiver",
					["Crew"] = 1,
					["Race"] = USA,
					["WingCount"] = 3,
					["Equipment"] = 2,
				},
			},
			["area"] = {
				["refPos"] = point,
				["angleRange"] = { luaJM12RAD(0), luaJM12RAD(180)},
				["lookAt"] = GetPosition(Mission.PlayerUnit),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 200,
				["ownVertical"] = 75,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			["callback"] = "luaJM12AirSquadSpawned",
			["id"] = "airsquadspawnreq",
		})
		Mission.AirSquadSpawnInit = true
	else
-- RELEASE_LOGOFF  		luaLog("No valid spawnpoint found")
	end

end

function luaJM12AirSquadSpawned(unit)
	--if not Mission.USNCarrier.Dead then
	--	SquadronSetHomeBase(unit, Mission.USNCarrier)
	--end
	--SetForcedReconLevel(Mission.PlayerUnit, 2, PARTY_ALLIED)
	PilotMoveToRange(unit, Mission.PlayerUnit)
	Mission.Avenger = unit
end

function luaJM12GetSpawnPoint(pos,modifier)
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

function luaJM12RAD(x)
	return x *  0.0174532925
end

function luaJM12InitGermanSub()
	Mission.GermanSub = FindEntity("German Type VII submarine 01")
	SetGuiName(Mission.GermanSub, "ingame.shipnames_u530")
	SetNumbering(Mission.GermanSub, 530)
	SetParty(Mission.GermanSub, PARTY_NEUTRAL)
	SetForcedReconLevel(Mission.GermanSub, 0, PARTY_ALLIED)
	SetRoleAvailable(Mission.GermanSub, EROLF_ALL, PLAYER_AI)
	SetInvincible(Mission.GermanSub, true)
	NavigatorStop(Mission.GermanSub)
	SetSubmarineDepthLevel(Mission.GermanSub, 0)
end

function luaJM12GermanSpeech()
	luaJM12StartDialog("GermanSpeech1")
	--luaJM12StartDialog("GermanSpeech2")
	--if Mission.CVSighted then
	--ShowHint("IJN12_Radar")
	SetSimplifiedReconMultiplier(1)
	--end
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.GermanSub.ID)
end

function luaJM12AddCVReconListener()
	if Mission.USNCarrier and not Mission.USNCarrier.Dead then
		AddListener("recon", "cvlistener", {
			["callback"] = "luaJM12CVSighted",  -- callback fuggveny
			["entity"] = { Mission.USNCarrier }, -- entityk akiken a listener aktiv
			["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
			["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
			["party"] = {PARTY_JAPANESE}
			})
	end
end

function luaJM12CVSighted()
	RemoveListener("recon", "cvlistener")
	Mission.CVSighted = true
end

function luaJM12AddConvoyReconListener()
	if Mission.CheckpointLoaded then
		return
	end
	
	Mission.Convoy = luaRemoveDeadsFromTable(Mission.Convoy)
	AddListener("recon", "convoylistener", {
		["callback"] = "luaJM12ConvoySighted",  -- callback fuggveny
		["entity"] = Mission.Convoy, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = {PARTY_JAPANESE}
		})
end

function luaJM12ConvoySighted()
	RemoveListener("recon", "convoylistener")

	Mission.SelectedUnit = GetSelectedUnit()

	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead and Mission.SelectedUnit.Class.Type ~= "Submarine" then
		UnitHoldFire(Mission.SelectedUnit)
		UnitSetFireStance(Mission.SelectedUnit, STANCE_HOLD_FIRE)
		--PilotMoveToRange(Mission.SelectedUnit, Mission.GermanSub)
	end

	luaJM12StartDialog("ConvoySighted")

	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.ConvoyLeader, ["distance"] = 250, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.ConvoyLeader, ["distance"] = 450, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 6},
		}, luaJM12IngameMovieEnd, true)

end

function luaJM12IngameMovieEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		--if Mission.SelectedUnit.Class.Type ~= "Submarine" then
			--luaDelay(luaJM12DelayedTTProFix, 1)
		--end
		SetSelectedUnit(Mission.SelectedUnit)
	else
		if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
			SetSelectedUnit(Mission.PlayerUnit)
		end
	end

	EnableInput(true)
end

function luaJM12DelayedTTProFix()
	PilotMoveToRange(Mission.SelectedUnit, Mission.GermanSub)
end

function luaJM12StepPhase(phase)
	if phase ~= nil and type(phase) == "number" then
-- RELEASE_LOGOFF  		luaLog("Setting phase to "..tostring(phase))
-- RELEASE_LOGOFF  		luaLog("Caller: "..debug.traceback())
		Mission.MissionPhase = phase
	else
-- RELEASE_LOGOFF  		luaLog("Setting phase to "..tostring(phase))
-- RELEASE_LOGOFF  		luaLog("Caller: "..debug.traceback())
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM12StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM12StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM12StartDialog cannot continue, non existing dialog: "..dialogID, 2)
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

function luaPrecacheUnits()
	Loading_Start()
	PrepareClass(193)
	PrepareClass(113)
	PrepareClass(102)
	PrepareClass(101)
	PrepareClass(16)
	PrepareClass(38)
	PrepareClass(108)
	PrepareClass(109)
	PrepareClass(172)
	Loading_Finish()
end

function luaJM12AddPowerup(type)
-- RELEASE_LOGOFF  	luaLog("powerup granted "..tostring(type))
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrativeEnqueue("missionglobals.newpowerup")
end

function luaJM12SetGuiNames()
-- RELEASE_LOGOFF  	luaLog("allitom a guineveket")

	--[[for idx, unit in pairs(Mission.Escorts) do
		SetGuiName(unit, Mission.EscortNames[idx])
	end

	SetGuiName(Mission.USNCarrier, "ingame.shipnames_bogue")]]

	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		if IsClassChanged(Mission.PlayerUnit.Class.ID) then
			if Mission.PlayerUnit.Class.ID == 81 then
				SetGuiName(Mission.PlayerUnit, "globals.unitclass_typeb_kaiten")
			elseif Mission.PlayerUnit.Class.ID == 8 then
-- RELEASE_LOGOFF  				luaLog("i400")
				SetGuiName(Mission.PlayerUnit, "ingame.shipnames_i400")
			else
				SetGuiName(Mission.PlayerUnit, Mission.PlayerUnit.Class.Name)
			end
		else
			SetGuiName(Mission.PlayerUnit, "ingame.shipnames_i52")
		end
	end

end

function luaJM12FadeIn()
	luaCheckSavedCheckpoint()

	if not Mission.CheckpointLoaded then
		--SoundFade(1, "",0.1)
		Blackout(false, "", 0.5)
	else
		EnableInput(false)
		Blackout(true, "", 0.5)
		Mission.CheckpointLoads = true
	end

end

function luaJM12CVStep()
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.USNCarrier.ID)
	--SetSimplifiedReconMultiplier(1)
	luaJM12StepPhase()
	Blackout(true, "luaJM12Checkpoint1", 1)
-- RELEASE_LOGOFF  	luaLog("egy fazist leptem, megjott a carrier, mostani fazis: "..tostring(Mission.MissionPhase))
end

function luaJM12Checkpoint1()
	luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM12OxygeneHint()
	ShowHint("IJN12_Oxygene")
end

function luaJM12HintLand()
	ShowHint("IJN12_Land")
end

function luaJM12EMDlg()
	StartDialog("Intro_dlg1", Dialogues["Intro"]);
end

function luaJM12InterMezzo()

	local pos = {["x"]=-30,["y"]=0,["z"]=100}
	PutRelTo(Mission.GermanSub, Mission.PlayerUnit, pos)

	for idx,unit in pairs(Mission.Escorts) do
		JoinFormation(unit, Mission.USNCarrier)
	end

	NavigatorMoveOnPath(Mission.USNCarrier, FindEntity("CarrierPath"), PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
	SetShipSpeed(Mission.USNCarrier, 30)
	NavigatorStop(Mission.GermanSub)

	--[[luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 200, ["theta"] = 5, ["rho"] = 340, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 50, ["theta"] = 5, ["rho"] = 340, ["moveTime"] = 5},
		}, luaJM12Intermezzo2, true)]]

	if not Mission.SavedCheckpoint then

-- RELEASE_LOGOFF  		luaLog("intermezzo")
-- RELEASE_LOGOFF  		luaLog(Mission.CheckpointLoaded)
-- RELEASE_LOGOFF  		luaLog(Mission)
-- RELEASE_LOGOFF  		luaLog(debug.traceback())

		--luaCamOnTargetFree(Mission.GermanSub, 5, 340, 62, false, "noupdate", 1, nil)
		luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 200, ["theta"] = 5, ["rho"] = 340, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 50, ["theta"] = 5, ["rho"] = 340, ["moveTime"] = 5},
		}, luaJM12InterMezzo2)
		--luaDelay(luaJM12InterMezzo2, 3)
	else
		luaJM12InterMezzo2()
	end



--[[theta: függõleges forgásszög. 0 - vízszintes, 90 - felülrõl
rho: vízszintes forgásszög. 0 - szembõl, 90 - balról, 180 - hátulról, 270 – jobbról
distance: kamera távolsága a targettõl]]
end

function luaJM12InterMezzo2()
-- RELEASE_LOGOFF  	luaLog("luaJM12InterMezzo2")
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_1)
		NavigatorStop(Mission.PlayerUnit)
	end
	Blackout(false, "", 2)
	luaDelay(luaJM12InterMezzo3, 2)
end

function luaJM12InterMezzo3()
-- RELEASE_LOGOFF  	luaLog("luaJM12InterMezzo3")
	luaJM12StartDialog("GermanSpeech1")
	SetSimplifiedReconMultiplier(1.5)
	luaDelay(luaJM12AddInput, 5)
end

function luaJM12JumpToCarrier()

	LaunchSquadron(Mission.USNCarrier, 102, 3)

		luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.USNCarrier, ["distance"] = 150, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.USNCarrier, ["distance"] = 150, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 10},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 150, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.PlayerUnit, ["distance"] = 50, ["theta"] = 10, ["rho"] = 10, ["moveTime"] = 5},
		}, luaJM12EndIntermezzo2, true)


	--Blackout(true,"luaJM12JumpToCarrier2",1)
end

function luaJM12EndIntermezzo2()
	if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
		SetRoleAvailable(Mission.PlayerUnit, EROLF_ALL, PLAYER_1)
		SetSelectedUnit(Mission.PlayerUnit)
	end
	EnableInput(true)
	Blackout(false, "", 1)
	--ShowHint("IJN12_Radar")
	luaJM12StartDialog("GermanSpeech2")
	ShowHint("IJN12_CV")
	Mission.CVInitDone = true
	Mission.MovieOnGoing = false
end


function luaJM12InitCarrierGrp()
	Mission.USNCarrier = GenerateObject("Bogue-class Escort Carrier 01")

	if Mission.Difficulty == 2 then
		Mission.USNCarrier.Maxplanes = 35
	elseif Mission.Difficulty == 1 then
		Mission.USNCarrier.Maxplanes = 25
	else
		Mission.USNCarrier.Maxplanes = 15
	end

	Mission.Escorts = {}
		table.insert(Mission.Escorts, GenerateObject("ASW Fletcher 01"))
		table.insert(Mission.Escorts, GenerateObject("ASW Fletcher 02"))
		table.insert(Mission.Escorts, GenerateObject("ASW Fletcher 03"))
		table.insert(Mission.Escorts, GenerateObject("Clemson-class 01"))
		table.insert(Mission.Escorts, GenerateObject("Clemson-class 02"))

	Mission.ASW = {}
		table.insert(Mission.ASW, FindEntity("ASW Fletcher 01"))
		table.insert(Mission.ASW, FindEntity("ASW Fletcher 02"))
		table.insert(Mission.ASW, FindEntity("ASW Fletcher 03"))

	Mission.EscortNames = {}
		table.insert(Mission.EscortNames, "ingame.shipnames_francis_m_robinson")
		table.insert(Mission.EscortNames, "ingame.shipnames_haverfield")
		table.insert(Mission.EscortNames, "ingame.shipnames_swenning")
		table.insert(Mission.EscortNames, "ingame.shipnames_willis")
		table.insert(Mission.EscortNames, "ingame.shipnames_janssen")

	for idx,unit in pairs(luaSumTablesIndex(Mission.ASW, Mission.Escorts)) do
		JoinFormation(unit, Mission.USNCarrier)
		if Mission.Difficulty == 2 then
			SetSkillLevel(unit, SKILL_SPVETERAN)
			NavigatorSetTorpedoEvasion(unit, true)
		else
			SetSkillLevel(unit, SKILL_SPNORMAL)
			NavigatorSetTorpedoEvasion(unit, false)
		end
	end

	for idx, unit in pairs(Mission.Escorts) do
		SetGuiName(unit, Mission.EscortNames[idx])
	end

	SetGuiName(Mission.USNCarrier, "ingame.shipnames_bogue")

	luaJM12RelocateUnits2()
end

function luaJM12CheckConvoy()
	local ship = Mission.ConvoyLeader
	if not ship.Dead then

		local shipsAround = luaGetShipsAround(ship, 2000, "enemy", nil,  nil, "submarine")

		if shipsAround and (luaGetScriptTarget(ship) == nil or luaGetScriptTarget(ship).Dead) then
			local trg = luaSortByDistance2(ship, shipsAround, true)
			if trg and not trg.Dead then

				if IsInFormation(Mission.ConvoyLeader) then
					LeaveFormation(Mission.ConvoyLeader)
				end

				NavigatorAttackMove(ship, trg, {})
				luaSetScriptTarget(ship, trg)
			end

		elseif not shipsAround and (luaGetScriptTarget(ship) == nil or luaGetScriptTarget(ship).Dead) then

			if not IsInFormation(Mission.ConvoyLeader) then

				local unit = luaPickRnd(luaRemoveDeadsFromTable(Mission.Convoy))
				if unit then
					local leader = GetFormationLeader(unit)
					if leader ~= nil then
						JoinFormation(Mission.ConvoyLeader, leader)
					else
						JoinFormation(Mission.ConvoyLeader, unit)
					end
				end

			end

		end
	end
end

function luaJM12InitConvoy()

	Mission.Convoy = {}

	table.insert(Mission.Convoy, FindEntity("Clemson-class 03"))
	table.insert(Mission.Convoy, FindEntity("US Cargo Transport 01"))
	table.insert(Mission.Convoy, FindEntity("US Cargo Transport 02"))
	table.insert(Mission.Convoy, FindEntity("US Cargo Transport 03"))

	Mission.MaxShips = table.getn(Mission.Convoy)
	Mission.ConvoyLeader = Mission.Convoy[1]

	for idx,unit in pairs(Mission.Convoy) do
		AddUntouchableUnit(unit)
		if idx > 1 then
			JoinFormation(unit, Mission.ConvoyLeader)
		end
		SetGuiName(unit, Mission.ConvoyNames[idx])
	end

	luaDelay(luaJM12ConvoyOnMove, 2)
	luaJM12AddConvoyReconListener()
end

function luaJM12ConvoyOnMove()
	if Mission.CheckpointLoaded then
		return
	end
	NavigatorMoveOnPath(Mission.ConvoyLeader, FindEntity("ConvoyPath"), PATH_FM_SIMPLE, PATH_SM_BEGIN, 5)
end
---kiba kesobb hivando cuccok--------
--[[
luaDelay(luaJM12OxygeneHint, 15)
]]

function luaJM12RelocateUnitsStart()
	Blackout(true, "", 1)
	luaDelay(luaJM12RelocateUnits, 1.5)
end

function luaJM12RelocateUnits()

	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead then
		return
	end

	NavigatorStop(Mission.PlayerUnit)
	local pos1 = GetPosition(FindEntity("IJNPutTo"))
	pos1.y = -20
	PutTo(Mission.PlayerUnit, pos1, -luaGetAngle("world", GetPosition(FindEntity("IJNPutTo")), GetPosition(FindEntity("GermanPutTo"))))
	luaJM12AddAirSupply(Mission.PlayerUnit)
	SetSubmarineDepthLevel(Mission.PlayerUnit, 1)
	SetSelectedUnit(Mission.PlayerUnit)

	if Mission.X and not Mission.X.Dead then
		SetInvincible(Mission.X, false)
		PutRelTo(Mission.X, Mission.PlayerUnit, {["x"]=0, ["y"]=200, ["z"]=0})
	end

	NavigatorStop(Mission.GermanSub)
	local pos2 = GetPosition(FindEntity("GermanPutTo"))
	pos2.y = -20
	PutTo(Mission.GermanSub, pos2, -luaGetAngle("world", GetPosition(FindEntity("GermanPutTo")), GetPosition(FindEntity("IJNPutTo"))))
	SetSubmarineDepthLevel(Mission.GermanSub, 1)
	luaJM12AddAirSupply(Mission.GermanSub)
	SetParty(Mission.GermanSub, PARTY_JAPANESE)
	SetRoleAvailable(Mission.GermanSub, EROLF_ALL, PLAYER_1)
	ClearForcedReconLevel(Mission.GermanSub, PARTY_ALLIED)
	SetInvincible(Mission.GermanSub, false)
	SetSelectedUnit(Mission.GermanSub)

	if table.getn(luaRemoveDeadsFromTable(Mission.Convoy)) < 4 then
		luaJM12RespawnConvoy()
	else
		local pathTbl = FillPathPoints(FindEntity("ConvoyPath"))
		PutTo(Mission.ConvoyLeader, GetPosition(FindEntity("ConvoyPutTo")), luaGetAngle("world", GetPosition(FindEntity("ConvoyPutTo")), pathTbl[1]))
		luaJM12ConvoyOnMove()
		Mission.Relocate = true
	end
end

function luaJM12RelocateUnits2()

	if not Mission.PlayerUnit or Mission.PlayerUnit.Dead then
		return
	end

	NavigatorStop(Mission.PlayerUnit)

	PutTo(Mission.PlayerUnit, GetPosition(FindEntity("IJNPutTo")), -luaGetAngle("world", GetPosition(FindEntity("IJNPutTo")), GetPosition(FindEntity("GermanPutTo"))))
	SetSubmarineDepthLevel(Mission.PlayerUnit, 1)
	SetSelectedUnit(Mission.PlayerUnit)

	luaJM12InterMezzo()
end

function luaJM12RespawnConvoy()
	for idx,unit in pairs(Mission.Convoy) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end

	Mission.Convoy = {}
	Mission.ConvoyLeader = nil

	local pathTbl = FillPathPoints(FindEntity("ConvoyPath"))

	SpawnNew({
	["party"] = PARTY_ALLIED,
	["groupMembers"] = {
		{
			["Type"] = 25,
			["Name"] = "Clemson",		--CA14
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 37,
			["Name"] = "Cargo",		--DDG26
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 37,
			["Name"] = "Cargo",	--D84
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
		{
			["Type"] = 37,
			["Name"] = "Cargo",		--DD377
			["Crew"] = crewLvl,
			["Race"] = USA,
		},
	},
	["area"] = {
		["refPos"] = GetPosition(FindEntity("ConvoyPutTo")),
		["angleRange"] = { luaJM12RAD(180), luaJM12RAD(270)},
		["lookAt"] = pathTbl[1],
	},
	["excludeRadiusOverride"] = {
		["ownHorizontal"] = 50,
		["enemyHorizontal"] = 200,
		["ownVertical"] = 75,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
	},
	["callback"] = "luaJM12ConvoySpawned",
})
end

function luaJM12ConvoySpawned(...)
	for k,v in ipairs(arg) do
		if v.Class.Type == "Destroyer" then
			Mission.ConvoyLeader = v
		end
		table.insert(Mission.Convoy, v)
		SetGuiName(v, Mission.ConvoyNames[k])
-- RELEASE_LOGOFF  		luaLog("guiname")
	end

	for idx,unit in pairs(Mission.Convoy) do
		if unit.ID ~= Mission.ConvoyLeader.ID then
			JoinFormation(unit, Mission.ConvoyLeader)
		end
	end

-- RELEASE_LOGOFF  	luaLog("faszombamaa2")
	luaDelay(luaJM12ConvoyOnMove,2)
	Mission.Relocate = true
end

function luaJM12StartEmovie()
	Blackout(true, "", 1)
	EnableInput(false)
	luaDelay(JM12RelocateMovieUnits, 1.5)
end

function luaJM12StartEmovie2()
	Mission.MovieOnGoing = true
	Blackout(true, "", 1)
	EnableInput(false)
	luaDelay(luaJM12InitCarrierGrp, 1.5)
end

function JM12RelocateMovieUnits()
	local planes = luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].own.reconplane)
	local movieEnt = luaSortByDistance2(Mission.GermanSub, planes, true)

-- RELEASE_LOGOFF  	luaLog("spawning jake")
	Mission.X = GenerateObject("E13A Jake 02")
	SetRoleAvailable(Mission.X, EROLF_ALL, PLAYER_1)
	SetSelectedUnit(Mission.X)

	if movieEnt and not movieEnt.Dead then
		Kill(movieEnt, true)
	end

	local subPos = GetPosition(Mission.GermanSub)
	subPos.y = 0
	subPos.x = subPos.x + 15
	PutTo(Mission.X, subPos)
	PilotStop(Mission.X)
	SetInvincible(Mission.X, true)

	Blackout(false, "", 0.5)
	luaDelay(luaJM12EmovieOn,1)

end

function luaJM12EmovieOn()
	luaJM12StartDialog("Landed")
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 150, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 0,},
		   {["postype"] = "cameraandtarget", ["target"] = Mission.GermanSub, ["distance"] = 120, ["theta"] = 15, ["rho"] = 15, ["moveTime"] = 15},
		}, luaJM12RelocateUnitsStart)

	luaJM12StartDialog("Phase2Start")
end

function luaJM12Back2Mission()
	Blackout(false, "", 0.5)
	EnableInput(true)
end

function luaJM12Phase2Started()
	Mission.Phase2Started = true
end

function luaJM12NavpointReached()
	Mission.Reached = true
end

function luaJM12InitDone()
	Mission.InitDone = true
end

function luaJM12DelayedInitDlg()
	luaJM12StartDialog("Init2")
end

function luaJM12EzmegbenaHPkiiratasdemajdleszjobb()

	if not Mission.MovieOnGoing then

		local unit = GetSelectedUnit()

		if unit and not unit.Dead then
			if unit.Class.ID == 93 or unit.Class.ID == 8 then
				DisplayUnitHP({Mission.GermanSub})
			elseif unit.Class.ID == 193 then
				DisplayUnitHP({Mission.PlayerUnit})
			end
		end
	end

	--luaDelay(luaJM12EzmegbenaHPkiiratasdemajdleszjobb, 3)
end

function luaJM12AddAirSupply(unit)
	SetSubmarineAirSupply(unit, 1)
end

function luaJM12CheckTorps()
	local japTorp = GetProperty(Mission.PlayerUnit, "TorpedoStock")
	if japTorp == 0 and not Mission.ReloadJapInProgress and not Mission.ReloadGerInProgress then
		luaJM12StartReloadOnJap()
	end

	local gerTorp = GetProperty(Mission.GermanSub, "TorpedoStock")
	if gerTorp == 0 and not Mission.ReloadJapInProgress and not Mission.ReloadGerInProgress then
		luaJM12StartReloadOnGer()
	end
end

function luaJM12StartReloadOnJap()
	Mission.ReloadName = GetGuiName(Mission.PlayerUnit)
	Countdown("ijn12.torpreload", 0, 60, luaJM12ReloadTorpOnJap)
	Mission.ReloadJapInProgress = true
end

function luaJM12ReloadTorpOnJap()
	local maxTorp = Mission.PlayerUnit.Class.MaxTorpedoStock
	ShipSetTorpedoStock(Mission.PlayerUnit, maxTorp)
	Mission.ReloadJapInProgress = false
end

function luaJM12StartReloadOnGer()
	Mission.ReloadName = GetGuiName(Mission.GermanSub)
	Countdown("ijn12.torpreload", 0, 60, luaJM12ReloadTorpOnGer)
	Mission.ReloadGerInProgress = true
end

function luaJM12ReloadTorpOnGer()
	local maxTorp = Mission.GermanSub.Class.MaxTorpedoStock
	ShipSetTorpedoStock(Mission.PlayerUnit, maxTorp)
	Mission.ReloadGerInProgress = false
end

function luaJM12SpawnJake()
	local spawnPoint = GetPosition(Mission.GermanSub)
	spawnPoint.y = 0
	spawnPoint.x = spawnPoint.x + 15

	SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				[1] = {
					["Type"] = 172,
					["Name"] = "E13A Jake",
					["Crew"] = 1,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 0,
				},
			},
			["area"] = {
				["refPos"] = spawnPoint,
				["angleRange"] = { luaJM12RAD(0), luaJM12RAD(180)},
				["lookAt"] = GetPosition(Mission.GermanSub),
			},
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 0,
				["enemyHorizontal"] = 0,
				["ownVertical"] = 0,
				["enemyVertical"] = 0,
				["formationHorizontal"] = 0,
			},
			["callback"] = "luaJM12JakeSpawned",
			["id"] = "jakespawnreq",
		})
end

function luaJM12JakeSpawned(unit)
-- RELEASE_LOGOFF  	luaLog("jakespawned")
	PilotStop(unit)
	Mission.X = unit
-- RELEASE_LOGOFF  	luaLog(GetPosition(unit))
-- RELEASE_LOGOFF  	luaLog(GetPosition(Mission.GermanSub))
end

function luaJM12ShipListener()
	AddListener("kill", "ShipsLost", {
			["callback"] = "luaJM12ShipsLost",
			["entity"] = {},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {PLAYER_1}, -- [PLAYER_1..PLAYER_8]
	})
end

function luaJM12ShipsLost(entity, lastAttacker, lastAttackerPlayerIndex)
	--luaLog("Shiplost")
	--luaLog(entity.Name)
	--luaLog(entity.ID)
	--luaLog(lastAttacker.Name)
	--luaLog(lastAttacker.ID)
	--luaLog(lastAttackerPlayerIndex)
	if entity.Party == PARTY_ALLIED and luaGetType(entity) == "ship" then
		if lastAttacker.ID == Mission.PlayerUnit.ID then
			Mission.IJNSubOK = true
		elseif lastAttacker.ID == Mission.GermanSub.ID then
			Mission.GermanSubOK = true
		end
	end

	if Mission.IJNSubOK and Mission.GermanSubOK then
		RemoveListener("kill", "ShipsLost")
		--luaJM12StartDialog("HiddenComplete")
	end
end

---check----
function luaJM12SaveMissionData()
	Mission.Checkpoint.CVInitDone = Mission.CVInitDone
	Mission.Checkpoint.IJNSubOK = Mission.IJNSubOK
	Mission.Checkpoint.GermanSubOK = Mission.GermanSubOK
	
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)

	local japPlanes = {}
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
		if unit and not unit.Dead then
			table.insert(japPlanes, {unit.Name, unit.Class.ID, GetPosition(unit)})
		end
	end

	Mission.Checkpoint.JapPlanes = japPlanes
end

function luaJM12LoadMissionData()
	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]

	Mission.IJNSubOK = Mission.Checkpoint.IJNSubOK
	Mission.GermanSubOK = Mission.Checkpoint.GermanSubOK
	Mission.CVInitDone = Mission.Checkpoint.CVInitDone
	
	SetParty(Mission.GermanSub, PARTY_JAPANESE)
	SetRoleAvailable(Mission.GermanSub, EROLF_ALL, PLAYER_1)
	SetSubmarineDepthLevel(Mission.GermanSub, 1)

	if IsInvincible(Mission.GermanSub) then
		SetInvincible(Mission.GermanSub, false)
	end

	ClearForcedReconLevel(Mission.GermanSub, PARTY_ALLIED)
	
	for idx,unit in pairs(recon[PARTY_JAPANESE].own.reconplane) do
		if unit and not unit.Dead then
			Kill(unit,true)
		end
	end

	for idx,saveTbl in pairs(Mission.Checkpoint.JapPlanes) do
		if saveTbl[2] == 172 then
			local plane = GenerateObject("E13A Jake 02")
			PutTo(plane, saveTbl[3])
		elseif saveTbl[2] == 180 then
			local plane = GenerateObject("M6A Seiran 01")
			PutTo(plane, saveTbl[3])
		end
	end

	for idx,unit in pairs(Mission.Convoy) do
		if unit and not unit.Dead then
			Kill(unit, true)
		end
	end

	luaJM12InitCarrierGrp()

	local angle1 = luaGetAngle("world", GetPosition(Mission.PlayerUnit), GetPosition(Mission.USNCarrier))
	local angle2 = luaGetAngle("world", GetPosition(Mission.GermanSub), GetPosition(Mission.USNCarrier))

	local pos1 = GetPosition(Mission.PlayerUnit)
	pos1.y = -20
	local pos2 = GetPosition(Mission.GermanSub)
	pos2.y = -20

	PutTo(Mission.PlayerUnit, pos1, -angle1)
	PutTo(Mission.GermanSub, pos2, -angle2)
	--luaJM12AddInput()
end

function luaJM12AddInput()
-- RELEASE_LOGOFF  	luaLog("luaJM12AddInput")
	--SoundFade(1, "",0.1)
	Mission.CheckpointLoads = false
	SetSelectedUnit(Mission.PlayerUnit)
	EnableInput(true)
	Blackout(false, "", 0)
end

function luaJM12RespawnJake()
	if Mission.PlayerUnit.Class.ID ~= 81 then
		return
	end

	Mission.StopThink = true

	if not Mission.PlayerJake or Mission.PlayerJake.Dead then
		if Mission.JakeRespawn < Mission.Stock then
			local spawnPoint
			if Mission.PlayerUnit and not Mission.PlayerUnit.Dead then
				spawnPoint = GetPosition(Mission.PlayerUnit)
			end

			if spawnPoint then
				spawnPoint.y = 0
				spawnPoint.x = spawnPoint.x + 15
			end

			SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						[1] = {
							["Type"] = 172,
							["Name"] = "E13A Jake",
							["Crew"] = 1,
							["Race"] = Japan,
							["WingCount"] = 1,
							["Equipment"] = 0,
						},
					},
					["area"] = {
						["refPos"] = spawnPoint,
						["angleRange"] = { luaJM12RAD(0), luaJM12RAD(180)},
						["lookAt"] = GetPosition(Mission.GermanSub),
					},
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 0,
						["enemyHorizontal"] = 0,
						["ownVertical"] = 0,
						["enemyVertical"] = 0,
						["formationHorizontal"] = 0,
					},
					["callback"] = "luaJM12JakeSpawned",
					["id"] = "jakespawnreq",
				})
		else
			Mission.StopThink = false
		end
	else
		Mission.StopThink = false
	end
end

function luaJM12JakeSpawned(unit)
	Mission.JakeRespawn = Mission.JakeRespawn + 1
	PilotMoveTo(unit, Mission.GermanSub)
	Mission.Jake = unit
	SetSelectedUnit(unit)
	Mission.StopThink = false
end