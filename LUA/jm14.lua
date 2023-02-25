--SceneFile="universe\Scenes\missions\IJN\ijn_14_invasion_of_havaii.scn"

--[[

		USN SHIPS in the mission:

			ATLANTA 1				USS Reno (96)
			ATLANTA 2				USS Flint (97)
			ATLANTA 3				USS Spokane (120)
			SOUTH DAKOTA 1			USS Alabama (60)
			SOUTH DAKOTA 2			USS South Dakota (49)
			SOUTH DAKOTA 3			USS Indiana (50)
			FLETCHER 1				USS Harrison (573)
			FLETCHER 2				USS Hazelwood (531)
			FLETCHER 3				USS Sigsbee (502)
			ALLEN M. SUMNER 1		USS CASTLE (720)
			ALLEN M. SUMNER 2		USS WOODROW R. THOMPSON (721)
			IOWA					USS Iowa (4)
			GATO 1					USS Snook
			GATO 2					USS Steelhead
			GATO 3					USS Sawfish
			GATO 4					USS Sunfish


		IJN SHIPS in the mission:

			AKAGI		  Akagi
			YAMATO        Yamato
			TONE		  Chikuma *
			TAKAO 1		  Maya
			TAKAO 2		  Chokai
			FUBUKI 1	  Asagiri*
			FUBUKI 2	  Yugiri*
			FUBUKI 3	  Amagiri*
			FUBUKI 4	  Sagiri*

			AKIZUKI 1	  Akizuki*
			AKIZUKI 2	  Teruzuki*
			SHIMAKAZE 1   Shimakaze


]]

DoFile("Scripts/datatables/Inputs.lua")

function luaEngineMovieInit()
	Music_Control_SetLevel(MUSIC_TENSION)
	EnableMessages(false)
	LoadMessageMap("ijndlg",14)

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
					["message"] = "idlg01b_1",
				},
				{
					["message"] = "idlg01c",
				},
			},
		},
	}

	MissionNarrative("ijn14.date_location")
	SetNumbering(FindEntity("Akagi-class 01"), 1)
	luaDelay(luaJM14EMDlg,8.5)
end

function luaJM14EMDlg()
	StartDialog("Intro_dlg1", Dialogues["Intro"]);
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end
function luaStageInit()
	CreateScript("luaInitJM14")
	Scoring_RealPlayTimeRunning(true)
end

function luaInitJM14(this)
	Mission = this
	Mission.ScriptFile = "Scripts/missions/Ijn/JM14.lua"

	this.Name = "JM14"
	this.HelperLog = false
	this.CustomLog = true
	this.DamageLog = false

	this.Party = SetParty(this, PARTY_JAPANESE)

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.." mission!")

	EnableMessages(true)
	LoadMessageMap("ijndlg",14)

	SetDeviceReloadEnabled(true)

	Mission.MissionPhase = 1
	Mission.FirstRun = true

	Mission.ThinkWait = 0
	Mission.B29Spawns = 0
	Mission.FPSSpawns = 0
	Mission.MaxSpawns = 1 -- tweakable if more FPS needed
	Mission.CountDownTimeLeft = 600
	Mission.AFPhase = 1

	Mission.Difficulty = GetDifficulty()

	if Mission.Difficulty == 0 then
		Mission.EndPhase = 2
	elseif Mission.Difficulty == 1 then
		Mission.EndPhase = 3
	elseif Mission.Difficulty == 2 then
		Mission.EndPhase = 4
	end

	--luaInitJumpinMovies()

	Mission.Yamato = FindEntity("Yamato-class 01")
	--luaLog("YAMATO")
	--luaLog(Mission.Yamato)
	--luaLog("YAMATO END")
	Mission.IJNCarrier = FindEntity("Akagi-class 01")
	Mission.IJNCarrier2 = FindEntity("Kaga-class 01")

	SetSkillLevel(Mission.IJNCarrier, SKILL_MPNORMAL)
	SetSkillLevel(Mission.IJNCarrier2, SKILL_MPNORMAL)

	SetNumbering(FindEntity("Akagi-class 01"), 1)

	Mission.SpawnTable = {16,38,118}
	Mission.DeckRepairPercentage = 0
	Mission.DeckBannTime = 0

	Mission.CheckpointLoadFunctions = {
		[1] = {luaJM14LoadMissionData},
	}

	Mission.CheckpointSaveFunctions = {
		[1] = {luaJM14SaveMissionData,},
	}

	Mission.AFEnts = {
		[1] = {},
	}

	Mission.BayEntrance = FindEntity("BayEntrance")
	Mission.FordIsland = FindEntity("FordIsland")

	Mission.PlayerFleet = {}
		table.insert(Mission.PlayerFleet, FindEntity("Akagi-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Kaga-class 01"))
		--table.insert(Mission.PlayerFleet, FindEntity("Tone-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Takao-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Agano-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Yamato-class 01"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 01"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 02"))
		table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 03"))
		--table.insert(Mission.PlayerFleet, FindEntity("Fubuki-class 04"))

		-- "ingame.shipnames_
	Mission.PlayerFleetNames = {}
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_zuikaku")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_kaga")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_chikuma")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_maya")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_agano")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_yamato")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_asagiri")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_yugiri")
		table.insert(Mission.PlayerFleetNames, "ingame.shipnames_amagiri")
		--table.insert(Mission.PlayerFleetNames, "ingame.shipnames_sagiri")

		JoinFormation(Mission.PlayerFleet[3], Mission.Yamato)
		JoinFormation(Mission.PlayerFleet[4], Mission.Yamato)
		JoinFormation(Mission.PlayerFleet[1], Mission.PlayerFleet[7])
		JoinFormation(Mission.PlayerFleet[2], Mission.PlayerFleet[7])
		JoinFormation(Mission.PlayerFleet[6], Mission.PlayerFleet[7])
		--JoinFormation(Mission.PlayerFleet[8], Mission.PlayerFleet[7])
		--JoinFormation(Mission.PlayerFleet[9], Mission.PlayerFleet[7])

	Mission.BonusUnits = {}
	Mission.Unlockables = {
		["68"] = {"ingame.shipnames_tone","ingame.shipnames_chikuma"},
		["1311"] = {"Prinz Eugen","Seydlitz"},
		["14"] = {"ingame.shipnames_suzutsuki","ingame.shipnames_shimotsuki"},
		["58"] = {"ingame.shipnames_kitakaze","ingame.shipnames_hayakaze"},
		["388"] = {"ingame.shipnames_yashima"},
		["2008"] = {"ingame.shipnames_yamato"},
		["1310"] = {"Bismarck"},
		["391"] = {"ingame.shipnames_abukuma","ingame.shipnames_natori"},
	}


	for idx,unit in pairs(Mission.PlayerFleet) do
		if IsClassChanged(unit.Class.ID) then
			local id = unit.Class.ID
-- RELEASE_LOGOFF  			luaLog("Cserelodik a "..unit.Class.Name)

			for i,names in pairs(Mission.Unlockables) do
				if tostring(id) == i then
-- RELEASE_LOGOFF  					luaLog("UNLOCK GUINAME ALLITAS: "..tostring(id).." "..names[1])
-- RELEASE_LOGOFF  					luaLog("breaking")
					SetGuiName(unit, names[1])
					table.remove(names, 1)
					break
				else
