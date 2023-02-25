--SceneFile="universe\Scenes\draven\keyboard.scn"
DoFile("scripts/datatables/inputs.lua")
Inputs = nil

KSST_KEYBOARD_SENSITIVITY = 0
KSST_MOUSE_SENSITIVITY = 1
KSST_CONTROLLER_SENSITIVITY = 2
KSST_MOUSE_INVERT = 3
KSST_CONTROLLER_INVERT = 4

MC_BUTTON_00 = 0
MC_BUTTON_01 = 1
MC_BUTTON_02 = 2
MC_BUTTON_03 = 3
MC_BUTTON_04 = 4
MC_BUTTON_05 = 5
MC_BUTTON_06 = 6
MC_BUTTON_07 = 7

MC_AXIS_00 = 8
MC_AXIS_01 = 9
MC_AXIS_02 = 10
MC_AXIS_03 = 11
MC_AXIS_04 = 12
MC_AXIS_05 = 13
MC_AXIS_06 = 14
MC_AXIS_07 = 15

KeyboardSetup =
{
	{
		["Name"] = "FE_pc.cs_air",
		["Inputs"] =
		{
			"FE_pc.cs_pilotmodeplanecontrol",
			{ "FE_pc.cs_pitchup", { IC_PLANE_PITCH_MOUSE, IC_PLANE_PITCH, }, },
			{ "FE_pc.cs_pitchdown", { IC_PLANE_PITCH_MOUSE, IC_PLANE_PITCH}, },
			{ "FE_pc.cs_rollleft", { IC_PLANE_ROLL_MOUSE, IC_PLANE_ROLL, }, },
			{ "FE_pc.cs_rollright", { IC_PLANE_ROLL_MOUSE, IC_PLANE_ROLL, }, },
			{ "FE_pc.cs_speedup", { IC_PLANE_POWER, }, },
			{ "FE_pc.cs_slowdown", { IC_PLANE_POWER, }, },
			{ "FE_pc.cs_turbo", { IC_PLANE_TURBO, }, },
			{ "FE_pc.cs_rudderleft", { IC_PLANE_YAW, }, },
			{ "FE_pc.cs_rudderright", { IC_PLANE_YAW, }, },
			{ "FE_pc.cs_fire", { IC_PLANE_FIRE, IC_PLANE_BOMBFIRE, }, },
			{ "FE_pc.cs_bombmode", { IC_PLANE_BOMBSWITCH, }, },
			{ "FE_pc.cs_togglezoomaamode", { IC_ZOOM_ROLE_SWITCH, }, },
			{ "FE_pc.cs_mouselook", { IC_PLANE_LOOKMODE, }, },
			"",
			"FE_pc.cs_mouselookcontrol",
			{ "FE_pc.cs_mouselookup", { IC_PLANE_LOOKV, IC_PLANE_LOOKV_MOUSE, }, },
			{ "FE_pc.cs_mouselookdown", { IC_PLANE_LOOKV, IC_PLANE_LOOKV_MOUSE, }, },
			{ "FE_pc.cs_mouselookleft", { IC_PLANE_LOOKH, IC_PLANE_LOOKH_MOUSE, }, },
			{ "FE_pc.cs_mouselookright", { IC_PLANE_LOOKH, IC_PLANE_LOOKH_MOUSE, }, },
			"",
			"FE_pc.cs_aamodeplanecontrol",
			{ "FE_pc.cs_aapitchup", { IC_BOMBER_PITCH, }, },
			{ "FE_pc.cs_aapitchdown", { IC_BOMBER_PITCH, }, },
			{ "FE_pc.cs_aarollleft", { IC_BOMBER_ROLL, }, },
			{ "FE_pc.cs_aarollright", { IC_BOMBER_ROLL, }, },
		},
		["Sensitivities"] =
		{
			{ "FE_pc.cs_keysens", KSST_KEYBOARD_SENSITIVITY, { IC_PLANE_PITCH, IC_PLANE_ROLL, IC_PLANE_YAW, IC_PLANE_POWER, IC_PLANE_LOOKV, IC_PLANE_LOOKH, IC_BOMBER_PITCH, IC_BOMBER_ROLL, }, },
			{ "FE_pc.cs_mousesens", KSST_MOUSE_SENSITIVITY, { IC_PLANE_PITCH_MOUSE, IC_PLANE_ROLL_MOUSE, IC_PLANE_YAW, IC_PLANE_POWER, IC_PLANE_LOOKV_MOUSE, IC_PLANE_LOOKH_MOUSE, IC_BOMBER_PITCH, IC_BOMBER_ROLL, }, },
			{ "FE_pc.cs_contsens", KSST_CONTROLLER_SENSITIVITY, { IC_PLANE_PITCH, IC_PLANE_ROLL, IC_PLANE_YAW, IC_PLANE_POWER, IC_PLANE_LOOKV, IC_PLANE_LOOKH, IC_BOMBER_PITCH, IC_BOMBER_ROLL, }, },
			{ "FE_pc.cs_invertmouseplaney", KSST_MOUSE_INVERT, { IC_PLANE_PITCH_MOUSE, IC_BOMBER_PITCH, }, },
			{ "FE_pc.cs_invertcontplaney", KSST_CONTROLLER_INVERT, { IC_PLANE_PITCH, IC_BOMBER_PITCH, }, },
		},
		["BaseSensitivities"] =
		{
			[IC_PLANE_PITCH] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_PLANE_PITCH_MOUSE] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1.0, [IDT_GAMECONTROLLER] = 0, },
			[IC_PLANE_ROLL] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_PLANE_ROLL_MOUSE] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1.0, [IDT_GAMECONTROLLER] = 0, },
			[IC_PLANE_POWER] = { [IDT_KEYBOARD] = 2, [IDT_MOUSE] = 2, [IDT_GAMECONTROLLER] = 2, },
			[IC_PLANE_YAW] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 1, },
			[IC_BOMBER_ROLL] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 1, },
			[IC_BOMBER_PITCH] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 1, },
			[IC_PLANE_LOOKV] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_PLANE_LOOKV_MOUSE] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 0, },
			[IC_PLANE_LOOKH] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_PLANE_LOOKH_MOUSE] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 0, },
		},
		["AxisPairs"] =
		{
			{ "FE_pc.cs_pitchup", "FE_pc.cs_pitchdown" },
			{ "FE_pc.cs_rollright", "FE_pc.cs_rollleft" },
			{ "FE_pc.cs_slowdown", "FE_pc.cs_speedup" },
			{ "FE_pc.cs_rudderright", "FE_pc.cs_rudderleft" },
			{ "FE_pc.cs_mouselookup", "FE_pc.cs_mouselookdown" },
			{ "FE_pc.cs_mouselookright", "FE_pc.cs_mouselookleft" },
			{ "FE_pc.cs_aarollright", "FE_pc.cs_aarollleft" },
			{ "FE_pc.cs_aapitchup", "FE_pc.cs_aapitchdown" },
		},
		["Min1SensHacks"] =
		{
			IC_PLANE_LOOKV,
			IC_PLANE_LOOKV_MOUSE,
			IC_PLANE_LOOKH,
			IC_PLANE_LOOKH_MOUSE,
		},
	},
	{
		["Name"] = "FE_pc.cs_sealandaa",
		["Inputs"] =
		{
			"FE_pc.cs_guncontrol",
			{ "FE_pc.cs_lookup", { IC_GENCAM_V, }, },
			{ "FE_pc.cs_lookdown", { IC_GENCAM_V, }, },
			{ "FE_pc.cs_lookleft", { IC_GENCAM_H, }, },
			{ "FE_pc.cs_lookright", { IC_GENCAM_H, }, },
			{ "FE_pc.cs_zoomtoggle", { IC_ZOOM_PC_TRICK, }, },
			{ "FE_pc.cs_zoomin", { IC_GENCAM_ZOOM, }, },
			{ "FE_pc.cs_zoomout", { IC_GENCAM_ZOOM, }, },
			{ "FE_pc.cs_fire", { IC_GUN_FIRE, }, },
			"",
			"FE_pc.cs_shipcontrol",
			{ "FE_pc.cs_speedup", { IC_SHIP_THRUST, }, },
			{ "FE_pc.cs_slowdownreverse", { IC_SHIP_THRUST, }, },
			{ "FE_pc.cs_steerleft", { IC_SHIP_STEER, }, },
			{ "FE_pc.cs_steerright", { IC_SHIP_STEER, }, },
			{ "FE_pc.cs_repair", { IC_REPAIR, }, },
			{ "FE_pc.cs_launchcarriedunits", { IC_SHIP_LAUNCHUNIT, IC_SHIP_LAUNCHLANDINGSHIPS, }, },
			"",
			"FE_pc.cs_submarinecontrol",
			{ "FE_pc.cs_emerge", { IC_SUB_RISE, }, },
			{ "FE_pc.cs_dive", { IC_SUB_DIP, }, },
			"",
			"FE_pc.cs_weaponcontrol",
			{ "FE_pc.cs_waa", { IC_GUNC_AAFLAK, }, },
			{ "FE_pc.cs_wartillery", { IC_GUNC_ARTILLERY, }, },
			{ "FE_pc.cs_wtorpedo", { IC_GUNC_TORPEDO, }, },
			{ "FE_pc.cs_wdc", { IC_GUNC_DEPTHCHARGE, }, },
			{ "FE_pc.cs_nextweapon", { IC_GUNC_CHANGE, }, },
			{ "FE_pc.cs_prevweapon", { IC_GUNC_CHANGE, }, },
			{ "Launch a Smokescreen (Realistic Mode)", { IC_CONSOLE_ONOFF, }, },
		},
		["Sensitivities"] =
		{
			{ "FE_pc.cs_keysens", KSST_KEYBOARD_SENSITIVITY, { IC_GENCAM_H, IC_GENCAM_V, IC_SHIP_THRUST, IC_SHIP_STEER, IC_GENCAM_ZOOM, }, },
			{ "FE_pc.cs_mousesens", KSST_MOUSE_SENSITIVITY, { IC_GENCAM_H, IC_GENCAM_V, IC_SHIP_THRUST, IC_SHIP_STEER, IC_GENCAM_ZOOM, }, },
			{ "FE_pc.cs_contsens", KSST_CONTROLLER_SENSITIVITY, { IC_GENCAM_H, IC_GENCAM_V, IC_SHIP_THRUST, IC_SHIP_STEER, IC_GENCAM_ZOOM, }, },
			{ "FE_pc.cs_invertmouseshipy", KSST_MOUSE_INVERT, { IC_GENCAM_V, }, },
			{ "FE_pc.cs_invertcontshipy", KSST_CONTROLLER_INVERT, { IC_GENCAM_V, }, },
		},
		["BaseSensitivities"] =
		{
			[IC_GENCAM_H] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 3, [IDT_GAMECONTROLLER] = 1, },
			[IC_GENCAM_V] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 3, [IDT_GAMECONTROLLER] = 1, },
			[IC_ZOOM_PC_TRICK] = { [IDT_KEYBOARD] = 2, [IDT_MOUSE] = 2, [IDT_GAMECONTROLLER] = 2, },
			[IC_GENCAM_ZOOM] = { [IDT_KEYBOARD] = 2, [IDT_MOUSE] = 2, [IDT_GAMECONTROLLER] = 2, },
			[IC_SHIP_THRUST] = { [IDT_KEYBOARD] = 2, [IDT_MOUSE] = 2, [IDT_GAMECONTROLLER] = 2, },
			[IC_SHIP_STEER] = { [IDT_KEYBOARD] = 2, [IDT_MOUSE] = 2, [IDT_GAMECONTROLLER] = 2, },
		},
		["AxisPairs"] =
		{
			{ "FE_pc.cs_lookup", "FE_pc.cs_lookdown" },
			{ "FE_pc.cs_lookright", "FE_pc.cs_lookleft" },
			{ "FE_pc.cs_slowdownreverse", "FE_pc.cs_speedup" },
			{ "FE_pc.cs_steerright", "FE_pc.cs_steerleft" },
			{ "FE_pc.cs_dive", "FE_pc.cs_emerge" },
			{ "FE_pc.cs_nextweapon", "FE_pc.cs_prevweapon" },
			{ "FE_pc.cs_zoomout", "FE_pc.cs_zoomin" },
		},
	},
	{
		["Name"] = "FE_pc.cs_command",
		["Inputs"] =
		{
			"FE_pc.cs_selection",
			{ "FE_pc.cs_previousunit", { IC_SEL_ABOVE_ITEM, IC_FORM_PREV, }, },
			{ "FE_pc.cs_nextunit", { IC_SEL_BELOW_ITEM, IC_FORM_NEXT, }, },
			{ "FE_pc.cs_previousformation", { IC_SEL_PREV_ITEM, }, },
			{ "FE_pc.cs_nextformation", { IC_SEL_NEXT_ITEM, }, },
			"",
			"FE_pc.cs_command",
			{ "FE_pc.cs_commandmenu", { IC_OVERLAY_BLUE, }, },
			{ "FE_pc.cs_showmap", { IC_MAP_TOGGLE, }, },
			{ "FE_pc.cs_pause", { IC_PAUSE, }, },
			"",
			"FE_pc.cs_multiplayer",
			{ "FE_pc.cs_chat", { IC_TOGGLECHAT_PC, }, },
			{ "FE_pc.cs_lobbyready", { IC_LOBBY_READY, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 1", { MP_LAUNCH_ABSTOCK_1, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 2", { MP_LAUNCH_ABSTOCK_2, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 3", { MP_LAUNCH_ABSTOCK_3, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 4", { MP_LAUNCH_ABSTOCK_4, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 5", { MP_LAUNCH_ABSTOCK_5, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 6", { MP_LAUNCH_ABSTOCK_6, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 7", { MP_LAUNCH_ABSTOCK_7, }, },
			{ "BSM CLASSIC - Launch Airbase Stock 8", { MP_LAUNCH_ABSTOCK_8, }, },
			"",
			"FE_pc.cs_ingamemenucontrol",
			{ "FE_pc.cs_menuup", { IC_MENU_UP, IC_GAMEMENU_UP, IC_DPMENU_UP, IC_AIRBASE_PREV, IC_CHEAT_UP, }, },
			{ "FE_pc.cs_menudown", { IC_MENU_DOWN, IC_GAMEMENU_DOWN, IC_DPMENU_DOWN, IC_AIRBASE_NEXT, IC_CHEAT_DOWN, }, },
			{ "FE_pc.cs_menuleft", { IC_MENU_LEFT, IC_GAMEMENU_LEFT, IC_DPMENU_LEFT, IC_AIRBASE_REMOVE, IC_CHEAT_LEFT, }, },
			{ "FE_pc.cs_menuright", { IC_MENU_RIGHT, IC_GAMEMENU_RIGHT, IC_DPMENU_RIGHT, IC_AIRBASE_ADD, IC_CHEAT_RIGHT, }, },
			{ "FE_pc.cs_apply", { IC_MENU_SELECT, IC_ORDERS_OK, IC_FORM_OK, IC_CHEAT_SELECT, IC_ENDMOVIEPLAY, IC_LIMBO_CONTINUE }, },
			{ "FE_pc.cs_back", { IC_MENU_BACK, IC_CHEAT_BACK}, },
			"",
			"FE_pc.cs_ingameoverlaycontrol",
			{ "FE_pc.cs_overlayup", { IC_REPAIR_V, IC_REPAIR_MOUSE_V, IC_REPAIR_KEYBOARD_V, IC_OVERLAY_V }, },
			{ "FE_pc.cs_overlaydown", { IC_REPAIR_V, IC_REPAIR_MOUSE_V, IC_REPAIR_KEYBOARD_V, IC_OVERLAY_V }, },
			{ "FE_pc.cs_overlayleft", { IC_REPAIR_H, IC_REPAIR_MOUSE_H, IC_REPAIR_KEYBOARD_H, IC_OVERLAY_H }, },
			{ "FE_pc.cs_overlayright", { IC_REPAIR_H, IC_REPAIR_MOUSE_H, IC_REPAIR_KEYBOARD_H, IC_OVERLAY_H }, },
			"",
			"FE_pc.cs_ingameunitcontrol",
			{ "FE_pc.cs_jumpin", { IC_CMD_JUMPIN, IC_AIRBASE_JUMPIN, }, },
			{ "FE_pc.cs_targetjoin", { IC_CMD_SETTARGET, }, },
			{ "FE_pc.cs_cleartarget", { IC_CMD_CLEARTARGET, }, },
			"",
			"FE_pc.cs_supportmanager",
			{ "FE_pc.cs_secondary_target", { IC_SM_SECONDARY, }, },
			{ "FE_pc.cs_launch", { IC_SM_ATTACK, }, },
			{ "FE_pc.cs_change_weapon", { IC_SM_CHANGE_WEAPON, }, },
			{ "FE_pc.cs_jump_in", { IC_SM_JUMP_IN, }, },
			{ "FE_pc.cs_land", { IC_SM_LAND, }, },
			"",
			{ "FE_pc.cs_powerups_toggle", { IC_POWERUPS_TOGGLE, }, },
			"",
			"FE_pc.cs_mapcontrol",
			{ "FE_pc.cs_cursorup", { IC_FORM_V, IC_MAP_VSCROLL, IC_FORM_V_UNIT_PC, }, },
			{ "FE_pc.cs_cursordown", { IC_FORM_V, IC_MAP_VSCROLL, IC_FORM_V_UNIT_PC, }, },
			{ "FE_pc.cs_cursorleft", { IC_FORM_H, IC_MAP_HSCROLL, IC_FORM_H_UNIT_PC, }, },
			{ "FE_pc.cs_cursorright", { IC_FORM_H, IC_MAP_HSCROLL, IC_FORM_H_UNIT_PC, }, },
			{ "FE_pc.cs_panup", { IC_MAP_PANNING_UP_DOWN, }, },
			{ "FE_pc.cs_pandown", { IC_MAP_PANNING_UP_DOWN, }, },
			{ "FE_pc.cs_panleft", { IC_MAP_PANNING_LEFT_RIGHT, }, },
			{ "FE_pc.cs_panright", { IC_MAP_PANNING_LEFT_RIGHT, }, },
			{ "FE_pc.cs_closestup", { IC_MAP_CLOSEST_V, }, },
			{ "FE_pc.cs_closestdown", { IC_MAP_CLOSEST_V, }, },
			{ "FE_pc.cs_closestleft", { IC_MAP_CLOSEST_H, }, },
			{ "FE_pc.cs_closestright", { IC_MAP_CLOSEST_H, }, },
			{ "FE_pc.cs_mapzoomin", { IC_MAP_ZOOM, }, },
			{ "FE_pc.cs_mapzoomout", { IC_MAP_ZOOM, }, },
			{ "FE_pc.cs_mapjumpin", { IC_CMD_MAP_JUMPIN, IC_FORM_SELECT, }, },
			{ "FE_pc.cs_maptargetjoin", { IC_CMD_MAP_TARGET, IC_CMD_MAP_MOVE, IC_CMD_MAP_JOIN, }, },
			{ "FE_pc.cs_mapcleartarget", { IC_CMD_MAP_CLEARTARGET, }, },
			{ "FE_pc.cs_maptoggleobjectives", { IC_MAP_OBJECTIVES, }, },
			{ "FE_pc.cs_mapfilter", { IC_MAP_FILTER, }, },
		},
		["Sensitivities"] =
		{
			{ "FE_pc.cs_mousesens", KSST_MOUSE_SENSITIVITY, { IC_MAP_HSCROLL, IC_MAP_VSCROLL, IC_FORM_H, IC_FORM_V }, },
			{ "FE_pc.cs_keysens", KSST_KEYBOARD_SENSITIVITY, { IC_MAP_HSCROLL, IC_MAP_VSCROLL, IC_FORM_H, IC_FORM_V }, },
			{ "FE_pc.cs_contsens", KSST_CONTROLLER_SENSITIVITY, { IC_MAP_HSCROLL, IC_MAP_VSCROLL, IC_FORM_H, IC_FORM_V }, },
		},
		["BaseSensitivities"] =
		{
			[IC_MAP_HSCROLL] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 1, },
			[IC_MAP_VSCROLL] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 1, },
			[IC_FORM_H] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 0, },
			[IC_FORM_V] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 0, },
			[IC_FORM_H_UNIT_PC] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_FORM_V_UNIT_PC] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_MAP_ZOOM] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 1, },
			[IC_REPAIR_KEYBOARD_H] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 0, },
			[IC_REPAIR_KEYBOARD_V] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 0, },
			[IC_REPAIR_MOUSE_H] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 0, },
			[IC_REPAIR_MOUSE_V] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 1, [IDT_GAMECONTROLLER] = 0, },
			[IC_REPAIR_H] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
			[IC_REPAIR_V] = { [IDT_KEYBOARD] = 0, [IDT_MOUSE] = 0, [IDT_GAMECONTROLLER] = 1, },
		},
		["AxisPairs"] =
		{
			{ "FE_pc.cs_nextformation", "FE_pc.cs_previousformation" },
			{ "FE_pc.cs_nextunit", "FE_pc.cs_previousunit" },
			{ "FE_pc.cs_menudown", "FE_pc.cs_menuup" },
			{ "FE_pc.cs_menuleft", "FE_pc.cs_menuright" },
			{ "FE_pc.cs_cursordown", "FE_pc.cs_cursorup" },
			{ "FE_pc.cs_cursorright", "FE_pc.cs_cursorleft" },
			{ "FE_pc.cs_overlaydown", "FE_pc.cs_overlayup" },
			{ "FE_pc.cs_overlayright", "FE_pc.cs_overlayleft" },
			{ "FE_pc.cs_mapzoomout", "FE_pc.cs_mapzoomin" },
			{ "FE_pc.cs_pandown", "FE_pc.cs_panup" },
			{ "FE_pc.cs_panright", "FE_pc.cs_panleft" },
			{ "FE_pc.cs_closestdown", "FE_pc.cs_closestup" },
			{ "FE_pc.cs_closestright", "FE_pc.cs_closestleft" },
		},
	},
	{
		["Name"] = "DevInputs",
		["Inputs"] =
		{
			"Debug",
			--{ "Console", { IC_CONSOLE_ONOFF, }, },
			{ "Unlock All", { IC_CHEAT_UNLOCKALL, }, },
			{ "Cheat Menu", { IC_CHEAT_MENU, }, },
			{ "Quit", { IC_CHEAT_QUIT, }, },
			{ "End Scene", { IC_CHEAT_ENDSCENE, }, },
			{ "Game Speed x0.5", { IC_CHEAT_SLOW, }, },
			{ "Game Speed x2", { IC_CHEAT_FAST, }, },
			{ "Game Speed x4", { IC_CHEAT_VERYFAST, }, },
			{ "Pause Step", { IC_CHEAT_PAUSESTEP, }, },
			{ "Change Party", { IC_CHEAT_NEXTPARTY, }, },
			{ "AllocLog", { IC_CHEAT_ALLOCLOG, }, },
			{ "Kill Unit", { IC_CHEAT_KILL, }, },
			{ "Look", { IC_CHEAT_LOOK, }, },
			{ "Wire Ocean", { IC_CHEAT_WIREOCEAN, }, },
			{ "AI Debug", { IC_CHEAT_AIDEBUG, }, },
			{ "Attis1", { IC_CHEAT_ATTIS1, }, },
			{ "Attis2", { IC_CHEAT_ATTIS2, }, },
			{ "Render GeomMesh", { IC_CHEAT_RENDERGEOMMESH, }, },
			{ "No Fire", { IC_CHEAT_NOFIRE, }, },
			{ "Capture", { IC_CHEAT_CAPTURE, }, },
			{ "Save Test", { IC_CHEAT_SAVETEST, }, },
			{ "Page Up", { IC_CHEAT_PGUP, }, },
			{ "Page Down", { IC_CHEAT_PGDOWN, }, },
			{ "Skip Dialog", { IC_WARNING_DIALOGSTEP, }, },
			{ "Skip Narrative", { IC_WARNING_MISSIONINFOSTEP, }, },
			{ "FOV Up", { IC_CHEAT_FOV_DOWN, }, },
			{ "FOV Down", { IC_CHEAT_FOV_UP, }, },
			{ "Camp.Map Zoom In", { IC_CAMPAIGN_MAP_ZOOM_IN, }, },
			{ "Camp.Map Zoom Out", { IC_CAMPAIGN_MAP_ZOOM_OUT, }, },
			{ "Frontend Scroll", { IC_FE_SCROLL, }, },
			{ "Form.Close", { IC_FORM_CLOSE, }, },
			"",
			"Free Camera",
			{ "Free Camera Toggle", { IC_FREECAM_TOGGLE, }, },
			{ "Free Camera Up", { IC_FREECAM_STRAFEUPDOWN, }, },
			{ "Free Camera Down", { IC_FREECAM_STRAFEUPDOWN, }, },
			{ "Free Camera Left", { IC_FREECAM_STRAFELEFTRIGHT, }, },
			{ "Free Camera Right", { IC_FREECAM_STRAFELEFTRIGHT, }, },
			{ "Free Camera Forward", { IC_FREECAM_FORWARD, }, },
			{ "Free Camera Back", { IC_FREECAM_FORWARD, }, },
			{ "Free Camera Turn Up", { IC_FREECAM_TURNUPDOWN, }, },
			{ "Free Camera Turn Down", { IC_FREECAM_TURNUPDOWN, }, },
			{ "Free Camera Turn Left", { IC_FREECAM_TURNLEFTRIGHT, }, },
			{ "Free Camera Turn Right", { IC_FREECAM_TURNLEFTRIGHT, }, },
			{ "Free Camera Act Unit", { IC_FREECAM_ACTUNIT, }, },
			{ "Free Camera Vert to 0", { IC_FREECAM_VERT_TO_ZERO, }, },
			{ "Free Camera to 0", { IC_FREECAM_HORZVERT_TO_ZERO, }, },
			{ "Free Camera Shoot", { IC_FREECAM_SHOOT, }, },
			{ "Free Camera Weapon Change", { IC_FREECAM_GUNSWITCH, }, },
			{ "Free Camera Roll+", { IC_FREECAM_ROLL, }, },
			{ "Free Camera Roll-", { IC_FREECAM_ROLL, }, },
			"",
			"Movie Camera",
			{ "MovCam Toggle", { IC_IF_MOVIECAMERA_TOGGLE, }, },
			{ "MovCam Toggle v2", { IC_IF_MOVIECAMERANEW_TOGGLE, }, },
			{ "MovCam Targeted Mode", { IC_MOVCAM_TARGETEDMODE, }, },
			{ "MovCam Deck Mode", { IC_MOVCAM_DECKMODE, }, },
			{ "MovCam Drop Camera", { IC_MOVCAM_DROPCAMERA, }, },
			{ "MovCam Select Secondary Target", { IC_MOVCAM_SELECTSECONDARYTARGET, }, },
			{ "MovCam Walk Around H", { IC_MOVCAM_WALKAROUNDH, }, },
			{ "MovCam Walk Around V", { IC_MOVCAM_WALKAROUNDV, }, },
			{ "MovCam Turn Around H", { IC_MOVCAM_TURNAROUNDH, }, },
			{ "MovCam Turn Around V", { IC_MOVCAM_TURNAROUNDV, }, },
			{ "MovCam Zoom", { IC_MOVCAM_ZOOM, }, },
			{ "MovCam Editor Mode", { IC_MOVCAM_EDITORMODE, }, },
			{ "MovCam Prev Item", { IC_MOVCAM_PREVITEM, }, },
			{ "MovCam Next Item", { IC_MOVCAM_NEXTITEM, }, },
			{ "MovCam Up Item", { IC_MOVCAM_UPITEM, }, },
			{ "MovCam Down Item", { IC_MOVCAM_DOWNITEM, }, },
		},
		["Sensitivities"] =
		{
		},
		["BaseSensitivities"] =
		{
			[IC_FREECAM_TURNUPDOWN] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 1, },
			[IC_FREECAM_TURNLEFTRIGHT] = { [IDT_KEYBOARD] = 1, [IDT_MOUSE] = 10, [IDT_GAMECONTROLLER] = 1, },
		},
		["AxisPairs"] =
		{
			{ "Free Camera Forward", "Free Camera Back" },
			{ "Free Camera Right", "Free Camera Left" },
			{ "Free Camera Up", "Free Camera Down" },
			{ "Free Camera Turn Right", "Free Camera Turn Left" },
			{ "Free Camera Turn Down", "Free Camera Turn Up" },
			{ "Free Camera Forward", "Free Camera Back" },
			{ "Free Camera Right", "Free Camera Left" },
			{ "Free Camera Up", "Free Camera Down" },
			{ "Free Camera Turn Right", "Free Camera Turn Left" },
			{ "Free Camera Turn Down", "Free Camera Turn Up" },
			{ "Free Camera Roll+", "Free Camera Roll-" },
		},
	},
}

