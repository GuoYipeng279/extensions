GuiScreen =
{
	["Priority"] = 169,
	["Pos"] = { 0, 0, -700 },

	["Main_Listbox"] = CreateStandardMenu2({ 0.0825, 0.48, -1 }, nil, nil, true, "Left"),
	["Ingame_Main_Listbox"] = CreateStandardMenu({ 0.5, 0.48, -1 }, nil, nil, true),

--	["SaveEtc_Listbox"] = CreateStandardMenu({ 0.15, 0.48, -1 }, nil, nil, true, "Left"),

	["SelectedConflict_Text"] =
	{
		["Pos"] = { 0.5, 0.79, -1 },
		["Pivot"] = { 0.5, 0.5 },
		["Size"] = { 0.75, 0.05 },
		["Font"] = "Arial18",
		["Align"] = "Center",
		["VerticalAlign"] = "Center",
		["Color"] = { 1, 0, 0, 1 },
	},
}
