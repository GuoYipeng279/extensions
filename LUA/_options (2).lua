GuiScreen =
{
	["Priority"] = 170,
	["ClearProps"] = "All",
	["Pos"] = { 0, 0, -500 },

	["Main_Listbox"] = CreateStandardMenu2({ 0.0825, 0.48, -1 }, nil, nil, true, "Left"),
	["Ingame_Main_Listbox"] = CreateStandardMenu({ 0.5, 0.48, -1 }, nil, nil, true, "Center"),

	["SfxVolume_Sound"] =
	{
		["Visible"] = false,
		["SoundEfx"] = "sound/gui/soundtest_01.fsb",
		["Category"] = "InPauseGUI",
	},
	["SpeechVolume_Sound"] =
	{
		["Visible"] = false,
		["SoundEfx"] = "sound/gui/voicetest_01.fsb",
		["Category"] = "GUITestSpeech",
	},
}
