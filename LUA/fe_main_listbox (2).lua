GuiScreen =
{
	["Editable"] = true,
	["Priority"] = 170,
	["ClearProps"] = "All",


--	["AlapIze_Group"] = GetAlapIze("", false),

	["Main_Listbox"] = CreateStandardMenu2({ 0.0825, 0.48, -1 }, nil, nil, true, "Left"),

	["Sub_Listbox"] = CreateStandardMenu({ 0.55, 0.48, -1 }, nil, nil, true),

	
--	["HelpText_Group"] =
--	{
--		["Size"] = { 0.2, 0.13 },
--		["Pos"] = { 0.06, 0.650, -1 },
--		["Pivot"] = { 0.000000, 0.000000 },
--		["WideScreenAlign"] = "Left",
--		["Help_Text"] =
--		{
--			["Size"] = { 0.2, 0.13 },
--			["Pos"] = { 0.0, 0.0, -99 },
--			["Pivot"] = { 0.000000, 0.000000 },
--			["Font"] = "Arial18",
--			["Color"] = { 0.63, 0.63, 0.63, 1 },
--			["DefaultText"] = "BM_Ver s i ondr tertwe wetrwet wte ret 8.0",
--			["Align"] = "Center",
--			["VerticalAlign"] = "Center",			
--		},
--	},


	["Version_Text"] =
	{
		["Size"] = { 0.25, 0.025 },
		["Pos"] = { 0.78+70/960, 0.06+535/720, -699 },
		["Font"] = "Arial15",
		["Color"] = { 0.5, 0.5, 0.5, 1 },
		["Visible"] = true,
		["DefaultShadow"] = 0,
		--["DefaultText"] = "BSP_V1.2",
		["DefaultText"] = "BSmodHQ v.4.0",
		["WideScreenAlign"] = "Right",
	},

	["ListBox_Group"] =
	{
		["Pos"] = { 0.4, 0.3, -1 },

		["ListBox_Text"] =
		{
			["Size"] = { 0.25, 0.025 },
			["Pos"] = { 0, 0, -1 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Multiline"] = false,
		},
	},

	["SmallListBox_Group"] =
	{
		["Pos"] = { 0.1, 0.3, -1 },

		["SmallListBox_Text"] =
		{
			["Size"] = { 0.25, 0.025 },
			["Pos"] = { 0, 0, -1 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Multiline"] = false,
		},
	},

	["TextBox_Group"] =
	{
		["Pos"] = { 0.3, 0.2, -1 },

		["TextBox_Text"] =
		{
			["Size"] = { 0.25, 0.025 },
			["Pos"] = { 0, 0, -1 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Multiline"] = false,
		},
	},

	["StorageSpace_Group"] = Platform(nil,
	{
		["LowStorageSpace_Text"] =
		{
			["Size"] = { 0.8, 0.4 },
			["Pos"] = { 0.5, 0.55, -1 },
			["Pivot"] = { 0.5, 0.5 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Align"] = "Center",
			["VerticalAlign"] = "Center",
		},
		["TotalBlocks_Text"] =
		{
			["Size"] = { 0.4, 0.1 },
			["Pos"] = { 0.925, 0.8, -1 },
			["Pivot"] = { 1, 0 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Align"] = "left",
			["VerticalAlign"] = "top",
				},
		["FreeBlocks_Text"] =
		{
			["Size"] = { 0.4, 0.1 },
			["Pos"] = { 0.075, 0.8, -1 },
			["Font"] = "Arial15",
			["Color"] = { 1, 1, 1, 1 },
			["Align"] = "right",
			["VerticalAlign"] = "top",
		},
	}),
}
