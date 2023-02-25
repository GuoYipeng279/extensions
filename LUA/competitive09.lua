--SceneFile="Missions\Multi\Scene9.scn"


--[[
	TODO list:
		+ GetPlanesAroundCoordinate viszonyitasi pontjat beallitani (pl. palya kozepere)
		+ nagyobb legyen a hint weight-je a carrierrol es az airfieldrol felszallo gepeknek (vagy untouchable-ra rakni az ai-nak)
		+ highlighted target kilovesekor nincs hint
		+ kesleltetni a japo pt-k spawnolasat (vagy egy ido utan megszuntetni)
		+ Kikka-k helyett Raidenek
		- esetleg idonkent raketas Raiden spawnoljon
		+ kozepso sziget reconban van
		(- esetleg az osszes cargo kiloveset secondary objective-nek)
		+ a repulokon a highlight bugos? -> megnezni
		+ PowerUpokat rakni be
		+ SpawnPoint teleportkor levizsgalni, hogy a palyan belul maradjon a spawnpoint
		+ highlight ne keruljon mar az oil tankerre, ha tavolabb van tole a player (jap_hq[1]-hez tavolsagot vizsgalni)
		+ a cargokat es a kisereteit atnevezni editorban es scriptben a competitve-nek megfeleloen
		+ szovegeket lokalizalni
		+ missionend-kor endunit-ra a kamera
		+ mission eleji hintet atirni
		+ oil tankerrol leszedni a hintweightet
		(- HellCat bombajat letiltani)
		+ a player spawn pointot lejjebb rakni a bombazoketol, mert a P80-ak kezdeskor belejuk szallnak
		+ secondary objective
		- AISetTargetWeight-tel beallitani unittipusokra a weightet, ha kell
		+ uj B-29-eseknek a HP-jat felvenni vagy armor nagyobb
		(- ha kell, be lehet rakni meg wildcat squadokat, akik a bombazokat kiserik (AI altal iranyitott))
		+ escortos objective nincs hozzaadva + a highlightos objective van akinel failed a vegen -> hogy kell beallitani mission completedkor?
		+ PlayerSpawnPoint-nak a Hellcat wingcount-jat beallitani 3-ra, most 1-en van
		(- AA-kat letiltani scene-ben:
			S01:
				- Heavy AA, CB 01, Heavy AA, CB 02)
			
		
		+ sec ojj: recon listener, hint, narrativa, init, kill listener	- 3 ora)
		+ powerupok, tervezes, implementalas - 2 ora
		+ spawn point teleportkor a palyan belul legyen - 1 ora
		
		
		- luaQAC09_HighlightedPlaneDestroyed()-ben nincs eltavolitva a kill listener, ugyanez az ObjectHighlightnal
		- playerenknek kulon spawn point, mert igy kezdeskor osszeutkoznek
		
		
		
		Meggondolni ebben a missionben, vagy egy kesobbi competitive tervezeskor:
			Elagaztatni a missiont ugy, hogy lenne egy olyan mellekszal, ami konnyebbe teszi az adott kuldetest.
			Ezzel ugyan kevesebb pontot tudnanak osszehozni a jatekosok, de talan a gyengebb playereknek segitseg
			lenne. A hc-k meg eldonthetik hogy a konnyebb vagy a nehezebb utat valasztjak.
			Ebben a missionben pl. az lenne, hogy menne 3 allied sub, ami a carriert tamadna. Ha megsemmisitik, 
			akkor kevesebb gep tamadna a playert, mert a carrier felol mar nem kell szamitani ellenseges repcsikre.
			A subokat azonban a japo pt-k tamadjak, tehat azokat is meg kell semmisitenie a playernek, ezzel supportalja
			a subok tamadasat (ebben az estben azonban valtoztatni kell a pt-k folyamatos utanpotlasan, mert most
			folyamatosan spawnolnak a pt-k).
			Ez azonban a balance-ot megneheziti, mivel 2-re es 8 playeresre is jol kell mukodnie.
	
		
	Allied planes
		(Wildcat,) Corsair, Hellcat
	Japanese planes
		A6M Zero, J2M Raiden
		
--]]

function luaPrecacheUnits()
	--PrepareClass(7) -- South Dakota
	--PrepareClass(21) -- York
	--PrepareClass(37) -- US Cargo
	--PrepareClass(101) -- Wildcat
	--PrepareClass(134) -- Hurricane 
	--PrepareClass(17) -- Atlanta
	--PrepareClass(25) -- Clemson
	--PrepareClass(18) -- Cleveland
	--PrepareClass(20) -- DeRuyter
	--PrepareClass(23) -- Fletcher
	--PrepareClass(41) -- Landin Ship
	--PrepareClass(1) -- Lexington
	--PrepareClass(13) -- New York
	--PrepareClass(19) -- Northampton
	--PrepareClass(27) -- PT Boat
	--PrepareClass(10) -- Renown
	--PrepareClass(36) -- Troop Transport
	--PrepareClass(2) -- Yorktown
	--PrepareClass(133) -- Buffalo
	--PrepareClass(167) -- Betty
	--PrepareClass(32) -- Betty - Ohka
	--PrepareClass(68) -- Tone
	--PrepareClass(61) -- Fuso
	--PrepareClass(50) -- Akagi
	PrepareClass(150) -- Zero
	PrepareClass(151)	-- J2M Raiden
	--PrepareClass(183) -- Ki-205 Kikka
	--PrepareClass(113) -- Avenger

end


------------------------------------------------------------------------------
function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

------------------------------------------------------------------------------
function luaStageInit()
	CreateScript("luaInitQAC09Mission")
end

------------------------------------------------------------------------------
function luaInitQAC09Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp9"..dateandtime

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false
	
	Mission.FPSDebug = false
	--Mission.FPSDebug = true

	SETLOG(this, true)
	--luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()
	
	-- konstansok
	this.CenterCoordinate									= {["x"] = 4100, ["y"] = 0, ["z"] = -800}
	this.Border01Coordinate								= {["x"] = -2306.35, ["y"] = 0, ["z"] = 9448.93}
	this.Border02Coordinate								= {["x"] = 9697.02, ["y"] = 0, ["z"] = -9313.92}
	this.BombersAltitude									= 800			-- a bomberek travelalt-ja, attackalt-ja, releasealt-ja
	this.BombersTravelSpeed								= 35			-- ennyivel mennek a bombazok
	this.DeltaTimeHighlightedPlane				= 200			-- min. ennyi mp mulva highlightolodhat ki a kov. plane
	this.DeltaTimeHighlightedObject				= 90			-- min. ennyi mp mulva highlighotolodhat a kov. target object (AA vagy cargo)
	this.DeltaTimeLastSpawnedPlane				= 30			-- min. ennyi ido mulva spawnolhat a kov. japo plane a carrierrol es az airfieldrol
	this.DeltaTimeLastSpawnedPT						= 60			-- min. ennyi ido mulva spawnolhat a kov. japo PT a shipyardokbol
	this.KillScore												= 100			-- ennyi bonus pontot kap highlighted unit kilovesekor
	this.SpeedOfConvoy										= KTS(22)	-- a Cargo shipek sebessege
	this.PTNumber													= 1				-- Hany PT spawnolhat egyszerre egy areahoz
	this.HP_HQ														= 8000		-- a 2. (airfieldes) HQ-nak a HP-je
	this.DeltaTimeChangeBombersFire				= 10			-- ennyi GameTime utan valtja a bombazok loveset az elozo valtashoz kepest
	this.NumberOfBombersFire							= 3				-- ennyi bombazo lo egyszerre gepfegyverrel

	-- globalis valtozok
	this.Multiplayer 										= true
	this.ThinkCounter 									= 0
	this.MultiplayerType 								= "Competitive"
	this.MultiplayerNumber 							= 9
	this.CompetitiveParty 							= PARTY_ALLIED
	this.Started 												= false
	this.ClosestBomber									= nil			-- ez a spawnpoint teleportalasahoz kell, mindig az utolso bomber moge teleportalom a spawnpointot
	this.BomberActiveTarget							= 1				-- kezdetben a bomberek elso targete az elso JAP HQ
	this.MissionEndCalled								= false		-- ha mar meghivodott a Mission end delay-je, akkor az erteke true lesz
	this.MaxPlanesFromCarrier						= 0				-- maximum hany repcsi lehet a levegoben, ami a japan carrierhez tartozik -> ertekadas a PlayerDetails utan
	this.MaxPlanesFromAirfield					= 0				-- maximum hany repcsi lehet a levegoben, ami a japan airfieldhez tartozik -> ertekadas a PlayerDetails utan
	this.MaxNumberOfBombers							= 0				-- a bomber beallitasoknal toltom fel (InitPlayerUnits)
	this.EnableHighlightedPlane					= false		-- akkor lesz true, ha highlighted unit spawnolhat (ha megsemmisult az elozo)
	this.TimeHighlightedPlane						= 0				-- ennyi GameTime-kor spawnolhat a kov. highlightolt plane
	this.EnableHighlightedObject				= true		-- true, ha highlightolhato bonusz pontert AA, vagy cargo hajo
	this.TimeHighlightedObject					= 0				-- ennyi GameTime-kor jelolheto ki uj hightlightolt unit
	this.TimeLastSpawnedFromCarrier			= 60			-- ennyi GameTime-kor spawnolt a legutolso japo repulo a carrierrol (a kezdo ertek nagyobb legyen, mint indulaskor a GameTime())
	this.TimeLastSpawnedFromAirfield		= 60			-- ennyi GameTime-kor spawnolt a legutolso japo repulo az airfieldrol (a kezdo ertek nagyobb legyen, mint indulaskor a GameTime())
	this.NextTimeChangeBombersFire			= 10			-- ennyi GameTime-kor valtja legkozelebb a bombazok loveset
	this.EnableHintAA										= true		-- ez csak gyorsitasnak van, hogy ha mar nem kell kiirni a hintet, akkor ne szamoljon tavolsagot
	

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- lobby
	--luaLog("----------")
	--luaLog(LobbySettings)
	--luaLog("----------")

	if LobbySettings.TimeLimit == "globals.none" then
		Mission.LobbyCountDown = 0
	elseif LobbySettings.TimeLimit == "globals.5m" then
		Mission.LobbyCountDown = 5 * 60
	elseif LobbySettings.TimeLimit == "globals.10m" then
		Mission.LobbyCountDown = 10 * 60
	elseif LobbySettings.TimeLimit == "globals.15m" then
		Mission.LobbyCountDown = 15 * 60
	elseif LobbySettings.TimeLimit == "globals.20m" then
		Mission.LobbyCountDown = 20 * 60
	elseif LobbySettings.TimeLimit == "globals.25m" then
		Mission.LobbyCountDown = 25 * 60
	elseif LobbySettings.TimeLimit == "globals.30m" then
		Mission.LobbyCountDown = 30 * 60
	else
		--luaLog(" LobbySettings.TimeLimit contains non-handled string | LobbySettings.TimeLimit: "..LobbySettings.TimeLimit)
		Mission.LobbyCountDown = 0
	end

	if Mission.LobbyCountDown == 0 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
		Mission.FourthWarningDone = true
	elseif Mission.LobbyCountDown <= 900 and Mission.LobbyCountDown >= 601 then
		Mission.FirstWarningDone = true
	elseif Mission.LobbyCountDown <= 600 and Mission.LobbyCountDown >= 301 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
	elseif Mission.LobbyCountDown <= 300 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
	end

	if LobbySettings.PointLimit == "globals.none" then
		Mission.PointLimit = 0
	elseif LobbySettings.PointLimit == "500" then
		Mission.PointLimit = 500
	elseif LobbySettings.PointLimit == "1000" then
		Mission.PointLimit = 1000
	elseif LobbySettings.PointLimit == "2000" then
		Mission.PointLimit = 2000
	elseif LobbySettings.PointLimit == "3000" then
		Mission.PointLimit = 3000
	elseif LobbySettings.PointLimit == "4000" then
		Mission.PointLimit = 4000
	elseif LobbySettings.PointLimit == "5000" then
		Mission.PointLimit = 5000
	else
		--luaLog(" LobbySettings.PointLimit contains non-handled string | LobbySettings.PointLimit: "..LobbySettings.PointLimit)
		Mission.PointLimit = 0
	end
	
	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
	--luaLog("-- playertable --")
	--luaLog(Mission.PlayersTable)
	--luaLog("-----------------")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
	--luaLog("  -> Players total: "..Mission.Players)
