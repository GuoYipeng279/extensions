---- BATTLE OF SURIGAO STRAIT (USN) ----

-- Scripted & Assembled by: Team Wolfpack

---- BATTLE OF SURIGAO STRAIT (USN) ----

DoFile("Scripts/datatables/Inputs.lua")
DoFile("scripts/datatables/Scoring.lua")

---- PRECACHE----

function luaPrecacheUnits()

	--PrepareClass(101) 	-- F4F
	--PrepareClass(108) 	-- TBF
	--PrepareClass(113) 	-- SBD
	--PrepareClass(121) 	-- Kingfisher
	
	--PrepareClass(53) 	-- Soryu
	--PrepareClass(2) 	-- Yorktown
	--PrepareClass(17) 	-- Atlanta
	--PrepareClass(7) 	-- South Dakota
	--PrepareClass(23) 	-- Fletcher
	--PrepareClass(19) 	-- Northampton
	
	--PrepareClass(73) 	-- Fubuki
	
end

---- INITS ----

function luaEngineMovieInit()
	EnableMessages(false)
	Music_Control_SetLevel(MUSIC_TENSION)
	LoadMessageMap("runsva09dlg",1)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInit")
	Scoring_RealPlayTimeRunning(true)
end

---- MAIN INIT ----

function luaInit(this)
	Mission = this
	this.Name = "US20"
	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false
	this.ScriptFile = "Scripts/missions/USN/usn_20_battle_of_surigao_strait.lua"

	DoFile("scripts/datatables/Scoring.lua")
			
	SETLOG(this, true)
	this.Party = SetParty(this, PARTY_ALLIED)
	
	SetDeviceReloadEnabled(true)
	
	---- DIFFICULTY SETTING ----
	
	this.Difficulty = GetDifficulty()
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_STUN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_ELITE
	end
	if Mission.Difficulty == 0 then
		Mission.SkillLevelOwn = SKILL_SPVETERAN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevelOwn = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_STUN
	end
	
	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	SetSimplifiedReconMultiplier(0.75)
	
	---- PLANE TYPES ----
	
	Mission.TypeFisher = 121
	Mission.TypeFairey = 109
	Mission.TypeHurricane = 134
	Mission.TypeJ2M = 151
	Mission.TypeB17 = 116
	Mission.TypeB25 = 118
	Mission.TypeSB2C = 38
	Mission.TypeSBD = 108
	Mission.TypeTBF = 113
	Mission.TypeP38 = 104
	Mission.TypeF6F = 26
	Mission.TypeG4M = 167
	Mission.TypeG4MOhka = 32
	Mission.TypeG3M = 166
	Mission.TypeJ1N1 = 152
	Mission.TypeH6K = 174
	Mission.TypeF1M = 171
	Mission.TypeA6M = 150
	Mission.TypeB6N = 163
	Mission.TypeD4Y = 159
	Mission.TypeB5N = 162
	Mission.TypeD3A = 158
	Mission.TypeJ2M = 151
	Mission.TypeShinden = 189
	
	---- NAVS ----
	
	Mission.IJNGoTo = FindEntity("JapanGoTo")
	Mission.IJNEsc = FindEntity("JapanEscape")
	Mission.IJNEdgeMove1 = FindEntity("JapanEdgeMove1")
	Mission.IJNEdgeMove2 = FindEntity("JapanEdgeMove2")
	
	---- USN ----
	
	Mission.Shipyard1 = FindEntity("EscortSY 03")
	Mission.Shipyard2 = FindEntity("EscortSY 04")
	
	Mission.USCenterGrp = {}
		table.insert(Mission.USCenterGrp, FindEntity("Mississippi"))
		table.insert(Mission.USCenterGrp, FindEntity("Maryland"))
		table.insert(Mission.USCenterGrp, FindEntity("West Virginia"))
		table.insert(Mission.USCenterGrp, FindEntity("Tennessee"))
		table.insert(Mission.USCenterGrp, FindEntity("California"))
		table.insert(Mission.USCenterGrp, FindEntity("Pennsylvania"))
		table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class10"))
		table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class11"))
		--[[table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class12"))
		table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class13"))
		table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class14"))
		table.insert(Mission.USCenterGrp, FindEntity("Fletcher-class15"))]]
		
	Mission.USLeftGrp = {}
		table.insert(Mission.USLeftGrp, FindEntity("Louisville"))
		table.insert(Mission.USLeftGrp, FindEntity("Portland"))
		--table.insert(Mission.USLeftGrp, FindEntity("Minneapolis"))
		--table.insert(Mission.USLeftGrp, FindEntity("Denver"))
		--table.insert(Mission.USLeftGrp, FindEntity("Columbia"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class01"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class02"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class03"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class04"))
		--[[table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class05"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class06"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class07"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class08"))
		table.insert(Mission.USLeftGrp, FindEntity("Fletcher-class09"))]]
		
	Mission.USRightGrp = {}
		table.insert(Mission.USRightGrp, FindEntity("Phoenix"))
		table.insert(Mission.USRightGrp, FindEntity("Boise"))
		--table.insert(Mission.USRightGrp, FindEntity("Shropshire"))
		table.insert(Mission.USRightGrp, FindEntity("Fletcher-class16"))
		table.insert(Mission.USRightGrp, FindEntity("Fletcher-class17"))
		--[[table.insert(Mission.USRightGrp, FindEntity("Fletcher-class18"))
		table.insert(Mission.USRightGrp, FindEntity("Fletcher-class19"))
		table.insert(Mission.USRightGrp, FindEntity("Fletcher-class20"))
		table.insert(Mission.USRightGrp, FindEntity("Fletcher-class21"))]]
		
	--[[Mission.USAdvanceGrp = {}
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class22"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class23"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class24"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class25"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class26"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class27"))
		table.insert(Mission.USAdvanceGrp, FindEntity("Fletcher-class28"))]]
	
	Mission.USShips = luaSumTablesIndex(Mission.USCenterGrp, Mission.USLeftGrp, Mission.USRightGrp)
	
	--[[Mission.USShips = {}
		table.insert(Mission.USShips, FindEntity("Mississippi"))
		table.insert(Mission.USShips, FindEntity("Maryland"))
		table.insert(Mission.USShips, FindEntity("West Virginia"))
		table.insert(Mission.USShips, FindEntity("Tennessee"))
		table.insert(Mission.USShips, FindEntity("California"))
		table.insert(Mission.USShips, FindEntity("Pennsylvania"))
		table.insert(Mission.USShips, FindEntity("Louisville"))
		table.insert(Mission.USShips, FindEntity("Portland"))
		table.insert(Mission.USShips, FindEntity("Minneapolis"))
		table.insert(Mission.USShips, FindEntity("Denver"))
		table.insert(Mission.USShips, FindEntity("Columbia"))
		table.insert(Mission.USShips, FindEntity("Phoenix"))
		table.insert(Mission.USShips, FindEntity("Boise"))
		table.insert(Mission.USShips, FindEntity("Shropshire"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class01"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class02"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class03"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class04"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class05"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class06"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class07"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class08"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class09"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class10"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class11"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class12"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class13"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class14"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class15"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class16"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class17"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class18"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class19"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class20"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class21"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class22"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class23"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class24"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class25"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class26"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class27"))
		table.insert(Mission.USShips, FindEntity("Fletcher-class28"))]]
	
	Mission.USShipyards = {}
		table.insert(Mission.USShipyards, FindEntity("EscortSY 03"))
		table.insert(Mission.USShipyards, FindEntity("EscortSY 04"))
	
	Mission.USPTNames = {}
		table.insert(Mission.USPTNames, "PT-152")
		table.insert(Mission.USPTNames, "PT-130")
		table.insert(Mission.USPTNames, "PT-131")
		table.insert(Mission.USPTNames, "PT-127")
		table.insert(Mission.USPTNames, "PT-128")
		table.insert(Mission.USPTNames, "PT-129")
		table.insert(Mission.USPTNames, "PT-151")
		table.insert(Mission.USPTNames, "PT-146")
		table.insert(Mission.USPTNames, "PT-190")
		table.insert(Mission.USPTNames, "PT-192")
		table.insert(Mission.USPTNames, "PT-191")
		table.insert(Mission.USPTNames, "PT-195")
		table.insert(Mission.USPTNames, "PT-196")
		table.insert(Mission.USPTNames, "PT-194")
		table.insert(Mission.USPTNames, "PT-150")
		table.insert(Mission.USPTNames, "PT-134")
		table.insert(Mission.USPTNames, "PT-132")
		table.insert(Mission.USPTNames, "PT-137")
		table.insert(Mission.USPTNames, "PT-494")
		table.insert(Mission.USPTNames, "PT-497")
		table.insert(Mission.USPTNames, "PT-324")
		table.insert(Mission.USPTNames, "PT-523")
		table.insert(Mission.USPTNames, "PT-524")
		table.insert(Mission.USPTNames, "PT-526")
		table.insert(Mission.USPTNames, "PT-490")
		table.insert(Mission.USPTNames, "PT-491")
		table.insert(Mission.USPTNames, "PT-493")
		table.insert(Mission.USPTNames, "PT-495")
		table.insert(Mission.USPTNames, "PT-489")
		table.insert(Mission.USPTNames, "PT-492")
		table.insert(Mission.USPTNames, "PT-327")
		table.insert(Mission.USPTNames, "PT-321")
		table.insert(Mission.USPTNames, "PT-326")
		table.insert(Mission.USPTNames, "PT-320")
		table.insert(Mission.USPTNames, "PT-330")
		table.insert(Mission.USPTNames, "PT-331")
		table.insert(Mission.USPTNames, "PT-328")
		table.insert(Mission.USPTNames, "PT-323")
		table.insert(Mission.USPTNames, "PT-329")
	
	for idx,unit in pairs(Mission.USCenterGrp) do
		JoinFormation(unit, Mission.USCenterGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end
	
	for idx,unit in pairs(Mission.USLeftGrp) do
		JoinFormation(unit, Mission.USLeftGrp[2])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end
	
	for idx,unit in pairs(Mission.USRightGrp) do
		JoinFormation(unit, Mission.USRightGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end
	
	--[[for idx,unit in pairs(Mission.USAdvanceGrp) do
		JoinFormation(unit, Mission.USAdvanceGrp[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetAvoidLandCollision(unit, true)
		NavigatorSetTorpedoEvasion(unit, true)
		if Mission.Difficulty == 0 then
			RepairEnable(unit, true)
		elseif Mission.Difficulty == 1 or Mission.Difficulty == 2 then
			RepairEnable(unit, false)
		end
	end]]
	
	---- UNLOCKABLES ----
	
	--[[Mission.Unlockables = {
		["11"] = {"USS Moale","USS Ingraham","USS Cooper","USS English","USS Charles S. Sperry","USS Ault","USS Waldron","USS Haynsworth","USS John W. Weeks","USS Hank","USS Wallace L. Lind","USS Borie","USS Compton","USS Gainard","USS Soley","USS Harlan R. Dickson","USS Hugh Purvis","USS Barton","USS Walke","USS Laffey","USS O'Brien","USS Meredith","USS De Haven","USS Mansfield","USS Lyman K. Swenson","USS Collett","USS Maddox","USS Hyman"},
		["17"] = {"USS San Diego","USS San Juan","USS Reno"},
		["390"] = {"USS Guam","USS Philippines","USS Puerto Rico"},
		["1606"] = {"HMS Belfast","HMS Gloucester","HMS Manchester"},
		["1607"] = {"HMS Fiji","HMS Sheffield","HMS Edinburgh"},
		["1609"] = {"HMS Icarus","HMS Ilex","HMS Imperial","HMS Impulsive","HMS Inglefield","HMS Intrepid","HMS Isis","HMS Ivanhoe","HMS Inconstant","HMS Ithuriel","HMS Gallant","HMS Garland","HMS Gipsy","HMS Glowworm","HMS Grafton","HMS Grenade","HMS Grenville","HMS Greyhound","HMS Griffin","HMS Hardy","HMS Hasty","HMS Havock","HMS Hereward","HMS Hero","HMS Hotspur","HMS Hunter","HMS Hyperion","HMS Harvester"},
	}

	for idx,unit in pairs(Mission.USShips) do
		if IsClassChanged(unit.Class.ID) then
			local id = unit.Class.ID
			for i,names in pairs(Mission.Unlockables) do
				if tostring(id) == i then
					SetGuiName(unit, names[1])
					table.remove(names, 1)
					break
				else
					SetGuiName(unit, unit.Class.Name)
				end
			end
		end
	end]]
	
	---- IJN ----
	
	Mission.IJNRightBBGrp = {}
		table.insert(Mission.IJNRightBBGrp, FindEntity("Fuso"))
		table.insert(Mission.IJNRightBBGrp, FindEntity("Mogami"))
		table.insert(Mission.IJNRightBBGrp, FindEntity("Fubuki-class01"))
		
	Mission.IJNLeftBBGrp = {}
		table.insert(Mission.IJNLeftBBGrp, FindEntity("Yamashiro"))
		table.insert(Mission.IJNLeftBBGrp, FindEntity("Fubuki-class06"))
		table.insert(Mission.IJNLeftBBGrp, FindEntity("Fubuki-class07"))
		table.insert(Mission.IJNLeftBBGrp, FindEntity("Fubuki-class08"))
		
	Mission.IJNRightCAGrp = {}
		table.insert(Mission.IJNRightCAGrp, FindEntity("Nachi"))
		table.insert(Mission.IJNRightCAGrp, FindEntity("Fubuki-class02"))
		table.insert(Mission.IJNRightCAGrp, FindEntity("Fubuki-class03"))
		table.insert(Mission.IJNRightCAGrp, FindEntity("Fubuki-class04"))
		table.insert(Mission.IJNRightCAGrp, FindEntity("Fubuki-class05"))
		
	Mission.IJNLeftCAGrp = {}
		table.insert(Mission.IJNLeftCAGrp, FindEntity("Ashigara"))
		table.insert(Mission.IJNLeftCAGrp, FindEntity("Fubuki-class09"))
		table.insert(Mission.IJNLeftCAGrp, FindEntity("Fubuki-class10"))
		table.insert(Mission.IJNLeftCAGrp, FindEntity("Fubuki-class11"))
		table.insert(Mission.IJNLeftCAGrp, FindEntity("Fubuki-class12"))
	
	Mission.IJNShips = {}
		table.insert(Mission.IJNShips, FindEntity("Fuso"))
		table.insert(Mission.IJNShips, FindEntity("Mogami"))
		table.insert(Mission.IJNShips, FindEntity("Yamashiro"))
		table.insert(Mission.IJNShips, FindEntity("Nachi"))
		table.insert(Mission.IJNShips, FindEntity("Ashigara"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class01"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class02"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class03"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class04"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class05"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class06"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class07"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class08"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class09"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class10"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class11"))
		table.insert(Mission.IJNShips, FindEntity("Fubuki-class12"))
		
	Mission.IJNKeyTrgs = {}
		table.insert(Mission.IJNKeyTrgs, FindEntity("Fuso"))
		table.insert(Mission.IJNKeyTrgs, FindEntity("Yamashiro"))
		table.insert(Mission.IJNKeyTrgs, FindEntity("Nachi"))
		table.insert(Mission.IJNKeyTrgs, FindEntity("Ashigara"))
	
	for idx,unit in pairs(Mission.IJNRightBBGrp) do
		JoinFormation(unit, Mission.IJNRightBBGrp[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, false)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	for idx,unit in pairs(Mission.IJNLeftBBGrp) do
		JoinFormation(unit, Mission.IJNLeftBBGrp[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, false)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	for idx,unit in pairs(Mission.IJNRightCAGrp) do
		JoinFormation(unit, Mission.IJNRightCAGrp[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, false)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	for idx,unit in pairs(Mission.IJNLeftCAGrp) do
		JoinFormation(unit, Mission.IJNLeftCAGrp[1])
		SetSkillLevel(unit, Mission.SkillLevel)
		NavigatorSetAvoidLandCollision(unit, true)
		if Mission.Difficulty == 0 then
			NavigatorSetTorpedoEvasion(unit, false)
			RepairEnable(unit, false)
			TorpedoEnable(unit, false)
		elseif Mission.Difficulty == 1 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, false)
			TorpedoEnable(unit, true)
		elseif Mission.Difficulty == 2 then
			NavigatorSetTorpedoEvasion(unit, true)
			RepairEnable(unit, true)
			TorpedoEnable(unit, true)
		end
	end
	
	---- OBJECTIVES ----
	
	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Sink",
				["Text"] = "Stop the Japanese by sinking their key vessels!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Prot",
				["Text"] = "Ensure the survival of both of your shipyards!",
				["TextFailed"] = "Both shipyards have been destroyed!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "D",
				["Text"] = "Completely annihilate the enemy forces!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
	}
	
	---- DIALOGUES ----
	
	Mission.Dialogues = {
		["INTRO1"] = {
			["sequence"] = {
				{
					["message"] = "INTRO1",
				},
				{
					["message"] = "INTRO2",
				},
				{
					["message"] = "INTRO3",
				},
				{
					["message"] = "INTRO4",
				},
			},
		},
		["INTRO2"] = {
			["sequence"] = {
				{
					["message"] = "INTRO5",
				},
				{
					["message"] = "INTRO6",
				},
				{
					["message"] = "INTRO7",
				},
			},
		},
		["INTRO3"] = {
			["sequence"] = {
				{
					["message"] = "INTRO8",
				},
				{
					["message"] = "INTRO9",
				},
				{
					["message"] = "INTRO10",
				},
			},
		},
		["PT"] = {
			["sequence"] = {
				{
					["message"] = "PT1",
				},
				{
					["message"] = "PT2",
				},
			},
		},
		["FLAG"] = {
			["sequence"] = {
				{
					["message"] = "FLAG1",
				},
				{
					["message"] = "FLAG2",
				},
			},
		},
		["TRANS"] = {
			["sequence"] = {
				{
					["message"] = "TRANS1",
				},
				{
					["message"] = "TRANS2",
				},
				{
					["message"] = "TRANS3",
				},
				{
					["message"] = "TRANS4",
				},
				{
					["message"] = "TRANS5",
				},
				{
					["message"] = "TRANS6",
				},
				{
					["message"] = "TRANS7",
				},
			},
		},
		["IJNLOW"] = {
			["sequence"] = {
				{
					["message"] = "IJNLOW1",
				},
				{
					["message"] = "IJNLOW2",
				},
			},
		},
		["FLAGWIN"] = {
			["sequence"] = {
				{
					["message"] = "FLAGWIN1",
				},
				{
					["message"] = "FLAGWIN2",
				},
				{
					["message"] = "FLAGWIN3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaFinalDia",
				},
			},
		},
		["DEST"] = {
			["sequence"] = {
				{
					["message"] = "DEST1",
				},
				{
					["type"] = "callback",
					["callback"] = "luaFinalDia",
				},
			},
		},
		["FINAL"] = {
			["sequence"] = {
				{
					["message"] = "FINAL1",
				},
				{
					["message"] = "FINAL2",
				},
				{
					["message"] = "FINAL3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMissionComplete",
				},
			},
		},
	}
	
	---- INIT FUNCT ----
	
	if Mission.IJNRightBBGrp[1] and not Mission.IJNRightBBGrp[1].Dead then
		
		local n = random(1,2)
		
		if n == 1 then
		
			NavigatorMoveToPos(Mission.IJNRightBBGrp[1], Mission.IJNEdgeMove1)
		
		elseif n == 2 then
		
			NavigatorMoveToPos(Mission.IJNRightBBGrp[1], Mission.IJNGoTo)
		
		end
		
	end
	if Mission.IJNRightCAGrp[1] and not Mission.IJNRightCAGrp[1].Dead then
		
		NavigatorMoveToPos(Mission.IJNRightCAGrp[1], Mission.IJNEdgeMove1)
		
	end
	if Mission.IJNLeftBBGrp[1] and not Mission.IJNLeftBBGrp[1].Dead then
		
		local n = random(1,2)
		
		if n == 1 then
		
			NavigatorMoveToPos(Mission.IJNLeftBBGrp[1], Mission.IJNEdgeMove2)
		
		elseif n == 2 then
		
			NavigatorMoveToPos(Mission.IJNLeftBBGrp[1], Mission.IJNGoTo)
		
		end
		
	end
	if Mission.IJNLeftCAGrp[1] and not Mission.IJNLeftCAGrp[1].Dead then

		NavigatorMoveToPos(Mission.IJNLeftCAGrp[1], Mission.IJNEdgeMove2)
		
	end
	
	luaDelay(luaTransmittion, 550)
	luaDelay(luaCheckObjs, 2)
	
	---- THNK ----
	
	luaInitNewSystems()

    SetThink(this, "Think")
	
end

---- THNK ----

function Think(this, msg)
	
	if Mission.EndMission then

		return
		
	end
	
	luaCheckMusic()
	
	if luaMessageHandler(this, msg) == "killed" then

		return
		
	end
	
	if Mission.Started then
	
	elseif not Mission.Started then
		
		Mission.Started = true
		
		luaIntroMovie()
	
	end
	
	---- SHIPYARD MANAGERS ----
	
	if not Mission.Shipyard1.Dead then
	
		local PTs = luaGetShipsAround(Mission.Shipyard1, 200, "own")
		
		if PTs then
		
			for idx,unit in pairs(PTs) do
				
				if unit.Class.Type == "TorpedoBoat" and not unit.named then
						
					SetGuiName(unit, Mission.USPTNames[1])
					table.remove(Mission.USPTNames, 1)
					
					unit.named = true
					
				end
			
			end
			
		end
	
	end
	
	if not Mission.Shipyard2.Dead then
	
		local PTs = luaGetShipsAround(Mission.Shipyard2, 200, "own")
		
		if PTs then
		
			for idx,unit in pairs(PTs) do
				
				if unit.Class.Type == "TorpedoBoat" and not unit.named then
					
					SetGuiName(unit, Mission.USPTNames[1])
					table.remove(Mission.USPTNames, 1)
					
					unit.named = true
					
				end
			
			end
		
		end
	
	end
	
	if luaObj_IsActive("secondary",1) then
	
		if Mission.Shipyard1.Dead or Mission.Shipyard2.Dead then
		
			luaObj_Failed("secondary",1,true)
		
		end
		
	end
	
	---- IJN FLEET MANAGER ----
	
	if not Mission.EndMission then
		
		if not Mission.japsrunning then
		
			local usships = table.getn(luaRemoveDeadsFromTable(Mission.USShips))
			local japships = table.getn(luaRemoveDeadsFromTable(Mission.IJNShips))
		
			if usships > japships then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNShips)) do
				
					if unit and not unit.Dead and not unit.attacking then
					
						UnitSetFireStance(unit, 2)
						unit.attacking = true
					
					end
				
				end
			
			elseif usships < japships then
			
				for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.IJNShips)) do
				
					if unit and not unit.Dead and not unit.running then
					
						UnitSetFireStance(unit, 1)
						NavigatorMoveToPos(unit, Mission.IJNGoTo)
						unit.running = true
					
					end
				
				end
				
				Mission.japsrunning = true
				return
				
			end
		
			if luaObj_IsActive("secondary",1) then
				
				if shipsready and table.getn(luaRemoveDeadsFromTable(shipsready)) > 0 then
				
					for idx,unit in pairs(shipsready) do
						
						if unit and not unit.Dead then
					
							if not Mission.Shipyard1.Dead then

								local leader = GetFormationLeader(unit)
							
								local shipsready = luaGetShipsAround(Mission.Shipyard1, 5000, "enemy")
							
								if shipsready then

									if leader and not leader.Dead and not leader.attackingyard then
									
										NavigatorAttackMove(leader, Mission.Shipyard1)
										luaSetScriptTarget(leader, Mission.Shipyard1)
										
										leader.attackingyard = true
									
									elseif leader.attackingyard and luaGetScriptTarget(leader) == nil or luaGetScriptTarget(leader).Dead then
										
										NavigatorMoveToPos(leader, Mission.IJNGoTo)
										leader.attackingyard = false
									
									end
								
								end
							
							end
						
						end
					
					end
				
				end
				
			else
			
				if leader and not leader.Dead then
				
					NavigatorMoveToPos(leader, Mission.IJNGoTo)
					
				end
			
			end
			
		end	
	
	end
	
end

---- OBJECTIVE CHECKERS ----

function luaCheckObjs()
	
	if luaObj_IsActive("primary",1) then
		
		local shipsnearescaped = luaGetShipsAround(Mission.IJNGoTo, 4000, "enemy")
		local shipsescaped = luaGetShipsAround(Mission.IJNGoTo, 3000, "enemy")
		
		if shipsescaped then
			
			luaMissionFailed()
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.USShips)) == 0 then
		
			luaMissionFailed()
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.IJNKeyTrgs)) == 0 and table.getn(luaRemoveDeadsFromTable(Mission.IJNShips)) > 0 then
		
			luaCompleteAll()
			
			luaStartDialog("FLAGWIN")
		
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.IJNShips)) == 0 then
			
			luaObj_Completed("hidden",1)
			luaCompleteAll()
			
			luaStartDialog("DEST")
			
		end
		
		if table.getn(luaRemoveDeadsFromTable(Mission.IJNShips)) == 6 and not Mission.asd then
		
			luaStartDialog("IJNLOW")
			
			Mission.asd = true
			
		end
		
	end

	luaDelay(luaCheckObjs, 2)
	
