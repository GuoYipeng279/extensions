-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
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
	Mission.MissionTime = 000000					-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0	
	Mission.CaptureCounters = false
	Mission.MissionStart = true
	Mission.HintDisplayed = false
-- Mission units

	-- to do: Ezt kodbol kene kezelni!! vagy teljesen mas metodussal lefigyelni!!!
	if Mission.IC4v4 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 4v4")
		
		Mission.Shipyards = {}
		
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB1"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB3"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB4"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB5"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB6"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB7"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB9"))
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		table.insert(Mission.CommandBuildings, FindEntity("CB3"))
		table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		table.insert(Mission.CommandBuildings, FindEntity("CB9"))			

		Mission.CP1 = FindEntity("CP01")
		SetGuiName(Mission.CP1, "globals.unitclass_commandpost|".." - |02")
		Mission.CP2 = FindEntity("CP02")
		SetGuiName(Mission.CP2, "globals.unitclass_commandpost|".." - |03")
		Mission.CP3 = FindEntity("CP03")
		SetGuiName(Mission.CP3, "globals.unitclass_commandpost|".." - |04")
		Mission.CP4 = FindEntity("CP04H")
		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |08")
--		Mission.CP4 = FindEntity("CP04L")
--		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |08")
		Mission.CP5 = FindEntity("CP05H")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |11")
--		Mission.CP5 = FindEntity("CP05L")
--		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |11")
--		Mission.CP5 = FindEntity("CP05M")
--		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |11")
--		Mission.CP5 = FindEntity("CP05S")
--		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |11")
		Mission.CP6 = FindEntity("CP06H")
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |12")
--		Mission.CP6 = FindEntity("CP06L")
--		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |12")
		Mission.CP7 = FindEntity("CP07")
		SetGuiName(Mission.CP7, "globals.unitclass_commandpost|".." - |15")
		Mission.CP8 = FindEntity("CP08")
		SetGuiName(Mission.CP8, "globals.unitclass_commandpost|".." - |16")
		Mission.CP9 = FindEntity("CP09")
		SetGuiName(Mission.CP9, "globals.unitclass_commandpost|".." - |18")
		
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
				
		Mission.CB1 = FindEntity("CB1")
		Mission.CB1.CaptureWeight = 2
		Mission.CB1.StrategicGain = 4
		SetCommandBuildingOwnerPlayer(Mission.CB1, PLAYER_1)
		SetGuiName(Mission.CB1, "globals.unitclass_headquarter|".." - |01")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 1 Params")
		Mission.CB2 = FindEntity("CB2")
		Mission.CB2.CaptureWeight = 2
		Mission.CB2.StrategicGain = 4
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |05")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 2 Params")
		Mission.CB3 = FindEntity("CB3")
		Mission.CB3.CaptureWeight = 3
		Mission.CB3.StrategicGain = 5
		--SetParty(Mission.CB3, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB3,EROLF_ALL,PLAYER_5)
		SetGuiName(Mission.CB3, "globals.unitclass_headquarter|".." - |06")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 3 Params")
		Mission.CB4 = FindEntity("CB4")
		Mission.CB4.CaptureWeight = 3
		Mission.CB4.StrategicGain = 5		
		--SetParty(Mission.CB4, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB4,EROLF_ALL,PLAYER_1)
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |07")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 4 Params")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 2
		Mission.CB5.StrategicGain = 7
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |09")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 4
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |10")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 4
		Mission.CB7.StrategicGain = 7
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |13")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 7 Params")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 4
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |14")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")
		Mission.CB9 = FindEntity("CB9")
		Mission.CB9.CaptureWeight = 2
		Mission.CB9.StrategicGain = 7
		SetCommandBuildingOwnerPlayer(Mission.CB9, PLAYER_5)
		SetGuiName(Mission.CB9, "globals.unitclass_headquarter|".." - |17")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 9 Params")
		
	end
	
	if Mission.IC3v3 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 3v3")
		
		Mission.Shipyards = {}
		
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB1"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB3"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB4"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB5"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB6"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB7"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB9"))
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		--table.insert(Mission.CommandBuildings, FindEntity("CB1"))
		table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		table.insert(Mission.CommandBuildings, FindEntity("CB3"))
		table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB7"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))
		--table.insert(Mission.CommandBuildings, FindEntity("CB9"))	

		Mission.CP4 = FindEntity("CP04L")
		SetGuiName(Mission.CP4, "globals.unitclass_commandpost|".." - |04")
		Mission.CP5 = FindEntity("CP05L")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |07")
		Mission.CP6 = FindEntity("CP06L")
		SetGuiName(Mission.CP6, "globals.unitclass_commandpost|".." - |08")
	
		Mission.CommandPosts = {}		
			
			table.insert(Mission.CommandPosts, Mission.CP4)
			table.insert(Mission.CommandPosts, Mission.CP5)
			table.insert(Mission.CommandPosts, Mission.CP6)
		
		--Mission.CB1 = FindEntity("CB1")
		--SetGuiName(Mission.CB1, "globals.unitclass_headquarter|".." - |01")
		Mission.CB2 = FindEntity("CB2")
		Mission.CB2.CaptureWeight = 3
		Mission.CB2.StrategicGain = 5
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |01")
		Mission.CB3 = FindEntity("CB3")
		Mission.CB3.CaptureWeight = 3
		Mission.CB3.StrategicGain = 5
		SetCommandBuildingOwnerPlayer(Mission.CB3, PLAYER_1)
		--SetParty(Mission.CB3, PARTY_JAPANESE)
		--SetRoleAvailable(Mission.CB3,EROLF_ALL,PLAYER_5)
		SetGuiName(Mission.CB3, "globals.unitclass_headquarter|".." - |02")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 3 Params")
		Mission.CB4 = FindEntity("CB4")
		Mission.CB4.CaptureWeight = 3
		Mission.CB4.StrategicGain = 5
		--SetCommandBuildingOwnerPlayer(Mission.CB4, PLAYER_1)
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 4 Params")
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |03")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 2
		Mission.CB5.StrategicGain = 7
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |05")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 4
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |06")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		Mission.CB7 = FindEntity("CB7")
		Mission.CB7.CaptureWeight = 4
		Mission.CB7.StrategicGain = 7
		SetCommandBuildingOwnerPlayer(Mission.CB7, PLAYER_5)
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |09")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 7 Params")
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 7
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |10")
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 8 Params")		

		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB3)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB7)

	end	
	
	if Mission.IC2v2 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 2v2")
		
		Mission.Shipyards = {}
		
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB4"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB5"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB6"))
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		
		table.insert(Mission.CommandBuildings, FindEntity("CB2"))
		table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))
		table.insert(Mission.CommandBuildings, FindEntity("CB8"))

		Mission.CP5 = FindEntity("CP05M")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |05")
		
		Mission.CommandPosts = {}		
						
		table.insert(Mission.CommandPosts, Mission.CP5)
			
					
		Mission.CB2 = FindEntity("CB2")
		SetCommandBuildingOwnerPlayer(Mission.CB2, PLAYER_1)
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |01")
		Mission.CB4 = FindEntity("CB4")
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |02")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 2
		Mission.CB5.StrategicGain = 7		
		--SetParty(Mission.CB5, PARTY_ALLIED)
		--SetRoleAvailable(Mission.CB5,EROLF_ALL,PLAYER_2)		
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 5 Params")
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |03")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 4	
-- RELEASE_LOGOFF  		luaLog("Setting Command Building 6 Params")
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |04")		
		Mission.CB8 = FindEntity("CB8")
		Mission.CB8.CaptureWeight = 2
		Mission.CB8.StrategicGain = 7
		SetCommandBuildingOwnerPlayer(Mission.CB8, PLAYER_5)
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |06")
	
		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB2)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB8)
		
	end
	
	if Mission.IC1v1 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 1v1")
		
		Mission.Shipyards = {}
		
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB4"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB5"))
		table.insert(Mission.Shipyards, FindEntity("Shipyard Entity CB6"))		
		
		Mission.CommandBuildings = {}
