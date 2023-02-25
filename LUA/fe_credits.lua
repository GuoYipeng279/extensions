GuiScreen = {}

    GuiScreen["geOrder"] = 0
    GuiScreen["bg_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, -98.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\bg\\multiplayer.tga",
			},
        }
	}
    GuiScreen["category_template_Text"] = {
	    ["Size"] = { 1.000000, 0.500000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "category",
	    ["ShaderName"] = "GuiFontBilinear.mshd",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["clipbox_Clipbox"] = {
	    ["Pos"] = { 0.157292, 0.240278, 0.000000 },
	    ["Size"] = { 0.682292, 0.541667 },
	    ["geOrder"] = 0,
	    ["moving_Group"] = {
		    ["Pos"] = { 0.000000, -0.138889, 0.000000 },
		    ["Size"] = { 1.000000, 1.000000 },
		    ["geOrder"] = 0,
		    ["bsplogo_Icon"] = {
			    ["Pos"] = { -1.000000, -1.000000, 0.000000 },
			    ["Size"] = { 0.533333, 0.177778 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "FE\\logo_bsp_big.tga",
					}
				}
			},
            ["wblogo_Icon"] = {
			    ["Pos"] = { -1.000000, -1.000000, 0.000000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "FE\\logo_wb.tga",
					}
				}
			},
            ["binklogo_Icon"] = {
			    ["Pos"] = { -1.000000, -1.000000, 0.000000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "FE\\logo_bink.tga",
					}
				}
			},
            ["spacer_Icon"] = {
			    ["Pos"] = { -1.000000, -1.000000, 0.000000 },
			    ["Size"] = { 400.0/960, 4.0/720 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_point_A.tga",
					}
				}
			},
        },
        ["BorderWidth"] = { 0.001000, 0.010000 },
	}
    GuiScreen["New_FrameBox"] = {
	    ["Pos"] = { 0.500000, 0.511111, -99.000000 },
	    ["Size"] = { 0.708333, 0.555556 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\framebox\\framebox_01.tga",
			},
        }
	}
    GuiScreen["person_template_Text"] = {
	    ["Pos"] = { 0.000000, 0.006944, 0.000000 },
	    ["Size"] = { 1.000000, 0.500000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Arial15",
	    ["DefaultText"] = "category",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    
