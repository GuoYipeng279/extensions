-- powerup types
PUT_AIRSUPPORT = 1
PUT_ACTIVE = 2
PUT_PASSIVE = 3

-- powerup target types
PUTT_FRIENDUNIT = 1
PUTT_ENEMYUNIT = 2
PUTT_RANGE = 3
PUTT_PLAYER = 4
PUTT_PARTY = 5

-- powerup target filter flags
PUTFF_NONE = 0
PUTFF_SHIP = 1
PUTFF_SUBMARINE = 2
PUTFF_PLANE = 4
PUTFF_LANDBASED = 8
PUTFF_ALL = PUTFF_SHIP + PUTFF_SUBMARINE + PUTFF_PLANE + PUTFF_LANDBASED -- a "+" itt most a bitenkenti "or" helyett van: aki tudja hogy lehet azt lua-ban leirni, mondja el arpinak
PUTFF_SHIPS_AND_SUBS = PUTFF_SHIP + PUTFF_SUBMARINE

-- powerup effect types
PUET_FIREPOWER = 1
PUET_ARMOR = 2
PUET_SHIP_REPAIR = 3
PUET_SHIP_SPEED = 4
PUET_SHIP_TURNFACTOR = 5
PUET_PLANE_SPEED = 6
PUET_TARGETING_ERROR = 7
PUET_DEVICE_RELOADING = 8
PUET_TURBO_RELOADING = 9
PUET_CAPTURE_POWER = 10
PUET_CAPTURE_RESISTANCE = 11
PUET_RECON = 12
PUET_PLANE_TURN = 13
PUET_TORPEDO_SPEED = 14
PUET_TORPEDO_TURN = 15


