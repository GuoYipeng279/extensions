ShipPartClass={}

DeviceExplosionChanceDistRange = { 2000, 3500, } -- a kameratol mert tavolsaga alapjan modositjuk a felrobbanas valoszinuseget. az elso erteknel kozelebb maximalis az esely szorozja, a masodiknal messzebb minimalis a szorzo, a ketto kozott meg linearisan valtozik
DeviceExplosionChanceDistMul   = { 1.0, 0.0, }   -- ennyivel szorzodik meg a felrobbanas eselye, az elobbi tavolsagtol fuggoen

ShipPartClass["lemez01"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_001.MMOD",
	"models/misc/hajodarabok_001.MMOD"
	),
	
	["StartVelocity"]      = { 24, 39, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(75), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 2, 4, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(120), DEG(200), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipPartClass["hengeres01"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_002.MMOD",
	"models/misc/hajodarabok_002.MMOD"
	),
	
	["StartVelocity"]      = { 40, 50, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(75), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 2, 4, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(120), DEG(200), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipPartClass["lemez02"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_003.MMOD",
	"models/misc/hajodarabok_003.MMOD"
	),
	
	["StartVelocity"]      = { 20, 30, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(75), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 3, 5, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(120), DEG(200), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipPartClass["lemez03"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_004.MMOD",
	"models/misc/hajodarabok_004.MMOD"
	),
	
	["StartVelocity"]      = { 30, 40, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(55), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 2, 3, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(60), DEG(120), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipPartClass["lemezgorbe01"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_005.MMOD",
	"models/misc/hajodarabok_005.MMOD"
	),
	
	["StartVelocity"]      = { 40, 40, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(55), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 4, 5, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(60), DEG(120), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipPartClass["lemezgorbe02"] =
{
	["Mesh"] = Platform(
	"models/misc/hajodarabok_006.MMOD",
	"models/misc/hajodarabok_006.MMOD"
	),
	
	["StartVelocity"]      = { 30, 40, },             -- ekkora sebesseggel repul ki ez a darabka
	["StartVelocityAngle"] = { DEG(30), DEG(55), },   -- a vizszintestol ennyivel nagyobb szogben lovodik ki a darabka, a kilovodes iranya barmi lehet
	["AirDrag"]            = { 3, 5, },             -- legellenallas: masodpercenkent ennyivel csokken a sebessege
	["GravityMul"]         = 2,                     -- exrta gravitacio szorzo. a sima gravitacio ennyiszerese hat a darabkara
	["RotationSpeed"]      = { DEG(60), DEG(120), }, -- masodpercenkent ekkora szogsebesseggel fog forogni a darab
	["RotationDecline"]    = { DEG(0), DEG(15), },    -- masodpercenkent ekkora szogsebesseggel lassul a forgasa
	
	["WaterSplashEfx"]     = 52,   -- vizbecsapodas effekt
--	["SmokeEfx"]           = 134,      -- ilyen fusteffektet huz maga utan
}

ShipExplosion={}

ShipExplosion["0"] = 
{
	["PartsNum"] = { 3, 5, },      -- ennyi darabka fog ilyen robbanas eseten kirepulni
	
	["Part0"]	= 
	{
		["Class"]  = "lemez01",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},
	["Part1"]	= 
	{
		["Class"]  = "lemez02",  -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},
}

ShipExplosion["1"] = 
{
	["PartsNum"] = { 7, 10, },      -- ennyi darabka fog ilyen robbanas eseten kirepulni
	
	["Part0"]	= 
	{
		["Class"]  = "lemez01",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},
	["Part1"]	= 
	{
		["Class"]  = "hengeres01",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},
	["Part2"]	= 
	{
		["Class"]  = "lemezgorbe01",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},
	["Part3"]	= 
	{
		["Class"]  = "lemezgorbe02",   -- ebbol a fajta darabkabol
		["Weight"] = 2,            -- ekkora sullyal lesz a robbanasban
	},
	["Part4"]	= 
	{
		["Class"]  = "lemez02",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},	
	["Part5"]	= 
	{
		["Class"]  = "lemez03",   -- ebbol a fajta darabkabol
		["Weight"] = 1,            -- ekkora sullyal lesz a robbanasban
	},		
}
