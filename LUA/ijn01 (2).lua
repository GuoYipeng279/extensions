GuiScreen = {}

    GuiScreen["geOrder"] = 0
    GuiScreen["1_pri_Group"] = {
        ["Pos"] = { 0.540626, 0.435417, -99.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Rotate"] = -0.174533,
		["geOrder"] = 5,
		["maparrow_1_Icon"] = {
            ["Pos"] = { 0.320834, 0.261806, 50.000000 },
			["Size"] = { 0.104167, 0.111111 },
			["Pivot"] = { 0.560000, 0.575000 },
			["Rotate"] = 3.904997,
			["HighColor"] = { 0.713726, 0.231373, 0.258824, 1.000000 },
			["BlendFactor"] = 1.000000,
			["geOrder"] = 13,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\map\\arrow.tga",
				},
			},
		},
		["USNAirfield_Model"] = {
            ["Pos"] = { 0.365751, -0.114583, 0.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 2.373648,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\airfieldmap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_buildingsmap_us.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["USNFighter_2_Model"] = {
            ["Pos"] = { 0.348750, 0.348945, 0.000000 },
			["Size"] = { 0.064583, 0.058333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.839725,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_us.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
	}
    GuiScreen["1_pri_objective_Group"] = {
        ["Pos"] = { 0.493750, 0.450000, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 2,
		["mapmarker_pri_2_Icon"] = {
            ["Pos"] = { 0.419011, 0.358855, 1.000000 },
			["Size"] = { 0.046875, 0.062500 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 742.427246,
			["geOrder"] = 4,
			["AutoRotate"] = 1.000000,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\map\\map_obj_primary.tga",
				},
			},
		},
	}
    GuiScreen["1_sec_Group"] = {
        ["Pos"] = { 0.550000, 0.500000, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["USNFighter_3_Model"] = {
            ["Pos"] = { 0.376875, 0.259363, -99.000000 },
			["Size"] = { 0.064583, 0.058333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 5.307991,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\destroyermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_us.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
	}
    GuiScreen["1_sec_objective_Group"] = {
        ["Pos"] = { 0.550000, 0.497917, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["mapmarker_sec_Icon"] = {
            ["Pos"] = { 0.373177, 0.210938, 1.000000 },
			["Size"] = { 0.041667, 0.055556 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 727.855225,
			["geOrder"] = 4,
			["AutoRotate"] = 1.000000,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\map\\map_obj_secondary.tga",
				},
			},
		},
	}
    GuiScreen["2_pri_Group"] = {
        ["Pos"] = { 0.502083, 0.443750, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["maparrow_2_Icon"] = {
            ["Pos"] = { 0.463543, 0.213890, -49.000000 },
			["Size"] = { 0.104167, 0.208333 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.839725,
			["HighColor"] = { 0.713726, 0.231373, 0.258824, 1.000000 },
			["BlendFactor"] = 1.000000,
			["geOrder"] = 13,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\map\\arrow.tga",
				},
			},
		},
		["USNBB_01_Model"] = {
            ["Pos"] = { 0.715751, 0.645138, -99.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 5.864306,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\battleshipmap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_shipmap_us.dds",
			["ScaleVector"] = { 0.000080, 0.000080, 0.000080 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
	}
    GuiScreen["2_pri_objective_Group"] = {
        ["Pos"] = { 0.504167, 0.439583, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["mapmarker_pri_1_Icon"] = {
            ["Pos"] = { 0.558594, 0.290105, 1.000000 },
			["Size"] = { 0.041667, 0.055556 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 727.855225,
			["geOrder"] = 4,
			["AutoRotate"] = 1.000000,
			["States"] = {
				[1] = {
					["Texture"] = "fe\\map\\map_obj_primary.tga",
				},
			},
		},
	}
    GuiScreen["BG_01_Group"] = {
        ["Pos"] = { 0.506250, 0.360416, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["bg_04_Icon"] = {
            ["Pos"] = { 0.397917, 0.201389, 6.000000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["geOrder"] = 1,
			["DelayedTextureLoad"] = true,
			["States"] = {
				[1] = {
					["Texture"] = "FE\\briefings\\IJN01.tga",
				},
			},
		},
	}
    GuiScreen["JapPlanes_Group"] = {
        ["Pos"] = { 0.512500, 0.491667, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["geOrder"] = 0,
		["IJNFighter_2_Model"] = {
            ["Pos"] = { 0.320473, 0.132390, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["IJNFighter_3_Model"] = {
            ["Pos"] = { 0.285057, 0.063639, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["IJNFighter_4_Model"] = {
            ["Pos"] = { 0.262140, 0.128223, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["IJNFighter_5_Model"] = {
            ["Pos"] = { 0.301723, -0.005111, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["IJNFighter_6_Model"] = {
            ["Pos"] = { 0.230890, 0.044890, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["IJNFighter_Model"] = {
            ["Pos"] = { 0.351724, 0.055306, -99.000000 },
			["Size"] = { 0.047917, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 3.665192,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\fightermap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_planemap_jap.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
	}
    GuiScreen["Trash_Group"] = {
        ["Pos"] = { 0.470833, 0.372917, 0.000000 },
		["Size"] = { 0.500000, 0.500000 },
		["Pivot"] = { 0.500000, 0.500000 },
		["Color"] = { 1.000000, 1.000000, 1.000000, 0.500000 },
		["LowColor"] = { 0.000000, 0.000000, 0.000000, 0.500000 },
		["HighColor"] = { 1.000000, 1.000000, 1.000000, 0.500000 },
		["geOrder"] = 0,
		["USNBB_3_Model"] = {
            ["Pos"] = { 0.375127, 0.897222, -99.000000 },
			["Size"] = { 0.500000, 0.500000 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 5.061455,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\battleshipmap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_shipmap_us.dds",
			["ScaleVector"] = { 0.000080, 0.000080, 0.000080 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["uspt_2_Model"] = {
            ["Pos"] = { 0.399167, 0.455751, 0.000000 },
			["Size"] = { 0.045833, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 5.759587,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\ptboatmap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_shipmap_us.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
		["uspt_Model"] = {
            ["Pos"] = { 0.501250, 0.274501, 0.000000 },
			["Size"] = { 0.045833, 0.056250 },
			["Pivot"] = { 0.500000, 0.500000 },
			["Rotate"] = 4.537856,
			["geOrder"] = 0,
			["ModelName"] = "models\\gui\\map\\units\\ptboatmap.MMOD",
			["ModelTextureOverride"] = "models\\gui\\map\\units\\FE_shipmap_us.dds",
			["ScaleVector"] = { 0.000100, 0.000100, 0.000100 },
			["RotationEuler"] = { 0.000000, -1.570796, 0.000000 },
		},
    }