-----------------------------------------------------------------------------
--
-- Abstract:
-- init script for all lua states
--
--
-----------------------------------------------------------------------------

-- Our error handling function
--
function _ERRORMESSAGE(message)
	log(message)
end

CALLED_FROM_MIDWAY = true

-----------------------------------------------------------------------------
-- basics
--

ORIGO = {["x"]=0,["y"]=0,["z"]=0}

COL_BLACK  = {[1]=0.0,[2]=0.0,[3]=0.0,[4]=1.0,}
COL_WHITE  = {[1]=1.0,[2]=1.0,[3]=1.0,[4]=1.0,}
COL_GRAY   = {[1]=0.5,[2]=0.5,[3]=0.5,[4]=1.0,}
COL_RED      = {[1]=1.0,[2]=0.0,[3]=0.0,[4]=1.0,}
COL_GREEN = {[1]=0.0,[2]=1.0,[3]=0.0,[4]=1.0,}
COL_BLUE    = {[1]=0.0,[2]=0.0,[3]=1.0,[4]=1.0,}
COL_BROWN   = {[1]=1.0,[2]=0.5,[3]=0.0,[4]=1.0,}

-- Briefing colours
BRI_COL_RED			= { 0.73, 0.56, 0.39, 1.0 }
BRI_COL_RED_OUTLINE		= { 0.46, 0.15, 0.13, 1.0 }
 
BRI_COL_BLUE			= { 0.42, 0.55, 0.58, 1.0 }
BRI_COL_BLUE_OUTLINE		= { 0.22, 0.30, 0.38, 1.0 }

BRI_COL_GOLD			= { 0.83, 0.69, 0.21, 1.0 }

BRI_COL_BLACK			= { 0.0, 0.0, 0.0, 1.0 }
BRI_COL_WHITE			= { 1.0, 1.0, 1.0, 1.0 }

BRI_COL_RED_ARROW		= {0.49, 0.07, 0.04, 0.5 }
BRI_COL_BLUE_ARROW		= {0.07, 0.17, 0.35, 0.5 }

-----------------------------------------------------------------------------
--
-- Camos
--

CamoColor_None  = 1
CamoColor_Blue  = 2
CamoColor_Brown = 3
CamoColor_Grey  = 4
CamoColor_Green = 5


-----------------------------------------------------------------------------
--
-- Nations (Races)
--
JAPANESE      = 1 
USA           = 2 
GREAT_BRITAIN = 3 
GERMAN        = 4 
DUTCH         = 5
AUSTRALIAN    = 6

-----------------------------------------------------------------------------
--
-- Sides (parties)
--
PARTY_ALLIED = 0
PARTY_JAPANESE = 1
PARTY_NEUTRAL = 2


-----------------------------------------------------------------------------
--
-- Players
--
PLAYER_1	= 0
PLAYER_2	= 1
PLAYER_3	= 2
PLAYER_4	= 3
PLAYER_5	= 4
PLAYER_6	= 5
PLAYER_7	= 6
PLAYER_8	= 7
PLAYER_AI	= 8
PLAYER_ANY	= 9


-----------------------------------------------------------------------------
--
-- Roles
--
EROLE_CAPTAIN			= 1
EROLE_PILOT				= 2
EROLE_AA_MACHINEGUN		= 3
EROLE_AA_FLAK			= 4
EROLE_ARTILLERY			= 5
EROLE_TORPEDO			= 6
EROLE_BOMB				= 7
EROLE_DEPTHCHARGE		= 8
EROLE_SPECIAL			= 9
EROLE_NUM				= 9

EROLF_CAPTAIN			= 1
EROLF_PILOT				= 2
EROLF_AA_MACHINEGUN		= 4
EROLF_AA_FLAK			= 8
EROLF_ARTILLERY			= 16
EROLF_TORPEDO			= 32
EROLF_BOMB				= 64
EROLF_DEPTHCHARGE		= 128
EROLF_SPECIAL			= 256
EROLF_ALL				= EROLF_CAPTAIN + EROLF_PILOT + EROLF_AA_MACHINEGUN + EROLF_AA_FLAK + EROLF_ARTILLERY + EROLF_TORPEDO + EROLF_BOMB + EROLF_DEPTHCHARGE + EROLF_SPECIAL
EROLF_ALLBUTCAPTAIN		= EROLF_PILOT + EROLF_AA_MACHINEGUN + EROLF_AA_FLAK + EROLF_ARTILLERY + EROLF_TORPEDO + EROLF_BOMB + EROLF_DEPTHCHARGE + EROLF_SPECIAL

