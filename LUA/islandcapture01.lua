-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
--	PrepareClass(102) -- atmeneti hack a "rocket1", amig nem mukodik kodbol
--	PrepareClass(45) -- atmeneti hack a "rocket1", amig nem mukodik kodbol
--[[
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
--]]
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitIslandCapture01")
end

function luaInitIslandCapture01(this)
	Mission = this
	Mission.Name = "IslandCapture01"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating IslandCapture01")
	-- Loc-Kit dolgok
--	AddLockitPathToSelection(this.Name)
--	AddLockitPathToSelection("missionglobals")
--	AddLockitPathToSelection("mm01")
--	LoadSelectedPaths()
	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")
-- mission objectives
--[[
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "mp.obj_ic_pri",				
				["TextCompleted"] = "mp.obj_ic_uswon",
				["TextFailed"] = "mp.obj_ic_jpwon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 2000,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "mp.obj_ic_pri",
				["TextCompleted"] = "mp.obj_ic_jpwon",
				["TextFailed"] = "mp.obj_ic_uswon",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 2000,
				["ScoreFailed"] = 0,
			},
		},
	}
]]

-- Lobby

-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")
		
	Mission.IC1v1 = false
	Mission.IC2v2 = false
	Mission.IC3v3 = false
	Mission.IC4v4 = false
	
	if LobbySettings.GameMode == "globals.gamemode_islandcapture" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.GameMode)
		if LobbySettings.MapSize == "FE.multi_small" then
