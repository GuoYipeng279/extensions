ArcadeTable = {}

ArcadeTable[1] = -- RN 356
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 115,
		["BlastDamageMin"] = 115,
		["BlastRange"] = 25,
	},
	["Comment"] = "King George V. 14'' Shell",
	["DamageMax"] = 350,
	["DamageMin"] = 230,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "14/45 battleship gun bullet - KGV primary",
	["Range"] = 3000,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["UE_DLC"] = "",
	["V0"] = 300,
}

ArcadeTable[2] = -- Hedgehog
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 200,
		["BlastDamageMin"] = 150,
		["BlastRange"] = 50,
	},
	["Comment"] = "Hedgehog Projector Depth Charge",
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 52,
	["FlyTime"] = 20,
	["Mass"] = 700,
	["MaxFall"] = 100,
	["MaxWaterHitVel"] = 55.555561,
	["Mesh"] = "bullets/hedgehog_bullet.MMOD",
	["Name"] = "Hedgehog Projector Depth Charge",
	["Type"] = "Depthcharge",
	["V0"] = 50,
	["V0RandomFactor"] = 0,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[3] = -- RN 134
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 65,
		["BlastDamageMin"] = 65,
		["BlastRange"] = 10,
	},
	["Comment"] = "King George V. 5.25'' Shell",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "battleship sec. gun bullet - KGV secondary",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[4] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_homing_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Fido Homing Airplane",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplDeepUnderWaterArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["HomingHorzTurnSpeed"] = 0.5,
	["HomingVertTurnSpeed"] = 0.5,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/usairplanetorp.mmod",
	["Name"] = "Fido homing airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_homing_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 30.8664,
}

ArcadeTable[5] = 
{
	["Acceleration"] = 650,
	["AntiAir"] = true,
	["BigPayloadIcon"] = "common/icons/payload/rocket_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 50,
	},
	["Comment"] = "Rocket 4.7'' AA - ellenorizni",
	["DamageMax"] = 75,
	["DamageMin"] = 50,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 5,
	["Mass"] = 25.030005,
	["Mesh"] = "bullets/japan50incendiary.mmod",
	["Name"] = "4.7'' AA rocket",
	["NoGravity"] = true,
	["Radar"] = true,
	["SmallPayloadIcon"] = "common/icons/payload/rocket_s.tga",
	["TimeOutEfx"] = 16,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	--["Type"] = "Rocket",
	["Type"] = "Flak",
	["V0"] = 200,
	["VMax"] = 1800,
}

ArcadeTable[6] = 
{
	["Acceleration"] = 50,
	["AntiAir"] = false,
	["BigPayloadIcon"] = "common/icons/payload/tinytim_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 100,
		["BlastDamageMin"] = 100,
		["BlastRange"] = 25,
	},
	["Comment"] = "Rocket Tiny Tim",
	["DamageMax"] = 2250,
	["DamageMin"] = 1800,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 16,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["FlyTime"] = 10,
	["IgnitionDelay"] = 1,
	["Mass"] = 25.030005,
	["Mesh"] = "bullets/TinyTim.mmod",
	["Name"] = "Tiny Tim",
	["SmallPayloadIcon"] = "common/icons/payload/tinytim_s.tga",
	["TimeOutEfx"] = 11,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	["Type"] = "Rocket",
	["V0"] = 0,
	["VMax"] = 250,
}

ArcadeTable[7] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 180,
		["BlastDamageMin"] = 180,
		["BlastRange"] = 40,
	},
	["Comment"] = "Rocket, 5'' Bombardment (bullet)",
	["DamageMax"] = 200,
	["DamageMin"] = 180,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.030029,
	["Mesh"] = "bullets/5inch_hvar.mmod",
	["Name"] = "5-Inch bombardment rocket",
	["Range"] = 4000,
	--["TravelEfx"] = 301,
	--["TravelEfx2"] = 405,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[8] = 
{
	["Acceleration"] = 500,
	["AntiAir"] = false,
	["BigPayloadIcon"] = "common/icons/payload/rocket_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 30,
		["BlastDamageMin"] = 30,
		["BlastRange"] = 25,
	},
	["Comment"] = "Rocket 5'' HVAR",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 6,
	["IgnitionDelay"] = 0,
	["Mass"] = "25,0300045013428",
	["Mesh"] = "bullets/5inch_hvar.mmod",
	["Name"] = "5'' HVAR",
	["SmallPayloadIcon"] = "common/icons/payload/rocket_s.tga",
	["TimeOutEfx"] = 11,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	["Type"] = "Rocket",
	["V0"] = 0,
	["VMax"] = 500,
}

