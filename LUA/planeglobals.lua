--SceneFile="universe\Scenes\draven\keyboard.scn"
PlaneGlobals = {}

PlaneGlobals["CloseToCameraDist"] = 1500.0 -- ennel messzebb nem forog a rotor, nem mozog a kormanyfelulet
PlaneGlobals["MoveDetailLODError"] = 0.8 -- (0..1) ennel nagyobb lod error eseten nem forog a rotor, nem mozog a kormanyfelulet
PlaneGlobals["MoveDetailRadius"] = 25.0 -- ennyi meretunek veszunk minden repulot a loderror szamitasnal, hogy ne kelljen gepenkent kulon allitgatni loderrort

PlaneGlobals["MultiPlayer"]=    
{
  ["SyncSendMul"] = 1.0, -- a repulok szinkronuzeneteinek szamat lehet valtoztatni. 1.0 az alapeset, ha noveljuk, akkor annyival surubben lesznek szinkronuzenetek kuldozgetve
  ["SyncUploadLimitKBitPerSec"] = 1024,  -- a szerver szinkronuzenet feltoltesenek a limitje, KBitPerSec.
}

PlaneGlobals["PlaneSounds"]=    
{
}

PlaneGlobals["WingTip"]=
{
	["MaxAlpha"]=1.0,
	["MaxalphaOwnPlane"]=0.5,
}

PlaneGlobals["PlaneCamera"]=
{
	["DistZ"]               =1.5,
	["DistY"]               =0.6,

	["ZRotMul"]             =0.3,
	["ZRotSmoothRate"]      =1.75,

	["XDistMul"]            =5.0,
	["XDistSmoothRate"]     =5.0,

	["YDistMul"]            =2.0,
	["YDistSmoothRate"]     =7.0,
	["YDistRollMul"]        =.5,
	["YDistRollSmoothRate"] =1.0,
	
	["ZDistMul"]            =0.00,
	["ZDistSmoothRate"]     =10.0,

	["LookAroundSmoothRate"]=10.0,

	["ShipYardDist"]        =100.0,
	
	["CockpitFOVMul"]      = 0.85,    -- ennyivel szorzodik meg az alap repulo FOV, ha cockpitbe ulunk
	["CockpitSmooth"]      = 0.5,     -- ennyi mp alatt fordul oda a kamera, ahova mondjuk
	["CockpitYawTurn"]     = DEG(5),  -- labkormanyt mozgatva ennyire forog a kamera vizszintesen
	["CockpitPitchTurn"]   = DEG(5),  -- magassagi kormanyt huzva ennyire forog a kamera fel es le
	["CockpitRollTurn"]    = DEG(14), -- rollozasnal ennyire forog a kamera az elore vektor korul
	["CockpitRollHTurn"]   = DEG(9), -- rollozasnal ennyire forog oldalra a kamera
	["CockpitRollVTurn"]   = DEG(2),  -- rollozasnal ennyire forog fel/le a kamera
	["CockpitViewHMax"]    = DEG(80), -- szabad nezelodeskor ennyire lehet oldalra nezni
	["CockpitViewVMin"]    = DEG(35), -- szabad nezelodeskor ennyire lehet lefele nezni
	["CockpitViewVMax"]    = DEG(70), -- szabad nezelodeskor ennyire lehet felfele nezni

	["CockpitMaxHeadMoveDist"]     = 0.06,   -- maximum ennyit mozoghat a fej egy nagyobb utkozes eseten
	["CockpitGunfireEffectSize"]   = 0.005, -- ennyi metert razkodik
	["CockpitGunfireEffectTime"]   = 0.02,  -- ennyi masodpercenkent van 1 uj remeges
	["CockpitGunfireEffectSmooth"] = 0.1,  -- ennyi masodperc alatt csillapodik le 1 remeges
	
	

	["FOVMinSpeed"]        = 80,    -- m/s,  ekkora sebesseg folott kezd el valtozni a FOV a sebesseg fuggvenyeben
	["FOVMaxSpeed"]        = 100,   -- m/s,  ekkora sebessegig valtozik a FOV a sebesseg miatt
	["FOVMinSpdMul"]       = 1.0,   -- m/s,  minimalis sebessegnel a FOV ennyivel szorzodik meg
	["FOVMaxSpdMul"]       = 1.3,   -- m/s,  maximalis sebessegnel a FOV ennyivel szorzodik meg
	["FOVMinAccel"]        = 0.5,   -- m/s2, ekkora gyorsulas felett kezd el valtozni a FOV a gyorsulas fuggvenyeben
	["FOVMaxAccel"]        = 8.0,   -- m/s2, ekkora gyorsulasig valtozni a FOV a gyorsulas fuggvenyeben
	["FOVAccelMul"]        = 1.0,   -- m/s2, max gyorsulasnal ennyivel szorzodik a FOV
	
	["TurboMotionBlurMinSpeed"] = 80,
	["TurboMotionBlurMaxSpeed"] = 100,
	["TurboMotionBlurMaxBlur"] = 0.1,
	
	
}