-- RELEASE_LOGOFF  			luaLog("IC1v1 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 500,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 500,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC1v1 = true
-- RELEASE_LOGOFF  			luaLog("IC1v1 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		elseif LobbySettings.MapSize == "FE.multi_medium" then
-- RELEASE_LOGOFF  			luaLog("IC2v2 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 1000,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 1000,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC2v2 = true
-- RELEASE_LOGOFF  			luaLog("IC2v2 flag is true")
-- RELEASE_LOGOFF  			luaLog("")			
		elseif LobbySettings.MapSize == "FE.multi_large" then
-- RELEASE_LOGOFF  			luaLog("IC3v3 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 2500,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 2500,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC3v3 = true
-- RELEASE_LOGOFF  			luaLog("IC3v3 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		elseif LobbySettings.MapSize == "FE.multi_huge" then
-- RELEASE_LOGOFF  			luaLog("IC4v4 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 5000,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 5000,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC4v4 = true
-- RELEASE_LOGOFF  			luaLog("IC4v4 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		end
	end
	
	if LobbySettings.TimeLimit_IC == "globals.none" then
		--luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.30m" then
		Mission.TimeLimit = 30 * 60
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.1h" then
		Mission.TimeLimit = 60 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.2h" then
		Mission.TimeLimit = 120 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit:"..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.4h" then
		Mission.TimeLimit = 240 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit"..tostring(Mission.TimeLimit))
	end		
	
	if LobbySettings.PointLimit == "globals.none" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 0
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "500" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 500
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))	
	elseif LobbySettings.PointLimit == "1000" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 1000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "2000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 2000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "3000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 3000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "4000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 4000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "5000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 5000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	end
				
	Mission.AlliedCapturePoints = 0000
	Mission.JapaneseCapturePoints = 0000
	Mission.AlliedCBCounter = 0000
	Mission.JapaneseCBCounter = 0000
	Mission.TimeLimitReached = false
	Mission.MissionInit = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0				-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CaptureCounters = false
	Mission.MissionStart = true
	Mission.HintDisplayed = false
-- Mission units
	
	
	if Mission.IC4v4 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 4v4")

		Mission.Shipyards = {}
		
		table.insert(Mission.Shipyards, FindEntity("Shipyard S01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L03 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M03 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S02_01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S04 Entity"))		
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB3"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		table.insert(Mission.CommandBuildings, FindEntity("CB9"))
		table.insert(Mission.CommandBuildings, FindEntity("CB10"))
		table.insert(Mission.CommandBuildings, FindEntity("CB11"))
		table.insert(Mission.CommandBuildings, FindEntity("CB12"))
		table.insert(Mission.CommandBuildings, FindEntity("CB13"))
		

		Mission.CP1 = FindEntity("CP03 H")
		Mission.CP1.CaptureWeight = 2
		Mission.CP1.StrategicGain = 1
		SetGuiName(Mission.CP1, "globals.unitclass_commandpost|".." - |03")
		
		Mission.CP2 = FindEntity("CP04 H")
		Mission.CP2.CaptureWeight = 2
		Mission.CP2.StrategicGain = 1
		SetGuiName(Mission.CP2, "globals.unitclass_commandpost|".." - |04")				
		
		Mission.CP3 = FindEntity("CP06 H")
		Mission.CP3.CaptureWeight = 2
		Mission.CP3.StrategicGain = 1
		SetGuiName(Mission.CP3, "globals.unitclass_commandpost|".." - |06")
		
		Mission.CP4 = FindEntity("CP07 H")
		Mission.CP4.CaptureWeight = 2
		Mission.CP4.StrategicGain = 1
		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |07")				
		
		Mission.CP5 = FindEntity("CP09 H")
		Mission.CP5.CaptureWeight = 2
		Mission.CP5.StrategicGain = 1
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |09")
		
		Mission.CP6 = FindEntity("CP10 H")
		Mission.CP6.CaptureWeight = 2
		Mission.CP6.StrategicGain = 1
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |10")
		
		Mission.CP7 = FindEntity("CP12 H")
		Mission.CP7.CaptureWeight = 2
		Mission.CP7.StrategicGain = 1
		SetGuiName(Mission.CP7, "globals.unitclass_commandpost|".." - |12")
		
		Mission.CP8 = FindEntity("CP16 H")
		Mission.CP8.CaptureWeight = 2
		Mission.CP8.StrategicGain = 1
		SetGuiName(Mission.CP8, "globals.unitclass_commandpost|".." - |16")
		
		Mission.CP9 = FindEntity("CP18 H")
		Mission.CP9.CaptureWeight = 2
		Mission.CP9.StrategicGain = 1		
		SetGuiName(Mission.CP9, "globals.unitclass_commandpost|".." - |18")
		
		Mission.CP10 = FindEntity("CP19 H")
		Mission.CP10.CaptureWeight = 2
		Mission.CP10.StrategicGain = 1
		SetGuiName(Mission.CP10, "globals.unitclass_commandpost|".." - |19")
		
		Mission.CP11 = FindEntity("CP21 H")
		Mission.CP11.CaptureWeight = 2
		Mission.CP11.StrategicGain = 1		
		SetGuiName(Mission.CP11, "globals.unitclass_commandpost|".." - |21")
		
		Mission.CP12 = FindEntity("CP22 H")
		Mission.CP12.CaptureWeight = 2
		Mission.CP12.StrategicGain = 1
		SetGuiName(Mission.CP12, "globals.unitclass_commandpost|".." - |22")
		
		Mission.CP13 = FindEntity("CP24 H")
		Mission.CP13.CaptureWeight = 1
		Mission.CP13.StrategicGain = 2
		SetGuiName(Mission.CP13, "globals.unitclass_commandpost|".." - |24")
		
		Mission.CP14 = FindEntity("CP25 H")
		Mission.CP14.CaptureWeight = 2
		Mission.CP14.StrategicGain = 1
		SetGuiName(Mission.CP14, "globals.unitclass_commandpost|".." - |25")

		Mission.CommandPosts = {}
			table.insert(Mission.CommandPosts, Mission.CP1)
			table.insert(Mission.CommandPosts, Mission.CP2)
			table.insert(Mission.CommandPosts, Mission.CP3)
			table.insert(Mission.CommandPosts, Mission.CP4)
			table.insert(Mission.CommandPosts, Mission.CP5)
			table.insert(Mission.CommandPosts, Mission.CP6)
			table.insert(Mission.CommandPosts, Mission.CP7)
			table.insert(Mission.CommandPosts, Mission.CP8)
			table.insert(Mission.CommandPosts, Mission.CP9)
			table.insert(Mission.CommandPosts, Mission.CP10)
			table.insert(Mission.CommandPosts, Mission.CP11)
			table.insert(Mission.CommandPosts, Mission.CP12)
			table.insert(Mission.CommandPosts, Mission.CP13)
			table.insert(Mission.CommandPosts, Mission.CP14)

		Mission.CB1 = FindEntity("CB1")
		Mission.CB1.CaptureWeight = 1
		Mission.CB1.StrategicGain = 2
		SetGuiName(Mission.CB1, "globals.unitclass_headquarter|".." - |01")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 1 Params")
		Mission.CB2 = FindEntity("CB2")
		Mission.CB2.CaptureWeight = 1
		Mission.CB2.StrategicGain = 2
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |02")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 2 Params")

	
		
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 3 Params")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 4 Params")

		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 1
		Mission.CB5.StrategicGain = 2
		--[[SetCommandBuildingOwnerPlayer(Mission.CB5, PLAYER_5)]]
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |05")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 1
		Mission.CB6.StrategicGain = 2
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |13")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 2
		Mission.CB7.StrategicGain = 4
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |14")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 7 Params")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 1
		Mission.CB8.StrategicGain = 2
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |15")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")
		Mission.CB9 = FindEntity("CB9")
		Mission.CB9.CaptureWeight = 1
		Mission.CB9.StrategicGain = 2
		SetGuiName(Mission.CB9, "globals.unitclass_headquarter|".." - |23")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 9 Params")
		Mission.CB10 = FindEntity("CB10")
		Mission.CB10.CaptureWeight = 1
		Mission.CB10.StrategicGain = 2
		SetCommandBuildingOwnerPlayer(Mission.CB10, PLAYER_5)
		--SetParty(Mission.CB10, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB10,EROLF_ALL,PLAYER_6)
		SetGuiName(Mission.CB10, "globals.unitclass_headquarter|".." - |17")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 10 Params")
		Mission.CB11 = FindEntity("CB11")
		Mission.CB11.CaptureWeight = 1
		Mission.CB11.StrategicGain = 2
		SetCommandBuildingOwnerPlayer(Mission.CB11, PLAYER_1)
		--SetParty(Mission.CB11, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB11,EROLF_ALL,PLAYER_2)
		SetGuiName(Mission.CB11, "globals.unitclass_headquarter|".." - |20")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 11 Params")
		Mission.CB12 = FindEntity("CB12")
		Mission.CB12.CaptureWeight = 1
		Mission.CB12.StrategicGain = 2
		SetGuiName(Mission.CB12, "globals.unitclass_headquarter|".." - |26")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 12 Params")
		Mission.CB13 = FindEntity("CB13")
		Mission.CB13.CaptureWeight = 1
		Mission.CB13.StrategicGain = 2
		SetGuiName(Mission.CB13, "globals.unitclass_headquarter|".." - |27")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 13 Params")
		-- CommandBuildings TODO: SetGuiName (multiban atmegy? (grave))
		-- todo modelltol fuggo a nev
		Mission.Yorktown = FindEntity("IC - Yorktown 01")
		SetParty(Mission.Yorktown, PARTY_ALLIED)
		SetRoleAvailable(Mission.Yorktown,EROLF_ALL,PLAYER_1)
-- RELEASE_LOGOFF  		luaLog("")
		Mission.Lexington = FindEntity("IC - Lexington 01")
		SetParty(Mission.Lexington , PARTY_ALLIED)
		SetRoleAvailable(Mission.Lexington ,EROLF_ALL,PLAYER_1)
-- RELEASE_LOGOFF  		luaLog("")
		Mission.Soryu  = FindEntity("IC - Soryu 01")
		SetParty(Mission.Soryu, PARTY_JAPANESE)
		SetRoleAvailable(Mission.Soryu,EROLF_ALL,PLAYER_5)
-- RELEASE_LOGOFF  		luaLog("")
		Mission.Hiryu = FindEntity("IC - Hiryu 01")
		SetParty(Mission.Hiryu, PARTY_JAPANESE)
		SetRoleAvailable(Mission.Hiryu,EROLF_ALL,PLAYER_5)
-- RELEASE_LOGOFF  		luaLog("")
	end

	if Mission.IC3v3 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 3v3")
		
		Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("Shipyard L02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L03 Entity"))		
		table.insert(Mission.Shipyards, FindEntity("Shipyard S01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M03 Entity"))		
		table.insert(Mission.Shipyards, FindEntity("Shipyard M02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S04 Entity"))
		
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		--table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB2"))
--		table.insert(Mission.CommandBuildings, FindEntity("CB3"))
--		table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		table.insert(Mission.CommandBuildings, FindEntity("CB9"))
		table.insert(Mission.CommandBuildings, FindEntity("CB10"))
		table.insert(Mission.CommandBuildings, FindEntity("CB11"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB12"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB13"))	

		Mission.CP3 = FindEntity("CP06 L")
		SetGuiName(Mission.CP3, "globals.unitclass_commandpost|".." - |02")
		Mission.CP4 = FindEntity("CP07 L")
		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |03")
		Mission.CP5 = FindEntity("CP09 L")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |05")
		Mission.CP6 = FindEntity("CP10 L")
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |06")
		Mission.CP7 = FindEntity("CP12 L")
		SetGuiName(Mission.CP7, "globals.unitclass_commandpost|".." - |08")
		Mission.CP8 = FindEntity("CP16 L")
		SetGuiName(Mission.CP8, "globals.unitclass_commandpost|".." - |12")
		Mission.CP9 = FindEntity("CP18 L")
		SetGuiName(Mission.CP9, "globals.unitclass_commandpost|".." - |14")
		Mission.CP10 = FindEntity("CP19 L")
		SetGuiName(Mission.CP10, "globals.unitclass_commandpost|".." - |15")
		Mission.CP11 = FindEntity("CP21 L")
		SetGuiName(Mission.CP11, "globals.unitclass_commandpost|".." - |17")
		Mission.CP12 = FindEntity("CP22 L")
		SetGuiName(Mission.CP12, "globals.unitclass_commandpost|".." - |18")		
		
		Mission.CP3.CaptureWeight = 0.5
		Mission.CP3.StrategicGain = 1
		Mission.CP4.CaptureWeight = 0.5
		Mission.CP4.StrategicGain = 1
		Mission.CP6.CaptureWeight = 0.5
		Mission.CP6.StrategicGain = 1
		Mission.CP7.CaptureWeight = 0.5
		Mission.CP7.StrategicGain = 1
		Mission.CP8.CaptureWeight = 0.5
		Mission.CP8.StrategicGain = 1
		Mission.CP9.CaptureWeight = 0.5
		Mission.CP9.StrategicGain = 1
		Mission.CP10.CaptureWeight = 0.5
		Mission.CP10.StrategicGain = 1
		Mission.CP11.CaptureWeight = 0.5
		Mission.CP11.StrategicGain = 1
		Mission.CP12.CaptureWeight = 0.5
		Mission.CP12.StrategicGain = 1

		Mission.CommandPosts = {}
			table.insert(Mission.CommandPosts, Mission.CP3)
			table.insert(Mission.CommandPosts, Mission.CP4)
			table.insert(Mission.CommandPosts, Mission.CP5)
			table.insert(Mission.CommandPosts, Mission.CP6)
			table.insert(Mission.CommandPosts, Mission.CP7)
			table.insert(Mission.CommandPosts, Mission.CP8)
			table.insert(Mission.CommandPosts, Mission.CP9)
			table.insert(Mission.CommandPosts, Mission.CP10)
			table.insert(Mission.CommandPosts, Mission.CP11)
			table.insert(Mission.CommandPosts, Mission.CP12)
		
		--Mission.CB1 = FindEntity("CB1")
		--SetGuiName(Mission.CB1, "globals.unitclass_headquarter")
		--Mission.CB2 = FindEntity("CB2")
		--SetGuiName(Mission.CB2, "globals.unitclass_headquarter")