ArcadeTable[9] = -- USN 203
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 90,
		["BlastDamageMin"] = 90,
		["BlastRange"] = 15,
	},
	["Comment"] = "Northampton 8'' Shell",
	["DamageMax"] = 220,
	["DamageMin"] = 200,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "8/55 heavy cruiser gun bullet - Northampton",
	["Range"] = 2300,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[10] = 
{
	["BigPayloadIcon"] = "common/icons/payload/800kg_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 25,
	},
	["Comment"] = "800 kg bomb Japan",
	["DamageMax"] = 1000,
	["DamageMin"] = 800,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 15,
	["Mass"] = 800,
	["Mesh"] = "bullets/japan500.MMOD",
	["Name"] = "Japan 800 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/800kg_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[11] = 
{
	["Acceleration"] = 1000,
	["AntiAir"] = true,
	["BigPayloadIcon"] = "common/icons/payload/rocket_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 120,
		["BlastDamageMin"] = 100,
		["BlastRange"] = 30,
	},
	["Comment"] = "Rocket R4M AA",
	["DamageMax"] = 50,
	["DamageMin"] = 25,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 10,
	["ExplGroundEfx"] = 10,
	["ExplLightArmorEfx"] = 10,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 4,
	["IgnitionDelay"] = 0,
	["Mass"] = 25,
	["Mesh"] = "bullets/japan50incendiary.mmod",
	["Name"] = "R4M AA",
	["SmallPayloadIcon"] = "common/icons/payload/rocket_s.tga",
	["TimeOutEfx"] = 10,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	["Type"] = "Rocket",
	["V0"] = 0,
	["VMax"] = 800,
}

ArcadeTable[12] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 260,
		["BlastRange"] = 50,
	},
	["Comment"] = "Depth Charge ship K-Gun US",
	["DiveMaxDepth"] = 33,
	["DiveMinDepth"] = 20,
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["Mass"] = 700,
	["MaxFall"] = 100,
	["MaxWaterHitVel"] = 200,
	["Mesh"] = "bullets/deptchargebomb.mmod",
	["Name"] = "Depth Charge ship US",
	["Type"] = "Depthcharge",
	["V0"] = 20,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[13] = -- 152
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 15,
	},
	["Comment"] = "De Ruyter 6'' Shell",
	["DamageMax"] = 155,
	["DamageMin"] = 145,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "6/47 cruiser gun bullet - De Ruyter",
	["Range"] = 1900,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[14] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 35,
		["BlastDamageMin"] = 35,
		["BlastRange"] = 30,
	},
	["Comment"] = "Akizuki Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2.5,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "Akizuki Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[15] = -- USN 127
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 65,
		["BlastDamageMin"] = 65,
		["BlastRange"] = 10,
	},
	["Comment"] = "Fletcher 5''",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "5inch/38 destroyer gun bullet - Fletcher",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[16] = -- RN 380
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 117,
		["BlastDamageMin"] = 117,
		["BlastRange"] = 25,
	},
	["Comment"] = "Repulse. 15'' Shell",
	["DamageMax"] = 400,
	["DamageMin"] = 235,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "15 battleship gun bullet - Repulse primary",
	["Range"] = 3000,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[17] = -- 102mm
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 65,
		["BlastDamageMin"] = 65,
		["BlastRange"] = 10,
	},
	["Comment"] = "Clemson/Minekaze Shell 4''",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "4inch destroyer gun bullet - Clemson",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 386,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[18] = -- SS 152
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 85,
		["BlastDamageMin"] = 85,
		["BlastRange"] = 10,
	},
	["Comment"] = "Submarine Shell US",
	["DamageMax"] = 155,
	["DamageMin"] = 145,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "submarine bullet",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 386,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[19] = -- IJN 100
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Akizuki 3.9''",
	["DamageMax"] = 120,
	["DamageMin"] = 110,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "3.9/65 combined gun bullet - semmi",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 386,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[20] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 35,
		["BlastDamageMin"] = 35,
		["BlastRange"] = 40,
	},
	["Comment"] = "Atlanta Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2.5,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "Akizuki Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[21] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 1250,
		["BlastDamageMin"] = 1000,
		["BlastRange"] = 30,
	},
	["Comment"] = "Kamikaze Plane Impact",
	["ExplArmorEfx"] = 71,
	["ExplGroundEfx"] = 71,
	["ExplLightArmorEfx"] = 71,
	["ExplWaterEfx"] = 166,
	["ExplWaterHit"] = true,
	["Name"] = "kamikaze plane impact",
	["Type"] = "Kamikaze",
}

ArcadeTable[22] = 
{
	["BigPayloadIcon"] = "common/icons/payload/paratrooper_l.tga",
	["CaptureDuration"] = 30,
	["CapturePower"] = 12,
	["CloseDuration"] = 2,
	["Comment"] = "JP Paratrooper",
	["Damage"] = 42,
	["ExplArmorEfx"] = 158,
	["Mesh"] = "models/bullets/cel_ejtoernyo_marine.MMOD",
	["Name"] = "Paratrooper",
	["OpenDelay"] = 3,
	["OpenDuration"] = 1,
	["SlowFactorClosed"] = 0.2,
	["SlowFactorOpened"] = 2,
	["SmallPayloadIcon"] = "common/icons/payload/paratrooper_s.tga",
	["SoldierAnim"] = "fire2",
	["SoldierClass"] = "USMarine_shiptraffic",
	["Type"] = "Paratrooper",
}

