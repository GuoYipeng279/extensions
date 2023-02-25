GuiScreen = {}

    GuiScreen["Priority"] = -50
    GuiScreen["Fps_Text"] =
	{
	    ["Pos"] = Platform( { 0.5, 0.01, -5000 }, { 0.5, 0.05, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Arial18"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["MinFps_Text"] =
	{
	    ["Pos"] = Platform( { 0.5, 0.06, -5000 }, { 0.5, 0.1, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Arial18"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["MaxFps_Text"] =
	{
	    ["Pos"] = Platform( { 0.5, 0.11, -5000 }, { 0.5, 0.15, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Arial18"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["Fingerprint_Text"] =
	{
	    ["Pos"] = Platform( { 0.01, 0.05, -75 }, { 0.05, 0.05, -75 }),
	    ["Size"] = { 1.0, 0.1 },
	    ["Font"] = Platform( "Arial15", "Arial18"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	    ["Multiline"] = true,
	}
--    ["Warning_Icon"] =
--	{
--	    ["Pos"] = { 0.5, 0.1, 0 },
--	    ["Pivot"] = { 0.5, 0.5 },
--	    ["States"] = { { ["Texture"] = "warning.tga", }, },
--	}
    GuiScreen["Warning_Text"] =
	{
	    ["Pos"] = Platform( { 0.01, 0.1, -75 }, { 0.05, 0.1, -75 }),
	    ["Size"] = { 1.0, 0.2 },
	    ["Font"] = Platform( "Arial15", "Arial18"),
	    ["Color"] = { 1, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	    ["Multiline"] = true,
	}
    GuiScreen["PG_1p_Text"] =
	{
	    ["Pos"] = Platform( { 0.100, 0.010, -5000 }, { 0.100, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_1_Text"] =
	{
	    ["Pos"] = Platform( { 0.101, 0.011, -5100 }, { 0.101, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_1s_Text"] =
	{
	    ["Pos"] = Platform( { 0.102, 0.012, -5000 }, { 0.102, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}

    GuiScreen["PG_2p_Text"] =
	{
	    ["Pos"] = Platform( { 0.200, 0.010, -5000 }, { 0.200, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_2_Text"] =
	{
	    ["Pos"] = Platform( { 0.201, 0.011, -5100 }, { 0.201, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_2s_Text"] =
	{
	    ["Pos"] = Platform( { 0.202, 0.012, -5000 }, { 0.202, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}


    GuiScreen["PG_3p_Text"] =
	{
	    ["Pos"] = Platform( { 0.300, 0.010, -5000 }, { 0.300, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_3_Text"] =
	{
	    ["Pos"] = Platform( { 0.301, 0.011, -5100 }, { 0.301, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_3s_Text"] =
	{
	    ["Pos"] = Platform( { 0.302, 0.012, -5000 }, { 0.302, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}

    GuiScreen["PG_4p_Text"] =
	{
	    ["Pos"] = Platform( { 0.400, 0.010, -5000 }, { 0.400, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_4_Text"] =
	{
	    ["Pos"] = Platform( { 0.401, 0.011, -5100 }, { 0.401, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_4s_Text"] =
	{
	    ["Pos"] = Platform( { 0.402, 0.012, -5000 }, { 0.402, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}


    GuiScreen["PG_5p_Text"] =
	{
	    ["Pos"] = Platform( { 0.500, 0.010, -5000 }, { 0.500, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_5_Text"] =
	{
	    ["Pos"] = Platform( { 0.501, 0.011, -5100 }, { 0.501, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_5s_Text"] =
	{
	    ["Pos"] = Platform( { 0.502, 0.012, -5000 }, { 0.502, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}


    GuiScreen["PG_6p_Text"] =
	{
	    ["Pos"] = Platform( { 0.600, 0.010, -5000 }, { 0.600, 0.050, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_6_Text"] =
	{
	    ["Pos"] = Platform( { 0.601, 0.011, -5100 }, { 0.601, 0.051, -5100 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 1, 1, 1, 1 },
	    ["DefaultShadow"] = 0,
	}
    GuiScreen["PG_6s_Text"] =
	{
	    ["Pos"] = Platform( { 0.602, 0.012, -5000 }, { 0.602, 0.052, -5000 }),
	    ["Size"] = { 0.45, 0.02 },
	    ["Font"] = Platform( "Arial15", "Viper19"),
	    ["Color"] = { 0, 0, 0, 1 },
	    ["DefaultShadow"] = 0,
	}

    
