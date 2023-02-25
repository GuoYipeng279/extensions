--[[
Kilõhetõ 3 ojjektum:
                Siege – Oil Refinery
                Siege – Office
                Siege – Hangar

Egy bónusz shipyard hangár dekornak:
                Siege – SY_Hangar

USN LST –k:
                Siege – LST 01
                Siege – LST 02
                Siege – LST 03
                Siege – LST 04

USN Spawnpointok:
                Siege – USN SpawnPoint 01
                Siege – USN SpawnPoint 02
                Siege – USN SpawnPoint 03
                Siege – USN SpawnPoint 04

IJN Spawnpointok – DD, CL, CA:
                Siege – IJN SpawnPoint All 01
                Siege – IJN SpawnPoint All 02
                Siege – IJN SpawnPoint All 03
                Siege – IJN SpawnPoint All 04

IJN Spawnpointok – DD, CL:
                Siege – IJN SpawnPoint D01 01
                Siege – IJN SpawnPoint D01 02
                Siege – IJN SpawnPoint D01 03
                Siege – IJN SpawnPoint D01 04

IJN Spawnpointok – DD:
                Siege – IJN SpawnPoint D02 01
                Siege – IJN SpawnPoint D02 02
                Siege – IJN SpawnPoint D02 03
                Siege – IJN SpawnPoint D02 04

Fortressek:
Siege - Fortress element, Large 01
Siege - Fortress element, Large 02
Siege - Fortress element, Large 03
Siege - Fortress element, Large 04

]]
function luaPrecacheUnits()
	PrepareClass(73)	--Fubuki
	PrepareClass(71)	--Agano
	PrepareClass(69)	--Takao
	PrepareClass(23)	--Fletcher
	PrepareClass(20)	--Deruyter
	PrepareClass(41)	--LST
	PrepareClass(70)	--Kuma
	PrepareClass(317)	--Northampton
	PrepareClass(21)	--York
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitS14Mission")
end

function luaInitS14Mission(this)
	Mission = this

	--local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege14"

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 1

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.MissionPhase = 0

	Mission.AICapturers = {}
	Mission.MaxCapturers = 4
	Mission.FirstLSTWave = true

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	--Mission.USCV = FindEntity("Siege - CV_US 01")
	--SetRoleAvailable(Mission.USCV, EROLF_ALL, PLAYER_AI)
	--OverrideHP(Mission.USCV, 30000)

	Mission.USReinf = {}
	Mission.JPReinf = {}

	Mission.USCV = FindEntity("Siege - CV_USN")
	Mission.USCVPos = GetPosition(Mission.USCV)
	OverrideHP(Mission.USCV, 50000)
	Mission.JPCV = FindEntity("Siege - CV_IJN")
	Mission.JPCVPos = GetPosition(Mission.JPCV)
	OverrideHP(Mission.JPCV, 50000)

	AISetTargetWeight("SHIP", "MOTHERSHIP", false, 0)
	AISetTargetWeight("PLANE", "MOTHERSHIP", false, 0)
	AISetTargetWeight(23, "SHIP", false, 0)
	AISetTargetWeight(73,41,false,5)
	AISetTargetWeight(71,41,false,5)
	AISetTargetWeight(69,41,false,5)
	AISetTargetWeight(70,41,false,5)

	Mission.KamikazeTemp = luaFindHidden("Siege - Kamikaze")
--	Mission.CorsairTemp = luaFindHidden("Siege - Corsair")
	Mission.AvengerTemp = luaFindHidden("Siege - Avenger")

	local hp = Mission.Players * 1875--3750 -- 8 playernel ez 30000

	Mission.HQ = FindEntity("Siege - CB3")
	OverrideHP(Mission.HQ, hp)

	Mission.OilRefinery = FindEntity("Siege - Oil Refinery")
	-- ha ezt olvasod, nem artott volna lockolni a geped
	OverrideHP(Mission.OilRefinery, hp/2)
	AISetHintWeight(Mission.OilRefinery, 20)

	Mission.Office = FindEntity("Siege - Office")
	OverrideHP(Mission.Office, hp/6)
	SetGuiName(Mission.Office, "mp14.defensecontrolcenter") -- TODO
	AISetHintWeight(Mission.Office, 20)

	Mission.Hangar = FindEntity("Siege - Hangar")