ArcadeTable[23] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 150,
		["BlastDamageMin"] = 150,
		["BlastRange"] = 25,
	},
	["Comment"] = "Yamato 18'' Shell",
	["DamageMax"] = 510,
	["DamageMin"] = 300,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "18/45 battleship gun bullet - Yamato primary",
	["Range"] = 3300,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[24] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 10,
	},
	["Comment"] = "Yamato 6'' Shell",
	["DamageMax"] = 180,
	["DamageMin"] = 150,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "6/60 cruiser gun bullet - Yamato secondary",
	["Range"] = 1800,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[25] = -- Fuso/Kongo 14 '' Shell
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 105,
		["BlastDamageMin"] = 105,
		["BlastRange"] = 25,
	},
	["Comment"] = "Fuso/Kongo 14'' Shell",
	["DamageMax"] = 450,
	["DamageMin"] = 230,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "14/45 battleship gun bullet",
	["Range"] = 3000,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[26] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 130,
		["BlastDamageMin"] = 130,
		["BlastRange"] = 25,
	},
	["Comment"] = "Huge Battery DLC Shell",
	["DamageMax"] = 2000,
	["DamageMin"] = 1500,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "Huge Battery DLC Shell",
	["Range"] = 2900,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[27] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Airplane JP strong",
	["DamageMax"] = 650,
	["DamageMin"] = 550,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/japanairplanetorp.mmod",
	["Name"] = "17.7 Type 91 Mod3 airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 18,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[28] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 90,
		["BlastDamageMin"] = 90,
		["BlastRange"] = 15,
	},
	["Comment"] = "Tone/Takao 8'' Shell",
	["DamageMax"] = 190,
	["DamageMin"] = 180,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "8/50 heavy cruiser gun bullet",
	["Range"] = 2200,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[29] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Airplane US strong",
	["DamageMax"] = 650,
	["DamageMin"] = 550,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 60,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/usairplanetorp.mmod",
	["Name"] = "22.4 Mark 13 airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 18,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[30] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 15,
	},
	["Comment"] = "Kuma 5.5'' Shell",
	["DamageMax"] = 155,
	["DamageMin"] = 145,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "5.5 cruiser gun bullet",
	["Range"] = 1700,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[31] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 65,
		["BlastDamageMin"] = 65,
		["BlastRange"] = 10,
	},
	["Comment"] = "Fubuki 5'' Shell",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "fubuki bullet nemdebar",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[32] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 1,
		["BlastDamageMin"] = 1,
		["BlastRange"] = 1,
	},
	["Comment"] = "MISSION - USN03 Puffin",
	["DiveMaxDepth"] = 6,
	["DiveMinDepth"] = 4,
	["DiveSpeed"] = 1,
	["ExplAirEfx"] = 3,
	["ExplArmorEfx"] = 3,
	["ExplGroundEfx"] = 3,
	["ExplLightArmorEfx"] = 3,
	["ExplWaterEfx"] = 3,
	["Mass"] = 300,
	["MaxFall"] = 100,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "structures/others/bala_kicsi.MMOD",
	["Name"] = "Depth Charge ship US",
	["Type"] = "Depthcharge",
	["V0"] = 10,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[33] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 85,
		["BlastDamageMin"] = 85,
		["BlastRange"] = 10,
	},
	["Comment"] = "Submarine Shell JP",
	["DamageMax"] = 155,
	["DamageMin"] = 145,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "submarine bullet",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 386,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[34] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 70,
		["BlastDamageMin"] = 70,
		["BlastRange"] = 10,
	},
	["Comment"] = "Deck Gun Shell",
	["DamageMax"] = 150,
	["DamageMin"] = 140,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "deck gun bullet",
	["Range"] = 1500,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 386,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[35] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 750,
		["BlastDamageMin"] = 500,
		["BlastRange"] = 30,
	},
	["Comment"] = "Kamikaze US10 Impact",
	["ExplArmorEfx"] = 71,
	["ExplGroundEfx"] = 71,
	["ExplLightArmorEfx"] = 71,
	["ExplWaterEfx"] = 166,
	["ExplWaterHit"] = true,
	["Name"] = "kamikaze US10 impact",
	["Type"] = "Kamikaze",
}

