-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------

Inputs = nil
function luaPrecacheUnits()
	PrepareClass(69)	-- Takao
	PrepareClass(70)	-- Kuma
	PrepareClass(73)	-- Fubuki
	PrepareClass(75)	-- Minekaze
	PrepareClass(23)	-- Fletcher
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort904")
end

function luaInitEscort904(this)
	Mission = this
	Mission.Name = "Battle of the Java Sea"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort01")
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
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "usn02.obj_s1", --Save allied ships from enemy attack!
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj2",
				["Text"] = "usn06.obj_p1", --Prevent the unloading of any Japanese transport ships!
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[3] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj1",
				["Text"] = "usn02.obj_s1", --Save allied ships from enemy attack!
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[4] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj2",
				["Text"] = "ijn03.obj_p3", --Sink the attacking ABDA forces! 
				["TextCompleted"] = "",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
		},
	}
	-- toltes gyorsitas
	
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")
	
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	
	Mission.Stage = 0
	
	Mission.Escape = FindEntity("Java_land")
	
	Mission.ABDASpawn = FindEntity("ABDA Spawn")
	
	Mission.ABDACruisers = {}
		table.insert(Mission.ABDACruisers, FindEntity("De Ruyter"))
		table.insert(Mission.ABDACruisers, FindEntity("Exeter"))
		table.insert(Mission.ABDACruisers, FindEntity("Houston"))
		table.insert(Mission.ABDACruisers, FindEntity("Perth"))
		table.insert(Mission.ABDACruisers, FindEntity("Java"))
		
	Mission.ElectraGroup = {}
		table.insert(Mission.ElectraGroup, FindEntity("Electra"))
		table.insert(Mission.ElectraGroup, FindEntity("Jupiter"))
		table.insert(Mission.ElectraGroup, FindEntity("Encounter"))
		
	Mission.deWithGroup = {}
		table.insert(Mission.deWithGroup, FindEntity("Witte de With"))
		table.insert(Mission.deWithGroup, FindEntity("Kortenaer"))
		
	Mission.EdwardsGroup = {}
		table.insert(Mission.EdwardsGroup, FindEntity("John D. Edwards"))
		table.insert(Mission.EdwardsGroup, FindEntity("Alden"))
		table.insert(Mission.EdwardsGroup, FindEntity("John D. Ford"))
		table.insert(Mission.EdwardsGroup, FindEntity("Paul Jones"))
		
	Mission.ABDACOM = {}
		table.insert(Mission.ABDACOM, FindEntity("De Ruyter"))
		table.insert(Mission.ABDACOM, FindEntity("Exeter"))
		table.insert(Mission.ABDACOM, FindEntity("Houston"))
		table.insert(Mission.ABDACOM, FindEntity("Perth"))
		table.insert(Mission.ABDACOM, FindEntity("Java"))
		table.insert(Mission.ABDACOM, FindEntity("Electra"))
		table.insert(Mission.ABDACOM, FindEntity("Jupiter"))
		table.insert(Mission.ABDACOM, FindEntity("Encounter"))
		table.insert(Mission.ABDACOM, FindEntity("Witte de With"))
		table.insert(Mission.ABDACOM, FindEntity("Kortenaer"))
		table.insert(Mission.ABDACOM, FindEntity("John D. Edwards"))
		table.insert(Mission.ABDACOM, FindEntity("Alden"))
		table.insert(Mission.ABDACOM, FindEntity("John D. Ford"))
		table.insert(Mission.ABDACOM, FindEntity("Paul Jones"))
		
	Mission.ABDAActive = Mission.ABDACOM[1]
	Mission.ShipsAlive = 14

	for idx, unit in pairs (Mission.ABDACOM) do
		RepairEnable(unit, false)
		--hp = unit.Class.HP * 1.25
		--OverrideHP(unit, hp)
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		NavigatorSetAvoidShipCollision(unit, false)
		TorpedoEnable(unit, true)
		NavigatorSetTorpedoEvasion(unit, false)
		--SetShipMaxSpeed(unit, 10.2889)  --20kts	
	end

	local pos1 = {["x"]=0, ["y"] = Mission.ABDACOM[3].Class.Height, ["z"]=0 }	
	Mission.HoustonEfx = Effect("SmallFire", pos1, Mission.ABDACOM[3], 60)
	local pos2 = {["x"]=0, ["y"] = Mission.ABDACOM[5].Class.Height, ["z"]=40 }
	Mission.JavaEfx = Effect("SmallFire", pos2, Mission.ABDACOM[5], 60)
	local pos3 = {["x"]=0, ["y"] = Mission.ABDACOM[6].Class.Height, ["z"]=0 }	
	Mission.ElectraEfx = Effect("SmallFire", pos3, Mission.ABDACOM[6], 60)
	local pos4 = {["x"]=0, ["y"] = Mission.ABDACOM[10].Class.Height, ["z"]=-20 }
	Mission.KortenaerEfx = Effect("SmallFire", pos4, Mission.ABDACOM[10], 60)
	
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, FindEntity("Tokushima Maru"))
		table.insert(Mission.Keyunits, FindEntity("Johore Maru"))
		table.insert(Mission.Keyunits, FindEntity("Morai Maru"))
		table.insert(Mission.Keyunits, FindEntity("Tatsumo Maru"))
		table.insert(Mission.Keyunits, FindEntity("Ryujo Maru"))
		table.insert(Mission.Keyunits, FindEntity("Sakura Maru"))
		
	Mission.JTT = {}
		table.insert(Mission.JTT, FindEntity("Tokushima Maru"))
		table.insert(Mission.JTT, FindEntity("Johore Maru"))
		table.insert(Mission.JTT, FindEntity("Morai Maru"))
		table.insert(Mission.JTT, FindEntity("Tatsumo Maru"))
		table.insert(Mission.JTT, FindEntity("Ryujo Maru"))
		table.insert(Mission.JTT, FindEntity("Sakura Maru"))
	
	Mission.TransportActive = Mission.Keyunits[1]

	for idx, unit in pairs (Mission.Keyunits) do
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		NavigatorSetAvoidShipCollision(unit, false)
		SetShipMaxSpeed(unit, 11.8322)  --23kts	
	end
		
	Mission.IJN = {}
		table.insert(Mission.IJN, FindEntity("Jintsu"))
		table.insert(Mission.IJN, FindEntity("Yukikaze"))
		table.insert(Mission.IJN, FindEntity("Tokitsukaze"))
		table.insert(Mission.IJN, FindEntity("Amatsukaze"))
		table.insert(Mission.IJN, FindEntity("Hatsukaze"))
		
	for idx, unit in pairs (Mission.IJN) do
		RepairEnable(unit, false)
		SetForcedReconLevel(unit, 2, PARTY_ALLIED)
		NavigatorSetAvoidShipCollision(unit, false)
		TorpedoEnable(unit, true)	
	end
	
	Mission.IJNTMP = {}
		table.insert(Mission.IJNTMP, luaFindHidden("Nachi"))
		table.insert(Mission.IJNTMP, luaFindHidden("Haguro"))
		table.insert(Mission.IJNTMP, luaFindHidden("Ushio"))
		table.insert(Mission.IJNTMP, luaFindHidden("Sazanami"))
		table.insert(Mission.IJNTMP, luaFindHidden("Yamakaze"))
		table.insert(Mission.IJNTMP, luaFindHidden("Kawakaze"))
		
		table.insert(Mission.IJNTMP, luaFindHidden("Naka"))
		table.insert(Mission.IJNTMP, luaFindHidden("Murasame"))
		table.insert(Mission.IJNTMP, luaFindHidden("Samidare"))
		table.insert(Mission.IJNTMP, luaFindHidden("Harukaze"))
		table.insert(Mission.IJNTMP, luaFindHidden("Yudachi"))
		table.insert(Mission.IJNTMP, luaFindHidden("Asagumo"))
		table.insert(Mission.IJNTMP, luaFindHidden("Minegumo"))
	
	Mission.IJNSpawns = {}
		table.insert(Mission.IJNSpawns, FindEntity("SpawnPoint IJN Fubuki"))	
		table.insert(Mission.IJNSpawns, FindEntity("SpawnPoint IJN Kuma"))	
		table.insert(Mission.IJNSpawns, FindEntity("SpawnPoint IJN Takao"))	
		
	for j = 4, 7 do
		DeactivateSpawnpoint(Mission.IJNSpawns[2], j)
		DeactivateSpawnpoint(Mission.IJNSpawns[3], j)
	end
		
	Mission.MissionStart = true
	Mission.MissionEnd = false
	this.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	
	--Events
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetThink(this, "luaEscort904_think")
	
	AddWatch(Mission.MissionTime)
	
