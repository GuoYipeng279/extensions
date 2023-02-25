GuiScreen = {}

    GuiScreen["Priority"] = -1
    GuiScreen["geOrder"] = 0
    GuiScreen["ChatModeOff_Group"] = {
	    ["Pos"] = { 0.000000, 0.000000, -2000.000000 },
	    ["geOrder"] = 0,
	    ["MessageTemplate_Text"] = {
--		    ["Pos"] = { 0.093750, 0.750000, -1.000000 },
		    ["Pos"] = { 360/960, 612/720, -1.000000 },
		    ["Size"] = { 0.812500, 0.100000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial15",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["ChatModeOn_Group"] = {
	    ["Pos"] = { 0.000000, 0.000000, -2000.000000 },
	    ["geOrder"] = 0,
	    ["LineStatic_FrameBox"] = {
		    ["Pos"] = { 0.083333, 0.055556, 0.000000 },
		    ["Size"] = { 0.833333, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\framebox\\framebox_03.tga",
				}
			},
        },
        ["MessageTemplate_Text"] = {
		    ["Pos"] = { 0.093750, 0.069444, -5.000000 },
		    ["Size"] = { 0.812500, 0.437500 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial15",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Bottom",
		},
        ["SendMessage_Text"] = {
		    ["Pos"] = { 0.093750, 0.520833, -5.000000 },
		    ["Size"] = { 0.812500, 0.027778 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial15",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		}
	}
    GuiScreen["Lobby_Group"] = {
	    ["Pos"] = { 0.000000, 0.000000, -2000.000000 },
	    ["geOrder"] = 7,
--	    ["MessageTemplate_Text"] = {
--		    ["Pos"] = { 0.064583, 0.702778, 0.000000 },
--		    ["Size"] = { 0.468750, 0.033333 },
--		    ["geOrder"] = 0,
--		    ["Font"] = "Arial16",
--		    ["Align"] = "Left",
--		    ["VerticalAlign"] = "Top",
--		},
        ["SendMessage_Text"] = {
		    ["Pos"] = { 0.064583, 0.738889, 0.000000 },
		    ["Size"] = { 0.468750, 0.069444 },
		    ["geOrder"] = 10,
		    ["Font"] = "Arial16",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		}
	}
    
