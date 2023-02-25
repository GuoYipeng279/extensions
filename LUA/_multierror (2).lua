--DoFile("interface/_Dialogue.lua")
--bgGroup = GuiScreen
--bgGroup.Pos = nil

GuiScreen =
{
	["Priority"] = 193,
	["Pos"] = { 0, 0, -3600 },

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
		["Pos"] = { 0.501042, 0.502778, 1.000000 },
		["Size"] = { 0.572917, 0.486111 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 8,
		["Options_Listbox"] =
		{
			["Pos"] = { 0.000000, 0.000000, -1.000000 },
			["geOrder"] = 0,
			["Yes_Text"] =
			{
				["Size"] = { 0.25, 0.06 },
				["Pos"] = { 0.27, 0.64-0.251389, -1 },
				["Font"] = "Viper19",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["DefaultText"] = Platform("globals.yes", "globals.dialog_yes"),
				["MouseHit"] = true,
				["MISColors"] = GetMISCols(),
				["DefaultShadow"] = 0,
			},
			["No_Text"] =
			{
				["Size"] = { 0.2, 0.06 },
				["Pos"] = { 0.53, 0.64-0.251389, -1 },
				["Font"] = "Viper19",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["DefaultText"] = Platform("globals.no", "globals.dialog_no"),
				["MouseHit"] = true,
				["MISColors"] = GetMISCols(),
				["DefaultShadow"] = 0,
			},
			["Accept_Text"] =
			{
				["Size"] = { 0.2, 0.06 },
				["Pos"] = { 0.40, 0.64-0.251389, -1 },
				["Font"] = "Viper19",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["DefaultText"] = Platform("globals.accept", "globals.dialog_accept"),
				["MouseHit"] = true,
				["MISColors"] = GetMISCols(),
				["DefaultShadow"] = 0,
			},
			["AutoControl"] = true,
			["DontMoveTheItems"] = true,
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

--	["Bg_Group"] = bgGroup,

	["Message_Text"] =
	{
		["Size"] = { 0.5, 0.5 },
		["Pos"] = { 0.5, 0.45, -1 },
		["Pivot"] = { 0.5, 0.5 },
		["Font"] = "Viper19",
		["Align"] = "Center",
		["VerticalAlign"] = "Center",
	},
	["MessageLower_Text"] =
	{
		["Size"] = { 0.5, 0.5 },
		["Pos"] = { 0.5, 0.45, -1 },
		["Pivot"] = { 0.5, 0.5 },
		["Font"] = "Arial20",
		["Align"] = "Center",
		["VerticalAlign"] = "Center",
	},
}
