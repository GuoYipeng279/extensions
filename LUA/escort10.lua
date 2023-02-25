--SceneFile="Missions\Multi\Scene10.scn"

--[[
TODO:
	- lehet hogy ForcedRecon kell a japan CB-knek
	- marker a japan CB-kre
	- nem jelenik meg usa oldalon a marker a Dummy_BB-n, lehet hogy a japan obj felulvagja es leszedi rola?
	+ bunkerek neveit atnevezni editorban hogy egyediek legyenek    
	- problema lehet meg, ha a japoknal az egyik playernek mar nincs HQ-ja es iranyithato unitja, akkor fel tudja hozni a support managert (esetleg spawnpointot kiszedni editorbol)
	- szovegeket atfogalmazni (+ szoveg: PT es kamikaze spawnnal)
	
	+ FPS CHECK -es reszeket megnezni, hogy abban lehet -e a problema a 360 framerate esesben
	
	- bekotni: luaEscort10_BB_AAEnable, luaEscort10_ImprovedRepairStart (luaEscort10_CheckBasesPhase02)
	

	command base-ek kiosztva egyesevel, support managert visszahegeszteni, csak az kapja meg, akinek mar elveszett az adott
	phase-beli hq-ja, vagy ha area-ba er egy us hajo. Ha a shipyard megsemmisult, vagy elert egy area-ba, akkor aktivalodik
	a masodik blokk command base annak a playernek, majd a vegen egy shipyard a japanoknak es abbol DD-ket tud spawnolni.
	Ha szetlottek ezt a shipyardot is, akkor a missiont megnyerte az US oldal.
	
	
	
	Redesign #2
	+ lokalizalni a DisplayUnitHP-t
	+ markert rakni az agyukra (secondary ojj.)
	+ hinteket atirni
	
]]--

-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
	--[[PrepareClass(2)		-- Yorktown-Class carrier
	PrepareClass(15)	-- Iowa
	PrepareClass(45)	-- Kamikaze Zero
	PrepareClass(77)	-- Japanese PT]]--
	PrepareClass(151)	-- Raiden
	PrepareClass(163)	-- Jill	
	PrepareClass(46)	-- Kamikaze Val
	PrepareClass(75)	-- Minekaze
	PrepareClass(102)	-- Corsair	
	PrepareClass(38)	-- Helldiver	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort10")
end

function luaInitEscort10(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "DLC-Escort10_"..dateandtime
-- logolasok
--	DamageLog = true
	Mission.HelperLog = false
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating Escort10")
	-- Loc-Kit dolgok
	Music_Control_SetLevel(MUSIC_CALM)
	
	--globalis konstansok
	this.Multiplayer 										= true
	this.MultiplayerType 								= "Escort"
	this.CompetitiveParty 							= PARTY_ALLIED
	this.ImprovedRepairEffectivity			= 2
	this.DecreasedRepairEffectivity			= 0.5
	this.IowaHP								= 30000
	this.CarrierHP							= 40000
	this.BunkerHP							= 5000
	this.MaxShipyardNum						= 4
	
	
	--this.KamikazeDelayTimeMin					= 20							-- min ennyi ido mulva spawnol scriptbol a kov. kamikaze
	--this.KamikazeDelayTimeMax					= 40							-- max ennyi ido mulva spawnol scriptbol a kov. kamikaze
	--this.HQ_Player1										= {1,1} --{1,1,1}	-- ez tartalmazza, hogy 1 player eseten az adott HQ melyik playerhez tartozik (itt az index, a kiosztaskor kulon tablaba kigyujtott, tablaban levo sorszam)
	--this.HQ_Player2										= {1,2,2,1} --{1,2,2,1,2,1}	-- ez tartalmazza, hogy 2 player eseten az adott HQ melyik playerhez tartozik (itt az index, a kiosztaskor kulon tablaba kigyujtott, tablaban levo sorszam)
	--this.HQ_Player3										= {1,2,1,3,3,2} --{1,2,1,3,3,1,3,2,2}	-- ez tartalmazza, hogy 3 player eseten az adott HQ melyik playerhez tartozik (itt az index, a kiosztaskor kulon tablaba kigyujtott, tablaban levo sorszam)
	--this.HQ_Player4										= {1,2,3,4,3,4,2,1}		--{1,2,3,4,4,2,3,4,2,1,1,3}	-- ez tartalmazza, hogy 4 player eseten az adott HQ melyik playerhez tartozik (itt az index, a kiosztaskor kulon tablaba kigyujtott, tablaban levo sorszam)
	--this.RepairEffectivity						= 1
	--this.ImprovedRepairEffectivityTime = 60		-- ennyi mp-ig javitja magat 2x sebesseggel az Iowa
	--this.MapCenter										= GetPosition(FindEntity("EscortMapCenter"))
	
	--globalis valtozok	
	this.MissionPhase									= 1
	this.ActivateShipyardCheck				= true			-- ez mutatja, hogy aktivalni kell -e a masodik group shipyardot
	this.USMarkers										= {}				-- ebben tarolom hogy melyik objectekre kell highlight US szemszogbol (iowa, HQ-k)
	this.ThinkCounter									= 0
	this.CheckArea01									= true			-- fortressek sulyozasa miatti area check kell -e
	this.FortressWeightCheck					= true			-- kell -e sulyozas visszaallitas miatt checkelni a meg elo fortresseket
	this.ActShipyardNum								= 4	
	
	
	--this.ShipyardActive								= false
	--this.NeedPUCheckPhase01						= false			-- ellenorizni kell -e a Phase01-es powerupot
	--this.PUPhase01										= false			-- megkaptak -e a playerek a phase01 utan a powerupot
	--this.CheckShipyard								= false			-- kell -e vizsgalni meg a PT shipyard szetloveset
	--this.CheckShipyardDD							= false			-- kell -e vizsgalni meg a DD shipyard szetloveset
	--this.PUShipyard										= false
	--this.PUPhase02										= false			-- megkapta -e mar a phase02 utan a powerupot a player
	--this.KamikazeHintEnabled					= true
	--this.PTSPawnPlayerIndex						= {-1, -1, -1, -1}	--ilyen playerindex-u pt-ket kell spawnolni
	--this.PTSpawnAvailable							= false			-- elerheto -e a player spawn a shipyardrol
	--this.PlaneSpawnPlayerIndex				= {-1, -1, -1, -1}	--ilyen playerindex-u repcsiket kell spawnolni
	--this.PlaneSpawnAvailable					= false			-- elerheto -e a player spawn az airfieldrol
	--this.EffectPointer								= {}				-- az effektek pointeret tarolom ebben
	--this.EnableKamikazeScriptSpawn		= true			-- azt tarolja meddig kell scriptbol spawnolni kamikazet
	--this.NeedAreaCheckPhase01					= true			-- kell -e meg csekkolni, hogy valamelyik player atlepte -e a phase01-es areat
	--this.NeedAreaCheckPhase02					= true			-- kell -e meg csekkolni, hogy valamelyik player atlepte -e a phase02-es areat
	--this.AAFixedHint									= false
	--this.ArtilleryFixedHint						= false


	--this.FPSDebug = false	
	NavigatorLandAttackerStop(true)
	
	Mission.Iowa = {}
		table.insert(Mission.Iowa, FindEntity("Escort_Iowa_01"))
	--[[Mission.Path_Iowa = {}
		table.insert(Mission.Path_Iowa, FindEntity("EscortIowaPath"))]]
	Mission.Carrier_Escorts = {}
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Iowa_01"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Iowa_02"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_York"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Atlanta"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Fletcher1"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Fletcher2"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Fletcher3"))
		table.insert(Mission.Carrier_Escorts, FindEntity("Escort_Fletcher4"))
	Mission.Carrier = {}
		table.insert(Mission.Carrier, FindEntity("Escort_Carrier"))
	Mission.Path_Carrier = {}
		table.insert(Mission.Path_Carrier, FindEntity("EscortCarrierPath"))
	for index, unit in pairs (Mission.Carrier_Escorts) do
		JoinFormation(unit, Mission.Carrier[1])
	end	
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, Mission.Path_Carrier[1])
		
	Mission.IJNSpawnPoints = {}
		table.insert(Mission.IJNSpawnPoints, FindEntity("EscortSpawn 04"))	-- Shipyard04 SP
		table.insert(Mission.IJNSpawnPoints, FindEntity("EscortSpawn 03"))	-- Shipyard03 SP
		table.insert(Mission.IJNSpawnPoints, FindEntity("EscortSpawn 02"))	-- Shipyard02 SP
		table.insert(Mission.IJNSpawnPoints, FindEntity("EscortSpawn 01"))	-- Shipyard01 SP

	for h = 2, 4 do
		for i = 4, 7 do
			DeactivateSpawnpoint(Mission.IJNSpawnPoints[h], i)
		end
	end
		
	Mission.IJNAirfieldSpawnPoints = {}
		table.insert(Mission.IJNAirfieldSpawnPoints, FindEntity("AFSpawnPoint"))		-- Airfield01 SP
	
	Mission.USSpawnPoints = {}
		table.insert(Mission.USSpawnPoints, FindEntity("Escort_SpawnPoint 01"))

	Mission.AirfieldHangars = {}
		table.insert(Mission.AirfieldHangars, FindEntity("AFHangar"))
		table.insert(Mission.AirfieldHangars, FindEntity("AirField 01"))
		
	Mission.ShipyardHangars = {}
		table.insert(Mission.ShipyardHangars, FindEntity("EscortShipyardHangar 04"))
		Mission.ShipyardHangars[1].Active = true
		Mission.ShipyardHangars[1].SPNum = 1			--spawnpoint number in SP table
		table.insert(Mission.ShipyardHangars, FindEntity("EscortShipyardHangar 03"))
		Mission.ShipyardHangars[2].Active = true
		Mission.ShipyardHangars[2].SPNum = 2
		table.insert(Mission.ShipyardHangars, FindEntity("EscortShipyardHangar 02"))
		Mission.ShipyardHangars[3].Active = true
		Mission.ShipyardHangars[3].SPNum = 3
		table.insert(Mission.ShipyardHangars, FindEntity("EscortShipyardHangar 01"))
		Mission.ShipyardHangars[4].Active = true
		Mission.ShipyardHangars[4].SPNum = 4
		
	Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("EscortSY 04"))
		table.insert(Mission.Shipyards, FindEntity("EscortSY 03"))
		table.insert(Mission.Shipyards, FindEntity("EscortSY 02"))
		table.insert(Mission.Shipyards, FindEntity("EscortSY 01"))

		
	Mission.Kamikazetmpl = {}
		table.insert(Mission.Kamikazetmpl, luaFindHidden("Escort_KamikazePlayer_01"))		
		table.insert(Mission.Kamikazetmpl, luaFindHidden("Escort_KamikazePlayer_02"))		
		table.insert(Mission.Kamikazetmpl, luaFindHidden("Escort_KamikazePlayer_03"))		
		table.insert(Mission.Kamikazetmpl, luaFindHidden("Escort_KamikazePlayer_04"))
		
	Mission.Kamikazes = {}	
	--Mission.Kamikaze = {}
	
	--[[Mission.NavpointsKamikaze = {}
		table.insert(Mission.NavpointsKamikaze, FindEntity("EscortKamikaze01"))
		table.insert(Mission.NavpointsKamikaze, FindEntity("EscortKamikaze02"))
		table.insert(Mission.NavpointsKamikaze, FindEntity("EscortKamikaze03"))
		table.insert(Mission.NavpointsKamikaze, FindEntity("EscortKamikaze04"))]]--
	--[[Mission.PosNavpointsKamikaze = {}
		table.insert(Mission.PosNavpointsKamikaze, GetPosition(Mission.NavpointsKamikaze[1])["z"])
		table.insert(Mission.PosNavpointsKamikaze, GetPosition(Mission.NavpointsKamikaze[2])["z"])
		table.insert(Mission.PosNavpointsKamikaze, GetPosition(Mission.NavpointsKamikaze[3])["z"])
		table.insert(Mission.PosNavpointsKamikaze, GetPosition(Mission.NavpointsKamikaze[4])["z"])]]--

	--[[Mission.JAPPT = {}
	
	Mission.JAPPlane = {}]]--
	
	Mission.AreaPhases = {}
		table.insert(Mission.AreaPhases, FindEntity("Escort_Area_Phase01"))
		--table.insert(Mission.AreaPhases, FindEntity("Escort_Area_Phase02"))
		--table.insert(Mission.AreaPhases, FindEntity("Escort_Area_Phase03"))
		
	--[[this.LookAtPoints = {}
		table.insert(this.LookAtPoints, FindEntity("Escort - LookTo 1"))	]]--
		
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	--LOGOFF luaLog("  -> Players total: "..Mission.Players)
	
	--Spawnpoints activation
	--japanese
	--[[for i = 1, 2 do
		--SetParty(Mission.ShipyardHangars[i], PARTY_JAPANESE)
		--SetRace(Mission.ShipyardHangars[i], JAPANESE)
		SetParty(Mission.Shipyards[i], PARTY_JAPANESE)
		SetRace(Mission.Shipyards[i], JAPANESE)
		SetParty(Mission.AirfieldHangars[i], PARTY_JAPANESE)
		SetRace(Mission.AirfieldHangars[i], JAPANESE)
		SetInvincible(Mission.AirfieldHangars[i], 1)
	end]]--
	for i, pAirfield in pairs (Mission.AirfieldHangars) do
		SetInvincible(pAirfield, 1)
	end
	
	--[[for i = 1, table.getn(Mission.IJNSpawnPoints) do
		for j = 0, 7 do
			if --[[(i == 1) and]] (j > 3) then
				ActivateSpawnpoint(Mission.IJNSpawnPoints[i], j)
-- RELEASE_LOGOFF  				luaLog("SP aktivalva: SpawnPoint = "..Mission.IJNSpawnPoints[i].Name..", Slot = "..j)
			else 
				DeactivateSpawnpoint(Mission.IJNSpawnPoints[i], j)
-- RELEASE_LOGOFF  				luaLog("SP deaktivalva: SpawnPoint = "..Mission.IJNSpawnPoints[i].Name..", Slot = "..j)
			end
		end
	end]]
	for j = 0, 7 do
		if (j > 3) then
			ActivateSpawnpoint(Mission.IJNAirfieldSpawnPoints[1], j)