--		Mission.CB3 = FindEntity("CB3")
--		Mission.CB3.CaptureWeight = 2
--		Mission.CB3.StrategicGain = 3
--		SetCommandBuildingOwnerPlayer(Mission.CB3, PLAYER_5)
		--SetParty(Mission.CB3, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB3,EROLF_ALL,PLAYER_5)
--		SetGuiName(Mission.CB3, "globals.unitclass_headquarter|".." - |04")
-- RELEASE_LOGOFF  --		luaLog("Setting Command Building 3 Params")
--		Mission.CB4 = FindEntity("CB4")
--		Mission.CB4.CaptureWeight = 2
--		Mission.CB4.StrategicGain = 3
--		SetCommandBuildingOwnerPlayer(Mission.CB4, PLAYER_1)
		--SetParty(Mission.CB4, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB4,EROLF_ALL,PLAYER_1)
--		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |07")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 4 Params")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 2
		Mission.CB5.StrategicGain = 4
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |01")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 3
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |09")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 3
		Mission.CB7.StrategicGain = 5
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |10")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 7 Params")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 3
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |11")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")
		Mission.CB9 = FindEntity("CB9")
		Mission.CB9.CaptureWeight = 1
		Mission.CB9.StrategicGain = 2
		SetGuiName(Mission.CB9, "globals.unitclass_headquarter|".." - |19")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 9 Params")
		Mission.CB10 = FindEntity("CB10")
		Mission.CB10.CaptureWeight = 2
		Mission.CB10.StrategicGain = 4
		SetCommandBuildingOwnerPlayer(Mission.CB10, PLAYER_5)
		--SetParty(Mission.CB10, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB10,EROLF_ALL,PLAYER_6)
		SetGuiName(Mission.CB10, "globals.unitclass_headquarter|".." - |13")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 10 Params")
		Mission.CB11 = FindEntity("CB11")
		Mission.CB11.CaptureWeight = 1
		Mission.CB11.StrategicGain = 2
		SetCommandBuildingOwnerPlayer(Mission.CB11, PLAYER_1)
		--SetParty(Mission.CB11, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB11,EROLF_ALL,PLAYER_2)
		SetGuiName(Mission.CB11, "globals.unitclass_headquarter|".." - |16")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 11 Params")
		--Mission.CB12 = FindEntity("CB12")
		--SetGuiName(Mission.CB12, "globals.unitclass_headquarter")
		--Mission.CB13 = FindEntity("CB13")
		--SetGuiName(Mission.CB13, "globals.unitclass_headquarter")
		-- CommandBuildings TODO: SetGuiName (multiban atmegy? (grave))
		-- todo modelltol fuggo a nev
		Mission.Yorktown = FindEntity("IC - Yorktown 01")
		SetParty(Mission.Yorktown, PARTY_ALLIED)
		SetRoleAvailable(Mission.Yorktown,EROLF_ALL,PLAYER_1)
-- RELEASE_LOGOFF  		luaLog("")
		--Mission.Lexington = FindEntity("Lexington 01")
		--luaLog("")
		--Mission.Soryu  = FindEntity("Soryu 01")
		--luaLog("")
		Mission.Hiryu = FindEntity("IC - Hiryu 01")
		SetParty(Mission.Hiryu, PARTY_JAPANESE)
		SetRoleAvailable(Mission.Hiryu,EROLF_ALL,PLAYER_5)
-- RELEASE_LOGOFF  		luaLog("")
		
		Mission.USCB = {}
--			table.insert(Mission.USCB, Mission.CB4)
			table.insert(Mission.USCB, Mission.CB11)
			table.insert(Mission.USCB, Mission.Yorktown)
		Mission.JPCB = {}
