-------------------------------------------------
--SwapStick
-------------------------------------------------

SWAPSTICK = true

function SwapStick(input)
	if SWAPSTICK then
		if input == AXIS_STICK_LEFT_X then
			return AXIS_STICK_RIGHT_X
		elseif input == AXIS_STICK_RIGHT_X then
			return AXIS_STICK_LEFT_X
		elseif input == AXIS_STICK_LEFT_Y then
			return AXIS_STICK_RIGHT_Y
		elseif input == AXIS_STICK_RIGHT_Y then
			return AXIS_STICK_LEFT_Y
		elseif input == BUTTON_STICK_LEFT then
			return BUTTON_STICK_RIGHT
		elseif input == BUTTON_STICK_RIGHT then
			return BUTTON_STICK_LEFT
		end
	else
		return input
	end
end

-------------------------------------------------
--INPUT GROUP-ok
-------------------------------------------------

--ezeknek osszhangban kell lenni az input.h-beli deklaraciokkal (nem szabad a kod valtoztatasa nelkul valtoztatni rajtuk)
--ne legyenek hezagok

IG_ALWAYS = -1

IG_MAINMENU = 1 -- = IG_FIRST -- main menu

IG_FREECAMERA = 2 -- free camera
IG_MOVIECAMERA = 3 -- filmszeru kamera
IG_GENERALCAMERA = 4 -- kamera mozgatas
IG_BOMBCAMERA = 5 -- bomba nezet
IG_SHIP = 6 -- hajoskapitany
IG_SUBMARINE = 7 -- tengeralattjaro
IG_AIRBASE = 8 -- repmester a legibazison
IG_BOMBER = 9 -- bombazo kulso nezet
IG_PLANE = 10 -- repcsi kulso es belso nezet
IG_GUNCONTROL = 11 -- hajo, plane squadron kulso nezetben osszes fegyver
IG_COMMAND = 12 -- command
IG_ORDERS = 13 -- orders screen
IG_MAP = 14 -- map
IG_FORMATION = 15 -- formation menu
IG_FMV = 16 -- FMV
IG_UNITMENUUNIT = 17 -- selector
IG_ZOOMROLESWITCH = 18 -- zoom/roleswitch
IG_LIMBO = 19 -- limbo
IG_SIMPLEMENU = 20 -- altalanos menu
IG_GIVEUNIT = 21 -- give unit menu
IG_LAUNCHLANDING = 22 -- gabor bazzeg updateld a kommentet vagy legalabb torold ki :) repmester a legibazison
IG_PLANESPAWN = 23
IG_OVERLAYSHORTCUT = 24
IG_REPAIR = 25 -- ingame always


IG_GAMEMENU = 26 -- = IG_TORVENYENKIVULIEK_FIRST -- game menu
IG_PAUSE = 27 -- pause menu
IG_DIALOGBOX = 28 -- dialogbox
IG_INGAMEALWAYS = 29 -- ingame always

-------------------------------------------------
--INPUT kategoriak
-------------------------------------------------

--ezeknek osszhangban kell lenni az input.h-beli deklaraciokkal (nem szabad a kod valtoztatasa nelkul valtoztatni rajtuk)
--ne legyen sok hezag (hatekonysagi okokbol)

-- common
IC_PAUSE = 1

--FMV
IC_ENDMOVIEPLAY = 3

-- cheat
IC_CHEAT_MENU = 6
IC_CHEAT_QUIT = 7
IC_CHEAT_ENDSCENE = 8
IC_CHEAT_FAST = 9
IC_CHEAT_VERYFAST = 10
IC_CHEAT_PAUSESTEP = 11
IC_CHEAT_SLOW = 12
IC_CHEAT_NEXTPARTY = 13
IC_CHEAT_ALLOCLOG = 14
IC_CHEAT_KILL = 15
IC_CHEAT_LOOK = 16
IC_CHEAT_WIREOCEAN = 17
IC_CHEAT_AIDEBUG = 18
IC_CHEAT_RENDERGEOMMESH = 19
IC_CHEAT_ATTIS1 = 20
IC_CHEAT_ATTIS2 = 21
IC_CHEAT_UP = 22
IC_CHEAT_DOWN = 23
IC_CHEAT_LEFT = 24
IC_CHEAT_RIGHT = 25
IC_CHEAT_SELECT = 26
IC_CHEAT_BACK = 27
IC_CHEAT_NOFIRE = 28
IC_CHEAT_CAPTURE = 29 -- E3 capture frames
IC_CHEAT_SAVETEST = 30
IC_CHEAT_UNLOCKALL = 31
IC_CHEAT_PGUP = 32
IC_CHEAT_PGDOWN = 33

IC_CHEAT_F1 = 40
IC_CHEAT_F2 = 41
IC_CHEAT_F3 = 42
IC_CHEAT_F4 = 43
IC_CHEAT_F5 = 44
IC_CHEAT_F6 = 45
IC_CHEAT_F7 = 46
IC_CHEAT_F8 = 47
IC_CHEAT_F9 = 48
IC_CHEAT_F10 = 49
IC_CHEAT_F11 = 50
IC_CHEAT_F12 = 51
IC_CHEAT_SHIFT = 52
IC_CHEAT_CONTROL = 53
IC_CHEAT_ALT = 54

IC_CHEAT_FOV_DOWN = 59
IC_CHEAT_FOV_UP = 60

-- menu
IC_MENU_UP = 70
IC_MENU_DOWN = 71
IC_MENU_PGUP = 72
IC_MENU_PGDOWN = 73
IC_MENU_SELECT = 74
IC_MENU_BACK = 75
IC_MENU_LEFT = 76
IC_MENU_RIGHT = 77
IC_MENU_START = 78

IC_MENU_BUTTON_X = 79
IC_MENU_BUTTON_Y = 80
IC_MENU_BUMPER_LEFT = 81
IC_MENU_BUMPER_RIGHT = 82
IC_MENU_TRIGGER_LEFT = 83
IC_MENU_TRIGGER_RIGHT = 84
IC_MENU_MOUSECLICK = 85
IC_MENU_RESTARTSCENE = 86
IC_MENU_PLUS = 87
IC_MENU_MINUS = 88

-- free camera
IC_FREECAM_TOGGLE = 90
IC_FREECAM_FORWARD = 92
IC_FREECAM_STRAFELEFTRIGHT = 93
IC_FREECAM_STRAFEUPDOWN = 94
IC_FREECAM_TURNLEFTRIGHT = 95
IC_FREECAM_TURNUPDOWN = 96
IC_FREECAM_ACTUNIT = 97
IC_FREECAM_VERT_TO_ZERO = 98
IC_FREECAM_HORZVERT_TO_ZERO = 99
IC_FREECAM_SHOOT = 100
IC_FREECAM_GUNSWITCH = 101
IC_FREECAM_ROLL = 102

-- general camera
IC_GENCAM_H = 114
IC_GENCAM_V = 115
IC_GENCAM_ZOOM = 116
IC_GENCAM_RESET = 117

-- movie camera overview
IC_MOVCAM_TARGETEDMODE = 120
IC_MOVCAM_DECKMODE = 121
IC_MOVCAM_DROPCAMERA = 122
IC_MOVCAM_SELECTSECONDARYTARGET = 123
IC_MOVCAM_WALKAROUNDH = 124
IC_MOVCAM_WALKAROUNDV = 125
IC_MOVCAM_TURNAROUNDH = 126
IC_MOVCAM_TURNAROUNDV = 127
IC_MOVCAM_ZOOM = 128
IC_MOVCAM_EDITORMODE = 129
IC_MOVCAM_PREVITEM = 130
IC_MOVCAM_NEXTITEM = 131
IC_MOVCAM_UPITEM   = 132
IC_MOVCAM_DOWNITEM = 133

-- interface
IC_IF_AIRBASE_TOGGLE = 136
IC_IF_MOVIECAMERA_TOGGLE = 137
IC_IF_MOVIECAMERANEW_TOGGLE = 138

-- selector
IC_SEL_NEXT_ITEM = 140
IC_SEL_PREV_ITEM = 141
IC_SEL_ABOVE_ITEM = 142
IC_SEL_BELOW_ITEM = 143

-- ship
IC_SHIP_THRUST = 147
IC_SHIP_STEER = 148
IC_SHIP_LAUNCHLANDINGSHIPS = 149

-- submarine
IC_SUB_DIP = 150
IC_SUB_RISE = 151
IC_SHIP_LAUNCHUNIT = 152

-- gun common
IC_GUN_FIRE = 153