--[[
	if (Mission.Players < 3) then
		Mission.MaxPlanesFromCarrier = 1
		Mission.MaxPlanesFromAirfield = 1
	elseif (Mission.Players == 3) then
		Mission.MaxPlanesFromCarrier = 2
		Mission.MaxPlanesFromAirfield = 1
	elseif (Mission.Players == 4) then
		Mission.MaxPlanesFromCarrier = 2
		Mission.MaxPlanesFromAirfield = 2
	elseif (Mission.Players == 5) then
		Mission.MaxPlanesFromCarrier = 3
		Mission.MaxPlanesFromAirfield = 2
	elseif (Mission.Players > 5) then
		Mission.MaxPlanesFromCarrier = 3
		Mission.MaxPlanesFromAirfield = 3
	end
]]
	if (Mission.Players < 3) then
		Mission.MaxPlanesFromCarrier = 1
		Mission.MaxPlanesFromAirfield = 1
	elseif (Mission.Players == 3) then
		Mission.MaxPlanesFromCarrier = 1
		Mission.MaxPlanesFromAirfield = 2
	elseif (Mission.Players == 4) then
		Mission.MaxPlanesFromCarrier = 2
		Mission.MaxPlanesFromAirfield = 2
	elseif (Mission.Players == 5) then
		Mission.MaxPlanesFromCarrier = 2
		Mission.MaxPlanesFromAirfield = 3
	elseif (Mission.Players == 6) then
		Mission.MaxPlanesFromCarrier = 3
		Mission.MaxPlanesFromAirfield = 3
	elseif (Mission.Players == 7) then
		Mission.MaxPlanesFromCarrier = 3
		Mission.MaxPlanesFromAirfield = 3
	else
		Mission.MaxPlanesFromCarrier = 3
		Mission.MaxPlanesFromAirfield = 3
	end

	-- mission tablak, valtozok

	-- japan unitok
	
	--debughoz
	--[[if (Mission.FPSDebug) then
		this.Debug_Planes = {}
			table.insert(Mission.Debug_Planes, FindEntity("Comp_A6M Zero 01"))
			table.insert(Mission.Debug_Planes, FindEntity("Comp_A6M Zero 02"))
			table.insert(Mission.Debug_Planes, FindEntity("Comp_A6M Zero 03"))
		for i, pPlane in pairs (Mission.Debug_Planes) do
			AddUntouchableUnit(pPlane)
		end
	end]]--
	--debughoz vege
	
	this.JAP_Hqs = {}
		table.insert(this.JAP_Hqs, FindEntity("DLCS04SHQ Comp"))
		table.insert(this.JAP_Hqs, FindEntity("DLCL06SAHQ Comp"))
		table.insert(this.JAP_Hqs, FindEntity("DLCS02SHQ Comp"))	-- dummy hq
		table.insert(this.JAP_Hqs, FindEntity("DLCL01SHQ Comp"))	-- dummy hq
		--table.insert(this.JAP_Hqs, FindEntity("DLCS01SHQ Comp"))	-- dummy hq
		table.insert(this.JAP_Hqs, FindEntity("DLCL02SHQ B Comp"))	-- dummy hq
		table.insert(this.JAP_Hqs, FindEntity("DLCL04SHQ A Comp"))	-- dummy hq
	
--[[
	this.JAP_Shipyard = {}
		--table.insert(this.JAP_Shipyard, FindEntity("SYS01"))
		--table.insert(this.JAP_Shipyard, FindEntity("SYL01"))
		table.insert(this.JAP_Shipyard, FindEntity("SYS04"))
		table.insert(this.JAP_Shipyard, FindEntity("SYS02"))
		table.insert(this.JAP_Shipyard, FindEntity("SYL06"))
]]
	--[[this.JAP_DummyShipyard = {} -- performancia
		table.insert(this.JAP_DummyShipyard, FindEntity("SYL01"))]]--
--[[
	this.JAP_ShipyardSpawns = {}
		table.insert(this.JAP_ShipyardSpawns, FindEntity("CompSP1SY01S"))
		this.JAP_ShipyardSpawns[1].LastSpawnedTime = -1
		this.JAP_ShipyardSpawns[1].Number = 0]]--
		--[[table.insert(this.JAP_ShipyardSpawns, FindEntity("CompSP1SY01L"))
		table.insert(this.JAP_ShipyardSpawns, FindEntity("CompSP1SY04S"))
		this.JAP_ShipyardSpawns[1].LastSpawnedTime = -1
		this.JAP_ShipyardSpawns[1].Number = 0
		table.insert(this.JAP_ShipyardSpawns, FindEntity("CompSP1SY02S"))
		this.JAP_ShipyardSpawns[2].LastSpawnedTime = -1
		this.JAP_ShipyardSpawns[2].Number = 0
		table.insert(this.JAP_ShipyardSpawns, FindEntity("CompSP1SY01"))
		this.JAP_ShipyardSpawns[3].LastSpawnedTime = -1
		this.JAP_ShipyardSpawns[3].Number = 0
	this.JAP_ShipyardSpawnTimes = {30, 30, 30} --{20, 30, 30, 30}
		
	this.JAP_ShipyardArea = {}
		table.insert(this.JAP_ShipyardArea, FindEntity("CompSYS01Area"))
		--table.insert(this.JAP_ShipyardArea, FindEntity("CompSYL01Area"))
		table.insert(this.JAP_ShipyardArea, FindEntity("CompSYS04Area"))
		table.insert(this.JAP_ShipyardArea, FindEntity("CompSYS02Area"))
		table.insert(this.JAP_ShipyardArea, FindEntity("CompSYL06Area"))
]]
	this.JAP_ShipyardGroup01 = {}
	this.JAP_ShipyardGroup02 = {}
	this.JAP_ShipyardGroup03 = {}
	this.JAP_ShipyardGroup04 = {}
	--this.JAP_ShipyardGroup05 = {}

		
	this.JAP_AAGRP01	= {}
		table.insert(this.JAP_AAGRP01, FindEntity("S04 Heavy AA, CB 01"))
		table.insert(this.JAP_AAGRP01, FindEntity("S04 Heavy AA, CB 02"))
		table.insert(this.JAP_AAGRP01, FindEntity("S04 Heavy AA, CB 03"))
	
	this.JAP_AAGRP02	= {}
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 01"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 02"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 03"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 04"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 05"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 06"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 07"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 08"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 09"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 10"))
		table.insert(this.JAP_AAGRP02, FindEntity("S06 Heavy AA, CB 11"))

	Kill(FindEntity("Huge Battery Open 01"), true)

	this.JAP_DummyAA_L01 = {}
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 01"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 02"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 03"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 04"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 05"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 09"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 10"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 06"))
		table.insert(this.JAP_DummyAA_L01, FindEntity("Heavy AA, CB 08"))

	this.JAP_Carrier = {}
		table.insert(this.JAP_Carrier, FindEntity("Comp_Akagi-class 01"))
	this.JAP_PlanesType = {150, 151}		-- A6M Zero, J2M Raiden
	
	this.JAP_PlanesFromCarrier = {}
	this.JAP_PlanesFromAirfield = {}
	this.JAP_Planes = {}
	
	this.JAP_Airfield = {}
		table.insert(this.JAP_Airfield, FindEntity("AFDLCL06SA"))
	
	this.JAP_SpawnPoints = {}
		table.insert(this.JAP_SpawnPoints, FindEntity("CompIJNCarrierSpawn"))
		table.insert(this.JAP_SpawnPoints, FindEntity("CompSP1AFL06"))
	
	this.JAP_LookAtPoints = {}
		table.insert(this.JAP_LookAtPoints, FindEntity("CompIJNCarrierLookAt"))	-- carrierrol felszallo gepek LookAt-je
		table.insert(this.JAP_LookAtPoints, FindEntity("CompIJNAirfieldLookAt"))	-- airfieldrol felszallo gepek LookAt-je
	
	this.JAP_CarrierPath = {}
		table.insert(this.JAP_CarrierPath, FindEntity("CompIJNCarrierPath"))	

	this.JAP_Minekazes = {}
		table.insert(this.JAP_Minekazes, FindEntity("Comp - Minekaze 1"))
		table.insert(this.JAP_Minekazes, FindEntity("Comp - Minekaze 2"))
		table.insert(this.JAP_Minekazes, FindEntity("Comp - Minekaze 3"))
		table.insert(this.JAP_Minekazes, FindEntity("Comp - Minekaze 4"))
		table.insert(this.JAP_Minekazes, FindEntity("Comp - Minekaze 5"))

	-- player spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("CompetitiveUsPlayerSpawn"))
		--[[table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 5"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 6"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 7"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 8"))]]--
	
	Mission.SlotIDTable = {}	-- TODO: slot ID-t beallitani
		table.insert(Mission.SlotIDTable, 0)
		--[[table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)]]--

	--luaLog("-- start of spawnpoint activation --")
	--[[for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
				--luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end]]--
	--luaLog("-- end of spawnpoint activation --")

	-- event unitok
	this.JAP_EventUnits = {}
		table.insert(this.JAP_EventUnits, FindEntity("Comp_Japan Tanker 01"))
		table.insert(this.JAP_EventUnits, FindEntity("Comp_Japan Tanker 02"))
		table.insert(this.JAP_EventUnits, FindEntity("Comp_Japan Tanker 03"))
		table.insert(this.JAP_EventUnits, FindEntity("Comp_Japan Tanker 04"))
		--table.insert(this.JAP_EventUnits, FindEntity("Comp_Japan Cargo Transport 01")) --performancia
	this.JAP_EventEscort = {}
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 01"))	--netlimit
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 02"))
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 03"))
--[[
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 04"))
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 05"))
		table.insert(this.JAP_EventEscort, FindEntity("Comp_Japanese Patrolboat 06"))
]]
	this.JAP_EventUnitsPath = {}
		table.insert(this.JAP_EventUnitsPath, FindEntity("CompPathTanker01"))
		table.insert(this.JAP_EventUnitsPath, FindEntity("CompPathTanker02"))
		table.insert(this.JAP_EventUnitsPath, FindEntity("CompPathTanker03"))
		table.insert(this.JAP_EventUnitsPath, FindEntity("CompPathTanker04"))
	this.JAP_EventEscortPath = {}
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT01"))
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT02"))
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT03"))
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT04"))
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT05"))
		table.insert(this.JAP_EventEscortPath, FindEntity("CompPathPT06"))
		
	this.JAP_SecondaryUnits = {}
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventUnits[1])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventUnits[2])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventUnits[3])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventUnits[4])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[1])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[2])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[3])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[4])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[5])
		table.insert(Mission.JAP_SecondaryUnits, Mission.JAP_EventEscort[6])

	-- amcsi unitok
	this.US_BomberNavpoints_State01 = {}
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber01_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber02_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber03_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber04_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber05_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber06_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber07_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber08_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber09_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber10_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber11_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber12_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber13_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber14_Navpoint01"))
		table.insert(this.US_BomberNavpoints_State01, FindEntity("CompetitiveUSBomber15_Navpoint01"))
	this.US_BomberNavpoints_State02 = {}
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber01_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber02_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber03_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber04_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber05_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber06_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber07_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber08_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber09_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber10_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber11_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber12_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber13_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber14_Navpoint02"))
		table.insert(this.US_BomberNavpoints_State02, FindEntity("CompetitiveUSBomber15_Navpoint02"))
		

	this.US_Bombers = {}
		table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber01"))
		this.US_Bombers[1].State = 1			-- hanyadik HQ fele megy
		this.US_Bombers[1].Number = 1			-- hanyadik levelbomber (az ennek megfelelo navpoint fele megy)
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber02"))
		this.US_Bombers[2].State = 1
		this.US_Bombers[2].Number = 2
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber03"))
		this.US_Bombers[3].State = 1
		this.US_Bombers[3].Number = 3
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber04"))
		this.US_Bombers[4].State = 1
		this.US_Bombers[4].Number = 4
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber05"))
		this.US_Bombers[5].State = 1
		this.US_Bombers[5].Number = 5
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber06"))
		this.US_Bombers[6].State = 1
		this.US_Bombers[6].Number = 6
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber07"))
		this.US_Bombers[7].State = 1
		this.US_Bombers[7].Number = 7
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber08"))
		this.US_Bombers[8].State = 1
		this.US_Bombers[8].Number = 8
