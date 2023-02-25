GuiScreen = {
	["geOrder"] = 0,
	["awards_page_Group"] = {
		["Visible"] = false,
		["geOrder"] = 6,
		["awards_Clipbox"] = {
			["Pos"] = { 0.088542, 0.250000, 0.000000 },
			["Size"] = { 0.822917, 0.500000 },
			["geOrder"] = 0,
			["move_Group"] = {
				["Pos"] = { 0.010417, 0.013889, -5.000000 },
				["Size"] = { 0.500000, 0.500000 },
				["geOrder"] = 0,
				["template_Group"] = {
					["Size"] = { 0.781250, 0.145833 },
					["geOrder"] = 4,
					["award_detail_Text"] = {
						["Pos"] = { 0.214583, 0.041667, -2.000000 },
						["Size"] = { 0.556250, 0.097222 },
						["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
						["geOrder"] = 4,
						["Font"] = "Arial16",
						["DefaultText"] = "award_detail: W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W W",
						["ShaderName"] = "GuiFontBilinear.mshd",
						["Align"] = "Left",
						["VerticalAlign"] = "Top",
						["MISColors"] = {
							["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
						},
						["DefaultShadow"] = 0,
					},
					["award_Icon"] = {
						["Pos"] = { 0.005208, 0.006944, -2.000000 },
						["Size"] = { 0.200000, 0.133333 },
						["geOrder"] = 2,
						["award_icon_FrameBox"] = {
							["Pos"] = { 0.000000, 0.000000, -3.000000 },
							["Size"] = { 0.100000, 0.133333 },
							["geOrder"] = 0,
							["FrameSizesX"] = { 0.016667, 0.016667 },
							["FrameSizesY"] = { 0.022222, 0.022222 },
							["States"] = {
								[1] = {
									["Texture"] = "common\\framebox\\framebox_04.tga",
								},
							},
						},
						["States"] = {
							[1] = {
								["Texture"] = "common/whiteGui.tga",
							},
						},
					},
					["award_title_Text"] = {
						["Pos"] = { 0.214583, 0.006944, -2.000000 },
						["Size"] = { 0.556250, 0.027778 },
						["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
						["geOrder"] = 3,
						["Font"] = "Arial18",
						["DefaultText"] = "award_title",
						["ShaderName"] = "GuiFontBilinear.mshd",
						["Align"] = "Left",
						["VerticalAlign"] = "Top",
						["MISColors"] = {
							["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
							["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
						},
						["DefaultShadow"] = 0,
					},
				},
			},
			["BorderWidth"] = { 0.001000, 0.010000 },
		},
		["awards_FrameBox"] = {
			["Pos"] = { 0.088542, 0.250000, 0.000000 },
			["Size"] = { 0.822917, 0.500000 },
			["geOrder"] = 0,
			["FrameSizesX"] = { 0.016667, 0.016667 },
			["FrameSizesY"] = { 0.022222, 0.022222 },
			["States"] = {
				[1] = {
					["Texture"] = "common/framebox/framebox_01.tga",
				},
			},
		},
		["slider_Group"] = {
			["Pos"] = { 0.855207, 0.513194, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["back_Icon"] = {
				["Pos"] = { 0.288542, 0.012500, -15.000000 },
				["Size"] = { 0.015625, 0.450000 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common/slider/slider_bg.tga",
					},
				},
			},
			["scroll_down_Icon"] = {
				["Pos"] = { 0.295834, 0.471528, -19.000000 },
				["Size"] = { 0.015625, 0.020833 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 2,
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
				},
			},
			["scroll_up_Icon"] = {
				["Pos"] = { 0.295833, 0.002778, -19.000000 },
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
					},
				},
			},
			["slider_FrameBox"] = {
				["Pos"] = { 0.288542, 0.012500, -20.000000 },
				["Size"] = { 0.015625, 0.041667 },
				["geOrder"] = 3,
				["MouseHit"] = true,
				["FrameSizesX"] = { 0.006250, 0.006250 },
				["FrameSizesY"] = { 0.008333, 0.008333 },
				["States"] = {
					[1] = {
						["Texture"] = "common/slider/slider.tga",
					},
					[2] = {
						["Texture"] = "common/slider/slider_mouse.tga",
					},
					[3] = {
						["Texture"] = "common/slider/slider_on.tga",
					},
				},
			},
		},
	},
	["backgrnd_Icon"] = {
		["Pos"] = { 0.500000, 0.500000, 20.000000 },
		["Size"] = { 1.333333, 0.683333 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["States"] = {
			[1] = {
				["Texture"] = "fe\\bg\\options.tga",
			},
			[2] = {
				["Texture"] = "fe\\bg\\options.tga",
			},
		},
	},
	["detail_page_Group"] = {
		["Visible"] = false,
		["geOrder"] = 8,
		["clipbox_Clipbox"] = {
			["Pos"] = { 0.095833, 0.263889, 0.000000 },
			["Size"] = { 0.791667, 0.472222 },
			["geOrder"] = 0,
			["header_template_Group"] = {
				["Pos"] = { 0.002083, 0.002778, -2.000000 },
				["Size"] = { 0.500000, 0.500000 },
				["geOrder"] = 3,
				["damage_Text"] = {
					["Pos"] = { 0.448958, 0.041667, -28.000000 },
					["Size"] = { 0.135417, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 3,
					["Font"] = "Arial18",
					["Multiline"] = false,
					["DefaultText"] = "FE.scoring_hits_damage",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["done_by_Text"] = {
					["Pos"] = { 0.011458, 0.041667, -28.000000 },
					["Size"] = { 0.208333, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 1,
					["Font"] = "Arial18",
					["Multiline"] = false,
					["DefaultText"] = "FE.scoring_hits_doneby",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["done_to_Text"] = {
					["Pos"] = { 0.230208, 0.041667, -28.000000 },
					["Size"] = { 0.208333, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 2,
					["Font"] = "Arial18",
					["Multiline"] = false,
					["DefaultText"] = "FE.scoring_hits_doneto",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["header_Text"] = {
					["Pos"] = { 0.006250, 0.000000, -28.000000 },
					["Size"] = { 0.771875, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 0,
					["Font"] = "Arial18",
					["DefaultText"] = "==== Action Scores ====",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["kills_Text"] = {
					["Pos"] = { 0.594792, 0.041667, -28.000000 },
					["Size"] = { 0.072917, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 4,
					["Font"] = "Arial18",
					["Multiline"] = false,
					["DefaultText"] = "FE.scoring_hits_kills",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["row_line_FrameBox"] = {
					["Pos"] = { 0.006250, 0.080556, -15.000000 },
					["Size"] = { 0.781250, 0.002778 },
					["geOrder"] = 6,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["separator_line_FrameBox"] = {
					["Pos"] = { 0.006250, 0.037500, -15.000000 },
					["Size"] = { 0.781250, 0.004167 },
					["geOrder"] = 7,
					["FrameSizesX"] = { 0.002083, 0.002083 },
					["FrameSizesY"] = { 0.002778, 0.002778 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["total_Text"] = {
					["Pos"] = { 0.678125, 0.041667, -28.000000 },
					["Size"] = { 0.104167, 0.041667 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 5,
					["Font"] = "Arial18",
					["Multiline"] = false,
					["DefaultText"] = "FE.scoring_hits_total",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Center",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["vline1_FrameBox"] = {
					["Pos"] = { 0.225001, 0.037500, -13.000000 },
					["Size"] = { 0.002083, 0.486111 },
					["geOrder"] = 9,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["vline2_FrameBox"] = {
					["Pos"] = { 0.443751, 0.037500, -13.000000 },
					["Size"] = { 0.002083, 0.486111 },
					["geOrder"] = 10,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["vline3_FrameBox"] = {
					["Pos"] = { 0.589584, 0.037500, -13.000000 },
					["Size"] = { 0.002083, 0.486111 },
					["geOrder"] = 11,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["vline4_FrameBox"] = {
					["Pos"] = { 0.672917, 0.037500, -13.000000 },
					["Size"] = { 0.002083, 0.486111 },
					["geOrder"] = 12,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
			},
			["key_template_Group"] = {
				["Pos"] = { 0.002083, 0.083333, -2.000000 },
				["Size"] = { 0.500000, 0.500000 },
				["geOrder"] = 2,
				["done_by_value_Text"] = {
					["Pos"] = { 0.011458, 0.002778, -1.000000 },
					["Size"] = { 0.208333, 0.027778 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 5,
					["Font"] = "Arial15",
					["Multiline"] = false,
					["DefaultText"] = "Transporttirenduffe",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Left",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["row_line_FrameBox"] = {
					["Pos"] = { 0.006251, 0.033334, -15.000000 },
					["Size"] = { 0.781250, 0.002778 },
					["geOrder"] = 6,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
			},
			["move_Group"] = {
				["Pos"] = { 0.002084, 0.002778, -2.000000 },
				["Size"] = { 0.500000, 0.500000 },
				["geOrder"] = 1,
			},
			["value_template_Group"] = {
				["Pos"] = { 0.002083, 0.083333, -2.000000 },
				["Size"] = { 0.500000, 0.500000 },
				["geOrder"] = 0,
				["damage_value_Text"] = {
					["Pos"] = { 0.447916, 0.002778, -1.000000 },
					["Size"] = { 0.135417, 0.027778 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 1,
					["Font"] = "Arial15",
					["DefaultText"] = "99999999",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Right",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["done_to_value_Text"] = {
					["Pos"] = { 0.230208, 0.002778, -1.000000 },
					["Size"] = { 0.208333, 0.027778 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 0,
					["Font"] = "Arial15",
					["Multiline"] = false,
					["DefaultText"] = "Transporttirenduffe",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Left",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["kills_value_Text"] = {
					["Pos"] = { 0.594792, 0.002778, -1.000000 },
					["Size"] = { 0.072917, 0.027778 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 2,
					["Font"] = "Arial15",
					["DefaultText"] = "99999999",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Right",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
				["total_value_Text"] = {
					["Pos"] = { 0.678125, 0.002778, -1.000000 },
					["Size"] = { 0.104167, 0.027778 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 3,
					["Font"] = "Arial15",
					["DefaultText"] = "9999999999",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Right",
					["VerticalAlign"] = "Top",
					["DefaultShadow"] = 0,
				},
			},
			["BorderWidth"] = { 0.001000, 0.010000 },
		},
		["hits_FrameBox"] = {
			["Pos"] = { 0.500000, 0.500000, 0.000000 },
			["Size"] = { 0.822917, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 9,
			["FrameSizesX"] = { 0.034375, 0.034375 },
			["FrameSizesY"] = { 0.045833, 0.045833 },
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["slider_Group"] = {
			["Pos"] = { 0.853124, 0.525695, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["back_Icon"] = {
				["Pos"] = { 0.287501, -0.000694, -1.000000 },
				["Size"] = { 0.015625, 0.451389 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common/slider/slider_bg.tga",
					},
				},
			},
			["scroll_down_Icon"] = {
				["Pos"] = { 0.295834, 0.460417, -19.000000 },
				["Size"] = { 0.015625, 0.020833 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 2,
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
				},
			},
			["scroll_up_Icon"] = {
				["Pos"] = { 0.295834, -0.009027, -19.000000 },
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
					},
				},
			},
			["slider_FrameBox"] = {
				["Pos"] = { 0.287501, 0.000695, -50.000000 },
				["Size"] = { 0.015625, 0.041667 },
				["geOrder"] = 3,
				["MouseHit"] = true,
				["FrameSizesX"] = { 0.006250, 0.006250 },
				["FrameSizesY"] = { 0.022222, 0.022222 },
				["States"] = {
					[1] = {
						["Texture"] = "common/slider/slider.tga",
					},
					[2] = {
						["Texture"] = "common/slider/slider_mouse.tga",
					},
					[3] = {
						["Texture"] = "common/slider/slider_on.tga",
					},
				},
			},
		},
	},
	["multi_page1_Group"] = {
		["Pos"] = { 0.000000, 0.050000, 0.000000 },
		["Visible"] = false,
		["geOrder"] = 4,
		["END_Text"] = {
			["Pos"] = { 0.500000, 0.200000, -522.000000 },
			["Size"] = { 0.260417, 0.027778 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 1,
			["Font"] = "Arial18",
			["DefaultText"] = "YOU HAVE REACHED THE ROUND LIMIT",
			["Align"] = "Center",
			["VerticalAlign"] = "Center",
			["MISColors"] = {
				["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
			},
			["DefaultShadow"] = 0,
		},
		["info_2_FrameBox"] = {
			["Pos"] = { 0.493750, 0.500694, 0.000000 },
			["Size"] = { 0.593750, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["JAP_Text"] = {
			["Pos"] = { 0.486459+0.057291, 0.348611, -522.000000 },
			["Size"] = { 0.260417, 0.027778 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 1,
			["New_Icon"] = {
				["Pos"] = { 0.033333-0.057291, 0.019445, 502.000000 },
				["Size"] = { 0.043750, 0.041667 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common\\worldmap\\flag_IJN2.tga",
					},
				},
			},
			["Font"] = "Arial16",
			["DefaultText"] = "VICTORY POINT:  960",
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
		["players_Listbox"] = {
			["Pos"] = { 0.206250, 0.288890, -500.000000 },
			["Size"] = { 0.572917, 0.027778 },
			["geOrder"] = 6,
			["template_Group"] = {
				["Pos"] = { 0.062500, -0.000001, 0.000000 },
				["Size"] = { 0.322917, 0.027778 },
				["geOrder"] = 4,
				["clan_Text"] = {
					["Pos"] = { 0.071875, 0.019444, -22.000000 },
					["Size"] = { 0.260417, 0.027778 },
					["Pivot"] = { 0.000000, 0.499996 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 5,
					["Font"] = "Arial16",
					["DefaultText"] = " ",
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
				["flag_Icon"] = {
					["Pos"] = { -0.023958, 0.023610, -22.000000 },
					["Size"] = { 0.041667, 0.041667 },
					["Pivot"] = { 0.500000, 0.500000 },
					["Visible"] = false,
					["geOrder"] = 2,
					["States"] = {
						[1] = {
							["Texture"] = "common\\worldmap\\flag_USA2.tga",
						},
						[2] = {
							["Texture"] = "common\\worldmap\\flag_IJN2.tga",
						},
					},
				},
				["name_Text"] = {
					["Pos"] = { 0.147916, 0.019444, -22.000000 },
					["Size"] = { 0.260417, 0.027778 },
					["Pivot"] = { 0.000000, 0.499996 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 6,
					["Font"] = "Arial16",
					["DefaultText"] = "WWWWWWWWWWWWWWW",
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
				["primary_2_FrameBox"] = {
					["Pos"] = { -0.060417, 0.034723, 490.000000 },
					["Size"] = { 0.573958, 0.002778 },
					["geOrder"] = 0,
					["FrameSizesX"] = { 0.001042, 0.001042 },
					["FrameSizesY"] = { 0.001389, 0.001389 },
					["States"] = {
						[1] = {
							["Texture"] = "common\\framebox\\framebox_01.tga",
						},
					},
				},
				["rank_Icon"] = {
					["Pos"] = { 0.026042, 0.020832, -22.000000 },
					["Size"] = { 0.034375, 0.029167 },
					["Pivot"] = { 0.500000, 0.500000 },
					["geOrder"] = 1,
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
					},
				},
				["rank_Text"] = {
					["Pos"] = { -0.061458, 0.018056, -21.000000 },
					["Size"] = { 0.260417, 0.027778 },
					["Pivot"] = { 0.000000, 0.499996 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 4,
					["Font"] = "Arial18",
					["DefaultText"] = "1",
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
				["score_Text"] = {
					["Pos"] = { 0.409375, 0.019444, -22.000000 },
					["Size"] = { 0.083333, 0.027778 },
					["Pivot"] = { 0.000000, 0.499996 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 3,
					["Font"] = "Arial16",
					["DefaultText"] = "99999999",
					["Align"] = "Right",
					["VerticalAlign"] = "Center",
					["MISColors"] = {
						["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
						["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
					},
					["DefaultShadow"] = 0,
				},
			},
			["DontMoveTheItems"] = true,
		},
		["time_Text"] = {
			["Pos"] = { 0.555208, 0.719444, -522.000000 },
			["Size"] = { 0.156250, 0.027778 },
			["Pivot"] = { 0.000000, 0.499996 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 5,
			["Font"] = "Arial16",
			["DefaultText"] = "FE.scoring_time|.:",
			["Align"] = "Right",
			["VerticalAlign"] = "Center",
			["MISColors"] = {
				["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
				["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
			},
			["DefaultShadow"] = 0,
		},
		["time_value_Text"] = {
			["Pos"] = { 0.715625, 0.719444, -522.000000 },
			["Size"] = { 0.062500, 0.027778 },
			["Pivot"] = { 0.000000, 0.499996 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 4,
			["Font"] = "Arial16",
			["DefaultText"] = "9999",
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
		["USA_Text"] = {
			["Pos"] = { 0.486459+0.057291, 0.272222, -522.000000 },
			["Size"] = { 0.260417, 0.027778 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 0,
			["New_Icon"] = {
				["Pos"] = { 0.033333-0.057291, 0.019445, 502.000000 },
				["Size"] = { 0.043750, 0.041667 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common\\worldmap\\flag_USA2.tga",
					},
				},
			},
			["Font"] = "Arial16",
			["DefaultText"] = "VICTORY POINT:  960",
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
	},
	["next_page_Icon"] = {
		["Pos"] = { 0.929167, 0.499306, -14.000000 },
		["Size"] = { 0.026042, 0.034722 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Rotate"] = 4.712389,
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
			},
		},
	},
	["objectives_page_Group"] = {
		["geOrder"] = 11,
		["hidden_FrameBox"] = {
			["Pos"] = { 0.500000, 0.475000, 0.000000 },
			["Size"] = { 0.822917, 0.069444 },
			["Pivot"] = { 0.500000, 0.000000 },
			["geOrder"] = 5,
			["FrameSizesX"] = { 0.016667, 0.016667 },
			["FrameSizesY"] = { 0.020833, 0.020833 },
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["hidden_header_Text"] = {
			["Pos"] = { 0.095833, 0.437500, 0.000000 },
			["Size"] = { 0.395833, 0.041667 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 3,
			["Font"] = "Viper19",
			["DefaultText"] = "FE.scoring_obj_hidden",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["obj_template_Group"] = {
			["Pos"] = { 0.104167, 0.262499, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["geOrder"] = 6,
			["number_Text"] = {
				["Pos"] = { 0.010416, 0.000000, -10.000000 },
				["Size"] = { 0.020833, 0.055556 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 0,
				["Font"] = "Arial15",
				["DefaultText"] = "1",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
			["primary_line_FrameBox"] = {
				["Pos"] = { 0.011458, 0.029167, -15.000000 },
				["Size"] = { 0.781250, 0.002778 },
				["geOrder"] = 10,
				["FrameSizesX"] = { 0.001042, 0.001042 },
				["FrameSizesY"] = { 0.001389, 0.001389 },
				["States"] = {
					[1] = {
						["Texture"] = "common\\framebox\\framebox_01.tga",
					},
				},
			},
			["primary_point_value_Text"] = {
				["Pos"] = { 0.646874, 0.000000, -10.000000 },
				["Size"] = { 0.104167, 0.055556 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 1,
				["Font"] = "Arial15",
				["DefaultText"] = "5000",
				["Align"] = "Right",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
			["primary_Text"] = {
				["Pos"] = { 0.035416, 0.000000, -10.000000 },
				["Size"] = { 0.500000, 0.055556 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 0,
				["Font"] = "Arial15",
				["DefaultText"] = "bla blabla blabla blabla blabla bla blabla blabla ba blabla blabla bla blabla blabla blabla bla",
				["Multiline"] = false,
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
			["primary_value_Text"] = {
				["Pos"] = { 0.542707, 0.000000, -10.000000 },
				["Size"] = { 0.135417, 0.055556 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 1,
				["Font"] = "Arial15",
				["DefaultText"] = "COMPLETED",
				["Align"] = "Right",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
		},
		["primary_FrameBox"] = {
			["Pos"] = { 0.500000, 0.250000, 0.000000 },
			["Size"] = { 0.822917, 0.069444 },
			["Pivot"] = { 0.500000, 0.000000 },
			["geOrder"] = 9,
			["FrameSizesX"] = { 0.016667, 0.016667 },
			["FrameSizesY"] = { 0.020833, 0.020833 },
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["primary_header_Text"] = {
			["Pos"] = { 0.095833, 0.212500, 0.000000 },
			["Size"] = { 0.395833, 0.041667 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 8,
			["Font"] = "Viper19",
			["DefaultText"] = "FE.scoring_obj_primary",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["secondary_FrameBox"] = {
			["Pos"] = { 0.500000, 0.363889, 0.000000 },
			["Size"] = { 0.822917, 0.069444 },
			["Pivot"] = { 0.500000, 0.000000 },
			["geOrder"] = 0,
			["FrameSizesX"] = { 0.016667, 0.016667 },
			["FrameSizesY"] = { 0.020833, 0.020833 },
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["secondary_header_Text"] = {
			["Pos"] = { 0.095833, 0.326389, 0.000000 },
			["Size"] = { 0.395833, 0.041667 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 1,
			["Font"] = "Viper19",
			["DefaultText"] = "FE.scoring_obj_secondary",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
	},
	["pop_Group"] = {
		["Pos"] = { 0.500000, 0.500000, -600.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["A_Text"] = {
			["Pos"] = { 0.035417, 0.277000, -40.000000 },
			["Size"] = { 0.260417, 0.145833 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 5,
			["Font"] = "Arial18",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["B_Text"] = {
			["Pos"] = { 0.055000, 0.263889, -40.000000 },
			["Size"] = { 350.0/960.0, 0.145833 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 5,
			["Font"] = "Arial18",
			["DefaultText"] = "globals.continue",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["back_Icon"] = {
			["Pos"] = { 0.250000, 0.250000, 50.000000 },
			["Size"] = { 1.333333, 0.683333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 1.000000, 1.000000, 1.000000, 0.900000 },
			["geOrder"] = 8,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\bg\\options.tga",
				},
				[2] = {
					["Texture"] = "fe\\bg\\options.tga",
				},
			},
		},
		["info_Text"] = {
			["Pos"] = { 0.213542, 0.063889, -40.000000 },
			["Size"] = { 0.260417, 0.145833 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 0,
			["Font"] = "Arial18",
			["DefaultText"] = "info text",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["New_FrameBox"] = {
			["Pos"] = { 0.250000, 0.162500, -39.000000 },
			["Size"] = { 0.500000, 0.319444 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 4,
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["rank_Icon"] = {
			["Pos"] = { 0.108333, 0.138889, -40.000000 },
			["Size"] = { 0.177083, 0.159722 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 9,
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
			},
		},
		["rank_Text"] = {
			["Pos"] = { 0.035417, 0.216667, -40.000000 },
			["Size"] = { 0.260417, 0.145833 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 3,
			["Font"] = "Arial18",
			["DefaultText"] = "RANK TEXT",
			["Align"] = "Left",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["title_Text"] = {
			["Pos"] = { 0.250000, 0.263889, -50.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
			["geOrder"] = 2,
			["Font"] = "Viper19",
			["DefaultText"] = "FE.congratulation",
			["Align"] = "Center",
			["VerticalAlign"] = "Top",
			["DefaultShadow"] = 0,
		},
		["unit_Icon"] = {
			["Pos"] = { 0.110417, 0.138889, -80.000000 },
			["Size"] = { 0.177083, 0.133333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 1,
			["States"] = {
				[1] = {
					["Texture"] = "common/whiteGui.tga",
				},
			},
		},
	},
	["prev_page_Icon"] = {
		["Pos"] = { 0.068750, 0.500000, -14.000000 },
		["Size"] = { 0.026042, 0.034722 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Rotate"] = 1.570796,
		["geOrder"] = 1,
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
		},
	},
	["single_page1_Group"] = {
		["Visible"] = false,
		["geOrder"] = 3,
		["debriefing_Clipbox"] = {
			["Pos"] = { 0.098958, 0.263194, 0.000000 },
			["Size"] = { 0.464583, 0.472222 },
			["geOrder"] = 5,
			["move_Group"] = {
				["geOrder"] = 0,
				["congrat1_Text"] = {
					["Pos"] = { 0.006251, 0.004861, -1.000000 },
					["Size"] = { 0.458333, 0.430556 },
					["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
					["geOrder"] = 0,
					["Font"] = "Arial18",
					["DefaultText"] = "Congratulation !",
					["ShaderName"] = "GuiFontBilinear.mshd",
					["Align"] = "Justified",
					["VerticalAlign"] = "Top",
				},
			},
			["BorderWidth"] = { 0.001000, 0.010000 },
		},
		["debriefing_FrameBox"] = {
			["Pos"] = { 0.088542, 0.250000, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["geOrder"] = 4,
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["info_FrameBox"] = {
			["Pos"] = { 0.630208, 0.250000, 0.000000 },
			["Size"] = { 0.281250, 0.500000 },
			["geOrder"] = 6,
			["States"] = {
				[1] = {
					["Texture"] = "common\\framebox\\framebox_01.tga",
				},
			},
		},
		["info_Group"] = {
			["Pos"] = { 0.456250, 0.583333, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 3,
			["rank_Text"] = {
				["Pos"] = { 0.427083, 0.060417, -2.000000 },
				["Size"] = { 0.145833, 0.041667 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["Visible"] = false,
				["geOrder"] = 0,
				["Font"] = "Arial18",
				["DefaultText"] = "FE.scoring_rank|.:",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
			},
			["score_Text"] = {
				["Pos"] = { 0.427083, -0.056250, -2.000000 },
				["Size"] = { 0.145833, 0.041667 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 3,
				["Font"] = "Arial18",
				["DefaultText"] = "FE.scoring_score|.:",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
			},
			["score_value_Text"] = {
				["Pos"] = { 0.575000, -0.056250, -2.000000 },
				["Size"] = { 0.114583, 0.041667 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 4,
				["Font"] = "Arial18",
				["DefaultText"] = "999999999999",
				["Align"] = "Right",
				["VerticalAlign"] = "Top",
			},
			["time_Text"] = {
				["Pos"] = { 0.427083, -0.002083, -2.000000 },
				["Size"] = { 0.145833, 0.069444 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 5,
				["Font"] = "Arial18",
				["DefaultText"] = "FE.scoring_time|.:",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
			},
			["time_value_Text"] = {
				["Pos"] = { 0.575000, -0.002083, -2.000000 },
				["Size"] = { 0.114583, 0.041667 },
				["Color"] = { 0.976471, 0.858824, 0.600000, 1.000000 },
				["geOrder"] = 6,
				["Font"] = "Arial18",
				["DefaultText"] = "1 : 20 min",
				["Align"] = "Right",
				["VerticalAlign"] = "Top",
			},
		},
		["medal_Icon"] = {
			["Pos"] = { 0.765624, 0.542361, -6.000000 },
			["Size"] = { 0.156250, 0.215278 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 2,
			["States"] = {
				[1] = {
					["Texture"] = "fe/worldmap/medal_bronz.tga",
				},
				[2] = {
					["Texture"] = "fe/worldmap/medal_ezust.tga",
				},
				[3] = {
					["Texture"] = "fe/worldmap/medal_arany.tga",
				},
			},
		},
		["rank_Icon"] = {
			["Pos"] = { 0.859375, 0.415972, -7.000000 },
			["Size"] = { 0.072917, 0.065278 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Visible"] = false,
			["geOrder"] = 0,
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
			},
		},
		["slider_Group"] = {
			["Pos"] = { 0.531249, 0.470833, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 8,
			["back_Icon"] = {
				["Pos"] = { 0.288542, 0.058334, -1.000000 },
				["Size"] = { 0.015625, 0.447222 },
				["geOrder"] = 0,
				["States"] = {
					[1] = {
						["Texture"] = "common/slider/slider_bg.tga",
					},
				},
			},
			["scroll_down_Icon"] = {
				["Pos"] = { 0.296355, 0.514585, -19.000000 },
				["Size"] = { 0.015625, 0.020833 },
				["Pivot"] = { 0.500000, 0.500000 },
				["geOrder"] = 2,
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
				},
			},
			["scroll_up_Icon"] = {
				["Pos"] = { 0.296355, 0.045584, -19.000000 },
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
					},
				},
			},
			["slider_FrameBox"] = {
				["Pos"] = { 0.288542, 0.055556, -2.000000 },
				["Size"] = { 0.015625, 0.041667 },
				["geOrder"] = 3,
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
					},
				},
			},
		},
	},
--
	["multiscore_page_Group"] = {
		["Pos"] = { -0.302083, 0.000000, 0.000000 },
		["Visible"] = false,
		["player_Group"] = {
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
				["Pos"] = { 0.010417, 0.097222, 0.000000 },
				["Size"] = { 0.250000, 0.037500 },
				["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
				["geOrder"] = 0,
				["Font"] = "Arial18",
				["DefaultText"] = "FE.scoring_score|.:",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
			["playername_var_Text"] = {
				["Pos"] = { 0.020833, 0.138889, 0.000000 },
				["Size"] = { 0.256250, 0.037500 },
				["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
				["geOrder"] = 1,
				["Font"] = "Arial16",
				["DefaultText"] = "0",
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
					},
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
					},
				},
			},
			["rank_Text"] = {
				["Pos"] = { 0.010417, 0.006944, 0.000000 },
				["Size"] = { 0.260417, 0.037500 },
				["Color"] = { 1.000000, 0.866667, 0.611765, 1.000000 },
				["geOrder"] = 2,
				["Font"] = "Arial18",
				["DefaultText"] = "FE.multi_rank",
				["Align"] = "Left",
				["VerticalAlign"] = "Top",
				["DefaultShadow"] = 0,
			},
			["rank_var_Text"] = {
				["Pos"] = { 0.020834, 0.048611, 0.000000 },
				["Size"] = { 0.310417, 0.037500 },
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
					},
				},
			},
		},
		["playerinfo_FrameBox"] = {
			["Pos"] = { 0.656250, 0.250000, 0.000000 },
			["Size"] = { 0.291667, 0.500000 },
			["geOrder"] = 9,
			["States"] = {
				[1] = {
					["Texture"] = "common/framebox/framebox_01.tga",
				},
			},
		},
		["rank_Icon"] = {
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
			},
		},
	},
--	
}