--			table.insert(Mission.JPCB, Mission.CB3)
			table.insert(Mission.JPCB, Mission.CB10)
			table.insert(Mission.JPCB, Mission.Hiryu)

		
	end	
	
	if Mission.IC2v2 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 2v2")
		
		Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("Shipyard S01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_02 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard M03 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S04 Entity"))
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		--table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB3"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		table.insert(Mission.CommandBuildings, FindEntity("CB9"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB10"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB11"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB12"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB13"))	
		
		Mission.CP3 = FindEntity("CP06 M")
		SetGuiName(Mission.CP3, "globals.unitclass_commandpost|".." - |02")
		Mission.CP4 = FindEntity("CP07 M")
		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |03")
		Mission.CP5 = FindEntity("CP09 M")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |04")
		Mission.CP6 = FindEntity("CP10 M")
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |05")
		Mission.CP9 = FindEntity("CP18 M")
		SetGuiName(Mission.CP9, "globals.unitclass_commandpost|".." - |09")
		Mission.CP10 = FindEntity("CP19 M")
		SetGuiName(Mission.CP10, "globals.unitclass_commandpost|".." - |10")
		Mission.CP11 = FindEntity("CP21 M")
		SetGuiName(Mission.CP11, "globals.unitclass_commandpost|".." - |11")
		Mission.CP12 = FindEntity("CP22 M")
		SetGuiName(Mission.CP12, "globals.unitclass_commandpost|".." - |12")
				
				
				
		Mission.CP3.CaptureWeight = 0.5
		Mission.CP3.StrategicGain = 2
		Mission.CP4.CaptureWeight = 0.5
		Mission.CP4.StrategicGain = 2
		Mission.CP5.CaptureWeight = 0.5
		Mission.CP5.StrategicGain = 2
		Mission.CP6.CaptureWeight = 0.5
		Mission.CP6.StrategicGain = 2
		Mission.CP9.CaptureWeight = 0.5
		Mission.CP9.StrategicGain = 2
		Mission.CP10.CaptureWeight = 0.5
		Mission.CP10.StrategicGain = 2
		Mission.CP11.CaptureWeight = 0.5
		Mission.CP11.StrategicGain = 2
		Mission.CP12.CaptureWeight = 0.5
		Mission.CP12.StrategicGain = 2		

		

		Mission.CommandPosts = {}
			table.insert(Mission.CommandPosts, Mission.CP3)
			table.insert(Mission.CommandPosts, Mission.CP4)
			table.insert(Mission.CommandPosts, Mission.CP5)
			table.insert(Mission.CommandPosts, Mission.CP6)
			table.insert(Mission.CommandPosts, Mission.CP9)
			table.insert(Mission.CommandPosts, Mission.CP10)
			table.insert(Mission.CommandPosts, Mission.CP11)
			table.insert(Mission.CommandPosts, Mission.CP12)
		
		--Mission.CB1 = FindEntity("CB1")
		--SetGuiName(Mission.CB1, "globals.unitclass_headquarter")
		--Mission.CB2 = FindEntity("CB2")
		--SetGuiName(Mission.CB2, "globals.unitclass_headquarter")
		--Mission.CB3 = FindEntity("CB3")
		--SetGuiName(Mission.CB3, "globals.unitclass_headquarter")
		--Mission.CB4 = FindEntity("CB4")
		--SetGuiName(Mission.CB4, "globals.unitclass_headquarter")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 2
		Mission.CB5.StrategicGain = 3
		SetCommandBuildingOwnerPlayer(Mission.CB5, PLAYER_1)
		--SetParty(Mission.CB5, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB5,EROLF_ALL,PLAYER_2)
		Mission.AirfieldCB5 = FindEntity("Multi Airfield CB5")
--		SetParty(Mission.AirfieldCB5, PARTY_ALLIED)
		Mission.HangarCB5 = FindEntity("Multi Hangar CB5")
--		SetParty(Mission.HangarCB5, PARTY_ALLIED)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |01")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 2
		SetCommandBuildingOwnerPlayer(Mission.CB6, PLAYER_5)
		--SetParty(Mission.CB6, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB6,EROLF_ALL,PLAYER_5)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |06")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 3
		Mission.CB7.StrategicGain = 4
		AISetHintWeight(Mission.CB7, 100)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 7 Params")
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |07")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 2
		SetCommandBuildingOwnerPlayer(Mission.CB8, PLAYER_1)
		--SetParty(Mission.CB8, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB8,EROLF_ALL,PLAYER_1)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |08")
		Mission.CB9 = FindEntity("CB9")
		Mission.CB9.CaptureWeight = 2
		Mission.CB9.StrategicGain = 3
		SetCommandBuildingOwnerPlayer(Mission.CB9, PLAYER_5)
		--SetParty(Mission.CB9, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB9,EROLF_ALL,PLAYER_6)
		Mission.AirfieldCB9 = FindEntity("Multi Airfield CB9")
--		SetParty(Mission.AirfieldCB9, PARTY_JAPANESE)
		Mission.HangarCB9 = FindEntity("Multi Hangar CB9")