Conflicts = {}

Conflicts["Groups"] =
{
	[1] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_nextformation" },
		{ "FE_pc.cs_command", "FE_pc.cs_previousformation" },
	},
	[2] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_nextunit" },
		{ "FE_pc.cs_command", "FE_pc.cs_previousunit" },
	},
	[3] =
	{
		{ "FE_pc.cs_air", "FE_pc.cs_pitchup" },
		{ "FE_pc.cs_air", "FE_pc.cs_pitchdown" },
		{ "FE_pc.cs_air", "FE_pc.cs_rollleft" },
		{ "FE_pc.cs_air", "FE_pc.cs_rollright" },
		{ "FE_pc.cs_air", "FE_pc.cs_speedup" },
		{ "FE_pc.cs_air", "FE_pc.cs_slowdown" },
		{ "FE_pc.cs_air", "FE_pc.cs_turbo" },
		{ "FE_pc.cs_air", "FE_pc.cs_rudderleft" },
		{ "FE_pc.cs_air", "FE_pc.cs_rudderright" },
		{ "FE_pc.cs_air", "FE_pc.cs_fire" },
		{ "FE_pc.cs_air", "FE_pc.cs_bombmode" },
	},
	[4] =
	{
		{ "FE_pc.cs_air", "FE_pc.cs_mouselook" },
	},
	[5] =
	{
		{ "FE_pc.cs_air", "FE_pc.cs_mouselookup" },
		{ "FE_pc.cs_air", "FE_pc.cs_mouselookdown" },
		{ "FE_pc.cs_air", "FE_pc.cs_mouselookleft" },
		{ "FE_pc.cs_air", "FE_pc.cs_mouselookright" },
	},
	[6] =
	{
		{ "FE_pc.cs_air", "FE_pc.cs_togglezoomaamode" },
	},
	[7] =
	{
		{ "FE_pc.cs_air", "FE_pc.cs_aarollleft" },
		{ "FE_pc.cs_air", "FE_pc.cs_aarollright" },
		{ "FE_pc.cs_air", "FE_pc.cs_aapitchup" },
		{ "FE_pc.cs_air", "FE_pc.cs_aapitchdown" },
	},
	[8] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_lookup" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_lookdown" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_lookleft" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_lookright" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_fire" },
	},
	[9] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_speedup" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_slowdownreverse" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_steerleft" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_steerright" },
	},
	[10] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_dive" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_emerge" },
	},
	[11] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_wartillery" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_waa" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_wtorpedo" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_wdc" },
		--{ "FE_pc.cs_sealandaa", "FE_pc.cs_nextweapon" },
		--{ "FE_pc.cs_sealandaa", "FE_pc.cs_prevweapon" },
	},
	[12] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_menuup" },
		{ "FE_pc.cs_command", "FE_pc.cs_menudown" },
		{ "FE_pc.cs_command", "FE_pc.cs_menuleft" },
		{ "FE_pc.cs_command", "FE_pc.cs_menuright" },
	},
	[13] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_jumpin" },
		--{ "FE_pc.cs_command", "FE_pc.cs_targetjoin" },
		--{ "FE_pc.cs_command", "FE_pc.cs_cleartarget" },
	},
	[14] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_cursorup" },
		{ "FE_pc.cs_command", "FE_pc.cs_cursordown" },
		{ "FE_pc.cs_command", "FE_pc.cs_cursorleft" },
		{ "FE_pc.cs_command", "FE_pc.cs_cursorright" },
	},
	[15] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_mapzoomin" },
		{ "FE_pc.cs_command", "FE_pc.cs_mapzoomout" },
	},
	[16] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_mapjumpin" },
		{ "FE_pc.cs_command", "FE_pc.cs_maptargetjoin" },
		{ "FE_pc.cs_command", "FE_pc.cs_mapcleartarget" },
		{ "FE_pc.cs_command", "FE_pc.cs_mapfilter" },
		--{ "FE_pc.cs_command", "FE_pc.cs_maptoggleobjectives" },
	},
	[17] =
	{
	},
	[18] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_zoomtoggle" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_zoomin" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_zoomout" },
	},
	[19] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_commandmenu" },
		{ "FE_pc.cs_command", "FE_pc.cs_showmap" },
		{ "FE_pc.cs_command", "FE_pc.cs_pause" },
	},
	[20] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_nextweapon" },
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_prevweapon" },
	},
	[21] =
	{
	},
	[22] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_targetjoin" },
		{ "FE_pc.cs_command", "FE_pc.cs_cleartarget" },
	},
	[23] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_apply" },
	},
	[24] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_chat" },
	},
	[25] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_maptoggleobjectives" },
	},
	[26] =
	{
		{ "FE_pc.cs_sealandaa", "FE_pc.cs_repair" },
	},
	[27] =
	{
		{ "FE_pc.cs_command", "FE_pc.cs_back" },
	},
}
Conflicts["Pairs"] =
{
	{ 1, 2 },
	{ 1, 3 },
	{ 1, 4 },
	{ 1, 5 },
	{ 1, 6 },
	{ 1, 7 },
	{ 1, 8 },
	{ 1, 9 },
	{ 1, 10 },
	{ 1, 11 },
	{ 1, 13 },
	{ 1, 14 },
	{ 1, 15 },
	{ 1, 16 },
	{ 1, 17 },
	{ 1, 18 },
	{ 1, 19 },
	{ 2, 8 },
	{ 2, 9 },
	{ 2, 11 },
	{ 2, 13 },
	{ 2, 14 },
	{ 2, 15 },
	{ 2, 16 },
	{ 2, 18 },
	{ 2, 19 },
	{ 3, 4 },
	{ 3, 6 },
	{ 3, 13 },
	{ 3, 19 },
	{ 4, 5 },
	{ 4, 6 },
	{ 4, 13 },
	{ 4, 19 },
	{ 5, 19 },
	{ 6, 7 },
	{ 6, 8 },
	{ 6, 13 },
	{ 6, 19 },
	{ 7, 8 },
	{ 7, 13 },
	{ 7, 19 },
	{ 8, 9 },
	{ 8, 10 },
	{ 8, 11 },
	{ 8, 12 },
	{ 8, 13 },
	{ 8, 18 },
	{ 8, 19 },
	{ 9, 10 },
	{ 9, 11 },
	{ 9, 13 },
	{ 9, 18 },
	{ 9, 19 },
	{ 10, 11 },
	{ 10, 13 },
	{ 10, 18 },
	{ 10, 19 },
	{ 11, 12 },
	{ 11, 13 },
	{ 11, 17 },
	{ 11, 18 },
	{ 11, 19 },
	{ 12, 13 },
	{ 12, 14 },
	{ 12, 15 },
	{ 12, 16 },
	{ 12, 19 },
	{ 13, 14 },
	{ 13, 19 },
	{ 14, 15 },
	{ 14, 16 },
	{ 14, 19 },
	{ 15, 16 },
	{ 15, 19 },
	{ 16, 19 },
	{ 17, 19 },
	{ 17, 21 },
	{ 18, 19 },
	{ 1, 20 },
	{ 2, 20 },
	{ 8, 20 },
	{ 9, 20 },
	{ 10, 20 },
	{ 20, 12 },
	{ 20, 13 },
	{ 20, 17 },
	{ 20, 18 },
	{ 20, 19 },
	{ 1, 21 },
	{ 2, 21 },
	{ 8, 21 },
	{ 9, 21 },
	{ 10, 21 },
	{ 21, 12 },
	{ 21, 13 },
	{ 21, 18 },
	{ 21, 19 },
	{ 11, 20 },
	{ 11, 21 },
	{ 1, 22 },
	{ 2, 22 },
	{ 3, 22 },
	{ 4, 22 },
	{ 6, 22 },
	{ 7, 22 },
	{ 8, 22 },
	{ 9, 22 },
	{ 10, 22 },
	{ 11, 22 },
	{ 12, 22 },
	{ 20, 22 },
	{ 21, 22 },
	{ 22, 19 },
	{ 13, 22 },
	{ 23, 12 },
	{ 23, 19 },
	{ 1, 24 },
	{ 2, 24 },
	{ 3, 24 },
	{ 4, 24 },
	{ 5, 24 },
	{ 6, 24 },
	{ 7, 24 },
	{ 8, 24 },
	{ 9, 24 },
	{ 10, 24 },
	{ 11, 24 },
	{ 12, 24 },
	{ 13, 24 },
	{ 14, 24 },
	{ 15, 24 },
	{ 16, 24 },
	{ 17, 24 },
	{ 18, 24 },
	{ 19, 24 },
	{ 20, 24 },
	{ 21, 24 },
	{ 22, 24 },
	{ 23, 24 },
	{ 1, 25 },
	{ 2, 25 },
	{ 12, 25 },
	{ 14, 25 },
	{ 15, 25 },
	{ 16, 25 },
	{ 19, 25 },
	{ 23, 25 },
	{ 24, 25 },
	{ 1, 26 },
	{ 2, 26 },
	{ 8, 26 },
	{ 9, 26 },
	{ 10, 26 },
	{ 11, 26 },
	{ 12, 26 },
	{ 13, 26 },
	{ 14, 26 },
	{ 15, 26 },
	{ 16, 26 },
	{ 18, 26 },
	{ 19, 26 },
	{ 20, 26 },
	{ 21, 26 },
	{ 22, 26 },
	{ 23, 26 },
	{ 24, 26 },
	{ 25, 26 },
	{ 12, 27 },
	{ 17, 27 },
	{ 18, 27 },
	{ 19, 27 },
	{ 21, 27 },
	{ 23, 27 },
	{ 24, 27 },
	{ 25, 27 },
	{ 26, 27 },
}