ArcadeTable[36] = 
{
	["Comment"] = "25mm/60 AA (Japanese Patrol Boat)",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 25.030001,
	["Name"] = "25mm/60 AA",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[37] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 15,
	},
	["Comment"] = "Agano 6'' Shell",
	["DamageMax"] = 180,
	["DamageMin"] = 150,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 11,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "Agano 6'' (DR clone)",
	["Range"] = 1900,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[38] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 130,
		["BlastDamageMin"] = 130,
		["BlastRange"] = 25,
	},
	["Comment"] = "Huge Battery Long Range Shell",
	["DamageMax"] = 500,
	["DamageMin"] = 400,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "Huge Battery Long Range Shell",
	["Range"] = 10000,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[39] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 35,
		["BlastDamageMin"] = 35,
		["BlastRange"] = 35,
	},
	["Comment"] = "5'' Command Building Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "5inch/38 destroyer AA Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[40] = 
{
	["Comment"] = "20mm Oerlikon bullet",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.123,
	["Name"] = "20mm/70 Oerlikon AA",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[41] = 
{
	["Comment"] = "28mm quad AA bullet",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.123,
	["Name"] = "28mm quad AA",
	["NoGravity"] = true,
	["TravelEfx"] = 83,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[42] = 
{
	["Comment"] = "40mm Bofors AA bullet",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2,
	["Mass"] = 0.123,
	["Name"] = "40mm Bofors AA",
	["NoGravity"] = true,
	["TravelEfx"] = 81,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[43] = -- .50 cal
{
	["Comment"] = ".50cal BMG twin AA",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.123,
	["Name"] = ".5 cal twin AA mg",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[44] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 35,
		["BlastDamageMin"] = 35,
		["BlastRange"] = 35,
	},
	["Comment"] = "5'' US Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2.5,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "5inch/38 destroyer AA Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[45] = 
{
	["Comment"] = "13mm/76 AA",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 25.030001,
	["Name"] = "13mm/76 AA",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[46] = -- 25mm
{
	["Comment"] = "25mm/60 AA",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2,
	["Mass"] = 25.030001,
	["Name"] = "25mm/60 AA",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[47] = 
{
	["BigPayloadIcon"] = "common/icons/payload/1600lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 25,
	},
	["Comment"] = "725kg (1600 lbs) bomb US",
	["DamageMax"] = 750,
	["DamageMin"] = 630,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 150,
	["FireDamage"] = 30,
	["Mass"] = 725,
	["Mesh"] = "bullets/us500.mmod",
	["Name"] = "US 725 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/1600lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[48] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 150,
		["BlastDamageMin"] = 150,
		["BlastRange"] = 25,
	},
	["Comment"] = "Super Yamato 20'' Shell",
	["DamageMax"] = 690,
	["DamageMin"] = 625,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 17,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 16,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "20/45 battleship gun bullet - Super Yamato",
	["Range"] = 3300,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["UE_DLC"] = "2",
	["V0"] = 300,
}

ArcadeTable[49] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 35,
		["BlastDamageMin"] = 35,
		["BlastRange"] = 35,
	},
	["Comment"] = "JP Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2.5,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "Jap Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[50] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 90,
		["BlastDamageMin"] = 90,
		["BlastRange"] = 15,
	},
	["Comment"] = "Alaska 12'' Shell DLC",
	["DamageMax"] = 260,
	["DamageMin"] = 240,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 13,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["Mass"] = 225.029999,
	["Name"] = "12 heavy cruiser gun bullet - Alaska DLC",
	["Range"] = 2300,
	["TravelEfx"] = 14,
	["TravelEfx2"] = 405,
	["Type"] = "Artillery",
	["UE_DLC"] = "2",
	["V0"] = 300,
}

ArcadeTable[51] = 
{
	["Acceleration"] = 500,
	["AntiAir"] = false,
	["BigPayloadIcon"] = "common/icons/payload/rocket_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 30,
		["BlastDamageMin"] = 30,
		["BlastRange"] = 25,
	},
	["Comment"] = "Rocket 5'' HVAR Small DLC",
	["DamageMax"] = 150,
	["DamageMin"] = 130,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 12,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 6,
	["IgnitionDelay"] = 0,
	["Mass"] = 250300040478720,
	["Mesh"] = "bullets/5inch_hvar_small.mmod",
	["Name"] = "5'' HVAR",
	["SmallPayloadIcon"] = "common/icons/payload/rocket_s.tga",
	["TimeOutEfx"] = 11,
	["TravelEfx"] = 341,
	["TravelEfx2"] = 341,
	["Type"] = "Rocket",
	--["UE_DLC"] = "2",
	["V0"] = 0,
	["VMax"] = 500,
}

ArcadeTable[54] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 260,
		["BlastRange"] = 50,
	},
	["Comment"] = "Depth Charge ship US",
	["DiveMaxDepth"] = 33,
	["DiveMinDepth"] = 20,
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["Mass"] = 700,
	["MaxFall"] = 100,
	["MaxWaterHitVel"] = 55.555557,
	["Mesh"] = "bullets/deptchargebomb.mmod",
	["Name"] = "Depth Charge ship US",
	["Type"] = "Depthcharge",
	["V0"] = 10,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[55] = 
{
	["BigPayloadIcon"] = "common/icons/payload/dc_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 280,
		["BlastRange"] = 50,
	},
	["Comment"] = "Depth Charge aerial US",
	["DiveMaxDepth"] = 33,
	["DiveMinDepth"] = 20,
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["Mass"] = 700,
	["MaxFall"] = 1400,
	["MaxWaterHitVel"] = 250,
	["Mesh"] = "bullets/usairplanedepthchargebomb.mmod",
	["Name"] = "Depth Charge aerial US",
	["SmallPayloadIcon"] = "common/icons/payload/dc_s.tga",
	["Type"] = "Depthcharge",
	["V0"] = 0,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[57] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 260,
		["BlastRange"] = 50,
	},
	["Comment"] = "Depth Charge ship Jap",
	["DiveMaxDepth"] = 33,
	["DiveMinDepth"] = 20,
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["Mass"] = 700,
	["MaxFall"] = 100,
	["MaxWaterHitVel"] = 55.555557,
	["Mesh"] = "bullets/deptchargebomb.mmod",
	["Name"] = "Depth Charge ship Jap",
	["Type"] = "Depthcharge",
	["V0"] = 5,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[58] = 
{
	["BigPayloadIcon"] = "common/icons/payload/dc_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 280,
		["BlastRange"] = 50,
	},
	["Comment"] = "Depth Charge aerial Jap",
	["DiveMaxDepth"] = 33,
	["DiveMinDepth"] = 20,
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["Mass"] = 700,
	["MaxFall"] = 1400,
	["MaxWaterHitVel"] = 250,
	["Mesh"] = "bullets/japanairplanedepthchargebomb.mmod",
	["Name"] = "Depth Charge aerial Jap",
	["SmallPayloadIcon"] = "common/icons/payload/dc_s.tga",
	["Type"] = "Depthcharge",
	["V0"] = 0,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
	["WaterTravelEfx"] = 53,
}