-- RELEASE_LOGOFF  			luaLog("SP aktivalva: SpawnPoint = "..Mission.IJNAirfieldSpawnPoints[1].Name..", Slot = "..j)
		else
			DeactivateSpawnpoint(Mission.IJNAirfieldSpawnPoints[1], j)
-- RELEASE_LOGOFF  			luaLog("SP deaktivalva: SpawnPoint = "..Mission.IJNAirfieldSpawnPoints[1].Name..", Slot = "..j)
		end
	end	

	for j = 0, 7 do
		if (j < 4) then
			ActivateSpawnpoint(Mission.USSpawnPoints[1], j)
-- RELEASE_LOGOFF  			luaLog("SP aktivalva: SpawnPoint = "..Mission.USSpawnPoints[1].Name..", Slot = "..j)
		else
			DeactivateSpawnpoint(Mission.USSpawnPoints[1], j)
-- RELEASE_LOGOFF  			luaLog("SP deaktivalva: SpawnPoint = "..Mission.USSpawnPoints[1].Name..", Slot = "..j)
		end
	end
	

-- RELEASE_LOGOFF  	--LOGOFF luaLog("Japan playerek")
	local nJapanPlayers = 0
	for i, pPlayer in pairs (Mission.PlayersTable) do
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Player:")
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pPlayer)
		if (pPlayer["party"] == PARTY_JAPANESE) then
			nJapanPlayers = nJapanPlayers + 1
		end
	end

-- RELEASE_LOGOFF  	--LOGOFF luaLog(nJapanPlayers)
	this.Bunkers = {}
	this.ObjBunkers = {}
	
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 06"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 07"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 12"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01 L02"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02 L02"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 04 L02"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05 L02"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 08 L02"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09 L02"))
		table.insert(this.Bunkers, this.TempBunkers)
		----
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10 L02"))
		table.insert(this.TempBunkers, FindEntity("Fortress element, Large 13 L02"))
		table.insert(this.Bunkers, this.TempBunkers)
	
	--[[this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 01 L01"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 02 L01"))
		table.insert(this.Bunkers, this.TempBunkers)]]--
		
	--[[this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 03 L01"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 04 L01"))
		table.insert(this.Bunkers, this.TempBunkers)]]--
	
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 05 L01"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 06 L01"))
		table.insert(this.Bunkers, this.TempBunkers)
	
	--[[this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 01 L02"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 02 L02"))
		table.insert(this.Bunkers, this.TempBunkers)]]--
		
	--[[this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 03 L02"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 04 L02"))
		table.insert(this.Bunkers, this.TempBunkers)]]--
		
	this.TempBunkers = {}
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 05 L02"))
		table.insert(this.TempBunkers, FindEntity("Huge Battery Open 06 L02"))
		table.insert(this.Bunkers, this.TempBunkers)
	
	
	this.WeightedBunkers = {}
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 07"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 09"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 10"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 12"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 08 L02"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 09 L02"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 10 L02"))
		table.insert(this.WeightedBunkers, FindEntity("Fortress element, Large 13 L02"))
		table.insert(this.WeightedBunkers, FindEntity("Huge Battery Open 05 L01"))
		table.insert(this.WeightedBunkers, FindEntity("Huge Battery Open 06 L01"))
		table.insert(this.WeightedBunkers, FindEntity("Huge Battery Open 05 L02"))
		table.insert(this.WeightedBunkers, FindEntity("Huge Battery Open 06 L02"))
		
	
	--[[if (nJapanPlayers == 4) then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("4 Player jatszik")
			--Mission.HQ_ALL = {}
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L01"))
			--Mission.HQ_ALL[1].Phase = 1
			--Mission.HQ_ALL[1].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02"))
			--table.insert(this.TempBunkers, FindEntity("Fortress element, Large 03"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 02 L01"))
			--Mission.HQ_ALL[2].Phase = 1
			--Mission.HQ_ALL[2].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 04"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L01"))
			--Mission.HQ_ALL[3].Phase = 2
			--Mission.HQ_ALL[3].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 07"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 08"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 04 L01"))
			--Mission.HQ_ALL[4].Phase = 2
			--Mission.HQ_ALL[4].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 12"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 25"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L01"))
			--Mission.HQ_ALL[5].Phase = 3
			--Mission.HQ_ALL[5].State = 0
			--table.insert(this.TempBunkers, FindEntity("Fortress element, Large 19"))
			--table.insert(this.TempBunkers, FindEntity("Fortress element, Large 20"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 01"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 02"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 08 L01"))
			--Mission.HQ_ALL[6].Phase = 3
			--Mission.HQ_ALL[6].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 22"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 23"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 24"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 03"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 04"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L02"))
			--Mission.HQ_ALL[5].Phase = 1
			--Mission.HQ_ALL[5].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 03 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 02 L02"))
			--Mission.HQ_ALL[6].Phase = 1
			--Mission.HQ_ALL[6].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 04 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 06 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L02"))
			--Mission.HQ_ALL[7].Phase = 2
			--Mission.HQ_ALL[7].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 07 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 08 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 04 L02"))
			--Mission.HQ_ALL[8].Phase = 2
			--Mission.HQ_ALL[8].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 11 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 13 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 06 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L02"))
			--Mission.HQ_ALL[11].Phase = 3
			--Mission.HQ_ALL[11].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 18 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 20 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 03 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 04 L02"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 08 L02"))
			--Mission.HQ_ALL[12].Phase = 3
			--Mission.HQ_ALL[12].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 22 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 23 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 24 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 01 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 02 L02"))
			----
	elseif (nJapanPlayers == 3) then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("3 Player jatszik")
		--Mission.HQ_ALL = {}
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L01"))
			--Mission.HQ_ALL[1].Phase = 1
			--Mission.HQ_ALL[1].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 03"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 02 L01"))
			--Mission.HQ_ALL[2].Phase = 1
			--Mission.HQ_ALL[2].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 04"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L01"))
			--Mission.HQ_ALL[3].Phase = 2
			--Mission.HQ_ALL[3].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 07"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 08"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 04 L01"))
			--Mission.HQ_ALL[4].Phase = 2
			--Mission.HQ_ALL[4].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 12"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 25"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L01"))
			--Mission.HQ_ALL[5].Phase = 3
			--Mission.HQ_ALL[5].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 19"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 20"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 01"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 02"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 08 L01"))
			--Mission.HQ_ALL[6].Phase = 3
			--Mission.HQ_ALL[6].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 22"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 23"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 24"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 03"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 04"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L02"))
			--Mission.HQ_ALL[5].Phase = 1
			--Mission.HQ_ALL[5].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 03 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L02"))
			--Mission.HQ_ALL[6].Phase = 2
			--Mission.HQ_ALL[6].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 07 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 08 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L02"))
			--Mission.HQ_ALL[9].Phase = 3
			--Mission.HQ_ALL[9].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 18 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 20 L02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 03 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 04 L02"))
			----
	elseif (nJapanPlayers == 2) then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("2 Player jatszik")
		--Mission.HQ_ALL = {}
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L01"))
			--Mission.HQ_ALL[1].Phase = 1
			--Mission.HQ_ALL[1].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 03"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 02 L01"))
			--Mission.HQ_ALL[2].Phase = 1
			--Mission.HQ_ALL[2].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 04"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 05"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L01"))
			--Mission.HQ_ALL[3].Phase = 2
			--Mission.HQ_ALL[3].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 07"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 08"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 06"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L01"))
			--Mission.HQ_ALL[4].Phase = 3
			--Mission.HQ_ALL[4].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 19"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 20"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 01"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 02"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 08 L01"))
			--Mission.HQ_ALL[5].Phase = 3
			--Mission.HQ_ALL[5].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 22"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 23"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 24"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 03"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 04"))
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 03 L02"))
			--Mission.HQ_ALL[4].Phase = 2
			--Mission.HQ_ALL[4].State = 0
			this.TempBunkers = {}
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 07 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 08 L02"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 09 L02"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05 L02"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
	elseif (nJapanPlayers == 1) then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("1 Player jatszik")
		--Mission.HQ_ALL = {}
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 01 L01"))
			--Mission.HQ_ALL[1].Phase = 1
			--Mission.HQ_ALL[1].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 01"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 02"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 03"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 04 L01"))
			--Mission.HQ_ALL[2].Phase = 2
			--Mission.HQ_ALL[2].State = 0
			this.TempBunkers = {}
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 10"))
			table.insert(this.TempBunkers, FindEntity("Fortress element, Large 12"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 25"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 05"))
			table.insert(this.Bunkers, this.TempBunkers)
			----
			--table.insert(Mission.HQ_ALL, FindEntity("Headquarter 07 L01"))
			--Mission.HQ_ALL[3].Phase = 3
			--Mission.HQ_ALL[3].State = 0
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 19"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 20"))
			--table.insert(this.Bunkers, FindEntity("Fortress element, Large 21"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 01"))
			--table.insert(this.Bunkers, FindEntity("Huge Battery Open 02"))
			----
	end]]--	
	
	for i, pBunker in pairs (Mission.Bunkers) do
		for j = 1, table.getn(pBunker) do
			SetParty(pBunker[j], PARTY_JAPANESE)
			SetRace(pBunker[j], JAPANESE)
			table.insert(Mission.ObjBunkers, pBunker[j])
		end
	end
	
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
				["Text"] = "mp10.obj_escort_p1_text", --"Protect the damaged prototype battleship",
				["TextCompleted"] = "mp10.obj_escort_p1_comp", -- "You have protected the battleship",
				["TextFailed"] = "mp10.obj_escort_p1_fail",
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
				["Text"] = "mp10.obj_escort_p2_text",
				["TextCompleted"] = "mp10.obj_escort_p2_comp",
				["TextFailed"] = "mp10.obj_escort_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
				},
		},
		["secondary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj1",
				["Text"] = "mp10.obj_escort_s1_text", --"Destroy the fortresses",
				["TextCompleted"] = "mp10.obj_escort_s1_comp", -- "You have destroyed all of the fortresses",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
			[2] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "us_sec_obj2",
				["Text"] = "mp10.obj_escort_s2_text", --"Destroy the Iowa",
				["TextCompleted"] = "mp10.obj_escort_s2_comp", -- "You have destroyed the Iowa",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
			},
		},
	}
