GuiScreen = {
	["Priority"] = 80,

	["MoviePlay_Movie"] =
	{
		["Size"] = { 1.334, 1 },
		["Pivot"] = { 0.5, 0.5 },
		["Pos"] = { 0.5, 0.5, -100 },
		["Visible"] = false,
	},
	["ShrinkWideScreen_Movie"] =
	{
		["Size"] = { 1, 0.75 },
		["Pivot"] = { 0.5, 0.5 },
		["Pos"] = { 0.5, 0.5, -100 },
		["Visible"] = false,
		["BlackBg_Icon"] =
		{
			["Size"] = { 1.334, 1 },
			["Pivot"] = { 0.5, 0.5 },
			["Pos"] = { 0.5, 0.375, 1 },
			["HasTexture"] = false,
			["Color"] = { 1, 1, 1, 0 },
		},
	},
	["BlackMovie_Icon"] = {
		["Pos"] = { -1.000000, -1.000000, -4999.000000 },
		["Size"] = { 3.000000, 3.000000 },
		["WideScreenAlign"] = "Left",
		["Visible"] = false,
		["geOrder"] = 1,
		["States"] = {
			[1] = {
				["Texture"] = "common/elements/black_bar.tga",
			},
		},
	},
	["SubtitlesNormal_Text"] =
	{
		["Size"] = { 0.85, 0.15 },
		["Pos"] = Platform({ 0.5, 0.96, -5000 }, { 0.5, 0.93, -5000 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},
	["SubtitlesWideScreen_Text"] =
	{
		["Size"] = { 1.183, 0.15 },
		["Pos"] = Platform({ 0.5, 0.96, -5000 }, { 0.5, 0.93, -5000 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},
}
