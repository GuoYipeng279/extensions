-- Scripted & Assembled by: Team Wolfpack

---- Java Sea Rush (IJN) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
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
	
	--LoadMessageMap("ijndlg",3)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/IJN/java_charge.lua"

	this.Name = "IJN40"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_JAPANESE)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Sink",
				["Text"] = "Sink first ABDACOM wave!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "UK",
				["Text"] = "Sink the British battleships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "USA",
				["Text"] = "Destroy enemy reinforcements!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "BB",
				["Text"] = "Don't lose any battleships!",
				["TextFailed"] = "One of our battleships is sinking!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Bruh",
				["Text"] = "Sink all enemy ships in the area!",
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
		["INTRO"] = {--
			["sequence"] = {
				{
					["message"] = "idlg01",
				},
				{
					["type"] = "pause",
					["time"] = 4,
				},
				{
					["message"] = "INTRO1",
				},
				{
					["type"] = "pause",
					["time"] = 8,
				},
				{
					["message"] = "idlg03",
				},
				{
					["type"] = "pause",
					["time"] = 12,
				},
				{
					["message"] = "idlg02_1",
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
		Mission.SkillLevel = SKILL_ELITE
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
	
	---- IJN ----
	
	Mission.JapFleetA = {}
		table.insert(Mission.JapFleetA, FindEntity("Yamato"))
		table.insert(Mission.JapFleetA, FindEntity("Musashi"))
		table.insert(Mission.JapFleetA, FindEntity("Izumo"))
		table.insert(Mission.JapFleetA, FindEntity("Sagami"))
		table.insert(Mission.JapFleetA, FindEntity("Azuma"))
		table.insert(Mission.JapFleetA, FindEntity("Yoshino"))
		table.insert(Mission.JapFleetA, FindEntity("Azumaya"))
		table.insert(Mission.JapFleetA, FindEntity("Mitsumine"))
		table.insert(Mission.JapFleetA, FindEntity("Zao"))
		table.insert(Mission.JapFleetA, FindEntity("Senjo"))
		table.insert(Mission.JapFleetA, FindEntity("Adatara"))
		table.insert(Mission.JapFleetA, FindEntity("Gassan"))
		table.insert(Mission.JapFleetA, FindEntity("Haru1"))
		table.insert(Mission.JapFleetA, FindEntity("Haru2"))
		table.insert(Mission.JapFleetA, FindEntity("Haru3"))
		table.insert(Mission.JapFleetA, FindEntity("Haru4"))
		table.insert(Mission.JapFleetA, FindEntity("Haru5"))
		table.insert(Mission.JapFleetA, FindEntity("Haru6"))
		table.insert(Mission.JapFleetA, FindEntity("Haru7"))
		table.insert(Mission.JapFleetA, FindEntity("Haru8"))
	for idx,unit in pairs(Mission.JapFleetA) do
		
		JoinFormation(unit, Mission.JapFleetA[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.JapFleetB = {}
		table.insert(Mission.JapFleetB, FindEntity("Yashima"))
		table.insert(Mission.JapFleetB, FindEntity("Asahi"))
		table.insert(Mission.JapFleetB, FindEntity("Shikishima"))
		table.insert(Mission.JapFleetB, FindEntity("Utsugi"))
		table.insert(Mission.JapFleetB, FindEntity("Asama"))
		table.insert(Mission.JapFleetB, FindEntity("Washiba"))
		table.insert(Mission.JapFleetB, FindEntity("Tsurugi"))
		table.insert(Mission.JapFleetB, FindEntity("Musume"))
		table.insert(Mission.JapFleetB, FindEntity("Michi"))
		table.insert(Mission.JapFleetB, FindEntity("Haru9"))
		table.insert(Mission.JapFleetB, FindEntity("Haru10"))
		table.insert(Mission.JapFleetB, FindEntity("Haru11"))
		table.insert(Mission.JapFleetB, FindEntity("Haru12"))
		table.insert(Mission.JapFleetB, FindEntity("Haru13"))
	for idx,unit in pairs(Mission.JapFleetB) do
		
		JoinFormation(unit, Mission.JapFleetB[1])
		SetSkillLevel(unit, Mission.SkillLevelOwn)
        luaSetUnlockName(unit)
		NavigatorSetTorpedoEvasion(unit, true)
		NavigatorSetAvoidLandCollision(unit, true)
		
		if Mission.Difficulty == 0 or Mission.Difficulty == 1 then
			
			RepairEnable(unit, true)
		
		elseif Mission.Difficulty == 2 then
			
			RepairEnable(unit, false)
		
		end
		
	end
	
	Mission.IJNShips = luaSumTablesIndex(Mission.JapFleetA, Mission.JapFleetB)
	
	Mission.JapCapitalShips = {}
		table.insert(Mission.JapCapitalShips, FindEntity("Yamato"))
		table.insert(Mission.JapCapitalShips, FindEntity("Musashi"))
		table.insert(Mission.JapCapitalShips, FindEntity("Sagami"))
		table.insert(Mission.JapCapitalShips, FindEntity("Izumo"))
		table.insert(Mission.JapCapitalShips, FindEntity("Yashima"))
		table.insert(Mission.JapCapitalShips, FindEntity("Asahi"))
		table.insert(Mission.JapCapitalShips, FindEntity("Shikishima"))
	
	---- USN ----
	
	Mission.USA = {}
		table.insert(Mission.USA, FindEntity("Alaska1"))
		table.insert(Mission.USA, FindEntity("Baltimore1"))
		table.insert(Mission.USA, FindEntity("Baltimore2"))
		table.insert(Mission.USA, FindEntity("Baltimore3"))
		table.insert(Mission.USA, FindEntity("Allen1"))
		table.insert(Mission.USA, FindEntity("Allen2"))
		table.insert(Mission.USA, FindEntity("Allen3"))
		table.insert(Mission.USA, FindEntity("Allen4"))
		table.insert(Mission.USA, FindEntity("Allen5"))
		table.insert(Mission.USA, FindEntity("Allen6"))
		table.insert(Mission.USA, FindEntity("Allen7"))
	for idx,unit in pairs(Mission.USA) do

		JoinFormation(unit, Mission.USA[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.USA[1], Mission.JapFleetA[1])
	
	Mission.USB = {}
		table.insert(Mission.USB, FindEntity("Alaska2"))
		table.insert(Mission.USB, FindEntity("Baltimore4"))
		table.insert(Mission.USB, FindEntity("Baltimore5"))
		table.insert(Mission.USB, FindEntity("Baltimore6"))
		table.insert(Mission.USB, FindEntity("Allen8"))
		table.insert(Mission.USB, FindEntity("Allen9"))
		table.insert(Mission.USB, FindEntity("Allen10"))
		table.insert(Mission.USB, FindEntity("Allen11"))
		table.insert(Mission.USB, FindEntity("Allen12"))
		table.insert(Mission.USB, FindEntity("Allen13"))
		table.insert(Mission.USB, FindEntity("Allen14"))
	for idx,unit in pairs(Mission.USB) do

		JoinFormation(unit, Mission.USB[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.USB[1], Mission.JapFleetB[1])
	
	Mission.WaveOne = luaSumTablesIndex(Mission.USA, Mission.USB)
	
	--[[Mission.UKA = {}
		table.insert(Mission.UKA, FindEntity("Conq"))
		table.insert(Mission.UKA, FindEntity("Fiji1"))
		table.insert(Mission.UKA, FindEntity("Fiji2"))
		table.insert(Mission.UKA, FindEntity("Fiji3"))
		table.insert(Mission.UKA, FindEntity("Tribal1"))
		table.insert(Mission.UKA, FindEntity("Tribal2"))
		table.insert(Mission.UKA, FindEntity("Tribal3"))
		table.insert(Mission.UKA, FindEntity("Tribal4"))
		table.insert(Mission.UKA, FindEntity("Tribal5"))
	for idx,unit in pairs(Mission.UKA) do

		JoinFormation(unit, Mission.UKA[1])
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
		
	end
	
	Mission.UKB = {}
		table.insert(Mission.UKB, FindEntity("Thund"))
		table.insert(Mission.UKB, FindEntity("Fiji4"))
		table.insert(Mission.UKB, FindEntity("Fiji5"))
		table.insert(Mission.UKB, FindEntity("Fiji6"))
		table.insert(Mission.UKB, FindEntity("Tribal6"))
		table.insert(Mission.UKB, FindEntity("Tribal7"))
		table.insert(Mission.UKB, FindEntity("Tribal8"))
		table.insert(Mission.UKB, FindEntity("Tribal9"))
		table.insert(Mission.UKB, FindEntity("Tribal10"))
	for idx,unit in pairs(Mission.UKB) do

		JoinFormation(unit, Mission.UKB[1])
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
		
	end
	
	Mission.USD = {}
		table.insert(Mission.USD, FindEntity("Missouri"))
		table.insert(Mission.USD, FindEntity("Iowa"))
		table.insert(Mission.USD, FindEntity("NewJersey"))
		table.insert(Mission.USD, FindEntity("Baltimore10"))
		table.insert(Mission.USD, FindEntity("Baltimore11"))
		table.insert(Mission.USD, FindEntity("Baltimore12"))
		table.insert(Mission.USD, FindEntity("Allen22"))
		table.insert(Mission.USD, FindEntity("Allen23"))
		table.insert(Mission.USD, FindEntity("Allen24"))
		table.insert(Mission.USD, FindEntity("Allen25"))
	for idx,unit in pairs(Mission.USD) do

		JoinFormation(unit, Mission.USD[1])
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
		
	end
	
	Mission.USE = {}
		table.insert(Mission.USE, FindEntity("Montana"))
		table.insert(Mission.USE, FindEntity("Ohio"))
		table.insert(Mission.USE, FindEntity("Vermont"))
		table.insert(Mission.USE, FindEntity("Baltimore13"))
		table.insert(Mission.USE, FindEntity("Baltimore14"))
		table.insert(Mission.USE, FindEntity("Baltimore15"))
		table.insert(Mission.USE, FindEntity("Allen26"))
		table.insert(Mission.USE, FindEntity("Allen27"))
		table.insert(Mission.USE, FindEntity("Allen28"))
		table.insert(Mission.USE, FindEntity("Allen29"))
	for idx,unit in pairs(Mission.USE) do

		JoinFormation(unit, Mission.USE[1])
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
		
	end
	
	Mission.USCVA = {}
		table.insert(Mission.USCVA, FindEntity("Essex1"))
		table.insert(Mission.USCVA, FindEntity("Essex2"))
		table.insert(Mission.USCVA, FindEntity("Allen30"))
		table.insert(Mission.USCVA, FindEntity("Allen31"))
		table.insert(Mission.USCVA, FindEntity("Allen32"))
		table.insert(Mission.USCVA, FindEntity("Allen33"))
	for idx,unit in pairs(Mission.USCVA) do

		JoinFormation(unit, Mission.USCVA[1])
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
		
	end
	
	Mission.USCVB = {}
		table.insert(Mission.USCVB, FindEntity("Essex3"))
		table.insert(Mission.USCVB, FindEntity("Essex4"))
		table.insert(Mission.USCVB, FindEntity("Allen34"))
		table.insert(Mission.USCVB, FindEntity("Allen35"))
		table.insert(Mission.USCVB, FindEntity("Allen36"))
		table.insert(Mission.USCVB, FindEntity("Allen37"))
	for idx,unit in pairs(Mission.USCVB) do

		JoinFormation(unit, Mission.USCVB[1])
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
		
	end]]
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapAI = 3
		Mission.USAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapAI = 2
		Mission.USAI = 2
		
	elseif Mission.Difficulty == 2 then
	
		Mission.JapAI = 1
		Mission.USAI = 3
		
	end
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	MissionNarrative("Somewhere off Java...")
	
	Blackout(true, "", true)
	
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
	
	--luaDelay(luaInitThirdEfx, 10)
	
	--SetSelected(FindEntity("Taiho"))
	
	--GenerateObject("Landscape 01")
	
	--luaShowPoint(FindEntity("HarborEntrance"))
	
	--luaShowPath(FindEntity("PHMovingInPathSouth"))
	
	--PrepareClass(2)
	--local ship = GenerateObject("Enterprise")
	
	--[[Mission.Debug = true
	
	if Mission.Debug then
		
		for idx,unit in pairs(Mission.RllyBruh) do
		
			SetInvincible(unit, 0.4)
			
		end
		
		--luaDelay(luaMoveToPh3, 30)
		
	end]]
	
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
	
		luaIntroMovie()
		
		Mission.Started = true
		
		else
		
		if MissionObjectivesThinkChecked then

            luaCheckObjectives()

        end
		
	end
	
	--luaCheckObjectives()

    ---- TEST ----

    --print("text")
	
	--Mission.TEST = table.getn(luaRemoveDeadsFromTable(Mission.USAttackers))
	--MissionNarrative("#Mission.TEST#")
	
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
			
			end
			
			
			
		end
		
		if Mission.MissionPhase == 1 then
			
			if luaObj_IsActive("primary", 1) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.WaveOne)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 1, true)
				
					luaPh1FadeOut()			
				
				end
			
			end	
		
		elseif Mission.MissionPhase == 2 then
		
			if luaObj_IsActive("primary", 2) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.Conq)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 2, true)
				
					luaPh2FadeOut()			
				
				end
			
			end	
		
		elseif Mission.MissionPhase == 3 then
		
			if luaObj_IsActive("primary", 3) then
				
				if table.getn(luaRemoveDeadsFromTable(Mission.USZ)) == 0 then
				
					HideUnitHP()
				
					luaObj_Completed("primary", 3, true)
				
					luaMissionComplete()		
				
				end
			
			end	
		
		end
		
		if not MissionObjectivesThinkChecked then

            luaDelay(luaCheckObjectives, MissionObjectiveCheckerDelay)

        end
	
	end

end

---- PHASE 1 ----

function luaPh1FadeOut()

	Blackout(true, "luaMoveToPh2", 1)

end

function luaIntroMovie()

	Music_Control_SetLevel(MUSIC_CALM)
	luaCheckMusicSetMinLevel(MUSIC_CALM)
	
	luaIngameMovie(
	{
		
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 400, ["theta"] = 10, ["rho"] = 25, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yamato"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 65, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 400, ["theta"] = 10, ["rho"] = 25, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Yashima"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 65, ["moveTime"] = 3, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Alaska1"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 45, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Alaska1"), ["distance"] = 200, ["theta"] = 10, ["rho"] = 90, ["moveTime"] = 4, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},

		
	}, luaIntroMovieEnd, true)
	

	
end

function luaIntroDia()

	luaStartDialog("INTRO")

end

function luaIntroMovieEnd()

	Blackout(true, "luaIn", 3)

end

function luaIn()

	EnableMessages(true)
	
	Mission.MissionPhase = 1
	
	SetSelectedUnit(FindEntity("Yamato"))
	
	Blackout(false, "", 1)
	
	luaAddFirstObjs()

end

function luaAddFirstObjs()

	luaObj_Add("primary", 1, Mission.WaveOne)

end

-- PHASE 2
function luaPh2FadeOut()

	Blackout(true, "luaMoveToPh3", 1)

end

function luaMoveToPh2()

	Mission.MissionPhase = 2

	luaSpawnWaveTwo()
	
	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Conq"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 120, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Conq"), ["distance"] = 400, ["theta"] = 15, ["rho"] = 90, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	}, luaPh2MovieEnd, true)

