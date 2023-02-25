GuiScreen = {
	["Pos"] = { 0.000000, 0.000000, -501.000000 },
	["geOrder"] = 0,
	["Header_Group"] = {
		["Pos"] = { 0.500000, 0.485833, 501.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 3,
		["USN_Icon"] = {
			["Pos"] = { 0.035937, 0.087500, -509.000000 },
			["Size"] = { 0.046875, 0.048611 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 8,
			["States"] = {
				[1] = {
					["Texture"] = "common\\worldmap\\flag_USA2.tga",
				},
				[2] = {
					["Texture"] = "common\\worldmap\\flag_IJN2.tga",
				},
			},
		},
		["USN_point_Text"] = {
			["Pos"] = { 0.381250, 0.085000, -509.000000 },
			["Size"] = { 0.104167, 0.047222 },
			["Pivot"] = { 0.000000, 0.500002 },
			["Color"] = { 0.900000, 0.900000, 0.960000, 1.000000 },
			["geOrder"] = 9,
			["Font"] = "Arial18",
			["DefaultText"] = "20000000",
			["Align"] = "Right",
			["VerticalAlign"] = "Center",
			["Shadowed"] = true,
			["ShadowPos"] = "Behind",
		},
		["USN_Text"] = {
			["Pos"] = { 0.075000, 0.084722, -509.000000 },
			["Size"] = { 0.263542, 0.047222 },
			["Pivot"] = { 0.000000, 0.500000 },
			["Color"] = { 0.900000, 0.900000, 0.960000, 1.000000 },
			["geOrder"] = 7,
			["line_2_FrameBox"] = {
				["Pos"] = { 0.175000, -0.001388, 0.000000 },
				["Size"] = { 0.500000, 0.005556 },
				["Pivot"] = { 0.500000, 0.500000 },
				["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
				["geOrder"] = 1,
				["FrameSizesX"] = { 0.004167, 0.004167 },
				["FrameSizesY"] = { 0.005556, 0.005556 },
				["States"] = {
					[1] = {
						["Texture"] = "common/framebox/framebox_05.tga",
					},
				},
			},
			["line_3_FrameBox"] = {
				["Pos"] = { 0.175000, 0.045834, 0.000000 },
				["Size"] = { 0.500000, 0.005556 },
				["Pivot"] = { 0.500000, 0.500000 },
				["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
				["geOrder"] = 0,
				["FrameSizesX"] = { 0.004167, 0.004167 },
				["FrameSizesY"] = { 0.005556, 0.005556 },
				["States"] = {
					[1] = {
						["Texture"] = "common/framebox/framebox_05.tga",
					},
				},
			},
			["Font"] = "Arial18",
			["DefaultText"] = "USN",
			["Align"] = "Left",
			["VerticalAlign"] = "Center",
			["Shadowed"] = true,
			["ShadowPos"] = "Behind",
		},
	},
	["Main_FrameBox"] = {
		["Pos"] = { 0.500000, 0.500000, 502.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 4,
		["States"] = {
			[1] = {
				["Texture"] = "common/framebox/framebox_05.tga",
			},
		},
	},
	["Main_Listbox"] = {
		["Pos"] = { 0.478792, 0.322055, -1.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["HL_Icon"] = {
			["Pos"] = { 0.200000, 0.000000, 0.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Visible"] = false,
			["geOrder"] = 1,
			["States"] = {
				[1] = {
					["Texture"] = "gui\\support_powerup\\frame_highlight_l.tga",
				},
			},
		},
		["Player_Group"] = {
			["Pos"] = { 0.000000, 0.000000, 502.000000 },
			["Size"] = { 0.460000, 0.033330 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["Connection_Group"] = {
				["Pos"] = { 0.235375, 0.008944, -18.000000 },
				["Size"] = { 0.416667, 0.034722 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 1,
				["ping_1_Icon"] = {
					["Pos"] = { 0.354166, 0.021528, -4.000000 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 0,
					["States"] = {
						[1] = {
							["Texture"] = "common\\connection_green.tga",
						},
					},
				},
				["ping_2_Icon"] = {
					["Pos"] = { 0.360416, 0.021528, -4.000000 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 0,
					["States"] = {
						[1] = {
							["Texture"] = "common\\connection_green.tga",
						},
					},
				},
				["ping_3_Icon"] = {
					["Pos"] = { 0.366666, 0.021528, -4.000000 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 0,
					["States"] = {
						[1] = {
							["Texture"] = "common\\connection_green.tga",
						},
					},
				},
				["ping_4_Icon"] = {
					["Pos"] = { 0.372916, 0.021528, -4.000000 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 0,
					["States"] = {
						[1] = {
							["Texture"] = "common\\connection_green.tga",
						},
					},
				},
				["ping_5_Icon"] = {
					["Pos"] = { 0.379166, 0.021528, -4.000000 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 0,
					["States"] = {
						[1] = {
							["Texture"] = "common\\connection_green.tga",
						},
					},
				},
			},
			["mic_Icon"] = {
				["Pos"] = { 0.361625, 0.014054, 0.000000 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common\\speaker.tga",
					},
				},
			},
			["Player_clan_Text"] = {
				["Pos"] = { 0.032292, 0.013000, -509.000000 },
				["Size"] = { 0.052083, 0.047222 },
				["Pivot"] = { 0.500000, 0.500000 },
				["Color"] = { 1.282353, 1.282353, 1.282353, 1.000000 },
				["geOrder"] = 5,
				["Font"] = "Arial16",
				["DefaultText"] = " ",
				["Align"] = "Center",
				["VerticalAlign"] = "Center",
				["Shadowed"] = true,
				["ShadowPos"] = "Behind",
			},
			["Player_name_Text"] = {
				["Pos"] = { 0.079167, 0.013000, -509.000000 },
				["Size"] = { 0.312500, 0.047222 },
				["Pivot"] = { 0.000000, 0.500000 },
				["Color"] = { 1.282353, 1.282353, 1.282353, 1.000000 },
				["geOrder"] = 2,
				["Font"] = "Arial16",
				["DefaultText"] = "WWWWWWWWWWWWWWWW",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["Shadowed"] = true,
				["ShadowPos"] = "Behind",
			},
			["Player_point_Text"] = {
				["Pos"] = { 0.382250, 0.012388, -509.000000 },
				["Size"] = { 0.104167, 0.047222 },
				["Pivot"] = { 0.000000, 0.500002 },
				["Color"] = { 1.282353, 1.282353, 1.282353, 1.000000 },
				["geOrder"] = 3,
				["Font"] = "Arial16",
				["DefaultText"] = "20000000",
				["Align"] = "Right",
				["VerticalAlign"] = "Center",
				["Shadowed"] = true,
				["ShadowPos"] = "Behind",
			},
		},
		["DontMoveTheItems"] = true,
		["AutoControl"] = true,
		["CenterVertical"] = true,
		["Items"] = {
			[1] = "Player_Group",
		},
	},
}
