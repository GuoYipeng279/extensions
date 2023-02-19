-----------------------------------------------------------------------------
-- Generic recon tables
---------------------------------------------------------------
-- raw recon types
RRT_VISION = 0
RRT_RADAR = 1
RRT_SONAR = 2

ReconClass = {}


-- Normal Ship (Cargo ship, Torpedoboat)
NormalShip_recon_VisionRange= 4000

ReconClass[1] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalShip_recon_VisionRange , ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 0.3, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
		},
	},
}

-- Radar ship (Battleship, Carrier)
RadarShip_recon_RadarRange = 5000
ReconClass[2] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalShip_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
				[2] = {["Range"]=RadarShip_recon_RadarRange, ["Color"]=COL_RED, ["RawType"] = RRT_RADAR, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = RadarShip_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = RadarShip_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 0.3, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
		},
	},
}
-- Sonar ship (Destroyer)
SonarShip_recon_SonarRange = 1000
ReconClass[3] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=SonarShip_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
				[2] = {["Range"]=SonarShip_recon_SonarRange * 2.5, ["Color"]=COL_GREEN,["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
				[3] = {["Range"]=NormalShip_recon_VisionRange , ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = SonarShip_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = SonarShip_recon_SonarRange * 2.5, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = SonarShip_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = SonarShip_recon_SonarRange * 2.5, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = SonarShip_recon_SonarRange * 0.66, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = SonarShip_recon_SonarRange * 1.66, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},
		},
	},
}

-- Ship with radar and sonar (Cruiser - TONE)
RadarAndSonarShip_recon_RadarRange = 5000
RadarAndSonarShip_recon_SonarRange = 1000
ReconClass[4] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=RadarAndSonarShip_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
				[2] = {["Range"]=RadarAndSonarShip_recon_SonarRange * 2.5, ["Color"]=COL_GREEN,["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
				[3] = {["Range"]=NormalShip_recon_VisionRange , ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
				[4] = {["Range"]=RadarAndSonarShip_recon_RadarRange, ["Color"]=COL_RED, ["RawType"] = RRT_RADAR, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = RadarAndSonarShip_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectSurface"]=
			{

				[1] = {["Dist"] = NormalShip_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = RadarAndSonarShip_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = RadarAndSonarShip_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = RadarAndSonarShip_recon_SonarRange * 2.5, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = RadarAndSonarShip_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = RadarAndSonarShip_recon_SonarRange * 2.5, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = RadarAndSonarShip_recon_SonarRange * 0.66, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
				[2] = {["Dist"] = RadarAndSonarShip_recon_SonarRange * 1.66, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["Angle"]=DEG(45), ["RawType"] = RRT_SONAR, },
			},			
		},
	},
}
-- Normal plane
NormalPlane_recon_VisionRange= 4000
ReconClass[5] =
{
	["Details"] =
	{
		["ObserverAir"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalPlane_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalPlane_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalPlane_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
		},
	},
}

-- Recon plane
ReconPlane_recon_VisionRange= 5000
ReconPlane_recon_SonarRange= 750
ReconClass[6] =
{
	["Details"] =
	{
		["ObserverAir"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]= ReconPlane_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
				[2] = {["Range"]= ReconPlane_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = ReconPlane_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = ReconPlane_recon_VisionRange * 1.0, ["Gain"] = 1/1,["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = ReconPlane_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = ReconPlane_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = ReconPlane_recon_SonarRange * 0.66, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
		},
	},
}

-- Normal submarine

NormalSub_recon_VisionRange= 4000
NormalSub_recon_SonarRange = 1800

NormalSub_recon_Details_ObserverSurface =
{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalSub_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
				[2] = {["Range"]=NormalSub_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalSub_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalSub_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
}

NormalSub_recon_Details_ObserverPeriscopeOut =
{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalSub_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
				[2] = {["Range"]=NormalSub_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = NormalSub_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = NormalSub_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/5, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
}

NormalSub_recon_Details_ObserverPeriscopeIn =
{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalSub_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
			},
			["SubjectSurface"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
}

NormalSub_recon_Details_ObserverUnderwater =
{
			["GUIRange"] =
			{
				[1] = {["Range"]=NormalSub_recon_SonarRange, ["Color"]=COL_GREEN, ["RawType"] = RRT_SONAR, },
			},
			["SubjectSurface"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeOut"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectPeriscopeIn"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
			["SubjectUnderwater"] =
			{
				[1] = {["Dist"] = NormalSub_recon_SonarRange, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_SONAR, },
			},
}
-- Submarine recon, kicsit benan leirva, nezd a fenti tablat
ReconClass[7] =
{
	["Details"] =
	{
		["ObserverSurface"] = NormalSub_recon_Details_ObserverSurface,
		["ObserverPeriscopeOut"] = NormalSub_recon_Details_ObserverPeriscopeOut,
		["ObserverPeriscopeIn"] = NormalSub_recon_Details_ObserverPeriscopeIn,
		["ObserverUnderwater"] = NormalSub_recon_Details_ObserverUnderwater,
	},
}

-- Ground unit w/o radar
GroundUnit_recon_VisionRange = 4000
ReconClass[8] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=GroundUnit_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = GroundUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = GroundUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
		},
	},
}

-- Ground unit with high vision (Observation post)
GroundObserverUnit_recon_VisionRange = 6000
ReconClass[9] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=GroundObserverUnit_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = GroundObserverUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = GroundObserverUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
			},
		},
	},
}