end

---- PHASE 1 ----

function luaAddPrimaryObj()
	
	luaObj_Add("primary",1,Mission.IJNKeyTrgs)
	luaObj_Add("secondary",1,Mission.USShipyards)
	luaObj_Add("hidden",1)
	EnableMessages(true)
	
	local line1 = "Stop the Japanese advance by"
	local line2 = "sinking their key vessels!"
	luaDisplayScore(1, line1, line2)
	
	luaDelay(luaPTDia, 1.2)
	luaAddIJNFleetListener()
	
end

---- MISSION ENDERS ----

function luaMissionFailed()

	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
	luaObj_Failed("primary",1)
	end
	if luaObj_IsActive("secondary",1) then
	luaObj_Failed("secondary",1)
	end
	if luaObj_IsActive("hidden",1) then
	luaObj_Failed("hidden",1)
	end
	
	luaMissionFailedNew(nil, "Game Over")
	
end

function luaCompleteAll()

	if luaObj_IsActive("primary",1) then
		luaObj_Completed("primary",1,true)
	end
	
	if luaObj_IsActive("secondary",1) then
		if luaObj_GetSuccess("secondary",1) == nil then
			luaObj_Completed("secondary",1)
		end
	end
	
	if luaObj_IsActive("hidden",1) then
		if luaObj_GetSuccess("hidden",1) == nil then
			luaObj_Failed("hidden",1)
		end
	end
	
	HideScoreDisplay(1,0)
	
	Mission.EndMission = true
	