-- Mission params  
	-- toltes gyorsitas
	
	
		
	
-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(LobbySettings)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("----------")
	
	--[[for i, pHQ in pairs (Mission.HQ_ALL) do
		SetParty(pHQ, PARTY_JAPANESE)
		SetRace(pHQ, JAPANESE)
	end
	for i, pBunkers in pairs (Mission.Bunkers) do
		SetParty(pBunkers, PARTY_JAPANESE)
		SetRace(pBunkers, JAPANESE)
	end]]--
	
	--HQ-k kiosztasa
	--[[local tJapanPlayers = {}
	for i, pPlayer in pairs (Mission.PlayersTable) do
		if (pPlayer["party"] == PARTY_JAPANESE) then
			table.insert(tJapanPlayers, pPlayer)
		end
	end
	local nJapanPlayers = table.getn(tJapanPlayers)
	local tOwner = {}
	if (nJapanPlayers == 1) then
		for i = 1, table.getn(Mission.HQ_Player1) do
			table.insert(tOwner, Mission.HQ_Player1[i])
		end
	elseif (nJapanPlayers == 2) then
		for i = 1, table.getn(Mission.HQ_Player2) do
			table.insert(tOwner, Mission.HQ_Player2[i])
		end
	elseif (nJapanPlayers == 3) then
		for i = 1, table.getn(Mission.HQ_Player3) do
			table.insert(tOwner, Mission.HQ_Player3[i])
		end
	else
		for i = 1, table.getn(Mission.HQ_Player4) do
			table.insert(tOwner, Mission.HQ_Player4[i])
		end
	end
	for i, pHQ in pairs (Mission.HQ_ALL) do
		--if (pHQ.Phase == 1) then
			local nIndex = tOwner[i]
			local nPlayerIndex = tJapanPlayers[nIndex].playerslot
			pHQ.PlayerIndex = nPlayerIndex
			table.insert(Mission.USMarkers, pHQ)
		--end
	end
	luaEscort10_SetCBOwner(1)
	--SetCommandBuildingOwnerPlayer(Mission.Shipyard01[1], 4)
	AISetHintWeight(Mission.Shipyard01[1], 1000)
	SetParty(Mission.Shipyard01[1], PARTY_JAPANESE)
	SetRace(Mission.Shipyard01[1], JAPANESE)]]--
	
	
	----------------
	MultiScore=	{
		[0]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[1]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[2]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[3]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[4]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[5]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[6]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
		[7]= {
			[1] = Mission.MaxShipyardNum,
			[2] = Mission.ActShipyardNum,
		},
	}
	Mission.MissionStart = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0					-- mennyi ido telt el a jatekidobol
	
	--[[if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.MaxShipyardNum
			MultiScore[i][2] = Mission.MaxShipyardNum
		end
	end]]--
	
	--Events
	
	-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaEscort10_think")
	
	Scoring_RealPlayTimeRunning(true)
end

-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaEscort10_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
		return
	end
	if this.MissionEnd then
		return
	end
	Mission.ThinkCounter = Mission.ThinkCounter + 1
	if this.MissionStart then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("")
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Adding objectives")
-- RELEASE_LOGOFF  		--LOGOFF luaLog("")
		-- allied objs
		table.insert(Mission.USMarkers, Mission.Carrier[1])
		--[[for i, pShipyard in pairs (Mission.ShipyardHangars) do
			table.insert(Mission.USMarkers, pShipyard)
		end]]
		for i = 1, table.getn(Mission.ShipyardHangars) do
			table.insert(Mission.USMarkers, Mission.ShipyardHangars[i])
		end
		luaObj_Add("primary", 1, Mission.USMarkers)
		-- japanese objs
		luaObj_Add("primary", 2, Mission.USMarkers)	--Mission.Carrier)
		--luaDelay(luaEscort10_AddSecondary, 4)
		this.MissionStart = false
-- RELEASE_LOGOFF  		--LOGOFF luaLog("")
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Mission Start false")
-- RELEASE_LOGOFF  		--LOGOFF luaLog("")
		--luaDelay(luaEscort10_IowaStartingMessage, 5)
		luaDelay(luaEscort10_InitSecondary, 3)
		luaEscort10_InitUSUnits()
		luaEscort10_InitJapanUnits()
		--luaEscort10_KamikazeManager()
		luaShowStartingHint()
		luaDelay(luaKamikazesquad, 60)
		luaDelay(luaKamikazecontroller, 60)
	end

	luaEscort10_CheckArea01()

	
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
	
	local activesy = 5 - Mission.ActShipyardNum
	if luaGetDistance(Mission.Carrier[1], Mission.Shipyards[activesy]) <= 1000 then
		AISetHintWeight(Mission.ShipyardHangars[activesy], 20)	
	end
	
	--[[if (Mission.MissionPhase == 1) then
		luaEscort10_CheckCB_Phase01()
		luaEscort10_CheckShipyard()
		luaEscort10_PTHintWeigth()
		luaEscort10_CheckPowerUpPhase01()
	elseif (Mission.MissionPhase == 2) then
		luaEscort10_CheckCB_Phase02()
		luaEscort10_CheckShipyardDD()
	end]]--
	
	--luaEscort10_SetHintWeight()
	--luaEscort10_HintManager()
	
	--luaEscort10_CheckCB()
	--luaEscort10_KamikazeHintCheck()
	--luaEscort10_CheckPhaseArea()
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
--[[function luaEscort10_SetHintWeight()
	--local tPos = GetPosition(Mission.NavpointsKamikaze[3])
	local tUS = luaGetShipsAroundCoordinate(Mission.MapCenter, 20000, PARTY_ALLIED, "own", nil, nil, nil)
	if (tUS == nil) then
		tUS = {}
	end
	if (table.getn(tUS) > 0) then
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_SetHintWeight): volt US hajo")
	else
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_SetHintWeight): nem volt US hajo")
	end
	for i, pShip in pairs (tUS) do
		AISetHintWeight(pShip, 100)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_HintManager()
	if (table.getn(Mission.Iowa)>0) and (not Mission.Iowa[1].Dead) then
		local nPosZ = GetPosition(Mission.Iowa[1])["z"]
		local nArea01PosZ = GetPosition(Mission.AreaPhases[1])["z"]
		local nArea03PosZ = GetPosition(Mission.AreaPhases[3])["z"]
		if (not Mission.AAFixedHint) and (nPosZ > nArea01PosZ) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_HintManager): AA Fixed hint")
			Mission.AAFixedHint = true
			AAEnable(Mission.Iowa[1], true)
			ShowHint("ID_Hint_Escort10_AA_Fixed")
		elseif (not Mission.ArtilleryFixedHint) and (nPosZ > nArea03PosZ) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_HintManager): Artillery Fixed hint")
			Mission.ArtilleryFixedHint = true
			ArtilleryEnable(Mission.Iowa[1], true)
			ShowHint("ID_Hint_Escort10_Artillery_Fixed")
		end
	end
end]]--

---------------------------------------------------------------------------------------------
function luaEscort10_InitSecondary()
	Mission.USMarkers = {}
	for i, tBunker in pairs (Mission.Bunkers) do
		for j, pBunker in pairs (tBunker)  do
			table.insert(Mission.USMarkers, pBunker)
		end
	end
	luaObj_Add("secondary", 1, Mission.USMarkers)
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_InitSecondary): sec01 addolva")
	luaObj_Add("secondary", 2, Mission.Iowa)
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_InitSecondary): sec02 addolva")
end

---------------------------------------------------------------------------------------------
function luaShowStartingHint()
	ShowHint("ID_Hint_Escort10")
end

---------------------------------------------------------------------------------------------

--[[function luaEscort10_AddSecondary()
	luaObj_Add("secondary", 1, Mission.HQ_ALL)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_IowaStartingMessage()
	--MissionNarrativeParty(PARTY_ALLIED, "Iowa has got serious damage. The engine and the guns don't work. Start to clean the path until the crew fix it.")
	--ShowHint("ID_Hint_Escort10_Damaged_BB")
	--MissionNarrativeParty(PARTY_JAPANESE, "Looks like the battleship has a problem, it standing in the same position.")
	luaDelay(luaEscort10_CountdownStart, 3)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CountdownStart()
	Countdown("Repairing of Iowa", 0, 120, "luaEscort10_IowaStartingToMove")
end]]--