-- RELEASE_LOGOFF  					luaLog("or else, unknown unlock...")
					SetGuiName(unit, unit.Class.Name)
					--break
				end
			end
		else
			SetGuiName(unit, Mission.PlayerFleetNames[idx])
		end
	end

	SetShipSpeed(Mission.Yamato, 10)

	Mission.Blocade = {}
		table.insert(Mission.Blocade, FindEntity("Atlanta-class 01"))
		table.insert(Mission.Blocade, FindEntity("Atlanta-class 02"))
		--table.insert(Mission.Blocade, FindEntity("Atlanta-class 03"))
		table.insert(Mission.Blocade, FindEntity("South Dakota Class 01"))
		table.insert(Mission.Blocade, FindEntity("South Dakota Class 02"))
		--table.insert(Mission.Blocade, FindEntity("South Dakota Class 03"))
		table.insert(Mission.Blocade, FindEntity("Fletcher-class 01"))
		table.insert(Mission.Blocade, FindEntity("Fletcher-class 02"))
		--table.insert(Mission.Blocade, FindEntity("Fletcher-class 03"))
		table.insert(Mission.Blocade, FindEntity("Allen M. Sumner-class 01"))
		table.insert(Mission.Blocade, FindEntity("Allen M. Sumner-class 02"))

	Mission.BlocadeNames = {}
		table.insert(Mission.BlocadeNames, "ingame.shipnames_reno")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_flint")
		--table.insert(Mission.BlocadeNames, "ingame.shipnames_spokane")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_alabama")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_south_dakota")
		--table.insert(Mission.BlocadeNames, "ingame.shipnames_indiana")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_harrison")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_hazelwood")
		--table.insert(Mission.BlocadeNames, "ingame.shipnames_sigsbee")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_castle")
		table.insert(Mission.BlocadeNames, "ingame.shipnames_woodrow_r_thompson")

	for idx,unit in pairs(Mission.Blocade) do
		NavigatorStop(unit)

		if Mission.Difficulty == 2 then
			SetSkillLevel(unit, SKILL_SPVETERAN)
		else
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
		SetGuiName(unit, Mission.BlocadeNames[idx])

		if unit.Class.Type == "Destroyer" then
			TorpedoEnable(unit, true)
			AAEnable(unit, false)
		end
	end


	Mission.PatrolPaths = {}
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPathEast"))
		table.insert(Mission.PatrolPaths, FindEntity("PatrolPathWest"))

	Mission.Patrols = {}
		table.insert(Mission.Patrols, FindEntity("Patrol 01"))
		table.insert(Mission.Patrols, FindEntity("Patrol 02"))

	Mission.PatrolNames = {}
		table.insert(Mission.PatrolNames, "ingame.shipnames_snook")
		table.insert(Mission.PatrolNames, "ingame.shipnames_steelhead")

	for idx,sub in pairs(Mission.Patrols) do
		SetGuiName(sub, Mission.PatrolNames[idx])
		ShipSetTorpedoStock(sub, (Mission.Difficulty+1)*8)
		SetSubmarineDepthLevel(sub, 1)
		SetUnlimitedAirSupply(sub, true)

		if Mission.Difficulty == 0 then
			SetSkillLevel(sub, SKILL_SPNORMAL)
		elseif Mission.Difficulty == 1 then
			SetSkillLevel(sub, SKILL_SPVETERAN)
		elseif Mission.Difficulty == 2 then
			SetSkillLevel(sub, SKILL_ELITE)
		end

	end

	NavigatorMoveOnPath(Mission.Patrols[1], Mission.PatrolPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
	NavigatorMoveOnPath(Mission.Patrols[2], Mission.PatrolPaths[2], PATH_FM_CIRCLE, PATH_SM_JOIN)

	Mission.DangerZone = {GetPosition(FindEntity("DZ01")), GetPosition(FindEntity("DZ02"))}

	Mission.EttolFuggHogyKuldERepulotAzUSACarrier = FindEntity("South Dakota Class 04")

	Mission.USNFleet = {

		FindEntity("Allen M. Sumner-class 06"),	--shipnames_john_w_weeks
		FindEntity("Allen M. Sumner-class 07"), --shipnames_charles_s_sperry
		FindEntity("Allen M. Sumner-class 08"), --shipnames_english
		FindEntity("Allen M. Sumner-class 09"), --shipnames_harlan_r_dickson
		FindEntity("Allen M. Sumner-class 10"), --shipnames_de_haven
		--FindEntity("Allen M. Sumner-class 04"), --shipnames_drexler
		--FindEntity("Allen M. Sumner-class 05"), --shipnames_strong
		FindEntity("South Dakota Class 04"),	--shipnames_massachusetts
		FindEntity("Allen M. Sumner-class 03"), --shipnames_bristol
		FindEntity("Atlanta-class 04"), --shipnames_san_juan
		--FindEntity("Yorktown-class 01") --shipnames_essex
	}

	Mission.USNFleetNames = {
			{"ingame.shipnames_john_w_weeks",701},
			{"ingame.shipnames_charles_s_sperry",697},
			{"ingame.shipnames_english",696},
			{"ingame.shipnames_harlan_r_dickson",708},
			{"ingame.shipnames_de_haven",727},
			--{"ingame.shipnames_drexler",741},
			--{"ingame.shipnames_strong",758},
			{"ingame.shipnames_massachusetts",59},
			{"ingame.shipnames_bristol",857},
			{"ingame.shipnames_san_juan",54},
			--{"ingame.shipnames_essex",9},
	}

	for i,v in pairs(Mission.USNFleet) do
		if i ~= 6 then
			JoinFormation(v, Mission.USNFleet[6])
		end

		SetGuiName(v, Mission.USNFleetNames[i][1])
		SetNumbering(v, Mission.USNFleetNames[i][2])

		if Mission.Difficulty ~= 0 then
			TorpedoEnable(v, true)
			NavigatorSetTorpedoEvasion(v, true)
			SetSkillLevel(v, SKILL_SPVETERAN)
		else
			TorpedoEnable(v, false)
			NavigatorSetTorpedoEvasion(v, false)
			SetSkillLevel(v, SKILL_SPNORMAL)
		end
	end


	--Mission.USNCarrier = FindEntity("Yorktown-class 01")

	--[[Mission.WolfPacks = {
		["East"] = {},
		["West"] = {},
						}

		table.insert(Mission.WolfPacks.East, FindEntity("Gato-class Submarine 01"))
		--table.insert(Mission.WolfPacks.East, FindEntity("Gato-class Submarine 02"))
		--table.insert(Mission.WolfPacks.East, FindEntity("Gato-class Submarine 03"))

		table.insert(Mission.WolfPacks.West, FindEntity("Gato-class Submarine 04"))
		--table.insert(Mission.WolfPacks.West, FindEntity("Gato-class Submarine 05"))
		--table.insert(Mission.WolfPacks.West, FindEntity("Gato-class Submarine 06"))


	Mission.WolfPackNames = {
		["East"] = {},
		["West"] = {},
							}

		table.insert(Mission.WolfPackNames.East, "ingame.shipnames_sawfish")
		table.insert(Mission.WolfPackNames.West, "ingame.shipnames_sunfish")

	for idx,tbl in pairs(Mission.WolfPacks) do
		for idx2,sub in pairs(tbl) do
			SetGuiName(sub, Mission.WolfPackNames[idx][idx2])
			ShipSetTorpedoStock(sub, (Mission.Difficulty+1)*8)
			SetSubmarineDepthLevel(sub, 4)
			SetUnlimitedAirSupply(sub, true)

			if Mission.Difficulty == 0 then
				SetSkillLevel(sub, SKILL_SPNORMAL)
			elseif Mission.Difficulty == 1 then
				SetSkillLevel(sub, SKILL_SPVETERAN)
			elseif Mission.Difficulty == 2 then
				SetSkillLevel(sub, SKILL_ELITE)
			end
		end
	end]]


	Mission.PlayerPlanes = {}
		--table.insert(Mission.PlayerPlanes, FindEntity("J2M Raiden 01"))
		--table.insert(Mission.PlayerPlanes, FindEntity("J2M Raiden 02"))
		--table.insert(Mission.PlayerPlanes, FindEntity("G4M Betty 01"))
		--table.insert(Mission.PlayerPlanes, FindEntity("G4M Betty 02"))

	Mission.Unlocks12 = {}
		table.insert(Mission.Unlocks12, luaFindHidden("Akizuki-class 01"))
		table.insert(Mission.Unlocks12, luaFindHidden("Akizuki-class 02"))

	Mission.Unlocks12Names = {}
		table.insert(Mission.Unlocks12Names, "ingame.shipnames_akizuki")
		table.insert(Mission.Unlocks12Names, "ingame.shipnames_teruzuki")

	Mission.Unlocks13 = {}
		table.insert(Mission.Unlocks13, luaFindHidden("Shimakaze 01"))
		--table.insert(Mission.Unlocks13, luaFindHidden("Shimakaze 02"))
	--Mission.IowaName = luaFindHidden("Iowa Class 01")

	Mission.Unlocks13Names = {}
		table.insert(Mission.Unlocks13Names, "ingame.shipnames_shimakaze")


	luaJM14Unlock()

	SetSelectedUnit(Mission.Yamato)

	this.Objectives = {
		["primary"] = {
			[1] = {
				["ID"] = "Goto",
				["Text"] = "ijn14.obj_p1",
				["TextCompleted"] = "ijn14.obj_p1_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[2] = {
				["ID"] = "Blocade",
				["Text"] = "ijn14.obj_p2",
				["TextCompleted"] = "ijn14.obj_p2_comp",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
			[3] = {
				["ID"] = "Iowa",
				["Text"] = "ijn14.obj_p3",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_PRIMARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["ID"] = "Time",
				["Text"] = "ijn14.obj_s1",
				["TextCompleted"] = "ijn14.obj_s1_comp",
				["TextFailed"] = "ijn14.obj_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500 * OBJ_SECONDARY_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
			[1] = {
				["ID"] = "Recon",
				["Text"] = "ijn14.obj_h1",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 1000 * OBJ_HIDDEN_MULTIPLIER,
				["ScoreFailed"] = 0
			},
		},
	}

	luaObj_FillSingleScores() 
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	this.Dialogues =

	{

		["Init"] = { --  ijn11 dlg2a-c
			["sequence"] = {
				{
					["message"] = "dlg1a",
				},
				{
					["message"] = "dlg1b",
				},
			},
		},
		["IowaSpotted"] = {
			["sequence"] = {
				{
					["message"] = "dlg2",
				},
			},
		},
		["DeckFailure"] = { --ijn04 dlg14 + intro2 cut
			["sequence"] = {
				{
					["message"] = "dlg3a",
				},
				{
					["message"] = "dlg3b",
				},

			},
		},

		["DeckRepaired"] = { --ijn04 dlg4a-b
			["sequence"] = {
				{
					["message"] = "dlg4a",
				},
				{
					["message"] = "dlg4b",
				},
			},
		},

		["SubDetected"] = {  --ijn06 dlg14
			["sequence"] = {
				{
					["message"] = "dlg5",
				},
			},
		},
		["PlaneSpotted"] = { --ijn04 dlg2a-b
			["sequence"] = {
				{
					["message"] = "dlg6a",
				},
				{
					["message"] = "dlg6b",
				},
			},
		},
		["BlocadeSpotted"] = { --ijn08 dlg03
			["sequence"] = {
				{
					["message"] = "dlg7a",
				},
				{
					["message"] = "dlg7b",
				},
				{
					["message"] = "dlg7b_1",
				},
			},
		},
		["Final"] = {
			["sequence"] = {
				{
					["message"] = "dlg8",
				},
				{
					["message"] = "dlg8_1",
				},
				{
					["message"] = "dlg8_2",
				},
				--{
					--["type"] = "callback",
					--["callback"] = "luaJM14Final",
				--},
			},
		},

	}

	luaCheckMusicSetMinLevel(MUSIC_TENSION)

	luaJM14AddBlocadeListener()
	--luaJM14AddCVHitListener()

	--AddWatch("Mission.BlocadeSpotted")
	--AddWatch("Mission.ReconUp")

	SetSelectedUnit(Mission.Yamato)
	luaJM14FadeIn()
	luaJM14StartDialog("Init")

	SetThink(this, "luaJM14_think")
end

function luaJM14_think(this, msg)
	--luaLog(this.Name.." mission is thinkin' !")

	if luaMessageHandler (this, msg) == "killed" then
		--luaLog(this.Name.." mission is terminated!")
		return
	end

	if Mission.EndMission then
		Scoring_RealPlayTimeRunning(false)
		return
	end

	--luaCheckMusic()

	luaJM14CheckObjectives()

	luaJM14CheckReconPlane()

	luaJM14CheckPatrols()

	luaJM14CheckFirstFleet()
	--luaJM14CheckPlayer()

	--if Mission.DeckBanned then
		--luaJM14DeckRepairProgress(Mission.BannedCV)
	--end

	if Mission.MissionPhase == 1 or Mission.MissionPhase == 2 then
		if Mission.FirstRun then
			Mission.FirstRun = false
			--luaLog("YAMATO 2")
			--luaLog(Mission.Yamato)
			--luaLog("YAMATO 2 END")

			if not Mission.SavedCheckpoint then
				luaJM14StartPlaneHarrassment()
			end
		end

		if Mission.BlocadeSpotted then
			--luaJM14WolfPackHarrass()
			luaJM14BlocadeHarrassment()
		end

		luaJM14CheckPlayer()

	elseif Mission.MissionPhase == 3 then
		luaJM14BlocadeHarrassment()
		luaJM14IowaHarrassment()
		luaJM14CheckPlayer()
	end

end

function luaJM14CheckObjectives()
	if Mission.MissionPhase < 99 then
		if not luaObj_IsActive("primary",1) then
			luaObj_Add("primary",1,GetPosition(Mission.BayEntrance))
		else
			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				if not Mission.PlayerNear then
					Mission.PlayerFleet = luaRemoveDeadsFromTable(Mission.PlayerFleet)

					if table.getn(Mission.PlayerFleet) ~= 0 then
						local unit = luaSortByDistance2(Mission.BayEntrance, Mission.PlayerFleet)[1]
						if unit and not unit.Dead then
							luaJM14DistanceCounter(unit,Mission.BayEntrance,1,"ijn14.obj_p1","ijn14.distance")
						end
					end
				else
					HideScoreDisplay(1,0)
					luaObj_Completed("primary",1,true)
				end
			end
		end

		if not luaObj_IsActive("hidden",1) then
			luaObj_Add("hidden",1)
		else
			if luaObj_IsActive("hidden",1) and luaObj_GetSuccess("hidden",1) == nil then
				if next(luaRemoveDeadsFromTable(recon[PARTY_JAPANESE].enemy.submarine)) then
					luaObj_Failed("hidden",1)
				else
					for idx,ship in pairs(luaRemoveDeadsFromTable(Mission.PlayerFleet)) do
						if GetNumCatapulted(ship) ~= 0 then
							Mission.ReconUp = true
							luaObj_Completed("hidden",1, true)
							if not Mission.HiddenPowerUpAdded then
								luaJM14AddPowerup("improved_shells")
								--luaJM14AddPowerup("DCR1")
								Mission.HiddenPowerUpAdded = true
							end
						end
					end
				end
			end
		end

		if not luaObj_IsActive("primary",2) and Mission.BlocadeSpotted then
			luaObj_Add("primary",2,Mission.Blocade)
		else
			if luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
				if table.getn(luaRemoveDeadsFromTable(Mission.Blocade)) == 0 then
					luaObj_Completed("primary",2,true)
					Blackout(true, "luaJM14Checkpoint1", 1)
				end
			end
		end

		if not luaObj_IsActive("secondary",1) and luaObj_IsActive("primary",2) and luaObj_GetSuccess("primary",2) == nil then
			luaObj_Add("secondary",1)
			Countdown("ijn14.reinf", 0, Mission.CountDownTimeLeft, "luaJM14IowaSpawn")
		else
			if luaObj_IsActive("secondary",1) and luaObj_GetSuccess("secondary",1) == nil then
				Mission.CountDownTimeLeft = CountdownTimeLeft()
				--luaLog("TIME LEFT: "..tostring(timeLeft))
				if table.getn(luaRemoveDeadsFromTable(Mission.Blocade)) == 0 and Mission.CountDownTimeLeft > 0 then
					CountdownCancel()
					luaObj_Completed("secondary",1)
					luaJM14AddPowerup("rocket1")
					Countdown("ijn14.reinf", 0, Mission.CountDownTimeLeft, "luaJM14IowaSpawn")
				elseif Mission.CountDownTimeLeft == 0 and table.getn(luaRemoveDeadsFromTable(Mission.Blocade)) ~= 0 then
					luaObj_Failed("secondary",1)
					CountdownCancel()
					if not Mission.IowaSpawned then
						luaJM14IowaSpawn()
					end
				end
			end
		end

		if not luaObj_IsActive("primary",3) and Mission.IowaSpotted then
			luaObj_Add("primary",3,Mission.Iowa)
			luaJM14AddPowerup("hardened_armour")

			if table.getn(luaRemoveDeadsFromTable(Mission.PlayerFleet)) < 3 then
				luaJM14AddPowerup("targeting_computer")
			end

			DisplayUnitHP({Mission.Iowa}, "ijn14.obj_p3")
		else
			if luaObj_IsActive("primary",3) and luaObj_GetSuccess("primary",3) == nil then
				if not Mission.Iowa or Mission.Iowa.Dead then
					HideUnitHP()
					luaObj_Completed("primary",3,true)
					--luaJM14FinalCam()
					--luaJM14StartDialog("Final")
				end
			end
		end

		if luaObj_GetSuccess("primary",3) and luaObj_GetSuccess("primary",2) --[[and luaObj_GetSuccess("primary",1)]] then
			luaJM14StartDialog("Final")
			luaDelay(luaJM14Final, 18)

			if luaObj_IsActive("primary",1) and luaObj_GetSuccess("primary",1) == nil then
				luaObj_Completed("primary",1)
				HideScoreDisplay(1,0)
			end

		end

	elseif Mission.MissionPhase == 99 then
		if Mission.MissionFailed then
			if GetSelectedUnit() then
				if GetSelectedUnit().LastBanto and not GetSelectedUnit().LastBanto.Dead then
					endEnt = GetSelectedUnit().LastBanto
				else
					endEnt = nil
				end
			else
				endEnt = nil
			end
			luaMissionFailedNew(endEnt, Mission.FailMsg)
			Mission.EndMission = true
		elseif Mission.MissionCompleted then
			luaMissionCompletedNew(nil, "ijn14.obj_missioncompleted", "jp_outro.bik", false, true)
			--luaDelay(luaJM14Outro, 5)
			Mission.EndMission = true
		end
	end


end

function luaJM14Checkpoint1()
	luaCheckpoint(1,nil)
	Blackout(false, "", 1)
end

function luaJM14StartDialog(dialogID, log, ignorePrinted)
	-- dialog indito wrapper
	if type(dialogID) ~= "string" then
		error("***ERROR: luaJM3StartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaJM3StartDialog cannot continue, non existing dialog: "..dialogID, 2)
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

function luaJM14AddPowerup(type)
	AddPowerup({
		["classID"] = type,
		["useLimit"] = 1,
	})

	--MissionNarrativeEnqueue("missionglobals.newpowerup")
end

function luaPrecacheUnits()
	Loading_Start()
		PrepareClass(150)
		PrepareClass(102)
		PrepareClass(159)
		PrepareClass(163)
		PrepareClass(15)
		PrepareClass(16)
		PrepareClass(11)
		PrepareClass(117)
		PrepareClass(38)
		PrepareClass(118)
		PrepareClass(23)
		PrepareClass(14)
		PrepareClass(58)
		PrepareClass(108)
		PrepareClass(45)
	Loading_Finish()
end

function luaJM14StepPhase(phase)
	if phase ~= nil and type(phase) == "number" then
-- RELEASE_LOGOFF  		luaLog("Setting phase to "..tostring(phase))
		Mission.MissionPhase = phase
	else
		Mission.MissionPhase = Mission.MissionPhase + 1
	end
end

function luaJM14RAD(x)
	return math.rad(x)
end

function luaJM14FadeIn()
	luaCheckSavedCheckpoint()
	Scoring_RealPlayTimeRunning(true)
	--SoundFade(1, "",0.5)
	
	if not Mission.SavedCheckpoint then
		Blackout(false, "", 3)
		luaDelay(luaJM14AddInitialPowerups, 6)
	end
end

function luaJM14SetGuiNames()

end

function luaJM14USNSpawn(classID)

		local hdnName = luaFindHidden(tostring(classID))
		local unit = GenerateObject(hdnName.Name, hdnName.Name)

		return unit
end

function luaJM14WolfPackHarrass()

	for idx,wp in pairs(Mission.WolfPacks) do
		for idx2, sub in pairs(luaRemoveDeadsFromTable(wp)) do
			if not luaGetScriptTarget(sub) or luaGetScriptTarget(sub).Dead then

				--[[
				local targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
				else
					targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
				end
				]]

				local targetList
				local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

				if next(tmpTbl["battleship"]) ~= nil then
					targetList = tmpTbl["battleship"]
				elseif next(tmpTbl["mothership"]) then
					targetList = tmpTbl["mothership"]
				elseif next(tmpTbl["cruiser"]) then
					targetList = tmpTbl["cruiser"]
				elseif next(tmpTbl["destroyer"]) then
					targetList = tmpTbl["destroyer"]
				else
					targetList = tmpTbl["allother"]
				end

				local trg = luaPickRnd(targetList)

				if trg and not trg.Dead then
					luaSetScriptTarget(sub, trg)
					NavigatorAttackMove(sub, trg, {})
				end
			end
		end
	end

end

--function luaJM14GetUnits(searchedType,searchedParty)
function luaJM14GetUnits(searchedParty)
	ForceRecon()

	local returnTbl = {
		["mothership"] = {},
		["battleship"] = {},
		["cruiser"] = {},
		["destroyer"] = {},
		["allother"] = {}
	}
	for idx,unitTbl in pairs(luaRemoveDeadsFromTable(recon[searchedParty].own)) do
		for idx2,unit in pairs(unitTbl) do
			if unit and not unit.Dead and luaGetType(unit) == "ship" then
				if unit.Class.Type == "MotherShip" then
					table.insert(returnTbl["mothership"],unit)
				elseif unit.Class.Type == "BattleShip" then
					table.insert(returnTbl["battleship"],unit)
				elseif unit.Class.Type == "Cruiser" then
					table.insert(returnTbl["cruiser"],unit)
				elseif unit.Class.Type == "Destroyer" then
					table.insert(returnTbl["destroyer"],unit)
				else
					table.insert(returnTbl["allother"],unit)
				end
			end
		end
	end
	--[[
	if type(searchedType) == "string" then --and recon[PARTY_JAPANESE].own.searchedType then
		for idx,unit in pairs(recon[searchedParty].own[searchedType]) do
			if not unit.Dead then
				----lualog("Inserting "..unit.Name.." intotargetlist")
				table.insert(returnTbl, unit)
			end
		end
	else
		----lualog("No param or wrong param returning all jap ships")
		for idx,unitTbl in pairs(recon[searchedParty].own) do
			for idx2,unit in pairs(unitTbl) do
				if not unit.Dead and luaGetType(unit) == "ship" then-- or luaGetType(unit) == "sub" then
					----lualog("Inserting "..unit.Name.." intotargetlist")
					table.insert(returnTbl, unit)
				end
			end
		end
	end
	]]
	----lualog("Getunits return tbl")
	----lualog(returnTbl)
	return returnTbl
end

function luaJM14StartPlaneHarrassment()
	Mission.PlaneHarrassment = CreateScript("luaJM14PlaneHarrassment_init")
end

function luaJM14PlaneHarrassment_init(this)
	SetThink(this, "luaJM14PlaneHarrassment_think")
end

function luaJM14PlaneHarrassment_think(this, msg)

	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaLog("planeharrass killed")
		return
	end

	--[[if Mission.PlaneThinkStopped then
		Mission.ThinkWait = Mission.ThinkWait + 1
		return
	end]]

	ForceRecon()

	if Mission.ThinkWait > 100 then  -- tweakable if more FPS needed
		Mission.FPSSpawns = 0
		--Mission.PlaneThinkStopped = false
		Mission.ThinkWait = 0
	else
		Mission.ThinkWait = Mission.ThinkWait + 1
		--return
	
		--SetWait(this, random(5,15))

		SetWait(this, 3)
		
-- RELEASE_LOGOFF  		luaLog("planeharrass fut")

		if Mission.EttolFuggHogyKuldERepulotAzUSACarrier.Dead then

				--[[
				local targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)

				if next(targetList) == nil then
					targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
				else
					targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
				end
				]]

				local targetList
				local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

				if next(tmpTbl["mothership"]) ~= nil then
					targetList = tmpTbl["mothership"]
				elseif next(tmpTbl["battleship"]) then
					targetList = tmpTbl["battleship"]
				elseif next(tmpTbl["cruiser"]) then
					targetList = tmpTbl["cruiser"]
				elseif next(tmpTbl["destroyer"]) then
					targetList = tmpTbl["destroyer"]
				else
					targetList = tmpTbl["allother"]
				end

				local trg = luaPickRnd(targetList)
				local squadrons = {}

				if not Mission.SecondHarrassmentPhase then
					if Mission.B29Spawns < 1 then
						squadron = luaJM14USNSpawn(117)
						squadron2 = luaJM14USNSpawn(11701)

						--squadron = luaSumTablesIndex(squadron1, squadron2)

						SetSkillLevel(squadron,SKILL_SPNORMAL)
						SetSkillLevel(squadron2,SKILL_SPNORMAL)

						--luaLog(squadron.Name)
						Mission.B29Spawns = Mission.B29Spawns + 1
					else
						Mission.PlaneThinkStopped = true
						Mission.SecondHarrassmentPhase = true
					end
				else
					if Mission.FPSSpawns < Mission.MaxSpawns then
-- RELEASE_LOGOFF  						luaLog("spawnolok repcsit")
						--local idx = random(1,table.getn(Mission.SpawnTable))
-- RELEASE_LOGOFF  						luaLog(idx)
						squadrons[1] = luaJM14USNSpawn(Mission.SpawnTable[1])
						squadrons[2] = luaJM14USNSpawn(Mission.SpawnTable[2])
						squadrons[3] = luaJM14USNSpawn(Mission.SpawnTable[3])

						for i,v in pairs(squadrons) do
							if Mission.Difficulty == 2 then
								SetSkillLevel(v,SKILL_SPVETERAN)
							else
								SetSkillLevel(v,SKILL_SPNORMAL)
							end
						end

						Mission.FPSSpawns = Mission.FPSSpawns + 1
					else
-- RELEASE_LOGOFF  						luaLog("itt megall")
						--Mission.PlaneThinkStopped = true
						--return
					end
				end

			
			if squadron and not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
				--lualog("-------------")
				--lualog(squadron)
				local ammo = GetProperty(squadron, "ammoType")
				if ammo ~= 0 then
					if trg and not trg.Dead then
						luaSetScriptTarget(squadron, trg)
						PilotSetTarget(squadron, trg)
					end

					if not IsListenerActive("recon", "planeSpot") and not Mission.PlaneSpotted then
						if not Mission.SavedCheckpoint then
							luaJM14PlaneSpotListener(squadron)
						end
					end

				else
					PilotRetreat(squadron)
				end
			end

			if squadron2 and not squadron2.Dead and (luaGetScriptTarget(squadron2) == nil or luaGetScriptTarget(squadron2).Dead) then
				--lualog("-------------")
				--lualog(squadron)
				local ammo = GetProperty(squadron2, "ammoType")
				if ammo ~= 0 then
					if trg and not trg.Dead then
						luaSetScriptTarget(squadron2, trg)
						PilotSetTarget(squadron2, trg)
					end

					if not IsListenerActive("recon", "planeSpot") and not Mission.PlaneSpotted then
						if not Mission.SavedCheckpoint then
							luaJM14PlaneSpotListener(squadron2)
						end
					end

				else
					PilotRetreat(squadron2)
				end
			end
			
			
			for i,sq in pairs(luaRemoveDeadsFromTable(squadrons)) do
				if sq and not sq.Dead and (luaGetScriptTarget(sq) == nil or luaGetScriptTarget(sq).Dead) then
					--lualog("-------------")
					--lualog(squadron)
					local ammo = GetProperty(sq, "ammoType")
					if ammo ~= 0 then
						if trg and not trg.Dead then
							luaSetScriptTarget(sq, trg)
							PilotSetTarget(sq, trg)
						end

						if not IsListenerActive("recon", "planeSpot") and not Mission.PlaneSpotted then
							if not Mission.SavedCheckpoint then
								luaJM14PlaneSpotListener(sq)
							end
						end

					else
						PilotRetreat(sq)
					end
				end
			end

		end
	end
end

function luaJM14CarrierHarrassment()
	if not Mission.EttolFuggHogyKuldERepulotAzUSACarrier.Dead then
		return
	end

	if Mission.USNCarrier and not Mission.USNCarrier.Dead then
		--local fighterClassIDs = {102}

		local otherClassIDs
		local equipments

		if Mission.Difficulty == 0 then
			otherClassIDs = {102}
			equipments = {1}
		elseif Mission.Difficulty == 1 then
			otherClassIDs = {16,102}
			equipments = {1,1}
		elseif Mission.Difficulty == 2 then
			otherClassIDs = {16,102,108}
			equipments = {1,1,1}
		end

		--luaCapManager(Mission.USNCarrier, fighterClassIDs, 1)

		--luaLog(errorLvl)
		if Mission.AFPhase == Mission.EndPhase then
			if table.getn(luaRemoveDeadsFromTable(Mission.AFEnts[1])) == 0 then
				Mission.AFPhase = 1
			else

				--[[
				local targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
				end
				if next(targetList) == nil then
					targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
				else
					targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
				end

				if not targetList or table.getn(luaRemoveDeadsFromTable(targetList)) == 0 then
					return
				end
				]]

				local targetList
				local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

				if next(tmpTbl["mothership"]) ~= nil then
					targetList = tmpTbl["mothership"]
				elseif next(tmpTbl["battleship"]) then
					targetList = tmpTbl["battleship"]
				elseif next(tmpTbl["cruiser"]) then
					targetList = tmpTbl["cruiser"]
				elseif next(tmpTbl["destroyer"]) then
					targetList = tmpTbl["destroyer"]
				else
					targetList = tmpTbl["allother"]
				end

				local trg = luaPickRnd(targetList)
				for idx2,squadron in pairs(Mission.AFEnts[1]) do
					if not squadron.Dead and (luaGetScriptTarget(squadron) == nil or luaGetScriptTarget(squadron).Dead) then
						--lualog("-------------")
						--lualog(squadron)
						--local ammo = GetProperty(squadron, "ammoType")
						--if ammo ~= 0 then
							luaSetScriptTarget(squadron, trg)
							PilotSetTarget(squadron, trg)
						--end
					end
				end
			end
		elseif Mission.AFPhase < Mission.EndPhase then
			Mission.AFPhase, Mission.AFEnts[1], errorLvl = luaLaunchAirstrike(Mission.AFPhase, Mission.EndPhase, {Mission.USNCarrier}, otherClassIDs, Mission.AFEnts[1], equipments)
		end
	end
end

function luaJM14AddBlocadeListener()
	Mission.Blocade = luaRemoveDeadsFromTable(Mission.Blocade)
	
	AddListener("recon", "blocadeListener", {
		["callback"] = "luaJM14BlocadeSpotted",  -- callback fuggveny
		["entity"] = Mission.Blocade, -- entityk akiken a listener aktiv
		["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2: identified
		["newLevel"] = {1,2}, -- 0: undetected, 1: detected, 2: identified
        ["party"] = { PARTY_JAPANESE },
	})
end

function luaJM14BlocadeSpotted()
-- RELEASE_LOGOFF  	luaLog("blocade spotted")
	RemoveListener("recon", "blocadeListener")
	Mission.BlocadeSpotted = true
	--DeleteScript(Mission.PlaneHarrassment)
	--luaDelay(luaJM14DelayedPlaneStop, 60)
	luaJM14StartDialog("BlocadeSpotted")
	--luaJM14RetreatAllPlanes()
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.Blocade[1].ID)
	luaJM14IngameMovie(Mission.Blocade[1])
-- RELEASE_LOGOFF  	luaLog("planescript deleted")
	luaJM14StepPhase()
end

function luaJM14DelayedPlaneStop()
	if Mission.PlaneHarrassment and not Mission.PlaneHarrassment.Dead then
		DeleteScript(Mission.PlaneHarrassment)
	end
end


function luaJM14DistanceCounter(unit, trg, id, obj, txt)
	if unit and trg and not unit.Dead and not trg.Dead then
		local dist = luaJM14Metric(luaGetDistance3D(unit, trg))
		Mission.Measure = GetMeasure()
		Mission.Distance = string.format("%.1f",dist)
		DisplayScores(id,0,obj,txt)

		if dist < luaJM14Metric(1500) then
			Mission.PlayerNear = true
		end
	end
end

function luaJM14Metric(dist)
	local mes = GetMeasure()

	if mes == "globals.mile" then
		return dist / 1852
	elseif mes == "globals.kilometer" then
		return dist / 1000
	end
end

function luaJM14AddCVHitListener()
	local nmiPlanes = luaGetOwnUnits("plane", PARTY_ALLIED)

	AddListener("hit", "cvHitListener", {
			["callback"] = "luaJM14CVHit", -- callback fuggveny
			["target"] = Mission.PlayerFleet, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = nmiPlanes, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
	})
end

function luaJM14CVHit(...)
-- RELEASE_LOGOFF  	luaLog("hit listener ugrik")
	--luaLog(arg)
-- RELEASE_LOGOFF  	luaLog("hit listener vege")

	if arg[1].Class.Type == "MotherShip" then
		if random(1,100) < 5 then
			RemoveListener("hit", "cvHitListener")
			luaJM14StartDialog("DeckFailure")
			SupportManagerEnable(arg[1], false)
			Mission.BannedCV = arg[1]
			Mission.DeckBanned = true
			--luaJM14DeckRepairProgress()
			--Countdown("ijn14.repairtime", 0, 180, "luaJM14DeckRepaired")
-- RELEASE_LOGOFF  			luaLog("support manager banned")
		end
	end
end

function luaJM14DeckRepairProgress(cv)
	if cv and not cv.Dead then
		if Mission.DeckBannTime < 200 then
			--DisplayScores(66,0,"ijn14.repair","ijn14.percentage")
			if math.mod(Mission.DeckBannTime, 30) == 0 then
				MissionNarrativeUrgent("ijn14.repair")
			end

			Mission.DeckBannTime = Mission.DeckBannTime + 3
			Mission.DeckRepairPercentage = math.floor(Mission.DeckBannTime / 2)
		else
			Mission.DeckBanned = false
			Mission.DeckBannTime = 0
			Mission.DeckRepairPercentage = 0
			luaJM14DeckRepaired(cv)
		end
	else
		--HideScoreDisplay(66,0)
	end
end

function luaJM14RetreatAllPlanes()
	local planes = luaGetOwnUnits("plane", PARTY_ALLIED)

	for idx,plane in pairs(planes) do
		if GetPlaneIsReloading(plane) then
			PilotMoveTo(plane, Mission.FordIsland)
		end
	end
end

function luaJM14DeckRepaired(cv)
	luaJM14StartDialog("DeckRepaired")
	SupportManagerEnable(cv, true)
	HideScoreDisplay(66,0)
	if not IsListenerActive("hit", "cvHitListener") then
		luaJM14AddCVHitListener()
	end
end

function luaJM14CheckReconPlane()
	if Mission.ReconUp then
		--for idx,wp in pairs(Mission.WolfPacks) do
			for idx2,sub in pairs(luaRemoveDeadsFromTable(Mission.Patrols)) do
				local recon = luaGetPlanesAroundCoordinate(GetPosition(sub), 2000, PARTY_ALLIED, "enemy", nil, "reconplane",nil)

				if recon and not recon.Dead and not Mission.SubReconned then
					luaJM14StartDialog("SubDetected")
					--luaJumpinMovieSetCurrentMovie("GoAround",sub.ID)
					luaJM14IngameMovie(sub)
					SetForcedReconLevel(sub, 2, 1)
					Mission.SubReconned = true
				else
					ClearForcedReconLevel(sub, 1)
				end
			end
		--end
	end
end

function luaJM14BlocadeHarrassment()
-- RELEASE_LOGOFF  	luaLog("blocadeharrassment fut")
	for idx, ship in pairs(luaRemoveDeadsFromTable(Mission.Blocade)) do
		if not luaGetScriptTarget(ship) or luaGetScriptTarget(ship).Dead then

			--[[
			local targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)
			end
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
			end
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
			else
				targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
			end
			]]

			local targetList
			local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

			if next(tmpTbl["mothership"]) ~= nil then
				targetList = tmpTbl["mothership"]
			elseif next(tmpTbl["battleship"]) then
				targetList = tmpTbl["battleship"]
			elseif next(tmpTbl["cruiser"]) then
				targetList = tmpTbl["cruiser"]
			elseif next(tmpTbl["destroyer"]) then
				targetList = tmpTbl["destroyer"]
			else
				targetList = tmpTbl["allother"]
			end

			local trg = luaPickRnd(targetList)
			if trg and not trg.Dead then
				luaSetScriptTarget(ship, trg)
				NavigatorAttackMove(ship, trg, {})
			end
		end
	end
end

function luaJM14IowaSpawn()
	Mission.IowaSpawned = true
	luaJM14StepPhase()
	Mission.Iowa = luaJM14USNSpawn(15)
	local esc1 = luaJM14USNSpawn(11)
	local esc2 = luaJM14USNSpawn(1101)
	local esc3 = luaJM14USNSpawn(1102)

	Mission.IowaEscorts = {}
		table.insert(Mission.IowaEscorts, esc1)
		table.insert(Mission.IowaEscorts, esc2)
		table.insert(Mission.IowaEscorts, esc3)

	for i,v in pairs(Mission.IowaEscorts) do
		AAEnable(v, true)
		NavigatorSetTorpedoEvasion(v,true)
		TorpedoEnable(v, true)
		JoinFormation(v, Mission.Iowa)
	end

	SetGuiName(Mission.Iowa, "ingame.shipnames_iowa")
	SetGuiName(esc1, "ingame.shipnames_moale")
	SetGuiName(esc2, "ingame.shipnames_ingraham")
	SetGuiName(esc3, "ingame.shipnames_hank")

	AAEnable(Mission.Iowa, true)

	if Mission.Difficulty == 2 then
		SetSkillLevel(Mission.Iowa, SKILL_ELITE)
		NavigatorSetTorpedoEvasion(Mission.Iowa, true)
	else
		SetSkillLevel(Mission.Iowa, SKILL_SPNORMAL)
		NavigatorSetTorpedoEvasion(Mission.Iowa, false)
	end

	--SetInvincible(Mission.Iowa, 0.001)
	UnitSetFireStance(Mission.Iowa, 2)

	NavigatorMoveToPos(Mission.Iowa,GetPosition(Mission.BayEntrance))
	--luaJumpinMovieSetCurrentMovie("GoAround",Mission.Iowa.ID)
	luaJM14IngameMovie(Mission.Iowa)
	Mission.IowaSpotted = true
end

function luaJM14IowaHarrassment()
	if Mission.Iowa and not Mission.Iowa.Dead then
		if not luaGetScriptTarget(Mission.Iowa) or luaGetScriptTarget(Mission.Iowa).Dead then
			local nearestNMI = luaGetNearestEnemy(Mission.Iowa)
			if nearestNMI and not nearestNMI.Dead then
				NavigatorAttackMove(Mission.Iowa, nearestNMI, {})
			end
		end
	end
end

function luaJM14FinalCam()
	--luaJM14StartDialog("Final")
	--luaCamOnTargetFree(Mission.Iowa, 20, 65, 250, false, "noupdate", 0, nil)

	local trg

	if not TrulyDead(Mission.Iowa) then
		trg = Mission.Iowa
	elseif GetSelectedUnit() and not GetSelectedUnit().Dead then
		trg = GetSelectedUnit()
	else
		return
	end


	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 250, ["theta"] = 20, ["rho"] = 65, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = trg, ["distance"] = 250, ["theta"] = 20, ["rho"] = 65, ["moveTime"] = 10},
		}, luaJM14Final, true )

	--SetInvincible(Mission.Iowa, false)
	--AddDamage(Mission.Iowa, 99999)
