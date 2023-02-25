GuiScreen = {}

    GuiScreen["Priority"] = 265
    GuiScreen["geOrder"] = 7
    GuiScreen["Open_Group"] = {
	    ["Pos"] = { -0.012583, 0.041445, -10.000000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 0,
	    ["obj_main_Icon"] = {
		    ["Pos"] = { 0.754250, 0.046055, 10.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/map/objectives_main.tga",
				}
			},
        },
        ["obj_scale_Icon"] = {
		    ["Pos"] = { 0.541750, 0.105778, 10.000000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/map/objectives_side.tga",
				}
			},
        },
        ["obj_text_bottom_Icon"] = {
		    ["Pos"] = { 0.967793, 0.153000, 10.000000 },
		    ["Rotate"] = 3.141593,
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/map/objectives_top.tga",
				}
			},
        },
        ["obj_text_FrameBox"] = {
		    ["Pos"] = { 0.541750, 0.080778, 10.000000 },
		    ["Size"] = { 0.427083, 0.083333 },
		    ["Visible"] = false,
		    ["geOrder"] = 0,
		    ["FrameSizesX"] = { 0.031250, 0.031250 },
		    ["FrameSizesY"] = { 0.041667, 0.041667 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["obj_text_top_Icon"] = {
		    ["Pos"] = { 0.540708, 0.083556, 10.000000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/map/objectives_top.tga",
				}
			},
        },
        ["ObjectiveNumbers_Listbox"] = {
		    ["Pos"] = { -10.000000, -10.000000, -10.000000 },
		    ["Size"] = { 1.000000, 1.000000 },
		    ["geOrder"] = 0,
		    ["KisPocset_Icon"] = {
			    ["Size"] = { 0.027000, 0.036100 },
			    ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "gui/map/filter_highlight.tga",
					}
				}
			},
            ["ObjectiveNumbersTemplate_Text"] = {
			    ["Pos"] = { 0.000000, 0.000000, -2.000000 },
			    ["Size"] = { 0.027000, 0.036100 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["Font"] = "Arial16",
			    ["Align"] = "Center",
			    ["VerticalAlign"] = "Center",
			},
            ["DontMoveTheItems"] = true,
		},
        ["PrimaryNumbers_Text"] = {
		    ["Pos"] = { 0.560000, 0.018000, -1.000000 },
		    ["Size"] = { 0.250000, 0.050000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "globals.primary|.:",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		},
        ["SecondaryNumbers_Text"] = {
		    ["Pos"] = { 0.770000, 0.018000, -1.000000 },
		    ["Size"] = { 0.250000, 0.050000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "globals.secondary|.:",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		},
        ["SelectedObjective_Text"] = {
		    ["Pos"] = { 0.485000, 0.064000, -1.000000 },
		    ["Size"] = { 0.400000, 0.200000 },
		    ["Color"] = { 1.000000, 0.980000, 0.920000, 1.000000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		}
	}
    