PlaneGlobals["BombCamera"]=
{
	["MinCameraAlt"]           = 2,		  -- a kamera a talajhoz kepest ennel alacsonyabban nem lehet
	["CameraPosSmooth"]        = 0.75,  -- mennyire finoman mozogjon a kamera, milyen gyorsan menjen at az elozo poziciobol a kovetkezo pozicioba. minel nagyobb, annal gyorsabban
	["FinalCameraPosSmooth"]   = 2.0,   -- ezt nem hasznaljuk semmire, majd kiszedem innen
	
	["TorpedoNearAlt"]         = { 80,  30 },	-- fuggoleges iranyban milyen messze van a bomba a becsapodastol. ha az elso erteknel messzebb, akkor kozelrol mutatjuk a bombat (FollowDistNear), ha a masodik erteknel kozelebb, akkor mar messzirol mutatjuk (FollowDistFar)
	["TorpedoFollowDistNear"]  = 30,  -- amig a bomba messze van a celponttol, addig ilyen kozelrol muatjuk
	["TorpedoFollowDistFar"]   = 80,  -- ha mar kozel van, akkor ilyen tavolrol mutatjuk
	
	["RocketNearAlt"]         = { 80,  30 }, -- fuggoleges iranyban milyen messze van a bomba a becsapodastol. ha az elso erteknel messzebb, akkor kozelrol mutatjuk a bombat (FollowDistNear), ha a masodik erteknel kozelebb, akkor mar messzirol mutatjuk (FollowDistFar)
	["RocketFollowDistNear"]  = 30,  -- amig a bomba messze van a celponttol, addig ilyen kozelrol muatjuk
	["RocketFollowDistFar"]   = 80,  -- ha mar kozel van, akkor ilyen tavolrol mutatjuk
	
	["BombNearAlt"]            = { 380, 120 }, -- fuggoleges iranyban milyen messze van a bomba a becsapodastol. ha az elso erteknel messzebb, akkor kozelrol mutatjuk a bombat (FollowDistNear), ha a masodik erteknel kozelebb, akkor mar messzirol mutatjuk (FollowDistFar)
	["BombFollowDistNear"]     = 40,  -- amig a bomba messze van a celponttol, addig ilyen kozelrol muatjuk
	["BombFollowDistFar"]      = 160, -- ha mar kozel van, akkor ilyen tavolrol mutatjuk
	
	["BulletNearAlt"]            = { 380, 120 }, -- fuggoleges iranyban milyen messze van a bomba a becsapodastol. ha az elso erteknel messzebb, akkor kozelrol mutatjuk a bombat (FollowDistNear), ha a masodik erteknel kozelebb, akkor mar messzirol mutatjuk (FollowDistFar)
	["BulletFollowDistNear"]     = 40,  -- amig a bomba messze van a celponttol, addig ilyen kozelrol muatjuk
	["BulletFollowDistFar"]      = 160, -- ha mar kozel van, akkor ilyen tavolrol mutatjuk
	
	["FinalDist"]              = 210, -- becsapodas utan ilyen tavolsagrol mutatjuk
	["FinalCameraSmooth"]      = 10.0, -- mennyire gyorsan tavolodjon a kamera becsapodas utan a bombatol. minel nagyobb, annal gyorsabban
	["CamVelBlenderAcceleration"]=0.005,  -- a kamera sebessegvaltozasanak a gyorsulasa. 0-1 kozott, mindel nagyobb, annal gyorsabban fog a kamera sebessege valtozni
	["MaxCamVelBlender"]		=0.5,  -- mennyire finoman valtozzon a kamera sebessege. 0 es 1 kozott, minel nagyobb, annal durvabban fog sebesseget valtoztatni a kamera

	["BombSubDistLimit"]       = 30,    -- ennel alacsonyabb szogben repulesnel kezdjuk levinni a kamerat a gep ala
	["BombSubDistMin"]         = 5,     -- legfeljebb ennyivel megyunk a gep ala
	["BombSubDistMul"]         = 0.25,  -- szorzo, szamolashoz (szogelteresbol ezzel lesz magasag ertek)
	["TorpedoSubDist"]         = -7.5,    -- torpedonal ennyivel a gep ala visszuk a kamerat (kis gep)
	["TorpedoSubDist2"]        = -7.5,    -- torpedonal ennyivel a gep ala visszuk a kamerat (nagy gep)
	["TorpedoSubAngle"]        = -0.1,  -- torpedonal ennyivel lebolintunk (kis repulonel)
	["TorpedoSubAngle2"]       = -0.2,  -- torpedonal ennyivel lebolintunk (nagy repulonel)
}

PlaneGlobals["PlaneGUI"]=
{
	["PitchYawZoomControlLimit"]   = 0.8,
	["RollZoomControlLimit"]       = 1.0,
	["AltimeterCeiling"]           = 1600,
	["MouseInputMultiplier"] = 1.0,
	["MouseInputDeadZoneMin"] = 0.05,
	["MouseInputDeadZoneMax"] = 0.95,
	["MouseInputSmoothTreshold"]   = 1.1,
	["MouseInputSmoothMultiplier"] = 0.50,
	["MouseInputExponencialWeight"] = 0.0,
	["SpeedDisplayMultiplier"] = 2,
}

PlaneGlobals["Sound"]=
{
	["EnginePowerMultiplier"] = 0.7,  -- motorhang pitchben ennyire szamit a gazkar allasa
	["EngineSpeedMultiplier"] = 0.35, -- motorhang pitchben ennyire szamit a sebesseg
	["IdleOffVolume"] = 0.5, -- ekkora toloeronel halkul el teljesen az idle effekt. (fontos: a GUI-n latott toloero nem egyenesen aranyos a tenyleges toloerovel)
	["EngineMinFreq"] = 0.4, -- minimalis pitch motorhangnal. 0 gazkarnal, ennyi a motorhang pitch
	["EngineMaxFreq"] = 1.0, -- maximalis pitch szorzo
	["EngineFreqLimitSpdMul"] = 0.6, -- ha az aktualis_sebesseg/max_sebesseg ertek 1-nel nagyobb, akkor ekkora mertekben noveli a max motorhang frekvenciat, hogy kicsit gyorsabban porogjon a motor zuhanas kozben
	["EngineFreqLimitMax"]    = 1.4, -- a motorhang frekvenciaja zuhanas miatt nagyobb lehet a max frekvencianal, de maximum a max frekvencia ennyiszerese lehet
	["IdleAndEngineVolMax"]   = 1.5, -- amikor atblendelodik az idle es a normal motorhang egymasba, akkor kettejuk hangereje osszesen ennyi 
	["PitchChangeRate"] = 10.0,  -- max ennyit valtozik a pitch szorzo masodpercenkent
	["VolumeChangeRate"] = 10.0, -- max ennyit valtozik a hangero masodpercenkent
	["IdleSafetyTime"] = 2.0, -- ennyi ideig kell repules utan a foldon/vizen tartozkodni hogy bejohessen az idle effekt 
						-- (kulonben vizen pattogaskor hulye nahgja lenne)
						
	["WindVolMinSpdRatio"]    =0.4,  -- ha az aktualis_sebesseg/max_sebesseg kisebb ennel, akkor 0 a szelzugas hangereje
	["WindVolMaxSpdRatio"]    =0.9,  -- ha az aktualis_sebesseg/max_sebesseg nagyobb ennel, akkor 1 a szelzugas hangereje

	["WindPitchMinSpdRatio"]  =0.8,  -- ha az aktualis_sebesseg/max_sebesseg kisebb ennel,  akkor minimalis a szelzugas pitch-je
	["WindPitchMaxSpdRatio"]  =2.5,  -- ha az aktualis_sebesseg/max_sebesseg nagyobb ennel, akkor maximalis a szelzugas pitch-je
	["WindPitchMin"]          =0.9,  -- ez a szelzugas minimalis pitch-je
	["WindPitchMax"]          =1.2,  -- ez a szelzugas maximalis pitch-je

	["FallVolMinSpdRatio"]    =1.2,  -- ha az aktualis_sebesseg/max_sebesseg kisebb ennel, akkor 0 a futyules hangereje
	["FallVolMaxSpdRatio"]    =1.8,  -- ha az aktualis_sebesseg/max_sebesseg nagyobb ennel, akkor 1 a futyules hangereje
	
	["FallPitchMinSpdRatio"]  =1.3,  -- ha az aktualis_sebesseg/max_sebesseg kisebb ennel,  akkor minimalis a futyules pitch-je
	["FallPitchMaxSpdRatio"]  =4.0,  -- ha az aktualis_sebesseg/max_sebesseg nagyobb ennel, akkor maximalis a futyules pitch-je
	["FallPitchMin"]          =0.8,  -- ez a futyules minimalis pitch-je
	["FallPitchMax"]          =1.2,  -- ez a futyules maximalis pitch-je
}

