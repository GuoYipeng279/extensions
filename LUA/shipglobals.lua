ShipGlobals = {}

	ShipGlobals["SubTorpedoDelay"]= 0.5 -- Ez a parameter allitja a subok torpedoveto csoveinek elsutese kozbeni idot, masodpercben.
	ShipGlobals["ShipTorpedoDelay"]= 0.5 -- Ez a parameter allitja a hajok torpedoveto csoveinek elsutese kozbeni idot, masodpercben.
	
	ShipGlobals["PipeSightParams"]=
	{
		["pipesight_enabled"]=true,
		
		["blur_drag"]=0.0,
		["blur_spring"]=0.0,
		["blur_rate"]=0.0,
		
		["blur_heavy_add"]=0.0,
		["blur_medium_add"]=0.0,
		["blur_light_add"]=0.0,
		["blur_aa_add"]=0.0,

		["zoom_drag"]=0.5,
		["zoom_spring"]=1.0,
		["zoom_rate"]=0.5,
		
		["zoom_heavy_add"]=0.05,
		["zoom_medium_add"]=0.0,
		["zoom_light_add"]=0.0,
		["zoom_aa_add"]=0.0,
	}
	ShipGlobals["DebrisStruct"]=
	{
		["DebrisEnabled"]=true,
		["DebrisNumPerMeter"]=0.3,
	}
	ShipGlobals["Sinking"]=
	{
		["StartAngularVelocity"]=-10, -- fokban megadva, a szetrobbanas pillanataban ekkora szogsebesseggel kezdenek el forogni
		["SectionNum"]=6, --paros szam legyen!
		["DragPower"]=1, --kitevo a kozegellenallashoz
		["DragMultiplier"]=2.0, --szorzo a kozegellenallashoz
		["DragMultiplierZ"]=0.3, --szorzo a kozegellenallashoz menetiranyban
		["LeakSize"]=1.0, --minel nagyobb, annal tobb viz folyik be a kettetort hajodarabokba adott ido alatt
	}

	ShipGlobals["Debris"]=
	{
		["SplashSpeed"]={5,20,},
		["SplashFXID"]={52,44,},
	}

  -- jatekos artillery szorasat modosito cuccok
	ShipGlobals["PlayerArtilleryThrow"]=
	{
	  -- ha a jatekos kezeli az artilleryket, akkor valtoztatjuk az artillery szorasat. ha rajta van a celkereszt valakin, es nem lo a jatekos, akkor csokken a szoras, kulonben no.
		["ThrowIncrementTime_NoTarget"] = 4.0,  -- JELENLEG NEM HASZNALT: ha nincs rajta a celkereszt senkin, akkor novekszik a szoras. ennyi masodperc alatt no vissza a szoras az eredeti ertekere
		["ThrowIncrementTime_HasTarget"] = 2.0,	-- ha rajta van a celkereszt a celponton, de megis novelni kell a szorast (mert pl lo a jatekos az agyukkal), akkor ennyi masodperc alatt no a szoras vissza nullarol az eredeti mertekre
		["ThrowDecrementTime"] = 2.0, -- ha csokkentjuk a szorast, mert rajta van a celkereszt a celon, es meg nem lo a jatekos, akkor ennyi masodperc alatt megy le a szoras nullara. JELENLEG NEM KELL CELON TARTANI, CSAK ABBAHAGYNI A LOVEST
		["AfterShot_FireTime"] = 0.2, -- ha abbahagyja a jatekos a lovest,  akkor meg ennyi masodpercig ugy vesszuk, hogy lo, azaz ennyi ideig meg romlik a szoras
		["AfterShot_WaitTime"] = 0.2, -- ha mar 'AfterShot_FireTime' ideje abbahagyta a jatekos a lovest, es meg mindig a celponton tartja a celkeresztet, akkor ennyi ideig meg varunk a szoras csokkentesevel. ez ido alatt se nem no, se nem csokken a szoras
	}

--utkozesi serulessel kapcsolatos parameterek
	ShipGlobals["ColliDolgok"]=
	{
		["ColliDamageMultiplier"] = 1.0, -- utkozesnel serulesszorzo
		["CollisionEffect"] = "BigCollision", -- utkozesi effekt
	}