end

function luaJM14Final()
	luaJM14StepPhase(99)
	Mission.MissionCompleted = true
	--Mission.EndMission = true
end


function luaJM14Unlock()
	if Scoring_IsUnlocked("JM12_GOLD") then
		for idx,hdnName in pairs(Mission.Unlocks12) do
			local unit = GenerateObject(hdnName.Name, hdnName.Name)
			JoinFormation(unit, Mission.Yamato)
			table.insert(Mission.PlayerFleet, unit)
			SetGuiName(unit, Mission.Unlocks12Names[idx])
		end
	end

	if Scoring_IsUnlocked("JM13_GOLD") then
		for idx,hdnName in pairs(Mission.Unlocks13) do
			local unit = GenerateObject(hdnName.Name, hdnName.Name)
			JoinFormation(unit, Mission.Yamato)
			table.insert(Mission.PlayerFleet, unit)
			SetGuiName(unit, Mission.Unlocks13Names[idx])
		end
	end
end

function luaJM14PatrolHarrass()
	for idx, sub in pairs(luaRemoveDeadsFromTable(Mission.Patrols)) do
		if not luaGetScriptTarget(sub) or luaGetScriptTarget(sub).Dead then

			--[[
			local targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)
			end
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
			end
			if next(targetList) == nil then
				targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
			else
				targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
			end
			]]

			local targetList
			local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

			if next(tmpTbl["mothership"]) ~= nil then
				targetList = tmpTbl["mothership"]
			elseif next(tmpTbl["battleship"]) then
				targetList = tmpTbl["battleship"]
			elseif next(tmpTbl["cruiser"]) then
				targetList = tmpTbl["cruiser"]
			elseif next(tmpTbl["destroyer"]) then
				targetList = tmpTbl["destroyer"]
			else
				targetList = tmpTbl["allother"]
			end

			if not targetList then
				local nearestpath = luaSortByDistance2(sub, Mission.PatrolPaths)[1]
				NavigatorMoveOnPath(sub, nearestpath, PATH_FM_CIRCLE, PATH_SM_JOIN)
			else
				local trg = luaPickRnd(targetList)

				if trg and not trg.Dead then
					luaSetScriptTarget(sub, trg)
					NavigatorAttackMove(sub, trg, {})
				end
			end
		end
	end
