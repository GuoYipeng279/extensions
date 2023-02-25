HighLvlAIGlobals = {}

HighLvlAIGlobals["IslandCaptureParams_Rookie"]=	-- Island Capture mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=12.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=1.0,
		["Cargo"]=2.0,
		["TBoat"]=0.001,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=8,
		["DiveBomber"]=8,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.95, 1.05 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 1.95,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 1.95,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 1.95,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 1.95,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 1.95,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 1500,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 60.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 80.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 60.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 200.0, 4.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 60.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 120.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.0 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.50,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.30,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = { 15.0,  1.15 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_ActAttackTargetWeightMulDist"] = { 3000.0,  4500.0 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)
		["Capture_SpawnDelay"] = { 60, 45 }, -- a foglalo bot 2 spawnolasa kozott legalabb ennyi idonek el kell telnie, masodpercben. Kezdetben ez a delay az elso ertek, majd 'Capture_SpawnDelayTime' ido alatt lecsokken a masodik ertekre
		["Capture_SpawnDelayTime"] = 150,    -- a foglalo bot 2 spawnolasa kozott el kell telnie valamennyi idonek. ennyi masodperc alatt csokken ez a limit a 'Capture_SpawnDelay' -ben beallitott elso ertekrol a masodikra
		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 1.5,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 0,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.0,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 40000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 500,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["SupportValues"]=	-- tamado csapat osszeallitasnal lehet jutalmazni azt, ha mar meglevo, X tipusu jarmu melle bevalaszt egy masik, Y tipusu jarmuvet, akkor a csapat tamadoertekehez hozzaadodik a harmadik parameterben szereplo ertek. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	{ -- az ertekeknek ugy kell kinezni, hogy SV.., ahol a .. helyere egyre novekvo 2jegyu szamot kell irni. 
	  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		["SV01"] = { "LEVELBOMBER", "FIGHTER", 1.5 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV02"] = { "CARGO", "TORPEDOBOMBER", 1.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV03"] = { "TORPEDOBOAT", "TORPEDOBOAT", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV04"] = { "LANDINGSHIP", "CRUISER", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV05"] = { "CRUISER", "DESTROYER", 1.75 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV06"] = { "CARGO", "CARGO", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV07"] = { "LANDINGSHIP", "LANDINGSHIP", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. Elso ket parameter lehet unittipus is! akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni). 
	{  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		{ "BATTLESHIP", 88, false, 0 },
		{ "BATTLESHIP", 88, true, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", false, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", true, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", false, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", true, 0 },
		{ "LANDINGSHIP", "COMMANDBUILDING", false, 0.18 },
		{ "LANDINGSHIP", "COMMANDBUILDING", true, 0.18 },
		{ "CARGO", "COMMANDBUILDING", false, 1 },
		{ "CARGO", "COMMANDBUILDING", true, 1 },
		{ "TORPEDOBOAT", "PLANE", true, 0 },
		{ "TORPEDOBOAT", "PLANE", false, 0 },
		{ "TORPEDOBOAT", "SHIP", true, 0 },
		{ "TORPEDOBOAT", "SHIP", false, 0 },
		{ "TORPEDOBOMBER", "SHIP", true, 4.5 },
		{ "TORPEDOBOMBER", "SHIP", false, 4.5 },
		{ "DIVEBOMBER", "SHIP", true, 5.0 },
		{ "DIVEBOMBER", "SHIP", false, 5.0 },
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { "TORPEDOBOMBER", "LANDFORT", false, 0.0 },	-- torpedobomberek ne tamadjanak landfortokat
	},	
}
	
HighLvlAIGlobals["IslandCaptureParams_Regular"]=	-- Island Capture mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=1.0,
		["Cargo"]=2.0,
		["TBoat"]=0.001,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=8,
		["DiveBomber"]=8,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.95, 1.05 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.90,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.90,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.90,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.90,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.90,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 1500,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 60.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 80.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 60.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 200.0, 4.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 60.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 120.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.0 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.50,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.30,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = { 15.0,  1.15 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_ActAttackTargetWeightMulDist"] = { 3000.0,  4500.0 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)
		["Capture_SpawnDelay"] = { 15, 5 }, -- a foglalo bot 2 spawnolasa kozott legalabb ennyi idonek el kell telnie, masodpercben. Kezdetben ez a delay az elso ertek, majd 'Capture_SpawnDelayTime' ido alatt lecsokken a masodik ertekre
		["Capture_SpawnDelayTime"] = 150,    -- a foglalo bot 2 spawnolasa kozott el kell telnie valamennyi idonek. ennyi masodperc alatt csokken ez a limit a 'Capture_SpawnDelay' -ben beallitott elso ertekrol a masodikra
		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 1.5,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 0,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.0,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 500,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["SupportValues"]=	-- tamado csapat osszeallitasnal lehet jutalmazni azt, ha mar meglevo, X tipusu jarmu melle bevalaszt egy masik, Y tipusu jarmuvet, akkor a csapat tamadoertekehez hozzaadodik a harmadik parameterben szereplo ertek. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	{ -- az ertekeknek ugy kell kinezni, hogy SV.., ahol a .. helyere egyre novekvo 2jegyu szamot kell irni. 
	  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		["SV01"] = { "LEVELBOMBER", "FIGHTER", 1.5 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV02"] = { "CARGO", "TORPEDOBOMBER", 1.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV03"] = { "TORPEDOBOAT", "TORPEDOBOAT", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV04"] = { "LANDINGSHIP", "CRUISER", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV05"] = { "CRUISER", "CRUISER", 2.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon		
		["SV06"] = { "CARGO", "CARGO", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV07"] = { "LANDINGSHIP", "LANDINGSHIP", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. Elso ket parameter lehet unittipus is! akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni). 
	{  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		{ "BATTLESHIP", 88, false, 0 },
		{ "BATTLESHIP", 88, true, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", false, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", true, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", false, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", true, 0 },
		{ "LANDINGSHIP", "COMMANDBUILDING", false, 0.12 },
		{ "LANDINGSHIP", "COMMANDBUILDING", true, 0.12 },
		{ "TORPEDOBOAT", "PLANE", true, 0 },
		{ "TORPEDOBOAT", "PLANE", false, 0 },
		{ "TORPEDOBOAT", "SHIP", true, 0 },
		{ "TORPEDOBOAT", "SHIP", false, 0 },
		{ "TORPEDOBOMBER", "SHIP", true, 4.5 },
		{ "TORPEDOBOMBER", "SHIP", false, 4.5 },
		{ "DIVEBOMBER", "SHIP", true, 5.0 },
		{ "DIVEBOMBER", "SHIP", false, 5.0 },
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { "TORPEDOBOMBER", "LANDFORT", false, 0.0 },	-- torpedobomberek ne tamadjanak landfortokat
	},	
}

HighLvlAIGlobals["IslandCaptureParams_Veteran"]=	-- Island Capture mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=1.0,
		["Cargo"]=2.0,
		["TBoat"]=0.001,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=8,
		["DiveBomber"]=8,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.95, 1.05 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.25,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.25,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 1500,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 60.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 80.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 60.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 200.0, 4.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 60.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 120.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.0 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.50,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.30,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = { 15.0,  1.15 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_ActAttackTargetWeightMulDist"] = { 3000.0,  4500.0 },  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)
		["Capture_SpawnDelay"] = { 5, 1 }, -- a foglalo bot 2 spawnolasa kozott legalabb ennyi idonek el kell telnie, masodpercben. Kezdetben ez a delay az elso ertek, majd 'Capture_SpawnDelayTime' ido alatt lecsokken a masodik ertekre
		["Capture_SpawnDelayTime"] = 150,    -- a foglalo bot 2 spawnolasa kozott el kell telnie valamennyi idonek. ennyi masodperc alatt csokken ez a limit a 'Capture_SpawnDelay' -ben beallitott elso ertekrol a masodikra
		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 1.5,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 0,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.0,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 500,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["SupportValues"]=	-- tamado csapat osszeallitasnal lehet jutalmazni azt, ha mar meglevo, X tipusu jarmu melle bevalaszt egy masik, Y tipusu jarmuvet, akkor a csapat tamadoertekehez hozzaadodik a harmadik parameterben szereplo ertek. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	{ -- az ertekeknek ugy kell kinezni, hogy SV.., ahol a .. helyere egyre novekvo 2jegyu szamot kell irni. 
	  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		["SV01"] = { "LEVELBOMBER", "FIGHTER", 1.5 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV02"] = { "CARGO", "TORPEDOBOMBER", 1.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV03"] = { "TORPEDOBOAT", "TORPEDOBOAT", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV04"] = { "LANDINGSHIP", "CRUISER", -100.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV05"] = { "CRUISER", "CRUISER", 2.0 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon		
		["SV06"] = { "CARGO", "CARGO", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
		["SV07"] = { "LANDINGSHIP", "LANDINGSHIP", -100 },  -- ha az elso parameterben levo tipusu jarmuvek melle bevalaszt egy masodik parameteru jarmuvet, akkor a kiszamolt csapat tamadoertekhez hozzaadja a harmadik parameterben szereplo erteket. Ha az negativ, akkor buntetni is lehet, hogy milyen parositast ne valasszon
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. Elso ket parameter lehet unittipus is! akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni). 
	{  -- lehetseges ertekek: fighter, levelbomber, torpedobomber, divebomber, smallreconplane, largereconplane, reconplane (az összes, small + large együtt), kamikazeplane, plane (az összes repülõ),  destroyer, submarine, mothership, cruiser, cargo, landingship, battleship, torpedoboat, ship (az összes hajó), landfort, commandbuilding, vehicle (az összes jarmü)
		{ "BATTLESHIP", 88, false, 0 },
		{ "BATTLESHIP", 88, true, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", false, 0 },
		{ "TORPEDOBOAT", "COMMANDBUILDING", true, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", false, 0 },
		{ "SUBMARINE", "COMMANDBUILDING", true, 0 },
		{ "LANDINGSHIP", "COMMANDBUILDING", false, 0.12 },
		{ "LANDINGSHIP", "COMMANDBUILDING", true, 0.12 },
		{ "TORPEDOBOAT", "PLANE", true, 0 },
		{ "TORPEDOBOAT", "PLANE", false, 0 },
		{ "TORPEDOBOAT", "SHIP", true, 0 },
		{ "TORPEDOBOAT", "SHIP", false, 0 },
		{ "TORPEDOBOMBER", "SHIP", true, 4.5 },
		{ "TORPEDOBOMBER", "SHIP", false, 4.5 },
		{ "DIVEBOMBER", "SHIP", true, 5.0 },
		{ "DIVEBOMBER", "SHIP", false, 5.0 },
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { "TORPEDOBOMBER", "LANDFORT", false, 0.0 },	-- torpedobomberek ne tamadjanak landfortokat
	},	
}
	
HighLvlAIGlobals["DuelParams"]=	-- Duel mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=2.0,
		["Cargo"]=2.0,
		["TBoat"]=2.0,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=1.5,
		["DiveBomber"]=1.5,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.85, 1.1 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.25,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.25,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 4000,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 90.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 30.0, 12.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 25.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 20.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.1 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.20,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.4,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = 1.5,  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)

		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 2.0,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 100,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.10,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 300,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni)
	{
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
	},	 
}
	
HighLvlAIGlobals["EscortParams"]=	-- Escort mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=2.0,
		["Cargo"]=2.0,
		["TBoat"]=2.0,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=8,
		["DiveBomber"]=8,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.85, 1.1 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.25,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.25,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 4000,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 90.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 30.0, 12.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 25.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 20.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.1 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.20,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.4,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = 1.5,  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)

		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 2.0,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 100,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.10,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 9000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 15000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 6000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 6000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 300,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.1,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni)
	{
		{ "FIGHTER", "SHIP", true, 0 },
		{ "FIGHTER", "SHIP", false, 0 },
		{ "FIGHTER", "TORPEDOBOAT", true, 5 },
		{ "FIGHTER", "TORPEDOBOAT", false, 5 },
		{ "TORPEDOBOMBER", "FIGHTER", true, 0 },
		{ "TORPEDOBOMBER", "FIGHTER", false, 0 },
		{ "TORPEDOBOMBER", "TORPEDOBOMBER", true, 0 },
		{ "TORPEDOBOMBER", "TORPEDOBOMBER", false, 0 },
		{ "DIVEBOMBER", "FIGHTER", true, 0 },
		{ "DIVEBOMBER", "FIGHTER", false, 0 },
		{ "DIVEBOMBER", "DIVEBOMBER", true, 0 },
		{ "DIVEBOMBER", "DIVEBOMBER", false, 0 },
		{ "FIGHTER", "LANDFORT", true, 0 },
		{ "FIGHTER", "LANDFORT", false, 0 },
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
	},	 
}
	
HighLvlAIGlobals["SiegeParams"]=	-- Siege mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=2.0,
		["Cargo"]=2.0,
		["TBoat"]=2.0,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=1.5,
		["DiveBomber"]=1.5,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.85, 1.1 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.25,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.25,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 4000,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 90.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 30.0, 12.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 25.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 20.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.1 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.20,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.4,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = 1.5,  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)

		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 2.0,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 100,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.10,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 300,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni)
	{
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
	},	
}
	