--[[
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber09"))
		this.US_Bombers[9].State = 1
		this.US_Bombers[9].Number = 9
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber10"))
		this.US_Bombers[10].State = 1
		this.US_Bombers[10].Number = 10
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber11"))
		this.US_Bombers[11].State = 1
		this.US_Bombers[11].Number = 11
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber12"))
		this.US_Bombers[12].State = 1
		this.US_Bombers[12].Number = 12
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber13"))
		this.US_Bombers[13].State = 1
		this.US_Bombers[13].Number = 13
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber14"))
		this.US_Bombers[14].State = 1
		this.US_Bombers[14].Number = 14
	table.insert(this.US_Bombers, FindEntity("CompetitiveUSBomber15"))
		this.US_Bombers[15].State = 1
		this.US_Bombers[15].Number = 15
]]
	luaQAC09_InitBombers()
	
	Mission.ClosestBomber = luaQAC09_GetClosestBomber()

	-- amerikai objektumok
	Mission.USHQs = {}
		--[[table.insert(Mission.USHQs, FindEntity("Comp - Command Post 1"))
		AISetHintWeight(Mission.USHQs[1], 25)
		table.insert(Mission.USHQs, FindEntity("Comp - Command Post 2"))
		AISetHintWeight(Mission.USHQs[2], 25)]]--

-------- uj cucc ---------
	Mission.DistanceCheckDisabled = true

	-- unitokat beallitani (ship names, ID, spawnpoint names)

	-- kezdo spawnpos-okat beallitani

	-- path-ok, path indexek
	-- path entry es exit pointok

	-- enemy objektek

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 0,
				["ID"] = "usn_obj_primary_1_player_1",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 1,
				["ID"] = "usn_obj_primary_1_player_2",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 2,
				["ID"] = "usn_obj_primary_1_player_3",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 3,
				["ID"] = "usn_obj_primary_1_player_4",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[5] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 4,
				["ID"] = "usn_obj_primary_1_player_5",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[6] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 5,
				["ID"] = "usn_obj_primary_1_player_6",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[7] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 6,
				["ID"] = "usn_obj_primary_1_player_7",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[8] = {
				["Party"] = PARTY_ALLIED,
				["PlayerIndex"] = 7,
				["ID"] = "usn_obj_primary_1_player_8",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[9] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "usn_obj_primary_2_player_all",
				["Text"] = "mp09.obj_comp_p1_text", --"Escort and defend the level bombers",
				["TextCompleted"] = "mp09.obj_comp_p1_compl", --"You have successfully escorted the level bombers",
				["TextFailed"] = "mp09.obj_comp_p1_fail", --"You have failed to destroy the highlighted units",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "usn_obj_secondary_1_player_all",
				["Text"] = "mp09.obj_comp_s1_text",
				["TextCompleted"] = "mp09.obj_comp_s1_comp",
				["TextFailed"] = "mp09.obj_comp_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	Mission.Digit4 = 8888

	MultiScore =	{
		[0]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
	}

	if Mission.PointLimit == 0 then
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1#", "mp01.score_comp_high".."| #MultiScore.0.5#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1#", "mp01.score_comp_high".."| #MultiScore.1.5#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1#", "mp01.score_comp_high".."| #MultiScore.2.5#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1#", "mp01.score_comp_high".."| #MultiScore.3.5#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1#", "mp01.score_comp_high".."| #MultiScore.4.5#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1#", "mp01.score_comp_high".."| #MultiScore.5.5#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1#", "mp01.score_comp_high".."| #MultiScore.6.5#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1#", "mp01.score_comp_high".."| #MultiScore.7.5#")
	else
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.7#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.7#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.7#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.7#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.7#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.7#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.7#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.7#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.7#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.7#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.7#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.7#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.7#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.7#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.7#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.7#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][7] = Mission.PointLimit
		end
	end

	luaQAC09InitEnemyUnits()
	luaQAC09InitPlayerUnits()

	luaInitNewSystems()

    SetThink(this, "luaQAC09Mission_think")
end

------------------------------------------------------------------------------
function luaQAC09Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
	--luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaQAC09_RemoveDeads()
		luaQAC09CheckMissionEnd()
		--luaQAC09HintManager()
		luaQAC09_TeleportSpawnPoint()
		luaQAC09_Hint_AA()
		luaQAC09_BombersFireManager()
		luaQAC09_CheckBomberTarget()
		--luaQAC09_CheckBombersPayload()
		luaQAC09_PlaneSpawnManager()
		luaQAC09_AttackManager()
		luaQAC09_SelectHighlightedPlane()
		luaQAC09_CheckHighlightedObject()
		--luaQAC09_PTManager() --netlimit
	elseif not Mission.Started then
		Mission.Started = true
		luaQAC09StartMission()
		luaUpdateCounters()
	end
end

------------------------------------------------------------------------------
function luaQAC09StartMission()
	--luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC09MissionEndTimeIsUp")
	end

	luaDelay(luaQAC09AddP1Obj, 5)
	luaDelay(luaQAC09_InitEscortObjective, 10)
	
	--luaQAC09InitEnemyUnits()
	--luaQAC09InitPlayerUnits()
	luaQAC09_InitSecondaryListener()
	
	luaDelay(luaQAC09_CheckJAPAirfield, 120)
end

------------------------------------------------------------------------------
function luaQAC09_InitBombers()
	for i, pBomber in pairs (Mission.US_Bombers) do
		--SetRoleAvailable(pBomber, EROLF_PILOT, PLAYER_AI)
		AAEnable(pBomber, false)
	end
	--luaLog("(luaQAC09_InitBombers): Elvileg a bombazok most nem lonek")
end

------------------------------------------------------------------------------
function luaQAC09_TeleportSpawnPoint()
	Mission.ClosestBomber = luaQAC09_GetClosestBomber()
	if (Mission.ClosestBomber ~= nil) then
		local tPos = GetPosition(Mission.ClosestBomber)
		if (Mission.JAP_Hqs[1].Party == PARTY_JAPANESE) then
			tPos["x"] = tPos["x"] - 400
		else
			tPos["x"] = tPos["x"] + 400
		end
		tPos["z"] = tPos["z"] + 400
		tPos["y"] = Mission.BombersAltitude - 100
		local bOutOfBorder = false
		if (tPos["x"] < Mission.Border01Coordinate["x"]) then
			tPos["x"] = Mission.Border01Coordinate["x"] + 200
			bOutOfBorder = true
		elseif (tPos["x"] > Mission.Border02Coordinate["x"]) then
			tPos["x"] = Mission.Border02Coordinate["x"] - 200
			bOutOfBorder = true
		end
		if (tPos["z"] > Mission.Border01Coordinate["z"]) then
			tPos["z"] = Mission.Border01Coordinate["z"] - 200
			bOutOfBorder = true
		elseif (tPos["z"] < Mission.Border02Coordinate["z"]) then
			tPos["z"] = Mission.Border02Coordinate["z"] + 200
			bOutOfBorder = true
		end
		if (bOutOfBorder) then
			--luaLog("(luaQAC09_TeleportSpawnPoint): Borderen kivulre volt a spawn, beljebb raktam")
		end
		PutTo(Mission.SpawnPoints[1], tPos)
		EntityTurnToPosition(Mission.SpawnPoints[1], GetPosition(Mission.ClosestBomber))
		--local tPos = {["x"] = 400, ["y"] = 0, ["z"] = -400}
		--PutRelTo(Mission.SpawnPoints[1], Mission.ClosestBomber, tPos)
	end
end

------------------------------------------------------------------------------
function luaQAC09_GetClosestBomber()
	Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
	local pClosestBomber = nil
	local nMinDistance = 100000
	for i, pPlane in pairs (Mission.US_Bombers) do
		local nActDistance = luaGetDistance(pPlane, Mission.SpawnPoints[1])
		if (nActDistance < nMinDistance) then
			nMinDistance = nActDistance
			pClosestBomber = pPlane
		end
	end
	return pClosestBomber
end

------------------------------------------------------------------------------
function luaQAC09_Hint_AA()
	if (Mission.EnableHintAA) then
		local pClosestBomber = luaQAC09_GetClosestBomber()
		local bBool = false
		if pClosestBomber ~= nil then
			if (Mission.JAP_Hqs[1].Party == PARTY_JAPANESE) and (table.getn(Mission.JAP_AAGRP01) > 0) then
				local nDistance = luaGetDistance(pClosestBomber, Mission.JAP_Hqs[1])
				if (nDistance < 2800) then
					bBool = true
				end
			elseif (Mission.JAP_Hqs[2].Party == PARTY_JAPANESE) and (table.getn(Mission.JAP_AAGRP02) > 0) then
				local nDistance = luaGetDistance(pClosestBomber, Mission.JAP_Hqs[2])
				if (nDistance < 2800) then
					bBool = true
				end
			end
		end
		if (bBool) then
			Mission.EnableHintAA = false
			ShowHint("ID_Hint_Competitive09_AA")
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09InitEnemyUnits()
	-- Party beallitasok
	for i, pHQ in pairs (Mission.JAP_Hqs) do
		RepairEnable(pHQ, false)
		SetParty(pHQ, PARTY_JAPANESE)
		SetRace(pHQ, JAPANESE)
		if (i > 1) then
			SetSkillLevel(pHQ, SKILL_STUN)
		end
		AAEnable(pHQ, false)
	end
	OverrideHP(Mission.JAP_Hqs[2], Mission.HP_HQ)
	for i, pAA in pairs (Mission.JAP_AAGRP01) do
		SetParty(pAA, PARTY_JAPANESE)
		SetRace(pAA, JAPANESE)
	end
	local tTemp = {}
	for i, pAA in pairs (Mission.JAP_AAGRP02) do
		SetParty(pAA, PARTY_JAPANESE)
		SetRace(pAA, JAPANESE)
		SetSkillLevel(pAA, SKILL_SPNORMAL)
		table.insert(tTemp, pAA)
	end
	for i = 1, 4 do
		local pAA = luaPickRnd(tTemp)
		local j = 0
		local nLength = table.getn(tTemp)
		local bBool = false
		while (j < nLength) and (not bBool) do
			j = j + 1
			if (pAA.Name == tTemp[j].Name) then
				bBool = true
			end
		end
		SetSkillLevel(pAA, SKILL_STUN)
		table.remove(tTemp, j)
		--luaLog("(luaQAC09InitEnemyUnits): AA STUN SKILL = "..pAA.Name)
	end
	-- performancia miatt csak a 2-es SYS01 lesz japan
--[[
	for i, pShipyard in pairs (Mission.JAP_Shipyard) do
		SetParty(pShipyard, PARTY_JAPANESE)
		SetRace(pShipyard, JAPANESE)
	end
]]
--[[
	SetParty(Mission.JAP_Shipyard[2], PARTY_JAPANESE)
	SetRace(Mission.JAP_Shipyard[2], JAPANESE)
]]
	for i, pAA in pairs (Mission.JAP_DummyAA_L01) do
		SetParty(pAA, PARTY_JAPANESE)
		SetSkillLevel(pAA, SKILL_STUN)
	end
	
	--Dummy shipyard -> performancia
	--[[for i, pShipyard in pairs (Mission.JAP_DummyShipyard) do
		SetParty(pShipyard, PARTY_JAPANESE)
		SetRace(pShipyard, JAPANESE)
	end]]--
	
	luaDelay(luaQAC09_EnableHighlightedPlane, 60)
	SetParty(Mission.JAP_Airfield[1], PARTY_JAPANESE)
	SetRace(Mission.JAP_Airfield[1], JAPANESE)
	-- unitok path-on mozgatasa
	-- carrier
	NavigatorMoveOnPath(Mission.JAP_Carrier[1], Mission.JAP_CarrierPath[1], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	-- tanker hajok es kisereteik
	for i, pUnit in pairs (Mission.JAP_EventUnits) do
		SetShipMaxSpeed(pUnit, Mission.SpeedOfConvoy)
	end
	for i, pUnit in pairs (Mission.JAP_EventEscort) do
		SetShipMaxSpeed(pUnit, Mission.SpeedOfConvoy)
	end
	NavigatorMoveOnPath(Mission.JAP_EventUnits[1], Mission.JAP_EventUnitsPath[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventUnits[1], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventUnitsPath[1], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventUnits[2], Mission.JAP_EventUnitsPath[2], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventUnits[2], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventUnitsPath[2], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventUnits[3], Mission.JAP_EventUnitsPath[3], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventUnits[3], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventUnitsPath[3], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventUnits[4], Mission.JAP_EventUnitsPath[4], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventUnits[4], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventUnitsPath[4], "last"), 300)
	--luaLog(Mission.JAP_EventEscort[1])
	--luaLog(Mission.JAP_EventEscortPath[1])
	NavigatorMoveOnPath(Mission.JAP_EventEscort[1], Mission.JAP_EventEscortPath[1], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[1], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[1], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventEscort[2], Mission.JAP_EventEscortPath[2], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[2], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[2], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventEscort[3], Mission.JAP_EventEscortPath[3], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[3], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[3], "last"), 300)
	--netlimit
--[[
	NavigatorMoveOnPath(Mission.JAP_EventEscort[4], Mission.JAP_EventEscortPath[4], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[4], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[4], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventEscort[5], Mission.JAP_EventEscortPath[5], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[5], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[5], "last"), 300)
	NavigatorMoveOnPath(Mission.JAP_EventEscort[6], Mission.JAP_EventEscortPath[6], PATH_FM_SIMPLE, PATH_SM_BEGIN)
	AddProximityTrigger(Mission.JAP_EventEscort[6], "TankersAndEscortReachedEndPoint", "luaQAC09_TankersAndEscortReachedEndPoint",  luaGetPathPoint(Mission.JAP_EventEscortPath[6], "last"), 300)
]]
	-- PT-k kispawnolnak az area-khoz

