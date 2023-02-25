GuiScreen = {}

    GuiScreen["geOrder"] = 4
    GuiScreen["background_Group"] = {
	    ["Pos"] = { 0.500000, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 2,
	    ["big_Icon"] = {
		    ["Pos"] = { 0.384375, 0.168056, 7.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "fe/bg/tactical.tga",
				}
			},
        },
        ["small_Icon"] = {
		    ["Pos"] = { 0.250000, 0.250000, 0.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "fe/bg/tactical_alpha.tga",
				}
			},
        }
	}
    GuiScreen["hajnal_Group"] = {
	    ["Pos"] = { 0.512500, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 4,
	    ["achievment_Group"] = {
		    ["Pos"] = { 0.348959, 0.264583, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 5,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.157639, 1.000000 },
			    ["Size"] = { 0.213334, 0.284445 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/whiteGui.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Pos"] = { 0.287499, 0.157639, 2.000000 },
			    ["Size"] = { 0.467708, 0.350000 },
			    ["Pivot"] = { 0.502083, 0.503704 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_01.tga",
					}
				}
			},
            ["lock_Icon"] = {
			    ["Pos"] = { 0.286458, 0.157639, 0.000000 },
			    ["Size"] = { 0.213334, 0.284445 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe\\lock02.tga",
					}
				}
			},
            ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 3,
			    ["keret_FrameBox"] = {
				    ["Pos"] = { 0.250000, 0.187111, -1.000000 },
				    ["Size"] = { 0.500000, 0.375000 },
				    ["Pivot"] = { 0.500000, 0.500000 },
				    ["geOrder"] = 0,
				    ["States"] = {
					    [1] = {
						    ["Texture"] = "common/framebox/framebox_01.tga",
						}
					}
				},
                ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
        },
        ["arrow_left_Icon"] = {
		    ["Pos"] = { 0.107292, 0.172222, -5.000000 },
		    ["Size"] = { 0.025000, 0.025000 },
		    ["Pivot"] = { 0.444444, 0.500000 },
		    ["Rotate"] = 1.570796,
		    ["WideScreenAlign"] = "Left",
		    ["Visible"] = false,
		    ["geOrder"] = 3,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_up.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_up_on.tga",
				},
                [4] = {
				    ["Texture"] = "common/arrows/arrow_up_inactive.tga",
				},
                [5] = {
				    ["Texture"] = "common/arrows/arrow_up_lock.tga",
				}
			},
        },
        ["arrow_right_Icon"] = {
		    ["Pos"] = { 0.653125, 0.172222, -5.000000 },
		    ["Size"] = { 0.025000, 0.025000 },
		    ["Pivot"] = { 0.444444, 0.500000 },
		    ["Rotate"] = 1.570796,
		    ["WideScreenAlign"] = "Left",
		    ["Visible"] = false,
		    ["geOrder"] = 4,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_down.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_down_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_down_on.tga",
				},
                [4] = {
				    ["Texture"] = "common/arrows/arrow_down_inactive.tga",
				},
                [5] = {
				    ["Texture"] = "common/arrows/arrow_down_lock.tga",
				}
			},
        },
        ["left_big_Icon"] = {
		    ["Pos"] = { 0.098958, 0.170833, -3.000000 },
		    ["Size"] = { 0.026042, 0.034722 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Rotate"] = 1.570796,
		    ["geOrder"] = 0,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\arrows\\arrow_up.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_up_on.tga",
				},
                [4] = {
				    ["Texture"] = "common/arrows/arrow_up_inactive.tga",
				}
			},
        },
        ["movies_Group"] = {
		    ["Pos"] = { 0.348959, 0.264583, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 10,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.380207, 0.076389, -4.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 3,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Pos"] = { 0.000001, 0.000694, 0.000000 },
			    ["Size"] = { 0.467708, 0.350000 },
			    ["Pivot"] = { 0.698660, 0.265873 },
			    ["Visible"] = false,
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_02.tga",
					}
				}
			},
            ["pic_Hide_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 0.000000 },
				--["Size"] = { 0.500000, 0.375000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
            ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
			    ["Size"] = { 0.533333, 0.355556 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
        },
        ["noseart_Group"] = {
		    ["Pos"] = { 0.348959, 0.264583, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 9,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.380207, 0.076389, -4.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 5,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Pos"] = { -0.000001, -0.000694, 2.000000 },
			    ["Size"] = { 0.500000, 0.377778 },
			    ["Pivot"] = { 0.687500, 0.285185 },
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\framebox\\framebox_01.tga",
					},
                    [2] = {
					    ["Texture"] = "common\\framebox\\framebox_01_select.tga",
					}
				}
			},
            ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.157639, -3.000000 },
			    ["Size"] = { 0.266667, 0.355556 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = -3,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
        },
        ["powerups_Group"] = {
		    ["Pos"] = { 0.348959, 0.264583, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 8,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.380207, 0.076389, -4.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 5,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["icon_big_BG2_Icon"] = {
			    ["Pos"] = { 0.086007, 0.026389, 0.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = true,
			    ["geOrder"] = 5,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Pos"] = { 0.379166, 0.075695, 0.000000 },
			    ["Size"] = { 0.467708, 0.350000 },
			    ["Pivot"] = { 0.698660, 0.265873 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_02.tga",
					}
				}
			},
		    ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
			    ["Size"] = { 0.533333, 0.355556 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/whiteGui.tga",
					}
				}
			},
        },
        ["right_big_Icon"] = {
		    ["Pos"] = { 0.673958, 0.169444, -3.000000 },
		    ["Size"] = { 0.026042, 0.034722 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Rotate"] = 4.712389,
		    ["geOrder"] = 1,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_up.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_up_on.tga",
				},
                [4] = {
				    ["Texture"] = "common/arrows/arrow_up_inactive.tga",
				}
			},
        },
        ["tutorial_Group"] = {
		    ["Pos"] = { 0.348959, 0.264583, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 7,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.380207, 0.076389, -4.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Size"] = { 0.467708, 0.350000 },
			    ["Pivot"] = { 0.698660, 0.265873 },
			    ["Visible"] = false,
			    ["geOrder"] = 1,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_02.tga",
					}
				}
			},
            ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
				--["Size"] = { 0.500000, 0.375000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
            ["video_Movie"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
			    ["Size"] = { 0.464583, 0.347222 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 3,
			    ["MovieName"] = "",
			},
        },
        ["units_Group"] = {
		    ["Pos"] = { 0.348958, 0.263889, 4.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 6,
		    ["icon_big_BG_Icon"] = {
			    ["Pos"] = { 0.380207, 0.076389, -4.000000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["Visible"] = false,
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/icons/class/ammo_bomb_s.tga",
					}
				}
			},
            ["keret_FrameBox"] = {
			    ["Pos"] = { 0.000001, 0.000694, 0.000000 },
			    ["Size"] = { 0.467708, 0.350000 },
			    ["Pivot"] = { 0.698660, 0.265873 },
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_02.tga",
					}
				}
			},
            ["pic_BG_Icon"] = {
			    ["Pos"] = { 0.286458, 0.158028, 1.000000 },
			    ["Size"] = { 0.533333, 0.355556 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 3,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "fe/moviepic.tga",
					}
				}
			},
        }
	}
    GuiScreen["INFO_box_Group"] = {
	    ["Pos"] = { 0.869791, 0.729167, -3.000000 },
	    ["Size"] = { 0.467708, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 5,
	    ["A_FrameBox"] = {
		    ["Pos"] = { 0.007291, 0.251389, 2.000000 },
		    ["Size"] = { 0.466667, 0.166667 },
		    ["Pivot"] = { 0.491667, 0.528125 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["arrow_botton_scroll_Icon"] = {
		    ["Pos"] = { 0.232293, 0.315972, -5.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 5,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_down.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_down_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_down_on.tga",
				}
			},
        },
        ["arrow_top_scroll_Icon"] = {
		    ["Pos"] = { 0.232292, 0.178471, -5.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_up.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_up_on.tga",
				}
			},
        },
        ["test_Clipbox"] = {
		    ["Pos"] = { -0.216667, 0.170833, -14.000000 },
		    ["Size"] = { 0.441667, 0.152778 },
		    ["Pivot"] = { 0.003030, 0.007716 },
		    ["geOrder"] = 13,
		    ["textbox_Group"] = {
			    ["Pos"] = { 0.000000, 0.005556, 0.000000 },
			    ["Size"] = { 0.437500, 0.143056 },
			    ["geOrder"] = 0,
			    ["content_main_Text"] = {
				    ["Pos"] = { 0.001325, -0.000318, -15.000000 },
				    ["Size"] = { 0.434375, 0.138889 },
				    ["Color"] = { 0.976471, 0.862745, 0.600000, 1.000000 },
				    ["geOrder"] = 14,
				    ["Font"] = "Arial16",
				    ["DefaultText"] = "dsdfd",
				    ["Align"] = "Justified",
				    ["VerticalAlign"] = "Top",
				    ["DefaultShadow"] = 0,
				}
			},
            ["BorderWidth"] = { 0.001000, 0.010000 },
		},
        ["textx_scroll_bg_Icon"] = {
		    ["Pos"] = { 0.232813, 0.187500, -4.000000 },
		    ["Size"] = { 0.015625, 0.119444 },
		    ["Pivot"] = { 0.533333, 0.000000 },
		    ["geOrder"] = 7,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/slider/slider_bg.tga",
				}
			},
        },
        ["textx_scroll_Framebox"] = {
		    ["Pos"] = { 0.232291, 0.186111, -12.000000 },
		    ["Size"] = { 0.014583, 0.033333 },
		    ["Pivot"] = { 0.500000, 0.000000 },
		    ["geOrder"] = 0,
		    ["MouseHit"] = true,
		    ["FrameSizesX"] = { 0.006250, 0.006250 },
		    ["FrameSizesY"] = { 0.016660, 0.016660 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/slider/slider.tga",
				},
                [2] = {
				    ["Texture"] = "common/slider/slider_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/slider/slider_on.tga",
				}
			},
        }
	}
    GuiScreen["no_unlock_Text"] = {
	    ["Pos"] = { 0.631666, 0.448749, -3.000000 },
	    ["Size"] = { 0.487500, 0.031944 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 0,
	    ["Font"] = "Arial16",
	    ["DefaultText"] = "FE.taclib_nounlock",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Top",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["SubtitlesNormal_Text"] = {
	    ["Pos"] = { 0.500000, 0.960000, -5000.000000 },
	    ["Size"] = { 0.850000, 0.150000 },
	    ["Pivot"] = { 0.500000, 1.000000 },
	    ["Color"] = { 0.940000, 0.940000, 0.940000, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Arial16",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Bottom",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["SubtitlesWideScreen_Text"] = {
	    ["Pos"] = { 0.500000, 0.960000, -5000.000000 },
	    ["Size"] = { 1.183000, 0.150000 },
	    ["Pivot"] = { 0.500000, 1.000000 },
	    ["Color"] = { 0.940000, 0.940000, 0.940000, 1.000000 },
	    ["geOrder"] = 0,
	    ["Font"] = "Arial16",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Bottom",
	    ["DefaultShadow"] = 0,
	}
    
