PlayerSoundBoost = 2
HRTFMinAngle = 120
HRTFMaxAngle = 180
HRTFFreq = 10000
DopplerConstant = 1000
DopplerMin = -0.4
DopplerMax = 0.1
SoundDistance1 = 800
SoundDistance2 = 1300
SoundDistance3 = 1800
SoundDistance4 = 2200
PassDistance = 500
PassTime = 4


Channelgroups=
{
	["Normal"]= -- name of the group
	{ 
		["Pitch"]=1,
		["Volume"]=1,
	},
	["Silent"]= -- name of the group
	{ 
		["Pitch"]=1.0,
		["Volume"]=0.5,
	},

	["Muzzle"]= -- name of the group
	{ 
		["Pitch"]=1,
		["Volume"]=1,
	},
	["Reverbed"]= -- name of the group
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
	},
		["UnderwaterReverbed"]= -- name of the group
	{
		["Pitch"]=1,
		["Volume"]=1,
-- 		["DSP"]=
-- 		{
-- 			{
-- 				["Type"]="SFXReverb",
-- 				["DryLevel"]=1,
-- 				["Room"]=-1000,
-- 				["RoomHF"]=-4000,
-- 				["RoomRolloff"]=0,
-- 				["DecayTime"]=1.49,
-- 				["DecayHFRatio"]=-0.1,
-- 				["ReflectionsLevel"]=-499,
-- 				["ReflectionsDelay"]=0.007,
-- 				["ReverbLevel"]=1700,
-- 				["ReverbDelay"]=0.011,
-- 				["Diffusion"]=100,
-- 				["Density"]=100,
-- 				["HFReference"]=5000,
-- 				["RoomLF"]=0,
-- 				["LFReference"]=250,

-- 			},
-- 			
-- 		},
	},
	["AirSpecialInUnderwater"]= -- name of the group
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
	},
	["Warnings"]=
	{
		["Pitch"]=1,
		["Volume"]=1,
		["DSP"]=
		{
			{
				["Type"]="Distortion",
			},
		},
	},
	["Cockpit"]= -- name of the group
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
	},

	["System"]= -- defines the system;s DSP chain
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
	},
	["Distance1"]= -- Normal Distanc 800m
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
	},
	["Distance2"]= -- Normal Distanc 1,2km
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
	},
	["Distance3"]= -- Normal Distanc 1,8km
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
	},
	["Distance4"]= -- Normal Distanc 2,2km
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


SoundTypes=
{
	["Normal"]=
	{
		["Air"]="Normal",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	},
	["Normal_dist1"]=
	{
		["Air"]="Distance1",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	},
	["Normal_dist2"]=
	{
		["Air"]="Distance2",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	},
	["Normal_dist3"]=
	{
		["Air"]="Distance3",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	},
	["Normal_dist4"]=
	{
		["Air"]="Distance4",
		["Underwater"]="UnderwaterReverbed",
		["Cockpit"]="Cockpit",
	},

	["Air"]=
	{
		["Air"]="Normal",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	},
	["Air_dist1"]=
	{
		["Air"]="Distance1",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	},
	["Air_dist2"]=
	{
		["Air"]="Distance2",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	},
	["Air_dist3"]=
	{
		["Air"]="Distance3",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	},
	["Air_dist4"]=
	{
		["Air"]="Distance4",
--		["Underwater"]="Normal",
		["Cockpit"]="Cockpit",
	},
	["AirSpecial"]=
	{
		["Air"]="Normal",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	},
	["AirSpecial_dist1"]=
	{
		["Air"]="Distance1",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	},
	["AirSpecial_dist2"]=
	{
		["Air"]="Distance2",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	},
	["AirSpecial_dist3"]=
	{
		["Air"]="Distance3",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	},
	["AirSpecial_dist4"]=
	{
		["Air"]="Distance4",
		["Underwater"]="AirSpecialInUnderwater",
		["Cockpit"]="Cockpit",
	},
	["Underwater"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["Underwater_dist1"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["Underwater_dist2"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["Underwater_dist3"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["Underwater_dist4"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["UnderwaterSpecial"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["UnderwaterSpecial_dist1"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["UnderwaterSpecial_dist2"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["UnderwaterSpecial_dist3"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
	["UnderwaterSpecial_dist4"]=
	{
--		["Air"]="Normal", -- not audible in air
		["Underwater"]="UnderwaterReverbed",
--		["Cockpit"]="Cockpit",
	},
}