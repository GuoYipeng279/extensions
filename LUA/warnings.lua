-- regexp kereseshez: ^{%[ ^t]++"[a-zA-Z_$^^%#~@0-9]+",^}^{%[ ^t]++--^[^[message_prefix^]^]"[a-zA-Z_$^^%#~@0-9]+",^}

Warnings = {}

Warnings["escapecharacters"] =
{
	["entity"] =
	{
		["~"] = -- csak own
		{
			["own"] =
			{
				--unit Name
				--["USS Yorktown"] = "uss_yorktown",

				--unit type
				["airfield"] = "own_land",
				["battleship"] = "own_ship",
				["cargo"] = "own_ship",
				["cruiser"] = "own_ship",
				["destroyer"] = "own_ship",
				["divebomber"] = "own_plane",
				["fighter"] = "own_plane",
				["kamikaze"] = "own_plane",
				["landfort"] = "own_land",
				["landingship"] = "own_ship",
				["landvehicle"] = "",
				["levelbomber"] = "own_plane",
				["mothership"] = "own_ship",
				["reconplane"] = "own_plane",
				["submarine"] = "own_submarine",
				["torpedoboat"] = "own_ship",
				["torpedobomber"] = "own_plane",

				--defaults
				--["default_ship"] = "own_ship",
				--["default_plane"] = "own_plane",
				--["default_planesquadron"] = "own_planesq",
				--["default_landobject"] = "own_landobject",
				
				-- multi fake entity
				["NavalSupply"] = "own_supply",
				["CommandBuilding"] = "own_base",
			},
			["neutral"] = 
			{
				["NavalSupply"] = "supply",
				["CommandBuilding"] = "base",
			},
		},
		["@"] = -- csak enemy
		{
			["enemy"] =
			{
				--unit Name
				--["IJN Akagi"] = "ijn_akagi",

				--unit type
				["airfield"] = "nmy_land",
				["battleship"] = "nmy_ship",
				["cargo"] = "nmy_ship",
				["cruiser"] = "nmy_ship",
				["destroyer"] = "nmy_ship",
				["divebomber"] = "nmy_plane",
				["fighter"] = "nmy_plane",
				["kamikaze"] = "nmy_plane",
				["kamikaze"] = "nmy_kamikaze",
				["landfort"] = "nmy_land",
				["landingship"] = "nmy_ship",
				["landvehicle"] = "",
				["levelbomber"] = "nmy_plane",
				["mothership"] = "nmy_CV",
				["reconplane"] = "nmy_plane",
				["shipyard"] = "nmy_land",
				["submarine"] = "nmy_submarine",
				["torpedoboat"] = "nmy_ship",
				["torpedobomber"] = "nmy_plane",
			["suicboat"] = "nmy_sboat", -- SUICIDE BOAT - CODE NEEDED
			["paratrooper"] = "nmy_ptrp", -- PARATROOPER PLANE - CODE NEEDED



				--defaults
				--["default_ship"] = "nmy_ship",
				--["default_plane"] = "nmy_plane",
				--["default_planesquadron"] = "nmy_planesq",
				--["default_landobject"] = "nmy_landobject",
				
				-- multi fake entity
				["NavalSupply"] = "nmy_supply",
				["CommandBuilding"] = "nmy_base",
			},
			["neutral"] = 
			{
				["NavalSupply"] = "supply",
				["CommandBuilding"] = "base",
			},
		},
	},
	["playerunit_section"] =
	{
		["%"] =
		{
			--section name on the player's unit
			["engineroom"] = "in_our_engineroom",
			["fueltank"] = "in_our_fueltank",
			["steering"] = "in_our_steering",
			["magazine"] = "in_our_magazine",
			["runway"] = "on_our_runway",
			--["hangar"] = "in_our_hangar",
			--["body"] = "on_our_ship",
		},
	},
}

----------------------------------------------------------------------------

