Robots = {}

-- nehany helyre kell stun is, pl. artillery subdirector!!!

Robots["AAFlakBot"] =    -- azokra az agyukra, akik Flakkal tudnak loni
{
	["NoTargetTimeUntilRest"] = 20.0,	-- ha ennyi ideig nincs target, akkor visszafordul alapallasba

	-- GoodRatio szazalekban megadva, azaz mennyi az eselye, hogy 'jol' lo. Ha 'jol' lo, akkor a ...Min es ...Max ertekek kozott valaszt, ha rosszul, akkor a ...Max es ...Bad ertekek kozott.
	-- AngleErr: ennyi fokkal a celpont pontos helye melle celoz, tetszoleges iranyba.  fokokban van megadva. Ha 'jol' lo, akkor a ...Min es ...Max ertekek kozott valaszt, ha rosszul, akkor a ...Max es ...Bad ertekek kozott.
	-- DistErr:  a flak nem akkor robban, amikor a celponthoz legkozelebb van, hanem meg elotte vagy utana valamennyivel. Ezt a valamennyit lehet itt megadni, a flak robbanasi radiuszanak szazalekaban megadva. Ha 'jol' lo, akkor a ...Min es ...Max ertekek kozott valaszt, ha rosszul, akkor a ...Max es ...Bad ertekek kozott.
	-- BulletThrowMul: az agyu default szorasat megszorozza ezzel. 0.0-ra azert ne nagyon allitsuk, lehet akkor pont minden loves kicsivel melle fog menni

	["SPNormal"] =
	{
		["GoodRatio"] = 0.40,	-- hany szazalekban lo jol. ha jol lo, akkor min es max kozott valaszt, ha rosszul, akkor max es bad kozott
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 2.0,
		["AngleErrBad"] = 4.5,
		["DistErrMin"] = 0.4,
		["DistErrMax"] = 1.5,
		["DistErrBad"] = 3.0,
		["BulletThrowMul"] = 0.6,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["GoodRatio"] = 0.55,
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 1.0,
		["AngleErrBad"] = 3.0,
		["DistErrMin"] = 0.1,
		["DistErrMax"] = 1.2,
		["DistErrBad"] = 2.5,
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["GoodRatio"] = 0.7,
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 0.5,
		["AngleErrBad"] = 1.5,
		["DistErrMin"] = 0.0,
		["DistErrMax"] = 1.0,
		["DistErrBad"] = 2.0,
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["GoodRatio"] = 0.85,
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 0.1,
		["AngleErrBad"] = 1.0,
		["DistErrMin"] = 0.0,
		["DistErrMax"] = 0.5,
		["DistErrBad"] = 1.0,
		["BulletThrowMul"] = 0.25,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPVeteran
	["Elite"] =
	{
		["GoodRatio"] = 1,
		["AngleErrMin"] = 0,
		["AngleErrMax"] = 0,
		["AngleErrBad"] = 0,
		["DistErrMin"] = 0,
		["DistErrMax"] = 0,
		["DistErrBad"] = 0,
		["BulletThrowMul"] = 0.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["GoodRatio"] = 0.0,
		["AngleErrMin"] = 0.5,
		["AngleErrMax"] = 5.0,
		["AngleErrBad"] = 7.0,
		["DistErrMin"] = 0.5,
		["DistErrMax"] = 5.0,
		["DistErrBad"] = 7.0,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Stun
} --AAFlakBot

Robots["TailGunnerBot"] =
{
	["NoTargetTimeUntilRest"] = 20.0,

	-- AimPeriodMin AimPeriodMax : iranyzek helyesbites perioduisa sec.ben (random tol..ig)
	-- AngleError : celzasi hiba fokban (random 0..AngleError)
	-- ShootRange : ilyen tavolsagbol lo a celpontra. meterben

	["SPNormal"] =
	{
		["AngleError"] = 3.0,
		["AimPeriodMin"] = 0.1,
		["AimPeriodMax"] = 0.8,
		["ShootRange"]   = 750,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t			
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["AngleError"] = 2.5,
		["AimPeriodMin"] = 0.1,
		["AimPeriodMax"] = 0.5,
		["ShootRange"]   = 800,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["AngleError"] = 2.5,
		["AimPeriodMin"] = 0.1,
		["AimPeriodMax"] = 0.3,
		["ShootRange"]   = 800,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["AngleError"] = 1.5,
		["AimPeriodMin"] = 0.1,
		["AimPeriodMax"] = 0.2,
		["ShootRange"]   = 850,
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --MPVeteran
	["Elite"] =
	{
		["AngleError"] = 0,
		["AimPeriodMin"] = 0,
		["AimPeriodMax"] = 0.1,
		["ShootRange"]   = 950,
		["BulletThrowMul"] = 0.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["AngleError"] = 4,
		["AimPeriodMin"] = 0.6,
		["AimPeriodMax"] = 1.2,
		["ShootRange"]   = 950,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --Stun
} --TailGunnerBot

Robots["AAGunnerBot"] =   -- azoka  legvedelmi agyuk, amik nem tudnak flakot loni. Hajokra a celzast meg befolyasolja a "AAGunnerErrorModifier" ertek a ShipGlobals.lua-ban !!!!!
{
	["NoTargetTimeUntilRest"] = 20.0,

	-- AngleDiffErrorRatio : celzas kozben nem a celpontra lo mindig, hanem 'imbolyog' egy elvi pont a celpont korul, es arra celoz. Ez annak a nagysaga, hogy a celpont meretehez kepest mekkora teruleten imbolyogjon ez az elvi pont, amire celoz. Ha 1.0, akkor a celzott unit boundingboxan belul marad, ha nagyobb, akkor annyiszor nagyobb teruleten imbolyog. ha a celra MEROLEGESEN haladsz, roszabbul celoznak rad (messze eled kellene celozni amit rosszul becsulnek meg)
	-- Dist2AngleErrRatio : UNSUPPORTED: nincs hasznalva!!!! celtavolsag fuggvenyeben a szogtevedes (dist*Dist2AngleErrRatio) -- EZT NE HASZNALD MERT TELJESEN IMPOTENS LESZ TOLE A CELZAS
	-- ConstAngleError : egy random maximum ekkora szoggel melle fog celozni az agyu a celpontnak, valamilyen iranyba. szogben kell megadni. random(0,ConstAngleError) az aktualis tevedes, ezt idonkent frissiti
	-- BulletThrowMul: az agyu default szorasat megszorozza ezzel. 0.0-ra azert ne nagyon allitsuk, lehet akkor pont minden loves kicsivel melle fog menni

	["SPNormal"] =
	{
		["ConstAngleError"] = 4,
		["AngleDiffErrorRatio"] = 5,
		["Dist2AngleErrRatio"] = 0.000, -- UNSUPPORTED: nincs hasznalva!!!!
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["ConstAngleError"] = 2.5,
		["AngleDiffErrorRatio"] = 2.5,
		["Dist2AngleErrRatio"] = 0.000, -- UNSUPPORTED: nincs hasznalva!!!!
		["BulletThrowMul"] = 0.75,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["ConstAngleError"] = 1,
		["AngleDiffErrorRatio"] = 1,
		["Dist2AngleErrRatio"] = 0.000, -- UNSUPPORTED: nincs hasznalva!!!!
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["ConstAngleError"] = 0.5,
		["AngleDiffErrorRatio"] = 0.5,
		["Dist2AngleErrRatio"] = 0.000, -- UNSUPPORTED: nincs hasznalva!!!!
		["BulletThrowMul"] = 0.25,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPVeteran
	["Elite"] =
	{
		["ConstAngleError"] = 0,
		["AngleDiffErrorRatio"] = 0,
		["Dist2AngleErrRatio"] = 0, -- UNSUPPORTED: nincs hasznalva!!!!
		["BulletThrowMul"] = 0.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["ConstAngleError"] = 7,
		["AngleDiffErrorRatio"] = 7,
		["Dist2AngleErrRatio"] = 0.4, -- UNSUPPORTED: nincs hasznalva!!!! 
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Stun
} --AAGunnerBot

Robots["ArtillerySubDirectorBot"] =
{
  -- ebben taroljuk, hogy a bot mennyivel celozzon a celpont melle. A melleloves erteket olyan gyakran frissitjuk, amilyen gyakran a weapondirector frissul (globals.lua: WeaponDirectorThinkTime)
  -- a melleloves merteket csak akkor csokkentjuk, ha lott az agyu a legutobbi frissites ota, azaz lovesenkent. Ha nem lo egy megadott ideig, akkor visszarontjuk a hibazast.
  
	-- ErrorDistIncStartTime : ha ennyi ideig nem lo az agyu, akkor szep lassan elkezd noni az ErrorRange, hogy romoljon a celzas, ha majd megint elkezd loni
	-- ErrorDistIncFullTime  : ennyi masodperc alatt romlik vissza az ErrorRange a maximalis meretre, ha nem lo az agyu.
	-- MaxErrorRadius	: maximum ennyire fog messzi loni a celponttol (kb. 100-1000)
	-- ErrorRangeMul	: celpont tolunk mert tavolsagat megszorozza ennyivel, es ennel nagyobbat nem fog hibazni
	-- MinErrorMul		: az elso lovesnel minimum (kiszamolt hiba*MinErrorMul)-t hibazik (kb. 0.0-0.9)
	-- ApproachMulMin	: minden loves utan ennyivel szorozza a tavolsagot (kb. 0.1-0.9), ha a celpont mar nagyon kozel van
	-- ApproachMulMax	: minden loves utan ennyivel szorozza a tavolsagot (kb. 0.1-0.9), ha a celpont meg nagyon tavol van
	-- 						(a ketto kozott atmenetet szamol, es azzal szoroz tenylegesen)
	-- DeviationMul		: minden frissitesnel, ha volt loves, akkor a celpont pozicio es a tippelt pozicio tavolsagat ennyivel megszorozzuk es hozzaadjuk a hibatavolsaghoz. Ha ez nagy, es gyorsan mozog a celpont, akkor mindig nagy lesz a melleloves, nem tud lecsokkenni (kb. 0.1-10.0)
	-- AngleChange		: a tevedes szogenek sebessege. Masodpercenkent ennyi fokot fordul a loves helye a celpont korul. Minden frissitesnel ujra szamoljuk ezt a sebesseget: rnd(+-AngleChange/2) (kb. 10-90 DEG)

	["SPNormal"] =
	{
		["ErrorDistIncStartTime"] = 10,
		["ErrorDistIncFullTime"] = 40,
		["MaxErrorRadius"] = 40,
		["ErrorRangeMul"] = 0.20,
		["MinErrorMul"] = 0.50,
		["ApproachMulMin"] = 0.15,
		["ApproachMulMax"] = 0.25,
		["DeviationMul"] = 0.8,
		["AngleChange"] = DEG(15),
		["BulletThrowMul"] = 0.9,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["ErrorDistIncStartTime"] = 20,
		["ErrorDistIncFullTime"] = 80,
		["MaxErrorRadius"] = 25,
		["ErrorRangeMul"] = 0.15,
		["MinErrorMul"] = 0.30,
		["ApproachMulMin"] = 0.12,
		["ApproachMulMax"] = 0.20,
		["DeviationMul"] = 0.75,
		["AngleChange"] = DEG(12),
		["BulletThrowMul"] = 0.85,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["ErrorDistIncStartTime"] = 20,
		["ErrorDistIncFullTime"] = 90,
		["MaxErrorRadius"] = 25,
		["ErrorRangeMul"] = 0.10,
		["MinErrorMul"] = 0.15,
		["ApproachMulMin"] = 0.15,
		["ApproachMulMax"] = 0.20,
		["DeviationMul"] = 0.75,
		["AngleChange"] = DEG(10),
		["BulletThrowMul"] = 0.85,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["ErrorDistIncStartTime"] = 40,
		["ErrorDistIncFullTime"] = 100,
		["MaxErrorRadius"] = 15,
		["ErrorRangeMul"] = 0.10,
		["MinErrorMul"] = 0.10,
		["ApproachMulMin"] = 0.10,
		["ApproachMulMax"] = 0.175,
		["DeviationMul"] = 0.70,
		["AngleChange"] = DEG(10),
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPVeteran
	["Elite"] =
	{		
		["ErrorDistIncStartTime"] = 60,
		["ErrorDistIncFullTime"] = 120,
		["MaxErrorRadius"] = 0,
		["ErrorRangeMul"] = 0,
		["MinErrorMul"] = 0,
		["ApproachMulMin"] = 0,
		["ApproachMulMax"] = 0,
		["DeviationMul"] = 0,
		["AngleChange"] = DEG(10),
		["BulletThrowMul"] = 0.1,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["ErrorDistIncStartTime"] = 5,
		["ErrorDistIncFullTime"] = 30,
		["MaxErrorRadius"] = 750,
		["ErrorRangeMul"] = 0.50,
		["MinErrorMul"] = 0.75,
		["ApproachMulMin"] = 0.75,
		["ApproachMulMax"] = 0.75,
		["DeviationMul"] = 10.00,
		["AngleChange"] = DEG(20),
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Stun
} --ArtillerySubDirectorBot

Robots["ArtilleryGunnerBot"] =
{
	["NoTargetTimeUntilRest"] = 20.0,

	-- MaxAngleError - szogtevedes celzasnal
	-- Power>=1 - eloszlast hatarozza meg; 1-nel egyenletes az eloszlas 1 folott a kisebb tevedes valoszinubb mint a nagyobb

	["SPNormal"] =
	{
		["MaxAngleError"] = DEG(5),
		["Power"] = 1,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 0.2,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1.0,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 0.1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 0.1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["MaxAngleError"] = DEG(4),
		["Power"] = 1.25,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 0.3,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 0.5,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 0.5,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["MaxAngleError"] = DEG(4),
		["Power"] = 1.5,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 0.5,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1.0,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 0.8,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 0.8,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["MaxAngleError"] = DEG(2),
		["Power"] = 1.8,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 0.8,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --MPVeteran
	["Elite"] =
	{
		["MaxAngleError"] = DEG(0),
		["Power"] = 2,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 1.0,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 0.5,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["MaxAngleError"] = DEG(10),
		["Power"] = 1,
		["TargetPointRefreshTime"] = 5,  -- ennyi masodpercenkent szamol uj celozhato pontot a targetjen, amit majd loni fog
		["SectionTargetChance"] = 0.0,   -- minden uj celozhato pont keresesnel ennyi az eselye, hogy ugy dont, egy szekciot fog loni. Ha nem szekciot fog loni, akkor random valaszt egy pontot a target egesz feluleten
		["EngineRoomWeight"] = 1,  -- ha szekciot fog loni, akkor ekkora sullyal valasztja az engineroom-t
		["MagazineWeight"] = 0.1,    -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  magazine-t
		["FueltankWeight"] = 0.1,		 -- ha szekciot fog loni, akkor ekkora sullyal valasztja a  fueltankot-t
	}, --Stun
} --ArtilleryGunnerBot

Robots["TorpedoBot"] =
{
	["NoTargetTimeUntilRest"] = 20.0,

	-- angle err fokokban megadva

	["SPNormal"] =
	{
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 10.0,
		["FireTargetAccuracy"] = 0.35,	-- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.45,   -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 7.5,
		["FireTargetAccuracy"] = 0.15,	-- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.25,    -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 6.0,
		["FireTargetAccuracy"] = 0.04,	 -- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.05,   -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["AngleErrMin"] = 0.0,
		["AngleErrMax"] = 3.0,
		["FireTargetAccuracy"] = 0.045,	 -- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.05,   -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --MPVeteran
	["Elite"] =
	{
		["AngleErrMin"] = 0,
		["AngleErrMax"] = 0.5,
		["FireTargetAccuracy"] = 0.055,	-- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.065,   -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 0.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["AngleErrMin"] = 10.0,
		["AngleErrMax"] = 20.0,
		["FireTargetAccuracy"] = 0.03,	-- a kijelolt celpontra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["AnyTargetAccuracy"] = 0.035,   -- agressziv modban, nem kijelolt celpontokra csak akkor lo torpedot, ha a talalati esely ennel jobb
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
	}, --Stun
} --TorpedoBot

Robots["DepthChargeBot"] =
{
	["NoTargetTimeUntilRest"] = 20.0,

	-- AttackDist: milyen messzi lehet maximum a tengeralattjaro a kiszamlolt talalkozasi ponthoz (20-100 m)

	["SPNormal"] =
	{
		["AttackDist"] = 30,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 0.5,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 2.0, 5.0, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["AttackDist"] = 45,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 1.0,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 1.0, 2.5, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["AttackDist"] = 60,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 1.0,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 3.0, 5.0, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["AttackDist"] = 80,
		["BulletThrowMul"] = 0.5,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 2.5,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 0.1, 1.0, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --MPVeteran
	["Elite"] =
	{
		["AttackDist"] = 100,
		["BulletThrowMul"] = 0.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 10.0,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 0.0, 0.0, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["AttackDist"] = 100,
		["BulletThrowMul"] = 1.0,  -- a kilott lovedekek szorasat megszorozza ezzel
		["ContinuousFireTime"] = 0.5,  -- ha lo, ennyi ideig folyamatosan lo. a bulletclass reloadtime-jatol, illetve az agyucsovek szamatol fugg, hogy ez alatt hany DC-t tud kidobni. ha 0, lehet, hogy egyet sem fog loni
		["FireDelay"] = { 5.0, 7.0, }   -- miutan lott, random ennyi ideig nem lo ujra			
	}, --Stun
} --DepthChargeBot

Robots["NavigatorBot"] =
{
	["SPNormal"] =
	{
		["TorpedoPredict"] = { 3.5, 5.0 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 100.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["TorpedoObservation"] = { 3.5, 5.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["TorpedoObservationSubAddon"] = { 4.0 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["SubAttackDistMultiplier"] = 1.3,
		["ArtilleryAttackDistError"] = { 100, 200 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -3.0, 1.0 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		["TorpedoPredict"] = { 5.0, 7.5 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 100.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["TorpedoObservation"] = { 1.5, 4.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["TorpedoObservationSubAddon"] = { 3.5 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["SubAttackDistMultiplier"] = 1.2,
		["ArtilleryAttackDistError"] = { 50, 125 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -2.0, 1.0 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		["TorpedoPredict"] = { 6.0, 8.0 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 150.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["TorpedoObservation"] = { 1.0, 3.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["TorpedoObservationSubAddon"] = { 3.0 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["SubAttackDistMultiplier"] = 1.1,
		["ArtilleryAttackDistError"] = { 30, 75 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -2.0, 1.0 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		["TorpedoPredict"] = { 8.0, 10.0 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 150.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["TorpedoObservation"] = { 0.5, 2.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["TorpedoObservationSubAddon"] = { 1.5 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["SubAttackDistMultiplier"] = 1,
		["ArtilleryAttackDistError"] = { 20, 40 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -1.5, 1.0 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --MPVeteran
	["Elite"] =
	{
		["TorpedoPredict"] = { 20.0, 22.0 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 150.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["TorpedoObservation"] = { 0.0, 1.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["SubAttackDistMultiplier"] = 1.0,
		["TorpedoObservationSubAddon"] = { 0.0 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["ArtilleryAttackDistError"] = { 0, 10 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -0.1, 0.1 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		["TorpedoPredict"] = { 4.0, 5.0 },  -- random ennyi masodperccel a becsapodas elott veszi eszre a torpedot, s kezdi kikerulni
		["TorpedoPredictReferenceLength"] = 150.0,  -- egy referencia hajo hossz, az ilyen hosszu hajokra igaz a fenti TorpedoPredict. Ha egy hajo ennel hosszabb, akkor a hosszaval aranyosan meg lesz novelve a TorpedoPredict erteke.
		["SubAttackDistMultiplier"] = 1.5,
		["TorpedoObservation"] = { 3.5, 5.0 },  -- csak a random ennyi ideje mar letezo torpedot veszi figyelembe kikeruleskor
		["TorpedoObservationSubAddon"] = { 1.0 },  -- a tengeralattjaroval viz alatt kilott torpedoknal az elozo ertekhez meg ennyi hozzaadodik
		["ArtilleryAttackDistError"] = { 0, 0 },  -- ha artilleryvel tamad valakire, akkor az optimalis tamadasi tavolsagnal meg ennyivel kozelebb megy, hogy konnyebb celpont legyen annak, akit tamad
		["TorpedoSpdErr"] = { -0.0, 1.0 },  -- random ennyivel (meterpersec) elteveszti a torpedo valos sebesseget, mikor a kikerulest szamolja
	}, --Stun
}

Robots["PilotBot"] =
{
	["SPNormal"] =
	{
		-- torpedozas parameterek
		["TorpReleaseAlt"]         = 12,         -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 450,        -- M -- bator ledobasi tavolsag. ha nem talaljak el tamadas kozben, akkor innen probal oldani
		["TorpReleaseDistFar"]     = 650,        -- M -- gyava ledobasi tavolsag. ha eltalaljak tamdas kozben, akkor innen fog oldani
		["TorpReleaseDropCloserMul"] = 0.7,      -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 12, 22 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 10,         -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 16,         -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 10,         -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.9,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 350, 450 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 10,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 5,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 10,           -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["DiveBombMaxPowerCtrl"]       = 0.7,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 0.2,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.5,          -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 3.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 0.8,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 70.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.3,          -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.018,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.025,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 20,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 50,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 10,    -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.9,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 15,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 30,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 4,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 1.0,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.03, 0.05 },-- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.7,           -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 850,           -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 6,            -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 4.5, 3.0 },  -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 1.6, 0.7 },  -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- dogfight es strafe kozbeni raketazo parameterek
		["RocketCheckTime"] = { 1.0, 2.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 4.0,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(30),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 4,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.2,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.6), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 0.5,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.2,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1800, 1200, 800 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(10),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 4,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.2,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 0.8,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 3,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.15,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1000,     -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 250,      -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(20),  -- A -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 0.75,      -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 1300, 800, 600 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(2.5), -- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 1.5,      -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(0.75), -- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 1.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 1000,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 240,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(33), -- A -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 0.9,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight
		["DogfightFollowDist"]         = 300,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 18,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 2.5,       -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 1.0,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 15,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		-- kamikaze
		["KamikazeSectionDamageChance"] = 0.5,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.9,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 50.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 20.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 3.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 0.8, 1.1 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti			
	}, --SPNormal (ex-Beginner & ex-Normal otvozes)
	["SPVeteran"] =
	{
		-- torpedozasi tavolsagok
		["TorpReleaseAlt"]         = 10,       -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 480,      -- M -- bator ledobasi tavolsag
		["TorpReleaseDistFar"]     = 1000,      -- M -- gyava ledobasi tavolsag
		["TorpReleaseDropCloserMul"] = 0.7,      -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 5, 8 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 5,        -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 10,       -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 6 ,       -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.9,   -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 250, 300 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 25,            -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 4,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 3,            -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DiveBombMaxPowerCtrl"]       = 1.0,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 0.6,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.25,         -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 3.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 0.6,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 35.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.24,         -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.014,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.018,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 0.6,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 15,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 40,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 5,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.8,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 6,     -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 15,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 1,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 1.0,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.04, 0.02 },  -- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.5,             -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 850,             -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 6,               -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 5.5, 2.0 },    -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 1.4, 0.9 },    -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1200,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 260,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(40), -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 0.7,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 900, 700, 600 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(5.0),-- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 1.8,     -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(1.2),-- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 1.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 900,         -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 160,         -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(35),     -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 0.7,    -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight parameterek
		["DogfightFollowDist"]         = 250,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 30,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 1.4,     -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 1.4,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 14,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		["RocketCheckTime"] = { 2.0, 3.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 0.3,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 4.0,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 0.5,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 0.6,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1400, 1200, 800 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(8),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 0.6,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		-- kamikaze
		["KamikazeSectionDamageChance"] = 0.2,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.7,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 25.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 15.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 3.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 0.9, 1.1 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti
	}, --SPVeteran (ex-Expert kisebb valtoztatasokkal)
	["MPNormal"] =
	{
		-- torpedozasi tavolsagok
		["TorpReleaseAlt"]         = 10,       -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 800,      -- M -- bator ledobasi tavolsag
		["TorpReleaseDistFar"]     = 1200,      -- M -- gyava ledobasi tavolsag
		["TorpReleaseDropCloserMul"] = 0.7,      -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 5, 8 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 25,        -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 35,       -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 3,       -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.8,   -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 250, 300 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 25,            -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 0,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 7,            -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DiveBombMaxPowerCtrl"]       = 0.85,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 0.5,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.25,         -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 3.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 0.4,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 50.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.24,         -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.014,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.018,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 0.5,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 15,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 40,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 5,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.4,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 15,     -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 40,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 5,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 1.0,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.03, 0.01 },  -- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.5,             -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 900,             -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 5,               -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 5.5, 4.0 },    -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 1.4, 0.9 },    -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1200,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 260,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(40), -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 0.3,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 1500, 1200, 900 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(5.0),-- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 1.8,     -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(1),-- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 1.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 0.5,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 900,         -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 160,         -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(35),     -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 0.7,    -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 0.5,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight parameterek
		["DogfightFollowDist"]         = 250,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 30,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 1.4,     -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 1.4,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 14,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		-- rocket
		["RocketCheckTime"] = { 2.0, 3.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 0.5,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 4.0,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(9),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 0.75,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 0.9,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1300, 1100, 900 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 0.9,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.5), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		-- kamikaze
		["KamikazeSectionDamageChance"] = 0.5,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 0.5,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.5,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 0.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 1.0, 1.0 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti
	}, --MPNormal (ex-Expert, nagyjabol ugyanaz, mint az SPVeteran)
	["MPVeteran"] =
	{
		-- torpedozasi tavolsagok
		["TorpReleaseAlt"]         = 10,       -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 800,      -- M -- bator ledobasi tavolsag
		["TorpReleaseDistFar"]     = 1200,      -- M -- gyava ledobasi tavolsag
		["TorpReleaseDropCloserMul"] = 0.6,      -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 5, 8 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 3,        -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 5,       -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 2,       -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.5,   -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 250, 300 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 5,            -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 2,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 1,            -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DiveBombMaxPowerCtrl"]       = 1.0,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 0.8,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.1,         -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 3.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 0.8,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 20.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.20,         -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.012,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.016,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 0.8,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 8,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 18,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 4,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.4,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 0,     -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 10,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 1,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 0.5,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.02, 0.005 },  -- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.4,             -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 900,             -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 2,               -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 7.0, 5.0 },    -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 1.0, 0.5 },    -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1000,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 250,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(40), -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 0.8,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 1800, 1500, 1200 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(3.0),-- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 1.5,     -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(1.5),-- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 1.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 0.8,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 900,         -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 200,         -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(35),     -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 0.55,    -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 0.8,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight parameterek
		["DogfightFollowDist"]         = 250,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 35,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 1,     -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 1.6,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 10,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		-- kamikaze
		["KamikazeSectionDamageChance"] = 0.8,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.5,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 0.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 1.0, 1.0 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti
		-- rocket
		["RocketCheckTime"] = { 2.0, 3.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 0.5,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 4.0,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(6),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1600, 1300, 1000 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.75), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1500,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(1.75), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
	}, --MPVeteran
	["Elite"] =
	{
		-- torpedozasi tavolsagok
		["TorpReleaseAlt"]         = 5,       -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 800,      -- M -- bator ledobasi tavolsag
		["TorpReleaseDistFar"]     = 1200,      -- M -- gyava ledobasi tavolsag
		["TorpReleaseDropCloserMul"] = 0.5,    -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 5, 8 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 0,        -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 0,        -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 1,        -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.25,   -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 250, 300 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 0,            -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 0,            -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 0,            -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["DiveBombMaxPowerCtrl"]       = 1.0,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 1.0,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 0.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 0.5,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 0.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.0,          -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.0,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.0,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 0.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 1.0,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 0,       -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 0,      -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 5,       -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.7,  -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 0,     -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 0,     -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 2,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 0.4,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.005, 0.0 },-- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.4,          -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 950,          -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 0,            -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 10.0, 8.0 },  -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 0.1, 0.0 },  -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1500,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 250,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(40), -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 0.5,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 2000, 1700, 1400 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(1.5),-- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 1.5,     -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(1.5),-- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 1.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 1.0,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 900,         -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 200,         -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(35),     -- M -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 0.5,    -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 1.0,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight parameterek
		["DogfightFollowDist"]         = 250,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 40,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 1,       -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 1.8,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 10,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		-- rocket
		["RocketCheckTime"] = { 2.0, 3.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1500,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(3),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1800,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(2),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1800, 1600, 1400 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(2),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 1.0,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1200,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(4),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 1,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.3,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(2.0), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		-- kamikaze
		["KamikazeSectionDamageChance"] = 1.0,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 0.5,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 1.0,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.5,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 0.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 1.0, 1.0 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti
	}, --Elite (ex-Ultimate)
	["Stun"] =
	{
		-- torpedozas parameterek
		["TorpReleaseAlt"]         = 12,         -- M -- ilyen magasrol dobja a torpedot
		["TorpReleaseDistNear"]    = 350,        -- M -- bator ledobasi tavolsag. ha nem talaljak el tamadas kozben, akkor innen probal oldani
		["TorpReleaseDistFar"]     = 600,        -- M -- gyava ledobasi tavolsag. ha eltalaljak tamdas kozben, akkor innen fog oldani
		["TorpReleaseDropCloserMul"] = 0.7,      -- F -- a torpedo ledobasi tavolsag arra az esetre vonatkozik, ha oldalba kapjuk a celpontot. ha szembol/hatulrol akarjuk megtorpedozni, akkor a torpedo oldasi tavolsag az ennyiszeresere csokken.
		["TorpFlikFlakTime"]       = { 20, 30 }, -- S -- a ketto kozotti idonkent beszur egy flik-flak manovert menekules kozben, hogy nehezebben talaljak el.
		["TorpTargetHError"]       = 200,         -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["TorpTargetVError"]       = 250,         -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["TorpCalcTargetPosError"] = 15,         -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["TorpTargetPointSelectPrec"] = 0.1,     -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["TorpThrowMul"]              = 1.0,     -- F -- a kilott torpedo szorasat megszorozza ezzel
		-- divebomb parameterek
		["DiveBombReleaseAlt"]         = { 350, 450 }, -- M -- regi tipusu, leboritos bumbazasnal a bomba oldasi magassag valahol a ketto kozott
		["DiveBombNewReleaseMul"]      = 0.6,          -- F -- ha nem leboritott manoverrel bombaz, csak siman rarepulve, akkor a fenti ReleaseAlt erteket ennyivel megszorozva hasznalja
		["DiveBombTargetHError"]       = 100,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DiveBombTargetVError"]       = 150,           -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DiveBombCalcTargetPosError"] = 17,           -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda kuldi a torpedot
		["DiveBombMaxPowerCtrl"]       = 0.6,          -- F -- ennyire huzza a gazkart, ha a celra tart
		["DiveBombMinPowerCtrl"]       = 0.1,          -- F -- ennyire huzza a gazkart, ha celoz
		["DiveBombMaxBrakeCtrl"]       = 0.5,          -- F -- ennyire huzza a feket, ha celoz
		["DiveBombMinBrakeCtrl"]       = 0.0,          -- F -- ennyire huzza a feket, ha a celra tart
		["DiveBombAimPitchRatio"]      = 3.0,          -- F -- a pitch kontroltol ennyire fugg, hogy mennyire celoz
		["DiveBombTargetPointSelectPrec"] = 1.0,       -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DiveBombAimPrecDist"]        = 150.0,         -- F -- tavolrol ennyivel melle celoz, aztan kozeledve egyre pontosabban
		["DiveBombAimPrecMul"]         = 0.75,          -- F -- celzasi pontossag szorzo. minel kisebb, annal jobb
		["DiveBombAimPrecPullPlus"]    = 0.03,        -- F -- tavolsagtol fuggoen mennyire huzza a pitch-t, ha nem pontos a celzas
		["DiveBombAimPrecPullMinus"]   = 0.06,        -- F -- tavolsagtol fuggoen mennyire tolja a pitch-t, ha nem pontos a celzas
		["DiveBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		["DiveBombSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a bombaval egy szekciot celoz be
		["DiveBombEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["DiveBombMagazineWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["DiveBombFueltankWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- levelbomb parameterek
		["LevelBombTargetHError"]       = 100,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["LevelBombTargetVError"]       = 200,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["LevelBombCalcTargetPosError"] = 30,    -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["LevelBombTargetPointSelectPrec"] = 0.1,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["LevelBombThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- depthcharge parameterek
		["DepthChargeTargetHError"]       = 100,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengelyere merolegesen
		["DepthChargeTargetVError"]       = 100,    -- M -- az elvileg jo celponttol random ennyivel arrebb celoz, a celpont hossztengely menten
		["DepthChargeCalcTargetPosError"] = 20,     -- S -- a becsapodasig hatralevo becsult ido plusz random ennyi ido mulva ahol elvileg lesz a celpont, oda celoz
		["DepthChargeCancelTargetDist"]   = 200,   -- M -- ha ennel kozelebb volt a celpont, mikor eltunt a szemunk elol (lemerult), akkor meg megprobaljuk vakon ledobni a bombat 
		["DepthChargeTargetPointSelectPrec"] = 1.0,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["DepthChargeThrowMul"]           = 1.0,          -- F -- a kilott bomba szorasat megszorozza ezzel
		-- celzas parameterek geppityuzashoz
		["AimDistortAngle"]       = { 0.075, 0.05 },-- R -- e ket szogtartomany kozotti mertekben lo a celpont melle
		["AimDistortChangeSpeed"] = 0.8,           -- F -- ekkora sebesseggel valtozik, hogy hova lo
		["AimShootDistance"]      = 800,           -- M -- ilyen tavolsagbol kezd el tuzelni
		["AimDontShootArea"]      = 20,            -- M -- a celponton kijelolt pont ekkora sugaru kornyezetet megprobalja nem eltalalni. (nehogy veletlenul eltalalja szegeny jatekost)
		["AimShootTime"]          = { 3.0, 2.0 },  -- S -- ennyi ideig lo folyamatosan
		["AimShootDelayTime"]     = { 2.0, 1.0 },  -- S -- ennyi szunetet tart ket sorozat kozott
		["AimBulletThrowMul"]     = 1.0,           -- F -- ennyivel megszorzodik a fix gepagyuk altal kilott toltenyek szorasa
		-- dogfight es strafe kozbeni raketazo parameterek
		["RocketCheckTime"] = { 2.0, 3.0 },        -- S -- ennyi masodpercenkent dont arrol, hogy raketazzon-e vagy sem
		["Rocket_SmallPlane"] = 
		{
			["RocketChance"]  = 0.1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 4.0,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(30),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.6,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_LargePlane"] = 
		{
			["RocketChance"]  = 0.1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 3.5,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(10),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.6,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Ship"] = 
		{
			["RocketChance"]  = 0.1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = { 1000, 700, 500 }, -- M -- ennel kozelebb levo celpontra raketazik csak. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
			["AttackTime"]    = 8,      -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(10),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.6,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		["Rocket_Landfort"] = 
		{
			["RocketChance"]  = 0.1,      -- S -- minden egyes dontesnel ennyi az eselye, hogy ugy dont, hogy raketazik. 0.0 - 1.0 kozott.
			["AttackDist"]    = 1000,     -- M -- ennel kozelebb levo celpontra raketazik csak. meterben
			["AttackTime"]    = 6,        -- S -- csak akkor raketazik, ha a raketa ennyi masodperc alatt el tudja erni a celpontot
			["AttackAngle"]   = DEG(10),   -- A -- csak akkor raketazik, ha a celpont iranya a raketa iranyatol maximum ennyivel ter el
			["NumRockets"]    = 2,        -- I -- egy dontesnel maximum ennyi raketat lo ki
			["RocketDelay"]   = 0.6,      -- S -- ha tobb raketat is lohet egy dontesnel, akkor a raketak kilovese kozott legalabb ennyi ido el fog telni
			["HomingAngle"]   = DEG(0.2), -- S -- a raketa 1 masodperc alatt ennyi fokot kanyarodhat el a celpont fele, hogy tobb eselye legyen a talaltra
		},
		-- nagy raketazas parameterek
		["StrikeGoAwayDistance"]   = 1000,     -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrikeTooClose"]         = 350,      -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrikeAttackAngle"]      = DEG(20),  -- A -- ilyen szogben szeret lecsapni a celpontra
		["StrikeTargetPrec"]       = 1.0,      -- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrikeFireDist"]         = { 1100, 800, 500 }, -- M -- milyen messzirol kezdjen el rakettazni. 3 hajocsoport van: 1. BB,CV; 2. CA,CL,AK, 3. DD es landfort
		["StrikeFireAngle"]        = DEG(50), -- A -- akkor lo ki egy raketat, ha a celpont iranya a raketa roppalyajatol max ennyire ter el.
		["StrikeRepeatTime"]       = 2.5,      -- S -- ha tobb raketaja is van, akkor azokat ennyi idokozonkent lovi ki
		["StrikeHomingAngle"]      = DEG(0.0), -- A -- a raketa hokoveto, masodpercenkent maximum ennyi fokot fordul a cel fele
		["StrikeThrowMul"]         = 2.0,          -- F -- a kilott raketa szorasat megszorozza ezzel
		["StrikeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy ezzel a raketaval egy szekciot celoz be
		["StrikeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrikeMagazineWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrikeFueltankWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- strafe parameterek
		["StrafeGoAwayDistance"]   = 1000,    -- M -- ilyen messzire megy egy tamadas utan, innen fordul vissza uj tamadashoz
		["StrafeTooCloseDistance"] = 350,     -- M -- ha ilyen kozel er a celponthoz, akkorabbahagyja a tamadast, es elkezd tavolodni egy uj tamadashoz
		["StrafeAttackAngle"]      = DEG(33), -- A -- ilyen szogben szeret lecsapni a celpontra
		["StrafeTargetPointSelectPrec"] = 1.0,-- F -- ekkora szorassal valaszt tamadhato pontot a celponton, a kozepehez kepest. 0-1 kozott. 0-nal a kozepet valasztja ki mindig
		["StrafeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy geppityuval egy szekciot celoz be
		["StrafeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["StrafeMagazineWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["StrafeFueltankWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya
		-- dogfight
		["DogfightFollowDist"]         = 300,     -- M -- ilyen messzirol probalja kovetni
		["DogfightBoringTime"]         = 14,      -- S -- ennyi masodperc utan unja meg a kergetozest, ha kozben nem kerult lovo pozicioba
		["DogfightAvoidTime"]          = 3, 		  -- S -- ha mar tul kozel a cel, akkor ennyi masodpercig probalja kikerulni a celpontot
		["DogfightTurnAfterChance"]    = 0.5,     -- % -- ekkora valseggel fordul utana azonnal a celpontnak, miutan kikerulte
		["DogfightManeuverChangeTime"] = 20,      -- S -- ennyi masodpercenkent uj iranyba kezdenek mozogni manoverezeskor
		-- kamikaze
		["KamikazeSectionDamageChance"] = 0.0,         -- F -- ennyi az eselye, hogy egy szekciot celoz be
		["KamikazeEngineRoomWeight"] = 1.0,            -- F -- ha szekciot celoz, akkor az enginroom celzas sulya
		["KamikazeMagazineWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az magazine celzas sulya
		["KamikazeFueltankWeight"] = 0.1,              -- F -- ha szekciot celoz, akkor az fueltank celzas sulya			
		["KamikazeTargetPrecision"] = 0.5,             -- F -- ha nem szekciot celoz, akkor a celpont ekkora teruleten valaszt random celpontot. 0: a kozepet valasztja, 1: az egesz feluleten valaszt
		["KamikazeTargetHError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelye menten hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetVError"] = 0.0,               -- F -- a celzasra kivalasztott ponthoz a target hossztengelyere merolegesen hozzaad egy random hibatavolsagot, maximum ennyit
		["KamikazeTargetProjTimeError"] = 0.0,          -- S -- mikor megsaccolja, hogy hany mp mulva fog becsapodni, es akkor hol lesz a celpont, akkor random ennyi mp-et teved a saccolassal. Mozgo celpontoknal ez minel nagyobb, annal tobbet teved.
		["KamikazeManeuverPrecisionTimer"] = 2.5,      -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. ennyi masodpercenkent valtoztat a manoverezes pontossagan
		["KamikazeManeuverPrecisionMul"] = { 1.0, 1.0 }, -- F -- mikozben rarepul a celra, valtoztatja a manoverezes pontossagat, hogy mennyire kovesse le a botkormany mozgatasaval a celpont mozgasat. Mikor uj pontossagot valaszt, ebbol a tartomanybol valaszt. 1.0 eseten marad az eddigi pontossag, 1-nel nagyobb szam eseten annyival agresszivebben koveti a botkormany a celpont mozgasat, 1-nel kisebb ertek eseten kevesbe koveti
	}, --Stun
} --PilotBot