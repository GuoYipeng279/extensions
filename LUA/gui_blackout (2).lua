GuiScreen =
{
	["Priority"] = -1000,

	["Blackout_Icon"] =
	{
		["Size"] = { 3.0, 3.0 },
		["Pivot"] = { 0.5, 0.5 },
		["Pos"] = { 0.5, 0.5, -999 },
		["HasTexture"] = false,
		["Color"] = { 1, 1, 1, 0 },
	},

	["Message_Text"] =
	{
		["Size"] = Platform({ 0.53, 0.15 }, { 0.45, 0.15 }),
		["Pos"] = Platform({ 0.55, 0.96, -200 }, { 0.55, 0.93, -200 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},
	["MessageWideScreen_Text"] =
	{
		["Size"] = Platform({ 0.863, 0.15 }, { 0.783, 0.15 }),
		["Pos"] = Platform({ 0.55, 0.96, -200 }, { 0.55, 0.93, -200 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},
	["MessageMovie_Text"] =
	{
		["Size"] = { 0.85, 0.15 },
		["Pos"] = Platform({ 0.5, 0.96, -200 }, { 0.5, 0.93, -200 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},
	["MessageMovieWideScreen_Text"] =
	{
		["Size"] = { 1.183, 0.15 },
		["Pos"] = Platform({ 0.5, 0.96, -200 }, { 0.5, 0.93, -200 }),
		["Pivot"] = { 0.5, 1.0 },
		["Font"] = "Arial16",
		["Align"] = "Center",
		["VerticalAlign"] = "Bottom",
		["Color"] = { 0.94, 0.94, 0.94, 1 },
		["DefaultShadow"] = 0,
	},

	["Warnings_Group"] =
	{
		["Size"] = { 1, 0.95 },
		["Pos"] = { 0, 0.05, -8 },
		["MessageBoxTemplate_Group"] =
		{
			["Size"] = { 1.000, 0.042 },
			["Pos"] = { 0, 0, 0 },
			["Message_Text"] =
			{
				["Size"] = { 1.000, 0.042 },
				["Pos"] = { 0, 0, 0 },
				["Font"] = "Arial16",
				["Color"] = { 1, 1, 1, 1 },
				["Align"] = "Center",
			},
			["Shortcut_Icon"] =
			{
				["Size"] = { 0.031, 0.042 },
				["Pos"] = { -9999, 0.021, 1 },
				["Pivot"] = { 0.5, 0.5 },
				["States"] = { { ["Texture"] = "common/whiteGui.tga", }, },
			},
		},
	},
	["Dialogs_Group"] =
	{
		["Pos"] = { 0, 0, -10 },
		["Pivot"] = { 0, 0 },

		["1_Group"] =
		{
			["Pos"] = { 0, 0, -10 },
			["Pivot"] = { 0, 0 },
			["Picture_Icon"] =
			{
				["Visible"] = false,
				["Size"] = { 0.156, 0.156 },
				["Pos"] = { -0.010, 0.070, 4 },
			},
			["Name_Text"] =
			{
				["Visible"] = false,
				["Size"] = { 0.750, 0.031 },
				["Pos"] = { 0.125, 0.160, -1 },
				["Font"] = "Arial16",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
				["Color"] = { 0.95, 0.2, 0.2, 255 },
			},
		},
	},


}
