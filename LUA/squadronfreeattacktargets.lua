

-- ez a tablazat azt irja le, hogy milyen fegyverzettel, milyen celpontokat valaszthat maganak, es milyen prioritasi sorrendben
AttackLists = {}

AttackLists["DepthCharge"]=    
{
	["1"]   = "SUBMARINE" ,
}

AttackLists["DiveBomb"]=    
{
	["1"]   = "BATTLESHIP",
	["2"]   = "MOTHERSHIP",
	["3"]   = "CRUISER",
	["4"]   = "SUBMARINE",
	["5"]   = "DESTROYER",
	["6"]   = "CARGO",
	["7"]   = "LANDINGSHIP",
	["8"]   = "AIRFIELD",
	["9"]   = "SHIPYARD",
}

AttackLists["LevelBomb"]=    
{
	["1"]   = "BATTLESHIP",
	["2"]   = "MOTHERSHIP",
	["3"]   = "CRUISER",
	["4"]   = "SUBMARINE",
	["5"]   = "DESTROYER",
	["6"]   = "CARGO",
	["7"]   = "LANDINGSHIP",
	["8"]   = "AIRFIELD",
	["9"]   = "SHIPYARD",
}

AttackLists["TorpedoBomb"]=    
{
	["1"]   = "BATTLESHIP",
	["2"]   = "MOTHERSHIP",
	["3"]   = "CRUISER",
	["4"]   = "DESTROYER",
	["5"]   = "SUBMARINE",
	["6"]   = "CARGO",
	["7"]   = "LANDINGSHIP",
}

AttackLists["Strike"]=    
{
	["1"]   = "BATTLESHIP",
	["2"]   = "MOTHERSHIP",
	["3"]   = "CRUISER",
	["4"]   = "SUBMARINE",
	["5"]   = "DESTROYER",
	["6"]   = "CARGO",
	["7"]   = "LANDINGSHIP",
	["8"]   = "AIRFIELD",
	["9"]   = "SHIPYARD",
}

AttackLists["NonFighterGun"]=    -- szabadon forgathato geppuska a repulon
{
	["1"]   = "FIGHTER",
	["2"]   = "KAMIKAZEPLANE",
	["3"]   = "DIVEBOMBER",
	["4"]   = "TORPEDOBOMBER",
	["5"]   = "TORPEDOBOAT",
	["6"]   = "RECONPLANE",
	["7"]   = "LEVELBOMBER",
	["8"]   = "PLANE",
	["9"]   = "LANDINGSHIP",
	["10"]   = "DUMMYTARGET_VEHICLE",
	["11"]  = "CARGO",
	["12"]  = "LANDFORT",
	["13"]  = "SHIP",
}

AttackLists["FighterGun"]=    -- fix, elore mutato geppuska a repulon
{
	["1"]   = "FIGHTER",
	["2"]   = "KAMIKAZEPLANE",
	["3"]   = "LEVELBOMBER",
	["4"]   = "DIVEBOMBER",
	["5"]   = "TORPEDOBOMBER",
	["6"]   = "RECONPLANE",
	["7"]   = "TORPEDOBOAT",
	["8"]   = "LANDINGSHIP",
	["9"]   = "CARGO",
	["10"]  = "DUMMYTARGET_VEHICLE",
}

AttackLists["Kamikaze"]=    -- kamikaze raketta
{
	["1"]   = "BATTLESHIP",
	["2"]   = "MOTHERSHIP",
	["3"]   = "CRUISER",
	["4"]   = "DESTROYER",
	["5"]   = "SUBMARINE",
	["6"]   = "CARGO",
	["7"]   = "AIRFIELD",
	["8"]   = "SHIPYARD",
}