-- RELEASE_LOGOFF  	AddWatch("Mission.StepCounter")
	
	--ModifyKeyUnitNumber

	Scoring_RealPlayTimeRunning(true)
end
-----------------------------------------------------------------------------------------
--------------------------------THINK----------------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort904_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end
	if this.MissionStart then
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Adding objectives")
-- RELEASE_LOGOFF  		luaLog("")
		-- allied objs
		luaObj_Add("primary", 1, {Mission.ABDACOM[1], Mission.ABDACOM[2], Mission.ABDACOM[3], Mission.ABDACOM[4], Mission.ABDACOM[5], Mission.ABDACOM[6], Mission.ABDACOM[7], Mission.ABDACOM[8], Mission.ABDACOM[9], Mission.ABDACOM[10], Mission.ABDACOM[11], Mission.ABDACOM[12], Mission.ABDACOM[13], Mission.ABDACOM[14]})
		luaObj_Add("primary", 2, {Mission.Keyunits[1], Mission.Keyunits[2], Mission.Keyunits[3], Mission.Keyunits[4], Mission.Keyunits[5], Mission.Keyunits[6]})
		luaObj_AddUnit("primary",2,GetPosition(Mission.Escape))
		-- japanese objs
		luaObj_Add("primary", 3, {Mission.ABDACOM[1], Mission.ABDACOM[2], Mission.ABDACOM[3], Mission.ABDACOM[4], Mission.ABDACOM[5], Mission.ABDACOM[6], Mission.ABDACOM[7], Mission.ABDACOM[8], Mission.ABDACOM[9], Mission.ABDACOM[10], Mission.ABDACOM[11], Mission.ABDACOM[12], Mission.ABDACOM[13], Mission.ABDACOM[14]})
		luaObj_Add("primary", 4, {Mission.Keyunits[1], Mission.Keyunits[2], Mission.Keyunits[3], Mission.Keyunits[4], Mission.Keyunits[5], Mission.Keyunits[6]})
		luaObj_AddUnit("primary",4,GetPosition(Mission.Escape))
		this.MissionStart = false
