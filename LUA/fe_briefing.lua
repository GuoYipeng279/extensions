GuiScreen = {}

    GuiScreen["geOrder"] = 3
    GuiScreen["background_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, 2.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "FE\\bg\\briefing_alpha.tga",
			},
        }
	}
    GuiScreen["async_bg_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, 250.000000 },
	    ["Size"] = { 2.000000, 1.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\black.tga",
			},
        }
	}
    GuiScreen["New_Group"] = {
	    ["Pos"] = { 0.284375+0.020833, 0.522223, -33.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Left",
	    ["geOrder"] = 1,
	    ["dest_2_Text"] = {
		    ["Pos"] = { 0.033333, 0.136111, -33.000000 },
		    ["Size"] = { 0.312500, 0.083333 },
		    ["Color"] = { 205/255, 149/255, 84/255, 1 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "adfasshdlifhhfiluahsdifuhalsidhflaishdfliahslidfhlaisdhfliahsdilfhalisdhfliashdlfiuahsldfiuhasoiufdhlashdflauhflsuhflashflhf",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["dest_Text"] = {
		    ["Pos"] = { 0.033333, 0.040278, -33.000000 },
		    ["Size"] = { 0.312500, 0.083333 },
		    ["Color"] = { 255/255, 221/255, 156/255, 1 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "adfasshdlifhhfiluahsdifuhalsidhflaishdfliahslidfhlaisdhfliahsdilfhalisdhfliashdlfiuahsldfiuhasoiufdhlashdflauhflsuhflashflhf",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["hl_bg_FrameBox"] = {
		    ["Pos"] = { 0.000000, 0.000000, -31.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_text_select.tga",
				}
			},
            ["FrameSizesY"] = { 0.01, 0.01 }, 
		},
--	    ["hl_left_Icon"] = {
--		    ["Pos"] = { 0.000000, 0.000000, -32.000000 },
--		    ["Pivot"] = { 0.000000, 0.500000 },
--		    ["geOrder"] = 8,
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "common\\highlight_left.tga",
--				}
--			}
--		}
--	    ["hl_right_Icon"] = {
--		    ["Pos"] = { 0.000000, 0.000000, -32.000000 },
--		    ["Pivot"] = { 1.000000, 0.500000 },
--		    ["geOrder"] = 9,
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "common\\highlight_right.tga",
--				}
--			}
--		},
        ["num_2_Text"] = {
		    ["Pos"] = { 0.017708, 0.136111, -33.000000 },
		    ["Size"] = { 0.010417, 0.055556 },
		    ["Color"] = { 0.850980, 0.760784, 0.584314, 1.000000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "2.",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["num_Text"] = {
		    ["Pos"] = { 0.017708, 0.040278, -33.000000 },
		    ["Size"] = { 0.010417, 0.055556 },
		    ["Color"] = { 0.929412, 0.768627, 0.388235, 1.000000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "1.",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["Primary_Text"] = {
		    ["Size"] = { 0.364583, -33.033333 },
		    ["Color"] = { 205/255, 149/255, 84/255, 1 },
		    ["geOrder"] = 0,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "PRIMARY OBJECTIVE",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		}
	}
    