end

function luaJM14CheckPatrols()
	Mission.PlayerFleet = luaRemoveDeadsFromTable(Mission.PlayerFleet)

	if table.getn(Mission.PlayerFleet) ~= 0 then
		local nearest = luaSortByDistance2(Mission.BayEntrance, Mission.PlayerFleet)[1]

		if nearest and not nearest.Dead then
			if luaIsInArea(Mission.DangerZone, GetPosition(nearest)) then
				luaJM14PatrolHarrass()
			end
		end
	end
end

function luaJM14CheckPlayer()
	--[[local units = luaGetOwnUnits()
-- RELEASE_LOGOFF  	luaLog("unitok")
-- RELEASE_LOGOFF  	luaLog(units)
-- RELEASE_LOGOFF  	luaLog(tostring(table.getn(units)))
-- RELEASE_LOGOFF  	luaLog("-----------------------")]]--

	if table.getn(luaRemoveDeadsFromTable(Mission.PlayerFleet)) == 0 then
		Mission.MissionFailed = true
		--luaLog("itt failelek, de miert?")
		Mission.FailMsg = "ijn14.obj_missionfailed_pu"
		luaJM14StepPhase(99)
	end
end

function luaJM14PlaneSpotListener(squadron)
	if squadron and not squadron.Dead then
		AddListener("recon", "planeSpot", {
			["callback"] = "luaJM14PlaneSpotted",  -- callback fuggveny
			["entity"] = {squadron}, -- entityk akiken a listener aktiv
			["oldLevel"] = {0}, -- 0: undetected, 1: detected, 2: identified
			["newLevel"] = {1}, -- 0: undetected, 1: detected, 2: identified
	        ["party"] = { PARTY_JAPANESE },
			})
	end