--	OverrideHP(Mission.Hangar, hp/2)
	SetGuiName(Mission.Hangar, "mp14.supplydepot") -- TODO
	AISetHintWeight(Mission.Hangar, 20)

	Mission.AvengerTrgs = {}
		table.insert(Mission.AvengerTrgs, Mission.OilRefinery)
		table.insert(Mission.AvengerTrgs, Mission.Office)
		table.insert(Mission.AvengerTrgs, Mission.Hangar)

	Mission.Supplies = {}
	table.insert(Mission.Supplies, Mission.Hangar)
	table.insert(Mission.Supplies, FindEntity("Siege - Oil Tank 01"))
	table.insert(Mission.Supplies, FindEntity("Siege - Oil Tank 02"))

	local supplyNum = table.getn(Mission.Supplies)

	for idx, entity in pairs(Mission.Supplies) do
		if idx == 1 then
			OverrideHP(entity, hp/supplyNum)
		else
			OverrideHP(entity, hp/supplyNum/8)
		end
	end

	Mission.SecObj = {}
		table.insert(Mission.SecObj, Mission.OilRefinery)
		table.insert(Mission.SecObj, Mission.Office)
		table.insert(Mission.SecObj, Mission.Hangar)
		table.insert(Mission.SecObj, FindEntity("Siege - Oil Tank 01"))
		table.insert(Mission.SecObj, FindEntity("Siege - Oil Tank 02"))

	--kiloheto szarok
	--Mission.AAs = {}
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 01"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 02"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 03"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 04"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 05"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 06"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 07"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 08"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 09"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 10"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 11"))
	--	table.insert(Mission.AAs, FindEntity("Heavy AA, CB 12"))

	--Mission.Coastals = {}
	--	table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 01"))
	--	table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 02"))
	--	table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 03"))
	--	table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 04"))
	--	table.insert(Mission.Coastals, FindEntity("Siege - Coastal Gun, Japanese 05"))

	--Mission.Batteries = {}
		--table.insert(Mission.Batteries, FindEntity("Siege - Huge Battery Open 01"))
		--table.insert(Mission.Batteries, FindEntity("Siege - Huge Battery Open 02"))

	--Mission.MediumBunkers = {}
	--	table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 01"))
	--	table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 02"))
	--	table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 03"))
	--	table.insert(Mission.MediumBunkers, FindEntity("Siege - Medium Bunker, Concrete 04"))

	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress element, Large 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress element, Large 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress element, Large 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress element, Large 04"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress element, Large 05"))

	for idx, fort in pairs(Mission.Fortresses) do
		SetSkillLevel(fort, 1)
	end

	--Mission.Airfield = FindEntity("Siege - CB4_AF")
	--Mission.Shipyard = FindEntity("CB4_SY")
	--SetParty(Mission.Shipyard, PARTY_JAPANESE)

	Mission.AllOtherJPUnits = {}
	Mission.AllOtherUSUnits = {}

	-- spawn pontok
	Mission.InitalIJNSpawnPoints = {}
		table.insert(Mission.InitalIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint All 01"))
		table.insert(Mission.InitalIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint All 02"))
		table.insert(Mission.InitalIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint All 03"))
		table.insert(Mission.InitalIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint All 04"))

	Mission.SecondaryIJNSpawnPoints = {}
		table.insert(Mission.SecondaryIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D01 01"))
		table.insert(Mission.SecondaryIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D01 02"))
		table.insert(Mission.SecondaryIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D01 03"))
		table.insert(Mission.SecondaryIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D01 04"))

	Mission.TertialyIJNSpawnPoints = {}
		table.insert(Mission.TertialyIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D02 01"))
		table.insert(Mission.TertialyIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D02 02"))
		table.insert(Mission.TertialyIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D02 03"))
		table.insert(Mission.TertialyIJNSpawnPoints, FindEntity("Siege - IJN SpawnPoint D02 04"))

	Mission.USNSpawnPoints = {}
		table.insert(Mission.USNSpawnPoints, FindEntity("Siege - USN SpawnPoint 01"))
		table.insert(Mission.USNSpawnPoints, FindEntity("Siege - USN SpawnPoint 02"))
		table.insert(Mission.USNSpawnPoints, FindEntity("Siege - USN SpawnPoint 03"))
		table.insert(Mission.USNSpawnPoints, FindEntity("Siege - USN SpawnPoint 04"))

	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

	--for index, entity in pairs(Mission.USNSpawnPoints) do
	--	for i=0,3 do
	--		if (index - 1) == i then
	--			ActivateSpawnpoint(entity, i)
	--		else
	--			DeactivateSpawnpoint(entity, i)
	--		end
	--	end
	--end

	for j=0,7 do
		if j == 0 then
			ActivateSpawnpoint(Mission.USNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[4], j)
		elseif j == 1 then
			DeactivateSpawnpoint(Mission.USNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[3], j)
			ActivateSpawnpoint(Mission.USNSpawnPoints[4], j)
		elseif j == 2 then
			DeactivateSpawnpoint(Mission.USNSpawnPoints[1], j)
			ActivateSpawnpoint(Mission.USNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[4], j)
		elseif j == 3 then
			DeactivateSpawnpoint(Mission.USNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[2], j)
			ActivateSpawnpoint(Mission.USNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.USNSpawnPoints[4], j)
		elseif j == 4 then
			ActivateSpawnpoint(Mission.InitalIJNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[4], j)
		elseif j == 5 then
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[3], j)
			ActivateSpawnpoint(Mission.InitalIJNSpawnPoints[4], j)
		elseif j == 6 then
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[1], j)
			ActivateSpawnpoint(Mission.InitalIJNSpawnPoints[2], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[4], j)
		elseif j == 7 then
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[1], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[2], j)
			ActivateSpawnpoint(Mission.InitalIJNSpawnPoints[3], j)
			DeactivateSpawnpoint(Mission.InitalIJNSpawnPoints[4], j)
		end
	end

	--for index, entity in pairs(Mission.InitalIJNSpawnPoints) do
	--	for i=4,7 do
	--		if (index + 3 ) == i then
	--			ActivateSpawnpoint(entity, i)
	--		else
	--			DeactivateSpawnpoint(entity, i)
	--		end
	--	end
	--end

	for index, entity in pairs(luaSumTablesIndex(Mission.SecondaryIJNSpawnPoints, Mission.TertialyIJNSpawnPoints)) do
-- RELEASE_LOGOFF  		luaLog("disabling "..entity.Name)
		for i=4,7 do
			DeactivateSpawnpoint(entity, i)
		end
	end


-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")
--warnings
	Mission.WarningsShown = {}
		Mission.WarningsShown["CV"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
		}
		Mission.WarningsShown["HQ"] = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
		}

----- resource dolgok -----

	if Mission.Players <= 2 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 2")
		Mission.ResourcePoolBase = 500
		Mission.ResourceUSPool = 500
		Mission.ResourceJapPool = 500
	elseif Mission.Players <= 4 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 4")
		Mission.ResourcePoolBase = 750
		Mission.ResourceUSPool = 750
		Mission.ResourceJapPool = 750
	elseif Mission.Players <= 6 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 6")
		Mission.ResourcePoolBase = 900
		Mission.ResourceUSPool = 900
		Mission.ResourceJapPool = 900
	elseif Mission.Players <= 8 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 8")
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! unhandled Mission.Players: "..Mission.Players)
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	end

	Mission.Points = {}
		Mission.Points.Fletcher = 30--15
		Mission.Points.Fubuki = 30--15
		Mission.Points.Agano = 30--15
		Mission.Points.Takao = 40--20
		Mission.Points.JPFortressLarge = 40--20
		Mission.Points.Deruyter = 20--10
		Mission.Points.LST = 12--10
		Mission.Points.Pete = 10--5
		Mission.Points.Kingfisher = 10--5
		Mission.Points.Kuma = 30--15
		Mission.Points.Carrier = 100
		Mission.Points.DefenseCenter = 50
		Mission.Points.Bunker = 25

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri1",
				["Text"] = "mp03.obj_siege_us_p1_text",
				["TextCompleted"] = "mp03.obj_siege_us_p1_comp",
				["TextFailed"] = "mp03.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec1",
				["Text"] = "mp14.obj_siege_us_s1_text",
				["TextCompleted"] = "mp14.obj_siege_us_s1_comp",
				["TextFailed"] = "mp14.obj_siege_us_s1_failed",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
		}
	}

-- power ups

	for idx, player in pairs(Mission.PlayersTable) do
		AddPowerup(Mission.PlayersTable[idx].playerslot, {["classID"] = "improved_shells", ["useLimit"] = 1,})
		AddPowerup(Mission.PlayersTable[idx].playerslot, {["classID"] = "automatic_reloader", ["useLimit"] = 1,})
--		AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
	end

	Mission.DeadUSShips = 0
	Mission.DeadUSShipsTarget = 5
	Mission.DeadJPShips = 0
	Mission.DeadJPShipsTarget = 5

	SetRocketAirGroundTypeDifferent(false)

	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	luaInitNewSystems()

    SetThink(this, "luaS14Mission_think")
end

function luaS14Mission_think(this, msg)
-- RELEASE_LOGOFF  	luaLog(" Mission.ResourceJapPool: "..tostring(Mission.ResourceJapPool).." | Mission.ResourceUSPool: "..tostring(Mission.ResourceUSPool))

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if not Mission.FirstRun then
		luaS14SetMultiScoreTable()
		luaS14AddObj()
		luaS14DeadShipCheck()
		luaDelay(luaS14CheckJapWeights,20)
		Mission.FirstRun = true
	end

	luaS14CheckLanding()
	luaS14HintManager()
	luaS14CheckBaseStatus()
	luaS14Warnings()
	luaS14CheckPoints()
	luaS14CheckObj()
	luaS14AIThink()
	if Mission.FirstLSTWave then
		if Mission.Office.Dead or luaCountTable(Mission.Fortresses) == 0 then
			luaS14SpawnAllLSTs()
			Mission.FirstLSTWave = false
		end
	end
end

function luaS14CheckBaseStatus()

	if not Mission.SecSpwnpointsActive then
		--if Mission.Hangar.Dead or Mission.OilRefinery.Dead then
		if (table.getn(luaRemoveDeadsFromTable(Mission.Supplies)) == 0) or Mission.OilRefinery.Dead then

			--MissionNarrativeParty(PARTY_JAPANESE, "UNLOCALIZED! MENO CRUISER SPAWN HUSS!")
			--MissionNarrativeParty(PARTY_ALLIED, "UNLOCALIZED! MENO JAPO CRUISER SPAWN HUSS!")
			ShowHint("ID_Hint_Siege14_NoMoreCA")
			for index,entity in pairs(Mission.InitalIJNSpawnPoints) do
				for i=3,7 do
					DeactivateSpawnpoint(entity, i)
				end
			end

			--for index,entity in pairs(Mission.SecondaryIJNSpawnPoints) do
			--	for i=3,7 do
			--		if (index + 3) == i then
			--			ActivateSpawnpoint(entity, i)
			--		end
			--	end
			--end
		for j=4,7 do
			if j == 4 then
				ActivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[1], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[2], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[3], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[4], j)
			elseif j == 5 then
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[1], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[2], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[3], j)
				ActivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[4], j)
			elseif j == 6 then
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[1], j)
				ActivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[2], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[3], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[4], j)
			elseif j == 7 then
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[1], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[2], j)
				ActivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[3], j)
				DeactivateSpawnpoint(Mission.SecondaryIJNSpawnPoints[4], j)
			end
		end

			Mission.SecSpwnpointsActive = true

			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Bunker

		end
	end

	if not Mission.TerSpwnpointsActive then
		--if Mission.Hangar.Dead and Mission.OilRefinery.Dead then
		if (table.getn(luaRemoveDeadsFromTable(Mission.Supplies)) == 0) and Mission.OilRefinery.Dead then

			--MissionNarrativeParty(PARTY_JAPANESE, "UNLOCALIZED! OSSZES CRUISER SPAWN HUSS!")
			--MissionNarrativeParty(PARTY_ALLIED, "UNLOCALIZED! JAPOKNAK NINCSE CRUISERUK!")
			ShowHint("ID_Hint_Siege14_NoMoreCr")
			for index,entity in pairs(Mission.SecondaryIJNSpawnPoints) do
				for i=3,7 do
					DeactivateSpawnpoint(entity, i)
				end
			end

			--for index,entity in pairs(Mission.TertialyIJNSpawnPoints) do
			--	for i=3,7 do
			--		if (index + 3) == i then
			--			ActivateSpawnpoint(entity, i)
			--		end
			--	end
			--end
			for j=4,7 do
				if j == 4 then
					ActivateSpawnpoint(Mission.TertialyIJNSpawnPoints[1], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[2], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[3], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[4], j)
				elseif j == 5 then
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[1], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[2], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[3], j)
					ActivateSpawnpoint(Mission.TertialyIJNSpawnPoints[4], j)
				elseif j == 6 then
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[1], j)
					ActivateSpawnpoint(Mission.TertialyIJNSpawnPoints[2], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[3], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[4], j)
				elseif j == 7 then
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[1], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[2], j)
					ActivateSpawnpoint(Mission.TertialyIJNSpawnPoints[3], j)
					DeactivateSpawnpoint(Mission.TertialyIJNSpawnPoints[4], j)
				end
			end

			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Bunker

			Mission.TerSpwnpointsActive = true

		end
	end

	if not Mission.ArtillDeactivated then
		Mission.Fortresses = luaRemoveDeadsFromTable(Mission.Fortresses)
		if Mission.Office.Dead or luaCountTable(Mission.Fortresses) == 0 then