-- gun control
IC_GUNC_CHANGE = 155
IC_GUNC_AAFLAK = 156
IC_GUNC_ARTILLERY = 157
IC_GUNC_TORPEDO = 158
IC_GUNC_DEPTHCHARGE = 159

-- plane
IC_PLANE_LOOKMODE = 160
IC_PLANE_LOOKH = 161
IC_PLANE_LOOKV = 162
IC_PLANE_POWER = 163
IC_PLANE_YAW = 164
IC_PLANE_ROLL = 165
IC_PLANE_PITCH = 166
IC_PLANE_BOMBSWITCH = 167
IC_PLANE_BOMBFIRE = 168
IC_PLANE_FIRE = 169
IC_PLANE_TURBO = 170

-- bomber
IC_BOMBER_ROLL = 172
IC_BOMBER_PITCH = 173

-- plane mouse hack
IC_PLANE_ROLL_MOUSE = 174
IC_PLANE_PITCH_MOUSE = 175
IC_PLANE_LOOKH_MOUSE = 176
IC_PLANE_LOOKV_MOUSE = 177

-- airbase
IC_AIRBASE_NEXT = 180
IC_AIRBASE_PREV = 181
IC_AIRBASE_ADD = 182
IC_AIRBASE_REMOVE = 183
IC_AIRBASE_LAND = 184
IC_AIRBASE_TAKEOFF = 185
IC_AIRBASE_ATTACK = 186
IC_AIRBASE_CANCEL = 187
IC_AIRBASE_JUMPIN = 188
IC_AIRBASE_SET_CLEAR_ATTACK = 189
IC_AIRBASE_TAKEOFF_LAND = 190

-- map
IC_MAP_TOGGLE = 193
IC_MAP_PANNING_UP_DOWN = 194
IC_MAP_PANNING_LEFT_RIGHT = 195
IC_MAP_ZOOM = 196
IC_MAP_HSCROLL = 197
IC_MAP_VSCROLL = 198
IC_MAP_GIVEUNIT = 199
IC_MAP_OBJECTIVES = 200
IC_MAP_CYCLE_OBJECTIVES = 201

-- orders
IC_ORDERS_OK = 203
IC_ORDERS_APPLY2FORMATION = 204

-- command
IC_CMD_SETTARGET = 206
IC_CMD_CLEARTARGET = 207
IC_CMD_JUMPIN = 208
IC_CMD_MAP_CLEARTARGET = 209
IC_CMD_MAP_JUMPIN = 210
IC_CMD_MAP_TARGET = 211
IC_CMD_MAP_MOVE = 212
IC_CMD_MAP_JOIN = 213

-- formation
IC_FORM_CLOSE = 214
IC_FORM_OK = 215
IC_FORM_SELECT = 216
IC_FORM_H = 217
IC_FORM_V = 218
IC_FORM_PREV = 219
IC_FORM_NEXT = 220
IC_FORM_H_UNIT_PC = 221
IC_FORM_V_UNIT_PC = 222

-- unit
IC_ZOOM_ROLE_SWITCH = 223
IC_ZOOM_PC_TRICK = 224

-- limbo
IC_LIMBO_CONTINUE = 225

-- shortcut
IC_WARNING_DIALOGSTEP = 230
IC_WARNING_MISSIONINFOSTEP = 231

-- overlay shortcut
IC_OVERLAY_GREEN = 234
IC_OVERLAY_RED = 235
IC_OVERLAY_BLUE = 236
IC_OVERLAY_YELLOW = 237

-- repair
IC_REPAIR = 239

-- configurable ingame menu
IC_GAMEMENU_LEFT = 241
IC_GAMEMENU_RIGHT = 242
IC_GAMEMENU_UP = 243
IC_GAMEMENU_DOWN = 244

-- load/save
IC_DIALOGBOX_RESTART = 245
IC_DIALOGBOX_YES = 246
IC_DIALOGBOX_NO = 247
IC_DIALOGBOX_ACCEPT = 248

-- pc chat
IC_TOGGLECHAT_PC = 249

-- support manager
IC_SM_PRIMARY = 251
IC_SM_SECONDARY = 252
IC_SM_GROUPED = 253
IC_SM_CAP = 254
IC_SM_ATTACK = 255
IC_SM_MENU_FIRST_LEVEL = 256
IC_SM_JUMP_IN = 257
IC_SM_LAND = 258

IC_SHIP_TURBO = 259

IC_REPAIR_H = 260
IC_REPAIR_V = 261

-- Orders Menu
IC_OVERLAY_H = 262
IC_OVERLAY_V = 263

-- power-ups
IC_POWERUPS_TOGGLE = 264

-- ping
IC_PING_NORMAL = 265
IC_PING_ATTACK = 266
IC_PING_DEFEND = 267

-- temp hacks
--[[IC_TEMP_HACK_1 = 271
IC_TEMP_HACK_2 = 272
IC_TEMP_HACK_3 = 273
IC_TEMP_HACK_4 = 274]]

IC_SM_CHANGE_WEAPON = 278

IC_DPMENU_LEFT = 280
IC_DPMENU_RIGHT = 281
IC_DPMENU_UP = 282
IC_DPMENU_DOWN = 283

IC_REPAIR_MOUSE_H = 284
IC_REPAIR_MOUSE_V = 285

IC_MAP_CLOSEST_H = 286
IC_MAP_CLOSEST_V = 287

IC_MAP_FILTER = 288

IC_CAMPAIGN_MAP_ZOOM_IN = 289
IC_CAMPAIGN_MAP_ZOOM_OUT = 290

IC_FE_SCROLL = 291

IC_LOBBY_READY = 292

IC_SINGLE_PAUSE_SCROLL = 293

IC_REPAIR_KEYBOARD_H = 294
IC_REPAIR_KEYBOARD_V = 295

---- NEW COMMANDS ----

-- SMOKESCREEN
IC_CONSOLE_ONOFF = 250

-- BSM CLASSIC
MP_LAUNCH_ABSTOCK_1 = 296
MP_LAUNCH_ABSTOCK_2 = 297
MP_LAUNCH_ABSTOCK_3 = 298
MP_LAUNCH_ABSTOCK_4 = 299
MP_LAUNCH_ABSTOCK_5 = 300
MP_LAUNCH_ABSTOCK_6 = 301
MP_LAUNCH_ABSTOCK_7 = 302
MP_LAUNCH_ABSTOCK_8 = 303

-------------------------------------------------
--controller input-ok
-------------------------------------------------

--ezeknek osszhangban kell lenni a mitgamecontroller.h-beli deklaraciokkal (nem szabad a kod valtoztatasa nelkul valtoztatni rajtuk)
--egyelore az xbox kontrollert vesszuk alapul

BUTTON_A = 0
BUTTON_B = 1
BUTTON_X = 2
BUTTON_Y = 3
BUTTON_DP_LEFT = 4
BUTTON_DP_RIGHT = 5
BUTTON_DP_UP = 6
BUTTON_DP_DOWN = 7
BUTTON_STICK_LEFT = 8
BUTTON_STICK_RIGHT = 9
BUTTON_BUMPER_LEFT = 10
BUTTON_BUMPER_RIGHT = 11
BUTTON_TRIGGER_LEFT = 12
BUTTON_TRIGGER_RIGHT = 13
BUTTON_START = 14
BUTTON_BACK = 15

AXIS_STICK_LEFT_X = 60
AXIS_STICK_LEFT_Y = 61
AXIS_STICK_RIGHT_X = 62
AXIS_STICK_RIGHT_Y = 63

-------------------------------------------------
--keyboard input-ok
-------------------------------------------------

--ezeknek osszhangban kell lenni a mitkeyboard.h-beli deklaraciokkal (nem szabad a kod valtoztatasa nelkul valtoztatni rajtuk)