PowerupClasses = {
	[PUT_AIRSUPPORT] = {
		["CAP"] = {
			["CAP1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_cap1_name_us",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 96, 
					["unitClassIndex"] = 101,
					["equipmentIndex"] = 0,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_cap1_name_jap",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 99, 
					["unitClassIndex"] = 150,
					["equipmentIndex"] = 0,
				},
				["PUMicon"] =  "common/icons/powerup/CAP_l.tga",
				["cooldown"] = 480,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_PLANE,
			},
			["CAP2"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_cap2_name_us",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 97, 
					["unitClassIndex"] = 133,
					["equipmentIndex"] = 0,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_cap2_name_jap",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 100, 
					["unitClassIndex"] = 154,
					["equipmentIndex"] = 0,
				},
				["PUMicon"] =  "common/icons/powerup/CAP_l.tga",
				["cooldown"] = 480,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_PLANE,
			},
			["CAP3"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_cap3_name_us",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 98, 
					["unitClassIndex"] = 104,
					["equipmentIndex"] = 0,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_cap3_name_jap",
					["description"] = "globals.powerup_airsupport_cap_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/CAP_s.tga",
					["centralIconIndex"] = 101, 
					["unitClassIndex"] = 151,
					["equipmentIndex"] = 0,
				},
				["PUMicon"] =  "common/icons/powerup/CAP_l.tga",
				["cooldown"] = 480,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_PLANE,
			},
		},
		["Light"] = {
			["DCR1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_dc_name_us", -- Dauntless DC Run
					["description"] = "globals.powerup_airsupport_dc_desc",
					["iconIndex"] = 40,
					["mapIconPicture"] = "common/icons/powerup/DC_s.tga",
					["centralIconIndex"] = 107, 
					["unitClassIndex"] = 108,
					["equipmentIndex"] = 2,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_dc_name_jap", -- Judy DC Run
					["description"] = "globals.powerup_airsupport_dc_desc",
					["iconIndex"] = 40,
					["mapIconPicture"] = "common/icons/powerup/DC_s.tga",
					["centralIconIndex"] = 108, 
					["unitClassIndex"] = 159,
					["equipmentIndex"] = 2,
				},
				["PUMicon"] =  "common/icons/powerup/DC_l.tga",
				["cooldown"] = 600,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SUBMARINE,
			},
			["divebomb1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_bomb1_name_us", -- Dauntless Bombing Run
					["description"] = "globals.powerup_airsupport_bomb_desc",
					["iconIndex"] = 41,
					["mapIconPicture"] = "common/icons/powerup/DIVEBOMB_s.tga",
					["centralIconIndex"] = 102, 
					["unitClassIndex"] = 108,
					["equipmentIndex"] = 1,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_bomb1_name_jap", -- Judy Bombing Run
					["description"] = "globals.powerup_airsupport_bomb_desc",
					["iconIndex"] = 41,
					["mapIconPicture"] = "common/icons/powerup/DIVEBOMB_s.tga",
					["centralIconIndex"] = 104, 
					["unitClassIndex"] = 159,
					["equipmentIndex"] = 1,
				},
				["PUMicon"] =  "common/icons/powerup/DIVEBOMB_l.tga",
				["cooldown"] = 300,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_LANDBASED,
			},
		},
		["Medium"] =  {
			["divebomb2"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_bomb2_name_us", -- Helldiver Bomb Run
					["description"] = "globals.powerup_airsupport_bomb_desc",
					["iconIndex"] = 41,
					["mapIconPicture"] = "common/icons/powerup/DIVEBOMB_s.tga",
					["centralIconIndex"] = 103, 
					["unitClassIndex"] = 38,
					["equipmentIndex"] = 1,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_bomb2_name_jap", -- Val Bombing Run
					["description"] = "globals.powerup_airsupport_bomb_desc",
					["iconIndex"] = 41,
					["mapIconPicture"] = "common/icons/powerup/DIVEBOMB_s.tga",
					["centralIconIndex"] = 105, 
					["unitClassIndex"] = 158,
					["equipmentIndex"] = 1,
				},
				["PUMicon"] =  "common/icons/powerup/DIVEBOMB_l.tga",
				["cooldown"] = 300,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_LANDBASED,
			},
			["torpedo1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_torpedo1_name_us", -- Avenger Torpedo Run
					["description"] = "globals.powerup_airsupport_torpedo_desc",
					["iconIndex"] = 58,
					["mapIconPicture"] = "common/icons/powerup/TORPEDO_s.tga",
					["centralIconIndex"] = 121, 
					["unitClassIndex"] = 113,
					["equipmentIndex"] = 1,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_torpedo1_name_jap", -- Kate Torpedo Run
					["description"] = "globals.powerup_airsupport_torpedo_desc",
					["iconIndex"] = 58,
					["mapIconPicture"] = "common/icons/powerup/TORPEDO_s.tga",
					["centralIconIndex"] = 122, 
					["unitClassIndex"] = 162,
					["equipmentIndex"] = 1,
				},
				["PUMicon"] =  "common/icons/powerup/TORPEDO_l.tga",
				["cooldown"] = 300,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_LANDBASED,
			},
		},
		["Heavy"] = {
			["levelbomb1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_levelbomb1_name_us", -- B-17 Air Strike
					["description"] = "globals.powerup_airsupport_levelbomb_desc",
					["iconIndex"] = 53,
					["mapIconPicture"] = "common/icons/powerup/LEVELBOMB_s.tga",
					["centralIconIndex"] = 95, 
					["unitClassIndex"] = 116,
					["equipmentIndex"] = 1,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_levelbomb1_name_jap", -- Betty Air Strike
					["description"] = "globals.powerup_airsupport_levelbomb_desc",
					["iconIndex"] = 53,
					["mapIconPicture"] = "common/icons/powerup/LEVELBOMB_s.tga",
					["centralIconIndex"] = 94, 
					["unitClassIndex"] = 167,
					["equipmentIndex"] = 1,
				},
				["PUMicon"] =  "common/icons/powerup/LEVELBOMB_l.tga",
				["cooldown"] = 600,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_LANDBASED,
			},
			["rocket1"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_rocket1_name_us", -- Corsair Rocket Run
					["description"] = "globals.powerup_airsupport_rocket1_desc_us",
					["iconIndex"] = 56,
					["mapIconPicture"] = "common/icons/powerup/ROCKET_s.tga",
					["centralIconIndex"] = 118, 
					["unitClassIndex"] = 102,
					["equipmentIndex"] = 1,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_rocket1_name_jap", -- Kamikaze Zero Strike
					["description"] = "globals.powerup_airsupport_rocket1_desc_jap",
					["iconIndex"] = 52,
					["mapIconPicture"] = "common/icons/powerup/KAMIKAZE_s.tga",
					["centralIconIndex"] = 125, 
					["unitClassIndex"] = 45,
					["equipmentIndex"] = 0,
				},
				["USPUMicon"] =  "common/icons/powerup/ROCKET_l.tga",
				["JapPUMicon"] =  "common/icons/powerup/KAMIKAZE_l.tga",
				["cooldown"] = 600,
				["targetType"] = PUTT_ENEMYUNIT,
			},
			["torpedo2"] = {
				["allied"] = {
					["name"] = "globals.powerup_airsupport_torpedo2_name_us", -- B-25 Torpedo Run
					["description"] = "globals.powerup_airsupport_torpedo_desc",
					["iconIndex"] = 58,
					["mapIconPicture"] = "common/icons/powerup/TORPEDO_s.tga",
					["centralIconIndex"] = 123, 
					["unitClassIndex"] = 118,
					["equipmentIndex"] = 2,
				},
				["japanese"] = {
					["name"] = "globals.powerup_airsupport_torpedo2_name_jap", -- Nell Torpedo Run
					["description"] = "globals.powerup_airsupport_torpedo_desc",
					["iconIndex"] = 58,
					["mapIconPicture"] = "common/icons/powerup/TORPEDO_s.tga",
					["centralIconIndex"] = 124, 
					["unitClassIndex"] = 166,
					["equipmentIndex"] = 2,
				},
				["PUMicon"] =  "common/icons/powerup/TORPEDO_l.tga",
				["cooldown"] = 600,
				["targetType"] = PUTT_ENEMYUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_LANDBASED,
			},
		},
	},
	[PUT_ACTIVE] = {
		["Plane"] = {
			["evasive_manoeuvre"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_evasive_manoeuvre_name",
					["description"] = "globals.powerup_active_evasive_manoeuvre_desc",
					["iconIndex"] = 43,
					["mapIconPicture"] = "common/icons/powerup/EVASIVE_MANEUVRE_s.tga",
					["centralIconIndex"] = 106, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_evasive_manoeuvre_name",
					["description"] = "globals.powerup_active_evasive_manoeuvre_desc",
					["iconIndex"] = 43,
					["mapIconPicture"] = "common/icons/powerup/EVASIVE_MANEUVRE_s.tga",
					["centralIconIndex"] = 107, 
				},
				["PUMicon"] =  "common/icons/powerup/EVASIVE_MANEUVRE_l.tga",
				["duration"] = 60,
				["cooldown"] = 600,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_PLANE,
				["multipliers"] = {
					--[PUET_PLANE_SPEED] = 1.2,
					[PUET_PLANE_SPEED] = 1.4,
					[PUET_ARMOR] = 8,
				},
			},
			["full_throttle"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_full_throttle_name",
					["description"] = "globals.powerup_active_full_throttle_desc",
					["iconIndex"] = 46,
					["mapIconPicture"] = "common/icons/powerup/FULL_THROTTLE_s.tga",
					["centralIconIndex"] = 128, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_full_throttle_name",
					["description"] = "globals.powerup_active_full_throttle_desc",
					["iconIndex"] = 46,
					["mapIconPicture"] = "common/icons/powerup/FULL_THROTTLE_s.tga",
					["centralIconIndex"] = 129, 
				},
				["PUMicon"] =  "common/icons/powerup/FULL_THROTTLE_l.tga",
				["duration"] = 60,
				["cooldown"] = 300,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_PLANE,
				["multipliers"] = {
					--[PUET_TURBO_RELOADING] = 2,
					[PUET_TURBO_RELOADING] = 4,
				},
			},
		},
		["Ship"] = {
			["improved_ship_manoeuvreability"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_improved_ship_manoeuvreability_name",
					["description"] = "globals.powerup_active_improved_ship_manoeuvreability_desc",
					["iconIndex"] = 51,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_SHIP_MANEUVRE_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_improved_ship_manoeuvreability_name",
					["description"] = "globals.powerup_active_improved_ship_manoeuvreability_desc",
					["iconIndex"] = 51,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_SHIP_MANEUVRE_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/IMPROVED_SHIP_MANEUVRE_l.tga",
				["duration"] = 60,
				["cooldown"] = 300,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_SUBMARINE,
				["multipliers"] = {
					--[PUET_SHIP_SPEED] = 1.15,
					--[PUET_SHIP_TURNFACTOR] = 1.15,
					[PUET_SHIP_SPEED] = 1.175,
					[PUET_SHIP_TURNFACTOR] = 1.175,
				},
			},
			["hardened_armour"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_hardened_armour_name",
					["description"] = "globals.powerup_active_hardened_armour_desc",
					["iconIndex"] = 47,
					["mapIconPicture"] = "common/icons/powerup/HARDENED_ARMOUR_s.tga",
					["centralIconIndex"] = 112, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_hardened_armour_name",
					["description"] = "globals.powerup_active_hardened_armour_desc",
					["iconIndex"] = 47,
					["mapIconPicture"] = "common/icons/powerup/HARDENED_ARMOUR_s.tga",
					["centralIconIndex"] = 113, 
				},
				["PUMicon"] =  "common/icons/powerup/HARDENED_ARMOUR_l.tga",
				["duration"] = 120,
				["cooldown"] = 600, 
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_SHIP + PUTFF_SUBMARINE,
				["multipliers"] = {
					--[PUET_ARMOR] = 1.2,
					[PUET_ARMOR] = 1.6,
				},
			},
			["improved_repair_team"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_improved_repair_team_name",
					["description"] = "globals.powerup_active_improved_repair_team_desc",
					["iconIndex"] = 49,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_REPAIR_s.tga",
					["centralIconIndex"] = 116, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_improved_repair_team_name",
					["description"] = "globals.powerup_active_improved_repair_team_desc",
					["iconIndex"] = 49,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_REPAIR_s.tga",
					["centralIconIndex"] = 117, 
				},
				["PUMicon"] =  "common/icons/powerup/IMPROVED_REPAIR_l.tga",
				["duration"] = 60,
				["cooldown"] = 300,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_SHIP,
				["multipliers"] = {
					--[PUET_SHIP_REPAIR] = 2,
					[PUET_SHIP_REPAIR] = 4,
				},
			},
		},
		["Capture"] = {
			["fierce_assault"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_fierce_assault_name",
					["description"] = "globals.powerup_active_fierce_assault_desc",
					["iconIndex"] = 45,
					["mapIconPicture"] = "common/icons/powerup/FIERCE_ASSAULT_s.tga",
					["centralIconIndex"] = 127, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_fierce_assault_name",
					["description"] = "globals.powerup_active_fierce_assault_desc",
					["iconIndex"] = 45,
					["mapIconPicture"] = "common/icons/powerup/FIERCE_ASSAULT_s.tga",
					["centralIconIndex"] = 127, 
				},
				["PUMicon"] =  "common/icons/powerup/FIERCE_ASSAULT_l.tga",
				["duration"] = 60,
				["cooldown"] = 1200,
				["targetType"] = PUTT_PLAYER,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					--[PUET_CAPTURE_POWER] = 2,
					[PUET_CAPTURE_POWER] = 3,
				},
			},
			["fearless_defense"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_fearless_defense_name",
					["description"] = "globals.powerup_active_fearless_defense_desc",
					["iconIndex"] = 44,
					["mapIconPicture"] = "common/icons/powerup/FEARLESS_DEFENSE_s.tga",
					["centralIconIndex"] = 126, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_fearless_defense_name",
					["description"] = "globals.powerup_active_fearless_defense_desc",
					["iconIndex"] = 44,
					["mapIconPicture"] = "common/icons/powerup/FEARLESS_DEFENSE_s.tga",
					["centralIconIndex"] = 126, 
				},
				["PUMicon"] =  "common/icons/powerup/FEARLESS_DEFENSE_l.tga",
				["duration"] = 60,
				["cooldown"] = 1200,
				["targetType"] = PUTT_PLAYER,
				["targetFilter"] = PUTFF_LANDBASED,
				["multipliers"] = {
					--[PUET_CAPTURE_RESISTANCE] = 2,
					[PUET_CAPTURE_RESISTANCE] = 4,
				},
			},
			["test_radar_sweep"] = {
				["allied"] = {
					["name"] = "Radar Sweep",
					["description"] = "A powerful radar station sweeps the area.",
					["iconIndex"] = 54,
					["mapIconPicture"] = "common/icons/powerup/RADAR_SWEEP_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "Radar Sweep",
					["description"] = "A powerful radar station sweeps the area.",
					["iconIndex"] = 54,
					["mapIconPicture"] = "common/icons/powerup/RADAR_SWEEP_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/RADAR_SWEEP_l.tga",
				["duration"] = 360,
				["cooldown"] = 125,
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					[PUET_RECON] = 100,
				},
			},
			["radar_sweep"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_radar_sweep_name",
					["description"] = "globals.powerup_active_radar_sweep_desc",
					["iconIndex"] = 54,
					["mapIconPicture"] = "common/icons/powerup/RADAR_SWEEP_s.tga",
					["centralIconIndex"] = 114, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_radar_sweep_name",
					["description"] = "globals.powerup_active_radar_sweep_desc",
					["iconIndex"] = 54,
					["mapIconPicture"] = "common/icons/powerup/RADAR_SWEEP_s.tga",
					["centralIconIndex"] = 115, 
				},
				["PUMicon"] =  "common/icons/powerup/RADAR_SWEEP_l.tga",
				["duration"] = 10,
				["cooldown"] = 600,
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					[PUET_RECON] = 100,
				},
			},
		},
		["Weapon"] = {
			["improved_shells"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_improved_shells_name",
					["description"] = "globals.powerup_active_improved_shells_desc",
					["iconIndex"] = 50,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_SHELLS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_improved_shells_name",
					["description"] = "globals.powerup_active_improved_shells_desc",
					["iconIndex"] = 50,
					["mapIconPicture"] = "common/icons/powerup/IMPROVED_SHELLS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/IMPROVED_SHELLS_l.tga",
				["duration"] = 120,
				["cooldown"] = 600,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_SHIP,
				["multipliers"] = {
					--[PUET_FIREPOWER] = 1.2,
					[PUET_FIREPOWER] = 1.3,
				},
			},
			["targeting_computer"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_targeting_computer_name",
					["description"] = "globals.powerup_active_targeting_computer_desc",
					["iconIndex"] = 57,
					["mapIconPicture"] = "common/icons/powerup/TARGETING_COMPUTER_s.tga",
					["centralIconIndex"] = 119, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_targeting_computer_name",
					["description"] = "globals.powerup_active_targeting_computer_desc",
					["iconIndex"] = 57,
					["mapIconPicture"] = "common/icons/powerup/TARGETING_COMPUTER_s.tga",
					["centralIconIndex"] = 120, 
				},
				["PUMicon"] =  "common/icons/powerup/TARGETING_COMPUTER_l.tga",
				["duration"] = 120,
				["cooldown"] = 600,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					--[PUET_TARGETING_ERROR] = 0.1,
					[PUET_TARGETING_ERROR] = 0.2,
				},
			},
			["automatic_reloader"] = {
				["allied"] = {
					["name"] = "globals.powerup_active_automatic_reloader_name",
					["description"] = "globals.powerup_active_automatic_reloader_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/AUTOMATIC_RELOADER_s.tga",
					["centralIconIndex"] = 110, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_active_automatic_reloader_name",
					["description"] = "globals.powerup_active_automatic_reloader_desc",
					["iconIndex"] = 39,
					["mapIconPicture"] = "common/icons/powerup/AUTOMATIC_RELOADER_s.tga",
					["centralIconIndex"] = 111, 
				},
				["PUMicon"] =  "common/icons/powerup/AUTOMATIC_RELOADER_l.tga",
				["duration"] = 60,
				["cooldown"] = 600,
				["targetType"] = PUTT_FRIENDUNIT,
				["targetFilter"] = PUTFF_SHIPS_AND_SUBS + PUTFF_LANDBASED,
				["multipliers"] = {
					--[PUET_DEVICE_RELOADING] = 1.25,
					[PUET_DEVICE_RELOADING] = 1.08,
				},
			},
		},
	},
	[PUT_PASSIVE] = {
		["CaptureRange"] = {
			["repair_bay"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_repair_bay_name",
					["description"] = "globals.powerup_passive_repair_bay_desc",
					["iconIndex"] = 55,
					["mapIconPicture"] = "common/icons/powerup/REPAIR_BAY_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_repair_bay_name",
					["description"] = "globals.powerup_passive_repair_bay_desc",
					["iconIndex"] = 55,
					["mapIconPicture"] = "common/icons/powerup/REPAIR_BAY_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/REPAIR_BAY_l.tga",
				["targetType"] = PUTT_RANGE,
				["targetFilter"] = PUTFF_SHIPS_AND_SUBS,
				["multipliers"] = {
					[PUET_SHIP_REPAIR] = 3,
				},
			},
		},
		["Party"] = {
			["advanced_repair_tools"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_advanced_repair_tools_name",
					["description"] = "globals.powerup_passive_advanced_repair_tools_desc",
					["iconIndex"] = 35,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_REPAIR_TOOLS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_advanced_repair_tools_name",
					["description"] = "globals.powerup_passive_advanced_repair_tools_desc",
					["iconIndex"] = 35,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_REPAIR_TOOLS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/ADVANCED_REPAIR_TOOLS_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_SHIP,
				["multipliers"] = {
					--[PUET_SHIP_REPAIR] = 1.05,
					[PUET_SHIP_REPAIR] = 1.15,
				},
			},
			["advanced_recon_devices"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_advanced_recon_devices_name",
					["description"] = "globals.powerup_passive_advanced_recon_devices_desc",
					["iconIndex"] = 61,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_RECON_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_advanced_recon_devices_name",
					["description"] = "globals.powerup_passive_advanced_recon_devices_desc",
			 		["iconIndex"] = 61,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_RECON_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/ADVANCED_RECON_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					--[PUET_RECON] = 1.2,
					[PUET_RECON] = 1.4,
				},
			},
			["veteran_crewmen"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_veteran_crewmen_name",
					["description"] = "globals.powerup_passive_veteran_crewmen_desc",
					["iconIndex"] = 59,
					["mapIconPicture"] = "common/icons/powerup/VETERAN_CREWMEN_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_veteran_crewmen_name",
					["description"] = "globals.powerup_passive_veteran_crewmen_desc",
					["iconIndex"] = 59,
					["mapIconPicture"] = "common/icons/powerup/VETERAN_CREWMEN_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/VETERAN_CREWMEN_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_SHIPS_AND_SUBS,
				["multipliers"] = {
					--[PUET_SHIP_SPEED] = 1.05,
					--[PUET_SHIP_TURNFACTOR] = 1.05,
					[PUET_SHIP_SPEED] = 1.1,
					[PUET_SHIP_TURNFACTOR] = 1.1,
				},
			},
			["advanced_planes"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_advanced_planes_name",
					["description"] = "globals.powerup_passive_advanced_planes_desc",
					["iconIndex"] = 34,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_PLANES_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_advanced_planes_name",
					["description"] = "globals.powerup_passive_advanced_planes_desc",
					["iconIndex"] = 34,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_PLANES_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/ADVANCED_PLANES_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_PLANE,
				["multipliers"] = {
					--[PUET_ARMOR] = 1.05,
					--[PUET_PLANE_SPEED] = 1.05,
					[PUET_ARMOR] = 1.1,
					[PUET_PLANE_SPEED] = 1.1,
				},
			},
			["advanced_weapons"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_advanced_weapons_name",
					["description"] = "globals.powerup_passive_advanced_weapons_desc",
					["iconIndex"] = 37,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_WEAPONS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_advanced_weapons_name",
					["description"] = "globals.powerup_passive_advanced_weapons_desc",
					["iconIndex"] = 37,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_WEAPONS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/ADVANCED_WEAPONS_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					--[PUET_FIREPOWER] = 1.05,
					--[PUET_TARGETING_ERROR] = 1.05,
					[PUET_FIREPOWER] = 1.1,
					[PUET_TARGETING_ERROR] = 1.1,
				},
			},
			["face_hardened_armour"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_face_hardened_armour_name",
					["description"] = "globals.powerup_passive_face_hardened_armour_desc",
					["iconIndex"] = 43,
					["mapIconPicture"] = "common/icons/powerup/FACE_HARDENED_ARMOUR_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_face_hardened_armour_name",
					["description"] = "globals.powerup_passive_face_hardened_armour_desc",
					["iconIndex"] = 43,
					["mapIconPicture"] = "common/icons/powerup/FACE_HARDENED_ARMOUR_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/FACE_HARDENED_ARMOUR_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_SHIPS_AND_SUBS,
				["multipliers"] = {
					--[PUET_ARMOR] = 1.05,
					[PUET_ARMOR] = 1.1,
				},
			},
			["veteran_pilots"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_veteran_pilots_name",
					["description"] = "globals.powerup_passive_veteran_pilots_desc",
					["iconIndex"] = 60,
					["mapIconPicture"] = "common/icons/powerup/VETERAN_PILOTS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_veteran_pilots_name",
					["description"] = "globals.powerup_passive_veteran_pilots_desc",
					["iconIndex"] = 60,
					["mapIconPicture"] = "common/icons/powerup/VETERAN_PILOTS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/VETERAN_PILOTS_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_PLANE,
				["multipliers"] = {
					--[PUET_PLANE_SPEED] = 1.05,
					--[PUET_PLANE_TURN] = 1.05,
					[PUET_PLANE_SPEED] = 1.1,
					[PUET_PLANE_TURN] = 1.1,
				},
			},
			["heavy_assault_troops"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_heavy_assault_troops_name",
					["description"] = "globals.powerup_passive_heavy_assault_troops_desc",
					["iconIndex"] = 48,
					["mapIconPicture"] = "common/icons/powerup/HEAVY_ASSAULT_TROOPS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_heavy_assault_troops_name",
					["description"] = "globals.powerup_passive_heavy_assault_troops_desc",
					["iconIndex"] = 48,
					["mapIconPicture"] = "common/icons/powerup/HEAVY_ASSAULT_TROOPS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/HEAVY_ASSAULT_TROOPS_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_ALL,
				["multipliers"] = {
					--[PUET_CAPTURE_POWER] = 1.1,
					[PUET_CAPTURE_POWER] = 1.4,
				},
			},
			["advanced_torpedoes"] = {
				["allied"] = {
					["name"] = "globals.powerup_passive_advanced_torpedoes_name",
					["description"] = "globals.powerup_passive_advanced_torpedoes_desc",
					["iconIndex"] = 36,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_TORPEDOS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["japanese"] = {
					["name"] = "globals.powerup_passive_advanced_torpedoes_name",
					["description"] = "globals.powerup_passive_advanced_torpedoes_desc",
					["iconIndex"] = 36,
					["mapIconPicture"] = "common/icons/powerup/ADVANCED_TORPEDOS_s.tga",
					["centralIconIndex"] = 0, 
				},
				["PUMicon"] =  "common/icons/powerup/ADVANCED_TORPEDOS_l.tga",
				["targetType"] = PUTT_PARTY,
				["targetFilter"] = PUTFF_SHIPS_AND_SUBS + PUTFF_PLANE,
				["multipliers"] = {
					--[PUET_TORPEDO_SPEED] = 1.1,
					--[PUET_TORPEDO_TURN] = 1.1,
					[PUET_TORPEDO_SPEED] = 1.2,
					[PUET_TORPEDO_TURN] = 1.2,
				},
			},
		},
	},
}