PlaneGlobals["Rotor"]=
{
	["SpeedBase"] = DEG(360.0),	-- fok per masodperc
	["StillMultiplier"] = 5.0, -- ha ez nem egesz szam, csunya dolgok tortenhetnek
	["SpeedRandom"] = 0.1, -- ez fugg a fentiektol, pl. 
		-- SpeedBase = 1.0 SpeedRandom = 0.1 eseten a szorzo 0.1, 
		-- SpeedBase = 0.6 SpeedRandom = 0.1 eseten a szorzo 0.06

	["StillOnlySpeed"]   = 0.1, -- ekkora sebessegnel mar csak az allo latszik
	["BlurredOnlySpeed"] = 0.3, -- ekkora sebessegnel mar csak a forgo latszik
	["IdlePowerSpeed"]   = 0.5, -- 0 allasnal ekkora sebesseggel forog a rotor (SpeedBase szorzo)
	["MaxPowerSpeed"]    = 1.0, -- max allasnal ekkora sebesseggel forog a rotor (SpeedBase szorzo)
	["RotorSpeedChange"] = 0.2, -- ennyire gyorsul/lassul a speedbase szorzoja masodpercenkent
}

PlaneGlobals["DeathModeChances"]=
{
	["Spinning"]=0.3,
	["Explosion"]=0.2,
	["Explosion_delayed"]=0.2,
	["Powerloss"]=0.4,
	["Explodetoparts"]=0.2,
}

PlaneGlobals["Wanderer"]=
{
	["SpeedRange"]            = { KMH(60),KMH(100) }, -- mekkora sebessegtartomanytol kezdve kezdjen hatni
	["RollChangeChance"]      = 0.28,           -- ilyen valseggel fog valtozni a roll is, mikor uj szellokes jon
	["RollChangeMax"]         = 0.5,            -- 
	["RollChangeDecay"]       = 0.4,            -- 
	["RollChangeSpeed"]       = 0.7,            -- 
	["SmallPlaneRollDecayMul"]= 1.8,            -- kis gepeknel ennyivel gyorsabban cseng le a roll valtozas
	
	["TimeRange"]             = {1.0, 3.2}, -- ilyen idokozonkent jon egy ujabb szellokes
	["ChangeMul"]             = 0.7,        -- maximum ennyi lehet a gyorsulas valtozasa
	["AccelMax"]              = 0.7,        -- gyorsulas vektor max nagysaga
	["SpeedMax"]              = 0.8,        -- sebesseg vektor max nagysaga
	["OffsetMax"]             = 3.5,        -- kiteres max nagysaga
	["AccelDecayTime"]        = 5.0,        -- gyorsulas vektor ennyi ido alatt szunik meg
	["SpeedDecayTime"]        = 7.0,        -- elmozdulas valtozasanak sebesseger ennyi ido alatt szunik meg
	["OffsetDecayTime"]       = 8.0,        -- elmozdulas vektor ennyi ido alatt szunik meg, kerulunk vissza az eredeti pozicioba
	["SmallPlaneOffsetMul"]   = 0.8,        -- max elmozdulas kis gepeknel ennyivel meg lesz szorozva
	["SmallPlaneAccelMul"]    = 1.4,        -- kis gepeknel ennyivel jobban gyorsul az elmozdulas
	["SmallPlaneDecalMul"]    = 1.2,        -- kis gepeknel ennyivel jobban csengenek le a mozgasok
	["SmallPlaneTimeMul"]     = 0.7,        -- kis gepeknel ennyivel gyorsabban van uj szellokes
}

PlaneGlobals["CameraShake"]=
{
	["RollPitchMult"] = DEG(0.5),
	["PowerMult"] = DEG(0.5),
	["SpeedMult"] = DEG(2.0), -- 1.0 fok lesz a razkodas dupla sebessegnel
	["Limit"] = DEG(1.0),
	["Ratio"] = 4, -- regi valtozatban kapott shake vektor hosszanak szorzoja a cameramover-es strength szamitasahoz

	["PauseLenMin"] = 1,
	["PauseLenMax"] = 3,
	["ShakeLenMin"] = 1,
	["ShakeLenMax"] = 2,
	["RandomLenFactor"] = 0.9,
	["ForceShakeLimit"] = 0.9,
}

PlaneGlobals["AirField"]=
{
	["TurnMultiplier"]    = 2.2,	   -- ennyivel jobban fordulnak mint a yaw-juk...
	["MinTurnSpd"]        = DEG(50.0), -- ...de legalabb ennyit forognak mindenkeppen masodpercenkent
	["MoveSpd"]           = KMH(35.0), -- ennyivel gurulnak a hangarbol a kifutoig
	["PlayerControlSpd"]  = KMH(80.0), -- ha mar ennyivel gurul a gep, akkor atveheti a jatekos az iranyitast
	["PlaneSendInterval"] = 2.0,       -- ennyi masodpercenkent jon ki egy gep a hangarbol, mar ha nem utkozne az elottelevonek
}

PlaneGlobals["Retreat"]=
{
	["ExitDist"]            = 1000,   -- ha ennyi meterrel messzebb kerult a jatekter hataratol, akkor megszuntetjuk
	["ExitTime"]            = 20,     -- ha ennyi ideig a borderzone-ban repul, akkor is mexuntetjuk
	["WarningRepeatTime"]   = 6,     -- ennyi masodpercenkent figyelmeztet minket egy warning, hogy kint motorozunk a borderen kivul
}

PlaneGlobals["ParatrooperDrop"]=
{
	["MinAltitude"]         = 300,
	["MaxAltitude"]         = 1500,
}

