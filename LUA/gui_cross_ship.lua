GuiScreen = {}

    GuiScreen["geOrder"] = 7
    GuiScreen["ship_AA_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 100.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 4,
	    ["cross__Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -100.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 5,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/aa_ship.tga",
				}
			},
        },
        ["cross_F_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -104.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/aa_ship_friendly.tga",
				}
			},
            ["cross_F2_Icon"] =
			{
			    ["Pos"] = { 0.00000, 0.00000, 0.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["States"] =
				{
				    [1] =
					{
					    ["Texture"] = "gui/crosshairs/_friendly.tga",
					}
				}
			},
        },
        ["cross_H_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -102.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/aa_ship_effective.tga",
				}
			},
        },
        ["cross_HF_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -103.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/aa_ship_ineffective.tga",
				}
			},
        },
        ["cross_L_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -101.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/aa_ship_lock.tga",
				}
			},
        }
	}
    GuiScreen["ship_art_Group"] = {
	    ["Pos"] = { 0.500000, 0.50833333333333333333333333333333, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["cross__Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_main.tga",
				}
			},
        },
        ["cross_botton_Icon"] = {
		    ["Pos"] = { 0.250000, 0.280555, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 3,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_down.tga",
				}
			},
        },
        ["cross_F_Icon"] = {
		    ["Pos"] = { 0.250000, 0.265973, -1.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_friendly.tga",
				}
			},
            ["cross_F2_Icon"] =
			{
			    ["Pos"] = { 0.00000, 0.00000, 0.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["States"] =
				{
				    [1] =
					{
					    ["Texture"] = "gui/crosshairs/_friendly.tga",
					}
				}
			},
        },
        ["cross_H_Icon"] = {
		    ["Pos"] = { 0.250000, 0.265973, -1.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_effective.tga",
				}
			},
        },
        ["cross_HF_Icon"] = {
		    ["Pos"] = { 0.250000, 0.265973, -1.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_ineffective.tga",
				}
			},
        },
        ["cross_left_Icon"] = {
		    ["Pos"] = { 0.215625, 0.243056, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Rotate"] = 3.1415926535897932384626433832795,
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_right.tga",
				}
			},
        },
        ["cross_right_Icon"] = {
		    ["Pos"] = { 0.284375, 0.243056, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/artillery_right.tga",
				}
			},
        }
	}
    GuiScreen["ship_DC_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 1,
	    ["cross__Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Size"] = { 0.107292, 0.073611 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 3,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/dc_ship.tga",
				},
                [2] = {
				    ["Texture"] = "gui/crosshairs/dc_hedgehog.tga",
				}
			},
        },
        ["cross_H_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/dc_effective.tga",
				}
			},
        }
	}
    GuiScreen["ship_rocket_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 5,
	    ["cross__Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/rocket.tga",
				}
			},
        },
        ["cross_F_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -4.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/rocket_friendly.tga",
				}
			},
            ["cross_F2_Icon"] =
			{
			    ["Pos"] = { 0.00000, 0.00000, 0.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["States"] =
				{
				    [1] =
					{
					    ["Texture"] = "gui/crosshairs/_friendly.tga",
					}
				}
			},
        },
        ["cross_H_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -2.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/rocket_effective.tga",
				}
			},
        },
        ["cross_HF_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, -3.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/rocket_ineffective.tga",
				}
			},
        },
        ["cross_L_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/rocket.tga",
				}
			},
        }
	}
    GuiScreen["ship_torpedo_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 3,
	    ["cross__Icon"] = {
		    ["Pos"] = { 0.250000, 0.218056, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/torpedo_ship_main.tga",
				}
			},
        },
        ["cross_F_Icon"] = {
		    ["Pos"] = { 0.250000, 0.218057, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/torpedo_friendly.tga",
				}
			},
            ["cross_F2_Icon"] =
			{
			    ["Pos"] = { 0.00000, 0.00000, 0.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["States"] =
				{
				    [1] =
					{
					    ["Texture"] = "gui/crosshairs/_friendly.tga",
					}
				}
			},
        },
        ["cross_H_Icon"] = {
		    ["Pos"] = { 0.250000, 0.218057, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/torpedo_effective.tga",
				}
			},
        },
        ["cross_tilt_Icon"] = {
		    ["Pos"] = { 0.251042, 0.245835, -1.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/crosshairs/tilt.tga",
				}
			},
        }
	}
    
