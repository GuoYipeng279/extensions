GuiScreen = {}

    GuiScreen["Priority"] = -100
    GuiScreen["geOrder"] = 4
    GuiScreen["GUI_pause_objectives_FrameBox"] = {
	    ["Pos"] = { 0.055208, 0.055556, -600.000000 },
	    ["Size"] = { 0.889583, 0.113889 },
	    ["geOrder"] = 0,
	    ["objectives_listbox_Text"] = {
		    ["Pos"] = { 98.645836, 0.037500, -10.000000 },
		    ["Size"] = { 0.750000, 0.022222 },
		    ["geOrder"] = 3,
		    ["MouseHit"] = true,
		    ["Font"] = "Arial15",
		    ["ShaderName"] = "GuiFontBilinear.mshd",
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
        ["Primary_Listbox"] = {
		    ["Pos"] = { 0.031250, 0.040278, -5.000000 },
		    ["Size"] = { 0.427083, 0.069444 },
		    ["geOrder"] = 4,
		    ["AutoControl"] = true,
		    ["CenterVertical"] = true,
		},
        ["primary_objectives_Text"] = {
		    ["Pos"] = { 0.031250, 0.004167, -5.000000 },
		    ["Size"] = { 0.427083, 0.027778 },
		    ["geOrder"] = 0,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "ingame.objgui_act_pri",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["Secondary_Listbox"] = {
		    ["Pos"] = { 0.479167, 0.040278, -5.000000 },
		    ["Size"] = { 0.395833, 0.069444 },
		    ["geOrder"] = 5,
		    ["AutoControl"] = true,
		    ["CenterVertical"] = true,
		},
        ["secondary_objectives_Text"] = {
		    ["Pos"] = { 0.479167, 0.004167, -5.000000 },
		    ["Size"] = { 0.395833, 0.027778 },
		    ["geOrder"] = 2,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "ingame.objgui_act_sec",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["FrameSizesX"] = { 0.027083, 0.027083 },
	    ["FrameSizesY"] = { 0.034722, 0.034722 },
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01_ingame.tga",
			},
        }
	}
    