-----------------------------------------------------------------------------
-- Messages                                                                             Params
MSG_KILLED           = 0 -- az entity meghott.                                           N/A
MSG_WINGLAUNCHED     = 1 -- wing felszalt.                                               "Wing" = wing GROUP!!! IDje
MSG_DEFENDERLAUNCHED = 2 -- elso defender squadron felszalt.                             "Defender" = wing GROUP!!! IDje
MSG_NEWLEADER        = 3 -- uj leadere van a groupnak (a regi elpatklt).                 N/A
MSG_CHEAT            = 4 -- Cheat key pressed                                            "F" = 1..10 "Shift"=0/1 "Ctrl"=0/1 "Alt"=0/1

-----------------------------------------------------------------------------
-- Damage catrgories. If you alter anything here you MUST make
-- the same changes on the C++ side too (NwiBaseEntity.h)!!
--
             -- PLANE
DAM_LWING			= 0
DAM_RWING			= 1
DAM_FUSELAGE		= 2
DAM_ENGINE			= 3

             -- SHIP
DAM_UNDERWATER		= 4
DAM_ENGINEROOM		= 5 -- USE THIS! NOT 'ENGINE'!!!!
DAM_FUELTANK		= 6
DAM_STEERING		= 7
DAM_MAGAZINE		= 8
DAM_BODY			= 9 -- ha csak egy kategoria van, ezt hasznald
DAM_RUNWAY			= 11 -- kifutopalya
DAM_HANGAR			= 12 -- anyahajo belso hangara

             -- SIMPLE STRUCTURES
-- ha csak egy kategoria van, ezt hasznald
DAM_BODY			= 9

             -- dontcare
-- talaj es egyeb lenyegtelen dolgok - uzenet sem jon rola!
DAM_NONE			= 10
-----------------------------------------------------------------------------
-- Plane commands (mondjuk mashol is ezek vannak)

COMMAND_HOLDPOS   = "moveto"
COMMAND_FOLLOW    = "follow"
COMMAND_TORPEDO   = "torpedo"
COMMAND_STRAFE    = "strafe"
COMMAND_DOGFIGHT  = "dogfight"
COMMAND_DIVEBOMB  = "divebomb"
COMMAND_LEVELBOMB = "levelbomb"
COMMAND_LAND      = "land"

PCB_MOVE             = 0
PCB_TARGET           = 1
PCB_JOIN_LEAVE       = 2
PCB_CHANGE_FORMATION = 3
PCB_ORDERS           = 4
PCB_REPAIR           = 5
PCB_RETREAT          = 6

PCF_MOVE =               1 -- move command
PCF_TARGET =             2 -- targetolas
PCF_JOIN_LEAVE =         4 -- formacioba ki/belepes (join/leave/disband)
PCF_CHANGE_FORMATION =   8 -- formacio atrendezes
PCF_ORDERS =            16 -- orders menu allitgatas
PCF_REPAIR =            32 -- repair screen behozas (hajok)
PCF_RETREAT =           64 -- visszavonulas parancs (repulok)
PCF_ATTACK =           128 -- visszavonulas parancs (repulok)
PCF_REGROUP =          256 -- visszavonulas parancs (repulok)

PCF_NONE =               0
PCF_ALL =              511

-----------------------------------------------------------------------------
-- Plane parancsfazisok (mashol nem ezek vannak, illetve ezek nincsenek)

PHASE_PREPARE = 2 -- keszulodik raja, pl. epp felszall
PHASE_ROUTE   = 3 -- odamegy
PHASE_EXECUTE = 4 -- csinalja
PHASE_IDLE    = 5 -- abbahagyta

-----------------------------------------------------------------------------
-- Fire stances

STANCE_HOLD_FIRE   = 0
STANCE_GUARD       = 1
STANCE_FREE_FIRE   = 1
STANCE_FREE_ATTACK = 2
STANCE_MOVE_ONLY   = 3

-----------------------------------------------------------------------------
-- Ammo on plane