--		SetParty(Mission.HangarCB9, PARTY_JAPANESE)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 9 Params")
		SetGuiName(Mission.CB9, "globals.unitclass_headquarter|".." - |13")
		--Mission.CB10 = FindEntity("CB10")
		--SetGuiName(Mission.CB10, "globals.unitclass_headquarter")
		--Mission.CB11 = FindEntity("CB11")
		--SetGuiName(Mission.CB11, "globals.unitclass_headquarter")
		--Mission.CB12 = FindEntity("CB12")
		--SetGuiName(Mission.CB12, "globals.unitclass_headquarter")
		--Mission.CB13 = FindEntity("CB13")
		--SetGuiName(Mission.CB13, "globals.unitclass_headquarter")
		-- CommandBuildings TODO: SetGuiName (multiban atmegy? (grave))
		-- todo modelltol fuggo a nev

		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB5)
			table.insert(Mission.USCB, Mission.CB8)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB6)
			table.insert(Mission.JPCB, Mission.CB9)

	
	end
	
	if Mission.IC1v1 == true then
		
		Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard L01 Entity"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard S03_02 Entity"))
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		--table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB3"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB9"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB10"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB11"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB12"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB13"))	
		
		
		Mission.CP5 = FindEntity("CP09 S")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |01")
		Mission.CP6 = FindEntity("CP10 S")
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |02")
		Mission.CP9 = FindEntity("CP18 S")
		SetGuiName(Mission.CP9, "globals.unitclass_commandpost|".." - |06")
		Mission.CP10 = FindEntity("CP19 S")
		SetGuiName(Mission.CP10, "globals.unitclass_commandpost|".." - |07")		
		
		Mission.CP5.CaptureWeight = 0.5
		Mission.CP5.StrategicGain = 2
		Mission.CP6.CaptureWeight = 0.5
		Mission.CP6.StrategicGain = 2		
		Mission.CP9.CaptureWeight = 0.5
		Mission.CP9.StrategicGain = 2
		Mission.CP10.CaptureWeight = 0.5
		Mission.CP10.StrategicGain = 2		

		Mission.CommandPosts = {}
			table.insert(Mission.CommandPosts, Mission.CP5)
			table.insert(Mission.CommandPosts, Mission.CP6)
			table.insert(Mission.CommandPosts, Mission.CP9)
			table.insert(Mission.CommandPosts, Mission.CP10)
			table.insert(Mission.CommandPosts, Mission.CP11)
		
		--Mission.CB1 = FindEntity("CB1")
		--SetGuiName(Mission.CB1, "globals.unitclass_headquarter")
		--Mission.CB2 = FindEntity("CB2")
		--SetGuiName(Mission.CB2, "globals.unitclass_headquarter")
		--Mission.CB3 = FindEntity("CB3")
		--SetGuiName(Mission.CB3, "globals.unitclass_headquarter")
		--Mission.CB4 = FindEntity("CB4")
		--SetGuiName(Mission.CB4, "globals.unitclass_headquarter")
		--Mission.CB5 = FindEntity("CB5")
		--SetGuiName(Mission.CB5, "globals.unitclass_headquarter")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 3
		SetCommandBuildingOwnerPlayer(Mission.CB6, PLAYER_5)
		--SetParty(Mission.CB6, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB6,EROLF_ALL,PLAYER_5)
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |03")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 3
		Mission.CB7.StrategicGain = 4
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |04")
-- RELEASE_LOGOFF  		luaLog("")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 3
		SetCommandBuildingOwnerPlayer(Mission.CB8, PLAYER_1)
		--SetParty(Mission.CB8, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB8,EROLF_ALL,PLAYER_1)
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |05")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")
		--Mission.CB9 = FindEntity("CB9")
		--SetGuiName(Mission.CB9, "globals.unitclass_headquarter")
		--Mission.CB10 = FindEntity("CB10")
		--SetGuiName(Mission.CB10, "globals.unitclass_headquarter")
		--Mission.CB11 = FindEntity("CB11")
		--SetGuiName(Mission.CB11, "globals.unitclass_headquarter")
		--Mission.CB12 = FindEntity("CB12")
		--SetGuiName(Mission.CB12, "globals.unitclass_headquarter")
		--Mission.CB13 = FindEntity("CB13")
		--SetGuiName(Mission.CB13, "globals.unitclass_headquarter")
		-- CommandBuildings TODO: SetGuiName (multiban atmegy? (grave))
		-- todo modelltol fuggo a nev
		
		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB8)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB6)
			
		
	end
	
	---- unit tablak es ertekek atmenetileg a scriptben
	Mission.USTable = {}
	Mission.JapTable = {}
	Mission.UnitValue = {}
	Mission.UnitValue.BattleShip = 24
	Mission.UnitValue.Cruiser = 12
	Mission.UnitValue.Destroyer = 6
	Mission.UnitValue.MotherShip = 18
	Mission.UnitValue.TorpedoBoat = 2
	Mission.UnitValue.Submarine = 8
	Mission.UnitValue.LandingShip = 2
	Mission.UnitValue.Cargo = 2
	Mission.UnitValue.Fighter = 3
	Mission.UnitValue.DiveBomber = 3
	Mission.UnitValue.TorpedoBomber = 3
	Mission.UnitValue.LevelBomber = 6
	Mission.UnitValue.LargeReconPlane = 6
	Mission.UnitValue.SmallReconPlane = 3
	Mission.UnitValue.Kamikaze = 3

	Mission.CBMultiplier = 1.3
	----
	
	luaShipyardManagerInit(Mission.Shipyards)
	
	luaInitNewSystems()
	
	--luaUnitRedistribution()