---------------------------------------------------------------------------------------------
function luaEscort10_InitUSUnits()
	local nSpeed = GetShipMaxSpeed(Mission.Carrier[1])
	SetShipMaxSpeed(Mission.Iowa[1], nSpeed)
	UnitFreeFire(Mission.Iowa[1])
	--[[SetRepairEffectivity(Mission.Iowa[1], Mission.ImprovedRepairEffectivity)
	SetRepairEffectivity(Mission.Carrier[1], Mission.DecreasedRepairEffectivity)]]
	OverrideHP(Mission.Iowa[1], Mission.IowaHP)
	OverrideHP(Mission.Carrier[1], Mission.CarrierHP)
	UnitFreeFire(Mission.Carrier[1])
	--NavigatorMoveOnPath(Mission.Iowa[1], Mission.Path_Iowa[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	NavigatorMoveOnPath(Mission.Carrier[1], Mission.Path_Carrier[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.Carrier[1], "CarrierReachedEndPoint", "luaEscort10_CarrierReachedEndPoint",  luaGetPathPoint(Mission.Path_Carrier[1], "last"), 300)
	for i = 0, 7 do
		DisplayUnitHP(i, Mission.Carrier, "") --"mp10.hint_escort_hp_display")
	end
	AISetHintWeight(Mission.Carrier[1], 20)
	AISetTargetWeight(102, 151, false, 0) -- Corsair vs. Raiden
	AISetTargetWeight(102, 163, false, 0) -- Corsair vs. Jill
	AISetTargetWeight(102, 45, false, 0) -- Corsair vs. Kamikaze Zero
	AISetTargetWeight(38, 151, false, 0) -- Helldiver vs. Raiden
	AISetTargetWeight(38, 163, false, 0) -- Helldiver vs. Jill
	AISetTargetWeight(38, 45, false, 0) -- Helldiver vs. Kamikaze Zero
	if (not IsListenerActive("kill", "Listener_Carrier")) then
		AddListener("kill", "Listener_Carrier", 
		{
				["callback"] = "luaEscort10_Carrier_Destroyed",
				["entity"] = Mission.Carrier,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (not IsListenerActive("kill", "Listener_Iowa")) then
		AddListener("kill", "Listener_Iowa", 
		{
				["callback"] = "luaEscort10_Iowa_Destroyed",
				["entity"] = Mission.Iowa,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

---------------------------------------------------------------------------------------------
function luaEscort10_Carrier_Destroyed(pEntity)
	if (IsListenerActive("kill", "Listener_Carrier")) then
		RemoveListener("kill", "Listener_Carrier")
	end
	luaObj_Failed("primary", 1)
	luaObj_Completed("primary", 2)
	luaDelay(luaMissionEnd_IJN, 3)
	Scoring_RealPlayTimeRunning(false)
end

---------------------------------------------------------------------------------------------
function luaEscort10_Iowa_Destroyed(pEntity)
	if (IsListenerActive("kill", "Listener_Iowa")) then
		RemoveListener("kill", "Listener_Iowa")
	end
	luaObj_Completed("secondary", 2)
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_Iowa_Destroyed): Iowa destroyed, sec02 completed")
end

---------------------------------------------------------------------------------------------
function luaEscort10_CarrierReachedEndPoint(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_CarrierReachedEndPoint): a Carrier elerte a legutolso path pontot")
	if (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
		SetInvincible(Mission.Iowa[1], 1)
	end
	if (table.getn(Mission.Carrier) > 0) and (not Mission.Carrier[1].Dead) then
		SetInvincible(Mission.Carrier[1], 1)
	end
	Mission.MissionEnd = true
	MissionNarrative("mp10.nar_escort_carrier_reached_endpoint")
	luaObj_Failed("primary", 2)
	--luaObj_Completed("secondary", 1)
	luaObj_Completed("primary", 1)
	luaDelay(luaMissionEnd_USN, 3)
	Scoring_RealPlayTimeRunning(false)
end

---------------------------------------------------------------------------------------------
function luaEscort10_InitJapanUnits()
	--[[for i = 1, table.getn(Mission.IJNSpawnPoints) do
		for j = 0, 7 do
			if (i < 4) and (j > 3) then		--a 2. groupbol a shipyardokat meg nem aktivalom senkinek, majd kesobb, a tobbit csak a japanoknak
				ActivateSpawnpoint(Mission.IJNSpawnPoints[i], j)
-- RELEASE_LOGOFF  				luaLog("SP aktivalva: SpawnPoint = "..Mission.IJNSpawnPoints[i].Name..", Slot = "..j)
			else
				DeactivateSpawnpoint(Mission.IJNSpawnPoints[i], j)
-- RELEASE_LOGOFF  				luaLog("SP deaktivalva: SpawnPoint = "..Mission.IJNSpawnPoints[i].Name..", Slot = "..j)
			end
		end
	end]]--
	
	for i, tBunker in pairs (Mission.Bunkers) do
		for j, pBunker in pairs (tBunker) do
			OverrideHP(pBunker, Mission.BunkerHP)
		end
	end
	
	for i, pAirfield in pairs (Mission.AirfieldHangars) do
		AISetHintWeight(pAirfield, 0)
	end
	for i, pShipyard in pairs (Mission.ShipyardHangars) do	--objektiva miatt kell atallitani a sulyozast
		AISetHintWeight(pShipyard, 20)
	end
	--AISetHintWeight(Mission.ShipyardHangars[1], 20)
	
	DisplayScores(1, 0,"mp10.score_shipyard|"..": #MultiScore.0.2# ".."/ #MultiScore.0.1#", "")
	DisplayScores(1, 1,"mp10.score_shipyard|"..": #MultiScore.1.2# ".."/ #MultiScore.1.1#", "")
	DisplayScores(1, 2,"mp10.score_shipyard|"..": #MultiScore.2.2# ".."/ #MultiScore.2.1#", "")
	DisplayScores(1, 3,"mp10.score_shipyard|"..": #MultiScore.3.2# ".."/ #MultiScore.3.1#", "")
	DisplayScores(1, 4,"mp10.score_shipyard|"..": #MultiScore.4.2# ".."/ #MultiScore.4.1#", "")
	DisplayScores(1, 5,"mp10.score_shipyard|"..": #MultiScore.5.2# ".."/ #MultiScore.5.1#", "")
	DisplayScores(1, 6,"mp10.score_shipyard|"..": #MultiScore.6.2# ".."/ #MultiScore.6.1#", "")
	DisplayScores(1, 7,"mp10.score_shipyard|"..": #MultiScore.7.2# ".."/ #MultiScore.7.1#", "")
	
	if (not IsListenerActive("kill", "Listener_Shipyard")) then
		AddListener("kill", "Listener_Shipyard", 
		{
				["callback"] = "luaEscort10_Shipyard_Destroyed",
				["entity"] = Mission.ShipyardHangars,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	if (not IsListenerActive("kill", "Listener_Bunkers")) then
		AddListener("kill", "Listener_Bunkers", 
		{
				["callback"] = "luaEscort10_Bunkers_Destroyed",
				["entity"] = Mission.ObjBunkers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

---------------------------------------------------------------------------------------------
function luaEscort10_Shipyard_Destroyed(pEntity)
	local nIndex = pEntity.SPNum
	for i = 4, 7 do
		DeactivateSpawnpoint(Mission.IJNSpawnPoints[nIndex], i)
-- RELEASE_LOGOFF  		luaLog("(luaEscort10_Shipyard_Destroyed): "..pEntity.Name.." nevu shipyard szetlove, Spawnpointja deaktivalva")
	end
	if nIndex < 4 then
		luaEscort10_ActivateShipyard(pEntity)
	end
	
	Mission.ActShipyardNum = Mission.ActShipyardNum - 1
	for i = 0, 7 do
		MultiScore[i][2] = Mission.ActShipyardNum
	end
	DisplayScores(1, 0,"mp10.score_shipyard|"..": #MultiScore.0.2# ".."/ #MultiScore.0.1#", "")
	DisplayScores(1, 1,"mp10.score_shipyard|"..": #MultiScore.1.2# ".."/ #MultiScore.1.1#", "")
	DisplayScores(1, 2,"mp10.score_shipyard|"..": #MultiScore.2.2# ".."/ #MultiScore.2.1#", "")
	DisplayScores(1, 3,"mp10.score_shipyard|"..": #MultiScore.3.2# ".."/ #MultiScore.3.1#", "")
	DisplayScores(1, 4,"mp10.score_shipyard|"..": #MultiScore.4.2# ".."/ #MultiScore.4.1#", "")
	DisplayScores(1, 5,"mp10.score_shipyard|"..": #MultiScore.5.2# ".."/ #MultiScore.5.1#", "")
	DisplayScores(1, 6,"mp10.score_shipyard|"..": #MultiScore.6.2# ".."/ #MultiScore.6.1#", "")
	DisplayScores(1, 7,"mp10.score_shipyard|"..": #MultiScore.7.2# ".."/ #MultiScore.7.1#", "")
	
	if (pEntity.Active) then --and (Mission.ActivateShipyardCheck)  then
		if (luaObj_IsActive("primary", 1)) and (luaObj_GetSuccess("primary", 1) == nil) and (luaObj_IsActive("primary", 2)) and (luaObj_GetSuccess("primary", 2) == nil) then
			--[[local bBool = false
			local index = 0
			local nLength = table.getn(Mission.IJNSpawnPoints)
			while (index < nLength) and (not bBool) do
				index = index + 1
				if (not Mission.ShipyardHangars[index].Dead) and (not Mission.ShipyardHangars[index].Active) then
					bBool = true
				end
			end
			if (bBool) then
				luaEscort10_ActivateShipyard(Mission.ShipyardHangars[index])
				luaObj_AddUnit("primary", 1, Mission.ShipyardHangars[index])
				luaObj_AddUnit("primary", 2, Mission.ShipyardHangars[index])
				MissionNarrativeParty(PARTY_JAPANESE, "mp10.nar_escort_shipyard_destroyed")
				AISetHintWeight(Mission.ShipyardHangars[index], 20)
			else
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_Shipyard_Destroyed): Nincs tobb HQ")
				luaEscort10_AllHQDestroyed()
			end]]--
			local index = 0
			local nLength = table.getn(Mission.ShipyardHangars)
			local bBool = false
			while (index < nLength) and (not bBool) do
				index = index + 1
				if (not Mission.ShipyardHangars[index].Dead) then
					bBool = true
					AISetHintWeight(Mission.ShipyardHangars[index], 20)
				end
			end
			if (not bBool) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_Shipyard_Destroyed): Nincs tobb HQ")
				luaEscort10_AllHQDestroyed()
			else
				MissionNarrativeParty(PARTY_JAPANESE, "mp10.nar_escort_shipyard_destroyed")
				MissionNarrativeParty(PARTY_ALLIED, "mp10.nar_escort_shipyard_destroyed")
			end
		end
	else
		pEntity.Active = true	--aktivra allitom, hogy kovetkezore mar ne akarja bevalasztani aktiva shipyardnak
	end
end

---------------------------------------------------------------------------------------------
function luaEscort10_Bunkers_Destroyed(pEntity)
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_Bunkers_Destroyed): Egy bunker megmurdalt")
	Mission.ObjBunkers = luaRemoveDeadsFromTable(Mission.ObjBunkers)
	if (table.getn(Mission.ObjBunkers) == 0) then
-- RELEASE_LOGOFF  		luaLog("(luaEscort10_Bunkers_Destroyed): az osszes bunker megsemmisult. sec01 completed.")
		luaObj_Completed("secondary", 1)
		--Mission.FortressWeightCheck = false
		if (IsListenerActive("kill", "Listener_Bunkers")) then
			RemoveListener("kill", "Listener_Bunkers")
		end
	end
end

---------------------------------------------------------------------------------------------
function luaEscort10_AllHQDestroyed()
-- RELEASE_LOGOFF  	luaLog("(luaEscort10_AllHQDestroyed): az osszes japan HQ megsemmisult")
	SetInvincible(Mission.Iowa[1], 1)
	SetInvincible(Mission.Carrier[1], 1)
	Mission.MissionEnd = true
	MissionNarrative("mp10.nar_escort_hq_destroyed")
	luaObj_Failed("primary", 2)
	--luaObj_Completed("secondary", 1)
	luaObj_Completed("primary", 1)
	luaDelay(luaMissionEnd_USN, 3)
	Scoring_RealPlayTimeRunning(false)
end

---------------------------------------------------------------------------------------------
function luaEscort10_CheckArea01()
	if (Mission.CheckArea01) then
		local bBool = false
		local nPosArea01Z = GetPosition(Mission.AreaPhases[1])["z"]
		if (Mission.ShipyardHangars[1].Dead) and (Mission.ShipyardHangars[2].Dead) then
-- RELEASE_LOGOFF  			luaLog("(luaEscort10_CheckArea01): Az elso 2 shipyard megsemmisult")
			bBool = true
		end
		if (not bBool) and (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
			local nPosIowaZ = GetPosition(Mission.Iowa[1])["z"]		-- eleg csak Z-t vizsgalni, mert felfele haladunk a palyan
			if (nPosIowaZ > nPosArea01Z) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_CheckArea01): Az Iowa elerte az area01-et fortresseket sulyozom")
				bBool = true
			end
		end
		if (not bBool) and (table.getn(Mission.Carrier[1]) > 0) and (not Mission.Carrier[1].Dead) then
			local nPosCarrierZ = GetPosition(Mission.Carrier[1])["z"]		-- eleg csak Z-t vizsgalni, mert felfele haladunk a palyan
			if (nPosCarrierZ > nPosArea01Z) then
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_CheckArea01): A carrier elerte az area01-et fortresseket sulyozom")
				bBool = true
			end
		end
		if (bBool) then
			Mission.CheckArea01 = false
			AISetTargetWeight(102, 228, false, 20)
			AISetTargetWeight(102, 65, false, 20)
			for i, pBunker in pairs (Mission.WeightedBunkers) do
-- RELEASE_LOGOFF  				luaLog("(luaEscort10_CheckArea01): "..pBunker.Name.." bunker felsulyozva")
				AISetHintWeight(pBunker, 20)
			end
		end
	end
	Mission.WeightedBunkers = luaRemoveDeadsFromTable(Mission.WeightedBunkers)
	if (Mission.FortressWeightCheck) and (table.getn(Mission.WeightedBunkers) == 0) then
		Mission.FortressWeightCheck = false
-- RELEASE_LOGOFF  		luaLog("(luaEscort10_CheckArea01): Megsemmisult az osszes target bunker, sulyozas visszaallitva")
		AISetTargetWeight(102, 228, false, 0)
		AISetTargetWeight(102, 65, false, 0)
	end
end

---------------------------------------------------------------------------------------------
function luaEscort10_ActivateShipyard(pEntity)
	pEntity.Active = true
	local nIndex = pEntity.SPNum + 1
	for i = 4, 7 do
		ActivateSpawnpoint(Mission.IJNSpawnPoints[nIndex], i)
-- RELEASE_LOGOFF  		luaLog("(luaEscort10_ActivateShipyard): SP aktivalva: SpawnPoint = "..Mission.IJNSpawnPoints[nIndex].Name..", Slot = "..i)
	end
end

---------------------------------------------------------------------------------------------
function luaMissionEnd_IJN()
	if (not TrulyDead(Mission.Iowa[1])) then
		luaMissionCompletedNew(Mission.Carrier[1], "", nil, nil, nil, PARTY_JAPANESE)
	else
		luaMissionCompletedNew(Mission.Carrier[1].LastBanto, "", nil, nil, nil, PARTY_JAPANESE)
	end
	Mission.MissionEnd = true
end

function luaKamikazesquad()
	for i = 1, 4 do
		local unit = GenerateObject(Mission.Kamikazetmpl[i].Name)
		EntityTurnToEntity(unit, Mission.Carrier[1])
		SquadronSetTravelAlt(unit, 1200)
		table.insert(Mission.Kamikazes, unit)
	end
	
	luaDelay(luaKamikazesquad, 120)
	MissionNarrativeParty(PARTY_JAPANESE, "mp.nar_jp_reinf_arrived")
	MissionNarrativeParty(PARTY_ALLIED, "mp.nar_jp_reinf_arrived")
end

function luaKamikazecontroller()
	for index, unit in pairs (Mission.Kamikazes) do
		if not unit.Dead then
			if not Mission.Iowa[1].Dead then
				PilotSetTarget(unit, Mission.Iowa[1])
			elseif not Mission.Carrier[1].Dead then
				PilotSetTarget(unit, Mission.Carrier[1])			
			end
		end
	end
	luaDelay(luaKamikazecontroller, 1)
end

---------------------------------------------------------------------------------------------
--[[function luaEscort10_IowaStartingToMove()
	CountdownCancel()
	for i = 0, 7 do
		DisplayUnitHP(i, Mission.Iowa, "mp10.hint_escort_hp_display")
	end
	--DisplayUnitHP(Mission.Iowa, "Damaged prototype battleship")
	--MissionNarrativeParty(PARTY_ALLIED, "The engine of the prototype battleship has been fixed, but the guns don't work. The Battleship is starting to move.")
	--MissionNarrativeParty(PARTY_JAPANESE, "The Battleship is starting to move. Destroy it!")
	StopEffect(Mission.EffectPointer["Pointer"])
	ShowHint("ID_Hint_Escort10_Engine_Fixed")
	NavigatorMoveOnPath(Mission.Iowa[1], Mission.Path_Iowa[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_SetCBOwner(nPhase)
	for i, pHQ in pairs (Mission.HQ_ALL) do
		if (pHQ.Phase == nPhase) then
			SetCommandBuildingOwnerPlayer(pHQ, pHQ.PlayerIndex)
			AISetHintWeight(pHQ, 1000)
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_KillCB(nPhase)
	for i, pHQ in pairs (Mission.HQ_ALL) do
		if (pHQ.Phase == nPhase) and (pHQ.Party == PARTY_JAPANESE) then
			AddDamage(pHQ, 50000)
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_KamikazeManager()
	if (not Mission.MissionEnd) and (Mission.EnableKamikazeScriptSpawn) and (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
-- RELEASE_LOGOFF  		----LOGOFF luaLog("(luaEscort10_KamikazeManager): Kamikaze Spawnol")
		local szName = ""
		local tUnitTemplate
		local pUnit
		if (Mission.MissionPhase == 2) then
			tUnitTemplate = luaFindHidden("Escort_KamikazeAI_02")
			szName = "Escort_KamikazeAI_02"
		else
			tUnitTemplate = luaFindHidden("Escort_KamikazeAI_01")
			szName = "Escort_KamikazeAI_01"
		end
		pUnit = GenerateObject(tUnitTemplate.Name, szName)
		luaEscort10_KamikazeSpawned(pUnit)
		local nRnd = luaRnd(Mission.KamikazeDelayTimeMin, Mission.KamikazeDelayTimeMax)
		luaDelay(luaEscort10_KamikazeManager, nRnd)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_KamikazeSpawned(pEntity)
	SetRoleAvailable(pEntity, EROLF_ALL, PLAYER_AI)
	--PilotSetTarget(pEntity, Mission.Iowa[1])
	--min kereses a navpointokra es az Iowa-ra
	
	local nIowaPosZ = GetPosition(Mission.Iowa[1])["z"]
	local nRnd
	if (nIowaPosZ > Mission.PosNavpointsKamikaze[4]) then
		nRnd = luaRnd(3,4)
	elseif (nIowaPosZ > Mission.PosNavpointsKamikaze[3]) then
		nRnd = luaRnd(2,4)
	else
		nRnd = luaRnd(1, 3)
	end
	
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_KamikazeSpawned): Kamikaze Navpoint number = "..nRnd)
	PilotMoveTo(pEntity, Mission.NavpointsKamikaze[nRnd])
	AddProximityTrigger(pEntity, "KamikazeNavpoint", "luaEscort10_KamikazeReachedNavpoint", Mission.NavpointsKamikaze[nRnd], 200)
	pEntity.State = nRnd 	-- state: > 0 = megy a navpoint fele, 0 = elerte a navpointot, tamdja az Iowa-t
end]]--

---------------------------------------------------------------------------------------------
--OPTIMALIZALAS miatt lett kiszedve
--[[function luaEscort10_KamikazeDestroyed(pEntity)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_KamikazeDestroyed): Egy kamikaze megsemmisult")
-- RELEASE_LOGOFF  	--LOGOFF luaLog("Remove Trigger Destroyed - Entity State:")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(pEntity.State)
	if (pEntity.State ~= nil) and (pEntity.State > 0) then
		RemoveTrigger(pEntity, "KamikazeNavpoint")
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Trigger remove-olva")
	end
	if (IsListenerActive("kill", "Listener_Kamikaze")) then
		RemoveListener("kill", "Listener_Kamikaze")
	end
	Mission.Kamikaze = luaRemoveDeadsFromTable(Mission.Kamikaze)
	AddListener("kill", "Listener_Kamikaze", 
	{
			["callback"] = "luaEscort10_KamikazeDestroyed",
			["entity"] = Mission.Kamikaze,
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {}
	})
end
]]--
---------------------------------------------------------------------------------------------
--[[function luaEscort10_KamikazeReachedNavpoint(pEntity)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_KamikazeReachedNavpoint): A kamikaze elerte a navpointot")
	pEntity.State = 0
-- RELEASE_LOGOFF  	--LOGOFF luaLog("Remove Trigger Navpoint - Entity State:")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(pEntity.State)
	RemoveTrigger(pEntity, "KamikazeNavpoint")
-- RELEASE_LOGOFF  	--LOGOFF luaLog("Trigger remove-olva")
	if (table.getn(Mission.Iowa)>0) and (not Mission.Iowa[1].Dead) then
		PilotSetTarget(pEntity, Mission.Iowa[1])
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_KamikazeHintCheck()
	--FPS CHECK
	if (not Mission.MissionEnd) and (Mission.KamikazeHintEnabled) and (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
		local tPlanes = luaGetPlanesAroundCoordinate(GetPosition(Mission.Iowa[1]), 3600, PARTY_JAPANESE, "own")
		if (tPlanes ~= nil) and (table.getn(tPlanes) > 0) then
-- RELEASE_LOGOFF  			----LOGOFF luaLog("Van repcsi a kozelben")
			local bMessage = false
			for i, pPlane in pairs (tPlanes) do
				if (not pPlane.Dead) then
					bMessage = true
				else
-- RELEASE_LOGOFF  					----LOGOFF luaLog("a repcsi halott vagy nem kamikaze tipusu")
-- RELEASE_LOGOFF  					----LOGOFF luaLog(pPlane.Type)
				end
			end
			if (bMessage) then
				Mission.KamikazeHintEnabled = false
				MissionNarrativeParty(PARTY_ALLIED, "mp10.nar_escort_kamikaze")	-- "Kamikazes near the Iowa! Shoot them down!"
-- RELEASE_LOGOFF  				--LOGOFF luaLog("(luaEscort10_KamikazeHintEnable): Kamikaze hint disabled. Next hint appears in 60 secs.")
				luaDelay(luaEscort10_KamikazeHintEnable, 60)
			end
		else
-- RELEASE_LOGOFF  			----LOGOFF luaLog("tPlanes tabla nil vagy ures")
		end
	end
end
]]--
---------------------------------------------------------------------------------------------
--[[function luaEscort10_KamikazeHintEnable()
	Mission.KamikazeHintEnabled = true
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_KamikazeHintEnable): Kamikaze hint enabled")
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckPhaseArea()
	if (Mission.NeedAreaCheckPhase01) and (Mission.MissionPhase == 1) then
		local tUSShips = luaGetShipsAroundCoordinate(Mission.MapCenter, 20000, PARTY_ALLIED, "own")
		if (tUSShips == nil) then
			tUSShips = {}
		end
		local bBool = false
		local AreaZ = GetPosition(Mission.AreaPhases[1])["z"]
		for i, pShip in pairs (tUSShips) do
			local PosZ = GetPosition(pShip)["z"]
			if (PosZ > AreaZ) then
				bBool = true
			end
		end
		if (bBool) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckPhaseArea): US unit belepett a Phase01-es area-ba. Phase02 indul.")
			Mission.NeedAreaCheckPhase01 = false
			luaEscort10_StartingPhase02()
		end
	elseif (Mission.NeedAreaCheckPhase02) and (Mission.MissionPhase == 2) then
		local tUSShips = luaGetShipsAroundCoordinate(Mission.MapCenter, 20000, PARTY_ALLIED, "own")
		if (tUSShips == nil) then
			tUSShips = {}
		end
		local bBool = false
		local AreaZ = GetPosition(Mission.AreaPhases[2])["z"]
		for i, pShip in pairs (tUSShips) do
			local PosZ = GetPosition(pShip)["z"]
			if (PosZ > AreaZ) then
				bBool = true
			end
		end
		if (bBool) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckPhaseArea): US unit belepett a Phase02-es area-ba. Phase03 indul.")
			Mission.NeedAreaCheckPhase02 = false
			luaEscort10_StartingPhase03()
		end
	end
end
]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckCB_Phase01()
	if (not Mission.MissionEnd) and (Mission.ThinkCounter > 3) then
		for i, pHQ in pairs (Mission.HQ_ALL) do
			if (pHQ.Phase == 1) and (pHQ.State == 0) then
				local bBool = false
				if (pHQ.Party ~= PARTY_JAPANESE) then
					bBool = true
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckCB_Phase01): egy CB elveszett, aktivalva a PT-s shipyard a kov. playernek = "..pHQ.PlayerIndex)
				else
					local bAllGunDestroyed = true
					local tTemp = Mission.Bunkers[i]
					for j, pGun in pairs (tTemp) do
						if (GetHpPercentage(pGun) > 0.05) then
							bAllGunDestroyed = false
						end
					end
					if (bAllGunDestroyed) then
						bBool = true
						AddDamage(pHQ, 50000)
-- RELEASE_LOGOFF  						--LOGOFF luaLog("(luaEscort10_CheckCB_Phase01): a CB meg ugyan el, de az osszes gun megsemmisult, aktivalva a PT-s shipyard a kov. playernek = "..pHQ.PlayerIndex)
					end
				end
				if (bBool) then
					pHQ.State = 1
					AISetHintWeight(pHQ, 0)
					luaObj_RemoveUnit("primary", 1, pHQ)
					ActivateSpawnpoint(Mission.SpawnPoints[3], pHQ.PlayerIndex)
					if (not Mission.CheckShipyard) then
						Mission.CheckShipyard = true
						Mission.NeedPUCheckPhase01 = true
						AISetHintWeight(Mission.Shipyard01[1], 1000)
						luaObj_AddUnit("primary", 1, Mission.Shipyard01[1])
					end
				end
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckPowerUpPhase01()
	if (Mission.NeedPUCheckPhase01) and (not Mission.PUPhase01) then
		local bBool = false
		for i, pHQ in pairs (Mission.HQ_ALL) do
			if (pHQ.Party == PARTY_JAPANESE) and (pHQ.Phase == 1) then
				bBool = true
			end
		end
		if (not bBool) then
			Mission.PUPhase01 = true
			Mission.NeedPUCheckPhase01 = false
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer["party"] == PARTY_ALLIED) then
					local tPowerUp = {"hardened_armour", "improved_shells"}
					local szPowerUp = luaPickRnd(tPowerUp)
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp09.nar_comp_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckCB): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckBasesPhase02()
	if (Mission.NeedPUCheckPhase01) and (not Mission.PUPhase01) then
	
		local bBool = false
		for i, pHQ in pairs (Mission.HQ_ALL) do
			if (pHQ.Party == PARTY_JAPANESE) and (pHQ.Phase == 2) then
				bBool = true
			end
		end
		if (not bBool) then
			Mission.PUPhase01 = true
			Mission.NeedPUCheckPhase01 = false
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer["party"] == PARTY_ALLIED) then
					local tPowerUp = {"hardened_armour", "improved_shells"}
					local szPowerUp = luaPickRnd(tPowerUp)
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp09.nar_comp_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckCB): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckShipyard()
	if (Mission.CheckShipyard) and (not Mission.PUShipyard) then