ArcadeTable[61] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo PT US",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/ussubmarinetorp.mmod",
	["Name"] = "21. Mark 14 submarine torpedo",
	["Type"] = "Torpedo",
	["V0"] = 23,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[62] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Ship US",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/ussubmarinetorp.mmod",
	["Name"] = "21. Mark 15 ship torpedo",
	["Type"] = "Torpedo",
	["V0"] = 13,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[63] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Airplane US",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 60,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/usairplanetorp.mmod",
	["Name"] = "22.4 Mark 13 airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[64] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Airplane UK",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/ukairplanetorp.mmod",
	["Name"] = "19. Mark 24 airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[65] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Sub US",
	["DamageMax"] = 800,
	["DamageMin"] = 700,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/ussubmarinetorp.mmod",
	["Name"] = "21. Mark 14 submarine torpedo",
	["Type"] = "Torpedo",
	["V0"] = 23,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[66] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo PT JP",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/japanshiptorp.mmod",
	["Name"] = "21. Type 95 Mod1 submarine torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 23,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[67] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Ship JP Long Lance",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/japanshiptorp.mmod",
	["Name"] = "24. Type 93 Mod1 Long Lance ship torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 13,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[69] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Airplane JP",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 100,
	["Mesh"] = "bullets/japanairplanetorp.mmod",
	["Name"] = "17.7 Type 91 Mod3 airplane torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 0,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[70] = 
{
	["BigPayloadIcon"] = "common/icons/payload/torpedo_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 50,
		["BlastDamageMin"] = 50,
		["BlastRange"] = 10,
	},
	["Comment"] = "Torpedo Sub JP",
	["DamageMax"] = 800,
	["DamageMin"] = 700,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplUnderWaterArmorEfx"] = 59,
	["ExplWaterEfx"] = 46,
	["FlyTime"] = 60,
	["HeadingTurn"] = 10,
	["Mass"] = 700,
	["MaxFall"] = 50,
	["MaxWaterHitVel"] = 60,
	["Mesh"] = "bullets/japanshiptorp.mmod",
	["Name"] = "21. Type 95 Mod1 submarine torpedo",
	["SmallPayloadIcon"] = "common/icons/payload/torpedo_s.tga",
	["Type"] = "Torpedo",
	["V0"] = 23,
	["WaterDamage"] = 15,
	["WaterSplashEfx"] = 58,
	["WaterTravelEfx"] = 60,
	["WaterTravelSpeed"] = 51.444,
}