KC_ESCAPE = 1
KC_1 = 2
KC_2 = 3
KC_3 = 4
KC_4 = 5
KC_5 = 6
KC_6 = 7
KC_7 = 8
KC_8 = 9
KC_9 = 10
KC_0 = 11
KC_MINUS = 12
KC_EQUALS = 13
KC_BACK = 14
KC_TAB = 15
KC_Q = 16
KC_W = 17
KC_E = 18
KC_R = 19
KC_T = 20
KC_Y = 21
KC_U = 22
KC_I = 23
KC_O = 24
KC_P = 25
KC_LBRACKET = 26
KC_RBRACKET = 27
KC_RETURN = 28
KC_LCONTROL = 29
KC_A = 30
KC_S = 31
KC_D = 32
KC_F = 33
KC_G = 34
KC_H = 35
KC_J = 36
KC_K = 37
KC_L = 38
KC_SEMICOLON = 39
KC_APOSTROPHE = 40
KC_GRAVE = 41
KC_LSHIFT = 42
KC_BACKSLASH = 43
KC_Z = 44
KC_X = 45
KC_C = 46
KC_V = 47
KC_B = 48
KC_N = 49
KC_M = 50
KC_COMMA = 51
KC_PERIOD = 52
KC_SLASH = 53
KC_RSHIFT = 54
KC_MULTIPLY = 55
KC_LMENU = 56
KC_SPACE = 57
KC_CAPITAL = 58
KC_F1 = 59
KC_F2 = 60
KC_F3 = 61
KC_F4 = 62
KC_F5 = 63
KC_F6 = 64
KC_F7 = 65
KC_F8 = 66
KC_F9 = 67
KC_F10 = 68
KC_NUMLOCK = 69
KC_SCROLL = 70
KC_NUMPAD7 = 71
KC_NUMPAD8 = 72
KC_NUMPAD9 = 73
KC_SUBTRACT = 74
KC_NUMPAD4 = 75
KC_NUMPAD5 = 76
KC_NUMPAD6 = 77
KC_ADD = 78
KC_NUMPAD1 = 79
KC_NUMPAD2 = 80
KC_NUMPAD3 = 81
KC_NUMPAD0 = 82
KC_DECIMAL = 83
KC_OEM_102 = 86
KC_F11 = 87
KC_F12 = 88
KC_F13 = 100
KC_F14 = 101
KC_F15 = 102
KC_KANA = 112
KC_ABNT_C1 = 115
KC_CONVERT = 121
KC_NOCONVERT = 123
KC_YEN = 125
KC_ABNT_C2 = 126
KC_NUMPADEQUALS = 141
KC_PREVTRACK = 144
KC_AT = 145
KC_COLON = 146
KC_UNDERLINE = 147
KC_KANJI = 148
KC_STOP = 149
KC_AX = 150
KC_UNLABELED = 151
KC_NEXTTRACK = 153
KC_NUMPADENTER = 156
KC_RCONTROL = 157
KC_MUTE = 160
KC_CALCULATOR = 161
KC_PLAYPAUSE = 162
KC_MEDIASTOP = 164
KC_VOLUMEDOWN = 174
KC_VOLUMEUP = 176
KC_WEBHOME = 178
KC_NUMPADCOMMA = 179
KC_DIVIDE = 181
KC_SYSRQ = 183
KC_RMENU = 184
KC_PAUSE = 197
KC_HOME = 199
KC_UP = 200
KC_PGUP = 201
KC_LEFT = 203
KC_RIGHT = 205
KC_END = 207
KC_DOWN = 208
KC_PGDOWN = 209
KC_INSERT = 210
KC_DELETE = 211
KC_LWIN = 219
KC_RWIN = 220
KC_APPS = 221
KC_POWER = 222
KC_SLEEP = 223
KC_WAKE = 227
KC_WEBSEARCH = 229
KC_WEBFAVORITES = 230
KC_WEBREFRESH = 231
KC_WEBSTOP = 232
KC_WEBFORWARD = 233
KC_WEBBACK = 234
KC_MYCOMPUTER = 235
KC_MAIL = 236
KC_MEDIASELECT = 237
KC_LALT = KC_LMENU
KC_RALT = KC_RMENU

-------------------------------------------------
--mouse input-ok
-------------------------------------------------

--ezeknek osszhangban kell lenni a mitmouse.h-beli deklaraciokkal (nem szabad a kod valtoztatasa nelkul valtoztatni rajtuk)

MC_BUTTON_LEFT = 0
MC_BUTTON_RIGHT = 1
MC_BUTTON_MIDDLE = 2

MC_AXIS_X = 8
MC_AXIS_Y = 9
MC_AXIS_SCROLL = 10

-------------------------------------------------
--input tipusok
-------------------------------------------------

IDT_KEYBOARD = 0
IDT_MOUSE = 1
IDT_GAMECONTROLLER = 2

-------------------------------------------------
--az Inputs tabla
-------------------------------------------------

