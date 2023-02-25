GuiScreen = {
	["Priority"] = 1000,
	["geOrder"] = 1,
	["All_Group"] = {
		["Pos"] = { 0.000000, 0.000000, 1000.000000 },
		["geOrder"] = 0,
		["Arrow_Icon"] = {
			["Pos"] = { -9999.000000, 0.500000, 500.000000 },
			["Size"] = { 0.362500, 0.091667 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/arrow_ai.tga",
				},
				[2] = {
					["Texture"] = "gui/map/arrow_other.tga",
				},
				[3] = {
					["Texture"] = "gui/map/arrow_actunit.tga",
				},
			},
		},
		["distance_A_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 12,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_distance_begin.tga",
				},
			},
		},
		["distance_B_Icon"] = {
			["Pos"] = { 0.583334, 0.494444, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 20,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_distance_end.tga",
				},
			},
		},
		["filter_item_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Size"] = { 0.031250, 0.034722 },
			["WideScreenAlign"] = "Right",
			["geOrder"] = 21,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/filter_off.tga",
				},
				[2] = {
					["Texture"] = "gui/map/filter_health.tga",
				},
				[3] = {
					["Texture"] = "gui/map/filter_base.tga",
				},
				[4] = {
					["Texture"] = "gui/map/filter_powerup.tga",
				},
				[5] = {
					["Texture"] = "gui/map/filter_repair.tga",
				},
			},
		},
		["filter_panel2_Icon"] = {
			["Pos"] = { 0.750208, 0.119445, -990.000000 },
			["WideScreenAlign"] = "Right",
			["geOrder"] = 18,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/filter_main.tga",
				},
			},
		},
		["filter_panel_Icon"] = {
			["Pos"] = { 0.750208, 0.049445, 0.000000 },
			["WideScreenAlign"] = "Right",
			["geOrder"] = 16,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/filter_main.tga",
				},
			},
		},
		["filter_Text"] = {
			["Pos"] = { 0.770208, 0.130445, -990.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["WideScreenAlign"] = "Right",
			["geOrder"] = 17,
			["Font"] = "Arial16",
			["DefaultText"] = "None",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
		},
		["HealthTemplate2_Icon"] = {
			["Pos"] = { 0.478125, 0.555555, -10.000000 },
			["geOrder"] = 23,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_health_back.tga",
				},
			},
		},
		["USCaptureTemplate_Icon"] = {
			["Pos"] = { 0.478125, 0.555555, -11.000000 },
			["geOrder"] = 24,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_blue.tga",
				},
			},
		},
		["JapCaptureTemplate_Icon"] = {
			["Pos"] = { 0.478125, 0.555555, -11.000000 },
			["geOrder"] = 24,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_red.tga",
				},
			},
		},
		["HealthTemplate_Icon"] = {
			["Pos"] = { 0.478125, 0.555555, -11.000000 },
			["geOrder"] = 24,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_health.tga",
				},
			},
		},
		["map_corner_Icon"] = {
			["Pos"] = { 0.481250, 0.515278, -2.000000 },
			["geOrder"] = 22,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_corner.tga",
				},
			},
		},
		["MessageHistory_Group"] = {
			["Pos"] = { -9999.000000, 0.000000, -6.000000 },
			["Size"] = { 0.250000, 1.000000 },
			["geOrder"] = 4,
			["Template_Text"] = {
				["Size"] = { 0.250000, 0.020000 },
				["geOrder"] = 0,
				["Font"] = "Arial15",
				["Multiline"] = false,
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
			},
		},
		["MessageMarker_Text"] = {
			["Pos"] = { 0.000000, 0.000000, -8.000000 },
			["Size"] = { 0.200000, 0.030000 },
			["Pivot"] = { 0.000000, 1.000000 },
			["geOrder"] = 1,
			["Font"] = "Arial15",
			["Multiline"] = false,
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
		},
		["mission_HL_Icon"] = {
			["Pos"] = { 0.750208, 0.132778, 0.000000 },
			["geOrder"] = 9,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/filter_highlight.tga",
				},
			},
		},