--[[
	Kill(FindEntity("PTHangar DLCS04S"), true)
	Kill(FindEntity("PTHangar DLCS02S"), true)
	Kill(FindEntity("PTHangar S06S"), true)
	for index, unit in pairs (Mission.JAP_Shipyard) do
		Kill(unit, true)
	end
]]
end

------------------------------------------------------------------------------
function luaQAC09_TankersAndEscortReachedEndPoint(pEntity)
	--luaLog("(luaQAC09_TankersAndEscortReachedEndPoint): Tanker vagy escort elerte a path veget: "..pEntity.Name)
	RemoveTrigger(pEntity, "TankersAndEscortReachedEndPoint")
	Kill(pEntity, true)
	Mission.JAP_EventUnits = luaRemoveDeadsFromTable(Mission.JAP_EventUnits)
	Mission.JAP_EventEscort = luaRemoveDeadsFromTable(Mission.JAP_EventEscort)
	if (luaObj_IsActive("secondary", 1) and (luaObj_GetSuccess("secondary", 1) == nil)) then
		luaObj_Failed("secondary", 1)
	end
	
	Mission.JAP_Minekazes = luaRemoveDeadsFromTable(Mission.JAP_Minekazes)
	for index, unit in pairs (Mission.JAP_Minekazes) do
		ArtilleryEnable(unit, true)
		AAEnable(unit, true)
	end
end

------------------------------------------------------------------------------
function luaQAC09InitPlayerUnits()
	-- Bomberek elinditasa
	--luaLog("----InitPlayerUnits---")
	for i, pPlane in pairs (Mission.US_Bombers) do
		Mission.MaxNumberOfBombers = Mission.MaxNumberOfBombers + 1
		--luaLog("Plane name = "..pPlane.Name)
		local tPos = GetPosition(pPlane)
		tPos["y"] = Mission.BombersAltitude
		PutTo(pPlane, tPos)
		local pTargetPos = GetPosition(Mission.US_BomberNavpoints_State01[pPlane.Number])
		--luaLog("Number = "..i)
		PilotMoveTo(pPlane, pTargetPos)
		AddProximityTrigger(pPlane, "BomberReachedNavpoint", "luaQAC09_BomberReachedNavpoint", pTargetPos, 200)
		EntityTurnToPosition(pPlane, pTargetPos)
		SquadronSetTravelAlt(pPlane, Mission.BombersAltitude)
		SquadronSetAttackAlt(pPlane, Mission.BombersAltitude)
		SquadronSetReleaseAlt(pPlane, Mission.BombersAltitude)
		SquadronSetTravelSpeed(pPlane, Mission.BombersTravelSpeed)
		SetSkillLevel(pPlane, SKILL_ELITE)
	end
	--luaLog("(luaQAC09InitPlayerUnits): Bomberek Max Szama = "..Mission.MaxNumberOfBombers)
	if (not IsListenerActive("kill", "Listener_BombersDestroyed")) then
		AddListener("kill", "Listener_BombersDestroyed", 
		{
				["callback"] = "luaQAC09_BombersDestroyed",
				["entity"] = Mission.US_Bombers,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	--[[local szScore = tostring(table.getn(Mission.US_Bombers).." / "..tostring(Mission.MaxNumberOfBombers))
	DisplayScores(2, 0, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 1, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 3, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 4, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 5, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 6, "mp09.score_comp_bombershealth", szScore)
	DisplayScores(2, 7, "mp09.score_comp_bombershealth", szScore)]]--
	for i = 0, 7 do
		DisplayUnitHP(i, Mission.US_Bombers, "mp09.score_comp_bombershealth")
	end
	--luaLog("----InitPlayerUnits END---")
end

------------------------------------------------------------------------------
function luaQAC09_BombersDestroyed(pEntity)
	pEntity.Dead = true
	Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
	if (table.getn(Mission.US_Bombers)) then
		if (not IsListenerActive("kill", "Listener_BombersDestroyed")) then
			RemoveListener("kill", "Listener_BombersDestroyed")
		end
	end
	--[[local szScore = tostring(table.getn(Mission.US_Bombers).." / "..tostring(Mission.MaxNumberOfBombers))
	DisplayScores(2, 0, "Remaining B-29 squads", szScore)
	DisplayScores(2, 1, "Remaining B-29 squads", szScore)
	DisplayScores(2, 3, "Remaining B-29 squads", szScore)
	DisplayScores(2, 4, "Remaining B-29 squads", szScore)
	DisplayScores(2, 5, "Remaining B-29 squads", szScore)
	DisplayScores(2, 6, "Remaining B-29 squads", szScore)
	DisplayScores(2, 7, "Remaining B-29 squads", szScore)]]--
	--luaLog("(luaQAC09_BombersDestroyed): A bomber hullam megsemmisult")
end

------------------------------------------------------------------------------
function luaQAC09_InitEscortObjective()
	if (not luaObj_IsActive("primary", 9)) then
		luaObj_Add("primary", 9, Mission.US_Bombers)
	end
	--luaLog("(luaQAC09_InitEscortObjective): Lehet Highlighted unit")
end

------------------------------------------------------------------------------
function luaQAC09_EnableHighlightedPlane()
	--luaLog("(luaQAC09_EnableHighlightedPlane): Highliht active")
	Mission.EnableHighlightedPlane = true
end

------------------------------------------------------------------------------
function luaQAC09_SelectHighlightedPlane()
	if (Mission.EnableHighlightedPlane) and (GameTime() >= Mission.TimeHighlightedPlane) then
		--luaLog("(luaQAC09_SelectHighlightedPlane): Letelt a highlight kesleltetes")
		Mission.TimeHighlightedPlane = GameTime() + Mission.DeltaTimeHighlightedPlane
		Mission.EnableHighlightedPlane = false
		Mission.JAP_Planes = luaRemoveDeadsFromTable(Mission.JAP_Planes)
		Mission.JAP_PlanesFromAirfield = luaRemoveDeadsFromTable(Mission.JAP_PlanesFromAirfield)
		local tPlanes = {}
		if (Mission.JAP_Hqs[1].Party == PARTY_JAPANESE) then
			for i, pPlane in pairs (Mission.JAP_PlanesFromCarrier) do
				if (UnitGetAttackTarget(pPlane) ~= nil) and (UnitGetAttackTarget(pPlane).Class.ID == 386) then
					--luaLog("(luaQAC09_SelectHighlightedPlane): LevelBomber celpontu gep a Carrierrol = "..pPlane.Name)
					table.insert(tPlanes, pPlane)
				end
			end
		else
			for i, pPlane in pairs (Mission.JAP_Planes) do
				if (UnitGetAttackTarget(pPlane) ~= nil) and (UnitGetAttackTarget(pPlane).Class.ID == 386) then
					--luaLog("(luaQAC09_SelectHighlightedPlane): LevelBomber celpontu gep barhonnan = "..pPlane.Name)
					table.insert(tPlanes, pPlane)
				end
			end
		end
		--luaLog("(luaQAC09_SelectHighlightedPlane): levelbomber celpontu tabla hossz = "..table.getn(tPlanes))
		if (table.getn(tPlanes) > 0) then
			Mission.HighlightedPlane = nil
			Mission.HighlightedPlane = luaPickRnd(tPlanes)
			--luaLog("(luaQAC09_SelectHighlightedPlane): Uj highlighted plane = "..Mission.HighlightedPlane.Name)
			--luaObj_AddUnit("primary", 9, Mission.HighlightedPlane)
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.HighlightedPlane)
			end
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
			luaDelay(luaQAC09_Hint_Highlight, 5)
			SetSkillLevel(Mission.HighlightedPlane, SKILL_MPVETERAN)
			AISetHintWeight(Mission.HighlightedPlane, 50)
			if (not IsListenerActive("kill", "Listener_HighlightedPlaneDestroyed")) then
				AddListener("kill", "Listener_HighlightedPlaneDestroyed", 
				{
						["callback"] = "luaQAC09_HighlightedPlaneDestroyed",
						["entity"] = {Mission.HighlightedPlane},
						["lastAttacker"] = {},
						["lastAttackerPlayerIndex"] = {}
				})
			end
		else
			Mission.TimeHighlightedPlane = GameTime()
			Mission.EnableHighlightedPlane = true
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09_HighlightedPlaneDestroyed(pEntity, lastAttacker, lastAttackerPlayerIndex)
	--luaLog("(luaQAC09_HighlightedPlaneDestroyed): a highlighted plane megsemmisult")
	Mission.EnableHighlightedPlane = true
	if (GameTime() < Mission.TimeHighlightedPlane) then
		--luaLog("(luaQAC09_HighlightedPlaneDestroyed): Kell meg ido az uj highlighthoz")
	else
		--luaLog("(luaQAC09_HighlightedPlaneDestroyed): Spawnolhat uj highlighted unit")
	end
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
		--luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
			if IsListenerActive("kill", "Listener_HighlightedPlaneDestroyed") then
				RemoveListener("kill", "Listener_HighlightedPlaneDestroyed")
			end
			for i = 1, 8 do
				local y = i - 1
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
					--luaLog(playerwhoscored.playerName)
					Mission.MultiScoreAILevel = 33
					for z = 1, 8 do
						local x = z - 1
						if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
							Mission.MultiScoreAILevel = 3
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
							Mission.MultiScoreAILevel = 4
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
							Mission.MultiScoreAILevel = 5
						end
						MultiScore[x][6] = playerwhoscored.playerName
					end
				end
]]
			end