Inputs =
{
	[IC_PAUSE] =
	{
		["comment"] = "IC_PAUSE",
		["groups"] = { IG_INGAMEALWAYS, IG_MOVIECAMERA, IG_PAUSE },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, },
		}),
	}, --IC_PAUSE

	[IC_ENDMOVIEPLAY] =
	{
		["comment"] = "IC_ENDMOVIEPLAY",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, }, --EM pausolhatosag miatt kiveve
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_SPACE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_SPACE }, },
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, }, --EM pausolhatosag miatt kiveve
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BACK }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_ENDMOVIEPLAY

	--[[[IC_CONSOLE_ONOFF] =
	{
		["comment"] = "IC_CONSOLE_ONOFF",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_GRAVE }, },
		}),
	}, --IC_CONSOLE_ONOFF]]

	[IC_CHEAT_MENU] =
	{
		["comment"] = "IC_CHEAT_MENU",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_MENU
	[IC_CHEAT_QUIT] = --jatekbol kilepes
	{
		["comment"] = "IC_CHEAT_QUIT",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_QUIT
	[IC_CHEAT_ENDSCENE] = --palyarol kilepes
	{
		["comment"] = "IC_CHEAT_ENDSCENE",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_ENDSCENE
	[IC_CHEAT_FAST] = --gyorsitas
	{
		["comment"] = "IC_CHEAT_FAST",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_FAST
	[IC_CHEAT_VERYFAST] =
	{
		["comment"] = "IC_CHEAT_VERYFAST",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_VERYFAST
	[IC_CHEAT_PAUSESTEP] =
	{
		["comment"] = "IC_CHEAT_PAUSESTEP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_PAUSESTEP
	[IC_CHEAT_SLOW] =
	{
		["comment"] = "IC_CHEAT_SLOW",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_SLOW
	[IC_CHEAT_NEXTPARTY] =
	{
		["comment"] = "IC_CHEAT_NEXTPARTY",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_NEXTPARTY
	[IC_CHEAT_ALLOCLOG] =
	{
		["comment"] = "IC_CHEAT_ALLOCLOG",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	},
	[IC_CHEAT_KILL] =
	{
		["comment"] = "IC_CHEAT_KILL",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_KILL
	[IC_CHEAT_LOOK] =
	{
		["comment"] = "IC_CHEAT_LOOK",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_LOOK
	[IC_CHEAT_WIREOCEAN] =
	{
		["comment"] = "IC_CHEAT_WIREOCEAN",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_WIREOCEAN
	[IC_CHEAT_AIDEBUG] =
	{
		["comment"] = "IC_CHEAT_AIDEBUG",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_AIDEBUG
	[IC_CHEAT_ATTIS1] =
	{
		["comment"] = "IC_CHEAT_ATTIS1",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_ATTIS
	[IC_CHEAT_ATTIS2] =
	{
		["comment"] = "IC_CHEAT_ATTIS2",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_ATTIS
	[IC_CHEAT_RENDERGEOMMESH] =
	{
		["comment"] = "IC_CHEAT_RENDERGEOMMESH",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_RENDERGEOMMESH
	[IC_CHEAT_UP] =
	{
		["comment"] = "IC_CHEAT_UP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_UP
	[IC_CHEAT_DOWN] =
	{
		["comment"] = "IC_CHEAT_DOWN",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_DOWN
	[IC_CHEAT_LEFT] =
	{
		["comment"] = "IC_CHEAT_LEFT",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_LEFT
	[IC_CHEAT_RIGHT] =
	{
		["comment"] = "IC_CHEAT_RIGHT",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_RIGHT
	[IC_CHEAT_SELECT] =
	{
		["comment"] = "IC_CHEAT_SELECT",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_SELECT
	[IC_CHEAT_BACK] =
	{
		["comment"] = "IC_CHEAT_BACK",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_BACK
	[IC_CHEAT_NOFIRE] =
	{
		["comment"] = "IC_CHEAT_NOFIRE",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	},
	[IC_CHEAT_CAPTURE] =
	{
		["comment"] = "IC_CHEAT_CAPTURE",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_CAPTURE
	[IC_CHEAT_SAVETEST] =
	{
		["comment"] = "IC_CHEAT_SAVETEST",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_SAVETEST
	[IC_CHEAT_UNLOCKALL] =
	{
		["comment"] = "IC_CHEAT_UNLOCKALL",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_UNLOCKALL
	[IC_CHEAT_PGUP] =
	{
		["comment"] = "IC_CHEAT_PGUP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_PGUP }, },
		},
	}, --IC_CHEAT_PGUP
	[IC_CHEAT_PGDOWN] =
	{
		["comment"] = "IC_CHEAT_PGDOWN",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_PGDOWN }, },
		},
	}, --IC_CHEAT_PGDOWN
	[IC_CHEAT_F1] =
	{
		["comment"] = "IC_CHEAT_F1",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F1 }, },
		},
	}, --IC_CHEAT_F1
	[IC_CHEAT_F2] =
	{
		["comment"] = "IC_CHEAT_F2",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F2 }, },
		},
	}, --IC_CHEAT_F2
	[IC_CHEAT_F3] =
	{
		["comment"] = "IC_CHEAT_F3",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F3 }, },
		},
	}, --IC_CHEAT_F3
	[IC_CHEAT_F4] =
	{
		["comment"] = "IC_CHEAT_F4",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F4 }, },
		},
	}, --IC_CHEAT_F4
	[IC_CHEAT_F5] =
	{
		["comment"] = "IC_CHEAT_F5",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F5 }, },
		},
	}, --IC_CHEAT_F5
	[IC_CHEAT_F6] =
	{
		["comment"] = "IC_CHEAT_F6",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F6 }, },
		},
	}, --IC_CHEAT_F6
	[IC_CHEAT_F7] =
	{
		["comment"] = "IC_CHEAT_F7",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F7 }, },
		},
	}, --IC_CHEAT_F7
	[IC_CHEAT_F8] =
	{
		["comment"] = "IC_CHEAT_F8",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F8 }, },
		},
	}, --IC_CHEAT_F8
	[IC_CHEAT_F9] =
	{
		["comment"] = "IC_CHEAT_F9",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F9 }, },
		},
	}, --IC_CHEAT_F9
	[IC_CHEAT_F10] =
	{
		["comment"] = "IC_CHEAT_F10",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F10 }, },
		},
	}, --IC_CHEAT_F10
	[IC_CHEAT_F11] =
	{
		["comment"] = "IC_CHEAT_F11",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F11 }, },
		},
	}, --IC_CHEAT_F11
	[IC_CHEAT_F12] =
	{
		["comment"] = "IC_CHEAT_F12",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_F12 }, },
		},
	}, --IC_CHEAT_F12
	[IC_CHEAT_SHIFT] =
	{
		["comment"] = "IC_CHEAT_SHIFT",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LSHIFT }, },
			{ ["press"] = { IDT_KEYBOARD, KC_RSHIFT }, },
		},
	}, --IC_CHEAT_SHIFT
	[IC_CHEAT_CONTROL] =
	{
		["comment"] = "IC_CHEAT_CONTROL",
		["groups"] = { IG_ALWAYS },
		["inputs"] = 
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LCONTROL }, },
			{ ["press"] = { IDT_KEYBOARD, KC_RCONTROL }, },
		},
	}, --IC_CHEAT_CONTROL
	[IC_CHEAT_ALT] =
	{
		["comment"] = "IC_CHEAT_ALT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = 
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LALT }, },
			{ ["press"] = { IDT_KEYBOARD, KC_RALT }, },
		},
	}, --IC_CHEAT_ALT
	[IC_CHEAT_FOV_DOWN] =
	{
		["comment"] = "IC_CHEAT_FOV_DOWN",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_FOV_DOWN
	[IC_CHEAT_FOV_UP] =
	{
		["comment"] = "IC_CHEAT_FOV_UP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_CHEAT_FOV_UP

-----------------------------MENU CUCCOK----------------------------------------

	[IC_MENU_UP] =
	{
		["comment"] = "IC_MENU_UP",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, }, },
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_LEFT_Y }, ["mul"] = -1, },
		}),
	}, --IC_MENU_UP
	[IC_MENU_DOWN] =
	{
		["comment"] = "IC_MENU_DOWN",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_DOWN }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_DOWN }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, }, },
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_LEFT_Y }, },
		}),
	}, --IC_MENU_DOWN
	[IC_MENU_PGUP] =
	{
		["comment"] = "IC_MENU_PGUP",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_PGUP }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, ["mul"] = -1, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, ["mul"] = -1, },
		}),
	}, --IC_MENU_PGUP
	[IC_MENU_PGDOWN] =
	{
		["comment"] = "IC_MENU_PGDOWN",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_PGDOWN }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_MENU_PGDOWN
	[IC_MENU_SELECT] =
	{
		["comment"] = "IC_MENU_SELECT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_MENU_SELECT
	[IC_MENU_BACK] =
	{
		["comment"] = "IC_MENU_BACK",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BACK }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	}, --IC_MENU_BACK
	[IC_MENU_LEFT] =
	{
		["comment"] = "IC_MENU_LEFT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LEFT }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LEFT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_DP_UP }, { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, }, },
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_LEFT_X }, ["mul"] = -1, },
		}),
	}, --IC_MENU_LEFT
	[IC_MENU_RIGHT] =
	{
		["comment"] = "IC_MENU_RIGHT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RIGHT }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RIGHT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_DP_UP }, { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, }, },
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_LEFT_X }, },
		}),
	}, --IC_MENU_RIGHT
	[IC_MENU_MOUSECLICK] =
	{
		["comment"] = "IC_MENU_MOUSECLICK",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_MOUSE, MC_BUTTON_LEFT }, },
		},
		{
			{ ["press"] = { IDT_MOUSE, MC_BUTTON_LEFT }, },
		}),
	}, --IC_MENU_MOUSECLICK
	[IC_MENU_RESTARTSCENE] =
	{
		["comment"] = "IC_MENU_RESTARTSCENE",
		["groups"] = { IG_MAINMENU },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	}, --IC_MENU_RESTARTSCENE
	[IC_MENU_START] =
	{
		["comment"] = "IC_MENU_START",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_SPACE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_SPACE }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},
	[IC_MENU_BUTTON_X] =
	{
		["comment"] = "IC_MENU_BUTTON_X",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_X }, },
		}),
	},
	[IC_MENU_BUTTON_Y] =
	{
		["comment"] = "IC_MENU_BUTTON_Y",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	},
	[IC_MENU_BUMPER_LEFT] =
	{
		["comment"] = "IC_MENU_BUMPER_LEFT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_DELETE }, }, -- Ha valakinek ez kell, irja vissza, hogy mihez hasznalja.
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_LEFT }, },
		}),
	},
	[IC_MENU_BUMPER_RIGHT] =
	{
		["comment"] = "IC_MENU_BUMPER_RIGHT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	},
	[IC_MENU_TRIGGER_RIGHT] =
	{
		["comment"] = "IC_MENU_TRIGGER_RIGHT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	},
	[IC_MENU_TRIGGER_LEFT] =
	{
		["comment"] = "IC_MENU_TRIGGER_LEFT",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, },
		}),
	},
	[IC_MENU_PLUS] =
	{
		["comment"] = "IC_MENU_PLUS",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ADD }, },
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT_PC }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	},
	[IC_MENU_MINUS] =
	{
		["comment"] = "IC_MENU_MINUS",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_SUBTRACT }, },
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT_PC }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, },
		}),
	},


-----------------------------MENU CUCCOK VEGE---------------------------------

-----------------------------FREE KAMERA CUCCAI---------------------------------


