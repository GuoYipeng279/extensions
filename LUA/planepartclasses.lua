PlanePartClass={}

PlanePartClass["Torzsdarab"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_001.MMOD",
	"models/misc/repulogepdarabok_001.MMOD"
	),
	
	["TimeToLive"] = { 10, 15, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 5, 20, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(0), DEG(30), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 1, 2, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(100), DEG(200), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 9,
	["SmokeEfx"] = 140,
}

PlanePartClass["Szarnydarab"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_002.MMOD",
	"models/misc/repulogepdarabok_002.MMOD"
	),
	
	["TimeToLive"] = { 10, 15, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 50, 80, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(80), DEG(150), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 0.5, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(350), DEG(600), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 9,
	["SmokeEfx"] = 141,
}

PlanePartClass["Motorblokk"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_003.MMOD",
	"models/misc/repulogepdarabok_003.MMOD"
	),
	
	["TimeToLive"] = { 10, 15, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 5, 10, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(60), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 1, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(80), DEG(100), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(5), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 9,
	["SmokeEfx"] = 139,
}

PlanePartClass["Lemezdarab1"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_004.MMOD",
	"models/misc/repulogepdarabok_004.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 70, 120, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(90), DEG(180), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 0.5, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Futomu"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_005.MMOD",
	"models/misc/repulogepdarabok_005.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 10, 25, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(40), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 0.5, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Legcsavar"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_006.MMOD",
	"models/misc/repulogepdarabok_006.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 10, 55, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(80), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 0.5, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Kormanyfelulet1"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_007.MMOD",
	"models/misc/repulogepdarabok_007.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 10, 55, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(80), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 1, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Kormanyfelulet2"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_008.MMOD",
	"models/misc/repulogepdarabok_008.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 80, 110, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(120), DEG(180), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 1, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Vezersik"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_009.MMOD",
	"models/misc/repulogepdarabok_009.MMOD"
	),
	
	["TimeToLive"] = { 10, 15, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 20, 60, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(80), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 1, 2, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.5,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Lemezdarab2"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_010.MMOD",
	"models/misc/repulogepdarabok_010.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 1, 2, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(20), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 1, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(80), DEG(100), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClass["Lemezdarab3"] =
{
	["Mesh"] = Platform(
	"models/misc/repulogepdarabok_011.MMOD",
	"models/misc/repulogepdarabok_011.MMOD"
	),
	
	["TimeToLive"] = { 6, 10, },  -- ennyi ideig fog elni ez a darab, majd elhalvanyul s eltunik
	["StartVelocityAdd"] = { 10, 55, },  -- ekkora nagysagu extra sebesseget kap a repulo sebessegehez kepest
	["StartVelocityDirAdd"] = { DEG(10), DEG(80), }, -- a repulo iranyahoz kepest ekkora szogelteressel fog elindulni
	["AirDrag"] = { 0, 1, },  -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"] = 1.2,  -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat ra
	["RotationSpeed"] = { DEG(150), DEG(300), },  -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"] = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"] = 52,
	["SmokeEfx"] = 134,
}

PlanePartClassWeights = {
	["Motorblokk"]			= { 1, 2, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Legcsavar"]			= { 1, 1, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Futomu"]			= { 1, 1, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Szarnydarab"]			= { 2, 2, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Torzsdarab"]			= { 1, 1, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Kormanyfelulet1"] 		= { 2, 2, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Kormanyfelulet2"] 		= { 2, 2, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Vezersik"]			= { 2, 2, 1 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Lemezdarab1"]			= { 2, 2, 0 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Lemezdarab2"]			= { 0, 0, 1 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
	["Lemezdarab3"]			= { 2, 2, 1 },  -- elso a kis gepekre, masidik a nagyokra, harmadik a felrobbanas elott kihullo darabokra
}

PlanePartClassMaxNum = {
	["Motorblokk"]			= { 1, 2 },  -- elso a kis gepekre, masidik a nagyokra
	["Legcsavar"]			= { 1, 2 },  -- elso a kis gepekre, masidik a nagyokra
	["Futomu"]			= { 1, 1 },  -- elso a kis gepekre, masidik a nagyokra
	["Szarnydarab"]			= { 2, 2 },  -- elso a kis gepekre, masidik a nagyokra
	["Torzsdarab"]			= { 1, 1 },  -- elso a kis gepekre, masidik a nagyokra
	["Kormanyfelulet1"]             = { 2, 2 },  -- elso a kis gepekre, masidik a nagyokra
	["Kormanyfelulet2"]             = { 2, 2 },  -- elso a kis gepekre, masidik a nagyokra
	["Vezersik"]			= { 1, 1 },  -- elso a kis gepekre, masidik a nagyokra
	["Lemezdarab1"]			= { 3, 4 },  -- elso a kis gepekre, masidik a nagyokra
	["Lemezdarab2"]			= { 3, 4 },  -- elso a kis gepekre, masidik a nagyokra
	["Lemezdarab3"]			= { 3, 4 },  -- elso a kis gepekre, masidik a nagyokra
}

SmallPlanePartCount = { 6, 8, }   -- kis gepekbol ennyi darab fog kiesni
LargePlanePartCount = { 6, 10, }  -- nagy gepekbol ennyi darab fog kiesni
PlanePartBornRange  = { 2.0, 5.0, } -- kis, illetve nagy gepeknel az egyes darabok a kozepponttol szamolva ennyi meteres sugaru korben szulethetnek
SinglePartBornTime  = { 1.5, 3.0, } -- amig csak ego motorral zuhan, addig ennyi idokozonkent kihullik belole egy darab

MaxExplosionNum = { 10, 16, } -- egyszerre maximum mennyi felrobbano repulot szeretnenk a palyan. az elso ertekig nyugodtan robbangatnak, ha annal tobb van, akkor fokozatosan egyre kisebb valoszinuseggel szerretnek felrobbanva meghalni.

ExplosionChance = { 0.4, 0.3, } -- mekkora az esely, hogy egy lelott gep felrobbanva hal meg. elso ertek a jatekos altal lelott gepekre vonatkozik, masik a gep altal lelott gepekre
ExplosionChanceDistRange = { 600, 1500, } -- a kameratol mert tavolsaga alapjan modositjuk a felrobbanas valoszinuseget. az elso erteknel kozelebb maximalis az esely szorozja, a masodiknal messzebb minimalis a szorzo, a ketto kozott meg linearisan valtozik
ExplosionChanceDistMul =   { 1.2, 0.5, }  -- ennyivel szorzodik meg a felrobbanas eselye, az elobbi tavolsagtol fuggoen
SpinVSPowerLostChance = 0.6  -- ha nem robban, akkor mennyire szeressen porogve zuhanni. ha nem porogve zuhan, akkor csak siman leall a motor
EngineFireChance = 0.06  -- ha egy motor bekrepal, akkor ekkora valseggel fog ki is gyulladni
DeadEngineFireDelay = { 3.0, 5.0, } -- ha egy gep meghal, akkor a halaltol szamitva random ennyi masodperc mulva kigyullad legalabb egy motorja

ExplosionExplosionDelay = { 0.6, 1.8, } -- 'Explosion' meghalas eseten a halaltol szamitva hany masodperc mulva robbanjon fel tenylegesen
SpinExplosionDelay = { 4, 12, } -- 'Spinning' meghalas eseten a halaltol szamitva hany masodperc mulva robbanjon fel tenylegesen
PowerLostExplosionDelay = { 4, 8, } -- 'PowerLost' meghalas eseten a halaltol szamitva hany masodperc mulva robbanjon fel tenylegesen