--[[
			local nRndPowerup = luaRnd(1, 2)
			local szPowerup
			if (nRndPowerup == 1) then
				szPowerup = "evasive_manoeuvre"
				--luaLog("Powerup = evasive menovar, vagy mi")
			else
				szPowerup = "full_throttle"
				--luaLog("Powerup = Full throttle")
			end
			local slotID = GetRoleAvailable(lastAttacker)[1]
			AddPowerup(slotID, {["classID"] = szPowerup, ["useLimit"] = 1,})
			MissionNarrativePlayer(lastAttackerPlayerIndex, "mp06.nar_comp_supply")
			--luaDelay(luaKillNarrative, 2, "ai", Mission.MultiScoreAILevel)
]]
		else
			--luaLog("(luaQAC09_HighlightedPlaneDestroyed): FAIL!!! lastAttackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
			end
		end
	else
		--luaLog("(luaQAC09_HighlightedPlaneDestroyed): FAIL!!! lastAttacker")
	end
end

------------------------------------------------------------------------------
function luaQAC09_CheckHighlightedObject()
	if (GameTime() >= Mission.TimeHighlightedObject) and (Mission.EnableHighlightedObject) then
		--luaLog("(luaQAC09_CheckHighlightedObject): Valasztunk highlighted objectet")
		Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
		--for i, pPlane in pairs (Mission.US_Bombers) do
		local i = 0
		local bInRange = false
		local bHintWeight = true
		while (i < table.getn(Mission.US_Bombers)) and (not bInRange) do
			--luaLog("(luaQAC09_CheckHighlightedObject): Keresem a range-ben levo bombazot")
			i = i + 1
			local pPlane = Mission.US_Bombers[i]
			local tHighlight = {}
			local pHQ = nil
			if (Mission.JAP_Hqs[1].Party == PARTY_JAPANESE) then
				local nRnd = 10 -- ha az oil tanker tavolabb van az 1-es HQ-tol mint 5km, akkor mar nem valasztjuk highlightednak
				if (table.getn(Mission.JAP_EventUnits) > 0) and (luaGetDistance(Mission.JAP_EventUnits[1], Mission.JAP_Hqs[1]) < 5000) then
					nRnd = luaRnd(1, 10)
				end
				if (nRnd < 5) then	-- 40% esely a tanker kiloves bonuszra, 60% az AA bonuszra
					--luaLog("(luaQAC09_CheckHighlightedObject): 1. fazis, Tankert valasztottam")
					Mission.JAP_EventUnits = luaRemoveDeadsFromTable(Mission.JAP_EventUnits)
					pHQ = Mission.JAP_EventUnits[1]
					tHighlight = Mission.JAP_EventUnits
					bHintWeight = false
				else
					--luaLog("(luaQAC09_CheckHighlightedObject): 1. fazis, AA-t valasztottam")
					Mission.JAP_AAGRP01 = luaRemoveDeadsFromTable(Mission.JAP_AAGRP01)
					pHQ = Mission.JAP_Hqs[1]
					tHighlight = Mission.JAP_AAGRP01
				end
			else
				--luaLog("(luaQAC09_CheckHighlightedObject): 2. fazis, AA-t valasztottam")
				Mission.JAP_AAGRP02 = luaRemoveDeadsFromTable(Mission.JAP_AAGRP02)
				pHQ = Mission.JAP_Hqs[2]
				tHighlight = Mission.JAP_AAGRP02
			end
			bInRange = luaQAC09_CheckHighlighted_DistanceCheck(pPlane, pHQ, tHighlight)
			if (bInRange) then
				Mission.HighlightedObject = nil
				Mission.HighlightedObject = luaPickRnd(tHighlight)
				Mission.EnableHighlightedObject = false
				--luaLog("(luaQAC09_CheckHighlightedObject): Uj highlighted object = "..Mission.HighlightedObject.Name)
				--luaObj_AddUnit("primary", 9, Mission.HighlightedObject)
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.HighlightedObject)
				end
				MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
				luaDelay(luaQAC09_Hint_Highlight, 5)
				if (bHintWeight) then
					AISetHintWeight(Mission.HighlightedObject, 50)
				else
					--cargo eseten levesszuk a sec. ojjektivat jelolo markert
					luaObj_RemoveUnit("secondary", 1, Mission.HighlightedObject)
				end
				--SetSkillLevel(Mission.HighlightedObject, SKILL_MPVETERAN)
				if (not IsListenerActive("kill", "Listener_HighlightedObjectDestroyed")) then
					AddListener("kill", "Listener_HighlightedObjectDestroyed", 
					{
							["callback"] = "luaQAC09_HighlightedObjectDestroyed",
							["entity"] = {Mission.HighlightedObject},
							["lastAttacker"] = {},
							["lastAttackerPlayerIndex"] = {}
					})
				end
				--[[if (not IsListenerActive("hit", "Listener_HighlightedObjectHit")) then
					AddListener("hit", "Listener_HighlightedObjectHit", {
						["callback"] = "luaQAC09_HighlightedObjectHit",
						["target"] = {Mission.HighlightedObject},
						["targetDevice"] = {},
						["attacker"] = {},
						["attackType"] = {},
						["attackerPlayerIndex"] = {},
						["damageCaused"] = {},
						["fireCaused"] = {},
						["leakCaused"] = {},
					})
				end]]--
			end
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09_Hint_Highlight()
	ShowHint("ID_Hint_Competitive09_Highlight")
end

------------------------------------------------------------------------------
function luaKillNarrative(timerthis)
	if timerthis.ParamTable.ai == 33 then
		MissionNarrativePlayer(0, "mp09.nar_comp_kill".."| #MultiScore.0.6#")
		MissionNarrativePlayer(1, "mp09.nar_comp_kill".."| #MultiScore.1.6#")
		MissionNarrativePlayer(2, "mp09.nar_comp_kill".."| #MultiScore.2.6#")
		MissionNarrativePlayer(3, "mp09.nar_comp_kill".."| #MultiScore.3.6#")
		MissionNarrativePlayer(4, "mp09.nar_comp_kill".."| #MultiScore.4.6#")
		MissionNarrativePlayer(5, "mp09.nar_comp_kill".."| #MultiScore.5.6#")
		MissionNarrativePlayer(6, "mp09.nar_comp_kill".."| #MultiScore.6.6#")
		MissionNarrativePlayer(7, "mp09.nar_comp_kill".."| #MultiScore.7.6#")
	elseif timerthis.ParamTable.ai == 3 then
		MissionNarrativeParty(PARTY_ALLIED, "mp09.nar_comp_kill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_ALLIED, "mp09.nar_comp_kill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_ALLIED, "mp09.nar_comp_kill".."| |FE.hard")
	end
end

------------------------------------------------------------------------------
function luaQAC09_CheckHighlighted_DistanceCheck(pPlane, pHQ, tHighlight)	-- aktualis bombazo, aktualis HQ, highlihted objects-et tartalmazo tabla (AA gunok)
	local i = 0
	local nBool = false
	--luaLog("(luaQAC09_CheckHighlighted_DistanceCheck): Distance check")
	tHighlight = luaRemoveDeadsFromTable(tHighlight)
	while (i < table.getn(tHighlight)) and (not nBool) do
		i = i + 1
		local nDistanceAA = luaGetDistance(pPlane, pHQ)
		if (nDistanceAA < 3000) then
			--luaLog("(luaQAC09_CheckHighlightedObject): Distance < 2000")
			nBool = true
		end
	end
	return nBool
end

------------------------------------------------------------------------------
--function luaQAC09_HighlightedObjectDestroyed(pEntity, targetDevice, attacker, attackType, lastAttackerPlayerIndex, damageCaused, fireCaused, leakCaused)
function luaQAC09_HighlightedObjectDestroyed(pEntity, lastAttacker, lastAttackerPlayerIndex)
	--if (GetHpPercentage(pEntity) < 0.05) then
		--luaLog("(luaQAC09_HighlightedObjectDestroyed): a highlighted object megsemmisult")
		if (IsListenerActive("kill", "Listener_HighlightedObjectDestroyed")) then
			RemoveListener("kill", "Listener_HighlightedObjectDestroyed")
		end
		Mission.EnableHighlightedObject = true
		--luaObj_RemoveUnit("primary", 9, pEntity)
		--[[if (GameTime() < Mission.TimeHighlightedObject) then
			--luaLog("(luaQAC09_HighlightedObjectDestroyed): Kell meg ido az uj highlighthoz")
		else
			--luaLog("(luaQAC09_HighlightedObjectDestroyed): Valaszthatunk uj highlighted objectet")
		end]]--
		Mission.TimeHighlightedObject = GameTime() + Mission.DeltaTimeHighlightedObject
		--luaLog("(luaQAC09_HighlightedObjectDestroyed): GameTime = "..tostring(GameTime()))
		--luaLog("(luaQAC09_HighlightedObjectDestroyed): Next Highlight Time = "..tostring(Mission.TimeHighlightedObject))
		if lastAttacker ~= nil then
			if not lastAttacker.Dead then
				lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
			end
			--luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
			if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
				if IsListenerActive("kill", "Listener_HighlightedObjectDestroyed") then
					RemoveListener("kill", "Listener_HighlightedObjectDestroyed")
				end
				for i = 1, 8 do
					local y = i - 1
					if y == lastAttackerPlayerIndex then
						MissionNarrativePlayer(y, "mp01.nar_comp_kill")
					else
						MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
					end
--[[
						local playerwhoscored = GetPlayerDetails()[y]
						--luaLog(playerwhoscored.playerName)
						Mission.MultiScoreAILevel = 33
						for z = 1, 8 do
							local x = z - 1
							if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
								Mission.MultiScoreAILevel = 3
							elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
								Mission.MultiScoreAILevel = 4
							elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
								Mission.MultiScoreAILevel = 5
							end
							MultiScore[x][6] = playerwhoscored.playerName
						end
					end
]]
				end
--[[
				local nRndPowerup = luaRnd(1, 2)
				local szPowerup
				if (nRndPowerup == 1) then
					szPowerup = "evasive_manoeuvre"
					--luaLog("Powerup = evasive menovar vagy mi a neve")
				else
					szPowerup = "full_throttle"
					--luaLog("Powerup = Full throttle")
				end
				local slotID = GetRoleAvailable(lastAttacker)[1]
				AddPowerup(slotID, {["classID"] = szPowerup, ["useLimit"] = 1,})
				MissionNarrativePlayer(lastAttackerPlayerIndex, "mp06.nar_comp_supply")
				--luaDelay(luaKillNarrative, 2, "ai", Mission.MultiScoreAILevel)
]]
			else
				--luaLog("(luaQAC09_HighlightedPlaneDestroyed): FAIL!!! lastAttackerPlayerIndex")
				for i = 0, 7 do
					MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
				end
			end
		else
			--luaLog("(luaQAC09_HighlightedPlaneDestroyed): FAIL!!! lastAttacker")
		end
	--end
end

------------------------------------------------------------------------------
function luaQAC09_BomberReachedNavpoint(pEntity)
	--luaLog("(luaQAC09_BomberReachedNavpoint) meghivodott")
	if (pEntity ~= nil) then
		--luaLog("(luaQAC09_BomberReachedNavpoint): 1 Bomber elerte a navpointot, Name = "..pEntity.Name..", State = "..pEntity.State)
	end
	RemoveTrigger(pEntity, "BomberReachedNavpoint")
	local pBombTarget = nil
	if (pEntity.State == 1) then
		pBombTarget = Mission.JAP_Hqs[1]
	elseif (pEntity.State == 2) then
		pBombTarget = Mission.JAP_Hqs[2]
	elseif (pEntity.State == 3) then
		pBombTarget = Mission.JAP_Hqs[3]
	elseif (pEntity.State == 4) then
		pBombTarget = Mission.JAP_Carrier[1]
	end
	--[[
	--luaLog("---Bombazas parameterek---")
	--luaLog(pEntity.Name)
	local Pos = GetPosition(pEntity)
	local Distance = luaGetDistance(pEntity, Mission.JAP_Hqs[1])
	--luaLog("Distance = "..Distance..", Height = "..Pos["y"])]]--
	PilotSetTarget(pEntity, pBombTarget)
	--PilotBomb(pEntity, pBombTarget)
end

------------------------------------------------------------------------------
function luaQAC09_CheckBomberTarget()
	Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
	Mission.JAP_Carrier = luaRemoveDeadsFromTable(Mission.JAP_Carrier)
	if (not Mission.MissionEndCalled) and (Mission.BomberActiveTarget == 1) and (Mission.JAP_Hqs[Mission.BomberActiveTarget].Party == PARTY_NEUTRAL) then
		for i, pPlane in pairs (Mission.US_Bombers) do
			pPlane.State = 2
			Mission.BomberActiveTarget = 2
			local pTargetPos = GetPosition(Mission.US_BomberNavpoints_State02[pPlane.Number])
			PilotMoveTo(pPlane, pTargetPos)
			AddProximityTrigger(pPlane, "BomberReachedNavpoint", "luaQAC09_BomberReachedNavpoint", pTargetPos, 200)
		end
		--SetParty(Mission.JAP_Shipyard[2], PARTY_NEUTRAL)
	elseif (not Mission.MissionEndCalled) and (Mission.BomberActiveTarget == 2) and (Mission.JAP_Hqs[1].Party == PARTY_NEUTRAL) and (Mission.JAP_Hqs[2].Party == PARTY_NEUTRAL) and (Mission.JAP_Hqs[3].Party == PARTY_JAPANESE) then
		for i, pPlane in pairs (Mission.US_Bombers) do
			pPlane.State = 3
			Mission.BomberActiveTarget = 3
			luaQAC09_BomberReachedNavpoint(pPlane)
		end
	elseif (not Mission.MissionEndCalled) and (Mission.BomberActiveTarget == 3) and (Mission.JAP_Hqs[3].Party == PARTY_NEUTRAL) and table.getn(Mission.JAP_Carrier) ~= 0 then
		for i, pPlane in pairs (Mission.US_Bombers) do
			pPlane.State = 4
			Mission.BomberActiveTarget = 4
			luaQAC09_BomberReachedNavpoint(pPlane)
		end
	end
end

------------------------------------------------------------------------------
--[[function luaQAC09_CheckBombersPayload()
	Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
	for i, pPlane in pairs (Mission.US_Bombers) do
		if (table.getn(GetPayloads(pPlane)) == 0) and (pPlane.State == 1) then
			--luaLog("Payload 0: "..pPlane.Name)
			pPlane.State = 2
			local pTargetPos = GetPosition(Mission.US_BomberNavpoints_State02[pPlane.Number])
			PilotMoveTo(pPlane, pTargetPos)
			AddProximityTrigger(pPlane, "BomberReachedNavpoint", "luaQAC09_BomberReachedNavpoint", pTargetPos, 200)
		else
			if (Mission.Debug ~= nil) then
				--luaLog("Payload ~= 0: "..pPlane.Name)
			end
		end
	end
end]]--