--[[	[IC_FREECAM_TOGGLE] =
	{
		["comment"] = "IC_FREECAM_TOGGLE",
		["groups"] = { IG_ALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, ["and"] = { { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT}, }, },
		}),
	}, ]]--
	[IC_FREECAM_ROLL] =
	{
		["comment"] = "IC_FREECAM_ROLL",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_LEFT }, ["mul"] = -1,},
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, --IC_FREECAM_ROLL
	[IC_FREECAM_FORWARD] =  --free camera elore-hatra mozgatasa
	{
		["comment"] = "IC_FREECAM_FORWARD",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) },  ["mul"] = -1, },
		}),
	}, --IC_FREECAM_FORWARD
	[IC_FREECAM_STRAFELEFTRIGHT] =
	{
		["comment"] = "IC_FREECAM_STRAFELEFTRIGHT",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_FREECAM_STRAFELEFTRIGHT
	[IC_FREECAM_STRAFEUPDOWN] =
	{
		["comment"] = "IC_FREECAM_STRAFEUPDOWN",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, ["mul"] = 0.3 },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, ["mul"] = -0.3 },
		}),
	}, --IC_FREECAM_STRAFEUPDOWN
	[IC_FREECAM_TURNLEFTRIGHT] =
	{
		["comment"] = "IC_FREECAM_TURNLEFTRIGHT",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) },},
		}),
	}, --IC_FREECAM_TURNLEFTRIGHT
	[IC_FREECAM_TURNUPDOWN] = 
	{
		["comment"] = "IC_FREECAM_TURNUPDOWN",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_FREECAM_TURNUPDOWN
	[IC_FREECAM_ACTUNIT] = 
	{
		["comment"] = "IC_FREECAM_ACTUNIT",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_LEFT }, },
		}),
	}, --IC_FREECAM_ACTUNIT
	[IC_FREECAM_VERT_TO_ZERO] = 
	{
		["comment"] = "IC_FREECAM_VERT_TO_ZERO",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_X }, },
		}),
	}, --IC_FREECAM_ACTUNIT
	[IC_FREECAM_HORZVERT_TO_ZERO] = 
	{
		["comment"] = "IC_FREECAM_HORZVERT_TO_ZERO",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	}, --IC_FREECAM_ACTUNIT
	[IC_FREECAM_SHOOT] = --ezzel lo a free kamera egyet, teszteleshez
	{
		["comment"] = "IC_FREECAM_SHOOT",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_FREECAM_SHOOT
	[IC_FREECAM_GUNSWITCH] = --ezzel valt lovest a free kamera, teszteleshez
	{
		["comment"] = "IC_FREECAM_GUNSWITCH",
		["groups"] = { IG_FREECAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	}, --IC_FREECAM_GUNSWITCH
	
-----------------------------FREE KAMERA VEGE------------------------------------

-----------------------------ALTALANOS KAMERA------------------------------------

	[IC_GENCAM_H] =
	{
		["comment"] = "IC_GENCAM_H",
		["groups"] = { IG_GENERALCAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_GENCAM_H
	[IC_GENCAM_V] =
	{
		["comment"] = "IC_GENCAM_V",
		["groups"] = { IG_GENERALCAMERA },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_GENCAM_V
	[IC_GENCAM_ZOOM] =
	{
		["comment"] = "IC_GENCAM_ZOOM",
		["groups"] = { IG_GENERALCAMERA },
		["inputs"] =
		{
		},
	}, --IC_GENCAM_ZOOM

	[IC_GENCAM_RESET] =
	{
		["comment"] = "IC_GENCAM_RESET",
		["groups"] = { IG_GENERALCAMERA },
		["inputs"] =
		{
		},
	}, --IC_GENCAM_ZOOM

-------------------------ALTALANOS KAMERA VEGE-----------------------------------


-----------------------------MOVIE KAMERA----------------------------------------

	[IC_MOVCAM_TARGETEDMODE] =
	{
		["comment"] = "IC_MOVCAM_TARGETEDMODE",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_TARGETEDMODE
	[IC_MOVCAM_DECKMODE] =
	{
		["comment"] = "IC_MOVCAM_DECKMODE",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_DECKMODE
	[IC_MOVCAM_DROPCAMERA] =
	{
		["comment"] = "IC_MOVCAM_DROPCAMERA",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_DROPCAMERA
	[IC_MOVCAM_SELECTSECONDARYTARGET] =
	{
		["comment"] = "IC_MOVCAM_SELECTSECONDARYTARGET",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_SELECTSECONDARYTARGET
	[IC_MOVCAM_WALKAROUNDH] =
	{
		["comment"] = "IC_MOVCAM_WALKAROUNDH",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_WALKAROUNDH
	[IC_MOVCAM_WALKAROUNDV] =
	{
		["comment"] = "IC_MOVCAM_WALKAROUNDV",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_WALKAROUNDV
	[IC_MOVCAM_TURNAROUNDH] =
	{
		["comment"] = "IC_MOVCAM_TURNAROUNDH",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_TURNAROUNDH
	[IC_MOVCAM_TURNAROUNDV] =
	{
		["comment"] = "IC_MOVCAM_TURNAROUNDV",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_TURNAROUNDV
	[IC_MOVCAM_ZOOM] =
	{
		["comment"] = "IC_MOVCAM_ZOOM",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_ZOOM
	[IC_MOVCAM_EDITORMODE] =
	{
		["comment"] = "IC_MOVCAM_EDITORMODE",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_EDITORMODE
	[IC_MOVCAM_PREVITEM] =
	{
		["comment"] = "IC_MOVCAM_PREVITEM",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_PREVITEM
	[IC_MOVCAM_NEXTITEM] =
	{
		["comment"] = "IC_MOVCAM_NEXTITEM",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_NEXTITEM
	[IC_MOVCAM_UPITEM] =
	{
		["comment"] = "IC_MOVCAM_UPITEM",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_UPITEM
	[IC_MOVCAM_DOWNITEM] =
	{
		["comment"] = "IC_MOVCAM_DOWNITEM",
		["groups"] = { IG_MOVIECAMERA },
		["inputs"] =
		{
		},
	}, --IC_MOVCAM_DOWNITEM

-----------------------------MOVIE KAMERA VEGE-----------------------------------

	[IC_SHIP_THRUST] =
	{
		["comment"] = "IC_SHIP_THRUST",
		["groups"] = { IG_SHIP, IG_SUBMARINE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
		}),
	}, --IC_SHIP_THRUST
	[IC_SHIP_STEER] =
	{
		["comment"] = "IC_SHIP_STEER",
		["groups"] = { IG_SHIP, IG_SUBMARINE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_SHIP_STEER
	[IC_SHIP_LAUNCHLANDINGSHIPS] =
	{
		["comment"] = "IC_SHIP_LAUNCHLANDINGSHIPS",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, --IC_SHIP_LAUNCHLANDINGSHIPS
	[IC_SHIP_TURBO] =
	{
		["comment"] = "IC_SHIP_TURBO",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_LEFT) }, },
		}),
	}, --IC_SHIP_TURBO
	[IC_SUB_DIP] =
	{
		["comment"] = "IC_SUB_DIP",
		["groups"] = { IG_SUBMARINE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, }, },
		}),
	}, --IC_SUB_DIP
	[IC_SUB_RISE] =
	{
		["comment"] = "IC_SUB_RISE",
		["groups"] = { IG_SUBMARINE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, }, },
		}),
	}, --IC_SUB_RISE
	[IC_SHIP_LAUNCHUNIT] =
	{
		["comment"] = "IC_SHIP_LAUNCHUNIT",
		["groups"] = { IG_SUBMARINE, IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, --IC_SHIP_LAUNCHUNIT

	[IC_MAP_TOGGLE] =
	{
		["comment"] = "IC_MAP_TOGGLE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BACK }, },
		}),
	}, --IC_MAP_TOGGLE
	[IC_MAP_PANNING_UP_DOWN] =
	{
		["comment"] = "IC_MAP_PANNING_UP_DOWN",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, ["mul"] = 1, },
		}),
	}, --IC_MAP_PANNING_UP_DOWN
	[IC_MAP_PANNING_LEFT_RIGHT] =
	{
		["comment"] = "IC_MAP_PANNING_LEFT_RIGHT",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, ["mul"] = 1, },
		}),
	}, --IC_MAP_PANNING_LEFT_RIGHT
	[IC_MAP_ZOOM] =
	{
		["comment"] = "IC_MAP_ZOOM",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, ["mul"] = -1.0, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, },
		}),
	},
	[IC_MAP_CLOSEST_H] =
	{
		["comment"] = "IC_MAP_CLOSEST_H",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, ["mul"] = 1, },
		}),
	}, --IC_MAP_CLOSEST_H
	[IC_MAP_CLOSEST_V] =
	{
		["comment"] = "IC_MAP_CLOSEST_V",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, ["mul"] = 1, },
		}),
	}, --IC_MAP_CLOSEST_H
	[IC_MAP_HSCROLL] =
	{
		["comment"] = "IC_MAP_HSCROLL",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_X }, },
		},
		{
		}),
	}, --IC_MAP_HSCROLL
	[IC_MAP_VSCROLL] =
	{
		["comment"] = "IC_MAP_VSCROLL",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_Y }, },
		},
		{
		}),
	}, --IC_MAP_VSCROLL
	[IC_MAP_GIVEUNIT] =
	{
		["comment"] = "IC_MAP_GIVEUNIT",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[IC_MAP_FILTER] =
	{
		["comment"] = "IC_MAP_FILTER",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	},
	[IC_CAMPAIGN_MAP_ZOOM_IN] =
	{
		["comment"] = "IC_CAMPAIGN_MAP_ZOOM_IN",
		["groups"] = { IG_MAINMENU },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, },
		}),
	},
	[IC_CAMPAIGN_MAP_ZOOM_OUT] =
	{
		["comment"] = "IC_CAMPAIGN_MAP_ZOOM_OUT",
		["groups"] = { IG_MAINMENU },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	},
	[IC_FE_SCROLL] =
	{
		["comment"] = "IC_FE_SCROLL",
		["groups"] = { IG_MAINMENU },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_RIGHT_Y }, ["mul"] = -1, },
		}),
	},
	[IC_SINGLE_PAUSE_SCROLL] =
	{
		["comment"] = "IC_SINGLE_PAUSE_SCROLL",
		["groups"] = { IG_PAUSE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, AXIS_STICK_RIGHT_Y }, ["mul"] = -1, },
		}),
	},
	[IC_LOBBY_READY] =
	{
		["comment"] = "IC_LOBBY_READY",
		["groups"] = { IG_MAINMENU },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, },
		}),
	},
	[IC_MAP_OBJECTIVES] =
	{
		["comment"] = "IC_MAP_OBJECTIVES",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	},
	[IC_MAP_CYCLE_OBJECTIVES] =
	{
		["comment"] = "IC_MAP_CYCLE_OBJECTIVES",
		["groups"] = { IG_MAP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},

	[IC_GUN_FIRE] =
	{
		["comment"] = "IC_GUN_FIRE",
		["groups"] = { IG_GUNCONTROL },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	}, --IC_GUN_FIRE
	[IC_GUNC_CHANGE] =
	{
		["comment"] = "IC_GUNC_CHANGE",
		["groups"] = { IG_GUNCONTROL, IG_ZOOMROLESWITCH },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_X }, }, },
		}),
	},
	[IC_GUNC_AAFLAK] =
	{
		["comment"] = "IC_GUNC_AAFLAK",
		["groups"] = { IG_GUNCONTROL, IG_ZOOMROLESWITCH },
		["inputs"] =
		{
		},
	},
	[IC_GUNC_ARTILLERY] =
	{
		["comment"] = "IC_GUNC_ARTILLERY",
		["groups"] = { IG_GUNCONTROL, IG_ZOOMROLESWITCH },
		["inputs"] =
		{
		},
	},
	[IC_GUNC_TORPEDO] =
	{
		["comment"] = "IC_GUNC_TORPEDO",
		["groups"] = { IG_GUNCONTROL, IG_ZOOMROLESWITCH },
		["inputs"] =
		{
		},
	},
	[IC_GUNC_DEPTHCHARGE] =
	{
		["comment"] = "IC_GUNC_DEPTHCHARGE",
		["groups"] = { IG_GUNCONTROL, IG_ZOOMROLESWITCH },
		["inputs"] =
		{
		},
	},

	[IC_PLANE_LOOKMODE] =
	{
		["comment"] = "IC_PLANE_LOOKMODE",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, --IC_PLANE_LOOKMODE
	[IC_PLANE_LOOKH] =
	{
		["comment"] = "IC_PLANE_LOOKH",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_PLANE_LOOKH
	[IC_PLANE_LOOKV] =
	{
		["comment"] = "IC_PLANE_LOOKV",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_PLANE_LOOKV
	[IC_PLANE_LOOKH_MOUSE] =
	{
		["comment"] = "IC_PLANE_LOOKH_MOUSE",
		["groups"] = { IG_PLANE },
		["inputs"] =
		{
		},
	}, --IC_PLANE_LOOKH_MOUSE
	[IC_PLANE_LOOKV_MOUSE] =
	{
		["comment"] = "IC_PLANE_LOOKV_MOUSE",
		["groups"] = { IG_PLANE },
		["inputs"] =
		{
		},
	}, --IC_PLANE_LOOKV_MOUSE
	[IC_PLANE_POWER] =
	{
		["comment"] = "IC_PLANE_POWER",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, ["mul"] = 2, },
		}),
	}, --IC_PLANE_POWER
	[IC_PLANE_TURBO] =
	{
		["comment"] = "IC_PLANE_TURBO",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_LEFT) }, },
		}),
	}, --IC_PLANE_POWER
	[IC_PLANE_YAW] =
	{
		["comment"] = "IC_PLANE_YAW",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_PLANE_YAW
	[IC_PLANE_ROLL] =
	{
		["comment"] = "IC_PLANE_ROLL",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_PLANE_ROLL
	[IC_PLANE_PITCH] =
	{
		["comment"] = "IC_PLANE_PITCH",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_PLANE_PITCH
	[IC_PLANE_ROLL_MOUSE] =
	{
		["comment"] = "IC_PLANE_ROLL_MOUSE",
		["groups"] = { IG_PLANE },
		["inputs"] =
		{
		},
	}, --IC_PLANE_ROLL_MOUSE
	[IC_PLANE_PITCH_MOUSE] =
	{
		["comment"] = "IC_PLANE_PITCH_MOUSE",
		["groups"] = { IG_PLANE },
		["inputs"] =
		{
		},
	}, --IC_PLANE_PITCH_MOUSE
	[IC_PLANE_BOMBSWITCH] =
	{
		["comment"] = "IC_PLANE_BOMBSWITCH",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_LEFT }, },
		}),
	}, --IC_PLANE_BOMBSWITCH
	[IC_PLANE_BOMBFIRE] =
	{
		["comment"] = "IC_PLANE_BOMBFIRE",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	}, --IC_PLANE_BOMBFIRE
	[IC_PLANE_FIRE] =
	{
		["comment"] = "IC_PLANE_FIRE",
		["groups"] = { IG_PLANE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_TRIGGER_RIGHT }, },
		}),
	}, --IC_PLANE_FIRE
	[IC_BOMBER_ROLL] =
	{
		["comment"] = "IC_BOMBER_ROLL",
		["groups"] = { IG_BOMBER },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_BOMBER_ROLL
	[IC_BOMBER_PITCH] =
	{
		["comment"] = "IC_BOMBER_PITCH",
		["groups"] = { IG_BOMBER },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_BOMBER_PITCH

	[IC_IF_AIRBASE_TOGGLE] =
	{
		["comment"] = "IC_IF_AIRBASE_TOGGLE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_IF_AIRBASE_TOGGLE
	[IC_IF_MOVIECAMERA_TOGGLE] =
	{
		["comment"] = "IC_IF_MOVIECAMERA_TOGGLE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] =
		{
		},
	}, --IC_IF_MOVIECAMERA_TOGGLE
	[IC_IF_MOVIECAMERANEW_TOGGLE] =
	{
		["comment"] = "IC_IF_MOVIECAMERANEW_TOGGLE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] =
		{
		},
	}, --IC_IF_MOVIECAMERANEW_TOGGLE
	[IC_SEL_NEXT_ITEM] =
	{
		["comment"] = "IC_SEL_NEXT_ITEM",
		["groups"] = { IG_UNITMENUUNIT, IG_LIMBO },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_X }, { IDT_GAMECONTROLLER, BUTTON_DP_UP }, { IDT_GAMECONTROLLER, BUTTON_DP_DOWN },  }, },
		}),
	}, --IC_SEL_NEXT_ITEM
	[IC_SEL_PREV_ITEM] =
	{
		["comment"] = "IC_SEL_PREV_ITEM",
		["groups"] = { IG_UNITMENUUNIT, IG_LIMBO },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_X }, { IDT_GAMECONTROLLER, BUTTON_DP_UP }, { IDT_GAMECONTROLLER, BUTTON_DP_DOWN },  }, },
		}),
	}, --IC_SEL_PREV_ITEM
	[IC_SEL_ABOVE_ITEM] =
	{
		["comment"] = "IC_SEL_ABOVE_ITEM",
		["groups"] = { IG_UNITMENUUNIT, IG_LIMBO },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_X }, { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT },  }, },
		}),
	}, --IC_SEL_ABOVE_ITEM
	[IC_SEL_BELOW_ITEM] =
	{
		["comment"] = "IC_SEL_BELOW_ITEM",
		["groups"] = { IG_UNITMENUUNIT, IG_LIMBO },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, ["not"] = { { IDT_GAMECONTROLLER, BUTTON_X }, { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT },  }, },
		}),
	}, --IC_SEL_BELOW_ITEM

	[IC_ORDERS_OK] =
	{
		["comment"] = "IC_ORDERS_OK",
		["groups"] = { IG_ORDERS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_ORDERS_OK
	[IC_ORDERS_APPLY2FORMATION] =
	{
		["comment"] = "IC_ORDERS_APPLY2FORMATION",
		["groups"] = { IG_ORDERS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_ORDERS_APPLY2FORMATION

	[IC_CMD_SETTARGET] =
	{
		["comment"] = "IC_CMD_SETTARGET",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},
	[IC_CMD_CLEARTARGET] =
	{
		["comment"] = "IC_CMD_CLEARTARGET",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	},
	[IC_CMD_JUMPIN] =
	{
		["comment"] = "IC_CMD_JUMPIN",
		["groups"] = { IG_COMMAND },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	},
	[IC_CMD_MAP_CLEARTARGET] =
	{
		["comment"] = "IC_CMD_MAP_CLEARTARGET",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	},
	[IC_CMD_MAP_JUMPIN] =
	{
		["comment"] = "IC_CMD_MAP_JUMPIN",
		["groups"] = { IG_COMMAND },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},
	[IC_CMD_MAP_TARGET] =
	{
		["comment"] = "IC_CMD_MAP_TARGET",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},
	[IC_CMD_MAP_MOVE] =
	{
		["comment"] = "IC_CMD_MAP_MOVE",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},
	[IC_CMD_MAP_JOIN] =
	{
		["comment"] = "IC_CMD_MAP_JOIN",
		["groups"] = { IG_COMMAND, IG_AIRBASE },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	},

	[IC_FORM_CLOSE] =
	{
		["comment"] = "IC_FORM_CLOSE",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	}, --IC_FORM_CLOSE
	[IC_FORM_OK] =
	{
		["comment"] = "IC_FORM_OK",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_FORM_OK
	[IC_FORM_SELECT] =
	{
		["comment"] = "IC_FORM_SELECT",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_RIGHT) }, },
		}),
	}, --IC_FORM_CUSTOMIZE
	[IC_FORM_H] =
	{
		["comment"] = "IC_FORM_H",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_X }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_FORM_H
	[IC_FORM_V] =
	{
		["comment"] = "IC_FORM_V",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_Y }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, },
		}),
	}, --IC_FORM_V
	[IC_FORM_H_UNIT_PC] =
	{
		["comment"] = "IC_FORM_H_UNIT_PC",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_FORM_H_UNIT_PC
	[IC_FORM_V_UNIT_PC] =
	{
		["comment"] = "IC_FORM_V_UNIT_PC",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, },
		}),
	}, --IC_FORM_V_UNIT_PC
	[IC_FORM_PREV] =
	{
		["comment"] = "IC_FORM_PREV",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, },
		}),
	}, --IC_FORM_PREV
	[IC_FORM_NEXT] =
	{
		["comment"] = "IC_FORM_NEXT",
		["groups"] = { IG_FORMATION },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, },
		}),
	}, --IC_FORM_NEXT

	[IC_ZOOM_ROLE_SWITCH] =
	{
		["comment"] = "IC_ZOOM_ROLE_SWITCH",
		["groups"] = { IG_ZOOMROLESWITCH },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_RIGHT) }, },
		}),
	}, --IC_ZOOM_ROLE_SWITCH
	[IC_ZOOM_PC_TRICK] =
	{
		["comment"] = "IC_ZOOM_PC_TRICK",
		["groups"] = { IG_ZOOMROLESWITCH },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_RIGHT) }, },
		}),
	}, --IC_ZOOM_PC_TRICK

	[IC_AIRBASE_PREV] =
	{
		["comment"] = "IC_AIRBASE_PREV",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_PREV
	[IC_AIRBASE_NEXT] =
	{
		["comment"] = "IC_AIRBASE_NEXT",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_NEXT
	[IC_AIRBASE_ADD] =
	{
		["comment"] = "IC_AIRBASE_ADD",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_ADD
	[IC_AIRBASE_REMOVE] =
	{
		["comment"] = "IC_AIRBASE_REMOVE",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_REMOVE
	[IC_AIRBASE_ATTACK] =
	{
		["comment"] = "IC_AIRBASE_ATTACK",
		["groups"] = { IG_AIRBASE },
		["inputs"] =
		{
		},
	}, --IC_AIRBASE_ATTACK
	[IC_AIRBASE_SET_CLEAR_ATTACK] =
	{
		["comment"] = "IC_AIRBASE_SET_CLEAR_ATTACK",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_SET_CLEAR_ATTACK
	[IC_AIRBASE_TAKEOFF_LAND] =
	{
		["comment"] = "IC_AIRBASE_TAKEOFF_LAND",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_TAKEOFF
	[IC_AIRBASE_CANCEL] =
	{
		["comment"] = "IC_AIRBASE_CANCEL",
		["groups"] = { IG_AIRBASE },
		["inputs"] =
		{
		},
	}, --IC_AIRBASE_CANCEL
	[IC_AIRBASE_JUMPIN] =
	{
		["comment"] = "IC_AIRBASE_JUMPIN",
		["groups"] = { IG_AIRBASE },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, --IC_AIRBASE_JUMPIN

	[IC_LIMBO_CONTINUE] =
	{
		["comment"] = "IC_LIMBO_CONTINUE",
		["groups"] = { IG_LIMBO },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_LIMBO_CONTINUE

	[IC_WARNING_DIALOGSTEP] =
	{
		["comment"] = "IC_WARNING_DIALOGSTEP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_WARNING_DIALOGSTEP
	[IC_WARNING_MISSIONINFOSTEP] =
	{
		["comment"] = "IC_WARNING_MISSIONINFOSTEP",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_WARNING_MISSIONINFOSTEP

	[IC_REPAIR] =
	{
		["comment"] = "IC_REPAIR",
		["groups"] = { IG_INGAMEALWAYS }, 
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_LEFT) }, },
		}),
	}, -- IC_REPAIR

	[IC_REPAIR_H] =
	{
		["comment"] = "IC_REPAIR_H",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_REPAIR_H
	[IC_REPAIR_V] =
	{
		["comment"] = "IC_REPAIR_V",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, },
		}),
	}, --IC_REPAIR_V
	
	[IC_REPAIR_MOUSE_H] =
	{
		["comment"] = "IC_REPAIR_MOUSE_H",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_X }, },

		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	}, --IC_REPAIR_MOUSE_H
	
	[IC_REPAIR_MOUSE_V] =
	{
		["comment"] = "IC_REPAIR_MOUSE_V",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_Y }, },
		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
		}),
	}, --IC_REPAIR_MOUSE_V
	
	[IC_REPAIR_KEYBOARD_H] =
	{
		["comment"] = "IC_REPAIR_KEYBOARD_H",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		},
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		}),
	}, --IC_REPAIR_KEYBOARD_H
	
	[IC_REPAIR_KEYBOARD_V] =
	{
		["comment"] = "IC_REPAIR_KEYBOARD_V",
		["groups"] = { IG_REPAIR },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		},
		{
			--{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		}),
	}, --IC_REPAIR_KEYBOARD_V

	
	
	[IC_SM_PRIMARY] =
	{
		["comment"] = "IC_SM_PRIMARY",
		["groups"] = { IG_INGAMEALWAYS },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, -- IC_SM_PRIMARY
	
	[IC_SM_SECONDARY] =
	{
		["comment"] = "IC_SM_SECONDARY",
		["groups"] = { IG_INGAMEALWAYS },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_LEFT }, },
		}),
	}, -- IC_SM_SECONDARY
	
	[IC_SM_GROUPED] =
	{
		["comment"] = "IC_SM_GROUPED",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_X }, },
		}),
	}, -- IC_SM_GROUPED
	
	[IC_SM_CHANGE_WEAPON] =
	{
		["comment"] = "IC_SM_CHANGE_WEAPON",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	}, -- IC_SM_CHANGE_WEAPON
	
	[IC_SM_JUMP_IN] =
	{
		["comment"] = "IC_SM_JUMP_IN",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	}, -- IC_SM_JUMP_IN
	
	[IC_SM_LAND] =
	{
		["comment"] = "IC_SM_LAND",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_X }, },
		}),
	}, -- IC_SM_LAND
	
	[IC_SM_CAP] =
	{
		["comment"] = "IC_SM_CAP",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	}, -- IC_SM_CAP
	
	[IC_SM_ATTACK] =
	{
		["comment"] = "IC_SM_ATTACK",
		["groups"] = { IG_INGAMEALWAYS },
		["helper"] = true,
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, -- IC_SM_ATTACK
	
	[IC_SM_MENU_FIRST_LEVEL] =
	{
		["comment"] = "IC_SM_MENU_FIRST_LEVEL",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] =
		{
		},
	}, -- IC_SM_MENU_FIRST_LEVEL

	[IC_POWERUPS_TOGGLE] =
	{
		["comment"] = "IC_POWERUPS_TOGGLE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_RIGHT }, },
		}),
	}, -- IC_POWERUPS_TOGGLE

	[IC_PING_NORMAL] =
	{
		["comment"] = "IC_PING_NORMAL",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			--{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(BUTTON_STICK_RIGHT) }, },
		}),
	},
	[IC_PING_ATTACK] =
	{
		["comment"] = "IC_PING_ATTACK",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = {},
	},
	[IC_PING_DEFEND] =
	{
		["comment"] = "IC_PING_DEFEND",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = {},
	},

	[IC_OVERLAY_GREEN] =
	{
		["comment"] = "IC_OVERLAY_GREEN",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BUMPER_LEFT }, },
		}),

	}, --IC_OVERLAY_GREEN
	
	[IC_OVERLAY_RED] =
	{
		["comment"] = "IC_OVERLAY_RED",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] =
		{
		},
	}, --IC_OVERLAY_RED
	[IC_OVERLAY_BLUE] =
	{
		["comment"] = "IC_OVERLAY_BLUE",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_X }, },
		}),
	}, --IC_OVERLAY_BLUE
	[IC_OVERLAY_YELLOW] =
	{
		["comment"] = "IC_OVERLAY_YELLOW",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] =
		{
		},
	}, --IC_OVERLAY_YELLOW

	[IC_OVERLAY_H] = 
	{
		["comment"] = "IC_OVERLAY_H",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_X }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
		}),
	},

	[IC_OVERLAY_V] = 
	{
		["comment"] = "IC_OVERLAY_V",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			--{ ["press"] = { IDT_MOUSE, MC_AXIS_Y }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
		}),
	},

	[IC_GAMEMENU_LEFT] =
	{
		["comment"] = "IC_GAMEMENU_LEFT",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, ["mul"] = -1, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, ["mul"] = -1, },
		}),
	}, --IC_GAMEMENU_LEFT
	[IC_GAMEMENU_RIGHT] =
	{
		["comment"] = "IC_GAMEMENU_RIGHT",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_X) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_X) }, },
		}),
	}, --IC_GAMEMENU_RIGHT
	[IC_GAMEMENU_UP] =
	{
		["comment"] = "IC_GAMEMENU_UP",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, ["mul"] = -1, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, ["mul"] = -1, },
		}),
	}, --IC_GAMEMENU_UP
	[IC_GAMEMENU_DOWN] =
	{
		["comment"] = "IC_GAMEMENU_DOWN",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_LEFT_Y) }, },
			{ ["press"] = { IDT_GAMECONTROLLER, SwapStick(AXIS_STICK_RIGHT_Y) }, },
		}),
	}, --IC_GAMEMENU_DOWN
	[IC_DPMENU_LEFT] =
	{
		["comment"] = "IC_DPMENU_LEFT",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_LEFT }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_LEFT }, },
		}),
	}, --IC_DPMENU_LEFT
	[IC_DPMENU_RIGHT] =
	{
		["comment"] = "IC_DPMENU_RIGHT",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RIGHT }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_RIGHT }, },
		}),
	}, --IC_DPMENU_RIGHT
	[IC_DPMENU_UP] =
	{
		["comment"] = "IC_DPMENU_UP",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_UP }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_UP }, },
		}),
	}, --IC_DPMENU_UP
	[IC_DPMENU_DOWN] =
	{
		["comment"] = "IC_DPMENU_DOWN",
		["groups"] = { IG_INGAMEALWAYS },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_DOWN }, },
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_DP_DOWN }, },
		}),
	}, --IC_DPMENU_DOWN

	[IC_DIALOGBOX_RESTART] =
	{
		["comment"] = "IC_DIALOGBOX_RESTART",
		["groups"] = { IG_DIALOGBOX },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_Y }, },
		}),
	}, --IC_DIALOGBOX_RESTART
	[IC_DIALOGBOX_YES] =
	{
		["comment"] = "IC_DIALOGBOX_YES",
		["groups"] = { IG_DIALOGBOX },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
		}),
	}, --IC_DIALOGBOX_YES
	[IC_DIALOGBOX_NO] =
	{
		["comment"] = "IC_DIALOGBOX_NO",
		["groups"] = { IG_DIALOGBOX },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BACK }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	}, --IC_DIALOGBOX_NO
	[IC_DIALOGBOX_ACCEPT] =
	{
		["comment"] = "IC_DIALOGBOX_ACCEPT",
		["groups"] = { IG_DIALOGBOX },
		["inputs"] = PlatformCompatibility(
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
		},
		{
			{ ["press"] = { IDT_KEYBOARD, KC_RETURN }, },
			{ ["press"] = { IDT_KEYBOARD, KC_NUMPADENTER }, },
			{ ["press"] = { IDT_KEYBOARD, KC_ESCAPE }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_START }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_A }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_BACK }, },
			{ ["press"] = { IDT_GAMECONTROLLER, BUTTON_B }, },
		}),
	}, --IC_DIALOGBOX_ACCEPT

	[IC_TOGGLECHAT_PC] =
	{
		["comment"] = "IC_TOGGLECHAT_PC",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_TOGGLECHAT_PC

	--[[[IC_TEMP_HACK_1] =
	{
		["comment"] = "IC_TEMP_HACK_1",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
		},
	}, --IC_TEMP_HACK_1
	[IC_TEMP_HACK_2] =
	{
		["comment"] = "IC_TEMP_HACK_2",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_2 }, },
		},
	}, --IC_TEMP_HACK_2
	[IC_TEMP_HACK_3] =
	{
		["comment"] = "IC_TEMP_HACK_3",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_3 }, },
		},
	}, --IC_TEMP_HACK_3
	[IC_TEMP_HACK_4] =
	{
		["comment"] = "IC_TEMP_HACK_4",
		["groups"] = { IG_ALWAYS },
		["inputs"] =
		{
			{ ["press"] = { IDT_KEYBOARD, KC_4 }, },
		},
	}, --IC_TEMP_HACK_4]]

	---- NEW COMMANDS ----
	
	-- LAUNCH SMOKESCREEN
	[IC_CONSOLE_ONOFF] =
	{
		["comment"] = "SMOKESCREEN",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	
	-- BSM CLASSIC
	[MP_LAUNCH_ABSTOCK_1] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_1",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_2] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_2",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_3] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_3",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_4] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_4",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_5] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_5",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_6] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_6",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_7] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_7",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},
	[MP_LAUNCH_ABSTOCK_8] =
	{
		["comment"] = "MP_LAUNCH_ABSTOCK_8",
		["groups"] = { IG_SHIP },
		["inputs"] = PlatformCompatibility(
		{
		},
		{
		}),
	},

}

