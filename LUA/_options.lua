GuiScreen = {}

    GuiScreen["Priority"] = 170
    GuiScreen["ClearProps"] = "All"
    GuiScreen["Pos"] = { 0, 0, -500 }

    GuiScreen["Main_Listbox"] = CreateStandardMenu2({ 0.0825, 0.48, -1 }, nil, nil, true, "Left")
    GuiScreen["Ingame_Main_Listbox"] = CreateStandardMenu({ 0.5, 0.48, -1 }, nil, nil, true, "Center")

    GuiScreen["SfxVolume_Sound"] =
	{
	    ["Visible"] = false,
	    ["SoundEfx"] = "sound/gui/soundtest_01.fsb",
	    ["Category"] = "InPauseGUI",
	}
    GuiScreen["SpeechVolume_Sound"] =
	{
	    ["Visible"] = false,
	    ["SoundEfx"] = "sound/gui/voicetest_01.fsb",
	    ["Category"] = "GUITestSpeech",
	}
    