------------------------------------------------------------------------------
function luaQAC09_BombersFireManager()
	if (GameTime() >= Mission.NextTimeChangeBombersFire) then
		--luaLog("(luaQAC09_BombersFireManager): letelt a bomber loves ido, csere.")
		Mission.US_Bombers = luaRemoveDeadsFromTable(Mission.US_Bombers)
		local nLength = table.getn(Mission.US_Bombers)
		local tBombers = {}
		local i
		for i = 1, nLength do
			table.insert(tBombers, Mission.US_Bombers[i])
			--SetRoleAvailable(Mission.US_Bombers[i], EROLF_PILOT, PLAYER_AI)
			UnitHoldFire(Mission.US_Bombers[i])
			AAEnable(Mission.US_Bombers[i], false)
		end
		i = 0
		while (i < Mission.NumberOfBombersFire) and (i < nLength) do
			i = i + 1
			local pBomber = luaPickRnd(tBombers)
			--luaLog("(luaQAC09_BombersFireManager): kivalasztott bomber sorszama = "..tostring(pBomber.Name))
			--SetRoleAvailable(pBomber, EROLF_ALL, PLAYER_AI)
			UnitFreeFire(pBomber)
			AAEnable(pBomber, true)
			local j = 0
			local bBool = false
			while (j < table.getn(tBombers)) and (not bBool) do
				j =  j + 1
				if (tBombers[j] == pBomber) then
					bBool = true
				end
			end
			if (bBool) then
				table.remove(tBombers, j)
			else
				--luaLog("(luaQAC09_BombersFireManager): FUKKA VAN! A random kivalasztott unit nem talalhato a temp tablaban.")
			end
		end
		Mission.NextTimeChangeBombersFire = Mission.NextTimeChangeBombersFire + Mission.DeltaTimeChangeBombersFire
	end
end

------------------------------------------------------------------------------
function luaQAC09_PlaneSpawnManager()
	--if ((GameTime() < 60) or ((GameTime() > 59) and (GameTime() >= (Mission.TimeLastSpawnedFromCarrier + Mission.DeltaTimeLastSpawnedPlane)))) then
	if (not Mission.MissionEndCalled) then
		if (table.getn(Mission.JAP_PlanesFromCarrier) < Mission.MaxPlanesFromCarrier) and (table.getn(Mission.JAP_Carrier) > 0) and (not Mission.JAP_Carrier[1].Dead) then
			Mission.TimeLastSpawnedFromCarrier = GameTime()
			local tSpawnPos = GetPosition(Mission.JAP_SpawnPoints[1])
			local tLookAtPos = GetPosition(Mission.JAP_LookAtPoints[1])
			local nPlaneType = luaPickRnd(Mission.JAP_PlanesType)
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = nPlaneType,
						["Name"] = "",
						["Crew"] = 1,
						["Race"] = JAPANESE,
						["WingCount"] = 3,
						["Equipment"] = 0,
					},
				},
				["area"] = {
					["refPos"] = tSpawnPos,
					["angleRange"] = { 1, -1},
					["lookAt"] = tLookAtPos,
				},
				["callback"] = "luaQAC09_PlaneSpawnedFromCarrier",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 100
				},
			})
		end
	--if (GameTime() >= (Mission.TimeLastSpawnedFromAirfield + Mission.DeltaTimeLastSpawnedPlane)) then
		if (table.getn(Mission.JAP_PlanesFromAirfield) < Mission.MaxPlanesFromAirfield) and (Mission.JAP_Airfield[1].Party == PARTY_JAPANESE) and not Mission.JAP_Airfield[1].Dead then
			Mission.TimeLastSpawnedFromAirfield = GameTime()
			local tSpawnPos = GetPosition(Mission.JAP_SpawnPoints[2])
			local tLookAtPos = GetPosition(Mission.JAP_LookAtPoints[2])
			local nPlaneType = luaPickRnd(Mission.JAP_PlanesType)
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{
						["Type"] = nPlaneType,
						["Name"] = "",
						["Crew"] = 1,
						["Race"] = JAPANESE,
						["WingCount"] = 3,
						["Equipment"] = 0,
					},
				},
				["area"] = {
					["refPos"] = tSpawnPos,
					["angleRange"] = { 1, -1},
					["lookAt"] = tLookAtPos,
				},
				["callback"] = "luaQAC09_PlaneSpawnedFromAirfield",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 5,
					["enemyHorizontal"] = 5,
					["ownVertical"] = 5,
					["enemyVertical"] = 5,
					["formationHorizontal"] = 100
				},
			})
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09_PlaneSpawnedFromCarrier(pEntity)
	table.insert(Mission.JAP_PlanesFromCarrier, pEntity)
	table.insert(Mission.JAP_Planes, pEntity)
	pEntity.Homebase = Mission.JAP_Carrier[1].Name
	AISetHintWeight(pEntity, 10)
	local nRnd = luaRnd(1, 10)
	--if (nRnd < 3) then
	if (nRnd < 8) then
		SetSkillLevel(pEntity, SKILL_STUN)
	else
		SetSkillLevel(pEntity, SKILL_SPNORMAL)
	end
	--for debug
	if (Mission.FPSDebug) then
		AddUntouchableUnit(pEntity)
	end
end

------------------------------------------------------------------------------
function luaQAC09_PlaneSpawnedFromAirfield(pEntity)
	table.insert(Mission.JAP_PlanesFromAirfield, pEntity)
	table.insert(Mission.JAP_Planes, pEntity)
	pEntity.Homebase = Mission.JAP_Airfield[1].Name
	AISetHintWeight(pEntity, 10)
	local nRnd = luaRnd(1, 10)
	--if (nRnd < 3) then
	if (nRnd < 8) then
		SetSkillLevel(pEntity, SKILL_STUN)
	else
		SetSkillLevel(pEntity, SKILL_SPNORMAL)
	end
	if (Mission.FPSDebug) then
		AddUntouchableUnit(pEntity)
	end
end

------------------------------------------------------------------------------
function luaQAC09_AttackManager()
	luaQAC09_RemoveDeads()
	if (not Mission.MissionEndCalled)	then
		for i, pPlane in pairs (Mission.JAP_Planes) do --(Mission.JAP_PlanesFromCarrier) do
			local pActTarget = UnitGetAttackTarget(pPlane)
			if (pActTarget == nil) or ((pActTarget ~= nil) and (pActTarget.Dead)) then
				local nRnd = luaRnd(1,10)
				--if (nRnd < 3) then		-- player unitokat tamadja, 20% esellyel valasztja be
				if (nRnd < 5) then		-- player unitokat tamadja, 40% esellyel valasztja be
					--luaLog("(luaQAC09_AttackManager): "..pPlane.Name.." PlayerUnitot tamad")
					local nPos = GetPosition(pPlane)
					local tTargets = luaQAC09_GetPlayersPlaneTable()
					local pTarget = luaQAC09_GetNearestFromTable(pPlane, tTargets)
					if (pTarget ~= nil) then
						PilotSetTarget(pPlane, pTarget)
						--luaLog("(luaQAC09_AttackManager): PlayerUnit = "..pTarget.Name)
					end
				else		-- bombazokat tamadja, 80% esellyel valasztja be
					--luaLog("(luaQAC09_AttackManager): "..pPlane.Name.." Bombazot tamad")
					local pTarget = luaPickRnd(Mission.US_Bombers)
					PilotSetTarget(pPlane, pTarget)
					AISetHintWeight(pPlane, 5)
					--luaLog("(luaQAC09_AttackManager): Bombazo = "..pTarget.Name)
				end
			end
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09_GetPlayerPlane(nPlayerIndex)
	local tPlayerPlanes = luaGetPlanesAroundCoordinate(GetPosition(Mission.JAP_Hqs[1]), 100000, PARTY_ALLIED, "own")
	if (tPlayerPlanes ~= nil) and (table.getn(tPlayerPlanes) > 0) then
		local i = 0
		local nBool = false
		while (i < table.getn(tPlayerPlanes)) and (not nBool) do
			i = i + 1
			local nOwnerID = GetRoleAvailable(tPlayerPlanes[i])[1]
			if (nOwnerID == nPlayerIndex) then
				nBool = true
			end
		end
	end
	if (nBool) then
		return tPlayerPlanes[i]
	else
		return nil
	end
end

------------------------------------------------------------------------------
function luaQAC09_GetNearestFromTable(pUnit, tTargets)
	if (pUnit ~= nil) and (tTargets ~= nil) and (table.getn(tTargets) > 0) then
		local nMinDistance = 100000
		local pTarget = nil
		for i, pActTarget in pairs (tTargets) do
			local nActDistance = luaGetDistance(pActTarget, pUnit)
			if (nActDistance < nMinDistance) then
				nMinDistance = nActDistance
				pTarget = pActTarget
			end
		end
		return pTarget
	else
		return nil
	end
end

------------------------------------------------------------------------------
function luaQAC09_GetPlayersPlaneTable()
	local tAllPlayerPlanes = luaGetPlanesAroundCoordinate(GetPosition(Mission.JAP_Hqs[1]), 100000, PARTY_ALLIED, "own")
	local tPlayerPlanes = {}
	if (tAllPlayerPlanes ~= nil) and (table.getn(tAllPlayerPlanes) > 0) then
		for i, pPlane in pairs (tAllPlayerPlanes) do
			local nOwnerID = GetRoleAvailable(pPlane)[1]
			if (nOwnerID > -1) and (nOwnerID < 8) then
				table.insert(tPlayerPlanes, pPlane)
			end
		end
	end
	return tPlayerPlanes
end