end

function luaJM14PlaneSpotted(plane)
-- RELEASE_LOGOFF  	luaLog("plane spotted")
	RemoveListener("recon", "planeSpot")
	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end


	luaJM14StartDialog("PlaneSpotted")
	Mission.PlaneSpotted = true

		luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = plane, ["distance"] = 100, ["theta"] = 10, ["rho"] = 179, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = plane, ["distance"] = 300, ["theta"] = 10, ["rho"] = 179, ["moveTime"] = 5},
		},	luaJM14PlaneCamEnd )


end


function luaJM14PlaneCamEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		if IsInvincible(Mission.SelectedUnit) then
			SetInvincible(Mission.SelectedUnit, false)
		end
		SetSelectedUnit(Mission.SelectedUnit)
	else
		Mission.PlayerFleet = luaRemoveDeadsFromTable(Mission.PlayerFleet)
		if Mission.PlayerFleet[1] and not Mission.PlayerFleet[1].Dead then
			if not Mission.EndMission then
				SetSelectedUnit(Mission.PlayerFleet[1])
			end
		end
	end

	EnableInput(true)
end

function luaJM14IngameMovie(target)
	Mission.SelectedUnit = GetSelectedUnit()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, true)
	end
	luaIngameMovie(
		{
		   {["postype"] = "cameraandtarget", ["target"] = target, ["distance"] = 500, ["theta"] = 5, ["rho"] = 15, ["moveTime"] = 0},
		   {["postype"] = "cameraandtarget", ["target"] = target, ["distance"] = 200, ["theta"] = 5, ["rho"] = 355, ["moveTime"] = 8},
		},	luaJM14IngameMovieEnd )
