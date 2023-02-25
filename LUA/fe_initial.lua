GuiScreen = {}

    GuiScreen["geOrder"] = 7
--[[
    ["copyright_Text"] = {
	    ["Pos"] = { 0.524833, 1.080000, -700.000000 },
	    ["Size"] = { 0.572917, 0.466667 },
	    ["Pivot"] = { 0.501266, 0.464879 },
	    ["Color"] = { 0.000000, 0.000000, 0.000000, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "FE.init_legal", --©2009 Eidos Interactive Limited Battlestations: Pacific is a trademark of Eidos Interactive Ltd Eidos and the Eidos logo are trademarks of Eidos plc
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 1,
	}
    GuiScreen["sublogo_bink_Icon"] = {
	    ["Pos"] = { 0.920000, 0.910000, -702.000000 },
	    ["Size"] = { 60/960, 60/720 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = Platform(true,false),
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "FE\\logo_bink.tga",
			},
        }
	}
    GuiScreen["sublogo_eidos_Icon"] = {
	    ["Pos"] = { 0.136000, 0.916000, -701.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "FE\\logo_eidos.tga",
			},
        }
	}
]]--
    GuiScreen["logo_pacfic_Icon"] = {
	    ["Pos"] = { 0.500000, 0.169444, -704.000000 },
	    ["Size"] = { 0.533333, 0.177778 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\logo_bsp.tga",
			},
        }
	}
    GuiScreen["New_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, 5.000000 },
		["Size"] = { 1.333333, 0.683333 },
		["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/bg/pic_4.tga",
			},
        }
	}
    GuiScreen["press_start_Text"] = {
	    ["Pos"] = { 0.596876, 0.942363, -700.000000 },
	    ["Size"] = { 0.520833, 0.054167 },
	    ["Pivot"] = { 0.670862, 4.233556 },
	    ["Color"] = { 0.878431, 0.690196, 0.411765, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = Platform("FE_pc.init_enter","FE_xbox.init_start"), --PRESS ENTER TO CONTINUE --PRESS START TO CONTINUE
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    