-- Ground unit with radar (Radar station)
GroundRadarUnit_recon_RadarRange = 10000
GroundRadarUnit_recon_VisionRange = 4000
ReconClass[10] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=GroundRadarUnit_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
				[2] = {["Range"]=GroundRadarUnit_recon_RadarRange, ["Color"]=COL_RED, ["RawType"] = RRT_RADAR, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = GroundRadarUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = GroundRadarUnit_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = GroundRadarUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = GroundRadarUnit_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
		},
	},
}

-- Ground unit with small radar (Airfield)
SmallRadarUnit_recon_RadarRange = 5000
ReconClass[11] =
{
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=GroundRadarUnit_recon_VisionRange, ["Color"]=COL_BLUE, ["RawType"] = RRT_VISION, },
				[2] = {["Range"]=SmallRadarUnit_recon_RadarRange, ["Color"]=COL_RED, ["RawType"] = RRT_RADAR, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = GroundRadarUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = SmallRadarUnit_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = GroundRadarUnit_recon_VisionRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 2, ["RawType"] = RRT_VISION, },
				[2] = {["Dist"] = SmallRadarUnit_recon_RadarRange * 1.0, ["Gain"] = 1/1, ["MaxLevel"] = 1, ["RawType"] = RRT_RADAR, },
			},
		},
	},
}

-- Units with no recon
ReconClass[12] =
{	
	["Details"] =
	{
		["ObserverSurface"] =
		{
			["GUIRange"] =
			{
				[1] = {["Range"]=0, ["Color"]=COL_BLUE, ["RawType"] = 0, },
				[2] = {["Range"]=0, ["Color"]=COL_RED, ["RawType"] = 0, },
			},
			["SubjectAir"] =
			{
				[1] = {["Dist"] = 0, ["Gain"] = 0, ["MaxLevel"] = 0, ["RawType"] = 0, },
				[2] = {["Dist"] = 0, ["Gain"] = 0, ["MaxLevel"] = 0, ["RawType"] = 0, },
			},
			["SubjectSurface"]=
			{
				[1] = {["Dist"] = 0, ["Gain"] = 0, ["MaxLevel"] = 0, ["RawType"] = 0, },
				[2] = {["Dist"] = 0, ["Gain"] = 0, ["MaxLevel"] = 0, ["RawType"] = 0, },
			},
		},
	},
}