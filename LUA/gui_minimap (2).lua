GuiScreen = {
	["geOrder"] = 0,
	["capture_icon_Group"] = {
		["Pos"] = { 0.878125, 0.370833, -20.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 1,
		["bluecapture_Section"] = {
			["Pos"] = { 0.238000, 0.008000, 0.000000 },
			["Size"] = { 0.206400, 0.206400 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["StartAngle"] = 3.141500,
			["Texture"] = "gui/minimap/capture_bar_blue.tga",
			["ClockWise"] = false,
			["RimWidthPercent"] = 0.160000,
			["TextureMode"] = 1,
		},
		["capturebg_Section"] = {
			["Pos"] = { 0.238000, 0.008000, 1.000000 },
			["Size"] = { 0.210000, 0.210000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.000000, 0.000000, 0.000000, 0.500000 },
			["geOrder"] = 0,
			["StartAngle"] = 3.141500,
			["Texture"] = "gui/minimap/capture_bar_red.tga",
			["RimWidthPercent"] = 0.200000,
			["TextureMode"] = 1,
		},
		["icon_big_hl_Icon"] = {
			["Pos"] = { 0.219123, 0.261194, -14.000000 },
			["Size"] = { 0.033333, 0.044444 },
			["Pivot"] = { -0.055556, 1.583333 },
			["Color"] = { 0.796078, 0.623529, 0.494118, 0.400000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/capture_icon_empty.tga",
				},
			},
		},
		["icon_big_Icon"] = {
			["Pos"] = { 0.237872, 0.211195, -11.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 3,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/capture_icon.tga",
				},
			},
		},
		["icon_big_item_hit_Icon"] = {
			["Pos"] = { 0.237872, 0.211195, -9.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 4,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/capture_icon_hit.tga",
				},
			},
		},
		["icon_big_item_Icon"] = {
			["Pos"] = { 0.237872, 0.211195, -10.000000 },
			["Size"] = { 0.037500, 0.050000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 4,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/capture_icon_USN.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/capture_icon_IJN.tga",
				},
				[3] = {
					["Texture"] = "gui/minimap/capture_icon_NTR.tga",
				},
			},
		},
		["redcapture_Section"] = {
			["Pos"] = { 0.238000, 0.008000, 0.000000 },
			["Size"] = { 0.206400, 0.206400 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["StartAngle"] = 3.141500,
			["Texture"] = "gui/minimap/capture_bar_red.tga",
			["RimWidthPercent"] = 0.160000,
			["TextureMode"] = 1,
		},
	},
	["minimap_compass_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -12.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 15,
		["States"] = {
			[1] = {
				["Texture"] = "gui/minimap/minimap_compass.tga",
			},
		},
	},
	["minimap_dest_yellow_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -21.000000 },
		["Pivot"] = { 0.500000, 6.250000 },
		["WideScreenAlign"] = "Right",
		["Visible"] = false,
		["geOrder"] = 12,
		["States"] = {
			[1] = {
				["Texture"] = "gui/minimap/minimap_destination.tga",
			},
		},
	},
	["minimap_dir_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -24.000000 },
		["Pivot"] = { 0.066667, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 13,
		["States"] = {
			[1] = {
				["Texture"] = "gui\\minimap\\minimap_direction02.tga",
			},
		},
	},
	["minimap_frame_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -22.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 11,
		["States"] = {
			[1] = {
				["Texture"] = "gui/minimap/minimap_frame.tga",
			},
		},
	},
	["minimap_hl_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -23.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Color"] = { 1.000000, 1.000000, 1.000000, 0.200000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 10,
		["States"] = {
			[1] = {
				["Texture"] = "gui/minimap/minimap_glass.tga",
			},
		},
	},
	["minimap_islandmap_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -5.000000 },
		["Size"] = { 0.625001, 0.833335 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 16,
		["ShaderName"] = "minimap_terrain.mshd",
		["States"] = {
			[1] = {
				["Texture"] = "error.tga",
			},
		},
	},
	["minimap_units_blue_Group"] = {
		["Pos"] = { 0.643750, 0.330555, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 6,
		["item_ship_Icon"] = {
			["Pos"] = { 0.331250, 0.250000, -10.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.047059, 0.066667, 0.913725, 1.000000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
			},
		},
	},
	["minimap_units_grey_Group"] = {
		["Pos"] = { 0.643750, 0.359722, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 7,
		["item_ship_Icon"] = {
			["Pos"] = { 0.331250, 0.250000, -10.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.521569, 0.521569, 0.521569, 1.000000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
			},
		},
	},
	["minimap_units_red_Group"] = {
		["Pos"] = { 0.643750, 0.304166, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 4,
		["item_ship_Icon"] = {
			["Pos"] = { 0.331250, 0.250000, -10.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 1.000000, 0.090196, 0.090196, 1.000000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
			},
		},
	},
	["minimap_units_silver_Group"] = {
		["Pos"] = { 0.643750, 0.226389, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 9,
		["item_ship_Icon"] = {
			["Pos"] = { 0.331250, 0.250000, -10.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.501961, 1.000000, 1.000000, 1.000000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
			},
		},
	},
	["minimap_units_white_Group"] = {
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 3,
		["item_building_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -16.000000 },
			["Size"] = { 0.008333, 0.011111 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_building.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
			},
		},
		["item_marker_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -17.000000 },
			["Size"] = { 0.010417, 0.013889 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ping.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
				[3] = {
					["Texture"] = "gui/minimap/item_ping_attack.tga",
				},
				[4] = {
					["Texture"] = "gui/minimap/item_ping_defend.tga",
				},
			},
		},
		["item_plane_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -18.000000 },
			["Size"] = { 0.004167, 0.005556 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_plane.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
			},
		},
		["item_prioutofrange_yellow_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -19.000000 },
			["Pivot"] = { 0.500000, 6.250000 },
			["geOrder"] = 8,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
			},
		},
		["item_ship_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -17.000000 },
			["Size"] = { 0.013542, 0.006944 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
			},
		},
		["item_sub_Icon"] = {
			["Pos"] = { 0.000000, 0.000000, -15.000000 },
			["Size"] = { 0.012500, 0.004167 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_sub.tga",
				},
				[2] = {
					["Texture"] = "gui/minimap/minimap_destination.tga",
				},
			},
		},
	},
	["minimap_units_yellow_Group"] = {
		["Pos"] = { 0.643750, 0.251389, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 8,
		["item_ship_Icon"] = {
			["Pos"] = { 0.331250, 0.250000, -10.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 1.000000, 1.000000, 0.000000, 1.000000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "gui/minimap/item_ship.tga",
				},
			},
		},
	},
	["minimap_visibility_Icon"] = {
		["Pos"] = { 0.866667, 0.165278, -13.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 14,
		["States"] = {
			[1] = {
				["Texture"] = "gui/minimap/minimap_visibility.tga",
			},
		},
	},
	["unit_marker_Group"] = {
		["Pos"] = { 0.865167, 0.164028, -5.000000 },
		["WideScreenAlign"] = "Right",
		["geOrder"] = 0,
	},
}