InputNames = {}

InputNames["^FE_pc.cs_mousebutton|. 1"] = { IDT_MOUSE, MC_BUTTON_00 }
InputNames["^FE_pc.cs_mousebutton|. 2"] = { IDT_MOUSE, MC_BUTTON_01 }
InputNames["^FE_pc.cs_mousebutton|. 3"] = { IDT_MOUSE, MC_BUTTON_02 }
InputNames["^FE_pc.cs_mousebutton|. 4"] = { IDT_MOUSE, MC_BUTTON_03 }
InputNames["^FE_pc.cs_mousebutton|. 5"] = { IDT_MOUSE, MC_BUTTON_04 }
InputNames["^FE_pc.cs_mousebutton|. 6"] = { IDT_MOUSE, MC_BUTTON_05 }
InputNames["^FE_pc.cs_mousebutton|. 7"] = { IDT_MOUSE, MC_BUTTON_06 }
InputNames["^FE_pc.cs_mousebutton|. 8"] = { IDT_MOUSE, MC_BUTTON_07 }

InputNames["^FE_pc.cs_mouseaxis|. X"] = { IDT_MOUSE, MC_AXIS_00 }
InputNames["^FE_pc.cs_mouseaxis|. Y"] = { IDT_MOUSE, MC_AXIS_01 }
InputNames["^FE_pc.cs_mousewheel"] = { IDT_MOUSE, MC_AXIS_02 }
InputNames["^FE_pc.cs_mouseaxis|. 3"] = { IDT_MOUSE, MC_AXIS_03 }
InputNames["^FE_pc.cs_mouseaxis|. 4"] = { IDT_MOUSE, MC_AXIS_04 }
InputNames["^FE_pc.cs_mouseaxis|. 5"] = { IDT_MOUSE, MC_AXIS_05 }
InputNames["^FE_pc.cs_mouseaxis|. 6"] = { IDT_MOUSE, MC_AXIS_06 }
InputNames["^FE_pc.cs_mouseaxis|. 7"] = { IDT_MOUSE, MC_AXIS_07 }