-- AA celzasjavitas jatekos illetve AI vezette hajokkal szemben
	ShipGlobals["AAGunnerErrorModifier"]=
	{
		["VersusPlayer"] = 1.2, -- az AI ennyivel lo pontosabban jatekos vezette hajokra AA-val. minel nagyobb, annal pontosabb. 1.0 az alapertelmezett, regi mukodes
		["VersusAI"] = 2.0,     -- az AI ennyivel lo pontosabban AI vezette hajokra AA-val. minel nagyobb, annal pontosabb. 1.0 az alapertelmezett, regi mukodes
		["CalcTargetPosTimeAddFix"] = 0.05, -- a celpont altal ennyi masodperc alatt megtett tavolsaggal a celpont ele celoz. Azaz ha pl mindig moge celoz a legvedelem egy repulonek, akkor ezzel utana lehet huzni, hogy ele celozzon (minel nagyobb, annal inkabb ele celoz)
		["CalcTargetPosTimeAddMul"] = 0.1, -- ugyanaz, mint az elozo, csak a celpont tavolsagatol fuggoen mukodik. 1km-re levo celpontnal a celpont altal ennyi masodperc alatt megtett tavolsaggal a celpont ele celoz.
		["TurnOffAAGunThrow"] = false,  -- ki lehet kapcsolni vele a legvedelmi agyuk szorasat. elvileg olyankor minden lovedek ugyanoda megy. CSAK TESZTELESHEZ!!!
	}

	ShipGlobals["WaterTickDamage"]=100 --ennyit sebez a viz tickenkemt
	ShipGlobals["FireTickDamage"]=40 --ennyit sebez a tuz tickenkent
	ShipGlobals["BodyRepairTickPercentage"]=0.1 --ennyi szazalekot gyogyul a hajotest normal repair mellett tickenkent
	ShipGlobals["GunRepairTickPercentage"]=2 --ennyi szazalekot gyogyulnak a fegyverek normal repair mellett tickenkent
	ShipGlobals["FireFailureChance"]=3 --ilyen esellyel lesz failure a tuztol tickenkent
	ShipGlobals["FireFailureDamageDuration"]=10 --a hajo ennyi masodperc firedamage-et kap, ha fueltankfailure van
	ShipGlobals["ExplosionDamagePercentage"]=20 ----a hajo maxhpjanak ennyi szazalekat kapja meg a hajo damage-kent, ha explosionfailure van
	ShipGlobals["PumpRepairMultiplier"]=3 --ennyiszer kevesebb dotot ad a viz
	ShipGlobals["FireRepairMultiplier"]=3 --ennyiszer kevesebb dotot ad a tuz
	ShipGlobals["FireFailureChanceMultiplier"]=1000 --ennyiszer ritkabban okoz failure-t a tuz, ha a fire-t szeretjuk gyogyitani a legjobban a vilagon
	ShipGlobals["FailureRepairMultiplier"]=3 --ennyiszer gyorsabban gyogyulnak a failure-ok,
	ShipGlobals["BodyRepairMultiplier"]=2 --ennyiszer gyorsabban gyogyul a hajotest
	ShipGlobals["GunRepairMultiplier"]=4 --ennyiszer gyorsabban gyogyulnak a fegyverek
	ShipGlobals["FailureChance"]=100 --ennyi az eselye a szekcio failure-nek, ha
	ShipGlobals["FailureDamageThreshold"]=100 --ennyi sebzest kap be

	ShipGlobals["Failures"]=
	{
		{
			["SectionName"]="steering",
			["FailureName"]="SteeringJam",
			["FailureDuration"]=20,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="engineroom",
			["FailureName"]="EngineJam",
			["FailureDuration"]=20,
			["FireFailure"]=true,
		},
		{
			["SectionName"]="runway",
			["FailureName"]="RunwayFailure",
			["FailureDuration"]=20,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="hangar",
			["FailureName"]="HangarFailure",
			["FailureDuration"]=20,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="magazine",
			["FailureName"]="Explosion",
			["FailureDuration"]=240, --cooldown ebben az esetben
			["FireFailure"]=false,
		},
		{
			["SectionName"]="fueltank",
			["FailureName"]="Fire",
			["FailureDuration"]=15, --cooldown ebben az esetben
			["FireFailure"]=false,
		},
	}

	ShipGlobals["AttackMoveDirector"]=
	{
	  ["MyDamageWeight"] = 10.0,
	  ["IdealDistWeight"] = 4.0,
	  ["NearbyEnemyWeight"] = 3.0,
	  ["NearbyEnemyReference"] = 1000.0,
	  ["NearestMoveDirWeight"] = 1.0,
	  ["PrevMoveDirWeight"] = 0.25,
	  ["PrevMoveDirRange"] = DEG(60),
	}


--kulonbozo fegyvertipusok talalati pontossaga a maximalis lotavolsag fuggvenyeben, kulonbozo meretu NEM REPULO celpontok eseteben. a talalati pontossag 0 es 1 kozotti valos szam.
-- minden fegyvertipusnal a maximalis lotavolsagot 10 darabra osztjuk, es minden resztavolsaghoz meg kell adni a talalati pontossagot. azaz pl egy 2000 meterre lovo fegyvernel a 10%=200m, 20%=400m, 30%=600m, stb tavolsagra levo celpontra loves talalati eselyet kell megadni.
-- a talalati pontossag fugg a celpont meretetol is. minden tavolsaghoz ket talalati pontossagot kell megadni, kis, illetve nagy celpontok eseten. Hogy mi szamit kis es nagy celpontnak, azt a celpontok meretevel lehet megadni, minden fegyvertipushoz meg kell adni a kis es nagy celpont meretet.
	ShipGlobals["WeaponHitAccuracy"]=
	{
		["Artillery"]=	-- artillery es raketa eseten.
		{
			["TargetReferenceSizes"] = { 100, 250 }, -- a legkisebb es a legnagyobb celpont merete, meterben.
			["Accuracy_10percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.1) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_20percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.2) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_30percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.3) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_40percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.4) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_50percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.5) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_60percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.6) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_70percent_Range"]  = { 0.9, 1.0 },  -- a (maximalis_lotavolsag * 0.7) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_80percent_Range"]  = { 0.7, 0.9 },  -- a (maximalis_lotavolsag * 0.8) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_90percent_Range"]  = { 0.5, 0.8 },  -- a (maximalis_lotavolsag * 0.9) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_100percent_Range"] = { 0.3, 0.5 },  -- a (maximalis_lotavolsag * 1.0) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
		},
		["AA"]=	-- AA gun es Flak eseten
		{
			["TargetReferenceSizes"] = { 80, 200 }, -- a legkisebb es a legnagyobb celpont merete, meterben.
			["Accuracy_10percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.1) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_20percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.2) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_30percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.3) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_40percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.4) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_50percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.5) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_60percent_Range"]  = { 0.9, 1.0 },  -- a (maximalis_lotavolsag * 0.6) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_70percent_Range"]  = { 0.8, 1.0 },  -- a (maximalis_lotavolsag * 0.7) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_80percent_Range"]  = { 0.7, 0.9 },  -- a (maximalis_lotavolsag * 0.8) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_90percent_Range"]  = { 0.5, 0.7 },  -- a (maximalis_lotavolsag * 0.9) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_100percent_Range"] = { 0.3, 0.5 },  -- a (maximalis_lotavolsag * 1.0) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
		},
		["Torpedo"]=	-- torpedoval
		{
			["TargetReferenceSizes"] = { 100, 300 }, -- a legkisebb es a legnagyobb celpont merete, meterben.
			["Accuracy_10percent_Range"]  = { 0.6, 0.8 },  -- a (maximalis_lotavolsag * 0.1) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_20percent_Range"]  = { 0.6, 0.8 },  -- a (maximalis_lotavolsag * 0.2) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_30percent_Range"]  = { 0.5, 0.7 },  -- a (maximalis_lotavolsag * 0.3) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_40percent_Range"]  = { 0.4, 0.6 },  -- a (maximalis_lotavolsag * 0.4) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_50percent_Range"]  = { 0.3, 0.45 },  -- a (maximalis_lotavolsag * 0.5) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_60percent_Range"]  = { 0.22, 0.3 },  -- a (maximalis_lotavolsag * 0.6) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_70percent_Range"]  = { 0.15, 0.22 },  -- a (maximalis_lotavolsag * 0.7) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_80percent_Range"]  = { 0.1, 0.15 },  -- a (maximalis_lotavolsag * 0.8) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_90percent_Range"]  = { 0.05, 0.1 },  -- a (maximalis_lotavolsag * 0.9) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_100percent_Range"] = { 0.02, 0.05 },  -- a (maximalis_lotavolsag * 1.0) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
		},
		["DepthCharge"]=	-- DepthCharge-al
		{
			["TargetReferenceSizes"] = { 100, 200 }, -- a legkisebb es a legnagyobb celpont merete, meterben.
			["Accuracy_10percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.1) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_20percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.2) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_30percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.3) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_40percent_Range"]  = { 1.0, 1.0 },  -- a (maximalis_lotavolsag * 0.4) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_50percent_Range"]  = { 0.9, 0.9 },  -- a (maximalis_lotavolsag * 0.5) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_60percent_Range"]  = { 0.8, 0.8 },  -- a (maximalis_lotavolsag * 0.6) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_70percent_Range"]  = { 0.7, 0.7 },  -- a (maximalis_lotavolsag * 0.7) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_80percent_Range"]  = { 0.6, 0.6 },  -- a (maximalis_lotavolsag * 0.8) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_90percent_Range"]  = { 0.5, 0.5 },  -- a (maximalis_lotavolsag * 0.9) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
			["Accuracy_100percent_Range"] = { 0.4, 0.4 },  -- a (maximalis_lotavolsag * 1.0) tavolsagra levo celpontra mekkora a talalti pontossag kis celpont, illetve nagy celpont eseten
		},

	}