-- RELEASE_LOGOFF  			luaLog("Meghalt az Office")
			--MissionNarrativeParty(PARTY_JAPANESE, "UNLOCALIZED! PARTI VEDELEM HUSS! KEZDODIK A SZOPAS!!")
			--MissionNarrativeParty(PARTY_ALLIED, "UNLOCALIZED! PARTI VEDELEM HUSS! KEZDODIK A LANDING!!")
			ShowHint("ID_Hint_Siege14_Landing")

			--for idx,unit in pairs(Mission.AAs) do
			--	Kill(unit, true)
			--	table.remove(Mission.AAs, idx) --hogy ne szamolja pontnak
			--end

			for idx, unit in pairs(Mission.Fortresses) do -- Ne kommentezd ki vagy ha megteszed legalabb csinald meg :D (Atis)
				Kill(unit, true)
		--		table.remove(Mission.Fortresses, idx) --hogy ne szamolja pontnak (Ezt nem ide kene rakni mert elrontja a for ciklust)
			end

			Mission.Fortresses = {}--luaRemoveDeadsFromTable(Mission.Fortresses)

			Mission.ArtillDeactivated = true

			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.DefenseCenter


		end
	end


end

function luaS14CheckLanding()

	for idx,unit in pairs(Mission.AICapturers) do

		if not unit.Dead then
			if Mission.ArtillDeactivated then
				if luaGetScriptTarget(unit) == nil and Mission.HQ.Party == PARTY_JAPANESE then
					luaSetScriptTarget(unit, Mission.HQ)
					NavigatorAttackMove(unit, Mission.HQ, {})
				end
			end
		else
			if string.find(unit.Name,"01") then
				luaS14SpawnLST(1)
			elseif string.find(unit.Name,"02") then
				luaS14SpawnLST(2)
			elseif string.find(unit.Name,"03") then
				luaS14SpawnLST(3)
			elseif string.find(unit.Name,"04") then
				luaS14SpawnLST(4)
			elseif string.find(unit.Name,"05") then
				luaS14SpawnLST(5)
			elseif string.find(unit.Name,"06") then
				luaS14SpawnLST(6)
			elseif string.find(unit.Name,"07") then
				luaS14SpawnLST(7)
			elseif string.find(unit.Name,"08") then
				luaS14SpawnLST(8)
			end
			table.remove(Mission.AICapturers, idx)
		end

	end

