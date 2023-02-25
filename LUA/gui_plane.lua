GuiScreen = {}

    GuiScreen["Pos"] = { -0.151042, -0.050000, 0.000000 }
    GuiScreen["WideScreenAlign"] = "Right"
    GuiScreen["geOrder"] = 0
    GuiScreen["muhorizont_dr_Icon"] = {
	    ["Pos"] = { 0.991668, 0.822223, -22.000000 },
	    ["Size"] = { 0.072917, 0.097222 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 4,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_shadow.tga",
			},
        }
	}
    GuiScreen["muhorizont_hl_Icon"] = {
	    ["Pos"] = { 0.984376, 0.819445, -23.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
	    ["geOrder"] = 3,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_light.tga",
			},
        }
	}
    GuiScreen["muhorizont_Model"] = {
	    ["Pos"] = { 1.241667, 1.070834, 1.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
	    ["geOrder"] = 16,
	    ["ModelName"] = "models\\gui\\horizont.MMOD",
	    ["ModelTextureOverride"] = "models\\Textures\\GUI_muhorizont.tga",
	    ["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
	}
    GuiScreen["plane_arrow_blue_Icon"] = {
	    ["Pos"] = { 0.990627, 0.821528, -3.000000 },
	    ["Size"] = { 0.020833, 0.019444 },
	    ["Pivot"] = { 2.894737, 0.423077 },
	    ["geOrder"] = 12,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/arrow_blue.tga",
			},
        }
	}
    GuiScreen["plane_arrow_red_Icon"] = {
	    ["Pos"] = { 0.990625, 0.822222, -4.000000 },
	    ["Size"] = { 0.020833, 0.019444 },
	    ["Pivot"] = { 2.894737, 0.461538 },
	    ["geOrder"] = 9,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/arrow_red.tga",
			},
        }
	}
    GuiScreen["plane_farme2_Icon"] = {
	    ["Pos"] = { 0.998959, 0.822222, 3.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 15,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_main.tga",
			},
        }
	}
    GuiScreen["plane_frame_Icon"] = {
	    ["Pos"] = { 0.998959, 0.822222, 2.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 14,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_frame.tga",
			},
        }
	}
    GuiScreen["plane_glass_Icon"] = {
	    ["Pos"] = { 0.962500, 0.819444, -30.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.300000 },
	    ["geOrder"] = 11,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_glass.tga",
			},
        }
	}
    GuiScreen["plane_payload_Group"] = {
	    ["Pos"] = { 0.651042, 0.550000, -1.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 1,
	    ["payload_type_Icon"] = {
		    ["Pos"] = { 0.604167, 0.448611, -1.000000 },
		    ["Size"] = { 0.051042, 0.038889 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/plane/counter_bomb.tga",
				},
                [2] = {
				    ["Texture"] = "gui/plane/counter_dc.tga",
				},
                [3] = {
				    ["Texture"] = "gui/plane/counter_ohka.tga",
				},
                [4] = {
				    ["Texture"] = "gui/plane/counter_paratroop.tga",
				},
                [5] = {
				    ["Texture"] = "gui/plane/counter_rocket.tga",
				},
                [6] = {
				    ["Texture"] = "gui/plane/counter_torpedo.tga",
				}
			},
        },
        ["ship_payload_1_Icon"] = {
		    ["Pos"] = { 0.613542, 0.450389, -10.000000 },
		    ["Size"] = { 0.012000, 0.025000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/elements/speed_num.tga",
				}
			},
        },
        ["ship_payload_2_Icon"] = {
		    ["Pos"] = { 0.621875, 0.450000, -11.000000 },
		    ["Size"] = { 0.012000, 0.025000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/elements/speed_num.tga",
				}
			},
        }
	}
    GuiScreen["plane_stick_Icon"] = {
	    ["Pos"] = { 1.058334, 0.853670, -10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 10,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_stick.tga",
			},
        }
	}
    GuiScreen["plane_warning_Icon"] = {
	    ["Pos"] = { 1.015626, 0.887500, -2.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 13,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/plane/plane_warning.tga",
			},
        }
	}
    GuiScreen["ship_speed_num1_Icon"] = {
	    ["Pos"] = { 1.044793, 0.896223, -10.000000 },
	    ["Size"] = { 0.012000, 0.025000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 5,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/elements/speed_num.tga",
			},
        }
	}
    GuiScreen["ship_speed_num2_Icon"] = {
	    ["Pos"] = { 1.054168, 0.896223, -10.000000 },
	    ["Size"] = { 0.012000, 0.025000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 6,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/elements/speed_num.tga",
			},
        }
	}
    GuiScreen["ship_speed_num3_Icon"] = {
	    ["Pos"] = { 1.063542, 0.896223, -10.000000 },
	    ["Size"] = { 0.012000, 0.025000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 8,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/elements/speed_num.tga",
			},
        }
	}
    GuiScreen["turbo_Group"] = {
	    ["Pos"] = { 0.641667, 0.500000, -20.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["plane_turbo_arrow_Icon"] = {
		    ["Pos"] = { 0.533333, 0.665278, -22.000000 },
		    ["Pivot"] = { 0.500000, 0.909091 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/indicators/arrow.tga",
				}
			},
        },
        ["plane_turbo_Icon"] = {
		    ["Pos"] = { 0.533333, 0.659723, -20.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/indicators/turbo_frame.tga",
				}
			},
        },
        ["plane_turbo_warning_Icon"] = {
		    ["Pos"] = { 0.533333, 0.660417, -21.000000 },
		    ["Size"] = { 0.035417, 0.050000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 0.666667, 0.050980, 0.035294, 0.500000 },
		    ["geOrder"] = 1,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "gui/indicators/warning.tga",
				}
			},
        }
	}
    