-- Players
--[[
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("")	
-- RELEASE_LOGOFF  	luaLog("")	
-- RELEASE_LOGOFF  	luaLog("")	
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog("")	
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("")

-- RELEASE_LOGOFF  	luaLog("----- START AI CHECK -----")
-- RELEASE_LOGOFF  	luaLog("")

	Mission.USAI = false
	Mission.JPAI = false
	Mission.NOAI = false

	if Mission.PlayersTable[0] ~= nil then
		if Mission.PlayersTable[0]["ai"] == true then
			Mission.USAI = true
-- RELEASE_LOGOFF  			luaLog("US AI")
		end
	end
	
	if Mission.PlayersTable[4] ~= nil then
		if Mission.PlayersTable[4]["ai"] == true then
			Mission.JPAI = true
-- RELEASE_LOGOFF  			luaLog("JP AI")
		end
	end
	
	if Mission.USAI == false and Mission.JPAI == false then
		Mission.NOAI = true
-- RELEASE_LOGOFF  		luaLog("NO AI")
	end

-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("----- END AI CHECK -----")
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("----- CB DISTRIBUTUIN -----")


	if Mission.JPAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.USCB)
-- RELEASE_LOGOFF  --		luaLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaLog("Player Slot "..player.playerslot)
				if player.party == 0 then
					if Mission.USCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.USCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.USCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaLog(Mission.USCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  						luaLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  				luaLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end
	
	if Mission.USAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.JPCB)
-- RELEASE_LOGOFF  --		luaLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaLog("Player Slot "..player.playerslot)
				if player.party == 1 then
					if Mission.JPCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.JPCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.JPCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaLog(Mission.JPCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  						luaLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  				luaLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end

	if Mission.NOAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.USCB)
-- RELEASE_LOGOFF  --		luaLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaLog("Player Slot "..player.playerslot)
				if player.party == 0 then
					if Mission.USCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.USCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.USCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaLog(Mission.USCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  						luaLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  				luaLog("----- BREAK from CB Cycle -----")
				break
			end
		end
		local cbnum = 1
		local run = luaCountTable(Mission.JPCB)
-- RELEASE_LOGOFF  --		luaLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaLog("Player Slot "..player.playerslot)
				if player.party == 1 then
					if Mission.JPCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.JPCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.JPCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaLog(Mission.JPCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  						luaLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  				luaLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end
]]
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetThink(this, "luaIslandCapture01_think")	
	
	luaMultiVoiceOverHandler()

	Scoring_RealPlayTimeRunning(true)
end
-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaIslandCapture01_think(this, msg)

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.MissionEnd then
		return
	end			
	
	if Mission.MissionStart then
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog("!!!MissionStart!!!")
-- RELEASE_LOGOFF  			luaLog("")
		if LobbySettings.TimeLimit_IC == "globals.none" then
-- RELEASE_LOGOFF  			luaLog("Timelimit: none")
		else
			Countdown("mp.nar_timeleft", 0, Mission.TimeLimit, "luaSetTimeLimit")
-- RELEASE_LOGOFF  			luaLog("Timelimit: Countdown started")
		end
		Mission.MissionStart = false
	end
	
	Mission.StepCounter = Mission.StepCounter+1		
	
	Mission.AIBehaviourSet = false
	Mission.AIRushSet = false
	
	luaSetObjectives()
	luaCheckCBParty()
	luaCheckAlliedCB()
	luaCheckJapaneseCB()
	luaCheckTimelimit()
	luaCheckCapturePointlimit()
	luaCaptureCounters()
	luaCheckPlayerUnits()
	luaSetMissionHint()
	
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
	
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaCaptureCounters()
-- RELEASE_LOGOFF  	luaLog(" Updating counters...")
	if not Mission.CaptureCounters == true then
		Mission.CaptureCounters = true
-- RELEASE_LOGOFF  		luaLog(" Initializing counters...")
		MultiScore=	{
			[0]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[1]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[2]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[3]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[4]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[5]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[6]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[7]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
		}
				
		if LobbySettings.PointLimit == "globals.none" then			
			DisplayScores(1, 0, "mp.score_ic_points|".." #MultiScore.0.1#".." |mp.score_ic_bases|".." #MultiScore.0.3#", "mp.score_ic_points|".." #MultiScore.0.4#".." |mp.score_ic_bases|".." #MultiScore.0.5#",2,1)
			DisplayScores(1, 1, "mp.score_ic_points|".." #MultiScore.1.1#".." |mp.score_ic_bases|".." #MultiScore.1.3#", "mp.score_ic_points|".." #MultiScore.1.4#".." |mp.score_ic_bases|".." #MultiScore.1.5#",2,1)
			DisplayScores(1, 2, "mp.score_ic_points|".." #MultiScore.2.1#".." |mp.score_ic_bases|".." #MultiScore.2.3#", "mp.score_ic_points|".." #MultiScore.2.4#".." |mp.score_ic_bases|".." #MultiScore.2.5#",2,1)
			DisplayScores(1, 3, "mp.score_ic_points|".." #MultiScore.3.1#".." |mp.score_ic_bases|".." #MultiScore.3.3#", "mp.score_ic_points|".." #MultiScore.3.4#".." |mp.score_ic_bases|".." #MultiScore.3.5#",2,1)
			DisplayScores(1, 4, "mp.score_ic_points|".." #MultiScore.4.1#".." |mp.score_ic_bases|".." #MultiScore.4.3#", "mp.score_ic_points|".." #MultiScore.4.4#".." |mp.score_ic_bases|".." #MultiScore.4.5#",2,1)
			DisplayScores(1, 5, "mp.score_ic_points|".." #MultiScore.5.1#".." |mp.score_ic_bases|".." #MultiScore.5.3#", "mp.score_ic_points|".." #MultiScore.5.4#".." |mp.score_ic_bases|".." #MultiScore.5.5#",2,1)
			DisplayScores(1, 6, "mp.score_ic_points|".." #MultiScore.6.1#".." |mp.score_ic_bases|".." #MultiScore.6.3#", "mp.score_ic_points|".." #MultiScore.6.4#".." |mp.score_ic_bases|".." #MultiScore.6.5#",2,1)
			DisplayScores(1, 7, "mp.score_ic_points|".." #MultiScore.7.1#".." |mp.score_ic_bases|".." #MultiScore.7.3#", "mp.score_ic_points|".." #MultiScore.7.4#".." |mp.score_ic_bases|".." #MultiScore.7.5#",2,1)
		else
			DisplayScores(1, 0, "mp.score_ic_points|".." #MultiScore.0.1# / #MultiScore.0.2#".." |mp.score_ic_bases|".." #MultiScore.0.3#", "mp.score_ic_points|".." #MultiScore.0.4# / #MultiScore.0.2#".." |mp.score_ic_bases|".." #MultiScore.0.5#",2,1)
			DisplayScores(1, 1, "mp.score_ic_points|".." #MultiScore.1.1# / #MultiScore.1.2#".." |mp.score_ic_bases|".." #MultiScore.1.3#", "mp.score_ic_points|".." #MultiScore.1.4# / #MultiScore.1.2#".." |mp.score_ic_bases|".." #MultiScore.1.5#",2,1)
			DisplayScores(1, 2, "mp.score_ic_points|".." #MultiScore.2.1# / #MultiScore.2.2#".." |mp.score_ic_bases|".." #MultiScore.2.3#", "mp.score_ic_points|".." #MultiScore.2.4# / #MultiScore.2.2#".." |mp.score_ic_bases|".." #MultiScore.2.5#",2,1)
			DisplayScores(1, 3, "mp.score_ic_points|".." #MultiScore.3.1# / #MultiScore.3.2#".." |mp.score_ic_bases|".." #MultiScore.3.3#", "mp.score_ic_points|".." #MultiScore.3.4# / #MultiScore.3.2#".." |mp.score_ic_bases|".." #MultiScore.3.5#",2,1)
			DisplayScores(1, 4, "mp.score_ic_points|".." #MultiScore.4.1# / #MultiScore.4.2#".." |mp.score_ic_bases|".." #MultiScore.4.3#", "mp.score_ic_points|".." #MultiScore.4.4# / #MultiScore.4.2#".." |mp.score_ic_bases|".." #MultiScore.4.5#",2,1)
			DisplayScores(1, 5, "mp.score_ic_points|".." #MultiScore.5.1# / #MultiScore.5.2#".." |mp.score_ic_bases|".." #MultiScore.5.3#", "mp.score_ic_points|".." #MultiScore.5.4# / #MultiScore.5.2#".." |mp.score_ic_bases|".." #MultiScore.5.5#",2,1)
			DisplayScores(1, 6, "mp.score_ic_points|".." #MultiScore.6.1# / #MultiScore.6.2#".." |mp.score_ic_bases|".." #MultiScore.6.3#", "mp.score_ic_points|".." #MultiScore.6.4# / #MultiScore.6.2#".." |mp.score_ic_bases|".." #MultiScore.6.5#",2,1)
			DisplayScores(1, 7, "mp.score_ic_points|".." #MultiScore.7.1# / #MultiScore.7.2#".." |mp.score_ic_bases|".." #MultiScore.7.3#", "mp.score_ic_points|".." #MultiScore.7.4# / #MultiScore.7.2#".." |mp.score_ic_bases|".." #MultiScore.7.5#",2,1)
		end
	end
	
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 3 do
			MultiScore[i][1] = Mission.AlliedCapturePoints
			MultiScore[i][2] = Mission.CapturePointLimit
			MultiScore[i][3] = Mission.AlliedCBCounter
			MultiScore[i][4] = Mission.JapaneseCapturePoints
			MultiScore[i][5] = Mission.JapaneseCBCounter
		end
		
		for i = 4, 7 do
			MultiScore[i][1] = Mission.AlliedCapturePoints
			MultiScore[i][2] = Mission.CapturePointLimit
			MultiScore[i][3] = Mission.AlliedCBCounter
			MultiScore[i][4] = Mission.JapaneseCapturePoints
			MultiScore[i][5] = Mission.JapaneseCBCounter
		end
	end	
end

function luaCheckCapturePointlimit()
-- MissionEnd1
	--if Mission.CapturePointLimit == 0 and Mission.TimeLimit == 0 then
	if Mission.CapturePointLimit == 0 then
-- RELEASE_LOGOFF  		luaLog("CapturePointLimit 0, adjusting victory points...")
		luaGiveCapturePoints()
	elseif not Mission.TimeLimitReached then
		luaGiveCapturePoints()
		if Mission.CapturePointLimit <= Mission.AlliedCapturePoints or Mission.CapturePointLimit <= Mission.JapaneseCapturePoints then
			if Mission.AlliedCapturePoints == Mission.JapaneseCapturePoints then
				luaGiveCapturePoints()
				elseif Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
					if not Mission.MissionEnd then
						-- allied wins
						--todo mas kamera dobas, otletek!!!
						luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
						Scoring_RealPlayTimeRunning(false)
						luaObj_Completed("primary", 1)
						luaObj_Failed("primary", 2)
						Mission.MissionEnd = true
					end
				elseif Mission.JapaneseCapturePoints > Mission.AlliedCapturePoints then
					if not Mission.MissionEnd then
						-- japanese wins
						--todo mas kamera dobas, otletek!!!
						luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
						Scoring_RealPlayTimeRunning(false)
						luaObj_Completed("primary", 2)
						luaObj_Failed("primary", 1)
						Mission.MissionEnd = true
					end
				end
			end
	end
end

function luaGiveCapturePoints()	
	if not Mission.MissionEnd then
		local USCB = 0
		local JapCB = 0
		for idx, unit in pairs(Mission.CommandBuildings) do
-- RELEASE_LOGOFF  --			luaLog(" Mission.CommandBuildings idx: "..idx.." | party: "..tostring(unit.Party))
			if unit.Party == PARTY_ALLIED then
				if USCB == 0 then
					USCB = 1
				else
					USCB = (USCB + 1)
				end
				--Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + 1
			elseif unit.Party == PARTY_JAPANESE then
				if JapCB == 0 then
					JapCB = 1
				else
					JapCB = (JapCB + 1)
				end
				--Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + 1
			end
		end
		for idx, unit in pairs(Mission.CommandPosts) do
-- RELEASE_LOGOFF  --			luaLog(" Mission.CommandBuildings idx: "..idx.." | party: "..tostring(unit.Party))
			if unit.Party == PARTY_ALLIED then
				if USCB == 0 then
					USCB = 1
				else
					USCB = (USCB + 1)
				end
				--Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + 1
			elseif unit.Party == PARTY_JAPANESE then
				if JapCB == 0 then
					JapCB = 1
				else
					JapCB = (JapCB + 1)
				end
				--Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + 1
			end
		end
		
		USCB = USCB * Mission.CBMultiplier
		JapCB = JapCB * Mission.CBMultiplier
		
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + luaRound(USCB)
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + luaRound(JapCB)
	end
end

function luaSetTimeLimit()
	Mission.TimeLimit = 0
	luaCaptureCounters()
end

function luaCheckTimelimit()
-- RELEASE_LOGOFF  		luaLog("Checking Timelimit")
		if Mission.TimeLimit == 0	then
-- RELEASE_LOGOFF  			luaLog("...")
-- RELEASE_LOGOFF  			luaLog("!!!!!!! STARTING MISSION END v2!!!!!!")
-- RELEASE_LOGOFF  			luaLog("...")
			luaMissionEnd2()
		end
end

function luaMissionEnd2()
	Mission.TimeLimitReached = true	
-- todo camera meghivas objectiva completere allitas stb
	if Mission.AlliedCapturePoints == Mission.JapaneseCapturePoints then
-- RELEASE_LOGOFF  		luaLog("Checking until is not equal")
		luaGiveCapturePoints()		
	elseif Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
		if not Mission.MissionEnd then
			-- allied wins
			--todo mas kamera dobas
			luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	elseif Mission.AlliedCapturePoints < Mission.JapaneseCapturePoints then
		if not Mission.MissionEnd then
			-- japanese wins
			--todo mas kamera dobas
			luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	end
end

function luaSetObjectives()	
	if Mission.IC4v4 == true then
		if Mission.MissionInit then
		
		-- allied objs
		luaObj_Add("primary", 1, {Mission.Soryu, Mission.Hiryu, Mission.Yorktown, Mission.Lexington, Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11, Mission.CB12, Mission.CB13})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Soryu, Mission.Hiryu, Mission.Yorktown, Mission.Lexington,Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11, Mission.CB12, Mission.CB13})
		Mission.MissionInit = false
		end	
	end
	
	if Mission.IC3v3 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11})
		Mission.MissionInit = false
		end	
	end
	
	if Mission.IC2v2 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9})
		Mission.MissionInit = false
		end	
	end
	
	if Mission.IC1v1 == true then
		if Mission.MissionInit then