end

function luaS14SpawnLST(i)
	local unit = GenerateObject("Siege - LST 0"..tostring(i))
	SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	table.insert(Mission.AICapturers, unit)
end

function luaS14SpawnAllLSTs()
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 01"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 02"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 03"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 04"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 05"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 06"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 07"))
	table.insert(Mission.AICapturers, GenerateObject("Siege - LST 08"))

	for idx,unit in pairs(Mission.AICapturers) do
		SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
	end
end

function luaS14HintManager()

	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 120 and not Mission.Hint1Shown then
			ShowHint("ID_Hint_Siege14_TinyTim")
			ShowHint("ID_Hint_Siege14_Kamikaze")
			Mission.Hint1Shown = true
		end
	end
end

function luaS14SetMultiScoreTable()
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	MultiScore=	{
		[0]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[1]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[2]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[3]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[4]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[5]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[6]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
		[7]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
--			[3] = Mission.DeadUSShips,
--			[4] = Mission.DeadUSShipsTarget,
--			[5] = Mission.DeadJPShips,
--			[6] = Mission.DeadJPShipsTarget,
		},
	}

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.1#", "mp01.score_siege_resource_def".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.1#", "mp01.score_siege_resource_def".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.1#", "mp01.score_siege_resource_def".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.1#", "mp01.score_siege_resource_def".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.1#", "mp01.score_siege_resource_def".."| #MultiScore.4.2#", 2, 1)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.1#", "mp01.score_siege_resource_def".."| #MultiScore.5.2#", 2, 1)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.1#", "mp01.score_siege_resource_def".."| #MultiScore.6.2#", 2, 1)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.1#", "mp01.score_siege_resource_def".."| #MultiScore.7.2#", 2, 1)
--[[
	DisplayScores(1, 0, "mp01.score_siege_resource".."| #MultiScore.0.1#", "mp01.score_siege_resource".."| #MultiScore.0.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 1, "mp01.score_siege_resource".."| #MultiScore.1.1#", "mp01.score_siege_resource".."| #MultiScore.1.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 2, "mp01.score_siege_resource".."| #MultiScore.2.1#", "mp01.score_siege_resource".."| #MultiScore.2.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 3, "mp01.score_siege_resource".."| #MultiScore.3.1#", "mp01.score_siege_resource".."| #MultiScore.3.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 4, "mp01.score_siege_resource".."| #MultiScore.4.1#", "mp01.score_siege_resource".."| #MultiScore.4.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 5, "mp01.score_siege_resource".."| #MultiScore.5.1#", "mp01.score_siege_resource".."| #MultiScore.5.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 6, "mp01.score_siege_resource".."| #MultiScore.6.1#", "mp01.score_siege_resource".."| #MultiScore.6.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 7, "mp01.score_siege_resource".."| #MultiScore.7.1#", "mp01.score_siege_resource".."| #MultiScore.7.2#", PARTY_ALLIED, PARTY_JAPANESE)


	DisplayScores(2, 0, "mp14.score_deadunit_us".."| #MultiScore.0.3# / #MultiScore.0.4#", "mp14.score_deadunit_ijn".."| #MultiScore.0.5# / #MultiScore.0.6#", 2, 1)
	DisplayScores(2, 1, "mp14.score_deadunit_us".."| #MultiScore.1.3# / #MultiScore.1.4#", "mp14.score_deadunit_ijn".."| #MultiScore.1.5# / #MultiScore.1.6#", 2, 1)
	DisplayScores(2, 2, "mp14.score_deadunit_us".."| #MultiScore.2.3# / #MultiScore.2.4#", "mp14.score_deadunit_ijn".."| #MultiScore.2.5# / #MultiScore.2.6#", 2, 1)
	DisplayScores(2, 3, "mp14.score_deadunit_us".."| #MultiScore.3.3# / #MultiScore.3.4#", "mp14.score_deadunit_ijn".."| #MultiScore.3.5# / #MultiScore.3.6#", 2, 1)
	DisplayScores(2, 4, "mp14.score_deadunit_us".."| #MultiScore.4.3# / #MultiScore.4.4#", "mp14.score_deadunit_ijn".."| #MultiScore.4.5# / #MultiScore.4.6#", 2, 1)
	DisplayScores(2, 5, "mp14.score_deadunit_us".."| #MultiScore.5.3# / #MultiScore.5.4#", "mp14.score_deadunit_ijn".."| #MultiScore.5.5# / #MultiScore.5.6#", 2, 1)
	DisplayScores(2, 6, "mp14.score_deadunit_us".."| #MultiScore.6.3# / #MultiScore.6.4#", "mp14.score_deadunit_ijn".."| #MultiScore.6.5# / #MultiScore.6.6#", 2, 1)
	DisplayScores(2, 7, "mp14.score_deadunit_us".."| #MultiScore.7.3# / #MultiScore.7.4#", "mp14.score_deadunit_ijn".."| #MultiScore.7.5# / #MultiScore.7.6#", 2, 1)
]]

end

function luaS14CheckPoints()
	--japan szarok
	--for idx,unit in pairs(Mission.AAs) do
	--	if unit.Dead then
	--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.HeavyAA
	--		table.remove(Mission.AAs, idx)
	--	end
	--end

	--for idx,unit in pairs(Mission.Coastals) do
	--	if unit.Dead then
	--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.CoastalGun
	--		table.remove(Mission.Coastals, idx)
	--	end
	--end

	--for idx,unit in pairs(Mission.Batteries) do
	--	if unit.Dead then
	--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Battery
	--		table.remove(Mission.Batteries, idx)
	--	end
	--end

	for idx,unit in pairs(Mission.Fortresses) do
		if unit.Dead then
			Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.JPFortressLarge
			table.remove(Mission.Fortresses, idx)
			Mission.DeadJPShips = Mission.DeadJPShips + 1
		end
	end

	--for idx,unit in pairs(Mission.MediumBunkers) do
	--	if unit.Dead then
	--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.JPFortressMedium
	--		table.remove(Mission.MediumBunkers, idx)
	--	end
	--end

--	if Mission.Airfield.Dead and not Mission.AirfieldPointsCounted then
--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Airfield
--		Mission.AirfieldPointsCounted = true
--	end

--	if Mission.Shipyard.Dead and not Mission.ShipyardPointsCounted then
--		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Shipyard
--		Mission.ShipyardPointsCounted = true
--	end

	Mission.AllOtherJPUnits = luaS14GetUnits(PARTY_JAPANESE)
	Mission.AllOtherUSUnits = luaS14GetUnits(PARTY_ALLIED)

	for idx,unit in pairs(Mission.AllOtherJPUnits) do
		if unit and unit.Dead then

			if luaGetType(unit) == "ship" then
				Mission.DeadJPShips = Mission.DeadJPShips + 1
			end

			if unit.Class.Type == "Destroyer" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Fubuki
			elseif unit.Class.Type == "Cruiser" then
				if unit.Class.ID == 71 then
					Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Agano
				elseif unit.Class.ID == 69 then
					Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Takao
				--elseif unit.Class.ID == 70 then
				--	Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Kuma
				end
			elseif unit.Class.Type == "SmallReconPlane" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Pete
			elseif unit.Class.Type == "MotherShip" then
				Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Carrier
			end

			table.remove(Mission.AllOtherJPUnits, idx)

		--[[
			else

			if luaGetType(unit) == "plane" then
				local lastNum = luaC12GetSqMultiplier(unit)
				local actNum = table.getn(GetSquadronPlanes(unit))

				if lastNum > actNum then
					unit.sqadnumchecked = actNum
				end

				if unit.Class.Type == "Fighter" then
					Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Points.Zero
				elseif unit.Class.Type == "DiveBomber" then
					Mission.ResourceJapPool = Mission.ResourceJapPool - (Mission.Points.Jill * (lastNum - actNum))
				end
			end
		]]
		end
	end

	for idx,unit in pairs(Mission.AllOtherUSUnits) do
		if unit and unit.Dead then

			if luaGetType(unit) == "ship" then
				Mission.DeadUSShips = Mission.DeadUSShips + 1
			end

			if unit.Class.Type == "Destroyer" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Fletcher
			elseif unit.Class.Type == "LandingShip" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.LST
			elseif unit.Class.Type == "Cruiser" then
				--if unit.Class.ID == 19 then
				--	Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Northampton
				--elseif unit.Class.ID == 20 then
					Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Deruyter
				--elseif unit.Class.ID == 21 then
				--	Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.York
				--end
			elseif unit.Class.Type == "SmallReconPlane" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Kingfisher
			elseif unit.Class.Type == "MotherShip" then
				Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Points.Carrier
			end

			table.remove(Mission.AllOtherUSUnits, idx)

		--[[
		else

			if luaGetType(unit) == "plane" then
				local lastNum = luaC12GetSqMultiplier(unit)
				local actNum = table.getn(GetSquadronPlanes(unit))

				if lastNum > actNum then
					unit.sqadnumchecked = actNum
				end

				if unit.Class.Type == "Fighter" then
					Mission.ResourceUSPool = Mission.ResourceUSPool - (Mission.Points.Hellcat * (lastNum - actNum))
				end
			end
			]]
		end
	end

	if Mission.ResourceUSPool > 0 and Mission.ResourceJapPool > 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" US pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.MissionEndCalled = true
		luaS14MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaS14MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaS14MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaS14MissionEnd()
		end
	end

end

function luaS14GetUnits(Party)

	if Party == PARTY_JAPANESE then

		--local unitsTbl = luaSumTablesIndex(recon[Party].own.destroyer,recon[Party].own.fighter,recon[Party].own.divebomber,recon[Party].own.reconplane,recon[Party].own.cruiser)
		local unitsTbl = luaSumTablesIndex(recon[Party].own.reconplane,recon[Party].own.cruiser,recon[Party].own.destroyer,recon[Party].own.mothership)

		for idx,unit in pairs(unitsTbl) do
			if not unit.Dead and not luaIsInside(unit, Mission.AllOtherJPUnits) then
				table.insert(Mission.AllOtherJPUnits, unit)
			end
		end

		return Mission.AllOtherJPUnits

	elseif Party == PARTY_ALLIED then

		--local unitsTbl = luaSumTablesIndex(recon[Party].own.destroyer,recon[Party].own.fighter,recon[Party].own.cargo,recon[Party].own.landingship,recon[Party].own.cruiser)
		local unitsTbl = luaSumTablesIndex(recon[Party].own.landingship,recon[Party].own.cruiser,recon[Party].own.destroyer,recon[Party].own.reconplane,recon[Party].own.mothership)

		for idx,unit in pairs(unitsTbl) do
			if not unit.Dead and not luaIsInside(unit, Mission.AllOtherUSUnits) then
				table.insert(Mission.AllOtherUSUnits, unit)
			end
		end

		return Mission.AllOtherUSUnits

	end

end

function luaC12GetSqMultiplier(unit)
	if not unit.sqadnumchecked then
		return 3
	else
		return unit.sqadnumchecked
	end
end

function luaS14MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Scoring_RealPlayTimeRunning(false)
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.USCV, "", nil, nil, nil, PARTY_ALLIED)
	end