ArcadeTable[71] = 
{
	["BigPayloadIcon"] = "common/icons/payload/1000lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 25,
	},
	["Comment"] = "500 kg bomb US",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 150,
	["FireDamage"] = 30,
	["Mass"] = 500,
	["Mesh"] = "bullets/us500.mmod",
	["Name"] = "US 500 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/1000lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[72] = 
{
	["BigPayloadIcon"] = "common/icons/payload/450lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 25,
	},
	["Comment"] = "250 kg bomb US",
	["DamageMax"] = 275,
	["DamageMin"] = 225,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 10,
	["Mass"] = 250,
	["Mesh"] = "bullets/us250.mmod",
	["Name"] = "US 250 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/450lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[73] = 
{
	["BigPayloadIcon"] = "common/icons/payload/200lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 25,
	},
	["Comment"] = "100 kg bomb US",
	["DamageMax"] = 200,
	["DamageMin"] = 150,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 5,
	["Mass"] = 100,
	["Mesh"] = "bullets/us100.mmod",
	["Name"] = "US 100 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/200lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[74] = 
{
	["BigPayloadIcon"] = "common/icons/payload/100lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 15,
	},
	["Comment"] = "50 kg bomb US",
	["DamageMax"] = 150,
	["DamageMin"] = 100,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 2,
	["Mass"] = 50,
	["Mesh"] = "bullets/us100.mmod",
	["Name"] = "US 50 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/100lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[75] = 
{
	["BigPayloadIcon"] = "common/icons/payload/450lbs_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 60,
		["BlastDamageMin"] = 60,
		["BlastRange"] = 20,
	},
	["Comment"] = "Incendiary bomb US",
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 71,
	["ExplGroundEfx"] = 71,
	["ExplLightArmorEfx"] = 71,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 50,
	["Mass"] = 40,
	["Mesh"] = "bullets/us250.MMOD",
	["Name"] = "US incendiary bomb",
	["SmallPayloadIcon"] = "common/icons/payload/450lbs_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[77] = 
{
	["BigPayloadIcon"] = "common/icons/payload/500kg_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 25,
	},
	["Comment"] = "500 kg bomb Japan",
	["DamageMax"] = 550,
	["DamageMin"] = 450,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 15,
	["Mass"] = 500,
	["Mesh"] = "bullets/japan500.MMOD",
	["Name"] = "Japan 500 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/500kg_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[78] = 
{
	["BigPayloadIcon"] = "common/icons/payload/250kg_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 25,
	},
	["Comment"] = "250 kg bomb Japan",
	["DamageMax"] = 275,
	["DamageMin"] = 225,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 10,
	["Mass"] = 250,
	["Mesh"] = "bullets/japan250.MMOD",
	["Name"] = "Japan 250 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/250kg_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[79] = 
{
	["BigPayloadIcon"] = "common/icons/payload/100kg_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 75,
		["BlastRange"] = 25,
	},
	["Comment"] = "100 kg bomb Japan",
	["DamageMax"] = 200,
	["DamageMin"] = 150,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 5,
	["Mass"] = 100,
	["Mesh"] = "bullets/japan100.MMOD",
	["Name"] = "Japan 100 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/100kg_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[80] = 
{
	["BigPayloadIcon"] = "common/icons/payload/45kg_bomb_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 80,
		["BlastDamageMin"] = 80,
		["BlastRange"] = 15,
	},
	["Comment"] = "50 kg bomb Japan",
	["DamageMax"] = 150,
	["DamageMin"] = 100,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 2,
	["Mass"] = 50,
	["Mesh"] = "bullets/japan50incendiary.mmod",
	["Name"] = "Japan 50 kg bomb",
	["SmallPayloadIcon"] = "common/icons/payload/45kg_bomb_s.tga",
	["Type"] = "Bomb",
}

ArcadeTable[81] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 60,
		["BlastDamageMin"] = 60,
		["BlastRange"] = 20,
	},
	["Comment"] = "Incendiary bomb Japan",
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["ExplWaterHit"] = true,
	["FireChance"] = 100,
	["FireDamage"] = 50,
	["Mass"] = 40,
	["Mesh"] = "bullets/japan12incendiary.MMOD",
	["Name"] = "Jap incendiary bomb",
	["Type"] = "Bomb",
}

ArcadeTable[82] = 
{
	["Comment"] = "* .50 cal BMG (P-80)",
	["DamageMax"] = 20,
	["DamageMin"] = 18,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.142,
	["Name"] = "20mm type 99m1",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 750,
}