-------------------------------------------------
--Input-modositok
-------------------------------------------------

InputModifiers =
{
	["SwapStickPairs"] =
	{
		{ AXIS_STICK_LEFT_X, AXIS_STICK_RIGHT_X },
		{ AXIS_STICK_LEFT_Y, AXIS_STICK_RIGHT_Y },
		{ BUTTON_STICK_LEFT, BUTTON_STICK_RIGHT },
	},
	["SwapStickGeneral"] =
	{
		IC_GENCAM_H,
		IC_GENCAM_V,
		IC_SHIP_THRUST,
		IC_SHIP_STEER,
		IC_SHIP_TURBO,
		IC_PLANE_LOOKH,
		IC_PLANE_LOOKV,
		IC_PLANE_POWER,
		IC_PLANE_TURBO,
		IC_PLANE_YAW,
		IC_PLANE_ROLL,
		IC_PLANE_PITCH,
		IC_BOMBER_ROLL,
		IC_BOMBER_PITCH,
		IC_FORM_SELECT,
		IC_FORM_H,
		IC_FORM_V,
		IC_FORM_H_UNIT_PC,
		IC_FORM_V_UNIT_PC,
		IC_ZOOM_ROLE_SWITCH,
		IC_ZOOM_PC_TRICK,
		IC_REPAIR,
		IC_REPAIR_H,
		IC_REPAIR_V,
		IC_REPAIR_MOUSE_H,
		IC_REPAIR_MOUSE_V,
		IC_OVERLAY_H,
		IC_OVERLAY_V,
	},
	["SwapStickMap"] =
	{
		IC_MAP_PANNING_LEFT_RIGHT,
		IC_MAP_CLOSEST_H,
		IC_MAP_PANNING_UP_DOWN,
		IC_MAP_CLOSEST_V,
	},
	["InvertCameraY"] =
	{
		IC_GENCAM_V,
		IC_BOMBER_PITCH,
	},
	["InvertPlaneY"] =
	{
		IC_PLANE_PITCH,
		IC_PLANE_PITCH_MOUSE,
	},
}