end

function luaS14AddObj()
	Scoring_RealPlayTimeRunning(true)

	luaS14ShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	luaObj_Add("primary", 1, {Mission.HQ})
	luaObj_Add("primary", 2, {Mission.HQ})
	for idx, entity in pairs(Mission.SecObj) do
		luaObj_Add("secondary", 1)
		luaObj_AddUnit("secondary", 1, entity)
	end

end

function luaS14CheckObj()

	Mission.SecObj = luaRemoveDeadsFromTable(Mission.SecObj)
	if luaObj_IsActive("secondary", 1) and table.getn(Mission.SecObj) == 0 then
		luaObj_Completed("secondary", 1)
	end


	if Mission.HQ.Party ~= PARTY_JAPANESE then
		luaObj_Completed("primary",1)
		luaObj_Failed("primary",2)

		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end

		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.USCV, "", nil, nil, nil, PARTY_ALLIED)

		--MissionNarrativeParty(PARTY_JAPANESE, "Sic transit gloria mundi!")
		--MissionNarrativeParty(PARTY_ALLIED, "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit!")

		--luaDelay(luaS14MissionEndUsWon,5)

		Mission.Completed = true

	end

	--[[
	if Mission.USCV.Dead then
		luaObj_Failed("primary",1)
		luaObj_Completed("primary",2)

		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end

		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)

		--MissionNarrativeParty(PARTY_ALLIED, "Sic transit gloria mundi!")
		--MissionNarrativeParty(PARTY_JAPANESE, "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit!")

		--luaDelay(luaS14MissionEndJPWon,5)

		Mission.Completed = true
	end
	]]