ArcadeTable[84] = 
{
	["Comment"] = ".30 cal BMG (Dive / Torpedobomber)",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = ".30 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[85] = 
{
	["Comment"] = ".50 cal BMG (Buffalo)",
	["DamageMax"] = 18,
	["DamageMin"] = 16,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = ".50 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[86] = 
{
	["Comment"] = ".50 cal BMG (US Fighter)",
	["DamageMax"] = 20,
	["DamageMin"] = 18,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.142,
	["Name"] = "20mm M2",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[87] = 
{
	["Comment"] = "20mm Hispano M2 (P-38)",
	["DamageMax"] = 22,
	["DamageMin"] = 20,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = ".30 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[88] = 
{
	["Comment"] = "7.7mm (Zero)",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = ".50 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[89] = 
{
	["Comment"] = "7.7mm (Dive / Torpedobomber)",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.0113,
	["Name"] = "7.7mm type 97",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[90] = 
{
	["Comment"] = "13.2mm (Oscar)",
	["DamageMax"] = 18,
	["DamageMin"] = 16,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = "13.2 mm Type 2",
	["NoGravity"] = true,
	["TravelEfx"] = 81,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[91] = 
{
	["Comment"] = "20mm 99m1 (Zero)",
	["DamageMax"] = 20,
	["DamageMin"] = 20,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.142,
	["Name"] = "20mm type 99m1",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[92] = 
{
	["Comment"] = "20mm 99m2 (Raiden)",
	["DamageMax"] = 26,
	["DamageMin"] = 22,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.142,
	["Name"] = "30mm type 5",
	["NoGravity"] = true,
	["TravelEfx"] = 83,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[95] = 
{
	["Comment"] = "* 30mm (Shinden, Kikka)",
	["DamageMax"] = 30,
	["DamageMin"] = 25,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.048,
	["Name"] = ".50 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 83,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[98] = 
{
	["BigPayloadIcon"] = "common/icons/payload/ohka_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 2500,
		["BlastDamageMin"] = 2000,
		["BlastRange"] = 30,
	},
	["Comment"] = "Okha Impact",
	["ExplArmorEfx"] = 165,
	["ExplGroundEfx"] = 71,
	["ExplLightArmorEfx"] = 165,
	["ExplWaterEfx"] = 166,
	["ExplWaterHit"] = true,
	["Name"] = "kamikaze plane impact",
	["SmallPayloadIcon"] = "common/icons/payload/ohka_s.tga",
	["Type"] = "Kamikaze",
}

ArcadeTable[99] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 500,
		["BlastDamageMin"] = 350,
		["BlastRange"] = 20,
	},
	["Comment"] = "Normal Plane Impact",
	["ExplArmorEfx"] = 21,
	["ExplGroundEfx"] = 25,
	["ExplLightArmorEfx"] = 21,
	["ExplWaterEfx"] = 160,
	["ExplWaterHit"] = true,
	["Name"] = "normal plane impact",
	["Type"] = "Kamikaze",
}

ArcadeTable[100] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 130,
		["BlastDamageMin"] = 130,
		["BlastRange"] = 25,
	},
	["Comment"] = "Iowa 16'' Shell",
	["DamageMax"] = 480,
	["DamageMin"] = 270,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "16/?? battleship gun bullet - Iowa primary",
	["Range"] = 3300,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[101] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 120,
		["BlastDamageMin"] = 120,
		["BlastRange"] = 25,
	},
	["Comment"] = "South Dakota 16'' Shell",
	["DamageMax"] = 260,
	["DamageMin"] = 240,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "16/?? battleship gun bullet - Iowa primary",
	["Range"] = 3000,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["V0"] = 300,
}

ArcadeTable[142] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 2,
		["BlastDamageMin"] = 1,
		["BlastRange"] = 1,
	},
	["Comment"] = "Releaseable target",
	["DummyTargetVehicleClass"] = 790,
	["ExplArmorEfx"] = 158,
	["ExplGroundEfx"] = 159,
	["ExplLightArmorEfx"] = 158,
	["ExplWaterEfx"] = 160,
	["ExplWaterHit"] = true,
	["Mass"] = 50,
	["Mesh"] = "bullets/cel_ejtoernyo.MMOD",
	["Name"] = "globals.unitclass_dummytargetvehicle",
	["OpenAfterTime"] = 3,
	["OpenAtFallingSpeed"] = 40,
	["Type"] = "DummyTarget",
}

ArcadeTable[143] = 
{
	["BigPayloadIcon"] = "common/icons/payload/ohka_l.tga",
	["Blast"] = 
	{
		["BlastDamageMax"] = 3000,
		["BlastDamageMin"] = 3000,
		["BlastRange"] = 30,
	},
	["Comment"] = "Releaseable Ohka",
	["ExplArmorEfx"] = 165,
	["ExplGroundEfx"] = 71,
	["ExplLightArmorEfx"] = 165,
	["ExplWaterEfx"] = 160,
	["ExplWaterHit"] = true,
	["KamikazePlaneClass"] = 156,
	["Mass"] = 50,
	["Name"] = "globals.unitclass_kamikaze",
	["OpenAfterTime"] = 3,
	["SmallPayloadIcon"] = "common/icons/payload/ohka_s.tga",
	["Type"] = "DummyKamikazePlane",
}

ArcadeTable[144] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 500,
		["BlastDamageMin"] = 500,
		["BlastRange"] = 20,
	},
	["Comment"] = "Releaseable Kaiten",
	["ExplArmorEfx"] = 158,
	["ExplGroundEfx"] = 159,
	["ExplLightArmorEfx"] = 158,
	["ExplWaterEfx"] = 57,
	["ExplWaterHit"] = true,
	["Mass"] = 50,
	["Name"] = "globals.unitclass_kaiten",
	["OpenAfterTime"] = 1.2,
	["SubmarineClass"] = 4,
	["Type"] = "DummySubmarine",
}

ArcadeTable[154] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 1750,
		["BlastDamageMin"] = 1750,
		["BlastRange"] = 50,
	},
	["Comment"] = "Watermine Test",
	["DiveSpeed"] = 8,
	["ExplAirEfx"] = 54,
	["ExplArmorEfx"] = 45,
	["ExplGroundEfx"] = 48,
	["ExplLightArmorEfx"] = 45,
	["ExplWaterEfx"] = 46,
	["FloatingDepth"] = -3,
	["Mass"] = 700,
	["Mesh"] = "bullets/watermine.mmod",
	["Name"] = "Watermine Test ship US",
	["TriggerRadius"] = 20,
	["Type"] = "WaterMine",
	["V0"] = 10,
	["V0RandomFactor"] = 0.1,
	["WaterSplashEfx"] = 52,
}

