GuiScreen = {}

    GuiScreen["geOrder"] = 0
    GuiScreen["map_001_Icon"] = {
	    ["Pos"] = { 0.306249, 0.386111, -101.000000 },
	    ["Size"] = { 0.156250, 0.208333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 10,
	    ["DelayedTextureLoad"] = true,
	    ["ShaderName"] = "guidefault_noalpha.mshd",
	    ["States"] = {
		    [1] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [2] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [3] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [4] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [5] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [6] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [7] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		    [8] = {    ["Texture"] = "gui/radarshots/scene1_ICH.tga", },
		}
	}
    GuiScreen["map_backg_Icon"] = {
	    ["Pos"] = { 0.306250, 0.386111, -100.000000 },
	    ["Size"] = { 0.156250, 0.208333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 15,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\map\\map_backg.tga",
			},
        }
	}
    GuiScreen["New_2_FrameBox"] = {
	    ["Pos"] = { 0.304941, 0.385000, -102.000000 },
	    ["Size"] = { 0.158333, 0.211111 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\framebox\\framebox_02.tga",
			},
        }
	}
    GuiScreen["New_FrameBox"] = {
	    ["Pos"] = { 0.200000, 0.239583, -100.000000 },
	    ["Size"] = { 0.604167, 0.500000 },
	    ["geOrder"] = 4,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01.tga",
			},
        }
	}
    GuiScreen["pause_BG_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, -50.000000 },
	    ["Size"] = { 1.333333, 0.683333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.900000 },
	    ["geOrder"] = 18,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\bg\\multiplayer.tga",
			},
        }
	}
    GuiScreen["scroll_left_Icon"] = {
	    ["Pos"] = { 0.572917, 0.304167, -101.000000 },
	    ["Size"] = { 0.020833, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Rotate"] = 1.570796,
	    ["geOrder"] = 3,
	    ["MouseHit"] = true,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\arrows\\arrow_up.tga",
			},
            [2] = {
			    ["Texture"] = "common\\arrows\\arrow_up_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common\\arrows\\arrow_up_on.tga",
			},
        }
	}
    GuiScreen["scroll_right_Icon"] = {
	    ["Pos"] = { 0.789583, 0.284722, -101.000000 },
	    ["Size"] = { 0.020833, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Rotate"] = 4.712389,
	    ["geOrder"] = 1,
	    ["MouseHit"] = true,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\arrows\\arrow_up.tga",
			},
            [2] = {
			    ["Texture"] = "common\\arrows\\arrow_up_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common\\arrows\\arrow_up_on.tga",
			},
        }
	}
    GuiScreen["selected_description_Text"] = {
	    ["Pos"] = { 0.223958, 0.731944, -101.000000 },
	    ["Size"] = { 0.552083, 0.222222 },
	    ["Pivot"] = { 0.000000, 1.000000 },
	    ["Color"] = { 0.894118, 0.800000, 0.596078, 1.000000 },
	    ["geOrder"] = 7,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "name_2_Text",
	    ["Align"] = "Justified",
	    ["VerticalAlign"] = "Bottom",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["setting_name_Text"] = {
	    ["Pos"] = { 380.0/960, 199.0/720, -101.000000 },
	    ["Size"] = { 156.0/960, 32.0/720 },
	    ["Color"] = { 0.894118, 0.800000, 0.596078, 1.000000 },
	    ["geOrder"] = 5,
	    ["MouseHit"] = true,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "ingame_map_Text",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["MISColors"] = {
		    ["Normal"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
		    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
		    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
		    ["Disabled"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
		},
        ["DefaultShadow"] = 0,
	}
    GuiScreen["setting_title_Text"] = {
	    ["Pos"] = { 0.448916, 0.499306, -100.000000 },
	    ["Size"] = { 0.500000, 0.541667 },
	    ["Pivot"] = { 0.500000, 0.540574 },
	    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
	    ["geOrder"] = 2,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.multi_lobby_settings",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["setting_value_Text"] = {
	    ["Pos"] = { 0.834375, 0.526389, -101.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 0.894118, 0.800000, 0.596078, 1.000000 },
	    ["geOrder"] = 6,
	    ["MouseHit"] = true,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "name_Text",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["MISColors"] = {
		    ["Normal"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
		    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
		    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
		    ["Disabled"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
		},
        ["DefaultShadow"] = 0,
	}
    GuiScreen["Settings_Listbox"] = {
	    ["Pos"] = { 0.835000, 0.526389, -101.000000 },
	    ["Size"] = { 0.633333, 0.579167 },
	    ["geOrder"] = 19,
	    ["MouseHit"] = true,
	    ["DontMoveTheItems"] = true,
	}
    
