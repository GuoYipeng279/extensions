GuiScreen = {}

    GuiScreen["Pos"] = { -0.288541, 0.015278, 0.000000 }
    GuiScreen["geOrder"] = 9
    GuiScreen["FlagJP_Icon"] = {
	    ["Pos"] = { 1.030208, 0.894444, -13.000000 },
	    ["Size"] = { 0.028125, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 4,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\flag_IJN.tga",
			},
        }
	}
    GuiScreen["FlagUS_Icon"] = {
	    ["Pos"] = { 1.030208, 0.894444, -12.000000 },
	    ["Size"] = { 0.028125, 0.020833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 3,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\flag_USA.tga",
			},
        }
	}
    GuiScreen["unit_command_Icon"] = {
	    ["Pos"] = { 1.217708, 0.906944, -16.000000 },
	    ["Size"] = { 0.034375, 0.045833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 1,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "GUI/unitframe/command_stop.tga",
			},
            [2] = {
			    ["Texture"] = "GUI/unitframe/command_move.tga",
			},
            [3] = {
			    ["Texture"] = "GUI/unitframe/command_cruise.tga",
			},
            [4] = {
			    ["Texture"] = "GUI/unitframe/command_attack.tga",
			},
            [5] = {
			    ["Texture"] = "GUI/unitframe/command_land.tga",
			},
        }
	}
    GuiScreen["unit_frame_Icon"] = {
	    ["Pos"] = { 1.106251, 0.908333, -10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 9,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "GUI\\unitframe\\frame.tga",
			},
        }
	}
    GuiScreen["unit_HP_damage_Icon"] = {
	    ["Pos"] = { 1.015625, 0.919444, -13.000000 },
	    ["Size"] = { 0.181250, 0.013889 },
	    ["Pivot"] = { 0.000000, 0.505050 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 6,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "GUI\\elements\\hp_lightgreen.tga",
			},
        }
	}
    GuiScreen["unit_HP_healthy_Icon"] = {
	    ["Pos"] = { 1.015625, 0.919444, -14.000000 },
	    ["Size"] = { 0.181250, 0.013889 },
	    ["Pivot"] = { 0.000000, 0.505050 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 5,
	    ["ShaderName"] = "GuiFontBilinear.mshd",
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "GUI\\elements\\hp_green.tga",
			},
        }
	}
    GuiScreen["unit_name_Text"] = {
	    ["Pos"] = { 1.115276, 0.894443, -17.000000 },
	    ["Size"] = { 0.147917, 0.019444 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Color"] = { 0.874510, 0.874510, 0.874510, 1.000000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 0,
	    ["Font"] = "Arial15",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Center",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["unit_payload_Icon"] = {
	    ["Pos"] = { 0.994793, 0.908333, -15.000000 },
	    ["Size"] = { 0.034375, 0.045833 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["geOrder"] = 2,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/icons/class/command_01_l.tga",
			},
            [2] = {
			    ["Texture"] = "common/icons/class/CV_l.tga",
			},
            [3] = {
			    ["Texture"] = "common/icons/class/shipyard_l.tga",
			},
            [4] = {
			    ["Texture"] = "gui/support_powerup/state_disabled.tga",
			},
            [5] = {
			    ["Texture"] = "common/icons/class/DD_l.tga",
			},
            [6] = {
			    ["Texture"] = "common/icons/class/SUB_l.tga",
			},
            [7] = {
			    ["Texture"] = "common/icons/class/CV_l.tga",
			},
            [8] = {
			    ["Texture"] = "common/icons/class/CL_l.tga",
			},
            [9] = {
			    ["Texture"] = "common/icons/class/CA_l.tga",
			},
            [10] = {
			    ["Texture"] = "common/icons/class/AP_l.tga",
			},
            [11] = {
			    ["Texture"] = "common/icons/class/LSM_l.tga",
			},
            [12] = {
			    ["Texture"] = "common/icons/class/LST_l.tga",
			},
            [13] = {
			    ["Texture"] = "common/icons/class/BB_l.tga",
			},
            [14] = {
			    ["Texture"] = "common/icons/class/PT_l.tga",
			},
            [15] = {
			    ["Texture"] = "common/icons/class/divebomber_l.tga",
			},
            [16] = {
			    ["Texture"] = "common/icons/class/fighter_l.tga",
			},
            [17] = {
			    ["Texture"] = "common/icons/class/recon_l.tga",
			},
            [18] = {
			    ["Texture"] = "common/icons/class/levelbomber_l.tga",
			},
            [19] = {
			    ["Texture"] = "common/icons/class/recon_l.tga",
			},
            [20] = {
			    ["Texture"] = "common/icons/class/torpedobomber_l.tga",
			},
            [21] = {
			    ["Texture"] = "common/whiteGui.tga",
			},
            [22] = {
			    ["Texture"] = "common/icons/class/BC_l.tga",
			},
            [23] = {
			    ["Texture"] = "common/icons/class/CVE_l.tga",
			},
            [24] = {
			    ["Texture"] = "common/icons/class/command_02_l.tga",
			},
            [25] = {
			    ["Texture"] = "common/icons/class/command_03_l.tga",
			},
            [26] = {
			    ["Texture"] = "common/icons/class/spawnpoint_l.tga",
			},
            [27] = {
			    ["Texture"] = "common/icons/class/paratrooper_l.tga",
			},
            [28] = {
			    ["Texture"] = "common/icons/class/suicide_boat_l.tga",
			},
            [29] = {
			    ["Texture"] = "gui/support_powerup/state_disabled.tga",
			},
            [30] = {
			    ["Texture"] = "common/icons/class/airfield_l.tga",
			},
            [31] = {
			    ["Texture"] = "common/icons/class/command_01_l.tga",
			},
            [32] = {
			    ["Texture"] = "common/icons/class/shipyard_l.tga",
			},
        }
	}
    
