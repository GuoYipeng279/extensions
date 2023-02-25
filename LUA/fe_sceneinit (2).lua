GuiScreen = {
	["Priority"] = -10000,
	["Pos"] = { 0.000000, 0.000000, -1000.000000 },
	["geOrder"] = 4,
	["bg_Group"] = {
		["geOrder"] = 4,
		["bottomFrame_Icon"] = {
			["Pos"] = { -0.166667, 0.823611, -60.000000 },
			["geOrder"] = 4,
			["States"] = {
				[1] = {
					["Texture"] = "fe/frame/frame_topbottom.tga",
				},
			},
		},
--		["bottomFrame_shadow_Icon"] = {
--			["Pos"] = { 0.468750, 0.833333, -58.000000 },
--			["Size"] = { 1.400000, 0.033333 },
--			["Pivot"] = { 0.500000, 1.000000 },
--			["geOrder"] = 9,
--			["States"] = {
--				[1] = {
--					["Texture"] = "fe/frame/frame_shadow.tga",
--				},
--			},
--		},
		["FE_bg_11_Icon"] = {
			["Pos"] = { 0.500000, 0.500000, -5.000000 },
			["Size"] = { 1.333333, 0.683333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["States"] = {
				[1] = {
					["Texture"] = "fe/bg/loading.tga",
				},
			},
		},
		["FE_bg_12_Icon"] = {
			["Pos"] = { 0.500000, 0.500000, -51.000000 },
			["Size"] = { 1.333333, 0.683333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 1.000000, 1.000000, 1.000000, 0.200000 },
			["geOrder"] = 0,
			["States"] = {
				[1] = {
					["Texture"] = "fe/bg/loading.tga",
				},
			},
		},
		["frameFlag_Icon"] = {
			["Pos"] = { 0.500000, 0.081944-20/720, -62.000000 },
			["Size"] = { 1.333333, 168/720 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
			["geOrder"] = 1,
			["States"] = {
				[1] = {
					["Texture"] = "fe/frame/frame_USA.tga",
				},
				[2] = {
					["Texture"] = "fe/frame/frame_IJN.tga",
				},
				[3] = {
					["Texture"] = "fe/frame/frame_NTR.tga",
				},
			},
		},
		["loadingLogo_FrameBox"] = {
			["Pos"] = { 0.500000, 0.154167, -70.000000 },
			["Size"] = { 0.533333, 0.177777 },
			["Pivot"] = { 0.500000, 0.488281 },
			["geOrder"] = 7,
			["FrameSizesX"] = { 0.156250, 0.156250 },
			["FrameSizesY"] = { 0.087500, 0.087500 },
			["States"] = {
				[1] = {
					["Texture"] = "common/title.tga",
				},
			},
		},
		["title_Text"] = {
			["Pos"] = { 0.500000, 0.166667, -75.000000 },
			["Size"] = { 0.800000, 0.037500 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.803922, 0.588235, 0.333333, 1.000000 },
			["geOrder"] = 8,
			["Font"] = "Viper19",
			["DefaultText"] = "MAIN MENU",
			["Align"] = "Center",
			["VerticalAlign"] = "Center",
			["DefaultShadow"] = 0,
		},
		["titleLogo_Icon"] = {
			["Pos"] = { 0.500000, 0.136111, -65.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Visible"] = false,
			["geOrder"] = 5,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\logo_bsp.tga",
				},
			},
		},
		["topFrame_Icon"] = {
			["Pos"] = { -0.166667, -0.177778, -60.000000 },
			["geOrder"] = 3,
			["States"] = {
				[1] = {
					["Texture"] = "fe/frame/frame_topbottom.tga",
				},
			},
		},
--		["topFrame_shadow_Icon"] = {
--			["Pos"] = { 0.476042, 0.166667, -58.000000 },
--			["Size"] = { 1.400000, 0.033333 },
--			["Pivot"] = { 0.500000, 0.000000 },
--			["geOrder"] = 10,
--			["States"] = {
--				[1] = {
--					["Texture"] = "fe/frame/frame_shadow.tga",
--					["UV_LURB"] = {
--						[1] = 0.000000,
--						[2] = 1.000000,
--						[3] = 1.000000,
--						[4] = 0.000000,
--					},
--				},
--			},
--		},
	},
	["hint_Text"] = {
		["Pos"] = { 0.500000, 0.994444, -100.000000 },
		["Size"] = { 0.750000, 0.050000 },
		["Pivot"] = { 0.500000, 4.433334 },
		["Color"] = { 0.858824, 0.670588, 0.415686, 1.000000 },
		["geOrder"] = 1,
		["Font"] = "Arial16",
		["DefaultText"] = "HINT: The landing ships capture the command buildings faster than the normal ships.",
		["Align"] = "Center",
		["VerticalAlign"] = "Top",
		["DefaultShadow"] = 0,
	},
	["Message_Text"] = {
		["Pos"] = { 0.500000, 0.951748, -10.000000 },
		["Size"] = { 0.312500, 0.100000 },
		["Pivot"] = { 0.500000, 2.323475 },
		["Color"] = { 0.858824, 0.670588, 0.415686, 1.000000 },
		["geOrder"] = 5,
		["Font"] = "Viper19",
		["DefaultText"] = "PRESS ANY KEY",
		["Multiline"] = false,
		["Align"] = "Center",
		["VerticalAlign"] = "Top",
		["DefaultShadow"] = 0,
	},
}