PlaneGlobals["Dynamics"]=
{
	["Ceiling"] = 2000,	-- ez a plafon. ennyi meter folott minden repulogep atesik
	["CeilingForce"] = 0.1, -- m/s² gyorsulas minden meterert

	["WheelFrictionSpeed"] = { 1.0,  1.4 },  -- kifutopalyan gurulva, alacsony sebessegnel (e ket szorzo * stallspd) feleled a kereksurlodas, ami lassitja a gyorsulast. azert kell, hogy ne szalljon fel nagyon hamar egy gep
	["WheelFrictionAccel"] = { 0.0,  8.0 },  -- e ket ertek kozotti gyorsulassal szamol wheelfriction szamitasnal
	["WheelFriction"]      = 0.75,            -- kereksurlodas nagysaga

	["MaxDragSpdMul"] = 0.1,
	["MinDragSpdMul"] = 0.1,
	["MaxDragPitch"]  = 1.0,
	
	["AccelCheatMul"]     = 1.5,	  -- minden gep gyorsulasat, a gravitaciot es a felhajtoerot megszorozza ezzel
	["AccelCheatMulMul"]  = 1.15,	  -- minden gep gyorsulasat megszorozza ezzel
	["AccelCheatFallPitchRange"] = { DEG(10), DEG(60) },  -- ekkora negativ pitch eseten kezd el hatni a zuhanas gyorsitas.
	["AccelCheatFallMul"] = 2.6,      -- lefele repulve, a zuhanas szogenek fuggvenyeben, max ennyivel nagyobb gyorsulassal megy lefele
	
	["RotationLimit"] = 0,
	["DragFuncPower"]=1.8,            -- kilebegtetes karakterisztikajat es nehezseget hatarozza meg
	["RotationFactors"]=
	{
		["A"]=0.5,
		["B"]=1.5,
		["C"]=0.1,
	},
	["SpdMultipliers"]=
	{
		["LevelFlight"]=        1.8,	--stallspeed % folott maximalis a felhajtoero (nincs sullyedes vizszintes repulesnel)
		["StallRangeMin"]=      1.2,	--stallspeed % alatt maximalis ateses
		["StallRangeMax"]=      1.6,	--stallspeed % efolott nincs ateses
		["StallOnPitch"]=   DEG(20),	--ilyen pitch folott maximalis az ateses (a pitch a repules szoge, vizszintesen repulve 0, felfele pozitiv, lefele negativ, 90 a fuggoleges)
		["StallOffPitch"]= DEG(-15),	--ilyen pitch alatt kikapcsol az ateses, mert mar elegge lefele nez az orra a gepnek. (a pitch a repules szoge, vizszintesen repulve 0, felfele pozitiv, lefele negativ, 90 a fuggoleges)
		["ControlRangeMin"]=    1.1,	--stallspeed % alatt megszunik a kontroll
		["ControlRangeMax"]=    1.7,	--stallspeed % folott max a kontroll
		["DragRangeMin"]=       1.0,	--stallspeed % alatt nincs oldalso legellenallas
		["DragRangeMax"]=       2.0,	--stallspeed % foltt max az oldalso legellenallas, azaz nem tud csuszni oldalra
		
		["TurboMultiplier"]= 1.95,       -- ennyivel gyorsabban mennek a koveto gepek, hogy utolerjeka  eladert
		["NewTravelSpeedMul"]  =  1.6,	 -- ezzel felszorzodik a travelspeed. igy be lehet allitani, hogy a travelspeed is max speed legyen

		["DiveBombSlowMul"]    =  1.3,	-- ennyiszerese lesz a repulo vizszintes legellenallasa, ha van rajta divebomb fuggesztmeny. csokken a gyorsulasa es a vegsebesseg
		["TorpedoBombSlowMul"] =  1.3,	-- ennyiszerese lesz a repulo vizszintes legellenallasa, ha van rajta torpedo fuggesztmeny. csokken a gyorsulasa es a vegsebesseg
		["DepthChargeSlowMul"] =  1.3,	-- ennyiszerese lesz a repulo vizszintes legellenallasa, ha van rajta depth charge fuggesztmeny. csokken a gyorsulasa es a vegsebesseg
		["LevelBombSlowMul"]   =  1.0,	-- ennyiszerese lesz a repulo vizszintes legellenallasa, ha van rajta levelbomb fuggesztmeny. csokken a gyorsulasa es a vegsebesseg
	},

	["DeadMeat"]=
	{
		["RotationMin"]     = DEG(10),  -- altalanos, veletlenszeru tengely koruli forgas min sebessege
		["RotationMax"]     = DEG(30),  -- altalanos, veletlenszeru tengely koruli forgas max sebessege
		["RollMul"]         = 2.0,      -- miutan elkezd zuhanni egy repulo, a rollozasa egyre gyorsabb lesz. ez egy szorzo, ennyiszeres lesz a rollozas  'RollMulTime' ido alatt
		["RollMulTime"]     = 6,        -- ennyi masodpers alatt gyorsul fel a zuhanas alatt a rollozas
		["LostDragTime"]    = 5,        -- ennyi masodperc alatt fokozatosan elveszti a repulo a legellenallasat
		["ExtraGravityMul"] = 1.5,      -- mialatt elveszti a legellenallasat, fokozatosan ennyiszeresere no a gravitacios ero, hogy gyorsabban zuhanjon
		["SpinRollSpd"]     = 5.0,      -- SPIN meghalas eseten a maximum rollozas ennyiszeresevel fog forogni valamelyik iranyba
		["StallMulTime"]    = 4,        -- ennyi masodperc alatt fokozatosan bekapcsol az atesesi ero, hogy kezdjen el a fold fele zuhanni
		["StallMul"]        = 1,        -- ekkora az atesesi ero ereje. minel nagyobb, annal gyorsabban fog atesni, es a fold fele zuhanni
		["StallMulOnPitch"] = DEG(10),  -- ekkora, vagy ennel nagyobb pitch-nel maximalis az ateses. (a pitch a repules szoge, vizszintesen repulve 0, felfele repulve pozitiv, lefele repulve negativ). On es Off ertek kozott linearisan valtozik az ateses erteke
		["StallMulOffPitch"] = DEG(-25), -- ekkora, vagy ennel kisebb pitch-nel kikapcsol az ateses, mert mar kello szogben zuhanunk. (a pitch a repules szoge, vizszintesen repulve 0, felfele repulve pozitiv, lefele repulve negativ). On es Off ertek kozott linearisan valtozik az ateses erteke
		["SpinStallMulTime"] = 4,       -- SPIN meghalasnal ennyi masodperc alatt fokozatosan bekapcsol az atesesi ero, hogy kezdjen el a fold fele zuhanni
		["SpinStallMul"]     = 10,       -- SPIN ekkora az atesesi ero ereje. minel nagyobb, annal gyorsabban fog atesni, es a fold fele zuhanni
		["SpinStallMulOnPitch"] = DEG(0),  -- SPIN meghalasnal ekkora, vagy ennel nagyobb pitch-nel maximalis az ateses. (a pitch a repules szoge, vizszintesen repulve 0, felfele repulve pozitiv, lefele repulve negativ). On es Off ertek kozott linearisan valtozik az ateses erteke
		["SpinStallMulOffPitch"] = DEG(-75), -- SPIN meghalasnal ekkora, vagy ennel kisebb pitch-nel kikapcsol az ateses, mert mar kello szogben zuhanunk. (a pitch a repules szoge, vizszintesen repulve 0, felfele repulve pozitiv, lefele repulve negativ). On es Off ertek kozott linearisan valtozik az ateses erteke
	},

	["RunwaySmoothStrength"]  = 4.0,
	["RunwayYawTurnSpdLimit"] = { KMH(25), KMH(40) }, -- kifutopalyan eme sebessegtartomanyon belul jobban hat a labkormany, hogy jobban lehessen kanyarodni
	["RunwayYawTurnSpdMul"]   = 2.2,                  -- kifutopalyan legalacsonyabb sebessegnel ennyivel jobban hat a labkormany okozta kanyarodas

	["Water"] = { -- vizre szallas felrobbanas elkerules, felhajtoero, iranyithatosag
		["MaxVSpd"]             = 10,      -- ha ennel jobban megy lefele, akkor robban
		["MaxDownPitch"]        = DEG(15), -- ha ennel nagyobb pitch-je van elore, akkor is robban
		["MaxUpPitch"]          = DEG(50), -- ha ennel nagyobb pitch-je van hatra, akkor is robban
		["MaxRoll"]             = DEG(20), -- ha ennel nagyobb a rollja, akkor is robban
		["MaxDepth"]            = 6.0,
		["YawControlFactor"]    = 0.4,
		["MaxYawControlSpd"]    = KMH(18),
		["NormalYawControlSpd"] = KMH(45),
		["MaxYawControl"]       = 6.0,
		["LiftBeginDiveMul"]    = 0.35,     -- a merulesi melyseg ennyiszerese ha kint van a vizbol, akkor kezdunk el felhajtoerot termelni
		["LiftDepthRatio"]      = 1.2,
		["LiftMax"]             = 1.5,
		["LiftRotateMax"]       = 8.0,
		["LiftRotateDepthRatio"]= 1.8,
		["LiftRotateAngleRatio"]= 8.0,
		
		["DecelSpeed"]          = KMH(15), -- ekkora lefele meno sebessegnel lesz 1g a viz ellenallasa
		["DecelMax"]            = 3.5,     -- ez mar nem kell
		["SideDragRatio"]       = 0.5,
		["MaxSideDrag"]         = 6.0,
		["MaxCtrlAngle"]        = DEG(5),
		["MinCtrlAngle"]        = DEG(20),
		["TakeOffMaxLength"]    = 250,
		["TakeOffMinLength"]    = 140,
		["MinDragSpd"]          = KMH(20),
	},
}