end

function luaJM14IngameMovieEnd()
	if Mission.SelectedUnit and not Mission.SelectedUnit.Dead then
		SetInvincible(Mission.SelectedUnit, false)

		if not Mission.EndMission then
			SetSelectedUnit(Mission.SelectedUnit)
		end
	elseif Mission.Yamato and not Mission.Yamato.Dead then
		if not Mission.EndMission then
			SetSelectedUnit(Mission.Yamato)
		end
	else
		Mission.PlayerFleet = luaRemoveDeadsFromTable(Mission.PlayerFleet)
		if Mission.PlayerFleet[1] and not Mission.PlayerFleet[1].Dead then
			if not Mission.EndMission then
				SetSelectedUnit(Mission.PlayerFleet[1])
			end
		end
	end


	EnableInput(true)
end

function luaJM14SaveMissionData()
	luaRegisterCheckpointData("Dialogues", "DialogTbl", Mission.Dialogues)

	Mission.Checkpoint.BlocadeSpotted = Mission.BlocadeSpotted
	Mission.Checkpoint.CountDownTimeLeft = CountdownTimeLeft()

	Mission.FormationTable = {}
	
	for i,v in pairs(luaRemoveDeadsFromTable(Mission.PlayerFleet)) do
		local entTbl = {}

		entTbl.Name = v.Name
		entTbl.Pos = GetPosition(v)
		if IsInFormation(v) then
			entTbl.InFormation = true
			entTbl.Leader = GetFormationLeader(v).Name
			entTbl.LeaderPos = GetPosition(GetFormationLeader(v))
		end
		
		table.insert(Mission.FormationTable, entTbl)
	end
	
	Mission.Checkpoint.FormationTable = Mission.FormationTable
	--luaRegisterCheckpointData("FormationTable", Mission.FormationTable)
	