-- RELEASE_LOGOFF  		----LOGOFF luaLog("Shipyard party = "..Mission.Shipyard01[1].Party)
		if (Mission.Shipyard01[1].Party ~= PARTY_JAPANESE) then
			Mission.PUShipyard = true
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckShipyard): a Shipyard megsemmisult, tobbet mar nem spawnolhat belole PT")
			AISetHintWeight(Mission.Shipyard01[1], 0)
			luaObj_RemoveUnit("primary", 1, Mission.Shipyard01[1])
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer.party == PARTY_ALLIED) then
					local szPowerUp = "automatic_reloader"
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp09.nar_comp_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckShipyard): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
			Mission.NeedPUCheckPhase01 = false
			luaEscort10_KillCB(1)
			luaEscort10_SetCBOwner(2)
			Mission.MissionPhase = 2
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_PTHintWeigth()
	if (Mission.CheckShipyard) then
		local tPT = luaGetShipsAroundCoordinate(Mission.MapCenter, 20000, PARTY_JAPANESE, "own", nil, nil, nil)
		if (tPT == nil) then
			tPT = {}
		end
		for i, pShip in pairs (tPT) do
			if (pShip.Class.ID == 77) then
				AISetHintWeight(pShip, 0.1)
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckCB_Phase02()
	if (not Mission.MissionEnd) and (Mission.ThinkCounter > 3) then
		for i, pHQ in pairs (Mission.HQ_ALL) do
			if (pHQ.Phase == 2) and (pHQ.State == 0) then
				local bBool = false
				if (pHQ.Party ~= PARTY_JAPANESE) then
					bBool = true
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckCB_Phase02): egy CB elveszett, aktivalva a DD-s shipyard a kov. playernek = "..pHQ.PlayerIndex)
				else
					local bAllGunDestroyed = true
					local tTemp = Mission.Bunkers[i]
					for j, pGun in pairs (tTemp) do
						if (GetHpPercentage(pGun) > 0.05) then
							bAllGunDestroyed = false
						end
					end
					if (bAllGunDestroyed) then
						bBool = true
						AddDamage(pHQ, 50000)