AMMO_NONE        = 0
AMMO_BOMB        = 1
AMMO_TORPEDO     = 2
AMMO_DEPTHCHARGE = 3

-----------------------------------------------------------------------------
-- gears

GEARS_AUTO = 0
GEARS_DOWN = 1
GEARS_UP   = 2

-----------------------------------------------------------------------------
-- Path kovetes

PATH_FM_SIMPLE   = 1 -- szepen elmegy a vegeig, aztan megall
PATH_FM_PINGPONG = 2 -- oda-vissza megy, mig meg nem unja (soha nem unja meg)
PATH_FM_CIRCLE   = 3 -- megy korbe-korbe, sokaig

PATH_SM_JOIN            = 5 -- kezdje a legkozelebbi pontnal
PATH_SM_JOIN_FORWARD    = 5 -- ua mint elozo
PATH_SM_BEGIN           = 6 -- kezdje a path elejen
PATH_SM_JOIN_RANDOM_DIR = 7 -- kezdje a legkozelebbi pontnal akarmerre
PATH_SM_JOIN_BACKWARDS  = 8 -- kezdje a legkozelebbi pontnal, csak visszafele

-----------------------------------------------------------------------------
-- PilotSetTarget harmadik parametere lehet

ATTACKTYPE_ANY             = 1 -- default: akarhogy de tamadjuk
ATTACKTYPE_GUN_ONLY        = 2 -- csak gepagyuval lojunk meg ha van bomba is
ATTACKTYPE_BOMB_OR_TORPEDO = 3 -- ... or depthcharge :) szoval minden 
                               -- eldobalhatoval tamadunk, aztan visszavonulunk

-----------------------------------------------------------------------------
-- AirBase slot state-ek 
-- scriptbol ezek kozul a SLOT_ASSIGNED es a SLOT_KILLED allapotu allithato at

SLOT_ASSIGNED = 1  -- semmi
SLOT_READY    = 2  -- minnya indulnak
SLOT_SENT     = 3  -- el vannak kuldve
SLOT_RETURN   = 4  -- mindenki mennyen haza
SLOT_KILLED   = 5  -- ua mint assigned, csak ez meghalas utan van
SLOT_FAKEAIR  = 6  -- levegoben begeneralt repulokre vonatkozik, jatekos
                   -- szemszogebol ez tulkepp olyan mint a SLOT_SENT

-----------------------------------------------------------------------------
-- Crew levelek

CREW_ROOKIE = 0
CREW_REGULAR = 1
CREW_VETERAN = 2
CREW_ELITE = 3

-----------------------------------------------------------------------------
-- Skill levelek

SKILL_STUN		= 0
SKILL_SPNORMAL	= 1
SKILL_SPVETERAN	= 2
SKILL_MPNORMAL	= 3
SKILL_MPVETERAN	= 4
SKILL_ELITE		= 5

-----------------------------------------------------------------------------
-- Spawn

-- Type
ST_ABSANGLE = 0
ST_RELANGLE = 1

-----------------------------------------------------------------------------
-- Difficulty levels
--
DIFF_ROOKIE	= 0
DIFF_REGULAR	= 1
DIFF_VETERAN	= 2
DIFF_ELITE	= 3

-----------------------------------------------------------------------------
-- Dynamic music levels
--
MUSIC_DEFAULT	= 0
MUSIC_TENSION	= 1
MUSIC_ACTION	= 2
MUSIC_VICTORY	= 3
MUSIC_DEFEAT	= 4
MUSIC_CALM		= 5
MUSIC_CUSTOM1	= 6
MUSIC_CUSTOM2	= 7
MUSIC_CUSTOM3	= 8

-----------------------------------------------------------------------------
-- Scoring multipliers for objectives
--

OBJ_PRIMARY_MULTIPLIER = 1.25
OBJ_SECONDARY_MULTIPLIER = 1
OBJ_HIDDEN_MULTIPLIER = 1.5

function OBJ_DIFF()
	if GetDifficulty() == 2 then
		return 1.2
	elseif GetDifficulty() == 1 then
		return 1
	elseif GetDifficulty() == 0 then
		return 0.8
	end
end

OBJ_PRIMARY_SCORE = 5000
OBJ_SECONDARY_SCORE = 3000
OBJ_HIDDEN_SCORE = 2000