end

function luaJM14LoadMissionData()
	Blackout(true, "", 0)
	local num = luaGetCheckpointData("CheckPoint", "Num", chckNum)[1]

	Mission.Dialogues = Mission.Checkpoint.Dialogues.DialogTbl[1]
	Mission.BlocadeSpotted = Mission.Checkpoint.BlocadeSpotted
	Mission.CountDownTimeLeft = Mission.Checkpoint.CountDownTimeLeft

	if Mission.CountDownTimeLeft ~= 0 then
		Countdown("ijn14.reinf", 0, Mission.CountDownTimeLeft, "luaJM14IowaSpawn")

		if Mission.CountDownTimeLeft > 360 then
			luaJM14StartPlaneHarrassment()
		end
	else
		luaJM14IowaSpawn()
	end

	local ijn = luaGetCheckpointData("Units", "JapUnits")
	local usn = luaGetCheckpointData("Units", "USUnits")


	local ijnnow = luaGetOwnUnits(nil, PARTY_JAPANESE)
	local usnnow = luaGetOwnUnits(nil, PARTY_ALLIED)


	for idx,unit in pairs(usnnow) do
		local found = false
		for idx2,unitTbl in pairs(usn[1]) do
			if unit.Name == unitTbl[1] then
				--luaLog(Mission.ChckLogPrefix.."Found unit "..unit.Name)
				if unitTbl[4] and unitTbl[4] >= 0 then
					--luaLog(Mission.ChckLogPrefix.."Setting torp stock to "..unitTbl[4])
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
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

	for idx,unit in pairs(ijnnow) do
		local found = false
		for idx2,unitTbl in pairs(ijn[1]) do
			if unit.Name == unitTbl[1] then
				if unitTbl[4] and unitTbl[4] >= 0 then
					ShipSetTorpedoStock(unit, unitTbl[4])
				end
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

	luaObj_AddUnit("primary",1,GetPosition(Mission.BayEntrance))
		
	
	luaDelay(luaJM14DisbandMindenki, 1)