ArcadeTable[160] = 
{
	["BigPayloadIcon"] = "common/icons/payload/paratrooper_l.tga",
	["CaptureDuration"] = 30,
	["CapturePower"] = 12,
	["CloseDuration"] = 2,
	["Comment"] = "US Paratrooper",
	["Damage"] = 42,
	["ExplArmorEfx"] = 158,
	["Mesh"] = "models/bullets/cel_ejtoernyo_marine.MMOD",
	["Name"] = "Paratrooper",
	["OpenDelay"] = 3,
	["OpenDuration"] = 1,
	["SlowFactorClosed"] = 0.2,
	["SlowFactorOpened"] = 2,
	["SmallPayloadIcon"] = "common/icons/payload/paratrooper_s.tga",
	["SoldierAnim"] = "fire2",
	["SoldierClass"] = "USMarine_shiptraffic",
	["Type"] = "Paratrooper",
}

ArcadeTable[102] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 55,
		["BlastDamageMin"] = 25,
		["BlastRange"] = 190,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 500,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 14,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[997] = 
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 115,
		["BlastDamageMin"] = 115,
		["BlastRange"] = 15,
	},
	["Comment"] = "DLC Siege Fortress Shell",
	["DamageMax"] = 300,
	["DamageMin"] = 290,
	["Decals"] = 
	{
		["Landscape"] = "landscape_hole",
		["Other"] = "explosion_hole",
	},
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["Mass"] = 25.030001,
	["Name"] = "14/45 battleship gun bullet - KGV primary",
	["Range"] = 4500,
	["TravelEfx"] = 19,
	["TravelEfx2"] = 387,
	["Type"] = "Artillery",
	["UE_DLC"] = "1",
	["V0"] = 300,
}

---- NEW BULLETS ----

ArcadeTable[107] = -- Royal Navy 7.7mm
{
	["Comment"] = ".50cal BMG twin AA",
	["DamageMax"] = 14,
	["DamageMin"] = 12,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1.2,
	["Mass"] = 0.123,
	["Name"] = ".5 cal twin AA mg",
	["NoGravity"] = true,
	["TravelEfx"] = 82,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[108] = -- Royal Navy 40mm
{
	["Comment"] = "40mm Bofors AA bullet",
	["DamageMax"] = 16,
	["DamageMin"] = 14,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2,
	["Mass"] = 0.123,
	["Name"] = "40mm Bofors AA",
	["NoGravity"] = true,
	["TravelEfx"] = 85,
	["Type"] = "Bullet",
	["V0"] = 800,
}

ArcadeTable[109] = -- IJN 203mm Sanshiki
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 155,
		["BlastDamageMin"] = 125,
		["BlastRange"] = 110,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 21,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[110] = -- IJN 310mm Sanshiki
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 250,
		["BlastDamageMin"] = 125,
		["BlastRange"] = 130,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 21,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[111] = -- 356mm Sanshiki
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 200,
		["BlastDamageMin"] = 175,
		["BlastRange"] = 150,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 500,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[112] = -- 410mm Sanshiki
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 300,
		["BlastDamageMin"] = 250,
		["BlastRange"] = 170,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 500,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[113] = -- 510mm Sanshiki
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 400,
		["BlastDamageMin"] = 250,
		["BlastRange"] = 250,
	},
	["Comment"] = "Yamato 1945 Type 3 Flak Bullet",
	["ExplAirEfx"] = 500,
	["ExplArmorEfx"] = 16,
	["ExplGroundEfx"] = 18,
	["ExplLightArmorEfx"] = 17,
	["ExplWaterEfx"] = 15,
	["ExplWaterHit"] = true,
	["FlyTime"] = 3.5,
	["Mass"] = 225.029999,
	["MinRange"] = 1000,
	["Name"] = "Yamato 1945 Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["Type"] = "Flak",
	["V0"] = 900,
}

ArcadeTable[114] = -- 152mm FLAK
{
	["Blast"] = 
	{
		["BlastDamageMax"] = 75,
		["BlastDamageMin"] = 55,
		["BlastRange"] = 50,
	},
	["Comment"] = "Akizuki Flak Bullet",
	["ExplAirEfx"] = 10,
	["ExplArmorEfx"] = 12,
	["ExplGroundEfx"] = 11,
	["ExplLightArmorEfx"] = 11,
	["ExplWaterEfx"] = 9,
	["ExplWaterHit"] = true,
	["FlyTime"] = 2.5,
	["Mass"] = 225.029999,
	["MinRange"] = 200,
	["Name"] = "Akizuki Flak bullet",
	["NoGravity"] = true,
	["Radar"] = true,
	["TravelEfx"] = 86,
	["TravelEfx2"] = 14,
	["Type"] = "Flak",
	["V0"] = 800,
}

ArcadeTable[115] = -- 37mm Cannon
{
	["Comment"] = "37mm Cannon",
	["DamageMax"] = 42,
	["DamageMin"] = 40,
	["ExplArmorEfx"] = 41,
	["ExplGroundEfx"] = 43,
	["ExplLightArmorEfx"] = 42,
	["ExplWaterEfx"] = 44,
	["ExplWaterHit"] = true,
	["FlyTime"] = 1,
	["Mass"] = 0.048,
	["Name"] = ".30 cal",
	["NoGravity"] = true,
	["TravelEfx"] = 80,
	["Type"] = "Bullet",
	["V0"] = 800,
}