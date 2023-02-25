GuiScreen = {}

    GuiScreen["Editable"] = true
    GuiScreen["Priority"] = 20
--    ["Failure_Warning_Group"] = {
--	    ["Pos"] = { 0.100000, 0.330000, 0.000000 },
--	    ["WideScreenAlign"] = "Right",
--	    ["Device_Icon"] = {
--		    ["Pos"] = { 0.800000, 0.470000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_kormany.tga",
--				}
--			}
--		}
--	    ["Fire_Icon"] = {
--		    ["Pos"] = { 0.795000, 0.415000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_tuz.tga",
--				}
--			}
--		}
--	    ["Leak_Icon"] = {
--		    ["Pos"] = { 0.790000, 0.520000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
---				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_viz.tga",
--				}
--			}
--		}
--	    ["Machine_Icon"] = {
--		    ["Pos"] = { 0.770000, 0.370000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_motor.tga",
--				}
--			}
--		}
--	}
--    ["Failures_Group"] =
--	{
--	    ["Pos"] = { 0.100000, 0.330000, 0.000000 },
--	    ["WideScreenAlign"] = "Right",
--	    ["Body_Icon"] = {
--		    ["Pos"] = { -0.004000, 0.045000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_orders_kiskor.tga",
--				}
--			}
--		}
--	    ["BottomSelected_Icon"] = {
--		    ["Pos"] = { 0.015000, 0.120000, 0.000000 },
--		    ["Size"] = { 0.030000, 0.030000 },
--		    ["Pivot"] = { 0.500000, 0.500000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "whiteGui.tga",
--				}
--			}
--		}
--	    ["Device_Bg_Icon"] = {
--		    ["Pos"] = { -0.050000, 0.130000, -5.000000 },
--		    ["Rotate"] = 1.572000,
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_alap.tga",
--				}
--			}
--		}
--	    ["Device_Icon"] = {
--		    ["Pos"] = { -0.040000, 0.050000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_kormany.tga",
--				}
--			}
--		}
--	    ["Fire_Bg_Icon"] = {
--		    ["Pos"] = { 0.059000, 0.155000, -5.000000 },
--		    ["Rotate"] = 3.142000,
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_alap.tga",
--				}
--			}
--		}
--	    ["Fire_Icon"] = {
--		    ["Pos"] = { 0.000000, 0.105000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_tuz.tga",
--				}
--			}
--		}
--	    ["Leak_Bg_Icon"] = {
--		    ["Pos"] = { 0.079000, 0.010000, -5.000000 },
--		    ["Rotate"] = 4.714000,
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_alap.tga",
--				}
--			}
--		}
--	    ["Leak_Icon"] = {
--		    ["Pos"] = { 0.040000, 0.050000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_viz.tga",
--				}
--			}
--		}
--	    ["LeftSelected_Icon"] = {
--		    ["Pos"] = { -0.030000, 0.065000, 0.000000 },
--		    ["Size"] = { 0.030000, 0.030000 },
--		    ["Pivot"] = { 0.500000, 0.500000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "whiteGui.tga",
--				}
--			}
--		}
--	    ["Machine_Bg_Icon"] = {
--		    ["Pos"] = { -0.030000, -0.015000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_alap.tga",
--				}
--			}
--		}
--	    ["Machine_Icon"] = {
--		    ["Pos"] = { 0.005000, 0.000000, -5.000000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "bsj_textures/gui_ingame/gui_repair_motor.tga",
--				}
--			}
--		}
--	    ["MiddleSelected_Icon"] = {
--		    ["Pos"] = { 0.015000, 0.075000, 0.000000 },
--		    ["Size"] = { 0.030000, 0.030000 },
--		    ["Pivot"] = { 0.500000, 0.500000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "whiteGui.tga",
--				}
--			}
--		}
--	    ["RightSelected_Icon"] = {
--		    ["Pos"] = { 0.050000, 0.070000, 0.000000 },
--		    ["Size"] = { 0.030000, 0.030000 },
--		    ["Pivot"] = { 0.500000, 0.500000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "whiteGui.tga",
--				}
--			}
--		}
--	    ["TopSelected_Icon"] = {
--		    ["Pos"] = { 0.020000, 0.020000, 0.000000 },
--		    ["Size"] = { 0.030000, 0.030000 },
--		    ["Pivot"] = { 0.500000, 0.500000 },
--		    ["States"] = {
--			    [1] = {
--				    ["Texture"] = "whiteGui.tga",
--				}
--			}
--		}
--	}
    GuiScreen["VillanasAlso_Icon"] = {
	    ["Pos"] = { 0.500000, 1.000000, 0.000000 },
	    ["Size"] = { 0.200000, 1.000000 },
	    ["Pivot"] = { 1.000000, 0.500000 },
	    ["Rotate"] = 4.710000,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/effects/villanas.tga",
			},
        }
	}
    GuiScreen["VillanasBal_Icon"] = {
	    ["Pos"] = { 0.000000, 0.500000, 0.000000 },
	    ["Size"] = { 0.200000, 1.000000 },
	    ["Pivot"] = { 1.000000, 0.500000 },
	    ["Rotate"] = 3.140000,
	    ["WideScreenAlign"] = "Left",
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/effects/villanas.tga",
			},
        }
	}
    GuiScreen["VillanasFelso_Icon"] = {
	    ["Pos"] = { 0.500000, 0.000000, 0.000000 },
	    ["Size"] = { 0.200000, 1.000000 },
	    ["Pivot"] = { 1.000000, 0.500000 },
	    ["Rotate"] = 1.570000,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/effects/villanas.tga",
			},
        }
	}
    GuiScreen["VillanasJobb_Icon"] = {
	    ["Pos"] = { 1.006250, 0.500000, 0.000000 },
	    ["Size"] = { 0.200000, 1.000000 },
	    ["Pivot"] = { 1.000000, 0.500000 },
	    ["WideScreenAlign"] = "Right",
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "gui/effects/villanas.tga",
			},
        }
	}
    
