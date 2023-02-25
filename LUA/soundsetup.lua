PlayerSoundBoost = 2
HRTFMinAngle = 120
HRTFMaxAngle = 180
HRTFFreq = 10000
DopplerConstant = 1000
DopplerMin = -0.4
DopplerMax = 0.1
SoundDistance1 = 1200
SoundDistance2 = 2600
SoundDistance3 = 6500
SoundDistance4 = 15000
PassDistance = 500
PassTime = 4


Channelgroups = {}
	
Channelgroups["Normal"]= -- name of the group
{ 
	["Pitch"]=1,
	["Volume"]=1,
}
Channelgroups["Silent"]= -- name of the group
{ 
	["Pitch"]=1.0,
	["Volume"]=0.5,
}
Channelgroups["Muzzle"]= -- name of the group
{ 
	["Pitch"]=1,
	["Volume"]=1,
}
Channelgroups["Reverbed"]= -- name of the group
{
	["Pitch"]=1,
	["Volume"]=1,
	["DSP"]=
	{
		{
			["Type"]="SFXReverb",
		},
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=500,
		},
	},
}
Channelgroups["UnderwaterReverbed"]= -- name of the group
{
	["Pitch"]=1,
	["Volume"]=1,
	["DSP"]=
	{
		{
			["Type"]="SFXReverb",
			["DryLevel"]=1,
			["Room"]=-1000,
			["RoomHF"]=-4000,
			["RoomRolloff"]=0,
			["DecayTime"]=1.49,
			["DecayHFRatio"]=-0.1,
			["ReflectionsLevel"]=-499,
			["ReflectionsDelay"]=0.007,
			["ReverbLevel"]=1700,
			["ReverbDelay"]=0.011,
			["Diffusion"]=100,
			["Density"]=100,
			["HFReference"]=5000,
			["RoomLF"]=0,
			["LFReference"]=250,

		},
		
	},
}
Channelgroups["AirSpecialInUnderwater"]= -- name of the group
{ 
	["Pitch"]=1,
	["Volume"]=0.7,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=5000,
		},
	},
}
Channelgroups["Warnings"]=
{
	["Pitch"]=1,
	["Volume"]=1,
	["DSP"]=
	{
		{
			["Type"]="Distortion",
		},
	},
}
Channelgroups["Cockpit"]= -- name of the group
{ 
	["Pitch"]=1,
	["Volume"]=1,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=11500,
		},
	},
}
Channelgroups["System"]= -- defines the system;s DSP chain
{
	["DSP"]=
	{
		{
			["Type"]="Compressor",
			["Treshold"]=-2,
			["Attack"]=15,
			["Release"]=100,
			["Gain"]=0,
		},
	},
}
Channelgroups["Distance1"]= -- Normal Distanc 800m
{ 
	["Pitch"]=1,
	["Volume"]=1.0,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=20000,
		},
	},
}
Channelgroups["Distance2"]= -- Normal Distanc 1,2km
{ 
	["Pitch"]=1,
	["Volume"]=1.0,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=15000,
		},
	},
}
Channelgroups["Distance3"]= -- Normal Distanc 1,8km
{ 
	["Pitch"]=1,
	["Volume"]=0.9,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=10000,
		},
	},
}
Channelgroups["Distance4"]= -- Normal Distanc 2,2km
{ 
	["Pitch"]=1,
	["Volume"]=0.8,
	["DSP"]=
	{
		{
			["Type"]="LowpassSimple",
			["Cutoff"]=8000,
		},
	},
}

Listeners=
{
	"Air",
	"Underwater",
	"Cockpit",
}

Categories=
{
	{
		["Name"]="Warnings",
		["Volume"]=1,
	},
	{
		["Name"]="InGameGUI",
		["Volume"]=1,
	},
	{
		["Name"]="GUITestSpeech",
		["Volume"]=1,
	},
	{
		["Name"]="InPauseGUI",
		["Volume"]=1,
	},
	{
		["Name"]="GUIMusic",
		["Volume"]=1,
	},
	{
		["Name"]="3DEffect",
		["Volume"]=1,
	},
	{
		["Name"]="Sonar",
		["Volume"]=1,
	},
}


SoundTypes = {}
	
	SoundTypes["Normal"]=
	{
		["Air"]="Normal",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Normal_dist1"]=
	{
		["Air"]="Distance1",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Normal_dist2"]=
	{
		["Air"]="Distance2",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Normal_dist3"]=
	{
		["Air"]="Distance3",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Normal_dist4"]=
	{
		["Air"]="Distance4",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Air"]=
	{
		["Air"]="Normal",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Air_dist1"]=
	{
		["Air"]="Distance1",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Air_dist2"]=
	{
		["Air"]="Distance2",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Air_dist3"]=
	{
		["Air"]="Distance3",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Air_dist4"]=
	{
		["Air"]="Distance4",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["AirSpecial"]=
	{
		["Air"]="Normal",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["AirSpecial_dist1"]=
	{
		["Air"]="Distance1",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["AirSpecial_dist2"]=
	{
		["Air"]="Distance2",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["AirSpecial_dist3"]=
	{
		["Air"]="Distance3",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["AirSpecial_dist4"]=
	{
		["Air"]="Distance4",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	}
	SoundTypes["Underwater"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["Underwater_dist1"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["Underwater_dist2"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["Underwater_dist3"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["Underwater_dist4"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["UnderwaterSpecial"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["UnderwaterSpecial_dist1"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["UnderwaterSpecial_dist2"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["UnderwaterSpecial_dist3"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}
	SoundTypes["UnderwaterSpecial_dist4"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	}