end

function luaS14ShowMissionHint()
	--ShowHint("ID_Hint_Siege14_US")
	--ShowHint("ID_Hint_Siege14_IJN")
	ShowHint("ID_Hint_Siege14")
	--MissionNarrative("UNLOCALIZED!! SIEGE14 KEZDO HINT NEKTEK NESZTEK!")
end

function luaS14Warnings()

	if Mission.WarningsShown["HQ"][4] and Mission.WarningsShown["CV"][4] then
		return
	end

	--local hpCV = GetHpPercentage(Mission.USCV)
	local hpHQ = GetHpPercentage(Mission.HQ)

	if hpHQ <= 0.75 and not Mission.WarningsShown["HQ"][1] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_75")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_75")
		Mission.WarningsShown["HQ"][1] = true
	elseif hpHQ <= 0.5 and not Mission.WarningsShown["HQ"][2] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_50")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_50")
		Mission.WarningsShown["HQ"][2] = true
	elseif hpHQ <= 0.25 and not Mission.WarningsShown["HQ"][3] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_25")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_25")
		Mission.WarningsShown["HQ"][3] = true
	elseif hpHQ <= 0.1 and not Mission.WarningsShown["HQ"][3] then
		MissionNarrativeParty(PARTY_JAPANESE, "mp12.nar_siege12_hqhp_10")
		MissionNarrativeParty(PARTY_ALLIED, "mp12.nar_siege12_hqhp_10")
		Mission.WarningsShown["HQ"][4] = true
	end