end

function luaFinalDia()

	luaStartDialog("FINAL")

end

function luaMissionComplete()
	
	local trg = luaPickRnd(luaRemoveDeadsFromTable(Mission.USShips))
	
	luaMissionCompletedNew(trg, "The Japanese have been repelled - Mission Complete")
	
end

---- LISTENERS ----

function luaAddIJNFleetListener()
	AddListener("recon", "IJNFleetListener", {
		["callback"] = "luaIJNFleetSighted",
		["entity"] = Mission.IJNKeyTrgs,
		["oldLevel"] = {0,1},
		["newLevel"] = {2},
		["party"] = {PARTY_ALLIED},
		})
end

---- LISTENER CALLBACKS ----

function luaIJNFleetSighted()

	RemoveListener("recon", "IJNFleetListener")
	
	luaStartDialog("FLAG")

end

---- DIALOGUES ----

function luaTransmittion()

	luaStartDialog("TRANS")

end

---- INTRO MOVIE ----

function luaIntroMovie()
	
	EnableMessages(false)
	
	luaDelay(luaIntroText, 3)
	local trg1 = FindEntity("Maryland")
	local trg2 = FindEntity("Tennessee")
	local trg3 = FindEntity("California")
	Blackout(true, "", 1)
	BlackBars(true)
	luaIngameMovie(
	{
  	    {["postype"] = "camera",["position"] = {["pos"] = {["x"]=-80,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 0,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=65},["parent"] = trg1,},["moveTime"] = 12,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=3,["z"]=130},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		{["postype"] = "target",["position"] = {["pos"] = {["x"]=0,["y"]=4,["z"]=130},["parent"] = trg1,},["moveTime"] = 6,["transformtype"] = "keepall"},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 300, ["theta"] = 17, ["rho"] = 260, ["moveTime"] = 5, ["terrainavoid"] = true, ["nonlinearblend"] = 0.1},
		{["postype"] = "cameraandtarget", ["target"] = trg2, ["distance"] = 420, ["theta"] = 20, ["rho"] = 200, ["moveTime"] = 7, ["terrainavoid"] = true, ["nonlinearblend"] = 0.5},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 150, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 4},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 250, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 4},
		{["postype"] = "cameraandtarget", ["target"] = trg3, ["distance"] = 250, ["theta"] = 10, ["rho"] = 15, ["moveTime"] = 5},
    }, luaIntroMovie2,true)
	