-- RELEASE_LOGOFF  		luaLog("Hint mejelenites")

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB6, Mission.CB7, Mission.CB8})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB6, Mission.CB7, Mission.CB8})
		Mission.MissionInit = false
		end	
	end
end

function luaCheckCBParty()
	local counterA = 0
	for idx,unit in pairs(Mission.CommandBuildings) do
		if unit.Party == PARTY_ALLIED then
			counterA = counterA + 1
		end
	end
	if counterA == 0 then
		---todo unit counter time counter
		luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.MissionEnd = true
	end
	local counterJ = 0
	for idx,unit in pairs(Mission.CommandBuildings) do
		if unit.Party == PARTY_JAPANESE then
			counterJ = counterJ + 1
		end
	end
	if counterJ == 0 then
		---todo unit counter time counter
-- RELEASE_LOGOFF  		luaLog("Japanese CB-s are captured")
		-- allied wins
		luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true
	end
end

function luaCheckAlliedCB()
	Mission.AlliedCBCounter = 0
	for idx,unit in pairs(Mission.CommandBuildings) do	
		if unit.Party == PARTY_ALLIED then
			Mission.AlliedCBCounter = Mission.AlliedCBCounter + 1
		end
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		if unit.Party == PARTY_ALLIED then
			Mission.AlliedCBCounter = Mission.AlliedCBCounter + 1
		end
	end