-----------------------------------------------------------------------------
-- Medals
--
MEDAL_BRONZE 	= 1
MEDAL_SILVER 	= 2
MEDAL_GOLD 	= 3

-----------------------------------------------------------------------------
-- Character Defines
--

SPACE = " "

-----------------------------------------------------------------------------
-- Button Icons
--

ICON_A = "¢"
ICON_B = "£"
ICON_X = "¥"
ICON_Y = "§"

ICON_DPAD_LEFT = "¤"
ICON_DPAD_DOWN = "¦"
ICON_DPAD_RIGHT = "¨"
ICON_DPAD_UP = "ª"
ICON_DPAD_ARROWS = "¬"
ICON_DPAD_UPDOWN = "­"
ICON_DPAD_LEFTRIGHT = "¯"

ICON_BACK = "°"
ICON_START = "±"
ICON_STICK_RIGHT = "²"
ICON_STICK_LEFT = "³"
ICON_TRIGGER_LEFT = "´"
ICON_TRIGGER_RIGHT = "¶"
ICON_BUMPER_LEFT = "·"
ICON_BUMPER_RIGHT = "¸"
ICON_STICK_RIGHT_BUTTON = "¹"
ICON_STICK_RIGHT_SIDE = "º"
ICON_STICK_LEFT_BUTTON = "¼"
ICON_STICK_LEFT_SIDE = "½"
ICON_DPAD = "¾"

ICON_MACHINEGUN = "€"
ICON_ARMOR = ""
ICON_ROCKET = "‚"
ICON_TORPEDO = "ƒ"
ICON_BOMB = "„"
ICON_DC = "…"
ICON_SPEED = "†"
ICON_TURNING = "‡"
ICON_ARTILLERY = "ˆ"
ICON_AAFLAK = "‰"

ICON_FAILURE_PERISCOPE = ""
ICON_FAILURE_DEVICE = "‘"
ICON_FAILURE_FIRE = "’"
ICON_FAILURE_ENGINE = "“"
ICON_FAILURE_WATER = "”"
ICON_RELOAD_AND_RANGE = "•"
-----------------------------------------------------------------------------
-- Global attacker table
--
AttackerTable = {}

-----------------------------------------------------------------------------
-- Global player cheat parameters
--
PlayerCheat=
{
	["DamageOnPlayer_Multiplier"] = 0.5,
}

-----------------------------------------------------------------------------
-- Global this table
--

thisTable = {}
--this = nil

-- global functions to init the 'this' table

--[[
	-- default vehicle init command
	function luaInitVehicleThisTable()
		this.Class = VehicleClass[this.ClassID]
		if this.Class == nil then
-- RELEASE_LOGOFF  			Log("No class-table for ",this.Name)
		else
-- RELEASE_LOGOFF  			Log("Class-table for ",this.Name)
		end
	end
--]]


-- this tabla ertekei

-- INIT TIME
-- Jarmunel
-- 		this.ClassID - class ID (string)
-- 		this.Class - a VehicleClass[this.ClassID] - a script irja bele

-- kotelezo parameterek:
-- ["Name"]

-----------------------------------------------------------------------------
-- VehicleClass table & helper functions
--

VehicleClass = {}
-- DEG -> RAD
function DEG(a)
	return a * math.pi / 180;
end

-- KMH -> m/s
function KMH(a)
	return a/3.6;
end

-- MPH -> m/s
function MPH(a)
	return a*0.446944;
end

-- kts -> m/s
function KTS(a)
	return a*0.51444;
end

-- tabla teljes lemasolasa (deep copy)

function copy_table(t)        -- return a copy of the table t
	local new = {}             -- create a new table
	local i, v = next(t, nil)  -- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then
			v=copy_table(v) 
		end 
		new[i] = v
		i, v = next(t, i)        -- get next index
	end
	return new
end

-- tablak osszefuzese

function merge_tables(...)
	local result = { }
	local arg_index = 1
	while arg_index <= arg.n do
		local cur_arg = arg[arg_index]
		local i, v = next(cur_arg, nil)
		while i do
			result[i] = v
			i, v = next(cur_arg, i)
		end
		arg_index = arg_index + 1
	end
	return result
end

-----------------------------------------------------------------------------
-- Global recon table
--

recon = {}

--Log("Global init done done.") -- ez a szar MINDIG lefut???