Warnings["messages"] =
{
	["recon"] =
	{
		["identified"] =
		{
			["enemy"] =  -- @ = enemy Name/type
			{
				["ship"] = -- ha ship jelent
				{
					"@_ident_dispatcher",
					"@_ident_dispatcher2",
					["player"] =
					{
						"@_ident_dispatcher",
						"@_ident_dispatcher2",
					},
				},
				["plane"] = -- ha ship jelent
				{
					"@_ident_dispatcher",
					"@_ident_dispatcher2",
					["player"] =
					{
						"@_ident_dispatcher",
						"@_ident_dispatcher2",
					},
				},
				["other"] = -- ha nem plane es nem ship jelent
				{
					"@_ident_dispatcher",
					"@_ident_dispatcher2",
					["player"] =
					{
						"@_ident_dispatcher",
						"@_ident_dispatcher2",
					},
				},
			},
		},
	},
	["kill"] =
	{
		["own"] =
		{
			["ship"] =
			{
				"ship_lost_dispatcher",
				"ship_lost_dispatcher2",
				"ship_lost_dispatcher3",
				"ship_lost_dispatcher4",
			},
			["ship_kamikaze_plane"] = -- TODO: CODE NEEDED
			{
				"ship_lost_kamikaze_dispatcher",
				"ship_lost_kamikaze_dispatcher2",
			},
			["ship_suicide_boat"] = -- TODO: CODE NEEDED
			{
				"ship_lost_suicboat_randomship",
				"ship_lost_suicboat_2_randomship",
			},
			["own_carrier"] = -- TODO: CODE NEEDED
			{
				"own_CV_lost_dispatcher",
			},
			["plane"] =
			{
				["ambient"] =
				{
					"plane_lost_1_ambient_randomplane",
					"plane_lost_2_ambient_randomplane",
					"plane_lost_3_ambient_randomplane",
					"plane_lost_4_ambient_randomplane",
				},
			},
			["planesquadron"] =
			{
				"plane_sq_lost_dispatcher",
				"plane_sq_lost_dispatcher2",
				"plane_sq_lost_dispatcher3",
				"plane_sq_lost_dispatcher4",
			},
			["airfield"] =
			{
				"airfield_lost_dispatcher",
				"airfield_lost_dispatcher2",
			},
		},
		["enemy"] = -- @ = enemy Name/type
		{
			["ship"] = -- ellenseges hajo sullyed
			{
				["ship"] = -- egy hajonk nyirta ki
				{
					--[[message_prefix]]"@_ship_dest_1_randomship",
					--[[message_prefix]]"@_ship_dest_2_randomship",
					--[[message_prefix]]"@_ship_dest_3_randomship",
					--[[message_prefix]]"@_ship_dest_4_randomship",
					["player"] = -- a player nyirta ki
					{
						"@_ship_dest_dispatcher",
						"@_ship_dest_dispatcher2",
					},
				},
				["plane"] = -- egy repcsink nyirta ki
				{
					--[[message_prefix]]"@_ship_dest_1_randomplane",
					--[[message_prefix]]"@_ship_dest_1_randomplane",
					["player"] = -- a player nyirta ki
					{
						"@_ship_dest_dispatcher",
						"@_ship_dest_dispatcher2",
					},
				},
				["other"] = -- parti cucc nyirta ki
				{
					--[[message_prefix]]"@_ship_dest_1_randomship",
					--[[message_prefix]]"@_ship_dest_2_randomship",
					--[[message_prefix]]"@_ship_dest_3_randomship",
					--[[message_prefix]]"@_ship_dest_4_randomship",
					["player"] = -- a player nyirta ki
					{
						"@_ship_dest_dispatcher",
						"@_ship_dest_dispatcher2",
					},
				},
				["unknown"] = -- nem lehet tudni ki nyirta ki (pl. falnak repult sertetlen repcsi, szkriptbol kinyirt unit stb.)
				{
					"@_ship_dest_dispatcher",
					"@_ship_dest_dispatcher2",
				},
			},
			["planesquadron"] =
			{
				["ship"] = -- egy hajonk nyirta ki
				{
					--[[message_prefix]]"@_sq_dest_1_randomship",
					--[[message_prefix]]"@_sq_dest_2_randomship",
					--[[message_prefix]]"@_sq_dest_3_randomship",
					--[[message_prefix]]"@_sq_dest_4_randomship",
					["player"] =
					{
						"@_sq_dest_dispatcher",
						"@_sq_dest_dispatcher2",
						"@_sq_dest_dispatcher3",
						"@_sq_dest_dispatcher4",
					},
				},
				["plane"] = -- egy repcsink nyirta ki
				{
					--[[message_prefix]]"@_sq_dest_1_randomplane",
					--[[message_prefix]]"@_sq_dest_2_randomplane",
					--[[message_prefix]]"@_sq_dest_3_randomplane",
					["player"] =
					{
						"@_sq_dest_dispatcher",
						"@_sq_dest_dispatcher2",
						"@_sq_dest_dispatcher3",
						"@_sq_dest_dispatcher4",
					},
				},
				["other"] = -- parti cucc nyirta ki
				{
					--[[message_prefix]]"@_sq_dest_1_randomship",
					--[[message_prefix]]"@_sq_dest_2_randomship",
					--[[message_prefix]]"@_sq_dest_3_randomship",
					--[[message_prefix]]"@_sq_dest_4_randomship",
					["player"] =
					{
						"@_sq_dest_dispatcher",
						"@_sq_dest_dispatcher2",
						"@_sq_dest_dispatcher3",
						"@_sq_dest_dispatcher4",
					},
				},
				["unknown"] = -- nem lehet tudni ki nyirta ki (pl. falnak repult sertetlen repcsi, szkriptbol kinyirt unit stb.)
				{
						"@_sq_dest_dispatcher",
						"@_sq_dest_dispatcher2",
						"@_sq_dest_dispatcher3",
						"@_sq_dest_dispatcher4",
				},
			},
			["airfield"] =
			{
				["ship"] = -- egy hajonk nyirta ki
				{
					--[[message_prefix]]"nmy_airfield_dest_1_randomship", --?
					--[[message_prefix]]"nmy_airfield_dest_2_randomship", --?
					["player"] =
					{
						"nmy_airfield_dest_dispatcher",
						"nmy_airfield_dest_dispatcher2",
					},
				},
				["plane"] = -- egy repcsink nyirta ki
				{
					--[[message_prefix]]"nmy_airfield_dest_1_randomplane",
					--[[message_prefix]]"nmy_airfield_dest_2_randomplane",
					["player"] =
					{
						"nmy_airfield_dest_dispatcher",
						"nmy_airfield_dest_dispatcher2",
					},
				},
				["other"] = -- parti cucc nyirta ki
				{
					--[[message_prefix]]"nmy_airfield_dest_1_randomship",
					--[[message_prefix]]"nmy_airfield_dest_2_randomship",
					["player"] =
					{
						"nmy_airfield_dest_dispatcher",
						"nmy_airfield_dest_dispatcher2",
					},
				},
				["unknown"] = -- nem lehet tudni ki nyirta ki (pl. falnak repult sertetlen repcsi, szkriptbol kinyirt unit stb.)
				{
					"nmy_airfield_dest_dispatcher",
					"nmy_airfield_dest_dispatcher2",
				},
			},
			["plane"] = -- ellenseges repcsi zuhan
			{
				["ambient"] =
				{
					["ship"] = -- egy hajonk nyirta ki
					{
						"plane_dest_1_ambient_randomship",
						"plane_dest_2_ambient_randomship", -- confirmed sinking issue, ha meglesz a hang, csak remove comment
						"plane_dest_3_ambient_randomship",
						"plane_dest_4_ambient_randomship",
						["player"] = -- a player nyirta ki
						{
							"plane_dest_dispatcher",
							"plane_dest_dispatcher2",
							"plane_dest_dispatcher3",
							"plane_dest_dispatcher4",
							"plane_dest_dispatcher5",
						},
					},
					["plane"] = -- egy repcsink nyirta ki
					{
						"plane_dest_1_ambient_randomplane",
						"plane_dest_2_ambient_randomplane",
						"plane_dest_3_ambient_randomplane",
						"plane_dest_4_ambient_randomplane",
						"plane_dest_5_ambient_randomplane",
						["player"] = -- a player nyirta ki
						{
							--INKABB NEM DISZPECSER, NEM JO "plane_dest_dispatcher",
						"plane_dest_1_ambient_randomplane",
						"plane_dest_2_ambient_randomplane",
						"plane_dest_3_ambient_randomplane",
						"plane_dest_4_ambient_randomplane",
						"plane_dest_5_ambient_randomplane",
						},
					},
					["other"] = -- parti cucc nyirta ki
					{
						"plane_dest_1_ambient_randomship",
						"plane_dest_2_ambient_randomship",
						"plane_dest_3_ambient_randomship",
						"plane_dest_4_ambient_randomship",
						["player"] = -- a player nyirta ki
						{
							"plane_dest_dispatcher",
							"plane_dest_dispatcher2",
							"plane_dest_dispatcher3",
							"plane_dest_dispatcher4",
							"plane_dest_dispatcher5",
						},
					},
				},
			},
		},
	},
	["hit"] =
	{
		["weareunderattack"] =
		{
			["ship"] =
			{
				--[[message_prefix]]"under_att_1_randomship",
				--[[message_prefix]]"under_att_2_randomship",
				--[[message_prefix]]"under_att_3_randomship",
				["player"] =
				{
					"under_att_dispatcher",
					"under_att_dispatcher2",
				},
			},
			["carrier"] =  --TODO: CODE NEEDED
			{
				--[[message_prefix]]"under_att_CV_dispatcher",
				["player"] =
				{
					"under_att_dispatcher",
					"under_att_dispatcher2",
				},
			},
			["base"] = --TODO: CODE NEEDED
			{
				--[[message_prefix]]"under_att_cmd_building_dispatcher",
				["player"] =
				{
					"under_att_dispatcher",
					"under_att_dispatcher2",
				},
			},
			["planesquadron"] =
			{
				--[[message_prefix]]"under_att_1_randomplane",
				--[[message_prefix]]"under_att_2_randomplane",
				--[[message_prefix]]"under_att_3_randomplane",
				["player"] = -- csak akkor jatszodhat le, ha 1-nel tobb squadmember van
				{
					"under_att_1_randomplane",
					"under_att_2_randomplane",
					"under_att_3_randomplane",
				},
			},
			["other"] =
			{
				--[[message_prefix]]"under_att_1_randomship",
				--[[message_prefix]]"under_att_2_randomship",
				--[[message_prefix]]"under_att_3_randomship",
				["player"] =
				{
					"under_att_dispatcher",
					"under_att_dispatcher2",
				},
			},
			["commandbuilding"] = 
			{
				
				["player"] =
				{
					"multi_own_hq_under_att", --Our base is under attack!
				},
				["last"] =
				{
					"multi_last_hq_under_att",
				},
				--"multi_own_base_under_att",
			},
			["navalsupply"] = 
			{
				
				["player"] =
				{
					"multi_own_supply_under_att", --Our base is under attack!
				},
				"multi_own_supply_under_att",
			},
		},
		["playermistake"] =
		{
			["friendlyfire"] =
			{
				["ship"] =
				{
					--[[message_prefix]]"friendly_fire_1_randomship",
					--[[message_prefix]]"friendly_fire_2_randomship",
					--[[message_prefix]]"friendly_fire_3_randomship",
				},
				["planesquadron"] =
				{
					--[[message_prefix]]"friendly_fire_1_randomship",
					--[[message_prefix]]"friendly_fire_2_randomship",
					--[[message_prefix]]"friendly_fire_3_randomship",						
				},
				["other"] =
				{
					--[[message_prefix]]"friendly_fire_1_randomship",
					--[[message_prefix]]"friendly_fire_2_randomship",
					--[[message_prefix]]"friendly_fire_3_randomship",
				},
			},
		},
		["payloadhit"] =
		{
			["player"] =
			{
				"payloadhit_dispatcher",
				"payloadhit_dispatcher2",
				"payloadhit_dispatcher3",
			},
			["plane"] =
			{
				["ambient"] =
				{
					"payloadhit_1_ambient_randomplane",
					"payloadhit_2_ambient_randomplane",
					"payloadhit_3_ambient_randomplane",
				},
			},
		},
	},
	["exitzone"] = -- ~ = own Name/type
	{
		["enter"] =
		{
			"~_exitzone_dispatcher",
			"~_exitzone_dispatcher2",
			["player"] =
			{
				["ship"] = -- ha a jatekos hajoban ul
				{
					"exitzone_dispatcher",
					"exitzone_dispatcher2",
				},
				"exitzone_dispatcher",
				"exitzone_dispatcher2",
			},
		},
	},
	["failure"] =
	{
		["SteeringJam"] =
		{
			"failure_in_our_steering_dispatcher",
			"failure_in_our_steering_dispatcher2",
		},
		["EngineJam"] =
		{
			"failure_in_our_engineroom_dispatcher",
			"failure_in_our_engineroom_dispatcher2",
		},
		["RunwayFailure"] =
		{
			"failure_on_our_runway_dispatcher",
			"failure_on_our_runway_dispatcher2",
		},
		["HangarFailure"] =
		{
		},
		["Explosion"] =
		{
			"failure_in_our_magazine_dispatcher",
			"failure_in_our_magazine_dispatcher2",
		},
		["airfield"] = 
		{
			"multi_own_airfield_neut",
		},
		["shipyard"] = 
		{
			"multi_own_shipyard_neut",
		},		
	},
	["leak"] =
	{
		"we_are_leaked_dispatcher",
		"we_are_leaked_dispatcher2",
		"we_are_leaked_dispatcher3",
	},
	["fire"] =
	{
		"fire_dispatcher",
		"fire_dispatcher2",
		"fire_dispatcher3",
	},
	["torpedo"] =
	{
		"incoming_torpedoes_dispatcher",
		"incoming_torpedoes_dispatcher2",
		"incoming_torpedoes_dispatcher3",
	},
	["submarine"] =
	{
		["air"] =
		{
			["low"] =
			{
				"airsupply_low_dispatcher",
				"airsupply_low_dispatcher2",
			},
			["critical"] =
			{
				"airsupply_critical_dispatcher",
				"airsupply_critical_dispatcher2",
			},
		},
		["depthdamage"] =
		{
			"pressure_damage_dispatcher",
			"pressure_damage_dispatcher2",
		},
		["periscopebroken"] =
		{
			"sub_periscope_lost",
		},
	},
	["confirm"] =
	{
		["ship"] =
		{
			["attack"] = --TODO: CODE NEEDED
			{
				"attack_cmd_dispatcher",
				"attack_cmd_dispatcher2",
				"attack_cmd_1_randomship",
				"attack_cmd_2_randomship",
				"attack_cmd_3_randomship",
			},
			["formation_change"] = -- TODO: CODE NEEDED
			{
				"formation_change_randomship",
			},
			["formation_disband"] = -- TODO: CODE NEEDED
			{
				"formation_disband_randomship",
			},
			["formation_join"] = -- TODO: CODE NEEDED
			{
				"formation_join_randomship",
			},
			["formation_leave"] = -- TODO: CODE NEEDED
			{
				"formation_leave_randomship",
			},
			["formation_new_leader"] = -- TODO: CODE NEEDED
			{
				"formation_new_leader_randomship",
			},
			["repair_body"] = -- TODO: CODE NEEDED
			{
				"repair_body_cmd_randomship",
			},
			["repair_device"] = -- TODO: CODE NEEDED
			{
				"repair_device_cmd_randomship",
			},
			["repair_engine"] = -- TODO: CODE NEEDED
			{
				"repair_engine_cmd_randomship",
			},
			["repair_fire"] = -- TODO: CODE NEEDED
			{
				"repair_fire_cmd_randomship",
			},
			["repair_pump"] = -- TODO: CODE NEEDED
			{
				"repair_pump_cmd_randomship",
			},
			["stance_aggr"] = -- TODO: CODE NEEDED
			{
				"stance_aggr_cmd_randomship",
			},
			["stance_def"] = -- TODO: CODE NEEDED
			{
				"stance_def_cmd_randomship",
			},
		},
		["plane"] =
		{
			["attack"] =
			{
				"attack_cmd_1_randomplane",
				"attack_cmd_2_randomplane",
			},
			["regroup"] =
			{
				"regroup_cmd_1_randomplane",
				"regroup_cmd_2_randomplane",
			},
			["land"] =
			{
				"land_cmd_1_randomplane",
				"land_cmd_2_randomplane",
				["player"] = -- mar csak egyedul van a player a squadban
				{
					"land_cmd_dispatcher",
					"land_cmd_dispatcher2",
				},
			},
			["retreat"] =
			{
				"retreat_cmd_1_randomplane",
				"retreat_cmd_2_randomplane",
				["player"] = -- mar csak egyedul van a player a squadban
				{
					"retreat_cmd_dispatcher",
					"retreat_cmd_dispatcher2",
				},
			},
			["stance_aggr"] = -- TODO: CODE NEEDED
			{
				"stance_aggr_cmd_randomplane",
			},
			["stance_def"] = -- TODO: CODE NEEDED
			{
				"stance_def_cmd_randomplane",
			},
		},
		["submarine"] = -- TODO: CODE NEEDED
		{
			["submerge"] = 
			{
				"submerge_cmd_randomsub",
			},
			["repair"] =
			{
				"repair_periscope_cmd_randomsub",
			},
		},
		["supman"] = -- TODO: CODE NEEDED
		{
			["plane_sq_launched"] = 
			{
				"supman_plane_sq_launched_dispatcher",
				"supman_plane_sq_launched_randomplane",
			},
			["plane_sq_queued"] = 
			{
				"supman_plane_sq_queued_dispatcher",
				"supman_plane_sq_queued_randomplane",
			},
		},
		["unit_sold"] =  -- TODO: CODE NEEDED
		{
			"unit_sell_dispatcher",
			"unit_sell_dispatcher2",
		},
	},

	["depthlevel"] = -- TODO: CODE NEEDED
	{
		["depth1"] =  
		{
			"depth_1_randomsub",
		},
		["depth2"] =  
		{
			"depth_2_randomsub",
		},
		["depth3"] =  
		{
			"depth_3_randomsub",
		},
		["depth4"] =  
		{
			"depth_4_randomsub",
		},
	},

	["disable"] = -- TODO: CODE NEEDED
	{
		["own_airfield"] =  
		{
			"own_airfield_disabled_dispatcher",
		},
		["nmy_airfield"] =  
		{
			"nmy_airfield_disabled_dispatcher",
		},
		["own_shipyard"] =  
		{
			"own_shipyard_disabled_dispatcher",
		},
		["nmy_shipyard"] =  
		{
			"nmy_shipyard_disabled_dispatcher",
		},
	},

	["powerup"] = -- TODO: CODE NEEDED
	{
		["pup_gain"] =  
		{
			"powerup_gain_dispatcher",
			["multi"] = 
			{
				"multi_pup_avl",
			},
		},
		["pup_lost"] =  
		{
			"powerup_lost_dispatcher",
			["multi"] = 
			{
				"multi_pup_lost",
			},
		},
		["pup_ready"] =  
		{
			"powerup_rdy_dispatcher",
			["multi"] = 
			{
				"multi_pup_rdy",
			},
		},
	},
	

	["newunit"] =
	{
		"multi_new_unit_dispatcher",
		"multi_new_unit_dispatcher2",
	},
	
	["score"]= 
	{
		["multi_score_lead_lost"] =  
		{
			"multi_score_lead_lost",
		},
		["multi_score_lead_gained"]= 
		{
			"multi_score_lead_gained",
		},
		["multi_allies_to_win"] =    
		{
			"multi_allies_to_win",
		},
		["multi_japanese_to_win"] =  
		{
			"multi_japanese_to_win",
		},
		["multi_allies_win"] = 		 
		{
			"multi_allies_win",
		},
		["multi_japanese_win"] = 	 
		{
			"multi_japanese_win",
		},
	},
	
	["capture"] =
	{
		["commandbuilding"] = 
		{
			["neutralize"] = {
				["nmy"] = 
				{
					["base"] = 
					{
						"multi_nmy_hq_neut", --hq
						["player"] = 
						{ 
							"multi_nmy_base_neut_p", 
						},
					},
					["supply"] = 
					{
						"multi_nmy_supply_neut",
					},
				},
				["own"] = 
				{
					["base"] = 
					{
						"multi_own_hq_neut",
						["last"] = 
						{ 
							"multi_last_hq_neut", 
						},
						["oneleft"] = 
						{ 
							"multi_last_hq",
						},
						["player"] =
						{
							"multi_own_base_lost",
						},
					},
				},		
			},
			["cap"] = {
				["neut"] = 
				{
					["own"] = 
					{
						["base"] = 
						{
							"multi_neut_base_captured", --hq
							["player"] = 
							{ 
								"multi_neut_base_captured_p", 
							},
						},
						["supply"] = 
						{
							"multi_neut_supply_captured",
						},
					},
					["nmy"] = 
					{
						["base"] = 
						{
							"multi_nmy_neut_hq_captured",
						},
						["supply"] = 
						{
							"multi_nmy_neut_supply_captured",
						},
					},
				},
				["nmy"] = 
				{
					["own"] = 
					{
						["base"] = 
						{
							"multi_nmy_base_captured", --hq
							["player"] = 
							{ 
								"multi_nmy_base_captured_p", 
							},
						},
						["supply"] = 
						{
							"multi_nmy_supply_captured",
						},
					},
					["nmy"] = 
					{
						["base"] = 
						{
							"multi_own_base_captured",
						},
						["supply"] = 
						{
							"multi_own_supply_captured",
						},
					},
				},		
			},
		},
		["ship"] =
		{
			["base"] = 
			{		
				["nmy"] = 
				{
					"multi_own_ship_capture_nmy_hq",
				},
				["neu"] = 
				{
					"multi_own_ship_capture_neut_base",
				},
			},
			["supply"] = 
			{
				["nmy"] = 
				{
					"multi_own_ship_capture_supply",
				},
				["neu"] = 
				{
					"multi_own_ship_capture_neut_base",
				},
			},
			["range"] =
			{ 
				"multi_land_range",
			},
		},
		
		-- TODO: CODE NEEDED 
		-- SINGLE
		["enemy_started"] =  
		{
			"landingboat_spwn_dispatcher",
		},
		["conq_neut"] =  
		{
			"neut_cmd_building_conq_dispatcher",
		},
		["nmy_conq_neut"] =  
		{
			"neut_cmd_building_nmy_conq_dispatcher",
		},
		["conq_nmy"] =  
		{
			"nmy_cmd_building_conq_dispatcher",
			"nmy_cmd_building_conq_dispatcher2",
		},
		["nmy_conq_own"] =  
		{
			"cmd_building_lost_dispatcher",
		},
		["neut_nmy"] =  
		{
			"nmy_cmd_building_neut_dispatcher",
		},
	},
}
------------------------------------------------------------------------------------
-- eddig van kesz
------------------------------------------------------------------------------------