-- RELEASE_LOGOFF  						--LOGOFF luaLog("(luaEscort10_CheckCB_Phase02): a CB meg ugyan el, de az osszes gun megsemmisult, aktivalva a PT-s shipyard a kov. playernek = "..pHQ.PlayerIndex)
					end
				end
				if (bBool) then
					pHQ.State = 1
					AISetHintWeight(pHQ, 0)
					luaObj_RemoveUnit("primary", 1, pHQ)
					ActivateSpawnpoint(Mission.SpawnPoints[4], pHQ.PlayerIndex)
					if (not Mission.CheckShipyardDD) then
						SetParty(Mission.Shipyard02[1], PARTY_JAPANESE)
						SetRace(Mission.Shipyard02[1], PARTY_JAPANESE)
						AISetHintWeight(Mission.Shipyard02[1], 1000)
						luaDelay(luaEscort10_StartingCheckDDShipyard, 2)
					end
				end
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_StartingCheckDDShipyard()
	Mission.CheckShipyardDD = true
	luaObj_AddUnit("primary", 1, Mission.Shipyard02[1])
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckShipyardDD()
	if (Mission.CheckShipyardDD) then
		if (Mission.Shipyard02[1].Party ~= PARTY_JAPANESE) then
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckShipyardDD): a Shipyard megsemmisult, tobbet mar nem spawnolhat belole PT")
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer.party == PARTY_ALLIED) then
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckShipyardDD): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
			luaEscort10_KillCB(2)
			Mission.MissionPhase = 100
			Mission.MissionEnd = true
			luaObj_Failed("primary", 2)
			--luaObj_Completed("secondary", 1)
			luaObj_Completed("primary", 1)
			luaDelay(luaMissionEnd_USN, 3)
			Scoring_RealPlayTimeRunning(false)
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_CheckCB()
	--FPS CHECK
	if (not Mission.MissionEnd) and (Mission.ThinkCounter > 3) then -- and (not Mission.FPSDebug) then
		local bBool = false
		local bPhase01 = false
		local bPhase02 = false
		local bAllBasePhase01 = true
		local bAllBasePhase02 = true
		for i, pHQ in pairs (Mission.HQ_ALL) do
			--LogToConsole("HQ Name = "..pHQ.Name..", Party = "..pHQ.Party)
			if (pHQ.Party == PARTY_JAPANESE) then
				bBool = true
				if (pHQ.Phase == 1) then
					bAllBasePhase01 = false
				elseif (pHQ.Phase == 2) then
					bAllBasePhase02 = false
				end
			else
				--LogToConsole("Nem japan HQ = "..pHQ.Name)
				if (pHQ.Phase == 1) then
					bPhase01 = true
				elseif (pHQ.Phase == 2) then
					bPhase02 = true
				end
			end
		end
		
		--PowerUp Phase01 HQs destroyed
		if (not Mission.PUPhase01) and (bAllBasePhase01) then
			Mission.PUPhase01 = true
			for i, pPlayer in pairs (Mission.PlayersTable) do
				if (pPlayer["party"] == PARTY_ALLIED) then
					local tPowerUp = {"hardened_armour", "improved_shells"}
					local szPowerUp = luaPickRnd(tPowerUp)
					local slotID = pPlayer["playerslot"]
					AddPowerup(slotID, {["classID"] = szPowerUp, ["useLimit"] = 1,})
					MissionNarrativePlayer(slotID, "mp09.nar_comp_supply")