-- RELEASE_LOGOFF  		luaLog("")
-- RELEASE_LOGOFF  		luaLog("Mission Start false")
-- RELEASE_LOGOFF  		luaLog("")
	end
	Mission.MissionTime = Mission.MissionTime+1 
	
-- objective giving
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end

-- objective watching
	luaTransportActive()
	luaFleetListener()
	luaABDAActive()
	luaABDASpawnPoint()
	luaIJNSpawnPoint()
	luaCheckEndPoint()
	luaMonitorWaves()
	luaDisplayScore()
end

---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaFleetListener()
	if not Mission.MissionEndCalled then
		--CHECK TRANSPORT FLEET
		Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
		local transports = table.getn(Mission.Keyunits)
		if transports == 0 then
			Mission.MissionEndCalled = true
			luaScene904MissionEnd('TransDead')
		end			
	
		--CHECK ABDACOM FLEET
		Mission.ABDACOM = luaRemoveDeadsFromTable(Mission.ABDACOM)
		Mission.ShipsAlive = table.getn(Mission.ABDACOM)
		if Mission.ShipsAlive == 0 then
			Mission.MissionEndCalled = true
			luaScene904MissionEnd('ABDADead')
		end		
	end
end

function luaABDAActive()
	if Mission.ABDAActive.Dead then
		for b = 1, 14 do
			local activeship = false
			if not Mission.ABDACOM[b].Dead and not activeship then
				Mission.ABDAActive = Mission.ABDACOM[b]
				activeship = true
			end
		end
	end
