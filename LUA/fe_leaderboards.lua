GuiScreen = {}

    GuiScreen["Pos"] = { 0.011458, -0.008333, 0.000000 }
    GuiScreen["geOrder"] = 0
    GuiScreen["background_Icon"] = {
	    ["Pos"] = { 0.488542, 0.500833, 10.000000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 3,
	    ["States"] = {
		    [1] = {
			    ["Texture"] = "FE\\bg\\multiplayer.tga",
			},
        }
	}
    GuiScreen["clipbox_Clipbox"] = {
	    ["Pos"] = { 0.063541, 0.265972, 0.000000 },
	    ["Size"] = { 0.387500, 0.259722 },
	    ["geOrder"] = 2,
	    ["filters_Listbox"] = {
		    ["Pos"] = { 0.000834, 0, -2.000000 },
		    ["Size"] = { 0.386458, 0.300000 },
		    ["geOrder"] = 0,
		    ["MouseHit"] = true,
		    ["listbox_Group"] = {
			    ["Pos"] = { 0.000000, 0.000000, -2.000000 },
			    ["Size"] = { 0.372000, 0.027778 },
			    ["geOrder"] = 0,
			    ["MouseHit"] = true,
			    ["filter_Text"] = {
				    ["Pos"] = { 0.006250, 0.013889, -2.000000 },
				    ["Size"] = { 0.375000, 0.025000 },
				    ["Pivot"] = { 0.000000, 0.500000 },
				    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				    ["geOrder"] = 0,
				    ["Font"] = "Arial15",
				    ["DefaultText"] = "filter template",
				    ["Multiline"] = false,
				    ["ShaderName"] = "GuiFontBilinear.mshd",
				    ["Align"] = "Left",
				    ["VerticalAlign"] = "Center",
				    ["MISColors"] = {
					    ["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					    ["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
					},
                    ["DefaultShadow"] = 0,
				}
			},
            ["AutoControl"] = true,
		    ["HeightPlus"] = 0.005000,
		},
        ["BorderWidth"] = { 0.001000, 0.010000 },
	}
    GuiScreen["data_Group"] = {
	    ["Pos"] = { 0.503125, 0.500000, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 0,
	    ["clipbox_2_Clipbox"] = {
		    ["Pos"] = { 0.244791, 0.013889, 0.000000 },
		    ["Size"] = { 0.416667, 0.497222 },
		    ["geOrder"] = 3,
		    ["data_Listbox"] = {
			    ["Pos"] = { 0.008126, 0.002861, -2.000000 },
			    ["Size"] = { 0.369792, 0.063889 },
			    ["geOrder"] = 0,
			    ["MouseHit"] = true,
			    ["listbox_Group"] = {
				    ["Pos"] = { 0.000000, 0.005556, -2.000000 },
				    ["Size"] = { 0.401042, 0.027778 },
				    ["geOrder"] = 0,
				    ["MouseHit"] = true,
				    ["name_Text"] = {
					    ["Pos"] = { 0.069792, 0.013889, -2.000000 },
					    ["Size"] = { 0.239583, 0.025000 },
					    ["Pivot"] = { 0.000000, 0.500000 },
					    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					    ["geOrder"] = 0,
					    ["Font"] = "Arial15",
					    ["DefaultText"] = "WWWWWWWWWWWWWWW",
					    ["Multiline"] = false,
					    ["ShaderName"] = "GuiFontBilinear.mshd",
					    ["Align"] = "Left",
					    ["VerticalAlign"] = "Center",
					    ["MISColors"] = {
						    ["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
						},
                        ["DefaultShadow"] = 0,
					},
                    ["rank_Text"] = {
					    ["Pos"] = { -0.002083, 0.013889, -2.000000 },
					    ["Size"] = { 0.062500, 0.025000 },
					    ["Pivot"] = { 0.000000, 0.500000 },
					    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					    ["geOrder"] = 0,
					    ["Font"] = "Arial15",
					    ["DefaultText"] = "9999999",
					    ["Multiline"] = false,
					    ["ShaderName"] = "GuiFontBilinear.mshd",
					    ["Align"] = "Left",
					    ["VerticalAlign"] = "Center",
					    ["MISColors"] = {
						    ["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
						},
                        ["DefaultShadow"] = 0,
					},
                    ["value_Text"] = {
					    ["Pos"] = { 0.310417, 0.013889, -2.000000 },
					    ["Size"] = { 0.093750, 0.025000 },
					    ["Pivot"] = { 0.000000, 0.500000 },
					    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					    ["geOrder"] = 0,
					    ["Font"] = "Arial15",
					    ["DefaultText"] = "99999999999",
					    ["Multiline"] = false,
					    ["ShaderName"] = "GuiFontBilinear.mshd",
					    ["Align"] = "Right",
					    ["VerticalAlign"] = "Center",
					    ["MISColors"] = {
						    ["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						    ["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
						},
                        ["DefaultShadow"] = 0,
					}
				},
                ["AutoControl"] = true,
			    ["HeightPlus"] = 0.005000,
			},
            ["BorderWidth"] = { 0.001000, 0.010000 },
		},
        ["data_misc_Group"] = {
		    ["Pos"] = { 0.237500, 0.206250, 0.000000 },
		    ["Size"] = { 0.493750, 0.500000 },
		    ["Pivot"] = { 0.504523, 0.500000 },
		    ["geOrder"] = 5,
		    ["data_FrameBox"] = {
			    ["Pos"] = { 0.250150, 0.050000, 0.000000 },
			    ["Size"] = { 0.447917, 0.547222 },
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/framebox/framebox_03.tga",
					}
				}
			},
            ["name_Text"] = {
			    ["Pos"] = { 0.334525, 0.017361, 0.000000 },
			    ["Size"] = { 0.239583, 0.034722 },
			    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			    ["geOrder"] = 2,
			    ["Font"] = "Viper19",
			    ["DefaultText"] = "FE.leaderboards_name",
			    ["Multiline"] = false,
			    ["Align"] = "Left",
			    ["VerticalAlign"] = "Top",
			    ["DefaultShadow"] = 0,
			},
            ["rank_Text"] = {
			    ["Pos"] = { 0.262650, 0.017361, 0.000000 },
			    ["Size"] = { 0.062500, 0.034722 },
			    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			    ["geOrder"] = 1,
			    ["Font"] = "Viper19",
			    ["DefaultText"] = "FE.leaderboards_rank",
			    ["Multiline"] = false,
			    ["Align"] = "Left",
			    ["VerticalAlign"] = "Top",
			    ["DefaultShadow"] = 0,
			},
            ["value_Text"] = {
			    ["Pos"] = { 0.575150, 0.015972, 0.000000 },
			    ["Size"] = { 0.093750, 0.041667 },
			    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			    ["geOrder"] = 3,
			    ["Font"] = "Viper19",
			    ["DefaultText"] = "FE.leaderboards_value",
			    ["Multiline"] = false,
			    ["Align"] = "Right",
			    ["VerticalAlign"] = "Top",
			    ["DefaultShadow"] = 0,
			},
        },
        ["filter_header_Text"] = {
		    ["Pos"] = { 0.242709, 0.519444, -6.000000 },
		    ["Size"] = { 0.197917, 0.025000 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 2,
		    ["MouseHit"] = true,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "FE.leaderboards_filter",
		    ["Multiline"] = false,
		    ["ShaderName"] = "GuiFontBilinear.mshd",
		    ["Align"] = "Center",
		    ["VerticalAlign"] = "Center",
		    ["MISColors"] = {
			    ["Normal"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
			    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Disabled"] = { 0.470000, 0.470000, 0.470000, 1.000000 },
			},
            ["DefaultShadow"] = 0,
		},
        ["filter_Text"] = {
		    ["Pos"] = { 0.443750, 0.519444, -6.000000 },
		    ["Size"] = { 0.239583, 0.025000 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 0,
		    ["MouseHit"] = true,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = " ",
		    ["Multiline"] = false,
		    ["ShaderName"] = "GuiFontBilinear.mshd",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Center",
		    ["MISColors"] = {
			    ["Normal"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
			    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Disabled"] = { 0.470000, 0.470000, 0.470000, 1.000000 },
			},
            ["DefaultShadow"] = 0,
		},
        ["slider2_Group"] = {
		    ["Pos"] = { 0.634374, 0.202778, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["back_Icon"] = {
			    ["Pos"] = { 0.282292, 0.080556, -1.000000 },
			    ["Size"] = { 0.015625, 0.461111 },
			    ["geOrder"] = 4,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common\\slider\\slider_bg.tga",
					}
				}
			},
            ["scroll_down2_Icon"] = {
			    ["Pos"] = { 0.290105, 0.549307, -19.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
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
					}
				}
			},
            ["scroll_up2_Icon"] = {
			    ["Pos"] = { 0.290105, 0.070833, -19.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 2,
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
					}
				}
			},
            ["slider2_FrameBox"] = {
			    ["Pos"] = { 0.282292, 0.077778, -2.000000 },
			    ["Size"] = { 0.015625, 0.041667 },
			    ["geOrder"] = 3,
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
					}
				}
			},
        }
	}
    GuiScreen["filters_Group"] = {
	    ["Pos"] = { 0.056250, 0.456250, 0.000000 },
	    ["Size"] = { 0.493750, 0.500000 },
	    ["Pivot"] = { 0.504523, 0.500000 },
	    ["geOrder"] = 7,
	    ["filters_FrameBox"] = {
		    ["Pos"] = { 0.250150, 0.050000, 0.000000 },
		    ["Size"] = { 0.416667, 0.277778 },
		    ["geOrder"] = 2,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["filters_header_Text"] = {
		    ["Pos"] = { 0.510524, 0.267361, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 1,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "FE.leaderboards_list",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["info_Group"] = {
	    ["Pos"] = { -0.090626, 0.840972, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 6,
	    ["info_FrameBox"] = {
		    ["Pos"] = { 0.398959, 0.004167, 0.000000 },
		    ["Size"] = { 0.416667, 0.208333 },
		    ["geOrder"] = 0,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01.tga",
				}
			},
        },
        ["info_header_Text"] = {
		    ["Pos"] = { 0.661417, 0.221528, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 3,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "FE.leaderboards_info",
		    ["Multiline"] = false,
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["info_Text"] = {
		    ["Pos"] = { 0.406251, 0.013194, -22.000000 },
		    ["Size"] = { 0.401042, 0.187500 },
		    ["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
		    ["geOrder"] = 2,
		    ["Font"] = "Arial15",
		    ["DefaultText"] = "filter info",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["MISColors"] = {
			    ["Normal"] = { 0.898039, 0.898039, 0.898039, 1.000000 },
			    ["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
			    ["Disabled"] = { 0.470000, 0.470000, 0.470000, 1.000000 },
			},
            ["DefaultShadow"] = 0,
		}
	}
    GuiScreen["slider_Group"] = {
	    ["Pos"] = { 0.421875, 0.452778, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 4,
	    ["back_Icon"] = {
		    ["Pos"] = { 0.282292, 0.080556, -1.000000 },
		    ["Size"] = { 0.015625, 0.226389 },
		    ["geOrder"] = 4,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common\\slider\\slider_bg.tga",
				}
			},
        },
        ["scroll_down_Icon"] = {
		    ["Pos"] = { 0.290105, 0.315973, -19.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
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
				}
			},
        },
        ["scroll_up_Icon"] = {
		    ["Pos"] = { 0.290105, 0.070833, -19.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
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
				}
			},
        },
        ["slider_FrameBox"] = {
		    ["Pos"] = { 0.282292, 0.077778, -2.000000 },
		    ["Size"] = { 0.015625, 0.041667 },
		    ["geOrder"] = 3,
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
				}
			},
        }
	}
    