------------------------------------------------------------------------------
function luaQAC09_PTManager()
	for i, pShipyard in pairs (Mission.JAP_Shipyard) do
		if ((GetHpPercentage(pShipyard) < 0.05) or (pShipyard.Dead)) and (pShipyard.Party == PARTY_JAPANESE) then
			--SetParty(pShipyard, PARTY_NEUTRAL)
		end
	end
	if (not Mission.MissionEndCalled) then
		if (not Mission.JAP_Shipyard[1].Dead) and (Mission.JAP_Shipyard[1].Party == PARTY_JAPANESE) then
			if (table.getn(Mission.JAP_ShipyardGroup01) < Mission.PTNumber) and (Mission.JAP_ShipyardSpawns[1].Number < 4)then
				if ((Mission.JAP_ShipyardSpawns[1].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[1]) < GameTime()) then
					Mission.JAP_ShipyardSpawns[1].LastSpawnedTime = GameTime()
					local tSpawnPos = GetPosition(Mission.JAP_ShipyardSpawns[1])
					local tLookAtPos = GetPosition(Mission.JAP_ShipyardArea[1])
					local nType = 77	-- Japanese PT
					local szName = "PT-"..tostring(Mission.JAP_ShipyardSpawns[1].Number).."_GRP01"
					SpawnNew({
						["party"] = PARTY_JAPANESE,
						["groupMembers"] = {
							{
								["Type"] = 77,
								["Name"] = szName,
								["Crew"] = 1,
								["Race"] = JAPANESE,
							},
						},
						["area"] = {
							["refPos"] = tSpawnPos,
							["angleRange"] = { DEG(0),DEG(180)},
							["lookAt"] = tLookAtPos,
				
						},
						["callback"] = "luaQAC09_PTSpawned_GRP01",
						["excludeRadiusOverride"] = {
							["ownHorizontal"] = 5,
							["enemyHorizontal"] = 5,
							["ownVertical"] = 5,
							["enemyVertical"] = 5,
							["formationHorizontal"] = 200,
						},
					})
				end
			end
		end
		if (not Mission.JAP_Shipyard[2].Dead) and (Mission.JAP_Shipyard[2].Party == PARTY_JAPANESE) then
			if (table.getn(Mission.JAP_ShipyardGroup02) < Mission.PTNumber) and ((Mission.JAP_ShipyardSpawns[2].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[2]) < GameTime()) then
				Mission.JAP_ShipyardSpawns[2].LastSpawnedTime = GameTime()
				local tSpawnPos = GetPosition(Mission.JAP_ShipyardSpawns[2])
				local tLookAtPos = GetPosition(Mission.JAP_ShipyardArea[2])
				local nType = 77	-- Japanese PT
				local szName = "PT-"..tostring(Mission.JAP_ShipyardSpawns[2].Number).."_GRP02"
				SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						{
							["Type"] = 77,
							["Name"] = szName,
							["Crew"] = 1,
							["Race"] = JAPANESE,
						},
					},
					["area"] = {
						["refPos"] = tSpawnPos,
						["angleRange"] = { DEG(0),DEG(180)},
						["lookAt"] = tLookAtPos,
			
					},
					["callback"] = "luaQAC09_PTSpawned_GRP02",
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 5,
						["enemyHorizontal"] = 5,
						["ownVertical"] = 5,
						["enemyVertical"] = 5,
						["formationHorizontal"] = 200,
					},
				})
			end
		end
		if (not Mission.JAP_Shipyard[3].Dead) and (Mission.JAP_Shipyard[3].Party == PARTY_JAPANESE) then
			if (table.getn(Mission.JAP_ShipyardGroup03) < Mission.PTNumber) and ((Mission.JAP_ShipyardSpawns[3].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[3]) < GameTime()) then
				Mission.JAP_ShipyardSpawns[3].LastSpawnedTime = GameTime()
				local tSpawnPos = GetPosition(Mission.JAP_ShipyardSpawns[3])
				local tLookAtPos = GetPosition(Mission.JAP_ShipyardArea[3])
				local nType = 77	-- Japanese PT
				local szName = "PT-"..tostring(Mission.JAP_ShipyardSpawns[2].Number).."_GRP03"
				SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						{
							["Type"] = 77,
							["Name"] = szName,
							["Crew"] = 1,
							["Race"] = JAPANESE,
						},
					},
					["area"] = {
						["refPos"] = tSpawnPos,
						["angleRange"] = { DEG(0),DEG(180)},
						["lookAt"] = tLookAtPos,
			
					},
					["callback"] = "luaQAC09_PTSpawned_GRP03",
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 5,
						["enemyHorizontal"] = 5,
						["ownVertical"] = 5,
						["enemyVertical"] = 5,
						["formationHorizontal"] = 200,
					},
				})
			end
		end
		if (not Mission.JAP_Shipyard[4].Dead) and (Mission.JAP_Shipyard[4].Party == PARTY_JAPANESE) then
			if (table.getn(Mission.JAP_ShipyardGroup04) < Mission.PTNumber) and ((Mission.JAP_ShipyardSpawns[4].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[4]) < GameTime()) then
				Mission.JAP_ShipyardSpawns[4].LastSpawnedTime = GameTime()
				local tSpawnPos = GetPosition(Mission.JAP_ShipyardSpawns[4])
				local tLookAtPos = GetPosition(Mission.JAP_ShipyardArea[4])
				local nType = 77	-- Japanese PT
				local szName = "PT-"..tostring(Mission.JAP_ShipyardSpawns[2].Number).."_GRP04"
				SpawnNew({
					["party"] = PARTY_JAPANESE,
					["groupMembers"] = {
						{
							["Type"] = 77,
							["Name"] = szName,
							["Crew"] = 1,
							["Race"] = JAPANESE,
						},
					},
					["area"] = {
						["refPos"] = tSpawnPos,
						["angleRange"] = { DEG(0),DEG(180)},
						["lookAt"] = tLookAtPos,
			
					},
					["callback"] = "luaQAC09_PTSpawned_GRP04",
					["excludeRadiusOverride"] = {
						["ownHorizontal"] = 5,
						["enemyHorizontal"] = 5,
						["ownVertical"] = 5,
						["enemyVertical"] = 5,
						["formationHorizontal"] = 200,
					},
				})
			end
		end
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTSpawned_GRP01(pEntity, nState)
	if (nState == nil) then
		table.insert(Mission.JAP_ShipyardGroup01, pEntity)
		Mission.JAP_ShipyardSpawns[1].Number = Mission.JAP_ShipyardSpawns[1].Number + 1
	end
	local tPos = luaQAC09_GetRandomAreaPos(GetPosition(Mission.JAP_ShipyardArea[1]), 1000)
	NavigatorMoveToPos(pEntity, tPos)
	AddProximityTrigger(pEntity, "PTReachedPointGRP01", "luaQAC09_PTReachedPointGRP01", tPos, 100)
end

------------------------------------------------------------------------------
function luaQAC09_PTReachedPointGRP01(pEntity)
	RemoveTrigger(pEntity, "PTReachedPointGRP01")
	luaQAC09_PTSpawned_GRP01(pEntity, 1)
end

------------------------------------------------------------------------------
function luaQAC09_PTSpawned_GRP02(pEntity, nState)
	if (nState == nil) then
		table.insert(Mission.JAP_ShipyardGroup02, pEntity)
		Mission.JAP_ShipyardSpawns[2].Number = Mission.JAP_ShipyardSpawns[2].Number + 1
		--luaLog("(luaQAC09_PTSpawned_GRP02): Spawnolt egy PT = "..tostring(pEntity.Name))
	end
	local tPos = luaQAC09_GetRandomAreaPos(GetPosition(Mission.JAP_ShipyardArea[2]), 1500)
	NavigatorMoveToPos(pEntity, tPos)
	AddProximityTrigger(pEntity, "PTReachedPointGRP02", "luaQAC09_PTReachedPointGRP02", tPos, 100)
	if (not IsListenerActive("kill", "Listener_PTKilled_GRP02")) then
		AddListener("kill", "Listener_PTKilled_GRP02", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP02",
				["entity"] = Mission.JAP_ShipyardGroup02,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
		--luaLog("(luaQAC09_PTSpawned_GRP02): A listenert beregisztraltam = "..tostring(pEntity.Name))
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTKilled_GRP02(pEntity)
	--luaLog("(luaQAC09_PTKilled_GRP02): Egy PT megsemmisult = "..tostring(pEntity.Name))
	pEntity.Dead = true
	Mission.JAP_ShipyardGroup02 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup02)
	if (IsListenerActive("kill", "Listener_PTKilled_GRP02")) then
		RemoveListener("kill", "Listener_PTKilled_GRP02")
		AddListener("kill", "Listener_PTKilled_GRP02", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP02",
				["entity"] = Mission.JAP_ShipyardGroup02,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
		--luaLog("(luaQAC09_PTKilled_GRP02): A kill listenert ujra beregisztraltam = "..tostring(pEntity.Name))
	end
	RemoveTrigger(pEntity, "PTReachedPointGRP02")
	if ((Mission.JAP_ShipyardSpawns[2].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[2])< GameTime()) then
		--luaLog("(function luaQAC09_PTKilled_GRP02): A LastSpawnedTime kisebb volt mint a GameTime, van valtoztatas")
		Mission.JAP_ShipyardSpawns[2].LastSpawnedTime = GameTime()
	else
		--luaLog("(function luaQAC09_PTKilled_GRP02): A LastSpawnedTime nagyobb volt mint a GameTime, nincs valtoztatas")
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTReachedPointGRP02(pEntity)
	RemoveTrigger(pEntity, "PTReachedPointGRP02")
	luaQAC09_PTSpawned_GRP02(pEntity, 1)
end

------------------------------------------------------------------------------
function luaQAC09_PTSpawned_GRP03(pEntity, nState)
	if (nState == nil) then
		table.insert(Mission.JAP_ShipyardGroup03, pEntity)
		Mission.JAP_ShipyardSpawns[3].Number = Mission.JAP_ShipyardSpawns[3].Number + 1
	end
	local tPos = luaQAC09_GetRandomAreaPos(GetPosition(Mission.JAP_ShipyardArea[3]), 1500)
	NavigatorMoveToPos(pEntity, tPos)
	AddProximityTrigger(pEntity, "PTReachedPointGRP03", "luaQAC09_PTReachedPointGRP03", tPos, 100)
	if (not IsListenerActive("kill", "Listener_PTKilled_GRP03")) then
		AddListener("kill", "Listener_PTKilled_GRP03", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP03",
				["entity"] = Mission.JAP_ShipyardGroup03,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTKilled_GRP03(pEntity)
	pEntity.Dead = true
	Mission.JAP_ShipyardGroup03 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup03)
	if (IsListenerActive("kill", "Listener_PTKilled_GRP03")) then
		RemoveListener("kill", "Listener_PTKilled_GRP03")
		AddListener("kill", "Listener_PTKilled_GRP03", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP03",
				["entity"] = Mission.JAP_ShipyardGroup03,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	RemoveTrigger(pEntity, "PTReachedPointGRP03")
	if ((Mission.JAP_ShipyardSpawns[3].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[3])< GameTime()) then
		Mission.JAP_ShipyardSpawns[3].LastSpawnedTime = GameTime()
	end
end
------------------------------------------------------------------------------
function luaQAC09_PTReachedPointGRP03(pEntity)
	RemoveTrigger(pEntity, "PTReachedPointGRP03")
	luaQAC09_PTSpawned_GRP03(pEntity, 1)
end

------------------------------------------------------------------------------
function luaQAC09_PTSpawned_GRP04(pEntity, nState)
	if (nState == nil) then
		table.insert(Mission.JAP_ShipyardGroup04, pEntity)
		Mission.JAP_ShipyardSpawns[4].Number = Mission.JAP_ShipyardSpawns[4].Number + 1
	end
	local tPos = luaQAC09_GetRandomAreaPos(GetPosition(Mission.JAP_ShipyardArea[4]), 1000)
	NavigatorMoveToPos(pEntity, tPos)
	AddProximityTrigger(pEntity, "PTReachedPointGRP04", "luaQAC09_PTReachedPointGRP04", tPos, 100)
	if (not IsListenerActive("kill", "Listener_PTKilled_GRP04")) then
		AddListener("kill", "Listener_PTKilled_GRP04", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP04",
				["entity"] = Mission.JAP_ShipyardGroup04,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTKilled_GRP04(pEntity)
	pEntity.Dead = true
	Mission.JAP_ShipyardGroup04 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup04)
	if (IsListenerActive("kill", "Listener_PTKilled_GRP04")) then
		RemoveListener("kill", "Listener_PTKilled_GRP04")
		AddListener("kill", "Listener_PTKilled_GRP04", 
		{
				["callback"] = "luaQAC09_PTKilled_GRP04",
				["entity"] = Mission.JAP_ShipyardGroup04,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
	end
	RemoveTrigger(pEntity, "PTReachedPointGRP04")
	if ((Mission.JAP_ShipyardSpawns[4].LastSpawnedTime + Mission.JAP_ShipyardSpawnTimes[4])< GameTime()) then
		Mission.JAP_ShipyardSpawns[4].LastSpawnedTime = GameTime()
	end
end

------------------------------------------------------------------------------
function luaQAC09_PTReachedPointGRP04(pEntity)
	RemoveTrigger(pEntity, "PTReachedPointGRP04")
	luaQAC09_PTSpawned_GRP04(pEntity, 1)
end

------------------------------------------------------------------------------
function luaQAC09_GetRandomAreaPos(tReferencePos, nRadius)
	--luaLog("nRadius = "..tostring(nRadius))
	local nRndX = luaRnd(((nRadius) * -1), nRadius)
	--luaLog("nRndX = "..tostring(nRndX))
	local nRndZ = luaRnd(((nRadius) * -1), nRadius)
	--luaLog("nRndZ = "..tostring(nRndZ))
	local tPos = {}
	tPos["x"] = tReferencePos["x"] + nRndX
	tPos["z"] = tReferencePos["z"] + nRndZ
	tPos["y"] = tReferencePos["y"]
	return tPos
end

------------------------------------------------------------------------------
function luaQAC09_RemoveDeads()
	Mission.JAP_PlanesFromCarrier = luaRemoveDeadsFromTable(Mission.JAP_PlanesFromCarrier)
	Mission.JAP_PlanesFromAirfield = luaRemoveDeadsFromTable(Mission.JAP_PlanesFromAirfield)
	Mission.JAP_Planes = luaRemoveDeadsFromTable(Mission.JAP_Planes)
	Mission.JAP_Carrier = luaRemoveDeadsFromTable(Mission.JAP_Carrier)
	Mission.JAP_AAGRP01 = luaRemoveDeadsFromTable(Mission.JAP_AAGRP01)
	Mission.JAP_AAGRP02 = luaRemoveDeadsFromTable(Mission.JAP_AAGRP02)
	Mission.JAP_EventUnits = luaRemoveDeadsFromTable(Mission.JAP_EventUnits)
	Mission.JAP_EventEscort = luaRemoveDeadsFromTable(Mission.JAP_EventEscort)
	Mission.JAP_ShipyardGroup01 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup01)
	Mission.JAP_ShipyardGroup02 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup02)
	Mission.JAP_ShipyardGroup03 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup03)
	Mission.JAP_ShipyardGroup04 = luaRemoveDeadsFromTable(Mission.JAP_ShipyardGroup04)
	Mission.JAP_SecondaryUnits = luaRemoveDeadsFromTable(Mission.JAP_SecondaryUnits)
end

------------------------------------------------------------------------------
function luaQAC09AddP1Obj()
	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
end

------------------------------------------------------------------------------
function luaQAC09_InitSecondaryListener()
	AddListener("recon", "Listener_CargosSpotted", {
		["callback"] = "luaQAC09_CargosSpotted",  -- callback fuggveny
		["entity"] = Mission.JAP_SecondaryUnits, -- entityk akiken a listener aktiv
		["oldLevel"] = {}, -- 0: undetected, 1: detected, 2-4: identified
		["newLevel"] = {2}, -- 0: undetected, 1: detected, 2-4: identified
		["party"] = { PARTY_ALLIED },
	})
	AddListener("kill", "Listener_SecondaryDestroyed", 
		{
				["callback"] = "luaQAC09_SecondaryDestroyed",
				["entity"] = Mission.JAP_SecondaryUnits,
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {}
		})
end

------------------------------------------------------------------------------
function luaQAC09_SecondaryDestroyed(pEntity)
	pEntity.Dead = true
	Mission.JAP_SecondaryUnits = luaRemoveDeadsFromTable(Mission.JAP_SecondaryUnits)
	if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) and (table.getn(Mission.JAP_SecondaryUnits) == 0) then
		if (IsListenerActive("kill", "Listener_SecondaryDestroyed")) then
			RemoveListener("kill", "Listener_SecondaryDestroyed")
		end
		if (IsListenerActive("recon", "Listener_CargosSpotted")) then
			RemoveListener("recon", "Listener_CargosSpotted")
		end
		luaObj_Completed("secondary", 1)
		--luaLog("(luaQAC09_SecondaryDestroyed): Sec01 completed")
	end

	Mission.JAP_Minekazes = luaRemoveDeadsFromTable(Mission.JAP_Minekazes)
	for index, unit in pairs (Mission.JAP_Minekazes) do
		ArtilleryEnable(unit, true)
		AAEnable(unit, true)
	end
