GuiScreen = {}

    GuiScreen["Pos"] = { -0.041667, 0.001389, 0.000000 }
    GuiScreen["geOrder"] = 0
    GuiScreen["background_Icon"] = {
	    ["Pos"] = { -0.125000, 0.156944, -1.000000 },
	    ["Size"] = { 1.333333, 0.683333 },
	    ["geOrder"] = 0,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/bg/historical.tga",
			},
            [2] = {
			    ["Texture"] = "fe/bg/worldmap_historical_alpha.tga",
			},
        }
	}
    GuiScreen["bg_01_Icon"] = {
	    ["Pos"] = { 0.935417, 0.878472, 6.000000 },
	    ["Size"] = { 3.968750, 3.213889 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 16,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/bg/worldmap.tga",
			},
        }
	}
    GuiScreen["centerMarker_Group"] = {
	    ["Pos"] = { 0.540000, 0.500000, 4.000000 },
	    ["Size"] = { 0.010000, 0.010000 },
	    ["Visible"] = false,
	    ["geOrder"] = 13,
	}
    GuiScreen["historical_Group"] = {
	    ["geOrder"] = 3,
	    ["bigtextbg_FrameBox"] = {
		    ["Pos"] = { 0.101041, 0.202778, -10.000000 },
		    ["Size"] = { 0.293750, 0.586111 },
		    ["WideScreenAlign"] = "Left",
		    ["geOrder"] = 3,
		    ["slider_Group"] = {
			    ["Pos"] = { -0.084374, -0.143056, 0.000000 },
			    ["Size"] = { 0.500000, 0.500000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["arrow_botton_scroll_Icon"] = {
				    ["Pos"] = { 0.616147, 0.964584, -8.000000 },
				    ["Size"] = { 0.015625, 0.020833 },
				    ["Pivot"] = { 0.500000, 0.500000 },
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
						}
					}
				},
                ["arrow_top_scroll_Icon"] = {
				    ["Pos"] = { 0.616146, 0.409027, -8.000000 },
				    ["Size"] = { 0.015625, 0.020833 },
				    ["Pivot"] = { 0.500000, 0.500000 },
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
						}
					}
				},
                ["textx_scroll_bg_Icon"] = {
				    ["Pos"] = { 0.616666, 0.418056, -7.000000 },
				    ["Size"] = { 0.015625, 0.537500 },
				    ["Pivot"] = { 0.533333, 0.000000 },
				    ["geOrder"] = 0,
				    ["States"] = {
					    [1] = {
						    ["Texture"] = "common/slider/slider_bg.tga",
						}
					}
				},
                ["textx_scroll_Framebox"] = {
				    ["Pos"] = { 0.616145, 0.418056, -15.000000 },
				    ["Size"] = { 0.014583, 0.037500 },
				    ["Pivot"] = { 0.500000, 0.000000 },
				    ["geOrder"] = 2,
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
					}
				}
			},
            ["test_Clipbox"] = {
			    ["Pos"] = { 0.003126, 0.005555, -7.000000 },
			    ["Size"] = { 0.266667, 0.575001 },
			    ["geOrder"] = 0,
			    ["textbox_Group"] = {
				    ["Pos"] = { 0.000000, 0.001389, 0.000000 },
				    ["Size"] = { 0.437500, 0.138889 },
				    ["geOrder"] = 0,
				    ["content_main_Text"] = {
					    ["Pos"] = { 0.004972, 0.004544, -15.000000 },
					    ["Size"] = { 0.260417, 0.520833 },
					    ["Color"] = { 0.976471, 0.862745, 0.600000, 1.000000 },
					    ["geOrder"] = 14,
					    ["Font"] = "Arial16",
					    ["DefaultText"] = "dsé",
					    ["Align"] = "Justified",
					    ["VerticalAlign"] = "Top",
					    ["DefaultShadow"] = 0,
					}
				},
                ["BorderWidth"] = { 0.001000, 0.010000 },
			},
            ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["New_FrameBox"] = {
		    ["Pos"] = { 0.728126, 0.413889, -20.000000 },
		    ["Size"] = { 0.375000, 0.375000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Visible"] = false,
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_02.tga",
				}
			},
        },
        ["video_Movie"] = {
		    ["Pos"] = { 0.713542, 0.212500, 0.000000 },
		    ["Size"] = { 0.637500, 0.566667 },
		    ["Pivot"] = { 0.500000, 0.000000 },
		    ["geOrder"] = 1,
		}
	}
    GuiScreen["mission_mapflag_template_Icon"] = {
	    ["Size"] = { 0.046875, 0.048611 },
	    ["Pivot"] = { 0.000000, 1.000000 },
	    ["Visible"] = false,
	    ["geOrder"] = 11,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/worldmap/flag_IJN.tga",
			},
            [2] = {
			    ["Texture"] = "fe/worldmap/flag_USA.tga",
			},
        }
	}
    GuiScreen["mission_mappoint_template_Icon"] = {
	    ["Size"] = { 0.034375, 0.043055 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 14,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/worldmap/mission_off.tga",
			},
            [2] = {
			    ["Texture"] = "fe/worldmap/mission_on.tga",
			},
            [3] = {
			    ["Texture"] = "fe/worldmap/mission_star_off.tga",
			},
            [4] = {
			    ["Texture"] = "fe/worldmap/mission_star_on.tga",
			},
        }
	}
    GuiScreen["mission_pic_Group"] = {
	    ["Pos"] = { 0.551250, 0.738889, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["WideScreenAlign"] = "Left",
	    ["Visible"] = false,
	    ["geOrder"] = 15,
	    ["arrow_botton_Icon"] = {
		    ["Pos"] = { -0.177082, 0.125000, -5.000000 },
		    ["Size"] = { 0.018750, 0.025000 },
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
        ["arrow_botton_scroll_Icon"] = {
		    ["Pos"] = { 0.257293, 0.309723, -5.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 7,
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
        ["arrow_top_Icon"] = {
		    ["Pos"] = { -0.177082, 0.095833, -5.000000 },
		    ["Size"] = { 0.018750, 0.025000 },
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
        ["arrow_top_scroll_Icon"] = {
		    ["Pos"] = { 0.257293, 0.157638, -5.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 6,
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
        ["checkpoint_FrameBox"] = {
		    ["Pos"] = { 0.036458, -0.250696, -20.000000 },
		    ["Size"] = { 0.240625, 0.062500 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 1.000000, 1.000000, 1.000000, 0.600000 },
		    ["geOrder"] = 1,
		    ["FrameSizesX"] = { 0.083333, 0.083333 },
		    ["FrameSizesY"] = { 0.000000, 0.000000 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "fe/worldmap/checkpoint.tga",
				}
			},
        },
        ["checkpoint_Text"] = {
		    ["Pos"] = { 0.035417, -0.248613, -25.000000 },
		    ["Size"] = { 0.385417, 0.027778 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 0.000000, 0.000000, 0.000000, 1.000000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "FE.main_checkpoint",
		    ["Align"] = "Center",
		    ["VerticalAlign"] = "Center",
		},
        ["medal1_Icon"] = {
		    ["Pos"] = { 0.230625, 0.024722, -11.000000 },
		    ["Size"] = { 0.072917, 0.097222 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 10,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "fe/worldmap/medal_bronz.tga",
				},
                [2] = {
				    ["Texture"] = "fe/worldmap/medal_ezust.tga",
				},
                [3] = {
				    ["Texture"] = "fe/worldmap/medal_arany.tga",
				}
			},
        },
        ["mission_name_backg_FrameBox"] = {
		    ["Pos"] = { -0.157292, 0.088194, -3.000000 },
		    ["Size"] = { 0.104167, 0.041667 },
		    ["geOrder"] = 15,
		    ["FrameSizesY"] = { 0.010000, 0.010000 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_text_select.tga",
				}
			},
        },
        ["mission_name_Text"] = {
		    ["Pos"] = { -0.147708, 0.090278, -11.000000 },
		    ["Size"] = { 0.416667, 0.111111 },
		    ["Color"] = { 0.796078, 0.635294, 0.454902, 1.000000 },
		    ["geOrder"] = 14,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "DEFEND THE BASE AT GUADALCANAL",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Bottom",
		    ["DefaultShadow"] = 0,
		},
        ["missionpicture_FrameBox"] = {
		    ["Pos"] = { -0.199999, -0.284722, -25.000000 },
		    ["Size"] = { 0.468750, 0.358333 },
		    ["geOrder"] = 13,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_02.tga",
				}
			},
        },
        ["missionpicture_Icon"] = {
		    ["Pos"] = { 0.034375, -0.105555, -10.000000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 12,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "fe\\missions\\IJN01.tga",
				}
			},
        },
        ["test_Clipbox"] = {
		    ["Pos"] = { -0.195000, 0.148611, -14.000000 },
		    ["Size"] = { 0.441667, 0.166667 },
		    ["geOrder"] = 16,
		    ["textbox_Group"] = {
			    ["Pos"] = { 0.003125, 0.006945, 0.000000 },
			    ["Size"] = { 0.333333, 0.138889 },
			    ["geOrder"] = 0,
			    ["content_main_Text"] = {
				    ["Pos"] = { -0.001042, 0.031388, -15.000000 },
				    ["Size"] = { 0.432292, 0.125000 },
				    ["Color"] = { 0.976471, 0.862745, 0.600000, 1.000000 },
				    ["geOrder"] = 14,
				    ["Font"] = "Arial16",
				    ["DefaultText"] = "The Grumman F4F Wildcat was an American carrier-based fighter that began service with both the United States Navy and the Fleet Air Arm in 1940. Although first used in combat by the British in Europe, the Wildcat would become the primary carrier fighter for the first year and a half of the United States Navy's involvement in World War II in the Pacific Theater. The FM Wildcat, an improved version built by General Motors,",
				    ["Align"] = "Justified",
				    ["VerticalAlign"] = "Top",
				    ["DefaultShadow"] = 0,
				},
                ["mission_date_Text"] = {
				    ["Pos"] = { 0.005208, -0.015000, -15.000000 },
				    ["Size"] = { 0.208333, 0.069444 },
				    ["Color"] = { 0.976471, 0.862745, 0.600000, 1.000000 },
				    ["geOrder"] = 13,
				    ["Font"] = "Arial15",
				    ["DefaultText"] = "DECEMBER 7 - 1941",
				    ["Align"] = "Left",
				    ["VerticalAlign"] = "Center",
				    ["DefaultShadow"] = 0,
				}
			},
            ["BorderWidth"] = { 0.001000, 0.010000 },
		},
        ["textbackground_FrameBox"] = {
		    ["Pos"] = { -0.200208, 0.143055, -2.000000 },
		    ["Size"] = { 0.468750, 0.180556 },
		    ["geOrder"] = 3,
		    ["MouseHit"] = true,
		    ["FrameSizesX"] = { 0.047917, 0.047917 },
		    ["FrameSizesY"] = { 0.062500, 0.062500 },
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["textx_scroll_bg_Icon"] = {
		    ["Pos"] = { 0.258125, 0.166667, -4.000000 },
		    ["Size"] = { 0.015625, 0.134722 },
		    ["Pivot"] = { 0.533333, 0.000000 },
		    ["geOrder"] = 8,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/slider/slider_bg.tga",
				}
			},
        },
        ["textx_scroll_FrameBox"] = {
		    ["Pos"] = { 0.257292, 0.166667, -12.000000 },
		    ["Size"] = { 0.014583, 0.031944 },
		    ["Pivot"] = { 0.500011, 0.000000 },
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
    GuiScreen["missions_JP_DLC_Group"] = {
	    ["Pos"] = { 0.531250, 0.363889, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 6,
	}
    GuiScreen["missions_JP_Group"] = {
	    ["Pos"] = { 0.531250, 0.363889, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 12,
	}
    GuiScreen["missions_US_DLC_Group"] = {
	    ["Pos"] = { 0.662500, 0.304167, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 5,
	}
    GuiScreen["missions_US_Group"] = {
	    ["Pos"] = { 0.635417, 0.331945, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 9,
	}
    GuiScreen["selector_Icon"] = {
	    ["Pos"] = { 0.000000, 0.000000, -10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["Rotate"] = 158.993301,
	    ["geOrder"] = 8,
	    ["AutoRotate"] = 1.000000,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "fe/worldmap/selection.tga",
			},
        }
	}
    GuiScreen["SubtitlesNormal_Text"] = {
	    ["Pos"] = { 0.500000, 0.960000, -5000.000000 },
	    ["Size"] = { 0.850000, 0.150000 },
	    ["Pivot"] = { 0.500000, 1.000000 },
	    ["Color"] = { 0.940000, 0.940000, 0.940000, 1.000000 },
	    ["geOrder"] = 2,
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
	    ["geOrder"] = 1,
	    ["Font"] = "Arial16",
	    ["Align"] = "Center",
	    ["VerticalAlign"] = "Bottom",
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["training_Group"] = {
	    ["Pos"] = { 0.531250, 0.405555, 0.000000 },
	    ["Size"] = { 0.558333, 0.500000 },
	    ["Pivot"] = { 0.444917, 0.500000 },
	    ["Visible"] = false,
	    ["geOrder"] = 10,
	}
    
