---- STEEL MONSTERS (BSM CLASSIC) ----

-- Scripted & Assembled by: Team Wolfpack

---- STEEL MONSTERS (BSM CLASSIC) ----

---- PRECACHE ----

function luaPrecacheUnits()

	PrepareClass(27) -- Elco PT
	
end

---- INITS ----

function luaStageInitMulti()
	luaLoadControlFunctionNames()
	Music_Control_SetLevel(MUSIC_TENSION)
end

function luaStageInit()
	CreateScript("luaInit")
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Classic2"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)

	this.Multiplayer = true
	Mission.Classic = true
	Mission.MultiplayerType = "Classic"

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	Mission.PlayersTable = GetPlayerDetails()

	DoFile("scripts/datatables/Scoring.lua")
	
	this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "Sink_US",
				["Text"] = "Sink all Japanese vessels!",
				["TextCompleted"] = "All Japanese vessels are sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "Sink_JP",
				["Text"] = "Sink all Allied vessels!",
				["TextCompleted"] = "All Allied vessels are sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "Surv_US",
				["Text"] = "Ensure the survival of at least one of your key units!",
				["TextFailed"] = "Your key units have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "Surv_JP",
				["Text"] = "Ensure the survival of at least one of your key units!",
				["TextFailed"] = "Your key units have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
		},
		["hidden"] = {
		}
	}
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	Mission.IJNGang = {}
		table.insert(Mission.IJNGang, FindEntity("Fuso"))
		table.insert(Mission.IJNGang, FindEntity("Yamashiro"))
		table.insert(Mission.IJNGang, FindEntity("Kongo"))
		table.insert(Mission.IJNGang, FindEntity("Haruna"))
		table.insert(Mission.IJNGang, FindEntity("Mogami"))
		table.insert(Mission.IJNGang, FindEntity("Takao"))
		table.insert(Mission.IJNGang, FindEntity("Tone"))
		table.insert(Mission.IJNGang, FindEntity("Kuma"))
	
	for idx,unit in pairs(Mission.IJNGang) do
		
		SetSkillLevel(unit, SKILL_MPVETERAN)
		RepairEnable(unit, false)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		
	end
	
	Mission.IJNKeyUnits = {}
		table.insert(Mission.IJNKeyUnits, FindEntity("Fuso"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Yamashiro"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Kongo"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Haruna"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Mogami"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Takao"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Tone"))
		table.insert(Mission.IJNKeyUnits, FindEntity("Kuma"))
	
	Mission.USNGang = {}
		table.insert(Mission.USNGang, FindEntity("Warspite"))
		table.insert(Mission.USNGang, FindEntity("Prince of Wales"))
		table.insert(Mission.USNGang, FindEntity("Pennsylvania"))
		table.insert(Mission.USNGang, FindEntity("New York"))
		table.insert(Mission.USNGang, FindEntity("Northampton"))
		table.insert(Mission.USNGang, FindEntity("Atlanta"))
		table.insert(Mission.USNGang, FindEntity("York"))
		table.insert(Mission.USNGang, FindEntity("Cleveland"))
	
	for idx,unit in pairs(Mission.USNGang) do
		
		SetSkillLevel(unit, SKILL_MPVETERAN)
		RepairEnable(unit, false)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		
	end
	
	Mission.USNKeyUnits = {}
		table.insert(Mission.USNKeyUnits, FindEntity("Warspite"))
		table.insert(Mission.USNKeyUnits, FindEntity("Prince of Wales"))
		table.insert(Mission.USNKeyUnits, FindEntity("Pennsylvania"))
		table.insert(Mission.USNKeyUnits, FindEntity("New York"))
		table.insert(Mission.USNKeyUnits, FindEntity("Northampton"))
		table.insert(Mission.USNKeyUnits, FindEntity("Atlanta"))
		table.insert(Mission.USNKeyUnits, FindEntity("York"))
		table.insert(Mission.USNKeyUnits, FindEntity("Cleveland"))
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	this.ThinkCounter = 0
	
	luaInitNewSystems()
	
	--PermitSupportmanager()
	--ShowHideSupportManager()
	
	--luaShowPath(FindEntity("AvoidZoneG all 5 #001"))
	
    SetThink(this, "luaThink")
	
end

---- THINK ----

