GuiScreen = {}

    GuiScreen["geOrder"] = 2
    GuiScreen["arrow_bottom_scroll_Icon"] = {
	    ["Pos"] = { 0.822916, 0.801389, -5.000000 },
	    ["Size"] = { 0.015625, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 5,
	    ["MouseHit"] = true,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/arrows/arrow_down.tga",
			},
            [2] = {
			    ["Texture"] = "common/arrows/arrow_down_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common/arrows/arrow_down_on.tga",
			},
        }
	}
    GuiScreen["arrow_top_scroll_Icon"] = {
	    ["Pos"] = { 0.822916, 0.620833, -5.000000 },
	    ["Size"] = { 0.015625, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 4,
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
				
			},
        }
	}
    GuiScreen["missionpicture_Icon"] = {
	    ["Pos"] = { 0.601042, 0.420834, -21.000000 },
	    ["Size"] = { 0.533333, 0.355556 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 7,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/multimode/escort.tga",
			},
            [2] = {
			    ["Texture"] = "fe/multimode/siege.tga",
			},
            [3] = {
			    ["Texture"] = "fe/multimode/comp.tga",
			},
            [4] = {
			    ["Texture"] = "fe/multimode/duel.tga",
			},
            [5] = {
			    ["Texture"] = "fe/multimode/ic.tga",
			},
            [6] = {
			    ["Texture"] = "fe/multimode/any.tga",
			},
        }
	}
    GuiScreen["New_FrameBox"] = {
	    ["Pos"] = { 0.367708, 0.245833, -22.000000 },
	    ["Size"] = { 0.466667, 0.350000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_02.tga",
			},
        }
	}
    GuiScreen["New_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, 10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/bg/multiplayer.tga",
			},
        }
	}
    GuiScreen["test_Clipbox"] = {
	    ["Pos"] = { 0.378126, 0.605555, -14.000000 },
	    ["Size"] = { 0.466667, 0.194444 },
	    ["geOrder"] = 12,
	    ["textbox_Group"] = {
		    ["Pos"] = { 0.000000, 0.034722, 0.000000 },
		    ["Size"] = { 0.531251, 0.194444 },
		    ["geOrder"] = 2,
		    ["description_Text"] = {
			    ["Pos"] = { 0.000000, 0.000000, -15.000000 },
			    ["Size"] = { 0.421875, 0.194444 },
			    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			    ["geOrder"] = 2,
			    ["Font"] = "Arial15",
			    ["DefaultText"] = "Island Capture mode is for strategic gamers who like to spend hours just staring to the ocean. Island Capture mode is for strategic gamers who like to spend hours just staring to the ocean. Island Capture mode is for strategic gamers who like to spend hours just staring to the ocean. Island Capture mode is for strategic gamers who like to spend hours just staring to the ocean. Island Capture mode is for strategic gamers who like to spend hours just staring to the ocean. ",
			    ["ShaderName"] = "GuiFontBilinear.mshd",
			    ["Align"] = "Justified",
			    ["VerticalAlign"] = "Top",
			    ["DefaultShadow"] = 0,
			},
            ["mode_Text"] = {
			    ["Pos"] = { 0.235416, 0.225000, -9.000000 },
			    ["Size"] = { 0.466667, 0.500000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			    ["geOrder"] = 1,
			    ["Font"] = "Arial15",
			    ["DefaultText"] = "GAMEMODE: DUEL",
			    ["Align"] = "Left",
			    ["VerticalAlign"] = "Top",
			    ["DefaultShadow"] = 0,
			},
        },
        ["BorderWidth"] = { 0.001000, 0.010000 },
	}
    GuiScreen["textbackground_FrameBox"] = {
	    ["Pos"] = { 0.601042, 0.711111, -2.000000 },
	    ["Size"] = { 0.466667, 0.208333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 1,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01.tga",
			},
        }
	}
    GuiScreen["textx_scroll_bg_Icon"] = {
	    ["Pos"] = { 0.823958, 0.630556, -4.000000 },
	    ["Size"] = { 0.015625, 0.161111 },
	    ["Pivot"] = { 0.538462, 0.000000 },
	    ["geOrder"] = 3,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/slider/slider_bg.tga",
			},
        }
	}
    GuiScreen["textx_scroll_FrameBox"] = {
	    ["Pos"] = { 0.815624, 0.630554, -12.000000 },
	    ["Size"] = { 0.014583, 0.036111 },
	    ["geOrder"] = 2,
	    ["MouseHit"] = true,
	    ["FrameSizesX"] = { 0.006250, 0.006250 },
	    ["FrameSizesY"] = { 0.016660, 0.016660 },
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/slider/slider.tga",
			},
            [2] = {
			    ["Texture"] = "common/slider/slider_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common/slider/slider_on.tga",
			},
        }
	}
    