--avoidzone parameterek. mindenhol 2 erteket kell megadni. elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
	ShipGlobals["AvoidZoneDepthsSingle"]=
	{
		["BattleShip"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["MotherShip"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["Destroyer"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["TBoat"] = { 0, 5, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["SmallLandingShip"] = { 0, 5, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["LargeLandingShip"] = { 0, 5, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["CargoShip"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["LightCruiser"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["HeavyCruiser"] = { 0, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["MiniSub"] = { 0, 11, 26, 46, 86, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik, ha a felszinen van; a tobbi sorban a 4 merulesi melysegnek megfeleloen annak a zonanak a melysege, amelyiket adott melysegen kozlekedve az utvonalkeresesnel elkerul
		["Submarine"] = { 0, 11, 26, 46, 86, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik, ha a felszinen van; a tobbi sorban a 4 merulesi melysegnek megfeleloen annak a zonanak a melysege, amelyiket adott melysegen kozlekedve az utvonalkeresesnel elkerul
	}

	ShipGlobals["AvoidZoneDepthsMulti"]=
	{
		["BattleShip"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["MotherShip"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["Destroyer"] = { 1, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["TBoat"] = { 1, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["SmallLandingShip"] = { 1, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["LargeLandingShip"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["CargoShip"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["LightCruiser"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["HeavyCruiser"] = { 3, 11, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik; masodik annak a zonanak a melysege, amelyiket utvonalkeresesnel elkerul
		["MiniSub"] = { 1, 11, 46, 46, 86, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik, ha a felszinen van; a tobbi sorban a 4 merulesi melysegnek megfeleloen annak a zonanak a melysege, amelyiket adott melysegen kozlekedve az utvonalkeresesnel elkerul
		["Submarine"] = { 1, 11, 46, 46, 86, }, -- elso az 'uvegfal' zona melysege, amivel fizikailag is utkozik, ha a felszinen van; a tobbi sorban a 4 merulesi melysegnek megfeleloen annak a zonanak a melysege, amelyiket adott melysegen kozlekedve az utvonalkeresesnel elkerul
	}

--hajo elkerules
	ShipGlobals["ShipAvoidance"]=
	{
		["CollectTimer"] = { 1, 2, },	 -- ennyi masodpercenkent frissiti a kozelben levo hajok listajat
		["CollectDist"] = 450,	 -- ha ennel kozelebb van ket hajo, akkor azok mindenkepp figyelembe veszik egymast elkerules szempontjabol
		["CollectHitTime"] = 10,	 -- ha ket hajo olyan kozel van egymashoz, hogy ennyi masodperc alatt osszeutkozhetnek, akkor mar figyelembe veszik egymast elkeruleshez

		["NearbyShip_PosSpeedCorrig"] = 0.5,  -- a kozeli hajo poziciojat korrigaljuk, a 'sebessege szorozva ezzel' tavolsaggal elorebb rakjuk, mint ahol tenylegesen van.
		["NearbyShip_ArriveTimeMin"] = 2.0,	    -- a kozeli hajo tavolsagat csokkentjuk az ennyi masodperc alatt megtett uttal, de legalabb 'NearbyShip_ArriveDistMin' tavolsaggal.
		["NearbyShip_ArriveDistMin"] = 0.4,  -- a kozeli hajo tavolsagat csokkentjuk a hajonk hosszanak ennyiszeresevel, vagy 'NearbyShip_ArriveTimeMin' masodperc alatt megtett tavolsaggal, ha az nagyobb.
		["NearbyShip_MyMinSpdRatio"] = 0.2,		-- mikor azt nezzuk, hogy mennyi ido alatt erunk a celhoz, akkor feltesszuk, hogy legalabb a max speed ennyiszeresevel megy a mi hajonk.
		["NearbyShip_EstPos_MinShipLength"] = 5, -- a kozeli hajo hosszat legalabb ennyinek vesszuk 
		["NearbyShip_EstPos_DistLimitMul"] = 4.0,  -- a kozeli hajo becsult elmozdulasa nem lehet nagyobb, mint a tolunk valo tavolsaga szorozva ezzel
		["NearbyShip_EstPos_ShipLengthLimitMul"] = 4.0, -- a kozeli hajo becsult elmozdulasa nem lehet nagyobb, mint a hossza szorozva ezzel
		["NearbyShip_EstPos_ShipSpdMul"] = 1.0,	-- a kozeli hajo tenyleges sebesseget megszorozzuk ennyivel
		["NearbyShip_EstPos_SizeDecMul"] = 0.3,   -- a kozeli hajo meretcsokkente a '(becsult ido)*(((akt_sebesseg)*ez)/hajohossz)'
		["NearbyShip_EstPos_SizeDecMin"] = 0.2,	-- a kozeli hajo meretet maximum a 'becsult ido szorozva ezzel' meretben csokkenthetjuk
		["NearbyShip_NextCornerReachDistAddOn"] = 100,  -- utvonalkeresesnel, a legkozelebbi sarokpontnal ennyivel messzebb levo hajokat mar nem kerulgetjuk
		["NearbyShip_MovePathLineCheckThreshold"] = 150,  -- utvonalkeresesnel, az elvi utvonaltol ennel messzebb levo a hajokkal nem foglalkozunk.
		["NearbyShip_WayClearCheckTime"] = 0.25,   -- ennyi idonkent ellenorzni, hogy szabad-e az ut arra, amerre a legoptimalisabb lenne az ut a cel fele
		["NearbyShip_GoAwaySpdAdd"] = 2.0,        -- a kozeli hajokhoz valo odaeres sebessege a ket hajo sebessegkulonbsege plusz ez.
		["HitDetector_LastHitDistAddOn"] = 50,    -- ha egy hitdetektor talalatot erzekelt, utana ennyivel nagyobb tavolsagot ellenoriz mindaddig, amig meg nem szunik az eszleles

		["RightOfWayValues"] = {
			-- fontos: alul legyenek az altalanosabbak
			{"MOTHERSHIP",   900.0},
			{"BATTLESHIP",   800.0},
			{"CRUISER",      700.0},
			{"CARGO",        600.0},
			{"DESTROYER",    500.0},
			{"SUBMARINE",    400.0},
			{"LANDINGSHIP",  300.0},
			{"TORPEDOBOAT",  200.0},
			{"SHIP",         100.0},
		},
	}

	ShipGlobals["TorpedoAvoidance"]=
	{
		["CollectTimer"] = { 1.5, 2, },	 -- ennyi masodpercenkent frissiti a kozelben levo torpedok listajat
		["CollectHitTime"] = 10,	       -- ha egy torpedo ennyi masodperc alatt becsapodhat, akkor ezt felveszi az elkerulendo torpedok listajaba
	}

	ShipGlobals["LandAvoidance"]=
	{
		["CollectTimer"] = { 1, 1.5, },	         -- ennyi masodpercenkent frissiti a kozelben levo avoidzonakat
		["CheckMovePosZoneTime"] = { 2.5, 3, },	 -- ennyi masodpercenkent ellenorzi, hogy milyen avoidzonaban van a pathon mozgo hajo celpontja. utvonalkereseshez kell ez
		["CheckShipPosZoneTime"] = { 2.5, 3, },	 -- ennyi masodpercenkent ellenorzi, hogy milyen avoidzonaban van a hajo. utvonalkereseshez kell ez
		["CheckTravelZoneTime"] = { 3, 4, },	   -- ennyi masodpercenkent ellenorzi, hogy a hajo el tud-e jutni a celpontjahoz boztonsagos melysegu vizben. ha a celpont sekelyebb vizben van, es mar kozel van az aktualis zonaja szelehez, akkor sekelyebb zonara valt
		["YTurnDirDiff"] = { 1.8, 2.1, },
	}

	ShipGlobals["AvoidanceCheat"]=
	{
		["TurnSpdLimit"] = 4.0,	 -- veszhelyzetben javitjuk a hajo fordulekonysagat, hogy jobban elkerulje a veszelyes helyzeteket. Ha ennyi foknal kisebb a forgasi sebesseg, akkor kicsit gyorsitunk rajta.
		["TurnSpdMul"] = 0.5,	   -- veszhelyzetben javitjuk a hajo fordulekonysagat, hogy jobban elkerulje a veszelyes helyzeteket. Amennyivel kisebb a forgasi sebesseg a fenti erteknel, annyi szorozva ezzel lesz a forgasi sebesseg plusz
		["StopSpdMul"] = 2.0,	   -- veszhelyzetben megnoveljuk a hajo fekezoerejet, hogy hamarabb alljon meg. ennyiszeres lesz a fekezoero
	}

	ShipGlobals["Retreat"]=
	{
		["ExitDist"]            = 1000,   -- ha ennyi meterrel messzebb kerult a jatekter hataratol, akkor megszuntetjuk
		["ExitTime"]            = 60,     -- ha ennyi ideig a borderzone-ban van, akkor is mexuntetjuk
		["WarningRepeatTime"]   = 10,     -- ennyi masodpercenkent figyelmeztet minket egy warning, hogy kint motorozunk a borderen kivul
	}

  -- farnehez hajok javitasa
	ShipGlobals["Hack"]=
	{
		["RotationAdd"] = 0.0,  -- ennyivel lesz minden hajo kicsit elforgatva. lehet hajonkent is allitani, a vehicleclass.lua-ban az egyes hajoosztalyoknal, ["HackShipRotationAdd"] ertekkel.
		["HeightAdd"]   = 0.0,  -- ennyivel fog pluszban kiemelkedni a vizbol minden hajo. lehet hajonkent is allitani, a vehicleclass.lua-ban az egyes hajoosztalyoknal, ["HackShipHeightAdd"] ertekkel.
	}

	ShipGlobals["TorpedoHit"]=
	{
		["LifeTime"] = 1.1,	    -- hany masodpercig hat a blast ereje
		["Upthrust"] = 1000000, -- mekkora felhajtoero hat a becsapodas pontjaban
		["UpDist"] = 1.2,       -- hany meter magasra probalja kiemelni a hajot (a lendulet miatt magasabbra is emelkedhet, ha nagy az ero)
		["MassRatio"] = 300,    -- hekk: a hajo tomegenek max ennyiszerese lehet a felhajtoero. ez azert kell, hogy konnyu hajok ne repuljenek nagyot
	}

	ShipGlobals["Navigator"]=
	{
		["AutoThrust"]=
		{
			["SteerValueMin_Slow"] = 0.4,	 -- ha nem heading, hanem steer alapjan allapitjuk meg a kanyarodast, akkor ilyen steer erteknel lesz az also thrust limit maximalis
			["SteerValueMax_Slow"] = 1.0,  -- ha nem heading, hanem steer alapjan allapitjuk meg a kanyarodast, akkor ilyen steer erteknel lesz az also thrust limit minimalis
			["SteerValueMin_Fast"] = 0.75, -- ha nem heading, hanem steer alapjan allapitjuk meg a kanyarodast, akkor ilyen steer erteknel lesz a felso thrust limit maximalis
			["SteerValueMax_Fast"] = 1.5,  -- ha nem heading, hanem steer alapjan allapitjuk meg a kanyarodast, akkor ilyen steer erteknel lesz a felso thrust limit minimalis
			["HdgDiffValueMin_Slow"] = DEG(25),  -- ha heading alapjan, akkor ennel kisebb headingdiff eseten lesz az also hatar maximalis
			["HdgDiffValueMax_Slow"] = DEG(75),  -- ha heading alapjan, akkor ennel nagyobb headingdiff eseten lesz az also hatar minimalis
			["HdgDiffValueMin_Fast"] = DEG(45),  -- ha heading alapjan, akkor ennel kisebb headingdiff eseten lesz a felso hatar maximalis
			["HdgDiffValueMax_Fast"] = DEG(90),  -- ha heading alapjan, akkor ennel nagyobb headingdiff eseten lesz a felso hatar minimalis
			["ThrustMin_Slow"] = 0.5,   -- a minimalis thrust also hatar. a felso az 1.0
			["ThrustMin_Fast"] = 0.75,    -- a maximalis thrust also hatar. a felso az 1.0
			["HdgDiffDangerMul"] = 6.0,  -- veszely eseten (szuken kell kanyarodni, mert akadaly van elottunk) ennyivel felszorozzuk a headingkulonbseget, hogy kisebb thrust legyen
		},

		["TurnMultipliers"]=
		{
			["TurnMultiplierMinSpeed"] = { 0.0, 0.4 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
			["TurnMultiplierMedSpeed"] = { 0.5, 1.5 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
			["TurnMultiplierMaxSpeed"] = { 1.0, 2.0 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
		},

		["PathFinderParams"]=
		{
			["LengthModifier_DirDiffMin"]  = DEG(15), -- 
			["LengthModifier_DirDiffMax"]  = DEG(80), -- 
			["LengthModifier_LengthAddon"] = 1200, -- 
		},

		["IslandAttackTurnCircleMultiplier"] = 4.0,

		["FlockPredictTime"] = 3.0,
		["FlockSeparationStrength"] = 1.1,
		["FlockFollowStrength"] = 1.0,
		["FlockSeparationMinDistMult"] = 0.8,   -- a hajok taszitjak egymast, ha formacioban vannak. ha ket hajo kozotti tavolsag, osztva a kozos hosszukkal, ennel kisebb, akkor maximalis a taszitas
		["FlockSeparationMaxDistMult"] = 2.0,   -- a hajok taszitjak egymast, ha formacioban vannak. ha ket hajo kozotti tavolsag, osztva a kozos hosszukkal, ennel nagyobb, akkor nincs taszitas
		["FlockMoveTreshold"]   = 0.5,
		["FlockThrustTreshold"] = 0.2,
		["FlockBackSteerSpeed"] = -0.1,
		["FlockVectorMultiplier"] = 1.5,
		["FlockLeaderMaxHdg"] = DEG(20),
		["FlockLeaderMaxSideMove"] = 0.2,

		["SmallShipFlockFollow"] = true,
	}

--vizbeomlessel, sullyedessel kapcsolatos parameterek
	ShipGlobals["VizbeomlesDolgok"]=
	{
		["BoardUnderWaterTime"]		=55.0, --ennyi ideig kell a fedelzetnek viz alatt lenni, hogy a hajo tutira elsullyedjen (sec)
		["WaterEroMultiplier"]		=1, --ennyivel szorzodik a beomlott viz sulya
		["WaterErokarMultiplier"]	=2.2, -- NE IRD AT VAGY LAGALABB SZOLJ !!! - Sics - 1.29
		["CounterFloodingRatio"]	=2.0, --ennyiszeres kulonbsegig araszt el a counterflooding
		["CounterFloodingSpeed"]	=3.0, --a normal szivattyuzas ennyiszeresevel muxik a counterflooding
		["KillDepth"]					=  -200.0, --ilyen melyen fog egy hajo kikillezodni
		["PTBoatLeakSize"]			=100.0, --ekkora lyuk legyen a torpedoboaton, ha feketere valt (mertekegyseg?????)
		["Elarasztaskesleltetes"]	=120.0, --minel nagyobb annal lassabb arasztodik el a tobbi szekcio deadmeat-en 20 volt eddig

		["EnnyiVizEsKeszPercent"]	=0.2, -- a max vizkiszoritas ennyiszeresenel tobb befolyt viz eseten lesz a hajo deadmeat
		["LeakPerHP"]					=0.1, -- 1 hp sebzesnel ennyi tonna viz fog a hajoba folyni masodpercenkent
		["MaxLeakPercent"]			=0.02, -- ennel tobb viz nem fog a hajoba folyni masodpercenkent, meg ha a lek nagyobb is (a max vizkiszoritas szazaleka)
		["HullRepairSpeed"]			=0.2, --ennyi tonna vizzel fog kevesebb befolyni masodpercenkent
		["PumpSpeed"]					=10, --ennyi tonna vizet szivattyuznak ki masodpercenkent (mindegy, mert a pumptimetoempty a hasznalt parameter)
		["RemainingWaterPercent"]	=0.66, --a bearamlott viz ekkora szazalekat nem lehet mar kiszivattyuzni

		["DologSzorzo"]				=2,   --ketszer akkora sebzestol hanyszor akkora vizbefolyas legyen

		["SinkEffect"]="SurfaceBubbles",
		["SinkEffectEnnyiMeterenkent"]=7,
		["SinkEffectIlyenGyakran"]=2000, --minel tobb, annal kevesebb, minimum 1
	}

--fordulas
	ShipGlobals["Fordulas"]=
	{
		["TurnMultiplierMinSpeed"] = { 0.0, 0.5 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
		["TurnMultiplierMedSpeed"] = { 0.5, 1.5 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
		["TurnMultiplierMaxSpeed"] = { 1.0, 2.0 }, -- mekkora gazkar allasnal mennyivel szorzodjon a vehicleclass-ban megadott fordulokor sugara. Elso ertek a gazkar allasa, masodik a fordulokor szorzoja
	}

--formacio
	ShipGlobals["Formacio"]=
	{
		["HeadingMul"]		=0.005,
		["HeadingPower"]	=1,
		["ThrustMul"]		=0.01,
		["FollowerSpeedMul"]=1.5,	--ennyiszer gyorsabban tudnak menni a formacio kovetohajok a max sebesseguknel szukseg eseten
		["FollowerMaxDist"]=1990.0, --maximum ekkora tavolsagra lehetnek a tagok a formacio leadertol. ez mindenkire vonatkozik
		["PlayerFollowerMaxDist"]=1990.0, --CSAK A JATEKOS ALTAL IS IRANYITHATO FORMACIOKRA VONATKOZIK, A GUI MIATT!! maximum ekkora tavolsagra lehetnek a kovetok a leadertol. ha ennel messzebb vannak, akkor kozelitenek
		["FormationShipDist"]=290.0, --ilyen messze vannak egymastol a hajok a nem kusztom formaciokban
		["FormationMaxCount"]= 24,--8, --maximum enyi tagbol allhat egy formacio
		["UpdateInterval"]=10.0, --ilyen surun probalunk hajokat cserelgetni
	}

--hajo kamera
	ShipGlobals["ShipCamera"]=
	{
		["LengthMult"] = 1.0,
		["ZoomOffset"] = 1.25,
		["MinCameraAngle"]=-89, --fokban
		["MaxCameraAngle"]=89, --fokban. az ertekek maradjanak -89 es 89 fok kozott
		["FollowCamDelay"] = 1,
	}

--repair
	ShipGlobals["Repair"]=
	{
		["RepairScriptInterval"]=2.0, --ennyi masodpercenkent hivodnak meg a repair scriptek
		["RepairStepValue"]= 0.025, -- hivasonkent a hpblack ekkora reszet javitjuk fel
		["RepairTeamCount"]=3, --ennyi repair-team van az osszes hajon amin van repair
		["RepairTeamBonus"]=0.60, --ennyivel gyorsitja egy repair-team konkret feladathoz rendelese az adott cucc javitasat
		["RepairTeamPenalty"]=0.10, --ennyivel lassitja egy repair-team konkret feladathoz rendelese a tobbi cucc javitasat
		["RepairUnderwaterModifier"]=0.70, --ennyiszer lassabban javitjak a viz alatt tartozkodo tengeralattjarot
		["RepairCrewLevelMultipliers"] = { 0.5, 0.8, 1, 1, 1.2, 1.4 }, -- Stun, SPNormal, SPVeteran, MPNormal, MPVeteran, Elite
		["RepairZoneMultiplier"]=5.00, --ennyiszer gyorsabban javitanak, ha a hajo repair zonaban van
		["TorpedoRestockTime"]=1.00, -- ennyi masodpercenkent kap a hajo +1 torpedot, ha repair zonaban van
	}


--submarine
	ShipGlobals["Submarine"]=
	{
		["SubmarineTorpedoRange"]		=400.0,  -- max ilyen messzirol szeret torpedozni ne allitsd tul kicsire

		["SubmarinePeriscopeLevel"]	=20.0,	--periszkopmelyseg
		["SubmarineMediumLevel"]		=50.0,	--kozepes melyseg
		["SubmarineDeepLevel"]			=80.0,	--mely segg
		["SubmarineDamageDepth"]		=70.0,   --ilyen melysegtol kezd el serulni

		["SubmarineAirWarningLimit"]			=0.35, --ha ennyi x 100 szazalek ala csokken a levegoszint, jon a warning
		["SubmarineAirNeedLimit"]			=0.16, --ha ennyi x 100 szazalek ala csokken a levegoszint, megyunk fel
		["SubmarineAirEnoughLimit"]			=0.5, --ha ennyi x 100 szazalek fole no a levegoszint, akkor csuhajla

		["SubmarineDepthDamage"]			=9.0,--ennyivel csokken a HP-ja a legnagyobb melysegben 1 sec alatt
		["SubmarineDepthSpeedMul"]			=0.834,--(834=25 csomo) ennyiszeresere megy ossze a submarine sebessege minden melysegben (regen legnagyobb melysegben)

		["SubSurfaceMinDist"]  = 500,  -- ilyen kozel a partokhoz mar teljesen feljon a felszinre, nehogy a talaj ala lassunk mi gonoszak
		["SubSurfaceMaxDist"]  = 1000,  -- ha kozeledik a parthoz, akkor a partoktol ilyen messze kezd emelkedni, hogy mire annyira kozel er, mint a fentebbi ertek, addigra felerjen teljesen

		["PeriscopeRepairTime"]	= 60.0,
	}

	ShipGlobals["SubAttack"]=
	{
		["MaxTorpedoRange"]		=800.0,  -- max ilyen messzirol szeret torpedozni
		["TooCloseDist"]		=400.0,  -- ha ilyen kozel kerult inkabb abbahagyja a lovoldozest/rafordulast
										 -- ha ez tul kicsi, akkor a sub nem tud majd rafordulni a celra, emiatt csak koroz a cel korul
										 -- ezt ultimate levellel kene beloni
		["FarEnoughDist"]		=480.0,  -- tavolodasnal ilyen messze erve fordul vissza a celra
										 -- celszeruen minimum 50-100 meterrel tobb mint a TooCloseDist, ekkor kezd visszafordulni
		["SubmarineLostTime"]		= 30,    -- ennyi masodpercig uldozik a tengeralattjarora vadaszo hajok a szem elol tevesztett tengeralattjarot; aztan feladjak
	}

-- lift anyahajon
	ShipGlobals["MotherShip"]=
	{
		["ElevatorSpeed"]=4.0,  --meter/sec. ha tul lassu nem mukodik rendesen a leszallas; ha tul gyors, akkor multiban nagy ping eseten eleg szarul nezhet ki kliensen
		["ElevatorDepth"]=7.0,  --meter.     milyen melyre sullyedjen le a lift
	}
	
-- UW DoF Paraméterek	
	ShipGlobals["DOFParams"] =
	{
		["Dist"] = 50,
		["Range1"] = 300,
		["Range2"] = 550,
		["MaxAmount"] = 0.1,
		["MinAmount"] = 0.6,
	}

--fizika
	ShipGlobals["Physics"]=
	{
		["WreckChance"]=0.3,
		
		["Ship"]=
		{
			["KozegellenallasiEgyutthatoL"]=0.1,
			["KozegellenallasiEgyutthatoN"]=0.03,
			["KozegellenallasiEgyutthatoLFel"]=0.1,
			["KozegellenallasiEgyutthatoNFel"]=0.03,

			["KozegellenallasiEgyutthatoLOldalra"]=0.1,
			["KozegellenallasiEgyutthatoNOldalra"]=0.01,

			["KozegellenallasiEgyutthatoLElore"]=0.001,
			["KozegellenallasiEgyutthatoNElore"]=0.03,

			["NyomatekSzorzo"]={1,1,2},
			["Kitevo"]=1.0,
			["Gravitacio"]=10.0,
			["Friction"]=0.5,
		},
		["TBoat"]=
		{
			["KozegellenallasiEgyutthatoL"]=0.5,
			["KozegellenallasiEgyutthatoN"]=0.03,
			["KozegellenallasiEgyutthatoLFel"]=0.5,
			["KozegellenallasiEgyutthatoNFel"]=0.03,

			["KozegellenallasiEgyutthatoLOldalra"]=0.5,
			["KozegellenallasiEgyutthatoNOldalra"]=0.1,

			["KozegellenallasiEgyutthatoLElore"]=0.075,
			["KozegellenallasiEgyutthatoNElore"]=0.001,

			["NyomatekSzorzo"]={1,1,2},
			["Kitevo"]=0.5,
			["Gravitacio"]=10.0,
			["Friction"]=0.5,
		},
		["Submarine"]=
		{
			["KozegellenallasiEgyutthatoL"]=0.05,
			["KozegellenallasiEgyutthatoN"]=0.01,
			["KozegellenallasiEgyutthatoLFel"]=0.1,
			["KozegellenallasiEgyutthatoNFel"]=0.03,

			["KozegellenallasiEgyutthatoLOldalra"]=0.1,
			["KozegellenallasiEgyutthatoNOldalra"]=0.03,

			["KozegellenallasiEgyutthatoLElore"]=0.001,
			["KozegellenallasiEgyutthatoNElore"]=0.03,

			["NyomatekSzorzo"]={1,1,1},
			["Kitevo"]=1.0,
			["Gravitacio"]=10.0,
			["Friction"]=1.0,
		},

		["TBoatNyomatekSzorzo"]=1500,
		["TBoatMotorMaxSzog"]=10.0,
		["TorpedoForce"]=-75,
	}
--sounds
	ShipGlobals["Sounds"]=
	{
		["TBoat"]=
		{
-- 			["EngineSoundFreqLow"]=1.0,
--  			["EngineSoundFreqHigh"]=1.0,
				["EngineSoundSmoothRate"]=0.5,
-- 			["EngineSoundFreqLimit"]=0.0,
    			["VolumeFadeRate"]=0.9,

--	 			["HajoCsavarFreqLow"]=1.0,
--	 			["HajoCsavarFreqHigh"]=1.0,

--	 			["OrrHullamFreqLow"]=1.0,
--  			["OrrHullamFreqHigh"]=1.0,
		},
		["Ship"]=
		{
-- 			["EngineSoundFreqLow"]=0.5,
-- 			["EngineSoundFreqHigh"]=1.0,
	 			["EngineSoundSmoothRate"]=0.5,
-- 			["EngineSoundFreqLimit"]=0.2,
	 			["VolumeFadeRate"]=1.0,

-- 			["HajoCsavarFreqLow"]=0.6,
-- 			["HajoCsavarFreqHigh"]=1.0,

-- 			["OrrHullamFreqLow"]=0.5,
-- 			["OrrHullamFreqHigh"]=1.0,
		},
		["Submarine"]=
		{
--			["EngineSoundFreqLow"]=1.0,
--			["EngineSoundFreqHigh"]=1.0,
			["EngineSoundSmoothRate"]=0.5,
--			["EngineSoundFreqLimit"]=0.2,
			["VolumeFadeRate"]=1.0,

--			["HajoCsavarFreqLow"]=0.6,
--			["HajoCsavarFreqHigh"]=1.0,

--			["OrrHullamFreqLow"]=0.5,
--			["OrrHullamFreqHigh"]=1.0,
		},
		["Plane"]=
		{
--			["EngineSoundFreqLow"]=1.0,
--			["EngineSoundFreqHigh"]=1.0,
			["EngineSoundSmoothRate"]=0.5,
--			["EngineSoundFreqLimit"]=0.2,
			["VolumeFadeRate"]=0.5,
		},

		["ShipDeadMeatSoundTimeMin"]=10.0,
		["ShipDeadMeatSoundTimeMax"]=15.0,
		["PlaneDeadMeatFreq0"]=1.0,
		["PlaneDeadMeatFreq1000"]=0.5,
	}

	ShipGlobals["Flag"]=
	{
		["NeedFlag"]=true,
		["WindPowerMin"]=8.0,
		["WindPowerMax"]=9.0,
		["WindPowerChange"]=0.04,
		["WindDirMin"]=-1,
		["WindDirMax"]=1,
		["WindDirChange"]=0.01,
		["DtMul"]=1.5,
		["DtStep"]=0.01666,
		["NumIteration"]=10,
		["Drag"]=1.5,
		["Gravity"]=0.75,
	}

	ShipGlobals["FreeCameraShot"]=
	{
		{
			["Name"]="Ezerotszaz demidzs", --a damage nem szamit laci aszonta
			["Speed"]=2000.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=0.01,
			["LifeSpan"]=1.0,
			["Damage"]=1000,
			["BlastDamage"]=1500.0,
			["BlastRadius"]=5.0,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="5InchExplosionArmour",
			["SplashEffect"]="5InchExplosionWater",
		},
		{
			["Name"]="BFG 9000 - mindent megol",
			["Speed"]=1000.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=0.2,
			["LifeSpan"]=0.3,
			["Damage"]=20,
			["BlastDamage"]=200000.0,
			["BlastRadius"]=1000000,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="5InchExplosionArmour",
			["SplashEffect"]="5InchExplosionWater",

		},
		{
			["Name"]="UFO lezeragyu 200 hp + 200 blast 10m",
			["Speed"]=1000.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=0.5,
			["LifeSpan"]=4.0,
			["Damage"]=200,
			["BlastDamage"]=200.0,
			["BlastRadius"]=10,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="SmallPlaneExplosion",
			["SplashEffect"]="SmallPlaneExplosionWater",
		},
		{
			["Name"]="Test DD gun",
			["Speed"]=1000.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=0.5,
			["LifeSpan"]=14.0,
			["Damage"]=120,
			["BlastDamage"]=30.0,
			["BlastRadius"]=10.0,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="5InchExplosionArmour",
			["SplashEffect"]="5InchExplosionWater",

		},
		{
			["Name"]="UFO geppuska 18 hp",
			["Speed"]=1000.0,
			["Gravity"]=0.0,
			["SingleShot"]=false,
			["ShotFrequency"]=0.1,
			["LifeSpan"]=2.0,
			["Damage"]=1,
			["BlastDamage"]=18.0,
			["BlastRadius"]=0.01,
			["BulletEffect"]="MachineGunBulletTracer",
			["ExplosionEffect"]="MachinegunHit",
			["SplashEffect"]="5InchExplosionWater",
		},
		{
			["Name"]="Standard torpedo damage 800 blast 1m",
			["Speed"]=600.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=1.0,
			["LifeSpan"]=10.0,
			["BlastDamage"]=800.0,
			["BlastRadius"]=1.0,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="5InchExplosionArmour",
			["SplashEffect"]="5InchExplosionWater",
		},

		{
			["Name"]="ARPI lezerbantodolog 500 hp + 500 blast 50m", --a damage nem szamit laci aszonta
			["Speed"]=2000.0,
			["Gravity"]=0.0,
			["SingleShot"]=true,
			["ShotFrequency"]=0.01,
			["LifeSpan"]=4.0,
			["Damage"]=500,
			["BlastDamage"]=500.0,
			["BlastRadius"]=50.0,
			["BulletEffect"]="5InchBulletTracer",
			["ExplosionEffect"]="5InchExplosionArmour",
			["SplashEffect"]="5InchExplosionWater",
		},
	}

	ShipGlobals["Fire"]=
	{
		["FireDamagePerFireTick"]=10.0,		--ennyit sebez a tuz tickenkent (ami jelenleg 5 sec)
	}

--universe\Scenes\Unittest\Planes\Zero.scn

DoFile("scripts/datatables/ScriptOptions.lua")

if FailureDebug then
	ShipGlobals.WaterTickDamage=0.01 --ennyit sebez a viz tickenkemt
	ShipGlobals.FireTickDamage=0.01 --ennyit sebez a tuz tickenkent
	ShipGlobals.BodyRepairTickPercentage=0.05 --ennyi szazalekot gyogyul a hajotest normal repair mellett tickenkent
	ShipGlobals.GunRepairTickPercentage=2 --ennyi szazalekot gyogyulnak a fegyverek normal repair mellett tickenkent
	ShipGlobals.FireFailureChance=0.01 --ilyen esellyel lesz failure a tuztol tickenkent
	ShipGlobals.FireFailureDamageDuration=20 --a hajo ennyi masodperc firedamage-et kap, ha fueltankfailure van
	ShipGlobals.ExplosionDamagePercentage=0.01 ----a hajo maxhpjanak ennyi szazalekat kapja meg a hajo damage-kent, ha explosionfailure van
	ShipGlobals.PumpRepairMultiplier=2 --ennyiszer kevesebb dotot ad a viz
	ShipGlobals.FireRepairMultiplier=2 --ennyiszer kevesebb dotot ad a tuz
	ShipGlobals.FireFailureChanceMultiplier=2 --ennyiszer ritkabban okoz failure-t a tuz, ha a fire-t szeretjuk gyogyitani a legjobban a vilagon
	ShipGlobals.FailureRepairMultiplier=2 --ennyiszer gyorsabban gyogyulnak a failure-ok,
	ShipGlobals.BodyRepairMultiplier=2 --ennyiszer gyorsabban gyogyul a hajotest
	ShipGlobals.GunRepairMultiplier=2 --ennyiszer gyorsabban gyogyulnak a fegyverek
	ShipGlobals.FailureChance=100 --ennyi az eselye a szekcio failure-nek, ha
	ShipGlobals.FailureDamageThreshold=1 --ennyi sebzest kap be

	ShipGlobals.Failures=
	{
		{
			["SectionName"]="steering",
			["FailureName"]="SteeringJam",
			["FailureDuration"]=10,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="engineroom",
			["FailureName"]="EngineJam",
			["FailureDuration"]=20,
			["FireFailure"]=true,
		},
		{
			["SectionName"]="runway",
			["FailureName"]="RunwayFailure",
			["FailureDuration"]=10,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="hangar",
			["FailureName"]="HangarFailure",
			["FailureDuration"]=10,
			["FireFailure"]=false,
		},
		{
			["SectionName"]="magazine",
			["FailureName"]="Explosion",
			["FailureDuration"]=5, --cooldown ebben az esetben
			["FireFailure"]=false,
		},
		{
			["SectionName"]="fueltank",
			["FailureName"]="Fire",
			["FailureDuration"]=10, --cooldown ebben az esetben
			["FireFailure"]=false,
		},
	}
end