--		["objective_Icon"] = {
--			["Pos"] = { 0.518750, 0.494444, 0.000000 },
--			["Size"] = { 0.066667, 0.088889 },
--			["Pivot"] = { 0.500000, 0.500000 },
--			["geOrder"] = 13,
--			["States"] = {
--				[1] = {
--					["Texture"] = "gui/map/map_obj_primary.tga",
--				},
--				[2] = {
--					["Texture"] = "gui/map/map_obj_secondary.tga",
--				},
--			},
--		},
		["PlayerNameTemplate_Text"] = {
			["Pos"] = { 0.000000, 0.000000, -6.000000 },
			["Size"] = { 0.200000, 0.030000 },
			["Pivot"] = { 0.000000, 0.500000 },
			["geOrder"] = 5,
			["Font"] = "Arial15",
			["Multiline"] = false,
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["PlayerTalkingTemplate_Icon"] = {
			["Pos"] = { -9999.000000, 0.000000, -5.000000 },
			["geOrder"] = 8,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/map_voicecom.tga",
				},
			},
		},
		["popup_FrameBox"] = {
			["Pos"] = { 0.470833, 0.457639, 10.000000 },
			["Size"] = { 0.050000, 0.070000 },
			["geOrder"] = 7,
			["FrameSizesX"] = { 0.016660, 0.016660 },
			["FrameSizesY"] = { 0.022220, 0.022220 },
			["States"] = {
				[1] = {
					["Texture"] = "common/framebox/framebox_05.tga",
				},
			},
		},
		["PupTemplate_Icon"] = {
			["Pos"] = { -9999.000000, 0.000000, -5.000000 },
			["geOrder"] = 3,
			["States"] = {
				[1] = {
					["Texture"] = "common/icons/powerup/ADVANCED_PLANES_s.tga",
				},
			},
		},
		["radio_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 11,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/map_radio.tga",
				},
			},
		},
		["actunit_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 11,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/map_actunit.tga",
				},
			},
		},
		["select_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 15,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/map_select.tga",
				},
			},
		},
		["target_Icon"] = {
			["Pos"] = { 0.518750, 0.494444, 0.000000 },
			["Size"] = { 0.033333, 0.044444 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 14,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/map_target.tga",
				},
				[2] = {
					["Texture"] = "gui/map/map_target02.tga",
					["Size"] = { 0.020833, 0.027778 },
				},
			},
		},
		["unit_name_Text"] = {
			["Pos"] = { 0.761459, 0.702777, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 10,
			["Font"] = "Arial16",
			["DefaultText"] = "unit name",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
		},
		["WarningTemplate_Icon"] = {
			["Pos"] = { -9999.000000, 0.000000, -5.000000 },
			["Size"] = { 0.036458, 0.048611 },
			["geOrder"] = 6,
			["States"] = {
				[1] = {
					["Texture"] = "gui/map/info_water_on.tga",
				},
				[2] = {
					["Texture"] = "gui/map/info_fire_on.tga",
				},
				[3] = {
					["Texture"] = "gui/map/info_gun_on.tga",
				},
				[4] = {
					["Texture"] = "gui/map/info_engine_on.tga",
				},
				[5] = {
					["Texture"] = "gui/map/info_periscope_on.tga",
				},
				[6] = {
					["Texture"] = "gui/map/info_water_off.tga",
				},
				[7] = {
					["Texture"] = "gui/map/info_fire_off.tga",
				},
				[8] = {
					["Texture"] = "gui/map/info_gun_off.tga",
				},
				[9] = {
					["Texture"] = "gui/map/info_engine_off.tga",
				},
				[10] = {
					["Texture"] = "gui/map/info_periscope_off.tga",
				},
			},
		},
	},
}
