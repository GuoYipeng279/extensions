WreckClass={}

WreckClass["ProbaWreck"] =
{
	["Mesh"] = "models/vehicles/roncs_teszt.MMOD",
	["Fire"] =
	{
		["Chance"] = 0.25,
		["EmitterEfx"] = 148,
		["TimeMin"] = 5.0,
		["TimeMax"] = 10.0,
	},
	["Smoke"] =
	{
		["Chance"] = 0.25,
		["EmitterEfx"] = 147,
		["TimeMin"] = 10.0,
		["TimeMax"] = 20.0,
	},
	["Remain"] =
	{
		["TimeMin"] = 20.0,
		["TimeMax"] = 25.0,
	},
}

WreckClass["VehicleWreck"] =
{
	["Mesh"] = "models/vehicles/roncs_teszt.MMOD",
	["Fire"] =
	{
		["Chance"] = 0.9,
		["EmitterEfx"] = 136,
		["TimeMin"] = 5.0,
		["TimeMax"] = 10.0,
	},
	["Smoke"] =
	{
		["Chance"] = 0.3,
		["EmitterEfx"] = 135,
		["TimeMin"] = 10.0,
		["TimeMax"] = 20.0,
	},
	["Remain"] =
	{
		["TimeMin"] = 20.0,
		["TimeMax"] = 25.0,
	},
}

WreckClass["SmallPlaneWreck"] =
{
--	["Mesh"] = "models/vehicles/roncs_teszt.MMOD",
	["Mesh"] = Platform(
		"models/vehicles/planes/stat_wildcat_roncs.MMOD",
		"models/vehicles/planes/stat_wildcat_roncs.MMOD"),
	["Fire"] =
	{
		["Chance"] = 0.4,
		["EmitterEfx"] = 148,
		["TimeMin"] = 5.0,
		["TimeMax"] = 10.0,
	},
	["Smoke"] =
	{
		["Chance"] = 0.4,
		["EmitterEfx"] = 147,
		["TimeMin"] = 10.0,
		["TimeMax"] = 30.0,
	},
	["Remain"] =
	{
		["TimeMin"] = 30.0,
		["TimeMax"] = 35.0,
	},
}

WreckClass["WildcatWreck"] =
{
	["Mesh"] = Platform(
		"models/vehicles/planes/stat_wildcat_roncs.MMOD",
		"models/vehicles/planes/stat_wildcat_roncs.MMOD"),
--	["Mesh"] = "models/vehicles/roncs_teszt.MMOD",
	["Fire"] =
	{
		["Chance"] = 0.4,
		["EmitterEfx"] = 148,
		["TimeMin"] = 10.0,
		["TimeMax"] = 30.0,
	},
	["Smoke"] =
	{
		["Chance"] = 0.4,
		["EmitterEfx"] = 147,
		["TimeMin"] = 20.0,
		["TimeMax"] = 60.0,
	},
	["Remain"] =
	{
		["TimeMin"] = 40.0,
		["TimeMax"] = 120.0,
	},
}