end

function luaCheckJapaneseCB()
	Mission.JapaneseCBCounter = 0
	for idx,unit in pairs(Mission.CommandBuildings) do	
		if unit.Party == PARTY_JAPANESE then
			Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + 1
		end
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		if unit.Party == PARTY_JAPANESE then
			Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + 1
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_IslandCapture01")
	-- mode description hint overlay
end


function luaCheckPlayerUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking players units...")
	if table.getn(Mission.USTable) ~= 0 then
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in Mission.USTable")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in Mission.JapTable")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
end

function luaManageDeadUnit(unitType, unitParty)
	if unitType == "BattleShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.BattleShip
	elseif unitType == "BattleShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.BattleShip
	elseif unitType == "Cruiser" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Cruiser
	elseif unitType == "Cruiser" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Cruiser
	elseif unitType == "Destroyer" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Destroyer
	elseif unitType == "Destroyer" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Destroyer
	elseif unitType == "MotherShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.MotherShip
	elseif unitType == "MotherShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.MotherShip
	elseif unitType == "TorpedoBoat" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.TorpedoBoat
	elseif unitType == "TorpedoBoat" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.TorpedoBoat
	elseif unitType == "Submarine" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Submarine
	elseif unitType == "Submarine" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Submarine
	elseif unitType == "LandingShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LandingShip
	elseif unitType == "LandingShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LandingShip
	elseif unitType == "Cargo" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Cargo
	elseif unitType == "Cargo" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Cargo
	elseif unitType == "Fighter" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Fighter
	elseif unitType == "Fighter" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Fighter
	elseif unitType == "DiveBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.DiveBomber
	elseif unitType == "DiveBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.DiveBomber
	elseif unitType == "TorpedoBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.TorpedoBomber
	elseif unitType == "TorpedoBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.TorpedoBomber
	elseif unitType == "LevelBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LevelBomber
	elseif unitType == "LevelBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LevelBomber
	elseif unitType == "LargeReconPlane" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LargeReconPlane
	elseif unitType == "LargeReconPlane" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LargeReconPlane
	elseif unitType == "SmallReconPlane" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.SmallReconPlane
	elseif unitType == "SmallReconPlane" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.SmallReconPlane
	elseif unitType == "Kamikaze" and unitParty == PARTY_JAPANESE then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Kamikaze
	end
end

function luaSkirmishAI()
	--todo
	Mission.AIParty = luaGetICSkirmishAIParty()	
	if not Mission.AIBehaviourSet then
		Mission.AIBehaviourSet = true
		Mission.AIBehaviour = luaRnd (1,3)
	end	
	if Mission.AIBehaviour == 1 then
		luaSkirmishAINormal()
	elseif Mission.AIBehaviour == 2 then
		luaSkirmishAIOffensive()
	elseif Mission.AIBehaviour == 3 then
		luaSkirmishAIDefensive()
	end	
end

function luaSkirmishAINormal()
	--TODO Normal skirmish AI
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,6)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	else
		for idx,unit in pairs(Mission.CommandBuildings) do
			unit.CaptureWeight = 2
			unit.StrategicGain = 3
		end		
		for idx,unit in pairs(Mission.CommandPosts) do
			unit.CaptureWeight = 1
			unit.StrategicGain = 2
		end
		MissionAISetDefendResourcePercent(0.3)		
	end
end

function luaSkirmishAIOffensive()
--TODO Tamado jellegu skirmish AI	
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,2)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	end
	for idx,unit in pairs(Mission.CommandBuildings) do
		unit.CaptureWeight = 3
		unit.StrategicGain = 5
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		unit.CaptureWeight = 1
		unit.StrategicGain = 2
	end
	AISetDefendResourcePercent(0.2)	
end

function luaSkirmishAIDefensive()
	--TODO Vedekezo jellegu skirmish AI
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,9)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	end
	for idx,unit in pairs(Mission.CommandBuildings) do
		unit.CaptureWeight = 2
		unit.StrategicGain = 2
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		unit.CaptureWeight = 1
		unit.StrategicGain = 2
	end	
	AISetDefendResourcePercent(0.5)	
end

function luaSkirmishAIRush()
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("Inbitialzing Rush Sequence")	
-- RELEASE_LOGOFF  	luaLog("")
	AISetDefendResourcePercent(0.0)
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("ChangeAI CB weights: ")	
-- RELEASE_LOGOFF  	luaLog("")
	
	Mission.UsCBs = {}
	Mission.JpCBs = {}
	
	local JpCBCount = 0
	local UsCBCount = 0
	
	Mission.FirstTarget = luaRnd(1,2)
	
	if Mission.FirstTarget == 1 then
		--todo range szamitast beleintegralni
		for idx,unit in pairs(Mission.CommandBuildings) do
			if unit.Party == PARTY_ALLIED then
				table.insert(Mission.UsCBs, unit)
			elseif unit.Party == PARTY_JAPANESE then
				table.insert(Mission.JpCBs, unit)
			end
		end
		if Mission.AIParty == PARTY_ALLIED then
			for idx,unit in pairs(Mission.JpCBs) do
				JpCBCount = JpCBCount + 1
-- RELEASE_LOGOFF  				luaLog("Jap CB count: "..tostring(JpCBCount))
			end
			local x = luaRnd(1, JpCBCount)
-- RELEASE_LOGOFF  			luaLog("Random CB number: "..tostring(x))
			Mission.JpCBs[x].CaptureWeight = 2
			Mission.JpCBs[x].StrategicGain = 10
		elseif Mission.AIParty == PARTY_JAPANESE then
			for idx,unit in pairs(Mission.UsCBs) do
				UsCBCount = UsCBCount + 1			
-- RELEASE_LOGOFF  				luaLog("Jap CB count: "..tostring(UsCBCount))
			end
			local x = luaRnd(1, UsCBCount)
-- RELEASE_LOGOFF  			luaLog("Random CB number: "..tostring(x))
			Mission.UsCBs[x].CaptureWeight = 2
			Mission.UsCBs[x].StrategicGain = 10
		end
	elseif Mission.FirstTarget == 2 then
		--todo palyafuggo besttarget???
	end
end

function luaSetMissionHint()
	if not Mission.HintDisplayed then
		Mission.HintDisplayed = true
		luaShowMissionHint()
	end
end