PlaneGlobals["UnitAI"]=
{-- ilyen sebesseg/magassagnal cserelotik le a Stop command MoveTo-ra
	["StopClearSpeed"] = KMH(50.0), 
	["StopClearAlt"] = 30.0,
}

PlaneGlobals["Pilot"]=
{
	["General"] =   -- altalanos pilotbot parameterek
	{
		["WaggleLimit"]         = 0.5,     -- lehetoleg 0.1 es 1.0 kozott legyen. mennyire finoman alljon be a roll control. minel kisebb, annal finomabb
		["SoftHdgZone"]         = 0.01,    -- ennel kisebb elteres eseten ugy teszunk, mintha nem is lenne elteres.
		["SoftHdgLimit"]        = 0.5,     -- ha iranyba akarunk fordulni a geppel, akkor 'huzott forduloval ennyi sec alatt megtett szog'-nel kisebb elteresnel mar tompitjuk az elterest
		["SoftHdgMul"]          = 0.35,    -- lehetoleg 0.1 es 1.0 kozott legyen. ennyivel finomodik a heading allitas
		["SoftRollCtrl"]        = 0.05,    -- a roll control ekkora elteresnel mar finomabban allitodik
		["SoftRollMul"]         = 0.7,     -- ez egy oszto, tehat lehetoleg 0.1 es 1.0 kozott legyen
		["HdgDiffCalcLimit"]    = {0.8, 1.5 },   -- lehetoleg 0.1 es 1.0 kozott legyen. mennyire finoman alljon be iranyba fordulaskor
		["HdgDiffCalcMinPitch"] = 0.1,     -- mikor megnezzuk hogy mennyit kanyarodna meg amig a rolljat vizszintesbe hozza, akkor legalabb ekkora pitch-el szamolunk (huzott fordulo)
		["HdgDiffCalcMinRoll"]  = DEG(5),  -- mikor megnezzuk hogy mennyit kanyarodna meg amig a rolljat vizszintesbe hozza, akkor legalabb ekkora roll-al szamolunk
		["CruisingAlt"]         = 1000,    -- altalanos utazo magassag (meter)
		["GuardDist"]           = 3000,    -- guard uzemmodban a vedett egysegtol max ilyen messze levo ellenfeleket tamadnak csak meg
		["DropDist"]            = 200,     -- ilyen magassagkulonbseg eseten sullyed maximalis szogben
		["ClimbDist"]           = 130,     -- ilyen magassagkulonbseg eseten emelkedik maximalis szogben
		["LeaveAlonePwr"]       = 0.8,     -- ha kilepunk terkepre, akkor az AI legalabb ennyire felhuzza a gazkart, hogy ne zuhanjunk le
		["MinTurnCircle"]       = 450,	   -- legalabb ekkora lesz minen gep fordulokore
		["TurnRollLimitSmall"]  = DEG(85), -- egy kis gep maximum ekkora rollal fordulhat
		["TurnRollLimitLarge"]  = DEG(56), -- egy nagy gep maximum ekkora rollal fordulhat
		["MaxAltOffset"]        = 5,       -- path mozgasnal a tenyleges path felett max ennyi meterrel megy
		                                      -- igy ugyanazon a pathon nem mindig tokre ugyanugy mennek a unitok
		["WingmenWaitDist"]     = {3000, 5000},    -- ha ilyen messze van tole a celpont, es varnia kell a tarsakra, akkor minimum/kozepes sebesseggel megy, amig felzarkoznak
		["DropAllEquipmentPercent"] = 0.41,         -- ha a 'jelenleg a squad gepein levo bombak szama' osztva a 'squad kezdeti bombaallomanya'-val kisebb mint ez, akkor mindenki ledobja a maradek bombait, hogy ne legyen olyan csonka squad, amelyiken csak epphogy van bomba
		["LevelBombAngleMax"]   = DEG(20),         -- ha a vizszintestol ettol nagyobb szogben ter el, akkor nem oldodik ki bomba
		["DiveBombPitchAngleMax"] =  DEG(90),      -- ha ennel nagyobb a pitch, akkor nem tud sima bombat dobni
		["DiveBombPitchAngleMin"] =  DEG(60),      -- ha ennel kisebb a pitch, akkor minden rollal tud sima bombat dobni
		["DiveBombRollAngleMax"]  =  DEG(90),      -- a roll korlatozas felso erteke. a roll korlat a pitch-tol fugg. roll korlatnal nagyobb rollal nem tud bombat oldani
		["DiveBombRollAngleMin"]  =  DEG(60),      -- a roll korlatozas also erteke. a roll korlat a pitch-tol fugg. roll korlatnal nagyobb rollal nem tud bombat oldani
		["DiveBombRollAngleMaxPitch"] = DEG(90),  -- ha a vizszintestol ettol nagyobb szogben ter el, akkor nem oldodik ki bomba
		["DiveBombRollAngleMinPitch"] = -DEG(80),  -- ha a vizszintestol ettol nagyobb szogben ter el, akkor nem oldodik ki bomba
		
		["YawTurnRollRange"]          = { DEG(30), DEG(60) }, -- ekkora roll tartomany eseten yaw-al is kanyarodik
		["YawTurnMaxPitch"]           = 0.6,                  -- ha ennel jobban kell huzni a pitch-t, hogy vizszintesben legyunk, akkor lekorlatozzuk a yaw kanyarodast
		["TurnRollPitchLimitPitch"]   = { DEG(0),  DEG(12) }, -- ha ennyivel kisebb a target pitch, mint a jelenlegi, akkor...
		["TurnRollPitchLimitRoll"]    = { DEG(15), DEG(60) }, -- ... max ekkora rollal kanyarodik. hogy elobb a pitch alljon be, es csak utana kanyarodjon
		
		["PitchTurnHdgRange"]         = { DEG(25), DEG(50) }, -- ha ekkora elteres van a cel irany es az aktualis irany kozott, akkor megengedett hogy jobban huzza a pitch-t, hogy jobban kanyarodjon
		["PitchTurnMaxPitch"]         = DEG(06),              -- max ennyi fokkal a tenyleges target pitch-nel nagyobb target pitch-t akar elerni. emiatt jobban fogja huzni a pitch kontrollt, es jobban kanyarodik
		["YawCtrlSetTimeMul"]         = 0.8,                  -- manoverezes kozben ugy allitja be a yaw kontrolt, hogy elvileg ennyi sec kell ahhoz, hog a kivant pozicioba keruljunk
		["PitchCtrlSetTimeMul"]       = 0.7,	              -- manoverezes kozben ugy allitja be a Pitch kontrolt, hogy elvileg ennyi sec kell ahhoz, hog a kivant pozicioba keruljunk
		
		-- korozes
		["MoveCircleMinAngle"]        = DEG(15),
		["MoveCircleMaxAngle"]        = DEG(45),
		["MoveCircleFollowedDist"]    = 180,
		
		["TrgSpeedCorrMinPitch"]      = DEG(70),  -- ekkora negativ pitch eseten mar maximalisan szorzodik a targetspeed
		["TrgSpeedCorrSpeedMul"]      = 2.6,      -- ennyivel szorzodik max a targetspeed
		["TrgSpeedCorrMulDecay"]      = 0.8,      -- a szorzo masodpercenkent ennyivel csokken otomatikusan
		
		["EnableFullInvincible"]      = true,
	},

	["Avoidance"]= {
		["Gunfire"]=   -- repulogep gepagyutuz kikerules
		{
			["MaxWeight"]  = 0.6,      -- milyen mertekben szamitson a kikerules kontroll a normal kontrollal szemben
			["WeightInc"]  = 1.3,      -- 1 masodperc alatt ennyivel no az elkerules kontroll erossege
			["WeightDec"]  = 1.0,      -- 1 masodperc alatt ennyivel csokken az elkerules kontroll erossege
			["AvoidTime"]  = {2, 3},   -- egyhuzamban max ennyi dieig kerul ki geppityutuzet...
			["WaitTime"]   = {5, 8},   -- ... utana ennyi ideig pihen
			["BomberVSGunfire"] = 1.2, -- levelbomberek a gunfire-t nem kikerulik, hanem a billegesuket megszorozzak ennyivel, hogy kicsit jobban billegjenek
		},

		["Vehicle"]=   -- mindenfele jarmu kikerules: repulo, hajo, repter, stb
		{
			["MaxWeight"]   = 1.0,           -- milyen mertekben szamitson a kikerules kontroll a normal kontrollal szemben
			["WeightInc"]   = 4.0,           -- 1 masodperc alatt ennyivel no az elkerules kontroll erossege
			["WeightDec"]   = 1.4,           -- 1 masodperc alatt ennyivel csokken az elkerules kontroll erossege
			["AvoidSpdMul"] = 0.4,           -- a maximalis yaw es pitch fordulasi sebesseget ennyivel megszorozva kapjuk meg, hogy kb mekkora sebesseggel bir kikerulni dolgokat. ha valaminek nekimenne, akkor megnezzuk, ekkora kanyarodassal mennyi sec kikerulni az adott jarmut, de ...
			["MinCollTime"] = 3.0,           -- ... legalabb ennyi masodperccel az utkozes elott probalnak kiterni. 
			["MinPlaneSpd"] = KMH(70),       -- ugy szamolunk, hogy minden repulo legalabb ennyivel megy. foleg vizen uszo hidroplanoknal kell ez a csalas, hogy lassan menve is elkezdjenek kerulni
			["MaxDistMultiplier"] = 1.2,     -- a gep fesztavjanak ennyiszeresere szeretnek lenni egymastol, akarmerre is van a masik gep
			["MinDistMultiplier"] = 1.0,     -- a gep fesztavjanak ennyiszeresenel mar maximalisan kiternek, akarmerre is van a masik gep
			["UseRollStrength"]   = 0.5,     -- mekkora kiteresi ero eseten kezdje el a roll-t is korrigalni, hogy ne a szarnyaikkal erjenek ossze
			
			["BomberVSSmallPlane"] = false,       -- engedelyezzuk-e, hogy levelbomberek kerulgessek a kozelukbe kerult kis gepeket?
		},
	
		["Terrain"]=   -- talajelkerules
		{
			["MaxWeight"]  = 1.0,    -- milyen mertekben szamitson a kikerules kontroll a normal kontrollal szemben
			["WeightInc"]  = 2.0,    -- 1 masodperc alatt ennyivel no az elkerules kontroll erossege
			["WeightDec"]  = 1.0,    -- 1 masodperc alatt ennyivel csokken az elkerules kontroll erossege
			
			["TimeTick"]   = 1.0,          -- ennyi masodpercenkent extrapolalja a gep poziciojat, es nezi hogy utkozik-e valamivel
			["SafeAlt"]    = { 12, 30 },  -- pitch-tol fuggo biztonsagos magassag. ha ennel kozelebb kerulne a talajhoz, akkor elkezd kiterni
			["PitchTurnRollRange"] = { DEG(45), DEG(60) },     -- 
			["YawTurnRollRange"]   = { DEG(35), DEG(55) },     -- 
		},
	},

	["AutoStrafeAngle"] = -- kulonbozo szituaciokban az optimalis iranytol max mekkora szogben kanyarodhat el, ha lat arrafele egy ellenseges celpontot, akire lohet geppityuval
	{
		["Angle_Prepare"]  = DEG(0),     -- a celpontja kozeleben van, tamadasra keszul, de meg nincs annyira kozel, hogy muszaly legyen precizen manoverezni. a vegso, preciz manoverezesi fazisokban mindig 0 az automatikus geppityuzas miatti max elfordulas
		["Angle_MoveTo"]   = DEG(2),     -- utazik a celpontja fele
		["Angle_GoAway"]   = DEG(10),    -- egy tamadas utan menekul a celpontjatol, hogy aztan kello tavolsagbol visszafordulva ujra tamadjon
		["Angle_Strafe"]   = DEG(15),    -- tamadas parancsa van a geppityuval, es uldozi a celpontjat
	},

	["MoveTo"] = -- MoveTo es MoveOnPath parancs parameterei
	{
		["SmallPlaneTravelAlt"] = 800,      -- ilyen magasan kozlekednek a kis gepek
		["LargePlaneTravelAlt"] = 1400,      -- ilyen magasan kozlekednek a nagy gepek (levelbomber, largerecon)
		["TravelAltRandom"]     = 50,       -- a fenti ertekekbol ennyi random levonodik
		["FollowDist"]          = {20, 200}, -- ha egy masik egyseg a moveto celpontja, azaz kovetunk valakit, akkor azt ilyen tavolsagbol fogjuk kb
		["ClosingDist"]         = 150,       -- ha ennyire megkozelitette a celpontot, akkor elkezdhet korozni korulotte
		["CircleAltDiff"]       = 30,        -- az egymas kozeleben korozo squadok repulesi magassaga kozott ennyi tavolsag lesz, hogy ne utkozzenek ossze
		["SwitchNextPointTime"] = 2.0,       -- MoveOnPath modban, ha ennyi masodperc mulva eleri az aktualis pathpointot, akkor atvalthat a kovetkezo pathpontra
		["ReferenceSpeed"]      = KMH(300)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Follow"] =   -- follow parancs parameterei. wingmanek igy kovetik a leadert
	{
	        -- koveto manoverezes parameterei
		["SmallPlaneDisplacement"] = { 60, 25, 70 },     -- relativ kovetesi pozicio {x,y,z} koordinatai kis gepeknel
		["BomberDisplacement"]     = { 100,  0, -100 }, -- relativ kovetesi pozicio {x,y,z} koordinatai nagy gepeknel
		["SymmetricalPosition"]    = true,              -- a leader ket oldalan levo wingmanek pozicioja szimmetrikus legyen-e (pl mindket oldali wingmanek elotte repulnek), vagy sem (pl baloldaliak elotte repulnek, jobboldaliak mogotte)
		["SymmetricalAltitude"]    = false,             -- a leader ket oldalan levo wingmanek magassaga szimmetrikus legyen-e (pl mindket oldali wingmanek alatta repulek), vagy sem (pl baloldaliak alatta repulnek, jobboldaliak felette)
		["SmallPlaneTurnMul"]      = 1.1,              -- a kis gepek fordulasi sebesseget ennyivel megszorozzuk, es ekkora fordulekonysaggal szamolunk manoverezes kozben
		["LargePlaneTurnMul"]      = 1.1,               -- a nagy gepek fordulasi sebesseget ennyivel megszorozzuk, es ekkora fordulekonysaggal szamolunk manoverezes kozben
		["NearbyDist"]             = 200,               -- ha ennel kozelebb van a pontos helyehez kepest, akkor a wingmanlag mar elkezd noni, egyre kevesbe kell ra varni, gyorsithat a leader
		["GoodPositionDist"]       = 100,               -- akkor van jo helyen a wingman, ha ennel kozelebb van az optimalis poziciojahoz
		["GoodPositionDir"]        = 0.5,               -- akkor van jo helyen a wingman, ha ennel kiseb a heading elteres kozte es a leader kozott
		["GoodPositionSpdTreshold"]= 1.0,
		["GoodPositionSpdDiff"]    = KMH(200),
		["MaxFollowSpdTargetDir"]  = DEG(30),
		["MinFollowSpdTargetDir"]  = DEG(100),
		["DontWaitForHdgDiff"]     = DEG(50),
		["WaitForHdgDiff"]         = DEG(100),
		["TightTurn"]              = 1.25,
		
		["BomberDisplacement"]     = { 100,  0, -100 }, -- relativ kovetesi pozicio {x,y,z} koordinatai nagy gepeknel
		["LeaderHeadingSpdTime"]   = { 0.5, 4.0 },      -- mikor megprobalunk felzarkozni a leaderhez, akkor a leader repulesi iranyahoz hozzaadunk meg ennyi masodperc forgasi sebesseget, hogy oda akarjunk felzarkozni, ahol majd a jovoben lesz
		["LeaderHeadingSpdDist"]   = {  100, 500 },      -- hogy mennyi masodpercet adunk hozza, az a tavolsagtol fugg. e tavolsagtartomanyban valtozik az ido
		
		
		["FollowedPointDist"]     = 250,
		["LeaderFollowAlt"]       = 10,
		["SafeAlt"]               = 60,

		-- yaw
		["yf_hdg_rad"]          =  1 / DEG(10),  -- + | heading difference multiplier
		["yf_yawV_radPerSec"]   =  0 / DEG(10),  --   | yaw speed difference multiplier
		["yf_sidepos_meter"]    =  1 / 25,       -- + | side position difference multiplier
		["yf_sidedir"]          =  1 / 25,       -- + | side position difference multiplier

		-- pitch
		["pf_pitch_rad"]        =  1 / DEG(10),  -- + | pitch difference multiplier
		["pf_pitchV_radPerSec"] =  1 / DEG(100), --   | pitch speed difference multiplier
		["pf_vertpos_meter"]    =  1 / 25,       -- + | vertical position difference multiplier
		["pf_vertdir"]          =  1 / 25,       -- + | vertical position difference multiplier

		-- roll
		["rf_roll_rad"]         = -1 / DEG(30),  -- - | roll difference multiplier
		["rf_rollV_radPerSec"]  = -0 / DEG(80),  --   | roll speed difference multiplier
		["rf_hdg_rad"]          =  0 / DEG(40),  -- + | heading difference multiplier
		["rf_hdgV_radPerSec"]   =  0 / DEG(400), --   | turn speed difference multiplier

		-- power and brake
		["pwr_back_meter"]      =  1 / 10,       -- lagging behind multiplier
		["pwr_spd_meterPerSec"] =  1 / KMH(10),  -- velocity difference multiplier
	},

	["CloseToShip"] = -- closetoship parancs parameterei
	{
		["CruisingAlt"] = 1200,  -- ilyen magasan kozeliti meg a hajot a squadron
		["DropAlt"]     = 1000,  -- ilyen magassagban fog korozni korulotte es dobalja a dummykat
		["ReferenceSpeed"]      = KMH(300)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["LevelBomb"] = -- levelbomb parancs parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 2000,  -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 1300,  -- ilyen magasan kozeliti meg a celpontot
		["DropAlt"]     = 1300,  -- a celpont folott! ilyen magasan fog bombazni. tehat ha a celpont egy 200m magasan levo repter, akkor 200m+ez magassagban fog bombazni!
		["SafeDist"]    = 1000,  -- bomba ledobasa utan a celponttol meg ilyen messze menekul, utana van befejezve a tamadas
		["MoveOnCruisingAlt"]    = false,  -- ha ez true, akkor azok a gepek, akiken van olyan fuggesztmeny, hogy igy tamadjanak, azok normal repules kozben is 'CruisingAlt' magassagon repulnek, nem pedig az alapertelmezett travelalt-on
		["ReferenceSpeed"]       = KMH(300)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Kamikaze"] = -- kamikaze es dropkamikaze parancs parameterei.
	{
		["RocketLike"] = 			-- a raketa szeru, bombazorol ledobott kamikazek parameterei. pl okha
		{
			["CruisingAlt"] = 1300,    -- ilyen magasan kozeliti meg a celpontot a hordozo
			["DropDist"]    = 3500,    -- a celponttol ilyen tavolsagra dobja le a hordozo a kamikaze gepeket. ne legyen tul kozel, mert a kamikazeknak a nagy sebesseguk miatt sok hely kell a manoverezeshez
			["AttackRange"] = 3500,    -- a celtol ilyen tavolsagban kezd rafordulni a celra
			["TurboRange"] = 3000,     -- a celtol ilyen tavolsagban begyujtja a raketat, ha mar iranyba fordult
			["AttackAlt"]   = 800,     -- a celponttol 'AttackRange' tavolsagra ilyen magasan probal lenni, ebbol a magassagbol tamad
			["TurboAngle"]  = DEG(12), -- ha a celponthoz ennel laposabb szogben kozelit, akkor mindenkepp bekapcsolja a turbot, hogy eljusson a celpontig, mert kulonben lezuhanna mielott elerne
			["ReferenceSpeed"] = KMH(600),   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
		},
		["FighterLike"] =   -- a vadaszgep szeru, nem bombazorol ledobott kamikazek parameterei. pl kamikaze zero
		{
			["CruisingAlt"] = 1200,    -- ilyen magasan kozeliti meg a celpontot a kamikaze squad
			["AttackRange"] = 2600,    -- a kamikaze vadaszok ilyen tavolsagbol bontjak a formaciot es kezdenek kulon-kulon tamadni
			["AttackAlt"]   = 800,     -- a celponttol 'AttackRange' tavolsagra ilyen magasan probal lenni, ebbol a magassagbol tamad
			["TurboRange"] =  2400,     -- a celtol ilyen tavolsagban bekapcsolja a turbot
			["ReferenceSpeed"] = KMH(400),   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
		},
	},

	["DepthCharge"] = -- depthcharge parancs parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 1800,               -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 700,               -- utazo magassag (meter)
		["AimAltRange"] = { 20, 60 },       -- e ket magassag kozott probalja dobni a csomagot
		["ManeuverAltRange"] = { 80, 150 },  -- e ket magassag kozott manoverez (tavolodas, fordulo eseten)
		["FlyAboveDist"] = 400,               -- ekkora tavolsagra a celtol mar iranyba van fordulva, es alacsonyan repul
		["SafeDist"] = 250,                   -- cucc ledobasa utan a celponttol meg ilyen messze menekul, utana van befejezve a tamadas
		["MoveOnCruisingAlt"]  = true,       -- ha ez true, akkor azok a gepek, akiken van olyan fuggesztmeny, hogy igy tamadjanak, azok normal repules kozben is 'CruisingAlt' magassagon repulnek, nem pedig az alapertelmezett travelalt-on
		["ReferenceSpeed"]     = KMH(270),   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
		["TargetLostTime"] = 20,            -- ha a sub eltunik a reconrol, akkor ennyi masodperc utan befejezodik a depthcharge tamadas
	},

	["DiveBomb"] = -- divebomb parancs parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 1100,             -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 1300,             -- utazo magassag (meter)
		["BeginAltRange"] = { 1000, 1200 }, -- e ket magassag kozott kezdi meg a leboritast
		["SafeDist"] = 100,                 -- bomba ledobasa utan a celponttol meg ilyen messze menekul, utana van befejezve a tamadas
		["MoveOnCruisingAlt"]    = true,   -- ha ez true, akkor azok a gepek, akiken van olyan fuggesztmeny, hogy igy tamadjanak, azok normal repules kozben is 'CruisingAlt' magassagon repulnek, nem pedig az alapertelmezett travelalt-on
		["ReferenceSpeed"]      = KMH(280)  -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Dogfight"] = -- dogfight parancs parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 2000,          -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 1400,          -- utazo magassag megkozeliteni az ellenfelet (meter)
		["FighterAimMulVersusAI"]     = 1.6, -- ennyivel pontosabban lonek a fighterek az AI iranyitotta gepekre. minel nagyobb, annal pontosabb. 1.0 eseten lesz az alapertelmezett.
		["FighterAimMulVersusPlayer"] = 1.1, -- ennyivel pontosabban lonek a fighterek a jatekos iranyitotta gepekre. minel nagyobb, annal pontosabb. 1.0 eseten lesz az alapertelmezett.
		["ReferenceSpeed"]      = KMH(300)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Strafe"] = -- gepagyuzas parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 2000,         -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 1000,         -- utazo magassag megkozeliteni az ellenfelet (meter)
		["ReferenceSpeed"] = KMH(280)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Strike"] = -- raketazas parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"]  = 1800,         -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 500,         -- utazo magassag megkozeliteni az ellenfelet (meter)
		["ReferenceSpeed"] = KMH(280)   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["Torpedo"] = -- torpedozas parameterei. a tobbi, skill fuggo parameter a Robots.Lua-ban
	{
		["AttackDist"] = 2200,          -- ilyen tavolsagbol bomlik fel a formacio, es kezdenek onalloan tamadni
		["CruisingAlt"] = 500,         -- utazo magassag megkozeliteni az ellenfelet (meter)
		["SafeDist"] = 700,             -- torpedo ledobasa utan a celponttol meg ilyen messze menekul, utana van befejezve a tamadas
		["MoveOnCruisingAlt"] = true,    -- ha ez true, akkor azok a gepek, akiken van olyan fuggesztmeny, hogy igy tamadjanak, azok normal repules kozben is 'CruisingAlt' magassagon repulnek, nem pedig az alapertelmezett travelalt-on
		["ReferenceSpeed"]    = KMH(300)  -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala
	},

	["TakeOff"] = -- felszallas parameterei
	{
		["PrepareTime"] = 1.5,    -- ennyi masodpercig teszteli a kifuton a kezeloszerveket, utana kezd el csak felszallni
	},

	["Landing"] = -- leszallas parancs parameterei
	{
		["StandbyDist"] = 3400,        -- ilyen messzirol bontjak fel a repulesi formaciot, es keszulodnek a landolashoz
		["ApproachDist"] = 200,        -- a kifutopalya mogott ennyivel (meter) kezd lelassulni ereszkedo sebessegre
		["ApproachPitch"] = DEG(6),    -- ilyen pitch-et probaljon tartani leszallas soran
		["ApproachAngle"] = DEG(12),   -- ilyen szogben erkezzen le
		["ReferenceSpeed"] = KMH(340),   -- ekkora max sebessegu repulore vonatkoznak ezek a parameterek. ha valaki gyorsabb, akkor a tavolsag parameterek aranyosan nagyobbak lesznek nala

		["FollowDistTime"] = 9,       -- leszallasnal ilyen idokozzel probaljak kovetni egymast. (celszeru ugy allitani hogy a maximalis elvart meretu squad is elferjen ilyen beallitassal a varakozo koron)
		["MinFreeRunwayLength"] = 40,  -- legalabb ennyi meter ures hely kell legyen a kifuto vegen, hogy a kovetkezo gep is leszalljon
		["ParkVelocity"] = KMH(20),    -- ennyivel gurul a kifutopalyan a helyere, miutan leszallt. Ha tul nagy, nem tud megallni anyahajon a liften
		["LiftDelay"] = 0.5,           -- hordozon a lift lenti allapotaban ennyi masodpercet var
		["WireRope"] = 1.25,           -- a drotkotel erossege anyahajon
		["MaxWireRope"] = 15.0,        -- a drotkotel erossege anyahajon

		["TouchDownDist"] = 150,       -- elvileg ennyi meter kell a leszallashoz drotkotel nelkul, airfielden
		["TakeoffDist"]   = 180,       -- elvileg ennyi meter kell a felszallashoz

		["PosBehind"] = 800,           -- ennyivel a hordozo mogott indulnak lefele
		["PosAlt"] =    180,           -- ilyen magasrol
		["CircleMultiplierMin"] = 1.1, -- fordulokor sugar szorzo kis gepeknel
		["CircleMultiplierMax"] = 1.05,-- fordulokor sugar szorzo nagy gepeknel
		
		["RadiusChange"] = { 10, 50 },  -- valtoztatja a leszallasi kor sugarat, ha ennyi gep akar leszallni. a kisebb erteknel kevesebb gep eseten minimalis a kor, a nagyobb erteknel tobb gep eseten maximalis a kor

		["CruisingAlt"] = 1400,        -- utazo magassag a repterig (meter)

	}
}