end

function luaPh2MovieEnd()

	SetSelectedUnit(FindEntity("Yamato"))
	
	luaAddSecObjs()
	
end

function luaAddSecObjs()

	luaObj_Add("primary", 2, Mission.Conq)
	
end

-- PHASE 3

function luaMoveToPh3()

	Mission.MissionPhase = 3
	
	luaSpawnWaveThree()

	luaIngameMovie(
	{
		{["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 300, ["theta"] = 10, ["rho"] = 30, ["moveTime"] = 0, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	    {["postype"] = "cameraandtarget", ["target"] = FindEntity("Montana"), ["distance"] = 400, ["theta"] = 15, ["rho"] = 60, ["moveTime"] = 5, ["smoothtime"] = 0.5, ["nonlinearblend"] = 1},
	}, luaPh3MovieEnd, true)

end

function luaPh3MovieEnd()

	SetSelectedUnit(FindEntity("Yamato"))
	
	luaAddThrObjs()
	
end

function luaAddThrObjs()

	luaObj_Add("primary", 3, Mission.USZ)
	
end

---- LISTENERS ----



---- LISTENER CALLBACKS ----



---- MISSION ENDERS ----

function luaMissionComplete()
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Completed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionCompletedNew(nil, "ABDACOM is no more - Mission Complete")
	
end

function luaMissionFailed()
	
	Mission.EndMission = true

	if luaObj_IsActive("primary",1) then
		
		luaObj_Failed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Failed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Failed("primary",3)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(nil, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

function luaSpawnWaveThree()

	Mission.USD = {}
		table.insert(Mission.USD, GenerateObject("Missouri"))
		table.insert(Mission.USD, GenerateObject("Iowa"))
		table.insert(Mission.USD, GenerateObject("Baltimore10"))
		table.insert(Mission.USD, GenerateObject("Baltimore11"))
		table.insert(Mission.USD, GenerateObject("Baltimore12"))
		table.insert(Mission.USD, GenerateObject("Allen22"))
		table.insert(Mission.USD, GenerateObject("Allen23"))
		table.insert(Mission.USD, GenerateObject("Allen24"))
		table.insert(Mission.USD, GenerateObject("Allen25"))
	for idx,unit in pairs(Mission.USD) do

		JoinFormation(unit, Mission.USD[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end

	NavigatorAttackMove(Mission.USD[1], Mission.JapFleetA[1])

	Mission.USE = {}
		table.insert(Mission.USE, GenerateObject("Montana"))
		table.insert(Mission.USE, GenerateObject("Ohio"))
		table.insert(Mission.USE, GenerateObject("Baltimore13"))
		table.insert(Mission.USE, GenerateObject("Baltimore14"))
		table.insert(Mission.USE, GenerateObject("Baltimore15"))
		table.insert(Mission.USE, GenerateObject("Allen26"))
		table.insert(Mission.USE, GenerateObject("Allen27"))
		table.insert(Mission.USE, GenerateObject("Allen28"))
		table.insert(Mission.USE, GenerateObject("Allen29"))
	for idx,unit in pairs(Mission.USE) do

		JoinFormation(unit, Mission.USE[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end

	NavigatorAttackMove(Mission.USE[1], Mission.JapFleetB[1])
	
	Mission.USZ = luaSumTablesIndex(Mission.USE, Mission.USD)

end

function luaSpawnWaveTwo()

	Mission.Conq = {}
		table.insert(Mission.Conq, GenerateObject("Conq"))
		table.insert(Mission.Conq, GenerateObject("Fiji1"))
		table.insert(Mission.Conq, GenerateObject("Fiji2"))
		table.insert(Mission.Conq, GenerateObject("Fiji3"))
		table.insert(Mission.Conq, GenerateObject("Tribal1"))
		table.insert(Mission.Conq, GenerateObject("Tribal2"))
		table.insert(Mission.Conq, GenerateObject("Tribal3"))
		table.insert(Mission.Conq, GenerateObject("Tribal4"))
		table.insert(Mission.Conq, GenerateObject("Tribal5"))
	for idx,unit in pairs(Mission.Conq) do

		JoinFormation(unit, Mission.Conq[1])
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
		
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		
	end
	
	NavigatorAttackMove(Mission.Conq[1], Mission.JapFleetA[1])
	
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