end

function luaABDASpawnPoint()
	local SpawnCoord = GetPosition(Mission.ABDAActive)
	SpawnCoord.x = SpawnCoord.x  + 1000	--horizontal
	SpawnCoord.y = SpawnCoord.y	 		--altitude
	SpawnCoord.z = SpawnCoord.z - 250 	--vertical
	PutTo(Mission.ABDASpawn, SpawnCoord)
	if Mission.Stage > 0 and Mission.Stage < 3 then
		EntityTurnToEntity(Mission.ABDASpawn, Mission.Escape)
	elseif Mission.Stage >= 3 then
		EntityTurnToEntity(Mission.ABDASpawn, Mission.TransportActive)
	end
end

function luaTransportActive()
	local activeship = false
	local ships = luaRemoveDeadsFromTable(Mission.Keyunits)
	if ships ~= nil then
		for idx, unit in pairs (ships) do	
			if not unit.Dead and not activeship then
				Mission.TransportActive = unit
				activeship = true
			end			
		end
	end
end

function luaIJNSpawnPoint()
	local abda = GetPosition(Mission.ABDAActive)
	local trans = GetPosition(Mission.TransportActive)
	if Mission.Stage < 3 then
		abda.x = abda.x - 1000 	--horizontal
		abda.y = abda.y	 		--altitude
		abda.z = abda.z + 3800 	--vertical
		for i = 1, 3 do
			PutTo(Mission.IJNSpawns[i], abda)		
		end
	elseif Mission.Stage >= 3 then
		trans.x = trans.x	+ 1000 	--horizontal
		trans.y = trans.y	 		--altitude
		trans.z = trans.z + 1000 	--vertical		
		for i = 1, 3 do
			PutTo(Mission.IJNSpawns[i], trans)		
		end
	end
end

function luaCheckEndPoint()
	if luaGetDistance(Mission.TransportActive, Mission.Escape) < 300 then
		Mission.MissionEndCalled = true
		luaScene904MissionEnd('TransDest')			
	end		
end

function luaMonitorWaves()
	if not Mission.MissionEndCalled then
		local abda = GetPosition(Mission.ABDAActive)["x"]

		if abda < 6000 and Mission.Stage < 1 then
			Mission.Stage = 1
		elseif abda < 2000 and Mission.Stage < 2 then
			luaSpawnWave(2)
		elseif abda < -2000 and Mission.Stage < 3 then
			luaSpawnWave(3)
		elseif abda < -5000 and Mission.Stage < 4 then
			Mission.Stage = 4
		end
		
		if Mission.Stage >= 1 then
			if Mission.Stage < 3 then
				NavigatorMoveToRange(Mission.ABDAActive, Mission.Escape)
			end
			for idx, unit in pairs (Mission.ElectraGroup) do
				if not unit.Dead then
					local closestenemy = luaGetNearestEnemy(unit)
					if closestenemy ~= nil then
						NavigatorAttackMove(unit, closestenemy, {})
						if not unit.left then
							LeaveFormation(unit)
							unit.left = true
						end
					end
				end
			end	
			for idx, unit in pairs (Mission.IJN) do
				if not unit.Dead then
					NavigatorAttackMove(unit, Mission.ABDAActive, {})
					if not unit.left then
						LeaveFormation(unit)
						unit.left = true
					end
				end
			end			
		end
		
		if Mission.Stage >= 2 then
			for idx, unit in pairs (Mission.EdwardsGroup) do
				if not unit.Dead then
					local closestenemy = luaGetNearestEnemy(unit)
					if closestenemy ~= nil then
						NavigatorAttackMove(unit, closestenemy, {})
						if not unit.left then
							LeaveFormation(unit)
							unit.left = true
						end
					end
				end
			end		
		end

		if Mission.Stage >= 3 then
			for idx, unit in pairs (Mission.deWithGroup) do
				if not unit.Dead then
					NavigatorAttackMove(unit, Mission.TransportActive, {})
					if not unit.left then
						LeaveFormation(unit)
						unit.left = true
					end
				end
			end	
		end
			
		if Mission.Stage >= 4 then
			for idx, unit in pairs (Mission.ABDACruisers) do
				if not unit.Dead then
					NavigatorAttackMove(unit, Mission.TransportActive, {})
					if not unit.left then
						LeaveFormation(unit)
						unit.left = true
					end
				end
			end				
		end	
	end