end

------------------------------------------------------------------------------
function luaQAC09_CargosSpotted(pEntity)
	--luaLog("(luaQAC09_CargosSpotted): Cargo Spotted")
	if (IsListenerActive("recon", "Listener_CargosSpotted")) then
		RemoveListener("recon", "Listener_CargosSpotted")
	end
	if (not luaObj_IsActive("secondary", 1)) then
		MissionNarrativeParty(PARTY_ALLIED, "mp09.nar_comp_cargospotted")
		luaDelay(luaQAC09_InitSecondaryObjective, 3)
	end
end

------------------------------------------------------------------------------
function luaQAC09_InitSecondaryObjective()
	luaObj_Add("secondary", 1, Mission.JAP_SecondaryUnits)
	for i, pUnit in pairs (Mission.JAP_SecondaryUnits) do
		AISetHintWeight(pUnit, 1)
	end
	--luaLog("(luaQAC09_InitSecondaryObjective): Secondary01 addolva")
end

------------------------------------------------------------------------------
function luaQAC09CheckMissionEnd()
	--luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
			----luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
			local PlayersInGame = GetPlayerDetails()
			local playerwhowon = PlayersInGame[highestindex]
			for index, value in pairs (PlayersInGame) do
				if playerwhowon.playerName ~= "" then
					MultiScore[index][4] = playerwhowon.playerName
					Mission.WinnerPlayer = playerwhowon.playerName
				else
					MultiScore[index][4] = "mp.nar_comp_skirmish_ai"
					Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
				end
			end
			Mission.MissionEndCalled = true
			Mission.PointLimitReached = true
			CountdownCancel()
			luaDelay(luaQAC09MissionEnd, 2, "Reason", "ScoreLimit")
		end
	end
	if (not Mission.MissionEndCalled) and (Mission.JAP_Hqs[1].Party ~= PARTY_JAPANESE) and (Mission.JAP_Hqs[2].Party ~= PARTY_JAPANESE) and (Mission.JAP_Hqs[3].Party ~= PARTY_JAPANESE) and table.getn(Mission.JAP_Carrier) == 0 then
		Mission.MissionEndCalled = true
		if (not IsListenerActive("kill", "Listener_BombersDestroyed")) then
			RemoveListener("kill", "Listener_BombersDestroyed")
		end
		luaDelay(luaQAC09MissionEnd, 2)
	end
	if (not Mission.MissionEndCalled) and (table.getn(Mission.US_Bombers) == 0) then
		--luaLog("(luaQAC09CheckMissionEnd): Meghivodott")
		Mission.MissionEndCalled = true
		if (not IsListenerActive("kill", "Listener_BombersDestroyed")) then
			RemoveListener("kill", "Listener_BombersDestroyed")
		end
		Mission.MissionFailed = true
		luaDelay(luaQAC09MissionEnd, 2)
		--luaDelay(luaQAC09MissionEndFailed, 2)
	end
end

------------------------------------------------------------------------------
function luaQAC09CheckHighestScore()
	----luaLog("!SCORES: ")
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		--luaLog(" playerindex: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	----luaLog(" highestindex: "..highestindex)
	----luaLog(" highestplayerscore: "..highestplayerscore)
	return highestindex, highestplayerscore
end

------------------------------------------------------------------------------
function luaQAC09MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
	local PlayersInGame = GetPlayerDetails()
	local playerwhowon = PlayersInGame[highestindex]
	for index, value in pairs (PlayersInGame) do
		if playerwhowon.playerName ~= "" then
			MultiScore[index][4] = playerwhowon.playerName
			Mission.WinnerPlayer = playerwhowon.playerName
		else
			MultiScore[index][4] = "mp.nar_comp_skirmish_ai"
			Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
		end
	end
	Mission.MissionEndCalled = true
	Mission.TimeIsUp = true
	CountdownCancel()
	luaDelay(luaQAC09MissionEnd, 2)
end

------------------------------------------------------------------------------
function luaQAC09MissionEnd(timerthis)
	--luaLog(" MissionEnd called...")
	HideScoreDisplay(2, 0)
	HideScoreDisplay(2, 1)
	HideScoreDisplay(2, 2)
	HideScoreDisplay(2, 3)
	HideScoreDisplay(2, 4)
	HideScoreDisplay(2, 5)
	HideScoreDisplay(2, 6)
	HideScoreDisplay(2, 7)
	if not Mission.Completed then
		Mission.Completed = true
		
		if (Mission.MissionFailed) then
			--luaLog("Mission Failed")
			--MissionNarrativeParty(PARTY_ALLIED, "mp09.obj_comp_p1_fail")
			luaObj_Failed("primary", 9)
		else
			--luaLog("Mission Completed")
			luaObj_Completed("primary", 9)
			if (timerthis.ParamTable.Reason == nil) then
				--MissionNarrativeParty(PARTY_ALLIED, "mp09.obj_comp_p1_compl")
			else
				--MissionNarrativeParty(PARTY_ALLIED, "mp09.nar_comp_scorelimit")
			end
		end

		luaDelay(luaQAC09DelayedMissionComplete, 4)
	end
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------
--[[function luaQAC09MissionEndFailed()
	--luaLog(" MissionEnd called...")
	HideScoreDisplay(2, 0)
	HideScoreDisplay(2, 1)
	HideScoreDisplay(2, 2)
	HideScoreDisplay(2, 3)
	HideScoreDisplay(2, 4)
	HideScoreDisplay(2, 5)
	HideScoreDisplay(2, 6)
	HideScoreDisplay(2, 7)
	if not Mission.Completed then
		Mission.Completed = true
		for i = 1, 8 do
			MissionNarrativeParty(PARTY_ALLIED, "mp09.obj_comp_p1_fail")
			luaObj_Failed("primary", i)
		end
		luaDelay(luaQAC09_DelayedMissionFailed, 4)
	end
end]]--

------------------------------------------------------------------------------
function luaQAC09DelayedMissionComplete()
	if not Mission.MissionEnd then
--[[
		if (not Mission.TimeIsUp) and (not Mission.MissionFailed) then
			MissionNarrativePlayer(0, "#MultiScore.0.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(1, "#MultiScore.1.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(2, "#MultiScore.2.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(3, "#MultiScore.3.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(4, "#MultiScore.4.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(5, "#MultiScore.5.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(6, "#MultiScore.6.4# |".."mp09.nar_comp_player_won")
			MissionNarrativePlayer(7, "#MultiScore.7.4# |".."mp09.nar_comp_player_won")
		end
]]
		local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
		--luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		if (not Mission.MissionFailed) then
			luaObj_Completed("primary", objindex)
		end
		for i = 1, 8 do
			if (Mission.MissionFailed) or ((not Mission.MissionFailed) and (i ~= objindex)) then
				luaObj_Failed("primary", i)
			end
		end
		-- a kov. nem biztos hogy kell, mert lehet hogy a narrative felulvagja a pri narrativat
		--[[if (luaObj_IsActive("secondary", 1)) and (luaObj_GetSuccess("secondary", 1) == nil) then
			luaObj_Failed("secondary", 1)
		end]]--
		Scoring_RealPlayTimeRunning(false)
		--MissionNarrativeParty(PARTY_ALLIED, "Mission Completed")	-- TOOD: luaMissionCompletedNew-t hivni, lokalizalni, kamera targetet kivalasztani
		local playerplanes = luaGetPlanesAroundCoordinate(Mission.CenterCoordinate, 40000, PARTY_ALLIED, "own")
		Mission.EndUnit = nil
		if playerplanes ~= nil then
			local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
			--luaLog("(luaQAC09DelayedMissionComplete): highestindex = "..tostring(highestindex)..", highestplayerscore = "..tostring(highestplayerscore))
			for index, unit in pairs (playerplanes) do
				local ownerID = GetRoleAvailable(unit)[1]
				if ownerID == highestindex then
					Mission.EndUnit = unit
				end
			end
		end
		if (Mission.EndUnit == nil) then
			if (Mission.JAP_Hqs[1].Party == PARTY_JAPANESE) then
				Mission.EndUnit = Mission.JAP_Hqs[1]
			else
				Mission.EndUnit = Mission.JAP_Hqs[2]
			end
		end
		if (not Mission.MissionFailed) then
			luaMissionCompletedNew(Mission.EndUnit, "", nil, nil, nil, PARTY_ALLIED)
		else
			luaMissionCompletedNew(Mission.EndUnit, "", nil, nil, nil, PARTY_JAPANESE)
		end
	end
end

------------------------------------------------------------------------------
--[[function luaQAC09_DelayedMissionFailed()
	--luaLog("(luaQAC09_DelayedMissionFailed) meghivodott")
	if (not Mission.MissionEnd) then
		Scoring_RealPlayTimeRunning(false)
		MissionNarrativeParty(PARTY_ALLIED, "Mission Failed")
		luaMissionFailedNew(Mission.JAP_Hqs[2], "", nil, nil, nil, PARTY_ALLIED)
	end
end]]--

------------------------------------------------------------------------------
function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive09")
	-- mode description hint overlay
end

------------------------------------------------------------------------------
function luaUpdateCounters()
	--luaLog(" Updating counters...")
	if MultiScore ~= nil then
		if table.getn(MultiScore) ~= 0 then
			local PlayersInGame = GetPlayerDetails()
			local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
				MultiScore[index][5] = highestplayerscore
			end
		end
	end

	luaDelay(luaUpdateCounters, 0.7)
end

------------------------------------------------------------------------------
---- cheat ----
function luaComplete()
	local highestindex, highestplayerscore = luaQAC09CheckHighestScore()
	local objindex = highestindex + 1
	luaObj_Completed("primary", objindex)
	for i = 1, 8 do
		if i ~= objindex then
			luaObj_Failed("primary", i)
		end
	end

	Scoring_RealPlayTimeRunning(false)
	-- TODO: luaMissionCompletedNew-t hivni
	--luaMissionCompletedNew(Mission.JapHQ, "")
end

------------------------------------------------------------------------------
function luaKillBombers()
	for i, pBomber in pairs (Mission.US_Bombers) do
		Kill(pBomber)
	end
end

------------------------------------------------------------------------------
function luaInvincibleBombers()
	for i, pBomber in pairs (Mission.US_Bombers) do
		SetInvincible(pBomber, 1)
	end
end

------------------------------------------------------------------------------
function luaDamagableBombers()
	for i, pBomber in pairs (Mission.US_Bombers) do
		SetInvincible(pBomber, 0)
	end
end

function luaQAC09_CheckJAPAirfield()
	if Mission.JAP_Hqs[2].Party ~= PARTY_JAPANESE then
		if not Mission.JAP_Airfield[1].Dead then
			SetParty(Mission.JAP_Airfield[1], PARTY_NEUTRAL)
		end
	else
		luaDelay(luaQAC09_CheckJAPAirfield, 0.8)
	end
end