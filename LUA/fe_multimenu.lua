GuiScreen = {}

    GuiScreen["Pos"] = { 0.000001, -0.001388, 0.000000 }
    GuiScreen["geOrder"] = 0
    GuiScreen["achievement_Clipbox"] = {
	    ["Pos"] = { 0.347916, 0.263888, 0.000000 },
	    ["Size"] = { 0.354167, 0.322223 },
	    ["geOrder"] = 14,
	    ["achievement_Group"] = {
		    ["Size"] = { 0.354167, 0.322223 },
		    ["geOrder"] = 6,
		    ["achievement_0_Icon"] = {
			    ["Pos"] = { 0.047917, 0.060417, -61.000000 },
			    ["Size"] = { 0.066667, 0.088889 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 0,
			    ["MouseHit"] = true,
			    ["achievement_lock_Icon"] = {
				    ["Pos"] = { 0.033334, 0.044445, -1.000000 },
				    ["Size"] = { 0.066667, 0.088889 },
				    ["Pivot"] = { 0.500000, 0.500000 },
				    ["Visible"] = false,
				    ["geOrder"] = 0,
				    ["MouseHit"] = true,
				    ["States"] = {
					    [1] = {
						    ["Texture"] = "FE/lock.tga",
						}
					}
				},
                ["States"] = {
				    [1] = {
					    ["Texture"] = "FE\\achievement\\ge_US_regular.tga",
					}
				}
			},
            ["select_FrameBox"] = {
			    ["Pos"] = { 0.050000, 0.058334, -100.000000 },
			    ["Size"] = { 0.083334, 0.111111 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["FrameSizesX"] = { 0.014583, 0.014583 },
			    ["FrameSizesY"] = { 0.026389, 0.026389 },
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\framebox\\framebox_04.tga",
					}
				}
			},
        },
        ["BorderWidth"] = { 0.001000, 0.010000 },
	}
    GuiScreen["achievement_FrameBox"] = {
	    ["Pos"] = { 0.341666, 0.249999, 0.000000 },
	    ["Size"] = { 0.296875, 0.500000 },
	    ["geOrder"] = 1,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01.tga",
			},
        }
	}
    GuiScreen["achievement_top_Text"] = {
	    ["Pos"] = { 0.352082, 0.216666, -5.000000 },
	    ["Size"] = { 0.354167, 0.034722 },
	    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
	    ["geOrder"] = 5,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.multi_achievement",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["arrow_bottom_Icon"] = {
	    ["Pos"] = { 0.618750, 0.575000, -10.000000 },
	    ["Size"] = { 0.016667, 0.022222 },
	    ["Pivot"] = { 0.000000, 1.000000 },
	    ["geOrder"] = 10,
	    ["MouseHit"] = true,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\arrows\\arrow_down.tga",
			},
            [2] = {
			    ["Texture"] = "common\\arrows\\arrow_down_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common\\arrows\\arrow_down_on.tga",
			},
        }
	}
    GuiScreen["arrow_top_Icon"] = {
	    ["Pos"] = { 0.618750, 0.269444, -10.000000 },
	    ["Size"] = { 0.016667, 0.022222 },
	    ["geOrder"] = 8,
	    ["MouseHit"] = true,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\arrows\\arrow_up.tga",
			},
            [2] = {
			    ["Texture"] = "common\\arrows\\arrow_up_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common\\arrows\\arrow_up_on.tga",
			},
        }
	}
    GuiScreen["bg_Icon"] = {
	    ["Pos"] = { 0.499999, 0.501388, 50.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe\\bg\\multiplayer.tga",
			},
        }
	}
    GuiScreen["line_FrameBox"] = {
	    ["Pos"] = { 0.341666, 0.594444, 1.000000 },
	    ["Size"] = { 0.296875, 0.002778 },
	    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.800000 },
	    ["geOrder"] = 2,
	    ["FrameSizesX"] = { 0.041667, 0.041667 },
	    ["FrameSizesY"] = { 0.002778, 0.002778 },
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01.tga",
			},
        }
	}
    GuiScreen["player_Group"] = {
	    ["Pos"] = { 0.661458, 0.479167, -10.000000 },
	    ["Size"] = { 0.322917, 0.263889 },
	    ["geOrder"] = 3,
	    ["multiscore_Text"] = {
		    ["Pos"] = { 0.010417, 0.187500, 0.000000 },
		    ["Size"] = { 0.175000, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 4,
		    ["Font"] = "Arial18",
		    ["DefaultText"] = "FE.multi_score",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["multiscore_var_Text"] = {
		    ["Pos"] = { 0.021875, 0.223611, 0.000000 },
		    ["Size"] = { 0.235417, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 5,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "12544 / 13000",
		    ["Align"] = "Center",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["playername_Text"] = {
		    ["Pos"] = { 0.010417, 0.006944, 0.000000 },
		    ["Size"] = { 0.260417, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial18",
		    ["DefaultText"] = "FE.multi_playername",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["playername_var_Text"] = {
		    ["Pos"] = { 0.020834, 0.048611, 0.000000 },
		    ["Size"] = { 0.310417, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "WWWWWWWWWWWWWW",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["rank_prog_Icon"] = {
		    ["Pos"] = { 0.022916, 0.229167, 3.000000 },
		    ["Size"] = { 0.104167, 0.025000 },
		    ["geOrder"] = 6,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\framebox\\framebox_point_A.tga",
				}
			},
        },
        ["rank_prog_new_Icon"] = {
		    ["Pos"] = { 0.022916, 0.229167, 4.000000 },
		    ["Size"] = { 0.135417, 0.025000 },
		    ["Color"] = { 1.000000, 0.784314, 0.000000, 1.000000 },
		    ["geOrder"] = 8,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\framebox\\framebox_point_B.tga",
				}
			},
        },
        ["rank_Text"] = {
		    ["Pos"] = { 0.010417, 0.097222, 0.000000 },
		    ["Size"] = { 0.175000, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 2,
		    ["Font"] = "Arial18",
		    ["DefaultText"] = "FE.multi_rank",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["rank_var_Text"] = {
		    ["Pos"] = { 0.020833, 0.138889, 0.000000 },
		    ["Size"] = { 0.256250, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 3,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "Petty Officer Second Class",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["rankgraf_FrameBox"] = {
		    ["Pos"] = { 0.139584, 0.240972, -5.000000 },
		    ["Size"] = { 0.239583, 0.033333 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["FrameSizesX"] = { 0.016667, 0.016667 },
		    ["FrameSizesY"] = { 0.020833, 0.020833 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\framebox\\framebox_04.tga",
				}
			},
        }
	}
    GuiScreen["playerinfo_FrameBox"] = {
	    ["Pos"] = { 0.656250, 0.250000, 0.000000 },
	    ["Size"] = { 0.291667, 0.500000 },
	    ["geOrder"] = 9,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common/framebox/framebox_01.tga",
			},
        }
	}
    GuiScreen["playerinfo_top_Text"] = {
	    ["Pos"] = { 0.664583, 0.216667, -5.000000 },
	    ["Size"] = { 0.302083, 0.034722 },
	    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Viper19",
	    ["DefaultText"] = "FE.multi_playerinfo",
	    ["Align"] = "Left",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["rank_Icon"] = {
	    ["Pos"] = { 0.802083, 0.361111, -24.000000 },
	    ["Size"] = { 0.177083, 0.159722 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 7,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "FE\\playerrank\\01_seaman3_big.tga",
			},
            [2] = {
			    ["Texture"] = "FE\\playerrank\\02_seaman2_big.tga",
			},
            [3] = {
			    ["Texture"] = "FE\\playerrank\\03_seaman1_big.tga",
			},
            [4] = {
			    ["Texture"] = "FE\\playerrank\\04_petty3_big.tga",
			},
            [5] = {
			    ["Texture"] = "FE\\playerrank\\05_petty2_big.tga",
			},
            [6] = {
			    ["Texture"] = "FE\\playerrank\\06_petty1_big.tga",
			},
            [7] = {
			    ["Texture"] = "FE\\playerrank\\07_petty_chief_big.tga",
			},
            [8] = {
			    ["Texture"] = "FE\\playerrank\\08_warrant_big.tga",
			},
            [9] = {
			    ["Texture"] = "FE\\playerrank\\09_warrant_chief_big.tga",
			},
            [10] = {
			    ["Texture"] = "FE\\playerrank\\10_ensign_big.tga",
			},
            [11] = {
			    ["Texture"] = "FE\\playerrank\\11_lieutenant_junior_big.tga",
			},
            [12] = {
			    ["Texture"] = "FE\\playerrank\\12_lieutenant_big.tga",
			},
            [13] = {
			    ["Texture"] = "FE\\playerrank\\13_lieutenant_commander_big.tga",
			},
            [14] = {
			    ["Texture"] = "FE\\playerrank\\14_commander_big.tga",
			},
            [15] = {
			    ["Texture"] = "FE\\playerrank\\15_captain_big.tga",
			},
            [16] = {
			    ["Texture"] = "FE\\playerrank\\16_commodore_big.tga",
			},
            [17] = {
			    ["Texture"] = "FE\\playerrank\\17_admiral_rear_big.tga",
			},
            [18] = {
			    ["Texture"] = "FE\\playerrank\\18_admiral_vice_big.tga",
			},
            [19] = {
			    ["Texture"] = "FE\\playerrank\\19_admiral_big.tga",
			},
            [20] = {
			    ["Texture"] = "FE\\playerrank\\20_admiral_fleet_big.tga",
			},
        }
	}
    GuiScreen["slider_bg_Icon"] = {
	    ["Pos"] = { 0.618959, 0.290278, -5.000000 },
	    ["Size"] = { 0.016667, 0.263889 },
	    ["geOrder"] = 12,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\slider\\slider_bg.tga",
			},
        }
	}
    GuiScreen["slider_FrameBox"] = {
	    ["Pos"] = { 0.618750, 0.290277, -10.000000 },
	    ["Size"] = { 0.016667, 0.041666 },
	    ["geOrder"] = 11,
	    ["MouseHit"] = true,
	    ["FrameSizesX"] = { 0.006250, 0.006250 },
	    ["FrameSizesY"] = { 0.016660, 0.016660 },
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "common\\slider\\slider.tga",
			},
            [2] = {
			    ["Texture"] = "common\\slider\\slider_mouse.tga",
			},
            [3] = {
			    ["Texture"] = "common\\slider\\slider_on.tga",
			},
        }
	}
    GuiScreen["text_Group"] = {
	    ["Pos"] = { 0.346874, 0.583332, -10.000000 },
	    ["Size"] = { 0.270833, 0.159722 },
	    ["geOrder"] = 13,
	    ["achievement_description_Text"] = {
		    ["Pos"] = { 0.010417, 0.045833, 0.000000 },
		    ["Size"] = { 0.250000, 0.138889 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 2,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
		    ["Align"] = "Justified",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["achievement_name_Text"] = {
		    ["Pos"] = { 0.010417, 0.013889, 0.000000 },
		    ["Size"] = { 0.250000, 0.037500 },
		    ["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Arial18",
		    ["DefaultText"] = "Armchair Admiral",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		}
	}
    
