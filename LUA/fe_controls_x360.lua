GuiScreen = {}

    GuiScreen["Pos"] = { -0.200000, 0.000000, -500.000000 }
    GuiScreen["geOrder"] = 1
    GuiScreen["ingame_FrameBox"] = {
	    ["Pos"] = { 0.700000, 0.500000, 500.000000 },
	    ["Size"] = { 0.875000, 0.638889 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\framebox\\framebox_01_ingame.tga",
			},
        }
	}
    GuiScreen["Menu_Group"] = {
	    ["Pos"] = { 0.541667, 0.513889, -20.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 3,
	    ["AButton_Text"] = {
		    ["Pos"] = { 0.576042, 0.286111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 12,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.select",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BackButton_Text"] = {
		    ["Pos"] = { 0.310417, 0.218055, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 15,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BButton_Text"] = {
		    ["Pos"] = { 0.576042, 0.219444, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 18,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.back",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadHorz_Text"] = {
		    ["Pos"] = { 0.231250, 0.423611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 10,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.change",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadVert_Text"] = {
		    ["Pos"] = { 0.231250, 0.386111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 13,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.navigate",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumper_Text"] = {
		    ["Pos"] = { 0.242708, 0.041667, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 16,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumperHold_Text"] = {
		    ["Pos"] = { 0.242708, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 20,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickClick_Text"] = {
		    ["Pos"] = { 0.252083, 0.351389, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 3,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickHorz_Text"] = {
		    ["Pos"] = { 0.253125, 0.320833, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickVert_Text"] = {
		    ["Pos"] = { 0.253125, 0.281944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.scroll_menu",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftTrigger_Text"] = {
		    ["Pos"] = { 0.242708, 0.000000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 19,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumper_Text"] = {
		    ["Pos"] = { 0.555208, 0.041667, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 8,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumperHold_Text"] = {
		    ["Pos"] = { 0.555208, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["Visible"] = false,
		    ["geOrder"] = 20,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickClick_Text"] = {
		    ["Pos"] = { 0.542708, 0.456944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 6,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickHorz_Text"] = {
		    ["Pos"] = { 0.540625, 0.465278, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 5,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.change",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickVert_Text"] = {
		    ["Pos"] = { 0.540625, 0.425000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 4,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "globals.navigate",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightTrigger_Text"] = {
		    ["Pos"] = { 0.554166, 0.000000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 11,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["StartButton_Text"] = {
		    ["Pos"] = { 0.310417, 0.184722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 9,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["XButton_Text"] = {
		    ["Pos"] = { 0.576042, 0.331944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 17,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["YButton_Text"] = {
		    ["Pos"] = { 0.576042, 0.181944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["geOrder"] = 14,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["Plane_Group"] = {
	    ["Pos"] = { 0.541667, 0.513889, -20.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 3,
	    ["AButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.286111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 12,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_selecttarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BackButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.218055, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 15,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_map",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.219444, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 18,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_cleartarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadHorz_Text"] = {
		    ["Pos"] = { 0.127083, 0.423611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 10,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_switchsquad",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadVert_Text"] = {
		    ["Pos"] = { 0.127083, 0.386111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 13,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_na",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumper_Text"] = {
		    ["Pos"] = { 0.137500, 0.041667, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 16,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_sm",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumperHold_Text"] = {
		    ["Pos"] = { 0.137500, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 20,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pum",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickClick_Text"] = {
		    ["Pos"] = { 0.148958, 0.351389, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 3,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_cockpit",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickHorz_Text"] = {
		    ["Pos"] = { 0.148958, 0.320833, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_roll",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickVert_Text"] = {
		    ["Pos"] = { 0.148958, 0.281944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pitch",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftTrigger_Text"] = {
		    ["Pos"] = { 0.137500, 0.000000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 19,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_bombmode",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Bottom",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumper_Text"] = {
		    ["Pos"] = { 0.689583, 0.062500, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 8,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "FE.opt_cl_lock",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Bottom",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumperHold_Text"] = {
		    ["Pos"] = { 0.689583, 0.090278, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 20,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "FE.opt_cl_look",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickClick_Text"] = {
		    ["Pos"] = { 0.644791, 0.498611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 6,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_turbo",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickHorz_Text"] = {
		    ["Pos"] = { 0.644791, 0.465278, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 5,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_rudder",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickVert_Text"] = {
		    ["Pos"] = { 0.644791, 0.425000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 4,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_speed",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightTrigger_Text"] = {
		    ["Pos"] = { 0.689583, -0.027778, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 11,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_fire",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["StartButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.184722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 9,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pause",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["XButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.359722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 17,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_orders",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Bottom",
		    ["DefaultShadow"] = 0,
		},
        ["YButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.181944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 14,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_jumpin",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["Ship_Group"] = {
	    ["Pos"] = { 0.541667, 0.513889, -20.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 3,
	    ["AButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.286111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 11,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_selecttarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BackButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.218055, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 14,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_map",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.219444, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 16,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_cleartarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadHorz_Text"] = {
		    ["Pos"] = { 0.127083, 0.423611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 9,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_switchformation",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadVert_Text"] = {
		    ["Pos"] = { 0.127083, 0.386111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 12,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_switchunit",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumper_Text"] = {
		    ["Pos"] = { 0.137500, 0.041667, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 7,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_sm",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumperHold_Text"] = {
		    ["Pos"] = { 0.137500, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 19,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pum",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickClick_Text"] = {
		    ["Pos"] = { 0.148958, 0.351389, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 2,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_binocular",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickHorz_Text"] = {
		    ["Pos"] = { 0.148958, 0.320833, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_camera",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickVert_Text"] = {
		    ["Pos"] = { 0.148958, 0.281944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_camera",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftTrigger_Text"] = {
		    ["Pos"] = { 0.137500, -0.000000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 17,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_changeweapon",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumper_Text"] = {
		    ["Pos"] = { 0.689583, 0.058333, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 6,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_launchunit",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumperHold_Text"] = {
		    ["Pos"] = { 0.576042, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["Visible"] = false,
		    ["geOrder"] = 18,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickClick_Text"] = {
		    ["Pos"] = { 0.644791, 0.498611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 5,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_repair",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickHorz_Text"] = {
		    ["Pos"] = { 0.644791, 0.465278, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 4,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_steer",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickVert_Text"] = {
		    ["Pos"] = { 0.644791, 0.425000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 3,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_speed",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightTrigger_Text"] = {
		    ["Pos"] = { 0.689583, -0.027778, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 10,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_fire",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["StartButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.184722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 8,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pause",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["XButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.359722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 15,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_orders",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["YButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.181944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 13,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_jumpin",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["static_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, -10.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["icons_Group"] = {
		    ["Pos"] = { 0.291667, 0.263889, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["arrow_10_Icon"] = {
			    ["Pos"] = { 0.658333, 0.419444, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_11_Icon"] = {
			    ["Pos"] = { 0.673958, 0.456944, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_12_Icon"] = {
			    ["Pos"] = { 0.657291, 0.456944, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_1_Icon"] = {
			    ["Pos"] = { 0.135417, 0.275000, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_2_Icon"] = {
			    ["Pos"] = { 0.119792, 0.275000, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_3_Icon"] = {
			    ["Pos"] = { 0.136458, 0.312500, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_4_Icon"] = {
			    ["Pos"] = { 0.119792, 0.312500, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_5_Icon"] = {
			    ["Pos"] = { 0.114583, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_6_Icon"] = {
			    ["Pos"] = { 0.098958, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_7_Icon"] = {
			    ["Pos"] = { 0.115625, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_8_Icon"] = {
			    ["Pos"] = { 0.098958, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_9_Icon"] = {
			    ["Pos"] = { 0.673958, 0.419444, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["x360_stick_l_Icon"] = {
			    ["Pos"] = { 0.129167, 0.343056, 0.000000 },
			    ["Size"] = { 0.019792, 0.019444 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\x360_stick_l.tga",
					}
				}
			},
            ["x360_stick_r_Icon"] = {
			    ["Pos"] = { 0.667708, 0.490278, 0.000000 },
			    ["Size"] = { 0.019792, 0.019444 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\x360_stick_r.tga",
					}
				}
			},
        },
        ["lines_Group"] = {
		    ["Pos"] = { 0.437501, 0.277778, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["line_Bck_Icon"] = {
			    ["Pos"] = { 0.130207, 0.231944, -17.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 7,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_BtnA_Icon"] = {
			    ["Pos"] = { 0.440624, 0.281944, -23.000000 },
			    ["Size"] = { 0.184375, 0.004167 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 14,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_3.tga",
					}
				}
			},
            ["line_BtnB_Icon"] = {
			    ["Pos"] = { 0.453124, 0.231944, -12.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_BtnX_Icon"] = {
			    ["Pos"] = { 0.436457, 0.326389, -20.000000 },
			    ["Size"] = { 0.251042, 0.143056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 11,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_BtnY_Icon"] = {
			    ["Pos"] = { 0.429166, 0.195833, -11.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_DPad_Icon"] = {
			    ["Pos"] = { 0.079166, 0.359722, -18.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 9,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					}
				}
			},
            ["line_LB_Icon"] = {
			    ["Pos"] = { 0.070832, 0.055555, -15.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_LS_Icon"] = {
			    ["Pos"] = { 0.070832, 0.258333, -22.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 8,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 1.000000,
						    [3] = 0.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["line_LT_Icon"] = {
			    ["Pos"] = { 0.086457, 0.013889, -16.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 6,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_RB_Icon"] = {
			    ["Pos"] = { 0.440624, 0.055555, -13.000000 },
			    ["Size"] = { 0.184375, 0.004167 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_3.tga",
					}
				}
			},
            ["line_RS_Icon"] = {
			    ["Pos"] = { 0.421874, 0.386111, -19.000000 },
			    ["Size"] = { 0.251042, 0.143056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 10,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_RT_Icon"] = {
			    ["Pos"] = { 0.435416, -0.013889, -14.000000 },
			    ["Size"] = { 0.210417, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 3,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_Strt_Icon"] = {
			    ["Pos"] = { 0.157291, 0.201389, -21.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 12,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
        },
        ["x360_pad_Icon"] = {
		    ["Pos"] = { 0.437500, 0.277778, 0.000000 },
		    ["Size"] = { 0.377083, 0.563889 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\X360\\X360_controller.tga",
				}
			},
        }
	}
    GuiScreen["staticMenu_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, -10.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 0,
	    ["icons_Group"] = {
		    ["Pos"] = { 0.291667, 0.263889, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["arrow_10_Icon"] = {
			    ["Pos"] = { 0.658333, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_11_Icon"] = {
			    ["Pos"] = { 0.673958, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_12_Icon"] = {
			    ["Pos"] = { 0.657292, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_1_Icon"] = {
			    ["Pos"] = { 0.135417, 0.275000, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_2_Icon"] = {
			    ["Pos"] = { 0.119792, 0.275000, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_3_Icon"] = {
			    ["Pos"] = { 0.136458, 0.312500, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_4_Icon"] = {
			    ["Pos"] = { 0.119792, 0.312500, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_5_Icon"] = {
			    ["Pos"] = { 0.114583, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_6_Icon"] = {
			    ["Pos"] = { 0.098958, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_7_Icon"] = {
			    ["Pos"] = { 0.115625, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["arrow_8_Icon"] = {
			    ["Pos"] = { 0.098958, 0.415278, 0.000000 },
			    ["Size"] = { 0.010417, 0.013889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Rotate"] = 1.570796,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["arrow_9_Icon"] = {
			    ["Pos"] = { 0.673958, 0.377778, 0.000000 },
			    ["Size"] = { 0.013542, 0.009722 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\arrow.tga",
					}
				}
			},
            ["x360_stick_l_Icon"] = {
			    ["Pos"] = { 0.129167, 0.343056, 0.000000 },
			    ["Size"] = { 0.019792, 0.019444 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\x360_stick_l.tga",
					}
				}
			},
            ["x360_stick_r_Icon"] = {
			    ["Pos"] = { 0.667708, 0.448611, 0.000000 },
			    ["Size"] = { 0.019792, 0.019444 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\x360_stick_r.tga",
					}
				}
			},
        },
        ["lines_Group"] = {
		    ["Pos"] = { 0.437501, 0.277778, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["line_1_1_Icon"] = {
			    ["Pos"] = { 0.429166, 0.195833, -11.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_1_2_Icon"] = {
			    ["Pos"] = { 0.453124, 0.231944, -12.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_1_3_Icon"] = {
			    ["Pos"] = { 0.435416, 0.055555, -13.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_1_4_Icon"] = {
			    ["Pos"] = { 0.419791, 0.013889, -14.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 3,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					}
				}
			},
            ["line_1_5_Icon"] = {
			    ["Pos"] = { 0.070833, 0.055555, -15.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_1_6_Icon"] = {
			    ["Pos"] = { 0.086458, 0.013889, -16.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 6,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_1_7_Icon"] = {
			    ["Pos"] = { 0.130208, 0.231944, -17.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 7,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_1_8_Icon"] = {
			    ["Pos"] = { 0.070833, 0.258333, -22.000000 },
			    ["Size"] = { 0.179167, 0.043056 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 8,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_1.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 1.000000,
						    [3] = 0.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["line_2_1_Icon"] = {
			    ["Pos"] = { 0.079166, 0.359722, -18.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 9,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					}
				}
			},
            ["line_2_2_Icon"] = {
			    ["Pos"] = { 0.421874, 0.358333, -19.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 10,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_2_3_Icon"] = {
			    ["Pos"] = { 0.436458, 0.305555, -20.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 11,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 1.000000,
						    [2] = 0.000000,
						    [3] = 0.000000,
						    [4] = 1.000000,
						}
					}
				}
			},
            ["line_2_4_Icon"] = {
			    ["Pos"] = { 0.157291, 0.201389, -21.000000 },
			    ["Size"] = { 0.251042, 0.087500 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 12,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_2.tga",
					    ["UV_LURB"] = {
						    [1] = 0.000000,
						    [2] = 1.000000,
						    [3] = 1.000000,
						    [4] = 0.000000,
						}
					}
				}
			},
            ["line_3_1_Icon"] = {
			    ["Pos"] = { 0.440624, 0.281944, -23.000000 },
			    ["Size"] = { 0.184375, 0.004167 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 14,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\X360\\line_3.tga",
					}
				}
			},
        },
        ["x360_pad_Icon"] = {
		    ["Pos"] = { 0.437500, 0.277778, 0.000000 },
		    ["Size"] = { 0.377083, 0.563889 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\X360\\X360_controller.tga",
				}
			},
        }
	}
    GuiScreen["Submarine_Group"] = {
	    ["Pos"] = { 0.541667, 0.513889, -20.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 3,
	    ["AButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.286111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 10,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_selecttarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BackButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.218055, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 13,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_map",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["BButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.219444, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 16,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_cleartarget",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadHorz_Text"] = {
		    ["Pos"] = { 0.127083, 0.423611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 8,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_switchunit",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["DPadVert_Text"] = {
		    ["Pos"] = { 0.127083, 0.386111, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 11,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_depth",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumper_Text"] = {
		    ["Pos"] = { 0.137500, 0.041667, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 14,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_sm",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftBumperHold_Text"] = {
		    ["Pos"] = { 0.137500, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 20,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pum",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickClick_Text"] = {
		    ["Pos"] = { 0.148958, 0.351389, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 2,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_periscope",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickHorz_Text"] = {
		    ["Pos"] = { 0.148958, 0.320833, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_camera",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftStickVert_Text"] = {
		    ["Pos"] = { 0.148958, 0.281944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_camera",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["LeftTrigger_Text"] = {
		    ["Pos"] = { 0.137500, 0.000000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 17,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_changeweapon",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumper_Text"] = {
		    ["Pos"] = { 0.689583, 0.058333, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 6,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_launchunit",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightBumperHold_Text"] = {
		    ["Pos"] = { 0.576042, 0.073611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.831987 },
		    ["Visible"] = false,
		    ["geOrder"] = 19,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickClick_Text"] = {
		    ["Pos"] = { 0.644791, 0.498611, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 5,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_repair",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickHorz_Text"] = {
		    ["Pos"] = { 0.644791, 0.465278, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 4,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_steer",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightStickVert_Text"] = {
		    ["Pos"] = { 0.644791, 0.425000, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 3,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_speed",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["RightTrigger_Text"] = {
		    ["Pos"] = { 0.689583, -0.027778, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 9,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_fire",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["StartButton_Text"] = {
		    ["Pos"] = { 0.206250, 0.184722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 0.000000, 0.849993 },
		    ["geOrder"] = 7,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_pause",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		},
        ["XButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.359722, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 15,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_orders",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Bottom",
		    ["DefaultShadow"] = 0,
		},
        ["YButton_Text"] = {
		    ["Pos"] = { 0.689583, 0.181944, 0.000000 },
		    ["Size"] = { 0.208333, 0.027778 },
		    ["Pivot"] = { 1.000002, 0.849993 },
		    ["geOrder"] = 12,
		    ["Font"] = "Arial16",
		    ["Multiline"] = false,
		    ["DefaultText"] = "FE.opt_cl_jumpin",
		    ["Align"] = "Right",
		    ["VerticalAlign"] = "Center",
		    ["DefaultShadow"] = 0,
		}
	}
    
