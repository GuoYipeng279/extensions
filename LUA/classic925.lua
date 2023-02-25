---- BATTLE OFF SAMAR (BSM CLASSIC) ----

-- Scripted & Assembled by: Team Wolfpack

---- BATTLE OFF SAMAR (BSM CLASSIC) ----

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(159) -- Judy
	PrepareClass(162) -- Kate
	
	PrepareClass(101) -- Wildcat
	PrepareClass(108) -- Dauntless
	PrepareClass(113) -- Avenger
	
end

---- INITS ----

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInit")
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Classic5"..dateandtime

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
				["ID"] = "us_obj_pri1",
				["Text"] = "Destroy the Yamato, the Japanese flagship!",
				["TextCompleted"] = "The Yamato has been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri1",
				["Text"] = "Destroy the Allied carriers!",
				["TextCompleted"] = "The Allied carriers have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri2",
				["Text"] = "Protect your carriers!",
				["TextFailed"] = "Your carriers have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri2",
				["Text"] = "Protect the Yamato!",
				["TextFailed"] = "The Yamato has been destroyed!",
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
	
	Mission.IJNGang = {}
		table.insert(Mission.IJNGang, FindEntity("Yamato"))
		table.insert(Mission.IJNGang, FindEntity("Akagi"))
		table.insert(Mission.IJNGang, FindEntity("Takao"))
		table.insert(Mission.IJNGang, FindEntity("Atago"))
		table.insert(Mission.IJNGang, FindEntity("Asakaze"))
		table.insert(Mission.IJNGang, FindEntity("Asagumo"))
		table.insert(Mission.IJNGang, FindEntity("Hagikaze"))
		table.insert(Mission.IJNGang, FindEntity("Harukaze"))
	
	for idx,unit in pairs(Mission.IJNGang) do
		
		SetSkillLevel(unit, SKILL_MPVETERAN)
		RepairEnable(unit, false)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		
	end
	
	Mission.IJNCVGang = {}
		table.insert(Mission.IJNCVGang, FindEntity("Yamato"))
	
	for idx,unit in pairs(Mission.IJNCVGang) do
		
		unit.slot1Stock = 150
		unit.slot2Stock = 159
		unit.slot3Stock = 162
		unit.airBaseSlotCount = 3
		
	end
	
	Mission.USNGang = {}
		table.insert(Mission.USNGang, FindEntity("Yorktown"))
		table.insert(Mission.USNGang, FindEntity("Enterprise"))
		table.insert(Mission.USNGang, FindEntity("New York"))
		table.insert(Mission.USNGang, FindEntity("Pennsylvania"))
		table.insert(Mission.USNGang, FindEntity("Ellet"))
		table.insert(Mission.USNGang, FindEntity("Henley"))
		table.insert(Mission.USNGang, FindEntity("Farragut"))
		table.insert(Mission.USNGang, FindEntity("Gridley"))
	
	for idx,unit in pairs(Mission.USNGang) do
		
		SetSkillLevel(unit, SKILL_MPVETERAN)
		RepairEnable(unit, false)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		
	end
	
	Mission.USNCVGang = {}
		table.insert(Mission.USNCVGang, FindEntity("Yorktown"))
		table.insert(Mission.USNCVGang, FindEntity("Enterprise"))
	
	for idx,unit in pairs(Mission.USNCVGang) do
		
		unit.slot1Stock = 101
		unit.slot2Stock = 108
		unit.slot3Stock = 113
		unit.airBaseSlotCount = 3
		
	end
	
	Mission.IJNKeyUnits = Mission.IJNCVGang
	Mission.USNKeyUnits = Mission.USNCVGang
	Mission.CVsToModerate = Mission.USNCVGang
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	luaInitNewSystems()
	
    SetThink(this, "luaThink")
	
end

---- THINK ----

function luaThink(this, msg)

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
		
		Mission.IJNGangLeft = table.getn(luaRemoveDeadsFromTable(Mission.IJNCVGang))
		Mission.USNGangLeft = table.getn(luaRemoveDeadsFromTable(Mission.USNCVGang))
		
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
		
		DisplayScores(1, 0, "Destroy the Yamato, the Japanese flagship!", "")
		DisplayScores(1, 1, "Destroy the Yamato, the Japanese flagship!", "")
		DisplayScores(1, 2, "Destroy the Yamato, the Japanese flagship!", "")
		DisplayScores(1, 3, "Destroy the Yamato, the Japanese flagship!", "")
		DisplayScores(1, 4, "Destroy the Allied carriers!", "Allied carriers left:".."| #MultiScore.4.1#")
		DisplayScores(1, 5, "Destroy the Allied carriers!", "Allied carriers left:".."| #MultiScore.5.1#")
		DisplayScores(1, 6, "Destroy the Allied carriers!", "Allied carriers left:".."| #MultiScore.6.1#")
		DisplayScores(1, 7, "Destroy the Allied carriers!", "Allied carriers left:".."| #MultiScore.7.1#")
		
		if Mission.IJNGangLeft == 0 then
		
			luaEndMission(false)
			
		elseif Mission.USNGangLeft == 0 then
			
			luaEndMission(true)
		
		end
		
		if Mission.Skirmish then
		
			luaCheckSkirmish()
		
		end
		
	end

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

	luaObj_Add("primary", 1, Mission.IJNCVGang)
	luaObj_Add("primary", 2, Mission.USNCVGang)
	luaObj_Add("primary", 3, Mission.USNCVGang)
	luaObj_Add("primary", 4, Mission.IJNCVGang)
	
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
		focusParty = Mission.USNCVGang
	
	else
	
		winParty = PARTY_ALLIED
		focusParty = Mission.IJNCVGang
	
	end
	
	focusUnit = luaPickRnd(luaRemoveDeadsFromTable(focusParty))
	
	luaMissionCompletedNew(focusUnit, "", nil, nil, nil, winParty)
	
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