function luaThink(this, msg)
	
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if not Mission.Started then
	
		luaStartMission()
		
		Mission.Started = true
		
	elseif Mission.Started then
		
		luaCheckMusic()
		
		Mission.IJNGang = luaRemoveDeadsFromTable(Mission.IJNGang)
		Mission.USNGang = luaRemoveDeadsFromTable(Mission.USNGang)
		
		Mission.IJNGangLeft = table.getn(luaRemoveDeadsFromTable(Mission.IJNGang))
		Mission.USNGangLeft = table.getn(luaRemoveDeadsFromTable(Mission.USNGang))
		
		MultiScore = {
			[0]= {
				[1] = Mission.IJNGangLeft,
			},
			[1]= {
				[1] = Mission.IJNGangLeft,
			},
			[2]= {
				[1] = Mission.IJNGangLeft,
			},
			[3]= {
				[1] = Mission.IJNGangLeft,
			},
			[4]= {
				[1] = Mission.USNGangLeft,
			},
			[5]= {
				[1] = Mission.USNGangLeft,
			},
			[6]= {
				[1] = Mission.USNGangLeft,
			},
			[7]= {
				[1] = Mission.USNGangLeft,
			},
		}
		
		DisplayScores(1, 0, "Sink all Japanese vessels!", "Japanese Key Units left:".."| #MultiScore.0.1#")
		DisplayScores(1, 1, "Sink all Japanese vessels!", "Japanese Key Units left:".."| #MultiScore.1.1#")
		DisplayScores(1, 2, "Sink all Japanese vessels!", "Japanese Key Units left:".."| #MultiScore.2.1#")
		DisplayScores(1, 3, "Sink all Japanese vessels!", "Japanese Key Units left:".."| #MultiScore.3.1#")
		DisplayScores(1, 4, "Sink all Allied vessels!", "Allied Key Units left:".."| #MultiScore.4.1#")
		DisplayScores(1, 5, "Sink all Allied vessels!", "Allied Key Units left:".."| #MultiScore.5.1#")
		DisplayScores(1, 6, "Sink all Allied vessels!", "Allied Key Units left:".."| #MultiScore.6.1#")
		DisplayScores(1, 7, "Sink all Allied vessels!", "Allied Key Units left:".."| #MultiScore.7.1#")
		
		if Mission.IJNGangLeft == 0 then
		
			luaEndMission(false)
			
		elseif Mission.USNGangLeft == 0 then
			
			luaEndMission(true)
		
		end
		
		if Mission.Skirmish then
		
			luaCheckSkirmish()
		
		end
		
	end
	
	--SetRoleAvailable(FindEntity("Atlanta"), EROLF_ALL, PLAYER_1)
	--Mission.TEST = GetRoleAvailable(FindEntity("Atlanta"))[1]
	--MissionNarrative("#Mission.TEST#")
	
end

---- MISSION ENDERS ----

function luaEndMission(isJap)
	
	Mission.MissionEnd = true
	
	--luaRemoveMPUnitGivingListeners()
	
	luaObj_Completed("primary", 1, true)
	luaObj_Completed("primary", 2, true)
	luaObj_Completed("primary", 3, true)
	luaObj_Completed("primary", 4, true)
	
	local winParty
	local focusParty
	local focusUnit
	
	if isJap then
	
		winParty = PARTY_JAPANESE
		focusParty = Mission.USNGang
	
	else
	
		winParty = PARTY_ALLIED
		focusParty = Mission.IJNGang
	
	end
	
	focusUnit = luaPickRnd(luaRemoveDeadsFromTable(focusParty))
	
	luaMissionCompletedNew(focusUnit, "", nil, nil, nil, winParty)
	
end

---- MISSION STARTERS -----

function luaStartMission()
	
	luaCheckSkirmish()
	
	--[[local player
	
	for idx,unit in pairs(Mission.USNGang) do
	
		if IsUnitSelectable(unit) then
		
			player = GetRoleAvailable(unit)[1]
			
			break
			
		end
	
	end
	
	if player == nil then
	
		for idx,unit in pairs(Mission.IJNGang) do
		
			if IsUnitSelectable(unit) then
			
				player = GetRoleAvailable(unit)[1]
				
				break
				
			end
		
		end
	
	end]]
	
	--luaInitMPUnitGiving(player)
	
	--if table.getn(Mission.PlayersTable) < 8 then
	
		--luaRedistributeMPUnits(false, Mission.USNGang, Mission.IJNGang)
	
	--end

	luaObj_Add("primary", 1, Mission.IJNKeyUnits)
	luaObj_Add("primary", 2, Mission.USNKeyUnits)
	luaObj_Add("primary", 3, Mission.USNKeyUnits)
	luaObj_Add("primary", 4, Mission.IJNKeyUnits)
	
end

---- SUPPPORT FUNCTIONS ----

function luaStopDialogues()

	local dlg = GetActDialogIDs()
	
	if next(dlg) ~= nil then
	
		for idx,actdlg in pairs(dlg) do
		
			KillDialog(actdlg)
			
		end
		
	end

end

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
	
	if not Mission.EndMission then
	
		if type(dialogID) ~= "string" then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue not a string! Dialogue ID: #Mission.DialogID#")
			end
			error("***ERROR: luaStartDialog's param must be a string!", 2)
		end

		if Mission.Dialogues[dialogID] == nil then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue non-existent! Dialogue ID: #Mission.DialogID#")
			end
			error("***ERROR: luaStartDialog cannot continue, non existing dialog: "..dialogID, 2)
		end

		if Mission.Dialogues[dialogID].printed and not ignorePrinted then
			if Mission.Debug then
				Mission.DialogID = dialogID
				MissionNarrative("Dialogue already printed! Dialogue ID: #Mission.DialogID#")
			end
			return
		end

		StartDialog(dialogID, Mission.Dialogues[dialogID])
		Mission.Dialogues[dialogID].printed = true
		Mission.LastDialog = math.floor(GameTime())

		if log then
		end

	end

end

function luaAddPowerup(type)
	
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})
	
end