-- RELEASE_LOGOFF  					--LOGOFF luaLog("(luaEscort10_CheckCB): SlotID = "..slotID..", PowerUp = "..szPowerUp)
				end
			end
		end
		if (not Mission.PUPhase02) and (bAllBasePhase02) then
			Mission.PUPhase02 = true
			--MissionNarrativeParty(PARTY_ALLIED, "Iowa got an advanced repair Naval Supply")
			ShowHint("ID_Hint_Escort10_Advanced_Repair")
			luaEscort10_ImprovedRepairStart()
		end
		
		if (bPhase01) and (Mission.MissionPhase == 1) then	-- egy CB-t kilott az 1. blokkbol
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckCB): Semleges lett egy Phase01-es CB. Phase02 indul.")
			Mission.NeedAreaCheckPhase01 = false
			luaEscort10_StartingPhase02()
		end
		if (bPhase02) and (Mission.MissionPhase == 2) then -- egy CB-t kilott a 2. blokkbol
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_CheckCB): Semleges lett egy Phase02-es CB. Phase03 indul.")
			Mission.NeedAreaCheckPhase02 = false
			luaEscort10_StartingPhase03()
		end
		if (not bBool) then
			Mission.MissionEnd = true
			luaObj_Failed("primary", 2)
			--luaObj_Completed("secondary", 1)
			luaObj_Completed("primary", 1)
			luaDelay(luaMissionEnd_USN, 3)
			Scoring_RealPlayTimeRunning(false)
		end
	end
end
]]--
---------------------------------------------------------------------------------------------
--[[function luaEscort10_StartingPhase02()
	Mission.MissionPhase = 2
	luaDelay(luaEscort10_BB_AAEnable, 20)
	Mission.KamikazeDelayTimeMin = 40
	Mission.KamikazeDelayTimeMax = 60
	luaEscort10_ActivateShipyard()
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_StartingPhase03()
	Mission.MissionPhase = 3
	ArtilleryEnable(Mission.Iowa[1], true)
	ShowHint("ID_Hint_Escort10_Artillery_Fixed")
	luaEscort10_ActivateAirfield()
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_BB_AAEnable()
	AAEnable(Mission.Iowa[1], true)
	--MissionNarrativeParty(PARTY_ALLIED, "The crew has fixed the AA guns of the prototype battleship. They starting to repair the artillery guns.")
	ShowHint("ID_Hint_Escort10_AA_Fixed")
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_ImprovedRepairStart()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ImprovedRepairStart): Improved Repair Start")
	SetRepairEffectivity(Mission.Iowa[1], Mission.ImprovedRepairEffectivity)
	luaDelay(luaEscort10_ImprovedRepairEnd, Mission.ImprovedRepairEffectivityTime)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_ImprovedRepairEnd()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ImprovedRepairStart): Improved Repair End")
	SetRepairEffectivity(Mission.Iowa[1], Mission.RepairEffectivity)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_ActivateShipyard()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ActivateShipyard): Shipyard aktivalva a 4-7 playereknek")
	
	--SetParty(Mission.Shipyard01[1], PARTY_JAPANESE)
	--SetRace(Mission.Shipyard01[1], JAPANESE)
	Mission.CheckShipyard = true
	--MissionNarrativeParty(PARTY_JAPANESE, "mp10.nar_escort_shipyard")	-- "A Japanese Patrolboat is available at the shipyard."
	
	Mission.PTSpawnAvailable = true
	local nJapanPlayers = 0
	local nIndex = 0
	for i, pPlayer in pairs (Mission.PlayersTable) do
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Player:")
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pPlayer)
		if (pPlayer["party"] == PARTY_JAPANESE) then
			nJapanPlayers = nJapanPlayers + 1
			nIndex = nIndex + 1
			Mission.PTSPawnPlayerIndex[nIndex] = pPlayer["playerslot"]
		end
	end
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ActivateShipyard): PTSPawnPlayerIndex =")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(Mission.PTSPawnPlayerIndex)
	luaDelay(luaEscort10_PTSpawning_FirstTime, 1, "nAct", "1", "nMax", nJapanPlayers)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_PTSpawning_FirstTime(TimeThis)
	local tPTNames = {"Escort_PT_Player01", "Escort_PT_Player02", "Escort_PT_Player03", "Escort_PT_Player04"}
	local szName = ""
	local tUnitTemplate 
	local pUnit
	local nAct = tonumber(TimeThis.ParamTable.nAct)
	local nMax = tonumber(TimeThis.ParamTable.nMax)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_PTSpawning_FirstTime): nAct")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(nAct)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_PTSpawning_FirstTime): nMax")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(nMax)
	tUnitTemplate = luaFindHidden(tPTNames[nAct])
	szName = tPTNames[nAct]
	pUnit = GenerateObject(tUnitTemplate.Name, szName)
	luaEscort10_JapPTSpawned(pUnit)
	if (nAct < nMax) then
		nAct = nAct + 1
		luaDelay(luaEscort10_PTSpawning_FirstTime, 1, "nAct", nAct, "nMax", nMax)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JapPTSpawned(pEntity)
	local i = 0
	local bBool = false
	Mission.JAPPT = luaRemoveDeadsFromTable(Mission.JAPPT)
	while (i < table.getn(Mission.PTSPawnPlayerIndex)) and (not bBool) do
		i = i + 1
		if (Mission.PTSPawnPlayerIndex[i] > -1) then
			bBool = true
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_JapPTSpawned): PT Spawnolt a kov. playerindexre = "..Mission.PTSPawnPlayerIndex[i])
			SetRoleAvailable(pEntity, EROLF_ALL, Mission.PTSPawnPlayerIndex[i])
			MissionNarrativePlayer(Mission.PTSPawnPlayerIndex[i], "mp10.nar_escort_shipyard")
			table.insert(Mission.JAPPT, pEntity)
			if (IsListenerActive("kill", "Listener_JAPPT")) then
				RemoveListener("kill", "Listener_JAPPT")
			end
			AddListener("kill", "Listener_JAPPT", 
			{
					["callback"] = "luaEscort10_JAPPTKilled",
					["entity"] = Mission.JAPPT,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}
			})
			if (IsListenerActive("exitzone", "Listener_PTExitZone")) then
				RemoveListener("exitzone", "Listener_PTExitZone")
			end
			AddListener("exitzone", "Listener_PTExitZone", { 
				["callback"] = "luaEscort10_JAPPTKilled",  -- callback fuggveny
				["entity"] = Mission.JAPPT, -- entityk akiken a listener aktiv
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
			})
			if (luaEscort10_IsPlayerUnit(Mission.PTSPawnPlayerIndex[i])) and (not Mission.Keyunits[1].Dead) then
				UnitFreeAttack(pEntity)
				NavigatorAttackMove(pEntity, Mission.Keyunits[1], {})
			end
			Mission.PTSPawnPlayerIndex[i] = -1
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_IsPlayerUnit(nSlotIndex)
	local bAI = false
	for i, pPlayer in pairs (Mission.PlayersTable) do
		if (pPlayer["playerslot"] == nSlotIndex) then
			if (pPlayer["ai"] == true) then
				bAI = true
			end
		end
	end
	return bAI
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JAPPTKilled(pEntity)
	local tTempTable = GetRoleAvailable(pEntity)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_JAPPTKilled): RoleTable = ")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(tTempTable)
	Mission.JAPPT = luaRemoveDeadsFromTable(Mission.JAPPT)
	if (tTempTable ~= nil) and (table.getn(tTempTable) > 0) then --ez csak egy biztonsagi ellenorzes, elvileg ilyen nem fordulhat elo, de ki tudja...
		local i = 0
		local bBool = false
		while (i < table.getn(Mission.PTSPawnPlayerIndex)) and (not bBool) do
			i = i + 1
			if (Mission.PTSPawnPlayerIndex[i] == -1) then
				bBool = true
				Mission.PTSPawnPlayerIndex[i] = tTempTable[1]
				luaDelay(luaEscort10_JAPPTSpawning, 3, "nSlotIndex", tostring(tTempTable[1]))
			end
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JAPPTSpawning(TimeThis)
	if (Mission.PTSpawnAvailable) then
		local nSlotIndex = tonumber(TimeThis.ParamTable.nSlotIndex)
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_JAPPTSpawning): PT Spawnol a kov. indexre: "..nSlotIndex)
		local tPTNames = {"Escort_PT_Player01", "Escort_PT_Player02", "Escort_PT_Player03", "Escort_PT_Player04"}
		local szName = ""
		local tUnitTemplate 
		local pUnit
		local szTempName = tPTNames[nSlotIndex - 3]
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_JAPPTSpawning): Template name = "..szTempName)
		tUnitTemplate = luaFindHidden(szTempName)
		szName = szTempName
		pUnit = GenerateObject(tUnitTemplate.Name, szName)
		luaEscort10_JapPTSpawned(pUnit)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_ActivateAirfield()
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ActivateAirfield): Airfield aktivalva a 4-7 playereknek")
	--MissionNarrativeParty(PARTY_JAPANESE, "mp10.nar_escort_airfield")		--A kamikaze sqaudron is available at the airfield.
	if (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
		AddListener("hit", "Listener_IowaHit", {
			["callback"] = "luaEscort10_IowaHit", -- callback fuggveny
			["target"] = Mission.Iowa, -- entityk akiken a listener aktiv
			["targetDevice"] = {}, -- device szukites, csak ezeken valo hitet nezunk
			["attacker"] = {}, -- tamado entityk
			["attackType"] = {}, -- DeviceClasses.lua-ban a "Function" kulcsnal lathato pl "HEAVYARTILLERY" - string
			["attackerPlayerIndex"] = {}, -- PLAYER_1..PLAYER_32
			["damageCaused"] = {}, -- ket ertek kozotti sebzes szures
			["fireCaused"] = {}, -- ket ertek kozotti tuzsebzes szures
			["leakCaused"] = {}, -- ket ertek kozotti viz damage szures
		})
	end
	
	Mission.EnableKamikazeScriptSpawn = false
	Mission.PlaneSpawnAvailable = true
	local nJapanPlayers = 0
	local nIndex = 0
	for i, pPlayer in pairs (Mission.PlayersTable) do
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Player:")
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pPlayer)
		if (pPlayer["party"] == PARTY_JAPANESE) then
			nJapanPlayers = nJapanPlayers + 1
			nIndex = nIndex + 1
			Mission.PlaneSpawnPlayerIndex[nIndex] = pPlayer["playerslot"]
		end
	end
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ActivateAirfield): PlaneSpawnPlayerIndex = ")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(Mission.PlaneSpawnPlayerIndex)
	luaDelay(luaEscort10_PlaneSpawning_FirstTime, 1, "nAct", "1", "nMax", nJapanPlayers)
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_PlaneSpawning_FirstTime(TimeThis)
	local tPlanesNames = {"Escort_KamikazePlayer_01", "Escort_KamikazePlayer_02", "Escort_KamikazePlayer_03", "Escort_KamikazePlayer_04"}
	local szName = ""
	local tUnitTemplate 
	local pUnit
	local nAct = tonumber(TimeThis.ParamTable.nAct)
	local nMax = tonumber(TimeThis.ParamTable.nMax)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_PTSpawning_FirstTime): nAct")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(nAct)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_PTSpawning_FirstTime): nMax")
