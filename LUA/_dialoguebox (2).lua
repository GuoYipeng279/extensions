DoFile("interface/_Dialogue.lua")
bgGroup = GuiScreen
bgGroup.Pos = nil

GuiScreen = {
	["Priority"] = -100000,
	["Pos"] = { 0.000000, 0.000000, -5010.000000 },
	["geOrder"] = 0,
	["Bg_Group"] = bgGroup,
	["background_Icon"] = {
		["Pos"] = { 0.500000, 0.500000, 10.000000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Size"] = { 1.5, 1.000000 },
		["geOrder"] = 3,
		["Color"] = { 0.000000, 0.000000, 0.000000, 1.000000 },
		["States"] = {
			[1] = {
				["Texture"] = "common/whiteGui.tga",
			},
		},
	},
	["dialog_BG_FrameBox"] = {
		["Pos"] = { 0.214583, 0.259722, 1.000000 },
		["Size"] = { 0.572917, 0.486111 },
		["geOrder"] = 8,
		["Options_Listbox"] = {
			["Pos"] = { 0.000000, 0.000000, -1.000000 },
			["geOrder"] = 0,
			["Accept_Text"] = {
				["Pos"] = { 0.185417, 0.380556, -1.000000 },
				["Size"] = { 0.200000, 0.060000 },
				["geOrder"] = 0,
				["MouseHit"] = true,
				["Font"] = "Viper19",
				["DefaultText"] = "globals.accept",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
			["Checkpoint_Text"] = {
				["Pos"] = { 0.185417, 0.380556, -1.000000 },
				["Size"] = { 0.200000, 0.060000 },
				["geOrder"] = 0,
				["MouseHit"] = true,
				["Font"] = "Viper19",
				["DefaultText"] = "globals.restartmission",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
			["No_Text"] = {
				["Pos"] = { 0.350000, 0.380556, -1.000000 },
				["Size"] = { 0.200000, 0.060000 },
				["geOrder"] = 0,
				["MouseHit"] = true,
				["Font"] = "Viper19",
				["DefaultText"] = "globals.no",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
			["Yes_Text"] = {
				["Pos"] = { 0.025000, 0.380556, -1.000000 },
				["Size"] = { 0.250000, 0.060000 },
				["geOrder"] = 0,
				["MouseHit"] = true,
				["Font"] = "Viper19",
				["DefaultText"] = "globals.yes",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
			["DontMoveTheItems"] = true,
			["AutoControl"] = true,
		},
		["States"] = {
			[1] = {
				["Texture"] = "common/framebox/framebox_06.tga",
			},
			[2] = {
				["Texture"] = "common/framebox/framebox_07.tga",
			},
		},
	},
	["Gamertag_Text"] = {
		["Pos"] = { 0.500000, 0.344444, -1.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.000000 },
		["Visible"] = true,
		["geOrder"] = 0,
		["Font"] = "Arial20",
		["DefaultText"] = "Kuk4cmuk1",
		["Align"] = "Center",
		["VerticalAlign"] = "Top",
	},
	["Message_Text"] = {
		["Pos"] = { 0.500000, 0.400000, -1.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.000000 },
		["geOrder"] = 0,
		["Font"] = "Viper19",
		["Align"] = "Center",
		["VerticalAlign"] = "Top",
	},
}
