---- STATIONED AT PEARL (BSM) ----

-- Scripted & Assembled by: Team Wolfpack

---- STATIONED AT PEARL (BSM) ----

DoFile("Scripts/datatables/Inputs.lua")

---- PRECACHE ----

function luaPrecacheUnits()
	
	PrepareClass(150) 	-- Zero
	PrepareClass(158) 	-- D3A
	PrepareClass(162) 	-- B5N
	
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
	
	LoadMessageMap("bsmdlg",1)
	
end

---- MAIN INIT ----

function luaInit(this)
	
	Mission = this
	Mission.ScriptFile = "Scripts/missions/BSM/bsm_01_stationed_at_pearl.lua"

	this.Name = "BSM01"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	---- PARTY SETTING ----
	
	this.Party = SetParty(this, PARTY_ALLIED)

	---- OBJECTIVES ----

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Phoenix",
				["Text"] = "Go to the USS Phoenix!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Survive",
				["Text"] = "Survive the first attack wave!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "MiniSub",
				["Text"] = "Destroy the enemy mini-sub!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[4] = {
				["ID"] = "Revenge",
				["Text"] = "Take revenge for Pearl Harbor!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[5] = {
				["ID"] = "Donald",
				["Text"] = "Donald must survive!",
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
			[1] = {
				["ID"] = "Bruh",
				["Text"] = "Shoot down at least 30 planes.",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0,
			},
		},
	}
	
	---- DIALOGUES ----
	
	Mission.Dialogues = {
		["WELCOME"] = {
			["sequence"] = {
				{
					["message"] = "WELCOME1",
				},
				{
					["message"] = "WELCOME2",
				},
				{
					["message"] = "WELCOME3",
				},
				{
					["message"] = "WELCOME4",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFirstObj",
				},
			},
		},
		["MORNING"] = {
			["sequence"] = {
				{
					["message"] = "MORNING1",
				},
				{
					["message"] = "MORNING2",
				},
				{
					["message"] = "MORNING3",
				},
				{
					["message"] = "MORNING4",
				},
			},
		},
		["CALS"] = {
			["sequence"] = {
				{
					["message"] = "CALS1",
				},
				{
					["message"] = "CALS2",
				},
				{
					["message"] = "CALS3",
				},
			},
		},
		["ARIZONA"] = {
			["sequence"] = {
				{
					["message"] = "ARIZONA1",
				},
				{
					["message"] = "ARIZONA2",
				},
			},
		},
		["OKLAHOMA"] = {
			["sequence"] = {
				{
					["message"] = "OKLAHOMA1",
				},
				{
					["message"] = "OKLAHOMA2",
				},
			},
		},
		["GOTONE"] = {
			["sequence"] = {
				{
					["message"] = "GOTONE1",
				},
				{
					["message"] = "GOTONE2",
				},
			},
		},
		["DOWN1"] = {
			["sequence"] = {
				{
					["message"] = "DOWN1",
				},
			},
		},
		["DOWN2"] = {
			["sequence"] = {
				{
					["message"] = "DOWN2",
				},
			},
		},
		["PERISCOPE"] = {
			["sequence"] = {
				{
					["message"] = "PERISCOPE1",
				},
				{
					["message"] = "PERISCOPE2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddThirdObj",
				},
			},
		},
		["TARGET"] = {
			["sequence"] = {
				{
					["message"] = "TARGET1",
				},
				{
					["message"] = "TARGET2",
				},
				{
					["message"] = "TARGET3",
				},
			},
		},
		["OPERATIONAL"] = {
			["sequence"] = {
				{
					["message"] = "OPERATIONAL1",
				},
			},
		},
		["WEGOTIT"] = {
			["sequence"] = {
				{
					["message"] = "WEGOTIT1",
				},
				{
					["message"] = "WEGOTIT2",
				},
				{
					["type"] = "callback",
					["callback"] = "luaMoveToPh4",
				},
			},
		},
		["EAGLE"] = {
			["sequence"] = {
				{
					["message"] = "EAGLE1",
				},
				{
					["message"] = "EAGLE2",
				},
				{
					["message"] = "EAGLE3",
				},
				{
					["type"] = "callback",
					["callback"] = "luaAddFinalObjs",
				},
			},
		},
		["SHOOT"] = {
			["sequence"] = {
				{
					["message"] = "SHOOT1",
				},
			},
		},
		["TAIL"] = {
			["sequence"] = {
				{
					["message"] = "TAIL1",
				},
			},
		},
		["SPEED"] = {
			["sequence"] = {
				{
					["message"] = "SPEED1",
				},
			},
		},
		["SCORE"] = {
			["sequence"] = {
				{
					["message"] = "SCORE1",
				},
			},
		},
		["GREAT"] = {
			["sequence"] = {
				{
					["message"] = "GREAT1",
				},
				{
					["message"] = "GREAT2",
				},
			},
		},
		["GOINGDOWN"] = {
			["sequence"] = {
				{
					["message"] = "GOINGDOWN1",
				},
				{
					["message"] = "GOINGDOWN2",
				},
			},
		},
		["TOOCLOSE"] = {
			["sequence"] = {
				{
					["message"] = "TOOCLOSE1",
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
	
	if Mission.Difficulty == 0 then
		Mission.SkillLevel = SKILL_STUN
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevel = SKILL_SPNORMAL
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevel = SKILL_SPVETERAN
	end
	if Mission.Difficulty == 0 then
		Mission.SkillLevelOwn = SKILL_ELITE
	elseif Mission.Difficulty == 1 then
		Mission.SkillLevelOwn = SKILL_SPVETERAN
	elseif Mission.Difficulty == 2 then
		Mission.SkillLevelOwn = SKILL_SPNORMAL
	end
	
	---- MUSIC ----
	
	Music_Control_SetLevel(MUSIC_TENSION)
	luaCheckMusicSetMinLevel(MUSIC_TENSION)
	
	---- SCORING ----
	
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaObj_FillSingleScores()
	
	---- USN ----
	
	Mission.Henry = FindEntity("HenryPT")
	
	Mission.Phoenix = FindEntity("Phoenix")
	
	Mission.Arizona = FindEntity("Arizona")
	Mission.WestVirginia = FindEntity("West Virginia")
	Mission.Nevada = FindEntity("Nevada")
	Mission.Utah = FindEntity("Utah")
	Mission.Maryland = FindEntity("Maryland")
	Mission.Oklahoma = FindEntity("Oklahoma")
	Mission.Tennessee = FindEntity("Tennessee")
	Mission.California = FindEntity("California")
	
	Mission.BBRowGang = {}
		table.insert(Mission.BBRowGang, FindEntity("Arizona"))
		table.insert(Mission.BBRowGang, FindEntity("West Virginia"))
		table.insert(Mission.BBRowGang, FindEntity("Nevada"))
		table.insert(Mission.BBRowGang, FindEntity("Utah"))
		table.insert(Mission.BBRowGang, FindEntity("Maryland"))
		table.insert(Mission.BBRowGang, FindEntity("Oklahoma"))
		table.insert(Mission.BBRowGang, FindEntity("Tennessee"))
		table.insert(Mission.BBRowGang, FindEntity("California"))
	
	for idx,unit in pairs(Mission.BBRowGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		SetInvincible(unit, 0.3)
		
	end
	
	Mission.EscortGang = {}
		table.insert(Mission.EscortGang, FindEntity("Phoenix"))
		table.insert(Mission.EscortGang, FindEntity("Sacramento"))
		table.insert(Mission.EscortGang, FindEntity("Raleigh"))
		table.insert(Mission.EscortGang, FindEntity("Downes"))
		table.insert(Mission.EscortGang, FindEntity("Cassin"))
		table.insert(Mission.EscortGang, FindEntity("Shaw"))
	
	for idx,unit in pairs(Mission.EscortGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	SetInvincible(FindEntity("Raleigh"), 0.4)
	
	Mission.SubGang = {}
		table.insert(Mission.SubGang, FindEntity("Tautog"))
	
	for idx,unit in pairs(Mission.SubGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.TransportGang = {}
		table.insert(Mission.TransportGang, FindEntity("Whitney"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 157"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 156"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 158"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 256"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 257"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 258"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 290"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 291"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 292"))
		table.insert(Mission.TransportGang, FindEntity("LST No. 122"))
	
	for idx,unit in pairs(Mission.TransportGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.CargoGang = {}
		table.insert(Mission.CargoGang, FindEntity("Neosho"))
		table.insert(Mission.CargoGang, FindEntity("Medusa"))
		table.insert(Mission.CargoGang, FindEntity("Vestal"))
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		RepairEnable(unit, false)
		AAEnable(unit, false)
		
	end
	
	Mission.EagleGang = {}
		table.insert(Mission.EagleGang, FindEntity("P-40 Warhawk 01"))
		table.insert(Mission.EagleGang, FindEntity("P-40 Warhawk 02"))
	
	for idx,unit in pairs(Mission.EagleGang) do
		
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
		
	end
	
	Mission.PTGang = {}
	Mission.RescueGang = {}
	
	Mission.HarborEscape = FindEntity("HarborEscape")
	
	---- IJN ----
	
	Mission.TypeA6M = 150
	Mission.TypeB5N = 162
	Mission.TypeD3A = 158
	
	Mission.ZeroGang = {}
	Mission.ValGang = {}
	Mission.KateGang = {}
	
	Mission.JapsToBeKilledGang = {}
	
	Mission.JapRetreat = FindEntity("JapRetreat")
	
	Mission.JapSpawnGang = {}
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnNorth1"))
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnNorth2"))
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnNorth3"))
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnSouth1"))
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnSouth2"))
		table.insert(Mission.JapSpawnGang, FindEntity("JapSpawnSouth3"))
	
	Mission.JapSpawnNorthGang = {}
		table.insert(Mission.JapSpawnNorthGang, FindEntity("JapSpawnNorth1"))
		table.insert(Mission.JapSpawnNorthGang, FindEntity("JapSpawnNorth2"))
		table.insert(Mission.JapSpawnNorthGang, FindEntity("JapSpawnNorth3"))
	
	Mission.JapSpawnSouthGang = {}
		table.insert(Mission.JapSpawnSouthGang, FindEntity("JapSpawnSouth1"))
		table.insert(Mission.JapSpawnSouthGang, FindEntity("JapSpawnSouth2"))
		table.insert(Mission.JapSpawnSouthGang, FindEntity("JapSpawnSouth3"))
	
	Mission.JapSpawnEastGang = {}
		table.insert(Mission.JapSpawnEastGang, FindEntity("JapSpawnEast1"))
		table.insert(Mission.JapSpawnEastGang, FindEntity("JapSpawnEast2"))
	
	Mission.JapFighterTrgGang = {}
	Mission.RunningJapGang = {}
	
	for idx,unit in pairs(recon[PARTY_ALLIED].own.landfort) do
		
		if not unit.Dead and (string.find(unit.Name, "Static warhawk") or string.find(unit.Name, "Static B") or string.find(unit.Name, "Static Catalina")) then
			
			table.insert(Mission.JapFighterTrgGang, unit)
			
		end
		
	end
	
	---- VAR ----
	
	Mission.FirePoints = {}
	
	for i=1,12 do
		
		local point = FindEntity("Boom_"..tostring(i))
		if point then
		
			table.insert(Mission.FirePoints, point)
			
		end
		
	end

	Mission.SmokePoints = {}
	
	for i=1,27 do
		
		local point = FindEntity("IslandEffect_"..tostring(i))
		if point then
		
			table.insert(Mission.SmokePoints, point)
			
		end
		
	end
	
	---- VALUES & VARIABLES ----
	
	Mission.MissionPhase = 0
	
	if Mission.Difficulty == 0 then
		
		Mission.JapFighterNum = 2
		Mission.JapAI = 1
	
	elseif Mission.Difficulty == 1 then
		
		Mission.JapFighterNum = 3
		Mission.JapAI = 2
	
	elseif Mission.Difficulty == 2 then
		
		Mission.JapFighterNum = 4
		Mission.JapAI = 3
	
	end
	
	Mission.ArizonaHits = 0
	Mission.WestVirginiaHits = 0
	Mission.NevadaHits = 0
	Mission.UtahHits = 0
	Mission.MarylandHits = 0
	Mission.OklahomaHits = 0
	Mission.TennesseHits = 0
	Mission.CaliforniaHits = 0
	
	Mission.Ratio = 1
	Mission.Ratio2 = 1
	
	Mission.DonaldShotDown = 0
	
	---- INIT FUNCT. ----
	
	EnableMessages(false)
	
	ForceEnableInput(IC_MAP_TOGGLE, false)
	
	Blackout(true, "", true)
	
	luaGenerateHarborTrafic()
	luaDelay(luaInitSubs, 9)
	
	MissionNarrative("December 7th, 1941 - Pearl Harbor")
	
	--luaAddBBRowHitListeners()
	
	---- THINK ----
	
	luaInitNewSystems()

    SetThink(this, "lua_Think")
	
	---- TEST ----
	
	--SetSimplifiedReconMultiplier(10.0)
	
	--luaDelay(luaMoveToPh4, 10)
	
	--SetParty(Mission.Henry, PARTY_JAPANESE)
	
	--luaDelay(luaInitThirdEfx, 10)
	
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
	
		luaStartMission()
		
		Mission.Started = true
		
		Mission.MissionPhase = 1
		
	end
	
	if Mission.MissionPhase < 99 then
		
		--[[local music_selectedUnit = GetSelectedUnit()

		if music_selectedUnit then

			luaCheckMusic(music_selectedUnit)

		end]]
		
		if Mission.MissionPhase <= 3 then
			
			if Mission.Henry.Dead then
			
				luaMissionFailed(Mission.Henry)
			
			else
				
				Mission.Ratio = Mission.Ratio - 0.002
				SetInvincible(Mission.Henry, Mission.Ratio)
			
			end
			
			local sd = Scoring_GetPlayerShotDown()
			
			if sd > 0 and not Mission.FirstDownDiaPlayed then
				
				luaStartDialog("GOTONE")
				
				Mission.FirstDownDiaPlayed = true
			
			elseif sd > 1 and not Mission.SecondDownDiaPlayed then
				
				luaStartDialog("DOWN1")
				
				Mission.SecondDownDiaPlayed = true
				
			elseif sd > 2 and not Mission.ThirdDownDiaPlayed then
				
				luaStartDialog("DOWN2")
				
				Mission.ThirdDownDiaPlayed = true
			
			end
			
			if GetHpPercentage(Mission.Arizona) <= 0.31 and not Mission.ArizonaSunk then
				
				luaArizonaHit()
				
				Mission.ArizonaSunk = true
				
			end
			
			if GetHpPercentage(Mission.WestVirginia) <= 0.31 and not Mission.WestVirginiaSunk then
				
				luaWVHit()
				
				Mission.WestVirginiaSunk = true
				
			end
			
			if GetHpPercentage(Mission.Nevada) <= 0.31 and not Mission.NevadaSunk then
				
				luaNevadaHit()
				
				Mission.NevadaSunk = true
				
			end
			
			if GetHpPercentage(Mission.Utah) <= 0.31 and not Mission.UtahSunk then
				
				luaUtahHit()
				
				Mission.UtahSunk = true
				
			end
			
			if GetHpPercentage(Mission.Maryland) <= 0.31 and not Mission.MarylandSunk then
				
				luaMarylandHit()
				
				Mission.MarylandSunk = true
				
			end
			
			if GetHpPercentage(Mission.Oklahoma) <= 0.31 and not Mission.OklahomaSunk then
				
				luaOklahomaHit()
				
				Mission.OklahomaSunk = true
				
			end
			
			if GetHpPercentage(Mission.Tennessee) <= 0.31 and not Mission.TennesseeSunk then
				
				luaTennesseHit()
				
				Mission.TennesseeSunk = true
				
			end
			
			if GetHpPercentage(Mission.California) <= 0.31 and not Mission.CaliforniaSunk then
				
				luaCaliforniaHit()
				
				Mission.CaliforniaSunk = true
				
			end
			
		else
		
			if Mission.Donald.Dead then
			
				luaMissionFailed(nil)
			
			else
				
				Mission.Ratio2 = Mission.Ratio2 - 0.004
				SetInvincible(Mission.Donald, Mission.Ratio2)
			
			end
		
		end
	
	end
	
	if Mission.MissionPhase == 1 then
		
		if luaGetDistance(Mission.Henry, Mission.Oklahoma) < 725 and not Mission.MorningDiaPlayed then
			
			luaStartDialog("MORNING")
			
			Mission.MorningDiaPlayed = true
			
		end
		
		if luaGetDistance(Mission.Henry, Mission.Phoenix) < 250 then
			
			HideScoreDisplay(1,0)
			luaMoveToPh2()
		
		else
			
			if luaObj_IsActive("primary",1) then
			
				luaDistanceCounter(Mission.Henry,Mission.Phoenix,1,"Go to the USS Phoenix!","ijn14.distance")
			
			end
			
		end
		
	elseif Mission.MissionPhase == 3 then
	
		if Mission.MiniSub and not Mission.MiniSub.Dead then
		
			local mynigga = HasFired(Mission.Henry, "DEPTHCHARGE", GameTime())
			
			if mynigga and not Mission.SubAliedDiaPlayed then
			
				luaDelay(luaAliveDia, 4)
				
				luaDelay(luaOperationalDia, 10)
				
				Mission.SubAliedDiaPlayed = true
			
			end
		
		end
	
	elseif Mission.MissionPhase == 4 then
	
		if luaObj_IsActive("primary",4) then
			
			--local bruh = Scoring_GetPlayerShotDown()
			
			--Mission.DonaldShotDown = bruh - Mission.HenryShotDown
			
			local line1 = "Take revenge for Pearl Harbor!"
			local line2 = "Planes shot down: #Mission.DonaldShotDown#"
			luaDisplayScore(1, line1, line2)
			
			if Mission.DonaldShotDown > 0 and not Mission.GoodGuysDiaPlayed then
			
				luaStartDialog("SCORE")
				
				Mission.GoodGuysDiaPlayed = true
			
			elseif Mission.DonaldShotDown > 3 and not Mission.GreatDiaPlayed then
			
				luaStartDialog("GREAT")
				
				Mission.GreatDiaPlayed = true
			
			elseif Mission.DonaldShotDown > 5 and not Mission.DownDiaPlayed then
				
				luaStartDialog("GOINGDOWN")
				
				Mission.DownDiaPlayed = true
				
			end
			
			if Mission.DonaldShotDown >= 10 or table.getn(luaRemoveDeadsFromTable(Mission.RunningJapGang)) == 0 or luaGetDistance(Mission.Donald, Mission.Akagi) > 17000 then
				
				RemoveListener("kill", "DonaldKillListener")
				
				HideScoreDisplay(1,0)
				luaObj_Completed("primary", 4)
				luaObj_Completed("primary", 5)
				
				PilotMoveToRange(Mission.Donald, Mission.HarborEscape)
				
				luaStartDialog("TOOCLOSE")
				
				Mission.EndMission = true
				
			end
			
			if not Mission.ZeroAttacking and Mission.AttackingZeroCanAttack then
				
				Mission.AttackingZeroSetToSpawn = false
				
				local higuysmynameismrbullseyeandIlikeplayingWarThunder = random(1,2)
				local bruhmoment
				
				if higuysmynameismrbullseyeandIlikeplayingWarThunder == 1 then
				
					bruhmoment = -1500
				
				elseif higuysmynameismrbullseyeandIlikeplayingWarThunder == 2 then
				
					bruhmoment = 1500
				
				end
				
				local donaldpos = GetPosition(Mission.Donald)
				local donaldposY = donaldpos.y
				
				luaSpawnJap(Mission.TypeA6M, 3, GetPosition(Mission.Donald), 0, random(-700,700), donaldposY, bruhmoment)
				
				Mission.AttackingZeroCanAttack = false
				Mission.ZeroAttacking = true
				
			elseif Mission.ZeroAttacking then
				
				if Mission.AttackingZero == nil or Mission.AttackingZero.Dead and not Mission.AttackingZeroSetToSpawn then
				
					luaDelay(luaDelayedZeroSpawn, 8)
					
					Mission.AttackingZeroSetToSpawn = true
					
				end
				
			end
			
		end
		
	end
	
	---- TEST ----
	
end

---- PHASE 4 ----

function luaMoveToPh4()
	
	Loading_Start()
	
	Mission.MissionPhase = 4
	Mission.AttackRunning = false
	
	Mission.HenryShotDown = Scoring_GetPlayerShotDown()
	
	--Kill(FindEntity("Landscape 01"), true)
	
	SetInvincible(Mission.Henry, 0.01)
	
	SetRoleAvailable(Mission.Henry, EROLF_ALL, PLAYER_AI)
	
	Mission.Donald = GenerateObject("Donald")
	--Mission.EagleTwo = GenerateObject("EagleTwo")
	--Mission.EagleThree = GenerateObject("EagleThree")
	
	SetGuiName(Mission.Donald,"Donald",true) 
	
	--SetRoleAvailable(Mission.EagleTwo, EROLF_ALL, PLAYER_AI)
	--SetRoleAvailable(Mission.EagleThree, EROLF_ALL, PLAYER_AI)
	
	--SetInvincible(Mission.EagleTwo, true)
	--SetInvincible(Mission.EagleThree, true)
	
	--SetSkillLevel(Mission.EagleTwo, SKILL_ELITE)
	--SetSkillLevel(Mission.EagleThree, SKILL_ELITE)
	
	Mission.Akagi = GenerateObject("Akagi")
	Mission.Kaga = GenerateObject("Kaga")
	Mission.Hiryu = GenerateObject("Hiryu")
	Mission.Soryu = GenerateObject("Soryu")
	Mission.Zuikaku = GenerateObject("Zuikaku")
	Mission.Shokaku = GenerateObject("Shokaku")
	Mission.Hiei = GenerateObject("Hiei")
	Mission.Tone = GenerateObject("Tone")
	Mission.Fubuki1 = GenerateObject("Fubuki-class01")
	Mission.Fubuki2 = GenerateObject("Fubuki-class02")
	Mission.Fubuki3 = GenerateObject("Fubuki-class03")
	Mission.Fubuki4 = GenerateObject("Fubuki-class04")
	Mission.Fubuki5 = GenerateObject("Fubuki-class05")
	Mission.Fubuki6 = GenerateObject("Fubuki-class06")
	Mission.Fubuki7 = GenerateObject("Fubuki-class07")
	Mission.Fubuki8 = GenerateObject("Fubuki-class08")
	
	Mission.JapFleetGang = {}
		table.insert(Mission.JapFleetGang, FindEntity("Akagi"))
		table.insert(Mission.JapFleetGang, FindEntity("Kaga"))
		table.insert(Mission.JapFleetGang, FindEntity("Hiryu"))
		table.insert(Mission.JapFleetGang, FindEntity("Soryu"))
		table.insert(Mission.JapFleetGang, FindEntity("Zuikaku"))
		table.insert(Mission.JapFleetGang, FindEntity("Shokaku"))
		table.insert(Mission.JapFleetGang, FindEntity("Hiei"))
		table.insert(Mission.JapFleetGang, FindEntity("Tone"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class01"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class02"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class03"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class04"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class05"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class06"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class07"))
		table.insert(Mission.JapFleetGang, FindEntity("Fubuki-class08"))
	
	Mission.JapFleetCVGang = {}
		table.insert(Mission.JapFleetCVGang, FindEntity("Akagi"))
		table.insert(Mission.JapFleetCVGang, FindEntity("Kaga"))
		table.insert(Mission.JapFleetCVGang, FindEntity("Hiryu"))
		table.insert(Mission.JapFleetCVGang, FindEntity("Soryu"))
		table.insert(Mission.JapFleetCVGang, FindEntity("Zuikaku"))
		table.insert(Mission.JapFleetCVGang, FindEntity("Shokaku"))
	
	for idx,unit in pairs(Mission.JapFleetGang) do
	
		SetSkillLevel(unit, Mission.SkillLevel)
		SetInvincible(unit, true)
		
	end
	
	for idx,unit in pairs(Mission.RunningJapGang) do
	
		SetSkillLevel(unit, Mission.SkillLevel)
	
	end
	
	for i = 1,10 do
		
		luaSpawnJap(Mission.TypeD3A, 3, GetPosition(luaPickRnd(Mission.JapFleetCVGang)), 0, random(-10500,-4500), random(500,900), random(-2000,2000))
		
		luaSpawnJap(Mission.TypeB5N, 3, GetPosition(luaPickRnd(Mission.JapFleetCVGang)), 0, random(-10500,-4500), random(500,900), random(-2000,2000))
		
	end
	
	--local planes = luaSortByDistance(Mission.Donald, luaRemoveDeadsFromTable(Mission.RunningJapGang))
	--local closesttrg = planes[1]
	--PilotSetTarget(Mission.Donald, luaPickRnd(luaRemoveDeadsFromTable(Mission.RunningJapGang)))
	
	--PilotSetTarget(Mission.EagleTwo, Mission.Donald)
	--PilotSetTarget(Mission.EagleThree, Mission.Donald)
	
	SetSelectedUnit(Mission.Donald)
	
	luaAddDonaldKillListener()
	
	Loading_Finish()
	
	luaPlayMovie3()
	
	luaDelay(luaEagleDia, 1)
	luaDelay(luaShootDia, 70)
	luaDelay(luaTailDia, 150)
	
	luaDelay(luaStartZeroSpawning, 30)
	
end

function luaEagleDia()

	luaStartDialog("EAGLE")

end

function luaShootDia()
	
	if not Mission.EndMission then
	
		luaStartDialog("SHOOT")
	
	end
	
end

function luaTailDia()
	
	if not Mission.EndMission then
	
		luaStartDialog("TAIL")
	
	end
	
end

function luaAddFinalObjs()

	luaObj_Add("primary", 4)
	luaObj_Add("primary", 5)

end

function luaDelayedZeroSpawn()
	
	Mission.AttackingZeroCanAttack = true
	
end

function luaStartZeroSpawning()

	Mission.AttackingZeroCanAttack = true

end

---- PHASE 3 ----

function luaMoveToPh3()
	
	Mission.MissionPhase = 3
	
	HideScoreDisplay(1,0)
	luaObj_Completed("primary", 2)
	
	luaInitJapSub()
	
	luaPlayMovie2()
	
	luaDelay(luaSubDia, 4)
	
end

function luaSubDia()

	luaStartDialog("PERISCOPE")

end

function luaAddThirdObj()

	luaObj_Add("primary", 3, Mission.MiniSub)
	
	luaAddMiniSubListener()
	
	local line1 = "Destroy the enemy mini-sub!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
end

function luaInitJapSub()

	Mission.MiniSub = GenerateObject("MiniSub")
	
	local unitpos = GetPosition(FindEntity("MiniSubSpawn"))
	unitpos.x = unitpos.x + 0
	unitpos.y = unitpos.y - 30
	unitpos.z = unitpos.z + 0
	
	PutTo(Mission.MiniSub, unitpos)
	
	SetShipMaxSpeed(Mission.MiniSub, 15)
	SetUnlimitedAirSupply(Mission.MiniSub, true)
	SetSubmarineDepthLevel(Mission.MiniSub, 1)
	--ForceSubmarinePeriscope(Mission.MiniSub, true)
	--SetSubmarineUseSubSurfaces(Mission.MiniSub, false)
	SetForcedReconLevel(Mission.MiniSub, 2, PARTY_ALLIED)
	
	SetInvincible(Mission.MiniSub, true)
	
	EntityTurnToEntity(Mission.MiniSub, Mission.WestVirginia)
	NavigatorMoveOnPath(Mission.MiniSub, FindEntity("pt_path3"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	Mission.SubHere = true

end

function luaAliveDia()
	
	if Mission.MiniSub and not Mission.MiniSub.Dead then
	
		luaStartDialog("TARGET")
	
	end
	
end

function luaOperationalDia()
	
	if Mission.MiniSub and not Mission.MiniSub.Dead then
	
		luaStartDialog("OPERATIONAL")
	
	end
	
end

---- PHASE 2 ----

function luaMoveToPh2()
	
	Loading_Start()
	
	Mission.MissionPhase = 2
	Mission.AttackRunning = true
	
	luaObj_Completed("primary", 1)
	
	luaGenerateJapTraffic()
	luaGeneratePanicTraffic()
	luaAddEfx()
	
	for idx,unit in pairs(luaRemoveDeadsFromTable(Mission.EagleGang)) do
		
		if unit and not unit.Dead then
		
			Kill(unit,true)
		
		end
	
	end
	
	ExplodeToParts(Mission.Phoenix)
	BreakShip(Mission.Phoenix)
	SetDeadMeat(Mission.Phoenix)
	
	SetRoleAvailable(Mission.Henry, EROLF_ALL, PLAYER_ANY)
	
	EntityTurnToEntity(Mission.Henry, FindEntity("Sacramento"))
	SetSelectedUnit(Mission.Henry)
	
	Music_Control_SetLevel(MUSIC_ACTION)
	luaCheckMusicSetMinLevel(MUSIC_ACTION)
	
	luaDelay(luaMoveToPh3, 150)
	
	Loading_Finish()
	
	luaPlayMovie1()
	
	luaDelay(luaCalsDia, 4)
	
end

function luaCalsDia()
	
	luaObj_Add("primary", 2)
	
	local line1 = "Survive the first attack wave!"
	local line2 = ""
	luaDisplayScore(1, line1, line2)
	
	luaStartDialog("CALS")

end

function luaGenerateJapTraffic()

	if Mission.AttackRunning then
		
		if not Mission.JapTrafficStarted then
			
			for i = 1,5 do
				
				if i <= Mission.JapFighterNum then
				
					luaSpawnJap(Mission.TypeA6M, 3, GetPosition(luaPickRnd(Mission.JapSpawnNorthGang)), 0, 0, 200)
				
				end
				
				luaSpawnJap(Mission.TypeD3A, 3, GetPosition(luaPickRnd(Mission.JapSpawnSouthGang)), 1, 0, 150)
				
				luaSpawnJap(Mission.TypeB5N, 3, GetPosition(luaPickRnd(Mission.JapSpawnSouthGang)), 1, 0, 150)
				
			end
			
			for i = 1,2 do
			
				luaSpawnJap(Mission.TypeB5N, 3, GetPosition(luaPickRnd(Mission.JapSpawnEastGang)), 1, 0, 150)
			
			end
			
			Mission.JapTrafficStarted = true
			
			luaDelay(luaJapBomberFlow, 30)
			luaDelay(luaKillOffJaps, 40)
			
		else
			
			local zeros = luaRemoveDeadsFromTable(Mission.ZeroGang)
			local vals = luaRemoveDeadsFromTable(Mission.ValGang)
			local kates = luaRemoveDeadsFromTable(Mission.KateGang)
			
			if table.getn(zeros) > 0 then
				
				if table.getn(zeros) < Mission.JapFighterNum then
				
					luaSpawnJap(Mission.TypeA6M, 3, GetPosition(luaPickRnd(Mission.JapSpawnGang)), 0, 0, 200)
				
				end
				
				for idx,unit in pairs(zeros) do
				
					if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
						
						local trg = luaGetJapTrg(1)
						
						if trg == nil and unit.strafing then
							
							UnitSetFireStance(unit, 2)
							
							unit.strafing = false
							
						elseif trg and not unit.strafing then
							
							UnitSetFireStance(unit, 1)
							luaSetScriptTarget(unit, trg)
							PilotSetTarget(unit, trg)
							
							unit.strafing = true
							
						end
						
					end
				
				end
			
			end
			
			if table.getn(vals) > 0 then
				
				for idx,unit in pairs(vals) do
					
					if (GetProperty(unit,"ammoType") ~= 0) then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
							local trg = luaGetJapTrg(2)
							
							if trg == nil and unit.attacking then
								
								UnitSetFireStance(unit, 2)
								
								unit.attacking = false
								
							elseif trg and not unit.attacking then
								
								UnitSetFireStance(unit, 1)
								luaSetScriptTarget(unit, trg)
								PilotSetTarget(unit, trg)
								
								unit.attacking = true
								
							end
							
						end
					
					else
					
						if not unit.retreating then
						
							PilotMoveToRange(unit, Mission.JapRetreat)
							
							unit.retreating = true
						
						end
					
					end
					
				end
			
			end
			
			if table.getn(kates) > 0 then
				
				for idx,unit in pairs(kates) do
				
					if (GetProperty(unit,"ammoType") ~= 0) then
					
						if luaGetScriptTarget(unit) == nil or luaGetScriptTarget(unit).Dead then
							
							local trg = luaGetJapTrg(3)
							
							if trg == nil and unit.attacking then
								
								UnitSetFireStance(unit, 2)
								
								unit.attacking = false
								
							elseif trg and not unit.attacking then
								
								UnitSetFireStance(unit, 1)
								luaSetScriptTarget(unit, trg)
								PilotSetTarget(unit, trg)
								
								unit.attacking = true
								
							end
							
						end
					
					else
					
						if not unit.retreating then
						
							PilotMoveToRange(unit, Mission.JapRetreat)
							
							unit.retreating = true
						
						end
					
					end
				
				end
			
			end
			
		end
		
		luaDelay(luaGenerateJapTraffic, 3)
		
	end

end

function luaJapBomberFlow()

	if Mission.AttackRunning and Mission.JapTrafficStarted then
	
		for i = 1,3 do
			
			local spawn = Mission.JapSpawnSouthGang[i]
			
			luaSpawnJap(Mission.TypeD3A, 3, GetPosition(spawn), 1, 0, 150)
			
			luaSpawnJap(Mission.TypeB5N, 3, GetPosition(spawn), 1, 0, 150)
			
		end
		
		luaDelay(luaJapBomberFlow, 45)
		
	end

end

function luaSpawnJap(class, wngCount, pos, equipment, spawnDelta, alt, spawnDeltaX)
	
	if not spawnDeltaX or spawnDeltaX == nil then
	
		spawnDeltaX = 0
	
	end
	
	local spawnpos = pos
	spawnpos.x = spawnpos.x + spawnDeltaX
	spawnpos.y = spawnpos.y + alt
	spawnpos.z = spawnpos.z + spawnDelta
	
	SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = class,
				["Name"] = "Jap",
				["Crew"] = Mission.JapAI,
				["Race"] = Japan,
				["WingCount"] = wngCount,
				["Equipment"] = equipment,
			},
		},
		["area"] = {
			["refPos"] = spawnpos,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaJapSpawned",
		["excludeRadiusOverride"] = {
		["ownHorizontal"] = 150,
		["enemyHorizontal"] = 150,
		["ownVertical"] = 150,
		["enemyVertical"] = 150,
		["formationHorizontal"] = 100,
		},
	})

end

function luaJapSpawned(unit)
	
	if Mission.AttackRunning then
	
		if unit.Class.Name == "globals.unitclass_zero" then
		
			table.insert(Mission.ZeroGang, unit)
		
		elseif unit.Class.Name == "globals.unitclass_val" then
			
			SquadronSetTravelAlt(unit, 150, true)
			SquadronSetAttackAlt(unit, 150, true)
			
			table.insert(Mission.ValGang, unit)
			
		elseif unit.Class.Name == "globals.unitclass_kate" then
			
			SquadronSetTravelAlt(unit,150, true)
			SquadronSetAttackAlt(unit, 30, true)
			
			table.insert(Mission.KateGang, unit)
		
		end
	
	else
		
		if unit.Class.Name == "globals.unitclass_val" or unit.Class.Name == "globals.unitclass_kate" then
		
			local unitPos = GetPosition(unit)
			local unitPosY = unitPos.y
			
			SquadronSetTravelAlt(unit, unitPosY, true)
			
			local trgcv = luaPickRnd(Mission.JapFleetCVGang)
			
			EntityTurnToEntity(unit, trgcv)
			PilotLand(unit, trgcv)
			
			table.insert(Mission.RunningJapGang, unit)
		
		elseif unit.Class.Name == "globals.unitclass_zero" then
			
			Mission.AttackingZero = unit
			
			EntityTurnToEntity(unit, Mission.Donald)
			PilotSetTarget(unit, Mission.Donald)
			
			MissionNarrative("Zeros! They're coming in fast!")
			
		end
		
	end
	
end

function luaGetJapTrg(bruh)

	if bruh == 1 then
	
		return luaPickRnd(luaRemoveDeadsFromTable(Mission.JapFighterTrgGang))
	
	elseif bruh == 2 then
	
		return luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	
	elseif bruh == 3 then
	
		return luaPickRnd(luaRemoveDeadsFromTable(Mission.BBRowGang))
	
	end
	
	return nil
	
end

function luaKillOffJaps()
	
	local bruhgang = luaRemoveDeadsFromTable(Mission.JapsToBeKilledGang)
	
	if table.getn(bruhgang) > 0 then
		
		for idx,unit in pairs(bruhgang) do
		
			if unit and not unit.Dead then
				
				if luaGetDistance(unit, Mission.Henry) > 2000 then
				
					Kill(unit,true)
				
				end
				
			end
		
		end
		
		luaDelay(luaKillOffJaps, 15)
		
	end
	
end

function luaGeneratePanicTraffic()

	local PTNames = {
		
		[1] = "PT-25",
		[2] = "PT-26",
		[3] = "PT-27",
		[4] = "PT-28",
		
	}
	
	local paths = {FindEntity("pt_path1"),FindEntity("pt_path2"),FindEntity("pt_path3"),FindEntity("pt_path4")}
	
	for idx,path in pairs(paths) do
		
		local pathTbl = FillPathPoints(path)
		local pt = GenerateObject("PT", PTNames[idx])
		local rescue = GenerateObject("Rescue")
		
		SetRoleAvailable(pt, EROLF_ALL, PLAYER_AI)
		SetGuiName(pt, PTNames[idx])
		table.insert(Mission.PTGang, pt)
		table.insert(Mission.JapFighterTrgGang, pt)
		AAEnable(pt, false)
		
		SetRoleAvailable(rescue, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.RescueGang, rescue)
		table.insert(Mission.JapFighterTrgGang, rescue)
		
		if idx > 1 and idx < 4 then
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
		else
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
		end
		
	end
	
	luaDelay(luaInitFirstRunners, 60)
	luaDelay(luaInitSecondRunners, 110)
	luaDelay(luaInitThirdRunners, 120)
	
end

function luaInitFirstRunners()

	NavigatorMoveOnPath(FindEntity("Nevada"), FindEntity("nevada_beaching"))
	
	NavigatorMoveOnPath(FindEntity("Neosho"), FindEntity("NeoshoPath"), PATH_FM_SIMPLE, PATH_SM_JOIN, 5)
	
	NavigatorMoveOnPath(FindEntity("Shaw"), FindEntity("pt_path3"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	NavigatorMoveToPos(FindEntity("LST No. 157"), Mission.HarborEscape)
	NavigatorMoveToPos(FindEntity("LST No. 256"), Mission.HarborEscape)
	
	if FindEntity("LST No. 122") and not FindEntity("LST No. 122").Dead then
	
		NavigatorMoveToPos(FindEntity("LST No. 122"), Mission.HarborEscape)
		
	end
	
	for idx,unit in pairs(Mission.PTGang) do
		
		if unit and not unit.Dead then
		
			AAEnable(unit, true)
		
		end
		
	end
	
	for idx,unit in pairs(Mission.CargoGang) do
		
		if unit and not unit.Dead then
		
			AAEnable(unit, true)
		
		end
		
	end
	
	AAEnable(Mission.Nevada, true)
	
end

function luaInitSecondRunners()
	
	NavigatorMoveOnPath(FindEntity("Whitney"), FindEntity("pt_path4"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	for idx,unit in pairs(Mission.SubGang) do
		
		if unit and not unit.Dead then
			
			AAEnable(unit, true)
		
		end
		
	end
	
	for idx,unit in pairs(Mission.EscortGang) do
		
		if unit and not unit.Dead then
			
			AAEnable(unit, true)
		
		end
		
	end

end

function luaInitThirdRunners()

	NavigatorMoveOnPath(FindEntity("Raleigh"), FindEntity("pt_path3"), PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
	
	luaDelay(luaSinkRaleigh, 30)
	
end

function luaAddEfx()

	luaDelay(luaInitFirstEfx, 45)
	luaDelay(luaInitSecondEfx, 95)
	luaDelay(luaInitThirdEfx, 115)

end

function luaInitFirstEfx()

	local efxName = {"GiantSmoke", "GiantSmoke"}
	
	for idx,point in pairs(Mission.SmokePoints) do
		
		local efx

		if not Mission.BigSmoke then
		
			efx = Effect(efxName[2], GetPosition(point))
			
			Mission.BigSmoke = true
			
		else
			
			efx = Effect(efxName[1], GetPosition(point))
			
		end
		
	end

end

function luaInitSecondEfx()

	for idx,point in pairs(Mission.FirePoints) do
		
		local efx

		if not Mission.BigFire then
			
			efx = Effect("BigFire", GetPosition(point))
			
			Mission.BigFire = true
			
		else
			
			efx = Effect("BigFire", GetPosition(point))
		
		end
		
	end

end

function luaInitThirdEfx()
	
	for i = 1,4 do
	
		local efx1 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke1")))
		local efx2 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke2")))
		local efx2 = Effect("EnvironmentSmokeBackground", GetPosition(FindEntity("BGSmoke3")))
	
	end
	
	--[[local debrisTbl = {
	
		[1] = {GetPosition(FindEntity("Debris1_1")), GetPosition(FindEntity("Debris1_2")),},
		[2] = {GetPosition(FindEntity("Debris2_1")), GetPosition(FindEntity("Debris2_2")),},
	
	}

	for idx,tbl in pairs(debrisTbl) do
		
		TempAddFloatsam({
			["topBox"] = {
				["minCorner"] = tbl[1],
				["maxCorner"] = tbl[2],
			},
			["buoyClassNames"] = { "Debrish_01", "Debrish_02", "Debrish_03", "Debrish_04", "Vizihulla_01", "Vizihulla_02", "Mentoov", "Box", },
			["buoyTypeWeights"] = { 3, 3, 3, 3, 2, 2, 1, 2, },
			["buoyGap"] = 40,
			["buoyDev"] = 20,
		})
	
	end]]

end

function luaSinkRaleigh()

	DisablePhysics(FindEntity("Raleigh"))
	
	local trTbl = {["x"] = 0, ["y"] = -10, ["z"] = 200}
	local rotTbl = {["x"] = -0.2, ["y"] = 0, ["z"] = 1}
	
	AddMatrixInterpolator(FindEntity("Raleigh"), trTbl, rotTbl, 20)

end

---- PHASE 1 ----

function luaStartMission()
	
	--SetShipMaxSpeed(Mission.Henry, 20.5778)
	ShipSetTorpedoStock(Mission.Henry, 0)
	
	SetSelectedUnit(Mission.Henry)
	
	SetRoleAvailable(Mission.Henry, EROLF_ALL, PLAYER_AI)
	SetRoleAvailable(Mission.Henry, EROLE_CAPTAIN, PLAYER_ANY)
	SetRoleAvailable(Mission.Henry, EROLE_PILOT, PLAYER_ANY)
	UnitSetPlayerCommandsEnabled(Mission.Henry, PCF_NONE)
	
	Blackout(false, "", 2)
	
	luaDelay(luaIntroDia, 1)
	
end

function luaIntroDia()
	
	luaStartDialog("WELCOME")
	
end

function luaAddFirstObj()

	luaObj_Add("primary", 1, GetPosition(Mission.Phoenix))
	luaObj_Add("hidden", 1)
	
end

function luaGenerateHarborTrafic()
	
	local PTNames = {
		
		[1] = "PT-20",
		[2] = "PT-21",
		[3] = "PT-22",
		[4] = "PT-24",
		
	}
	
	local paths = {FindEntity("pt_path1"),FindEntity("pt_path2"),FindEntity("pt_path3"),FindEntity("pt_path4")}
	
	for idx,path in pairs(paths) do
		
		local pathTbl = FillPathPoints(path)
		local pt = GenerateObject("PT", PTNames[idx])
		local rescue = GenerateObject("Rescue")
		
		SetRoleAvailable(pt, EROLF_ALL, PLAYER_AI)
		SetGuiName(pt, PTNames[idx])
		table.insert(Mission.PTGang, pt)
		table.insert(Mission.JapFighterTrgGang, pt)
		AAEnable(pt, false)
		
		SetRoleAvailable(rescue, EROLF_ALL, PLAYER_AI)
		table.insert(Mission.RescueGang, rescue)
		table.insert(Mission.JapFighterTrgGang, rescue)
		
		if idx > 1 and idx < 4 then
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
		else
		
			PutTo(pt, pathTbl[random(2,10)])
			NavigatorMoveOnPath(pt, path, PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
			
			PutTo(rescue, pathTbl[random(2,10)])
			NavigatorMoveOnPath(rescue, path, PATH_FM_CIRCLE, PATH_SM_JOIN, random(20,25))
			
		end
		
	end
	
	local bruh = GenerateObject("Rescue")
	SetRoleAvailable(bruh, EROLF_ALL, PLAYER_AI)
	NavigatorMoveOnPath(bruh, FindEntity("henry_path"), PATH_FM_SIMPLE, PATH_SM_JOIN, 8)
	table.insert(Mission.JapFighterTrgGang, bruh)
	
	SetShipMaxSpeed(FindEntity("Whitney"), 6)
	NavigatorMoveToPos(FindEntity("Whitney"), FindEntity("WhitneyGoTo"))
	
	NavigatorMoveOnPath(FindEntity("LST No. 122"), FindEntity("pt_path1"), PATH_FM_CIRCLE, PATH_SM_JOIN_BACKWARDS, random(20,25))
	
	PilotMoveOnPath(FindEntity("P-40 Warhawk 01"), FindEntity("PatrolPath1"), PATH_FM_CIRCLE)
	SquadronSetTravelAlt(FindEntity("P-40 Warhawk 01"), 200)
	table.insert(Mission.JapFighterTrgGang, FindEntity("P-40 Warhawk 01"))
	PilotMoveOnPath(FindEntity("P-40 Warhawk 02"), FindEntity("PatrolPath2"), PATH_FM_CIRCLE)
	SquadronSetTravelAlt(FindEntity("P-40 Warhawk 02"), 200)
	table.insert(Mission.JapFighterTrgGang, FindEntity("P-40 Warhawk 02"))
	
end

function luaInitSubs()
	
	SetShipMaxSpeed(FindEntity("Tautog"), 6)
	NavigatorMoveToPos(FindEntity("Tautog"), FindEntity("TautogGoTo"))

end

---- LISTENERS ----

--[[function luaAddBBRowHitListeners()

	AddListener("hit", "ArizonaHitListener", {
		["callback"] = "luaArizonaHit", 
		["target"] = {Mission.Arizona}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "WVHitListener", {
		["callback"] = "luaWVHit", 
		["target"] = {Mission.WestVirginia}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "NevadaHitListener", {
		["callback"] = "luaNevadaHit", 
		["target"] = {Mission.Nevada}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

	AddListener("hit", "UtahHitListener", {
		["callback"] = "luaUtahHit", 
		["target"] = {Mission.Utah}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "MarylandHitListener", {
		["callback"] = "luaMarylandHit", 
		["target"] = {Mission.Maryland}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "OklahomaHitListener", {
		["callback"] = "luaOklahomaHit", 
		["target"] = {Mission.Oklahoma}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "TennesseHitListener", {
		["callback"] = "luaTennesseHit", 
		["target"] = {Mission.Tennessee}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})
	
	AddListener("hit", "CaliforniaHitListener", {
		["callback"] = "luaCaliforniaHit", 
		["target"] = {Mission.California}, 
		["targetDevice"] = {}, 
		["attacker"] = {}, 
		["attackType"] = {"TORPEDO"}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end]]

function luaAddDonaldKillListener()

	AddListener("kill", "DonaldKillListener", {
		["callback"] = "luaDonaldKilled",
		["entity"] = {},
		["lastAttacker"] = {Mission.Donald},
		["lastAttackerPlayerIndex"] = {},
	})

end

function luaAddMiniSubListener()

	AddListener("hit", "MiniSubHitListener", {
		["callback"] = "luaMiniSubHit", 
		["target"] = {Mission.MiniSub}, 
		["targetDevice"] = {}, 
		["attacker"] = {Mission.Henry}, 
		["attackType"] = {}, 
		["attackerPlayerIndex"] = {}, 
		["damageCaused"] = {}, 
		["fireCaused"] = {}, 
		["leakCaused"] = {}, 
	})

end

---- LISTENER CALLBACKS ----

function luaDonaldKilled()
	
	Mission.DonaldShotDown = Mission.DonaldShotDown + 1
	
	MissionNarrative("#Mission.DonaldShotDown# killed!")

end

function luaMiniSubHit()
	
	RemoveListener("hit", "MiniSubHitListener")
	
	SetInvincible(Mission.MiniSub, false)
	
	AddDamage(Mission.MiniSub, 9999)
	
	Mission.SubHere = false
	
	HideScoreDisplay(1,0)
	luaObj_Completed("primary", 3)
	
	luaStartDialog("WEGOTIT")
	
end

function luaArizonaHit()
	
	--[[if Mission.ArizonaHits < 3 then
	
		Mission.ArizonaHits = Mission.ArizonaHits + 1
	
	else
	
		RemoveListener("hit", "ArizonaHitListener")]]
		
		for i = 1,8 do
		
			luaBlowUp(Mission.Arizona)
		
		end
		
		local pos = {["x"]=0, ["y"] = Mission.Arizona.Class.Height+3, ["z"]=0 }
		Effect("ExplosionMagazine", pos, Mission.Arizona, 20)
		Effect("GiantSmoke", pos, Mission.Arizona, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Arizona.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Arizona, 20)
		
		SetDamagedGFXLevel(Mission.Arizona, 1)
		DisablePhysics(Mission.Arizona)
		AddMatrixInterpolator(Mission.Arizona, {["x"]=0, ["y"]=-15, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-5)}, 30)
		
		luaStartDialog("ARIZONA")
		
	--end

end

function luaWVHit()
	
	--[[if Mission.WestVirginiaHits < 3 then
	
		Mission.WestVirginiaHits = Mission.WestVirginiaHits + 1
	
	else
	
		RemoveListener("hit", "WestVirginiaHitListener")]]
		
		luaBlowUp(Mission.WestVirginia)
		
		local pos = {["x"]=0, ["y"] = Mission.WestVirginia.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.WestVirginia, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.WestVirginia.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.WestVirginia, 20)
		
		SetDamagedGFXLevel(Mission.WestVirginia, 1)
		DisablePhysics(Mission.WestVirginia)
		AddMatrixInterpolator(Mission.WestVirginia, {["x"]=0, ["y"]=-10, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(30),}, 45)
		
	--end

end

function luaNevadaHit()
	
	--[[if Mission.NevadaHits < 3 then
	
		Mission.NevadaHits = Mission.NevadaHits + 1
	
	else
	
		RemoveListener("hit", "NevadaHitListener")]]
		
		luaBlowUp(Mission.Nevada)
		
		local pos = {["x"]=0, ["y"] = Mission.Nevada.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Nevada, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Nevada.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Nevada, 20)
		
		SetDamagedGFXLevel(Mission.Nevada, 1)
		DisablePhysics(Mission.Nevada)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Nevada, {["x"]=0, ["y"]=-7, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, 1)
	
	--end

end

function luaUtahHit()

	--[[if Mission.UtahHits < 3 then
	
		Mission.UtahHits = Mission.UtahHits + 1
	
	else
	
		RemoveListener("hit", "UtahHitListener")]]
		
		luaBlowUp(Mission.Utah)
		
		local pos = {["x"]=0, ["y"] = Mission.Utah.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Utah, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Utah.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Utah, 20)
		
		SetDamagedGFXLevel(Mission.Utah, 1)
		DisablePhysics(Mission.Utah)
		local x = random(-5,35)
		AddMatrixInterpolator(Mission.Utah, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
	
	--end

end

function luaMarylandHit()
	
	--[[if Mission.MarylandHits < 3 then
	
		Mission.MarylandHits = Mission.MarylandHits + 1
	
	else
	
		RemoveListener("hit", "MarylandHitListener")]]
		
		luaBlowUp(Mission.Maryland)
		
		local pos = {["x"]=0, ["y"] = Mission.Maryland.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Maryland, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Maryland.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Maryland, 20)
		
		SetDamagedGFXLevel(Mission.Maryland, 1)
		DisablePhysics(Mission.Maryland)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Maryland, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
	
	--end

end

function luaOklahomaHit()
	
	--[[if Mission.OklahomaHits < 3 then
	
		Mission.OklahomaHits = Mission.OklahomaHits + 1
	
	else
	
		RemoveListener("hit", "OklahomaHitListener")]]
		
		luaBlowUp(Mission.Oklahoma)
		
		local pos = {["x"]=0, ["y"] = Mission.Oklahoma.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Oklahoma, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Oklahoma.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Oklahoma, 20)
		
		SetDamagedGFXLevel(Mission.Oklahoma, 1)
		DisablePhysics(Mission.Oklahoma)
		local x = random(-5,35)
		AddMatrixInterpolator(Mission.Oklahoma, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
		
		luaDelay(luaOklahomaRoll, 36)
		
	--end

end

function luaOklahomaRoll()

	AddMatrixInterpolator(Mission.Oklahoma, {["x"]=0, ["y"]=-4, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(25),}, 30)
	
	luaStartDialog("OKLAHOMA")

end

function luaTennesseHit()
	
	--[[if Mission.TennesseHits < 3 then
	
		Mission.TennesseHits = Mission.TennesseHits + 1
	
	else
	
		RemoveListener("hit", "TennesseHitListener")]]
		
		luaBlowUp(Mission.Tennessee)
		
		local pos = {["x"]=0, ["y"] = Mission.Tennessee.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.Tennessee, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.Tennessee.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.Tennessee, 20)
		
		SetDamagedGFXLevel(Mission.Tennessee, 1)
		DisablePhysics(Mission.Tennessee)
		local x = random(-25,35)
		AddMatrixInterpolator(Mission.Tennessee, {["x"]=0, ["y"]=-5, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(x)}, random(45,65))
	
	--end

end

function luaCaliforniaHit()
	
	--[[if Mission.CaliforniaHits < 3 then
	
		Mission.CaliforniaHits = Mission.CaliforniaHits + 1
	
	else
	
		RemoveListener("hit", "CaliforniaHitListener")]]
		
		luaBlowUp(Mission.California)
		
		local pos = {["x"]=0, ["y"] = Mission.California.Class.Height+3, ["z"]=0 }
		Effect("GiantSmoke", pos, Mission.California, 20)
		
		local randomposX = random(-8,8)
		local randomposY = random(-10,10)
		local pos2 = {["x"]=randomposX, ["y"] = Mission.California.Class.Height+3, ["z"]=randomposY }
		Effect("BigFire", pos2, Mission.California, 20)
		
		SetDamagedGFXLevel(Mission.California, 1)
		DisablePhysics(Mission.California)
		AddMatrixInterpolator(Mission.California, {["x"]=0, ["y"]=-6, ["z"]=0,}, {["x"]=0, ["y"]=0, ["z"]=luaRAD(-35)}, 10)
	
	--end

end

---- MOVIES ----

function luaPlayMovie3()

	PlayBinkMovie("campaigns/BSM/m0104.bik")

end

function luaPlayMovie2()

	PlayBinkMovie("campaigns/BSM/m0103.bik")

end

function luaPlayMovie1()

	PlayBinkMovie("campaigns/BSM/m0102.bik")

end

---- MISSION ENDERS ----

function luaMissionComplete()
	
	Mission.EndMission = true
	
	local sd = Scoring_GetPlayerShotDown()
	
	if sd >= 30 then
	
		luaObj_Completed("hidden",1)
		
	else
	
		luaObj_Failed("hidden",1)
	
	end
	
	if luaObj_IsActive("primary",1) then
		
		luaObj_Completed("primary",1)
	
	end
	
	if luaObj_IsActive("primary",2) then
		
		luaObj_Completed("primary",2)
	
	end
	
	if luaObj_IsActive("primary",3) then
		
		luaObj_Completed("primary",3)
	
	end
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Completed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Completed("primary",5)
	
	end
	
	luaMissionCompletedNew(Mission.Donald, "Donald is heading home - Mission Complete", "campaigns/BSM/m0105.bik")
	
end

function luaMissionFailed(unit)
	
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
	
	if luaObj_IsActive("primary",4) then
		
		luaObj_Failed("primary",4)
	
	end
	
	if luaObj_IsActive("primary",5) then
		
		luaObj_Failed("primary",5)
	
	end
	
	if luaObj_IsActive("secondary",1) then
		
		luaObj_Failed("secondary",1)
	
	end
	
	if luaObj_IsActive("hidden",1) then
		
		luaObj_Failed("hidden",1)
	
	end
	
	luaMissionFailedNew(unit, "Game Over")
	
end

---- SUPPPORT FUNCTIONS ----

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