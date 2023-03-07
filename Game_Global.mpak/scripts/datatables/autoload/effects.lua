Effects = 
{
	[1] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["MaxMagnitude"] = 0.4,
			["MaxStart"] = true,
			["MaxTime"] = 0.08,
			["MinMagnitude"] = 0,
			["MinTime"] = 0.05,
			["PowerType"] = 1,
			["Radius"] = 10,
			["TimeTotal"] = 999999,
			["Type"] = "SquareRumble",
		},
		[2] = 
		{
			["Autostart"] = true,
			["MaxMagnitude"] = 0.5,
			["MaxStart"] = true,
			["MaxTime"] = 0.08,
			["MinMagnitude"] = 0,
			["MinTime"] = 0.05,
			["PowerType"] = 0,
			["Radius"] = 10,
			["TimeTotal"] = 999999,
			["Type"] = "SquareRumble",
		},
		["Comment"] = "Heavy rumble gepeknek",
		["Name"] = "PlaneRumble",
		["Type"] = "Rumble",
	},
	[2] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["MaxMagnitude"] = 1.7,
			["MaxStart"] = true,
			["MaxTime"] = 0.08,
			["MinMagnitude"] = 0,
			["MinTime"] = 0.1,
			["PowerType"] = 0,
			["Radius"] = 10,
			["TimeTotal"] = 999999,
			["Type"] = "SquareRumble",
		},
		["Comment"] = "Light small rumble gepeknek",
		["Name"] = "RumbleMedium2",
		["Type"] = "Rumble",
	},
	[3] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 10,
			["StartMagnitude"] = 0.7,
			["TimeTotal"] = 0.3,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "light rumble agyuknak",
		["Name"] = "RumbleSmall",
		["Type"] = "Rumble",
	},
	[4] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 10,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "heavy rumble agyuknak",
		["Name"] = "RumbleLarge",
		["Type"] = "Rumble",
	},
	[5] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzle5inch/muzzle_5_inch",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "gunshot_small.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event on <6''flaks rockets",
		["Name"] = "Muzzle5inch",
		["Type"] = "Effect",
	},
	[6] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzle8inch/muzzle_8_inch",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "gunshot_medium.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event used on >=6''",
		["Name"] = "Muzzle8inch",
		["Type"] = "Effect",
	},
	[7] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzle14inch/muzzle_14_inch",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "gunshot_big.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 50,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		["Comment"] = "New Eventadded shake effect",
		["Name"] = "Muzzle14inch",
		["Type"] = "Effect",
	},
	[8] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzlejamato/muzzle_jamato",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "gunshot_big.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 50,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		["Comment"] = "New Event added shake effect",
		["Name"] = "MuzzleYamato",
		["Type"] = "Effect",
	},
	[9] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/splash/splashmedium/splash_medium",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "splash_medium_main.pes",
				[2] = "splash_small_main.pes",
			},
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 50,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 100,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 100,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Amplitude"] = 1,
			["Autostart"] = true,
			["Radius"] = 30,
			["Speed"] = 15,
			["Type"] = "Splash",
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "splash_medium_float.pes",
				[2] = "splash_small_float.pes",
			},
			["Type"] = "Particle",
		},
		["Comment"] = "New Event small artillery,Impact5inchWater explionWater",
		["Name"] = "5InchExplosionWater",
		["Type"] = "Effect",
	},
	[10] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactsmallflack/impact_small_flack",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_flak.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 80,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.3,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "Flak robbanas a levegoben",
		["Name"] = "Impact5InchFlak",
		["Type"] = "Effect",
	},
	[11] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumarmor/impact_medium_armor",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_small.pes",
			},
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 100,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "5-8  agyuk ha hajot talalnak el",
		["Name"] = "5InchExplosionArmour",
		["Type"] = "Effect",
	},
	[12] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumarmor/impact_medium_armor",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_small.pes",
			},
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 100,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "5-8  agyuk ha repcsit talalnak, ki van kotve mert ugyanaz mint a 11",
		["Name"] = "Impact5InchArmourforFlak",
		["Type"] = "Effect",
	},
	[13] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumground/impact_medium_ground",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_bomb_ground_big.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 100,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "small artillery, flak, rocket expl",
		["Name"] = "Impact5InchGround",
		["Type"] = "Effect",
	},
	[14] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["HeadRadius"] = 0.5,
			["MaxSegmentNum"] = 200,
			["MinSegmentLength"] = 13,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 10,
			},
			["SegmentLifeTime"] = 1,
			["TextureName"] = "cloud_snake.dds",
			["Type"] = "Tracer",
			["UVTileLength"] = 10,
			["Width"] = 1,
			["WidthSpeed"] = 0.5,
			["WidthSpeedEnd"] = 0.1,
		},
		["Comment"] = "small artillery, flak, rocket expl",
		["Name"] = "5InchBulletTracer",
		["Type"] = "Tracer",
	},
	[15] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/splash/splashbig/splash_big",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_big_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Amplitude"] = 0.5,
			["Autostart"] = true,
			["Radius"] = 40,
			["Speed"] = 19,
			["Type"] = "Splash",
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_big_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event big artillery, flak, rocket expl",
		["Name"] = "Impact14InchWater",
		["Type"] = "Effect",
	},
	[16] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigarmor/impact_big_armor",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_14inch.pes",
			},
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "BB agyuk hajo elleni talalata",
		["Name"] = "Impact14InchArmour",
		["Type"] = "Effect",
	},
	[17] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigarmor/impact_big_armor",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_small.pes",
			},
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 0.3,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "BB agyuk repcsi elleni talalata",
		["Name"] = "Impact14InchArmourforFlak",
		["Type"] = "Effect",
	},
	[18] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigground/impact_big_ground",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_ground_big.pes",
				[2] = "explosion_bomb_ground_big_v2.pes",
			},
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "New Event big artillery, flak, rocket expl",
		["Name"] = "Impact14InchGround",
		["Type"] = "Effect",
	},
	[19] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["HeadRadius"] = 1,
			["MaxSegmentNum"] = 250,
			["MinSegmentLength"] = 20,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 10,
			},
			["SegmentLifeTime"] = 1,
			["TextureName"] = "cloud_snake.dds",
			["Type"] = "Tracer",
			["UVTileLength"] = 15,
			["Width"] = 2.5,
			["WidthSpeed"] = 0,
			["WidthSpeedEnd"] = 0,
		},
		["Comment"] = "big artillery, flak, rocket expl",
		["Name"] = "14InchBulletTracer",
		["Type"] = "Tracer",
	},
	[20] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionobject/explosion_object",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_white.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 150,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "6 + turret explosion",
		["Name"] = "ExplosionBigTurret",
		["Type"] = "Effect",
	},
	[21] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigplane/explosion_big_plane",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_plane_big.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "Hasznaljuk Nagy repcsikhez",
		["Name"] = "ExplosionBigPlane",
		["Type"] = "Effect",
	},
	[22] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_farviz.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "rotorparticle",
		["Name"] = "ParticleShipRotor",
		["Type"] = "Particle",
	},
	[23] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["BulletFadeBegin"] = 1.6,
			["BulletHeadTexture"] = "tr_glow_add.dds",
			["BulletLifeTime"] = 2,
			["BulletTailTexture"] = "tr_bullet2.dds",
			["HeadColor"] = 
			{
				[1] = 255,
				[2] = 128,
				[3] = 50,
				[4] = 255,
			},
			["HeadRadius"] = 0.3,
			["MaxSegmentNum"] = 15,
			["MinSegmentLength"] = 11.34,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 7,
			},
			["SegmentLifeTime"] = 0.5,
			["ShowBullet"] = true,
			["TailColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 50,
			},
			["TailLength"] = 15,
			["TextureName"] = "cloud_snake_0000.dds",
			["Type"] = "Tracer",
			["UVTileLength"] = 5,
			["Width"] = 0.3,
			["WidthSpeed"] = 0,
			["WidthSpeedEnd"] = 0,
		},
		["Comment"] = "20mm- AA bullet tracer",
		["Name"] = "MachineGunBulletTracer",
		["Type"] = "Tracer",
	},
	[24] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["BulletFadeBegin"] = 2.6,
			["BulletHeadTexture"] = "tr_glow_add.dds",
			["BulletLifeTime"] = 2,
			["BulletTailTexture"] = "tr_bullet2.dds",
			["HeadColor"] = 
			{
				[1] = 255,
				[2] = 128,
				[3] = 50,
				[4] = 150,
			},
			["HeadRadius"] = 0.5,
			["MaxSegmentNum"] = 20,
			["MinSegmentLength"] = 11.34,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 8,
			},
			["SegmentLifeTime"] = 0.5,
			["ShowBullet"] = true,
			["TailColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 50,
			},
			["TailLength"] = 20,
			["TextureName"] = "cloud_snake.dds",
			["Type"] = "Tracer",
			["Width"] = 0.6,
			["WidthSpeed"] = 0.5,
			["WidthSpeedEnd"] = 0.5,
		},
		["Comment"] = "20mm+ AA bullet tracer",
		["Name"] = "TracerSmallOerlikon",
		["Type"] = "Tracer",
	},
	[25] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionconcretebuilding/explosion_concretebuilding",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_plane_ground.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 150,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "repulo foldbecsapodas",
		["Name"] = "ExplosionPlaneGround",
		["Type"] = "Effect",
	},
	[26] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_single.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzle50calAA/muzzle_50calAA",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "new Event Raiden 20mm",
		["Name"] = "Muzzle50calAA",
		["Type"] = "Effect",
	},
	[27] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_small.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlelightfightergun/muzzle_light_fightergun",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event Torlendo MG cont. fire efx, gyakori",
		["Name"] = "MuzzleLightMachinegunLoop",
		["Type"] = "Effect",
	},
	[28] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_medium.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzleheavyfightergun/muzzle_heavy_fightergun",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event Torlendo PTken",
		["Name"] = "MuzzleHeavyMachinegunLoop",
		["Type"] = "Effect",
	},
	[29] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_medium.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzleoerlikon/muzzle_oerlikon",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event ritkan hasznalt",
		["Name"] = "MuzzleOerlikonLoop",
		["Type"] = "Effect",
	},
	[30] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_medium.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlebofors/muzzle_bofors",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol!",
		["Name"] = "MuzzleBoforsLoop",
		["Type"] = "Effect",
	},
	[31] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzlebofors/muzzle_bofors",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_single.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event",
		["Name"] = "MuzzleBoforsSingle",
		["Type"] = "Effect",
	},
	[32] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_small.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default plane MG",
		["Name"] = "MuzzlePlaneLightMachineGun",
		["Type"] = "Particle",
	},
	[33] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "bullet_ammo.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "toltenyhuvely potyogas",
		["Name"] = "MuzzleShellEject",
		["Type"] = "Particle",
	},
	[34] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "machinegun_shot_20mm.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "20mm 30mm Hispano efx",
		["Name"] = "MuzzlePlaneHeavyMachineGun",
		["Type"] = "Particle",
	},
	[35] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzleusgeneralplane/muzzle_us_general_plane",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event",
		["Name"] = "MuzzleUSGeneralPlaneGun",
		["Type"] = "Sound",
	},
	[36] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzleusfighter50cal/muzzle_us_fighter_50cal",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event leggyakrabb",
		["Name"] = "MuzzleUS50CalGun",
		["Type"] = "Sound",
	},
	[37] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlejpgeneralplane/muzzle_jp_general_plane",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event !nem hasznalt sehol",
		["Name"] = "MuzzleJPGeneralPlaneGun",
		["Type"] = "Sound",
	},
	[38] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlejpfighter/muzzle_jp_fighter",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event",
		["Name"] = "MuzzleJPFighterGun",
		["Type"] = "Sound",
	},
	[39] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzleus20mm/muzzle_us_20mm",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event 20mm Bradley Like",
		["Name"] = "MuzzleUS20mmGun",
		["Type"] = "Sound",
	},
	[40] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlejp30mm/muzzle_jp_30mm",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event 30mm Slow BiGun",
		["Name"] = "MuzzleJP30mmGun",
		["Type"] = "Sound",
	},
	[41] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "bullethit_mg_armour.pes",
				[2] = "bullethit_mg_armour.pes",
				[3] = "bullethit_mg_armour_big.pes",
				[4] = "bullethit_mg_armour.pes",
				[5] = "bullethit_mg_armour.pes",
			},
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impactmachinegunarmour/impact_machinegun_armour",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "bullet expl effect",
		["Name"] = "MachinegunHit",
		["Type"] = "Effect",
	},
	[42] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "bullet_hit_light.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impactmachinegunplane/impact_machinegun_plane",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event bullet expl effect",
		["Name"] = "ImpactMachinegunPlane",
		["Type"] = "Effect",
	},
	[43] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "bullethit_mg_ground.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impactmachinegunground/impact_machinegun_ground",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "bullet expl effect",
		["Name"] = "ImpactMachinegunGround",
		["Type"] = "Effect",
	},
	[44] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "bullethit_mg_water_main.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "bullethit_mg_water_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "bullet expl effect",
		["Name"] = "ImpactMachinegunWater",
		["Type"] = "Effect",
	},
	[45] = 
	{
		[1] = 
		{
			[9] = 
			{
				["Autostart"] = true,
				["Category"] = "3DEffect",
				["Persistent"] = true,
				["Sample"] = "planes.fev:planes/muzzle/muzzletorpedolaunchsurface/muzzle_torpedolaunchsurface",
				["SoundType"] = "Underwater",
				["Type"] = "Sound",
			},
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigarmor/impact_big_armor",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_big_onwater_main.pes",
				[2] = "explosion_ship_main.pes",
			},
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 0.5,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_big_onwater_float.pes",
				[2] = "explosion_ship_float.pes",
			},
			["Type"] = "Particle",
		},
		["Comment"] = "New Event bomb expl effect",
		["Name"] = "ImpactBigArmor",
		["Type"] = "Effect",
	},
	[46] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigwater/impact_big_water",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_big_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 200,
			["StartMagnitude"] = 0.5,
			["TimeTotal"] = 0.4,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Amplitude"] = 0.5,
			["Autostart"] = true,
			["Radius"] = 40,
			["Speed"] = 19,
			["Type"] = "Splash",
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_big_float.pes",
			["Type"] = "Particle",
		},
		[9] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumdepthchargeunderwater/impact_medium_depthchargeunderwater",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event bomb expl effect",
		["Name"] = "ImpactBigBombWater",
		["Type"] = "Effect",
	},
	[47] = 
	{
		[1] = 
		{
			["ApplyAtBottomOnly"] = true,
			["Autostart"] = true,
			["Gravity"] = 120,
			["MaxLifeTime"] = 1.2,
			["MaxSize"] = 0.004,
			["MinLifeTime"] = 0.75,
			["MinSize"] = 0.0035,
			["Radius"] = 50,
			["Range"] = 20,
			["StickyPercent"] = 50,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 20,
		},
		["Comment"] = "waterdrop near water Waterdrops lesz",
		["Name"] = "LowPlaneAlt",
		["Type"] = "Waterdrops",
	},
	[48] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigground/impact_big_ground",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_bomb_ground_big.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "New Event bomb expl effect",
		["Name"] = "ImpactBigGround",
		["Type"] = "Effect",
	},
	[49] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzlebombrelease/muzzle_bombrelease",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 50,
			["StartMagnitude"] = 3,
			["TimeTotal"] = 0.2,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "New Event bomba oldas",
		["Name"] = "MuzzleBombRelease1",
		["Type"] = "Sound",
	},
	[50] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzlebombfall/muzzle_bombfall",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event",
		["Name"] = "MuzzleBombRelease2",
		["Type"] = "Sound",
	},
	[51] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzledepthchargerelease/muzzle_depthchargerelease",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event DC release from ship",
		["Name"] = "MuzzleDepthchargeRelease",
		["Type"] = "Sound",
	},
	[52] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_flat_main.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzledepthchargesplash/muzzle_depthchargesplash",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzledepthchargeunderwatersplash/muzzle_depthcharge_underwater_splash",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[4] = 
		{
			["Amplitude"] = 0.1,
			["Autostart"] = true,
			["Radius"] = 15,
			["Speed"] = 13,
			["Type"] = "Splash",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_flat_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event DC effect",
		["Name"] = "MuzzleDepthchargeSplash",
		["Type"] = "Effect",
	},
	[53] = 
	{
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_dpthchg_underw.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_underw_bubl_small.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[4] = 
		{
			["Amplitude"] = 0.1,
			["Autostart"] = true,
			["Radius"] = 15,
			["Speed"] = 13,
			["Type"] = "Splash",
		},
		["Comment"] = "DC effect",
		["Name"] = "TracerDepthchargeUnderwater",
		["Type"] = "Effect",
	},
	[54] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumdepthchargesurface/impact_medium_depthchargesurface",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactmediumdepthchargeunderwater/impact_medium_depthchargeunderwater",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_underwater_big.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_medium_main.pes",
			["Type"] = "Particle",
		},
		[7] = 
		{
			["Amplitude"] = 1,
			["Autostart"] = true,
			["Radius"] = 30,
			["Speed"] = 15,
			["Type"] = "Splash",
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_medium_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "DE effect",
		["Name"] = "ImpactDepthcharge",
		["Type"] = "Effect",
	},
	[55] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzletorpedolaunchsurface/muzzle_torpedolaunchsurface",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzletorpedolaunchunderwater/muzzle_torpedolaunchunderwater",
			["SoundType"] = "UnderwaterSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "torp_launch_underw.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event torp launch from sub",
		["Name"] = "MuzzleTorpedoLaunchUnderwater",
		["Type"] = "Effect",
	},
	[56] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["HeadRadius"] = 1,
			["MaxSegmentNum"] = 250,
			["MinSegmentLength"] = 20,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 80,
			},
			["SegmentLifeTime"] = 2,
			["TextureName"] = "cloud_snake.dds",
			["Type"] = "Tracer",
			["Width"] = 2,
			["WidthSpeed"] = 0,
			["WidthSpeedEnd"] = 0,
		},
		["Comment"] = "!ez minek kell, ne hasznald",
		["Name"] = "TracerRocket",
		["Type"] = "Effect",
	},
	[57] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzletorpedolaunchsurface/muzzle_torpedolaunchsurface",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzletorpedolaunchunderwater/muzzle_torpedolaunchunderwater",
			["SoundType"] = "UnderwaterSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "torpedo_shot.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event torpedo effect",
		["Name"] = "MuzzleTorpedoLaunchSurface",
		["Type"] = "Effect",
	},
	[58] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_flat_main.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzledepthchargesplash/muzzle_depthchargesplash",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/muzzle/muzzledepthchargeunderwatersplash/muzzle_depthcharge_underwater_splash",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[4] = 
		{
			["Amplitude"] = 0.1,
			["Autostart"] = true,
			["Radius"] = 12,
			["Speed"] = 13,
			["Type"] = "Splash",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_flat_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event torpedo effect",
		["Name"] = "MuzzleTorpedoSplash",
		["Type"] = "Effect",
	},
	[59] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impactbigwater/impact_big_water",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impacttorpedoarmor/impact_torpedoarmor",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_depthcharge_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_underwater_big.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[5] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[6] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 300,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[7] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[8] = 
		{
			["Amplitude"] = 0.5,
			["Autostart"] = true,
			["Radius"] = 40,
			["Speed"] = 19,
			["Type"] = "Splash",
		},
		[9] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_depthcharge_float.pes",
			["Type"] = "Particle",
		},
		[10] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/impact/impactbigarmor/impact_big_armor",
			["SoundType"] = "Airspecial",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event torpedo effect",
		["Name"] = "MuzzleTorpedoExplosionArmour",
		["Type"] = "Effect",
	},
	[60] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.3,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1000,
			["Autostart"] = true,
			["DisplacementScale"] = 0.1,
			["Divisions"] = 4,
			["FadeIn"] = 0.005,
			["FitToWater"] = true,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 0.1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Length"] = 600,
			["Lifetime"] = 12,
			["LineDistance"] = 1,
			["LOD"] = false,
			["MaxSpeed"] = 51.444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 0.1,
			["StartTime"] = 0.15,
			["StopSpeed"] = 1,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.025,
			["TimeScale"] = 0.5,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.005,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 0.875,
				},
				[6] = 
				{
					[1] = 0.45,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "prop_bubbles_torpedo.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.25,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1000,
			["Autostart"] = true,
			["DisplacementScale"] = 5,
			["Divisions"] = 4,
			["FadeIn"] = 0.005,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 0.4,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.95,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.9,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.8,
				},
				[5] = 
				{
					[1] = 0.55,
					[2] = 0.55,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.39,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.88,
				},
				[4] = 
				{
					[1] = 0.1,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.46,
					[2] = 0.74,
				},
				[7] = 
				{
					[1] = 0.58,
					[2] = 0.56,
				},
				[8] = 
				{
					[1] = 0.74,
					[2] = 0.28,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.14,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Length"] = 23,
			["Lifetime"] = 1,
			["LineDistance"] = 1,
			["LocalSpace"] = true,
			["LOD"] = false,
			["MaxSpeed"] = 51.444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 0.1,
			["StartTime"] = 0.15,
			["StopSpeed"] = 1,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.1,
			["TimeScale"] = 0.5,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.03,
					[2] = 0.625,
				},
				[4] = 
				{
					[1] = 0.065,
					[2] = 0.79,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.42,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.55,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.995,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.9975,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 1.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[4] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["Sample"] = "planes.fev:planes/muzzle/muzzletorpedotravelunderwater/muzzle_torpedotravel_underwater",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event torpedo effect",
		["Name"] = "MuzzleTorpedoTravelUnderwater",
		["Type"] = "Effect",
	},
	[61] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "prop_bubbles.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		["Comment"] = "61,62,63 ugyanaz",
		["Name"] = "TracerSmallScrewUnderwater",
		["Type"] = "Particle",
	},
	[62] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "prop_bubbles.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		["Comment"] = "61,62,63 ugyanaz",
		["Name"] = "TracerMediumScrewUnderwater",
		["Type"] = "Particle",
	},
	[63] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "prop_bubbles.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		["Comment"] = "61,62,63 TracerBigScrewUnderwater lesz",
		["Name"] = "BigBubbles",
		["Type"] = "Particle",
	},
	[64] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "sink_on_water_big_main.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Amplitude"] = 0.2,
			["Autostart"] = true,
			["Radius"] = 10,
			["Speed"] = 3,
			["Type"] = "Splash",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "sink_on_water_big_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "sullyedes buborekok",
		["Name"] = "SurfaceBubbles",
		["Type"] = "Particle",
	},
	[65] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["SampleTable"] = 
			{
				[1] = "environment_shipcolliding_01.fsb",
				[2] = "environment_shipcolliding_02.fsb",
			},
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Comment"] = "hajo utkozes hang",
		["Name"] = "BigCollision",
		["Type"] = "Sound",
	},
	[66] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigship/explosion_big_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_engine.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		["Comment"] = "default engine explosion effekt ",
		["Name"] = "ExplosionEngine",
		["Type"] = "Effect",
	},
	[67] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_magazine_main.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/explosion/explosionbigobject/explosion_big_object",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_magazine_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default magazine explosion effekt",
		["Name"] = "ExplosionMagazine",
		["Type"] = "Effect",
	},
	[68] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "rain_clouds.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "es�h�z pamacsok",
		["Name"] = "RainCloud",
		["Type"] = "Particle",
	},
	[69] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "rain_splashes.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "es�cseppek a vizen",
		["Name"] = "RainSplashes",
		["Type"] = "Particle",
	},
	[70] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "steamtrain_smoke.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "vonat fust",
		["Name"] = "SmokeTrainEngine",
		["Type"] = "Particle",
	},
	[71] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigbuilding/explosion_big_building",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_building_large.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "epulet expl effekt,nagy",
		["Name"] = "ExplosionLargeBuilding",
		["Type"] = "Effect",
	},
	[72] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "smoke_building.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "serult epuletekhez fust",
		["Name"] = "BuildingSmoke",
		["Type"] = "Effect",
	},
	[73] = 
	{
		["Comment"] = "csak rescueship hasznalja (96)",
		["Name"] = "ObsoleteBoatEngine",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/ships/engines/defptboat/engine_def_pt",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[74] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_underw_bubl_big_loop.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		["Comment"] = "loopolt bubi,serult subokhoz es hajokhoz",
		["Name"] = "DamageBubblesUnderwater",
		["Type"] = "Effect",
	},
	[75] = 
	{
		[1] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 37,
			["MaxLifeTime"] = 1.6,
			["MaxSize"] = 0.008,
			["MinLifeTime"] = 0.5,
			["MinSize"] = 0.005,
			["Radius"] = 12,
			["Range"] = 20,
			["StickyPercent"] = 5,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 2,
		},
		["Comment"] = "waterdrop rain",
		["Name"] = "RainWaterdrops",
		["Type"] = "Waterdrops",
	},
	[76] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_fire_medium.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_big_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "gyH damage efect kozepes hajokhoz",
		["Name"] = "BigFire_medium",
		["Type"] = "Effect",
	},
	[77] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigship/explosion_big_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_megabomb.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		["Comment"] = "default meghalas effect",
		["Name"] = "ExplosionShipDeath",
		["Type"] = "Effect",
	},
	[78] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigship/explosion_big_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_megabomb_medium.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		["Comment"] = "default meghalas effect medium",
		["Name"] = "ExplosionShipDeathMedium",
		["Type"] = "Effect",
	},
	[79] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigship/explosion_big_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_small_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_small_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default innerexplosion effekt - ImpactMediumArmor_small",
		["Name"] = "ExplosionBigShip_small",
		["Type"] = "Effect",
	},
	[84] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "plane_jetengine.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "jet effect",
		["Name"] = "TracerJetEngine",
		["Type"] = "Particle",
	},
	-- [87] = -- Stuka Siren Sound
	-- {
	-- 	["Comment"] = "Stuka Siren",
	-- 	["Name"] = "StukaSiren",
	-- 	["Sound"] = 
	-- 	{
	-- 		["Autostart"] = true,
	-- 		["Category"] = "3DEffect",
	-- 		["Persistent"] = true,
	-- 		["PitchRnd"] = 0.1,
	-- 		["Sample"] = "environment_stuka_siren.fsb",
	-- 		["SoundType"] = "Air",
	-- 		["Type"] = "Sound",
	-- 	},
	-- 	["Type"] = "Sound",
	-- },
	[97] = 
	{
		["Comment"] = "event repcsi hang",
		["Name"] = "USBomberTwinEngine",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/planes/engines/us_twinengine/us_twin",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[100] = 
	{
		["Comment"] = "event repcsi hang",
		["Name"] = "USBomberQuadEngine",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/planes/engines/us_quadengine/us_quad",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[103] = 
	{
		["Comment"] = "vehicle hang",
		["Name"] = "EngineJeepVehicle",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/vehicles/engines/enginetruck/engine_truck",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[104] = 
	{
		["Comment"] = "vehicle hang",
		["Name"] = "EngineTruckVehicle",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/vehicles/engines/enginearmoured/engine_armoured",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[105] = 
	{
		["Comment"] = "vehicle hang",
		["Name"] = "EngineArmoredVehicle",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/vehicles/engines/enginetank/engine_tank",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[110] = 
	{
		["Comment"] = "hajocsavar hang",
		["Name"] = "EnvironmentBigScrewUnderwater",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/ships/engines/bigscrewunderwater/engine_big_screw_underwater",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[111] = 
	{
		["Comment"] = "hajocsavar hang",
		["Name"] = "EnvironmentSmallScrewUnderwater",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/ships/engines/smallscrewunderwater/engine_small_screw_underwater",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[112] = 
	{
		["Comment"] = "New Small Submarine Screw",
		["Name"] = "EnvironmentSubmarineScrew",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/ships/engines/smallsubmarinescrew/engine_small_submarine_screw",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[113] = 
	{
		["Comment"] = "sullyedes recseges, kodbol",
		["Name"] = "SinkingBigShip",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_waterpressure_underwater.fsb",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[114] = 
	{
		["Comment"] = "hajocsavar hang",
		["Name"] = "SinkingSmallShip",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_waterpressure_underwater.fsb",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[115] = 
	{
		["Comment"] = "sullyedes recseges, kodbol",
		["Name"] = "EnvironmentShipColliding",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_shipcolliding_02.fsb",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[116] = 
	{
		["Comment"] = "deadmeat repcsi hang",
		["Name"] = "DyingSmallPlane",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_fighter_planefall.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[117] = 
	{
		["Comment"] = "deadmeat repcsi hang",
		["Name"] = "DyingBigPlane",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_bomber_planefall.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[118] = 
	{
		["Comment"] = "deadmeat repcsi hang",
		["Name"] = "FallingSmallPlane",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_planefall.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[119] = 
	{
		["Comment"] = "toofast bigl",
		["Name"] = "FallingBigPlane",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_big_planefall.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[120] = 
	{
		["Comment"] = "SzelzajEnvironmentWindnoise",
		["Name"] = "PlaneWingWind",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0,
			["Sample"] = "environment_windnoise.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[121] = 
	{
		["Comment"] = "anyahajo lift hang",
		["Name"] = "ElevatorMove",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_servo.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[122] = 
	{
		["Comment"] = "sonar hang 1",
		["Name"] = "SonarPing",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "Sonar",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_sonar_02.fsb",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[123] = 
	{
		["Comment"] = "sonar hang 2",
		["Name"] = "JapSonarPing",
		["Sound"] = 
		{
			["Autostart"] = true,
			["Category"] = "Sonar",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_sonar_01.fsb",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		["Type"] = "Sound",
	},
	[124] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_air_raid.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "UJ Szirena hang",
		["Name"] = "EnvironmentAirRaid",
		["Type"] = "Sound",
	},
	[125] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_alarm_ring.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "UJ Csengo hang",
		["Name"] = "EnvironmentAlarmRing",
		["Type"] = "Sound",
	},
	[126] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_us_horn.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "hajokurt hang",
		["Name"] = "EnvironmentUSHorn",
		["Type"] = "Sound",
	},
	[130] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_dockwork_ambience.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "UJ Ambiens hajo dokk hang",
		["Name"] = "DockWork",
		["Type"] = "Sound",
	},
	[131] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/splash/splashbig/splash_big",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "New Event vizcsobbanas (nem unithoz kotott)",
		["Name"] = "WaterSpray",
		["Type"] = "Sound",
	},
	[132] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_waterfall.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!nem hasznalt vizeses(am3)",
		["Name"] = "EnvironmentWaterfall",
		["Type"] = "Particle",
	},
	[133] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "oil_fire_small.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!kis tuz (kod hasznalja?)",
		["Name"] = "?kemenytuz",
		["Type"] = "Particle",
	},
	[134] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "object_small_smoke2.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!kis fust (kod hasznalja?)",
		["Name"] = "?TinySmoke",
		["Type"] = "Particle",
	},
	[135] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_engine_smoke_small.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "gyakran hasznalt hajoknal",
		["Name"] = "SmallSmoke",
		["Type"] = "Effect",
	},
	[136] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_fire_small.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "gyarkan hasznalt damagsmoke hajoknal",
		["Name"] = "SmallFire",
		["Type"] = "Effect",
	},
	[137] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_smoke.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_smoke.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "building damage effect",
		["Name"] = "EnvironmentSmoke",
		["Type"] = "Effect",
	},
	[138] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_fire.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_big_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "gyH damage efect EnvironmentBigPlaneFire lesz",
		["Name"] = "BigFire",
		["Type"] = "Effect",
	},
	[139] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "plane_damage_fire_big.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "enginefire efx",
		["Name"] = "EnvironmentSmallFire",
		["Type"] = "Effect",
	},
	[140] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "plane_damage_fire_med.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "SmallerPlaneFire",
		["Type"] = "Effect",
	},
	[141] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "plane_damage_fire_min.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "VerySmallPlaneFire",
		["Type"] = "Effect",
	},
	[142] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "plane_damage_smoke_small.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "damagesmoke effekt",
		["Name"] = "SmokeSmallPlane",
		["Type"] = "Particle",
	},
	[143] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "smoke_giant.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "gyakran hasznalt damagesmoke",
		["Name"] = "GiantSmoke",
		["Type"] = "Effect",
	},
	[144] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "smoke_giant_v2.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_big_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol (movie)",
		["Name"] = "RealGiantSmoke",
		["Type"] = "Effect",
	},
	[145] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "background_smoke1.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!nem hasznalt sehol (movie)",
		["Name"] = "EnvironmentSmokeBackground",
		["Type"] = "Particle",
	},
	[146] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "smoke_giant_v3.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_big_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol (movie)",
		["Name"] = "MoreRealGiantSmoke",
		["Type"] = "Effect",
	},
	[147] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_smoke_white.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_smoke.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "smokefire efx landfortoknal",
		["Name"] = "WreckSmoke",
		["Type"] = "Effect",
	},
	[148] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_damage_fire.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = true,
			["PitchRnd"] = 0.1,
			["Sample"] = "environment_small_fire.fsb",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "WreckFire",
		["Type"] = "Effect",
	},
	[149] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_engine_smoke_big.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default nagy hajo fust",
		["Name"] = "SmokeBigShipEngine",
		["Type"] = "Particle",
	},
	[150] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_engine_smoke_medium.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default kozepes hajo fust",
		["Name"] = "SmokeMediumShipEngine",
		["Type"] = "Particle",
	},
	[151] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_engine_smoke_small.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default kicsi ajo fust",
		["Name"] = "SmokeSmallShipEngine",
		["Type"] = "Particle",
	},
	[152] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ship_engine_smoke_boat.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "SmokeSmallBoatEngine",
		["Type"] = "Particle",
	},
	[153] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["HeadRadius"] = 0.25,
			["MaxSegmentNum"] = 200,
			["MinSegmentLength"] = 1,
			["OuterColor"] = 
			{
				[1] = 255,
				[2] = 255,
				[3] = 255,
				[4] = 35,
			},
			["SegmentLifeTime"] = 1.5,
			["TextureName"] = "cloud_snake.dds",
			["Type"] = "Tracer",
			["Width"] = 0.5,
			["WidthSpeed"] = 0.5,
			["WidthSpeedEnd"] = 0.1,
		},
		["Comment"] = "szarnyveg effekt",
		["Name"] = "TracerPlaneWingTip",
		["Type"] = "Tracer",
	},
	[154] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigship/explosion_big_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default innerexplosion effekt - ImpactMediumArmor",
		["Name"] = "ExplosionBigShip",
		["Type"] = "Effect",
	},
	[155] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosiommediumship/explosion_medium_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionmediumsubmairne/explosion_medium_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_ship_small_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_big_onwater_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "kis hajo secondary es inner expl",
		["Name"] = "ExplosionMediumShip",
		["Type"] = "Effect",
	},
	[156] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosiommediumship/explosion_medium_ship",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_big_onwater_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["Autostart"] = true,
			["Gravity"] = 9,
			["MaxLifeTime"] = 7.6,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 25,
			["Range"] = 75,
			["StickyPercent"] = 1,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_big_onwater_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "default structuraldamage effect",
		["Name"] = "SmokeExplosion",
		["Type"] = "Effect",
	},
	[157] = 
	{
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigsubmairne/explosion_big_submairne",
			["SoundType"] = "Underwater",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_underwater_big.pes",
			["Type"] = "Particle",
			["UnderWater"] = true,
		},
		[4] = 
		{
			["Autostart"] = true,
			["Particle"] = "sink_on_water_big_main.pes",
			["Type"] = "Particle",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[6] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[7] = 
		{
			["Autostart"] = true,
			["Particle"] = "sink_on_water_big_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "SubExplosion",
		["Type"] = "Effect",
	},
	[158] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_plane.pes",
			["Type"] = "Particle",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionsmallplane/explosion_small_plane",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "Kis repulo ezzel robban fel",
		["Name"] = "ExplosionSmallPlane",
		["Type"] = "Effect",
	},
	[159] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionkamikaze/explosion_kamikaze",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_plane_ground.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "KAMIKAZE expl ground",
		["Name"] = "SmallPlaneExplosion",
		["Type"] = "Effect",
	},
	[160] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigwater/impact_big_water",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_torpedo_main.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[6] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 120,
			["MaxLifeTime"] = 3,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 1.5,
			["MinSize"] = 0.003,
			["Radius"] = 50,
			["Range"] = 75,
			["StickyPercent"] = 80,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 200,
		},
		[7] = 
		{
			["Amplitude"] = 1,
			["Autostart"] = true,
			["Radius"] = 30,
			["Speed"] = 15,
			["Type"] = "Splash",
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_torpedo_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event kamikaze expl water",
		["Name"] = "SmallPlaneExplosionWater",
		["Type"] = "Effect",
	},
	[161] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/explosion/explosionobject/explosion_object",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_bomb_small.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "New Event gyakori explosion es secondary expl",
		["Name"] = "ObjectExplosion",
		["Type"] = "Effect",
	},
	[162] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionwoodenbuilding/explosion_woodenbuilding",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_building_small.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "epulet expl effekt",
		["Name"] = "ExplosionWoodenBuilding",
		["Type"] = "Effect",
	},
	[163] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigobject/explosion_big_object",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = 
			{
				[1] = "explosion_bomb_big.pes",
				[2] = "explosion_building.pes",
			},
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "epulet expl effekt",
		["Name"] = "BigObjectExplosion",
		["Type"] = "Effect",
	},
	[164] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionconcretebuilding/explosion_concretebuilding",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_building_bunker.pes",
			["Type"] = "Particle",
		},
		[4] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[5] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		["Comment"] = "epulet expl effekt",
		["Name"] = "ExplosionConcreteBuilding",
		["Type"] = "Effect",
	},
	[165] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionkamikaze/explosion_kamikaze",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[2] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_big_onwater_main.pes",
			["Type"] = "Particle",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 200,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[4] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Particle"] = "explosion_big_onwater_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "kamikaze becsapodas",
		["Name"] = "ExplosionKamikazeArmour",
		["Type"] = "Effect",
	},
	[166] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["Sample"] = "planes.fev:planes/impact/impactbigwater/impact_big_water",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_kamikaze_main.pes",
			["Type"] = "Particle",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 100,
			["Strength"] = 0.5,
			["Type"] = "Shake",
		},
		[6] = 
		{
			["Autostart"] = true,
			["PowerType"] = 1,
			["Radius"] = 400,
			["StartMagnitude"] = 1,
			["TimeTotal"] = 0.5,
			["Type"] = "SlopeRumble",
		},
		[7] = 
		{
			["ApplyAtBottomOnly"] = false,
			["Autostart"] = true,
			["Gravity"] = 5,
			["MaxLifeTime"] = 5,
			["MaxSize"] = 0.005,
			["MinLifeTime"] = 2,
			["MinSize"] = 0.003,
			["Radius"] = 100,
			["Range"] = 100,
			["StickyPercent"] = 75,
			["Texture"] = "waterdrops.dds",
			["Type"] = "Waterdrops",
			["WaterdropCount"] = 25,
		},
		[8] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_kamikaze_float.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "New Event kamikaze becsapodas",
		["Name"] = "KamikazeImpactWater",
		["Type"] = "Effect",
	},
	[167] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/explosion/explosionbigplane/explosion_big_plane",
			["SoundType"] = "AirSpecial",
			["Type"] = "Sound",
		},
		[3] = 
		{
			["Autostart"] = true,
			["Persistent"] = false,
			["Radius"] = 555,
			["Strength"] = 3,
			["Type"] = "Shake",
		},
		["Comment"] = "!nem hasznalt sehol (talan kod)",
		["Name"] = "PH_shake",
		["Type"] = "Effect",
	},
	[168] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.1,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.3,
			["Autostart"] = true,
			["Divisions"] = 1,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 0.5,
			["HeadingLines"] = 1,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 4,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.005,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.035,
					[2] = 0.875,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.4,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.3,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 100,
			["FitToWater"] = true,
			["HeadingLength"] = 0.4,
			["HeadingLines"] = 1,
			["HeightScale"] = 0.8,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.6,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.95,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.7,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 0.1,
				},
				[7] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["Lifetime"] = 2,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.005,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.035,
					[2] = 0.875,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.4,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		["Comment"] = "submarine periscope tracer",
		["Name"] = "TracerPeriscopeWake",
		["Type"] = "WaterTracer",
	},
	[169] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0.35,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.45,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["HeadingLength"] = 3,
			["HeadingLines"] = 3,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 15,
			["LineDistance"] = 3,
			["LocalSpace"] = false,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.15625,
				},
				[3] = 
				{
					[1] = 0.09,
					[2] = 0.240625,
				},
				[4] = 
				{
					[1] = 0.2,
					[2] = 0.2625,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0.3,
				},
			},
			["WidthScale"] = 30,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 0.5,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.39,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.68,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.85,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.9,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.78,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.47,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.53,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.9,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.75,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.617,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.2,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1,
			["LineDistance"] = 2,
			["LocalSpace"] = false,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.375,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.625,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.825,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.995,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.9975,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 0.5,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.87,
				},
				[5] = 
				{
					[1] = 0.5,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.6875,
					[2] = 0.6,
				},
				[7] = 
				{
					[1] = 0.75,
					[2] = 0.45,
				},
				[8] = 
				{
					[1] = 0.875,
					[2] = 0.15,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.083,
					[2] = 0.183,
				},
				[3] = 
				{
					[1] = 0.17,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.25,
					[2] = 0.717,
				},
				[5] = 
				{
					[1] = 0.417,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.583,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.77,
					[2] = 0.617,
				},
				[8] = 
				{
					[1] = 0.83,
					[2] = 0.43,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1,
			["LineDistance"] = 2,
			["LocalSpace"] = false,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.66,
				},
				[5] = 
				{
					[1] = 0.625,
					[2] = 0.792,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0.8,
				},
			},
			["WidthScale"] = 8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteDestroyerBowWave",
		["Type"] = "WaterTracer",
	},
	[170] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.85,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.8,
					[2] = 0,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["HeadingLength"] = 2,
			["HeadingLines"] = 2,
			["HeightScale"] = 1.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.7,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0.035,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.9,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 0.6,
				},
				[9] = 
				{
					[1] = 0.8,
					[2] = 0.35,
				},
				[10] = 
				{
					[1] = 0.9,
					[2] = 0.15,
				},
				[11] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1.5,
			["LineDistance"] = 1,
			["LocalSpace"] = false,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.21,
				},
				[2] = 
				{
					[1] = 0.1248,
					[2] = 0.4025,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.49,
				},
				[4] = 
				{
					[1] = 0.373,
					[2] = 0.5418,
				},
				[5] = 
				{
					[1] = 0.624,
					[2] = 0.62496,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0.63,
				},
			},
			["WidthScale"] = 12.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.3,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["FullLines"] = 5,
			["HeadingLength"] = 15,
			["HeadingLines"] = 3,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 32,
			["LineDistance"] = 8,
			["LocalSpace"] = false,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.12,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.192,
				},
				[4] = 
				{
					[1] = 0.0234,
					[2] = 0.27,
				},
				[5] = 
				{
					[1] = 0.035,
					[2] = 0.2856,
				},
				[6] = 
				{
					[1] = 0.047,
					[2] = 0.2912,
				},
				[7] = 
				{
					[1] = 0.07,
					[2] = 0.296,
				},
				[8] = 
				{
					[1] = 0.117,
					[2] = 0.304,
				},
			},
			["WidthScale"] = 25,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.1,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteDestroyerSternWave",
		["Type"] = "WaterTracer",
	},
	[171] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.85,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 8,
			["HeadingLength"] = 3,
			["HeadingLines"] = 3,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 50,
			["LineDistance"] = 6,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.13,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 0.23,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 0.3,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 0.35,
				},
				[6] = 
				{
					[1] = 0.07,
					[2] = 0.43,
				},
				[7] = 
				{
					[1] = 0.13,
					[2] = 0.51,
				},
				[9] = 
				{
					[1] = 0.24,
					[2] = 0.58,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0.58,
				},
			},
			["WidthScale"] = 45,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.1,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.9,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 3.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.62,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.8,
				},
				[5] = 
				{
					[1] = 0.46,
					[2] = 0.875,
				},
				[6] = 
				{
					[1] = 0.6,
					[2] = 0.68,
				},
				[7] = 
				{
					[1] = 0.7,
					[2] = 0.4,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.2,
				},
				[9] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.656,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.86,
				},
				[5] = 
				{
					[1] = 0.46,
					[2] = 0.93,
				},
				[6] = 
				{
					[1] = 0.6,
					[2] = 0.7,
				},
				[7] = 
				{
					[1] = 0.7,
					[2] = 0.45,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.19,
				},
				[9] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 2.5,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.25,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.56,
				},
				[5] = 
				{
					[1] = 0.46,
					[2] = 0.68,
				},
				[6] = 
				{
					[1] = 0.6,
					[2] = 0.75,
				},
				[7] = 
				{
					[1] = 0.7,
					[2] = 0.8,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.88,
				},
				[9] = 
				{
					[1] = 0.9,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 18,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.3,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.8,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = true,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
			},
			["HeightY"] = 
			{
			},
			["Lifetime"] = 22,
			["LineDistance"] = 2,
			["LocalSpace"] = true,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.31,
				},
				[3] = 
				{
					[1] = 0.13,
					[2] = 0.59,
				},
				[4] = 
				{
					[1] = 0.23,
					[2] = 0.78,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 0.54,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.68,
					[2] = 0.96,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.86,
				},
				[9] = 
				{
					[1] = 0.9,
					[2] = 0.74,
				},
				[10] = 
				{
					[1] = 1,
					[2] = 0.59,
				},
			},
			["WidthScale"] = 30,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteBattleshipBowWave",
		["Type"] = "WaterTracer",
	},
	[172] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.6,
				},
				[4] = 
				{
					[1] = 0.8,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.3,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["FullLines"] = 8,
			["HeadingLength"] = 20,
			["HeadingLines"] = 3,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.6,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.95,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.7,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 0.1,
				},
				[7] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["Lifetime"] = 30,
			["LineDistance"] = 7,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.063,
				},
				[2] = 
				{
					[1] = 0.011,
					[2] = 0.135,
				},
				[3] = 
				{
					[1] = 0.022,
					[2] = 0.19,
				},
				[4] = 
				{
					[1] = 0.033,
					[2] = 0.23,
				},
				[5] = 
				{
					[1] = 0.049,
					[2] = 0.266,
				},
				[6] = 
				{
					[1] = 0.066,
					[2] = 0.288,
				},
				[7] = 
				{
					[1] = 0.99,
					[2] = 1,
				},
			},
			["WidthScale"] = 70,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.1,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteBattleshipSternWave",
		["Type"] = "WaterTracer",
	},
	[173] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.8,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.85,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 3,
			["HeadingLines"] = 3,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 16,
			["LineDistance"] = 4,
			["LocalSpace"] = true,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.02,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.09,
					[2] = 0.358,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.56,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.65,
				},
			},
			["WidthScale"] = 22,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.1,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.9,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.39,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.87,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.9,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.69,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.4,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.2,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.37,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.78,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 1.02,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 1.05,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.917,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.65,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.33,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.13,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["Lifetime"] = 2,
			["LineDistance"] = 2,
			["LocalSpace"] = true,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.257,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.567,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.68,
				},
				[6] = 
				{
					[1] = 0.55,
					[2] = 0.75,
				},
				[7] = 
				{
					[1] = 0.66,
					[2] = 0.8,
				},
				[8] = 
				{
					[1] = 0.77,
					[2] = 0.9,
				},
				[9] = 
				{
					[1] = 0.88,
					[2] = 0.95,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 1,
				},
			},
			["WidthScale"] = 10,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.9,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.87,
				},
				[5] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.6875,
					[2] = 0.8,
				},
				[7] = 
				{
					[1] = 0.75,
					[2] = 0.25,
				},
				[8] = 
				{
					[1] = 0.875,
					[2] = 0.05,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.083,
					[2] = 0.283,
				},
				[3] = 
				{
					[1] = 0.17,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.25,
					[2] = 0.917,
				},
				[5] = 
				{
					[1] = 0.417,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.583,
					[2] = 0.917,
				},
				[7] = 
				{
					[1] = 0.75,
					[2] = 0.33,
				},
				[8] = 
				{
					[1] = 0.83,
					[2] = 0.13,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 2,
			["LineDistance"] = 2,
			["LocalSpace"] = true,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.09375,
					[2] = 0.257,
				},
				[3] = 
				{
					[1] = 0.1875,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.28125,
					[2] = 0.567,
				},
				[5] = 
				{
					[1] = 0.46875,
					[2] = 0.68,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 10,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteCruiserBowWave",
		["Type"] = "WaterTracer",
	},
	[174] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.3,
					[2] = 0.2,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["FullLines"] = 5,
			["HeadingLength"] = 15,
			["HeadingLines"] = 3,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 80,
			["LineDistance"] = 8,
			["LocalSpace"] = false,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.12,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.192,
				},
				[4] = 
				{
					[1] = 0.0234,
					[2] = 0.27,
				},
				[5] = 
				{
					[1] = 0.035,
					[2] = 0.2856,
				},
				[6] = 
				{
					[1] = 0.047,
					[2] = 0.2912,
				},
				[7] = 
				{
					[1] = 0.07,
					[2] = 0.296,
				},
				[8] = 
				{
					[1] = 0.117,
					[2] = 0.304,
				},
			},
			["WidthScale"] = 30,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.1,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteCruiserSternWave",
		["Type"] = "WaterTracer",
	},
	[175] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.7,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 15,
			["HeadingLines"] = 3,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 30,
			["LineDistance"] = 6,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.0425,
					[2] = 0.53,
				},
				[3] = 
				{
					[1] = 0.125,
					[2] = 0.625,
				},
				[4] = 
				{
					[1] = 0.2375,
					[2] = 0.825,
				},
				[5] = 
				{
					[1] = 0.3125,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 15,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.7,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 8,
			["HeadingLines"] = 2,
			["HeightScale"] = 1.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1.5,
			["LineDistance"] = 5,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.375,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.625,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.825,
				},
				[5] = 
				{
					[1] = 0.625,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.9,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 1.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.87,
				},
				[5] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.6875,
					[2] = 0.8,
				},
				[7] = 
				{
					[1] = 0.75,
					[2] = 0.25,
				},
				[8] = 
				{
					[1] = 0.875,
					[2] = 0.05,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.083,
					[2] = 0.283,
				},
				[3] = 
				{
					[1] = 0.17,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.25,
					[2] = 0.917,
				},
				[5] = 
				{
					[1] = 0.417,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.583,
					[2] = 0.917,
				},
				[7] = 
				{
					[1] = 0.75,
					[2] = 0.33,
				},
				[8] = 
				{
					[1] = 0.83,
					[2] = 0.13,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1.5,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.3,
				},
				[2] = 
				{
					[1] = 0.125,
					[2] = 0.375,
				},
				[3] = 
				{
					[1] = 0.25,
					[2] = 0.625,
				},
				[4] = 
				{
					[1] = 0.375,
					[2] = 0.825,
				},
				[5] = 
				{
					[1] = 0.625,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteJapLandingBowWave",
		["Type"] = "WaterTracer",
	},
	[176] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.6,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.85,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 15,
			["HeadingLines"] = 3,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 24,
			["LineDistance"] = 6,
			["LocalSpace"] = true,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.044,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.015,
					[2] = 0.17,
				},
				[3] = 
				{
					[1] = 0.03,
					[2] = 0.27,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.38,
				},
				[5] = 
				{
					[1] = 0.085,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 0.125,
					[2] = 0.6,
				},
				[7] = 
				{
					[1] = 2,
					[2] = 0.73,
				},
				[8] = 
				{
					[1] = 0.3125,
					[2] = 0.83,
				},
				[9] = 
				{
					[1] = 0.45,
					[2] = 0.9,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0.9,
				},
			},
			["WidthScale"] = 30,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[3] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 3.25,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.18,
				},
				[3] = 
				{
					[1] = 0.125,
					[2] = 0.38,
				},
				[4] = 
				{
					[1] = 0.25,
					[2] = 0.6,
				},
				[5] = 
				{
					[1] = 0.375,
					[2] = 0.69,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.7,
				},
				[7] = 
				{
					[1] = 0.62,
					[2] = 0.54,
				},
				[8] = 
				{
					[1] = 0.75,
					[2] = 0.27,
				},
				[9] = 
				{
					[1] = 0.875,
					[2] = 0.07,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.083,
					[2] = 0.32,
				},
				[3] = 
				{
					[1] = 0.17,
					[2] = 0.64,
				},
				[4] = 
				{
					[1] = 0.24,
					[2] = 0.85,
				},
				[5] = 
				{
					[1] = 0.32,
					[2] = 0.96,
				},
				[6] = 
				{
					[1] = 0.4,
					[2] = 0.99,
				},
				[7] = 
				{
					[1] = 0.55,
					[2] = 0.78,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.83,
					[2] = 0.2,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["Lifetime"] = 2.5,
			["LineDistance"] = 2,
			["LocalSpace"] = true,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.09375,
					[2] = 0.257,
				},
				[3] = 
				{
					[1] = 0.1875,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.28125,
					[2] = 0.567,
				},
				[5] = 
				{
					[1] = 0.46875,
					[2] = 0.68,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 15.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.6,
					[2] = 0.8,
				},
				[3] = 
				{
					[1] = 0.7,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 3.25,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.18,
				},
				[3] = 
				{
					[1] = 0.125,
					[2] = 0.38,
				},
				[4] = 
				{
					[1] = 0.25,
					[2] = 0.6,
				},
				[5] = 
				{
					[1] = 0.375,
					[2] = 0.69,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.7,
				},
				[7] = 
				{
					[1] = 0.62,
					[2] = 0.54,
				},
				[8] = 
				{
					[1] = 0.75,
					[2] = 0.27,
				},
				[9] = 
				{
					[1] = 0.875,
					[2] = 0.07,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.083,
					[2] = 0.32,
				},
				[3] = 
				{
					[1] = 0.17,
					[2] = 0.64,
				},
				[4] = 
				{
					[1] = 0.24,
					[2] = 0.85,
				},
				[5] = 
				{
					[1] = 0.32,
					[2] = 0.96,
				},
				[6] = 
				{
					[1] = 0.4,
					[2] = 0.99,
				},
				[7] = 
				{
					[1] = 0.55,
					[2] = 0.78,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.83,
					[2] = 0.2,
				},
				[10] = 
				{
					[1] = 0.99,
					[2] = 0,
				},
			},
			["Lifetime"] = 2.5,
			["LineDistance"] = 2,
			["LocalSpace"] = true,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.09375,
					[2] = 0.257,
				},
				[3] = 
				{
					[1] = 0.1875,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.28125,
					[2] = 0.567,
				},
				[5] = 
				{
					[1] = 0.46875,
					[2] = 0.68,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 15.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteCargoBowWave",
		["Type"] = "WaterTracer",
	},
	[177] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.15,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.6,
					[2] = 0.02,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["HeadingLength"] = 16,
			["HeadingLines"] = 3,
			["HeightScale"] = 2.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.6,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.95,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.7,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 0.1,
				},
				[7] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["Lifetime"] = 90,
			["LineDistance"] = 3,
			["LocalSpace"] = false,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.044,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.1,
				},
				[2] = 
				{
					[1] = 0.0075,
					[2] = 0.15,
				},
				[3] = 
				{
					[1] = 0.0165,
					[2] = 0.205,
				},
				[4] = 
				{
					[1] = 0.027,
					[2] = 0.25,
				},
				[5] = 
				{
					[1] = 0.0405,
					[2] = 0.28,
				},
				[6] = 
				{
					[1] = 0.0525,
					[2] = 0.3,
				},
				[7] = 
				{
					[1] = 0.99,
					[2] = 0.3,
				},
			},
			["WidthScale"] = 54,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteCargoSternWave",
		["Type"] = "WaterTracer",
	},
	[178] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.4,
			["Autostart"] = true,
			["Divisions"] = 7,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 1.5,
			["HeadingLines"] = 2,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 6,
			["LineDistance"] = 1,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 14,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.02,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["FullLines"] = 10,
			["HeadingLength"] = 1.5,
			["HeadingLines"] = 2,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1.5,
			["LineDistance"] = 1,
			["LOD"] = true,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.45,
				},
				[3] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.4,
					[2] = 0.6,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 13,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.02,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 15,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 1.2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.17,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.78,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.83,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.2,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 0.67,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.28,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 0.5,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.25,
					[2] = 0.67,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.91,
				},
				[4] = 
				{
					[1] = 0.75,
					[2] = 0.99,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.6,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteBoatBowWave",
		["Type"] = "WaterTracer",
	},
	[179] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.8,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["HeadingLength"] = 2,
			["HeadingLines"] = 2,
			["HeightScale"] = 0,
			["HeightX"] = 
			{
			},
			["HeightY"] = 
			{
			},
			["Lifetime"] = 4,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.028,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.33,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.6,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 9,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 6,
			["FadeIn"] = 0.2,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 1.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.4,
				},
				[2] = 
				{
					[1] = 0.4,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 1,
					[2] = -0.05,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.05,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.25,
				},
				[4] = 
				{
					[1] = 0.075,
					[2] = 0.39,
				},
				[5] = 
				{
					[1] = 0.1,
					[2] = 0.35,
				},
				[6] = 
				{
					[1] = 0.15,
					[2] = 0.45,
				},
				[7] = 
				{
					[1] = 0.2,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.4,
					[2] = 0.4,
				},
				[9] = 
				{
					[1] = 0.7,
					[2] = 0.3,
				},
				[10] = 
				{
					[1] = 0.8,
					[2] = 0.175,
				},
				[11] = 
				{
					[1] = 0.9,
					[2] = 0.075,
				},
				[12] = 
				{
					[1] = 1,
					[2] = -0.2,
				},
			},
			["Lifetime"] = 1,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.028,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.4,
					[2] = 0.9,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.6,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[4] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.4,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 2.4,
			["HeadingLines"] = 2,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 6,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = true,
			["ShowForward"] = false,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 14,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteBoatSternWave",
		["Type"] = "WaterTracer",
	},
	[180] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.4,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 1.5,
			["HeadingLines"] = 2,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 4,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.02,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 1.5,
			["HeadingLines"] = 2,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 1.5,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.45,
				},
				[3] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.4,
					[2] = 0.6,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.02,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 15,
			["FadeIn"] = 1,
			["FitToWater"] = false,
			["HeadingLength"] = 1,
			["HeadingLines"] = 1,
			["HeightScale"] = 1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.17,
					[2] = 0.1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.2,
				},
				[4] = 
				{
					[1] = 0.78,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.83,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.1,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.3,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 0.67,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.28,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 0.3,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.67,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.81,
				},
				[4] = 
				{
					[1] = 0.75,
					[2] = 0.99,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 4,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.2,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0,
		},
		["Comment"] = "!nem hasznalt sehol",
		["Name"] = "ObsoleteSmallBoatBowWave",
		["Type"] = "WaterTracer",
	},
	[181] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.7,
				},
				[3] = 
				{
					[1] = 0.8,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 5,
			["FadeIn"] = 0.2,
			["FitToWater"] = true,
			["HeadingLength"] = 2,
			["HeadingLines"] = 2,
			["HeightScale"] = 0.6,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.6,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.95,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.7,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 0.1,
				},
				[7] = 
				{
					[1] = 1,
					[2] = 0.05,
				},
			},
			["Lifetime"] = 2,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.4,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1.2,
				},
			},
			["WidthScale"] = 4,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		["Comment"] = "!csak dutch PT ami nem hasznalt",
		["Name"] = "ObsoleteSmallBoatSternWave",
		["Type"] = "WaterTracer",
	},
	[182] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 22.9,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2183,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.46,
				},
				[3] = 
				{
					[1] = 0.09,
					[2] = 0.83,
				},
				[4] = 
				{
					[1] = 0.14,
					[2] = 1.26,
				},
				[5] = 
				{
					[1] = 0.18,
					[2] = 1.68,
				},
				[6] = 
				{
					[1] = 0.23,
					[2] = 2.03,
				},
				[7] = 
				{
					[1] = 0.27,
					[2] = 2.34,
				},
				[8] = 
				{
					[1] = 0.32,
					[2] = 2.57,
				},
				[9] = 
				{
					[1] = 0.36,
					[2] = 2.71,
				},
				[10] = 
				{
					[1] = 0.41,
					[2] = 2.66,
				},
				[11] = 
				{
					[1] = 0.45,
					[2] = 2.67,
				},
				[12] = 
				{
					[1] = 0.5,
					[2] = 2.65,
				},
				[13] = 
				{
					[1] = 0.55,
					[2] = 2.64,
				},
				[14] = 
				{
					[1] = 0.59,
					[2] = 2.62,
				},
				[15] = 
				{
					[1] = 0.64,
					[2] = 2.59,
				},
				[16] = 
				{
					[1] = 0.68,
					[2] = 2.55,
				},
				[17] = 
				{
					[1] = 0.73,
					[2] = 2.51,
				},
				[18] = 
				{
					[1] = 0.77,
					[2] = 2.46,
				},
				[19] = 
				{
					[1] = 0.82,
					[2] = 2.41,
				},
				[20] = 
				{
					[1] = 0.86,
					[2] = 2.36,
				},
				[21] = 
				{
					[1] = 0.91,
					[2] = 2.31,
				},
				[22] = 
				{
					[1] = 0.95,
					[2] = 2.25,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Lifetime"] = 6.56,
			["LocalSpace"] = false,
			["MaxSpeed"] = 25.722,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureFile2"] = "foamcurve02.dds",
			["TextureRate"] = 0.0372,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.08,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "daihatsu wave",
		["Name"] = "ObsoleteDaihatsuBowWave",
		["Type"] = "WaterTracer",
	},
	[183] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Lifetime"] = 3.56,
			["LocalSpace"] = false,
			["MaxSpeed"] = 25.722,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureFile2"] = "foamcurve02.dds",
			["TextureRate"] = 0.0772,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 4,
			["WidthScale"] = 1.08,
			["WidthScaler"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "daihatsu wave",
		["Name"] = "ObsoleteDaihatsuSternWave",
		["Type"] = "WaterTracer",
	},
	[184] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 1,
			["HeadingLines"] = 2,
			["HeightScale"] = 0.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 3,
			["LineDistance"] = 3,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.025,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.083,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 0.8,
			["HeadingLines"] = 2,
			["HeightScale"] = 1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 0.25,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.6,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 0.85,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 1,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 1,
				},
				[9] = 
				{
					[1] = 0.8,
					[2] = 1,
				},
				[10] = 
				{
					[1] = 0.9,
					[2] = 1,
				},
				[11] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 1.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.7,
				},
				[4] = 
				{
					[1] = 0.9,
					[2] = 0.1,
				},
				[5] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.8,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 10,
			["FitToWater"] = false,
			["HeadingLength"] = 0.5,
			["HeadingLines"] = 1,
			["HeightScale"] = 0.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.17,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.78,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.83,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.2,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 0.67,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.28,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 0.25,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.6,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 0.85,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 1,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 1,
				},
				[9] = 
				{
					[1] = 0.8,
					[2] = 1,
				},
				[10] = 
				{
					[1] = 0.9,
					[2] = 1,
				},
				[11] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 1.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[4] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_farviz_small.pes",
			["Type"] = "Particle",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/splash/splashplanewash/splash_plane_wash",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "flying boat bow wave kicsi",
		["Name"] = "ObsoletePlaneBowWave",
		["Type"] = "WaterTracer",
	},
	[185] = 
	{
		[1] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0.5,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.9,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 1,
			["HeadingLines"] = 2,
			["HeightScale"] = 1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 3,
			["LineDistance"] = 3,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.025,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.083,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 2.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[2] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 0.5,
			["Autostart"] = true,
			["Divisions"] = 3,
			["FadeIn"] = 0.5,
			["FitToWater"] = true,
			["HeadingLength"] = 1.5,
			["HeadingLines"] = 2,
			["HeightScale"] = 1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
			},
			["Lifetime"] = 2.5,
			["LineDistance"] = 2,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.033,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[3] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 4,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[3] = 
		{
			["Alpha"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 1,
				},
				[4] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["AlphaScale"] = 1,
			["Autostart"] = true,
			["Divisions"] = 10,
			["FadeIn"] = 10,
			["FitToWater"] = false,
			["HeadingLength"] = 0.5,
			["HeadingLines"] = 1,
			["HeightScale"] = 1.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.17,
					[2] = 0.35,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.78,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.83,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.2,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 1,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 0.95,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 0.67,
				},
				[8] = 
				{
					[1] = 0.8,
					[2] = 0.28,
				},
				[9] = 
				{
					[1] = 1,
					[2] = 0,
				},
			},
			["Lifetime"] = 0.25,
			["LineDistance"] = 1,
			["LOD"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamship2.dds",
			["TextureRate"] = 0.063,
			["TimeScale"] = 1,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.9,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.95,
				},
				[6] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthScale"] = 2.2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
			["WidthWave"] = 0.05,
		},
		[4] = 
		{
			["Autostart"] = true,
			["Particle"] = "splash_farviz_small.pes",
			["Type"] = "Particle",
		},
		[5] = 
		{
			["Autostart"] = true,
			["Category"] = "3DEffect",
			["Persistent"] = false,
			["PitchRnd"] = 0.1,
			["Sample"] = "planes.fev:planes/splash/splashplanewash/splash_plane_wash",
			["SoundType"] = "Air",
			["Type"] = "Sound",
		},
		["Comment"] = "flying boat bow wave nagy",
		["Name"] = "ObsoletePlaneBowWaveLarge",
		["Type"] = "WaterTracer",
	},
	[186] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 800000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
					["TextureName2"] = "streaks1.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunDayTime",
		["Type"] = "Flare",
	},
	[187] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 215,
						[3] = 96,
						[4] = 0,
					},
					["Color2"] = 
					{
						[1] = 255,
						[2] = 80,
						[3] = 0,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 800000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
					["TextureName2"] = "streaks1.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunRise",
		["Type"] = "Flare",
	},
	[188] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "glow3.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 800000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunGlow",
		["Type"] = "Flare",
	},
	[189] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 800000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
					["TextureName2"] = "streaks1.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunBlue",
		["Type"] = "Flare",
	},
	[190] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 600000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunEveningTime",
		["Type"] = "Flare",
	},
	[191] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 600000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunOvercastWeather",
		["Type"] = "Flare",
	},
	[192] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ElementTable"] = 
			{
				[1] = 
				{
					["Color"] = 
					{
						[1] = 100,
						[2] = 100,
						[3] = 100,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 490000,
						["Y"] = 490000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 450000,
						["Y"] = 450000,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 0,
						["Y"] = 0,
					},
					["State"] = "WORLDSPACE",
					["TextureName"] = "streaks1.dds",
				},
				[2] = 
				{
					["Color"] = 
					{
						[1] = 255,
						[2] = 255,
						[3] = 255,
						[4] = 0,
					},
					["Rotation"] = 0,
					["Scale"] = 
					{
						["X"] = 600000,
						["Y"] = 600000,
					},
					["ScaleBlow"] = true,
					["ScaleDamp"] = 
					{
						["X"] = 40,
						["Y"] = 40,
					},
					["ScaleSpeed"] = 
					{
						["X"] = 1.5,
						["Y"] = 1.5,
					},
					["State"] = "FOREGROUNDSPRITE",
					["TextureName"] = "glow3.dds",
				},
			},
			["FarPlaneClip"] = false,
			["Type"] = "Flare",
		},
		["Comment"] = "nap effekt",
		["Name"] = "SunFilmyWeather",
		["Type"] = "Flare",
	},
	[193] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ParamsTable"] = 
			{
				["GlowTexture"] = "villam_glow_01.dds",
				["Has3Dlightning"] = true,
				["MaxLifeTime"] = 4,
				["MaxScale"] = 635,
				["MaxSpawnCount"] = 15,
				["MinLifeTime"] = 0.5,
				["MinScale"] = 320,
				["SpawnDelay"] = 1,
				["Textures"] = 
				{
					[1] = 
					{
						["Name"] = "villam01.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[2] = 
					{
						["Name"] = "villam02.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[3] = 
					{
						["Name"] = "villam03.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[4] = 
					{
						["Name"] = "villam04.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[5] = 
					{
						["Name"] = "villam05.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[6] = 
					{
						["Name"] = "villam06.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
				},
			},
			["Type"] = "ThunderStorm",
		},
		["Comment"] = "!vihar UJ nem regi!",
		["Name"] = "ObsoleteStorm01",
		["Type"] = "ThunderStorm",
	},
	[194] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["ParamsTable"] = 
			{
				["GlowTexture"] = "villam_glow_01.dds",
				["Has3Dlightning"] = false,
				["MaxLifeTime"] = 4,
				["MaxScale"] = 635,
				["MaxSpawnCount"] = 15,
				["MinLifeTime"] = 0.5,
				["MinScale"] = 320,
				["SpawnDelay"] = 1,
				["Textures"] = 
				{
					[1] = 
					{
						["Name"] = "villam01.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[2] = 
					{
						["Name"] = "villam02.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[3] = 
					{
						["Name"] = "villam03.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[4] = 
					{
						["Name"] = "villam04.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[5] = 
					{
						["Name"] = "villam05.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
					[6] = 
					{
						["Name"] = "villam06.dds",
						["Origo"] = 
						{
							[1] = 0.32,
							[2] = 0.05,
						},
					},
				},
			},
			["Type"] = "ThunderStorm",
		},
		["Comment"] = "!vihar UJ nem regi!",
		["Name"] = "ObsoleteStorm02",
		["Type"] = "ThunderStorm",
	},
	[196] = 
	{
		[1] = 
		{
			["Autostart"] = true,
			["Particle"] = "ps2_test.pes",
			["Type"] = "Particle",
		},
		["Comment"] = "!nem hasznalt sehol (ps2 maradvany?)",
		["Name"] = "ObsoleteTest_effect",
		["Type"] = "Particle",
	},
	[197] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 247.300003,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0202,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.98,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.29,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1.58,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.88,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 2.17,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 2.47,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 2.74,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 3.01,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 3.29,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 3.58,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 3.88,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 4.17,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 4.47,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 4.76,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 5.03,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 5.3,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 5.57,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 5.83,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 6.1,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 6.36,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 6.63,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 6.88,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 7.03,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 7.18,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 7.32,
				},
				[27] = 
				{
					[1] = 0.11,
					[2] = 7.5,
				},
				[28] = 
				{
					[1] = 0.11,
					[2] = 7.69,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 7.88,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 8.06,
				},
				[31] = 
				{
					[1] = 0.12,
					[2] = 8.25,
				},
				[32] = 
				{
					[1] = 0.13,
					[2] = 8.44,
				},
				[33] = 
				{
					[1] = 0.13,
					[2] = 8.61,
				},
				[34] = 
				{
					[1] = 0.13,
					[2] = 8.76,
				},
				[35] = 
				{
					[1] = 0.14,
					[2] = 8.91,
				},
				[36] = 
				{
					[1] = 0.14,
					[2] = 9.06,
				},
				[37] = 
				{
					[1] = 0.15,
					[2] = 9.21,
				},
				[38] = 
				{
					[1] = 0.15,
					[2] = 9.36,
				},
				[39] = 
				{
					[1] = 0.15,
					[2] = 9.51,
				},
				[40] = 
				{
					[1] = 0.16,
					[2] = 9.66,
				},
				[41] = 
				{
					[1] = 0.16,
					[2] = 9.82,
				},
				[42] = 
				{
					[1] = 0.17,
					[2] = 9.98,
				},
				[43] = 
				{
					[1] = 0.17,
					[2] = 10.15,
				},
				[44] = 
				{
					[1] = 0.17,
					[2] = 10.32,
				},
				[45] = 
				{
					[1] = 0.18,
					[2] = 10.45,
				},
				[46] = 
				{
					[1] = 0.18,
					[2] = 10.53,
				},
				[47] = 
				{
					[1] = 0.19,
					[2] = 10.62,
				},
				[48] = 
				{
					[1] = 0.19,
					[2] = 10.7,
				},
				[49] = 
				{
					[1] = 0.19,
					[2] = 10.78,
				},
				[50] = 
				{
					[1] = 0.2,
					[2] = 10.86,
				},
				[51] = 
				{
					[1] = 0.2,
					[2] = 10.94,
				},
				[52] = 
				{
					[1] = 0.21,
					[2] = 11.02,
				},
				[53] = 
				{
					[1] = 0.21,
					[2] = 11.11,
				},
				[54] = 
				{
					[1] = 0.21,
					[2] = 11.17,
				},
				[55] = 
				{
					[1] = 0.22,
					[2] = 11.22,
				},
				[56] = 
				{
					[1] = 0.22,
					[2] = 11.27,
				},
				[57] = 
				{
					[1] = 0.23,
					[2] = 11.32,
				},
				[58] = 
				{
					[1] = 0.23,
					[2] = 11.38,
				},
				[59] = 
				{
					[1] = 0.23,
					[2] = 11.46,
				},
				[60] = 
				{
					[1] = 0.24,
					[2] = 11.54,
				},
				[61] = 
				{
					[1] = 0.24,
					[2] = 11.62,
				},
				[62] = 
				{
					[1] = 0.25,
					[2] = 11.7,
				},
				[63] = 
				{
					[1] = 0.25,
					[2] = 11.78,
				},
				[64] = 
				{
					[1] = 0.26,
					[2] = 11.86,
				},
				[65] = 
				{
					[1] = 0.26,
					[2] = 11.94,
				},
				[66] = 
				{
					[1] = 0.26,
					[2] = 12.03,
				},
				[67] = 
				{
					[1] = 0.27,
					[2] = 12.12,
				},
				[68] = 
				{
					[1] = 0.27,
					[2] = 12.22,
				},
				[69] = 
				{
					[1] = 0.28,
					[2] = 12.29,
				},
				[70] = 
				{
					[1] = 0.28,
					[2] = 12.29,
				},
				[71] = 
				{
					[1] = 0.28,
					[2] = 12.3,
				},
				[72] = 
				{
					[1] = 0.29,
					[2] = 12.31,
				},
				[73] = 
				{
					[1] = 0.29,
					[2] = 12.32,
				},
				[74] = 
				{
					[1] = 0.3,
					[2] = 12.32,
				},
				[75] = 
				{
					[1] = 0.3,
					[2] = 12.33,
				},
				[76] = 
				{
					[1] = 0.3,
					[2] = 12.34,
				},
				[77] = 
				{
					[1] = 0.31,
					[2] = 12.35,
				},
				[78] = 
				{
					[1] = 0.31,
					[2] = 12.35,
				},
				[79] = 
				{
					[1] = 0.32,
					[2] = 12.36,
				},
				[80] = 
				{
					[1] = 0.32,
					[2] = 12.37,
				},
				[81] = 
				{
					[1] = 0.32,
					[2] = 12.38,
				},
				[82] = 
				{
					[1] = 0.33,
					[2] = 12.38,
				},
				[83] = 
				{
					[1] = 0.33,
					[2] = 12.39,
				},
				[84] = 
				{
					[1] = 0.34,
					[2] = 12.4,
				},
				[85] = 
				{
					[1] = 0.34,
					[2] = 12.4,
				},
				[86] = 
				{
					[1] = 0.34,
					[2] = 12.41,
				},
				[87] = 
				{
					[1] = 0.35,
					[2] = 12.42,
				},
				[88] = 
				{
					[1] = 0.35,
					[2] = 12.43,
				},
				[89] = 
				{
					[1] = 0.36,
					[2] = 12.43,
				},
				[90] = 
				{
					[1] = 0.36,
					[2] = 12.44,
				},
				[91] = 
				{
					[1] = 0.36,
					[2] = 12.45,
				},
				[92] = 
				{
					[1] = 0.37,
					[2] = 12.46,
				},
				[93] = 
				{
					[1] = 0.37,
					[2] = 12.48,
				},
				[94] = 
				{
					[1] = 0.38,
					[2] = 12.49,
				},
				[95] = 
				{
					[1] = 0.38,
					[2] = 12.5,
				},
				[96] = 
				{
					[1] = 0.38,
					[2] = 12.52,
				},
				[97] = 
				{
					[1] = 0.39,
					[2] = 12.53,
				},
				[98] = 
				{
					[1] = 0.39,
					[2] = 12.55,
				},
				[99] = 
				{
					[1] = 0.4,
					[2] = 12.56,
				},
				[100] = 
				{
					[1] = 0.4,
					[2] = 12.57,
				},
				[101] = 
				{
					[1] = 0.4,
					[2] = 12.59,
				},
				[102] = 
				{
					[1] = 0.41,
					[2] = 12.6,
				},
				[103] = 
				{
					[1] = 0.41,
					[2] = 12.61,
				},
				[104] = 
				{
					[1] = 0.42,
					[2] = 12.61,
				},
				[105] = 
				{
					[1] = 0.42,
					[2] = 12.62,
				},
				[106] = 
				{
					[1] = 0.43,
					[2] = 12.62,
				},
				[107] = 
				{
					[1] = 0.43,
					[2] = 12.62,
				},
				[108] = 
				{
					[1] = 0.43,
					[2] = 12.63,
				},
				[109] = 
				{
					[1] = 0.44,
					[2] = 12.63,
				},
				[110] = 
				{
					[1] = 0.44,
					[2] = 12.64,
				},
				[111] = 
				{
					[1] = 0.45,
					[2] = 12.64,
				},
				[112] = 
				{
					[1] = 0.45,
					[2] = 12.64,
				},
				[113] = 
				{
					[1] = 0.45,
					[2] = 12.65,
				},
				[114] = 
				{
					[1] = 0.46,
					[2] = 12.65,
				},
				[115] = 
				{
					[1] = 0.46,
					[2] = 12.66,
				},
				[116] = 
				{
					[1] = 0.47,
					[2] = 12.66,
				},
				[117] = 
				{
					[1] = 0.47,
					[2] = 12.66,
				},
				[118] = 
				{
					[1] = 0.47,
					[2] = 12.67,
				},
				[119] = 
				{
					[1] = 0.48,
					[2] = 12.67,
				},
				[120] = 
				{
					[1] = 0.48,
					[2] = 12.67,
				},
				[121] = 
				{
					[1] = 0.49,
					[2] = 12.67,
				},
				[122] = 
				{
					[1] = 0.49,
					[2] = 12.67,
				},
				[123] = 
				{
					[1] = 0.49,
					[2] = 12.67,
				},
				[124] = 
				{
					[1] = 0.5,
					[2] = 12.68,
				},
				[125] = 
				{
					[1] = 0.5,
					[2] = 12.68,
				},
				[126] = 
				{
					[1] = 0.51,
					[2] = 12.68,
				},
				[127] = 
				{
					[1] = 0.51,
					[2] = 12.68,
				},
				[128] = 
				{
					[1] = 0.51,
					[2] = 12.68,
				},
				[129] = 
				{
					[1] = 0.52,
					[2] = 12.69,
				},
				[130] = 
				{
					[1] = 0.52,
					[2] = 12.69,
				},
				[131] = 
				{
					[1] = 0.53,
					[2] = 12.69,
				},
				[132] = 
				{
					[1] = 0.53,
					[2] = 12.69,
				},
				[133] = 
				{
					[1] = 0.53,
					[2] = 12.69,
				},
				[134] = 
				{
					[1] = 0.54,
					[2] = 12.7,
				},
				[135] = 
				{
					[1] = 0.54,
					[2] = 12.7,
				},
				[136] = 
				{
					[1] = 0.55,
					[2] = 12.7,
				},
				[137] = 
				{
					[1] = 0.55,
					[2] = 12.7,
				},
				[138] = 
				{
					[1] = 0.55,
					[2] = 12.7,
				},
				[139] = 
				{
					[1] = 0.56,
					[2] = 12.7,
				},
				[140] = 
				{
					[1] = 0.56,
					[2] = 12.71,
				},
				[141] = 
				{
					[1] = 0.57,
					[2] = 12.73,
				},
				[142] = 
				{
					[1] = 0.57,
					[2] = 12.76,
				},
				[143] = 
				{
					[1] = 0.57,
					[2] = 12.78,
				},
				[144] = 
				{
					[1] = 0.58,
					[2] = 12.8,
				},
				[145] = 
				{
					[1] = 0.58,
					[2] = 12.82,
				},
				[146] = 
				{
					[1] = 0.59,
					[2] = 12.85,
				},
				[147] = 
				{
					[1] = 0.59,
					[2] = 12.87,
				},
				[148] = 
				{
					[1] = 0.6,
					[2] = 12.89,
				},
				[149] = 
				{
					[1] = 0.6,
					[2] = 12.92,
				},
				[150] = 
				{
					[1] = 0.6,
					[2] = 12.94,
				},
				[151] = 
				{
					[1] = 0.61,
					[2] = 12.96,
				},
				[152] = 
				{
					[1] = 0.61,
					[2] = 12.98,
				},
				[153] = 
				{
					[1] = 0.62,
					[2] = 12.99,
				},
				[154] = 
				{
					[1] = 0.62,
					[2] = 13,
				},
				[155] = 
				{
					[1] = 0.62,
					[2] = 13,
				},
				[156] = 
				{
					[1] = 0.63,
					[2] = 13.01,
				},
				[157] = 
				{
					[1] = 0.63,
					[2] = 13.01,
				},
				[158] = 
				{
					[1] = 0.64,
					[2] = 13.02,
				},
				[159] = 
				{
					[1] = 0.64,
					[2] = 13.02,
				},
				[160] = 
				{
					[1] = 0.64,
					[2] = 13.02,
				},
				[161] = 
				{
					[1] = 0.65,
					[2] = 13.02,
				},
				[162] = 
				{
					[1] = 0.65,
					[2] = 13.03,
				},
				[163] = 
				{
					[1] = 0.66,
					[2] = 13.03,
				},
				[164] = 
				{
					[1] = 0.66,
					[2] = 13.03,
				},
				[165] = 
				{
					[1] = 0.66,
					[2] = 13.03,
				},
				[166] = 
				{
					[1] = 0.67,
					[2] = 13.03,
				},
				[167] = 
				{
					[1] = 0.67,
					[2] = 13.02,
				},
				[168] = 
				{
					[1] = 0.68,
					[2] = 13.02,
				},
				[169] = 
				{
					[1] = 0.68,
					[2] = 13.01,
				},
				[170] = 
				{
					[1] = 0.68,
					[2] = 13.01,
				},
				[171] = 
				{
					[1] = 0.69,
					[2] = 13.01,
				},
				[172] = 
				{
					[1] = 0.69,
					[2] = 13.01,
				},
				[173] = 
				{
					[1] = 0.7,
					[2] = 13.01,
				},
				[174] = 
				{
					[1] = 0.7,
					[2] = 13,
				},
				[175] = 
				{
					[1] = 0.7,
					[2] = 13,
				},
				[176] = 
				{
					[1] = 0.71,
					[2] = 13,
				},
				[177] = 
				{
					[1] = 0.71,
					[2] = 13.01,
				},
				[178] = 
				{
					[1] = 0.72,
					[2] = 13.01,
				},
				[179] = 
				{
					[1] = 0.72,
					[2] = 13.02,
				},
				[180] = 
				{
					[1] = 0.72,
					[2] = 12.98,
				},
				[181] = 
				{
					[1] = 0.73,
					[2] = 12.89,
				},
				[182] = 
				{
					[1] = 0.73,
					[2] = 12.8,
				},
				[183] = 
				{
					[1] = 0.74,
					[2] = 12.71,
				},
				[184] = 
				{
					[1] = 0.74,
					[2] = 12.62,
				},
				[185] = 
				{
					[1] = 0.74,
					[2] = 12.53,
				},
				[186] = 
				{
					[1] = 0.75,
					[2] = 12.45,
				},
				[187] = 
				{
					[1] = 0.75,
					[2] = 12.36,
				},
				[188] = 
				{
					[1] = 0.76,
					[2] = 12.27,
				},
				[189] = 
				{
					[1] = 0.76,
					[2] = 12.18,
				},
				[190] = 
				{
					[1] = 0.77,
					[2] = 12.07,
				},
				[191] = 
				{
					[1] = 0.77,
					[2] = 11.95,
				},
				[192] = 
				{
					[1] = 0.77,
					[2] = 11.82,
				},
				[193] = 
				{
					[1] = 0.78,
					[2] = 11.7,
				},
				[194] = 
				{
					[1] = 0.78,
					[2] = 11.58,
				},
				[195] = 
				{
					[1] = 0.79,
					[2] = 11.45,
				},
				[196] = 
				{
					[1] = 0.79,
					[2] = 11.33,
				},
				[197] = 
				{
					[1] = 0.79,
					[2] = 11.21,
				},
				[198] = 
				{
					[1] = 0.8,
					[2] = 11.08,
				},
				[199] = 
				{
					[1] = 0.8,
					[2] = 10.96,
				},
				[200] = 
				{
					[1] = 0.81,
					[2] = 10.83,
				},
				[201] = 
				{
					[1] = 0.81,
					[2] = 10.71,
				},
				[202] = 
				{
					[1] = 0.81,
					[2] = 10.66,
				},
				[203] = 
				{
					[1] = 0.82,
					[2] = 10.6,
				},
				[204] = 
				{
					[1] = 0.82,
					[2] = 10.55,
				},
				[205] = 
				{
					[1] = 0.83,
					[2] = 10.49,
				},
				[206] = 
				{
					[1] = 0.83,
					[2] = 10.49,
				},
				[207] = 
				{
					[1] = 0.83,
					[2] = 10.47,
				},
				[208] = 
				{
					[1] = 0.84,
					[2] = 10.36,
				},
				[209] = 
				{
					[1] = 0.84,
					[2] = 10.25,
				},
				[210] = 
				{
					[1] = 0.85,
					[2] = 10.14,
				},
				[211] = 
				{
					[1] = 0.85,
					[2] = 10.04,
				},
				[212] = 
				{
					[1] = 0.85,
					[2] = 9.93,
				},
				[213] = 
				{
					[1] = 0.86,
					[2] = 9.82,
				},
				[214] = 
				{
					[1] = 0.86,
					[2] = 9.71,
				},
				[215] = 
				{
					[1] = 0.87,
					[2] = 9.6,
				},
				[216] = 
				{
					[1] = 0.87,
					[2] = 9.47,
				},
				[217] = 
				{
					[1] = 0.87,
					[2] = 9.35,
				},
				[218] = 
				{
					[1] = 0.88,
					[2] = 9.23,
				},
				[219] = 
				{
					[1] = 0.88,
					[2] = 9.09,
				},
				[220] = 
				{
					[1] = 0.89,
					[2] = 8.93,
				},
				[221] = 
				{
					[1] = 0.89,
					[2] = 8.77,
				},
				[222] = 
				{
					[1] = 0.89,
					[2] = 8.61,
				},
				[223] = 
				{
					[1] = 0.9,
					[2] = 8.45,
				},
				[224] = 
				{
					[1] = 0.9,
					[2] = 8.28,
				},
				[225] = 
				{
					[1] = 0.91,
					[2] = 8.12,
				},
				[226] = 
				{
					[1] = 0.91,
					[2] = 7.96,
				},
				[227] = 
				{
					[1] = 0.91,
					[2] = 7.79,
				},
				[228] = 
				{
					[1] = 0.92,
					[2] = 7.59,
				},
				[229] = 
				{
					[1] = 0.92,
					[2] = 7.32,
				},
				[230] = 
				{
					[1] = 0.93,
					[2] = 7.05,
				},
				[231] = 
				{
					[1] = 0.93,
					[2] = 6.78,
				},
				[232] = 
				{
					[1] = 0.94,
					[2] = 6.54,
				},
				[233] = 
				{
					[1] = 0.94,
					[2] = 6.29,
				},
				[234] = 
				{
					[1] = 0.94,
					[2] = 6.05,
				},
				[235] = 
				{
					[1] = 0.95,
					[2] = 5.81,
				},
				[236] = 
				{
					[1] = 0.95,
					[2] = 5.57,
				},
				[237] = 
				{
					[1] = 0.96,
					[2] = 5.33,
				},
				[238] = 
				{
					[1] = 0.96,
					[2] = 4.96,
				},
				[239] = 
				{
					[1] = 0.96,
					[2] = 4.7,
				},
				[240] = 
				{
					[1] = 0.97,
					[2] = 4.44,
				},
				[241] = 
				{
					[1] = 0.97,
					[2] = 4.19,
				},
				[242] = 
				{
					[1] = 0.98,
					[2] = 3.97,
				},
				[243] = 
				{
					[1] = 0.98,
					[2] = 3.76,
				},
				[244] = 
				{
					[1] = 0.98,
					[2] = 3.54,
				},
				[245] = 
				{
					[1] = 0.99,
					[2] = 3.33,
				},
				[246] = 
				{
					[1] = 0.99,
					[2] = 3.12,
				},
				[247] = 
				{
					[1] = 1,
					[2] = 2.91,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.2,
				},
				[3] = 
				{
					[1] = 0.03,
					[2] = 0.27,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.32,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.36,
				},
				[6] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[7] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[8] = 
				{
					[1] = 0.11,
					[2] = 0.44,
				},
				[9] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[10] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[11] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[12] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[18] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[19] = 
				{
					[1] = 0.3,
					[2] = 0.5,
				},
				[20] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[21] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[22] = 
				{
					[1] = 0.34,
					[2] = 0.48,
				},
				[23] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[24] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[25] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[26] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[27] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[28] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[29] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[30] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[31] = 
				{
					[1] = 0.49,
					[2] = 0.4,
				},
				[32] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[33] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[34] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[35] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[36] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[37] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[38] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[39] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[40] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[41] = 
				{
					[1] = 0.66,
					[2] = 0.28,
				},
				[42] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[43] = 
				{
					[1] = 0.69,
					[2] = 0.26,
				},
				[44] = 
				{
					[1] = 0.7,
					[2] = 0.24,
				},
				[45] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[46] = 
				{
					[1] = 0.74,
					[2] = 0.22,
				},
				[47] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[48] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[49] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[50] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[51] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[52] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[53] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[54] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[55] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[56] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[57] = 
				{
					[1] = 0.92,
					[2] = 0.07,
				},
				[58] = 
				{
					[1] = 0.93,
					[2] = 0.05,
				},
				[59] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[60] = 
				{
					[1] = 0.97,
					[2] = 0.03,
				},
				[61] = 
				{
					[1] = 0.98,
					[2] = 0.01,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 17.1,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 1.41,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.46,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1.52,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 1.58,
				},
				[6] = 
				{
					[1] = 0.01,
					[2] = 1.64,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 1.7,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 1.76,
				},
				[9] = 
				{
					[1] = 0.02,
					[2] = 1.82,
				},
				[10] = 
				{
					[1] = 0.02,
					[2] = 1.88,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 1.93,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 1.99,
				},
				[13] = 
				{
					[1] = 0.03,
					[2] = 2.05,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 2.11,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 2.16,
				},
				[16] = 
				{
					[1] = 0.04,
					[2] = 2.22,
				},
				[17] = 
				{
					[1] = 0.04,
					[2] = 2.28,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 2.33,
				},
				[19] = 
				{
					[1] = 0.05,
					[2] = 2.39,
				},
				[20] = 
				{
					[1] = 0.05,
					[2] = 2.45,
				},
				[21] = 
				{
					[1] = 0.05,
					[2] = 2.5,
				},
				[22] = 
				{
					[1] = 0.06,
					[2] = 2.55,
				},
				[23] = 
				{
					[1] = 0.06,
					[2] = 2.61,
				},
				[24] = 
				{
					[1] = 0.06,
					[2] = 2.66,
				},
				[25] = 
				{
					[1] = 0.06,
					[2] = 2.72,
				},
				[26] = 
				{
					[1] = 0.07,
					[2] = 2.77,
				},
				[27] = 
				{
					[1] = 0.07,
					[2] = 2.82,
				},
				[28] = 
				{
					[1] = 0.07,
					[2] = 2.88,
				},
				[29] = 
				{
					[1] = 0.08,
					[2] = 2.93,
				},
				[30] = 
				{
					[1] = 0.08,
					[2] = 2.98,
				},
				[31] = 
				{
					[1] = 0.08,
					[2] = 3.03,
				},
				[32] = 
				{
					[1] = 0.08,
					[2] = 3.09,
				},
				[33] = 
				{
					[1] = 0.09,
					[2] = 3.14,
				},
				[34] = 
				{
					[1] = 0.09,
					[2] = 3.19,
				},
				[35] = 
				{
					[1] = 0.09,
					[2] = 3.24,
				},
				[36] = 
				{
					[1] = 0.09,
					[2] = 3.29,
				},
				[37] = 
				{
					[1] = 0.1,
					[2] = 3.35,
				},
				[38] = 
				{
					[1] = 0.1,
					[2] = 3.4,
				},
				[39] = 
				{
					[1] = 0.1,
					[2] = 3.45,
				},
				[40] = 
				{
					[1] = 0.11,
					[2] = 3.5,
				},
				[41] = 
				{
					[1] = 0.11,
					[2] = 3.55,
				},
				[42] = 
				{
					[1] = 0.11,
					[2] = 3.6,
				},
				[43] = 
				{
					[1] = 0.11,
					[2] = 3.65,
				},
				[44] = 
				{
					[1] = 0.12,
					[2] = 3.7,
				},
				[45] = 
				{
					[1] = 0.12,
					[2] = 3.75,
				},
				[46] = 
				{
					[1] = 0.12,
					[2] = 3.8,
				},
				[47] = 
				{
					[1] = 0.12,
					[2] = 3.85,
				},
				[48] = 
				{
					[1] = 0.13,
					[2] = 3.9,
				},
				[49] = 
				{
					[1] = 0.13,
					[2] = 3.95,
				},
				[50] = 
				{
					[1] = 0.13,
					[2] = 4,
				},
				[51] = 
				{
					[1] = 0.13,
					[2] = 4.05,
				},
				[52] = 
				{
					[1] = 0.14,
					[2] = 4.1,
				},
				[53] = 
				{
					[1] = 0.14,
					[2] = 4.15,
				},
				[54] = 
				{
					[1] = 0.14,
					[2] = 4.2,
				},
				[55] = 
				{
					[1] = 0.15,
					[2] = 4.25,
				},
				[56] = 
				{
					[1] = 0.15,
					[2] = 4.3,
				},
				[57] = 
				{
					[1] = 0.15,
					[2] = 4.35,
				},
				[58] = 
				{
					[1] = 0.15,
					[2] = 4.39,
				},
				[59] = 
				{
					[1] = 0.16,
					[2] = 4.44,
				},
				[60] = 
				{
					[1] = 0.16,
					[2] = 4.49,
				},
				[61] = 
				{
					[1] = 0.16,
					[2] = 4.54,
				},
				[62] = 
				{
					[1] = 0.16,
					[2] = 4.59,
				},
				[63] = 
				{
					[1] = 0.17,
					[2] = 4.63,
				},
				[64] = 
				{
					[1] = 0.17,
					[2] = 4.67,
				},
				[65] = 
				{
					[1] = 0.17,
					[2] = 4.72,
				},
				[66] = 
				{
					[1] = 0.18,
					[2] = 4.76,
				},
				[67] = 
				{
					[1] = 0.18,
					[2] = 4.8,
				},
				[68] = 
				{
					[1] = 0.18,
					[2] = 4.84,
				},
				[69] = 
				{
					[1] = 0.18,
					[2] = 4.88,
				},
				[70] = 
				{
					[1] = 0.19,
					[2] = 4.92,
				},
				[71] = 
				{
					[1] = 0.19,
					[2] = 4.97,
				},
				[72] = 
				{
					[1] = 0.19,
					[2] = 5.01,
				},
				[73] = 
				{
					[1] = 0.19,
					[2] = 5.05,
				},
				[74] = 
				{
					[1] = 0.2,
					[2] = 5.09,
				},
				[75] = 
				{
					[1] = 0.2,
					[2] = 5.13,
				},
				[76] = 
				{
					[1] = 0.2,
					[2] = 5.17,
				},
				[77] = 
				{
					[1] = 0.2,
					[2] = 5.21,
				},
				[78] = 
				{
					[1] = 0.21,
					[2] = 5.25,
				},
				[79] = 
				{
					[1] = 0.21,
					[2] = 5.29,
				},
				[80] = 
				{
					[1] = 0.21,
					[2] = 5.33,
				},
				[81] = 
				{
					[1] = 0.22,
					[2] = 5.37,
				},
				[82] = 
				{
					[1] = 0.22,
					[2] = 5.41,
				},
				[83] = 
				{
					[1] = 0.22,
					[2] = 5.45,
				},
				[84] = 
				{
					[1] = 0.22,
					[2] = 5.49,
				},
				[85] = 
				{
					[1] = 0.23,
					[2] = 5.53,
				},
				[86] = 
				{
					[1] = 0.23,
					[2] = 5.57,
				},
				[87] = 
				{
					[1] = 0.23,
					[2] = 5.61,
				},
				[88] = 
				{
					[1] = 0.23,
					[2] = 5.65,
				},
				[89] = 
				{
					[1] = 0.24,
					[2] = 5.69,
				},
				[90] = 
				{
					[1] = 0.24,
					[2] = 5.74,
				},
				[91] = 
				{
					[1] = 0.24,
					[2] = 5.78,
				},
				[92] = 
				{
					[1] = 0.25,
					[2] = 5.82,
				},
				[93] = 
				{
					[1] = 0.25,
					[2] = 5.87,
				},
				[94] = 
				{
					[1] = 0.25,
					[2] = 5.91,
				},
				[95] = 
				{
					[1] = 0.25,
					[2] = 5.95,
				},
				[96] = 
				{
					[1] = 0.26,
					[2] = 5.99,
				},
				[97] = 
				{
					[1] = 0.26,
					[2] = 6.03,
				},
				[98] = 
				{
					[1] = 0.26,
					[2] = 6.08,
				},
				[99] = 
				{
					[1] = 0.26,
					[2] = 6.12,
				},
				[100] = 
				{
					[1] = 0.27,
					[2] = 6.16,
				},
				[101] = 
				{
					[1] = 0.27,
					[2] = 6.2,
				},
				[102] = 
				{
					[1] = 0.27,
					[2] = 6.24,
				},
				[103] = 
				{
					[1] = 0.27,
					[2] = 6.28,
				},
				[104] = 
				{
					[1] = 0.28,
					[2] = 6.32,
				},
				[105] = 
				{
					[1] = 0.28,
					[2] = 6.37,
				},
				[106] = 
				{
					[1] = 0.28,
					[2] = 6.41,
				},
				[107] = 
				{
					[1] = 0.29,
					[2] = 6.45,
				},
				[108] = 
				{
					[1] = 0.29,
					[2] = 6.49,
				},
				[109] = 
				{
					[1] = 0.29,
					[2] = 6.53,
				},
				[110] = 
				{
					[1] = 0.29,
					[2] = 6.57,
				},
				[111] = 
				{
					[1] = 0.3,
					[2] = 6.61,
				},
				[112] = 
				{
					[1] = 0.3,
					[2] = 6.65,
				},
				[113] = 
				{
					[1] = 0.3,
					[2] = 6.69,
				},
				[114] = 
				{
					[1] = 0.3,
					[2] = 6.73,
				},
				[115] = 
				{
					[1] = 0.31,
					[2] = 6.76,
				},
				[116] = 
				{
					[1] = 0.31,
					[2] = 6.8,
				},
				[117] = 
				{
					[1] = 0.31,
					[2] = 6.84,
				},
				[118] = 
				{
					[1] = 0.32,
					[2] = 6.88,
				},
				[119] = 
				{
					[1] = 0.32,
					[2] = 6.92,
				},
				[120] = 
				{
					[1] = 0.32,
					[2] = 6.96,
				},
				[121] = 
				{
					[1] = 0.32,
					[2] = 7,
				},
				[122] = 
				{
					[1] = 0.33,
					[2] = 7.03,
				},
				[123] = 
				{
					[1] = 0.33,
					[2] = 7.07,
				},
				[124] = 
				{
					[1] = 0.33,
					[2] = 7.11,
				},
				[125] = 
				{
					[1] = 0.33,
					[2] = 7.15,
				},
				[126] = 
				{
					[1] = 0.34,
					[2] = 7.18,
				},
				[127] = 
				{
					[1] = 0.34,
					[2] = 7.22,
				},
				[128] = 
				{
					[1] = 0.34,
					[2] = 7.26,
				},
				[129] = 
				{
					[1] = 0.35,
					[2] = 7.3,
				},
				[130] = 
				{
					[1] = 0.35,
					[2] = 7.33,
				},
				[131] = 
				{
					[1] = 0.35,
					[2] = 7.37,
				},
				[132] = 
				{
					[1] = 0.35,
					[2] = 7.41,
				},
				[133] = 
				{
					[1] = 0.36,
					[2] = 7.44,
				},
				[134] = 
				{
					[1] = 0.36,
					[2] = 7.48,
				},
				[135] = 
				{
					[1] = 0.36,
					[2] = 7.51,
				},
				[136] = 
				{
					[1] = 0.36,
					[2] = 7.55,
				},
				[137] = 
				{
					[1] = 0.37,
					[2] = 7.59,
				},
				[138] = 
				{
					[1] = 0.37,
					[2] = 7.62,
				},
				[139] = 
				{
					[1] = 0.37,
					[2] = 7.65,
				},
				[140] = 
				{
					[1] = 0.37,
					[2] = 7.69,
				},
				[141] = 
				{
					[1] = 0.38,
					[2] = 7.72,
				},
				[142] = 
				{
					[1] = 0.38,
					[2] = 7.75,
				},
				[143] = 
				{
					[1] = 0.38,
					[2] = 7.78,
				},
				[144] = 
				{
					[1] = 0.39,
					[2] = 7.81,
				},
				[145] = 
				{
					[1] = 0.39,
					[2] = 7.84,
				},
				[146] = 
				{
					[1] = 0.39,
					[2] = 7.87,
				},
				[147] = 
				{
					[1] = 0.39,
					[2] = 7.9,
				},
				[148] = 
				{
					[1] = 0.4,
					[2] = 7.93,
				},
				[149] = 
				{
					[1] = 0.4,
					[2] = 7.96,
				},
				[150] = 
				{
					[1] = 0.4,
					[2] = 7.99,
				},
				[151] = 
				{
					[1] = 0.4,
					[2] = 8.02,
				},
				[152] = 
				{
					[1] = 0.41,
					[2] = 8.05,
				},
				[153] = 
				{
					[1] = 0.41,
					[2] = 8.08,
				},
				[154] = 
				{
					[1] = 0.41,
					[2] = 8.11,
				},
				[155] = 
				{
					[1] = 0.42,
					[2] = 8.14,
				},
				[156] = 
				{
					[1] = 0.42,
					[2] = 8.17,
				},
				[157] = 
				{
					[1] = 0.42,
					[2] = 8.2,
				},
				[158] = 
				{
					[1] = 0.42,
					[2] = 8.23,
				},
				[159] = 
				{
					[1] = 0.43,
					[2] = 8.26,
				},
				[160] = 
				{
					[1] = 0.43,
					[2] = 8.29,
				},
				[161] = 
				{
					[1] = 0.43,
					[2] = 8.32,
				},
				[162] = 
				{
					[1] = 0.43,
					[2] = 8.35,
				},
				[163] = 
				{
					[1] = 0.44,
					[2] = 8.37,
				},
				[164] = 
				{
					[1] = 0.44,
					[2] = 8.4,
				},
				[165] = 
				{
					[1] = 0.44,
					[2] = 8.43,
				},
				[166] = 
				{
					[1] = 0.44,
					[2] = 8.46,
				},
				[167] = 
				{
					[1] = 0.45,
					[2] = 8.48,
				},
				[168] = 
				{
					[1] = 0.45,
					[2] = 8.51,
				},
				[169] = 
				{
					[1] = 0.45,
					[2] = 8.54,
				},
				[170] = 
				{
					[1] = 0.46,
					[2] = 8.56,
				},
				[171] = 
				{
					[1] = 0.46,
					[2] = 8.59,
				},
				[172] = 
				{
					[1] = 0.46,
					[2] = 8.61,
				},
				[173] = 
				{
					[1] = 0.46,
					[2] = 8.64,
				},
				[174] = 
				{
					[1] = 0.47,
					[2] = 8.66,
				},
				[175] = 
				{
					[1] = 0.47,
					[2] = 8.69,
				},
				[176] = 
				{
					[1] = 0.47,
					[2] = 8.71,
				},
				[177] = 
				{
					[1] = 0.47,
					[2] = 8.74,
				},
				[178] = 
				{
					[1] = 0.48,
					[2] = 8.76,
				},
				[179] = 
				{
					[1] = 0.48,
					[2] = 8.79,
				},
				[180] = 
				{
					[1] = 0.48,
					[2] = 8.81,
				},
				[181] = 
				{
					[1] = 0.49,
					[2] = 8.84,
				},
				[182] = 
				{
					[1] = 0.49,
					[2] = 8.86,
				},
				[183] = 
				{
					[1] = 0.49,
					[2] = 8.89,
				},
				[184] = 
				{
					[1] = 0.49,
					[2] = 8.91,
				},
				[185] = 
				{
					[1] = 0.5,
					[2] = 8.93,
				},
				[186] = 
				{
					[1] = 0.5,
					[2] = 8.96,
				},
				[187] = 
				{
					[1] = 0.5,
					[2] = 8.98,
				},
				[188] = 
				{
					[1] = 0.5,
					[2] = 9,
				},
				[189] = 
				{
					[1] = 0.51,
					[2] = 9.03,
				},
				[190] = 
				{
					[1] = 0.51,
					[2] = 9.05,
				},
				[191] = 
				{
					[1] = 0.51,
					[2] = 9.07,
				},
				[192] = 
				{
					[1] = 0.51,
					[2] = 9.1,
				},
				[193] = 
				{
					[1] = 0.52,
					[2] = 9.12,
				},
				[194] = 
				{
					[1] = 0.52,
					[2] = 9.14,
				},
				[195] = 
				{
					[1] = 0.52,
					[2] = 9.16,
				},
				[196] = 
				{
					[1] = 0.53,
					[2] = 9.19,
				},
				[197] = 
				{
					[1] = 0.53,
					[2] = 9.21,
				},
				[198] = 
				{
					[1] = 0.53,
					[2] = 9.23,
				},
				[199] = 
				{
					[1] = 0.53,
					[2] = 9.25,
				},
				[200] = 
				{
					[1] = 0.54,
					[2] = 9.27,
				},
				[201] = 
				{
					[1] = 0.54,
					[2] = 9.29,
				},
				[202] = 
				{
					[1] = 0.54,
					[2] = 9.32,
				},
				[203] = 
				{
					[1] = 0.54,
					[2] = 9.34,
				},
				[204] = 
				{
					[1] = 0.55,
					[2] = 9.36,
				},
				[205] = 
				{
					[1] = 0.55,
					[2] = 9.38,
				},
				[206] = 
				{
					[1] = 0.55,
					[2] = 9.4,
				},
				[207] = 
				{
					[1] = 0.56,
					[2] = 9.42,
				},
				[208] = 
				{
					[1] = 0.56,
					[2] = 9.44,
				},
				[209] = 
				{
					[1] = 0.56,
					[2] = 9.46,
				},
				[210] = 
				{
					[1] = 0.56,
					[2] = 9.48,
				},
				[211] = 
				{
					[1] = 0.57,
					[2] = 9.5,
				},
				[212] = 
				{
					[1] = 0.57,
					[2] = 9.52,
				},
				[213] = 
				{
					[1] = 0.57,
					[2] = 9.54,
				},
				[214] = 
				{
					[1] = 0.57,
					[2] = 9.56,
				},
				[215] = 
				{
					[1] = 0.58,
					[2] = 9.58,
				},
				[216] = 
				{
					[1] = 0.58,
					[2] = 9.6,
				},
				[217] = 
				{
					[1] = 0.58,
					[2] = 9.62,
				},
				[218] = 
				{
					[1] = 0.58,
					[2] = 9.64,
				},
				[219] = 
				{
					[1] = 0.59,
					[2] = 9.66,
				},
				[220] = 
				{
					[1] = 0.59,
					[2] = 9.67,
				},
				[221] = 
				{
					[1] = 0.59,
					[2] = 9.68,
				},
				[222] = 
				{
					[1] = 0.6,
					[2] = 9.68,
				},
				[223] = 
				{
					[1] = 0.6,
					[2] = 9.68,
				},
				[224] = 
				{
					[1] = 0.6,
					[2] = 9.68,
				},
				[225] = 
				{
					[1] = 0.6,
					[2] = 9.68,
				},
				[226] = 
				{
					[1] = 0.61,
					[2] = 9.69,
				},
				[227] = 
				{
					[1] = 0.61,
					[2] = 9.69,
				},
				[228] = 
				{
					[1] = 0.61,
					[2] = 9.69,
				},
				[229] = 
				{
					[1] = 0.61,
					[2] = 9.69,
				},
				[230] = 
				{
					[1] = 0.62,
					[2] = 9.69,
				},
				[231] = 
				{
					[1] = 0.62,
					[2] = 9.7,
				},
				[232] = 
				{
					[1] = 0.62,
					[2] = 9.7,
				},
				[233] = 
				{
					[1] = 0.63,
					[2] = 9.7,
				},
				[234] = 
				{
					[1] = 0.63,
					[2] = 9.7,
				},
				[235] = 
				{
					[1] = 0.63,
					[2] = 9.7,
				},
				[236] = 
				{
					[1] = 0.63,
					[2] = 9.7,
				},
				[237] = 
				{
					[1] = 0.64,
					[2] = 9.7,
				},
				[238] = 
				{
					[1] = 0.64,
					[2] = 9.71,
				},
				[239] = 
				{
					[1] = 0.64,
					[2] = 9.71,
				},
				[240] = 
				{
					[1] = 0.64,
					[2] = 9.71,
				},
				[241] = 
				{
					[1] = 0.65,
					[2] = 9.71,
				},
				[242] = 
				{
					[1] = 0.65,
					[2] = 9.71,
				},
				[243] = 
				{
					[1] = 0.65,
					[2] = 9.71,
				},
				[244] = 
				{
					[1] = 0.65,
					[2] = 9.71,
				},
				[245] = 
				{
					[1] = 0.66,
					[2] = 9.71,
				},
				[246] = 
				{
					[1] = 0.66,
					[2] = 9.71,
				},
				[247] = 
				{
					[1] = 0.66,
					[2] = 9.71,
				},
				[248] = 
				{
					[1] = 0.67,
					[2] = 9.71,
				},
				[249] = 
				{
					[1] = 0.67,
					[2] = 9.71,
				},
				[250] = 
				{
					[1] = 0.67,
					[2] = 9.71,
				},
				[251] = 
				{
					[1] = 0.67,
					[2] = 9.71,
				},
				[252] = 
				{
					[1] = 0.68,
					[2] = 9.71,
				},
				[253] = 
				{
					[1] = 0.68,
					[2] = 9.72,
				},
				[254] = 
				{
					[1] = 0.68,
					[2] = 9.72,
				},
				[255] = 
				{
					[1] = 0.68,
					[2] = 9.72,
				},
				[256] = 
				{
					[1] = 0.69,
					[2] = 9.73,
				},
				[257] = 
				{
					[1] = 0.69,
					[2] = 9.73,
				},
				[258] = 
				{
					[1] = 0.69,
					[2] = 9.74,
				},
				[259] = 
				{
					[1] = 0.7,
					[2] = 9.74,
				},
				[260] = 
				{
					[1] = 0.7,
					[2] = 9.75,
				},
				[261] = 
				{
					[1] = 0.7,
					[2] = 9.75,
				},
				[262] = 
				{
					[1] = 0.7,
					[2] = 9.75,
				},
				[263] = 
				{
					[1] = 0.71,
					[2] = 9.76,
				},
				[264] = 
				{
					[1] = 0.71,
					[2] = 9.76,
				},
				[265] = 
				{
					[1] = 0.71,
					[2] = 9.77,
				},
				[266] = 
				{
					[1] = 0.71,
					[2] = 9.77,
				},
				[267] = 
				{
					[1] = 0.72,
					[2] = 9.77,
				},
				[268] = 
				{
					[1] = 0.72,
					[2] = 9.78,
				},
				[269] = 
				{
					[1] = 0.72,
					[2] = 9.78,
				},
				[270] = 
				{
					[1] = 0.73,
					[2] = 9.78,
				},
				[271] = 
				{
					[1] = 0.73,
					[2] = 9.79,
				},
				[272] = 
				{
					[1] = 0.73,
					[2] = 9.79,
				},
				[273] = 
				{
					[1] = 0.73,
					[2] = 9.79,
				},
				[274] = 
				{
					[1] = 0.74,
					[2] = 9.79,
				},
				[275] = 
				{
					[1] = 0.74,
					[2] = 9.8,
				},
				[276] = 
				{
					[1] = 0.74,
					[2] = 9.8,
				},
				[277] = 
				{
					[1] = 0.74,
					[2] = 9.8,
				},
				[278] = 
				{
					[1] = 0.75,
					[2] = 9.8,
				},
				[279] = 
				{
					[1] = 0.75,
					[2] = 9.81,
				},
				[280] = 
				{
					[1] = 0.75,
					[2] = 9.81,
				},
				[281] = 
				{
					[1] = 0.75,
					[2] = 9.81,
				},
				[282] = 
				{
					[1] = 0.76,
					[2] = 9.81,
				},
				[283] = 
				{
					[1] = 0.76,
					[2] = 9.81,
				},
				[284] = 
				{
					[1] = 0.76,
					[2] = 9.82,
				},
				[285] = 
				{
					[1] = 0.77,
					[2] = 9.82,
				},
				[286] = 
				{
					[1] = 0.77,
					[2] = 9.82,
				},
				[287] = 
				{
					[1] = 0.77,
					[2] = 9.82,
				},
				[288] = 
				{
					[1] = 0.77,
					[2] = 9.82,
				},
				[289] = 
				{
					[1] = 0.78,
					[2] = 9.82,
				},
				[290] = 
				{
					[1] = 0.78,
					[2] = 9.82,
				},
				[291] = 
				{
					[1] = 0.78,
					[2] = 9.82,
				},
				[292] = 
				{
					[1] = 0.78,
					[2] = 9.83,
				},
				[293] = 
				{
					[1] = 0.79,
					[2] = 9.83,
				},
				[294] = 
				{
					[1] = 0.79,
					[2] = 9.83,
				},
				[295] = 
				{
					[1] = 0.79,
					[2] = 9.83,
				},
				[296] = 
				{
					[1] = 0.8,
					[2] = 9.83,
				},
				[297] = 
				{
					[1] = 0.8,
					[2] = 9.83,
				},
				[298] = 
				{
					[1] = 0.8,
					[2] = 9.83,
				},
				[299] = 
				{
					[1] = 0.8,
					[2] = 9.83,
				},
				[300] = 
				{
					[1] = 0.81,
					[2] = 9.83,
				},
				[301] = 
				{
					[1] = 0.81,
					[2] = 9.83,
				},
				[302] = 
				{
					[1] = 0.81,
					[2] = 9.83,
				},
				[303] = 
				{
					[1] = 0.81,
					[2] = 9.83,
				},
				[304] = 
				{
					[1] = 0.82,
					[2] = 9.83,
				},
				[305] = 
				{
					[1] = 0.82,
					[2] = 9.83,
				},
				[306] = 
				{
					[1] = 0.82,
					[2] = 9.83,
				},
				[307] = 
				{
					[1] = 0.82,
					[2] = 9.83,
				},
				[308] = 
				{
					[1] = 0.83,
					[2] = 9.83,
				},
				[309] = 
				{
					[1] = 0.83,
					[2] = 9.83,
				},
				[310] = 
				{
					[1] = 0.83,
					[2] = 9.82,
				},
				[311] = 
				{
					[1] = 0.84,
					[2] = 9.82,
				},
				[312] = 
				{
					[1] = 0.84,
					[2] = 9.82,
				},
				[313] = 
				{
					[1] = 0.84,
					[2] = 9.82,
				},
				[314] = 
				{
					[1] = 0.84,
					[2] = 9.82,
				},
				[315] = 
				{
					[1] = 0.85,
					[2] = 9.82,
				},
				[316] = 
				{
					[1] = 0.85,
					[2] = 9.82,
				},
				[317] = 
				{
					[1] = 0.85,
					[2] = 9.82,
				},
				[318] = 
				{
					[1] = 0.85,
					[2] = 9.81,
				},
				[319] = 
				{
					[1] = 0.86,
					[2] = 9.81,
				},
				[320] = 
				{
					[1] = 0.86,
					[2] = 9.8,
				},
				[321] = 
				{
					[1] = 0.86,
					[2] = 9.79,
				},
				[322] = 
				{
					[1] = 0.87,
					[2] = 9.79,
				},
				[323] = 
				{
					[1] = 0.87,
					[2] = 9.78,
				},
				[324] = 
				{
					[1] = 0.87,
					[2] = 9.77,
				},
				[325] = 
				{
					[1] = 0.87,
					[2] = 9.77,
				},
				[326] = 
				{
					[1] = 0.88,
					[2] = 9.76,
				},
				[327] = 
				{
					[1] = 0.88,
					[2] = 9.75,
				},
				[328] = 
				{
					[1] = 0.88,
					[2] = 9.75,
				},
				[329] = 
				{
					[1] = 0.88,
					[2] = 9.74,
				},
				[330] = 
				{
					[1] = 0.89,
					[2] = 9.73,
				},
				[331] = 
				{
					[1] = 0.89,
					[2] = 9.73,
				},
				[332] = 
				{
					[1] = 0.89,
					[2] = 9.72,
				},
				[333] = 
				{
					[1] = 0.89,
					[2] = 9.71,
				},
				[334] = 
				{
					[1] = 0.9,
					[2] = 9.71,
				},
				[335] = 
				{
					[1] = 0.9,
					[2] = 9.7,
				},
				[336] = 
				{
					[1] = 0.9,
					[2] = 9.69,
				},
				[337] = 
				{
					[1] = 0.91,
					[2] = 9.68,
				},
				[338] = 
				{
					[1] = 0.91,
					[2] = 9.68,
				},
				[339] = 
				{
					[1] = 0.91,
					[2] = 9.67,
				},
				[340] = 
				{
					[1] = 0.91,
					[2] = 9.66,
				},
				[341] = 
				{
					[1] = 0.92,
					[2] = 9.65,
				},
				[342] = 
				{
					[1] = 0.92,
					[2] = 9.65,
				},
				[343] = 
				{
					[1] = 0.92,
					[2] = 9.64,
				},
				[344] = 
				{
					[1] = 0.92,
					[2] = 9.63,
				},
				[345] = 
				{
					[1] = 0.93,
					[2] = 9.62,
				},
				[346] = 
				{
					[1] = 0.93,
					[2] = 9.61,
				},
				[347] = 
				{
					[1] = 0.93,
					[2] = 9.61,
				},
				[348] = 
				{
					[1] = 0.94,
					[2] = 9.6,
				},
				[349] = 
				{
					[1] = 0.94,
					[2] = 9.59,
				},
				[350] = 
				{
					[1] = 0.94,
					[2] = 9.58,
				},
				[351] = 
				{
					[1] = 0.94,
					[2] = 9.57,
				},
				[352] = 
				{
					[1] = 0.95,
					[2] = 9.56,
				},
				[353] = 
				{
					[1] = 0.95,
					[2] = 9.56,
				},
				[354] = 
				{
					[1] = 0.95,
					[2] = 9.55,
				},
				[355] = 
				{
					[1] = 0.95,
					[2] = 9.54,
				},
				[356] = 
				{
					[1] = 0.96,
					[2] = 9.53,
				},
				[357] = 
				{
					[1] = 0.96,
					[2] = 9.52,
				},
				[358] = 
				{
					[1] = 0.96,
					[2] = 9.51,
				},
				[359] = 
				{
					[1] = 0.96,
					[2] = 9.5,
				},
				[360] = 
				{
					[1] = 0.97,
					[2] = 9.49,
				},
				[361] = 
				{
					[1] = 0.97,
					[2] = 9.48,
				},
				[362] = 
				{
					[1] = 0.97,
					[2] = 9.47,
				},
				[363] = 
				{
					[1] = 0.98,
					[2] = 9.46,
				},
				[364] = 
				{
					[1] = 0.98,
					[2] = 9.45,
				},
				[365] = 
				{
					[1] = 0.98,
					[2] = 9.44,
				},
				[366] = 
				{
					[1] = 0.98,
					[2] = 9.43,
				},
				[367] = 
				{
					[1] = 0.99,
					[2] = 9.43,
				},
				[368] = 
				{
					[1] = 0.99,
					[2] = 9.42,
				},
				[369] = 
				{
					[1] = 0.99,
					[2] = 9.41,
				},
				[370] = 
				{
					[1] = 0.99,
					[2] = 9.4,
				},
				[371] = 
				{
					[1] = 1,
					[2] = 9.38,
				},
			},
			["WidthScale"] = 0.7,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_akagi",
		["Type"] = "WaterTracer",
	},
	[198] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 217.813889,
			["Lifetime"] = 21.17,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.017,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 313.396851,
			["Lifetime"] = 30.459999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 2.89,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 71.610046,
			["Lifetime"] = 6.96,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_akagi",
		["Type"] = "WaterTracer",
	},
	[199] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 163.399994,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0306,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.36,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.56,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.7,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.85,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.13,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 1.25,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.38,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 1.5,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 1.64,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 1.83,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 2.02,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 2.2,
				},
				[15] = 
				{
					[1] = 0.09,
					[2] = 2.39,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 2.57,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 2.76,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 2.94,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 3.12,
				},
				[20] = 
				{
					[1] = 0.12,
					[2] = 3.3,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 3.48,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 3.66,
				},
				[23] = 
				{
					[1] = 0.13,
					[2] = 3.85,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 4.03,
				},
				[25] = 
				{
					[1] = 0.15,
					[2] = 4.21,
				},
				[26] = 
				{
					[1] = 0.15,
					[2] = 4.35,
				},
				[27] = 
				{
					[1] = 0.16,
					[2] = 4.47,
				},
				[28] = 
				{
					[1] = 0.17,
					[2] = 4.59,
				},
				[29] = 
				{
					[1] = 0.17,
					[2] = 4.71,
				},
				[30] = 
				{
					[1] = 0.18,
					[2] = 4.83,
				},
				[31] = 
				{
					[1] = 0.18,
					[2] = 4.95,
				},
				[32] = 
				{
					[1] = 0.19,
					[2] = 5.06,
				},
				[33] = 
				{
					[1] = 0.2,
					[2] = 5.18,
				},
				[34] = 
				{
					[1] = 0.2,
					[2] = 5.3,
				},
				[35] = 
				{
					[1] = 0.21,
					[2] = 5.42,
				},
				[36] = 
				{
					[1] = 0.21,
					[2] = 5.54,
				},
				[37] = 
				{
					[1] = 0.22,
					[2] = 5.65,
				},
				[38] = 
				{
					[1] = 0.23,
					[2] = 5.72,
				},
				[39] = 
				{
					[1] = 0.23,
					[2] = 5.79,
				},
				[40] = 
				{
					[1] = 0.24,
					[2] = 5.86,
				},
				[41] = 
				{
					[1] = 0.25,
					[2] = 5.92,
				},
				[42] = 
				{
					[1] = 0.25,
					[2] = 5.99,
				},
				[43] = 
				{
					[1] = 0.26,
					[2] = 6.06,
				},
				[44] = 
				{
					[1] = 0.26,
					[2] = 6.13,
				},
				[45] = 
				{
					[1] = 0.27,
					[2] = 6.2,
				},
				[46] = 
				{
					[1] = 0.28,
					[2] = 6.27,
				},
				[47] = 
				{
					[1] = 0.28,
					[2] = 6.34,
				},
				[48] = 
				{
					[1] = 0.29,
					[2] = 6.38,
				},
				[49] = 
				{
					[1] = 0.29,
					[2] = 6.41,
				},
				[50] = 
				{
					[1] = 0.3,
					[2] = 6.44,
				},
				[51] = 
				{
					[1] = 0.31,
					[2] = 6.47,
				},
				[52] = 
				{
					[1] = 0.31,
					[2] = 6.5,
				},
				[53] = 
				{
					[1] = 0.32,
					[2] = 6.53,
				},
				[54] = 
				{
					[1] = 0.33,
					[2] = 6.56,
				},
				[55] = 
				{
					[1] = 0.33,
					[2] = 6.59,
				},
				[56] = 
				{
					[1] = 0.34,
					[2] = 6.62,
				},
				[57] = 
				{
					[1] = 0.34,
					[2] = 6.65,
				},
				[58] = 
				{
					[1] = 0.35,
					[2] = 6.68,
				},
				[59] = 
				{
					[1] = 0.36,
					[2] = 6.71,
				},
				[60] = 
				{
					[1] = 0.36,
					[2] = 6.74,
				},
				[61] = 
				{
					[1] = 0.37,
					[2] = 6.82,
				},
				[62] = 
				{
					[1] = 0.37,
					[2] = 6.97,
				},
				[63] = 
				{
					[1] = 0.38,
					[2] = 7.12,
				},
				[64] = 
				{
					[1] = 0.39,
					[2] = 7.27,
				},
				[65] = 
				{
					[1] = 0.39,
					[2] = 7.42,
				},
				[66] = 
				{
					[1] = 0.4,
					[2] = 7.57,
				},
				[67] = 
				{
					[1] = 0.4,
					[2] = 7.6,
				},
				[68] = 
				{
					[1] = 0.41,
					[2] = 7.61,
				},
				[69] = 
				{
					[1] = 0.42,
					[2] = 7.62,
				},
				[70] = 
				{
					[1] = 0.42,
					[2] = 7.62,
				},
				[71] = 
				{
					[1] = 0.43,
					[2] = 7.63,
				},
				[72] = 
				{
					[1] = 0.44,
					[2] = 7.63,
				},
				[73] = 
				{
					[1] = 0.44,
					[2] = 7.64,
				},
				[74] = 
				{
					[1] = 0.45,
					[2] = 7.64,
				},
				[75] = 
				{
					[1] = 0.45,
					[2] = 7.65,
				},
				[76] = 
				{
					[1] = 0.46,
					[2] = 7.66,
				},
				[77] = 
				{
					[1] = 0.47,
					[2] = 7.66,
				},
				[78] = 
				{
					[1] = 0.47,
					[2] = 7.67,
				},
				[79] = 
				{
					[1] = 0.48,
					[2] = 7.67,
				},
				[80] = 
				{
					[1] = 0.48,
					[2] = 7.68,
				},
				[81] = 
				{
					[1] = 0.49,
					[2] = 7.68,
				},
				[82] = 
				{
					[1] = 0.5,
					[2] = 7.69,
				},
				[83] = 
				{
					[1] = 0.5,
					[2] = 7.7,
				},
				[84] = 
				{
					[1] = 0.51,
					[2] = 7.7,
				},
				[85] = 
				{
					[1] = 0.52,
					[2] = 7.71,
				},
				[86] = 
				{
					[1] = 0.52,
					[2] = 7.71,
				},
				[87] = 
				{
					[1] = 0.53,
					[2] = 7.73,
				},
				[88] = 
				{
					[1] = 0.53,
					[2] = 7.74,
				},
				[89] = 
				{
					[1] = 0.54,
					[2] = 7.75,
				},
				[90] = 
				{
					[1] = 0.55,
					[2] = 7.77,
				},
				[91] = 
				{
					[1] = 0.55,
					[2] = 7.78,
				},
				[92] = 
				{
					[1] = 0.56,
					[2] = 7.79,
				},
				[93] = 
				{
					[1] = 0.56,
					[2] = 7.8,
				},
				[94] = 
				{
					[1] = 0.57,
					[2] = 7.82,
				},
				[95] = 
				{
					[1] = 0.58,
					[2] = 7.83,
				},
				[96] = 
				{
					[1] = 0.58,
					[2] = 7.84,
				},
				[97] = 
				{
					[1] = 0.59,
					[2] = 7.85,
				},
				[98] = 
				{
					[1] = 0.6,
					[2] = 7.87,
				},
				[99] = 
				{
					[1] = 0.6,
					[2] = 7.87,
				},
				[100] = 
				{
					[1] = 0.61,
					[2] = 7.86,
				},
				[101] = 
				{
					[1] = 0.61,
					[2] = 7.84,
				},
				[102] = 
				{
					[1] = 0.62,
					[2] = 7.83,
				},
				[103] = 
				{
					[1] = 0.63,
					[2] = 7.82,
				},
				[104] = 
				{
					[1] = 0.63,
					[2] = 7.81,
				},
				[105] = 
				{
					[1] = 0.64,
					[2] = 7.8,
				},
				[106] = 
				{
					[1] = 0.64,
					[2] = 7.79,
				},
				[107] = 
				{
					[1] = 0.65,
					[2] = 7.78,
				},
				[108] = 
				{
					[1] = 0.66,
					[2] = 7.76,
				},
				[109] = 
				{
					[1] = 0.66,
					[2] = 7.75,
				},
				[110] = 
				{
					[1] = 0.67,
					[2] = 7.74,
				},
				[111] = 
				{
					[1] = 0.67,
					[2] = 7.7,
				},
				[112] = 
				{
					[1] = 0.68,
					[2] = 7.58,
				},
				[113] = 
				{
					[1] = 0.69,
					[2] = 7.46,
				},
				[114] = 
				{
					[1] = 0.69,
					[2] = 7.34,
				},
				[115] = 
				{
					[1] = 0.7,
					[2] = 7.22,
				},
				[116] = 
				{
					[1] = 0.71,
					[2] = 7.12,
				},
				[117] = 
				{
					[1] = 0.71,
					[2] = 7.04,
				},
				[118] = 
				{
					[1] = 0.72,
					[2] = 6.97,
				},
				[119] = 
				{
					[1] = 0.72,
					[2] = 6.89,
				},
				[120] = 
				{
					[1] = 0.73,
					[2] = 6.82,
				},
				[121] = 
				{
					[1] = 0.74,
					[2] = 6.74,
				},
				[122] = 
				{
					[1] = 0.74,
					[2] = 6.67,
				},
				[123] = 
				{
					[1] = 0.75,
					[2] = 6.6,
				},
				[124] = 
				{
					[1] = 0.75,
					[2] = 6.53,
				},
				[125] = 
				{
					[1] = 0.76,
					[2] = 6.47,
				},
				[126] = 
				{
					[1] = 0.77,
					[2] = 6.4,
				},
				[127] = 
				{
					[1] = 0.77,
					[2] = 6.34,
				},
				[128] = 
				{
					[1] = 0.78,
					[2] = 6.27,
				},
				[129] = 
				{
					[1] = 0.79,
					[2] = 6.2,
				},
				[130] = 
				{
					[1] = 0.79,
					[2] = 6.14,
				},
				[131] = 
				{
					[1] = 0.8,
					[2] = 6.07,
				},
				[132] = 
				{
					[1] = 0.8,
					[2] = 6,
				},
				[133] = 
				{
					[1] = 0.81,
					[2] = 5.94,
				},
				[134] = 
				{
					[1] = 0.82,
					[2] = 5.87,
				},
				[135] = 
				{
					[1] = 0.82,
					[2] = 5.8,
				},
				[136] = 
				{
					[1] = 0.83,
					[2] = 5.71,
				},
				[137] = 
				{
					[1] = 0.83,
					[2] = 5.63,
				},
				[138] = 
				{
					[1] = 0.84,
					[2] = 5.54,
				},
				[139] = 
				{
					[1] = 0.85,
					[2] = 5.45,
				},
				[140] = 
				{
					[1] = 0.85,
					[2] = 5.37,
				},
				[141] = 
				{
					[1] = 0.86,
					[2] = 5.26,
				},
				[142] = 
				{
					[1] = 0.87,
					[2] = 5.15,
				},
				[143] = 
				{
					[1] = 0.87,
					[2] = 5.04,
				},
				[144] = 
				{
					[1] = 0.88,
					[2] = 4.93,
				},
				[145] = 
				{
					[1] = 0.88,
					[2] = 4.84,
				},
				[146] = 
				{
					[1] = 0.89,
					[2] = 4.74,
				},
				[147] = 
				{
					[1] = 0.9,
					[2] = 4.65,
				},
				[148] = 
				{
					[1] = 0.9,
					[2] = 4.55,
				},
				[149] = 
				{
					[1] = 0.91,
					[2] = 4.45,
				},
				[150] = 
				{
					[1] = 0.91,
					[2] = 4.36,
				},
				[151] = 
				{
					[1] = 0.92,
					[2] = 4.26,
				},
				[152] = 
				{
					[1] = 0.93,
					[2] = 4.18,
				},
				[153] = 
				{
					[1] = 0.93,
					[2] = 4.11,
				},
				[154] = 
				{
					[1] = 0.94,
					[2] = 4.03,
				},
				[155] = 
				{
					[1] = 0.94,
					[2] = 3.95,
				},
				[156] = 
				{
					[1] = 0.95,
					[2] = 3.87,
				},
				[157] = 
				{
					[1] = 0.96,
					[2] = 3.79,
				},
				[158] = 
				{
					[1] = 0.96,
					[2] = 3.72,
				},
				[159] = 
				{
					[1] = 0.97,
					[2] = 3.64,
				},
				[160] = 
				{
					[1] = 0.98,
					[2] = 3.56,
				},
				[161] = 
				{
					[1] = 0.98,
					[2] = 3.48,
				},
				[162] = 
				{
					[1] = 0.99,
					[2] = 3.32,
				},
				[163] = 
				{
					[1] = 0.99,
					[2] = 3.13,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.24,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.32,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.38,
				},
				[5] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[6] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[7] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[8] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[9] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[15] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[16] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[17] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[18] = 
				{
					[1] = 0.42,
					[2] = 0.44,
				},
				[19] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[20] = 
				{
					[1] = 0.47,
					[2] = 0.41,
				},
				[21] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[22] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[23] = 
				{
					[1] = 0.55,
					[2] = 0.36,
				},
				[24] = 
				{
					[1] = 0.57,
					[2] = 0.34,
				},
				[25] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[26] = 
				{
					[1] = 0.63,
					[2] = 0.31,
				},
				[27] = 
				{
					[1] = 0.65,
					[2] = 0.29,
				},
				[28] = 
				{
					[1] = 0.68,
					[2] = 0.27,
				},
				[29] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[30] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[31] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[32] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[33] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[34] = 
				{
					[1] = 0.82,
					[2] = 0.14,
				},
				[35] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[36] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[37] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[38] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[39] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[40] = 
				{
					[1] = 0.97,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 16.51,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.09,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.16,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.23,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.31,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.38,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.45,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.52,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.59,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 0.66,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 0.7,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 0.74,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 0.77,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 0.81,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 0.85,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 0.88,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 0.92,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 0.96,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 0.99,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 1.03,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 1.07,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 1.1,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 1.12,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 1.15,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 1.17,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 1.2,
				},
				[27] = 
				{
					[1] = 0.11,
					[2] = 1.22,
				},
				[28] = 
				{
					[1] = 0.11,
					[2] = 1.25,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 1.27,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 1.3,
				},
				[31] = 
				{
					[1] = 0.12,
					[2] = 1.32,
				},
				[32] = 
				{
					[1] = 0.13,
					[2] = 1.35,
				},
				[33] = 
				{
					[1] = 0.13,
					[2] = 1.37,
				},
				[34] = 
				{
					[1] = 0.13,
					[2] = 1.4,
				},
				[35] = 
				{
					[1] = 0.14,
					[2] = 1.42,
				},
				[36] = 
				{
					[1] = 0.14,
					[2] = 1.45,
				},
				[37] = 
				{
					[1] = 0.15,
					[2] = 1.47,
				},
				[38] = 
				{
					[1] = 0.15,
					[2] = 1.49,
				},
				[39] = 
				{
					[1] = 0.16,
					[2] = 1.52,
				},
				[40] = 
				{
					[1] = 0.16,
					[2] = 1.54,
				},
				[41] = 
				{
					[1] = 0.16,
					[2] = 1.56,
				},
				[42] = 
				{
					[1] = 0.17,
					[2] = 1.59,
				},
				[43] = 
				{
					[1] = 0.17,
					[2] = 1.61,
				},
				[44] = 
				{
					[1] = 0.18,
					[2] = 1.63,
				},
				[45] = 
				{
					[1] = 0.18,
					[2] = 1.66,
				},
				[46] = 
				{
					[1] = 0.18,
					[2] = 1.68,
				},
				[47] = 
				{
					[1] = 0.19,
					[2] = 1.7,
				},
				[48] = 
				{
					[1] = 0.19,
					[2] = 1.73,
				},
				[49] = 
				{
					[1] = 0.2,
					[2] = 1.75,
				},
				[50] = 
				{
					[1] = 0.2,
					[2] = 1.77,
				},
				[51] = 
				{
					[1] = 0.2,
					[2] = 1.8,
				},
				[52] = 
				{
					[1] = 0.21,
					[2] = 1.83,
				},
				[53] = 
				{
					[1] = 0.21,
					[2] = 1.85,
				},
				[54] = 
				{
					[1] = 0.22,
					[2] = 1.86,
				},
				[55] = 
				{
					[1] = 0.22,
					[2] = 1.88,
				},
				[56] = 
				{
					[1] = 0.22,
					[2] = 1.9,
				},
				[57] = 
				{
					[1] = 0.23,
					[2] = 1.92,
				},
				[58] = 
				{
					[1] = 0.23,
					[2] = 1.93,
				},
				[59] = 
				{
					[1] = 0.24,
					[2] = 1.95,
				},
				[60] = 
				{
					[1] = 0.24,
					[2] = 1.97,
				},
				[61] = 
				{
					[1] = 0.24,
					[2] = 1.99,
				},
				[62] = 
				{
					[1] = 0.25,
					[2] = 2,
				},
				[63] = 
				{
					[1] = 0.25,
					[2] = 2.02,
				},
				[64] = 
				{
					[1] = 0.26,
					[2] = 2.04,
				},
				[65] = 
				{
					[1] = 0.26,
					[2] = 2.05,
				},
				[66] = 
				{
					[1] = 0.27,
					[2] = 2.07,
				},
				[67] = 
				{
					[1] = 0.27,
					[2] = 2.09,
				},
				[68] = 
				{
					[1] = 0.27,
					[2] = 2.1,
				},
				[69] = 
				{
					[1] = 0.28,
					[2] = 2.12,
				},
				[70] = 
				{
					[1] = 0.28,
					[2] = 2.13,
				},
				[71] = 
				{
					[1] = 0.29,
					[2] = 2.15,
				},
				[72] = 
				{
					[1] = 0.29,
					[2] = 2.17,
				},
				[73] = 
				{
					[1] = 0.29,
					[2] = 2.18,
				},
				[74] = 
				{
					[1] = 0.3,
					[2] = 2.2,
				},
				[75] = 
				{
					[1] = 0.3,
					[2] = 2.21,
				},
				[76] = 
				{
					[1] = 0.31,
					[2] = 2.23,
				},
				[77] = 
				{
					[1] = 0.31,
					[2] = 2.25,
				},
				[78] = 
				{
					[1] = 0.31,
					[2] = 2.26,
				},
				[79] = 
				{
					[1] = 0.32,
					[2] = 2.28,
				},
				[80] = 
				{
					[1] = 0.32,
					[2] = 2.29,
				},
				[81] = 
				{
					[1] = 0.33,
					[2] = 2.31,
				},
				[82] = 
				{
					[1] = 0.33,
					[2] = 2.32,
				},
				[83] = 
				{
					[1] = 0.33,
					[2] = 2.34,
				},
				[84] = 
				{
					[1] = 0.34,
					[2] = 2.35,
				},
				[85] = 
				{
					[1] = 0.34,
					[2] = 2.37,
				},
				[86] = 
				{
					[1] = 0.35,
					[2] = 2.38,
				},
				[87] = 
				{
					[1] = 0.35,
					[2] = 2.39,
				},
				[88] = 
				{
					[1] = 0.36,
					[2] = 2.41,
				},
				[89] = 
				{
					[1] = 0.36,
					[2] = 2.42,
				},
				[90] = 
				{
					[1] = 0.36,
					[2] = 2.44,
				},
				[91] = 
				{
					[1] = 0.37,
					[2] = 2.45,
				},
				[92] = 
				{
					[1] = 0.37,
					[2] = 2.46,
				},
				[93] = 
				{
					[1] = 0.38,
					[2] = 2.48,
				},
				[94] = 
				{
					[1] = 0.38,
					[2] = 2.49,
				},
				[95] = 
				{
					[1] = 0.38,
					[2] = 2.51,
				},
				[96] = 
				{
					[1] = 0.39,
					[2] = 2.52,
				},
				[97] = 
				{
					[1] = 0.39,
					[2] = 2.53,
				},
				[98] = 
				{
					[1] = 0.4,
					[2] = 2.55,
				},
				[99] = 
				{
					[1] = 0.4,
					[2] = 2.57,
				},
				[100] = 
				{
					[1] = 0.4,
					[2] = 2.59,
				},
				[101] = 
				{
					[1] = 0.41,
					[2] = 2.62,
				},
				[102] = 
				{
					[1] = 0.41,
					[2] = 2.64,
				},
				[103] = 
				{
					[1] = 0.42,
					[2] = 2.66,
				},
				[104] = 
				{
					[1] = 0.42,
					[2] = 2.69,
				},
				[105] = 
				{
					[1] = 0.42,
					[2] = 2.71,
				},
				[106] = 
				{
					[1] = 0.43,
					[2] = 2.73,
				},
				[107] = 
				{
					[1] = 0.43,
					[2] = 2.75,
				},
				[108] = 
				{
					[1] = 0.44,
					[2] = 2.77,
				},
				[109] = 
				{
					[1] = 0.44,
					[2] = 2.8,
				},
				[110] = 
				{
					[1] = 0.44,
					[2] = 2.82,
				},
				[111] = 
				{
					[1] = 0.45,
					[2] = 2.84,
				},
				[112] = 
				{
					[1] = 0.45,
					[2] = 2.86,
				},
				[113] = 
				{
					[1] = 0.46,
					[2] = 2.88,
				},
				[114] = 
				{
					[1] = 0.46,
					[2] = 2.9,
				},
				[115] = 
				{
					[1] = 0.47,
					[2] = 2.92,
				},
				[116] = 
				{
					[1] = 0.47,
					[2] = 2.94,
				},
				[117] = 
				{
					[1] = 0.47,
					[2] = 2.96,
				},
				[118] = 
				{
					[1] = 0.48,
					[2] = 2.98,
				},
				[119] = 
				{
					[1] = 0.48,
					[2] = 3,
				},
				[120] = 
				{
					[1] = 0.49,
					[2] = 3.02,
				},
				[121] = 
				{
					[1] = 0.49,
					[2] = 3.04,
				},
				[122] = 
				{
					[1] = 0.49,
					[2] = 3.06,
				},
				[123] = 
				{
					[1] = 0.5,
					[2] = 3.08,
				},
				[124] = 
				{
					[1] = 0.5,
					[2] = 3.1,
				},
				[125] = 
				{
					[1] = 0.51,
					[2] = 3.12,
				},
				[126] = 
				{
					[1] = 0.51,
					[2] = 3.14,
				},
				[127] = 
				{
					[1] = 0.51,
					[2] = 3.16,
				},
				[128] = 
				{
					[1] = 0.52,
					[2] = 3.18,
				},
				[129] = 
				{
					[1] = 0.52,
					[2] = 3.2,
				},
				[130] = 
				{
					[1] = 0.53,
					[2] = 3.22,
				},
				[131] = 
				{
					[1] = 0.53,
					[2] = 3.24,
				},
				[132] = 
				{
					[1] = 0.53,
					[2] = 3.25,
				},
				[133] = 
				{
					[1] = 0.54,
					[2] = 3.27,
				},
				[134] = 
				{
					[1] = 0.54,
					[2] = 3.29,
				},
				[135] = 
				{
					[1] = 0.55,
					[2] = 3.31,
				},
				[136] = 
				{
					[1] = 0.55,
					[2] = 3.32,
				},
				[137] = 
				{
					[1] = 0.56,
					[2] = 3.34,
				},
				[138] = 
				{
					[1] = 0.56,
					[2] = 3.36,
				},
				[139] = 
				{
					[1] = 0.56,
					[2] = 3.38,
				},
				[140] = 
				{
					[1] = 0.57,
					[2] = 3.39,
				},
				[141] = 
				{
					[1] = 0.57,
					[2] = 3.41,
				},
				[142] = 
				{
					[1] = 0.58,
					[2] = 3.43,
				},
				[143] = 
				{
					[1] = 0.58,
					[2] = 3.44,
				},
				[144] = 
				{
					[1] = 0.58,
					[2] = 3.46,
				},
				[145] = 
				{
					[1] = 0.59,
					[2] = 3.48,
				},
				[146] = 
				{
					[1] = 0.59,
					[2] = 3.49,
				},
				[147] = 
				{
					[1] = 0.6,
					[2] = 3.51,
				},
				[148] = 
				{
					[1] = 0.6,
					[2] = 3.52,
				},
				[149] = 
				{
					[1] = 0.6,
					[2] = 3.54,
				},
				[150] = 
				{
					[1] = 0.61,
					[2] = 3.56,
				},
				[151] = 
				{
					[1] = 0.61,
					[2] = 3.57,
				},
				[152] = 
				{
					[1] = 0.62,
					[2] = 3.59,
				},
				[153] = 
				{
					[1] = 0.62,
					[2] = 3.6,
				},
				[154] = 
				{
					[1] = 0.62,
					[2] = 3.62,
				},
				[155] = 
				{
					[1] = 0.63,
					[2] = 3.63,
				},
				[156] = 
				{
					[1] = 0.63,
					[2] = 3.65,
				},
				[157] = 
				{
					[1] = 0.64,
					[2] = 3.66,
				},
				[158] = 
				{
					[1] = 0.64,
					[2] = 3.67,
				},
				[159] = 
				{
					[1] = 0.64,
					[2] = 3.69,
				},
				[160] = 
				{
					[1] = 0.65,
					[2] = 3.7,
				},
				[161] = 
				{
					[1] = 0.65,
					[2] = 3.71,
				},
				[162] = 
				{
					[1] = 0.66,
					[2] = 3.73,
				},
				[163] = 
				{
					[1] = 0.66,
					[2] = 3.74,
				},
				[164] = 
				{
					[1] = 0.67,
					[2] = 3.75,
				},
				[165] = 
				{
					[1] = 0.67,
					[2] = 3.77,
				},
				[166] = 
				{
					[1] = 0.67,
					[2] = 3.78,
				},
				[167] = 
				{
					[1] = 0.68,
					[2] = 3.79,
				},
				[168] = 
				{
					[1] = 0.68,
					[2] = 3.8,
				},
				[169] = 
				{
					[1] = 0.69,
					[2] = 3.82,
				},
				[170] = 
				{
					[1] = 0.69,
					[2] = 3.83,
				},
				[171] = 
				{
					[1] = 0.69,
					[2] = 3.84,
				},
				[172] = 
				{
					[1] = 0.7,
					[2] = 3.85,
				},
				[173] = 
				{
					[1] = 0.7,
					[2] = 3.86,
				},
				[174] = 
				{
					[1] = 0.71,
					[2] = 3.87,
				},
				[175] = 
				{
					[1] = 0.71,
					[2] = 3.88,
				},
				[176] = 
				{
					[1] = 0.71,
					[2] = 3.9,
				},
				[177] = 
				{
					[1] = 0.72,
					[2] = 3.91,
				},
				[178] = 
				{
					[1] = 0.72,
					[2] = 3.92,
				},
				[179] = 
				{
					[1] = 0.73,
					[2] = 3.93,
				},
				[180] = 
				{
					[1] = 0.73,
					[2] = 3.94,
				},
				[181] = 
				{
					[1] = 0.73,
					[2] = 3.95,
				},
				[182] = 
				{
					[1] = 0.74,
					[2] = 3.96,
				},
				[183] = 
				{
					[1] = 0.74,
					[2] = 3.97,
				},
				[184] = 
				{
					[1] = 0.75,
					[2] = 3.98,
				},
				[185] = 
				{
					[1] = 0.75,
					[2] = 3.99,
				},
				[186] = 
				{
					[1] = 0.76,
					[2] = 4,
				},
				[187] = 
				{
					[1] = 0.76,
					[2] = 4.01,
				},
				[188] = 
				{
					[1] = 0.76,
					[2] = 4.02,
				},
				[189] = 
				{
					[1] = 0.77,
					[2] = 4.03,
				},
				[190] = 
				{
					[1] = 0.77,
					[2] = 4.03,
				},
				[191] = 
				{
					[1] = 0.78,
					[2] = 4.04,
				},
				[192] = 
				{
					[1] = 0.78,
					[2] = 4.05,
				},
				[193] = 
				{
					[1] = 0.78,
					[2] = 4.06,
				},
				[194] = 
				{
					[1] = 0.79,
					[2] = 4.07,
				},
				[195] = 
				{
					[1] = 0.79,
					[2] = 4.08,
				},
				[196] = 
				{
					[1] = 0.8,
					[2] = 4.08,
				},
				[197] = 
				{
					[1] = 0.8,
					[2] = 4.09,
				},
				[198] = 
				{
					[1] = 0.8,
					[2] = 4.1,
				},
				[199] = 
				{
					[1] = 0.81,
					[2] = 4.11,
				},
				[200] = 
				{
					[1] = 0.81,
					[2] = 4.12,
				},
				[201] = 
				{
					[1] = 0.82,
					[2] = 4.12,
				},
				[202] = 
				{
					[1] = 0.82,
					[2] = 4.13,
				},
				[203] = 
				{
					[1] = 0.82,
					[2] = 4.14,
				},
				[204] = 
				{
					[1] = 0.83,
					[2] = 4.14,
				},
				[205] = 
				{
					[1] = 0.83,
					[2] = 4.15,
				},
				[206] = 
				{
					[1] = 0.84,
					[2] = 4.16,
				},
				[207] = 
				{
					[1] = 0.84,
					[2] = 4.16,
				},
				[208] = 
				{
					[1] = 0.84,
					[2] = 4.17,
				},
				[209] = 
				{
					[1] = 0.85,
					[2] = 4.18,
				},
				[210] = 
				{
					[1] = 0.85,
					[2] = 4.18,
				},
				[211] = 
				{
					[1] = 0.86,
					[2] = 4.19,
				},
				[212] = 
				{
					[1] = 0.86,
					[2] = 4.19,
				},
				[213] = 
				{
					[1] = 0.87,
					[2] = 4.2,
				},
				[214] = 
				{
					[1] = 0.87,
					[2] = 4.2,
				},
				[215] = 
				{
					[1] = 0.87,
					[2] = 4.21,
				},
				[216] = 
				{
					[1] = 0.88,
					[2] = 4.21,
				},
				[217] = 
				{
					[1] = 0.88,
					[2] = 4.22,
				},
				[218] = 
				{
					[1] = 0.89,
					[2] = 4.22,
				},
				[219] = 
				{
					[1] = 0.89,
					[2] = 4.23,
				},
				[220] = 
				{
					[1] = 0.89,
					[2] = 4.23,
				},
				[221] = 
				{
					[1] = 0.9,
					[2] = 4.24,
				},
				[222] = 
				{
					[1] = 0.9,
					[2] = 4.24,
				},
				[223] = 
				{
					[1] = 0.91,
					[2] = 4.25,
				},
				[224] = 
				{
					[1] = 0.91,
					[2] = 4.25,
				},
				[225] = 
				{
					[1] = 0.91,
					[2] = 4.25,
				},
				[226] = 
				{
					[1] = 0.92,
					[2] = 4.26,
				},
				[227] = 
				{
					[1] = 0.92,
					[2] = 4.26,
				},
				[228] = 
				{
					[1] = 0.93,
					[2] = 4.26,
				},
				[229] = 
				{
					[1] = 0.93,
					[2] = 4.27,
				},
				[230] = 
				{
					[1] = 0.93,
					[2] = 4.27,
				},
				[231] = 
				{
					[1] = 0.94,
					[2] = 4.27,
				},
				[232] = 
				{
					[1] = 0.94,
					[2] = 4.28,
				},
				[233] = 
				{
					[1] = 0.95,
					[2] = 4.28,
				},
				[234] = 
				{
					[1] = 0.95,
					[2] = 4.28,
				},
				[235] = 
				{
					[1] = 0.96,
					[2] = 4.28,
				},
				[236] = 
				{
					[1] = 0.96,
					[2] = 4.29,
				},
				[237] = 
				{
					[1] = 0.96,
					[2] = 4.29,
				},
				[238] = 
				{
					[1] = 0.97,
					[2] = 4.29,
				},
				[239] = 
				{
					[1] = 0.97,
					[2] = 4.29,
				},
				[240] = 
				{
					[1] = 0.98,
					[2] = 4.29,
				},
				[241] = 
				{
					[1] = 0.98,
					[2] = 4.29,
				},
				[242] = 
				{
					[1] = 0.98,
					[2] = 4.29,
				},
				[243] = 
				{
					[1] = 0.99,
					[2] = 4.29,
				},
				[244] = 
				{
					[1] = 0.99,
					[2] = 4.29,
				},
				[245] = 
				{
					[1] = 1,
					[2] = 4.29,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Atlanta",
		["Type"] = "WaterTracer",
	},
	[200] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 212.360825,
			["Lifetime"] = 13.76,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.038,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.39,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 277.797607,
			["Lifetime"] = 18,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0475,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.93,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 49.077576,
			["Lifetime"] = 3.18,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0475,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.46,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Atlanta",
		["Type"] = "WaterTracer",
	},
	[201] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 73.199997,
			["LocalSpace"] = true,
			["MaxSpeed"] = 8.23104,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0683,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 1.82,
				},
				[3] = 
				{
					[1] = 0.03,
					[2] = 2.09,
				},
				[4] = 
				{
					[1] = 0.04,
					[2] = 2.29,
				},
				[5] = 
				{
					[1] = 0.05,
					[2] = 2.49,
				},
				[6] = 
				{
					[1] = 0.07,
					[2] = 2.69,
				},
				[7] = 
				{
					[1] = 0.08,
					[2] = 2.77,
				},
				[8] = 
				{
					[1] = 0.1,
					[2] = 2.86,
				},
				[9] = 
				{
					[1] = 0.11,
					[2] = 2.95,
				},
				[10] = 
				{
					[1] = 0.12,
					[2] = 3.04,
				},
				[11] = 
				{
					[1] = 0.14,
					[2] = 3.12,
				},
				[12] = 
				{
					[1] = 0.15,
					[2] = 3.2,
				},
				[13] = 
				{
					[1] = 0.16,
					[2] = 3.26,
				},
				[14] = 
				{
					[1] = 0.18,
					[2] = 3.35,
				},
				[15] = 
				{
					[1] = 0.19,
					[2] = 3.43,
				},
				[16] = 
				{
					[1] = 0.21,
					[2] = 3.52,
				},
				[17] = 
				{
					[1] = 0.22,
					[2] = 3.61,
				},
				[18] = 
				{
					[1] = 0.23,
					[2] = 3.69,
				},
				[19] = 
				{
					[1] = 0.25,
					[2] = 3.78,
				},
				[20] = 
				{
					[1] = 0.26,
					[2] = 3.87,
				},
				[21] = 
				{
					[1] = 0.27,
					[2] = 3.93,
				},
				[22] = 
				{
					[1] = 0.29,
					[2] = 3.98,
				},
				[23] = 
				{
					[1] = 0.3,
					[2] = 4.02,
				},
				[24] = 
				{
					[1] = 0.32,
					[2] = 4.06,
				},
				[25] = 
				{
					[1] = 0.33,
					[2] = 4.11,
				},
				[26] = 
				{
					[1] = 0.34,
					[2] = 4.15,
				},
				[27] = 
				{
					[1] = 0.36,
					[2] = 4.19,
				},
				[28] = 
				{
					[1] = 0.37,
					[2] = 4.24,
				},
				[29] = 
				{
					[1] = 0.38,
					[2] = 4.27,
				},
				[30] = 
				{
					[1] = 0.4,
					[2] = 4.28,
				},
				[31] = 
				{
					[1] = 0.41,
					[2] = 4.3,
				},
				[32] = 
				{
					[1] = 0.42,
					[2] = 4.31,
				},
				[33] = 
				{
					[1] = 0.44,
					[2] = 4.32,
				},
				[34] = 
				{
					[1] = 0.45,
					[2] = 4.33,
				},
				[35] = 
				{
					[1] = 0.47,
					[2] = 4.35,
				},
				[36] = 
				{
					[1] = 0.48,
					[2] = 4.36,
				},
				[37] = 
				{
					[1] = 0.49,
					[2] = 4.36,
				},
				[38] = 
				{
					[1] = 0.51,
					[2] = 4.36,
				},
				[39] = 
				{
					[1] = 0.52,
					[2] = 4.36,
				},
				[40] = 
				{
					[1] = 0.53,
					[2] = 4.36,
				},
				[41] = 
				{
					[1] = 0.55,
					[2] = 4.36,
				},
				[42] = 
				{
					[1] = 0.56,
					[2] = 4.36,
				},
				[43] = 
				{
					[1] = 0.58,
					[2] = 4.36,
				},
				[44] = 
				{
					[1] = 0.59,
					[2] = 4.36,
				},
				[45] = 
				{
					[1] = 0.6,
					[2] = 4.33,
				},
				[46] = 
				{
					[1] = 0.62,
					[2] = 4.29,
				},
				[47] = 
				{
					[1] = 0.63,
					[2] = 4.24,
				},
				[48] = 
				{
					[1] = 0.64,
					[2] = 4.19,
				},
				[49] = 
				{
					[1] = 0.66,
					[2] = 4.15,
				},
				[50] = 
				{
					[1] = 0.67,
					[2] = 4.1,
				},
				[51] = 
				{
					[1] = 0.68,
					[2] = 4.05,
				},
				[52] = 
				{
					[1] = 0.7,
					[2] = 3.99,
				},
				[53] = 
				{
					[1] = 0.71,
					[2] = 3.91,
				},
				[54] = 
				{
					[1] = 0.73,
					[2] = 3.83,
				},
				[55] = 
				{
					[1] = 0.74,
					[2] = 3.75,
				},
				[56] = 
				{
					[1] = 0.75,
					[2] = 3.67,
				},
				[57] = 
				{
					[1] = 0.77,
					[2] = 3.58,
				},
				[58] = 
				{
					[1] = 0.78,
					[2] = 3.48,
				},
				[59] = 
				{
					[1] = 0.79,
					[2] = 3.39,
				},
				[60] = 
				{
					[1] = 0.81,
					[2] = 3.29,
				},
				[61] = 
				{
					[1] = 0.82,
					[2] = 3.2,
				},
				[62] = 
				{
					[1] = 0.84,
					[2] = 3.1,
				},
				[63] = 
				{
					[1] = 0.85,
					[2] = 3,
				},
				[64] = 
				{
					[1] = 0.86,
					[2] = 2.9,
				},
				[65] = 
				{
					[1] = 0.88,
					[2] = 2.8,
				},
				[66] = 
				{
					[1] = 0.89,
					[2] = 2.7,
				},
				[67] = 
				{
					[1] = 0.9,
					[2] = 2.58,
				},
				[68] = 
				{
					[1] = 0.92,
					[2] = 2.46,
				},
				[69] = 
				{
					[1] = 0.93,
					[2] = 2.34,
				},
				[70] = 
				{
					[1] = 0.95,
					[2] = 2.22,
				},
				[71] = 
				{
					[1] = 0.96,
					[2] = 2.11,
				},
				[72] = 
				{
					[1] = 0.97,
					[2] = 2,
				},
				[73] = 
				{
					[1] = 0.99,
					[2] = 1.91,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 2.14,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.06,
					[2] = 0.34,
				},
				[3] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[4] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[5] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[6] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[7] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[8] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[9] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[10] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[11] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[12] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[13] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[14] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[15] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[16] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[17] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[18] = 
				{
					[1] = 0.94,
					[2] = 0.04,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 8.98,
			["LocalSpace"] = true,
			["MaxSpeed"] = 8.23104,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 2.16,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 2.52,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 2.68,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 2.81,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 2.95,
				},
				[7] = 
				{
					[1] = 0.06,
					[2] = 3.09,
				},
				[8] = 
				{
					[1] = 0.06,
					[2] = 3.22,
				},
				[9] = 
				{
					[1] = 0.07,
					[2] = 3.35,
				},
				[10] = 
				{
					[1] = 0.08,
					[2] = 3.43,
				},
				[11] = 
				{
					[1] = 0.09,
					[2] = 3.47,
				},
				[12] = 
				{
					[1] = 0.1,
					[2] = 3.51,
				},
				[13] = 
				{
					[1] = 0.11,
					[2] = 3.55,
				},
				[14] = 
				{
					[1] = 0.12,
					[2] = 3.58,
				},
				[15] = 
				{
					[1] = 0.13,
					[2] = 3.62,
				},
				[16] = 
				{
					[1] = 0.14,
					[2] = 3.66,
				},
				[17] = 
				{
					[1] = 0.15,
					[2] = 3.69,
				},
				[18] = 
				{
					[1] = 0.16,
					[2] = 3.73,
				},
				[19] = 
				{
					[1] = 0.17,
					[2] = 3.76,
				},
				[20] = 
				{
					[1] = 0.17,
					[2] = 3.77,
				},
				[21] = 
				{
					[1] = 0.18,
					[2] = 3.79,
				},
				[22] = 
				{
					[1] = 0.19,
					[2] = 3.81,
				},
				[23] = 
				{
					[1] = 0.2,
					[2] = 3.83,
				},
				[24] = 
				{
					[1] = 0.21,
					[2] = 3.85,
				},
				[25] = 
				{
					[1] = 0.22,
					[2] = 3.86,
				},
				[26] = 
				{
					[1] = 0.23,
					[2] = 3.88,
				},
				[27] = 
				{
					[1] = 0.24,
					[2] = 3.9,
				},
				[28] = 
				{
					[1] = 0.25,
					[2] = 3.91,
				},
				[29] = 
				{
					[1] = 0.26,
					[2] = 3.92,
				},
				[30] = 
				{
					[1] = 0.27,
					[2] = 3.93,
				},
				[31] = 
				{
					[1] = 0.28,
					[2] = 3.95,
				},
				[32] = 
				{
					[1] = 0.28,
					[2] = 3.95,
				},
				[33] = 
				{
					[1] = 0.29,
					[2] = 3.96,
				},
				[34] = 
				{
					[1] = 0.3,
					[2] = 3.97,
				},
				[35] = 
				{
					[1] = 0.31,
					[2] = 3.98,
				},
				[36] = 
				{
					[1] = 0.32,
					[2] = 4,
				},
				[37] = 
				{
					[1] = 0.33,
					[2] = 4.01,
				},
				[38] = 
				{
					[1] = 0.34,
					[2] = 4.03,
				},
				[39] = 
				{
					[1] = 0.35,
					[2] = 4.04,
				},
				[40] = 
				{
					[1] = 0.36,
					[2] = 4.05,
				},
				[41] = 
				{
					[1] = 0.37,
					[2] = 4.06,
				},
				[42] = 
				{
					[1] = 0.38,
					[2] = 4.08,
				},
				[43] = 
				{
					[1] = 0.39,
					[2] = 4.09,
				},
				[44] = 
				{
					[1] = 0.39,
					[2] = 4.1,
				},
				[45] = 
				{
					[1] = 0.4,
					[2] = 4.11,
				},
				[46] = 
				{
					[1] = 0.41,
					[2] = 4.12,
				},
				[47] = 
				{
					[1] = 0.42,
					[2] = 4.13,
				},
				[48] = 
				{
					[1] = 0.43,
					[2] = 4.14,
				},
				[49] = 
				{
					[1] = 0.44,
					[2] = 4.15,
				},
				[50] = 
				{
					[1] = 0.45,
					[2] = 4.15,
				},
				[51] = 
				{
					[1] = 0.46,
					[2] = 4.14,
				},
				[52] = 
				{
					[1] = 0.47,
					[2] = 4.13,
				},
				[53] = 
				{
					[1] = 0.48,
					[2] = 4.12,
				},
				[54] = 
				{
					[1] = 0.49,
					[2] = 4.11,
				},
				[55] = 
				{
					[1] = 0.5,
					[2] = 4.09,
				},
				[56] = 
				{
					[1] = 0.5,
					[2] = 4.08,
				},
				[57] = 
				{
					[1] = 0.51,
					[2] = 4.07,
				},
				[58] = 
				{
					[1] = 0.52,
					[2] = 4.06,
				},
				[59] = 
				{
					[1] = 0.53,
					[2] = 4.05,
				},
				[60] = 
				{
					[1] = 0.54,
					[2] = 4.03,
				},
				[61] = 
				{
					[1] = 0.55,
					[2] = 4.02,
				},
				[62] = 
				{
					[1] = 0.56,
					[2] = 4.01,
				},
				[63] = 
				{
					[1] = 0.57,
					[2] = 3.99,
				},
				[64] = 
				{
					[1] = 0.58,
					[2] = 3.98,
				},
				[65] = 
				{
					[1] = 0.59,
					[2] = 3.97,
				},
				[66] = 
				{
					[1] = 0.6,
					[2] = 3.95,
				},
				[67] = 
				{
					[1] = 0.61,
					[2] = 3.94,
				},
				[68] = 
				{
					[1] = 0.61,
					[2] = 3.93,
				},
				[69] = 
				{
					[1] = 0.62,
					[2] = 3.91,
				},
				[70] = 
				{
					[1] = 0.63,
					[2] = 3.9,
				},
				[71] = 
				{
					[1] = 0.64,
					[2] = 3.88,
				},
				[72] = 
				{
					[1] = 0.65,
					[2] = 3.87,
				},
				[73] = 
				{
					[1] = 0.66,
					[2] = 3.86,
				},
				[74] = 
				{
					[1] = 0.67,
					[2] = 3.84,
				},
				[75] = 
				{
					[1] = 0.68,
					[2] = 3.83,
				},
				[76] = 
				{
					[1] = 0.69,
					[2] = 3.81,
				},
				[77] = 
				{
					[1] = 0.7,
					[2] = 3.79,
				},
				[78] = 
				{
					[1] = 0.71,
					[2] = 3.78,
				},
				[79] = 
				{
					[1] = 0.72,
					[2] = 3.76,
				},
				[80] = 
				{
					[1] = 0.72,
					[2] = 3.75,
				},
				[81] = 
				{
					[1] = 0.73,
					[2] = 3.73,
				},
				[82] = 
				{
					[1] = 0.74,
					[2] = 3.72,
				},
				[83] = 
				{
					[1] = 0.75,
					[2] = 3.7,
				},
				[84] = 
				{
					[1] = 0.76,
					[2] = 3.68,
				},
				[85] = 
				{
					[1] = 0.77,
					[2] = 3.67,
				},
				[86] = 
				{
					[1] = 0.78,
					[2] = 3.65,
				},
				[87] = 
				{
					[1] = 0.79,
					[2] = 3.63,
				},
				[88] = 
				{
					[1] = 0.8,
					[2] = 3.62,
				},
				[89] = 
				{
					[1] = 0.81,
					[2] = 3.6,
				},
				[90] = 
				{
					[1] = 0.82,
					[2] = 3.58,
				},
				[91] = 
				{
					[1] = 0.83,
					[2] = 3.56,
				},
				[92] = 
				{
					[1] = 0.83,
					[2] = 3.55,
				},
				[93] = 
				{
					[1] = 0.84,
					[2] = 3.53,
				},
				[94] = 
				{
					[1] = 0.85,
					[2] = 3.51,
				},
				[95] = 
				{
					[1] = 0.86,
					[2] = 3.49,
				},
				[96] = 
				{
					[1] = 0.87,
					[2] = 3.47,
				},
				[97] = 
				{
					[1] = 0.88,
					[2] = 3.46,
				},
				[98] = 
				{
					[1] = 0.89,
					[2] = 3.44,
				},
				[99] = 
				{
					[1] = 0.9,
					[2] = 3.42,
				},
				[100] = 
				{
					[1] = 0.91,
					[2] = 3.4,
				},
				[101] = 
				{
					[1] = 0.92,
					[2] = 3.38,
				},
				[102] = 
				{
					[1] = 0.93,
					[2] = 3.36,
				},
				[103] = 
				{
					[1] = 0.94,
					[2] = 3.34,
				},
				[104] = 
				{
					[1] = 0.94,
					[2] = 3.32,
				},
				[105] = 
				{
					[1] = 0.95,
					[2] = 3.3,
				},
				[106] = 
				{
					[1] = 0.96,
					[2] = 3.28,
				},
				[107] = 
				{
					[1] = 0.97,
					[2] = 3.26,
				},
				[108] = 
				{
					[1] = 0.98,
					[2] = 3.24,
				},
				[109] = 
				{
					[1] = 0.99,
					[2] = 3.22,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Big_landing",
		["Type"] = "WaterTracer",
	},
	[202] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 95.150826,
			["Lifetime"] = 11.56,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0741,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.25,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 124.453323,
			["Lifetime"] = 15.12,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0927,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.99,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 21.976877,
			["Lifetime"] = 2.67,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0927,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.28,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Big_landing",
		["Type"] = "WaterTracer",
	},
	[203] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 93.599998,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0534,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.92,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 1.23,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 1.47,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 1.64,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 1.78,
				},
				[7] = 
				{
					[1] = 0.06,
					[2] = 1.92,
				},
				[8] = 
				{
					[1] = 0.08,
					[2] = 2.06,
				},
				[9] = 
				{
					[1] = 0.09,
					[2] = 2.2,
				},
				[10] = 
				{
					[1] = 0.1,
					[2] = 2.33,
				},
				[11] = 
				{
					[1] = 0.11,
					[2] = 2.46,
				},
				[12] = 
				{
					[1] = 0.12,
					[2] = 2.58,
				},
				[13] = 
				{
					[1] = 0.13,
					[2] = 2.69,
				},
				[14] = 
				{
					[1] = 0.14,
					[2] = 2.81,
				},
				[15] = 
				{
					[1] = 0.15,
					[2] = 2.92,
				},
				[16] = 
				{
					[1] = 0.16,
					[2] = 3.04,
				},
				[17] = 
				{
					[1] = 0.17,
					[2] = 3.16,
				},
				[18] = 
				{
					[1] = 0.18,
					[2] = 3.27,
				},
				[19] = 
				{
					[1] = 0.19,
					[2] = 3.38,
				},
				[20] = 
				{
					[1] = 0.2,
					[2] = 3.45,
				},
				[21] = 
				{
					[1] = 0.22,
					[2] = 3.51,
				},
				[22] = 
				{
					[1] = 0.23,
					[2] = 3.58,
				},
				[23] = 
				{
					[1] = 0.24,
					[2] = 3.64,
				},
				[24] = 
				{
					[1] = 0.25,
					[2] = 3.71,
				},
				[25] = 
				{
					[1] = 0.26,
					[2] = 3.77,
				},
				[26] = 
				{
					[1] = 0.27,
					[2] = 3.82,
				},
				[27] = 
				{
					[1] = 0.28,
					[2] = 3.86,
				},
				[28] = 
				{
					[1] = 0.29,
					[2] = 3.91,
				},
				[29] = 
				{
					[1] = 0.3,
					[2] = 3.94,
				},
				[30] = 
				{
					[1] = 0.31,
					[2] = 3.97,
				},
				[31] = 
				{
					[1] = 0.32,
					[2] = 4,
				},
				[32] = 
				{
					[1] = 0.33,
					[2] = 4.03,
				},
				[33] = 
				{
					[1] = 0.34,
					[2] = 4.06,
				},
				[34] = 
				{
					[1] = 0.35,
					[2] = 4.09,
				},
				[35] = 
				{
					[1] = 0.37,
					[2] = 4.12,
				},
				[36] = 
				{
					[1] = 0.38,
					[2] = 4.15,
				},
				[37] = 
				{
					[1] = 0.39,
					[2] = 4.18,
				},
				[38] = 
				{
					[1] = 0.4,
					[2] = 4.21,
				},
				[39] = 
				{
					[1] = 0.41,
					[2] = 4.25,
				},
				[40] = 
				{
					[1] = 0.42,
					[2] = 4.28,
				},
				[41] = 
				{
					[1] = 0.43,
					[2] = 4.32,
				},
				[42] = 
				{
					[1] = 0.44,
					[2] = 4.35,
				},
				[43] = 
				{
					[1] = 0.45,
					[2] = 4.38,
				},
				[44] = 
				{
					[1] = 0.46,
					[2] = 4.4,
				},
				[45] = 
				{
					[1] = 0.47,
					[2] = 4.4,
				},
				[46] = 
				{
					[1] = 0.48,
					[2] = 4.39,
				},
				[47] = 
				{
					[1] = 0.49,
					[2] = 4.39,
				},
				[48] = 
				{
					[1] = 0.51,
					[2] = 4.39,
				},
				[49] = 
				{
					[1] = 0.52,
					[2] = 4.39,
				},
				[50] = 
				{
					[1] = 0.53,
					[2] = 4.38,
				},
				[51] = 
				{
					[1] = 0.54,
					[2] = 4.38,
				},
				[52] = 
				{
					[1] = 0.55,
					[2] = 4.38,
				},
				[53] = 
				{
					[1] = 0.56,
					[2] = 4.38,
				},
				[54] = 
				{
					[1] = 0.57,
					[2] = 4.37,
				},
				[55] = 
				{
					[1] = 0.58,
					[2] = 4.37,
				},
				[56] = 
				{
					[1] = 0.59,
					[2] = 4.37,
				},
				[57] = 
				{
					[1] = 0.6,
					[2] = 4.37,
				},
				[58] = 
				{
					[1] = 0.61,
					[2] = 4.36,
				},
				[59] = 
				{
					[1] = 0.62,
					[2] = 4.34,
				},
				[60] = 
				{
					[1] = 0.63,
					[2] = 4.33,
				},
				[61] = 
				{
					[1] = 0.65,
					[2] = 4.32,
				},
				[62] = 
				{
					[1] = 0.66,
					[2] = 4.3,
				},
				[63] = 
				{
					[1] = 0.67,
					[2] = 4.29,
				},
				[64] = 
				{
					[1] = 0.68,
					[2] = 4.28,
				},
				[65] = 
				{
					[1] = 0.69,
					[2] = 4.26,
				},
				[66] = 
				{
					[1] = 0.7,
					[2] = 4.25,
				},
				[67] = 
				{
					[1] = 0.71,
					[2] = 4.22,
				},
				[68] = 
				{
					[1] = 0.72,
					[2] = 4.15,
				},
				[69] = 
				{
					[1] = 0.73,
					[2] = 4.09,
				},
				[70] = 
				{
					[1] = 0.74,
					[2] = 4.02,
				},
				[71] = 
				{
					[1] = 0.75,
					[2] = 3.95,
				},
				[72] = 
				{
					[1] = 0.76,
					[2] = 3.88,
				},
				[73] = 
				{
					[1] = 0.77,
					[2] = 3.82,
				},
				[74] = 
				{
					[1] = 0.78,
					[2] = 3.75,
				},
				[75] = 
				{
					[1] = 0.8,
					[2] = 3.68,
				},
				[76] = 
				{
					[1] = 0.81,
					[2] = 3.61,
				},
				[77] = 
				{
					[1] = 0.82,
					[2] = 3.54,
				},
				[78] = 
				{
					[1] = 0.83,
					[2] = 3.46,
				},
				[79] = 
				{
					[1] = 0.84,
					[2] = 3.37,
				},
				[80] = 
				{
					[1] = 0.85,
					[2] = 3.29,
				},
				[81] = 
				{
					[1] = 0.86,
					[2] = 3.21,
				},
				[82] = 
				{
					[1] = 0.87,
					[2] = 3.12,
				},
				[83] = 
				{
					[1] = 0.88,
					[2] = 3.04,
				},
				[84] = 
				{
					[1] = 0.89,
					[2] = 2.95,
				},
				[85] = 
				{
					[1] = 0.9,
					[2] = 2.87,
				},
				[86] = 
				{
					[1] = 0.91,
					[2] = 2.77,
				},
				[87] = 
				{
					[1] = 0.92,
					[2] = 2.61,
				},
				[88] = 
				{
					[1] = 0.94,
					[2] = 2.44,
				},
				[89] = 
				{
					[1] = 0.95,
					[2] = 2.28,
				},
				[90] = 
				{
					[1] = 0.96,
					[2] = 2.12,
				},
				[91] = 
				{
					[1] = 0.97,
					[2] = 1.96,
				},
				[92] = 
				{
					[1] = 0.98,
					[2] = 1.63,
				},
				[93] = 
				{
					[1] = 0.99,
					[2] = 1.25,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.09,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[6] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[7] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[10] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[11] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[12] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[13] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[14] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[15] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[16] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[17] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[18] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[19] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[20] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[21] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[22] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[23] = 
				{
					[1] = 0.96,
					[2] = 0.04,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 7.04,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.4,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.64,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.86,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 1.09,
				},
				[6] = 
				{
					[1] = 0.04,
					[2] = 1.21,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.32,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 1.44,
				},
				[9] = 
				{
					[1] = 0.06,
					[2] = 1.55,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 1.67,
				},
				[11] = 
				{
					[1] = 0.07,
					[2] = 1.78,
				},
				[12] = 
				{
					[1] = 0.08,
					[2] = 1.85,
				},
				[13] = 
				{
					[1] = 0.09,
					[2] = 1.9,
				},
				[14] = 
				{
					[1] = 0.09,
					[2] = 1.95,
				},
				[15] = 
				{
					[1] = 0.1,
					[2] = 2,
				},
				[16] = 
				{
					[1] = 0.11,
					[2] = 2.05,
				},
				[17] = 
				{
					[1] = 0.11,
					[2] = 2.1,
				},
				[18] = 
				{
					[1] = 0.12,
					[2] = 2.15,
				},
				[19] = 
				{
					[1] = 0.13,
					[2] = 2.19,
				},
				[20] = 
				{
					[1] = 0.14,
					[2] = 2.24,
				},
				[21] = 
				{
					[1] = 0.14,
					[2] = 2.29,
				},
				[22] = 
				{
					[1] = 0.15,
					[2] = 2.33,
				},
				[23] = 
				{
					[1] = 0.16,
					[2] = 2.38,
				},
				[24] = 
				{
					[1] = 0.16,
					[2] = 2.43,
				},
				[25] = 
				{
					[1] = 0.17,
					[2] = 2.47,
				},
				[26] = 
				{
					[1] = 0.18,
					[2] = 2.49,
				},
				[27] = 
				{
					[1] = 0.19,
					[2] = 2.52,
				},
				[28] = 
				{
					[1] = 0.19,
					[2] = 2.54,
				},
				[29] = 
				{
					[1] = 0.2,
					[2] = 2.57,
				},
				[30] = 
				{
					[1] = 0.21,
					[2] = 2.6,
				},
				[31] = 
				{
					[1] = 0.21,
					[2] = 2.62,
				},
				[32] = 
				{
					[1] = 0.22,
					[2] = 2.64,
				},
				[33] = 
				{
					[1] = 0.23,
					[2] = 2.67,
				},
				[34] = 
				{
					[1] = 0.24,
					[2] = 2.69,
				},
				[35] = 
				{
					[1] = 0.24,
					[2] = 2.72,
				},
				[36] = 
				{
					[1] = 0.25,
					[2] = 2.74,
				},
				[37] = 
				{
					[1] = 0.26,
					[2] = 2.76,
				},
				[38] = 
				{
					[1] = 0.26,
					[2] = 2.78,
				},
				[39] = 
				{
					[1] = 0.27,
					[2] = 2.79,
				},
				[40] = 
				{
					[1] = 0.28,
					[2] = 2.8,
				},
				[41] = 
				{
					[1] = 0.29,
					[2] = 2.81,
				},
				[42] = 
				{
					[1] = 0.29,
					[2] = 2.83,
				},
				[43] = 
				{
					[1] = 0.3,
					[2] = 2.84,
				},
				[44] = 
				{
					[1] = 0.31,
					[2] = 2.85,
				},
				[45] = 
				{
					[1] = 0.31,
					[2] = 2.86,
				},
				[46] = 
				{
					[1] = 0.32,
					[2] = 2.87,
				},
				[47] = 
				{
					[1] = 0.33,
					[2] = 2.88,
				},
				[48] = 
				{
					[1] = 0.34,
					[2] = 2.89,
				},
				[49] = 
				{
					[1] = 0.34,
					[2] = 2.9,
				},
				[50] = 
				{
					[1] = 0.35,
					[2] = 2.91,
				},
				[51] = 
				{
					[1] = 0.36,
					[2] = 2.92,
				},
				[52] = 
				{
					[1] = 0.36,
					[2] = 2.93,
				},
				[53] = 
				{
					[1] = 0.37,
					[2] = 2.94,
				},
				[54] = 
				{
					[1] = 0.38,
					[2] = 2.95,
				},
				[55] = 
				{
					[1] = 0.39,
					[2] = 2.96,
				},
				[56] = 
				{
					[1] = 0.39,
					[2] = 2.97,
				},
				[57] = 
				{
					[1] = 0.4,
					[2] = 2.98,
				},
				[58] = 
				{
					[1] = 0.41,
					[2] = 2.99,
				},
				[59] = 
				{
					[1] = 0.41,
					[2] = 3,
				},
				[60] = 
				{
					[1] = 0.42,
					[2] = 3.01,
				},
				[61] = 
				{
					[1] = 0.43,
					[2] = 3.02,
				},
				[62] = 
				{
					[1] = 0.44,
					[2] = 3.02,
				},
				[63] = 
				{
					[1] = 0.44,
					[2] = 3.03,
				},
				[64] = 
				{
					[1] = 0.45,
					[2] = 3.04,
				},
				[65] = 
				{
					[1] = 0.46,
					[2] = 3.05,
				},
				[66] = 
				{
					[1] = 0.46,
					[2] = 3.05,
				},
				[67] = 
				{
					[1] = 0.47,
					[2] = 3.06,
				},
				[68] = 
				{
					[1] = 0.48,
					[2] = 3.07,
				},
				[69] = 
				{
					[1] = 0.49,
					[2] = 3.07,
				},
				[70] = 
				{
					[1] = 0.49,
					[2] = 3.08,
				},
				[71] = 
				{
					[1] = 0.5,
					[2] = 3.09,
				},
				[72] = 
				{
					[1] = 0.51,
					[2] = 3.09,
				},
				[73] = 
				{
					[1] = 0.51,
					[2] = 3.1,
				},
				[74] = 
				{
					[1] = 0.52,
					[2] = 3.1,
				},
				[75] = 
				{
					[1] = 0.53,
					[2] = 3.11,
				},
				[76] = 
				{
					[1] = 0.54,
					[2] = 3.11,
				},
				[77] = 
				{
					[1] = 0.54,
					[2] = 3.12,
				},
				[78] = 
				{
					[1] = 0.55,
					[2] = 3.12,
				},
				[79] = 
				{
					[1] = 0.56,
					[2] = 3.13,
				},
				[80] = 
				{
					[1] = 0.56,
					[2] = 3.13,
				},
				[81] = 
				{
					[1] = 0.57,
					[2] = 3.14,
				},
				[82] = 
				{
					[1] = 0.58,
					[2] = 3.14,
				},
				[83] = 
				{
					[1] = 0.59,
					[2] = 3.15,
				},
				[84] = 
				{
					[1] = 0.59,
					[2] = 3.15,
				},
				[85] = 
				{
					[1] = 0.6,
					[2] = 3.15,
				},
				[86] = 
				{
					[1] = 0.61,
					[2] = 3.16,
				},
				[87] = 
				{
					[1] = 0.61,
					[2] = 3.16,
				},
				[88] = 
				{
					[1] = 0.62,
					[2] = 3.16,
				},
				[89] = 
				{
					[1] = 0.63,
					[2] = 3.16,
				},
				[90] = 
				{
					[1] = 0.64,
					[2] = 3.17,
				},
				[91] = 
				{
					[1] = 0.64,
					[2] = 3.17,
				},
				[92] = 
				{
					[1] = 0.65,
					[2] = 3.17,
				},
				[93] = 
				{
					[1] = 0.66,
					[2] = 3.17,
				},
				[94] = 
				{
					[1] = 0.66,
					[2] = 3.17,
				},
				[95] = 
				{
					[1] = 0.67,
					[2] = 3.17,
				},
				[96] = 
				{
					[1] = 0.68,
					[2] = 3.17,
				},
				[97] = 
				{
					[1] = 0.69,
					[2] = 3.17,
				},
				[98] = 
				{
					[1] = 0.69,
					[2] = 3.17,
				},
				[99] = 
				{
					[1] = 0.7,
					[2] = 3.17,
				},
				[100] = 
				{
					[1] = 0.71,
					[2] = 3.17,
				},
				[101] = 
				{
					[1] = 0.71,
					[2] = 3.16,
				},
				[102] = 
				{
					[1] = 0.72,
					[2] = 3.16,
				},
				[103] = 
				{
					[1] = 0.73,
					[2] = 3.16,
				},
				[104] = 
				{
					[1] = 0.74,
					[2] = 3.15,
				},
				[105] = 
				{
					[1] = 0.74,
					[2] = 3.15,
				},
				[106] = 
				{
					[1] = 0.75,
					[2] = 3.15,
				},
				[107] = 
				{
					[1] = 0.76,
					[2] = 3.14,
				},
				[108] = 
				{
					[1] = 0.76,
					[2] = 3.14,
				},
				[109] = 
				{
					[1] = 0.77,
					[2] = 3.14,
				},
				[110] = 
				{
					[1] = 0.78,
					[2] = 3.13,
				},
				[111] = 
				{
					[1] = 0.79,
					[2] = 3.13,
				},
				[112] = 
				{
					[1] = 0.79,
					[2] = 3.12,
				},
				[113] = 
				{
					[1] = 0.8,
					[2] = 3.12,
				},
				[114] = 
				{
					[1] = 0.81,
					[2] = 3.11,
				},
				[115] = 
				{
					[1] = 0.81,
					[2] = 3.11,
				},
				[116] = 
				{
					[1] = 0.82,
					[2] = 3.1,
				},
				[117] = 
				{
					[1] = 0.83,
					[2] = 3.1,
				},
				[118] = 
				{
					[1] = 0.84,
					[2] = 3.09,
				},
				[119] = 
				{
					[1] = 0.84,
					[2] = 3.09,
				},
				[120] = 
				{
					[1] = 0.85,
					[2] = 3.08,
				},
				[121] = 
				{
					[1] = 0.86,
					[2] = 3.08,
				},
				[122] = 
				{
					[1] = 0.86,
					[2] = 3.07,
				},
				[123] = 
				{
					[1] = 0.87,
					[2] = 3.06,
				},
				[124] = 
				{
					[1] = 0.88,
					[2] = 3.06,
				},
				[125] = 
				{
					[1] = 0.89,
					[2] = 3.05,
				},
				[126] = 
				{
					[1] = 0.89,
					[2] = 3.04,
				},
				[127] = 
				{
					[1] = 0.9,
					[2] = 3.04,
				},
				[128] = 
				{
					[1] = 0.91,
					[2] = 3.03,
				},
				[129] = 
				{
					[1] = 0.91,
					[2] = 3.02,
				},
				[130] = 
				{
					[1] = 0.92,
					[2] = 3.02,
				},
				[131] = 
				{
					[1] = 0.93,
					[2] = 3.01,
				},
				[132] = 
				{
					[1] = 0.94,
					[2] = 3,
				},
				[133] = 
				{
					[1] = 0.94,
					[2] = 2.99,
				},
				[134] = 
				{
					[1] = 0.95,
					[2] = 2.99,
				},
				[135] = 
				{
					[1] = 0.96,
					[2] = 2.98,
				},
				[136] = 
				{
					[1] = 0.96,
					[2] = 2.97,
				},
				[137] = 
				{
					[1] = 0.97,
					[2] = 2.96,
				},
				[138] = 
				{
					[1] = 0.98,
					[2] = 2.95,
				},
				[139] = 
				{
					[1] = 0.99,
					[2] = 2.94,
				},
				[140] = 
				{
					[1] = 0.99,
					[2] = 2.93,
				},
			},
			["WidthScale"] = 0.8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_clemson",
		["Type"] = "WaterTracer",
	},
	[204] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 121.716507,
			["Lifetime"] = 6.76,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0792,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.1,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 159.16774,
			["Lifetime"] = 8.84,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.099,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.93,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 28.088425,
			["Lifetime"] = 1.56,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.099,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.14,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_clemson",
		["Type"] = "WaterTracer",
	},
	[205] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 177.600006,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0282,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.32,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.42,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.52,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.62,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 0.72,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 0.83,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 0.93,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.04,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 1.16,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 1.28,
				},
				[12] = 
				{
					[1] = 0.06,
					[2] = 1.4,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 1.52,
				},
				[14] = 
				{
					[1] = 0.07,
					[2] = 1.64,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 1.76,
				},
				[16] = 
				{
					[1] = 0.08,
					[2] = 1.88,
				},
				[17] = 
				{
					[1] = 0.09,
					[2] = 2.01,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 2.17,
				},
				[19] = 
				{
					[1] = 0.1,
					[2] = 2.33,
				},
				[20] = 
				{
					[1] = 0.11,
					[2] = 2.48,
				},
				[21] = 
				{
					[1] = 0.11,
					[2] = 2.64,
				},
				[22] = 
				{
					[1] = 0.12,
					[2] = 2.79,
				},
				[23] = 
				{
					[1] = 0.12,
					[2] = 2.95,
				},
				[24] = 
				{
					[1] = 0.13,
					[2] = 3.1,
				},
				[25] = 
				{
					[1] = 0.14,
					[2] = 3.26,
				},
				[26] = 
				{
					[1] = 0.14,
					[2] = 3.42,
				},
				[27] = 
				{
					[1] = 0.15,
					[2] = 3.57,
				},
				[28] = 
				{
					[1] = 0.15,
					[2] = 3.73,
				},
				[29] = 
				{
					[1] = 0.16,
					[2] = 3.88,
				},
				[30] = 
				{
					[1] = 0.16,
					[2] = 4.04,
				},
				[31] = 
				{
					[1] = 0.17,
					[2] = 4.16,
				},
				[32] = 
				{
					[1] = 0.18,
					[2] = 4.28,
				},
				[33] = 
				{
					[1] = 0.18,
					[2] = 4.41,
				},
				[34] = 
				{
					[1] = 0.19,
					[2] = 4.53,
				},
				[35] = 
				{
					[1] = 0.19,
					[2] = 4.65,
				},
				[36] = 
				{
					[1] = 0.2,
					[2] = 4.77,
				},
				[37] = 
				{
					[1] = 0.2,
					[2] = 4.9,
				},
				[38] = 
				{
					[1] = 0.21,
					[2] = 5.02,
				},
				[39] = 
				{
					[1] = 0.21,
					[2] = 5.14,
				},
				[40] = 
				{
					[1] = 0.22,
					[2] = 5.26,
				},
				[41] = 
				{
					[1] = 0.23,
					[2] = 5.39,
				},
				[42] = 
				{
					[1] = 0.23,
					[2] = 5.52,
				},
				[43] = 
				{
					[1] = 0.24,
					[2] = 5.67,
				},
				[44] = 
				{
					[1] = 0.24,
					[2] = 5.83,
				},
				[45] = 
				{
					[1] = 0.25,
					[2] = 5.98,
				},
				[46] = 
				{
					[1] = 0.25,
					[2] = 6.13,
				},
				[47] = 
				{
					[1] = 0.26,
					[2] = 6.28,
				},
				[48] = 
				{
					[1] = 0.27,
					[2] = 6.43,
				},
				[49] = 
				{
					[1] = 0.27,
					[2] = 6.58,
				},
				[50] = 
				{
					[1] = 0.28,
					[2] = 6.73,
				},
				[51] = 
				{
					[1] = 0.28,
					[2] = 6.89,
				},
				[52] = 
				{
					[1] = 0.29,
					[2] = 7.03,
				},
				[53] = 
				{
					[1] = 0.29,
					[2] = 7.19,
				},
				[54] = 
				{
					[1] = 0.3,
					[2] = 7.34,
				},
				[55] = 
				{
					[1] = 0.31,
					[2] = 7.49,
				},
				[56] = 
				{
					[1] = 0.31,
					[2] = 7.64,
				},
				[57] = 
				{
					[1] = 0.32,
					[2] = 7.79,
				},
				[58] = 
				{
					[1] = 0.32,
					[2] = 7.94,
				},
				[59] = 
				{
					[1] = 0.33,
					[2] = 8.08,
				},
				[60] = 
				{
					[1] = 0.33,
					[2] = 8.15,
				},
				[61] = 
				{
					[1] = 0.34,
					[2] = 8.21,
				},
				[62] = 
				{
					[1] = 0.34,
					[2] = 8.28,
				},
				[63] = 
				{
					[1] = 0.35,
					[2] = 8.35,
				},
				[64] = 
				{
					[1] = 0.36,
					[2] = 8.41,
				},
				[65] = 
				{
					[1] = 0.36,
					[2] = 8.48,
				},
				[66] = 
				{
					[1] = 0.37,
					[2] = 8.54,
				},
				[67] = 
				{
					[1] = 0.37,
					[2] = 8.61,
				},
				[68] = 
				{
					[1] = 0.38,
					[2] = 8.63,
				},
				[69] = 
				{
					[1] = 0.38,
					[2] = 8.65,
				},
				[70] = 
				{
					[1] = 0.39,
					[2] = 8.67,
				},
				[71] = 
				{
					[1] = 0.4,
					[2] = 8.69,
				},
				[72] = 
				{
					[1] = 0.4,
					[2] = 8.71,
				},
				[73] = 
				{
					[1] = 0.41,
					[2] = 8.73,
				},
				[74] = 
				{
					[1] = 0.41,
					[2] = 8.75,
				},
				[75] = 
				{
					[1] = 0.42,
					[2] = 8.77,
				},
				[76] = 
				{
					[1] = 0.42,
					[2] = 8.79,
				},
				[77] = 
				{
					[1] = 0.43,
					[2] = 8.81,
				},
				[78] = 
				{
					[1] = 0.44,
					[2] = 8.83,
				},
				[79] = 
				{
					[1] = 0.44,
					[2] = 8.84,
				},
				[80] = 
				{
					[1] = 0.45,
					[2] = 8.85,
				},
				[81] = 
				{
					[1] = 0.45,
					[2] = 8.86,
				},
				[82] = 
				{
					[1] = 0.46,
					[2] = 8.88,
				},
				[83] = 
				{
					[1] = 0.46,
					[2] = 8.89,
				},
				[84] = 
				{
					[1] = 0.47,
					[2] = 8.9,
				},
				[85] = 
				{
					[1] = 0.47,
					[2] = 8.91,
				},
				[86] = 
				{
					[1] = 0.48,
					[2] = 8.93,
				},
				[87] = 
				{
					[1] = 0.49,
					[2] = 8.94,
				},
				[88] = 
				{
					[1] = 0.49,
					[2] = 8.95,
				},
				[89] = 
				{
					[1] = 0.5,
					[2] = 8.96,
				},
				[90] = 
				{
					[1] = 0.5,
					[2] = 8.98,
				},
				[91] = 
				{
					[1] = 0.51,
					[2] = 8.99,
				},
				[92] = 
				{
					[1] = 0.51,
					[2] = 9,
				},
				[93] = 
				{
					[1] = 0.52,
					[2] = 9.01,
				},
				[94] = 
				{
					[1] = 0.53,
					[2] = 9.03,
				},
				[95] = 
				{
					[1] = 0.53,
					[2] = 9.04,
				},
				[96] = 
				{
					[1] = 0.54,
					[2] = 9.05,
				},
				[97] = 
				{
					[1] = 0.54,
					[2] = 9.06,
				},
				[98] = 
				{
					[1] = 0.55,
					[2] = 9.08,
				},
				[99] = 
				{
					[1] = 0.55,
					[2] = 9.09,
				},
				[100] = 
				{
					[1] = 0.56,
					[2] = 9.1,
				},
				[101] = 
				{
					[1] = 0.56,
					[2] = 9.11,
				},
				[102] = 
				{
					[1] = 0.57,
					[2] = 9.13,
				},
				[103] = 
				{
					[1] = 0.58,
					[2] = 9.14,
				},
				[104] = 
				{
					[1] = 0.58,
					[2] = 9.15,
				},
				[105] = 
				{
					[1] = 0.59,
					[2] = 9.16,
				},
				[106] = 
				{
					[1] = 0.59,
					[2] = 9.18,
				},
				[107] = 
				{
					[1] = 0.6,
					[2] = 9.19,
				},
				[108] = 
				{
					[1] = 0.6,
					[2] = 9.2,
				},
				[109] = 
				{
					[1] = 0.61,
					[2] = 9.21,
				},
				[110] = 
				{
					[1] = 0.62,
					[2] = 9.19,
				},
				[111] = 
				{
					[1] = 0.62,
					[2] = 9.18,
				},
				[112] = 
				{
					[1] = 0.63,
					[2] = 9.16,
				},
				[113] = 
				{
					[1] = 0.63,
					[2] = 9.14,
				},
				[114] = 
				{
					[1] = 0.64,
					[2] = 9.13,
				},
				[115] = 
				{
					[1] = 0.64,
					[2] = 9.11,
				},
				[116] = 
				{
					[1] = 0.65,
					[2] = 9.09,
				},
				[117] = 
				{
					[1] = 0.66,
					[2] = 9.08,
				},
				[118] = 
				{
					[1] = 0.66,
					[2] = 9.06,
				},
				[119] = 
				{
					[1] = 0.67,
					[2] = 9.05,
				},
				[120] = 
				{
					[1] = 0.67,
					[2] = 9.03,
				},
				[121] = 
				{
					[1] = 0.68,
					[2] = 9.01,
				},
				[122] = 
				{
					[1] = 0.68,
					[2] = 8.99,
				},
				[123] = 
				{
					[1] = 0.69,
					[2] = 8.97,
				},
				[124] = 
				{
					[1] = 0.69,
					[2] = 8.95,
				},
				[125] = 
				{
					[1] = 0.7,
					[2] = 8.93,
				},
				[126] = 
				{
					[1] = 0.71,
					[2] = 8.91,
				},
				[127] = 
				{
					[1] = 0.71,
					[2] = 8.89,
				},
				[128] = 
				{
					[1] = 0.72,
					[2] = 8.87,
				},
				[129] = 
				{
					[1] = 0.72,
					[2] = 8.85,
				},
				[130] = 
				{
					[1] = 0.73,
					[2] = 8.83,
				},
				[131] = 
				{
					[1] = 0.73,
					[2] = 8.81,
				},
				[132] = 
				{
					[1] = 0.74,
					[2] = 8.78,
				},
				[133] = 
				{
					[1] = 0.75,
					[2] = 8.76,
				},
				[134] = 
				{
					[1] = 0.75,
					[2] = 8.73,
				},
				[135] = 
				{
					[1] = 0.76,
					[2] = 8.71,
				},
				[136] = 
				{
					[1] = 0.76,
					[2] = 8.68,
				},
				[137] = 
				{
					[1] = 0.77,
					[2] = 8.66,
				},
				[138] = 
				{
					[1] = 0.77,
					[2] = 8.63,
				},
				[139] = 
				{
					[1] = 0.78,
					[2] = 8.61,
				},
				[140] = 
				{
					[1] = 0.79,
					[2] = 8.58,
				},
				[141] = 
				{
					[1] = 0.79,
					[2] = 8.56,
				},
				[142] = 
				{
					[1] = 0.8,
					[2] = 8.53,
				},
				[143] = 
				{
					[1] = 0.8,
					[2] = 8.51,
				},
				[144] = 
				{
					[1] = 0.81,
					[2] = 8.48,
				},
				[145] = 
				{
					[1] = 0.81,
					[2] = 8.46,
				},
				[146] = 
				{
					[1] = 0.82,
					[2] = 8.43,
				},
				[147] = 
				{
					[1] = 0.82,
					[2] = 8.4,
				},
				[148] = 
				{
					[1] = 0.83,
					[2] = 8.34,
				},
				[149] = 
				{
					[1] = 0.84,
					[2] = 8.28,
				},
				[150] = 
				{
					[1] = 0.84,
					[2] = 8.22,
				},
				[151] = 
				{
					[1] = 0.85,
					[2] = 8.16,
				},
				[152] = 
				{
					[1] = 0.85,
					[2] = 8.09,
				},
				[153] = 
				{
					[1] = 0.86,
					[2] = 8.03,
				},
				[154] = 
				{
					[1] = 0.86,
					[2] = 7.97,
				},
				[155] = 
				{
					[1] = 0.87,
					[2] = 7.91,
				},
				[156] = 
				{
					[1] = 0.88,
					[2] = 7.85,
				},
				[157] = 
				{
					[1] = 0.88,
					[2] = 7.78,
				},
				[158] = 
				{
					[1] = 0.89,
					[2] = 7.72,
				},
				[159] = 
				{
					[1] = 0.89,
					[2] = 7.66,
				},
				[160] = 
				{
					[1] = 0.9,
					[2] = 7.6,
				},
				[161] = 
				{
					[1] = 0.9,
					[2] = 7.54,
				},
				[162] = 
				{
					[1] = 0.91,
					[2] = 7.48,
				},
				[163] = 
				{
					[1] = 0.92,
					[2] = 7.41,
				},
				[164] = 
				{
					[1] = 0.92,
					[2] = 7.36,
				},
				[165] = 
				{
					[1] = 0.93,
					[2] = 7.31,
				},
				[166] = 
				{
					[1] = 0.93,
					[2] = 7.26,
				},
				[167] = 
				{
					[1] = 0.94,
					[2] = 7.21,
				},
				[168] = 
				{
					[1] = 0.94,
					[2] = 7.16,
				},
				[169] = 
				{
					[1] = 0.95,
					[2] = 7.1,
				},
				[170] = 
				{
					[1] = 0.95,
					[2] = 7.05,
				},
				[171] = 
				{
					[1] = 0.96,
					[2] = 7,
				},
				[172] = 
				{
					[1] = 0.97,
					[2] = 6.8,
				},
				[173] = 
				{
					[1] = 0.97,
					[2] = 6.54,
				},
				[174] = 
				{
					[1] = 0.98,
					[2] = 6.29,
				},
				[175] = 
				{
					[1] = 0.98,
					[2] = 5.96,
				},
				[176] = 
				{
					[1] = 0.99,
					[2] = 5.16,
				},
				[177] = 
				{
					[1] = 0.99,
					[2] = 4.37,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.92,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.23,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.31,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[5] = 
				{
					[1] = 0.09,
					[2] = 0.41,
				},
				[6] = 
				{
					[1] = 0.11,
					[2] = 0.44,
				},
				[7] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[8] = 
				{
					[1] = 0.16,
					[2] = 0.47,
				},
				[9] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[11] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.3,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.32,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.34,
					[2] = 0.48,
				},
				[17] = 
				{
					[1] = 0.36,
					[2] = 0.47,
				},
				[18] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[19] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[20] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[21] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[22] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[23] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[24] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[25] = 
				{
					[1] = 0.55,
					[2] = 0.37,
				},
				[26] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[27] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[28] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[29] = 
				{
					[1] = 0.64,
					[2] = 0.3,
				},
				[30] = 
				{
					[1] = 0.66,
					[2] = 0.28,
				},
				[31] = 
				{
					[1] = 0.68,
					[2] = 0.26,
				},
				[32] = 
				{
					[1] = 0.7,
					[2] = 0.24,
				},
				[33] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[34] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[35] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[36] = 
				{
					[1] = 0.8,
					[2] = 0.17,
				},
				[37] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[38] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[39] = 
				{
					[1] = 0.86,
					[2] = 0.11,
				},
				[40] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[41] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[42] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[43] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[44] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 13.64,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.47,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.49,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.51,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.53,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.55,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.57,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.58,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.6,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.62,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 0.64,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 0.65,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 0.67,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 0.69,
				},
				[15] = 
				{
					[1] = 0.05,
					[2] = 0.71,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 0.72,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 0.74,
				},
				[18] = 
				{
					[1] = 0.06,
					[2] = 0.76,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 0.77,
				},
				[20] = 
				{
					[1] = 0.07,
					[2] = 0.79,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 0.81,
				},
				[22] = 
				{
					[1] = 0.08,
					[2] = 0.82,
				},
				[23] = 
				{
					[1] = 0.08,
					[2] = 0.84,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 0.86,
				},
				[25] = 
				{
					[1] = 0.09,
					[2] = 0.87,
				},
				[26] = 
				{
					[1] = 0.09,
					[2] = 0.89,
				},
				[27] = 
				{
					[1] = 0.1,
					[2] = 0.91,
				},
				[28] = 
				{
					[1] = 0.1,
					[2] = 0.92,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 0.94,
				},
				[30] = 
				{
					[1] = 0.11,
					[2] = 0.96,
				},
				[31] = 
				{
					[1] = 0.11,
					[2] = 0.98,
				},
				[32] = 
				{
					[1] = 0.12,
					[2] = 0.99,
				},
				[33] = 
				{
					[1] = 0.12,
					[2] = 1.01,
				},
				[34] = 
				{
					[1] = 0.12,
					[2] = 1.03,
				},
				[35] = 
				{
					[1] = 0.13,
					[2] = 1.05,
				},
				[36] = 
				{
					[1] = 0.13,
					[2] = 1.06,
				},
				[37] = 
				{
					[1] = 0.14,
					[2] = 1.08,
				},
				[38] = 
				{
					[1] = 0.14,
					[2] = 1.1,
				},
				[39] = 
				{
					[1] = 0.14,
					[2] = 1.11,
				},
				[40] = 
				{
					[1] = 0.15,
					[2] = 1.13,
				},
				[41] = 
				{
					[1] = 0.15,
					[2] = 1.15,
				},
				[42] = 
				{
					[1] = 0.15,
					[2] = 1.16,
				},
				[43] = 
				{
					[1] = 0.16,
					[2] = 1.18,
				},
				[44] = 
				{
					[1] = 0.16,
					[2] = 1.2,
				},
				[45] = 
				{
					[1] = 0.17,
					[2] = 1.21,
				},
				[46] = 
				{
					[1] = 0.17,
					[2] = 1.23,
				},
				[47] = 
				{
					[1] = 0.17,
					[2] = 1.25,
				},
				[48] = 
				{
					[1] = 0.18,
					[2] = 1.26,
				},
				[49] = 
				{
					[1] = 0.18,
					[2] = 1.28,
				},
				[50] = 
				{
					[1] = 0.18,
					[2] = 1.29,
				},
				[51] = 
				{
					[1] = 0.19,
					[2] = 1.31,
				},
				[52] = 
				{
					[1] = 0.19,
					[2] = 1.33,
				},
				[53] = 
				{
					[1] = 0.2,
					[2] = 1.34,
				},
				[54] = 
				{
					[1] = 0.2,
					[2] = 1.36,
				},
				[55] = 
				{
					[1] = 0.2,
					[2] = 1.37,
				},
				[56] = 
				{
					[1] = 0.21,
					[2] = 1.39,
				},
				[57] = 
				{
					[1] = 0.21,
					[2] = 1.4,
				},
				[58] = 
				{
					[1] = 0.21,
					[2] = 1.42,
				},
				[59] = 
				{
					[1] = 0.22,
					[2] = 1.43,
				},
				[60] = 
				{
					[1] = 0.22,
					[2] = 1.45,
				},
				[61] = 
				{
					[1] = 0.23,
					[2] = 1.46,
				},
				[62] = 
				{
					[1] = 0.23,
					[2] = 1.48,
				},
				[63] = 
				{
					[1] = 0.23,
					[2] = 1.49,
				},
				[64] = 
				{
					[1] = 0.24,
					[2] = 1.51,
				},
				[65] = 
				{
					[1] = 0.24,
					[2] = 1.52,
				},
				[66] = 
				{
					[1] = 0.24,
					[2] = 1.54,
				},
				[67] = 
				{
					[1] = 0.25,
					[2] = 1.55,
				},
				[68] = 
				{
					[1] = 0.25,
					[2] = 1.57,
				},
				[69] = 
				{
					[1] = 0.26,
					[2] = 1.58,
				},
				[70] = 
				{
					[1] = 0.26,
					[2] = 1.6,
				},
				[71] = 
				{
					[1] = 0.26,
					[2] = 1.61,
				},
				[72] = 
				{
					[1] = 0.27,
					[2] = 1.63,
				},
				[73] = 
				{
					[1] = 0.27,
					[2] = 1.64,
				},
				[74] = 
				{
					[1] = 0.27,
					[2] = 1.65,
				},
				[75] = 
				{
					[1] = 0.28,
					[2] = 1.67,
				},
				[76] = 
				{
					[1] = 0.28,
					[2] = 1.68,
				},
				[77] = 
				{
					[1] = 0.29,
					[2] = 1.7,
				},
				[78] = 
				{
					[1] = 0.29,
					[2] = 1.72,
				},
				[79] = 
				{
					[1] = 0.29,
					[2] = 1.73,
				},
				[80] = 
				{
					[1] = 0.3,
					[2] = 1.75,
				},
				[81] = 
				{
					[1] = 0.3,
					[2] = 1.77,
				},
				[82] = 
				{
					[1] = 0.3,
					[2] = 1.78,
				},
				[83] = 
				{
					[1] = 0.31,
					[2] = 1.8,
				},
				[84] = 
				{
					[1] = 0.31,
					[2] = 1.82,
				},
				[85] = 
				{
					[1] = 0.32,
					[2] = 1.83,
				},
				[86] = 
				{
					[1] = 0.32,
					[2] = 1.85,
				},
				[87] = 
				{
					[1] = 0.32,
					[2] = 1.86,
				},
				[88] = 
				{
					[1] = 0.33,
					[2] = 1.88,
				},
				[89] = 
				{
					[1] = 0.33,
					[2] = 1.9,
				},
				[90] = 
				{
					[1] = 0.33,
					[2] = 1.91,
				},
				[91] = 
				{
					[1] = 0.34,
					[2] = 1.93,
				},
				[92] = 
				{
					[1] = 0.34,
					[2] = 1.94,
				},
				[93] = 
				{
					[1] = 0.35,
					[2] = 1.96,
				},
				[94] = 
				{
					[1] = 0.35,
					[2] = 1.97,
				},
				[95] = 
				{
					[1] = 0.35,
					[2] = 1.99,
				},
				[96] = 
				{
					[1] = 0.36,
					[2] = 2,
				},
				[97] = 
				{
					[1] = 0.36,
					[2] = 2.02,
				},
				[98] = 
				{
					[1] = 0.36,
					[2] = 2.03,
				},
				[99] = 
				{
					[1] = 0.37,
					[2] = 2.05,
				},
				[100] = 
				{
					[1] = 0.37,
					[2] = 2.06,
				},
				[101] = 
				{
					[1] = 0.38,
					[2] = 2.08,
				},
				[102] = 
				{
					[1] = 0.38,
					[2] = 2.09,
				},
				[103] = 
				{
					[1] = 0.38,
					[2] = 2.11,
				},
				[104] = 
				{
					[1] = 0.39,
					[2] = 2.12,
				},
				[105] = 
				{
					[1] = 0.39,
					[2] = 2.14,
				},
				[106] = 
				{
					[1] = 0.39,
					[2] = 2.15,
				},
				[107] = 
				{
					[1] = 0.4,
					[2] = 2.17,
				},
				[108] = 
				{
					[1] = 0.4,
					[2] = 2.18,
				},
				[109] = 
				{
					[1] = 0.41,
					[2] = 2.19,
				},
				[110] = 
				{
					[1] = 0.41,
					[2] = 2.21,
				},
				[111] = 
				{
					[1] = 0.41,
					[2] = 2.22,
				},
				[112] = 
				{
					[1] = 0.42,
					[2] = 2.24,
				},
				[113] = 
				{
					[1] = 0.42,
					[2] = 2.25,
				},
				[114] = 
				{
					[1] = 0.42,
					[2] = 2.26,
				},
				[115] = 
				{
					[1] = 0.43,
					[2] = 2.28,
				},
				[116] = 
				{
					[1] = 0.43,
					[2] = 2.29,
				},
				[117] = 
				{
					[1] = 0.44,
					[2] = 2.3,
				},
				[118] = 
				{
					[1] = 0.44,
					[2] = 2.32,
				},
				[119] = 
				{
					[1] = 0.44,
					[2] = 2.33,
				},
				[120] = 
				{
					[1] = 0.45,
					[2] = 2.34,
				},
				[121] = 
				{
					[1] = 0.45,
					[2] = 2.36,
				},
				[122] = 
				{
					[1] = 0.45,
					[2] = 2.37,
				},
				[123] = 
				{
					[1] = 0.46,
					[2] = 2.38,
				},
				[124] = 
				{
					[1] = 0.46,
					[2] = 2.39,
				},
				[125] = 
				{
					[1] = 0.47,
					[2] = 2.41,
				},
				[126] = 
				{
					[1] = 0.47,
					[2] = 2.42,
				},
				[127] = 
				{
					[1] = 0.47,
					[2] = 2.43,
				},
				[128] = 
				{
					[1] = 0.48,
					[2] = 2.44,
				},
				[129] = 
				{
					[1] = 0.48,
					[2] = 2.46,
				},
				[130] = 
				{
					[1] = 0.48,
					[2] = 2.47,
				},
				[131] = 
				{
					[1] = 0.49,
					[2] = 2.48,
				},
				[132] = 
				{
					[1] = 0.49,
					[2] = 2.49,
				},
				[133] = 
				{
					[1] = 0.5,
					[2] = 2.5,
				},
				[134] = 
				{
					[1] = 0.5,
					[2] = 2.52,
				},
				[135] = 
				{
					[1] = 0.5,
					[2] = 2.53,
				},
				[136] = 
				{
					[1] = 0.51,
					[2] = 2.54,
				},
				[137] = 
				{
					[1] = 0.51,
					[2] = 2.55,
				},
				[138] = 
				{
					[1] = 0.52,
					[2] = 2.56,
				},
				[139] = 
				{
					[1] = 0.52,
					[2] = 2.57,
				},
				[140] = 
				{
					[1] = 0.52,
					[2] = 2.58,
				},
				[141] = 
				{
					[1] = 0.53,
					[2] = 2.6,
				},
				[142] = 
				{
					[1] = 0.53,
					[2] = 2.61,
				},
				[143] = 
				{
					[1] = 0.53,
					[2] = 2.62,
				},
				[144] = 
				{
					[1] = 0.54,
					[2] = 2.63,
				},
				[145] = 
				{
					[1] = 0.54,
					[2] = 2.64,
				},
				[146] = 
				{
					[1] = 0.55,
					[2] = 2.65,
				},
				[147] = 
				{
					[1] = 0.55,
					[2] = 2.66,
				},
				[148] = 
				{
					[1] = 0.55,
					[2] = 2.67,
				},
				[149] = 
				{
					[1] = 0.56,
					[2] = 2.68,
				},
				[150] = 
				{
					[1] = 0.56,
					[2] = 2.69,
				},
				[151] = 
				{
					[1] = 0.56,
					[2] = 2.7,
				},
				[152] = 
				{
					[1] = 0.57,
					[2] = 2.71,
				},
				[153] = 
				{
					[1] = 0.57,
					[2] = 2.72,
				},
				[154] = 
				{
					[1] = 0.58,
					[2] = 2.73,
				},
				[155] = 
				{
					[1] = 0.58,
					[2] = 2.74,
				},
				[156] = 
				{
					[1] = 0.58,
					[2] = 2.75,
				},
				[157] = 
				{
					[1] = 0.59,
					[2] = 2.76,
				},
				[158] = 
				{
					[1] = 0.59,
					[2] = 2.77,
				},
				[159] = 
				{
					[1] = 0.59,
					[2] = 2.79,
				},
				[160] = 
				{
					[1] = 0.6,
					[2] = 2.8,
				},
				[161] = 
				{
					[1] = 0.6,
					[2] = 2.82,
				},
				[162] = 
				{
					[1] = 0.61,
					[2] = 2.83,
				},
				[163] = 
				{
					[1] = 0.61,
					[2] = 2.85,
				},
				[164] = 
				{
					[1] = 0.61,
					[2] = 2.86,
				},
				[165] = 
				{
					[1] = 0.62,
					[2] = 2.87,
				},
				[166] = 
				{
					[1] = 0.62,
					[2] = 2.89,
				},
				[167] = 
				{
					[1] = 0.62,
					[2] = 2.9,
				},
				[168] = 
				{
					[1] = 0.63,
					[2] = 2.91,
				},
				[169] = 
				{
					[1] = 0.63,
					[2] = 2.93,
				},
				[170] = 
				{
					[1] = 0.64,
					[2] = 2.94,
				},
				[171] = 
				{
					[1] = 0.64,
					[2] = 2.95,
				},
				[172] = 
				{
					[1] = 0.64,
					[2] = 2.97,
				},
				[173] = 
				{
					[1] = 0.65,
					[2] = 2.98,
				},
				[174] = 
				{
					[1] = 0.65,
					[2] = 2.99,
				},
				[175] = 
				{
					[1] = 0.65,
					[2] = 3,
				},
				[176] = 
				{
					[1] = 0.66,
					[2] = 3.02,
				},
				[177] = 
				{
					[1] = 0.66,
					[2] = 3.03,
				},
				[178] = 
				{
					[1] = 0.67,
					[2] = 3.04,
				},
				[179] = 
				{
					[1] = 0.67,
					[2] = 3.05,
				},
				[180] = 
				{
					[1] = 0.67,
					[2] = 3.07,
				},
				[181] = 
				{
					[1] = 0.68,
					[2] = 3.08,
				},
				[182] = 
				{
					[1] = 0.68,
					[2] = 3.09,
				},
				[183] = 
				{
					[1] = 0.68,
					[2] = 3.1,
				},
				[184] = 
				{
					[1] = 0.69,
					[2] = 3.11,
				},
				[185] = 
				{
					[1] = 0.69,
					[2] = 3.12,
				},
				[186] = 
				{
					[1] = 0.7,
					[2] = 3.14,
				},
				[187] = 
				{
					[1] = 0.7,
					[2] = 3.15,
				},
				[188] = 
				{
					[1] = 0.7,
					[2] = 3.16,
				},
				[189] = 
				{
					[1] = 0.71,
					[2] = 3.17,
				},
				[190] = 
				{
					[1] = 0.71,
					[2] = 3.18,
				},
				[191] = 
				{
					[1] = 0.71,
					[2] = 3.19,
				},
				[192] = 
				{
					[1] = 0.72,
					[2] = 3.2,
				},
				[193] = 
				{
					[1] = 0.72,
					[2] = 3.21,
				},
				[194] = 
				{
					[1] = 0.73,
					[2] = 3.22,
				},
				[195] = 
				{
					[1] = 0.73,
					[2] = 3.23,
				},
				[196] = 
				{
					[1] = 0.73,
					[2] = 3.24,
				},
				[197] = 
				{
					[1] = 0.74,
					[2] = 3.25,
				},
				[198] = 
				{
					[1] = 0.74,
					[2] = 3.26,
				},
				[199] = 
				{
					[1] = 0.74,
					[2] = 3.27,
				},
				[200] = 
				{
					[1] = 0.75,
					[2] = 3.28,
				},
				[201] = 
				{
					[1] = 0.75,
					[2] = 3.29,
				},
				[202] = 
				{
					[1] = 0.76,
					[2] = 3.3,
				},
				[203] = 
				{
					[1] = 0.76,
					[2] = 3.31,
				},
				[204] = 
				{
					[1] = 0.76,
					[2] = 3.32,
				},
				[205] = 
				{
					[1] = 0.77,
					[2] = 3.33,
				},
				[206] = 
				{
					[1] = 0.77,
					[2] = 3.34,
				},
				[207] = 
				{
					[1] = 0.77,
					[2] = 3.35,
				},
				[208] = 
				{
					[1] = 0.78,
					[2] = 3.36,
				},
				[209] = 
				{
					[1] = 0.78,
					[2] = 3.36,
				},
				[210] = 
				{
					[1] = 0.79,
					[2] = 3.37,
				},
				[211] = 
				{
					[1] = 0.79,
					[2] = 3.38,
				},
				[212] = 
				{
					[1] = 0.79,
					[2] = 3.39,
				},
				[213] = 
				{
					[1] = 0.8,
					[2] = 3.4,
				},
				[214] = 
				{
					[1] = 0.8,
					[2] = 3.41,
				},
				[215] = 
				{
					[1] = 0.8,
					[2] = 3.41,
				},
				[216] = 
				{
					[1] = 0.81,
					[2] = 3.42,
				},
				[217] = 
				{
					[1] = 0.81,
					[2] = 3.43,
				},
				[218] = 
				{
					[1] = 0.82,
					[2] = 3.44,
				},
				[219] = 
				{
					[1] = 0.82,
					[2] = 3.44,
				},
				[220] = 
				{
					[1] = 0.82,
					[2] = 3.45,
				},
				[221] = 
				{
					[1] = 0.83,
					[2] = 3.46,
				},
				[222] = 
				{
					[1] = 0.83,
					[2] = 3.47,
				},
				[223] = 
				{
					[1] = 0.83,
					[2] = 3.47,
				},
				[224] = 
				{
					[1] = 0.84,
					[2] = 3.48,
				},
				[225] = 
				{
					[1] = 0.84,
					[2] = 3.49,
				},
				[226] = 
				{
					[1] = 0.85,
					[2] = 3.49,
				},
				[227] = 
				{
					[1] = 0.85,
					[2] = 3.5,
				},
				[228] = 
				{
					[1] = 0.85,
					[2] = 3.51,
				},
				[229] = 
				{
					[1] = 0.86,
					[2] = 3.51,
				},
				[230] = 
				{
					[1] = 0.86,
					[2] = 3.52,
				},
				[231] = 
				{
					[1] = 0.86,
					[2] = 3.52,
				},
				[232] = 
				{
					[1] = 0.87,
					[2] = 3.53,
				},
				[233] = 
				{
					[1] = 0.87,
					[2] = 3.54,
				},
				[234] = 
				{
					[1] = 0.88,
					[2] = 3.54,
				},
				[235] = 
				{
					[1] = 0.88,
					[2] = 3.55,
				},
				[236] = 
				{
					[1] = 0.88,
					[2] = 3.55,
				},
				[237] = 
				{
					[1] = 0.89,
					[2] = 3.56,
				},
				[238] = 
				{
					[1] = 0.89,
					[2] = 3.56,
				},
				[239] = 
				{
					[1] = 0.89,
					[2] = 3.57,
				},
				[240] = 
				{
					[1] = 0.9,
					[2] = 3.57,
				},
				[241] = 
				{
					[1] = 0.9,
					[2] = 3.58,
				},
				[242] = 
				{
					[1] = 0.91,
					[2] = 3.58,
				},
				[243] = 
				{
					[1] = 0.91,
					[2] = 3.59,
				},
				[244] = 
				{
					[1] = 0.91,
					[2] = 3.59,
				},
				[245] = 
				{
					[1] = 0.92,
					[2] = 3.6,
				},
				[246] = 
				{
					[1] = 0.92,
					[2] = 3.6,
				},
				[247] = 
				{
					[1] = 0.92,
					[2] = 3.6,
				},
				[248] = 
				{
					[1] = 0.93,
					[2] = 3.61,
				},
				[249] = 
				{
					[1] = 0.93,
					[2] = 3.61,
				},
				[250] = 
				{
					[1] = 0.94,
					[2] = 3.62,
				},
				[251] = 
				{
					[1] = 0.94,
					[2] = 3.62,
				},
				[252] = 
				{
					[1] = 0.94,
					[2] = 3.62,
				},
				[253] = 
				{
					[1] = 0.95,
					[2] = 3.63,
				},
				[254] = 
				{
					[1] = 0.95,
					[2] = 3.63,
				},
				[255] = 
				{
					[1] = 0.95,
					[2] = 3.63,
				},
				[256] = 
				{
					[1] = 0.96,
					[2] = 3.64,
				},
				[257] = 
				{
					[1] = 0.96,
					[2] = 3.64,
				},
				[258] = 
				{
					[1] = 0.97,
					[2] = 3.64,
				},
				[259] = 
				{
					[1] = 0.97,
					[2] = 3.65,
				},
				[260] = 
				{
					[1] = 0.97,
					[2] = 3.65,
				},
				[261] = 
				{
					[1] = 0.98,
					[2] = 3.65,
				},
				[262] = 
				{
					[1] = 0.98,
					[2] = 3.65,
				},
				[263] = 
				{
					[1] = 0.98,
					[2] = 3.66,
				},
				[264] = 
				{
					[1] = 0.99,
					[2] = 3.66,
				},
				[265] = 
				{
					[1] = 0.99,
					[2] = 3.66,
				},
				[266] = 
				{
					[1] = 1,
					[2] = 3.66,
				},
			},
			["WidthScale"] = 0.75,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Cleveland",
		["Type"] = "WaterTracer",
	},
	[206] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 230.880676,
			["Lifetime"] = 14.96,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0238,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.99,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 301.873383,
			["Lifetime"] = 19.559999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0298,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 3.08,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 53.244541,
			["Lifetime"] = 3.45,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0298,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 7.1,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Cleveland",
		["Type"] = "WaterTracer",
	},
	[207] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 14.5,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.3448,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.07,
					[2] = 1.57,
				},
				[3] = 
				{
					[1] = 0.14,
					[2] = 1.71,
				},
				[4] = 
				{
					[1] = 0.21,
					[2] = 1.82,
				},
				[5] = 
				{
					[1] = 0.29,
					[2] = 1.9,
				},
				[6] = 
				{
					[1] = 0.36,
					[2] = 2,
				},
				[7] = 
				{
					[1] = 0.43,
					[2] = 2.03,
				},
				[8] = 
				{
					[1] = 0.5,
					[2] = 2.03,
				},
				[9] = 
				{
					[1] = 0.57,
					[2] = 2.02,
				},
				[10] = 
				{
					[1] = 0.64,
					[2] = 2,
				},
				[11] = 
				{
					[1] = 0.71,
					[2] = 1.97,
				},
				[12] = 
				{
					[1] = 0.79,
					[2] = 1.92,
				},
				[13] = 
				{
					[1] = 0.86,
					[2] = 1.81,
				},
				[14] = 
				{
					[1] = 0.93,
					[2] = 1.6,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.48,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[3] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 2.18,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 2.88,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 2.83,
				},
				[4] = 
				{
					[1] = 0.14,
					[2] = 2.78,
				},
				[5] = 
				{
					[1] = 0.19,
					[2] = 2.72,
				},
				[6] = 
				{
					[1] = 0.24,
					[2] = 2.67,
				},
				[7] = 
				{
					[1] = 0.29,
					[2] = 2.62,
				},
				[8] = 
				{
					[1] = 0.33,
					[2] = 2.56,
				},
				[9] = 
				{
					[1] = 0.38,
					[2] = 2.51,
				},
				[10] = 
				{
					[1] = 0.43,
					[2] = 2.45,
				},
				[11] = 
				{
					[1] = 0.48,
					[2] = 2.39,
				},
				[12] = 
				{
					[1] = 0.52,
					[2] = 2.33,
				},
				[13] = 
				{
					[1] = 0.57,
					[2] = 2.27,
				},
				[14] = 
				{
					[1] = 0.62,
					[2] = 2.21,
				},
				[15] = 
				{
					[1] = 0.67,
					[2] = 2.15,
				},
				[16] = 
				{
					[1] = 0.71,
					[2] = 2.1,
				},
				[17] = 
				{
					[1] = 0.76,
					[2] = 2.06,
				},
				[18] = 
				{
					[1] = 0.81,
					[2] = 2,
				},
				[19] = 
				{
					[1] = 0.86,
					[2] = 1.93,
				},
				[20] = 
				{
					[1] = 0.9,
					[2] = 1.86,
				},
				[21] = 
				{
					[1] = 0.95,
					[2] = 1.79,
				},
			},
			["WidthScale"] = 1.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_daihatsu",
		["Type"] = "WaterTracer",
	},
	[208] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 18.90567,
			["Lifetime"] = 1.47,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.135,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.23,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 24.693119,
			["Lifetime"] = 1.92,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1688,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.54,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 4.37274,
			["Lifetime"] = 0.34,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.1688,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.25,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_daihatsu",
		["Type"] = "WaterTracer",
	},
	[209] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 167.699997,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0298,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.11,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.23,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.37,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.51,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 0.64,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 0.77,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 0.9,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.03,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 1.15,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 1.28,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 1.41,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 1.53,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 1.66,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 1.78,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 1.91,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 2.03,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 2.15,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 2.28,
				},
				[20] = 
				{
					[1] = 0.11,
					[2] = 2.4,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 2.52,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 2.65,
				},
				[23] = 
				{
					[1] = 0.13,
					[2] = 2.77,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 2.89,
				},
				[25] = 
				{
					[1] = 0.14,
					[2] = 3.01,
				},
				[26] = 
				{
					[1] = 0.15,
					[2] = 3.11,
				},
				[27] = 
				{
					[1] = 0.16,
					[2] = 3.21,
				},
				[28] = 
				{
					[1] = 0.16,
					[2] = 3.31,
				},
				[29] = 
				{
					[1] = 0.17,
					[2] = 3.42,
				},
				[30] = 
				{
					[1] = 0.17,
					[2] = 3.52,
				},
				[31] = 
				{
					[1] = 0.18,
					[2] = 3.62,
				},
				[32] = 
				{
					[1] = 0.19,
					[2] = 3.72,
				},
				[33] = 
				{
					[1] = 0.19,
					[2] = 3.82,
				},
				[34] = 
				{
					[1] = 0.2,
					[2] = 3.92,
				},
				[35] = 
				{
					[1] = 0.2,
					[2] = 4.03,
				},
				[36] = 
				{
					[1] = 0.21,
					[2] = 4.13,
				},
				[37] = 
				{
					[1] = 0.22,
					[2] = 4.23,
				},
				[38] = 
				{
					[1] = 0.22,
					[2] = 4.33,
				},
				[39] = 
				{
					[1] = 0.23,
					[2] = 4.42,
				},
				[40] = 
				{
					[1] = 0.23,
					[2] = 4.51,
				},
				[41] = 
				{
					[1] = 0.24,
					[2] = 4.59,
				},
				[42] = 
				{
					[1] = 0.25,
					[2] = 4.68,
				},
				[43] = 
				{
					[1] = 0.25,
					[2] = 4.76,
				},
				[44] = 
				{
					[1] = 0.26,
					[2] = 4.85,
				},
				[45] = 
				{
					[1] = 0.26,
					[2] = 4.93,
				},
				[46] = 
				{
					[1] = 0.27,
					[2] = 5.01,
				},
				[47] = 
				{
					[1] = 0.28,
					[2] = 5.1,
				},
				[48] = 
				{
					[1] = 0.28,
					[2] = 5.18,
				},
				[49] = 
				{
					[1] = 0.29,
					[2] = 5.27,
				},
				[50] = 
				{
					[1] = 0.29,
					[2] = 5.35,
				},
				[51] = 
				{
					[1] = 0.3,
					[2] = 5.44,
				},
				[52] = 
				{
					[1] = 0.31,
					[2] = 5.52,
				},
				[53] = 
				{
					[1] = 0.31,
					[2] = 5.6,
				},
				[54] = 
				{
					[1] = 0.32,
					[2] = 5.69,
				},
				[55] = 
				{
					[1] = 0.32,
					[2] = 5.77,
				},
				[56] = 
				{
					[1] = 0.33,
					[2] = 5.84,
				},
				[57] = 
				{
					[1] = 0.34,
					[2] = 5.91,
				},
				[58] = 
				{
					[1] = 0.34,
					[2] = 5.98,
				},
				[59] = 
				{
					[1] = 0.35,
					[2] = 6.05,
				},
				[60] = 
				{
					[1] = 0.35,
					[2] = 6.12,
				},
				[61] = 
				{
					[1] = 0.36,
					[2] = 6.19,
				},
				[62] = 
				{
					[1] = 0.37,
					[2] = 6.26,
				},
				[63] = 
				{
					[1] = 0.37,
					[2] = 6.33,
				},
				[64] = 
				{
					[1] = 0.38,
					[2] = 6.4,
				},
				[65] = 
				{
					[1] = 0.38,
					[2] = 6.47,
				},
				[66] = 
				{
					[1] = 0.39,
					[2] = 6.54,
				},
				[67] = 
				{
					[1] = 0.4,
					[2] = 6.61,
				},
				[68] = 
				{
					[1] = 0.4,
					[2] = 6.68,
				},
				[69] = 
				{
					[1] = 0.41,
					[2] = 6.75,
				},
				[70] = 
				{
					[1] = 0.41,
					[2] = 6.82,
				},
				[71] = 
				{
					[1] = 0.42,
					[2] = 6.86,
				},
				[72] = 
				{
					[1] = 0.43,
					[2] = 6.9,
				},
				[73] = 
				{
					[1] = 0.43,
					[2] = 6.94,
				},
				[74] = 
				{
					[1] = 0.44,
					[2] = 6.98,
				},
				[75] = 
				{
					[1] = 0.44,
					[2] = 7.03,
				},
				[76] = 
				{
					[1] = 0.45,
					[2] = 7.07,
				},
				[77] = 
				{
					[1] = 0.46,
					[2] = 7.11,
				},
				[78] = 
				{
					[1] = 0.46,
					[2] = 7.15,
				},
				[79] = 
				{
					[1] = 0.47,
					[2] = 7.2,
				},
				[80] = 
				{
					[1] = 0.47,
					[2] = 7.24,
				},
				[81] = 
				{
					[1] = 0.48,
					[2] = 7.28,
				},
				[82] = 
				{
					[1] = 0.49,
					[2] = 7.32,
				},
				[83] = 
				{
					[1] = 0.49,
					[2] = 7.36,
				},
				[84] = 
				{
					[1] = 0.5,
					[2] = 7.39,
				},
				[85] = 
				{
					[1] = 0.5,
					[2] = 7.39,
				},
				[86] = 
				{
					[1] = 0.51,
					[2] = 7.39,
				},
				[87] = 
				{
					[1] = 0.51,
					[2] = 7.39,
				},
				[88] = 
				{
					[1] = 0.52,
					[2] = 7.39,
				},
				[89] = 
				{
					[1] = 0.53,
					[2] = 7.39,
				},
				[90] = 
				{
					[1] = 0.53,
					[2] = 7.39,
				},
				[91] = 
				{
					[1] = 0.54,
					[2] = 7.38,
				},
				[92] = 
				{
					[1] = 0.54,
					[2] = 7.38,
				},
				[93] = 
				{
					[1] = 0.55,
					[2] = 7.38,
				},
				[94] = 
				{
					[1] = 0.56,
					[2] = 7.38,
				},
				[95] = 
				{
					[1] = 0.56,
					[2] = 7.38,
				},
				[96] = 
				{
					[1] = 0.57,
					[2] = 7.37,
				},
				[97] = 
				{
					[1] = 0.57,
					[2] = 7.35,
				},
				[98] = 
				{
					[1] = 0.58,
					[2] = 7.34,
				},
				[99] = 
				{
					[1] = 0.59,
					[2] = 7.33,
				},
				[100] = 
				{
					[1] = 0.59,
					[2] = 7.31,
				},
				[101] = 
				{
					[1] = 0.6,
					[2] = 7.3,
				},
				[102] = 
				{
					[1] = 0.6,
					[2] = 7.29,
				},
				[103] = 
				{
					[1] = 0.61,
					[2] = 7.27,
				},
				[104] = 
				{
					[1] = 0.62,
					[2] = 7.26,
				},
				[105] = 
				{
					[1] = 0.62,
					[2] = 7.25,
				},
				[106] = 
				{
					[1] = 0.63,
					[2] = 7.23,
				},
				[107] = 
				{
					[1] = 0.63,
					[2] = 7.22,
				},
				[108] = 
				{
					[1] = 0.64,
					[2] = 7.21,
				},
				[109] = 
				{
					[1] = 0.65,
					[2] = 7.19,
				},
				[110] = 
				{
					[1] = 0.65,
					[2] = 7.18,
				},
				[111] = 
				{
					[1] = 0.66,
					[2] = 7.15,
				},
				[112] = 
				{
					[1] = 0.66,
					[2] = 7.13,
				},
				[113] = 
				{
					[1] = 0.67,
					[2] = 7.1,
				},
				[114] = 
				{
					[1] = 0.68,
					[2] = 7.08,
				},
				[115] = 
				{
					[1] = 0.68,
					[2] = 7.05,
				},
				[116] = 
				{
					[1] = 0.69,
					[2] = 7.03,
				},
				[117] = 
				{
					[1] = 0.69,
					[2] = 7,
				},
				[118] = 
				{
					[1] = 0.7,
					[2] = 6.98,
				},
				[119] = 
				{
					[1] = 0.71,
					[2] = 6.95,
				},
				[120] = 
				{
					[1] = 0.71,
					[2] = 6.93,
				},
				[121] = 
				{
					[1] = 0.72,
					[2] = 6.9,
				},
				[122] = 
				{
					[1] = 0.72,
					[2] = 6.87,
				},
				[123] = 
				{
					[1] = 0.73,
					[2] = 6.84,
				},
				[124] = 
				{
					[1] = 0.74,
					[2] = 6.8,
				},
				[125] = 
				{
					[1] = 0.74,
					[2] = 6.76,
				},
				[126] = 
				{
					[1] = 0.75,
					[2] = 6.72,
				},
				[127] = 
				{
					[1] = 0.75,
					[2] = 6.68,
				},
				[128] = 
				{
					[1] = 0.76,
					[2] = 6.59,
				},
				[129] = 
				{
					[1] = 0.77,
					[2] = 6.5,
				},
				[130] = 
				{
					[1] = 0.77,
					[2] = 6.41,
				},
				[131] = 
				{
					[1] = 0.78,
					[2] = 6.33,
				},
				[132] = 
				{
					[1] = 0.78,
					[2] = 6.24,
				},
				[133] = 
				{
					[1] = 0.79,
					[2] = 6.15,
				},
				[134] = 
				{
					[1] = 0.8,
					[2] = 6.07,
				},
				[135] = 
				{
					[1] = 0.8,
					[2] = 5.98,
				},
				[136] = 
				{
					[1] = 0.81,
					[2] = 5.9,
				},
				[137] = 
				{
					[1] = 0.81,
					[2] = 5.81,
				},
				[138] = 
				{
					[1] = 0.82,
					[2] = 5.72,
				},
				[139] = 
				{
					[1] = 0.83,
					[2] = 5.62,
				},
				[140] = 
				{
					[1] = 0.83,
					[2] = 5.52,
				},
				[141] = 
				{
					[1] = 0.84,
					[2] = 5.43,
				},
				[142] = 
				{
					[1] = 0.84,
					[2] = 5.33,
				},
				[143] = 
				{
					[1] = 0.85,
					[2] = 5.24,
				},
				[144] = 
				{
					[1] = 0.86,
					[2] = 5.14,
				},
				[145] = 
				{
					[1] = 0.86,
					[2] = 5.04,
				},
				[146] = 
				{
					[1] = 0.87,
					[2] = 4.95,
				},
				[147] = 
				{
					[1] = 0.87,
					[2] = 4.85,
				},
				[148] = 
				{
					[1] = 0.88,
					[2] = 4.75,
				},
				[149] = 
				{
					[1] = 0.89,
					[2] = 4.61,
				},
				[150] = 
				{
					[1] = 0.89,
					[2] = 4.48,
				},
				[151] = 
				{
					[1] = 0.9,
					[2] = 4.35,
				},
				[152] = 
				{
					[1] = 0.9,
					[2] = 4.21,
				},
				[153] = 
				{
					[1] = 0.91,
					[2] = 4.03,
				},
				[154] = 
				{
					[1] = 0.92,
					[2] = 3.83,
				},
				[155] = 
				{
					[1] = 0.92,
					[2] = 3.62,
				},
				[156] = 
				{
					[1] = 0.93,
					[2] = 3.42,
				},
				[157] = 
				{
					[1] = 0.93,
					[2] = 3.21,
				},
				[158] = 
				{
					[1] = 0.94,
					[2] = 3,
				},
				[159] = 
				{
					[1] = 0.95,
					[2] = 2.79,
				},
				[160] = 
				{
					[1] = 0.95,
					[2] = 2.58,
				},
				[161] = 
				{
					[1] = 0.96,
					[2] = 2.37,
				},
				[162] = 
				{
					[1] = 0.96,
					[2] = 2.15,
				},
				[163] = 
				{
					[1] = 0.97,
					[2] = 1.94,
				},
				[164] = 
				{
					[1] = 0.98,
					[2] = 1.73,
				},
				[165] = 
				{
					[1] = 0.98,
					[2] = 1.51,
				},
				[166] = 
				{
					[1] = 0.99,
					[2] = 1.27,
				},
				[167] = 
				{
					[1] = 0.99,
					[2] = 0.93,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.59,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.24,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.32,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.38,
				},
				[5] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[6] = 
				{
					[1] = 0.12,
					[2] = 0.44,
				},
				[7] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[8] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[9] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.32,
					[2] = 0.49,
				},
				[15] = 
				{
					[1] = 0.34,
					[2] = 0.48,
				},
				[16] = 
				{
					[1] = 0.37,
					[2] = 0.47,
				},
				[17] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[18] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[19] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[20] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[21] = 
				{
					[1] = 0.49,
					[2] = 0.41,
				},
				[22] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[23] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[24] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[25] = 
				{
					[1] = 0.59,
					[2] = 0.34,
				},
				[26] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[27] = 
				{
					[1] = 0.63,
					[2] = 0.3,
				},
				[28] = 
				{
					[1] = 0.66,
					[2] = 0.28,
				},
				[29] = 
				{
					[1] = 0.68,
					[2] = 0.26,
				},
				[30] = 
				{
					[1] = 0.71,
					[2] = 0.24,
				},
				[31] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[32] = 
				{
					[1] = 0.76,
					[2] = 0.2,
				},
				[33] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[34] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[35] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[36] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[37] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[38] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[39] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[40] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[41] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 18.16,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.03,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.05,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.07,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.09,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.11,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.13,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.15,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.17,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 0.19,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 0.21,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 0.23,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 0.25,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 0.27,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 0.29,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 0.32,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 0.34,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 0.39,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 0.42,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 0.45,
				},
				[22] = 
				{
					[1] = 0.08,
					[2] = 0.47,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 0.5,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 0.52,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 0.55,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 0.57,
				},
				[27] = 
				{
					[1] = 0.1,
					[2] = 0.6,
				},
				[28] = 
				{
					[1] = 0.11,
					[2] = 0.62,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 0.65,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 0.67,
				},
				[31] = 
				{
					[1] = 0.12,
					[2] = 0.69,
				},
				[32] = 
				{
					[1] = 0.12,
					[2] = 0.72,
				},
				[33] = 
				{
					[1] = 0.13,
					[2] = 0.74,
				},
				[34] = 
				{
					[1] = 0.13,
					[2] = 0.77,
				},
				[35] = 
				{
					[1] = 0.14,
					[2] = 0.79,
				},
				[36] = 
				{
					[1] = 0.14,
					[2] = 0.81,
				},
				[37] = 
				{
					[1] = 0.14,
					[2] = 0.84,
				},
				[38] = 
				{
					[1] = 0.15,
					[2] = 0.86,
				},
				[39] = 
				{
					[1] = 0.15,
					[2] = 0.88,
				},
				[40] = 
				{
					[1] = 0.16,
					[2] = 0.91,
				},
				[41] = 
				{
					[1] = 0.16,
					[2] = 0.93,
				},
				[42] = 
				{
					[1] = 0.16,
					[2] = 0.95,
				},
				[43] = 
				{
					[1] = 0.17,
					[2] = 0.98,
				},
				[44] = 
				{
					[1] = 0.17,
					[2] = 1,
				},
				[45] = 
				{
					[1] = 0.18,
					[2] = 1.02,
				},
				[46] = 
				{
					[1] = 0.18,
					[2] = 1.05,
				},
				[47] = 
				{
					[1] = 0.18,
					[2] = 1.07,
				},
				[48] = 
				{
					[1] = 0.19,
					[2] = 1.09,
				},
				[49] = 
				{
					[1] = 0.19,
					[2] = 1.11,
				},
				[50] = 
				{
					[1] = 0.2,
					[2] = 1.14,
				},
				[51] = 
				{
					[1] = 0.2,
					[2] = 1.16,
				},
				[52] = 
				{
					[1] = 0.2,
					[2] = 1.18,
				},
				[53] = 
				{
					[1] = 0.21,
					[2] = 1.2,
				},
				[54] = 
				{
					[1] = 0.21,
					[2] = 1.22,
				},
				[55] = 
				{
					[1] = 0.22,
					[2] = 1.25,
				},
				[56] = 
				{
					[1] = 0.22,
					[2] = 1.27,
				},
				[57] = 
				{
					[1] = 0.22,
					[2] = 1.28,
				},
				[58] = 
				{
					[1] = 0.23,
					[2] = 1.3,
				},
				[59] = 
				{
					[1] = 0.23,
					[2] = 1.32,
				},
				[60] = 
				{
					[1] = 0.24,
					[2] = 1.34,
				},
				[61] = 
				{
					[1] = 0.24,
					[2] = 1.36,
				},
				[62] = 
				{
					[1] = 0.24,
					[2] = 1.38,
				},
				[63] = 
				{
					[1] = 0.25,
					[2] = 1.4,
				},
				[64] = 
				{
					[1] = 0.25,
					[2] = 1.42,
				},
				[65] = 
				{
					[1] = 0.25,
					[2] = 1.44,
				},
				[66] = 
				{
					[1] = 0.26,
					[2] = 1.46,
				},
				[67] = 
				{
					[1] = 0.26,
					[2] = 1.48,
				},
				[68] = 
				{
					[1] = 0.27,
					[2] = 1.49,
				},
				[69] = 
				{
					[1] = 0.27,
					[2] = 1.51,
				},
				[70] = 
				{
					[1] = 0.27,
					[2] = 1.53,
				},
				[71] = 
				{
					[1] = 0.28,
					[2] = 1.55,
				},
				[72] = 
				{
					[1] = 0.28,
					[2] = 1.57,
				},
				[73] = 
				{
					[1] = 0.29,
					[2] = 1.59,
				},
				[74] = 
				{
					[1] = 0.29,
					[2] = 1.6,
				},
				[75] = 
				{
					[1] = 0.29,
					[2] = 1.62,
				},
				[76] = 
				{
					[1] = 0.3,
					[2] = 1.64,
				},
				[77] = 
				{
					[1] = 0.3,
					[2] = 1.66,
				},
				[78] = 
				{
					[1] = 0.31,
					[2] = 1.68,
				},
				[79] = 
				{
					[1] = 0.31,
					[2] = 1.69,
				},
				[80] = 
				{
					[1] = 0.31,
					[2] = 1.71,
				},
				[81] = 
				{
					[1] = 0.32,
					[2] = 1.73,
				},
				[82] = 
				{
					[1] = 0.32,
					[2] = 1.74,
				},
				[83] = 
				{
					[1] = 0.33,
					[2] = 1.76,
				},
				[84] = 
				{
					[1] = 0.33,
					[2] = 1.78,
				},
				[85] = 
				{
					[1] = 0.33,
					[2] = 1.8,
				},
				[86] = 
				{
					[1] = 0.34,
					[2] = 1.81,
				},
				[87] = 
				{
					[1] = 0.34,
					[2] = 1.83,
				},
				[88] = 
				{
					[1] = 0.35,
					[2] = 1.85,
				},
				[89] = 
				{
					[1] = 0.35,
					[2] = 1.86,
				},
				[90] = 
				{
					[1] = 0.35,
					[2] = 1.88,
				},
				[91] = 
				{
					[1] = 0.36,
					[2] = 1.89,
				},
				[92] = 
				{
					[1] = 0.36,
					[2] = 1.91,
				},
				[93] = 
				{
					[1] = 0.37,
					[2] = 1.93,
				},
				[94] = 
				{
					[1] = 0.37,
					[2] = 1.94,
				},
				[95] = 
				{
					[1] = 0.37,
					[2] = 1.96,
				},
				[96] = 
				{
					[1] = 0.38,
					[2] = 1.97,
				},
				[97] = 
				{
					[1] = 0.38,
					[2] = 1.99,
				},
				[98] = 
				{
					[1] = 0.39,
					[2] = 2.01,
				},
				[99] = 
				{
					[1] = 0.39,
					[2] = 2.02,
				},
				[100] = 
				{
					[1] = 0.39,
					[2] = 2.04,
				},
				[101] = 
				{
					[1] = 0.4,
					[2] = 2.05,
				},
				[102] = 
				{
					[1] = 0.4,
					[2] = 2.07,
				},
				[103] = 
				{
					[1] = 0.41,
					[2] = 2.08,
				},
				[104] = 
				{
					[1] = 0.41,
					[2] = 2.1,
				},
				[105] = 
				{
					[1] = 0.41,
					[2] = 2.11,
				},
				[106] = 
				{
					[1] = 0.42,
					[2] = 2.13,
				},
				[107] = 
				{
					[1] = 0.42,
					[2] = 2.14,
				},
				[108] = 
				{
					[1] = 0.43,
					[2] = 2.16,
				},
				[109] = 
				{
					[1] = 0.43,
					[2] = 2.17,
				},
				[110] = 
				{
					[1] = 0.43,
					[2] = 2.18,
				},
				[111] = 
				{
					[1] = 0.44,
					[2] = 2.2,
				},
				[112] = 
				{
					[1] = 0.44,
					[2] = 2.21,
				},
				[113] = 
				{
					[1] = 0.45,
					[2] = 2.23,
				},
				[114] = 
				{
					[1] = 0.45,
					[2] = 2.24,
				},
				[115] = 
				{
					[1] = 0.45,
					[2] = 2.25,
				},
				[116] = 
				{
					[1] = 0.46,
					[2] = 2.27,
				},
				[117] = 
				{
					[1] = 0.46,
					[2] = 2.28,
				},
				[118] = 
				{
					[1] = 0.47,
					[2] = 2.3,
				},
				[119] = 
				{
					[1] = 0.47,
					[2] = 2.31,
				},
				[120] = 
				{
					[1] = 0.47,
					[2] = 2.32,
				},
				[121] = 
				{
					[1] = 0.48,
					[2] = 2.34,
				},
				[122] = 
				{
					[1] = 0.48,
					[2] = 2.35,
				},
				[123] = 
				{
					[1] = 0.49,
					[2] = 2.36,
				},
				[124] = 
				{
					[1] = 0.49,
					[2] = 2.37,
				},
				[125] = 
				{
					[1] = 0.49,
					[2] = 2.39,
				},
				[126] = 
				{
					[1] = 0.5,
					[2] = 2.4,
				},
				[127] = 
				{
					[1] = 0.5,
					[2] = 2.41,
				},
				[128] = 
				{
					[1] = 0.51,
					[2] = 2.42,
				},
				[129] = 
				{
					[1] = 0.51,
					[2] = 2.43,
				},
				[130] = 
				{
					[1] = 0.51,
					[2] = 2.45,
				},
				[131] = 
				{
					[1] = 0.52,
					[2] = 2.46,
				},
				[132] = 
				{
					[1] = 0.52,
					[2] = 2.47,
				},
				[133] = 
				{
					[1] = 0.53,
					[2] = 2.48,
				},
				[134] = 
				{
					[1] = 0.53,
					[2] = 2.49,
				},
				[135] = 
				{
					[1] = 0.53,
					[2] = 2.5,
				},
				[136] = 
				{
					[1] = 0.54,
					[2] = 2.51,
				},
				[137] = 
				{
					[1] = 0.54,
					[2] = 2.53,
				},
				[138] = 
				{
					[1] = 0.55,
					[2] = 2.54,
				},
				[139] = 
				{
					[1] = 0.55,
					[2] = 2.55,
				},
				[140] = 
				{
					[1] = 0.55,
					[2] = 2.56,
				},
				[141] = 
				{
					[1] = 0.56,
					[2] = 2.57,
				},
				[142] = 
				{
					[1] = 0.56,
					[2] = 2.58,
				},
				[143] = 
				{
					[1] = 0.57,
					[2] = 2.59,
				},
				[144] = 
				{
					[1] = 0.57,
					[2] = 2.6,
				},
				[145] = 
				{
					[1] = 0.57,
					[2] = 2.61,
				},
				[146] = 
				{
					[1] = 0.58,
					[2] = 2.62,
				},
				[147] = 
				{
					[1] = 0.58,
					[2] = 2.63,
				},
				[148] = 
				{
					[1] = 0.59,
					[2] = 2.64,
				},
				[149] = 
				{
					[1] = 0.59,
					[2] = 2.65,
				},
				[150] = 
				{
					[1] = 0.59,
					[2] = 2.66,
				},
				[151] = 
				{
					[1] = 0.6,
					[2] = 2.67,
				},
				[152] = 
				{
					[1] = 0.6,
					[2] = 2.68,
				},
				[153] = 
				{
					[1] = 0.61,
					[2] = 2.69,
				},
				[154] = 
				{
					[1] = 0.61,
					[2] = 2.7,
				},
				[155] = 
				{
					[1] = 0.61,
					[2] = 2.71,
				},
				[156] = 
				{
					[1] = 0.62,
					[2] = 2.72,
				},
				[157] = 
				{
					[1] = 0.62,
					[2] = 2.73,
				},
				[158] = 
				{
					[1] = 0.63,
					[2] = 2.74,
				},
				[159] = 
				{
					[1] = 0.63,
					[2] = 2.75,
				},
				[160] = 
				{
					[1] = 0.63,
					[2] = 2.76,
				},
				[161] = 
				{
					[1] = 0.64,
					[2] = 2.76,
				},
				[162] = 
				{
					[1] = 0.64,
					[2] = 2.77,
				},
				[163] = 
				{
					[1] = 0.65,
					[2] = 2.78,
				},
				[164] = 
				{
					[1] = 0.65,
					[2] = 2.79,
				},
				[165] = 
				{
					[1] = 0.65,
					[2] = 2.8,
				},
				[166] = 
				{
					[1] = 0.66,
					[2] = 2.81,
				},
				[167] = 
				{
					[1] = 0.66,
					[2] = 2.82,
				},
				[168] = 
				{
					[1] = 0.67,
					[2] = 2.82,
				},
				[169] = 
				{
					[1] = 0.67,
					[2] = 2.83,
				},
				[170] = 
				{
					[1] = 0.67,
					[2] = 2.84,
				},
				[171] = 
				{
					[1] = 0.68,
					[2] = 2.85,
				},
				[172] = 
				{
					[1] = 0.68,
					[2] = 2.86,
				},
				[173] = 
				{
					[1] = 0.69,
					[2] = 2.86,
				},
				[174] = 
				{
					[1] = 0.69,
					[2] = 2.87,
				},
				[175] = 
				{
					[1] = 0.69,
					[2] = 2.88,
				},
				[176] = 
				{
					[1] = 0.7,
					[2] = 2.89,
				},
				[177] = 
				{
					[1] = 0.7,
					[2] = 2.89,
				},
				[178] = 
				{
					[1] = 0.71,
					[2] = 2.9,
				},
				[179] = 
				{
					[1] = 0.71,
					[2] = 2.91,
				},
				[180] = 
				{
					[1] = 0.71,
					[2] = 2.91,
				},
				[181] = 
				{
					[1] = 0.72,
					[2] = 2.92,
				},
				[182] = 
				{
					[1] = 0.72,
					[2] = 2.93,
				},
				[183] = 
				{
					[1] = 0.73,
					[2] = 2.93,
				},
				[184] = 
				{
					[1] = 0.73,
					[2] = 2.94,
				},
				[185] = 
				{
					[1] = 0.73,
					[2] = 2.95,
				},
				[186] = 
				{
					[1] = 0.74,
					[2] = 2.95,
				},
				[187] = 
				{
					[1] = 0.74,
					[2] = 2.96,
				},
				[188] = 
				{
					[1] = 0.75,
					[2] = 2.97,
				},
				[189] = 
				{
					[1] = 0.75,
					[2] = 2.97,
				},
				[190] = 
				{
					[1] = 0.75,
					[2] = 2.98,
				},
				[191] = 
				{
					[1] = 0.76,
					[2] = 2.98,
				},
				[192] = 
				{
					[1] = 0.76,
					[2] = 2.99,
				},
				[193] = 
				{
					[1] = 0.76,
					[2] = 2.99,
				},
				[194] = 
				{
					[1] = 0.77,
					[2] = 3,
				},
				[195] = 
				{
					[1] = 0.77,
					[2] = 3.01,
				},
				[196] = 
				{
					[1] = 0.78,
					[2] = 3.01,
				},
				[197] = 
				{
					[1] = 0.78,
					[2] = 3.02,
				},
				[198] = 
				{
					[1] = 0.78,
					[2] = 3.02,
				},
				[199] = 
				{
					[1] = 0.79,
					[2] = 3.03,
				},
				[200] = 
				{
					[1] = 0.79,
					[2] = 3.03,
				},
				[201] = 
				{
					[1] = 0.8,
					[2] = 3.04,
				},
				[202] = 
				{
					[1] = 0.8,
					[2] = 3.04,
				},
				[203] = 
				{
					[1] = 0.8,
					[2] = 3.05,
				},
				[204] = 
				{
					[1] = 0.81,
					[2] = 3.05,
				},
				[205] = 
				{
					[1] = 0.81,
					[2] = 3.05,
				},
				[206] = 
				{
					[1] = 0.82,
					[2] = 3.06,
				},
				[207] = 
				{
					[1] = 0.82,
					[2] = 3.06,
				},
				[208] = 
				{
					[1] = 0.82,
					[2] = 3.07,
				},
				[209] = 
				{
					[1] = 0.83,
					[2] = 3.07,
				},
				[210] = 
				{
					[1] = 0.83,
					[2] = 3.08,
				},
				[211] = 
				{
					[1] = 0.84,
					[2] = 3.08,
				},
				[212] = 
				{
					[1] = 0.84,
					[2] = 3.08,
				},
				[213] = 
				{
					[1] = 0.84,
					[2] = 3.09,
				},
				[214] = 
				{
					[1] = 0.85,
					[2] = 3.09,
				},
				[215] = 
				{
					[1] = 0.85,
					[2] = 3.09,
				},
				[216] = 
				{
					[1] = 0.86,
					[2] = 3.1,
				},
				[217] = 
				{
					[1] = 0.86,
					[2] = 3.1,
				},
				[218] = 
				{
					[1] = 0.86,
					[2] = 3.1,
				},
				[219] = 
				{
					[1] = 0.87,
					[2] = 3.11,
				},
				[220] = 
				{
					[1] = 0.87,
					[2] = 3.11,
				},
				[221] = 
				{
					[1] = 0.88,
					[2] = 3.11,
				},
				[222] = 
				{
					[1] = 0.88,
					[2] = 3.12,
				},
				[223] = 
				{
					[1] = 0.88,
					[2] = 3.12,
				},
				[224] = 
				{
					[1] = 0.89,
					[2] = 3.12,
				},
				[225] = 
				{
					[1] = 0.89,
					[2] = 3.12,
				},
				[226] = 
				{
					[1] = 0.9,
					[2] = 3.13,
				},
				[227] = 
				{
					[1] = 0.9,
					[2] = 3.13,
				},
				[228] = 
				{
					[1] = 0.9,
					[2] = 3.13,
				},
				[229] = 
				{
					[1] = 0.91,
					[2] = 3.13,
				},
				[230] = 
				{
					[1] = 0.91,
					[2] = 3.13,
				},
				[231] = 
				{
					[1] = 0.92,
					[2] = 3.14,
				},
				[232] = 
				{
					[1] = 0.92,
					[2] = 3.14,
				},
				[233] = 
				{
					[1] = 0.92,
					[2] = 3.14,
				},
				[234] = 
				{
					[1] = 0.93,
					[2] = 3.14,
				},
				[235] = 
				{
					[1] = 0.93,
					[2] = 3.14,
				},
				[236] = 
				{
					[1] = 0.94,
					[2] = 3.14,
				},
				[237] = 
				{
					[1] = 0.94,
					[2] = 3.15,
				},
				[238] = 
				{
					[1] = 0.94,
					[2] = 3.14,
				},
				[239] = 
				{
					[1] = 0.95,
					[2] = 3.14,
				},
				[240] = 
				{
					[1] = 0.95,
					[2] = 3.14,
				},
				[241] = 
				{
					[1] = 0.96,
					[2] = 3.14,
				},
				[242] = 
				{
					[1] = 0.96,
					[2] = 3.14,
				},
				[243] = 
				{
					[1] = 0.96,
					[2] = 3.14,
				},
				[244] = 
				{
					[1] = 0.97,
					[2] = 3.14,
				},
				[245] = 
				{
					[1] = 0.97,
					[2] = 3.13,
				},
				[246] = 
				{
					[1] = 0.98,
					[2] = 3.13,
				},
				[247] = 
				{
					[1] = 0.98,
					[2] = 3.13,
				},
				[248] = 
				{
					[1] = 0.98,
					[2] = 3.13,
				},
				[249] = 
				{
					[1] = 0.99,
					[2] = 3.13,
				},
				[250] = 
				{
					[1] = 0.99,
					[2] = 3.12,
				},
				[251] = 
				{
					[1] = 1,
					[2] = 3.12,
				},
			},
			["WidthScale"] = 1.3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Deruyter",
		["Type"] = "WaterTracer",
	},
	[210] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 218.071121,
			["Lifetime"] = 14.13,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0606,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.75,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 285.051178,
			["Lifetime"] = 18.469999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0758,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.21,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 50.312233,
			["Lifetime"] = 3.26,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0758,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.79,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Deruyter",
		["Type"] = "WaterTracer",
	},
	[211] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 17.6,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2841,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.06,
					[2] = 1.23,
				},
				[3] = 
				{
					[1] = 0.12,
					[2] = 1.58,
				},
				[4] = 
				{
					[1] = 0.18,
					[2] = 1.85,
				},
				[5] = 
				{
					[1] = 0.24,
					[2] = 1.98,
				},
				[6] = 
				{
					[1] = 0.29,
					[2] = 2.01,
				},
				[7] = 
				{
					[1] = 0.35,
					[2] = 2.02,
				},
				[8] = 
				{
					[1] = 0.41,
					[2] = 2.03,
				},
				[9] = 
				{
					[1] = 0.47,
					[2] = 2.02,
				},
				[10] = 
				{
					[1] = 0.53,
					[2] = 2,
				},
				[11] = 
				{
					[1] = 0.59,
					[2] = 1.98,
				},
				[12] = 
				{
					[1] = 0.65,
					[2] = 1.94,
				},
				[13] = 
				{
					[1] = 0.71,
					[2] = 1.89,
				},
				[14] = 
				{
					[1] = 0.76,
					[2] = 1.84,
				},
				[15] = 
				{
					[1] = 0.82,
					[2] = 1.79,
				},
				[16] = 
				{
					[1] = 0.88,
					[2] = 1.74,
				},
				[17] = 
				{
					[1] = 0.94,
					[2] = 1.69,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.59,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 2.64,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 1.34,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 1.5,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 1.6,
				},
				[5] = 
				{
					[1] = 0.15,
					[2] = 1.7,
				},
				[6] = 
				{
					[1] = 0.19,
					[2] = 1.79,
				},
				[7] = 
				{
					[1] = 0.23,
					[2] = 1.83,
				},
				[8] = 
				{
					[1] = 0.27,
					[2] = 1.88,
				},
				[9] = 
				{
					[1] = 0.31,
					[2] = 1.92,
				},
				[10] = 
				{
					[1] = 0.35,
					[2] = 1.95,
				},
				[11] = 
				{
					[1] = 0.38,
					[2] = 1.99,
				},
				[12] = 
				{
					[1] = 0.42,
					[2] = 2.01,
				},
				[13] = 
				{
					[1] = 0.46,
					[2] = 2.03,
				},
				[14] = 
				{
					[1] = 0.5,
					[2] = 2.03,
				},
				[15] = 
				{
					[1] = 0.54,
					[2] = 2.1,
				},
				[16] = 
				{
					[1] = 0.58,
					[2] = 2.06,
				},
				[17] = 
				{
					[1] = 0.62,
					[2] = 2.03,
				},
				[18] = 
				{
					[1] = 0.65,
					[2] = 1.99,
				},
				[19] = 
				{
					[1] = 0.69,
					[2] = 1.98,
				},
				[20] = 
				{
					[1] = 0.73,
					[2] = 1.96,
				},
				[21] = 
				{
					[1] = 0.77,
					[2] = 1.94,
				},
				[22] = 
				{
					[1] = 0.81,
					[2] = 1.92,
				},
				[23] = 
				{
					[1] = 0.85,
					[2] = 1.89,
				},
				[24] = 
				{
					[1] = 0.88,
					[2] = 1.87,
				},
				[25] = 
				{
					[1] = 0.92,
					[2] = 1.84,
				},
				[26] = 
				{
					[1] = 0.96,
					[2] = 1.8,
				},
			},
			["WidthScale"] = 1.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_dutch_patrol",
		["Type"] = "WaterTracer",
	},
	[212] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 22.841137,
			["Lifetime"] = 2.22,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0979,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.7,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 29.940409,
			["Lifetime"] = 2.91,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1224,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.75,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 5.247288,
			["Lifetime"] = 0.51,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.1224,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.73,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_dutch_patrol",
		["Type"] = "WaterTracer",
	},
	[213] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 31.200001,
			["LocalSpace"] = true,
			["MaxSpeed"] = 5.1444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1603,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.38,
				},
				[3] = 
				{
					[1] = 0.06,
					[2] = 1.53,
				},
				[4] = 
				{
					[1] = 0.1,
					[2] = 1.96,
				},
				[5] = 
				{
					[1] = 0.13,
					[2] = 2.16,
				},
				[6] = 
				{
					[1] = 0.16,
					[2] = 2.35,
				},
				[7] = 
				{
					[1] = 0.19,
					[2] = 2.55,
				},
				[8] = 
				{
					[1] = 0.23,
					[2] = 2.66,
				},
				[9] = 
				{
					[1] = 0.26,
					[2] = 2.71,
				},
				[10] = 
				{
					[1] = 0.29,
					[2] = 2.77,
				},
				[11] = 
				{
					[1] = 0.32,
					[2] = 2.84,
				},
				[12] = 
				{
					[1] = 0.35,
					[2] = 2.9,
				},
				[13] = 
				{
					[1] = 0.39,
					[2] = 2.95,
				},
				[14] = 
				{
					[1] = 0.42,
					[2] = 2.95,
				},
				[15] = 
				{
					[1] = 0.45,
					[2] = 2.95,
				},
				[16] = 
				{
					[1] = 0.48,
					[2] = 2.95,
				},
				[17] = 
				{
					[1] = 0.52,
					[2] = 2.95,
				},
				[18] = 
				{
					[1] = 0.55,
					[2] = 2.95,
				},
				[19] = 
				{
					[1] = 0.58,
					[2] = 2.95,
				},
				[20] = 
				{
					[1] = 0.61,
					[2] = 2.95,
				},
				[21] = 
				{
					[1] = 0.65,
					[2] = 2.92,
				},
				[22] = 
				{
					[1] = 0.68,
					[2] = 2.86,
				},
				[23] = 
				{
					[1] = 0.71,
					[2] = 2.73,
				},
				[24] = 
				{
					[1] = 0.74,
					[2] = 2.6,
				},
				[25] = 
				{
					[1] = 0.77,
					[2] = 2.46,
				},
				[26] = 
				{
					[1] = 0.81,
					[2] = 2.27,
				},
				[27] = 
				{
					[1] = 0.84,
					[2] = 2.08,
				},
				[28] = 
				{
					[1] = 0.87,
					[2] = 1.88,
				},
				[29] = 
				{
					[1] = 0.9,
					[2] = 1.69,
				},
				[30] = 
				{
					[1] = 0.94,
					[2] = 1.06,
				},
				[31] = 
				{
					[1] = 0.97,
					[2] = 0.29,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 1.04,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[3] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[5] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[6] = 
				{
					[1] = 0.71,
					[2] = 0.23,
				},
				[7] = 
				{
					[1] = 0.86,
					[2] = 0.12,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 4.68,
			["LocalSpace"] = true,
			["MaxSpeed"] = 5.1444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.48,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.47,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.47,
				},
				[5] = 
				{
					[1] = 0.09,
					[2] = 0.46,
				},
				[6] = 
				{
					[1] = 0.11,
					[2] = 0.46,
				},
				[7] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[8] = 
				{
					[1] = 0.15,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.17,
					[2] = 0.44,
				},
				[10] = 
				{
					[1] = 0.2,
					[2] = 0.47,
				},
				[11] = 
				{
					[1] = 0.22,
					[2] = 0.67,
				},
				[12] = 
				{
					[1] = 0.24,
					[2] = 0.86,
				},
				[13] = 
				{
					[1] = 0.26,
					[2] = 1.05,
				},
				[14] = 
				{
					[1] = 0.28,
					[2] = 1.24,
				},
				[15] = 
				{
					[1] = 0.3,
					[2] = 1.42,
				},
				[16] = 
				{
					[1] = 0.33,
					[2] = 1.6,
				},
				[17] = 
				{
					[1] = 0.35,
					[2] = 1.77,
				},
				[18] = 
				{
					[1] = 0.37,
					[2] = 1.93,
				},
				[19] = 
				{
					[1] = 0.39,
					[2] = 2.09,
				},
				[20] = 
				{
					[1] = 0.41,
					[2] = 2.25,
				},
				[21] = 
				{
					[1] = 0.43,
					[2] = 2.39,
				},
				[22] = 
				{
					[1] = 0.46,
					[2] = 2.51,
				},
				[23] = 
				{
					[1] = 0.48,
					[2] = 2.63,
				},
				[24] = 
				{
					[1] = 0.5,
					[2] = 2.74,
				},
				[25] = 
				{
					[1] = 0.52,
					[2] = 2.76,
				},
				[26] = 
				{
					[1] = 0.54,
					[2] = 2.74,
				},
				[27] = 
				{
					[1] = 0.57,
					[2] = 2.73,
				},
				[28] = 
				{
					[1] = 0.59,
					[2] = 2.71,
				},
				[29] = 
				{
					[1] = 0.61,
					[2] = 2.68,
				},
				[30] = 
				{
					[1] = 0.63,
					[2] = 2.66,
				},
				[31] = 
				{
					[1] = 0.65,
					[2] = 2.64,
				},
				[32] = 
				{
					[1] = 0.67,
					[2] = 2.63,
				},
				[33] = 
				{
					[1] = 0.7,
					[2] = 2.61,
				},
				[34] = 
				{
					[1] = 0.72,
					[2] = 2.59,
				},
				[35] = 
				{
					[1] = 0.74,
					[2] = 2.57,
				},
				[36] = 
				{
					[1] = 0.76,
					[2] = 2.55,
				},
				[37] = 
				{
					[1] = 0.78,
					[2] = 2.53,
				},
				[38] = 
				{
					[1] = 0.8,
					[2] = 2.51,
				},
				[39] = 
				{
					[1] = 0.83,
					[2] = 2.49,
				},
				[40] = 
				{
					[1] = 0.85,
					[2] = 2.46,
				},
				[41] = 
				{
					[1] = 0.87,
					[2] = 2.44,
				},
				[42] = 
				{
					[1] = 0.89,
					[2] = 2.41,
				},
				[43] = 
				{
					[1] = 0.91,
					[2] = 2.39,
				},
				[44] = 
				{
					[1] = 0.93,
					[2] = 2.36,
				},
				[45] = 
				{
					[1] = 0.96,
					[2] = 2.33,
				},
				[46] = 
				{
					[1] = 0.98,
					[2] = 2.3,
				},
			},
			["WidthScale"] = 1.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Dzsunka-big",
		["Type"] = "WaterTracer",
	},
	[214] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 40.537872,
			["Lifetime"] = 7.88,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2005,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.83,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 53.038765,
			["Lifetime"] = 10.31,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2506,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.37,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 9.362808,
			["Lifetime"] = 1.82,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.2506,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.84,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Dzsunka-big",
		["Type"] = "WaterTracer",
	},
	[215] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 20.200001,
			["LocalSpace"] = true,
			["MaxSpeed"] = 5.1444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2475,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 1.64,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 2.2,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 2.66,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 2.69,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 2.72,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 2.77,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 2.82,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 2.88,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 2.85,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 2.76,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 2.68,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 2.59,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 2.51,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 2.44,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 2.33,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 2.11,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 1.71,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 1.3,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.89,
				},
			},
			["WidthScale"] = 1.55,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.77,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[3] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[4] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[5] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 3.03,
			["LocalSpace"] = true,
			["MaxSpeed"] = 5.1444,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.75,
				},
				[3] = 
				{
					[1] = 0.07,
					[2] = 1.1,
				},
				[4] = 
				{
					[1] = 0.1,
					[2] = 1.38,
				},
				[5] = 
				{
					[1] = 0.13,
					[2] = 1.65,
				},
				[6] = 
				{
					[1] = 0.17,
					[2] = 1.91,
				},
				[7] = 
				{
					[1] = 0.2,
					[2] = 2.16,
				},
				[8] = 
				{
					[1] = 0.23,
					[2] = 2.36,
				},
				[9] = 
				{
					[1] = 0.27,
					[2] = 2.54,
				},
				[10] = 
				{
					[1] = 0.3,
					[2] = 2.7,
				},
				[11] = 
				{
					[1] = 0.33,
					[2] = 2.74,
				},
				[12] = 
				{
					[1] = 0.37,
					[2] = 2.78,
				},
				[13] = 
				{
					[1] = 0.4,
					[2] = 2.81,
				},
				[14] = 
				{
					[1] = 0.43,
					[2] = 2.84,
				},
				[15] = 
				{
					[1] = 0.47,
					[2] = 2.87,
				},
				[16] = 
				{
					[1] = 0.5,
					[2] = 2.89,
				},
				[17] = 
				{
					[1] = 0.53,
					[2] = 2.91,
				},
				[18] = 
				{
					[1] = 0.57,
					[2] = 2.92,
				},
				[19] = 
				{
					[1] = 0.6,
					[2] = 2.93,
				},
				[20] = 
				{
					[1] = 0.63,
					[2] = 2.94,
				},
				[21] = 
				{
					[1] = 0.67,
					[2] = 2.93,
				},
				[22] = 
				{
					[1] = 0.7,
					[2] = 2.92,
				},
				[23] = 
				{
					[1] = 0.73,
					[2] = 2.91,
				},
				[24] = 
				{
					[1] = 0.77,
					[2] = 2.89,
				},
				[25] = 
				{
					[1] = 0.8,
					[2] = 2.87,
				},
				[26] = 
				{
					[1] = 0.83,
					[2] = 2.85,
				},
				[27] = 
				{
					[1] = 0.87,
					[2] = 2.82,
				},
				[28] = 
				{
					[1] = 0.9,
					[2] = 2.79,
				},
				[29] = 
				{
					[1] = 0.93,
					[2] = 2.76,
				},
				[30] = 
				{
					[1] = 0.97,
					[2] = 2.72,
				},
			},
			["WidthScale"] = 1.2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_fishingboat",
		["Type"] = "WaterTracer",
	},
	[216] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 26.236441,
			["Lifetime"] = 5.1,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 1.1821,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.14,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 34.364594,
			["Lifetime"] = 6.68,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 1.4776,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.06,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 6.070392,
			["Lifetime"] = 1.18,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 1.4776,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.14,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_fishingboat",
		["Type"] = "WaterTracer",
	},
	[217] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 111.300003,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0449,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.44,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 0.7,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 0.95,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 1.19,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 1.44,
				},
				[7] = 
				{
					[1] = 0.05,
					[2] = 1.64,
				},
				[8] = 
				{
					[1] = 0.06,
					[2] = 1.84,
				},
				[9] = 
				{
					[1] = 0.07,
					[2] = 2.05,
				},
				[10] = 
				{
					[1] = 0.08,
					[2] = 2.24,
				},
				[11] = 
				{
					[1] = 0.09,
					[2] = 2.4,
				},
				[12] = 
				{
					[1] = 0.1,
					[2] = 2.55,
				},
				[13] = 
				{
					[1] = 0.11,
					[2] = 2.71,
				},
				[14] = 
				{
					[1] = 0.12,
					[2] = 2.87,
				},
				[15] = 
				{
					[1] = 0.13,
					[2] = 3.02,
				},
				[16] = 
				{
					[1] = 0.14,
					[2] = 3.18,
				},
				[17] = 
				{
					[1] = 0.14,
					[2] = 3.33,
				},
				[18] = 
				{
					[1] = 0.15,
					[2] = 3.49,
				},
				[19] = 
				{
					[1] = 0.16,
					[2] = 3.61,
				},
				[20] = 
				{
					[1] = 0.17,
					[2] = 3.72,
				},
				[21] = 
				{
					[1] = 0.18,
					[2] = 3.82,
				},
				[22] = 
				{
					[1] = 0.19,
					[2] = 3.93,
				},
				[23] = 
				{
					[1] = 0.2,
					[2] = 4.03,
				},
				[24] = 
				{
					[1] = 0.21,
					[2] = 4.14,
				},
				[25] = 
				{
					[1] = 0.22,
					[2] = 4.25,
				},
				[26] = 
				{
					[1] = 0.23,
					[2] = 4.35,
				},
				[27] = 
				{
					[1] = 0.23,
					[2] = 4.46,
				},
				[28] = 
				{
					[1] = 0.24,
					[2] = 4.53,
				},
				[29] = 
				{
					[1] = 0.25,
					[2] = 4.6,
				},
				[30] = 
				{
					[1] = 0.26,
					[2] = 4.67,
				},
				[31] = 
				{
					[1] = 0.27,
					[2] = 4.74,
				},
				[32] = 
				{
					[1] = 0.28,
					[2] = 4.8,
				},
				[33] = 
				{
					[1] = 0.29,
					[2] = 4.87,
				},
				[34] = 
				{
					[1] = 0.3,
					[2] = 4.94,
				},
				[35] = 
				{
					[1] = 0.31,
					[2] = 5.01,
				},
				[36] = 
				{
					[1] = 0.32,
					[2] = 5.07,
				},
				[37] = 
				{
					[1] = 0.32,
					[2] = 5.1,
				},
				[38] = 
				{
					[1] = 0.33,
					[2] = 5.14,
				},
				[39] = 
				{
					[1] = 0.34,
					[2] = 5.18,
				},
				[40] = 
				{
					[1] = 0.35,
					[2] = 5.22,
				},
				[41] = 
				{
					[1] = 0.36,
					[2] = 5.26,
				},
				[42] = 
				{
					[1] = 0.37,
					[2] = 5.3,
				},
				[43] = 
				{
					[1] = 0.38,
					[2] = 5.32,
				},
				[44] = 
				{
					[1] = 0.39,
					[2] = 5.33,
				},
				[45] = 
				{
					[1] = 0.4,
					[2] = 5.33,
				},
				[46] = 
				{
					[1] = 0.41,
					[2] = 5.34,
				},
				[47] = 
				{
					[1] = 0.41,
					[2] = 5.35,
				},
				[48] = 
				{
					[1] = 0.42,
					[2] = 5.36,
				},
				[49] = 
				{
					[1] = 0.43,
					[2] = 5.37,
				},
				[50] = 
				{
					[1] = 0.44,
					[2] = 5.38,
				},
				[51] = 
				{
					[1] = 0.45,
					[2] = 5.39,
				},
				[52] = 
				{
					[1] = 0.46,
					[2] = 5.41,
				},
				[53] = 
				{
					[1] = 0.47,
					[2] = 5.42,
				},
				[54] = 
				{
					[1] = 0.48,
					[2] = 5.43,
				},
				[55] = 
				{
					[1] = 0.49,
					[2] = 5.44,
				},
				[56] = 
				{
					[1] = 0.5,
					[2] = 5.45,
				},
				[57] = 
				{
					[1] = 0.5,
					[2] = 5.46,
				},
				[58] = 
				{
					[1] = 0.51,
					[2] = 5.47,
				},
				[59] = 
				{
					[1] = 0.52,
					[2] = 5.47,
				},
				[60] = 
				{
					[1] = 0.53,
					[2] = 5.48,
				},
				[61] = 
				{
					[1] = 0.54,
					[2] = 5.49,
				},
				[62] = 
				{
					[1] = 0.55,
					[2] = 5.49,
				},
				[63] = 
				{
					[1] = 0.56,
					[2] = 5.5,
				},
				[64] = 
				{
					[1] = 0.57,
					[2] = 5.51,
				},
				[65] = 
				{
					[1] = 0.58,
					[2] = 5.5,
				},
				[66] = 
				{
					[1] = 0.59,
					[2] = 5.49,
				},
				[67] = 
				{
					[1] = 0.59,
					[2] = 5.48,
				},
				[68] = 
				{
					[1] = 0.6,
					[2] = 5.47,
				},
				[69] = 
				{
					[1] = 0.61,
					[2] = 5.46,
				},
				[70] = 
				{
					[1] = 0.62,
					[2] = 5.45,
				},
				[71] = 
				{
					[1] = 0.63,
					[2] = 5.44,
				},
				[72] = 
				{
					[1] = 0.64,
					[2] = 5.43,
				},
				[73] = 
				{
					[1] = 0.65,
					[2] = 5.43,
				},
				[74] = 
				{
					[1] = 0.66,
					[2] = 5.42,
				},
				[75] = 
				{
					[1] = 0.67,
					[2] = 5.42,
				},
				[76] = 
				{
					[1] = 0.68,
					[2] = 5.41,
				},
				[77] = 
				{
					[1] = 0.68,
					[2] = 5.41,
				},
				[78] = 
				{
					[1] = 0.69,
					[2] = 5.41,
				},
				[79] = 
				{
					[1] = 0.7,
					[2] = 5.4,
				},
				[80] = 
				{
					[1] = 0.71,
					[2] = 5.4,
				},
				[81] = 
				{
					[1] = 0.72,
					[2] = 5.39,
				},
				[82] = 
				{
					[1] = 0.73,
					[2] = 5.37,
				},
				[83] = 
				{
					[1] = 0.74,
					[2] = 5.36,
				},
				[84] = 
				{
					[1] = 0.75,
					[2] = 5.34,
				},
				[85] = 
				{
					[1] = 0.76,
					[2] = 5.33,
				},
				[86] = 
				{
					[1] = 0.77,
					[2] = 5.31,
				},
				[87] = 
				{
					[1] = 0.77,
					[2] = 5.29,
				},
				[88] = 
				{
					[1] = 0.78,
					[2] = 5.28,
				},
				[89] = 
				{
					[1] = 0.79,
					[2] = 5.26,
				},
				[90] = 
				{
					[1] = 0.8,
					[2] = 5.24,
				},
				[91] = 
				{
					[1] = 0.81,
					[2] = 5.2,
				},
				[92] = 
				{
					[1] = 0.82,
					[2] = 5.15,
				},
				[93] = 
				{
					[1] = 0.83,
					[2] = 5.1,
				},
				[94] = 
				{
					[1] = 0.84,
					[2] = 5.05,
				},
				[95] = 
				{
					[1] = 0.85,
					[2] = 5,
				},
				[96] = 
				{
					[1] = 0.86,
					[2] = 4.95,
				},
				[97] = 
				{
					[1] = 0.86,
					[2] = 4.9,
				},
				[98] = 
				{
					[1] = 0.87,
					[2] = 4.86,
				},
				[99] = 
				{
					[1] = 0.88,
					[2] = 4.81,
				},
				[100] = 
				{
					[1] = 0.89,
					[2] = 4.76,
				},
				[101] = 
				{
					[1] = 0.9,
					[2] = 4.7,
				},
				[102] = 
				{
					[1] = 0.91,
					[2] = 4.61,
				},
				[103] = 
				{
					[1] = 0.92,
					[2] = 4.52,
				},
				[104] = 
				{
					[1] = 0.93,
					[2] = 4.43,
				},
				[105] = 
				{
					[1] = 0.94,
					[2] = 4.34,
				},
				[106] = 
				{
					[1] = 0.95,
					[2] = 4.25,
				},
				[107] = 
				{
					[1] = 0.95,
					[2] = 4.15,
				},
				[108] = 
				{
					[1] = 0.96,
					[2] = 4.05,
				},
				[109] = 
				{
					[1] = 0.97,
					[2] = 3.95,
				},
				[110] = 
				{
					[1] = 0.98,
					[2] = 3.8,
				},
				[111] = 
				{
					[1] = 0.99,
					[2] = 3.49,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 2.71,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.28,
				},
				[3] = 
				{
					[1] = 0.07,
					[2] = 0.38,
				},
				[4] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[5] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[6] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[7] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[9] = 
				{
					[1] = 0.3,
					[2] = 0.5,
				},
				[10] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[11] = 
				{
					[1] = 0.37,
					[2] = 0.47,
				},
				[12] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[13] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[14] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[15] = 
				{
					[1] = 0.52,
					[2] = 0.39,
				},
				[16] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[17] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.63,
					[2] = 0.3,
				},
				[19] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[20] = 
				{
					[1] = 0.7,
					[2] = 0.24,
				},
				[21] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[22] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[23] = 
				{
					[1] = 0.81,
					[2] = 0.15,
				},
				[24] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[25] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[26] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[27] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 10,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.34,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.46,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.52,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 0.58,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 0.63,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 0.69,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 0.75,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 0.8,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 0.86,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 0.91,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 0.97,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 1.02,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 1.07,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 1.11,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 1.15,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 1.19,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 1.24,
				},
				[20] = 
				{
					[1] = 0.11,
					[2] = 1.28,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 1.32,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 1.36,
				},
				[23] = 
				{
					[1] = 0.13,
					[2] = 1.41,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 1.45,
				},
				[25] = 
				{
					[1] = 0.14,
					[2] = 1.49,
				},
				[26] = 
				{
					[1] = 0.15,
					[2] = 1.53,
				},
				[27] = 
				{
					[1] = 0.16,
					[2] = 1.57,
				},
				[28] = 
				{
					[1] = 0.16,
					[2] = 1.61,
				},
				[29] = 
				{
					[1] = 0.17,
					[2] = 1.65,
				},
				[30] = 
				{
					[1] = 0.17,
					[2] = 1.69,
				},
				[31] = 
				{
					[1] = 0.18,
					[2] = 1.73,
				},
				[32] = 
				{
					[1] = 0.19,
					[2] = 1.76,
				},
				[33] = 
				{
					[1] = 0.19,
					[2] = 1.8,
				},
				[34] = 
				{
					[1] = 0.2,
					[2] = 1.84,
				},
				[35] = 
				{
					[1] = 0.2,
					[2] = 1.88,
				},
				[36] = 
				{
					[1] = 0.21,
					[2] = 1.92,
				},
				[37] = 
				{
					[1] = 0.22,
					[2] = 1.95,
				},
				[38] = 
				{
					[1] = 0.22,
					[2] = 1.99,
				},
				[39] = 
				{
					[1] = 0.23,
					[2] = 2.03,
				},
				[40] = 
				{
					[1] = 0.23,
					[2] = 2.06,
				},
				[41] = 
				{
					[1] = 0.24,
					[2] = 2.1,
				},
				[42] = 
				{
					[1] = 0.25,
					[2] = 2.14,
				},
				[43] = 
				{
					[1] = 0.25,
					[2] = 2.17,
				},
				[44] = 
				{
					[1] = 0.26,
					[2] = 2.21,
				},
				[45] = 
				{
					[1] = 0.26,
					[2] = 2.24,
				},
				[46] = 
				{
					[1] = 0.27,
					[2] = 2.28,
				},
				[47] = 
				{
					[1] = 0.28,
					[2] = 2.31,
				},
				[48] = 
				{
					[1] = 0.28,
					[2] = 2.34,
				},
				[49] = 
				{
					[1] = 0.29,
					[2] = 2.38,
				},
				[50] = 
				{
					[1] = 0.29,
					[2] = 2.41,
				},
				[51] = 
				{
					[1] = 0.3,
					[2] = 2.44,
				},
				[52] = 
				{
					[1] = 0.31,
					[2] = 2.47,
				},
				[53] = 
				{
					[1] = 0.31,
					[2] = 2.49,
				},
				[54] = 
				{
					[1] = 0.32,
					[2] = 2.52,
				},
				[55] = 
				{
					[1] = 0.32,
					[2] = 2.54,
				},
				[56] = 
				{
					[1] = 0.33,
					[2] = 2.57,
				},
				[57] = 
				{
					[1] = 0.34,
					[2] = 2.59,
				},
				[58] = 
				{
					[1] = 0.34,
					[2] = 2.62,
				},
				[59] = 
				{
					[1] = 0.35,
					[2] = 2.64,
				},
				[60] = 
				{
					[1] = 0.35,
					[2] = 2.67,
				},
				[61] = 
				{
					[1] = 0.36,
					[2] = 2.69,
				},
				[62] = 
				{
					[1] = 0.37,
					[2] = 2.71,
				},
				[63] = 
				{
					[1] = 0.37,
					[2] = 2.74,
				},
				[64] = 
				{
					[1] = 0.38,
					[2] = 2.76,
				},
				[65] = 
				{
					[1] = 0.38,
					[2] = 2.78,
				},
				[66] = 
				{
					[1] = 0.39,
					[2] = 2.8,
				},
				[67] = 
				{
					[1] = 0.4,
					[2] = 2.83,
				},
				[68] = 
				{
					[1] = 0.4,
					[2] = 2.85,
				},
				[69] = 
				{
					[1] = 0.41,
					[2] = 2.87,
				},
				[70] = 
				{
					[1] = 0.41,
					[2] = 2.89,
				},
				[71] = 
				{
					[1] = 0.42,
					[2] = 2.91,
				},
				[72] = 
				{
					[1] = 0.43,
					[2] = 2.93,
				},
				[73] = 
				{
					[1] = 0.43,
					[2] = 2.95,
				},
				[74] = 
				{
					[1] = 0.44,
					[2] = 2.97,
				},
				[75] = 
				{
					[1] = 0.44,
					[2] = 2.99,
				},
				[76] = 
				{
					[1] = 0.45,
					[2] = 3.01,
				},
				[77] = 
				{
					[1] = 0.46,
					[2] = 3.03,
				},
				[78] = 
				{
					[1] = 0.46,
					[2] = 3.05,
				},
				[79] = 
				{
					[1] = 0.47,
					[2] = 3.07,
				},
				[80] = 
				{
					[1] = 0.47,
					[2] = 3.09,
				},
				[81] = 
				{
					[1] = 0.48,
					[2] = 3.11,
				},
				[82] = 
				{
					[1] = 0.49,
					[2] = 3.13,
				},
				[83] = 
				{
					[1] = 0.49,
					[2] = 3.15,
				},
				[84] = 
				{
					[1] = 0.5,
					[2] = 3.17,
				},
				[85] = 
				{
					[1] = 0.5,
					[2] = 3.18,
				},
				[86] = 
				{
					[1] = 0.51,
					[2] = 3.2,
				},
				[87] = 
				{
					[1] = 0.51,
					[2] = 3.22,
				},
				[88] = 
				{
					[1] = 0.52,
					[2] = 3.24,
				},
				[89] = 
				{
					[1] = 0.53,
					[2] = 3.25,
				},
				[90] = 
				{
					[1] = 0.53,
					[2] = 3.27,
				},
				[91] = 
				{
					[1] = 0.54,
					[2] = 3.28,
				},
				[92] = 
				{
					[1] = 0.54,
					[2] = 3.28,
				},
				[93] = 
				{
					[1] = 0.55,
					[2] = 3.29,
				},
				[94] = 
				{
					[1] = 0.56,
					[2] = 3.3,
				},
				[95] = 
				{
					[1] = 0.56,
					[2] = 3.31,
				},
				[96] = 
				{
					[1] = 0.57,
					[2] = 3.32,
				},
				[97] = 
				{
					[1] = 0.57,
					[2] = 3.33,
				},
				[98] = 
				{
					[1] = 0.58,
					[2] = 3.34,
				},
				[99] = 
				{
					[1] = 0.59,
					[2] = 3.34,
				},
				[100] = 
				{
					[1] = 0.59,
					[2] = 3.35,
				},
				[101] = 
				{
					[1] = 0.6,
					[2] = 3.36,
				},
				[102] = 
				{
					[1] = 0.6,
					[2] = 3.37,
				},
				[103] = 
				{
					[1] = 0.61,
					[2] = 3.37,
				},
				[104] = 
				{
					[1] = 0.62,
					[2] = 3.38,
				},
				[105] = 
				{
					[1] = 0.62,
					[2] = 3.39,
				},
				[106] = 
				{
					[1] = 0.63,
					[2] = 3.39,
				},
				[107] = 
				{
					[1] = 0.63,
					[2] = 3.4,
				},
				[108] = 
				{
					[1] = 0.64,
					[2] = 3.41,
				},
				[109] = 
				{
					[1] = 0.65,
					[2] = 3.41,
				},
				[110] = 
				{
					[1] = 0.65,
					[2] = 3.42,
				},
				[111] = 
				{
					[1] = 0.66,
					[2] = 3.43,
				},
				[112] = 
				{
					[1] = 0.66,
					[2] = 3.43,
				},
				[113] = 
				{
					[1] = 0.67,
					[2] = 3.44,
				},
				[114] = 
				{
					[1] = 0.68,
					[2] = 3.44,
				},
				[115] = 
				{
					[1] = 0.68,
					[2] = 3.45,
				},
				[116] = 
				{
					[1] = 0.69,
					[2] = 3.45,
				},
				[117] = 
				{
					[1] = 0.69,
					[2] = 3.46,
				},
				[118] = 
				{
					[1] = 0.7,
					[2] = 3.46,
				},
				[119] = 
				{
					[1] = 0.71,
					[2] = 3.46,
				},
				[120] = 
				{
					[1] = 0.71,
					[2] = 3.47,
				},
				[121] = 
				{
					[1] = 0.72,
					[2] = 3.47,
				},
				[122] = 
				{
					[1] = 0.72,
					[2] = 3.48,
				},
				[123] = 
				{
					[1] = 0.73,
					[2] = 3.48,
				},
				[124] = 
				{
					[1] = 0.74,
					[2] = 3.48,
				},
				[125] = 
				{
					[1] = 0.74,
					[2] = 3.49,
				},
				[126] = 
				{
					[1] = 0.75,
					[2] = 3.49,
				},
				[127] = 
				{
					[1] = 0.75,
					[2] = 3.49,
				},
				[128] = 
				{
					[1] = 0.76,
					[2] = 3.49,
				},
				[129] = 
				{
					[1] = 0.77,
					[2] = 3.5,
				},
				[130] = 
				{
					[1] = 0.77,
					[2] = 3.5,
				},
				[131] = 
				{
					[1] = 0.78,
					[2] = 3.5,
				},
				[132] = 
				{
					[1] = 0.78,
					[2] = 3.5,
				},
				[133] = 
				{
					[1] = 0.79,
					[2] = 3.5,
				},
				[134] = 
				{
					[1] = 0.8,
					[2] = 3.51,
				},
				[135] = 
				{
					[1] = 0.8,
					[2] = 3.51,
				},
				[136] = 
				{
					[1] = 0.81,
					[2] = 3.51,
				},
				[137] = 
				{
					[1] = 0.81,
					[2] = 3.51,
				},
				[138] = 
				{
					[1] = 0.82,
					[2] = 3.51,
				},
				[139] = 
				{
					[1] = 0.83,
					[2] = 3.51,
				},
				[140] = 
				{
					[1] = 0.83,
					[2] = 3.51,
				},
				[141] = 
				{
					[1] = 0.84,
					[2] = 3.51,
				},
				[142] = 
				{
					[1] = 0.84,
					[2] = 3.51,
				},
				[143] = 
				{
					[1] = 0.85,
					[2] = 3.51,
				},
				[144] = 
				{
					[1] = 0.86,
					[2] = 3.51,
				},
				[145] = 
				{
					[1] = 0.86,
					[2] = 3.51,
				},
				[146] = 
				{
					[1] = 0.87,
					[2] = 3.51,
				},
				[147] = 
				{
					[1] = 0.87,
					[2] = 3.51,
				},
				[148] = 
				{
					[1] = 0.88,
					[2] = 3.51,
				},
				[149] = 
				{
					[1] = 0.89,
					[2] = 3.51,
				},
				[150] = 
				{
					[1] = 0.89,
					[2] = 3.5,
				},
				[151] = 
				{
					[1] = 0.9,
					[2] = 3.5,
				},
				[152] = 
				{
					[1] = 0.9,
					[2] = 3.5,
				},
				[153] = 
				{
					[1] = 0.91,
					[2] = 3.5,
				},
				[154] = 
				{
					[1] = 0.92,
					[2] = 3.5,
				},
				[155] = 
				{
					[1] = 0.92,
					[2] = 3.49,
				},
				[156] = 
				{
					[1] = 0.93,
					[2] = 3.49,
				},
				[157] = 
				{
					[1] = 0.93,
					[2] = 3.49,
				},
				[158] = 
				{
					[1] = 0.94,
					[2] = 3.48,
				},
				[159] = 
				{
					[1] = 0.95,
					[2] = 3.48,
				},
				[160] = 
				{
					[1] = 0.95,
					[2] = 3.48,
				},
				[161] = 
				{
					[1] = 0.96,
					[2] = 3.47,
				},
				[162] = 
				{
					[1] = 0.96,
					[2] = 3.47,
				},
				[163] = 
				{
					[1] = 0.97,
					[2] = 3.47,
				},
				[164] = 
				{
					[1] = 0.98,
					[2] = 3.46,
				},
				[165] = 
				{
					[1] = 0.98,
					[2] = 3.46,
				},
				[166] = 
				{
					[1] = 0.99,
					[2] = 3.45,
				},
				[167] = 
				{
					[1] = 0.99,
					[2] = 3.45,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_fletcher",
		["Type"] = "WaterTracer",
	},
	[218] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 144.763412,
			["Lifetime"] = 8.04,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0377,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.42,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 189.236755,
			["Lifetime"] = 10.51,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0471,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.95,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 33.30999,
			["Lifetime"] = 1.85,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0471,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.49,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_fletcher",
		["Type"] = "WaterTracer",
	},
	[219] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 113.099998,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0442,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.38,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 0.68,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 0.93,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 1.11,
				},
				[6] = 
				{
					[1] = 0.04,
					[2] = 1.25,
				},
				[7] = 
				{
					[1] = 0.05,
					[2] = 1.37,
				},
				[8] = 
				{
					[1] = 0.06,
					[2] = 1.49,
				},
				[9] = 
				{
					[1] = 0.07,
					[2] = 1.6,
				},
				[10] = 
				{
					[1] = 0.08,
					[2] = 1.72,
				},
				[11] = 
				{
					[1] = 0.09,
					[2] = 1.82,
				},
				[12] = 
				{
					[1] = 0.1,
					[2] = 1.93,
				},
				[13] = 
				{
					[1] = 0.11,
					[2] = 2.03,
				},
				[14] = 
				{
					[1] = 0.12,
					[2] = 2.14,
				},
				[15] = 
				{
					[1] = 0.12,
					[2] = 2.25,
				},
				[16] = 
				{
					[1] = 0.13,
					[2] = 2.35,
				},
				[17] = 
				{
					[1] = 0.14,
					[2] = 2.46,
				},
				[18] = 
				{
					[1] = 0.15,
					[2] = 2.56,
				},
				[19] = 
				{
					[1] = 0.16,
					[2] = 2.67,
				},
				[20] = 
				{
					[1] = 0.17,
					[2] = 2.77,
				},
				[21] = 
				{
					[1] = 0.18,
					[2] = 2.88,
				},
				[22] = 
				{
					[1] = 0.19,
					[2] = 2.98,
				},
				[23] = 
				{
					[1] = 0.19,
					[2] = 3.09,
				},
				[24] = 
				{
					[1] = 0.2,
					[2] = 3.2,
				},
				[25] = 
				{
					[1] = 0.21,
					[2] = 3.3,
				},
				[26] = 
				{
					[1] = 0.22,
					[2] = 3.41,
				},
				[27] = 
				{
					[1] = 0.23,
					[2] = 3.52,
				},
				[28] = 
				{
					[1] = 0.24,
					[2] = 3.6,
				},
				[29] = 
				{
					[1] = 0.25,
					[2] = 3.69,
				},
				[30] = 
				{
					[1] = 0.26,
					[2] = 3.78,
				},
				[31] = 
				{
					[1] = 0.27,
					[2] = 3.87,
				},
				[32] = 
				{
					[1] = 0.27,
					[2] = 3.96,
				},
				[33] = 
				{
					[1] = 0.28,
					[2] = 4.05,
				},
				[34] = 
				{
					[1] = 0.29,
					[2] = 4.14,
				},
				[35] = 
				{
					[1] = 0.3,
					[2] = 4.23,
				},
				[36] = 
				{
					[1] = 0.31,
					[2] = 4.32,
				},
				[37] = 
				{
					[1] = 0.32,
					[2] = 4.41,
				},
				[38] = 
				{
					[1] = 0.33,
					[2] = 4.5,
				},
				[39] = 
				{
					[1] = 0.34,
					[2] = 4.59,
				},
				[40] = 
				{
					[1] = 0.35,
					[2] = 4.64,
				},
				[41] = 
				{
					[1] = 0.35,
					[2] = 4.66,
				},
				[42] = 
				{
					[1] = 0.36,
					[2] = 4.67,
				},
				[43] = 
				{
					[1] = 0.37,
					[2] = 4.69,
				},
				[44] = 
				{
					[1] = 0.38,
					[2] = 4.71,
				},
				[45] = 
				{
					[1] = 0.39,
					[2] = 4.73,
				},
				[46] = 
				{
					[1] = 0.4,
					[2] = 4.74,
				},
				[47] = 
				{
					[1] = 0.41,
					[2] = 4.76,
				},
				[48] = 
				{
					[1] = 0.42,
					[2] = 4.77,
				},
				[49] = 
				{
					[1] = 0.42,
					[2] = 4.78,
				},
				[50] = 
				{
					[1] = 0.43,
					[2] = 4.79,
				},
				[51] = 
				{
					[1] = 0.44,
					[2] = 4.8,
				},
				[52] = 
				{
					[1] = 0.45,
					[2] = 4.82,
				},
				[53] = 
				{
					[1] = 0.46,
					[2] = 4.83,
				},
				[54] = 
				{
					[1] = 0.47,
					[2] = 4.84,
				},
				[55] = 
				{
					[1] = 0.48,
					[2] = 4.84,
				},
				[56] = 
				{
					[1] = 0.49,
					[2] = 4.84,
				},
				[57] = 
				{
					[1] = 0.5,
					[2] = 4.84,
				},
				[58] = 
				{
					[1] = 0.5,
					[2] = 4.84,
				},
				[59] = 
				{
					[1] = 0.51,
					[2] = 4.84,
				},
				[60] = 
				{
					[1] = 0.52,
					[2] = 4.84,
				},
				[61] = 
				{
					[1] = 0.53,
					[2] = 4.84,
				},
				[62] = 
				{
					[1] = 0.54,
					[2] = 4.84,
				},
				[63] = 
				{
					[1] = 0.55,
					[2] = 4.84,
				},
				[64] = 
				{
					[1] = 0.56,
					[2] = 4.84,
				},
				[65] = 
				{
					[1] = 0.57,
					[2] = 4.84,
				},
				[66] = 
				{
					[1] = 0.58,
					[2] = 4.84,
				},
				[67] = 
				{
					[1] = 0.58,
					[2] = 4.84,
				},
				[68] = 
				{
					[1] = 0.59,
					[2] = 4.84,
				},
				[69] = 
				{
					[1] = 0.6,
					[2] = 4.84,
				},
				[70] = 
				{
					[1] = 0.61,
					[2] = 4.84,
				},
				[71] = 
				{
					[1] = 0.62,
					[2] = 4.84,
				},
				[72] = 
				{
					[1] = 0.63,
					[2] = 4.84,
				},
				[73] = 
				{
					[1] = 0.64,
					[2] = 4.81,
				},
				[74] = 
				{
					[1] = 0.65,
					[2] = 4.78,
				},
				[75] = 
				{
					[1] = 0.65,
					[2] = 4.75,
				},
				[76] = 
				{
					[1] = 0.66,
					[2] = 4.72,
				},
				[77] = 
				{
					[1] = 0.67,
					[2] = 4.68,
				},
				[78] = 
				{
					[1] = 0.68,
					[2] = 4.65,
				},
				[79] = 
				{
					[1] = 0.69,
					[2] = 4.62,
				},
				[80] = 
				{
					[1] = 0.7,
					[2] = 4.59,
				},
				[81] = 
				{
					[1] = 0.71,
					[2] = 4.56,
				},
				[82] = 
				{
					[1] = 0.72,
					[2] = 4.53,
				},
				[83] = 
				{
					[1] = 0.73,
					[2] = 4.5,
				},
				[84] = 
				{
					[1] = 0.73,
					[2] = 4.47,
				},
				[85] = 
				{
					[1] = 0.74,
					[2] = 4.44,
				},
				[86] = 
				{
					[1] = 0.75,
					[2] = 4.41,
				},
				[87] = 
				{
					[1] = 0.76,
					[2] = 4.38,
				},
				[88] = 
				{
					[1] = 0.77,
					[2] = 4.34,
				},
				[89] = 
				{
					[1] = 0.78,
					[2] = 4.31,
				},
				[90] = 
				{
					[1] = 0.79,
					[2] = 4.28,
				},
				[91] = 
				{
					[1] = 0.8,
					[2] = 4.25,
				},
				[92] = 
				{
					[1] = 0.81,
					[2] = 4.21,
				},
				[93] = 
				{
					[1] = 0.81,
					[2] = 4.17,
				},
				[94] = 
				{
					[1] = 0.82,
					[2] = 4.14,
				},
				[95] = 
				{
					[1] = 0.83,
					[2] = 4.1,
				},
				[96] = 
				{
					[1] = 0.84,
					[2] = 4.05,
				},
				[97] = 
				{
					[1] = 0.85,
					[2] = 3.99,
				},
				[98] = 
				{
					[1] = 0.86,
					[2] = 3.93,
				},
				[99] = 
				{
					[1] = 0.87,
					[2] = 3.86,
				},
				[100] = 
				{
					[1] = 0.88,
					[2] = 3.8,
				},
				[101] = 
				{
					[1] = 0.88,
					[2] = 3.7,
				},
				[102] = 
				{
					[1] = 0.89,
					[2] = 3.6,
				},
				[103] = 
				{
					[1] = 0.9,
					[2] = 3.49,
				},
				[104] = 
				{
					[1] = 0.91,
					[2] = 3.34,
				},
				[105] = 
				{
					[1] = 0.92,
					[2] = 3.19,
				},
				[106] = 
				{
					[1] = 0.93,
					[2] = 3.05,
				},
				[107] = 
				{
					[1] = 0.94,
					[2] = 2.9,
				},
				[108] = 
				{
					[1] = 0.95,
					[2] = 2.75,
				},
				[109] = 
				{
					[1] = 0.96,
					[2] = 2.59,
				},
				[110] = 
				{
					[1] = 0.96,
					[2] = 2.29,
				},
				[111] = 
				{
					[1] = 0.97,
					[2] = 1.99,
				},
				[112] = 
				{
					[1] = 0.98,
					[2] = 1.66,
				},
				[113] = 
				{
					[1] = 0.99,
					[2] = 1.28,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.17,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.28,
				},
				[3] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[4] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[5] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[6] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[7] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[9] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[10] = 
				{
					[1] = 0.32,
					[2] = 0.49,
				},
				[11] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[12] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[13] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[14] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[15] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[16] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[17] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[18] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[19] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[20] = 
				{
					[1] = 0.68,
					[2] = 0.26,
				},
				[21] = 
				{
					[1] = 0.71,
					[2] = 0.23,
				},
				[22] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[23] = 
				{
					[1] = 0.79,
					[2] = 0.18,
				},
				[24] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[25] = 
				{
					[1] = 0.86,
					[2] = 0.12,
				},
				[26] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[27] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[28] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 10,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.13,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.21,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.28,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.36,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 0.43,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 0.49,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 0.56,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 0.62,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 0.68,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 0.74,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 0.8,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 0.86,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 0.92,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 0.98,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 1.03,
				},
				[17] = 
				{
					[1] = 0.09,
					[2] = 1.08,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 1.13,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 1.18,
				},
				[20] = 
				{
					[1] = 0.11,
					[2] = 1.23,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 1.28,
				},
				[22] = 
				{
					[1] = 0.12,
					[2] = 1.33,
				},
				[23] = 
				{
					[1] = 0.13,
					[2] = 1.38,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 1.42,
				},
				[25] = 
				{
					[1] = 0.14,
					[2] = 1.47,
				},
				[26] = 
				{
					[1] = 0.15,
					[2] = 1.52,
				},
				[27] = 
				{
					[1] = 0.15,
					[2] = 1.56,
				},
				[28] = 
				{
					[1] = 0.16,
					[2] = 1.61,
				},
				[29] = 
				{
					[1] = 0.17,
					[2] = 1.64,
				},
				[30] = 
				{
					[1] = 0.17,
					[2] = 1.67,
				},
				[31] = 
				{
					[1] = 0.18,
					[2] = 1.7,
				},
				[32] = 
				{
					[1] = 0.18,
					[2] = 1.72,
				},
				[33] = 
				{
					[1] = 0.19,
					[2] = 1.75,
				},
				[34] = 
				{
					[1] = 0.2,
					[2] = 1.78,
				},
				[35] = 
				{
					[1] = 0.2,
					[2] = 1.81,
				},
				[36] = 
				{
					[1] = 0.21,
					[2] = 1.83,
				},
				[37] = 
				{
					[1] = 0.21,
					[2] = 1.86,
				},
				[38] = 
				{
					[1] = 0.22,
					[2] = 1.89,
				},
				[39] = 
				{
					[1] = 0.22,
					[2] = 1.91,
				},
				[40] = 
				{
					[1] = 0.23,
					[2] = 1.94,
				},
				[41] = 
				{
					[1] = 0.24,
					[2] = 1.96,
				},
				[42] = 
				{
					[1] = 0.24,
					[2] = 1.99,
				},
				[43] = 
				{
					[1] = 0.25,
					[2] = 2.01,
				},
				[44] = 
				{
					[1] = 0.25,
					[2] = 2.04,
				},
				[45] = 
				{
					[1] = 0.26,
					[2] = 2.06,
				},
				[46] = 
				{
					[1] = 0.27,
					[2] = 2.07,
				},
				[47] = 
				{
					[1] = 0.27,
					[2] = 2.09,
				},
				[48] = 
				{
					[1] = 0.28,
					[2] = 2.1,
				},
				[49] = 
				{
					[1] = 0.28,
					[2] = 2.11,
				},
				[50] = 
				{
					[1] = 0.29,
					[2] = 2.13,
				},
				[51] = 
				{
					[1] = 0.3,
					[2] = 2.14,
				},
				[52] = 
				{
					[1] = 0.3,
					[2] = 2.15,
				},
				[53] = 
				{
					[1] = 0.31,
					[2] = 2.16,
				},
				[54] = 
				{
					[1] = 0.31,
					[2] = 2.17,
				},
				[55] = 
				{
					[1] = 0.32,
					[2] = 2.19,
				},
				[56] = 
				{
					[1] = 0.33,
					[2] = 2.2,
				},
				[57] = 
				{
					[1] = 0.33,
					[2] = 2.21,
				},
				[58] = 
				{
					[1] = 0.34,
					[2] = 2.22,
				},
				[59] = 
				{
					[1] = 0.34,
					[2] = 2.23,
				},
				[60] = 
				{
					[1] = 0.35,
					[2] = 2.24,
				},
				[61] = 
				{
					[1] = 0.36,
					[2] = 2.26,
				},
				[62] = 
				{
					[1] = 0.36,
					[2] = 2.27,
				},
				[63] = 
				{
					[1] = 0.37,
					[2] = 2.28,
				},
				[64] = 
				{
					[1] = 0.37,
					[2] = 2.29,
				},
				[65] = 
				{
					[1] = 0.38,
					[2] = 2.3,
				},
				[66] = 
				{
					[1] = 0.38,
					[2] = 2.31,
				},
				[67] = 
				{
					[1] = 0.39,
					[2] = 2.32,
				},
				[68] = 
				{
					[1] = 0.4,
					[2] = 2.33,
				},
				[69] = 
				{
					[1] = 0.4,
					[2] = 2.34,
				},
				[70] = 
				{
					[1] = 0.41,
					[2] = 2.35,
				},
				[71] = 
				{
					[1] = 0.41,
					[2] = 2.36,
				},
				[72] = 
				{
					[1] = 0.42,
					[2] = 2.37,
				},
				[73] = 
				{
					[1] = 0.43,
					[2] = 2.38,
				},
				[74] = 
				{
					[1] = 0.43,
					[2] = 2.39,
				},
				[75] = 
				{
					[1] = 0.44,
					[2] = 2.4,
				},
				[76] = 
				{
					[1] = 0.44,
					[2] = 2.41,
				},
				[77] = 
				{
					[1] = 0.45,
					[2] = 2.42,
				},
				[78] = 
				{
					[1] = 0.46,
					[2] = 2.42,
				},
				[79] = 
				{
					[1] = 0.46,
					[2] = 2.43,
				},
				[80] = 
				{
					[1] = 0.47,
					[2] = 2.44,
				},
				[81] = 
				{
					[1] = 0.47,
					[2] = 2.45,
				},
				[82] = 
				{
					[1] = 0.48,
					[2] = 2.46,
				},
				[83] = 
				{
					[1] = 0.49,
					[2] = 2.47,
				},
				[84] = 
				{
					[1] = 0.49,
					[2] = 2.47,
				},
				[85] = 
				{
					[1] = 0.5,
					[2] = 2.48,
				},
				[86] = 
				{
					[1] = 0.5,
					[2] = 2.49,
				},
				[87] = 
				{
					[1] = 0.51,
					[2] = 2.5,
				},
				[88] = 
				{
					[1] = 0.51,
					[2] = 2.5,
				},
				[89] = 
				{
					[1] = 0.52,
					[2] = 2.51,
				},
				[90] = 
				{
					[1] = 0.53,
					[2] = 2.52,
				},
				[91] = 
				{
					[1] = 0.53,
					[2] = 2.52,
				},
				[92] = 
				{
					[1] = 0.54,
					[2] = 2.53,
				},
				[93] = 
				{
					[1] = 0.54,
					[2] = 2.53,
				},
				[94] = 
				{
					[1] = 0.55,
					[2] = 2.54,
				},
				[95] = 
				{
					[1] = 0.56,
					[2] = 2.54,
				},
				[96] = 
				{
					[1] = 0.56,
					[2] = 2.55,
				},
				[97] = 
				{
					[1] = 0.57,
					[2] = 2.55,
				},
				[98] = 
				{
					[1] = 0.57,
					[2] = 2.56,
				},
				[99] = 
				{
					[1] = 0.58,
					[2] = 2.56,
				},
				[100] = 
				{
					[1] = 0.59,
					[2] = 2.57,
				},
				[101] = 
				{
					[1] = 0.59,
					[2] = 2.57,
				},
				[102] = 
				{
					[1] = 0.6,
					[2] = 2.57,
				},
				[103] = 
				{
					[1] = 0.6,
					[2] = 2.58,
				},
				[104] = 
				{
					[1] = 0.61,
					[2] = 2.58,
				},
				[105] = 
				{
					[1] = 0.62,
					[2] = 2.58,
				},
				[106] = 
				{
					[1] = 0.62,
					[2] = 2.59,
				},
				[107] = 
				{
					[1] = 0.63,
					[2] = 2.59,
				},
				[108] = 
				{
					[1] = 0.63,
					[2] = 2.59,
				},
				[109] = 
				{
					[1] = 0.64,
					[2] = 2.6,
				},
				[110] = 
				{
					[1] = 0.64,
					[2] = 2.6,
				},
				[111] = 
				{
					[1] = 0.65,
					[2] = 2.6,
				},
				[112] = 
				{
					[1] = 0.66,
					[2] = 2.61,
				},
				[113] = 
				{
					[1] = 0.66,
					[2] = 2.61,
				},
				[114] = 
				{
					[1] = 0.67,
					[2] = 2.61,
				},
				[115] = 
				{
					[1] = 0.67,
					[2] = 2.61,
				},
				[116] = 
				{
					[1] = 0.68,
					[2] = 2.62,
				},
				[117] = 
				{
					[1] = 0.69,
					[2] = 2.62,
				},
				[118] = 
				{
					[1] = 0.69,
					[2] = 2.62,
				},
				[119] = 
				{
					[1] = 0.7,
					[2] = 2.62,
				},
				[120] = 
				{
					[1] = 0.7,
					[2] = 2.62,
				},
				[121] = 
				{
					[1] = 0.71,
					[2] = 2.63,
				},
				[122] = 
				{
					[1] = 0.72,
					[2] = 2.63,
				},
				[123] = 
				{
					[1] = 0.72,
					[2] = 2.63,
				},
				[124] = 
				{
					[1] = 0.73,
					[2] = 2.63,
				},
				[125] = 
				{
					[1] = 0.73,
					[2] = 2.63,
				},
				[126] = 
				{
					[1] = 0.74,
					[2] = 2.63,
				},
				[127] = 
				{
					[1] = 0.75,
					[2] = 2.63,
				},
				[128] = 
				{
					[1] = 0.75,
					[2] = 2.63,
				},
				[129] = 
				{
					[1] = 0.76,
					[2] = 2.63,
				},
				[130] = 
				{
					[1] = 0.76,
					[2] = 2.63,
				},
				[131] = 
				{
					[1] = 0.77,
					[2] = 2.63,
				},
				[132] = 
				{
					[1] = 0.78,
					[2] = 2.63,
				},
				[133] = 
				{
					[1] = 0.78,
					[2] = 2.63,
				},
				[134] = 
				{
					[1] = 0.79,
					[2] = 2.63,
				},
				[135] = 
				{
					[1] = 0.79,
					[2] = 2.63,
				},
				[136] = 
				{
					[1] = 0.8,
					[2] = 2.63,
				},
				[137] = 
				{
					[1] = 0.8,
					[2] = 2.63,
				},
				[138] = 
				{
					[1] = 0.81,
					[2] = 2.63,
				},
				[139] = 
				{
					[1] = 0.82,
					[2] = 2.63,
				},
				[140] = 
				{
					[1] = 0.82,
					[2] = 2.63,
				},
				[141] = 
				{
					[1] = 0.83,
					[2] = 2.63,
				},
				[142] = 
				{
					[1] = 0.83,
					[2] = 2.63,
				},
				[143] = 
				{
					[1] = 0.84,
					[2] = 2.63,
				},
				[144] = 
				{
					[1] = 0.85,
					[2] = 2.63,
				},
				[145] = 
				{
					[1] = 0.85,
					[2] = 2.63,
				},
				[146] = 
				{
					[1] = 0.86,
					[2] = 2.62,
				},
				[147] = 
				{
					[1] = 0.86,
					[2] = 2.62,
				},
				[148] = 
				{
					[1] = 0.87,
					[2] = 2.62,
				},
				[149] = 
				{
					[1] = 0.88,
					[2] = 2.62,
				},
				[150] = 
				{
					[1] = 0.88,
					[2] = 2.62,
				},
				[151] = 
				{
					[1] = 0.89,
					[2] = 2.61,
				},
				[152] = 
				{
					[1] = 0.89,
					[2] = 2.61,
				},
				[153] = 
				{
					[1] = 0.9,
					[2] = 2.61,
				},
				[154] = 
				{
					[1] = 0.91,
					[2] = 2.61,
				},
				[155] = 
				{
					[1] = 0.91,
					[2] = 2.6,
				},
				[156] = 
				{
					[1] = 0.92,
					[2] = 2.6,
				},
				[157] = 
				{
					[1] = 0.92,
					[2] = 2.6,
				},
				[158] = 
				{
					[1] = 0.93,
					[2] = 2.6,
				},
				[159] = 
				{
					[1] = 0.93,
					[2] = 2.59,
				},
				[160] = 
				{
					[1] = 0.94,
					[2] = 2.59,
				},
				[161] = 
				{
					[1] = 0.95,
					[2] = 2.59,
				},
				[162] = 
				{
					[1] = 0.95,
					[2] = 2.58,
				},
				[163] = 
				{
					[1] = 0.96,
					[2] = 2.58,
				},
				[164] = 
				{
					[1] = 0.96,
					[2] = 2.58,
				},
				[165] = 
				{
					[1] = 0.97,
					[2] = 2.57,
				},
				[166] = 
				{
					[1] = 0.98,
					[2] = 2.57,
				},
				[167] = 
				{
					[1] = 0.98,
					[2] = 2.56,
				},
				[168] = 
				{
					[1] = 0.99,
					[2] = 2.56,
				},
				[169] = 
				{
					[1] = 0.99,
					[2] = 2.55,
				},
			},
			["WidthScale"] = 0.8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_fubuki",
		["Type"] = "WaterTracer",
	},
	[220] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 147.104111,
			["Lifetime"] = 8.17,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0587,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.84,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 192.297668,
			["Lifetime"] = 10.68,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0733,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.25,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 33.850151,
			["Lifetime"] = 1.88,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0733,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.89,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_fubuki",
		["Type"] = "WaterTracer",
	},
	[221] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 210.100006,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0238,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.44,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.87,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 1.1,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.22,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.36,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 1.58,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 1.8,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 2.02,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 2.23,
				},
				[13] = 
				{
					[1] = 0.06,
					[2] = 2.45,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 2.67,
				},
				[15] = 
				{
					[1] = 0.07,
					[2] = 2.89,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 3.11,
				},
				[17] = 
				{
					[1] = 0.08,
					[2] = 3.32,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 3.54,
				},
				[19] = 
				{
					[1] = 0.09,
					[2] = 3.76,
				},
				[20] = 
				{
					[1] = 0.09,
					[2] = 3.97,
				},
				[21] = 
				{
					[1] = 0.1,
					[2] = 4.18,
				},
				[22] = 
				{
					[1] = 0.1,
					[2] = 4.39,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 4.6,
				},
				[24] = 
				{
					[1] = 0.11,
					[2] = 4.81,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 5.02,
				},
				[26] = 
				{
					[1] = 0.12,
					[2] = 5.23,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 5.44,
				},
				[28] = 
				{
					[1] = 0.13,
					[2] = 5.66,
				},
				[29] = 
				{
					[1] = 0.13,
					[2] = 5.89,
				},
				[30] = 
				{
					[1] = 0.14,
					[2] = 6.11,
				},
				[31] = 
				{
					[1] = 0.14,
					[2] = 6.34,
				},
				[32] = 
				{
					[1] = 0.15,
					[2] = 6.56,
				},
				[33] = 
				{
					[1] = 0.15,
					[2] = 6.77,
				},
				[34] = 
				{
					[1] = 0.16,
					[2] = 6.98,
				},
				[35] = 
				{
					[1] = 0.16,
					[2] = 7.18,
				},
				[36] = 
				{
					[1] = 0.17,
					[2] = 7.39,
				},
				[37] = 
				{
					[1] = 0.17,
					[2] = 7.6,
				},
				[38] = 
				{
					[1] = 0.18,
					[2] = 7.8,
				},
				[39] = 
				{
					[1] = 0.18,
					[2] = 8.02,
				},
				[40] = 
				{
					[1] = 0.19,
					[2] = 8.27,
				},
				[41] = 
				{
					[1] = 0.19,
					[2] = 8.52,
				},
				[42] = 
				{
					[1] = 0.2,
					[2] = 8.77,
				},
				[43] = 
				{
					[1] = 0.2,
					[2] = 9.03,
				},
				[44] = 
				{
					[1] = 0.2,
					[2] = 9.28,
				},
				[45] = 
				{
					[1] = 0.21,
					[2] = 9.53,
				},
				[46] = 
				{
					[1] = 0.21,
					[2] = 9.79,
				},
				[47] = 
				{
					[1] = 0.22,
					[2] = 10.04,
				},
				[48] = 
				{
					[1] = 0.22,
					[2] = 10.21,
				},
				[49] = 
				{
					[1] = 0.23,
					[2] = 10.38,
				},
				[50] = 
				{
					[1] = 0.23,
					[2] = 10.55,
				},
				[51] = 
				{
					[1] = 0.24,
					[2] = 10.72,
				},
				[52] = 
				{
					[1] = 0.24,
					[2] = 10.89,
				},
				[53] = 
				{
					[1] = 0.25,
					[2] = 11.06,
				},
				[54] = 
				{
					[1] = 0.25,
					[2] = 11.23,
				},
				[55] = 
				{
					[1] = 0.26,
					[2] = 11.4,
				},
				[56] = 
				{
					[1] = 0.26,
					[2] = 11.59,
				},
				[57] = 
				{
					[1] = 0.27,
					[2] = 11.77,
				},
				[58] = 
				{
					[1] = 0.27,
					[2] = 11.95,
				},
				[59] = 
				{
					[1] = 0.28,
					[2] = 12.14,
				},
				[60] = 
				{
					[1] = 0.28,
					[2] = 12.32,
				},
				[61] = 
				{
					[1] = 0.29,
					[2] = 12.48,
				},
				[62] = 
				{
					[1] = 0.29,
					[2] = 12.61,
				},
				[63] = 
				{
					[1] = 0.3,
					[2] = 12.75,
				},
				[64] = 
				{
					[1] = 0.3,
					[2] = 12.89,
				},
				[65] = 
				{
					[1] = 0.3,
					[2] = 13.02,
				},
				[66] = 
				{
					[1] = 0.31,
					[2] = 13.16,
				},
				[67] = 
				{
					[1] = 0.31,
					[2] = 13.3,
				},
				[68] = 
				{
					[1] = 0.32,
					[2] = 13.44,
				},
				[69] = 
				{
					[1] = 0.32,
					[2] = 13.57,
				},
				[70] = 
				{
					[1] = 0.33,
					[2] = 13.65,
				},
				[71] = 
				{
					[1] = 0.33,
					[2] = 13.74,
				},
				[72] = 
				{
					[1] = 0.34,
					[2] = 13.82,
				},
				[73] = 
				{
					[1] = 0.34,
					[2] = 13.9,
				},
				[74] = 
				{
					[1] = 0.35,
					[2] = 13.98,
				},
				[75] = 
				{
					[1] = 0.35,
					[2] = 14.07,
				},
				[76] = 
				{
					[1] = 0.36,
					[2] = 14.15,
				},
				[77] = 
				{
					[1] = 0.36,
					[2] = 14.23,
				},
				[78] = 
				{
					[1] = 0.37,
					[2] = 14.31,
				},
				[79] = 
				{
					[1] = 0.37,
					[2] = 14.39,
				},
				[80] = 
				{
					[1] = 0.38,
					[2] = 14.44,
				},
				[81] = 
				{
					[1] = 0.38,
					[2] = 14.48,
				},
				[82] = 
				{
					[1] = 0.39,
					[2] = 14.53,
				},
				[83] = 
				{
					[1] = 0.39,
					[2] = 14.58,
				},
				[84] = 
				{
					[1] = 0.4,
					[2] = 14.63,
				},
				[85] = 
				{
					[1] = 0.4,
					[2] = 14.68,
				},
				[86] = 
				{
					[1] = 0.4,
					[2] = 14.73,
				},
				[87] = 
				{
					[1] = 0.41,
					[2] = 14.78,
				},
				[88] = 
				{
					[1] = 0.41,
					[2] = 14.83,
				},
				[89] = 
				{
					[1] = 0.42,
					[2] = 14.86,
				},
				[90] = 
				{
					[1] = 0.42,
					[2] = 14.89,
				},
				[91] = 
				{
					[1] = 0.43,
					[2] = 14.91,
				},
				[92] = 
				{
					[1] = 0.43,
					[2] = 14.93,
				},
				[93] = 
				{
					[1] = 0.44,
					[2] = 14.95,
				},
				[94] = 
				{
					[1] = 0.44,
					[2] = 14.97,
				},
				[95] = 
				{
					[1] = 0.45,
					[2] = 15,
				},
				[96] = 
				{
					[1] = 0.45,
					[2] = 15.02,
				},
				[97] = 
				{
					[1] = 0.46,
					[2] = 15.04,
				},
				[98] = 
				{
					[1] = 0.46,
					[2] = 15.06,
				},
				[99] = 
				{
					[1] = 0.47,
					[2] = 15.09,
				},
				[100] = 
				{
					[1] = 0.47,
					[2] = 15.11,
				},
				[101] = 
				{
					[1] = 0.48,
					[2] = 15.13,
				},
				[102] = 
				{
					[1] = 0.48,
					[2] = 15.15,
				},
				[103] = 
				{
					[1] = 0.49,
					[2] = 15.18,
				},
				[104] = 
				{
					[1] = 0.49,
					[2] = 15.2,
				},
				[105] = 
				{
					[1] = 0.5,
					[2] = 15.19,
				},
				[106] = 
				{
					[1] = 0.5,
					[2] = 15.18,
				},
				[107] = 
				{
					[1] = 0.5,
					[2] = 15.17,
				},
				[108] = 
				{
					[1] = 0.51,
					[2] = 15.16,
				},
				[109] = 
				{
					[1] = 0.51,
					[2] = 15.15,
				},
				[110] = 
				{
					[1] = 0.52,
					[2] = 15.14,
				},
				[111] = 
				{
					[1] = 0.52,
					[2] = 15.13,
				},
				[112] = 
				{
					[1] = 0.53,
					[2] = 15.11,
				},
				[113] = 
				{
					[1] = 0.53,
					[2] = 15.1,
				},
				[114] = 
				{
					[1] = 0.54,
					[2] = 15.09,
				},
				[115] = 
				{
					[1] = 0.54,
					[2] = 15.08,
				},
				[116] = 
				{
					[1] = 0.55,
					[2] = 15.07,
				},
				[117] = 
				{
					[1] = 0.55,
					[2] = 15.06,
				},
				[118] = 
				{
					[1] = 0.56,
					[2] = 15.05,
				},
				[119] = 
				{
					[1] = 0.56,
					[2] = 15.04,
				},
				[120] = 
				{
					[1] = 0.57,
					[2] = 15.03,
				},
				[121] = 
				{
					[1] = 0.57,
					[2] = 15.02,
				},
				[122] = 
				{
					[1] = 0.58,
					[2] = 15,
				},
				[123] = 
				{
					[1] = 0.58,
					[2] = 14.97,
				},
				[124] = 
				{
					[1] = 0.59,
					[2] = 14.95,
				},
				[125] = 
				{
					[1] = 0.59,
					[2] = 14.93,
				},
				[126] = 
				{
					[1] = 0.6,
					[2] = 14.9,
				},
				[127] = 
				{
					[1] = 0.6,
					[2] = 14.88,
				},
				[128] = 
				{
					[1] = 0.6,
					[2] = 14.85,
				},
				[129] = 
				{
					[1] = 0.61,
					[2] = 14.83,
				},
				[130] = 
				{
					[1] = 0.61,
					[2] = 14.8,
				},
				[131] = 
				{
					[1] = 0.62,
					[2] = 14.78,
				},
				[132] = 
				{
					[1] = 0.62,
					[2] = 14.76,
				},
				[133] = 
				{
					[1] = 0.63,
					[2] = 14.73,
				},
				[134] = 
				{
					[1] = 0.63,
					[2] = 14.71,
				},
				[135] = 
				{
					[1] = 0.64,
					[2] = 14.68,
				},
				[136] = 
				{
					[1] = 0.64,
					[2] = 14.63,
				},
				[137] = 
				{
					[1] = 0.65,
					[2] = 14.55,
				},
				[138] = 
				{
					[1] = 0.65,
					[2] = 14.48,
				},
				[139] = 
				{
					[1] = 0.66,
					[2] = 14.4,
				},
				[140] = 
				{
					[1] = 0.66,
					[2] = 14.33,
				},
				[141] = 
				{
					[1] = 0.67,
					[2] = 14.25,
				},
				[142] = 
				{
					[1] = 0.67,
					[2] = 14.18,
				},
				[143] = 
				{
					[1] = 0.68,
					[2] = 14.12,
				},
				[144] = 
				{
					[1] = 0.68,
					[2] = 14.06,
				},
				[145] = 
				{
					[1] = 0.69,
					[2] = 14.01,
				},
				[146] = 
				{
					[1] = 0.69,
					[2] = 13.96,
				},
				[147] = 
				{
					[1] = 0.7,
					[2] = 13.9,
				},
				[148] = 
				{
					[1] = 0.7,
					[2] = 13.85,
				},
				[149] = 
				{
					[1] = 0.7,
					[2] = 13.79,
				},
				[150] = 
				{
					[1] = 0.71,
					[2] = 13.73,
				},
				[151] = 
				{
					[1] = 0.71,
					[2] = 13.65,
				},
				[152] = 
				{
					[1] = 0.72,
					[2] = 13.58,
				},
				[153] = 
				{
					[1] = 0.72,
					[2] = 13.5,
				},
				[154] = 
				{
					[1] = 0.73,
					[2] = 13.43,
				},
				[155] = 
				{
					[1] = 0.73,
					[2] = 13.35,
				},
				[156] = 
				{
					[1] = 0.74,
					[2] = 13.28,
				},
				[157] = 
				{
					[1] = 0.74,
					[2] = 13.19,
				},
				[158] = 
				{
					[1] = 0.75,
					[2] = 13.07,
				},
				[159] = 
				{
					[1] = 0.75,
					[2] = 12.94,
				},
				[160] = 
				{
					[1] = 0.76,
					[2] = 12.82,
				},
				[161] = 
				{
					[1] = 0.76,
					[2] = 12.69,
				},
				[162] = 
				{
					[1] = 0.77,
					[2] = 12.57,
				},
				[163] = 
				{
					[1] = 0.77,
					[2] = 12.44,
				},
				[164] = 
				{
					[1] = 0.78,
					[2] = 12.32,
				},
				[165] = 
				{
					[1] = 0.78,
					[2] = 12.19,
				},
				[166] = 
				{
					[1] = 0.79,
					[2] = 12.03,
				},
				[167] = 
				{
					[1] = 0.79,
					[2] = 11.85,
				},
				[168] = 
				{
					[1] = 0.8,
					[2] = 11.67,
				},
				[169] = 
				{
					[1] = 0.8,
					[2] = 11.49,
				},
				[170] = 
				{
					[1] = 0.8,
					[2] = 11.32,
				},
				[171] = 
				{
					[1] = 0.81,
					[2] = 11.14,
				},
				[172] = 
				{
					[1] = 0.81,
					[2] = 10.96,
				},
				[173] = 
				{
					[1] = 0.82,
					[2] = 10.78,
				},
				[174] = 
				{
					[1] = 0.82,
					[2] = 10.6,
				},
				[175] = 
				{
					[1] = 0.83,
					[2] = 10.41,
				},
				[176] = 
				{
					[1] = 0.83,
					[2] = 10.23,
				},
				[177] = 
				{
					[1] = 0.84,
					[2] = 10.01,
				},
				[178] = 
				{
					[1] = 0.84,
					[2] = 9.72,
				},
				[179] = 
				{
					[1] = 0.85,
					[2] = 9.45,
				},
				[180] = 
				{
					[1] = 0.85,
					[2] = 9.2,
				},
				[181] = 
				{
					[1] = 0.86,
					[2] = 8.95,
				},
				[182] = 
				{
					[1] = 0.86,
					[2] = 8.7,
				},
				[183] = 
				{
					[1] = 0.87,
					[2] = 8.46,
				},
				[184] = 
				{
					[1] = 0.87,
					[2] = 8.21,
				},
				[185] = 
				{
					[1] = 0.88,
					[2] = 7.96,
				},
				[186] = 
				{
					[1] = 0.88,
					[2] = 7.71,
				},
				[187] = 
				{
					[1] = 0.89,
					[2] = 7.46,
				},
				[188] = 
				{
					[1] = 0.89,
					[2] = 7.22,
				},
				[189] = 
				{
					[1] = 0.9,
					[2] = 6.97,
				},
				[190] = 
				{
					[1] = 0.9,
					[2] = 6.71,
				},
				[191] = 
				{
					[1] = 0.9,
					[2] = 6.46,
				},
				[192] = 
				{
					[1] = 0.91,
					[2] = 6.21,
				},
				[193] = 
				{
					[1] = 0.91,
					[2] = 5.96,
				},
				[194] = 
				{
					[1] = 0.92,
					[2] = 5.71,
				},
				[195] = 
				{
					[1] = 0.92,
					[2] = 5.45,
				},
				[196] = 
				{
					[1] = 0.93,
					[2] = 5.2,
				},
				[197] = 
				{
					[1] = 0.93,
					[2] = 4.95,
				},
				[198] = 
				{
					[1] = 0.94,
					[2] = 4.7,
				},
				[199] = 
				{
					[1] = 0.94,
					[2] = 4.44,
				},
				[200] = 
				{
					[1] = 0.95,
					[2] = 4.15,
				},
				[201] = 
				{
					[1] = 0.95,
					[2] = 3.87,
				},
				[202] = 
				{
					[1] = 0.96,
					[2] = 3.58,
				},
				[203] = 
				{
					[1] = 0.96,
					[2] = 3.3,
				},
				[204] = 
				{
					[1] = 0.97,
					[2] = 3.01,
				},
				[205] = 
				{
					[1] = 0.97,
					[2] = 2.74,
				},
				[206] = 
				{
					[1] = 0.98,
					[2] = 2.49,
				},
				[207] = 
				{
					[1] = 0.98,
					[2] = 2.24,
				},
				[208] = 
				{
					[1] = 0.99,
					[2] = 1.99,
				},
				[209] = 
				{
					[1] = 0.99,
					[2] = 1.74,
				},
				[210] = 
				{
					[1] = 1,
					[2] = 1.38,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4.25,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.21,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.29,
				},
				[4] = 
				{
					[1] = 0.06,
					[2] = 0.34,
				},
				[5] = 
				{
					[1] = 0.08,
					[2] = 0.38,
				},
				[6] = 
				{
					[1] = 0.1,
					[2] = 0.41,
				},
				[7] = 
				{
					[1] = 0.12,
					[2] = 0.44,
				},
				[8] = 
				{
					[1] = 0.13,
					[2] = 0.46,
				},
				[9] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[10] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[12] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[18] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[19] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[20] = 
				{
					[1] = 0.37,
					[2] = 0.47,
				},
				[21] = 
				{
					[1] = 0.38,
					[2] = 0.46,
				},
				[22] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[23] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[24] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[25] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[26] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[27] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[28] = 
				{
					[1] = 0.52,
					[2] = 0.39,
				},
				[29] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[30] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[31] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[32] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[33] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[34] = 
				{
					[1] = 0.63,
					[2] = 0.3,
				},
				[35] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[36] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[37] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[38] = 
				{
					[1] = 0.71,
					[2] = 0.24,
				},
				[39] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[40] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[41] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[42] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[43] = 
				{
					[1] = 0.81,
					[2] = 0.16,
				},
				[44] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[45] = 
				{
					[1] = 0.85,
					[2] = 0.13,
				},
				[46] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[47] = 
				{
					[1] = 0.88,
					[2] = 0.09,
				},
				[48] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[49] = 
				{
					[1] = 0.92,
					[2] = 0.06,
				},
				[50] = 
				{
					[1] = 0.94,
					[2] = 0.05,
				},
				[51] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
				[52] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 6.95,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.17,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.3,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.42,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.49,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.56,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.62,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 0.68,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.74,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.8,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 0.86,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 0.92,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 0.98,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 1.04,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 1.1,
				},
				[16] = 
				{
					[1] = 0.05,
					[2] = 1.16,
				},
				[17] = 
				{
					[1] = 0.05,
					[2] = 1.22,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 1.28,
				},
				[19] = 
				{
					[1] = 0.06,
					[2] = 1.34,
				},
				[20] = 
				{
					[1] = 0.06,
					[2] = 1.4,
				},
				[21] = 
				{
					[1] = 0.06,
					[2] = 1.45,
				},
				[22] = 
				{
					[1] = 0.07,
					[2] = 1.47,
				},
				[23] = 
				{
					[1] = 0.07,
					[2] = 1.49,
				},
				[24] = 
				{
					[1] = 0.07,
					[2] = 1.51,
				},
				[25] = 
				{
					[1] = 0.08,
					[2] = 1.54,
				},
				[26] = 
				{
					[1] = 0.08,
					[2] = 1.56,
				},
				[27] = 
				{
					[1] = 0.08,
					[2] = 1.58,
				},
				[28] = 
				{
					[1] = 0.09,
					[2] = 1.59,
				},
				[29] = 
				{
					[1] = 0.09,
					[2] = 1.61,
				},
				[30] = 
				{
					[1] = 0.09,
					[2] = 1.63,
				},
				[31] = 
				{
					[1] = 0.1,
					[2] = 1.65,
				},
				[32] = 
				{
					[1] = 0.1,
					[2] = 1.67,
				},
				[33] = 
				{
					[1] = 0.1,
					[2] = 1.69,
				},
				[34] = 
				{
					[1] = 0.1,
					[2] = 1.71,
				},
				[35] = 
				{
					[1] = 0.11,
					[2] = 1.73,
				},
				[36] = 
				{
					[1] = 0.11,
					[2] = 1.75,
				},
				[37] = 
				{
					[1] = 0.11,
					[2] = 1.77,
				},
				[38] = 
				{
					[1] = 0.12,
					[2] = 1.79,
				},
				[39] = 
				{
					[1] = 0.12,
					[2] = 1.81,
				},
				[40] = 
				{
					[1] = 0.12,
					[2] = 1.83,
				},
				[41] = 
				{
					[1] = 0.13,
					[2] = 1.85,
				},
				[42] = 
				{
					[1] = 0.13,
					[2] = 1.87,
				},
				[43] = 
				{
					[1] = 0.13,
					[2] = 1.88,
				},
				[44] = 
				{
					[1] = 0.14,
					[2] = 1.9,
				},
				[45] = 
				{
					[1] = 0.14,
					[2] = 1.92,
				},
				[46] = 
				{
					[1] = 0.14,
					[2] = 1.94,
				},
				[47] = 
				{
					[1] = 0.15,
					[2] = 1.96,
				},
				[48] = 
				{
					[1] = 0.15,
					[2] = 1.98,
				},
				[49] = 
				{
					[1] = 0.15,
					[2] = 2,
				},
				[50] = 
				{
					[1] = 0.16,
					[2] = 2.01,
				},
				[51] = 
				{
					[1] = 0.16,
					[2] = 2.03,
				},
				[52] = 
				{
					[1] = 0.16,
					[2] = 2.05,
				},
				[53] = 
				{
					[1] = 0.17,
					[2] = 2.07,
				},
				[54] = 
				{
					[1] = 0.17,
					[2] = 2.09,
				},
				[55] = 
				{
					[1] = 0.17,
					[2] = 2.1,
				},
				[56] = 
				{
					[1] = 0.17,
					[2] = 2.12,
				},
				[57] = 
				{
					[1] = 0.18,
					[2] = 2.14,
				},
				[58] = 
				{
					[1] = 0.18,
					[2] = 2.16,
				},
				[59] = 
				{
					[1] = 0.18,
					[2] = 2.17,
				},
				[60] = 
				{
					[1] = 0.19,
					[2] = 2.19,
				},
				[61] = 
				{
					[1] = 0.19,
					[2] = 2.21,
				},
				[62] = 
				{
					[1] = 0.19,
					[2] = 2.23,
				},
				[63] = 
				{
					[1] = 0.2,
					[2] = 2.24,
				},
				[64] = 
				{
					[1] = 0.2,
					[2] = 2.26,
				},
				[65] = 
				{
					[1] = 0.2,
					[2] = 2.28,
				},
				[66] = 
				{
					[1] = 0.21,
					[2] = 2.3,
				},
				[67] = 
				{
					[1] = 0.21,
					[2] = 2.31,
				},
				[68] = 
				{
					[1] = 0.21,
					[2] = 2.33,
				},
				[69] = 
				{
					[1] = 0.22,
					[2] = 2.35,
				},
				[70] = 
				{
					[1] = 0.22,
					[2] = 2.38,
				},
				[71] = 
				{
					[1] = 0.22,
					[2] = 2.42,
				},
				[72] = 
				{
					[1] = 0.23,
					[2] = 2.45,
				},
				[73] = 
				{
					[1] = 0.23,
					[2] = 2.49,
				},
				[74] = 
				{
					[1] = 0.23,
					[2] = 2.52,
				},
				[75] = 
				{
					[1] = 0.23,
					[2] = 2.56,
				},
				[76] = 
				{
					[1] = 0.24,
					[2] = 2.59,
				},
				[77] = 
				{
					[1] = 0.24,
					[2] = 2.62,
				},
				[78] = 
				{
					[1] = 0.24,
					[2] = 2.66,
				},
				[79] = 
				{
					[1] = 0.25,
					[2] = 2.69,
				},
				[80] = 
				{
					[1] = 0.25,
					[2] = 2.72,
				},
				[81] = 
				{
					[1] = 0.25,
					[2] = 2.76,
				},
				[82] = 
				{
					[1] = 0.26,
					[2] = 2.79,
				},
				[83] = 
				{
					[1] = 0.26,
					[2] = 2.82,
				},
				[84] = 
				{
					[1] = 0.26,
					[2] = 2.86,
				},
				[85] = 
				{
					[1] = 0.27,
					[2] = 2.89,
				},
				[86] = 
				{
					[1] = 0.27,
					[2] = 2.92,
				},
				[87] = 
				{
					[1] = 0.27,
					[2] = 2.95,
				},
				[88] = 
				{
					[1] = 0.28,
					[2] = 2.98,
				},
				[89] = 
				{
					[1] = 0.28,
					[2] = 3.02,
				},
				[90] = 
				{
					[1] = 0.28,
					[2] = 3.05,
				},
				[91] = 
				{
					[1] = 0.29,
					[2] = 3.08,
				},
				[92] = 
				{
					[1] = 0.29,
					[2] = 3.11,
				},
				[93] = 
				{
					[1] = 0.29,
					[2] = 3.14,
				},
				[94] = 
				{
					[1] = 0.3,
					[2] = 3.17,
				},
				[95] = 
				{
					[1] = 0.3,
					[2] = 3.21,
				},
				[96] = 
				{
					[1] = 0.3,
					[2] = 3.24,
				},
				[97] = 
				{
					[1] = 0.3,
					[2] = 3.27,
				},
				[98] = 
				{
					[1] = 0.31,
					[2] = 3.3,
				},
				[99] = 
				{
					[1] = 0.31,
					[2] = 3.33,
				},
				[100] = 
				{
					[1] = 0.31,
					[2] = 3.36,
				},
				[101] = 
				{
					[1] = 0.32,
					[2] = 3.39,
				},
				[102] = 
				{
					[1] = 0.32,
					[2] = 3.42,
				},
				[103] = 
				{
					[1] = 0.32,
					[2] = 3.45,
				},
				[104] = 
				{
					[1] = 0.33,
					[2] = 3.48,
				},
				[105] = 
				{
					[1] = 0.33,
					[2] = 3.51,
				},
				[106] = 
				{
					[1] = 0.33,
					[2] = 3.54,
				},
				[107] = 
				{
					[1] = 0.34,
					[2] = 3.57,
				},
				[108] = 
				{
					[1] = 0.34,
					[2] = 3.6,
				},
				[109] = 
				{
					[1] = 0.34,
					[2] = 3.63,
				},
				[110] = 
				{
					[1] = 0.35,
					[2] = 3.66,
				},
				[111] = 
				{
					[1] = 0.35,
					[2] = 3.69,
				},
				[112] = 
				{
					[1] = 0.35,
					[2] = 3.72,
				},
				[113] = 
				{
					[1] = 0.36,
					[2] = 3.74,
				},
				[114] = 
				{
					[1] = 0.36,
					[2] = 3.77,
				},
				[115] = 
				{
					[1] = 0.36,
					[2] = 3.8,
				},
				[116] = 
				{
					[1] = 0.37,
					[2] = 3.83,
				},
				[117] = 
				{
					[1] = 0.37,
					[2] = 3.86,
				},
				[118] = 
				{
					[1] = 0.37,
					[2] = 3.89,
				},
				[119] = 
				{
					[1] = 0.37,
					[2] = 3.91,
				},
				[120] = 
				{
					[1] = 0.38,
					[2] = 3.94,
				},
				[121] = 
				{
					[1] = 0.38,
					[2] = 3.97,
				},
				[122] = 
				{
					[1] = 0.38,
					[2] = 4,
				},
				[123] = 
				{
					[1] = 0.39,
					[2] = 4.02,
				},
				[124] = 
				{
					[1] = 0.39,
					[2] = 4.05,
				},
				[125] = 
				{
					[1] = 0.39,
					[2] = 4.08,
				},
				[126] = 
				{
					[1] = 0.4,
					[2] = 4.11,
				},
				[127] = 
				{
					[1] = 0.4,
					[2] = 4.13,
				},
				[128] = 
				{
					[1] = 0.4,
					[2] = 4.16,
				},
				[129] = 
				{
					[1] = 0.41,
					[2] = 4.19,
				},
				[130] = 
				{
					[1] = 0.41,
					[2] = 4.21,
				},
				[131] = 
				{
					[1] = 0.41,
					[2] = 4.24,
				},
				[132] = 
				{
					[1] = 0.42,
					[2] = 4.26,
				},
				[133] = 
				{
					[1] = 0.42,
					[2] = 4.29,
				},
				[134] = 
				{
					[1] = 0.42,
					[2] = 4.32,
				},
				[135] = 
				{
					[1] = 0.43,
					[2] = 4.34,
				},
				[136] = 
				{
					[1] = 0.43,
					[2] = 4.37,
				},
				[137] = 
				{
					[1] = 0.43,
					[2] = 4.39,
				},
				[138] = 
				{
					[1] = 0.43,
					[2] = 4.42,
				},
				[139] = 
				{
					[1] = 0.44,
					[2] = 4.44,
				},
				[140] = 
				{
					[1] = 0.44,
					[2] = 4.47,
				},
				[141] = 
				{
					[1] = 0.44,
					[2] = 4.49,
				},
				[142] = 
				{
					[1] = 0.45,
					[2] = 4.52,
				},
				[143] = 
				{
					[1] = 0.45,
					[2] = 4.54,
				},
				[144] = 
				{
					[1] = 0.45,
					[2] = 4.57,
				},
				[145] = 
				{
					[1] = 0.46,
					[2] = 4.59,
				},
				[146] = 
				{
					[1] = 0.46,
					[2] = 4.61,
				},
				[147] = 
				{
					[1] = 0.46,
					[2] = 4.64,
				},
				[148] = 
				{
					[1] = 0.47,
					[2] = 4.66,
				},
				[149] = 
				{
					[1] = 0.47,
					[2] = 4.69,
				},
				[150] = 
				{
					[1] = 0.47,
					[2] = 4.71,
				},
				[151] = 
				{
					[1] = 0.48,
					[2] = 4.73,
				},
				[152] = 
				{
					[1] = 0.48,
					[2] = 4.76,
				},
				[153] = 
				{
					[1] = 0.48,
					[2] = 4.78,
				},
				[154] = 
				{
					[1] = 0.49,
					[2] = 4.8,
				},
				[155] = 
				{
					[1] = 0.49,
					[2] = 4.83,
				},
				[156] = 
				{
					[1] = 0.49,
					[2] = 4.85,
				},
				[157] = 
				{
					[1] = 0.5,
					[2] = 4.87,
				},
				[158] = 
				{
					[1] = 0.5,
					[2] = 4.89,
				},
				[159] = 
				{
					[1] = 0.5,
					[2] = 4.92,
				},
				[160] = 
				{
					[1] = 0.5,
					[2] = 4.94,
				},
				[161] = 
				{
					[1] = 0.51,
					[2] = 4.96,
				},
				[162] = 
				{
					[1] = 0.51,
					[2] = 4.98,
				},
				[163] = 
				{
					[1] = 0.51,
					[2] = 5,
				},
				[164] = 
				{
					[1] = 0.52,
					[2] = 5.03,
				},
				[165] = 
				{
					[1] = 0.52,
					[2] = 5.05,
				},
				[166] = 
				{
					[1] = 0.52,
					[2] = 5.07,
				},
				[167] = 
				{
					[1] = 0.53,
					[2] = 5.09,
				},
				[168] = 
				{
					[1] = 0.53,
					[2] = 5.11,
				},
				[169] = 
				{
					[1] = 0.53,
					[2] = 5.13,
				},
				[170] = 
				{
					[1] = 0.54,
					[2] = 5.15,
				},
				[171] = 
				{
					[1] = 0.54,
					[2] = 5.17,
				},
				[172] = 
				{
					[1] = 0.54,
					[2] = 5.19,
				},
				[173] = 
				{
					[1] = 0.55,
					[2] = 5.21,
				},
				[174] = 
				{
					[1] = 0.55,
					[2] = 5.24,
				},
				[175] = 
				{
					[1] = 0.55,
					[2] = 5.26,
				},
				[176] = 
				{
					[1] = 0.56,
					[2] = 5.28,
				},
				[177] = 
				{
					[1] = 0.56,
					[2] = 5.3,
				},
				[178] = 
				{
					[1] = 0.56,
					[2] = 5.31,
				},
				[179] = 
				{
					[1] = 0.57,
					[2] = 5.33,
				},
				[180] = 
				{
					[1] = 0.57,
					[2] = 5.35,
				},
				[181] = 
				{
					[1] = 0.57,
					[2] = 5.37,
				},
				[182] = 
				{
					[1] = 0.57,
					[2] = 5.39,
				},
				[183] = 
				{
					[1] = 0.58,
					[2] = 5.41,
				},
				[184] = 
				{
					[1] = 0.58,
					[2] = 5.42,
				},
				[185] = 
				{
					[1] = 0.58,
					[2] = 5.44,
				},
				[186] = 
				{
					[1] = 0.59,
					[2] = 5.46,
				},
				[187] = 
				{
					[1] = 0.59,
					[2] = 5.48,
				},
				[188] = 
				{
					[1] = 0.59,
					[2] = 5.49,
				},
				[189] = 
				{
					[1] = 0.6,
					[2] = 5.51,
				},
				[190] = 
				{
					[1] = 0.6,
					[2] = 5.53,
				},
				[191] = 
				{
					[1] = 0.6,
					[2] = 5.54,
				},
				[192] = 
				{
					[1] = 0.61,
					[2] = 5.56,
				},
				[193] = 
				{
					[1] = 0.61,
					[2] = 5.58,
				},
				[194] = 
				{
					[1] = 0.61,
					[2] = 5.59,
				},
				[195] = 
				{
					[1] = 0.62,
					[2] = 5.61,
				},
				[196] = 
				{
					[1] = 0.62,
					[2] = 5.62,
				},
				[197] = 
				{
					[1] = 0.62,
					[2] = 5.64,
				},
				[198] = 
				{
					[1] = 0.63,
					[2] = 5.66,
				},
				[199] = 
				{
					[1] = 0.63,
					[2] = 5.67,
				},
				[200] = 
				{
					[1] = 0.63,
					[2] = 5.69,
				},
				[201] = 
				{
					[1] = 0.63,
					[2] = 5.7,
				},
				[202] = 
				{
					[1] = 0.64,
					[2] = 5.72,
				},
				[203] = 
				{
					[1] = 0.64,
					[2] = 5.73,
				},
				[204] = 
				{
					[1] = 0.64,
					[2] = 5.75,
				},
				[205] = 
				{
					[1] = 0.65,
					[2] = 5.76,
				},
				[206] = 
				{
					[1] = 0.65,
					[2] = 5.78,
				},
				[207] = 
				{
					[1] = 0.65,
					[2] = 5.79,
				},
				[208] = 
				{
					[1] = 0.66,
					[2] = 5.81,
				},
				[209] = 
				{
					[1] = 0.66,
					[2] = 5.82,
				},
				[210] = 
				{
					[1] = 0.66,
					[2] = 5.84,
				},
				[211] = 
				{
					[1] = 0.67,
					[2] = 5.85,
				},
				[212] = 
				{
					[1] = 0.67,
					[2] = 5.86,
				},
				[213] = 
				{
					[1] = 0.67,
					[2] = 5.88,
				},
				[214] = 
				{
					[1] = 0.68,
					[2] = 5.89,
				},
				[215] = 
				{
					[1] = 0.68,
					[2] = 5.9,
				},
				[216] = 
				{
					[1] = 0.68,
					[2] = 5.92,
				},
				[217] = 
				{
					[1] = 0.69,
					[2] = 5.93,
				},
				[218] = 
				{
					[1] = 0.69,
					[2] = 5.94,
				},
				[219] = 
				{
					[1] = 0.69,
					[2] = 5.96,
				},
				[220] = 
				{
					[1] = 0.7,
					[2] = 5.97,
				},
				[221] = 
				{
					[1] = 0.7,
					[2] = 5.98,
				},
				[222] = 
				{
					[1] = 0.7,
					[2] = 6,
				},
				[223] = 
				{
					[1] = 0.7,
					[2] = 6.01,
				},
				[224] = 
				{
					[1] = 0.71,
					[2] = 6.02,
				},
				[225] = 
				{
					[1] = 0.71,
					[2] = 6.03,
				},
				[226] = 
				{
					[1] = 0.71,
					[2] = 6.04,
				},
				[227] = 
				{
					[1] = 0.72,
					[2] = 6.06,
				},
				[228] = 
				{
					[1] = 0.72,
					[2] = 6.07,
				},
				[229] = 
				{
					[1] = 0.72,
					[2] = 6.08,
				},
				[230] = 
				{
					[1] = 0.73,
					[2] = 6.09,
				},
				[231] = 
				{
					[1] = 0.73,
					[2] = 6.1,
				},
				[232] = 
				{
					[1] = 0.73,
					[2] = 6.11,
				},
				[233] = 
				{
					[1] = 0.74,
					[2] = 6.13,
				},
				[234] = 
				{
					[1] = 0.74,
					[2] = 6.14,
				},
				[235] = 
				{
					[1] = 0.74,
					[2] = 6.15,
				},
				[236] = 
				{
					[1] = 0.75,
					[2] = 6.16,
				},
				[237] = 
				{
					[1] = 0.75,
					[2] = 6.17,
				},
				[238] = 
				{
					[1] = 0.75,
					[2] = 6.18,
				},
				[239] = 
				{
					[1] = 0.76,
					[2] = 6.19,
				},
				[240] = 
				{
					[1] = 0.76,
					[2] = 6.2,
				},
				[241] = 
				{
					[1] = 0.76,
					[2] = 6.21,
				},
				[242] = 
				{
					[1] = 0.77,
					[2] = 6.22,
				},
				[243] = 
				{
					[1] = 0.77,
					[2] = 6.23,
				},
				[244] = 
				{
					[1] = 0.77,
					[2] = 6.24,
				},
				[245] = 
				{
					[1] = 0.77,
					[2] = 6.25,
				},
				[246] = 
				{
					[1] = 0.78,
					[2] = 6.26,
				},
				[247] = 
				{
					[1] = 0.78,
					[2] = 6.27,
				},
				[248] = 
				{
					[1] = 0.78,
					[2] = 6.28,
				},
				[249] = 
				{
					[1] = 0.79,
					[2] = 6.29,
				},
				[250] = 
				{
					[1] = 0.79,
					[2] = 6.29,
				},
				[251] = 
				{
					[1] = 0.79,
					[2] = 6.3,
				},
				[252] = 
				{
					[1] = 0.8,
					[2] = 6.31,
				},
				[253] = 
				{
					[1] = 0.8,
					[2] = 6.32,
				},
				[254] = 
				{
					[1] = 0.8,
					[2] = 6.33,
				},
				[255] = 
				{
					[1] = 0.81,
					[2] = 6.34,
				},
				[256] = 
				{
					[1] = 0.81,
					[2] = 6.35,
				},
				[257] = 
				{
					[1] = 0.81,
					[2] = 6.35,
				},
				[258] = 
				{
					[1] = 0.82,
					[2] = 6.36,
				},
				[259] = 
				{
					[1] = 0.82,
					[2] = 6.37,
				},
				[260] = 
				{
					[1] = 0.82,
					[2] = 6.38,
				},
				[261] = 
				{
					[1] = 0.83,
					[2] = 6.39,
				},
				[262] = 
				{
					[1] = 0.83,
					[2] = 6.39,
				},
				[263] = 
				{
					[1] = 0.83,
					[2] = 6.4,
				},
				[264] = 
				{
					[1] = 0.83,
					[2] = 6.41,
				},
				[265] = 
				{
					[1] = 0.84,
					[2] = 6.42,
				},
				[266] = 
				{
					[1] = 0.84,
					[2] = 6.43,
				},
				[267] = 
				{
					[1] = 0.84,
					[2] = 6.44,
				},
				[268] = 
				{
					[1] = 0.85,
					[2] = 6.45,
				},
				[269] = 
				{
					[1] = 0.85,
					[2] = 6.45,
				},
				[270] = 
				{
					[1] = 0.85,
					[2] = 6.46,
				},
				[271] = 
				{
					[1] = 0.86,
					[2] = 6.47,
				},
				[272] = 
				{
					[1] = 0.86,
					[2] = 6.48,
				},
				[273] = 
				{
					[1] = 0.86,
					[2] = 6.48,
				},
				[274] = 
				{
					[1] = 0.87,
					[2] = 6.49,
				},
				[275] = 
				{
					[1] = 0.87,
					[2] = 6.5,
				},
				[276] = 
				{
					[1] = 0.87,
					[2] = 6.51,
				},
				[277] = 
				{
					[1] = 0.88,
					[2] = 6.51,
				},
				[278] = 
				{
					[1] = 0.88,
					[2] = 6.52,
				},
				[279] = 
				{
					[1] = 0.88,
					[2] = 6.53,
				},
				[280] = 
				{
					[1] = 0.89,
					[2] = 6.53,
				},
				[281] = 
				{
					[1] = 0.89,
					[2] = 6.54,
				},
				[282] = 
				{
					[1] = 0.89,
					[2] = 6.55,
				},
				[283] = 
				{
					[1] = 0.9,
					[2] = 6.55,
				},
				[284] = 
				{
					[1] = 0.9,
					[2] = 6.56,
				},
				[285] = 
				{
					[1] = 0.9,
					[2] = 6.56,
				},
				[286] = 
				{
					[1] = 0.9,
					[2] = 6.57,
				},
				[287] = 
				{
					[1] = 0.91,
					[2] = 6.57,
				},
				[288] = 
				{
					[1] = 0.91,
					[2] = 6.58,
				},
				[289] = 
				{
					[1] = 0.91,
					[2] = 6.59,
				},
				[290] = 
				{
					[1] = 0.92,
					[2] = 6.59,
				},
				[291] = 
				{
					[1] = 0.92,
					[2] = 6.6,
				},
				[292] = 
				{
					[1] = 0.92,
					[2] = 6.6,
				},
				[293] = 
				{
					[1] = 0.93,
					[2] = 6.6,
				},
				[294] = 
				{
					[1] = 0.93,
					[2] = 6.61,
				},
				[295] = 
				{
					[1] = 0.93,
					[2] = 6.61,
				},
				[296] = 
				{
					[1] = 0.94,
					[2] = 6.62,
				},
				[297] = 
				{
					[1] = 0.94,
					[2] = 6.62,
				},
				[298] = 
				{
					[1] = 0.94,
					[2] = 6.63,
				},
				[299] = 
				{
					[1] = 0.95,
					[2] = 6.63,
				},
				[300] = 
				{
					[1] = 0.95,
					[2] = 6.63,
				},
				[301] = 
				{
					[1] = 0.95,
					[2] = 6.64,
				},
				[302] = 
				{
					[1] = 0.96,
					[2] = 6.64,
				},
				[303] = 
				{
					[1] = 0.96,
					[2] = 6.64,
				},
				[304] = 
				{
					[1] = 0.96,
					[2] = 6.65,
				},
				[305] = 
				{
					[1] = 0.97,
					[2] = 6.65,
				},
				[306] = 
				{
					[1] = 0.97,
					[2] = 6.65,
				},
				[307] = 
				{
					[1] = 0.97,
					[2] = 6.65,
				},
				[308] = 
				{
					[1] = 0.97,
					[2] = 6.66,
				},
				[309] = 
				{
					[1] = 0.98,
					[2] = 6.66,
				},
				[310] = 
				{
					[1] = 0.98,
					[2] = 6.66,
				},
				[311] = 
				{
					[1] = 0.98,
					[2] = 6.66,
				},
				[312] = 
				{
					[1] = 0.99,
					[2] = 6.67,
				},
				[313] = 
				{
					[1] = 0.99,
					[2] = 6.67,
				},
				[314] = 
				{
					[1] = 0.99,
					[2] = 6.67,
				},
				[315] = 
				{
					[1] = 1,
					[2] = 6.67,
				},
			},
			["WidthScale"] = 0.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Fuso",
		["Type"] = "WaterTracer",
	},
	[222] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 273.167633,
			["Lifetime"] = 26.549999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0198,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.43,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 357.124237,
			["Lifetime"] = 34.709999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0247,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.71,
			["WidthScaler"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 63.070343,
			["Lifetime"] = 6.13,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0247,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.57,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Fuso",
		["Type"] = "WaterTracer",
	},
	[223] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 92.199997,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0542,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 1.09,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 1.21,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 1.29,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 1.37,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 1.46,
				},
				[7] = 
				{
					[1] = 0.07,
					[2] = 1.57,
				},
				[8] = 
				{
					[1] = 0.08,
					[2] = 1.67,
				},
				[9] = 
				{
					[1] = 0.09,
					[2] = 1.78,
				},
				[10] = 
				{
					[1] = 0.1,
					[2] = 1.9,
				},
				[11] = 
				{
					[1] = 0.11,
					[2] = 1.97,
				},
				[12] = 
				{
					[1] = 0.12,
					[2] = 2.03,
				},
				[13] = 
				{
					[1] = 0.13,
					[2] = 2.09,
				},
				[14] = 
				{
					[1] = 0.14,
					[2] = 2.16,
				},
				[15] = 
				{
					[1] = 0.15,
					[2] = 2.23,
				},
				[16] = 
				{
					[1] = 0.16,
					[2] = 2.29,
				},
				[17] = 
				{
					[1] = 0.17,
					[2] = 2.36,
				},
				[18] = 
				{
					[1] = 0.18,
					[2] = 2.42,
				},
				[19] = 
				{
					[1] = 0.2,
					[2] = 2.49,
				},
				[20] = 
				{
					[1] = 0.21,
					[2] = 2.56,
				},
				[21] = 
				{
					[1] = 0.22,
					[2] = 2.62,
				},
				[22] = 
				{
					[1] = 0.23,
					[2] = 2.69,
				},
				[23] = 
				{
					[1] = 0.24,
					[2] = 2.75,
				},
				[24] = 
				{
					[1] = 0.25,
					[2] = 2.81,
				},
				[25] = 
				{
					[1] = 0.26,
					[2] = 2.87,
				},
				[26] = 
				{
					[1] = 0.27,
					[2] = 2.94,
				},
				[27] = 
				{
					[1] = 0.28,
					[2] = 3,
				},
				[28] = 
				{
					[1] = 0.29,
					[2] = 3.06,
				},
				[29] = 
				{
					[1] = 0.3,
					[2] = 3.12,
				},
				[30] = 
				{
					[1] = 0.32,
					[2] = 3.19,
				},
				[31] = 
				{
					[1] = 0.33,
					[2] = 3.25,
				},
				[32] = 
				{
					[1] = 0.34,
					[2] = 3.31,
				},
				[33] = 
				{
					[1] = 0.35,
					[2] = 3.36,
				},
				[34] = 
				{
					[1] = 0.36,
					[2] = 3.42,
				},
				[35] = 
				{
					[1] = 0.37,
					[2] = 3.47,
				},
				[36] = 
				{
					[1] = 0.38,
					[2] = 3.53,
				},
				[37] = 
				{
					[1] = 0.39,
					[2] = 3.57,
				},
				[38] = 
				{
					[1] = 0.4,
					[2] = 3.59,
				},
				[39] = 
				{
					[1] = 0.41,
					[2] = 3.62,
				},
				[40] = 
				{
					[1] = 0.42,
					[2] = 3.65,
				},
				[41] = 
				{
					[1] = 0.43,
					[2] = 3.68,
				},
				[42] = 
				{
					[1] = 0.45,
					[2] = 3.7,
				},
				[43] = 
				{
					[1] = 0.46,
					[2] = 3.73,
				},
				[44] = 
				{
					[1] = 0.47,
					[2] = 3.76,
				},
				[45] = 
				{
					[1] = 0.48,
					[2] = 3.79,
				},
				[46] = 
				{
					[1] = 0.49,
					[2] = 3.8,
				},
				[47] = 
				{
					[1] = 0.5,
					[2] = 3.8,
				},
				[48] = 
				{
					[1] = 0.51,
					[2] = 3.8,
				},
				[49] = 
				{
					[1] = 0.52,
					[2] = 3.8,
				},
				[50] = 
				{
					[1] = 0.53,
					[2] = 3.77,
				},
				[51] = 
				{
					[1] = 0.54,
					[2] = 3.73,
				},
				[52] = 
				{
					[1] = 0.55,
					[2] = 3.69,
				},
				[53] = 
				{
					[1] = 0.57,
					[2] = 3.65,
				},
				[54] = 
				{
					[1] = 0.58,
					[2] = 3.61,
				},
				[55] = 
				{
					[1] = 0.59,
					[2] = 3.57,
				},
				[56] = 
				{
					[1] = 0.6,
					[2] = 3.53,
				},
				[57] = 
				{
					[1] = 0.61,
					[2] = 3.49,
				},
				[58] = 
				{
					[1] = 0.62,
					[2] = 3.45,
				},
				[59] = 
				{
					[1] = 0.63,
					[2] = 3.41,
				},
				[60] = 
				{
					[1] = 0.64,
					[2] = 3.37,
				},
				[61] = 
				{
					[1] = 0.65,
					[2] = 3.33,
				},
				[62] = 
				{
					[1] = 0.66,
					[2] = 3.29,
				},
				[63] = 
				{
					[1] = 0.67,
					[2] = 3.25,
				},
				[64] = 
				{
					[1] = 0.68,
					[2] = 3.21,
				},
				[65] = 
				{
					[1] = 0.7,
					[2] = 3.17,
				},
				[66] = 
				{
					[1] = 0.71,
					[2] = 3.13,
				},
				[67] = 
				{
					[1] = 0.72,
					[2] = 3.09,
				},
				[68] = 
				{
					[1] = 0.73,
					[2] = 3.03,
				},
				[69] = 
				{
					[1] = 0.74,
					[2] = 2.96,
				},
				[70] = 
				{
					[1] = 0.75,
					[2] = 2.89,
				},
				[71] = 
				{
					[1] = 0.76,
					[2] = 2.82,
				},
				[72] = 
				{
					[1] = 0.77,
					[2] = 2.71,
				},
				[73] = 
				{
					[1] = 0.78,
					[2] = 2.6,
				},
				[74] = 
				{
					[1] = 0.79,
					[2] = 2.49,
				},
				[75] = 
				{
					[1] = 0.8,
					[2] = 2.38,
				},
				[76] = 
				{
					[1] = 0.82,
					[2] = 2.26,
				},
				[77] = 
				{
					[1] = 0.83,
					[2] = 2.12,
				},
				[78] = 
				{
					[1] = 0.84,
					[2] = 1.99,
				},
				[79] = 
				{
					[1] = 0.85,
					[2] = 1.86,
				},
				[80] = 
				{
					[1] = 0.86,
					[2] = 1.72,
				},
				[81] = 
				{
					[1] = 0.87,
					[2] = 1.59,
				},
				[82] = 
				{
					[1] = 0.88,
					[2] = 1.45,
				},
				[83] = 
				{
					[1] = 0.89,
					[2] = 1.35,
				},
				[84] = 
				{
					[1] = 0.9,
					[2] = 1.24,
				},
				[85] = 
				{
					[1] = 0.91,
					[2] = 1.13,
				},
				[86] = 
				{
					[1] = 0.92,
					[2] = 1.03,
				},
				[87] = 
				{
					[1] = 0.93,
					[2] = 0.93,
				},
				[88] = 
				{
					[1] = 0.95,
					[2] = 0.83,
				},
				[89] = 
				{
					[1] = 0.96,
					[2] = 0.73,
				},
				[90] = 
				{
					[1] = 0.97,
					[2] = 0.63,
				},
				[91] = 
				{
					[1] = 0.98,
					[2] = 0.53,
				},
				[92] = 
				{
					[1] = 0.99,
					[2] = 0.42,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 2.07,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.09,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[6] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[7] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[10] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[11] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[12] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[13] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[14] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[15] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[16] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[17] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[18] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[19] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[20] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[21] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[22] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[23] = 
				{
					[1] = 0.96,
					[2] = 0.04,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 10.83,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 1.17,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.4,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.59,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 1.77,
				},
				[6] = 
				{
					[1] = 0.04,
					[2] = 1.96,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 2.05,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 2.06,
				},
				[9] = 
				{
					[1] = 0.06,
					[2] = 2.08,
				},
				[10] = 
				{
					[1] = 0.07,
					[2] = 2.09,
				},
				[11] = 
				{
					[1] = 0.07,
					[2] = 2.1,
				},
				[12] = 
				{
					[1] = 0.08,
					[2] = 2.12,
				},
				[13] = 
				{
					[1] = 0.09,
					[2] = 2.13,
				},
				[14] = 
				{
					[1] = 0.09,
					[2] = 2.15,
				},
				[15] = 
				{
					[1] = 0.1,
					[2] = 2.16,
				},
				[16] = 
				{
					[1] = 0.11,
					[2] = 2.17,
				},
				[17] = 
				{
					[1] = 0.12,
					[2] = 2.19,
				},
				[18] = 
				{
					[1] = 0.12,
					[2] = 2.2,
				},
				[19] = 
				{
					[1] = 0.13,
					[2] = 2.21,
				},
				[20] = 
				{
					[1] = 0.14,
					[2] = 2.23,
				},
				[21] = 
				{
					[1] = 0.14,
					[2] = 2.24,
				},
				[22] = 
				{
					[1] = 0.15,
					[2] = 2.25,
				},
				[23] = 
				{
					[1] = 0.16,
					[2] = 2.26,
				},
				[24] = 
				{
					[1] = 0.17,
					[2] = 2.27,
				},
				[25] = 
				{
					[1] = 0.17,
					[2] = 2.27,
				},
				[26] = 
				{
					[1] = 0.18,
					[2] = 2.28,
				},
				[27] = 
				{
					[1] = 0.19,
					[2] = 2.28,
				},
				[28] = 
				{
					[1] = 0.2,
					[2] = 2.29,
				},
				[29] = 
				{
					[1] = 0.2,
					[2] = 2.29,
				},
				[30] = 
				{
					[1] = 0.21,
					[2] = 2.3,
				},
				[31] = 
				{
					[1] = 0.22,
					[2] = 2.3,
				},
				[32] = 
				{
					[1] = 0.22,
					[2] = 2.31,
				},
				[33] = 
				{
					[1] = 0.23,
					[2] = 2.31,
				},
				[34] = 
				{
					[1] = 0.24,
					[2] = 2.32,
				},
				[35] = 
				{
					[1] = 0.25,
					[2] = 2.32,
				},
				[36] = 
				{
					[1] = 0.25,
					[2] = 2.32,
				},
				[37] = 
				{
					[1] = 0.26,
					[2] = 2.33,
				},
				[38] = 
				{
					[1] = 0.27,
					[2] = 2.33,
				},
				[39] = 
				{
					[1] = 0.28,
					[2] = 2.34,
				},
				[40] = 
				{
					[1] = 0.28,
					[2] = 2.34,
				},
				[41] = 
				{
					[1] = 0.29,
					[2] = 2.34,
				},
				[42] = 
				{
					[1] = 0.3,
					[2] = 2.35,
				},
				[43] = 
				{
					[1] = 0.3,
					[2] = 2.35,
				},
				[44] = 
				{
					[1] = 0.31,
					[2] = 2.36,
				},
				[45] = 
				{
					[1] = 0.32,
					[2] = 2.37,
				},
				[46] = 
				{
					[1] = 0.33,
					[2] = 2.38,
				},
				[47] = 
				{
					[1] = 0.33,
					[2] = 2.38,
				},
				[48] = 
				{
					[1] = 0.34,
					[2] = 2.38,
				},
				[49] = 
				{
					[1] = 0.35,
					[2] = 2.38,
				},
				[50] = 
				{
					[1] = 0.36,
					[2] = 2.38,
				},
				[51] = 
				{
					[1] = 0.36,
					[2] = 2.38,
				},
				[52] = 
				{
					[1] = 0.37,
					[2] = 2.39,
				},
				[53] = 
				{
					[1] = 0.38,
					[2] = 2.4,
				},
				[54] = 
				{
					[1] = 0.38,
					[2] = 2.41,
				},
				[55] = 
				{
					[1] = 0.39,
					[2] = 2.42,
				},
				[56] = 
				{
					[1] = 0.4,
					[2] = 2.43,
				},
				[57] = 
				{
					[1] = 0.41,
					[2] = 2.43,
				},
				[58] = 
				{
					[1] = 0.41,
					[2] = 2.44,
				},
				[59] = 
				{
					[1] = 0.42,
					[2] = 2.45,
				},
				[60] = 
				{
					[1] = 0.43,
					[2] = 2.45,
				},
				[61] = 
				{
					[1] = 0.43,
					[2] = 2.46,
				},
				[62] = 
				{
					[1] = 0.44,
					[2] = 2.46,
				},
				[63] = 
				{
					[1] = 0.45,
					[2] = 2.47,
				},
				[64] = 
				{
					[1] = 0.46,
					[2] = 2.47,
				},
				[65] = 
				{
					[1] = 0.46,
					[2] = 2.47,
				},
				[66] = 
				{
					[1] = 0.47,
					[2] = 2.48,
				},
				[67] = 
				{
					[1] = 0.48,
					[2] = 2.48,
				},
				[68] = 
				{
					[1] = 0.49,
					[2] = 2.49,
				},
				[69] = 
				{
					[1] = 0.49,
					[2] = 2.49,
				},
				[70] = 
				{
					[1] = 0.5,
					[2] = 2.5,
				},
				[71] = 
				{
					[1] = 0.51,
					[2] = 2.5,
				},
				[72] = 
				{
					[1] = 0.51,
					[2] = 2.5,
				},
				[73] = 
				{
					[1] = 0.52,
					[2] = 2.51,
				},
				[74] = 
				{
					[1] = 0.53,
					[2] = 2.51,
				},
				[75] = 
				{
					[1] = 0.54,
					[2] = 2.51,
				},
				[76] = 
				{
					[1] = 0.54,
					[2] = 2.51,
				},
				[77] = 
				{
					[1] = 0.55,
					[2] = 2.52,
				},
				[78] = 
				{
					[1] = 0.56,
					[2] = 2.52,
				},
				[79] = 
				{
					[1] = 0.57,
					[2] = 2.52,
				},
				[80] = 
				{
					[1] = 0.57,
					[2] = 2.52,
				},
				[81] = 
				{
					[1] = 0.58,
					[2] = 2.53,
				},
				[82] = 
				{
					[1] = 0.59,
					[2] = 2.53,
				},
				[83] = 
				{
					[1] = 0.59,
					[2] = 2.53,
				},
				[84] = 
				{
					[1] = 0.6,
					[2] = 2.53,
				},
				[85] = 
				{
					[1] = 0.61,
					[2] = 2.53,
				},
				[86] = 
				{
					[1] = 0.62,
					[2] = 2.54,
				},
				[87] = 
				{
					[1] = 0.62,
					[2] = 2.54,
				},
				[88] = 
				{
					[1] = 0.63,
					[2] = 2.55,
				},
				[89] = 
				{
					[1] = 0.64,
					[2] = 2.55,
				},
				[90] = 
				{
					[1] = 0.64,
					[2] = 2.56,
				},
				[91] = 
				{
					[1] = 0.65,
					[2] = 2.56,
				},
				[92] = 
				{
					[1] = 0.66,
					[2] = 2.56,
				},
				[93] = 
				{
					[1] = 0.67,
					[2] = 2.56,
				},
				[94] = 
				{
					[1] = 0.67,
					[2] = 2.56,
				},
				[95] = 
				{
					[1] = 0.68,
					[2] = 2.55,
				},
				[96] = 
				{
					[1] = 0.69,
					[2] = 2.55,
				},
				[97] = 
				{
					[1] = 0.7,
					[2] = 2.54,
				},
				[98] = 
				{
					[1] = 0.7,
					[2] = 2.53,
				},
				[99] = 
				{
					[1] = 0.71,
					[2] = 2.53,
				},
				[100] = 
				{
					[1] = 0.72,
					[2] = 2.52,
				},
				[101] = 
				{
					[1] = 0.72,
					[2] = 2.52,
				},
				[102] = 
				{
					[1] = 0.73,
					[2] = 2.51,
				},
				[103] = 
				{
					[1] = 0.74,
					[2] = 2.5,
				},
				[104] = 
				{
					[1] = 0.75,
					[2] = 2.5,
				},
				[105] = 
				{
					[1] = 0.75,
					[2] = 2.49,
				},
				[106] = 
				{
					[1] = 0.76,
					[2] = 2.48,
				},
				[107] = 
				{
					[1] = 0.77,
					[2] = 2.48,
				},
				[108] = 
				{
					[1] = 0.78,
					[2] = 2.47,
				},
				[109] = 
				{
					[1] = 0.78,
					[2] = 2.46,
				},
				[110] = 
				{
					[1] = 0.79,
					[2] = 2.45,
				},
				[111] = 
				{
					[1] = 0.8,
					[2] = 2.45,
				},
				[112] = 
				{
					[1] = 0.8,
					[2] = 2.44,
				},
				[113] = 
				{
					[1] = 0.81,
					[2] = 2.43,
				},
				[114] = 
				{
					[1] = 0.82,
					[2] = 2.42,
				},
				[115] = 
				{
					[1] = 0.83,
					[2] = 2.41,
				},
				[116] = 
				{
					[1] = 0.83,
					[2] = 2.41,
				},
				[117] = 
				{
					[1] = 0.84,
					[2] = 2.4,
				},
				[118] = 
				{
					[1] = 0.85,
					[2] = 2.39,
				},
				[119] = 
				{
					[1] = 0.86,
					[2] = 2.38,
				},
				[120] = 
				{
					[1] = 0.86,
					[2] = 2.37,
				},
				[121] = 
				{
					[1] = 0.87,
					[2] = 2.37,
				},
				[122] = 
				{
					[1] = 0.88,
					[2] = 2.36,
				},
				[123] = 
				{
					[1] = 0.88,
					[2] = 2.35,
				},
				[124] = 
				{
					[1] = 0.89,
					[2] = 2.34,
				},
				[125] = 
				{
					[1] = 0.9,
					[2] = 2.34,
				},
				[126] = 
				{
					[1] = 0.91,
					[2] = 2.33,
				},
				[127] = 
				{
					[1] = 0.91,
					[2] = 2.32,
				},
				[128] = 
				{
					[1] = 0.92,
					[2] = 2.31,
				},
				[129] = 
				{
					[1] = 0.93,
					[2] = 2.3,
				},
				[130] = 
				{
					[1] = 0.93,
					[2] = 2.29,
				},
				[131] = 
				{
					[1] = 0.94,
					[2] = 2.29,
				},
				[132] = 
				{
					[1] = 0.95,
					[2] = 2.28,
				},
				[133] = 
				{
					[1] = 0.96,
					[2] = 2.27,
				},
				[134] = 
				{
					[1] = 0.96,
					[2] = 2.26,
				},
				[135] = 
				{
					[1] = 0.97,
					[2] = 2.25,
				},
				[136] = 
				{
					[1] = 0.98,
					[2] = 2.24,
				},
				[137] = 
				{
					[1] = 0.99,
					[2] = 2.23,
				},
				[138] = 
				{
					[1] = 0.99,
					[2] = 2.22,
				},
			},
			["WidthScale"] = 0.8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_gato",
		["Type"] = "WaterTracer",
	},
	[224] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 119.915962,
			["Lifetime"] = 7.77,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2086,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.6,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 156.801315,
			["Lifetime"] = 10.16,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2607,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.65,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 27.625427,
			["Lifetime"] = 1.79,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.2607,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.62,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_gato",
		["Type"] = "WaterTracer",
	},
	[225] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 173,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0289,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.37,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.7,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.04,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.37,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.71,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 2.05,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 2.39,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 2.73,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 2.97,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 3.18,
				},
				[12] = 
				{
					[1] = 0.06,
					[2] = 3.4,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 3.62,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 3.83,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 4.08,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 4.46,
				},
				[17] = 
				{
					[1] = 0.09,
					[2] = 4.84,
				},
				[18] = 
				{
					[1] = 0.1,
					[2] = 5.22,
				},
				[19] = 
				{
					[1] = 0.1,
					[2] = 5.6,
				},
				[20] = 
				{
					[1] = 0.11,
					[2] = 5.98,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 6.36,
				},
				[22] = 
				{
					[1] = 0.12,
					[2] = 6.74,
				},
				[23] = 
				{
					[1] = 0.13,
					[2] = 7.05,
				},
				[24] = 
				{
					[1] = 0.13,
					[2] = 7.35,
				},
				[25] = 
				{
					[1] = 0.14,
					[2] = 7.66,
				},
				[26] = 
				{
					[1] = 0.14,
					[2] = 7.97,
				},
				[27] = 
				{
					[1] = 0.15,
					[2] = 8.27,
				},
				[28] = 
				{
					[1] = 0.16,
					[2] = 8.58,
				},
				[29] = 
				{
					[1] = 0.16,
					[2] = 8.89,
				},
				[30] = 
				{
					[1] = 0.17,
					[2] = 9.19,
				},
				[31] = 
				{
					[1] = 0.17,
					[2] = 9.32,
				},
				[32] = 
				{
					[1] = 0.18,
					[2] = 9.43,
				},
				[33] = 
				{
					[1] = 0.18,
					[2] = 9.53,
				},
				[34] = 
				{
					[1] = 0.19,
					[2] = 9.63,
				},
				[35] = 
				{
					[1] = 0.2,
					[2] = 9.74,
				},
				[36] = 
				{
					[1] = 0.2,
					[2] = 9.84,
				},
				[37] = 
				{
					[1] = 0.21,
					[2] = 9.95,
				},
				[38] = 
				{
					[1] = 0.21,
					[2] = 10.05,
				},
				[39] = 
				{
					[1] = 0.22,
					[2] = 10.16,
				},
				[40] = 
				{
					[1] = 0.23,
					[2] = 10.25,
				},
				[41] = 
				{
					[1] = 0.23,
					[2] = 10.33,
				},
				[42] = 
				{
					[1] = 0.24,
					[2] = 10.41,
				},
				[43] = 
				{
					[1] = 0.24,
					[2] = 10.49,
				},
				[44] = 
				{
					[1] = 0.25,
					[2] = 10.57,
				},
				[45] = 
				{
					[1] = 0.25,
					[2] = 10.66,
				},
				[46] = 
				{
					[1] = 0.26,
					[2] = 10.74,
				},
				[47] = 
				{
					[1] = 0.27,
					[2] = 10.82,
				},
				[48] = 
				{
					[1] = 0.27,
					[2] = 10.9,
				},
				[49] = 
				{
					[1] = 0.28,
					[2] = 10.98,
				},
				[50] = 
				{
					[1] = 0.28,
					[2] = 11.06,
				},
				[51] = 
				{
					[1] = 0.29,
					[2] = 11.15,
				},
				[52] = 
				{
					[1] = 0.29,
					[2] = 11.23,
				},
				[53] = 
				{
					[1] = 0.3,
					[2] = 11.31,
				},
				[54] = 
				{
					[1] = 0.31,
					[2] = 11.32,
				},
				[55] = 
				{
					[1] = 0.31,
					[2] = 11.32,
				},
				[56] = 
				{
					[1] = 0.32,
					[2] = 11.32,
				},
				[57] = 
				{
					[1] = 0.32,
					[2] = 11.32,
				},
				[58] = 
				{
					[1] = 0.33,
					[2] = 11.32,
				},
				[59] = 
				{
					[1] = 0.34,
					[2] = 11.32,
				},
				[60] = 
				{
					[1] = 0.34,
					[2] = 11.32,
				},
				[61] = 
				{
					[1] = 0.35,
					[2] = 11.32,
				},
				[62] = 
				{
					[1] = 0.35,
					[2] = 11.32,
				},
				[63] = 
				{
					[1] = 0.36,
					[2] = 11.32,
				},
				[64] = 
				{
					[1] = 0.36,
					[2] = 11.32,
				},
				[65] = 
				{
					[1] = 0.37,
					[2] = 11.32,
				},
				[66] = 
				{
					[1] = 0.38,
					[2] = 11.32,
				},
				[67] = 
				{
					[1] = 0.38,
					[2] = 11.32,
				},
				[68] = 
				{
					[1] = 0.39,
					[2] = 11.32,
				},
				[69] = 
				{
					[1] = 0.39,
					[2] = 11.32,
				},
				[70] = 
				{
					[1] = 0.4,
					[2] = 11.32,
				},
				[71] = 
				{
					[1] = 0.4,
					[2] = 11.32,
				},
				[72] = 
				{
					[1] = 0.41,
					[2] = 11.32,
				},
				[73] = 
				{
					[1] = 0.42,
					[2] = 11.32,
				},
				[74] = 
				{
					[1] = 0.42,
					[2] = 11.32,
				},
				[75] = 
				{
					[1] = 0.43,
					[2] = 11.32,
				},
				[76] = 
				{
					[1] = 0.43,
					[2] = 11.32,
				},
				[77] = 
				{
					[1] = 0.44,
					[2] = 11.32,
				},
				[78] = 
				{
					[1] = 0.45,
					[2] = 11.32,
				},
				[79] = 
				{
					[1] = 0.45,
					[2] = 11.32,
				},
				[80] = 
				{
					[1] = 0.46,
					[2] = 11.32,
				},
				[81] = 
				{
					[1] = 0.46,
					[2] = 11.32,
				},
				[82] = 
				{
					[1] = 0.47,
					[2] = 11.32,
				},
				[83] = 
				{
					[1] = 0.47,
					[2] = 11.32,
				},
				[84] = 
				{
					[1] = 0.48,
					[2] = 11.32,
				},
				[85] = 
				{
					[1] = 0.49,
					[2] = 11.32,
				},
				[86] = 
				{
					[1] = 0.49,
					[2] = 11.32,
				},
				[87] = 
				{
					[1] = 0.5,
					[2] = 11.32,
				},
				[88] = 
				{
					[1] = 0.5,
					[2] = 11.32,
				},
				[89] = 
				{
					[1] = 0.51,
					[2] = 11.32,
				},
				[90] = 
				{
					[1] = 0.51,
					[2] = 11.32,
				},
				[91] = 
				{
					[1] = 0.52,
					[2] = 11.32,
				},
				[92] = 
				{
					[1] = 0.53,
					[2] = 11.32,
				},
				[93] = 
				{
					[1] = 0.53,
					[2] = 11.32,
				},
				[94] = 
				{
					[1] = 0.54,
					[2] = 11.32,
				},
				[95] = 
				{
					[1] = 0.54,
					[2] = 11.32,
				},
				[96] = 
				{
					[1] = 0.55,
					[2] = 11.32,
				},
				[97] = 
				{
					[1] = 0.55,
					[2] = 11.32,
				},
				[98] = 
				{
					[1] = 0.56,
					[2] = 11.32,
				},
				[99] = 
				{
					[1] = 0.57,
					[2] = 11.32,
				},
				[100] = 
				{
					[1] = 0.57,
					[2] = 11.32,
				},
				[101] = 
				{
					[1] = 0.58,
					[2] = 11.32,
				},
				[102] = 
				{
					[1] = 0.58,
					[2] = 11.32,
				},
				[103] = 
				{
					[1] = 0.59,
					[2] = 11.32,
				},
				[104] = 
				{
					[1] = 0.6,
					[2] = 11.32,
				},
				[105] = 
				{
					[1] = 0.6,
					[2] = 11.32,
				},
				[106] = 
				{
					[1] = 0.61,
					[2] = 11.32,
				},
				[107] = 
				{
					[1] = 0.61,
					[2] = 11.32,
				},
				[108] = 
				{
					[1] = 0.62,
					[2] = 11.32,
				},
				[109] = 
				{
					[1] = 0.62,
					[2] = 11.32,
				},
				[110] = 
				{
					[1] = 0.63,
					[2] = 11.32,
				},
				[111] = 
				{
					[1] = 0.64,
					[2] = 11.32,
				},
				[112] = 
				{
					[1] = 0.64,
					[2] = 11.32,
				},
				[113] = 
				{
					[1] = 0.65,
					[2] = 11.32,
				},
				[114] = 
				{
					[1] = 0.65,
					[2] = 11.32,
				},
				[115] = 
				{
					[1] = 0.66,
					[2] = 11.32,
				},
				[116] = 
				{
					[1] = 0.66,
					[2] = 11.32,
				},
				[117] = 
				{
					[1] = 0.67,
					[2] = 11.32,
				},
				[118] = 
				{
					[1] = 0.68,
					[2] = 11.32,
				},
				[119] = 
				{
					[1] = 0.68,
					[2] = 11.32,
				},
				[120] = 
				{
					[1] = 0.69,
					[2] = 11.32,
				},
				[121] = 
				{
					[1] = 0.69,
					[2] = 11.32,
				},
				[122] = 
				{
					[1] = 0.7,
					[2] = 11.32,
				},
				[123] = 
				{
					[1] = 0.71,
					[2] = 11.32,
				},
				[124] = 
				{
					[1] = 0.71,
					[2] = 11.32,
				},
				[125] = 
				{
					[1] = 0.72,
					[2] = 11.32,
				},
				[126] = 
				{
					[1] = 0.72,
					[2] = 11.32,
				},
				[127] = 
				{
					[1] = 0.73,
					[2] = 11.32,
				},
				[128] = 
				{
					[1] = 0.73,
					[2] = 11.29,
				},
				[129] = 
				{
					[1] = 0.74,
					[2] = 11.26,
				},
				[130] = 
				{
					[1] = 0.75,
					[2] = 11.23,
				},
				[131] = 
				{
					[1] = 0.75,
					[2] = 11.2,
				},
				[132] = 
				{
					[1] = 0.76,
					[2] = 11.17,
				},
				[133] = 
				{
					[1] = 0.76,
					[2] = 11.14,
				},
				[134] = 
				{
					[1] = 0.77,
					[2] = 11.11,
				},
				[135] = 
				{
					[1] = 0.77,
					[2] = 11.08,
				},
				[136] = 
				{
					[1] = 0.78,
					[2] = 11.05,
				},
				[137] = 
				{
					[1] = 0.79,
					[2] = 11.02,
				},
				[138] = 
				{
					[1] = 0.79,
					[2] = 10.99,
				},
				[139] = 
				{
					[1] = 0.8,
					[2] = 10.96,
				},
				[140] = 
				{
					[1] = 0.8,
					[2] = 10.93,
				},
				[141] = 
				{
					[1] = 0.81,
					[2] = 10.9,
				},
				[142] = 
				{
					[1] = 0.82,
					[2] = 10.88,
				},
				[143] = 
				{
					[1] = 0.82,
					[2] = 10.85,
				},
				[144] = 
				{
					[1] = 0.83,
					[2] = 10.83,
				},
				[145] = 
				{
					[1] = 0.83,
					[2] = 10.8,
				},
				[146] = 
				{
					[1] = 0.84,
					[2] = 10.77,
				},
				[147] = 
				{
					[1] = 0.84,
					[2] = 10.75,
				},
				[148] = 
				{
					[1] = 0.85,
					[2] = 10.72,
				},
				[149] = 
				{
					[1] = 0.86,
					[2] = 10.7,
				},
				[150] = 
				{
					[1] = 0.86,
					[2] = 10.67,
				},
				[151] = 
				{
					[1] = 0.87,
					[2] = 10.65,
				},
				[152] = 
				{
					[1] = 0.87,
					[2] = 10.62,
				},
				[153] = 
				{
					[1] = 0.88,
					[2] = 10.59,
				},
				[154] = 
				{
					[1] = 0.88,
					[2] = 10.51,
				},
				[155] = 
				{
					[1] = 0.89,
					[2] = 10.43,
				},
				[156] = 
				{
					[1] = 0.9,
					[2] = 10.34,
				},
				[157] = 
				{
					[1] = 0.9,
					[2] = 10.25,
				},
				[158] = 
				{
					[1] = 0.91,
					[2] = 10.16,
				},
				[159] = 
				{
					[1] = 0.91,
					[2] = 10.08,
				},
				[160] = 
				{
					[1] = 0.92,
					[2] = 9.99,
				},
				[161] = 
				{
					[1] = 0.92,
					[2] = 9.9,
				},
				[162] = 
				{
					[1] = 0.93,
					[2] = 9.81,
				},
				[163] = 
				{
					[1] = 0.94,
					[2] = 9.73,
				},
				[164] = 
				{
					[1] = 0.94,
					[2] = 9.64,
				},
				[165] = 
				{
					[1] = 0.95,
					[2] = 9.55,
				},
				[166] = 
				{
					[1] = 0.95,
					[2] = 9.46,
				},
				[167] = 
				{
					[1] = 0.96,
					[2] = 9.38,
				},
				[168] = 
				{
					[1] = 0.97,
					[2] = 9.29,
				},
				[169] = 
				{
					[1] = 0.97,
					[2] = 8.72,
				},
				[170] = 
				{
					[1] = 0.98,
					[2] = 8.05,
				},
				[171] = 
				{
					[1] = 0.98,
					[2] = 7.37,
				},
				[172] = 
				{
					[1] = 0.99,
					[2] = 6.32,
				},
				[173] = 
				{
					[1] = 0.99,
					[2] = 4.93,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.23,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.31,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[5] = 
				{
					[1] = 0.09,
					[2] = 0.41,
				},
				[6] = 
				{
					[1] = 0.12,
					[2] = 0.44,
				},
				[7] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[8] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[9] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[15] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[17] = 
				{
					[1] = 0.37,
					[2] = 0.47,
				},
				[18] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[19] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[20] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[21] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[22] = 
				{
					[1] = 0.49,
					[2] = 0.41,
				},
				[23] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[24] = 
				{
					[1] = 0.53,
					[2] = 0.37,
				},
				[25] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[26] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[27] = 
				{
					[1] = 0.6,
					[2] = 0.32,
				},
				[28] = 
				{
					[1] = 0.63,
					[2] = 0.3,
				},
				[29] = 
				{
					[1] = 0.65,
					[2] = 0.29,
				},
				[30] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[31] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[32] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[33] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[34] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[35] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[36] = 
				{
					[1] = 0.81,
					[2] = 0.15,
				},
				[37] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[38] = 
				{
					[1] = 0.86,
					[2] = 0.11,
				},
				[39] = 
				{
					[1] = 0.88,
					[2] = 0.09,
				},
				[40] = 
				{
					[1] = 0.91,
					[2] = 0.08,
				},
				[41] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[42] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[43] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.13,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.2,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.26,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.33,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.39,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.46,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.52,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.59,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.65,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 0.72,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 0.78,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 0.85,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 0.91,
				},
				[15] = 
				{
					[1] = 0.05,
					[2] = 0.97,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 1.04,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 1.1,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 1.16,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 1.22,
				},
				[20] = 
				{
					[1] = 0.07,
					[2] = 1.29,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 1.35,
				},
				[22] = 
				{
					[1] = 0.08,
					[2] = 1.41,
				},
				[23] = 
				{
					[1] = 0.08,
					[2] = 1.47,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 1.53,
				},
				[25] = 
				{
					[1] = 0.09,
					[2] = 1.59,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 1.65,
				},
				[27] = 
				{
					[1] = 0.1,
					[2] = 1.71,
				},
				[28] = 
				{
					[1] = 0.1,
					[2] = 1.77,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 1.83,
				},
				[30] = 
				{
					[1] = 0.11,
					[2] = 1.89,
				},
				[31] = 
				{
					[1] = 0.12,
					[2] = 1.95,
				},
				[32] = 
				{
					[1] = 0.12,
					[2] = 2.01,
				},
				[33] = 
				{
					[1] = 0.12,
					[2] = 2.07,
				},
				[34] = 
				{
					[1] = 0.13,
					[2] = 2.13,
				},
				[35] = 
				{
					[1] = 0.13,
					[2] = 2.19,
				},
				[36] = 
				{
					[1] = 0.14,
					[2] = 2.24,
				},
				[37] = 
				{
					[1] = 0.14,
					[2] = 2.3,
				},
				[38] = 
				{
					[1] = 0.14,
					[2] = 2.36,
				},
				[39] = 
				{
					[1] = 0.15,
					[2] = 2.42,
				},
				[40] = 
				{
					[1] = 0.15,
					[2] = 2.48,
				},
				[41] = 
				{
					[1] = 0.15,
					[2] = 2.53,
				},
				[42] = 
				{
					[1] = 0.16,
					[2] = 2.59,
				},
				[43] = 
				{
					[1] = 0.16,
					[2] = 2.65,
				},
				[44] = 
				{
					[1] = 0.17,
					[2] = 2.7,
				},
				[45] = 
				{
					[1] = 0.17,
					[2] = 2.76,
				},
				[46] = 
				{
					[1] = 0.17,
					[2] = 2.82,
				},
				[47] = 
				{
					[1] = 0.18,
					[2] = 2.87,
				},
				[48] = 
				{
					[1] = 0.18,
					[2] = 2.93,
				},
				[49] = 
				{
					[1] = 0.19,
					[2] = 2.98,
				},
				[50] = 
				{
					[1] = 0.19,
					[2] = 3.04,
				},
				[51] = 
				{
					[1] = 0.19,
					[2] = 3.09,
				},
				[52] = 
				{
					[1] = 0.2,
					[2] = 3.15,
				},
				[53] = 
				{
					[1] = 0.2,
					[2] = 3.2,
				},
				[54] = 
				{
					[1] = 0.2,
					[2] = 3.26,
				},
				[55] = 
				{
					[1] = 0.21,
					[2] = 3.31,
				},
				[56] = 
				{
					[1] = 0.21,
					[2] = 3.36,
				},
				[57] = 
				{
					[1] = 0.22,
					[2] = 3.42,
				},
				[58] = 
				{
					[1] = 0.22,
					[2] = 3.47,
				},
				[59] = 
				{
					[1] = 0.22,
					[2] = 3.52,
				},
				[60] = 
				{
					[1] = 0.23,
					[2] = 3.57,
				},
				[61] = 
				{
					[1] = 0.23,
					[2] = 3.63,
				},
				[62] = 
				{
					[1] = 0.24,
					[2] = 3.68,
				},
				[63] = 
				{
					[1] = 0.24,
					[2] = 3.73,
				},
				[64] = 
				{
					[1] = 0.24,
					[2] = 3.78,
				},
				[65] = 
				{
					[1] = 0.25,
					[2] = 3.83,
				},
				[66] = 
				{
					[1] = 0.25,
					[2] = 3.88,
				},
				[67] = 
				{
					[1] = 0.25,
					[2] = 3.93,
				},
				[68] = 
				{
					[1] = 0.26,
					[2] = 3.98,
				},
				[69] = 
				{
					[1] = 0.26,
					[2] = 4.03,
				},
				[70] = 
				{
					[1] = 0.27,
					[2] = 4.08,
				},
				[71] = 
				{
					[1] = 0.27,
					[2] = 4.13,
				},
				[72] = 
				{
					[1] = 0.27,
					[2] = 4.18,
				},
				[73] = 
				{
					[1] = 0.28,
					[2] = 4.23,
				},
				[74] = 
				{
					[1] = 0.28,
					[2] = 4.28,
				},
				[75] = 
				{
					[1] = 0.29,
					[2] = 4.33,
				},
				[76] = 
				{
					[1] = 0.29,
					[2] = 4.38,
				},
				[77] = 
				{
					[1] = 0.29,
					[2] = 4.43,
				},
				[78] = 
				{
					[1] = 0.3,
					[2] = 4.47,
				},
				[79] = 
				{
					[1] = 0.3,
					[2] = 4.52,
				},
				[80] = 
				{
					[1] = 0.31,
					[2] = 4.57,
				},
				[81] = 
				{
					[1] = 0.31,
					[2] = 4.61,
				},
				[82] = 
				{
					[1] = 0.31,
					[2] = 4.66,
				},
				[83] = 
				{
					[1] = 0.32,
					[2] = 4.7,
				},
				[84] = 
				{
					[1] = 0.32,
					[2] = 4.73,
				},
				[85] = 
				{
					[1] = 0.32,
					[2] = 4.75,
				},
				[86] = 
				{
					[1] = 0.33,
					[2] = 4.78,
				},
				[87] = 
				{
					[1] = 0.33,
					[2] = 4.8,
				},
				[88] = 
				{
					[1] = 0.34,
					[2] = 4.83,
				},
				[89] = 
				{
					[1] = 0.34,
					[2] = 4.85,
				},
				[90] = 
				{
					[1] = 0.34,
					[2] = 4.88,
				},
				[91] = 
				{
					[1] = 0.35,
					[2] = 4.9,
				},
				[92] = 
				{
					[1] = 0.35,
					[2] = 4.93,
				},
				[93] = 
				{
					[1] = 0.36,
					[2] = 4.95,
				},
				[94] = 
				{
					[1] = 0.36,
					[2] = 4.97,
				},
				[95] = 
				{
					[1] = 0.36,
					[2] = 5,
				},
				[96] = 
				{
					[1] = 0.37,
					[2] = 5.02,
				},
				[97] = 
				{
					[1] = 0.37,
					[2] = 5.05,
				},
				[98] = 
				{
					[1] = 0.37,
					[2] = 5.07,
				},
				[99] = 
				{
					[1] = 0.38,
					[2] = 5.09,
				},
				[100] = 
				{
					[1] = 0.38,
					[2] = 5.12,
				},
				[101] = 
				{
					[1] = 0.39,
					[2] = 5.14,
				},
				[102] = 
				{
					[1] = 0.39,
					[2] = 5.16,
				},
				[103] = 
				{
					[1] = 0.39,
					[2] = 5.18,
				},
				[104] = 
				{
					[1] = 0.4,
					[2] = 5.21,
				},
				[105] = 
				{
					[1] = 0.4,
					[2] = 5.23,
				},
				[106] = 
				{
					[1] = 0.41,
					[2] = 5.25,
				},
				[107] = 
				{
					[1] = 0.41,
					[2] = 5.27,
				},
				[108] = 
				{
					[1] = 0.41,
					[2] = 5.29,
				},
				[109] = 
				{
					[1] = 0.42,
					[2] = 5.31,
				},
				[110] = 
				{
					[1] = 0.42,
					[2] = 5.34,
				},
				[111] = 
				{
					[1] = 0.42,
					[2] = 5.36,
				},
				[112] = 
				{
					[1] = 0.43,
					[2] = 5.38,
				},
				[113] = 
				{
					[1] = 0.43,
					[2] = 5.4,
				},
				[114] = 
				{
					[1] = 0.44,
					[2] = 5.42,
				},
				[115] = 
				{
					[1] = 0.44,
					[2] = 5.44,
				},
				[116] = 
				{
					[1] = 0.44,
					[2] = 5.46,
				},
				[117] = 
				{
					[1] = 0.45,
					[2] = 5.48,
				},
				[118] = 
				{
					[1] = 0.45,
					[2] = 5.5,
				},
				[119] = 
				{
					[1] = 0.46,
					[2] = 5.52,
				},
				[120] = 
				{
					[1] = 0.46,
					[2] = 5.54,
				},
				[121] = 
				{
					[1] = 0.46,
					[2] = 5.56,
				},
				[122] = 
				{
					[1] = 0.47,
					[2] = 5.58,
				},
				[123] = 
				{
					[1] = 0.47,
					[2] = 5.6,
				},
				[124] = 
				{
					[1] = 0.47,
					[2] = 5.62,
				},
				[125] = 
				{
					[1] = 0.48,
					[2] = 5.64,
				},
				[126] = 
				{
					[1] = 0.48,
					[2] = 5.65,
				},
				[127] = 
				{
					[1] = 0.49,
					[2] = 5.67,
				},
				[128] = 
				{
					[1] = 0.49,
					[2] = 5.69,
				},
				[129] = 
				{
					[1] = 0.49,
					[2] = 5.71,
				},
				[130] = 
				{
					[1] = 0.5,
					[2] = 5.73,
				},
				[131] = 
				{
					[1] = 0.5,
					[2] = 5.74,
				},
				[132] = 
				{
					[1] = 0.51,
					[2] = 5.76,
				},
				[133] = 
				{
					[1] = 0.51,
					[2] = 5.78,
				},
				[134] = 
				{
					[1] = 0.51,
					[2] = 5.8,
				},
				[135] = 
				{
					[1] = 0.52,
					[2] = 5.81,
				},
				[136] = 
				{
					[1] = 0.52,
					[2] = 5.83,
				},
				[137] = 
				{
					[1] = 0.53,
					[2] = 5.85,
				},
				[138] = 
				{
					[1] = 0.53,
					[2] = 5.86,
				},
				[139] = 
				{
					[1] = 0.53,
					[2] = 5.88,
				},
				[140] = 
				{
					[1] = 0.54,
					[2] = 5.92,
				},
				[141] = 
				{
					[1] = 0.54,
					[2] = 5.96,
				},
				[142] = 
				{
					[1] = 0.54,
					[2] = 6,
				},
				[143] = 
				{
					[1] = 0.55,
					[2] = 6.04,
				},
				[144] = 
				{
					[1] = 0.55,
					[2] = 6.08,
				},
				[145] = 
				{
					[1] = 0.56,
					[2] = 6.11,
				},
				[146] = 
				{
					[1] = 0.56,
					[2] = 6.15,
				},
				[147] = 
				{
					[1] = 0.56,
					[2] = 6.19,
				},
				[148] = 
				{
					[1] = 0.57,
					[2] = 6.23,
				},
				[149] = 
				{
					[1] = 0.57,
					[2] = 6.26,
				},
				[150] = 
				{
					[1] = 0.58,
					[2] = 6.3,
				},
				[151] = 
				{
					[1] = 0.58,
					[2] = 6.34,
				},
				[152] = 
				{
					[1] = 0.58,
					[2] = 6.38,
				},
				[153] = 
				{
					[1] = 0.59,
					[2] = 6.41,
				},
				[154] = 
				{
					[1] = 0.59,
					[2] = 6.45,
				},
				[155] = 
				{
					[1] = 0.59,
					[2] = 6.48,
				},
				[156] = 
				{
					[1] = 0.6,
					[2] = 6.52,
				},
				[157] = 
				{
					[1] = 0.6,
					[2] = 6.55,
				},
				[158] = 
				{
					[1] = 0.61,
					[2] = 6.59,
				},
				[159] = 
				{
					[1] = 0.61,
					[2] = 6.62,
				},
				[160] = 
				{
					[1] = 0.61,
					[2] = 6.66,
				},
				[161] = 
				{
					[1] = 0.62,
					[2] = 6.69,
				},
				[162] = 
				{
					[1] = 0.62,
					[2] = 6.72,
				},
				[163] = 
				{
					[1] = 0.63,
					[2] = 6.76,
				},
				[164] = 
				{
					[1] = 0.63,
					[2] = 6.79,
				},
				[165] = 
				{
					[1] = 0.63,
					[2] = 6.82,
				},
				[166] = 
				{
					[1] = 0.64,
					[2] = 6.86,
				},
				[167] = 
				{
					[1] = 0.64,
					[2] = 6.89,
				},
				[168] = 
				{
					[1] = 0.64,
					[2] = 6.92,
				},
				[169] = 
				{
					[1] = 0.65,
					[2] = 6.95,
				},
				[170] = 
				{
					[1] = 0.65,
					[2] = 6.98,
				},
				[171] = 
				{
					[1] = 0.66,
					[2] = 7.01,
				},
				[172] = 
				{
					[1] = 0.66,
					[2] = 7.04,
				},
				[173] = 
				{
					[1] = 0.66,
					[2] = 7.07,
				},
				[174] = 
				{
					[1] = 0.67,
					[2] = 7.1,
				},
				[175] = 
				{
					[1] = 0.67,
					[2] = 7.13,
				},
				[176] = 
				{
					[1] = 0.68,
					[2] = 7.16,
				},
				[177] = 
				{
					[1] = 0.68,
					[2] = 7.19,
				},
				[178] = 
				{
					[1] = 0.68,
					[2] = 7.22,
				},
				[179] = 
				{
					[1] = 0.69,
					[2] = 7.25,
				},
				[180] = 
				{
					[1] = 0.69,
					[2] = 7.28,
				},
				[181] = 
				{
					[1] = 0.69,
					[2] = 7.31,
				},
				[182] = 
				{
					[1] = 0.7,
					[2] = 7.33,
				},
				[183] = 
				{
					[1] = 0.7,
					[2] = 7.36,
				},
				[184] = 
				{
					[1] = 0.71,
					[2] = 7.39,
				},
				[185] = 
				{
					[1] = 0.71,
					[2] = 7.41,
				},
				[186] = 
				{
					[1] = 0.71,
					[2] = 7.44,
				},
				[187] = 
				{
					[1] = 0.72,
					[2] = 7.47,
				},
				[188] = 
				{
					[1] = 0.72,
					[2] = 7.49,
				},
				[189] = 
				{
					[1] = 0.73,
					[2] = 7.52,
				},
				[190] = 
				{
					[1] = 0.73,
					[2] = 7.54,
				},
				[191] = 
				{
					[1] = 0.73,
					[2] = 7.57,
				},
				[192] = 
				{
					[1] = 0.74,
					[2] = 7.59,
				},
				[193] = 
				{
					[1] = 0.74,
					[2] = 7.62,
				},
				[194] = 
				{
					[1] = 0.75,
					[2] = 7.64,
				},
				[195] = 
				{
					[1] = 0.75,
					[2] = 7.67,
				},
				[196] = 
				{
					[1] = 0.75,
					[2] = 7.69,
				},
				[197] = 
				{
					[1] = 0.76,
					[2] = 7.71,
				},
				[198] = 
				{
					[1] = 0.76,
					[2] = 7.74,
				},
				[199] = 
				{
					[1] = 0.76,
					[2] = 7.76,
				},
				[200] = 
				{
					[1] = 0.77,
					[2] = 7.78,
				},
				[201] = 
				{
					[1] = 0.77,
					[2] = 7.8,
				},
				[202] = 
				{
					[1] = 0.78,
					[2] = 7.83,
				},
				[203] = 
				{
					[1] = 0.78,
					[2] = 7.85,
				},
				[204] = 
				{
					[1] = 0.78,
					[2] = 7.87,
				},
				[205] = 
				{
					[1] = 0.79,
					[2] = 7.89,
				},
				[206] = 
				{
					[1] = 0.79,
					[2] = 7.91,
				},
				[207] = 
				{
					[1] = 0.8,
					[2] = 7.93,
				},
				[208] = 
				{
					[1] = 0.8,
					[2] = 7.95,
				},
				[209] = 
				{
					[1] = 0.8,
					[2] = 7.97,
				},
				[210] = 
				{
					[1] = 0.81,
					[2] = 7.99,
				},
				[211] = 
				{
					[1] = 0.81,
					[2] = 8.01,
				},
				[212] = 
				{
					[1] = 0.81,
					[2] = 8.02,
				},
				[213] = 
				{
					[1] = 0.82,
					[2] = 8.03,
				},
				[214] = 
				{
					[1] = 0.82,
					[2] = 8.04,
				},
				[215] = 
				{
					[1] = 0.83,
					[2] = 8.05,
				},
				[216] = 
				{
					[1] = 0.83,
					[2] = 8.06,
				},
				[217] = 
				{
					[1] = 0.83,
					[2] = 8.07,
				},
				[218] = 
				{
					[1] = 0.84,
					[2] = 8.08,
				},
				[219] = 
				{
					[1] = 0.84,
					[2] = 8.09,
				},
				[220] = 
				{
					[1] = 0.85,
					[2] = 8.1,
				},
				[221] = 
				{
					[1] = 0.85,
					[2] = 8.11,
				},
				[222] = 
				{
					[1] = 0.85,
					[2] = 8.12,
				},
				[223] = 
				{
					[1] = 0.86,
					[2] = 8.12,
				},
				[224] = 
				{
					[1] = 0.86,
					[2] = 8.13,
				},
				[225] = 
				{
					[1] = 0.86,
					[2] = 8.14,
				},
				[226] = 
				{
					[1] = 0.87,
					[2] = 8.14,
				},
				[227] = 
				{
					[1] = 0.87,
					[2] = 8.15,
				},
				[228] = 
				{
					[1] = 0.88,
					[2] = 8.16,
				},
				[229] = 
				{
					[1] = 0.88,
					[2] = 8.16,
				},
				[230] = 
				{
					[1] = 0.88,
					[2] = 8.17,
				},
				[231] = 
				{
					[1] = 0.89,
					[2] = 8.18,
				},
				[232] = 
				{
					[1] = 0.89,
					[2] = 8.18,
				},
				[233] = 
				{
					[1] = 0.9,
					[2] = 8.19,
				},
				[234] = 
				{
					[1] = 0.9,
					[2] = 8.19,
				},
				[235] = 
				{
					[1] = 0.9,
					[2] = 8.2,
				},
				[236] = 
				{
					[1] = 0.91,
					[2] = 8.2,
				},
				[237] = 
				{
					[1] = 0.91,
					[2] = 8.21,
				},
				[238] = 
				{
					[1] = 0.92,
					[2] = 8.21,
				},
				[239] = 
				{
					[1] = 0.92,
					[2] = 8.21,
				},
				[240] = 
				{
					[1] = 0.92,
					[2] = 8.22,
				},
				[241] = 
				{
					[1] = 0.93,
					[2] = 8.22,
				},
				[242] = 
				{
					[1] = 0.93,
					[2] = 8.23,
				},
				[243] = 
				{
					[1] = 0.93,
					[2] = 8.23,
				},
				[244] = 
				{
					[1] = 0.94,
					[2] = 8.23,
				},
				[245] = 
				{
					[1] = 0.94,
					[2] = 8.23,
				},
				[246] = 
				{
					[1] = 0.95,
					[2] = 8.24,
				},
				[247] = 
				{
					[1] = 0.95,
					[2] = 8.24,
				},
				[248] = 
				{
					[1] = 0.95,
					[2] = 8.24,
				},
				[249] = 
				{
					[1] = 0.96,
					[2] = 8.24,
				},
				[250] = 
				{
					[1] = 0.96,
					[2] = 8.24,
				},
				[251] = 
				{
					[1] = 0.97,
					[2] = 8.24,
				},
				[252] = 
				{
					[1] = 0.97,
					[2] = 8.24,
				},
				[253] = 
				{
					[1] = 0.97,
					[2] = 8.25,
				},
				[254] = 
				{
					[1] = 0.98,
					[2] = 8.25,
				},
				[255] = 
				{
					[1] = 0.98,
					[2] = 8.25,
				},
				[256] = 
				{
					[1] = 0.98,
					[2] = 8.25,
				},
				[257] = 
				{
					[1] = 0.99,
					[2] = 8.25,
				},
				[258] = 
				{
					[1] = 0.99,
					[2] = 8.24,
				},
				[259] = 
				{
					[1] = 1,
					[2] = 8.24,
				},
			},
			["WidthScale"] = 0.7,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Hermes",
		["Type"] = "WaterTracer",
	},
	[226] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 217.813889,
			["Lifetime"] = 21.17,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.017,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 313.396851,
			["Lifetime"] = 30.459999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 2.89,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 71.610046,
			["Lifetime"] = 6.96,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Hermes",
		["Type"] = "WaterTracer",
	},
	[227] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 220.300003,
			["LocalSpace"] = true,
			["MaxSpeed"] = 14.40432,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0227,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.19,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.23,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.27,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.3,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.4,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 0.58,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.76,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 0.94,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 1.14,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 1.35,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 1.57,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 1.79,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 2,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 2.22,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 2.44,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 2.66,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 2.88,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 3.1,
				},
				[20] = 
				{
					[1] = 0.09,
					[2] = 3.35,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 3.64,
				},
				[22] = 
				{
					[1] = 0.1,
					[2] = 3.93,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 4.21,
				},
				[24] = 
				{
					[1] = 0.1,
					[2] = 4.5,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 4.78,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 5.07,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 5.35,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 5.63,
				},
				[29] = 
				{
					[1] = 0.13,
					[2] = 5.92,
				},
				[30] = 
				{
					[1] = 0.13,
					[2] = 6.2,
				},
				[31] = 
				{
					[1] = 0.14,
					[2] = 6.48,
				},
				[32] = 
				{
					[1] = 0.14,
					[2] = 6.69,
				},
				[33] = 
				{
					[1] = 0.15,
					[2] = 6.9,
				},
				[34] = 
				{
					[1] = 0.15,
					[2] = 7.11,
				},
				[35] = 
				{
					[1] = 0.15,
					[2] = 7.32,
				},
				[36] = 
				{
					[1] = 0.16,
					[2] = 7.52,
				},
				[37] = 
				{
					[1] = 0.16,
					[2] = 7.73,
				},
				[38] = 
				{
					[1] = 0.17,
					[2] = 7.94,
				},
				[39] = 
				{
					[1] = 0.17,
					[2] = 8.15,
				},
				[40] = 
				{
					[1] = 0.18,
					[2] = 8.36,
				},
				[41] = 
				{
					[1] = 0.18,
					[2] = 8.56,
				},
				[42] = 
				{
					[1] = 0.19,
					[2] = 8.76,
				},
				[43] = 
				{
					[1] = 0.19,
					[2] = 8.97,
				},
				[44] = 
				{
					[1] = 0.2,
					[2] = 9.17,
				},
				[45] = 
				{
					[1] = 0.2,
					[2] = 9.37,
				},
				[46] = 
				{
					[1] = 0.2,
					[2] = 9.58,
				},
				[47] = 
				{
					[1] = 0.21,
					[2] = 9.78,
				},
				[48] = 
				{
					[1] = 0.21,
					[2] = 9.98,
				},
				[49] = 
				{
					[1] = 0.22,
					[2] = 10.17,
				},
				[50] = 
				{
					[1] = 0.22,
					[2] = 10.34,
				},
				[51] = 
				{
					[1] = 0.23,
					[2] = 10.49,
				},
				[52] = 
				{
					[1] = 0.23,
					[2] = 10.65,
				},
				[53] = 
				{
					[1] = 0.24,
					[2] = 10.81,
				},
				[54] = 
				{
					[1] = 0.24,
					[2] = 10.97,
				},
				[55] = 
				{
					[1] = 0.25,
					[2] = 11.13,
				},
				[56] = 
				{
					[1] = 0.25,
					[2] = 11.29,
				},
				[57] = 
				{
					[1] = 0.25,
					[2] = 11.45,
				},
				[58] = 
				{
					[1] = 0.26,
					[2] = 11.61,
				},
				[59] = 
				{
					[1] = 0.26,
					[2] = 11.77,
				},
				[60] = 
				{
					[1] = 0.27,
					[2] = 11.93,
				},
				[61] = 
				{
					[1] = 0.27,
					[2] = 12.09,
				},
				[62] = 
				{
					[1] = 0.28,
					[2] = 12.25,
				},
				[63] = 
				{
					[1] = 0.28,
					[2] = 12.41,
				},
				[64] = 
				{
					[1] = 0.29,
					[2] = 12.57,
				},
				[65] = 
				{
					[1] = 0.29,
					[2] = 12.73,
				},
				[66] = 
				{
					[1] = 0.3,
					[2] = 12.88,
				},
				[67] = 
				{
					[1] = 0.3,
					[2] = 13.04,
				},
				[68] = 
				{
					[1] = 0.3,
					[2] = 13.2,
				},
				[69] = 
				{
					[1] = 0.31,
					[2] = 13.36,
				},
				[70] = 
				{
					[1] = 0.31,
					[2] = 13.52,
				},
				[71] = 
				{
					[1] = 0.32,
					[2] = 13.61,
				},
				[72] = 
				{
					[1] = 0.32,
					[2] = 13.69,
				},
				[73] = 
				{
					[1] = 0.33,
					[2] = 13.78,
				},
				[74] = 
				{
					[1] = 0.33,
					[2] = 13.86,
				},
				[75] = 
				{
					[1] = 0.34,
					[2] = 13.94,
				},
				[76] = 
				{
					[1] = 0.34,
					[2] = 14.02,
				},
				[77] = 
				{
					[1] = 0.35,
					[2] = 14.11,
				},
				[78] = 
				{
					[1] = 0.35,
					[2] = 14.19,
				},
				[79] = 
				{
					[1] = 0.35,
					[2] = 14.27,
				},
				[80] = 
				{
					[1] = 0.36,
					[2] = 14.35,
				},
				[81] = 
				{
					[1] = 0.36,
					[2] = 14.41,
				},
				[82] = 
				{
					[1] = 0.37,
					[2] = 14.45,
				},
				[83] = 
				{
					[1] = 0.37,
					[2] = 14.5,
				},
				[84] = 
				{
					[1] = 0.38,
					[2] = 14.54,
				},
				[85] = 
				{
					[1] = 0.38,
					[2] = 14.58,
				},
				[86] = 
				{
					[1] = 0.39,
					[2] = 14.62,
				},
				[87] = 
				{
					[1] = 0.39,
					[2] = 14.67,
				},
				[88] = 
				{
					[1] = 0.4,
					[2] = 14.71,
				},
				[89] = 
				{
					[1] = 0.4,
					[2] = 14.75,
				},
				[90] = 
				{
					[1] = 0.4,
					[2] = 14.79,
				},
				[91] = 
				{
					[1] = 0.41,
					[2] = 14.82,
				},
				[92] = 
				{
					[1] = 0.41,
					[2] = 14.85,
				},
				[93] = 
				{
					[1] = 0.42,
					[2] = 14.87,
				},
				[94] = 
				{
					[1] = 0.42,
					[2] = 14.9,
				},
				[95] = 
				{
					[1] = 0.43,
					[2] = 14.93,
				},
				[96] = 
				{
					[1] = 0.43,
					[2] = 14.95,
				},
				[97] = 
				{
					[1] = 0.44,
					[2] = 14.98,
				},
				[98] = 
				{
					[1] = 0.44,
					[2] = 15.01,
				},
				[99] = 
				{
					[1] = 0.45,
					[2] = 15.03,
				},
				[100] = 
				{
					[1] = 0.45,
					[2] = 15.03,
				},
				[101] = 
				{
					[1] = 0.45,
					[2] = 15.03,
				},
				[102] = 
				{
					[1] = 0.46,
					[2] = 15.03,
				},
				[103] = 
				{
					[1] = 0.46,
					[2] = 15.03,
				},
				[104] = 
				{
					[1] = 0.47,
					[2] = 15.03,
				},
				[105] = 
				{
					[1] = 0.47,
					[2] = 15.03,
				},
				[106] = 
				{
					[1] = 0.48,
					[2] = 15.03,
				},
				[107] = 
				{
					[1] = 0.48,
					[2] = 15.03,
				},
				[108] = 
				{
					[1] = 0.49,
					[2] = 15.03,
				},
				[109] = 
				{
					[1] = 0.49,
					[2] = 15.03,
				},
				[110] = 
				{
					[1] = 0.5,
					[2] = 15.03,
				},
				[111] = 
				{
					[1] = 0.5,
					[2] = 15.02,
				},
				[112] = 
				{
					[1] = 0.5,
					[2] = 15.01,
				},
				[113] = 
				{
					[1] = 0.51,
					[2] = 15.01,
				},
				[114] = 
				{
					[1] = 0.51,
					[2] = 15,
				},
				[115] = 
				{
					[1] = 0.52,
					[2] = 14.99,
				},
				[116] = 
				{
					[1] = 0.52,
					[2] = 14.99,
				},
				[117] = 
				{
					[1] = 0.53,
					[2] = 14.98,
				},
				[118] = 
				{
					[1] = 0.53,
					[2] = 14.97,
				},
				[119] = 
				{
					[1] = 0.54,
					[2] = 14.97,
				},
				[120] = 
				{
					[1] = 0.54,
					[2] = 14.95,
				},
				[121] = 
				{
					[1] = 0.55,
					[2] = 14.91,
				},
				[122] = 
				{
					[1] = 0.55,
					[2] = 14.86,
				},
				[123] = 
				{
					[1] = 0.55,
					[2] = 14.82,
				},
				[124] = 
				{
					[1] = 0.56,
					[2] = 14.78,
				},
				[125] = 
				{
					[1] = 0.56,
					[2] = 14.74,
				},
				[126] = 
				{
					[1] = 0.57,
					[2] = 14.69,
				},
				[127] = 
				{
					[1] = 0.57,
					[2] = 14.65,
				},
				[128] = 
				{
					[1] = 0.58,
					[2] = 14.61,
				},
				[129] = 
				{
					[1] = 0.58,
					[2] = 14.57,
				},
				[130] = 
				{
					[1] = 0.59,
					[2] = 14.52,
				},
				[131] = 
				{
					[1] = 0.59,
					[2] = 14.45,
				},
				[132] = 
				{
					[1] = 0.6,
					[2] = 14.38,
				},
				[133] = 
				{
					[1] = 0.6,
					[2] = 14.3,
				},
				[134] = 
				{
					[1] = 0.6,
					[2] = 14.22,
				},
				[135] = 
				{
					[1] = 0.61,
					[2] = 14.14,
				},
				[136] = 
				{
					[1] = 0.61,
					[2] = 14.06,
				},
				[137] = 
				{
					[1] = 0.62,
					[2] = 13.98,
				},
				[138] = 
				{
					[1] = 0.62,
					[2] = 13.91,
				},
				[139] = 
				{
					[1] = 0.63,
					[2] = 13.83,
				},
				[140] = 
				{
					[1] = 0.63,
					[2] = 13.75,
				},
				[141] = 
				{
					[1] = 0.64,
					[2] = 13.67,
				},
				[142] = 
				{
					[1] = 0.64,
					[2] = 13.59,
				},
				[143] = 
				{
					[1] = 0.65,
					[2] = 13.51,
				},
				[144] = 
				{
					[1] = 0.65,
					[2] = 13.43,
				},
				[145] = 
				{
					[1] = 0.65,
					[2] = 13.35,
				},
				[146] = 
				{
					[1] = 0.66,
					[2] = 13.28,
				},
				[147] = 
				{
					[1] = 0.66,
					[2] = 13.2,
				},
				[148] = 
				{
					[1] = 0.67,
					[2] = 13.12,
				},
				[149] = 
				{
					[1] = 0.67,
					[2] = 13.03,
				},
				[150] = 
				{
					[1] = 0.68,
					[2] = 12.91,
				},
				[151] = 
				{
					[1] = 0.68,
					[2] = 12.8,
				},
				[152] = 
				{
					[1] = 0.69,
					[2] = 12.68,
				},
				[153] = 
				{
					[1] = 0.69,
					[2] = 12.57,
				},
				[154] = 
				{
					[1] = 0.7,
					[2] = 12.45,
				},
				[155] = 
				{
					[1] = 0.7,
					[2] = 12.34,
				},
				[156] = 
				{
					[1] = 0.7,
					[2] = 12.23,
				},
				[157] = 
				{
					[1] = 0.71,
					[2] = 12.11,
				},
				[158] = 
				{
					[1] = 0.71,
					[2] = 12,
				},
				[159] = 
				{
					[1] = 0.72,
					[2] = 11.88,
				},
				[160] = 
				{
					[1] = 0.72,
					[2] = 11.77,
				},
				[161] = 
				{
					[1] = 0.73,
					[2] = 11.66,
				},
				[162] = 
				{
					[1] = 0.73,
					[2] = 11.54,
				},
				[163] = 
				{
					[1] = 0.74,
					[2] = 11.43,
				},
				[164] = 
				{
					[1] = 0.74,
					[2] = 11.31,
				},
				[165] = 
				{
					[1] = 0.75,
					[2] = 11.2,
				},
				[166] = 
				{
					[1] = 0.75,
					[2] = 11.08,
				},
				[167] = 
				{
					[1] = 0.75,
					[2] = 10.97,
				},
				[168] = 
				{
					[1] = 0.76,
					[2] = 10.85,
				},
				[169] = 
				{
					[1] = 0.76,
					[2] = 10.74,
				},
				[170] = 
				{
					[1] = 0.77,
					[2] = 10.61,
				},
				[171] = 
				{
					[1] = 0.77,
					[2] = 10.46,
				},
				[172] = 
				{
					[1] = 0.78,
					[2] = 10.33,
				},
				[173] = 
				{
					[1] = 0.78,
					[2] = 10.19,
				},
				[174] = 
				{
					[1] = 0.79,
					[2] = 10.06,
				},
				[175] = 
				{
					[1] = 0.79,
					[2] = 9.92,
				},
				[176] = 
				{
					[1] = 0.8,
					[2] = 9.78,
				},
				[177] = 
				{
					[1] = 0.8,
					[2] = 9.65,
				},
				[178] = 
				{
					[1] = 0.8,
					[2] = 9.51,
				},
				[179] = 
				{
					[1] = 0.81,
					[2] = 9.37,
				},
				[180] = 
				{
					[1] = 0.81,
					[2] = 9.22,
				},
				[181] = 
				{
					[1] = 0.82,
					[2] = 8.98,
				},
				[182] = 
				{
					[1] = 0.82,
					[2] = 8.73,
				},
				[183] = 
				{
					[1] = 0.83,
					[2] = 8.49,
				},
				[184] = 
				{
					[1] = 0.83,
					[2] = 8.24,
				},
				[185] = 
				{
					[1] = 0.84,
					[2] = 8,
				},
				[186] = 
				{
					[1] = 0.84,
					[2] = 7.75,
				},
				[187] = 
				{
					[1] = 0.85,
					[2] = 7.51,
				},
				[188] = 
				{
					[1] = 0.85,
					[2] = 7.26,
				},
				[189] = 
				{
					[1] = 0.85,
					[2] = 7.02,
				},
				[190] = 
				{
					[1] = 0.86,
					[2] = 6.78,
				},
				[191] = 
				{
					[1] = 0.86,
					[2] = 6.59,
				},
				[192] = 
				{
					[1] = 0.87,
					[2] = 6.42,
				},
				[193] = 
				{
					[1] = 0.87,
					[2] = 6.24,
				},
				[194] = 
				{
					[1] = 0.88,
					[2] = 6.07,
				},
				[195] = 
				{
					[1] = 0.88,
					[2] = 5.84,
				},
				[196] = 
				{
					[1] = 0.89,
					[2] = 5.62,
				},
				[197] = 
				{
					[1] = 0.89,
					[2] = 5.39,
				},
				[198] = 
				{
					[1] = 0.9,
					[2] = 5.17,
				},
				[199] = 
				{
					[1] = 0.9,
					[2] = 4.97,
				},
				[200] = 
				{
					[1] = 0.9,
					[2] = 4.78,
				},
				[201] = 
				{
					[1] = 0.91,
					[2] = 4.58,
				},
				[202] = 
				{
					[1] = 0.91,
					[2] = 4.37,
				},
				[203] = 
				{
					[1] = 0.92,
					[2] = 4.15,
				},
				[204] = 
				{
					[1] = 0.92,
					[2] = 3.94,
				},
				[205] = 
				{
					[1] = 0.93,
					[2] = 3.72,
				},
				[206] = 
				{
					[1] = 0.93,
					[2] = 3.51,
				},
				[207] = 
				{
					[1] = 0.94,
					[2] = 3.3,
				},
				[208] = 
				{
					[1] = 0.94,
					[2] = 3.08,
				},
				[209] = 
				{
					[1] = 0.95,
					[2] = 2.87,
				},
				[210] = 
				{
					[1] = 0.95,
					[2] = 2.63,
				},
				[211] = 
				{
					[1] = 0.95,
					[2] = 2.43,
				},
				[212] = 
				{
					[1] = 0.96,
					[2] = 2.22,
				},
				[213] = 
				{
					[1] = 0.96,
					[2] = 2.01,
				},
				[214] = 
				{
					[1] = 0.97,
					[2] = 1.81,
				},
				[215] = 
				{
					[1] = 0.97,
					[2] = 1.6,
				},
				[216] = 
				{
					[1] = 0.98,
					[2] = 1.39,
				},
				[217] = 
				{
					[1] = 0.98,
					[2] = 1.18,
				},
				[218] = 
				{
					[1] = 0.99,
					[2] = 0.98,
				},
				[219] = 
				{
					[1] = 0.99,
					[2] = 0.78,
				},
				[220] = 
				{
					[1] = 1,
					[2] = 0.57,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.21,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.28,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[6] = 
				{
					[1] = 0.09,
					[2] = 0.41,
				},
				[7] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[8] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[10] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[12] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[18] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[19] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[20] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[21] = 
				{
					[1] = 0.36,
					[2] = 0.47,
				},
				[22] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[23] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[24] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[25] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[26] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[27] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[28] = 
				{
					[1] = 0.49,
					[2] = 0.4,
				},
				[29] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[30] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[31] = 
				{
					[1] = 0.55,
					[2] = 0.37,
				},
				[32] = 
				{
					[1] = 0.56,
					[2] = 0.35,
				},
				[33] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[34] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[35] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[36] = 
				{
					[1] = 0.64,
					[2] = 0.3,
				},
				[37] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[38] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[39] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[40] = 
				{
					[1] = 0.71,
					[2] = 0.24,
				},
				[41] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[42] = 
				{
					[1] = 0.75,
					[2] = 0.21,
				},
				[43] = 
				{
					[1] = 0.76,
					[2] = 0.19,
				},
				[44] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[45] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[46] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[47] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[48] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[49] = 
				{
					[1] = 0.87,
					[2] = 0.1,
				},
				[50] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[51] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[52] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[53] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[54] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
				[55] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12.05,
			["LocalSpace"] = true,
			["MaxSpeed"] = 14.40432,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.27,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.32,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.32,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.33,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.34,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.35,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 0.35,
				},
				[9] = 
				{
					[1] = 0.02,
					[2] = 0.36,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.37,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 0.37,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 0.38,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 0.39,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 0.39,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 0.4,
				},
				[16] = 
				{
					[1] = 0.05,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.05,
					[2] = 0.41,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 0.42,
				},
				[19] = 
				{
					[1] = 0.05,
					[2] = 0.43,
				},
				[20] = 
				{
					[1] = 0.06,
					[2] = 0.44,
				},
				[21] = 
				{
					[1] = 0.06,
					[2] = 0.44,
				},
				[22] = 
				{
					[1] = 0.06,
					[2] = 0.45,
				},
				[23] = 
				{
					[1] = 0.07,
					[2] = 0.46,
				},
				[24] = 
				{
					[1] = 0.07,
					[2] = 0.46,
				},
				[25] = 
				{
					[1] = 0.07,
					[2] = 0.47,
				},
				[26] = 
				{
					[1] = 0.08,
					[2] = 0.48,
				},
				[27] = 
				{
					[1] = 0.08,
					[2] = 0.48,
				},
				[28] = 
				{
					[1] = 0.08,
					[2] = 0.49,
				},
				[29] = 
				{
					[1] = 0.08,
					[2] = 0.49,
				},
				[30] = 
				{
					[1] = 0.09,
					[2] = 0.5,
				},
				[31] = 
				{
					[1] = 0.09,
					[2] = 0.51,
				},
				[32] = 
				{
					[1] = 0.09,
					[2] = 0.51,
				},
				[33] = 
				{
					[1] = 0.1,
					[2] = 0.52,
				},
				[34] = 
				{
					[1] = 0.1,
					[2] = 0.53,
				},
				[35] = 
				{
					[1] = 0.1,
					[2] = 0.53,
				},
				[36] = 
				{
					[1] = 0.11,
					[2] = 0.54,
				},
				[37] = 
				{
					[1] = 0.11,
					[2] = 0.55,
				},
				[38] = 
				{
					[1] = 0.11,
					[2] = 0.55,
				},
				[39] = 
				{
					[1] = 0.12,
					[2] = 0.56,
				},
				[40] = 
				{
					[1] = 0.12,
					[2] = 0.56,
				},
				[41] = 
				{
					[1] = 0.12,
					[2] = 0.57,
				},
				[42] = 
				{
					[1] = 0.12,
					[2] = 0.58,
				},
				[43] = 
				{
					[1] = 0.13,
					[2] = 0.58,
				},
				[44] = 
				{
					[1] = 0.13,
					[2] = 0.59,
				},
				[45] = 
				{
					[1] = 0.13,
					[2] = 0.59,
				},
				[46] = 
				{
					[1] = 0.14,
					[2] = 0.6,
				},
				[47] = 
				{
					[1] = 0.14,
					[2] = 0.62,
				},
				[48] = 
				{
					[1] = 0.14,
					[2] = 0.65,
				},
				[49] = 
				{
					[1] = 0.15,
					[2] = 0.68,
				},
				[50] = 
				{
					[1] = 0.15,
					[2] = 0.71,
				},
				[51] = 
				{
					[1] = 0.15,
					[2] = 0.74,
				},
				[52] = 
				{
					[1] = 0.15,
					[2] = 0.77,
				},
				[53] = 
				{
					[1] = 0.16,
					[2] = 0.8,
				},
				[54] = 
				{
					[1] = 0.16,
					[2] = 0.83,
				},
				[55] = 
				{
					[1] = 0.16,
					[2] = 0.86,
				},
				[56] = 
				{
					[1] = 0.17,
					[2] = 0.89,
				},
				[57] = 
				{
					[1] = 0.17,
					[2] = 0.92,
				},
				[58] = 
				{
					[1] = 0.17,
					[2] = 0.96,
				},
				[59] = 
				{
					[1] = 0.18,
					[2] = 0.99,
				},
				[60] = 
				{
					[1] = 0.18,
					[2] = 1.02,
				},
				[61] = 
				{
					[1] = 0.18,
					[2] = 1.05,
				},
				[62] = 
				{
					[1] = 0.18,
					[2] = 1.08,
				},
				[63] = 
				{
					[1] = 0.19,
					[2] = 1.11,
				},
				[64] = 
				{
					[1] = 0.19,
					[2] = 1.14,
				},
				[65] = 
				{
					[1] = 0.19,
					[2] = 1.17,
				},
				[66] = 
				{
					[1] = 0.2,
					[2] = 1.2,
				},
				[67] = 
				{
					[1] = 0.2,
					[2] = 1.23,
				},
				[68] = 
				{
					[1] = 0.2,
					[2] = 1.26,
				},
				[69] = 
				{
					[1] = 0.21,
					[2] = 1.29,
				},
				[70] = 
				{
					[1] = 0.21,
					[2] = 1.32,
				},
				[71] = 
				{
					[1] = 0.21,
					[2] = 1.35,
				},
				[72] = 
				{
					[1] = 0.22,
					[2] = 1.38,
				},
				[73] = 
				{
					[1] = 0.22,
					[2] = 1.41,
				},
				[74] = 
				{
					[1] = 0.22,
					[2] = 1.44,
				},
				[75] = 
				{
					[1] = 0.22,
					[2] = 1.47,
				},
				[76] = 
				{
					[1] = 0.23,
					[2] = 1.5,
				},
				[77] = 
				{
					[1] = 0.23,
					[2] = 1.53,
				},
				[78] = 
				{
					[1] = 0.23,
					[2] = 1.56,
				},
				[79] = 
				{
					[1] = 0.24,
					[2] = 1.59,
				},
				[80] = 
				{
					[1] = 0.24,
					[2] = 1.62,
				},
				[81] = 
				{
					[1] = 0.24,
					[2] = 1.65,
				},
				[82] = 
				{
					[1] = 0.25,
					[2] = 1.68,
				},
				[83] = 
				{
					[1] = 0.25,
					[2] = 1.7,
				},
				[84] = 
				{
					[1] = 0.25,
					[2] = 1.73,
				},
				[85] = 
				{
					[1] = 0.25,
					[2] = 1.76,
				},
				[86] = 
				{
					[1] = 0.26,
					[2] = 1.8,
				},
				[87] = 
				{
					[1] = 0.26,
					[2] = 1.83,
				},
				[88] = 
				{
					[1] = 0.26,
					[2] = 1.86,
				},
				[89] = 
				{
					[1] = 0.27,
					[2] = 1.89,
				},
				[90] = 
				{
					[1] = 0.27,
					[2] = 1.93,
				},
				[91] = 
				{
					[1] = 0.27,
					[2] = 1.96,
				},
				[92] = 
				{
					[1] = 0.28,
					[2] = 2,
				},
				[93] = 
				{
					[1] = 0.28,
					[2] = 2.03,
				},
				[94] = 
				{
					[1] = 0.28,
					[2] = 2.06,
				},
				[95] = 
				{
					[1] = 0.28,
					[2] = 2.1,
				},
				[96] = 
				{
					[1] = 0.29,
					[2] = 2.13,
				},
				[97] = 
				{
					[1] = 0.29,
					[2] = 2.16,
				},
				[98] = 
				{
					[1] = 0.29,
					[2] = 2.2,
				},
				[99] = 
				{
					[1] = 0.3,
					[2] = 2.23,
				},
				[100] = 
				{
					[1] = 0.3,
					[2] = 2.26,
				},
				[101] = 
				{
					[1] = 0.3,
					[2] = 2.3,
				},
				[102] = 
				{
					[1] = 0.31,
					[2] = 2.33,
				},
				[103] = 
				{
					[1] = 0.31,
					[2] = 2.36,
				},
				[104] = 
				{
					[1] = 0.31,
					[2] = 2.39,
				},
				[105] = 
				{
					[1] = 0.32,
					[2] = 2.43,
				},
				[106] = 
				{
					[1] = 0.32,
					[2] = 2.46,
				},
				[107] = 
				{
					[1] = 0.32,
					[2] = 2.49,
				},
				[108] = 
				{
					[1] = 0.32,
					[2] = 2.52,
				},
				[109] = 
				{
					[1] = 0.33,
					[2] = 2.55,
				},
				[110] = 
				{
					[1] = 0.33,
					[2] = 2.59,
				},
				[111] = 
				{
					[1] = 0.33,
					[2] = 2.62,
				},
				[112] = 
				{
					[1] = 0.34,
					[2] = 2.65,
				},
				[113] = 
				{
					[1] = 0.34,
					[2] = 2.68,
				},
				[114] = 
				{
					[1] = 0.34,
					[2] = 2.71,
				},
				[115] = 
				{
					[1] = 0.35,
					[2] = 2.74,
				},
				[116] = 
				{
					[1] = 0.35,
					[2] = 2.77,
				},
				[117] = 
				{
					[1] = 0.35,
					[2] = 2.8,
				},
				[118] = 
				{
					[1] = 0.35,
					[2] = 2.83,
				},
				[119] = 
				{
					[1] = 0.36,
					[2] = 2.86,
				},
				[120] = 
				{
					[1] = 0.36,
					[2] = 2.89,
				},
				[121] = 
				{
					[1] = 0.36,
					[2] = 2.92,
				},
				[122] = 
				{
					[1] = 0.37,
					[2] = 2.95,
				},
				[123] = 
				{
					[1] = 0.37,
					[2] = 2.98,
				},
				[124] = 
				{
					[1] = 0.37,
					[2] = 3.01,
				},
				[125] = 
				{
					[1] = 0.38,
					[2] = 3.04,
				},
				[126] = 
				{
					[1] = 0.38,
					[2] = 3.07,
				},
				[127] = 
				{
					[1] = 0.38,
					[2] = 3.1,
				},
				[128] = 
				{
					[1] = 0.38,
					[2] = 3.13,
				},
				[129] = 
				{
					[1] = 0.39,
					[2] = 3.16,
				},
				[130] = 
				{
					[1] = 0.39,
					[2] = 3.19,
				},
				[131] = 
				{
					[1] = 0.39,
					[2] = 3.22,
				},
				[132] = 
				{
					[1] = 0.4,
					[2] = 3.25,
				},
				[133] = 
				{
					[1] = 0.4,
					[2] = 3.28,
				},
				[134] = 
				{
					[1] = 0.4,
					[2] = 3.31,
				},
				[135] = 
				{
					[1] = 0.41,
					[2] = 3.33,
				},
				[136] = 
				{
					[1] = 0.41,
					[2] = 3.36,
				},
				[137] = 
				{
					[1] = 0.41,
					[2] = 3.39,
				},
				[138] = 
				{
					[1] = 0.42,
					[2] = 3.41,
				},
				[139] = 
				{
					[1] = 0.42,
					[2] = 3.44,
				},
				[140] = 
				{
					[1] = 0.42,
					[2] = 3.47,
				},
				[141] = 
				{
					[1] = 0.42,
					[2] = 3.5,
				},
				[142] = 
				{
					[1] = 0.43,
					[2] = 3.52,
				},
				[143] = 
				{
					[1] = 0.43,
					[2] = 3.55,
				},
				[144] = 
				{
					[1] = 0.43,
					[2] = 3.58,
				},
				[145] = 
				{
					[1] = 0.44,
					[2] = 3.61,
				},
				[146] = 
				{
					[1] = 0.44,
					[2] = 3.63,
				},
				[147] = 
				{
					[1] = 0.44,
					[2] = 3.66,
				},
				[148] = 
				{
					[1] = 0.45,
					[2] = 3.69,
				},
				[149] = 
				{
					[1] = 0.45,
					[2] = 3.72,
				},
				[150] = 
				{
					[1] = 0.45,
					[2] = 3.74,
				},
				[151] = 
				{
					[1] = 0.45,
					[2] = 3.77,
				},
				[152] = 
				{
					[1] = 0.46,
					[2] = 3.8,
				},
				[153] = 
				{
					[1] = 0.46,
					[2] = 3.82,
				},
				[154] = 
				{
					[1] = 0.46,
					[2] = 3.85,
				},
				[155] = 
				{
					[1] = 0.47,
					[2] = 3.88,
				},
				[156] = 
				{
					[1] = 0.47,
					[2] = 3.9,
				},
				[157] = 
				{
					[1] = 0.47,
					[2] = 3.93,
				},
				[158] = 
				{
					[1] = 0.48,
					[2] = 3.96,
				},
				[159] = 
				{
					[1] = 0.48,
					[2] = 3.98,
				},
				[160] = 
				{
					[1] = 0.48,
					[2] = 4.01,
				},
				[161] = 
				{
					[1] = 0.48,
					[2] = 4.03,
				},
				[162] = 
				{
					[1] = 0.49,
					[2] = 4.06,
				},
				[163] = 
				{
					[1] = 0.49,
					[2] = 4.08,
				},
				[164] = 
				{
					[1] = 0.49,
					[2] = 4.11,
				},
				[165] = 
				{
					[1] = 0.5,
					[2] = 4.13,
				},
				[166] = 
				{
					[1] = 0.5,
					[2] = 4.16,
				},
				[167] = 
				{
					[1] = 0.5,
					[2] = 4.18,
				},
				[168] = 
				{
					[1] = 0.51,
					[2] = 4.21,
				},
				[169] = 
				{
					[1] = 0.51,
					[2] = 4.23,
				},
				[170] = 
				{
					[1] = 0.51,
					[2] = 4.26,
				},
				[171] = 
				{
					[1] = 0.52,
					[2] = 4.28,
				},
				[172] = 
				{
					[1] = 0.52,
					[2] = 4.3,
				},
				[173] = 
				{
					[1] = 0.52,
					[2] = 4.33,
				},
				[174] = 
				{
					[1] = 0.52,
					[2] = 4.35,
				},
				[175] = 
				{
					[1] = 0.53,
					[2] = 4.38,
				},
				[176] = 
				{
					[1] = 0.53,
					[2] = 4.4,
				},
				[177] = 
				{
					[1] = 0.53,
					[2] = 4.42,
				},
				[178] = 
				{
					[1] = 0.54,
					[2] = 4.45,
				},
				[179] = 
				{
					[1] = 0.54,
					[2] = 4.47,
				},
				[180] = 
				{
					[1] = 0.54,
					[2] = 4.49,
				},
				[181] = 
				{
					[1] = 0.55,
					[2] = 4.52,
				},
				[182] = 
				{
					[1] = 0.55,
					[2] = 4.54,
				},
				[183] = 
				{
					[1] = 0.55,
					[2] = 4.56,
				},
				[184] = 
				{
					[1] = 0.55,
					[2] = 4.58,
				},
				[185] = 
				{
					[1] = 0.56,
					[2] = 4.61,
				},
				[186] = 
				{
					[1] = 0.56,
					[2] = 4.63,
				},
				[187] = 
				{
					[1] = 0.56,
					[2] = 4.65,
				},
				[188] = 
				{
					[1] = 0.57,
					[2] = 4.67,
				},
				[189] = 
				{
					[1] = 0.57,
					[2] = 4.71,
				},
				[190] = 
				{
					[1] = 0.57,
					[2] = 4.74,
				},
				[191] = 
				{
					[1] = 0.58,
					[2] = 4.77,
				},
				[192] = 
				{
					[1] = 0.58,
					[2] = 4.81,
				},
				[193] = 
				{
					[1] = 0.58,
					[2] = 4.84,
				},
				[194] = 
				{
					[1] = 0.58,
					[2] = 4.87,
				},
				[195] = 
				{
					[1] = 0.59,
					[2] = 4.9,
				},
				[196] = 
				{
					[1] = 0.59,
					[2] = 4.93,
				},
				[197] = 
				{
					[1] = 0.59,
					[2] = 4.96,
				},
				[198] = 
				{
					[1] = 0.6,
					[2] = 4.99,
				},
				[199] = 
				{
					[1] = 0.6,
					[2] = 5.02,
				},
				[200] = 
				{
					[1] = 0.6,
					[2] = 5.05,
				},
				[201] = 
				{
					[1] = 0.61,
					[2] = 5.08,
				},
				[202] = 
				{
					[1] = 0.61,
					[2] = 5.1,
				},
				[203] = 
				{
					[1] = 0.61,
					[2] = 5.13,
				},
				[204] = 
				{
					[1] = 0.62,
					[2] = 5.16,
				},
				[205] = 
				{
					[1] = 0.62,
					[2] = 5.19,
				},
				[206] = 
				{
					[1] = 0.62,
					[2] = 5.22,
				},
				[207] = 
				{
					[1] = 0.62,
					[2] = 5.24,
				},
				[208] = 
				{
					[1] = 0.63,
					[2] = 5.27,
				},
				[209] = 
				{
					[1] = 0.63,
					[2] = 5.3,
				},
				[210] = 
				{
					[1] = 0.63,
					[2] = 5.33,
				},
				[211] = 
				{
					[1] = 0.64,
					[2] = 5.35,
				},
				[212] = 
				{
					[1] = 0.64,
					[2] = 5.38,
				},
				[213] = 
				{
					[1] = 0.64,
					[2] = 5.41,
				},
				[214] = 
				{
					[1] = 0.65,
					[2] = 5.43,
				},
				[215] = 
				{
					[1] = 0.65,
					[2] = 5.46,
				},
				[216] = 
				{
					[1] = 0.65,
					[2] = 5.49,
				},
				[217] = 
				{
					[1] = 0.65,
					[2] = 5.51,
				},
				[218] = 
				{
					[1] = 0.66,
					[2] = 5.54,
				},
				[219] = 
				{
					[1] = 0.66,
					[2] = 5.56,
				},
				[220] = 
				{
					[1] = 0.66,
					[2] = 5.59,
				},
				[221] = 
				{
					[1] = 0.67,
					[2] = 5.61,
				},
				[222] = 
				{
					[1] = 0.67,
					[2] = 5.64,
				},
				[223] = 
				{
					[1] = 0.67,
					[2] = 5.66,
				},
				[224] = 
				{
					[1] = 0.68,
					[2] = 5.69,
				},
				[225] = 
				{
					[1] = 0.68,
					[2] = 5.71,
				},
				[226] = 
				{
					[1] = 0.68,
					[2] = 5.74,
				},
				[227] = 
				{
					[1] = 0.68,
					[2] = 5.76,
				},
				[228] = 
				{
					[1] = 0.69,
					[2] = 5.79,
				},
				[229] = 
				{
					[1] = 0.69,
					[2] = 5.81,
				},
				[230] = 
				{
					[1] = 0.69,
					[2] = 5.83,
				},
				[231] = 
				{
					[1] = 0.7,
					[2] = 5.86,
				},
				[232] = 
				{
					[1] = 0.7,
					[2] = 5.88,
				},
				[233] = 
				{
					[1] = 0.7,
					[2] = 5.9,
				},
				[234] = 
				{
					[1] = 0.71,
					[2] = 5.93,
				},
				[235] = 
				{
					[1] = 0.71,
					[2] = 5.95,
				},
				[236] = 
				{
					[1] = 0.71,
					[2] = 5.97,
				},
				[237] = 
				{
					[1] = 0.72,
					[2] = 6,
				},
				[238] = 
				{
					[1] = 0.72,
					[2] = 6.02,
				},
				[239] = 
				{
					[1] = 0.72,
					[2] = 6.04,
				},
				[240] = 
				{
					[1] = 0.72,
					[2] = 6.06,
				},
				[241] = 
				{
					[1] = 0.73,
					[2] = 6.08,
				},
				[242] = 
				{
					[1] = 0.73,
					[2] = 6.11,
				},
				[243] = 
				{
					[1] = 0.73,
					[2] = 6.13,
				},
				[244] = 
				{
					[1] = 0.74,
					[2] = 6.15,
				},
				[245] = 
				{
					[1] = 0.74,
					[2] = 6.17,
				},
				[246] = 
				{
					[1] = 0.74,
					[2] = 6.19,
				},
				[247] = 
				{
					[1] = 0.75,
					[2] = 6.21,
				},
				[248] = 
				{
					[1] = 0.75,
					[2] = 6.23,
				},
				[249] = 
				{
					[1] = 0.75,
					[2] = 6.25,
				},
				[250] = 
				{
					[1] = 0.75,
					[2] = 6.27,
				},
				[251] = 
				{
					[1] = 0.76,
					[2] = 6.29,
				},
				[252] = 
				{
					[1] = 0.76,
					[2] = 6.31,
				},
				[253] = 
				{
					[1] = 0.76,
					[2] = 6.33,
				},
				[254] = 
				{
					[1] = 0.77,
					[2] = 6.35,
				},
				[255] = 
				{
					[1] = 0.77,
					[2] = 6.37,
				},
				[256] = 
				{
					[1] = 0.77,
					[2] = 6.39,
				},
				[257] = 
				{
					[1] = 0.78,
					[2] = 6.41,
				},
				[258] = 
				{
					[1] = 0.78,
					[2] = 6.43,
				},
				[259] = 
				{
					[1] = 0.78,
					[2] = 6.45,
				},
				[260] = 
				{
					[1] = 0.78,
					[2] = 6.47,
				},
				[261] = 
				{
					[1] = 0.79,
					[2] = 6.48,
				},
				[262] = 
				{
					[1] = 0.79,
					[2] = 6.5,
				},
				[263] = 
				{
					[1] = 0.79,
					[2] = 6.52,
				},
				[264] = 
				{
					[1] = 0.8,
					[2] = 6.54,
				},
				[265] = 
				{
					[1] = 0.8,
					[2] = 6.56,
				},
				[266] = 
				{
					[1] = 0.8,
					[2] = 6.57,
				},
				[267] = 
				{
					[1] = 0.81,
					[2] = 6.59,
				},
				[268] = 
				{
					[1] = 0.81,
					[2] = 6.61,
				},
				[269] = 
				{
					[1] = 0.81,
					[2] = 6.63,
				},
				[270] = 
				{
					[1] = 0.82,
					[2] = 6.64,
				},
				[271] = 
				{
					[1] = 0.82,
					[2] = 6.66,
				},
				[272] = 
				{
					[1] = 0.82,
					[2] = 6.68,
				},
				[273] = 
				{
					[1] = 0.82,
					[2] = 6.69,
				},
				[274] = 
				{
					[1] = 0.83,
					[2] = 6.71,
				},
				[275] = 
				{
					[1] = 0.83,
					[2] = 6.72,
				},
				[276] = 
				{
					[1] = 0.83,
					[2] = 6.74,
				},
				[277] = 
				{
					[1] = 0.84,
					[2] = 6.76,
				},
				[278] = 
				{
					[1] = 0.84,
					[2] = 6.77,
				},
				[279] = 
				{
					[1] = 0.84,
					[2] = 6.79,
				},
				[280] = 
				{
					[1] = 0.85,
					[2] = 6.8,
				},
				[281] = 
				{
					[1] = 0.85,
					[2] = 6.82,
				},
				[282] = 
				{
					[1] = 0.85,
					[2] = 6.83,
				},
				[283] = 
				{
					[1] = 0.85,
					[2] = 6.85,
				},
				[284] = 
				{
					[1] = 0.86,
					[2] = 6.86,
				},
				[285] = 
				{
					[1] = 0.86,
					[2] = 6.87,
				},
				[286] = 
				{
					[1] = 0.86,
					[2] = 6.89,
				},
				[287] = 
				{
					[1] = 0.87,
					[2] = 6.9,
				},
				[288] = 
				{
					[1] = 0.87,
					[2] = 6.92,
				},
				[289] = 
				{
					[1] = 0.87,
					[2] = 6.93,
				},
				[290] = 
				{
					[1] = 0.88,
					[2] = 6.94,
				},
				[291] = 
				{
					[1] = 0.88,
					[2] = 6.96,
				},
				[292] = 
				{
					[1] = 0.88,
					[2] = 6.97,
				},
				[293] = 
				{
					[1] = 0.88,
					[2] = 6.98,
				},
				[294] = 
				{
					[1] = 0.89,
					[2] = 6.99,
				},
				[295] = 
				{
					[1] = 0.89,
					[2] = 7.01,
				},
				[296] = 
				{
					[1] = 0.89,
					[2] = 7.02,
				},
				[297] = 
				{
					[1] = 0.9,
					[2] = 7.03,
				},
				[298] = 
				{
					[1] = 0.9,
					[2] = 7.04,
				},
				[299] = 
				{
					[1] = 0.9,
					[2] = 7.06,
				},
				[300] = 
				{
					[1] = 0.91,
					[2] = 7.06,
				},
				[301] = 
				{
					[1] = 0.91,
					[2] = 7.07,
				},
				[302] = 
				{
					[1] = 0.91,
					[2] = 7.07,
				},
				[303] = 
				{
					[1] = 0.92,
					[2] = 7.07,
				},
				[304] = 
				{
					[1] = 0.92,
					[2] = 7.08,
				},
				[305] = 
				{
					[1] = 0.92,
					[2] = 7.08,
				},
				[306] = 
				{
					[1] = 0.92,
					[2] = 7.08,
				},
				[307] = 
				{
					[1] = 0.93,
					[2] = 7.09,
				},
				[308] = 
				{
					[1] = 0.93,
					[2] = 7.09,
				},
				[309] = 
				{
					[1] = 0.93,
					[2] = 7.09,
				},
				[310] = 
				{
					[1] = 0.94,
					[2] = 7.09,
				},
				[311] = 
				{
					[1] = 0.94,
					[2] = 7.09,
				},
				[312] = 
				{
					[1] = 0.94,
					[2] = 7.1,
				},
				[313] = 
				{
					[1] = 0.95,
					[2] = 7.1,
				},
				[314] = 
				{
					[1] = 0.95,
					[2] = 7.1,
				},
				[315] = 
				{
					[1] = 0.95,
					[2] = 7.1,
				},
				[316] = 
				{
					[1] = 0.95,
					[2] = 7.1,
				},
				[317] = 
				{
					[1] = 0.96,
					[2] = 7.1,
				},
				[318] = 
				{
					[1] = 0.96,
					[2] = 7.1,
				},
				[319] = 
				{
					[1] = 0.96,
					[2] = 7.11,
				},
				[320] = 
				{
					[1] = 0.97,
					[2] = 7.11,
				},
				[321] = 
				{
					[1] = 0.97,
					[2] = 7.11,
				},
				[322] = 
				{
					[1] = 0.97,
					[2] = 7.11,
				},
				[323] = 
				{
					[1] = 0.98,
					[2] = 7.11,
				},
				[324] = 
				{
					[1] = 0.98,
					[2] = 7.11,
				},
				[325] = 
				{
					[1] = 0.98,
					[2] = 7.11,
				},
				[326] = 
				{
					[1] = 0.98,
					[2] = 7.11,
				},
				[327] = 
				{
					[1] = 0.99,
					[2] = 7.11,
				},
				[328] = 
				{
					[1] = 0.99,
					[2] = 7.11,
				},
				[329] = 
				{
					[1] = 0.99,
					[2] = 7.11,
				},
				[330] = 
				{
					[1] = 1,
					[2] = 7.11,
				},
			},
			["WidthScale"] = 0.5,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Hiei",
		["Type"] = "WaterTracer",
	},
	[228] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 286.35788,
			["Lifetime"] = 19.879999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.023,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 7.24,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 374.512329,
			["Lifetime"] = 26,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0288,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 3.19,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 66.115829,
			["Lifetime"] = 4.59,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0288,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 7.36,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Hiei",
		["Type"] = "WaterTracer",
	},
	[229] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 9.8,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.5102,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 1.25,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 1.27,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 1.3,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 1.33,
				},
				[6] = 
				{
					[1] = 0.56,
					[2] = 1.36,
				},
				[7] = 
				{
					[1] = 0.67,
					[2] = 1.39,
				},
				[8] = 
				{
					[1] = 0.78,
					[2] = 1.39,
				},
				[9] = 
				{
					[1] = 0.89,
					[2] = 1.39,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.33,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 1.47,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.07,
					[2] = 1.57,
				},
				[3] = 
				{
					[1] = 0.14,
					[2] = 1.7,
				},
				[4] = 
				{
					[1] = 0.21,
					[2] = 1.77,
				},
				[5] = 
				{
					[1] = 0.29,
					[2] = 1.82,
				},
				[6] = 
				{
					[1] = 0.36,
					[2] = 1.86,
				},
				[7] = 
				{
					[1] = 0.43,
					[2] = 1.89,
				},
				[8] = 
				{
					[1] = 0.5,
					[2] = 1.85,
				},
				[9] = 
				{
					[1] = 0.57,
					[2] = 1.77,
				},
				[10] = 
				{
					[1] = 0.64,
					[2] = 1.69,
				},
				[11] = 
				{
					[1] = 0.71,
					[2] = 1.6,
				},
				[12] = 
				{
					[1] = 0.79,
					[2] = 1.52,
				},
				[13] = 
				{
					[1] = 0.86,
					[2] = 1.43,
				},
				[14] = 
				{
					[1] = 0.93,
					[2] = 1.35,
				},
			},
			["WidthScale"] = 1.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Higgins",
		["Type"] = "WaterTracer",
	},
	[230] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 12.758112,
			["Lifetime"] = 1.24,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1715,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.97,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 16.667856,
			["Lifetime"] = 1.62,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2143,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.43,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 2.983752,
			["Lifetime"] = 0.29,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.2143,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.99,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Higgins",
		["Type"] = "WaterTracer",
	},
	[231] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 222.5,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0225,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.42,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.7,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.93,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.15,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 1.39,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.62,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.86,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 2.08,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 2.3,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 2.52,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 2.72,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 2.9,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 3.08,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 3.26,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 3.44,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 3.62,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 3.78,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 3.95,
				},
				[20] = 
				{
					[1] = 0.09,
					[2] = 4.11,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 4.27,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 4.43,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 4.59,
				},
				[24] = 
				{
					[1] = 0.1,
					[2] = 4.76,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 4.92,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 5.08,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 5.24,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 5.39,
				},
				[29] = 
				{
					[1] = 0.13,
					[2] = 5.54,
				},
				[30] = 
				{
					[1] = 0.13,
					[2] = 5.69,
				},
				[31] = 
				{
					[1] = 0.14,
					[2] = 5.84,
				},
				[32] = 
				{
					[1] = 0.14,
					[2] = 5.99,
				},
				[33] = 
				{
					[1] = 0.14,
					[2] = 6.14,
				},
				[34] = 
				{
					[1] = 0.15,
					[2] = 6.29,
				},
				[35] = 
				{
					[1] = 0.15,
					[2] = 6.44,
				},
				[36] = 
				{
					[1] = 0.16,
					[2] = 6.59,
				},
				[37] = 
				{
					[1] = 0.16,
					[2] = 6.74,
				},
				[38] = 
				{
					[1] = 0.17,
					[2] = 6.89,
				},
				[39] = 
				{
					[1] = 0.17,
					[2] = 7.02,
				},
				[40] = 
				{
					[1] = 0.18,
					[2] = 7.14,
				},
				[41] = 
				{
					[1] = 0.18,
					[2] = 7.26,
				},
				[42] = 
				{
					[1] = 0.18,
					[2] = 7.38,
				},
				[43] = 
				{
					[1] = 0.19,
					[2] = 7.5,
				},
				[44] = 
				{
					[1] = 0.19,
					[2] = 7.62,
				},
				[45] = 
				{
					[1] = 0.2,
					[2] = 7.74,
				},
				[46] = 
				{
					[1] = 0.2,
					[2] = 7.86,
				},
				[47] = 
				{
					[1] = 0.21,
					[2] = 7.98,
				},
				[48] = 
				{
					[1] = 0.21,
					[2] = 8.1,
				},
				[49] = 
				{
					[1] = 0.22,
					[2] = 8.21,
				},
				[50] = 
				{
					[1] = 0.22,
					[2] = 8.33,
				},
				[51] = 
				{
					[1] = 0.23,
					[2] = 8.45,
				},
				[52] = 
				{
					[1] = 0.23,
					[2] = 8.57,
				},
				[53] = 
				{
					[1] = 0.23,
					[2] = 8.69,
				},
				[54] = 
				{
					[1] = 0.24,
					[2] = 8.81,
				},
				[55] = 
				{
					[1] = 0.24,
					[2] = 8.93,
				},
				[56] = 
				{
					[1] = 0.25,
					[2] = 9.05,
				},
				[57] = 
				{
					[1] = 0.25,
					[2] = 9.17,
				},
				[58] = 
				{
					[1] = 0.26,
					[2] = 9.29,
				},
				[59] = 
				{
					[1] = 0.26,
					[2] = 9.41,
				},
				[60] = 
				{
					[1] = 0.27,
					[2] = 9.55,
				},
				[61] = 
				{
					[1] = 0.27,
					[2] = 9.69,
				},
				[62] = 
				{
					[1] = 0.27,
					[2] = 9.82,
				},
				[63] = 
				{
					[1] = 0.28,
					[2] = 9.96,
				},
				[64] = 
				{
					[1] = 0.28,
					[2] = 10.09,
				},
				[65] = 
				{
					[1] = 0.29,
					[2] = 10.23,
				},
				[66] = 
				{
					[1] = 0.29,
					[2] = 10.37,
				},
				[67] = 
				{
					[1] = 0.3,
					[2] = 10.46,
				},
				[68] = 
				{
					[1] = 0.3,
					[2] = 10.49,
				},
				[69] = 
				{
					[1] = 0.31,
					[2] = 10.51,
				},
				[70] = 
				{
					[1] = 0.31,
					[2] = 10.54,
				},
				[71] = 
				{
					[1] = 0.32,
					[2] = 10.57,
				},
				[72] = 
				{
					[1] = 0.32,
					[2] = 10.59,
				},
				[73] = 
				{
					[1] = 0.32,
					[2] = 10.62,
				},
				[74] = 
				{
					[1] = 0.33,
					[2] = 10.64,
				},
				[75] = 
				{
					[1] = 0.33,
					[2] = 10.67,
				},
				[76] = 
				{
					[1] = 0.34,
					[2] = 10.7,
				},
				[77] = 
				{
					[1] = 0.34,
					[2] = 10.72,
				},
				[78] = 
				{
					[1] = 0.35,
					[2] = 10.75,
				},
				[79] = 
				{
					[1] = 0.35,
					[2] = 10.77,
				},
				[80] = 
				{
					[1] = 0.36,
					[2] = 10.8,
				},
				[81] = 
				{
					[1] = 0.36,
					[2] = 10.83,
				},
				[82] = 
				{
					[1] = 0.36,
					[2] = 10.85,
				},
				[83] = 
				{
					[1] = 0.37,
					[2] = 10.88,
				},
				[84] = 
				{
					[1] = 0.37,
					[2] = 10.9,
				},
				[85] = 
				{
					[1] = 0.38,
					[2] = 10.93,
				},
				[86] = 
				{
					[1] = 0.38,
					[2] = 10.96,
				},
				[87] = 
				{
					[1] = 0.39,
					[2] = 10.98,
				},
				[88] = 
				{
					[1] = 0.39,
					[2] = 11.01,
				},
				[89] = 
				{
					[1] = 0.4,
					[2] = 11.04,
				},
				[90] = 
				{
					[1] = 0.4,
					[2] = 11.06,
				},
				[91] = 
				{
					[1] = 0.41,
					[2] = 11.09,
				},
				[92] = 
				{
					[1] = 0.41,
					[2] = 11.11,
				},
				[93] = 
				{
					[1] = 0.41,
					[2] = 11.14,
				},
				[94] = 
				{
					[1] = 0.42,
					[2] = 11.17,
				},
				[95] = 
				{
					[1] = 0.42,
					[2] = 11.19,
				},
				[96] = 
				{
					[1] = 0.43,
					[2] = 11.22,
				},
				[97] = 
				{
					[1] = 0.43,
					[2] = 11.24,
				},
				[98] = 
				{
					[1] = 0.44,
					[2] = 11.27,
				},
				[99] = 
				{
					[1] = 0.44,
					[2] = 11.3,
				},
				[100] = 
				{
					[1] = 0.45,
					[2] = 11.32,
				},
				[101] = 
				{
					[1] = 0.45,
					[2] = 11.35,
				},
				[102] = 
				{
					[1] = 0.45,
					[2] = 11.37,
				},
				[103] = 
				{
					[1] = 0.46,
					[2] = 11.4,
				},
				[104] = 
				{
					[1] = 0.46,
					[2] = 11.43,
				},
				[105] = 
				{
					[1] = 0.47,
					[2] = 11.45,
				},
				[106] = 
				{
					[1] = 0.47,
					[2] = 11.48,
				},
				[107] = 
				{
					[1] = 0.48,
					[2] = 11.5,
				},
				[108] = 
				{
					[1] = 0.48,
					[2] = 11.53,
				},
				[109] = 
				{
					[1] = 0.49,
					[2] = 11.56,
				},
				[110] = 
				{
					[1] = 0.49,
					[2] = 11.58,
				},
				[111] = 
				{
					[1] = 0.5,
					[2] = 11.61,
				},
				[112] = 
				{
					[1] = 0.5,
					[2] = 11.64,
				},
				[113] = 
				{
					[1] = 0.5,
					[2] = 11.66,
				},
				[114] = 
				{
					[1] = 0.51,
					[2] = 11.69,
				},
				[115] = 
				{
					[1] = 0.51,
					[2] = 11.71,
				},
				[116] = 
				{
					[1] = 0.52,
					[2] = 11.74,
				},
				[117] = 
				{
					[1] = 0.52,
					[2] = 11.77,
				},
				[118] = 
				{
					[1] = 0.53,
					[2] = 11.79,
				},
				[119] = 
				{
					[1] = 0.53,
					[2] = 11.82,
				},
				[120] = 
				{
					[1] = 0.54,
					[2] = 11.84,
				},
				[121] = 
				{
					[1] = 0.54,
					[2] = 11.87,
				},
				[122] = 
				{
					[1] = 0.55,
					[2] = 11.9,
				},
				[123] = 
				{
					[1] = 0.55,
					[2] = 11.92,
				},
				[124] = 
				{
					[1] = 0.55,
					[2] = 11.95,
				},
				[125] = 
				{
					[1] = 0.56,
					[2] = 11.94,
				},
				[126] = 
				{
					[1] = 0.56,
					[2] = 11.93,
				},
				[127] = 
				{
					[1] = 0.57,
					[2] = 11.92,
				},
				[128] = 
				{
					[1] = 0.57,
					[2] = 11.91,
				},
				[129] = 
				{
					[1] = 0.58,
					[2] = 11.9,
				},
				[130] = 
				{
					[1] = 0.58,
					[2] = 11.89,
				},
				[131] = 
				{
					[1] = 0.59,
					[2] = 11.88,
				},
				[132] = 
				{
					[1] = 0.59,
					[2] = 11.87,
				},
				[133] = 
				{
					[1] = 0.59,
					[2] = 11.85,
				},
				[134] = 
				{
					[1] = 0.6,
					[2] = 11.84,
				},
				[135] = 
				{
					[1] = 0.6,
					[2] = 11.83,
				},
				[136] = 
				{
					[1] = 0.61,
					[2] = 11.82,
				},
				[137] = 
				{
					[1] = 0.61,
					[2] = 11.81,
				},
				[138] = 
				{
					[1] = 0.62,
					[2] = 11.8,
				},
				[139] = 
				{
					[1] = 0.62,
					[2] = 11.79,
				},
				[140] = 
				{
					[1] = 0.63,
					[2] = 11.78,
				},
				[141] = 
				{
					[1] = 0.63,
					[2] = 11.76,
				},
				[142] = 
				{
					[1] = 0.64,
					[2] = 11.75,
				},
				[143] = 
				{
					[1] = 0.64,
					[2] = 11.74,
				},
				[144] = 
				{
					[1] = 0.64,
					[2] = 11.73,
				},
				[145] = 
				{
					[1] = 0.65,
					[2] = 11.71,
				},
				[146] = 
				{
					[1] = 0.65,
					[2] = 11.7,
				},
				[147] = 
				{
					[1] = 0.66,
					[2] = 11.69,
				},
				[148] = 
				{
					[1] = 0.66,
					[2] = 11.68,
				},
				[149] = 
				{
					[1] = 0.67,
					[2] = 11.66,
				},
				[150] = 
				{
					[1] = 0.67,
					[2] = 11.65,
				},
				[151] = 
				{
					[1] = 0.68,
					[2] = 11.64,
				},
				[152] = 
				{
					[1] = 0.68,
					[2] = 11.62,
				},
				[153] = 
				{
					[1] = 0.68,
					[2] = 11.61,
				},
				[154] = 
				{
					[1] = 0.69,
					[2] = 11.6,
				},
				[155] = 
				{
					[1] = 0.69,
					[2] = 11.59,
				},
				[156] = 
				{
					[1] = 0.7,
					[2] = 11.57,
				},
				[157] = 
				{
					[1] = 0.7,
					[2] = 11.56,
				},
				[158] = 
				{
					[1] = 0.71,
					[2] = 11.55,
				},
				[159] = 
				{
					[1] = 0.71,
					[2] = 11.54,
				},
				[160] = 
				{
					[1] = 0.72,
					[2] = 11.55,
				},
				[161] = 
				{
					[1] = 0.72,
					[2] = 11.55,
				},
				[162] = 
				{
					[1] = 0.73,
					[2] = 11.56,
				},
				[163] = 
				{
					[1] = 0.73,
					[2] = 11.57,
				},
				[164] = 
				{
					[1] = 0.73,
					[2] = 11.58,
				},
				[165] = 
				{
					[1] = 0.74,
					[2] = 11.59,
				},
				[166] = 
				{
					[1] = 0.74,
					[2] = 11.6,
				},
				[167] = 
				{
					[1] = 0.75,
					[2] = 11.6,
				},
				[168] = 
				{
					[1] = 0.75,
					[2] = 11.61,
				},
				[169] = 
				{
					[1] = 0.76,
					[2] = 11.62,
				},
				[170] = 
				{
					[1] = 0.76,
					[2] = 11.63,
				},
				[171] = 
				{
					[1] = 0.77,
					[2] = 11.65,
				},
				[172] = 
				{
					[1] = 0.77,
					[2] = 11.67,
				},
				[173] = 
				{
					[1] = 0.77,
					[2] = 11.7,
				},
				[174] = 
				{
					[1] = 0.78,
					[2] = 11.73,
				},
				[175] = 
				{
					[1] = 0.78,
					[2] = 11.75,
				},
				[176] = 
				{
					[1] = 0.79,
					[2] = 11.78,
				},
				[177] = 
				{
					[1] = 0.79,
					[2] = 11.81,
				},
				[178] = 
				{
					[1] = 0.8,
					[2] = 11.83,
				},
				[179] = 
				{
					[1] = 0.8,
					[2] = 11.82,
				},
				[180] = 
				{
					[1] = 0.81,
					[2] = 11.81,
				},
				[181] = 
				{
					[1] = 0.81,
					[2] = 11.8,
				},
				[182] = 
				{
					[1] = 0.82,
					[2] = 11.79,
				},
				[183] = 
				{
					[1] = 0.82,
					[2] = 11.78,
				},
				[184] = 
				{
					[1] = 0.82,
					[2] = 11.77,
				},
				[185] = 
				{
					[1] = 0.83,
					[2] = 11.75,
				},
				[186] = 
				{
					[1] = 0.83,
					[2] = 11.74,
				},
				[187] = 
				{
					[1] = 0.84,
					[2] = 11.72,
				},
				[188] = 
				{
					[1] = 0.84,
					[2] = 11.71,
				},
				[189] = 
				{
					[1] = 0.85,
					[2] = 11.69,
				},
				[190] = 
				{
					[1] = 0.85,
					[2] = 11.68,
				},
				[191] = 
				{
					[1] = 0.86,
					[2] = 11.62,
				},
				[192] = 
				{
					[1] = 0.86,
					[2] = 11.57,
				},
				[193] = 
				{
					[1] = 0.86,
					[2] = 11.51,
				},
				[194] = 
				{
					[1] = 0.87,
					[2] = 11.45,
				},
				[195] = 
				{
					[1] = 0.87,
					[2] = 11.4,
				},
				[196] = 
				{
					[1] = 0.88,
					[2] = 11.34,
				},
				[197] = 
				{
					[1] = 0.88,
					[2] = 11.29,
				},
				[198] = 
				{
					[1] = 0.89,
					[2] = 11.24,
				},
				[199] = 
				{
					[1] = 0.89,
					[2] = 11.13,
				},
				[200] = 
				{
					[1] = 0.9,
					[2] = 11.02,
				},
				[201] = 
				{
					[1] = 0.9,
					[2] = 10.91,
				},
				[202] = 
				{
					[1] = 0.91,
					[2] = 10.8,
				},
				[203] = 
				{
					[1] = 0.91,
					[2] = 10.7,
				},
				[204] = 
				{
					[1] = 0.91,
					[2] = 10.61,
				},
				[205] = 
				{
					[1] = 0.92,
					[2] = 10.42,
				},
				[206] = 
				{
					[1] = 0.92,
					[2] = 10.22,
				},
				[207] = 
				{
					[1] = 0.93,
					[2] = 10.03,
				},
				[208] = 
				{
					[1] = 0.93,
					[2] = 9.84,
				},
				[209] = 
				{
					[1] = 0.94,
					[2] = 9.65,
				},
				[210] = 
				{
					[1] = 0.94,
					[2] = 9.47,
				},
				[211] = 
				{
					[1] = 0.95,
					[2] = 9.19,
				},
				[212] = 
				{
					[1] = 0.95,
					[2] = 8.9,
				},
				[213] = 
				{
					[1] = 0.95,
					[2] = 8.62,
				},
				[214] = 
				{
					[1] = 0.96,
					[2] = 8.34,
				},
				[215] = 
				{
					[1] = 0.96,
					[2] = 8.15,
				},
				[216] = 
				{
					[1] = 0.97,
					[2] = 7.73,
				},
				[217] = 
				{
					[1] = 0.97,
					[2] = 7.16,
				},
				[218] = 
				{
					[1] = 0.98,
					[2] = 6.56,
				},
				[219] = 
				{
					[1] = 0.98,
					[2] = 5.96,
				},
				[220] = 
				{
					[1] = 0.99,
					[2] = 5.36,
				},
				[221] = 
				{
					[1] = 0.99,
					[2] = 4.71,
				},
				[222] = 
				{
					[1] = 1,
					[2] = 3.83,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.21,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.28,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[6] = 
				{
					[1] = 0.09,
					[2] = 0.41,
				},
				[7] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[8] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[10] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[12] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[18] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[19] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[20] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[21] = 
				{
					[1] = 0.36,
					[2] = 0.47,
				},
				[22] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[23] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[24] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[25] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[26] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[27] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[28] = 
				{
					[1] = 0.49,
					[2] = 0.4,
				},
				[29] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[30] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[31] = 
				{
					[1] = 0.55,
					[2] = 0.37,
				},
				[32] = 
				{
					[1] = 0.56,
					[2] = 0.35,
				},
				[33] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[34] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[35] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[36] = 
				{
					[1] = 0.64,
					[2] = 0.3,
				},
				[37] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[38] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[39] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[40] = 
				{
					[1] = 0.71,
					[2] = 0.24,
				},
				[41] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[42] = 
				{
					[1] = 0.75,
					[2] = 0.21,
				},
				[43] = 
				{
					[1] = 0.76,
					[2] = 0.19,
				},
				[44] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[45] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[46] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[47] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[48] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[49] = 
				{
					[1] = 0.87,
					[2] = 0.1,
				},
				[50] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[51] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[52] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[53] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[54] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
				[55] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 15,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.11,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.19,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.27,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.35,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.43,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.51,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 0.59,
				},
				[9] = 
				{
					[1] = 0.02,
					[2] = 0.67,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.75,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 0.83,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 0.91,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 0.99,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 1.05,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 1.1,
				},
				[16] = 
				{
					[1] = 0.05,
					[2] = 1.14,
				},
				[17] = 
				{
					[1] = 0.05,
					[2] = 1.18,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 1.23,
				},
				[19] = 
				{
					[1] = 0.05,
					[2] = 1.27,
				},
				[20] = 
				{
					[1] = 0.06,
					[2] = 1.31,
				},
				[21] = 
				{
					[1] = 0.06,
					[2] = 1.35,
				},
				[22] = 
				{
					[1] = 0.06,
					[2] = 1.4,
				},
				[23] = 
				{
					[1] = 0.07,
					[2] = 1.44,
				},
				[24] = 
				{
					[1] = 0.07,
					[2] = 1.48,
				},
				[25] = 
				{
					[1] = 0.07,
					[2] = 1.52,
				},
				[26] = 
				{
					[1] = 0.08,
					[2] = 1.56,
				},
				[27] = 
				{
					[1] = 0.08,
					[2] = 1.61,
				},
				[28] = 
				{
					[1] = 0.08,
					[2] = 1.65,
				},
				[29] = 
				{
					[1] = 0.08,
					[2] = 1.69,
				},
				[30] = 
				{
					[1] = 0.09,
					[2] = 1.73,
				},
				[31] = 
				{
					[1] = 0.09,
					[2] = 1.77,
				},
				[32] = 
				{
					[1] = 0.09,
					[2] = 1.81,
				},
				[33] = 
				{
					[1] = 0.1,
					[2] = 1.85,
				},
				[34] = 
				{
					[1] = 0.1,
					[2] = 1.89,
				},
				[35] = 
				{
					[1] = 0.1,
					[2] = 1.93,
				},
				[36] = 
				{
					[1] = 0.11,
					[2] = 1.97,
				},
				[37] = 
				{
					[1] = 0.11,
					[2] = 2.01,
				},
				[38] = 
				{
					[1] = 0.11,
					[2] = 2.05,
				},
				[39] = 
				{
					[1] = 0.11,
					[2] = 2.08,
				},
				[40] = 
				{
					[1] = 0.12,
					[2] = 2.12,
				},
				[41] = 
				{
					[1] = 0.12,
					[2] = 2.16,
				},
				[42] = 
				{
					[1] = 0.12,
					[2] = 2.2,
				},
				[43] = 
				{
					[1] = 0.13,
					[2] = 2.24,
				},
				[44] = 
				{
					[1] = 0.13,
					[2] = 2.28,
				},
				[45] = 
				{
					[1] = 0.13,
					[2] = 2.32,
				},
				[46] = 
				{
					[1] = 0.14,
					[2] = 2.36,
				},
				[47] = 
				{
					[1] = 0.14,
					[2] = 2.4,
				},
				[48] = 
				{
					[1] = 0.14,
					[2] = 2.45,
				},
				[49] = 
				{
					[1] = 0.14,
					[2] = 2.49,
				},
				[50] = 
				{
					[1] = 0.15,
					[2] = 2.53,
				},
				[51] = 
				{
					[1] = 0.15,
					[2] = 2.57,
				},
				[52] = 
				{
					[1] = 0.15,
					[2] = 2.61,
				},
				[53] = 
				{
					[1] = 0.16,
					[2] = 2.65,
				},
				[54] = 
				{
					[1] = 0.16,
					[2] = 2.69,
				},
				[55] = 
				{
					[1] = 0.16,
					[2] = 2.72,
				},
				[56] = 
				{
					[1] = 0.17,
					[2] = 2.76,
				},
				[57] = 
				{
					[1] = 0.17,
					[2] = 2.8,
				},
				[58] = 
				{
					[1] = 0.17,
					[2] = 2.84,
				},
				[59] = 
				{
					[1] = 0.17,
					[2] = 2.88,
				},
				[60] = 
				{
					[1] = 0.18,
					[2] = 2.92,
				},
				[61] = 
				{
					[1] = 0.18,
					[2] = 2.95,
				},
				[62] = 
				{
					[1] = 0.18,
					[2] = 2.99,
				},
				[63] = 
				{
					[1] = 0.19,
					[2] = 3.03,
				},
				[64] = 
				{
					[1] = 0.19,
					[2] = 3.07,
				},
				[65] = 
				{
					[1] = 0.19,
					[2] = 3.1,
				},
				[66] = 
				{
					[1] = 0.2,
					[2] = 3.14,
				},
				[67] = 
				{
					[1] = 0.2,
					[2] = 3.18,
				},
				[68] = 
				{
					[1] = 0.2,
					[2] = 3.21,
				},
				[69] = 
				{
					[1] = 0.2,
					[2] = 3.25,
				},
				[70] = 
				{
					[1] = 0.21,
					[2] = 3.29,
				},
				[71] = 
				{
					[1] = 0.21,
					[2] = 3.32,
				},
				[72] = 
				{
					[1] = 0.21,
					[2] = 3.36,
				},
				[73] = 
				{
					[1] = 0.22,
					[2] = 3.39,
				},
				[74] = 
				{
					[1] = 0.22,
					[2] = 3.43,
				},
				[75] = 
				{
					[1] = 0.22,
					[2] = 3.46,
				},
				[76] = 
				{
					[1] = 0.23,
					[2] = 3.49,
				},
				[77] = 
				{
					[1] = 0.23,
					[2] = 3.53,
				},
				[78] = 
				{
					[1] = 0.23,
					[2] = 3.56,
				},
				[79] = 
				{
					[1] = 0.23,
					[2] = 3.59,
				},
				[80] = 
				{
					[1] = 0.24,
					[2] = 3.63,
				},
				[81] = 
				{
					[1] = 0.24,
					[2] = 3.66,
				},
				[82] = 
				{
					[1] = 0.24,
					[2] = 3.69,
				},
				[83] = 
				{
					[1] = 0.25,
					[2] = 3.72,
				},
				[84] = 
				{
					[1] = 0.25,
					[2] = 3.76,
				},
				[85] = 
				{
					[1] = 0.25,
					[2] = 3.79,
				},
				[86] = 
				{
					[1] = 0.26,
					[2] = 3.82,
				},
				[87] = 
				{
					[1] = 0.26,
					[2] = 3.85,
				},
				[88] = 
				{
					[1] = 0.26,
					[2] = 3.88,
				},
				[89] = 
				{
					[1] = 0.26,
					[2] = 3.91,
				},
				[90] = 
				{
					[1] = 0.27,
					[2] = 3.94,
				},
				[91] = 
				{
					[1] = 0.27,
					[2] = 3.98,
				},
				[92] = 
				{
					[1] = 0.27,
					[2] = 4.01,
				},
				[93] = 
				{
					[1] = 0.28,
					[2] = 4.04,
				},
				[94] = 
				{
					[1] = 0.28,
					[2] = 4.07,
				},
				[95] = 
				{
					[1] = 0.28,
					[2] = 4.1,
				},
				[96] = 
				{
					[1] = 0.29,
					[2] = 4.13,
				},
				[97] = 
				{
					[1] = 0.29,
					[2] = 4.16,
				},
				[98] = 
				{
					[1] = 0.29,
					[2] = 4.19,
				},
				[99] = 
				{
					[1] = 0.29,
					[2] = 4.22,
				},
				[100] = 
				{
					[1] = 0.3,
					[2] = 4.25,
				},
				[101] = 
				{
					[1] = 0.3,
					[2] = 4.28,
				},
				[102] = 
				{
					[1] = 0.3,
					[2] = 4.31,
				},
				[103] = 
				{
					[1] = 0.31,
					[2] = 4.33,
				},
				[104] = 
				{
					[1] = 0.31,
					[2] = 4.36,
				},
				[105] = 
				{
					[1] = 0.31,
					[2] = 4.39,
				},
				[106] = 
				{
					[1] = 0.32,
					[2] = 4.42,
				},
				[107] = 
				{
					[1] = 0.32,
					[2] = 4.45,
				},
				[108] = 
				{
					[1] = 0.32,
					[2] = 4.48,
				},
				[109] = 
				{
					[1] = 0.32,
					[2] = 4.5,
				},
				[110] = 
				{
					[1] = 0.33,
					[2] = 4.52,
				},
				[111] = 
				{
					[1] = 0.33,
					[2] = 4.55,
				},
				[112] = 
				{
					[1] = 0.33,
					[2] = 4.57,
				},
				[113] = 
				{
					[1] = 0.34,
					[2] = 4.59,
				},
				[114] = 
				{
					[1] = 0.34,
					[2] = 4.61,
				},
				[115] = 
				{
					[1] = 0.34,
					[2] = 4.63,
				},
				[116] = 
				{
					[1] = 0.35,
					[2] = 4.65,
				},
				[117] = 
				{
					[1] = 0.35,
					[2] = 4.68,
				},
				[118] = 
				{
					[1] = 0.35,
					[2] = 4.7,
				},
				[119] = 
				{
					[1] = 0.35,
					[2] = 4.72,
				},
				[120] = 
				{
					[1] = 0.36,
					[2] = 4.74,
				},
				[121] = 
				{
					[1] = 0.36,
					[2] = 4.76,
				},
				[122] = 
				{
					[1] = 0.36,
					[2] = 4.78,
				},
				[123] = 
				{
					[1] = 0.37,
					[2] = 4.8,
				},
				[124] = 
				{
					[1] = 0.37,
					[2] = 4.82,
				},
				[125] = 
				{
					[1] = 0.37,
					[2] = 4.84,
				},
				[126] = 
				{
					[1] = 0.38,
					[2] = 4.86,
				},
				[127] = 
				{
					[1] = 0.38,
					[2] = 4.88,
				},
				[128] = 
				{
					[1] = 0.38,
					[2] = 4.9,
				},
				[129] = 
				{
					[1] = 0.38,
					[2] = 4.92,
				},
				[130] = 
				{
					[1] = 0.39,
					[2] = 4.94,
				},
				[131] = 
				{
					[1] = 0.39,
					[2] = 4.96,
				},
				[132] = 
				{
					[1] = 0.39,
					[2] = 4.98,
				},
				[133] = 
				{
					[1] = 0.4,
					[2] = 5,
				},
				[134] = 
				{
					[1] = 0.4,
					[2] = 5.02,
				},
				[135] = 
				{
					[1] = 0.4,
					[2] = 5.04,
				},
				[136] = 
				{
					[1] = 0.41,
					[2] = 5.06,
				},
				[137] = 
				{
					[1] = 0.41,
					[2] = 5.08,
				},
				[138] = 
				{
					[1] = 0.41,
					[2] = 5.1,
				},
				[139] = 
				{
					[1] = 0.41,
					[2] = 5.12,
				},
				[140] = 
				{
					[1] = 0.42,
					[2] = 5.14,
				},
				[141] = 
				{
					[1] = 0.42,
					[2] = 5.15,
				},
				[142] = 
				{
					[1] = 0.42,
					[2] = 5.17,
				},
				[143] = 
				{
					[1] = 0.43,
					[2] = 5.19,
				},
				[144] = 
				{
					[1] = 0.43,
					[2] = 5.21,
				},
				[145] = 
				{
					[1] = 0.43,
					[2] = 5.23,
				},
				[146] = 
				{
					[1] = 0.44,
					[2] = 5.25,
				},
				[147] = 
				{
					[1] = 0.44,
					[2] = 5.26,
				},
				[148] = 
				{
					[1] = 0.44,
					[2] = 5.28,
				},
				[149] = 
				{
					[1] = 0.44,
					[2] = 5.3,
				},
				[150] = 
				{
					[1] = 0.45,
					[2] = 5.32,
				},
				[151] = 
				{
					[1] = 0.45,
					[2] = 5.33,
				},
				[152] = 
				{
					[1] = 0.45,
					[2] = 5.35,
				},
				[153] = 
				{
					[1] = 0.46,
					[2] = 5.37,
				},
				[154] = 
				{
					[1] = 0.46,
					[2] = 5.38,
				},
				[155] = 
				{
					[1] = 0.46,
					[2] = 5.4,
				},
				[156] = 
				{
					[1] = 0.47,
					[2] = 5.42,
				},
				[157] = 
				{
					[1] = 0.47,
					[2] = 5.43,
				},
				[158] = 
				{
					[1] = 0.47,
					[2] = 5.45,
				},
				[159] = 
				{
					[1] = 0.47,
					[2] = 5.47,
				},
				[160] = 
				{
					[1] = 0.48,
					[2] = 5.48,
				},
				[161] = 
				{
					[1] = 0.48,
					[2] = 5.5,
				},
				[162] = 
				{
					[1] = 0.48,
					[2] = 5.52,
				},
				[163] = 
				{
					[1] = 0.49,
					[2] = 5.53,
				},
				[164] = 
				{
					[1] = 0.49,
					[2] = 5.54,
				},
				[165] = 
				{
					[1] = 0.49,
					[2] = 5.56,
				},
				[166] = 
				{
					[1] = 0.5,
					[2] = 5.57,
				},
				[167] = 
				{
					[1] = 0.5,
					[2] = 5.58,
				},
				[168] = 
				{
					[1] = 0.5,
					[2] = 5.6,
				},
				[169] = 
				{
					[1] = 0.5,
					[2] = 5.61,
				},
				[170] = 
				{
					[1] = 0.51,
					[2] = 5.62,
				},
				[171] = 
				{
					[1] = 0.51,
					[2] = 5.64,
				},
				[172] = 
				{
					[1] = 0.51,
					[2] = 5.65,
				},
				[173] = 
				{
					[1] = 0.52,
					[2] = 5.66,
				},
				[174] = 
				{
					[1] = 0.52,
					[2] = 5.67,
				},
				[175] = 
				{
					[1] = 0.52,
					[2] = 5.69,
				},
				[176] = 
				{
					[1] = 0.53,
					[2] = 5.7,
				},
				[177] = 
				{
					[1] = 0.53,
					[2] = 5.71,
				},
				[178] = 
				{
					[1] = 0.53,
					[2] = 5.72,
				},
				[179] = 
				{
					[1] = 0.53,
					[2] = 5.73,
				},
				[180] = 
				{
					[1] = 0.54,
					[2] = 5.75,
				},
				[181] = 
				{
					[1] = 0.54,
					[2] = 5.76,
				},
				[182] = 
				{
					[1] = 0.54,
					[2] = 5.77,
				},
				[183] = 
				{
					[1] = 0.55,
					[2] = 5.78,
				},
				[184] = 
				{
					[1] = 0.55,
					[2] = 5.79,
				},
				[185] = 
				{
					[1] = 0.55,
					[2] = 5.81,
				},
				[186] = 
				{
					[1] = 0.56,
					[2] = 5.82,
				},
				[187] = 
				{
					[1] = 0.56,
					[2] = 5.83,
				},
				[188] = 
				{
					[1] = 0.56,
					[2] = 5.84,
				},
				[189] = 
				{
					[1] = 0.56,
					[2] = 5.85,
				},
				[190] = 
				{
					[1] = 0.57,
					[2] = 5.86,
				},
				[191] = 
				{
					[1] = 0.57,
					[2] = 5.87,
				},
				[192] = 
				{
					[1] = 0.57,
					[2] = 5.88,
				},
				[193] = 
				{
					[1] = 0.58,
					[2] = 5.89,
				},
				[194] = 
				{
					[1] = 0.58,
					[2] = 5.9,
				},
				[195] = 
				{
					[1] = 0.58,
					[2] = 5.91,
				},
				[196] = 
				{
					[1] = 0.59,
					[2] = 5.93,
				},
				[197] = 
				{
					[1] = 0.59,
					[2] = 5.94,
				},
				[198] = 
				{
					[1] = 0.59,
					[2] = 5.95,
				},
				[199] = 
				{
					[1] = 0.59,
					[2] = 5.96,
				},
				[200] = 
				{
					[1] = 0.6,
					[2] = 5.97,
				},
				[201] = 
				{
					[1] = 0.6,
					[2] = 5.98,
				},
				[202] = 
				{
					[1] = 0.6,
					[2] = 5.99,
				},
				[203] = 
				{
					[1] = 0.61,
					[2] = 6,
				},
				[204] = 
				{
					[1] = 0.61,
					[2] = 6,
				},
				[205] = 
				{
					[1] = 0.61,
					[2] = 6.01,
				},
				[206] = 
				{
					[1] = 0.62,
					[2] = 6.02,
				},
				[207] = 
				{
					[1] = 0.62,
					[2] = 6.03,
				},
				[208] = 
				{
					[1] = 0.62,
					[2] = 6.04,
				},
				[209] = 
				{
					[1] = 0.62,
					[2] = 6.05,
				},
				[210] = 
				{
					[1] = 0.63,
					[2] = 6.06,
				},
				[211] = 
				{
					[1] = 0.63,
					[2] = 6.07,
				},
				[212] = 
				{
					[1] = 0.63,
					[2] = 6.08,
				},
				[213] = 
				{
					[1] = 0.64,
					[2] = 6.09,
				},
				[214] = 
				{
					[1] = 0.64,
					[2] = 6.1,
				},
				[215] = 
				{
					[1] = 0.64,
					[2] = 6.1,
				},
				[216] = 
				{
					[1] = 0.65,
					[2] = 6.11,
				},
				[217] = 
				{
					[1] = 0.65,
					[2] = 6.12,
				},
				[218] = 
				{
					[1] = 0.65,
					[2] = 6.13,
				},
				[219] = 
				{
					[1] = 0.65,
					[2] = 6.14,
				},
				[220] = 
				{
					[1] = 0.66,
					[2] = 6.15,
				},
				[221] = 
				{
					[1] = 0.66,
					[2] = 6.15,
				},
				[222] = 
				{
					[1] = 0.66,
					[2] = 6.16,
				},
				[223] = 
				{
					[1] = 0.67,
					[2] = 6.17,
				},
				[224] = 
				{
					[1] = 0.67,
					[2] = 6.18,
				},
				[225] = 
				{
					[1] = 0.67,
					[2] = 6.18,
				},
				[226] = 
				{
					[1] = 0.68,
					[2] = 6.19,
				},
				[227] = 
				{
					[1] = 0.68,
					[2] = 6.2,
				},
				[228] = 
				{
					[1] = 0.68,
					[2] = 6.21,
				},
				[229] = 
				{
					[1] = 0.68,
					[2] = 6.21,
				},
				[230] = 
				{
					[1] = 0.69,
					[2] = 6.22,
				},
				[231] = 
				{
					[1] = 0.69,
					[2] = 6.23,
				},
				[232] = 
				{
					[1] = 0.69,
					[2] = 6.23,
				},
				[233] = 
				{
					[1] = 0.7,
					[2] = 6.24,
				},
				[234] = 
				{
					[1] = 0.7,
					[2] = 6.25,
				},
				[235] = 
				{
					[1] = 0.7,
					[2] = 6.25,
				},
				[236] = 
				{
					[1] = 0.71,
					[2] = 6.26,
				},
				[237] = 
				{
					[1] = 0.71,
					[2] = 6.27,
				},
				[238] = 
				{
					[1] = 0.71,
					[2] = 6.27,
				},
				[239] = 
				{
					[1] = 0.71,
					[2] = 6.28,
				},
				[240] = 
				{
					[1] = 0.72,
					[2] = 6.29,
				},
				[241] = 
				{
					[1] = 0.72,
					[2] = 6.29,
				},
				[242] = 
				{
					[1] = 0.72,
					[2] = 6.3,
				},
				[243] = 
				{
					[1] = 0.73,
					[2] = 6.3,
				},
				[244] = 
				{
					[1] = 0.73,
					[2] = 6.31,
				},
				[245] = 
				{
					[1] = 0.73,
					[2] = 6.31,
				},
				[246] = 
				{
					[1] = 0.74,
					[2] = 6.32,
				},
				[247] = 
				{
					[1] = 0.74,
					[2] = 6.33,
				},
				[248] = 
				{
					[1] = 0.74,
					[2] = 6.33,
				},
				[249] = 
				{
					[1] = 0.74,
					[2] = 6.34,
				},
				[250] = 
				{
					[1] = 0.75,
					[2] = 6.34,
				},
				[251] = 
				{
					[1] = 0.75,
					[2] = 6.35,
				},
				[252] = 
				{
					[1] = 0.75,
					[2] = 6.35,
				},
				[253] = 
				{
					[1] = 0.76,
					[2] = 6.36,
				},
				[254] = 
				{
					[1] = 0.76,
					[2] = 6.36,
				},
				[255] = 
				{
					[1] = 0.76,
					[2] = 6.36,
				},
				[256] = 
				{
					[1] = 0.77,
					[2] = 6.37,
				},
				[257] = 
				{
					[1] = 0.77,
					[2] = 6.37,
				},
				[258] = 
				{
					[1] = 0.77,
					[2] = 6.38,
				},
				[259] = 
				{
					[1] = 0.77,
					[2] = 6.38,
				},
				[260] = 
				{
					[1] = 0.78,
					[2] = 6.38,
				},
				[261] = 
				{
					[1] = 0.78,
					[2] = 6.38,
				},
				[262] = 
				{
					[1] = 0.78,
					[2] = 6.39,
				},
				[263] = 
				{
					[1] = 0.79,
					[2] = 6.39,
				},
				[264] = 
				{
					[1] = 0.79,
					[2] = 6.39,
				},
				[265] = 
				{
					[1] = 0.79,
					[2] = 6.39,
				},
				[266] = 
				{
					[1] = 0.8,
					[2] = 6.4,
				},
				[267] = 
				{
					[1] = 0.8,
					[2] = 6.4,
				},
				[268] = 
				{
					[1] = 0.8,
					[2] = 6.4,
				},
				[269] = 
				{
					[1] = 0.8,
					[2] = 6.4,
				},
				[270] = 
				{
					[1] = 0.81,
					[2] = 6.4,
				},
				[271] = 
				{
					[1] = 0.81,
					[2] = 6.41,
				},
				[272] = 
				{
					[1] = 0.81,
					[2] = 6.41,
				},
				[273] = 
				{
					[1] = 0.82,
					[2] = 6.41,
				},
				[274] = 
				{
					[1] = 0.82,
					[2] = 6.41,
				},
				[275] = 
				{
					[1] = 0.82,
					[2] = 6.41,
				},
				[276] = 
				{
					[1] = 0.83,
					[2] = 6.41,
				},
				[277] = 
				{
					[1] = 0.83,
					[2] = 6.41,
				},
				[278] = 
				{
					[1] = 0.83,
					[2] = 6.41,
				},
				[279] = 
				{
					[1] = 0.83,
					[2] = 6.42,
				},
				[280] = 
				{
					[1] = 0.84,
					[2] = 6.42,
				},
				[281] = 
				{
					[1] = 0.84,
					[2] = 6.42,
				},
				[282] = 
				{
					[1] = 0.84,
					[2] = 6.42,
				},
				[283] = 
				{
					[1] = 0.85,
					[2] = 6.42,
				},
				[284] = 
				{
					[1] = 0.85,
					[2] = 6.42,
				},
				[285] = 
				{
					[1] = 0.85,
					[2] = 6.42,
				},
				[286] = 
				{
					[1] = 0.86,
					[2] = 6.42,
				},
				[287] = 
				{
					[1] = 0.86,
					[2] = 6.42,
				},
				[288] = 
				{
					[1] = 0.86,
					[2] = 6.42,
				},
				[289] = 
				{
					[1] = 0.86,
					[2] = 6.42,
				},
				[290] = 
				{
					[1] = 0.87,
					[2] = 6.42,
				},
				[291] = 
				{
					[1] = 0.87,
					[2] = 6.42,
				},
				[292] = 
				{
					[1] = 0.87,
					[2] = 6.42,
				},
				[293] = 
				{
					[1] = 0.88,
					[2] = 6.42,
				},
				[294] = 
				{
					[1] = 0.88,
					[2] = 6.42,
				},
				[295] = 
				{
					[1] = 0.88,
					[2] = 6.42,
				},
				[296] = 
				{
					[1] = 0.89,
					[2] = 6.42,
				},
				[297] = 
				{
					[1] = 0.89,
					[2] = 6.42,
				},
				[298] = 
				{
					[1] = 0.89,
					[2] = 6.42,
				},
				[299] = 
				{
					[1] = 0.89,
					[2] = 6.42,
				},
				[300] = 
				{
					[1] = 0.9,
					[2] = 6.42,
				},
				[301] = 
				{
					[1] = 0.9,
					[2] = 6.42,
				},
				[302] = 
				{
					[1] = 0.9,
					[2] = 6.41,
				},
				[303] = 
				{
					[1] = 0.91,
					[2] = 6.41,
				},
				[304] = 
				{
					[1] = 0.91,
					[2] = 6.41,
				},
				[305] = 
				{
					[1] = 0.91,
					[2] = 6.41,
				},
				[306] = 
				{
					[1] = 0.92,
					[2] = 6.41,
				},
				[307] = 
				{
					[1] = 0.92,
					[2] = 6.41,
				},
				[308] = 
				{
					[1] = 0.92,
					[2] = 6.41,
				},
				[309] = 
				{
					[1] = 0.92,
					[2] = 6.4,
				},
				[310] = 
				{
					[1] = 0.93,
					[2] = 6.4,
				},
				[311] = 
				{
					[1] = 0.93,
					[2] = 6.4,
				},
				[312] = 
				{
					[1] = 0.93,
					[2] = 6.4,
				},
				[313] = 
				{
					[1] = 0.94,
					[2] = 6.4,
				},
				[314] = 
				{
					[1] = 0.94,
					[2] = 6.39,
				},
				[315] = 
				{
					[1] = 0.94,
					[2] = 6.39,
				},
				[316] = 
				{
					[1] = 0.95,
					[2] = 6.39,
				},
				[317] = 
				{
					[1] = 0.95,
					[2] = 6.39,
				},
				[318] = 
				{
					[1] = 0.95,
					[2] = 6.38,
				},
				[319] = 
				{
					[1] = 0.95,
					[2] = 6.38,
				},
				[320] = 
				{
					[1] = 0.96,
					[2] = 6.38,
				},
				[321] = 
				{
					[1] = 0.96,
					[2] = 6.38,
				},
				[322] = 
				{
					[1] = 0.96,
					[2] = 6.37,
				},
				[323] = 
				{
					[1] = 0.97,
					[2] = 6.37,
				},
				[324] = 
				{
					[1] = 0.97,
					[2] = 6.37,
				},
				[325] = 
				{
					[1] = 0.97,
					[2] = 6.36,
				},
				[326] = 
				{
					[1] = 0.98,
					[2] = 6.36,
				},
				[327] = 
				{
					[1] = 0.98,
					[2] = 6.36,
				},
				[328] = 
				{
					[1] = 0.98,
					[2] = 6.35,
				},
				[329] = 
				{
					[1] = 0.98,
					[2] = 6.35,
				},
				[330] = 
				{
					[1] = 0.99,
					[2] = 6.35,
				},
				[331] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[332] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[333] = 
				{
					[1] = 1,
					[2] = 6.34,
				},
			},
			["WidthScale"] = 0.75,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_hiryu",
		["Type"] = "WaterTracer",
	},
	[232] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 217.813889,
			["Lifetime"] = 21.17,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.017,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 313.396851,
			["Lifetime"] = 30.459999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 2.89,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 71.610046,
			["Lifetime"] = 6.96,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_hiryu",
		["Type"] = "WaterTracer",
	},
	[233] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 145.899994,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0343,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.71,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.97,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.2,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 1.44,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.68,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.91,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 2.15,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 2.41,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 2.66,
				},
				[11] = 
				{
					[1] = 0.07,
					[2] = 2.91,
				},
				[12] = 
				{
					[1] = 0.08,
					[2] = 3.16,
				},
				[13] = 
				{
					[1] = 0.08,
					[2] = 3.41,
				},
				[14] = 
				{
					[1] = 0.09,
					[2] = 3.67,
				},
				[15] = 
				{
					[1] = 0.1,
					[2] = 3.93,
				},
				[16] = 
				{
					[1] = 0.1,
					[2] = 4.19,
				},
				[17] = 
				{
					[1] = 0.11,
					[2] = 4.44,
				},
				[18] = 
				{
					[1] = 0.12,
					[2] = 4.7,
				},
				[19] = 
				{
					[1] = 0.12,
					[2] = 4.96,
				},
				[20] = 
				{
					[1] = 0.13,
					[2] = 5.22,
				},
				[21] = 
				{
					[1] = 0.14,
					[2] = 5.47,
				},
				[22] = 
				{
					[1] = 0.14,
					[2] = 5.66,
				},
				[23] = 
				{
					[1] = 0.15,
					[2] = 5.86,
				},
				[24] = 
				{
					[1] = 0.16,
					[2] = 6.06,
				},
				[25] = 
				{
					[1] = 0.16,
					[2] = 6.27,
				},
				[26] = 
				{
					[1] = 0.17,
					[2] = 6.47,
				},
				[27] = 
				{
					[1] = 0.18,
					[2] = 6.67,
				},
				[28] = 
				{
					[1] = 0.18,
					[2] = 6.87,
				},
				[29] = 
				{
					[1] = 0.19,
					[2] = 7.08,
				},
				[30] = 
				{
					[1] = 0.2,
					[2] = 7.28,
				},
				[31] = 
				{
					[1] = 0.21,
					[2] = 7.45,
				},
				[32] = 
				{
					[1] = 0.21,
					[2] = 7.61,
				},
				[33] = 
				{
					[1] = 0.22,
					[2] = 7.76,
				},
				[34] = 
				{
					[1] = 0.23,
					[2] = 7.91,
				},
				[35] = 
				{
					[1] = 0.23,
					[2] = 8.07,
				},
				[36] = 
				{
					[1] = 0.24,
					[2] = 8.22,
				},
				[37] = 
				{
					[1] = 0.25,
					[2] = 8.38,
				},
				[38] = 
				{
					[1] = 0.25,
					[2] = 8.53,
				},
				[39] = 
				{
					[1] = 0.26,
					[2] = 8.69,
				},
				[40] = 
				{
					[1] = 0.27,
					[2] = 8.8,
				},
				[41] = 
				{
					[1] = 0.27,
					[2] = 8.9,
				},
				[42] = 
				{
					[1] = 0.28,
					[2] = 8.99,
				},
				[43] = 
				{
					[1] = 0.29,
					[2] = 9.08,
				},
				[44] = 
				{
					[1] = 0.29,
					[2] = 9.18,
				},
				[45] = 
				{
					[1] = 0.3,
					[2] = 9.27,
				},
				[46] = 
				{
					[1] = 0.31,
					[2] = 9.36,
				},
				[47] = 
				{
					[1] = 0.32,
					[2] = 9.46,
				},
				[48] = 
				{
					[1] = 0.32,
					[2] = 9.55,
				},
				[49] = 
				{
					[1] = 0.33,
					[2] = 9.61,
				},
				[50] = 
				{
					[1] = 0.34,
					[2] = 9.65,
				},
				[51] = 
				{
					[1] = 0.34,
					[2] = 9.69,
				},
				[52] = 
				{
					[1] = 0.35,
					[2] = 9.73,
				},
				[53] = 
				{
					[1] = 0.36,
					[2] = 9.77,
				},
				[54] = 
				{
					[1] = 0.36,
					[2] = 9.81,
				},
				[55] = 
				{
					[1] = 0.37,
					[2] = 9.85,
				},
				[56] = 
				{
					[1] = 0.38,
					[2] = 9.88,
				},
				[57] = 
				{
					[1] = 0.38,
					[2] = 9.92,
				},
				[58] = 
				{
					[1] = 0.39,
					[2] = 9.94,
				},
				[59] = 
				{
					[1] = 0.4,
					[2] = 9.94,
				},
				[60] = 
				{
					[1] = 0.4,
					[2] = 9.94,
				},
				[61] = 
				{
					[1] = 0.41,
					[2] = 9.94,
				},
				[62] = 
				{
					[1] = 0.42,
					[2] = 9.94,
				},
				[63] = 
				{
					[1] = 0.42,
					[2] = 9.94,
				},
				[64] = 
				{
					[1] = 0.43,
					[2] = 9.94,
				},
				[65] = 
				{
					[1] = 0.44,
					[2] = 9.94,
				},
				[66] = 
				{
					[1] = 0.45,
					[2] = 9.94,
				},
				[67] = 
				{
					[1] = 0.45,
					[2] = 9.94,
				},
				[68] = 
				{
					[1] = 0.46,
					[2] = 9.94,
				},
				[69] = 
				{
					[1] = 0.47,
					[2] = 9.94,
				},
				[70] = 
				{
					[1] = 0.47,
					[2] = 9.94,
				},
				[71] = 
				{
					[1] = 0.48,
					[2] = 9.94,
				},
				[72] = 
				{
					[1] = 0.49,
					[2] = 9.94,
				},
				[73] = 
				{
					[1] = 0.49,
					[2] = 9.94,
				},
				[74] = 
				{
					[1] = 0.5,
					[2] = 9.94,
				},
				[75] = 
				{
					[1] = 0.51,
					[2] = 9.94,
				},
				[76] = 
				{
					[1] = 0.51,
					[2] = 9.94,
				},
				[77] = 
				{
					[1] = 0.52,
					[2] = 9.94,
				},
				[78] = 
				{
					[1] = 0.53,
					[2] = 9.94,
				},
				[79] = 
				{
					[1] = 0.53,
					[2] = 9.94,
				},
				[80] = 
				{
					[1] = 0.54,
					[2] = 9.94,
				},
				[81] = 
				{
					[1] = 0.55,
					[2] = 9.94,
				},
				[82] = 
				{
					[1] = 0.55,
					[2] = 9.94,
				},
				[83] = 
				{
					[1] = 0.56,
					[2] = 9.94,
				},
				[84] = 
				{
					[1] = 0.57,
					[2] = 9.94,
				},
				[85] = 
				{
					[1] = 0.58,
					[2] = 9.94,
				},
				[86] = 
				{
					[1] = 0.58,
					[2] = 9.94,
				},
				[87] = 
				{
					[1] = 0.59,
					[2] = 9.94,
				},
				[88] = 
				{
					[1] = 0.6,
					[2] = 9.94,
				},
				[89] = 
				{
					[1] = 0.6,
					[2] = 9.94,
				},
				[90] = 
				{
					[1] = 0.61,
					[2] = 9.94,
				},
				[91] = 
				{
					[1] = 0.62,
					[2] = 9.94,
				},
				[92] = 
				{
					[1] = 0.62,
					[2] = 9.94,
				},
				[93] = 
				{
					[1] = 0.63,
					[2] = 9.94,
				},
				[94] = 
				{
					[1] = 0.64,
					[2] = 9.92,
				},
				[95] = 
				{
					[1] = 0.64,
					[2] = 9.89,
				},
				[96] = 
				{
					[1] = 0.65,
					[2] = 9.86,
				},
				[97] = 
				{
					[1] = 0.66,
					[2] = 9.83,
				},
				[98] = 
				{
					[1] = 0.66,
					[2] = 9.8,
				},
				[99] = 
				{
					[1] = 0.67,
					[2] = 9.77,
				},
				[100] = 
				{
					[1] = 0.68,
					[2] = 9.75,
				},
				[101] = 
				{
					[1] = 0.68,
					[2] = 9.72,
				},
				[102] = 
				{
					[1] = 0.69,
					[2] = 9.69,
				},
				[103] = 
				{
					[1] = 0.7,
					[2] = 9.62,
				},
				[104] = 
				{
					[1] = 0.71,
					[2] = 9.54,
				},
				[105] = 
				{
					[1] = 0.71,
					[2] = 9.47,
				},
				[106] = 
				{
					[1] = 0.72,
					[2] = 9.39,
				},
				[107] = 
				{
					[1] = 0.73,
					[2] = 9.31,
				},
				[108] = 
				{
					[1] = 0.73,
					[2] = 9.24,
				},
				[109] = 
				{
					[1] = 0.74,
					[2] = 9.16,
				},
				[110] = 
				{
					[1] = 0.75,
					[2] = 9.08,
				},
				[111] = 
				{
					[1] = 0.75,
					[2] = 9,
				},
				[112] = 
				{
					[1] = 0.76,
					[2] = 8.93,
				},
				[113] = 
				{
					[1] = 0.77,
					[2] = 8.81,
				},
				[114] = 
				{
					[1] = 0.77,
					[2] = 8.7,
				},
				[115] = 
				{
					[1] = 0.78,
					[2] = 8.6,
				},
				[116] = 
				{
					[1] = 0.79,
					[2] = 8.49,
				},
				[117] = 
				{
					[1] = 0.79,
					[2] = 8.38,
				},
				[118] = 
				{
					[1] = 0.8,
					[2] = 8.28,
				},
				[119] = 
				{
					[1] = 0.81,
					[2] = 8.17,
				},
				[120] = 
				{
					[1] = 0.82,
					[2] = 8.06,
				},
				[121] = 
				{
					[1] = 0.82,
					[2] = 7.95,
				},
				[122] = 
				{
					[1] = 0.83,
					[2] = 7.83,
				},
				[123] = 
				{
					[1] = 0.84,
					[2] = 7.66,
				},
				[124] = 
				{
					[1] = 0.84,
					[2] = 7.5,
				},
				[125] = 
				{
					[1] = 0.85,
					[2] = 7.34,
				},
				[126] = 
				{
					[1] = 0.86,
					[2] = 7.18,
				},
				[127] = 
				{
					[1] = 0.86,
					[2] = 7.02,
				},
				[128] = 
				{
					[1] = 0.87,
					[2] = 6.86,
				},
				[129] = 
				{
					[1] = 0.88,
					[2] = 6.7,
				},
				[130] = 
				{
					[1] = 0.88,
					[2] = 6.54,
				},
				[131] = 
				{
					[1] = 0.89,
					[2] = 6.39,
				},
				[132] = 
				{
					[1] = 0.9,
					[2] = 6.11,
				},
				[133] = 
				{
					[1] = 0.9,
					[2] = 5.83,
				},
				[134] = 
				{
					[1] = 0.91,
					[2] = 5.55,
				},
				[135] = 
				{
					[1] = 0.92,
					[2] = 5.28,
				},
				[136] = 
				{
					[1] = 0.92,
					[2] = 5,
				},
				[137] = 
				{
					[1] = 0.93,
					[2] = 4.72,
				},
				[138] = 
				{
					[1] = 0.94,
					[2] = 4.44,
				},
				[139] = 
				{
					[1] = 0.95,
					[2] = 4.05,
				},
				[140] = 
				{
					[1] = 0.95,
					[2] = 3.61,
				},
				[141] = 
				{
					[1] = 0.96,
					[2] = 3.16,
				},
				[142] = 
				{
					[1] = 0.97,
					[2] = 2.72,
				},
				[143] = 
				{
					[1] = 0.97,
					[2] = 2.28,
				},
				[144] = 
				{
					[1] = 0.98,
					[2] = 1.83,
				},
				[145] = 
				{
					[1] = 0.99,
					[2] = 1.39,
				},
				[146] = 
				{
					[1] = 0.99,
					[2] = 0.92,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.86,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.25,
				},
				[3] = 
				{
					[1] = 0.06,
					[2] = 0.34,
				},
				[4] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[5] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[6] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[7] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[8] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[10] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[15] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[16] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[17] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[18] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[19] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[20] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[21] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[22] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[23] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[24] = 
				{
					[1] = 0.64,
					[2] = 0.3,
				},
				[25] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[26] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[27] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[28] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[29] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[30] = 
				{
					[1] = 0.81,
					[2] = 0.16,
				},
				[31] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[32] = 
				{
					[1] = 0.86,
					[2] = 0.11,
				},
				[33] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[34] = 
				{
					[1] = 0.92,
					[2] = 0.07,
				},
				[35] = 
				{
					[1] = 0.94,
					[2] = 0.04,
				},
				[36] = 
				{
					[1] = 0.97,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 13.88,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.93,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.98,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1.03,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.08,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 1.13,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.18,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.23,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 1.28,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 1.33,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 1.38,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 1.43,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 1.48,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 1.53,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 1.57,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 1.62,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 1.67,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 1.72,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 1.76,
				},
				[20] = 
				{
					[1] = 0.09,
					[2] = 1.8,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 1.84,
				},
				[22] = 
				{
					[1] = 0.1,
					[2] = 1.88,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 1.93,
				},
				[24] = 
				{
					[1] = 0.11,
					[2] = 1.97,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 2.01,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 2.05,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 2.09,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 2.13,
				},
				[29] = 
				{
					[1] = 0.13,
					[2] = 2.17,
				},
				[30] = 
				{
					[1] = 0.13,
					[2] = 2.21,
				},
				[31] = 
				{
					[1] = 0.14,
					[2] = 2.24,
				},
				[32] = 
				{
					[1] = 0.14,
					[2] = 2.28,
				},
				[33] = 
				{
					[1] = 0.15,
					[2] = 2.32,
				},
				[34] = 
				{
					[1] = 0.15,
					[2] = 2.36,
				},
				[35] = 
				{
					[1] = 0.16,
					[2] = 2.4,
				},
				[36] = 
				{
					[1] = 0.16,
					[2] = 2.44,
				},
				[37] = 
				{
					[1] = 0.16,
					[2] = 2.47,
				},
				[38] = 
				{
					[1] = 0.17,
					[2] = 2.51,
				},
				[39] = 
				{
					[1] = 0.17,
					[2] = 2.55,
				},
				[40] = 
				{
					[1] = 0.18,
					[2] = 2.59,
				},
				[41] = 
				{
					[1] = 0.18,
					[2] = 2.62,
				},
				[42] = 
				{
					[1] = 0.19,
					[2] = 2.66,
				},
				[43] = 
				{
					[1] = 0.19,
					[2] = 2.7,
				},
				[44] = 
				{
					[1] = 0.2,
					[2] = 2.73,
				},
				[45] = 
				{
					[1] = 0.2,
					[2] = 2.77,
				},
				[46] = 
				{
					[1] = 0.21,
					[2] = 2.81,
				},
				[47] = 
				{
					[1] = 0.21,
					[2] = 2.84,
				},
				[48] = 
				{
					[1] = 0.21,
					[2] = 2.88,
				},
				[49] = 
				{
					[1] = 0.22,
					[2] = 2.91,
				},
				[50] = 
				{
					[1] = 0.22,
					[2] = 2.95,
				},
				[51] = 
				{
					[1] = 0.23,
					[2] = 2.98,
				},
				[52] = 
				{
					[1] = 0.23,
					[2] = 3.02,
				},
				[53] = 
				{
					[1] = 0.24,
					[2] = 3.05,
				},
				[54] = 
				{
					[1] = 0.24,
					[2] = 3.08,
				},
				[55] = 
				{
					[1] = 0.25,
					[2] = 3.12,
				},
				[56] = 
				{
					[1] = 0.25,
					[2] = 3.15,
				},
				[57] = 
				{
					[1] = 0.26,
					[2] = 3.19,
				},
				[58] = 
				{
					[1] = 0.26,
					[2] = 3.22,
				},
				[59] = 
				{
					[1] = 0.26,
					[2] = 3.24,
				},
				[60] = 
				{
					[1] = 0.27,
					[2] = 3.26,
				},
				[61] = 
				{
					[1] = 0.27,
					[2] = 3.29,
				},
				[62] = 
				{
					[1] = 0.28,
					[2] = 3.32,
				},
				[63] = 
				{
					[1] = 0.28,
					[2] = 3.35,
				},
				[64] = 
				{
					[1] = 0.29,
					[2] = 3.39,
				},
				[65] = 
				{
					[1] = 0.29,
					[2] = 3.42,
				},
				[66] = 
				{
					[1] = 0.3,
					[2] = 3.46,
				},
				[67] = 
				{
					[1] = 0.3,
					[2] = 3.49,
				},
				[68] = 
				{
					[1] = 0.31,
					[2] = 3.52,
				},
				[69] = 
				{
					[1] = 0.31,
					[2] = 3.56,
				},
				[70] = 
				{
					[1] = 0.32,
					[2] = 3.59,
				},
				[71] = 
				{
					[1] = 0.32,
					[2] = 3.62,
				},
				[72] = 
				{
					[1] = 0.32,
					[2] = 3.65,
				},
				[73] = 
				{
					[1] = 0.33,
					[2] = 3.69,
				},
				[74] = 
				{
					[1] = 0.33,
					[2] = 3.72,
				},
				[75] = 
				{
					[1] = 0.34,
					[2] = 3.75,
				},
				[76] = 
				{
					[1] = 0.34,
					[2] = 3.78,
				},
				[77] = 
				{
					[1] = 0.35,
					[2] = 3.81,
				},
				[78] = 
				{
					[1] = 0.35,
					[2] = 3.84,
				},
				[79] = 
				{
					[1] = 0.36,
					[2] = 3.87,
				},
				[80] = 
				{
					[1] = 0.36,
					[2] = 3.9,
				},
				[81] = 
				{
					[1] = 0.37,
					[2] = 3.93,
				},
				[82] = 
				{
					[1] = 0.37,
					[2] = 3.96,
				},
				[83] = 
				{
					[1] = 0.37,
					[2] = 3.99,
				},
				[84] = 
				{
					[1] = 0.38,
					[2] = 4.02,
				},
				[85] = 
				{
					[1] = 0.38,
					[2] = 4.05,
				},
				[86] = 
				{
					[1] = 0.39,
					[2] = 4.08,
				},
				[87] = 
				{
					[1] = 0.39,
					[2] = 4.11,
				},
				[88] = 
				{
					[1] = 0.4,
					[2] = 4.14,
				},
				[89] = 
				{
					[1] = 0.4,
					[2] = 4.17,
				},
				[90] = 
				{
					[1] = 0.41,
					[2] = 4.2,
				},
				[91] = 
				{
					[1] = 0.41,
					[2] = 4.22,
				},
				[92] = 
				{
					[1] = 0.42,
					[2] = 4.25,
				},
				[93] = 
				{
					[1] = 0.42,
					[2] = 4.28,
				},
				[94] = 
				{
					[1] = 0.42,
					[2] = 4.31,
				},
				[95] = 
				{
					[1] = 0.43,
					[2] = 4.33,
				},
				[96] = 
				{
					[1] = 0.43,
					[2] = 4.36,
				},
				[97] = 
				{
					[1] = 0.44,
					[2] = 4.39,
				},
				[98] = 
				{
					[1] = 0.44,
					[2] = 4.41,
				},
				[99] = 
				{
					[1] = 0.45,
					[2] = 4.44,
				},
				[100] = 
				{
					[1] = 0.45,
					[2] = 4.47,
				},
				[101] = 
				{
					[1] = 0.46,
					[2] = 4.49,
				},
				[102] = 
				{
					[1] = 0.46,
					[2] = 4.52,
				},
				[103] = 
				{
					[1] = 0.47,
					[2] = 4.54,
				},
				[104] = 
				{
					[1] = 0.47,
					[2] = 4.57,
				},
				[105] = 
				{
					[1] = 0.47,
					[2] = 4.59,
				},
				[106] = 
				{
					[1] = 0.48,
					[2] = 4.62,
				},
				[107] = 
				{
					[1] = 0.48,
					[2] = 4.64,
				},
				[108] = 
				{
					[1] = 0.49,
					[2] = 4.67,
				},
				[109] = 
				{
					[1] = 0.49,
					[2] = 4.69,
				},
				[110] = 
				{
					[1] = 0.5,
					[2] = 4.71,
				},
				[111] = 
				{
					[1] = 0.5,
					[2] = 4.74,
				},
				[112] = 
				{
					[1] = 0.51,
					[2] = 4.76,
				},
				[113] = 
				{
					[1] = 0.51,
					[2] = 4.78,
				},
				[114] = 
				{
					[1] = 0.52,
					[2] = 4.8,
				},
				[115] = 
				{
					[1] = 0.52,
					[2] = 4.83,
				},
				[116] = 
				{
					[1] = 0.53,
					[2] = 4.85,
				},
				[117] = 
				{
					[1] = 0.53,
					[2] = 4.87,
				},
				[118] = 
				{
					[1] = 0.53,
					[2] = 4.89,
				},
				[119] = 
				{
					[1] = 0.54,
					[2] = 4.91,
				},
				[120] = 
				{
					[1] = 0.54,
					[2] = 4.94,
				},
				[121] = 
				{
					[1] = 0.55,
					[2] = 4.96,
				},
				[122] = 
				{
					[1] = 0.55,
					[2] = 4.98,
				},
				[123] = 
				{
					[1] = 0.56,
					[2] = 5,
				},
				[124] = 
				{
					[1] = 0.56,
					[2] = 5.02,
				},
				[125] = 
				{
					[1] = 0.57,
					[2] = 5.04,
				},
				[126] = 
				{
					[1] = 0.57,
					[2] = 5.06,
				},
				[127] = 
				{
					[1] = 0.58,
					[2] = 5.08,
				},
				[128] = 
				{
					[1] = 0.58,
					[2] = 5.1,
				},
				[129] = 
				{
					[1] = 0.58,
					[2] = 5.12,
				},
				[130] = 
				{
					[1] = 0.59,
					[2] = 5.14,
				},
				[131] = 
				{
					[1] = 0.59,
					[2] = 5.16,
				},
				[132] = 
				{
					[1] = 0.6,
					[2] = 5.18,
				},
				[133] = 
				{
					[1] = 0.6,
					[2] = 5.2,
				},
				[134] = 
				{
					[1] = 0.61,
					[2] = 5.22,
				},
				[135] = 
				{
					[1] = 0.61,
					[2] = 5.24,
				},
				[136] = 
				{
					[1] = 0.62,
					[2] = 5.26,
				},
				[137] = 
				{
					[1] = 0.62,
					[2] = 5.27,
				},
				[138] = 
				{
					[1] = 0.63,
					[2] = 5.29,
				},
				[139] = 
				{
					[1] = 0.63,
					[2] = 5.31,
				},
				[140] = 
				{
					[1] = 0.63,
					[2] = 5.33,
				},
				[141] = 
				{
					[1] = 0.64,
					[2] = 5.35,
				},
				[142] = 
				{
					[1] = 0.64,
					[2] = 5.36,
				},
				[143] = 
				{
					[1] = 0.65,
					[2] = 5.38,
				},
				[144] = 
				{
					[1] = 0.65,
					[2] = 5.4,
				},
				[145] = 
				{
					[1] = 0.66,
					[2] = 5.41,
				},
				[146] = 
				{
					[1] = 0.66,
					[2] = 5.43,
				},
				[147] = 
				{
					[1] = 0.67,
					[2] = 5.44,
				},
				[148] = 
				{
					[1] = 0.67,
					[2] = 5.46,
				},
				[149] = 
				{
					[1] = 0.68,
					[2] = 5.47,
				},
				[150] = 
				{
					[1] = 0.68,
					[2] = 5.49,
				},
				[151] = 
				{
					[1] = 0.68,
					[2] = 5.5,
				},
				[152] = 
				{
					[1] = 0.69,
					[2] = 5.52,
				},
				[153] = 
				{
					[1] = 0.69,
					[2] = 5.53,
				},
				[154] = 
				{
					[1] = 0.7,
					[2] = 5.55,
				},
				[155] = 
				{
					[1] = 0.7,
					[2] = 5.56,
				},
				[156] = 
				{
					[1] = 0.71,
					[2] = 5.58,
				},
				[157] = 
				{
					[1] = 0.71,
					[2] = 5.59,
				},
				[158] = 
				{
					[1] = 0.72,
					[2] = 5.6,
				},
				[159] = 
				{
					[1] = 0.72,
					[2] = 5.62,
				},
				[160] = 
				{
					[1] = 0.73,
					[2] = 5.63,
				},
				[161] = 
				{
					[1] = 0.73,
					[2] = 5.64,
				},
				[162] = 
				{
					[1] = 0.74,
					[2] = 5.65,
				},
				[163] = 
				{
					[1] = 0.74,
					[2] = 5.66,
				},
				[164] = 
				{
					[1] = 0.74,
					[2] = 5.68,
				},
				[165] = 
				{
					[1] = 0.75,
					[2] = 5.69,
				},
				[166] = 
				{
					[1] = 0.75,
					[2] = 5.7,
				},
				[167] = 
				{
					[1] = 0.76,
					[2] = 5.71,
				},
				[168] = 
				{
					[1] = 0.76,
					[2] = 5.72,
				},
				[169] = 
				{
					[1] = 0.77,
					[2] = 5.73,
				},
				[170] = 
				{
					[1] = 0.77,
					[2] = 5.74,
				},
				[171] = 
				{
					[1] = 0.78,
					[2] = 5.75,
				},
				[172] = 
				{
					[1] = 0.78,
					[2] = 5.76,
				},
				[173] = 
				{
					[1] = 0.79,
					[2] = 5.77,
				},
				[174] = 
				{
					[1] = 0.79,
					[2] = 5.78,
				},
				[175] = 
				{
					[1] = 0.79,
					[2] = 5.79,
				},
				[176] = 
				{
					[1] = 0.8,
					[2] = 5.8,
				},
				[177] = 
				{
					[1] = 0.8,
					[2] = 5.81,
				},
				[178] = 
				{
					[1] = 0.81,
					[2] = 5.82,
				},
				[179] = 
				{
					[1] = 0.81,
					[2] = 5.83,
				},
				[180] = 
				{
					[1] = 0.82,
					[2] = 5.83,
				},
				[181] = 
				{
					[1] = 0.82,
					[2] = 5.84,
				},
				[182] = 
				{
					[1] = 0.83,
					[2] = 5.85,
				},
				[183] = 
				{
					[1] = 0.83,
					[2] = 5.86,
				},
				[184] = 
				{
					[1] = 0.84,
					[2] = 5.86,
				},
				[185] = 
				{
					[1] = 0.84,
					[2] = 5.87,
				},
				[186] = 
				{
					[1] = 0.84,
					[2] = 5.88,
				},
				[187] = 
				{
					[1] = 0.85,
					[2] = 5.88,
				},
				[188] = 
				{
					[1] = 0.85,
					[2] = 5.89,
				},
				[189] = 
				{
					[1] = 0.86,
					[2] = 5.9,
				},
				[190] = 
				{
					[1] = 0.86,
					[2] = 5.9,
				},
				[191] = 
				{
					[1] = 0.87,
					[2] = 5.91,
				},
				[192] = 
				{
					[1] = 0.87,
					[2] = 5.91,
				},
				[193] = 
				{
					[1] = 0.88,
					[2] = 5.92,
				},
				[194] = 
				{
					[1] = 0.88,
					[2] = 5.92,
				},
				[195] = 
				{
					[1] = 0.89,
					[2] = 5.93,
				},
				[196] = 
				{
					[1] = 0.89,
					[2] = 5.93,
				},
				[197] = 
				{
					[1] = 0.89,
					[2] = 5.94,
				},
				[198] = 
				{
					[1] = 0.9,
					[2] = 5.94,
				},
				[199] = 
				{
					[1] = 0.9,
					[2] = 5.94,
				},
				[200] = 
				{
					[1] = 0.91,
					[2] = 5.94,
				},
				[201] = 
				{
					[1] = 0.91,
					[2] = 5.94,
				},
				[202] = 
				{
					[1] = 0.92,
					[2] = 5.94,
				},
				[203] = 
				{
					[1] = 0.92,
					[2] = 5.94,
				},
				[204] = 
				{
					[1] = 0.93,
					[2] = 5.93,
				},
				[205] = 
				{
					[1] = 0.93,
					[2] = 5.92,
				},
				[206] = 
				{
					[1] = 0.94,
					[2] = 5.91,
				},
				[207] = 
				{
					[1] = 0.94,
					[2] = 5.91,
				},
				[208] = 
				{
					[1] = 0.95,
					[2] = 5.9,
				},
				[209] = 
				{
					[1] = 0.95,
					[2] = 5.9,
				},
				[210] = 
				{
					[1] = 0.95,
					[2] = 5.89,
				},
				[211] = 
				{
					[1] = 0.96,
					[2] = 5.89,
				},
				[212] = 
				{
					[1] = 0.96,
					[2] = 5.89,
				},
				[213] = 
				{
					[1] = 0.97,
					[2] = 5.88,
				},
				[214] = 
				{
					[1] = 0.97,
					[2] = 5.88,
				},
				[215] = 
				{
					[1] = 0.98,
					[2] = 5.87,
				},
				[216] = 
				{
					[1] = 0.98,
					[2] = 5.86,
				},
				[217] = 
				{
					[1] = 0.99,
					[2] = 5.86,
				},
				[218] = 
				{
					[1] = 0.99,
					[2] = 5.85,
				},
				[219] = 
				{
					[1] = 1,
					[2] = 5.85,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Jap_cargo",
		["Type"] = "WaterTracer",
	},
	[234] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 152.603485,
			["Lifetime"] = 16.48,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0704,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0.6,
			["WidthScale"] = 2.97,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 211.033585,
			["Lifetime"] = 22.790001,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0881,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0.6,
			["WidthScale"] = 1.94,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 43.799423,
			["Lifetime"] = 4.73,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0881,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Jap_cargo",
		["Type"] = "WaterTracer",
	},
	[235] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 145.899994,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0343,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.71,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.97,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.2,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 1.44,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.68,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.91,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 2.15,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 2.41,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 2.66,
				},
				[11] = 
				{
					[1] = 0.07,
					[2] = 2.91,
				},
				[12] = 
				{
					[1] = 0.08,
					[2] = 3.16,
				},
				[13] = 
				{
					[1] = 0.08,
					[2] = 3.41,
				},
				[14] = 
				{
					[1] = 0.09,
					[2] = 3.67,
				},
				[15] = 
				{
					[1] = 0.1,
					[2] = 3.93,
				},
				[16] = 
				{
					[1] = 0.1,
					[2] = 4.19,
				},
				[17] = 
				{
					[1] = 0.11,
					[2] = 4.44,
				},
				[18] = 
				{
					[1] = 0.12,
					[2] = 4.7,
				},
				[19] = 
				{
					[1] = 0.12,
					[2] = 4.96,
				},
				[20] = 
				{
					[1] = 0.13,
					[2] = 5.22,
				},
				[21] = 
				{
					[1] = 0.14,
					[2] = 5.47,
				},
				[22] = 
				{
					[1] = 0.14,
					[2] = 5.66,
				},
				[23] = 
				{
					[1] = 0.15,
					[2] = 5.86,
				},
				[24] = 
				{
					[1] = 0.16,
					[2] = 6.06,
				},
				[25] = 
				{
					[1] = 0.16,
					[2] = 6.27,
				},
				[26] = 
				{
					[1] = 0.17,
					[2] = 6.47,
				},
				[27] = 
				{
					[1] = 0.18,
					[2] = 6.67,
				},
				[28] = 
				{
					[1] = 0.18,
					[2] = 6.87,
				},
				[29] = 
				{
					[1] = 0.19,
					[2] = 7.08,
				},
				[30] = 
				{
					[1] = 0.2,
					[2] = 7.28,
				},
				[31] = 
				{
					[1] = 0.21,
					[2] = 7.45,
				},
				[32] = 
				{
					[1] = 0.21,
					[2] = 7.61,
				},
				[33] = 
				{
					[1] = 0.22,
					[2] = 7.76,
				},
				[34] = 
				{
					[1] = 0.23,
					[2] = 7.91,
				},
				[35] = 
				{
					[1] = 0.23,
					[2] = 8.07,
				},
				[36] = 
				{
					[1] = 0.24,
					[2] = 8.22,
				},
				[37] = 
				{
					[1] = 0.25,
					[2] = 8.38,
				},
				[38] = 
				{
					[1] = 0.25,
					[2] = 8.53,
				},
				[39] = 
				{
					[1] = 0.26,
					[2] = 8.69,
				},
				[40] = 
				{
					[1] = 0.27,
					[2] = 8.8,
				},
				[41] = 
				{
					[1] = 0.27,
					[2] = 8.9,
				},
				[42] = 
				{
					[1] = 0.28,
					[2] = 8.99,
				},
				[43] = 
				{
					[1] = 0.29,
					[2] = 9.08,
				},
				[44] = 
				{
					[1] = 0.29,
					[2] = 9.18,
				},
				[45] = 
				{
					[1] = 0.3,
					[2] = 9.27,
				},
				[46] = 
				{
					[1] = 0.31,
					[2] = 9.36,
				},
				[47] = 
				{
					[1] = 0.32,
					[2] = 9.46,
				},
				[48] = 
				{
					[1] = 0.32,
					[2] = 9.55,
				},
				[49] = 
				{
					[1] = 0.33,
					[2] = 9.61,
				},
				[50] = 
				{
					[1] = 0.34,
					[2] = 9.65,
				},
				[51] = 
				{
					[1] = 0.34,
					[2] = 9.69,
				},
				[52] = 
				{
					[1] = 0.35,
					[2] = 9.73,
				},
				[53] = 
				{
					[1] = 0.36,
					[2] = 9.77,
				},
				[54] = 
				{
					[1] = 0.36,
					[2] = 9.81,
				},
				[55] = 
				{
					[1] = 0.37,
					[2] = 9.85,
				},
				[56] = 
				{
					[1] = 0.38,
					[2] = 9.88,
				},
				[57] = 
				{
					[1] = 0.38,
					[2] = 9.92,
				},
				[58] = 
				{
					[1] = 0.39,
					[2] = 9.94,
				},
				[59] = 
				{
					[1] = 0.4,
					[2] = 9.94,
				},
				[60] = 
				{
					[1] = 0.4,
					[2] = 9.94,
				},
				[61] = 
				{
					[1] = 0.41,
					[2] = 9.94,
				},
				[62] = 
				{
					[1] = 0.42,
					[2] = 9.94,
				},
				[63] = 
				{
					[1] = 0.42,
					[2] = 9.94,
				},
				[64] = 
				{
					[1] = 0.43,
					[2] = 9.94,
				},
				[65] = 
				{
					[1] = 0.44,
					[2] = 9.94,
				},
				[66] = 
				{
					[1] = 0.45,
					[2] = 9.94,
				},
				[67] = 
				{
					[1] = 0.45,
					[2] = 9.94,
				},
				[68] = 
				{
					[1] = 0.46,
					[2] = 9.94,
				},
				[69] = 
				{
					[1] = 0.47,
					[2] = 9.94,
				},
				[70] = 
				{
					[1] = 0.47,
					[2] = 9.94,
				},
				[71] = 
				{
					[1] = 0.48,
					[2] = 9.94,
				},
				[72] = 
				{
					[1] = 0.49,
					[2] = 9.94,
				},
				[73] = 
				{
					[1] = 0.49,
					[2] = 9.94,
				},
				[74] = 
				{
					[1] = 0.5,
					[2] = 9.94,
				},
				[75] = 
				{
					[1] = 0.51,
					[2] = 9.94,
				},
				[76] = 
				{
					[1] = 0.51,
					[2] = 9.94,
				},
				[77] = 
				{
					[1] = 0.52,
					[2] = 9.94,
				},
				[78] = 
				{
					[1] = 0.53,
					[2] = 9.94,
				},
				[79] = 
				{
					[1] = 0.53,
					[2] = 9.94,
				},
				[80] = 
				{
					[1] = 0.54,
					[2] = 9.94,
				},
				[81] = 
				{
					[1] = 0.55,
					[2] = 9.94,
				},
				[82] = 
				{
					[1] = 0.55,
					[2] = 9.94,
				},
				[83] = 
				{
					[1] = 0.56,
					[2] = 9.94,
				},
				[84] = 
				{
					[1] = 0.57,
					[2] = 9.94,
				},
				[85] = 
				{
					[1] = 0.58,
					[2] = 9.94,
				},
				[86] = 
				{
					[1] = 0.58,
					[2] = 9.94,
				},
				[87] = 
				{
					[1] = 0.59,
					[2] = 9.94,
				},
				[88] = 
				{
					[1] = 0.6,
					[2] = 9.94,
				},
				[89] = 
				{
					[1] = 0.6,
					[2] = 9.94,
				},
				[90] = 
				{
					[1] = 0.61,
					[2] = 9.94,
				},
				[91] = 
				{
					[1] = 0.62,
					[2] = 9.94,
				},
				[92] = 
				{
					[1] = 0.62,
					[2] = 9.94,
				},
				[93] = 
				{
					[1] = 0.63,
					[2] = 9.94,
				},
				[94] = 
				{
					[1] = 0.64,
					[2] = 9.92,
				},
				[95] = 
				{
					[1] = 0.64,
					[2] = 9.89,
				},
				[96] = 
				{
					[1] = 0.65,
					[2] = 9.86,
				},
				[97] = 
				{
					[1] = 0.66,
					[2] = 9.83,
				},
				[98] = 
				{
					[1] = 0.66,
					[2] = 9.8,
				},
				[99] = 
				{
					[1] = 0.67,
					[2] = 9.77,
				},
				[100] = 
				{
					[1] = 0.68,
					[2] = 9.75,
				},
				[101] = 
				{
					[1] = 0.68,
					[2] = 9.72,
				},
				[102] = 
				{
					[1] = 0.69,
					[2] = 9.69,
				},
				[103] = 
				{
					[1] = 0.7,
					[2] = 9.62,
				},
				[104] = 
				{
					[1] = 0.71,
					[2] = 9.54,
				},
				[105] = 
				{
					[1] = 0.71,
					[2] = 9.47,
				},
				[106] = 
				{
					[1] = 0.72,
					[2] = 9.39,
				},
				[107] = 
				{
					[1] = 0.73,
					[2] = 9.31,
				},
				[108] = 
				{
					[1] = 0.73,
					[2] = 9.24,
				},
				[109] = 
				{
					[1] = 0.74,
					[2] = 9.16,
				},
				[110] = 
				{
					[1] = 0.75,
					[2] = 9.08,
				},
				[111] = 
				{
					[1] = 0.75,
					[2] = 9,
				},
				[112] = 
				{
					[1] = 0.76,
					[2] = 8.93,
				},
				[113] = 
				{
					[1] = 0.77,
					[2] = 8.81,
				},
				[114] = 
				{
					[1] = 0.77,
					[2] = 8.7,
				},
				[115] = 
				{
					[1] = 0.78,
					[2] = 8.6,
				},
				[116] = 
				{
					[1] = 0.79,
					[2] = 8.49,
				},
				[117] = 
				{
					[1] = 0.79,
					[2] = 8.38,
				},
				[118] = 
				{
					[1] = 0.8,
					[2] = 8.28,
				},
				[119] = 
				{
					[1] = 0.81,
					[2] = 8.17,
				},
				[120] = 
				{
					[1] = 0.82,
					[2] = 8.06,
				},
				[121] = 
				{
					[1] = 0.82,
					[2] = 7.95,
				},
				[122] = 
				{
					[1] = 0.83,
					[2] = 7.83,
				},
				[123] = 
				{
					[1] = 0.84,
					[2] = 7.66,
				},
				[124] = 
				{
					[1] = 0.84,
					[2] = 7.5,
				},
				[125] = 
				{
					[1] = 0.85,
					[2] = 7.34,
				},
				[126] = 
				{
					[1] = 0.86,
					[2] = 7.18,
				},
				[127] = 
				{
					[1] = 0.86,
					[2] = 7.02,
				},
				[128] = 
				{
					[1] = 0.87,
					[2] = 6.86,
				},
				[129] = 
				{
					[1] = 0.88,
					[2] = 6.7,
				},
				[130] = 
				{
					[1] = 0.88,
					[2] = 6.54,
				},
				[131] = 
				{
					[1] = 0.89,
					[2] = 6.39,
				},
				[132] = 
				{
					[1] = 0.9,
					[2] = 6.11,
				},
				[133] = 
				{
					[1] = 0.9,
					[2] = 5.83,
				},
				[134] = 
				{
					[1] = 0.91,
					[2] = 5.55,
				},
				[135] = 
				{
					[1] = 0.92,
					[2] = 5.28,
				},
				[136] = 
				{
					[1] = 0.92,
					[2] = 5,
				},
				[137] = 
				{
					[1] = 0.93,
					[2] = 4.72,
				},
				[138] = 
				{
					[1] = 0.94,
					[2] = 4.44,
				},
				[139] = 
				{
					[1] = 0.95,
					[2] = 4.05,
				},
				[140] = 
				{
					[1] = 0.95,
					[2] = 3.61,
				},
				[141] = 
				{
					[1] = 0.96,
					[2] = 3.16,
				},
				[142] = 
				{
					[1] = 0.97,
					[2] = 2.72,
				},
				[143] = 
				{
					[1] = 0.97,
					[2] = 2.28,
				},
				[144] = 
				{
					[1] = 0.98,
					[2] = 1.83,
				},
				[145] = 
				{
					[1] = 0.99,
					[2] = 1.39,
				},
				[146] = 
				{
					[1] = 0.99,
					[2] = 0.92,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.25,
				},
				[3] = 
				{
					[1] = 0.06,
					[2] = 0.34,
				},
				[4] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[5] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[6] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[7] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[8] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[10] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[15] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[16] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[17] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[18] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[19] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[20] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[21] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[22] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[23] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[24] = 
				{
					[1] = 0.64,
					[2] = 0.3,
				},
				[25] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[26] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[27] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[28] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[29] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[30] = 
				{
					[1] = 0.81,
					[2] = 0.16,
				},
				[31] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[32] = 
				{
					[1] = 0.86,
					[2] = 0.11,
				},
				[33] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[34] = 
				{
					[1] = 0.92,
					[2] = 0.07,
				},
				[35] = 
				{
					[1] = 0.94,
					[2] = 0.04,
				},
				[36] = 
				{
					[1] = 0.97,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 13.88,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.93,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.98,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1.03,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.08,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 1.13,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.18,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.23,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 1.28,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 1.33,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 1.38,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 1.43,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 1.48,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 1.53,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 1.57,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 1.62,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 1.67,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 1.72,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 1.76,
				},
				[20] = 
				{
					[1] = 0.09,
					[2] = 1.8,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 1.84,
				},
				[22] = 
				{
					[1] = 0.1,
					[2] = 1.88,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 1.93,
				},
				[24] = 
				{
					[1] = 0.11,
					[2] = 1.97,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 2.01,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 2.05,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 2.09,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 2.13,
				},
				[29] = 
				{
					[1] = 0.13,
					[2] = 2.17,
				},
				[30] = 
				{
					[1] = 0.13,
					[2] = 2.21,
				},
				[31] = 
				{
					[1] = 0.14,
					[2] = 2.24,
				},
				[32] = 
				{
					[1] = 0.14,
					[2] = 2.28,
				},
				[33] = 
				{
					[1] = 0.15,
					[2] = 2.32,
				},
				[34] = 
				{
					[1] = 0.15,
					[2] = 2.36,
				},
				[35] = 
				{
					[1] = 0.16,
					[2] = 2.4,
				},
				[36] = 
				{
					[1] = 0.16,
					[2] = 2.44,
				},
				[37] = 
				{
					[1] = 0.16,
					[2] = 2.47,
				},
				[38] = 
				{
					[1] = 0.17,
					[2] = 2.51,
				},
				[39] = 
				{
					[1] = 0.17,
					[2] = 2.55,
				},
				[40] = 
				{
					[1] = 0.18,
					[2] = 2.59,
				},
				[41] = 
				{
					[1] = 0.18,
					[2] = 2.62,
				},
				[42] = 
				{
					[1] = 0.19,
					[2] = 2.66,
				},
				[43] = 
				{
					[1] = 0.19,
					[2] = 2.7,
				},
				[44] = 
				{
					[1] = 0.2,
					[2] = 2.73,
				},
				[45] = 
				{
					[1] = 0.2,
					[2] = 2.77,
				},
				[46] = 
				{
					[1] = 0.21,
					[2] = 2.81,
				},
				[47] = 
				{
					[1] = 0.21,
					[2] = 2.84,
				},
				[48] = 
				{
					[1] = 0.21,
					[2] = 2.88,
				},
				[49] = 
				{
					[1] = 0.22,
					[2] = 2.91,
				},
				[50] = 
				{
					[1] = 0.22,
					[2] = 2.95,
				},
				[51] = 
				{
					[1] = 0.23,
					[2] = 2.98,
				},
				[52] = 
				{
					[1] = 0.23,
					[2] = 3.02,
				},
				[53] = 
				{
					[1] = 0.24,
					[2] = 3.05,
				},
				[54] = 
				{
					[1] = 0.24,
					[2] = 3.08,
				},
				[55] = 
				{
					[1] = 0.25,
					[2] = 3.12,
				},
				[56] = 
				{
					[1] = 0.25,
					[2] = 3.15,
				},
				[57] = 
				{
					[1] = 0.26,
					[2] = 3.19,
				},
				[58] = 
				{
					[1] = 0.26,
					[2] = 3.22,
				},
				[59] = 
				{
					[1] = 0.26,
					[2] = 3.24,
				},
				[60] = 
				{
					[1] = 0.27,
					[2] = 3.26,
				},
				[61] = 
				{
					[1] = 0.27,
					[2] = 3.29,
				},
				[62] = 
				{
					[1] = 0.28,
					[2] = 3.32,
				},
				[63] = 
				{
					[1] = 0.28,
					[2] = 3.35,
				},
				[64] = 
				{
					[1] = 0.29,
					[2] = 3.39,
				},
				[65] = 
				{
					[1] = 0.29,
					[2] = 3.42,
				},
				[66] = 
				{
					[1] = 0.3,
					[2] = 3.46,
				},
				[67] = 
				{
					[1] = 0.3,
					[2] = 3.49,
				},
				[68] = 
				{
					[1] = 0.31,
					[2] = 3.52,
				},
				[69] = 
				{
					[1] = 0.31,
					[2] = 3.56,
				},
				[70] = 
				{
					[1] = 0.32,
					[2] = 3.59,
				},
				[71] = 
				{
					[1] = 0.32,
					[2] = 3.62,
				},
				[72] = 
				{
					[1] = 0.32,
					[2] = 3.65,
				},
				[73] = 
				{
					[1] = 0.33,
					[2] = 3.69,
				},
				[74] = 
				{
					[1] = 0.33,
					[2] = 3.72,
				},
				[75] = 
				{
					[1] = 0.34,
					[2] = 3.75,
				},
				[76] = 
				{
					[1] = 0.34,
					[2] = 3.78,
				},
				[77] = 
				{
					[1] = 0.35,
					[2] = 3.81,
				},
				[78] = 
				{
					[1] = 0.35,
					[2] = 3.84,
				},
				[79] = 
				{
					[1] = 0.36,
					[2] = 3.87,
				},
				[80] = 
				{
					[1] = 0.36,
					[2] = 3.9,
				},
				[81] = 
				{
					[1] = 0.37,
					[2] = 3.93,
				},
				[82] = 
				{
					[1] = 0.37,
					[2] = 3.96,
				},
				[83] = 
				{
					[1] = 0.37,
					[2] = 3.99,
				},
				[84] = 
				{
					[1] = 0.38,
					[2] = 4.02,
				},
				[85] = 
				{
					[1] = 0.38,
					[2] = 4.05,
				},
				[86] = 
				{
					[1] = 0.39,
					[2] = 4.08,
				},
				[87] = 
				{
					[1] = 0.39,
					[2] = 4.11,
				},
				[88] = 
				{
					[1] = 0.4,
					[2] = 4.14,
				},
				[89] = 
				{
					[1] = 0.4,
					[2] = 4.17,
				},
				[90] = 
				{
					[1] = 0.41,
					[2] = 4.2,
				},
				[91] = 
				{
					[1] = 0.41,
					[2] = 4.22,
				},
				[92] = 
				{
					[1] = 0.42,
					[2] = 4.25,
				},
				[93] = 
				{
					[1] = 0.42,
					[2] = 4.28,
				},
				[94] = 
				{
					[1] = 0.42,
					[2] = 4.31,
				},
				[95] = 
				{
					[1] = 0.43,
					[2] = 4.33,
				},
				[96] = 
				{
					[1] = 0.43,
					[2] = 4.36,
				},
				[97] = 
				{
					[1] = 0.44,
					[2] = 4.39,
				},
				[98] = 
				{
					[1] = 0.44,
					[2] = 4.41,
				},
				[99] = 
				{
					[1] = 0.45,
					[2] = 4.44,
				},
				[100] = 
				{
					[1] = 0.45,
					[2] = 4.47,
				},
				[101] = 
				{
					[1] = 0.46,
					[2] = 4.49,
				},
				[102] = 
				{
					[1] = 0.46,
					[2] = 4.52,
				},
				[103] = 
				{
					[1] = 0.47,
					[2] = 4.54,
				},
				[104] = 
				{
					[1] = 0.47,
					[2] = 4.57,
				},
				[105] = 
				{
					[1] = 0.47,
					[2] = 4.59,
				},
				[106] = 
				{
					[1] = 0.48,
					[2] = 4.62,
				},
				[107] = 
				{
					[1] = 0.48,
					[2] = 4.64,
				},
				[108] = 
				{
					[1] = 0.49,
					[2] = 4.67,
				},
				[109] = 
				{
					[1] = 0.49,
					[2] = 4.69,
				},
				[110] = 
				{
					[1] = 0.5,
					[2] = 4.71,
				},
				[111] = 
				{
					[1] = 0.5,
					[2] = 4.74,
				},
				[112] = 
				{
					[1] = 0.51,
					[2] = 4.76,
				},
				[113] = 
				{
					[1] = 0.51,
					[2] = 4.78,
				},
				[114] = 
				{
					[1] = 0.52,
					[2] = 4.8,
				},
				[115] = 
				{
					[1] = 0.52,
					[2] = 4.83,
				},
				[116] = 
				{
					[1] = 0.53,
					[2] = 4.85,
				},
				[117] = 
				{
					[1] = 0.53,
					[2] = 4.87,
				},
				[118] = 
				{
					[1] = 0.53,
					[2] = 4.89,
				},
				[119] = 
				{
					[1] = 0.54,
					[2] = 4.91,
				},
				[120] = 
				{
					[1] = 0.54,
					[2] = 4.94,
				},
				[121] = 
				{
					[1] = 0.55,
					[2] = 4.96,
				},
				[122] = 
				{
					[1] = 0.55,
					[2] = 4.98,
				},
				[123] = 
				{
					[1] = 0.56,
					[2] = 5,
				},
				[124] = 
				{
					[1] = 0.56,
					[2] = 5.02,
				},
				[125] = 
				{
					[1] = 0.57,
					[2] = 5.04,
				},
				[126] = 
				{
					[1] = 0.57,
					[2] = 5.06,
				},
				[127] = 
				{
					[1] = 0.58,
					[2] = 5.08,
				},
				[128] = 
				{
					[1] = 0.58,
					[2] = 5.1,
				},
				[129] = 
				{
					[1] = 0.58,
					[2] = 5.12,
				},
				[130] = 
				{
					[1] = 0.59,
					[2] = 5.14,
				},
				[131] = 
				{
					[1] = 0.59,
					[2] = 5.16,
				},
				[132] = 
				{
					[1] = 0.6,
					[2] = 5.18,
				},
				[133] = 
				{
					[1] = 0.6,
					[2] = 5.2,
				},
				[134] = 
				{
					[1] = 0.61,
					[2] = 5.22,
				},
				[135] = 
				{
					[1] = 0.61,
					[2] = 5.24,
				},
				[136] = 
				{
					[1] = 0.62,
					[2] = 5.26,
				},
				[137] = 
				{
					[1] = 0.62,
					[2] = 5.27,
				},
				[138] = 
				{
					[1] = 0.63,
					[2] = 5.29,
				},
				[139] = 
				{
					[1] = 0.63,
					[2] = 5.31,
				},
				[140] = 
				{
					[1] = 0.63,
					[2] = 5.33,
				},
				[141] = 
				{
					[1] = 0.64,
					[2] = 5.35,
				},
				[142] = 
				{
					[1] = 0.64,
					[2] = 5.36,
				},
				[143] = 
				{
					[1] = 0.65,
					[2] = 5.38,
				},
				[144] = 
				{
					[1] = 0.65,
					[2] = 5.4,
				},
				[145] = 
				{
					[1] = 0.66,
					[2] = 5.41,
				},
				[146] = 
				{
					[1] = 0.66,
					[2] = 5.43,
				},
				[147] = 
				{
					[1] = 0.67,
					[2] = 5.44,
				},
				[148] = 
				{
					[1] = 0.67,
					[2] = 5.46,
				},
				[149] = 
				{
					[1] = 0.68,
					[2] = 5.47,
				},
				[150] = 
				{
					[1] = 0.68,
					[2] = 5.49,
				},
				[151] = 
				{
					[1] = 0.68,
					[2] = 5.5,
				},
				[152] = 
				{
					[1] = 0.69,
					[2] = 5.52,
				},
				[153] = 
				{
					[1] = 0.69,
					[2] = 5.53,
				},
				[154] = 
				{
					[1] = 0.7,
					[2] = 5.55,
				},
				[155] = 
				{
					[1] = 0.7,
					[2] = 5.56,
				},
				[156] = 
				{
					[1] = 0.71,
					[2] = 5.58,
				},
				[157] = 
				{
					[1] = 0.71,
					[2] = 5.59,
				},
				[158] = 
				{
					[1] = 0.72,
					[2] = 5.6,
				},
				[159] = 
				{
					[1] = 0.72,
					[2] = 5.62,
				},
				[160] = 
				{
					[1] = 0.73,
					[2] = 5.63,
				},
				[161] = 
				{
					[1] = 0.73,
					[2] = 5.64,
				},
				[162] = 
				{
					[1] = 0.74,
					[2] = 5.65,
				},
				[163] = 
				{
					[1] = 0.74,
					[2] = 5.66,
				},
				[164] = 
				{
					[1] = 0.74,
					[2] = 5.68,
				},
				[165] = 
				{
					[1] = 0.75,
					[2] = 5.69,
				},
				[166] = 
				{
					[1] = 0.75,
					[2] = 5.7,
				},
				[167] = 
				{
					[1] = 0.76,
					[2] = 5.71,
				},
				[168] = 
				{
					[1] = 0.76,
					[2] = 5.72,
				},
				[169] = 
				{
					[1] = 0.77,
					[2] = 5.73,
				},
				[170] = 
				{
					[1] = 0.77,
					[2] = 5.74,
				},
				[171] = 
				{
					[1] = 0.78,
					[2] = 5.75,
				},
				[172] = 
				{
					[1] = 0.78,
					[2] = 5.76,
				},
				[173] = 
				{
					[1] = 0.79,
					[2] = 5.77,
				},
				[174] = 
				{
					[1] = 0.79,
					[2] = 5.78,
				},
				[175] = 
				{
					[1] = 0.79,
					[2] = 5.79,
				},
				[176] = 
				{
					[1] = 0.8,
					[2] = 5.8,
				},
				[177] = 
				{
					[1] = 0.8,
					[2] = 5.81,
				},
				[178] = 
				{
					[1] = 0.81,
					[2] = 5.82,
				},
				[179] = 
				{
					[1] = 0.81,
					[2] = 5.83,
				},
				[180] = 
				{
					[1] = 0.82,
					[2] = 5.83,
				},
				[181] = 
				{
					[1] = 0.82,
					[2] = 5.84,
				},
				[182] = 
				{
					[1] = 0.83,
					[2] = 5.85,
				},
				[183] = 
				{
					[1] = 0.83,
					[2] = 5.86,
				},
				[184] = 
				{
					[1] = 0.84,
					[2] = 5.86,
				},
				[185] = 
				{
					[1] = 0.84,
					[2] = 5.87,
				},
				[186] = 
				{
					[1] = 0.84,
					[2] = 5.88,
				},
				[187] = 
				{
					[1] = 0.85,
					[2] = 5.88,
				},
				[188] = 
				{
					[1] = 0.85,
					[2] = 5.89,
				},
				[189] = 
				{
					[1] = 0.86,
					[2] = 5.9,
				},
				[190] = 
				{
					[1] = 0.86,
					[2] = 5.9,
				},
				[191] = 
				{
					[1] = 0.87,
					[2] = 5.91,
				},
				[192] = 
				{
					[1] = 0.87,
					[2] = 5.91,
				},
				[193] = 
				{
					[1] = 0.88,
					[2] = 5.92,
				},
				[194] = 
				{
					[1] = 0.88,
					[2] = 5.92,
				},
				[195] = 
				{
					[1] = 0.89,
					[2] = 5.93,
				},
				[196] = 
				{
					[1] = 0.89,
					[2] = 5.93,
				},
				[197] = 
				{
					[1] = 0.89,
					[2] = 5.94,
				},
				[198] = 
				{
					[1] = 0.9,
					[2] = 5.94,
				},
				[199] = 
				{
					[1] = 0.9,
					[2] = 5.94,
				},
				[200] = 
				{
					[1] = 0.91,
					[2] = 5.94,
				},
				[201] = 
				{
					[1] = 0.91,
					[2] = 5.94,
				},
				[202] = 
				{
					[1] = 0.92,
					[2] = 5.94,
				},
				[203] = 
				{
					[1] = 0.92,
					[2] = 5.94,
				},
				[204] = 
				{
					[1] = 0.93,
					[2] = 5.93,
				},
				[205] = 
				{
					[1] = 0.93,
					[2] = 5.92,
				},
				[206] = 
				{
					[1] = 0.94,
					[2] = 5.91,
				},
				[207] = 
				{
					[1] = 0.94,
					[2] = 5.91,
				},
				[208] = 
				{
					[1] = 0.95,
					[2] = 5.9,
				},
				[209] = 
				{
					[1] = 0.95,
					[2] = 5.9,
				},
				[210] = 
				{
					[1] = 0.95,
					[2] = 5.89,
				},
				[211] = 
				{
					[1] = 0.96,
					[2] = 5.89,
				},
				[212] = 
				{
					[1] = 0.96,
					[2] = 5.89,
				},
				[213] = 
				{
					[1] = 0.97,
					[2] = 5.88,
				},
				[214] = 
				{
					[1] = 0.97,
					[2] = 5.88,
				},
				[215] = 
				{
					[1] = 0.98,
					[2] = 5.87,
				},
				[216] = 
				{
					[1] = 0.98,
					[2] = 5.86,
				},
				[217] = 
				{
					[1] = 0.99,
					[2] = 5.86,
				},
				[218] = 
				{
					[1] = 0.99,
					[2] = 5.85,
				},
				[219] = 
				{
					[1] = 1,
					[2] = 5.85,
				},
			},
			["WidthScale"] = 1.1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Jap_cargo_new",
		["Type"] = "WaterTracer",
	},
	[236] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 189.643158,
			["Lifetime"] = 20.48,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0704,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.37,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 248.073273,
			["Lifetime"] = 26.790001,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0881,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.04,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 43.799423,
			["Lifetime"] = 4.73,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0881,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Jap_cargo_new",
		["Type"] = "WaterTracer",
	},
	[237] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 36.400002,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1374,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.71,
				},
				[3] = 
				{
					[1] = 0.06,
					[2] = 1.14,
				},
				[4] = 
				{
					[1] = 0.08,
					[2] = 1.52,
				},
				[5] = 
				{
					[1] = 0.11,
					[2] = 1.81,
				},
				[6] = 
				{
					[1] = 0.14,
					[2] = 2,
				},
				[7] = 
				{
					[1] = 0.17,
					[2] = 2.12,
				},
				[8] = 
				{
					[1] = 0.19,
					[2] = 2.16,
				},
				[9] = 
				{
					[1] = 0.22,
					[2] = 2.2,
				},
				[10] = 
				{
					[1] = 0.25,
					[2] = 2.21,
				},
				[11] = 
				{
					[1] = 0.28,
					[2] = 2.21,
				},
				[12] = 
				{
					[1] = 0.31,
					[2] = 2.21,
				},
				[13] = 
				{
					[1] = 0.33,
					[2] = 2.21,
				},
				[14] = 
				{
					[1] = 0.36,
					[2] = 2.21,
				},
				[15] = 
				{
					[1] = 0.39,
					[2] = 2.23,
				},
				[16] = 
				{
					[1] = 0.42,
					[2] = 2.24,
				},
				[17] = 
				{
					[1] = 0.44,
					[2] = 2.25,
				},
				[18] = 
				{
					[1] = 0.47,
					[2] = 2.25,
				},
				[19] = 
				{
					[1] = 0.5,
					[2] = 2.26,
				},
				[20] = 
				{
					[1] = 0.53,
					[2] = 2.27,
				},
				[21] = 
				{
					[1] = 0.56,
					[2] = 2.26,
				},
				[22] = 
				{
					[1] = 0.58,
					[2] = 2.25,
				},
				[23] = 
				{
					[1] = 0.61,
					[2] = 2.24,
				},
				[24] = 
				{
					[1] = 0.64,
					[2] = 2.23,
				},
				[25] = 
				{
					[1] = 0.67,
					[2] = 2.19,
				},
				[26] = 
				{
					[1] = 0.69,
					[2] = 2.15,
				},
				[27] = 
				{
					[1] = 0.72,
					[2] = 2.11,
				},
				[28] = 
				{
					[1] = 0.75,
					[2] = 2.04,
				},
				[29] = 
				{
					[1] = 0.78,
					[2] = 1.96,
				},
				[30] = 
				{
					[1] = 0.81,
					[2] = 1.87,
				},
				[31] = 
				{
					[1] = 0.83,
					[2] = 1.84,
				},
				[32] = 
				{
					[1] = 0.86,
					[2] = 1.82,
				},
				[33] = 
				{
					[1] = 0.89,
					[2] = 1.79,
				},
				[34] = 
				{
					[1] = 0.92,
					[2] = 1.77,
				},
				[35] = 
				{
					[1] = 0.94,
					[2] = 1.74,
				},
				[36] = 
				{
					[1] = 0.97,
					[2] = 1.72,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 1.1,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[3] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[5] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[6] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[7] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[8] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[9] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 5,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.58,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.06,
					[2] = 0.75,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.83,
				},
				[6] = 
				{
					[1] = 0.09,
					[2] = 0.91,
				},
				[7] = 
				{
					[1] = 0.11,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.13,
					[2] = 1.07,
				},
				[9] = 
				{
					[1] = 0.15,
					[2] = 1.15,
				},
				[10] = 
				{
					[1] = 0.17,
					[2] = 1.22,
				},
				[11] = 
				{
					[1] = 0.19,
					[2] = 1.29,
				},
				[12] = 
				{
					[1] = 0.2,
					[2] = 1.37,
				},
				[13] = 
				{
					[1] = 0.22,
					[2] = 1.43,
				},
				[14] = 
				{
					[1] = 0.24,
					[2] = 1.49,
				},
				[15] = 
				{
					[1] = 0.26,
					[2] = 1.55,
				},
				[16] = 
				{
					[1] = 0.28,
					[2] = 1.61,
				},
				[17] = 
				{
					[1] = 0.3,
					[2] = 1.66,
				},
				[18] = 
				{
					[1] = 0.31,
					[2] = 1.71,
				},
				[19] = 
				{
					[1] = 0.33,
					[2] = 1.76,
				},
				[20] = 
				{
					[1] = 0.35,
					[2] = 1.81,
				},
				[21] = 
				{
					[1] = 0.37,
					[2] = 1.86,
				},
				[22] = 
				{
					[1] = 0.39,
					[2] = 1.91,
				},
				[23] = 
				{
					[1] = 0.41,
					[2] = 1.95,
				},
				[24] = 
				{
					[1] = 0.43,
					[2] = 2,
				},
				[25] = 
				{
					[1] = 0.44,
					[2] = 2.04,
				},
				[26] = 
				{
					[1] = 0.46,
					[2] = 2.08,
				},
				[27] = 
				{
					[1] = 0.48,
					[2] = 2.1,
				},
				[28] = 
				{
					[1] = 0.5,
					[2] = 2.13,
				},
				[29] = 
				{
					[1] = 0.52,
					[2] = 2.15,
				},
				[30] = 
				{
					[1] = 0.54,
					[2] = 2.17,
				},
				[31] = 
				{
					[1] = 0.56,
					[2] = 2.19,
				},
				[32] = 
				{
					[1] = 0.57,
					[2] = 2.21,
				},
				[33] = 
				{
					[1] = 0.59,
					[2] = 2.23,
				},
				[34] = 
				{
					[1] = 0.61,
					[2] = 2.25,
				},
				[35] = 
				{
					[1] = 0.63,
					[2] = 2.26,
				},
				[36] = 
				{
					[1] = 0.65,
					[2] = 2.28,
				},
				[37] = 
				{
					[1] = 0.67,
					[2] = 2.29,
				},
				[38] = 
				{
					[1] = 0.69,
					[2] = 2.29,
				},
				[39] = 
				{
					[1] = 0.7,
					[2] = 2.28,
				},
				[40] = 
				{
					[1] = 0.72,
					[2] = 2.28,
				},
				[41] = 
				{
					[1] = 0.74,
					[2] = 2.28,
				},
				[42] = 
				{
					[1] = 0.76,
					[2] = 2.27,
				},
				[43] = 
				{
					[1] = 0.78,
					[2] = 2.26,
				},
				[44] = 
				{
					[1] = 0.8,
					[2] = 2.26,
				},
				[45] = 
				{
					[1] = 0.81,
					[2] = 2.25,
				},
				[46] = 
				{
					[1] = 0.83,
					[2] = 2.24,
				},
				[47] = 
				{
					[1] = 0.85,
					[2] = 2.23,
				},
				[48] = 
				{
					[1] = 0.87,
					[2] = 2.21,
				},
				[49] = 
				{
					[1] = 0.89,
					[2] = 2.19,
				},
				[50] = 
				{
					[1] = 0.91,
					[2] = 2.17,
				},
				[51] = 
				{
					[1] = 0.93,
					[2] = 2.15,
				},
				[52] = 
				{
					[1] = 0.94,
					[2] = 2.13,
				},
				[53] = 
				{
					[1] = 0.96,
					[2] = 2.11,
				},
				[54] = 
				{
					[1] = 0.98,
					[2] = 2.09,
				},
			},
			["WidthScale"] = 1.2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Jap_PT",
		["Type"] = "WaterTracer",
	},
	[238] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 47.32848,
			["Lifetime"] = 4.6,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0966,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.73,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 61.83569,
			["Lifetime"] = 6.01,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1207,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.76,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 10.906128,
			["Lifetime"] = 1.06,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.1207,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.75,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Jap_PT",
		["Type"] = "WaterTracer",
	},
	[239] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 156,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0321,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 1.35,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.59,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.83,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 2.05,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 2.27,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 2.52,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 2.78,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 3.03,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 3.27,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 3.52,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 3.79,
				},
				[13] = 
				{
					[1] = 0.08,
					[2] = 4.06,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 4.34,
				},
				[15] = 
				{
					[1] = 0.09,
					[2] = 4.58,
				},
				[16] = 
				{
					[1] = 0.1,
					[2] = 4.82,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 5.07,
				},
				[18] = 
				{
					[1] = 0.11,
					[2] = 5.33,
				},
				[19] = 
				{
					[1] = 0.12,
					[2] = 5.58,
				},
				[20] = 
				{
					[1] = 0.12,
					[2] = 5.84,
				},
				[21] = 
				{
					[1] = 0.13,
					[2] = 6.09,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 6.35,
				},
				[23] = 
				{
					[1] = 0.14,
					[2] = 6.58,
				},
				[24] = 
				{
					[1] = 0.15,
					[2] = 6.77,
				},
				[25] = 
				{
					[1] = 0.15,
					[2] = 6.97,
				},
				[26] = 
				{
					[1] = 0.16,
					[2] = 7.16,
				},
				[27] = 
				{
					[1] = 0.17,
					[2] = 7.36,
				},
				[28] = 
				{
					[1] = 0.17,
					[2] = 7.56,
				},
				[29] = 
				{
					[1] = 0.18,
					[2] = 7.75,
				},
				[30] = 
				{
					[1] = 0.19,
					[2] = 7.95,
				},
				[31] = 
				{
					[1] = 0.19,
					[2] = 8.14,
				},
				[32] = 
				{
					[1] = 0.2,
					[2] = 8.34,
				},
				[33] = 
				{
					[1] = 0.21,
					[2] = 8.53,
				},
				[34] = 
				{
					[1] = 0.21,
					[2] = 8.7,
				},
				[35] = 
				{
					[1] = 0.22,
					[2] = 8.83,
				},
				[36] = 
				{
					[1] = 0.22,
					[2] = 8.93,
				},
				[37] = 
				{
					[1] = 0.23,
					[2] = 9.03,
				},
				[38] = 
				{
					[1] = 0.24,
					[2] = 9.13,
				},
				[39] = 
				{
					[1] = 0.24,
					[2] = 9.23,
				},
				[40] = 
				{
					[1] = 0.25,
					[2] = 9.33,
				},
				[41] = 
				{
					[1] = 0.26,
					[2] = 9.43,
				},
				[42] = 
				{
					[1] = 0.26,
					[2] = 9.53,
				},
				[43] = 
				{
					[1] = 0.27,
					[2] = 9.63,
				},
				[44] = 
				{
					[1] = 0.28,
					[2] = 9.73,
				},
				[45] = 
				{
					[1] = 0.28,
					[2] = 9.83,
				},
				[46] = 
				{
					[1] = 0.29,
					[2] = 9.93,
				},
				[47] = 
				{
					[1] = 0.29,
					[2] = 10.03,
				},
				[48] = 
				{
					[1] = 0.3,
					[2] = 10.13,
				},
				[49] = 
				{
					[1] = 0.31,
					[2] = 10.23,
				},
				[50] = 
				{
					[1] = 0.31,
					[2] = 10.33,
				},
				[51] = 
				{
					[1] = 0.32,
					[2] = 10.42,
				},
				[52] = 
				{
					[1] = 0.33,
					[2] = 10.51,
				},
				[53] = 
				{
					[1] = 0.33,
					[2] = 10.52,
				},
				[54] = 
				{
					[1] = 0.34,
					[2] = 10.52,
				},
				[55] = 
				{
					[1] = 0.35,
					[2] = 10.53,
				},
				[56] = 
				{
					[1] = 0.35,
					[2] = 10.54,
				},
				[57] = 
				{
					[1] = 0.36,
					[2] = 10.54,
				},
				[58] = 
				{
					[1] = 0.37,
					[2] = 10.55,
				},
				[59] = 
				{
					[1] = 0.37,
					[2] = 10.55,
				},
				[60] = 
				{
					[1] = 0.38,
					[2] = 10.56,
				},
				[61] = 
				{
					[1] = 0.38,
					[2] = 10.56,
				},
				[62] = 
				{
					[1] = 0.39,
					[2] = 10.57,
				},
				[63] = 
				{
					[1] = 0.4,
					[2] = 10.57,
				},
				[64] = 
				{
					[1] = 0.4,
					[2] = 10.58,
				},
				[65] = 
				{
					[1] = 0.41,
					[2] = 10.59,
				},
				[66] = 
				{
					[1] = 0.42,
					[2] = 10.59,
				},
				[67] = 
				{
					[1] = 0.42,
					[2] = 10.6,
				},
				[68] = 
				{
					[1] = 0.43,
					[2] = 10.6,
				},
				[69] = 
				{
					[1] = 0.44,
					[2] = 10.61,
				},
				[70] = 
				{
					[1] = 0.44,
					[2] = 10.61,
				},
				[71] = 
				{
					[1] = 0.45,
					[2] = 10.62,
				},
				[72] = 
				{
					[1] = 0.46,
					[2] = 10.63,
				},
				[73] = 
				{
					[1] = 0.46,
					[2] = 10.63,
				},
				[74] = 
				{
					[1] = 0.47,
					[2] = 10.64,
				},
				[75] = 
				{
					[1] = 0.47,
					[2] = 10.65,
				},
				[76] = 
				{
					[1] = 0.48,
					[2] = 10.65,
				},
				[77] = 
				{
					[1] = 0.49,
					[2] = 10.66,
				},
				[78] = 
				{
					[1] = 0.49,
					[2] = 10.66,
				},
				[79] = 
				{
					[1] = 0.5,
					[2] = 10.67,
				},
				[80] = 
				{
					[1] = 0.51,
					[2] = 10.67,
				},
				[81] = 
				{
					[1] = 0.51,
					[2] = 10.68,
				},
				[82] = 
				{
					[1] = 0.52,
					[2] = 10.68,
				},
				[83] = 
				{
					[1] = 0.53,
					[2] = 10.69,
				},
				[84] = 
				{
					[1] = 0.53,
					[2] = 10.69,
				},
				[85] = 
				{
					[1] = 0.54,
					[2] = 10.7,
				},
				[86] = 
				{
					[1] = 0.54,
					[2] = 10.7,
				},
				[87] = 
				{
					[1] = 0.55,
					[2] = 10.7,
				},
				[88] = 
				{
					[1] = 0.56,
					[2] = 10.7,
				},
				[89] = 
				{
					[1] = 0.56,
					[2] = 10.7,
				},
				[90] = 
				{
					[1] = 0.57,
					[2] = 10.7,
				},
				[91] = 
				{
					[1] = 0.58,
					[2] = 10.7,
				},
				[92] = 
				{
					[1] = 0.58,
					[2] = 10.7,
				},
				[93] = 
				{
					[1] = 0.59,
					[2] = 10.7,
				},
				[94] = 
				{
					[1] = 0.6,
					[2] = 10.7,
				},
				[95] = 
				{
					[1] = 0.6,
					[2] = 10.69,
				},
				[96] = 
				{
					[1] = 0.61,
					[2] = 10.69,
				},
				[97] = 
				{
					[1] = 0.62,
					[2] = 10.69,
				},
				[98] = 
				{
					[1] = 0.62,
					[2] = 10.69,
				},
				[99] = 
				{
					[1] = 0.63,
					[2] = 10.69,
				},
				[100] = 
				{
					[1] = 0.63,
					[2] = 10.69,
				},
				[101] = 
				{
					[1] = 0.64,
					[2] = 10.69,
				},
				[102] = 
				{
					[1] = 0.65,
					[2] = 10.68,
				},
				[103] = 
				{
					[1] = 0.65,
					[2] = 10.65,
				},
				[104] = 
				{
					[1] = 0.66,
					[2] = 10.61,
				},
				[105] = 
				{
					[1] = 0.67,
					[2] = 10.57,
				},
				[106] = 
				{
					[1] = 0.67,
					[2] = 10.53,
				},
				[107] = 
				{
					[1] = 0.68,
					[2] = 10.49,
				},
				[108] = 
				{
					[1] = 0.69,
					[2] = 10.46,
				},
				[109] = 
				{
					[1] = 0.69,
					[2] = 10.42,
				},
				[110] = 
				{
					[1] = 0.7,
					[2] = 10.38,
				},
				[111] = 
				{
					[1] = 0.71,
					[2] = 10.34,
				},
				[112] = 
				{
					[1] = 0.71,
					[2] = 10.31,
				},
				[113] = 
				{
					[1] = 0.72,
					[2] = 10.27,
				},
				[114] = 
				{
					[1] = 0.72,
					[2] = 10.23,
				},
				[115] = 
				{
					[1] = 0.73,
					[2] = 10.18,
				},
				[116] = 
				{
					[1] = 0.74,
					[2] = 10.12,
				},
				[117] = 
				{
					[1] = 0.74,
					[2] = 10.07,
				},
				[118] = 
				{
					[1] = 0.75,
					[2] = 10.03,
				},
				[119] = 
				{
					[1] = 0.76,
					[2] = 9.99,
				},
				[120] = 
				{
					[1] = 0.76,
					[2] = 9.94,
				},
				[121] = 
				{
					[1] = 0.77,
					[2] = 9.9,
				},
				[122] = 
				{
					[1] = 0.78,
					[2] = 9.84,
				},
				[123] = 
				{
					[1] = 0.78,
					[2] = 9.77,
				},
				[124] = 
				{
					[1] = 0.79,
					[2] = 9.72,
				},
				[125] = 
				{
					[1] = 0.79,
					[2] = 9.67,
				},
				[126] = 
				{
					[1] = 0.8,
					[2] = 9.61,
				},
				[127] = 
				{
					[1] = 0.81,
					[2] = 9.56,
				},
				[128] = 
				{
					[1] = 0.81,
					[2] = 9.51,
				},
				[129] = 
				{
					[1] = 0.82,
					[2] = 9.35,
				},
				[130] = 
				{
					[1] = 0.83,
					[2] = 9.16,
				},
				[131] = 
				{
					[1] = 0.83,
					[2] = 8.97,
				},
				[132] = 
				{
					[1] = 0.84,
					[2] = 8.79,
				},
				[133] = 
				{
					[1] = 0.85,
					[2] = 8.6,
				},
				[134] = 
				{
					[1] = 0.85,
					[2] = 8.41,
				},
				[135] = 
				{
					[1] = 0.86,
					[2] = 8.23,
				},
				[136] = 
				{
					[1] = 0.87,
					[2] = 8.04,
				},
				[137] = 
				{
					[1] = 0.87,
					[2] = 7.81,
				},
				[138] = 
				{
					[1] = 0.88,
					[2] = 7.54,
				},
				[139] = 
				{
					[1] = 0.88,
					[2] = 7.27,
				},
				[140] = 
				{
					[1] = 0.89,
					[2] = 7,
				},
				[141] = 
				{
					[1] = 0.9,
					[2] = 6.77,
				},
				[142] = 
				{
					[1] = 0.9,
					[2] = 6.59,
				},
				[143] = 
				{
					[1] = 0.91,
					[2] = 6.14,
				},
				[144] = 
				{
					[1] = 0.92,
					[2] = 5.84,
				},
				[145] = 
				{
					[1] = 0.92,
					[2] = 5.53,
				},
				[146] = 
				{
					[1] = 0.93,
					[2] = 5.22,
				},
				[147] = 
				{
					[1] = 0.94,
					[2] = 4.93,
				},
				[148] = 
				{
					[1] = 0.94,
					[2] = 4.64,
				},
				[149] = 
				{
					[1] = 0.95,
					[2] = 4.34,
				},
				[150] = 
				{
					[1] = 0.96,
					[2] = 3.85,
				},
				[151] = 
				{
					[1] = 0.96,
					[2] = 3.33,
				},
				[152] = 
				{
					[1] = 0.97,
					[2] = 2.81,
				},
				[153] = 
				{
					[1] = 0.97,
					[2] = 2.29,
				},
				[154] = 
				{
					[1] = 0.98,
					[2] = 1.26,
				},
				[155] = 
				{
					[1] = 0.99,
					[2] = 0.42,
				},
				[156] = 
				{
					[1] = 0.99,
					[2] = 0.42,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.2,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.24,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[4] = 
				{
					[1] = 0.08,
					[2] = 0.38,
				},
				[5] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[6] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[7] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[8] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.21,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[15] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[16] = 
				{
					[1] = 0.38,
					[2] = 0.46,
				},
				[17] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[18] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[19] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[20] = 
				{
					[1] = 0.49,
					[2] = 0.41,
				},
				[21] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[22] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[23] = 
				{
					[1] = 0.56,
					[2] = 0.35,
				},
				[24] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[25] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[26] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[27] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[28] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[29] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[30] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[31] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[32] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[33] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[34] = 
				{
					[1] = 0.85,
					[2] = 0.13,
				},
				[35] = 
				{
					[1] = 0.87,
					[2] = 0.1,
				},
				[36] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[37] = 
				{
					[1] = 0.92,
					[2] = 0.06,
				},
				[38] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[39] = 
				{
					[1] = 0.97,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 15.4,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 2.26,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 2.3,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 2.34,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 2.39,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 2.43,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 2.47,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 2.51,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 2.55,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 2.59,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 2.64,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 2.68,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 2.72,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 2.76,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 2.8,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 2.84,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 2.88,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 2.92,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 2.96,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 3,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 3.04,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 3.08,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 3.11,
				},
				[24] = 
				{
					[1] = 0.1,
					[2] = 3.15,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 3.19,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 3.23,
				},
				[27] = 
				{
					[1] = 0.11,
					[2] = 3.27,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 3.31,
				},
				[29] = 
				{
					[1] = 0.12,
					[2] = 3.34,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 3.38,
				},
				[31] = 
				{
					[1] = 0.13,
					[2] = 3.42,
				},
				[32] = 
				{
					[1] = 0.13,
					[2] = 3.45,
				},
				[33] = 
				{
					[1] = 0.14,
					[2] = 3.49,
				},
				[34] = 
				{
					[1] = 0.14,
					[2] = 3.53,
				},
				[35] = 
				{
					[1] = 0.15,
					[2] = 3.56,
				},
				[36] = 
				{
					[1] = 0.15,
					[2] = 3.6,
				},
				[37] = 
				{
					[1] = 0.15,
					[2] = 3.64,
				},
				[38] = 
				{
					[1] = 0.16,
					[2] = 3.67,
				},
				[39] = 
				{
					[1] = 0.16,
					[2] = 3.69,
				},
				[40] = 
				{
					[1] = 0.17,
					[2] = 3.72,
				},
				[41] = 
				{
					[1] = 0.17,
					[2] = 3.75,
				},
				[42] = 
				{
					[1] = 0.18,
					[2] = 3.78,
				},
				[43] = 
				{
					[1] = 0.18,
					[2] = 3.8,
				},
				[44] = 
				{
					[1] = 0.18,
					[2] = 3.83,
				},
				[45] = 
				{
					[1] = 0.19,
					[2] = 3.85,
				},
				[46] = 
				{
					[1] = 0.19,
					[2] = 3.88,
				},
				[47] = 
				{
					[1] = 0.2,
					[2] = 3.92,
				},
				[48] = 
				{
					[1] = 0.2,
					[2] = 3.95,
				},
				[49] = 
				{
					[1] = 0.21,
					[2] = 3.99,
				},
				[50] = 
				{
					[1] = 0.21,
					[2] = 4.02,
				},
				[51] = 
				{
					[1] = 0.21,
					[2] = 4.06,
				},
				[52] = 
				{
					[1] = 0.22,
					[2] = 4.09,
				},
				[53] = 
				{
					[1] = 0.22,
					[2] = 4.13,
				},
				[54] = 
				{
					[1] = 0.23,
					[2] = 4.16,
				},
				[55] = 
				{
					[1] = 0.23,
					[2] = 4.2,
				},
				[56] = 
				{
					[1] = 0.24,
					[2] = 4.23,
				},
				[57] = 
				{
					[1] = 0.24,
					[2] = 4.27,
				},
				[58] = 
				{
					[1] = 0.24,
					[2] = 4.3,
				},
				[59] = 
				{
					[1] = 0.25,
					[2] = 4.33,
				},
				[60] = 
				{
					[1] = 0.25,
					[2] = 4.37,
				},
				[61] = 
				{
					[1] = 0.26,
					[2] = 4.4,
				},
				[62] = 
				{
					[1] = 0.26,
					[2] = 4.43,
				},
				[63] = 
				{
					[1] = 0.26,
					[2] = 4.47,
				},
				[64] = 
				{
					[1] = 0.27,
					[2] = 4.5,
				},
				[65] = 
				{
					[1] = 0.27,
					[2] = 4.53,
				},
				[66] = 
				{
					[1] = 0.28,
					[2] = 4.56,
				},
				[67] = 
				{
					[1] = 0.28,
					[2] = 4.6,
				},
				[68] = 
				{
					[1] = 0.29,
					[2] = 4.63,
				},
				[69] = 
				{
					[1] = 0.29,
					[2] = 4.66,
				},
				[70] = 
				{
					[1] = 0.29,
					[2] = 4.69,
				},
				[71] = 
				{
					[1] = 0.3,
					[2] = 4.72,
				},
				[72] = 
				{
					[1] = 0.3,
					[2] = 4.75,
				},
				[73] = 
				{
					[1] = 0.31,
					[2] = 4.78,
				},
				[74] = 
				{
					[1] = 0.31,
					[2] = 4.81,
				},
				[75] = 
				{
					[1] = 0.32,
					[2] = 4.84,
				},
				[76] = 
				{
					[1] = 0.32,
					[2] = 4.87,
				},
				[77] = 
				{
					[1] = 0.32,
					[2] = 4.9,
				},
				[78] = 
				{
					[1] = 0.33,
					[2] = 4.93,
				},
				[79] = 
				{
					[1] = 0.33,
					[2] = 4.96,
				},
				[80] = 
				{
					[1] = 0.34,
					[2] = 4.99,
				},
				[81] = 
				{
					[1] = 0.34,
					[2] = 5.02,
				},
				[82] = 
				{
					[1] = 0.35,
					[2] = 5.05,
				},
				[83] = 
				{
					[1] = 0.35,
					[2] = 5.08,
				},
				[84] = 
				{
					[1] = 0.35,
					[2] = 5.11,
				},
				[85] = 
				{
					[1] = 0.36,
					[2] = 5.13,
				},
				[86] = 
				{
					[1] = 0.36,
					[2] = 5.16,
				},
				[87] = 
				{
					[1] = 0.37,
					[2] = 5.19,
				},
				[88] = 
				{
					[1] = 0.37,
					[2] = 5.22,
				},
				[89] = 
				{
					[1] = 0.38,
					[2] = 5.24,
				},
				[90] = 
				{
					[1] = 0.38,
					[2] = 5.26,
				},
				[91] = 
				{
					[1] = 0.38,
					[2] = 5.28,
				},
				[92] = 
				{
					[1] = 0.39,
					[2] = 5.29,
				},
				[93] = 
				{
					[1] = 0.39,
					[2] = 5.31,
				},
				[94] = 
				{
					[1] = 0.4,
					[2] = 5.33,
				},
				[95] = 
				{
					[1] = 0.4,
					[2] = 5.36,
				},
				[96] = 
				{
					[1] = 0.41,
					[2] = 5.39,
				},
				[97] = 
				{
					[1] = 0.41,
					[2] = 5.42,
				},
				[98] = 
				{
					[1] = 0.41,
					[2] = 5.45,
				},
				[99] = 
				{
					[1] = 0.42,
					[2] = 5.48,
				},
				[100] = 
				{
					[1] = 0.42,
					[2] = 5.51,
				},
				[101] = 
				{
					[1] = 0.43,
					[2] = 5.53,
				},
				[102] = 
				{
					[1] = 0.43,
					[2] = 5.56,
				},
				[103] = 
				{
					[1] = 0.44,
					[2] = 5.59,
				},
				[104] = 
				{
					[1] = 0.44,
					[2] = 5.62,
				},
				[105] = 
				{
					[1] = 0.44,
					[2] = 5.64,
				},
				[106] = 
				{
					[1] = 0.45,
					[2] = 5.67,
				},
				[107] = 
				{
					[1] = 0.45,
					[2] = 5.7,
				},
				[108] = 
				{
					[1] = 0.46,
					[2] = 5.72,
				},
				[109] = 
				{
					[1] = 0.46,
					[2] = 5.75,
				},
				[110] = 
				{
					[1] = 0.47,
					[2] = 5.77,
				},
				[111] = 
				{
					[1] = 0.47,
					[2] = 5.8,
				},
				[112] = 
				{
					[1] = 0.47,
					[2] = 5.83,
				},
				[113] = 
				{
					[1] = 0.48,
					[2] = 5.85,
				},
				[114] = 
				{
					[1] = 0.48,
					[2] = 5.88,
				},
				[115] = 
				{
					[1] = 0.49,
					[2] = 5.9,
				},
				[116] = 
				{
					[1] = 0.49,
					[2] = 5.92,
				},
				[117] = 
				{
					[1] = 0.5,
					[2] = 5.95,
				},
				[118] = 
				{
					[1] = 0.5,
					[2] = 5.97,
				},
				[119] = 
				{
					[1] = 0.5,
					[2] = 6,
				},
				[120] = 
				{
					[1] = 0.51,
					[2] = 6.02,
				},
				[121] = 
				{
					[1] = 0.51,
					[2] = 6.04,
				},
				[122] = 
				{
					[1] = 0.52,
					[2] = 6.07,
				},
				[123] = 
				{
					[1] = 0.52,
					[2] = 6.09,
				},
				[124] = 
				{
					[1] = 0.53,
					[2] = 6.11,
				},
				[125] = 
				{
					[1] = 0.53,
					[2] = 6.13,
				},
				[126] = 
				{
					[1] = 0.53,
					[2] = 6.16,
				},
				[127] = 
				{
					[1] = 0.54,
					[2] = 6.18,
				},
				[128] = 
				{
					[1] = 0.54,
					[2] = 6.2,
				},
				[129] = 
				{
					[1] = 0.55,
					[2] = 6.22,
				},
				[130] = 
				{
					[1] = 0.55,
					[2] = 6.24,
				},
				[131] = 
				{
					[1] = 0.56,
					[2] = 6.26,
				},
				[132] = 
				{
					[1] = 0.56,
					[2] = 6.28,
				},
				[133] = 
				{
					[1] = 0.56,
					[2] = 6.3,
				},
				[134] = 
				{
					[1] = 0.57,
					[2] = 6.32,
				},
				[135] = 
				{
					[1] = 0.57,
					[2] = 6.34,
				},
				[136] = 
				{
					[1] = 0.58,
					[2] = 6.36,
				},
				[137] = 
				{
					[1] = 0.58,
					[2] = 6.38,
				},
				[138] = 
				{
					[1] = 0.59,
					[2] = 6.4,
				},
				[139] = 
				{
					[1] = 0.59,
					[2] = 6.41,
				},
				[140] = 
				{
					[1] = 0.59,
					[2] = 6.42,
				},
				[141] = 
				{
					[1] = 0.6,
					[2] = 6.42,
				},
				[142] = 
				{
					[1] = 0.6,
					[2] = 6.43,
				},
				[143] = 
				{
					[1] = 0.61,
					[2] = 6.44,
				},
				[144] = 
				{
					[1] = 0.61,
					[2] = 6.44,
				},
				[145] = 
				{
					[1] = 0.62,
					[2] = 6.46,
				},
				[146] = 
				{
					[1] = 0.62,
					[2] = 6.48,
				},
				[147] = 
				{
					[1] = 0.62,
					[2] = 6.49,
				},
				[148] = 
				{
					[1] = 0.63,
					[2] = 6.51,
				},
				[149] = 
				{
					[1] = 0.63,
					[2] = 6.52,
				},
				[150] = 
				{
					[1] = 0.64,
					[2] = 6.53,
				},
				[151] = 
				{
					[1] = 0.64,
					[2] = 6.55,
				},
				[152] = 
				{
					[1] = 0.65,
					[2] = 6.56,
				},
				[153] = 
				{
					[1] = 0.65,
					[2] = 6.58,
				},
				[154] = 
				{
					[1] = 0.65,
					[2] = 6.59,
				},
				[155] = 
				{
					[1] = 0.66,
					[2] = 6.6,
				},
				[156] = 
				{
					[1] = 0.66,
					[2] = 6.62,
				},
				[157] = 
				{
					[1] = 0.67,
					[2] = 6.63,
				},
				[158] = 
				{
					[1] = 0.67,
					[2] = 6.64,
				},
				[159] = 
				{
					[1] = 0.68,
					[2] = 6.65,
				},
				[160] = 
				{
					[1] = 0.68,
					[2] = 6.67,
				},
				[161] = 
				{
					[1] = 0.68,
					[2] = 6.68,
				},
				[162] = 
				{
					[1] = 0.69,
					[2] = 6.69,
				},
				[163] = 
				{
					[1] = 0.69,
					[2] = 6.7,
				},
				[164] = 
				{
					[1] = 0.7,
					[2] = 6.71,
				},
				[165] = 
				{
					[1] = 0.7,
					[2] = 6.72,
				},
				[166] = 
				{
					[1] = 0.71,
					[2] = 6.74,
				},
				[167] = 
				{
					[1] = 0.71,
					[2] = 6.75,
				},
				[168] = 
				{
					[1] = 0.71,
					[2] = 6.76,
				},
				[169] = 
				{
					[1] = 0.72,
					[2] = 6.77,
				},
				[170] = 
				{
					[1] = 0.72,
					[2] = 6.78,
				},
				[171] = 
				{
					[1] = 0.73,
					[2] = 6.79,
				},
				[172] = 
				{
					[1] = 0.73,
					[2] = 6.8,
				},
				[173] = 
				{
					[1] = 0.74,
					[2] = 6.81,
				},
				[174] = 
				{
					[1] = 0.74,
					[2] = 6.81,
				},
				[175] = 
				{
					[1] = 0.74,
					[2] = 6.82,
				},
				[176] = 
				{
					[1] = 0.75,
					[2] = 6.83,
				},
				[177] = 
				{
					[1] = 0.75,
					[2] = 6.84,
				},
				[178] = 
				{
					[1] = 0.76,
					[2] = 6.85,
				},
				[179] = 
				{
					[1] = 0.76,
					[2] = 6.86,
				},
				[180] = 
				{
					[1] = 0.76,
					[2] = 6.87,
				},
				[181] = 
				{
					[1] = 0.77,
					[2] = 6.87,
				},
				[182] = 
				{
					[1] = 0.77,
					[2] = 6.88,
				},
				[183] = 
				{
					[1] = 0.78,
					[2] = 6.89,
				},
				[184] = 
				{
					[1] = 0.78,
					[2] = 6.89,
				},
				[185] = 
				{
					[1] = 0.79,
					[2] = 6.9,
				},
				[186] = 
				{
					[1] = 0.79,
					[2] = 6.91,
				},
				[187] = 
				{
					[1] = 0.79,
					[2] = 6.91,
				},
				[188] = 
				{
					[1] = 0.8,
					[2] = 6.92,
				},
				[189] = 
				{
					[1] = 0.8,
					[2] = 6.93,
				},
				[190] = 
				{
					[1] = 0.81,
					[2] = 6.93,
				},
				[191] = 
				{
					[1] = 0.81,
					[2] = 6.94,
				},
				[192] = 
				{
					[1] = 0.82,
					[2] = 6.94,
				},
				[193] = 
				{
					[1] = 0.82,
					[2] = 6.95,
				},
				[194] = 
				{
					[1] = 0.82,
					[2] = 6.95,
				},
				[195] = 
				{
					[1] = 0.83,
					[2] = 6.96,
				},
				[196] = 
				{
					[1] = 0.83,
					[2] = 6.96,
				},
				[197] = 
				{
					[1] = 0.84,
					[2] = 6.97,
				},
				[198] = 
				{
					[1] = 0.84,
					[2] = 6.97,
				},
				[199] = 
				{
					[1] = 0.85,
					[2] = 6.97,
				},
				[200] = 
				{
					[1] = 0.85,
					[2] = 6.98,
				},
				[201] = 
				{
					[1] = 0.85,
					[2] = 6.98,
				},
				[202] = 
				{
					[1] = 0.86,
					[2] = 6.98,
				},
				[203] = 
				{
					[1] = 0.86,
					[2] = 6.99,
				},
				[204] = 
				{
					[1] = 0.87,
					[2] = 6.99,
				},
				[205] = 
				{
					[1] = 0.87,
					[2] = 6.99,
				},
				[206] = 
				{
					[1] = 0.88,
					[2] = 6.99,
				},
				[207] = 
				{
					[1] = 0.88,
					[2] = 7,
				},
				[208] = 
				{
					[1] = 0.88,
					[2] = 7,
				},
				[209] = 
				{
					[1] = 0.89,
					[2] = 7,
				},
				[210] = 
				{
					[1] = 0.89,
					[2] = 7,
				},
				[211] = 
				{
					[1] = 0.9,
					[2] = 7,
				},
				[212] = 
				{
					[1] = 0.9,
					[2] = 7,
				},
				[213] = 
				{
					[1] = 0.91,
					[2] = 7,
				},
				[214] = 
				{
					[1] = 0.91,
					[2] = 7,
				},
				[215] = 
				{
					[1] = 0.91,
					[2] = 7,
				},
				[216] = 
				{
					[1] = 0.92,
					[2] = 6.99,
				},
				[217] = 
				{
					[1] = 0.92,
					[2] = 6.99,
				},
				[218] = 
				{
					[1] = 0.93,
					[2] = 6.99,
				},
				[219] = 
				{
					[1] = 0.93,
					[2] = 6.98,
				},
				[220] = 
				{
					[1] = 0.94,
					[2] = 6.97,
				},
				[221] = 
				{
					[1] = 0.94,
					[2] = 6.97,
				},
				[222] = 
				{
					[1] = 0.94,
					[2] = 6.96,
				},
				[223] = 
				{
					[1] = 0.95,
					[2] = 6.96,
				},
				[224] = 
				{
					[1] = 0.95,
					[2] = 6.95,
				},
				[225] = 
				{
					[1] = 0.96,
					[2] = 6.94,
				},
				[226] = 
				{
					[1] = 0.96,
					[2] = 6.93,
				},
				[227] = 
				{
					[1] = 0.97,
					[2] = 6.92,
				},
				[228] = 
				{
					[1] = 0.97,
					[2] = 6.92,
				},
				[229] = 
				{
					[1] = 0.97,
					[2] = 6.91,
				},
				[230] = 
				{
					[1] = 0.98,
					[2] = 6.9,
				},
				[231] = 
				{
					[1] = 0.98,
					[2] = 6.89,
				},
				[232] = 
				{
					[1] = 0.99,
					[2] = 6.88,
				},
				[233] = 
				{
					[1] = 0.99,
					[2] = 6.87,
				},
				[234] = 
				{
					[1] = 1,
					[2] = 6.86,
				},
			},
			["WidthScale"] = 0.7,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Jap_Tanker",
		["Type"] = "WaterTracer",
	},
	[240] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 202.792252,
			["Lifetime"] = 21.9,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0478,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 3.49,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 265.204102,
			["Lifetime"] = 28.639999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0598,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.53,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 46.762596,
			["Lifetime"] = 5.05,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0598,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 3.54,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Jap_Tanker",
		["Type"] = "WaterTracer",
	},
	[241] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 181.399994,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0276,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.88,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.51,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 2.13,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 2.82,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 3.38,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 3.72,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 4.06,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 4.41,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 4.75,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 5.07,
				},
				[12] = 
				{
					[1] = 0.06,
					[2] = 5.39,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 5.69,
				},
				[14] = 
				{
					[1] = 0.07,
					[2] = 5.92,
				},
				[15] = 
				{
					[1] = 0.08,
					[2] = 6.15,
				},
				[16] = 
				{
					[1] = 0.08,
					[2] = 6.38,
				},
				[17] = 
				{
					[1] = 0.09,
					[2] = 6.58,
				},
				[18] = 
				{
					[1] = 0.09,
					[2] = 6.76,
				},
				[19] = 
				{
					[1] = 0.1,
					[2] = 6.94,
				},
				[20] = 
				{
					[1] = 0.1,
					[2] = 7.13,
				},
				[21] = 
				{
					[1] = 0.11,
					[2] = 7.31,
				},
				[22] = 
				{
					[1] = 0.12,
					[2] = 7.5,
				},
				[23] = 
				{
					[1] = 0.12,
					[2] = 7.68,
				},
				[24] = 
				{
					[1] = 0.13,
					[2] = 7.86,
				},
				[25] = 
				{
					[1] = 0.13,
					[2] = 8.04,
				},
				[26] = 
				{
					[1] = 0.14,
					[2] = 8.22,
				},
				[27] = 
				{
					[1] = 0.14,
					[2] = 8.4,
				},
				[28] = 
				{
					[1] = 0.15,
					[2] = 8.58,
				},
				[29] = 
				{
					[1] = 0.15,
					[2] = 8.75,
				},
				[30] = 
				{
					[1] = 0.16,
					[2] = 8.93,
				},
				[31] = 
				{
					[1] = 0.17,
					[2] = 9.11,
				},
				[32] = 
				{
					[1] = 0.17,
					[2] = 9.29,
				},
				[33] = 
				{
					[1] = 0.18,
					[2] = 9.46,
				},
				[34] = 
				{
					[1] = 0.18,
					[2] = 9.63,
				},
				[35] = 
				{
					[1] = 0.19,
					[2] = 9.8,
				},
				[36] = 
				{
					[1] = 0.19,
					[2] = 9.97,
				},
				[37] = 
				{
					[1] = 0.2,
					[2] = 10.15,
				},
				[38] = 
				{
					[1] = 0.2,
					[2] = 10.31,
				},
				[39] = 
				{
					[1] = 0.21,
					[2] = 10.46,
				},
				[40] = 
				{
					[1] = 0.22,
					[2] = 10.61,
				},
				[41] = 
				{
					[1] = 0.22,
					[2] = 10.75,
				},
				[42] = 
				{
					[1] = 0.23,
					[2] = 10.9,
				},
				[43] = 
				{
					[1] = 0.23,
					[2] = 11.04,
				},
				[44] = 
				{
					[1] = 0.24,
					[2] = 11.19,
				},
				[45] = 
				{
					[1] = 0.24,
					[2] = 11.33,
				},
				[46] = 
				{
					[1] = 0.25,
					[2] = 11.47,
				},
				[47] = 
				{
					[1] = 0.25,
					[2] = 11.6,
				},
				[48] = 
				{
					[1] = 0.26,
					[2] = 11.73,
				},
				[49] = 
				{
					[1] = 0.27,
					[2] = 11.86,
				},
				[50] = 
				{
					[1] = 0.27,
					[2] = 11.99,
				},
				[51] = 
				{
					[1] = 0.28,
					[2] = 12.13,
				},
				[52] = 
				{
					[1] = 0.28,
					[2] = 12.26,
				},
				[53] = 
				{
					[1] = 0.29,
					[2] = 12.38,
				},
				[54] = 
				{
					[1] = 0.29,
					[2] = 12.48,
				},
				[55] = 
				{
					[1] = 0.3,
					[2] = 12.58,
				},
				[56] = 
				{
					[1] = 0.3,
					[2] = 12.68,
				},
				[57] = 
				{
					[1] = 0.31,
					[2] = 12.78,
				},
				[58] = 
				{
					[1] = 0.31,
					[2] = 12.88,
				},
				[59] = 
				{
					[1] = 0.32,
					[2] = 12.97,
				},
				[60] = 
				{
					[1] = 0.33,
					[2] = 13.04,
				},
				[61] = 
				{
					[1] = 0.33,
					[2] = 13.08,
				},
				[62] = 
				{
					[1] = 0.34,
					[2] = 13.13,
				},
				[63] = 
				{
					[1] = 0.34,
					[2] = 13.17,
				},
				[64] = 
				{
					[1] = 0.35,
					[2] = 13.22,
				},
				[65] = 
				{
					[1] = 0.35,
					[2] = 13.25,
				},
				[66] = 
				{
					[1] = 0.36,
					[2] = 13.27,
				},
				[67] = 
				{
					[1] = 0.36,
					[2] = 13.27,
				},
				[68] = 
				{
					[1] = 0.37,
					[2] = 13.28,
				},
				[69] = 
				{
					[1] = 0.38,
					[2] = 13.28,
				},
				[70] = 
				{
					[1] = 0.38,
					[2] = 13.28,
				},
				[71] = 
				{
					[1] = 0.39,
					[2] = 13.28,
				},
				[72] = 
				{
					[1] = 0.39,
					[2] = 13.29,
				},
				[73] = 
				{
					[1] = 0.4,
					[2] = 13.29,
				},
				[74] = 
				{
					[1] = 0.4,
					[2] = 13.29,
				},
				[75] = 
				{
					[1] = 0.41,
					[2] = 13.29,
				},
				[76] = 
				{
					[1] = 0.41,
					[2] = 13.29,
				},
				[77] = 
				{
					[1] = 0.42,
					[2] = 13.3,
				},
				[78] = 
				{
					[1] = 0.43,
					[2] = 13.3,
				},
				[79] = 
				{
					[1] = 0.43,
					[2] = 13.3,
				},
				[80] = 
				{
					[1] = 0.44,
					[2] = 13.3,
				},
				[81] = 
				{
					[1] = 0.44,
					[2] = 13.31,
				},
				[82] = 
				{
					[1] = 0.45,
					[2] = 13.31,
				},
				[83] = 
				{
					[1] = 0.45,
					[2] = 13.31,
				},
				[84] = 
				{
					[1] = 0.46,
					[2] = 13.31,
				},
				[85] = 
				{
					[1] = 0.46,
					[2] = 13.32,
				},
				[86] = 
				{
					[1] = 0.47,
					[2] = 13.32,
				},
				[87] = 
				{
					[1] = 0.48,
					[2] = 13.32,
				},
				[88] = 
				{
					[1] = 0.48,
					[2] = 13.32,
				},
				[89] = 
				{
					[1] = 0.49,
					[2] = 13.33,
				},
				[90] = 
				{
					[1] = 0.49,
					[2] = 13.33,
				},
				[91] = 
				{
					[1] = 0.5,
					[2] = 13.33,
				},
				[92] = 
				{
					[1] = 0.5,
					[2] = 13.33,
				},
				[93] = 
				{
					[1] = 0.51,
					[2] = 13.34,
				},
				[94] = 
				{
					[1] = 0.51,
					[2] = 13.34,
				},
				[95] = 
				{
					[1] = 0.52,
					[2] = 13.34,
				},
				[96] = 
				{
					[1] = 0.52,
					[2] = 13.34,
				},
				[97] = 
				{
					[1] = 0.53,
					[2] = 13.35,
				},
				[98] = 
				{
					[1] = 0.54,
					[2] = 13.35,
				},
				[99] = 
				{
					[1] = 0.54,
					[2] = 13.35,
				},
				[100] = 
				{
					[1] = 0.55,
					[2] = 13.35,
				},
				[101] = 
				{
					[1] = 0.55,
					[2] = 13.36,
				},
				[102] = 
				{
					[1] = 0.56,
					[2] = 13.36,
				},
				[103] = 
				{
					[1] = 0.56,
					[2] = 13.36,
				},
				[104] = 
				{
					[1] = 0.57,
					[2] = 13.36,
				},
				[105] = 
				{
					[1] = 0.57,
					[2] = 13.36,
				},
				[106] = 
				{
					[1] = 0.58,
					[2] = 13.37,
				},
				[107] = 
				{
					[1] = 0.59,
					[2] = 13.37,
				},
				[108] = 
				{
					[1] = 0.59,
					[2] = 13.37,
				},
				[109] = 
				{
					[1] = 0.6,
					[2] = 13.37,
				},
				[110] = 
				{
					[1] = 0.6,
					[2] = 13.38,
				},
				[111] = 
				{
					[1] = 0.61,
					[2] = 13.38,
				},
				[112] = 
				{
					[1] = 0.61,
					[2] = 13.38,
				},
				[113] = 
				{
					[1] = 0.62,
					[2] = 13.38,
				},
				[114] = 
				{
					[1] = 0.62,
					[2] = 13.39,
				},
				[115] = 
				{
					[1] = 0.63,
					[2] = 13.39,
				},
				[116] = 
				{
					[1] = 0.64,
					[2] = 13.39,
				},
				[117] = 
				{
					[1] = 0.64,
					[2] = 13.39,
				},
				[118] = 
				{
					[1] = 0.65,
					[2] = 13.4,
				},
				[119] = 
				{
					[1] = 0.65,
					[2] = 13.4,
				},
				[120] = 
				{
					[1] = 0.66,
					[2] = 13.4,
				},
				[121] = 
				{
					[1] = 0.66,
					[2] = 13.4,
				},
				[122] = 
				{
					[1] = 0.67,
					[2] = 13.4,
				},
				[123] = 
				{
					[1] = 0.67,
					[2] = 13.38,
				},
				[124] = 
				{
					[1] = 0.68,
					[2] = 13.37,
				},
				[125] = 
				{
					[1] = 0.69,
					[2] = 13.35,
				},
				[126] = 
				{
					[1] = 0.69,
					[2] = 13.34,
				},
				[127] = 
				{
					[1] = 0.7,
					[2] = 13.32,
				},
				[128] = 
				{
					[1] = 0.7,
					[2] = 13.31,
				},
				[129] = 
				{
					[1] = 0.71,
					[2] = 13.29,
				},
				[130] = 
				{
					[1] = 0.71,
					[2] = 13.26,
				},
				[131] = 
				{
					[1] = 0.72,
					[2] = 13.23,
				},
				[132] = 
				{
					[1] = 0.72,
					[2] = 13.2,
				},
				[133] = 
				{
					[1] = 0.73,
					[2] = 13.18,
				},
				[134] = 
				{
					[1] = 0.73,
					[2] = 13.15,
				},
				[135] = 
				{
					[1] = 0.74,
					[2] = 13.12,
				},
				[136] = 
				{
					[1] = 0.75,
					[2] = 13.09,
				},
				[137] = 
				{
					[1] = 0.75,
					[2] = 13.04,
				},
				[138] = 
				{
					[1] = 0.76,
					[2] = 13,
				},
				[139] = 
				{
					[1] = 0.76,
					[2] = 12.95,
				},
				[140] = 
				{
					[1] = 0.77,
					[2] = 12.9,
				},
				[141] = 
				{
					[1] = 0.77,
					[2] = 12.85,
				},
				[142] = 
				{
					[1] = 0.78,
					[2] = 12.81,
				},
				[143] = 
				{
					[1] = 0.78,
					[2] = 12.76,
				},
				[144] = 
				{
					[1] = 0.79,
					[2] = 12.71,
				},
				[145] = 
				{
					[1] = 0.8,
					[2] = 12.67,
				},
				[146] = 
				{
					[1] = 0.8,
					[2] = 12.62,
				},
				[147] = 
				{
					[1] = 0.81,
					[2] = 12.58,
				},
				[148] = 
				{
					[1] = 0.81,
					[2] = 12.53,
				},
				[149] = 
				{
					[1] = 0.82,
					[2] = 12.49,
				},
				[150] = 
				{
					[1] = 0.82,
					[2] = 12.45,
				},
				[151] = 
				{
					[1] = 0.83,
					[2] = 12.37,
				},
				[152] = 
				{
					[1] = 0.83,
					[2] = 12.28,
				},
				[153] = 
				{
					[1] = 0.84,
					[2] = 12.19,
				},
				[154] = 
				{
					[1] = 0.85,
					[2] = 12.09,
				},
				[155] = 
				{
					[1] = 0.85,
					[2] = 12,
				},
				[156] = 
				{
					[1] = 0.86,
					[2] = 11.91,
				},
				[157] = 
				{
					[1] = 0.86,
					[2] = 11.81,
				},
				[158] = 
				{
					[1] = 0.87,
					[2] = 11.71,
				},
				[159] = 
				{
					[1] = 0.87,
					[2] = 11.58,
				},
				[160] = 
				{
					[1] = 0.88,
					[2] = 11.42,
				},
				[161] = 
				{
					[1] = 0.88,
					[2] = 11.26,
				},
				[162] = 
				{
					[1] = 0.89,
					[2] = 11.09,
				},
				[163] = 
				{
					[1] = 0.9,
					[2] = 10.92,
				},
				[164] = 
				{
					[1] = 0.9,
					[2] = 10.75,
				},
				[165] = 
				{
					[1] = 0.91,
					[2] = 10.58,
				},
				[166] = 
				{
					[1] = 0.91,
					[2] = 10.42,
				},
				[167] = 
				{
					[1] = 0.92,
					[2] = 10.25,
				},
				[168] = 
				{
					[1] = 0.92,
					[2] = 10.08,
				},
				[169] = 
				{
					[1] = 0.93,
					[2] = 9.9,
				},
				[170] = 
				{
					[1] = 0.93,
					[2] = 9.67,
				},
				[171] = 
				{
					[1] = 0.94,
					[2] = 9.45,
				},
				[172] = 
				{
					[1] = 0.94,
					[2] = 9.22,
				},
				[173] = 
				{
					[1] = 0.95,
					[2] = 8.94,
				},
				[174] = 
				{
					[1] = 0.96,
					[2] = 8.63,
				},
				[175] = 
				{
					[1] = 0.96,
					[2] = 8.33,
				},
				[176] = 
				{
					[1] = 0.97,
					[2] = 7.99,
				},
				[177] = 
				{
					[1] = 0.97,
					[2] = 7.18,
				},
				[178] = 
				{
					[1] = 0.98,
					[2] = 6.35,
				},
				[179] = 
				{
					[1] = 0.98,
					[2] = 5.52,
				},
				[180] = 
				{
					[1] = 0.99,
					[2] = 4.2,
				},
				[181] = 
				{
					[1] = 0.99,
					[2] = 2.9,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4.05,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.23,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.31,
				},
				[4] = 
				{
					[1] = 0.07,
					[2] = 0.36,
				},
				[5] = 
				{
					[1] = 0.09,
					[2] = 0.4,
				},
				[6] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[7] = 
				{
					[1] = 0.13,
					[2] = 0.46,
				},
				[8] = 
				{
					[1] = 0.16,
					[2] = 0.47,
				},
				[9] = 
				{
					[1] = 0.18,
					[2] = 0.48,
				},
				[10] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[11] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[17] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[18] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[19] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[20] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[21] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[22] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[23] = 
				{
					[1] = 0.49,
					[2] = 0.41,
				},
				[24] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[25] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[26] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[27] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[28] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[29] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[30] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[31] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[32] = 
				{
					[1] = 0.69,
					[2] = 0.26,
				},
				[33] = 
				{
					[1] = 0.71,
					[2] = 0.24,
				},
				[34] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[35] = 
				{
					[1] = 0.76,
					[2] = 0.2,
				},
				[36] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[37] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[38] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[39] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[40] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[41] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[42] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[43] = 
				{
					[1] = 0.93,
					[2] = 0.05,
				},
				[44] = 
				{
					[1] = 0.96,
					[2] = 0.04,
				},
				[45] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 15.21,
			["LocalSpace"] = true,
			["MaxSpeed"] = 9.25992,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.23,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.58,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.76,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.93,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 1.11,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.28,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 1.46,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 1.61,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 1.73,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 1.85,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 1.97,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 2.09,
				},
				[15] = 
				{
					[1] = 0.05,
					[2] = 2.2,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 2.32,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 2.44,
				},
				[18] = 
				{
					[1] = 0.06,
					[2] = 2.55,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 2.67,
				},
				[20] = 
				{
					[1] = 0.07,
					[2] = 2.79,
				},
				[21] = 
				{
					[1] = 0.07,
					[2] = 2.9,
				},
				[22] = 
				{
					[1] = 0.08,
					[2] = 3.01,
				},
				[23] = 
				{
					[1] = 0.08,
					[2] = 3.13,
				},
				[24] = 
				{
					[1] = 0.08,
					[2] = 3.24,
				},
				[25] = 
				{
					[1] = 0.09,
					[2] = 3.35,
				},
				[26] = 
				{
					[1] = 0.09,
					[2] = 3.47,
				},
				[27] = 
				{
					[1] = 0.1,
					[2] = 3.58,
				},
				[28] = 
				{
					[1] = 0.1,
					[2] = 3.69,
				},
				[29] = 
				{
					[1] = 0.1,
					[2] = 3.8,
				},
				[30] = 
				{
					[1] = 0.11,
					[2] = 3.91,
				},
				[31] = 
				{
					[1] = 0.11,
					[2] = 4.02,
				},
				[32] = 
				{
					[1] = 0.11,
					[2] = 4.13,
				},
				[33] = 
				{
					[1] = 0.12,
					[2] = 4.24,
				},
				[34] = 
				{
					[1] = 0.12,
					[2] = 4.37,
				},
				[35] = 
				{
					[1] = 0.13,
					[2] = 4.49,
				},
				[36] = 
				{
					[1] = 0.13,
					[2] = 4.62,
				},
				[37] = 
				{
					[1] = 0.13,
					[2] = 4.74,
				},
				[38] = 
				{
					[1] = 0.14,
					[2] = 4.86,
				},
				[39] = 
				{
					[1] = 0.14,
					[2] = 4.98,
				},
				[40] = 
				{
					[1] = 0.14,
					[2] = 5.1,
				},
				[41] = 
				{
					[1] = 0.15,
					[2] = 5.22,
				},
				[42] = 
				{
					[1] = 0.15,
					[2] = 5.34,
				},
				[43] = 
				{
					[1] = 0.15,
					[2] = 5.46,
				},
				[44] = 
				{
					[1] = 0.16,
					[2] = 5.58,
				},
				[45] = 
				{
					[1] = 0.16,
					[2] = 5.69,
				},
				[46] = 
				{
					[1] = 0.17,
					[2] = 5.81,
				},
				[47] = 
				{
					[1] = 0.17,
					[2] = 5.92,
				},
				[48] = 
				{
					[1] = 0.17,
					[2] = 5.98,
				},
				[49] = 
				{
					[1] = 0.18,
					[2] = 6.04,
				},
				[50] = 
				{
					[1] = 0.18,
					[2] = 6.09,
				},
				[51] = 
				{
					[1] = 0.18,
					[2] = 6.14,
				},
				[52] = 
				{
					[1] = 0.19,
					[2] = 6.19,
				},
				[53] = 
				{
					[1] = 0.19,
					[2] = 6.24,
				},
				[54] = 
				{
					[1] = 0.19,
					[2] = 6.28,
				},
				[55] = 
				{
					[1] = 0.2,
					[2] = 6.33,
				},
				[56] = 
				{
					[1] = 0.2,
					[2] = 6.38,
				},
				[57] = 
				{
					[1] = 0.21,
					[2] = 6.43,
				},
				[58] = 
				{
					[1] = 0.21,
					[2] = 6.48,
				},
				[59] = 
				{
					[1] = 0.21,
					[2] = 6.53,
				},
				[60] = 
				{
					[1] = 0.22,
					[2] = 6.57,
				},
				[61] = 
				{
					[1] = 0.22,
					[2] = 6.62,
				},
				[62] = 
				{
					[1] = 0.22,
					[2] = 6.67,
				},
				[63] = 
				{
					[1] = 0.23,
					[2] = 6.72,
				},
				[64] = 
				{
					[1] = 0.23,
					[2] = 6.76,
				},
				[65] = 
				{
					[1] = 0.24,
					[2] = 6.81,
				},
				[66] = 
				{
					[1] = 0.24,
					[2] = 6.86,
				},
				[67] = 
				{
					[1] = 0.24,
					[2] = 6.9,
				},
				[68] = 
				{
					[1] = 0.25,
					[2] = 6.95,
				},
				[69] = 
				{
					[1] = 0.25,
					[2] = 6.99,
				},
				[70] = 
				{
					[1] = 0.25,
					[2] = 7.04,
				},
				[71] = 
				{
					[1] = 0.26,
					[2] = 7.08,
				},
				[72] = 
				{
					[1] = 0.26,
					[2] = 7.13,
				},
				[73] = 
				{
					[1] = 0.26,
					[2] = 7.17,
				},
				[74] = 
				{
					[1] = 0.27,
					[2] = 7.22,
				},
				[75] = 
				{
					[1] = 0.27,
					[2] = 7.26,
				},
				[76] = 
				{
					[1] = 0.28,
					[2] = 7.3,
				},
				[77] = 
				{
					[1] = 0.28,
					[2] = 7.35,
				},
				[78] = 
				{
					[1] = 0.28,
					[2] = 7.39,
				},
				[79] = 
				{
					[1] = 0.29,
					[2] = 7.43,
				},
				[80] = 
				{
					[1] = 0.29,
					[2] = 7.48,
				},
				[81] = 
				{
					[1] = 0.29,
					[2] = 7.52,
				},
				[82] = 
				{
					[1] = 0.3,
					[2] = 7.56,
				},
				[83] = 
				{
					[1] = 0.3,
					[2] = 7.6,
				},
				[84] = 
				{
					[1] = 0.31,
					[2] = 7.64,
				},
				[85] = 
				{
					[1] = 0.31,
					[2] = 7.69,
				},
				[86] = 
				{
					[1] = 0.31,
					[2] = 7.73,
				},
				[87] = 
				{
					[1] = 0.32,
					[2] = 7.77,
				},
				[88] = 
				{
					[1] = 0.32,
					[2] = 7.81,
				},
				[89] = 
				{
					[1] = 0.32,
					[2] = 7.85,
				},
				[90] = 
				{
					[1] = 0.33,
					[2] = 7.89,
				},
				[91] = 
				{
					[1] = 0.33,
					[2] = 7.92,
				},
				[92] = 
				{
					[1] = 0.33,
					[2] = 7.96,
				},
				[93] = 
				{
					[1] = 0.34,
					[2] = 7.99,
				},
				[94] = 
				{
					[1] = 0.34,
					[2] = 8.03,
				},
				[95] = 
				{
					[1] = 0.35,
					[2] = 8.06,
				},
				[96] = 
				{
					[1] = 0.35,
					[2] = 8.1,
				},
				[97] = 
				{
					[1] = 0.35,
					[2] = 8.13,
				},
				[98] = 
				{
					[1] = 0.36,
					[2] = 8.17,
				},
				[99] = 
				{
					[1] = 0.36,
					[2] = 8.2,
				},
				[100] = 
				{
					[1] = 0.36,
					[2] = 8.24,
				},
				[101] = 
				{
					[1] = 0.37,
					[2] = 8.27,
				},
				[102] = 
				{
					[1] = 0.37,
					[2] = 8.3,
				},
				[103] = 
				{
					[1] = 0.38,
					[2] = 8.34,
				},
				[104] = 
				{
					[1] = 0.38,
					[2] = 8.37,
				},
				[105] = 
				{
					[1] = 0.38,
					[2] = 8.4,
				},
				[106] = 
				{
					[1] = 0.39,
					[2] = 8.44,
				},
				[107] = 
				{
					[1] = 0.39,
					[2] = 8.47,
				},
				[108] = 
				{
					[1] = 0.39,
					[2] = 8.5,
				},
				[109] = 
				{
					[1] = 0.4,
					[2] = 8.53,
				},
				[110] = 
				{
					[1] = 0.4,
					[2] = 8.56,
				},
				[111] = 
				{
					[1] = 0.4,
					[2] = 8.59,
				},
				[112] = 
				{
					[1] = 0.41,
					[2] = 8.63,
				},
				[113] = 
				{
					[1] = 0.41,
					[2] = 8.66,
				},
				[114] = 
				{
					[1] = 0.42,
					[2] = 8.69,
				},
				[115] = 
				{
					[1] = 0.42,
					[2] = 8.72,
				},
				[116] = 
				{
					[1] = 0.42,
					[2] = 8.75,
				},
				[117] = 
				{
					[1] = 0.43,
					[2] = 8.78,
				},
				[118] = 
				{
					[1] = 0.43,
					[2] = 8.81,
				},
				[119] = 
				{
					[1] = 0.43,
					[2] = 8.84,
				},
				[120] = 
				{
					[1] = 0.44,
					[2] = 8.86,
				},
				[121] = 
				{
					[1] = 0.44,
					[2] = 8.87,
				},
				[122] = 
				{
					[1] = 0.44,
					[2] = 8.89,
				},
				[123] = 
				{
					[1] = 0.45,
					[2] = 8.9,
				},
				[124] = 
				{
					[1] = 0.45,
					[2] = 8.92,
				},
				[125] = 
				{
					[1] = 0.46,
					[2] = 8.93,
				},
				[126] = 
				{
					[1] = 0.46,
					[2] = 8.95,
				},
				[127] = 
				{
					[1] = 0.46,
					[2] = 8.96,
				},
				[128] = 
				{
					[1] = 0.47,
					[2] = 8.97,
				},
				[129] = 
				{
					[1] = 0.47,
					[2] = 8.99,
				},
				[130] = 
				{
					[1] = 0.47,
					[2] = 9,
				},
				[131] = 
				{
					[1] = 0.48,
					[2] = 9.01,
				},
				[132] = 
				{
					[1] = 0.48,
					[2] = 9.03,
				},
				[133] = 
				{
					[1] = 0.49,
					[2] = 9.04,
				},
				[134] = 
				{
					[1] = 0.49,
					[2] = 9.05,
				},
				[135] = 
				{
					[1] = 0.49,
					[2] = 9.07,
				},
				[136] = 
				{
					[1] = 0.5,
					[2] = 9.08,
				},
				[137] = 
				{
					[1] = 0.5,
					[2] = 9.09,
				},
				[138] = 
				{
					[1] = 0.5,
					[2] = 9.1,
				},
				[139] = 
				{
					[1] = 0.51,
					[2] = 9.12,
				},
				[140] = 
				{
					[1] = 0.51,
					[2] = 9.13,
				},
				[141] = 
				{
					[1] = 0.51,
					[2] = 9.14,
				},
				[142] = 
				{
					[1] = 0.52,
					[2] = 9.15,
				},
				[143] = 
				{
					[1] = 0.52,
					[2] = 9.16,
				},
				[144] = 
				{
					[1] = 0.53,
					[2] = 9.17,
				},
				[145] = 
				{
					[1] = 0.53,
					[2] = 9.18,
				},
				[146] = 
				{
					[1] = 0.53,
					[2] = 9.19,
				},
				[147] = 
				{
					[1] = 0.54,
					[2] = 9.21,
				},
				[148] = 
				{
					[1] = 0.54,
					[2] = 9.22,
				},
				[149] = 
				{
					[1] = 0.54,
					[2] = 9.23,
				},
				[150] = 
				{
					[1] = 0.55,
					[2] = 9.24,
				},
				[151] = 
				{
					[1] = 0.55,
					[2] = 9.25,
				},
				[152] = 
				{
					[1] = 0.56,
					[2] = 9.25,
				},
				[153] = 
				{
					[1] = 0.56,
					[2] = 9.26,
				},
				[154] = 
				{
					[1] = 0.56,
					[2] = 9.26,
				},
				[155] = 
				{
					[1] = 0.57,
					[2] = 9.27,
				},
				[156] = 
				{
					[1] = 0.57,
					[2] = 9.27,
				},
				[157] = 
				{
					[1] = 0.57,
					[2] = 9.28,
				},
				[158] = 
				{
					[1] = 0.58,
					[2] = 9.28,
				},
				[159] = 
				{
					[1] = 0.58,
					[2] = 9.28,
				},
				[160] = 
				{
					[1] = 0.58,
					[2] = 9.28,
				},
				[161] = 
				{
					[1] = 0.59,
					[2] = 9.28,
				},
				[162] = 
				{
					[1] = 0.59,
					[2] = 9.29,
				},
				[163] = 
				{
					[1] = 0.6,
					[2] = 9.29,
				},
				[164] = 
				{
					[1] = 0.6,
					[2] = 9.29,
				},
				[165] = 
				{
					[1] = 0.6,
					[2] = 9.29,
				},
				[166] = 
				{
					[1] = 0.61,
					[2] = 9.29,
				},
				[167] = 
				{
					[1] = 0.61,
					[2] = 9.29,
				},
				[168] = 
				{
					[1] = 0.61,
					[2] = 9.29,
				},
				[169] = 
				{
					[1] = 0.62,
					[2] = 9.29,
				},
				[170] = 
				{
					[1] = 0.62,
					[2] = 9.3,
				},
				[171] = 
				{
					[1] = 0.63,
					[2] = 9.3,
				},
				[172] = 
				{
					[1] = 0.63,
					[2] = 9.3,
				},
				[173] = 
				{
					[1] = 0.63,
					[2] = 9.3,
				},
				[174] = 
				{
					[1] = 0.64,
					[2] = 9.3,
				},
				[175] = 
				{
					[1] = 0.64,
					[2] = 9.3,
				},
				[176] = 
				{
					[1] = 0.64,
					[2] = 9.3,
				},
				[177] = 
				{
					[1] = 0.65,
					[2] = 9.3,
				},
				[178] = 
				{
					[1] = 0.65,
					[2] = 9.3,
				},
				[179] = 
				{
					[1] = 0.65,
					[2] = 9.29,
				},
				[180] = 
				{
					[1] = 0.66,
					[2] = 9.29,
				},
				[181] = 
				{
					[1] = 0.66,
					[2] = 9.29,
				},
				[182] = 
				{
					[1] = 0.67,
					[2] = 9.29,
				},
				[183] = 
				{
					[1] = 0.67,
					[2] = 9.29,
				},
				[184] = 
				{
					[1] = 0.67,
					[2] = 9.29,
				},
				[185] = 
				{
					[1] = 0.68,
					[2] = 9.29,
				},
				[186] = 
				{
					[1] = 0.68,
					[2] = 9.29,
				},
				[187] = 
				{
					[1] = 0.68,
					[2] = 9.29,
				},
				[188] = 
				{
					[1] = 0.69,
					[2] = 9.28,
				},
				[189] = 
				{
					[1] = 0.69,
					[2] = 9.28,
				},
				[190] = 
				{
					[1] = 0.69,
					[2] = 9.28,
				},
				[191] = 
				{
					[1] = 0.7,
					[2] = 9.28,
				},
				[192] = 
				{
					[1] = 0.7,
					[2] = 9.27,
				},
				[193] = 
				{
					[1] = 0.71,
					[2] = 9.27,
				},
				[194] = 
				{
					[1] = 0.71,
					[2] = 9.27,
				},
				[195] = 
				{
					[1] = 0.71,
					[2] = 9.27,
				},
				[196] = 
				{
					[1] = 0.72,
					[2] = 9.26,
				},
				[197] = 
				{
					[1] = 0.72,
					[2] = 9.26,
				},
				[198] = 
				{
					[1] = 0.72,
					[2] = 9.26,
				},
				[199] = 
				{
					[1] = 0.73,
					[2] = 9.25,
				},
				[200] = 
				{
					[1] = 0.73,
					[2] = 9.25,
				},
				[201] = 
				{
					[1] = 0.74,
					[2] = 9.25,
				},
				[202] = 
				{
					[1] = 0.74,
					[2] = 9.24,
				},
				[203] = 
				{
					[1] = 0.74,
					[2] = 9.24,
				},
				[204] = 
				{
					[1] = 0.75,
					[2] = 9.24,
				},
				[205] = 
				{
					[1] = 0.75,
					[2] = 9.23,
				},
				[206] = 
				{
					[1] = 0.75,
					[2] = 9.23,
				},
				[207] = 
				{
					[1] = 0.76,
					[2] = 9.22,
				},
				[208] = 
				{
					[1] = 0.76,
					[2] = 9.22,
				},
				[209] = 
				{
					[1] = 0.76,
					[2] = 9.21,
				},
				[210] = 
				{
					[1] = 0.77,
					[2] = 9.21,
				},
				[211] = 
				{
					[1] = 0.77,
					[2] = 9.2,
				},
				[212] = 
				{
					[1] = 0.78,
					[2] = 9.2,
				},
				[213] = 
				{
					[1] = 0.78,
					[2] = 9.19,
				},
				[214] = 
				{
					[1] = 0.78,
					[2] = 9.19,
				},
				[215] = 
				{
					[1] = 0.79,
					[2] = 9.18,
				},
				[216] = 
				{
					[1] = 0.79,
					[2] = 9.18,
				},
				[217] = 
				{
					[1] = 0.79,
					[2] = 9.17,
				},
				[218] = 
				{
					[1] = 0.8,
					[2] = 9.17,
				},
				[219] = 
				{
					[1] = 0.8,
					[2] = 9.16,
				},
				[220] = 
				{
					[1] = 0.81,
					[2] = 9.15,
				},
				[221] = 
				{
					[1] = 0.81,
					[2] = 9.15,
				},
				[222] = 
				{
					[1] = 0.81,
					[2] = 9.14,
				},
				[223] = 
				{
					[1] = 0.82,
					[2] = 9.14,
				},
				[224] = 
				{
					[1] = 0.82,
					[2] = 9.13,
				},
				[225] = 
				{
					[1] = 0.82,
					[2] = 9.12,
				},
				[226] = 
				{
					[1] = 0.83,
					[2] = 9.11,
				},
				[227] = 
				{
					[1] = 0.83,
					[2] = 9.11,
				},
				[228] = 
				{
					[1] = 0.83,
					[2] = 9.1,
				},
				[229] = 
				{
					[1] = 0.84,
					[2] = 9.09,
				},
				[230] = 
				{
					[1] = 0.84,
					[2] = 9.08,
				},
				[231] = 
				{
					[1] = 0.85,
					[2] = 9.07,
				},
				[232] = 
				{
					[1] = 0.85,
					[2] = 9.07,
				},
				[233] = 
				{
					[1] = 0.85,
					[2] = 9.06,
				},
				[234] = 
				{
					[1] = 0.86,
					[2] = 9.05,
				},
				[235] = 
				{
					[1] = 0.86,
					[2] = 9.04,
				},
				[236] = 
				{
					[1] = 0.86,
					[2] = 9.03,
				},
				[237] = 
				{
					[1] = 0.87,
					[2] = 9.02,
				},
				[238] = 
				{
					[1] = 0.87,
					[2] = 9.01,
				},
				[239] = 
				{
					[1] = 0.88,
					[2] = 9,
				},
				[240] = 
				{
					[1] = 0.88,
					[2] = 8.99,
				},
				[241] = 
				{
					[1] = 0.88,
					[2] = 8.99,
				},
				[242] = 
				{
					[1] = 0.89,
					[2] = 8.98,
				},
				[243] = 
				{
					[1] = 0.89,
					[2] = 8.97,
				},
				[244] = 
				{
					[1] = 0.89,
					[2] = 8.96,
				},
				[245] = 
				{
					[1] = 0.9,
					[2] = 8.95,
				},
				[246] = 
				{
					[1] = 0.9,
					[2] = 8.94,
				},
				[247] = 
				{
					[1] = 0.9,
					[2] = 8.93,
				},
				[248] = 
				{
					[1] = 0.91,
					[2] = 8.92,
				},
				[249] = 
				{
					[1] = 0.91,
					[2] = 8.9,
				},
				[250] = 
				{
					[1] = 0.92,
					[2] = 8.89,
				},
				[251] = 
				{
					[1] = 0.92,
					[2] = 8.88,
				},
				[252] = 
				{
					[1] = 0.92,
					[2] = 8.87,
				},
				[253] = 
				{
					[1] = 0.93,
					[2] = 8.86,
				},
				[254] = 
				{
					[1] = 0.93,
					[2] = 8.85,
				},
				[255] = 
				{
					[1] = 0.93,
					[2] = 8.84,
				},
				[256] = 
				{
					[1] = 0.94,
					[2] = 8.83,
				},
				[257] = 
				{
					[1] = 0.94,
					[2] = 8.82,
				},
				[258] = 
				{
					[1] = 0.94,
					[2] = 8.8,
				},
				[259] = 
				{
					[1] = 0.95,
					[2] = 8.79,
				},
				[260] = 
				{
					[1] = 0.95,
					[2] = 8.78,
				},
				[261] = 
				{
					[1] = 0.96,
					[2] = 8.77,
				},
				[262] = 
				{
					[1] = 0.96,
					[2] = 8.76,
				},
				[263] = 
				{
					[1] = 0.96,
					[2] = 8.74,
				},
				[264] = 
				{
					[1] = 0.97,
					[2] = 8.73,
				},
				[265] = 
				{
					[1] = 0.97,
					[2] = 8.72,
				},
				[266] = 
				{
					[1] = 0.97,
					[2] = 8.7,
				},
				[267] = 
				{
					[1] = 0.98,
					[2] = 8.69,
				},
				[268] = 
				{
					[1] = 0.98,
					[2] = 8.68,
				},
				[269] = 
				{
					[1] = 0.99,
					[2] = 8.67,
				},
				[270] = 
				{
					[1] = 0.99,
					[2] = 8.65,
				},
				[271] = 
				{
					[1] = 0.99,
					[2] = 8.64,
				},
				[272] = 
				{
					[1] = 1,
					[2] = 8.63,
				},
			},
			["WidthScale"] = 0.8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Jap_Troop_Transporter",
		["Type"] = "WaterTracer",
	},
	[242] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 235.850159,
			["Lifetime"] = 25.469999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0181,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5.2,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 308.355316,
			["Lifetime"] = 33.299999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0226,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.05,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 54.44833,
			["Lifetime"] = 5.88,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0226,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5.35,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Jap_Troop_Transporter",
		["Type"] = "WaterTracer",
	},
	[243] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 247.100006,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0202,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.85,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.16,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1.46,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.77,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 2.08,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 2.38,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 2.66,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 2.92,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 3.19,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 3.46,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 3.73,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 4,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 4.27,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 4.54,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 4.82,
				},
				[17] = 
				{
					[1] = 0.06,
					[2] = 5.09,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 5.36,
				},
				[19] = 
				{
					[1] = 0.07,
					[2] = 5.63,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 5.91,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 6.18,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 6.45,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 6.7,
				},
				[24] = 
				{
					[1] = 0.09,
					[2] = 6.84,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 6.99,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 7.14,
				},
				[27] = 
				{
					[1] = 0.11,
					[2] = 7.29,
				},
				[28] = 
				{
					[1] = 0.11,
					[2] = 7.44,
				},
				[29] = 
				{
					[1] = 0.11,
					[2] = 7.58,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 7.73,
				},
				[31] = 
				{
					[1] = 0.12,
					[2] = 7.88,
				},
				[32] = 
				{
					[1] = 0.13,
					[2] = 8.03,
				},
				[33] = 
				{
					[1] = 0.13,
					[2] = 8.19,
				},
				[34] = 
				{
					[1] = 0.13,
					[2] = 8.36,
				},
				[35] = 
				{
					[1] = 0.14,
					[2] = 8.53,
				},
				[36] = 
				{
					[1] = 0.14,
					[2] = 8.7,
				},
				[37] = 
				{
					[1] = 0.15,
					[2] = 8.86,
				},
				[38] = 
				{
					[1] = 0.15,
					[2] = 9.03,
				},
				[39] = 
				{
					[1] = 0.15,
					[2] = 9.2,
				},
				[40] = 
				{
					[1] = 0.16,
					[2] = 9.36,
				},
				[41] = 
				{
					[1] = 0.16,
					[2] = 9.53,
				},
				[42] = 
				{
					[1] = 0.17,
					[2] = 9.7,
				},
				[43] = 
				{
					[1] = 0.17,
					[2] = 9.86,
				},
				[44] = 
				{
					[1] = 0.17,
					[2] = 10.03,
				},
				[45] = 
				{
					[1] = 0.18,
					[2] = 10.12,
				},
				[46] = 
				{
					[1] = 0.18,
					[2] = 10.17,
				},
				[47] = 
				{
					[1] = 0.19,
					[2] = 10.23,
				},
				[48] = 
				{
					[1] = 0.19,
					[2] = 10.28,
				},
				[49] = 
				{
					[1] = 0.19,
					[2] = 10.33,
				},
				[50] = 
				{
					[1] = 0.2,
					[2] = 10.38,
				},
				[51] = 
				{
					[1] = 0.2,
					[2] = 10.43,
				},
				[52] = 
				{
					[1] = 0.21,
					[2] = 10.48,
				},
				[53] = 
				{
					[1] = 0.21,
					[2] = 10.53,
				},
				[54] = 
				{
					[1] = 0.21,
					[2] = 10.59,
				},
				[55] = 
				{
					[1] = 0.22,
					[2] = 10.64,
				},
				[56] = 
				{
					[1] = 0.22,
					[2] = 10.69,
				},
				[57] = 
				{
					[1] = 0.23,
					[2] = 10.73,
				},
				[58] = 
				{
					[1] = 0.23,
					[2] = 10.8,
				},
				[59] = 
				{
					[1] = 0.23,
					[2] = 10.89,
				},
				[60] = 
				{
					[1] = 0.24,
					[2] = 10.98,
				},
				[61] = 
				{
					[1] = 0.24,
					[2] = 11.08,
				},
				[62] = 
				{
					[1] = 0.25,
					[2] = 11.17,
				},
				[63] = 
				{
					[1] = 0.25,
					[2] = 11.26,
				},
				[64] = 
				{
					[1] = 0.26,
					[2] = 11.35,
				},
				[65] = 
				{
					[1] = 0.26,
					[2] = 11.44,
				},
				[66] = 
				{
					[1] = 0.26,
					[2] = 11.54,
				},
				[67] = 
				{
					[1] = 0.27,
					[2] = 11.63,
				},
				[68] = 
				{
					[1] = 0.27,
					[2] = 11.72,
				},
				[69] = 
				{
					[1] = 0.28,
					[2] = 11.76,
				},
				[70] = 
				{
					[1] = 0.28,
					[2] = 11.78,
				},
				[71] = 
				{
					[1] = 0.28,
					[2] = 11.8,
				},
				[72] = 
				{
					[1] = 0.29,
					[2] = 11.81,
				},
				[73] = 
				{
					[1] = 0.29,
					[2] = 11.82,
				},
				[74] = 
				{
					[1] = 0.3,
					[2] = 11.84,
				},
				[75] = 
				{
					[1] = 0.3,
					[2] = 11.85,
				},
				[76] = 
				{
					[1] = 0.3,
					[2] = 11.87,
				},
				[77] = 
				{
					[1] = 0.31,
					[2] = 11.88,
				},
				[78] = 
				{
					[1] = 0.31,
					[2] = 11.89,
				},
				[79] = 
				{
					[1] = 0.32,
					[2] = 11.91,
				},
				[80] = 
				{
					[1] = 0.32,
					[2] = 11.92,
				},
				[81] = 
				{
					[1] = 0.32,
					[2] = 11.94,
				},
				[82] = 
				{
					[1] = 0.33,
					[2] = 11.95,
				},
				[83] = 
				{
					[1] = 0.33,
					[2] = 11.96,
				},
				[84] = 
				{
					[1] = 0.34,
					[2] = 11.98,
				},
				[85] = 
				{
					[1] = 0.34,
					[2] = 11.99,
				},
				[86] = 
				{
					[1] = 0.34,
					[2] = 12,
				},
				[87] = 
				{
					[1] = 0.35,
					[2] = 12.02,
				},
				[88] = 
				{
					[1] = 0.35,
					[2] = 12.03,
				},
				[89] = 
				{
					[1] = 0.36,
					[2] = 12.05,
				},
				[90] = 
				{
					[1] = 0.36,
					[2] = 12.06,
				},
				[91] = 
				{
					[1] = 0.36,
					[2] = 12.07,
				},
				[92] = 
				{
					[1] = 0.37,
					[2] = 12.09,
				},
				[93] = 
				{
					[1] = 0.37,
					[2] = 12.1,
				},
				[94] = 
				{
					[1] = 0.38,
					[2] = 12.12,
				},
				[95] = 
				{
					[1] = 0.38,
					[2] = 12.13,
				},
				[96] = 
				{
					[1] = 0.38,
					[2] = 12.14,
				},
				[97] = 
				{
					[1] = 0.39,
					[2] = 12.16,
				},
				[98] = 
				{
					[1] = 0.39,
					[2] = 12.17,
				},
				[99] = 
				{
					[1] = 0.4,
					[2] = 12.18,
				},
				[100] = 
				{
					[1] = 0.4,
					[2] = 12.2,
				},
				[101] = 
				{
					[1] = 0.4,
					[2] = 12.21,
				},
				[102] = 
				{
					[1] = 0.41,
					[2] = 12.22,
				},
				[103] = 
				{
					[1] = 0.41,
					[2] = 12.22,
				},
				[104] = 
				{
					[1] = 0.42,
					[2] = 12.23,
				},
				[105] = 
				{
					[1] = 0.42,
					[2] = 12.23,
				},
				[106] = 
				{
					[1] = 0.43,
					[2] = 12.23,
				},
				[107] = 
				{
					[1] = 0.43,
					[2] = 12.23,
				},
				[108] = 
				{
					[1] = 0.43,
					[2] = 12.23,
				},
				[109] = 
				{
					[1] = 0.44,
					[2] = 12.23,
				},
				[110] = 
				{
					[1] = 0.44,
					[2] = 12.23,
				},
				[111] = 
				{
					[1] = 0.45,
					[2] = 12.24,
				},
				[112] = 
				{
					[1] = 0.45,
					[2] = 12.24,
				},
				[113] = 
				{
					[1] = 0.45,
					[2] = 12.24,
				},
				[114] = 
				{
					[1] = 0.46,
					[2] = 12.24,
				},
				[115] = 
				{
					[1] = 0.46,
					[2] = 12.24,
				},
				[116] = 
				{
					[1] = 0.47,
					[2] = 12.24,
				},
				[117] = 
				{
					[1] = 0.47,
					[2] = 12.24,
				},
				[118] = 
				{
					[1] = 0.47,
					[2] = 12.24,
				},
				[119] = 
				{
					[1] = 0.48,
					[2] = 12.25,
				},
				[120] = 
				{
					[1] = 0.48,
					[2] = 12.25,
				},
				[121] = 
				{
					[1] = 0.49,
					[2] = 12.25,
				},
				[122] = 
				{
					[1] = 0.49,
					[2] = 12.25,
				},
				[123] = 
				{
					[1] = 0.49,
					[2] = 12.25,
				},
				[124] = 
				{
					[1] = 0.5,
					[2] = 12.25,
				},
				[125] = 
				{
					[1] = 0.5,
					[2] = 12.25,
				},
				[126] = 
				{
					[1] = 0.51,
					[2] = 12.25,
				},
				[127] = 
				{
					[1] = 0.51,
					[2] = 12.26,
				},
				[128] = 
				{
					[1] = 0.51,
					[2] = 12.26,
				},
				[129] = 
				{
					[1] = 0.52,
					[2] = 12.26,
				},
				[130] = 
				{
					[1] = 0.52,
					[2] = 12.26,
				},
				[131] = 
				{
					[1] = 0.53,
					[2] = 12.26,
				},
				[132] = 
				{
					[1] = 0.53,
					[2] = 12.26,
				},
				[133] = 
				{
					[1] = 0.53,
					[2] = 12.27,
				},
				[134] = 
				{
					[1] = 0.54,
					[2] = 12.27,
				},
				[135] = 
				{
					[1] = 0.54,
					[2] = 12.27,
				},
				[136] = 
				{
					[1] = 0.55,
					[2] = 12.27,
				},
				[137] = 
				{
					[1] = 0.55,
					[2] = 12.27,
				},
				[138] = 
				{
					[1] = 0.55,
					[2] = 12.27,
				},
				[139] = 
				{
					[1] = 0.56,
					[2] = 12.27,
				},
				[140] = 
				{
					[1] = 0.56,
					[2] = 12.28,
				},
				[141] = 
				{
					[1] = 0.57,
					[2] = 12.29,
				},
				[142] = 
				{
					[1] = 0.57,
					[2] = 12.29,
				},
				[143] = 
				{
					[1] = 0.57,
					[2] = 12.3,
				},
				[144] = 
				{
					[1] = 0.58,
					[2] = 12.3,
				},
				[145] = 
				{
					[1] = 0.58,
					[2] = 12.31,
				},
				[146] = 
				{
					[1] = 0.59,
					[2] = 12.31,
				},
				[147] = 
				{
					[1] = 0.59,
					[2] = 12.32,
				},
				[148] = 
				{
					[1] = 0.6,
					[2] = 12.32,
				},
				[149] = 
				{
					[1] = 0.6,
					[2] = 12.33,
				},
				[150] = 
				{
					[1] = 0.6,
					[2] = 12.33,
				},
				[151] = 
				{
					[1] = 0.61,
					[2] = 12.34,
				},
				[152] = 
				{
					[1] = 0.61,
					[2] = 12.35,
				},
				[153] = 
				{
					[1] = 0.62,
					[2] = 12.35,
				},
				[154] = 
				{
					[1] = 0.62,
					[2] = 12.36,
				},
				[155] = 
				{
					[1] = 0.62,
					[2] = 12.36,
				},
				[156] = 
				{
					[1] = 0.63,
					[2] = 12.37,
				},
				[157] = 
				{
					[1] = 0.63,
					[2] = 12.36,
				},
				[158] = 
				{
					[1] = 0.64,
					[2] = 12.36,
				},
				[159] = 
				{
					[1] = 0.64,
					[2] = 12.35,
				},
				[160] = 
				{
					[1] = 0.64,
					[2] = 12.35,
				},
				[161] = 
				{
					[1] = 0.65,
					[2] = 12.34,
				},
				[162] = 
				{
					[1] = 0.65,
					[2] = 12.33,
				},
				[163] = 
				{
					[1] = 0.66,
					[2] = 12.33,
				},
				[164] = 
				{
					[1] = 0.66,
					[2] = 12.32,
				},
				[165] = 
				{
					[1] = 0.66,
					[2] = 12.32,
				},
				[166] = 
				{
					[1] = 0.67,
					[2] = 12.31,
				},
				[167] = 
				{
					[1] = 0.67,
					[2] = 12.31,
				},
				[168] = 
				{
					[1] = 0.68,
					[2] = 12.3,
				},
				[169] = 
				{
					[1] = 0.68,
					[2] = 12.3,
				},
				[170] = 
				{
					[1] = 0.68,
					[2] = 12.31,
				},
				[171] = 
				{
					[1] = 0.69,
					[2] = 12.32,
				},
				[172] = 
				{
					[1] = 0.69,
					[2] = 12.32,
				},
				[173] = 
				{
					[1] = 0.7,
					[2] = 12.33,
				},
				[174] = 
				{
					[1] = 0.7,
					[2] = 12.34,
				},
				[175] = 
				{
					[1] = 0.7,
					[2] = 12.34,
				},
				[176] = 
				{
					[1] = 0.71,
					[2] = 12.35,
				},
				[177] = 
				{
					[1] = 0.71,
					[2] = 12.36,
				},
				[178] = 
				{
					[1] = 0.72,
					[2] = 12.36,
				},
				[179] = 
				{
					[1] = 0.72,
					[2] = 12.33,
				},
				[180] = 
				{
					[1] = 0.72,
					[2] = 12.24,
				},
				[181] = 
				{
					[1] = 0.73,
					[2] = 12.15,
				},
				[182] = 
				{
					[1] = 0.73,
					[2] = 12.06,
				},
				[183] = 
				{
					[1] = 0.74,
					[2] = 11.97,
				},
				[184] = 
				{
					[1] = 0.74,
					[2] = 11.88,
				},
				[185] = 
				{
					[1] = 0.74,
					[2] = 11.79,
				},
				[186] = 
				{
					[1] = 0.75,
					[2] = 11.69,
				},
				[187] = 
				{
					[1] = 0.75,
					[2] = 11.6,
				},
				[188] = 
				{
					[1] = 0.76,
					[2] = 11.51,
				},
				[189] = 
				{
					[1] = 0.76,
					[2] = 11.4,
				},
				[190] = 
				{
					[1] = 0.77,
					[2] = 11.27,
				},
				[191] = 
				{
					[1] = 0.77,
					[2] = 11.15,
				},
				[192] = 
				{
					[1] = 0.77,
					[2] = 11.02,
				},
				[193] = 
				{
					[1] = 0.78,
					[2] = 10.9,
				},
				[194] = 
				{
					[1] = 0.78,
					[2] = 10.77,
				},
				[195] = 
				{
					[1] = 0.79,
					[2] = 10.65,
				},
				[196] = 
				{
					[1] = 0.79,
					[2] = 10.52,
				},
				[197] = 
				{
					[1] = 0.79,
					[2] = 10.4,
				},
				[198] = 
				{
					[1] = 0.8,
					[2] = 10.27,
				},
				[199] = 
				{
					[1] = 0.8,
					[2] = 10.15,
				},
				[200] = 
				{
					[1] = 0.81,
					[2] = 10.05,
				},
				[201] = 
				{
					[1] = 0.81,
					[2] = 10.05,
				},
				[202] = 
				{
					[1] = 0.81,
					[2] = 10.05,
				},
				[203] = 
				{
					[1] = 0.82,
					[2] = 10.05,
				},
				[204] = 
				{
					[1] = 0.82,
					[2] = 10.05,
				},
				[205] = 
				{
					[1] = 0.83,
					[2] = 10.05,
				},
				[206] = 
				{
					[1] = 0.83,
					[2] = 9.93,
				},
				[207] = 
				{
					[1] = 0.83,
					[2] = 9.8,
				},
				[208] = 
				{
					[1] = 0.84,
					[2] = 9.68,
				},
				[209] = 
				{
					[1] = 0.84,
					[2] = 9.55,
				},
				[210] = 
				{
					[1] = 0.85,
					[2] = 9.43,
				},
				[211] = 
				{
					[1] = 0.85,
					[2] = 9.3,
				},
				[212] = 
				{
					[1] = 0.85,
					[2] = 9.18,
				},
				[213] = 
				{
					[1] = 0.86,
					[2] = 9.06,
				},
				[214] = 
				{
					[1] = 0.86,
					[2] = 8.93,
				},
				[215] = 
				{
					[1] = 0.87,
					[2] = 8.81,
				},
				[216] = 
				{
					[1] = 0.87,
					[2] = 8.68,
				},
				[217] = 
				{
					[1] = 0.87,
					[2] = 8.55,
				},
				[218] = 
				{
					[1] = 0.88,
					[2] = 8.37,
				},
				[219] = 
				{
					[1] = 0.88,
					[2] = 8.2,
				},
				[220] = 
				{
					[1] = 0.89,
					[2] = 8.04,
				},
				[221] = 
				{
					[1] = 0.89,
					[2] = 7.88,
				},
				[222] = 
				{
					[1] = 0.89,
					[2] = 7.72,
				},
				[223] = 
				{
					[1] = 0.9,
					[2] = 7.56,
				},
				[224] = 
				{
					[1] = 0.9,
					[2] = 7.4,
				},
				[225] = 
				{
					[1] = 0.91,
					[2] = 7.24,
				},
				[226] = 
				{
					[1] = 0.91,
					[2] = 7.08,
				},
				[227] = 
				{
					[1] = 0.91,
					[2] = 6.88,
				},
				[228] = 
				{
					[1] = 0.92,
					[2] = 6.61,
				},
				[229] = 
				{
					[1] = 0.92,
					[2] = 6.34,
				},
				[230] = 
				{
					[1] = 0.93,
					[2] = 6.07,
				},
				[231] = 
				{
					[1] = 0.93,
					[2] = 5.8,
				},
				[232] = 
				{
					[1] = 0.94,
					[2] = 5.53,
				},
				[233] = 
				{
					[1] = 0.94,
					[2] = 5.26,
				},
				[234] = 
				{
					[1] = 0.94,
					[2] = 4.99,
				},
				[235] = 
				{
					[1] = 0.95,
					[2] = 4.72,
				},
				[236] = 
				{
					[1] = 0.95,
					[2] = 4.45,
				},
				[237] = 
				{
					[1] = 0.96,
					[2] = 3.99,
				},
				[238] = 
				{
					[1] = 0.96,
					[2] = 3.6,
				},
				[239] = 
				{
					[1] = 0.96,
					[2] = 3.34,
				},
				[240] = 
				{
					[1] = 0.97,
					[2] = 3.08,
				},
				[241] = 
				{
					[1] = 0.97,
					[2] = 2.82,
				},
				[242] = 
				{
					[1] = 0.98,
					[2] = 2.57,
				},
				[243] = 
				{
					[1] = 0.98,
					[2] = 2.31,
				},
				[244] = 
				{
					[1] = 0.98,
					[2] = 2.05,
				},
				[245] = 
				{
					[1] = 0.99,
					[2] = 1.79,
				},
				[246] = 
				{
					[1] = 0.99,
					[2] = 1.53,
				},
				[247] = 
				{
					[1] = 1,
					[2] = 1.26,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.2,
				},
				[3] = 
				{
					[1] = 0.03,
					[2] = 0.27,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.32,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.36,
				},
				[6] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[7] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[8] = 
				{
					[1] = 0.11,
					[2] = 0.44,
				},
				[9] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[10] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[11] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[12] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[18] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[19] = 
				{
					[1] = 0.3,
					[2] = 0.5,
				},
				[20] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[21] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[22] = 
				{
					[1] = 0.34,
					[2] = 0.48,
				},
				[23] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[24] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[25] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[26] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[27] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[28] = 
				{
					[1] = 0.44,
					[2] = 0.43,
				},
				[29] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[30] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[31] = 
				{
					[1] = 0.49,
					[2] = 0.4,
				},
				[32] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[33] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[34] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[35] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[36] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[37] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[38] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[39] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[40] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[41] = 
				{
					[1] = 0.66,
					[2] = 0.28,
				},
				[42] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[43] = 
				{
					[1] = 0.69,
					[2] = 0.26,
				},
				[44] = 
				{
					[1] = 0.7,
					[2] = 0.24,
				},
				[45] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[46] = 
				{
					[1] = 0.74,
					[2] = 0.22,
				},
				[47] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[48] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[49] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[50] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[51] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[52] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[53] = 
				{
					[1] = 0.85,
					[2] = 0.12,
				},
				[54] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[55] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[56] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[57] = 
				{
					[1] = 0.92,
					[2] = 0.07,
				},
				[58] = 
				{
					[1] = 0.93,
					[2] = 0.05,
				},
				[59] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[60] = 
				{
					[1] = 0.97,
					[2] = 0.03,
				},
				[61] = 
				{
					[1] = 0.98,
					[2] = 0.01,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 13.07,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.43,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.92,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 1.17,
				},
				[6] = 
				{
					[1] = 0.01,
					[2] = 1.38,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 1.44,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 1.5,
				},
				[9] = 
				{
					[1] = 0.02,
					[2] = 1.56,
				},
				[10] = 
				{
					[1] = 0.02,
					[2] = 1.62,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 1.68,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 1.74,
				},
				[13] = 
				{
					[1] = 0.03,
					[2] = 1.8,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 1.85,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 1.91,
				},
				[16] = 
				{
					[1] = 0.04,
					[2] = 1.97,
				},
				[17] = 
				{
					[1] = 0.04,
					[2] = 2.03,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 2.08,
				},
				[19] = 
				{
					[1] = 0.05,
					[2] = 2.14,
				},
				[20] = 
				{
					[1] = 0.05,
					[2] = 2.2,
				},
				[21] = 
				{
					[1] = 0.05,
					[2] = 2.25,
				},
				[22] = 
				{
					[1] = 0.06,
					[2] = 2.31,
				},
				[23] = 
				{
					[1] = 0.06,
					[2] = 2.37,
				},
				[24] = 
				{
					[1] = 0.06,
					[2] = 2.42,
				},
				[25] = 
				{
					[1] = 0.06,
					[2] = 2.48,
				},
				[26] = 
				{
					[1] = 0.07,
					[2] = 2.53,
				},
				[27] = 
				{
					[1] = 0.07,
					[2] = 2.59,
				},
				[28] = 
				{
					[1] = 0.07,
					[2] = 2.65,
				},
				[29] = 
				{
					[1] = 0.08,
					[2] = 2.7,
				},
				[30] = 
				{
					[1] = 0.08,
					[2] = 2.76,
				},
				[31] = 
				{
					[1] = 0.08,
					[2] = 2.81,
				},
				[32] = 
				{
					[1] = 0.08,
					[2] = 2.87,
				},
				[33] = 
				{
					[1] = 0.09,
					[2] = 2.92,
				},
				[34] = 
				{
					[1] = 0.09,
					[2] = 2.97,
				},
				[35] = 
				{
					[1] = 0.09,
					[2] = 3.03,
				},
				[36] = 
				{
					[1] = 0.09,
					[2] = 3.08,
				},
				[37] = 
				{
					[1] = 0.1,
					[2] = 3.14,
				},
				[38] = 
				{
					[1] = 0.1,
					[2] = 3.19,
				},
				[39] = 
				{
					[1] = 0.1,
					[2] = 3.24,
				},
				[40] = 
				{
					[1] = 0.11,
					[2] = 3.3,
				},
				[41] = 
				{
					[1] = 0.11,
					[2] = 3.35,
				},
				[42] = 
				{
					[1] = 0.11,
					[2] = 3.4,
				},
				[43] = 
				{
					[1] = 0.11,
					[2] = 3.46,
				},
				[44] = 
				{
					[1] = 0.12,
					[2] = 3.51,
				},
				[45] = 
				{
					[1] = 0.12,
					[2] = 3.56,
				},
				[46] = 
				{
					[1] = 0.12,
					[2] = 3.61,
				},
				[47] = 
				{
					[1] = 0.12,
					[2] = 3.67,
				},
				[48] = 
				{
					[1] = 0.13,
					[2] = 3.72,
				},
				[49] = 
				{
					[1] = 0.13,
					[2] = 3.77,
				},
				[50] = 
				{
					[1] = 0.13,
					[2] = 3.82,
				},
				[51] = 
				{
					[1] = 0.14,
					[2] = 3.87,
				},
				[52] = 
				{
					[1] = 0.14,
					[2] = 3.93,
				},
				[53] = 
				{
					[1] = 0.14,
					[2] = 3.98,
				},
				[54] = 
				{
					[1] = 0.14,
					[2] = 4.03,
				},
				[55] = 
				{
					[1] = 0.15,
					[2] = 4.08,
				},
				[56] = 
				{
					[1] = 0.15,
					[2] = 4.13,
				},
				[57] = 
				{
					[1] = 0.15,
					[2] = 4.18,
				},
				[58] = 
				{
					[1] = 0.15,
					[2] = 4.23,
				},
				[59] = 
				{
					[1] = 0.16,
					[2] = 4.28,
				},
				[60] = 
				{
					[1] = 0.16,
					[2] = 4.33,
				},
				[61] = 
				{
					[1] = 0.16,
					[2] = 4.38,
				},
				[62] = 
				{
					[1] = 0.16,
					[2] = 4.43,
				},
				[63] = 
				{
					[1] = 0.17,
					[2] = 4.48,
				},
				[64] = 
				{
					[1] = 0.17,
					[2] = 4.52,
				},
				[65] = 
				{
					[1] = 0.17,
					[2] = 4.57,
				},
				[66] = 
				{
					[1] = 0.18,
					[2] = 4.61,
				},
				[67] = 
				{
					[1] = 0.18,
					[2] = 4.65,
				},
				[68] = 
				{
					[1] = 0.18,
					[2] = 4.69,
				},
				[69] = 
				{
					[1] = 0.18,
					[2] = 4.73,
				},
				[70] = 
				{
					[1] = 0.19,
					[2] = 4.77,
				},
				[71] = 
				{
					[1] = 0.19,
					[2] = 4.81,
				},
				[72] = 
				{
					[1] = 0.19,
					[2] = 4.85,
				},
				[73] = 
				{
					[1] = 0.19,
					[2] = 4.89,
				},
				[74] = 
				{
					[1] = 0.2,
					[2] = 4.93,
				},
				[75] = 
				{
					[1] = 0.2,
					[2] = 4.97,
				},
				[76] = 
				{
					[1] = 0.2,
					[2] = 5.01,
				},
				[77] = 
				{
					[1] = 0.21,
					[2] = 5.06,
				},
				[78] = 
				{
					[1] = 0.21,
					[2] = 5.1,
				},
				[79] = 
				{
					[1] = 0.21,
					[2] = 5.14,
				},
				[80] = 
				{
					[1] = 0.21,
					[2] = 5.18,
				},
				[81] = 
				{
					[1] = 0.22,
					[2] = 5.22,
				},
				[82] = 
				{
					[1] = 0.22,
					[2] = 5.26,
				},
				[83] = 
				{
					[1] = 0.22,
					[2] = 5.3,
				},
				[84] = 
				{
					[1] = 0.22,
					[2] = 5.34,
				},
				[85] = 
				{
					[1] = 0.23,
					[2] = 5.38,
				},
				[86] = 
				{
					[1] = 0.23,
					[2] = 5.42,
				},
				[87] = 
				{
					[1] = 0.23,
					[2] = 5.45,
				},
				[88] = 
				{
					[1] = 0.24,
					[2] = 5.49,
				},
				[89] = 
				{
					[1] = 0.24,
					[2] = 5.53,
				},
				[90] = 
				{
					[1] = 0.24,
					[2] = 5.57,
				},
				[91] = 
				{
					[1] = 0.24,
					[2] = 5.61,
				},
				[92] = 
				{
					[1] = 0.25,
					[2] = 5.65,
				},
				[93] = 
				{
					[1] = 0.25,
					[2] = 5.69,
				},
				[94] = 
				{
					[1] = 0.25,
					[2] = 5.73,
				},
				[95] = 
				{
					[1] = 0.25,
					[2] = 5.76,
				},
				[96] = 
				{
					[1] = 0.26,
					[2] = 5.8,
				},
				[97] = 
				{
					[1] = 0.26,
					[2] = 5.84,
				},
				[98] = 
				{
					[1] = 0.26,
					[2] = 5.88,
				},
				[99] = 
				{
					[1] = 0.26,
					[2] = 5.92,
				},
				[100] = 
				{
					[1] = 0.27,
					[2] = 5.95,
				},
				[101] = 
				{
					[1] = 0.27,
					[2] = 5.99,
				},
				[102] = 
				{
					[1] = 0.27,
					[2] = 6.03,
				},
				[103] = 
				{
					[1] = 0.28,
					[2] = 6.06,
				},
				[104] = 
				{
					[1] = 0.28,
					[2] = 6.1,
				},
				[105] = 
				{
					[1] = 0.28,
					[2] = 6.14,
				},
				[106] = 
				{
					[1] = 0.28,
					[2] = 6.17,
				},
				[107] = 
				{
					[1] = 0.29,
					[2] = 6.21,
				},
				[108] = 
				{
					[1] = 0.29,
					[2] = 6.25,
				},
				[109] = 
				{
					[1] = 0.29,
					[2] = 6.28,
				},
				[110] = 
				{
					[1] = 0.29,
					[2] = 6.32,
				},
				[111] = 
				{
					[1] = 0.3,
					[2] = 6.35,
				},
				[112] = 
				{
					[1] = 0.3,
					[2] = 6.39,
				},
				[113] = 
				{
					[1] = 0.3,
					[2] = 6.43,
				},
				[114] = 
				{
					[1] = 0.31,
					[2] = 6.46,
				},
				[115] = 
				{
					[1] = 0.31,
					[2] = 6.5,
				},
				[116] = 
				{
					[1] = 0.31,
					[2] = 6.53,
				},
				[117] = 
				{
					[1] = 0.31,
					[2] = 6.57,
				},
				[118] = 
				{
					[1] = 0.32,
					[2] = 6.6,
				},
				[119] = 
				{
					[1] = 0.32,
					[2] = 6.64,
				},
				[120] = 
				{
					[1] = 0.32,
					[2] = 6.67,
				},
				[121] = 
				{
					[1] = 0.32,
					[2] = 6.7,
				},
				[122] = 
				{
					[1] = 0.33,
					[2] = 6.74,
				},
				[123] = 
				{
					[1] = 0.33,
					[2] = 6.77,
				},
				[124] = 
				{
					[1] = 0.33,
					[2] = 6.81,
				},
				[125] = 
				{
					[1] = 0.34,
					[2] = 6.84,
				},
				[126] = 
				{
					[1] = 0.34,
					[2] = 6.87,
				},
				[127] = 
				{
					[1] = 0.34,
					[2] = 6.91,
				},
				[128] = 
				{
					[1] = 0.34,
					[2] = 6.94,
				},
				[129] = 
				{
					[1] = 0.35,
					[2] = 6.97,
				},
				[130] = 
				{
					[1] = 0.35,
					[2] = 7.01,
				},
				[131] = 
				{
					[1] = 0.35,
					[2] = 7.04,
				},
				[132] = 
				{
					[1] = 0.35,
					[2] = 7.07,
				},
				[133] = 
				{
					[1] = 0.36,
					[2] = 7.11,
				},
				[134] = 
				{
					[1] = 0.36,
					[2] = 7.14,
				},
				[135] = 
				{
					[1] = 0.36,
					[2] = 7.17,
				},
				[136] = 
				{
					[1] = 0.36,
					[2] = 7.2,
				},
				[137] = 
				{
					[1] = 0.37,
					[2] = 7.23,
				},
				[138] = 
				{
					[1] = 0.37,
					[2] = 7.27,
				},
				[139] = 
				{
					[1] = 0.37,
					[2] = 7.3,
				},
				[140] = 
				{
					[1] = 0.38,
					[2] = 7.33,
				},
				[141] = 
				{
					[1] = 0.38,
					[2] = 7.36,
				},
				[142] = 
				{
					[1] = 0.38,
					[2] = 7.4,
				},
				[143] = 
				{
					[1] = 0.38,
					[2] = 7.43,
				},
				[144] = 
				{
					[1] = 0.39,
					[2] = 7.46,
				},
				[145] = 
				{
					[1] = 0.39,
					[2] = 7.49,
				},
				[146] = 
				{
					[1] = 0.39,
					[2] = 7.53,
				},
				[147] = 
				{
					[1] = 0.39,
					[2] = 7.56,
				},
				[148] = 
				{
					[1] = 0.4,
					[2] = 7.59,
				},
				[149] = 
				{
					[1] = 0.4,
					[2] = 7.62,
				},
				[150] = 
				{
					[1] = 0.4,
					[2] = 7.65,
				},
				[151] = 
				{
					[1] = 0.41,
					[2] = 7.68,
				},
				[152] = 
				{
					[1] = 0.41,
					[2] = 7.71,
				},
				[153] = 
				{
					[1] = 0.41,
					[2] = 7.74,
				},
				[154] = 
				{
					[1] = 0.41,
					[2] = 7.77,
				},
				[155] = 
				{
					[1] = 0.42,
					[2] = 7.8,
				},
				[156] = 
				{
					[1] = 0.42,
					[2] = 7.83,
				},
				[157] = 
				{
					[1] = 0.42,
					[2] = 7.86,
				},
				[158] = 
				{
					[1] = 0.42,
					[2] = 7.89,
				},
				[159] = 
				{
					[1] = 0.43,
					[2] = 7.92,
				},
				[160] = 
				{
					[1] = 0.43,
					[2] = 7.95,
				},
				[161] = 
				{
					[1] = 0.43,
					[2] = 7.98,
				},
				[162] = 
				{
					[1] = 0.44,
					[2] = 8.01,
				},
				[163] = 
				{
					[1] = 0.44,
					[2] = 8.04,
				},
				[164] = 
				{
					[1] = 0.44,
					[2] = 8.06,
				},
				[165] = 
				{
					[1] = 0.44,
					[2] = 8.09,
				},
				[166] = 
				{
					[1] = 0.45,
					[2] = 8.12,
				},
				[167] = 
				{
					[1] = 0.45,
					[2] = 8.15,
				},
				[168] = 
				{
					[1] = 0.45,
					[2] = 8.18,
				},
				[169] = 
				{
					[1] = 0.45,
					[2] = 8.2,
				},
				[170] = 
				{
					[1] = 0.46,
					[2] = 8.23,
				},
				[171] = 
				{
					[1] = 0.46,
					[2] = 8.26,
				},
				[172] = 
				{
					[1] = 0.46,
					[2] = 8.29,
				},
				[173] = 
				{
					[1] = 0.46,
					[2] = 8.32,
				},
				[174] = 
				{
					[1] = 0.47,
					[2] = 8.34,
				},
				[175] = 
				{
					[1] = 0.47,
					[2] = 8.37,
				},
				[176] = 
				{
					[1] = 0.47,
					[2] = 8.4,
				},
				[177] = 
				{
					[1] = 0.48,
					[2] = 8.42,
				},
				[178] = 
				{
					[1] = 0.48,
					[2] = 8.45,
				},
				[179] = 
				{
					[1] = 0.48,
					[2] = 8.48,
				},
				[180] = 
				{
					[1] = 0.48,
					[2] = 8.5,
				},
				[181] = 
				{
					[1] = 0.49,
					[2] = 8.53,
				},
				[182] = 
				{
					[1] = 0.49,
					[2] = 8.55,
				},
				[183] = 
				{
					[1] = 0.49,
					[2] = 8.58,
				},
				[184] = 
				{
					[1] = 0.49,
					[2] = 8.61,
				},
				[185] = 
				{
					[1] = 0.5,
					[2] = 8.63,
				},
				[186] = 
				{
					[1] = 0.5,
					[2] = 8.66,
				},
				[187] = 
				{
					[1] = 0.5,
					[2] = 8.68,
				},
				[188] = 
				{
					[1] = 0.51,
					[2] = 8.71,
				},
				[189] = 
				{
					[1] = 0.51,
					[2] = 8.73,
				},
				[190] = 
				{
					[1] = 0.51,
					[2] = 8.76,
				},
				[191] = 
				{
					[1] = 0.51,
					[2] = 8.78,
				},
				[192] = 
				{
					[1] = 0.52,
					[2] = 8.81,
				},
				[193] = 
				{
					[1] = 0.52,
					[2] = 8.83,
				},
				[194] = 
				{
					[1] = 0.52,
					[2] = 8.86,
				},
				[195] = 
				{
					[1] = 0.52,
					[2] = 8.88,
				},
				[196] = 
				{
					[1] = 0.53,
					[2] = 8.9,
				},
				[197] = 
				{
					[1] = 0.53,
					[2] = 8.93,
				},
				[198] = 
				{
					[1] = 0.53,
					[2] = 8.95,
				},
				[199] = 
				{
					[1] = 0.54,
					[2] = 8.97,
				},
				[200] = 
				{
					[1] = 0.54,
					[2] = 9,
				},
				[201] = 
				{
					[1] = 0.54,
					[2] = 9.02,
				},
				[202] = 
				{
					[1] = 0.54,
					[2] = 9.04,
				},
				[203] = 
				{
					[1] = 0.55,
					[2] = 9.07,
				},
				[204] = 
				{
					[1] = 0.55,
					[2] = 9.09,
				},
				[205] = 
				{
					[1] = 0.55,
					[2] = 9.11,
				},
				[206] = 
				{
					[1] = 0.55,
					[2] = 9.13,
				},
				[207] = 
				{
					[1] = 0.56,
					[2] = 9.16,
				},
				[208] = 
				{
					[1] = 0.56,
					[2] = 9.18,
				},
				[209] = 
				{
					[1] = 0.56,
					[2] = 9.2,
				},
				[210] = 
				{
					[1] = 0.56,
					[2] = 9.22,
				},
				[211] = 
				{
					[1] = 0.57,
					[2] = 9.24,
				},
				[212] = 
				{
					[1] = 0.57,
					[2] = 9.27,
				},
				[213] = 
				{
					[1] = 0.57,
					[2] = 9.29,
				},
				[214] = 
				{
					[1] = 0.58,
					[2] = 9.31,
				},
				[215] = 
				{
					[1] = 0.58,
					[2] = 9.33,
				},
				[216] = 
				{
					[1] = 0.58,
					[2] = 9.35,
				},
				[217] = 
				{
					[1] = 0.58,
					[2] = 9.37,
				},
				[218] = 
				{
					[1] = 0.59,
					[2] = 9.39,
				},
				[219] = 
				{
					[1] = 0.59,
					[2] = 9.41,
				},
				[220] = 
				{
					[1] = 0.59,
					[2] = 9.41,
				},
				[221] = 
				{
					[1] = 0.59,
					[2] = 9.41,
				},
				[222] = 
				{
					[1] = 0.6,
					[2] = 9.41,
				},
				[223] = 
				{
					[1] = 0.6,
					[2] = 9.42,
				},
				[224] = 
				{
					[1] = 0.6,
					[2] = 9.42,
				},
				[225] = 
				{
					[1] = 0.61,
					[2] = 9.42,
				},
				[226] = 
				{
					[1] = 0.61,
					[2] = 9.42,
				},
				[227] = 
				{
					[1] = 0.61,
					[2] = 9.42,
				},
				[228] = 
				{
					[1] = 0.61,
					[2] = 9.42,
				},
				[229] = 
				{
					[1] = 0.62,
					[2] = 9.42,
				},
				[230] = 
				{
					[1] = 0.62,
					[2] = 9.42,
				},
				[231] = 
				{
					[1] = 0.62,
					[2] = 9.43,
				},
				[232] = 
				{
					[1] = 0.62,
					[2] = 9.43,
				},
				[233] = 
				{
					[1] = 0.63,
					[2] = 9.43,
				},
				[234] = 
				{
					[1] = 0.63,
					[2] = 9.43,
				},
				[235] = 
				{
					[1] = 0.63,
					[2] = 9.43,
				},
				[236] = 
				{
					[1] = 0.64,
					[2] = 9.44,
				},
				[237] = 
				{
					[1] = 0.64,
					[2] = 9.44,
				},
				[238] = 
				{
					[1] = 0.64,
					[2] = 9.44,
				},
				[239] = 
				{
					[1] = 0.64,
					[2] = 9.44,
				},
				[240] = 
				{
					[1] = 0.65,
					[2] = 9.44,
				},
				[241] = 
				{
					[1] = 0.65,
					[2] = 9.44,
				},
				[242] = 
				{
					[1] = 0.65,
					[2] = 9.44,
				},
				[243] = 
				{
					[1] = 0.65,
					[2] = 9.44,
				},
				[244] = 
				{
					[1] = 0.66,
					[2] = 9.45,
				},
				[245] = 
				{
					[1] = 0.66,
					[2] = 9.45,
				},
				[246] = 
				{
					[1] = 0.66,
					[2] = 9.45,
				},
				[247] = 
				{
					[1] = 0.66,
					[2] = 9.45,
				},
				[248] = 
				{
					[1] = 0.67,
					[2] = 9.45,
				},
				[249] = 
				{
					[1] = 0.67,
					[2] = 9.45,
				},
				[250] = 
				{
					[1] = 0.67,
					[2] = 9.45,
				},
				[251] = 
				{
					[1] = 0.68,
					[2] = 9.45,
				},
				[252] = 
				{
					[1] = 0.68,
					[2] = 9.45,
				},
				[253] = 
				{
					[1] = 0.68,
					[2] = 9.45,
				},
				[254] = 
				{
					[1] = 0.68,
					[2] = 9.45,
				},
				[255] = 
				{
					[1] = 0.69,
					[2] = 9.45,
				},
				[256] = 
				{
					[1] = 0.69,
					[2] = 9.45,
				},
				[257] = 
				{
					[1] = 0.69,
					[2] = 9.45,
				},
				[258] = 
				{
					[1] = 0.69,
					[2] = 9.45,
				},
				[259] = 
				{
					[1] = 0.7,
					[2] = 9.45,
				},
				[260] = 
				{
					[1] = 0.7,
					[2] = 9.45,
				},
				[261] = 
				{
					[1] = 0.7,
					[2] = 9.45,
				},
				[262] = 
				{
					[1] = 0.71,
					[2] = 9.45,
				},
				[263] = 
				{
					[1] = 0.71,
					[2] = 9.45,
				},
				[264] = 
				{
					[1] = 0.71,
					[2] = 9.45,
				},
				[265] = 
				{
					[1] = 0.71,
					[2] = 9.45,
				},
				[266] = 
				{
					[1] = 0.72,
					[2] = 9.45,
				},
				[267] = 
				{
					[1] = 0.72,
					[2] = 9.45,
				},
				[268] = 
				{
					[1] = 0.72,
					[2] = 9.45,
				},
				[269] = 
				{
					[1] = 0.72,
					[2] = 9.45,
				},
				[270] = 
				{
					[1] = 0.73,
					[2] = 9.45,
				},
				[271] = 
				{
					[1] = 0.73,
					[2] = 9.44,
				},
				[272] = 
				{
					[1] = 0.73,
					[2] = 9.44,
				},
				[273] = 
				{
					[1] = 0.74,
					[2] = 9.44,
				},
				[274] = 
				{
					[1] = 0.74,
					[2] = 9.44,
				},
				[275] = 
				{
					[1] = 0.74,
					[2] = 9.44,
				},
				[276] = 
				{
					[1] = 0.74,
					[2] = 9.44,
				},
				[277] = 
				{
					[1] = 0.75,
					[2] = 9.44,
				},
				[278] = 
				{
					[1] = 0.75,
					[2] = 9.43,
				},
				[279] = 
				{
					[1] = 0.75,
					[2] = 9.43,
				},
				[280] = 
				{
					[1] = 0.75,
					[2] = 9.43,
				},
				[281] = 
				{
					[1] = 0.76,
					[2] = 9.43,
				},
				[282] = 
				{
					[1] = 0.76,
					[2] = 9.43,
				},
				[283] = 
				{
					[1] = 0.76,
					[2] = 9.43,
				},
				[284] = 
				{
					[1] = 0.76,
					[2] = 9.42,
				},
				[285] = 
				{
					[1] = 0.77,
					[2] = 9.42,
				},
				[286] = 
				{
					[1] = 0.77,
					[2] = 9.42,
				},
				[287] = 
				{
					[1] = 0.77,
					[2] = 9.42,
				},
				[288] = 
				{
					[1] = 0.78,
					[2] = 9.41,
				},
				[289] = 
				{
					[1] = 0.78,
					[2] = 9.41,
				},
				[290] = 
				{
					[1] = 0.78,
					[2] = 9.41,
				},
				[291] = 
				{
					[1] = 0.78,
					[2] = 9.41,
				},
				[292] = 
				{
					[1] = 0.79,
					[2] = 9.4,
				},
				[293] = 
				{
					[1] = 0.79,
					[2] = 9.4,
				},
				[294] = 
				{
					[1] = 0.79,
					[2] = 9.4,
				},
				[295] = 
				{
					[1] = 0.79,
					[2] = 9.39,
				},
				[296] = 
				{
					[1] = 0.8,
					[2] = 9.39,
				},
				[297] = 
				{
					[1] = 0.8,
					[2] = 9.39,
				},
				[298] = 
				{
					[1] = 0.8,
					[2] = 9.38,
				},
				[299] = 
				{
					[1] = 0.81,
					[2] = 9.38,
				},
				[300] = 
				{
					[1] = 0.81,
					[2] = 9.38,
				},
				[301] = 
				{
					[1] = 0.81,
					[2] = 9.37,
				},
				[302] = 
				{
					[1] = 0.81,
					[2] = 9.37,
				},
				[303] = 
				{
					[1] = 0.82,
					[2] = 9.37,
				},
				[304] = 
				{
					[1] = 0.82,
					[2] = 9.36,
				},
				[305] = 
				{
					[1] = 0.82,
					[2] = 9.36,
				},
				[306] = 
				{
					[1] = 0.82,
					[2] = 9.36,
				},
				[307] = 
				{
					[1] = 0.83,
					[2] = 9.35,
				},
				[308] = 
				{
					[1] = 0.83,
					[2] = 9.35,
				},
				[309] = 
				{
					[1] = 0.83,
					[2] = 9.34,
				},
				[310] = 
				{
					[1] = 0.84,
					[2] = 9.34,
				},
				[311] = 
				{
					[1] = 0.84,
					[2] = 9.33,
				},
				[312] = 
				{
					[1] = 0.84,
					[2] = 9.33,
				},
				[313] = 
				{
					[1] = 0.84,
					[2] = 9.33,
				},
				[314] = 
				{
					[1] = 0.85,
					[2] = 9.32,
				},
				[315] = 
				{
					[1] = 0.85,
					[2] = 9.32,
				},
				[316] = 
				{
					[1] = 0.85,
					[2] = 9.31,
				},
				[317] = 
				{
					[1] = 0.85,
					[2] = 9.31,
				},
				[318] = 
				{
					[1] = 0.86,
					[2] = 9.31,
				},
				[319] = 
				{
					[1] = 0.86,
					[2] = 9.31,
				},
				[320] = 
				{
					[1] = 0.86,
					[2] = 9.3,
				},
				[321] = 
				{
					[1] = 0.86,
					[2] = 9.3,
				},
				[322] = 
				{
					[1] = 0.87,
					[2] = 9.3,
				},
				[323] = 
				{
					[1] = 0.87,
					[2] = 9.3,
				},
				[324] = 
				{
					[1] = 0.87,
					[2] = 9.29,
				},
				[325] = 
				{
					[1] = 0.88,
					[2] = 9.29,
				},
				[326] = 
				{
					[1] = 0.88,
					[2] = 9.29,
				},
				[327] = 
				{
					[1] = 0.88,
					[2] = 9.28,
				},
				[328] = 
				{
					[1] = 0.88,
					[2] = 9.28,
				},
				[329] = 
				{
					[1] = 0.89,
					[2] = 9.28,
				},
				[330] = 
				{
					[1] = 0.89,
					[2] = 9.27,
				},
				[331] = 
				{
					[1] = 0.89,
					[2] = 9.27,
				},
				[332] = 
				{
					[1] = 0.89,
					[2] = 9.26,
				},
				[333] = 
				{
					[1] = 0.9,
					[2] = 9.26,
				},
				[334] = 
				{
					[1] = 0.9,
					[2] = 9.26,
				},
				[335] = 
				{
					[1] = 0.9,
					[2] = 9.25,
				},
				[336] = 
				{
					[1] = 0.91,
					[2] = 9.25,
				},
				[337] = 
				{
					[1] = 0.91,
					[2] = 9.24,
				},
				[338] = 
				{
					[1] = 0.91,
					[2] = 9.24,
				},
				[339] = 
				{
					[1] = 0.91,
					[2] = 9.23,
				},
				[340] = 
				{
					[1] = 0.92,
					[2] = 9.23,
				},
				[341] = 
				{
					[1] = 0.92,
					[2] = 9.22,
				},
				[342] = 
				{
					[1] = 0.92,
					[2] = 9.22,
				},
				[343] = 
				{
					[1] = 0.92,
					[2] = 9.21,
				},
				[344] = 
				{
					[1] = 0.93,
					[2] = 9.21,
				},
				[345] = 
				{
					[1] = 0.93,
					[2] = 9.2,
				},
				[346] = 
				{
					[1] = 0.93,
					[2] = 9.2,
				},
				[347] = 
				{
					[1] = 0.94,
					[2] = 9.19,
				},
				[348] = 
				{
					[1] = 0.94,
					[2] = 9.18,
				},
				[349] = 
				{
					[1] = 0.94,
					[2] = 9.18,
				},
				[350] = 
				{
					[1] = 0.94,
					[2] = 9.17,
				},
				[351] = 
				{
					[1] = 0.95,
					[2] = 9.17,
				},
				[352] = 
				{
					[1] = 0.95,
					[2] = 9.16,
				},
				[353] = 
				{
					[1] = 0.95,
					[2] = 9.16,
				},
				[354] = 
				{
					[1] = 0.95,
					[2] = 9.15,
				},
				[355] = 
				{
					[1] = 0.96,
					[2] = 9.14,
				},
				[356] = 
				{
					[1] = 0.96,
					[2] = 9.14,
				},
				[357] = 
				{
					[1] = 0.96,
					[2] = 9.13,
				},
				[358] = 
				{
					[1] = 0.96,
					[2] = 9.12,
				},
				[359] = 
				{
					[1] = 0.97,
					[2] = 9.12,
				},
				[360] = 
				{
					[1] = 0.97,
					[2] = 9.11,
				},
				[361] = 
				{
					[1] = 0.97,
					[2] = 9.1,
				},
				[362] = 
				{
					[1] = 0.98,
					[2] = 9.1,
				},
				[363] = 
				{
					[1] = 0.98,
					[2] = 9.09,
				},
				[364] = 
				{
					[1] = 0.98,
					[2] = 9.08,
				},
				[365] = 
				{
					[1] = 0.98,
					[2] = 9.08,
				},
				[366] = 
				{
					[1] = 0.99,
					[2] = 9.07,
				},
				[367] = 
				{
					[1] = 0.99,
					[2] = 9.06,
				},
				[368] = 
				{
					[1] = 0.99,
					[2] = 9.05,
				},
				[369] = 
				{
					[1] = 0.99,
					[2] = 9.05,
				},
				[370] = 
				{
					[1] = 1,
					[2] = 9.04,
				},
			},
			["WidthScale"] = 0.55,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Kaga",
		["Type"] = "WaterTracer",
	},
	[244] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 217.813889,
			["Lifetime"] = 21.17,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.017,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 5,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 313.396851,
			["Lifetime"] = 30.459999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 1,
			["WidthScale"] = 2.89,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 71.610046,
			["Lifetime"] = 6.96,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0213,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Kaga",
		["Type"] = "WaterTracer",
	},
	[245] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 225.100006,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0222,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.52,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.76,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 1,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.18,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 1.33,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.47,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 1.61,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 1.75,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 1.87,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 2.02,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 2.18,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 2.33,
				},
				[14] = 
				{
					[1] = 0.06,
					[2] = 2.48,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 2.62,
				},
				[16] = 
				{
					[1] = 0.07,
					[2] = 2.78,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 2.93,
				},
				[18] = 
				{
					[1] = 0.08,
					[2] = 3.09,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 3.25,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 3.41,
				},
				[21] = 
				{
					[1] = 0.09,
					[2] = 3.57,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 3.74,
				},
				[23] = 
				{
					[1] = 0.1,
					[2] = 3.95,
				},
				[24] = 
				{
					[1] = 0.1,
					[2] = 4.16,
				},
				[25] = 
				{
					[1] = 0.11,
					[2] = 4.37,
				},
				[26] = 
				{
					[1] = 0.11,
					[2] = 4.58,
				},
				[27] = 
				{
					[1] = 0.12,
					[2] = 4.78,
				},
				[28] = 
				{
					[1] = 0.12,
					[2] = 4.99,
				},
				[29] = 
				{
					[1] = 0.12,
					[2] = 5.19,
				},
				[30] = 
				{
					[1] = 0.13,
					[2] = 5.39,
				},
				[31] = 
				{
					[1] = 0.13,
					[2] = 5.6,
				},
				[32] = 
				{
					[1] = 0.14,
					[2] = 5.8,
				},
				[33] = 
				{
					[1] = 0.14,
					[2] = 6,
				},
				[34] = 
				{
					[1] = 0.15,
					[2] = 6.21,
				},
				[35] = 
				{
					[1] = 0.15,
					[2] = 6.41,
				},
				[36] = 
				{
					[1] = 0.16,
					[2] = 6.62,
				},
				[37] = 
				{
					[1] = 0.16,
					[2] = 6.86,
				},
				[38] = 
				{
					[1] = 0.16,
					[2] = 7.12,
				},
				[39] = 
				{
					[1] = 0.17,
					[2] = 7.38,
				},
				[40] = 
				{
					[1] = 0.17,
					[2] = 7.63,
				},
				[41] = 
				{
					[1] = 0.18,
					[2] = 7.89,
				},
				[42] = 
				{
					[1] = 0.18,
					[2] = 8.15,
				},
				[43] = 
				{
					[1] = 0.19,
					[2] = 8.41,
				},
				[44] = 
				{
					[1] = 0.19,
					[2] = 8.67,
				},
				[45] = 
				{
					[1] = 0.2,
					[2] = 8.93,
				},
				[46] = 
				{
					[1] = 0.2,
					[2] = 9.17,
				},
				[47] = 
				{
					[1] = 0.2,
					[2] = 9.39,
				},
				[48] = 
				{
					[1] = 0.21,
					[2] = 9.62,
				},
				[49] = 
				{
					[1] = 0.21,
					[2] = 9.84,
				},
				[50] = 
				{
					[1] = 0.22,
					[2] = 10.07,
				},
				[51] = 
				{
					[1] = 0.22,
					[2] = 10.29,
				},
				[52] = 
				{
					[1] = 0.23,
					[2] = 10.52,
				},
				[53] = 
				{
					[1] = 0.23,
					[2] = 10.74,
				},
				[54] = 
				{
					[1] = 0.24,
					[2] = 10.96,
				},
				[55] = 
				{
					[1] = 0.24,
					[2] = 11.18,
				},
				[56] = 
				{
					[1] = 0.24,
					[2] = 11.37,
				},
				[57] = 
				{
					[1] = 0.25,
					[2] = 11.56,
				},
				[58] = 
				{
					[1] = 0.25,
					[2] = 11.75,
				},
				[59] = 
				{
					[1] = 0.26,
					[2] = 11.93,
				},
				[60] = 
				{
					[1] = 0.26,
					[2] = 12.12,
				},
				[61] = 
				{
					[1] = 0.27,
					[2] = 12.31,
				},
				[62] = 
				{
					[1] = 0.27,
					[2] = 12.5,
				},
				[63] = 
				{
					[1] = 0.28,
					[2] = 12.69,
				},
				[64] = 
				{
					[1] = 0.28,
					[2] = 12.82,
				},
				[65] = 
				{
					[1] = 0.28,
					[2] = 12.95,
				},
				[66] = 
				{
					[1] = 0.29,
					[2] = 13.07,
				},
				[67] = 
				{
					[1] = 0.29,
					[2] = 13.19,
				},
				[68] = 
				{
					[1] = 0.3,
					[2] = 13.31,
				},
				[69] = 
				{
					[1] = 0.3,
					[2] = 13.43,
				},
				[70] = 
				{
					[1] = 0.31,
					[2] = 13.56,
				},
				[71] = 
				{
					[1] = 0.31,
					[2] = 13.68,
				},
				[72] = 
				{
					[1] = 0.32,
					[2] = 13.8,
				},
				[73] = 
				{
					[1] = 0.32,
					[2] = 13.91,
				},
				[74] = 
				{
					[1] = 0.32,
					[2] = 13.96,
				},
				[75] = 
				{
					[1] = 0.33,
					[2] = 14.02,
				},
				[76] = 
				{
					[1] = 0.33,
					[2] = 14.08,
				},
				[77] = 
				{
					[1] = 0.34,
					[2] = 14.14,
				},
				[78] = 
				{
					[1] = 0.34,
					[2] = 14.2,
				},
				[79] = 
				{
					[1] = 0.35,
					[2] = 14.25,
				},
				[80] = 
				{
					[1] = 0.35,
					[2] = 14.31,
				},
				[81] = 
				{
					[1] = 0.36,
					[2] = 14.37,
				},
				[82] = 
				{
					[1] = 0.36,
					[2] = 14.43,
				},
				[83] = 
				{
					[1] = 0.36,
					[2] = 14.49,
				},
				[84] = 
				{
					[1] = 0.37,
					[2] = 14.55,
				},
				[85] = 
				{
					[1] = 0.37,
					[2] = 14.6,
				},
				[86] = 
				{
					[1] = 0.38,
					[2] = 14.64,
				},
				[87] = 
				{
					[1] = 0.38,
					[2] = 14.68,
				},
				[88] = 
				{
					[1] = 0.39,
					[2] = 14.72,
				},
				[89] = 
				{
					[1] = 0.39,
					[2] = 14.76,
				},
				[90] = 
				{
					[1] = 0.4,
					[2] = 14.79,
				},
				[91] = 
				{
					[1] = 0.4,
					[2] = 14.83,
				},
				[92] = 
				{
					[1] = 0.4,
					[2] = 14.87,
				},
				[93] = 
				{
					[1] = 0.41,
					[2] = 14.9,
				},
				[94] = 
				{
					[1] = 0.41,
					[2] = 14.94,
				},
				[95] = 
				{
					[1] = 0.42,
					[2] = 14.98,
				},
				[96] = 
				{
					[1] = 0.42,
					[2] = 15.01,
				},
				[97] = 
				{
					[1] = 0.43,
					[2] = 15.05,
				},
				[98] = 
				{
					[1] = 0.43,
					[2] = 15.09,
				},
				[99] = 
				{
					[1] = 0.44,
					[2] = 15.11,
				},
				[100] = 
				{
					[1] = 0.44,
					[2] = 15.11,
				},
				[101] = 
				{
					[1] = 0.44,
					[2] = 15.12,
				},
				[102] = 
				{
					[1] = 0.45,
					[2] = 15.12,
				},
				[103] = 
				{
					[1] = 0.45,
					[2] = 15.13,
				},
				[104] = 
				{
					[1] = 0.46,
					[2] = 15.13,
				},
				[105] = 
				{
					[1] = 0.46,
					[2] = 15.13,
				},
				[106] = 
				{
					[1] = 0.47,
					[2] = 15.14,
				},
				[107] = 
				{
					[1] = 0.47,
					[2] = 15.14,
				},
				[108] = 
				{
					[1] = 0.48,
					[2] = 15.14,
				},
				[109] = 
				{
					[1] = 0.48,
					[2] = 15.14,
				},
				[110] = 
				{
					[1] = 0.48,
					[2] = 15.14,
				},
				[111] = 
				{
					[1] = 0.49,
					[2] = 15.15,
				},
				[112] = 
				{
					[1] = 0.49,
					[2] = 15.15,
				},
				[113] = 
				{
					[1] = 0.5,
					[2] = 15.16,
				},
				[114] = 
				{
					[1] = 0.5,
					[2] = 15.16,
				},
				[115] = 
				{
					[1] = 0.51,
					[2] = 15.16,
				},
				[116] = 
				{
					[1] = 0.51,
					[2] = 15.17,
				},
				[117] = 
				{
					[1] = 0.52,
					[2] = 15.17,
				},
				[118] = 
				{
					[1] = 0.52,
					[2] = 15.17,
				},
				[119] = 
				{
					[1] = 0.52,
					[2] = 15.18,
				},
				[120] = 
				{
					[1] = 0.53,
					[2] = 15.16,
				},
				[121] = 
				{
					[1] = 0.53,
					[2] = 15.17,
				},
				[122] = 
				{
					[1] = 0.54,
					[2] = 15.17,
				},
				[123] = 
				{
					[1] = 0.54,
					[2] = 15.17,
				},
				[124] = 
				{
					[1] = 0.55,
					[2] = 15.18,
				},
				[125] = 
				{
					[1] = 0.55,
					[2] = 15.18,
				},
				[126] = 
				{
					[1] = 0.56,
					[2] = 15.18,
				},
				[127] = 
				{
					[1] = 0.56,
					[2] = 15.19,
				},
				[128] = 
				{
					[1] = 0.56,
					[2] = 15.19,
				},
				[129] = 
				{
					[1] = 0.57,
					[2] = 15.19,
				},
				[130] = 
				{
					[1] = 0.57,
					[2] = 15.2,
				},
				[131] = 
				{
					[1] = 0.58,
					[2] = 15.2,
				},
				[132] = 
				{
					[1] = 0.58,
					[2] = 15.17,
				},
				[133] = 
				{
					[1] = 0.59,
					[2] = 15.15,
				},
				[134] = 
				{
					[1] = 0.59,
					[2] = 15.13,
				},
				[135] = 
				{
					[1] = 0.6,
					[2] = 15.11,
				},
				[136] = 
				{
					[1] = 0.6,
					[2] = 15.09,
				},
				[137] = 
				{
					[1] = 0.6,
					[2] = 15.07,
				},
				[138] = 
				{
					[1] = 0.61,
					[2] = 15.05,
				},
				[139] = 
				{
					[1] = 0.61,
					[2] = 15.03,
				},
				[140] = 
				{
					[1] = 0.62,
					[2] = 15.01,
				},
				[141] = 
				{
					[1] = 0.62,
					[2] = 14.99,
				},
				[142] = 
				{
					[1] = 0.63,
					[2] = 14.97,
				},
				[143] = 
				{
					[1] = 0.63,
					[2] = 14.95,
				},
				[144] = 
				{
					[1] = 0.64,
					[2] = 14.93,
				},
				[145] = 
				{
					[1] = 0.64,
					[2] = 14.87,
				},
				[146] = 
				{
					[1] = 0.64,
					[2] = 14.8,
				},
				[147] = 
				{
					[1] = 0.65,
					[2] = 14.74,
				},
				[148] = 
				{
					[1] = 0.65,
					[2] = 14.68,
				},
				[149] = 
				{
					[1] = 0.66,
					[2] = 14.62,
				},
				[150] = 
				{
					[1] = 0.66,
					[2] = 14.56,
				},
				[151] = 
				{
					[1] = 0.67,
					[2] = 14.51,
				},
				[152] = 
				{
					[1] = 0.67,
					[2] = 14.45,
				},
				[153] = 
				{
					[1] = 0.68,
					[2] = 14.39,
				},
				[154] = 
				{
					[1] = 0.68,
					[2] = 14.33,
				},
				[155] = 
				{
					[1] = 0.68,
					[2] = 14.27,
				},
				[156] = 
				{
					[1] = 0.69,
					[2] = 14.21,
				},
				[157] = 
				{
					[1] = 0.69,
					[2] = 14.15,
				},
				[158] = 
				{
					[1] = 0.7,
					[2] = 14.08,
				},
				[159] = 
				{
					[1] = 0.7,
					[2] = 13.98,
				},
				[160] = 
				{
					[1] = 0.71,
					[2] = 13.91,
				},
				[161] = 
				{
					[1] = 0.71,
					[2] = 13.83,
				},
				[162] = 
				{
					[1] = 0.72,
					[2] = 13.75,
				},
				[163] = 
				{
					[1] = 0.72,
					[2] = 13.67,
				},
				[164] = 
				{
					[1] = 0.72,
					[2] = 13.6,
				},
				[165] = 
				{
					[1] = 0.73,
					[2] = 13.52,
				},
				[166] = 
				{
					[1] = 0.73,
					[2] = 13.38,
				},
				[167] = 
				{
					[1] = 0.74,
					[2] = 13.26,
				},
				[168] = 
				{
					[1] = 0.74,
					[2] = 13.15,
				},
				[169] = 
				{
					[1] = 0.75,
					[2] = 13.03,
				},
				[170] = 
				{
					[1] = 0.75,
					[2] = 12.92,
				},
				[171] = 
				{
					[1] = 0.76,
					[2] = 12.81,
				},
				[172] = 
				{
					[1] = 0.76,
					[2] = 12.7,
				},
				[173] = 
				{
					[1] = 0.76,
					[2] = 12.59,
				},
				[174] = 
				{
					[1] = 0.77,
					[2] = 12.48,
				},
				[175] = 
				{
					[1] = 0.77,
					[2] = 12.37,
				},
				[176] = 
				{
					[1] = 0.78,
					[2] = 12.26,
				},
				[177] = 
				{
					[1] = 0.78,
					[2] = 12.15,
				},
				[178] = 
				{
					[1] = 0.79,
					[2] = 12.01,
				},
				[179] = 
				{
					[1] = 0.79,
					[2] = 11.85,
				},
				[180] = 
				{
					[1] = 0.8,
					[2] = 11.71,
				},
				[181] = 
				{
					[1] = 0.8,
					[2] = 11.57,
				},
				[182] = 
				{
					[1] = 0.8,
					[2] = 11.43,
				},
				[183] = 
				{
					[1] = 0.81,
					[2] = 11.28,
				},
				[184] = 
				{
					[1] = 0.81,
					[2] = 11.14,
				},
				[185] = 
				{
					[1] = 0.82,
					[2] = 11,
				},
				[186] = 
				{
					[1] = 0.82,
					[2] = 10.86,
				},
				[187] = 
				{
					[1] = 0.83,
					[2] = 10.72,
				},
				[188] = 
				{
					[1] = 0.83,
					[2] = 10.58,
				},
				[189] = 
				{
					[1] = 0.84,
					[2] = 10.43,
				},
				[190] = 
				{
					[1] = 0.84,
					[2] = 10.28,
				},
				[191] = 
				{
					[1] = 0.84,
					[2] = 10.09,
				},
				[192] = 
				{
					[1] = 0.85,
					[2] = 9.9,
				},
				[193] = 
				{
					[1] = 0.85,
					[2] = 9.71,
				},
				[194] = 
				{
					[1] = 0.86,
					[2] = 9.52,
				},
				[195] = 
				{
					[1] = 0.86,
					[2] = 9.33,
				},
				[196] = 
				{
					[1] = 0.87,
					[2] = 9.14,
				},
				[197] = 
				{
					[1] = 0.87,
					[2] = 8.95,
				},
				[198] = 
				{
					[1] = 0.88,
					[2] = 8.75,
				},
				[199] = 
				{
					[1] = 0.88,
					[2] = 8.54,
				},
				[200] = 
				{
					[1] = 0.88,
					[2] = 8.34,
				},
				[201] = 
				{
					[1] = 0.89,
					[2] = 8.13,
				},
				[202] = 
				{
					[1] = 0.89,
					[2] = 7.93,
				},
				[203] = 
				{
					[1] = 0.9,
					[2] = 7.72,
				},
				[204] = 
				{
					[1] = 0.9,
					[2] = 7.46,
				},
				[205] = 
				{
					[1] = 0.91,
					[2] = 7.2,
				},
				[206] = 
				{
					[1] = 0.91,
					[2] = 6.94,
				},
				[207] = 
				{
					[1] = 0.92,
					[2] = 6.68,
				},
				[208] = 
				{
					[1] = 0.92,
					[2] = 6.42,
				},
				[209] = 
				{
					[1] = 0.92,
					[2] = 6.16,
				},
				[210] = 
				{
					[1] = 0.93,
					[2] = 5.87,
				},
				[211] = 
				{
					[1] = 0.93,
					[2] = 5.59,
				},
				[212] = 
				{
					[1] = 0.94,
					[2] = 5.31,
				},
				[213] = 
				{
					[1] = 0.94,
					[2] = 5.03,
				},
				[214] = 
				{
					[1] = 0.95,
					[2] = 4.75,
				},
				[215] = 
				{
					[1] = 0.95,
					[2] = 4.47,
				},
				[216] = 
				{
					[1] = 0.96,
					[2] = 4.2,
				},
				[217] = 
				{
					[1] = 0.96,
					[2] = 3.92,
				},
				[218] = 
				{
					[1] = 0.96,
					[2] = 3.65,
				},
				[219] = 
				{
					[1] = 0.97,
					[2] = 3.37,
				},
				[220] = 
				{
					[1] = 0.97,
					[2] = 3.1,
				},
				[221] = 
				{
					[1] = 0.98,
					[2] = 2.82,
				},
				[222] = 
				{
					[1] = 0.98,
					[2] = 2.55,
				},
				[223] = 
				{
					[1] = 0.99,
					[2] = 2.21,
				},
				[224] = 
				{
					[1] = 0.99,
					[2] = 1.73,
				},
				[225] = 
				{
					[1] = 1,
					[2] = 1.29,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.2,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.28,
				},
				[4] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[5] = 
				{
					[1] = 0.07,
					[2] = 0.37,
				},
				[6] = 
				{
					[1] = 0.09,
					[2] = 0.4,
				},
				[7] = 
				{
					[1] = 0.11,
					[2] = 0.43,
				},
				[8] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[9] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[10] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[12] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[13] = 
				{
					[1] = 0.21,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.25,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[17] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[18] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[19] = 
				{
					[1] = 0.32,
					[2] = 0.49,
				},
				[20] = 
				{
					[1] = 0.34,
					[2] = 0.48,
				},
				[21] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[22] = 
				{
					[1] = 0.38,
					[2] = 0.47,
				},
				[23] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[24] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[25] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[26] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[27] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[28] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[29] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[30] = 
				{
					[1] = 0.52,
					[2] = 0.39,
				},
				[31] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[32] = 
				{
					[1] = 0.55,
					[2] = 0.36,
				},
				[33] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[34] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[35] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[36] = 
				{
					[1] = 0.63,
					[2] = 0.31,
				},
				[37] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[38] = 
				{
					[1] = 0.66,
					[2] = 0.28,
				},
				[39] = 
				{
					[1] = 0.68,
					[2] = 0.26,
				},
				[40] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[41] = 
				{
					[1] = 0.71,
					[2] = 0.23,
				},
				[42] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[43] = 
				{
					[1] = 0.75,
					[2] = 0.2,
				},
				[44] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[45] = 
				{
					[1] = 0.79,
					[2] = 0.18,
				},
				[46] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[47] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[48] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[49] = 
				{
					[1] = 0.86,
					[2] = 0.12,
				},
				[50] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[51] = 
				{
					[1] = 0.89,
					[2] = 0.09,
				},
				[52] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[53] = 
				{
					[1] = 0.93,
					[2] = 0.06,
				},
				[54] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[55] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
				[56] = 
				{
					[1] = 0.98,
					[2] = 0.01,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 8,
			["LocalSpace"] = true,
			["MaxSpeed"] = 10.2888,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.19,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.33,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.48,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.62,
				},
				[6] = 
				{
					[1] = 0.01,
					[2] = 0.76,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.89,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 0.94,
				},
				[9] = 
				{
					[1] = 0.02,
					[2] = 0.96,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.99,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 1.02,
				},
				[12] = 
				{
					[1] = 0.03,
					[2] = 1.07,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 1.11,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 1.16,
				},
				[15] = 
				{
					[1] = 0.04,
					[2] = 1.2,
				},
				[16] = 
				{
					[1] = 0.04,
					[2] = 1.25,
				},
				[17] = 
				{
					[1] = 0.05,
					[2] = 1.29,
				},
				[18] = 
				{
					[1] = 0.05,
					[2] = 1.34,
				},
				[19] = 
				{
					[1] = 0.05,
					[2] = 1.38,
				},
				[20] = 
				{
					[1] = 0.06,
					[2] = 1.43,
				},
				[21] = 
				{
					[1] = 0.06,
					[2] = 1.47,
				},
				[22] = 
				{
					[1] = 0.06,
					[2] = 1.52,
				},
				[23] = 
				{
					[1] = 0.07,
					[2] = 1.56,
				},
				[24] = 
				{
					[1] = 0.07,
					[2] = 1.61,
				},
				[25] = 
				{
					[1] = 0.07,
					[2] = 1.65,
				},
				[26] = 
				{
					[1] = 0.07,
					[2] = 1.69,
				},
				[27] = 
				{
					[1] = 0.08,
					[2] = 1.74,
				},
				[28] = 
				{
					[1] = 0.08,
					[2] = 1.78,
				},
				[29] = 
				{
					[1] = 0.08,
					[2] = 1.83,
				},
				[30] = 
				{
					[1] = 0.09,
					[2] = 1.87,
				},
				[31] = 
				{
					[1] = 0.09,
					[2] = 1.91,
				},
				[32] = 
				{
					[1] = 0.09,
					[2] = 1.95,
				},
				[33] = 
				{
					[1] = 0.09,
					[2] = 2,
				},
				[34] = 
				{
					[1] = 0.1,
					[2] = 2.04,
				},
				[35] = 
				{
					[1] = 0.1,
					[2] = 2.08,
				},
				[36] = 
				{
					[1] = 0.1,
					[2] = 2.12,
				},
				[37] = 
				{
					[1] = 0.11,
					[2] = 2.14,
				},
				[38] = 
				{
					[1] = 0.11,
					[2] = 2.16,
				},
				[39] = 
				{
					[1] = 0.11,
					[2] = 2.18,
				},
				[40] = 
				{
					[1] = 0.12,
					[2] = 2.2,
				},
				[41] = 
				{
					[1] = 0.12,
					[2] = 2.23,
				},
				[42] = 
				{
					[1] = 0.12,
					[2] = 2.25,
				},
				[43] = 
				{
					[1] = 0.12,
					[2] = 2.27,
				},
				[44] = 
				{
					[1] = 0.13,
					[2] = 2.3,
				},
				[45] = 
				{
					[1] = 0.13,
					[2] = 2.32,
				},
				[46] = 
				{
					[1] = 0.13,
					[2] = 2.34,
				},
				[47] = 
				{
					[1] = 0.14,
					[2] = 2.36,
				},
				[48] = 
				{
					[1] = 0.14,
					[2] = 2.39,
				},
				[49] = 
				{
					[1] = 0.14,
					[2] = 2.41,
				},
				[50] = 
				{
					[1] = 0.15,
					[2] = 2.43,
				},
				[51] = 
				{
					[1] = 0.15,
					[2] = 2.45,
				},
				[52] = 
				{
					[1] = 0.15,
					[2] = 2.48,
				},
				[53] = 
				{
					[1] = 0.15,
					[2] = 2.5,
				},
				[54] = 
				{
					[1] = 0.16,
					[2] = 2.52,
				},
				[55] = 
				{
					[1] = 0.16,
					[2] = 2.54,
				},
				[56] = 
				{
					[1] = 0.16,
					[2] = 2.56,
				},
				[57] = 
				{
					[1] = 0.17,
					[2] = 2.59,
				},
				[58] = 
				{
					[1] = 0.17,
					[2] = 2.61,
				},
				[59] = 
				{
					[1] = 0.17,
					[2] = 2.63,
				},
				[60] = 
				{
					[1] = 0.18,
					[2] = 2.65,
				},
				[61] = 
				{
					[1] = 0.18,
					[2] = 2.67,
				},
				[62] = 
				{
					[1] = 0.18,
					[2] = 2.69,
				},
				[63] = 
				{
					[1] = 0.18,
					[2] = 2.71,
				},
				[64] = 
				{
					[1] = 0.19,
					[2] = 2.74,
				},
				[65] = 
				{
					[1] = 0.19,
					[2] = 2.76,
				},
				[66] = 
				{
					[1] = 0.19,
					[2] = 2.78,
				},
				[67] = 
				{
					[1] = 0.2,
					[2] = 2.8,
				},
				[68] = 
				{
					[1] = 0.2,
					[2] = 2.82,
				},
				[69] = 
				{
					[1] = 0.2,
					[2] = 2.84,
				},
				[70] = 
				{
					[1] = 0.2,
					[2] = 2.86,
				},
				[71] = 
				{
					[1] = 0.21,
					[2] = 2.88,
				},
				[72] = 
				{
					[1] = 0.21,
					[2] = 2.9,
				},
				[73] = 
				{
					[1] = 0.21,
					[2] = 2.92,
				},
				[74] = 
				{
					[1] = 0.22,
					[2] = 2.94,
				},
				[75] = 
				{
					[1] = 0.22,
					[2] = 2.96,
				},
				[76] = 
				{
					[1] = 0.22,
					[2] = 2.98,
				},
				[77] = 
				{
					[1] = 0.23,
					[2] = 3,
				},
				[78] = 
				{
					[1] = 0.23,
					[2] = 3.02,
				},
				[79] = 
				{
					[1] = 0.23,
					[2] = 3.04,
				},
				[80] = 
				{
					[1] = 0.23,
					[2] = 3.06,
				},
				[81] = 
				{
					[1] = 0.24,
					[2] = 3.08,
				},
				[82] = 
				{
					[1] = 0.24,
					[2] = 3.1,
				},
				[83] = 
				{
					[1] = 0.24,
					[2] = 3.12,
				},
				[84] = 
				{
					[1] = 0.25,
					[2] = 3.14,
				},
				[85] = 
				{
					[1] = 0.25,
					[2] = 3.16,
				},
				[86] = 
				{
					[1] = 0.25,
					[2] = 3.18,
				},
				[87] = 
				{
					[1] = 0.26,
					[2] = 3.19,
				},
				[88] = 
				{
					[1] = 0.26,
					[2] = 3.2,
				},
				[89] = 
				{
					[1] = 0.26,
					[2] = 3.2,
				},
				[90] = 
				{
					[1] = 0.26,
					[2] = 3.22,
				},
				[91] = 
				{
					[1] = 0.27,
					[2] = 3.24,
				},
				[92] = 
				{
					[1] = 0.27,
					[2] = 3.26,
				},
				[93] = 
				{
					[1] = 0.27,
					[2] = 3.28,
				},
				[94] = 
				{
					[1] = 0.28,
					[2] = 3.3,
				},
				[95] = 
				{
					[1] = 0.28,
					[2] = 3.32,
				},
				[96] = 
				{
					[1] = 0.28,
					[2] = 3.34,
				},
				[97] = 
				{
					[1] = 0.28,
					[2] = 3.36,
				},
				[98] = 
				{
					[1] = 0.29,
					[2] = 3.38,
				},
				[99] = 
				{
					[1] = 0.29,
					[2] = 3.4,
				},
				[100] = 
				{
					[1] = 0.29,
					[2] = 3.42,
				},
				[101] = 
				{
					[1] = 0.3,
					[2] = 3.44,
				},
				[102] = 
				{
					[1] = 0.3,
					[2] = 3.46,
				},
				[103] = 
				{
					[1] = 0.3,
					[2] = 3.48,
				},
				[104] = 
				{
					[1] = 0.31,
					[2] = 3.5,
				},
				[105] = 
				{
					[1] = 0.31,
					[2] = 3.52,
				},
				[106] = 
				{
					[1] = 0.31,
					[2] = 3.54,
				},
				[107] = 
				{
					[1] = 0.31,
					[2] = 3.56,
				},
				[108] = 
				{
					[1] = 0.32,
					[2] = 3.58,
				},
				[109] = 
				{
					[1] = 0.32,
					[2] = 3.6,
				},
				[110] = 
				{
					[1] = 0.32,
					[2] = 3.62,
				},
				[111] = 
				{
					[1] = 0.33,
					[2] = 3.64,
				},
				[112] = 
				{
					[1] = 0.33,
					[2] = 3.66,
				},
				[113] = 
				{
					[1] = 0.33,
					[2] = 3.68,
				},
				[114] = 
				{
					[1] = 0.34,
					[2] = 3.7,
				},
				[115] = 
				{
					[1] = 0.34,
					[2] = 3.72,
				},
				[116] = 
				{
					[1] = 0.34,
					[2] = 3.73,
				},
				[117] = 
				{
					[1] = 0.34,
					[2] = 3.75,
				},
				[118] = 
				{
					[1] = 0.35,
					[2] = 3.77,
				},
				[119] = 
				{
					[1] = 0.35,
					[2] = 3.79,
				},
				[120] = 
				{
					[1] = 0.35,
					[2] = 3.81,
				},
				[121] = 
				{
					[1] = 0.36,
					[2] = 3.83,
				},
				[122] = 
				{
					[1] = 0.36,
					[2] = 3.85,
				},
				[123] = 
				{
					[1] = 0.36,
					[2] = 3.86,
				},
				[124] = 
				{
					[1] = 0.36,
					[2] = 3.88,
				},
				[125] = 
				{
					[1] = 0.37,
					[2] = 3.9,
				},
				[126] = 
				{
					[1] = 0.37,
					[2] = 3.92,
				},
				[127] = 
				{
					[1] = 0.37,
					[2] = 3.94,
				},
				[128] = 
				{
					[1] = 0.38,
					[2] = 3.95,
				},
				[129] = 
				{
					[1] = 0.38,
					[2] = 3.97,
				},
				[130] = 
				{
					[1] = 0.38,
					[2] = 3.99,
				},
				[131] = 
				{
					[1] = 0.39,
					[2] = 4.01,
				},
				[132] = 
				{
					[1] = 0.39,
					[2] = 4.02,
				},
				[133] = 
				{
					[1] = 0.39,
					[2] = 4.04,
				},
				[134] = 
				{
					[1] = 0.39,
					[2] = 4.06,
				},
				[135] = 
				{
					[1] = 0.4,
					[2] = 4.07,
				},
				[136] = 
				{
					[1] = 0.4,
					[2] = 4.09,
				},
				[137] = 
				{
					[1] = 0.4,
					[2] = 4.1,
				},
				[138] = 
				{
					[1] = 0.41,
					[2] = 4.11,
				},
				[139] = 
				{
					[1] = 0.41,
					[2] = 4.12,
				},
				[140] = 
				{
					[1] = 0.41,
					[2] = 4.14,
				},
				[141] = 
				{
					[1] = 0.42,
					[2] = 4.15,
				},
				[142] = 
				{
					[1] = 0.42,
					[2] = 4.16,
				},
				[143] = 
				{
					[1] = 0.42,
					[2] = 4.18,
				},
				[144] = 
				{
					[1] = 0.42,
					[2] = 4.2,
				},
				[145] = 
				{
					[1] = 0.43,
					[2] = 4.22,
				},
				[146] = 
				{
					[1] = 0.43,
					[2] = 4.23,
				},
				[147] = 
				{
					[1] = 0.43,
					[2] = 4.25,
				},
				[148] = 
				{
					[1] = 0.44,
					[2] = 4.27,
				},
				[149] = 
				{
					[1] = 0.44,
					[2] = 4.28,
				},
				[150] = 
				{
					[1] = 0.44,
					[2] = 4.3,
				},
				[151] = 
				{
					[1] = 0.45,
					[2] = 4.32,
				},
				[152] = 
				{
					[1] = 0.45,
					[2] = 4.33,
				},
				[153] = 
				{
					[1] = 0.45,
					[2] = 4.35,
				},
				[154] = 
				{
					[1] = 0.45,
					[2] = 4.36,
				},
				[155] = 
				{
					[1] = 0.46,
					[2] = 4.38,
				},
				[156] = 
				{
					[1] = 0.46,
					[2] = 4.4,
				},
				[157] = 
				{
					[1] = 0.46,
					[2] = 4.41,
				},
				[158] = 
				{
					[1] = 0.47,
					[2] = 4.43,
				},
				[159] = 
				{
					[1] = 0.47,
					[2] = 4.44,
				},
				[160] = 
				{
					[1] = 0.47,
					[2] = 4.46,
				},
				[161] = 
				{
					[1] = 0.47,
					[2] = 4.48,
				},
				[162] = 
				{
					[1] = 0.48,
					[2] = 4.49,
				},
				[163] = 
				{
					[1] = 0.48,
					[2] = 4.51,
				},
				[164] = 
				{
					[1] = 0.48,
					[2] = 4.52,
				},
				[165] = 
				{
					[1] = 0.49,
					[2] = 4.54,
				},
				[166] = 
				{
					[1] = 0.49,
					[2] = 4.55,
				},
				[167] = 
				{
					[1] = 0.49,
					[2] = 4.57,
				},
				[168] = 
				{
					[1] = 0.5,
					[2] = 4.58,
				},
				[169] = 
				{
					[1] = 0.5,
					[2] = 4.6,
				},
				[170] = 
				{
					[1] = 0.5,
					[2] = 4.61,
				},
				[171] = 
				{
					[1] = 0.5,
					[2] = 4.63,
				},
				[172] = 
				{
					[1] = 0.51,
					[2] = 4.64,
				},
				[173] = 
				{
					[1] = 0.51,
					[2] = 4.65,
				},
				[174] = 
				{
					[1] = 0.51,
					[2] = 4.67,
				},
				[175] = 
				{
					[1] = 0.52,
					[2] = 4.68,
				},
				[176] = 
				{
					[1] = 0.52,
					[2] = 4.7,
				},
				[177] = 
				{
					[1] = 0.52,
					[2] = 4.71,
				},
				[178] = 
				{
					[1] = 0.53,
					[2] = 4.73,
				},
				[179] = 
				{
					[1] = 0.53,
					[2] = 4.74,
				},
				[180] = 
				{
					[1] = 0.53,
					[2] = 4.75,
				},
				[181] = 
				{
					[1] = 0.53,
					[2] = 4.77,
				},
				[182] = 
				{
					[1] = 0.54,
					[2] = 4.78,
				},
				[183] = 
				{
					[1] = 0.54,
					[2] = 4.79,
				},
				[184] = 
				{
					[1] = 0.54,
					[2] = 4.81,
				},
				[185] = 
				{
					[1] = 0.55,
					[2] = 4.82,
				},
				[186] = 
				{
					[1] = 0.55,
					[2] = 4.83,
				},
				[187] = 
				{
					[1] = 0.55,
					[2] = 4.85,
				},
				[188] = 
				{
					[1] = 0.55,
					[2] = 4.86,
				},
				[189] = 
				{
					[1] = 0.56,
					[2] = 4.87,
				},
				[190] = 
				{
					[1] = 0.56,
					[2] = 4.88,
				},
				[191] = 
				{
					[1] = 0.56,
					[2] = 4.9,
				},
				[192] = 
				{
					[1] = 0.57,
					[2] = 4.91,
				},
				[193] = 
				{
					[1] = 0.57,
					[2] = 4.92,
				},
				[194] = 
				{
					[1] = 0.57,
					[2] = 4.94,
				},
				[195] = 
				{
					[1] = 0.58,
					[2] = 4.95,
				},
				[196] = 
				{
					[1] = 0.58,
					[2] = 4.96,
				},
				[197] = 
				{
					[1] = 0.58,
					[2] = 4.97,
				},
				[198] = 
				{
					[1] = 0.58,
					[2] = 4.98,
				},
				[199] = 
				{
					[1] = 0.59,
					[2] = 5,
				},
				[200] = 
				{
					[1] = 0.59,
					[2] = 5.01,
				},
				[201] = 
				{
					[1] = 0.59,
					[2] = 5.02,
				},
				[202] = 
				{
					[1] = 0.6,
					[2] = 5.03,
				},
				[203] = 
				{
					[1] = 0.6,
					[2] = 5.04,
				},
				[204] = 
				{
					[1] = 0.6,
					[2] = 5.05,
				},
				[205] = 
				{
					[1] = 0.61,
					[2] = 5.07,
				},
				[206] = 
				{
					[1] = 0.61,
					[2] = 5.08,
				},
				[207] = 
				{
					[1] = 0.61,
					[2] = 5.09,
				},
				[208] = 
				{
					[1] = 0.61,
					[2] = 5.1,
				},
				[209] = 
				{
					[1] = 0.62,
					[2] = 5.12,
				},
				[210] = 
				{
					[1] = 0.62,
					[2] = 5.13,
				},
				[211] = 
				{
					[1] = 0.62,
					[2] = 5.15,
				},
				[212] = 
				{
					[1] = 0.63,
					[2] = 5.17,
				},
				[213] = 
				{
					[1] = 0.63,
					[2] = 5.19,
				},
				[214] = 
				{
					[1] = 0.63,
					[2] = 5.2,
				},
				[215] = 
				{
					[1] = 0.64,
					[2] = 5.22,
				},
				[216] = 
				{
					[1] = 0.64,
					[2] = 5.24,
				},
				[217] = 
				{
					[1] = 0.64,
					[2] = 5.26,
				},
				[218] = 
				{
					[1] = 0.64,
					[2] = 5.27,
				},
				[219] = 
				{
					[1] = 0.65,
					[2] = 5.29,
				},
				[220] = 
				{
					[1] = 0.65,
					[2] = 5.31,
				},
				[221] = 
				{
					[1] = 0.65,
					[2] = 5.32,
				},
				[222] = 
				{
					[1] = 0.66,
					[2] = 5.34,
				},
				[223] = 
				{
					[1] = 0.66,
					[2] = 5.35,
				},
				[224] = 
				{
					[1] = 0.66,
					[2] = 5.37,
				},
				[225] = 
				{
					[1] = 0.66,
					[2] = 5.39,
				},
				[226] = 
				{
					[1] = 0.67,
					[2] = 5.4,
				},
				[227] = 
				{
					[1] = 0.67,
					[2] = 5.42,
				},
				[228] = 
				{
					[1] = 0.67,
					[2] = 5.43,
				},
				[229] = 
				{
					[1] = 0.68,
					[2] = 5.45,
				},
				[230] = 
				{
					[1] = 0.68,
					[2] = 5.46,
				},
				[231] = 
				{
					[1] = 0.68,
					[2] = 5.48,
				},
				[232] = 
				{
					[1] = 0.69,
					[2] = 5.49,
				},
				[233] = 
				{
					[1] = 0.69,
					[2] = 5.51,
				},
				[234] = 
				{
					[1] = 0.69,
					[2] = 5.52,
				},
				[235] = 
				{
					[1] = 0.69,
					[2] = 5.54,
				},
				[236] = 
				{
					[1] = 0.7,
					[2] = 5.55,
				},
				[237] = 
				{
					[1] = 0.7,
					[2] = 5.57,
				},
				[238] = 
				{
					[1] = 0.7,
					[2] = 5.58,
				},
				[239] = 
				{
					[1] = 0.71,
					[2] = 5.6,
				},
				[240] = 
				{
					[1] = 0.71,
					[2] = 5.61,
				},
				[241] = 
				{
					[1] = 0.71,
					[2] = 5.62,
				},
				[242] = 
				{
					[1] = 0.72,
					[2] = 5.64,
				},
				[243] = 
				{
					[1] = 0.72,
					[2] = 5.65,
				},
				[244] = 
				{
					[1] = 0.72,
					[2] = 5.67,
				},
				[245] = 
				{
					[1] = 0.72,
					[2] = 5.68,
				},
				[246] = 
				{
					[1] = 0.73,
					[2] = 5.69,
				},
				[247] = 
				{
					[1] = 0.73,
					[2] = 5.71,
				},
				[248] = 
				{
					[1] = 0.73,
					[2] = 5.72,
				},
				[249] = 
				{
					[1] = 0.74,
					[2] = 5.73,
				},
				[250] = 
				{
					[1] = 0.74,
					[2] = 5.74,
				},
				[251] = 
				{
					[1] = 0.74,
					[2] = 5.76,
				},
				[252] = 
				{
					[1] = 0.74,
					[2] = 5.77,
				},
				[253] = 
				{
					[1] = 0.75,
					[2] = 5.78,
				},
				[254] = 
				{
					[1] = 0.75,
					[2] = 5.8,
				},
				[255] = 
				{
					[1] = 0.75,
					[2] = 5.81,
				},
				[256] = 
				{
					[1] = 0.76,
					[2] = 5.82,
				},
				[257] = 
				{
					[1] = 0.76,
					[2] = 5.83,
				},
				[258] = 
				{
					[1] = 0.76,
					[2] = 5.84,
				},
				[259] = 
				{
					[1] = 0.77,
					[2] = 5.86,
				},
				[260] = 
				{
					[1] = 0.77,
					[2] = 5.87,
				},
				[261] = 
				{
					[1] = 0.77,
					[2] = 5.88,
				},
				[262] = 
				{
					[1] = 0.77,
					[2] = 5.89,
				},
				[263] = 
				{
					[1] = 0.78,
					[2] = 5.9,
				},
				[264] = 
				{
					[1] = 0.78,
					[2] = 5.91,
				},
				[265] = 
				{
					[1] = 0.78,
					[2] = 5.92,
				},
				[266] = 
				{
					[1] = 0.79,
					[2] = 5.93,
				},
				[267] = 
				{
					[1] = 0.79,
					[2] = 5.94,
				},
				[268] = 
				{
					[1] = 0.79,
					[2] = 5.96,
				},
				[269] = 
				{
					[1] = 0.8,
					[2] = 5.97,
				},
				[270] = 
				{
					[1] = 0.8,
					[2] = 5.98,
				},
				[271] = 
				{
					[1] = 0.8,
					[2] = 5.98,
				},
				[272] = 
				{
					[1] = 0.8,
					[2] = 5.99,
				},
				[273] = 
				{
					[1] = 0.81,
					[2] = 6,
				},
				[274] = 
				{
					[1] = 0.81,
					[2] = 6.01,
				},
				[275] = 
				{
					[1] = 0.81,
					[2] = 6.02,
				},
				[276] = 
				{
					[1] = 0.82,
					[2] = 6.03,
				},
				[277] = 
				{
					[1] = 0.82,
					[2] = 6.03,
				},
				[278] = 
				{
					[1] = 0.82,
					[2] = 6.04,
				},
				[279] = 
				{
					[1] = 0.82,
					[2] = 6.05,
				},
				[280] = 
				{
					[1] = 0.83,
					[2] = 6.06,
				},
				[281] = 
				{
					[1] = 0.83,
					[2] = 6.07,
				},
				[282] = 
				{
					[1] = 0.83,
					[2] = 6.08,
				},
				[283] = 
				{
					[1] = 0.84,
					[2] = 6.09,
				},
				[284] = 
				{
					[1] = 0.84,
					[2] = 6.09,
				},
				[285] = 
				{
					[1] = 0.84,
					[2] = 6.1,
				},
				[286] = 
				{
					[1] = 0.85,
					[2] = 6.11,
				},
				[287] = 
				{
					[1] = 0.85,
					[2] = 6.12,
				},
				[288] = 
				{
					[1] = 0.85,
					[2] = 6.12,
				},
				[289] = 
				{
					[1] = 0.85,
					[2] = 6.13,
				},
				[290] = 
				{
					[1] = 0.86,
					[2] = 6.14,
				},
				[291] = 
				{
					[1] = 0.86,
					[2] = 6.15,
				},
				[292] = 
				{
					[1] = 0.86,
					[2] = 6.15,
				},
				[293] = 
				{
					[1] = 0.87,
					[2] = 6.16,
				},
				[294] = 
				{
					[1] = 0.87,
					[2] = 6.17,
				},
				[295] = 
				{
					[1] = 0.87,
					[2] = 6.17,
				},
				[296] = 
				{
					[1] = 0.88,
					[2] = 6.18,
				},
				[297] = 
				{
					[1] = 0.88,
					[2] = 6.19,
				},
				[298] = 
				{
					[1] = 0.88,
					[2] = 6.19,
				},
				[299] = 
				{
					[1] = 0.88,
					[2] = 6.2,
				},
				[300] = 
				{
					[1] = 0.89,
					[2] = 6.21,
				},
				[301] = 
				{
					[1] = 0.89,
					[2] = 6.21,
				},
				[302] = 
				{
					[1] = 0.89,
					[2] = 6.22,
				},
				[303] = 
				{
					[1] = 0.9,
					[2] = 6.22,
				},
				[304] = 
				{
					[1] = 0.9,
					[2] = 6.23,
				},
				[305] = 
				{
					[1] = 0.9,
					[2] = 6.23,
				},
				[306] = 
				{
					[1] = 0.91,
					[2] = 6.24,
				},
				[307] = 
				{
					[1] = 0.91,
					[2] = 6.24,
				},
				[308] = 
				{
					[1] = 0.91,
					[2] = 6.25,
				},
				[309] = 
				{
					[1] = 0.91,
					[2] = 6.26,
				},
				[310] = 
				{
					[1] = 0.92,
					[2] = 6.26,
				},
				[311] = 
				{
					[1] = 0.92,
					[2] = 6.26,
				},
				[312] = 
				{
					[1] = 0.92,
					[2] = 6.27,
				},
				[313] = 
				{
					[1] = 0.93,
					[2] = 6.27,
				},
				[314] = 
				{
					[1] = 0.93,
					[2] = 6.28,
				},
				[315] = 
				{
					[1] = 0.93,
					[2] = 6.28,
				},
				[316] = 
				{
					[1] = 0.93,
					[2] = 6.29,
				},
				[317] = 
				{
					[1] = 0.94,
					[2] = 6.29,
				},
				[318] = 
				{
					[1] = 0.94,
					[2] = 6.29,
				},
				[319] = 
				{
					[1] = 0.94,
					[2] = 6.3,
				},
				[320] = 
				{
					[1] = 0.95,
					[2] = 6.3,
				},
				[321] = 
				{
					[1] = 0.95,
					[2] = 6.31,
				},
				[322] = 
				{
					[1] = 0.95,
					[2] = 6.31,
				},
				[323] = 
				{
					[1] = 0.96,
					[2] = 6.31,
				},
				[324] = 
				{
					[1] = 0.96,
					[2] = 6.32,
				},
				[325] = 
				{
					[1] = 0.96,
					[2] = 6.32,
				},
				[326] = 
				{
					[1] = 0.96,
					[2] = 6.32,
				},
				[327] = 
				{
					[1] = 0.97,
					[2] = 6.32,
				},
				[328] = 
				{
					[1] = 0.97,
					[2] = 6.33,
				},
				[329] = 
				{
					[1] = 0.97,
					[2] = 6.33,
				},
				[330] = 
				{
					[1] = 0.98,
					[2] = 6.33,
				},
				[331] = 
				{
					[1] = 0.98,
					[2] = 6.33,
				},
				[332] = 
				{
					[1] = 0.98,
					[2] = 6.34,
				},
				[333] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[334] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[335] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[336] = 
				{
					[1] = 0.99,
					[2] = 6.34,
				},
				[337] = 
				{
					[1] = 1,
					[2] = 6.35,
				},
			},
			["WidthScale"] = 0.6,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_king_george",
		["Type"] = "WaterTracer",
	},
	[246] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 292.613495,
			["Lifetime"] = 28.440001,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0158,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.58,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 382.640472,
			["Lifetime"] = 37.189999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0197,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.85,
			["WidthScaler"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 67.49453,
			["Lifetime"] = 6.56,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0197,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 5.9,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_king_george",
		["Type"] = "WaterTracer",
	},
	[247] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 159.600006,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0313,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.33,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.5,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.68,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 0.91,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.13,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.36,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 1.57,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.74,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 1.92,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 2.09,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 2.27,
				},
				[13] = 
				{
					[1] = 0.08,
					[2] = 2.44,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 2.62,
				},
				[15] = 
				{
					[1] = 0.09,
					[2] = 2.75,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 2.88,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 3.01,
				},
				[18] = 
				{
					[1] = 0.11,
					[2] = 3.14,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 3.26,
				},
				[20] = 
				{
					[1] = 0.12,
					[2] = 3.39,
				},
				[21] = 
				{
					[1] = 0.13,
					[2] = 3.52,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 3.65,
				},
				[23] = 
				{
					[1] = 0.14,
					[2] = 3.75,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 3.85,
				},
				[25] = 
				{
					[1] = 0.15,
					[2] = 3.95,
				},
				[26] = 
				{
					[1] = 0.16,
					[2] = 4.05,
				},
				[27] = 
				{
					[1] = 0.16,
					[2] = 4.15,
				},
				[28] = 
				{
					[1] = 0.17,
					[2] = 4.25,
				},
				[29] = 
				{
					[1] = 0.18,
					[2] = 4.35,
				},
				[30] = 
				{
					[1] = 0.18,
					[2] = 4.45,
				},
				[31] = 
				{
					[1] = 0.19,
					[2] = 4.55,
				},
				[32] = 
				{
					[1] = 0.19,
					[2] = 4.65,
				},
				[33] = 
				{
					[1] = 0.2,
					[2] = 4.75,
				},
				[34] = 
				{
					[1] = 0.21,
					[2] = 4.85,
				},
				[35] = 
				{
					[1] = 0.21,
					[2] = 4.95,
				},
				[36] = 
				{
					[1] = 0.22,
					[2] = 5.04,
				},
				[37] = 
				{
					[1] = 0.23,
					[2] = 5.1,
				},
				[38] = 
				{
					[1] = 0.23,
					[2] = 5.16,
				},
				[39] = 
				{
					[1] = 0.24,
					[2] = 5.23,
				},
				[40] = 
				{
					[1] = 0.25,
					[2] = 5.29,
				},
				[41] = 
				{
					[1] = 0.25,
					[2] = 5.36,
				},
				[42] = 
				{
					[1] = 0.26,
					[2] = 5.42,
				},
				[43] = 
				{
					[1] = 0.26,
					[2] = 5.49,
				},
				[44] = 
				{
					[1] = 0.27,
					[2] = 5.55,
				},
				[45] = 
				{
					[1] = 0.28,
					[2] = 5.62,
				},
				[46] = 
				{
					[1] = 0.28,
					[2] = 5.69,
				},
				[47] = 
				{
					[1] = 0.29,
					[2] = 5.75,
				},
				[48] = 
				{
					[1] = 0.3,
					[2] = 5.82,
				},
				[49] = 
				{
					[1] = 0.3,
					[2] = 5.88,
				},
				[50] = 
				{
					[1] = 0.31,
					[2] = 5.95,
				},
				[51] = 
				{
					[1] = 0.31,
					[2] = 6.01,
				},
				[52] = 
				{
					[1] = 0.32,
					[2] = 6.08,
				},
				[53] = 
				{
					[1] = 0.33,
					[2] = 6.15,
				},
				[54] = 
				{
					[1] = 0.33,
					[2] = 6.21,
				},
				[55] = 
				{
					[1] = 0.34,
					[2] = 6.28,
				},
				[56] = 
				{
					[1] = 0.35,
					[2] = 6.34,
				},
				[57] = 
				{
					[1] = 0.35,
					[2] = 6.41,
				},
				[58] = 
				{
					[1] = 0.36,
					[2] = 6.44,
				},
				[59] = 
				{
					[1] = 0.36,
					[2] = 6.46,
				},
				[60] = 
				{
					[1] = 0.37,
					[2] = 6.49,
				},
				[61] = 
				{
					[1] = 0.38,
					[2] = 6.51,
				},
				[62] = 
				{
					[1] = 0.38,
					[2] = 6.54,
				},
				[63] = 
				{
					[1] = 0.39,
					[2] = 6.57,
				},
				[64] = 
				{
					[1] = 0.4,
					[2] = 6.6,
				},
				[65] = 
				{
					[1] = 0.4,
					[2] = 6.62,
				},
				[66] = 
				{
					[1] = 0.41,
					[2] = 6.65,
				},
				[67] = 
				{
					[1] = 0.42,
					[2] = 6.68,
				},
				[68] = 
				{
					[1] = 0.42,
					[2] = 6.7,
				},
				[69] = 
				{
					[1] = 0.43,
					[2] = 6.73,
				},
				[70] = 
				{
					[1] = 0.43,
					[2] = 6.76,
				},
				[71] = 
				{
					[1] = 0.44,
					[2] = 6.78,
				},
				[72] = 
				{
					[1] = 0.45,
					[2] = 6.81,
				},
				[73] = 
				{
					[1] = 0.45,
					[2] = 6.84,
				},
				[74] = 
				{
					[1] = 0.46,
					[2] = 6.86,
				},
				[75] = 
				{
					[1] = 0.47,
					[2] = 6.89,
				},
				[76] = 
				{
					[1] = 0.47,
					[2] = 6.92,
				},
				[77] = 
				{
					[1] = 0.48,
					[2] = 6.95,
				},
				[78] = 
				{
					[1] = 0.48,
					[2] = 6.97,
				},
				[79] = 
				{
					[1] = 0.49,
					[2] = 6.98,
				},
				[80] = 
				{
					[1] = 0.5,
					[2] = 6.98,
				},
				[81] = 
				{
					[1] = 0.5,
					[2] = 6.98,
				},
				[82] = 
				{
					[1] = 0.51,
					[2] = 6.98,
				},
				[83] = 
				{
					[1] = 0.52,
					[2] = 6.98,
				},
				[84] = 
				{
					[1] = 0.52,
					[2] = 6.98,
				},
				[85] = 
				{
					[1] = 0.53,
					[2] = 6.98,
				},
				[86] = 
				{
					[1] = 0.53,
					[2] = 6.98,
				},
				[87] = 
				{
					[1] = 0.54,
					[2] = 6.98,
				},
				[88] = 
				{
					[1] = 0.55,
					[2] = 6.98,
				},
				[89] = 
				{
					[1] = 0.55,
					[2] = 6.98,
				},
				[90] = 
				{
					[1] = 0.56,
					[2] = 6.98,
				},
				[91] = 
				{
					[1] = 0.57,
					[2] = 6.98,
				},
				[92] = 
				{
					[1] = 0.57,
					[2] = 6.98,
				},
				[93] = 
				{
					[1] = 0.58,
					[2] = 6.98,
				},
				[94] = 
				{
					[1] = 0.58,
					[2] = 6.98,
				},
				[95] = 
				{
					[1] = 0.59,
					[2] = 6.98,
				},
				[96] = 
				{
					[1] = 0.6,
					[2] = 6.98,
				},
				[97] = 
				{
					[1] = 0.6,
					[2] = 6.98,
				},
				[98] = 
				{
					[1] = 0.61,
					[2] = 6.98,
				},
				[99] = 
				{
					[1] = 0.62,
					[2] = 6.98,
				},
				[100] = 
				{
					[1] = 0.62,
					[2] = 6.98,
				},
				[101] = 
				{
					[1] = 0.63,
					[2] = 6.96,
				},
				[102] = 
				{
					[1] = 0.64,
					[2] = 6.94,
				},
				[103] = 
				{
					[1] = 0.64,
					[2] = 6.92,
				},
				[104] = 
				{
					[1] = 0.65,
					[2] = 6.9,
				},
				[105] = 
				{
					[1] = 0.65,
					[2] = 6.88,
				},
				[106] = 
				{
					[1] = 0.66,
					[2] = 6.87,
				},
				[107] = 
				{
					[1] = 0.67,
					[2] = 6.85,
				},
				[108] = 
				{
					[1] = 0.67,
					[2] = 6.83,
				},
				[109] = 
				{
					[1] = 0.68,
					[2] = 6.81,
				},
				[110] = 
				{
					[1] = 0.69,
					[2] = 6.79,
				},
				[111] = 
				{
					[1] = 0.69,
					[2] = 6.77,
				},
				[112] = 
				{
					[1] = 0.7,
					[2] = 6.75,
				},
				[113] = 
				{
					[1] = 0.7,
					[2] = 6.73,
				},
				[114] = 
				{
					[1] = 0.71,
					[2] = 6.71,
				},
				[115] = 
				{
					[1] = 0.72,
					[2] = 6.69,
				},
				[116] = 
				{
					[1] = 0.72,
					[2] = 6.68,
				},
				[117] = 
				{
					[1] = 0.73,
					[2] = 6.66,
				},
				[118] = 
				{
					[1] = 0.74,
					[2] = 6.64,
				},
				[119] = 
				{
					[1] = 0.74,
					[2] = 6.62,
				},
				[120] = 
				{
					[1] = 0.75,
					[2] = 6.61,
				},
				[121] = 
				{
					[1] = 0.75,
					[2] = 6.58,
				},
				[122] = 
				{
					[1] = 0.76,
					[2] = 6.53,
				},
				[123] = 
				{
					[1] = 0.77,
					[2] = 6.48,
				},
				[124] = 
				{
					[1] = 0.77,
					[2] = 6.43,
				},
				[125] = 
				{
					[1] = 0.78,
					[2] = 6.38,
				},
				[126] = 
				{
					[1] = 0.79,
					[2] = 6.33,
				},
				[127] = 
				{
					[1] = 0.79,
					[2] = 6.28,
				},
				[128] = 
				{
					[1] = 0.8,
					[2] = 6.24,
				},
				[129] = 
				{
					[1] = 0.81,
					[2] = 6.19,
				},
				[130] = 
				{
					[1] = 0.81,
					[2] = 6.14,
				},
				[131] = 
				{
					[1] = 0.82,
					[2] = 6.09,
				},
				[132] = 
				{
					[1] = 0.82,
					[2] = 6.04,
				},
				[133] = 
				{
					[1] = 0.83,
					[2] = 5.99,
				},
				[134] = 
				{
					[1] = 0.84,
					[2] = 5.94,
				},
				[135] = 
				{
					[1] = 0.84,
					[2] = 5.89,
				},
				[136] = 
				{
					[1] = 0.85,
					[2] = 5.84,
				},
				[137] = 
				{
					[1] = 0.86,
					[2] = 5.79,
				},
				[138] = 
				{
					[1] = 0.86,
					[2] = 5.74,
				},
				[139] = 
				{
					[1] = 0.87,
					[2] = 5.7,
				},
				[140] = 
				{
					[1] = 0.87,
					[2] = 5.64,
				},
				[141] = 
				{
					[1] = 0.88,
					[2] = 5.56,
				},
				[142] = 
				{
					[1] = 0.89,
					[2] = 5.48,
				},
				[143] = 
				{
					[1] = 0.89,
					[2] = 5.39,
				},
				[144] = 
				{
					[1] = 0.9,
					[2] = 5.31,
				},
				[145] = 
				{
					[1] = 0.91,
					[2] = 5.23,
				},
				[146] = 
				{
					[1] = 0.91,
					[2] = 5.12,
				},
				[147] = 
				{
					[1] = 0.92,
					[2] = 4.99,
				},
				[148] = 
				{
					[1] = 0.92,
					[2] = 4.85,
				},
				[149] = 
				{
					[1] = 0.93,
					[2] = 4.72,
				},
				[150] = 
				{
					[1] = 0.94,
					[2] = 4.58,
				},
				[151] = 
				{
					[1] = 0.94,
					[2] = 4.45,
				},
				[152] = 
				{
					[1] = 0.95,
					[2] = 4.31,
				},
				[153] = 
				{
					[1] = 0.96,
					[2] = 4.18,
				},
				[154] = 
				{
					[1] = 0.96,
					[2] = 4.06,
				},
				[155] = 
				{
					[1] = 0.97,
					[2] = 3.89,
				},
				[156] = 
				{
					[1] = 0.97,
					[2] = 3.72,
				},
				[157] = 
				{
					[1] = 0.98,
					[2] = 3.55,
				},
				[158] = 
				{
					[1] = 0.99,
					[2] = 3.11,
				},
				[159] = 
				{
					[1] = 0.99,
					[2] = 2.67,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 4.32,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.24,
				},
				[3] = 
				{
					[1] = 0.05,
					[2] = 0.33,
				},
				[4] = 
				{
					[1] = 0.08,
					[2] = 0.38,
				},
				[5] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[6] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[7] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[8] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.21,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[11] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[12] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[14] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[15] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[16] = 
				{
					[1] = 0.38,
					[2] = 0.46,
				},
				[17] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[18] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[19] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[20] = 
				{
					[1] = 0.49,
					[2] = 0.41,
				},
				[21] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[22] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[23] = 
				{
					[1] = 0.56,
					[2] = 0.35,
				},
				[24] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[25] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[26] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[27] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[28] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[29] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[30] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[31] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[32] = 
				{
					[1] = 0.79,
					[2] = 0.17,
				},
				[33] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[34] = 
				{
					[1] = 0.85,
					[2] = 0.13,
				},
				[35] = 
				{
					[1] = 0.87,
					[2] = 0.1,
				},
				[36] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[37] = 
				{
					[1] = 0.92,
					[2] = 0.06,
				},
				[38] = 
				{
					[1] = 0.95,
					[2] = 0.04,
				},
				[39] = 
				{
					[1] = 0.97,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 13.94,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.36,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.39,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.43,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 0.46,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.49,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 0.53,
				},
				[8] = 
				{
					[1] = 0.03,
					[2] = 0.56,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.59,
				},
				[10] = 
				{
					[1] = 0.04,
					[2] = 0.62,
				},
				[11] = 
				{
					[1] = 0.04,
					[2] = 0.65,
				},
				[12] = 
				{
					[1] = 0.05,
					[2] = 0.68,
				},
				[13] = 
				{
					[1] = 0.05,
					[2] = 0.72,
				},
				[14] = 
				{
					[1] = 0.05,
					[2] = 0.75,
				},
				[15] = 
				{
					[1] = 0.06,
					[2] = 0.78,
				},
				[16] = 
				{
					[1] = 0.06,
					[2] = 0.81,
				},
				[17] = 
				{
					[1] = 0.07,
					[2] = 0.84,
				},
				[18] = 
				{
					[1] = 0.07,
					[2] = 0.87,
				},
				[19] = 
				{
					[1] = 0.08,
					[2] = 0.9,
				},
				[20] = 
				{
					[1] = 0.08,
					[2] = 0.93,
				},
				[21] = 
				{
					[1] = 0.08,
					[2] = 0.96,
				},
				[22] = 
				{
					[1] = 0.09,
					[2] = 0.99,
				},
				[23] = 
				{
					[1] = 0.09,
					[2] = 1.02,
				},
				[24] = 
				{
					[1] = 0.1,
					[2] = 1.05,
				},
				[25] = 
				{
					[1] = 0.1,
					[2] = 1.08,
				},
				[26] = 
				{
					[1] = 0.1,
					[2] = 1.11,
				},
				[27] = 
				{
					[1] = 0.11,
					[2] = 1.14,
				},
				[28] = 
				{
					[1] = 0.11,
					[2] = 1.17,
				},
				[29] = 
				{
					[1] = 0.12,
					[2] = 1.2,
				},
				[30] = 
				{
					[1] = 0.12,
					[2] = 1.23,
				},
				[31] = 
				{
					[1] = 0.13,
					[2] = 1.27,
				},
				[32] = 
				{
					[1] = 0.13,
					[2] = 1.31,
				},
				[33] = 
				{
					[1] = 0.13,
					[2] = 1.35,
				},
				[34] = 
				{
					[1] = 0.14,
					[2] = 1.39,
				},
				[35] = 
				{
					[1] = 0.14,
					[2] = 1.43,
				},
				[36] = 
				{
					[1] = 0.15,
					[2] = 1.47,
				},
				[37] = 
				{
					[1] = 0.15,
					[2] = 1.51,
				},
				[38] = 
				{
					[1] = 0.15,
					[2] = 1.54,
				},
				[39] = 
				{
					[1] = 0.16,
					[2] = 1.58,
				},
				[40] = 
				{
					[1] = 0.16,
					[2] = 1.62,
				},
				[41] = 
				{
					[1] = 0.17,
					[2] = 1.66,
				},
				[42] = 
				{
					[1] = 0.17,
					[2] = 1.7,
				},
				[43] = 
				{
					[1] = 0.18,
					[2] = 1.74,
				},
				[44] = 
				{
					[1] = 0.18,
					[2] = 1.77,
				},
				[45] = 
				{
					[1] = 0.18,
					[2] = 1.81,
				},
				[46] = 
				{
					[1] = 0.19,
					[2] = 1.85,
				},
				[47] = 
				{
					[1] = 0.19,
					[2] = 1.89,
				},
				[48] = 
				{
					[1] = 0.2,
					[2] = 1.92,
				},
				[49] = 
				{
					[1] = 0.2,
					[2] = 1.96,
				},
				[50] = 
				{
					[1] = 0.21,
					[2] = 2,
				},
				[51] = 
				{
					[1] = 0.21,
					[2] = 2.03,
				},
				[52] = 
				{
					[1] = 0.21,
					[2] = 2.07,
				},
				[53] = 
				{
					[1] = 0.22,
					[2] = 2.1,
				},
				[54] = 
				{
					[1] = 0.22,
					[2] = 2.14,
				},
				[55] = 
				{
					[1] = 0.23,
					[2] = 2.18,
				},
				[56] = 
				{
					[1] = 0.23,
					[2] = 2.21,
				},
				[57] = 
				{
					[1] = 0.23,
					[2] = 2.25,
				},
				[58] = 
				{
					[1] = 0.24,
					[2] = 2.28,
				},
				[59] = 
				{
					[1] = 0.24,
					[2] = 2.32,
				},
				[60] = 
				{
					[1] = 0.25,
					[2] = 2.35,
				},
				[61] = 
				{
					[1] = 0.25,
					[2] = 2.39,
				},
				[62] = 
				{
					[1] = 0.26,
					[2] = 2.42,
				},
				[63] = 
				{
					[1] = 0.26,
					[2] = 2.45,
				},
				[64] = 
				{
					[1] = 0.26,
					[2] = 2.49,
				},
				[65] = 
				{
					[1] = 0.27,
					[2] = 2.52,
				},
				[66] = 
				{
					[1] = 0.27,
					[2] = 2.55,
				},
				[67] = 
				{
					[1] = 0.28,
					[2] = 2.57,
				},
				[68] = 
				{
					[1] = 0.28,
					[2] = 2.6,
				},
				[69] = 
				{
					[1] = 0.28,
					[2] = 2.63,
				},
				[70] = 
				{
					[1] = 0.29,
					[2] = 2.65,
				},
				[71] = 
				{
					[1] = 0.29,
					[2] = 2.67,
				},
				[72] = 
				{
					[1] = 0.3,
					[2] = 2.7,
				},
				[73] = 
				{
					[1] = 0.3,
					[2] = 2.72,
				},
				[74] = 
				{
					[1] = 0.31,
					[2] = 2.74,
				},
				[75] = 
				{
					[1] = 0.31,
					[2] = 2.76,
				},
				[76] = 
				{
					[1] = 0.31,
					[2] = 2.79,
				},
				[77] = 
				{
					[1] = 0.32,
					[2] = 2.81,
				},
				[78] = 
				{
					[1] = 0.32,
					[2] = 2.83,
				},
				[79] = 
				{
					[1] = 0.33,
					[2] = 2.86,
				},
				[80] = 
				{
					[1] = 0.33,
					[2] = 2.88,
				},
				[81] = 
				{
					[1] = 0.33,
					[2] = 2.9,
				},
				[82] = 
				{
					[1] = 0.34,
					[2] = 2.92,
				},
				[83] = 
				{
					[1] = 0.34,
					[2] = 2.94,
				},
				[84] = 
				{
					[1] = 0.35,
					[2] = 2.96,
				},
				[85] = 
				{
					[1] = 0.35,
					[2] = 2.99,
				},
				[86] = 
				{
					[1] = 0.36,
					[2] = 3.01,
				},
				[87] = 
				{
					[1] = 0.36,
					[2] = 3.03,
				},
				[88] = 
				{
					[1] = 0.36,
					[2] = 3.05,
				},
				[89] = 
				{
					[1] = 0.37,
					[2] = 3.07,
				},
				[90] = 
				{
					[1] = 0.37,
					[2] = 3.09,
				},
				[91] = 
				{
					[1] = 0.38,
					[2] = 3.11,
				},
				[92] = 
				{
					[1] = 0.38,
					[2] = 3.13,
				},
				[93] = 
				{
					[1] = 0.38,
					[2] = 3.15,
				},
				[94] = 
				{
					[1] = 0.39,
					[2] = 3.17,
				},
				[95] = 
				{
					[1] = 0.39,
					[2] = 3.19,
				},
				[96] = 
				{
					[1] = 0.4,
					[2] = 3.21,
				},
				[97] = 
				{
					[1] = 0.4,
					[2] = 3.23,
				},
				[98] = 
				{
					[1] = 0.41,
					[2] = 3.25,
				},
				[99] = 
				{
					[1] = 0.41,
					[2] = 3.27,
				},
				[100] = 
				{
					[1] = 0.41,
					[2] = 3.29,
				},
				[101] = 
				{
					[1] = 0.42,
					[2] = 3.31,
				},
				[102] = 
				{
					[1] = 0.42,
					[2] = 3.33,
				},
				[103] = 
				{
					[1] = 0.43,
					[2] = 3.35,
				},
				[104] = 
				{
					[1] = 0.43,
					[2] = 3.37,
				},
				[105] = 
				{
					[1] = 0.44,
					[2] = 3.38,
				},
				[106] = 
				{
					[1] = 0.44,
					[2] = 3.4,
				},
				[107] = 
				{
					[1] = 0.44,
					[2] = 3.42,
				},
				[108] = 
				{
					[1] = 0.45,
					[2] = 3.44,
				},
				[109] = 
				{
					[1] = 0.45,
					[2] = 3.46,
				},
				[110] = 
				{
					[1] = 0.46,
					[2] = 3.48,
				},
				[111] = 
				{
					[1] = 0.46,
					[2] = 3.49,
				},
				[112] = 
				{
					[1] = 0.46,
					[2] = 3.51,
				},
				[113] = 
				{
					[1] = 0.47,
					[2] = 3.53,
				},
				[114] = 
				{
					[1] = 0.47,
					[2] = 3.55,
				},
				[115] = 
				{
					[1] = 0.48,
					[2] = 3.56,
				},
				[116] = 
				{
					[1] = 0.48,
					[2] = 3.58,
				},
				[117] = 
				{
					[1] = 0.49,
					[2] = 3.6,
				},
				[118] = 
				{
					[1] = 0.49,
					[2] = 3.61,
				},
				[119] = 
				{
					[1] = 0.49,
					[2] = 3.63,
				},
				[120] = 
				{
					[1] = 0.5,
					[2] = 3.65,
				},
				[121] = 
				{
					[1] = 0.5,
					[2] = 3.66,
				},
				[122] = 
				{
					[1] = 0.51,
					[2] = 3.68,
				},
				[123] = 
				{
					[1] = 0.51,
					[2] = 3.69,
				},
				[124] = 
				{
					[1] = 0.51,
					[2] = 3.71,
				},
				[125] = 
				{
					[1] = 0.52,
					[2] = 3.72,
				},
				[126] = 
				{
					[1] = 0.52,
					[2] = 3.74,
				},
				[127] = 
				{
					[1] = 0.53,
					[2] = 3.76,
				},
				[128] = 
				{
					[1] = 0.53,
					[2] = 3.77,
				},
				[129] = 
				{
					[1] = 0.54,
					[2] = 3.79,
				},
				[130] = 
				{
					[1] = 0.54,
					[2] = 3.8,
				},
				[131] = 
				{
					[1] = 0.54,
					[2] = 3.81,
				},
				[132] = 
				{
					[1] = 0.55,
					[2] = 3.82,
				},
				[133] = 
				{
					[1] = 0.55,
					[2] = 3.83,
				},
				[134] = 
				{
					[1] = 0.56,
					[2] = 3.84,
				},
				[135] = 
				{
					[1] = 0.56,
					[2] = 3.85,
				},
				[136] = 
				{
					[1] = 0.56,
					[2] = 3.86,
				},
				[137] = 
				{
					[1] = 0.57,
					[2] = 3.86,
				},
				[138] = 
				{
					[1] = 0.57,
					[2] = 3.87,
				},
				[139] = 
				{
					[1] = 0.58,
					[2] = 3.88,
				},
				[140] = 
				{
					[1] = 0.58,
					[2] = 3.88,
				},
				[141] = 
				{
					[1] = 0.59,
					[2] = 3.89,
				},
				[142] = 
				{
					[1] = 0.59,
					[2] = 3.9,
				},
				[143] = 
				{
					[1] = 0.59,
					[2] = 3.9,
				},
				[144] = 
				{
					[1] = 0.6,
					[2] = 3.91,
				},
				[145] = 
				{
					[1] = 0.6,
					[2] = 3.92,
				},
				[146] = 
				{
					[1] = 0.61,
					[2] = 3.92,
				},
				[147] = 
				{
					[1] = 0.61,
					[2] = 3.93,
				},
				[148] = 
				{
					[1] = 0.62,
					[2] = 3.93,
				},
				[149] = 
				{
					[1] = 0.62,
					[2] = 3.94,
				},
				[150] = 
				{
					[1] = 0.62,
					[2] = 3.95,
				},
				[151] = 
				{
					[1] = 0.63,
					[2] = 3.95,
				},
				[152] = 
				{
					[1] = 0.63,
					[2] = 3.96,
				},
				[153] = 
				{
					[1] = 0.64,
					[2] = 3.96,
				},
				[154] = 
				{
					[1] = 0.64,
					[2] = 3.97,
				},
				[155] = 
				{
					[1] = 0.64,
					[2] = 3.97,
				},
				[156] = 
				{
					[1] = 0.65,
					[2] = 3.98,
				},
				[157] = 
				{
					[1] = 0.65,
					[2] = 3.98,
				},
				[158] = 
				{
					[1] = 0.66,
					[2] = 3.99,
				},
				[159] = 
				{
					[1] = 0.66,
					[2] = 3.99,
				},
				[160] = 
				{
					[1] = 0.67,
					[2] = 4,
				},
				[161] = 
				{
					[1] = 0.67,
					[2] = 4,
				},
				[162] = 
				{
					[1] = 0.67,
					[2] = 4.01,
				},
				[163] = 
				{
					[1] = 0.68,
					[2] = 4.01,
				},
				[164] = 
				{
					[1] = 0.68,
					[2] = 4.01,
				},
				[165] = 
				{
					[1] = 0.69,
					[2] = 4.02,
				},
				[166] = 
				{
					[1] = 0.69,
					[2] = 4.02,
				},
				[167] = 
				{
					[1] = 0.69,
					[2] = 4.03,
				},
				[168] = 
				{
					[1] = 0.7,
					[2] = 4.03,
				},
				[169] = 
				{
					[1] = 0.7,
					[2] = 4.03,
				},
				[170] = 
				{
					[1] = 0.71,
					[2] = 4.04,
				},
				[171] = 
				{
					[1] = 0.71,
					[2] = 4.04,
				},
				[172] = 
				{
					[1] = 0.72,
					[2] = 4.04,
				},
				[173] = 
				{
					[1] = 0.72,
					[2] = 4.05,
				},
				[174] = 
				{
					[1] = 0.72,
					[2] = 4.05,
				},
				[175] = 
				{
					[1] = 0.73,
					[2] = 4.05,
				},
				[176] = 
				{
					[1] = 0.73,
					[2] = 4.06,
				},
				[177] = 
				{
					[1] = 0.74,
					[2] = 4.06,
				},
				[178] = 
				{
					[1] = 0.74,
					[2] = 4.06,
				},
				[179] = 
				{
					[1] = 0.74,
					[2] = 4.06,
				},
				[180] = 
				{
					[1] = 0.75,
					[2] = 4.07,
				},
				[181] = 
				{
					[1] = 0.75,
					[2] = 4.07,
				},
				[182] = 
				{
					[1] = 0.76,
					[2] = 4.07,
				},
				[183] = 
				{
					[1] = 0.76,
					[2] = 4.07,
				},
				[184] = 
				{
					[1] = 0.77,
					[2] = 4.08,
				},
				[185] = 
				{
					[1] = 0.77,
					[2] = 4.08,
				},
				[186] = 
				{
					[1] = 0.77,
					[2] = 4.08,
				},
				[187] = 
				{
					[1] = 0.78,
					[2] = 4.08,
				},
				[188] = 
				{
					[1] = 0.78,
					[2] = 4.08,
				},
				[189] = 
				{
					[1] = 0.79,
					[2] = 4.08,
				},
				[190] = 
				{
					[1] = 0.79,
					[2] = 4.09,
				},
				[191] = 
				{
					[1] = 0.79,
					[2] = 4.09,
				},
				[192] = 
				{
					[1] = 0.8,
					[2] = 4.09,
				},
				[193] = 
				{
					[1] = 0.8,
					[2] = 4.09,
				},
				[194] = 
				{
					[1] = 0.81,
					[2] = 4.09,
				},
				[195] = 
				{
					[1] = 0.81,
					[2] = 4.09,
				},
				[196] = 
				{
					[1] = 0.82,
					[2] = 4.09,
				},
				[197] = 
				{
					[1] = 0.82,
					[2] = 4.09,
				},
				[198] = 
				{
					[1] = 0.82,
					[2] = 4.09,
				},
				[199] = 
				{
					[1] = 0.83,
					[2] = 4.09,
				},
				[200] = 
				{
					[1] = 0.83,
					[2] = 4.09,
				},
				[201] = 
				{
					[1] = 0.84,
					[2] = 4.09,
				},
				[202] = 
				{
					[1] = 0.84,
					[2] = 4.09,
				},
				[203] = 
				{
					[1] = 0.85,
					[2] = 4.09,
				},
				[204] = 
				{
					[1] = 0.85,
					[2] = 4.09,
				},
				[205] = 
				{
					[1] = 0.85,
					[2] = 4.09,
				},
				[206] = 
				{
					[1] = 0.86,
					[2] = 4.09,
				},
				[207] = 
				{
					[1] = 0.86,
					[2] = 4.09,
				},
				[208] = 
				{
					[1] = 0.87,
					[2] = 4.09,
				},
				[209] = 
				{
					[1] = 0.87,
					[2] = 4.09,
				},
				[210] = 
				{
					[1] = 0.87,
					[2] = 4.09,
				},
				[211] = 
				{
					[1] = 0.88,
					[2] = 4.09,
				},
				[212] = 
				{
					[1] = 0.88,
					[2] = 4.09,
				},
				[213] = 
				{
					[1] = 0.89,
					[2] = 4.09,
				},
				[214] = 
				{
					[1] = 0.89,
					[2] = 4.09,
				},
				[215] = 
				{
					[1] = 0.9,
					[2] = 4.09,
				},
				[216] = 
				{
					[1] = 0.9,
					[2] = 4.08,
				},
				[217] = 
				{
					[1] = 0.9,
					[2] = 4.07,
				},
				[218] = 
				{
					[1] = 0.91,
					[2] = 4.07,
				},
				[219] = 
				{
					[1] = 0.91,
					[2] = 4.06,
				},
				[220] = 
				{
					[1] = 0.92,
					[2] = 4.05,
				},
				[221] = 
				{
					[1] = 0.92,
					[2] = 4.05,
				},
				[222] = 
				{
					[1] = 0.92,
					[2] = 4.04,
				},
				[223] = 
				{
					[1] = 0.93,
					[2] = 4.03,
				},
				[224] = 
				{
					[1] = 0.93,
					[2] = 4.03,
				},
				[225] = 
				{
					[1] = 0.94,
					[2] = 4.02,
				},
				[226] = 
				{
					[1] = 0.94,
					[2] = 4.02,
				},
				[227] = 
				{
					[1] = 0.95,
					[2] = 4.01,
				},
				[228] = 
				{
					[1] = 0.95,
					[2] = 4.01,
				},
				[229] = 
				{
					[1] = 0.95,
					[2] = 4,
				},
				[230] = 
				{
					[1] = 0.96,
					[2] = 4,
				},
				[231] = 
				{
					[1] = 0.96,
					[2] = 3.99,
				},
				[232] = 
				{
					[1] = 0.97,
					[2] = 3.99,
				},
				[233] = 
				{
					[1] = 0.97,
					[2] = 3.98,
				},
				[234] = 
				{
					[1] = 0.97,
					[2] = 3.97,
				},
				[235] = 
				{
					[1] = 0.98,
					[2] = 3.97,
				},
				[236] = 
				{
					[1] = 0.98,
					[2] = 3.96,
				},
				[237] = 
				{
					[1] = 0.99,
					[2] = 3.96,
				},
				[238] = 
				{
					[1] = 0.99,
					[2] = 3.95,
				},
				[239] = 
				{
					[1] = 1,
					[2] = 3.94,
				},
			},
			["WidthScale"] = 0.8,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Kuma",
		["Type"] = "WaterTracer",
	},
	[248] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 207.422211,
			["Lifetime"] = 13.44,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.03,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 5.56,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 271.315643,
			["Lifetime"] = 17.58,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0375,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.44,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 47.842918,
			["Lifetime"] = 3.1,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0375,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 5.65,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Kuma",
		["Type"] = "WaterTracer",
	},
	[249] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 94.300003,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.053,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 1.91,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 3.25,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 4.2,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 4.84,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 5.28,
				},
				[7] = 
				{
					[1] = 0.06,
					[2] = 5.65,
				},
				[8] = 
				{
					[1] = 0.07,
					[2] = 6,
				},
				[9] = 
				{
					[1] = 0.09,
					[2] = 6.26,
				},
				[10] = 
				{
					[1] = 0.1,
					[2] = 6.43,
				},
				[11] = 
				{
					[1] = 0.11,
					[2] = 6.61,
				},
				[12] = 
				{
					[1] = 0.12,
					[2] = 6.77,
				},
				[13] = 
				{
					[1] = 0.13,
					[2] = 6.94,
				},
				[14] = 
				{
					[1] = 0.14,
					[2] = 7.02,
				},
				[15] = 
				{
					[1] = 0.15,
					[2] = 7.09,
				},
				[16] = 
				{
					[1] = 0.16,
					[2] = 7.16,
				},
				[17] = 
				{
					[1] = 0.17,
					[2] = 7.23,
				},
				[18] = 
				{
					[1] = 0.18,
					[2] = 7.27,
				},
				[19] = 
				{
					[1] = 0.19,
					[2] = 7.28,
				},
				[20] = 
				{
					[1] = 0.2,
					[2] = 7.28,
				},
				[21] = 
				{
					[1] = 0.21,
					[2] = 7.28,
				},
				[22] = 
				{
					[1] = 0.22,
					[2] = 7.28,
				},
				[23] = 
				{
					[1] = 0.23,
					[2] = 7.28,
				},
				[24] = 
				{
					[1] = 0.24,
					[2] = 7.28,
				},
				[25] = 
				{
					[1] = 0.26,
					[2] = 7.28,
				},
				[26] = 
				{
					[1] = 0.27,
					[2] = 7.28,
				},
				[27] = 
				{
					[1] = 0.28,
					[2] = 7.29,
				},
				[28] = 
				{
					[1] = 0.29,
					[2] = 7.29,
				},
				[29] = 
				{
					[1] = 0.3,
					[2] = 7.29,
				},
				[30] = 
				{
					[1] = 0.31,
					[2] = 7.29,
				},
				[31] = 
				{
					[1] = 0.32,
					[2] = 7.3,
				},
				[32] = 
				{
					[1] = 0.33,
					[2] = 7.3,
				},
				[33] = 
				{
					[1] = 0.34,
					[2] = 7.3,
				},
				[34] = 
				{
					[1] = 0.35,
					[2] = 7.3,
				},
				[35] = 
				{
					[1] = 0.36,
					[2] = 7.3,
				},
				[36] = 
				{
					[1] = 0.37,
					[2] = 7.3,
				},
				[37] = 
				{
					[1] = 0.38,
					[2] = 7.31,
				},
				[38] = 
				{
					[1] = 0.39,
					[2] = 7.31,
				},
				[39] = 
				{
					[1] = 0.4,
					[2] = 7.31,
				},
				[40] = 
				{
					[1] = 0.41,
					[2] = 7.31,
				},
				[41] = 
				{
					[1] = 0.43,
					[2] = 7.31,
				},
				[42] = 
				{
					[1] = 0.44,
					[2] = 7.31,
				},
				[43] = 
				{
					[1] = 0.45,
					[2] = 7.31,
				},
				[44] = 
				{
					[1] = 0.46,
					[2] = 7.32,
				},
				[45] = 
				{
					[1] = 0.47,
					[2] = 7.32,
				},
				[46] = 
				{
					[1] = 0.48,
					[2] = 7.32,
				},
				[47] = 
				{
					[1] = 0.49,
					[2] = 7.32,
				},
				[48] = 
				{
					[1] = 0.5,
					[2] = 7.33,
				},
				[49] = 
				{
					[1] = 0.51,
					[2] = 7.33,
				},
				[50] = 
				{
					[1] = 0.52,
					[2] = 7.33,
				},
				[51] = 
				{
					[1] = 0.53,
					[2] = 7.33,
				},
				[52] = 
				{
					[1] = 0.54,
					[2] = 7.34,
				},
				[53] = 
				{
					[1] = 0.55,
					[2] = 7.33,
				},
				[54] = 
				{
					[1] = 0.56,
					[2] = 7.33,
				},
				[55] = 
				{
					[1] = 0.57,
					[2] = 7.33,
				},
				[56] = 
				{
					[1] = 0.59,
					[2] = 7.33,
				},
				[57] = 
				{
					[1] = 0.6,
					[2] = 7.32,
				},
				[58] = 
				{
					[1] = 0.61,
					[2] = 7.32,
				},
				[59] = 
				{
					[1] = 0.62,
					[2] = 7.32,
				},
				[60] = 
				{
					[1] = 0.63,
					[2] = 7.32,
				},
				[61] = 
				{
					[1] = 0.64,
					[2] = 7.31,
				},
				[62] = 
				{
					[1] = 0.65,
					[2] = 7.31,
				},
				[63] = 
				{
					[1] = 0.66,
					[2] = 7.31,
				},
				[64] = 
				{
					[1] = 0.67,
					[2] = 7.3,
				},
				[65] = 
				{
					[1] = 0.68,
					[2] = 7.3,
				},
				[66] = 
				{
					[1] = 0.69,
					[2] = 7.3,
				},
				[67] = 
				{
					[1] = 0.7,
					[2] = 7.29,
				},
				[68] = 
				{
					[1] = 0.71,
					[2] = 7.29,
				},
				[69] = 
				{
					[1] = 0.72,
					[2] = 7.29,
				},
				[70] = 
				{
					[1] = 0.73,
					[2] = 7.28,
				},
				[71] = 
				{
					[1] = 0.74,
					[2] = 7.27,
				},
				[72] = 
				{
					[1] = 0.76,
					[2] = 7.26,
				},
				[73] = 
				{
					[1] = 0.77,
					[2] = 7.24,
				},
				[74] = 
				{
					[1] = 0.78,
					[2] = 7.23,
				},
				[75] = 
				{
					[1] = 0.79,
					[2] = 7.21,
				},
				[76] = 
				{
					[1] = 0.8,
					[2] = 7.19,
				},
				[77] = 
				{
					[1] = 0.81,
					[2] = 7.18,
				},
				[78] = 
				{
					[1] = 0.82,
					[2] = 7.16,
				},
				[79] = 
				{
					[1] = 0.83,
					[2] = 7.15,
				},
				[80] = 
				{
					[1] = 0.84,
					[2] = 7.1,
				},
				[81] = 
				{
					[1] = 0.85,
					[2] = 7.04,
				},
				[82] = 
				{
					[1] = 0.86,
					[2] = 6.97,
				},
				[83] = 
				{
					[1] = 0.87,
					[2] = 6.91,
				},
				[84] = 
				{
					[1] = 0.88,
					[2] = 6.76,
				},
				[85] = 
				{
					[1] = 0.89,
					[2] = 6.58,
				},
				[86] = 
				{
					[1] = 0.9,
					[2] = 6.39,
				},
				[87] = 
				{
					[1] = 0.91,
					[2] = 6.13,
				},
				[88] = 
				{
					[1] = 0.93,
					[2] = 5.82,
				},
				[89] = 
				{
					[1] = 0.94,
					[2] = 5.52,
				},
				[90] = 
				{
					[1] = 0.95,
					[2] = 5.17,
				},
				[91] = 
				{
					[1] = 0.96,
					[2] = 4.65,
				},
				[92] = 
				{
					[1] = 0.97,
					[2] = 4.02,
				},
				[93] = 
				{
					[1] = 0.98,
					[2] = 3.29,
				},
				[94] = 
				{
					[1] = 0.99,
					[2] = 2.33,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3.5,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.3,
				},
				[3] = 
				{
					[1] = 0.09,
					[2] = 0.4,
				},
				[4] = 
				{
					[1] = 0.13,
					[2] = 0.45,
				},
				[5] = 
				{
					[1] = 0.17,
					[2] = 0.48,
				},
				[6] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[7] = 
				{
					[1] = 0.26,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.3,
					[2] = 0.49,
				},
				[9] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[10] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[11] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[12] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[13] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[14] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[15] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[16] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[17] = 
				{
					[1] = 0.7,
					[2] = 0.25,
				},
				[18] = 
				{
					[1] = 0.74,
					[2] = 0.21,
				},
				[19] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[20] = 
				{
					[1] = 0.83,
					[2] = 0.14,
				},
				[21] = 
				{
					[1] = 0.87,
					[2] = 0.11,
				},
				[22] = 
				{
					[1] = 0.91,
					[2] = 0.07,
				},
				[23] = 
				{
					[1] = 0.96,
					[2] = 0.04,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12.15,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.87,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.32,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.76,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 2.05,
				},
				[6] = 
				{
					[1] = 0.04,
					[2] = 2.32,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 2.6,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 2.87,
				},
				[9] = 
				{
					[1] = 0.06,
					[2] = 3.14,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 3.41,
				},
				[11] = 
				{
					[1] = 0.07,
					[2] = 3.68,
				},
				[12] = 
				{
					[1] = 0.08,
					[2] = 3.94,
				},
				[13] = 
				{
					[1] = 0.09,
					[2] = 4.2,
				},
				[14] = 
				{
					[1] = 0.09,
					[2] = 4.46,
				},
				[15] = 
				{
					[1] = 0.1,
					[2] = 4.72,
				},
				[16] = 
				{
					[1] = 0.11,
					[2] = 4.98,
				},
				[17] = 
				{
					[1] = 0.11,
					[2] = 5.23,
				},
				[18] = 
				{
					[1] = 0.12,
					[2] = 5.48,
				},
				[19] = 
				{
					[1] = 0.13,
					[2] = 5.72,
				},
				[20] = 
				{
					[1] = 0.13,
					[2] = 5.88,
				},
				[21] = 
				{
					[1] = 0.14,
					[2] = 6.04,
				},
				[22] = 
				{
					[1] = 0.15,
					[2] = 6.2,
				},
				[23] = 
				{
					[1] = 0.16,
					[2] = 6.36,
				},
				[24] = 
				{
					[1] = 0.16,
					[2] = 6.54,
				},
				[25] = 
				{
					[1] = 0.17,
					[2] = 6.68,
				},
				[26] = 
				{
					[1] = 0.18,
					[2] = 6.82,
				},
				[27] = 
				{
					[1] = 0.18,
					[2] = 6.96,
				},
				[28] = 
				{
					[1] = 0.19,
					[2] = 7.09,
				},
				[29] = 
				{
					[1] = 0.2,
					[2] = 7.23,
				},
				[30] = 
				{
					[1] = 0.21,
					[2] = 7.36,
				},
				[31] = 
				{
					[1] = 0.21,
					[2] = 7.5,
				},
				[32] = 
				{
					[1] = 0.22,
					[2] = 7.63,
				},
				[33] = 
				{
					[1] = 0.23,
					[2] = 7.76,
				},
				[34] = 
				{
					[1] = 0.23,
					[2] = 7.89,
				},
				[35] = 
				{
					[1] = 0.24,
					[2] = 8.02,
				},
				[36] = 
				{
					[1] = 0.25,
					[2] = 8.1,
				},
				[37] = 
				{
					[1] = 0.26,
					[2] = 8.14,
				},
				[38] = 
				{
					[1] = 0.26,
					[2] = 8.18,
				},
				[39] = 
				{
					[1] = 0.27,
					[2] = 8.23,
				},
				[40] = 
				{
					[1] = 0.28,
					[2] = 8.27,
				},
				[41] = 
				{
					[1] = 0.28,
					[2] = 8.31,
				},
				[42] = 
				{
					[1] = 0.29,
					[2] = 8.35,
				},
				[43] = 
				{
					[1] = 0.3,
					[2] = 8.39,
				},
				[44] = 
				{
					[1] = 0.3,
					[2] = 8.43,
				},
				[45] = 
				{
					[1] = 0.31,
					[2] = 8.47,
				},
				[46] = 
				{
					[1] = 0.32,
					[2] = 8.5,
				},
				[47] = 
				{
					[1] = 0.33,
					[2] = 8.54,
				},
				[48] = 
				{
					[1] = 0.33,
					[2] = 8.58,
				},
				[49] = 
				{
					[1] = 0.34,
					[2] = 8.61,
				},
				[50] = 
				{
					[1] = 0.35,
					[2] = 8.65,
				},
				[51] = 
				{
					[1] = 0.35,
					[2] = 8.68,
				},
				[52] = 
				{
					[1] = 0.36,
					[2] = 8.72,
				},
				[53] = 
				{
					[1] = 0.37,
					[2] = 8.75,
				},
				[54] = 
				{
					[1] = 0.38,
					[2] = 8.77,
				},
				[55] = 
				{
					[1] = 0.38,
					[2] = 8.79,
				},
				[56] = 
				{
					[1] = 0.39,
					[2] = 8.81,
				},
				[57] = 
				{
					[1] = 0.4,
					[2] = 8.83,
				},
				[58] = 
				{
					[1] = 0.4,
					[2] = 8.84,
				},
				[59] = 
				{
					[1] = 0.41,
					[2] = 8.86,
				},
				[60] = 
				{
					[1] = 0.42,
					[2] = 8.88,
				},
				[61] = 
				{
					[1] = 0.43,
					[2] = 8.89,
				},
				[62] = 
				{
					[1] = 0.43,
					[2] = 8.91,
				},
				[63] = 
				{
					[1] = 0.44,
					[2] = 8.92,
				},
				[64] = 
				{
					[1] = 0.45,
					[2] = 8.94,
				},
				[65] = 
				{
					[1] = 0.45,
					[2] = 8.95,
				},
				[66] = 
				{
					[1] = 0.46,
					[2] = 8.97,
				},
				[67] = 
				{
					[1] = 0.47,
					[2] = 8.98,
				},
				[68] = 
				{
					[1] = 0.48,
					[2] = 8.99,
				},
				[69] = 
				{
					[1] = 0.48,
					[2] = 9,
				},
				[70] = 
				{
					[1] = 0.49,
					[2] = 9.02,
				},
				[71] = 
				{
					[1] = 0.5,
					[2] = 9.03,
				},
				[72] = 
				{
					[1] = 0.5,
					[2] = 9.04,
				},
				[73] = 
				{
					[1] = 0.51,
					[2] = 9.05,
				},
				[74] = 
				{
					[1] = 0.52,
					[2] = 9.06,
				},
				[75] = 
				{
					[1] = 0.52,
					[2] = 9.07,
				},
				[76] = 
				{
					[1] = 0.53,
					[2] = 9.06,
				},
				[77] = 
				{
					[1] = 0.54,
					[2] = 9.04,
				},
				[78] = 
				{
					[1] = 0.55,
					[2] = 9.02,
				},
				[79] = 
				{
					[1] = 0.55,
					[2] = 9,
				},
				[80] = 
				{
					[1] = 0.56,
					[2] = 8.98,
				},
				[81] = 
				{
					[1] = 0.57,
					[2] = 8.96,
				},
				[82] = 
				{
					[1] = 0.57,
					[2] = 8.94,
				},
				[83] = 
				{
					[1] = 0.58,
					[2] = 8.93,
				},
				[84] = 
				{
					[1] = 0.59,
					[2] = 8.91,
				},
				[85] = 
				{
					[1] = 0.6,
					[2] = 8.89,
				},
				[86] = 
				{
					[1] = 0.6,
					[2] = 8.87,
				},
				[87] = 
				{
					[1] = 0.61,
					[2] = 8.85,
				},
				[88] = 
				{
					[1] = 0.62,
					[2] = 8.83,
				},
				[89] = 
				{
					[1] = 0.62,
					[2] = 8.8,
				},
				[90] = 
				{
					[1] = 0.63,
					[2] = 8.78,
				},
				[91] = 
				{
					[1] = 0.64,
					[2] = 8.76,
				},
				[92] = 
				{
					[1] = 0.65,
					[2] = 8.74,
				},
				[93] = 
				{
					[1] = 0.65,
					[2] = 8.72,
				},
				[94] = 
				{
					[1] = 0.66,
					[2] = 8.7,
				},
				[95] = 
				{
					[1] = 0.67,
					[2] = 8.67,
				},
				[96] = 
				{
					[1] = 0.67,
					[2] = 8.65,
				},
				[97] = 
				{
					[1] = 0.68,
					[2] = 8.63,
				},
				[98] = 
				{
					[1] = 0.69,
					[2] = 8.61,
				},
				[99] = 
				{
					[1] = 0.7,
					[2] = 8.58,
				},
				[100] = 
				{
					[1] = 0.7,
					[2] = 8.56,
				},
				[101] = 
				{
					[1] = 0.71,
					[2] = 8.53,
				},
				[102] = 
				{
					[1] = 0.72,
					[2] = 8.51,
				},
				[103] = 
				{
					[1] = 0.72,
					[2] = 8.48,
				},
				[104] = 
				{
					[1] = 0.73,
					[2] = 8.45,
				},
				[105] = 
				{
					[1] = 0.74,
					[2] = 8.43,
				},
				[106] = 
				{
					[1] = 0.74,
					[2] = 8.4,
				},
				[107] = 
				{
					[1] = 0.75,
					[2] = 8.37,
				},
				[108] = 
				{
					[1] = 0.76,
					[2] = 8.35,
				},
				[109] = 
				{
					[1] = 0.77,
					[2] = 8.32,
				},
				[110] = 
				{
					[1] = 0.77,
					[2] = 8.29,
				},
				[111] = 
				{
					[1] = 0.78,
					[2] = 8.26,
				},
				[112] = 
				{
					[1] = 0.79,
					[2] = 8.24,
				},
				[113] = 
				{
					[1] = 0.79,
					[2] = 8.21,
				},
				[114] = 
				{
					[1] = 0.8,
					[2] = 8.18,
				},
				[115] = 
				{
					[1] = 0.81,
					[2] = 8.15,
				},
				[116] = 
				{
					[1] = 0.82,
					[2] = 8.12,
				},
				[117] = 
				{
					[1] = 0.82,
					[2] = 8.09,
				},
				[118] = 
				{
					[1] = 0.83,
					[2] = 8.06,
				},
				[119] = 
				{
					[1] = 0.84,
					[2] = 8.03,
				},
				[120] = 
				{
					[1] = 0.84,
					[2] = 8,
				},
				[121] = 
				{
					[1] = 0.85,
					[2] = 7.97,
				},
				[122] = 
				{
					[1] = 0.86,
					[2] = 7.94,
				},
				[123] = 
				{
					[1] = 0.87,
					[2] = 7.91,
				},
				[124] = 
				{
					[1] = 0.87,
					[2] = 7.87,
				},
				[125] = 
				{
					[1] = 0.88,
					[2] = 7.82,
				},
				[126] = 
				{
					[1] = 0.89,
					[2] = 7.78,
				},
				[127] = 
				{
					[1] = 0.89,
					[2] = 7.74,
				},
				[128] = 
				{
					[1] = 0.9,
					[2] = 7.7,
				},
				[129] = 
				{
					[1] = 0.91,
					[2] = 7.66,
				},
				[130] = 
				{
					[1] = 0.91,
					[2] = 7.61,
				},
				[131] = 
				{
					[1] = 0.92,
					[2] = 7.57,
				},
				[132] = 
				{
					[1] = 0.93,
					[2] = 7.53,
				},
				[133] = 
				{
					[1] = 0.94,
					[2] = 7.49,
				},
				[134] = 
				{
					[1] = 0.94,
					[2] = 7.44,
				},
				[135] = 
				{
					[1] = 0.95,
					[2] = 7.4,
				},
				[136] = 
				{
					[1] = 0.96,
					[2] = 7.36,
				},
				[137] = 
				{
					[1] = 0.96,
					[2] = 7.31,
				},
				[138] = 
				{
					[1] = 0.97,
					[2] = 7.27,
				},
				[139] = 
				{
					[1] = 0.98,
					[2] = 7.23,
				},
				[140] = 
				{
					[1] = 0.99,
					[2] = 7.18,
				},
				[141] = 
				{
					[1] = 0.99,
					[2] = 7.14,
				},
			},
			["WidthScale"] = 0.7,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_LST_mark5",
		["Type"] = "WaterTracer",
	},
	[250] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 122.565331,
			["Lifetime"] = 9.53,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0401,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.16,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 160.248062,
			["Lifetime"] = 12.46,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0501,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.83,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 28.294201,
			["Lifetime"] = 2.2,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0501,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.22,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_LST_mark5",
		["Type"] = "WaterTracer",
	},
	[251] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 102.599998,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0487,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.96,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 1.43,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 1.9,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 2.31,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 2.58,
				},
				[7] = 
				{
					[1] = 0.06,
					[2] = 2.77,
				},
				[8] = 
				{
					[1] = 0.07,
					[2] = 2.94,
				},
				[9] = 
				{
					[1] = 0.08,
					[2] = 3.11,
				},
				[10] = 
				{
					[1] = 0.09,
					[2] = 3.26,
				},
				[11] = 
				{
					[1] = 0.1,
					[2] = 3.34,
				},
				[12] = 
				{
					[1] = 0.11,
					[2] = 3.42,
				},
				[13] = 
				{
					[1] = 0.12,
					[2] = 3.5,
				},
				[14] = 
				{
					[1] = 0.13,
					[2] = 3.59,
				},
				[15] = 
				{
					[1] = 0.14,
					[2] = 3.66,
				},
				[16] = 
				{
					[1] = 0.15,
					[2] = 3.73,
				},
				[17] = 
				{
					[1] = 0.16,
					[2] = 3.79,
				},
				[18] = 
				{
					[1] = 0.17,
					[2] = 3.85,
				},
				[19] = 
				{
					[1] = 0.18,
					[2] = 3.91,
				},
				[20] = 
				{
					[1] = 0.19,
					[2] = 3.98,
				},
				[21] = 
				{
					[1] = 0.2,
					[2] = 4.07,
				},
				[22] = 
				{
					[1] = 0.21,
					[2] = 4.1,
				},
				[23] = 
				{
					[1] = 0.22,
					[2] = 4.14,
				},
				[24] = 
				{
					[1] = 0.23,
					[2] = 4.17,
				},
				[25] = 
				{
					[1] = 0.24,
					[2] = 4.21,
				},
				[26] = 
				{
					[1] = 0.25,
					[2] = 4.24,
				},
				[27] = 
				{
					[1] = 0.25,
					[2] = 4.27,
				},
				[28] = 
				{
					[1] = 0.26,
					[2] = 4.31,
				},
				[29] = 
				{
					[1] = 0.27,
					[2] = 4.34,
				},
				[30] = 
				{
					[1] = 0.28,
					[2] = 4.35,
				},
				[31] = 
				{
					[1] = 0.29,
					[2] = 4.36,
				},
				[32] = 
				{
					[1] = 0.3,
					[2] = 4.36,
				},
				[33] = 
				{
					[1] = 0.31,
					[2] = 4.37,
				},
				[34] = 
				{
					[1] = 0.32,
					[2] = 4.38,
				},
				[35] = 
				{
					[1] = 0.33,
					[2] = 4.38,
				},
				[36] = 
				{
					[1] = 0.34,
					[2] = 4.39,
				},
				[37] = 
				{
					[1] = 0.35,
					[2] = 4.39,
				},
				[38] = 
				{
					[1] = 0.36,
					[2] = 4.4,
				},
				[39] = 
				{
					[1] = 0.37,
					[2] = 4.4,
				},
				[40] = 
				{
					[1] = 0.38,
					[2] = 4.41,
				},
				[41] = 
				{
					[1] = 0.39,
					[2] = 4.41,
				},
				[42] = 
				{
					[1] = 0.4,
					[2] = 4.42,
				},
				[43] = 
				{
					[1] = 0.41,
					[2] = 4.42,
				},
				[44] = 
				{
					[1] = 0.42,
					[2] = 4.43,
				},
				[45] = 
				{
					[1] = 0.43,
					[2] = 4.43,
				},
				[46] = 
				{
					[1] = 0.44,
					[2] = 4.44,
				},
				[47] = 
				{
					[1] = 0.45,
					[2] = 4.44,
				},
				[48] = 
				{
					[1] = 0.46,
					[2] = 4.45,
				},
				[49] = 
				{
					[1] = 0.47,
					[2] = 4.45,
				},
				[50] = 
				{
					[1] = 0.48,
					[2] = 4.46,
				},
				[51] = 
				{
					[1] = 0.49,
					[2] = 4.46,
				},
				[52] = 
				{
					[1] = 0.5,
					[2] = 4.46,
				},
				[53] = 
				{
					[1] = 0.51,
					[2] = 4.47,
				},
				[54] = 
				{
					[1] = 0.52,
					[2] = 4.47,
				},
				[55] = 
				{
					[1] = 0.53,
					[2] = 4.48,
				},
				[56] = 
				{
					[1] = 0.54,
					[2] = 4.48,
				},
				[57] = 
				{
					[1] = 0.55,
					[2] = 4.49,
				},
				[58] = 
				{
					[1] = 0.56,
					[2] = 4.49,
				},
				[59] = 
				{
					[1] = 0.57,
					[2] = 4.5,
				},
				[60] = 
				{
					[1] = 0.58,
					[2] = 4.5,
				},
				[61] = 
				{
					[1] = 0.59,
					[2] = 4.51,
				},
				[62] = 
				{
					[1] = 0.6,
					[2] = 4.51,
				},
				[63] = 
				{
					[1] = 0.61,
					[2] = 4.52,
				},
				[64] = 
				{
					[1] = 0.62,
					[2] = 4.52,
				},
				[65] = 
				{
					[1] = 0.63,
					[2] = 4.53,
				},
				[66] = 
				{
					[1] = 0.64,
					[2] = 4.54,
				},
				[67] = 
				{
					[1] = 0.65,
					[2] = 4.54,
				},
				[68] = 
				{
					[1] = 0.66,
					[2] = 4.55,
				},
				[69] = 
				{
					[1] = 0.67,
					[2] = 4.55,
				},
				[70] = 
				{
					[1] = 0.68,
					[2] = 4.56,
				},
				[71] = 
				{
					[1] = 0.69,
					[2] = 4.56,
				},
				[72] = 
				{
					[1] = 0.7,
					[2] = 4.57,
				},
				[73] = 
				{
					[1] = 0.71,
					[2] = 4.57,
				},
				[74] = 
				{
					[1] = 0.72,
					[2] = 4.58,
				},
				[75] = 
				{
					[1] = 0.73,
					[2] = 4.58,
				},
				[76] = 
				{
					[1] = 0.74,
					[2] = 4.59,
				},
				[77] = 
				{
					[1] = 0.75,
					[2] = 4.59,
				},
				[78] = 
				{
					[1] = 0.75,
					[2] = 4.6,
				},
				[79] = 
				{
					[1] = 0.76,
					[2] = 4.6,
				},
				[80] = 
				{
					[1] = 0.77,
					[2] = 4.61,
				},
				[81] = 
				{
					[1] = 0.78,
					[2] = 4.61,
				},
				[82] = 
				{
					[1] = 0.79,
					[2] = 4.61,
				},
				[83] = 
				{
					[1] = 0.8,
					[2] = 4.59,
				},
				[84] = 
				{
					[1] = 0.81,
					[2] = 4.58,
				},
				[85] = 
				{
					[1] = 0.82,
					[2] = 4.56,
				},
				[86] = 
				{
					[1] = 0.83,
					[2] = 4.55,
				},
				[87] = 
				{
					[1] = 0.84,
					[2] = 4.53,
				},
				[88] = 
				{
					[1] = 0.85,
					[2] = 4.51,
				},
				[89] = 
				{
					[1] = 0.86,
					[2] = 4.48,
				},
				[90] = 
				{
					[1] = 0.87,
					[2] = 4.45,
				},
				[91] = 
				{
					[1] = 0.88,
					[2] = 4.41,
				},
				[92] = 
				{
					[1] = 0.89,
					[2] = 4.38,
				},
				[93] = 
				{
					[1] = 0.9,
					[2] = 4.34,
				},
				[94] = 
				{
					[1] = 0.91,
					[2] = 4.31,
				},
				[95] = 
				{
					[1] = 0.92,
					[2] = 4.28,
				},
				[96] = 
				{
					[1] = 0.93,
					[2] = 4.15,
				},
				[97] = 
				{
					[1] = 0.94,
					[2] = 4.02,
				},
				[98] = 
				{
					[1] = 0.95,
					[2] = 3.84,
				},
				[99] = 
				{
					[1] = 0.96,
					[2] = 3.62,
				},
				[100] = 
				{
					[1] = 0.97,
					[2] = 3.35,
				},
				[101] = 
				{
					[1] = 0.98,
					[2] = 2.99,
				},
				[102] = 
				{
					[1] = 0.99,
					[2] = 2.48,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 3,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.29,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.44,
				},
				[5] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[6] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[7] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.28,
					[2] = 0.5,
				},
				[9] = 
				{
					[1] = 0.32,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.36,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[12] = 
				{
					[1] = 0.44,
					[2] = 0.44,
				},
				[13] = 
				{
					[1] = 0.48,
					[2] = 0.41,
				},
				[14] = 
				{
					[1] = 0.52,
					[2] = 0.38,
				},
				[15] = 
				{
					[1] = 0.56,
					[2] = 0.36,
				},
				[16] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[17] = 
				{
					[1] = 0.64,
					[2] = 0.29,
				},
				[18] = 
				{
					[1] = 0.68,
					[2] = 0.26,
				},
				[19] = 
				{
					[1] = 0.72,
					[2] = 0.23,
				},
				[20] = 
				{
					[1] = 0.76,
					[2] = 0.2,
				},
				[21] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
				[22] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[23] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[24] = 
				{
					[1] = 0.92,
					[2] = 0.06,
				},
				[25] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12.39,
			["LocalSpace"] = true,
			["MaxSpeed"] = 18.0054,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.43,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.62,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 0.81,
				},
				[5] = 
				{
					[1] = 0.03,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.18,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.36,
				},
				[8] = 
				{
					[1] = 0.05,
					[2] = 1.54,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.7,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 1.78,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 1.86,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 1.95,
				},
				[13] = 
				{
					[1] = 0.08,
					[2] = 2.03,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 2.11,
				},
				[15] = 
				{
					[1] = 0.09,
					[2] = 2.2,
				},
				[16] = 
				{
					[1] = 0.1,
					[2] = 2.28,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 2.36,
				},
				[18] = 
				{
					[1] = 0.11,
					[2] = 2.44,
				},
				[19] = 
				{
					[1] = 0.12,
					[2] = 2.52,
				},
				[20] = 
				{
					[1] = 0.12,
					[2] = 2.6,
				},
				[21] = 
				{
					[1] = 0.13,
					[2] = 2.68,
				},
				[22] = 
				{
					[1] = 0.14,
					[2] = 2.76,
				},
				[23] = 
				{
					[1] = 0.14,
					[2] = 2.84,
				},
				[24] = 
				{
					[1] = 0.15,
					[2] = 2.91,
				},
				[25] = 
				{
					[1] = 0.16,
					[2] = 2.99,
				},
				[26] = 
				{
					[1] = 0.16,
					[2] = 3.07,
				},
				[27] = 
				{
					[1] = 0.17,
					[2] = 3.14,
				},
				[28] = 
				{
					[1] = 0.18,
					[2] = 3.22,
				},
				[29] = 
				{
					[1] = 0.18,
					[2] = 3.29,
				},
				[30] = 
				{
					[1] = 0.19,
					[2] = 3.37,
				},
				[31] = 
				{
					[1] = 0.19,
					[2] = 3.44,
				},
				[32] = 
				{
					[1] = 0.2,
					[2] = 3.51,
				},
				[33] = 
				{
					[1] = 0.21,
					[2] = 3.58,
				},
				[34] = 
				{
					[1] = 0.21,
					[2] = 3.65,
				},
				[35] = 
				{
					[1] = 0.22,
					[2] = 3.72,
				},
				[36] = 
				{
					[1] = 0.23,
					[2] = 3.79,
				},
				[37] = 
				{
					[1] = 0.23,
					[2] = 3.86,
				},
				[38] = 
				{
					[1] = 0.24,
					[2] = 3.92,
				},
				[39] = 
				{
					[1] = 0.25,
					[2] = 3.96,
				},
				[40] = 
				{
					[1] = 0.25,
					[2] = 3.99,
				},
				[41] = 
				{
					[1] = 0.26,
					[2] = 4.02,
				},
				[42] = 
				{
					[1] = 0.27,
					[2] = 4.05,
				},
				[43] = 
				{
					[1] = 0.27,
					[2] = 4.09,
				},
				[44] = 
				{
					[1] = 0.28,
					[2] = 4.12,
				},
				[45] = 
				{
					[1] = 0.29,
					[2] = 4.15,
				},
				[46] = 
				{
					[1] = 0.29,
					[2] = 4.18,
				},
				[47] = 
				{
					[1] = 0.3,
					[2] = 4.21,
				},
				[48] = 
				{
					[1] = 0.31,
					[2] = 4.24,
				},
				[49] = 
				{
					[1] = 0.31,
					[2] = 4.27,
				},
				[50] = 
				{
					[1] = 0.32,
					[2] = 4.3,
				},
				[51] = 
				{
					[1] = 0.32,
					[2] = 4.33,
				},
				[52] = 
				{
					[1] = 0.33,
					[2] = 4.35,
				},
				[53] = 
				{
					[1] = 0.34,
					[2] = 4.38,
				},
				[54] = 
				{
					[1] = 0.34,
					[2] = 4.39,
				},
				[55] = 
				{
					[1] = 0.35,
					[2] = 4.4,
				},
				[56] = 
				{
					[1] = 0.36,
					[2] = 4.41,
				},
				[57] = 
				{
					[1] = 0.36,
					[2] = 4.42,
				},
				[58] = 
				{
					[1] = 0.37,
					[2] = 4.43,
				},
				[59] = 
				{
					[1] = 0.38,
					[2] = 4.44,
				},
				[60] = 
				{
					[1] = 0.38,
					[2] = 4.45,
				},
				[61] = 
				{
					[1] = 0.39,
					[2] = 4.46,
				},
				[62] = 
				{
					[1] = 0.4,
					[2] = 4.47,
				},
				[63] = 
				{
					[1] = 0.4,
					[2] = 4.48,
				},
				[64] = 
				{
					[1] = 0.41,
					[2] = 4.49,
				},
				[65] = 
				{
					[1] = 0.42,
					[2] = 4.5,
				},
				[66] = 
				{
					[1] = 0.42,
					[2] = 4.5,
				},
				[67] = 
				{
					[1] = 0.43,
					[2] = 4.51,
				},
				[68] = 
				{
					[1] = 0.44,
					[2] = 4.52,
				},
				[69] = 
				{
					[1] = 0.44,
					[2] = 4.53,
				},
				[70] = 
				{
					[1] = 0.45,
					[2] = 4.54,
				},
				[71] = 
				{
					[1] = 0.45,
					[2] = 4.54,
				},
				[72] = 
				{
					[1] = 0.46,
					[2] = 4.55,
				},
				[73] = 
				{
					[1] = 0.47,
					[2] = 4.56,
				},
				[74] = 
				{
					[1] = 0.47,
					[2] = 4.56,
				},
				[75] = 
				{
					[1] = 0.48,
					[2] = 4.57,
				},
				[76] = 
				{
					[1] = 0.49,
					[2] = 4.58,
				},
				[77] = 
				{
					[1] = 0.49,
					[2] = 4.58,
				},
				[78] = 
				{
					[1] = 0.5,
					[2] = 4.59,
				},
				[79] = 
				{
					[1] = 0.51,
					[2] = 4.6,
				},
				[80] = 
				{
					[1] = 0.51,
					[2] = 4.6,
				},
				[81] = 
				{
					[1] = 0.52,
					[2] = 4.61,
				},
				[82] = 
				{
					[1] = 0.53,
					[2] = 4.61,
				},
				[83] = 
				{
					[1] = 0.53,
					[2] = 4.62,
				},
				[84] = 
				{
					[1] = 0.54,
					[2] = 4.62,
				},
				[85] = 
				{
					[1] = 0.55,
					[2] = 4.62,
				},
				[86] = 
				{
					[1] = 0.55,
					[2] = 4.63,
				},
				[87] = 
				{
					[1] = 0.56,
					[2] = 4.63,
				},
				[88] = 
				{
					[1] = 0.56,
					[2] = 4.64,
				},
				[89] = 
				{
					[1] = 0.57,
					[2] = 4.63,
				},
				[90] = 
				{
					[1] = 0.58,
					[2] = 4.62,
				},
				[91] = 
				{
					[1] = 0.58,
					[2] = 4.61,
				},
				[92] = 
				{
					[1] = 0.59,
					[2] = 4.6,
				},
				[93] = 
				{
					[1] = 0.6,
					[2] = 4.59,
				},
				[94] = 
				{
					[1] = 0.6,
					[2] = 4.58,
				},
				[95] = 
				{
					[1] = 0.61,
					[2] = 4.57,
				},
				[96] = 
				{
					[1] = 0.62,
					[2] = 4.56,
				},
				[97] = 
				{
					[1] = 0.62,
					[2] = 4.55,
				},
				[98] = 
				{
					[1] = 0.63,
					[2] = 4.54,
				},
				[99] = 
				{
					[1] = 0.64,
					[2] = 4.53,
				},
				[100] = 
				{
					[1] = 0.64,
					[2] = 4.52,
				},
				[101] = 
				{
					[1] = 0.65,
					[2] = 4.51,
				},
				[102] = 
				{
					[1] = 0.66,
					[2] = 4.5,
				},
				[103] = 
				{
					[1] = 0.66,
					[2] = 4.49,
				},
				[104] = 
				{
					[1] = 0.67,
					[2] = 4.48,
				},
				[105] = 
				{
					[1] = 0.68,
					[2] = 4.47,
				},
				[106] = 
				{
					[1] = 0.68,
					[2] = 4.46,
				},
				[107] = 
				{
					[1] = 0.69,
					[2] = 4.44,
				},
				[108] = 
				{
					[1] = 0.69,
					[2] = 4.43,
				},
				[109] = 
				{
					[1] = 0.7,
					[2] = 4.42,
				},
				[110] = 
				{
					[1] = 0.71,
					[2] = 4.41,
				},
				[111] = 
				{
					[1] = 0.71,
					[2] = 4.4,
				},
				[112] = 
				{
					[1] = 0.72,
					[2] = 4.39,
				},
				[113] = 
				{
					[1] = 0.73,
					[2] = 4.38,
				},
				[114] = 
				{
					[1] = 0.73,
					[2] = 4.36,
				},
				[115] = 
				{
					[1] = 0.74,
					[2] = 4.35,
				},
				[116] = 
				{
					[1] = 0.75,
					[2] = 4.34,
				},
				[117] = 
				{
					[1] = 0.75,
					[2] = 4.33,
				},
				[118] = 
				{
					[1] = 0.76,
					[2] = 4.31,
				},
				[119] = 
				{
					[1] = 0.77,
					[2] = 4.3,
				},
				[120] = 
				{
					[1] = 0.77,
					[2] = 4.29,
				},
				[121] = 
				{
					[1] = 0.78,
					[2] = 4.28,
				},
				[122] = 
				{
					[1] = 0.79,
					[2] = 4.26,
				},
				[123] = 
				{
					[1] = 0.79,
					[2] = 4.25,
				},
				[124] = 
				{
					[1] = 0.8,
					[2] = 4.24,
				},
				[125] = 
				{
					[1] = 0.81,
					[2] = 4.22,
				},
				[126] = 
				{
					[1] = 0.81,
					[2] = 4.21,
				},
				[127] = 
				{
					[1] = 0.82,
					[2] = 4.2,
				},
				[128] = 
				{
					[1] = 0.82,
					[2] = 4.18,
				},
				[129] = 
				{
					[1] = 0.83,
					[2] = 4.17,
				},
				[130] = 
				{
					[1] = 0.84,
					[2] = 4.16,
				},
				[131] = 
				{
					[1] = 0.84,
					[2] = 4.14,
				},
				[132] = 
				{
					[1] = 0.85,
					[2] = 4.13,
				},
				[133] = 
				{
					[1] = 0.86,
					[2] = 4.12,
				},
				[134] = 
				{
					[1] = 0.86,
					[2] = 4.1,
				},
				[135] = 
				{
					[1] = 0.87,
					[2] = 4.09,
				},
				[136] = 
				{
					[1] = 0.88,
					[2] = 4.07,
				},
				[137] = 
				{
					[1] = 0.88,
					[2] = 4.06,
				},
				[138] = 
				{
					[1] = 0.89,
					[2] = 4.04,
				},
				[139] = 
				{
					[1] = 0.9,
					[2] = 4.03,
				},
				[140] = 
				{
					[1] = 0.9,
					[2] = 4.01,
				},
				[141] = 
				{
					[1] = 0.91,
					[2] = 4,
				},
				[142] = 
				{
					[1] = 0.92,
					[2] = 3.98,
				},
				[143] = 
				{
					[1] = 0.92,
					[2] = 3.96,
				},
				[144] = 
				{
					[1] = 0.93,
					[2] = 3.95,
				},
				[145] = 
				{
					[1] = 0.94,
					[2] = 3.93,
				},
				[146] = 
				{
					[1] = 0.94,
					[2] = 3.91,
				},
				[147] = 
				{
					[1] = 0.95,
					[2] = 3.89,
				},
				[148] = 
				{
					[1] = 0.95,
					[2] = 3.88,
				},
				[149] = 
				{
					[1] = 0.96,
					[2] = 3.86,
				},
				[150] = 
				{
					[1] = 0.97,
					[2] = 3.84,
				},
				[151] = 
				{
					[1] = 0.97,
					[2] = 3.82,
				},
				[152] = 
				{
					[1] = 0.98,
					[2] = 3.81,
				},
				[153] = 
				{
					[1] = 0.99,
					[2] = 3.79,
				},
				[154] = 
				{
					[1] = 0.99,
					[2] = 3.77,
				},
			},
			["WidthScale"] = 0.9,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_Minekaze",
		["Type"] = "WaterTracer",
	},
	[252] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 133.420013,
			["Lifetime"] = 7.41,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0405,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.11,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 174.472321,
			["Lifetime"] = 9.69,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0507,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.81,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 30.789234,
			["Lifetime"] = 1.71,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0507,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 4.18,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_Minekaze",
		["Type"] = "WaterTracer",
	},
	[253] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 21.200001,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.2358,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.56,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.67,
				},
				[4] = 
				{
					[1] = 0.14,
					[2] = 0.74,
				},
				[5] = 
				{
					[1] = 0.19,
					[2] = 0.79,
				},
				[6] = 
				{
					[1] = 0.24,
					[2] = 0.83,
				},
				[7] = 
				{
					[1] = 0.29,
					[2] = 0.87,
				},
				[8] = 
				{
					[1] = 0.33,
					[2] = 0.87,
				},
				[9] = 
				{
					[1] = 0.38,
					[2] = 0.87,
				},
				[10] = 
				{
					[1] = 0.43,
					[2] = 0.87,
				},
				[11] = 
				{
					[1] = 0.48,
					[2] = 0.87,
				},
				[12] = 
				{
					[1] = 0.52,
					[2] = 0.87,
				},
				[13] = 
				{
					[1] = 0.57,
					[2] = 0.87,
				},
				[14] = 
				{
					[1] = 0.62,
					[2] = 0.85,
				},
				[15] = 
				{
					[1] = 0.67,
					[2] = 0.82,
				},
				[16] = 
				{
					[1] = 0.71,
					[2] = 0.78,
				},
				[17] = 
				{
					[1] = 0.76,
					[2] = 0.71,
				},
				[18] = 
				{
					[1] = 0.81,
					[2] = 0.64,
				},
				[19] = 
				{
					[1] = 0.86,
					[2] = 0.55,
				},
				[20] = 
				{
					[1] = 0.9,
					[2] = 0.46,
				},
				[21] = 
				{
					[1] = 0.95,
					[2] = 0.36,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.71,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[3] = 
				{
					[1] = 0.4,
					[2] = 0.46,
				},
				[4] = 
				{
					[1] = 0.6,
					[2] = 0.33,
				},
				[5] = 
				{
					[1] = 0.8,
					[2] = 0.16,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 3.18,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.03,
					[2] = 0.55,
				},
				[3] = 
				{
					[1] = 0.06,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.1,
					[2] = 0.8,
				},
				[5] = 
				{
					[1] = 0.13,
					[2] = 0.86,
				},
				[6] = 
				{
					[1] = 0.16,
					[2] = 0.89,
				},
				[7] = 
				{
					[1] = 0.19,
					[2] = 0.9,
				},
				[8] = 
				{
					[1] = 0.23,
					[2] = 0.91,
				},
				[9] = 
				{
					[1] = 0.26,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.29,
					[2] = 0.93,
				},
				[11] = 
				{
					[1] = 0.32,
					[2] = 0.93,
				},
				[12] = 
				{
					[1] = 0.35,
					[2] = 0.94,
				},
				[13] = 
				{
					[1] = 0.39,
					[2] = 0.94,
				},
				[14] = 
				{
					[1] = 0.42,
					[2] = 0.94,
				},
				[15] = 
				{
					[1] = 0.45,
					[2] = 0.94,
				},
				[16] = 
				{
					[1] = 0.48,
					[2] = 0.93,
				},
				[17] = 
				{
					[1] = 0.52,
					[2] = 0.93,
				},
				[18] = 
				{
					[1] = 0.55,
					[2] = 0.92,
				},
				[19] = 
				{
					[1] = 0.58,
					[2] = 0.92,
				},
				[20] = 
				{
					[1] = 0.61,
					[2] = 0.91,
				},
				[21] = 
				{
					[1] = 0.65,
					[2] = 0.9,
				},
				[22] = 
				{
					[1] = 0.68,
					[2] = 0.9,
				},
				[23] = 
				{
					[1] = 0.71,
					[2] = 0.89,
				},
				[24] = 
				{
					[1] = 0.74,
					[2] = 0.88,
				},
				[25] = 
				{
					[1] = 0.77,
					[2] = 0.87,
				},
				[26] = 
				{
					[1] = 0.81,
					[2] = 0.85,
				},
				[27] = 
				{
					[1] = 0.84,
					[2] = 0.83,
				},
				[28] = 
				{
					[1] = 0.87,
					[2] = 0.81,
				},
				[29] = 
				{
					[1] = 0.9,
					[2] = 0.8,
				},
				[30] = 
				{
					[1] = 0.94,
					[2] = 0.78,
				},
				[31] = 
				{
					[1] = 0.97,
					[2] = 0.76,
				},
			},
			["WidthScale"] = 1,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_minisub",
		["Type"] = "WaterTracer",
	},
	[254] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 27.522539,
			["Lifetime"] = 2.14,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.3845,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.43,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 36.010799,
			["Lifetime"] = 2.8,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.4806,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.19,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 6.30189,
			["Lifetime"] = 0.49,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.4806,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.44,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_minisub",
		["Type"] = "WaterTracer",
	},
	[255] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 196.399994,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0255,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.46,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.8,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.11,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.29,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.47,
				},
				[7] = 
				{
					[1] = 0.03,
					[2] = 1.65,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 1.81,
				},
				[9] = 
				{
					[1] = 0.04,
					[2] = 1.94,
				},
				[10] = 
				{
					[1] = 0.05,
					[2] = 2.07,
				},
				[11] = 
				{
					[1] = 0.05,
					[2] = 2.2,
				},
				[12] = 
				{
					[1] = 0.06,
					[2] = 2.33,
				},
				[13] = 
				{
					[1] = 0.06,
					[2] = 2.46,
				},
				[14] = 
				{
					[1] = 0.07,
					[2] = 2.59,
				},
				[15] = 
				{
					[1] = 0.07,
					[2] = 2.72,
				},
				[16] = 
				{
					[1] = 0.08,
					[2] = 2.85,
				},
				[17] = 
				{
					[1] = 0.08,
					[2] = 2.98,
				},
				[18] = 
				{
					[1] = 0.09,
					[2] = 3.11,
				},
				[19] = 
				{
					[1] = 0.09,
					[2] = 3.24,
				},
				[20] = 
				{
					[1] = 0.1,
					[2] = 3.37,
				},
				[21] = 
				{
					[1] = 0.1,
					[2] = 3.47,
				},
				[22] = 
				{
					[1] = 0.11,
					[2] = 3.56,
				},
				[23] = 
				{
					[1] = 0.11,
					[2] = 3.65,
				},
				[24] = 
				{
					[1] = 0.12,
					[2] = 3.75,
				},
				[25] = 
				{
					[1] = 0.12,
					[2] = 3.84,
				},
				[26] = 
				{
					[1] = 0.13,
					[2] = 3.94,
				},
				[27] = 
				{
					[1] = 0.13,
					[2] = 4.03,
				},
				[28] = 
				{
					[1] = 0.14,
					[2] = 4.12,
				},
				[29] = 
				{
					[1] = 0.14,
					[2] = 4.22,
				},
				[30] = 
				{
					[1] = 0.15,
					[2] = 4.31,
				},
				[31] = 
				{
					[1] = 0.15,
					[2] = 4.41,
				},
				[32] = 
				{
					[1] = 0.16,
					[2] = 4.51,
				},
				[33] = 
				{
					[1] = 0.16,
					[2] = 4.61,
				},
				[34] = 
				{
					[1] = 0.17,
					[2] = 4.72,
				},
				[35] = 
				{
					[1] = 0.17,
					[2] = 4.82,
				},
				[36] = 
				{
					[1] = 0.18,
					[2] = 4.93,
				},
				[37] = 
				{
					[1] = 0.18,
					[2] = 5.04,
				},
				[38] = 
				{
					[1] = 0.19,
					[2] = 5.16,
				},
				[39] = 
				{
					[1] = 0.19,
					[2] = 5.28,
				},
				[40] = 
				{
					[1] = 0.2,
					[2] = 5.4,
				},
				[41] = 
				{
					[1] = 0.2,
					[2] = 5.52,
				},
				[42] = 
				{
					[1] = 0.21,
					[2] = 5.64,
				},
				[43] = 
				{
					[1] = 0.21,
					[2] = 5.76,
				},
				[44] = 
				{
					[1] = 0.22,
					[2] = 5.87,
				},
				[45] = 
				{
					[1] = 0.22,
					[2] = 5.99,
				},
				[46] = 
				{
					[1] = 0.23,
					[2] = 6.11,
				},
				[47] = 
				{
					[1] = 0.23,
					[2] = 6.23,
				},
				[48] = 
				{
					[1] = 0.24,
					[2] = 6.35,
				},
				[49] = 
				{
					[1] = 0.24,
					[2] = 6.47,
				},
				[50] = 
				{
					[1] = 0.25,
					[2] = 6.59,
				},
				[51] = 
				{
					[1] = 0.26,
					[2] = 6.7,
				},
				[52] = 
				{
					[1] = 0.26,
					[2] = 6.82,
				},
				[53] = 
				{
					[1] = 0.27,
					[2] = 6.92,
				},
				[54] = 
				{
					[1] = 0.27,
					[2] = 6.99,
				},
				[55] = 
				{
					[1] = 0.28,
					[2] = 7.07,
				},
				[56] = 
				{
					[1] = 0.28,
					[2] = 7.14,
				},
				[57] = 
				{
					[1] = 0.29,
					[2] = 7.21,
				},
				[58] = 
				{
					[1] = 0.29,
					[2] = 7.29,
				},
				[59] = 
				{
					[1] = 0.3,
					[2] = 7.36,
				},
				[60] = 
				{
					[1] = 0.3,
					[2] = 7.44,
				},
				[61] = 
				{
					[1] = 0.31,
					[2] = 7.51,
				},
				[62] = 
				{
					[1] = 0.31,
					[2] = 7.58,
				},
				[63] = 
				{
					[1] = 0.32,
					[2] = 7.66,
				},
				[64] = 
				{
					[1] = 0.32,
					[2] = 7.73,
				},
				[65] = 
				{
					[1] = 0.33,
					[2] = 7.81,
				},
				[66] = 
				{
					[1] = 0.33,
					[2] = 7.88,
				},
				[67] = 
				{
					[1] = 0.34,
					[2] = 7.95,
				},
				[68] = 
				{
					[1] = 0.34,
					[2] = 8.03,
				},
				[69] = 
				{
					[1] = 0.35,
					[2] = 8.1,
				},
				[70] = 
				{
					[1] = 0.35,
					[2] = 8.17,
				},
				[71] = 
				{
					[1] = 0.36,
					[2] = 8.25,
				},
				[72] = 
				{
					[1] = 0.36,
					[2] = 8.32,
				},
				[73] = 
				{
					[1] = 0.37,
					[2] = 8.4,
				},
				[74] = 
				{
					[1] = 0.37,
					[2] = 8.46,
				},
				[75] = 
				{
					[1] = 0.38,
					[2] = 8.51,
				},
				[76] = 
				{
					[1] = 0.38,
					[2] = 8.57,
				},
				[77] = 
				{
					[1] = 0.39,
					[2] = 8.62,
				},
				[78] = 
				{
					[1] = 0.39,
					[2] = 8.68,
				},
				[79] = 
				{
					[1] = 0.4,
					[2] = 8.73,
				},
				[80] = 
				{
					[1] = 0.4,
					[2] = 8.78,
				},
				[81] = 
				{
					[1] = 0.41,
					[2] = 8.84,
				},
				[82] = 
				{
					[1] = 0.41,
					[2] = 8.89,
				},
				[83] = 
				{
					[1] = 0.42,
					[2] = 8.95,
				},
				[84] = 
				{
					[1] = 0.42,
					[2] = 9,
				},
				[85] = 
				{
					[1] = 0.43,
					[2] = 9.06,
				},
				[86] = 
				{
					[1] = 0.43,
					[2] = 9.11,
				},
				[87] = 
				{
					[1] = 0.44,
					[2] = 9.16,
				},
				[88] = 
				{
					[1] = 0.44,
					[2] = 9.22,
				},
				[89] = 
				{
					[1] = 0.45,
					[2] = 9.27,
				},
				[90] = 
				{
					[1] = 0.45,
					[2] = 9.33,
				},
				[91] = 
				{
					[1] = 0.46,
					[2] = 9.38,
				},
				[92] = 
				{
					[1] = 0.46,
					[2] = 9.43,
				},
				[93] = 
				{
					[1] = 0.47,
					[2] = 9.49,
				},
				[94] = 
				{
					[1] = 0.47,
					[2] = 9.54,
				},
				[95] = 
				{
					[1] = 0.48,
					[2] = 9.58,
				},
				[96] = 
				{
					[1] = 0.48,
					[2] = 9.59,
				},
				[97] = 
				{
					[1] = 0.49,
					[2] = 9.61,
				},
				[98] = 
				{
					[1] = 0.49,
					[2] = 9.62,
				},
				[99] = 
				{
					[1] = 0.5,
					[2] = 9.64,
				},
				[100] = 
				{
					[1] = 0.51,
					[2] = 9.65,
				},
				[101] = 
				{
					[1] = 0.51,
					[2] = 9.67,
				},
				[102] = 
				{
					[1] = 0.52,
					[2] = 9.68,
				},
				[103] = 
				{
					[1] = 0.52,
					[2] = 9.7,
				},
				[104] = 
				{
					[1] = 0.53,
					[2] = 9.71,
				},
				[105] = 
				{
					[1] = 0.53,
					[2] = 9.73,
				},
				[106] = 
				{
					[1] = 0.54,
					[2] = 9.74,
				},
				[107] = 
				{
					[1] = 0.54,
					[2] = 9.76,
				},
				[108] = 
				{
					[1] = 0.55,
					[2] = 9.77,
				},
				[109] = 
				{
					[1] = 0.55,
					[2] = 9.79,
				},
				[110] = 
				{
					[1] = 0.56,
					[2] = 9.8,
				},
				[111] = 
				{
					[1] = 0.56,
					[2] = 9.82,
				},
				[112] = 
				{
					[1] = 0.57,
					[2] = 9.83,
				},
				[113] = 
				{
					[1] = 0.57,
					[2] = 9.85,
				},
				[114] = 
				{
					[1] = 0.58,
					[2] = 9.86,
				},
				[115] = 
				{
					[1] = 0.58,
					[2] = 9.88,
				},
				[116] = 
				{
					[1] = 0.59,
					[2] = 9.87,
				},
				[117] = 
				{
					[1] = 0.59,
					[2] = 9.85,
				},
				[118] = 
				{
					[1] = 0.6,
					[2] = 9.82,
				},
				[119] = 
				{
					[1] = 0.6,
					[2] = 9.79,
				},
				[120] = 
				{
					[1] = 0.61,
					[2] = 9.77,
				},
				[121] = 
				{
					[1] = 0.61,
					[2] = 9.74,
				},
				[122] = 
				{
					[1] = 0.62,
					[2] = 9.71,
				},
				[123] = 
				{
					[1] = 0.62,
					[2] = 9.69,
				},
				[124] = 
				{
					[1] = 0.63,
					[2] = 9.66,
				},
				[125] = 
				{
					[1] = 0.63,
					[2] = 9.64,
				},
				[126] = 
				{
					[1] = 0.64,
					[2] = 9.61,
				},
				[127] = 
				{
					[1] = 0.64,
					[2] = 9.58,
				},
				[128] = 
				{
					[1] = 0.65,
					[2] = 9.56,
				},
				[129] = 
				{
					[1] = 0.65,
					[2] = 9.53,
				},
				[130] = 
				{
					[1] = 0.66,
					[2] = 9.5,
				},
				[131] = 
				{
					[1] = 0.66,
					[2] = 9.48,
				},
				[132] = 
				{
					[1] = 0.67,
					[2] = 9.45,
				},
				[133] = 
				{
					[1] = 0.67,
					[2] = 9.42,
				},
				[134] = 
				{
					[1] = 0.68,
					[2] = 9.4,
				},
				[135] = 
				{
					[1] = 0.68,
					[2] = 9.37,
				},
				[136] = 
				{
					[1] = 0.69,
					[2] = 9.35,
				},
				[137] = 
				{
					[1] = 0.69,
					[2] = 9.3,
				},
				[138] = 
				{
					[1] = 0.7,
					[2] = 9.25,
				},
				[139] = 
				{
					[1] = 0.7,
					[2] = 9.2,
				},
				[140] = 
				{
					[1] = 0.71,
					[2] = 9.14,
				},
				[141] = 
				{
					[1] = 0.71,
					[2] = 9.09,
				},
				[142] = 
				{
					[1] = 0.72,
					[2] = 9.04,
				},
				[143] = 
				{
					[1] = 0.72,
					[2] = 8.98,
				},
				[144] = 
				{
					[1] = 0.73,
					[2] = 8.93,
				},
				[145] = 
				{
					[1] = 0.73,
					[2] = 8.88,
				},
				[146] = 
				{
					[1] = 0.74,
					[2] = 8.83,
				},
				[147] = 
				{
					[1] = 0.74,
					[2] = 8.77,
				},
				[148] = 
				{
					[1] = 0.75,
					[2] = 8.72,
				},
				[149] = 
				{
					[1] = 0.76,
					[2] = 8.67,
				},
				[150] = 
				{
					[1] = 0.76,
					[2] = 8.61,
				},
				[151] = 
				{
					[1] = 0.77,
					[2] = 8.56,
				},
				[152] = 
				{
					[1] = 0.77,
					[2] = 8.51,
				},
				[153] = 
				{
					[1] = 0.78,
					[2] = 8.45,
				},
				[154] = 
				{
					[1] = 0.78,
					[2] = 8.4,
				},
				[155] = 
				{
					[1] = 0.79,
					[2] = 8.35,
				},
				[156] = 
				{
					[1] = 0.79,
					[2] = 8.29,
				},
				[157] = 
				{
					[1] = 0.8,
					[2] = 8.24,
				},
				[158] = 
				{
					[1] = 0.8,
					[2] = 8.16,
				},
				[159] = 
				{
					[1] = 0.81,
					[2] = 8.06,
				},
				[160] = 
				{
					[1] = 0.81,
					[2] = 7.96,
				},
				[161] = 
				{
					[1] = 0.82,
					[2] = 7.85,
				},
				[162] = 
				{
					[1] = 0.82,
					[2] = 7.75,
				},
				[163] = 
				{
					[1] = 0.83,
					[2] = 7.65,
				},
				[164] = 
				{
					[1] = 0.83,
					[2] = 7.54,
				},
				[165] = 
				{
					[1] = 0.84,
					[2] = 7.44,
				},
				[166] = 
				{
					[1] = 0.84,
					[2] = 7.34,
				},
				[167] = 
				{
					[1] = 0.85,
					[2] = 7.24,
				},
				[168] = 
				{
					[1] = 0.85,
					[2] = 7.14,
				},
				[169] = 
				{
					[1] = 0.86,
					[2] = 7.04,
				},
				[170] = 
				{
					[1] = 0.86,
					[2] = 6.94,
				},
				[171] = 
				{
					[1] = 0.87,
					[2] = 6.84,
				},
				[172] = 
				{
					[1] = 0.87,
					[2] = 6.75,
				},
				[173] = 
				{
					[1] = 0.88,
					[2] = 6.65,
				},
				[174] = 
				{
					[1] = 0.88,
					[2] = 6.55,
				},
				[175] = 
				{
					[1] = 0.89,
					[2] = 6.45,
				},
				[176] = 
				{
					[1] = 0.89,
					[2] = 6.31,
				},
				[177] = 
				{
					[1] = 0.9,
					[2] = 6.14,
				},
				[178] = 
				{
					[1] = 0.9,
					[2] = 5.98,
				},
				[179] = 
				{
					[1] = 0.91,
					[2] = 5.81,
				},
				[180] = 
				{
					[1] = 0.91,
					[2] = 5.65,
				},
				[181] = 
				{
					[1] = 0.92,
					[2] = 5.48,
				},
				[182] = 
				{
					[1] = 0.92,
					[2] = 5.32,
				},
				[183] = 
				{
					[1] = 0.93,
					[2] = 5.15,
				},
				[184] = 
				{
					[1] = 0.93,
					[2] = 4.99,
				},
				[185] = 
				{
					[1] = 0.94,
					[2] = 4.76,
				},
				[186] = 
				{
					[1] = 0.94,
					[2] = 4.51,
				},
				[187] = 
				{
					[1] = 0.95,
					[2] = 4.25,
				},
				[188] = 
				{
					[1] = 0.95,
					[2] = 4,
				},
				[189] = 
				{
					[1] = 0.96,
					[2] = 3.74,
				},
				[190] = 
				{
					[1] = 0.96,
					[2] = 3.49,
				},
				[191] = 
				{
					[1] = 0.97,
					[2] = 3.22,
				},
				[192] = 
				{
					[1] = 0.97,
					[2] = 2.9,
				},
				[193] = 
				{
					[1] = 0.98,
					[2] = 2.58,
				},
				[194] = 
				{
					[1] = 0.98,
					[2] = 2.25,
				},
				[195] = 
				{
					[1] = 0.99,
					[2] = 1.87,
				},
				[196] = 
				{
					[1] = 0.99,
					[2] = 1.44,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 5.55,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.02,
					[2] = 0.22,
				},
				[3] = 
				{
					[1] = 0.04,
					[2] = 0.3,
				},
				[4] = 
				{
					[1] = 0.06,
					[2] = 0.35,
				},
				[5] = 
				{
					[1] = 0.08,
					[2] = 0.39,
				},
				[6] = 
				{
					[1] = 0.1,
					[2] = 0.42,
				},
				[7] = 
				{
					[1] = 0.12,
					[2] = 0.45,
				},
				[8] = 
				{
					[1] = 0.14,
					[2] = 0.46,
				},
				[9] = 
				{
					[1] = 0.16,
					[2] = 0.48,
				},
				[10] = 
				{
					[1] = 0.18,
					[2] = 0.49,
				},
				[11] = 
				{
					[1] = 0.2,
					[2] = 0.49,
				},
				[12] = 
				{
					[1] = 0.22,
					[2] = 0.5,
				},
				[13] = 
				{
					[1] = 0.24,
					[2] = 0.5,
				},
				[14] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[15] = 
				{
					[1] = 0.29,
					[2] = 0.5,
				},
				[16] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[17] = 
				{
					[1] = 0.33,
					[2] = 0.49,
				},
				[18] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[19] = 
				{
					[1] = 0.37,
					[2] = 0.47,
				},
				[20] = 
				{
					[1] = 0.39,
					[2] = 0.46,
				},
				[21] = 
				{
					[1] = 0.41,
					[2] = 0.45,
				},
				[22] = 
				{
					[1] = 0.43,
					[2] = 0.44,
				},
				[23] = 
				{
					[1] = 0.45,
					[2] = 0.43,
				},
				[24] = 
				{
					[1] = 0.47,
					[2] = 0.42,
				},
				[25] = 
				{
					[1] = 0.49,
					[2] = 0.4,
				},
				[26] = 
				{
					[1] = 0.51,
					[2] = 0.39,
				},
				[27] = 
				{
					[1] = 0.53,
					[2] = 0.38,
				},
				[28] = 
				{
					[1] = 0.55,
					[2] = 0.36,
				},
				[29] = 
				{
					[1] = 0.57,
					[2] = 0.35,
				},
				[30] = 
				{
					[1] = 0.59,
					[2] = 0.33,
				},
				[31] = 
				{
					[1] = 0.61,
					[2] = 0.32,
				},
				[32] = 
				{
					[1] = 0.63,
					[2] = 0.3,
				},
				[33] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[34] = 
				{
					[1] = 0.67,
					[2] = 0.27,
				},
				[35] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[36] = 
				{
					[1] = 0.71,
					[2] = 0.23,
				},
				[37] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[38] = 
				{
					[1] = 0.76,
					[2] = 0.2,
				},
				[39] = 
				{
					[1] = 0.78,
					[2] = 0.18,
				},
				[40] = 
				{
					[1] = 0.8,
					[2] = 0.17,
				},
				[41] = 
				{
					[1] = 0.82,
					[2] = 0.15,
				},
				[42] = 
				{
					[1] = 0.84,
					[2] = 0.13,
				},
				[43] = 
				{
					[1] = 0.86,
					[2] = 0.12,
				},
				[44] = 
				{
					[1] = 0.88,
					[2] = 0.1,
				},
				[45] = 
				{
					[1] = 0.9,
					[2] = 0.08,
				},
				[46] = 
				{
					[1] = 0.92,
					[2] = 0.07,
				},
				[47] = 
				{
					[1] = 0.94,
					[2] = 0.05,
				},
				[48] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
				[49] = 
				{
					[1] = 0.98,
					[2] = 0.02,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12.46,
			["LocalSpace"] = true,
			["MaxSpeed"] = 12.861,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0,
					[2] = 0.31,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 0.37,
				},
				[4] = 
				{
					[1] = 0.01,
					[2] = 0.44,
				},
				[5] = 
				{
					[1] = 0.01,
					[2] = 0.51,
				},
				[6] = 
				{
					[1] = 0.02,
					[2] = 0.58,
				},
				[7] = 
				{
					[1] = 0.02,
					[2] = 0.64,
				},
				[8] = 
				{
					[1] = 0.02,
					[2] = 0.71,
				},
				[9] = 
				{
					[1] = 0.03,
					[2] = 0.77,
				},
				[10] = 
				{
					[1] = 0.03,
					[2] = 0.84,
				},
				[11] = 
				{
					[1] = 0.03,
					[2] = 0.91,
				},
				[12] = 
				{
					[1] = 0.04,
					[2] = 0.97,
				},
				[13] = 
				{
					[1] = 0.04,
					[2] = 1.04,
				},
				[14] = 
				{
					[1] = 0.04,
					[2] = 1.1,
				},
				[15] = 
				{
					[1] = 0.05,
					[2] = 1.17,
				},
				[16] = 
				{
					[1] = 0.05,
					[2] = 1.23,
				},
				[17] = 
				{
					[1] = 0.05,
					[2] = 1.3,
				},
				[18] = 
				{
					[1] = 0.06,
					[2] = 1.36,
				},
				[19] = 
				{
					[1] = 0.06,
					[2] = 1.42,
				},
				[20] = 
				{
					[1] = 0.06,
					[2] = 1.49,
				},
				[21] = 
				{
					[1] = 0.07,
					[2] = 1.55,
				},
				[22] = 
				{
					[1] = 0.07,
					[2] = 1.61,
				},
				[23] = 
				{
					[1] = 0.07,
					[2] = 1.68,
				},
				[24] = 
				{
					[1] = 0.08,
					[2] = 1.74,
				},
				[25] = 
				{
					[1] = 0.08,
					[2] = 1.8,
				},
				[26] = 
				{
					[1] = 0.09,
					[2] = 1.86,
				},
				[27] = 
				{
					[1] = 0.09,
					[2] = 1.93,
				},
				[28] = 
				{
					[1] = 0.09,
					[2] = 1.99,
				},
				[29] = 
				{
					[1] = 0.1,
					[2] = 2.04,
				},
				[30] = 
				{
					[1] = 0.1,
					[2] = 2.07,
				},
				[31] = 
				{
					[1] = 0.1,
					[2] = 2.1,
				},
				[32] = 
				{
					[1] = 0.11,
					[2] = 2.13,
				},
				[33] = 
				{
					[1] = 0.11,
					[2] = 2.16,
				},
				[34] = 
				{
					[1] = 0.11,
					[2] = 2.19,
				},
				[35] = 
				{
					[1] = 0.12,
					[2] = 2.22,
				},
				[36] = 
				{
					[1] = 0.12,
					[2] = 2.25,
				},
				[37] = 
				{
					[1] = 0.12,
					[2] = 2.28,
				},
				[38] = 
				{
					[1] = 0.13,
					[2] = 2.31,
				},
				[39] = 
				{
					[1] = 0.13,
					[2] = 2.34,
				},
				[40] = 
				{
					[1] = 0.13,
					[2] = 2.37,
				},
				[41] = 
				{
					[1] = 0.14,
					[2] = 2.4,
				},
				[42] = 
				{
					[1] = 0.14,
					[2] = 2.43,
				},
				[43] = 
				{
					[1] = 0.14,
					[2] = 2.46,
				},
				[44] = 
				{
					[1] = 0.15,
					[2] = 2.49,
				},
				[45] = 
				{
					[1] = 0.15,
					[2] = 2.51,
				},
				[46] = 
				{
					[1] = 0.15,
					[2] = 2.54,
				},
				[47] = 
				{
					[1] = 0.16,
					[2] = 2.57,
				},
				[48] = 
				{
					[1] = 0.16,
					[2] = 2.6,
				},
				[49] = 
				{
					[1] = 0.16,
					[2] = 2.63,
				},
				[50] = 
				{
					[1] = 0.17,
					[2] = 2.66,
				},
				[51] = 
				{
					[1] = 0.17,
					[2] = 2.68,
				},
				[52] = 
				{
					[1] = 0.17,
					[2] = 2.71,
				},
				[53] = 
				{
					[1] = 0.18,
					[2] = 2.74,
				},
				[54] = 
				{
					[1] = 0.18,
					[2] = 2.77,
				},
				[55] = 
				{
					[1] = 0.18,
					[2] = 2.79,
				},
				[56] = 
				{
					[1] = 0.19,
					[2] = 2.82,
				},
				[57] = 
				{
					[1] = 0.19,
					[2] = 2.85,
				},
				[58] = 
				{
					[1] = 0.19,
					[2] = 2.87,
				},
				[59] = 
				{
					[1] = 0.2,
					[2] = 2.9,
				},
				[60] = 
				{
					[1] = 0.2,
					[2] = 2.93,
				},
				[61] = 
				{
					[1] = 0.2,
					[2] = 2.95,
				},
				[62] = 
				{
					[1] = 0.21,
					[2] = 2.98,
				},
				[63] = 
				{
					[1] = 0.21,
					[2] = 3.01,
				},
				[64] = 
				{
					[1] = 0.21,
					[2] = 3.03,
				},
				[65] = 
				{
					[1] = 0.22,
					[2] = 3.06,
				},
				[66] = 
				{
					[1] = 0.22,
					[2] = 3.09,
				},
				[67] = 
				{
					[1] = 0.22,
					[2] = 3.11,
				},
				[68] = 
				{
					[1] = 0.23,
					[2] = 3.14,
				},
				[69] = 
				{
					[1] = 0.23,
					[2] = 3.16,
				},
				[70] = 
				{
					[1] = 0.23,
					[2] = 3.17,
				},
				[71] = 
				{
					[1] = 0.24,
					[2] = 3.19,
				},
				[72] = 
				{
					[1] = 0.24,
					[2] = 3.21,
				},
				[73] = 
				{
					[1] = 0.24,
					[2] = 3.22,
				},
				[74] = 
				{
					[1] = 0.25,
					[2] = 3.24,
				},
				[75] = 
				{
					[1] = 0.25,
					[2] = 3.26,
				},
				[76] = 
				{
					[1] = 0.26,
					[2] = 3.27,
				},
				[77] = 
				{
					[1] = 0.26,
					[2] = 3.29,
				},
				[78] = 
				{
					[1] = 0.26,
					[2] = 3.3,
				},
				[79] = 
				{
					[1] = 0.27,
					[2] = 3.32,
				},
				[80] = 
				{
					[1] = 0.27,
					[2] = 3.34,
				},
				[81] = 
				{
					[1] = 0.27,
					[2] = 3.35,
				},
				[82] = 
				{
					[1] = 0.28,
					[2] = 3.37,
				},
				[83] = 
				{
					[1] = 0.28,
					[2] = 3.38,
				},
				[84] = 
				{
					[1] = 0.28,
					[2] = 3.4,
				},
				[85] = 
				{
					[1] = 0.29,
					[2] = 3.41,
				},
				[86] = 
				{
					[1] = 0.29,
					[2] = 3.43,
				},
				[87] = 
				{
					[1] = 0.29,
					[2] = 3.45,
				},
				[88] = 
				{
					[1] = 0.3,
					[2] = 3.46,
				},
				[89] = 
				{
					[1] = 0.3,
					[2] = 3.48,
				},
				[90] = 
				{
					[1] = 0.3,
					[2] = 3.49,
				},
				[91] = 
				{
					[1] = 0.31,
					[2] = 3.51,
				},
				[92] = 
				{
					[1] = 0.31,
					[2] = 3.52,
				},
				[93] = 
				{
					[1] = 0.31,
					[2] = 3.54,
				},
				[94] = 
				{
					[1] = 0.32,
					[2] = 3.55,
				},
				[95] = 
				{
					[1] = 0.32,
					[2] = 3.56,
				},
				[96] = 
				{
					[1] = 0.32,
					[2] = 3.58,
				},
				[97] = 
				{
					[1] = 0.33,
					[2] = 3.59,
				},
				[98] = 
				{
					[1] = 0.33,
					[2] = 3.61,
				},
				[99] = 
				{
					[1] = 0.33,
					[2] = 3.62,
				},
				[100] = 
				{
					[1] = 0.34,
					[2] = 3.64,
				},
				[101] = 
				{
					[1] = 0.34,
					[2] = 3.65,
				},
				[102] = 
				{
					[1] = 0.34,
					[2] = 3.66,
				},
				[103] = 
				{
					[1] = 0.35,
					[2] = 3.68,
				},
				[104] = 
				{
					[1] = 0.35,
					[2] = 3.69,
				},
				[105] = 
				{
					[1] = 0.35,
					[2] = 3.71,
				},
				[106] = 
				{
					[1] = 0.36,
					[2] = 3.72,
				},
				[107] = 
				{
					[1] = 0.36,
					[2] = 3.73,
				},
				[108] = 
				{
					[1] = 0.36,
					[2] = 3.75,
				},
				[109] = 
				{
					[1] = 0.37,
					[2] = 3.76,
				},
				[110] = 
				{
					[1] = 0.37,
					[2] = 3.77,
				},
				[111] = 
				{
					[1] = 0.37,
					[2] = 3.79,
				},
				[112] = 
				{
					[1] = 0.38,
					[2] = 3.8,
				},
				[113] = 
				{
					[1] = 0.38,
					[2] = 3.81,
				},
				[114] = 
				{
					[1] = 0.38,
					[2] = 3.82,
				},
				[115] = 
				{
					[1] = 0.39,
					[2] = 3.84,
				},
				[116] = 
				{
					[1] = 0.39,
					[2] = 3.85,
				},
				[117] = 
				{
					[1] = 0.39,
					[2] = 3.86,
				},
				[118] = 
				{
					[1] = 0.4,
					[2] = 3.88,
				},
				[119] = 
				{
					[1] = 0.4,
					[2] = 3.89,
				},
				[120] = 
				{
					[1] = 0.4,
					[2] = 3.9,
				},
				[121] = 
				{
					[1] = 0.41,
					[2] = 3.91,
				},
				[122] = 
				{
					[1] = 0.41,
					[2] = 3.93,
				},
				[123] = 
				{
					[1] = 0.41,
					[2] = 3.94,
				},
				[124] = 
				{
					[1] = 0.42,
					[2] = 3.95,
				},
				[125] = 
				{
					[1] = 0.42,
					[2] = 3.96,
				},
				[126] = 
				{
					[1] = 0.43,
					[2] = 3.97,
				},
				[127] = 
				{
					[1] = 0.43,
					[2] = 3.98,
				},
				[128] = 
				{
					[1] = 0.43,
					[2] = 4,
				},
				[129] = 
				{
					[1] = 0.44,
					[2] = 4.01,
				},
				[130] = 
				{
					[1] = 0.44,
					[2] = 4.02,
				},
				[131] = 
				{
					[1] = 0.44,
					[2] = 4.03,
				},
				[132] = 
				{
					[1] = 0.45,
					[2] = 4.04,
				},
				[133] = 
				{
					[1] = 0.45,
					[2] = 4.05,
				},
				[134] = 
				{
					[1] = 0.45,
					[2] = 4.06,
				},
				[135] = 
				{
					[1] = 0.46,
					[2] = 4.08,
				},
				[136] = 
				{
					[1] = 0.46,
					[2] = 4.09,
				},
				[137] = 
				{
					[1] = 0.46,
					[2] = 4.1,
				},
				[138] = 
				{
					[1] = 0.47,
					[2] = 4.11,
				},
				[139] = 
				{
					[1] = 0.47,
					[2] = 4.12,
				},
				[140] = 
				{
					[1] = 0.47,
					[2] = 4.13,
				},
				[141] = 
				{
					[1] = 0.48,
					[2] = 4.14,
				},
				[142] = 
				{
					[1] = 0.48,
					[2] = 4.15,
				},
				[143] = 
				{
					[1] = 0.48,
					[2] = 4.16,
				},
				[144] = 
				{
					[1] = 0.49,
					[2] = 4.17,
				},
				[145] = 
				{
					[1] = 0.49,
					[2] = 4.18,
				},
				[146] = 
				{
					[1] = 0.49,
					[2] = 4.19,
				},
				[147] = 
				{
					[1] = 0.5,
					[2] = 4.2,
				},
				[148] = 
				{
					[1] = 0.5,
					[2] = 4.21,
				},
				[149] = 
				{
					[1] = 0.5,
					[2] = 4.22,
				},
				[150] = 
				{
					[1] = 0.51,
					[2] = 4.23,
				},
				[151] = 
				{
					[1] = 0.51,
					[2] = 4.24,
				},
				[152] = 
				{
					[1] = 0.51,
					[2] = 4.25,
				},
				[153] = 
				{
					[1] = 0.52,
					[2] = 4.26,
				},
				[154] = 
				{
					[1] = 0.52,
					[2] = 4.27,
				},
				[155] = 
				{
					[1] = 0.52,
					[2] = 4.28,
				},
				[156] = 
				{
					[1] = 0.53,
					[2] = 4.29,
				},
				[157] = 
				{
					[1] = 0.53,
					[2] = 4.3,
				},
				[158] = 
				{
					[1] = 0.53,
					[2] = 4.31,
				},
				[159] = 
				{
					[1] = 0.54,
					[2] = 4.32,
				},
				[160] = 
				{
					[1] = 0.54,
					[2] = 4.32,
				},
				[161] = 
				{
					[1] = 0.54,
					[2] = 4.33,
				},
				[162] = 
				{
					[1] = 0.55,
					[2] = 4.34,
				},
				[163] = 
				{
					[1] = 0.55,
					[2] = 4.35,
				},
				[164] = 
				{
					[1] = 0.55,
					[2] = 4.36,
				},
				[165] = 
				{
					[1] = 0.56,
					[2] = 4.37,
				},
				[166] = 
				{
					[1] = 0.56,
					[2] = 4.38,
				},
				[167] = 
				{
					[1] = 0.56,
					[2] = 4.38,
				},
				[168] = 
				{
					[1] = 0.57,
					[2] = 4.39,
				},
				[169] = 
				{
					[1] = 0.57,
					[2] = 4.4,
				},
				[170] = 
				{
					[1] = 0.57,
					[2] = 4.41,
				},
				[171] = 
				{
					[1] = 0.58,
					[2] = 4.42,
				},
				[172] = 
				{
					[1] = 0.58,
					[2] = 4.42,
				},
				[173] = 
				{
					[1] = 0.59,
					[2] = 4.43,
				},
				[174] = 
				{
					[1] = 0.59,
					[2] = 4.44,
				},
				[175] = 
				{
					[1] = 0.59,
					[2] = 4.45,
				},
				[176] = 
				{
					[1] = 0.6,
					[2] = 4.45,
				},
				[177] = 
				{
					[1] = 0.6,
					[2] = 4.46,
				},
				[178] = 
				{
					[1] = 0.6,
					[2] = 4.47,
				},
				[179] = 
				{
					[1] = 0.61,
					[2] = 4.48,
				},
				[180] = 
				{
					[1] = 0.61,
					[2] = 4.48,
				},
				[181] = 
				{
					[1] = 0.61,
					[2] = 4.49,
				},
				[182] = 
				{
					[1] = 0.62,
					[2] = 4.5,
				},
				[183] = 
				{
					[1] = 0.62,
					[2] = 4.5,
				},
				[184] = 
				{
					[1] = 0.62,
					[2] = 4.51,
				},
				[185] = 
				{
					[1] = 0.63,
					[2] = 4.52,
				},
				[186] = 
				{
					[1] = 0.63,
					[2] = 4.52,
				},
				[187] = 
				{
					[1] = 0.63,
					[2] = 4.53,
				},
				[188] = 
				{
					[1] = 0.64,
					[2] = 4.54,
				},
				[189] = 
				{
					[1] = 0.64,
					[2] = 4.54,
				},
				[190] = 
				{
					[1] = 0.64,
					[2] = 4.55,
				},
				[191] = 
				{
					[1] = 0.65,
					[2] = 4.56,
				},
				[192] = 
				{
					[1] = 0.65,
					[2] = 4.56,
				},
				[193] = 
				{
					[1] = 0.65,
					[2] = 4.57,
				},
				[194] = 
				{
					[1] = 0.66,
					[2] = 4.57,
				},
				[195] = 
				{
					[1] = 0.66,
					[2] = 4.57,
				},
				[196] = 
				{
					[1] = 0.66,
					[2] = 4.57,
				},
				[197] = 
				{
					[1] = 0.67,
					[2] = 4.57,
				},
				[198] = 
				{
					[1] = 0.67,
					[2] = 4.57,
				},
				[199] = 
				{
					[1] = 0.67,
					[2] = 4.57,
				},
				[200] = 
				{
					[1] = 0.68,
					[2] = 4.57,
				},
				[201] = 
				{
					[1] = 0.68,
					[2] = 4.58,
				},
				[202] = 
				{
					[1] = 0.68,
					[2] = 4.58,
				},
				[203] = 
				{
					[1] = 0.69,
					[2] = 4.58,
				},
				[204] = 
				{
					[1] = 0.69,
					[2] = 4.58,
				},
				[205] = 
				{
					[1] = 0.69,
					[2] = 4.58,
				},
				[206] = 
				{
					[1] = 0.7,
					[2] = 4.58,
				},
				[207] = 
				{
					[1] = 0.7,
					[2] = 4.58,
				},
				[208] = 
				{
					[1] = 0.7,
					[2] = 4.58,
				},
				[209] = 
				{
					[1] = 0.71,
					[2] = 4.58,
				},
				[210] = 
				{
					[1] = 0.71,
					[2] = 4.58,
				},
				[211] = 
				{
					[1] = 0.71,
					[2] = 4.58,
				},
				[212] = 
				{
					[1] = 0.72,
					[2] = 4.58,
				},
				[213] = 
				{
					[1] = 0.72,
					[2] = 4.58,
				},
				[214] = 
				{
					[1] = 0.72,
					[2] = 4.58,
				},
				[215] = 
				{
					[1] = 0.73,
					[2] = 4.58,
				},
				[216] = 
				{
					[1] = 0.73,
					[2] = 4.58,
				},
				[217] = 
				{
					[1] = 0.73,
					[2] = 4.58,
				},
				[218] = 
				{
					[1] = 0.74,
					[2] = 4.58,
				},
				[219] = 
				{
					[1] = 0.74,
					[2] = 4.58,
				},
				[220] = 
				{
					[1] = 0.74,
					[2] = 4.58,
				},
				[221] = 
				{
					[1] = 0.75,
					[2] = 4.57,
				},
				[222] = 
				{
					[1] = 0.75,
					[2] = 4.57,
				},
				[223] = 
				{
					[1] = 0.76,
					[2] = 4.57,
				},
				[224] = 
				{
					[1] = 0.76,
					[2] = 4.57,
				},
				[225] = 
				{
					[1] = 0.76,
					[2] = 4.57,
				},
				[226] = 
				{
					[1] = 0.77,
					[2] = 4.57,
				},
				[227] = 
				{
					[1] = 0.77,
					[2] = 4.57,
				},
				[228] = 
				{
					[1] = 0.77,
					[2] = 4.57,
				},
				[229] = 
				{
					[1] = 0.78,
					[2] = 4.57,
				},
				[230] = 
				{
					[1] = 0.78,
					[2] = 4.57,
				},
				[231] = 
				{
					[1] = 0.78,
					[2] = 4.56,
				},
				[232] = 
				{
					[1] = 0.79,
					[2] = 4.56,
				},
				[233] = 
				{
					[1] = 0.79,
					[2] = 4.56,
				},
				[234] = 
				{
					[1] = 0.79,
					[2] = 4.56,
				},
				[235] = 
				{
					[1] = 0.8,
					[2] = 4.56,
				},
				[236] = 
				{
					[1] = 0.8,
					[2] = 4.56,
				},
				[237] = 
				{
					[1] = 0.8,
					[2] = 4.56,
				},
				[238] = 
				{
					[1] = 0.81,
					[2] = 4.55,
				},
				[239] = 
				{
					[1] = 0.81,
					[2] = 4.55,
				},
				[240] = 
				{
					[1] = 0.81,
					[2] = 4.55,
				},
				[241] = 
				{
					[1] = 0.82,
					[2] = 4.55,
				},
				[242] = 
				{
					[1] = 0.82,
					[2] = 4.55,
				},
				[243] = 
				{
					[1] = 0.82,
					[2] = 4.54,
				},
				[244] = 
				{
					[1] = 0.83,
					[2] = 4.54,
				},
				[245] = 
				{
					[1] = 0.83,
					[2] = 4.54,
				},
				[246] = 
				{
					[1] = 0.83,
					[2] = 4.54,
				},
				[247] = 
				{
					[1] = 0.84,
					[2] = 4.54,
				},
				[248] = 
				{
					[1] = 0.84,
					[2] = 4.53,
				},
				[249] = 
				{
					[1] = 0.84,
					[2] = 4.53,
				},
				[250] = 
				{
					[1] = 0.85,
					[2] = 4.53,
				},
				[251] = 
				{
					[1] = 0.85,
					[2] = 4.53,
				},
				[252] = 
				{
					[1] = 0.85,
					[2] = 4.52,
				},
				[253] = 
				{
					[1] = 0.86,
					[2] = 4.52,
				},
				[254] = 
				{
					[1] = 0.86,
					[2] = 4.52,
				},
				[255] = 
				{
					[1] = 0.86,
					[2] = 4.51,
				},
				[256] = 
				{
					[1] = 0.87,
					[2] = 4.51,
				},
				[257] = 
				{
					[1] = 0.87,
					[2] = 4.51,
				},
				[258] = 
				{
					[1] = 0.87,
					[2] = 4.51,
				},
				[259] = 
				{
					[1] = 0.88,
					[2] = 4.5,
				},
				[260] = 
				{
					[1] = 0.88,
					[2] = 4.5,
				},
				[261] = 
				{
					[1] = 0.88,
					[2] = 4.5,
				},
				[262] = 
				{
					[1] = 0.89,
					[2] = 4.49,
				},
				[263] = 
				{
					[1] = 0.89,
					[2] = 4.49,
				},
				[264] = 
				{
					[1] = 0.89,
					[2] = 4.49,
				},
				[265] = 
				{
					[1] = 0.9,
					[2] = 4.48,
				},
				[266] = 
				{
					[1] = 0.9,
					[2] = 4.48,
				},
				[267] = 
				{
					[1] = 0.9,
					[2] = 4.48,
				},
				[268] = 
				{
					[1] = 0.91,
					[2] = 4.47,
				},
				[269] = 
				{
					[1] = 0.91,
					[2] = 4.47,
				},
				[270] = 
				{
					[1] = 0.91,
					[2] = 4.46,
				},
				[271] = 
				{
					[1] = 0.92,
					[2] = 4.46,
				},
				[272] = 
				{
					[1] = 0.92,
					[2] = 4.46,
				},
				[273] = 
				{
					[1] = 0.93,
					[2] = 4.45,
				},
				[274] = 
				{
					[1] = 0.93,
					[2] = 4.45,
				},
				[275] = 
				{
					[1] = 0.93,
					[2] = 4.45,
				},
				[276] = 
				{
					[1] = 0.94,
					[2] = 4.44,
				},
				[277] = 
				{
					[1] = 0.94,
					[2] = 4.44,
				},
				[278] = 
				{
					[1] = 0.94,
					[2] = 4.43,
				},
				[279] = 
				{
					[1] = 0.95,
					[2] = 4.43,
				},
				[280] = 
				{
					[1] = 0.95,
					[2] = 4.42,
				},
				[281] = 
				{
					[1] = 0.95,
					[2] = 4.42,
				},
				[282] = 
				{
					[1] = 0.96,
					[2] = 4.41,
				},
				[283] = 
				{
					[1] = 0.96,
					[2] = 4.41,
				},
				[284] = 
				{
					[1] = 0.96,
					[2] = 4.41,
				},
				[285] = 
				{
					[1] = 0.97,
					[2] = 4.4,
				},
				[286] = 
				{
					[1] = 0.97,
					[2] = 4.4,
				},
				[287] = 
				{
					[1] = 0.97,
					[2] = 4.39,
				},
				[288] = 
				{
					[1] = 0.98,
					[2] = 4.39,
				},
				[289] = 
				{
					[1] = 0.98,
					[2] = 4.38,
				},
				[290] = 
				{
					[1] = 0.98,
					[2] = 4.38,
				},
				[291] = 
				{
					[1] = 0.99,
					[2] = 4.37,
				},
				[292] = 
				{
					[1] = 0.99,
					[2] = 4.37,
				},
				[293] = 
				{
					[1] = 0.99,
					[2] = 4.36,
				},
				[294] = 
				{
					[1] = 1,
					[2] = 4.36,
				},
			},
			["WidthScale"] = 0.9,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_mogami",
		["Type"] = "WaterTracer",
	},
	[256] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 255.290848,
			["Lifetime"] = 19.85,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0251,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.65,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 333.871552,
			["Lifetime"] = 25.959999,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0313,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 2.93,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 58.903381,
			["Lifetime"] = 4.58,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.0313,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 6.76,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_mogami",
		["Type"] = "WaterTracer",
	},
	[257] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 9.9,
			["LocalSpace"] = true,
			["MaxSpeed"] = 30.8664,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.5051,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.1,
					[2] = 0.5,
				},
				[3] = 
				{
					[1] = 0.2,
					[2] = 0.75,
				},
				[4] = 
				{
					[1] = 0.3,
					[2] = 0.96,
				},
				[5] = 
				{
					[1] = 0.4,
					[2] = 1.06,
				},
				[6] = 
				{
					[1] = 0.5,
					[2] = 1.15,
				},
				[7] = 
				{
					[1] = 0.6,
					[2] = 1.17,
				},
				[8] = 
				{
					[1] = 0.7,
					[2] = 1.19,
				},
				[9] = 
				{
					[1] = 0.8,
					[2] = 1.2,
				},
				[10] = 
				{
					[1] = 0.9,
					[2] = 1.21,
				},
			},
			["WidthScale"] = 1.65,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 0.33,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 1.49,
			["LocalSpace"] = true,
			["MaxSpeed"] = 30.8664,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.07,
					[2] = 0.18,
				},
				[3] = 
				{
					[1] = 0.13,
					[2] = 0.3,
				},
				[4] = 
				{
					[1] = 0.2,
					[2] = 0.4,
				},
				[5] = 
				{
					[1] = 0.27,
					[2] = 0.48,
				},
				[6] = 
				{
					[1] = 0.33,
					[2] = 0.56,
				},
				[7] = 
				{
					[1] = 0.4,
					[2] = 0.59,
				},
				[8] = 
				{
					[1] = 0.47,
					[2] = 0.61,
				},
				[9] = 
				{
					[1] = 0.53,
					[2] = 0.63,
				},
				[10] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[11] = 
				{
					[1] = 0.67,
					[2] = 0.66,
				},
				[12] = 
				{
					[1] = 0.73,
					[2] = 0.67,
				},
				[13] = 
				{
					[1] = 0.8,
					[2] = 0.68,
				},
				[14] = 
				{
					[1] = 0.87,
					[2] = 0.68,
				},
				[15] = 
				{
					[1] = 0.93,
					[2] = 0.66,
				},
			},
			["WidthScale"] = 1.2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "BowWave_motorcsonak",
		["Type"] = "WaterTracer",
	},
	[258] = 
	{
		[1] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 12.963888,
			["Lifetime"] = 0.42,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1387,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.2,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 16.976521,
			["Lifetime"] = 0.55,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.1734,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 0.53,
			["WidthScaler"] = 2,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[3] = 
		{
			["AlphaScale"] = 3,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 3.08664,
			["Lifetime"] = 0.1,
			["LocalSpace"] = false,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew03.dds",
			["TextureRate"] = 0.1734,
			["Type"] = "WaterTracer",
			["WidthOffset"] = 0,
			["WidthScale"] = 1.22,
			["WidthScaler"] = 3,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		["Comment"] = "testreszabott hajo watertracer",
		["Name"] = "SternWave_motorcsonak",
		["Type"] = "WaterTracer",
	},
	[259] = 
	{
		[1] = 
		{
			["AlphaScale"] = 2,
			["AlphaScaler"] = 0.95,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = true,
			["Length"] = 107.800003,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew01.dds",
			["TextureRate"] = 0.0464,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.74,
				},
				[3] = 
				{
					[1] = 0.02,
					[2] = 0.85,
				},
				[4] = 
				{
					[1] = 0.03,
					[2] = 0.97,
				},
				[5] = 
				{
					[1] = 0.04,
					[2] = 1.08,
				},
				[6] = 
				{
					[1] = 0.05,
					[2] = 1.18,
				},
				[7] = 
				{
					[1] = 0.06,
					[2] = 1.27,
				},
				[8] = 
				{
					[1] = 0.07,
					[2] = 1.36,
				},
				[9] = 
				{
					[1] = 0.07,
					[2] = 1.44,
				},
				[10] = 
				{
					[1] = 0.08,
					[2] = 1.52,
				},
				[11] = 
				{
					[1] = 0.09,
					[2] = 1.65,
				},
				[12] = 
				{
					[1] = 0.1,
					[2] = 1.77,
				},
				[13] = 
				{
					[1] = 0.11,
					[2] = 1.89,
				},
				[14] = 
				{
					[1] = 0.12,
					[2] = 2.02,
				},
				[15] = 
				{
					[1] = 0.13,
					[2] = 2.14,
				},
				[16] = 
				{
					[1] = 0.14,
					[2] = 2.26,
				},
				[17] = 
				{
					[1] = 0.15,
					[2] = 2.37,
				},
				[18] = 
				{
					[1] = 0.16,
					[2] = 2.48,
				},
				[19] = 
				{
					[1] = 0.17,
					[2] = 2.59,
				},
				[20] = 
				{
					[1] = 0.18,
					[2] = 2.7,
				},
				[21] = 
				{
					[1] = 0.19,
					[2] = 2.81,
				},
				[22] = 
				{
					[1] = 0.2,
					[2] = 2.9,
				},
				[23] = 
				{
					[1] = 0.21,
					[2] = 2.99,
				},
				[24] = 
				{
					[1] = 0.21,
					[2] = 3.08,
				},
				[25] = 
				{
					[1] = 0.22,
					[2] = 3.16,
				},
				[26] = 
				{
					[1] = 0.23,
					[2] = 3.25,
				},
				[27] = 
				{
					[1] = 0.24,
					[2] = 3.33,
				},
				[28] = 
				{
					[1] = 0.25,
					[2] = 3.41,
				},
				[29] = 
				{
					[1] = 0.26,
					[2] = 3.49,
				},
				[30] = 
				{
					[1] = 0.27,
					[2] = 3.56,
				},
				[31] = 
				{
					[1] = 0.28,
					[2] = 3.64,
				},
				[32] = 
				{
					[1] = 0.29,
					[2] = 3.71,
				},
				[33] = 
				{
					[1] = 0.3,
					[2] = 3.78,
				},
				[34] = 
				{
					[1] = 0.31,
					[2] = 3.84,
				},
				[35] = 
				{
					[1] = 0.32,
					[2] = 3.91,
				},
				[36] = 
				{
					[1] = 0.33,
					[2] = 3.98,
				},
				[37] = 
				{
					[1] = 0.34,
					[2] = 4.04,
				},
				[38] = 
				{
					[1] = 0.35,
					[2] = 4.11,
				},
				[39] = 
				{
					[1] = 0.36,
					[2] = 4.16,
				},
				[40] = 
				{
					[1] = 0.36,
					[2] = 4.22,
				},
				[41] = 
				{
					[1] = 0.37,
					[2] = 4.28,
				},
				[42] = 
				{
					[1] = 0.38,
					[2] = 4.34,
				},
				[43] = 
				{
					[1] = 0.39,
					[2] = 4.39,
				},
				[44] = 
				{
					[1] = 0.4,
					[2] = 4.45,
				},
				[45] = 
				{
					[1] = 0.41,
					[2] = 4.5,
				},
				[46] = 
				{
					[1] = 0.42,
					[2] = 4.54,
				},
				[47] = 
				{
					[1] = 0.43,
					[2] = 4.59,
				},
				[48] = 
				{
					[1] = 0.44,
					[2] = 4.64,
				},
				[49] = 
				{
					[1] = 0.45,
					[2] = 4.69,
				},
				[50] = 
				{
					[1] = 0.46,
					[2] = 4.73,
				},
				[51] = 
				{
					[1] = 0.47,
					[2] = 4.77,
				},
				[52] = 
				{
					[1] = 0.48,
					[2] = 4.8,
				},
				[53] = 
				{
					[1] = 0.49,
					[2] = 4.84,
				},
				[54] = 
				{
					[1] = 0.5,
					[2] = 4.87,
				},
				[55] = 
				{
					[1] = 0.5,
					[2] = 4.9,
				},
				[56] = 
				{
					[1] = 0.51,
					[2] = 4.92,
				},
				[57] = 
				{
					[1] = 0.52,
					[2] = 4.93,
				},
				[58] = 
				{
					[1] = 0.53,
					[2] = 4.95,
				},
				[59] = 
				{
					[1] = 0.54,
					[2] = 4.96,
				},
				[60] = 
				{
					[1] = 0.55,
					[2] = 4.98,
				},
				[61] = 
				{
					[1] = 0.56,
					[2] = 4.98,
				},
				[62] = 
				{
					[1] = 0.57,
					[2] = 4.97,
				},
				[63] = 
				{
					[1] = 0.58,
					[2] = 4.96,
				},
				[64] = 
				{
					[1] = 0.59,
					[2] = 4.95,
				},
				[65] = 
				{
					[1] = 0.6,
					[2] = 4.94,
				},
				[66] = 
				{
					[1] = 0.61,
					[2] = 4.93,
				},
				[67] = 
				{
					[1] = 0.62,
					[2] = 4.9,
				},
				[68] = 
				{
					[1] = 0.63,
					[2] = 4.86,
				},
				[69] = 
				{
					[1] = 0.64,
					[2] = 4.83,
				},
				[70] = 
				{
					[1] = 0.64,
					[2] = 4.79,
				},
				[71] = 
				{
					[1] = 0.65,
					[2] = 4.76,
				},
				[72] = 
				{
					[1] = 0.66,
					[2] = 4.7,
				},
				[73] = 
				{
					[1] = 0.67,
					[2] = 4.64,
				},
				[74] = 
				{
					[1] = 0.68,
					[2] = 4.58,
				},
				[75] = 
				{
					[1] = 0.69,
					[2] = 4.52,
				},
				[76] = 
				{
					[1] = 0.7,
					[2] = 4.45,
				},
				[77] = 
				{
					[1] = 0.71,
					[2] = 4.39,
				},
				[78] = 
				{
					[1] = 0.72,
					[2] = 4.32,
				},
				[79] = 
				{
					[1] = 0.73,
					[2] = 4.24,
				},
				[80] = 
				{
					[1] = 0.74,
					[2] = 4.15,
				},
				[81] = 
				{
					[1] = 0.75,
					[2] = 4.07,
				},
				[82] = 
				{
					[1] = 0.76,
					[2] = 3.98,
				},
				[83] = 
				{
					[1] = 0.77,
					[2] = 3.9,
				},
				[84] = 
				{
					[1] = 0.78,
					[2] = 3.82,
				},
				[85] = 
				{
					[1] = 0.79,
					[2] = 3.72,
				},
				[86] = 
				{
					[1] = 0.79,
					[2] = 3.63,
				},
				[87] = 
				{
					[1] = 0.8,
					[2] = 3.53,
				},
				[88] = 
				{
					[1] = 0.81,
					[2] = 3.44,
				},
				[89] = 
				{
					[1] = 0.82,
					[2] = 3.35,
				},
				[90] = 
				{
					[1] = 0.83,
					[2] = 3.25,
				},
				[91] = 
				{
					[1] = 0.84,
					[2] = 3.16,
				},
				[92] = 
				{
					[1] = 0.85,
					[2] = 3.06,
				},
				[93] = 
				{
					[1] = 0.86,
					[2] = 2.97,
				},
				[94] = 
				{
					[1] = 0.87,
					[2] = 2.87,
				},
				[95] = 
				{
					[1] = 0.88,
					[2] = 2.77,
				},
				[96] = 
				{
					[1] = 0.89,
					[2] = 2.67,
				},
				[97] = 
				{
					[1] = 0.9,
					[2] = 2.56,
				},
				[98] = 
				{
					[1] = 0.91,
					[2] = 2.46,
				},
				[99] = 
				{
					[1] = 0.92,
					[2] = 2.35,
				},
				[100] = 
				{
					[1] = 0.93,
					[2] = 2.25,
				},
				[101] = 
				{
					[1] = 0.93,
					[2] = 1.99,
				},
				[102] = 
				{
					[1] = 0.94,
					[2] = 1.83,
				},
				[103] = 
				{
					[1] = 0.95,
					[2] = 1.66,
				},
				[104] = 
				{
					[1] = 0.96,
					[2] = 1.49,
				},
				[105] = 
				{
					[1] = 0.97,
					[2] = 1.31,
				},
				[106] = 
				{
					[1] = 0.98,
					[2] = 1.14,
				},
				[107] = 
				{
					[1] = 0.99,
					[2] = 0.9,
				},
			},
			["WidthScale"] = 1.35,
			["WidthSpeed"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 1,
				},
				[2] = 
				{
					[1] = 1,
					[2] = 1,
				},
			},
		},
		[2] = 
		{
			["AlphaScale"] = 1,
			["AlphaScaler"] = 1,
			["Autostart"] = true,
			["FadeIn"] = 0.1,
			["FitToWater"] = false,
			["HeightScale"] = 2.59,
			["HeightX"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.05,
					[2] = 0.65,
				},
				[3] = 
				{
					[1] = 0.1,
					[2] = 0.84,
				},
				[4] = 
				{
					[1] = 0.15,
					[2] = 0.94,
				},
				[5] = 
				{
					[1] = 0.2,
					[2] = 0.99,
				},
				[6] = 
				{
					[1] = 0.25,
					[2] = 1,
				},
				[7] = 
				{
					[1] = 0.3,
					[2] = 0.99,
				},
				[8] = 
				{
					[1] = 0.35,
					[2] = 0.96,
				},
				[9] = 
				{
					[1] = 0.4,
					[2] = 0.92,
				},
				[10] = 
				{
					[1] = 0.45,
					[2] = 0.86,
				},
				[11] = 
				{
					[1] = 0.5,
					[2] = 0.8,
				},
				[12] = 
				{
					[1] = 0.55,
					[2] = 0.73,
				},
				[13] = 
				{
					[1] = 0.6,
					[2] = 0.65,
				},
				[14] = 
				{
					[1] = 0.65,
					[2] = 0.57,
				},
				[15] = 
				{
					[1] = 0.7,
					[2] = 0.49,
				},
				[16] = 
				{
					[1] = 0.75,
					[2] = 0.41,
				},
				[17] = 
				{
					[1] = 0.8,
					[2] = 0.33,
				},
				[18] = 
				{
					[1] = 0.85,
					[2] = 0.24,
				},
				[19] = 
				{
					[1] = 0.9,
					[2] = 0.16,
				},
				[20] = 
				{
					[1] = 0.95,
					[2] = 0.08,
				},
			},
			["HeightY"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.04,
					[2] = 0.29,
				},
				[3] = 
				{
					[1] = 0.08,
					[2] = 0.38,
				},
				[4] = 
				{
					[1] = 0.12,
					[2] = 0.44,
				},
				[5] = 
				{
					[1] = 0.15,
					[2] = 0.47,
				},
				[6] = 
				{
					[1] = 0.19,
					[2] = 0.49,
				},
				[7] = 
				{
					[1] = 0.23,
					[2] = 0.5,
				},
				[8] = 
				{
					[1] = 0.27,
					[2] = 0.5,
				},
				[9] = 
				{
					[1] = 0.31,
					[2] = 0.49,
				},
				[10] = 
				{
					[1] = 0.35,
					[2] = 0.48,
				},
				[11] = 
				{
					[1] = 0.38,
					[2] = 0.46,
				},
				[12] = 
				{
					[1] = 0.42,
					[2] = 0.45,
				},
				[13] = 
				{
					[1] = 0.46,
					[2] = 0.42,
				},
				[14] = 
				{
					[1] = 0.5,
					[2] = 0.4,
				},
				[15] = 
				{
					[1] = 0.54,
					[2] = 0.37,
				},
				[16] = 
				{
					[1] = 0.58,
					[2] = 0.34,
				},
				[17] = 
				{
					[1] = 0.62,
					[2] = 0.31,
				},
				[18] = 
				{
					[1] = 0.65,
					[2] = 0.28,
				},
				[19] = 
				{
					[1] = 0.69,
					[2] = 0.25,
				},
				[20] = 
				{
					[1] = 0.73,
					[2] = 0.22,
				},
				[21] = 
				{
					[1] = 0.77,
					[2] = 0.19,
				},
				[22] = 
				{
					[1] = 0.81,
					[2] = 0.16,
				},
				[23] = 
				{
					[1] = 0.85,
					[2] = 0.13,
				},
				[24] = 
				{
					[1] = 0.88,
					[2] = 0.09,
				},
				[25] = 
				{
					[1] = 0.92,
					[2] = 0.06,
				},
				[26] = 
				{
					[1] = 0.96,
					[2] = 0.03,
				},
			},
			["HorizDivisions"] = 15,
			["Length"] = 12.17,
			["LocalSpace"] = true,
			["MaxSpeed"] = 15.4332,
			["ShowBackwards"] = false,
			["ShowForward"] = true,
			["StartSpeed"] = 3,
			["StartTime"] = 0.15,
			["StopSpeed"] = 3,
			["StopTime"] = 0.15,
			["TextureFile"] = "foamnew02.dds",
			["TextureRate"] = 0.084,
			["Type"] = "WaterTracer",
			["Width"] = 
			{
				[1] = 
				{
					[1] = 0,
					[2] = 0,
				},
				[2] = 
				{
					[1] = 0.01,
					[2] = 0.8,
				},
				[3] = 
				{
					[1] = 0.01,
					[2] = 1.02,
				},
				[4] = 
				{
					[1] = 0.02,
					[2] = 1.07,
				},
				[5] = 
				{
					[1] = 0.02,
					[2] = 1.13,
				},
				[6] = 
				{
					[1] = 0.03,
					[2] = 1.19,
				},
				[7] = 
				{
					[1] = 0.04,
					[2] = 1.25,
				},
				[8] = 
				{
					[1] = 0.04,
					[2] = 1.3,
				},
				[9] = 
				{
					[1] = 0.05,
					[2] = 1.36,
				},
				[10] = 
				{
					[1] = 0.06,
					[2] = 1.4,
				},
				[11] = 
				{
					[1] = 0.06,
					[2] = 1.43,
				},
				[12] = 
				{
					[1] = 0.07,
					[2] = 1.45,
				},
				[13] = 
				{
					[1] = 0.07,
					[2] = 1.47,
				},
				[14] = 
				{
					[1] = 0.08,
					[2] = 1.48,
				},
				[15] = 
				{
					[1] = 0.09,
					[2] = 1.5,
				},
				[16] = 
				{
					[1] = 0.09,
					[2] = 1.52,
				},
				[17] = 
				{
					[1] = 0.1,
					[2] = 1.53,
				},
				[18] = 
				{
					[1] = 0.11,
					[2] = 1.55,
				},
				[19] = 
				{
					[1] = 0.11,
					[2] = 1.57,
				},
				[20] = 
				{
					[1] = 0.12,
					[2] = 1.58,
				},
				[21] = 
				{
					[1] = 0.12,
					[2] = 1.6,
				},
				[22] = 
				{
					[1] = 0.13,
					[2] = 1.61,
				},
				[23] = 
				{
					[1] = 0.14,
					[2] = 1.63,
				},
				[24] = 
				{
					[1] = 0.14,
					[2] = 1.65,
				},
				[25] = 
				{
					[1] = 0.15,
					[2] = 1.66,
				},
				[26] = 
				{
					[1] = 0.16,
					[2] = 1.68,
				},
				[27] = 
				{
					[1] = 0.16,
					[2] = 1.69,
				},
				[28] = 
				{
					[1] = 0.17,
					[2] = 1.71,
				},
				[29] = 
				{
					[1] = 0.17,
					[2] = 1.72,
				},
				[30] = 
				{
					[1] = 0.18,
					[2] = 1.74,
				},
				[31] = 
				{
					[1] = 0.19,
					[2] = 1.75,
				},
				[32] = 
				{
					[1] = 0.19,
					[2] = 1.77,
				},
				[33] = 
				{
					[1] = 0.2,
					[2] = 1.78,
				},
				[34] = 
				{
					[1] = 0.2,
					[2] = 1.79,
				},
				[35] = 
				{
					[1] = 0.21,
					[2] = 1.81,
				},
				[36] = 
				{
					[1] = 0.22,
					[2] = 1.82,
				},
				[37] = 
				{
					[1] = 0.22,
					[2] = 1.84,
				},
				[38] = 
				{
					[1] = 0.23,
					[2] = 1.85,
				},
				[39] = 
				{
					[1] = 0.24,
					[2] = 1.86,
				},
				[40] = 
				{
					[1] = 0.24,
					[2] = 1.88,
				},
				[41] = 
				{
					[1] = 0.25,
					[2] = 1.89,
				},
				[42] = 
				{
					[1] = 0.25,
					[2] = 1.9,
				},
				[43] = 
				{
					[1] = 0.26,
					[2] = 1.91,
				},
				[44] = 
				{
					[1] = 0.27,
					[2] = 1.92,
				},
				[45] = 
				{
					[1] = 0.27,
					[2] = 1.93,
				},
				[46] = 
				{
					[1] = 0.28,
					[2] = 1.94,
				},
				[47] = 
				{
					[1] = 0.29,
					[2] = 1.95,
				},
				[48] = 
				{
					[1] = 0.29,
					[2] = 1.96,
				},
				[49] = 
				{
					[1] = 0.3,
					[2] = 1.97,
				},
				[50] = 
				{
					[1] = 0.3,
					[2] = 1.98,
				},
				[51] = 
				{
					[1] = 0.31,
					[2] = 1.99,
				},
				[52] = 
				{
					[1] = 0.32,
					[2] = 1.99,
				},
				[53] = 
				{
					[1] = 0.32,
					[2] = 2,
				},
				[54] = 
				{
					[1] = 0.33,
					[2] = 2.01,
				},
				[55] = 
				{
					[1] = 0.34,
					[2] = 2.02,
				},
				[56] = 
				{
					[1] = 0.34,
					[2] = 2.03,
				},
				[57] = 
				{
					[1] = 0.35,
					[2] = 2.04,
				},
				[58] = 
				{
					[1] = 0.35,
					[2] = 2.04,
				},
				[59] = 
				{
					[1] = 0.36,
					[2] = 2.05,
				},
				[60] = 
				{
					[1] = 0.37,
					[2] = 2.06,
				},
				[61] = 
				{
					[1] = 0.37,
					[2] = 2.07,
				},
				[62] = 
				{
					[1] = 0.38,
					[2] = 2.08,
				},
				[63] = 
				{
					[1] = 0.39,
					[2] = 2.08,
				},
				[64] = 
				{
					[1] = 0.39,
					[2] = 2.09,
				},
				[65] = 
				{
					[1] = 0.4,
					[2] = 2.1,
				},
				[66] = 
				{
					[1] = 0.4,
					[2] = 2.1,
				},
				[67] = 
				{
					[1] = 0.41,
					[2] = 2.11,
				},
				[68] = 
				{
					[1] = 0.42,
					[2] = 2.11,
				},
				[69] = 
				{
					[1] = 0.42,
					[2] = 2.12,
				},
				[70] = 
				{
					[1] = 0.43,
					[2] = 2.12,
				},
				[71] = 
				{
					[1] = 0.43,
					[2] = 2.12,
				},
				[72] = 
				{
					[1] = 0.44,
					[2] = 2.13,
				},
				[73] = 
				{
					[1] = 0.45,
					[2] = 2.13,
				},
				[74] = 
				{
					[1] = 0.45,
					[2] = 2.14,
				},
				[75] = 
				{
					[1] = 0.46,
					[2] = 2.14,
				},
				[76] = 
				{
					[1] = 0.47,
					[2] = 2.15,
				},
				[77] = 
				{
					[1] = 0.47,
					[2] = 2.15,
				},
				[78] = 
				{
					[1] = 0.48,
					[2] = 2.15,
				},
				[79] = 
				{
					[1] = 0.48,
					[2] = 2.16,
				},
				[80] = 
				{
					[1] = 0.49,
					[2] = 2.16,
				},
				[81] = 
				{
					[1] = 0.5,
					[2] = 2.16,
				},
				[82] = 
				{
					[1] = 0.5,
					[2] = 2.17,
				},
				[83] = 
				{
					[1] = 0.51,
					[2] = 2.17,
				},
				[84] = 
				{
					[1] = 0.52,
					[2] = 2.17,
				},
				[85] = 
				{
					[1] = 0.52,
					[2] = 2.18,
				},
				[86] = 
				{
					[1] = 0.53,
					[2] = 2.18,
				},
				[87] = 
				{
					[1] = 0.53,
					[2] = 2.18,
				},
				[88] = 
				{
					[1] = 0.54,
					[2] = 2.19,
				},
				[89] = 
				{
					[1] = 0.55,
					[2] = 2.19,
				},
				[90] = 
				{
					[1] = 0.55,
					[2] = 2.19,
				},
				[91] = 
				{
					[1] = 0.56,
					[2] = 2.19,
				},
				[92] = 
				{
					[1] = 0.57,
					[2] = 2.2,
				},
				[93] = 
				{
					[1] = 0.57,
					[2] = 2.2,
				},
				[94] = 
				{
					[1] = 0.58,
					[2] = 2.22,
				},
				[95] = 
				{
					[1] = 0.58,
					[2] = 2.23,
				},
				[96] = 
				{
					[1] = 0.59,
					[2] = 2.23,
				},
				[97] = 
				{
					[1] = 0.6,
					[2] = 2.24,
				},
				[98] = 
				{
					[1] = 0.6,
					[2] = 2.25,
				},
				[99] = 
				{
					[1] = 0.61,
					[2] = 2.26,
				},
				[100] = 
				{
					[1] = 0.61,
					[2] = 2.26,
				},
				[101] = 
				{
					[1] = 0.62,
					[2] = 2.27,
				},
				[102] = 
				{
					[1] = 0.63,
					[2] = 2.28,
				},
				[103] = 
				{
					[1] = 0.63,
					[2] = 2.28,
				},
				[104] = 
				{
					[1] = 0.64,
					[2] = 2.29,
				},
				[105] = 
				{
					[1] = 0.65,
					[2] = 2.3,
				},
				[106] = 
				{
					[1] = 0.65,
					[2] = 2.3,
				},
				[107] = 
				{
					[1] = 0.66,
					[2] = 2.31,
				},
				[108] = 
				{
					[1] = 0.66,
					[2] = 2.31,
				},
				[109] = 
				{
					[1] = 0.67,
					[2] = 2.32,
				},
				[110] = 
				{
					[1] = 0.68,
					[2] = 2.32,
				},
				[111] = 
				{
					[1] = 0.68,
					[2] = 2.33,
				},
				[112] = 
				{
					[1] = 0.69,
				},
	},