-- RELEASE_LOGOFF  		luaLog("")
		
		table.insert(Mission.CommandBuildings, FindEntity("CB4"))
		table.insert(Mission.CommandBuildings, FindEntity("CB5"))
		table.insert(Mission.CommandBuildings, FindEntity("CB6"))

		Mission.CP5 = FindEntity("CP05S")
		SetGuiName(Mission.CP5, "globals.unitclass_commandpost|".." - |04")
		
		Mission.CommandPosts = {}		
						
		table.insert(Mission.CommandPosts, Mission.CP5)
		
		Mission.CB4 = FindEntity("CB4")
		Mission.CB4.CaptureWeight = 2
		Mission.CB4.StrategicGain = 4
		SetCommandBuildingOwnerPlayer(Mission.CB4, PLAYER_5)
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |01")
		Mission.CB5 = FindEntity("CB5")
		Mission.CB5.CaptureWeight = 4
		Mission.CB5.StrategicGain = 7
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |02")
-- RELEASE_LOGOFF  		luaLog("")
		Mission.CB6 = FindEntity("CB6")
		Mission.CB6.CaptureWeight = 2
		Mission.CB6.StrategicGain = 4
		SetCommandBuildingOwnerPlayer(Mission.CB6, PLAYER_1)
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |03")
	
		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB6)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB4)
	
	end
	
	for idx,unit in pairs(Mission.CommandPosts) do
		unit.CaptureWeight = 0.5
		unit.StrategicGain = 1
	end
	
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


	luaShipyardManagerInit(Mission.Shipyards)

	--luaUnitRedistribution()

-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaIslandCapture01_think")
	--AddWatch("Mission.MusicLevel")

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
		luaObj_Add("primary", 1, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11, Mission.CB12, Mission.CB13})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.CB10, Mission.CB11, Mission.CB12, Mission.CB13})
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
		if Mission.MissionInit  then
		
		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9})
		Mission.MissionInit = false
		end	
	end
	
	if Mission.IC1v1 == true then
		if Mission.MissionInit  then
		
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
	ShowHint("ID_Hint_IslandCapture07")
	-- mode description hint overlay
end


function luaCheckPlayerUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking players units...")
	if table.getn(luaRemoveDeadsFromTable(Mission.USTable)) ~= 0 then
		for index, unit in pairs (luaRemoveDeadsFromTable(Mission.USTable)) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in luaRemoveDeadsFromTable(Mission.USTable)")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(luaRemoveDeadsFromTable(Mission.USTable), index)
			end
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.JapTable)) ~= 0 then
		for index, unit in pairs (luaRemoveDeadsFromTable(Mission.JapTable)) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in luaRemoveDeadsFromTable(Mission.JapTable)")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(luaRemoveDeadsFromTable(Mission.JapTable), index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.USTable)) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.USTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.USTable), unit)
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.JapTable)) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.JapTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.JapTable), unit)
			end
		end
	end
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.USTable)) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.USTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.USTable), unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.JapTable)) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.JapTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.JapTable), unit)
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

function luaSetMissionHint()
	if not Mission.HintDisplayed then
		Mission.HintDisplayed = true
		luaShowMissionHint()
	end
end