-- RELEASE_LOGOFF  	--LOGOFF luaLog(nMax)
	tUnitTemplate = luaFindHidden(tPlanesNames[nAct])
	szName = tPlanesNames[nAct]
	pUnit = GenerateObject(tUnitTemplate.Name, szName)
	luaEscort10_JapPlaneSpawned(pUnit)
	if (nAct < nMax) then
		nAct = nAct + 1
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_PlaneSpawning_FirstTime): nAct = "..nAct..", nMax = "..nMax)
		luaDelay(luaEscort10_PlaneSpawning_FirstTime, 1, "nAct", nAct, "nMax", nMax)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JapPlaneSpawned(pEntity)
	local i = 0
	local bBool = false
	Mission.JAPPlane = luaRemoveDeadsFromTable(Mission.JAPPlane)
	while (i < table.getn(Mission.PlaneSpawnPlayerIndex)) and (not bBool) do
		i = i + 1
		if (Mission.PlaneSpawnPlayerIndex[i] > -1) then
			bBool = true
-- RELEASE_LOGOFF  			--LOGOFF luaLog("(luaEscort10_JapPTSpawned): PT Spawnolt a kov. playerindexre = "..Mission.PTSPawnPlayerIndex[i])
			SetRoleAvailable(pEntity, EROLF_ALL, Mission.PlaneSpawnPlayerIndex[i])
			MissionNarrativePlayer(Mission.PlaneSpawnPlayerIndex[i], "mp10.nar_escort_airfield")
			pEntity.PlayerPlane = true
			table.insert(Mission.JAPPlane, pEntity)
			if (IsListenerActive("kill", "Listener_JAPPlane")) then
				RemoveListener("kill", "Listener_JAPPlane")
			end
			AddListener("kill", "Listener_JAPPlane", 
			{
					["callback"] = "luaEscort10_JAPPlaneKilled",
					["entity"] = Mission.JAPPlane,
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {}
			})
			if (IsListenerActive("exitzone", "Listener_PlaneExitZone")) then
				RemoveListener("exitzone", "Listener_PlaneExitZone")
			end
			AddListener("exitzone", "Listener_PlaneExitZone", { 
				["callback"] = "luaEscort10_ExitZone",  -- callback fuggveny
				["entity"] = Mission.JAPPlane, -- entityk akiken a listener aktiv
				["exited"] = {true}, -- kilepes/belepes vizsgalatara true/false
			})
			if (luaEscort10_IsPlayerUnit(Mission.PlaneSpawnPlayerIndex[i])) and (not Mission.Keyunits[1].Dead) then
				PilotSetTarget(pEntity, Mission.Keyunits[1])
			end
			Mission.PlaneSpawnPlayerIndex[i] = -1
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_IowaHit(...)
	if (arg[4] == "KAMIKAZE") then
		local pSquadron = GetPlaneSquadron(arg[3])
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_IowaHit): Kamikaze hit volt")
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pSquadron.Name)
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pSquadron.PlayerPlane)
		if (pSquadron.Hit == nil) and (pSquadron.PlayerPlane ~= nil) then
			pSquadron.Hit = true
			luaDelay(luaEscort10_JAPPlaneKilled, 1)
			--luaLog("(luaEscort10_IowaHit): Name = "..arg[3].Name)
		end
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_ExitZone(pEntity)
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_ExitZone): Repcsi elhagyta a zonat")
	if (pEntity.Exited == nil) then
		pEntity.Exited = true
		luaDelay(luaEscort10_JAPPlaneKilled, 1)
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JAPPlaneKilled(pEntity)
	
	Mission.JAPPlane = luaRemoveDeadsFromTable(Mission.JAPPlane)
	
	local tPlayerIndexes = {}
	for i, pPlayer in pairs (Mission.PlayersTable) do
-- RELEASE_LOGOFF  		--LOGOFF luaLog("Player:")
-- RELEASE_LOGOFF  		--LOGOFF luaLog(pPlayer)
		if (pPlayer["party"] == PARTY_JAPANESE) then
			table.insert(tPlayerIndexes, pPlayer["playerslot"])
		end
	end
	local tJapanPlanes = luaGetPlanesAroundCoordinate(Mission.MapCenter, 20000, PARTY_JAPANESE, "own")
	--luaLog("(luaEscort10_JAPPlaneKilled): PlanesAround = ")
	--luaLog(tJapanPlanes)
	if (tJapanPlanes == nil) then
		tJapanPlanes = {}
	end
	local i = 0
	local bBool = false
	local nPlayerIndex = 0
	while (i < table.getn(tPlayerIndexes)) and (not bBool) do
		i = i + 1
		nPlayerIndex = tPlayerIndexes[i]
		local bIndexExist = false
		for j, pPlane in pairs (tJapanPlanes) do
			local nActIndex = (GetRoleAvailable(pPlane))[1]
			if (nActIndex == nPlayerIndex) then
				bIndexExist = true
			end
		end
		if (not bIndexExist) then
			bBool = true
		end
	end
-- RELEASE_LOGOFF  	--LOGOFF luaLog("(luaEscort10_JAPPlaneKilled): a kov. index-u repcsi nincs = "..nPlayerIndex)
	
	--if (tTempTable ~= nil) and (table.getn(tTempTable) > 0) then --ez csak egy biztonsagi ellenorzes, elvileg ilyen nem fordulhat elo, de ki tudja...
	if (bBool) then
		local i = 0
		bBool2 = false
		while (i < table.getn(Mission.PlaneSpawnPlayerIndex)) and (not bBool2) do
			i = i + 1
			if (Mission.PlaneSpawnPlayerIndex[i] == -1) then
				bBool2 = true
				Mission.PlaneSpawnPlayerIndex[i] = nPlayerIndex
				--luaDelay(luaEscort10_JAPPlaneSpawning, 3, "nSlotIndex", tostring(tTempTable[1]))
			end
		end
		luaDelay(luaEscort10_JAPPlaneSpawning, 3, "nSlotIndex", tostring(nPlayerIndex))
	end
end]]--

---------------------------------------------------------------------------------------------
--[[function luaEscort10_JAPPlaneSpawning(TimeThis)
	if (Mission.PlaneSpawnAvailable) then
		local nSlotIndex = tonumber(TimeThis.ParamTable.nSlotIndex)
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_JAPPTSpawning): PT Spawnol a kov. indexre: "..nSlotIndex)
		local tPlanesNames = {"Escort_KamikazePlayer_01", "Escort_KamikazePlayer_02", "Escort_KamikazePlayer_03", "Escort_KamikazePlayer_04"}
		local szName = ""
		local tUnitTemplate 
		local pUnit
		local szTempName = tPlanesNames[nSlotIndex - 3]
-- RELEASE_LOGOFF  		--LOGOFF luaLog("(luaEscort10_JAPPTSpawning): Template name = "..szTempName)
		tUnitTemplate = luaFindHidden(szTempName)
		szName = szTempName
		pUnit = GenerateObject(tUnitTemplate.Name, szName)
		luaEscort10_JapPlaneSpawned(pUnit)
	end
end]]--

---------------------------------------------------------------------------------------------
function luaMissionEnd_USN()
	luaMissionCompletedNew(Mission.Carrier[1], "", nil, nil, nil, PARTY_ALLIED)
	Mission.MissionEnd = true
end

---------------------------------------------------------------------------------------------
-- Cheat Fv-ek
---------------------------------------------------------------------------------------------
function luaSetCB()
	for i, pHQ in pairs (Mission.HQ_ALL) do
		SetParty(pHQ, PARTY_NEUTRAL)
	end
	--[[for i, pHQ in pairs (Mission.HQ_L02) do
		SetParty(pHQ, PARTY_NEUTRAL)
	end]]--
end

---------------------------------------------------------------------------------------------
function luaPhase01()
	for i, pHQ in pairs (Mission.HQ_ALL) do
		if (pHQ.Phase == 1) then
			AddDamage(pHQ, 50000)
		end
	end
end

---------------------------------------------------------------------------------------------
function luaPhase02()
	for i, pHQ in pairs (Mission.HQ_ALL) do
		if (pHQ.Phase == 2) then
			AddDamage(pHQ, 50000)
		end
	end
end

---------------------------------------------------------------------------------------------
function luaKillShipyard01()
	AddDamage(Mission.Shipyard01[1], 50000)
end

---------------------------------------------------------------------------------------------
function luaKillShipyard02()
	AddDamage(Mission.Shipyard02[1], 50000)
end

---------------------------------------------------------------------------------------------
function luaKillBB()
	Kill(Mission.Iowa[1])
end

---------------------------------------------------------------------------------------------
function luaListHQ()
-- RELEASE_LOGOFF  	LogToConsole("MissionPhase = "..Mission.MissionPhase)
	for i, pHQ in pairs (Mission.HQ_ALL) do
-- RELEASE_LOGOFF  		LogToConsole(pHQ.Name..", Phase = "..pHQ.Phase)
	end
	--[[for i, pHQ in pairs (Mission.HQ_L02) do
-- RELEASE_LOGOFF  		LogToConsole(pHQ.Name..", Phase = "..pHQ.Phase)
	end]]--
end

function luaInvincible()
	SetInvincible(Mission.Iowa[1], 1)
	SetInvincible(Mission.Carrier[1], 1)
end

function luaKillBunkers()
	for i, pBunker in pairs (Mission.ObjBunkers) do
		AddDamage(pBunker, 10000)
	end
end