end

function luaDisplayScore()
	local shipsdestroyed = 14 - Mission.ShipsAlive
	local transalive = table.getn(luaRemoveDeadsFromTable(Mission.Keyunits))
	local transdestroyed = 6 - transalive
	
	DisplayScores(0, 0, "usn02.obj_s1| "..tostring(Mission.ShipsAlive).."/14", "usn06.obj_p1|:| "..tostring(transdestroyed).."/6")
	DisplayScores(0, 1, "usn02.obj_s1| "..tostring(Mission.ShipsAlive).."/14", "usn06.obj_p1|:| "..tostring(transdestroyed).."/6")
	DisplayScores(0, 2, "usn02.obj_s1| "..tostring(Mission.ShipsAlive).."/14", "usn06.obj_p1|:| "..tostring(transdestroyed).."/6")
	DisplayScores(0, 3, "usn02.obj_s1| "..tostring(Mission.ShipsAlive).."/14", "usn06.obj_p1|:| "..tostring(transdestroyed).."/6")
	
	DisplayScores(0, 4, "ijn03.obj_p3".."| "..tostring(shipsdestroyed).."/14", "usn02.obj_s1|:| "..tostring(transalive).."/6")
	DisplayScores(0, 5, "ijn03.obj_p3".."| "..tostring(shipsdestroyed).."/14", "usn02.obj_s1|:| "..tostring(transalive).."/6")
	DisplayScores(0, 6, "ijn03.obj_p3".."| "..tostring(shipsdestroyed).."/14", "usn02.obj_s1|:| "..tostring(transalive).."/6")
	DisplayScores(0, 7, "ijn03.obj_p3".."| "..tostring(shipsdestroyed).."/14", "usn02.obj_s1|:| "..tostring(transalive).."/6")
	
	--DisplayScores(1, 0, "Next upgrade:".."| #MultiScore.0.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	
	--[[DisplayUnitHP(0,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(1,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(2,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(3,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(4,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(5,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(6,Mission.JTT, Mission.TransportActive.Class.Name)
	DisplayUnitHP(7,Mission.JTT, Mission.TransportActive.Class.Name)]]
end

function luaSpawnWave(wave)
	local fleetcoord = GetPosition(Mission.ABDAActive)

	if wave == 2 then
		if Mission.Stage ~= 2 then
			local nachi = GenerateObject(Mission.IJNTMP[1].Name, {["x"] = fleetcoord.x - 2000, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4000})
			luaSetAttrib(nachi)
			local haguro = GenerateObject(Mission.IJNTMP[2].Name, {["x"] = fleetcoord.x - 1900, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4300})
			luaSetAttrib(haguro)
			local ushio = GenerateObject(Mission.IJNTMP[3].Name, {["x"] = fleetcoord.x - 1600, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 3700})
			luaSetAttrib(ushio)
			local sazanami = GenerateObject(Mission.IJNTMP[4].Name, {["x"] = fleetcoord.x - 1600, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4000})
			luaSetAttrib(sazanami)
			local yamakaze = GenerateObject(Mission.IJNTMP[5].Name, {["x"] = fleetcoord.x - 1600, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4300})
			luaSetAttrib(yamakaze)
			local kawakaze = GenerateObject(Mission.IJNTMP[6].Name, {["x"] = fleetcoord.x - 1600, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4600})
			luaSetAttrib(kawakaze)

			for j = 4, 7 do
				DeactivateSpawnpoint(Mission.IJNSpawns[1], j)
				ActivateSpawnpoint(Mission.IJNSpawns[2], j)
			end	
			MissionNarrativeParty(0, "mp06.nar_comp_incoming") --INCOMING!
			MissionNarrativeParty(1, "mp06.nar_comp_incoming") --INCOMING!			
		end
	elseif wave == 3 then
		if Mission.Stage ~= 3 then
			local naka = GenerateObject(Mission.IJNTMP[7].Name, {["x"] = fleetcoord.x - 2000, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4300})
			luaSetAttrib(naka)
			local murasame = GenerateObject(Mission.IJNTMP[8].Name, {["x"] = fleetcoord.x - 1900, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4600})
			luaSetAttrib(murasame)
			local samidare = GenerateObject(Mission.IJNTMP[9].Name, {["x"] = fleetcoord.x - 1950, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4900})
			luaSetAttrib(samidare)
			local harukaze = GenerateObject(Mission.IJNTMP[10].Name, {["x"] = fleetcoord.x - 1950, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 5200})
			luaSetAttrib(harukaze)
			local yudachi = GenerateObject(Mission.IJNTMP[11].Name, {["x"] = fleetcoord.x - 2000, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 5300})
			luaSetAttrib(yudachi)
			local asagumo = GenerateObject(Mission.IJNTMP[12].Name, {["x"] = fleetcoord.x - 2200, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4000})
			luaSetAttrib(asagumo)
			local minegumo = GenerateObject(Mission.IJNTMP[13].Name, {["x"] = fleetcoord.x - 2250, ["y"] = fleetcoord.y, ["z"] = fleetcoord.z + 4600})
			luaSetAttrib(minegumo)
			
			for j = 4, 7 do
				DeactivateSpawnpoint(Mission.IJNSpawns[2], j)
				ActivateSpawnpoint(Mission.IJNSpawns[3], j)
			end
			MissionNarrativeParty(0, "mp06.nar_comp_incoming") --INCOMING!
			MissionNarrativeParty(1, "mp06.nar_comp_incoming") --INCOMING!			
		end
	end
	Mission.Stage = wave
end

function luaSetAttrib(ship)
	table.insert(Mission.IJN, ship)
	RepairEnable(ship, false)
	SetForcedReconLevel(ship, 2, PARTY_ALLIED)
	NavigatorSetAvoidShipCollision(ship, false)
	TorpedoEnable(ship, true)
end

function luaScene904MissionEnd(winner)
--	Scoring_RealPlayTimeRunning(false)	
	if winner == 'ABDADead' then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
	luaMissionCompletedNew(Mission.ABDAActive.LastBanto, "", nil, nil, nil, PARTY_JAPANESE)	
	luaObj_Completed("primary", 3)
	luaObj_Completed("primary", 4)
	luaObj_Failed("primary", 1)		
	luaObj_Failed("primary", 2)		
	Mission.MissionEnd = true		
	elseif winner == 'TransDest' then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
	luaMissionCompletedNew(Mission.TransportActive, "", nil, nil, nil, PARTY_JAPANESE)	
	luaObj_Completed("primary", 3)
	luaObj_Completed("primary", 4)
	luaObj_Failed("primary", 1)		
	luaObj_Failed("primary", 2)		
	Mission.MissionEnd = true	
	elseif winner == 'TransDead' then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
	luaMissionCompletedNew(Mission.TransportActive.LastBanto, "", nil, nil, nil, PARTY_ALLIED)
	luaObj_Completed("primary", 1)
	luaObj_Completed("primary", 2)
	luaObj_Failed("primary", 3)		
	luaObj_Failed("primary", 4)		
	Mission.MissionEnd = true	
	end
end