end

function luaJM14DisbandMindenki()
	for i,v in pairs(Mission.Checkpoint.Units.JapUnits[1]) do
		if IsInFormation(FindEntity(v[1])) then
			LeaveFormation(FindEntity(v[1]))
		end
	end
	
	luaDelay(luaJM14MegegyDelayeltFostartaly, 1)
	
end

function luaJM14MegegyDelayeltFostartaly()
	for i,tbl in pairs(Mission.Checkpoint.FormationTable) do
		if not tbl.InFormation then
			local ent = FindEntity(tbl.Name)
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, tbl.Pos)
				ent.Put = true
			end
		else
			JoinFormation(FindEntity(tbl.Name), FindEntity(tbl.Leader))
		end
	end

	luaDelay(luaJM14ArrabbBaszo, 1)
end

function luaJM14ArrabbBaszo()
	for i,tbl in pairs(Mission.Checkpoint.FormationTable) do
		if tbl.Leader then
			local ldr = FindEntity(tbl.Leader)
			if ldr and not ldr.Dead and not ldr.Put then
				PutTo(ldr, tbl.Pos)
				ldr.Put = true
			end
		end
	end

	for i,v in pairs(Mission.Checkpoint.Units.USUnits[1]) do
		if v[5] then
			local ent = FindEntity(v[5])
			if ent and not ent.Dead and not ent.Put then
				PutTo(ent, v[6])
				ent.Put = true
			end
		end
	end
	
	Blackout(false, "", 3)
	--luaDelay(luaJM14BlackoutVege, 2)
end

function luaJM14AddInitialPowerups()
	luaJM14AddPowerup("improved_ship_manoeuvreability")

	--NavigatorMoveToRange(GetFormationLeader(Mission.USNFleet["First"][1]), Mission.BayEntrance)
	--NavigatorMoveToRange(GetFormationLeader(Mission.USNFleet["Second"][1]), Mission.BayEntrance)
	--NavigatorMoveToRange(GetFormationLeader(Mission.USNFleet["Third"][1]), Mission.BayEntrance)

end

function luaJM14CheckFirstFleet_old()
	Mission.USNFleet["First"] = luaRemoveDeadsFromTable(Mission.USNFleet["First"])
	Mission.USNFleet["Second"] = luaRemoveDeadsFromTable(Mission.USNFleet["Second"])
	Mission.USNFleet["Third"] = luaRemoveDeadsFromTable(Mission.USNFleet["Third"])

	if table.getn(Mission.USNFleet["First"]) == 0 and table.getn(Mission.USNFleet["Second"]) == 0 and table.getn(Mission.USNFleet["Third"]) == 0 then
		return
	end

	local trg
	local trgTbl = luaRemoveDeadsFromTable(luaSumTablesIndex({Mission.Yamato}, {Mission.IJNCarrier}, {Mission.IJNCarrier2}))

	if not trgTbl then
		trgTbl = luaRemoveDeadsFromTable(Mission.PlayerFleet)
	end

	trg = luaPickRnd(trgTbl)

	if table.getn(luaRemoveDeadsFromTable(Mission.USNFleet["First"])) ~= 0 then
		if not Mission.FirstAttack then
			Mission.FirstAttack = true
			NavigatorAttackMove(GetFormationLeader(Mission.USNFleet["First"][1]), trg, {})
		end
	else
		if table.getn(luaRemoveDeadsFromTable(Mission.USNFleet["Second"])) ~= 0 then
			if not Mission.SecondAttack then
				Mission.SecondAttack = true
				NavigatorAttackMove(GetFormationLeader(Mission.USNFleet["Second"][2]), trg, {})
			end
		else
			if not Mission.ThirdAttack then
				Mission.ThirdAttack = true
				NavigatorAttackMove(GetFormationLeader(Mission.USNFleet["Third"][3]), trg, {})
			end
		end
	end
end

function luaJM14CheckFirstFleet()
	Mission.USNFleet = luaRemoveDeadsFromTable(Mission.USNFleet)
	--Mission.USNFleet["Second"] = luaRemoveDeadsFromTable(Mission.USNFleet["Second"])
	--Mission.USNFleet["Third"] = luaRemoveDeadsFromTable(Mission.USNFleet["Third"])

	if table.getn(Mission.USNFleet) == 0 then
		return
	end

	for idx,ship in pairs(Mission.USNFleet) do
		if IsFormationLeader(ship) then
			if ship.Class.Type == "MotherShip" then
				NavigatorMoveToRange(ship, Mission.BayEntrance)
			else
				if not luaGetScriptTarget(ship) or luaGetScriptTarget(ship).Dead then

					--[[
					local targetList = luaJM14GetUnits("battleship",PARTY_JAPANESE)
					if next(targetList) == nil then
						targetList = luaJM14GetUnits("mothership",PARTY_JAPANESE)
					end
					if next(targetList) == nil then
						targetList = luaJM14GetUnits("cruiser",PARTY_JAPANESE)
					end
					if next(targetList) == nil then
						targetList = luaJM14GetUnits("destroyer",PARTY_JAPANESE)
					else
						targetList = luaJM14GetUnits(nil,PARTY_JAPANESE)
					end
					]]

					local targetList
					local tmpTbl = luaJM14GetUnits(PARTY_JAPANESE)

					if next(tmpTbl["battleship"]) ~= nil then
						targetList = tmpTbl["battleship"]
					elseif next(tmpTbl["mothership"]) then
						targetList = tmpTbl["mothership"]
					elseif next(tmpTbl["cruiser"]) then
						targetList = tmpTbl["cruiser"]
					elseif next(tmpTbl["destroyer"]) then
						targetList = tmpTbl["destroyer"]
					else
						targetList = tmpTbl["allother"]
					end

					local trg = luaPickRnd(targetList)

					if trg and not trg.Dead then
						luaSetScriptTarget(ship, trg)
						NavigatorAttackMove(ship, trg, {})
					end
				end
			end
		end
	end

end
