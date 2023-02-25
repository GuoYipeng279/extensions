MARKERANIM_NONE = 0
MARKERANIM_ROTATE_X = 1
MARKERANIM_ROTATE_Y = 2
MARKERANIM_ROTATE_Z = 3
MARKERANIM_JUMP = 4

MarkerClasses={}

MarkerClasses["SzurkeNyil"] =
{
	["Mesh"] = "gui/atlacconyil.mmod",
	["Anim"] = MARKERANIM_JUMP,
	["Synchronized"] = true,
}

MarkerClasses["AtlaccoNyil"] =
{
	["Mesh"] = "gui/atlacconyil.mmod",
	["Anim"] = MARKERANIM_ROTATE_Y,
	["Synchronized"] = false,
}