HighLvlAIGlobals["CompetitiveParams"]=	-- Competitive mod parameterei
{
	["UnitWeights"]=	-- az inicializalasnal a sulyozasa a unitoknak. Ezt a sulyt lehet felszorozni konkret unitoknal a AISetHintWeight(entity,sulyszorzo) lua fugvennyel
	{
		["MotherShip"]=25.0,
		["BattleShip"]=20.0,
		["Cruiser"]=12.0,
		["Destroyer"]=8.0,
		["Submarine"]=4.0,
		["LandingShip"]=2.0,
		["Cargo"]=2.0,
		["TBoat"]=2.0,
		["OtherShip"]=1.0,  -- itt fel nem sorolt tipusu hajo
		
		["CommandBuilding"]=15,
		["Landfort"]=1,
		
		["LevelBomber"]=2.0,
		["KamikazePlane"]=2.0,
		["TorpedoBomber"]=1.5,
		["DiveBomber"]=1.5,
		["Fighter"]=1.0,
		["ReconPlaneSmall"]=1.0,
		["ReconPlaneLarge"]=1.0,
		["OtherPlane"]=1.0,  -- itt fel nem sorolt tipusu repulo
		["Other"]=1.0,  -- itt fel nem sorolt jarmu
	},
	
	["AttackerVSTarget"]=	-- az 1 vs 1 elleni tamadoertek kiszamitasahoz szukseges parameterek. Azt nezi, a tamado x ido alatt mennyi sebzest tud okozni a tamadottnak
	{
		["DamageCalcTime"] = 60,  -- ennyi masodperc alatti sebzest szamol
		["MaxTargetKillRatio"] = 150.0,  -- az okozhato sebzest limitaljuk, hogy maximum a celpont HP-janak ennyiszerese sebzest veszunk az adott ido alatt. CB eseten a foglalassal okozhato sebzesre ez nem vonatkozik!
		["DogfightEquipmentPenalty"] = 0.6,  -- ha egy repulo dogfightolva, vagy strafeelve tamad valakit, es van nem raketa equipmentje, akkor ennyivel megszorozzuk a tamadoerteket. ez 1-nel kisebb legyen, hogy buntetes legyen az equipment olyan tamadaskor, ahol nincs hasznalva.
--	["AttackerReferenceSpeed"] = 200,  -- !!!EZ KISZEDVE!!! a sebzest megszorozzuk (1.0 + (attackerSpeed/ez)) ertekkel. azaz a tamado sebessege is szamit kicsit, ez az ertek minel nagyobb, annal kevesbe.
		["ValueRandomMul"] = { 0.85, 1.1 },	 -- a kiszamolt tamadoerteket randomizaljuk, megszorozzuk egy random szammal, ebbol az intervallumbol

		["Capture_SmallLandingShipSurviveMul"] = 0.25,  -- CB foglalasnal a transportship altal kikuldott kishajok hany szazaleka fog partraerni. 0.0 - 1.0 kozotti ertek, 0-nal egy se, 1-nel mind
		["Capture_InRangeCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert benne van a hajo a capture rangeben.
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedCaptureMul"] = 0.25,  -- CB foglalasnal mennyire szamitsa bele azt a foglaloerteket, ami azert van, mert partrafutott egy landingship. 0.0 es 1.0 kozotti ertek
		["Capture_LandedDamageMul"] = 0.25,    -- CB foglalasnal mikor partrafut egy kishajo, az o altala okozott Damage sebzes mennyire szamitson. 0.0 es 1.0 kozotti ertek

		-- hajo sulyanak valtoztatasa a celpont tavolsagatol fuggoen
		["ShipDistWeight_AriveDist"] = 3000,   -- hajoknal mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["ShipDistWeight_TravelTime"] = { 60.0, 300.0 }, -- hajoknal megnezi, hogy mennyi ido alatt erne oda a cel ShipDistWeight_ArriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["ShipDistWeight_WeightMul"]  = { 1.0, 0.1 },    -- mekkora a hajok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		["PlaneDistWeight_AriveDist"] = 4000,   -- repuloknel, mikor azt nezi, hogy mennyi ido alatt er el a celpontjahoz, akkor a celpont tavolsagat csokkenti ennyivel, azaz eleg a celpontot ennyire megkozeliteni hogy ugy vegyuk, hogy odaert
		["PlaneDistWeight_TravelTime"] = { 0.0, 90.0 }, -- repuloknel megnezi, hogy mennyi ido alatt erne oda a cel PlaneDistWeight_AriveDist sugaru kozelebe. ez alapjan van egy tamadoertek rontas. Ha az elso erteknyi masodpercnel hamarabb er oda, akkor nincs rontas, ha a masodik erteknel kesobb, akkor maximalis a rontas. koztuk linearis az atmenet
		["PlaneDistWeight_WeightMul"]  = { 1.0, 1.0 },    -- mekkora a repulok tamadoertek rontasa kozeli (elso ertek) es tavoli (masodik ertek) celpontok ellen.
		
		
		-- repulogep tamadaskor az egyes fegyverekkel,fuggesztmenyekkel nem folyamatosan lovi a celpontot, hanem valamilyen idokozonkent, valamennyi ideig tamad. Peldaul Divebombazasnal kell egy bizonyos ido a manover megismetlesehez, es manoverenkent csak maximum x darab bombat tud ledobni.
		["DogfightParams"]  = { 8.0, 3.0, 4.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["StrafeParams"]    = { 18.0, 8.0, 16.0 }, -- Az elso parameternyi idokozonkent a masodik parameternyi ideig lo geppityuval, es ellohet harmadik parameter szamu kis raketat
		["TailGunParams"]   = { 15.0, 8.0 }, -- Az elso parameternyi idotartam alatt atlagosan a masodik parameternyi ideig lo a farokloveszekkel a repulo celpontra
		["TorpedoParams"]   = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["DivebombParams"]  = { 25.0, 3.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["LevelbombParams"] = { 30.0, 12.0 }, --Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es tamadasonkent maximum a masodik parameterben megadott bomba fog betalalni. Azaz hiaba van 40 bomba egy levelbombazon, az kizart, hogy mind a 40 a celpontra essen. A manover ideje valtozhat a reload idejetol
		["DCParams"]        = { 25.0, 4.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
		["BigRocketParams"] = { 20.0, 2.0 }, -- Az elso parameternyi ido alatt tud vegrehajtani egy tamadas manovert, es egy manover alatt maximum a masodik parameternyi szamu fuggesztmenyt tud ledobni. A ledobott fuggesztmeny szama persze fugg attol, hogy mennyi van a konkret repulon, illetve a manover ideje is fugg a fuggesztmeny reload idejetol, ha elfogynak a fuggesztmenyek
	},

	["SpawnAgainstTargets"]=	-- egy konkret target group ellen probal mindig spawnolni. az ilyen a spawnolasnak a parameterei
	{
	  -- egy adott csapat spawn erteke a target group ellen fugg attol is, mennyi ido alatt tud odaerni a spawnban meghatarozott ponthoz. ennek a parameterei:
		["TravelTimeValue"] = { 40, 240 },   -- masodpercek. az utazasi ido le lesz kerekitve ebbe az intervallumba.
		["TravelTimeMul"]   = { 1.0, 0.5 },  -- az utazasi idotol fuggo szorzo erteke. a legkisebb utazasi idonel az elso szorzot veszi, a legnagyobb utazasi idonel a masodikat, a ketto kozott meg interpolal
	},

	["BulletTypeAccuracy"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["MachineGun"]  = { 0.10, 0.15, 0, 0.1 },   -- Repulore/Kishajora/Nagyhajora/Landfortra geppityu es AA talalati esely 
		["Artillery"]   = { 0.00, 0.50, 0.70, 0.55 },   -- Repulore/Kishajora/Nagyhajora/Landfortra artillery talalati esely 
		["Flak"]        = { 0.50, 0.20, 0.00, 0.00 },   -- Repulore/Kishajora/Nagyhajora/Landfortra flak blast talalati esely
		["Bomb"]        = { 0.00, 0.50, 0.70, 0.20 },   -- Repulore/Kishajora/Nagyhajora/Landfortra repulorol dobott bomba talalati esely
		["Kamikaze"]    = { 0.00, 0.50, 0.70, 0.80 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kamikaze repulo becsapodasi talalati esely
		["SmallRocket"] = { 0.15, 0.25, 0.70, 0.50 },   -- Repulore/Kishajora/Nagyhajora/Landfortra kis raketa (pl. dogfight kozbel lovoldozheto raketak) talalati esely
		["BigRocket"]   = { 0.00, 0.25, 0.90, 0.75 },   -- Repulore/Kishajora/Nagyhajora/Landfortra nagy raketa (bombaszeru fuggesztmenykent viselkedo raketa)talalati esely
		["Torpedo"]     = { 0.75, 0.45 },    -- Hajora/Tengeralattjarora torpedo talalati esely
		["DepthCharge"] = 0.20,  -- DC talalati esely tengeralattjarokra
		["Paratroopers"] = 0.4,  -- ejtoernyos talalati esely CommandBuildingre
	},
	
	["Constants"]=	-- egy adott bullettype-al ha lovunk egy adott fajta celpontot, akkor sebzesszamitasnal mekkora talalati szorzot hasznaljon, azaz atlag mekkora esellyel talal egy tolteny egy celpontot
	{
		["AutoMerge_MergeDist"] = 650,  -- a parancs nelkuli unitokat osszeszedi egy groupba, ha ennel kozelebb vannak egymashoz
		["AutoMerge_LeaveDist"] = 1200,  -- ha egy grouptag ennel jobban lemarad a leadertol, akkor kikerul a groupbol

		["PartyPresence_DistanceMin"] = 2000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		["PartyPresence_DistanceMax"] = 4000,  -- milyen tavolsagban nezze, hogy mennyire vannak jelen ellenfelek egy adott pont kornyeken. Aki Min-en belul van, annak a sulya1, aki Max-on kivul, aze 0.
		
		["Capture_ArriveToRangeTime"] = 30,  -- mikor capture erteket szamol egy konkret unit vs konkret CB ellen, akkor onnantol szamit a unit Capture erteke, ha ennyi mp-en belul eleri a CaptureRange-t
		["Capture_CapturePointResourceValue"] = 35,  -- 1 capture pont mennyi resourcenak felel meg
		["Capture_MinimalResource"] = 200,  -- mikor egy foglalo csapatot csinal egy CB ellen, akkor legalabb ennyi resourcenyi foglalot kuld
		["Capture_CollectDefendersDist"] = 3000,  -- milyen messzirol szedje ossze az ellenseges CB korul azokat, akik ellen osszeszedi a tamado csapatot
		["Capture_ActAttackTargetWeightMul"] = 1.5,  -- a mar letezo groupokra idonkent megnezi, hogy ki ellen mennyire jok, es ez alapjan felulbiralhatja az aktualis celpontjat. A jelenlegi celpontja kap egy kis bonuszt, annak a 'josaga' megszorzodik ezzel
		["Capture_MinimalCBTargetWeight"] = 0.5,    --  mikor egy elfoglalando CB fontossagat nezi, akkor a 'fontossag' legalabb ennyi lesz minden CB eseten. ez lesz megszorozva StrategicGain-el
		["Capture_CommandBuildingStrategicWeightMul"] = 0.8,    -- a vegso sulya egy CB-nek, hogy mennyire fontos elfoglalni, az a CB strategiai fontossaga es a tamado csapat CB elleni tamadoertekenek valamilyen aranyu osszege. ilyen aranyban szamit a CB strategiai sulya (es 1-ez sullyal a tamado csapat tamadoerteke)

		
		["Defend_MergeTargetDist"] = 500,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak a vedendo celponthoz.
		["Defend_MergeGroupsDist"] = 300,  -- akik ugyanazt a celpontot vedik, azokat osszevonhatja. Akkor von ossze 2 groupot. ha ennel kozelebb vannak egymashoz.
		["Defend_CollectEnemiesDist"] = 4000,  -- a CB-tol milyen tavolsagra nezi az ellenfeleket
		["Defend_AgainstEnemyResourceMul"] = 2.0,  -- ha vedekezik, akkor amennyi resourcepontbol kene neki vedekeznie egy adott tamado sereg ellen, azt megszorozza ennyivel. Finomhangolashoz hasznalhato, hogy altalanosan tobb/kevesebb vedelmet spawnoljon
		["Defend_MinimalResource"] = 100,  -- ha ugy dont hogy vedekezik egy CB korul, akkor legalabb ennyi resourcenyi vedekezo erot spawnol oda
		["Defend_ResourcePercent"] = 0.10,  -- az ossz resource ennyiszereset fogja vedekezesre forditani
				
		["CautionMove_Dist"] = 8000,  -- ha ennel kozelebb van a celpont, akkor nem fog ovatosan mozogni
		
		["FreeAttack_ObjectiveTargetMul"] = 2.0,  -- az objektivaunitok fontossaga ennyiszerese a nem objektivaunitoknak
		["FreeAttack_NearDist"] = 5000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["FreeAttack_FarDist"] = 12000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["FreeAttack_ExistingTargetMul"] = 2,  --  aki jelenleg a celpontja, annak a sulya ennyiszeresen szamit

		["CloseAttack_CollectDist"] = 3000,  -- milyen tavolsagbol valtson at move-rol attack-ra
		["CloseAttack_NearDist"] = 3000,  -- ennel kozelebb levo ellenfelek egyenranguak. aki tavolabb van, annak mar csokken a fontossaga
		["CloseAttack_FarDist"] = 6000,  -- a NearDist-nel tavolabb levo ellenfelek sulya linearisan csokken eddig a tavolsagig. aki ennel messzebb van, az mar nem szamit
		["CloseAttack_ExistingTargetMul"] = 1.8,  --  aki jelenleg a KONKRET GAME UNITNAK UNIT SZINEN A TARGETJE, annak a sulya ennyiszeresen szamit (akit a unit epp bot szinten tamad)
		["CloseAttack_TargetGroupMemberMul"] = 10,  --  aki GROUP SZINTEN, A TAMADO GROUPNAK A CELPONT GROUPJA, a celpont group tagjaira ennyivel jobban szeret tamadni. azaz skirmish ai szinten aki a celpontja az adott unitnak, nem pedig akit epp a pilotbot tamad pl

		["Formation_UnitDist"] = 300,  -- formacional ilyen tavolra rakja a unitokat

   -- egy tamado csoport tamado erteke adott celpontok ellen:
     -- attackerSum    : egyenkent, az osszes tamado unit tamadoerteke egyenkent, az osszes target unit ellen. Ezeknek az osszege ez.
     -- attackMaxes    : minden egyes target unitra megjegyzi, hogy mi volt a legnagyobb tamadoertek, amit valaki elert ellene
     -- attackMaxesSum : minden egyes target unithoz tartozik egy attackMax ertek, ezen ertekek osszege
     -- noAttackCount  : azon target unitok szama, akiknel az attackMax 0 volt, azaz egyik tamado unit sem tudta ot bantani
     -- repeatCount    : hanyszor ismetlodik egy adott unit a tamado unitok kozott. ez igy no az ismetlodesek szamaval: 2x: 1,  3x: 3, 4x: 6, 5x: 10, stb 
     -- groupspeed     : a leglassabb unit sebessege a tamado unitok kozzul
     -- WEIGHT_BASE      : (('ComposeGroup_AttackSumMul' * attackerSum) + attackMaxesSum) / 'ComposeGroup_ReferenceWeight'
     -- NOATTACK_PENALTY : noAttackCount * 'ComposeGroup_NoAttackPenalty' 
     -- REPEAT_PENALTY   : repeatCount * 'ComposeGroup_NoAttackPenalty'
     -- SPEED_BONUS      : MIN('ComposeGroup_SpeedBonusWeightRatio' * WEIGHT_BASE, groupspeed * 'ComposeGroup_SpeedBonusWeightRatio')
     -- GROUPVALUE --    : ez a vegso ertek, ez szamit: (WEIGHT_BASE + SPEED_BONUS) - (NOATTACK_PENALTY + REPEAT_PENALTY)
		["ComposeGroup_ReferenceWeight"] = 5.0,  -- ez minel nagyobb, annal erosebbek lesznek a kulonbozo buntetesek, es annal kevesbe szamit a tenyleges, sebzessel okozot tamadoertek
		["ComposeGroup_AttackSumMul"] = 0.33,    -- mekkora sullyal szamitson az osszes unit ossz tamadoerteke az egyenkenti max tamadoertekekkel szemben
		["ComposeGroup_AttackerDontAttackPenalty"] = 0.5,  -- azon tamado unitokra a buntetes, akik nem tudnak tamadni senkit
		["ComposeGroup_TargetDontAttackedPenalty"] = 2.0,  -- azon tamadott unitokra  abuntetes, akiket nem tud tamadni senki
		["ComposeGroup_RepeatPenalty"] = 1.0,  -- az ismetlodesek mennyire legyenek buntetve
		["ComposeGroup_SpeedBonusWeightRatio"] = 0,  -- a speedbonusz aranya maximum ekkora lehet a buntetesek nelkuli alap csoport tamadoertekhez kepest
		["ComposeGroup_SpeedBonus"] = 0,  -- a csapat sebessege ennyivel megszorozva lesz a bonusz erteke
		
		["ComposeGroup_GroupCostModifier"] = 0.4,  -- 0 es 1 kozott: mennyire rontsa egy tamado group erteket az, hogy tobb costba kerul. 0.0 eseten: semennyire, 1.0 eseten: ha egy group 2x annyi pontba kerul mint egy masik, akkor 2x akkora tamadoertek kell neki hogy o legyen a jobb
		["ComposeGroup_AttackerAgainstTargetMul"] = 1.0,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadok sulya a tamadottak ellen
		["ComposeGroup_TargetAgainstAttackerMul"] = 0.4,  -- mikor egy adott tamado group sulyat nezi egy adott tamadott group ellen, akkor mekkora szorzoval szamitson a tamadottak sulya a tamadok ellen
	},
	
	["ForcedTargetWeightValues"]=	-- egy konkret vehicleclass tamadoerteket lehet felulirni egy masik konkret vehicleclassal szemben. akar konkretan, akar mas referencia paroshoz kepest relative. HA HASZNALTOK REFERENCIAERTEKEKET, AKKOR HA x PAROS FUGG y PAROSTOL, AKKOR y PAROS ERTEKE HAMARABB LEGYEN FELSOROLVA, MINT x !!! (mar ha y-t is felul akarjuk definialni)
	{
	  -- ezek csak proba ertekek hogy lassatok a szintaktikat!!!! 
		-- { 66, 55, false, 1.0 },	-- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
		-- { 44, 33, false, 66, 55, false, 1.5 },  -- tamado vehicleclass, tamadott vehicleclass, neutral-e a tamadott, [referencia tamado vehicleclass, referencia tamadott vehicleclass, neutral-e a referencia tamadott,] a suly erteke
	},	
}