end

function luaS14DeadShipCheck()

	if Mission.USCV.Dead then
		Mission.DeadUSShips = 0
	end

	if Mission.JPCV.Dead then
		Mission.DeadJPShips = 0
	end

--[[
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][3] = Mission.DeadUSShips
			MultiScore[i][5] = Mission.DeadJPShips
		end
	end

	if not Mission.USCV.Dead and not Mission.JPCV.Dead then
		DisplayScores(2, 0, "mp14.score_deadunit_us".."| #MultiScore.0.3# / #MultiScore.0.4#", "mp14.score_deadunit_ijn".."| #MultiScore.0.5# / #MultiScore.0.6#", 2, 1)
		DisplayScores(2, 1, "mp14.score_deadunit_us".."| #MultiScore.1.3# / #MultiScore.1.4#", "mp14.score_deadunit_ijn".."| #MultiScore.1.5# / #MultiScore.1.6#", 2, 1)
		DisplayScores(2, 2, "mp14.score_deadunit_us".."| #MultiScore.2.3# / #MultiScore.2.4#", "mp14.score_deadunit_ijn".."| #MultiScore.2.5# / #MultiScore.2.6#", 2, 1)
		DisplayScores(2, 3, "mp14.score_deadunit_us".."| #MultiScore.3.3# / #MultiScore.3.4#", "mp14.score_deadunit_ijn".."| #MultiScore.3.5# / #MultiScore.3.6#", 2, 1)
		DisplayScores(2, 4, "mp14.score_deadunit_us".."| #MultiScore.4.3# / #MultiScore.4.4#", "mp14.score_deadunit_ijn".."| #MultiScore.4.5# / #MultiScore.4.6#", 2, 1)
		DisplayScores(2, 5, "mp14.score_deadunit_us".."| #MultiScore.5.3# / #MultiScore.5.4#", "mp14.score_deadunit_ijn".."| #MultiScore.5.5# / #MultiScore.5.6#", 2, 1)
		DisplayScores(2, 6, "mp14.score_deadunit_us".."| #MultiScore.6.3# / #MultiScore.6.4#", "mp14.score_deadunit_ijn".."| #MultiScore.6.5# / #MultiScore.6.6#", 2, 1)
		DisplayScores(2, 7, "mp14.score_deadunit_us".."| #MultiScore.7.3# / #MultiScore.7.4#", "mp14.score_deadunit_ijn".."| #MultiScore.7.5# / #MultiScore.7.6#", 2, 1)
	elseif Mission.USCV.Dead and not Mission.JPCV.Dead then
		DisplayScores(2, 0, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.0.5# / #MultiScore.0.6#", 2, 1)
		DisplayScores(2, 1, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.1.5# / #MultiScore.1.6#", 2, 1)
		DisplayScores(2, 2, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.2.5# / #MultiScore.2.6#", 2, 1)
		DisplayScores(2, 3, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.3.5# / #MultiScore.3.6#", 2, 1)
		DisplayScores(2, 4, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.4.5# / #MultiScore.4.6#", 2, 1)
		DisplayScores(2, 5, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.5.5# / #MultiScore.5.6#", 2, 1)
		DisplayScores(2, 6, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.6.5# / #MultiScore.6.6#", 2, 1)
		DisplayScores(2, 7, "mp12.nar_escort_carrierdestroyed", "mp14.score_deadunit_ijn".."| #MultiScore.7.5# / #MultiScore.7.6#", 2, 1)
	elseif not Mission.USCV.Dead and Mission.JPCV.Dead then
		DisplayScores(2, 0, "mp14.score_deadunit_us".."| #MultiScore.0.3# / #MultiScore.0.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 1, "mp14.score_deadunit_us".."| #MultiScore.1.3# / #MultiScore.1.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 2, "mp14.score_deadunit_us".."| #MultiScore.2.3# / #MultiScore.2.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 3, "mp14.score_deadunit_us".."| #MultiScore.3.3# / #MultiScore.3.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 4, "mp14.score_deadunit_us".."| #MultiScore.4.3# / #MultiScore.4.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 5, "mp14.score_deadunit_us".."| #MultiScore.5.3# / #MultiScore.5.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 6, "mp14.score_deadunit_us".."| #MultiScore.6.3# / #MultiScore.6.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 7, "mp14.score_deadunit_us".."| #MultiScore.7.3# / #MultiScore.7.4#", "mp12.nar_escort_carrierdestroyed", 2, 1)
	elseif Mission.USCV.Dead and Mission.JPCV.Dead then
		DisplayScores(2, 0, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 1, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 2, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 3, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 4, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 5, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 6, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
		DisplayScores(2, 7, "mp12.nar_escort_carrierdestroyed", "mp12.nar_escort_carrierdestroyed", 2, 1)
	end
]]

	if Mission.DeadUSShips >= Mission.DeadUSShipsTarget then
		Mission.DeadUSShips = 0
		luaSpawnUSReinf()
	end

	if Mission.DeadJPShips >= Mission.DeadJPShipsTarget then
		Mission.DeadJPShips = 0
		luaSpawnJPReinf()
	end

	luaDelay(luaS14DeadShipCheck, 1)

end

function luaSpawnUSReinf()

	local hqpos = GetPosition(Mission.HQ)
	hqpos.z = hqpos.z + 2000
	local pos = Mission.USCVPos
	pos.y = 200
	local reinf = GenerateObject(Mission.AvengerTemp.Name, pos)
	SetSkillLevel(reinf, SKILL_MPVETERAN)
	PilotMoveToRange(reinf, hqpos, 1000)
	--UnitFreeAttack(reinf)
	SquadronSetTravelAlt(reinf, 500)
	SquadronSetAttackAlt(reinf, 500)
	--SetInvincible(reinf, 1)
	--for i = 0, 7 do
		MissionNarrative("mp14.nar_tinytim")
	--end

	table.insert(Mission.USReinf, reinf)

	local planes = GetSquadronPlanes(reinf)
	for idx,unitID in pairs(planes) do
		local unit = thisTable[tostring(unitID)]
		OverrideHP(unit, 800)
	end

end

function luaSpawnJPReinf()

	local hqpos = GetPosition(Mission.HQ)
	hqpos.z = hqpos.z + 2000
	local pos = Mission.JPCVPos
	pos.y = 200
	local reinf = GenerateObject(Mission.KamikazeTemp.Name, pos)
	SetSkillLevel(reinf, SKILL_MPVETERAN)
	PilotMoveToRange(reinf, hqpos, 1000)
	UnitFreeAttack(reinf)
	SquadronSetTravelAlt(reinf, 200)
	SquadronSetAttackAlt(reinf, 200)
	--SetInvincible(reinf, 1)
	--for i = 0, 7 do
		MissionNarrative("mp14.nar_kamikaze")
	--end

	table.insert(Mission.JPReinf, reinf)

end

function luaS14AIThink()

	Mission.USReinf = luaRemoveDeadsFromTable(Mission.USReinf)
	if table.getn(Mission.USReinf) > 4 then
-- RELEASE_LOGOFF  		luaLog("Tul Sok USReinf van!")
		Kill(Mission.USReinf[1])
		table.remove(Mission.USReinf, 1)
	end

	--Mission.USReinf = luaRemoveDeadsFromTable(Mission.USReinf)

	if table.getn(Mission.USReinf) ~= 0 then
-- RELEASE_LOGOFF  		luaLog("Vannak USReinf-ek!")

		local trgTbl = {}
		trgTbl = luaRemoveDeadsFromTable(Mission.AvengerTrgs)

		if table.getn(trgTbl) == 0 then
			trgTbl = luaRemoveDeadsFromTable(luaSumTablesIndex(recon[PARTY_JAPANESE].own.cruiser, recon[PARTY_JAPANESE].own.destroyer))
		end

		for idx, entity in pairs(Mission.USReinf) do
			if UnitGetAttackTarget(entity) == nil then
-- RELEASE_LOGOFF  				luaLog("USReinf-nek Nincse Targete!")

				if table.getn(trgTbl) > 0 then
					PilotSetTarget(entity, luaPickRnd(trgTbl))
				end

			end
		end
	end

	Mission.JPReinf = luaRemoveDeadsFromTable(Mission.JPReinf)
	if table.getn(Mission.JPReinf) > 4 then
-- RELEASE_LOGOFF  		luaLog("Tul Sok JPReinf Van!")
		Kill(Mission.JPReinf[1])
		table.remove(Mission.JPReinf, 1)
	end
	--Mission.JPReinf = luaRemoveDeadsFromTable(Mission.JPReinf)

	if table.getn(Mission.JPReinf) ~= 0 then

		local trgTbl = {}
		trgTbl = luaRemoveDeadsFromTable(luaSumTablesIndex(recon[PARTY_ALLIED].own.cruiser, recon[PARTY_ALLIED].own.destroyer))

-- RELEASE_LOGOFF  		luaLog("Vannak JPReinf-ek!")


		for idx, entity in pairs(Mission.JPReinf) do
			if UnitGetAttackTarget(entity) == nil then
-- RELEASE_LOGOFF  				luaLog("JPReinf-nek Nincs Targete!")

				if table.getn(trgTbl) > 0 then
					PilotSetTarget(entity, luaPickRnd(trgTbl))
				end

			end
		end
	end

	--luaDelay(luaS14AITHink, 3)

end


function luaS14CheckJapWeights()
	local ships = luaGetShipsAround(Mission.HQ, 3500, "enemy")

	if ships and next(ships) ~= nil then
		local ship = luaSortByDistance2(Mission.HQ, ships, true)

		if ship and not ship.Dead then
			--AISetTargetWeight("SHIP", "MOTHERSHIP", false, 0)
			AISetHintWeight(ship, 1000)
		end
	end

	if not Mission.Completed and not Mission.MissionEnd then
		luaDelay(luaS14CheckJapWeights,20)
	end

end