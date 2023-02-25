GuiScreen = {}

    GuiScreen["geOrder"] = 2
    GuiScreen["info_Group"] = {
	    ["Pos"] = { 0.415624, 0.498611, 0.000000 },
	    ["Size"] = { 0.500000, 0.500000 },
	    ["Pivot"] = { 0.500000, 0.500000 },
	    ["geOrder"] = 1,
	    ["info_Clipbox"] = {
		    ["Pos"] = { 0.333334, 0.009722, -14.000000 },
		    ["Size"] = { 0.262500, 0.479167 },
		    ["geOrder"] = 0,
		    ["info_text_Group"] = {
			    ["Pos"] = { 0.001042, 0.241667, 14.000000 },
			    ["Size"] = { 0.500000, 0.500000 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["info_Text"] = {
				    ["Pos"] = { 0.250000, 0.011111, -20.000000 },
				    ["Size"] = { 0.260417, 0.475000 },
				    ["geOrder"] = 0,
				    ["Font"] = "Arial16",
				    ["DefaultText"] = "blvlbdbvsdlsd",
				    ["Align"] = "Justified",
				    ["VerticalAlign"] = "Top",
				    ["DefaultShadow"] = 0,
				},
                ["silverline_FrameBox"] = {
				    ["Pos"] = { 0.381250, 0.052778, 3.000000 },
				    ["Size"] = { 0.171875, 0.005556 },
				    ["Pivot"] = { 0.500000, 0.500000 },
				    ["geOrder"] = 1,
				    ["FrameSizesX"] = { 0.005208, 0.005208 },
				    ["FrameSizesY"] = { 0.005556, 0.005556 },
				    ["States"] = {
					    [1] = {
						    ["Texture"] = "common/framebox/framebox_01_ingame.tga",
						}
					}
				},
                ["title_Text"] = {
				    ["Pos"] = { 0.248958, 0.015278, -20.000000 },
				    ["Size"] = { 0.260417, 0.041667 },
				    ["geOrder"] = 2,
				    ["Font"] = "Arial16",
				    ["DefaultText"] = "BDLKVDLFDFDKLFDFDLFK",
				    ["Align"] = "Center",
				    ["VerticalAlign"] = "Top",
				    ["DefaultShadow"] = 0,
				}
			},
            ["BorderWidth"] = { 0.000800, 0.000800 },
		},
        ["info_FrameBox"] = {
		    ["Pos"] = { 0.471875, 0.251389, 0.000000 },
		    ["Size"] = { 0.291667, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 5,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01_ingame.tga",
				}
			},
        },
        ["ScrollDown_Icon"] = {
		    ["Pos"] = { 0.605731, 0.485418, -19.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_down_ingame.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_down_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_down_on.tga",
				}
			},
        },
        ["ScrollUp_Icon"] = {
		    ["Pos"] = { 0.605731, 0.017806, -19.000000 },
		    ["Size"] = { 0.015625, 0.020833 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 3,
		    ["MouseHit"] = true,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/arrows/arrow_up_ingame.tga",
				},
                [2] = {
				    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
				},
                [3] = {
				    ["Texture"] = "common/arrows/arrow_up_on.tga",
				}
			},
        },
        ["slider_Group"] = {
		    ["Pos"] = { 0.559376, 0.222222, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 2,
		    ["back_Icon"] = {
			    ["Pos"] = { 0.288542, 0.058334, -1.000000 },
			    ["Size"] = { 0.015625, 0.447222 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/slider/slider_bg_ingame.tga",
					}
				}
			},
            ["slider_FrameBox"] = {
			    ["Pos"] = { 0.288542, 0.055556, -2.000000 },
			    ["Size"] = { 0.015625, 0.041667 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["FrameSizesX"] = { 0.006250, 0.006250 },
			    ["FrameSizesY"] = { 0.016660, 0.016660 },
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/slider/slider_ingame.tga",
					},
                    [2] = {
					    ["Texture"] = "common/slider/slider_mouse.tga",
					},
                    [3] = {
					    ["Texture"] = "common/slider/slider_on.tga",
					}
				}
			},
        }
	}
    GuiScreen["title_Group"] = {
	    ["Pos"] = { 0.291667, 0.458333, 0.000000 },
	    ["Size"] = { 0.493750, 0.500000 },
	    ["Pivot"] = { 0.504523, 0.500000 },
	    ["geOrder"] = 2,
	    ["child_Group"] = {
		    ["Pos"] = { 0.214733, 0.094445, 0.000000 },
		    ["Size"] = { 0.169792, 0.030556 },
		    ["Pivot"] = { 0.000000, 0.499996 },
		    ["geOrder"] = 1,
		    ["felkialtojel_Text"] = {
			    ["Pos"] = { -0.007292, 0.014973, -27.000000 },
			    ["Size"] = { 0.192708, 0.025000 },
			    ["Pivot"] = { 0.000000, 0.500000 },
			    ["Color"] = { 0.988235, 0.725490, 0.113725, 1.000000 },
			    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
			    ["geOrder"] = 0,
			    ["MouseHit"] = false,
			    ["Font"] = "Arial18",
			    ["DefaultText"] = "!",
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
            ["hint_Text"] = {
			    ["Pos"] = { 0.002083, 0.014278, -27.000000 },
			    ["Size"] = { 0.192708, 0.025000 },
			    ["Pivot"] = { 0.000000, 0.500000 },
			    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["Font"] = "Arial16",
			    ["DefaultText"] = "Isliiiand Capture",
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
        },
        ["hint_2_Text"] = {
		    ["Pos"] = { 0.217858, 0.095528, -27.000000 },
		    ["Size"] = { 0.192708, 0.025000 },
		    ["Pivot"] = { 0.000000, 0.500000 },
		    ["Color"] = { 0.996078, 0.525490, 0.094118, 1.000000 },
		    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
		    ["Visible"] = false,
		    ["geOrder"] = 6,
		    ["MouseHit"] = false,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "!",
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
        ["hint_title_Text"] = {
		    ["Pos"] = { 0.217858, 0.067750, -27.000000 },
		    ["Size"] = { 0.192708, 0.025000 },
		    ["Pivot"] = { 0.000000, 0.500000 },
		    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
		    ["geOrder"] = 8,
		    ["MouseHit"] = true,
		    ["Font"] = "Arial16",
		    ["DefaultText"] = "Isliiiand Capture",
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
        ["HintTitle_Listbox"] = {
		    ["Pos"] = { 0.223483, 0.061751, -29.000000 },
		    ["Size"] = { 0.200000, 0.479167 },
		    ["geOrder"] = 5,
		    ["MouseHit"] = true,
		    ["ScrollDown_Icon"] = {
			    ["Pos"] = { 0.199063, 0.465334, 10.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/arrows/arrow_down_ingame.tga",
					},
                    [2] = {
					    ["Texture"] = "common/arrows/arrow_down_mouse.tga",
					},
                    [3] = {
					    ["Texture"] = "common/arrows/arrow_down_on.tga",
					}
				}
			},
            ["ScrollUp_Icon"] = {
			    ["Pos"] = { 0.199063, -0.003667, 10.000000 },
			    ["Size"] = { 0.015625, 0.020833 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 0,
			    ["MouseHit"] = true,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/arrows/arrow_up_ingame.tga",
					},
                    [2] = {
					    ["Texture"] = "common/arrows/arrow_up_mouse.tga",
					    ["Pivot"] = { 0.000000, 0.000000 },
					},
                    [3] = {
					    ["Texture"] = "common/arrows/arrow_up_on.tga",
					    ["Pivot"] = { 0.000000, 0.000000 },
					}
				}
			},
            ["AutoControl"] = true,
		},
        ["parent_Group"] = {
		    ["Pos"] = { 0.212650, 0.119445, 0.000000 },
		    ["Size"] = { 0.182292, 0.030556 },
		    ["Pivot"] = { 0.000000, 0.500000 },
		    ["geOrder"] = 2,
		    ["button_Icon"] = {
			    ["Pos"] = { 0.009375, 0.015278, -10.000000 },
			    ["Size"] = { 0.016667, 0.022222 },
			    ["Pivot"] = { 0.500000, 0.500000 },
			    ["geOrder"] = 2,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "gui\\elements\\pause_p.tga",
					},
                    [2] = {
					    ["Texture"] = "gui\\elements\\pause_m.tga",
					}
				}
			},
            ["felkialtojel_Text"] = {
			    ["Pos"] = { -0.007291, 0.014973, -27.000000 },
			    ["Size"] = { 0.192708, 0.025000 },
			    ["Pivot"] = { 0.000000, 0.500000 },
			    ["Color"] = { 0.988235, 0.725490, 0.113725, 1.000000 },
			    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
			    ["geOrder"] = 0,
			    ["MouseHit"] = false,
			    ["Font"] = "Arial18",
			    ["DefaultText"] = "!",
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
            ["hint_Text"] = {
			    ["Pos"] = { 0.021876, 0.014972, -27.000000 },
			    ["Size"] = { 0.192708, 0.025000 },
			    ["Pivot"] = { 0.000000, 0.500000 },
			    ["LowColor"] = { 1.000000, 1.000000, 1.000000, 1.000000 },
			    ["geOrder"] = 1,
			    ["MouseHit"] = true,
			    ["Font"] = "Arial16",
			    ["DefaultText"] = "Isliiiand Capture",
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
        },
        ["slider_Group"] = {
		    ["Pos"] = { 0.376191, 0.262500, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 4,
		    ["back_Icon"] = {
			    ["Pos"] = { 0.288542, 0.058334, -1.000000 },
			    ["Size"] = { 0.015625, 0.447222 },
			    ["geOrder"] = 0,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/slider/slider_bg_ingame.tga",
					}
				}
			},
            ["slider_FrameBox"] = {
			    ["Pos"] = { 0.288542, 0.055556, -2.000000 },
			    ["Size"] = { 0.015625, 0.041667 },
			    ["geOrder"] = 1,
			    ["FrameSizesX"] = { 0.006250, 0.006250 },
			    ["FrameSizesY"] = { 0.016660, 0.016660 },
			    ["MouseHit"] = true,
			    ["States"] = {
				    [1] = {
					    ["Texture"] = "common/slider/slider_ingame.tga",
					},
                    [2] = {
					    ["Texture"] = "common/slider/slider_mouse.tga",
					},
                    [3] = {
					    ["Texture"] = "common/slider/slider_on.tga",
					}
				}
			},
        },
        ["tips_Text"] = {
		    ["Pos"] = { 0.457441, 0.261111, 0.000000 },
		    ["Size"] = { 0.500000, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 0,
		    ["Font"] = "Viper19",
		    ["DefaultText"] = "ingame.pause_tips_list",
		    ["Align"] = "Left",
		    ["VerticalAlign"] = "Top",
		    ["DefaultShadow"] = 0,
		},
        ["title_FrameBox"] = {
		    ["Pos"] = { 0.320983, 0.291667, 0.000000 },
		    ["Size"] = { 0.229167, 0.500000 },
		    ["Pivot"] = { 0.500000, 0.500000 },
		    ["geOrder"] = 9,
		    ["States"] = {
			    [1] = {
				    ["Texture"] = "common/framebox/framebox_01_ingame.tga",
				}
			},
        }
	}
    
