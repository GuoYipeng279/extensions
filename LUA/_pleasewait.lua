--DoFile("interface/_Dialogue.lua")
--bgGroup = GuiScreen
--bgGroup.Pos = nil

GuiScreen = {}

    GuiScreen["Priority"] = -100
    GuiScreen["Pos"] = { 0, 0, -3500 }
--    ["Bg_Group"] = bgGroup,

--    ["Message_Text"] =
--	{
--	    ["Size"] = { 0.5, 0.5 },
--	    ["Pos"] = { 0.5, 0.45, -1 },
--	    ["Pivot"] = { 0.5, 0.5 },
--	    ["Font"] = "Viper19",
--	    ["Align"] = "Center",
--	    ["VerticalAlign"] = "Center",
--	    ["DefaultText"] = "globals.pleasewait",
--	}

--    ["PorgoForgo_AnimIcon"] = {
--	    ["Pos"] = { 0.5, 0.6, -1 },
--	    ["Pivot"] = { 0.5, 0.5 },
--	    ["States"] = {
--			{ ["Texture"] = "multimenu/spinny1.tga", },
--			{ ["Texture"] = "multimenu/spinny2.tga", },
--			{ ["Texture"] = "multimenu/spinny3.tga", },
--			{ ["Texture"] = "multimenu/spinny4.tga", },
--			{ ["Texture"] = "multimenu/spinny5.tga", },
--			{ ["Texture"] = "multimenu/spinny6.tga", },
--			{ ["Texture"] = "multimenu/spinny7.tga", },
--			{ ["Texture"] = "multimenu/spinny8.tga", },
--		}
--	}
    GuiScreen["Background_Icon"] = {
	    ["Pos"] = { -1.000000, -1.000000, 99.000000 },
	    ["Size"] = { 3.000000, 3.000000 },
	    ["WideScreenAlign"] = "Left",
	    ["Visible"] = false,
	    ["geOrder"] = 1,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/elements/black_bar.tga",
			},
        }
	}
    GuiScreen["radar_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 0.000000 },
	    ["Size"] = { 0.239583, 0.361111 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
	    ["geOrder"] = 0,
	    ["back_Icon"] = {
		    ["Pos"] = { 0.119792, 0.180556, 0.000000 },
		    ["Size"] = { 0.260417, 0.347222 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
		    ["geOrder"] = 5,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/loading/loading_back.tga",
				}
			},
        },
        ["glass_Icon"] = {
		    ["Pos"] = { 0.119792, 0.180555, -6.000000 },
		    ["Size"] = { 0.260417, 0.347222 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.300000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/loading/loading_glass.tga",
				}
			},
        },
        ["message_Text"] = {
		    ["Pos"] = { 0.119792, 0.145833, -4.000000 },
		    ["Size"] = { 0.187500, 0.083333 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 0.717647, 1.000000, 0.435294, 1.000000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "globals.pleasewait",
		    ["Align"] = "Center",
		    ["VerticalAlign"] = "Top",
		    ["FontScale"] = 0.75,
		},
        ["SHIP_f_Icon"] = {
		    ["Pos"] = { 0.119792, 0.180555, -2.000000 },
		    ["Size"] = { 0.260417, 0.347222 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 3,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/loading/loading_ship.tga",
				}
			},
        },
        ["wave_Icon"] = {
		    ["Pos"] = { 0.119792, 0.180555, -5.000000 },
		    ["Size"] = { 0.260417, 0.347222 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Rotate"] = 1.000000,
		    ["geOrder"] = 1,
		    ["AutoRotate"] = -1.000000,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/loading/loading_wave.tga",
				}
			},
        }
	}
    
