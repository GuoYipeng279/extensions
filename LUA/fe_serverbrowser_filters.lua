GuiScreen = {}

    GuiScreen["geOrder"] = 5
    GuiScreen["cucc_Group"] = {
	    ["Pos"] = { 0.543750, 0.604167, -100.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["keret_FrameBox"] = {
		    ["Pos"] = { -0.050000, -0.010417, -100.000000 },
		    ["Size"] = { 0.500000, 0.298333 },
		    ["geOrder"] = 5,
		    ["FrameSizesX"] = { 0.041667, 0.041667 },
		    ["FrameSizesY"] = { 0.055556, 0.055556 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["menu_line_Group"] = {
		    ["Pos"] = { -0.043750, 0.006944, 0.000000 },
		    ["Size"] = { 0.487500, 0.027778 },
		    ["geOrder"] = 0,
		    ["scroll_left_Icon"] = {
			    ["Pos"] = { 0.318750, 0.014584, -101.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 2,
			    ["MouseHit"] = true,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/arrows/arrow_up.tga",
					},
                    [2] = {
					    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
					},
                    [3] = {
					    ["Texture"] = "common/arrows/arrow_up_on.tga",
					}
				}
			},
            ["scroll_right_Icon"] = {
			    ["Pos"] = { 0.460166, 0.015972, -101.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 4.712389,
			    ["geOrder"] = 0,
			    ["MouseHit"] = true,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/arrows/arrow_up.tga",
					},
                    [2] = {
					    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
					},
                    [3] = {
					    ["Texture"] = "common/arrows/arrow_up_on.tga",
					}
				}
			},
            ["setting_name_Text"] = {
			    ["Pos"] = { 0.002083, -0.002083, -101.000000 },
			    ["Size"] = { 452.0/960.0, 0.222222 },
			    ["Color"] = { 0.894118, 0.800000, 0.596078, 1.000000 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["Font"] = "Arial16",
			    ["DefaultText"] = "ingame_map_Text",
			    ["Align"] = "Left",
			    ["VerticalAlign"] = "Top",
			    ["MISColors"] = GetMISCols(),
			    ["DefaultShadow"] = 0,
			},
            ["setting_value_Text"] = {
			    ["Pos"] = { 0.388541, 0.247917, -101.000000 },
			    ["Size"] = { 0.125000, 0.500000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Color"] = { 0.894118, 0.800000, 0.596078, 1.000000 },
			    ["geOrder"] = 3,
--			    ["MouseHit"] = true,
			    ["Font"] = "Arial16",
			    ["DefaultText"] = "name_Text",
			    ["Align"] = "Center",
			    ["VerticalAlign"] = "Top",
			    ["MISColors"] = GetMISCols(),
			    ["DefaultShadow"] = 0,
			},
        },
        ["setting_title_Text"] = {
		    ["Pos"] = { 0.198916, 0.249306, -100.000000 },
		    ["Size"] = { 0.500000, 0.541667 },
		    ["Pivot"] = { 0.500000, 0.540574 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 2,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "FE.multi_browser_filters",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["Settings_Listbox"] = {
		    ["Pos"] = { -0.032709, -0.000694, -101.000000 },
		    ["geOrder"] = 7,
		    ["MouseHit"] = true,
		    ["AutoControl"] = true,
		}
	}
    GuiScreen["gray_BG_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, -150.000000 },
	    ["Size"] = { 1.333333, 0.683333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.900000 },
	    ["geOrder"] = 8,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/bg/multiplayer.tga",
			},
        }
	}
    
