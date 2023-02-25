GuiScreen = {}

    GuiScreen["geOrder"] = 4
    GuiScreen["Main_Listbox"] = CreateAchievementMenu({ 0.0825, 0.50, -1 }, nil, nil, true, "left")
    GuiScreen["MainOOB_Listbox"] = CreateOOBMenu({ 0.0825, 0.50, -1 }, nil, nil, true, "left")
    GuiScreen["Difficulty_Listbox"] = CreateStandardMenu({ 0.50, 0.50, -1 }, nil, nil, true, "center")
    GuiScreen["Fixed_Text"] = {
	    ["Size"] = { 0.364583, 0.133333 },
	    ["Color"] = { 205/255, 149/255, 84/255, 1 },
	    ["geOrder"] = 0,
	    ["Visible"] = false,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.oob_fixed",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}

    GuiScreen["Changeable_Text"] = {
	    ["Size"] = { 0.364583, 0.1 },
	    ["Color"] = { 205/255, 149/255, 84/255, 1 },
	    ["geOrder"] = 0,
	    ["Visible"] = false,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.oob_changeable",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}

    GuiScreen["Bonus_Text"] = {
	    ["Size"] = { 0.364583, 0.033333 },
	    ["Color"] = { 205/255, 149/255, 84/255, 1 },
	    ["geOrder"] = 0,
	    ["Visible"] = false,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.oob_bonus",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    