end

function luaIntroMovie2()
	
	luaDelay(luaIntroDia2, 2)
	
	local trg1 = FindEntity("movieelco1")
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 8, ["rho"] = -65, ["moveTime"] = 0},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 30, ["theta"] = 8, ["rho"] = -65, ["moveTime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 60, ["theta"] = 8, ["rho"] = -65, ["moveTime"] = 6},
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 60, ["theta"] = 8, ["rho"] = -65, ["moveTime"] = 7.25},
    }, luaIntroMovie3,true)
	
end

function luaIntroMovie3()
	
	luaDelay(luaIntroDia3, 2)
	
	local trg1 = FindEntity("Fuso")
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 100, ["theta"] = 1, ["rho"] = 5, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	  	{["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 110, ["theta"] = 1, ["rho"] = 3, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
        {["postype"] = "cameraandtarget", ["target"] = trg1, ["distance"] = 200, ["theta"] = 5, ["rho"] = 3, ["moveTime"] = 11, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
    }, luaIntroMovieEnd,true)
	
end

function luaIntroText()

	MissionNarrative("October 24th, 1944 - In the Surigao Strait")
	luaStartDialog("INTRO1")
	
end

function luaIntroMovieEnd()
	
	if FindEntity("movieelco1") and not FindEntity("movieelco1").Dead then
		local unitpos = GetPosition(FindEntity("movieelco1"))
		unitpos.x = unitpos.x + 0
		unitpos.y = unitpos.y + 0
		unitpos.z = unitpos.z + 20000
		PutTo(FindEntity("movieelco1"), unitpos)
		SetDeadMeat(FindEntity("movieelco1"))
	end
	
	SetSelectedUnit(FindEntity("Mississippi"))
	BlackBars(false)
	Blackout(false, "", 1)
	Mission.MissionPhase = 1
	
	luaDelay(luaAddPrimaryObj, 3)
	
end

function luaIntroDia2()

	luaStartDialog("INTRO2")

end

function luaIntroDia3()

	luaStartDialog("INTRO3")

end

function luaPTDia()

	luaStartDialog("PT")

end

---- SUPPORT FUNCTIONS ----

function luaRAD(x)
	return x *  0.0174532925
end

function luaDisplayScore(scoreID, line1, line2)
	DisplayScores(scoreID,0,line1,line2)
end

function luaStartDialog(dialogID, log, ignorePrinted)

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