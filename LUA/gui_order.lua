GuiScreen = {}

    GuiScreen["geOrder"] = 1
    GuiScreen["all_ship_leave_for_Icon"] = {
	    ["Pos"] = { 0.552083, 0.491667, -30.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui\\order_repair\\all_ship_leave_formation.tga",
			},
        }
	}
    GuiScreen["cancel_Icon"] = {
	    ["Pos"] = { 0.502083, 0.498611, -24.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/plane_cancel.tga",
			},
        }
	}
    GuiScreen["info_Text"] = {
	    ["Pos"] = { 0.501042, 0.620833, -22.000000 },
	    ["Size"] = { 0.270833, 0.027778 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 0.756863, 0.737255, 0.666667, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "Body Repair",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["plane_attack_Icon"] = {
	    ["Pos"] = { 0.503125, 0.431945, -23.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/plane_attack.tga",
			},
        }
	}
    GuiScreen["plane_formation_Icon"] = {
	    ["Pos"] = { 0.500000, 0.566667, -25.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/plane_regroup.tga",
			},
        }
	}
    GuiScreen["plane_landing_Icon"] = {
	    ["Pos"] = { 0.558333, 0.504861, -24.000000 },
	    ["Size"] = { 0.062500, 0.083333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/plane_land.tga",
			},
        }
	}
    GuiScreen["plane_retreat_Icon"] = {
	    ["Pos"] = { 0.558333, 0.500000, -26.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/plane_retreat.tga",
			},
        }
	}
    GuiScreen["repair_frame_Icon"] = {
	    ["Pos"] = { 0.502083, 0.498611, -1.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 1.200000 },
	    ["geOrder"] = 15,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/frame.tga",
			},
        }
	}
    GuiScreen["repair_glass_Icon"] = {
	    ["Pos"] = { 0.500000, 0.500000, -3.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.500000 },
	    ["geOrder"] = 2,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/glass.tga",
			},
        }
	}
    GuiScreen["repair_hl_east_Icon"] = {
	    ["Pos"] = { 0.551041, 0.497916, -17.000000 },
	    ["Size"] = { 0.111458, 0.074306 },
	    ["Pivot"] = { 0.508138, 0.517042 },
	    ["Rotate"] = -1.570796,
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 2.500000 },
	    ["geOrder"] = 5,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/highlight_side.tga",
			},
        }
	}
    GuiScreen["repair_hl_middle_Icon"] = {
	    ["Pos"] = { 0.502083, 0.495833, -19.000000 },
	    ["Size"] = { 0.042708, 0.056944 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 2.500000 },
	    ["geOrder"] = 3,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/highlight_center.tga",
			},
        }
	}
    GuiScreen["repair_hl_north_Icon"] = {
	    ["Pos"] = { 0.502083, 0.430556, -10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 2.500000 },
	    ["geOrder"] = 7,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/highlight_side.tga",
			},
        }
	}
    GuiScreen["repair_hl_south_Icon"] = {
	    ["Pos"] = { 0.502083, 0.561111, -16.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Rotate"] = 3.141593,
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 2.500000 },
	    ["geOrder"] = 6,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/highlight_side.tga",
			},
        }
	}
    GuiScreen["repair_hl_west_Icon"] = {
	    ["Pos"] = { 0.452083, 0.495833, -18.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Rotate"] = 1.570796,
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 2.500000 },
	    ["geOrder"] = 4,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/highlight_side.tga",
			},
        }
	}
    GuiScreen["ship_attack_Icon"] = {
	    ["Pos"] = { 0.502083, 0.434722, -27.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_attack.tga",
			},
        }
	}
    GuiScreen["ship_formation_Icon"] = {
	    ["Pos"] = { 0.501042, 0.568056, -29.000000 },
	    ["Size"] = { 0.062500, 0.083333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_formation_menu.tga",
			},
        }
	}
    GuiScreen["ship_leave_form_Icon"] = {
	    ["Pos"] = { 0.554167, 0.500000, -30.000000 },
	    ["Size"] = { 0.062500, 0.083333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_leave_formation.tga",
			},
        }
	}
    GuiScreen["ship_plane_agressive_Icon"] = {
	    ["Pos"] = { 0.444791, 0.498611, -22.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_agressive.tga",
			},
        }
	}
    GuiScreen["ship_plane_defensive_Icon"] = {
	    ["Pos"] = { 0.446875, 0.501389, -28.000000 },
	    ["Size"] = { 0.062500, 0.083333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_defensive.tga",
			},
        }
	}
    GuiScreen["ship_plane_move_Icon"] = {
	    ["Pos"] = { 0.503125, 0.431944, -31.000000 },
	    ["Size"] = { 0.062500, 0.083333 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_move.tga",
			},
        }
	}
    GuiScreen["ship_sell_Icon"] = {
	    ["Pos"] = { 0.554167, 0.494444, -32.000000 },
	    ["Size"] = { 0.067708, 0.090278 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/order_repair/ship_shell.tga",
			},
        }
	}
    
